# Lead Routing Policy

## Purpose

Route qualified leads into the appropriate sales motion using deterministic business rules.

## Routing Dimensions

Routing considers:

- geography
- employee count
- lead source
- enterprise exception rules

## Geography Groups

### North America

- United States
- Canada

### EMEA

- Germany
- United Kingdom
- France
- Netherlands
- Spain
- Italy

## Company Segments

### SMB

20–99 employees

### Mid-Market

100–999 employees

### Enterprise

1000+ employees

## Routing Targets

### na_smb

North America + SMB

### na_mid_market

North America + Mid-Market

### emea_smb

EMEA + SMB

### emea_mid_market

EMEA + Mid-Market

### enterprise_review

1000+ employees regardless of normal geographic routing

### partner_motion

Qualified Partner Referral requiring partner-aware handling

### manual_review

No deterministic routing rule can be applied safely.

## Precedence Rules

1. Enterprise exception
2. Partner-specific motion
3. Geography
4. Company segment
5. Manual review fallback

## Routing Principle

Qualification answers:

Is this lead commercially ready?

Routing answers:

Where should this qualified lead go?

These decisions must remain separate.
