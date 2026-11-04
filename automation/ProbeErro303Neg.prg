SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gcLN
gb_4c_ModoTeste = .T.
gnConnHandle = 0
gc_4c_UsuarioLogado = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_neg.txt"
gcLN = "C:\4c\automation\probe_erro303_neg.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLN)
LOCAL loc_oE, lnI
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "orlBO.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "CsiBO.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\Formorl.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "cadastros\FormCsi.prg") ADDITIVE
    LogN("B: deps carregadas")
    Detalhar("Formorl")
    Detalhar("FormCsi")
CATCH TO loc_oE
    LogN("EXCEPTION: " + loc_oE.Message)
ENDTRY
STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcLN, 1)
QUIT

PROCEDURE LogN(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcLN, 1)
ENDPROC

PROCEDURE Detalhar(par_cForm)
    LOCAL loF, loPg, lnOff, lnI, lnJ, loC, loB, loc_oErr
    TRY
        loF = CREATEOBJECT(par_cForm)
        IF VARTYPE(loF) # "O"
            LogN(par_cForm + ": nao instanciou")
            RETURN
        ENDIF
        lnOff = loF.pgf_4c_Paginas.Top
        loPg  = loF.pgf_4c_Paginas.Page1
        LogN("")
        LogN("=== " + par_cForm + " Page1 (PageFrame.Top=" + TRANSFORM(lnOff) + ")")
        FOR lnI = 1 TO loPg.ControlCount
            loC = loPg.Controls(lnI)
            IF UPPER(loC.BaseClass) # "CONTAINER"
                LOOP
            ENDIF
            LogN("   container " + PADR(ALLTRIM(loC.Name), 22) + ;
                 " Top=" + PADL(TRANSFORM(loC.Top), 5) + ;
                 " H=" + PADL(TRANSFORM(loC.Height), 4) + ;
                 " tela " + TRANSFORM(loC.Top + lnOff) + ".." + ;
                 TRANSFORM(loC.Top + loC.Height + lnOff) + ;
                 "  BackColor=" + TRANSFORM(loC.BackColor))
            FOR lnJ = 1 TO loC.ControlCount
                loB = loC.Controls(lnJ)
                IF UPPER(loB.BaseClass) == "COMMANDBUTTON"
                    LogN("        btn " + PADR(ALLTRIM(loB.Name), 20) + ;
                         " Top=" + PADL(TRANSFORM(loB.Top), 4) + ;
                         " H=" + PADL(TRANSFORM(loB.Height), 4) + ;
                         " tela " + TRANSFORM(loC.Top + loB.Top + lnOff) + ".." + ;
                         TRANSFORM(loC.Top + loB.Top + loB.Height + lnOff))
                ENDIF
            ENDFOR
        ENDFOR
        loF.Release()
    CATCH TO loc_oErr
        LogN(par_cForm + " ERRO: " + loc_oErr.Message)
    ENDTRY
ENDPROC
