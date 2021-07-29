insert overwrite local directory '/data1/home/zhoufang/save' row format delimited fields terminated by ','
select count(*) as ip_cnt,
  sum(case when user_id_cnt>1 then 1 else 0 end) as user_id_dup,
  sum(case when user_ua_cnt>1 then 1 else 0 end) as user_ua_dup,
  sum(case when (user_id_cnt-user_ua_cnt)>0 then 1 else 0 end) as id_gt_ua,
  sum(case when (user_id_cnt-user_ua_cnt)<0 then 1 else 0 end) as id_lt_ua,
  sum(case when (user_id_cnt-user_ua_cnt)<>0 then 1 else 0 end) as id_ne_ua,
  round(sum(case when user_id_cnt>1 then 1 else 0 end)/count(*),4) as user_id_dup_rate,
  round(sum(case when user_ua_cnt>1 then 1 else 0 end)/count(*),4) as user_ua_dup_rate,
  round(sum(case when (user_id_cnt-user_ua_cnt)>0 then 1 else 0 end)/count(*),4) as id_gt_ua_rate,
  round(sum(case when (user_id_cnt-user_ua_cnt)<0 then 1 else 0 end)/count(*),4) as id_lt_ua_rate,
  round(sum(case when (user_id_cnt-user_ua_cnt)<>0 then 1 else 0 end)/count(*),4) as id_ne_ua_rate
from(
  select user_ip as ip, count(*) as cnt, count(distinct user_id) as user_id_cnt, count(distinct md5(user_ua)) as user_ua_cnt
  from pbs.t_pbs_log
  where pt >= '2019-05-26-00' and pt <= '2019-05-26-23' and log_type='bid'
  group by user_ip
  order by cnt desc) a;
