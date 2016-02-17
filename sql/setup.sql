# sensor table representing different kinds of sensors with relevant attributes
create table tbl_sensor(
  sid serial primary key not null,
  name text,
  type text,
  measurement text,
  measurement_unit text,
  accuracy double precision,
  accuracy_unit text,
  update_rate double precision,
  update_rate_unit text,
  position text,
  description text);

select * from tbl_sensor;

# web thermograph: temperature sensor
insert into tbl_sensor (
  name,
  type,
  measurement,
  measurement_unit,
  accuracy,
  accuracy_unit,
  update_rate,
  update_rate_unit,
  position,
  description)
values (
  'wt_00',
  'web thermograph',
  'air temperature',
  'degreesCelsius',
  0.1,
  'degreesCelsius',
  1.0/30.0,
  'hertz',
  'wall-east-0',
  'web thermograph 0 measuring air temperature');

# rtm: temperature sensor (modbus)
insert into tbl_sensor (
  name,
  type,
  measurement,
  measurement_unit,
  accuracy,
  accuracy_unit,
  update_rate,
  update_rate_unit,
  position,
  description)
values (
  'rtm_00',
  'temperature sensor (modbus)',
  'air temperature',
  'degreesCelsius',
  0.1,
  'degreesCelsius',
  1.0/30.0,
  'hertz',
  'wall-north-0',
  'temperature sensor (modbus) 0 measuring air temperature');

# fm: flowmeter
insert into tbl_sensor (
  name,
  type,
  measurement,
  measurement_unit,
  accuracy,
  accuracy_unit,
  update_rate,
  update_rate_unit,
  position,
  description)
values (
  'fm_00',
  'flowmeter',
  'volume flow',
  'literPerHour',
  0.1,
  'literPerHour',
  1.0/30.0,
  'hertz',
  'heating-wall-south',
  'flowmeter measuring volume flow');

# table for web thermograph sensor 00 that used for logging measured values
create table tbl_sensor_wt_00 (
  wt_00_id serial primary key not null,
  sid int REFERENCES tbl_sensor (sid),
  unix_epoch double precision,
  data double precision);

insert into tbl_sensor_wt_00(
  sid,
  unix_epoch,
  data)
values
(1, 1452509095.17, 21.6),
(1, 1452509130.75, 21.6),
(1, 1452509191.69, 21.6),
(1, 1452510776.06, 21.5),
(1, 1452510837.01, 21.5),
(1, 1452510897.95, 21.5);

create table tbl_sensor_wt_01 (
  wt_01_id serial primary key not null,
  sid int REFERENCES tbl_sensor (sid),
  unix_epoch double precision,
  data double precision);

insert into tbl_sensor_wt_01(
  sid,
  unix_epoch,
  data)
values
(2, 1452509095.17, 21.5),
(2, 1452509130.75, 21.5),
(2, 1452509191.69, 21.5),
(2, 1452510776.06, 21.4),
(2, 1452510837.01, 21.4),
(2, 1452510897.95, 21.4);

create table tbl_sensor_wt_02 (
  wt_02_id serial primary key not null,
  sid int REFERENCES tbl_sensor (sid),
  unix_epoch double precision,
  data double precision);

insert into tbl_sensor_wt_02(
  sid,
  unix_epoch,
  data)
values
(3, 1452509095.17, 22.1),
(3, 1452509130.75, 22.2),
(3, 1452509191.69, 22.2),
(3, 1452510776.06, 22),
(3, 1452510837.01, 22),
(3, 1452510897.95, 21.9);

create table tbl_sensor_wt_03 (
  wt_03_id serial primary key not null,
  sid int REFERENCES tbl_sensor (sid),
  unix_epoch double precision,
  data double precision);

insert into tbl_sensor_wt_03(
  sid,
  unix_epoch,
  data)
values
(4, 1452509095.17, 21.8),
(4, 1452509130.75, 21.8),
(4, 1452509191.69, 21.8),
(4, 1452510776.06, 21.8),
(4, 1452510837.01, 21.8),
(4, 1452510897.95, 21.8);

create table tbl_sensor_rtm_00 (
  rtm_00_id serial primary key not null,
  sid int REFERENCES tbl_sensor (sid),
  unix_epoch double precision,
  data double precision);

  insert into tbl_sensor_rtm_00(
    sid,
    unix_epoch,
    data)
values
(5, 1452509095.17, 23.2),
(5, 1452509130.75, 23.2),
(5, 1452509191.69, 23.2),
(5, 1452510776.06, 23),
(5, 1452510837.01, 23),
(5, 1452510897.95, 23);

create table tbl_sensor_rtm_01 (
  rtm_01_id serial primary key not null,
  sid int REFERENCES tbl_sensor (sid),
  unix_epoch double precision,
  data double precision);

insert into tbl_sensor_rtm_01(
  sid,
  unix_epoch,
  data)
values
(6, 1452509095.17, 22.4),
(6, 1452509130.75, 22.4),
(6, 1452509191.69, 22.4),
(6, 1452510776.06, 22.4),
(6, 1452510837.01, 22.4),
(6, 1452510897.95, 22.4);

create table tbl_sensor_fm_00 (
  fm_00_id serial primary key not null,
  sid int REFERENCES tbl_sensor (sid),
  unix_epoch double precision,
  data double precision);

insert into tbl_sensor_fm_00(
  sid,
  unix_epoch,
  data)
values
(7, 1452509095.17, 0),
(7, 1452509130.75, 0),
(7, 1452509191.69, 0),
(7, 1452510776.06, 0),
(7, 1452510837.01, 0),
(7, 1452510897.95, 0);

# transform unix epoch to timestamp with accuracy based on minutes
-- select wt_02_id, date_trunc('minute', to_timestamp(unix_epoch)), to_timestamp(unix_epoch)
-- from tbl_sensor_wt_02 a, tbl_sensor b
-- where a.sid = b.sid;
