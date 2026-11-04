*==============================================================================
* ProbeErro303Final.prg - Prova por INSTANCIACAO que, numa amostra dos forms
* do sweep, os botoes ficam INTEIROS dentro da faixa do cabecalho.
* Mede em coordenadas de tela (Top + PageFrame.Top) nas DUAS paginas.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
PUBLIC gcLF303
gb_4c_ModoTeste        = .T.
gnConnHandle           = 0
gc_4c_UsuarioLogado    = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_f303.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

gcLF303 = "C:\4c\automation\probe_erro303_final.txt"
STRTOFILE("A: inicio" + CHR(13) + CHR(10), gcLF303)

LOCAL loc_oE, loc_nI

DIMENSION laF[10, 2]
laF[1,1]="FormGpe"         && laF[1,2]="GpeBO"
laF[1,2]="GpeBO"
laF[2,1]="Formorl"
laF[2,2]="orlBO"
laF[3,1]="FormCsi"
laF[3,2]="CsiBO"
laF[4,1]="FormMtt"
laF[4,2]="MttBO"
laF[5,1]="FormCNF"
laF[5,2]="CNFBO"
laF[6,1]="FormRop"
laF[6,2]="RopBO"
laF[7,1]="Formpgr"
laF[7,2]="pgrBO"
laF[8,1]="FormCrt"
laF[8,2]="CrtBO"
laF[9,1]="Formmod"
laF[9,2]="modBO"
laF[10,1]="FormAcessoGrupo"
laF[10,2]="AcessoGrupoBO"

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
    FOR loc_nI = 1 TO 10
        SET PROCEDURE TO (gcCaminhoClasses + ALLTRIM(laF[loc_nI,2]) + ".prg") ADDITIVE
        SET PROCEDURE TO (gcCaminhoForms + "cadastros\" + ALLTRIM(laF[loc_nI,1]) + ".prg") ADDITIVE
    ENDFOR
    LogF("B: deps carregadas")
    LogF("")
    LogF("  FORM             PAG  FAIXA(tela)   BOTOES(tela)       VEREDICTO")
    LogF("  ---------------- ---  ------------  -----------------  ---------")

    FOR loc_nI = 1 TO 10
        Medir(ALLTRIM(laF[loc_nI,1]))
    ENDFOR

CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " | Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " | Proc:" + loc_oE.Procedure + CHR(13) + CHR(10), gcLF303, 1)
ENDTRY

STRTOFILE("Z: fim" + CHR(13) + CHR(10), gcLF303, 1)
QUIT

PROCEDURE LogF(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcLF303, 1)
ENDPROC

PROCEDURE Medir(par_cForm)
    LOCAL loF, lnOff, lnP, loc_oErr
    TRY
        loF = CREATEOBJECT(par_cForm)
        IF VARTYPE(loF) # "O"
            LogF("  " + PADR(par_cForm, 17) + "CREATEOBJECT FALHOU")
            RETURN
        ENDIF
        lnOff = loF.pgf_4c_Paginas.Top
        FOR lnP = 1 TO loF.pgf_4c_Paginas.PageCount
            MedirPag(par_cForm, loF.pgf_4c_Paginas.Pages(lnP), lnP, lnOff)
        ENDFOR
        loF.Release()
    CATCH TO loc_oErr
        LogF("  " + PADR(par_cForm, 17) + "ERRO: " + loc_oErr.Message)
    ENDTRY
ENDPROC

PROCEDURE MedirPag(par_cForm, par_oPg, par_nP, par_nOff)
    LOCAL lnI, loC, lnFxI, lnFxF, lnMin, lnMax, lcN, lnJ, loB, llAchou
    lnFxI = -9999
    *-- faixa: Container BackColor 100,100,100 e Height >= 60 (regra #11)
    FOR lnI = 1 TO par_oPg.ControlCount
        loC = par_oPg.Controls(lnI)
        IF UPPER(loC.BaseClass) == "CONTAINER"
            IF loC.BackColor = RGB(100,100,100) AND loC.Height >= 60
                lnFxI = loC.Top + par_nOff
                lnFxF = loC.Top + loC.Height + par_nOff
                EXIT
            ENDIF
        ENDIF
    ENDFOR
    IF lnFxI = -9999
        RETURN
    ENDIF

    *-- menor inicio e maior fim de botao que INTERSECTA a faixa
    lnMin = 99999
    lnMax = -99999
    llAchou = .F.
    FOR lnI = 1 TO par_oPg.ControlCount
        loC = par_oPg.Controls(lnI)
        IF UPPER(loC.BaseClass) # "CONTAINER"
            LOOP
        ENDIF
        FOR lnJ = 1 TO loC.ControlCount
            loB = loC.Controls(lnJ)
            IF UPPER(loB.BaseClass) == "COMMANDBUTTON"
                lnI2 = loC.Top + loB.Top + par_nOff
                lnF2 = lnI2 + loB.Height
                IF lnI2 < lnFxF
                    llAchou = .T.
                    lnMin = MIN(lnMin, lnI2)
                    lnMax = MAX(lnMax, lnF2)
                ENDIF
            ENDIF
        ENDFOR
    ENDFOR
    IF !llAchou
        RETURN
    ENDIF

    LogF("  " + PADR(par_cForm, 17) + PADR(TRANSFORM(par_nP), 5) + ;
         PADR(TRANSFORM(lnFxI) + ".." + TRANSFORM(lnFxF), 14) + ;
         PADR(TRANSFORM(lnMin) + ".." + TRANSFORM(lnMax), 19) + ;
         IIF(lnMin >= lnFxI AND lnMax <= lnFxF, "DENTRO", ;
             "FORA (transborda " + TRANSFORM(MAX(lnMax - lnFxF, 0)) + ")"))
ENDPROC
