*==============================================================================
* GerarFRXSigReCmc.prg
* Gera SigReCm1.frx / SigReCm2.frx / SigReCm3.frx para o relatorio
* "Clientes que Mais/Menos/Nao Compram" (Formsigrecmc / sigrecmcBO).
*
* CONTEXTO (Erro215): os FRX originais do legado NUNCA foram adquiridos - a
* fase 2 da task052 registrou a pendencia e ela nunca foi concluida. Como nao
* ha original para copiar (que seria o caminho do CriarNovoFRX.prg), o layout
* aqui eh CONSTRUIDO, no estilo da familia SigReCm* (Verdana 7/8/9/12,
* cabecalho com empresa/titulo/periodo, rodape com paginacao).
*
* TECNICA: parte-se do "quick report" nativo (CREATE REPORT ... FROM ... COLUMN),
* que produz um FRX estruturalmente VALIDO, e em seguida reescrevem-se os
* objetos. Montar o FRX do zero registro a registro produz arquivo invalido
* (ver aviso em docs/report_guide.md).
*
* A ORDEM DOS REGISTROS IMPORTA: o motor de relatorio ignora objeto que venha
* DEPOIS dos registros de fonte/DataEnvironment (objtype 23 e 25) - no FRX
* legado de referencia (SigReCmv.frx) o 25 eh o ULTIMO registro. Por isso, no
* fim, o arquivo eh REORDENADO: primeiro todos os objetos, depois 23 e 25.
* (Reaproveitar registros sobrando do quick report NAO funciona: em layout
* COLUMN ele so emite o que cabe na largura da pagina, e sobra pouco.)
*
* GEOMETRIA: posicoes em 1/10000 de polegada. As bandas empilham e cada uma
* consome (height + 2084) - os 2084 sao a barra separadora da banda. Logo:
*     base(PageHeader) = 0
*     base(Detail)     = AlturaPageHeader + 2084
*     base(PageFooter) = AlturaPageHeader + 2084 + AlturaDetail + 2084
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE SEPARADOR_BANDA  2084
#DEFINE ALT_PAGEHEADER   9000
#DEFINE ALT_DETAIL       1770
#DEFINE ALT_PAGEFOOTER   2600

*-- Coluna de medida: segue a "Selecao" da tela, mesmo criterio que o BO usa
*-- para preencher nvalcomp x nqtde.
#DEFINE EXPR_MEDIDA  "IIF(ALLTRIM(CsCabecalho.nm_tipo) == 'Valor', TmpResult.nvalcomp, TmpResult.nqtde)"

LOCAL lcLog
lcLog = "C:\4c\automation\frxtmp\gerar_frx.log"
STRTOFILE("GerarFRXSigReCmc " + TTOC(DATETIME()) + CHR(13) + CHR(10), lcLog)

*------------------------------------------------------------------------------
* SigReCm1 - layout PADRAO (sem comparativo, sem dados do cliente). Retrato.
*   [n,1] legenda   [n,2] expressao   [n,3] hpos   [n,4] width
*------------------------------------------------------------------------------
LOCAL ARRAY laCm1[6, 4]
laCm1[1,1] = "Ordem"
laCm1[1,2] = "ordem"
laCm1[1,3] = 0
laCm1[1,4] = 5000

laCm1[2,1] = "C" + CHR(243) + "digo"
laCm1[2,2] = "ciclis"
laCm1[2,3] = 5500
laCm1[2,4] = 11000

laCm1[3,1] = "Cliente"
laCm1[3,2] = "crclis"
laCm1[3,3] = 17000
laCm1[3,4] = 26000

laCm1[4,1] = "Classif."
laCm1[4,2] = "clacos"
laCm1[4,3] = 43500
laCm1[4,4] = 9000

laCm1[5,1] = "Compras"
laCm1[5,2] = "ncompras"
laCm1[5,3] = 53000
laCm1[5,4] = 7500

*-- Legenda DINAMICA: "Valor" ou "Quantidade", conforme a tela
laCm1[6,1] = "=CsCabecalho.nm_tipo"
laCm1[6,2] = EXPR_MEDIDA
laCm1[6,3] = 61000
laCm1[6,4] = 14000

GerarUm("C:\4c\projeto\app\reports\SigReCm1.frx", @laCm1, 0, lcLog)

*------------------------------------------------------------------------------
* SigReCm2 - COMPARATIVO: uma coluna por ano (nm_Ano1..6 do CsCabecalho).
* Paisagem.
*------------------------------------------------------------------------------
LOCAL ARRAY laCm2[8, 4]
laCm2[1,1] = "C" + CHR(243) + "digo"
laCm2[1,2] = "ciclis"
laCm2[1,3] = 0
laCm2[1,4] = 11000

