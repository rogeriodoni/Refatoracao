# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (5)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CODIGOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDQUERYS, GRUPODS, CONTADS, DOPES, EMPS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICLIS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDQUERYS, GRUPODS, CONTADS, DOPES, EMPS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CEMPS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDQUERYS, GRUPODS, CONTADS, DOPES, EMPS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'ICL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDQUERYS, GRUPODS, CONTADS, DOPES, EMPS, DATAS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'RCL' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CIDQUERYS, GRUPODS, CONTADS, DOPES, EMPS, DATAS

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
lcQryGTmpD = [Select * From SigTempC Where cIdQuerys = '] + pIds + [']
lcQuery = [Select * ] + ;
  			[From SigMvCab ] + ;
If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'TprMvCab') < 1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrPpc.prg) - PRIMEIRAS 1045 de 1045 linhas:
*==============================================================================
* FormSigPrPpc.prg - Formulario Operacional: Produtos Por Conta
* Tipo: OPERACIONAL (flat, sem PageFrame CRUD - popup modal de filtros)
* Migrado de SIGPRPPC.SCX
*
* Pilares:
*   UX   -> layout identico ao legado (660x300, flat, sem barra de titulo)
*   BD   -> SigMvCab / SigCdGcr / SigCdCli / SigCdOpe / SigCdEmp
*   CODE -> FormBase / SigPrPpcBO
*
* Comportamento:
*   - Form de filtros modal: usuario preenche Grupo, Conta, Operacao,
*     Periodo e Empresa, clica Consultar -> abre resultado (FormSigPrPpp)
*   - Encerrar fecha o form
*
* FASE 7 - COMPLETO
*   - Form OPERACIONAL flat: eventos principais sao CmdConsultarClick() e
*     CmdEncerrarClick() (equivalentes aos BtnIncluirClick/BtnExcluirClick do
*     padrao CRUD - nao aplicaveis aqui pois nao ha botoes de CRUD)
*   - CmdConsultarClick() valida Grupo/Conta/datas + BO.Inserir() + abre FormSigPrPpp
*   - Lookup helpers canonicos para SigCdGcr, SigCdCli, SigCdOpe, SigCdEmp
*==============================================================================

