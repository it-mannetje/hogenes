-- ═══════════════════════════════════════════════════
--  Stamboek Hogenes — Supabase Setup
--  Run this ONCE in: Supabase dashboard → SQL Editor
-- ═══════════════════════════════════════════════════

-- 1. Photo overrides table (custom/removed portraits)
create table if not exists photo_overrides (
  person_id   text primary key,
  data        text not null
);

alter table photo_overrides enable row level security;

create policy "Public read"
  on photo_overrides for select using (true);

create policy "Anon write"
  on photo_overrides for all using (true) with check (true);


-- 2. Custom people table (newly added family members)
create table if not exists custom_people (
  person_id   text primary key,
  data        text not null
);

alter table custom_people enable row level security;

create policy "Public read custom_people"
  on custom_people for select using (true);

create policy "Anon write custom_people"
  on custom_people for all using (true) with check (true);

-- ═══════════════════════════════════════════════════
-- Done! Both tables are ready.
-- ═══════════════════════════════════════════════════


-- 3. Person edits table (overrides for existing family member details)
create table if not exists person_edits (
  person_id   text primary key,
  data        text not null
);

alter table person_edits enable row level security;

create policy "Public read person_edits"
  on person_edits for select using (true);

create policy "Anon write person_edits"
  on person_edits for all using (true) with check (true);
