*==============================================================================
* Formsigopets.prg - Impressao de Etiquetas de Produto
*
* Legado : SIGOPETS.SCX ("SigOpEtS" no Do Form do chamador)
*          tasks\task733\sigopets_form_codigo_fonte.txt
* Herda  : FormBase
* Tipo   : OPERACIONAL - dialogo FILHO, layout FLAT (sem PageFrame)
*
*------------------------------------------------------------------------------
* FUNCAO DA TELA
*
* Dialogo de configuracao de impressao de etiquetas, aberto pelo movimento
* (SIGMVCAB) depois de montar os cursores de cabecalho/itens do movimento.
* O usuario escolhe o tipo de etiqueta, a impressora e os ajustes de
* hardware, e dispara a impressao. NAO grava nada no SQL Server - a
* "gravacao" desta tela eh fisica (envio para a impressora via SigOpEtq()).
*
* Nao existe Page, nao existe PageFrame: os 34 objetos do dump penduram
* direto na Form ou num dos DOIS containers dela (cntSombra e
* Cnt_Impressora) - por isso NAO ha a compensacao de +29 pixels dos forms
* paginados, e os Top/Left do dump entram CRUS.
*
*------------------------------------------------------------------------------
* CONTRATO COM O FORM PAI (transcrito do legado)
*
*    SIGOPETS.Init : Lparameters pForm, pnDatSes
*                    Thisform.ParentForm = pForm
*                    Set DataSession To pnDatSes
*
* O legado declara DataSession = 2 na classe (private, para isolar os SETs
* de ambiente) e IMEDIATAMENTE troca para a datasession do PAI dentro do
* Init, porque os cursores que o BO le (TprMvCab, crSigMvNfi, dbImpressao,
* CrSigCdPam - ver cabecalho de sigopetsBO.prg) sao MONTADOS pelo form pai
* e vivem na sessao dele. Sem a troca, EVALUATE("TprMvCab.Dopes") dentro
* do BO nao acharia o alias.
*
* A mesma necessidade existe aqui: o BO (Fases 1-2) ja assume, por
* contrato documentado, que esses quatro cursores estao ALCANCAVEIS no
* momento em que seus metodos rodam. Por isso este form recebe os DOIS
* parametros do legado (par_oFormPai, par_nDataSessionIdPai) e usa
* DataSession = 1 (compartilhada) em vez do 2 do dump - mesma solucao,
* pelo mesmo motivo, que FormSigOpEtqDoc.prg ja adotou para o caso irmao
* (ver o bloco de comentario da linha 36 daquela classe): com sessao
* PROPRIA (2) o form nunca veria os cursores do pai sem repetir a troca de
* sessao em CADA metodo que os toca; com sessao COMPARTILHADA (1) ele
* enxerga o que estiver aberto, igual ao legado depois do "Set DataSession
* To pnDatSes". this_nDataSessionIdPai fica guardado para as fases de
* evento (6-8) aplicarem "SET DATASESSION TO" pontualmente, caso o form
* pai (fora do escopo desta task) venha a usar sessao privada de verdade.
*
*------------------------------------------------------------------------------
* ESCOPO DESTA FASE (3/8 - Estrutura Base)
*
* DEFINE CLASS + propriedades visuais do dump, Init completo (contexto do
* pai + instanciacao do BO + chamada a InicializarForm), InicializarForm
* como orquestrador, os DOIS containers de topo do layout legado
* (cnt_4c_Sombra com a faixa do titulo, e cnt_4c__Impressora, a moldura
* dos ajustes de hardware) e Destroy.
*
* Os CONTROLES de dados entram nas fases seguintes, cada um junto do
* objeto que ele acompanha no dump:
*   - Fase 4 (ENTREGUE): shp_4c_Shape2/shp_4c_Shape3 (molduras
*     transparentes); obj_4c_BtnReport (estrutura - sem .Click, que
*     fica para a Fase 7-8); obj_4c_Opt_Tipo (OptionGroup dinamico -
*     ButtonCount/Caption/Tag/Top vem de sigopetsBO.CarregarTiposEtiqueta()/
*     ObterIndiceTipoEtiquetaPadrao(), ja entregues nas Fases 1-2); os
*     filhos de cnt_4c__Impressora (obj_4c_Opcao_imp, os 4 spinners de
*     ajuste, chk_4c_Opt_Qtd e os 4 rotulos Say2..Say5).
*   - Fase 5 (ENTREGUE): o bloco da IMPRESSORA - lbl_4c_Label2 "Etiquetas" e
*     lbl_4c_Label4 "Impressoras" (os rotulos das duas molduras),
*     lbl_4c_Label5 "Sistema"/lbl_4c_Label6 "Windows" (cabecalho das duas
*     metades do combo), cbo_4c_Get_Printer (combo das impressoras, com a
*     carga de crImpreV por sigopetsBO.CarregarImpressorasDisponiveis()) e
*     obj_4c_Opt_Impressora (grupo de radios que o legado APOSENTOU - criado
*     fiel ao dump, com Option1 invisivel/desabilitado, porque o Init legado
*     ainda dispara o InteractiveChange dele). Entra junto
*     RestaurarOcultosDoDump(), que repoe esse Option1 oculto DEPOIS da
*     varredura de TornarControlesVisiveis.
*   - Fase 6 (ENTREGUE): o bloco de OPCOES de impressao, a direita
*     (Left 434..663) - obj_4c_Opt_Preco + lbl_4c_Label1 "Preco :",
*     obj_4c_Opt_separador + lbl_4c_Lbl_Separador "Separadora :",
*     obj_4c_OptOrdem + lbl_4c_Label3 "Ordem :" e obj_4c_OptOrigem +
*     lbl_4c_Label7 "Origem :" (ConfigurarOpcoesImpressao) - mais os
*     defaults que o Init legado aplica neles (CrSigCdPac.etqseps = 1 ->
*     opt_separador) e nos spinners/Opcao_imp da Fase 4, via
*     sigopetsBO.ObterParametrosPadraoImpressao() (ja entregue nas Fases
*     1-2) - AplicarParametrosPadraoImpressao().
*
*     Entra junto o LOOKUP desta tela. NAO ha lookup de TABELA (picker/F4):
*     confirmado em tasks\task733\analise.json/comportamento.json
*     ("temLookup": false nos 6 metodos) e no dump (zero fwBuscaExt/
*     fwBuscaSel/fwBuscaInt/sigacess/mAddColuna) - os campos restantes sao
*     OptionGroup, nao TextBox com F4. O que ESTA no lugar do lookup eh a
*     resolucao da IMPRESSORA: escolher uma no combo recarrega os campos
*     que dependem dela (tipo + os 4 ajustes de hardware), que eh o que o
*     legado faz chamando fCarregarImps nos dois InteractiveChange do dump
*     (Get_Printer e Opt_Impressora) e tambem direto no Init (linha 1180).
*     Entregue aqui em ConfigurarEventosImpressora() (os dois BINDEVENT),
*     ValidarImpressoraSelecionada() (o funil, que espelha nos controles o
*     que sigopetsBO.CarregarAjustesImpressora() leu de SigCdmp) e os dois
*     handlers GetPrinterInteractiveChange()/OptImpressoraInteractiveChange().
*     Fica nesta fase, e nao nas de evento, porque eh o lookup do CAMPO
*     impressora (criado na Fase 5) - sem ele trocar de impressora deixaria
*     na tela os ajustes da anterior e a etiqueta sairia com densidade/
*     velocidade erradas, sem erro nenhum.
*   - Fases 7-8 (ENTREGUE): eventos dos BOTOES - ConfigurarEventosBtnReport()
*     liga os dois Click de obj_4c_BtnReport (BINDEVENT, metodos PUBLIC -
*     CLAUDE.md regra #3): BtnImprimirClick() monta/ordena dbImpressao via
*     sigopetsBO (MontarCursorImpressao/PrepararImpressao/ExecutarImpressao,
*     ja entregues nas Fases 1-2) e dispara SigOpEtq(); BtnSairClick() fecha o
*     dialogo (THIS.Release(), igual ao "ThisForm.Release" do legado - sem
*     Release() extra no chamador, que so faz Show() - ver Problema 7 do
*     FORMCOR_LICOES_APRENDIDAS.md). AjustarEstadoBtnImprimir() espelha o
*     ".Imprime.Enabled/.Value" que o Init legado calcula no fim (linhas
*     1182-1185), a partir dos contadores de tipos/impressoras ja
*     carregados nas Fases 4-5 (this_nTotalTiposEtiqueta/
*     this_nTotalImpressoras).
*
*------------------------------------------------------------------------------
* NAO-PORT DELIBERADO (Fase 8 - consolidacao): Load ("=fConfigGeral()")
*
* O dump legado tem um SEXTO metodo com codigo, alem dos cinco ja cobertos
* acima (Init, Imprime.Click, Sair.Click, Opt_Impressora.InteractiveChange,
* Get_Printer.InteractiveChange): "PROCEDURE Load / =fConfigGeral()".
*
* fConfigGeral era funcao GLOBAL da aplicacao legado (sig.prg/SIGFUNCS.PRG)
* que NAO veio no acervo extraido. O que existe em
* projeto\app\utils\fconfiggeral.prg e' um wrapper NO-OP (RETURN .T.) cujo
* proprio cabecalho diz que, em codigo NOSSO, nunca se chama fConfigGeral -
* o arquivo existe so para o p-code dos VCX legado que a invoca direto (e nao
* da para editar). Chama-lo aqui seria escrever uma chamada que comprovadamente
* nao faz nada e ainda sugerir que falta alguma inicializacao global.
*
* O que fConfigGeral fazia esta distribuido e ocorre ANTES deste dialogo
* abrir: config.prg (SETs, paths, aliases globais), main.prg (conexao,
* CarregarEmpresa) e o FORM PAI (SigMvCab), que ja monta os cursores
* TprMvCab/crSigMvNfi/dbImpressao/CrSigCdPam antes de instanciar SIGOPETS -
* ver CONTRATO COM O FORM PAI acima. Mesmo nao-port, pelo mesmo motivo, de
* FormSigMvExp.prg/FormSigMvMen.prg/FormSigMvPdt.prg/FormSigMvSbn.prg/
* FormSIGMVTI2.prg (task570 e seguintes).
*==============================================================================

DEFINE CLASS Formsigopets AS FormBase

    *==========================================================================
    * PROPRIEDADES VISUAIS - PILAR 1: transcritas do dump do SCX
    *
    * Copiadas literalmente: BorderStyle = 2, ScaleMode = 3, Height = 350,
    * Width = 800, ControlBox = .F., MaxButton = .F., MinButton = .F.,
    * TitleBar = 0, WindowType = 1, Themes = .F., AutoCenter = .T.,
    * ShowTips = .T.
    *
    * ShowWindow = 1 ("In Top-Level Form"): canonico do projeto para
    * dialogo modal criado por CREATEOBJECT + Show() (ver FormPgb.prg).
    *
    * DataSession = 1 (NAO o 2 do dump) - ver CONTRATO COM O FORM PAI.
    *
    * Picture e Caption NAO cabem aqui: dependem de variavel global
    * (gc_4c_CaminhoFramework) e de CHR() para acento, e DEFINE CLASS so
    * aceita literal - sao montados no Init/InicializarForm.
    *
    * FICAM DE FORA, de proposito: DoCreate (flag de design-time do Form
    * Designer, nao property de runtime), DrawStyle = 0 / FillStyle = 1
    * (iguais ao default do VFP9) e o Dataenvironment inteiro (a nova
    * arquitetura usa BO + SQLEXEC).
    *==========================================================================
    DataSession = 1
    BorderStyle = 2
    ScaleMode   = 3
    Height      = 350
    Width       = 800
    ControlBox  = .F.
    MaxButton   = .F.
    MinButton   = .F.
    TitleBar    = 0
    Themes      = .F.
    WindowType  = 1
    ShowWindow  = 1
    AutoCenter  = .T.
    ShowTips    = .T.

    *==========================================================================
    * PROPRIEDADES DE ESTADO
    *==========================================================================
    this_oBusinessObject = .NULL.

    *-- Form PAI (ParentForm do legado) e o DataSessionId dele (pnDatSes) -
    *-- ver CONTRATO COM O FORM PAI acima.
    this_oFormPai          = .NULL.
    this_nDataSessionIdPai = 0

    *==========================================================================
    * Init - recebe o form pai e o DataSessionId dele (mesma assinatura do
    * legado: Lparameters pForm, pnDatSes), cria o BO e delega a montagem
    * visual para InicializarForm atraves do DODEFAULT() (FormBase.Init
    * chama THIS.InicializarForm()).
    *
    * O DODEFAULT() roda DENTRO do TRY e o resultado vai para uma flag -
    * RETURN unico, FORA do TRY/CATCH (CLAUDE.md regra #1).
    *==========================================================================
    PROCEDURE Init()
        LPARAMETERS par_oFormPai, par_nDataSessionIdPai

        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_oFormPai) = "O"
                THIS.this_oFormPai = par_oFormPai
            ENDIF

            IF VARTYPE(par_nDataSessionIdPai) = "N"
                THIS.this_nDataSessionIdPai = par_nDataSessionIdPai
            ENDIF

            *-- Caption do dump (acentos via CHR() - CLAUDE.md regra #4).
            *-- Setado ANTES do DODEFAULT porque FormBase.Init repassa
            *-- this_cTituloForm para THIS.Caption, e InicializarForm le
            *-- THIS.Caption para alimentar os dois labels da faixa.
            THIS.Caption          = "Impress" + CHR(227) + "o de Etiquetas de Produto"
            THIS.this_cTituloForm = THIS.Caption

            THIS.this_oBusinessObject = CREATEOBJECT("sigopetsBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar sigopetsBO." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                    "Formsigopets.Init")
            ELSE
                loc_lSucesso = DODEFAULT()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopets.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - orquestrador chamado por FormBase.Init(). Monta o
    * fundo da tela, os containers de topo e propaga o titulo para a faixa.
    *
    * RETURN unico, FORA do TRY (CLAUDE.md regra #1).
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lBlocoImpressora, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Fundo da tela. O dump declara
            *-- Picture = ..\framework\imagens\new_background.jpg, que eh
            *-- arquivo do Framework Fortyus legado: o caminho sai de
            *-- gc_4c_CaminhoFramework, NUNCA de gc_4c_CaminhoBase nem de
            *-- gc_4c_CaminhoIcones (CorretorAutomatico #170).
            THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"

            *-- Containers de topo do layout legado (cntSombra e Cnt_Impressora)
            THIS.ConfigurarContainersBase()

            *-- Fase 4: molduras, botoes de acao, grupo de tipo de
            *-- etiqueta (dinamico) e os ajustes de impressora.
            THIS.ConfigurarMolduras()
            THIS.ConfigurarBtnReport()

            *-- Fase 7-8: liga os dois Click do CommandGroup (Imprime/Sair).
            THIS.ConfigurarEventosBtnReport()

            THIS.ConfigurarOptTipo()
            THIS.ConfigurarAjustesImpressora()

            *-- Fase 5: o bloco da IMPRESSORA - rotulo das duas molduras,
            *-- cabecalho "Sistema"/"Windows", o combo cbo_4c_Get_Printer com
            *-- a lista de impressoras e o grupo de radios aposentado
            *-- obj_4c_Opt_Impressora.
            *--
            *-- Devolve .F. quando nao ha impressora disponivel (ou a consulta
            *-- de impressoras falha): eh o "Return 0" do Init legado, que
            *-- RECUSA a abertura da tela - sem impressora nao ha etiqueta a
            *-- imprimir. Por isso o resultado entra no loc_lSucesso da
            *-- InicializarForm, e nao eh descartado.
            loc_lBlocoImpressora = THIS.ConfigurarBlocoImpressora()

            *-- Fase 6: bloco de OPCOES de impressao (Preco/Separadora/Ordem/
            *-- Origem), a direita da tela (Left 434..663).
            THIS.ConfigurarOpcoesImpressao()

            *-- Fase 6: defaults que o Init legado aplica nos ajustes de
            *-- impressora (Opcao_imp/spinners, criados na Fase 4) e no
            *-- separador (opt_separador, criado acima), via
            *-- sigopetsBO.ObterParametrosPadraoImpressao(). O legado nao tem
            *-- Return/Messagebox de falha neste trecho do Init - por isso o
            *-- resultado NAO entra em loc_lSucesso (best-effort, igual ao
            *-- original).
            THIS.AplicarParametrosPadraoImpressao()

            *-- Fase 6: liga os DOIS InteractiveChange do legado - o "lookup"
            *-- desta tela, que resolve a impressora escolhida e recarrega os
            *-- campos que dependem dela (tipo + os 4 ajustes de hardware).
            THIS.ConfigurarEventosImpressora()

            *-- Legado, Init linha 1180 (logo DEPOIS dos defaults de
            *-- CrSigCdPam/CrSigCdPac, que entraram em
            *-- AplicarParametrosPadraoImpressao acima):
            *--     Thisform.Opt_Impressora.InteractiveChange()
            *-- Chamada DIRETA, nao por evento - o legado dispara o handler
            *-- do grupo aposentado para carregar os ajustes da impressora
            *-- inicial. Mesmo metodo que o BINDEVENT acima liga.
            THIS.OptImpressoraInteractiveChange()

            *-- Legado, Init linhas 1182-1185 (ULTIMO trecho do Init,
            *-- depois de ja terem rodado CarregarTiposEtiqueta() -
            *-- ConfigurarOptTipo, Fase 4 - e CarregarImpressorasDisponiveis()
            *-- - ConfigurarBlocoImpressora, Fase 5):
            *--     With Thisform.BtnReport
            *--         .Imprime.Enabled = ( lnTipos # 0 And lnImpres # 0)
            *--         .Value = Iif( .Imprime.Enabled, 1, 2 )
            *--     Endwith
            THIS.AjustarEstadoBtnImprimir()

            *-- O Init legado alimenta os dois labels da faixa com o Caption
            *-- da propria Form:
            *--   ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption
            *--   ThisForm.cntSombra.lblTitulo.Caption = ThisForm.Caption
            *-- (no dump os dois Caption estao em "Cadastro de Testes", sobra
            *--  do template de onde a tela foi copiada, e o legado sobrescreve
            *--  os dois em runtime - eh o runtime que se transcreve aqui)
            THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
            THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

            *-- AddObject cria tudo com Visible = .F.
            THIS.TornarControlesVisiveis(THIS)

            *-- ...e a varredura acima tambem reexibe o que o dump mandava
            *-- nascer OCULTO (Opt_Impressora.Option1). Este metodo repoe -
            *-- tem de rodar DEPOIS da varredura.
            THIS.RestaurarOcultosDoDump()

            loc_lSucesso = loc_lBlocoImpressora
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarContainersBase - cria os DOIS containers do dump, na ordem
    * em que a arvore de objetos do legado os declara.
    *
    * cnt_4c_Sombra      (cntSombra)      : faixa cinza do titulo, no topo.
    * cnt_4c__Impressora (Cnt_Impressora) : moldura dos ajustes de hardware
    *                                       da impressora, a direita.
    *
    * Nomes conforme tasks\task733\mapeamento.json - eh por eles que o
    * ValidarUIFidelity casa migrado x legado, inclusive o underscore
    * duplo de cnt_4c__Impressora (vem do "Cnt_" do legado).
    *
    * Os valores de Top/Left/Width/Height/cor saem CRUS do dump: sem
    * PageFrame nao existe a compensacao de +29 pixels.
    *
    * Cada AddObject fica FORA de qualquer bloco WITH, e a configuracao
    * usa o caminho EXPLICITO do objeto - AddObject chamado de dentro de um
    * WITH faz o VFP9 descartar as propriedades em silencio (CLAUDE.md,
    * "WITH aninhado em Container/Label criados com AddObject").
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarContainersBase()
        LOCAL loc_oCab, loc_oErro

        TRY
            *----------------------------------------------------------------
            * cntSombra: Top=0 Left=0 Width=800 Height=80 BorderWidth=0
            *            BackColor=100,100,100
            * Container nao tem BorderStyle (so BorderWidth) - CLAUDE.md.
            * BackStyle = 1 vai explicito porque eh o que faz a faixa
            * PINTAR o cinza que da contraste ao titulo branco.
            *----------------------------------------------------------------
            THIS.AddObject("cnt_4c_Sombra", "Container")
            loc_oCab = THIS.cnt_4c_Sombra
            WITH loc_oCab
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BorderWidth = 0
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
            ENDWITH

            *----------------------------------------------------------------
            * lblSombra: a "sombra" preta do titulo, desenhada 1px abaixo
            * do texto branco (Top=18 contra Top=17).
            *
            * AutoSize = .F. EXPLICITO: o dump nao declara AutoSize, mas
            * declara WordWrap = .T. com Height = 40 - e AutoSize = .T.
            * junto de WordWrap DESCARTA a Height e corta o texto
            * (CLAUDE.md regra #23). Width/Height sao os do dump.
            *----------------------------------------------------------------
            loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
            WITH loc_oCab.lbl_4c_LblSombra
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .FontUnderline = .F.
                .WordWrap      = .T.
                .AutoSize      = .F.
                .Alignment     = 0
                .BackStyle     = 0
                .Height        = 40
                .Left          = 10
                .Top           = 18
                .Width         = 769
                .ForeColor     = RGB(0, 0, 0)
                .Caption       = ""
            ENDWITH

            *----------------------------------------------------------------
            * lblTitulo: o titulo em si, branco sobre o cinza da faixa.
            * ForeColor branco eh LEGITIMO aqui (CLAUDE.md regra #12
            * excetua lbl Titulo/Sombra do cabecalho) porque o container
            * pai eh OPACO escuro - BackStyle = 1 + RGB(100,100,100).
            *----------------------------------------------------------------
            loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCab.lbl_4c_LblTitulo
                .FontBold    = .T.
                .FontName    = "Tahoma"
                .FontSize    = 18
                .WordWrap    = .T.
                .AutoSize    = .F.
                .Alignment   = 0
                .BackStyle   = 0
                .Height      = 46
                .Left        = 10
                .Top         = 17
                .Width       = 769
                .ForeColor   = RGB(255, 255, 255)
                .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Caption     = ""
            ENDWITH

            *----------------------------------------------------------------
            * Cnt_Impressora: Top=123 Left=399 Width=392 Height=73
            *                 BackStyle=0 SpecialEffect=2 TabIndex=5
            *                 BorderColor=90,90,90
            *
            * BackStyle = 0 (transparente) eh do dump: o fundo que aparece
            * dentro da moldura eh a textura new_background.jpg da propria
            * Form. SpecialEffect = 2 (Plain) + BorderColor sao o que
            * desenham a moldura cinza em volta dos ajustes.
            *
            * Como o container eh TRANSPARENTE, os rotulos que entram nele
            * na Fase 4 (Say2..Say5, classe "say" do Framework) NAO podem
            * receber ForeColor branco - vao em RGB(90,90,90), que eh o
            * canonico da regra #12 para label de dados.
            *
            * Fica VAZIO nesta fase: os 9 filhos (obj_4c_Opcao_imp, os 4
            * spinners de ajuste, chk_4c_Opt_Qtd e os 4 rotulos) sao
            * controles de dados e entram na Fase 4.
            *----------------------------------------------------------------
            THIS.AddObject("cnt_4c__Impressora", "Container")
            WITH THIS.cnt_4c__Impressora
                .Top           = 123
                .Left          = 399
                .Width         = 392
                .Height        = 73
                .BackStyle     = 0
                .SpecialEffect = 2
                .BorderColor   = RGB(90, 90, 90)
                .TabIndex      = 5
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarContainersBase")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarMolduras - Shape2/Shape3 do dump: duas molduras
    * transparentes (BackStyle = 0 - so o retangulo da borda eh visivel,
    * o preenchimento nao pinta) que cercam, respectivamente, o grupo de
    * tipo de etiqueta (obj_4c_Opt_Tipo, criado nesta mesma fase) e a
    * area de impressora/Opt_Impressora (Get_Printer, criado na Fase 5-6).
    *
    * Shape nao tem ForeColor (CLAUDE.md regra #33) - so BorderColor e
    * FillColor, e FillColor so pintaria com BackStyle = 1.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarMolduras()
        LOCAL loc_oErro

        TRY
            *----------------------------------------------------------------
            * Shape2: Top=123 Left=9 Width=191 Height=191 BorderWidth=1
            *         SpecialEffect=0 BackStyle=0 FillColor=136,189,188
            *         BorderColor=90,90,90
            *----------------------------------------------------------------
            THIS.AddObject("shp_4c_Shape2", "Shape")
            WITH THIS.shp_4c_Shape2
                .Top           = 123
                .Left          = 9
                .Width         = 191
                .Height        = 191
                .BackStyle     = 0
                .BorderWidth   = 1
                .SpecialEffect = 0
                .FillColor     = RGB(136, 189, 188)
                .BorderColor   = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * Shape3: Top=123 Left=204 Width=191 Height=191 SpecialEffect=0
            *         BackStyle=0 FillColor=136,189,188 BorderColor=90,90,90
            * (o dump nao repete BorderWidth=1 para este Shape; usado o
            *  mesmo valor do Shape2 - os dois desenham a mesma moldura)
            *----------------------------------------------------------------
            THIS.AddObject("shp_4c_Shape3", "Shape")
            WITH THIS.shp_4c_Shape3
                .Top           = 123
                .Left          = 204
                .Width         = 191
                .Height        = 191
                .BackStyle     = 0
                .BorderWidth   = 1
                .SpecialEffect = 0
                .FillColor     = RGB(136, 189, 188)
                .BorderColor   = RGB(90, 90, 90)
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarMolduras")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBtnReport - BtnReport do dump (CommandGroup com os botoes
    * Imprime/"\<Imprimir" e Sair/"Sair"). Monta so ESTRUTURA e aparencia -
    * os .Click (BtnImprimirClick/BtnSairClick, Fase 7-8) sao ligados por
    * BINDEVENT em ConfigurarEventosBtnReport(), chamado logo depois deste
    * metodo em InicializarForm.
    *
    * AutoSize = .T. do dump NAO transcrito (CLAUDE.md #31/#33): em
    * CommandGroup o AutoSize usa a geometria do BOTAO INTERNO para
    * definir a altura do GRUPO, e sobrescreveria o Width=160/Height=85
    * que o dump ja declara explicitamente no grupo.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBtnReport()
        LOCAL loc_oGrp, loc_oErro

        TRY
            THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
            loc_oGrp = THIS.obj_4c_BtnReport
            WITH loc_oGrp
                .Top           = -2
                .Left          = 645
                .Width         = 160
                .Height        = 85
                .ButtonCount   = 2
                .BackStyle     = 0
                .BorderStyle   = 0
                .Value         = 1
                .TabIndex      = 12
                .SpecialEffect = 1
                .BorderColor   = RGB(231, 254, 253)
                .Themes        = .F.
            ENDWITH

            *-- Buttons(1) = Imprime (Command1 no dump)
            WITH loc_oGrp.Buttons(1)
                .Top             = 5
                .Left            = 5
                .Height          = 75
                .Width           = 75
                .AutoSize        = .F.
                .FontBold        = .T.
                .FontItalic      = .T.
                .FontName        = "Comic Sans MS"
                .FontSize        = 8
                .WordWrap        = .T.
                .Picture         = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption         = "\<Imprimir"
                .ToolTipText     = "Imprimir"
                .PicturePosition = 13
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
            ENDWITH

            *-- Buttons(2) = Sair (Command2 no dump) - Cancel=.T. (tecla ESC)
            WITH loc_oGrp.Buttons(2)
                .Top         = 5
                .Left        = 80
                .Height      = 75
                .Width       = 75
                .AutoSize    = .F.
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .WordWrap    = .T.
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "Sair"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes      = .F.
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarBtnReport")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarEventosBtnReport - Fase 7-8: liga os DOIS Click do
    * CommandGroup criado em ConfigurarBtnReport (Buttons(1) = Imprime,
    * Buttons(2) = Sair - nomes do dump: Command1/Command2).
    *
    * BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3) - BtnImprimirClick()
    * e BtnSairClick() nao levam PROTECTED.
    *
    * PEMSTATUS guarda a existencia do grupo para o metodo continuar valido
    * se uma fase futura mudar a ordem de montagem - e porque BINDEVENT com
    * referencia invalida estoura no proprio bind, derrubando o Init.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosBtnReport()
        LOCAL loc_oGrp, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "obj_4c_BtnReport", 5)
                loc_oGrp = THIS.obj_4c_BtnReport

                IF loc_oGrp.ButtonCount >= 1
                    BINDEVENT(loc_oGrp.Buttons(1), "Click", THIS, "BtnImprimirClick")
                ENDIF

                IF loc_oGrp.ButtonCount >= 2
                    BINDEVENT(loc_oGrp.Buttons(2), "Click", THIS, "BtnSairClick")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarEventosBtnReport")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnImprimirClick - handler de BtnReport.Buttons(1) ("Imprime"), ligado
    * por BINDEVENT. Transcreve BtnReport.Imprime.Click do legado (dump,
    * linhas 1206-1427): le as opcoes de impressao da tela, pede ao BO para
    * (re)montar dbImpressao conforme o tipo de etiqueta, ordena e dispara
    * SigOpEtq().
    *
    * Nomeado pela ACAO (Caption "\<Imprimir"), NAO pelo nome do objeto
    * legado ("Imprime"): o prefixo Btn nao eh cosmetico - eh o que torna o
    * handler de botao ENUMERAVEL pelos gates das Fases 7 e 8, e herdar o
    * nome do objeto legado violaria o PILAR 3 (nomes do migrado
    * obrigatoriamente diferentes). NAO renomear de volta para ImprimeClick.
    *
    * "Set Step On" do dump (linha 1236) NAO eh transcrito - eh um
    * breakpoint do depurador interativo do VFP9, esquecido no codigo de
    * producao pelo desenvolvedor legado, e nao faz parte da regra de
    * negocio (abriria a janela de Trace a cada clique em Imprimir).
    *
    * llImpPreco/llImpPeso/llOrigem/lnTipo/vTipEtq/lcNomeImp/vnTpImp/
    * vnAjVerts/vnAjHorzs/vnAjDenss sao lidos dos MESMOS controles que o
    * legado le (Opt_Preco, Cnt_Impressora.opt_Qtd, OptOrigem, Opt_Tipo,
    * get_Printer/crImpreV.impres, Cnt_Impressora.Opcao_Imp e os 3
    * spinners usados a jante). vnAjVelos continua sendo lido (variavel
    * morta tambem no legado - With Thisform.Cnt_Impressora le os 4
    * spinners, mas so 3 chegam ao SigOpEtq) para nao divergir da leitura
    * original.
    *
    * lcNomeImp sai de crImpreV.impres (a coluna do NOME NO WINDOWS, "b.impres"
    * no JOIN de CarregarImpressorasDisponiveis) - NAO de impresS (o nome
    * cadastrado no SISTEMA, "a.impres", que GetPrinterInteractiveChange usa
    * para casar com SigCdmp). Sao colunas DIFERENTES do MESMO cursor, e o
    * legado usa cada uma no lugar certo (Imprime.Click:1221 usa .impres;
    * Get_Printer.InteractiveChange:1469 usa .impresS) - trocar as duas faria
    * SigOpEtq receber o nome errado da impressora do Windows.
    *
    * A remontagem de dbImpressao (MontarCursorImpressao), o calculo do Bop
    * e a ordenacao final (PrepararImpressao) e o disparo de SigOpEtq()
    * (ExecutarImpressao) ja estao no BO (Fases 1-2) - este metodo so
    * ORQUESTRA, na mesma ordem do legado, e so EXIBE o resultado.
    *
    * llSeparador (ThisForm.Opt_separador.Value = 1) eh lido do CONTROLE,
    * nao de sigopetsBO.this_lSeparador: o legado so usa esse default para
    * SUGERIR o estado inicial do radio (AplicarParametrosPadraoImpressao,
    * Fase 6) - o usuario pode trocar Sim/Nao na tela antes de clicar
    * Imprimir, e eh esse valor CORRENTE que tem de ir para SigOpEtq.
    *
    * loc_lMontou = .F. (falha TECNICA ao remontar, ex.: SQL da remontagem
    * falhou) corresponde ao "Return .f." do legado dentro de cada bloco de
    * remontagem - aborta o metodo (CLAUDE.md regra #1: RETURN so FORA do
    * TRY, por isso o aborto eh feito com flag + IF, nao com RETURN
    * antecipado dentro do TRY). loc_lPreparou = .F. eh "Nao Existem
    * Etiquetas Para Impressao" (dbImpressao ficou vazio) - MsgAviso, nao
    * MsgErro, porque eh estado de DADO, nao falha do sistema.
    *==========================================================================
    PROCEDURE BtnImprimirClick()
        LOCAL loc_oBO, loc_lLeu, loc_lMontou, loc_lPreparou, loc_lImprimiu, loc_oErro

        loc_oBO = THIS.this_oBusinessObject

        TRY
            *-- Leitura da tela num funil UNICO: FormParaBO popula as 12
            *-- properties do sigopetsBO que correspondem aos controles
            *-- editaveis (era aqui que o legado montava llImpPreco,
            *-- llImpPeso, llOrigem, vTipEtq, lcNomeImp, vnTpImp e os 4
            *-- vnAj*). Daqui para baixo a FONTE UNICA dos parametros eh o
            *-- BO - nao se le controle de novo, para as duas copias nao
            *-- divergirem em silencio.
            loc_lLeu = THIS.FormParaBO()

            IF !loc_lLeu
                *-- FormParaBO ja exibiu a falha; imprimir com parametro
                *-- pela metade eh pior que nao imprimir.
                loc_lMontou = .F.
            ELSE
                loc_lMontou = loc_oBO.MontarCursorImpressao(loc_oBO.this_nTipoEtiqueta)
            ENDIF

            IF loc_lMontou
                loc_lPreparou = loc_oBO.PrepararImpressao(loc_oBO.this_nTipoEtiqueta, ;
                    loc_oBO.this_nOrdem)

                IF loc_lPreparou
                    loc_lImprimiu = loc_oBO.ExecutarImpressao( ;
                        loc_oBO.this_lImprimirPreco, loc_oBO.this_lSeparador, ;
                        loc_oBO.this_nTipoEtiqueta, loc_oBO.this_nTipoImpressora, ;
                        loc_oBO.this_nAjusteVertical, loc_oBO.this_nAjusteHorizontal, ;
                        loc_oBO.this_nAjusteDensidade, loc_oBO.this_lImprimirPesoTotal, ;
                        loc_oBO.this_cNomeImpressora, loc_oBO.this_lOrigemEtiqueta140)

                    IF loc_lImprimiu
                        MsgInfo("Impress" + CHR(227) + "o Conclu" + CHR(237) + "da!!!", "Confirmar")

                        THIS.obj_4c_OptOrdem.Enabled     = .F.
                        THIS.obj_4c_Opt_separador.Enabled = .F.
                    ELSE
                        MsgErro(loc_oBO.this_cMensagemErro, "Erro")
                    ENDIF
                ELSE
                    MsgAviso(loc_oBO.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
            ELSE
                *-- Falha de LEITURA da tela ja foi reportada por FormParaBO
                *-- (this_cMensagemErro do BO estaria vazio aqui); so o ramo
                *-- de MONTAGEM tem mensagem propria do BO a exibir.
                IF loc_lLeu
                    MsgErro(loc_oBO.this_cMensagemErro, "Falha na Conex" + CHR(227) + "o")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopets.BtnImprimirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnSairClick - handler de BtnReport.Buttons(2) ("Sair"), ligado por
    * BINDEVENT. Transcreve BtnReport.Sair.Click do legado ("ThisForm.
    * Release"). O botao ja tem .Cancel = .T. (ConfigurarBtnReport), que
    * faz a tecla ESC disparar este MESMO Click nativamente - por isso nao
    * ha BINDEVENT de KeyPress separado para ESC (ToolTipText do dump,
    * "[ESC] Sair", confirma que o atalho e o botao sao a MESMA acao).
    *
    * Nomeado pela ACAO: aqui "Sair" eh HONESTO porque o corpo do Click
    * legado de fato so faz ThisForm.Release. Botao cujo nome legado MENTE
    * (ex.: chamado de sair mas que GRAVA) levaria o nome da acao real.
    *
    * Sem Release() extra no chamador (SigMvCab so faz Show() - ver
    * Problema 7 do FORMCOR_LICOES_APRENDIDAS.md: Release() depois de
    * Show() de form modal tenta destruir objeto ja destruido).
    *==========================================================================
    PROCEDURE BtnSairClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * ConfigurarOptTipo - Opt_Tipo do dump (OptionGroup, tipos de etiqueta
    * disponiveis). No legado o ButtonCount e cada Caption/Tag/Top sao
    * calculados em runtime (Init, linhas 1044-1069): ButtonCount =
    * Min(total de tipos, Max(CrSigCdPam.nMaxTpEtis, 7)); cada botao recebe
    * a letra-acelerador + descricao de CrSigCdTpe.cEtiquetas (ordenado por
    * cordems+cEtiquetas) e o Tag = CrSigCdTpe.nTipos (lido depois pelo
    * Imprime.Click para montar vTipEtq).
    *
    * sigopetsBO.CarregarTiposEtiqueta() (Fase 1-2) ja faz a query
    * ORDER BY cordems, cEtiquetas em CrSigCdTpe - mesmo cursor e mesma
    * ordenacao do legado (que usava INDEX ON no lugar do ORDER BY).
    * sigopetsBO.ObterIndiceTipoEtiquetaPadrao() replica o SCAN que casa
    * CrSigCdTpe.nTipos com CrSigCdPam.TpEtiPads.
    *
    * CrSigCdPam eh contrato do FORM PAI (ja aberto quando este dialogo
    * sobe - ver CONTRATO COM O FORM PAI no cabecalho do arquivo); sem
    * conexao (gb_4c_ValidandoUI) ou sem nenhum tipo cadastrado, o grupo cai
    * no botao ESTATICO que o proprio dump declara (Option1.Caption =
    * "Rabicho"), so para nao nascer vazio.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOptTipo()
        LOCAL loc_oGrp, loc_nMaxBotoes, loc_nIndicePadrao, loc_nI, ;
              loc_nTop, loc_cLetra, loc_oErro

        TRY
            THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
            loc_oGrp = THIS.obj_4c_Opt_Tipo
            WITH loc_oGrp
                .Height      = 177
                .Left        = 12
                .Top         = 134
                .Width       = 186
                .BackStyle   = 0
                .BorderStyle = 0
                .TabIndex    = 2
                .BorderColor = RGB(136, 189, 188)
                .Themes      = .F.
            ENDWITH

            loc_nMaxBotoes    = 0
            loc_nIndicePadrao = 1

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) ;
                AND VARTYPE(THIS.this_oBusinessObject) = "O"

                IF THIS.this_oBusinessObject.CarregarTiposEtiqueta()
                    IF USED("CrSigCdPam")
                        loc_nMaxBotoes = MIN(THIS.this_oBusinessObject.this_nTotalTiposEtiqueta, ;
                            MAX(NVL(CrSigCdPam.nMaxTpEtis, 0), 7))
                    ELSE
                        loc_nMaxBotoes = MIN(THIS.this_oBusinessObject.this_nTotalTiposEtiqueta, 7)
                    ENDIF
                ENDIF
            ENDIF

            IF loc_nMaxBotoes > 0
                loc_nIndicePadrao = THIS.this_oBusinessObject.ObterIndiceTipoEtiquetaPadrao(loc_nMaxBotoes)

                loc_oGrp.ButtonCount = loc_nMaxBotoes

                SELECT CrSigCdTpe
                GO TOP
                loc_nTop = 10

                FOR loc_nI = 1 TO loc_nMaxBotoes
                    loc_cLetra = CHR(96 + loc_nI)

                    WITH loc_oGrp.Buttons(loc_nI)
                        .AutoSize  = .F.
                        .Width     = loc_oGrp.Width - 10
                        .Caption   = " \<" + loc_cLetra + ". " + ALLTRIM(CrSigCdTpe.cEtiquetas)
                        .FontSize  = 8
                        .Tag       = ALLTRIM(STR(CrSigCdTpe.nTipos))
                        .Top       = loc_nTop
                        .ForeColor = RGB(90, 90, 90)
                    ENDWITH

                    loc_nTop = loc_nTop + 20

                    IF !EOF("CrSigCdTpe")
                        SELECT CrSigCdTpe
                        SKIP
                    ENDIF
                ENDFOR

                loc_oGrp.Value = loc_nIndicePadrao
            ELSE
                loc_oGrp.ButtonCount = 1
                WITH loc_oGrp.Buttons(1)
                    .AutoSize  = .F.
                    .Width     = loc_oGrp.Width - 10
                    .Caption   = "Rabicho"
                    .FontSize  = 8
                    .Top       = 10
                    .ForeColor = RGB(90, 90, 90)
                ENDWITH
                loc_oGrp.Value = 1
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarOptTipo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarAjustesImpressora - filhos de cnt_4c__Impressora (criado na
    * Fase 3): Opcao_imp (tipo de impressora - Allegro/Zebra ZPL/Zebra EPL),
    * os 4 spinners de ajuste fisico e o CheckBox "Imprimir Qtd/Peso Total",
    * mais os 4 rotulos (Say2..Say5) da classe "say" do Framework.
    *
    * Valores default dos spinners/checkbox (CrSigCdPam/CrSigCdPac) entram
    * no BOParaForm (Fase 5-6) - aqui so a ESTRUTURA/aparencia, igual ao
    * dump ANTES do Init() do legado rodar.
    *
    * Say2..Say5 recebem ForeColor = RGB(90,90,90) do dump (regra #12) -
    * o container pai (cnt_4c__Impressora) eh BackStyle=0, transparente
    * sobre a textura CLARA do fundo da Form, entao ForeColor branco
    * ficaria invisivel aqui.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarAjustesImpressora()
        LOCAL loc_oCnt, loc_oErro

        TRY
            loc_oCnt = THIS.cnt_4c__Impressora

            *----------------------------------------------------------------
            * Opcao_imp (fwoption no legado -> OptionGroup aqui): Allegro/
            * Zebra ZPL/Zebra EPL. AutoSize = .T. do dump NAO transcrito
            * (CLAUDE.md #31/#33) - sobrescreveria o 76x63 do dump.
            *----------------------------------------------------------------
            loc_oCnt.AddObject("obj_4c_Opcao_imp", "OptionGroup")
            WITH loc_oCnt.obj_4c_Opcao_imp
                .Height      = 63
                .Left        = 0
                .Top         = 4
                .Width       = 76
                .ButtonCount = 3
                .BackStyle   = 0
                .BorderStyle = 0
                .TabIndex    = 1
            ENDWITH

            WITH loc_oCnt.obj_4c_Opcao_imp.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Allegro"
                .Left      = 5
                .Top       = 5
                .Width     = 51
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH loc_oCnt.obj_4c_Opcao_imp.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Zebra ZPL"
                .Left      = 5
                .Top       = 24
                .Width     = 66
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH loc_oCnt.obj_4c_Opcao_imp.Buttons(3)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Zebra EPL"
                .Height    = 15
                .Left      = 5
                .Top       = 43
                .Width     = 66
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * Spinners - limites EXATOS do dump (Keyboard/SpinnerHighValue/
            * LowValue). Spn_AjVerts (Top=19,Left=99), Spn_AjHorzs
            * (Left=173), Spn_AjDenss (Left=247,Value=10), spn_AjVelos
            * (Left=321,Value=3).
            *----------------------------------------------------------------
            loc_oCnt.AddObject("obj_4c_Spn_AjVerts", "Spinner")
            WITH loc_oCnt.obj_4c_Spn_AjVerts
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 26
                .Left              = 99
                .Top               = 19
                .Width             = 61
                .KeyboardHighValue = 999
                .KeyboardLowValue  = 0
                .SpinnerHighValue  = 999.00
                .SpinnerLowValue   = 0.00
                .TabIndex          = 3
            ENDWITH

            loc_oCnt.AddObject("obj_4c_Spn_AjHorzs", "Spinner")
            WITH loc_oCnt.obj_4c_Spn_AjHorzs
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 26
                .Left              = 173
                .Top               = 19
                .Width             = 61
                .KeyboardHighValue = 999
                .KeyboardLowValue  = -999
                .SpinnerHighValue  = 999.00
                .SpinnerLowValue   = -999.00
                .TabIndex          = 5
            ENDWITH

            loc_oCnt.AddObject("obj_4c_Spn_AjDenss", "Spinner")
            WITH loc_oCnt.obj_4c_Spn_AjDenss
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 26
                .Left              = 247
                .Top               = 19
                .Width             = 61
                .KeyboardHighValue = 20
                .KeyboardLowValue  = 10
                .SpinnerHighValue  = 20.00
                .SpinnerLowValue   = 10.00
                .Value             = 10
                .TabIndex          = 5
            ENDWITH

            loc_oCnt.AddObject("obj_4c_Spn_AjVelos", "Spinner")
            WITH loc_oCnt.obj_4c_Spn_AjVelos
                .FontName          = "Tahoma"
                .FontSize          = 8
                .Height            = 26
                .Left              = 321
                .Top               = 19
                .Width             = 61
                .KeyboardHighValue = 3
                .KeyboardLowValue  = 1
                .SpinnerHighValue  = 3.00
                .SpinnerLowValue   = 1.00
                .Value             = 3
                .TabIndex          = 9
            ENDWITH

            *----------------------------------------------------------------
            * opt_Qtd -> "Imprimir Qtd/Peso Total". CheckBox.Value SEMPRE
            * numerico (CLAUDE.md) - 0 = desmarcado, igual ao legado (o
            * dump nao declara Value, ou seja nasce desmarcado).
            *----------------------------------------------------------------
            loc_oCnt.AddObject("chk_4c_Opt_Qtd", "CheckBox")
            WITH loc_oCnt.chk_4c_Opt_Qtd
                .Top       = 49
                .Left      = 99
                .Height    = 15
                .Width     = 131
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Alignment = 0
                .BackStyle = 0
                .Caption   = "Imprimir Qtd/Peso Total"
                .TabIndex  = 11
                .ForeColor = RGB(90, 90, 90)
                .Value     = 0
            ENDWITH

            *----------------------------------------------------------------
            * Say2..Say5 - rotulos do bloco de ajustes (classe "say" do
            * Framework: AutoSize/Alignment NAO sao herdados pelo Label
            * criado via AddObject - CLAUDE.md regra #23 - por isso os
            * dois ficam explicitos aqui).
            *----------------------------------------------------------------
            loc_oCnt.AddObject("lbl_4c_Label2", "Label")
            WITH loc_oCnt.lbl_4c_Label2
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Vertical"
                .Height    = 15
                .Left      = 99
                .Top       = 4
                .Width     = 37
                .TabIndex  = 3
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label3", "Label")
            WITH loc_oCnt.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Horizontal"
                .Height    = 15
                .Left      = 173
                .Top       = 4
                .Width     = 50
                .TabIndex  = 5
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label4", "Label")
            WITH loc_oCnt.lbl_4c_Label4
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Densidade"
                .Height    = 15
                .Left      = 247
                .Top       = 4
                .Width     = 52
                .TabIndex  = 7
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_Label5", "Label")
            WITH loc_oCnt.lbl_4c_Label5
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Caption   = "Velocidade"
                .Height    = 15
                .Left      = 321
                .Top       = 4
                .Width     = 53
                .TabIndex  = 9
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarAjustesImpressora")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarBlocoImpressora - Fase 5 (campos, parte 1): o BLOCO DA
    * IMPRESSORA, isto eh, tudo que o dump pendura SOBRE a moldura
    * shp_4c_Shape3 (Left 204..395), mais o rotulo da moldura das etiquetas.
    *
    * Objetos do dump entregues aqui (nomes de tasks\task733\mapeamento.json):
    *   Label2         -> lbl_4c_Label2         "Etiquetas"   (rotulo de Shape2)
    *   Label4         -> lbl_4c_Label4         "Impressoras" (rotulo de Shape3)
    *   Label5         -> lbl_4c_Label5         "Sistema"     (1a metade do combo)
    *   Label6         -> lbl_4c_Label6         "Windows"     (2a metade do combo)
    *   Get_Printer    -> cbo_4c_Get_Printer    combo das impressoras
    *   Opt_Impressora -> obj_4c_Opt_Impressora radio APOSENTADO (ver abaixo)
    *
    * A ORDEM IMPORTA: este metodo roda DEPOIS de ConfigurarMolduras(). Os
    * Shape criados antes ficam ABAIXO no z-order; invertido, a moldura
    * desenharia POR CIMA e esconderia rotulo, combo e radio.
    *
    * COLISAO DE NOMES NO mapeamento.json (nao eh defeito): lbl_4c_Label2..5
    * aparecem DUAS vezes - aqui como filhos DIRETOS da Form (Label2/Label4/
    * Label5 do dump) e na Fase 4 como filhos de cnt_4c__Impressora (Say2..
    * Say5). O PAI eh diferente, entao AddObject nao estoura "object already
    * exists" (que so vale dentro do MESMO container) e o ValidarUIFidelity
    * resolve cada um pelo caminho completo do pai. NAO renomear: o nome vem
    * do mapeamento, e eh dele que o validador monta o caminho.
    *
    * ForeColor = RGB(90,90,90) em TODOS os rotulos: eh o que o dump declara
    * e tambem o canonico da regra #12 - estes controles penduram direto na
    * Form, cuja Picture (new_background.jpg) eh textura CLARA, entao
    * ForeColor branco ficaria INVISIVEL.
    *
    * AutoSize = .F. EXPLICITO mesmo com AutoSize = .T. no dump (regra #23):
    * em Label criado por AddObject o AutoSize eh no-op (a Width fica nos 100
    * do default). Os Width/Height do dump JA SAO o auto-size que o Form
    * Designer calculou, logo fixa-los eh reproducao fiel, nao desvio.
    *
    * RETURN unico, FORA do TRY/CATCH (regra #1). Devolve .F. quando a carga
    * das impressoras falha - eh o "Return 0" do Init legado (linhas 1030 e
    * 1086), que RECUSA a abertura da tela: sem impressora nao ha etiqueta a
    * imprimir, e abrir o dialogo so adiaria o erro para o clique em Imprimir.
    *==========================================================================
    PROTECTED FUNCTION ConfigurarBlocoImpressora()
        LOCAL loc_lSucesso, loc_lModoSemBanco, loc_oBO, loc_oErro

        loc_lSucesso = .F.

        TRY
            *----------------------------------------------------------------
            * Label2 "Etiquetas" - rotulo da moldura shp_4c_Shape2, que cerca
            * o grupo obj_4c_Opt_Tipo (criado na Fase 4). FontBold = .T. do
            * dump: os quatro rotulos de SECAO desta tela (Etiquetas,
            * Impressoras, Sistema, Windows) sao bold; os de CAMPO (Preco,
            * Separadora, Ordem, Origem - Fase 6) sao FontBold = .F.
            *----------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .F.
                .Caption    = "Etiquetas"
                .Height     = 15
                .Left       = 17
                .Top        = 128
                .Width      = 55
                .TabIndex   = 1
                .AutoSize   = .F.
                .Alignment  = 0
                .BackStyle  = 0
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * Label4 "Impressoras" - rotulo da moldura shp_4c_Shape3.
            * Top = 126 (nao 128 como o Label2): os dois rotulos de moldura
            * nao estao alinhados no dump, e o desalinhamento de 2px eh
            * transcrito como esta.
            *----------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .F.
                .Caption    = "Impressoras"
                .Height     = 15
                .Left       = 212
                .Top        = 126
                .Width      = 74
                .TabIndex   = 3
                .AutoSize   = .F.
                .Alignment  = 0
                .BackStyle  = 0
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * Label5 "Sistema" / Label6 "Windows" - cabecalho das DUAS
            * metades de cada linha do combo. A coluna exibida (IDupla) eh
            *     Padr(Alltrim(SigCdmp.impres), 15) + " " + <nome no Windows>
            * ou seja o nome cadastrado no sistema seguido do nome da
            * impressora no Windows; por isso os dois rotulos, e por isso o
            * combo usa fonte MONOESPACADA (ver cbo_4c_Get_Printer).
            *
            * Os dois tem TabIndex = 15 no dump (duplicado) - transcrito como
            * esta: Label nao recebe foco, o TabIndex nao tem efeito pratico
            * aqui, e "corrigir" seria inventar valor que o legado nao tem.
            *----------------------------------------------------------------
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .F.
                .Caption    = "Sistema"
                .Height     = 15
                .Left       = 214
                .Top        = 162
                .Width      = 48
                .TabIndex   = 15
                .AutoSize   = .F.
                .Alignment  = 0
                .BackStyle  = 0
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName   = "Tahoma"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .F.
                .Caption    = "Windows"
                .Height     = 15
                .Left       = 328
                .Top        = 162
                .Width      = 52
                .TabIndex   = 15
                .AutoSize   = .F.
                .Alignment  = 0
                .BackStyle  = 0
                .ForeColor  = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * Get_Printer (ComboBox) - a lista de impressoras, que no legado
            * SUBSTITUIU o grupo de radios Opt_Impressora (comentario
            * "mena - 10/09/2015 - a lista de impressoras sairam dos radio
            * para o combobox", Init linha 1111).
            *
            * Transcrito do dump: FontName = "Courier New", FontSize = 8,
            * Top/Left/Width/Height = 179/212/176/23, Style = 2 (DropDown
            * List - o usuario ESCOLHE, nao digita), SpecialEffect = 1,
            * TabIndex = 1, BoundColumn = 1, RowSourceType = 2 (Alias),
            * RowSource = "crImpreV", BoundTo = .F., BorderColor =
            * RGB(100,100,100), DisabledBackColor = RGB(238,238,238),
            * DisabledForeColor = RGB(0,0,128).
            *
            * "Courier New" NAO eh descuido do legado: a coluna exibida
            * (IDupla) junta dois nomes com PADR(...,15), e so fonte
            * MONOESPACADA mantem a 2a metade alinhada sob o rotulo
            * "Windows". Trocar por Tahoma desalinharia a coluna inteira.
            *
            * BoundTo = .F. com Value NUMERICO: o combo devolve o INDICE da
            * linha, nao o texto - eh assim que o Imprime.Click do legado le
            * a escolha (lnImpres = Recno('crImpreV') e lcNomeImp =
            * crImpreV.impres, linhas 1220-1221), navegando o CURSOR pela
            * posicao. Por isso NAO transformar em Value caractere.
            *
            * ControlSource = "" do dump NAO eh transcrito: eh override
            * VAZIO do Form Designer (regra #49) - transcrever ligaria o
            * controle a "nada" em vez de deixar o default.
            *----------------------------------------------------------------
            THIS.AddObject("cbo_4c_Get_Printer", "ComboBox")
            WITH THIS.cbo_4c_Get_Printer
                .FontName          = "Courier New"
                .FontSize          = 8
                .Height            = 23
                .Left              = 212
                .Top               = 179
                .Width             = 176
                .Style             = 2
                .SpecialEffect     = 1
                .RowSourceType     = 2
                .BoundColumn       = 1
                .BoundTo           = .F.
                .TabIndex          = 1
                .BorderColor       = RGB(100, 100, 100)
                .DisabledBackColor = RGB(238, 238, 238)
                .DisabledForeColor = RGB(0, 0, 128)
            ENDWITH

            *----------------------------------------------------------------
            * Opt_Impressora - o grupo de radios APOSENTADO. No legado o
            * bloco que o populava esta INTEIRO comentado com *!* (Init,
            * linhas 1129-1162) e o SCX declara Option1 com Visible = .F. +
            * Enabled = .F.: o objeto continua existindo so porque o Init
            * ainda chama Thisform.Opt_Impressora.InteractiveChange() (linha
            * 1180) para disparar o fCarregarImps dos ajustes de hardware.
            *
            * Entao ele eh criado FIEL ao dump - presente, com UM botao
            * invisivel e desabilitado - e NAO repopulado. Reanimar o grupo
            * seria inventar UI que o legado aposentou (quem faz esse papel
            * hoje eh o combo cbo_4c_Get_Printer).
            *
            * AutoSize NAO eh transcrito no Option1 (regra #31/#33): em
            * OptionGroup a geometria do botao INTERNO define a altura do
            * grupo e sobrescreveria o 186x24 que o dump declara no grupo.
            *
            * Option1.Value = 1 do dump NAO eh transcrito: OptionButton.Value
            * eh gerenciado pelo GRUPO, e qualquer valor nao-zero num
            * Buttons(N) faz o VFP9 tratar como truthy e marcar TODOS os
            * radios de uma vez. Quem seleciona eh OptionGroup.Value = 1,
            * logo acima (CorretorAutomatico #108).
            *----------------------------------------------------------------
            THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
            WITH THIS.obj_4c_Opt_Impressora
                .Height      = 24
                .Left        = 206
                .Top         = 273
                .Width       = 186
                .ButtonCount = 1
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 1
                .TabIndex    = 4
                .BorderColor = RGB(136, 189, 188)
                .Themes      = .F.
            ENDWITH

            WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Gen" + CHR(233) + "rico/Somente Texto"
                .Height    = 15
                .Left      = 9
                .Top       = 6
                .Width     = 137
                .Style     = 0
                .TabIndex  = 1
                .ForeColor = RGB(90, 90, 90)
                .Enabled   = .F.
                .Visible   = .F.
            ENDWITH

            *----------------------------------------------------------------
            * Carga da lista de impressoras - legado (Init, linhas 1119-1126):
            *     Select crImpreV
            *     Go Top
            *     Thisform.get_Printer.Value     = Recno('crImpreV')
            *     Thisform.get_Printer.RowSource = 'crImpreV'
            *     Thisform.get_Printer.Refresh
            *
            * Quem monta crImpreV eh sigopetsBO.CarregarImpressorasDisponiveis()
            * (Fases 1-2), que reproduz a mesma cadeia do legado: APRINTERS()
            * -> crImpre (impressoras do Windows), SigSyImp/SigCdAcG/SigCdmp
            * -> crSigCdmp (impressoras liberadas para o usuario logado) e o
            * match textual entre as duas -> crImp -> crImpreV (colunas
            * IDupla, impres, impresS).
            *
            * A ordem Value -> RowSource eh a do legado e fica como esta. A
            * suspeita natural - "atribuir RowSource recalcula a lista e
            * descarta um Value posto antes" - foi MEDIDA no VFP9 e eh FALSA:
            * com o cursor em RECNO = 2, as duas ordens terminam em
            * ListIndex = 2 / Value = 2. Nao inverter "para garantir": o
            * ganho eh zero e a divergencia do legado seria gratuita.
            *
            * RowSource so eh atribuido com o alias ABERTO: apontar
            * RowSourceType = 2 para cursor inexistente derruba o Init (mesma
            * familia da regra #41, ControlSource antes do cursor existir).
            *
            * Em modo de validacao de UI / teste nao ha gnConnHandle: a carga
            * eh PULADA e o combo nasce vazio, mas a tela abre (loc_lSucesso
            * = .T.) para o ValidarUIFidelity poder medir o layout.
            *----------------------------------------------------------------
            loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                                (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

            IF loc_lModoSemBanco
                loc_lSucesso = .T.
            ELSE
                loc_oBO = THIS.this_oBusinessObject

                IF VARTYPE(loc_oBO) != "O"
                    MsgErro("Business Object indispon" + CHR(237) + "vel para carregar a " + ;
                        "lista de impressoras.", "Formsigopets")
                ELSE
                    IF loc_oBO.CarregarImpressorasDisponiveis() AND USED("crImpreV") ;
                        AND RECCOUNT("crImpreV") > 0

                        SELECT crImpreV
                        GO TOP

                        THIS.cbo_4c_Get_Printer.Value     = RECNO("crImpreV")
                        THIS.cbo_4c_Get_Printer.RowSource = "crImpreV"
                        THIS.cbo_4c_Get_Printer.Refresh()

                        loc_lSucesso = .T.
                    ELSE
                        *-- Mesmas mensagens do legado ("Nao Foi Encontrada
                        *-- Nenhuma Impressora!!!" / "Impossivel Efetuar
                        *-- Conexao com Servidor de Banco de Dados."), que o
                        *-- BO ja montou em this_cMensagemErro. MsgAviso e
                        *-- nao MsgErro: eh condicao de AMBIENTE do usuario
                        *-- (nao ha impressora liberada), nao falha tecnica.
                        IF EMPTY(loc_oBO.this_cMensagemErro)
                            MsgAviso("N" + CHR(227) + "o Foi Encontrada Nenhuma Impressora!!!", ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                        ELSE
                            MsgAviso(loc_oBO.this_cMensagemErro, ;
                                "Aten" + CHR(231) + CHR(227) + "o")
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarBlocoImpressora")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConfigurarOpcoesImpressao - Fase 6 (campos, parte 2): o bloco de
    * OPCOES de impressao, filhos DIRETOS da Form, a direita da tela
    * (Left 434..663, Top 199..289) - os quatro OptionGroups que faltavam
    * mais os respectivos rotulos (nomes de tasks\task733\mapeamento.json):
    *
    *   Opt_Preco      -> obj_4c_Opt_Preco      "Sim/Nao" - llImpPreco
    *   Label1         -> lbl_4c_Label1         "Preco :"
    *   opt_separador  -> obj_4c_Opt_separador  "Sim/Nao" - llSeparador
    *   lbl_Separador  -> lbl_4c_Lbl_Separador  "Separadora :"
    *   OptOrdem       -> obj_4c_OptOrdem       "Produto/Sem Ordem"
    *   Label3         -> lbl_4c_Label3         "Ordem :"
    *   OptOrigem      -> obj_4c_OptOrigem      "Sim/Nao" - llOrigem (so usado
    *                                           na etiqueta tipo 140)
    *   Label7         -> lbl_4c_Label7         "Origem :"
    *
    * COLISAO DE NOMES NO mapeamento.json (nao eh defeito, mesma familia do
    * comentario em ConfigurarBlocoImpressora): lbl_4c_Label3 ja existe como
    * filho de cnt_4c__Impressora (Say3 "Horizontal", Fase 4). O PAI eh
    * diferente (THIS, nao loc_oCnt), entao AddObject nao colide.
    *
    * NUNCA setar Buttons(N).Value nos radios individuais (CorretorAutomatico
    * #108) - quem seleciona eh o OptionGroup.Value, no nivel do grupo. O
    * dump da opt_separador declara Option1.Value=0/Option2.Value=1, mas
    * isso NAO eh transcrito por essa mesma razao.
    *
    * ForeColor = RGB(90,90,90) em TODOS os botoes e rotulos: estes
    * controles penduram direto na Form (Picture = new_background.jpg,
    * textura CLARA) - branco ficaria invisivel (regra #12).
    *
    * Labels com AutoSize = .F. EXPLICITO mesmo com AutoSize = .T. no dump
    * (regra #23 - no-op em Label criado por AddObject); Width/Height sao
    * os do dump, que JA SAO o auto-size calculado pelo Form Designer.
    * FontBold = .F. nestes quatro rotulos (rotulo de CAMPO, nao de SECAO -
    * os de secao, Etiquetas/Impressoras/Sistema/Windows, sao bold).
    *
    * Buttons(1)/(2) com AutoSize = .T. + Width do dump (controle ESTATICO,
    * nao gerado em runtime - mesmo padrao de obj_4c_Opcao_imp na Fase 4;
    * diferente de obj_4c_Opt_Tipo, cujos botoes sao runtime-gerados pelo
    * legado com AutoSize = .F. explicito).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarOpcoesImpressao()
        LOCAL loc_oErro

        TRY
            *----------------------------------------------------------------
            * Opt_Preco: Top=199 Left=495 Width=168 Height=26 ButtonCount=2
            *            AutoSize=.F. Value=1 TabIndex=7
            *----------------------------------------------------------------
            THIS.AddObject("obj_4c_Opt_Preco", "OptionGroup")
            WITH THIS.obj_4c_Opt_Preco
                .Top         = 199
                .Left        = 495
                .Width       = 168
                .Height      = 26
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .AutoSize    = .F.
                .Value       = 1
                .TabIndex    = 7
            ENDWITH

            WITH THIS.obj_4c_Opt_Preco.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Height    = 15
                .Left      = 6
                .Top       = 5
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH THIS.obj_4c_Opt_Preco.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 15
                .Left      = 75
                .Top       = 5
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .Caption   = "Pre" + CHR(231) + "o :"
                .Height    = 15
                .Left      = 463
                .Top       = 204
                .Width     = 36
                .TabIndex  = 6
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * opt_separador: Top=222 Left=495 Width=168 Height=23
            *                ButtonCount=2 Value=2 TabIndex=9
            *----------------------------------------------------------------
            THIS.AddObject("obj_4c_Opt_separador", "OptionGroup")
            WITH THIS.obj_4c_Opt_separador
                .Top         = 222
                .Left        = 495
                .Width       = 168
                .Height      = 23
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .TabIndex    = 9
            ENDWITH

            WITH THIS.obj_4c_Opt_separador.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Height    = 15
                .Left      = 6
                .Top       = 3
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH THIS.obj_4c_Opt_separador.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 15
                .Left      = 75
                .Top       = 3
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("lbl_4c_Lbl_Separador", "Label")
            WITH THIS.lbl_4c_Lbl_Separador
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .Caption   = "Separadora :"
                .Height    = 15
                .Left      = 434
                .Top       = 225
                .Width     = 65
                .TabIndex  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * OptOrdem: Top=243 Left=495 Width=168 Height=25 ButtonCount=2
            *           AutoSize=.F. Value=2 TabIndex=11
            *----------------------------------------------------------------
            THIS.AddObject("obj_4c_OptOrdem", "OptionGroup")
            WITH THIS.obj_4c_OptOrdem
                .Top         = 243
                .Left        = 495
                .Width       = 168
                .Height      = 25
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .AutoSize    = .F.
                .Value       = 2
                .TabIndex    = 11
            ENDWITH

            WITH THIS.obj_4c_OptOrdem.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Produto"
                .Height    = 15
                .Left      = 6
                .Top       = 3
                .Width     = 56
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH THIS.obj_4c_OptOrdem.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sem Ordem"
                .Height    = 15
                .Left      = 75
                .Top       = 3
                .Width     = 73
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .Caption   = "Ordem :"
                .Height    = 15
                .Left      = 458
                .Top       = 247
                .Width     = 41
                .TabIndex  = 10
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            *----------------------------------------------------------------
            * OptOrigem: Top=266 Left=495 Width=168 Height=23 ButtonCount=2
            *            Value=2 TabIndex=9 - so usado na etiqueta tipo 140
            *            (ToolTipText do dump, transcrito).
            *----------------------------------------------------------------
            THIS.AddObject("obj_4c_OptOrigem", "OptionGroup")
            WITH THIS.obj_4c_OptOrigem
                .Top         = 266
                .Left        = 495
                .Width       = 168
                .Height      = 23
                .ButtonCount = 2
                .BackStyle   = 0
                .BorderStyle = 0
                .Value       = 2
                .TabIndex    = 9
                .ToolTipText = "Opcao usada na etiqueta 140"
            ENDWITH

            WITH THIS.obj_4c_OptOrigem.Buttons(1)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "Sim"
                .Height    = 15
                .Left      = 6
                .Top       = 3
                .Width     = 34
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            WITH THIS.obj_4c_OptOrigem.Buttons(2)
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Caption   = "N" + CHR(227) + "o"
                .Height    = 15
                .Left      = 75
                .Top       = 3
                .Width     = 37
                .AutoSize  = .T.
                .ForeColor = RGB(90, 90, 90)
            ENDWITH

            THIS.AddObject("lbl_4c_Label7", "Label")
            WITH THIS.lbl_4c_Label7
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .Caption   = "Origem :"
                .Height    = 15
                .Left      = 456
                .Top       = 269
                .Width     = 43
                .TabIndex  = 8
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
            ENDWITH
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarOpcoesImpressao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AplicarParametrosPadraoImpressao - Fase 6: aplica os defaults que o
    * Init legado le de CrSigCdPam/CrSigCdPac nos controles de ajuste de
    * impressora (Opcao_imp + os 4 spinners, criados em
    * ConfigurarAjustesImpressora na Fase 4) e no separador (opt_separador,
    * criado acima).
    *
    * Legado (Init, linhas 1165-1178):
    *   With Thisform.Cnt_Impressora
    *       With .Opcao_Imp
    *           .Value = Iif(CrSigCdPam.ImpEtis <> 0, CrSigCdPam.ImpEtis, 1)
    *       Endwith
    *       .Spn_AjVerts.Value = CrSigCdPam.AjVerts
    *       .Spn_AjHorzs.Value = CrSigCdPam.AjHorzs
    *       .Spn_AjDenss.Value = Iif(CrSigCdPac.AjDens<10,10,CrSigCdPac.AjDens)
    *       .Spn_AjVelos.Value = Iif(CrSigCdPac.AjVelos<1, 1, CrSigCdPac.AjVelos)
    *   Endwith
    *   If Type('CrSigCdPac.etqseps') = [N] And CrSigCdPac.etqseps = 1
    *       Thisform.Opt_separador.Value = 1
    *       Thisform.Opt_separador.Refresh
    *   Endif
    *
    * sigopetsBO.ObterParametrosPadraoImpressao() (Fases 1-2) ja reproduz
    * TODA essa leitura/regra de piso (ajdens<10, ajvelos<1, impetis=0 nao
    * troca) via CarregarDoCursor() - este metodo so ESPELHA o resultado
    * nos controles visuais. Fonte unica: sigopetsBO eh quem decide o
    * VALOR, o form so EXIBE (mesma disciplina de FormParaBO/BOParaForm).
    *
    * opt_separador.Value: Buttons(1)="Sim", Buttons(2)="Nao" (ordem do
    * dump) - so troca para 1 quando this_lSeparador, exatamente como o
    * legado; o default de fabrica (.Value = 2, "Nao") fica como esta
    * quando a condicao eh falsa.
    *
    * Sem Return/Messagebox de falha no legado para este trecho do Init -
    * por isso este metodo eh PROCEDURE (sem valor de retorno que bloqueie
    * InicializarForm): best-effort, igual ao original. gb_4c_ValidandoUI/
    * gb_4c_ModoTeste pulam a leitura (sem gnConnHandle, sem CrSigCdPam do
    * form pai) e deixam os controles com os defaults ja postos em
    * ConfigurarAjustesImpressora/ConfigurarOpcoesImpressao.
    *==========================================================================
    PROTECTED PROCEDURE AplicarParametrosPadraoImpressao()
        LOCAL loc_lModoSemBanco, loc_oBO, loc_oErro

        loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                            (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        IF loc_lModoSemBanco
            RETURN
        ENDIF

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O" AND loc_oBO.ObterParametrosPadraoImpressao()
                *-- Espelhamento pelo funil UNICO. O .T. pede o separador
                *-- junto, que eh exatamente o que o Init do legado faz
                *-- (If CrSigCdPac.etqseps = 1 ... Endif) e o que a troca
                *-- de impressora NAO faz - ver BOParaForm.
                THIS.BOParaForm(.T.)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.AplicarParametrosPadraoImpressao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarEventosImpressora - Fase 6 (lookups): liga os DOIS
    * InteractiveChange que o legado tem nesta tela. Sao eles que fazem o
    * papel de LOOKUP aqui - resolver a impressora escolhida e trazer de
    * volta os campos que DEPENDEM dela (o tipo de impressora e os 4
    * ajustes de hardware), exatamente o padrao "escolheu o codigo ->
    * carrega os campos dependentes".
    *
    * Legado - as DUAS unicas PROCEDUREs de evento de CAMPO do dump:
    *
    *   SIGOPETS.Get_Printer.InteractiveChange
    *       loImp = ThisForm.cnt_Impressora
    *       =fCarregarImps(ALLTRIM(crImpreV.impresS), loImp.Opcao_Imp, ;
    *                      loImp.Spn_AjVerts, loImp.Spn_AjHorzs, ;
    *                      loImp.Spn_AjDenss, loImp.Spn_AjVelos, ;
    *                      ThisForm.ParentForm.poDataMgr)
    *
    *   SIGOPETS.Opt_Impressora.InteractiveChange
    *       loImp = ThisForm.cnt_Impressora
    *       =fCarregarImps(ThisForm.Opt_Impressora.Buttons( ;
    *                          ThisForm.Opt_Impressora.Value).Tag, ;
    *                      loImp.Opcao_Imp, loImp.Spn_AjVerts, ;
    *                      loImp.Spn_AjHorzs, loImp.Spn_AjDenss, ;
    *                      loImp.Spn_AjVelos, ;
    *                      ThisForm.ParentForm.poDataMgr, ThisForm.Opt_Tipo)
    *
    * Os dois caem no MESMO funil (ValidarImpressoraSelecionada), igual ao
    * legado, que chama a MESMA fCarregarImps nos dois - o que muda eh so
    * de ONDE sai o nome da impressora (a coluna do cursor, no combo; o Tag
    * do botao marcado, no grupo aposentado).
    *
    * NAO existe lookup de TABELA nesta tela (picker/F4/F5): conferido no
    * dump (zero fwBuscaExt/fwBuscaSel/fwBuscaInt/sigacess/mAddColuna) e em
    * tasks\task733\comportamento.json ("temLookup": false nos 6 metodos).
    * Inventar um FormBuscaAuxiliar aqui violaria o PILAR 1 e a regra
    * "NUNCA inventar tabelas de lookup que nao existem no original" - o
    * universo de impressoras eh FECHADO e ja esta todo no combo
    * (cbo_4c_Get_Printer tem Style = 2, DropDown List: o usuario ESCOLHE,
    * nao digita, logo nao ha codigo digitado para um picker resolver).
    *
    * BINDEVENT exige metodo PUBLIC (CLAUDE.md regra #3): os tres metodos
    * abaixo NAO levam PROTECTED - com PROTECTED o bind falha em silencio.
    *
    * PEMSTATUS guarda a existencia dos dois controles (criados em
    * ConfigurarBlocoImpressora, Fase 5) para o metodo continuar valido se
    * uma fase futura mudar a ordem de montagem - e porque BINDEVENT com
    * referencia invalida estoura no proprio bind, derrubando o Init.
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarEventosImpressora()
        LOCAL loc_oErro

        TRY
            IF PEMSTATUS(THIS, "cbo_4c_Get_Printer", 5)
                BINDEVENT(THIS.cbo_4c_Get_Printer, "InteractiveChange", ;
                    THIS, "GetPrinterInteractiveChange")
            ENDIF

            IF PEMSTATUS(THIS, "obj_4c_Opt_Impressora", 5)
                BINDEVENT(THIS.obj_4c_Opt_Impressora, "InteractiveChange", ;
                    THIS, "OptImpressoraInteractiveChange")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ConfigurarEventosImpressora")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ValidarImpressoraSelecionada - FUNIL do "lookup" desta tela: recebe o
    * nome da impressora no SISTEMA e espelha nos controles os ajustes que
    * sigopetsBO.CarregarAjustesImpressora() (Fases 1-2, porte de
    * fCarregarImps) leu de SigCdmp - obj_4c_Opcao_imp e os 4 spinners de
    * cnt_4c__Impressora, criados em ConfigurarAjustesImpressora (Fase 4).
    *
    * Fonte unica, mesma disciplina de AplicarParametrosPadraoImpressao: o
    * BO eh quem DECIDE o valor (inclusive os pisos ajdens < 10 /
    * ajvelos < 1 e a regra impetis = 0 nao troca, todos dentro de
    * CarregarDoCursor); o form so EXIBE. Sem isto, trocar de impressora no
    * combo deixaria na tela os ajustes de hardware do PADRAO anterior e a
    * etiqueta sairia com densidade/velocidade da impressora errada - sem
    * erro, sem log.
    *
    * Nome VAZIO eh caminho LEGITIMO, nao erro - por isso sai calado:
    *   (a) o Init legado monta crImpreV com uma linha EM BRANCO de
    *       proposito quando ha mais de uma impressora ("Append Blank" -
    *       "se houver mais de uma impressora na lista, posiciona em
    *       impressora em branco"), e eh nela que o combo abre: nenhuma
    *       impressora escolhida ainda, nada a recarregar;
    *   (b) o grupo aposentado obj_4c_Opt_Impressora nao declara Tag no
    *       dump (o bloco do Init que o populava esta inteiro comentado com
    *       *!*), entao o Tag eh "" e a chamada que o Init legado faz na
    *       linha 1180 nao tem impressora para resolver - os defaults que
    *       AplicarParametrosPadraoImpressao acabou de por FICAM, que eh o
    *       efeito observavel no legado de hoje.
    * Avisar "impressora nao encontrada" nesses dois casos, ou limpar os
    * ajustes, seria inventar comportamento que o legado nao tem (regra
    * #50: universo vazio de lookup NAO eh erro).
    *
    * Os RETURN de guarda ficam ANTES do TRY (CLAUDE.md regra #1).
    *
    * Nome do metodo pela ACAO que ele executa, nao pelo Name do objeto
    * legado (PILAR 3).
    *==========================================================================
    PROCEDURE ValidarImpressoraSelecionada(par_cNomeImpressora)
        LOCAL loc_cNome, loc_lModoSemBanco, loc_oBO, loc_oErro

        *-- VARTYPE antes do ALLTRIM: parametro omitido chega como Logico
        *-- .F., e ALLTRIM(.F.) estoura erro 11 em runtime.
        loc_cNome = IIF(VARTYPE(par_cNomeImpressora) = "C", ;
                        ALLTRIM(par_cNomeImpressora), "")

        IF EMPTY(loc_cNome)
            RETURN
        ENDIF

        *-- Sem conexao (ValidarUIFidelity / teste headless) nao ha SigCdmp
        *-- para consultar: os defaults que ja estao na tela seguem validos.
        loc_lModoSemBanco = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                            (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)

        IF loc_lModoSemBanco
            RETURN
        ENDIF

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel para carregar os " + ;
                    "ajustes da impressora.", "Formsigopets")
            ELSE
                *-- loc_cNome eh o nome CADASTRADO (crImpreV.impresS) e vai
                *-- so como PARAMETRO da consulta - NAO se guarda em
                *-- this_cNomeImpressora. Essa property eh o nome de
                *-- IMPRESSAO (crImpreV.impres, outra coluna) e tem um
                *-- unico escritor, o FormParaBO; gravar o impresS aqui
                *-- faria a impressao sair pela impressora errada.
                IF loc_oBO.CarregarAjustesImpressora(loc_cNome)
                    *-- Espelhamento pelo funil UNICO. SEM o separador: o
                    *-- fCarregarImps do legado repoe Opcao_Imp e os 4
                    *-- ajustes e nao toca Opt_separador, que eh escolha do
                    *-- usuario (SigCdmp nem tem a coluna etqseps).
                    THIS.BOParaForm(.F.)
                ELSE
                    *-- CarregarAjustesImpressora so devolve .F. em FALHA
                    *-- tecnica: o caminho "nenhum registro casou o nome"
                    *-- devolve .T. de proposito, mantendo os defaults.
                    *-- MsgAviso e nao MsgErro - eh condicao de dado/ambiente,
                    *-- nao falha do sistema.
                    IF !EMPTY(loc_oBO.this_cMensagemErro)
                        MsgAviso(loc_oBO.this_cMensagemErro, ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Formsigopets.ValidarImpressoraSelecionada")
        ENDTRY
    ENDPROC

    *==========================================================================
    * GetPrinterInteractiveChange - handler de cbo_4c_Get_Printer, ligado
    * por BINDEVENT. Transcreve Get_Printer.InteractiveChange do legado:
    *     =fCarregarImps(ALLTRIM(crImpreV.impresS), ...)
    *
    * O nome sai de crImpreV.impresS, e NAO de .impres: sao colunas
    * DIFERENTES do mesmo cursor - impresS eh o "a.impres" de SigCdmp (o
    * nome CADASTRADO no sistema) e impres eh o "b.impres" de crImpre (o
    * nome da impressora no WINDOWS). Quem casa com SigCdmp.impres na
    * consulta do BO eh o do SISTEMA; trocar as duas faria a busca nunca
    * achar registro - e, pela regra #50, calada.
    *
    * Ler a COLUNA do cursor (em vez do .Value do combo) eh o que o legado
    * faz, e funciona porque RowSourceType = 2 (Alias) faz o VFP9 mover o
    * ponteiro de crImpreV para a linha escolhida - eh a mesma premissa que
    * o Imprime.Click legado usa (lnImpres = Recno('crImpreV') e
    * lcNomeImp = crImpreV.impres).
    *
    * Guarda de USED/EOF: sem o alias aberto (modo de validacao de UI, onde
    * ConfigurarBlocoImpressora pula a carga da lista) a leitura estouraria.
    *==========================================================================
    PROCEDURE GetPrinterInteractiveChange()
        LOCAL loc_cNome

        loc_cNome = ""

        IF USED("crImpreV") AND !EOF("crImpreV")
            loc_cNome = ALLTRIM(crImpreV.impresS)
        ENDIF

        THIS.ValidarImpressoraSelecionada(loc_cNome)
    ENDPROC

    *==========================================================================
    * OptImpressoraInteractiveChange - handler de obj_4c_Opt_Impressora (o
    * grupo de radios APOSENTADO), ligado por BINDEVENT. Transcreve
    * Opt_Impressora.InteractiveChange do legado, que le o nome da
    * impressora no Tag do botao marcado.
    *
    * Tambem eh chamado DIRETO por InicializarForm, reproduzindo a linha
    * 1180 do Init legado (Thisform.Opt_Impressora.InteractiveChange()) -
    * mesmo metodo, mesma posicao no fluxo: DEPOIS dos defaults de
    * CrSigCdPam/CrSigCdPac.
    *
    * Buttons(N) so eh alcancavel com N entre 1 e ButtonCount - indice fora
    * da faixa estoura. Como o grupo ficou com UM botao invisivel e sem Tag
    * (ver ValidarImpressoraSelecionada), na pratica o funil recebe "" e
    * sai calado, igual ao legado de hoje; o metodo fica fiel ao dump para
    * o caso de o grupo voltar a ser populado.
    *==========================================================================
    PROCEDURE OptImpressoraInteractiveChange()
        LOCAL loc_cTag, loc_oGrupo

        loc_cTag = ""

        IF PEMSTATUS(THIS, "obj_4c_Opt_Impressora", 5)
            loc_oGrupo = THIS.obj_4c_Opt_Impressora

            IF loc_oGrupo.Value >= 1 AND loc_oGrupo.Value <= loc_oGrupo.ButtonCount
                *-- Tag eh SEMPRE Character em VFP9 - ALLTRIM eh seguro.
                loc_cTag = ALLTRIM(loc_oGrupo.Buttons(loc_oGrupo.Value).Tag)
            ENDIF
        ENDIF

        THIS.ValidarImpressoraSelecionada(loc_cTag)
    ENDPROC

    *==========================================================================
    * AjustarEstadoBtnImprimir - Fase 7-8: espelha o estado final do botao
    * Imprime, calculado pelo Init legado no ULTIMO trecho (linhas
    * 1182-1185), depois de CarregarTiposEtiqueta() (ConfigurarOptTipo,
    * Fase 4) e CarregarImpressorasDisponiveis() (ConfigurarBlocoImpressora,
    * Fase 5) ja terem rodado:
    *
    *   With Thisform.BtnReport
    *       .Imprime.Enabled = ( lnTipos # 0 And lnImpres # 0)
    *       .Value = Iif( .Imprime.Enabled, 1, 2 )
    *   Endwith
    *
    * lnTipos/lnImpres sao this_nTotalTiposEtiqueta/this_nTotalImpressoras
    * do BO - os MESMOS contadores, ja alimentados pelos dois metodos
    * acima (sigopetsBO, Fases 1-2). Sem impressora ou sem tipo de
    * etiqueta disponivel, o Imprime fica desabilitado e o foco do grupo
    * (.Value) vai para o Sair (Buttons(2)) - identico ao legado.
    *
    * Em modo de validacao de UI / teste headless (gb_4c_ValidandoUI/
    * gb_4c_ModoTeste) os dois carregamentos sao pulados e os contadores
    * ficam em 0 (default do BO) - o Imprime nasce desabilitado, mas a
    * tela abre normalmente para o ValidarUIFidelity medir o layout.
    *==========================================================================
    PROTECTED PROCEDURE AjustarEstadoBtnImprimir()
        LOCAL loc_oBO, loc_oGrp, loc_lImprimeHabilitado

        loc_lImprimeHabilitado = .F.
        loc_oBO = THIS.this_oBusinessObject

        IF VARTYPE(loc_oBO) = "O"
            loc_lImprimeHabilitado = (loc_oBO.this_nTotalTiposEtiqueta <> 0) AND ;
                                      (loc_oBO.this_nTotalImpressoras <> 0)
        ENDIF

        IF PEMSTATUS(THIS, "obj_4c_BtnReport", 5)
            loc_oGrp = THIS.obj_4c_BtnReport

            IF loc_oGrp.ButtonCount >= 1
                loc_oGrp.Buttons(1).Enabled = loc_lImprimeHabilitado
            ENDIF

            loc_oGrp.Value = IIF(loc_lImprimeHabilitado, 1, 2)
        ENDIF
    ENDPROC

    *==========================================================================
    * FormParaBO - funil UNICO de leitura da TELA para o sigopetsBO.
    *
    * Transcreve o cabecalho do Imprime.Click legado, que eh onde o
    * original le os 12 controles editaveis desta tela:
    *
    *   llImpPreco = ( ThisForm.Opt_Preco.Value = 1 )
    *   llImpPeso  = ( ThisForm.Cnt_Impressora.Opt_Qtd.Value = 1 )
    *   llOrigem   = ( ThisForm.optOrigem.Value <> 1 )
    *   With ThisForm.Opt_Tipo
    *       lnTipo  = .Value
    *       vTipEtq = Int( Val( .Buttons(lnTipo).Tag ) )
    *   EndWith
    *   With Thisform.get_Printer
    *       lnImpres  = RECNO("crImpreV")
    *       lcNomeImp = crImpreV.impres
    *   EndWith
    *   With Thisform.Cnt_Impressora
    *       vnTpImp   = .Opcao_Imp.Value
    *       vnAjVerts = .Spn_AjVerts.Value
    *       vnAjHorzs = .Spn_AjHorzs.Value
    *       vnAjDenss = .spn_AjDenss .Value
    *       vnAjVelos = .Spn_AjVelos.Value
    *   EndWith
    *   llSeparador = ( ThisForm.Opt_separador.Value = 1 )   && mais abaixo
    *   ThisForm.OptOrdem.Value                              && mais abaixo
    *
    * O legado guardava esses valores em variaveis LOCAIS do proprio
    * Click. Na arquitetura nova o dono do VALOR eh o sigopetsBO, que ja
    * declara as 12 properties correspondentes (Fase 1) - por isso a
    * leitura vem para ca, num funil unico, e o Imprime.Click passa a
    * consumir THIS.this_oBusinessObject.this_* em vez de manter uma
    * segunda copia dos mesmos dados em locais paralelas. Sem este funil
    * as 12 properties ficam DECLARADAS E NUNCA POPULADAS, e todo metodo
    * do BO que as leia (hoje ObterBop/OrdenarCursorImpressao, via
    * this_nOrdem e this_nTipoEtiqueta) trabalha com o default de fabrica
    * em vez do que esta na tela - divergencia silenciosa.
    *
    * TRES transcricoes em que eh facil errar o sinal/origem:
    *   1. optOrigem usa <> 1 (DIFERENTE de 1), nao = 1 - o legado liga
    *      llOrigem quando o usuario escolhe o 2o botao;
    *   2. vTipEtq vem do .Tag do botao MARCADO, nao do indice .Value - o
    *      indice eh 1..N e o Tag guarda o SigCdTpe.nTipos de verdade;
    *   3. lcNomeImp sai de crImpreV.impres (nome da impressora no
    *      WINDOWS) e NAO de crImpreV.impresS (nome CADASTRADO em
    *      SigCdmp, que eh o que GetPrinterInteractiveChange usa para a
    *      consulta de ajustes). Sao colunas DIFERENTES do mesmo cursor;
    *      trocar as duas faria a impressao sair pela impressora errada.
    *      Este metodo eh o UNICO escritor de this_cNomeImpressora.
    *
    * Ler crImpreV (em vez do .Value do combo) eh o que o legado faz, e
    * funciona porque RowSourceType = 2 (Alias) move o ponteiro do cursor
    * para a linha escolhida. Guarda de USED/EOF porque em modo de
    * validacao de UI o alias nao esta aberto.
    *
    * PROTECTED explicito: FormBase declara FormParaBO como PROTECTED e o
    * VFP9 NAO deixa a subclasse ALARGAR o escopo - omitir o modificador
    * nao tornaria o metodo publico, so esconderia o fato. Chamado sempre
    * por THIS. de dentro da classe (regra #8).
    *
    * FUNCTION (e nao PROCEDURE) porque o Imprime.Click precisa ABORTAR a
    * impressao se a leitura falhar - imprimir com parametro pela metade
    * eh pior que nao imprimir.
    *==========================================================================
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oBO, loc_oCnt, loc_oGrp, loc_nIndiceTipo, loc_oErro

        loc_lSucesso = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel para ler os " + ;
                    "par" + CHR(226) + "metros de impress" + CHR(227) + "o da tela.", ;
                    "Formsigopets")
            ELSE
                loc_oCnt = THIS.cnt_4c__Impressora

                *-- Opt_Preco: Buttons(1) = "Sim" -> llImpPreco
                loc_oBO.this_lImprimirPreco = (THIS.obj_4c_Opt_Preco.Value = 1)

                *-- Cnt_Impressora.opt_Qtd: CheckBox, .Value NUMERICO (regra
                *-- "CheckBox .Value sempre numerico") -> llImpPeso
                loc_oBO.this_lImprimirPesoTotal = (loc_oCnt.chk_4c_Opt_Qtd.Value = 1)

                *-- OptOrigem: llOrigem = ( .Value <> 1 ) - DIFERENTE de 1
                loc_oBO.this_lOrigemEtiqueta140 = (THIS.obj_4c_OptOrigem.Value <> 1)

                *-- Opt_separador: Buttons(1) = "Sim" -> llSeparador
                loc_oBO.this_lSeparador = (THIS.obj_4c_Opt_separador.Value = 1)

                *-- OptOrdem: 1 = Produto (Index On Cpros), 2 = Sem Ordem
                *-- (Index On Recno()). Indice DIRETO, sem +1/-1 (regra #45).
                loc_oBO.this_nOrdem = THIS.obj_4c_OptOrdem.Value

                *-- vTipEtq = Int(Val(Opt_Tipo.Buttons(.Value).Tag))
                loc_oGrp        = THIS.obj_4c_Opt_Tipo
                loc_nIndiceTipo = loc_oGrp.Value

                IF loc_nIndiceTipo >= 1 AND loc_nIndiceTipo <= loc_oGrp.ButtonCount
                    loc_oBO.this_nTipoEtiqueta = ;
                        INT(VAL(loc_oGrp.Buttons(loc_nIndiceTipo).Tag))
                ELSE
                    loc_oBO.this_nTipoEtiqueta = 0
                ENDIF

                *-- Opcao_Imp + os 4 spinners de ajuste de hardware
                loc_oBO.this_nTipoImpressora   = loc_oCnt.obj_4c_Opcao_imp.Value
                loc_oBO.this_nAjusteVertical   = loc_oCnt.obj_4c_Spn_AjVerts.Value
                loc_oBO.this_nAjusteHorizontal = loc_oCnt.obj_4c_Spn_AjHorzs.Value
                loc_oBO.this_nAjusteDensidade  = loc_oCnt.obj_4c_Spn_AjDenss.Value
                loc_oBO.this_nAjusteVelocidade = loc_oCnt.obj_4c_Spn_AjVelos.Value

                *-- lcNomeImp = crImpreV.impres (nome no WINDOWS)
                loc_oBO.this_cNomeImpressora = ""

                IF USED("crImpreV") AND !EOF("crImpreV")
                    loc_oBO.this_cNomeImpressora = crImpreV.impres
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopets.FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * BOParaForm - funil UNICO de espelhamento do sigopetsBO na TELA.
    *
    * Caminho inverso do FormParaBO. O legado faz esse espelhamento em
    * DOIS pontos, e os dois caem aqui:
    *
    *   1. Init (parametros padrao, CrSigCdPam/CrSigCdPac):
    *          Thisform.Cnt_Impressora.Opcao_Imp.Value   = CrSigCdPam.ImpEtis
    *          Thisform.Cnt_Impressora.Spn_AjVerts.Value = CrSigCdPam.AjVerts
    *          ... (os 4 ajustes) ...
    *          If CrSigCdPac.etqseps = 1
    *              Thisform.Opt_separador.Value = 1
    *              Thisform.Opt_separador.Refresh
    *          Endif
    *
    *   2. fCarregarImps (Get_Printer/Opt_Impressora.InteractiveChange):
    *          repoe Opcao_Imp + os MESMOS 4 ajustes para a impressora
    *          recem-escolhida - e NAO toca o separador.
    *
    * Dai o par_lIncluirSeparador: a diferenca entre os dois pontos eh
    * exatamente esse controle, e ela eh REGRA do legado, nao detalhe.
    * Reaplicar o separador na troca de impressora sobrescreveria uma
    * escolha do usuario que o original preserva - SigCdmp nem tem a
    * coluna etqseps, e sigopetsBO.CarregarDoCursor guarda cada campo com
    * TYPE(), entao this_lSeparador chega aqui com o valor ANTIGO.
    *
    * Parametro LOGICO omitido chega como Logico .F. em alguns caminhos e
    * como Undefined em outros - testar PCOUNT() + VARTYPE antes de usar,
    * nunca o valor cru.
    *
    * O separador so vai para "Sim" (Buttons(1)); nunca volta para "Nao"
    * aqui, porque o legado tambem nao volta (If ... EndIf sem Else).
    *
    * PROTECTED explicito pelo mesmo motivo do FormParaBO: FormBase ja
    * declara BOParaForm como PROTECTED e o escopo vem da HERANCA.
    *==========================================================================
    PROTECTED FUNCTION BOParaForm(par_lIncluirSeparador)
        LOCAL loc_lSucesso, loc_lSeparador, loc_oBO, loc_oCnt, loc_oErro

        loc_lSucesso = .F.

        loc_lSeparador = (PCOUNT() >= 1) AND ;
                         (VARTYPE(par_lIncluirSeparador) = "L") AND ;
                         par_lIncluirSeparador

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) != "O"
                MsgErro("Business Object indispon" + CHR(237) + "vel para exibir os " + ;
                    "par" + CHR(226) + "metros de impress" + CHR(227) + "o.", ;
                    "Formsigopets")
            ELSE
                loc_oCnt = THIS.cnt_4c__Impressora

                loc_oCnt.obj_4c_Opcao_imp.Value    = loc_oBO.this_nTipoImpressora
                loc_oCnt.obj_4c_Spn_AjVerts.Value  = loc_oBO.this_nAjusteVertical
                loc_oCnt.obj_4c_Spn_AjHorzs.Value  = loc_oBO.this_nAjusteHorizontal
                loc_oCnt.obj_4c_Spn_AjDenss.Value  = loc_oBO.this_nAjusteDensidade
                loc_oCnt.obj_4c_Spn_AjVelos.Value  = loc_oBO.this_nAjusteVelocidade

                loc_oCnt.Refresh()

                IF loc_lSeparador AND loc_oBO.this_lSeparador
                    THIS.obj_4c_Opt_separador.Value = 1
                    THIS.obj_4c_Opt_separador.Refresh()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigopets.BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * RestaurarOcultosDoDump - repoe o Visible/Enabled dos controles que o
    * SCX declara OCULTOS, DEPOIS da varredura de TornarControlesVisiveis.
    *
    * A varredura liga Visible = .T. em TUDO (AddObject cria todo controle
    * invisivel) e recursa dentro de OptionGroup - entao ela REEXIBE o
    * Option1 aposentado de obj_4c_Opt_Impressora, que o dump declara com
    * Visible = .F. + Enabled = .F.
    *
    * O conserto vem AQUI, e nao como excecao dentro da varredura, porque o
    * nome do alvo eh "Option1", generico: TODO OptionGroup desta tela
    * (obj_4c_Opt_Tipo, obj_4c_Opcao_imp, e os da Fase 6) tem um Option1, e
    * uma excecao por nome esconderia o 1o botao de todos eles.
    *
    * PEMSTATUS guarda a existencia do grupo para o metodo continuar valido
    * se uma fase futura mudar a ordem de montagem.
    *==========================================================================
    PROTECTED PROCEDURE RestaurarOcultosDoDump()
        IF PEMSTATUS(THIS, "obj_4c_Opt_Impressora", 5)
            IF THIS.obj_4c_Opt_Impressora.ButtonCount >= 1
                THIS.obj_4c_Opt_Impressora.Buttons(1).Visible = .F.
                THIS.obj_4c_Opt_Impressora.Buttons(1).Enabled = .F.
            ENDIF
        ENDIF
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - AddObject cria todo controle com
    * Visible = .F.; este metodo percorre a arvore e os liga.
    *
    * NAO ha container flutuante a excetuar nesta tela: o dump declara
    * Visible = .F. (e Enabled = .F.) em UM unico objeto, e nao eh
    * container - eh "Opt_Impressora.Option1", o radio aposentado e
    * substituido pelo combobox Get_Printer (ver comentario do legado,
    * linhas *!* do Init, e sigopetsBO.prg cabecalho). Opt_Tipo NAO tem
    * nada oculto no dump - a Fase 4 que o cria nao precisa de excecao
    * aqui. O Opt_Impressora foi criado na Fase 5, e eh por isso que
    * RestaurarOcultosDoDump() roda LOGO DEPOIS desta varredura no
    * InicializarForm: a varredura recursa dentro de OptionGroup e REEXIBE
    * esse Option1, que o dump manda nascer oculto.
    *==========================================================================
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oCtrl

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oCtrl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oCtrl) = "O"
                IF PEMSTATUS(loc_oCtrl, "Visible", 5)
                    loc_oCtrl.Visible = .T.
                ENDIF
                IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
                    LOCAL loc_nP
                    FOR loc_nP = 1 TO loc_oCtrl.PageCount
                        THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_nP))
                    ENDFOR
                ENDIF
                IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oCtrl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * Destroy - solta a referencia ao form pai. O BO e os cursores que ele
    * le (TprMvCab / crSigMvNfi / dbImpressao / CrSigCdPam) pertencem ao
    * form PAI, que continua vivo depois deste dialogo fechar - por isso
    * este Destroy NAO fecha nenhum desses aliases.
    *
    * DODEFAULT() eh a ULTIMA linha, obrigatoriamente: FormBase.Destroy
    * repoe os pads do menu principal; sem ele o menu volta encolhido
    * (CorretorAutomatico #145).
    *==========================================================================
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.

        DODEFAULT()
    ENDPROC

ENDDEFINE
