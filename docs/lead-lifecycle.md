# Lead Lifecycle

## Purpose

Define the controlled lifecycle of an inbound or outbound lead from intake through sales progression.

## Lifecycle States

### received

The lead has entered the revenue system but has not yet passed validation.

### data_review

Critical lead data is incomplete, inconsistent, or requires controlled review.

### ready_for_qualification

Required identity and company data is sufficient for qualification.

### nurture

The lead is commercially relevant but does not currently meet the threshold for direct sales engagement.

### qualified

The lead meets the qualification threshold and is eligible for routing.

### disqualified

The lead fails explicit commercial qualification rules.

### routed

A qualified lead has been assigned to the correct sales motion.

### sales_followup_pending

The lead has been routed and the response SLA has started.

### sales_engaged

A valid sales activity has occurred within or after the SLA window.

### sla_breached

The required sales response did not occur before the SLA deadline.

### opportunity_candidate

The lead has sufficient qualification and sales engagement to enter Opportunity evaluation.

### converted

The Lead has been successfully progressed into the Account / Contact / Opportunity lifecycle.

## State Principles

- Missing information is not automatically treated as a negative qualification signal.
- Disqualification must be caused by an explicit business rule.
- Qualification and routing are separate decisions.
- Sales engagement and qualification are separate states.
- SLA state is operational and must not overwrite commercial qualification.
- Conversion must be idempotent and must not create duplicate commercial records.
