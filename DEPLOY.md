# Deploy no Cloudflare

## 1. Instalar dependências

```bash
npm install
npx wrangler login
```

## 2. Criar o D1

```bash
npx wrangler d1 create reforma-datasul-db
```

O comando retornará um `database_id`. Substitua `COLE_AQUI_O_DATABASE_ID` no `wrangler.jsonc` pelo ID retornado.

## 3. Criar as tabelas

```bash
npx wrangler d1 migrations apply reforma-datasul-db --remote
```

## 4. Publicar

```bash
npx wrangler deploy
```

O `wrangler.jsonc` já contém:

- Static Assets em `public/`
- D1 no binding `DB`
- Workers AI no binding `AI`
- 4 Cron Triggers diários entre 09:00 e 09:45 UTC (06:00–06:45 BRT), com 2 fontes por execução para respeitar com folga o limite de CPU do plano Free

## 5. Segurança recomendada

Antes de liberar uso interno com edição, proteja o hostname com **Cloudflare Access**. O plano gratuito atende equipes com menos de 50 usuários.

Sem autenticação, qualquer pessoa que descubra a URL consegue abrir o dashboard e usar os endpoints de edição. Para uma ferramenta corporativa, não deixe assim em produção.

## Testar coleta manualmente

Para teste técnico, configure um segredo:

```bash
npx wrangler secret put COLLECTOR_TOKEN
```

Depois faça POST para `/api/collect` com header `x-collector-token`.

A rotina automática do Cron não precisa desse token.


## URL padrão (Workers.dev)

Este projeto está configurado com `workers_dev: true` e **não exige domínio próprio**.
Após o primeiro deploy, a URL seguirá o padrão:

`https://reforma-datasul.<seu-subdominio-da-conta>.workers.dev`

O subdomínio da conta é definido pela própria conta Cloudflare em **Workers & Pages → Your subdomain**.
Não há `route` ou `custom_domain` configurado no `wrangler.jsonc`; portanto o deploy permanece no endereço padrão `workers.dev`.
