# P2 System Architecture

## System Objective

RelayIQ requires a controlled Revenue Operations system that converts incoming leads into qualified, routed, SLA-managed Salesforce records and eventually into Account, Contact, and Opportunity lifecycle states.

## Core Systems

### Salesforce

Primary CRM and revenue-facing system of record.

Salesforce owns:

- Lead business state
- CRM identity
- Lead qualification result
- Lead owner / routing result
- Account
- Contact
- Opportunity
- Sales-facing SLA status
- Sales activity context

### PostgreSQL / Supabase

Operational and audit system of record.

PostgreSQL owns:

- raw lead intake events
- normalized intake payloads
- processing attempts
- idempotency state
- identity resolution state
- SLA operational timestamps
- failure and retry state
- processing audit history

### n8n

Orchestration layer.

n8n coordinates:

- intake
- validation
- normalization
- Salesforce API operations
- PostgreSQL persistence
- deterministic business logic
- routing
- SLA actions
- lifecycle progression
- failure handling

n8n is not a source of truth.

### JavaScript

Deterministic decision logic for:

- validation
- normalization
- qualification
- segmentation
- routing
- SLA evaluation
- duplicate protection decisions

## High-Level Flow

Lead Intake
→ Authenticate / Validate
→ Persist Intake
→ Normalize
→ Resolve CRM Identity
→ Evaluate Data Readiness
→ Calculate ICP Fit
→ Determine Buying Intent
→ Qualification Decision
→ Salesforce Lead Update
→ Routing
→ SLA Start
→ Sales Engagement Monitoring
→ Account / Contact Resolution
→ Opportunity Guard
→ Lead-to-Opportunity Progression
→ Operational Completion

## Reliability Principle

Durable intake must exist before downstream Salesforce mutations.

The system must be capable of reconstructing processing state without relying on transient n8n execution memory.