laCm2[2,1] = "Cliente"
laCm2[2,2] = "crclis"
laCm2[2,3] = 11500
laCm2[2,4] = 25000

LOCAL lnI, lcSufixo
FOR lnI = 1 TO 6
    lcSufixo = TRANSFORM(lnI)
    *-- Legenda DINAMICA: o rotulo do ano vem do cursor de cabecalho
    laCm2[lnI + 2, 1] = "=ALLTRIM(CsCabecalho.nm_Ano" + lcSufixo + ")"
    laCm2[lnI + 2, 2] = "IIF(ALLTRIM(CsCabecalho.nm_tipo) == 'Valor', " + ;
                        "TmpResult.nValAno" + lcSufixo + ", TmpResult.nQtdAno" + lcSufixo + ")"
    laCm2[lnI + 2, 3] = 37000 + (lnI - 1) * 12000
    laCm2[lnI + 2, 4] = 11500
ENDFOR

GerarUm("C:\4c\projeto\app\reports\SigReCm2.frx", @laCm2, 1, lcLog)

*------------------------------------------------------------------------------
* SigReCm3 - DADOS DO CLIENTE: TmpResult ampliado com as colunas de SigCdCli
* (cidas, estas, contato, tel1s, emails) pelo join em PrepararDados. Paisagem.
*------------------------------------------------------------------------------
LOCAL ARRAY laCm3[9, 4]
laCm3[1,1] = "Ordem"
laCm3[1,2] = "ordem"
laCm3[1,3] = 0
laCm3[1,4] = 4500

laCm3[2,1] = "C" + CHR(243) + "digo"
laCm3[2,2] = "ciclis"
laCm3[2,3] = 5000
laCm3[2,4] = 11000

laCm3[3,1] = "Cliente"
laCm3[3,2] = "crclis"
laCm3[3,3] = 16500
laCm3[3,4] = 20000

laCm3[4,1] = "Cidade"
laCm3[4,2] = "cidas"
laCm3[4,3] = 37000
laCm3[4,4] = 13500

laCm3[5,1] = "UF"
laCm3[5,2] = "estas"
laCm3[5,3] = 51000
laCm3[5,4] = 3000

laCm3[6,1] = "Contato"
laCm3[6,2] = "contato"
laCm3[6,3] = 54500
laCm3[6,4] = 13500

laCm3[7,1] = "Telefone"
laCm3[7,2] = "tel1s"
laCm3[7,3] = 68500
laCm3[7,4] = 11000

laCm3[8,1] = "E-mail"
laCm3[8,2] = "emails"
laCm3[8,3] = 80000
laCm3[8,4] = 16000

laCm3[9,1] = "=CsCabecalho.nm_tipo"
laCm3[9,2] = EXPR_MEDIDA
laCm3[9,3] = 96500
laCm3[9,4] = 12000

GerarUm("C:\4c\projeto\app\reports\SigReCm3.frx", @laCm3, 1, lcLog)

STRTOFILE("FIM" + CHR(13) + CHR(10), lcLog, 1)
QUIT


