# Listas configuráveis — plano de implementação

Data: 26/10/2026. Estado: implementado em 26/10/2026; validação no celular real em andamento. O texto abaixo preserva o plano de referência. A implementação usa listSchema=1 dentro do documento schema=3, com cópia local pré-migração; alterações de tipo em campos preenchidos são bloqueadas para preservar valores. Google continua com envio para confirmação, sem OAuth/sincronização automática.

## Objetivo e decisões

Permitir organizar assuntos diferentes com listas simples, sem exigir a configuração de uma planilha. Área → lista → item → subitens. Modelos são pontos de partida editáveis, não módulos isolados. A mesma lista pode conter itens comuns e itens com valores; ter um campo monetário não cria lançamento financeiro.

Decisões alinhadas com o proprietário: listas livres; modelos opcionais; até três campos extras visíveis; vínculo financeiro opcional e desligado por padrão; conclusão e pagamento independentes. Demais detalhes deste documento são recomendações para orientar a implementação.

## Nomenclatura e botão +

Recomendação: manter o botão flutuante **+**, com nome acessível **Criar**, abrindo quatro ações:

| Ação | Função | Informações iniciais |
| --- | --- | --- |
| Lista | Organizar vários itens | Nome, área e modelo opcional |
| Item | Adicionar algo a uma lista | Lista, título e campos dessa lista |
| Compromisso | Reservar data e horário na Agenda | Título, data, início e término |
| Lançamento | Registrar diretamente no Financeiro | Descrição, entrada/saída, valor, situação e data |

“Item” substitui “demanda” na interface e atende a tarefa, compra, exercício, leitura ou conta. “Checklist” passa a ser um modelo de lista. “Pagamento” deixa de duplicar opções no menu: é um item com vínculo financeiro ou um lançamento de saída. Lançamento direto continua disponível sem criar uma lista artificial.

Dentro de uma lista, **+ Adicionar item** já seleciona a lista e a área. No botão global, a última lista pode vir sugerida, sempre visível e editável. Sem listas, oferecer criar uma lista no próprio fluxo. Em compromissos e lançamentos não exigir lista.

## Modelos de lista

Todos podem ser renomeados e associados a qualquer área compatível com o uso escolhido. O modelo sugere campos; não produz dados fictícios nem configura integrações automaticamente.

| Modelo | Uso | Campos sugeridos | Comportamento |
| --- | --- | --- | --- |
| Em branco | Qualquer organização | Nenhum campo extra | Título e check; personalização opcional |
| Checklist | Casa, carro, pendências | Prazo opcional | Progresso por itens concluídos |
| Rotina | Hábitos diários ou semanais | Horário opcional | Conclusão por ocorrência; histórico preservado |
| Treino | Exercícios da academia | Séries/repetições em texto, carga em número, link de vídeo | Baseado em rotina; check por dia previsto |
| Compras | Mercado, aquisições e orçamento | Quantidade, valor total estimado do item, categoria | Total dos valores; sem movimentar saldo por padrão |
| Contas e pagamentos | Contas previstas | Valor, vencimento, categoria | Oferece vínculo financeiro; exige ativação explícita |
| Projeto | Trabalho e negócio | Prazo, prioridade, seleção de etapa | Visão simples de entregas e subitens |
| Estudos e leituras | Bíblia, cursos e livros | Referência, link, prazo opcional | Check e notas; pode ser checklist ou rotina |

Primeira entrega funcional: Em branco, Checklist, Rotina e Contas e pagamentos. Os demais entram em seguida como combinações dos mesmos recursos, evitando criar mecanismos separados para cada modelo.

## Configurações da lista

- Nome, área, descrição opcional, modelo e ordem de exibição.
- Funcionamento: lista geral ou rotina. Rotina define frequência, dias da semana e período de validade; mantém conclusões por data.
- Campos: adicionar, renomear, ordenar, mostrar/recolher e configurar as opções de seleção.
- Até três campos extras visíveis na linha; outros detalhes ficam no item expandido. Na primeira versão, limitar a três definições extras por lista, evitando acúmulo oculto.
- Campos padrão opcionais não se repetem como personalizados: prazo, horário, prioridade, notas e anexos.
- Resumos: concluídos/total e, quando houver valores, soma por campo monetário. Valores em moedas diferentes não serão misturados; primeira versão em reais.
- Arquivar, restaurar e excluir com tratamento dos vínculos e histórico. Arquivar não apaga registros financeiros.

