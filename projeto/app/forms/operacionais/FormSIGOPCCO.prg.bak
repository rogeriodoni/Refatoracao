*==============================================================================
* FormSIGOPCCO.prg - Form OPERACIONAL: Carta de Correcao de Nota Fiscal
* Migrado de: tasks/task657/SIGOPCCO.SCX (SIGOPCCO)
* Herda de: FormBase
* Layout: Flat (sem PageFrame) - dialogo unico modal
*
* O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico (WindowType=1,
* 800x425) com cabecalho (cntSombra), uma grade de ocorrencias ligada a um
* cursor LOCAL (XCorNf: codigo/descricao/texto de retificacao), o campo
* "Nota :" (Get_NotaIni) que reconsulta a grade ao ser alterado, e o
* CommandGroup "Sair" com 2 botoes (Confirmar/Cancelar).
*
* Fase 3/8 - ESTRUTURA BASE: cria o esqueleto da classe (propriedades,
* Init() recebendo os parametros do form chamador, InicializarForm(),
* Destroy()) e o cabecalho (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo),
* com geometria TRANSCRITA do dump. Grade e botoes (Fase 4), campo Nota
* (Fases 5-6), os eventos reais (Confirmar/Cancelar/Valid da Nota - Fase 7)
* e a consolidacao (Fase 8) entram nos blocos seguintes deste cabecalho.
*
* Fase 4/8 - GRADE E BOTOES: este form NAO tem Page1=Lista/Page2=Dados nem
* botoes CRUD (Incluir/Alterar/Excluir/Buscar) - e um dialogo OPERACIONAL
* unico, e inventar PageFrame/CRUD aqui violaria o PILAR 1. A superficie que
* o legado DE FATO tem:
*   - grd_4c_Dados        <- SIGOPCCO.Grade (3 colunas: Ocorrencia/Descricao/
*                            Retificacao), ligada a cursor_4c_Ocorrencias
*                            (equivalente ao "Create Cursor XCorNf" do Load).
*                            Column3 usa EditBox (Column3.Edit1 no legado),
*                            logo exige AddObject + CurrentControl + Sparse.
*   - cmg_4c_Sair         <- SIGOPCCO.Sair (CommandGroup Confirmar/Cancelar)
*   - CarregarDados()     <- bloco de carga que o legado repete IDENTICO em
*                            PROCEDURE Init e em Get_NotaIni.Valid: monta a
*                            lista de ocorrencias (SigCcOco) e casa cada uma
*                            com a retificacao gravada (SigNfCor)
*   - AtualizarGrade()    <- "Select XCorNf / Go Top / Grade.Refresh", metodo
*                            unico de repintura usado por todo caminho que
*                            popula o cursor
*
* Fase 5/8 - CAMPO NOTA (PARTE 1/2 - visual): adiciona ConfigurarCampoNota(),
* equivalente a SIGOPCCO.Say1 ("Nota : ") + SIGOPCCO.Get_NotaIni, com
* geometria TRANSCRITA do dump (Say1.Left=183/Top=94; Get_NotaIni.Left=220/
* Top=91/Width=52/MaxLength=6). O valor inicial (equivalente a
* "ThisForm.Get_NotaIni.Value = NFis" no PROCEDURE Init legado) e atribuido
* dentro do proprio metodo, com THIS.this_cNfis ja recebido pelo Init.
*
* Fase 6/8 - CAMPO NOTA (PARTE 2/2 - eventos e lookups):
*   - txt_4c_NotaIni.ReadOnly = .T. <- transcricao de Get_NotaIni.When
*     ("Return .f."): o campo NAO aceita digitacao, o valor vem so do form
*     chamador. NAO se faz isso com BINDEVENT "When" - BINDEVENT descarta o
*     retorno do delegate e o campo continuaria digitavel (regra CLAUDE.md #3).
*   - ValidarNotaIni()  <- Get_NotaIni.Valid, ligado por BINDEVENT
*     "LostFocus" ("Valid" nao e confiavel em TextBox). Delega a
*     THIS.CarregarDados(valor, .T.) e zera o campo quando a nota nao tem
*     correcao gravada, igual ao "This.Value = ''" do legado; devolve
*     .T./.F. no lugar do "Return 0" do ramo Else.
*
* LOOKUPS: o legado NAO TEM NENHUM - zero fwBuscaExt/fwBuscaSel/fwBuscaInt,
* zero sigacess()/Acesso*(), zero mAddColuna em todo o SIGOPCCO.SCX. O unico
* campo digitavel do form e a coluna Retificacao da grade (texto livre, memo
* mretifs). Criar AbrirLookup*/AbrirBusca* aqui obrigaria a INVENTAR uma
* tabela de busca que o original nunca consulta - proibido pelo PILAR 1 e
* pela regra explicita "NUNCA inventar tabelas de lookup que nao existem no
* original".
*
* A mensagem "Nota Fiscal Invalida !!" NAO pertence ao Valid do campo - ela
* esta no Ok.Click (Fase 7/8), disparada quando o campo esta vazio ao
* confirmar.
*
* Fase 7/8 - EVENTOS PRINCIPAIS (Confirmar/Cancelar + navegacao da grade):
*   - BtnConfirmarClick()   <- Sair.Ok.Click: Delete+Insert(s)+Update de
*     SigNfCor/SigMvNfi.Correcs como LOTE T-SQL UNICO (SAVE TRANSACTION,
*     THIS.this_oBusinessObject.ConfirmarCorrecao) - o par SqlExecute/Commit/
*     RollBack do fSqlConector legado NAO protegia nada (a conexao
*     SQLSTRINGCONNECT ja nasce com @@TRANCOUNT=1), entao a atomicidade
*     pretendida so se reproduz num lote so. Sem retificacao gravada,
*     oferece "Confirma Impressao da Correcao ?" e abre Formsigreimc.
*   - BtnCancelarClick()    <- Sair.Cancela.Click: THIS.Release() direto.
*   - AbrirImpressaoCorrecao() <- "Do Form SigreImc With ..."; pEDNs (chave
*     EmpDopNums) vem do cursor global do form CHAMADOR no legado - aqui,
*     sem form chamador, e obtido de SigMvNfi.empdopnums pela mesma chave
*     natural Emps/Series/Nfis (THIS.this_oBusinessObject.ObterEmpDopNums).
*   - GradeRetificacaoKeyPress() <- Column3.Edit1.KeyPress: navegacao por
*     registro (Enter/Ctrl+X avanca, Ctrl+E volta, Tab vira Ctrl+Tab).
*
* Parametros recebidos (equivalentes a "LParameters pForm,Emp,Serie,EmisDe,
* EmisAte,NFis" do legado): o form chamador, empresa/serie/intervalo de
* emissao (repassados a impressao) e o numero da nota fiscal inicial, que
* preenche txt_4c_NotaIni e dispara a 1a carga da grade.
*
* Fase 8/8 - EVENTOS AUXILIARES E CONSOLIDACAO FINAL. Quatro metodos de
* consolidacao, todos ligados ao fluxo real (nenhum e ponto morto):
*   - CarregarLista()  <- FUNIL da unica lista do form (a grade de
*     ocorrencias): FormParaBO -> CarregarDados -> AtualizarGrade. Chamado
*     pelo InicializarForm no lugar da chamada direta a CarregarDados.
*   - FormParaBO()     <- o bloco "ThisForm.Emp = Emp / ThisForm.Serie =
*     Serie / ThisForm.EmisDe = ... / ThisForm.pcNFisDe = NFis" do PROCEDURE
*     Init legado, MAIS a linha corrente da grade (XCorNf.Cods/Retifs, que o
*     Ok.Click le para montar cada Insert). Chamado pelo InicializarForm
*     (semeia o BO), pelo CarregarLista e pelo BtnConfirmarClick.
*   - BOParaForm()     <- o inverso: a nota vai para txt_4c_NotaIni
*     ("ThisForm.Get_NotaIni.Value = NFis") e a retificacao gravada vai para
*     a linha da grade pelo Seek/Replace do 2o Scan do Init/Valid legado.
*     Chamado pelo ConfigurarCampoNota e por CarregarDados (dentro do Scan).
*   - LimparCampos()   <- o ramo Else do Get_NotaIni.Valid ("This.Value = ''
*     / Select XCorNf / Zap / Grade.Refresh"), agora em fonte unica, usado
*     pelo ValidarNotaIni quando a nota nao tem correcao gravada.
*
* A barra CRUD canonica (os cinco botoes de manutencao da Page1 de Lista, o
* par Gravar/Desistir da Page2 de Dados e o Encerrar do canto) NAO EXISTE
* neste legado: o SIGOPCCO tem UM CommandGroup ("Sair") de dois botoes -
* Confirmar (Ok.Click, que grava) e Cancelar (Cancela.Click, que so fecha) -
* e nenhuma alternancia de pagina. Pelo mesmo motivo nao ha metodo de
* habilitacao por modo nem de ajuste de botoes por modo: a tela tem estado
* FIXO (campo da nota nao digitavel pelo Get_NotaIni.When; colunas
* Ocorrencia/Descricao travadas pelos Text1.When; so a coluna Retificacao
* aceita digitacao), definido uma vez na montagem. Criar esses metodos
* exigiria INVENTAR botoes e modos que o original nao tem (viola o PILAR 1)
* ou deixar corpo vazio (proibido pela regra de completude).
*==============================================================================

DEFINE CLASS FormSIGOPCCO AS FormBase

    Height       = 425
    Width        = 800
    Caption      = ""
    TitleBar     = 0
    ShowWindow   = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    ClipControls = .T.
    WindowType   = 0
    DataSession  = 1
    BorderStyle  = 2
    AutoCenter   = .T.
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *-- Contexto recebido do form chamador (par_* do Init)
    this_oFormPai  = .NULL.
    this_cEmps     = ""
    this_cSeries   = ""
    this_dEmisDe   = {}
    this_dEmisAte  = {}
    this_cNfis     = ""

    *--------------------------------------------------------------------------
    * Init - recebe o contexto do form chamador e define Caption com CHR()
    * antes de delegar ao FormBase
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oFormPai, par_cEmps, par_cSeries, par_dEmisDe, par_dEmisAte, par_cNfis)
        THIS.Caption = "Carta de Corre" + CHR(231) + CHR(227) + "o"

        THIS.this_oFormPai  = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
        THIS.this_cEmps     = IIF(VARTYPE(par_cEmps)   = "C", par_cEmps,   "")
        THIS.this_cSeries   = IIF(VARTYPE(par_cSeries) = "C", par_cSeries, "")
        THIS.this_dEmisDe   = IIF(INLIST(VARTYPE(par_dEmisDe),  "D", "T"), par_dEmisDe,  {})
        THIS.this_dEmisAte  = IIF(INLIST(VARTYPE(par_dEmisAte), "D", "T"), par_dEmisAte, {})
        THIS.this_cNfis     = IIF(VARTYPE(par_cNfis)   = "C", par_cNfis,   "")

        *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
        *-- definida com WindowType=0; producao restaura para modal aqui, fora
        *-- de teste/validacao de UI (mesmo padrao de FormSigOpCcl).
        IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
             (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
            THIS.WindowType = 1
            THIS.ShowWindow = 1
        ENDIF

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - cria o Business Object e monta a estrutura base
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCCOBO")

            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SIGOPCCOBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
                        "Erro em InicializarForm")
            ELSE
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"

                *-- Semeia o BO com o contexto recebido do form chamador,
                *-- equivalente ao bloco "ThisForm.Emp = Emp / ThisForm.Serie =
                *-- Serie / ThisForm.EmisDe = EmisDe / ThisForm.EmisAte =
                *-- EmisAte / ThisForm.pcNFisDe = NFis" do PROCEDURE Init
                *-- legado. Chamado ANTES de ConfigurarPageFrame porque
                *-- ConfigurarCampoNota le o valor de volta pelo BOParaForm -
                *-- nesta 1a passagem o campo da tela ainda nao existe e o
                *-- FormParaBO cai no parametro recebido (ver o guard la).
                THIS.FormParaBO()

                THIS.ConfigurarPageFrame()

                THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
                THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption

                THIS.TornarControlesVisiveis(THIS)

                *-- 1a carga da grade, como o PROCEDURE Init legado faz
                *-- (Requery de CrSigNfCor/CrSigCcOco + montagem de XCorNf)
                *-- com a nota recebida do form chamador. Sem aviso de "Nota
                *-- sem Correcao" - o legado so avisa no Valid do campo.
                *-- Pulado em validacao de UI/modo teste: nao ha conexao SQL.
                IF (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI) AND ;
                   (TYPE("gb_4c_ModoTeste")   != "L" OR !gb_4c_ModoTeste)
                    THIS.CarregarLista()
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em InicializarForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
    * Nao ha PageFrame real (o legado SIGOPCCO e flat); o nome e mantido por
    * conformidade com o contrato do pipeline multi-fase.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarGrade()
        THIS.ConfigurarBotoes()
        THIS.ConfigurarCampoNota()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
    * labels de titulo sobrepostos (sombra preta + titulo branco).
    * Geometria TRANSCRITA do dump: SIGOPCCO.cntSombra/lblSombra/lblTitulo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BackColor   = RGB(100, 100, 100)
            .BackStyle   = 1
            .BorderWidth = 0
            .Visible     = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top           = 18
            .Left          = 10
            .Width         = 769
            .Height        = 40
            .AutoSize      = .F.
            .BackStyle     = 0
            .WordWrap      = .T.
            .Alignment     = 0
            .FontName      = "Tahoma"
            .FontSize      = 18
            .FontBold      = .T.
            .FontUnderline = .F.
            .ForeColor     = RGB(0, 0, 0)
            .Caption       = THIS.Caption
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top         = 17
            .Left        = 10
            .Width       = 769
            .Height      = 46
            .AutoSize    = .F.
            .BackStyle   = 0
            .WordWrap    = .T.
            .Alignment   = 0
            .FontName    = "Tahoma"
            .FontSize    = 18
            .FontBold    = .T.
            .ForeColor   = RGB(255, 255, 255)
            .Caption     = THIS.Caption
            .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarCursorOcorrencias - cursor LOCAL (nao SQL) de ocorrencias de
    * correcao, equivalente ao "Create Cursor XCorNf (cods n(3),descs c(30),
    * retifs m(8) NULL) / Index On cods Tag cods" do PROCEDURE Load legado.
    * E repopulado a cada troca de Nota Fiscal (Fase 6, Get_NotaIni.Valid) -
    * por isso o reset defensivo no inicio, igual ao padrao de todo form que
    * recria cursor local proprio.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CriarCursorOcorrencias()
        IF USED("cursor_4c_Ocorrencias")
            USE IN cursor_4c_Ocorrencias
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Ocorrencias (cods N(3), descs C(30), retifs M NULL)
        SET NULL OFF
        INDEX ON cods TAG cods
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrade - grd_4c_Dados, equivalente a SIGOPCCO.Grade: 3 colunas
    * (Ocorrencia/Descricao/Retificacao), geometria TRANSCRITA do dump.
    * Column3 usa EditBox (nao Text1 - o legado tem Column3.Edit1), por isso
    * precisa de AddObject + CurrentControl + Sparse=.F. (regra #18 - sem
    * isso a coluna continua desenhando o Text1 default e a retificacao
    * digitada nunca aparece).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrade()
        THIS.CriarCursorOcorrencias()

        THIS.AddObject("grd_4c_Dados", "Grid")

        *-- ColumnCount/RecordSource FORA do WITH abaixo: dentro do mesmo WITH
        *-- que acessa .Column1/.Column2/.Column3, as colunas ainda nao
        *-- existem no momento da compilacao do bloco e o VFP estoura
        *-- "Unknown member COLUMN1" (regra CLAUDE.md sobre WITH + Grid).
        THIS.grd_4c_Dados.ColumnCount  = 3
        THIS.grd_4c_Dados.RecordSource = "cursor_4c_Ocorrencias"

        WITH THIS.grd_4c_Dados
            .Top               = 122
            .Left              = 98
            .Width             = 604
            .Height            = 290
            .FontName          = "Tahoma"
            .FontSize          = 8
            .ForeColor         = RGB(0, 0, 0)
            .AllowHeaderSizing = .F.
            .AllowRowSizing    = .F.
            .DeleteMark        = .F.
            .RecordMark        = .F.
            .GridLines         = 3
            .ReadOnly          = .F.
            .RowHeight         = 16
            .ScrollBars        = 2
            .TabIndex          = 5

            .Column1.ControlSource     = "cursor_4c_Ocorrencias.cods"
            .Column1.Width             = 70
            .Column1.FontName          = "Tahoma"
            .Column1.FontSize          = 8
            .Column1.Movable           = .F.
            .Column1.Resizable         = .F.
            .Column1.ForeColor         = RGB(0, 0, 0)
            .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
            .Column1.Header1.Alignment = 2
            .Column1.Header1.FontName  = "Tahoma"
            .Column1.Header1.FontSize  = 8
            .Column1.Text1.BorderStyle = 0
            .Column1.Text1.Margin      = 0
            .Column1.Text1.ReadOnly    = .F.   && transcrito do dump (default)
            .Column1.Text1.ForeColor   = RGB(0, 0, 0)
            .Column1.Text1.BackColor   = RGB(255, 255, 255)
            *-- legado: Column1.Text1.When -> Return(.F.) (coluna nao digitavel).
            *-- POR ULTIMO de proposito: o ReadOnly do Grid propaga para as
            *-- colunas e o do Text1 reabriria a celula (regra CLAUDE.md #18/#46)
            .Column1.ReadOnly          = .T.

            .Column2.ControlSource     = "cursor_4c_Ocorrencias.descs"
            .Column2.Width             = 220
            .Column2.FontName          = "Tahoma"
            .Column2.FontSize          = 8
            .Column2.Movable           = .F.
            .Column2.Resizable         = .F.
            .Column2.ForeColor         = RGB(0, 0, 0)
            .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
            .Column2.Header1.Alignment = 2
            .Column2.Header1.FontName  = "Tahoma"
            .Column2.Header1.FontSize  = 8
            .Column2.Text1.BorderStyle = 0
            .Column2.Text1.Margin      = 0
            .Column2.Text1.ReadOnly    = .F.   && transcrito do dump (default)
            .Column2.Text1.ForeColor   = RGB(0, 0, 0)
            .Column2.Text1.BackColor   = RGB(255, 255, 255)
            *-- legado: Column2.Text1.When -> Return(.F.) (coluna nao digitavel).
            *-- POR ULTIMO, mesmo motivo da Column1.
            .Column2.ReadOnly          = .T.

            .Column3.Width             = 280
            .Column3.FontName          = "Tahoma"
            .Column3.FontSize          = 8
            .Column3.Movable           = .F.
            .Column3.Resizable         = .F.
            .Column3.ForeColor         = RGB(0, 0, 0)
            .Column3.Header1.Caption   = "Retifica" + CHR(231) + CHR(227) + "o"
            .Column3.Header1.Alignment = 2
            .Column3.Header1.FontName  = "Tahoma"
            .Column3.Header1.FontSize  = 8

            .Column3.AddObject("edt_4c_Retificacao", "EditBox")
            .Column3.edt_4c_Retificacao.Top       = 31
            .Column3.edt_4c_Retificacao.Left      = 5
            .Column3.edt_4c_Retificacao.Width     = 100
            .Column3.edt_4c_Retificacao.Height    = 53
            .Column3.edt_4c_Retificacao.FontName  = "Tahoma"
            .Column3.edt_4c_Retificacao.FontSize  = 8
            .Column3.edt_4c_Retificacao.ForeColor = RGB(0, 0, 0)
            .Column3.CurrentControl    = "edt_4c_Retificacao"
            .Column3.ControlSource     = "cursor_4c_Ocorrencias.retifs"
            .Column3.Sparse            = .F.
            .Column3.ReadOnly          = .F.

            .Visible = .T.
        ENDWITH

        *-- SIGOPCCO.Grade.Column3.Edit1.KeyPress (legado): navegacao por
        *-- registro (Enter/Ctrl+X avancam, Ctrl+E volta, Tab vira Ctrl+Tab).
        *-- BINDEVENT exige que o metodo alvo ja exista em THIS e seja PUBLIC
        *-- (regra CLAUDE.md #3) - por isso vem DEPOIS do WITH acima.
        BINDEVENT(THIS.grd_4c_Dados.Column3.edt_4c_Retificacao, "KeyPress", ;
                  THIS, "GradeRetificacaoKeyPress")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - cmg_4c_Sair, equivalente a SIGOPCCO.Sair
    * (CommandGroup com Confirmar/Cancelar). Geometria e visual TRANSCRITOS
    * do dump; Buttons(N) dentro de CommandGroup mantem Themes=.F. (igual ao
    * legado Command1/Command2.Themes=.F.). Os Click handlers (Ok.Click/
    * Cancela.Click do legado) sao implementados na Fase 7/8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        THIS.AddObject("cmg_4c_Sair", "CommandGroup")
        WITH THIS.cmg_4c_Sair
            .Top           = -2
            .Left          = 645
            .Width         = 160
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .BorderColor   = RGB(136, 189, 188)
            .TabIndex      = 6

            WITH .Buttons(1)
                .Top        = 5
                .Left       = 5
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
                .Caption    = "\<Confirmar"
            ENDWITH

            WITH .Buttons(2)
                .Top        = 5
                .Left       = 80
                .Width      = 75
                .Height     = 75
                .FontName   = "Comic Sans MS"
                .FontSize   = 8
                .FontBold   = .T.
                .FontItalic = .T.
                .ForeColor  = RGB(90, 90, 90)
                .BackColor  = RGB(255, 255, 255)
                .Cancel     = .T.
                .Themes     = .F.
                .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .Caption    = "\<Cancelar"
            ENDWITH

            .Visible = .T.
        ENDWITH

        *-- SIGOPCCO.Sair.Ok.Click / Cancela.Click (legado). BINDEVENT exige
        *-- que o metodo alvo ja exista em THIS e seja PUBLIC (regra CLAUDE.md
        *-- #3) - por isso vem DEPOIS do WITH acima, no mesmo padrao de
        *-- FormSigOpCcl (Buttons(1)=acao principal, Buttons(2)=saida).
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(1), "Click", THIS, "BtnConfirmarClick")
        BINDEVENT(THIS.cmg_4c_Sair.Buttons(2), "Click", THIS, "BtnCancelarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampoNota - lbl_4c_Label1 + txt_4c_NotaIni, equivalente a
    * SIGOPCCO.Say1 ("Nota : ") + SIGOPCCO.Get_NotaIni. Geometria TRANSCRITA
    * do dump:
    *   Say1:        Left=183, Top=94,                Caption="Nota : "
    *   Get_NotaIni: Left=220, Top=91, Width=52, MaxLength=6, ForeColor preto
    *
    * Say1 e classe "say" (framework.vcx) e nao declara Width nem Alignment
    * no dump - regra #23: nao inventar .Alignment=1 nem Width alheio ao
    * texto. AutoSize=.T. e no-op em Label criado por AddObject, entao a
    * largura (34) e explicita e calculada para o texto terminar perto do
    * Left do TextBox (220), igual ao padrao do framework. ForeColor nao
    * declarado no dump -> canonico RGB(90,90,90) (regra #12).
    *
    * Valor inicial equivalente a "ThisForm.Get_NotaIni.Value = NFis" do
    * PROCEDURE Init legado (THIS.this_cNfis ja foi normalizado no Init do
    * form). O evento Valid (que rechama CarregarDados com aviso e reproduz
    * "Nota Fiscal Invalida !!") fica para a Fase 6/8.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampoNota()
        THIS.AddObject("lbl_4c_Label1", "Label")
        WITH THIS.lbl_4c_Label1
            .Top       = 94
            .Left      = 183
            .Width     = 34
            .Height    = 17
            .AutoSize  = .F.
            .BackStyle = 0
            .WordWrap  = .F.
            .Alignment = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Nota : "
            .TabIndex  = 3
        ENDWITH

        THIS.AddObject("txt_4c_NotaIni", "TextBox")
        WITH THIS.txt_4c_NotaIni
            .Top       = 91
            .Left      = 220
            .Width     = 52
            .MaxLength = 6
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
            .Value     = ""
            .TabIndex  = 1

            *-- Get_NotaIni.When (legado) -> "Return .f." SEMPRE: o campo NAO
            *-- aceita digitacao - o valor vem so do form chamador (o
            *-- "ThisForm.Get_NotaIni.Value = NFis" do PROCEDURE Init).
            *--
            *-- NAO usar BINDEVENT(..., "When", ...) para isso: BINDEVENT
            *-- DESCARTA o retorno do delegate, entao um When ligado por
            *-- BINDEVENT nao bloqueia nada (regra CLAUDE.md #3) - o campo
            *-- continuaria digitavel e o usuario poderia trocar a nota por uma
            *-- que o Ok.Click vai gravar com o Emps/Series do form chamador.
            *-- ReadOnly = .T. eh a reproducao canonica de "When -> .f." no
            *-- sistema novo (mesmo criterio que o validador de UI usa para os
            *-- campos nao-digitaveis do Framework Fortyus) e PRESERVA a
            *-- aparencia do legado - ao contrario de Enabled = .F., que
            *-- acinzentaria o campo (violaria o PILAR 1).
            .ReadOnly  = .T.
        ENDWITH

        *-- "ThisForm.Get_NotaIni.Value = NFis" do PROCEDURE Init legado.
        *-- Centralizado no BOParaForm (fonte unica da transferencia
        *-- BO -> tela), que o InicializarForm ja semeou pelo FormParaBO.
        THIS.BOParaForm()

        *-- Get_NotaIni.Valid (legado) roda ao SAIR do campo. BINDEVENT "Valid"
        *-- NAO eh confiavel em TextBox (regra CLAUDE.md), por isso o gancho eh
        *-- "LostFocus" - padrao do projeto para handler derivado de Valid.
        BINDEVENT(THIS.txt_4c_NotaIni, "LostFocus", THIS, "ValidarNotaIni")
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNotaIni - equivalente a SIGOPCCO.Get_NotaIni.Valid:
    *
    *   If !IsEmpty(This.Value)
    *       Select XCorNf / Zap
    *       pcNFisDe = This.Value / Requery('CrSigNfCor')
    *       If !Eof()
    *           <monta XCorNf a partir de CrSigCcOco + casa com CrSigNfCor>
    *       Else
    *           MessageBox('Nota sem Correcao !!',0+48,'')
    *           This.Value = '' / This.Refresh
    *           Select XCorNf / Zap / ThisForm.Grade.Refresh
    *           Return 0
    *       EndIf
    *   EndIf
    *
    * Campo vazio: o "If !IsEmpty" do legado envolve o metodo INTEIRO, sem
    * ramo Else - NAO faz nada (nem Zap, nem aviso). Campo preenchido:
    * delega a THIS.CarregarDados(valor, .T.), que ja reproduz o Zap +
    * Requery + os dois Scan (Fase 4) e, no ramo sem correcao gravada,
    * mostra "Nota sem Correcao !!" + zera a grade + repinta (regra do
    * par_lAvisarSemRegistro=.T.); aqui so falta zerar o proprio campo,
    * igual ao "This.Value = ''" do legado.
    *
    * Retorno: .T. quando a nota tem correcao gravada, .F. quando nao tem -
    * equivalente ao "Return 0" do ramo Else do Valid legado.
    *
    * PUBLIC (nao PROTECTED) porque e alvo de BINDEVENT - regra CLAUDE.md #3.
    * TRANSCRICAO FIEL, inclusive do alcance: com o ReadOnly = .T. que
    * reproduz o Get_NotaIni.When, o campo nao aceita digitacao e o valor
    * nunca muda entre ganhar e perder o foco - exatamente como no legado,
    * onde o "When -> Return .f." tambem impede o Valid de rodar. O handler
    * NAO foi descartado (o legado o tem, o PILAR 1 manda reproduzir) e volta
    * a valer sozinho se o campo for liberado para digitacao no futuro.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNotaIni()
        LOCAL loc_cValor, loc_lTemCorrecao

        loc_lTemCorrecao = .F.
        loc_cValor       = ALLTRIM(THIS.txt_4c_NotaIni.Value)

        IF !EMPTY(loc_cValor)
            loc_lTemCorrecao = THIS.CarregarDados(loc_cValor, .T.)

            IF !loc_lTemCorrecao
                *-- "This.Value = '' / This.Refresh / Select XCorNf / Zap /
                *-- ThisForm.Grade.Refresh" do ramo Else do Valid legado -
                *-- centralizado em LimparCampos (fonte unica da limpeza).
                THIS.LimparCampos()
            ENDIF
        ENDIF

        RETURN loc_lTemCorrecao
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnConfirmarClick - equivalente a SIGOPCCO.Sair.Ok.Click:
    *
    *   If Not IsEmpty(ThisForm.Get_NotaIni.Value)
    *       <Delete SigNfCor + Update SigMvNfi.Correcs=.F. + Commit>
    *       Zap In crSigNfCor
    *       <para cada XCorNf.Retifs preenchido: Insert Into crSigNfCor>
    *       Select crSigNfCor / Go Top
    *       If !Eof()
    *           <Update(crSigNfCor) + Update SigMvNfi.Correcs=.T. + Commit>
    *       Else
    *           If MessageBox('Confirma Impressao da Correcao ?',4+32+256,'')=6
    *               <Do Form SigreImc com Emp/Serie/EmisDe/EmisAte/EmpDopNums/
    *                NFisDe/NFisDe>
    *           EndIf
    *       EndIf
    *       ThisForm.Release
    *   Else
    *       MessageBox('Nota Fiscal Invalida !!',0+48,'')
    *   EndIf
    *
    * O legado protege a sequencia Delete+Update+Insert(s)+Update com
    * SqlExecute/Commit/RollBack do fSqlConector - mas BEGIN/COMMIT via
    * SQLEXEC separados NAO protegem nada (a conexao SQLSTRINGCONNECT ja
    * nasce com @@TRANCOUNT=1, entao um par BEGIN/COMMIT so aninha o
    * contador e nunca efetiva rollback nenhum). A transcricao fiel da
    * ATOMICIDADE pretendida pelo legado (tudo ou nada) e um LOTE T-SQL
    * UNICO com SAVE TRANSACTION/TRY/CATCH/THROW (THIS.this_oBusinessObject.
    * ConfirmarCorrecao, padrao ProdutoBO.CopiarProduto) - nao os llTaOk/
    * Return 0 encadeados do VFP, que dependiam do Commit/RollBack que nao
    * protegia nada.
    *
    * "Zap In crSigNfCor" + o 1o Scan (monta crSigNfCor so com as linhas que
    * tem Retifs) + "Select crSigNfCor / Go Top / If !Eof()" virou
    * this_lTemCorrecoesGravadas: .T. quando o lote gravou pelo menos 1
    * retificacao (equivalente a "o buffer nao ficou vazio"), .F. quando
    * nenhuma linha de XCorNf tinha Retifs preenchido (equivalente ao buffer
    * vazio que cai no ramo "Confirma Impressao da Correcao ?").
    *
    * pEDNs ("CrSigMvNfi.Emps + CrSigMvNfi.Dopes + Str(CrSigMvNfi.Numes,6)")
    * vem, no legado, do cursor global do FORM CHAMADOR - aqui o form abre
    * direto do menu (sem form chamador com grade de notas), e a mesma chave
    * (SigMvNfi.empdopnums, coluna ja materializada - regra #42) e obtida
    * consultando a MESMA linha pela chave natural Emps/Series/Nfis que os
    * Updates acima ja usam (THIS.this_oBusinessObject.ObterEmpDopNums).
    *--------------------------------------------------------------------------
    PROCEDURE BtnConfirmarClick()
        LOCAL loc_cNfis, loc_lSucesso, loc_cEmpDopNums

        loc_cNfis = ALLTRIM(THIS.txt_4c_NotaIni.Value)

        IF EMPTY(loc_cNfis)
            *-- "MessageBox('Nota Fiscal Invalida !!',0+48,'')" - validacao de
            *-- UI, nao erro tecnico (regra CLAUDE.md: MsgAviso, nao MsgErro)
            MsgAviso("Nota Fiscal Inv" + CHR(225) + "lida !!", "")
        ELSE
            *-- Transfere tela -> BO ANTES de gravar: empresa/serie/nota e a
            *-- linha corrente da grade passam a ser lidas das properties do
            *-- proprio BO (fonte unica), em vez de repassadas como argumento
            *-- em cada chamada.
            THIS.FormParaBO()

            loc_lSucesso = THIS.this_oBusinessObject.ConfirmarCorrecao()

            IF loc_lSucesso
                IF !THIS.this_oBusinessObject.this_lTemCorrecoesGravadas
                    *-- "If MessageBox('Confirma Impressao da Correcao ?',4+32+256,'')=6"
                    IF MsgConfirma("Confirma Impress" + CHR(227) + "o da Corre" + CHR(231) + CHR(227) + "o ?", "Confirmar")
                        loc_cEmpDopNums = THIS.this_oBusinessObject.ObterEmpDopNums()
                        THIS.AbrirImpressaoCorrecao(loc_cEmpDopNums, loc_cNfis)
                    ENDIF
                ENDIF

                *-- "ThisForm.Release" - so no caminho de SUCESSO; a falha
                *-- (ELSE abaixo) mantem a tela aberta, igual ao "Return 0"
                *-- dos ramos de erro do legado
                THIS.Release()
            ELSE
                IF !THIS.this_oBusinessObject.this_lErroExibido
                    MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o")
                ENDIF
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - equivalente a SIGOPCCO.Sair.Cancela.Click:
    * "ThisForm.Release" - sem gravar nada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Alias canonico para fechar o form sem salvar (harness
    * TesteAutomatico exige este nome em todo form OPERACIONAL). O SIGOPCCO
    * legado so tem UM botao de saida sem gravar (Sair.Cancela.Click), ja
    * implementado em BtnCancelarClick - este metodo apenas delega para ele,
    * sem duplicar logica (mesmo padrao de FormFis.prg).
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.BtnCancelarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirImpressaoCorrecao - equivalente a "Do Form SigreImc With pcEmps,
    * pcSeries,pcEmisDe,pcEmisAte,pEDNs,pcNFisDe,pcNFisAte" do Ok.Click
    * legado. O legado repete pcNFisDe duas vezes (NFisDe e NFisAte) porque a
    * Carta de Correcao trata sempre UMA nota so - reproduzido aqui passando
    * par_cNfis duas vezes.
    *--------------------------------------------------------------------------
    PROCEDURE AbrirImpressaoCorrecao(par_cEmpDopNums, par_cNfis)
        LOCAL loc_oForm, loc_oErro

        TRY
            loc_oForm = CREATEOBJECT("Formsigreimc", THIS.this_cEmps, THIS.this_cSeries, ;
                                      THIS.this_dEmisDe, THIS.this_dEmisAte, ;
                                      IIF(VARTYPE(par_cEmpDopNums) = "C", par_cEmpDopNums, ""), ;
                                      par_cNfis, par_cNfis)

            IF VARTYPE(loc_oForm) = "O"
                loc_oForm.Show()
            ELSE
                MsgErro("Erro ao criar formul" + CHR(225) + "rio de impress" + CHR(227) + "o da corre" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(loc_oForm), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao abrir impress" + CHR(227) + "o da corre" + CHR(231) + CHR(227) + "o")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * GradeRetificacaoKeyPress - equivalente a SIGOPCCO.Grade.Column3.Edit1.
    * KeyPress: navegacao por registro dentro do EditBox de retificacao
    * (Enter/Ctrl+X avancam, Ctrl+E volta, Tab vira Ctrl+Tab p/ sair da
    * grade). PUBLIC (nao PROTECTED) porque e alvo de BINDEVENT (regra
    * CLAUDE.md #3) e DECLARA os parametros do evento (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE GradeRetificacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = 13 OR par_nKeyCode = 24
                IF USED("cursor_4c_Ocorrencias")
                    SELECT cursor_4c_Ocorrencias
                    IF !EOF()
                        SKIP
                    ENDIF
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            CASE par_nKeyCode = 5
                IF USED("cursor_4c_Ocorrencias")
                    SELECT cursor_4c_Ocorrencias
                    IF !BOF()
                        SKIP -1
                    ENDIF
                ENDIF
                THIS.grd_4c_Dados.Refresh()
            CASE par_nKeyCode = 9
                KEYBOARD "{CTRL+TAB}"
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - popula a grade de ocorrencias da Carta de Correcao.
    *
    * TRANSCRICAO do bloco de carga do legado, que aparece IDENTICO em DOIS
    * lugares (PROCEDURE Init e Get_NotaIni.Valid) e aqui vira METODO UNICO:
    *
    *   Select XCorNf / Zap
    *   pcNFisDe = <nota> / ThisForm.poDataMgr.Requery('CrSigNfCor')
    *   Select CrSigNfCor / Go Top
    *   If !Eof()
    *       Select CrSigCcOco
    *       Scan
    *           Insert Into XCorNf (cods,descs,retifs) ;
    *           Values (CrSigCcOco.ncodigos,CrSigCcOco.cdescrs,'')
    *       EndScan
    *       Select CrSigNfCor
    *       Scan
    *           If Seek(CrSigNfCor.noccors,'XCorNf.cods','cods')
    *               Replace XCorNf.retifs With CrSigNfCor.mretifs
    *           EndIf
    *       EndScan
    *   Else
    *       MessageBox('Nota sem Correcao !!',0+48,'')   && SO no Valid
    *   EndIf
    *   Select XCorNf / Go Top / ThisForm.Refresh
    *
    * REGRA DE NEGOCIO transcrita (nao "simplificar"): a lista completa de
    * ocorrencias so eh montada quando a nota JA TEM correcao gravada. Nota
    * sem nenhuma linha em SigNfCor deixa a grade VAZIA de proposito - e o
    * que faz o Ok.Click cair no ramo "Confirma Impressao da Correcao ?".
    *
    * Parametros:
    *   par_cNfis              - nota fiscal a consultar (default: this_cNfis)
    *   par_lAvisarSemRegistro - .T. reproduz o aviso 'Nota sem Correcao !!'
    *       do Get_NotaIni.Valid. O Init legado NAO avisa (abre a grade vazia
    *       em silencio), por isso o aviso eh PARAMETRIZADO em vez de fixo.
    *
    * Retorno: .T. quando a nota tem correcao gravada (grade populada) e .F.
    * quando nao tem - o Valid do campo Nota usa esse retorno para reproduzir
    * o "Return 0" do legado.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados(par_cNfis, par_lAvisarSemRegistro)
        LOCAL loc_cNfis, loc_lAvisar, loc_lTemCorrecao, loc_oErro
        LOCAL loc_oBO

        loc_cNfis        = IIF(VARTYPE(par_cNfis) = "C", ALLTRIM(par_cNfis), ALLTRIM(THIS.this_cNfis))
        loc_lAvisar      = (VARTYPE(par_lAvisarSemRegistro) = "L" AND par_lAvisarSemRegistro)
        loc_lTemCorrecao = .F.
        loc_oBO          = THIS.this_oBusinessObject

        TRY
            *-- "Select XCorNf / Zap": esvazia a grade SEM derrubar o alias.
            *-- USE IN + CREATE CURSOR aqui quebraria RecordSource/
            *-- ControlSource/CurrentControl da grade ja criada - por isso
            *-- CriarCursorOcorrencias() so roda se o alias nao existir.
            IF !USED("cursor_4c_Ocorrencias")
                THIS.CriarCursorOcorrencias()
            ENDIF
            SELECT cursor_4c_Ocorrencias
            ZAP

            IF VARTYPE(loc_oBO) = "O" AND !EMPTY(loc_cNfis)

                *-- Requery('CrSigNfCor'): retificacoes JA gravadas na nota
                IF loc_oBO.CarregarCorrecoes(THIS.this_cEmps, THIS.this_cSeries, loc_cNfis) ;
                   AND USED("cursor_4c_Correcoes") AND RECCOUNT("cursor_4c_Correcoes") > 0

                    loc_lTemCorrecao = .T.

                    *-- 1o Scan do legado: a LISTA COMPLETA de ocorrencias
                    *-- (CrSigCcOco) entra na grade com retificacao em branco
                    IF loc_oBO.CarregarOcorrencias() AND USED("cursor_4c_TiposOcorrencia")
                        SELECT cursor_4c_TiposOcorrencia
                        GO TOP
                        SCAN
                            INSERT INTO cursor_4c_Ocorrencias (cods, descs, retifs) ;
                                 VALUES (cursor_4c_TiposOcorrencia.ncodigos, ;
                                         cursor_4c_TiposOcorrencia.cdescrs, ;
                                         "")
                            *-- INSERT INTO seleciona a tabela de DESTINO:
                            *-- reposicionar o alias do SCAN, igual ao
                            *-- "Select CrSigNfCor" que o legado faz no 2o Scan
                            SELECT cursor_4c_TiposOcorrencia
                        ENDSCAN
                    ENDIF

                    *-- 2o Scan do legado: casa a retificacao gravada com a
                    *-- ocorrencia correspondente (SEEK pelo TAG cods)
                    SELECT cursor_4c_Correcoes
                    GO TOP
                    SCAN
                        *-- Uma linha gravada de SigNfCor por vez: o BO le a
                        *-- linha (TratarNulo em mretifs, que e text NULL) e o
                        *-- BOParaForm faz o Seek + Replace na ocorrencia
                        *-- correspondente da grade. Fonte unica da
                        *-- transferencia BO -> tela.
                        loc_oBO.CarregarDoCursor("cursor_4c_Correcoes")
                        THIS.BOParaForm()
                        SELECT cursor_4c_Correcoes
                    ENDSCAN
                ELSE
                    *-- Legado: o aviso existe SO no Get_NotaIni.Valid - o Init
                    *-- abre a grade vazia sem avisar nada
                    IF loc_lAvisar
                        MsgAviso("Nota sem Corre" + CHR(231) + CHR(227) + "o !!", "")
                    ENDIF
                ENDIF
            ENDIF

            *-- "Select XCorNf / Go Top / ThisForm.Refresh"
            THIS.AtualizarGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lTemCorrecao
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarGrade - METODO UNICO de repintura da grade, equivalente ao
    * "Select XCorNf / Go Top In XCorNf / ThisForm.Grade.Refresh" do legado.
    *
    * Popular o cursor NAO repinta a grade: sem GO TOP + Refresh explicitos a
    * grade fica visualmente VAZIA com o cursor cheio, e o sintoma ("a tela
    * nao traz dados") manda o diagnostico para SQL/cursor/permissao. Por isso
    * mora num metodo unico, chamado em TODO caminho que popula o cursor
    * (CarregarDados agora; o Valid da Nota e o Ok.Click nas Fases 7-8).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarGrade()
        IF USED("cursor_4c_Ocorrencias")
            SELECT cursor_4c_Ocorrencias
            GO TOP IN cursor_4c_Ocorrencias
        ENDIF

        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Refresh()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - FUNIL de carga da unica lista deste form: a grade de
    * ocorrencias da Carta de Correcao (SIGOPCCO.Grade, ligada ao cursor local
    * XCorNf no legado). Nao ha Page1=Lista/Page2=Dados aqui - a "lista" desta
    * tela e essa grade, e e ela que o PROCEDURE Init legado popula.
    *
    * Sequencia do funil: FormParaBO (tela -> BO, resolvendo a nota corrente)
    * -> CarregarDados (os dois Scan do legado) -> AtualizarGrade (GO TOP +
    * Refresh, feito no fim do proprio CarregarDados). Sem aviso de "Nota sem
    * Correcao": esse MessageBox existe SO no Get_NotaIni.Valid do legado, e o
    * Init abre a grade vazia em silencio - por isso par_lAvisarSemRegistro
    * vai .F. aqui.
    *
    * PUBLIC (nao PROTECTED) de proposito: o harness de teste automatico
    * chama THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS nao
    * verifica escopo - um PROTECTED aqui passaria pelo IF do teste e falharia
    * em runtime (regra CLAUDE.md #3).
    *
    * Retorno: .T. quando a nota tem retificacao gravada (grade populada),
    * .F. quando nao tem - mesmo criterio de CarregarDados.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.

        IF THIS.FormParaBO()
            loc_lSucesso = THIS.CarregarDados(THIS.this_oBusinessObject.this_cNfis, .F.)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - transferencia TELA -> BO. Reproduz o bloco de atribuicoes
    * do PROCEDURE Init legado, que nao tem esse nome mas e exatamente isto:
    *
    *   ThisForm.Emp      = Emp
    *   ThisForm.Serie    = Serie
    *   ThisForm.EmisDe   = EmisDe
    *   ThisForm.EmisAte  = EmisAte
    *   ThisForm.pcNFisDe = NFis
    *
    * mais a LINHA CORRENTE da grade, que e a ficha editavel desta tela: o
    * Ok.Click legado le XCorNf.Cods/XCorNf.Retifs para montar cada
    * "Insert Into crSigNfCor (... nOccors, mRetifs ...)".
    *
    * A nota tem DUAS fontes conforme o momento: o campo da tela quando ele
    * ja existe (fonte unica a partir dai - inclusive quando o Valid o zera
    * por "Nota sem Correcao", caso em que o branco e o estado REAL e tem de
    * chegar ao BO para o Ok.Click recusar com "Nota Fiscal Invalida !!") e o
    * parametro recebido do form chamador na 1a passagem, chamada pelo
    * InicializarForm antes de ConfigurarCampoNota criar o TextBox.
    *
    * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED e
    * VFP9 nao permite ALARGAR o escopo de metodo herdado.
    *
    * Retorno: .F. quando o BO nao esta instanciado (nada a transferir).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                WITH THIS.this_oBusinessObject
                    *-- Contexto recebido do form chamador (repassado tal qual
                    *-- a impressao da correcao o espera)
                    .this_cEmps    = THIS.this_cEmps
                    .this_cSeries  = THIS.this_cSeries
                    .this_dEmisDe  = THIS.this_dEmisDe
                    .this_dEmisAte = THIS.this_dEmisAte

                    *-- Nota fiscal: o campo da tela manda quando existe
                    IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
                        .this_cNfis = ALLTRIM(THIS.txt_4c_NotaIni.Value)
                    ELSE
                        .this_cNfis = ALLTRIM(THIS.this_cNfis)
                    ENDIF

                    *-- Linha corrente da grade (XCorNf.Cods/Retifs do legado).
                    *-- Grade vazia ou cursor no fim: zera, para o BO nao
                    *-- carregar a ocorrencia da leitura anterior.
                    IF USED("cursor_4c_Ocorrencias") AND !EOF("cursor_4c_Ocorrencias") ;
                       AND RECCOUNT("cursor_4c_Ocorrencias") > 0
                        .this_nNoccors = cursor_4c_Ocorrencias.cods
                        .this_cMretifs = TratarNulo(cursor_4c_Ocorrencias.retifs, "")
                    ELSE
                        .this_nNoccors = 0
                        .this_cMretifs = ""
                    ENDIF
                ENDWITH

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em FormParaBO")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - transferencia BO -> TELA, o inverso de FormParaBO:
    *
    *   1) nota fiscal   -> txt_4c_NotaIni ("ThisForm.Get_NotaIni.Value = NFis"
    *      do PROCEDURE Init legado);
    *   2) retificacao   -> linha da grade correspondente a ocorrencia do BO,
    *      que e o 2o Scan do Init/Valid legado aplicado a UMA linha:
    *          If Seek(CrSigNfCor.noccors,'XCorNf.cods','cods')
    *              Replace XCorNf.retifs With CrSigNfCor.mretifs
    *          EndIf
    *
    * Com this_nNoccors = 0 (nenhuma ocorrencia carregada) o passo 2 nao faz
    * nada - e o estado logo apos o Zap da grade.
    *
    * NAO repinta: quem chama e que fecha com AtualizarGrade (um Refresh por
    * linha dentro do Scan de CarregarDados seria desperdicio puro).
    *
    * PROTECTED obrigatoriamente, pelo mesmo motivo de FormParaBO (FormBase
    * declara o hook PROTECTED e VFP9 nao permite alargar escopo herdado).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lSucesso, loc_oErro, loc_cNfis, loc_nNoccors, loc_cMretifs

        loc_lSucesso = .F.

        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                *-- Valores em LOCAL, nao ".prop" solto dentro de WITH: os dois
                *-- usos abaixo entram em comando xBase (REPLACE ... WITH) e em
                *-- argumento de funcao, onde ler o membro antes evita qualquer
                *-- duvida de escopo (regra CLAUDE.md #33 - WITH aninhado
                *-- sequestra a resolucao do ponto).
                loc_cNfis    = ALLTRIM(THIS.this_oBusinessObject.this_cNfis)
                loc_nNoccors = THIS.this_oBusinessObject.this_nNoccors
                loc_cMretifs = THIS.this_oBusinessObject.this_cMretifs

                IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
                    THIS.txt_4c_NotaIni.Value = loc_cNfis
                ENDIF

                IF loc_nNoccors > 0 AND USED("cursor_4c_Ocorrencias")
                    IF SEEK(loc_nNoccors, "cursor_4c_Ocorrencias", "cods")
                        REPLACE retifs WITH loc_cMretifs IN cursor_4c_Ocorrencias
                    ENDIF
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro em BOParaForm")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - fonte unica da limpeza da tela, transcrita do ramo Else
    * do Get_NotaIni.Valid legado (nota sem correcao gravada):
    *
    *   This.Value = ''
    *   This.Refresh
    *   Select XCorNf
    *   Zap
    *   ThisForm.Grade.Refresh
    *
    * O Zap e o Refresh sao idempotentes: CarregarDados ja esvaziou e
    * repintou a grade antes de cair no ramo sem registro, e repetir aqui
    * mantem o metodo correto tambem se ele for chamado de outro caminho.
    * Zap (nao USE IN + CREATE CURSOR) de proposito - derrubar o alias
    * quebraria RecordSource/ControlSource/CurrentControl da grade.
    *
    * PROTECTED obrigatoriamente: FormBase declara este hook PROTECTED e
    * VFP9 nao permite ALARGAR o escopo de metodo herdado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparCampos()
        IF PEMSTATUS(THIS, "txt_4c_NotaIni", 5)
            THIS.txt_4c_NotaIni.Value = ""
            THIS.txt_4c_NotaIni.Refresh()
        ENDIF

        IF USED("cursor_4c_Ocorrencias")
            SELECT cursor_4c_Ocorrencias
            ZAP
        ENDIF

        THIS.AtualizarGrade()
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - equivalente ao "PROCEDURE Release" implicito do legado.
    * Fecha o cursor local de ocorrencias (cursor_4c_Ocorrencias, criado em
    * CriarCursorOcorrencias/ConfigurarGrade) para nao vazar work area entre
    * aberturas sucessivas do dialogo.
    * DODEFAULT() e a ULTIMA linha, obrigatoriamente: FormBase.Destroy faz o
    * SET SYSMENU TO DEFAULT + RELEASE POPUP + CriarMenuPrincipal() que repoe
    * os pads do menu principal depois de uma tela modal fechar.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Ocorrencias")
            USE IN cursor_4c_Ocorrencias
        ENDIF

        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - torna todos os controles visiveis
    * recursivamente. FILTRO: nenhum container flutuante neste form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl

        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

ENDDEFINE
