# Processing State Model

## Processing Status

### received

Lead intake was persisted successfully.

### validated

Payload passed structural validation.

### processing

Revenue-system processing is active.

### review_required

Processing stopped safely because human review is required.

### failed

A technical failure prevented completion.

### retry_pending

A failed attempt is eligible for controlled retry.

### completed

The processing attempt reached a valid terminal state.

## Separation of Concerns

Three state families must remain independent:

### Commercial State

Examples:

- nurture
- qualified
- disqualified

### SLA State

Examples:

- active
- met
- breached
- escalated

### Technical Processing State

Examples:

- processing
- failed
- completed

An SLA breach does not mean the lead is commercially disqualified.

A technical failure does not change ICP Fit.

A Lead may be commercially qualified while a processing attempt is temporarily failed.
