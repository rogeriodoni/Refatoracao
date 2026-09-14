# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-TABELA] Tabela 'SigMvFornE' usada no BO migrado mas NAO aparece no codigo original. Pode ser tabela inventada/confundida.
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'EMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LCREF, LCVEN, I, LNCNT, DOPES, IMPRESS, EMPDOPNUMS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'NUMES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LCREF, LCVEN, I, LNCNT, DOPES, IMPRESS, EMPDOPNUMS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
		Insert Into LocalOpe2 (DckLogos, DckAcess, DocAcess, ChkImpDp, ChkImpRot, ChkImpMon) Values (0, 0, [], 0, 0, 0)
	Select TmpRelat
	Insert Into crCabecalho (Dopes, Numes, Datas, RazSocs, Cgcs, Ies, Obses, TitFornec, DckPrzE, DocPrzE, DckReffs, ;
		Select crCabecalho
Select TmpRelat
Select TmpRel
	Select TmpRelat
lcQuery = [ Select a.Ndopes, b.chkImpDoc, b.carcompos, b.dckTermos, a.Cmoes, a.TipoNfs, a.Opers, c.lbltxidCs, c.chkIFoto ] + ;
		    [ From SigCdOpe a, SigOpCdc b, SigOpCdi c ]+ ;
If (ThisForm.Conexao.SqlExecute(lcQuery, [crSigCdOpeD]) < 1)
Select TmpRelat
	Select TmpRelat
				Define Window Visualizar From 0, 0 To 37, 80 Title [ ] + Alltrim(Prompt()) + [ ]
				Select (lcTabela)
							If Thisform.mEmail( 	Thisform.oEMAIL.cFrom, ;
			If (ThisForm.poDataMgr2.SQLExecute([Update SigMvCab Set Impress = 1 Where EmpDopNums =  '] + lcEdn + ['], '') < 1)
Select TmpRel
Select TmpRel
Select TmpRel
Select TmpRel
Select TmpRel

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigredcu.prg) - PRIMEIRAS 1181 de 1181 linhas:
*==============================================================================
* FORMSIGREDCU.PRG
* Form de Impressao de Documento (dialogo modal parametrizado)
* Tipo: DIALOGO - chamado por forms operacionais apos preparar TmpRelat/TmpRel
* Migrado de: SIGREDCU.SCX (frmrelatorio legado)
*
* Parametros Init():
*   par_nQbols     - Quantidade de vias para impressao
*   par_oCnx       - Conexao legada (ignorada - usa gnConnHandle global)
*   par_cEmail     - Email de destino para envio do documento
*   par_cEmp       - Codigo da empresa (3 chars)
*   par_cDop       - Tipo de operacao (20 chars)
*   par_nNum       - Numero do documento
*   par_nImpress   - Tipo impressao pre-selecionado (0=nenhum,1=video,2=impr,3=xls,4=enc)
*   par_oForm      - Referencia ao form chamador (reativado ao fechar)
*   par_lChkImpDoc - Flag controle de impressao do documento
*
* FASE 3/8 - Estrutura base do form
*   - Propriedades visuais (EXATAS do original SIGREDCU: Width=798, Height=250)
*   - Init() com recepcao de 9 parametros e criacao do BO antes de InicializarForm
*   - InicializarForm() - carrega dados da operacao e monta cabecalho
*   - ConfigurarCabecalho() - container escuro com titulo (equivale ao cntSombra)
*   - Destroy() - reativa form pai e libera recursos
*==============================================================================

DEFINE CLASS Formsigredcu AS FormBase

    *-- Dimensoes e aparencia (EXATAS do original SIGREDCU)
    this_cMensagemErro = ""
    Height          = 250
    Width           = 798
    DataSession     = 1
    ShowWindow = 1
    BorderStyle     = 2
    ControlBox      = .F.
    WindowType      = 1
    AlwaysOnTop     = .T.
    AutoCenter      = .T.
    MaxButton       = .F.
    MinButton       = .F.
    Themes          = .F.
    ShowTips        = .T.

    *-- BO de impressao (criado em Init() antes de DODEFAULT/InicializarForm)
    this_oRelatorio         = .NULL.

    *-- Parametros do dialogo (mapeados das propriedades do SIGREDCU legado)
    this_oFormPai           = .NULL.    && oForm: referencia ao form chamador
    this_nQbols             = 1         && Qbols: quantidade de vias
    this_nTpImpressao       = 0         && TpImpressao: 0=nenhum 1=video 2=impressora 3=excel 4=encerrar
    this_lAcImprimir        = .T.       && lAcImprimir: acesso ao botao imprimir
    this_lAcExcel           = .T.       && lAcExcel: acesso ao botao excel
    this_lChkImpDoc         = .F.       && ChkImpDoc: flag controle de impressao do documento
    this_lChkImpDocAcess    = .F.       && ChkImpDocAcess: flag acesso para reimpressao

    *--------------------------------------------------------------------------
    * Init - Recebe parametros do form chamador, prepara BO e inicia interface
    *   O BO e criado ANTES de DODEFAULT() porque InicializarForm() precisa
    *   de this_oRelatorio para carregar dados da operacao via PrepararDados().
    *   Desabilita o form pai enquanto este dialogo estiver aberto.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_nQbols, par_oCnx, par_cEmail, par_cEmp, par_cDop, par_nNum, par_nImpress, par_oForm, par_lChkImpDoc)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Cria o BO antes de DODEFAULT (InicializarForm precisa dele)
            THIS.this_oRelatorio = CREATEOBJECT("sigredcuBO")
            IF VARTYPE(THIS.this_oRelatorio) = "O"

                *-- Armazena referencia ao form pai (para reativar em Destroy)
                THIS.this_oFormPai                 = par_oForm
                THIS.this_oRelatorio.this_oFormPai = par_oForm

                *-- Transfere parametros para o BO
                THIS.this_oRelatorio.this_cEmail  = IIF(VARTYPE(par_cEmail)   = "C", ALLTRIM(par_cEmail),   "")
                THIS.this_oRelatorio.this_cEmps   = IIF(VARTYPE(par_cEmp)     = "C", ALLTRIM(par_cEmp),     "")
                THIS.this_oRelatorio.this_cDopes  = IIF(VARTYPE(par_cDop)     = "C", ALLTRIM(par_cDop),     "")
                THIS.this_oRelatorio.this_nNumes  = IIF(VARTYPE(par_nNum)     = "N", par_nNum,               0)
                THIS.this_oRelatorio.this_nQbols  = IIF(VARTYPE(par_nQbols)   = "N" AND par_nQbols >= 1, par_nQbols, 1)
                THIS.this_nQbols                  = THIS.this_oRelatorio.this_nQbols

                *-- Tipo de impressao pre-selecionado (pImpress do legado)
                THIS.this_nTpImpressao                     = IIF(VARTYPE(par_nImpress) = "N", par_nImpress, 0)
                THIS.this_oRelatorio.this_nTpImpressao     = THIS.this_nTpImpressao

                *-- Flag controle de impressao (pChkImpDoc do legado)
                THIS.this_lChkImpDoc = IIF(VARTYPE(par_lChkImpDoc) = "L", par_lChkImpDoc, .F.)

                *-- Desabilita form pai enquanto este dialogo estiver aberto
                IF VARTYPE(par_oForm) = "O" AND !ISNULL(par_oForm)
                    par_oForm.Enabled = .F.
                ENDIF

                *-- Inicializa interface (FormBase.Init -> THIS.InicializarForm)
                loc_lSucesso = DODEFAULT()

            ELSE
                MsgErro("Falha ao criar sigredcuBO" + CHR(13) + ;
                    "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Formsigredcu.Init")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigredcu.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Configura fundo, caption, carrega dados da operacao
    *                   e monta estrutura visual base (fase 3: cabecalho)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_lContinuar
        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            *-- Valida que o BO foi criado pelo Init() antes de DODEFAULT()
            IF VARTYPE(THIS.this_oRelatorio) != "O"
                MsgErro("BO n" + CHR(227) + "o inicializado em InicializarForm", ;
                    "Formsigredcu.InicializarForm")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Imagem de fundo e caption do dialogo
                IF TYPE("gc_4c_CaminhoIcones") = "U"
                    gc_4c_CaminhoIcones = ""
                ENDIF
                THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
                THIS.Caption = "Impress" + CHR(227) + "o de Documento (" + ;
                               ALLTRIM(THIS.this_oRelatorio.this_cDopes) + "/" + ;
                               ALLTRIM(STR(THIS.this_oRelatorio.this_nNumes)) + ")"

                *-- Carrega dados da operacao do banco (pula em modo validacao UI)
                IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                    IF !THIS.this_oRelatorio.PrepararDados()
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Formsigredcu.InicializarForm")
                        loc_lContinuar = .F.
                    ENDIF
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Monta layout (FLAT - orquestrado por ConfigurarPageFrame)
                THIS.ConfigurarPageFrame()

                THIS.Visible = .T.
                THIS.AplicarTipoImpressaoInicial()
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Formsigredcu.InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPageFrame - Orquestra a montagem do layout do form de relatorio
    *
    * Form REPORT (frmrelatorio): layout FLAT sem PageFrame CRUD de duas Pages.
    * Mesmo assim mantemos o nome ConfigurarPageFrame para padronizacao com o
    * pipeline de migracao (orquestrador valida presenca do metodo) e para
    * concentrar em um unico ponto a montagem visual do dialogo de impressao.
    *
    * Na Fase 3 monta apenas a estrutura base (cabecalho escuro com titulo).
    * Fases posteriores incrementam este orquestrador adicionando chamadas a
    * ConfigurarBotoesRelatorio (Fase 4), ConfigurarControles (Fase 5/6) e
    * AplicarValoresIniciais (Fase 7/8).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.ConfigurarCabecalho()
        THIS.ConfigurarBotoesRelatorio()
        THIS.ConfigurarPaginaDados()
        THIS.ConfigurarPaginaLista()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaLista - Aplica valores iniciais aos controles do dialogo
    *
    * Em forms REPORT (frmrelatorio) nao ha Page1/Page2 - este metodo eh o
    * equivalente funcional do ConfigurarPaginaLista CRUD: sincroniza estado
    * inicial dos controles de opcao (CheckBoxes e OptionGroup) com os dados
    * carregados pelo BO em PrepararDados() e com os parametros recebidos
    * do form chamador.
    *
    * Logica espelhada do SIGREDCU.Init() legado:
    *   chkImagem.Value = crSigCdOpeD.chkIFoto  (1=imprime imagem padrao)
    *   chkCompo.Value  = Int(Val(Substr(lbltxidCs, 21, 1)))  (configuracao composicao)
    *   chkCompo.Visible = fChecaAcesso(nDopes, "INIBCOMPO")
    *   OptAgrupa.Value = 2  (default "Nenhum")
    *   chkImpPag/ChkItensP/chkDescIng marcam ImpTodasPaginas no BO
    *
    * Os controles sao criados em fases posteriores (5/6) - usa VARTYPE para
    * evitar erro quando este metodo for chamado antes da criacao dos checkboxes.
    * Sempre sincroniza o BO no final (mesmo sem os controles instanciados).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_nValComp, loc_cConfig, loc_oBO

        loc_oBO = THIS.this_oRelatorio
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF

        *-- chkImagem: marca conforme flag chkIFoto da operacao
        IF VARTYPE(THIS.chk_4c_ChkImagem) = "O"
            THIS.chk_4c_ChkImagem.Value = IIF(loc_oBO.this_nChkIFoto = 1, 1, 0)
        ENDIF
        loc_oBO.this_nChkImagem = IIF(loc_oBO.this_nChkIFoto = 1, 1, 0)

        *-- chkCompo: valor extraido do char 21 da string de configuracao
        loc_cConfig = loc_oBO.this_cLblTxIdCs
        loc_nValComp = 0
        IF LEN(loc_cConfig) >= 21
            loc_nValComp = INT(VAL(SUBSTR(loc_cConfig, 21, 1)))
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkCompo) = "O"
            THIS.chk_4c_ChkCompo.Value   = loc_nValComp
            THIS.chk_4c_ChkCompo.Visible = loc_oBO.this_lChkCompoVisivel
        ENDIF
        loc_oBO.this_nChkCompo = loc_nValComp

        *-- ChkItensP: nao marcado por default
        IF VARTYPE(THIS.chk_4c_ChkItensP) = "O"
            THIS.chk_4c_ChkItensP.Value = 0
        ENDIF
        loc_oBO.this_nChkItensP = 0

        *-- chkDescIng: nao marcado por default
        IF VARTYPE(THIS.chk_4c_ChkDescIng) = "O"
            THIS.chk_4c_ChkDescIng.Value = 0
        ENDIF
        loc_oBO.this_nChkDescIng = 0

        *-- chkImpPag: nao marcado por default (ImpTodasPaginas desligado)
        IF VARTYPE(THIS.chk_4c_ChkImpPag) = "O"
            THIS.chk_4c_ChkImpPag.Value = 0
        ENDIF
        loc_oBO.this_nChkImpPag       = 0
        loc_oBO.this_lImpTodasPaginas = .F.

        *-- OptAgrupa: default "Nenhum" (valor 2)
        IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
            THIS.obj_4c_OptAgrupa.Value = 2
        ENDIF
        loc_oBO.this_nOptAgrupa = 2

        *-- Sincroniza permissoes vindas do BO para os botoes de acesso
        THIS.this_lAcImprimir     = loc_oBO.this_lAcImprimir
        THIS.this_lAcExcel        = loc_oBO.this_lAcExcel
        THIS.this_lChkImpDocAcess = loc_oBO.this_lChkImpDocAcess
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Despacha acao do relatorio conforme par_nPagina
    *
    * Em forms REPORT (frmrelatorio) nao ha Page1/Page2 para alternar - este
    * metodo eh o equivalente funcional do "alternar pagina" CRUD: despacha
    * para uma das 4 acoes do CommandGroup superior conforme o codigo:
    *   1 = Visualizar (preview na tela)
    *   2 = Imprimir   (impressora padrao)
    *   3 = DocExcel   (exportacao para planilha)
    *   4 = Encerrar   (fecha o dialogo, restaura impressora)
    *
    * Permite invocar acoes do relatorio via codigo (testes / shortcuts /
    * RemoteTrigger) sem depender do Click direto dos botoes.
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_nAcao
        loc_nAcao = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)

        DO CASE
            CASE loc_nAcao = 1
                THIS.BtnVisualizarClick()
            CASE loc_nAcao = 2
                THIS.BtnImprimirClick()
            CASE loc_nAcao = 3
                THIS.BtnExcelClick()
            CASE loc_nAcao = 4
                THIS.BtnEncerrarClick()
            OTHERWISE
                MsgAviso("AlternarPagina: a" + CHR(231) + CHR(227) + "o inv" + ;
                    CHR(225) + "lida (" + ALLTRIM(STR(loc_nAcao)) + ;
                    "). Use 1=Visualizar, 2=Imprimir, 3=Excel, 4=Encerrar.", "Aviso")
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarCabecalho - Container escuro superior com titulo do dialogo
    *   Equivalente ao cntSombra do frmrelatorio legado.
    *   Largura = Width do form (cobre toda a faixa superior).
    *   Height = 83 para acomodar os botoes (cmg_4c_Botoes Height=80 acima).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 83
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            *-- Sombra deslocada 2px para efeito 3D no texto branco
            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 22
                .Left      = 22
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(0, 0, 0)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH

            *-- Titulo em branco sobre a sombra
            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 20
                .Left      = 20
                .Width     = THIS.Width
                .Height    = 30
                .Caption   = "Impress" + CHR(227) + "o de Documento"
                .FontName  = "Tahoma"
                .FontSize  = 14
                .FontBold  = .T.
                .ForeColor = RGB(255, 255, 255)
                .BackStyle = 0
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Reativa form pai, restaura impressora e libera BO
    *   Chamado automaticamente pelo VFP9 ao executar Release() no form.
    *   Equivalente ao PROCEDURE Release do SIGREDCU legado.
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        TRY
            *-- Reativa o form pai ao fechar este dialogo
            IF VARTYPE(THIS.this_oFormPai) = "O" AND !ISNULL(THIS.this_oFormPai)
                THIS.this_oFormPai.Enabled = .T.
            ENDIF

            *-- Restaura impressora padrao (Set Printer to Default do legado)
            SET PRINTER TO DEFAULT

            *-- Libera BO (NAO usar .Release() - Custom nao tem Release)
            IF VARTYPE(THIS.this_oRelatorio) = "O" AND !ISNULL(THIS.this_oRelatorio)
                THIS.this_oRelatorio = .NULL.
            ENDIF

            THIS.this_oFormPai = .NULL.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.Destroy")
        ENDTRY
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes de acao do relatorio
    *   Geometria EXATA do frmrelatorio framework: Top=0 Left=529 Width=273 Height=80
    *   Buttons(1)=Visualizar, (2)=Imprimir, (3)=DocExcel, (4)=Encerrar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
        THIS.AddObject("cmg_4c_Botoes", "CommandGroup")

        WITH THIS.cmg_4c_Botoes
            .Top           = 0
            .Left          = 529
            .Width         = 273
            .Height        = 80
            .ButtonCount   = 4
            .BackStyle     = 0
            .BorderStyle   = 0
            .BorderColor   = RGB(136, 189, 188)
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 0
            .Visible       = .T.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(1)
            .Caption         = "Visualizar"
            .Top             = 5
            .Left            = 5
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(2)
            .Caption         = "Imprimir"
            .Top             = 5
            .Left            = 71
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(3)
            .Caption         = "Doc Excel"
            .Top             = 5
            .Left            = 137
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
        ENDWITH

        WITH THIS.cmg_4c_Botoes.Buttons(4)
            .Caption         = "Encerrar"
            .Top             = 5
            .Left            = 203
            .Width           = 65
            .Height          = 70
            .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
            .FontName        = "Comic Sans MS"
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontSize        = 8
            .BackColor       = RGB(255, 255, 255)
            .ForeColor       = RGB(90, 90, 90)
            .PicturePosition = 13
            .SpecialEffect   = 0
            .MousePointer    = 15
            .Themes          = .F.
            .Cancel          = .T.
        ENDWITH

        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
        BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarTipoImpressaoInicial - Auto-executa acao pre-selecionada pelo chamador
    *   TpImpressao: 0=usuario escolhe, 1=video, 2=impressora, 3=excel, 4=encerrar
    *   Chamado ao final de InicializarForm() depois de THIS.Visible = .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AplicarTipoImpressaoInicial()
        DO CASE
        CASE THIS.this_nTpImpressao = 1
            THIS.BtnVisualizarClick()
        CASE THIS.this_nTpImpressao = 2
            THIS.BtnImprimirClick()
        CASE THIS.this_nTpImpressao = 3
            THIS.BtnExcelClick()
        CASE THIS.this_nTpImpressao = 4
            THIS.BtnEncerrarClick()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    * InibirBotoes - Habilita ou desabilita o CommandGroup durante processamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InibirBotoes(par_lInibir)
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Enabled = !par_lInibir
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Preview do documento na tela (Buttons(1))
    *   Equivale a This.Value=1 no Click do CommandGroup legado
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_cSep, loc_cPnt
        loc_cSep = SET("Separator")
        loc_cPnt = SET("Point")
        TRY
            IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "QtdDecimais", 5)
                IF INLIST(go_4c_Sistema.QtdDecimais, 0, 2)
                    SET SEPARATOR TO ","
                    SET POINT TO "."
                ELSE
                    SET SEPARATOR TO "."
                    SET POINT TO ","
                ENDIF
            ENDIF

            THIS.AlwaysOnTop = .F.
            THIS.InibirBotoes(.T.)
            THIS.FormParaRelatorio()

            IF !THIS.this_oRelatorio.Atualizar()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Formsigredcu.BtnVisualizarClick")
            ENDIF

            THIS.AlwaysOnTop = .T.
        CATCH TO loc_oErro
            THIS.AlwaysOnTop = .T.
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnVisualizarClick")
        ENDTRY
        SET SEPARATOR TO (loc_cSep)
        SET POINT TO (loc_cPnt)
        THIS.InibirBotoes(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnImprimirClick - Envia documento para impressora (Buttons(2))
    *   Equivale a This.Value=2 no Click do CommandGroup legado.
    *   Verifica acesso e controle de impressao antes de processar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnImprimirClick()
        LOCAL loc_cSep, loc_cPnt, loc_lPodeProsseguir
        loc_cSep = SET("Separator")
        loc_cPnt = SET("Point")
        loc_lPodeProsseguir = .T.
        TRY
            IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "QtdDecimais", 5)
                IF INLIST(go_4c_Sistema.QtdDecimais, 0, 2)
                    SET SEPARATOR TO ","
                    SET POINT TO "."
                ELSE
                    SET SEPARATOR TO "."
                    SET POINT TO ","
                ENDIF
            ENDIF

            IF !THIS.this_lAcImprimir
                MsgAviso("Acesso negado " + CHR(224) + " opera" + CHR(231) + ;
                    CHR(227) + "o Imprimir.", "Acesso")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir AND THIS.this_lChkImpDoc
                IF THIS.this_oRelatorio.VerificarReimpressao() AND !THIS.this_lChkImpDocAcess
                    MsgAviso("Documento j" + CHR(225) + " foi impresso." + CHR(13) + ;
                        "N" + CHR(227) + "o h" + CHR(225) + " permiss" + CHR(227) + ;
                        "o para reimpress" + CHR(227) + "o.", ;
                        "Controle de Impress" + CHR(227) + "o")
                    loc_lPodeProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lPodeProsseguir
                IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "ControlaImp", 5)
                    go_4c_Sistema.ControlaImp = .F.
                ENDIF

                THIS.AlwaysOnTop = .F.
                THIS.InibirBotoes(.T.)
                THIS.FormParaRelatorio()

                IF !THIS.this_oRelatorio.Inserir()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Formsigredcu.BtnImprimirClick")
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.this_cEmail) AND ;
                       !EMPTY(THIS.this_oRelatorio.this_cArqEmail) AND ;
                       FILE(THIS.this_oRelatorio.this_cArqEmail)
                        THIS.this_oRelatorio.EnviarEmail(THIS.this_oRelatorio.this_cArqEmail)
                    ENDIF
                ENDIF

                THIS.AlwaysOnTop = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.AlwaysOnTop = .T.
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnImprimirClick")
        ENDTRY
        SET SEPARATOR TO (loc_cSep)
        SET POINT TO (loc_cPnt)
        THIS.InibirBotoes(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcelClick - Gera exportacao do documento para Excel (Buttons(3))
    *   Equivale a This.Value=3 no Click do CommandGroup legado.
    *   Apos gerar o arquivo envia por email se this_cEmail estiver configurado.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcelClick()
        LOCAL loc_cSep, loc_cPnt, loc_lPodeProsseguir
        loc_cSep = SET("Separator")
        loc_cPnt = SET("Point")
        loc_lPodeProsseguir = .T.
        TRY
            IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "QtdDecimais", 5)
                IF INLIST(go_4c_Sistema.QtdDecimais, 0, 2)
                    SET SEPARATOR TO ","
                    SET POINT TO "."
                ELSE
                    SET SEPARATOR TO "."
                    SET POINT TO ","
                ENDIF
            ENDIF

            IF !THIS.this_lAcExcel
                MsgAviso("Acesso negado " + CHR(224) + " opera" + CHR(231) + ;
                    CHR(227) + "o Excel.", "Acesso")
                loc_lPodeProsseguir = .F.
            ENDIF

            IF loc_lPodeProsseguir
                IF VARTYPE(go_4c_Sistema) = "O" AND PEMSTATUS(go_4c_Sistema, "ControlaImp", 5)
                    go_4c_Sistema.ControlaImp = .F.
                ENDIF

                THIS.AlwaysOnTop = .F.
                THIS.InibirBotoes(.T.)
                THIS.FormParaRelatorio()

                IF !THIS.this_oRelatorio.DocumentoExcel()
                    MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                        "Formsigredcu.BtnExcelClick")
                ELSE
                    IF !EMPTY(THIS.this_oRelatorio.this_cEmail) AND ;
                       !EMPTY(THIS.this_oRelatorio.this_cArqEmail) AND ;
                       FILE(THIS.this_oRelatorio.this_cArqEmail)
                        THIS.this_oRelatorio.EnviarEmail(THIS.this_oRelatorio.this_cArqEmail)
                    ENDIF
                ENDIF

                THIS.AlwaysOnTop = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.AlwaysOnTop = .T.
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnExcelClick")
        ENDTRY
        SET SEPARATOR TO (loc_cSep)
        SET POINT TO (loc_cPnt)
        THIS.InibirBotoes(.F.)
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnEncerrarClick - Fecha o dialogo de impressao (Buttons(4) / ESC)
    *   Equivale a This.Value=4 no Click do CommandGroup legado.
    *   Destroy() reativa o form pai e restaura SET PRINTER automaticamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    * ConfigurarPaginaDados - Cria controles do dialogo (Fase 5: primeiros 50%)
    *   Cria: chk_4c_ChkImagem, chk_4c_ChkItensP, chk_4c_ChkDescIng, chk_4c_ChkCompo
    *   Posicoes EXATAS do original SIGREDCU (Top=88/105/122/139, Left=36)
    *   Fase 6 completa com chk_4c_ChkImpPag, obj_4c_OptAgrupa, lbl_4c_Agrupa
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        *-- chkImagem: "Imprimir Imagem" (Top=88)
        THIS.AddObject("chk_4c_ChkImagem", "CheckBox")
        WITH THIS.chk_4c_ChkImagem
            .Top       = 88
            .Left      = 36
            .Height    = 17
            .Width     = 140
            .Caption   = "Imprimir Imagem"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkImagem, "Click", THIS, "ChkImagemClick")

        *-- ChkItensP: checkbox filtro de itens (Top=105)
        THIS.AddObject("chk_4c_ChkItensP", "CheckBox")
        WITH THIS.chk_4c_ChkItensP
            .Top       = 105
            .Left      = 36
            .Height    = 17
            .Width     = 200
            .Caption   = "Imprimir Apenas Itens Pendentes"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkItensP, "Click", THIS, "ChkItensPClick")

        *-- chkDescIng: "Imprimir Descricao em Ingles" (Top=122)
        THIS.AddObject("chk_4c_ChkDescIng", "CheckBox")
        WITH THIS.chk_4c_ChkDescIng
            .Top       = 122
            .Left      = 36
            .Height    = 17
            .Width     = 200
            .Caption   = "Imprimir Descri" + CHR(231) + CHR(227) + "o em Ingl" + CHR(234) + "s"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkDescIng, "Click", THIS, "ChkDescIngClick")

        *-- chkCompo: "Inibir Composicao Desmembrada" (Top=139)
        THIS.AddObject("chk_4c_ChkCompo", "CheckBox")
        WITH THIS.chk_4c_ChkCompo
            .Top       = 139
            .Left      = 36
            .Height    = 17
            .Width     = 200
            .Caption   = "Inibir Composi" + CHR(231) + CHR(227) + "o Desmembrada"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkCompo, "Click", THIS, "ChkCompoClick")

        *-- chkImpPag: "Imprimir o Cabecalho em Todas as Paginas" (Top=156)
        THIS.AddObject("chk_4c_ChkImpPag", "CheckBox")
        WITH THIS.chk_4c_ChkImpPag
            .Top       = 156
            .Left      = 36
            .Height    = 17
            .Width     = 230
            .Caption   = "Imprimir o Cabe" + CHR(231) + "alho em Todas as P" + CHR(225) + "ginas"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .Alignment = 0
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Value     = 0
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.chk_4c_ChkImpPag, "Click", THIS, "ChkImpPagClick")

        *-- lbl_4c_Agrupa: "Agrupar por :" (Top=180, Left=36)
        THIS.AddObject("lbl_4c_Agrupa", "Label")
        WITH THIS.lbl_4c_Agrupa
            .Top       = 180
            .Left      = 36
            .Height    = 15
            .Width     = 67
            .Caption   = "Agrupar por :"
            .FontName  = "Tahoma"
            .FontSize  = 8
            .AutoSize  = .T.
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH

        *-- obj_4c_OptAgrupa: OptionGroup com 3 opcoes de agrupamento (Top=174, Left=117)
        THIS.AddObject("obj_4c_OptAgrupa", "OptionGroup")
        WITH THIS.obj_4c_OptAgrupa
            .Top         = 174
            .Left        = 117
            .Width       = 210
            .Height      = 57
            .ButtonCount = 3
            .BackStyle   = 0
            .BorderStyle = 0
            .Value       = 2
            .Visible     = .T.
        ENDWITH
        WITH THIS.obj_4c_OptAgrupa.Buttons(1)
            .Caption   = "Produto, Cor, Valor Unit" + CHR(225) + "rio"
            .Top       = 5
            .Left      = 6
            .Height    = 15
            .Width     = 151
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .T.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        WITH THIS.obj_4c_OptAgrupa.Buttons(2)
            .Caption   = "Nenhum"
            .Top       = 20
            .Left      = 6
            .Height    = 17
            .Width     = 78
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        WITH THIS.obj_4c_OptAgrupa.Buttons(3)
            .Caption   = "Ref fornecedor, Cor, Tamanho"
            .Top       = 37
            .Left      = 6
            .Height    = 15
            .Width     = 194
            .FontName  = "Tahoma"
            .FontSize  = 8
            .BackStyle = 0
            .AutoSize  = .F.
            .ForeColor = RGB(90, 90, 90)
            .Visible   = .T.
        ENDWITH
        BINDEVENT(THIS.obj_4c_OptAgrupa, "InteractiveChange", THIS, "OptAgrupaInteractiveChange")
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkImagemClick - Sincroniza flag imagem no BO e reprocessa TmpRelat
    *   Equivale a chkImagem.Click() do legado (chama SigPrIdc com novo valor)
    *--------------------------------------------------------------------------
    PROCEDURE ChkImagemClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkImagem = THIS.chk_4c_ChkImagem.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkImagemClick")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkItensPClick - Sincroniza flag ChkItensP no BO e reprocessa TmpRelat
    *   Equivale a ChkItensP.Click() do legado (chama SigPrIdc com novo valor)
    *--------------------------------------------------------------------------
    PROCEDURE ChkItensPClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkItensP = THIS.chk_4c_ChkItensP.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkItensPClick")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkDescIngClick - Sincroniza flag descricao em ingles no BO e reprocessa TmpRelat
    *   Equivale a chkDescIng.Click() do legado (chama SigPrIdc com novo valor)
    *--------------------------------------------------------------------------
    PROCEDURE ChkDescIngClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkDescIng = THIS.chk_4c_ChkDescIng.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkDescIngClick")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkCompoClick - Sincroniza flag inibir composicao no BO e reprocessa TmpRelat
    *   Equivale a chkCompo.Click() do legado (lnInibCompo = this.Value, chama SigPrIdc)
    *--------------------------------------------------------------------------
    PROCEDURE ChkCompoClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkCompo = THIS.chk_4c_ChkCompo.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigredcu.ChkCompoClick")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ChkImpPagClick - Sincroniza flag ImpTodasPaginas no BO
    *   Equivale a chkImpPag.Click() do legado (atualiza this_lImpTodasPaginas)
    *--------------------------------------------------------------------------
    PROCEDURE ChkImpPagClick()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nChkImpPag       = THIS.chk_4c_ChkImpPag.Value
            THIS.this_oRelatorio.this_lImpTodasPaginas = (THIS.chk_4c_ChkImpPag.Value = 1)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * OptAgrupaInteractiveChange - Sincroniza agrupamento no BO e reprocessa TmpRelat
    *   Equivale a OptAgrupa.Valid() do legado (chama SigPrIdc com novo agrupamento)
    *--------------------------------------------------------------------------
    PROCEDURE OptAgrupaInteractiveChange()
        IF VARTYPE(THIS.this_oRelatorio) = "O"
            THIS.this_oRelatorio.this_nOptAgrupa = THIS.obj_4c_OptAgrupa.Value
            IF !THIS.this_oRelatorio.AtualizarOpcoes()
                MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                    "Formsigredcu.OptAgrupaInteractiveChange")
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Acao principal para REPORT: gera/imprime o documento
    *
    * Em forms REPORT (frmrelatorio) "Incluir" nao tem sentido CRUD. O equivalente
    * funcional eh a acao primaria do dialogo: enviar documento para impressora
    * (registra impressao se this_lChkImpDoc estiver ativo).
    *
    * Delega para BtnImprimirClick que ja implementa toda a logica de:
    *   - Validacao de acesso (this_lAcImprimir)
    *   - Controle de reimpressao (VerificarReimpressao + this_lChkImpDocAcess)
    *   - Chamada this_oRelatorio.Inserir() (executa Impressao + RegistrarImpressao)
    *   - Envio por email se this_cEmail estiver configurado
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        TRY
            THIS.BtnImprimirClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnIncluirClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Restaura opcoes padrao do dialogo de impressao
    *
    * Em forms REPORT (frmrelatorio) "Alterar" nao tem sentido CRUD. O equivalente
    * funcional eh permitir ao usuario voltar as opcoes para o estado inicial
    * (chk_4c_Imagem, chk_4c_ItensP, chk_4c_DescIng, chk_4c_Compo, chk_4c_ImpPag,
    *  obj_4c_OptAgrupa = 2) e reprocessar TmpRelat com os defaults.
    *
    * Reaplica ConfigurarPaginaLista (sincroniza estado inicial dos controles com
    * o BO) e dispara AtualizarOpcoes() para reprocessar SigPrIdc com defaults.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oBO
        TRY
            loc_oBO = THIS.this_oRelatorio
            IF VARTYPE(loc_oBO) = "O"
                THIS.ConfigurarPaginaLista()
                IF !loc_oBO.AtualizarOpcoes()
                    MsgErro(loc_oBO.ObterMensagemErro(), ;
                        "Formsigredcu.BtnAlterarClick")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnAlterarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Encerra o dialogo de impressao com confirmacao
    *
    * Em forms REPORT (frmrelatorio) "Excluir" nao tem sentido CRUD. O equivalente
    * funcional eh encerrar o dialogo (mesmo papel do botao Encerrar - Buttons(4)
    * do cmg_4c_Botoes). Pede confirmacao antes de fechar para nao perder as
    * opcoes/configuracoes selecionadas pelo usuario acidentalmente.
    *
    * Destroy() reativa o form pai e restaura SET PRINTER automaticamente.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        IF MsgConfirma("Deseja encerrar a impress" + CHR(227) + "o do documento?", ;
                       "Encerrar")
            THIS.BtnEncerrarClick()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaRelatorio - Sincroniza TODOS os controles do form para o BO
    *   Garante que o BO tem o estado exato antes de Visualizar/Imprimir/Excel.
    *   Equivalente ao FormParaBO() dos forms CRUD.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaRelatorio()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oRelatorio
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF
        WITH loc_oBO
            .this_nChkImagem       = IIF(VARTYPE(THIS.chk_4c_ChkImagem)  = "O", THIS.chk_4c_ChkImagem.Value,  0)
            .this_nChkItensP       = IIF(VARTYPE(THIS.chk_4c_ChkItensP)  = "O", THIS.chk_4c_ChkItensP.Value,  0)
            .this_nChkDescIng      = IIF(VARTYPE(THIS.chk_4c_ChkDescIng) = "O", THIS.chk_4c_ChkDescIng.Value, 0)
            .this_nChkCompo        = IIF(VARTYPE(THIS.chk_4c_ChkCompo)   = "O", THIS.chk_4c_ChkCompo.Value,   0)
            .this_nChkImpPag       = IIF(VARTYPE(THIS.chk_4c_ChkImpPag)  = "O", THIS.chk_4c_ChkImpPag.Value,  0)
            .this_lImpTodasPaginas = (IIF(VARTYPE(THIS.chk_4c_ChkImpPag) = "O", THIS.chk_4c_ChkImpPag.Value, 0) = 1)
            .this_nOptAgrupa       = IIF(VARTYPE(THIS.obj_4c_OptAgrupa)  = "O", THIS.obj_4c_OptAgrupa.Value,  2)
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    * RelatorioParaForm - Sincroniza valores do BO de volta para os controles
    *   Equivalente ao BOParaForm() dos forms CRUD. Usado em LimparCampos().
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RelatorioParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oRelatorio
        IF VARTYPE(loc_oBO) != "O"
            RETURN
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkImagem) = "O"
            THIS.chk_4c_ChkImagem.Value = loc_oBO.this_nChkImagem
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkItensP) = "O"
            THIS.chk_4c_ChkItensP.Value = loc_oBO.this_nChkItensP
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkDescIng) = "O"
            THIS.chk_4c_ChkDescIng.Value = loc_oBO.this_nChkDescIng
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkCompo) = "O"
            THIS.chk_4c_ChkCompo.Value   = loc_oBO.this_nChkCompo
            THIS.chk_4c_ChkCompo.Visible = loc_oBO.this_lChkCompoVisivel
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkImpPag) = "O"
            THIS.chk_4c_ChkImpPag.Value = loc_oBO.this_nChkImpPag
        ENDIF
        IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
            THIS.obj_4c_OptAgrupa.Value = loc_oBO.this_nOptAgrupa
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCampos - Restaura todos os controles para os valores iniciais
    *   Reaplica ConfigurarPaginaLista (recalcula defaults do BO) e reflete no form.
    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
        TRY
            THIS.ConfigurarPaginaLista()
            THIS.RelatorioParaForm()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.LimparCampos")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * HabilitarCampos - Habilita ou desabilita controles de opcao do dialogo
    *   par_lHabilitar = .T. habilita todos, .F. desabilita durante processamento.
    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
        LOCAL loc_lHab
        loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
        IF VARTYPE(THIS.chk_4c_ChkImagem) = "O"
            THIS.chk_4c_ChkImagem.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkItensP) = "O"
            THIS.chk_4c_ChkItensP.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkDescIng) = "O"
            THIS.chk_4c_ChkDescIng.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkCompo) = "O"
            THIS.chk_4c_ChkCompo.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.chk_4c_ChkImpPag) = "O"
            THIS.chk_4c_ChkImpPag.Enabled = loc_lHab
        ENDIF
        IF VARTYPE(THIS.obj_4c_OptAgrupa) = "O"
            THIS.obj_4c_OptAgrupa.Enabled = loc_lHab
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AjustarBotoesPorModo - Ajusta estado dos botoes conforme permissoes de acesso
    *   Desabilita Imprimir se !this_lAcImprimir, Excel se !this_lAcExcel.
    *   Chamado apos carregar dados e apos recarregar permissoes do BO.
    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
        IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
            THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.
            THIS.cmg_4c_Botoes.Buttons(2).Enabled = THIS.this_lAcImprimir
            THIS.cmg_4c_Botoes.Buttons(3).Enabled = THIS.this_lAcExcel
            THIS.cmg_4c_Botoes.Buttons(4).Enabled = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarLista - Form REPORT nao tem grade de lista
    *   Equivalente funcional: recarrega dados da operacao no BO via PrepararDados.
    *   Mantem assinatura padrao do pipeline para compatibilidade com ValidarUIFidelity.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
                IF VARTYPE(THIS.this_oRelatorio) = "O"
                    loc_lSucesso = THIS.this_oRelatorio.PrepararDados()
                    IF !loc_lSucesso
                        MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
                            "Formsigredcu.CarregarLista")
                    ENDIF
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.CarregarLista")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnSalvarClick - Acao primaria do dialogo REPORT (equiv. Salvar CRUD)
    *
    * Em forms REPORT (frmrelatorio) "Salvar" nao tem sentido CRUD. O equivalente
    * funcional eh consolidar/processar o documento - aqui mapeia para a acao
    * de impressao (mesma logica de BtnIncluirClick) que executa o registro
    * de impressao via this_oRelatorio.Inserir() e envia por email se aplicavel.
    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
        TRY
            THIS.BtnImprimirClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnSalvarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnCancelarClick - Cancela operacao e encerra dialogo (equiv. Cancelar CRUD)
    *
    * Em forms REPORT (frmrelatorio) "Cancelar" eh equivalente a encerrar o
    * dialogo de impressao - delega para BtnEncerrarClick que faz Release()
    * (reativa form pai e restaura SET PRINTER via Destroy()).
    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
        TRY
            THIS.BtnEncerrarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Formsigredcu.BtnCancelarClick")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormParaBO - Alias CRUD para FormParaRelatorio (compatibilidade pipeline)
    *
    * O pipeline de migracao espera FormParaBO em forms CRUD. Em forms REPORT
    * o equivalente eh FormParaRelatorio (sincroniza controles -> BO antes de
    * Visualizar/Imprimir/Excel). Este alias garante compatibilidade com a
    * validacao de completude e mantem a semantica do form REPORT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormParaBO()
        THIS.FormParaRelatorio()
    ENDPROC

    *--------------------------------------------------------------------------
    * BOParaForm - Alias CRUD para RelatorioParaForm (compatibilidade pipeline)
    *
    * O pipeline de migracao espera BOParaForm em forms CRUD. Em forms REPORT
    * o equivalente eh RelatorioParaForm (sincroniza BO -> controles). Este
    * alias garante compatibilidade com a validacao de completude.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BOParaForm()
        THIS.RelatorioParaForm()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\sigredcuBO.prg):
