# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (3)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'SELECAOICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: 0, GRUPOS, CONTAS, MOEDAS, EMPS, DATAS, DATACONCS, CONCS, CEMPS, CPROS, DOPES, TIPOOPS, TPGDMIS, ATUCOMPRAS, EMPDOPNUMS, ICLIS, I, GERGDMIS, MULTCOMPS

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
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
  ControlSource = ""
		ProgSel.Update(.T.)
				lcQuery = [ Select Cemps From SigCdEmp ]
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEmps') < 1)
				Select TmpEmps
					Insert into TmpConta (Emps, Grupos,Contas,Moedas,CidChaves) Values ;
					Select TmpEmps
				Insert into TmpConta (Emps,Grupos,Contas,Moedas,CidChaves) Values ;
			lcQuery = [ Select Distinct Emps, Grupos, Contas, Moedas, Space(20) as CidChaves From SigMvCcr ]+lcWhere+;
					  [ Select Distinct Emps, Grupos, Contas, Moedas, Space(20) as CidChaves From SigMvCcr ]+lcWherc
			If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpConta') < 1)
			Select TmpConta
			Select * From TmpConta Into Cursor Selecao Order by Emps,Grupos,Contas,Moedas
			Select Selecao
				ProgConta.Update( .t. )
				Select TmpConta
				If Seek(Selecao.CidChaves)
					Delete
		lcQuery = [ Select Distinct Emps, Grupos, Estos, Cpros, CodCors, CodTams, Space(20) as CidChaves From SigMvHst ]+lcWhere
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TmpEst') < 1)
		Select TmpEst
			Select * From TmpEst Into Cursor Selecao
			Select Selecao
			Select Selecao
				ProgConta.Update( .t. )
				Select TmpEst
				If Seek(Selecao.CidChaves)
					Delete
		lcQuery = [Select Cemps ] + ;
				    [From SigCdEmp ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalEmp') < 1)
		lcQuery = [Select Calccustos From SigCdPac ]
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalParac') < 1)
		lcQuery = [Select Cpros ] + ;
				    [From SigCdPro ] + ;
		If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro2') < 1)
		Select LocalEmp
				lcQuery = [Select Distinct Cpros ] + ;
				    [From SigMvEst ] + ;
				If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
				Select * From LocalPro2 Into Cursor LocalPro ReadWrite
			Select LocalPro
				loCusto.Update(.t.)
		Select CrSigOpClU
		lcSql = [Select a.datas,a.Emps,a.Dopes,a.Numes,a.EmpDopNums,a.Valos,a.Contads,a.ContaOs,]+;
				[From SigMvCab a, SigCdOpe b, SigCdTom c ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'TprMvCab') < 1)
		lcSql = [Select Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas From SigMvItn ]+;
				[Where EmpDopNums in (Select EmpDopNums	From SigMvCab a, SigCdOpe b, SigCdTom c ]+;
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'crTpmMvItn') < 1)
		lcSql = [Select EmpDopNums From SigOpClU ]
		If (ThisForm.poDataMgr.SqlExecute(lcSql, 'LocCalcU') < 1)
		Select LocCalcU
		Select TprMvCab
		Select crTpmMvItn
		Select TprMvCab
			loCusto.Update(.t.)
			If Seek(TprMvCab.EmpDopNums,'LocCalcU','EmpdopNums')
				Insert Into CrSigOpClU (Emps,Dopes,Numes,EmpdopNums,iclis,Valors,Datas,Cidchaves) Values ;
				Select crTpmMvItn
				=Seek(TprMvCab.EmpDopNums)
					lcSql = [Select Cpros, UltComps From SigCdPro Where Cpros = ']+crTpmMvItn.Cpros+[']
					If thisform.Podatamgr.sqlexecute(lcsql,'TmpPro') < 1
						MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Select SigCdPro)')
					Insert Into CrSigOpClU (Emps,Dopes,Numes,empDopNums,cpros,Valors,Datas,Moedas,Cidchaves) Values ;
		If Not ThisForm.Podatamgr.Update('CrSigOpClU')
			=MessageBox('Favor Reinicializar o Processo!!!', 16, 'Falha na Conexão (Update CrSigOpClU)')
		lcSql = [Select * From SigOpClU ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'CsSelecao')
		Select Distinct Iclis From CsSelecao Into Cursor Selecao
		Select Selecao
			loCusto.Update(.t.)
			lcSql = [Select Top 1 Iclis,Datas,Valors From SigOpClU Where Iclis = ']+lcConta+[' ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCalcU') < 1
			lcUpDate = [UpDate SigCdCli Set UltComps = ?llData, vUltComps = ]+Str(LocalCalcU.Valors,12,2)+[ Where Iclis = ']+lcConta+[']
			If ThisForm.podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdCli)')
			lcSql = [Select Top 1 Iclis,Datas,Valors From SigOpClU Where Iclis = ']+lcConta+[' ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCalcU') < 1
			lcUpDate = [UpDate SigCdCli Set dtfats = ?llData, mfats = ]+Str(LocalCalcU.Valors,12,2)+[ Where Iclis = ']+lcConta+[']
			If ThisForm.podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdCli 2)')
		Select Distinct Cpros From CsSelecao Into Cursor Selecao
		Select Selecao
			loCusto.Update(.t.)
			lcSql = [Select Top 1 Cpros,Datas,Valors,Moedas From SigOpClU Where Cpros = ']+Selecao.Cpros+[' ]+;
			If ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalCalcU') < 1
			lcUpDate = [UpDate SigCdPro Set UltComps = ?llData, vUltComps = ]+Str(lnValor,12,2)+[, ]+;
			If ThisForm.podatamgr.SqlExecute(lcUpDate,'') < 1
				MessageBox('Favor reinicializar o processo.',16,'Falha na Conexão (Update SigCdPro)')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCcc.prg) - PRIMEIRAS 1912 de 1912 linhas:
*==============================================================================
* FormSigPrCcc.prg - Rec" + CHR(225) + "lculo de Saldos (SIGPRCCC)
* Form OPERACIONAL - Herda de FormBase
* Legado: SIGPRCCC.SCX
*
* Pilares:
*   UX   -> layout PIXEL-PERFECT identico ao legado (800px -> 1000px)
*   BD   -> SigOpClU / SigMvCcr / SigMvHst / SigMvCab / SigMvItn
*   CODE -> arquitetura em camadas (FormBase / SigPrCccBO)
*==============================================================================
DEFINE CLASS FormSigPrCcc AS FormBase

    *-- Dimensoes (escala 1000/800 = 1.25 do original)
    Width        = 1000
    Height       = 600

    *-- Form sem barra de titulo (identico ao legado TitleBar=0)
    TitleBar     = 0
    ShowWindow = 1
    WindowType = 1
    ControlBox   = .F.
    Closable     = .F.
    MaxButton    = .F.
    MinButton    = .F.
    Movable      = .F.

    *-- Aparencia
    AutoCenter   = .T.
    DataSession  = 2
    ShowTips     = .T.
    ClipControls = .F.
    BorderStyle  = 2
    FontName     = "Tahoma"
    FontSize     = 8

    *-- Business Object
    this_oBusinessObject = .NULL.

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *  DODEFAULT() chama FormBase.Init() -> THIS.InicializarForm()
    *--------------------------------------------------------------------------
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarForm()
    *  Cria toda a estrutura visual do form OPERACIONAL
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Modo validacao UI: nao executa SQL
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = .T.
            ENDIF

            *-- Verificar conexao principal
            IF gnConnHandle <= 0
                MsgErro("Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + ;
                        "o estabelecida.", "Erro de Conex" + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Criar Business Object
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrCccBO")
            IF VARTYPE(THIS.this_oBusinessObject) != "O"
                MsgErro("Falha ao criar objeto de neg" + CHR(243) + "cios.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Configuracao base do form (Picture, dimensoes, caption)
            *-- Nome ConfigurarPageFrame mantido por convencao do pipeline mesmo
            *-- nao havendo PageFrame neste form OPERACIONAL (layout flat).
            THIS.ConfigurarPageFrame()

            *-- Criar estrutura visual
            THIS.ConfigurarCabecalho()
            THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
            THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
            THIS.ConfigurarCheckboxes()
            THIS.ConfigurarBotoesPrincipais()
            THIS.ConfigurarContaineresOpcoes()
            THIS.ConfigurarPaginaDados()
            THIS.ConfigurarBINDEVENTs()
            THIS.ConfigurarRodape()

            *-- Tornar controles visiveis (exceto containers de opcoes e LblEnd)
            THIS.TornarControlesVisiveis(THIS)

            *-- Aplicar estado inicial: checkboxes off, containers ocultos,
            *   contador zerado, botao Processar desabilitado
            THIS.ConfigurarPaginaLista()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPageFrame()
    *  Configuracao base do form OPERACIONAL (layout flat, sem PageFrame).
    *  Ajusta Picture, Caption, dimensoes e centralizacao. Mantem o nome
    *  ConfigurarPageFrame por convencao do pipeline de migracao.
    *--------------------------------------------------------------------------
        LOCAL loc_cImgFundo

        *-- Titulo do form (para telemetria/tracing; TitleBar=0 nao mostra)
        THIS.Caption = "Rec" + CHR(225) + "lculo de Saldos"

        *-- Imagem de fundo do framework
        loc_cImgFundo = gc_4c_CaminhoIcones + "new_background.jpg"
        IF FILE(loc_cImgFundo)
            THIS.Picture = loc_cImgFundo
        ENDIF

        *-- Reforca dimensoes canonicas (escala 1.25x do legado 800x600)
        THIS.Width      = 1000
        THIS.Height     = 600
        THIS.AutoCenter = .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCabecalho()
    *  Container cinza escuro com titulo do form
    *--------------------------------------------------------------------------
        THIS.AddObject("cnt_4c_Cabecalho", "Container")
        WITH THIS.cnt_4c_Cabecalho
            .Top         = 0
            .Left        = 0
            .Width       = 1000
            .Height      = 80
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .BorderWidth = 0
            .Visible     = .T.

            .AddObject("lbl_4c_Sombra", "Label")
            WITH .lbl_4c_Sombra
                .Top       = 18
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 40
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(0, 0, 0)
                .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
                .Visible   = .T.
            ENDWITH

            .AddObject("lbl_4c_Titulo", "Label")
            WITH .lbl_4c_Titulo
                .Top       = 17
                .Left      = 10
                .Width     = THIS.Width
                .Height    = 46
                .AutoSize  = .F.
                .BackStyle = 0
                .FontBold  = .T.
                .FontName  = "Tahoma"
                .FontSize  = 18
                .ForeColor = RGB(255, 255, 255)
                .Caption   = "Rec" + CHR(225) + "lculo de Saldos"
                .Visible   = .T.
            ENDWITH
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarCheckboxes()
    *  Shape de fundo decorativo + 4 checkboxes de selecao de modulo
    *  Posicoes escaladas 1.25x do original (800->1000)
    *--------------------------------------------------------------------------
        *-- Shape decorativo de fundo dos botoes de acao (direita)
        THIS.AddObject("shp_4c_Shape1", "Shape")
        WITH THIS.shp_4c_Shape1
            .Top         = 7
            .Left        = 871
            .Height      = 110
            .Width       = 112
            .BackStyle   = 0
            .BorderStyle = 0
            .BorderColor = RGB(136, 189, 188)
            .Visible     = .T.
        ENDWITH

        *-- CheckBox: Conta Corrente (original Left=350 -> 437)
        THIS.AddObject("chk_4c_Conta", "CheckBox")
        WITH THIS.chk_4c_Conta
            .Top           = 3
            .Left          = 437
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "C.C."
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = "Conta Corrente"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder42.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "a_cash1.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Estoque (original Left=425 -> 531)
        THIS.AddObject("chk_4c_Estoque", "CheckBox")
        WITH THIS.chk_4c_Estoque
            .Top           = 3
            .Left          = 531
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Estoque"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder22.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "a_diamd1.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Custo de Produto (original Left=500 -> 625)
        THIS.AddObject("chk_4c_BtnCusto", "CheckBox")
        WITH THIS.chk_4c_BtnCusto
            .Top           = 3
            .Left          = 625
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = "Custo"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder34.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH

        *-- CheckBox: Ultima Compra (original Left=575 -> 718)
        THIS.AddObject("chk_4c_BtnCompra", "CheckBox")
        WITH THIS.chk_4c_BtnCompra
            .Top           = 3
            .Left          = 718
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .AutoSize      = .F.
            .Alignment     = 1
            .BackStyle     = 0
            .Caption       = CHR(218) + "lt. Compra"
            .Value         = 0
            .SpecialEffect = 0
            .Style         = 1
            .ToolTipText   = CHR(218) + "ltima Compra"
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Picture       = gc_4c_CaminhoIcones + "folder27.ico"
            .DownPicture   = gc_4c_CaminhoIcones + "d_misc2.bmp"
            .Themes        = .F.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBotoesPrincipais()
    *  Botoes Processar e Encerrar (original Left=650/725 -> 812/906)
    *--------------------------------------------------------------------------
        *-- Botao Processar (inicia desabilitado - habilita quando algum checkbox marcado)
        THIS.AddObject("cmd_4c_Processar", "CommandButton")
        WITH THIS.cmd_4c_Processar
            .Top             = 3
            .Left            = 812
            .Height          = 75
            .Width           = 75
            .FontBold        = .T.
            .FontItalic      = .T.
            .FontName        = "Tahoma"
            .FontSize        = 8
            .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
            .Caption         = "Processar"
            .Enabled         = .F.
            .ToolTipText     = "Processar"
            .SpecialEffect   = 0
            .ForeColor       = RGB(90, 90, 90)
            .BackColor       = RGB(255, 255, 255)
            .Themes          = .T.
            .WordWrap        = .T.
            .Visible         = .T.
        ENDWITH

        *-- Botao Encerrar (Cancel=.T. -> ESC fecha o form)
        THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
        WITH THIS.cmd_4c_Encerrar
            .Top           = 3
            .Left          = 906
            .Height        = 75
            .Width         = 75
            .FontBold      = .T.
            .FontItalic    = .T.
            .FontName      = "Tahoma"
            .FontSize      = 8
            .Picture       = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
            .Cancel        = .T.
            .Caption       = "Encerrar"
            .ToolTipText   = "[ESC] Sair"
            .SpecialEffect = 0
            .ForeColor     = RGB(90, 90, 90)
            .BackColor     = RGB(255, 255, 255)
            .Themes           = .T.
            .WordWrap      = .T.
            .Visible       = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarContaineresOpcoes()
    *  4 containers de parametros - iniciam ocultos, toggled pelos checkboxes
    *  Posicoes escaladas 1.25x: Left=139->173, Width=536->670
    *--------------------------------------------------------------------------

        *-- Container: Opcoes de Conta Corrente (original Top=114)
        THIS.AddObject("cnt_4c_OpConta", "Container")
        WITH THIS.cnt_4c_OpConta
            .Top           = 114
            .Left          = 173
            .Width         = 670
            .Height        = 81
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Container: Opcoes de Estoque (original Top=200)
        THIS.AddObject("cnt_4c_OpEstoque", "Container")
        WITH THIS.cnt_4c_OpEstoque
            .Top           = 200
            .Left          = 173
            .Width         = 670
            .Height        = 143
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Container: Opcoes de Custo de Produto (original Top=349)
        THIS.AddObject("cnt_4c_OpCusto", "Container")
        WITH THIS.cnt_4c_OpCusto
            .Top           = 349
            .Left          = 173
            .Width         = 670
            .Height        = 92
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH

        *-- Container: Opcoes de Ultima Compra (original Top=447)
        THIS.AddObject("cnt_4c_OpCompra", "Container")
        WITH THIS.cnt_4c_OpCompra
            .Top           = 447
            .Left          = 173
            .Width         = 670
            .Height        = 91
            .BackStyle     = 0
            .BorderWidth   = 2
            .SpecialEffect = 2
            .BackColor     = RGB(192, 192, 255)
            .BorderColor   = RGB(90, 90, 90)
            .Visible       = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarRodape()
    *  Label "Registros:", contador numerico e label de conclusao
    *  Posicoes escaladas 1.25x do original
    *--------------------------------------------------------------------------
        *-- Label "Registros : " (original Left=171 -> 213)
        THIS.AddObject("lbl_4c_Registros", "Label")
        WITH THIS.lbl_4c_Registros
            .Top       = 547
            .Left      = 213
            .Width     = 65
            .Height    = 15
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(90, 90, 90)
            .Caption   = "Registros : "
            .Visible   = .T.
        ENDWITH

        *-- TextBox contador (original Left=238 -> 297, Width=93 -> 116)
        *  ReadOnly: legado usa When=Return .F. para impedir foco
        THIS.AddObject("txt_4c_Registro", "TextBox")
        WITH THIS.txt_4c_Registro
            .Top           = 543
            .Left          = 297
            .Width         = 116
            .Height        = 23
            .FontName      = "Tahoma"
            .FontSize      = 8
            .InputMask     = "999,999,999"
            .SpecialEffect = 1
            .ForeColor     = RGB(0, 0, 0)
            .Value         = 0
            .ReadOnly      = .T.
            .TabStop       = .F.
            .Visible       = .T.
        ENDWITH

        *-- Label conclusao (oculto, exibido ao terminar processamento)
        *  original Left=361 -> 451, Width=205 -> 256
        THIS.AddObject("lbl_4c_LblEnd", "Label")
        WITH THIS.lbl_4c_LblEnd
            .Top       = 545
            .Left      = 451
            .Width     = 256
            .Height    = 22
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Arial"
            .FontSize  = 12
            .Alignment = 2
            .ForeColor = RGB(255, 0, 0)
            .Caption   = "Processamento Conclu" + CHR(237) + "do"
            .Visible   = .F.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpConta()
    *  Sub-controles de cnt_4c_OpConta (Opcoes Conta Corrente)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpConta

        loc_oCnt.AddObject("lbl_4c_TituloConta", "Label")
        WITH loc_oCnt.lbl_4c_TituloConta
            .Top       = 2
            .Left      = 213
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de Conta Corrente"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaConta", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaConta
            .Top       = 23
            .Left      = 20
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaConta", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaConta
            .Top       = 20
            .Left      = 93
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_GruposConta", "Label")
        WITH loc_oCnt.lbl_4c_GruposConta
            .Top       = 24
            .Left      = 152
            .Width     = 52
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_GruposConta", "TextBox")
        WITH loc_oCnt.txt_4c_GruposConta
            .Top       = 20
            .Left      = 207
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ContasConta", "Label")
        WITH loc_oCnt.lbl_4c_ContasConta
            .Top       = 24
            .Left      = 318
            .Width     = 51
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Conta :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ContasConta", "TextBox")
        WITH loc_oCnt.txt_4c_ContasConta
            .Top       = 20
            .Left      = 372
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_MoedasConta", "Label")
        WITH loc_oCnt.lbl_4c_MoedasConta
            .Top       = 50
            .Left      = 33
            .Width     = 57
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Moeda :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_MoedasConta", "TextBox")
        WITH loc_oCnt.txt_4c_MoedasConta
            .Top       = 46
            .Left      = 93
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataConta", "Label")
        WITH loc_oCnt.lbl_4c_DataConta
            .Top       = 50
            .Left      = 151
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataConta", "TextBox")
        WITH loc_oCnt.txt_4c_DataConta
            .Top       = 46
            .Left      = 238
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpEstoque()
    *  Sub-controles de cnt_4c_OpEstoque (Opcoes de Estoque)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpEstoque

        loc_oCnt.AddObject("lbl_4c_TituloEst", "Label")
        WITH loc_oCnt.lbl_4c_TituloEst
            .Top       = 2
            .Left      = 227
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de Estoque"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaEst", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaEst
            .Top       = 15
            .Left      = 38
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaEst", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaEst
            .Top       = 12
            .Left      = 112
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_GruposEst", "Label")
        WITH loc_oCnt.lbl_4c_GruposEst
            .Top       = 40
            .Left      = 57
            .Width     = 52
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Grupo :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_GruposEst", "TextBox")
        WITH loc_oCnt.txt_4c_GruposEst
            .Top       = 37
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EstoqueEst", "Label")
        WITH loc_oCnt.lbl_4c_EstoqueEst
            .Top       = 65
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Estoque :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EstoqueEst", "TextBox")
        WITH loc_oCnt.txt_4c_EstoqueEst
            .Top       = 62
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ProdutoEst", "Label")
        WITH loc_oCnt.lbl_4c_ProdutoEst
            .Top       = 90
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ProdutoEst", "TextBox")
        WITH loc_oCnt.txt_4c_ProdutoEst
            .Top       = 87
            .Left      = 112
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DescsEst", "TextBox")
        WITH loc_oCnt.txt_4c_DescsEst
            .Top       = 87
            .Left      = 248
            .Width     = 408
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataEst", "Label")
        WITH loc_oCnt.lbl_4c_DataEst
            .Top       = 115
            .Left      = 25
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataEst", "TextBox")
        WITH loc_oCnt.txt_4c_DataEst
            .Top       = 112
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpCusto()
    *  Sub-controles de cnt_4c_OpCusto (Opcoes de Custo de Produto)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpCusto

        loc_oCnt.AddObject("lbl_4c_TituloCusto", "Label")
        WITH loc_oCnt.lbl_4c_TituloCusto
            .Top       = 2
            .Left      = 193
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de Custo de Produto"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaCusto", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaCusto
            .Top       = 14
            .Left      = 38
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaCusto", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaCusto
            .Top       = 11
            .Left      = 112
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ProdutoCusto", "Label")
        WITH loc_oCnt.lbl_4c_ProdutoCusto
            .Top       = 39
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ProdutoCusto", "TextBox")
        WITH loc_oCnt.txt_4c_ProdutoCusto
            .Top       = 36
            .Left      = 112
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DescsCusto", "TextBox")
        WITH loc_oCnt.txt_4c_DescsCusto
            .Top       = 36
            .Left      = 248
            .Width     = 408
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataCusto", "Label")
        WITH loc_oCnt.lbl_4c_DataCusto
            .Top       = 64
            .Left      = 25
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataCusto", "TextBox")
        WITH loc_oCnt.txt_4c_DataCusto
            .Top       = 61
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarConteudoOpCompra()
    *  Sub-controles de cnt_4c_OpCompra (Opcoes de Ultima Compra)
    *--------------------------------------------------------------------------
        LOCAL loc_oCnt
        loc_oCnt = THIS.cnt_4c_OpCompra

        loc_oCnt.AddObject("lbl_4c_TituloCompra", "Label")
        WITH loc_oCnt.lbl_4c_TituloCompra
            .Top       = 2
            .Left      = 175
            .AutoSize  = .T.
            .BackStyle = 0
            .FontBold  = .T.
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 128)
            .Caption   = "Op" + CHR(231) + CHR(245) + "es de " + CHR(218) + "ltima Compra do Produto/Cliente"
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_EmpresaCompra", "Label")
        WITH loc_oCnt.lbl_4c_EmpresaCompra
            .Top       = 14
            .Left      = 38
            .Width     = 71
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Empresa :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_EmpresaCompra", "TextBox")
        WITH loc_oCnt.txt_4c_EmpresaCompra
            .Top       = 10
            .Left      = 112
            .Width     = 38
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_ProdutoCompra", "Label")
        WITH loc_oCnt.lbl_4c_ProdutoCompra
            .Top       = 39
            .Left      = 43
            .Width     = 66
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "Produto :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_ProdutoCompra", "TextBox")
        WITH loc_oCnt.txt_4c_ProdutoCompra
            .Top       = 35
            .Left      = 112
            .Width     = 135
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DescsCompra", "TextBox")
        WITH loc_oCnt.txt_4c_DescsCompra
            .Top       = 35
            .Left      = 248
            .Width     = 408
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = ""
            .Visible   = .T.
        ENDWITH

        loc_oCnt.AddObject("lbl_4c_DataCompra", "Label")
        WITH loc_oCnt.lbl_4c_DataCompra
            .Top       = 64
            .Left      = 25
            .Width     = 85
            .Height    = 15
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Caption   = "A partir de :"
            .Visible   = .T.
        ENDWITH
        loc_oCnt.AddObject("txt_4c_DataCompra", "TextBox")
        WITH loc_oCnt.txt_4c_DataCompra
            .Top       = 60
            .Left      = 112
            .Width     = 100
            .Height    = 23
            .FontName  = "Tahoma"
            .FontSize  = 8
            .Value     = {}
            .Visible   = .T.
        ENDWITH
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
    *--------------------------------------------------------------------------
        BINDEVENT(THIS.chk_4c_Conta,     "Click", THIS, "ChkContaClick")
        BINDEVENT(THIS.chk_4c_Estoque,   "Click", THIS, "ChkEstoqueClick")
        BINDEVENT(THIS.chk_4c_BtnCusto,  "Click", THIS, "ChkBtnCustoClick")
        BINDEVENT(THIS.chk_4c_BtnCompra, "Click", THIS, "ChkBtnCompraClick")

        BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
        BINDEVENT(THIS.cmd_4c_Encerrar,  "Click", THIS, "CmdEncerrarClick")

        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "KeyPress", THIS, "TxtEmpresaContaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta, "DblClick", THIS, "TxtEmpresaContaDblClick")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "KeyPress", THIS, "TxtMoedasContaKeyPress")
        BINDEVENT(THIS.cnt_4c_OpConta.txt_4c_MoedasConta,  "DblClick", THIS, "TxtMoedasContaDblClick")

        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "KeyPress", THIS, "TxtEmpresaEstKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst, "DblClick", THIS, "TxtEmpresaEstDblClick")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "KeyPress", THIS, "TxtProdutoEstKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, "DblClick", THIS, "TxtProdutoEstDblClick")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "KeyPress", THIS, "TxtDescsEstKeyPress")
        BINDEVENT(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst,   "DblClick", THIS, "TxtDescsEstDblClick")

        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "KeyPress", THIS, "TxtEmpresaCustoKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto, "DblClick", THIS, "TxtEmpresaCustoDblClick")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "KeyPress", THIS, "TxtProdutoCustoKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, "DblClick", THIS, "TxtProdutoCustoDblClick")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "KeyPress", THIS, "TxtDescsCustoKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto,   "DblClick", THIS, "TxtDescsCustoDblClick")

        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "KeyPress", THIS, "TxtEmpresaCompraKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra, "DblClick", THIS, "TxtEmpresaCompraDblClick")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "KeyPress", THIS, "TxtProdutoCompraKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, "DblClick", THIS, "TxtProdutoCompraDblClick")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "KeyPress", THIS, "TxtDescsCompraKeyPress")
        BINDEVENT(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra,   "DblClick", THIS, "TxtDescsCompraDblClick")
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AtualizarBotaoProcessar()
    *--------------------------------------------------------------------------
        THIS.cmd_4c_Processar.Enabled = (THIS.chk_4c_Conta.Value     = 1 OR ;
                                         THIS.chk_4c_Estoque.Value   = 1 OR ;
                                         THIS.chk_4c_BtnCusto.Value  = 1 OR ;
                                         THIS.chk_4c_BtnCompra.Value = 1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaLista()
    *  Reset do estado inicial (equivalente a Page1/LISTA em forms CRUD,
    *  adaptado para o form OPERACIONAL flat): reseta checkboxes de selecao
    *  de modulos, oculta containers de opcoes, esconde label de conclusao
    *  e zera contador de registros processados.
    *--------------------------------------------------------------------------
        *-- Checkboxes de selecao de modulos: desmarcados
        THIS.chk_4c_Conta.Value       = 0
        THIS.chk_4c_Estoque.Value     = 0
        THIS.chk_4c_BtnCusto.Value    = 0
        THIS.chk_4c_BtnCompra.Value   = 0

        *-- Containers de opcoes ocultos (togglados pelos checkboxes)
        THIS.cnt_4c_OpConta.Visible   = .F.
        THIS.cnt_4c_OpEstoque.Visible = .F.
        THIS.cnt_4c_OpCusto.Visible   = .F.
        THIS.cnt_4c_OpCompra.Visible  = .F.

        *-- Rodape: label de conclusao oculto e contador zerado
        THIS.lbl_4c_LblEnd.Visible    = .F.
        THIS.txt_4c_Registro.Value    = 0

        *-- Botao Processar inicia desabilitado (nenhum modulo selecionado)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ConfigurarPaginaDados()
    *  Fachada que agrupa a construcao dos "campos de dados" do form OPERACIONAL.
    *  Este form nao possui PageFrame CRUD; a entrada de parametros pelo usuario
    *  ocorre dentro dos 4 containers flutuantes de opcoes (Conta Corrente,
    *  Estoque, Custo, Ultima Compra), cada um com seus TextBoxes de empresa,
    *  grupo, conta, moeda, produto, descricao e data. Esta rotina cria todos
    *  esses campos de entrada, agrupando as chamadas ConfigurarConteudoOp*.
    *  Equivale, na semantica CRUD, ao "Page2 Dados" onde o usuario preenche
    *  os campos para a operacao.
    *--------------------------------------------------------------------------
        *-- Container OpConta: Empresa, Grupo, Conta, Moeda, Data
        THIS.ConfigurarConteudoOpConta()

        *-- Container OpEstoque: Empresa, Grupo, Estoque, Produto, Descricao, Data
        THIS.ConfigurarConteudoOpEstoque()

        *-- Container OpCusto: Empresa, Produto, Descricao, Data
        THIS.ConfigurarConteudoOpCusto()

        *-- Container OpCompra: Empresa, Produto, Descricao, Data
        THIS.ConfigurarConteudoOpCompra()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
    *  Alterna entre modos operacionais (adaptacao do padrao AlternarPagina
    *  dos forms CRUD para o form OPERACIONAL flat):
    *     par_nPagina = 1 -> Modo SELECAO: usuario escolhe modulos e opcoes
    *     par_nPagina = 2 -> Modo PROCESSAMENTO: controles bloqueados
    *--------------------------------------------------------------------------
        DO CASE
        CASE par_nPagina = 2
            *-- Modo PROCESSAMENTO: bloqueia todos os controles
            THIS.chk_4c_Conta.Enabled     = .F.
            THIS.chk_4c_Estoque.Enabled   = .F.
            THIS.chk_4c_BtnCusto.Enabled  = .F.
            THIS.chk_4c_BtnCompra.Enabled = .F.
            THIS.cmd_4c_Processar.Enabled = .F.
            THIS.cmd_4c_Encerrar.Enabled  = .F.
            THIS.lbl_4c_LblEnd.Visible    = .F.
            THIS.txt_4c_Registro.Value    = 0
        OTHERWISE
            *-- Modo SELECAO (par_nPagina = 1 ou omitido)
            THIS.chk_4c_Conta.Enabled     = .T.
            THIS.chk_4c_Estoque.Enabled   = .T.
            THIS.chk_4c_BtnCusto.Enabled  = .T.
            THIS.chk_4c_BtnCompra.Enabled = .T.
            THIS.cmd_4c_Encerrar.Enabled  = .T.
            THIS.AtualizarBotaoProcessar()
        ENDCASE
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkContaClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpConta.Visible = (THIS.chk_4c_Conta.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkEstoqueClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpEstoque.Visible = (THIS.chk_4c_Estoque.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkBtnCustoClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpCusto.Visible = (THIS.chk_4c_BtnCusto.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ChkBtnCompraClick()
    *--------------------------------------------------------------------------
        THIS.cnt_4c_OpCompra.Visible = (THIS.chk_4c_BtnCompra.Value = 1)
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdProcessarClick()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_oBO, loc_oErro
        loc_oBO      = THIS.this_oBusinessObject
        loc_lSucesso = .F.

        loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
        loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
        loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
        loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)

        IF loc_oBO.this_lProcessarConta
            loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
            loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
            loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
            loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
            loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
        ENDIF
        IF loc_oBO.this_lProcessarEstoque
            loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
            loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
            loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
            loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
            loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
            loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
        ENDIF
        IF loc_oBO.this_lProcessarCusto
            loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
            loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
            loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
            loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
        ENDIF
        IF loc_oBO.this_lProcessarCompra
            loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
            loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
            loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
            loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
        ENDIF

        *-- Modo PROCESSAMENTO: bloqueia controles durante execucao
        THIS.AlternarPagina(2)

        TRY
            loc_lSucesso = loc_oBO.Processar(THIS)
            THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
            IF loc_lSucesso
                THIS.lbl_4c_LblEnd.Visible = .T.
                MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso.", ;
                        "Rec" + CHR(225) + "lculo de Saldos")
            ELSE
                MsgAviso("Processamento conclu" + CHR(237) + "do com erros.", ;
                         "Rec" + CHR(225) + "lculo de Saldos")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao Processar")
        ENDTRY

        *-- Volta para modo SELECAO
        THIS.AlternarPagina(1)
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CmdEncerrarClick()
    *--------------------------------------------------------------------------
        THIS.Release()
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupEmpresa(par_oTxt)
    *  Lookup generico de empresa (SigCdEmp -> Cemps, Razas)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxt.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("Cemps", "XXXXXX", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaEmp")
                USE IN cursor_4c_BuscaEmp
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupProduto(par_oTxtCod, par_oTxtDesc)
    *  Lookup de produto por codigo (SigCdPro -> CPros, DPros)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxtCod.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaPro.CPros)
                    par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaPro.DPros)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaPro")
                USE IN cursor_4c_BuscaPro
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupDescricao(par_oTxtCod, par_oTxtDesc)
    *  Lookup de produto por descricao (SigCdPro -> DPros, CPros)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxtDesc.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdPro", "cursor_4c_BuscaDesc", "DPros", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Produto")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
                par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxtCod.Value  = ALLTRIM(cursor_4c_BuscaDesc.CPros)
                    par_oTxtDesc.Value = ALLTRIM(cursor_4c_BuscaDesc.DPros)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaDesc")
                USE IN cursor_4c_BuscaDesc
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AbrirLookupMoeda(par_oTxt)
    *  Lookup de moeda (SigCdMoe -> Cmoes, Dmoes)
    *--------------------------------------------------------------------------
        LOCAL loc_oForm, loc_cValor
        TRY
            loc_cValor = ALLTRIM(par_oTxt.Value)
            loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdMoe", "cursor_4c_BuscaMoe", "Cmoes", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Moeda")
            IF ISNULL(loc_oForm)
                RETURN
            ENDIF
            IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
                par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
            ELSE
                IF !loc_oForm.this_lAchouRegistro
                loc_oForm.mAddColuna("Cmoes", "", "Moe")
                loc_oForm.mAddColuna("Dmoes", "", "Nome")
                loc_oForm.Show()
                IF loc_oForm.this_lSelecionou
                    par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.Cmoes)
                ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_BuscaMoe")
                USE IN cursor_4c_BuscaMoe
            ENDIF
            loc_oForm.Release()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--- Handlers: cnt_4c_OpConta ---
    PROCEDURE TxtEmpresaContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaContaDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta)
    ENDPROC

    PROCEDURE TxtMoedasContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
        ENDIF
    ENDPROC

    PROCEDURE TxtMoedasContaDblClick()
        THIS.AbrirLookupMoeda(THIS.cnt_4c_OpConta.txt_4c_MoedasConta)
    ENDPROC

    *--- Handlers: cnt_4c_OpEstoque ---
    PROCEDURE TxtEmpresaEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaEstDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst)
    ENDPROC

    PROCEDURE TxtProdutoEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                    THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
        ENDIF
    ENDPROC

    PROCEDURE TxtProdutoEstDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
    ENDPROC

    PROCEDURE TxtDescsEstKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
                THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                          THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDescsEstDblClick()
        IF EMPTY(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
            THIS.AbrirLookupDescricao(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst, ;
                                      THIS.cnt_4c_OpEstoque.txt_4c_DescsEst)
        ENDIF
    ENDPROC

    *--- Handlers: cnt_4c_OpCusto ---
    PROCEDURE TxtEmpresaCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaCustoDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto)
    ENDPROC

    PROCEDURE TxtProdutoCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                    THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
        ENDIF
    ENDPROC

    PROCEDURE TxtProdutoCustoDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
    ENDPROC

    PROCEDURE TxtDescsCustoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
                THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                          THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDescsCustoDblClick()
        IF EMPTY(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
            THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto, ;
                                      THIS.cnt_4c_OpCusto.txt_4c_DescsCusto)
        ENDIF
    ENDPROC

    *--- Handlers: cnt_4c_OpCompra ---
    PROCEDURE TxtEmpresaCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
        ENDIF
    ENDPROC

    PROCEDURE TxtEmpresaCompraDblClick()
        THIS.AbrirLookupEmpresa(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra)
    ENDPROC

    PROCEDURE TxtProdutoCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                    THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
        ENDIF
    ENDPROC

    PROCEDURE TxtProdutoCompraDblClick()
        THIS.AbrirLookupProduto(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
    ENDPROC

    PROCEDURE TxtDescsCompraKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
            IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
                THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                          THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
            ENDIF
        ENDIF
    ENDPROC

    PROCEDURE TxtDescsCompraDblClick()
        IF EMPTY(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
            THIS.AbrirLookupDescricao(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra, ;
                                      THIS.cnt_4c_OpCompra.txt_4c_DescsCompra)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE TornarControlesVisiveis(par_oContainer)
    *  Torna controles visiveis recursivamente.
    *  EXCECOES (permanecem ocultos apos InicializarForm):
    *    - cnt_4c_OpConta/OpEstoque/OpCusto/OpCompra: toggled pelos checkboxes
    *    - lbl_4c_LblEnd: exibido apenas ao concluir processamento
    *--------------------------------------------------------------------------
        LOCAL loc_i, loc_p, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) != "O"
                LOOP
            ENDIF

            *-- Containers gerenciados: nao forcar .Visible via este metodo
            *  - CNT_4C_CABECALHO: visivel mas recursao ja garante filhos visiveis
            *  - CNT_4C_OPCONTA/OPESTOQUE/OPCUSTO/OPCOMPRA: toggled pelos checkboxes (inicia .F.)
            *  - LBL_4C_LBLEND: exibido apenas ao concluir processamento (inicia .F.)
            IF INLIST(UPPER(loc_oControl.Name), ;
                "CNT_4C_CABECALHO", ;
                "CNT_4C_OPCONTA", "CNT_4C_OPESTOQUE", ;
                "CNT_4C_OPCUSTO", "CNT_4C_OPCOMPRA", ;
                "LBL_4C_LBLEND")
                *-- Recursao nos filhos para que fiquem prontos quando container tornar visivel
                IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                    THIS.TornarControlesVisiveis(loc_oControl)
                ENDIF
                LOOP
            ENDIF

            IF PEMSTATUS(loc_oControl, "Visible", 5)
                loc_oControl.Visible = .T.
            ENDIF

            *-- Recursao para PageFrame (nao usado neste form, mas por padrao)
            IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                FOR loc_p = 1 TO loc_oControl.PageCount
                    THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
                ENDFOR
            ENDIF

            *-- Recursao para containers com filhos
            IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
                THIS.TornarControlesVisiveis(loc_oControl)
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnIncluirClick - Inicia um novo ciclo de recalculo de saldos
    * Form OPERACIONAL: mapeado para o disparo do processamento (equivalente
    * a "incluir" uma nova execucao). Delega para CmdProcessarClick.
    *--------------------------------------------------------------------------
    PROCEDURE BtnIncluirClick()
        LOCAL loc_oErro
        TRY
            IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
               THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
                MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + "o de processamento (Conta, Estoque, Custo ou " + CHR(250) + "lt. Compra).", ;
                         "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            THIS.lbl_4c_LblEnd.Visible = .F.
            THIS.txt_4c_Registro.Value = 0
            THIS.CmdProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao iniciar processamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnAlterarClick - Reexecuta o processamento com as opcoes atuais
    * Form OPERACIONAL: equivalente a "alterar" parametros e reprocessar.
    * Requer que pelo menos uma opcao esteja marcada.
    *--------------------------------------------------------------------------
    PROCEDURE BtnAlterarClick()
        LOCAL loc_oErro
        TRY
            IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
               THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
                MsgAviso("Nenhuma op" + CHR(231) + CHR(227) + "o marcada para reprocessar.", ;
                         "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            IF MsgConfirma("Reexecutar o processamento com as op" + CHR(231) + CHR(245) + "es atuais?", ;
                           "Rec" + CHR(225) + "lculo de Saldos")
                THIS.lbl_4c_LblEnd.Visible = .F.
                THIS.txt_4c_Registro.Value = 0
                THIS.CmdProcessarClick()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao reexecutar processamento")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnVisualizarClick - Exibe o resumo do ultimo processamento
    * Form OPERACIONAL: mostra os totais processados sem reexecutar.
    *--------------------------------------------------------------------------
    PROCEDURE BtnVisualizarClick()
        LOCAL loc_oBO, loc_nRegistros, loc_cMsg, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            loc_nRegistros = 0
            IF VARTYPE(loc_oBO) = "O" AND !ISNULL(loc_oBO)
                loc_nRegistros = loc_oBO.this_nRegistros
            ENDIF
            THIS.txt_4c_Registro.Value = loc_nRegistros

            loc_cMsg = "Resumo do " + CHR(250) + "ltimo processamento:" + CHR(13) + CHR(13) + ;
                       "Registros processados: " + TRANSFORM(loc_nRegistros) + CHR(13) + ;
                       "Conta Corrente......: " + IIF(THIS.chk_4c_Conta.Value    = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
                       "Estoque.............: " + IIF(THIS.chk_4c_Estoque.Value  = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
                       "Custo...............: " + IIF(THIS.chk_4c_BtnCusto.Value = 1, "SIM", "N" + CHR(227) + "O") + CHR(13) + ;
                       CHR(250) + "lt. Compra..........: " + IIF(THIS.chk_4c_BtnCompra.Value = 1, "SIM", "N" + CHR(227) + "O")

            THIS.lbl_4c_LblEnd.Visible = (loc_nRegistros > 0)
            MsgInfo(loc_cMsg, "Rec" + CHR(225) + "lculo de Saldos")
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao visualizar resumo")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * BtnExcluirClick - Cancela / reinicia a selecao de opcoes
    * Form OPERACIONAL: nao ha exclusao de dados; a acao reseta os
    * checkboxes, esconde os paineis flutuantes e zera o contador.
    *--------------------------------------------------------------------------
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + "es selecionadas?", ;
                            "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF

            THIS.chk_4c_Conta.Value     = 0
            THIS.chk_4c_Estoque.Value   = 0
            THIS.chk_4c_BtnCusto.Value  = 0
            THIS.chk_4c_BtnCompra.Value = 0

            THIS.cnt_4c_OpConta.Visible   = .F.
            THIS.cnt_4c_OpEstoque.Visible = .F.
            THIS.cnt_4c_OpCusto.Visible   = .F.
            THIS.cnt_4c_OpCompra.Visible  = .F.

            THIS.txt_4c_Registro.Value = 0
            THIS.lbl_4c_LblEnd.Visible = .F.

            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject.this_nRegistros = 0
            ENDIF

            THIS.AtualizarBotaoProcessar()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao limpar op" + CHR(231) + CHR(245) + "es")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE FormParaBO()
    *  Transfere os valores dos campos visuais para as propriedades do BO.
    *  Para o form OPERACIONAL: copia flags dos checkboxes e parametros
    *  de cada secao ativa para as propriedades this_* do BO.
    *--------------------------------------------------------------------------
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
                RETURN
            ENDIF

            loc_oBO.this_lProcessarConta   = (THIS.chk_4c_Conta.Value     = 1)
            loc_oBO.this_lProcessarEstoque = (THIS.chk_4c_Estoque.Value   = 1)
            loc_oBO.this_lProcessarCusto   = (THIS.chk_4c_BtnCusto.Value  = 1)
            loc_oBO.this_lProcessarCompra  = (THIS.chk_4c_BtnCompra.Value = 1)

            IF loc_oBO.this_lProcessarConta
                loc_oBO.this_cEmpConta    = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value)
                loc_oBO.this_cGruposConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value)
                loc_oBO.this_cContasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value)
                loc_oBO.this_cMoedasConta = ALLTRIM(THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value)
                loc_oBO.this_dDataConta   = THIS.cnt_4c_OpConta.txt_4c_DataConta.Value
            ENDIF

            IF loc_oBO.this_lProcessarEstoque
                loc_oBO.this_cEmpEstoque       = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value)
                loc_oBO.this_cGruposEstoque    = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value)
                loc_oBO.this_cEstoqueEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value)
                loc_oBO.this_cProdutoEstoque   = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value)
                loc_oBO.this_cDescricaoEstoque = ALLTRIM(THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value)
                loc_oBO.this_dDataEstoque      = THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value
            ENDIF

            IF loc_oBO.this_lProcessarCusto
                loc_oBO.this_cEmpCusto       = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value)
                loc_oBO.this_cProdutoCusto   = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value)
                loc_oBO.this_cDescricaoCusto = ALLTRIM(THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value)
                loc_oBO.this_dDataCusto      = THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value
            ENDIF

            IF loc_oBO.this_lProcessarCompra
                loc_oBO.this_cEmpCompra       = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value)
                loc_oBO.this_cProdutoCompra   = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value)
                loc_oBO.this_cDescricaoCompra = ALLTRIM(THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value)
                loc_oBO.this_dDataCompra      = THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BOParaForm()
    *  Transfere resultados do BO de volta para os campos visuais.
    *  Para o form OPERACIONAL: exibe o contador de registros processados
    *  e o label de conclusao quando houver resultado.
    *--------------------------------------------------------------------------
        LOCAL loc_oBO, loc_oErro
        TRY
            loc_oBO = THIS.this_oBusinessObject
            IF VARTYPE(loc_oBO) != "O" OR ISNULL(loc_oBO)
                RETURN
            ENDIF
            THIS.txt_4c_Registro.Value = loc_oBO.this_nRegistros
            THIS.lbl_4c_LblEnd.Visible = (loc_oBO.this_nRegistros > 0)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE LimparCampos()
    *  Limpa todos os campos de entrada nos 4 containers de opcoes e
    *  redefine flags/checkboxes para o estado inicial (sem selecao).
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            *-- Checkboxes
            THIS.chk_4c_Conta.Value     = 0
            THIS.chk_4c_Estoque.Value   = 0
            THIS.chk_4c_BtnCusto.Value  = 0
            THIS.chk_4c_BtnCompra.Value = 0

            *-- Campos de Conta Corrente
            THIS.cnt_4c_OpConta.txt_4c_EmpresaConta.Value = ""
            THIS.cnt_4c_OpConta.txt_4c_GruposConta.Value  = ""
            THIS.cnt_4c_OpConta.txt_4c_ContasConta.Value  = ""
            THIS.cnt_4c_OpConta.txt_4c_MoedasConta.Value  = ""
            THIS.cnt_4c_OpConta.txt_4c_DataConta.Value    = {}

            *-- Campos de Estoque
            THIS.cnt_4c_OpEstoque.txt_4c_EmpresaEst.Value = ""
            THIS.cnt_4c_OpEstoque.txt_4c_GruposEst.Value  = ""
            THIS.cnt_4c_OpEstoque.txt_4c_EstoqueEst.Value = ""
            THIS.cnt_4c_OpEstoque.txt_4c_ProdutoEst.Value = ""
            THIS.cnt_4c_OpEstoque.txt_4c_DescsEst.Value   = ""
            THIS.cnt_4c_OpEstoque.txt_4c_DataEst.Value    = {}

            *-- Campos de Custo
            THIS.cnt_4c_OpCusto.txt_4c_EmpresaCusto.Value = ""
            THIS.cnt_4c_OpCusto.txt_4c_ProdutoCusto.Value = ""
            THIS.cnt_4c_OpCusto.txt_4c_DescsCusto.Value   = ""
            THIS.cnt_4c_OpCusto.txt_4c_DataCusto.Value    = {}

            *-- Campos de Ultima Compra
            THIS.cnt_4c_OpCompra.txt_4c_EmpresaCompra.Value = ""
            THIS.cnt_4c_OpCompra.txt_4c_ProdutoCompra.Value = ""
            THIS.cnt_4c_OpCompra.txt_4c_DescsCompra.Value   = ""
            THIS.cnt_4c_OpCompra.txt_4c_DataCompra.Value    = {}

            *-- Rodape
            THIS.txt_4c_Registro.Value = 0
            THIS.lbl_4c_LblEnd.Visible = .F.

            *-- Oculta containers flutuantes
            THIS.cnt_4c_OpConta.Visible   = .F.
            THIS.cnt_4c_OpEstoque.Visible = .F.
            THIS.cnt_4c_OpCusto.Visible   = .F.
            THIS.cnt_4c_OpCompra.Visible  = .F.

            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject.this_nRegistros = 0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE HabilitarCampos(par_lHabilitar)
    *  Habilita ou desabilita todos os controles de entrada do form.
    *  Chamado por AlternarPagina para bloquear durante o processamento.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            THIS.chk_4c_Conta.Enabled     = par_lHabilitar
            THIS.chk_4c_Estoque.Enabled   = par_lHabilitar
            THIS.chk_4c_BtnCusto.Enabled  = par_lHabilitar
            THIS.chk_4c_BtnCompra.Enabled = par_lHabilitar
            THIS.cmd_4c_Encerrar.Enabled  = par_lHabilitar

            IF par_lHabilitar
                *-- Ao habilitar, Processar depende da selecao dos checkboxes
                THIS.AtualizarBotaoProcessar()
            ELSE
                THIS.cmd_4c_Processar.Enabled = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE AjustarBotoesPorModo()
    *  Atualiza o estado do botao Processar conforme selecao atual.
    *  Alias de AtualizarBotaoProcessar() para compatibilidade com
    *  o padrao do pipeline de migracao.
    *--------------------------------------------------------------------------
        THIS.AtualizarBotaoProcessar()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarLista()
    *  Reinicia o form para o estado inicial: desmarca checkboxes, oculta
    *  containers de opcoes e zera o contador. Equivalente ao "recarregar
    *  a lista" nos forms CRUD, adaptado para o form OPERACIONAL flat.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            THIS.ConfigurarPaginaLista()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnBuscarClick()
    *  Para o form OPERACIONAL: exibe o resumo do estado atual (opcoes
    *  selecionadas e registros do ultimo processamento). Equivalente ao
    *  "Buscar / Visualizar" nos forms CRUD.
    *--------------------------------------------------------------------------
        THIS.BtnVisualizarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnEncerrarClick()
    *  Fecha o form OPERACIONAL. Alias de CmdEncerrarClick() para
    *  compatibilidade com o padrao do pipeline de migracao.
    *--------------------------------------------------------------------------
        THIS.CmdEncerrarClick()
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnSalvarClick()
    *  Para o form OPERACIONAL: dispara o processamento de recalculo.
    *  Equivale ao "Salvar" nos forms CRUD, adaptado para este contexto.
    *  Valida selecao antes de processar.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF THIS.chk_4c_Conta.Value    = 0 AND THIS.chk_4c_Estoque.Value  = 0 AND ;
               THIS.chk_4c_BtnCusto.Value = 0 AND THIS.chk_4c_BtnCompra.Value = 0
                MsgAviso("Selecione ao menos uma op" + CHR(231) + CHR(227) + ;
                         "o de processamento.", "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            THIS.FormParaBO()
            THIS.lbl_4c_LblEnd.Visible = .F.
            THIS.txt_4c_Registro.Value = 0
            THIS.CmdProcessarClick()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao processar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE BtnCancelarClick()
    *  Para o form OPERACIONAL: limpa todas as selecoes e reinicia o form
    *  para o estado inicial. Equivale ao "Cancelar" nos forms CRUD.
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF !MsgConfirma("Limpar todas as op" + CHR(231) + CHR(245) + ;
                            "es e reiniciar?", "Rec" + CHR(225) + "lculo de Saldos")
                RETURN
            ENDIF
            THIS.LimparCampos()
            THIS.AjustarBotoesPorModo()
            THIS.Refresh()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao cancelar")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
    *--------------------------------------------------------------------------
        LOCAL loc_oErro
        TRY
            IF VARTYPE(THIS.this_oBusinessObject) = "O" AND !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject = .NULL.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        DODEFAULT()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\SigPrCccBO.prg):
