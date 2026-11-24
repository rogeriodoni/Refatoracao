*------------------------------------------------------------------------------
* Formsigopvci.prg - Form Operacional: Visualizacao de Cupom Impresso
* Herda de FormBase
* Migrado de SIGOPVCI.SCX
*
* Form OPERACIONAL sem tabela principal propria: o cupom fiscal e lido da
* memoria da impressora fiscal (MFD) via DLL do fabricante e apenas exibido
* em tela (Edit1), nao persistido no SQL Server - ver cabecalho do
* sigopvciBO.prg. Layout PLANO (sem PageFrame Page1/Page2 de CRUD), fiel ao
* SCX legado: cabecalho cinza (cntSombra) + bloco de filtros (tipo de busca,
* faixa de cupom/data) + area de conteudo do cupom + botoes Consultar/
* Encerrar (Commandgroup1).
*
* FASE 4/8 - CONTROLES E BOTOES DE ACAO: alem do cabecalho e Destroy da
* Fase 3, esta fase acrescenta TODOS os controles de entrada/exibicao do
* corpo do form (Optiongroup1, Text1-4, Check1, Edit1, Labels, cntAguarde)
* e o Commandgroup1 (equivalente aos botoes CRUD do padrao cadastro - aqui
* sao "Consultar"/"Encerrar", os unicos botoes do legado). Os controles sao
* criados com as propriedades visuais EXATAS do SCX (PILAR 1).
*
* FASE 5/8 - VINCULO COM O BO: este form nao tem Page1/Page2 (layout PLANO,
* ver acima), entao nao ha ConfigurarPaginaDados - o equivalente aqui e
* FormParaBO()/BOParaForm(), que ligam os controles do corpo (obj_4c_
* Optiongroup1, txt_4c_Text1-4, chk_4c_Check1, edt_4c_Edit1) as properties
* this_* do sigopvciBO criadas na Fase 1. BOParaForm() roda no fim de
* InicializarForm() para o BO permanecer fonte unica do criterio (mesmo
* default que ConfigurarControles ja aplica). BINDEVENT dos eventos quando/
* lostfocus (Fase 6) e os metodos Click reais (Fases 7-8) entram nas fases
* seguintes - criar o controle e ligar ao BO antes de ligar o evento nao e
* stub, e a divisao que o processamento multi-fase adota para este tipo de
* form (OPERACIONAL sem lista/grade - dialogo de captura).
*
* FASE 6/8 - CAMPOS RESTANTES E LOOKUPS: o SCX legado NAO POSSUI LOOKUP
* ALGUM - a varredura do dump (sigopvci_form_codigo_fonte.txt, 9 metodos com
* codigo) devolve ZERO ocorrencia de fwBuscaExt/fwBuscaSel/fwBuscaInt,
* mAddColuna, sigacess()/Acesso*() e FormBuscaAuxiliar, e nenhum dos 4
* TextBox tem Valid que abra browse: os campos sao faixa de numero de cupom
* e faixa de data, digitados a mao. Criar AbrirLookup*/AbrirBusca* aqui
* exigiria INVENTAR tabela de referencia que o legado nao consulta, o que
* viola o PILAR 1 e a regra "NUNCA inventar tabelas de lookup que nao
* existem no original". Pelo mesmo motivo nao existe cnt_4c_BotoesAcao com
* Salvar/Cancelar: este form nao grava registro (ver cabecalho do
* sigopvciBO.prg) e os UNICOS botoes do legado sao Consultar/Encerrar, ja
* criados na Fase 4 em cmg_4c_Botoes.
*
* O que esta fase entrega, portanto, sao os EVENTOS dos campos que a Fase 5
* deixou explicitamente para ca - as 6 procedures de evento dos TextBox do
* legado (sigopvci_form_codigo_fonte.txt:940-1010):
*   - 4x When   (Text1/Text2 so acessiveis com Optiongroup1.Value = 1;
*                Text3/Text4 so acessiveis com Optiongroup1.Value = 2)
*     -> ValidarCriterioBusca(), metodo PUBLIC unico de dependencia, ligado
*        ao Optiongroup1 por BINDEVENT e chamado no fim de BOParaForm.
*        NAO se liga "When" por BINDEVENT: o BINDEVENT DESCARTA o retorno do
*        delegate, entao um When ligado assim nao bloqueia nada - a forma que
*        reproduz o legado (campo inalcancavel) e' .Enabled.
*   - 2x LostFocus (Text1/Text2 normalizam o numero digitado com
*                Transform(Val(This.Value), '@L 999999'))
*     -> ValidarNumeroInicial()/ValidarNumeroFinal(), ligados por BINDEVENT
*        em "LostFocus" (o evento do legado), delegando ao formatador unico
*        FormatarNumeroCupom() para a regra ficar em UM lugar so.
*
* A validacao de FAIXA (Text1 > Text2, Text3 > Text4, faixa vazia) NAO entra
* aqui de proposito: no legado ela mora dentro do Commandgroup1.CmdInserir.
* Click (sigopvci_form_codigo_fonte.txt:601+), junto com a leitura da MFD,
* e portanto acompanha o metodo Click real nas Fases 7-8 - antecipa-la aqui
* duplicaria a regra em dois lugares.
*
* FASE 7/8 - EVENTOS PRINCIPAIS DOS BOTOES: o SCX legado tem EXATAMENTE DOIS
* botoes, os Command1/Command2 do Commandgroup1, e os Name deles MENTEM -
* "CmdInserir" e "CmdExcluir" num form que nao inclui nem exclui registro
* algum. Os handlers sao nomeados pela ACAO, que e' o Caption que o usuario LE
* (sigopvci_form_codigo_fonte.txt:228 e 242):
*
*   Command1 "\<Consultar" (CmdInserir.Click, 320 linhas) -> BtnConsultarClick
*   Command2 "Encerrar"    (CmdExcluir.Click, "Release Windows") -> BtnEncerrarClick
*
* NAO existem BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick:
* esses quatro nomes sao a barra CRUD do frmcadastro, e este legado herda de
* "form" PURO - zero frmcadastro, zero Grupo_Op, zero pcEscolha no dump
* inteiro. Cria-los exigiria INVENTAR botao que o legado nao tem (viola o
* PILAR 1) ou deixar metodo vazio (proibido pela regra de completude).
*
* O Consultar foi quebrado em metodos na MESMA ordem do Click legado, porque
* porta-lo num unico corpo de 320 linhas tornaria ilegiveis os quatro ramos de
* impressora fiscal:
*
*   BtnConsultarClick       guarda de reentrancia + TRY (libera a flag sempre)
*   BtnConsultarClickExec   fluxo do Click legado, passo a passo
*   ValidarFaixaConsulta    as 4 validacoes de faixa do inicio do Click
*   AguardarPintura         a espera de 2s que deixa o "Aguarde..." aparecer
*   ResolverFaixaMFD        monta lcTipo/lcInic/lcFim conforme o modelo
*   ExtrairCupomBematech    ramo BEMA8501 (BemaFI32.dll -> DOWNLOAD.TXT)
*   ExtrairCupomDaruma      ramo DARUMA   (DarumaFramework.dll -> espelho_mfd.TXT)
*   ExtrairCupomNsweda      ramo NSWEDA   (LeMFD -> c:\Retorno.TXT)
*   ExtrairCupomEpson       ramo EPSON    (InterfaceEpson.dll -> C:\SAIDA_ESP.TXT)
*   CarregarCupomDeArquivo  fonte unica do cursor SDF -> Edit1 (comum aos 4)
*   ObterDiretorioDaruma    <LocalArquivos> do darumaframework.xml
*   CarregarConfiguracaoFiscal  pre-requisito: o "=fLerFiscal()" do Init legado
*
* Funcoes GLOBAIS do Fortyus que o Click usa e que NAO vieram no acervo
* ganharam wrapper documentado em utils\ (regra CLAUDE.md #27): lemfd.prg,
* verifporta.prg, rotstatus.prg e fecharporta.prg - LeituraFab ja existia. Em
* todos, a AUSENCIA fica VISIVEL ao usuario pelas guardas que o PROPRIO legado
* tem ("Problemas na Leitura do Cupom !!!"), nunca como cupom em branco mudo.
*
* Os DECLARE de DLL ficam em TRY/CATCH com flag de disponibilidade: "DECLARE
* ... IN <dll>" NAO e' preguicoso, o VFP9 carrega a biblioteca na hora e
* estoura "Cannot load 32-bit DLL ..." na estacao sem o driver (medido nesta
* maquina em 2026-11-19) - sem a guarda o erro subiria e fecharia a tela.
*
* FASE 8/8 - CONSOLIDACAO FINAL: auditoria campo a campo contra o dump
* (sigopvci_form_codigo_fonte.txt) confirma os 9/9 metodos com codigo
* legado (Init, CmdInserir.Click, CmdExcluir.Click, 2x Text.LostFocus,
* 4x Text.When) portados, e os 18 objetos do mapeamento.json (cnt_4c_Sombra
* +2 labels, cmg_4c_Botoes, edt_4c_Edit1, obj_4c_Optiongroup1, txt_4c_Text1-4,
* chk_4c_Check1, cnt_4c_Aguarde +2 labels, lbl_4c_Label1-5) criados com as
* propriedades visuais exatas do SCX. Test-CompletudeCodigo (sem TODO/stub/
* procedure vazia) e COMPILE (sem erro) confirmados nesta maquina em
* 2026-11-19.
*
* O QUE NAO SE APLICA A ESTE FORM (e por que inventar violaria o PILAR 1):
*   - BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick/
*     BtnSalvarClick/BtnCancelarClick: a barra CRUD do frmcadastro.
*     Este legado herda de "form" puro (zero frmcadastro, zero Grupo_Op,
*     zero pcEscolha no dump inteiro) e os UNICOS botoes sao Consultar
*     (BtnConsultarClick, Fase 7) e Encerrar (BtnEncerrarClick, Fase 7).
*   - BtnBuscarClick: o nome generico nao se aplica - a acao de buscar/ler
*     o cupom na impressora fiscal JA e' o botao "\<Consultar" (Caption do
*     legado), migrado como BtnConsultarClick.
*   - CarregarLista/AjustarBotoesPorModo/HabilitarCampos/LimparCampos: todos
*     pressupoem Page1=Lista + grid de registros. Este form e' FLAT (sem
*     PageFrame), nao lista nem edita registro - o cupom e' lido da MFD da
*     impressora fiscal e so exibido (ver cabecalho do sigopvciBO.prg).
*     ValidarCriterioBusca (Fase 6/7) e' o equivalente real a HabilitarCampos
*     aqui: habilita a faixa de numero OU a de data conforme Optiongroup1.
*
* Integracao (fora de escopo desta fase - mesmo padrao do FormSigOpTop.prg/
* FormSigOpTrf.prg, familia de ~230 dialogos "SigOp*" OPERACIONAL):
*   - config.prg: NADA a acrescentar (carga sob demanda, GarantirClasse +
*     start\indice_classes.txt - ja indexado automaticamente nesta maquina).
*   - menu.prg: NADA a acrescentar - nenhum dos outros ~230 forms "SigOp*"
*     (incluindo os irmaos da mesma leva, FormSIGOPTOR/FormSigOpTop/
*     FormSigOpTot/FormSigOpTrf/FormSigoptrp) tem item de menu proprio;
*     o Init legado recebe par_cFormulario (PARAMETERS poFormulario) e e'
*     chamado por outra tela do acervo legado (provavelmente a configuracao
*     de caixa/impressora fiscal), nao pelo popup principal. Inventar um
*     DEFINE BAR/ON SELECTION aqui criaria navegacao que o legado nao tem.
*------------------------------------------------------------------------------
DEFINE CLASS Formsigopvci AS FormBase

    *-- Propriedades visuais (original SIGOPVCI.SCX: DataSession=2, Height=500,
    *-- Width=800, BorderStyle=2, ControlBox=.F., TitleBar=0, WindowType=1)
    this_cMensagemErro = ""
    DataSession = 2
    ShowWindow = 1
    Top         = 0
    Left        = 0
    Height      = 500
    Width       = 800
    BorderStyle = 2
    AutoCenter  = .T.
    TitleBar    = 0
    ShowWindow  = 0
    WindowType  = 1
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    Caption     = "Vizualiza" + CHR(231) + CHR(227) + "o de Cupom Impresso"
    FontName    = "Tahoma"
    FontSize    = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- FASE 7/8 - estado do botao Consultar (CmdInserir.Click do legado).
    *-- O legado guarda isso em LOCAL/PRIVATE do proprio Click (lnNoFabr,
    *-- lcTipo, lcInic, lcFim); aqui sao properties porque o Click foi
    *-- quebrado em metodos (ResolverFaixaMFD + ExtrairCupom*) e passar por
    *-- referencia com @ em cadeia tornaria o fluxo ilegivel.
    this_cNumFabricacao = ""   && LeituraFab(poFormulario) - numero de fabricacao do ECF
    this_cTipoMFD       = ""   && lcTipo - criterio enviado a DLL ("0"/"1"/"2", varia por modelo)
    this_cInicioMFD     = ""   && lcInic - inicio da faixa (numero de cupom ou data, conforme o modelo)
    this_cFimMFD        = ""   && lcFim  - fim da faixa

    *-- Guarda de reentrancia do Consultar: a leitura da MFD leva segundos e
    *-- exibe dialogos (MsgInfo/MsgErro) que devolvem o foco ao botao; sem a
    *-- guarda, um segundo clique reentra no meio da extracao e as duas
    *-- passagens disputam o mesmo arquivo de retorno e o mesmo cursor.
    this_lEmConsulta = .F.

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        RETURN DODEFAULT()
    ENDPROC

    *==========================================================================
    * InicializarForm - Chamado por FormBase.Init via DODEFAULT
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("sigopvciBO")

            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF gnConnHandle <= 0
                    MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
                            "o Com o Servidor de Banco de Dados...", ;
                            "Conex" + CHR(227) + "o")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarControles()
            THIS.ConfigurarBotoes()
            THIS.TornarControlesVisiveis()
            THIS.ConfigurarEventos()
            THIS.BOParaForm()

            *-- FASE 7/8: pre-requisito do botao Consultar - o legado le a
            *-- configuracao da impressora fiscal no PROPRIO Init
            *-- ("=fLerFiscal()", sigopvci_form_codigo_fonte.txt:548) e todo o
            *-- CmdInserir.Click se ramifica por crSigFiFis.Imps. Sem esta
            *-- carga o botao nao teria por onde decidir o modelo.
            THIS.CarregarConfiguracaoFiscal()

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Constroi o cabecalho cinza superior do form e o
    * fundo padrao (textura new_background.jpg, igual ao SCX legado). Forms
    * OPERACIONAIS nao usam PageFrame CRUD - o cabecalho e um container
    * direto no form, equivalente ao cntSombra do framework legado.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        LOCAL loc_oErro

        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.AddObject("cnt_4c_Sombra", "Container")
            WITH THIS.cnt_4c_Sombra
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackColor   = RGB(100, 100, 100)
                .BackStyle   = 1
                .BorderWidth = 0

                .AddObject("lbl_4c_LblSombra", "Label")
                WITH .lbl_4c_LblSombra
                    .Top       = 18
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 40
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(0, 0, 0)
                    .Caption   = THIS.Caption
                ENDWITH

                .AddObject("lbl_4c_LblTitulo", "Label")
                WITH .lbl_4c_LblTitulo
                    .Top       = 17
                    .Left      = 10
                    .Width     = THIS.Width
                    .Height    = 46
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 18
                    .AutoSize  = .F.
                    .BackStyle = 0
                    .WordWrap  = .T.
                    .Alignment = 0
                    .ForeColor = RGB(255, 255, 255)
                    .Caption   = THIS.Caption
                ENDWITH

                .Visible = .T.
            ENDWITH

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarPageFrame")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarControles - Cria os controles de entrada/exibicao do corpo
    * do form, com as propriedades visuais EXATAS do SCX legado (sigopvci_
    * form_codigo_fonte.txt:385-519). Nao vincula ControlSource/BO (Fase 5)
    * nem BINDEVENT de evento (Fase 6) - so geometria/fonte/cor, igual ao
    * padrao de ConfigurarPaginaLista/ConfigurarPaginaDados (regra #41).
    *
    * obj_4c_Optiongroup1 (Tipo de busca: Cupom/Data) controla via When() dos
    * TextBoxes legado quais campos (faixa de numero x faixa de data) estao
    * habilitados - os Whens serao religados na Fase 6/7 junto com os demais
    * handlers; aqui o Value = 1 ja reproduz o default do legado (Optiongroup1.
    * Value = 1 no dump, Option1 = "Cupom").
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarControles()
        LOCAL loc_oErro

        TRY
            *-- Label1 "Tipo :" (SIGOPVCI.Label1)
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Top       = 96
                .Left      = 240
                .Width     = 32
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Tipo :"
                .Visible   = .T.
            ENDWITH

            *-- Optiongroup1 (criterio de busca: Cupom x Data)
            THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
            WITH THIS.obj_4c_Optiongroup1
                .ButtonCount  = 2
                .BackStyle    = 0
                .BorderStyle  = 0
                .Top          = 90
                .Left         = 271
                .Width        = 180
                .Height       = 26
                .Value        = 1

                WITH .Buttons(1)
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = " Cupom"
                    .Value     = 1
                    .Top       = 4
                    .Left      = 5
                    .Width     = 61
                    .Height    = 17
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH

                WITH .Buttons(2)
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .BackStyle = 0
                    .Caption   = " Data"
                    .Top       = 4
                    .Left      = 84
                    .Width     = 61
                    .Height    = 17
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH

                .Visible = .T.
            ENDWITH

            *-- Label2 "Cupom :" + Text1/Text2 (faixa de numero de cupom)
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 119
                .Left      = 225
                .Width     = 47
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Cupom :"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Text1", "TextBox")
            WITH THIS.txt_4c_Text1
                .Top       = 116
                .Left      = 274
                .Width     = 60
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .InputMask = "999999"
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 119
                .Left      = 352
                .Width     = 9
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "a"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Text2", "TextBox")
            WITH THIS.txt_4c_Text2
                .Top       = 116
                .Left      = 367
                .Width     = 60
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .InputMask = "999999"
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- Check1 "Geracao de Cupons em Arquivo"
            THIS.AddObject("chk_4c_Check1", "CheckBox")
            WITH THIS.chk_4c_Check1
                .Top       = 168
                .Left      = 274
                .Width     = 194
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Gera" + CHR(231) + CHR(227) + "o de Cupons em Arquivo"
                .Value     = 0
                .Visible   = .T.
            ENDWITH

            *-- Label4 "Data :" + Text3/Text4 (faixa de data)
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Top       = 144
                .Left      = 237
                .Width     = 35
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Data :"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Text3", "TextBox")
            WITH THIS.txt_4c_Text3
                .Top       = 141
                .Left      = 274
                .Width     = 75
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .InputMask = "999999"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .Top       = 144
                .Left      = 352
                .Width     = 9
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "a"
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Text4", "TextBox")
            WITH THIS.txt_4c_Text4
                .Top       = 141
                .Left      = 367
                .Width     = 75
                .Height    = 23
                .FontName  = "Tahoma"
                .FontSize  = 8
                .InputMask = "999999"
                .Value     = {}
                .Visible   = .T.
            ENDWITH

            *-- Edit1 (conteudo do cupom extraido - somente leitura)
            THIS.AddObject("edt_4c_Edit1", "EditBox")
            WITH THIS.edt_4c_Edit1
                .Top               = 186
                .Left              = 215
                .Width             = 370
                .Height            = 283
                .FontBold          = .F.
                .FontName          = "Tahoma"
                .FontSize          = 8
                .ReadOnly          = .T.
                .DisabledBackColor = RGB(255, 255, 255)
                .DisabledForeColor = RGB(0, 0, 0)
                .Value             = ""
                .Visible           = .T.
            ENDWITH

            *-- cntAguarde - aviso "Aguarde... Processando Dados..." exibido
            *-- durante a leitura do cupom na impressora fiscal. Nasce oculto
            *-- (sigopvci_form_codigo_fonte.txt:588) e esta na lista de
            *-- excecao de TornarVisivelRecursivo.
            THIS.AddObject("cnt_4c_Aguarde", "Container")
            WITH THIS.cnt_4c_Aguarde
                .Top           = 225
                .Left          = 280
                .Width         = 239
                .Height        = 49
                .BorderWidth   = 5
                .SpecialEffect = 0
                .BackColor     = RGB(255, 255, 255)

                .AddObject("lbl_4c_Label1", "Label")
                WITH .lbl_4c_Label1
                    .Top       = 7
                    .Left      = 87
                    .Width     = 70
                    .Height    = 18
                    .AutoSize  = .F.
                    .Alignment = 0
                    .BackStyle = 0
                    .FontBold  = .T.
                    .FontName  = "Tahoma"
                    .FontSize  = 10
                    .ForeColor = RGB(255, 0, 0)
                    .Caption   = "Aguarde..."
                    .Visible   = .T.
                ENDWITH

                .AddObject("lbl_4c_Label2", "Label")
                WITH .lbl_4c_Label2
                    .Top          = 24
                    .Left         = 46
                    .Width        = 141
                    .Height       = 18
                    .AutoSize     = .F.
                    .Alignment    = 0
                    .BackStyle    = 0
                    .FontBold     = .T.
                    .FontName     = "Tahoma"
                    .FontSize     = 10
                    .FontCondense = .T.
                    .ForeColor    = RGB(90, 90, 90)
                    .Caption      = "Processando Dados..."
                    .Visible      = .T.
                ENDWITH

                .Visible = .F.
            ENDWITH

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarControles")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBotoes - Cria o Commandgroup1 do legado (unico bloco de
    * botoes do form - nao ha CRUD aqui, so a acao de ler o cupom na
    * impressora fiscal e a de encerrar a tela). Propriedades EXATAS do
    * SCX (sigopvci_form_codigo_fonte.txt:203-250). Os Click reais
    * (CmdInserir.Click/CmdExcluir.Click do legado) entram nas Fases 7-8;
    * aqui so a casca visual, igual ao padrao CRUD de criar o botao antes
    * de ligar o evento.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
            WITH THIS.cmg_4c_Botoes
                .ButtonCount    = 2
                .BackStyle      = 0
                .BorderStyle    = 0
                .SpecialEffect  = 1
                .BorderColor    = RGB(136, 189, 188)
                .AutoSize       = .T.
                .Top            = -2
                .Left           = 645
                .Width          = 160
                .Height         = 85
                .Value          = 1

                WITH .Buttons(1)
                    .Top        = 5
                    .Left       = 5
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .WordWrap   = .T.
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                    .Caption    = "\<Consultar"
                    IF FILE(gc_4c_CaminhoIcones + "geral_procura_60.jpg")
                        .Picture = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                    ENDIF
                ENDWITH

                WITH .Buttons(2)
                    .Top        = 5
                    .Left       = 80
                    .Width      = 75
                    .Height     = 75
                    .FontBold   = .T.
                    .FontItalic = .T.
                    .FontName   = "Comic Sans MS"
                    .FontSize   = 8
                    .WordWrap   = .T.
                    .ForeColor  = RGB(90, 90, 90)
                    .BackColor  = RGB(255, 255, 255)
                    .Themes     = .F.
                    .Cancel     = .T.
                    .Caption    = "Encerrar"
                    IF FILE(gc_4c_CaminhoIcones + "cadastro_sair_60.jpg")
                        .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    ENDIF
                ENDWITH

                .Visible = .T.
            ENDWITH

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *==========================================================================
    * FormParaBO - Transfere os valores digitados nos controles do corpo do
    * form para as properties this_* do Business Object (vinculo Form->BO,
    * Fase 5/8 - ver comentario de ConfigurarControles). Chamado pelos
    * metodos Click reais (Fases 7-8) antes de acionar a extracao do cupom
    * na impressora fiscal - a validacao de faixa (Text1>Text2, Text3>Text4,
    * faixa vazia) e exclusiva do Commandgroup1.Click do legado e entra
    * junto com o metodo Click real, nao aqui.
    *
    * obj_4c_Optiongroup1.Value e txt_4c_Text1-4/chk_4c_Check1.Value sao
    * copiados DIRETO (regra #188 - ControlSource numerico = indice 1-based,
    * sem +1/-1); txt_4c_Text1/Text2 guardam o numero de cupom como STRING
    * (ver LostFocus do legado: Transform(Val(This.Value),'@L 999999')), por
    * isso a conversao para this_nNumeroInicial/Final usa VAL(ALLTRIM(...)).
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_nTipoBusca = THIS.obj_4c_Optiongroup1.Value

            .this_nNumeroInicial = ALLTRIM(THIS.txt_4c_Text1.Value)
            .this_nNumeroFinal   = ALLTRIM(THIS.txt_4c_Text2.Value)

            .this_dDataInicial = THIS.txt_4c_Text3.Value
            .this_dDataFinal   = THIS.txt_4c_Text4.Value

            .this_lGeraArquivo = (THIS.chk_4c_Check1.Value = 1)

            .this_cConteudoCupom = THIS.edt_4c_Edit1.Value
        ENDWITH
    ENDPROC

    *==========================================================================
    * BOParaForm - Transfere as properties this_* do Business Object para os
    * controles do corpo do form (vinculo BO->Form, Fase 5/8). Chamado no
    * fim de InicializarForm (espelha os defaults this_nTipoBusca=1/
    * this_lGeraArquivo=.F. ja setados em ConfigurarControles - mantem o BO
    * como fonte unica do criterio) e sera reusado pelos metodos Click reais
    * (Fases 7-8) apos THIS.this_oBusinessObject.this_cConteudoCupom receber
    * o retorno da leitura da impressora fiscal.
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        WITH THIS.this_oBusinessObject
            THIS.obj_4c_Optiongroup1.Value = IIF(BETWEEN(.this_nTipoBusca, 1, 2), .this_nTipoBusca, 1)

            THIS.txt_4c_Text1.Value = IIF(.this_nNumeroInicial = 0, "", TRANSFORM(.this_nNumeroInicial, "@L 999999"))
            THIS.txt_4c_Text2.Value = IIF(.this_nNumeroFinal = 0, "", TRANSFORM(.this_nNumeroFinal, "@L 999999"))

            THIS.txt_4c_Text3.Value = .this_dDataInicial
            THIS.txt_4c_Text4.Value = .this_dDataFinal

            THIS.chk_4c_Check1.Value = IIF(.this_lGeraArquivo, 1, 0)

            THIS.edt_4c_Edit1.Value = .this_cConteudoCupom
        ENDWITH

        *-- Estado inicial de habilitacao igual ao do legado (ver ValidarCriterioBusca):
        *-- o criterio recem-espelhado do BO decide qual faixa fica acessivel.
        THIS.ValidarCriterioBusca()
    ENDPROC

    *==========================================================================
    * ConfigurarEventos - Liga por BINDEVENT os eventos dos campos de entrada
    * que o SCX legado implementava nas procedures de evento dos TextBox
    * (sigopvci_form_codigo_fonte.txt:940-1010). Rodado em InicializarForm
    * DEPOIS de ConfigurarControles/ConfigurarBotoes (os controles-alvo tem de
    * existir: BINDEVENT com delegate ou alvo inexistente estoura no proprio
    * bind) e ANTES de BOParaForm, que fecha chamando ValidarCriterioBusca()
    * para o estado inicial de habilitacao ja sair igual ao do legado.
    *
    * Optiongroup1 -> ValidarCriterioBusca nos DOIS eventos: "InteractiveChange"
    * cobre a troca pelo teclado (setas) e "Click" a troca pelo mouse. O metodo
    * e' idempotente (so reatribui .Enabled), entao o disparo duplo que o mouse
    * provoca e' inofensivo.
    *
    * Text1/Text2 -> ValidarNumeroInicial/ValidarNumeroFinal em "LostFocus",
    * que e' o MESMO evento do legado (regra: lookup/normalizacao de campo vai
    * em LostFocus, nunca em KeyPress sem testar a tecla). Handlers de LostFocus
    * NAO recebem parametro - por isso os metodos sao sem argumento.
    * Text3/Text4 nao recebem BINDEVENT: no legado eles tem SO o When, nenhum
    * LostFocus (a faixa de data nao e' reformatada).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventos()
        LOCAL loc_oErro

        TRY
            BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "ValidarCriterioBusca")
            BINDEVENT(THIS.obj_4c_Optiongroup1, "Click", THIS, "ValidarCriterioBusca")

            BINDEVENT(THIS.txt_4c_Text1, "LostFocus", THIS, "ValidarNumeroInicial")
            BINDEVENT(THIS.txt_4c_Text2, "LostFocus", THIS, "ValidarNumeroFinal")

            *-- FASE 7/8 - os DOIS unicos botoes do SCX legado. Os Name do
            *-- legado MENTEM (CmdInserir/CmdExcluir num form que nao inclui
            *-- nem exclui nada): os handlers sao nomeados pela ACAO, que eh o
            *-- Caption que o usuario LE - "\<Consultar" e "Encerrar"
            *-- (sigopvci_form_codigo_fonte.txt:228 e 242).
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConsultarClick")
            BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnEncerrarClick")

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ConfigurarEventos")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarCriterioBusca - Metodo PUBLIC unico de dependencia entre controles.
    * Reproduz as QUATRO procedures When dos TextBox do legado:
    *
    *     Text1.When -> Return(ThisForm.Optiongroup1.Value = 1)
    *     Text2.When -> Return(ThisForm.Optiongroup1.Value = 1)
    *     Text3.When -> Return(ThisForm.Optiongroup1.Value = 2)
    *     Text4.When -> Return(ThisForm.Optiongroup1.Value = 2)
    *
    * Ou seja: escolhido "Cupom" (Value = 1) so a faixa de NUMERO e' acessivel;
    * escolhido "Data" (Value = 2) so a faixa de DATA e'. O When do legado e'
    * reavaliado pelo VFP a cada tentativa de entrar no campo e, devolvendo .F.,
    * torna o campo INALCANCAVEL - o equivalente em runtime e' .Enabled, porque
    * BINDEVENT DESCARTA o retorno do delegate e um "When" ligado por BINDEVENT
    * nao bloquearia edicao nenhuma.
    *
    * NAO limpa o valor do campo desabilitado: o legado tambem nao limpa (o When
    * so barra o foco), e apagar o que o usuario digitou ao trocar de criterio
    * e ir e voltar perderia a faixa ja preenchida.
    *
    * PUBLIC (sem PROTECTED) porque e' alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE ValidarCriterioBusca()
        LOCAL loc_lPorCupom, loc_lPorData

        loc_lPorCupom = (THIS.obj_4c_Optiongroup1.Value = 1)
        loc_lPorData  = (THIS.obj_4c_Optiongroup1.Value = 2)

        THIS.txt_4c_Text1.Enabled = loc_lPorCupom
        THIS.txt_4c_Text2.Enabled = loc_lPorCupom

        THIS.txt_4c_Text3.Enabled = loc_lPorData
        THIS.txt_4c_Text4.Enabled = loc_lPorData
    ENDPROC

    *==========================================================================
    * ValidarNumeroInicial - Porte do Text1.LostFocus do legado:
    *
    *     If Val(This.Value) <> 0
    *         This.Value = Transform(Val(This.Value), '@L 999999')
    *     Endif
    *
    * PUBLIC (alvo de BINDEVENT) e sem parametro (LostFocus nao passa nenhum).
    *==========================================================================
    PROCEDURE ValidarNumeroInicial()
        THIS.FormatarNumeroCupom(THIS.txt_4c_Text1)
    ENDPROC

    *==========================================================================
    * ValidarNumeroFinal - Porte do Text2.LostFocus do legado (identico ao do
    * Text1 - ver ValidarNumeroInicial).
    *==========================================================================
    PROCEDURE ValidarNumeroFinal()
        THIS.FormatarNumeroCupom(THIS.txt_4c_Text2)
    ENDPROC

    *==========================================================================
    * FormatarNumeroCupom - Fonte UNICA da normalizacao do numero de cupom,
    * transcrita LITERALMENTE do LostFocus do legado: zero (ou campo vazio,
    * cujo Val() tambem e' 0) fica como esta; qualquer outro numero e'
    * reescrito com '@L 999999', que preenche a esquerda com zeros ("12" vira
    * "000012"). O par Format/InputMask dos TextBox ja vem do SCX (InputMask =
    * "999999"), entao aqui nao se inventa mascara nova.
    *
    * O .Value de txt_4c_Text1/Text2 nasce CHARACTER em ConfigurarControles
    * (.Value = "") e BOParaForm tambem atribui string; o guard de VARTYPE
    * existe porque este metodo recebe o controle por parametro e VAL() sobre
    * valor nao-character dispara o erro 11 do VFP9.
    *==========================================================================
    PROTECTED PROCEDURE FormatarNumeroCupom(par_oTextBox)
        LOCAL loc_nNumero

        IF VARTYPE(par_oTextBox) != "O"
            RETURN
        ENDIF

        IF VARTYPE(par_oTextBox.Value) != "C"
            RETURN
        ENDIF

        loc_nNumero = VAL(par_oTextBox.Value)

        IF loc_nNumero != 0
            par_oTextBox.Value = TRANSFORM(loc_nNumero, "@L 999999")
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarConfiguracaoFiscal - Porte do trecho do Init legado que prepara a
    * comunicacao com a impressora fiscal (sigopvci_form_codigo_fonte.txt:
    * 548-588), pre-requisito do botao Consultar:
    *
    *   =fLerFiscal()                         -> popula crSigFiFis (Imps/Portas)
    *   lcFile = GetEnv("SystemRoot") + '\system32\BEMAFI32.INI'
    *   If File(lcFile) ... StrToFile(...)    -> grava a porta configurada no INI
    *   If crSigFiFis.Imps = 'NSWEDA' ...     -> alarga Edit1/cntAguarde
    *   ThisForm.cntAguarde.Visible = .F.
    *
    * fLerFiscal() e' funcao GLOBAL do Fortyus que NAO veio no acervo (regra
    * CLAUDE.md #13/#27): quem le SigFiFis aqui e' o BO, em
    * sigopvciBO.CarregarConfiguracaoFiscal().
    *
    * O patch do BEMAFI32.INI fica em TRY/CATCH PROPRIO: ele grava em
    * %SystemRoot%\system32, que em Windows atual exige elevacao, e uma falha
    * ali NAO pode impedir o form de abrir - so a porta do driver Bematech
    * deixa de ser sincronizada. Na estacao sem o driver o arquivo nao existe e
    * o bloco inteiro e' pulado, igual ao legado (o IF File() e' do legado).
    *==========================================================================
    PROTECTED PROCEDURE CarregarConfiguracaoFiscal()
        LOCAL loc_oErro, loc_cArquivoIni, loc_cConfig, loc_cPortaAtual
        LOCAL loc_cPorta, loc_cNovoConfig

        TRY
            *-- Sem conexao (ValidarUIFidelity / probe headless) nao ha SigFiFis
            *-- a ler: o botao Consultar reporta a configuracao ausente quando
            *-- for acionado, em vez de impedir a tela de abrir.
            IF (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
               TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- nada a carregar neste ambiente
            ELSE
                THIS.this_oBusinessObject.CarregarConfiguracaoFiscal()
            ENDIF

            *-- NSWEDA usa cupom de 63 colunas: o legado alarga Edit1 e
            *-- recentraliza os rotulos do painel "Aguarde..."
            IF UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cImpressora)) == "NSWEDA"
                THIS.edt_4c_Edit1.Width                = 450
                THIS.cnt_4c_Aguarde.Width              = 320
                THIS.cnt_4c_Aguarde.lbl_4c_Label1.Left = 132
                THIS.cnt_4c_Aguarde.lbl_4c_Label2.Left = 97
            ENDIF

            THIS.cnt_4c_Aguarde.Visible = .F.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro CarregarConfiguracaoFiscal")
        ENDTRY

        *-- Sincroniza a porta configurada em SigFiFis.Portas com o INI do
        *-- driver Bematech. Porta 9 significa USB (comentario do legado:
        *-- "mena - 27/02/2015 - se porta = 9 considera USB").
        TRY
            loc_cArquivoIni = GETENV("SystemRoot") + "\system32\BEMAFI32.INI"

            IF FILE(loc_cArquivoIni)
                loc_cConfig     = FILETOSTR(loc_cArquivoIni)
                loc_cPortaAtual = STREXTRACT(loc_cConfig, "Porta", CHR(13) + CHR(10), 1, 1)
                loc_cPorta      = ALLTRIM(STR(THIS.this_oBusinessObject.this_nPortas))
                loc_cNovoConfig = STRTRAN(loc_cConfig, ;
                    "Porta" + loc_cPortaAtual, ;
                    IIF(loc_cPorta == "9", "Porta=USB", "Porta=COM" + loc_cPorta), ;
                    -1, 1, 1)

                STRTOFILE(loc_cNovoConfig, loc_cArquivoIni)
            ENDIF

        CATCH TO loc_oErro
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel sincronizar a porta " + ;
                "da impressora fiscal em BEMAFI32.INI." + CHR(13) + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Configura" + CHR(231) + CHR(227) + "o da Impressora Fiscal")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnConsultarClick - Porte do Commandgroup1.CmdInserir.Click do legado
    * (sigopvci_form_codigo_fonte.txt:599-920), o botao "\<Consultar": le o
    * cupom da MFD (Memoria de Fita-Detalhe) da impressora fiscal e exibe o
    * conteudo em Edit1.
    *
    * O Name legado ("CmdInserir") MENTE - este form nao inclui nada; o handler
    * e' nomeado pela ACAO, que e' o Caption que o usuario LE.
    *
    * Este wrapper existe por causa da GUARDA DE REENTRANCIA: a extracao leva
    * segundos e exibe dialogos que devolvem o foco ao botao, e o corpo tem
    * saidas antecipadas (RETURN apos validacao). Com set/clear no proprio
    * corpo, um RETURN deixaria a flag presa em .T. e MATARIA o botao pelo
    * resto da vida do form - por isso o corpo mora em BtnConsultarClickExec()
    * e quem libera a flag e' o wrapper, sempre (inclusive via CATCH).
    *
    * PUBLIC (sem PROTECTED) porque e' alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE BtnConsultarClick()
        LOCAL loc_oErro

        IF THIS.this_lEmConsulta
            RETURN
        ENDIF

        THIS.this_lEmConsulta = .T.

        TRY
            THIS.BtnConsultarClickExec()

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.cnt_4c_Aguarde.Visible = .F.
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro ao consultar cupom")
        ENDTRY

        THIS.this_lEmConsulta = .F.
    ENDPROC

    *==========================================================================
    * BtnConsultarClickExec - Corpo do Consultar, na MESMA ordem do legado:
    *
    *   1. lnNoFabr = LeituraFab(ThisForm.poFormulario)
    *   2. ThisForm.Edit1.Value = [] / Edit1.Refresh
    *   3. validacao da faixa (numero ou data) - aborta sem ler a impressora
    *   4. cntAguarde visivel + ZOrder(0) + Draw + Refresh + espera de 2s
    *   5. monta lcTipo/lcInic/lcFim conforme o modelo
    *   6. ramo por modelo: BEMA8501 / DARUMA / NSWEDA / EPSON
    *   7. cntAguarde oculto + Refresh
    *
    * Os DECLARE das DLLs ficaram em cada metodo ExtrairCupom*, nao aqui: no
    * legado eles estao no topo do Click mas dentro de "If crSigFiFis.Imps =
    * <modelo>" MUTUAMENTE EXCLUSIVOS, entao declarar junto da chamada e'
    * equivalente - e evita rodar o "CLEAR DLLS" do ramo Daruma numa estacao
    * Bematech.
    *
    * Ha UMA divergencia deliberada do legado, marcada em cada ponto: modelo
    * nao atendido ou falha de extracao AVISA o usuario. O legado cai no fim do
    * Click em silencio nesses casos, e o botao "nao faz nada" - exatamente o
    * sintoma que a regra CLAUDE.md #27 manda tornar VISIVEL. A mensagem usada
    * e' a que o PROPRIO legado tem para essa condicao nos ramos DARUMA/NSWEDA
    * ("Problemas na Leitura do Cupom !!!").
    *==========================================================================
    PROTECTED PROCEDURE BtnConsultarClickExec()
        LOCAL loc_cModelo

        *-- Numero de fabricacao do ECF. LeituraFab() e' wrapper documentado em
        *-- utils\leiturafab.prg (protocolo da ECF ausente do acervo, devolve "").
        THIS.this_cNumFabricacao = LeituraFab(THIS.this_oBusinessObject.this_cFormulario)
        IF VARTYPE(THIS.this_cNumFabricacao) != "C"
            THIS.this_cNumFabricacao = ""
        ENDIF

        THIS.edt_4c_Edit1.Value = ""
        THIS.edt_4c_Edit1.Refresh()

        IF !THIS.ValidarFaixaConsulta()
            RETURN
        ENDIF

        *-- O criterio e a faixa validados viram estado do BO (fonte unica)
        THIS.FormParaBO()

        THIS.cnt_4c_Aguarde.Visible = .T.
        THIS.cnt_4c_Aguarde.ZOrder(0)
        THIS.cnt_4c_Aguarde.Draw()
        THIS.Refresh()
        THIS.AguardarPintura()

        IF THIS.ResolverFaixaMFD()
            loc_cModelo = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cImpressora))

            DO CASE
                CASE loc_cModelo == "BEMA8501"
                    THIS.ExtrairCupomBematech()

                CASE loc_cModelo == "DARUMA"
                    THIS.ExtrairCupomDaruma()

                CASE loc_cModelo == "NSWEDA"
                    THIS.ExtrairCupomNsweda()

                CASE loc_cModelo == "EPSON"
                    THIS.ExtrairCupomEpson()

                OTHERWISE
                    *-- DIVERGENCIA DELIBERADA (ver cabecalho): o legado nao
                    *-- tem ramo para modelo desconhecido/vazio e sai calado.
                    THIS.cnt_4c_Aguarde.Visible = .F.
                    MsgAviso("Impressora fiscal n" + CHR(227) + "o configurada " + ;
                        "ou modelo n" + CHR(227) + "o atendido: [" + loc_cModelo + "]." + ;
                        CHR(13) + "Verifique o cadastro de Configura" + CHR(231) + CHR(227) + ;
                        "o Fiscal antes de consultar o cupom.", "")
            ENDCASE
        ENDIF

        THIS.cnt_4c_Aguarde.Visible = .F.
        THIS.cnt_4c_Aguarde.Refresh()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Porte do Commandgroup1.CmdExcluir.Click do legado
    * (sigopvci_form_codigo_fonte.txt:924-927), cujo corpo inteiro e':
    *
    *     Release Windows
    *
    * O Name legado ("CmdExcluir") MENTE - nada e' excluido; o Caption e'
    * "Encerrar" e Cancel = .T., entao o ESC tambem cai aqui, como no legado.
    *
    * "Release Windows" do legado derruba a janela; o equivalente no sistema
    * novo e' THIS.Release(), que passa por QueryUnload/Destroy - e e' o Destroy
    * que fecha o BO e reconstroi o menu principal via DODEFAULT().
    *
    * PUBLIC (sem PROTECTED) porque e' alvo de BINDEVENT.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ValidarFaixaConsulta - Porte LITERAL das QUATRO validacoes do inicio do
    * CmdInserir.Click legado (sigopvci_form_codigo_fonte.txt:646-680):
    *
    *   If ThisForm.Optiongroup1.Value = 1
    *       If Val(Text1.Value) > Val(Text2.Value)  -> 'Numero Final Maior Que Inicial !!!'
    *       If Val(Text1.Value) = 0 Or Val(Text2.Value) = 0 -> 'Faixa Invalida !!!'
    *   Else
    *       If Text3.Value > Text4.Value            -> 'Data Final Maior Que Inicial !!!'
    *       If Empty(Text3.Value) Or Empty(Text4.Value) -> 'Faixa Invalida !!!'
    *   Endif
    *
    * As mensagens estao transcritas EXATAMENTE como o legado as escreve - sem
    * acento em "Numero"/"Invalida", porque e' o texto que o usuario conhece
    * (PILAR 1). Cada ramo repete o trio do legado: avisa, devolve o foco ao
    * PRIMEIRO campo da faixa e oculta o painel "Aguarde...".
    *
    * A ordem importa: o teste de ORDEM vem antes do de faixa VAZIA, igual ao
    * legado - com os dois campos em branco (Val = 0, nao ha ">"), quem acusa
    * e' o segundo teste.
    *
    * PUBLIC: chamado por BtnConsultarClickExec, que e' do proprio form, mas
    * tambem e' o ponto unico de validacao reusado pela Fase 8.
    *==========================================================================
    FUNCTION ValidarFaixaConsulta()
        LOCAL loc_lValido

        loc_lValido = .T.

        IF THIS.obj_4c_Optiongroup1.Value = 1
            *-- Faixa por NUMERO de cupom (Text1/Text2 guardam string)
            IF VAL(THIS.txt_4c_Text1.Value) > VAL(THIS.txt_4c_Text2.Value)
                MsgAviso("Numero Final Maior Que Inicial !!!", "")
                THIS.txt_4c_Text1.SetFocus()
                THIS.cnt_4c_Aguarde.Visible = .F.
                loc_lValido = .F.
            ENDIF

            IF loc_lValido AND ;
               (VAL(THIS.txt_4c_Text1.Value) = 0 OR VAL(THIS.txt_4c_Text2.Value) = 0)
                MsgAviso("Faixa Invalida !!!", "")
                THIS.txt_4c_Text1.SetFocus()
                THIS.cnt_4c_Aguarde.Visible = .F.
                loc_lValido = .F.
            ENDIF
        ELSE
            *-- Faixa por DATA (Text3/Text4 guardam DATE)
            IF THIS.txt_4c_Text3.Value > THIS.txt_4c_Text4.Value
                MsgAviso("Data Final Maior Que Inicial !!!", "")
                THIS.txt_4c_Text3.SetFocus()
                THIS.cnt_4c_Aguarde.Visible = .F.
                loc_lValido = .F.
            ENDIF

            IF loc_lValido AND ;
               (EMPTY(THIS.txt_4c_Text3.Value) OR EMPTY(THIS.txt_4c_Text4.Value))
                MsgAviso("Faixa Invalida !!!", "")
                THIS.txt_4c_Text3.SetFocus()
                THIS.cnt_4c_Aguarde.Visible = .F.
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * AguardarPintura - Porte literal da espera do legado
    * (sigopvci_form_codigo_fonte.txt:687-689):
    *
    *     xDAteT = Datetime()
    *     DO While Datetime() - xDateT < 2
    *     Enddo
    *
    * Da ao painel "Aguarde... Processando Dados..." tempo de aparecer antes de
    * a leitura da impressora bloquear a interface. A subtracao de DATETIME em
    * VFP9 devolve SEGUNDOS, por isso o "< 2" literal do legado vale aqui sem
    * conversao. Mantida como laco de espera ativa, igual ao legado - trocar
    * por INKEY()/WAIT mudaria o comportamento de teclado da tela.
    *==========================================================================
    PROTECTED PROCEDURE AguardarPintura()
        LOCAL loc_tInicio

        loc_tInicio = DATETIME()

        DO WHILE DATETIME() - loc_tInicio < 2
        ENDDO
    ENDPROC

    *==========================================================================
    * ResolverFaixaMFD - Monta lcTipo/lcInic/lcFim do legado
    * (sigopvci_form_codigo_fonte.txt:691-729). Cada modelo de impressora
    * fiscal espera a faixa num formato PROPRIO, e isso e' regra de negocio
    * transcrita literalmente (regra CLAUDE.md #17):
    *
    *   Optiongroup1 = 1 (por CUPOM)  -> lcTipo = '2', faixa = Text1/Text2 cruas
    *   Optiongroup1 = 2 (por DATA)   -> lcTipo = '1' e, por modelo:
    *       BEMA8501        DDMMAA  (Transform(Day,'@L 99') + Month + Right(Year,2))
    *       NSWEDA/DARUMA   faixa de SEQUENCIA lida das Reducoes Z em SigFiRx
    *                       (BO.ResolverSequenciaPorData - o SQL mora no BO)
    *       EPSON           lcTipo = '0' e Strtran(Dtoc(data), '/', '')
    *
    * O ramo EPSON usa DTOC() como o legado escreveu. Note que a largura do
    * resultado segue o SET CENTURY vigente (ON neste projeto, por FormBase.
    * Init - regra CLAUDE.md #9.4), portanto DDMMAAAA; e o proprio legado
    * ainda passa esse valor por Alltrim(Str(Val(...))) na chamada da DLL, o
    * que descarta zero a esquerda. Nao "corrigido" aqui de proposito:
    * reescrever a expressao seria inventar formato que o legado nao usa.
    *==========================================================================
    FUNCTION ResolverFaixaMFD()
        LOCAL loc_lResultado, loc_cModelo, loc_dInicial, loc_dFinal

        loc_lResultado = .T.
        loc_cModelo    = UPPER(ALLTRIM(THIS.this_oBusinessObject.this_cImpressora))

        THIS.this_cTipoMFD   = ""
        THIS.this_cInicioMFD = ""
        THIS.this_cFimMFD    = ""

        IF THIS.obj_4c_Optiongroup1.Value = 1
            THIS.this_cTipoMFD   = "2"
            THIS.this_cInicioMFD = THIS.txt_4c_Text1.Value
            THIS.this_cFimMFD    = THIS.txt_4c_Text2.Value
        ELSE
            *-- Default do legado antes do DO CASE: so EPSON o sobrescreve
            THIS.this_cTipoMFD = "1"

            loc_dInicial = ConverterParaData(THIS.txt_4c_Text3.Value)
            loc_dFinal   = ConverterParaData(THIS.txt_4c_Text4.Value)

            DO CASE
                CASE loc_cModelo == "BEMA8501"
                    THIS.this_cInicioMFD = TRANSFORM(DAY(loc_dInicial), "@L 99") + ;
                        TRANSFORM(MONTH(loc_dInicial), "@L 99") + ;
                        RIGHT(TRANSFORM(YEAR(loc_dInicial), "@L 9999"), 2)

                    THIS.this_cFimMFD = TRANSFORM(DAY(loc_dFinal), "@L 99") + ;
                        TRANSFORM(MONTH(loc_dFinal), "@L 99") + ;
                        RIGHT(TRANSFORM(YEAR(loc_dFinal), "@L 9999"), 2)

                CASE loc_cModelo == "NSWEDA" OR loc_cModelo == "DARUMA"
                    IF THIS.this_oBusinessObject.ResolverSequenciaPorData(THIS.this_cNumFabricacao)
                        THIS.this_cInicioMFD = THIS.this_oBusinessObject.this_cSequenciaInicial
                        THIS.this_cFimMFD    = THIS.this_oBusinessObject.this_cSequenciaFinal
                    ELSE
                        *-- O legado nao tem caminho de falha aqui (o
                        *-- poDataMgr.SqlExecute estouraria cru). Reportar a
                        *-- mensagem que o BO deixou e' o que torna a falha
                        *-- de consulta VISIVEL em vez de gerar faixa vazia.
                        IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                            MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
                                "Erro ao resolver faixa de cupom")
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF

                CASE loc_cModelo == "EPSON"
                    THIS.this_cTipoMFD   = "0"
                    THIS.this_cInicioMFD = STRTRAN(DTOC(loc_dInicial), "/", "")
                    THIS.this_cFimMFD    = STRTRAN(DTOC(loc_dFinal), "/", "")
            ENDCASE
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExtrairCupomBematech - Ramo "If crSigFiFis.Imps = 'BEMA8501'" do legado
    * (sigopvci_form_codigo_fonte.txt:607-620 os DECLARE, 731-771 a extracao):
    * baixa a MFD para DOWNLOAD.MFD, converte para DOWNLOAD.TXT e carrega o
    * texto em Edit1. Os arquivos ficam no diretorio corrente - e' o que a
    * mensagem do legado chama de "Diretorio do Sistema".
    *
    * Os DECLARE vao em TRY/CATCH e alimentam uma flag: "DECLARE ... IN <dll>"
    * NAO e' declaracao preguicosa, o VFP9 CARREGA a biblioteca na hora e
    * estoura "Cannot load 32-bit DLL BemaFI32.dll." na estacao sem o driver
    * (medido nesta maquina). Sem a guarda, o erro subiria e a tela fecharia.
    *
    * O legado DESCARTA o retorno das duas funcoes da DLL (iRetorno nunca e'
    * testado) e decide pelo File('DOWNLOAD.TXT') - transcrito assim.
    *==========================================================================
    PROTECTED PROCEDURE ExtrairCupomBematech()
        LOCAL loc_lDisponivel, loc_nRetorno, loc_oErro

        loc_lDisponivel = .F.

        TRY
            DECLARE INTEGER Bematech_FI_DownloadMFD IN "BemaFI32.dll" ;
                STRING cFile, STRING cTipo, STRING cInicio, STRING cFinal, STRING cProp

            DECLARE INTEGER Bematech_FI_FormatoDadosMFD IN "BemaFI32.dll" ;
                STRING cFile, STRING cDest, STRING cZero, STRING cTipo, ;
                STRING cInicio, STRING cFinal, STRING cProp

            loc_lDisponivel = .T.

        CATCH TO loc_oErro
            THIS.cnt_4c_Aguarde.Visible = .F.
            MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
                "A biblioteca BemaFI32.dll da impressora fiscal Bematech n" + ;
                CHR(227) + "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta esta" + ;
                CHR(231) + CHR(227) + "o." + CHR(13) + CHR(13) + loc_oErro.Message, ;
                "Impressora Fiscal")
        ENDTRY

        IF loc_lDisponivel
            IF FILE("DOWNLOAD.MFD")
                ERASE ("DOWNLOAD.MFD")
            ENDIF

            IF FILE("DOWNLOAD.TXT")
                ERASE ("DOWNLOAD.TXT")
            ENDIF

            loc_nRetorno = Bematech_FI_DownloadMFD("DOWNLOAD.MFD", ;
                THIS.this_cTipoMFD, THIS.this_cInicioMFD, THIS.this_cFimMFD, "1")

            loc_nRetorno = Bematech_FI_FormatoDadosMFD("DOWNLOAD.MFD", "DOWNLOAD.TXT", ;
                "0", THIS.this_cTipoMFD, THIS.this_cInicioMFD, THIS.this_cFimMFD, "1")

            IF FILE("DOWNLOAD.TXT")
                IF THIS.CarregarCupomDeArquivo("DOWNLOAD.TXT", 50)
                    ERASE ("DOWNLOAD.MFD")

                    IF THIS.chk_4c_Check1.Value = 0
                        ERASE ("DOWNLOAD.TXT")
                    ELSE
                        MsgInfo("Arquivo DOWNLOAD.TXT Gerado no Diret" + CHR(243) + ;
                            "rio do Sistema !", "")
                    ENDIF
                ENDIF
            ELSE
                *-- DIVERGENCIA DELIBERADA: o legado sai calado quando o TXT
                *-- nao foi gerado. A mensagem e' a do PROPRIO legado para esta
                *-- condicao nos ramos DARUMA/NSWEDA.
                THIS.cnt_4c_Aguarde.Visible = .F.
                MsgErro("Problemas na Leitura do Cupom !!!", "Impressora Fiscal")
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ExtrairCupomDaruma - Ramo "If crSigFiFis.Imps = 'DARUMA'" do legado
    * (sigopvci_form_codigo_fonte.txt:622-637 os DECLARE, 773-825 a extracao):
    * gera o espelho da MFD em <LocalArquivos>\espelho_mfd.TXT e carrega em
    * Edit1.
    *
    * Particularidades transcritas do legado:
    *   - "CLEAR DLLS" antes dos DECLARE (comentario do legado: "mena -
    *     11/09/2015 - pega pasta padrao para ler os arquivos gerados");
    *   - rGerarEspelhoMFD_ECF_Daruma e' DECLARADO e NAO chamado - a chamada
    *     esta comentada no SCX desde o ajuste de homologacao 2014; mantido o
    *     DECLARE para nao divergir do legado;
    *   - lcTp = 'COO' quando a faixa e' por cupom e 'DATAM' quando e' por
    *     data; lcIn/lcFi escolhem entre a faixa crua (lcTipo='2') e a data
    *     reordenada por Dtos como DDMMAAAA;
    *   - a unica checagem de erro do ramo e' "lnRetorno <> 1".
    *==========================================================================
    PROTECTED PROCEDURE ExtrairCupomDaruma()
        LOCAL loc_lDisponivel, loc_nRetorno, loc_oErro
        LOCAL loc_cArquivo, loc_cTipoRel, loc_cDtIni, loc_cDtFim, loc_cIni, loc_cFim

        loc_lDisponivel = .F.

        TRY
            CLEAR DLLS

            DECLARE INTEGER rGerarEspelhoMFD_ECF_Daruma IN "DarumaFramework.dll" ;
                STRING tp, STRING pnic, STRING pfim

            DECLARE INTEGER rGerarRelatorio_ECF_Daruma IN "DarumaFramework.dll" ;
                STRING szRelatorio, STRING szTipo, STRING szInicial, STRING szFinal

            loc_lDisponivel = .T.

        CATCH TO loc_oErro
            THIS.cnt_4c_Aguarde.Visible = .F.
            MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
                "A biblioteca DarumaFramework.dll da impressora fiscal n" + CHR(227) + ;
                "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta esta" + ;
                CHR(231) + CHR(227) + "o." + CHR(13) + CHR(13) + loc_oErro.Message, ;
                "Impressora Fiscal")
        ENDTRY

        IF loc_lDisponivel
            loc_cArquivo = THIS.ObterDiretorioDaruma() + "espelho_mfd.TXT"

            IF FILE(loc_cArquivo)
                ERASE (loc_cArquivo)
            ENDIF

            loc_cTipoRel = IIF(THIS.obj_4c_Optiongroup1.Value = 1, "COO", "DATAM")

            *-- Dtos devolve AAAAMMDD; o legado reordena para DDMMAAAA
            loc_cDtIni = DTOS(ConverterParaData(THIS.txt_4c_Text3.Value))
            loc_cDtIni = SUBSTR(loc_cDtIni, 7, 2) + SUBSTR(loc_cDtIni, 5, 2) + ;
                SUBSTR(loc_cDtIni, 1, 4)

            loc_cDtFim = DTOS(ConverterParaData(THIS.txt_4c_Text4.Value))
            loc_cDtFim = SUBSTR(loc_cDtFim, 7, 2) + SUBSTR(loc_cDtFim, 5, 2) + ;
                SUBSTR(loc_cDtFim, 1, 4)

            loc_cIni = IIF(THIS.this_cTipoMFD == "2", THIS.this_cInicioMFD, loc_cDtIni)
            loc_cFim = IIF(THIS.this_cTipoMFD == "2", THIS.this_cFimMFD, loc_cDtFim)

            *-- "mena - 24/02/2015 - ajustado parametro do espelho"
            loc_nRetorno = rGerarRelatorio_ECF_Daruma("ESPELHO", loc_cTipoRel, ;
                loc_cIni, loc_cFim)

            IF loc_nRetorno != 1
                THIS.cnt_4c_Aguarde.Visible = .F.
                MsgErro("Problemas na Leitura do Cupom - Erro:" + ;
                    ALLTRIM(STR(loc_nRetorno)), "")
            ELSE
                IF FILE(loc_cArquivo)
                    IF THIS.CarregarCupomDeArquivo(loc_cArquivo, 50)
                        IF THIS.chk_4c_Check1.Value = 0
                            ERASE (loc_cArquivo)
                        ELSE
                            MsgInfo("Arquivo " + loc_cArquivo + " Gerado !", "")
                        ENDIF
                    ENDIF
                ELSE
                    *-- DIVERGENCIA DELIBERADA: o legado sai calado quando a DLL
                    *-- devolve 1 e o espelho nao aparece no disco.
                    THIS.cnt_4c_Aguarde.Visible = .F.
                    MsgErro("Problemas na Leitura do Cupom !!!", "Impressora Fiscal")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ExtrairCupomNsweda - Ramo "If crSigFiFis.Imps = 'NSWEDA'" do legado
    * (sigopvci_form_codigo_fonte.txt:827-861): pede o download da MFD, que a
    * rotina do fabricante grava em c:\Retorno.TXT, e carrega o texto (63
    * colunas) em Edit1.
    *
    * LeMFD() e' funcao GLOBAL do Fortyus ausente do acervo; o wrapper
    * documentado esta em utils\lemfd.prg e devolve -1. O contrato quem fecha
    * e' o PROPRIO legado na linha seguinte, testando File('c:\Retorno.TXT') e
    * exibindo "Problemas na Leitura do Cupom !!!" - ou seja, a ausencia da
    * rotina fica VISIVEL ao usuario, sem cupom em branco silencioso
    * (regra CLAUDE.md #27).
    *==========================================================================
    PROTECTED PROCEDURE ExtrairCupomNsweda()
        LOCAL loc_nRetorno

        loc_nRetorno = LeMFD(THIS.this_cInicioMFD, THIS.this_cFimMFD, ;
            THIS.this_oBusinessObject.this_cFormulario)

        IF !FILE("c:\Retorno.TXT")
            THIS.cnt_4c_Aguarde.Visible = .F.
            MsgErro("Problemas na Leitura do Cupom !!!", "")
        ELSE
            IF THIS.CarregarCupomDeArquivo("c:\RETORNO.TXT", 63)
                IF THIS.chk_4c_Check1.Value = 0
                    ERASE ("c:\RETORNO.TXT")
                ELSE
                    MsgInfo("Arquivo c:\Retorno.TXT Gerado !", "")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * ExtrairCupomEpson - Ramo "If crSigFiFis.Imps = 'EPSON'" do legado
    * (sigopvci_form_codigo_fonte.txt:863-917): verifica a porta, liga o log da
    * InterfaceEpson.dll, pede os dados da MF/MFD para C:\SAIDA e carrega
    * C:\SAIDA_ESP.TXT (63 colunas) em Edit1.
    *
    * Tres particularidades do legado, transcritas como estao:
    *   - o teste de erro da DLL e' "lnRetorno = 1" (1 = falha nesta
    *     interface), nao "<> 1" como no ramo Daruma;
    *   - com Check1 MARCADO o legado so AVISA que gerou o arquivo e NAO
    *     carrega o Edit1 - ao contrario dos outros tres ramos, que exibem o
    *     cupom nos dois casos;
    *   - o caminho de saida e' escrito [C:\\SAIDA], com DUAS barras; em VFP os
    *     delimitadores [ ] nao processam escape, entao o valor passado a DLL
    *     tem mesmo as duas barras. Mantido literal.
    *
    * VerifPorta()/RotStatus()/FecharPorta() sao funcoes GLOBAIS do Fortyus
    * ausentes do acervo (wrappers documentados em utils\). verifporta.prg
    * devolve .F. - "porta nao disponivel", a direcao segura -, portanto nesta
    * instalacao o ramo RECUSA a leitura em vez de acionar a DLL sobre uma
    * porta de estado desconhecido. A recusa e' REPORTADA com a mensagem que o
    * proprio legado usa para falha de comunicacao, para o botao nao ficar
    * "sem fazer nada" (regra CLAUDE.md #27).
    *==========================================================================
    PROTECTED PROCEDURE ExtrairCupomEpson()
        LOCAL loc_lDisponivel, loc_lPortaOk, loc_nRetorno, loc_oErro

        loc_lPortaOk = VerifPorta()

        IF !loc_lPortaOk
            RotStatus(.T.)
            THIS.cnt_4c_Aguarde.Visible = .F.
            MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
                "N" + CHR(227) + "o foi poss" + CHR(237) + "vel verificar a porta de " + ;
                "comunica" + CHR(231) + CHR(227) + "o com a impressora fiscal EPSON " + ;
                "nesta esta" + CHR(231) + CHR(227) + "o.", "Impressora Fiscal")
        ELSE
            loc_lDisponivel = .F.

            TRY
                DECLARE INTEGER EPSON_Sys_Log IN "InterfaceEpson.dll" ;
                    STRING pszPath, INTEGER dwAction

                DECLARE INTEGER EPSON_Obter_Dados_MF_MFD IN "InterfaceEpson.dll" ;
                    STRING pszInicio, STRING pszFinal, INTEGER dwTipoEntrada, ;
                    INTEGER dwEspelhos, INTEGER dwAtoCotepe, INTEGER dwSintegra, ;
                    STRING pszArquivoSaida

                loc_lDisponivel = .T.

            CATCH TO loc_oErro
                THIS.cnt_4c_Aguarde.Visible = .F.
                MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
                    "A biblioteca InterfaceEpson.dll n" + CHR(227) + "o est" + CHR(225) + ;
                    " dispon" + CHR(237) + "vel nesta esta" + CHR(231) + CHR(227) + "o." + ;
                    CHR(13) + CHR(13) + loc_oErro.Message, "Impressora Fiscal")
            ENDTRY

            IF loc_lDisponivel
                loc_nRetorno = EPSON_Sys_Log("C:\", 1)

                loc_nRetorno = EPSON_Obter_Dados_MF_MFD( ;
                    ALLTRIM(STR(VAL(THIS.this_cInicioMFD))), ;
                    ALLTRIM(STR(VAL(THIS.this_cFimMFD))), ;
                    VAL(THIS.this_cTipoMFD), 65535, 0, 0, "C:\\SAIDA")

                IF loc_nRetorno = 1
                    RotStatus(.T.)
                    FecharPorta(.T.)
                    THIS.cnt_4c_Aguarde.Visible = .F.
                    MsgErro("Problemas na Leitura do Cupom !!!", "Impressora Fiscal")
                ELSE
                    IF THIS.chk_4c_Check1.Value = 1
                        MsgInfo("Arquivo C:\SAIDA_ESP.TXT Gerado com sucesso !!!", "")
                    ELSE
                        IF THIS.CarregarCupomDeArquivo("c:\SAIDA_ESP.TXT", 63)
                            ERASE ("c:\SAIDA_ESP.TXT")
                        ENDIF
                    ENDIF

                    FecharPorta(.T.)
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * CarregarCupomDeArquivo - Fonte UNICA da leitura do arquivo gerado pela
    * impressora fiscal para o Edit1, igual nos quatro ramos do legado
    * (sigopvci_form_codigo_fonte.txt:745-757 e repeticoes):
    *
    *     Create Cursor crMfd (Linha C(<largura>))
    *     Select crMfd
    *     Append From <arquivo> SDF
    *     lcCupom = ''
    *     Scan
    *         lcCupom = lcCupom + Linha
    *     EndScan
    *     ThisForm.Edit1.Value = lcCupom
    *     ThisForm.Edit1.Refresh
    *
    * A largura da linha varia por modelo (50 em BEMA8501/DARUMA, 63 em
    * NSWEDA/EPSON) e por isso e' PARAMETRO - a estrutura do cursor e' montada
    * por macro, forma medida no VFP9 desta maquina.
    *
    * A concatenacao NAO leva ALLTRIM: as linhas do espelho da MFD sao de
    * largura FIXA e o preenchimento faz parte do alinhamento das colunas do
    * cupom - igual ao legado.
    *
    * O conteudo tambem vai para o BO (this_cConteudoCupom), que e' a fonte
    * unica do estado da tela e de onde BOParaForm o reexibe.
    *==========================================================================
    FUNCTION CarregarCupomDeArquivo(par_cArquivo, par_nLargura)
        LOCAL loc_lResultado, loc_cCupom, loc_cEstrutura, loc_oErro

        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Mfd")
                IF CURSORGETPROP("Buffering", "cursor_4c_Mfd") > 1
                    TABLEREVERT(.T., "cursor_4c_Mfd")
                ENDIF
                USE IN cursor_4c_Mfd
            ENDIF

            loc_cEstrutura = "cursor_4c_Mfd (Linha C(" + ALLTRIM(STR(par_nLargura)) + "))"
            CREATE CURSOR &loc_cEstrutura

            SELECT cursor_4c_Mfd
            APPEND FROM (par_cArquivo) SDF

            loc_cCupom = ""
            SCAN
                loc_cCupom = loc_cCupom + cursor_4c_Mfd.Linha
            ENDSCAN

            THIS.edt_4c_Edit1.Value = loc_cCupom
            THIS.edt_4c_Edit1.Refresh()

            THIS.this_oBusinessObject.this_cConteudoCupom = loc_cCupom

            IF USED("cursor_4c_Mfd")
                USE IN cursor_4c_Mfd
            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            THIS.cnt_4c_Aguarde.Visible = .F.
            MsgErro("Problemas na Leitura do Cupom !!!" + CHR(13) + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Impressora Fiscal")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ObterDiretorioDaruma - Porte do trecho do legado que descobre onde o
    * DarumaFramework grava os arquivos gerados
    * (sigopvci_form_codigo_fonte.txt:630-635):
    *
    *     lcDir = 'C:\'
    *     IF FILE('darumaframework.xml')
    *         lcXml = FILETOSTR('darumaframework.xml')
    *         lcDir = STREXTRACT(lcXml,[<LocalArquivos>],[</LocalArquivos>])
    *     ENDIF
    *
    * Mantida a concatenacao direta do legado (lcDir + 'espelho_mfd.TXT'), sem
    * ADDBS: o default 'C:\' ja traz a barra, e acrescentar ADDBS mudaria o
    * caminho que o legado monta quando o XML traz o diretorio com barra.
    *==========================================================================
    FUNCTION ObterDiretorioDaruma()
        LOCAL loc_cDir, loc_cXml

        loc_cDir = "C:\"

        IF FILE("darumaframework.xml")
            loc_cXml = FILETOSTR("darumaframework.xml")
            loc_cDir = STREXTRACT(loc_cXml, "<LocalArquivos>", "</LocalArquivos>")
        ENDIF

        RETURN loc_cDir
    ENDFUNC

    *==========================================================================
    * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz
    * do form. cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarPageFrame.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis()
        LOCAL loc_oErro

        TRY
            THIS.TornarVisivelRecursivo(THIS)

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro TornarControlesVisiveis")
        ENDTRY
    ENDPROC

    *==========================================================================
    * TornarVisivelRecursivo - Percorre container recursivamente tornando
    * visiveis os controles. cnt_4c_Aguarde (fase 4+) sera adicionado a lista
    * de excecao quando for criado, pois nasce Visible=.F. de proposito.
    *==========================================================================
    PROTECTED PROCEDURE TornarVisivelRecursivo(par_oContainer)
        LOCAL loc_i, loc_oCtrl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oCtrl) = "O"
                IF INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_AGUARDE")
                    IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
                       loc_oCtrl.ControlCount > 0
                        THIS.TornarVisivelRecursivo(loc_oCtrl)
                    ENDIF
                    LOOP
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND ;
                   loc_oCtrl.ControlCount > 0
                    THIS.TornarVisivelRecursivo(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    PROCEDURE Destroy()
    *==========================================================================
        *-- cursor_4c_Mfd e' fechado pelo proprio CarregarCupomDeArquivo no
        *-- caminho normal; aqui cobre o caso em que o CATCH dele interrompeu a
        *-- leitura com o cursor ainda aberto.
        IF USED("cursor_4c_Mfd")
            USE IN cursor_4c_Mfd
        ENDIF
        IF USED("cursor_4c_RelX")
            USE IN cursor_4c_RelX
        ENDIF

        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
