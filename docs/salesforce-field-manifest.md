# Salesforce Lead Field Manifest

## External Lead ID
Object: Lead
Field Type: Text
Length: 100
Unique: Yes
External ID: Yes
Purpose: Stable intake identity and idempotency key.

## Data Readiness
Object: Lead
Field Type: Picklist
Values:
- Ready
- Incomplete
- Ambiguous
- Blocked

## ICP Fit
Object: Lead
Field Type: Picklist
Values:
- Strong Fit
- Moderate Fit
- Weak Fit
- Disqualified

## Buying Intent
Object: Lead
Field Type: Picklist
Values:
- Low Intent
- Medium Intent
- High Intent

## Qualification State
Object: Lead
Field Type: Picklist
Values:
- Data Review
- Nurture
- Qualified
- Disqualified
- Needs Review

## Qualification Reason
Object: Lead
Field Type: Long Text Area
Length: 2000

## Routing Target
Object: Lead
Field Type: Picklist
Values:
- NA SMB
- NA Mid-Market
- EMEA SMB
- EMEA Mid-Market
- Enterprise Review
- Partner Motion
- Manual Review

## SLA Status
Object: Lead
Field Type: Picklist
Values:
- Not Started
- Active
- Met
- Breached
- Escalated

## SLA Started At
Object: Lead
Field Type: Date/Time

## SLA Due At
Object: Lead
Field Type: Date/Time

## First Sales Engagement At
Object: Lead
Field Type: Date/Time

## Escalated At
Object: Lead
Field Type: Date/Time
