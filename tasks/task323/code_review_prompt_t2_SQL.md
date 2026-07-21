# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: CPROS

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
	lcQuery = [Select DPros ] + ;
			    [From SigCdPro ] + ;
	If (.ParentForm.poDataMgr.SqlExecute(lcQuery, 'LocalPro') < 1)
		.Column1.ControlSource  = 'LocalCrPro.Caracteris'

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRPRO.prg) - TRECHOS RELEVANTES PARA PASS SQL (690 linhas total):

*-- Linhas 87 a 111:
87:                 *-- Carregar descricao do produto
88:                 THIS.this_oBusinessObject.BuscarDadosProduto(THIS.this_cCPros)
89: 
90:                 *-- Criar cursor placeholder para o grid (estrutura identica ao SQLEXEC do BO)
91:                 IF USED("cursor_4c_Carac")
92:                     TABLEREVERT(.T., "cursor_4c_Carac")
93:                     USE IN cursor_4c_Carac
94:                 ENDIF
95:                 SET NULL ON
96:                 CREATE CURSOR cursor_4c_Carac ;
97:                     (cidchaves  C(20), ;
98:                      caracteris C(40), ;
99:                      compls     C(40), ;
100:                      infos      M)
101:                 SET NULL OFF
102: 
103:                 *-- Criar componentes visuais
104:                 THIS.ConfigurarCabecalho()
105:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
106:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
107: 
108:                 *-- Criar area de exibicao do produto (shapes decorativos + codigo)
109:                 THIS.ConfigurarPaginaLista()
110:                 *-- Criar area de conteudo (grid + complemento + memo + botao OK)
111:                 THIS.ConfigurarPaginaDados()

*-- Linhas 345 a 363:
345:             .ColumnCount        = 1
346:             .ReadOnly           = .F.
347:             .RecordMark         = .F.
348:             .DeleteMark         = .F.
349:             .GridLineColor      = RGB(238, 238, 238)
350:             .HighlightBackColor = RGB(255, 255, 255)
351:             .HighlightForeColor = RGB(15, 41, 104)
352:             .HighlightStyle     = 2
353:             .ScrollBars         = 2
354:             .RowHeight          = 16
355:             .Visible            = .T.
356:         ENDWITH
357: 
358:         *-- Configurar coluna 1: Caracteristicas
359:         *-- Original: Column1.FontName="Courier New", Width=290, Text1.When()=.F.
360:         loc_oGrd = THIS.grd_4c_Dados
361:         WITH loc_oGrd.Column1
362:             .Width     = 363
363:             .Movable   = .F.

