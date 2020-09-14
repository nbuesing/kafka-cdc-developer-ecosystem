SET 'auto.offset.reset'='earliest';

create table ZIPCODE (ID VARCHAR PRIMARY KEY) with (KAFKA_TOPIC='mysql.inventory.ZIPCODE', VALUE_FORMAT='avro');
create table ZIPCODE2 (ID VARCHAR PRIMARY KEY) with (KAFKA_TOPIC='mysql.inventory.ZIPCODE2', VALUE_FORMAT='avro');
create table KNA1 (ID VARCHAR PRIMARY KEY) with (KAFKA_TOPIC='mysql.inventory.KNA1', VALUE_FORMAT='avro');
create table MARA (ID VARCHAR PRIMARY KEY) with (KAFKA_TOPIC='mysql.inventory.MARA', VALUE_FORMAT='avro');
create table MAKT (ID VARCHAR PRIMARY KEY) with (KAFKA_TOPIC='mysql.inventory.MAKT', VALUE_FORMAT='avro');

create stream AUSP with (KAFKA_TOPIC='mysql.inventory.AUSP', VALUE_FORMAT='avro');

  
create stream AUSP2 as
select AUSP.ATWRT, MAKT.* from AUSP
  left join MAKT on CONCAT(AUSP.ATWRT,'_E') = MAKT.ID;
  
-- Material Number (MATNR) XREF Customer Facing Number (CFN)
create table XREF with (KAFKA_TOPIC='xref', VALUE_FORMAT='avro') as
select OBJEK as MATNR, latest_by_offset(ATWRT) as CFN, latest_by_offset(MAKTX) as DESCRIPTION 
  from AUSP  
  left join MAKT on CONCAT(AUSP.ATWRT,'_E') = MAKT.ID
 where KLART='001' 
   and ATINN=1 
   and ADZHL=0 
   and ATWRT not like 'Z_%' and ATWRT not like 'N/A' 
   group by OBJEK; 

create stream MSKU with (KAFKA_TOPIC='mysql.inventory.MSKU', VALUE_FORMAT='avro');


create stream MSKU_ENRICHED
  with (KAFKA_TOPIC='MSKU_ENRICHED') 
    as 
select 
    MSKU.MATNR MATNR, 
    MSKU.WERKS WERKS, 
    MSKU.CHARG CHARG, 
    MSKU.KUNNR KUNNR, 
    MSKU.KULAB KULAB, 
    XREF.CFN CFN, 
    XREF.DESCRIPTION DESCRIPTION,
    KNA1.PSTLZ PSTLZ, 
    ZIPCODE.ZIPCODE ZIPCODE,
    ZIPCODE.GEO_POINT GEO_POINT,
    ZIPCODE2.STATE STATE,
    ZIPCODE2.STATE_ABBR STATE_ABBR,
    ZIPCODE2.COUNTY COUNTY,
    ZIPCODE2.CITY CITY,
    ZIPCODE2.COUNTY_FIPS COUNTY_FIPS
  from MSKU 
  join XREF on XREF.MATNR = MSKU.MATNR
  join KNA1 on KNA1.ID = MSKU.KUNNR
  join ZIPCODE on ZIPCODE.ID = SUBSTRING(KNA1.PSTLZ, 0, 5)
  join ZIPCODE2 on ZIPCODE2.ID = SUBSTRING(KNA1.PSTLZ, 0, 5)
  partition by MSKU.MATNR;

select 
    MSKU.MATNR MATNR, 
    MSKU.WERKS WERKS, 
    MSKU.CHARG CHARG, 
    MSKU.KUNNR KUNNR, 
    MSKU.KULAB KULAB, 
    XREF.CFN CFN, 
    XREF.DESCRIPTION DESCRIPTION,
    KNA1.PSTLZ PSTLZ
  from MSKU 
  join XREF on XREF.MATNR = MSKU.MATNR
  join KNA1 on KNA1.ID = MSKU.KUNNR emit changes;

create table qty_cfn_state
  with (KAFKA_TOPIC='qty.cfn.state') 
    as 
select CFN, STATE_ABBR STATE, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED
    group by CFN, STATE_ABBR;

create table cfn_state
  with (KAFKA_TOPIC='cfn.state') 
    as 
