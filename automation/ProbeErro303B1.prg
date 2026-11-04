*==============================================================================
* ProbeErro303B1.prg - Erro303 sub-grupo B1: a faixa da pagina Lista esta em
* Top=2 (tela -27..53) e os containers de botao em 29 (corretos). Antes de
* mover a faixa para 31, medir o MENOR Top de controle de dados da Page1: com
* a faixa em 31..111, qualquer controle com Top < 111 seria SOTERRADO (#11).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gcLB1
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_b1.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

gcLB1 = "C:\4c\automation\probe_erro303_b1.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLB1)

LOCAL loc_oE, loc_nI

DIMENSION laF[5, 2]
laF[1,1] = "FormCsi"  && laF[n,2] = BO
laF[1,2] = "CsiBO"
laF[2,1] = "FormCVI"
laF[2,2] = "CVIBO"
laF[3,1] = "FormFTF"
laF[3,2] = "FTFBO"
laF[4,1] = "FormGpe"
laF[4,2] = "GpeBO"
laF[5,1] = "Formorl"
laF[5,2] = "orlBO"

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
    FOR loc_nI = 1 TO 5
        SET PROCEDURE TO (gcCaminhoClasses + ALLTRIM(laF[loc_nI,2]) + ".prg") ADDITIVE
        SET PROCEDURE TO (gcCaminhoForms + "cadastros\" + ALLTRIM(laF[loc_nI,1]) + ".prg") ADDITIVE
    ENDFOR
    LogB1("B: deps carregadas")

    FOR loc_nI = 1 TO 5
        MedirForm(ALLTRIM(laF[loc_nI,1]))
    ENDFOR

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " | Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), gcLB1, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcLB1, 1)
QUIT

PROCEDURE LogB1(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcLB1, 1)
ENDPROC

PROCEDURE MedirForm(par_cForm)
    LOCAL loF, loPg, lnI, loC, lnMin, lcMin, lnOff, loc_oErr
    TRY
        loF = CREATEOBJECT(par_cForm)
        IF VARTYPE(loF) # "O"
            LogB1("   " + PADR(par_cForm, 10) + " CREATEOBJECT FALHOU")
            RETURN
        ENDIF
        lnOff = loF.pgf_4c_Paginas.Top
        loPg  = loF.pgf_4c_Paginas.Page1
        lnMin = 99999
        lcMin = "(nenhum)"
        FOR lnI = 1 TO loPg.ControlCount
            loC = loPg.Controls(lnI)
            IF UPPER(loC.BaseClass) $ "TEXTBOXLABELCHECKBOXGRIDEDITBOXCOMBOBOXSPINNEROPTIONGROUP"
                IF loC.Top < lnMin
                    lnMin = loC.Top
                    lcMin = ALLTRIM(loC.Name) + "(" + ALLTRIM(loC.BaseClass) + ")"
                ENDIF
            ENDIF
        ENDFOR
        LogB1("   " + PADR(par_cForm, 10) + ;
              " faixa " + Fx(loPg) + ;
              " | 1o dado Top=" + PADL(TRANSFORM(lnMin), 4) + " " + PADR(lcMin, 28) + ;
              " | com faixa 31..111 soterra? " + TRANSFORM(lnMin < 111))
        loF.Release()
    CATCH TO loc_oErr
        LogB1("   " + PADR(par_cForm, 10) + " ERRO: " + loc_oErr.Message)
    ENDTRY
ENDPROC

FUNCTION Fx(par_oPg)
    LOCAL lcN, loO, lnI
    FOR lnI = 1 TO par_oPg.ControlCount
        loO = par_oPg.Controls(lnI)
        IF UPPER(loO.BaseClass) == "CONTAINER"
            IF loO.BackColor = RGB(100,100,100) AND loO.Height >= 60
                RETURN TRANSFORM(loO.Top) + ".." + TRANSFORM(loO.Top + loO.Height) + ;
                       " [" + ALLTRIM(loO.Name) + "]"
            ENDIF
        ENDIF
    ENDFOR
    RETURN "(nao achada)"
ENDFUNC
