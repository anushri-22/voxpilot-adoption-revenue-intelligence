-- VoxPilot: synthetic demonstration data. Run once in Snowflake.
USE DATABASE VOXPILOT;
USE SCHEMA ANALYTICS;

CREATE TABLE IF NOT EXISTS CUSTOMERS (
 CUSTOMER_ID VARCHAR(10), CUSTOMER_NAME VARCHAR(100), INDUSTRY VARCHAR(50),
 ARR NUMBER(12,2), RENEWAL_DATE DATE, CONTRACTED_MONTHLY_CAPACITY NUMBER,
 DEPLOYED_CHANNELS VARCHAR(100)
);
CREATE TABLE IF NOT EXISTS PRODUCT_USAGE (
 CUSTOMER_ID VARCHAR(10), USAGE_DATE DATE, CHANNEL VARCHAR(20),
 CONVERSATIONS NUMBER, API_ERRORS NUMBER, AVG_LATENCY_MS NUMBER,
 SUCCESSFUL_CONVERSATIONS NUMBER
);
CREATE TABLE IF NOT EXISTS ACCOUNT_ACTIONS (
 ACTION_ID VARCHAR(10), CUSTOMER_ID VARCHAR(10), ACTION_DATE DATE,
 ACTION_TYPE VARCHAR(100), RECOMMENDATION VARCHAR(500),
 STATUS VARCHAR(30), OUTCOME VARCHAR(500), REVENUE_IMPACT NUMBER(12,2)
);

-- Idempotent seed: rerunning this file replaces only VoxPilot demonstration records.
DELETE FROM ACCOUNT_ACTIONS;
DELETE FROM PRODUCT_USAGE;
DELETE FROM CUSTOMERS;

INSERT INTO CUSTOMERS
SELECT 'C' || LPAD(SEQ4()::VARCHAR,3,'0') AS CUSTOMER_ID,
       COLUMN1 AS CUSTOMER_NAME, COLUMN2 AS INDUSTRY,
       COLUMN3 AS ARR,
       DATEADD(day, COLUMN4, '2026-10-25'::DATE) AS RENEWAL_DATE,
       COLUMN5 AS CONTRACTED_MONTHLY_CAPACITY,
       COLUMN6 AS DEPLOYED_CHANNELS
FROM VALUES
 ('Meridian Travel','Travel',180000,94,160000,'Web,Mobile,API'),
 ('Nova Retail','Retail',120000,150,115000,'Web,API'),
 ('Harbour Finance','Financial Services',260000,40,240000,'Web,Mobile,API'),
 ('Atlas Health','Healthcare',210000,180,185000,'Web,API'),
 ('Northstar Logistics','Logistics',175000,60,160000,'Mobile,API'),
 ('Cedar Learning','Education',95000,210,80000,'Web,Mobile'),
 ('Pioneer Energy','Energy',225000,120,195000,'Web,API'),
 ('Orchid Media','Media',110000,85,100000,'Web,Mobile,API'),
 ('Lumen Insurance','Insurance',240000,70,210000,'Web,API'),
 ('Summit Hotels','Hospitality',135000,145,120000,'Web,Mobile'),
 ('BluePeak Commerce','Retail',155000,200,135000,'Web,Mobile,API'),
 ('Evergreen Bank','Financial Services',280000,50,260000,'Web,Mobile,API'),
 ('Solstice Mobility','Transport',165000,175,140000,'Mobile,API'),
 ('Beacon Telecom','Telecommunications',250000,95,225000,'Web,API'),
 ('Clearwater Legal','Legal',105000,230,90000,'Web,API'),
 ('UrbanNest Property','Property',125000,125,105000,'Web,Mobile'),
 ('Horizon Airlines','Travel',230000,55,205000,'Web,Mobile,API'),
 ('Maple Foods','Food & Beverage',115000,195,100000,'Web,API'),
 ('Aster Technology','Technology',195000,115,175000,'Web,Mobile,API'),
 ('Bridgewater Utilities','Utilities',185000,75,165000,'Web,API'),
 ('Copperfield Services','Professional Services',145000,165,130000,'Web,Mobile'),
 ('Redwood Fitness','Fitness',90000,250,75000,'Mobile,API'),
 ('Silverline Automotive','Automotive',205000,135,185000,'Web,API'),
 ('Cloudline Software','Technology',215000,105,195000,'Web,Mobile,API'),
 ('Willow Charities','Nonprofit',80000,280,70000,'Web,Mobile')
