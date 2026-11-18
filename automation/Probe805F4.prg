SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut
gcOut = "C:\4c\automation\probe805f4.txt"
STRTOFILE("PROBE 805 FASE 4 - INICIO" + CHR(13) + CHR(10), gcOut)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpSpr")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe805f4_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL loForm, loGrd, loBt

*==========================================================================
* CENARIO A - SEM o cursor do form pai (caminho normal do harness)
*==========================================================================
Log805("=== CENARIO A: sem cursor_4c_Produtos ===")

loForm = CREATEOBJECT("FormSigOpSpr")
Log805("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log805("Caption=[" + loForm.Caption + "] W=" + TRANSFORM(loForm.Width) + ;
           " H=" + TRANSFORM(loForm.Height) + " DataSession=" + TRANSFORM(loForm.DataSession))

    LOCAL lnI, lcZ
    lcZ = ""
    FOR lnI = 1 TO loForm.ControlCount
        lcZ = lcZ + IIF(EMPTY(lcZ), "", " | ") + UPPER(loForm.Controls(lnI).Name)
    ENDFOR
    Log805("z-order do form: " + lcZ)

    loGrd = loForm.grd_4c_Dados
    Log805("Grade: Top=" + TRANSFORM(loGrd.Top) + " Left=" + TRANSFORM(loGrd.Left) + ;
           " W=" + TRANSFORM(loGrd.Width) + " H=" + TRANSFORM(loGrd.Height) + ;
           " ColumnCount=" + TRANSFORM(loGrd.ColumnCount) + ;
           " ReadOnly=" + TRANSFORM(loGrd.ReadOnly) + ;
           " Visible=" + TRANSFORM(loGrd.Visible) + ;
           " RecordSource=[" + loGrd.RecordSource + "]")
    Log805("Colunas: C1.W=" + TRANSFORM(loGrd.Column1.Width) + ;
           " C1.Header=[" + loGrd.Column1.Header1.Caption + "]" + ;
           " C2.W=" + TRANSFORM(loGrd.Column2.Width) + ;
           " C2.Header=[" + loGrd.Column2.Header1.Caption + "]")

    Log805("CmdEscolha: Top=" + TRANSFORM(loForm.cmg_4c_CmdEscolha.Top) + ;
           " Left=" + TRANSFORM(loForm.cmg_4c_CmdEscolha.Left) + ;
           " W=" + TRANSFORM(loForm.cmg_4c_CmdEscolha.Width) + ;
           " H=" + TRANSFORM(loForm.cmg_4c_CmdEscolha.Height) + ;
           " Visible=" + TRANSFORM(loForm.cmg_4c_CmdEscolha.Visible) + ;
           " ButtonCount=" + TRANSFORM(loForm.cmg_4c_CmdEscolha.ButtonCount))

    loBt = loForm.cmg_4c_CmdEscolha.Buttons(1)
    Log805("  Btn1 [" + loBt.Caption + "] Left=" + TRANSFORM(loBt.Left) + ;
           " Top=" + TRANSFORM(loBt.Top) + " W=" + TRANSFORM(loBt.Width) + ;
           " H=" + TRANSFORM(loBt.Height) + " PictureOK=" + TRANSFORM(FILE(loBt.Picture)))
    loBt = loForm.cmg_4c_CmdEscolha.Buttons(2)
    Log805("  Btn2 [" + loBt.Caption + "] Left=" + TRANSFORM(loBt.Left) + ;
           " W=" + TRANSFORM(loBt.Width) + " PictureOK=" + TRANSFORM(FILE(loBt.Picture)))

    Log805("CmdSalva: Top=" + TRANSFORM(loForm.cmg_4c_CmdSalva.Top) + ;
           " Left=" + TRANSFORM(loForm.cmg_4c_CmdSalva.Left) + ;
           " W=" + TRANSFORM(loForm.cmg_4c_CmdSalva.Width) + ;
           " H=" + TRANSFORM(loForm.cmg_4c_CmdSalva.Height) + ;
           " Visible=" + TRANSFORM(loForm.cmg_4c_CmdSalva.Visible))
    loBt = loForm.cmg_4c_CmdSalva.Buttons(1)
    Log805("  Btn1 [" + loBt.Caption + "] Cancel=" + TRANSFORM(loBt.Cancel) + ;
           " W=" + TRANSFORM(loBt.Width) + " PictureOK=" + TRANSFORM(FILE(loBt.Picture)))

    Log805("ImgBarra1.Visible=" + TRANSFORM(loForm.img_4c_ImgBarra1.Visible) + ;
           " ImgBarra2.Visible=" + TRANSFORM(loForm.img_4c_ImgBarra2.Visible))

    Log805("Escopo (0=PUBLIC): CarregarDados prot=" + ;
           TRANSFORM(PEMSTATUS(loForm, "CarregarDados", 2)) + ;
           " AplicarFormatoGrade prot=" + TRANSFORM(PEMSTATUS(loForm, "AplicarFormatoGrade", 2)) + ;
           " GarantirLinhaEmBranco prot=" + TRANSFORM(PEMSTATUS(loForm, "GarantirLinhaEmBranco", 2)) + ;
           " AplicarVisibilidade prot=" + TRANSFORM(PEMSTATUS(loForm, "AplicarVisibilidadePorContexto", 2)))

    Log805("CarregarDados() de fora, sem cursor = " + TRANSFORM(loForm.CarregarDados()))

    loForm.Release()
    Log805("Release OK")
