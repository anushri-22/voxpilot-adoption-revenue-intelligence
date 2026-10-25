# VoxPilot — Customer Adoption & Revenue Intelligence

**Snowflake SQL · Product Analytics · Customer Success · Revenue Intelligence · Interactive Dashboard**

### [Explore the Live Dashboard](https://anushri-22.github.io/voxpilot-adoption-revenue-intelligence/)

**Demo note:** VoxPilot is an independent portfolio analytics prototype using 25 synthetic B2B SaaS customers. It demonstrates how product telemetry can be translated into actionable customer success and commercial intelligence. All customer records, revenue figures, and opportunities are illustrative.

## The Problem

B2B SaaS companies already collect extensive product usage data through analytics platforms, API monitoring systems, and customer success tools.

However, understanding product usage is different from knowing what action to take.

A customer might experience declining API performance, reduced engagement, or low adoption across certain channels without raising a support ticket. By the time the problem becomes visible during a renewal conversation, the account may already be at risk.

Equally, customers with strong product adoption may have untapped expansion potential that is not immediately obvious from standard usage reports.

**The challenge is connecting technical product signals with proactive account management and commercial decisions.**

## The Solution

VoxPilot explores an additional intelligence layer built on top of existing product telemetry and commercial account data.

Rather than replacing existing analytics, CRM, or customer success platforms, it translates their underlying signals into three questions:

1. Which customers need attention before they raise an issue?
2. What is driving adoption risk or limiting product value?
3. Where could product usage indicate a potential expansion opportunity?

The prototype uses Snowflake SQL to process synthetic customer and product usage data, classify account health, and generate rule-based recommendations.

## Live Dashboard

[Open VoxPilot — Customer Adoption & Revenue Intelligence](https://anushri-22.github.io/voxpilot-adoption-revenue-intelligence/)

The interactive dashboard includes:

- **Portfolio overview:** Total ARR, ARR associated with at-risk accounts, and accounts requiring attention.
- **Account priority queue:** Searchable customer portfolio with health classifications and commercial context.
- **Product adoption intelligence:** Usage changes, conversation volumes, agent success rates, and capacity utilisation.
- **Technical performance:** API error rates and average latency.
- **Renewal intelligence:** Upcoming renewal dates alongside account health signals.
- **Recommended actions:** Rule-based technical reviews, adoption interventions, and commercial opportunity discovery.

## Example: Detecting Customer Risk Before Renewal

Consider Meridian Travel, a synthetic customer with £180,000 ARR.

The dashboard identifies:

| Metric | Observed signal |
|---|---|
| Product usage | 33.3% decline |
| Agent goal success | 66.5% |
| API error rate | 2.5% |
| Average latency | 1,055 ms |
| Account health | High Risk |

Rather than waiting for the customer to report dissatisfaction, an account manager could use these signals to initiate a technical investigation.

**Recommended workflow:**

Investigate the technical performance issues, validate whether they explain the usage decline, coordinate remediation with engineering, and establish an adoption recovery plan before renewal.

This demonstrates how product telemetry can inform proactive retention activity.

The example does not claim that the intervention prevented churn; it illustrates how an earlier intervention could be prioritised.

## From Product Adoption to Commercial Growth

VoxPilot also explores how product usage can inform account expansion conversations.

| Product signal | Potential opportunity |
|---|---|
| Sustained high capacity utilisation | Review whether additional capacity is needed |
| Strong adoption in one deployment channel | Explore rollout to additional channels |
| High agent success and growing usage | Investigate additional workflows or departments |
| Low adoption despite contracted capacity | Prioritise enablement before proposing expansion |

Expansion estimates in the prototype are illustrative sizing assumptions, not sales forecasts, booked revenue, or validated customer demand.

The purpose is to help account managers identify where discovery conversations may be commercially relevant.

## Technical Architecture

**Data sources (synthetic)**

Customer account information, contract ARR, renewal dates, deployed channels, daily usage, technical performance, and account actions.

↓

**Snowflake — Data & Analytics Layer**

- Store customer and product usage records.
- Aggregate usage and performance metrics.
- Compare recent and previous activity.
- Calculate account health indicators.
- Apply rule-based classifications and next-best-action logic.

↓

**Account Intelligence View**

A customer-level analytical view combining product adoption, technical performance, renewal context, and commercial signals.

↓

**Interactive Dashboard**

A standalone HTML and JavaScript dashboard using a JSON snapshot of account intelligence.

↓

**Customer Success & Commercial Decisions**

Prioritise technical interventions, adoption recovery, renewal preparation, and expansion discovery.

## Technology Stack

| Technology | Purpose |
|---|---|
| Snowflake | Data storage and SQL analytics |
| SQL | Data transformations, account health classification, and commercial rules |
| JSON | Transfer of account intelligence into the dashboard |
| HTML, CSS, JavaScript | Interactive dashboard and customer drill-down |
| GitHub Pages | Public hosting of the prototype |

## Repository Structure

```text
voxpilot-adoption-revenue-intelligence/
│
├── index.html
├── README.md
│
├── data/
│   └── account_intelligence.json
│
└── sql/
    ├── voxpilot_setup.sql
    ├── voxpilot_data.sql
    └── voxpilot_intelligence.sql
```

### SQL Pipeline

**1. voxpilot_setup.sql**

Creates the Snowflake database and analytics schema.

**2. voxpilot_data.sql**

Creates synthetic customer, product usage, and account action records.

**3. voxpilot_intelligence.sql**

Calculates customer-level adoption and performance metrics, classifies account health, and produces account intelligence for commercial decision-making.

The dashboard uses an exported JSON snapshot rather than a live Snowflake connection. It is therefore a static-data demonstration, not a real-time monitoring service.

## Key Design Decisions

**An intelligence layer, not another CRM**

VoxPilot is designed to complement existing analytics, customer success, and CRM systems by connecting product signals to recommended account actions.

**Technical signals linked to commercial context**

API errors, latency, usage changes, and agent success are analysed alongside ARR and renewal timing.

**Explainable rules**

Account health and recommendations are generated through SQL-based rules rather than opaque AI predictions.

**Actionable insights**

The objective is not simply to display metrics but to help identify what a customer-facing team should investigate next.

## Limitations & Future Development

This is a proof-of-concept, not a production customer intelligence platform.

Potential extensions include:

- Automated ingestion of product telemetry and CRM data.
- Channel-specific adoption and integration health analysis.
- Trend-based alerts for emerging adoption and technical issues.
- Opportunity scoring based on sustained usage and commercial eligibility.
- CRM task creation and ownership tracking.
- Measurement of interventions against subsequent adoption, retention, and expansion outcomes.

## Why I Built This

My experience in B2B SaaS customer success has shown me that account growth depends on understanding both the customer and how they use the product.

Traditional account reviews often focus on adoption metrics, renewal dates, and customer sentiment separately. I wanted to explore how those signals could be brought together to identify technical friction earlier, prioritise interventions, and uncover commercially relevant opportunities.

VoxPilot combines customer success, product analytics, SQL, and commercial account management in a practical portfolio prototype.

---

**Built as an independent portfolio project using synthetic data. Not affiliated with any commercial AI platform or vendor.**