*==============================================================================
* SigPrCccBO.prg - Business Object para Rec?lculo de Saldos
* Herda de: BusinessBase
* Entidade: SigPrCcc
* Tabela principal: SigOpClU (ultima compra por cliente/produto)
*==============================================================================
DEFINE CLASS SigPrCccBO AS BusinessBase

    *-- Identificacao da entidade
    this_cTabela     = "SigOpClU"
    this_cCampoChave = "CidChaves"

    *-- Filtros secao Conta Corrente (OpConta)
    this_cEmpConta     = ""
    this_cGruposConta  = ""
    this_cContasConta  = ""
    this_cMoedasConta  = ""
    this_dDataConta    = {}

    *-- Filtros secao Estoque (OpEstoque)
    this_cEmpEstoque       = ""
    this_cGruposEstoque    = ""
    this_cEstoqueEstoque   = ""
    this_cProdutoEstoque   = ""
    this_cDescricaoEstoque = ""
    this_dDataEstoque      = {}

    *-- Filtros secao Custo de Produto (OpCusto)
    this_cEmpCusto       = ""
    this_cProdutoCusto   = ""
    this_cDescricaoCusto = ""
    this_dDataCusto      = {}

    *-- Filtros secao Ultima Compra (OpCompra)
    this_cEmpCompra       = ""
    this_cProdutoCompra   = ""
    this_cDescricaoCompra = ""
    this_dDataCompra      = {}

    *-- Flags de processamento (estado dos checkboxes)
    this_lProcessarConta   = .F.
    this_lProcessarEstoque = .F.
    this_lProcessarCusto   = .F.
    this_lProcessarCompra  = .F.

    *-- Contador de registros (exibido no txt_4c_Registro)
    this_nRegistros = 0

    *-- Conexao legada para funcoes de recalculo do Framework
    this_oDataMgr = .NULL.

    *-- Campos da tabela SigOpClU (para CRUD direto)
    this_cCidchaves   = ""
    this_cCpros       = ""
    this_dDatas       = {}
    this_cDopes       = ""
    this_cEmpdopnums  = ""
    this_cEmps        = ""
    this_cIclis       = ""
    this_cMoedas      = ""
    this_nNumes       = 0
    this_nValors      = 0
    this_nQtds        = 0

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
    *  Retorna a chave primaria (CidChaves) do registro atual.
    *  Se estiver vazia (novo registro), gera nova via SYS(2015)+SYS(2015).
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cCidchaves)
            RETURN SYS(2015) + SYS(2015)
        ENDIF
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
    *  Limpa propriedades da tabela SigOpClU (novo registro)
    *--------------------------------------------------------------------------
        THIS.this_cCidchaves   = ""
        THIS.this_cCpros       = ""
        THIS.this_dDatas       = {}
        THIS.this_cDopes       = ""
        THIS.this_cEmpdopnums  = ""
        THIS.this_cEmps        = ""
        THIS.this_cIclis       = ""
        THIS.this_cMoedas      = ""
        THIS.this_nNumes       = 0
        THIS.this_nValors      = 0
        THIS.this_nQtds        = 0
        THIS.this_cMensagemErro = ""
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
    *  Carrega dados de SigOpClU do cursor para as propriedades this_*.
    *  Segue padrao canonico: SELECT (alias) + acesso direto aos campos.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor '" + par_cAliasCursor + "' n" + CHR(227) + "o est" + CHR(225) + " aberto"
                loc_lSucesso = .F.
            ENDIF

            SELECT (par_cAliasCursor)

            THIS.this_cCidchaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCpros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cDopes      = TratarNulo(dopes,      "C")
            THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
            THIS.this_cEmps       = TratarNulo(emps,       "C")
            THIS.this_cIclis      = TratarNulo(iclis,      "C")
            THIS.this_cMoedas     = TratarNulo(moedas,     "C")
            THIS.this_nNumes      = TratarNulo(numes,      "N")
            THIS.this_nValors     = TratarNulo(valors,     "N")
            THIS.this_nQtds       = TratarNulo(qtds,       "N")

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar do cursor: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
    *  Valida campos obrigatorios de SigOpClU antes de INSERT/UPDATE.
    *--------------------------------------------------------------------------
        IF EMPTY(THIS.this_cEmps)
            THIS.this_cMensagemErro = "Empresa " + CHR(233) + " obrigat" + CHR(243) + "ria"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cDopes)
            THIS.this_cMensagemErro = "Documento " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nNumes <= 0
            THIS.this_cMensagemErro = "N" + CHR(250) + "mero da opera" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "rio"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_cEmpdopnums)
            THIS.this_cEmpdopnums = ALLTRIM(THIS.this_cEmps) + ALLTRIM(THIS.this_cDopes) + ;
                                    PADL(ALLTRIM(TRANSFORM(THIS.this_nNumes)), 6, "0")
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *  INSERT INTO SigOpClU. Gera nova CidChaves se vazia.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpClU " + ;
                       "(cidchaves, cpros, datas, dopes, empdopnums, " + ;
                       " emps, iclis, moedas, numes, valors, qtds) " + ;
                       "VALUES (" + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       FormatarNumeroSQL(THIS.this_nQtds)        + ")"

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao inserir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inserir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *  UPDATE SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE SigOpClU SET " + ;
                       "cpros = "      + EscaparSQL(ALLTRIM(THIS.this_cCpros))     + ", " + ;
                       "datas = "      + IIF(EMPTY(THIS.this_dDatas), "NULL", FormatarDataSQL(THIS.this_dDatas)) + ", " + ;
                       "dopes = "      + EscaparSQL(ALLTRIM(THIS.this_cDopes))     + ", " + ;
                       "empdopnums = " + EscaparSQL(ALLTRIM(THIS.this_cEmpdopnums))+ ", " + ;
                       "emps = "       + EscaparSQL(ALLTRIM(THIS.this_cEmps))      + ", " + ;
                       "iclis = "      + EscaparSQL(ALLTRIM(THIS.this_cIclis))     + ", " + ;
                       "moedas = "     + EscaparSQL(ALLTRIM(THIS.this_cMoedas))    + ", " + ;
                       "numes = "      + FormatarNumeroSQL(THIS.this_nNumes)       + ", " + ;
                       "valors = "     + FormatarNumeroSQL(THIS.this_nValors)      + ", " + ;
                       "qtds = "       + FormatarNumeroSQL(THIS.this_nQtds)        + " " + ;
                       "WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao atualizar registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao atualizar: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *  DELETE FROM SigOpClU pelo cidchaves.
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cSQL, loc_nRetorno
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cMensagemErro = "Chave prim" + CHR(225) + "ria (cidchaves) n" + CHR(227) + "o informada"
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM SigOpClU WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

            loc_nRetorno = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRetorno < 0
                THIS.this_cMensagemErro = "Falha ao excluir registro em SigOpClU"
                loc_lSucesso = .F.
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao excluir: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE InicializarConexao()
    *  Cria conexao legada para funcoes de recalculo do Framework (fSqlConector)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF VARTYPE(THIS.this_oDataMgr) != "O" OR ISNULL(THIS.this_oDataMgr)
                THIS.this_oDataMgr = CREATEOBJECT('fSqlConector', 'RECSALDO', .T.)
                IF THIS.this_oDataMgr.pnIdConn > 0
                    THIS.this_oDataMgr.AddCursor('SigOpClU', 'CidChaves', 'CrSigOpClU')
                    THIS.this_oDataMgr.Cursorquery('SigCdPam', 'CrSigCdPam', .F., .F., ;
                        'GrupoRecs,GrupoPags,ContaRecs,ContaPags,MoeCentral')
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Imposs" + CHR(237) + "vel efetuar conex" + CHR(227) + ;
                            "o com o servidor de banco de dados.", "Erro de Conex" + CHR(227) + "o")
                ENDIF
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_oForm)
    *  Metodo principal: executa todos os recalculos selecionados via flags
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.InicializarConexao()
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.

                IF THIS.this_lProcessarConta
                    IF !THIS.ProcessarContaCorrente(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarEstoque
                    IF !THIS.ProcessarEstoque(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCusto
                    IF !THIS.ProcessarCusto(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF

                IF THIS.this_lProcessarCompra
                    IF !THIS.ProcessarUltimaCompra(par_oForm)
                        loc_lSucesso = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarContaCorrente(par_oForm)
    *  Recalcula saldos de Conta Corrente em SigMvCcr via fRecalculaS
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cGrupo, loc_cConta, loc_cMoeda
        LOCAL loc_dData, loc_cGcm, loc_llConc, loc_cWhere, loc_cWherC
        LOCAL loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta, loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEmp   = PADR(THIS.this_cEmpConta,    3)
            loc_cGrupo = PADR(THIS.this_cGruposConta, 10)
            loc_cConta = PADR(THIS.this_cContasConta, 10)
            loc_cMoeda = PADR(THIS.this_cMoedasConta,  3)
            loc_dData  = THIS.this_dDataConta
            loc_llConc = .T.
            loc_pData  = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)
            loc_cGcm   = IIF(!EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cConta) .AND. !EMPTY(loc_cMoeda), ;
                             loc_cGrupo + loc_cConta + loc_cMoeda, SPACE(23))

            loc_cWhere = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '" + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '" + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '" + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"   + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And Datas >= "  + FormatarDataSQL(loc_dData) + " ", " ")

            loc_cWherC = "Where 0 = 0 " + ;
                IIF(!EMPTY(loc_cGrupo), "And Grupos = '"    + ALLTRIM(loc_cGrupo) + "' ", " ") + ;
                IIF(!EMPTY(loc_cConta), "And Contas = '"    + ALLTRIM(loc_cConta) + "' ", " ") + ;
                IIF(!EMPTY(loc_cMoeda), "And Moedas = '"    + ALLTRIM(loc_cMoeda) + "' ", " ") + ;
                IIF(!EMPTY(loc_cEmp),   "And Emps = '"      + ALLTRIM(loc_cEmp)   + "' ", " ") + ;
                IIF(!EMPTY(loc_dData),  "And DataConcs >= " + FormatarDataSQL(loc_dData) + " ", " ") + ;
                "And Concs = 1 "

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
            CREATE CURSOR TmpConta (Emps C(3), Grupos C(10), Contas C(10), Moedas C(3), CidChaves C(20))
            INDEX ON CidChaves TAG CidChaves

            DO WHILE .T.
                IF !EMPTY(loc_cGcm)
                    IF EMPTY(loc_cEmp)
                        loc_cQuery = "Select Cemps From SigCdEmp"
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEmps') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (TmpEmps)", "Erro")
                            EXIT
                        ENDIF
                        SELECT TmpEmps
                        GO TOP
                        SCAN
                            INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                                VALUES (TmpEmps.Cemps, loc_cGrupo, loc_cConta, ;
                                        loc_cMoeda, SYS(2015)+SYS(2015))
                            SELECT TmpEmps
                        ENDSCAN
                        IF USED("TmpEmps")
                            USE IN TmpEmps
                        ENDIF
                    ELSE
                        INSERT INTO TmpConta (Emps, Grupos, Contas, Moedas, CidChaves) ;
                            VALUES (loc_cEmp, loc_cGrupo, loc_cConta, ;
                                    loc_cMoeda, SYS(2015)+SYS(2015))
                    ENDIF
                ELSE
                    loc_cQuery = "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWhere + ;
                                 " Union all " + ;
                                 "Select Distinct Emps, Grupos, Contas, Moedas, " + ;
                                 "Space(20) as CidChaves From SigMvCcr " + loc_cWherC
                    IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpConta') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (TmpConta)", "Erro")
                        EXIT
                    ENDIF
                    SELECT TmpConta
                    REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                    INDEX ON CidChaves TAG Cidchaves
                ENDIF

                *-- Processa os registros de TmpConta
                DO WHILE .T.
                    SELECT * FROM TmpConta INTO CURSOR Selecao ORDER BY Emps, Grupos, Contas, Moedas
                    SELECT Selecao
                    IF RECCOUNT() = 0
                        EXIT
                    ENDIF

                    loc_nReg      = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo de Conta Corrente', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)
                        loc_oProgConta.SubTitulo.Caption = ALLTRIM(Selecao.Grupos) + " : " + ;
                            ALLTRIM(Selecao.Contas) + "-" + ALLTRIM(Selecao.Moedas)

                        =fRecalculaS(Selecao.Grupos, Selecao.Contas, loc_pData, Selecao.Moedas)
                        loc_lOk = fRecalculaS(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpConta
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpConta")
                USE IN TmpConta
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEstoque(par_oForm)
    *  Recalcula saldos de Estoque em SigMvHst via fRecalculaP
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEstoque, loc_cEmpresa, loc_cGrupo, loc_cProduto
        LOCAL loc_dData, loc_cWhere, loc_cQuery, loc_lOk, loc_nReg, loc_oProgConta
        LOCAL loc_cEmpIni, loc_cGruIni, loc_cEstIni, loc_cEmpFin, loc_cGruFin, loc_cEstFin
        LOCAL loc_pData

        loc_lSucesso = .F.
        TRY
            loc_cEstoque = PADR(THIS.this_cEstoqueEstoque, 10)
            loc_cEmpresa = PADR(THIS.this_cEmpEstoque,     3)
            loc_cGrupo   = PADR(THIS.this_cGruposEstoque,  10)
            loc_cProduto = PADR(THIS.this_cProdutoEstoque, 14)
            loc_dData    = THIS.this_dDataEstoque
            loc_pData    = IIF(EMPTY(loc_dData), CTOD('01/01/1900'), loc_dData)

            DO CASE
                CASE !EMPTY(loc_cEmpresa) .AND. !EMPTY(loc_cGrupo) .AND. !EMPTY(loc_cEstoque)
                    loc_cWhere = "EmpGruEsts = '" + loc_cEmpresa + loc_cGrupo + loc_cEstoque + "' "
                CASE EMPTY(loc_cEmpresa) .AND. EMPTY(loc_cGrupo) .AND. EMPTY(loc_cEstoque)
                    loc_cWhere = ""
                OTHERWISE
                    loc_cEmpIni = IIF(EMPTY(loc_cEmpresa), SPACE(3),  loc_cEmpresa)
                    loc_cGruIni = IIF(EMPTY(loc_cGrupo),   SPACE(10), loc_cGrupo)
                    loc_cEstIni = IIF(EMPTY(loc_cEstoque),  SPACE(10), loc_cEstoque)
                    loc_cEmpFin = IIF(EMPTY(loc_cEmpresa), REPLICATE(CHR(254), 3),  loc_cEmpresa)
                    loc_cGruFin = IIF(EMPTY(loc_cGrupo),   REPLICATE(CHR(254), 10), loc_cGrupo)
                    loc_cEstFin = IIF(EMPTY(loc_cEstoque),  REPLICATE(CHR(254), 10), loc_cEstoque)
                    loc_cWhere  = "EmpGruEsts Between '" + ;
                                  loc_cEmpIni + loc_cGruIni + loc_cEstIni + "' And '" + ;
                                  loc_cEmpFin + loc_cGruFin + loc_cEstFin + "' "
            ENDCASE

            loc_cWhere = IIF(!EMPTY(loc_cProduto), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " CPros = '" + ALLTRIM(loc_cProduto) + "' ", loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_dData), ;
                IIF(!EMPTY(loc_cWhere), loc_cWhere + " And ", "") + ;
                " Datas >= " + FormatarDataSQL(loc_dData), loc_cWhere)
            loc_cWhere = IIF(!EMPTY(loc_cWhere), "Where " + loc_cWhere, "")

            loc_cQuery = "Select Distinct Emps, Grupos, Estos, Cpros, CodCors, CodTams, " + ;
                         "Space(20) as CidChaves From SigMvHst " + loc_cWhere

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'TmpEst') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TmpEst)", "Erro")
                    EXIT
                ENDIF

                SELECT TmpEst
                REPLACE ALL CidChaves WITH SYS(2015)+SYS(2015)
                INDEX ON CidChaves TAG CidChaves

                DO WHILE .T.
                    SELECT * FROM TmpEst INTO CURSOR Selecao
                    IF RECCOUNT('Selecao') = 0
                        EXIT
                    ENDIF

                    SELECT Selecao
                    loc_nReg       = RECCOUNT('Selecao')
                    loc_oProgConta = CREATEOBJECT('fwprogressbar', ;
                        'Recalculando Saldo do Estoque', loc_nReg)
                    loc_oProgConta.Titulo.FontBold = .T.
                    loc_oProgConta.Show

                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oProgConta.Update(.T.)

                        =fRecalculaP(Selecao.Emps, Selecao.Grupos, Selecao.Estos, ;
                                     Selecao.CPros, loc_pData, Selecao.CodCors, ;
                                     Selecao.CodTams, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaP(.T., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF

                        SELECT TmpEst
                        IF SEEK(Selecao.CidChaves)
                            DELETE
                        ENDIF
                    ENDSCAN

                    loc_oProgConta.Complete(.T., .T.)
                    IF USED("Selecao")
                        USE IN Selecao
                    ENDIF
                ENDDO

                loc_lSucesso = .T.
                EXIT
            ENDDO

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarCusto(par_oForm)
    *  Recalcula custo de produtos via fRecalculaC
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cQuery
        LOCAL loc_llEmp, loc_nReg, loc_lOk, loc_oCusto, loc_lParou

        loc_lSucesso = .F.
        TRY
            loc_cEmp = PADR(THIS.this_cEmpCusto,    3)
            loc_cPro = PADR(THIS.this_cProdutoCusto, 14)
            loc_dDat = THIS.this_dDataCusto

            loc_cQuery = "Select Cemps From SigCdEmp " + ;
                         "Where Not Cemps = Space(3)" + ;
                         IIF(EMPTY(loc_cEmp), "", " And Cemps = '" + ALLTRIM(loc_cEmp) + "'")

            DO WHILE .T.
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalEmp') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalEmp)", "Erro")
                    EXIT
                ENDIF

                loc_cQuery = "Select Calccustos From SigCdPac"
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalParac') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalParac)", "Erro")
                    EXIT
                ENDIF
                loc_llEmp = (LocalParac.CalcCustos <> 1)

                loc_cQuery = "Select Cpros From SigCdPro " + ;
                             "Where Not Cpros = Space(14)" + ;
                             IIF(EMPTY(loc_cPro), "", " And Cpros = '" + ALLTRIM(loc_cPro) + "'")
                IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro2') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocalPro2)", "Erro")
                    EXIT
                ENDIF

                loc_lParou = .F.
                SELECT LocalEmp
                SCAN
                    IF loc_llEmp
                        loc_cQuery = "Select Distinct Cpros From SigMvEst " + ;
                                     "Where Emps = " + EscaparSQL(ALLTRIM(LocalEmp.Cemps)) + " " + ;
                                     "And Not Cpros = Space(14)" + ;
                                     IIF(EMPTY(loc_cPro), "", " And Cpros = " + EscaparSQL(ALLTRIM(loc_cPro)) + " ")
                        IF THIS.this_oDataMgr.SqlExecute(loc_cQuery, 'LocalPro') < 1
                            MsgErro("Falha na conex" + CHR(227) + "o (LocalPro)", "Erro")
                            loc_lParou = .T.
                            EXIT
                        ENDIF
                    ELSE
                        SELECT * FROM LocalPro2 INTO CURSOR LocalPro READWRITE
                    ENDIF

                    loc_nReg  = RECCOUNT('LocalPro')
                    loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                        'Preparando Arquivo de Rec' + CHR(225) + 'lculo do Custo de Produtos', ;
                        loc_nReg)
                    loc_oCusto.Titulo.FontBold = .T.
                    loc_oCusto.Show

                    SELECT LocalPro
                    SCAN
                        loc_nReg = loc_nReg - 1
                        THIS.this_nRegistros = loc_nReg
                        IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                            par_oForm.txt_4c_Registro.Value = loc_nReg
                            par_oForm.txt_4c_Registro.Refresh
                        ENDIF
                        loc_oCusto.SubTitulo.Caption = "Empresa : " + LocalEmp.Cemps + ;
                                                        " - Produto : " + LocalPro.CPros
                        loc_oCusto.Update(.T.)

                        =fRecalculaC(LocalEmp.Cemps, LocalPro.CPros, loc_dDat, THIS.this_oDataMgr)
                        loc_lOk = fRecalculaC(.T., .T., .F., THIS.this_oDataMgr, .T.)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                        loc_lOk = (THIS.this_oDataMgr.Commit() > 0)
                        IF !loc_lOk
                            THIS.this_oDataMgr.Rollback()
                            LOOP
                        ENDIF
                    ENDSCAN

                    loc_oCusto.Complete(.T., .T.)

                    IF USED("LocalPro")
                        USE IN LocalPro
                    ENDIF
                    IF !loc_llEmp
                        EXIT
                    ENDIF
                ENDSCAN

                IF USED("LocalEmp")
                    USE IN LocalEmp
                ENDIF
                IF USED("LocalPro2")
                    USE IN LocalPro2
                ENDIF
                IF USED("LocalParac")
                    USE IN LocalParac
                ENDIF

                IF !loc_lParou
                    loc_lSucesso = .T.
                ENDIF
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarUltimaCompra(par_oForm)
    *  Reconstroi SigOpClU e atualiza SigCdCli/SigCdPro com ultima compra
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso, loc_cEmp, loc_cPro, loc_dDat, loc_cSql
        LOCAL loc_nReg, loc_oCusto, loc_cConta, loc_lOk
        LOCAL loc_lnCotaCentral, loc_lnCotaOperac, loc_lnValorCentral, loc_lnValor
        LOCAL loc_cMoeda, loc_ldData, loc_cUpDate

        loc_lSucesso = .F.
        TRY
            *-- Limpa cursor principal de ultima compra
            IF USED("CrSigOpClU")
                SELECT CrSigOpClU
                ZAP
            ENDIF

            loc_cEmp = PADR(THIS.this_cEmpCompra,    3)
            loc_cPro = PADR(THIS.this_cProdutoCompra, 14)
            loc_dDat = THIS.this_dDataCompra

            DO WHILE .T.
                *-- Seleciona movimentos de cabecalho com operacoes de compra
                loc_cSql = "Select a.datas, a.Emps, a.Dopes, a.Numes, a.EmpDopNums, " + ;
                           "a.Valos, a.Contads, a.ContaOs, " + ;
                           "c.GerGdmis, c.atuCompras, c.TpGdmis, b.cOpers, b.cmoes " + ;
                           "From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "((c.GerGdmis = 1 And c.TpGdmis = 1) Or " + ;
                           "(c.GerGdmis = 2 And c.AtuCompras = 1)) " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "")
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TprMvCab') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (TprMvCab)", "Erro")
                    EXIT
                ENDIF

                *-- Seleciona itens dos movimentos de compra por produto
                loc_cSql = "Select Emps, Dopes, Numes, EmpDopNums, Cpros, Units, Moedas " + ;
                           "From SigMvItn " + ;
                           "Where EmpDopNums in (" + ;
                           "Select EmpDopNums From SigMvCab a, SigCdOpe b, SigCdTom c " + ;
                           "Where a.Dopes = b.Dopes And b.TipoOps = c.Codigos And " + ;
                           "c.GerGdmis = 2 And c.AtuCompras = 1 " + ;
                           IIF(!EMPTY(loc_dDat), "And a.Datas >= " + FormatarDataSQL(loc_dDat) + " ", "") + ;
                           IIF(!EMPTY(loc_cEmp), "And a.Emps = '" + ALLTRIM(loc_cEmp) + "' ", "") + ;
                           ") "
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'crTpmMvItn') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (crTpmMvItn)", "Erro")
                    EXIT
                ENDIF

                *-- Carrega registros existentes em SigOpClU para verificar duplicidade
                loc_cSql = "Select EmpDopNums From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocCalcU') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (LocCalcU)", "Erro")
                    EXIT
                ENDIF

                SELECT LocCalcU
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT TprMvCab
                INDEX ON EmpDopNums TAG EmpDopNums
                SELECT crTpmMvItn
                INDEX ON EmpDopNums TAG EmpDopNums

                loc_nReg  = RECCOUNT('TprMvCab')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Preparando Arquivo de Atualiza' + CHR(231) + CHR(227) + ;
                    'o da Ultima Compra', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT TprMvCab
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = TprMvCab.Emps + " " + ;
                        TprMvCab.Dopes + " " + STR(TprMvCab.Numes, 6)
                    loc_oCusto.Update(.T.)

                    IF SEEK(TprMvCab.EmpDopNums, 'LocCalcU', 'EmpdopNums')
                        LOOP
                    ENDIF

                    *-- Tipo 1: movimento de conta corrente
                    IF (TprMvCab.GerGdmis = 1 .AND. TprMvCab.TpGdmis = 1)
                        loc_cConta = IIF(TprMvCab.Copers = 1, TprMvCab.Contads, TprMvCab.Contaos)

                        IF USED("crSigCdPam") .AND. TprMvCab.CMoes # crSigCdPam.MoeCentral
                            loc_lnCotaCentral  = fBuscarCotacao(crSigCdPam.MoeCentral, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnCotaOperac   = fBuscarCotacao(TprMvCab.CMoes, ;
                                                     TprMvCab.Datas, THIS.this_oDataMgr)
                            loc_lnValorCentral = ROUND(TprMvCab.Valos * loc_lnCotaOperac / ;
                                                       loc_lnCotaCentral, 2)
                        ELSE
                            loc_lnValorCentral = TprMvCab.Valos
                        ENDIF

                        loc_ldData = TprMvCab.Datas
                        INSERT INTO CrSigOpClU ;
                            (Emps, Dopes, Numes, EmpdopNums, iclis, Valors, Datas, Cidchaves) ;
                            VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                    TprMvCab.EmpdopNums, loc_cConta, loc_lnValorCentral, ;
                                    loc_ldData, fUniqueIds())
                    ENDIF

                    *-- Tipo 2: movimento de itens (produtos)
                    IF (TprMvCab.GerGdmis = 2 .AND. TprMvCab.AtuCompras = 1)
                        SELECT crTpmMvItn
                        =SEEK(TprMvCab.EmpDopNums)
                        SCAN WHILE EmpdopNums = TprMvCab.EmpDopNums
                            IF EMPTY(Cpros)
                                LOOP
                            ENDIF

                            loc_cSql = "Select Cpros, UltComps From SigCdPro " + ;
                                       "Where Cpros = '" + ALLTRIM(crTpmMvItn.Cpros) + "'"
                            IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'TmpPro') < 1
                                MsgErro("Falha na conex" + CHR(227) + "o (SigCdPro)", "Erro")
                                LOOP
                            ENDIF

                            loc_ldData  = TprMvCab.Datas
                            loc_lnValor = crTpmMvItn.Units
                            loc_cMoeda  = crTpmMvItn.Moedas

                            INSERT INTO CrSigOpClU ;
                                (Emps, Dopes, Numes, empDopNums, cpros, Valors, ;
                                 Datas, Moedas, Cidchaves) ;
                                VALUES (TprMvCab.Emps, TprMvCab.Dopes, TprMvCab.Numes, ;
                                        TprMvCab.EmpdopNums, crTpmMvItn.Cpros, loc_lnValor, ;
                                        loc_ldData, loc_cMoeda, fUniqueIds())
                        ENDSCAN
                    ENDIF
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                *-- Persiste CrSigOpClU no banco
                IF !THIS.this_oDataMgr.Update('CrSigOpClU')
                    MsgErro("Falha na conex" + CHR(227) + "o (Update CrSigOpClU)", "Erro")
                    EXIT
                ENDIF
                THIS.this_oDataMgr.Commit()

                *-- Atualiza SigCdCli: ultima compra por cliente
                loc_cSql = "Select * From SigOpClU"
                IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'CsSelecao') < 1
                    MsgErro("Falha na conex" + CHR(227) + "o (CsSelecao)", "Erro")
                    EXIT
                ENDIF

                SELECT DISTINCT Iclis FROM CsSelecao INTO CURSOR SelecaoIclis

                loc_nReg  = RECCOUNT('SelecaoIclis')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Clientes ', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoIclis
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Cliente " + SelecaoIclis.Iclis
                    loc_oCusto.Update(.T.)

                    loc_cConta = SelecaoIclis.Iclis

                    *-- Ultima compra pela data mais recente
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Data)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli)", "Erro")
                        LOOP
                    ENDIF

                    *-- Ultima compra pelo maior valor
                    loc_cSql = "Select Top 1 Iclis, Datas, Valors From SigOpClU " + ;
                               "Where Iclis = '" + ALLTRIM(loc_cConta) + "' Order by Valors Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Valor)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_cUpDate = "Update SigCdCli Set dtfats = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", mfats = " + ;
                                  STR(IIF(RECCOUNT('LocalCalcU') = 0, 0, LocalCalcU.Valors), 12, 2) + ;
                                  " Where Iclis = '" + ALLTRIM(loc_cConta) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdCli dtfats)", "Erro")
                        LOOP
                    ENDIF

                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                *-- Atualiza SigCdPro: ultima compra por produto
                SELECT DISTINCT Cpros FROM CsSelecao INTO CURSOR SelecaoCpros

                loc_nReg  = RECCOUNT('SelecaoCpros')
                loc_oCusto = CREATEOBJECT('fwprogressbar', ;
                    'Atualizando Valor da Ultima Compra Produtos', loc_nReg)
                loc_oCusto.Titulo.FontBold = .T.
                loc_oCusto.Show

                SELECT SelecaoCpros
                SCAN
                    loc_nReg = loc_nReg - 1
                    THIS.this_nRegistros = loc_nReg
                    IF VARTYPE(par_oForm) = "O" .AND. !ISNULL(par_oForm)
                        par_oForm.txt_4c_Registro.Value = loc_nReg
                        par_oForm.txt_4c_Registro.Refresh
                    ENDIF
                    loc_oCusto.SubTitulo.Caption = "Produto " + SelecaoCpros.Cpros
                    loc_oCusto.Update(.T.)

                    loc_cSql = "Select Top 1 Cpros, Datas, Valors, Moedas From SigOpClU " + ;
                               "Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "' " + ;
                               "Order by Datas Desc"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cSql, 'LocalCalcU') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (LocalCalcU Produto)", "Erro")
                        LOOP
                    ENDIF
                    loc_ldData  = IIF(RECCOUNT('LocalCalcU') = 0, .NULL., LocalCalcU.Datas)
                    loc_lnValor = IIF(RECCOUNT('LocalCalcU') = 0, 0,     LocalCalcU.Valors)
                    loc_cMoeda  = IIF(RECCOUNT('LocalCalcU') = 0, "",    ALLTRIM(LocalCalcU.Moedas))

                    loc_cUpDate = "Update SigCdPro Set UltComps = " + ;
                                  IIF(ISNULL(loc_ldData), "NULL", FormatarDataSQL(loc_ldData)) + ;
                                  ", vUltComps = " + STR(loc_lnValor, 12, 2) + ;
                                  ", mUltComps = '" + loc_cMoeda + "'" + ;
                                  " Where Cpros = '" + ALLTRIM(SelecaoCpros.Cpros) + "'"
                    IF THIS.this_oDataMgr.SqlExecute(loc_cUpDate, '') < 1
                        MsgErro("Falha na conex" + CHR(227) + "o (Update SigCdPro)", "Erro")
                        LOOP
                    ENDIF
                    THIS.this_oDataMgr.Commit()
                ENDSCAN

                loc_oCusto.Complete(.T., .T.)

                IF USED("TprMvCab")
                    USE IN TprMvCab
                ENDIF
                IF USED("crTpmMvItn")
                    USE IN crTpmMvItn
                ENDIF
                IF USED("LocCalcU")
                    USE IN LocCalcU
                ENDIF
                IF USED("CsSelecao")
                    USE IN CsSelecao
                ENDIF
                IF USED("SelecaoIclis")
                    USE IN SelecaoIclis
                ENDIF
                IF USED("SelecaoCpros")
                    USE IN SelecaoCpros
                ENDIF

                loc_lSucesso = .T.
                EXIT
            ENDDO
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

