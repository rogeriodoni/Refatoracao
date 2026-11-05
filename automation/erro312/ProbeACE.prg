*==============================================================================
* ProbeACE.prg - mede a geometria REAL da faixa de cabecalho e dos containers
* de botoes do FormACE (Erro312). Nao altera nada: so instancia e dumpa.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE CK_FILE "C:\4c\automation\erro312\probe_ck.txt"
#DEFINE OUT_FILE "C:\4c\automation\erro312\probe_out.txt"

LOCAL loc_cOut, loForm, loc_oErr

STRTOFILE("CK00 inicio" + CHR(13) + CHR(10), CK_FILE)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste       = .T.
gb_4c_ValidandoUI     = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\erro312\probe_erro.txt"

CD "C:\4c\projeto\app\start"
STRTOFILE("CK01 antes DO config.prg" + CHR(13) + CHR(10), CK_FILE, 1)
DO config.prg
STRTOFILE("CK02 config.prg carregado" + CHR(13) + CHR(10), CK_FILE, 1)

ConfigurarAmbiente()
STRTOFILE("CK03 ConfigurarAmbiente ok" + CHR(13) + CHR(10), CK_FILE, 1)

GarantirClasse("FormACE")
STRTOFILE("CK04 GarantirClasse ok" + CHR(13) + CHR(10), CK_FILE, 1)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormACE")
CATCH TO loc_oErr
    STRTOFILE("ERRO CREATEOBJECT: " + loc_oErr.Message + CHR(13) + CHR(10), CK_FILE, 1)
ENDTRY
STRTOFILE("CK05 CREATEOBJECT vartype=" + VARTYPE(loForm) + CHR(13) + CHR(10), CK_FILE, 1)

IF VARTYPE(loForm) != "O"
    STRTOFILE("FALHOU: form nao instanciou", OUT_FILE)
    QUIT
ENDIF

loc_cOut = "=== FormACE - geometria real (Erro312) ===" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "Form.Width=" + TRANSFORM(loForm.Width) + ;
           "  Form.Height=" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)

WITH loForm.pgf_4c_Paginas
    loc_cOut = loc_cOut + "PageFrame Top=" + TRANSFORM(.Top) + ;
               " Left=" + TRANSFORM(.Left) + ;
               " Width=" + TRANSFORM(.Width) + ;
               " Height=" + TRANSFORM(.Height) + ;
               " Tabs=" + TRANSFORM(.Tabs) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "Page1 Width=" + TRANSFORM(.Page1.Width) + ;
               " Height=" + TRANSFORM(.Page1.Height) + CHR(13) + CHR(10)
ENDWITH

LOCAL loc_nP, loc_oPg, loc_nI, loc_oC
FOR loc_nP = 1 TO 2
    loc_oPg = IIF(loc_nP = 1, loForm.pgf_4c_Paginas.Page1, loForm.pgf_4c_Paginas.Page2)
    loc_cOut = loc_cOut + CHR(13) + CHR(10) + "--- Page" + TRANSFORM(loc_nP) + ;
               " (" + ALLTRIM(loc_oPg.Caption) + ") ControlCount=" + ;
               TRANSFORM(loc_oPg.ControlCount) + " ---" + CHR(13) + CHR(10)
    FOR loc_nI = 1 TO loc_oPg.ControlCount
        loc_oC = loc_oPg.Controls(loc_nI)
        loc_cOut = loc_cOut + PADR(loc_oC.Name, 22) + PADR(loc_oC.BaseClass, 15) + ;
                   " T=" + PADL(TRANSFORM(loc_oC.Top), 5) + ;
                   " L=" + PADL(TRANSFORM(loc_oC.Left), 5) + ;
                   " W=" + PADL(TRANSFORM(loc_oC.Width), 5) + ;
                   " H=" + PADL(TRANSFORM(loc_oC.Height), 5)
        IF PEMSTATUS(loc_oC, "BackStyle", 5)
            loc_cOut = loc_cOut + " BackStyle=" + TRANSFORM(loc_oC.BackStyle)
        ENDIF
        IF PEMSTATUS(loc_oC, "BackColor", 5)
            loc_cOut = loc_cOut + " BackColor=" + TRANSFORM(loc_oC.BackColor)
        ENDIF
        IF PEMSTATUS(loc_oC, "BorderWidth", 5)
            loc_cOut = loc_cOut + " BorderWidth=" + TRANSFORM(loc_oC.BorderWidth)
        ENDIF
        IF PEMSTATUS(loc_oC, "SpecialEffect", 5)
            loc_cOut = loc_cOut + " SpecialEffect=" + TRANSFORM(loc_oC.SpecialEffect)
        ENDIF
        IF PEMSTATUS(loc_oC, "BorderColor", 5)
            loc_cOut = loc_cOut + " BorderColor=" + TRANSFORM(loc_oC.BorderColor)
        ENDIF
        loc_cOut = loc_cOut + " Visible=" + TRANSFORM(loc_oC.Visible) + CHR(13) + CHR(10)

        *-- filhos de container (botoes)
        IF loc_oC.BaseClass = "Container" AND PEMSTATUS(loc_oC, "ControlCount", 5)
            LOCAL loc_nJ, loc_oB
            FOR loc_nJ = 1 TO loc_oC.ControlCount
                loc_oB = loc_oC.Controls(loc_nJ)
                loc_cOut = loc_cOut + "    > " + PADR(loc_oB.Name, 20) + ;
                           PADR(loc_oB.BaseClass, 15) + ;
                           " T=" + PADL(TRANSFORM(loc_oB.Top), 4) + ;
                           " L=" + PADL(TRANSFORM(loc_oB.Left), 4) + ;
                           " W=" + PADL(TRANSFORM(loc_oB.Width), 4) + ;
                           " H=" + PADL(TRANSFORM(loc_oB.Height), 4)
                IF PEMSTATUS(loc_oB, "Caption", 5)
                    loc_cOut = loc_cOut + " Cap=[" + ALLTRIM(loc_oB.Caption) + "]"
                ENDIF
                IF PEMSTATUS(loc_oB, "BackColor", 5)
                    loc_cOut = loc_cOut + " BackColor=" + TRANSFORM(loc_oB.BackColor)
                ENDIF
                IF PEMSTATUS(loc_oB, "Picture", 5)
                    loc_cOut = loc_cOut + " Pic=" + IIF(EMPTY(loc_oB.Picture), "(vazio)", ;
                               IIF(FILE(loc_oB.Picture), "OK", "AUSENTE")) + ;
                               "[" + JUSTFNAME(loc_oB.Picture) + "]"
                ENDIF
                loc_cOut = loc_cOut + CHR(13) + CHR(10)
            ENDFOR
        ENDIF
    ENDFOR
ENDFOR

loc_cOut = loc_cOut + CHR(13) + CHR(10) + ;
    "RGB(100,100,100)=" + TRANSFORM(RGB(100,100,100)) + ;
    "  RGB(53,53,53)=" + TRANSFORM(RGB(53,53,53)) + ;
    "  RGB(255,255,255)=" + TRANSFORM(RGB(255,255,255)) + CHR(13) + CHR(10)

STRTOFILE(loc_cOut, OUT_FILE)
STRTOFILE("CK99 fim" + CHR(13) + CHR(10), CK_FILE, 1)
QUIT
