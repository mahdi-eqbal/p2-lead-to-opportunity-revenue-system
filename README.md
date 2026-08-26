# P2 — End-to-End Lead-to-Opportunity Revenue Operations System

A Salesforce-centered Revenue Systems implementation that manages the lead lifecycle from inbound intake through validation, qualification, routing, SLA enforcement, CRM identity resolution, sales handoff, and operational failure handling.

The system was independently designed and built as a realistic B2B revenue operations implementation, with emphasis on data integrity, idempotency, lifecycle control, observability, and failure-safe CRM integration.

---

## Business Problem

Revenue teams frequently receive leads from multiple acquisition sources with inconsistent data quality, duplicate submissions, incomplete records, and varying levels of buying intent.

Sending every inbound lead directly into the CRM creates several operational problems:

- duplicate CRM records
- incomplete or unusable sales records
- inconsistent qualification
- unclear routing ownership
- missed follow-up SLAs
- poor visibility into rejected or disqualified leads
- integration failures that leave processing state unknown

This system introduces an operational control layer between lead intake and Salesforce.

Its purpose is to ensure that only validated, qualified, correctly routed leads reach the sales workflow while preserving an auditable processing history for every intake event.

---

## System Architecture

The implementation uses:

- **n8n** — orchestration and business logic
- **PostgreSQL / Supabase** — operational persistence, processing state, idempotency, and auditability
- **Salesforce** — CRM destination and sales execution layer
- **Salesforce REST API** — CRM identity resolution and Lead operations
- **Salesforce Flow** — downstream sales follow-up Task creation
- **JavaScript** — normalization, readiness evaluation, qualification, routing, and SLA logic
- **Webhooks / HTTP** — inbound event ingestion and Salesforce API communication

High-level flow:

**Inbound Lead Event**

→ Validate & Normalize
→ Persist Intake
→ Duplicate Detection
→ Create Processing Attempt
→ Load Trusted Lead Context
→ Evaluate Data Readiness
→ Qualification & Buying Intent Evaluation
→ Qualification Decision
→ Routing
→ SLA Calculation
→ Persist Qualification State
→ Salesforce Authentication
→ Salesforce Lead Lookup
→ Existing Lead Reuse or New Lead Creation
→ Salesforce Lead Update
→ Sales Follow-Up Task
→ Processing Completion

Failure and exception paths are handled separately rather than being allowed to silently fall through the happy path.

---

## Core Workflow

### 1. Lead Intake

Inbound lead events enter through an n8n Webhook.

The payload contains operational identifiers and lead attributes such as:

- `intake_id`
- `external_lead_id`
- source
- first name
- last name
- email
- company
- country
- employee count

The intake event is normalized before downstream processing.

---

### 2. Validation

The workflow validates whether the incoming payload contains the minimum structure required for processing.

Invalid records are routed to a dedicated rejection path:

**Lead Valid? → False → Log Rejected Lead**

Rejected events do not enter qualification or Salesforce processing.

---

### 3. Intake Persistence and Idempotency

Valid intake events are persisted in PostgreSQL.

Idempotency is enforced using:

`intake_id`

This separates **event identity** from **lead identity**.

As a result:

- the same `intake_id` cannot be processed twice
- the same lead may legitimately generate multiple intake events
- repeated lead activity does not automatically create duplicate Salesforce Leads

A duplicate event is detected before expensive downstream processing occurs.

---

### 4. Processing Attempt

Each accepted intake creates a processing-attempt record.

This provides an operational record of the lead's processing lifecycle and stores information including:

- qualification state
- routing target
- SLA status
- Salesforce Lead ID
- processing status
- failure metadata
- completion timestamp

This separates transient workflow execution from persistent operational state.

---

### 5. Trusted Lead Context

The workflow loads persisted lead context before qualification.

Downstream decisions therefore operate against trusted operational data rather than relying only on the transient inbound webhook payload.

---

### 6. Data Readiness

A dedicated JavaScript evaluation checks whether required business data is available.

The readiness logic evaluates fields including:

- email
- company
- country
- source

Records are classified as:

**Ready**

or

**Incomplete**

Incomplete records are routed to:

**Mark Data Review**

and do not proceed into automated qualification and Salesforce handoff.

---

### 7. ICP Fit and Buying Intent

Ready leads are evaluated against qualification criteria.

The workflow derives business states such as:

- ICP Fit
- Buying Intent
- Qualification State
- Qualification Reason

Example validated state:

- ICP Fit: Strong Fit
- Buying Intent: High Intent
- Qualification State: Qualified

This separates raw lead attributes from explicit revenue decision states.

---

### 8. Qualification Gate

The qualification decision creates two operational paths.

#### Qualified

Qualified leads continue into:

Routing → SLA → Salesforce handoff

#### Not Qualified

Non-qualified leads are persisted through:

**Store Non-Qualified Outcome**

The system records the qualification result and reason without creating unnecessary Salesforce activity.

---

## Routing

Qualified leads are assigned a routing target based on business rules.

Example validated routing result:

`EMEA Mid-Market`

Routing is determined before CRM handoff so Salesforce receives an already-resolved operational state rather than becoming the sole location of routing logic.

---

## SLA Management

The workflow calculates sales follow-up timing for qualified leads.

Operational SLA fields include:

- SLA Started At
- SLA Due At
- SLA Status
- First Sales Engagement At
- Escalated At

A validated example produced:

`SLA Status = Active`

The calculated SLA state is persisted before Salesforce handoff.

---

## Salesforce Integration

### Authentication

n8n obtains a Salesforce access token and uses the returned instance URL for subsequent REST API operations.

Credentials and tokens are not stored in the repository.

