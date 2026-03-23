# Stamboek Familie Hogenes — Online Deployment

## Stap 1 — Supabase database aanmaken

1. Ga naar [supabase.com](https://supabase.com) → maak een gratis account
2. Maak een nieuw project aan (kies regio **West Europe**)
3. Ga naar **SQL Editor** en plak de inhoud van `supabase_setup.sql` → klik **Run**
4. Noteer je **Project URL** en **anon/public key** (te vinden bij Settings → API)

---

## Stap 2 — GitHub repo aanmaken

```bash
# In de map met index.html, netlify.toml, etc.:
git init
git add .
git commit -m "Stamboek Hogenes — eerste versie"
git branch -M main
git remote add origin https://github.com/jouwnaam/stamboek-hogenes.git
git push -u origin main
```

---

## Stap 3 — Netlify koppelen

1. Ga naar [netlify.com](https://netlify.com) → **Add new site → Import from Git**
2. Kies GitHub → selecteer je repo
3. Build settings:
   - **Build command:** `node inject_config.js`
   - **Publish directory:** `.`
4. Ga naar **Site settings → Environment variables** → voeg toe:

| Key                | Value                                  |
|--------------------|----------------------------------------|
| `SUPABASE_URL`     | `https://jouwproject.supabase.co`      |
| `SUPABASE_ANON_KEY`| `jouw-anon-key`                        |
| `EDIT_PIN`         | `kies-een-pincode`                     |

5. Klik **Deploy site** → klaar! 🎉

---

## Nieuwe versie deployen

```bash
git add .
git commit -m "Nieuwe portretfoto's toegevoegd"
git push
```
Netlify detecteert de push en deployt automatisch binnen ~30 seconden.

---

## Foto's beheren op de live site

1. Open de site
2. Klik **🔒 Beheren** (rechtsboven in de tabbalk)
3. Voer je pincode in
4. Klik op het ✎ icoon bij een foto, of **＋ Foto** als er nog geen is
5. Upload, bijsnijden, opslaan — wijzigingen zijn direct zichtbaar voor iedereen

---

## Lokaal testen (zonder Supabase)

Open `index.html` direct in de browser (dubbelklik).  
Foto-aanpassingen worden dan opgeslagen in `localStorage` van de browser.  
Je ziet een melding bovenin de pagina dat Supabase niet geconfigureerd is.

---

## Gratis limieten

| Service  | Gratis limiet                        | Gebruik stamboek |
|----------|--------------------------------------|------------------|
| Netlify  | 100 GB bandbreedte/mnd               | ~50 MB/mnd       |
| Supabase | 500 MB database, 5 GB storage        | < 10 MB          |

Beide zijn royaal voldoende voor een familiesite.
