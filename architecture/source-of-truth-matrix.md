# Source of Truth Matrix

| Data / State | Salesforce | PostgreSQL | n8n |
|---|---|---|---|
| Raw lead intake payload | No | Primary | Transient |
| Intake idempotency | No | Primary | Decision layer |
| CRM Lead record | Primary | Reference ID | Orchestration |
| Lead business status | Primary | Audit copy | Decision layer |
| Qualification result | Primary | Audit copy | Calculates |
| Routing target | Primary | Audit copy | Calculates |
| Lead Owner | Primary | Optional audit | Applies |
| SLA business status | Primary | Operational copy | Evaluates |
| SLA timestamps | CRM visibility | Primary operational history | Calculates |
| Processing attempt | No | Primary | Executes |
| Failure / retry state | No | Primary | Executes |
| Account identity | Primary | Resolution cache | Resolves |
| Contact identity | Primary | Resolution cache | Resolves |
| Opportunity | Primary | Reference / audit | Guards / creates |
| Workflow execution memory | No | No | Temporary |

## Principle

Salesforce owns revenue-facing CRM state.

PostgreSQL owns durable operational processing state.

n8n coordinates state transitions but does not independently own durable business truth.
