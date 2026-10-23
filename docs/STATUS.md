# Estado da implementação — 23/10/2026

## Implementado

- Edição, exclusão confirmada, arquivamento e ordenação de checklists/demandas; subtarefas editáveis, busca e filtros.
- Datas absolutas e migração assistida dos registros antigos, com IDs estáveis e sem apagar a origem.
- Rotinas diárias, semanais e em dias selecionados; conclusão por ocorrência; histórico real e revisão semanal.
- Finanças manuais em centavos: entradas, despesas, pagamentos vinculados sem duplicação, parcelas, repetição mensal finita, orçamento, reserva e CSV.
- Registros de saúde com minutos/distância e meta semanal; família/casa e projetos; planos de leitura por checklist, referências/reflexões; humor, gratidão e estresse com detalhes privados.
- Preferências de áreas, fuso, exportação/restauração de registros e bytes dos anexos.
- Tela de login/cadastro/recuperação por e-mail e senha, sessão persistente, animação inicial e bloqueio de todas as telas antes do login; cliente de conta, sincronização com detecção de conflitos, cache de leitura e arquivos privados.
- Supabase exclusivo em São Paulo, banco/RLS, revogação de sessão aplicada ao acesso, funções de conta/exclusão e worker de push com cron ativo.
- Workflow publica somente dist, após checks/testes/build; fonte e dependências fixadas no repositório.

Perfil simplificado: nome, áreas e notificações; sem campo de fuso nem importação de arquivos. Anexos continuam nos registros.

## Verificado automaticamente

- 20 testes de regras: dinheiro, parcelas, datas, rotina, migração, idempotência e agendamento por fuso.
- 15 fluxos de navegador em viewport móvel: criação/edição, finanças, migração, privacidade das emoções e backup/restauração de anexos em outro contexto.
- Teste transacional de banco: isolamento entre duas identidades, conflito de revisão e negação após revogar sessão.
- Assessor de segurança Supabase sem alertas; cron com HTTP 200.
- Dependências de produção sem vulnerabilidades conhecidas no npm audit.

## Em validação / dependências reais

- Configurar Site URL e Redirect URLs do Auth no painel Supabase para https://yurisilva90.github.io/Grao/; solicitação enviada ao proprietário.
- Conta do proprietário criada pelo cadastro padrão; aguardando confirmação por e-mail. Primeiro login real, remetente/SMTP, sincronização em dois aparelhos e fluxo completo de exclusão ainda em validação.
- Os 15 testes de navegador usam respostas controladas do Auth/Storage para validar telas e persistência, sem usar credenciais do proprietário.
- Web Push real no iPhone instalado: autorização, permissão negada, reagendamento e recebimento. Servidor ativo não comprova entrega ao aparelho.
- Uso diário, contraste/legibilidade e interações com teclado/câmera no iPhone real.
- Agendamento automático de backups externos e recuperação integral do projeto não configurados; exportação manual completa está disponível e foi testada.

## Backlog deliberado

- Convidados e métricas de uso sem conteúdo sensível, suporte e observação prolongada de custos/falhas.
- Monetização, preço e assinatura após validação com convidados; não há cobrança ativada.
- Integração bancária, sensores, texto bíblico integral licenciado, colaboração e IA.

Não considerar o marco “pronto para meu dia a dia” encerrado até resolver as validações acima. As issues no GitHub são o ponto de acompanhamento de cada etapa.
