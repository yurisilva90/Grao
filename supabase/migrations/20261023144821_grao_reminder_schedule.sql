select cron.schedule('grao-reminders-every-minute','* * * * *',$job$
 select net.http_post(url:='https://ljjrrabjujmcgdzrxnhu.supabase.co/functions/v1/grao-reminders',headers:=jsonb_build_object('Content-Type','application/json','x-cron-key',(select config->>'cronSecret' from grao_private.worker_config where id=true)),body:='{}'::jsonb,timeout_milliseconds:=30000);
$job$);
