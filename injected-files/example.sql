drop database sko;
create database sko;
drop table call;
create table call (
VmailMessage numeric(10),
DayMins decimal(10,2),
EveMins decimal(10,2),
NightMins decimal(10,2),
IntlMins decimal(10,2),
CustServCalls numeric(10),
DayCalls numeric(10),
DayCharge decimal(10,2),
EveCalls numeric(10),
EveCharge decimal(10,2),
NightCalls numeric(10),
NightCharge decimal(10,2),
IntlCalls numeric(10),
IntlCharge decimal(10,2),
AreaCode numeric(10),
Phone varchar(20) CONSTRAINT call_phone_pk PRIMARY KEY
);

COPY call FROM 'CallsData.csv' ( FORMAT CSV, DELIMITER(';'), HEADER(TRUE));

drop table contract;
create table contract (
AccountLength numeric(10),
Churn numeric(10),
IntlPlan numeric(10),
VmailPlan numeric(10),
State varchar(10),
AreaCode numeric(10),
Phone varchar(25) CONSTRAINT contract_phone_pk PRIMARY KEY
);

COPY contract FROM 'ContractData.csv' ( FORMAT CSV, DELIMITER(','), HEADER(TRUE));
