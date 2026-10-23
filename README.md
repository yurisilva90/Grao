# Grão

Gestão pessoal visual, com rotinas, checklists, finanças e áreas da vida.

- Aplicativo: https://yurisilva90.github.io/Grao/
- Primeira versão preservada: https://yurisilva90.github.io/Grao/primeira-versao/
- [Roteiro](docs/ROADMAP.md) · [Estado real e pendências](docs/STATUS.md) · [Operação e recuperação](docs/OPERATIONS.md)
- [Entregas no GitHub](https://github.com/yurisilva90/Grao/issues)

## Desenvolvimento

Node 22+. `npm ci`, `npm run check`, `npm test`, `npm run build`.
O site publicável é **dist/**. Sirva esse diretório por HTTP, por exemplo `python -m http.server 8124 --directory dist`.
`npm run test:browser` executa os fluxos móveis em Chromium instalado em `/usr/bin/chromium`; ajuste o executablePath em outro ambiente.
A publicação no Pages executa testes, gera o bundle com dependências fixadas e publica apenas os arquivos públicos. O site não publica migrations, testes ou código das funções.

## Arquitetura

Frontend ES modules em src/, com regras puras em domain.js. Dados locais na chave grao-v3:local; anexos locais em IndexedDB. Conta usa Supabase Auth, documento privado versionado, bucket privado e funções de conta/lembretes. A chave publicável do frontend não concede acesso aos dados: RLS exige usuário e sessão válidos. Nenhuma chave administrativa ou VAPID privada é versionada.

## Publicação de backend

O projeto Supabase de Grão é exclusivo, região São Paulo. SQL versionado em supabase/migrations e testes de isolamento em supabase/tests/isolation.sql. As funções de produção são grao-account e grao-reminders; ambas fazem autenticação explícita no corpo. O worker aceita apenas o segredo do agendador. Consulte OPERATIONS.md antes de restaurar ou configurar outro projeto.