select KSQL_COL_0, split(KSQL_COL_0, '|+|')[1] as CFN, split(KSQL_COL_0, '|+|')[2] as STATE, QTY from qty_cfn_state;

create table qty_cfn_county
  with (KAFKA_TOPIC='qty.cfn.county') 
    as 
select CFN, COUNTY_FIPS as COUNTY, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED
    group by CFN, COUNTY_FIPS;

create table cfn_county
  with (KAFKA_TOPIC='cfn.county') 
    as 
select KSQL_COL_0, split(KSQL_COL_0, '|+|')[1] as CFN, split(KSQL_COL_0, '|+|')[2] as COUNTY, QTY from qty_cfn_county;



























create table product_county
  with (KAFKA_TOPIC='product.county') 
    as 
select CFN, COUNTY, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED
    group by CFN, COUNTY;
  
  
  
  




create stream D
  with (KAFKA_TOPIC='D') 
    as 
select 
    MSKU.MATNR MATNR, 
    MSKU.WERKS WERKS, 
    MSKU.CHARG CHARG, 
    MSKU.KUNNR KUNNR, 
    MSKU.KULAB KULAB,
    XREF.CFN CFN,
    KNA1.PSTLZ PSTLZ 
  from MSKU 
  join XREF on XREF.MATNR = MSKU.MATNR
  join KNA1 on KNA1.ID = MSKU.KUNNR
  partition by MSKU.MATNR;
  
create stream MSKU_ENRICHED
  with (KAFKA_TOPIC='MSKU_ENRICHED') 
    as 
select 
    MSKU.MATNR MATNR, 
    MSKU.WERKS WERKS, 
    MSKU.CHARG CHARG, 
    MSKU.KUNNR KUNNR, 
    MSKU.KULAB KULAB, 
    XREF.CFN CFN,
    XREF.DESCRIPTION DESCRIPTION, 
    KNA1.PSTLZ PSTLZ, 
    ZIPCODE.ZIPCODE ZIPCODE,
    ZIPCODE.GEO_POINT GEO_POINT,
    ZIPCODE2.STATE STATE,
    ZIPCODE2.STATE_ABBR STATE_ABBR,
    ZIPCODE2.COUNTY COUNTY,
    ZIPCODE2.CITY CITY
  from MSKU 
  join XREF on XREF.MATNR = MSKU.MATNR
  join KNA1 on KNA1.ID = MSKU.KUNNR
  join ZIPCODE on ZIPCODE.ID = SUBSTRING(KNA1.PSTLZ, 0, 5)
  join ZIPCODE2 on ZIPCODE2.ID = SUBSTRING(KNA1.PSTLZ, 0, 5)
  partition by MSKU.MATNR;
   
create stream MSKU_ENRICHED
  with (KAFKA_TOPIC='MSKU_ENRICHED') 
    as 
select 
    MSKU.MATNR MATNR, 
    MSKU.WERKS WERKS, 
    MSKU.CHARG CHARG, 
    MSKU.KUNNR KUNNR, 
    MSKU.KULAB KULAB, 
    XREF.CFN CFN, 
    KNA1.PSTLZ PSTLZ, 
    ZIPCODE.ZIPCODE ZIPCODE,
    ZIPCODE.GEO_POINT GEO_POINT
  from MSKU 
  join XREF on XREF.MATNR = MSKU.MATNR
  join KNA1 on KNA1.ID = MSKU.KUNNR
  join ZIPCODE on ZIPCODE.ID = SUBSTRING(KNA1.PSTLZ, 0, 5)
  partition by MSKU.MATNR;


create stream MSKU_ENRICHED
  with (KAFKA_TOPIC='MSKU_ENRICHED') 
    as 
select 
    MSKU.MATNR MATNR, 
    MSKU.WERKS WERKS, 
    MSKU.CHARG CHARG, 
    MSKU.KUNNR KUNNR, 
    MSKU.KULAB KULAB, 
    XREF.CFN CFN, 
    KNA1.PSTLZ PSTLZ
  from MSKU 
  join XREF on XREF.MATNR = MSKU.MATNR
  join KNA1 on KNA1.ID = MSKU.KUNNR
  partition by MSKU.MATNR;


