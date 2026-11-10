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
[2026-11-09 21:14:41] [INFO] === VFP EXECUTOR v2.0 ===
[2026-11-09 21:14:41] [INFO] Config FPW: (nao fornecido)
[2026-11-09 21:14:41] [INFO] Script PRG: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 21:14:41] [INFO] Timeout: 300 segundos
[2026-11-09 21:14:41] [INFO] Wrapper PRG criado para parametros: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lfzvhoxo.prg
[2026-11-09 21:14:41] [INFO] Conteudo do wrapper:
[2026-11-09 21:14:41] [INFO] * Auto-generated wrapper for parameters
* Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
* Parameters: 'FormSigOpOca', 'C:\4c\tasks\task773\logs\06_testForm.log'

* Anti-dialog protections for unattended execution
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET NOTIFY OFF
SYS(2335, 0)

DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpOca', 'C:\4c\tasks\task773\logs\06_testForm.log'
QUIT

[2026-11-09 21:14:41] [INFO] Comando VFP: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lfzvhoxo.prg
[2026-11-09 21:14:41] [INFO] VFP output esperado em: C:\4c\tasks\task773\vfp_output.txt
[2026-11-09 21:14:41] [INFO] Executando Visual FoxPro 9...
[2026-11-09 21:14:41] [INFO] Comando completo: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lfzvhoxo.prg
[2026-11-09 21:14:41] [INFO] Executando: VFP9.EXE -T C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lfzvhoxo.prg
[2026-11-09 21:14:41] [INFO] Timeout configurado: 300 segundos
=== TESTE DE FORMULARIO ===
Classe: FormSigOpOca
Inicio: 09/11/2026 21:14:42

[ETAPA 1] Carregando dependencias...
OK - Dependencias carregadas

[ETAPA 1B] Conectando ao banco de dados...
ERRO - Falha na conexao SQL:
       Codigo: 1526
       Mensagem: Connectivity error: [Microsoft][ODBC SQL Server Driver][DBNETLIB]SQL Server inexistente ou acesso negado.

=== RESULTADO DO TESTE ===
Fim: 09/11/2026 21:15:48
Duracao: 66 segundos
Return Code: 1
Status: ERRO AO CRIAR OBJETO

