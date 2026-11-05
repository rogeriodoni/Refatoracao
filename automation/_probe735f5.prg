SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe735f5_dialogs.txt"
gb_4c_ValidandoUI      = .F.
gnConnHandle           = 0

LOCAL lcOut, loForm, lcCk, loPg, lnI
lcCk  = "C:\4c\automation\_probe735f5_ck.txt"
lcOut = "C:\4c\automation\_probe735f5_out.txt"

STRTOFILE("CK1 inicio" + CHR(13) + CHR(10), lcCk)
CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CK2 config.prg ok" + CHR(13) + CHR(10), lcCk, .T.)
ConfigurarAmbiente()
STRTOFILE("CK3 ConfigurarAmbiente ok" + CHR(13) + CHR(10), lcCk, .T.)
GarantirClasse("FormSIGOPFLU")
STRTOFILE("CK4 GarantirClasse ok" + CHR(13) + CHR(10), lcCk, .T.)

loForm = CREATEOBJECT("FormSIGOPFLU")
STRTOFILE("CK5 CREATEOBJECT VARTYPE=" + VARTYPE(loForm) + CHR(13) + CHR(10), lcCk, .T.)

LOCAL lcR
lcR = "VARTYPE(loForm)=" + VARTYPE(loForm) + CHR(13) + CHR(10)

IF VARTYPE(loForm) = "O"
    lcR = lcR + "Caption=[" + loForm.Caption + "]" + CHR(13) + CHR(10)
    lcR = lcR + "Form WxH=" + TRANSFORM(loForm.Width) + "x" + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    loPg = loForm.pgf_4c_Paginas.Page1
    lcR = lcR + "PageCount=" + TRANSFORM(loForm.pgf_4c_Paginas.PageCount) + ;
          " ActivePage=" + TRANSFORM(loForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10)
    lcR = lcR + "Page1.ControlCount=" + TRANSFORM(loPg.ControlCount) + CHR(13) + CHR(10)
    lcR = lcR + "--- controles da Page1 (ordem de AddObject) ---" + CHR(13) + CHR(10)
    FOR lnI = 1 TO loPg.ControlCount
        lcR = lcR + PADR(TRANSFORM(lnI), 3) + PADR(loPg.Controls(lnI).Name, 22) + ;
              PADR(loPg.Controls(lnI).BaseClass, 13) + ;
              "T=" + PADL(TRANSFORM(loPg.Controls(lnI).Top), 4) + ;
              " L=" + PADL(TRANSFORM(loPg.Controls(lnI).Left), 4) + ;
              " W=" + PADL(TRANSFORM(loPg.Controls(lnI).Width), 4) + ;
              " H=" + PADL(TRANSFORM(loPg.Controls(lnI).Height), 4) + ;
              " Vis=" + IIF(loPg.Controls(lnI).Visible, "T", "F") + CHR(13) + CHR(10)
    ENDFOR
    lcR = lcR + "--- metodos ---" + CHR(13) + CHR(10)
    lcR = lcR + "PEMSTATUS ConfigurarPaginaDados exists=" + ;
          IIF(PEMSTATUS(loForm, "ConfigurarPaginaDados", 5), "T", "F") + ;
          " protected=" + IIF(PEMSTATUS(loForm, "ConfigurarPaginaDados", 2), "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "PEMSTATUS ConfigurarPaginaLista exists=" + ;
          IIF(PEMSTATUS(loForm, "ConfigurarPaginaLista", 5), "T", "F") + ;
          " protected=" + IIF(PEMSTATUS(loForm, "ConfigurarPaginaLista", 2), "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "--- estado inicial ---" + CHR(13) + CHR(10)
    lcR = lcR + "DtInicial=[" + TRANSFORM(loPg.txt_4c_DtInicial.Value) + "]" + ;
          " DtFinal=[" + TRANSFORM(loPg.txt_4c_DtFinal.Value) + "]" + CHR(13) + CHR(10)
    lcR = lcR + "Grupo.Enabled=" + IIF(loPg.txt_4c_Grupo.Enabled, "T", "F") + ;
          " DGrupo.Enabled=" + IIF(loPg.txt_4c_DGrupo.Enabled, "T", "F") + CHR(13) + CHR(10)
    lcR = lcR + "ChkData.Value=" + TRANSFORM(loPg.chk_4c_ChkData.Value) + CHR(13) + CHR(10)
    loForm.Release()
ENDIF

STRTOFILE(lcR, lcOut)
STRTOFILE("CK6 fim" + CHR(13) + CHR(10), lcCk, .T.)
QUIT
