*==============================================================================
* SIGOPCGLBO.PRG
* Business Object - Historico de Locais (SigCdMlc)
* Origem legado: SIGOPCGL.SCX (form generico, filtro por barras)
* Form: FormSigOpCgl.prg (OPERACIONAL - somente leitura)
*
* O legado (Init do SCX) faz APENAS um Select filtrado por barras e exibe o
* resultado num grid - nao ha Insert/Update/Delete em lugar nenhum do dump
* (nenhum TABLEUPDATE, nenhum .AddCursor). SigCdMlc eh log de movimentacao de
* local, populado por outro processo; este form so CONSULTA. Por isso
* Inserir()/Atualizar()/ExecutarExclusao() sao sobrescritos apenas para
* informar que a operacao nao e suportada por este BO - nunca para inventar
* INSERT/UPDATE que o legado nao faz. Metodos presentes nesta fase:
* CarregarHistorico (Select real), CarregarDoCursor (mapeia as colunas do
* cursor para as propriedades), ObterChavePrimaria, Inserir, Atualizar.
*==============================================================================

DEFINE CLASS SigOpCglBO AS BusinessBase

    *-- Propriedades (nomenclatura: this_ + tipo)
    this_nBarras      = 0    && SigCdMlc.barras - numeric(14,0) - chave de filtro (parametro do form)
    this_dDatas       = {}   && SigCdMlc.datas - datetime
    this_cHoras       = ""   && SigCdMlc.horas - char(8)
    this_cLocatus     = ""   && SigCdMlc.locatus - char(10) - local atual (antes da alteracao)
    this_cLocnews     = ""   && SigCdMlc.locnews - char(10) - local novo (depois da alteracao)
    this_cUsuars      = ""   && SigCdMlc.usuars - char(10)
    this_cEmpdopnums  = ""   && SigCdMlc.empdopnums - char(29) - identificacao da operacao

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela      = "SigCdMlc"
        THIS.this_cCampoChave  = "cidchaves"

        DODEFAULT("SigCdMlc")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarHistorico - Executa o Select do legado (SigCdMlc filtrado por
    * barras) e popula cursor_4c_HistoricoCgl, que o Grid da Lista consome.
    *   par_nBarras = codigo de barras cujo historico de locais sera exibido
    * Retorna .T. se ok, .F. se erro
    *--------------------------------------------------------------------------
    FUNCTION CarregarHistorico(par_nBarras)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_nResult

        loc_lSucesso = .F.

        TRY
            *-- Cursor placeholder identico ao que o SQLEXEC vai popular
            SET NULL ON
            IF USED("cursor_4c_HistoricoCgl")
                USE IN cursor_4c_HistoricoCgl
            ENDIF
            CREATE CURSOR cursor_4c_HistoricoCgl ;
                (Datas      T     NULL, ;
                 Horas      C(8)  NULL, ;
                 Locatus    C(10) NULL, ;
                 Locnews    C(10) NULL, ;
                 Usuars     C(10) NULL, ;
                 Empdopnums C(29) NULL)
            SET NULL OFF

            THIS.this_nBarras = par_nBarras

            *-- Select identico ao Init do SCX legado (ordem das colunas e do
            *-- Order By transcritos sem alteracao)
            loc_cSQL = "SELECT datas, horas, locatus, locnews, usuars, empdopnums " + ;
                       "FROM SigCdMlc " + ;
                       "WHERE barras = " + FormatarNumeroSQL(par_nBarras, 0) + " " + ;
                       "ORDER BY datas, horas, locatus, locnews, usuars, empdopnums"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistCglTemp")

            IF loc_nResult >= 0
                SELECT cursor_4c_HistoricoCgl
                ZAP
                APPEND FROM DBF("cursor_4c_HistCglTemp")
                IF USED("cursor_4c_HistCglTemp")
                    USE IN cursor_4c_HistCglTemp
                ENDIF
                SELECT cursor_4c_HistoricoCgl
                GO TOP
                loc_lSucesso = .T.
            ELSE
                LOCAL loc_aErroSQL[1]
                AERROR(loc_aErroSQL)
                MsgErro("Erro ao carregar hist" + CHR(243) + "rico de locais:" + CHR(13) + ;
                        loc_aErroSQL[2], "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro em CarregarHistorico")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o registro corrente de cursor_4c_HistoricoCgl
    * (ou do alias informado) para as propriedades da instancia
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_cAlias

        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                         par_cAliasCursor, "cursor_4c_HistoricoCgl")

        IF !USED(loc_cAlias)
            THIS.this_cMensagemErro = "Cursor de hist" + CHR(243) + "rico n" + CHR(227) + ;
                                      "o est" + CHR(225) + " aberto: " + loc_cAlias
            RETURN .F.
        ENDIF

        SELECT (loc_cAlias)
        IF RECCOUNT() = 0 OR EOF()
            RETURN .F.
        ENDIF

        THIS.this_dDatas      = TratarNulo(datas, {})
        THIS.this_cHoras      = TratarNulo(horas, "")
        THIS.this_cLocatus    = TratarNulo(locatus, "")
        THIS.this_cLocnews    = TratarNulo(locnews, "")
        THIS.this_cUsuars     = TratarNulo(usuars, "")
        THIS.this_cEmpdopnums = TratarNulo(empdopnums, "")

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional eh somente consulta; nao ha uma
    * unica coluna-chave exibida (a PK real da tabela, cidchaves, nem entra no
    * Select do legado)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Historico de Locais eh SOMENTE LEITURA
    *   SigCdMlc eh log de movimentacao de local, gravado por outro processo
    *   (movimentacao de produto/local). Este BO nunca grava nela.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico de Locais " + CHR(233) + ;
                                  " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de INSER" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Historico de Locais eh SOMENTE LEITURA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico de Locais " + CHR(233) + ;
                                  " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de ATUALIZA" + CHR(199) + ;
                                  CHR(195) + "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Historico de Locais eh SOMENTE LEITURA
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        THIS.this_cMensagemErro = "Hist" + CHR(243) + "rico de Locais " + CHR(233) + ;
                                  " somente leitura." + CHR(13) + ;
                                  "Opera" + CHR(231) + CHR(227) + "o de EXCLUS" + CHR(195) + ;
                                  "O n" + CHR(227) + "o " + CHR(233) + " suportada."
        RETURN .F.
    ENDFUNC

ENDDEFINE