create stream MSKU_ENRICHED with (KAFKA_TOPIC='MSKU_ENRICHED') as select MSKU.MATNR MATNR, MSKU.WERKS WERKS, MSKU.CHARG CHARG, MSKU.KUNNR KUNNR, MSKU.KULAB KULAB, XREF.CFN CFN, KNA1.PSTLZ PSTLZ from MSKU join XREF on XREF.MATNR = MSKU.MATNR join KNA1 on KNA1.ID = MSKU.KUNNR partition by MSKU.MATNR; 
 
 
 GEOHASH(ZIPCODE.GEO_POINT, 1) GEOHASH_1,
    GEOHASH(ZIPCODE.GEO_POINT, 2) GEOHASH_2,
    GEOHASH(ZIPCODE.GEO_POINT, 3) GEOHASH_3,
    GEOHASH(ZIPCODE.GEO_POINT, 4) GEOHASH_4,
    GEOHASH(ZIPCODE.GEO_POINT, 8) GEOHASH_8,
    GEOHASH(ZIPCODE.GEO_POINT, 12) GEOHASH_12













create table MARA with (KAFKA_TOPIC='mysql.inventory.MARA', VALUE_FORMAT='avro', KEY='MATNR');

create table MAKT with (KAFKA_TOPIC='mysql.inventory.MAKT', VALUE_FORMAT='avro');

create stream AUSP with (KAFKA_TOPIC='mysql.inventory.AUSP', VALUE_FORMAT='avro');

create table XREF with (KAFKA_TOPIC='m', VALUE_FORMAT='avro') as
select OBJEK as MATNR, latest_by_offset(ATWRT) as CFN 
  from AUSP  
 where KLART='001' 
   and ATINN=1 
   and ADZHL=0 
   and ATWRT not like 'Z_%' and ATWRT not like 'N/A' 
   group by OBJEK; 



create table XREF with (KAFKA_TOPIC='xref', VALUE_FORMAT='avro') as
select OBJEK as MATNR, latest_by_offset(ATWRT) as CFN 
  from AUSP  
 where KLART='001' 
   and ATINN=1 
   and ADZHL=0 
   and ATWRT not like 'Z_%' and ATWRT not like 'N/A' 
   group by OBJEK; 

   
create stream MSKU 
  with (KAFKA_TOPIC='mysql.inventory.MSKU', VALUE_FORMAT='avro');

create stream MSKU_ENRICHED
  with (KAFKA_TOPIC='MSKU_ENRICHED') 
    as 
select 
    MSKU.MATNR MATNR, 
    MSKU.WERKS WERKS, 
    MSKU.CHARG CHARG, 
    MSKU.KUNNR KUNNR, 
    MSKU.KULAB KULAB, 
    XREF.CFN CFN, 
    KNA1.PSTLZ PSTLZ, 
    ZIPCODE.ZIPCODE ZIPCODE,
    ZIPCODE.GEO_POINT GEO_POINT,
    GEOHASH(ZIPCODE.GEO_POINT, 1) GEOHASH_1,
    GEOHASH(ZIPCODE.GEO_POINT, 2) GEOHASH_2,
    GEOHASH(ZIPCODE.GEO_POINT, 3) GEOHASH_3,
    GEOHASH(ZIPCODE.GEO_POINT, 4) GEOHASH_4,
    GEOHASH(ZIPCODE.GEO_POINT, 8) GEOHASH_8,
    GEOHASH(ZIPCODE.GEO_POINT, 12) GEOHASH_12
  from MSKU 
  join XREF on XREF.ROWKEY = MSKU.MATNR
  join KNA1 on KNA1.ROWKEY = MSKU.KUNNR
  join ZIPCODE on ZIPCODE.ROWKEY = SUBSTRING(KNA1.PSTLZ, 0, 5)
  partition by MSKU.MATNR;




create table geohash_1
  with (KAFKA_TOPIC='product.geohash_1') 
    as 
select CFN, GEOHASH_1 GEO_POINT, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED4
    group by CFN, GEOHASH_1;

create table geohash_2
  with (KAFKA_TOPIC='product.geohash_2') 
    as 
select CFN, GEOHASH_2 GEO_POINT, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED4
    group by CFN, GEOHASH_2;

create table geohash_4
  with (KAFKA_TOPIC='product.geohash_4') 
    as 