*-- Linhas 456 a 474:
456:             loc_oGrd = THIS.grd_4c_Dados
457:             loc_oGrd.ColumnCount           = 1
458:             loc_oGrd.RecordSource          = "cursor_4c_Carac"
459:             loc_oGrd.Column1.ControlSource = "cursor_4c_Carac.caracteris"
460:             *-- Re-setar cabecalho (RecordSource pode resetar headers)
461:             loc_oGrd.Column1.Header1.Caption = "Caracter" + CHR(237) + "sticas"
462: 
463:             *-- Exibir informacoes da primeira caracteristica (se houver)
464:             IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
465:                 GO TOP IN cursor_4c_Carac
466:                 THIS.txt_4c_Comples.Value = NVL(cursor_4c_Carac.compls, "")
467:                 THIS.edt_4c_Infos.Value   = NVL(cursor_4c_Carac.infos, "")
468:             ELSE
469:                 THIS.txt_4c_Comples.Value = ""
470:                 THIS.edt_4c_Infos.Value   = ""
471:             ENDIF
472: 
473:         CATCH TO loc_oErro
474:             MsgErro(loc_oErro.Message + " | LN=" + TRANSFORM(loc_oErro.LineNo), ;

*-- Linhas 636 a 654:
636: 
637:         IF PEMSTATUS(THIS, "txt_4c_Comples", 5)
638:             IF USED("cursor_4c_Carac") AND RECCOUNT("cursor_4c_Carac") > 0
639:                 SELECT cursor_4c_Carac
640:                 GO TOP
641:                 THIS.txt_4c_Comples.Value = NVL(ALLTRIM(compls), "")
642:                 THIS.edt_4c_Infos.Value   = NVL(infos, "")
643:             ELSE
644:                 THIS.txt_4c_Comples.Value = ""
645:                 THIS.edt_4c_Infos.Value   = ""
646:             ENDIF
647:         ENDIF
648:     ENDPROC
649: 
650:     *---------------------------------------------------------------------------
651:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
652:     *-- Formulario somente-leitura: ignora o parametro.
653:     *-- Todos os campos permanecem desabilitados (When=.F. no legado).
654:     *-- O unico controle interativo eh o grid e o botao OK.


### BO (C:\4c\projeto\app\classes\SIGPRPROBO.prg):
*==============================================================================
* SIGPRPROBO.prg - Business Object: Caracteristicas de Produtos
* Tabela principal : SigPrCrr
* Form OPERACIONAL - somente leitura (viewer de caracteristicas por produto)
* Fase 2/8: Metodos CRUD (BuscarDadosProduto, BuscarCaracteristicas,
*            CarregarDoCursor, ObterChavePrimaria)
*==============================================================================
DEFINE CLASS SIGPRPROBO AS BusinessBase

  *-- SigCdPro
  this_cCPros   = ""   && cpros char(14) - codigo do produto (FK SigCdPro)
  this_cDPros   = ""   && dpros char(65) - descricao do produto

  *-- SigPrCrr
  this_cCidChaves  = ""   && cidchaves  char(20) - chave PK da caracteristica
  this_cCaracteris = ""   && caracteris char(40) - texto da caracteristica
  this_cCompls     = ""   && compls     char(40) - complemento
  this_cInfos      = ""   && infos      text     - informacoes detalhadas (memo)

  *----------------------------------------------------------------------------
  PROCEDURE Init()
    THIS.this_cTabela     = "SigPrCrr"
    THIS.this_cCampoChave = "cidchaves"
    DODEFAULT()
  ENDPROC

  *----------------------------------------------------------------------------
  * BuscarDadosProduto - Carrega descricao do produto em this_cDPros
  *   Equivale ao: SELECT DPros FROM SigCdPro WHERE CPros = pPro
  * Retorna .T. se encontrou, .F. se nao encontrou ou erro
  *----------------------------------------------------------------------------
  FUNCTION BuscarDadosProduto(par_cCPros)
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.

    TRY
      loc_cSQL = "SELECT dpros FROM SigCdPro " + ;
                 "WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros))

      IF USED("cursor_4c_ProTemp")
        USE IN cursor_4c_ProTemp
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProTemp")

      IF loc_nRet > 0 AND USED("cursor_4c_ProTemp") AND RECCOUNT("cursor_4c_ProTemp") > 0
        SELECT cursor_4c_ProTemp
        GO TOP
        THIS.this_cDPros = NVL(ALLTRIM(dpros), "")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cDPros = ""
      ENDIF

      IF USED("cursor_4c_ProTemp")
        USE IN cursor_4c_ProTemp
      ENDIF

    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * BuscarCaracteristicas - Carrega SigPrCrr no cursor_4c_Carac para o grid
  *   Equivale ao: CursorQuery('SigPrCrr', 'LocalCrPro', 'CPros', pPro)
  *   O cursor cursor_4c_Carac deve existir (criado no InicializarForm do Form)
  * Retorna .T. se sucesso, .F. se erro
  *----------------------------------------------------------------------------
  FUNCTION BuscarCaracteristicas(par_cCPros)
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.

    TRY
      loc_cSQL = "SELECT cidchaves, caracteris, compls, infos " + ;
                 "FROM SigPrCrr " + ;
                 "WHERE cpros = " + EscaparSQL(ALLTRIM(par_cCPros)) + " " + ;
                 "ORDER BY cidchaves"

      IF USED("cursor_4c_CaracTemp")
        USE IN cursor_4c_CaracTemp
      ENDIF

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CaracTemp")

      IF loc_nRet >= 0
        IF USED("cursor_4c_Carac")
          TABLEREVERT(.T., "cursor_4c_Carac")
          SELECT cursor_4c_Carac
          ZAP
          IF USED("cursor_4c_CaracTemp") AND RECCOUNT("cursor_4c_CaracTemp") > 0
            APPEND FROM DBF("cursor_4c_CaracTemp")
          ENDIF
          GO TOP IN cursor_4c_Carac
        ENDIF

        IF USED("cursor_4c_CaracTemp")
          USE IN cursor_4c_CaracTemp
        ENDIF

        loc_lSucesso = .T.
      ELSE
        IF USED("cursor_4c_CaracTemp")
          USE IN cursor_4c_CaracTemp
        ENDIF
        MsgErro("Erro ao consultar caracter" + CHR(237) + "sticas do produto.", "Erro")
      ENDIF

    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
  *   par_cAliasCursor: nome do alias do cursor (ex: "cursor_4c_Carac")
  * Retorna .T. se sucesso, .F. caso contrario
  *----------------------------------------------------------------------------
  FUNCTION CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso, loc_oErro

    loc_lSucesso = .F.

    TRY
      IF USED(par_cAliasCursor) AND RECCOUNT(par_cAliasCursor) > 0
        SELECT (par_cAliasCursor)
        THIS.this_cCidChaves  = NVL(ALLTRIM(cidchaves), "")
        THIS.this_cCaracteris = NVL(ALLTRIM(caracteris), "")
        THIS.this_cCompls     = NVL(ALLTRIM(compls), "")
        THIS.this_cInfos      = NVL(ALLTRIM(infos), "")
        loc_lSucesso = .T.
      ENDIF
    CATCH TO loc_oErro
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * ObterChavePrimaria - Retorna valor da chave primaria (cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ObterChavePrimaria()
    RETURN ALLTRIM(THIS.this_cCidChaves)
  ENDFUNC

  *----------------------------------------------------------------------------
  * ValidarDados - Valida campos obrigatorios de SigPrCrr
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ValidarDados()
    LOCAL loc_lValido

    loc_lValido = .T.
    THIS.this_cMensagemErro = ""

    IF EMPTY(ALLTRIM(THIS.this_cCPros))
      THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto (cpros) " + CHR(233) + " obrigat" + CHR(243) + "rio."
      loc_lValido = .F.
    ENDIF

    IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCidChaves))
      THIS.this_cMensagemErro = "Chave da caracter" + CHR(237) + "stica (cidchaves) " + CHR(233) + " obrigat" + CHR(243) + "ria."
      loc_lValido = .F.
    ENDIF

    IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cCaracteris))
      THIS.this_cMensagemErro = "Descri" + CHR(231) + CHR(227) + "o da caracter" + CHR(237) + "stica " + CHR(233) + " obrigat" + CHR(243) + "ria."
      loc_lValido = .F.
    ENDIF

    RETURN loc_lValido
  ENDFUNC

  *----------------------------------------------------------------------------
  * Inserir - Insere novo registro em SigPrCrr
  *   Colunas: caracteris char(40), cidchaves char(20) PK, compls char(40),
  *            cpros char(14), infos text NULL
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION Inserir()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "INSERT INTO SigPrCrr (caracteris, cidchaves, compls, cpros, infos) VALUES (" + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCaracteris), 40)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompls), 40)) + ", " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                 EscaparSQL(ALLTRIM(THIS.this_cInfos)) + ")"

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet > 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao inserir caracter" + CHR(237) + "stica no SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * Atualizar - Atualiza registro existente em SigPrCrr (chave cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION Atualizar()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "UPDATE SigPrCrr SET " + ;
                 "caracteris = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCaracteris), 40)) + ", " + ;
                 "compls = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCompls), 40)) + ", " + ;
                 "cpros = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCPros), 14)) + ", " + ;
                 "infos = " + EscaparSQL(ALLTRIM(THIS.this_cInfos)) + " " + ;
                 "WHERE cidchaves = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet >= 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao atualizar caracter" + CHR(237) + "stica no SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

  *----------------------------------------------------------------------------
  * ExecutarExclusao - Deleta registro em SigPrCrr (chave cidchaves)
  *----------------------------------------------------------------------------
  PROTECTED FUNCTION ExecutarExclusao()
    LOCAL loc_lSucesso, loc_cSQL, loc_nRet, loc_oErro

    loc_lSucesso = .F.
    THIS.this_cMensagemErro = ""

    TRY
      loc_cSQL = "DELETE FROM SigPrCrr WHERE cidchaves = " + ;
                 EscaparSQL(LEFT(ALLTRIM(THIS.this_cCidChaves), 20))

      loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

      IF loc_nRet >= 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lSucesso = .T.
      ELSE
        THIS.this_cMensagemErro = "Falha ao excluir caracter" + CHR(237) + "stica do SigPrCrr."
      ENDIF

    CATCH TO loc_oErro
      THIS.this_cMensagemErro = loc_oErro.Message
      MsgErro(loc_oErro.Message, "Erro")
    ENDTRY

    RETURN loc_lSucesso
  ENDFUNC

ENDDEFINE

