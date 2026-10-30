-- Run in your NEW Record Room Supabase project SQL editor.
-- Create your owner user in Authentication > Users, then paste that user UUID below.
create table if not exists public.owner_state (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);
alter table public.owner_state enable row level security;
revoke all on public.owner_state from anon;
grant select,insert,update on public.owner_state to authenticated;
-- IMPORTANT: Replace the placeholder UUID with your actual Supabase Auth user ID.
-- The owner ID restriction ensures other signed-in accounts cannot write.
create policy "owner only select" on public.owner_state for select to authenticated
using (auth.uid() = user_id AND auth.uid() = '722c8ba8-e597-4aa2-84b3-336b5e33586d'::uuid);
create policy "owner only insert" on public.owner_state for insert to authenticated
with check (auth.uid() = user_id AND auth.uid() = '722c8ba8-e597-4aa2-84b3-336b5e33586d'::uuid);
create policy "owner only update" on public.owner_state for update to authenticated
using (auth.uid() = user_id AND auth.uid() = '722c8ba8-e597-4aa2-84b3-336b5e33586d'::uuid)
with check (auth.uid() = user_id AND auth.uid() = '722c8ba8-e597-4aa2-84b3-336b5e33586d'::uuid);