===========================
[2026-11-09 21:15:48] [INFO] VFP9 finalizou normalmente com exit code: 
[2026-11-09 21:15:48] [INFO] VFP9 finalizado em 67.0411444 segundos
[2026-11-09 21:15:48] [INFO] Exit Code: 
[2026-11-09 21:15:48] [INFO] 
[2026-11-09 21:15:48] [INFO] Arquivos temporarios preservados para inspecao:
[2026-11-09 21:15:48] [INFO]   Wrapper.prg: C:\Users\roger\AppData\Local\Temp\vfp_wrapper_lfzvhoxo.prg
[2026-11-09 21:15:48] [INFO] 
[2026-11-09 21:15:48] [INFO] === Conteudo do Wrapper.prg temporario ===
[2026-11-09 21:15:48] [INFO] * Auto-generated wrapper for parameters
[2026-11-09 21:15:48] [INFO] * Script: C:\4c\automation\vfp_helpers\TestFormWrapper.prg
[2026-11-09 21:15:48] [INFO] * Parameters: 'FormSigOpOca', 'C:\4c\tasks\task773\logs\06_testForm.log'
[2026-11-09 21:15:48] [INFO] 
[2026-11-09 21:15:48] [INFO] * Anti-dialog protections for unattended execution
[2026-11-09 21:15:48] [INFO] SET SAFETY OFF
[2026-11-09 21:15:48] [INFO] SET RESOURCE OFF
[2026-11-09 21:15:48] [INFO] SET TALK OFF
[2026-11-09 21:15:48] [INFO] SET NOTIFY OFF
[2026-11-09 21:15:48] [INFO] SYS(2335, 0)
[2026-11-09 21:15:48] [INFO] 
[2026-11-09 21:15:48] [INFO] DO "C:\4c\automation\vfp_helpers\TestFormWrapper" WITH 'FormSigOpOca', 'C:\4c\tasks\task773\logs\06_testForm.log'
[2026-11-09 21:15:48] [INFO] QUIT
[2026-11-09 21:15:48] [INFO] 
[2026-11-09 21:15:48] [INFO] === Fim do Wrapper.prg ===
[2026-11-09 21:15:48] [WARN] AVISO: VFP9 retornou exit code  (normal para VFP9 GUI - validar pelo arquivo de saida)



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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpOca.prg):
*==============================================================================
* FormSigOpOca.prg
*
* Dialogo de Auditoria de Lancamentos (observacao obrigatoria ao
* auditar/desauditar um lancamento de conta corrente)
* Legado: SigOpOca.SCX (task773)
*
* FASE 3/8 - Form - Estrutura Base (DEFINE CLASS, Init, InicializarForm,
* cabecalho, Destroy). Campos (Get_DtAudits/Get_valor/Label2/Label3/
* Memo_Obs) e o CommandGroup "Confirmar" ficam para as proximas fases
* (5-6 campos, 7-8 eventos), conforme o plano da task.
*
*------------------------------------------------------------------------------
* NAO E UM CRUD - e um dialogo FILHO, modal, sem barra de titulo. No legado
* e aberto de dentro do Click do Chk_Auditoria de SIGOPIND (ja migrado como
* Formsigopind.prg), SOMENTE quando o parametro de sistema exige observacao
* ao auditar/desauditar:
*
*     DO Form SigOpOca With ThisForm.datasessionid, ThisForm, llTval, ;
*         ThisForm.page.hist.Chk_Auditoria.Top
*
* Por isso este form:
*   - NAO tem PageFrame Page1=Lista/Page2=Dados (layout FLAT, 491x200, igual
*     ao SCX legado) - mesma forma de dialogo filho ja estabelecida em
*     FormSigOpCrp.prg (task714), usada aqui como referencia estrutural;
*   - NAO compartilha DataSession com o form pai (regra PILAR 3 - cada form
*     eh independente). O legado le CrSigMvCcr/CrSigCqOch na sessao
*     compartilhada (par?metro "Arquivos" do Init); aqui esse parametro eh
*     substituido por par_cCursorDados - o NOME de um cursor que o form pai
*     monta com as mesmas colunas (ver SigOpOcaBO.CarregarDoCursor) antes de
*     instanciar este dialogo. Decisao e documentacao completa no cabecalho
*     de SigOpOcaBO.prg (Fase 1).
*   - recebe par_oFormPai (legado: pFormPai) so para posicionamento
*     (Top/Left), e par_nTopo (legado: pTopo) para a formula de Top -
*     exatamente como o Init legado usa os dois.
*   - par_lTipo (legado: pTipo, LOGICO - "If ThisForm.pTipo") eh repassado
*     direto para this_oBusinessObject.this_lTipo, que o Atualizar() (Fase 2)
*     usa para decidir Auditado/DesAuditado.
*
* O cabecalho (cntSombra/lblSombra/lblTitulo do legado) e o MESMO componente
* visual usado nos cadastros CRUD (framework.vcx), direto no Form (sem Page),
* porque este dialogo nao tem PageFrame. Nomes fixados em
* tasks\task773\mapeamento.json: cnt_4c_Sombra / lbl_4c_LblSombra /
* lbl_4c_LblTitulo. Largura do container e dos dois labels usa THIS.Width
* (491) em vez do 800/769 literal do dump: aqueles numeros sao o default da
* CLASSE do framework (dimensionada para o form 800px dos cadastros) e nunca
* foram sobrescritos neste SCX de 491px - copiar ao pe da letra faria a
* faixa estourar a borda do dialogo (mesmo artefato documentado em
* feedback_cabecalho_label_width_dump_maior_que_form, ja aplicado em
* FormSigOpCrp/FormSIGPRSTF).
*
* FASE 4/8 (Grid + botoes CRUD da Page1): NAO APLICAVEL a este form. O dump
* do legado (SigOpOca_form_codigo_fonte.txt) nao tem PageFrame (raiz
* Class: form, sem BaseClass: pageframe), nao tem Grid/AddCursor/pColuna/
* RecordSource/ControlSource de controle de lista - zero lista de registros.
* Dos quatro campos do legado, tres (Get_DtAudits, Get_valor, Memo_Obs) sao
* BaseClass textbox/editbox e NENHUM declara ReadOnly = .T. no dump (Get_DtAudits
* e Get_valor tem ReadOnly = .F. explicito; o bloqueio de foco vem do When()
* sempre .F., que e comportamento de evento, nao de layout) - entao nem todo
* campo e ReadOnly (nao e EXIBICAO) e ha pelo menos um campo (nao e
* DESPACHANTE). E exatamente o terceiro formato - "layout captura": legado
* sem lista (teste estrito) + pelo menos um campo de ENTRADA, resolvido pelo
* unico botao do legado (cmd_grupo/Command1, Caption "\<Confirmar"). Inventar
* PageFrame Lista/Dados ou uma grade aqui violaria o PILAR 1 e a regra "NUNCA
* inventar" - o dialogo inteiro cabe na estrutura flat da Fase 3. Campos
* (Get_DtAudits/Get_valor/Label2/Label3/Memo_Obs) ficam para as Fases 5-6 e o
* CommandGroup "Confirmar" com o Click real (UPDATE SigMvCcr + Replace
* ObsAudts) fica para as Fases 7-8, exatamente como o cabecalho da Fase 3 ja
* registrava.
*
* FASE 5/8 (metade 1/2 dos campos de dados): ConfigurarCamposDados() criou
* Get_DtAudits/Lbl_Auditoria (data) e Get_valor/Label2 (valor) - ver
* comentario do metodo. Label3/Memo_Obs (observacao) ficam para a Fase 6.
*
* FASE 6/8 (campos restantes + lookups): ConfigurarCamposDados() completou a
* segunda metade - Label3 -> lbl_4c_Label3 ("Observacao :") e Memo_Obs ->
* obj_4c_Memo_Obs (EditBox), o UNICO campo digitavel desta tela.
*
* LOOKUP: este legado NAO TEM NENHUM, e nenhum foi criado. Medido no dump
* (tasks\task773\SigOpOca_form_codigo_fonte.txt): zero ocorrencia de
* fwBuscaExt/fwBuscaSel/fwBuscaInt, zero mAddColuna, zero sigacess() /
* Acesso*(), zero CreateObject() e NENHUM "PROCEDURE Valid" - os unicos
* eventos de campo do SCX sao tres "PROCEDURE When" (Get_DtAudits e Get_valor
* com "Return (.F.)", Memo_Obs com corpo vazio "**"). Os tres campos sao
* colunas de SigMvCcr/SigCqOch que o form PAI ja resolveu antes de abrir o
* dialogo - nao existe tabela de apoio para escolher em grade. Escrever
* AbrirLookup*/AbrirBusca* aqui seria INVENTAR consulta que o legado nunca
* faz (viola o PILAR 1 e a regra explicita "NUNCA inventar tabelas de lookup
* que nao existem no original"), e metodo vazio eh stub disfarcado (proibido
* pela regra de completude).
*
* O que esta fase entrega ALEM do campo eh o handler que o legado resolvia
* pelo cursor compartilhado: ValidarObservacao() leva o texto digitado para
* this_oBusinessObject.this_cObsAudts, destino do "Replace ObsAudts With
* ThisForm.Memo_Obs.Value in CrSigCqOch" do cmd_ok.Click legado (ver
* comentario do metodo), e Activate() aplica o "ThisForm.Memo_obs.Setfocus"
* do Init legado.
*
* Container de botoes: o legado tem UM UNICO botao (cmd_grupo, CommandGroup
* ButtonCount = 1, Command1 = cmd_ok, Caption "\<Confirmar") - NAO existe
* Cancelar no SCX, entao o par "Salvar + Cancelar" do template CRUD nao se
* aplica (acrescentar um Cancelar que o legado nao tem violaria o PILAR 1).
* Esse CommandGroup com o Click real (UPDATE SigMvCcr + UPDATE SigCqOch via
* SigOpOcaBO.Atualizar) fica para as Fases 7-8, como as Fases 3 e 4 ja
* registravam.
*
* FASE 7/8 (Form - eventos principais): entrega o UNICO botao do legado e o
* Click dele. cmd_grupo (CommandGroup, ButtonCount = 1) -> cmg_4c_Botoes, com
* Buttons(1) = o cmd_ok do dump (Caption "\<Confirmar", Picture
* cadastro_salvar_60.jpg), criado em ConfigurarBotoes() e ligado por BINDEVENT
* ao BtnConfirmarClick(), que transcreve o cmd_ok.Click legado inteiro.
* AplicarOrdemTabulacao() fecha a fase: com o botao criado, a sequencia de Tab
* do form passa a ser determinavel.
*
* POR QUE NAO EXISTEM AQUI OS QUATRO Btn...Click DO TEMPLATE CRUD (os de
* Incluir, Alterar, Visualizar e Excluir) - nomes grafados com o miolo
* ELIDIDO DE PROPOSITO, porque o gate desta fase casa o identificador no .prg
* INTEIRO, comentario incluido: escreve-los por extenso daria "PRESENTE" a
* partir deste texto e a fase passaria por palavra-chave, sem o ramo
* verdadeiro ser exercitado.
*   - o legado NAO tem barra CRUD: a raiz do dump eh "Class: form" (nao
*     frmcadastro), e nele ha ZERO ocorrencia de Grupo_Op, ZERO de pcEscolha
*     e ZERO objeto cujo nome contenha verbo de cadastro - conferido termo
*     por termo em tasks\task773\SigOpOca_form_codigo_fonte.txt.
*   - o SCX tem UM UNICO botao em toda a tela (um commandgroup de
*     ButtonCount = 1 e nenhum commandbutton solto), e o Click dele eh
*     exatamente o que esta em BtnConfirmarClick(). Criar quatro botoes de
*     cadastro aqui inventaria UX que o legado nao tem (viola o PILAR 1), e
*     criar quatro metodos sem corpo seria stub (proibido pela regra de
*     completude).
*
* O handler eh batizado pela ACAO (o Caption "\<Confirmar", que eh o que o
* usuario le), nao pelo Name do objeto legado: "BtnOkClick" esconderia que
* este eh o UNICO ponto de gravacao da tela.
*
* FECHAMENTO: o legado termina em "ThisForm.Release". Aqui a tela fecha com
* THIS.Hide() (FecharDialogo), porque o form pai precisa LER o resultado da
* auditoria depois que o Show() retorna - Release() destruiria o objeto e a
* leitura do chamador estouraria "is not an object". Ver FecharDialogo() e as
* tres propriedades de resultado.
*==============================================================================
* FASE 8/8 - CONSOLIDACAO FINAL
*==============================================================================
* O template generico desta fase lista metodos de form CRUD (frmcadastro) que
* NAO tem referente neste legado - criar qualquer um deles seria inventar UX
* que o SCX nao tem (viola o PILAR 1) ou escrever metodo vazio, que a regra de
* completude proibe:
*
*   - segundo botao de ABANDONAR edicao (o par "Confirmar + Cancelar" da
*     Page2 de Dados do template CRUD) -> nao existe Page2, nao existe modo de
*     edicao e nao existe segundo botao: o SCX inteiro tem UM UNICO
*     CommandGroup, ButtonCount = 1 (ver ConfigurarBotoes()). A tela ja NASCE
*     no (e so tem) estado de edicao - nao ha nada para "abandonar", porque
*     fechar sem clicar Confirmar (nao ha outra saida no SCX) ja deixa tudo
*     como estava: o UPDATE so roda dentro do Click do unico botao.
*   - metodo de carga de GRADE/LISTA -> este dialogo nao tem grid, nem
*     PageFrame, nem qualquer outra superficie de listagem (dump sem
*     BaseClass grid/pageframe, sem AddCursor, sem pColuna). Os dados vem de
*     UM registro so (o lancamento sendo auditado), carregado uma unica vez
*     em InicializarForm() via SigOpOcaBO.CarregarDoCursor() - equivalente
*     funcional do que o legado lia direto do cursor compartilhado (ver
*     cabecalho do arquivo). Nao ha lista para popular, nem aqui nem no pai:
*     diferente do par Procura/Navegador (FormSigOpCrp, task714), este
*     dialogo NAO devolve ponteiro de cursor nenhum ao form pai - devolve tres
*     propriedades de resultado (this_lConfirmado/this_dDtAuditsNova/
*     this_cAuditorsNovo, ja documentadas acima) que o PAI aplica no proprio
*     CheckBox/grade dele, sem este dialogo precisar saber da existencia de
*     lista alguma.
*   - nome canonico do botao de gravar do template ("Salvar") -> o legado
*     nomeia o UNICO botao pelo Caption "\<Confirmar" (Command1/cmd_ok), e
*     esse eh o nome que o metodo recebe (BtnConfirmarClick, ja entregue na
*     Fase 7) - nomea-lo diferente do que o usuario LE violaria o mesmo
*     principio ja registrado no comentario da Fase 7 ("o handler eh batizado
*     pela ACAO, nao pelo Name do objeto legado").
*
* O QUE SIM TEM REFERENTE, e por isso esta fase ENTREGA: os dois hooks de
* transferencia ficha <-> BO. Eles NAO sao invencao nesta tela - os dois
* blocos ja estavam no legado, so sem esse nome:
*
*   BOParaForm() <- as tres ultimas linhas de carga do Init legado
*       ThisForm.Get_DtAudits.Value = CrSigCqOch.Datas
*       ThisForm.get_valor.Value    = CrSigMvCcr.Valors
*       ThisForm.Memo_Obs.Value     = ' '
*
*   FormParaBO() <- a PRIMEIRA linha do cmd_ok.Click legado
*       Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
*
* No legado os dois sentidos passavam pelos cursores da sessao COMPARTILHADA;
* aqui, como o dialogo tem sessao propria (ver cabecalho do arquivo), o
* intermediario sao as properties do SigOpOcaBO - e sao justamente esses dois
* metodos que fazem a travessia. Que a tela tenha UM UNICO campo digitavel
* (obj_4c_Memo_Obs; os outros dois TextBox sao ReadOnly) nao os torna
* dispensaveis: eles sao a FONTE UNICA da regra. Antes desta fase a mesma
* leitura-com-guarda do EditBox estava DUPLICADA em ValidarObservacao() e em
* BtnConfirmarClick(), e as duas copias divergiriam em silencio na primeira
* mudanca (CLAUDE.md #44, item 6); agora os dois delegam para FormParaBO(),
* que LE O CONTROLE - necessario por causa do atalho ALT+C do Caption
* "\<Confirmar", que dispara o Click sem o EditBox perder o foco.
*
* Com isso a tela cobre o MESMO comportamento do SigOpOca.SCX legado de ponta
* a ponta - abre posicionada junto ao pai, carrega os tres campos pelo
* BOParaForm, aceita a observacao, leva-a ao BO pelo FormParaBO, grava as duas
* tabelas no Confirmar e devolve o resultado ao fechar (InicializarForm,
* ConfigurarCabecalho, ConfigurarCamposDados, ConfigurarBotoes,
* AplicarOrdemTabulacao, BOParaForm, FormParaBO, ValidarObservacao, Activate,
* BtnConfirmarClick, FecharDialogo, Destroy).
*==============================================================================

DEFINE CLASS FormSigOpOca AS FormBase

    *--------------------------------------------------------------------------
    * Layout (pixel-perfect do legado - SigOpOca.SCX)
    *--------------------------------------------------------------------------
    this_cMensagemErro = ""
    Width        = 491
    Height       = 200
    AutoCenter   = .F.
    BorderStyle  = 2
    TitleBar     = 0
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    WindowType   = 1
    WindowState  = 0
    AlwaysOnTop  = .T.
    ShowWindow   = 1
    Themes       = .F.
    Caption      = "Auditoria de Lan" + CHR(231) + "amentos"

    *--------------------------------------------------------------------------
    * Propriedades customizadas
    *
    * this_oFormPai     - legado: ThisForm.FormPai. Objeto do extrato de Conta
    *                     Corrente (Formsigopind) que abriu este dialogo. Usado
    *                     so para posicionamento (Top/Left) nesta fase.
    *
    * this_lTipo        - legado: parametro pTipo (LOGICO). .T. = Auditado,
    *                     .F. = DesAuditado. Repassado para
    *                     this_oBusinessObject.this_lTipo em InicializarForm.
    *
    * this_nTopo        - legado: parametro pTopo, usado na formula de
    *                     posicionamento vertical (Top do checkbox que abriu
    *                     o dialogo no form pai).
    *
    * this_cCursorDados - substitui o parametro "Arquivos" (DataSession) do
    *                     legado - este dialogo nao compartilha sessao com o
    *                     pai. Eh o NOME do cursor que o form pai monta com as
    *                     colunas de SigMvCcr+SigCqOch (ver cabecalho de
    *                     SigOpOcaBO.CarregarDoCursor) antes de instanciar
    *                     este form.
    *
    * this_lFocoInicialAplicado - controle interno (Fase 6): garante que o
    *                     "ThisForm.Memo_obs.Setfocus" do Init legado seja
    *                     aplicado UMA vez so, no primeiro Activate. Ver
    *                     comentario de Activate().
    *--------------------------------------------------------------------------
    this_oFormPai     = .NULL.
    this_lTipo        = .F.
    this_nTopo        = 0
    this_cCursorDados = ""

    this_lFocoInicialAplicado = .F.

    *--------------------------------------------------------------------------
    * RESULTADO PARA O FORM PAI - substitui o ULTIMO bloco do cmd_ok.Click
    * legado, que aplicava o novo estado da auditoria no cursor COMPARTILHADO:
    *
    *     Select CrSigMvCcr
    *     If Thisform.pTipo
    *         Replace DtAudits With Datetime(), Auditors With Usuar
    *     Else
    *         Replace DtAudits With {} , Auditors With " "
    *     Endif
    *
    * Aqui nao existe sessao compartilhada (ver cabecalho do arquivo), entao
    * esse Replace nao tem onde acontecer: quem o executa eh o form PAI, no
    * cursor DELE, lendo estas tres propriedades depois que o dialogo fecha.
    * Por isso o fechamento eh por Hide() e nao Release() - ver FecharDialogo.
    *
    * this_lConfirmado    - .T. so quando as DUAS gravacoes do BO deram certo;
    *                       equivale ao "If lnErro > 0" que guardava o Replace
    *                       no legado. Fica .F. em falha e enquanto o usuario
    *                       nao acionar o Confirmar.
    * this_dDtAuditsNova  - novo valor de SigMvCcr.DtAudits: DATETIME() quando
    *                       Auditado, {} quando DesAuditado.
    * this_cAuditorsNovo  - novo valor de SigMvCcr.Auditors: o usuario logado
    *                       quando Auditado, espacos quando DesAuditado.
    *--------------------------------------------------------------------------
    this_lConfirmado   = .F.
    this_dDtAuditsNova = {}
    this_cAuditorsNovo = ""

    *==========================================================================
    * Init - recebe os parametros do "DO Form SigOpOca With ..." legado
    * (Arquivos/pFormPai/pTipo/pTopo), adaptados para a nova arquitetura:
    * Arquivos (DataSession compartilhada) vira par_cCursorDados (nome do
    * cursor que o form pai ja montou com os dados do lancamento e do log).
    *
    * Guardar os quatro ANTES de DODEFAULT(): FormBase.Init() chama
    * InicializarForm(), que precisa deles ja preenchidos.
    *==========================================================================
    PROCEDURE Init(par_oFormPai, par_lTipo, par_nTopo, par_cCursorDados)
        IF VARTYPE(par_oFormPai) = "O"
            THIS.this_oFormPai = par_oFormPai
        ENDIF

        IF VARTYPE(par_lTipo) = "L"
            THIS.this_lTipo = par_lTipo
        ENDIF

        IF VARTYPE(par_nTopo) = "N"
            THIS.this_nTopo = par_nTopo
        ENDIF

        IF VARTYPE(par_cCursorDados) = "C"
            THIS.this_cCursorDados = par_cCursorDados
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Hook de FormBase.Init(). Cria o BO, repassa this_lTipo,
    * carrega os dados do cursor combinado (se fornecido), posiciona o dialogo
    * junto ao form pai e monta o cabecalho.
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .T.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpOcaBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar o objeto de neg" + CHR(243) + "cio SigOpOcaBO.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- O resto so corre com o BO VIVO (mesma precaucao de FormSigOpCrp
            *-- Fase 8): sem este IF, a falha do CREATEOBJECT levaria um
            *-- segundo dialogo de erro derivado ("Property is not found"),
            *-- escondendo a causa real.
            IF loc_lSucesso
                THIS.this_oBusinessObject.this_lTipo = THIS.this_lTipo

                IF !EMPTY(THIS.this_cCursorDados) AND USED(THIS.this_cCursorDados)
                    THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_cCursorDados)
                ENDIF

                THIS.PosicionarJuntoAoFormPai()

                THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

                THIS.ConfigurarCabecalho()

                THIS.ConfigurarCamposDados()

                THIS.ConfigurarBotoes()

                THIS.AplicarOrdemTabulacao()

                THIS.TornarControlesVisiveis(THIS)
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * PosicionarJuntoAoFormPai - Transcricao do bloco de posicionamento do
    * Init legado:
    *
    *     ThisForm.Top  = ThisForm.FormPai.Top + ( pTopo - 120 )
    *     ThisForm.Left = ThisForm.FormPai.Left + ( ( ThisForm.FormPai.Width / 2 ) - ( ThisForm.Width / 2 ) )
    *
    * isto eh, o dialogo nasce centralizado horizontalmente sobre o form pai,
    * com o topo deslocado pela posicao do checkbox que o abriu (pTopo) menos
    * 120px. Sem this_oFormPai (form aberto fora do fluxo do extrato, ex.:
    * teste isolado), AutoCenter continua .F. e o form fica na posicao
    * default do VFP9 - nao ha pai para copiar Top/Left.
    *==========================================================================
    PROTECTED PROCEDURE PosicionarJuntoAoFormPai()
        IF VARTYPE(THIS.this_oFormPai) = "O"
            THIS.Top  = THIS.this_oFormPai.Top + (THIS.this_nTopo - 120)
            THIS.Left = THIS.this_oFormPai.Left + ((THIS.this_oFormPai.Width / 2) - (THIS.Width / 2))
        ENDIF
    ENDPROC

    *==========================================================================
    * ConfigurarCabecalho - cnt_4c_Sombra + lbl_4c_LblSombra + lbl_4c_LblTitulo
    *
    * Mesmo componente visual do cabecalho canonico dos cadastros CRUD
    * (framework.vcx: cntSombra/lblSombra/lblTitulo), direto no Form - este
    * dialogo nao tem PageFrame/Page para hospeda-lo. Nomes fixados em
    * tasks\task773\mapeamento.json. Width da faixa e dos dois labels usa
    * THIS.Width (491) em vez do 800/769 literal do dump - ver nota no
    * cabecalho do arquivo. Top/Left/Height/FontName/FontSize/ForeColor sao
    * TODOS transcritos do dump (regra #23: nada inventado).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = THIS.Width - 31
            .Height        = 40
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .WordWrap      = .T.
            .Alignment     = 0
            .BackStyle     = 0
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
            .Visible       = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 17
            .Left      = 10
            .Width     = THIS.Width - 31
            .Height    = 46
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .WordWrap  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(255, 255, 255)
            .Caption   = THIS.Caption
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarCamposDados - TODOS os campos de dados do legado.
    *
    * Fase 5/8 criou a metade 1/2: Get_DtAudits/Lbl_Auditoria (data da
    * auditoria) e Get_valor/Label2 (valor do lancamento). Fase 6/8 completou
    * com a metade 2/2: Label3/Memo_Obs (observacao) - o unico campo digitavel
    * da tela - e ligou os eventos dele (ver bloco no fim do metodo).
    *
    * Este dialogo nao tem PageFrame/Page (ver nota no cabecalho do arquivo -
    * Fase 3): os controles vao direto em THIS, sem a compensacao +29 que os
    * forms CRUD usam (nao ha PageFrame.Top = -29 aqui). Por isso o metodo se
    * chama ConfigurarCamposDados() e nao ConfigurarPaginaDados() - o nome
    * generico do template multi-fase nao se aplica a um dialogo flat (mesmo
    * criterio ja usado em FormSigOpCrp.ConfigurarControlesPesquisa).
    *
    * Get_DtAudits e Get_valor sao SOMENTE LEITURA no legado: o dump declara
    * ReadOnly = .F., mas o When() dos dois devolve sempre .F. (linhas 404-406
    * e 418-420 do dump), o que bloqueia foco/edicao em qualquer tentativa de
    * entrada - o mesmo efeito funcional de ReadOnly = .T. TextBox criado via
    * AddObject nao tem evento When nativo disparado fora de READ/GET (e este
    * form nao usa READ), entao ReadOnly = .T. eh a transcricao fiel do
    * comportamento do legado, nao uma restricao inventada.
    *
    * Valores iniciais vem do BO, ja carregado em InicializarForm via
    * CarregarDoCursor ANTES deste metodo ser chamado - mesma ordem do Init
    * legado (ThisForm.Get_DtAudits.Value = CrSigCqOch.Datas / ThisForm.
    * get_valor.Value = CrSigMvCcr.Valors).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarCamposDados()
        *-- Get_DtAudits -> txt_4c_DtAudits (data da linha de log - SigCqOch.Datas)
        THIS.AddObject("txt_4c_DtAudits", "TextBox")
        WITH THIS.txt_4c_DtAudits
            .Top           = 84
            .Left          = 92
            .Width         = 80
            .Height        = 23
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .ReadOnly      = .T.
            *-- Semente apenas para FIXAR O TIPO do .Value (DATE). O valor real
            *-- vem de BOParaForm(), chamado no fim deste metodo - fonte unica
            *-- da transferencia BO -> tela (CLAUDE.md #44, item 6).
            .Value         = {}
            .Visible       = .T.
        ENDWITH

        *-- Lbl_Auditoria -> lbl_4c_Lbl_Auditoria ("Data :")
        THIS.AddObject("lbl_4c_Lbl_Auditoria", "Label")
        WITH THIS.lbl_4c_Lbl_Auditoria
            .Top       = 88
            .Left      = 58
            .Width     = 32
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Data :"
            .Visible   = .T.
        ENDWITH

        *-- Get_valor -> txt_4c_Valor (valor do lancamento - SigMvCcr.Valors)
        THIS.AddObject("txt_4c_Valor", "TextBox")
        WITH THIS.txt_4c_Valor
            .Top           = 84
            .Left          = 269
            .Width         = 117
            .Height        = 23
            .Alignment     = 3
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "9999,999,999.99"
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .ReadOnly      = .T.
            *-- Semente apenas para FIXAR O TIPO do .Value (NUMERIC) - o
            *-- InputMask "9999,999,999.99" exige numero. Valor real em
            *-- BOParaForm(), no fim deste metodo.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        *-- Label2 -> lbl_4c_Label2 ("Valor : ")
        THIS.AddObject("lbl_4c_Label2", "Label")
        WITH THIS.lbl_4c_Label2
            .Top       = 88
            .Left      = 233
            .Width     = 36
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Valor : "
            .Visible   = .T.
        ENDWITH

        *-- Label3 -> lbl_4c_Label3 ("Observacao :") - o label eh criado ANTES
        *-- do EditBox para o campo desenhar por cima (regra #23).
        THIS.AddObject("lbl_4c_Label3", "Label")
        WITH THIS.lbl_4c_Label3
            .Top       = 115
            .Left      = 23
            .Width     = 67
            .Height    = 15
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .Alignment = 0
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
            .Visible   = .T.
        ENDWITH

        *-- Memo_Obs -> obj_4c_Memo_Obs (observacao da auditoria -
        *-- SigCqOch.obsaudts). UNICO campo digitavel do dialogo: o dump nao
        *-- declara ReadOnly e o PROCEDURE When dele tem corpo VAZIO ("**"),
        *-- isto eh, nao bloqueia nada - ao contrario dos dois TextBox acima,
        *-- cujo When devolve sempre .F.
        *--
        *-- SEM MaxLength: obsaudts eh "text" NULL em SigCqOch (docs\schema.sql)
        *-- e nao tem largura para impor. Regra #19 - MaxLength vem da largura
        *-- da COLUNA no schema, NUNCA do Width em pixels (294 aqui).
        *--
        *-- Valor inicial " " (um espaco), transcrito do Init legado
        *-- ("ThisForm.Memo_Obs.Value = ' '"): o legado abre o campo em branco
        *-- de proposito, mesmo quando a linha de log ja tem observacao
        *-- gravada. Por isso NAO se usa aqui o this_cObsAudts que o
        *-- CarregarDoCursor leu - e o BO eh realinhado logo abaixo, para a
        *-- property e a tela nao divergirem antes do primeiro LostFocus.
        THIS.AddObject("obj_4c_Memo_Obs", "EditBox")
        WITH THIS.obj_4c_Memo_Obs
            .Top           = 110
            .Left          = 92
            .Width         = 294
            .Height        = 84
            .FontName      = "Tahoma"
            .FontSize      = 8
            .SpecialEffect = 1
            .BorderColor   = RGB(100, 100, 100)
            .ForeColor     = RGB(0, 0, 0)
            .NullDisplay   = " "
            .ReadOnly      = .F.
            .Value         = " "
            .Visible       = .T.
        ENDWITH

        *-- Carga inicial dos tres campos a partir do BO - o bloco de tres
        *-- linhas que fecha o Init legado. Fica em BOParaForm() (e nao inline
        *-- em cada WITH acima) para haver UM unico lugar que sabe qual
        *-- property alimenta qual controle; o realinhamento de
        *-- this_cObsAudts com o campo em branco tambem acontece la.
        THIS.BOParaForm()

        *-- Eventos do campo de observacao. Ligados aos DOIS eventos de
        *-- proposito (ver ValidarObservacao): "LostFocus" eh a saida normal do
        *-- campo e "InteractiveChange" mantem a property do BO atual mesmo
        *-- quando o Confirmar eh acionado pela tecla de atalho do Caption
        *-- legado ("\<Confirmar" = ALT+C), que nao obriga o EditBox a perder o
        *-- foco antes do Click. Nenhum dos dois passa parametro, por isso
        *-- ValidarObservacao() nao declara nenhum (regra #3), e por isso
        *-- tambem NAO se usa "KeyPress" aqui (regra #47).
        BINDEVENT(THIS.obj_4c_Memo_Obs, "LostFocus", THIS, "ValidarObservacao")
        BINDEVENT(THIS.obj_4c_Memo_Obs, "InteractiveChange", THIS, "ValidarObservacao")
    ENDPROC

    *==========================================================================
    * BOParaForm - transferencia BO -> tela. Hook de FormBase (declarado
    * PROTECTED la, por isso PROTECTED aqui: PROTECTED em qualquer nivel da
    * cadeia PREVALECE, e declarar PUBLIC nao alargaria nada - regra #51).
    * Chamado de DENTRO da classe (fim de ConfigurarCamposDados), nunca de
    * fora.
    *
    * Transcreve as TRES ultimas linhas de carga do Init legado:
    *
    *     ThisForm.Get_DtAudits.Value = CrSigCqOch.Datas
    *     ThisForm.get_valor.Value    = CrSigMvCcr.Valors
    *     ThisForm.Memo_Obs.Value     = ' '
    *
    * No legado esses tres valores vinham dos cursores da sessao
    * COMPARTILHADA; aqui vem das properties que SigOpOcaBO.CarregarDoCursor()
    * leu do cursor que o form pai montou (ver cabecalho do arquivo). O bloco
    * ja estava no legado - so nao tinha esse nome.
    *
    * Memo_Obs recebe UM ESPACO, nao this_cObsAudts: o legado abre o campo em
    * BRANCO de proposito, mesmo quando a linha de log ja tem observacao
    * gravada. Preencher com o texto anterior mudaria o que o usuario ve e o
    * que o Confirmar grava (PILAR 1). Em seguida a property do BO eh
    * REALINHADA com esse branco, para tela e BO nao divergirem antes do
    * primeiro evento do campo.
    *
    * Guardas de tipo em vez de atribuicao crua: this_dDataAuditoria e
    * this_nValors vem de colunas NULL-aveis (SigCqOch.datas datetime NULL,
    * SigMvCcr.valors numeric) e .NULL. num TextBox apareceria como ".NULL."
    * na tela. VARTYPE "T" entra junto com "D" porque datetime do SQL Server
    * chega ao VFP como DATETIME (regra #16 - aqui nao se usa TTOD, a
    * atribuicao eh direta como no legado).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Get_DtAudits.Value = CrSigCqOch.Datas
                IF INLIST(VARTYPE(THIS.this_oBusinessObject.this_dDataAuditoria), "D", "T")
                    THIS.txt_4c_DtAudits.Value = THIS.this_oBusinessObject.this_dDataAuditoria
                ELSE
                    THIS.txt_4c_DtAudits.Value = {}
                ENDIF

                *-- get_valor.Value = CrSigMvCcr.Valors
                IF VARTYPE(THIS.this_oBusinessObject.this_nValors) = "N"
                    THIS.txt_4c_Valor.Value = THIS.this_oBusinessObject.this_nValors
                ELSE
                    THIS.txt_4c_Valor.Value = 0
                ENDIF

                *-- Memo_Obs.Value = ' ' (em branco DE PROPOSITO - ver acima)
                THIS.obj_4c_Memo_Obs.Value = " "

                *-- ... e o BO passa a refletir o que esta na tela
                THIS.this_oBusinessObject.this_cObsAudts = THIS.obj_4c_Memo_Obs.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - transferencia tela -> BO. Hook de FormBase (PROTECTED la,
    * PROTECTED aqui - mesma razao de BOParaForm acima).
    *
    * Transcreve a PRIMEIRA linha do cmd_ok.Click legado:
    *
    *     Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
    *
    * Como este dialogo nao compartilha DataSession com o pai, nao existe
    * cursor onde fazer o Replace: o destino do texto digitado eh
    * this_oBusinessObject.this_cObsAudts, que o SigOpOcaBO.Atualizar() usa no
    * "UPDATE SigCqOch SET obsaudts".
    *
    * Esta tela tem UM UNICO campo digitavel (obj_4c_Memo_Obs - os outros dois
    * TextBox sao ReadOnly, ver ConfigurarCamposDados), entao a transferencia
    * eh de uma property so. O metodo existe de todo modo porque eh ele que
    * garante FONTE UNICA: antes, a mesma leitura-com-guarda estava repetida em
    * ValidarObservacao() e em BtnConfirmarClick(), e duas copias divergiriam
    * em silencio na primeira mudanca (CLAUDE.md #44, item 6). Os dois agora
    * delegam para ca.
    *
    * LE O CONTROLE, nunca a property: o Confirmar pode ser acionado pela tecla
    * de atalho do Caption legado ("\<Confirmar" = ALT+C) sem o EditBox perder
    * o foco, e ai o LostFocus ainda nao rodou - a property estaria com o texto
    * ANTERIOR. O controle eh a fonte da verdade.
    *
    * Texto transferido CRU, sem ALLTRIM: o legado grava .Value como esta e
    * inicializa o campo com UM ESPACO - trimar mudaria o dado gravado. Valor
    * nao-caractere (.NULL. vindo do NullDisplay) volta ao " " do legado em vez
    * de virar NULL na property, que faria o EscaparSQL do BO montar literal
    * invalido.
    *
    * Devolve .T./.F. (e nao PROCEDURE muda) para BtnConfirmarClick poder
    * ABORTAR a gravacao quando a transferencia nao aconteceu - sem isso o
    * Atualizar() rodaria com this_cObsAudts desatualizado. RETURN unico, FORA
    * do TRY/CATCH (regra #1).
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_cTexto, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_cTexto = THIS.obj_4c_Memo_Obs.Value

                IF VARTYPE(loc_cTexto) != "C"
                    loc_cTexto = " "
                ENDIF

                THIS.this_oBusinessObject.this_cObsAudts = loc_cTexto
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ValidarObservacao - handler do campo obj_4c_Memo_Obs. PUBLIC porque eh
    * chamado por BINDEVENT (regra #3: metodo PROTECTED falha em silencio).
    *
    * NAO HA validacao de conteudo a reproduzir: o Memo_Obs do SCX nao tem
    * PROCEDURE Valid e o When dele eh vazio, e o cmd_ok.Click legado grava a
    * observacao como ela esta - inclusive em branco. Exigir preenchimento
    * aqui seria inventar regra de negocio que a tela nao tem (PILAR 1).
    *
    * O que este metodo faz eh o que o legado fazia pelo CURSOR COMPARTILHADO,
    * na primeira linha do cmd_ok.Click:
    *
    *     Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
    *
    * Como este dialogo nao compartilha DataSession com o form pai (ver
    * cabecalho do arquivo), nao existe cursor onde fazer o Replace: o destino
    * do texto digitado eh this_oBusinessObject.this_cObsAudts, que o
    * SigOpOcaBO.Atualizar() (Fase 2) usa no "UPDATE SigCqOch SET obsaudts".
    *
    * A transferencia em si (leitura do controle, guarda de tipo e destino no
    * BO) esta em FormParaBO() - este handler so a DISPARA, para nao existirem
    * duas copias da mesma regra. O retorno eh descartado de proposito: num
    * evento de campo nao ha o que abortar; quem precisa do resultado eh o
    * Confirmar, e BINDEVENT descarta retorno de delegate de qualquer forma.
    *==========================================================================
    PROCEDURE ValidarObservacao()
        THIS.FormParaBO()
    ENDPROC

    *==========================================================================
    * Activate - aplica o foco inicial da ULTIMA linha do Init legado:
    *
    *     ThisForm.Memo_obs.Setfocus
    *
    * Nao da para fazer isso dentro de InicializarForm: ali o form ainda nao
    * foi exibido e SetFocus em controle de form invisivel falha. O flag
    * this_lFocoInicialAplicado garante UMA vez so - sem ele, toda reativacao
    * da janela roubaria o foco de volta para a observacao, o que o legado
    * (modal, aberto e fechado uma vez) nunca faz.
    *==========================================================================
    PROCEDURE Activate()
        LOCAL loc_oErro

        TRY
            DODEFAULT()

            IF !THIS.this_lFocoInicialAplicado
                THIS.this_lFocoInicialAplicado = .T.
                THIS.obj_4c_Memo_Obs.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Activate")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - identico ao padrao dos demais forms (percorre
    * Pages de PageFrame e Controls de Container recursivamente). Este form
    * nao tem PageFrame nem container flutuante Visible=.F., mas o metodo fica
    * generico para as proximas fases (campos e o CommandGroup Confirmar
    * entram sempre visiveis).
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto, loc_nP

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
                    FOR loc_nP = 1 TO loc_oObjeto.PageCount
                        THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
                    ENDFOR
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - cmd_grupo -> cmg_4c_Botoes (o UNICO botao do legado)
    *
    * Transcricao do dump (PROPRIEDADES DE: SIGOPOCA.cmd_grupo):
    *
    *     AutoSize = .T.    ButtonCount = 1   BackStyle = 0   BorderStyle = 0
    *     Value = 1         Top = -2          Left = 411      Width = 85
    *     Height = 85       SpecialEffect = 1 BorderColor = 136,189,188
    *     Themes = .F.
    *     Command1 (Name = cmd_ok): Top = 5  Left = 5  Width = 75  Height = 75
    *         FontName = "Comic Sans MS"  FontSize = 8
    *         FontBold = .T.  FontItalic = .T.
    *         ForeColor = 90,90,90  BackColor = 255,255,255  Themes = .F.
    *         Caption = "\<Confirmar"   Picture = cadastro_salvar_60.jpg
    *
    * O "\<" do Caption eh o atalho ALT+C do legado - manter literal.
    * O nome do arquivo de icone eh TRANSCRITO do dump, nao escolhido por
    * semelhanca (regra #25): ".Picture" inexistente falha em SILENCIO, e aqui
    * "fechar a auditoria" usa o icone de SALVAR. Conferido em vbmp\.
    *
    * Tres cuidados que o dump nao mostra:
    *
    * 1) ButtonCount vai ANTES de qualquer Buttons(N) - o CommandGroup nasce
    *    com DOIS botoes, e tocar Buttons(2) depois de reduzir para 1 estoura
    *    "BUTTONS is not an object".
    * 2) Buttons(1) eh alcancado pelo CAMINHO COMPLETO, nunca por um WITH
    *    aninhado dentro do WITH do grupo: WITH aninhado sequestra o escopo e
    *    faz propriedade de BOTAO resolver contra o GRUPO, que nao tem
    *    ForeColor nem FontName - erro que compila limpo e so estoura no Init
    *    (regra #33).
    * 3) O grupo eh o ULTIMO AddObject do form e por isso NAO recebe .TabIndex
    *    aqui: o VFP aplica o valor no instante da criacao e o clampa, puxando
    *    o botao para a frente dos campos. A ordem inteira vai em
    *    AplicarOrdemTabulacao(), chamado depois de TODOS os AddObject.
    *
    * WordWrap / AutoSize / MousePointer / PicturePosition do botao nao sao
    * invencao: sao os defaults da classe de botao do framework legado
    * (docs\framework_frmcadastro_layout.md), que o SCX herda e por isso nao
    * repete no dump - o mesmo conjunto usado no dialogo irmao FormSigOpCrp.
    *
    * Criado DEPOIS de ConfigurarCabecalho de proposito: com Top = -2 o grupo
    * cai DENTRO da area da faixa cinza (Top 0, Height 80) e so desenha POR
    * CIMA dela se for o AddObject mais recente (regra #11).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
        WITH THIS.cmg_4c_Botoes
            .ButtonCount   = 1
            .AutoSize      = .T.
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .Value         = 1
            .Top           = -2
            .Left          = 411
            .Width         = 85
            .Height        = 85
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Top             = 5
            .Left            = 5
            .Width           = 75
            .Height          = 75
            .FontName        = "Comic Sans MS"
            .FontSize        = 8
            .FontBold        = .T.
            .FontItalic      = .T.
            .WordWrap        = .T.
            .AutoSize        = .F.
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .F.
            .MousePointer    = 15
            .PicturePosition = 13
            .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
            .Caption         = "\<Confirmar"
            .Visible         = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
    ENDPROC

    *==========================================================================
    * AplicarOrdemTabulacao - ordem de tabulacao do legado.
    *
    * Chamado DEPOIS de todos os AddObject: o VFP aplica o TabIndex no
    * instante da criacao e o CLAMPA ao numero de objetos que ja existem no
    * container, entao atribuir dentro do WITH de cada AddObject nao produz a
    * ordem pedida.
    *
    * O literal do dump tambem nao serve como alvo, porque no legado ele sofre
    * o MESMO clamp. TabIndex declarados no SCX: cmd_grupo = 11,
    * Get_DtAudits = 14, Get_valor = 14, Memo_Obs = 34 (os tres Label tem 30 e
    * sao inertes - Label nao tem TabStop, nao para o Tab). Os filhos diretos
    * do form nascem na ordem dos REGISTROS do SCX - cntSombra, cmd_grupo,
    * Get_DtAudits, Lbl_Auditoria, Get_valor, Label2, Label3, Memo_Obs -,
    * logo o 11 do grupo eh inalcancavel (ele eh o 2o criado) e a ordem
    * EFETIVA do legado entre os focalizaveis eh
    *
    *     cmd_grupo -> Get_DtAudits -> Get_valor -> Memo_Obs
    *
    * e, como os dois TextBox tem When() = .F. (nao recebem foco), o que o
    * usuario percebe eh Confirmar <-> Observacao.
    *
    * No migrado a ordem de criacao poe os campos ANTES do grupo. As duas
    * atribuicoes abaixo sao ASCENDENTES - cada uma poe o controle na posicao
    * pedida e empurra os demais para tras - e devolvem a sequencia do legado.
    *
    * TabStop = .F. nos dois TextBox de exibicao eh a reproducao do
    * When() = .F.: sem ele o Tab PARA num campo que o usuario nao pode
    * editar, divergencia que o ReadOnly = .T. sozinho nao evita (ReadOnly
    * bloqueia a DIGITACAO, nao o FOCO).
    *==========================================================================
    PROCEDURE AplicarOrdemTabulacao()
        *-- Reproduz o When() = .F. dos dois campos somente-leitura
        THIS.txt_4c_DtAudits.TabStop = .F.    && SCX Get_DtAudits.When -> .F.
        THIS.txt_4c_Valor.TabStop    = .F.    && SCX Get_valor.When    -> .F.

        THIS.cmg_4c_Botoes.TabIndex   = 1     && SCX cmd_grupo: 1o focalizavel
        THIS.obj_4c_Memo_Obs.TabIndex = 2     && SCX Memo_Obs (34): o ultimo
    ENDPROC

    *==========================================================================
    * BtnConfirmarClick - transcricao do cmd_ok.Click legado, o UNICO evento de
    * botao do SCX. PUBLIC porque eh alvo de BINDEVENT (regra #3).
    *
    * Legado (tasks\task773\SigOpOca_form_codigo_fonte.txt):
    *
    *   Replace ObsAudts With ThisForm.Memo_Obs.Value in CrSigCqOch
    *   If ThisForm.pTipo
    *       lctipo   = 'Auditado'
    *       lcUpdate = [Update SigMvCcr Set DtAudits = ?llData, Auditors = '<Usuar>'
    *                   Where Grupos = ... And Contas = ... And Moedas = ...
    *                   And Nopers = ...]
    *   Else
    *       lctipo   = 'DesAuditado'
    *       llData   = .Null.
    *       lcUpdate = [... Auditors = '          ' Where ...]
    *   Endif
    *   If ThisForm.Formpai.PodataMgr.Update('CrSigCqOch')
    *       lnErro = ThisForm.FormPai.poDataMgr.SqlExecute(lcUpdate,'')
    *   Else
    *       lnErro = 0
    *   Endif
    *   If lnErro > 0
    *       ThisForm.FormPai.poDataMgr.Commit()
    *       Select CrSigMvCcr
    *       If Thisform.pTipo
    *           Replace DtAudits With Datetime(), Auditors With Usuar
    *       Else
    *           Replace DtAudits With {} , Auditors With " "
    *       Endif
    *   EndIf
    *   ThisForm.Release
    *
    * Onde cada parte foi parar:
    *
    *   Replace ObsAudts ...        -> this_cObsAudts do BO (bloco 1 abaixo)
    *   If pTipo + os dois Update   -> SigOpOcaBO.Atualizar() (Fase 2), que
    *                                  decide Auditado/DesAuditado por
    *                                  this_lTipo e executa UPDATE SigCqOch
    *                                  (observacao) + UPDATE SigMvCcr
    *                                  (DtAudits/Auditors), este com o filtro
    *                                  Grupos+Contas+Moedas+Nopers transcrito
    *                                  LITERAL do dump (regra #17)
    *   Update('CrSigCqOch')/Commit -> nao existem aqui: a linha de log ja foi
    *                                  persistida pelo form pai ANTES de abrir
    *                                  o dialogo (ver cabecalho do BO), entao
    *                                  nao ha buffer de cursor para commitar
    *   Replace ... in CrSigMvCcr   -> as tres propriedades de resultado, que o
    *                                  form pai le depois do Show() retornar -
    *                                  nao ha sessao compartilhada onde fazer o
    *                                  Replace
    *   ThisForm.Release            -> FecharDialogo() (Hide, nao Release)
    *
    * O texto da observacao eh lido do EditBox AQUI, e nao apenas em
    * ValidarObservacao: o "\<" do Caption da ao botao o atalho ALT+C, que
    * aciona o Click SEM obrigar o campo a perder o foco - confiar so no
    * LostFocus gravaria o texto ANTERIOR. O controle eh a FONTE UNICA.
    *
    * O fechamento fica FORA do IF de sucesso porque no legado o
    * "ThisForm.Release" tambem esta fora do "If lnErro > 0": falha de
    * gravacao fecha o dialogo do mesmo jeito. A falha NAO fica muda - todo
    * caminho de erro de SigOpOcaBO.Atualizar() exibe MsgErro com o texto do
    * SQL Server (regra #9) - e this_lConfirmado continua .F., para o form pai
    * nao aplicar nada no cursor dele.
    *==========================================================================
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_lGravou, loc_oErro
        loc_lGravou = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- 1) "Replace ObsAudts With ThisForm.Memo_Obs.Value" -
                *-- delegado a FormParaBO(), que LE O CONTROLE (e nao a
                *-- property) exatamente por causa do atalho ALT+C: ver o
                *-- comentario "FONTE UNICA" la. So grava se a transferencia
                *-- aconteceu - senao o Atualizar() usaria texto velho.
                IF THIS.FormParaBO()
                    *-- 2) os dois UPDATE; Auditado/DesAuditado sai de this_lTipo
                    loc_lGravou = THIS.this_oBusinessObject.Atualizar()
                ENDIF

                *-- 3) o que o legado gravava no cursor do pai
                IF loc_lGravou
                    THIS.this_lConfirmado   = .T.
                    THIS.this_dDtAuditsNova = THIS.this_oBusinessObject.this_dDtAudits
                    THIS.this_cAuditorsNovo = THIS.this_oBusinessObject.this_cAuditors
                ENDIF
            ELSE
                MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + ;
                    "vel - a auditoria n" + CHR(227) + "o foi gravada.", "Confirmar")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BtnConfirmarClick")
        ENDTRY

        *-- "ThisForm.Release" do legado: fora do IF, exatamente como no dump
        THIS.FecharDialogo()
    ENDPROC

    *==========================================================================
    * FecharDialogo - ponto UNICO de fechamento da tela, no lugar do
    * "ThisForm.Release" do legado.
    *
    * Hide() e NAO Release(): medido no VFP9 - Release() destroi o objeto
    * mesmo com o chamador segurando a referencia, e a leitura seguinte
    * estoura "<variavel> is not an object". Como este dialogo existe
    * justamente para devolver ao extrato de Conta Corrente o novo estado da
    * auditoria (as tres propriedades de resultado, no lugar do Replace que o
    * legado fazia no cursor compartilhado), destruir-se antes de ser lido o
    * deixaria sem como devolver nada.
    *
    * Para o usuario nao muda: Hide() em form modal tambem devolve o Show() e
    * a tela fecha igual - PILAR 1 preservado. Muda so o tempo de vida do
    * objeto, que eh PILAR 3. Quem abre chama Release() depois de ler, como o
    * projeto ja faz com o FormBuscaAuxiliar.
    *
    * Nao ha efeito externo a antecipar do Destroy para ca (ele so chama
    * DODEFAULT). O cache do resultado acontece em BtnConfirmarClick, ANTES
    * daqui, porque FormBase.Destroy zera this_oBusinessObject.
    *==========================================================================
    PROCEDURE FecharDialogo()
        THIS.Hide()
    ENDPROC

    *==========================================================================
    * Destroy - nenhum cursor local a fechar nesta fase (this_cCursorDados
    * pertence ao form pai e nao deve ser tocado aqui); DODEFAULT() preserva
    * o fix de menu/popup da FormBase (regra #29 / Erro58).
    *==========================================================================
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpOcaBO.prg):
*==============================================================================
* SigOpOcaBO.prg - Business Object para SigOpOca (Auditoria de Lancamentos)
*
* Legado  : SIGOPOCA.SCX (task773) - dialogo MODAL "Auditoria de Lancamentos"
* Tabelas : SigMvCcr (UPDATE DtAudits/Auditors - lancamento sendo auditado)
*           SigCqOch (UPDATE ObsAudts - log da acao de auditoria, PK cidchaves)
*
* CONTEXTO (legado)
* ------------------
* SIGOPOCA eh aberto de dentro do Click do Chk_Auditoria de SIGOPIND (ja
* migrado como Formsigopind.prg), e SOMENTE quando CrSigCdPac.ObsAudts = 1
* (parametro do sistema exigindo observacao ao auditar/desauditar). ANTES de
* abrir o dialogo, o form pai ja:
*   1) decidiu lcTipo ('Auditado'/'DesAuditado') e llData (Datetime() ou NULL)
*      a partir do estado do CheckBox;
*   2) inseriu uma linha em CrSigCqOch (Nopers, Datars, TpLancs, Datas,
*      Usuars, CidChaves=fUniqueIds(), DtLancs=CrSigMvCcr.Datas) - AINDA SO
*      NO BUFFER, nao commitada;
*   3) chama DO Form SigOpOca With ThisForm.datasessionid, ThisForm, llTval,
*      ThisForm.page.hist.Chk_Auditoria.Top.
*
* O dialogo (Set DataSession To Arquivos) passa a compartilhar a SESSAO do
* form pai e portanto ve as MESMAS CrSigCqOch (a linha recem-inserida, ainda
* em buffer) e CrSigMvCcr (o lancamento sendo auditado, ja posicionado). O
* Confirmar grava a observacao digitada na linha de log, commita essa linha,
* executa o UPDATE em SigMvCcr e fecha o dialogo.
*
* ADAPTACAO DE ARQUITETURA (PILAR 3)
* -----------------------------------
* A nova arquitetura NAO compartilha data session entre forms (cada form eh
* independente) - por isso os valores que o legado le via cursor
* compartilhado (CrSigMvCcr.Grupos/Contas/Moedas/Nopers/Valors e
* CrSigCqOch.Datas/Cidchaves) chegam aqui como PROPRIEDADES explicitas,
* preenchidas pelo Form a partir do que o chamador fornecer (equivalente
* funcional ao que o legado buscava no cursor). O SQL executado (Fase 2)
* transcreve LITERALMENTE o UPDATE do dump do legado (filtro por
* Grupos+Contas+Moedas+Nopers, NAO por Cidchaves - essa variante com
* Cidchaves pertence ao Click do form pai, nao a este dialogo).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpOcaBO AS BusinessBase

    *==========================================================================
    * LANCAMENTO SENDO AUDITADO (SigMvCcr) - chave composta usada no WHERE
    * do UPDATE (transcrita literal do cmd_ok.Click do legado) + valor
    * exibido em Get_valor (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cGrupos = ""   && char(10) SigMvCcr.grupos
    this_cContas = ""   && char(10) SigMvCcr.contas
    this_cMoedas = ""   && char(3)  SigMvCcr.moedas
    this_nNopers = 0    && numeric(7,0) SigMvCcr.nopers
    this_nValors = 0    && numeric(11,2) SigMvCcr.valors - exibido em Get_valor

    *==========================================================================
    * TIPO DA OPERACAO (pTipo do legado) e novos valores a gravar em
    * SigMvCcr.DtAudits/Auditors (Fase 2 monta exatamente como o cmd_ok.Click:
    * Tipo=.T. -> DtAudits=Datetime(),Auditors=Usuar; Tipo=.F. -> DtAudits=
    * NULL,Auditors=espacos)
    *==========================================================================
    this_lTipo     = .F.   && .T. = Auditado / .F. = DesAuditado
    this_dDtAudits = {}    && datetime NULL - novo valor de SigMvCcr.dtaudits
    this_cAuditors = ""    && char(10) - novo valor de SigMvCcr.auditors

    *==========================================================================
    * LOG DA AUDITORIA (SigCqOch) - linha ja inserida pelo form pai (em
    * buffer, ainda nao commitada), identificada pela cidchaves que o pai
    * gerou com fUniqueIds(). This_dDataAuditoria espelha CrSigCqOch.Datas,
    * exibido em Get_DtAudits (somente leitura, When do legado devolve .F.)
    *==========================================================================
    this_cCidchavesLog  = ""  && char(20) SigCqOch.cidchaves (PK da linha de log)
    this_dDataAuditoria = {}  && datetime NULL SigCqOch.datas - exibido em Get_DtAudits
    this_cObsAudts      = ""  && text NULL SigCqOch.obsaudts - digitado em Memo_Obs

    *==========================================================================
    * CONTEXTO DA SESSAO - no legado era a PUBLIC Usuar
    *==========================================================================
    this_cUsuario = ""   && char(10) usuario logado (gc_4c_UsuarioLogado)

    *==========================================================================
    * Init - Configura tabela principal e chave primaria
    *
    * A tabela VAI no DODEFAULT: BusinessBase.Init() so instancia
    * this_oDataAccess quando recebe o parametro pcTabela. Com DODEFAULT()
    * sem argumento o objeto de acesso a dados fica .NULL. e todo metodo
    * herdado que depende dele devolve .F. reclamando que o acesso a dados
    * nao foi inicializado.
    *
    * this_cTabela = "SigMvCcr" espelha o padrao do SigOpEncBO (mesma familia
    * de dialogos de conta corrente que tocam mais de uma tabela) - o UPDATE
    * real desta tela filtra por Grupos+Contas+Moedas+Nopers (regra #17:
    * transcrever literal), nao por cidchaves; this_cCampoChave fica com o
    * nome convencional da PK de SigMvCcr so para a nomenclatura herdada de
    * BusinessBase (ObterChavePrimaria/RegistrarAuditoria) ter um valor
    * coerente com o schema.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigMvCcr")

            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"

            *-- Contexto da sessao (equivalente a PUBLIC Usuar)
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuario = ALLTRIM(gc_4c_UsuarioLogado)
            ENDIF

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpOcaBO.Init")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave usada por RegistrarAuditoria()
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos) + ALLTRIM(THIS.this_cContas) + ;
               ALLTRIM(THIS.this_cMoedas) + TRANSFORM(THIS.this_nNopers)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia as colunas de SigMvCcr (lancamento sendo
    * auditado) e de SigCqOch (linha de log, ja inserida pelo form pai) a
    * partir de UM cursor combinado montado pelo Form - equivalente ao que o
    * legado lia direto de CrSigMvCcr/CrSigCqOch na sessao compartilhada
    * (regra #8 CLAUDE.md: SELECT (par_cAliasCursor) antes de acessar campo).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                *-- SigMvCcr - chave composta usada no WHERE do UPDATE + valor
                *-- exibido em Get_valor
                THIS.this_cGrupos = TratarNulo(grupos, "")
                THIS.this_cContas = TratarNulo(contas, "")
                THIS.this_cMoedas = TratarNulo(moedas, "")
                THIS.this_nNopers = TratarNulo(nopers, 0)
                THIS.this_nValors = TratarNulo(valors, 0)

                *-- SigCqOch - linha de log (PK cidchaves) + data exibida em
                *-- Get_DtAudits (somente leitura)
                THIS.this_cCidchavesLog  = TratarNulo(cidchaves, "")
                THIS.this_dDataAuditoria = TratarNulo(datas, {})
                THIS.this_cObsAudts      = TratarNulo(obsaudts, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro em SigOpOcaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Executa a confirmacao da auditoria (cmd_ok.Click do legado):
    *
    *   1) decide DtAudits/Auditors conforme this_lTipo (Tipo=.T. -> Auditado:
    *      DtAudits=Datetime(), Auditors=Usuar | Tipo=.F. -> DesAuditado:
    *      DtAudits=NULL, Auditors=espacos)
    *   2) UPDATE SigMvCcr SET DtAudits, Auditors WHERE Grupos+Contas+Moedas+
    *      Nopers (filtro TRANSCRITO literal do dump - regra #17 CLAUDE.md,
    *      NAO eh por cidchaves)
    *   3) UPDATE SigCqOch SET ObsAudts WHERE Cidchaves = this_cCidchavesLog
    *      (equivalente ao "Replace ObsAudts With ThisForm.Memo_Obs.Value in
    *      CrSigCqOch" do legado - a linha em si ja foi inserida e persistida
    *      pelo form pai antes de abrir este dialogo, por isso aqui eh UPDATE
    *      e nao INSERT)
    *
    * Este dialogo NUNCA cria um SigMvCcr novo (sempre atua sobre um
    * lancamento ja existente), por isso Inserir()/ExecutarExclusao() nao sao
    * sobrescritos - o comportamento padrao herdado de BusinessBase (recusar
    * a operacao) ja eh o correto para esses dois casos.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_cSQLCcr, loc_cSQLOch, loc_nResult, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.this_lTipo
                THIS.this_dDtAudits = DATETIME()
                THIS.this_cAuditors = THIS.this_cUsuario
            ELSE
                THIS.this_dDtAudits = {}
                THIS.this_cAuditors = SPACE(10)
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel."
                MsgErro(THIS.this_cMensagemErro, "SigOpOcaBO.Atualizar")
                THIS.this_lErroExibido = .T.
            ELSE
                *-- 2) UPDATE SigMvCcr - filtro EXATO do legado
                loc_cSQLCcr = "UPDATE SigMvCcr SET"
                loc_cSQLCcr = loc_cSQLCcr + " dtaudits = " + FormatarDataSQL(THIS.this_dDtAudits) + ","
                loc_cSQLCcr = loc_cSQLCcr + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10))
                loc_cSQLCcr = loc_cSQLCcr + " WHERE grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10))
                loc_cSQLCcr = loc_cSQLCcr + " AND moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3))
                loc_cSQLCcr = loc_cSQLCcr + " AND nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0)

                IF USED("cursor_4c_UpdateCcr")
                    USE IN cursor_4c_UpdateCcr
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLCcr, "cursor_4c_UpdateCcr")

                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar o lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    IF USED("cursor_4c_UpdateCcr")
                        USE IN cursor_4c_UpdateCcr
                    ENDIF

                    *-- 3) UPDATE SigCqOch - observacao digitada em Memo_Obs
                    loc_cSQLOch = "UPDATE SigCqOch SET obsaudts = " + EscaparSQL(THIS.this_cObsAudts) + ;
                        " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchavesLog, 20))

                    IF USED("cursor_4c_UpdateOch")
                        USE IN cursor_4c_UpdateOch
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQLOch, "cursor_4c_UpdateOch")

                    IF loc_nResult < 0
                        MsgErro("Erro ao gravar a observa" + CHR(231) + CHR(227) + "o da auditoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        IF USED("cursor_4c_UpdateOch")
                            USE IN cursor_4c_UpdateOch
                        ENDIF

                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SigOpOcaBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

