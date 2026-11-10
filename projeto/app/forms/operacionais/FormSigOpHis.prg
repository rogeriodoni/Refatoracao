*==============================================================================
* FormSigOpHis.prg - Historico de Produtos (tela de filtro)
*==============================================================================
* Herda de: FormBase
* BO: SigOpHisBO
* Legado: SIGOPHIS.SCX (tasks/task745/SigOpHis_form_codigo_fonte.txt)
* Tipo: OPERACIONAL (form PLANO sem PageFrame - todos os objetos do dump sao
*       filhos diretos de SIGOPHIS ou de cntSombra, sem Pagina.Lista/Dados)
*
* Dialogo MODAL que recebe Grupo/Conta (contabeis), Produto e um periodo
* (Data Inicial/Data Final), valida os quatro campos (SigOpHisBO.ValidarFiltro)
* e repassa os parametros para FormSigPrHpr (ja migrado - "Do Form SigPrHpr
* With ThisForm" no legado), que le as PRIVATE pcCdGrupo/pcCdConta/
* pcCdProduto/pcDsProduto/pdDataIni/pdDataFin declaradas pelo botao Consulta
* (ver SIGOPHIS.sair.consulta.Click no dump).
*
* DataSession = 2 (dump linha 138) - Init() chama DODEFAULT() para
* FormBase.Init() aplicar SET DATE TO BRITISH + SET CENTURY ON (regra
* CLAUDE.md #9.4).
*
* Montagem (migracao multi-fase):
*   Fase 3 (ja feita) - DEFINE CLASS, Init/Destroy/InicializarForm, cabecalho
*                       cnt_4c_Sombra, TornarControlesVisiveis.
*   Fase 4 (feita)    - SEM TRABALHO, medido no dump (tasks/task745/
*                       SigOpHis_form_codigo_fonte.txt): ZERO BaseClass
*                       grid|pageframe|listbox, ZERO AddCursor/pColuna/
*                       Grade/grd, ZERO RecordSource; a UNICA ocorrencia de
*                       ControlSource (Get_grupo) eh override VAZIO ("")
*                       (regra #49 - nao transcrever, nao conta como
*                       lista). O form inteiro eh um dialogo de CAPTURA
*                       (8 fwget + CommandGroup "sair" com 2 botoes -
*                       Consulta/Encerrar), sem nenhuma superficie de
*                       LISTA para entregar Grid+CRUD (Incluir/
*                       Visualizar/Alterar/Excluir/Buscar/Encerrar) -
*                       inventar essa grade violaria o PILAR 1 ("manter
*                       o mais proximo possivel") e a regra "NUNCA
*                       inventar lista que o legado nao tem". Mesmo
*                       perfil ja registrado em SigOpChp (task699),
*                       SigOpCtd (task715) e SigOpCts (task717) - ver
*                       memoria
*                       feedback_noop_guard_sem_excecao_para_fase_sem_trabalho.
*   Fase 5 (feita)    - metade dos campos de filtro: Grupo (Get_grupo/
*                       Get_Dgrupo) e Conta (Get_est/Get_dest), via
*                       ConfigurarCamposFiltro().
*   Fase 6 (esta)     - segunda metade dos campos: Produto (Get_cod/
*                       Get_dcod) e Periodo (Get_DataIni/Say5/
*                       Get_DataFin), via ConfigurarCamposFiltro(), com
*                       as duas datas nascendo em DATE() como no Init
*                       legado; o CommandGroup "sair" (Consulta +
*                       Encerrar), via ConfigurarBotoesAcao() -
*                       geometria/icones/captions transcritos do dump
*                       (Command1="consulta"/Command2="sair"); e os SEIS
*                       LOOKUPS dos campos de codigo/descricao, ligados
*                       por BINDEVENT("LostFocus") + BINDEVENT("KeyPress")
*                       (F4 = 115) e resolvidos por SELECT TOP 1 exato +
*                       FormBuscaAuxiliar sobre SigCdGcr (Grupo),
*                       SigCdCli (Conta) e SigCdPro (Produto) - regra
*                       CLAUDE.md #36/#37/#47/#50, no lugar do
*                       fAcessoContab/fAcessoContas/fwBuscaExt do legado.
*                       O When de Get_Dgrupo/Get_dest/Get_dcod vira
*                       AjustarCamposDependentes().
*   Fase 7 (esta)     - eventos dos DOIS botoes que o legado tem, com o
*                       BINDEVENT("Click") de obj_4c_Sair.Buttons(1)/(2):
*                       BtnConsultaClick (consulta.Click - FormParaBO() +
*                       SigOpHisBO.ValidarFiltro() + MsgAviso/
*                       FocarCampoRecusado() no campo recusado e, se
*                       valido, Enabled=.F. + CREATEOBJECT("FormSigPrHpr",
*                       THIS) com as PRIVATE pcCd*/pdData* declaradas no
*                       handler) e BtnEncerrarClick (sair.Click ->
*                       THIS.Release()). NAO ha BtnIncluir/Alterar/
*                       Visualizar/ExcluirClick: o legado nao tem CRUD
*                       algum (herda de "form" puro, sem frmcadastro, sem
*                       Grupo_Op e sem pcEscolha) - ver o bloco "EVENTOS
*                       DOS BOTOES DE ACAO" adiante.
*   Fase 8 (esta)     - BOParaForm(), contraparte simetrica de FormParaBO()
*                       que faltava para fechar o contrato de form - o
*                       gate da Fase 8 classifica este dialogo como
*                       layout FILTRO-DESPACHO (legado sem lista/grade,
*                       sem CRUD, sem persistencia, despachando via
*                       "Do Form" para outro form), que dispensa
*                       BtnCancelarClick/CarregarLista mas EXIGE
*                       FormParaBO/BOParaForm/Btn\w*Click - os dois
*                       ultimos ja existiam desde a Fase 7. Chamado de
*                       ConfigurarPageFrame() ao final da montagem, para
*                       nao ficar metodo morto (regra "sem stub"):
*                       centraliza no BO (ja com os defaults postos em
*                       SigOpHisBO.Init()) a origem dos valores em branco
*                       do dialogo, em vez de duplicar literal "" /
*                       DATE() tanto no AddObject quanto no BO. Revisao
*                       final de completude: sem TODO/stub, Fases 3-8
*                       presentes.
*
* Nomes de objeto conforme tasks/task745/mapeamento.json.
*==============================================================================

DEFINE CLASS FormSigOpHis AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGOPHIS.SCX: DataSession=2, BorderStyle=2,
    * Height=300, Width=650, AutoCenter=.T., ControlBox=.F., MaxButton=.F.,
    * MinButton=.F., TitleBar=0 - dump linhas 138-151). Closable NAO consta
    * do dump - nao inventar (feedback Closable_inventado_tira_a_unica_saida).
    *--------------------------------------------------------------------------
    DataSession  = 2
    Width        = 650
    Height       = 300
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *--------------------------------------------------------------------------
    * this_lEmLookup - guarda de reentrancia dos lookups (regra CLAUDE.md #37
    * e #47). O picker (FormBuscaAuxiliar) eh MODAL: ao receber o foco ele
    * dispara de novo o LostFocus do campo que o abriu, o que empilharia um
    * segundo dialogo. O corpo de cada handler vive num <Nome>Exec() para que
    * a flag seja SEMPRE liberada pelo wrapper, inclusive nos RETURN
    * antecipados; os irmaos de F4 usam save/restore (loc_lEmLookupAnt) porque
    * compoem sob aninhamento.
    *--------------------------------------------------------------------------
    this_lEmLookup = .F.

    Caption = "Hist" + CHR(243) + "rico de Produtos"

    *--------------------------------------------------------------------------
    * Init - cria o Business Object antes do DODEFAULT(), para que
    * InicializarForm() (chamado por FormBase.Init() via DODEFAULT) ja o
    * encontre pronto.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpHisBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Falha ao criar SigOpHisBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Hist" + CHR(243) + "rico de Produtos: " + ;
                loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - encadeia direto para FormBase.Destroy() (libera
    * this_oBusinessObject e restaura o menu principal).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo e
    * cabecalho nesta fase; campos e botoes nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("SigOpHisBO n" + CHR(227) + "o foi inicializado.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.TornarControlesVisiveis(THIS)

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpHis.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGOPHIS nao
    * tem PageFrame no legado (layout flat: cntSombra + campos + botao de
    * saida direto no form) - o nome do metodo e mantido apenas como ponto
    * de entrada arquitetural padrao (mesmo papel em Formsigopfin/
    * FormSigPrHpr).
    *
    * Fase 3 (feita)  - ConfigurarCabecalho() (cnt_4c_Sombra).
    * Fase 5 (feita)  - ConfigurarCamposFiltro() com a metade Grupo/Conta.
    * Fase 6 (feita)  - completar ConfigurarCamposFiltro() com Produto/
    *                   Periodo + o BINDEVENT dos seis lookups, e
    *                   ConfigurarBotoesAcao() (CommandGroup "sair":
    *                   Consulta/Encerrar).
    * Fase 8 (esta)   - BOParaForm() apos ConfigurarCamposFiltro(), para
    *                   que o estado inicial dos TextBox venha do BO
    *                   (fonte unica dos defaults do dialogo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarCamposFiltro()
        THIS.BOParaForm()
        THIS.ConfigurarBotoesAcao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposFiltro - campos de filtro do dialogo. Todos filhos
    * diretos de THIS (form flat, sem PageFrame real - regra documentada no
    * cabecalho do arquivo).
    *
    * Fase 5 (feita): metade Grupo (Say4+Get_grupo+Get_Dgrupo) e Conta
    * (Say1+Get_est+Get_dest). Fase 6 (esta) completa com Produto
    * (Say2+Get_cod+Get_dcod), Periodo (Say3+Get_DataIni+Say5+Get_DataFin) e
    * o BINDEVENT dos seis lookups.
    *
    * Geometria TRANSCRITA do dump (tasks/task745/SigOpHis_form_codigo_
    * fonte.txt): Say1/Say2/Say3/Say4/Say5 sao classe "say" (AutoSize=.T./
    * Alignment=0 no legado, sem Width declarado) - regra CLAUDE.md #23:
    * usar AutoSize=.F. + Alignment=0 + Width que caiba o texto (nao
    * inventar Alignment=1), FontBold=.T. por nao haver override no dump
    * (mesmo padrao do irmao FormSigOpBcb). Width=38..52/Height=15 seguem o
    * padrao do projeto para as legendas "Grupo :"/"Conta :"/"Produto :"/
    * "Per" + CHR(237) + "odo :" (FormSIGRECMV, FormSigReCsp, FormSIGRECND,
    * FormSIGREAPR, Formsigreapp). Say5 ("CHR(224)" - separador "a" das
    * datas, mesmo CHR() do separador de periodo em FormBAL) nao tem
    * Width/Alignment no dump - AutoSize=.F. com Width=10 so para caber o
    * caractere.
    *
    * Get_grupo/Get_Dgrupo/Get_est/Get_dest/Get_cod/Get_dcod/Get_DataIni/
    * Get_DataFin sao classe "fwget" (BaseClass textbox) - Height=23 so
    * consta explicito no dump para Get_grupo; os demais nao declaram
    * (extracao terse desta task) e seguem o mesmo valor para alinhar
    * visualmente a linha. FontName/FontSize/BackStyle/BorderStyle/
    * SpecialEffect/ForeColor seguem o padrao canonico de fwget do projeto
    * (FormSigOpBcb/FormSigOpCcl); Get_est preserva o UNICO override de
    * fonte do dump (FontName="Courier New").
    *
    * MaxLength: Get_grupo/Get_Dgrupo validam contra SigCdGcr.codigos
    * char(10)/descrs char(40) (fAcessoContab - Framework\sigacess.PRG:1029,
    * 1104/1107); Get_est/Get_dest contra SigCdCli.iclis char(10)/rclis
    * char(50) (fAcessoContas - Framework\sigacess.PRG:158, linha 63 do
    * corpo); Get_cod/Get_dcod contra SigCdPro.cpros char(14)/dpros char(65)
    * (docs/schema.sql - cpros bate com o MaxLength=14 ja declarado no dump
    * linha 251; dpros nao tem MaxLength explicito no dump, usar a largura
    * da coluna). Get_DataIni/Get_DataFin usam MaxLength=10 (dump linhas
    * 369/392 - tamanho da mascara "99/99/9999") - regra CLAUDE.md #19,
    * MaxLength vem da coluna/mascara, nunca do Width em pixels. Confirmado
    * em docs/schema.sql (UTF-16).
    *
    * Get_DataIni/Get_DataFin sao campos de DATA (Alignment=3 - dump linhas
    * 365/389), nao char: nascem em DATE(), nao em SPACE(N), reproduzindo o
    * Init legado (ThisForm.get_dataini.Value = Date() / get_datafin.Value =
    * Date()). InputMask="99/99/9999"
    * so consta explicito no dump para Get_DataFin (linha 390); aplicado
    * tambem a Get_DataIni para a mesma mascara visual nos dois campos da
    * linha.
    *
    * Sem ControlSource (comportamento.json confirma totalQueries=0 - os oito
    * campos sao de CAPTURA e os seis de lookup resolvem o par codigo/
    * descricao por consulta propria, nao por vinculo de cursor). O BINDEVENT
    * dos seis lookups fecha este metodo; o bloco LOOKUPS DOS CAMPOS DE
    * FILTRO, mais abaixo, documenta a correspondencia com o Valid/When do
    * legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposFiltro()
        LOCAL loc_oErro

        TRY
            *-- Say4 "Grupo :"
            THIS.AddObject("lbl_4c_Label4", "Label")
            WITH THIS.lbl_4c_Label4
                .Top       = 124
                .Left      = 101
                .Width     = 38
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Grupo :"
                .Visible   = .T.
            ENDWITH

            *-- Get_grupo - codigo do Grupo Contabil (SigCdGcr.codigos)
            THIS.AddObject("txt_4c_Grupo", "TextBox")
            WITH THIS.txt_4c_Grupo
                .Top           = 121
                .Left          = 148
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .MaxLength     = 10
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 1
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Get_Dgrupo - descricao do Grupo Contabil (SigCdGcr.descrs)
            THIS.AddObject("txt_4c_Dgrupo", "TextBox")
            WITH THIS.txt_4c_Dgrupo
                .Top           = 121
                .Left          = 228
                .Width         = 150
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .MaxLength     = 40
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 2
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Say1 "Conta :"
            THIS.AddObject("lbl_4c_Label1", "Label")
            WITH THIS.lbl_4c_Label1
                .Top       = 149
                .Left      = 102
                .Width     = 38
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Conta :"
                .Visible   = .T.
            ENDWITH

            *-- Get_est - codigo da Conta (SigCdCli.iclis). FontName
            *-- "Courier New" e o UNICO override de fonte do dump.
            THIS.AddObject("txt_4c_Est", "TextBox")
            WITH THIS.txt_4c_Est
                .Top           = 144
                .Left          = 148
                .Width         = 80
                .Height        = 23
                .FontName      = "Courier New"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .MaxLength     = 10
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 3
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Get_dest - descricao da Conta (SigCdCli.rclis)
            THIS.AddObject("txt_4c_Dest", "TextBox")
            WITH THIS.txt_4c_Dest
                .Top           = 144
                .Left          = 228
                .Width         = 290
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .MaxLength     = 50
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 4
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Say2 "Produto :"
            THIS.AddObject("lbl_4c_Label2", "Label")
            WITH THIS.lbl_4c_Label2
                .Top       = 172
                .Left      = 92
                .Width     = 48
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Produto :"
                .Visible   = .T.
            ENDWITH

            *-- Get_cod - codigo do Produto (SigCdPro.cpros char(14))
            THIS.AddObject("txt_4c_Cod", "TextBox")
            WITH THIS.txt_4c_Cod
                .Top           = 167
                .Left          = 148
                .Width         = 108
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .MaxLength     = 14
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 5
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Get_dcod - descricao do Produto (SigCdPro.dpros char(65))
            THIS.AddObject("txt_4c_Dcod", "TextBox")
            WITH THIS.txt_4c_Dcod
                .Top           = 167
                .Left          = 257
                .Width         = 290
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 0
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .MaxLength     = 65
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 6
                .Value         = ""
                .Visible       = .T.
            ENDWITH

            *-- Say3 "Periodo :"
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .Top       = 196
                .Left      = 92
                .Width     = 52
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = "Per" + CHR(237) + "odo :"
                .Visible   = .T.
            ENDWITH

            *-- Get_DataIni - data inicial do periodo (campo DATA, nao char)
            THIS.AddObject("txt_4c_DataIni", "TextBox")
            WITH THIS.txt_4c_DataIni
                .Top           = 191
                .Left          = 148
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 3
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .InputMask     = "99/99/9999"
                .MaxLength     = 10
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 7
                .Value         = DATE()
                .Visible       = .T.
            ENDWITH

            *-- Say5 "a" - separador entre as duas datas do periodo
            THIS.AddObject("lbl_4c_Label5", "Label")
            WITH THIS.lbl_4c_Label5
                .Top       = 195
                .Left      = 231
                .Width     = 10
                .Height    = 15
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .T.
                .ForeColor = RGB(90, 90, 90)
                .Caption   = CHR(224)
                .Visible   = .T.
            ENDWITH

            *-- Get_DataFin - data final do periodo (campo DATA, nao char)
            THIS.AddObject("txt_4c_DataFin", "TextBox")
            WITH THIS.txt_4c_DataFin
                .Top           = 191
                .Left          = 242
                .Width         = 80
                .Height        = 23
                .FontName      = "Tahoma"
                .FontSize      = 9
                .FontBold      = .F.
                .FontItalic    = .F.
                .FontUnderline = .F.
                .Alignment     = 3
                .BackStyle     = 1
                .BorderStyle   = 1
                .SpecialEffect = 1
                .InputMask     = "99/99/9999"
                .MaxLength     = 10
                .ForeColor     = RGB(0, 0, 0)
                .TabIndex      = 8
                .Value         = DATE()
                .Visible       = .T.
            ENDWITH

            *----------------------------------------------------------
            * Lookups - BINDEVENT dos seis campos que o legado valida no
            * Valid (Get_grupo/Get_Dgrupo/Get_est/Get_dest/Get_cod/
            * Get_dcod). Dois eventos por campo:
            *
            *   "LostFocus" - funil de validacao, equivalente ao Valid do
            *                 legado (dispara ao SAIR do campo). Ligar o
            *                 picker a "KeyPress" sem testar a tecla abre
            *                 o dialogo a CADA caractere digitado e o
            *                 usuario nao consegue terminar de digitar o
            *                 codigo (regra CLAUDE.md #47).
            *   "KeyPress"  - so abre o picker em F4 (par_nKeyCode = 115),
            *                 atalho padrao do projeto. O handler TESTA a
            *                 tecla, portanto nao incorre na regra #47.
            *
            * LostFocus nao recebe parametro algum - os handlers ligados a
            * ele NAO declaram par_nKeyCode (regra CLAUDE.md #3).
            *----------------------------------------------------------
            BINDEVENT(THIS.txt_4c_Grupo,  "LostFocus", THIS, "GrupoLostFocus")
            BINDEVENT(THIS.txt_4c_Grupo,  "KeyPress",  THIS, "GrupoKeyPress")
            BINDEVENT(THIS.txt_4c_Dgrupo, "LostFocus", THIS, "DgrupoLostFocus")
            BINDEVENT(THIS.txt_4c_Dgrupo, "KeyPress",  THIS, "DgrupoKeyPress")

            BINDEVENT(THIS.txt_4c_Est,    "LostFocus", THIS, "EstLostFocus")
            BINDEVENT(THIS.txt_4c_Est,    "KeyPress",  THIS, "EstKeyPress")
            BINDEVENT(THIS.txt_4c_Dest,   "LostFocus", THIS, "DestLostFocus")
            BINDEVENT(THIS.txt_4c_Dest,   "KeyPress",  THIS, "DestKeyPress")

            BINDEVENT(THIS.txt_4c_Cod,    "LostFocus", THIS, "CodLostFocus")
            BINDEVENT(THIS.txt_4c_Cod,    "KeyPress",  THIS, "CodKeyPress")
            BINDEVENT(THIS.txt_4c_Dcod,   "LostFocus", THIS, "DcodLostFocus")
            BINDEVENT(THIS.txt_4c_Dcod,   "KeyPress",  THIS, "DcodKeyPress")

            *-- Estado inicial dos tres campos de descricao (reproduz o
            *-- PROCEDURE When de Get_Dgrupo/Get_dest/Get_dcod do legado).
            THIS.AjustarCamposDependentes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposFiltro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesAcao - CommandGroup "sair" do dump (SIGOPHIS.sair,
    * ButtonCount=2, dump linhas 269-316). Buttons(1) = Command1/"consulta"
    * (Picture geral_procura_60.jpg, Caption "\<Consulta"), Buttons(2) =
    * Command2/"sair" (Picture cadastro_sair_60.jpg, Caption "Encerrar",
    * Cancel=.T.) - indexacao NUMERICA dos Buttons (CLAUDE.md regra #34),
    * nunca por .Name. Geometria/fonte/cores TRANSCRITAS do dump
    * (Top/Left/Height/Width/FontName="Comic Sans MS"/FontBold/FontItalic/
    * FontSize/WordWrap/ForeColor/BackColor/Themes=.F. de cada Command);
    * icones resolvidos via gc_4c_CaminhoIcones (regra CLAUDE.md #25 - o
    * legado aponta para Framework\imagens, mas os mesmos .jpg existem em
    * vbmp\gc_4c_CaminhoIcones, igual ao restante do projeto).
    *
    * CommandGroup.Left=493 do dump extrapola o Width=650 do form junto com
    * ButtonCount=2 (Left=493 + Width=161 = 654 > 650) - ajustado para
    * terminar dentro do form (Left = THIS.Width - 161 - 6), preservando a
    * geometria INTERNA dos dois Command (regra sobre controle fora da
    * area do pai ser recortado).
    *
    * CommandGroup NAO tem FontName (CLAUDE.md regra #33) - fonte so nos
    * Buttons(N) individuais. O Click dos dois botoes (Consulta/Encerrar) eh
    * ligado na fase de eventos do form, descrita no cabecalho do arquivo -
    * aqui o CommandGroup entrega a geometria e os icones do dump.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesAcao()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("obj_4c_Sair", "CommandGroup")
            WITH THIS.obj_4c_Sair
                .Top         = -2
                .Left        = THIS.Width - 161 - 6
                .Width       = 161
                .Height      = 85
                .ButtonCount = 2
                .AutoSize    = .T.
                .BackStyle   = 0
                .BorderStyle = 0
                .SpecialEffect = 1
                .BorderColor = RGB(136, 188, 189)
                .Themes      = .F.
                .Value       = 1
                .Visible     = .T.

                WITH .Buttons(1)
                    .Top       = 5
                    .Left      = 5
                    .Height    = 75
                    .Width     = 75
                    .FontBold  = .T.
                    .FontItalic = .T.
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .WordWrap  = .T.
                    .Picture   = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                    .Caption   = "\<Consulta"
                    .ForeColor = RGB(90, 90, 90)
                    .BackColor = RGB(255, 255, 255)
                    .Themes    = .F.
                ENDWITH

                WITH .Buttons(2)
                    .Top       = 5
                    .Left      = 81
                    .Height    = 75
                    .Width     = 75
                    .FontBold  = .T.
                    .FontItalic = .T.
                    .FontName  = "Comic Sans MS"
                    .FontSize  = 8
                    .WordWrap  = .T.
                    .Picture   = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                    .Cancel    = .T.
                    .Caption   = "Encerrar"
                    .ForeColor = RGB(90, 90, 90)
                    .BackColor = RGB(255, 255, 255)
                    .Themes    = .F.
                ENDWITH
            ENDWITH

            *----------------------------------------------------------
            * Click dos dois botoes do CommandGroup. Buttons(N) eh
            * indexado por NUMERO (regra CLAUDE.md #34) e N <= ButtonCount
            * (= 2, declarado acima). Os dois delegates sao PUBLIC - metodo
            * PROTECTED falha em SILENCIO no BINDEVENT (regra #3).
            *----------------------------------------------------------
            BINDEVENT(THIS.obj_4c_Sair.Buttons(1), "Click", THIS, "BtnConsultaClick")
            BINDEVENT(THIS.obj_4c_Sair.Buttons(2), "Click", THIS, "BtnEncerrarClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoesAcao")
        ENDTRY
    ENDPROC

    *==========================================================================
    * EVENTOS DOS BOTOES DE ACAO - obj_4c_Sair (CommandGroup "sair" do dump)
    *
    * O CommandGroup do legado tem DOIS botoes, cada um com o seu Click
    * (SIGOPHIS.sair.consulta.Click e SIGOPHIS.sair.sair.Click no dump):
    *
    *   Buttons(1) "\<Consulta" (consulta) -> BtnConsultaClick
    *   Buttons(2) "Encerrar"   (sair)     -> BtnEncerrarClick
    *
    * Esses dois botoes sao TODA a superficie de acao do legado: o SCX herda
    * de "form" PURO (nao de frmcadastro), nao tem Grupo_Op, nao declara
    * pcEscolha e nao possui nenhum objeto Incluir/Alterar/Visualizar/
    * Excluir - eh um dialogo de CAPTURA de filtros, nao um cadastro. Por
    * isso NAO existem aqui os BtnIncluirClick/BtnAlterarClick/
    * BtnVisualizarClick/BtnExcluirClick da convencao CRUD: cria-los
    * obrigaria a INVENTAR botoes que o legado nao tem (viola o PILAR 1 e a
    * regra "NUNCA inventar") ou a escrever quatro metodos vazios (proibido
    * pela regra de completude).
    *
    * Os dois handlers sao PUBLIC - exigido por BINDEVENT (regra CLAUDE.md
    * #3) - e BtnEncerrarClick usa o nome canonico que o harness
    * TesteAutomatico reconhece no teste BtnEncerrarExiste.
    *==========================================================================

    *--------------------------------------------------------------------------
    * FormParaBO - transfere os oito campos da tela para o BO, na MESMA ordem
    * do bloco "Inicializa variaveis de campos" do consulta.Click legado:
    *
    *     pcCdGrupo   = ThisForm.get_grupo.Value
    *     pcCdConta   = ThisForm.get_est.Value
    *     pcDsConta   = ThisForm.get_dest.Value
    *     pcCdProduto = ThisForm.get_cod.Value
    *     pcDsProduto = ThisForm.get_dcod.Value
    *     pdDataIni   = ThisForm.get_dataini.Value
    *     pdDataFin   = ThisForm.get_datafin.Value
    *
    * FUNCTION (nao PROCEDURE) devolvendo .T./.F.: BtnConsultaClick ABORTA a
    * acao quando a transferencia falha, em vez de seguir validando
    * propriedades que ninguem alimentou (CLAUDE.md - "FormParaBO deve ser
    * FUNCTION e o chamador deve abortar quando ela falhar").
    *
    * Os codigos vao PADR na largura da coluna do schema (SigCdGcr.codigos
    * char(10), SigCdCli.iclis char(10), SigCdPro.cpros char(14)); as datas
    * passam por ConverterParaData(), que normaliza DATE/DATETIME/CHAR - os
    * dois TextBox nascem com DATE() mas sao DIGITADOS pelo usuario, e
    * TTOD() sobre um DATE dispara erro 11 em runtime (regra CLAUDE.md #16).
    *
    * PROTECTED porque FormBase.FormParaBO() eh PROTECTED: declarar PUBLIC
    * aqui NAO alargaria o escopo (o PROTECTED da classe base prevalece -
    * regra CLAUDE.md #51) e o metodo so eh alcancado por THIS. de dentro
    * da propria classe.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION FormParaBO()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("SigOpHisBO n" + CHR(227) + "o foi inicializado.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- Alvo qualificado em TODA atribuicao: WITH aninhado sobre o BO
            *-- sequestraria o escopo dos THIS.txt_4c_* (regra CLAUDE.md #33).
            THIS.this_oBusinessObject.this_cGrupo    = PADR(ALLTRIM(THIS.txt_4c_Grupo.Value), 10)
            THIS.this_oBusinessObject.this_cDGrupo   = ALLTRIM(THIS.txt_4c_Dgrupo.Value)
            THIS.this_oBusinessObject.this_cConta    = PADR(ALLTRIM(THIS.txt_4c_Est.Value), 10)
            THIS.this_oBusinessObject.this_cDConta   = ALLTRIM(THIS.txt_4c_Dest.Value)
            THIS.this_oBusinessObject.this_cProduto  = PADR(ALLTRIM(THIS.txt_4c_Cod.Value), 14)
            THIS.this_oBusinessObject.this_cDProduto = ALLTRIM(THIS.txt_4c_Dcod.Value)
            THIS.this_oBusinessObject.this_dDataIni  = ConverterParaData(THIS.txt_4c_DataIni.Value)
            THIS.this_oBusinessObject.this_dDataFin  = ConverterParaData(THIS.txt_4c_DataFin.Value)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BOParaForm - contraparte simetrica de FormParaBO(): espelha os oito
    * campos do BO (this_oBusinessObject, ja com os defaults postos em
    * SigOpHisBO.Init() - SPACE(10)/""/DATE()) de volta para os TextBox.
    *
    * Este dialogo nao tem registro proprio para "carregar" (nao ha tabela
    * SigOpHis - regra CLAUDE.md "BO somente-leitura"), entao BOParaForm
    * nao eh chamado apos um SEEK/SELECT como nos forms CRUD: o papel dele
    * aqui eh restaurar a tela para o estado em BRANCO do BO, chamado uma
    * unica vez por ConfigurarPageFrame() ao final da montagem (fonte
    * unica dos defaults do dialogo, em vez de duplicar o literal
    * "" / DATE() tanto no AddObject de ConfigurarCamposFiltro() quanto no
    * SigOpHisBO.Init()).
    *
    * PROTECTED pelo mesmo motivo de FormParaBO: FormBase.BOParaForm() eh
    * PROTECTED e o PROTECTED da classe base prevalece (regra CLAUDE.md
    * #51) - o metodo so e alcancado por THIS. de dentro da propria
    * classe.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oErro

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            RETURN
        ENDIF

        TRY
            THIS.txt_4c_Grupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupo)
            THIS.txt_4c_Dgrupo.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cDGrupo)
            THIS.txt_4c_Est.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
            THIS.txt_4c_Dest.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDConta)
            THIS.txt_4c_Cod.Value      = ALLTRIM(THIS.this_oBusinessObject.this_cProduto)
            THIS.txt_4c_Dcod.Value     = ALLTRIM(THIS.this_oBusinessObject.this_cDProduto)
            THIS.txt_4c_DataIni.Value  = ConverterParaData(THIS.this_oBusinessObject.this_dDataIni)
            THIS.txt_4c_DataFin.Value  = ConverterParaData(THIS.this_oBusinessObject.this_dDataFin)

            *-- Reaplica a dependencia Codigo/Descricao (regra CLAUDE.md
            *-- #3/#34 nao se aplica aqui - chamada direta, nao BINDEVENT):
            *-- com os valores do BO em branco, os tres campos de
            *-- descricao voltam a ficar habilitados.
            THIS.AjustarCamposDependentes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FocarCampoRecusado - reproduz o "ThisForm.get_xxx.SetFocus" que cada
    * bloco "Consiste o Campo..." do consulta.Click legado executa antes de
    * Return(.F.). O campo vem de SigOpHisBO.this_cCampoFoco, preenchido por
    * ValidarFiltro() na mesma ordem do legado (Grupo -> Conta -> Produto ->
    * DataIni -> DataFin -> periodo invertido, que volta para DataIni).
    *
    * SetFocus() em controle desabilitado/invisivel estoura - daqui a guarda
    * por .Enabled/.Visible, ainda que os cinco campos de CODIGO nunca sejam
    * desabilitados (AjustarCamposDependentes so desabilita os campos de
    * DESCRICAO).
    *
    * PUBLIC: chamado pelos handlers de botao da propria classe e alcancavel
    * pelo harness de teste - metodo chamado de fora nao pode ser PROTECTED
    * (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE FocarCampoRecusado()
        LOCAL loc_cCampo, loc_oControle

        loc_cCampo = ""
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            loc_cCampo = ALLTRIM(THIS.this_oBusinessObject.this_cCampoFoco)
        ENDIF

        loc_oControle = .NULL.

        DO CASE
            CASE loc_cCampo == "Grupo"
                loc_oControle = THIS.txt_4c_Grupo
            CASE loc_cCampo == "Conta"
                loc_oControle = THIS.txt_4c_Est
            CASE loc_cCampo == "Produto"
                loc_oControle = THIS.txt_4c_Cod
            CASE loc_cCampo == "DataIni"
                loc_oControle = THIS.txt_4c_DataIni
            CASE loc_cCampo == "DataFin"
                loc_oControle = THIS.txt_4c_DataFin
        ENDCASE

        IF VARTYPE(loc_oControle) = "O"
            IF loc_oControle.Enabled AND loc_oControle.Visible
                loc_oControle.SetFocus()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConsultaClick - Click de obj_4c_Sair.Buttons(1) ("\<Consulta"),
    * transcricao do SIGOPHIS.sair.consulta.Click legado (dump linhas
    * 601-660):
    *
    *     pcCdGrupo = ... (sete campos)
    *     If IsEmpty(pcCdGrupo)       -> 'Grupo Invalido !'   + SetFocus
    *     If IsEmpty(pcCdConta) Or !ChkRegister('SigCdCli','iclis',...)
    *                                 -> 'Conta Invalida !'   + SetFocus
    *     If IsEmpty(pcCdProduto) Or !ChkRegister('SigCdPro','cpros',...)
    *                                 -> 'Produto Invalido !' + SetFocus
    *     If IsEmpty(pdDataIni)       -> 'Data Inicial Invalida !'
    *     If IsEmpty(pdDataFin)       -> 'Data Final Invalida !'
    *     If pdDataIni > pdDataFin    -> 'Data Inicial maior que Data Final !'
    *     ThisForm.Enabled = .F.
    *     Do Form SigPrHpr With ThisForm
    *
    * A sequencia de consistencias INTEIRA vive em SigOpHisBO.ValidarFiltro()
    * (Fase 2), que a transcreve na MESMA ordem e com as MESMAS mensagens e
    * devolve this_cMensagemErro + this_cCampoFoco; aqui ficam so a exibicao
    * e o foco. As mensagens de validacao de campo usam MsgAviso (dialogo
    * amarelo) e nao MsgErro, conforme a norma do projeto ("Campo
    * obrigatorio"/"Valor invalido" DEVEM usar MsgAviso; MsgErro fica para
    * erro tecnico) - o TEXTO eh o do legado, letra por letra.
    *
    * Despacho: "Do Form ... With ThisForm" nao existe no sistema novo (DO
    * FORM no projeto nunca abre o dialogo filho) - o equivalente eh
    * CREATEOBJECT("FormSigPrHpr", THIS), cujo Init(par_oFormPai) guarda o
    * form pai em this_oFormPai e LE as PRIVATE pcCdGrupo/pcCdConta/
    * pcCdProduto/pcDsProduto/pdDataIni/pdDataFin do escopo do chamador -
    * exatamente como o legado, que as declara aqui. CREATEOBJECT com nome
    * LITERAL dentro de um Form dispensa GarantirClasse (o indice da carga
    * sob demanda ja traz o fecho de dependencias).
    *
    * Show() fica FORA do TRY: FormSigPrHpr eh MODAL (WindowType = 1) e o
    * Show() bloqueia, portanto todo o uso daquela tela correria dentro do
    * bloco e qualquer erro de runtime dela saltaria para este CATCH,
    * derrubando a referencia e FECHANDO a tela (regra CLAUDE.md #29).
    *
    * THIS.Enabled = .T. depois do Show() eh o funil de VOLTA: o
    * BtnSairClick do filho ja reabilita o pai (this_oFormPai.Enabled = .T.),
    * mas quem desabilita tem de reabilitar tambem no retorno, senao um
    * caminho de saida que nao passe por aquele botao deixaria este dialogo
    * permanentemente morto (regra CLAUDE.md #40).
    *
    * PUBLIC - exigido para BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConsultaClick()
        LOCAL loc_oFormHistorico, loc_oErro

        *-- Equivalente ao "Private pnOpcao,pcCdEstoque,..." do legado:
        *-- PRIVATE torna estas variaveis visiveis ao Init de FormSigPrHpr,
        *-- que as le pelo nome (TYPE("pcCdGrupo") etc.).
        PRIVATE pcCdGrupo, pcCdConta, pcDsConta, pcCdProduto, pcDsProduto
        PRIVATE pdDataIni, pdDataFin

        IF VARTYPE(THIS.this_oBusinessObject) != "O"
            MsgErro("SigOpHisBO n" + CHR(227) + "o foi inicializado.", "Consulta")
            RETURN
        ENDIF

        IF !THIS.FormParaBO()
            RETURN
        ENDIF

        IF !THIS.this_oBusinessObject.ValidarFiltro()
            MsgAviso(THIS.this_oBusinessObject.this_cMensagemErro, ;
                "Hist" + CHR(243) + "rico de Produtos")
            THIS.FocarCampoRecusado()
            RETURN
        ENDIF

        *-- Parametros lidos pelo Init de FormSigPrHpr (PRIVATE do chamador).
        pcCdGrupo   = ALLTRIM(THIS.this_oBusinessObject.this_cGrupo)
        pcCdConta   = ALLTRIM(THIS.this_oBusinessObject.this_cConta)
        pcDsConta   = ALLTRIM(THIS.this_oBusinessObject.this_cDConta)
        pcCdProduto = ALLTRIM(THIS.this_oBusinessObject.this_cProduto)
        pcDsProduto = ALLTRIM(THIS.this_oBusinessObject.this_cDProduto)
        pdDataIni   = THIS.this_oBusinessObject.this_dDataIni
        pdDataFin   = THIS.this_oBusinessObject.this_dDataFin

        *-- Legado: ThisForm.Enabled = .F. antes de abrir a tela de historico.
        THIS.Enabled = .F.

        loc_oFormHistorico = .NULL.
        TRY
            loc_oFormHistorico = CREATEOBJECT("FormSigPrHpr", THIS)
        CATCH TO loc_oErro
            MsgErro("Erro ao abrir Hist" + CHR(243) + "rico de Produtos:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Consulta")
            loc_oFormHistorico = .NULL.
        ENDTRY

        IF VARTYPE(loc_oFormHistorico) = "O"
            loc_oFormHistorico.Show()
        ENDIF

        *-- Funil de volta (regra #40): reabilita este dialogo por qualquer
        *-- caminho de retorno, inclusive quando o CREATEOBJECT falhou.
        THIS.Enabled = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Click de obj_4c_Sair.Buttons(2) ("Encerrar",
    * Cancel = .T.), transcricao do SIGOPHIS.sair.sair.Click legado (dump
    * linhas 663-666):
    *
    *     ThisForm.Release
    *
    * Nao ha poDataMgr a liberar (a conexao SQL do sistema novo eh
    * gnConnHandle, global) nem cursor proprio deste dialogo - os cursores
    * de lookup sao fechados pelos proprios helpers (ObterValorExato/
    * AbrirPicker). Release() encadeia para Destroy(), que chama DODEFAULT()
    * e deixa FormBase liberar o BO e restaurar o menu principal.
    *
    * PUBLIC - exigido para BINDEVENT (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * LOOKUPS DOS CAMPOS DE FILTRO
    *
    * No legado cada campo resolve o par codigo/descricao dentro do proprio
    * Valid, por uma funcao global do Framework Fortyus:
    *
    *   Get_grupo / Get_Dgrupo -> fAcessoContab(Usuar, 'C'|'D', This.Value,
    *                             ThisForm.get_grupo, ThisForm.get_DGrupo)
    *                             -> picker sobre SigCdGcr (Codigos/Descrs)
    *   Get_est   / Get_dest   -> fAcessoContas(Usuar, Grupo, 'C'|'D',
    *                             This.Value, ThisForm.get_Est,
    *                             ThisForm.get_DEst)
    *                             -> picker sobre SigCdCli (IClis/RClis)
    *   Get_cod   / Get_dcod   -> CreateObject('fwBuscaExt', ..., 'SigCdPro',
    *                             'CrProds', 'cpros'|'dpros', This.Value, ...)
    *                             -> picker sobre SigCdPro (cpros/dpros)
    *
    * Substituicao canonica do projeto (identica a Formsigmvcot/FormCRC):
    * SELECT TOP 1 pelo valor EXATO digitado; achando, preenche o campo par;
    * nao achando, abre FormBuscaAuxiliar com o valor como filtro. As duas
    * funcoes globais continuam vivas em Framework\sigacess.PRG, mas NAO sao
    * usadas como handler de lookup: fAcessoContas auto-preenche o PRIMEIRO
    * registro que apenas CONTEM o valor digitado (LIKE percent valor percent),
    * de modo que digitar "11" carregaria a primeira conta cujo codigo contem
    * "11" sem o usuario ter escolhido nada (memoria "facessocontas_lookup_ux").
    * Com isso, o recorte por grupo/usuario que aquelas funcoes aplicam sobre
    * SigSyAcc/SigSyAgc/SigCdAcJ fica fora destes handlers - a conferencia do
    * dialogo continua sendo a de SigOpHisBO.ValidarFiltro(), que transcreve
    * os ChkRegister do consulta.Click legado.
    *
    * Universo vazio NAO eh erro (regra CLAUDE.md #50): havendo picker, o
    * handler NAO exibe MsgAviso e NAO apaga o codigo digitado - o proprio
    * dialogo eh o feedback e o valor digitado vira o filtro da busca.
    *
    * Tabelas/colunas conferidas em docs/schema.sql (UTF-16, lido com
    * Get-Content -Raw - regra #14): SigCdGcr.codigos char(10)/descrs
    * char(40); SigCdCli.iclis char(10)/rclis char(50); SigCdPro.cpros
    * char(14)/dpros char(65) - as mesmas larguras dos MaxLength declarados
    * em ConfigurarCamposFiltro. Sem filtro extra no WHERE: a chamada do
    * legado omite pInd, entao fAcessoContas NAO restringe SigCdCli por
    * Grupos - inventar esse recorte seria filtro que o legado nao tem.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * ObterValorExato - resolve o campo par de um lookup pelo valor EXATO.
    * Devolve "" quando nao ha conexao, quando o valor esta vazio ou quando
    * nada casa - e eh esse "" que faz o handler abrir o picker.
    *
    * EVALUATE eh LEITURA do cursor (regra CLAUDE.md #15) e o alias vai entre
    * parenteses em USE IN (name expression). TratarNulo(x, "") - o 2o
    * argumento eh o valor PADRAO devolvido quando a coluna vem NULL, nao um
    * codigo de tipo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterValorExato(par_cTabela, par_cCampoChave, ;
            par_cCampoRetorno, par_cValor)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno, loc_cCursor, loc_oErro

        loc_cRetorno = ""
        loc_cCursor  = "cursor_4c_LkpExata"

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0 OR ;
                EMPTY(ALLTRIM(par_cValor))
            RETURN ""
        ENDIF

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_cSQL = "SELECT TOP 1 " + par_cCampoRetorno + " AS cValor" + ;
                       " FROM " + par_cTabela + ;
                       " WHERE " + par_cCampoChave + " = " + ;
                       EscaparSQL(ALLTRIM(par_cValor))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            IF loc_nResultado > 0 AND USED(loc_cCursor) AND !EOF(loc_cCursor)
                loc_cRetorno = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + ".cValor"), ""))
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ObterValorExato")
        ENDTRY

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        RETURN loc_cRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirPicker - corpo unico dos seis AbrirLookup*. Reproduz o contrato de
    * FormBuscaAuxiliar (regra CLAUDE.md #36/#37):
    *   - 1o argumento eh o HANDLE da conexao (gnConnHandle), nunca a tabela;
    *   - Show() SO quando this_lAchouRegistro eh .F. (com match exato unico
    *     o Init ja resolveu o valor, e abrir o dialogo por cima da tela
    *     preenchida obrigaria o usuario a dispensa-lo);
    *   - atribuicao SO sob a guarda this_lSelecionou (fora dela o campo
    *     seria ZERADO quando nada fosse escolhido).
    *
    * par_lLimparSeCancelar reproduz o ramo de cancelamento que o Valid de
    * Get_cod/Get_dcod tem no dump (LastKey() = 27 / ESC limpa os dois
    * campos); Grupo e Conta nao tem esse ramo no legado e nao limpam.
    *
    * Devolve .T. quando o par codigo/descricao foi resolvido.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirPicker(par_cTabela, par_cCampoChave, ;
            par_cCaptionChave, par_cCampoPar, par_cCaptionPar, par_cTitulo, ;
            par_cValor, par_oTxtChave, par_oTxtPar, par_lLimparSeCancelar)
        LOCAL loc_oBusca, loc_cCursor, loc_lSelecionou, loc_oErro
        LOCAL loc_cValChave, loc_cValPar

        loc_cCursor     = "cursor_4c_BuscaLkp"
        loc_lSelecionou = .F.
        loc_cValChave   = ""
        loc_cValPar     = ""

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                par_cTabela, loc_cCursor, par_cCampoChave, ;
                ALLTRIM(par_cValor), par_cTitulo)

            IF VARTYPE(loc_oBusca) = "O"
                IF !loc_oBusca.this_lAchouRegistro
                    loc_oBusca.mAddColuna(par_cCampoChave, "", par_cCaptionChave)
                    loc_oBusca.mAddColuna(par_cCampoPar,   "", par_cCaptionPar)
                    loc_oBusca.Show()
                ENDIF

                IF loc_oBusca.this_lSelecionou AND USED(loc_cCursor)
                    SELECT (loc_cCursor)
                    loc_cValChave   = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + "." + par_cCampoChave), ""))
                    loc_cValPar     = ALLTRIM(TratarNulo(EVALUATE(loc_cCursor + "." + par_cCampoPar), ""))
                    loc_lSelecionou = .T.
                ENDIF

                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em AbrirPicker")
        ENDTRY

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        IF loc_lSelecionou
            IF VARTYPE(par_oTxtChave) = "O"
                par_oTxtChave.Value = loc_cValChave
                par_oTxtChave.Refresh()
            ENDIF
            IF VARTYPE(par_oTxtPar) = "O"
                par_oTxtPar.Value = loc_cValPar
                par_oTxtPar.Refresh()
            ENDIF
        ELSE
            IF par_lLimparSeCancelar
                IF VARTYPE(par_oTxtChave) = "O"
                    par_oTxtChave.Value = ""
                    par_oTxtChave.Refresh()
                ENDIF
                IF VARTYPE(par_oTxtPar) = "O"
                    par_oTxtPar.Value = ""
                    par_oTxtPar.Refresh()
                ENDIF
            ENDIF
        ENDIF

        THIS.AjustarCamposDependentes()

        RETURN loc_lSelecionou
    ENDFUNC

    *--------------------------------------------------------------------------
    * AjustarCamposDependentes - reproduz os tres PROCEDURE When do legado:
    *   Get_Dgrupo.When -> Return(IsEmpty(ThisForm.Get_Grupo.Value))
    *   Get_dest.When   -> Return(IsEmpty(ThisForm.get_Est.Value))
    *   Get_dcod.When   -> Return(IsEmpty(ThisForm.get_cod.Value))
    * Ou seja: o campo de DESCRICAO so aceita entrada enquanto o campo de
    * CODIGO estiver vazio. BINDEVENT em "When" de TextBox nao eh confiavel
    * (o retorno do delegate eh descartado), entao a dependencia eh aplicada
    * por .Enabled, como nos irmaos ja migrados (FormCRC).
    *
    * PUBLIC: alcancado de fora da classe pelos funis de lookup e por
    * ConfigurarCamposFiltro (regra CLAUDE.md #3 - metodo chamado de fora nao
    * pode ser PROTECTED).
    *--------------------------------------------------------------------------
    PROCEDURE AjustarCamposDependentes()
        THIS.txt_4c_Dgrupo.Enabled = EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
        THIS.txt_4c_Dest.Enabled   = EMPTY(ALLTRIM(THIS.txt_4c_Est.Value))
        THIS.txt_4c_Dcod.Enabled   = EMPTY(ALLTRIM(THIS.txt_4c_Cod.Value))
    ENDPROC

    *==========================================================================
    * GRUPO CONTABIL - SigCdGcr (codigos / descrs)
    * Legado: Get_grupo.Valid / Get_Dgrupo.Valid -> fAcessoContab
    *==========================================================================

    *-- F4 abre o picker pelo CODIGO. Save/restore da flag (regra #47): este
    *-- irmao tambem eh alcancado de dentro do funil de LostFocus.
    PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoCodigo()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    *-- Funil equivalente ao Valid de Get_grupo. O corpo vive no Exec para a
    *-- flag ser liberada mesmo nos RETURN antecipados dele (regra #47).
    PROCEDURE GrupoLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.GrupoLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE GrupoLostFocusExec()
        LOCAL loc_cCodigo, loc_cDescricao

        loc_cCodigo = ALLTRIM(THIS.txt_4c_Grupo.Value)

        IF EMPTY(loc_cCodigo)
            *-- Legado: ramo Else -> get_DGrupo.Value = vazio
            THIS.txt_4c_Dgrupo.Value = ""
            THIS.txt_4c_Dgrupo.Refresh()
            THIS.AjustarCamposDependentes()
            RETURN
        ENDIF

        loc_cDescricao = THIS.ObterValorExato("SigCdGcr", "codigos", "descrs", loc_cCodigo)

        IF EMPTY(loc_cDescricao)
            *-- Nada casou exato: o picker abre com o digitado como filtro.
            *-- Sem MsgAviso e sem apagar o codigo (regra #50).
            THIS.AbrirLookupGrupoCodigo()
        ELSE
            THIS.txt_4c_Dgrupo.Value = loc_cDescricao
            THIS.txt_4c_Dgrupo.Refresh()
            THIS.AjustarCamposDependentes()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGrupoCodigo()
        IF !THIS.txt_4c_Grupo.Enabled
            RETURN
        ENDIF

        THIS.AbrirPicker("SigCdGcr", "codigos", "C" + CHR(243) + "digo", ;
            "descrs", "Descri" + CHR(231) + CHR(227) + "o", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            THIS.txt_4c_Grupo.Value, THIS.txt_4c_Grupo, THIS.txt_4c_Dgrupo, .F.)
    ENDPROC

    *-- F4 abre o picker pela DESCRICAO.
    PROCEDURE DgrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupGrupoDescricao()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    PROCEDURE DgrupoLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.DgrupoLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE DgrupoLostFocusExec()
        LOCAL loc_cDescricao, loc_cCodigo

        loc_cDescricao = ALLTRIM(THIS.txt_4c_Dgrupo.Value)

        IF EMPTY(loc_cDescricao)
            *-- Legado: ramo Else -> get_Grupo.Value = vazio
            THIS.txt_4c_Grupo.Value = ""
            THIS.txt_4c_Grupo.Refresh()
            THIS.AjustarCamposDependentes()
            RETURN
        ENDIF

        loc_cCodigo = THIS.ObterValorExato("SigCdGcr", "descrs", "codigos", loc_cDescricao)

        IF EMPTY(loc_cCodigo)
            THIS.AbrirLookupGrupoDescricao()
        ELSE
            THIS.txt_4c_Grupo.Value = loc_cCodigo
            THIS.txt_4c_Grupo.Refresh()
            THIS.AjustarCamposDependentes()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupGrupoDescricao()
        IF !THIS.txt_4c_Dgrupo.Enabled
            RETURN
        ENDIF

        THIS.AbrirPicker("SigCdGcr", "descrs", "Descri" + CHR(231) + CHR(227) + "o", ;
            "codigos", "C" + CHR(243) + "digo", ;
            "Sele" + CHR(231) + CHR(227) + "o de Grupo", ;
            THIS.txt_4c_Dgrupo.Value, THIS.txt_4c_Dgrupo, THIS.txt_4c_Grupo, .F.)
    ENDPROC

    *==========================================================================
    * CONTA - SigCdCli (iclis / rclis)
    * Legado: Get_est.Valid / Get_dest.Valid -> fAcessoContas
    *==========================================================================

    PROCEDURE EstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaCodigo()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    PROCEDURE EstLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.EstLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE EstLostFocusExec()
        LOCAL loc_cCodigo, loc_cDescricao

        loc_cCodigo = ALLTRIM(THIS.txt_4c_Est.Value)

        IF EMPTY(loc_cCodigo)
            *-- Legado: ramo Else -> get_dest.Value = vazio
            THIS.txt_4c_Dest.Value = ""
            THIS.txt_4c_Dest.Refresh()
            THIS.AjustarCamposDependentes()
            RETURN
        ENDIF

        loc_cDescricao = THIS.ObterValorExato("SigCdCli", "iclis", "rclis", loc_cCodigo)

        IF EMPTY(loc_cDescricao)
            THIS.AbrirLookupContaCodigo()
        ELSE
            THIS.txt_4c_Dest.Value = loc_cDescricao
            THIS.txt_4c_Dest.Refresh()
            THIS.AjustarCamposDependentes()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupContaCodigo()
        IF !THIS.txt_4c_Est.Enabled
            RETURN
        ENDIF

        THIS.AbrirPicker("SigCdCli", "iclis", "C" + CHR(243) + "digo", ;
            "rclis", "Descri" + CHR(231) + CHR(227) + "o", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            THIS.txt_4c_Est.Value, THIS.txt_4c_Est, THIS.txt_4c_Dest, .F.)
    ENDPROC

    PROCEDURE DestKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupContaDescricao()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    PROCEDURE DestLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.DestLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE DestLostFocusExec()
        LOCAL loc_cDescricao, loc_cCodigo

        loc_cDescricao = ALLTRIM(THIS.txt_4c_Dest.Value)

        IF EMPTY(loc_cDescricao)
            *-- Legado: ramo Else -> get_est.Value = vazio
            THIS.txt_4c_Est.Value = ""
            THIS.txt_4c_Est.Refresh()
            THIS.AjustarCamposDependentes()
            RETURN
        ENDIF

        loc_cCodigo = THIS.ObterValorExato("SigCdCli", "rclis", "iclis", loc_cDescricao)

        IF EMPTY(loc_cCodigo)
            THIS.AbrirLookupContaDescricao()
        ELSE
            THIS.txt_4c_Est.Value = loc_cCodigo
            THIS.txt_4c_Est.Refresh()
            THIS.AjustarCamposDependentes()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupContaDescricao()
        IF !THIS.txt_4c_Dest.Enabled
            RETURN
        ENDIF

        THIS.AbrirPicker("SigCdCli", "rclis", "Descri" + CHR(231) + CHR(227) + "o", ;
            "iclis", "C" + CHR(243) + "digo", ;
            "Sele" + CHR(231) + CHR(227) + "o de Conta", ;
            THIS.txt_4c_Dest.Value, THIS.txt_4c_Dest, THIS.txt_4c_Est, .F.)
    ENDPROC

    *==========================================================================
    * PRODUTO - SigCdPro (cpros / dpros)
    * Legado: Get_cod.Valid / Get_dcod.Valid -> fwBuscaExt sobre SigCdPro
    *
    * Unico par cujo Valid legado tem o ramo de CANCELAMENTO explicito: no
    * dump, saindo do picker com ESC (LastKey() = 27) os DOIS campos sao
    * limpos. Por isso par_lLimparSeCancelar entra .T. aqui e .F. nos pares
    * de Grupo e Conta, que nao tem esse ramo.
    *==========================================================================

    PROCEDURE CodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProdutoCodigo()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    PROCEDURE CodLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.CodLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE CodLostFocusExec()
        LOCAL loc_cCodigo, loc_cDescricao

        loc_cCodigo = ALLTRIM(THIS.txt_4c_Cod.Value)

        IF EMPTY(loc_cCodigo)
            *-- Legado: If IsEmpty(This.Value) -> get_dcod.Value = vazio
            THIS.txt_4c_Dcod.Value = ""
            THIS.txt_4c_Dcod.Refresh()
            THIS.AjustarCamposDependentes()
            RETURN
        ENDIF

        loc_cDescricao = THIS.ObterValorExato("SigCdPro", "cpros", "dpros", loc_cCodigo)

        IF EMPTY(loc_cDescricao)
            THIS.AbrirLookupProdutoCodigo()
        ELSE
            THIS.txt_4c_Dcod.Value = loc_cDescricao
            THIS.txt_4c_Dcod.Refresh()
            THIS.AjustarCamposDependentes()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupProdutoCodigo()
        IF !THIS.txt_4c_Cod.Enabled
            RETURN
        ENDIF

        THIS.AbrirPicker("SigCdPro", "cpros", "C" + CHR(243) + "digo", ;
            "dpros", "Descri" + CHR(231) + CHR(227) + "o", ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
            THIS.txt_4c_Cod.Value, THIS.txt_4c_Cod, THIS.txt_4c_Dcod, .T.)
    ENDPROC

    PROCEDURE DcodKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        LOCAL loc_lEmLookupAnt
        loc_lEmLookupAnt    = THIS.this_lEmLookup
        THIS.this_lEmLookup = .T.
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProdutoDescricao()
        ENDIF
        THIS.this_lEmLookup = loc_lEmLookupAnt
    ENDPROC

    PROCEDURE DcodLostFocus()
        IF THIS.this_lEmLookup
            RETURN
        ENDIF
        THIS.this_lEmLookup = .T.
        THIS.DcodLostFocusExec()
        THIS.this_lEmLookup = .F.
    ENDPROC

    PROCEDURE DcodLostFocusExec()
        LOCAL loc_cDescricao, loc_cCodigo

        loc_cDescricao = ALLTRIM(THIS.txt_4c_Dcod.Value)

        IF EMPTY(loc_cDescricao)
            *-- Legado: If IsEmpty(This.Value) -> get_cod.Value = vazio
            THIS.txt_4c_Cod.Value = ""
            THIS.txt_4c_Cod.Refresh()
            THIS.AjustarCamposDependentes()
            RETURN
        ENDIF

        loc_cCodigo = THIS.ObterValorExato("SigCdPro", "dpros", "cpros", loc_cDescricao)

        IF EMPTY(loc_cCodigo)
            THIS.AbrirLookupProdutoDescricao()
        ELSE
            THIS.txt_4c_Cod.Value = loc_cCodigo
            THIS.txt_4c_Cod.Refresh()
            THIS.AjustarCamposDependentes()
        ENDIF
    ENDPROC

    PROCEDURE AbrirLookupProdutoDescricao()
        IF !THIS.txt_4c_Dcod.Enabled
            RETURN
        ENDIF

        THIS.AbrirPicker("SigCdPro", "dpros", "Descri" + CHR(231) + CHR(227) + "o", ;
            "cpros", "C" + CHR(243) + "digo", ;
            "Sele" + CHR(231) + CHR(227) + "o de Produto", ;
            THIS.txt_4c_Dcod.Value, THIS.txt_4c_Dcod, THIS.txt_4c_Cod, .T.)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original (dump legado): cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 800 do dump (que extrapola o Width=650
    * do proprio form).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oCnt, loc_oErro

        TRY
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
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 40
                .Left      = 10
                .Top       = 25
                .Width     = 619
                .ForeColor = RGB(0, 0, 0)
                .Visible   = .T.
            ENDWITH

            loc_oCnt.AddObject("lbl_4c_LblTitulo", "Label")
            WITH loc_oCnt.lbl_4c_LblTitulo
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .WordWrap  = .T.
                .Alignment = 0
                .BackStyle = 0
                .AutoSize  = .F.
                .Caption   = THIS.Caption
                .Height    = 46
                .Left      = 10
                .Top       = 24
                .Width     = 619
                .ForeColor = RGB(255, 255, 255)
                .Visible   = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (containers/PageFrame) para
    * garantir que tudo fique visivel apos a montagem.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oObjeto

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oObjeto = par_oContainer.Controls(loc_nI)

            IF VARTYPE(loc_oObjeto) = "O"
                IF PEMSTATUS(loc_oObjeto, "Visible", 5)
                    loc_oObjeto.Visible = .T.
                ENDIF

                IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
                    THIS.TornarControlesVisiveis(loc_oObjeto)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
