# Lead Qualification Model

## Qualification Dimensions

RelayIQ evaluates leads using three independent dimensions:

1. Data Readiness
2. ICP Fit
3. Buying Intent

## Data Readiness

### ready

Required fields are available and usable:

- email
- company
- country
- lead source

### incomplete

One or more required fields are missing.

### ambiguous

Identity or company information conflicts or cannot be resolved confidently.

## ICP Fit

### strong_fit

Typical conditions:

- supported geography
- target B2B / technology-oriented company
- 50–999 employees

### moderate_fit

Typical conditions:

- supported geography
- 20–49 employees
- 1000+ employees requiring different sales handling
- partial but commercially plausible fit

### weak_fit

The company is potentially relevant but does not match the primary ICP.

### disqualified

Explicit commercial exclusion exists.

Examples:

- unsupported market
- invalid business context
- clearly non-commercial / consumer record

## Buying Intent

### low_intent

Low-commitment acquisition or prospecting signal.

Examples:

- outbound prospect
- generic content interaction

### medium_intent

Meaningful interest but not necessarily an immediate buying request.

Examples:

- partner referral
- repeated meaningful engagement

### high_intent

Strong explicit buying signal.

Examples:

- demo request
- contact-sales request

## Qualification Decision Matrix

### qualified

Data Readiness = ready

AND

ICP Fit = strong_fit or moderate_fit

AND

Buying Intent = high_intent

### nurture

Data is usable and the lead is commercially plausible, but intent is below the sales threshold.

### data_review

Data Readiness = incomplete or ambiguous.

### disqualified

ICP Fit = disqualified.

### needs_review

Conflicting qualification signals or governance exceptions require human review.

## Design Principle

Qualification is deterministic and explainable.

The system must persist both:

- qualification_state
- qualification_reason