---

### Salesforce Identity Resolution

Before creating a Lead, the workflow searches Salesforce using the external lead identity.

This creates two paths:

**Existing Salesforce Lead**

or

**New Salesforce Lead**

This prevents the integration from blindly creating a new CRM record for every intake event.

---

### Existing Lead Path

When Salesforce already contains the Lead:

**Lookup Lead in Salesforce API**

→ **Existing Salesforce Lead?**

→ **Link Existing Salesforce Lead**

→ **Update Resolved Salesforce Lead**

The existing Salesforce record is reused and linked to the current processing attempt.

---

### New Lead Path

When no Salesforce Lead exists:

**Create Salesforce Lead**

→ **Persist Salesforce Lead Link**

→ **Update Resolved Salesforce Lead**

The Salesforce Lead ID is persisted back into the operational database so the CRM record and processing attempt remain linked.

---

## Salesforce Sales Handoff

After a qualified Lead reaches Salesforce, a Salesforce Record-Triggered Flow creates the sales follow-up Task.

Validated Task:

`Follow up with qualified lead`

The Task is assigned to the Lead owner and receives an SLA-derived due date.

This separates responsibilities between systems:

- n8n controls orchestration and integration
- PostgreSQL preserves operational state
- Salesforce controls CRM execution and salesperson activity

---

## Reliability and Failure Handling

The implementation includes explicit controls for failure and duplicate scenarios.

### Duplicate Intake Protection

Repeated `intake_id` values are detected and prevented from re-entering downstream processing.

### CRM Duplicate Prevention

Lead identity is resolved in Salesforce before record creation.

A new intake event for an existing lead reuses the existing Salesforce Lead.

### Data Quality Isolation

Incomplete records are routed to Data Review rather than being silently pushed into Salesforce.

### Qualification Isolation

Non-qualified leads terminate through a controlled persistence path.

### Salesforce API Retry

Salesforce lookup requests are configured with retry behavior.

### Salesforce Failure Branch

The Salesforce lookup node uses a dedicated error output.

A lookup failure follows:

**Lookup Lead in Salesforce API**

→ **Error**

→ **Record Salesforce Lookup Failure**

The processing attempt is persisted with:

- failed processing status
- failure type
- failure reason
- completion timestamp

This prevents integration failures from being mistaken for successful or unprocessed records.

---

## Validated Test Scenarios

The implementation was tested across positive, negative, duplicate, and integration-failure scenarios.

| Scenario | Validated Behavior |
|---|---|
| Qualified new lead | Full processing and Salesforce handoff |
| Invalid lead | Rejected and logged |
| Incomplete lead | Routed to Data Review |
| Non-qualified lead | Outcome persisted without Salesforce handoff |
| Duplicate intake | Reprocessing prevented |
| Existing Salesforce Lead | Existing CRM record reused |
| New Salesforce Lead | New record created and linked |
| Salesforce API failure | Failure isolated and persisted |
| Sales follow-up | Salesforce Task created |
| SLA enforcement | Follow-up Task receives calculated due date |

See `TEST-MATRIX.md` for the formal test matrix.

---

## Evidence

Implementation evidence is stored under:

`evidence/n8n/`

Key evidence includes:

- complete workflow architecture
- successful qualified happy path
- Salesforce qualification and SLA state
- SLA-based sales Task creation
- non-qualified outcome persistence
- Data Review routing
- rejected lead handling
- duplicate intake protection
- existing Salesforce Lead reuse
- Salesforce API failure handling

The evidence reflects executed system behavior rather than conceptual mockups.

---

## Repository Structure

```text
p2-lead-to-opportunity-revenue-system/
├── adrs/
├── architecture/
├── docs/
├── evidence/
│   └── n8n/
├── sample-events/
├── scripts/
├── sql/
├── tests/
├── workflows/
├── .gitignore
├── README.md
└── TEST-MATRIX.md
```

---

## Design Decisions

Several architectural decisions were deliberate.

### Event Identity and Lead Identity Are Separate

`intake_id` represents an individual inbound event.

`external_lead_id` represents the business lead.

Conflating these identifiers would incorrectly classify legitimate repeat activity as duplicate intake.

---

### PostgreSQL Is an Operational Control Layer

Salesforce is not used as the only source of processing state.

The database preserves intake, qualification, routing, failure, and completion information independently from CRM availability.

---

### Qualification Happens Before CRM Handoff

The system prevents invalid, incomplete, and non-qualified records from unnecessarily entering the sales workflow.

---

### CRM Creation Is Preceded by Identity Resolution

Salesforce is queried before creating a Lead.

This reduces duplicate CRM creation and supports repeated events for an existing lead.

---

### Failures Become Explicit Business States

A Salesforce integration failure is not treated as an invisible workflow crash.

The failure is persisted and becomes inspectable operational data.

---

## Security

Sensitive integration information is intentionally excluded from the repository.

The repository should not contain:

- Salesforce access tokens
- Salesforce credentials
- database passwords
- webhook authentication secrets
- API secrets
- production credentials

Screenshots intended for public use should also be reviewed for credential exposure before publication.

---

## What This Project Demonstrates

This implementation demonstrates practical capability across:

- Revenue Systems architecture
- RevOps workflow design
- Salesforce integration
- REST APIs and authentication
- n8n orchestration
- PostgreSQL operational modeling
- JavaScript business logic
- lead qualification
- lead routing
- SLA management
- CRM identity resolution
- idempotent event processing
- data-quality controls
- retry and failure handling
- operational persistence
- testing and evidence-based validation

The project is designed as a professional implementation case study and does not represent a claimed client deployment or production revenue result.
