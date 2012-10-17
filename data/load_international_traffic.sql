--load into working
--load into final
--  where loading into final has gid and geom

-- Table: ib.traffic_2010

DROP TABLE if exists ib.traffic_2010;
CREATE TABLE ib.traffic_2010
(
  country character varying(100),
  messages_billed_us numeric,
  minutes_billed_us numeric,
  us_revenue_billed_us numeric,
  payout_billed_us numeric,
  retained_revenue_billed_us numeric,
  messages_term_us numeric,
  minutes_term_us numeric,
  reciepts_foreign_term_us numeric,
  reciepts_foreign_trans_us numeric,
  payout_trans_us numeric,
  retained_revenue_trans_us numeric,
  retained_revenue_total numeric,
  latitude numeric,
  longitude numeric,
  region character varying(50), 
  symsize numeric, 
  gid serial not null,
  sum_region numeric,
  pct_country numeric,
  pct_region numeric,
  geom geometry
)
WITH (
  OIDS=true
);
ALTER TABLE ib.traffic_2010 OWNER TO postgres;
alter table ib.traffic_2010 
  add CONSTRAINT ib_traffic_2010_pkey PRIMARY KEY (gid);
  
DROP TABLE if exists ib.working;
CREATE TABLE ib.working
(
  country character varying(100),
  messages_billed_us numeric,
  minutes_billed_us numeric,
  us_revenue_billed_us numeric,
  payout_billed_us numeric,
  retained_revenue_billed_us numeric,
  messages_term_us numeric,
  minutes_term_us numeric,
  reciepts_foreign_term_us numeric,
  reciepts_foreign_trans_us numeric,
  payout_trans_us numeric,
  retained_revenue_trans_us numeric,
  retained_revenue_total numeric,
  latitude numeric,
  longitude numeric
)
WITH (
  OIDS=FALSE
);
ALTER TABLE ib.working OWNER TO postgres;

--do africa
copy ib.working from 
  './data/africa.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Africa' where region is null;

--do asia
truncate ib.working;
copy ib.working from 
  './data/asia.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Asia' where region is null;

--do Caribean
truncate ib.working;
copy ib.working from 
  './data/caribean.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Caribean' where region is null;

--do Eastern Europe
truncate ib.working;
copy ib.working from 
  './data/eastern_europe.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Eastern Europe' where region is null;

--do Middle East
truncate ib.working;
copy ib.working from 
  './data/middle_east.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Middle East' where region is null;

--do North & Central America
truncate ib.working;
copy ib.working from 
  './data/north_central_america.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'North and Central America' where region is null;

--do Oceania
truncate ib.working;
copy ib.working from 
  './data/oceania.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Oceania' where region is null;

--do Other Regions
truncate ib.working;
copy ib.working from 
  './data/other-regions.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Other Regions' where region is null;

--do South America
truncate ib.working;
copy ib.working from 
  './data/south_america.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'South America' where region is null;

--Western Europe
truncate ib.working;
copy ib.working from 
  './data/western_europe.csv'
  csv header delimiter ',';
insert into ib.traffic_2010 (select * from ib.working);
update ib.traffic_2010 set sum_region = (select sum(minutes_billed_us) from ib.working) where region is null;
update ib.traffic_2010 set region = 'Western Europe' where region is null;

update ib.traffic_2010 
  set symsize = 1
  where minutes_billed_us > 1500000000;

update ib.traffic_2010 
  set symsize = 2 
  where minutes_billed_us > 250000000 and minutes_billed_us < 1500000000;

update ib.traffic_2010 
  set symsize = 3
  where minutes_billed_us > 100000000 and minutes_billed_us < 250000000;

update ib.traffic_2010 
  set symsize = 4
  where minutes_billed_us > 25000000 and minutes_billed_us < 100000000;

update ib.traffic_2010 
  set symsize = 5
  where minutes_billed_us > 10000000 and minutes_billed_us < 25000000;

update ib.traffic_2010 
  set symsize = 6
  where minutes_billed_us > 1000000 and minutes_billed_us < 10000000;

update ib.traffic_2010 
  set symsize = 7
  where minutes_billed_us < 1000000;

--select country, minutes_billed_us, symsize from ib.traffic_2010
--  order by minutes_billed_us desc;

--populate fields for percentage mouse overs
update ib.traffic_2010 set pct_country = round((minutes_billed_us / sum_region) * 100,2);
update ib.traffic_2010 set pct_region = round(100 - pct_country,2);

copy ib.traffic_2010 to 
  './data/traffic_2010.csv'
  csv header delimiter ',';

--populate geometry
update ib.traffic_2010 
  set geom = ST_GeometryFromText('POINT(' || longitude || ' ' || latitude || ')', 4326);
  