select CFN, GEOHASH_4 GEO_POINT, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED3
    group by CFN, GEOHASH_4;

create table geohash_8
  with (KAFKA_TOPIC='product.geohash_8') 
    as 
select CFN, GEOHASH_8 GEO_POINT, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED4
    group by CFN, GEOHASH_8;

create table geohash_12
  with (KAFKA_TOPIC='product.geohash_12') 
    as 
select CFN, GEOHASH_12 GEO_POINT, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED3
    group by CFN, GEOHASH_12;

create table geohash_12
  with (KAFKA_TOPIC='product.geohash_12') 
    as 
select CFN, GEOHASH_12 GEO_POINT, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED3
    group by CFN, GEOHASH_12;




create table geohash_2a
  with (KAFKA_TOPIC='product.geohash_2a') 
    as 
select CFN, GEOHASH_2 GEO_POINT, summation(keyvalue(cast(MATNR as varchar) + '_' + cast(WERKS as varchar) + '_' + cast(CHARG as varchar), KULAB)) QTY
    from MSKU_ENRICHED4
    group by CFN, GEOHASH_2;

create table geohash_1a
  with (KAFKA_TOPIC='product.geohash_1a') 
    as 
select CFN, GEOHASH_1 GEO_POINT, summation(keyvalue(cast(MATNR as varchar) + '_' + cast(WERKS as varchar) + '_' + cast(CHARG as varchar), KULAB)) QTY
    from MSKU_ENRICHED4
    group by CFN, GEOHASH_1;

create table geohash_4a
  with (KAFKA_TOPIC='product.geohash_4a') 
    as 
select CFN, GEOHASH_4 GEO_POINT, summation(keyvalue(cast(MATNR as varchar) + '_' + cast(WERKS as varchar) + '_' + cast(CHARG as varchar), KULAB)) QTY
    from MSKU_ENRICHED4
    group by CFN, GEOHASH_4;



SET 'auto.offset.reset'='earliest';

select CFN, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED
    group by CFN
    emit changes;


create table geohash_8
  with (KAFKA_TOPIC='product.geohash_8') 
    as 
select CFN, geohash(GEO_POINT, 8) geo_point, summation(keyvalue(cast(MATNR as varchar), KULAB)) QTY
    from MSKU_ENRICHED2
    group by CFN, GEO_POINT;
    

>    emit changes;


















create stream MSKU_KUNNR
  with (KAFKA_TOPIC='MSKU_KUNNR_OUT', VALUE_FORMAT='avro', KEY='KUNNR');

create stream MSKU_ZIPCODE_OUT2 
  with (KAFKA_TOPIC='MSKU_ZIPCODE_OUT2') 
    as 
select MATNR, MSKU_KUNNR.WERKS WERKS, CHARG, MSKU_KUNNR.KUNNR KUNNR, KULAB, CFN, PSTLZ 
  from MSKU_KUNNR
  join KNA1 on KNA1.ROWKEY = MSKU_KUNNR.KUNNR
  partition by SUBSTRING(PSTLZ, 0, 5);



create stream MSKU_ZIP 
  with (KAFKA_TOPIC='MSKU_MATNR') 
    as 
select MSKU.MATNR MATNR, WERKS, CHARG, KUNNR, KULAB, CFN 
  from MSKU 
  join XREF on XREF.ROWKEY = MSKU.MATNR
  partition by MSKU.MATNR;












//KULAB

create table PRODUCT as
select MATNR, ERSDA, LAEDA, VPSTA, PSTAT, MTART, MATKL, BISMT, MEINS
  from MARA
 where MTART = 'ZPRD';
 
create stream AUSP with (KAFKA_TOPIC='mysql.inventory.AUSP', VALUE_FORMAT='avro');

create table xref with (KAFKA_TOPIC='xref', VALUE_FORMAT='avro') as
select OBJEK as MATNR, latest_by_offset(ATWRT) as CFN 
  from AUSP  
 where KLART='001' 
   and ATINN=1 
   and ADZHL=0 
   and ATWRT not like 'Z_%' and ATWRT not like 'N/A' 
   group by OBJEK;  


