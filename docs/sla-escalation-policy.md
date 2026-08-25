# Sales SLA and Escalation Policy

## Purpose

Ensure that qualified routed leads receive timely sales follow-up.

## SLA Starts When

The SLA starts only after:

- qualification_state = qualified
- routing has completed successfully
- a Sales Owner / Sales Motion has been established

## SLA Tiers

### High-Intent Demo Request

Target response:

2 business hours

### Partner Referral

Target response:

4 business hours

### Other Qualified Lead

Target response:

1 business day

## SLA States

### not_started

Lead is not yet eligible for SLA measurement.

### active

Lead has been routed and the SLA clock is running.

### met

A valid sales engagement occurred before the deadline.

### breached

The deadline passed without valid sales engagement.

### escalated

A breached SLA triggered an operational escalation.

## Valid Sales Engagement

Examples:

- logged sales call
- logged outbound email
- completed follow-up task
- other explicitly accepted sales activity

Assignment alone does not count as engagement.

## Escalation Policy

When SLA is breached:

1. mark SLA as breached
2. persist the breach timestamp
3. create an escalation task
4. increase operational priority
5. surface the lead for manager / operations review

## Guardrails

- Escalation must not change ICP Fit.
- Escalation must not automatically disqualify a lead.
- Reassignment must be auditable.
- SLA timestamps must be persisted independently from qualification state.
