SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probe778f4.txt"
STRTOFILE("PROBE INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
Log778("config.prg carregado")

ConfigurarAmbiente()
Log778("ConfigurarAmbiente OK")

GarantirClasse("FormSigOpPec")
Log778("GarantirClasse OK")

LOCAL loForm, loImg, loNav, lnI
loForm = CREATEOBJECT("FormSigOpPec")
Log778("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log778("Caption=[" + loForm.Caption + "] Width=" + TRANSFORM(loForm.Width) + ;
           " Height=" + TRANSFORM(loForm.Height) + " DataSession=" + TRANSFORM(loForm.DataSession))

    *-- Cabecalho (fase 3)
    Log778("cnt_4c_Sombra: Visible=" + TRANSFORM(loForm.cnt_4c_Sombra.Visible) + ;
           " lblTitulo.Caption=[" + loForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]")

    *-- Cnt_Pag deve permanecer FLUTUANTE (Visible = .F.) mesmo apos TornarControlesVisiveis
    Log778("cnt_4c__Pag: Visible=" + TRANSFORM(loForm.cnt_4c__Pag.Visible) + ;
           " Text1.Visible=" + TRANSFORM(loForm.cnt_4c__Pag.txt_4c_Text1.Visible) + ;
           " Text1.InputMask=[" + loForm.cnt_4c__Pag.txt_4c_Text1.InputMask + "]" + ;
           " Command4.PictureOK=" + TRANSFORM(FILE(loForm.cnt_4c__Pag.cmd_4c_Command4.Picture)))

    *-- Grade de imagens: 15 containers, cada um com IMG/Label/Check1
    LOCAL lcFalhas
    lcFalhas = ""
    FOR lnI = 1 TO 15
        loImg = EVALUATE("loForm.cnt_4c_Imagem" + TRANSFORM(lnI))
        IF VARTYPE(loImg) != "O"
            lcFalhas = lcFalhas + "Imagem" + TRANSFORM(lnI) + "=AUSENTE "
        ELSE
            IF !PEMSTATUS(loImg, "img_4c_IMG", 5) OR ;
               !PEMSTATUS(loImg, "lbl_4c_Label1", 5) OR ;
               !PEMSTATUS(loImg, "chk_4c_Check1", 5)
                lcFalhas = lcFalhas + "Imagem" + TRANSFORM(lnI) + "=FILHO_AUSENTE "
            ENDIF
            IF !loImg.Visible
                lcFalhas = lcFalhas + "Imagem" + TRANSFORM(lnI) + "=NAO_VISIVEL(apos TornarControlesVisiveis) "
            ENDIF
            IF !FILE(loImg.chk_4c_Check1.Picture) OR !FILE(loImg.chk_4c_Check1.DownPicture)
                lcFalhas = lcFalhas + "Imagem" + TRANSFORM(lnI) + "=ICONE_AUSENTE "
            ENDIF
        ENDIF
    ENDFOR
    Log778("Grade 15 slots - falhas=[" + lcFalhas + "] (vazio = OK)")

    Log778("Imagem1: Top=" + TRANSFORM(loForm.cnt_4c_Imagem1.Top) + " Left=" + TRANSFORM(loForm.cnt_4c_Imagem1.Left))
    Log778("Imagem5: Top=" + TRANSFORM(loForm.cnt_4c_Imagem5.Top) + " Left=" + TRANSFORM(loForm.cnt_4c_Imagem5.Left))
    Log778("Imagem11: Top=" + TRANSFORM(loForm.cnt_4c_Imagem11.Top) + " Left=" + TRANSFORM(loForm.cnt_4c_Imagem11.Left))
    Log778("Imagem15: Top=" + TRANSFORM(loForm.cnt_4c_Imagem15.Top) + " Left=" + TRANSFORM(loForm.cnt_4c_Imagem15.Left))

    Log778("lbl_4c_Pagina: Caption=[" + loForm.lbl_4c_Pagina.Caption + "] Visible=" + TRANSFORM(loForm.lbl_4c_Pagina.Visible))

    *-- BOTOES_CONSULTA
    loNav = loForm.obj_4c_BOTOES_CONSULTA
    Log778("obj_4c_BOTOES_CONSULTA: ButtonCount=" + TRANSFORM(loNav.ButtonCount) + ;
           " Visible=" + TRANSFORM(loNav.Visible) + " Top=" + TRANSFORM(loNav.Top) + " Left=" + TRANSFORM(loNav.Left))
    FOR lnI = 1 TO 4
        Log778("  Buttons(" + TRANSFORM(lnI) + "): Caption=[" + loNav.Buttons(lnI).Caption + "]" + ;
               " PictureOK=" + TRANSFORM(FILE(loNav.Buttons(lnI).Picture)) + ;
               " Cancel=" + TRANSFORM(loNav.Buttons(lnI).Cancel))
    ENDFOR

    loForm.Release()
    Log778("Release OK")
ENDIF

Log778("PROBE FIM")
QUIT

PROCEDURE Log778(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