## Campos e informações do item

Campos básicos: título obrigatório, check/status, subitens, notas, links/anexos, prazo e lembrete opcionais. Detalhes não precisam ser preenchidos para criar um item simples.

| Campo extra | Configuração | Exemplo |
| --- | --- | --- |
| Texto curto | Nome e tamanho máximo | Referência bíblica, séries/repetições |
| Número | Nome e unidade opcional | Quantidade, carga em kg |
| Valor em R$ | Nome; soma no resumo | Custo estimado, valor da conta |
| Data | Nome e função explícita | Data informativa ou prazo |
| Seleção única | Nome e opções | Categoria, etapa do projeto |
| Sim/não | Nome | Separado, conferido |
| Link | Nome e URL segura | Vídeo do exercício |

O check de conclusão permanece único. Um campo sim/não não altera o status. Os estados iniciais são Pendente, Em andamento e Concluído; marcar o check conclui, reabrir retorna a Pendente. Em rotinas, esse estado pertence à ocorrência, não ao item permanente. O modelo Projeto usa o status padrão para a etapa simples; a seleção extra serve apenas se houver outra classificação necessária.

Não oferecer editor de fórmulas. No modelo Compras, o valor inicial é o total estimado do item: a quantidade não multiplica o preço silenciosamente. Cálculo de quantidade × preço unitário pode entrar depois como comportamento pronto e explicitamente identificado.

## O que aparece no celular

Um card por lista: título, área discreta, progresso leve e total monetário quando aplicável. Ao expandir, linhas com check, título e no máximo três indicadores curtos. Campos longos, vídeo, notas e anexos ficam na expansão/edição do item. Não introduzir uma tabela com rolagem horizontal.

A criação começa pelo necessário. Escolher modelo preenche as sugestões; a pessoa pode salvar sem abrir a personalização. Na tela de configurar campos, uma prévia mostra uma linha da lista antes de salvar.

Vídeo inicialmente por link, aberto pelo usuário; não há reprodução automática nem hospedagem/transcodificação de vídeo. Anexos seguem os limites e a privacidade já existentes.

## Financeiro opcional

Um valor não muda o financeiro por conta própria. Em cada item com valor existe **Contabilizar no financeiro**, desligado por padrão, inclusive ao criar listas pelos novos modelos.

Ao ativar, escolher qual campo de valor alimenta o lançamento, entrada/saída, conta, categoria, vencimento e situação. Data efetiva é obrigatória quando pago/recebido. É necessário valor positivo. Se houver mais de um campo monetário, o usuário escolhe um; não somar campos automaticamente para o lançamento.

| Situação | Efeito |
| --- | --- |
| Valor sem vínculo | Soma apenas no resumo da lista |
| Vínculo ativo e previsto | Um lançamento a pagar/a receber; não altera saldo realizado |
| Vínculo ativo e pago/recebido | Afeta o saldo pela data efetiva |
| Check concluído, mas previsto | Continua previsto; concluir não significa pagar |
| Pago, mas check pendente | Pagamento permanece efetivado; ação pode continuar pendente |
| Editar valor, título, conta ou datas | Atualiza o mesmo lançamento |
| Editar pelo Financeiro | Atualiza os campos correspondentes do item vinculado |
| Arquivar lista/item | Mantém o lançamento e o histórico financeiro |

Desativar o vínculo: apresentar o lançamento existente e duas ações explícitas — **Desvincular e manter lançamento** ou **Desvincular e excluir lançamento**. A recomendação inicial é manter, principalmente se já efetivado. Não recriar o lançamento desvinculado sem nova ativação consciente.

Excluir um item/lista: indicar quantos lançamentos estão ligados; preservar por padrão como registros independentes, ou excluir apenas por escolha explícita. Cancelar mantém tudo. Não deixar referências quebradas.

Uma edição no Financeiro nunca transforma o check de conclusão. Mudanças de área e de modelo não removem lançamentos. Um pagamento vinculado aparece uma única vez na Agenda e no Financeiro.

## Datas, Agenda e lembretes