*==============================================================================
* SIGREDCUBO.PRG
* Business Object para Impressao de Documento (SIGREDCU)
* Herda de RelatorioBase
*
* Dialogo de opcoes de impressao de documentos operacionais.
* Recebe cursores ja populados (TmpRelat/TmpRel) do form chamador.
*==============================================================================

DEFINE CLASS sigredcuBO AS RelatorioBase

    *-- Parametros do documento a imprimir (recebidos do form chamador)
    this_cEmps            = ""    && Codigo empresa (3 chars)
    this_cDopes           = ""    && Tipo de operacao (20 chars)
    this_nNumes           = 0     && Numero do documento
    this_nQbols           = 1     && Quantidade de vias para impressao
    this_cEmail           = ""    && Email de destino

    *-- Tipo de impressao (TpImpressao do legado)
    this_nTpImpressao     = 0     && 0=nenhum, 1=video, 2=impressora, 3=excel, 4=encerrar

    *-- Opcoes de impressao (mapeadas dos checkboxes do form)
    this_nChkImagem       = 0     && Imprimir imagem (0=nao, 1=sim)
    this_nChkItensP       = 0     && Apenas itens pendentes (0=nao, 1=sim)
    this_nChkDescIng      = 0     && Descricao em ingles (0=nao, 1=sim)
    this_nChkCompo        = 0     && Inibir composicao desmembrada (0=nao, 1=sim)
    this_nChkImpPag       = 0     && Imprimir cabecalho em todas as paginas (0=nao, 1=sim)

    *-- Tipo de agrupamento (OptAgrupa, default 2=Nenhum)
    this_nOptAgrupa       = 2     && 1=Produto/Cor/Valor, 2=Nenhum, 3=Ref Forn/Cor/Tamanho

    *-- Controle de impressao de documento (ChkImpDoc do legado)
    this_lChkImpDoc       = .F.   && Documento tem controle de impressao
    this_lChkImpDocAcess  = .F.   && Acesso para reimpressao liberado
    this_lImpTodasPaginas = .F.   && Estado: imprimir cabecalho em todas as paginas

    *-- Controles de acesso aos botoes (lAcImprimir/lAcExcel do frmrelatorio)
    this_lAcImprimir      = .T.   && Acesso ao botao imprimir
    this_lAcExcel         = .T.   && Acesso ao botao excel

    *-- Visibilidade do chkCompo (determinada por fChecaAcesso no Init)
    this_lChkCompoVisivel = .F.

    *-- Dados carregados de crSigCdOpeD (JOIN SigCdOpe + SigOpCdc + SigOpCdi)
    this_nNDopes          = 0     && ID numerico da operacao (para fChecaAcesso)
    this_nChkImpDocOpe    = 0     && SigOpCdc.chkImpDoc: flag controle impressao
    this_nCarCompos       = 0     && SigOpCdc.carcompos: tipo composicao
    this_nDckTermos       = 0     && SigOpCdc.dckTermos: flag termos de garantia
    this_cCMoes           = ""    && SigCdOpe.Cmoes: moeda
    this_nTipoNfs         = 0     && SigCdOpe.TipoNfs: tipo nota fiscal
    this_nOpers           = 0     && SigCdOpe.Opers: 1=fornecedor, 2=destino, 3=ambos
    this_cLblTxIdCs       = ""    && SigOpCdi.lbltxidCs: string de configuracao
    this_nChkIFoto        = 0     && SigOpCdi.chkIFoto: flag imagem padrao

    *-- Cursores de dados (populados externamente pelo form chamador)
    this_cCursorDados     = "TmpRelat"   && Cursor principal com dados do documento
    this_cCursorRel       = "TmpRel"     && Cursor auxiliar de relatorio

    *-- Referencia ao form pai (para reativar apos fechar este dialogo)
    this_oFormPai         = .NULL.

    *-- Arquivo gerado para email/PDF (pcArqEmail do legado)
    this_cArqEmail        = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Carrega dados da operacao do banco (crSigCdOpeD)
    * Chamado pelo Form apos setar this_cEmps/this_cDopes/this_nNumes
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT a.Ndopes, b.chkImpDoc, b.carcompos, b.dckTermos, " + ;
                       "a.Cmoes, a.TipoNfs, a.Opers, c.lbltxidCs, c.chkIFoto " + ;
                       "FROM SigCdOpe a, SigOpCdc b, SigOpCdi c " + ;
                       "WHERE a.Dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                       " AND b.Dopes = a.Dopes AND c.Dopes = a.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuOpe")

            IF loc_nResult >= 1
                SELECT cursor_4c_SigRedcuOpe
                IF !EOF()
                    THIS.this_nNDopes         = NVL(Ndopes, 0)
                    THIS.this_nChkImpDocOpe   = NVL(chkImpDoc, 0)
                    THIS.this_nCarCompos      = NVL(carcompos, 0)
                    THIS.this_nDckTermos      = NVL(dckTermos, 0)
                    THIS.this_cCMoes          = ALLTRIM(NVL(Cmoes, ""))
                    THIS.this_nTipoNfs        = NVL(TipoNfs, 0)
                    THIS.this_nOpers          = NVL(Opers, 0)
                    THIS.this_cLblTxIdCs      = ALLTRIM(NVL(lbltxidCs, ""))
                    THIS.this_nChkIFoto       = NVL(chkIFoto, 0)

                    *-- chkCompo inicializado com valor da posicao 21 de lbltxidCs
                    THIS.this_nChkCompo = INT(VAL(SUBSTR(THIS.this_cLblTxIdCs, 21, 1)))

                    *-- chkImagem inicializado com valor de chkIFoto
                    THIS.this_nChkImagem = THIS.this_nChkIFoto

                    *-- Flag controle de impressao
                    IF THIS.this_nChkImpDocOpe <> 0
                        THIS.this_lChkImpDoc = .T.
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o " + ;
                        ALLTRIM(THIS.this_cDopes) + " n" + CHR(227) + "o encontrada"
                ENDIF

                IF USED("cursor_4c_SigRedcuOpe")
                    USE IN cursor_4c_SigRedcuOpe
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar dados da opera" + ;
                    CHR(231) + CHR(227) + "o " + ALLTRIM(THIS.this_cDopes)
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarReimpressao - Verifica se documento ja foi impresso em SigMvCab
    * Retorna .T. se ja foi impresso
    *--------------------------------------------------------------------------
    PROCEDURE VerificarReimpressao()
        LOCAL loc_lJaImpresso, loc_cSQL, loc_nResult, loc_cEdn
        loc_lJaImpresso = .F.
        TRY
            loc_cEdn = PADR(THIS.this_cEmps, 3) + ;
                       PADR(THIS.this_cDopes, 20) + ;
                       STR(THIS.this_nNumes, 6)

            loc_cSQL = "SELECT Impress FROM SigMvCab WHERE EmpDopNums = " + ;
                       EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuImp")

            IF loc_nResult > 0
                SELECT cursor_4c_SigRedcuImp
                IF !EOF()
                    IF NVL(Impress, 0) <> 0
                        loc_lJaImpresso = .T.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigRedcuImp")
                    USE IN cursor_4c_SigRedcuImp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigredcuBO.VerificarReimpressao")
        ENDTRY
        RETURN loc_lJaImpresso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarImpressao - Marca documento como impresso (Impress=1) em SigMvCab
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarImpressao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cEdn
        loc_lSucesso = .F.
        TRY
            loc_cEdn = PADR(THIS.this_cEmps, 3) + ;
                       PADR(THIS.this_cDopes, 20) + ;
                       STR(THIS.this_nNumes, 6)

            loc_cSQL = "UPDATE SigMvCab SET Impress = 1 WHERE EmpDopNums = " + ;
                       EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "")
            IF loc_nResult >= 0
                SQLCOMMIT(gnConnHandle)
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao registrar impress" + CHR(227) + "o"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.RegistrarImpressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave do documento (EmpDopNums concatenado)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cEmps, 3) + ;
               PADR(THIS.this_cDopes, 20) + ;
               STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do documento em LogAuditoria
    * par_cOperacao: IMPRIMIR, VISUALIZAR, EXCEL, EMAIL
    * Para IMPRIMIR, tambem atualiza SigMvCab.Impress = 1 via RegistrarImpressao()
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario, loc_cOp
        loc_lSucesso = .F.
        TRY
            loc_cOp = UPPER(ALLTRIM(par_cOperacao))

            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = "EMP=" + ALLTRIM(THIS.this_cEmps) + ;
                         ";DOP=" + ALLTRIM(THIS.this_cDopes) + ;
                         ";NUM=" + ALLTRIM(STR(THIS.this_nNumes, 6))

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReDcu") + ", " + ;
                       EscaparSQL(loc_cOp) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)

            *-- Para operacao IMPRIMIR, marca documento como impresso em SigMvCab
            IF loc_cOp = "IMPRIMIR"
                THIS.RegistrarImpressao()
            ENDIF
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do documento
            MsgErro("Falha ao registrar auditoria: " + loc_oErro.Message, "Auditoria")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega parametros do documento a partir de cursor preset
    * Permite restaurar configuracao previamente salva (vias, opcoes, tipo agrupamento)
    * par_cAliasCursor: cursor com colunas: cEmps, cDopes, nNumes, nQbols,
    *                   nOptAgrupa, nChkImagem, nChkItensP, nChkDescIng,
    *                   nChkCompo, nChkImpPag, cEmail
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros n" + ;
                    CHR(227) + "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor de par" + CHR(226) + "metros vazio: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SCATTER MEMVAR

            IF TYPE("m.cEmps") = "C"
                THIS.this_cEmps = ALLTRIM(m.cEmps)
            ENDIF
            IF TYPE("m.cDopes") = "C"
                THIS.this_cDopes = ALLTRIM(m.cDopes)
            ENDIF
            IF TYPE("m.nNumes") = "N"
                THIS.this_nNumes = m.nNumes
            ENDIF
            IF TYPE("m.nQbols") = "N"
                THIS.this_nQbols = IIF(m.nQbols >= 1, m.nQbols, 1)
            ENDIF
            IF TYPE("m.cEmail") = "C"
                THIS.this_cEmail = ALLTRIM(m.cEmail)
            ENDIF
            IF TYPE("m.nOptAgrupa") = "N"
                THIS.this_nOptAgrupa = m.nOptAgrupa
            ENDIF
            IF TYPE("m.nChkImagem") = "N"
                THIS.this_nChkImagem = m.nChkImagem
            ENDIF
            IF TYPE("m.nChkItensP") = "N"
                THIS.this_nChkItensP = m.nChkItensP
            ENDIF
            IF TYPE("m.nChkDescIng") = "N"
                THIS.this_nChkDescIng = m.nChkDescIng
            ENDIF
            IF TYPE("m.nChkCompo") = "N"
                THIS.this_nChkCompo = m.nChkCompo
            ENDIF
            IF TYPE("m.nChkImpPag") = "N"
                THIS.this_nChkImpPag = m.nChkImpPag
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Gera o documento enviando para a impressora
    * Semantica para BO de relatorio: "inserir" = produzir documento impresso
    * Valida parametros, executa Impressao() e registra auditoria IMPRIMIR
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR THIS.this_nNumes <= 0
                THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do documento " + ;
                    "(empresa/opera" + CHR(231) + CHR(227) + "o/n" + CHR(250) + "mero) " + ;
                    "s" + CHR(227) + "o obrigat" + CHR(243) + "rios"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nQbols < 1
                THIS.this_nQbols = 1
            ENDIF

            loc_lSucesso = THIS.Impressao()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRIMIR")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Reprocessa os dados e exibe o documento em preview
    * Semantica para BO de relatorio: "atualizar" = recalcular e visualizar
    * Reaplica Processamento() (TmpRelat) e delega para Visualizacao()
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps) OR EMPTY(THIS.this_cDopes) OR THIS.this_nNumes <= 0
                THIS.this_cMensagemErro = "Par" + CHR(226) + "metros do documento " + ;
                    "(empresa/opera" + CHR(231) + CHR(227) + "o/n" + CHR(250) + "mero) " + ;
                    "s" + CHR(227) + "o obrigat" + CHR(243) + "rios"
                loc_lSucesso = .F.
            ENDIF

            IF THIS.this_nQbols < 1
                THIS.this_nQbols = 1
            ENDIF

            *-- Reprocessa TmpRelat com as opcoes atuais antes do preview
            IF !THIS.Processamento()
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = THIS.Visualizacao()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZAR")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Configura flag ImpTodasPaginas e posiciona cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararImpressao()
        THIS.this_lImpTodasPaginas = (THIS.this_nChkImpPag = 1)
        IF USED(THIS.this_cCursorDados)
            SELECT (THIS.this_cCursorDados)
            GO TOP
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Popula TmpRelat chamando SigPrIdc com opcoes atuais
    * Chamado ao inicializar e cada vez que usuario altera uma opcao
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorRel)
                SELECT (THIS.this_cCursorRel)
                GO TOP IN (THIS.this_cCursorRel)
            ENDIF
            DO SigPrIdc WITH ;
                THIS.this_cEmps, ;
                THIS.this_cDopes, ;
                THIS.this_nNumes, ;
                0, ;
                THIS.this_nQbols, ;
                THIS.this_nOptAgrupa, ;
                .T., ;
                gnConnHandle, ;
                (THIS.this_nChkImagem = 1), ;
                .F., ;
                (THIS.this_nChkItensP = 1), ;
                THIS.this_oFormPai, ;
                .F., ;
                (THIS.this_nChkDescIng = 1), ;
                THIS.this_nChkCompo
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Processamento")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarOpcoes - Reprocessa TmpRelat ao alterar opcoes de impressao
    * Chamado pelos handlers de OptAgrupa e todos os checkboxes de opcoes
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarOpcoes()
        RETURN THIS.Processamento()
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizacao - Exibe preview do documento na tela (REPORT FORM PREVIEW)
    * Apos o preview, imprime termo de garantia se dckTermos = 1
    *--------------------------------------------------------------------------
    PROCEDURE Visualizacao()
        LOCAL loc_lSucesso, loc_nCnt
        loc_lSucesso = .F.
        TRY
            THIS.PrepararImpressao()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                REPORT FORM SigReDc2 PREVIEW NOCONSOLE
            NEXT
            THIS.impGarantia()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Visualizacao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Envia documento para impressora em this_nQbols vias
    * TpImpressao 2 ou 4 = sem dialogo de impressora; outros = com PROMPT
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_lSucesso, loc_nCnt
        loc_lSucesso = .F.
        TRY
            SET PRINTER TO DEFAULT
            THIS.PrepararImpressao()
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                IF INLIST(THIS.this_nTpImpressao, 2, 4)
                    REPORT FORM SigReDc2 TO PRINTER NOCONSOLE
                ELSE
                    REPORT FORM SigReDc2 TO PRINTER PROMPT NOCONSOLE
                ENDIF
            NEXT
            THIS.impGarantia()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.Impressao")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * DocumentoExcel - Gera exportacao do documento para arquivo XLS
    * Popula this_cArqEmail com o caminho do arquivo gerado para uso posterior
    *--------------------------------------------------------------------------
    PROCEDURE DocumentoExcel()
        LOCAL loc_lSucesso, loc_nCnt, loc_cArqSaida
        loc_lSucesso = .F.
        TRY
            THIS.PrepararImpressao()
            IF EMPTY(THIS.this_cArqEmail)
                loc_cArqSaida = SYS(2023) + "\" + ;
                    "Dcto_" + ALLTRIM(THIS.this_cDopes) + "_" + ;
                    TRANSFORM(THIS.this_nNumes) + "_" + ;
                    TRANSFORM(DATE(), "@YL") + ".xls"
                THIS.this_cArqEmail = loc_cArqSaida
            ELSE
                loc_cArqSaida = THIS.this_cArqEmail
            ENDIF
            FOR loc_nCnt = 1 TO THIS.this_nQbols
                IF USED(THIS.this_cCursorDados)
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                ENDIF
                REPORT FORM SigReDc2 TO FILE (loc_cArqSaida) ASCII NOCONSOLE
            NEXT
            loc_lSucesso = FILE(loc_cArqSaida)
            IF !loc_lSucesso
                THIS.this_cMensagemErro = "Falha ao gerar arquivo Excel"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.DocumentoExcel")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * impGarantia - Imprime termo de garantia quando dckTermos = 1
    * Carrega colunas de texto e titulo de SigOpCdc e imprime SigReDc3
    *--------------------------------------------------------------------------
    PROCEDURE impGarantia()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_cTxtTermos
        loc_lSucesso = .F.
        TRY
            IF THIS.this_nDckTermos <> 1
                loc_lSucesso = .T.
            ENDIF
            loc_cSQL = "SELECT DocTit, DocOrig, DocDest, DckReffs, DocReffs, " + ;
                       "DckPrzE, DocPrzE, TxtPrzEnts, ChkPrzEnts, DckVend, " + ;
                       "DocVend, DocPag, DckTVend, DckBarra, DckFretes, DocFretes, " + ;
                       "DckIcmIpi, DocDesco, DocAcres, DckEntregs, DocEntregs, " + ;
                       "DckObsI, ImgTecs, DckTermos, TitTermos, TxtTermos, " + ;
                       "ViaTermos, TitTermgs, TxtTermgs " + ;
                       "FROM SigOpCdc " + ;
                       "WHERE Dopes = " + EscaparSQL(THIS.this_cDopes)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuGar")
            IF loc_nResult > 0
                SELECT cursor_4c_SigRedcuGar
                IF !EOF()
                    loc_cTxtTermos = ALLTRIM(NVL(TxtTermos, ""))
                    IF !EMPTY(loc_cTxtTermos)
                        IF USED(THIS.this_cCursorDados)
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                        ENDIF
                        REPORT FORM SigReDc3 TO PRINTER NOCONSOLE
                    ENDIF
                ENDIF
                IF USED("cursor_4c_SigRedcuGar")
                    USE IN cursor_4c_SigRedcuGar
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.impGarantia")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EnviarEmail - Envia documento por email com anexo PDF ou XLS
    * par_cAnexo - Caminho completo do arquivo a anexar
    * Usa this_cEmail (passado no Init) ou busca em SigMvFornE se vazio
    *--------------------------------------------------------------------------
    PROCEDURE EnviarEmail(par_cAnexo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmailDest, loc_cAssunto
        loc_lSucesso = .F.
        TRY
            loc_cEmailDest = ALLTRIM(THIS.this_cEmail)
            IF EMPTY(loc_cEmailDest)
                loc_cSQL = "SELECT TOP 1 emails FROM SigMvFornE " + ;
                           "WHERE Emps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + ;
                           " AND Dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                           " AND Numes = " + FormatarNumeroSQL(THIS.this_nNumes)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigRedcuMail")
                IF loc_nResult > 0
                    SELECT cursor_4c_SigRedcuMail
                    IF !EOF()
                        loc_cEmailDest = ALLTRIM(NVL(emails, ""))
                    ENDIF
                    IF USED("cursor_4c_SigRedcuMail")
                        USE IN cursor_4c_SigRedcuMail
                    ENDIF
                ENDIF
            ENDIF
            IF EMPTY(loc_cEmailDest)
                THIS.this_cMensagemErro = "E-mail de destino n" + CHR(227) + "o definido"
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(par_cAnexo) OR !FILE(par_cAnexo)
                THIS.this_cMensagemErro = "Arquivo anexo n" + CHR(227) + "o encontrado"
                loc_lSucesso = .F.
            ENDIF
            loc_cAssunto = "Documento " + ALLTRIM(THIS.this_cDopes) + ;
                           " N" + CHR(250) + "mero " + TRANSFORM(THIS.this_nNumes)
            ForeMails(loc_cEmailDest, loc_cAssunto, par_cAnexo, ;
                      PADR(THIS.this_cEmps, 3))
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigredcuBO.EnviarEmail")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.this_oFormPai = .NULL.
        DODEFAULT()
    ENDPROC

ENDDEFINE

