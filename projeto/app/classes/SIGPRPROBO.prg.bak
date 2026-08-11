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
