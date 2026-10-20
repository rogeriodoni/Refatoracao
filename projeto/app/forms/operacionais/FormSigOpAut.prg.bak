*==============================================================================
* FormSigOpAut.prg
* Form OPERACIONAL: Autenticacao de comprovantes de pagamento/cheque
* (SigOpAut.SCX migrado) - dialogo MODAL aberto por outro form (caixa/PDV)
* antes de liberar o movimento.
*
* Legado (Init): Lparameters poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica
* Uso canonico:
*   loForm = CREATEOBJECT("FormSigOpAut", THISFORM, cEmps, cDopes, nNumes, ;
*       lTipoPec, nTipoAutentica)
*   IF VARTYPE(loForm) = "O"
*       loForm.Show()
*   ENDIF
*
* Layout: form PLANO, sem PageFrame - o SCX legado nao tem PageFrame algum
* (cntSombra + Grd + TxtObs + botoes soltos direto na form). Ver padrao em
* Formale.prg/FormFpN.prg (dialogos OPERACIONAL planos).
*
* Fase 4/8 - Grid (Grd -> grd_4c_Dados, vinculado ao cursor local
* cursor_4c_Pagamentos, mesma estrutura de SigOpAutBO.this_cCursorPagamentos),
* os 3 botoes standalone do legado (Grade/Imprimir/Sair -> cmd_4c_Grade/
* cmd_4c_Fwbtnm1/cmd_4c_Sair) e a carga de dados (CarregarDados/VincularGrade,
* equivalentes ao bloco de consulta do Init legado). O legado NAO tem botoes
* CRUD (Incluir/Alterar/Excluir/Buscar) - este dialogo so marca linhas de
* pagamento/parcela para autenticar e imprime o comprovante.
*
* Fase 5/8 - Campo de observacao (Say6/TxtObs -> lbl_4c_Label6/txt_4c_TxtObs).
*
* Fase 6/8 - Controle OLE restante do dump (OleComm -> obj_4c_OleComm, porta
* serial da impressora de cheque/fiscal usada dentro de autentica()). SEM
* LOOKUPS: o form NAO tem nenhum CreateObject('fwbuscaext'/'fwBuscaSel'),
* sigacess() nem Seek em tabela auxiliar no codigo fonte original (SigOpAut e
* um dialogo modal de marcacao/autenticacao, nao um cadastro) - varredura
* integral de SigOpAut_form_codigo_fonte.txt confirma isso, entao esta
* fase nao tem nenhum AbrirLookupXxx/BtnXxxLookupKeyPress/DblClick.
*
* Fase 7/8 - Eventos principais dos 3 botoes standalone (BtnGradeClick/
* BtnImprimirClick/BtnSairClick, ligados por BINDEVENT em ConfigurarBotoes),
* Form.KeyPress (F2 -> Imprimir, F3 -> Grade) e o metodo Autentica() (envio
* do texto de autenticacao a impressora fiscal/cheque). Este dialogo NAO tem
* botoes CRUD (Incluir/Alterar/Visualizar/Excluir) - nenhum existe no
* legado, e nao ha o que mapear para eles; ver comentario acima (linhas
* 19-25) e tasks\task644\SigOpAut_form_codigo_fonte.txt. As chamadas de
* hardware que o legado faz via funcoes globais do Fortyus sem acervo
* (LeituraFab/fDecriptografar/ImpVerso/ReAutentica/Autentica-global) tem
* wrapper em utils\ (regra CLAUDE.md #13/#27); o ramo da impressora de
* CHEQUE (porta serial via obj_4c_OleComm) foi portado por completo, sem
* depender de nenhuma funcao externa.
*
* Fase 8/8 - Consolidacao: par FormParaBO/BOParaForm ligando a UNICA
* superficie editavel do legado (TxtObs -> SigOpAutBO.this_cObservacao, mais
* a linha corrente da grade via SigOpAutBO.CarregarDoCursor). Antes desta
* fase this_cObservacao estava declarada no BO e NUNCA era escrita nem lida:
* Autentica() lia THIS.txt_4c_TxtObs.Value direto, e o zeramento do campo no
* fim do Init escrevia no controle - duas fontes para o mesmo dado. Agora o
* BO eh a fonte unica nos dois sentidos.
*
* Os outros nomes canonicos de consolidacao do pipeline NAO se aplicam a este
* legado, e inventa-los violaria o PILAR 1 ("NUNCA inventar") ou produziria
* metodo vazio (proibido pela regra de completude). O SCX legado nao tem
* PageFrame, nao tem modo de edicao e tem exatamente 3 botoes (Grade/
* Imprimir/Encerrar); por isso os botoes CRUD (Incluir/Alterar/Visualizar/
* Excluir/Buscar) e o par Salvar/Cancelar da Page2 de Dados ficam fora do
* escopo desta tela. A grade EH carregada, so que pelo metodo unico
* CarregarDados() desta tela (que reproduz o bloco de consulta do Init
* legado e roda na abertura, nao atraves de um botao de busca separado).
* Tambem nao ha habilitar/limpar campos por modo, porque esta tela nao
* tem modo algum: o unico campo digitavel eh zerado por BOParaForm no
* fim do Init.
*==============================================================================

DEFINE CLASS FormSigOpAut AS FormBase

    *-- Propriedades visuais (PILAR 1: identico ao legado SigOpAut.SCX)
    Width        = 800
    Height       = 364
    AutoCenter   = .T.
    Caption      = "Autentica" + CHR(231) + CHR(227) + "o"
    ShowWindow   = 1
    WindowType   = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.
    TitleBar     = 0
    BorderStyle  = 2
    KeyPreview   = .T.
    ShowTips     = .T.
    ClipControls = .F.

    *-- Referencia ao form pai (legado "ThisForm.Parentform") - da acesso a
    *-- poDataMgr/oModemEest/TemAutentica usados nos eventos (Fase 7/8)
    this_oParentForm = .NULL.

    *-- Referencia ao modem/porta serial do form pai (legado "Thisform.oModem
    *-- = ThisForm.Parentform.oModemEest"), usada so no metodo Autentica (Fase 8)
    this_oModem = .NULL.

    *-- Parametros escalares equivalentes ao Init legado (repassados ao BO em
    *-- InicializarForm): _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica
    this_cEmps          = ""
    this_cDopes         = ""
    this_nNumes         = 0
    this_lTipoPec       = .F.
    this_nTipoAutentica = 0

    *--------------------------------------------------------------------------
    * Init - Recebe os mesmos parametros do Init legado (poform, _pEmps,
    * _pDopes, _pNumes, _pTipo, _pnAutentica). Armazena as referencias de UI
    * (ParentForm/oModem) e os escalares ANTES de DODEFAULT() - FormBase.Init()
    * chama InicializarForm(), que ja usa esses valores para criar o SigOpAutBO.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_oParentForm, par_cEmps, par_cDopes, par_nNumes, ;
            par_lTipoPec, par_nTipoAutentica)
        LOCAL loc_lSucesso

        IF VARTYPE(par_oParentForm) = "O"
            THIS.this_oParentForm = par_oParentForm
            IF PEMSTATUS(par_oParentForm, "oModemEest", 5)
                THIS.this_oModem = par_oParentForm.oModemEest
            ENDIF
        ENDIF

        THIS.this_cEmps          = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
        THIS.this_cDopes         = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
        THIS.this_nNumes         = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
        THIS.this_lTipoPec       = IIF(VARTYPE(par_lTipoPec) = "L", par_lTipoPec, .F.)
        THIS.this_nTipoAutentica = IIF(VARTYPE(par_nTipoAutentica) = "N", par_nTipoAutentica, 0)

        loc_lSucesso = DODEFAULT()

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Cria o Business Object com os escalares recebidos no
    * Init, monta a estrutura visual (cabecalho, grade, botoes) e faz a carga
    * da grade, na mesma ordem do Init legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigOpAutBO", ;
                THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
                THIS.this_lTipoPec, THIS.this_nTipoAutentica)

            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                THIS.ConfigurarPageFrame()
                THIS.ConfigurarCabecalho()

                THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
                THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption

                *-- Grid e botoes criados DEPOIS do cabecalho: os botoes
                *-- (Top=3..78) ficam DENTRO da faixa (Height=80) e precisam
                *-- desenhar por cima dela (regra CLAUDE.md #11/#31).
                THIS.ConfigurarGrid()
                THIS.ConfigurarBotoes()
                THIS.ConfigurarCampos()

                THIS.TornarControlesVisiveis(THIS)

                *-- Carga da grade por ULTIMO, com os controles ja visiveis -
                *-- mesma posicao que o bloco de consulta ocupa no Init legado.
                *-- Devolve .F. quando nao sobrou linha para autenticar, o que
                *-- reproduz o "If Reccount() = 0 / ThisForm.Release /
                *-- Return .F." do legado: InicializarForm .F. faz o
                *-- CREATEOBJECT devolver .F. e a tela nao abre.
                loc_lSucesso = THIS.CarregarDados()

                *-- Regra de exibicao do campo Observacao: ULTIMO bloco do Init
                *-- legado, logo depois do vinculo da grade. So faz sentido
                *-- quando a tela vai mesmo abrir - com zero linha para
                *-- autenticar o legado da Release e nunca chega aqui.
                IF loc_lSucesso
                    THIS.AplicarRegraVisibilidadeObs()
                ENDIF
            ELSE
                MsgErro("Erro ao criar Business Object de Autentica" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpAut")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - SigOpAut legado NAO TEM PageFrame: layout PLANO
    * com fundo new_background.jpg (Picture do dump), igual ao padrao de
    * dialogos OPERACIONAL pequenos sem abas (ver Formale.prg/FormFpN.prg).
    * Mantido so para configurar a aparencia base do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
        THIS.SetAll("FontName", "Tahoma")
        THIS.SetAll("FontSize", 8)
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container header cinza (cntSombra do legado)
    * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
    * BackColor=100,100,100; lblSombra/lblTitulo Top=18/17, Left=10,
    * Width=769 (= THIS.Width - 21), ForeColor preto/branco, FontSize=18.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cnt_4c_Cabecalho", "Container")
            WITH THIS.cnt_4c_Cabecalho
                .Top         = 0
                .Left        = 0
                .Width       = THIS.Width
                .Height      = 80
                .BackStyle   = 1
                .BackColor   = RGB(100, 100, 100)
                .BorderWidth = 0
                .Visible     = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
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
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(0, 0, 0)
                .Visible       = .T.
            ENDWITH

            THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
            WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
                .FontBold      = .T.
                .FontName      = "Tahoma"
                .FontSize      = 18
                .WordWrap      = .T.
                .Alignment     = 0
                .BackStyle     = 0
                .AutoSize      = .F.
                .Caption       = THIS.Caption
                .Height        = 46
                .Left          = 10
                .Top           = 17
                .Width         = THIS.Width - 21
                .ForeColor     = RGB(255, 255, 255)
                .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
                .Visible       = .T.
            ENDWITH
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarCabecalho")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarGrid - Grd legado (sem PageFrame, filho direto do form):
    * ColumnCount=3, Column1=Check1 (Marca), Column2/Column3=Text1 (Obs/Fpags),
    * os dois ultimos ReadOnly. Cria o cursor cursor_4c_Pagamentos com a MESMA
    * estrutura/ordem de campos de SigOpAutBO.this_cCursorPagamentos (regra
    * CLAUDE.md: CREATE CURSOR identico em todo lugar onde o mesmo alias
    * aparece) - equivale ao Load legado:
    *   Create Cursor csPgto (Marca L, Obs C(27), fpags C(12), Printed L,
    *                         Autenticas n(1))
    *
    * Aqui ficam SO as propriedades de desenho do Grd (as que nao dependem do
    * cursor). O vinculo (ColumnCount/RecordSource/ControlSource/Width/
    * CurrentControl) mora em VincularGrade(), porque tambem tem de rodar
    * DEPOIS de cada carga de dados.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarGrid()
        LOCAL loc_oErro
        TRY
            IF !USED("cursor_4c_Pagamentos")
                CREATE CURSOR cursor_4c_Pagamentos (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
            ENDIF

            THIS.AddObject("grd_4c_Dados", "Grid")
            WITH THIS.grd_4c_Dados
                .Top               = 85
                .Left              = 12
                .Width             = 527
                .Height            = 228
                .TabIndex          = 1
                .FontName          = "Tahoma"
                .FontSize          = 8
                .AllowHeaderSizing = .F.
                .AllowRowSizing    = .F.
                .DeleteMark        = .F.
                .RecordMark        = .F.
                .RowHeight         = 16
                .ScrollBars        = 2
                *-- O dump do SCX traz "SplitBar = .F.", mas Grid.SplitBar eh
                *-- READ-ONLY em runtime (medido no VFP9: "Property SPLITBAR
                *-- is read-only") - atribuir aborta o resto deste WITH dentro
                *-- do TRY e as propriedades seguintes somem em silencio. O
                *-- default ja eh .F. sem split, entao omitir eh fiel.
                .Panel             = 1
                .GridLineColor     = RGB(238, 238, 238)
                *-- Grid.ReadOnly ANTES do ReadOnly de cada Column (regra
                *-- CLAUDE.md #18/#46): o do Grid propaga e sobrescreve o das
                *-- colunas. No legado so Column2/Column3 sao ReadOnly;
                *-- Column1 (Marca) tem de aceitar o clique do usuario.
                .ReadOnly          = .F.
                .Visible           = .T.
            ENDWITH

            THIS.VincularGrade()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarGrid")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * VincularGrade - (Re)vincula grd_4c_Dados ao cursor_4c_Pagamentos.
    * Legado (fim do Init):
    *   With ThisForm.Grd
    *       .RecordSource          = 'csPgto'
    *       .RecordSourceType      = 1
    *       .Column1.ControlSource = 'csPgto.marca'
    *       .Column2.ControlSource = 'csPgto.Obs'
    *       .Column3.ControlSource = 'csPgto.fPags'
    *       .Refresh
    *   EndWith
    *
    * PUBLIC e idempotente de proposito: SigOpAutBO.PopularCursorPagamentos()
    * faz USE IN + CREATE CURSOR no alias da grade, e derrubar o alias leva o
    * Grid a ColumnCount = 0 - retangulo branco sem cabecalho, sem erro e sem
    * log, morto pelo resto da vida do form. Por isso TODO caminho que popula
    * o cursor chama este metodo depois. O CheckBox da Column1 tambem eh
    * reinstalado aqui, porque reconstruir o ColumnCount cria objetos Column
    * novos (CurrentControl volta a "Text1").
    *
    * Ordem obrigatoria: ColumnCount -> RecordSource -> ControlSource ->
    * Width/Header (RecordSource recalcula as larguras para o default 90) e,
    * na Column1, AddObject -> propriedades do CheckBox -> CurrentControl ->
    * ControlSource por ULTIMO (ControlSource antes do AddObject dispara o
    * erro 1767).
    *--------------------------------------------------------------------------
    PROCEDURE VincularGrade()
        LOCAL loc_oErro, loc_oGrd, loc_lOk
        loc_lOk = .F.

        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Pagamentos")
                loc_oGrd = THIS.grd_4c_Dados

                *-- ColumnCount so eh reatribuido quando difere do esperado:
                *-- REDUZIR destroi os controles postos por AddObject nas
                *-- Columns (medido no VFP9); subir de 0 - que eh o estado
                *-- depois do alias ser derrubado - eh justamente o caso que
                *-- este metodo existe para consertar. Vem ANTES do
                *-- RecordSource para o VFP nao auto-expandir a grade para as
                *-- 5 colunas do cursor.
                IF loc_oGrd.ColumnCount != 3
                    loc_oGrd.ColumnCount = 3
                ENDIF

                loc_oGrd.RecordSourceType = 1
                loc_oGrd.RecordSource     = ""
                loc_oGrd.ColumnCount = 3
                loc_oGrd.RecordSource     = "cursor_4c_Pagamentos"

                *-- Column1 - Check1 do legado (csPgto.marca), coluna de marcacao
                loc_oGrd.Column1.FontSize  = 8
                loc_oGrd.Column1.Movable   = .F.
                loc_oGrd.Column1.Resizable = .F.
                loc_oGrd.Column1.Alignment = 0
                loc_oGrd.Column1.Enabled   = .T.
                loc_oGrd.Column1.ReadOnly  = .F.
                *-- Sparse = .F.: sem isto o CheckBox so desenha na linha
                *-- corrente e as outras exibem 0/1 como texto, sem clique.
                loc_oGrd.Column1.Sparse    = .F.

                IF !PEMSTATUS(loc_oGrd.Column1, "chk_4c_Marca", 5)
                    loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
                ENDIF

                *-- Caption/Alignment/ReadOnly/Visible explicitos: CheckBox de
                *-- Column renderiza mas NAO responde ao clique sem eles. Os
                *-- valores do SCX (Top=23/Left=25/60x17/Caption="Check1") sao
                *-- sobras do Form Designer - nao cabem na coluna de 17px do
                *-- proprio dump e nunca renderizaram. A geometria abaixo eh a
                *-- canonica do projeto; medido no VFP9, o Grid REFLUI o
                *-- CurrentControl para o tamanho da celula (fica 10x10 nesta
                *-- coluna), entao ela serve de piso e nao de posicao final.
                loc_oGrd.Column1.chk_4c_Marca.Caption   = ""
                loc_oGrd.Column1.chk_4c_Marca.Alignment = 0
                loc_oGrd.Column1.chk_4c_Marca.ReadOnly  = .F.
                loc_oGrd.Column1.chk_4c_Marca.Visible   = .T.
                loc_oGrd.Column1.chk_4c_Marca.Top       = 9
                loc_oGrd.Column1.chk_4c_Marca.Left      = 2
                loc_oGrd.Column1.chk_4c_Marca.Height    = 17
                loc_oGrd.Column1.chk_4c_Marca.Width     = 22

                loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
                loc_oGrd.Column1.ControlSource  = "cursor_4c_Pagamentos.Marca"

                *-- Column2 - Text1 do legado (csPgto.Obs), ReadOnly/ColumnOrder=3
                loc_oGrd.Column2.FontSize      = 8
                loc_oGrd.Column2.Movable       = .F.
                loc_oGrd.Column2.Resizable     = .F.
                loc_oGrd.Column2.ControlSource = "cursor_4c_Pagamentos.Obs"
                loc_oGrd.Column2.ReadOnly      = .T.
                loc_oGrd.Column2.Text1.FontSize    = 8
                loc_oGrd.Column2.Text1.BorderStyle = 0
                loc_oGrd.Column2.Text1.Margin      = 0
                loc_oGrd.Column2.Text1.ReadOnly    = .T.
                loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
                loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)

                *-- Column3 - Text1 do legado (csPgto.fPags), ReadOnly/ColumnOrder=2
                loc_oGrd.Column3.FontSize      = 8
                loc_oGrd.Column3.ControlSource = "cursor_4c_Pagamentos.Fpags"
                loc_oGrd.Column3.ReadOnly      = .T.
                loc_oGrd.Column3.Text1.FontSize    = 8
                loc_oGrd.Column3.Text1.BorderStyle = 0
                loc_oGrd.Column3.Text1.Margin      = 0
                loc_oGrd.Column3.Text1.ReadOnly    = .T.
                loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
                loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)

                *-- Width/Header DEPOIS do RecordSource e dos ControlSource,
                *-- senao o VFP devolve as larguras para o default 90
                loc_oGrd.Column1.Width = 17
                loc_oGrd.Column2.Width = 382
                loc_oGrd.Column3.Width = 94

                *-- Headers sem texto no legado (Caption = "", Alignment = 2)
                loc_oGrd.Column1.Header1.FontSize  = 8
                loc_oGrd.Column1.Header1.Alignment = 2
                loc_oGrd.Column1.Header1.Caption   = ""
                loc_oGrd.Column2.Header1.FontSize  = 8
                loc_oGrd.Column2.Header1.Alignment = 2
                loc_oGrd.Column2.Header1.Caption   = ""
                loc_oGrd.Column3.Header1.FontSize  = 8
                loc_oGrd.Column3.Header1.Alignment = 2
                loc_oGrd.Column3.Header1.Caption   = ""

                *-- Ordem visual do SCX: Marca, Fpags, Obs (Column2.ColumnOrder
                *-- = 3 e Column3.ColumnOrder = 2 no dump). ColumnOrder por
                *-- ultimo, porque reordenar reposiciona as colunas irmas.
                loc_oGrd.Column3.ColumnOrder = 2
                loc_oGrd.Column2.ColumnOrder = 3

                *-- Popular cursor NAO repinta a grade (regra CLAUDE.md #21):
                *-- o legado fecha com Select csPgto / Go Top / .Refresh
                SELECT cursor_4c_Pagamentos
                GO TOP
                loc_oGrd.Refresh()

                *-- Os 4 handlers do CheckBox sao (re)ligados AQUI, e nao no
                *-- InicializarForm: reconstruir o ColumnCount destroi os
                *-- objetos Column e leva o chk_4c_Marca junto, e com ele os
                *-- BINDEVENT. Ligados uma unica vez na inicializacao, o
                *-- CheckBox ficaria inerte depois da primeira recarga.
                THIS.LigarEventosGrade()

                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.VincularGrade")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * LigarEventosGrade - Liga os 4 handlers do CheckBox da Column1.
    *
    * CheckBox de Column NAO alterna pelo binding nativo: ele renderiza, recebe
    * foco e ignora o clique. O legado tambem nao usa o toggle padrao - ele
    * escreve o valor por codigo no Click. Por isso os quatro eventos vao
    * juntos: KeyPress/MouseUp executam a marcacao, e Click/MouseDown existem
    * so para SUPRIMIR o toggle nativo com NODEFAULT (sem eles o valor alterna
    * duas vezes e volta ao que era).
    *
    * UNBINDEVENT antes de religar: VincularGrade eh idempotente e roda a cada
    * recarga do cursor; sem isso as ligacoes se ACUMULAM no mesmo objeto e um
    * unico clique dispararia o handler N vezes, alternando a marca N vezes.
    *
    * PEMSTATUS ANINHADO, nao com AND: VFP9 nao faz short-circuit, entao
    * "PEMSTATUS(THIS, 'grd_4c_Dados', 5) AND PEMSTATUS(THIS.grd_4c_Dados...)"
    * avaliaria o segundo lado mesmo sem a grade existir.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LigarEventosGrade()
        LOCAL loc_oChk, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Marca", 5)
                    loc_oChk = THIS.grd_4c_Dados.Column1.chk_4c_Marca

                    UNBINDEVENT(loc_oChk)

                    BINDEVENT(loc_oChk, "KeyPress",  THIS, "ChkMarcaKeyPress")
                    BINDEVENT(loc_oChk, "MouseUp",   THIS, "ChkMarcaMouseUp")
                    BINDEVENT(loc_oChk, "MouseDown", THIS, "ChkMarcaMouseDown")
                    BINDEVENT(loc_oChk, "Click",     THIS, "ChkMarcaClick")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpAut.LigarEventosGrade")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarMarcacaoLinha - Regra de marcacao da linha corrente da grade.
    *
    * Legado (SIGOPAUT.Grd.Column1.Check1.Click), transcrito:
    *     if !(csPgto.printed)
    *         This.value = .t.
    *     endif
    *
    * O Click legado roda DEPOIS do toggle nativo do CheckBox (nao ha NoDefault
    * la), entao o efeito observavel eh:
    *   - linha ainda NAO autenticada (Printed = .F.) -> volta sempre para
    *     marcada; o usuario NAO consegue desmarcar o que ainda falta
    *     autenticar. Eh o par do guard do botao Encerrar, que recusa fechar a
    *     tela enquanto houver linha nao autenticada.
    *   - linha JA autenticada (Printed = .T.) -> o toggle vale, permitindo
    *     marcar de novo para reautenticar.
    * Aqui o toggle nativo foi suprimido (NODEFAULT nos handlers), entao ele eh
    * refeito explicitamente ANTES da regra - o resultado final eh identico.
    *
    * Marca e Printed sao LOGICOS no cursor (legado: "Create Cursor csPgto
    * (Marca L, Obs C(27), fpags C(12), Printed L, Autenticas n(1))"), por isso
    * a alternancia eh "!valor" e NAO o IIF(col = 0, 1, 0) usado quando a
    * coluna de marcacao eh numerica.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarMarcacaoLinha()
        LOCAL loc_oErro

        TRY
            IF USED("cursor_4c_Pagamentos")
                SELECT cursor_4c_Pagamentos
                IF !EOF("cursor_4c_Pagamentos") AND !BOF("cursor_4c_Pagamentos")
                    REPLACE cursor_4c_Pagamentos.Marca ;
                        WITH !cursor_4c_Pagamentos.Marca

                    IF !cursor_4c_Pagamentos.Printed
                        REPLACE cursor_4c_Pagamentos.Marca WITH .T.
                    ENDIF

                    IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                        THIS.grd_4c_Dados.Refresh()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpAut.ValidarMarcacaoLinha")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaKeyPress - Espaco/Enter marcam a linha, igual ao clique.
    * Assinatura COMPLETA obrigatoria: handler ligado a KeyPress sem os dois
    * parametros estoura a cada tecla (regra CLAUDE.md #3).
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF INLIST(par_nKeyCode, 13, 32)
            THIS.ValidarMarcacaoLinha()
            NODEFAULT
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseUp - Clique do mouse: mesma acao da tecla.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        THIS.ValidarMarcacaoLinha()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaMouseDown - Existe so para suprimir o toggle nativo do CheckBox.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkMarcaClick - Existe so para suprimir o toggle nativo do CheckBox.
    *--------------------------------------------------------------------------
    PROCEDURE ChkMarcaClick()
        NODEFAULT
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarRegraVisibilidadeObs - Regra de exibicao do campo Observacao.
    *
    * Legado (ultimo bloco do Init, depois do vinculo da grade):
    *     If InList(CrSigFiFis.Imps,'BEMA8501','EPSON')
    *         .txtObs.Visible = .f.
    *     Else
    *         .txtObs.value = ""
    *         .Refresh
    *         .txtObs.SetFocus
    *     Endif
    *
    * Nessas duas impressoras a observacao nao vai para o papel, entao o campo
    * some. O legado esconde SOMENTE o TextBox e deixa o rotulo "Observacao" na
    * tela - transcrito como esta (PILAR 1), sem estender a regra ao Label.
    *
    * Em modo de teste/validacao de UI nao se consulta a configuracao fiscal
    * (ObterModeloImpressoraFiscal instancia o FisBO e le o SetFiscal.Ini) nem
    * se da SetFocus: a tela nao chega a ser exibida e SetFocus em form nao
    * ativo dispara erro. Sem modelo, cai no ramo ELSE - que eh o estado padrao
    * do campo, criado visivel e vazio em ConfigurarCampos.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarRegraVisibilidadeObs()
        LOCAL loc_cModelo, loc_lInterativo, loc_oErro

        TRY
            IF PEMSTATUS(THIS, "txt_4c_TxtObs", 5)
                loc_lInterativo = (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste) ;
                    AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)

                loc_cModelo = ""
                IF loc_lInterativo
                    loc_cModelo = UPPER(ALLTRIM(THIS.ObterModeloImpressoraFiscal()))
                ENDIF

                IF INLIST(loc_cModelo, "BEMA8501", "EPSON")
                    THIS.txt_4c_TxtObs.Visible = .F.
                ELSE
                    THIS.txt_4c_TxtObs.Visible = .T.

                    *-- Legado: ".txtObs.value = ''". Quem zera eh o BO (fonte
                    *-- unica do texto de observacao) e o form so reflete, via
                    *-- BOParaForm - o mesmo par usado em Autentica no sentido
                    *-- oposto.
                    IF VARTYPE(THIS.this_oBusinessObject) = "O"
                        THIS.this_oBusinessObject.this_cObservacao = ""
                        THIS.BOParaForm()
                    ELSE
                        THIS.txt_4c_TxtObs.Value = ""
                    ENDIF

                    THIS.Refresh()

                    IF loc_lInterativo
                        THIS.txt_4c_TxtObs.SetFocus()
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em FormSigOpAut.AplicarRegraVisibilidadeObs")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarEstiloBotaoPadrao - Propriedades comuns aos 3 botoes standalone
    * (fwbtng/fwbtnm do legado, filhos diretos do form, fora de CommandGroup).
    * Themes=.T. + DisabledPicture (NUNCA Themes=.F. como nos Buttons(N) de
    * CommandGroup) para o icone renderizar - regra da memoria de botao
    * standalone com Picture.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarEstiloBotaoPadrao(par_oBtn, par_cPicture)
        WITH par_oBtn
            .FontName         = "Comic Sans MS"
            .FontBold          = .T.
            .FontItalic        = .T.
            .FontSize          = 8
            .ForeColor         = RGB(90, 90, 90)
            .BackColor         = RGB(255, 255, 255)
            .SpecialEffect     = 0
            .PicturePosition   = 13
            .MousePointer      = 15
            .WordWrap          = .T.
            .AutoSize          = .F.
            .Picture           = gc_4c_CaminhoIcones + par_cPicture
            .DisabledPicture   = gc_4c_CaminhoIcones + par_cPicture
            .Themes            = .T.
            .Enabled           = .T.
            .Visible           = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoes - 3 botoes standalone do legado (Top=3, Height=75,
    * Width=75, dentro da faixa do cabecalho - desenham por cima dela porque
    * sao criados DEPOIS). O legado NAO tem botoes CRUD: Grade foca a grade
    * (F3), Fwbtnm1 imprime/autentica (F2), Sair fecha o dialogo (Cancel=.T.).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoes()
        LOCAL loc_oErro
        TRY
            THIS.AddObject("cmd_4c_Grade", "CommandButton")
            WITH THIS.cmd_4c_Grade
                .Top         = 3
                .Left        = 573
                .Width       = 75
                .Height      = 75
                .Caption     = "\<Grade"
                .ToolTipText = "[F3] Grade"
            ENDWITH
            THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Grade, "geral_limpa_grade_60.jpg")

            THIS.AddObject("cmd_4c_Fwbtnm1", "CommandButton")
            WITH THIS.cmd_4c_Fwbtnm1
                .Top     = 3
                .Left    = 648
                .Width   = 75
                .Height  = 75
                .Caption = "\<Imprimir"
            ENDWITH
            THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Fwbtnm1, "geral_impressora_normal_60.jpg")

            THIS.AddObject("cmd_4c_Sair", "CommandButton")
            WITH THIS.cmd_4c_Sair
                .Top     = 3
                .Left    = 723
                .Width   = 75
                .Height  = 75
                .Cancel  = .T.
                .Caption = "Encerrar"
            ENDWITH
            THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Sair, "cadastro_sair_60.jpg")

            *-- Botoes criados com AddObject (classe generica CommandButton,
            *-- sem subclasse): o Click so eh alcancado via BINDEVENT, em
            *-- metodos PUBLIC do form (regra CLAUDE.md #3/#8).
            BINDEVENT(THIS.cmd_4c_Grade,   "Click", THIS, "BtnGradeClick")
            BINDEVENT(THIS.cmd_4c_Fwbtnm1, "Click", THIS, "BtnImprimirClick")
            BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "BtnSairClick")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarBotoes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCampos - Campo de observacao do legado (filho direto do form,
    * sem PageFrame): Say6 (label) + TxtObs (textbox), digitados pelo operador
    * e impressos no comprovante dentro de autentica() (Fase 7/8). Dump:
    *   Say6:   FontName=Tahoma, FontSize=8, Caption="Observacao", Left=12,
    *           Top=322, ForeColor=90,90,90 (classe say, sem Width/Alignment
    *           declarados - regra CLAUDE.md #23: AutoSize=.F. + Width que
    *           caiba o texto, Alignment=0)
    *   TxtObs: Left=12, Top=337, Width=430, Height=23, MaxLength=60
    *
    * O legado inicializa .txtObs.Value = "" e da SetFocus dentro do Init
    * (depois do bind da grade), e esconde o campo quando a impressora eh
    * BEMA8501/EPSON (If InList(CrSigFiFis.Imps,'BEMA8501','EPSON') / .txtObs.
    * Visible = .f.) - esse condicional pertence a CarregarDados/autentica
    * (Fase 7/8), que ja conhece o modelo da impressora fiscal via
    * ObterModeloImpressoraFiscal(). Aqui fica so a criacao do controle,
    * visivel por padrao.
    *
    * OleComm (Fase 6/8) - unico objeto do dump ainda sem equivalente no
    * migrado: controle OLE MSComm (porta serial), consumido dentro de
    * autentica() para falar com a impressora de cheque/Impressora Fiscal
    * (verso) quando o modelo NAO eh BEMA8501 (nesse ramo o legado cria o
    * proprio ThisForm.Parentform.oModemEest, que ja existe em
    * THIS.this_oModem). Dump: Top=91, Left=480, Width=100, Height=100, sem
    * Visible declarado (OLE control fica OCULTO - nao eh elemento de tela).
    * Mesmo padrao de obj_4c_OModem em FormSigReEch.prg: AddObject de
    * OLEControl TRAVA o VFP indefinidamente em ambiente sem o OCX
    * registrado/sem usuario, entao (a) nunca instanciar em modo teste/
    * validacao de UI e (b) envolver em TRY/CATCH proprio, sem abortar o
    * resto do form quando o MSComm nao estiver disponivel na maquina.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCampos()
        LOCAL loc_oErro, loc_oErroOle
        TRY
            THIS.AddObject("lbl_4c_Label6", "Label")
            WITH THIS.lbl_4c_Label6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .FontBold  = .F.
                .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
                .Left      = 12
                .Top       = 322
                .Width     = 100
                .Height    = 17
                .AutoSize  = .F.
                .Alignment = 0
                .BackStyle = 0
                .ForeColor = RGB(90, 90, 90)
                .TabIndex  = 5
                .Visible   = .T.
            ENDWITH

            THIS.AddObject("txt_4c_TxtObs", "TextBox")
            WITH THIS.txt_4c_TxtObs
                .Left      = 12
                .Top       = 337
                .Width     = 430
                .Height    = 23
                .MaxLength = 60
                .TabIndex  = 6
                .FontName  = "Tahoma"
                .FontSize  = 8
                .Value     = ""
                .Visible   = .T.
            ENDWITH

            *-- OLE MSComm (porta serial) - nao instanciar em modo teste:
            *-- AddObject de OLEControl trava indefinidamente sem usuario.
            IF (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste) AND ;
                    (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
                TRY
                    THIS.AddObject("obj_4c_OleComm", "OLEControl", "MSCommLib.MSComm")
                    WITH THIS.obj_4c_OleComm
                        .Top     = 91
                        .Left    = 480
                        .Width   = 100
                        .Height  = 100
                        .Visible = .F.
                    ENDWITH
                CATCH TO loc_oErroOle
                    MsgErro("OLE MSComm indispon" + CHR(237) + "vel: " + ;
                        loc_oErroOle.Message, "Aviso")
                ENDTRY
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDados - Carga da grade. Equivale ao bloco de consulta do Init
    * legado, transcrito do dump:
    *   =fLerFiscal() / Select CrSigFiFis / Goto top
    *   If Not _pTipo
    *       cursorquery('SigMvPar','CrTmpPar','EmpDopNums',lcEDN) + SigOpFp
    *   Else
    *       cursorquery('SigMvPec','CrTmpEstPe','EmpDopNums',lcEDN) + SigCdOpe
    *   EndIf
    *   If ( Alltrim(CrSigFiFis.Imps) = 'DARUMA' And _PnAutentica = 1 ) Or ;
    *      ( _PnAutentica <> 1 And Not ThisForm.ParentForm.TemAutentica )
    *       Zap
    *   EndIf
    *   Select csPgto / Go Top
    *   If Reccount() = 0 / ThisForm.Release / Return .F. / Endif
    *   With ThisForm / With .Grd / ... bind ... / EndWith / EndWith
    *
    * O SQL mora no BO (SigOpAutBO.PopularCursorPagamentos e
    * ZerarSeNaoRequerAutenticacao); no form ficam a leitura da configuracao
    * de hardware, a regra TemAutentica que vem do form pai, o revinculo da
    * grade e a decisao de nao abrir a tela.
    *
    * Retorna .F. quando nao sobrou linha alguma para autenticar: eh o
    * "ThisForm.Release + Return .F." do legado, propagado por InicializarForm
    * (CREATEOBJECT devolve .F. e a tela nao abre, sem mensagem - igual ao
    * legado, que fecha calado).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDados()
        LOCAL loc_oErro, loc_lOk, loc_oBO, loc_uTemAut
        loc_lOk = .F.

        TRY
            IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
                    (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
                *-- Sem conexao SQL em modo de teste/validacao de UI: a grade
                *-- fica com o cursor vazio criado em ConfigurarGrid e a tela
                *-- abre normalmente - nao ha o que consultar.
                THIS.VincularGrade()
                loc_lOk = .T.
            ELSE
                loc_oBO = THIS.this_oBusinessObject

                IF VARTYPE(loc_oBO) = "O"
                    *-- Legado: ThisForm.ParentForm.TemAutentica, lido dentro do
                    *-- teste de Zap. VARTYPE antes de atribuir porque a
                    *-- property do form pai pode vir Logica ou Numerica
                    *-- (comparar tipos diferentes estoura type mismatch).
                    IF VARTYPE(THIS.this_oParentForm) = "O" ;
                            AND PEMSTATUS(THIS.this_oParentForm, "TemAutentica", 5)
                        loc_uTemAut = THIS.this_oParentForm.TemAutentica
                        IF VARTYPE(loc_uTemAut) = "L"
                            loc_oBO.this_lTemAutentica = loc_uTemAut
                        ENDIF
                        IF VARTYPE(loc_uTemAut) = "N"
                            loc_oBO.this_lTemAutentica = (loc_uTemAut != 0)
                        ENDIF
                    ENDIF

                    IF loc_oBO.PopularCursorPagamentos()
                        *-- Legado: Zap quando a impressora eh DARUMA com
                        *-- _PnAutentica = 1, ou quando o form pai nao exige
                        *-- autenticacao
                        loc_oBO.ZerarSeNaoRequerAutenticacao(THIS.ObterModeloImpressoraFiscal())

                        *-- PopularCursorPagamentos faz USE IN + CREATE CURSOR
                        *-- no alias da grade: sem revincular, o Grid fica em
                        *-- ColumnCount = 0 e vira um retangulo branco
                        THIS.VincularGrade()

                        *-- Legado: If Reccount() = 0 / ThisForm.Release / Return .F.
                        loc_lOk = (RECCOUNT("cursor_4c_Pagamentos") > 0)
                    ELSE
                        IF !EMPTY(loc_oBO.this_cMensagemErro)
                            MsgErro(loc_oBO.this_cMensagemErro, ;
                                "Autentica" + CHR(231) + CHR(227) + "o")
                        ENDIF
                        loc_lOk = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.CarregarDados")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterModeloImpressoraFiscal - Legado (Init): "=fLerFiscal() / Select
    * CrSigFiFis / Goto top", consumido depois em Alltrim(CrSigFiFis.Imps).
    *
    * fLerFiscal() eh funcao global do Fortyus que NAO existe no acervo
    * portado - chama-la daria "File 'flerfiscal.prg' does not exist" em
    * runtime (nome desconhecido seguido de "(" nao eh erro de compilacao,
    * regra CLAUDE.md #13). O equivalente portado eh
    * FisBO.CarregarDeArquivo(), que le o mesmo SetFiscal.Ini e popula o mesmo
    * cursor CrSigFiFis; eh usado so quando o cursor ainda nao esta aberto,
    * para nao sobrescrever uma configuracao fiscal ja carregada por outra
    * tela.
    *
    * Modelo vazio apenas nao casa com o teste 'DARUMA' do legado - nao
    * impede autenticar.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterModeloImpressoraFiscal()
        LOCAL loc_cModelo, loc_oFis, loc_oErro
        loc_cModelo = ""

        TRY
            IF !USED("CrSigFiFis")
                loc_oFis = CREATEOBJECT("FisBO")
                IF VARTYPE(loc_oFis) = "O"
                    loc_oFis.CarregarDeArquivo()
                    loc_oFis = .NULL.
                ENDIF
            ENDIF

            IF USED("CrSigFiFis")
                SELECT CrSigFiFis
                GO TOP
                IF !EOF() AND VARTYPE(CrSigFiFis.Imps) = "C"
                    loc_cModelo = ALLTRIM(CrSigFiFis.Imps)
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a " + ;
                "configura" + CHR(231) + CHR(227) + "o da impressora fiscal:" + ;
                CHR(13) + loc_oErro.Message, ;
                "Autentica" + CHR(231) + CHR(227) + "o")
            loc_cModelo = ""
        ENDTRY

        RETURN loc_cModelo
    ENDPROC
    *--------------------------------------------------------------------------
    * TornarControlesVisiveis - Torna controles visiveis recursivamente
    * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
    * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
    * metodo fica generico para reaproveitar nas fases seguintes).
    *
    * EXCECAO por NOME: obj_4c_OleComm (controle OLE MSComm) fica de fora -
    * o dump do SCX nao declara Visible para ele (eh um controle funcional de
    * porta serial, nunca um elemento de tela) e forcar .Visible = .T. criaria
    * uma caixa OLE 100x100 em branco sobre a grade (Top=91/Left=480 cai
    * dentro da area do grd_4c_Dados). Mesmo padrao de exclusao por nome usado
    * para containers flutuantes (regra CLAUDE.md de TornarControlesVisiveis).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_nI, loc_oControl, loc_nP, loc_lExcluido

        IF VARTYPE(par_oContainer) != "O"
            RETURN
        ENDIF

        FOR loc_nI = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_nI)
            IF VARTYPE(loc_oControl) = "O"
                loc_lExcluido = INLIST(UPPER(loc_oControl.Name), "OBJ_4C_OLECOMM")

                IF PEMSTATUS(loc_oControl, "Visible", 5) AND !loc_lExcluido
                    loc_oControl.Visible = .T.
                ENDIF

                IF !loc_lExcluido
                    IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                        FOR loc_nP = 1 TO loc_oControl.PageCount
                            THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
                        ENDFOR
                    ENDIF

                    IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * KeyPress - Legado:
    *   Case nKeyCode = -1 && F2 / NoDefault / ThisForm.Imprimir.Click()
    *   Case nKeyCode = -2 && F3 / NoDefault / ThisForm.Grade.Click()
    * KeyPreview = .T. (propriedade da classe) faz esses codigos de tecla
    * chegarem aqui antes de qualquer controle filho.
    *--------------------------------------------------------------------------
    PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
        DO CASE
            CASE par_nKeyCode = -1 && F2
                THIS.BtnImprimirClick()
                NODEFAULT
            CASE par_nKeyCode = -2 && F3
                THIS.BtnGradeClick()
                NODEFAULT
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnGradeClick - cmd_4c_Grade.Click. Legado (Grade.Click):
    *   Thisform.Grd.Column1.Setfocus
    *--------------------------------------------------------------------------
    PROCEDURE BtnGradeClick()
        IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
            THIS.grd_4c_Dados.Column1.SetFocus()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSairClick - cmd_4c_Sair.Click. Legado (Sair.Click):
    *   Select csPgto / If Reccount() > 0 / Go top / Scan
    *       if !(csPgto.Printed)
    *           .Grd.Refresh / .Grd.Column1.SetFocus
    *           MessageBox("Autenticacao Obrigatoria",16,"") / Return
    *       endif
    *   EndScan / EndIf
    *   ldtime = DateTime() / Do While DateTime()-ldtime<=2 / =chrsaw(.5) / EndDo
    *   ThisForm.Release
    *
    * ExisteLinhaNaoAutenticada() (BO) reproduz o Scan/Locate For !Printed.
    * chrsaw(.5) em loop (funcao global do Fortyus nao portada - so dava
    * tempo ao SO processar a tela) -> DOEVENTS no lugar, mesmo efeito
    * pratico. MESSAGEBOX legado -> MsgAviso (regra CLAUDE.md "MESSAGEBOX
    * PROIBIDO").
    *--------------------------------------------------------------------------
    PROCEDURE BtnSairClick()
        LOCAL loc_tInicio

        IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
                AND THIS.this_oBusinessObject.ExisteLinhaNaoAutenticada()
            IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                THIS.grd_4c_Dados.Refresh()
                THIS.grd_4c_Dados.Column1.SetFocus()
            ENDIF
            MsgAviso("Autentica" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN
        ENDIF

        loc_tInicio = DATETIME()
        DO WHILE DATETIME() - loc_tInicio <= 2
            DOEVENTS
        ENDDO

        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - cmd_4c_Fwbtnm1.Click. Legado (Fwbtnm1.Click):
    *   Local lOk / lOk = .f.
    *   if Reccount("csPgto") <=0
    *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
    *       ThisForm.Sair.Setfocus
    *   Endif
    *   Select csPgto / go Top / Scan
    *       If csPgto.marca
    *           lOk = ThisForm.Autentica(csPgto.Autenticas)
    *           if lOk
    *               Replace csPgto.marca with .f., csPgto.Printed with .t.
    *           EndIf
    *       EndIf
    *   EndScan
    *
    * O legado NAO interrompe o fluxo quando o cursor esta vazio (apenas
    * mostra o aviso e tenta focar Sair; o Scan seguinte nao executa nada
    * num cursor vazio) - mesmo efeito reproduzido aqui.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_lOk, loc_oErro

        *-- Legado: "Local lOk / lOk = .f." - o valor so eh lido logo apos a
        *-- atribuicao dentro do Scan, mas LOCAL sem inicializar nasce .F.
        *-- (logico) no VFP e deixar implicito ja custou erro de tipo antes.
        loc_lOk = .F.

        TRY
            IF !USED("cursor_4c_Pagamentos") OR RECCOUNT("cursor_4c_Pagamentos") <= 0
                MsgAviso("N" + CHR(227) + "o existem observa" + CHR(231) + CHR(245) + "es a serem autenticadas", ;
                    "Autentica" + CHR(231) + CHR(227) + "o")
                IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
                    THIS.cmd_4c_Sair.SetFocus()
                ENDIF
            ENDIF

            IF USED("cursor_4c_Pagamentos")
                SELECT cursor_4c_Pagamentos
                GO TOP
                SCAN
                    IF cursor_4c_Pagamentos.Marca
                        loc_lOk = THIS.Autentica(cursor_4c_Pagamentos.Autenticas)
                        IF loc_lOk
                            THIS.this_oBusinessObject.MarcarLinhaAutenticada()
                        ENDIF
                    ENDIF
                ENDSCAN

                SELECT cursor_4c_Pagamentos
                GO TOP
                IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
                    THIS.grd_4c_Dados.Refresh()
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.BtnImprimirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Transferencia FORM -> BO.
    *
    * Este dialogo nao tem ficha de cadastro: a superficie editavel do legado
    * eh UM campo (TxtObs) mais a coluna de marcacao da grade. Logo o par
    * FormParaBO/BOParaForm aqui nao mapeia dezenas de campos - mapeia o que
    * de fato existe:
    *   - txt_4c_TxtObs -> this_cObservacao, o texto que autentica() imprime
    *     junto do comprovante (legado: "_toPrint = padc(alltrim(ThisForm.
    *     txtObs.Value),60," ")");
    *   - a LINHA corrente da grade -> this_lLinhaMarca/this_cLinhaObs/
    *     this_cLinhaFpags/this_lLinhaImpressa/this_nLinhaAutenticas, via
    *     SigOpAutBO.CarregarDoCursor (o legado le csPgto.marca/.Autenticas
    *     direto do cursor dentro do Scan do botao Imprimir).
    *
    * CarregarDoCursor NAO move o ponteiro (so SELECT + leitura dos campos),
    * por isso FormParaBO pode ser chamado de DENTRO do SCAN de
    * BtnImprimirClick sem quebrar a varredura.
    *
    * Retorna .F. quando o BO ainda nao existe - BtnImprimirClick e Autentica
    * chamam este metodo e nao podem presumir sucesso.
    *
    * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
    * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR
    * o escopo herdado - escrever "PROCEDURE FormParaBO" aqui deixaria o
    * metodo protegido do mesmo jeito e mentiria para quem le. Consequencia
    * pratica: so da para chama-lo por THIS. de dentro da classe; harness que
    * precise exerce-lo tem de faze-lo por uma subclasse (ver
    * automation\ProbeAut644F8.prg), nunca de um script solto - PEMSTATUS com
    * o 3o argumento 5 responde "existe?", nao "da para chamar daqui?".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        LOCAL loc_lOk, loc_oBO, loc_oErro
        loc_lOk = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                IF PEMSTATUS(THIS, "txt_4c_TxtObs", 5) ;
                        AND VARTYPE(THIS.txt_4c_TxtObs.Value) = "C"
                    loc_oBO.this_cObservacao = THIS.txt_4c_TxtObs.Value
                ELSE
                    loc_oBO.this_cObservacao = ""
                ENDIF

                IF USED("cursor_4c_Pagamentos")
                    loc_oBO.CarregarDoCursor("cursor_4c_Pagamentos")
                ENDIF

                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.FormParaBO")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Transferencia BO -> FORM, sentido inverso de FormParaBO.
    *
    * Espelha this_cObservacao no TextBox. Usado por
    * AplicarRegraVisibilidadeObs para reproduzir o ".txtObs.value = ''" do
    * fim do Init legado: quem zera eh o BO (fonte unica), o form so reflete.
    *
    * A grade NAO eh repintada a partir das properties this_*Linha*: elas sao
    * uma FOTO da linha corrente (leitura), e quem desenha as linhas eh o
    * ControlSource do Grid ligado ao proprio cursor. Reescrever o cursor a
    * partir da foto sobrescreveria as outras linhas com a corrente.
    *
    * PROTECTED EXPLICITO pela mesma razao de FormParaBO acima (FormBase
    * declara o nome como PROTECTED e o escopo herdado nao se alarga).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_lOk, loc_oBO, loc_oErro
        loc_lOk = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            IF VARTYPE(loc_oBO) = "O"
                IF PEMSTATUS(THIS, "txt_4c_TxtObs", 5)
                    THIS.txt_4c_TxtObs.Value = NVL(loc_oBO.this_cObservacao, "")
                ENDIF
                loc_lOk = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.BOParaForm")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *--------------------------------------------------------------------------
    * Autentica - Envia o texto de autenticacao para a impressora fiscal
    * (verso) ou para a impressora de cheque (porta serial OLE), conforme o
    * modelo configurado e o tipo de autenticacao solicitado
    * (par_nTipoAutentica - legado Lparameters _TpAutentica: 1 = Impressora
    * Fiscal/Cheque via verso; outro valor = impressora fiscal "comum").
    *
    * Transcrito de SIGOPAUT.autentica
    * (tasks\task644\SigOpAut_form_codigo_fonte.txt). _autVal vem de
    * this_oBusinessObject.ObterTextoAutenticacao(); CrSigFiFis.Imps vem de
    * THIS.ObterModeloImpressoraFiscal(). Aqui ficam so as chamadas de
    * hardware que o legado faz via funcoes globais do Fortyus - LeituraFab/
    * fDecriptografar/ImpVerso/ReAutentica/Autentica(global), SEM o acervo
    * do protocolo proprietario da ECF (ver utils\leiturafab.prg e irmaos,
    * regra CLAUDE.md #27). O ramo da impressora de CHEQUE (porta serial via
    * obj_4c_OleComm) nao depende de nenhuma funcao externa e foi portado
    * por completo, byte a byte igual ao legado.
    *
    * "Thisform.Primeiravez = .f." no legado roda ANTES de qualquer branch,
    * o que faz "If Not Thisform.Primeiravez" dentro dos ramos ser SEMPRE
    * verdadeiro (cai em ReAutentica, nunca no Autentica(global) do 1o
    * disparo) - transcrito literalmente (regra CLAUDE.md #17: formula do
    * legado nunca se reescreve, mesmo quando parece redundante).
    *
    * RetImpVer (loc_lRetImpVer) eh calculado mas NUNCA usado como retorno
    * do metodo no legado - o "Return .t." final eh incondicional em todo
    * caminho, exceto o "Return 0" dentro do ramo de impressora de cheque
    * quando a configuracao de porta nao esta disponivel. Mesmo contrato
    * aqui.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Autentica(par_nTipoAutentica)
        LOCAL loc_oBO, loc_cAutVal, loc_cToPrintPad, loc_cToPrintCru, loc_cModelo
        LOCAL loc_cNoFab, loc_cNoFabReal, loc_cModeloInterno, loc_lRetImpVer
        LOCAL loc_uTemAut, loc_lTemAutentica, loc_lResultado, loc_oErro, loc_nImpCheqs

        loc_lResultado    = .T.
        loc_lRetImpVer    = .T.
        loc_lTemAutentica = .F.

        TRY
            loc_oBO = THIS.this_oBusinessObject

            *-- Legado: "Thisform.Primeiravez = .f." roda ANTES de
            *-- qualquer branch (ver nota acima)
            loc_oBO.this_lPrimeiraVez = .F.

            *-- Legado: ThisForm.ParentForm.TemAutentica, lido fresco a
            *-- cada chamada (nao reaproveita o snapshot de CarregarDados)
            IF VARTYPE(THIS.this_oParentForm) = "O" ;
                    AND PEMSTATUS(THIS.this_oParentForm, "TemAutentica", 5)
                loc_uTemAut = THIS.this_oParentForm.TemAutentica
                IF VARTYPE(loc_uTemAut) = "L"
                    loc_lTemAutentica = loc_uTemAut
                ENDIF
                IF VARTYPE(loc_uTemAut) = "N"
                    loc_lTemAutentica = (loc_uTemAut != 0)
                ENDIF
            ENDIF

            loc_cAutVal = loc_oBO.ObterTextoAutenticacao()

            *-- Legado: "_toPrint = padc(alltrim(ThisForm.txtObs.Value),60," ")"
            *-- lido FRESCO a cada chamada de autentica(). FormParaBO() eh a
            *-- transferencia unica form -> BO (campo digitavel + linha corrente
            *-- da grade), entao o texto sai de this_cObservacao e nao de uma
            *-- segunda leitura do controle - fonte unica, mesmo instante de
            *-- leitura do legado.
            THIS.FormParaBO()
            loc_cToPrintCru = loc_oBO.this_cObservacao
            loc_cToPrintPad = PADC(ALLTRIM(loc_cToPrintCru), 60, " ")
            loc_cModelo     = THIS.ObterModeloImpressoraFiscal()

            IF par_nTipoAutentica = 1

                IF INLIST(loc_cModelo, "DATAREGIS", "NDATAREGIS", "BEMA8501", "DARUMA", "EPSON")

                    IF loc_cModelo == "BEMA8501"
                        loc_cNoFab         = LeituraFab(THIS.this_oModem)
                        loc_cNoFabReal     = fDecriptografar(ALLTRIM(NVL(loc_cNoFab, "")))
                        loc_cModeloInterno = loc_oBO.ObterModeloInternoPorNumeroFabricacao(loc_cNoFabReal)
                    ELSE
                        loc_cModeloInterno = SPACE(10)
                    ENDIF

                    fMensagemFixa("Posicione o papel na impressora para autentica" + CHR(231) + CHR(227) + "o...", ;
                        48, "Autentica" + CHR(231) + CHR(227) + "o", .F., .F., "\vbmp\ifiscal2.bmp")

                    IF ALLTRIM(loc_cModeloInterno) != "MP-7000 TH FI"
                        loc_lRetImpVer = ImpVerso(loc_cAutVal, loc_cToPrintPad, THIS.this_oModem, .T.)
                    ELSE
                        IF !loc_oBO.this_lPrimeiraVez
                            loc_lRetImpVer = ReAutentica(THIS.this_oModem)
                        ELSE
                            IF !loc_lTemAutentica
                                loc_lRetImpVer = .T.
                            ELSE
                                loc_lRetImpVer = Autentica(THIS.this_oModem)
                            ENDIF
                            loc_oBO.this_lPrimeiraVez = .F.
                        ENDIF
                    ENDIF

                ELSE
                    *-- Ramo impressora de CHEQUE (porta serial) - portado
                    *-- por completo, sem dependencia de funcao externa
                    loc_nImpCheqs = loc_oBO.ObterTipoImpressaoCheque()

                    fMensagemFixa("Posicione o Papel na impressora para autentica" + CHR(231) + CHR(227) + "o...", ;
                        48, "Autentica" + CHR(231) + CHR(227) + "o", .F., .F., "\vbmp\a_print4.bmp")

                    IF !loc_oBO.ObterConfigPortaCheque()
                        loc_lResultado = .F.
                    ELSE
                        IF PEMSTATUS(THIS, "obj_4c_OleComm", 5)
                            IF !THIS.obj_4c_OleComm.PortOpen AND loc_oBO.this_nPortaCheque != 0
                                WITH THIS.obj_4c_OleComm
                                    .CommPort = loc_oBO.this_nPortaCheque
                                    .Settings = ALLTRIM(loc_oBO.this_cSettingsCheque)
                                    .InputLen = 1
                                ENDWITH
                            ENDIF

                            THIS.obj_4c_OleComm.PortOpen = .T.

                            SET CENTURY OFF

                            IF loc_nImpCheqs = 2
                                THIS.obj_4c_OleComm.Output = SPACE(8) + loc_cAutVal + CHR(10) + CHR(13)
                                THIS.obj_4c_OleComm.Output = SPACE(8) + loc_cToPrintCru + CHR(10) + CHR(13)
                                THIS.obj_4c_OleComm.Output = CHR(12)
                            ELSE
                                THIS.obj_4c_OleComm.Output = CHR(27) + CHR(64) + CHR(13)
                                THIS.obj_4c_OleComm.Output = SPACE(5) + loc_cAutVal + CHR(13) + CHR(10)
                                THIS.obj_4c_OleComm.Output = SPACE(5) + loc_cToPrintCru + CHR(13) + CHR(10)
                                THIS.obj_4c_OleComm.Output = CHR(12)
                            ENDIF

                            SET CENTURY ON

                            THIS.obj_4c_OleComm.PortOpen = .F.
                        ENDIF
                    ENDIF
                ENDIF

            ELSE
                fMensagemFixa("Posicione o papel na impressora para autentica" + CHR(231) + CHR(227) + "o...", ;
                    48, "Autentica" + CHR(231) + CHR(227) + "o", .F., .F., "\vbmp\IFiscal.bmp")

                IF INLIST(loc_cModelo, "SWEDA", "NSWEDA") AND !loc_oBO.this_lPrimeiraVez
                    loc_lRetImpVer = ReAutentica(THIS.this_oModem)
                ELSE
                    IF !loc_lTemAutentica
                        loc_lRetImpVer = .T.
                    ELSE
                        loc_lRetImpVer = Autentica(THIS.this_oModem)
                    ENDIF
                    loc_oBO.this_lPrimeiraVez = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.Autentica")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera referencias de UI/BO. SigOpAut eh modal (WindowType=1)
    * e o legado nao desabilita o ParentForm explicitamente no Init (o bloqueio
    * de interacao vem do proprio modal do VFP), entao Destroy so limpa as
    * referencias - nao ha Enabled a restaurar.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Pagamentos")
            USE IN cursor_4c_Pagamentos
        ENDIF
        THIS.this_oParentForm     = .NULL.
        THIS.this_oModem          = .NULL.
        THIS.this_oBusinessObject = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE
