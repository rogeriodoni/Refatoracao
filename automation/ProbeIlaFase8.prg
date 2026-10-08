SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ilaf8.txt"
#DEFINE OUT "C:\4c\automation\probe_ilaf8.txt"

LOCAL loc_oE, loc_oBO, loc_cL, loc_nI, loc_cM, loc_lAll
LOCAL ARRAY loc_aM[7]

STRTOFILE("=== PROBE sigprilaBO Fase 8 ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "fwprogressbar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprilaBO.prg")   ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeIlaFase8.prg"    ADDITIVE

    gnConnHandle = -1

    *-- ============================================= 1) instanciar
    loc_oBO = CREATEOBJECT("ProbeIlaBO")
    STRTOFILE("1) CREATEOBJECT ProbeIlaBO -> VARTYPE=" + VARTYPE(loc_oBO) + CHR(13) + CHR(10), OUT, 1)

    *-- ============================================= 2) as 7 rotinas existem?
    loc_aM[1] = "ImportarListaPreco"
    loc_aM[2] = "ImportarTransferencia"
    loc_aM[3] = "ImportarPrecificacao"
    loc_aM[4] = "ImportarPedidoTerceiro"
    loc_aM[5] = "ImportarPedidoConsignado"
    loc_aM[6] = "ImportarPedidoFabrica"
    loc_aM[7] = "ImportarPedidoAcessorio"

    loc_cL = "2) rotinas de importacao (o que ValidaCols do Form checa):" + CHR(13) + CHR(10)
    loc_lAll = .T.
    FOR loc_nI = 1 TO 7
        loc_cM = loc_aM[loc_nI]
        loc_cL = loc_cL + "   " + PADR(loc_cM, 26) + ;
                 " PEMSTATUS=" + TRANSFORM(PEMSTATUS(loc_oBO, loc_cM, 5))
        *-- PEMSTATUS devolve .T. ate para PROTECTED: a prova de que da para
        *-- chamar de FORA eh CHAMAR. Sem TmpPlanilha cada rotina sai cedo
        *-- com .F., entao a chamada eh inofensiva.
        TRY
            loc_cL = loc_cL + " CHAMADA_EXTERNA=OK retorno=" + ;
                     TRANSFORM(EVALUATE("loc_oBO." + loc_cM + "()"))
        CATCH TO loc_oE
            loc_cL = loc_cL + " CHAMADA_EXTERNA=FALHOU (" + loc_oE.Message + ")"
            loc_lAll = .F.
        ENDTRY
        loc_cL = loc_cL + CHR(13) + CHR(10)
    ENDFOR
    loc_cL = loc_cL + "   TODAS CHAMAVEIS DE FORA: " + TRANSFORM(loc_lAll) + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- ============================================= 3) chaves POSICIONAIS
    loc_cL = "3) chaves posicionais (regra #42 - largura do destino):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   EmpDopNums  LEN=" + ;
             TRANSFORM(LEN(loc_oBO.TesteChaveEmpDopNum("1", "MALOTE", 3))) + ;
             " (esperado 29) valor=[" + loc_oBO.TesteChaveEmpDopNum("1", "MALOTE", 3) + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   EmpGruEsts  LEN=" + ;
             TRANSFORM(LEN(loc_oBO.TesteChaveEmpGruEst("1", "GRP", "CTA"))) + ;
             " (esperado 23)" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- ============================================= 4) helpers puros
    loc_cL = "4) helpers puros:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ValorNumerico(12.5)      = " + TRANSFORM(loc_oBO.TesteValorNumerico(12.5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ValorNumerico('12,50')   = " + TRANSFORM(loc_oBO.TesteValorNumerico("12,50")) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ValorNumerico('1.234,56')= " + TRANSFORM(loc_oBO.TesteValorNumerico("1.234,56")) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ValorNumerico('99.90')   = " + TRANSFORM(loc_oBO.TesteValorNumerico("99.90")) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ValorNumerico(.NULL.)    = " + TRANSFORM(loc_oBO.TesteValorNumerico(.NULL.)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ColunaMes 03 (campo)     =[" + loc_oBO.TesteColunaMes("03", .F.) + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ColunaMes 03 (acumulado) =[" + loc_oBO.TesteColunaMes("03", .T.) + "]" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   ColunaMes 13 (invalido)  =[" + loc_oBO.TesteColunaMes("13", .F.) + "]" + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- ============================================= 5) cursores de acumulacao
    loc_oBO.TesteCriarCursores()
    loc_cL = "5) cursores de acumulacao criados:" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cursor_4c_MvCab  = " + TRANSFORM(USED("cursor_4c_MvCab")) + ;
             " campos=" + TRANSFORM(IIF(USED("cursor_4c_MvCab"), FCOUNT("cursor_4c_MvCab"), 0)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cursor_4c_MvItn  = " + TRANSFORM(USED("cursor_4c_MvItn")) + ;
             " campos=" + TRANSFORM(IIF(USED("cursor_4c_MvItn"), FCOUNT("cursor_4c_MvItn"), 0)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cursor_4c_MvIts  = " + TRANSFORM(USED("cursor_4c_MvIts")) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cursor_4c_MvHst  = " + TRANSFORM(USED("cursor_4c_MvHst")) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   cursor_4c_TmpCot = " + TRANSFORM(USED("cursor_4c_TmpCot")) + CHR(13) + CHR(10)
    STRTOFILE(loc_cL, OUT, 1)

    *-- ============================================= 6) PARIDADE COLUNA/VALOR
    *-- Este eh o teste critico: as listas de colunas dos INSERT de
    *-- MontarLoteMovimento foram escritas a mao (SigMvCab tem 117 colunas).
    *-- Uma coluna a mais ou a menos que os VALUES = INSERT recusado.
    loc_oBO.TesteSemearMovimento()
    loc_cL = loc_oBO.TesteParidadeLote()
    STRTOFILE(loc_cL, OUT, 1)

    STRTOFILE("7) AtualizarValorCabecalho (soma dos itens no cabecalho):" + CHR(13) + CHR(10) + ;
              "   " + loc_oBO.TesteValosCabecalho() + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE(loc_oBO.TesteDumpLote(), "C:\4c\automation\probe_ilaf8_lote.sql")

    STRTOFILE("=== FIM OK ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10) + ;
              "  Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
              "  Proc : " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT


*==============================================================================
* ProbeIlaBO - subclasse so para o probe: expoe os metodos PROTECTED do
* sigprilaBO (que de fora nao sao alcancaveis) e semeia linhas sinteticas nos
* cursores de acumulacao.
*==============================================================================
DEFINE CLASS ProbeIlaBO AS sigprilaBO

    FUNCTION TesteChaveEmpDopNum(p1, p2, p3)
        RETURN THIS.MontarChaveEmpDopNum(p1, p2, p3)
    ENDFUNC

    FUNCTION TesteChaveEmpGruEst(p1, p2, p3)
        RETURN THIS.MontarChaveEmpGruEst(p1, p2, p3)
    ENDFUNC

    FUNCTION TesteValorNumerico(p1)
        RETURN THIS.ValorNumerico(p1)
    ENDFUNC

    FUNCTION TesteColunaMes(p1, p2)
        RETURN THIS.ObterColunaMesOrcamento(p1, p2)
    ENDFUNC

    PROCEDURE TesteCriarCursores()
        THIS.CriarCursoresMovimento()
    ENDPROC

    *-- Semeia 1 linha em cada cursor de acumulacao, para MontarLoteMovimento
    *-- gerar os quatro INSERT
    PROCEDURE TesteSemearMovimento()
        LOCAL loc_cChave
        THIS.this_tDataMovimento = DATETIME()
        THIS.this_dDataMovimento = DATE()
        THIS.this_cSigKey        = "ABC"
        loc_cChave = THIS.MontarChaveEmpDopNum("001", "MALOTE", 7)

        INSERT INTO cursor_4c_MvCab ;
            (Datars, Datas, Dopes, Emps, EmpDs, Numes, MascNum, GrupoOs, ContaOs, ;
             GrupoDs, ContaDs, CidChaves, DtAlts, EmpDopNums, Usuals, Usuars, ;
             PrazoEnts, GrupoCCs, ContaCCs, Valos) ;
            VALUES (DATETIME(), DATETIME(), "MALOTE", "001", "002", 7, "0000007", ;
                    "GRO", "CTO", "GRD", "CTD", "CID001", DATETIME(), loc_cChave, ;
                    "TESTE", "TESTE", DATE(), "GCC", "CCC", 123.45)

        INSERT INTO cursor_4c_MvItn ;
            (CPros, Dopes, Emps, Numes, Opers, Qtds, CItens, Units, Totas, Moedas, ;
             DPros, AQtds, CUnis, CidChaves, DtAlts, EmpDopNums, Pesos, CodBarras) ;
            VALUES ("PRO1", "MALOTE", "001", 7, "S", 2, 1, 10.5, 21, "BRL", ;
                    "PRODUTO UM", 2, "UN", "CID002", DATE(), loc_cChave, 1.25, 0)

        INSERT INTO cursor_4c_MvIts ;
            (Emps, Dopes, Numes, CPros, CodTams, CodCors, Qtds, AQtds, CodBarras, ;
             Pesos, CidChaves, EmpDopNums, ChkSubn, CItens) ;
            VALUES ("001", "MALOTE", 7, "PRO1", "M", "AZ", 2, 2, 0, 1.25, ;
                    "CID003", loc_cChave, .F., 1)

        INSERT INTO cursor_4c_MvHst ;
            (CPros, Datars, Datas, Dopes, EmpOs, Emps, Opers, Numes, Qtds, Units, ;
             Totas, Grupos, Estos, CidChaves, EmpDopNums, EmpGruEsts, OriDopNums, ;
             Seqs, Pesos, Usuars, CodBarras, CodTams, CodCors) ;
            VALUES ("PRO1", DATETIME(), DATETIME(), "MALOTE", "001", "001", "S", 7, ;
                    2, 10.5, 21, "GRO", "CTO", "CID004", loc_cChave, ;
                    THIS.MontarChaveEmpGruEst("001", "GRO", "CTO"), loc_cChave, ;
                    1, 1.25, "TESTE", 0, "M", "AZ")
    ENDPROC

    *-- Gera o lote e confere, em cada INSERT, se o numero de COLUNAS bate com
    *-- o numero de VALORES. Conta por virgula no nivel ZERO de parenteses,
    *-- ignorando virgula dentro de string.
    FUNCTION TesteParidadeLote()
        LOCAL loc_cLote, loc_cL, loc_nI, loc_cCmd, loc_nC, loc_nV, loc_cTab
        LOCAL loc_nPos, loc_cCols, loc_cVals, loc_lTudoOk
        LOCAL ARRAY loc_aCmd[1]

        loc_cLote = THIS.MontarLoteMovimento()
        loc_cL = "6) PARIDADE COLUNA/VALOR nos INSERT de MontarLoteMovimento:" + CHR(13) + CHR(10)
        loc_cL = loc_cL + "   tamanho do lote = " + TRANSFORM(LEN(loc_cLote)) + " bytes" + CHR(13) + CHR(10)

        loc_lTudoOk = .T.
        FOR loc_nI = 1 TO ALINES(loc_aCmd, loc_cLote, 1, ";")
            loc_cCmd = ALLTRIM(CHRTRAN(loc_aCmd[loc_nI], CHR(13) + CHR(10), "  "))
            IF !("INSERT INTO" $ UPPER(loc_cCmd))
                LOOP
            ENDIF

            loc_cTab = ALLTRIM(STREXTRACT(UPPER(loc_cCmd), "INSERT INTO ", " ("))
            loc_cCols = STREXTRACT(loc_cCmd, "(", ") VALUES (", 1, 0)
            loc_nPos  = AT(") VALUES (", loc_cCmd)
            loc_cVals = SUBSTR(loc_cCmd, loc_nPos + 10)
            loc_cVals = LEFT(loc_cVals, RAT(")", loc_cVals) - 1)

            loc_nC = THIS.ContarItens(loc_cCols)
            loc_nV = THIS.ContarItens(loc_cVals)

            loc_cL = loc_cL + "   " + PADR(loc_cTab, 10) + " colunas=" + PADL(TRANSFORM(loc_nC), 3) + ;
                     " valores=" + PADL(TRANSFORM(loc_nV), 3) + ;
                     IIF(loc_nC = loc_nV, "  OK", "  *** DIVERGENTE ***") + CHR(13) + CHR(10)

            IF loc_nC <> loc_nV
                loc_lTudoOk = .F.
            ENDIF
        ENDFOR

        loc_cL = loc_cL + "   PARIDADE GERAL: " + IIF(loc_lTudoOk, "OK", "FALHOU") + CHR(13) + CHR(10)

        RETURN loc_cL
    ENDFUNC

    *-- Conta itens separados por virgula no nivel 0 de parenteses, ignorando
    *-- virgula dentro de string entre apostrofos
    FUNCTION TesteValosCabecalho()
        LOCAL loc_c, loc_nAntes
        SELECT cursor_4c_MvCab
        GO TOP
        loc_nAntes = cursor_4c_MvCab.Valos
        *-- 2o item no mesmo cabecalho, para a soma ter o que somar
        INSERT INTO cursor_4c_MvItn ;
            (CPros, Dopes, Emps, Numes, Opers, Qtds, CItens, Units, Totas, Moedas, ;
             DPros, AQtds, CUnis, CidChaves, DtAlts, EmpDopNums, Pesos, CodBarras) ;
            VALUES ("PRO2", "MALOTE", "001", 7, "S", 3, 2, 5, 15, "BRL", ;
                    "PRODUTO DOIS", 3, "UN", "CID009", DATE(), ;
                    THIS.MontarChaveEmpDopNum("001", "MALOTE", 7), 1, 0)
        THIS.AtualizarValorCabecalho()
        SELECT cursor_4c_MvCab
        GO TOP
        loc_c = "Valos antes=" + TRANSFORM(loc_nAntes) + ;
                " itens=21+15=36 -> Valos depois=" + TRANSFORM(cursor_4c_MvCab.Valos) + ;
                IIF(cursor_4c_MvCab.Valos = 36, "  OK", "  *** DIVERGENTE ***")
        RETURN loc_c
    ENDFUNC

    FUNCTION TesteDumpLote()
        RETURN THIS.MontarLoteMovimento()
    ENDFUNC

    FUNCTION ContarItens(par_cTexto)
        LOCAL loc_nI, loc_nNivel, loc_lStr, loc_nQtd, loc_cCh

        loc_nNivel = 0
        loc_lStr   = .F.
        loc_nQtd   = 1

        FOR loc_nI = 1 TO LEN(par_cTexto)
            loc_cCh = SUBSTR(par_cTexto, loc_nI, 1)
            DO CASE
                CASE loc_cCh == "'"
                    loc_lStr = !loc_lStr
                CASE loc_lStr
                    *-- dentro de string: ignora
                CASE loc_cCh == "("
                    loc_nNivel = loc_nNivel + 1
                CASE loc_cCh == ")"
                    loc_nNivel = loc_nNivel - 1
                CASE loc_cCh == "," AND loc_nNivel = 0
                    loc_nQtd = loc_nQtd + 1
            ENDCASE
        ENDFOR

        RETURN IIF(EMPTY(ALLTRIM(par_cTexto)), 0, loc_nQtd)
    ENDFUNC

ENDDEFINE
