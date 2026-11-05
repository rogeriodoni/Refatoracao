*==============================================================================
* ProbeSweep.prg - Erro312
* Instancia cada form corrigido e le o BackStyle REAL de cnt_4c_Botoes.
* Grava incrementalmente: se algum form pendurar, o que ja passou fica provado.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE OUT "C:\4c\automation\erro312\sweep_runtime.txt"

LOCAL loc_cLista, loc_nI, loc_cForm, loForm, loc_oErr, loc_cLinha, loc_oCnt
LOCAL ARRAY loc_aForms[1]

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\erro312\sweep_erro.txt"

STRTOFILE("=== Erro312 - BackStyle real de cnt_4c_Boteos apos a correcao ===" + CHR(13) + CHR(10), OUT)

CD "C:\4c\projeto\app\start"
DO config.prg
ConfigurarAmbiente()
STRTOFILE("ambiente carregado" + CHR(13) + CHR(10), OUT, 1)

loc_cLista = FILETOSTR("C:\4c\automation\erro312\lista_forms.txt")
LOCAL loc_nQtd
loc_nQtd = ALINES(loc_aForms, loc_cLista)

LOCAL loc_nOk, loc_nFalha, loc_nNaoInst
loc_nOk      = 0
loc_nFalha   = 0
loc_nNaoInst = 0

FOR loc_nI = 1 TO loc_nQtd
    loc_cForm = ALLTRIM(loc_aForms[loc_nI])
    IF EMPTY(loc_cForm)
        LOOP
    ENDIF

    loForm = .NULL.
    TRY
        GarantirClasse(loc_cForm)
        loForm = CREATEOBJECT(loc_cForm)
    CATCH TO loc_oErr
        loForm = .NULL.
        STRTOFILE(PADR(loc_cForm, 24) + "NAO INSTANCIOU: " + loc_oErr.Message + ;
                  CHR(13) + CHR(10), OUT, 1)
        loc_nNaoInst = loc_nNaoInst + 1
    ENDTRY

    IF VARTYPE(loForm) = "O"
        loc_cLinha = PADR(loc_cForm, 24)
        loc_oCnt = .NULL.
        TRY
            IF PEMSTATUS(loForm, "pgf_4c_Paginas", 5)
                IF PEMSTATUS(loForm.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
                    loc_oCnt = loForm.pgf_4c_Paginas.Page1.cnt_4c_Botoes
                ENDIF
            ENDIF
        CATCH TO loc_oErr
            loc_oCnt = .NULL.
        ENDTRY

        IF VARTYPE(loc_oCnt) = "O"
            loc_cLinha = loc_cLinha + "BackStyle=" + TRANSFORM(loc_oCnt.BackStyle)
            IF loc_oCnt.BackStyle = 0
                loc_cLinha = loc_cLinha + "  OK"
                loc_nOk = loc_nOk + 1
            ELSE
                loc_cLinha = loc_cLinha + "  *** AINDA OPACO ***"
                loc_nFalha = loc_nFalha + 1
            ENDIF
        ELSE
            loc_cLinha = loc_cLinha + "cnt_4c_Botoes nao encontrado na Page1"
        ENDIF
        STRTOFILE(loc_cLinha + CHR(13) + CHR(10), OUT, 1)
        loForm.Release()
    ENDIF
    loForm = .NULL.
ENDFOR

STRTOFILE(CHR(13) + CHR(10) + "TOTAL ok=" + TRANSFORM(loc_nOk) + ;
          " aindaOpaco=" + TRANSFORM(loc_nFalha) + ;
          " naoInstanciou=" + TRANSFORM(loc_nNaoInst) + CHR(13) + CHR(10), OUT, 1)
QUIT