*==============================================================================
* GerarUm - gera UM arquivo FRX
*==============================================================================
PROCEDURE GerarUm(par_cDestino, par_aCols, par_nOrientacao, par_cLog)
    LOCAL lnCols, lnI, lcBaseDbf, lcCampos, lcNome, lcTmp
    LOCAL lnBaseDet, lnBasePie, lnLargura, lnLabel, lnCampo

    lnCols    = ALEN(par_aCols, 1)
    lnLargura = IIF(par_nOrientacao = 1, 109000, 75000)
    lnBaseDet = ALT_PAGEHEADER + SEPARADOR_BANDA
    lnBasePie = lnBaseDet + ALT_DETAIL + SEPARADOR_BANDA

    lcNome    = JUSTSTEM(par_cDestino)
    lcBaseDbf = "C:\4c\automation\frxtmp\base_" + lcNome + ".dbf"
    lcTmp     = "C:\4c\automation\frxtmp\ord_"  + lcNome + ".dbf"

    *-- Tabela de apoio: o quick report precisa de uma tabela para gerar o
    *-- esqueleto. Um campo por coluna do layout.
    ApagarSeExistir(lcBaseDbf)
    ApagarSeExistir(FORCEEXT(lcBaseDbf, "fpt"))
    lcCampos = ""
    FOR lnI = 1 TO lnCols
        lcCampos = lcCampos + IIF(EMPTY(lcCampos), "", ", ") + "c" + TRANSFORM(lnI) + " C(10)"
    ENDFOR
    CREATE TABLE (lcBaseDbf) (&lcCampos)
    USE IN SELECT(JUSTSTEM(lcBaseDbf))

    ApagarSeExistir(par_cDestino)
    ApagarSeExistir(FORCEEXT(par_cDestino, "frt"))

    *-- Esqueleto VALIDO gerado pelo proprio VFP
    CREATE REPORT (par_cDestino) FROM (lcBaseDbf) COLUMN

    USE (par_cDestino) IN 0 ALIAS frxout EXCLUSIVE
    SELECT frxout

    lnLabel = 0
    lnCampo = 0

    SCAN
        DO CASE
            CASE frxout.objtype = 1 AND frxout.objcode = 53
                REPLACE expr WITH "ORIENTATION=" + TRANSFORM(par_nOrientacao) + ;
                    CHR(13) + CHR(10) + "PAPERSIZE=9" + CHR(13) + CHR(10) + ;
                    "COLOR=2" + CHR(13) + CHR(10)

            CASE frxout.objtype = 9 AND frxout.objcode = 1
                REPLACE height WITH ALT_PAGEHEADER
            CASE frxout.objtype = 9 AND frxout.objcode = 4
                REPLACE height WITH ALT_DETAIL
            CASE frxout.objtype = 9 AND frxout.objcode = 7
                REPLACE height WITH ALT_PAGEFOOTER

            *-- Legendas das colunas
            CASE frxout.objtype = 5
                lnLabel = lnLabel + 1
                IF lnLabel <= lnCols
                    *-- Legenda iniciada por "=" eh EXPRESSAO (rotulo dinamico vindo
                    *   de cursor); qualquer outra eh texto fixo e vai entre aspas.
                    *   Nao da para deduzir pelo conteudo: "Classif." tem ponto e
                    *   NAO eh expressao - deduzir assim gerava Syntax error.
                    IF LEFT(par_aCols[lnLabel, 1], 1) == "="
                        REPLACE expr WITH SUBSTR(par_aCols[lnLabel, 1], 2)
                    ELSE
                        REPLACE expr WITH ["] + par_aCols[lnLabel, 1] + ["]
                    ENDIF
                    *-- objtype 8 (campo), NAO 5 (label): Label em FRX nao avalia
                    *-- expressao - a legenda dinamica sairia LITERAL na pagina.
                    *-- Eh o que o FRX legado da familia faz (SigReCmv usa t=8).
                    REPLACE objtype   WITH 8, ;
                            vpos      WITH ALT_PAGEHEADER - 1500, ;
                            hpos      WITH par_aCols[lnLabel, 3], ;
                            width     WITH par_aCols[lnLabel, 4], ;
                            height    WITH 1354, ;
                            fontface  WITH "Verdana", ;
                            fontsize  WITH 8, ;
                            fontstyle WITH 1
                ELSE
                    DELETE
                ENDIF

            *-- Campos de dados
            CASE frxout.objtype = 8
                lnCampo = lnCampo + 1
                IF lnCampo <= lnCols
                    REPLACE expr      WITH par_aCols[lnCampo, 2], ;
                            vpos      WITH lnBaseDet + 100, ;
                            hpos      WITH par_aCols[lnCampo, 3], ;
                            width     WITH par_aCols[lnCampo, 4], ;
                            height    WITH 1562, ;
                            fontface  WITH "Verdana", ;
                            fontsize  WITH 8, ;
                            fontstyle WITH 0
                ELSE
                    *-- DATE()/_PAGENO que o quick report poe no rodape: refeitos abaixo
                    DELETE
                ENDIF

            *-- DataEnvironment amarrado a tabela de apoio: REMOVER, senao o
            *   REPORT abriria o .dbf em vez de usar o cursor ja selecionado.
            CASE frxout.objtype = 26
                DELETE
        ENDCASE
    ENDSCAN

    *-- MODELO: um objeto de campo ja valido, para CLONAR. Um INSERT manual
    *-- deixa zerados campos internos do FRX (resoid/style/offset/...) e o
    *-- objeto simplesmente NAO eh desenhado - sem erro e sem aviso. Clonar um
    *-- registro que o proprio VFP gerou herda tudo isso.
    GO TOP
    LOCATE FOR frxout.objtype = 8
    IF !FOUND()
        STRTOFILE("  ERRO: nenhum objeto modelo (objtype 8) em " + par_cDestino + ;
            CHR(13) + CHR(10), par_cLog, 1)
        USE IN SELECT("frxout")
        RETURN
    ENDIF
    SCATTER MEMVAR MEMO
    GO BOTTOM

    *-- Cabecalho da pagina
    InsTexto("gc_4c_CabecalhoRelatorio", 300,  0, 45000, "Verdana", 12, 1)
    InsTexto("CsCabecalho.nm_titulo",    2600, 0, 60000, "Verdana",  9, 1)
    InsTexto("CsCabecalho.nm_periodo",   4400, 0, 70000, "Verdana",  8, 0)
    InsTexto("DATE()", 300,  lnLargura - 11000, 11000, "Verdana", 8, 0)
    InsTexto("TIME()", 1900, lnLargura - 11000, 11000, "Verdana", 8, 0)
    InsTexto([TRANSFORM(_PAGENO, '@L 999') + " de " + TRANSFORM(_PAGETOTAL, '@L 999')], ;
             3500, lnLargura - 11000, 11000, "Verdana", 8, 0)
    InsLinha(ALT_PAGEHEADER - 1800, 0, lnLargura)
    InsLinha(ALT_PAGEHEADER - 150,  0, lnLargura)

    *-- Rodape
    InsTexto("go_4c_Sistema.NomeSistema", lnBasePie + 300, 0, 40000, "Verdana", 7, 0)
    InsTexto(["] + lcNome + ["], lnBasePie + 300, lnLargura - 11000, 11000, "Verdana", 7, 0)
    InsLinha(lnBasePie + 150, 0, lnLargura)

    *-- PACK: DELETE apenas MARCA o registro, e o motor le a tabela inteira.
    PACK

    *-- REORDENACAO: objtype 23 (tabela de fontes) e 25 (DataEnvironment) tem de
    *-- ficar por ULTIMO; objeto que caia depois deles nao eh desenhado.
    SELECT frxout
    ApagarSeExistir(lcTmp)
    ApagarSeExistir(FORCEEXT(lcTmp, "fpt"))
    COPY STRUCTURE TO (lcTmp)
    USE IN SELECT("frxout")

    USE (lcTmp) IN 0 ALIAS frxord EXCLUSIVE
    SELECT frxord
    APPEND FROM (par_cDestino) FOR !INLIST(objtype, 23, 25)
    APPEND FROM (par_cDestino) FOR  INLIST(objtype, 23, 25)
    USE IN SELECT("frxord")

    ApagarSeExistir(par_cDestino)
    ApagarSeExistir(FORCEEXT(par_cDestino, "frt"))
    RENAME (lcTmp) TO (par_cDestino)
    RENAME (FORCEEXT(lcTmp, "fpt")) TO (FORCEEXT(par_cDestino, "frt"))

    ApagarSeExistir(lcBaseDbf)
    ApagarSeExistir(FORCEEXT(lcBaseDbf, "fpt"))

    STRTOFILE("  gerado " + par_cDestino + ;
        " colunas=" + TRANSFORM(lnCols) + ;
        " orientacao=" + TRANSFORM(par_nOrientacao) + CHR(13) + CHR(10), par_cLog, 1)
