# Architecture Decision Register

## ADR-001 — Salesforce Is the Primary CRM

Decision:

Salesforce owns revenue-facing Lead, Account, Contact, Opportunity, ownership, and sales lifecycle state.

Reason:

P2 must demonstrate Salesforce-centered Revenue Systems engineering rather than replicate the HubSpot architecture from P1.

---

## ADR-002 — PostgreSQL Owns Operational Processing State

Decision:

Raw intake, processing attempts, idempotency, failure history, and operational SLA timestamps are persisted in PostgreSQL.

Reason:

CRM objects should not be used as a technical event ledger.

---

## ADR-003 — Persist Before CRM Mutation

Decision:

Incoming lead data must be durably persisted before Salesforce mutations occur.

Reason:

This preserves recoverability when Salesforce or downstream processing fails.

---

## ADR-004 — Qualification and Routing Are Separate

Decision:

A Lead becomes commercially qualified before routing is calculated.

Reason:

Qualification answers whether Sales should engage.

Routing answers where the qualified Lead should go.

---

## ADR-005 — Qualification and SLA Are Separate

Decision:

SLA status must not overwrite commercial qualification state.

Reason:

Sales response performance and commercial fit measure different operational dimensions.

---

## ADR-006 — Lead Conversion Requires Identity Guards

Decision:

Account and Contact identity must be checked before Lead conversion creates new commercial records.

Reason:

Blind conversion can create duplicate Accounts and Contacts.

---

## ADR-007 — Opportunity Creation Requires a Duplicate Guard

Decision:

Existing open Opportunities must be checked before creating another Opportunity.

Reason:

A qualified Lead does not justify duplicate pipeline creation.

---

## ADR-008 — Deterministic Core Qualification

Decision:

Core qualification, routing, and SLA logic will be deterministic.

Reason:

P2 focuses on auditable Revenue Operations controls rather than probabilistic AI decision-making.
