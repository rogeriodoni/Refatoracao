*==============================================================================
* ValidarCargaTelas.prg - valida a carga sob demanda tela a tela
*
* Para cada classe de lista_forms_menu.txt (os CREATEOBJECT do menu.prg),
* a partir da posicao par_nInicio: GarantirClasse + CREATEOBJECT, grava a
* arvore de objetos e os erros, Release. Roda nos dois modos:
*   "sobdemanda" -> ConfigurarAmbiente()
*   "completo"   -> ConfigurarAmbiente(.T.)   (carga antiga, ~170 s)
* Chamado por ValidarCargaTelas.ps1, que reinicia o VFP se uma tela travar.
*==============================================================================
PROCEDURE ValidarCargaTelas(par_cModo, par_nInicio)
    LOCAL loc_nT, loc_nH, loc_nN, loc_nI, loc_cClasse, loc_oForm, loc_oErro, loc_cDir
    LOCAL ARRAY loc_aForms[1]
    PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gcLogVal, gcErrVal
    loc_cDir = "C:\4c\refatoracao\automation\validacao_carga\"
    gcLogVal = loc_cDir + "log_" + par_cModo + ".txt"
    gcErrVal = ""
    gc_4c_ArquivoErroTeste = loc_cDir + "msgerro_" + par_cModo + ".tmp"
    gb_4c_ModoTeste = .T.
    ON ERROR gcErrVal = gcErrVal + "[ON ERROR " + TRANSFORM(ERROR()) + " " + MESSAGE() + " @" + PROGRAM() + ":" + TRANSFORM(LINENO()) + "]"

    CD C:\4c\refatoracao\projeto\app\start
    loc_nT = SECONDS()
    DO config.prg
    SET PROCEDURE TO (ADDBS(gc_4c_CaminhoBase) + "config.prg") ADDITIVE
    SET PROCEDURE TO (ADDBS(gc_4c_CaminhoBase) + "main.prg") ADDITIVE
    ConfigurarAmbiente(par_cModo == "completo")
    ConfigurarSETs()
    LogVal("AMBIENTE " + TRANSFORM(SECONDS() - loc_nT, "999.999") + " s, sob demanda=" + TRANSFORM(gl_4c_CargaSobDemanda) + ", inicio=" + TRANSFORM(par_nInicio))

    loc_nH = SQLSTRINGCONNECT(ObterStringConexao())
    IF loc_nH > 0
        SQLDISCONNECT(loc_nH)
        ConectarBancoDados()
    ELSE
        PUBLIC gnConnHandle, gb_4c_ValidandoUI
        gnConnHandle = 0
        gb_4c_ValidandoUI = .T.
        LogVal("SEM BANCO")
    ENDIF
    gcErrVal = ""

    loc_nN = ALINES(loc_aForms, FILETOSTR(loc_cDir + "lista_forms_menu.txt"), 1)
    FOR loc_nI = par_nInicio TO loc_nN
        loc_cClasse = loc_aForms[loc_nI]
        LogVal("INICIO|" + TRANSFORM(loc_nI) + "|" + loc_cClasse)
        gcErrVal = ""
        IF FILE(gc_4c_ArquivoErroTeste)
            DELETE FILE (gc_4c_ArquivoErroTeste)
        ENDIF
        loc_oForm = .NULL.
        loc_nT = SECONDS()
        TRY
            GarantirClasse(loc_cClasse)
            loc_oForm = CREATEOBJECT(loc_cClasse)
        CATCH TO loc_oErro
            gcErrVal = gcErrVal + "[CATCH " + TRANSFORM(loc_oErro.ErrorNo) + " " + loc_oErro.Message + "]"
        ENDTRY
        loc_nT = SECONDS() - loc_nT
        IF FILE(gc_4c_ArquivoErroTeste)
            gcErrVal = gcErrVal + "[MSG " + CHRTRAN(FILETOSTR(gc_4c_ArquivoErroTeste), CHR(13) + CHR(10) + "|", "   ") + "]"
        ENDIF
        STRTOFILE("#" + loc_cClasse + CHR(13) + CHR(10), loc_cDir + "arvore_" + par_cModo + ".txt", 1)
        IF VARTYPE(loc_oForm) = "O"
            TRY
                DumpArvoreVal(loc_oForm, loc_cClasse, loc_cDir + "arvore_" + par_cModo + ".txt")
            CATCH TO loc_oErro
                gcErrVal = gcErrVal + "[DUMP " + loc_oErro.Message + "]"
            ENDTRY
        ENDIF
        LogVal("FIM|" + TRANSFORM(loc_nI) + "|" + loc_cClasse + "|" + VARTYPE(loc_oForm) + "|" + ;
               TRANSFORM(loc_nT, "99.999") + "|" + CHRTRAN(gcErrVal, CHR(13) + CHR(10), "  "))
        IF VARTYPE(loc_oForm) = "O"
            TRY
                loc_oForm.Release()
            CATCH
            ENDTRY
        ENDIF
        loc_oForm = .NULL.
        CLEAR TYPEAHEAD
    ENDFOR
    LogVal("CONCLUIDO|arquivos no SET PROCEDURE=" + TRANSFORM(OCCURS(",", SET("PROCEDURE")) + 1))
ENDPROC

PROCEDURE LogVal(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcLogVal, 1)
ENDPROC

PROCEDURE DumpArvoreVal(par_oObj, par_cCaminho, par_cArquivo)
    LOCAL loc_nN, loc_nI, loc_oFilho, loc_cLinha
    LOCAL ARRAY loc_aM[1]
    loc_cLinha = par_cCaminho + "|" + par_oObj.Class
    IF PEMSTATUS(par_oObj, "Left", 5)
        loc_cLinha = loc_cLinha + "|" + TRANSFORM(par_oObj.Left) + "|" + TRANSFORM(par_oObj.Top) + ;
                     "|" + TRANSFORM(par_oObj.Width) + "|" + TRANSFORM(par_oObj.Height)
    ENDIF
    IF PEMSTATUS(par_oObj, "Visible", 5)
        loc_cLinha = loc_cLinha + "|" + TRANSFORM(par_oObj.Visible)
    ENDIF
    STRTOFILE(loc_cLinha + CHR(13) + CHR(10), par_cArquivo, 1)
    loc_nN = AMEMBERS(loc_aM, par_oObj, 2)
    IF loc_nN > 0
        ASORT(loc_aM)
    ENDIF
    FOR loc_nI = 1 TO loc_nN
        loc_oFilho = EVALUATE("par_oObj." + loc_aM[loc_nI])
        IF VARTYPE(loc_oFilho) = "O"
            DumpArvoreVal(loc_oFilho, par_cCaminho + "." + loc_aM[loc_nI], par_cArquivo)
        ENDIF
    ENDFOR
ENDPROC
