-- ═══════════════════════════════════════════════════════════════
--  Stamboek Hogenes — Auth Setup
--  Run in Supabase dashboard → SQL Editor
-- ═══════════════════════════════════════════════════════════════

-- 1. Whitelist van toegestane beheerder-e-mailadressen
create table if not exists allowed_admins (
  email       text primary key,
  name        text,
  added_at    timestamptz default now()
);

-- Voeg hier de beheerders toe (vervang met echte adressen):
insert into allowed_admins (email, name) values
  ('jouw@emailadres.nl', 'Jouw naam')
  -- voeg meer toe:
  -- ,('tweede@beheerder.nl', 'Tweede naam')
on conflict do nothing;

-- 2. Zet RLS aan voor allowed_admins
alter table allowed_admins enable row level security;

-- Alleen ingelogde gebruikers mogen hun eigen e-mail checken
create policy "Check own email"
  on allowed_admins for select
  using (auth.email() = email);

-- 3. UPDATE: schrijfrechten op photo_overrides vereisen nu inloggen
drop policy if exists "Anon write" on photo_overrides;
create policy "Auth write photo_overrides"
  on photo_overrides for all
  using (
    exists (select 1 from allowed_admins where email = auth.email())
  )
  with check (
    exists (select 1 from allowed_admins where email = auth.email())
  );

-- 4. Zelfde voor custom_people
drop policy if exists "Anon write custom_people" on custom_people;
create policy "Auth write custom_people"
  on custom_people for all
  using (
    exists (select 1 from allowed_admins where email = auth.email())
  )
  with check (
    exists (select 1 from allowed_admins where email = auth.email())
  );

-- 5. Zelfde voor person_edits
drop policy if exists "Anon write person_edits" on person_edits;
create policy "Auth write person_edits"
  on person_edits for all
  using (
    exists (select 1 from allowed_admins where email = auth.email())
  )
  with check (
    exists (select 1 from allowed_admins where email = auth.email())
  );

-- Lees-policies blijven publiek (iedereen kan het stamboek bekijken)
-- ═══════════════════════════════════════════════════════════════
-- Klaar! Stel daarna in Supabase in:
--   Authentication → Providers → Email → "Enable Email provider" ✓
--   Authentication → Email Templates → pas de tekst aan (optioneel)
--   Authentication → URL Configuration → Site URL = jouw Netlify URL
-- ═══════════════════════════════════════════════════════════════
