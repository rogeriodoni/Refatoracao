# CORRIGIR ERRO DE RUNTIME VFP9

## TAREFA OBRIGATORIA
O formulario VFP9 apresentou erro de runtime durante teste automatizado.
Voce DEVE corrigir o erro e salvar os arquivos corrigidos usando Write tool.

## ERRO DETECTADO
- Etapa: 06_testForm
- Tentativa: 6/10
- Mensagem: Teste de formulario falhou com exit code 1.

## CONTEXTO DO ERRO

### LOG DA ETAPA (06_testForm):
[2026-11-09 15:12:42] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-09 15:12:42] [INFO] Config FPW: (nao fornecido)
[2026-11-09 15:12:42] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 15:12:42] [INFO] Timeout: 300 segundos
[2026-11-09 15:12:42] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pwjr4byt.prg
[2026-11-09 15:12:42] [INFO] Conteudo do wrapper:
[2026-11-09 15:12:42] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpNFd', 'C:\4c\tasks\task771\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpNFd', 'C:\4c\tasks\task771\logs\06_testForm.log'
QUIT

[2026-11-09 15:12:42] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pwjr4byt.prg
[2026-11-09 15:12:42] [INFO] VFP output esperado em: C:\4c\tasks\task771\vfp_output.txt
[2026-11-09 15:12:42] [INFO] Executando Visual FoxPro 9...
[2026-11-09 15:12:42] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pwjr4byt.prg
[2026-11-09 15:12:42] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pwjr4byt.prg
[2026-11-09 15:12:42] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpNFd
Inicio: 09/11/2026 15:12:42

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 09/11/2026 15:13:54
Duracao: 72 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-09 15:13:54] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-09 15:13:54] [INFO] VFP9 finalizado em 72.1485228 segundos
[2026-11-09 15:13:54] [INFO] Exit Code: 
[2026-11-09 15:13:54] [INFO] 
[2026-11-09 15:13:54] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-09 15:13:54] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_pwjr4byt.prg
[2026-11-09 15:13:54] [INFO] 
[2026-11-09 15:13:54] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-09 15:13:54] [INFO] * Auto-generated wrapper for parameters
[2026-11-09 15:13:54] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 15:13:54] [INFO] * Parameters: 'FormSigOpNFd', 'C:\4c\tasks\task771\logs\06_testForm.log'
[2026-11-09 15:13:54] [INFO] 
[2026-11-09 15:13:55] [INFO] * Anti-dialog protections for unattended execution
[2026-11-09 15:13:55] [INFO] SET SAFETY OFF
[2026-11-09 15:13:55] [INFO] SET RESOURCE OFF
[2026-11-09 15:13:55] [INFO] SET TALK OFF
[2026-11-09 15:13:55] [INFO] SET NOTIFY OFF
[2026-11-09 15:13:55] [INFO] SYS(2335, 0)
[2026-11-09 15:13:55] [INFO] 
[2026-11-09 15:13:55] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpNFd', 'C:\4c\tasks\task771\logs\06_testForm.log'
[2026-11-09 15:13:55] [INFO] QUIT
[2026-11-09 15:13:55] [INFO] 
[2026-11-09 15:13:55] [INFO] === Fim do Wrapper.prg ===
[2026-11-09 15:13:55] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



## ERROS COMUNS E SOLUCOES (Consultar CLAUDE.md)
- "Property PAGE1 is not found" -> Definir .PageCount ANTES de acessar .Page1
- "Property BACKCOLOR is not found" em PageFrame -> Remover BackColor do PageFrame, usar Page1.BackColor
- "RETURN/RETRY not allowed in TRY/CATCH" -> Usar variavel loc_lResultado e RETURN fora do TRY
- "Property ALLOWDELETE is not found" -> Grid VFP9 nao tem AllowDelete/AllowEdit/AllowAddNew
- "Property VISIBLE is not found" em Page -> Pages NAO tem .Visible, apenas PageFrame tem
- "Property ERASEPAGE is not found" -> PageFrame NAO tem ErasePage
- "Unknown member BUTTON1" -> OptionGroup: usar .Buttons(1) ao inves de .Button1
- "Property FONTNAME is not found" em OptionGroup -> OptionGroup NAO tem FontName/FontSize, definir nas Buttons(N)
- "Property FONTNAME is not found" em Grid -> SetAll("FontName",...,"Column") invalido, usar Grid.FontName diretamente
- "Alias XXX is not found" -> Criar cursor ANTES de definir ControlSource
- "Property THIS_CNOMETABELA is not found" -> Usar this_cTabela (nao this_cNomeTabela)
- "Property OBTERTODOS is not found" -> Usar Buscar("") (nao ObterTodos)
- "Property RELEASE is not found" -> Custom/BO NAO tem Release(), usar = .NULL.
- "Function argument value, type, or count is invalid" em FormParaBO -> Se TextBox.Value ja eh numerico, NAO usar VAL()
- "Unknown member PAGE1" apos WITH PageFrame -> Mover config das Pages para FORA do WITH block
- "PAGE1" ou "COLUMN1" apos .Name -> NUNCA usar .Name em Pages ou Columns (rename quebra TODAS as referencias .Page1/.Column1 no resto do codigo)
- BINDEVENT nao funciona -> Metodo deve ser PUBLIC (sem PROTECTED)
- "Incorrect syntax near" em SQL com EscaparSQL/FormatarDataSQL -> Estas funcoes JA INCLUEM aspas. NUNCA adicionar aspas extras: usar campo = " + EscaparSQL(val), NAO campo = '" + EscaparSQL(val) + "'"
- TIMEOUT sem mensagem de erro visivel -> Provavelmente dialog modal de erro travando VFP