ENDIF

*==========================================================================
* CENARIO B - COM o cursor do form pai, SEM linha em branco
*==========================================================================
Log805("")
Log805("=== CENARIO B: com cursor_4c_Produtos (2 linhas preenchidas) ===")

CREATE CURSOR cursor_4c_Produtos (CPros C(14), DPros C(65))
INSERT INTO cursor_4c_Produtos (CPros, DPros) VALUES ("0001", "PRODUTO UM")
INSERT INTO cursor_4c_Produtos (CPros, DPros) VALUES ("0002", "PRODUTO DOIS")
Log805("cursor criado: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Produtos")))

loForm = CREATEOBJECT("FormSigOpSpr")
Log805("CREATEOBJECT -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    loGrd = loForm.grd_4c_Dados
    Log805("RecordSource=[" + loGrd.RecordSource + "]" + ;
           " C1.ControlSource=[" + loGrd.Column1.ControlSource + "]" + ;
           " C2.ControlSource=[" + loGrd.Column2.ControlSource + "]")
    Log805("Apos bind: C1.W=" + TRANSFORM(loGrd.Column1.Width) + ;
           " C1.Header=[" + loGrd.Column1.Header1.Caption + "]" + ;
           " C2.W=" + TRANSFORM(loGrd.Column2.Width) + ;
           " C2.Header=[" + loGrd.Column2.Header1.Caption + "]")
    Log805("Linha em branco: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Produtos")) + ;
           " (esperado 3)  RECNO=" + TRANSFORM(RECNO("cursor_4c_Produtos")) + ;
           " alias corrente=[" + ALIAS() + "]")

    Log805("2a chamada CarregarDados() = " + TRANSFORM(loForm.CarregarDados()) + ;
           " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Produtos")) + ;
           " (esperado 3 - idempotente)")
    Log805("Apos recarga: C1.W=" + TRANSFORM(loGrd.Column1.Width) + ;
           " C1.Header=[" + loGrd.Column1.Header1.Caption + "]" + ;
           " C2.W=" + TRANSFORM(loGrd.Column2.Width))

    Log805("Cursor temporario de brancos fechado: " + ;
           TRANSFORM(!USED("cursor_4c_LinhasBrancas")))

    loForm.Release()
    Log805("Release OK - cursor do pai sobreviveu: " + TRANSFORM(USED("cursor_4c_Produtos")))
ENDIF

Log805("")
Log805("ERROS CAPTURADOS: [" + FILETOSTR("C:\4c\automation\probe805f4_erros.txt") + "]")
Log805("PROBE FIM")
QUIT

PROCEDURE Log805(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gcOut, 1)
ENDPROC
