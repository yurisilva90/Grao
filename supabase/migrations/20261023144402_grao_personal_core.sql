create table public.grao_documents (
 user_id uuid primary key references auth.users(id) on delete cascade,
 payload jsonb not null check (jsonb_typeof(payload)='object' and payload->>'schema'='3'),
 revision bigint not null default 1,
 updated_at timestamptz not null default now()
);
alter table public.grao_documents enable row level security;
create policy owner_select on public.grao_documents for select to authenticated using ((select auth.uid())=user_id);
create policy owner_insert on public.grao_documents for insert to authenticated with check ((select auth.uid())=user_id);
create policy owner_update on public.grao_documents for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create policy owner_delete on public.grao_documents for delete to authenticated using ((select auth.uid())=user_id);
revoke all on public.grao_documents from anon;
grant select,insert,update,delete on public.grao_documents to authenticated;
create or replace function public.grao_save_document(document jsonb, expected_revision bigint)
returns bigint language plpgsql security invoker set search_path='' as $$
declare result bigint; begin
 if auth.uid() is null then raise exception 'Authentication required'; end if;
 if expected_revision=0 then
  insert into public.grao_documents(user_id,payload,revision) values(auth.uid(),document,1)
  on conflict(user_id) do nothing returning revision into result;
 else
  update public.grao_documents set payload=document,revision=revision+1,updated_at=now()
  where user_id=auth.uid() and revision=expected_revision returning revision into result;
 end if;
 if result is null then raise exception 'REVISION_CONFLICT' using errcode='40001'; end if;
 return result;
end $$;
revoke all on function public.grao_save_document(jsonb,bigint) from public,anon;
grant execute on function public.grao_save_document(jsonb,bigint) to authenticated;
insert into storage.buckets(id,name,public,file_size_limit) values('grao-files','grao-files',false,5242880);
create policy grao_file_select on storage.objects for select to authenticated using(bucket_id='grao-files' and (storage.foldername(name))[1]=(select auth.uid())::text);
create policy grao_file_insert on storage.objects for insert to authenticated with check(bucket_id='grao-files' and (storage.foldername(name))[1]=(select auth.uid())::text);
create policy grao_file_update on storage.objects for update to authenticated using(bucket_id='grao-files' and (storage.foldername(name))[1]=(select auth.uid())::text) with check(bucket_id='grao-files' and (storage.foldername(name))[1]=(select auth.uid())::text);
create policy grao_file_delete on storage.objects for delete to authenticated using(bucket_id='grao-files' and (storage.foldername(name))[1]=(select auth.uid())::text);
create table public.grao_push_subscriptions(user_id uuid not null references auth.users(id) on delete cascade,endpoint text not null,subscription jsonb not null,primary key(user_id,endpoint));
alter table public.grao_push_subscriptions enable row level security;
create policy push_owner on public.grao_push_subscriptions for all to authenticated using((select auth.uid())=user_id) with check((select auth.uid())=user_id);
grant select,insert,update,delete on public.grao_push_subscriptions to authenticated;
revoke all on public.grao_push_subscriptions from anon;
create table public.grao_push_deliveries(delivery_key text primary key,user_id uuid not null references auth.users(id) on delete cascade,created_at timestamptz not null default now(),status text not null default 'pending');
alter table public.grao_push_deliveries enable row level security;
revoke all on public.grao_push_deliveries from public,anon,authenticated;
create index grao_push_deliveries_user on public.grao_push_deliveries(user_id);
