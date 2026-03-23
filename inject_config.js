// Netlify build plugin: inject Supabase config into index.html
// This runs during `netlify build` and replaces placeholders.
//
// Set these in Netlify: Site settings → Environment variables:
//   SUPABASE_URL      = https://your-project.supabase.co
//   SUPABASE_ANON_KEY = your-anon-key
//   EDIT_PIN          = your-secret-pin  (default: 1234)

const fs   = require('fs');
const path = require('path');

const file = path.join(__dirname, 'index.html');
let   html = fs.readFileSync(file, 'utf8');

const url  = process.env.SUPABASE_URL      || '';
const key  = process.env.SUPABASE_ANON_KEY || '';
const pin  = process.env.EDIT_PIN          || '1234';

const inject = `
<script>
  const _SUPABASE_URL      = ${JSON.stringify(url)};
  const _SUPABASE_ANON_KEY = ${JSON.stringify(key)};
  const _EDIT_PIN          = ${JSON.stringify(pin)};
</script>`;

html = html.replace('<script src="https://cdn.jsdelivr.net/npm/@supabase', inject + '\n<script src="https://cdn.jsdelivr.net/npm/@supabase');

fs.writeFileSync(file, html);
console.log('✓ Config injected (URL configured:', !!url, ')');
