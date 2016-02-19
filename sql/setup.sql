# sensor table representing different kinds of sensors with relevant attributes
create table tbl_sensor_meta(
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

select * from tbl_sensor_meta;

# web thermograph: temperature sensor
insert into tbl_sensor_meta (
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
values
  ('wt_00','web thermograph','air temperature','degreesCelsius',0.1,'degreesCelsius',1.0/30.0,'hertz','wall-east-0','web thermograph 0 measuring air temperature'),
  ('wt_01','web thermograph','air temperature','degreesCelsius',0.1,'degreesCelsius',1.0/30.0,'hertz','wall-east-0','web thermograph 1 measuring air temperature'),
  ('wt_02','web thermograph','air temperature','degreesCelsius',0.1,'degreesCelsius',1.0/30.0,'hertz','wall-east-0','web thermograph 2 measuring air temperature'),
  ('wt_03','web thermograph','air temperature','degreesCelsius',0.1,'degreesCelsius',1.0/30.0,'hertz','wall-east-0','web thermograph 3 measuring air temperature'),
  ('rtm_00','temperature sensor (modbus)','air temperature','degreesCelsius',0.1,'degreesCelsius',1.0/30.0,'hertz','wall-north-0','temperature sensor (modbus) 0 measuring air temperature'),
  ('rtm_01','temperature sensor (modbus)','air temperature','degreesCelsius',0.1,'degreesCelsius',1.0/30.0,'hertz','wall-north-0','temperature sensor (modbus) 1 measuring air temperature'),
  ('fm_00','flowmeter','volume flow','literPerHour',0.1,'literPerHour',1.0/30.0,'hertz','heating-wall-south','flowmeter 0 measuring volume flow');


# table for web thermograph sensor 00 that used for logging measured values
create table tbl_sensor_data (
  id serial primary key not null,
  sid int REFERENCES tbl_sensor_meta (sid),
  unix_epoch double precision,
  data double precision);

insert into tbl_sensor_data(
  sid,
  unix_epoch,
  data)
values
(1, 1452509095.17, 21.6),
(2, 1452509095.17, 21.5),
(3, 1452509095.17, 22.1),
(4, 1452509095.17, 21.8),
(5, 1452509095.17, 23.2),
(6, 1452509095.17, 22.4),
(7, 1452509095.17, 0),
(1, 1452509130.75, 21.6),
(2, 1452509130.75, 21.5),
(3, 1452509130.75, 22.2),
(4, 1452509130.75, 21.8),
(5, 1452509130.75, 23.2),
(6, 1452509130.75, 22.4),
(7, 1452509130.75, 0),
(1, 1452509191.69, 21.6),
(2, 1452509191.69, 21.5),
(3, 1452509191.69, 22.2),
(4, 1452509191.69, 21.8),
(5, 1452509191.69, 23.2),
(6, 1452509191.69, 22.4),
(7, 1452509191.69, 0),
(1, 1452510776.06, 21.5),
(2, 1452510776.06, 21.4),
(3, 1452510776.06, 22),
(4, 1452510776.06, 21.8),
(5, 1452510776.06, 23),
(6, 1452510776.06, 22.4),
(7, 1452510776.06, 0),
(1, 1452510837.01, 21.5),
(2, 1452510837.01, 21.4),
(3, 1452510837.01, 22),
(4, 1452510837.01, 21.8),
(5, 1452510837.01, 23),
(6, 1452510837.01, 22.4),
(7, 1452510837.01, 0),
(1, 1452510897.95, 21.5),
(2, 1452510897.95, 21.4),
(3, 1452510897.95, 21.9),
(4, 1452510897.95, 21.8),
(5, 1452510897.95, 23),
(6, 1452510897.95, 22.4),
(7, 1452510897.95, 0);

# transform unix epoch to timestamp with accuracy based on minutes
-- select wt_02_id, date_trunc('minute', to_timestamp(unix_epoch)), to_timestamp(unix_epoch)
-- from tbl_sensor_wt_02 a, tbl_sensor b
-- where a.sid = b.sid;