create table MATERIAL as 
select M.MATNR MATNR, M.ERSDA, M.LAEDA, M.VPSTA, M.PSTAT, M.MTART, M.MATKL, M.BISMT, M.MEINS, X.CFN
  from MARA M
  left join XREF X on X.ROWKEY = M.ROWKEY
 where MTART = 'ZFRT' or MTART = 'ZHWA' or MTART = 'ZUFG';
 

select MATERIAL.CFN CFN, sum(KULAB) QTY
  from MSKU_REKEY 
  join MATERIAL on MSKU_REKEY.MATNR = MATERIAL.ROWKEY
 group by CFN
  emit changes;
  
  select MATERIAL.CFN CFN, summation(keyvalue(MATERIAL.MATNR, KULAB)) QTY
    from MSKU_REKEY 
    join MATERIAL on MSKU_REKEY.MATNR = MATERIAL.ROWKEY
   group by CFN
    emit changes;


select MATERIAL.CFN CFN, summation(keyvalue(cast(MATERIAL.MATNR as varchar), KULAB)) QTY
    from MSKU_REKEY
    join MATERIAL on MSKU_REKEY.MATNR = MATERIAL.ROWKEY
    group by CFN
    emit changes;

select MATERIAL.CFN CFN, keyvalue(cast(MATERIAL.MATNR as varchar), KULAB) QTY
    from MSKU_REKEY
    join MATERIAL on MSKU_REKEY.MATNR = MATERIAL.ROWKEY
    emit changes;
    
    

 
create table MATERIAL_E
select MATERIAL.*, XREF.CFN 
  from MATERIAL 
  join XREF on XREF.ROWKEY = MATERIAL.ROWKEY
  emit changes;




KULAB










create stream xref_stream with (KAFKA_TOPIC='xref', VALUE_FORMAT='avro');

create stream xref_rekey with (KAFKA_TOPIC='xref_rekey', VALUE_FORMAT='avro') as select * from xref_stream partition by MATNR;





create table xref_rekey_t with (KAFKA_TOPIC='xref_rekey', VALUE_FORMAT='avro');


create stream with (KAFKA_TOPIC='test2', VALUE_FORMAT='avro')
as select * from product_xref5;




create stream t

create table test3 with (KAFKA_TOPIC='test2', VALUE_FORMAT='avro');



create table MATERIAL as 
select MATNR, ERSDA, LAEDA, VPSTA, PSTAT, MTART, MATKL, BISMT, MEINS
  from MARA 
 where MTART = 'ZFRT' or MTART = 'ZHWA' or MTART = 'ZUFG';
 
 

select MATERIAL.*, XREF.CFN 
  from MATERIAL 
  join XREF on XREF.ROWKEY = MATERIAL.ROWKEY
  emit changes;
  



create stream AUSP with (KAFKA_TOPIC='mysql.inventory.AUSP', VALUE_FORMAT='avro');

create table AUSP_T with (KAFKA_TOPIC='mysql.inventory.AUSP', VALUE_FORMAT='avro');
create table MSKU with (KAFKA_TOPIC='mysql.inventory.MSKU', VALUE_FORMAT='avro');
create table MAKT with (KAFKA_TOPIC='mysql.inventory.MAKT', VALUE_FORMAT='avro');



create table xxPRODUCT as
select LAST(ATWRT) as CFN 
  from AUSP 
 where KLART='001' 
   and ATINN=1 
   and ADZHL=0 
   and ATWRT not like 'Z_%' and ATWRT not like 'N/A' 
 group by ATWRT;




select * 
  from MSKU
  join MAKT on MSKU.MATNR = MAKT.MATNR

  
select * 
  from MARA
 where MTART = 'ZPRD';

select * 
  from MARA
 where MTART != 'ZPRD';
 
ZPRD


  
  
select * from AUSP;



select * from AUSP where KLART='001' and ATINN=1 and ADZHL=0 and ATWRT not like 'Z_%'
  and ATWRT not like 'N/A' emit changes;

select OBJEK MATNR, ATWRT CFN from AUSP where KLART='001' and ATINN=1 and ADZHL=0 and ATWRT not like 'Z_%'
>  and ATWRT not like 'N/A' partition by OBJEK emit changes limit 1;
>


create stream AUSP with (KAFKA_TOPIC='mysql.inventory.AUSP', VALUE_FORMAT='avro');