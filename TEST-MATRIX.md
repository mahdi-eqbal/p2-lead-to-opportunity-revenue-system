# P2 Test Matrix

## System
End-to-End Lead-to-Opportunity Revenue System

## Test Coverage

| Test | Expected Behavior | Result |
|---|---|---|
| Qualified new lead | Lead is validated, qualified, routed, written to Salesforce, assigned SLA, follow-up Task created, processing completed | PASS |
| Disqualified lead | Lead is evaluated as outside ICP, outcome persisted, no Salesforce handoff | PASS |
| Incomplete but valid lead | Lead passes validation but fails data readiness and is routed to Data Review | PASS |
| Invalid lead | Lead fails validation and is logged as rejected before processing | PASS |
| Duplicate intake event | Same intake_id is detected as duplicate and is not processed again | PASS |
| Existing Salesforce lead | New event for an existing external_lead_id resolves the existing Salesforce Lead instead of creating a duplicate | PASS |
| Salesforce lookup failure | Salesforce API lookup failure is retried and routed to persistent failure logging | PASS |
| SLA task creation | Qualified Salesforce Lead triggers a follow-up Task with an SLA-derived due date | PASS |

## Reliability Controls

- Intake-level idempotency based on `intake_id`
- Salesforce identity resolution based on `external_lead_id`
- Controlled rejection of invalid records
- Data-readiness review path
- Explicit non-qualified outcome persistence
- Salesforce API retry behavior
- Dedicated Salesforce lookup error branch
- Persistent processing status and failure metadata
- Salesforce Lead ID persisted back to PostgreSQL

## Final Validation

The qualified happy path was validated end to end:

Inbound event → validation → persistence → qualification → routing → SLA calculation → Salesforce identity resolution/create → Salesforce Lead update → Salesforce Flow task creation → processing completion.

Negative and failure paths were also validated independently.