DEFINE CLASS FormSigPrPpc AS FormBase

    *-- Dimensoes e layout identicos ao legado
    Width        = 660
    Height       = 300
    BorderStyle  = 2
    AutoCenter   = .T.
    TitleBar     = 0
    ShowWindow = 1
    ControlBox   = .F.
    MaxButton    = .F.
    MinButton    = .F.
    DataSession  = 2
    WindowType   = 1
    FontName     = "Tahoma"
    FontSize     = 8
    Caption      = "Produtos Por Conta"

    *-- Business Object
    this_oBusinessObject = .NULL.
    this_cMensagemErro   = ""

    *==========================================================================
    * Init - Cria BO e delega inicializacao para FormBase
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            THIS.this_oBusinessObject = CREATEOBJECT("SigPrPpcBO")
            IF VARTYPE(THIS.this_oBusinessObject) = "O"
                loc_lSucesso = DODEFAULT()
            ELSE
                MsgErro("Erro ao criar SigPrPpcBO." + CHR(13) + ;
                        "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InicializarForm - Monta estrutura visual completa do form
    *==========================================================================
    PROTECTED PROCEDURE InicializarForm()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
                THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
            ENDIF

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarPaginaDados()
            THIS.InicializarValores()
            THIS.TornarControlesVisiveis(THIS)
            THIS.ConfigurarBINDEVENTs()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro InicializarForm")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ConfigurarPageFrame - Cabecalho cinza com titulo (estrutura OPERACIONAL)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPageFrame()
        THIS.AddObject("cnt_4c_Sombra", "Container")
        WITH THIS.cnt_4c_Sombra
            .Top         = 0
            .Left        = 0
            .Width       = THIS.Width
            .Height      = 80
            .BorderWidth = 0
            .BackStyle   = 1
            .BackColor   = RGB(100, 100, 100)
            .Visible     = .T.

            .AddObject("lbl_4c_LblSombra", "Label")
        ENDWITH
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
            .Top       = 25
            .Left      = 10
            .Width     = THIS.cnt_4c_Sombra.Width - 20
            .Height    = 40
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(0, 0, 0)
            .Caption   = "Produtos Por Conta"
            .WordWrap  = .T.
        ENDWITH

        THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
        WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
            .Top       = 24
            .Left      = 10
            .Width     = THIS.cnt_4c_Sombra.Width - 20
            .Height    = 46
            .AutoSize  = .F.
            .BackStyle = 0
            .FontName  = "Tahoma"
            .FontSize  = 18
            .FontBold  = .T.
            .ForeColor = RGB(255, 255, 255)
            .Caption   = "Produtos Por Conta"
            .WordWrap  = .T.
        ENDWITH
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaLista - Prepara o painel de filtros para novo uso
    * Adapta o conceito CRUD "pagina de lista" para o contexto OPERACIONAL:
    * repopula valores iniciais e devolve o foco ao primeiro campo (Grupo).
    * Chamado por AlternarPagina() e por comandos externos que precisam
    * resetar o form sem destrui-lo (ex.: retorno do FormSigPrPpp).
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaLista()
        LOCAL loc_oErro
        TRY
            THIS.InicializarValores()
            IF PEMSTATUS(THIS, "txt_4c_Grupo", 5) AND THIS.txt_4c_Grupo.Enabled
                THIS.txt_4c_Grupo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro ConfigurarPaginaLista")
        ENDTRY
    ENDPROC

    *==========================================================================
    * AlternarPagina - Alterna estado do form entre "filtros" e "resultado"
    * Neste OPERACIONAL flat nao ha PageFrame; a semantica de alternar
    * corresponde a habilitar/desabilitar os campos de filtro conforme
    * par_nPagina (1=filtros editaveis, 2=filtros bloqueados enquanto
    * FormSigPrPpp esta ativo). Quando volta a 1 chama ConfigurarPaginaLista
    * para restaurar o painel ao estado inicial.
    *==========================================================================
    PROCEDURE AlternarPagina(par_nPagina)
        LOCAL loc_lHabilitar, loc_oErro
        IF VARTYPE(par_nPagina) != "N"
            par_nPagina = 1
        ENDIF
        loc_lHabilitar = (par_nPagina = 1)
        TRY
            THIS.txt_4c_Grupo.Enabled       = loc_lHabilitar
            THIS.txt_4c_DGrupo.Enabled      = loc_lHabilitar
            THIS.txt_4c_Conta.Enabled       = loc_lHabilitar
            THIS.txt_4c_ContaDesc.Enabled   = loc_lHabilitar
            THIS.txt_4c_Operacao.Enabled    = loc_lHabilitar
            THIS.txt_4c_DtIni.Enabled       = loc_lHabilitar
            THIS.txt_4c_DtFin.Enabled       = loc_lHabilitar
            THIS.txt_4c_Empresa.Enabled     = loc_lHabilitar
            THIS.txt_4c_EmpresaDesc.Enabled = loc_lHabilitar
            THIS.cmg_4c_Operacao.Buttons(1).Enabled = loc_lHabilitar
            IF loc_lHabilitar
                THIS.ConfigurarPaginaLista()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro AlternarPagina")
        ENDTRY
    ENDPROC

    *==========================================================================
    * ConfigurarPaginaDados - Monta CommandGroup de acao e todos os campos
    * de filtro: Grupo, Conta, Operacao, Periodo, Empresa.
    * Este form OPERACIONAL flat NAO possui separacao Page1=Lista/Page2=Dados
    * como forms CRUD; todo o conteudo equivalente ao "Page Dados" eh criado
    * diretamente sobre THIS. O nome do metodo eh mantido por convencao para
    * aderir ao contrato multi-fase do pipeline (Fase 5 espera este simbolo).
    * Posicoes identicas ao legado (layout.json / SIGPRPPC SECAO 2)
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarPaginaDados()
        LOCAL loc_oCmg

        *-- CommandGroup flutuante sobre o cabecalho (legado: grp_operacao)
        THIS.AddObject("cmg_4c_Operacao", "CommandGroup")
        loc_oCmg = THIS.cmg_4c_Operacao
        WITH loc_oCmg
            .Top           = -2
            .Left          = 502
            .Width         = 161
            .Height        = 85
            .ButtonCount   = 2
            .BackStyle     = 0
            .BorderStyle   = 0
            .SpecialEffect = 1
            .Themes        = .F.
            .Value         = 1
            WITH .Buttons(1)
                .Top             = 5
                .Left            = 5
                .Width           = 75
                .Height          = 75
                .Caption         = "\<Consultar"
                .Picture         = gc_4c_CaminhoIcones + "geral_procura_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Themes          = .F.
                .WordWrap        = .T.
                .PicturePosition = 13
            ENDWITH
            WITH .Buttons(2)
                .Top             = 5
                .Left            = 81
                .Width           = 75
                .Height          = 75
                .Caption         = "Encerrar"
                .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
                .FontName        = "Tahoma"
                .FontSize        = 8
                .FontBold        = .T.
                .FontItalic      = .T.
                .ForeColor       = RGB(90, 90, 90)
                .BackColor       = RGB(255, 255, 255)
                .Cancel          = .T.
                .Themes          = .F.
                .WordWrap        = .T.
                .PicturePosition = 13
            ENDWITH
        ENDWITH

        *-- LINHA GRUPO (legado: Say4 / Get_grupo / Get_DGrupo)
        THIS.AddObject("lbl_4c_LblGrupo", "Label")
        WITH THIS.lbl_4c_LblGrupo
            .Top      = 123
            .Left     = 138
            .Caption  = "Grupo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Grupo", "TextBox")
        WITH THIS.txt_4c_Grupo
            .Top      = 120
            .Left     = 180
            .Width    = 80
            .Height   = 23
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.AddObject("txt_4c_DGrupo", "TextBox")
        WITH THIS.txt_4c_DGrupo
            .Top       = 120
            .Left      = 261
            .Width     = 150
            .Height    = 23
            .MaxLength = 20
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- LINHA CONTA (legado: lbl_cliente / get_cliente / get_cliente_desc)
        THIS.AddObject("lbl_4c_LblConta", "Label")
        WITH THIS.lbl_4c_LblConta
            .Top      = 150
            .Left     = 138
            .Caption  = "Conta :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Conta", "TextBox")
        WITH THIS.txt_4c_Conta
            .Top      = 145
            .Left     = 180
            .Width    = 80
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.AddObject("txt_4c_ContaDesc", "TextBox")
        WITH THIS.txt_4c_ContaDesc
            .Top      = 145
            .Left     = 261
            .Width    = 290
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- LINHA OPERACAO (legado: lbl_operacao / get_operacao)
        THIS.AddObject("lbl_4c_LblOperacao", "Label")
        WITH THIS.lbl_4c_LblOperacao
            .Top      = 175
            .Left     = 120
            .Caption  = "Opera" + CHR(231) + CHR(227) + "o :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Operacao", "TextBox")
        WITH THIS.txt_4c_Operacao
            .Top      = 170
            .Left     = 180
            .Width    = 150
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- LINHA PERIODO (legado: lbl_periodo / get_dt_inicial / lbl_periodo_a / get_dt_final)
        THIS.AddObject("lbl_4c_LblPeriodo", "Label")
        WITH THIS.lbl_4c_LblPeriodo
            .Top      = 200
            .Left     = 131
            .Caption  = "Periodo :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_DtIni", "TextBox")
        WITH THIS.txt_4c_DtIni
            .Top       = 195
            .Left      = 180
            .Width     = 80
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.AddObject("lbl_4c_LblA", "Label")
        WITH THIS.lbl_4c_LblA
            .Top      = 200
            .Left     = 263
            .Caption  = "a"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_DtFin", "TextBox")
        WITH THIS.txt_4c_DtFin
            .Top       = 195
            .Left      = 273
            .Width     = 80
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        *-- LINHA EMPRESA (legado: lbl_empresa / get_empresa / get_empresa_desc)
        THIS.AddObject("lbl_4c_LblEmpresa", "Label")
        WITH THIS.lbl_4c_LblEmpresa
            .Top      = 225
            .Left     = 126
            .Caption  = "Empresa :"
            .FontName = "Tahoma"
            .FontSize = 8
            .BackStyle = 0
        ENDWITH

        THIS.AddObject("txt_4c_Empresa", "TextBox")
        WITH THIS.txt_4c_Empresa
            .Top       = 220
            .Left      = 180
            .Width     = 36
            .Height    = 23
            .MaxLength = 3
            .FontName  = "Tahoma"
            .FontSize  = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH

        THIS.AddObject("txt_4c_EmpresaDesc", "TextBox")
        WITH THIS.txt_4c_EmpresaDesc
            .Top      = 220
            .Left     = 217
            .Width    = 250
            .FontName = "Tahoma"
            .FontSize = 8
            .ForeColor = RGB(0, 0, 0)
        ENDWITH
    ENDPROC

    *==========================================================================
    * InicializarValores - Preenche valores iniciais dos campos (replica legado)
    *==========================================================================
    PROTECTED PROCEDURE InicializarValores()
        THIS.txt_4c_Grupo.Value       = SPACE(10)
        THIS.txt_4c_DGrupo.Value      = SPACE(20)
        THIS.txt_4c_Conta.Value       = SPACE(10)
        THIS.txt_4c_ContaDesc.Value   = SPACE(40)
        THIS.txt_4c_Operacao.Value    = SPACE(20)
        THIS.txt_4c_DtIni.Value       = DATE()
        THIS.txt_4c_DtFin.Value       = DATE()
        THIS.txt_4c_Empresa.Value     = SPACE(3)
        THIS.txt_4c_EmpresaDesc.Value = SPACE(40)
    ENDPROC

    *==========================================================================
    * ConfigurarBINDEVENTs - Conecta handlers de teclado e botoes
    *==========================================================================
    PROTECTED PROCEDURE ConfigurarBINDEVENTs()
        BINDEVENT(THIS.txt_4c_Grupo,       "KeyPress", THIS, "TxtGrupoKeyPress")
        BINDEVENT(THIS.txt_4c_DGrupo,      "KeyPress", THIS, "TxtDGrupoKeyPress")
        BINDEVENT(THIS.txt_4c_Conta,       "KeyPress", THIS, "TxtContaKeyPress")
        BINDEVENT(THIS.txt_4c_ContaDesc,   "KeyPress", THIS, "TxtContaDescKeyPress")
        BINDEVENT(THIS.txt_4c_Operacao,    "KeyPress", THIS, "TxtOperacaoKeyPress")
        BINDEVENT(THIS.txt_4c_Empresa,     "KeyPress", THIS, "TxtEmpresaKeyPress")
        BINDEVENT(THIS.txt_4c_EmpresaDesc, "KeyPress", THIS, "TxtEmpresaDescKeyPress")
        BINDEVENT(THIS.cmg_4c_Operacao.Buttons(1), "Click", THIS, "CmdConsultarClick")
        BINDEVENT(THIS.cmg_4c_Operacao.Buttons(2), "Click", THIS, "CmdEncerrarClick")
    ENDPROC

    *==========================================================================
    * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
    *==========================================================================
    PROCEDURE TornarControlesVisiveis(par_oContainer)
        LOCAL loc_i, loc_oControl
        FOR loc_i = 1 TO par_oContainer.ControlCount
            loc_oControl = par_oContainer.Controls(loc_i)
            IF VARTYPE(loc_oControl) = "O"
                IF PEMSTATUS(loc_oControl, "Visible", 5)
                    loc_oControl.Visible = .T.
                ENDIF
                IF PEMSTATUS(loc_oControl, "ControlCount", 5)
                    IF loc_oControl.ControlCount > 0
                        THIS.TornarControlesVisiveis(loc_oControl)
                    ENDIF
                ENDIF
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * FormParaBO - Copia valores dos campos para o Business Object
    *==========================================================================
    PROTECTED PROCEDURE FormParaBO()
        WITH THIS.this_oBusinessObject
            .this_cGrupo       = ALLTRIM(THIS.txt_4c_Grupo.Value)
            .this_cDGrupo      = ALLTRIM(THIS.txt_4c_DGrupo.Value)
            .this_cConta       = ALLTRIM(THIS.txt_4c_Conta.Value)
            .this_cContaDesc   = ALLTRIM(THIS.txt_4c_ContaDesc.Value)
            .this_cOperacao    = ALLTRIM(THIS.txt_4c_Operacao.Value)
            .this_dInicial     = THIS.txt_4c_DtIni.Value
            .this_dFinal       = THIS.txt_4c_DtFin.Value
            .this_cEmpresa     = ALLTRIM(THIS.txt_4c_Empresa.Value)
            .this_cEmpresaDesc = ALLTRIM(THIS.txt_4c_EmpresaDesc.Value)
        ENDWITH
    ENDPROC

    *==========================================================================
    * CmdConsultarClick - Valida campos, executa consulta e abre resultado
    * Validacoes de UI ficam FORA do TRY/CATCH (RETURN permitido)
    *==========================================================================
    PROCEDURE CmdConsultarClick()
        LOCAL loc_lSucesso, loc_cErro, loc_oResultado, loc_oErro, loc_lProsseguir
        loc_lSucesso   = .F.
        loc_lProsseguir = .T.

        *-- Validacoes rapidas de UI (fora do TRY - RETURN permitido aqui)
        IF VARTYPE(THIS.txt_4c_DtIni.Value) != "D" OR EMPTY(THIS.txt_4c_DtIni.Value)
            MsgAviso("Data inicial inv" + CHR(225) + "lida.", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_DtIni.SetFocus()
            RETURN
        ENDIF
        IF VARTYPE(THIS.txt_4c_DtFin.Value) != "D" OR EMPTY(THIS.txt_4c_DtFin.Value)
            MsgAviso("Data final inv" + CHR(225) + "lida.", "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_DtFin.SetFocus()
            RETURN
        ENDIF
        IF THIS.txt_4c_DtIni.Value > THIS.txt_4c_DtFin.Value
            MsgAviso("Data inicial maior que a data final.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_DtIni.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
            MsgAviso("Grupo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Grupo.SetFocus()
            RETURN
        ENDIF
        IF EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            MsgAviso("Conta inv" + CHR(225) + "lida.", ;
                     "Aten" + CHR(231) + CHR(227) + "o")
            THIS.txt_4c_Conta.SetFocus()
            RETURN
        ENDIF

        TRY
            THIS.FormParaBO()

            *-- BO valida filtros + executa consulta (popula TprMvCab)
            IF !THIS.this_oBusinessObject.Inserir()
                loc_cErro = THIS.this_oBusinessObject.this_cMensagemErro
                IF !EMPTY(loc_cErro)
                    MsgAviso(loc_cErro, "Aten" + CHR(231) + CHR(227) + "o")
                ENDIF
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                IF !USED("TprMvCab") OR RECCOUNT("TprMvCab") = 0
                    MsgAviso("Nenhuma movimenta" + CHR(231) + CHR(227) + "o foi encontrada.", ;
                             "Resultado")
                ELSE
                    *-- Abrir form de resultado (FormSigPrPpp) e bloquear filtros
                    THIS.AlternarPagina(2)
                    IF FILE(gc_4c_CaminhoForms + "operacionais\FormSigPrPpp.prg")
                        loc_oResultado = CREATEOBJECT("FormSigPrPpp", THIS, THIS.DataSessionID)
                        IF VARTYPE(loc_oResultado) = "O"
                            loc_oResultado.Show()
                        ELSE
                            MsgErro("Erro ao criar FormSigPrPpp." + CHR(13) + ;
                                    "VARTYPE: " + VARTYPE(loc_oResultado), "Erro")
                        ENDIF
                    ELSE
                        MsgInfo("Movimenta" + CHR(231) + CHR(245) + "es encontradas: " + ;
                                TRANSFORM(RECCOUNT("TprMvCab")) + " registros em TprMvCab.")
                    ENDIF
                    THIS.AlternarPagina(1)
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro")
        ENDTRY
    ENDPROC

    *==========================================================================
    * CmdEncerrarClick - Fecha o formulario
    *==========================================================================
    PROCEDURE CmdEncerrarClick()
        THIS.Release()
    ENDPROC

    *==========================================================================
    * TxtGrupoKeyPress - Lookup SigCdGcr por codigos em ENTER/TAB/F4
    *==========================================================================
    PROCEDURE TxtGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupo()
    ENDPROC

    *==========================================================================
    * TxtDGrupoKeyPress - Lookup SigCdGcr por descrs
    * Reproduz When legado: apenas quando txt_4c_Grupo estiver vazio
    *==========================================================================
    PROCEDURE TxtDGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Grupo.Value))
            RETURN
        ENDIF
        THIS.AbrirBuscaGrupoPorDesc()
    ENDPROC

    *==========================================================================
    * TxtContaKeyPress - Lookup SigCdCli por IClis em ENTER/TAB/F4
    *==========================================================================
    PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaConta()
    ENDPROC

    *==========================================================================
    * TxtContaDescKeyPress - Lookup SigCdCli por RClis
    * Reproduz When legado: apenas quando txt_4c_Conta estiver vazia
    *==========================================================================
    PROCEDURE TxtContaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Conta.Value))
            RETURN
        ENDIF
        THIS.AbrirBuscaContaPorDesc()
    ENDPROC

    *==========================================================================
    * TxtOperacaoKeyPress - Lookup SigCdOpe por Dopes em ENTER/TAB/F4
    *==========================================================================
    PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaOperacao()
    ENDPROC

    *==========================================================================
    * TxtEmpresaKeyPress - Lookup SigCdEmp por Cemps em ENTER/TAB/F4
    *==========================================================================
    PROCEDURE TxtEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        THIS.AbrirBuscaEmpresa()
    ENDPROC

    *==========================================================================
    * TxtEmpresaDescKeyPress - Lookup SigCdEmp por Razas
    * Reproduz When legado: apenas quando txt_4c_Empresa estiver vazia
    *==========================================================================
    PROCEDURE TxtEmpresaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
        IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
            RETURN
        ENDIF
        IF !EMPTY(ALLTRIM(THIS.txt_4c_Empresa.Value))
            RETURN
        ENDIF
        THIS.AbrirBuscaEmpresaPorDesc()
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupo - FormBuscaAuxiliar para SigCdGcr pesquisando por codigos
    * Preenche txt_4c_Grupo (codigos) e txt_4c_DGrupo (descrs) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaGrupo()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_Grupo.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cValor, ;
                "Busca de Grupos Cont" + CHR(225) + "beis")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    THIS.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                    THIS.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaGrupoPorDesc - FormBuscaAuxiliar para SigCdGcr por descrs
    * Preenche txt_4c_Grupo (codigos) e txt_4c_DGrupo (descrs) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaGrupoPorDesc()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_DGrupo.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdGcr", "cursor_4c_BuscaGcr", "descrs", loc_cValor, ;
                "Busca por Descri" + CHR(231) + CHR(227) + "o de Grupo")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
                    THIS.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_BuscaGcr.codigos)
                    THIS.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_BuscaGcr.descrs)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaGcr")
            USE IN cursor_4c_BuscaGcr
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaConta - FormBuscaAuxiliar para SigCdCli pesquisando por IClis
    * Preenche txt_4c_Conta (IClis) e txt_4c_ContaDesc (RClis) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaConta()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_Conta.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "IClis", loc_cValor, ;
                "Busca de Contas")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    THIS.txt_4c_Conta.Value     = ALLTRIM(cursor_4c_BuscaCli.IClis)
                    THIS.txt_4c_ContaDesc.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaContaPorDesc - FormBuscaAuxiliar para SigCdCli por RClis
    * Preenche txt_4c_Conta (IClis) e txt_4c_ContaDesc (RClis) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaContaPorDesc()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_ContaDesc.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdCli", "cursor_4c_BuscaCli", "RClis", loc_cValor, ;
                "Busca por Nome da Conta")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("RClis", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("IClis", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCli")
                    THIS.txt_4c_Conta.Value     = ALLTRIM(cursor_4c_BuscaCli.IClis)
                    THIS.txt_4c_ContaDesc.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaCli")
            USE IN cursor_4c_BuscaCli
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaOperacao - FormBuscaAuxiliar para SigCdOpe pesquisando por Dopes
    * SigCdOpe eh single-column: Dopes eh PK E descricao (sem coluna descrs)
    * Preenche txt_4c_Operacao ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaOperacao()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_Operacao.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdOpe", "cursor_4c_BuscaOpe", "Dopes", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Opera" + CHR(231) + CHR(227) + "o")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Dopes", "", "Opera" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaOpe")
                    THIS.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_BuscaOpe.Dopes)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaOpe")
            USE IN cursor_4c_BuscaOpe
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresa - FormBuscaAuxiliar para SigCdEmp por Cemps (codigo)
    * Preenche txt_4c_Empresa (Cemps) e txt_4c_EmpresaDesc (Razas) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresa()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_Empresa.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", loc_cValor, ;
                "Sele" + CHR(231) + CHR(227) + "o de Empresa")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    THIS.txt_4c_Empresa.Value     = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    THIS.txt_4c_EmpresaDesc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *==========================================================================
    * AbrirBuscaEmpresaPorDesc - FormBuscaAuxiliar para SigCdEmp por Razas
    * Preenche txt_4c_Empresa (Cemps) e txt_4c_EmpresaDesc (Razas) ao selecionar
    *==========================================================================
    PROCEDURE AbrirBuscaEmpresaPorDesc()
        LOCAL loc_cValor, loc_oBusca, loc_oErro
        loc_cValor = ALLTRIM(THIS.txt_4c_EmpresaDesc.Value)
        TRY
            loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
                "SigCdEmp", "cursor_4c_BuscaEmp", "Razas", loc_cValor, ;
                "Busca por Nome de Empresa")
            IF VARTYPE(loc_oBusca) = "O"
                loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
                loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
                loc_oBusca.Show()
                IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
                    THIS.txt_4c_Empresa.Value     = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
                    THIS.txt_4c_EmpresaDesc.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
                ENDIF
                loc_oBusca.Release()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_BuscaEmp")
            USE IN cursor_4c_BuscaEmp
        ENDIF
    ENDPROC

    *==========================================================================
    * BtnIncluirClick - Executa a consulta com os filtros atuais
    * Neste OPERACIONAL flat "incluir" corresponde a executar/adicionar uma
    * nova consulta (o botao Consultar do CommandGroup) - delega para o
    * handler funcional real CmdConsultarClick.
    *==========================================================================
    PROCEDURE BtnIncluirClick()
        THIS.CmdConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnAlterarClick - Reabilita filtros para nova edicao apos consulta
    * Equivalente OPERACIONAL do "Alterar": volta o painel ao estado editavel
    * (AlternarPagina(1) restaura Enabled=.T. e chama ConfigurarPaginaLista).
    *==========================================================================
    PROCEDURE BtnAlterarClick()
        THIS.AlternarPagina(1)
    ENDPROC

    *==========================================================================
    * BtnVisualizarClick - Reexecuta a consulta e exibe o resultado
    * Equivalente OPERACIONAL do "Visualizar": mesma acao de Consultar
    * (que abre FormSigPrPpp com os dados de TprMvCab).
    *==========================================================================
    PROCEDURE BtnVisualizarClick()
        THIS.CmdConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnExcluirClick - Limpa todos os filtros e devolve foco ao Grupo
    * Equivalente OPERACIONAL do "Excluir": remove os valores digitados,
    * fecha o cursor de resultado (se existir) e retorna ao estado inicial.
    *==========================================================================
    PROCEDURE BtnExcluirClick()
        LOCAL loc_oErro
        TRY
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            THIS.InicializarValores()
            THIS.AlternarPagina(1)
            IF PEMSTATUS(THIS, "txt_4c_Grupo", 5) AND THIS.txt_4c_Grupo.Enabled
                THIS.txt_4c_Grupo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro BtnExcluirClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BOParaForm - Copia valores do Business Object para os campos do form
    * Usado para restaurar o painel de filtros apos uma consulta ou em
    * fluxos onde o BO foi populado externamente (ex.: CarregarDoCursor).
    *==========================================================================
    PROTECTED PROCEDURE BOParaForm()
        LOCAL loc_oBO
        loc_oBO = THIS.this_oBusinessObject
        THIS.txt_4c_Grupo.Value       = loc_oBO.this_cGrupo
        THIS.txt_4c_DGrupo.Value      = loc_oBO.this_cDGrupo
        THIS.txt_4c_Conta.Value       = loc_oBO.this_cConta
        THIS.txt_4c_ContaDesc.Value   = loc_oBO.this_cContaDesc
        THIS.txt_4c_Operacao.Value    = loc_oBO.this_cOperacao
        THIS.txt_4c_DtIni.Value       = IIF(EMPTY(loc_oBO.this_dInicial), DATE(), loc_oBO.this_dInicial)
        THIS.txt_4c_DtFin.Value       = IIF(EMPTY(loc_oBO.this_dFinal),   DATE(), loc_oBO.this_dFinal)
        THIS.txt_4c_Empresa.Value     = loc_oBO.this_cEmpresa
        THIS.txt_4c_EmpresaDesc.Value = loc_oBO.this_cEmpresaDesc
    ENDPROC

    *==========================================================================
    * HabilitarCampos - Habilita ou desabilita todos os controles de filtro
    * par_lHabilitar = .T. -> campos editaveis / .F. -> somente leitura
    *==========================================================================
    PROCEDURE HabilitarCampos(par_lHabilitar)
        IF VARTYPE(par_lHabilitar) != "L"
            par_lHabilitar = .T.
        ENDIF
        THIS.txt_4c_Grupo.Enabled              = par_lHabilitar
        THIS.txt_4c_DGrupo.Enabled             = par_lHabilitar
        THIS.txt_4c_Conta.Enabled              = par_lHabilitar
        THIS.txt_4c_ContaDesc.Enabled          = par_lHabilitar
        THIS.txt_4c_Operacao.Enabled           = par_lHabilitar
        THIS.txt_4c_DtIni.Enabled              = par_lHabilitar
        THIS.txt_4c_DtFin.Enabled              = par_lHabilitar
        THIS.txt_4c_Empresa.Enabled            = par_lHabilitar
        THIS.txt_4c_EmpresaDesc.Enabled        = par_lHabilitar
        THIS.cmg_4c_Operacao.Buttons(1).Enabled = par_lHabilitar
    ENDPROC

    *==========================================================================
    * LimparCampos - Restaura todos os campos de filtro para o estado inicial
    *==========================================================================
    PROCEDURE LimparCampos()
        THIS.InicializarValores()
    ENDPROC

    *==========================================================================
    * CarregarLista - Contrato de FormBase para forms CRUD
    * Form OPERACIONAL flat nao possui grade de listagem; retorna .T. para
    * indicar sucesso ao framework sem executar acoes desnecessarias.
    *==========================================================================
    PROCEDURE CarregarLista()
        RETURN .T.
    ENDPROC

    *==========================================================================
    * AjustarBotoesPorModo - Atualiza estado do botao Consultar
    * Em forms OPERACIONAIS o "modo" equivale ao estado editavel/bloqueado.
    * Chamado pelo framework quando o modo de edicao muda; delega para
    * HabilitarCampos usando o estado atual do primeiro campo como referencia.
    *==========================================================================
    PROCEDURE AjustarBotoesPorModo()
        LOCAL loc_lHabilitar, loc_oErro
        TRY
            loc_lHabilitar = THIS.txt_4c_Grupo.Enabled
            THIS.cmg_4c_Operacao.Buttons(1).Enabled = loc_lHabilitar
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro AjustarBotoesPorModo")
        ENDTRY
    ENDPROC

    *==========================================================================
    * BtnBuscarClick - Executa a consulta com os filtros informados
    * Equivalente OPERACIONAL do botao Buscar do CRUD: inicia a pesquisa.
    *==========================================================================
    PROCEDURE BtnBuscarClick()
        THIS.CmdConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnEncerrarClick - Fecha o formulario
    * Equivalente OPERACIONAL do botao Encerrar do CRUD.
    *==========================================================================
    PROCEDURE BtnEncerrarClick()
        THIS.CmdEncerrarClick()
    ENDPROC

    *==========================================================================
    * BtnSalvarClick - Confirma/executa a consulta (equivalente OPERACIONAL)
    * Em forms OPERACIONAIS nao ha persistencia; "salvar" significa confirmar
    * os filtros e executar a consulta.
    *==========================================================================
    PROCEDURE BtnSalvarClick()
        THIS.CmdConsultarClick()
    ENDPROC

    *==========================================================================
    * BtnCancelarClick - Cancela operacao atual e limpa os filtros
    * Equivalente OPERACIONAL do Cancelar: fecha cursor de resultado,
    * restaura valores iniciais e reabilita os campos de filtro.
    *==========================================================================
    PROCEDURE BtnCancelarClick()
        LOCAL loc_oErro
        TRY
            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF
            THIS.LimparCampos()
            THIS.HabilitarCampos(.T.)
            IF PEMSTATUS(THIS, "txt_4c_Grupo", 5) AND THIS.txt_4c_Grupo.Enabled
                THIS.txt_4c_Grupo.SetFocus()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Proc: "  + loc_oErro.Procedure, "Erro BtnCancelarClick")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Destroy - Libera BO e chama destrutor da classe base
    *==========================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.this_oBusinessObject) = "O"
            THIS.this_oBusinessObject = .NULL.
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