;

-- 180 complete days ending 2026-10-24, one row per customer/channel/day.
-- Scenario accounts: C000 usage decline + API errors, C001 healthy growth,
-- C002 reliability regression, C003 successful adoption, C004 usage decline.
INSERT INTO PRODUCT_USAGE
WITH days AS (
 SELECT DATEADD(day, -179 + SEQ4(), '2026-10-24'::DATE) AS USAGE_DATE
 FROM TABLE(GENERATOR(ROWCOUNT => 180))
), channels AS (
 SELECT COLUMN1 AS CHANNEL, COLUMN2 AS SHARE
 FROM VALUES ('Web',0.48),('Mobile',0.27),('API',0.25)
), raw AS (
 SELECT c.CUSTOMER_ID, d.USAGE_DATE, ch.CHANNEL,
   DATEDIFF(day, '2026-04-28'::DATE, d.USAGE_DATE) AS DAY_NUMBER,
   ch.SHARE,
   CASE
    WHEN c.CUSTOMER_ID IN ('C000','C004') AND d.USAGE_DATE >= '2026-09-25' THEN 0.65
    WHEN c.CUSTOMER_ID IN ('C001','C003') THEN 1 + DATEDIFF(day,'2026-04-28'::DATE,d.USAGE_DATE)*0.003
    ELSE 1 END AS USAGE_FACTOR,
   CASE WHEN c.CUSTOMER_ID IN ('C000','C002') AND d.USAGE_DATE >= '2026-09-25'
      AND ch.CHANNEL='API' THEN 0.095 ELSE 0.012 END AS ERROR_FACTOR,
   CASE WHEN c.CUSTOMER_ID IN ('C000','C002') AND d.USAGE_DATE >= '2026-09-25'
      THEN 0.67 ELSE 0.91 END AS SUCCESS_FACTOR
 FROM CUSTOMERS c
 CROSS JOIN days d
 JOIN channels ch ON CONTAINS(c.DEPLOYED_CHANNELS,ch.CHANNEL)
), counts AS (
 SELECT CUSTOMER_ID, USAGE_DATE, CHANNEL,
 GREATEST(0,ROUND((80 + MOD(ABS(HASH(CUSTOMER_ID,USAGE_DATE,CHANNEL)),70))
   * SHARE * USAGE_FACTOR))::NUMBER AS CONVERSATIONS,
 ERROR_FACTOR, SUCCESS_FACTOR
 FROM raw
)
SELECT CUSTOMER_ID, USAGE_DATE, CHANNEL, CONVERSATIONS,
 LEAST(CONVERSATIONS,ROUND(CONVERSATIONS*ERROR_FACTOR))::NUMBER AS API_ERRORS,
 CASE WHEN ERROR_FACTOR > 0.05 THEN 1900 ELSE 620 + MOD(ABS(HASH(CUSTOMER_ID,USAGE_DATE)),350) END AS AVG_LATENCY_MS,
 LEAST(CONVERSATIONS,ROUND(CONVERSATIONS*SUCCESS_FACTOR))::NUMBER AS SUCCESSFUL_CONVERSATIONS
FROM counts;

INSERT INTO ACCOUNT_ACTIONS VALUES
('A001','C000','2026-10-12','Technical review','Investigate API error spike and mobile adoption decline','In Progress','Pending integration diagnostics',0),
('A002','C001','2026-10-15','Expansion discovery','Validate order tracking agent use case','Qualified','Illustrative £36k ARR opportunity; not closed',0),
('A003','C002','2026-10-18','Engineering escalation','Review API failure traces before renewal','Open','Pending remediation',0),
('A004','C003','2026-09-30','Enablement','Train second department on agent workflows','Completed','Adoption increased in synthetic usage series',0);

SELECT (SELECT COUNT(*) FROM CUSTOMERS) AS CUSTOMER_COUNT,
       (SELECT COUNT(*) FROM PRODUCT_USAGE) AS USAGE_ROWS,
       (SELECT COUNT(*) FROM ACCOUNT_ACTIONS) AS ACTION_ROWS,
       (SELECT MIN(USAGE_DATE) FROM PRODUCT_USAGE) AS FIRST_DATE,
       (SELECT MAX(USAGE_DATE) FROM PRODUCT_USAGE) AS LAST_DATE;
