*==============================================================================
* SigPrGf1BO.prg - Business Object para Falha x Recuperacao por Mes
* Herda de: BusinessBase
* Form OPERACIONAL: selecao de periodo + processamento de SigCdFea
*==============================================================================
DEFINE CLASS SigPrGf1BO AS BusinessBase

    *-- Identificacao
    this_cTabela          = "SigCdFea"
    this_cCampoChave      = ""

    *-- Periodo de filtro
    this_dDtInicial       = {}
    this_dDtFinal         = {}

    *-- Empresa
    this_cEmpresa         = ""
    this_cNomeEmpresa     = ""

    *-- Titulos gerados pelo processamento
    this_cTitulo1         = ""
    this_cTitulo2         = ""

    *-- Nome do cursor de resultado produzido por ProcessarDados()
    this_cCursorResultado = "crRel1"

    *-- Mensagem de retorno para o form (equivalente a pcMsg legado)
    this_cMensagem        = ""

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdFea"
        THIS.this_cCampoChave = ""
        THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarPeriodo - Valida datas de filtro (equivalente a mChkValid do legado)
    * Retorna .T. se valido; seta this_cMensagem e retorna .F. se invalido
    *--------------------------------------------------------------------------
    PROCEDURE ValidarPeriodo()
        LOCAL loc_nDifMeses

        THIS.this_cMensagem = ""

        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagem = "Data Final Inv" + CHR(225) + "lida!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagem = "Data Inicial Maior Que a Data Final!!!"
            RETURN .F.
        ENDIF

        IF YEAR(THIS.this_dDtInicial) = YEAR(THIS.this_dDtFinal)
            loc_nDifMeses = MONTH(THIS.this_dDtInicial) - MONTH(THIS.this_dDtFinal) + 1
        ELSE
            loc_nDifMeses = (12 - MONTH(THIS.this_dDtInicial)) + MONTH(THIS.this_dDtFinal) + 1
        ENDIF

        IF loc_nDifMeses > 12
            THIS.this_cMensagem = "Per" + CHR(237) + "odo Ultrapassa Doze Meses!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDados - Gera cursor crRel1 com dados agregados de SigCdFea
    * Equivalente a mProcessamento do legado
    * Retorna .T. se encontrou registros, .F. caso contrario ou em erro
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDados()
        LOCAL loc_lSucesso, loc_lContinuar
        LOCAL loc_cSQL, loc_cNomeEmpresa
        LOCAL loc_cDtIni, loc_cDtFim
        LOCAL loc_cStrgMes, loc_cTitulo1, loc_cTitulo2, loc_cEmpresa
        LOCAL loc_nSaveDecimals, loc_cSaveFixed, loc_cSaveExact

        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        THIS.this_cMensagem = ""

        TRY
            *-- Buscar nome da empresa no SQL Server
            loc_cNomeEmpresa = ""
            IF SQLEXEC(gnConnHandle, ;
                "SELECT Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(THIS.this_cEmpresa), ;
                "crSigCdEmpGf1") > 0
                IF !EOF("crSigCdEmpGf1")
                    SELECT crSigCdEmpGf1
                    loc_cNomeEmpresa = ALLTRIM(NVL(crSigCdEmpGf1.Razas, ""))
                ENDIF
                USE IN crSigCdEmpGf1
            ENDIF
            THIS.this_cNomeEmpresa = loc_cNomeEmpresa

            *-- Formatar datas para SQL Server
            loc_cDtIni = FormatarDataSQL(THIS.this_dDtInicial)
            loc_cDtFim = "'" + DTOC(THIS.this_dDtFinal, 1) + " 23:59:59'"

            *-- SQL de busca no SQL Server
            loc_cSQL = "SELECT a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs" + ;
                       " FROM SigCdFea a" + ;
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.Cemps" + ;
                       " WHERE a.Datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                       " AND a.Emps = " + EscaparSQL(THIS.this_cEmpresa)

            IF USED("crTmpRelGf1")
                USE IN crTmpRelGf1
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpRelGf1") < 1
                THIS.this_cMensagem = "Falha na conex" + CHR(227) + "o ao buscar dados de SigCdFea."
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar AND EOF("crTmpRelGf1")
                THIS.this_cMensagem = "Nenhum Registro Encontrado."
                USE IN crTmpRelGf1
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                *-- Variaveis para o SELECT VFP local (usar m. prefix nas refs abaixo)
                loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)

                *-- String de nomes de meses, 9 chars por mes (12 * 9 = 108 chars)
                loc_cStrgMes  = "Janeiro  " + "Fevereiro" + "Mar" + CHR(231) + "o    " + ;
                                "Abril    " + "Maio     " + "Junho    " + ;
                                "Julho    " + "Agosto   " + "Setembro " + ;
                                "Outubro  " + "Novembro " + "Dezembro "

                loc_cTitulo1  = "Falha X Recupera" + CHR(231) + CHR(227) + ;
                                "o por M" + CHR(234) + "s da Empresa "

                IF EMPTY(THIS.this_dDtInicial) AND EMPTY(THIS.this_dDtFinal)
                    loc_cTitulo2 = ""
                ELSE
                    IF THIS.this_dDtInicial = THIS.this_dDtFinal
                        loc_cTitulo2 = " [Em " + DTOC(THIS.this_dDtInicial) + "]"
                    ELSE
                        IF EMPTY(THIS.this_dDtInicial)
                            loc_cTitulo2 = " [At" + CHR(233) + " " + DTOC(THIS.this_dDtFinal) + "]"
                        ELSE
                            loc_cTitulo2 = " [De " + DTOC(THIS.this_dDtInicial) + ;
                                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + "]"
                        ENDIF
                    ENDIF
                ENDIF

                THIS.this_cTitulo1 = loc_cTitulo1
                THIS.this_cTitulo2 = loc_cTitulo2

                IF USED("crRel1")
                    USE IN crRel1
                ENDIF

                *-- Salvar configuracoes SET para restaurar apos SELECT
                loc_nSaveDecimals = SET("DECIMALS")
                loc_cSaveFixed    = SET("FIXED")
                loc_cSaveExact    = SET("EXACT")

                SET DECIMALS TO 6
                SET FIXED ON
                SET EXACT ON

                *-- SELECT VFP local: agrega dados de SigCdFea por empresa/mes
                SELECT Emps AS Cemps, ;
                       PADR(DTOS(Datas), 6) AS cAnomess, ;
                       PADR(PADR(SUBSTR(m.loc_cStrgMes, (MONTH(Datas) * 9 - 8), 9), 3) + "./" + ;
                            TRANSFORM(YEAR(Datas), "@L 9999"), 9) AS csTraNomes, ;
                       PADR(m.loc_cTitulo1 + ALLTRIM(NVL(Cemps, "")) + ;
                            " - " + ALLTRIM(NVL(Razas, "")), 100) AS cTitulo1s, ;
                       m.loc_cTitulo2 AS ctitulo2s, ;
                       PADR(ALLTRIM(m.loc_cEmpresa) + " - " + ;
                            ALLTRIM(m.loc_cNomeEmpresa), 100) AS cEmpresas, ;
                       VAL(STR(SUM(Falhas), 16, 2)) AS nFalhas, ;
                       VAL(STR(SUM(Pesoccbs), 16, 2)) AS nPesoccbs ;
                  FROM crTmpRelGf1 ;
                 GROUP BY 1, 2, 3, 4, 5, 6 ;
                  INTO CURSOR crRel1 READWRITE

                SELECT crRel1
                GO TOP

                *-- Restaurar configuracoes SET
                SET DECIMALS TO (loc_nSaveDecimals)
                IF loc_cSaveFixed = "ON"
                    SET FIXED ON
                ELSE
                    SET FIXED OFF
                ENDIF
                IF loc_cSaveExact = "ON"
                    SET EXACT ON
                ELSE
                    SET EXACT OFF
                ENDIF

                USE IN crTmpRelGf1

                loc_lSucesso = !EOF("crRel1")
                IF !loc_lSucesso
                    THIS.this_cMensagem = "Nenhum Registro Encontrado."
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " PROC=" + loc_oErro.Procedure, "Erro em ProcessarDados")
            THIS.this_cMensagem = "Erro no processamento: " + loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades BO a partir do cursor de resultado
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cEmpresa     = NVL(Cemps, "")
            THIS.this_cTitulo1     = NVL(cTitulo1s, "")
            THIS.this_cTitulo2     = NVL(ctitulo2s, "")
            THIS.this_cNomeEmpresa = NVL(cEmpresas, "")
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Form OPERACIONAL nao insere linhas em SigCdFea diretamente
    * SigCdFea eh populada por outros processos do sistema (movimentacao de
    * producao). Este BO apenas LE e agrega dados para o relatorio de
    * "Falha X Recuperacao por Mes". Bloquear insercao evita gravacao acidental.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        THIS.this_cMensagem = "Form operacional: inser" + CHR(231) + CHR(227) + ;
                              "o direta em SigCdFea n" + CHR(227) + "o " + ;
                              "suportada. Utilize os m" + CHR(243) + "dulos de " + ;
                              "movimenta" + CHR(231) + CHR(227) + "o de produ" + ;
                              CHR(231) + CHR(227) + "o."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Form OPERACIONAL nao atualiza linhas de SigCdFea
    * Bloqueia UPDATE por design: este BO consome dados agregados, nao mantem
    * cadastro. Alteracoes em SigCdFea ocorrem via processos de producao.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        THIS.this_cMensagem = "Form operacional: atualiza" + CHR(231) + CHR(227) + ;
                              "o direta em SigCdFea n" + CHR(227) + "o " + ;
                              "suportada. Utilize os m" + CHR(243) + "dulos de " + ;
                              "movimenta" + CHR(231) + CHR(227) + "o de produ" + ;
                              CHR(231) + CHR(227) + "o."
        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Form OPERACIONAL nao exclui linhas de SigCdFea
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        THIS.this_cMensagem = "Form operacional: exclus" + CHR(227) + "o direta " + ;
                              "em SigCdFea n" + CHR(227) + "o suportada."
        RETURN .F.
    ENDFUNC

ENDDEFINE