ENDPROC


PROCEDURE ApagarSeExistir(par_cArq)
    IF FILE(par_cArq)
        DELETE FILE (par_cArq)
    ENDIF
ENDPROC

*-- InsTexto: objeto de campo/expressao (objtype 8) no fim de frxout.
*-- CLONA o registro modelo capturado por SCATTER MEMVAR MEMO em GerarUm.
PROCEDURE InsTexto(par_cExpr, par_nVpos, par_nHpos, par_nWidth, par_cFonte, par_nTam, par_nBold)
    SELECT frxout
    APPEND BLANK
    GATHER MEMVAR MEMO
    REPLACE uniqueid  WITH SYS(2015), ;
            objtype   WITH 8, ;
            objcode   WITH 0, ;
            expr      WITH par_cExpr, ;
            vpos      WITH par_nVpos, ;
            hpos      WITH par_nHpos, ;
            height    WITH 1562, ;
            width     WITH par_nWidth, ;
            fontface  WITH par_cFonte, ;
            fontsize  WITH par_nTam, ;
            fontstyle WITH par_nBold
ENDPROC

*-- InsLinha: linha horizontal (objtype 6) no fim de frxout, pelo mesmo clone.
PROCEDURE InsLinha(par_nVpos, par_nHpos, par_nWidth)
    SELECT frxout
    APPEND BLANK
    GATHER MEMVAR MEMO
    REPLACE uniqueid WITH SYS(2015), ;
            objtype  WITH 6, ;
            objcode  WITH 0, ;
            expr     WITH "", ;
            vpos     WITH par_nVpos, ;
            hpos     WITH par_nHpos, ;
            height   WITH 0, ;
            width    WITH par_nWidth, ;
            pensize  WITH 1
ENDPROC