### BO (C:\4c\projeto\app\classes\SigPrPpcBO.prg):
*==============================================================================
* SigPrPpcBO.prg - Business Object - Produtos Por Conta
* Form OPERACIONAL: coleta filtros e consulta SigMvCab
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS SigPrPpcBO AS BusinessBase

    *-- Filtros de consulta - Grupo contabil (SigCdGcr)
    this_cGrupo       = ""
    this_cDGrupo      = ""

    *-- Filtros de consulta - Conta/Cliente (SigCdCli)
    this_cConta       = ""
    this_cContaDesc   = ""

    *-- Filtros de consulta - Operacao (SigCdOpe)
    this_cOperacao    = ""

    *-- Filtros de consulta - Periodo
    this_dInicial     = {}
    this_dFinal       = {}

    *-- Filtros de consulta - Empresa (SigCdEmp)
    this_cEmpresa     = ""
    this_cEmpresaDesc = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "Numes"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form OPERACIONAL nao tem chave primaria singular
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_cEmpresa) + TRANSFORM(THIS.this_cOperacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarGrupo - Verifica se grupo existe em SigCdGcr; popula this_cDGrupo
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarGrupo(par_cGrupo)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + ;
                       EscaparSQL(ALLTRIM(par_cGrupo))
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GcrVal")
            IF loc_nResult > 0 AND USED("cursor_4c_GcrVal") AND RECCOUNT("cursor_4c_GcrVal") > 0
                SELECT cursor_4c_GcrVal
                THIS.this_cDGrupo = ALLTRIM(descrs)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_GcrVal")
                USE IN cursor_4c_GcrVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarConta - Verifica se conta/cliente existe em SigCdCli; popula this_cContaDesc
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarConta(par_cConta)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT IClis, RClis FROM SigCdCli WHERE IClis = " + ;
                       EscaparSQL(ALLTRIM(par_cConta))
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliVal")
            IF loc_nResult > 0 AND USED("cursor_4c_CliVal") AND RECCOUNT("cursor_4c_CliVal") > 0
                SELECT cursor_4c_CliVal
                THIS.this_cContaDesc = ALLTRIM(RClis)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_CliVal")
                USE IN cursor_4c_CliVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarOperacao - Verifica se operacao existe em SigCdOpe
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarOperacao(par_cOperacao)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(ALLTRIM(par_cOperacao))
            IF USED("cursor_4c_OpeVal")
                USE IN cursor_4c_OpeVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpeVal")
            IF loc_nResult > 0 AND USED("cursor_4c_OpeVal") AND RECCOUNT("cursor_4c_OpeVal") > 0
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_OpeVal")
                USE IN cursor_4c_OpeVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Verifica se empresa existe em SigCdEmp; popula this_cEmpresaDesc
    * Retorna .T. se encontrado
    *--------------------------------------------------------------------------
    FUNCTION ValidarEmpresa(par_cEmpresa)
        LOCAL loc_lValido, loc_nResult, loc_oErro, loc_cSQL
        loc_lValido = .F.
        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
                       EscaparSQL(ALLTRIM(par_cEmpresa))
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
            IF loc_nResult > 0 AND USED("cursor_4c_EmpVal") AND RECCOUNT("cursor_4c_EmpVal") > 0
                SELECT cursor_4c_EmpVal
                THIS.this_cEmpresaDesc = ALLTRIM(Razas)
                loc_lValido = .T.
            ENDIF
            IF USED("cursor_4c_EmpVal")
                USE IN cursor_4c_EmpVal
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida todos os filtros obrigatorios
    * Retorna "" se tudo valido, ou mensagem de erro descritiva
    *--------------------------------------------------------------------------
    FUNCTION ValidarFiltros()
        LOCAL loc_cErro
        loc_cErro = ""

        IF EMPTY(ALLTRIM(THIS.this_cGrupo))
            RETURN "Grupo inv" + CHR(225) + "lido. Informe um grupo cont" + CHR(225) + "bil."
        ENDIF

        IF !THIS.ValidarGrupo(THIS.this_cGrupo)
            RETURN "Grupo " + CHR(34) + ALLTRIM(THIS.this_cGrupo) + CHR(34) + ;
                   " n" + CHR(227) + "o encontrado em SigCdGcr."
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cConta))
            RETURN "Conta inv" + CHR(225) + "lida. Informe uma conta."
        ENDIF

        IF !THIS.ValidarConta(THIS.this_cConta)
            RETURN "Conta " + CHR(34) + ALLTRIM(THIS.this_cConta) + CHR(34) + ;
                   " n" + CHR(227) + "o encontrada em SigCdCli."
        ENDIF

        IF EMPTY(THIS.this_dInicial)
            RETURN "Data inicial inv" + CHR(225) + "lida."
        ENDIF

        IF EMPTY(THIS.this_dFinal)
            RETURN "Data final inv" + CHR(225) + "lida."
        ENDIF

        IF THIS.this_dInicial > THIS.this_dFinal
            RETURN "Data inicial maior do que a data final."
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
            IF !THIS.ValidarOperacao(THIS.this_cOperacao)
                RETURN "Opera" + CHR(231) + CHR(227) + "o " + CHR(34) + ;
                       ALLTRIM(THIS.this_cOperacao) + CHR(34) + " n" + CHR(227) + "o encontrada."
            ENDIF
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
            IF !THIS.ValidarEmpresa(THIS.this_cEmpresa)
                RETURN "Empresa " + CHR(34) + ALLTRIM(THIS.this_cEmpresa) + CHR(34) + ;
                       " n" + CHR(227) + "o encontrada em SigCdEmp."
            ENDIF
        ENDIF

        RETURN loc_cErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarMovimentacoes - Executa consulta em SigMvCab com os filtros
    * Popula cursor TprMvCab (nome mantido para compatibilidade com SigPrPpp)
    * Retorna qtd de registros encontrados, ou -1 em erro de SQL
    *--------------------------------------------------------------------------
    FUNCTION ConsultarMovimentacoes()
        LOCAL loc_nResultado, loc_cWhere, loc_cSQL, loc_oErro
        LOCAL loc_cDtIniBase, loc_cDtFimBase, loc_cDtIniStr, loc_cDtFimStr
        loc_nResultado = -1
        TRY
            *-- Formata datas: inicio 00:00:00, fim 23:59:59
            loc_cDtIniBase = DTOS(THIS.this_dInicial)
            loc_cDtFimBase = DTOS(THIS.this_dFinal)
            loc_cDtIniStr  = "'" + SUBSTR(loc_cDtIniBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtIniBase,5,2) + "-" + SUBSTR(loc_cDtIniBase,7,2) + "'"
            loc_cDtFimStr  = "'" + SUBSTR(loc_cDtFimBase,1,4) + "-" + ;
                              SUBSTR(loc_cDtFimBase,5,2) + "-" + SUBSTR(loc_cDtFimBase,7,2) + ;
                              " 23:59:59'"

            *-- Monta clausula WHERE adicional com filtros opcionais
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                loc_cWhere = loc_cWhere + ;
                    " AND GrupoDs = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cConta))
                loc_cWhere = loc_cWhere + ;
                    " AND ContaDs = " + EscaparSQL(ALLTRIM(THIS.this_cConta))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cOperacao))
                loc_cWhere = loc_cWhere + " AND Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cOperacao))
            ENDIF

            IF !EMPTY(ALLTRIM(THIS.this_cEmpresa))
                loc_cWhere = loc_cWhere + " AND Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpresa))
            ENDIF

            loc_cSQL = "SELECT * FROM SigMvCab" + ;
                       " WHERE Datas BETWEEN " + loc_cDtIniStr + " AND " + loc_cDtFimStr + ;
                       loc_cWhere + ;
                       " ORDER BY Emps, Dopes, Numes"

            IF USED("TprMvCab")
                USE IN TprMvCab
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TprMvCab")

            IF loc_nResultado <= 0
                loc_nResultado = 0
            ELSE
                loc_nResultado = RECCOUNT("TprMvCab")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_nResultado = -1
        ENDTRY
        RETURN loc_nResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor de filtros para as props do BO
    * Cursor esperado: crSigTempC (SigTempC) ou similar com colunas de filtro
    * Campos opcionais - so mapeia os que existirem no cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                IF TYPE(par_cAliasCursor + ".cliente") != "U"
                    THIS.this_cConta = TratarNulo(cliente, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dcliente") != "U"
                    THIS.this_cContaDesc = TratarNulo(dcliente, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".operacao") != "U"
                    THIS.this_cOperacao = TratarNulo(operacao, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".datai") != "U"
                    THIS.this_dInicial = TratarNulo(datai, "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dataf") != "U"
                    THIS.this_dFinal = TratarNulo(dataf, "D")
                ENDIF
                IF TYPE(par_cAliasCursor + ".empresa") != "U"
                    THIS.this_cEmpresa = TratarNulo(empresa, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dempresa") != "U"
                    THIS.this_cEmpresaDesc = TratarNulo(dempresa, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".grupo") != "U"
                    THIS.this_cGrupo = TratarNulo(grupo, "C")
                ENDIF
                IF TYPE(par_cAliasCursor + ".dgrupo") != "U"
                    THIS.this_cDGrupo = TratarNulo(dgrupo, "C")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL: executa consulta em SigMvCab com os filtros
    * Nao ha persistencia de registros - a "acao" do form eh consultar
    * movimentacoes que atendem os filtros. Popula cursor TprMvCab (padrao legado).
    * RegistrarAuditoria registra a operacao CONSULTA no LogAuditoria.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_nQtd, loc_cErroFiltros, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cErroFiltros = THIS.ValidarFiltros()
            IF !EMPTY(loc_cErroFiltros)
                THIS.this_cMensagemErro = loc_cErroFiltros
                loc_lSucesso = .F.
            ENDIF

            loc_nQtd = THIS.ConsultarMovimentacoes()

            DO CASE
            CASE loc_nQtd < 0
                THIS.this_cMensagemErro = "Falha ao consultar movimenta" + CHR(231) + CHR(245) + "es."
            CASE loc_nQtd = 0
                THIS.this_cMensagemErro = "Nenhuma movimenta" + CHR(231) + CHR(227) + "o foi encontrada."
            OTHERWISE
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("CONSULTA")
            ENDCASE

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL nao persiste registros
    * Delega para Inserir() (executa nova consulta) mantendo contrato BusinessBase
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.Inserir()
    ENDPROC

ENDDEFINE

