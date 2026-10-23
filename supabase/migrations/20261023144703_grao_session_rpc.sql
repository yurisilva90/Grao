create function public.grao_live_session() returns boolean language sql stable security invoker set search_path='' as $$select grao_private.active_session()$$;
revoke all on function public.grao_live_session() from public,anon;
grant execute on function public.grao_live_session() to authenticated;
