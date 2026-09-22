# Migração segura do Netlify para Cloudflare

Não apague nem desative o `reforma-datasul.netlify.app` antes de validar a nova versão.

## O que será preservado

O script `scripts/migrate-netlify.mjs` copia para o D1:

- eventos já registrados;
- status e responsáveis;
- notas internas;
- registros da Debiasi;
- saúde conhecida das fontes;
- informação da última coleta.

Os snapshots brutos das páginas não estão expostos pela API antiga do Netlify. Portanto, a primeira coleta no Cloudflare recria uma nova linha de base. Isso é intencional: ela não gera alertas falsos com conteúdo já existente.

## Processo

1. Publique a versão Cloudflare e crie o D1.
2. Configure `COLLECTOR_TOKEN` nos dois comandos abaixo com um valor forte:

```bash
npx wrangler secret put COLLECTOR_TOKEN
```

3. Execute a migração:

```bash
COLLECTOR_TOKEN="SEU_TOKEN" node scripts/migrate-netlify.mjs \
  https://reforma-datasul.netlify.app \
  https://SEU-WORKER.workers.dev
```

4. Abra o Cloudflare e confira eventos, responsáveis e notas.
5. Aguarde/execute a primeira coleta Cloudflare para criar snapshots.
6. Só depois desative o agendamento do Netlify, evitando coleta duplicada.
7. Configure Cloudflare Access antes de uso corporativo com edição.
