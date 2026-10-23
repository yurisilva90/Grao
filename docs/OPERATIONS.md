# Operação e recuperação

## Conta e e-mail

Projeto: ljjrrabjujmcgdzrxnhu, organização yurisilva1990, região sa-east-1.
Em Auth → URL Configuration, Site URL e Redirect URLs devem permitir `https://yurisilva90.github.io/Grao/`. Esta configuração depende do painel e não é oferecida pelas ferramentas da sessão. Verificar remetente/SMTP e limites de envio antes de convidar usuários fora da equipe. Não registrar códigos, tokens ou conteúdo de e-mails em issues.

## Migração e backup

Os registros anteriores não são apagados. A importação local tem prévia, fixa as datas relativas uma única vez e usa IDs estáveis para evitar duplicação. Faça a migração no aparelho que contém os anexos.
Na conta/preferências, Exportar dados gera JSON com registros e bytes dos anexos acessíveis. Guarde o backup em local privado. Para recuperar, importe o arquivo, confira a prévia e salve. O teste de navegador cobre exportação e recuperação do anexo em outro contexto. Não há rotina automática de backup externo; recuperação de todo o projeto e PITR dependem do plano/configuração do Supabase e devem ser validados antes de abrir para convidados.

## Sincronização

Cada usuário possui um documento com revisão monotônica. O RPC de gravação verifica a revisão e detecta alterações simultâneas. Em conflito, o app preserva o formulário, bloqueia gravações e oferece exportar/recarregar; não substitui o servidor silenciosamente. Leitura usa cache; alterações na conta exigem conexão. O modo local continua disponível. Ao sair, o cache de registros daquela conta é removido.

## Lembretes

VAPID e segredo do cron ficam somente em grao_private.worker_config, sem permissões de leitura para anon/authenticated. O frontend recebe apenas a chave VAPID pública por função autenticada. O job `grao-reminders-every-minute` chama o worker a cada minuto por pg_net. Verifique cron.job_run_details e os códigos de resposta em net._http_response sem expor cabeçalhos/segredos.

O worker recalcula datas usando o fuso do usuário, ignora itens concluídos/arquivados e registra uma chave de entrega por usuário, tarefa, horário e dispositivo. Subscrições expiradas são removidas. Tentativas com falha podem ser repetidas; Web Push não garante entrega e, em falha após o envio antes da confirmação, pode haver reentrega. A janela de recuperação é de 24 horas. No iPhone, testar PWA instalado, permissão aceita/negada e reagendamento real. Não marcar validação móvel como concluída apenas porque o cron retornou 200.

## Privacidade e exclusão

Documentos, subscrições e arquivos exigem proprietário e sessão ativa. Emoções não aparecem como detalhes na home. A função de exclusão valida JWT e sessão, revoga sessões, remove arquivos e exclui o usuário; documentos e subscrições são removidos por cascata. Não usar chaves administrativas no cliente. Arquivos retirados dos registros são apagados após salvar o documento; se uma remoção falhar, o usuário recebe aviso e o arquivo pode exigir limpeza posterior.

## Versões e incidentes

Frontend: reverter o commit e publicar pelo Actions. Backend: alterações de banco não são revertidas pelo frontend; avaliar compatibilidade antes de reverter. Não executar migrations novamente sobre o projeto existente sem conferir supabase_migrations.schema_migrations. As migrations locais documentam o SQL aplicado via MCP; o timestamp local pode diferir do registrado pelo serviço.
