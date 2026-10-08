*==============================================================================
* FormSigPrIbb.prg - Impressao de Boleto Bancario
*==============================================================================
* Herda de: FormBase
* BO: SigPrIbbBO
* Legado: SIGPRIBB.SCX (tasks/task622/SigPrIbb_form_codigo_fonte.txt)
* Tipo: OPERACIONAL (form PLANO sem PageFrame - todos os objetos do dump sao
*       filhos diretos de SIGPRIBB ou de cntSombra, sem Pagina.Lista/Dados)
*
* Tela de impressao aberta com a chave de negocio do documento de
* movimentacao ja resolvida pelo chamador - equivalente ao
* "Parameters pEdn, pFrm" do Init legado (pEdn = EmpDopNums do documento;
* pFrm nunca eh lido em lugar nenhum do dump - mantido aqui so para paridade
* de assinatura). O usuario ve a grade de condicoes de pagamento
* boleto-habilitadas do documento (crGrade/SigMvPar), pode editar o local de
* pagamento e o texto de responsabilidade do cedente da parcela selecionada,
* e imprime o boleto via SigPrIbbBO.ImprimirBoleto().
*
* DataSession = 2 (privada) - diferente de FormSigPrGst/FormSigPrHpr, que
* dependem de cursores jah abertos por um form pai em sessao compartilhada:
* aqui o UNICO dado de entrada eh a chave EmpDopNums recebida por parametro,
* e todos os cursores (crGrade/crDados/TmpImprime no legado) sao criados
* pelo proprio SigPrIbbBO a partir dela - ver CLAUDE.md regra #9.4
* (FormBase.Init() ja compensa SET DATE/CENTURY para DataSession=2).
*
* Montagem (migracao multi-fase):
*   Fase 3 (feita)  - DEFINE CLASS, Init/Destroy/InicializarForm, cabecalho
*                     cnt_4c_Sombra, TornarControlesVisiveis.
*   Fase 4          - grd_4c_Dados (Column1..4 ReadOnly, bind a
*                     cursor_4c_Dados via SigPrIbbBO.CarregarParcelas),
*                     txt_4c_Emps/txt_4c_Dopes/txt_4c_Numes (Enabled=.F.,
*                     espelham EmpDopNums partido), obj_4c_GetLocals/
*                     obj_4c_GetTxtCds (EditBox editaveis da parcela
*                     corrente), txt_4c_Total (Enabled=.F.), Label3/Label31,
*                     shp_4c_Shape1, cmd_4c_Ok/cmd_4c_BtnImprimir.
*   Fase 5 (feita)  - ConfigurarOrdemTabulacao(): TabIndex dos 9 controles
*                     focalizaveis, transcrito do SCX (o migrador havia
*                     descartado e a ordem saia da ordem de criacao dos
*                     AddObject - ver o metodo para a tabela SCX x criacao).
*   Fase 6 (feita)  - campos restantes = os DOIS unicos digitaveis da tela
*                     (obj_4c_GetLocals/obj_4c_GetTxtCds; todo o resto eh
*                     Enabled=.F. ou ReadOnly=.T. no dump): .MaxLength=100 em
*                     GetLocals (SigCnFBl.clocals CHAR(100) NOT NULL - regra
*                     #19) e os handlers ValidarLocalPagamento/
*                     ValidarTextoCedente ligados por BINDEVENT em LostFocus,
*                     que ajustam o valor a largura da coluna destino e
*                     propagam a edicao para as propriedades *Atual do BO
*                     (SincronizarCampoParcela/SincronizarBOComTela). LOOKUPS:
*                     NAO EXISTEM neste legado - o dump nao tem fwBuscaExt/
*                     fwBuscaSel/fwBuscaInt/mAddColuna/sigacess/Acesso*; os
*                     tres fwget (getEmps/getDopes/getNumes) sao Enabled=.F. e
*                     recebem partes de EmpDopNums vindas do chamador, sem
*                     nenhuma tabela auxiliar a consultar. Inventar um lookup
*                     aqui violaria o PILAR 1.
*                     Alem disso: GridDadosAfterRowColChange (equivalente ao
*                     grdItens.AfterRowColChange do legado: Select crGrade +
*                     Refresh em cascata - aqui alimentado por
*                     SigPrIbbBO.CarregarDoCursor(), que o legado dispensa
*                     porque crGrade/getLocals/getTxtCds sao ligados DIRETO
*                     por ControlSource); BtnImprimirClick (equivalente a
*                     btnImprimir.Click: confirmacao + ThisForm.Imprimir) e
*                     THIS.Imprimir() (encadeia SigPrIbbBO.ImprimirBoleto());
*                     BtnEncerrarClick (equivalente a ok.Click: ThisForm.Release).
*   Fase 7 (feita)  - eventos principais; ver Fase 8 para o veredito sobre CRUD.
*   Fase 8 (esta)   - consolidacao final. DUAS mudancas, nenhuma cosmetica:
*                     (a) os dois handlers de botao passaram a se chamar pela
*                     ACAO que executam - BtnImprimirClick (era
*                     "CmdBtnImprimirClick", que carregava o NOME DO OBJETO
*                     legado "btnImprimir" dentro do nome do metodo, com o
*                     "Btn" no meio) e BtnEncerrarClick (era "CmdOkClick", do
*                     objeto "ok", cujo Caption no SCX eh justamente
*                     "Encerrar"). O verbo do handler tem de ser o verbo da
*                     acao, nao o nome do objeto do legado;
*                     (b) SigPrIbbBO.AtualizarConfiguracaoBoleto() ganhou o
*                     Commit que o legado faz logo depois do UPDATE em
*                     SigCnFBl - ver o comentario do metodo no BO: sem ele a
*                     edicao do local de pagamento / texto do cedente ficava
*                     presa numa transacao manual aberta e sumia em silencio.
*                     Revisao do escopo: o dump do legado (SigPrIbb_form_codigo_
*                     fonte.txt, SECAO 3/4 - "Total de metodos/eventos com
*                     codigo: 10") tem SOMENTE: Init/Load/Release/Detalhe/
*                     Imprimir/MontaGrades/SelecionaDados (metodos do form),
*                     ok.Click e btnImprimir.Click (os DOIS UNICOS botoes -
*                     CommandButton standalone, sem CommandGroup) e
*                     grdItens.AfterRowColChange. NAO EXISTE Incluir/Alterar/
*                     Visualizar/Excluir em lugar nenhum do dump - nem
*                     frmcadastro, nem Grupo_Op, nem pcEscolha: eh tela de
*                     IMPRESSAO (Encerrar + Imprimir), nao cadastro. Os 10
*                     metodos do legado ja tem equivalente 1-para-1 no
*                     migrado (BtnEncerrarClick/BtnImprimirClick/
*                     GridDadosAfterRowColChange/Imprimir() aqui;
*                     CarregarParcelas/CarregarDoCursor/CarregarDadosDocumento/
*                     AtualizarConfiguracaoBoleto/CarregarConfiguracaoLayout/
*                     MontarLayoutImpressao/ExecutarImpressaoMatricial/
*                     ImprimirBoleto no SigPrIbbBO). Adicionar
*                     BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/
*                     BtnExcluirClick aqui seria inventar funcionalidade
*                     inexistente no legado (viola o PILAR 1 e a proibicao de
*                     stubs do CLAUDE.md) - mesmo padrao de "legado sem CRUD"
*                     ja identificado em SigPrGst/SigPrHpr/SigPrGmi/SigPrGlx.
*
* Nomes de objeto conforme tasks/task622/mapeamento.json.
*==============================================================================

DEFINE CLASS FormSigPrIbb AS FormBase

    *--------------------------------------------------------------------------
    * Propriedades do form (SIGPRIBB.SCX: DataSession=2, BorderStyle=2,
    * Height=700, Width=1000, ShowTips=.T., AutoCenter=.T., ControlBox=.F.,
    * MaxButton=.F., MinButton=.F., Movable=.F., TitleBar=0, WindowType=1 -
    * dump de SigPrIbb_form_codigo_fonte.txt, linhas 159-176)
    *--------------------------------------------------------------------------
    DataSession  = 2
    Width        = 1000
    Height       = 700
    AutoCenter   = .T.
    ShowTips     = .T.
    TitleBar     = 0
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Movable      = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    Caption = "Impress" + CHR(227) + "o de Boleto Banc" + CHR(225) + "rio"

    *--------------------------------------------------------------------------
    * Chave de negocio recebida na abertura - equivalente a ThisForm.EmpDopNum
    * do legado (Substr(.EmpDopNum,1,3)/(4,20)/(24,6) alimentam
    * getEmps/getDopes/getNumes). Repassada a SigPrIbbBO.CarregarParcelas()
    * na Fase 4.
    *--------------------------------------------------------------------------
    this_cEmpDopNum = SPACE(29)

    *--------------------------------------------------------------------------
    * Form chamador - equivalente ao parametro "pFrm" do Init legado. Nenhum
    * metodo do dump le este parametro de volta (so pEdn eh usado); mantido
    * apenas para paridade de assinatura com o legado.
    *--------------------------------------------------------------------------
    this_oFormPai = .NULL.

    *--------------------------------------------------------------------------
    * Guarda de reentrancia dos handlers de LostFocus dos dois EditBox
    * editaveis (obj_4c_GetLocals/obj_4c_GetTxtCds). LostFocus dispara
    * SEMPRE que o foco sai do controle - inclusive por SetFocus disparado de
    * dentro do proprio handler - e o CLAUDE.md adverte explicitamente contra
    * a recursao infinita que isso causa. Ligada na entrada e liberada DEPOIS
    * do ENDTRY, para valer tambem quando o CATCH dispara.
    *--------------------------------------------------------------------------
    this_lSincronizandoParcela = .F.

    *--------------------------------------------------------------------------
    * Init - recebe a chave de negocio do documento e o form chamador
    * (equivalente a "Parameters pEdn, pFrm" do legado) e cria o Business
    * Object ANTES do DODEFAULT(), para que InicializarForm() (chamado por
    * FormBase.Init() via DODEFAULT) ja o encontre pronto.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LPARAMETERS par_cEmpDopNum, par_oFormPai
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrIbbBO")

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                IF PCOUNT() >= 1 AND VARTYPE(par_cEmpDopNum) = "C"
                    THIS.this_cEmpDopNum = PADR(par_cEmpDopNum, 29)
                ENDIF

                IF PCOUNT() >= 2 AND VARTYPE(par_oFormPai) = "O"
                    THIS.this_oFormPai = par_oFormPai
                ENDIF

                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Falha ao criar SigPrIbbBO.", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar Impress" + CHR(227) + "o de Boleto Banc" + ;
                CHR(225) + "rio: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - encadeia direto para FormBase.Destroy() (libera
    * this_oBusinessObject e restaura o menu principal). this_oFormPai NAO
    * eh liberado aqui - pertence a quem o criou.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - monta a tela via ConfigurarPageFrame(): fundo e
    * cabecalho nesta fase; grade/campos/botoes nas fases seguintes.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cPicture
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("SigPrIbbBO n" + CHR(227) + "o foi inicializado.", "Erro")
            ELSE
                loc_cPicture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
                IF FILE(loc_cPicture)
                    THIS.Picture = loc_cPicture
                ENDIF

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- Mesmo guard usado em FormSigPrGlx/FormSigPrGst/FormSigPrHpr:
                *-- em modo de teste de UI (sem gnConnHandle/sem conexao real)
                *-- pular a carga evita o dialogo "Favor reinicializar o
                *-- processo" num contexto sem SQL.
                IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
                     (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
                    THIS.CarregarDados()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigPrIbb.InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestrador de montagem visual. SIGPRIBB nao tem
    * PageFrame no legado (layout flat: cntSombra + Shape1 + grid + campos +
    * 2 botoes no proprio form) - o nome do metodo eh mantido apenas como
    * ponto de entrada arquitetural padrao (mesmo papel em
    * FormSigPrGst/FormSigPrGmi/FormSigPrGlp).
    *
    * Fase 3 (feita) - ConfigurarCabecalho() (cnt_4c_Sombra).
    * Fase 4          - grd_4c_Dados (4 colunas ReadOnly, bind a
    *                    cursor_4c_Dados via SigPrIbbBO.CarregarParcelas),
    *                    txt_4c_Emps/txt_4c_Dopes/txt_4c_Numes (Enabled=.F.,
    *                    partes de this_cEmpDopNum), obj_4c_GetLocals/
    *                    obj_4c_GetTxtCds (EditBox editaveis, parcela
    *                    corrente), txt_4c_Total (Enabled=.F.), Label3/
    *                    Label31, shp_4c_Shape1 decorativo, cmd_4c_Ok/
    *                    cmd_4c_BtnImprimir.
    * Fase 5 (feita)  - ConfigurarOrdemTabulacao() ao FIM da montagem:
    *                    TabIndex transcrito do SCX para os 9 controles que
    *                    param o Tab (os dois botoes estavam INVERTIDOS).
    * Fase 6 (feita)  - BINDEVENT de grd_4c_Dados.AfterRowColChange (delega a
    *                    SigPrIbbBO.CarregarDoCursor() e espelha o resultado
    *                    em obj_4c_GetLocals/obj_4c_GetTxtCds - equivalente a
    *                    grdItens.AfterRowColChange do legado) e dos dois
    *                    botoes (cmd_4c_BtnImprimir confirma e chama
    *                    SigPrIbbBO.ImprimirBoleto() via THIS.Imprimir();
    *                    cmd_4c_Ok chama THIS.Release()). CarregarDados()
    *                    dispara a primeira sincronizacao (equivalente ao
    *                    Column1.Setfocus do Init legado, que no legado ja
    *                    bastava por causa do ControlSource direto).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarShape()
        THIS.ConfigurarCamposChave()
        THIS.ConfigurarGrid()
        THIS.ConfigurarCamposParcela()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarOrdemTabulacao()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container cinza escuro com titulo do form.
    * Original (dump legado): cntSombra Top=0, Left=0, Width=1008, Height=80,
    * BackColor=RGB(100,100,100) - Width usa THIS.Width (canonico do
    * projeto) em vez do literal 1008 do dump (que extrapola o Width=1000
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
                .Top       = 18
                .Width     = 769
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
                .Top       = 17
                .Width     = 769
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
    * ConfigurarShape - Shape1 do dump legado, decorativo: BackStyle=0 +
    * BorderStyle=0 nao preenchem nem desenham borda (shape sem efeito
    * visivel). Mantido so por fidelidade de transcricao (PILAR 1) - Shape
    * NAO tem ForeColor (CLAUDE.md regra #33); a cor usada no dump eh
    * BorderColor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarShape()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("shp_4c_Shape1", "Shape")
            WITH THIS.shp_4c_Shape1
                .Top         = 9
                .Left        = 820
                .Height      = 110
                .Width       = 173
                .BackStyle   = 0
                .BorderStyle = 0
                .BorderColor = RGB(136, 189, 188)
                .Visible     = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarShape")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposChave - getEmps/getDopes/getNumes do legado: tres
    * TextBox Enabled=.F. que exibem (sem permitir edicao) as tres partes de
    * THIS.this_cEmpDopNum (Substr 1-3/4-23/24-29 - equivalente a
    * .getEmps.Value=Substr(.EmpDopNum,1,3) etc. do Init legado). Como
    * this_cEmpDopNum ja foi resolvido em Init() ANTES de DODEFAULT() chamar
    * InicializarForm(), o .Value pode ser atribuido aqui mesmo, na criacao.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposChave()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("txt_4c_Emps", "TextBox")
            WITH THIS.txt_4c_Emps
                .FontName          = "Tahoma"
                .FontSize          = 11
                .BorderStyle       = 1
                .Enabled           = .F.
                .Height            = 27
                .Left              = 7
                .SpecialEffect     = 1
                .Top               = 101
                .Width             = 44
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(245, 251, 136)
                .DisabledBackColor = RGB(245, 251, 136)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value             = SUBSTR(THIS.this_cEmpDopNum, 01, 03)
                .Visible           = .T.
                .MaxLength   = 3
            ENDWITH

            THIS.AddObject("txt_4c_Dopes", "TextBox")
            WITH THIS.txt_4c_Dopes
                .FontName          = "Tahoma"
                .FontSize          = 11
                .BorderStyle       = 1
                .Enabled           = .F.
                .Height            = 27
                .Left              = 57
                .SpecialEffect     = 1
                .Top               = 101
                .Width             = 288
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(245, 251, 136)
                .DisabledBackColor = RGB(245, 251, 136)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value             = SUBSTR(THIS.this_cEmpDopNum, 04, 20)
                .Visible           = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Numes", "TextBox")
            WITH THIS.txt_4c_Numes
                .FontName          = "Tahoma"
                .FontSize          = 11
                .BorderStyle       = 1
                .Enabled           = .F.
                .Height            = 27
                .Left              = 352
                .SpecialEffect     = 1
                .Top               = 101
                .Width             = 80
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(245, 251, 136)
                .DisabledBackColor = RGB(245, 251, 136)
                .DisabledForeColor = RGB(36, 84, 155)
                .Value             = SUBSTR(THIS.this_cEmpDopNum, 24, 06)
                .Visible           = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposChave")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - grd_4c_Dados (grdItens no legado): so a geometria e as
    * propriedades que NAO dependem do cursor. RecordSource/ControlSource de
    * cada Column ficam em CarregarDados, chamado DEPOIS que
    * SigPrIbbBO.CarregarParcelas() cria cursor_4c_Dados (CLAUDE.md regra
    * #41 - Column.ControlSource antes do cursor existir derruba o Init).
    * ColumnCount=4 e o ReadOnly geral (grdItens.ReadOnly=.T. no dump) sao
    * fixados aqui; o ReadOnly de cada Column (regra #18 - tem de vir DEPOIS
    * do Grid) e o restante de cada coluna ficam em CarregarDados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top               = 138
                .Left              = 7
                .Width             = 425
                .Height            = 520
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .HeaderHeight      = 22
                .RowHeight         = 16
                .ScrollBars        = 2
                .GridLineColor     = RGB(238, 238, 238)
                .ReadOnly          = .T.
                .ColumnCount       = 4
                .Visible           = .T.
            ENDWITH

            *-- grdItens.AfterRowColChange do legado (LParameters nColIndex) -
            *-- handler PUBLIC (CLAUDE.md regra #3), declarando o parametro
            *-- do evento.
            BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GridDadosAfterRowColChange")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCamposParcela - Label3/Label31 ("Local de Pagamento "/"Texto
    * de Responsabilidade do Cedente ") e os EditBox obj_4c_GetLocals/
    * obj_4c_GetTxtCds (getLocals/getTxtCds no legado - EDITAVEIS, ligados a
    * crGrade.CLocals/CTxtCds, a linha corrente da grade) + txt_4c_Total
    * (getTotal, Enabled=.F., soma das parcelas). ControlSource dos dois
    * EditBox e o .Value de txt_4c_Total ficam em CarregarDados - dependem do
    * cursor (mesma regra #41 de ConfigurarGrid).
    *
    * AutoSize=.T. do dump eh NO-OP em Label criado por AddObject (CLAUDE.md
    * regra #23) - .AutoSize=.F. aqui com Width/Height explicitos reproduz
    * os numeros que o Form Designer legado ja tinha calculado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCamposParcela()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("lbl_4c_Label3", "Label")
            WITH THIS.lbl_4c_Label3
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Local de Pagamento "
                .Left      = 444
                .Top       = 211
                .Width     = 119
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetLocals", "EditBox")
            WITH THIS.obj_4c_GetLocals
                .FontName      = "Tahoma"
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 228
                .Left          = 444
                .Width         = 548
                .Height        = 201
                *-- MaxLength vem da LARGURA DA COLUNA no schema, nunca do
                *-- Width em pixels (CLAUDE.md regra #19): o valor digitado
                *-- aqui vai para SigCnFBl.clocals CHAR(100) NOT NULL, no
                *-- UPDATE de SigPrIbbBO.AtualizarConfiguracaoBoleto(). Sem o
                *-- limite, o excedente seria cortado EM SILENCIO pelo
                *-- ControlSource (cursor_4c_Dados.CLocals eh C(100)) e o
                *-- usuario nao perceberia a perda.
                .MaxLength     = 100
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("lbl_4c_Label31", "Label")
            WITH THIS.lbl_4c_Label31
                .AutoSize  = .F.
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 8
                .BackStyle = 0
                .Alignment = 0
                .Caption   = "Texto de Responsabilidade do Cedente "
                .Left      = 444
                .Top       = 438
                .Width     = 224
                .Height    = 15
                .ForeColor = RGB(90, 90, 90)
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("obj_4c_GetTxtCds", "EditBox")
            WITH THIS.obj_4c_GetTxtCds
                .FontName      = "Tahoma"
                .BorderStyle   = 1
                .SpecialEffect = 1
                .Top           = 455
                .Left          = 444
                .Width         = 548
                .Height        = 201
                *-- SEM MaxLength de proposito: SigCnFBl.ctxtcds eh TEXT
                *-- (memo), sem limite de largura - e cursor_4c_Dados.CTxtCds
                *-- eh M, igual ao crGrade.CTxtCds m(4) do Load legado.
                *-- Limitar aqui cortaria texto que o banco aceita.
                .Visible       = .T.
            ENDWITH

            THIS.AddObject("txt_4c_Total", "TextBox")
            WITH THIS.txt_4c_Total
                .FontName          = "Tahoma"
                .BorderStyle       = 1
                .Enabled           = .F.
                .SpecialEffect     = 1
                .Top               = 657
                .Left              = 262
                .Width             = 150
                .Height            = 23
                .ForeColor         = RGB(0, 0, 0)
                .BackColor         = RGB(255, 255, 255)
                .DisabledBackColor = RGB(224, 253, 254)
                .Value             = 0
                .Visible           = .T.
            ENDWITH

            *-- Os DOIS unicos controles digitaveis da tela (todo o resto eh
            *-- Enabled=.F. ou ReadOnly=.T. no dump). No legado eles sao
            *-- ligados DIRETO por ControlSource a crGrade.CLocals/CTxtCds e
            *-- "Procedure imprimir" le crGrade.* na hora de gravar/imprimir -
            *-- ou seja, o que esta na tela ja ERA o que ia para o boleto.
            *-- Aqui SigPrIbbBO.AtualizarConfiguracaoBoleto()/
            *-- CarregarDadosImpressao() leem as propriedades *Atual do BO, e
            *-- por isso a edicao precisa de um ponto explicito de
            *-- sincronizacao - este handler.
            *--
            *-- LostFocus (nao "Valid"): BINDEVENT em "Valid" nao dispara de
            *-- forma confiavel em controle de entrada (CLAUDE.md regra #3 /
            *-- lookups). Eh seguro aqui porque o handler NAO executa SQL,
            *-- NAO remonta grade e NAO chama SetFocus - a recursao que o
            *-- CLAUDE.md adverte fica coberta pela guarda
            *-- this_lSincronizandoParcela.
            BINDEVENT(THIS.obj_4c_GetLocals, "LostFocus", THIS, "ValidarLocalPagamento")
            BINDEVENT(THIS.obj_4c_GetTxtCds, "LostFocus", THIS, "ValidarTextoCedente")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCamposParcela")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cmd_4c_Ok/cmd_4c_BtnImprimir (ok/btnImprimir no
    * legado). Standalone CommandButton com .Picture: mantido Themes=.F.
    * (igual ao legado) porque nenhum dos dois eh desabilitado em runtime -
    * a excecao de Themes=.T.+DisabledPicture (CLAUDE.md regra sobre icone-
    * only button) so se aplica quando .Enabled alterna para .F.
    *
    * Click (Release em cmd_4c_Ok; confirmacao + ImprimirBoleto em
    * cmd_4c_BtnImprimir) fica para as Fases 6-8, junto com o
    * AfterRowColChange de grd_4c_Dados - ver cabecalho do arquivo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro

        TRY
            THIS.AddObject("cmd_4c_Ok", "CommandButton")
            WITH THIS.cmd_4c_Ok
                .Top         = 3
                .Left        = 922
                .Height      = 75
                .Width       = 75
                .FontBold    = .T.
                .FontItalic  = .T.
                .FontName    = "Comic Sans MS"
                .FontSize    = 8
                .Picture     = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Cancel      = .T.
                .Caption     = "Encerrar"
                .ToolTipText = "[ESC] Sair"
                .ForeColor   = RGB(90, 90, 90)
                .BackColor   = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible     = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "BtnEncerrarClick")

            THIS.AddObject("cmd_4c_BtnImprimir", "CommandButton")
            WITH THIS.cmd_4c_BtnImprimir
                .Top        = 3
                .Left       = 846
                .Height     = 75
                .Width      = 75
                .FontBold   = .T.
                .FontItalic = .T.
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .Picture    = gc_4c_CaminhoIcones + "geral_impressora_normal_60.jpg"
                .Caption    = "\<Imprimir"
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes           = .T.
                .Visible    = .T.
            ENDWITH
            BINDEVENT(THIS.cmd_4c_BtnImprimir, "Click", THIS, "BtnImprimirClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarOrdemTabulacao - transcreve o TabIndex que o SCX legado
    * declara. Com AddObject o VFP9 numera o TabIndex pela ORDEM DE CRIACAO,
    * que nao tem relacao nenhuma com a ordem do legado: nao ha erro, nao ha
    * log e nao aparece em screenshot - so o Tab andando na ordem errada.
    *
    * TabIndex declarado no dump (SECAO 2 de
    * tasks/task622/SigPrIbb_form_codigo_fonte.txt) contra a ordem de criacao
    * que as Fases 3/4 produziram:
    *
    *   SCX  objeto legado  migrado               criacao
    *    2   getEmps        txt_4c_Emps               3
    *    3   getDopes       txt_4c_Dopes              4
    *    3   getTotal       txt_4c_Total             11   <- empate no SCX
    *    4   getNumes       txt_4c_Numes              5
    *    5   grdItens       grd_4c_Dados              6
    *    6   Label3         lbl_4c_Label3             7   (Label - ver abaixo)
    *    7   getLocals      obj_4c_GetLocals          8
    *    8   Label31        lbl_4c_Label31            9   (Label - ver abaixo)
    *    9   getTxtCds      obj_4c_GetTxtCds         10
    *   10   btnImprimir    cmd_4c_BtnImprimir       13   <- INVERTIDO
    *   11   ok             cmd_4c_Ok                12   <- INVERTIDO
    *
    * A divergencia que DOI eh a dos dois botoes: na ordem de criacao o Tab
    * sai de obj_4c_GetTxtCds (o texto de responsabilidade do cedente, que o
    * usuario acabou de editar) direto para cmd_4c_Ok, que eh .Cancel = .T. -
    * um Enter/Espaco ali FECHA a tela e descarta a edicao. No legado o Tab
    * cai em btnImprimir (10) ANTES de ok (11), que eh a acao pretendida.
    *
    * Numerar SO os focalizaveis: Label tem TabIndex mas NAO tem TabStop
    * (conferido em automation/propriedades_baseclasses.txt - a property nem
    * existe na classe), logo transcrever o TabIndex de lbl_4c_Label3/
    * lbl_4c_Label31 seria inerte e ainda embaralharia a sequencia dos
    * controles que de fato param o Tab. Eles, cnt_4c_Sombra e shp_4c_Shape1
    * ficam nas posicoes seguintes, sem efeito.
    *
    * Atribuicao em ordem ASCENDENTE e com posicoes COMPACTAS (1..9), nao com
    * os numeros literais do SCX: cada atribuicao poe o controle na posicao
    * pedida e EMPURRA os demais para tras, entao reusar os literais (que tem
    * buraco no 1 e empate no 3) deslocaria os seguintes a cada passo. A
    * sequencia resultante eh exatamente a do SCX lido em ordem crescente.
    *
    * O empate do SCX em TabIndex = 3 (getDopes e getTotal) eh impossivel de
    * reproduzir literalmente e eh inerte aqui: os quatro primeiros campos
    * sao Enabled = .F. no legado E no migrado, logo nenhum deles para o Tab
    * e a ordem entre eles nao chega ao usuario. Mantida a leitura literal do
    * dump (getTotal no empate, logo depois de getDopes).
    *
    * Chamado ao FIM de ConfigurarPageFrame, DEPOIS de todos os AddObject -
    * TabIndex eh gravavel em runtime, mas a numeracao automatica da criacao
    * sobrescreveria qualquer atribuicao feita antes do ultimo AddObject.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
        LOCAL loc_oErro

        TRY
            THIS.txt_4c_Emps.TabIndex        = 1   && SCX getEmps     TabIndex=2
            THIS.txt_4c_Dopes.TabIndex       = 2   && SCX getDopes    TabIndex=3
            THIS.txt_4c_Total.TabIndex       = 3   && SCX getTotal    TabIndex=3
            THIS.txt_4c_Numes.TabIndex       = 4   && SCX getNumes    TabIndex=4
            THIS.grd_4c_Dados.TabIndex       = 5   && SCX grdItens    TabIndex=5
            THIS.obj_4c_GetLocals.TabIndex   = 6   && SCX getLocals   TabIndex=7
            THIS.obj_4c_GetTxtCds.TabIndex   = 7   && SCX getTxtCds   TabIndex=9
            THIS.cmd_4c_BtnImprimir.TabIndex = 8   && SCX btnImprimir TabIndex=10
            THIS.cmd_4c_Ok.TabIndex          = 9   && SCX ok          TabIndex=11
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarOrdemTabulacao")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - equivalente ao bloco final de Init + SelecionaDados() do
    * legado: chama SigPrIbbBO.CarregarParcelas() (cria/popula
    * cursor_4c_Dados a partir de THIS.this_cEmpDopNum) e SO DEPOIS rebinda
    * grd_4c_Dados e os dois EditBox editaveis - CLAUDE.md regra #41
    * (Column.ControlSource antes do cursor existir derruba o Init).
    * Width/Header1.Caption/ReadOnly de cada coluna sao refeitos aqui (nao em
    * ConfigurarGrid) porque trocar RecordSource reseta os tres ("Problema 2"
    * / regra #43.1 do CLAUDE.md).
    *--------------------------------------------------------------------------
    *--------------------------------------------------------------------------
    * PUBLIC (nao PROTECTED): TesteAutomatico.prg chama THIS.oForm.
    * CarregarDados() direto de fora da classe, nao via BINDEVENT -
    * CLAUDE.md regra #3. PEMSTATUS() devolve .T. mesmo com o metodo
    * PROTECTED (so verifica existencia, nao escopo); a chamada real
    * estoura em runtime com "Property CARREGARDADOS is not found."
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_oGrid, loc_oErro

        TRY
            IF THIS.this_oBusinessObject.CarregarParcelas(THIS.this_cEmpDopNum)
                loc_oGrid = THIS.grd_4c_Dados

                loc_oGrid.RecordSource = ""
                loc_oGrid.ColumnCount  = 4
                loc_oGrid.RecordSource = "cursor_4c_Dados"

                loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
                loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Parcs"
                loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Vencs"
                loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.Valos"

                WITH loc_oGrid.Column1
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Width     = 120
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .BackColor = RGB(245, 251, 136)
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "Condi" + CHR(231) + CHR(227) + "o Pagto."
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ReadOnly    = .T.
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(245, 251, 136)
                ENDWITH

                WITH loc_oGrid.Column2
                    .FontBold  = .T.
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Alignment = 2
                    .Width     = 31
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .InputMask = "99"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "X"
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.FontBold    = .T.
                    .Text1.Alignment   = 2
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.ReadOnly    = .T.
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                WITH loc_oGrid.Column3
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Width     = 100
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "Vencimento"
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                WITH loc_oGrid.Column4
                    .FontName  = "Courier New"
                    .FontSize  = 8
                    .Width     = 150
                    .Movable   = .F.
                    .Resizable = .F.
                    .ReadOnly  = .T.
                    .InputMask = "9999999.99"
                    .Header1.FontName  = "Tahoma"
                    .Header1.FontSize  = 8
                    .Header1.Alignment = 2
                    .Header1.Caption   = "Valor"
                    .Header1.ForeColor = RGB(90, 90, 90)
                    .Header1.BackColor = RGB(255, 255, 223)
                    .Text1.BorderStyle = 0
                    .Text1.Margin      = 0
                    .Text1.FontName    = "Courier New"
                    .Text1.FontSize    = 8
                    .Text1.ForeColor   = RGB(0, 0, 0)
                    .Text1.BackColor   = RGB(255, 255, 255)
                ENDWITH

                THIS.obj_4c_GetLocals.ControlSource = "cursor_4c_Dados.CLocals"
                THIS.obj_4c_GetTxtCds.ControlSource  = "cursor_4c_Dados.CTxtCds"
                THIS.txt_4c_Total.Value = THIS.this_oBusinessObject.this_nTotalParcelas

                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_oGrid.Refresh()
                THIS.obj_4c_GetLocals.Refresh()
                THIS.obj_4c_GetTxtCds.Refresh()

                *-- Equivalente ao .grdItens.Column1.Setfocus do Init legado:
                *-- no legado o proprio SetFocus/ControlSource direto ja
                *-- bastava para crGrade.FPags/CLocals/CTxtCds aparecerem
                *-- corretos; aqui THIS.this_oBusinessObject.this_cFPagsAtual
                *-- (e demais *Atual, usados por ImprimirBoleto) so existem
                *-- apos CarregarDoCursor - sincronizar com a 1a linha agora
                *-- evita imprimir com a parcela errada quando o usuario
                *-- nunca navega na grade (ex.: so uma condicao de pagamento).
                IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
                    THIS.GridDadosAfterRowColChange(1)
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GridDadosAfterRowColChange - equivalente a grdItens.AfterRowColChange
    * do legado (LParameters nColIndex / Select crGrade / This.Refresh /
    * ThisForm.Refresh / ThisForm.getLocals.Refresh / ThisForm.getTxtCds.
    * Refresh). La, crGrade/getLocals/getTxtCds sao ligados DIRETO por
    * ControlSource, entao o Select+Refresh ja bastava para a tela refletir
    * a linha corrente. Aqui, alem do refresh visual, sincroniza as
    * propriedades *Atual do BO (this_cFPagsAtual/this_nParcsAtual/etc, via
    * CarregarDoCursor) - sao elas que SigPrIbbBO.ImprimirBoleto() usa, e sem
    * esta sincronizacao a impressao sairia sempre com os dados da PRIMEIRA
    * linha carregada, mesmo apos o usuario navegar/selecionar outra parcela.
    *
    * PUBLIC (nao PROTECTED) porque esta ligado via BINDEVENT - CLAUDE.md
    * regra #3 - e declara o parametro do evento (par_nColIndex), mesmo sem
    * uso direto aqui (o legado tambem recebe e nao usa nColIndex).
    *--------------------------------------------------------------------------
    PROCEDURE GridDadosAfterRowColChange(par_nColIndex)
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Dados")
                THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
            ENDIF

            THIS.grd_4c_Dados.Refresh()
            THIS.Refresh()
            THIS.obj_4c_GetLocals.Refresh()
            THIS.obj_4c_GetTxtCds.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em GridDadosAfterRowColChange")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - equivalente a SIGPRIBB.ok.Click do legado (ThisForm.
    * Release). PUBLIC por estar ligado via BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - equivalente a SIGPRIBB.btnImprimir.Click do
    * legado: so age com a grade posicionada num registro (Not Eof('crGrade'))
    * e apos confirmacao do usuario (MessageBox(...)==6, aqui MsgConfirma()
    * - CLAUDE.md regra #7, retorna LOGICAL, nunca comparar com numero).
    * PUBLIC por estar ligado via BINDEVENT (regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lConfirmou, loc_cMsg

        IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
            loc_cMsg = "Confirma a Impress" + CHR(227) + "o do Boleto Banc" + CHR(225) + ;
                "rio da Condi" + CHR(231) + CHR(227) + "o de Pagamento:" + CHR(13) + CHR(13) + ;
                ALLTRIM(cursor_4c_Dados.FPags) + " - Parcela: " + ALLTRIM(STR(cursor_4c_Dados.Parcs, 2))

            loc_lConfirmou = MsgConfirma(loc_cMsg, "Confirmar")

            IF loc_lConfirmou
                THIS.Imprimir()
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarLocalPagamento - handler de LostFocus de obj_4c_GetLocals
    * (getLocals no legado, ControlSource = crGrade.CLocals). O campo alimenta
    * SigCnFBl.clocals CHAR(100) NOT NULL (UPDATE em
    * SigPrIbbBO.AtualizarConfiguracaoBoleto) e tambem eh impresso como
    * "Local de Pagamento" do boleto (crDados.CLocals em Procedure imprimir).
    * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarLocalPagamento()
        THIS.SincronizarCampoParcela(THIS.obj_4c_GetLocals, 100)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarTextoCedente - handler de LostFocus de obj_4c_GetTxtCds
    * (getTxtCds no legado, ControlSource = crGrade.CTxtCds). Alimenta
    * SigCnFBl.ctxtcds (TEXT, sem limite de largura - por isso largura 0) e eh
    * impresso como "Texto de Cobranca" (crDados.Texto).
    * PUBLIC - exigido para BINDEVENT (CLAUDE.md regra #3).
    *--------------------------------------------------------------------------
    PROCEDURE ValidarTextoCedente()
        THIS.SincronizarCampoParcela(THIS.obj_4c_GetTxtCds, 0)
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarCampoParcela - corpo comum aos dois handlers acima.
    *
    * par_nLargura = largura da coluna DESTINO no schema (0 = sem limite).
    * O corte eh defensivo: .MaxLength ja impede a digitacao alem do limite,
    * mas valor colado/atribuido por programa passaria direto e seria cortado
    * em silencio mais adiante - aqui o corte acontece com o valor ja visivel
    * de volta no controle, e nunca chega truncado ao UPDATE.
    *
    * Depois do ajuste, propaga o estado da TELA para o BO: o legado lia
    * crGrade.CLocals/CTxtCds direto (ControlSource mantinha cursor e tela
    * iguais), enquanto aqui quem grava e imprime sao as propriedades *Atual.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SincronizarCampoParcela(par_oCampo, par_nLargura)
        LOCAL loc_cValor, loc_oErro

        *-- RETURN de guarda FORA do TRY/CATCH (CLAUDE.md regra #1).
        IF THIS.this_lSincronizandoParcela
            RETURN
        ENDIF

        THIS.this_lSincronizandoParcela = .T.

        TRY
            IF VARTYPE(par_oCampo) = "O" AND VARTYPE(par_oCampo.Value) = "C"
                loc_cValor = par_oCampo.Value

                IF par_nLargura > 0 AND LEN(loc_cValor) > par_nLargura
                    par_oCampo.Value = LEFT(loc_cValor, par_nLargura)
                ENDIF
            ENDIF

            THIS.SincronizarBOComTela()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em SincronizarCampoParcela")
        ENDTRY

        *-- Liberada DEPOIS do ENDTRY, para valer tambem quando o CATCH dispara.
        THIS.this_lSincronizandoParcela = .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * SincronizarBOComTela - leva a linha corrente da grade E o conteudo dos
    * dois EditBox editaveis para as propriedades *Atual do BO.
    *
    * CarregarDoCursor() resolve a parcela (FPags/Parcs/Vencs/Datas/Valos) a
    * partir do registro corrente; em seguida this_cLocalPgtoAtual/
    * this_cTextoCedenteAtual sao reafirmados a partir dos CONTROLES, que sao
    * a fonte do que o usuario de fato ve - sem depender do instante em que o
    * ControlSource descarrega o valor editado no cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SincronizarBOComTela()
        IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
            RETURN
        ENDIF

        THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")

        *-- So sobrepoe o valor lido do cursor quando o EditBox esta de fato
        *-- LIGADO a coluna (ControlSource atribuido em CarregarDados). Sem
        *-- esta condicao, um caminho em que a ligacao nao ocorreu - cursor
        *-- populado mas CarregarDados interrompido - faria o ""  do controle
        *-- apagar o valor que CarregarDoCursor acabou de trazer do cursor.
        IF UPPER(ALLTRIM(THIS.obj_4c_GetLocals.ControlSource)) == "CURSOR_4C_DADOS.CLOCALS" AND ;
                VARTYPE(THIS.obj_4c_GetLocals.Value) = "C"
            THIS.this_oBusinessObject.this_cLocalPgtoAtual = THIS.obj_4c_GetLocals.Value
        ENDIF

        IF UPPER(ALLTRIM(THIS.obj_4c_GetTxtCds.ControlSource)) == "CURSOR_4C_DADOS.CTXTCDS" AND ;
                VARTYPE(THIS.obj_4c_GetTxtCds.Value) = "C"
            THIS.this_oBusinessObject.this_cTextoCedenteAtual = THIS.obj_4c_GetTxtCds.Value
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - equivalente a Procedure imprimir() do legado (chamada apos
    * a confirmacao em btnImprimir.Click). Antes de delegar a
    * SigPrIbbBO.ImprimirBoleto(), chama SincronizarBOComTela() - o mesmo
    * ponto de sincronizacao usado pelos handlers de LostFocus dos dois
    * EditBox editaveis. Necessario porque o botao Imprimir pode ser acionado
    * por ENTER/atalho sem que o campo editado tenha perdido o foco, e porque
    * ImprimirBoleto() le as propriedades *Atual do BO, nao o cursor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Imprimir()
        LOCAL loc_oErro

        TRY
            THIS.SincronizarBOComTela()

            IF !THIS.this_oBusinessObject.ImprimirBoleto()
                IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
                    MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Imprimir")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - AddObject cria controles com Visible=.F. por
    * padrao; percorre recursivamente Controls (Containers/Grids/Pages de
    * eventuais PageFrames filhos) tornando tudo visivel.
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
