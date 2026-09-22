const oldUrl = process.argv[2] || 'https://reforma-datasul.netlify.app';
const newUrl = process.argv[3];
const token = process.env.COLLECTOR_TOKEN;
if (!newUrl || !token) {
  console.error('Uso: COLLECTOR_TOKEN="..." node scripts/migrate-netlify.mjs https://reforma-datasul.netlify.app https://SEU-WORKER.workers.dev');
  process.exit(1);
}
const oldRes = await fetch(`${oldUrl.replace(/\/$/,'')}/api/dashboard`);
if (!oldRes.ok) throw new Error(`Netlify respondeu HTTP ${oldRes.status}`);
const backup = await oldRes.json();
const newRes = await fetch(`${newUrl.replace(/\/$/,'')}/api/import`, {
  method: 'POST',
  headers: {'content-type':'application/json','x-collector-token':token},
  body: JSON.stringify(backup)
});
if (!newRes.ok) throw new Error(`Cloudflare respondeu HTTP ${newRes.status}: ${await newRes.text()}`);
console.log(await newRes.json());
console.log('Eventos, status e última coleta importados. Snapshots serão recriados como nova linha de base na primeira coleta Cloudflare.');
