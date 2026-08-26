-- P2 Migration 002
-- Separate intake-event identity from business lead identity

ALTER TABLE public.lead_intake_events
DROP CONSTRAINT IF EXISTS lead_intake_events_external_lead_id_key;

CREATE INDEX IF NOT EXISTS idx_lead_intake_external_lead_id
ON public.lead_intake_events (external_lead_id);
