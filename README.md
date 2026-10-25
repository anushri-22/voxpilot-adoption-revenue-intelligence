# VoxPilot — Customer Adoption-to-Revenue Intelligence

An independent portfolio prototype that translates AI agent usage and technical performance into proactive customer success and commercial account decisions.

## Live dashboard
Enable GitHub Pages for the `main` branch, `/ (root)` folder. The dashboard loads `data/account_intelligence.json` locally from the repository.

## What it demonstrates
- 25 synthetic B2B customers and Snowflake-derived account intelligence.
- Searchable account priority queue and customer-level drill-down.
- Usage change, agent success, API error rate, latency and capacity utilisation.
- Rule-based next-best actions, risk-associated ARR and illustrative expansion sizing.

## Data pipeline
Synthetic customer and daily usage tables → Snowflake `ACCOUNT_INTELLIGENCE` view → CSV export → `data/account_intelligence.json` → GitHub Pages.

This repository contains a **static export**, not a live Snowflake integration. Do not commit Snowflake credentials. To refresh, rerun the Snowflake view and replace the JSON export.

## Important interpretation
- All customer names, usage and contracts are **synthetic**.
- The snapshot covers data through **2026-10-24**.
- ARR associated with risk is **not** predicted lost revenue.
- Illustrative expansion is **not** a qualified pipeline or forecast.
- In this particular SQL export, **no accounts meet the expansion criteria**. The UI reports this explicitly rather than inventing opportunities.
- Health thresholds are prototype rules, not statistically validated churn predictions.
- The dashboard does not claim to prove that interventions caused revenue outcomes.

## Next iteration
Add time-series charts from daily Snowflake telemetry, import the synthetic `ACCOUNT_ACTIONS` log, and compare pre/post intervention periods. Add a CRM opportunity qualification workflow for healthy accounts.

## Technology
Snowflake SQL (upstream), HTML, CSS, JavaScript, JSON, GitHub Pages.
