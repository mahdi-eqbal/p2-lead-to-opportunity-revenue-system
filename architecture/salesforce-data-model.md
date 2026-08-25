# Salesforce Data Model

## Lead

The Salesforce Lead object represents a pre-conversion commercial prospect.

### Standard Fields Used

- FirstName
- LastName
- Email
- Company
- Country
- LeadSource
- Status
- OwnerId

### Custom Fields Planned

#### External Lead ID

Type: Text / Unique

Purpose:
Stable identity for intake idempotency and external-system matching.

#### Data Readiness

Type: Picklist

Values:

- Ready
- Incomplete
- Ambiguous
- Blocked

#### ICP Fit

Type: Picklist

Values:

- Strong Fit
- Moderate Fit
- Weak Fit
- Disqualified

#### Buying Intent

Type: Picklist

Values:

- Low Intent
- Medium Intent
- High Intent

#### Qualification State

Type: Picklist

Values:

- Data Review
- Nurture
- Qualified
- Disqualified
- Needs Review

#### Qualification Reason

Type: Long Text Area

#### Routing Target

Type: Picklist

Values:

- NA SMB
- NA Mid-Market
- EMEA SMB
- EMEA Mid-Market
- Enterprise Review
- Partner Motion
- Manual Review

#### SLA Status

Type: Picklist

Values:

- Not Started
- Active
- Met
- Breached
- Escalated

#### SLA Started At

Type: Date/Time

#### SLA Due At

Type: Date/Time

#### First Sales Engagement At

Type: Date/Time

#### Escalated At

Type: Date/Time


## Account

Account represents the resolved commercial company after identity resolution / conversion.

Key responsibilities:

- company-level commercial identity
- existing-customer / prospect context
- duplicate prevention
- Opportunity association


## Contact

Contact represents the resolved individual after Lead conversion.

Key responsibilities:

- person identity
- email-based matching
- Account association
- sales activity context


## Opportunity

Opportunity represents an active commercial buying process.

Key responsibilities:

- pipeline state
- stage
- amount when applicable
- Account association
- Contact role context
- duplicate Opportunity protection

## Data Model Principle

Lead qualification must not create an Opportunity automatically unless Opportunity-entry criteria are satisfied.

Lead qualification and Opportunity creation are separate lifecycle decisions.
