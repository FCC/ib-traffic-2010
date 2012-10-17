select count(*), max(minutes_billed_us) as max, sum(minutes_billed_us) as sum, min(minutes_billed_us) as min, 
      avg(minutes_billed_us) as avg, stddev(minutes_billed_us) as stdev
  from ib.traffic_2010
  where minutes_billed_us < 250000000;

select count(*) from ib.traffic_2010;

select country, minutes_billed_us
  from ib.traffic_2010;

select country,minutes_billed_us
  from ib.traffic_2010
  where minutes_billed_us > 250000000
  order by minutes_billed_us desc;

select country,minutes_billed_us
  from ib.traffic_2010
  where minutes_billed_us > 100000000 and minutes_billed_us < 250000000
  order by minutes_billed_us desc;

select country,minutes_billed_us
  from ib.traffic_2010
  where minutes_billed_us > 10000000 and minutes_billed_us < 100000000
  order by minutes_billed_us desc;

select country,minutes_billed_us
  from ib.traffic_2010
  where minutes_billed_us > 10000000 and minutes_billed_us < 100000000
  order by minutes_billed_us desc;

select country,minutes_billed_us
  from ib.traffic_2010
  where minutes_billed_us > 1000000 and minutes_billed_us < 10000000
  order by minutes_billed_us desc;

select country,minutes_billed_us
  from ib.traffic_2010
  where minutes_billed_us < 1000000 
  order by minutes_billed_us desc;