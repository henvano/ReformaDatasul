# Reforma Datasul — Cloudflare

MVP do Radar de Reforma Tributária migrado para Cloudflare e redesenhado para uso simples por TI e áreas de negócio.

## Arquitetura

- **Cloudflare Workers + Static Assets**: frontend e API em um deploy.
- **D1**: eventos, histórico, snapshots e saúde das fontes.
- **Cron Trigger**: coleta diária às 09:00 UTC (06:00 BRT).
- **Workers AI**: resume/classifica somente quando uma fonte muda.
- **Fallback por regras**: a coleta continua mesmo se a IA falhar.

## Princípios

1. Fonte oficial nunca é confundida com TOTVS ou Debiasi.
2. IA não marca item como implementado ou homologado.
3. Datas ausentes nunca são inventadas.
4. Primeira coleta cria linha de base; só alterações posteriores geram alerta.
5. A interface mostra primeiro a ação necessária e só depois o detalhe técnico.

Leia `DEPLOY.md` antes de publicar.


## URL padrão (Workers.dev)

Este projeto está configurado com `workers_dev: true` e **não exige domínio próprio**.
Após o primeiro deploy, a URL seguirá o padrão:

`https://reforma-datasul.<seu-subdominio-da-conta>.workers.dev`

O subdomínio da conta é definido pela própria conta Cloudflare em **Workers & Pages → Your subdomain**.
Não há `route` ou `custom_domain` configurado no `wrangler.jsonc`; portanto o deploy permanece no endereço padrão `workers.dev`.
