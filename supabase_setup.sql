-- ═══════════════════════════════════════════════════
--  Stamboek Hogenes — Supabase Setup
--  Run this in: Supabase dashboard → SQL Editor
-- ═══════════════════════════════════════════════════

-- 1. Create the photo overrides table
create table if not exists photo_overrides (
  person_id   text primary key,           -- e.g. 'VII.1' or 'VII.1_partner'
  data        text not null,              -- base64 data URL or '__removed__'
  updated_at  timestamptz default now()
);

-- 2. Enable Row Level Security
alter table photo_overrides enable row level security;

-- 3. Allow anyone to READ (public family site)
create policy "Public read"
  on photo_overrides for select
  using (true);

-- 4. Allow INSERT/UPDATE/DELETE with anon key
--    (the EDIT_PIN in the app provides the user-facing security)
create policy "Anon write"
  on photo_overrides for all
  using (true)
  with check (true);

-- 5. Optional: index on updated_at for ordering
create index if not exists photo_overrides_updated_at
  on photo_overrides (updated_at desc);

-- ═══════════════════════════════════════════════════
-- Done! Your table is ready.
-- ═══════════════════════════════════════════════════