## REGRAS OBRIGATORIAS
- Corrigir APENAS o erro indicado, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- NAO alterar nomes de tabelas/colunas do banco (PILAR 2)
- Manter nomenclatura padronizada _4c_ (PILAR 3)
- Strings SQL longas DEVEM ser quebradas com `+;` (continuation) a cada 3-4 campos - NUNCA numa unica linha
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpNFd.prg):
*==============================================================================
* FormSigOpNFd.prg
*
* Form OPERACIONAL "Eventos NFe" - dialogo modal invocado a partir do form
* de movimentacao/nota fiscal (SigMvCab) para registrar na SEFAZ um evento
* sobre uma NFe ja emitida: CANCELAMENTO (pEvento = 'CAN') ou CARTA DE
* CORRECAO (pEvento = 'CAR'). Ver cabecalho de SigOpNFdBO.prg para o fluxo
* completo do legado (atucur/btnSelItens.Click/conscan/Refazer.Click).
*
* PILAR 1 (UX): dialogo modal identico ao legado SIGOPNFD - sem barra de
* titulo com botoes (TitleBar = 0, ControlBox = .F.), nao movivel
* (Movable = .F.), 758x387, com a faixa de cabecalho cinza (cntSombra) no
* topo mostrando o Caption "Eventos NFe".
*
* PILAR 3 (arquitetura): o legado (SIGOPNFD) e um form FLAT do VFP - SEM
* PageFrame, SEM Page1/Page2: cntObservacao, cntBotoes (CommandGroup),
* cntNFe, cntData, cntSeq, GetEvento, Refazer e Verao sao filhos DIRETOS do
* form. Este form migrado segue a mesma estrutura flat (excecao ja
* documentada em CLAUDE.md para o Gate da Fase 3 quando o legado nao tem
* PageFrame - nao inventar Page1/Page2 que o original nao possui;
* precedente: FormSigMvSbn.prg). NAO HA GRID NESTE FORM (layout.json nao
* declara nenhum objeto baseClass=grid) - o "Grid e Botoes CRUD (Page1)" da
* Fase 4 generica nao se aplica aqui; o ramo FLAT da Fase 4 (precedente:
* FormSigOpNch.prg/task770) entrega so os 2 botoes reais do legado
* (cntBotoes = Enviar/Cancelar).
*
* Containers do dump (ordem = ordem de AddObject):
*   cnt_4c_Sombra      <- cntSombra      (Fase 3)
*   cnt_4c_Botoes      <- cntBotoes      (Fase 4 - CommandGroup Enviar/Cancelar)
*   cnt_4c_Observacao  <- cntObservacao  (Fase 5 - descricao do evento)
*   cnt_4c_NFe         <- cntNFe         (Fase 5 - numero da nota, so exibicao)
*   cnt_4c_Data        <- cntData        (Fase 5 - data/hora do evento)
*   cnt_4c_Seq         <- cntSeq         (Fase 6 - sequencia do evento, so exibicao)
*   txt_4c_Evento      <- GetEvento      (Fase 6 - rotulo do evento, so exibicao)
*   chk_4c_Refazer     <- Refazer        (Fase 6 - CheckBox)
*   chk_4c_Verao       <- Verao          (Fase 6 - CheckBox)
*
* Parametros de Init (equivalentes ao legado
* Lparameters pForm1, pForm2, pDId, pEvento):
*   par_oFormPai         - pForm1: form de movimentacao/nota fiscal que abriu
*                          este dialogo (ThisForm.ParentForm no legado)
*   par_oFormPai2        - pForm2: form auxiliar usado pelo fluxo de envio
*                          UniNFe (ThisForm.ParentForm2.esperaarq no legado -
*                          consumido a partir da fase que portar conscan)
*   par_nDataSessionPai  - pDId: id da datasession do form pai. O legado faz
*                          "Set DataSession to pDId" para que este dialogo
*                          veja os cursores do pai (crSigmvNfi, crSigCdOpe,
*                          LocalOpe, ...) na MESMA sessao. Nesta arquitetura
*                          o SigOpNFdBO le essas tabelas por SQLEXEC proprio
*                          (ver cabecalho do BO), entao o valor e armazenado
*                          so para fidelidade/diagnostico - nao ha
*                          "SET DATASESSION TO" neste form.
*   par_cEvento          - pEvento: 'CAN' (cancelamento) ou 'CAR' (carta de
*                          correcao)
*
* FASE 3/8 - ESTRUTURA BASE: esqueleto do form (propriedades visuais,
* Init/InicializarForm, BO e o cabecalho). CONCLUIDA.
*
* FASE 4/8 - BOTOES DE ACAO (ramo FLAT, sem grid): cnt_4c_Botoes com os 2
* botoes reais do legado (Enviar = btnSelItens.Click, Cancelar = btnSair.
* Click). CONCLUIDA. BtnCancelarClick() reproduz o legado por completo
* (reabilita o form pai + Release). BtnEnviarClick() reproduz a guarda de
* descricao minima (regra #17 do CLAUDE.md - guard transcrito literalmente)
* e grava o evento via SigOpNFdBO.Salvar() (Inserir() ja implementado na
* Fase 2). O restante do fluxo legado (contexto da nota via SQLEXEC proprio,
* SAT.dll/DarumaFramework.dll, protocolo de arquivos da UniNFe, e-mail,
* Gerarnota) ainda NAO existe em nenhum ponto do projeto - documentado no
* cabecalho de BtnEnviarClick() e no cabecalho de SigOpNFdBO.prg
* ("fases seguintes"), nao e omissao silenciosa (regra fundamental do
* CLAUDE.md).
*
* FASE 5/8 - CAMPOS PRINCIPAIS (ramo FLAT, "Parte 1" dos campos restantes):
* cnt_4c_Observacao (descricao do evento - lbl_4c_LblEve + obj_4c_GetDesc),
* cnt_4c_NFe (numero da nota - lbl_4c_LblEmiss + txt_4c_Nfe, somente
* exibicao, When = .F. no dump) e cnt_4c_Data (data/hora do evento -
* lbl_4c_LblEntregas + txt_4c_Data, editavel, When = .T. no dump, valor
* inicial = DATETIME() como no Init legado - "thisform.cntData.getData.
* Value = ttoc(DATEtime())"). CONCLUIDA. BtnEnviarClick() agora le a
* descricao do CONTROLE real (obj_4c_GetDesc.Value) em vez de ler
* this_cNfedesc direto do BO (o container nao existia nas fases
* anteriores - comentario da Fase 4 ja sinalizava esta pendencia).
*
* FASE 6/8 - CAMPOS RESTANTES (ramo FLAT, "Parte 2" - sem lookups: este
* form nao tem nenhum fwBuscaExt/sigacess no dump, todos os campos sao
* somente exibicao ou digitacao direta). ConfigurarCamposRestantes()
* adiciona os ultimos filhos diretos do form: cnt_4c_Seq (sequencia do
* evento, somente exibicao, When = .F. no dump - igual a cnt_4c_NFe),
* txt_4c_Evento (GetEvento - rotulo do evento, somente exibicao,
* populado a partir de this_cRotuloCancelamento/this_cRotuloCarta
* conforme this_cEvento, igual ao "IF thisform.Evento = 'CAN' ...
* thisform.getEvento.Value = ..." do Init legado), chk_4c_Refazer e
* chk_4c_Verao (CheckBox). CONCLUIDA.
*
* VALIDACAO DOS CAMPOS DIGITAVEIS (a parte "lookups" desta fase): o dump
* NAO tem lookup algum - zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/
* mAddColuna/Acesso*() -, e nenhum campo referencia tabela auxiliar.
* Criar AbrirLookup*/AbrirBusca* aqui seria inventar picker e tabela que o
* original nao consulta (PILAR 1 + regra "NUNCA inventar tabelas de lookup
* que nao existem no original"). O que esta fase entrega no lugar sao os
* dois campos digitaveis do legado - os unicos cujo When devolve .T.:
*
*   ValidarDescricaoEvento() <- ControlSource = "crSigMvNfd.nfedesc" do
*     getDesc. Espelha o texto no BO a cada LostFocus, como o
*     ControlSource fazia continuamente; sem isso qualquer recarga
*     (ChkRefazerClick / AtualizarCursorEvento) reescreveria o EditBox a
*     partir de this_cNfedesc e apagaria o que o usuario digitou.
*
*   ValidarDataEvento() <- restricao de entrada da classe fweditdata
*     (framework.vcx) que o getData legado tinha. O migrado e TextBox
*     comum de valor CARACTERE, entao aceita qualquer texto, e o
*     CTOT(getData.Value) dos tres pontos de consumo do legado devolveria
*     DATETIME vazio em silencio. Aceita campo vazio (NullDisplay = "//"),
*     normaliza o que converte e repoe o ultimo valor valido no que nao
*     converte.
*
* Ambos em "LostFocus", nunca "KeyPress" (regra #47), e o de data com
* guarda de reentrancia (wrapper + Exec), porque MsgAviso e modal.
*
* Tambem adiciona o equivalente ao atucur() legado:
* AtualizarCursorEvento() no Form (chamado no fim de InicializarForm,
* mesma posicao do "thisform.atucur()" no Init legado, e em
* ChkRefazerClick quando o Refazer esta desmarcado ou nao acha evento
* anterior) delega a SigOpNFdBO.AtualizarUltimoEvento()/
* ConsultarUltimoEvento() (metodos novos). Como no legado, atucur NAO
* persiste nada: ele so PREPARA o registro (o "APPEND BLANK + replace" do
* legado mexe apenas no cursor em memoria) e define o modo do BO -
* NovoRegistro no ramo de linha nova, EditarRegistro no ramo de reuso do
* evento 'CAN'. Quem grava e BtnEnviarClick, uma vez, com a descricao
* final - igual ao "replace nfedesc with lcdesc" + Update + Commit do
* Click legado.
*
* Estes metodos tem uma GUARDA explicita contra this_cNfiEmpDopNums
* vazio: a leitura do CONTEXTO da nota (SigMvNfi, via DataSession
* compartilhada no legado) ainda nao existe em nenhuma fase deste BO -
* mesma pendencia ja documentada em BtnEnviarClick() e no cabecalho de
* SigOpNFdBO.prg. Sem a chave da nota, gravar um evento deixaria
* empdopnums/emps/nfis em branco (pior que nao gravar nada) - por isso a
* guarda, e nao e omissao silenciosa: esta documentada nos tres lugares
* (aqui, no BO e em BtnEnviarClick).
*
* Refazer.Click legado (linhas 1759-1782 do dump) e reproduzido em
* ChkRefazerClick(): marcado, consulta o ultimo evento e so cria
* sequencia nova se nao achar nenhum; desmarcado, sempre atualiza (cria
* sequencia nova). Verao nao tem Click no legado - e lido direto no
* fuso horario do evento (linha 1142 do dump); aqui ChkVeraoChange()
* espelha o estado no BO (this_lHorarioVerao/this_cFusoHorario) a cada
* mudanca, para BtnEnviarClick usar o valor atual quando a fase que monta
* o XML do evento for implementada.
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: medido no dump (SECAO 1 -
* ESTRUTURA + grep por "^PROCEDURE"/".Click") que o unico objeto com
* BaseClass commandbutton/commandgroup e cntBotoes (Registro 10,
* ButtonCount = 2), e os UNICOS dois "PROCEDURE *.Click" do arquivo
* inteiro sao btnSelItens.Click (linha 977, 700 linhas) e btnSair.Click
* (linha 1683, 3 linhas) - ja portados na FASE 4/8 (BtnEnviarClick /
* BtnCancelarClick, acima). Nao ha Grupo_Op, nao ha pcEscolha, nao ha
* herranca de frmcadastro/frmrelatorio e nao ha NENHUMA ocorrencia de
* Incluir/Alterar/Visualizar/Excluir/Inserir no dump - o SIGOPNFD e um
* dialogo de UMA acao (Enviar) + Cancelar, nao um cadastro CRUD. Criar
* BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick
* aqui inventaria botoes e fluxo que o legado nunca teve (violaria o
* PILAR 1 e a regra fundamental "nunca inventar funcionalidade").
*
* Re-auditoria dos pares BINDEVENT+handler (ja entregues nas fases
* anteriores), conferida nesta fase:
*   - Buttons(1)/Buttons(2) de cnt_4c_Botoes -> BtnEnviarClick/
*     BtnCancelarClick: ambos PUBLIC (sem PROTECTED - regra #3), ambos
*     com BINDEVENT("Click", ...) chamado DEPOIS do WITH que configura
*     os Buttons (ConfigurarBotoesAcao);
*   - Buttons(2).Cancel = .T. cobre o ESC (equivalente ao btnSair do
*     legado, que tambem e o botao de cancelamento do CommandGroup);
*   - BtnCancelarClick usa THIS.Release() (nao Hide()) - dialogo modal
*     sem valor de retorno para o chamador ler depois de fechado, igual
*     ao "Thisform.Release" do legado;
*   - chk_4c_Refazer/chk_4c_Verao -> ChkRefazerClick/ChkVeraoChange:
*     idem PUBLIC, BINDEVENT apos o WITH (ConfigurarCamposRestantes);
*   - obj_4c_GetDesc/txt_4c_Data -> ValidarDescricaoEvento/
*     ValidarDataEvento: BINDEVENT em "LostFocus" (regra #47), nunca
*     "KeyPress";
*   - properties que os handlers tocam (this_cNfedesc, this_dNfedte,
*     this_nTamMinDescricao, this_cNfis, this_nNfeseq, this_lRefazer,
*     this_lHorarioVerao, this_cFusoHorario) conferidas DECLARADAS em
*     SigOpNFdBO.prg (Fase 1) - nenhuma e dinamica;
*   - this_cMensagemErro conferida em BusinessBase (heranca);
*   - .Picture dos dois botoes (cadastro_salvar_60.jpg,
*     cadastro_sair_60.jpg) e do form (new_background.jpg) conferidos
*     existentes em vbmp\ (regra #25 - .Picture inexistente falha em
*     silencio).
*
* Metodo Load do legado (linha 948 do dump: "&&Do Parametros_Iniciais")
* e comentario puro, sem codigo - nao ha o que portar. Zero outro
* evento no dump (zero Grid, zero KeyPress/Valid alem dos dois ja
* cobertos, zero InteractiveChange alem de Verao) alcanca a tela sem
* ja estar coberto pelas fases anteriores.
*
* FASE 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Entrega os hooks
* canonicos do projeto, cada um com o conteudo REAL que o legado tem, e
* elimina a duplicacao que as fases 6/7 deixaram (o mesmo bloco de
* espelhamento BO -> controles aparecia COPIADO em AtualizarCursorEvento
* e em ChkRefazerClick - CLAUDE.md #44, item 6: fonte unica):
*
*   FormParaBO()  - controles -> BO. Mapeia os QUATRO controles que o
*     legado le de volta (todos os sites do dump): getDesc (linhas 999 e
*     1120), getData (CTOT nas linhas 571, 1220 e 1469), Refazer (linhas
*     1310 e 1519) e Verao (linha 1142). getNfe/getSeq/GetEvento NAO
*     entram: tem "When -> Return .f." no dump, sao somente EXIBICAO e o
*     legado nunca le o valor deles - ler um campo de exibicao de volta
*     sobrescreveria a property com o que o proprio BO acabou de escrever
*     nele (e com BRANCO antes da primeira carga).
*
*   BOParaForm(par_nSequencia) - BO -> controles. E o bloco final do
*     atucur legado (linhas 577-579) e o do ramo "achou evento" do
*     Refazer.Click (linhas 1771-1775), que sao o MESMO bloco com UMA
*     diferenca: a sequencia exibida. No atucur e lnUltSeq (ultimo + 1);
*     no Refazer e crSigMvNfd.nfeseq (a do evento encontrado, SEM o + 1).
*     Dai o parametro - sem ele a consolidacao dos dois perderia essa
*     distincao do legado em silencio.
*
*   CarregarLista() - funil publico de carga (nome canonico do projeto,
*     que o harness de teste chama de FORA da classe, por isso PUBLIC -
*     regra #3/#51): delega a AtualizarCursorEvento(), que e o atucur.
*     NAO ha grade neste form (layout.json nao declara nenhum objeto
*     baseClass=grid), logo nao ha RecordSource/GO TOP/Grid.Refresh a
*     fazer - o equivalente aqui e a consulta do ultimo evento mais o
*     THIS.Refresh() do fim do atucur. Mesmo padrao de funil de
*     FormSigOpNch.CarregarLista() -> CarregarGrade().
*
*   HabilitarCampos(par_lHabilitar) - fonte UNICA do estado Enabled dos
*     controles, derivado do When de cada um no dump: getDesc e getData
*     ("When -> Return .t.") acompanham o parametro; getNfe, getSeq e
*     GetEvento ("When -> Return .f.") ficam SEMPRE desabilitados, em
*     qualquer valor do parametro. PUBLIC porque o harness de teste a
*     chama de fora da classe.
*
*   LimparCampos() - reset do "evento novo": e o "nfedesc with ''" do
*     atucur (linha 572), que no legado zera a COLUNA e, por tabela (o
*     getDesc tinha ControlSource), tambem o que esta na tela. Aqui zera
*     os dois - property e controle. NAO toca o campo de data/hora: o
*     legado tem exatamente essa linha COMENTADA nos dois pontos onde ela
*     caberia ("*!* nfedte with DATETIME()" no atucur, linha 562, e
*     "*!* thisform.cntData.getData.Value = ttoc(DATEtime())" no
*     Refazer.Click, linha 1772) - reinstalar o reset da data seria
*     reativar codigo que o autor do legado desligou.
*
* Alem dos hooks, esta fase fecha DUAS lacunas de comportamento:
*
*   1. btnSelItens.Click termina com "thisform.atucur()  && atualiza
*      cursor" (linha 1676), FORA de qualquer IF e antes do RETURN lOk -
*      depois de gravar, a tela se recarrega. BtnEnviarClick nao fazia
*      isso. O RETURN antecipado da guarda de descricao continua
*      PULANDO o atucur, igual ao "return" nu do legado (linha 1122).
*
*   2. A sequencia exibida no ramo de reuso. A Fase 6 usava
*      this_nNfeseq nos DOIS caminhos; o legado usa lnUltSeq no atucur e
*      nfeseq no Refazer (ver BOParaForm acima).
*
* NAO SE APLICAM a este form, e por que (o prompt desta fase e o
* generico de cadastro CRUD; aqui a lista de botoes vem do dump):
*   - BtnSalvarClick / BtnBuscarClick / BtnEncerrarClick: o SIGOPNFD tem
*     EXATAMENTE DOIS botoes (cntBotoes.Command1 "\<Enviar" =
*     btnSelItens, cntBotoes.Command2 "\<Cancelar" = btnSair) e os
*     UNICOS dois "PROCEDURE *.Click" do dump sao os desses dois - ja
*     portados como BtnEnviarClick/BtnCancelarClick. Nao existe
*     Salvar/Buscar/Encerrar no legado; o botao que GRAVA e o Enviar, e
*     o handler leva o nome da acao dele.
*   - AjustarBotoesPorModo: nao ha MODO neste dialogo (zero pcEscolha,
*     zero frmcadastro, zero Grupo_Op no dump) e nao ha uma unica
*     atribuicao a ".Enabled"/".Visible" de controle em todo o legado -
*     as duas ocorrencias de "Enabled" sao "ParentForm.Enabled = .T."
*     (linhas 907 e 1684), que ja estao em HabilitarFormPai. Os dois
*     botoes ficam sempre habilitados.
*   - AlternarPagina: form FLAT, sem PageFrame (ver PILAR 3 acima).
*
* Herda de: FormBase
*==============================================================================

DEFINE CLASS FormSigOpNFd AS FormBase

    *-- Propriedades visuais (pixel-perfect SCX original - PILAR 1)
    Width       = 758
    Height      = 387
    AutoCenter  = .T.
    Caption     = "Eventos NFe"
    ShowWindow = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Movable     = .F.
    KeyPreview  = .T.
    TitleBar    = 0
    WindowType  = 1
    WindowState = 0
    AlwaysOnTop = .F.
    BorderStyle = 2
    ShowTips    = .T.
    DataSession = 2

    *-- Referencias ao form pai (pForm1/pForm2 do legado) e ao BO
    this_oFormPai        = .NULL.
    this_oFormPai2       = .NULL.
    this_nDataSessionPai = 0
    this_oBusinessObject = .NULL.

    *-- Evento recebido do form pai ('CAN' ou 'CAR' - espelhado no
    *-- SigOpNFdBO.this_cEvento logo apos a criacao do BO)
    this_cEvento = ""

    *-- Ultimo valor VALIDO de cnt_4c_Data.txt_4c_Data (ver
    *-- ValidarDataEvento): o legado usa a classe fweditdata do Framework,
    *-- um TextBox de DATA (Value = {} na classe) que simplesmente NAO
    *-- aceita texto que nao seja data/hora. Na migracao o controle virou
    *-- TextBox comum de valor CARACTERE (o Init legado atribui
    *-- "ttoc(DATEtime())"), perdendo essa restricao - esta property guarda
    *-- o valor a repor quando o usuario digita algo que CTOT() nao
    *-- converte.
    this_cDataEventoAnterior = ""

    *-- Guarda de reentrancia dos handlers de LostFocus que exibem dialogo
    *-- (regra #37/#47 do CLAUDE.md): MsgAviso eh MODAL, tira o foco do
    *-- campo e faz o proprio LostFocus disparar de novo.
    this_lEmValidacao = .F.

    *==========================================================================
    * Init - Armazena os parametros recebidos do form pai antes de DODEFAULT
    * (equivalente ao Lparameters pForm1, pForm2, pDId, pEvento do legado).
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_oFormPai2, par_nDataSessionPai, par_cEvento)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_oFormPai2) = "O"
            THIS.this_oFormPai2 = par_oFormPai2
        ENDIF

        THIS.this_nDataSessionPai = IIF(VARTYPE(par_nDataSessionPai) = "N", par_nDataSessionPai, 0)
        THIS.this_cEvento         = IIF(VARTYPE(par_cEvento) = "C", UPPER(ALLTRIM(par_cEvento)), "")

        loc_lResultado = DODEFAULT()
        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * InicializarForm - Cria o BO, espelha o evento recebido nele e monta o
    * cabecalho, os botoes de acao (Enviar/Cancelar) e todos os campos do
    * dump (cntObservacao/cntNFe/cntData/cntSeq/GetEvento/Refazer/Verao).
    * Por fim, reproduz o atucur() incondicional do Init legado via
    * AtualizarCursorEvento() (guardado contra a ausencia do contexto da
    * nota - ver cabecalho da classe e de SigOpNFdBO.prg).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

            *-- Legado (Init, linha ~907): With ThisForm / .ParentForm.Enabled
            *-- = .T. / EndWith - forca o form pai habilitado mesmo com este
            *-- dialogo modal por cima (WindowType = 1 ja bloqueia a entrada
            *-- nele; o legado faz isso para o caso do pai ter ficado
            *-- desabilitado por algum fluxo anterior).
            THIS.HabilitarFormPai(.T.)

            THIS.this_oBusinessObject = CREATEOBJECT("SigOpNFdBO")
            IF VARTYPE(THIS.this_oBusinessObject) <> "O"
                MsgErro("Erro ao criar SigOpNFdBO. VARTYPE retornou: " + ;
                        VARTYPE(THIS.this_oBusinessObject), "FormSigOpNFd.InicializarForm")
            ELSE
                THIS.this_oBusinessObject.this_cEvento = THIS.this_cEvento

                THIS.ConfigurarCabecalho()
                THIS.ConfigurarBotoesAcao()
                THIS.ConfigurarCamposPrincipais()
                THIS.ConfigurarCamposRestantes()

                *-- Legado (Init, linha 918): thisform.atucur() - roda
                *-- incondicionalmente, depois de getEvento/getData e antes
                *-- da leitura de SigMvCab/LocalOpe (ainda nao portada).
                THIS.AtualizarCursorEvento()

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNFd.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - Faixa cinza do topo (cntSombra do legado), com os
    * dois labels espelhando THIS.Caption (legado: ThisForm.cntSombra.
    * lblSombra.Caption = ThisForm.Caption, idem lblTitulo). Geometria e cores
    * transcritas literalmente do dump (SigOpNFd_form_codigo_fonte.txt,
    * SECAO 2 - PROPRIEDADES DE SIGOPNFD.cntSombra/.lblSombra/.lblTitulo).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt

        THIS.AddObject("cnt_4c_Sombra", "Container")
        loc_oCnt = THIS.cnt_4c_Sombra
        WITH loc_oCnt
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblSombra", "Label")
        WITH loc_oCnt.lbl_4c_LblSombra
            .FontBold      = .T.
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .AutoSize      = .F.
            .Caption       = THIS.Caption
            .Height        = 40
            .Left          = 10
            .Top           = 18
            .Width         = 769
            .ForeColor     = RGB(0, 0, 0)
            .Visible       = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
        WITH loc_oCnt.lbl_4c_LblTitulo
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 18
            .WordWrap    = .T.
            .Alignment   = 0
            .BackStyle   = 0
            .AutoSize    = .F.
            .Caption     = THIS.Caption
            .Height      = 46
            .Left        = 10
            .Top         = 17
            .Width       = 769
            .ForeColor   = RGB(255, 255, 255)
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
            .Visible     = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarBotoesAcao - cntBotoes do legado: CommandGroup com 2 botoes
    * (Command1 "btnSelItens" = "\<Enviar", Command2 "btnSair" = "\<Cancelar").
    *
    * NAO sao os 5 botoes CRUD do padrao frmcadastro - o SIGOPNFD e um
    * dialogo de UMA acao (registrar o evento) + sair, sem Lista/Dados, sem
    * grid (layout.json nao tem nenhum objeto baseClass=grid) e sem modo de
    * edicao. Geometria/cores transcritas literalmente do dump (SECAO 2 -
    * PROPRIEDADES DE SIGOPNFD.cntBotoes).
    *
    * Themes = .F. nos Buttons (canonico p/ CommandGroup - framework_
    * frmcadastro_layout.md) e FontName = "Comic Sans MS" (regra dos botoes
    * de acao do framework legado, igual ao cntSombra/cnt_4c_Saida dos
    * cadastros).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oCmg

        THIS.AddObject("cnt_4c_Botoes", "CommandGroup")
        loc_oCmg = THIS.cnt_4c_Botoes
        WITH loc_oCmg
            .ButtonCount  = 2
            .AutoSize     = .T.
            .BackStyle    = 0
            .BorderStyle  = 0
            .SpecialEffect = 1
            .BorderColor  = RGB(136, 189, 188)
            .Value        = 0
            .Top          = -2
            .Left         = 601
            .Width        = 160
            .Height       = 85
            .Themes       = .F.
            .Visible      = .T.
        ENDWITH

        WITH loc_oCmg.Buttons(1)
            .AutoSize      = .F.
            .Top           = 5
            .Left          = 5
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .WordWrap      = .T.
            .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption       = "\<Enviar"
            .MousePointer  = 15
            .ToolTipText   = "Gravar os Dados Informados"
            .SpecialEffect = 0
            .PicturePosition = 13
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
        ENDWITH

        WITH loc_oCmg.Buttons(2)
            .Top           = 5
            .Left          = 80
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Comic Sans MS"
            .FontSize      = 8
            .WordWrap      = .T.
            .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel        = .T.
            .Caption       = "\<Cancelar"
            .MousePointer  = 15
            .ToolTipText   = "[Esc] Sair Sem Gravar os Dados"
            .SpecialEffect = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes        = .F.
        ENDWITH

        BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnEnviarClick")
        BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *==========================================================================
    * ConfigurarCamposPrincipais - Fase 5/8 (Parte 1 dos campos restantes do
    * dump, filhos DIRETOS do form - ramo FLAT, sem Page1/Page2):
    *
    *   cnt_4c_Observacao <- cntObservacao (lblEve + getDesc - descricao do
    *     evento, ControlSource = "crSigMvNfd.nfedesc" no legado; aqui o
    *     valor eh sincronizado manualmente com SigOpNFdBO.this_cNfedesc em
    *     BtnEnviarClick, ja que este form nao tem FormParaBO/BOParaForm)
    *
    *   cnt_4c_NFe <- cntNFe (lblEmiss + txt_4c_Nfe - numero da nota/nfis;
    *     When do getNfe retorna .F. no dump -> campo NAO recebe foco,
    *     .Enabled = .F. aqui. Valor vem de crsigmvnfi.nfis via atucur() -
    *     ainda nao portado, ver cabecalho de SigOpNFdBO.prg)
    *
    *   cnt_4c_Data <- cntData (lblEntregas + txt_4c_Data - data/hora do
    *     evento; When do getData retorna .T. no dump -> campo RECEBE foco
    *     (editavel, ao contrario de getNfe/getSeq/GetEvento). Valor
    *     inicial = DATETIME(), reproduzindo o Init legado -
    *     "thisform.cntData.getData.Value = ttoc(DATEtime())" - que roda
    *     ANTES do atucur() e nao depende de nenhum cursor)
    *
    * Geometria/cores/CHR() transcritos literalmente do dump (SECAO 2 -
    * PROPRIEDADES DE SIGOPNFD.cntObservacao/.cntNFe/.cntData e filhos).
    *
    * Labels (classe say do legado, sem Width/Alignment declarados -
    * cntObservacao.lblEve/cntNFe.lblEmiss - ou com AutoSize = .T. no dump
    * mas que eh NO-OP em Label criado por AddObject - cntData.lblEntregas):
    * regra #23 do CLAUDE.md - .AutoSize = .F. + .Alignment = 0 + .Width
    * explicita que caiba o texto, dentro da largura do container pai.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposPrincipais()
        LOCAL loc_oCnt

        *-- cntObservacao: descricao do evento (justificativa/correcao)
        THIS.AddObject("cnt_4c_Observacao", "Container")
        loc_oCnt = THIS.cnt_4c_Observacao
        WITH loc_oCnt
            .Top         = 167
            .Left        = 40
            .Width       = 722
            .Height      = 219
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEve", "Label")
        WITH loc_oCnt.lbl_4c_LblEve
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Descri" + CHR(231) + CHR(227) + "o do evento:"
            .Left      = 3
            .Top       = 23
            .Width     = 200
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("obj_4c_GetDesc", "EditBox")
        WITH loc_oCnt.obj_4c_GetDesc
            .Height        = 144
            .Left          = 3
            .Top           = 46
            .Width         = 691
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .Value         = ""
            .Visible       = .T.
        ENDWITH

        *-- cntNFe: numero da nota (crsigmvnfi.nfis) - somente exibicao
        THIS.AddObject("cnt_4c_NFe", "Container")
        loc_oCnt = THIS.cnt_4c_NFe
        WITH loc_oCnt
            .Top         = 119
            .Left        = 45
            .Width       = 86
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEmiss", "Label")
        WITH loc_oCnt.lbl_4c_LblEmiss
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "N" + CHR(250) + "mero Nfe"
            .Left      = 3
            .Top       = 3
            .Width     = 80
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Nfe", "TextBox")
        WITH loc_oCnt.txt_4c_Nfe
            .Height        = 23
            .Left          = 3
            .Top           = 20
            .Width         = 80
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .NullDisplay   = ""
            .Value         = ""
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- cntData: data/hora do evento - editavel, default = DATETIME()
        THIS.AddObject("cnt_4c_Data", "Container")
        loc_oCnt = THIS.cnt_4c_Data
        WITH loc_oCnt
            .Top         = 119
            .Left        = 142
            .Width       = 150
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblEntregas", "Label")
        WITH loc_oCnt.lbl_4c_LblEntregas
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Data/Hora"
            .Left      = 3
            .Top       = 3
            .Width     = 70
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Data", "TextBox")
        WITH loc_oCnt.txt_4c_Data
            .Height        = 23
            .Left          = 3
            .Top           = 20
            .Width         = 138
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .NullDisplay   = "//"
            .Value         = TTOC(DATETIME())
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposRestantes - Fase 6/8 ("Parte 2" dos campos restantes do
    * dump, filhos DIRETOS do form - ramo FLAT):
    *
    *   cnt_4c_Seq <- cntSeq (lblRecepcaos + getSeq - sequencia do evento
    *     (nfeseq), somente exibicao; When do getSeq retorna .F. no dump,
    *     igual a cntNFe.getNfe - .Enabled = .F. aqui. Valor numerico (o
    *     legado atribui lnUltSeq/crsigmvnfd.nfeseq direto, sem STR()))
    *
    *   txt_4c_Evento <- GetEvento (rotulo do evento - CANCELAMENTO ou
    *     CARTA DE CORRECAO; somente exibicao, When = .F. no dump. Valor
    *     populado a partir de SigOpNFdBO.this_cRotuloCancelamento/
    *     this_cRotuloCarta conforme this_cEvento, reproduzindo o
    *     "IF thisform.Evento = 'CAN' / thisform.getEvento.Value =
    *     'CANCELAMENTO' / ELSE / ... = 'CARTA DE CORRECAO'" do Init legado)
    *
    *   chk_4c_Refazer <- Refazer (CheckBox - reusa o ultimo evento gravado
    *     em vez de criar sequencia nova; ver ChkRefazerClick)
    *
    *   chk_4c_Verao <- Verao (CheckBox - fuso horario do dhEvento; sem
    *     Click no legado, e lido direto no fuso - linha 1142 do dump - por
    *     isso aqui so espelha o estado no BO a cada mudanca, via
    *     ChkVeraoChange)
    *
    * Geometria/cores/CHR() transcritos literalmente do dump (SECAO 2 -
    * PROPRIEDADES DE SIGOPNFD.cntSeq/.GetEvento/.Refazer/.Verao e filhos).
    * Refazer/Verao: regra #23 do CLAUDE.md (AutoSize eh NO-OP em CheckBox
    * criado por AddObject) - .AutoSize = .F. + Width/Height explicitos do
    * dump, em vez do AutoSize = .T. que o dump declara.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposRestantes()
        LOCAL loc_oCnt

        *-- cntSeq: sequencia do evento (nfeseq) - somente exibicao
        THIS.AddObject("cnt_4c_Seq", "Container")
        loc_oCnt = THIS.cnt_4c_Seq
        WITH loc_oCnt
            .Top         = 119
            .Left        = 303
            .Width       = 86
            .Height      = 45
            .BackStyle   = 0
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_LblRecepcaos", "Label")
        WITH loc_oCnt.lbl_4c_LblRecepcaos
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .Alignment = 0
            .Caption   = "Sequ" + CHR(234) + "ncia"
            .Height    = 15
            .Left      = 3
            .Top       = 3
            .Width     = 60
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("txt_4c_Seq", "TextBox")
        WITH loc_oCnt.txt_4c_Seq
            .Height        = 23
            .Left          = 3
            .Top           = 20
            .Width         = 80
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .NullDisplay   = ""
            .Value         = 0
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- GetEvento: rotulo do evento - filho direto do form, somente
        *-- exibicao
        THIS.AddObject("txt_4c_Evento", "TextBox")
        WITH THIS.txt_4c_Evento
            .Height        = 23
            .Left          = 48
            .Top           = 87
            .Width         = 265
            .SpecialEffect = 1
            .BorderColor   = RGB(90, 90, 90)
            .NullDisplay   = "//"
            .Value         = ""
            .Enabled       = .F.
            .Visible       = .T.
        ENDWITH

        *-- O rotulo do evento (CANCELAMENTO / CARTA DE CORRECAO) passou a
        *-- ser atribuido em BOParaForm() na Fase 8, junto dos outros tres
        *-- campos de exibicao - fonte unica (CLAUDE.md #44, item 6). Ele e
        *-- funcao PURA de this_cEvento, que nao muda durante a vida do
        *-- dialogo (vem do pEvento do Init e nunca e reescrito), entao
        *-- reatribui-lo em cada recarga e idempotente.

        *-- Refazer: CheckBox - filho direto do form
        THIS.AddObject("chk_4c_Refazer", "CheckBox")
        WITH THIS.chk_4c_Refazer
            .Top         = 89
            .Left        = 358
            .Height      = 15
            .Width       = 62
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .AutoSize    = .F.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = "Refazer"
            .Style       = 0
            .ToolTipText = "Selecione para reimprimir a ultima carta ou refazer o xml do cancelamento"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Value       = 0
            .Visible     = .T.
        ENDWITH

        *-- Verao: CheckBox - filho direto do form
        THIS.AddObject("chk_4c_Verao", "CheckBox")
        WITH THIS.chk_4c_Verao
            .Top         = 89
            .Left        = 439
            .Height      = 15
            .Width       = 113
            .FontBold    = .T.
            .FontName    = "Tahoma"
            .FontSize    = 8
            .AutoSize    = .F.
            .Alignment   = 0
            .BackStyle   = 0
            .Caption     = "Horario de Verao"
            .Style       = 0
            .ToolTipText = "Selecione para reimprimir a ultima carta ou refazer o xml do cancelamento"
            .ForeColor   = RGB(90, 90, 90)
            .BackColor   = RGB(255, 255, 255)
            .Themes      = .F.
            .Value       = 0
            .Visible     = .T.
        ENDWITH

        BINDEVENT(THIS.chk_4c_Refazer, "Click", THIS, "ChkRefazerClick")
        BINDEVENT(THIS.chk_4c_Verao, "InteractiveChange", THIS, "ChkVeraoChange")

        *-- Semente do "ultimo valor valido" do campo de data/hora: o valor
        *-- que ConfigurarCamposPrincipais acabou de por (TTOC(DATETIME()),
        *-- igual ao Init legado) JA eh valido por construcao.
        THIS.this_cDataEventoAnterior = THIS.cnt_4c_Data.txt_4c_Data.Value

        *-- Validacao dos DOIS campos digitaveis do legado (os unicos cujo
        *-- When devolve .T. no dump: cntObservacao.getDesc e
        *-- cntData.getData; getNfe/getSeq/GetEvento tem When -> .F. e
        *-- estao com .Enabled = .F. aqui). Em "LostFocus", nunca em
        *-- "KeyPress" - o equivalente do Valid do legado eh SAIR do campo
        *-- (regra #47 do CLAUDE.md); em KeyPress o dialogo subiria a cada
        *-- tecla digitada.
        *--
        *-- Este form NAO tem lookup algum: nao existe fwBuscaExt/
        *-- fwBuscaSel/fwBuscaInt/sigacess/mAddColuna em nenhum ponto do
        *-- dump legado (conferido por busca nos 6 padroes), e nenhum campo
        *-- referencia tabela auxiliar. Criar AbrirLookup*/AbrirBusca* aqui
        *-- seria inventar picker e tabela que o original nao consulta -
        *-- proibido pelo PILAR 1 e pela regra "NUNCA inventar tabelas de
        *-- lookup que nao existem no original".
        BINDEVENT(THIS.cnt_4c_Observacao.obj_4c_GetDesc, "LostFocus", THIS, "ValidarDescricaoEvento")
        BINDEVENT(THIS.cnt_4c_Data.txt_4c_Data, "LostFocus", THIS, "ValidarDataEvento")

        *-- Fase 8: com todos os controles do dump ja criados, o estado
        *-- Enabled passa a sair de HabilitarCampos (fonte unica derivada do
        *-- When de cada campo no legado) e o rotulo do evento, de
        *-- BOParaForm. Os dois ficam AQUI, no fim do ultimo metodo de
        *-- configuracao, porque so agora existe a superficie inteira:
        *-- HabilitarCampos toca controles dos TRES containers de campo
        *-- (cnt_4c_Observacao/cnt_4c_Data da Fase 5 e cnt_4c_Seq da Fase 6)
        *-- mais os filhos diretos do form.
        THIS.HabilitarCampos(.T.)
        THIS.BOParaForm()
    ENDPROC

    *==========================================================================
    * ValidarDescricaoEvento - Equivalente, nesta arquitetura, ao
    * ControlSource do getDesc legado.
    *
    * No dump, getDesc declara ControlSource = "crSigMvNfd.nfedesc" (SECAO 2
    * - PROPRIEDADES DE SIGOPNFD.cntObservacao.getDesc): o texto digitado vai
    * para o cursor do evento CONTINUAMENTE, e e dali que todo o resto do
    * legado o le - "IF LEN(ALLTRIM(crsigmvnfd.nfedesc)) < 15" (linha 1120),
    * "lcJu = ALLTRIM(thisform.cntObservacao.getDesc.Value)" (linha 999) e
    * "lcDesc = ALLTRIM(fLimpaTexto(crSigMvNfd.nfedesc))" (linha 1209).
    *
    * Nesta arquitetura nao ha ControlSource (o BO le/grava por SQLEXEC), e
    * o controle eh a fonte UNICA do texto: sem este espelhamento, o valor
    * digitado so chegaria ao BO dentro de BtnEnviarClick - e qualquer
    * recarga anterior a isso (ChkRefazerClick no ramo "achou evento",
    * AtualizarCursorEvento) reescreve obj_4c_GetDesc.Value a partir de
    * this_cNfedesc e APAGA o que o usuario digitou, sem erro e sem log. No
    * legado isso nao acontece justamente porque o ControlSource ja havia
    * gravado o texto no cursor.
    *
    * NAO exibe mensagem: o ControlSource do legado nao avisa nada, e a
    * unica critica da descricao ("Descricao do evento invalida", LEN < 15)
    * mora no Click do botao Enviar - reproduzida em BtnEnviarClick. Avisar
    * aqui inventaria comportamento e, pior, atrapalharia quem esta no meio
    * da digitacao (regra #50 do CLAUDE.md).
    *
    * Fase 8: a atribuicao solta a this_cNfedesc deu lugar a FormParaBO(),
    * fonte unica da transferencia controles -> BO (CLAUDE.md #44, item 6).
    * Varrer os quatro controles em vez de um nao muda nada aqui: os outros
    * tres recebem o valor que ja esta neles.
    *==========================================================================
    PROCEDURE ValidarDescricaoEvento()
        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * ValidarDataEvento / ValidarDataEventoExec - Reproduz a restricao de
    * entrada que a classe fweditdata do Framework dava ao getData legado.
    *
    * O legado le esse campo com CTOT() em TRES pontos (linhas 571, 1220 e
    * 1469 do dump): "nfedte with CTOT(thisform.cntData.getData.Value)" no
    * atucur e "b = ttoc(CTOT(thisform.cntData.getData.Value))" nas duas
    * montagens do dhEvento enviado a SEFAZ. La isso e seguro porque getData
    * e um fweditdata (framework.vcx: TextBox de data, Value = {},
    * tpcalendario = 3, com calendario) - o controle nao deixa o campo
    * guardar algo que nao seja data/hora.
    *
    * Aqui o controle e um TextBox comum de valor CARACTERE (fidelidade ao
    * "thisform.cntData.getData.Value = ttoc(DATEtime())" do Init legado),
    * logo o usuario pode digitar qualquer coisa. CTOT() de texto invalido
    * devolve DATETIME VAZIO - sem erro e sem aviso - e o evento seria
    * gravado/enviado com dhEvento em branco. Este handler repoe a
    * restricao: aceita o campo VAZIO (a propria classe declara
    * NullDisplay = "//", ou seja, vazio e estado valido), normaliza o que
    * converte para a forma canonica TTOC() e, no que nao converte, avisa e
    * devolve o ultimo valor valido - que e o que o controle de data do
    * legado faz ao recusar a tecla.
    *
    * Wrapper + Exec (regra #47): o corpo tem RETURN antecipado e o MsgAviso
    * e MODAL (redispara o LostFocus). Com set/clear no proprio corpo a
    * flag travaria ligada no primeiro RETURN e MATARIA a validacao pelo
    * resto da vida do form.
    *==========================================================================
    PROCEDURE ValidarDataEvento()
        LOCAL loc_oErro

        IF THIS.this_lEmValidacao
            RETURN
        ENDIF

        THIS.this_lEmValidacao = .T.

        *-- TRY no WRAPPER, nao no corpo: qualquer excecao dentro do Exec
        *-- (o SetFocus do ramo invalido, por exemplo) deixaria a flag
        *-- LIGADA e mataria a validacao pelo resto da vida do form - o
        *-- mesmo estrago que a regra #47 descreve para o RETURN antecipado.
        TRY
            THIS.ValidarDataEventoExec()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormSigOpNFd.ValidarDataEvento")
        ENDTRY

        THIS.this_lEmValidacao = .F.
    ENDPROC

    PROCEDURE ValidarDataEventoExec()
        LOCAL loc_cDigitado, loc_tConvertido, loc_lValido, loc_oErro

        loc_cDigitado = ALLTRIM(TRANSFORM(THIS.cnt_4c_Data.txt_4c_Data.Value))

        *-- Campo vazio e estado VALIDO (NullDisplay = "//" no dump): o
        *-- legado nao obriga data/hora aqui, e CTOT("") devolve DATETIME
        *-- vazio tanto no legado quanto aqui.
        IF EMPTY(loc_cDigitado)
            THIS.this_cDataEventoAnterior = ""
            THIS.FormParaBO()
            RETURN
        ENDIF

        loc_lValido     = .F.
        loc_tConvertido = {/:}

        *-- CTOT() de texto nao-convertivel devolve DATETIME vazio em vez de
        *-- estourar; o TRY cobre tambem o caso de erro, para o diagnostico
        *-- nao depender de qual dos dois comportamentos ocorre.
        TRY
            loc_tConvertido = CTOT(loc_cDigitado)
            loc_lValido     = (VARTYPE(loc_tConvertido) = "T" AND !EMPTY(loc_tConvertido))
        CATCH TO loc_oErro
            loc_lValido = .F.
        ENDTRY

        IF loc_lValido
            *-- Normaliza para a forma canonica do legado (TTOC), para que
            *-- o CTOT() de quem consome o campo receba sempre o mesmo
            *-- formato que o Init gerou.
            THIS.cnt_4c_Data.txt_4c_Data.Value = TTOC(loc_tConvertido)
            THIS.this_cDataEventoAnterior      = THIS.cnt_4c_Data.txt_4c_Data.Value
        ELSE
            MsgAviso("Data/Hora do evento inv" + CHR(225) + "lida.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.cnt_4c_Data.txt_4c_Data.Value = THIS.this_cDataEventoAnterior
            THIS.cnt_4c_Data.txt_4c_Data.SetFocus()
        ENDIF

        *-- Fase 8: o espelhamento no BO (antes feito com uma atribuicao
        *-- solta a this_dNfedte dentro de cada ramo) passa por FormParaBO,
        *-- fonte unica da transferencia controles -> BO. Fica FORA do
        *-- IF/ELSE de proposito: nos DOIS ramos o controle acabou de ser
        *-- reescrito (valor normalizado no ramo valido, ultimo valor valido
        *-- no invalido), e o BO tem de acompanhar - antes, o ramo invalido
        *-- devolvia o campo ao valor bom na tela e deixava no BO a data que
        *-- CTOT() nao soube converter.
        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * ChkRefazerClick - Refazer.Click do legado (linhas 1759-1782 do dump):
    *
    *   IF this.value = 1
    *       <consulta o ultimo evento da nota>
    *       IF EOF('crSigMvNfd')
    *           thisform.atucur        && nao achou - cria sequencia nova
    *       ELSE
    *           <so espelha os campos do evento encontrado>
    *       ENDIF
    *   ELSE
    *       thisform.atucur            && desmarcado - sempre cria sequencia
    *   ENDIF
    *==========================================================================
    PROCEDURE ChkRefazerClick()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        *-- Espelha o estado dos controles no BO. O legado le
        *-- "thisform.refazer.Value = 1" direto nos dois ramos de envio
        *-- (linhas 1310 e 1519 do dump - reenvio do XML de cancelamento e
        *-- reimpressao da ultima carta), entao a fase que portar a montagem
        *-- do XML precisa do valor ATUAL em this_lRefazer. Fase 8: a
        *-- atribuicao solta deu lugar a FormParaBO(), que cobre os QUATRO
        *-- controles que o legado le de volta - fonte unica
        *-- (CLAUDE.md #44, item 6).
        THIS.FormParaBO()

        IF THIS.chk_4c_Refazer.Value = 1
            IF loc_oBO.ConsultarUltimoEvento()
                *-- Achou o ultimo evento desta nota/evento - so espelha os
                *-- campos (NAO cria sequencia nova, igual ao ramo ELSE do
                *-- legado). A sequencia exibida aqui eh a do evento
                *-- ENCONTRADO - "thisform.cntSeq.getSeq.value =
                *-- crsigmvnfd.nfeseq" (linha 1774 do dump), SEM o "+ 1" que
                *-- o atucur aplica: por isso o parametro de BOParaForm.
                THIS.BOParaForm(loc_oBO.this_nNfeseq)
            ELSE
                THIS.AtualizarCursorEvento()
            ENDIF
        ELSE
            THIS.AtualizarCursorEvento()
        ENDIF
    ENDPROC

    *==========================================================================
    * ChkVeraoChange - Verao nao tem Click no legado; o CheckBox e lido
    * direto na montagem do dhEvento (linha 1142 do dump: "lcVerao =
    * IIF(thisform.verao.Value=1,'02:00','03:00')"). Aqui so espelha o
    * estado no BO a cada mudanca, para o metodo que montar o XML do evento
    * usar THIS.this_oBusinessObject.this_cFusoHorario.
    *
    * Fase 8: as duas atribuicoes soltas deram lugar a FormParaBO(), onde o
    * "IIF(thisform.verao.Value=1,'02:00','03:00')" do legado agora mora uma
    * UNICA vez (CLAUDE.md #44, item 6).
    *==========================================================================
    PROCEDURE ChkVeraoChange()
        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * AtualizarCursorEvento - Equivalente ao atucur() legado (linhas
    * 548-584 do dump) do lado do Form: delega a SigOpNFdBO.
    * AtualizarUltimoEvento() (que decide se PREPARA sequencia nova ou reusa
    * a existente - sem gravar, igual ao atucur, que so mexe no cursor em
    * memoria) e, so quando ele tem sucesso, espelha os
    * campos atualizados nos controles da tela - igual ao legado
    * ("thisform.cntNFe.getNfe.value = ... / thisform.cntSeq.getSeq.value =
    * ... / thisform.cntObservacao.getDesc.value = ... / ThisForm.Refresh").
    *
    * A data/hora que o BO recebe eh a do CONTROLE - equivale ao
    * "CTOT(thisform.cntData.getData.Value)" do legado (linha 571). Fase 8:
    * a leitura do controle deixou de ser feita aqui com um CTOT() solto e
    * passa por FormParaBO(), que eh quem normaliza e guarda o valor em
    * this_dNfedte (fonte unica - CLAUDE.md #44, item 6); o argumento
    * continua sendo passado porque eh o contrato de
    * AtualizarUltimoEvento().
    *
    * A sequencia exibida eh this_nUltimaSequencia - o lnUltSeq do legado
    * ("thisform.cntSeq.getSeq.value = lnUltSeq", linha 578), que eh o
    * ultimo nfeseq + 1 (ou 1, quando nao ha evento anterior) e vale nos
    * DOIS ramos do atucur, inclusive no de reuso. Nao confundir com
    * this_nNfeseq, que eh a sequencia do evento ENCONTRADO e eh o que o
    * Refazer.Click exibe (ver ChkRefazerClick).
    *
    * LimparCampos() reproduz o "nfedesc with ''" do APPEND legado (linha
    * 572) e por isso roda SO no ramo da sequencia nova, que eh onde aquele
    * replace esta - this_lNovoRegistro eh exatamente o que
    * AtualizarUltimoEvento acabou de definir (NovoRegistro no ramo novo,
    * EditarRegistro no de reuso).
    *
    * AtualizarUltimoEvento() tem guarda propria contra o contexto da nota
    * ainda nao lido (this_cNfiEmpDopNums vazio - ver cabecalho da classe e
    * de SigOpNFdBO.prg): quando a guarda bloqueia, devolve .F. e este
    * metodo simplesmente nao atualiza nada na tela (os campos continuam no
    * default vazio/zero ate a fase que portar a leitura de SigMvNfi).
    *==========================================================================
    PROCEDURE AtualizarCursorEvento()
        LOCAL loc_oBO, loc_lAtualizou
        loc_lAtualizou = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        THIS.FormParaBO()

        IF loc_oBO.AtualizarUltimoEvento(loc_oBO.this_dNfedte)
            IF loc_oBO.this_lNovoRegistro
                THIS.LimparCampos()
            ENDIF

            THIS.BOParaForm(loc_oBO.this_nUltimaSequencia)
            loc_lAtualizou = .T.
        ENDIF

        RETURN loc_lAtualizou
    ENDPROC

    *==========================================================================
    * CarregarLista - Funil PUBLICO de carga desta tela, no nome canonico do
    * projeto. Delega a AtualizarCursorEvento(), que eh o atucur() legado -
    * a consulta do ultimo evento da nota mais o espelhamento nos controles.
    *
    * NAO ha grade neste form (layout.json nao declara um unico objeto
    * baseClass=grid, e a SECAO 1 do dump confirma: nenhum grid/pageframe),
    * logo nao ha RecordSource/ControlSource de coluna, GO TOP nem
    * Grid.Refresh a fazer aqui - o repintar equivalente eh o
    * "ThisForm.Refresh" com que o atucur termina, dentro de BOParaForm.
    * Mesmo padrao de funil de FormSigOpNch.CarregarLista() ->
    * CarregarGrade().
    *
    * PUBLIC (sem PROTECTED) de proposito: o harness de teste chama
    * oForm.CarregarLista() de FORA da classe, e metodo PROTECTED falha ali
    * em runtime mesmo com PEMSTATUS(...,5) devolvendo .T. (regras #3 e #51
    * do CLAUDE.md).
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN THIS.AtualizarCursorEvento()
    ENDPROC

    *==========================================================================
    * FormParaBO - Transferencia CONTROLES -> BO.
    *
    * Cobre os QUATRO controles que o legado le de volta, com todos os seus
    * sites no dump:
    *
    *   cntObservacao.getDesc -> this_cNfedesc
    *       "lcJu = ALLTRIM(thisform.cntObservacao.getDesc.Value)" (linha
    *       999) e, via ControlSource, "LEN(ALLTRIM(crsigmvnfd.nfedesc))"
    *       (linha 1120) e "fLimpaTexto(crSigMvNfd.nfedesc)" (linha 1209).
    *
    *   cntData.getData -> this_dNfedte
    *       "CTOT(thisform.cntData.getData.Value)" (linhas 571, 1220 e
    *       1469). CTOT de texto nao-convertivel devolve DATETIME VAZIO sem
    *       erro, e eh exatamente esse o valor que o legado gravaria -
    *       ValidarDataEvento eh quem impede o campo de chegar nesse estado.
    *
    *   Refazer -> this_lRefazer
    *       "thisform.refazer.Value = 1" (linhas 1310 e 1519).
    *
    *   Verao -> this_lHorarioVerao / this_cFusoHorario
    *       "lcVerao = IIF(thisform.verao.Value=1,'02:00','03:00')"
    *       (linha 1142).
    *
    * getNfe, getSeq e GetEvento NAO entram: os tres tem "When -> Return
    * .f." no dump (somente EXIBICAO) e o legado nunca le o valor deles -
    * quem escreve nesses campos eh o proprio BO, atraves de BOParaForm.
    * Ler um campo de exibicao de volta sobrescreveria a property com o que
    * o BO acabou de por nela e, antes da primeira carga, com BRANCO.
    *
    * this_cEvento tambem nao entra: vem do pEvento do Init (parametro do
    * form pai), nao de controle nenhum, e eh espelhado no BO uma vez em
    * InicializarForm.
    *
    * PROTECTED EXPLICITO: FormBase declara FormParaBO como PROTECTED e o
    * VFP9 nao deixa a subclasse ALARGAR o escopo - escrever sem o
    * modificador apenas esconderia que o metodo continua protegido.
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_oBO, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
            loc_oBO.this_cNfedesc = ALLTRIM(THIS.cnt_4c_Observacao.obj_4c_GetDesc.Value)
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Data", 5)
            loc_oBO.this_dNfedte = CTOT(ALLTRIM(TRANSFORM(THIS.cnt_4c_Data.txt_4c_Data.Value)))
        ENDIF

        IF PEMSTATUS(THIS, "chk_4c_Refazer", 5)
            loc_oBO.this_lRefazer = (THIS.chk_4c_Refazer.Value = 1)
        ENDIF

        IF PEMSTATUS(THIS, "chk_4c_Verao", 5)
            loc_oBO.this_lHorarioVerao = (THIS.chk_4c_Verao.Value = 1)
            loc_oBO.this_cFusoHorario  = IIF(THIS.chk_4c_Verao.Value = 1, "02:00", "03:00")
        ENDIF

        loc_lSucesso = .T.

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BOParaForm - Transferencia BO -> CONTROLES.
    *
    * Eh o bloco final do atucur legado (linhas 577-579)
    *
    *   thisform.cntNFe.getNfe.value         = crsigmvnfi.nfis
    *   thisform.cntSeq.getSeq.value         = lnUltSeq
    *   thisform.cntObservacao.getDesc.value = crsigmvnfd.nfedesc
    *   ThisForm.Refresh
    *
    * e o do ramo "achou evento" do Refazer.Click (linhas 1771-1775), que eh
    * o MESMO bloco trocando a sequencia por crsigmvnfd.nfeseq. Dai o
    * par_nSequencia: quando numerico, eh a sequencia a exibir; omitido,
    * vale this_nUltimaSequencia (o lnUltSeq do atucur). Sem o parametro a
    * consolidacao dos dois blocos perderia essa distincao do legado em
    * silencio.
    *
    * O numero da nota vem de this_cNfiNfis (a property que espelha
    * crSigMvNfi.nfis, a nota de ORIGEM), NAO de this_cNfis (que eh a coluna
    * nfis do EVENTO - homonima, outro registro; ver o bloco de prefixos
    * "Nfi" no cabecalho de SigOpNFdBO.prg). Os dois caminhos que chamam
    * este metodo passam pela guarda de this_cNfiEmpDopNums do BO, entao
    * quando BOParaForm roda a partir deles o contexto da nota ja existe.
    *
    * txt_4c_Evento (GetEvento) recebe o rotulo do evento, que no legado eh
    * atribuido no Init ("IF thisform.Evento = 'CAN' / thisform.getEvento.
    * Value = 'CANCELAMENTO' / ELSE / ... = 'CARTA DE CORRECAO'"). Eh funcao
    * PURA de this_cEvento, que nao muda durante a vida do dialogo, logo
    * reatribui-lo em cada recarga eh idempotente - e mantem num lugar so
    * TODA a escrita BO -> controle (CLAUDE.md #44, item 6).
    *
    * NAO escreve no campo de data/hora: nem o atucur nem o Refazer.Click
    * escrevem - no Refazer a linha existe COMENTADA no proprio legado
    * ("*!* thisform.cntData.getData.Value = ttoc(DATEtime())", linha 1772).
    * O campo eh de ENTRADA e quem o alimenta eh o usuario; sobrescreve-lo a
    * cada recarga apagaria o que ele digitou.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO (FormBase declara
    * BOParaForm como PROTECTED e VFP9 nao permite alargar o escopo).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm(par_nSequencia)
        LOCAL loc_oBO, loc_nSeq, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN .F.
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        loc_nSeq = IIF(VARTYPE(par_nSequencia) = "N", par_nSequencia, ;
                       loc_oBO.this_nUltimaSequencia)

        IF PEMSTATUS(THIS, "cnt_4c_NFe", 5)
            THIS.cnt_4c_NFe.txt_4c_Nfe.Value = ALLTRIM(loc_oBO.this_cNfiNfis)
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Seq", 5)
            THIS.cnt_4c_Seq.txt_4c_Seq.Value = loc_nSeq
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
            THIS.cnt_4c_Observacao.obj_4c_GetDesc.Value = loc_oBO.this_cNfedesc
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Evento", 5)
            THIS.txt_4c_Evento.Value = IIF(loc_oBO.this_cEvento = "CAN", ;
                loc_oBO.this_cRotuloCancelamento, loc_oBO.this_cRotuloCarta)
        ENDIF

        *-- "ThisForm.Refresh" com que o atucur e o ramo de reuso do
        *-- Refazer.Click terminam - popular nao repinta sozinho (regra #21)
        THIS.Refresh()

        loc_lSucesso = .T.

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Fonte UNICA do estado Enabled dos controles.
    *
    * O criterio eh o When de cada campo no dump, NAO uma regra de modo (o
    * SIGOPNFD nao tem modo: zero pcEscolha, zero frmcadastro, zero Grupo_Op,
    * e nenhuma atribuicao a .Enabled de controle em todo o legado):
    *
    *   cntObservacao.getDesc  When -> Return .t.  -> acompanha o parametro
    *   cntData.getData        When -> Return .t.  -> acompanha o parametro
    *   cntNFe.getNfe          When -> Return .f.  -> SEMPRE desabilitado
    *   cntSeq.getSeq          When -> Return .f.  -> SEMPRE desabilitado
    *   GetEvento              When -> Return .f.  -> SEMPRE desabilitado
    *
    * Os tres de "When -> Return .f." ficam desabilitados em QUALQUER valor
    * do parametro: no legado nao existe estado da tela que os torne
    * digitaveis, e habilita-los seria comportamento novo (PILAR 1). Os dois
    * CheckBox nao declaram When no dump (sao clicaveis sempre) e por isso
    * acompanham o parametro.
    *
    * PEMSTATUS em cada container: o metodo eh PUBLIC e pode ser chamado
    * antes de a superficie inteira existir (harness de teste, ou uma fase
    * futura chamando-o de dentro de outro ponto do Init).
    *
    * PUBLIC (sem PROTECTED): o harness de teste chama
    * oForm.HabilitarCampos(...) de fora da classe (regras #3 e #51).
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHabilitar

        loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)

        *-- Campos digitaveis do legado (When -> Return .t.)
        IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
            THIS.cnt_4c_Observacao.obj_4c_GetDesc.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Data", 5)
            THIS.cnt_4c_Data.txt_4c_Data.Enabled = loc_lHabilitar
        ENDIF

        *-- CheckBox: o dump nao declara When para nenhum dos dois
        IF PEMSTATUS(THIS, "chk_4c_Refazer", 5)
            THIS.chk_4c_Refazer.Enabled = loc_lHabilitar
        ENDIF

        IF PEMSTATUS(THIS, "chk_4c_Verao", 5)
            THIS.chk_4c_Verao.Enabled = loc_lHabilitar
        ENDIF

        *-- Campos de EXIBICAO (When -> Return .f.): nunca recebem foco, em
        *-- nenhum estado da tela
        IF PEMSTATUS(THIS, "cnt_4c_NFe", 5)
            THIS.cnt_4c_NFe.txt_4c_Nfe.Enabled = .F.
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Seq", 5)
            THIS.cnt_4c_Seq.txt_4c_Seq.Enabled = .F.
        ENDIF

        IF PEMSTATUS(THIS, "txt_4c_Evento", 5)
            THIS.txt_4c_Evento.Enabled = .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparCampos - Reset do "evento novo": eh o "nfedesc with ''" do APPEND
    * BLANK do atucur legado (linha 572).
    *
    * No legado aquele replace zera a COLUNA nfedesc do cursor e, porque o
    * getDesc tem ControlSource = "crSigMvNfd.nfedesc", a tela acompanha
    * sozinha. Aqui nao ha ControlSource, entao zerar os DOIS lados -
    * property e controle - eh o que reproduz o efeito.
    *
    * NAO toca o campo de data/hora. O legado tem exatamente essa linha
    * COMENTADA nos dois pontos onde ela caberia ("*!* nfedte with
    * DATETIME()" no atucur, linha 562, e "*!* thisform.cntData.getData.
    * Value = ttoc(DATEtime())" no Refazer.Click, linha 1772): reinstalar o
    * reset da data seria reativar codigo que o autor do legado desligou, e
    * apagaria a data/hora que o usuario tiver informado.
    *
    * Tambem nao toca Refazer/Verao: o legado nunca os desmarca por codigo.
    *
    * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO/BOParaForm
    * (FormBase declara LimparCampos como PROTECTED e o VFP9 nao permite
    * alargar o escopo de metodo herdado).
    *==========================================================================
    PROTECTED PROCEDURE LimparCampos()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject.this_cNfedesc = ""
        ENDIF

        IF PEMSTATUS(THIS, "cnt_4c_Observacao", 5)
            THIS.cnt_4c_Observacao.obj_4c_GetDesc.Value = ""
        ENDIF

        RETURN .T.
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - btnSair.Click do legado (linhas 1683-1686 do dump):
    *   Thisform.parentform.enabled = .T.
    *   Thisform.release
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        THIS.HabilitarFormPai(.T.)
        THIS.Release()
    ENDPROC

    *==========================================================================
    * BtnEnviarClick - btnSelItens.Click do legado (linhas 977-1678 do dump).
    *
    * Reproduz aqui a parte do fluxo que e PURAMENTE validacao de dados (as
    * guardas que antecedem a montagem/envio do XML, linhas 1107-1123 e 1120
    * do dump - nenhuma delas depende de arquivo em disco, DLL ou processo
    * externo) e a gravacao do evento em SigMvNfd (equivalente ao
    * atucur()/APPEND BLANK, ja implementado em SigOpNFdBO.Inserir() - Fase
    * 2) atraves de loc_oBO.Salvar() (BusinessBase - chama ValidarDados() e
    * Inserir(), e ja exibe a falha sozinha quando Salvar() devolve .F. -
    * regra #20 do CLAUDE.md, "o form NAO precisa de ELSE").
    *
    * NAO reproduzido nesta fase - depende de infraestrutura que ainda nao
    * existe em NENHUM ponto do projeto novo (nao e omissao silenciosa: a
    * propria SigOpNFdBO.prg, Fase 2, ja documenta estes passos em
    * "Fluxo do legado (a reproduzir nas fases seguintes)"):
    *   - leitura do CONTEXTO da nota (SigMvNfi/SigPrNfe/SigMvCab/SigCdOpe+
    *     SigOpCdd/Cdc/Cdi/SigCdEmp/SigCdCli) - as properties this_cNfi*/
    *     this_cStats/this_cCabDopes/this_nCupFis/this_cEmp* ja existem no BO
    *     (Fase 1) mas nenhum metodo as popula ainda;
    *   - cancelamento de NFCe via DarumaFramework.dll (CupFis = 5) e de CF-e
    *     via SAT.dll (CupFis = 6, canccfe());
    *   - protocolo de arquivos da UniNFe (envio/validar/retorno, esperaarq/
    *     esperauniler do ParentForm2) e geracao/assinatura do XML do evento;
    *   - envio de e-mail (enviaEmail) e geracao automatica de operacao
    *     (Gerarnota) quando SigOpCdc.Geropes = 4.
    *==========================================================================
    PROCEDURE BtnEnviarClick()
        LOCAL loc_oBO

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF
        loc_oBO = THIS.this_oBusinessObject

        *-- Legado (linhas 1406 e 1649): replace nfedesc with lcdesc in
        *-- crSigMvNfd, imediatamente antes do Update/Commit -
        *-- cnt_4c_Observacao.obj_4c_GetDesc (equivalente a getDesc, Fase 5)
        *-- eh a fonte UNICA do texto digitado. ValidarDescricaoEvento ja
        *-- espelha a cada LostFocus (equivalente ao ControlSource do
        *-- legado); aqui o espelhamento eh repetido para cobrir o caso de o
        *-- usuario clicar Enviar com o cursor AINDA dentro do EditBox, em
        *-- que o LostFocus nao chegou a disparar. Fase 8: por FormParaBO,
        *-- que faz o mesmo para os QUATRO controles que o legado le de
        *-- volta - a descricao, a data/hora (os tres CTOT do dump) e os
        *-- dois CheckBox, todos consumidos pelo fluxo de envio.
        THIS.FormParaBO()

        *-- Legado (linha 1120): IF LEN(ALLTRIM(crsigmvnfd.nfedesc)) < 15
        IF LEN(loc_oBO.this_cNfedesc) < loc_oBO.this_nTamMinDescricao
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o do evento inv" + ;
                     CHR(225) + "lida", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        *-- O MODO de gravacao ja foi definido por AtualizarCursorEvento ->
        *-- SigOpNFdBO.AtualizarUltimoEvento (equivalente ao atucur): linha
        *-- nova -> NovoRegistro (Salvar roteia para Inserir); evento 'CAN'
        *-- reaproveitado -> EditarRegistro (Salvar roteia para Atualizar).
        *-- NAO chamar NovoRegistro() aqui: forcaria INSERT tambem no ramo de
        *-- reuso, criando um registro duplicado onde o legado faz UPDATE.
        *-- Salvar() ja exibe a propria falha quando devolve .F. (regra #20
        *-- do CLAUDE.md - inclusive o caso "nao esta em modo de edicao",
        *-- que e como a ausencia do contexto da nota se manifesta enquanto
        *-- a leitura de SigMvNfi nao for portada).
        loc_oBO.Salvar()

        *-- Legado (linha 1676, ULTIMA instrucao do Click antes do
        *-- "RETURN lOk"): "thisform.atucur()  && atualiza cursor". Fica
        *-- FORA de qualquer IF no legado - roda tanto no caminho de sucesso
        *-- quanto nos de falha do envio -, e por isso tambem roda aqui sem
        *-- condicionar ao retorno de Salvar(). Depois de gravar, a tela se
        *-- recarrega: a consulta volta a buscar o ultimo evento da nota e a
        *-- sequencia exibida avanca.
        *--
        *-- O RETURN antecipado da guarda de descricao, acima, PULA este
        *-- atucur - igual ao "return" nu do legado (linha 1122), que sai do
        *-- Click sem alcancar a linha 1676.
        THIS.AtualizarCursorEvento()
    ENDPROC

    *==========================================================================
    * HabilitarFormPai - Habilita/desabilita o form que abriu este dialogo
    * (this_oFormPai = ThisForm.ParentForm no legado). Guardado por VARTYPE
    * porque em validacao de UI / modo teste o dialogo e instanciado sem pai.
    *==========================================================================
    PROTECTED PROCEDURE HabilitarFormPai(par_lHabilitar)
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.this_oFormPai.Enabled = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        ENDIF
    ENDPROC

    *==========================================================================
    * Destroy - Rede de seguranca: reabilita o form pai (caso o usuario
    * feche a janela por outro caminho que nao o BtnCancelarClick, que ja
    * reabilita) e libera BO/referencias antes do DODEFAULT().
    *==========================================================================
    PROCEDURE Destroy()
        LOCAL loc_oErro

        THIS.HabilitarFormPai(.T.)

        TRY
            THIS.this_oBusinessObject = .NULL.
            THIS.this_oFormPai        = .NULL.
            THIS.this_oFormPai2       = .NULL.
        CATCH TO loc_oErro
            *-- Destruicao nao bloqueia saida
        ENDTRY

        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpNFdBO.prg):
*==============================================================================
* SigOpNFdBO.prg - Business Object para SigOpNFd (Eventos NFe)
*
* Form OPERACIONAL (SIGOPNFD.SCX, Caption "Eventos NFe"). NAO eh cadastro
* CRUD: eh um dialogo FILHO, aberto pelo form de movimentacao/nota fiscal
* (ParentForm) passando (pForm1, pForm2, pDId, pEvento), que registra na
* SEFAZ um EVENTO sobre uma NFe ja emitida:
*
*   pEvento = 'CAN' -> CANCELAMENTO       (tpEvento 110111)
*   pEvento = 'CAR' -> CARTA DE CORRECAO  (tpEvento 110110)
*
* Fluxo do legado (a reproduzir nas fases seguintes):
*
*   Init do form
*     - Evento := pEvento; rotulo do campo GetEvento conforme o evento
*     - getData.Value := ttoc(DATETIME())
*     - atucur()  -> le o ULTIMO evento desta operacao e, se for 'CAR' ou se
*                    nao houver linha, APPEND BLANK + Replace no cursor de
*                    SigMvNfd com nfeseq = ultimo + 1 (1 quando nao ha linha)
*     - le SigMvCab pela chave empdopnums da nota
*     - le a configuracao da operacao (SigCdOpe + SigOpCdd + SigOpCdc +
*       SigOpCdi) para o cursor LocalOpe
*
*   atucur (metodo do form legado)
*     Select * From SigMvNfd Where empdopnums = <chave> And nfeEve = <evento>
*       Order By nfeseq desc
*     lnUltSeq = IIF(EOF(), 1, nfeseq + 1)
*     Replace cidchaves With fUniqueIds(), nfis, dopes, numes, emps,
*             empdopnums, nfedte With CTOT(getData.Value), nfedesc With '',
*             nfeeve With Evento, nfeseq With lnUltSeq
*     Espelha nfis / nfeseq / nfedesc nos campos da tela
*
*   btnSelItens.Click ("Enviar") - tres caminhos, decididos por SigCdOpe.CupFis
*     CupFis = 5 -> NFCe emitida pelo Migrate: cancela pela DLL
*                   DarumaFramework (tCFCancelar_NFCe_Daruma), exigindo
*                   SigPrNfe.stats = 'EMI' e situacao '100' na consulta
*     CupFis = 6 -> CF-e do SAT: canccfe() monta o XML de cancelamento
*                   (cursor CFTags) e grava SigMvNfi.canxml
*     demais     -> NFe pela UniNFe: valida/envia o XML do evento, le o
*                   retorno (cStat/xMotivo), grava SigMvNfd.nfexml +
*                   nfedesc, marca SigMvNfi.cancelas / SigPrNfe.stats e
*                   envia o XML por e-mail ao cliente
*     Fecha SEMPRE com atucur() (repopula o cursor do evento)
*
*   conscan (metodo do form legado)
*     Monta consSitNFe versao 4.00, envia pela UniNFe e, com cStat 100/101,
*     grava SigPrNfe.stats = 'CAN' / statts = '0' / prots = <nProt>
*
*   Refazer.Click
*     Marcado    -> reusa o ULTIMO evento gravado (nao cria sequencia nova):
*                   reenvia o XML de cancelamento ou reimprime a carta
*     Desmarcado -> atucur() (volta a criar a proxima sequencia)
*
* TABELAS E COLUNAS - todos os nomes conferidos em docs/schema.sql lido com
* Get-Content -Raw (o arquivo eh UTF-16; grep/findstr devolvem ZERO em
* silencio - regra #14 do CLAUDE.md):
*
*   SigMvNfd (tabela principal deste BO - um registro por EVENTO da nota)
*     cidchaves  char(20)      NOT NULL  PK (fUniqueIds no legado)
*     dopes      char(20)      NOT NULL
*     empdopnums char(29)      NOT NULL  Emps(3) + Dopes(20) + Str(Numes,6)
*     emps       char(3)       NOT NULL
*     nfedesc    text          NULL      justificativa / texto da correcao
*     nfedte     datetime      NULL      data/hora do evento (dhEvento)
*     nfeeve     char(3)       NOT NULL  'CAN' ou 'CAR'
*     nfeprt     char(15)      NOT NULL  protocolo
*     nfeseq     numeric(2,0)  NOT NULL  nSeqEvento (1..99)
*     nfexml     text          NULL      XML do evento autorizado
*     nfis       char(6)       NOT NULL  numero da nota
*     numes      numeric(6,0)  NOT NULL
*     numeronota char(10)      NOT NULL
*
*   SigMvNfi (nota fiscal de origem - crSigMvNfi no legado; gravada pelo
*            form PAI, lida e marcada por este fluxo)
*     cidchaves char(20), empdopnums char(29), emps char(3), dopes char(20),
*     numes numeric(6,0), nfis char(6), series char(8), clifors char(20),
*     emis datetime NULL, nfechv char(44), nfeprt char(15),
*     nfexml text NULL, canxml text NULL, cancelas bit
*
*   SigPrNfe (situacao da NFe - crSigPrNfe no legado)
*     stats char(3), statts char(1), prots char(15), arquivos char(250)
*
*   SigMvCab (cabecalho do movimento - crSigMvCab no legado)
*     empdopnums char(29), dopes char(20), lcancelas bit
*
*   SigCdOpe  cupfis numeric(1,0), dopes char(20)   (5=NFCe Migrate, 6=SAT)
*   SigOpCdd  configgers char(250)  (posicao 239..241 = empresa emitente)
*   SigOpCdc  cncaixas char(3), geropes numeric(1,0), dopenfs char(20)
*   SigCdPac  direxpsdfs char(200) (pasta de backup do XML)
*   SigCdEmp  cemps char(3) PK, razas char(40), cgcs char(20),
*             pastas char(50), textonfe text, emailnfe char(250),
*             servs char(50), senhas char(30), portas numeric(3,0),
*             textopaf text
*             ATENCAO (regra #48): a coluna de empresa de SigCdEmp eh
*             CEMPS; em SigMvNfd/SigMvNfi/SigPrNfe/SigMvCab eh EMPS.
*   SigCdCli  iclis char(10) PK, emails char(50)
*
* Nao sobrescreve Inserir()/Atualizar()/ExecutarExclusao() no sentido CRUD
* classico: a gravacao do evento (Fase 2) espelha o APPEND BLANK + Replace
* do legado sobre SigMvNfd, por isso this_cTabela/this_cCampoChave apontam
* para SigMvNfd/cidchaves.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpNFdBO AS BusinessBase

    *==========================================================================
    * SigMvNfd - registro do EVENTO (tabela principal deste BO)
    *
    * nfedte eh declarada com {/:} (DATETIME vazio, VARTYPE "T") e NAO com {}
    * (DATE): a hora faz parte do dhEvento enviado a SEFAZ, e so com tipo "T"
    * o FormatarDataSQL() acrescenta " HH:MM:SS" ao literal. Pelo mesmo motivo
    * NUNCA aplicar TTOD() a esta property (regra #16) - o valor vem de
    * CTOT(<TextBox>.Value) no form e pode chegar como DATE quando o campo
    * esta vazio; normalizar com ConverterParaData() apenas onde se quiser a
    * DATA pura (nome da pasta de autorizados, por exemplo).
    *==========================================================================
    this_cCidchaves  = ""     && cidchaves  char(20) NOT NULL - PK (fUniqueIds)
    this_cDopes      = ""     && dopes      char(20) NOT NULL - documento da operacao
    this_cEmpDopNums = ""     && empdopnums char(29) NOT NULL - Emps+Dopes+Str(Numes,6)
    this_cEmps       = ""     && emps       char(3)  NOT NULL - empresa do movimento
    this_cNfedesc    = ""     && nfedesc    text     NULL     - justificativa / correcao
    this_dNfedte     = {/:}   && nfedte     datetime NULL     - data/hora do evento
    this_cNfeeve     = ""     && nfeeve     char(3)  NOT NULL - 'CAN' ou 'CAR'
    this_cNfeprt     = ""     && nfeprt     char(15) NOT NULL - protocolo do evento
    this_nNfeseq     = 0      && nfeseq     numeric(2,0) NOT NULL - nSeqEvento (1..99)
    this_cNfexml     = ""     && nfexml     text     NULL     - XML do evento autorizado
    this_cNfis       = ""     && nfis       char(6)  NOT NULL - numero da nota
    this_nNumes      = 0      && numes      numeric(6,0) NOT NULL
    this_cNumeroNota = ""     && numeronota char(10) NOT NULL

    *==========================================================================
    * SigMvNfi - nota fiscal de ORIGEM (crSigMvNfi no legado)
    *
    * Prefixo "Nfi" nos nomes porque SigMvNfi e SigMvNfd tem colunas
    * HOMONIMAS com conteudo diferente (nfis, nfeprt, nfexml, emps, dopes,
    * numes, empdopnums, cidchaves): sem o prefixo, o protocolo da NOTA
    * sobrescreveria o protocolo do EVENTO.
    *==========================================================================
    this_cNfiCidchaves  = ""     && cidchaves  char(20) - PK da nota
    this_cNfiEmpDopNums = ""     && empdopnums char(29) - liga nota, evento e cabecalho
    this_cNfiEmps       = ""     && emps       char(3)
    this_cNfiDopes      = ""     && dopes      char(20)
    this_nNfiNumes      = 0      && numes      numeric(6,0)
    this_cNfiNfis       = ""     && nfis       char(6)  - numero da nota (exibido na tela)
    this_cNfiSeries     = ""     && series     char(8)  - serie da nota
    this_cNfiCliFors    = ""     && clifors    char(20) - cliente/fornecedor (SigCdCli.IClis)
    this_dNfiEmis       = {/:}   && emis       datetime NULL - emissao (pasta de autorizados)
    this_cNfiNfechv     = ""     && nfechv     char(44) - chave de acesso da NFe (cId / chNFe)
    this_cNfiNfeprt     = ""     && nfeprt     char(15) - protocolo da AUTORIZACAO (nProt)
    this_cNfiNfexml     = ""     && nfexml     text NULL - XML de autorizacao (origem do tpAmb)
    this_cNfiCanxml     = ""     && canxml     text NULL - XML do cancelamento
    this_lNfiCancelas   = .F.    && cancelas   bit - nota cancelada

    *==========================================================================
    * SigPrNfe - situacao da NFe (crSigPrNfe no legado)
    *
    * stats = 'EMI' eh pre-requisito para os dois eventos; o cancelamento
    * tambem aceita 'CAN' (reenvio). Ao autorizar o cancelamento o legado
    * grava stats = 'CAN' + statts = '0' e, no conscan, prots = <nProt>.
    *==========================================================================
    this_cStats    = ""   && stats    char(3)   - 'EMI' / 'CAN'
    this_cStatts   = ""   && statts   char(1)   - '0' apos cancelar
    this_cProts    = ""   && prots    char(15)  - protocolo retornado pela consulta
    this_cArquivos = ""   && arquivos char(250) - justificativa gravada no cancelamento de NFCe

    *==========================================================================
    * SigMvCab - cabecalho do movimento (crSigMvCab no legado)
    *==========================================================================
    this_cCabDopes     = ""    && dopes     char(20) - operacao do movimento (le a config da operacao)
    this_lCabLCancelas = .F.   && lcancelas bit - marca a OPERACAO como cancelada

    *==========================================================================
    * Configuracao da OPERACAO (cursor LocalOpe do legado: SigCdOpe +
    * SigOpCdd + SigOpCdc + SigOpCdi) e parametros do sistema (SigCdPac)
    *==========================================================================
    this_nCupFis     = 0    && SigCdOpe.cupfis     numeric(1,0) - 5=NFCe Migrate, 6=CF-e SAT, outros=NFe
    this_cConfigGers = ""   && SigOpCdd.configgers char(250)    - 239..241 = empresa emitente
    this_cCnCaixas   = ""   && SigOpCdc.cncaixas   char(3)      - numero do caixa (SAT: numeroCaixa)
    this_nGeropes    = 0    && SigOpCdc.geropes    numeric(1,0) - 4 = gera operacao automatica
    this_cDopenfs    = ""   && SigOpCdc.dopenfs    char(20)     - operacao gerada automaticamente
    this_cDirExpSdfs = ""   && SigCdPac.direxpsdfs char(200)    - pasta de backup do XML

    *==========================================================================
    * Empresa EMITENTE (cursor LocalEmp do legado: SigCdEmp da empresa
    * resolvida em ConfigGers 239..241, com fallback na empresa da nota)
    *
    * textopaf guarda, em posicoes FIXAS, os dados do SAT:
    *   1..14    CNPJ da casa de software (CNPJ da AC)
    *   16..359  assinatura (signAC)
    *   361..370 fabricante do equipamento SAT
    *==========================================================================
    this_cEmpCemps    = ""   && SigCdEmp.cemps    char(3) PK - empresa emitente
    this_cEmpRazas    = ""   && SigCdEmp.razas    char(40)
    this_cEmpCgcs     = ""   && SigCdEmp.cgcs     char(20) - CNPJ (a pasta do XML usa so os digitos)
    this_cEmpPastas   = ""   && SigCdEmp.pastas   char(50) - pasta raiz da UniNFe (cPathUni)
    this_cEmpTextoNfe = ""   && SigCdEmp.textonfe text NULL - corpo do e-mail
    this_cEmpEmailNfe = ""   && SigCdEmp.emailnfe char(250) - remetente / copia
    this_cEmpServs    = ""   && SigCdEmp.servs    char(50) - servidor SMTP
    this_cEmpSenhas   = ""   && SigCdEmp.senhas   char(30) - senha SMTP
    this_nEmpPortas   = 0    && SigCdEmp.portas   numeric(3,0) - porta SMTP
    this_cEmpTextoPaf = ""   && SigCdEmp.textopaf text NULL - dados do SAT em posicoes fixas

    *==========================================================================
    * Destinatario (SigCdCli) - e-mail para onde vai o XML do evento
    *==========================================================================
    this_cEmailCliente = ""   && SigCdCli.emails char(50) - WHERE IClis = SigMvNfi.clifors

    *==========================================================================
    * Estado do EVENTO em edicao (campos da tela e parametro de abertura)
    *
    * this_cEvento eh o pEvento recebido pelo form; os rotulos exibidos no
    * campo GetEvento sao atribuidos no Init (precisam de CHR() para os
    * acentos, e declaracao de property nao aceita chamada de funcao).
    *==========================================================================
    this_cEvento             = ""    && 'CAN' (cancelamento) ou 'CAR' (carta de correcao)
    this_cRotuloEvento       = ""    && texto exibido no campo GetEvento
    this_cRotuloCancelamento = ""    && 'CANCELAMENTO'      (atribuido no Init)
    this_cRotuloCarta        = ""    && 'CARTA DE CORRECAO'  (atribuido no Init, com CHR())
    this_lRefazer            = .F.   && CheckBox Refazer: reusa o ULTIMO evento gravado
    this_lHorarioVerao       = .F.   && CheckBox Horario de Verao: fuso 02:00 em vez de 03:00
    this_cFusoHorario        = ""    && '02:00' / '03:00' - sufixo do dhEvento (vem do CheckBox)
    this_nUltimaSequencia    = 0     && lnUltSeq do atucur: ultimo nfeseq + 1 (1 se nao ha evento)

    *==========================================================================
    * Constantes do evento NFe (layout nacional) - transcritas do legado
    *==========================================================================
    this_cTpEventoCancelamento = "110111"   && tpEvento do cancelamento
    this_cTpEventoCarta        = "110110"   && tpEvento da carta de correcao
    this_cVersaoEvento         = "1.00"     && versao do envEvento / evento / detEvento
    this_cVersaoConsulta       = "4.00"     && versao do consSitNFe (conscan)
    this_nTamMinDescricao      = 15         && LEN(ALLTRIM(nfedesc)) < 15 recusa o envio
    this_nMaxSequencia         = 99         && nfeseq eh numeric(2,0): 1..99

    *==========================================================================
    * Retorno da SEFAZ / do SAT (lido do XML de retorno)
    *==========================================================================
    this_cTipoAmbiente     = ""   && tpAmb extraido do XML de autorizacao da nota
    this_cStatusRetorno    = ""   && cStat (135 / 'EVENTO REGISTRADO' no evento; 100/101 no conscan)
    this_cMotivoRetorno    = ""   && xMotivo
    this_cMensagemRetorno  = ""   && mensagem montada para o usuario (cCampo no legado)
    this_cProtocoloRetorno = ""   && nProt retornado pela consulta de situacao
    this_cConteudoXml      = ""   && conteudo do XML autorizado (gravado em nfexml / canxml)

    *==========================================================================
    * Caminhos de arquivo da UniNFe - a pasta raiz vem de SigCdEmp.pastas e as
    * subpastas sao FIXAS no legado (nomes transcritos literalmente, pois sao
    * os nomes que o UniNFe monitora em disco)
    *==========================================================================
    this_cPathUni      = ""   && cPathUni - SigCdEmp.pastas
    this_cPathNFe      = ""   && cPathUni + <CNPJ sem pontuacao> + "\"
    this_cPathBackup   = ""   && SigCdPac.direxpsdfs ou cPathUni + "BKP\"
    this_cCnpjEmitente = ""   && SigCdEmp.cgcs sem ponto, barra e hifen
    this_cChaveAcesso  = ""   && cId - SigMvNfi.nfechv (44 posicoes)

    this_cPastaEnvio       = "envio\"
    this_cPastaEnviado     = "Enviado\"
    this_cPastaEmProc      = "Enviado\EmProcessamento\"
    this_cPastaEnvioLote   = "EnvioEmLote\"
    this_cPastaErro        = "Erro\"
    this_cPastaRetorno     = "Retorno\"
    this_cPastaValidar     = "Validar\"
    this_cPastaBkEnviados  = "BKenviados\"
    this_cPastaAssinado    = "Assinado\"
    this_cPastaValidado    = "Validado\"
    this_cPastaAutorizados = "Enviado\Autorizados\"
    this_cPastaPdf         = "PDF\"
    this_cPastaTxt         = "TXT\"

    *==========================================================================
    * CF-e do SAT (canccfe do legado) - dados lidos de SigCdEmp.textopaf
    *==========================================================================
    this_cCnpjAC        = ""   && textopaf 1..14    - CNPJ da casa de software
    this_cAssinaturaAC  = ""   && textopaf 16..359  - signAC
    this_cFabricanteSat = ""   && textopaf 361..370 - SWEDA / BEMAT / outros
    this_nCodFabricante = 0    && 3=SWEDA, 2=BEMAT, 0=demais
    this_cXmlCancelaSat = ""   && XML de cancelamento devolvido pelo SAT (pcXml no legado)

    *==========================================================================
    * Nomes dos cursores usados pelo BO e pelo Form (mantidos em property
    * para o Form nao repetir literais - mesmo padrao do SigOpNchBO)
    *==========================================================================
    this_cCursorEventos    = "cursor_4c_Eventos"     && SigMvNfd (crSigMvNfd no legado)
    this_cCursorNota       = "cursor_4c_Nota"        && SigMvNfi (crSigMvNfi)
    this_cCursorSitNFe     = "cursor_4c_SitNFe"      && SigPrNfe (crSigPrNfe)
    this_cCursorCabecalho  = "cursor_4c_Cabecalho"   && SigMvCab (crSigMvCab)
    this_cCursorOperacao   = "cursor_4c_Operacao"    && SigCdOpe + SigOpCdd/Cdc/Cdi (LocalOpe)
    this_cCursorEmpresa    = "cursor_4c_Empresa"     && SigCdEmp (LocalEmp)
    this_cCursorCliente    = "cursor_4c_Cliente"     && SigCdCli (LocalCliD)
    this_cCursorParametros = "cursor_4c_Parametros"  && SigCdPac (crSigCdPac)
    this_cCursorTagsCFe    = "cursor_4c_TagsCFe"     && CFTags - estrutura do XML do SAT

    *==========================================================================
    * Init - Configura tabela/chave principal (SigMvNfd) e os rotulos de
    *        evento que dependem de CHR() para os acentos.
    *
    * NAO faz acesso a banco: Init que retorna .F. mata o form, e o BO eh
    * instanciado tambem pelo harness de teste, sem gnConnHandle valido.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            *-- Tabela gravada por este BO: um registro por evento da nota
            THIS.this_cTabela     = "SigMvNfd"
            THIS.this_cCampoChave = "cidchaves"

            *-- Rotulos exibidos no campo GetEvento (legado: Init do form)
            THIS.this_cRotuloCancelamento = "CANCELAMENTO"
            THIS.this_cRotuloCarta        = "CARTA DE CORRE" + CHR(199) + CHR(195) + "O"

            *-- Fuso default do dhEvento: sem horario de verao o legado usa
            *-- '03:00' (IIF(thisform.verao.Value = 1, '02:00', '03:00'))
            THIS.this_cFusoHorario = "03:00"

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao inicializar SigOpNFdBO")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Valor da PK de SigMvNfd para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCidchaves, ""))
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega a linha corrente de SigMvNfd (crSigMvNfd no
    * legado - par_cAliasCursor eh tipicamente THIS.this_cCursorEventos) nas
    * properties deste BO. Mapeia TODAS as 13 colunas da tabela, na ordem do
    * schema (regra #22 do CLAUDE.md - conferido em docs/schema.sql lido com
    * Get-Content -Raw, por ser UTF-16).
    *
    * SELECT (par_cAliasCursor) primeiro, depois campo sem alias (Problema 9
    * do FORMCOR_LICOES_APRENDIDAS.md - "campo" eh sintaxe invalida
    * em VFP9).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            IF !EOF()
                THIS.this_cCidchaves  = TratarNulo(cidchaves, "")
                THIS.this_cDopes      = TratarNulo(dopes, "")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "")
                THIS.this_cEmps       = TratarNulo(emps, "")
                THIS.this_cNfedesc    = TratarNulo(nfedesc, "")
                THIS.this_dNfedte     = TratarNulo(nfedte, {/:})
                THIS.this_cNfeeve     = TratarNulo(nfeeve, "")
                THIS.this_cNfeprt     = TratarNulo(nfeprt, "")
                THIS.this_nNfeseq     = TratarNulo(nfeseq, 0)
                THIS.this_cNfexml     = TratarNulo(nfexml, "")
                THIS.this_cNfis       = TratarNulo(nfis, "")
                THIS.this_nNumes      = TratarNulo(numes, 0)
                THIS.this_cNumeroNota = TratarNulo(numeronota, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * MontarInsertEvento - Fonte UNICA do SQL de INSERT em SigMvNfd. Espelha o
    * "APPEND BLANK + Replace" do atucur() legado (linhas 564-574 do dump):
    *
    *   replace cidchaves with fUniqueIds(), nfis with crsigmvnfi.nfis,
    *           dopes with crsigmvnfi.dopes, numes with crsigmvnfi.numes,
    *           emps with crsigmvnfi.emps, empdopnums with crsigmvnfi.empdopnums,
    *           nfedte with CTOT(thisform.cntData.getData.Value),
    *           nfedesc with '', nfeeve with thisform.Evento,
    *           nfeseq with lnUltSeq in crSigMvNfd
    *
    * nfis/dopes/numes/emps/empdopnums vem das properties "Nfi" (espelham
    * crSigMvNfi - a nota de ORIGEM), nao das properties homonimas da nota
    * (que sao colunas DIFERENTES, com conteudo do proprio EVENTO).
    *
    * nfeprt char(15) NOT NULL e numeronota char(10) NOT NULL NUNCA aparecem
    * no atucur() nem em nenhum outro ponto do dump legado contra crSigMvNfd -
    * exatamente a armadilha da regra #22 (coluna invisivel no dump porque so
    * existia no buffer em branco do AddCursor). Gravar EscaparSQL("") para
    * as duas explicitamente, para nao violar o NOT NULL.
    *
    * nfedesc e nfexml sao NULL no schema. nfedesc vai com this_cNfedesc (e
    * NAO com '' literal): o '' do APPEND legado e valor INICIAL do cursor em
    * memoria - quando a linha chega de fato ao banco, pelo
    * "poDataMgr.Update([crSigMvNfd])" do Click, ela ja passou pelo "replace
    * nfedesc with lcdesc" (linhas 1406 e 1649 do dump) e carrega a
    * justificativa digitada. Gravar '' aqui perderia a descricao em todo
    * evento novo - exatamente o campo que o fluxo existe para registrar.
    * nfexml fica NULL (o legado nunca o toca antes da autorizacao; quem
    * grava o XML autorizado e Atualizar()).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertEvento()
        LOCAL loc_cSQL

        loc_cSQL = "INSERT INTO SigMvNfd (cidchaves, dopes, empdopnums, emps, " + ;
                   "nfedesc, nfedte, nfeeve, nfeprt, nfeseq, nfexml, nfis, " + ;
                   "numes, numeronota) VALUES (" + ;
                   EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmpDopNums, 29)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                   EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   FormatarDataSQL(THIS.this_dNfedte) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeeve, 3)) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNfeprt, 15)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNfeseq, 0) + ", " + ;
                   "NULL, " + ;
                   EscaparSQL(LEFT(THIS.this_cNfis, 6)) + ", " + ;
                   FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                   EscaparSQL(LEFT(THIS.this_cNumeroNota, 10)) + ")"

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * MontarUpdateEvento - Fonte UNICA do SQL de UPDATE em SigMvNfd. Espelha o
    * UNICO Update que o legado faz contra crSigMvNfd (btnSelItens.Click,
    * linhas 1405-1406 e 1648-1649 do dump, repetido nos tres caminhos de
    * envio - NFCe/Migrate nao atualiza SigMvNfd, so SAT e UniNFe):
    *
    *   replace nfexml with cConteudoxml in crSigMvNfd
    *   replace nfedesc with lcdesc in crSigMvNfd
    *
    * So essas DUAS colunas sao tocadas em algum ponto do fluxo legado depois
    * do INSERT inicial - o resto do registro (chave, nota de origem, sequencia)
    * nasce certo no atucur() e nunca muda. Atualizar nfedte/nfeprt/nfeseq aqui
    * seria regra de negocio inventada (regra #17 do CLAUDE.md).
    *==========================================================================
    PROTECTED PROCEDURE MontarUpdateEvento()
        LOCAL loc_cSQL

        loc_cSQL = "UPDATE SigMvNfd SET " + ;
                   "nfedesc = " + EscaparSQL(THIS.this_cNfedesc) + ", " + ;
                   "nfexml = " + IIF(EMPTY(THIS.this_cNfexml), "NULL", EscaparSQL(THIS.this_cNfexml)) + ;
                   " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * Inserir - INSERT de UM evento em SigMvNfd (caminho BusinessBase.Salvar e
    * o equivalente, nesta arquitetura, do atucur()/APPEND BLANK legado).
    *
    * cidchaves eh gerado AQUI quando ainda vazio, reproduzindo
    * "replace cidchaves with fUniqueIds()" - NUNCA string vazia (regra #22:
    * colidiria no indice unico do segundo evento).
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cCidchaves = fUniqueIds()
                ENDIF

                loc_cSQL = THIS.MontarInsertEvento()
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    loc_cErro = CapturarErroSQL()
                    THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                        "o do Evento da NFe." + CHR(13) + loc_cErro
                    MsgErro(THIS.this_cMensagemErro, "Erro")
                    THIS.this_lErroExibido = .T.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.Inserir")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConsultarUltimoEvento - SELECT do atucur() legado (linhas 552-558 do
    * dump):
    *
    *   lcEDN = crSigmvNfi.empdopnums
    *   lcQuery = Select * From SigMvNfd Where empdopnums = <lcEDN>
    *             and nfeEve = <thisform.Evento> order by nfeseq desc
    *
    * Carrega a linha mais recente (se houver) nas properties deste BO via
    * CarregarDoCursor. NAO faz APPEND BLANK - isso fica em
    * AtualizarUltimoEvento(), que decide se cria linha nova ou reusa esta.
    *
    * GUARDA: this_cNfiEmpDopNums (chave da nota de origem) ainda nao e
    * populada em nenhuma fase deste BO - a leitura do contexto da nota via
    * SigMvNfi (que no legado chega pela DataSession compartilhada com o
    * form pai) e a mesma pendencia ja documentada em
    * FormSigOpNFd.BtnEnviarClick e no cabecalho desta classe ("Fluxo do
    * legado... fases seguintes"). Consultar com a chave vazia casaria
    * empdopnums = '' e corromperia o diagnostico de "encontrado"/"nao
    * encontrado" - por isso o metodo nao tenta a consulta nesse caso.
    *==========================================================================
    PROCEDURE ConsultarUltimoEvento()
        LOCAL loc_lEncontrado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lEncontrado = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        TRY
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF USED(THIS.this_cCursorEventos)
                    USE IN (THIS.this_cCursorEventos)
                ENDIF

                loc_cSQL = "SELECT * FROM SigMvNfd WHERE empdopnums = " + ;
                           EscaparSQL(LEFT(THIS.this_cNfiEmpDopNums, 29)) + ;
                           " AND nfeeve = " + EscaparSQL(LEFT(THIS.this_cEvento, 3)) + ;
                           " ORDER BY nfeseq DESC"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorEventos)

                IF loc_nResultado >= 0 AND USED(THIS.this_cCursorEventos) AND !EOF(THIS.this_cCursorEventos)
                    THIS.CarregarDoCursor(THIS.this_cCursorEventos)
                    loc_lEncontrado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.ConsultarUltimoEvento")
        ENDTRY

        RETURN loc_lEncontrado
    ENDPROC

    *==========================================================================
    * AtualizarUltimoEvento - Equivalente ao atucur() legado completo (linhas
    * 548-584 do dump): consulta o ultimo evento (ConsultarUltimoEvento) e,
    * quando o evento e 'CAR' (carta de correcao sempre gera sequencia nova)
    * OU nao ha nenhum evento anterior, PREPARA a linha nova (equivalente ao
    * "APPEND BLANK + Replace" do legado). Quando acha um evento 'CAN'
    * existente, apenas REUSA os dados ja carregados por
    * ConsultarUltimoEvento (igual ao legado, que nesse caso NAO cria linha
    * nova).
    *
    * NAO PERSISTE NADA - e isso e fidelidade ao legado, nao omissao. O
    * "APPEND BLANK + replace ... in crSigMvNfd" do atucur mexe apenas no
    * CURSOR em memoria; quem grava e o Click do botao Enviar, que faz
    * "replace nfedesc with lcdesc in crSigMvNfd" e so entao
    * "poDataMgr.Update([crSigMvNfd]) + Commit()" (linhas 1406-1430 e
    * 1649-1660 do dump). Chamar Salvar() aqui gravaria um evento de
    * descricao vazia a CADA abertura do dialogo (inclusive quando o usuario
    * desiste e clica Cancelar) e um SEGUNDO registro no Enviar.
    *
    * O que este metodo deixa pronto e o MODO de gravacao do BO:
    * NovoRegistro() no ramo da linha nova (Salvar -> Inserir) e
    * EditarRegistro() no ramo de reuso (Salvar -> Atualizar). Quem dispara
    * a gravacao e FormSigOpNFd.BtnEnviarClick, com a descricao final ja
    * lida do controle.
    *
    * par_dDataHora equivale a "CTOT(thisform.cntData.getData.Value)" do
    * legado - o Form passa o valor atual do campo de data/hora, porque esta
    * e uma leitura de CONTROLE da tela (camada de UI), nao de cursor.
    *
    * Mesma guarda de ConsultarUltimoEvento: sem this_cNfiEmpDopNums nao ha
    * como montar um registro valido (emps/dopes/numes/nfis viriam vazios),
    * entao o metodo nao grava nada e devolve .F.
    *==========================================================================
    PROCEDURE AtualizarUltimoEvento(par_dDataHora)
        LOCAL loc_lEncontrado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cNfiEmpDopNums)
            RETURN .F.
        ENDIF

        loc_lEncontrado = THIS.ConsultarUltimoEvento()
        THIS.this_nUltimaSequencia = IIF(loc_lEncontrado, THIS.this_nNfeseq + 1, 1)

        IF THIS.this_cEvento = "CAR" OR !loc_lEncontrado
            THIS.NovoRegistro()

            THIS.this_cCidchaves  = ""
            THIS.this_cDopes      = THIS.this_cNfiDopes
            THIS.this_cEmpDopNums = THIS.this_cNfiEmpDopNums
            THIS.this_cEmps       = THIS.this_cNfiEmps
            THIS.this_nNumes      = THIS.this_nNfiNumes
            THIS.this_cNfis       = THIS.this_cNfiNfis
            THIS.this_cNfedesc    = ""
            THIS.this_dNfedte     = IIF(VARTYPE(par_dDataHora) = "T", par_dDataHora, {/:})
            THIS.this_cNfeeve     = THIS.this_cEvento
            THIS.this_nNfeseq     = THIS.this_nUltimaSequencia

            loc_lSucesso = .T.
        ELSE
            *-- Legado nao faz APPEND neste ramo: REUSA a linha que o SELECT
            *-- trouxe (this_cCidchaves/this_cNfedesc/this_nNfeseq/this_cNfis
            *-- ja vieram de ConsultarUltimoEvento via CarregarDoCursor), e o
            *-- "replace nfedesc ... in crSigMvNfd" do Click vira UPDATE.
            *-- EditarRegistro deixa this_lNovoRegistro = .F., que eh o que
            *-- faz BusinessBase.Salvar() rotear para Atualizar() em vez de
            *-- Inserir().
            *--
            *-- RESET do modo ANTES de EditarRegistro: BusinessBase.
            *-- EditarRegistro() RECUSA (devolve .F. com "Nao ha registro
            *-- para editar") quando this_lNovoRegistro ainda esta .T., e
            *-- este metodo eh um FUNIL que roda VARIAS vezes na mesma vida
            *-- do form - uma abertura em 'CAR'/sem evento anterior passa
            *-- pelo ramo de cima e deixa a flag ligada, e a chamada seguinte
            *-- (Refazer desmarcado, ou o atucur do fim do Enviar) cai aqui
            *-- com ela ainda ligada. Sem o reset, o ramo de reuso falharia e
            *-- o BO continuaria em modo INSERT: o Salvar seguinte gravaria
            *-- um registro DUPLICADO onde o legado faz UPDATE.
            *--
            *-- A flag eh zerada na mao, e NAO por CancelarEdicao(): aquele
            *-- chama LimparDados() quando this_lNovoRegistro esta .T., o que
            *-- apagaria as properties que ConsultarUltimoEvento acabou de
            *-- carregar do banco, logo acima.
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = THIS.EditarRegistro()
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE do evento existente em SigMvNfd (nfedesc/nfexml) -
    * caminho usado depois que a SEFAZ/SAT autoriza o evento e o XML/
    * justificativa definitivos sao conhecidos.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cErro, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de " + ;
                                          "dados indispon" + CHR(237) + "vel."
            ELSE
                IF EMPTY(THIS.this_cCidchaves)
                    THIS.this_cMensagemErro = "Evento da NFe n" + CHR(227) + ;
                        "o identificado para atualiza" + CHR(231) + CHR(227) + "o."
                ELSE
                    loc_cSQL = THIS.MontarUpdateEvento()
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResultado < 0
                        loc_cErro = CapturarErroSQL()
                        THIS.this_cMensagemErro = "Erro na Grava" + CHR(231) + CHR(227) + ;
                            "o do Evento da NFe." + CHR(13) + loc_cErro
                        MsgErro(THIS.this_cMensagemErro, "Erro")
                        THIS.this_lErroExibido = .T.
                    ELSE
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em SigOpNFdBO.Atualizar")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

