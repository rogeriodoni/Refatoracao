# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (1)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CONTROLCOUNT' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: DATAS, EMPS

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
	lcQuery = [Select a.Emps, a.Datas, b.Cemps, b.Razas, a.Falhas, a.Pesoccbs ] + ;
				[From SigCdFea a ] + ;
				[Left Join SigCdEmp b On b.Cemps = a.Emps ] + ;
	If (ThisForm.poDataMgr.SqlExecute(lcQuery, 'crTmpRel') < 1)
	Select Emps as Cemps, ;
	  From crTmpRel ;
	Select crRel1

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGf1.prg) - TRECHOS RELEVANTES PARA PASS SQL (770 linhas total):

*-- Linhas 524 a 542:
524:     *--------------------------------------------------------------------------
525:     * BtnIncluirClick - Reset do filtro para novo processamento (equivalente
526:     * a "Nova consulta" em OPERACIONAL): restaura periodo padrao (mes corrente)
527:     * e devolve foco a DtInicial. Nao existe INSERT em SigPrGf1 (nao ha entidade
528:     * persistida ??? o form apenas processa saldos em memoria via ProcessarDados).
529:     *--------------------------------------------------------------------------
530:     PROCEDURE BtnIncluirClick()
531:         LOCAL loc_oErro
532: 
533:         TRY
534:             THIS.txt_4c_DtInicial.Value = CTOD("01/" + PADL(LTRIM(STR(MONTH(DATE()), 2)), 2, "0") + ;
535:                                                "/" + LTRIM(STR(YEAR(DATE()), 4)))
536:             THIS.txt_4c_DtFinal.Value   = GOMONTH(THIS.txt_4c_DtInicial.Value, 1) - 1
537: 
538:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
539:                 THIS.this_oBusinessObject.this_dDtInicial = THIS.txt_4c_DtInicial.Value
540:                 THIS.this_oBusinessObject.this_dDtFinal   = THIS.txt_4c_DtFinal.Value
541:                 THIS.this_oBusinessObject.this_cMensagem  = ""
542:             ENDIF

*-- Linhas 553 a 571:
553:     *--------------------------------------------------------------------------
554:     * BtnAlterarClick - Habilita edicao interativa do filtro de periodo:
555:     * garante que os campos de data estejam editaveis e devolve foco a
556:     * DtInicial. Nao ha UPDATE persistente em SigPrGf1 (form OPERACIONAL sem
557:     * entidade CRUD) ??? este evento existe para atender ao contrato da pipeline
558:     * e para uso via atalho de teclado equivalente a "editar filtro".
559:     *--------------------------------------------------------------------------
560:     PROCEDURE BtnAlterarClick()
561:         LOCAL loc_oErro
562: 
563:         TRY
564:             THIS.txt_4c_DtInicial.Enabled  = .T.
565:             THIS.txt_4c_DtInicial.ReadOnly = .F.
566:             THIS.txt_4c_DtFinal.Enabled    = .T.
567:             THIS.txt_4c_DtFinal.ReadOnly   = .F.
568: 
569:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
570:                 THIS.this_oBusinessObject.this_cMensagem = ""
571:             ENDIF

*-- Linhas 593 a 611:
593:     *--------------------------------------------------------------------------
594:     * BtnExcluirClick - Limpa o filtro de periodo (equivalente a "cancelar
595:     * consulta"): zera datas, limpa mensagem do BO e devolve foco a DtInicial.
596:     * Nao existe DELETE em SigPrGf1 (form OPERACIONAL sem entidade persistida)
597:     * ??? este evento existe para atender ao contrato da pipeline.
598:     *--------------------------------------------------------------------------
599:     PROCEDURE BtnExcluirClick()
600:         LOCAL loc_oErro
601: 
602:         TRY
603:             THIS.txt_4c_DtInicial.Value = {}
604:             THIS.txt_4c_DtFinal.Value   = {}
605: 
606:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
607:                 THIS.this_oBusinessObject.this_dDtInicial = {}
608:                 THIS.this_oBusinessObject.this_dDtFinal   = {}
609:                 THIS.this_oBusinessObject.this_cMensagem  = ""
610:             ENDIF
611: 


### BO (C:\4c\projeto\app\classes\SigPrGf1BO.prg):
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
                       " LEFT JOIN SigCdEmp b ON b.Cemps = a.Emps" + ;
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