- Data informativa: não cria evento na Agenda.
- Prazo: aparece como pendência no dia correspondente.
- Compromisso: continua como entidade da Agenda com início/término e opção de envio ao Google.
- Lançamento financeiro: usa vencimento e situação; vínculo com item evita duplicar a ocorrência na Agenda.
- Rotina: mantém ocorrências previstas; concluir um dia não conclui os próximos.
- Lembrete: usar o agendador existente; não anunciar alertas para um novo tipo até a integração ter sido verificada.
- Google: preservar o envio preenchido para confirmação já entregue. OAuth e sincronização automática são uma frente separada e não serão apresentados como prontos nesta entrega.

## Estrutura técnica e compatibilidade

Preservar IDs, áreas, contas e dados reais. A implementação atual usa lists/tasks/entries/appointments num documento privado com revisão; os nomes internos podem continuar para evitar uma reescrita desnecessária.

- Lista recebe template e definições de campo com ID estável, tipo, nome, opções e ordem.
- Item recebe valores personalizados indexados pelo ID do campo. Renomear/ordenar não perde valores.
- O financeiro passa a ter vínculo explícito, separado do status de conclusão. Manter uma fonte de verdade para os campos monetários e uma rotina de atualização compartilhada pelos dois editores.
- Armazenar dinheiro em centavos; não usar ponto flutuante para os totais.
- Referência estável do item no lançamento, garantindo no máximo um vínculo ativo por item.
- Mudança de tipo de campo mostra prévia de conversão; conversões incompatíveis não apagam dados. Remover campo preenchido requer escolha explícita e não remove lançamento financeiro.
- Trocar rotina por lista geral não apaga conclusões históricas; mostrar o efeito antes da alteração e permitir cancelar.
- Versionar o documento para a evolução; leitores devem aceitar a versão anterior. Exportar backup e migrar de forma idempotente antes de gravar a nova versão; documentos de versões futuras desconhecidas devem ser recusados, não rebaixados.
- Migração dos pagamentos antigos mantém o lançamento, seu identificador e a situação existentes. O novo padrão desligado só vale para novos itens; nenhuma conta existente desaparece. A conclusão atual dos pagamentos antigos é preservada como estado inicial e fica independente nas edições seguintes.
- Importar/exportar campos, valores e vínculos; testar recuperação após falha de gravação e conflito de outro dispositivo. Escritas usam a revisão otimista já existente.
- Revisar worker de lembretes, Agenda e resumos para ler tanto registros migrados quanto os novos; novas rotinas de campos não podem contornar RLS nem permitir acesso a outra conta.

## Etapas de entrega e aceite

1. **Contrato e prévia de UX.** Montar prévia interativa com Lista/Item no botão +, escolha do modelo, configuração de três campos, item expandido e vínculo financeiro. Cenários de exemplo: treino, compras sem vínculo e conta com vínculo. Dados da prévia separados da conta real. Aceite: pessoa entende onde criar e consegue ver o efeito de ativar o financeiro.
2. **Base e migração.** Versionamento, campos e valores, compatibilidade de backups, atualização de vínculos antigos e independência entre conclusão/pagamento. Aceite: executar migração duas vezes não duplica nem altera saldos, datas ou histórico; falhas não substituem o documento original.
3. **Listas e itens funcionais.** CRUD, personalização limitada, Em branco/Checklist/Rotina/Contas e pagamentos, novos nomes e botão +. Aceite: criar, editar e reabrir no celular preserva valores, tipos e campos; linhas não exigem rolagem horizontal.
4. **Financeiro e Agenda.** Vínculo opcional bidirecional, ativação/desativação, exclusão explícita, totalização e datas com função definida. Aceite: lista de compras não altera saldo; item pago e concluído são independentes; nenhum lançamento/ocorrência duplicado; edições em qualquer entrada atualizam o mesmo registro.
5. **Modelos complementares e validação.** Treino, Compras, Projeto e Estudos; validar contas distintas, recuperação, rotinas por data, iPhone, arquivos, estados vazios e acessibilidade. Aceite: tarefas comuns exigem poucos toques e alterações de campo não apagam conteúdo.

A entrega inicial só fica completa depois da integração das etapas 2–4; trocar os nomes antes de separar conclusão/pagamento pode produzir uma interface enganosa. O STATUS deve registrar cada etapa efetivamente publicada, sem antecipar conclusão.

## Limites desta rodada

Não incluir fórmulas livres, relações genéricas entre listas, automações configuráveis, permissões de equipe, planilhas com dezenas de colunas, múltiplas moedas ou sincronização automática Google. Uma evolução pode ser avaliada a partir do uso, sem tornar esses recursos pré-requisitos para criar listas simples.
