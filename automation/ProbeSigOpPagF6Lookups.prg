* ProbeSigOpPagF6Lookups.prg
* Instancia Formsigoppag (task782, Fase 6) headless e PROVA o funil de
* lookups refatorado: escopo PUBLIC dos metodos e os BINDEVENT ligados.
SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\automation\_probe782f6lk.txt"

STRTOFILE("[1] inicio" + CHR(13) + CHR(10), OUTFILE)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe782f6lk_dialogs.txt"

DO (ADDBS("C:\4c\projeto\app\start") + "config.prg")

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoppagBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoppag.prg") ADDITIVE
STRTOFILE("[2] SET PROCEDURE ok" + CHR(13) + CHR(10), OUTFILE, 1)

LOCAL loc_oForm, loc_oErro, loc_cMsg, loc_nI, loc_nJ, loc_nQtd
LOCAL ARRAY loc_aMet[8], loc_aEv[10]
loc_cMsg = ""

*-- Metodos que TEM de existir e ser PUBLIC (BINDEVENT so dispara PUBLIC)
loc_aMet[1] = "ValidarModfpgLostFocus"
loc_aMet[2] = "ValidarModfpgCorpo"
loc_aMet[3] = "ModfpgKeyPress"
loc_aMet[4] = "ModfpgDblClick"
loc_aMet[5] = "AbrirBuscaMoeda"
loc_aMet[6] = "ValidarFpgLostFocus"
loc_aMet[7] = "FpgKeyPress"
loc_aMet[8] = "AbrirBuscaFormaPagamento"

TRY
    loc_oForm = CREATEOBJECT("Formsigoppag")

    IF VARTYPE(loc_oForm) = "O"
        loc_cMsg = loc_cMsg + "[3] FORM INSTANCIADO: Caption=[" + loc_oForm.Caption + "]" + ;
            " Width=" + TRANSFORM(loc_oForm.Width) + " Height=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10)

        *-- (a) existencia + escopo dos metodos do funil
        FOR loc_nI = 1 TO ALEN(loc_aMet)
            loc_cMsg = loc_cMsg + "    METODO " + PADR(loc_aMet[loc_nI], 26) + ;
                " EXISTE=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5)) + ;
                " PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 2)) + CHR(13) + CHR(10)
        ENDFOR

        *-- (b) helper que DEVE ser PROTECTED (so uso interno)
        loc_cMsg = loc_cMsg + "    HELPER CarregarFormasPagamento EXISTE=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, "CarregarFormasPagamento", 5)) + ;
            " PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarFormasPagamento", 2)) + CHR(13) + CHR(10)

        *-- (c) BINDEVENT ligados - AEVENTS com DOIS argumentos, evento na coluna 3
        LOCAL ARRAY loc_aBind[1]
        loc_nQtd = AEVENTS(loc_aBind, loc_oForm.txt_4c_Modfpg)
        loc_cMsg = loc_cMsg + "    AEVENTS txt_4c_Modfpg = " + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nJ = 1 TO loc_nQtd
            loc_cMsg = loc_cMsg + "        " + UPPER(loc_aBind[loc_nJ, 3]) + " -> " + ;
                UPPER(loc_aBind[loc_nJ, 4]) + CHR(13) + CHR(10)
        ENDFOR

        loc_nQtd = AEVENTS(loc_aBind, loc_oForm.txt_4c_Fpg)
        loc_cMsg = loc_cMsg + "    AEVENTS txt_4c_Fpg = " + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nJ = 1 TO loc_nQtd
            loc_cMsg = loc_cMsg + "        " + UPPER(loc_aBind[loc_nJ, 3]) + " -> " + ;
                UPPER(loc_aBind[loc_nJ, 4]) + CHR(13) + CHR(10)
        ENDFOR

        *-- (d) guarda de reentrancia comeca LIMPA
        loc_cMsg = loc_cMsg + "    FLAGS Modfpg=" + TRANSFORM(loc_oForm.this_lEmLookupModfpg) + ;
            " Fpg=" + TRANSFORM(loc_oForm.this_lEmLookupFpg) + CHR(13) + CHR(10)

        *-- (e) KeyPress com tecla NAO-lookup tem de ser no-op (regra #47)
        loc_oForm.txt_4c_Modfpg.Value = "X"
        loc_oForm.ModfpgKeyPress(65, 0)
        loc_oForm.FpgKeyPress(65, 0)
        loc_cMsg = loc_cMsg + "    KEYPRESS 'A' no-op OK; flags Modfpg=" + ;
            TRANSFORM(loc_oForm.this_lEmLookupModfpg) + " Fpg=" + ;
            TRANSFORM(loc_oForm.this_lEmLookupFpg) + CHR(13) + CHR(10)

        *-- (f) corpo com conexao invalida (gnConnHandle = 0) tem de sair sem
        *--     abrir picker nenhum, e DEIXAR A FLAG LIMPA no fim
        loc_oForm.ValidarModfpgLostFocus()
        loc_oForm.txt_4c_Fpg.Value = "DINHEIRO"
        loc_oForm.ValidarFpgLostFocus()
        loc_cMsg = loc_cMsg + "    LOSTFOCUS sem conexao OK; flags Modfpg=" + ;
            TRANSFORM(loc_oForm.this_lEmLookupModfpg) + " Fpg=" + ;
            TRANSFORM(loc_oForm.this_lEmLookupFpg) + CHR(13) + CHR(10)
        loc_cMsg = loc_cMsg + "    VALOR PRESERVADO Modfpg=[" + ALLTRIM(loc_oForm.txt_4c_Modfpg.Value) + ;
            "] Fpg=[" + ALLTRIM(loc_oForm.txt_4c_Fpg.Value) + "]" + CHR(13) + CHR(10)

        *-- (g) reentrancia: flag ligada faz o wrapper devolver sem agir
        loc_oForm.this_lEmLookupModfpg = .T.
        loc_oForm.ValidarModfpgLostFocus()
        loc_cMsg = loc_cMsg + "    REENTRANCIA guard OK; flag segue=" + ;
            TRANSFORM(loc_oForm.this_lEmLookupModfpg) + CHR(13) + CHR(10)
        loc_oForm.this_lEmLookupModfpg = .F.

        loc_oForm.Release()
        loc_cMsg = loc_cMsg + "[4] RELEASE OK" + CHR(13) + CHR(10)
    ELSE
        loc_cMsg = loc_cMsg + "[3] FALHA: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cMsg = loc_cMsg + "[X] ERRO: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cMsg, OUTFILE, 1)
QUIT
