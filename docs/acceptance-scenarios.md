# P2 Acceptance Scenarios

## Core Scenarios

### 1. High-Intent Strong-Fit Demo Lead

Expected:

- validation passes
- qualified
- deterministic routing
- SLA starts
- sales follow-up task created

### 2. Strong-Fit Low-Intent Lead

Expected:

- nurture
- no immediate sales handoff

### 3. Missing Required Data

Expected:

- data_review
- no automatic sales routing

### 4. Explicitly Disqualified Lead

Expected:

- disqualified
- no SLA
- no sales task

### 5. Enterprise Lead

Expected:

- enterprise_review
- no standard SMB / Mid-Market routing

### 6. Partner Referral

Expected:

- partner-specific routing policy
- partner SLA applied

### 7. SLA Met

Expected:

- engagement detected before deadline
- SLA state becomes met

### 8. SLA Breach

Expected:

- SLA becomes breached
- escalation action created
- breach recorded in operational state

### 9. Existing Account

Expected:

- existing Account resolved
- duplicate Account not created

### 10. Existing Contact

Expected:

- existing Contact resolved
- duplicate Contact not created

### 11. Existing Open Opportunity

Expected:

- duplicate Opportunity suppressed
- controlled review or existing-opportunity path used

### 12. Safe Retry

Expected:

- processing retry does not create duplicate Lead, Account, Contact, Opportunity, or Sales Task

### 13. Salesforce API Failure

Expected:

- failure persisted
- processing remains recoverable
- retry can occur from durable state

### 14. Ambiguous Identity

Expected:

- human review
- no blind CRM mutation

## Acceptance Principle

The project is complete only when both happy paths and operational failure paths are demonstrated with evidence.
