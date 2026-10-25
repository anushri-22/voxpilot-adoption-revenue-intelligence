VoxPilot — Customer Adoption & Revenue Intelligence
Snowflake SQL · Product Analytics · Customer Success · Revenue Intelligence · Interactive Dashboard
Explore the Live Dashboard · View Source on GitHub
> **Portfolio demonstration:** VoxPilot uses 25 fictional B2B SaaS accounts and synthetic AI-agent product telemetry. Customer identities, ARR, commercial opportunities and scenario assumptions are illustrative. This is not a production system, a live Snowflake connection or qualified sales pipeline.
Dashboard preview
![VoxPilot expansion intelligence dashboard](assets/voxpilot-expansion-dashboard.png)
Expansion Intelligence: three hypothetical opportunities representing £152,000 in illustrative potential ARR. These are scenarios to validate, not forecast or contracted revenue.
The problem
Customer-facing teams can see usage, API performance and contract information in separate systems, but it is harder to turn those signals into timely account decisions. Declining usage or technical friction may go unnoticed until a renewal conversation. Strong adoption may also suggest an opportunity for a customer discovery conversation, without proving demand for an upsell.
What I built
VoxPilot is a customer adoption-to-revenue intelligence prototype. It combines product telemetry with commercial context to help answer:
Retention: Which customers need attention before renewal, and why?
Adoption: Is technical friction or limited usage holding back customer value?
Expansion: Which accounts merit discovery about additional capacity, teams or workflows?
The Snowflake SQL layer creates explainable account-health and opportunity classifications. A standalone HTML/JavaScript dashboard presents exported JSON snapshots in a searchable account portfolio and customer drill-down.
Dashboard capabilities
Portfolio overview: Total ARR, ARR associated with flagged accounts, and number of accounts needing attention.
Account priority queue: Search, sort and review synthetic customers by account-health and usage signals.
Adoption and technical health: Usage change, AI-agent goal success, API error rates, latency and capacity utilisation.
Renewal context: ARR and renewal timing alongside account-health signals.
Recommended next actions: Rule-based suggestions for technical investigation, adoption recovery and customer discovery.
Expansion Intelligence: A separate scenario-based view of possible capacity and workflow expansion, including illustrative ARR assumptions.
Example: proactive retention
Meridian Travel is a fictional £180,000 ARR account. The prototype flags a 33.3% usage decline, 66.5% agent goal success, 2.5% API error rate and 1,055 ms average latency, producing a High Risk classification.
A plausible account-management response would be to investigate performance with technical teams, establish whether it explains the adoption decline, agree corrective actions with the customer, and monitor recovery ahead of renewal. This is a prioritisation example, not evidence that churn was prevented.
Example: scenario-based expansion
The current-state portfolio signals do not identify accounts that meet the original SQL-defined expansion criteria. A separate hypothetical scenario model explores what could become relevant if adoption and utilisation changed.
Fictional account	Scenario	Illustrative potential ARR	Discovery action
Evergreen Bank	Capacity expansion	£56,000	Validate demand for additional contracted capacity
Beacon Telecom	Workflow expansion	£50,000	Explore additional teams, channels or AI workflows
Horizon Airlines	Capacity expansion	£46,000	Validate demand for additional contracted capacity
Total	3 scenarios	£152,000	Validate before treating as pipeline
These are illustrative sizing assumptions, not customer commitments, qualified pipeline or revenue forecasts. Keeping current-state and scenario-based insights separate avoids presenting hypothetical growth as observed demand.
Architecture
```text
Synthetic customer + contract + AI-agent telemetry
                    |
                    v
        Snowflake database and SQL
        - customer and usage records
        - adoption / performance metrics
        - account health classifications
        - opportunity and scenario logic
                    |
                    v
           JSON snapshot exports
        - account_intelligence.json
        - opportunity_intelligence.json
                    |
                    v
     HTML / CSS / JavaScript dashboard
              (GitHub Pages)
                    |
                    v
    Retention prioritisation and expansion discovery
```
Technology: Snowflake, SQL, JSON, HTML, CSS, JavaScript and GitHub Pages. The public dashboard loads static JSON files; it does not query Snowflake or any external CRM in real time.
Repository structure
```text
voxpilot-adoption-revenue-intelligence/
├── index.html
├── README.md
├── assets/
│   └── voxpilot-expansion-dashboard.png   # upload this screenshot
├── data/
│   ├── account_intelligence.json
│   └── opportunity_intelligence.json
└── sql/
    ├── voxpilot_setup.sql
    ├── voxpilot_data.sql
    ├── voxpilot_intelligence.sql
    ├── voxpilot_opportunities.sql          # add if not yet published
    └── voxpilot_expansion_scenarios.sql    # add if not yet published
```
SQL pipeline: `voxpilot_setup.sql` establishes the analytics environment; `voxpilot_data.sql` generates synthetic source data; `voxpilot_intelligence.sql` builds account-level health metrics; `voxpilot_opportunities.sql` classifies opportunity signals; and `voxpilot_expansion_scenarios.sql` defines hypothetical growth cases. The last two SQL files should be committed to the public repository if they currently exist only in Snowflake worksheets.
Design decisions and limitations
Explainable rules, not AI predictions: Classifications and recommendations are based on defined SQL logic.
Commercial context with technical evidence: Usage and performance signals are considered alongside ARR and renewal timing.
Current state versus scenarios: The project distinguishes observed signals from hypothetical opportunity assumptions.
Synthetic and static: All records are fictional; the dashboard is a snapshot, not a monitoring or forecasting service.
Not vendor-affiliated: This is an independent portfolio project and is not affiliated with ElevenLabs or another commercial AI platform.
Why I built it
My work in B2B SaaS customer success has reinforced the importance of connecting product adoption with commercial outcomes. I built VoxPilot to demonstrate how an account manager or technical customer success professional could use SQL and product telemetry to prioritise technical issues, protect adoption and make better-informed expansion discovery decisions.
---
Launch the dashboard · Explore the repository
