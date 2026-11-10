*-- Probe da FASE 6 do FormSigOpLcl (task757): instancia o form de verdade e
*-- mede os objetos acrescentados (Terceiro/Quarto Nivel, ShpFigura/ImgJpg,
*-- cmdAcoes, Label5+OptOrdem), os gates estendidos e o fluxo de Localizar.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut757b
gcOut757b = "C:\4c\automation\probef6sigoplcl757.txt"
STRTOFILE("PROBE F6 task757 INICIO" + CHR(13) + CHR(10), gcOut757b)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpLcl")

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef6sigoplcl757_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log757b("ambiente OK")

*-- Cursor do form CHAMADOR (contrato externo - nome do legado)
CREATE CURSOR crTpmMvItn (cItens N(10,0), Cpros C(14), Dpros C(65), ;
                          Locals C(10), Localos C(10))
INSERT INTO crTpmMvItn VALUES (1, "PROD001", "PRODUTO UM",   "", "")
INSERT INTO crTpmMvItn VALUES (2, "PROD002", "PRODUTO DOIS", "", "")

LOCAL loForm

*------------------------------------------------------------------
* 1) Modo INSERIR - this_lPodeEditar = .T.
*------------------------------------------------------------------
loForm = CREATEOBJECT("FormSigOpLcl", .NULL., "INSERIR", "")
Log757b("1) CREATEOBJECT INSERIR -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"

    MedirObj757b(loForm, "lbl_4c_Label2")
    MedirObj757b(loForm, "txt_4c_Nvl3")
    MedirObj757b(loForm, "txt_4c_DNvl3")
    MedirObj757b(loForm, "lbl_4c_Label4")
    MedirObj757b(loForm, "txt_4c_Nvl4")
    MedirObj757b(loForm, "txt_4c_DNvl4")
    MedirObj757b(loForm, "shp_4c_ShpFigura")
    MedirObj757b(loForm, "img_4c_ImgJpg")
    MedirObj757b(loForm, "obj_4c_CmdAcoes")
    MedirObj757b(loForm, "lbl_4c_Label5")
    MedirObj757b(loForm, "obj_4c_OptOrdem")

    Log757b("   MaxLength: Nvl3=" + TRANSFORM(loForm.txt_4c_Nvl3.MaxLength) + ;
            " DNvl3=" + TRANSFORM(loForm.txt_4c_DNvl3.MaxLength) + ;
            " Nvl4=" + TRANSFORM(loForm.txt_4c_Nvl4.MaxLength) + ;
            " DNvl4=" + TRANSFORM(loForm.txt_4c_DNvl4.MaxLength))

    Log757b("   ImgJpg.Visible=" + TRANSFORM(loForm.img_4c_ImgJpg.Visible) + ;
            " (esperado .F. - nasce oculta)")

    Log757b("   cmdAcoes.ButtonCount=" + TRANSFORM(loForm.obj_4c_CmdAcoes.ButtonCount) + ;
            " Buttons(1).Caption=[" + loForm.obj_4c_CmdAcoes.Buttons(1).Caption + "]" + ;
            " Buttons(2).Caption=[" + loForm.obj_4c_CmdAcoes.Buttons(2).Caption + "]")

    Log757b("   OptOrdem.Value=" + TRANSFORM(loForm.obj_4c_OptOrdem.Value) + ;
            " (esperado 1) Buttons(1).Caption=[" + loForm.obj_4c_OptOrdem.Buttons(1).Caption + ;
            "] Buttons(2).Caption=[" + loForm.obj_4c_OptOrdem.Buttons(2).Caption + "]")

    *-- Gate completo: Base->Nvl2->Nvl3->Nvl4 em cadeia
    loForm.txt_4c_Base.Value = ""
    loForm.txt_4c_Nvl2.Value = ""
    loForm.txt_4c_Nvl3.Value = ""
    loForm.AtualizarDependenciaNiveis()
    Log757b("   GATE tudo vazio: Nvl3.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl3.Enabled) + ;
            " (esperado .F.) Nvl4.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl4.Enabled) + " (esperado .F.)")

    loForm.txt_4c_Base.Value = "01"
    loForm.txt_4c_Nvl2.Value = "02"
    loForm.AtualizarDependenciaNiveis()
    Log757b("   GATE Base+Nvl2 preenchidos: Nvl3.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl3.Enabled) + ;
            " (esperado .T.) Nvl4.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl4.Enabled) + " (esperado .F., Nvl3 vazio)")

    loForm.txt_4c_Nvl3.Value = "03"
    loForm.AtualizarDependenciaNiveis()
    Log757b("   GATE +Nvl3: Nvl4.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl4.Enabled) + " (esperado .T.)")

    *-- cmdAcoes.Buttons(1) (Localizar) comeca Enabled=this_lPodeEditar
    Log757b("   btnLocalizar.Enabled inicial=" + TRANSFORM(loForm.obj_4c_CmdAcoes.Buttons(1).Enabled) + ;
            " (esperado .T. - this_lPodeEditar)")

    *-- Marca o item 1 e dispara AfterRowColChange manualmente (equivalente ao
    *-- toggle do Check1) para medir o refinamento do botao Localizar
    IF USED("cursor_4c_Itens")
        SELECT cursor_4c_Itens
        GO TOP
        REPLACE Marcas WITH 1
    ENDIF
    loForm.GradeAfterRowColChange()
    Log757b("   apos marcar linha 1 + AfterRowColChange: btnLocalizar.Enabled=" + ;
            TRANSFORM(loForm.obj_4c_CmdAcoes.Buttons(1).Enabled) + " (esperado .T.)")

    IF USED("cursor_4c_Itens")
        SELECT cursor_4c_Itens
        REPLACE Marcas WITH 0
    ENDIF
    loForm.GradeAfterRowColChange()
    Log757b("   apos desmarcar + AfterRowColChange: btnLocalizar.Enabled=" + ;
            TRANSFORM(loForm.obj_4c_CmdAcoes.Buttons(1).Enabled) + " (esperado .F.)")

    *-- Toggle via ChkMarcasKeyPress (Enter) - simula o clique no CheckBox
    loForm.ChkMarcasKeyPress(13, 0)
    Log757b("   apos ChkMarcasKeyPress(13): cursor_4c_Itens.Marcas=" + ;
            TRANSFORM(cursor_4c_Itens.Marcas) + " (esperado 1) btnLocalizar.Enabled=" + ;
            TRANSFORM(loForm.obj_4c_CmdAcoes.Buttons(1).Enabled))

    *-- BtnLocalizarClick com os 4 niveis preenchidos (Base=01/Nvl2=02/Nvl3=03/Nvl4 vazio)
    *-- ValidarNiveis vai reprovar por falta do Nvl4 SE houver filhos cadastrados
    *-- em cursor_4c_LcNv4 para o pai '03' - sem conexao SQL os cursores de nivel
    *-- ficam vazios (RECCOUNT=0), entao a exigencia de Nvl4 eh pulada e a
    *-- gravacao deve SUCEDER.
    loForm.BtnLocalizarClick()
    Log757b("   apos BtnLocalizarClick: txt_4c_Base.Value=[" + loForm.txt_4c_Base.Value + ;
            "] (esperado vazio se gravou) cursor_4c_Locais RECCOUNT=" + ;
            IIF(USED("cursor_4c_Locais"), TRANSFORM(RECCOUNT("cursor_4c_Locais")), "N/A"))

    *-- BtnLimparClick - so limpa os 8 campos de nivel, NAO desmarca itens
    loForm.txt_4c_Base.Value = "99"
    loForm.BtnLimparClick()
    Log757b("   apos BtnLimparClick: txt_4c_Base.Value=[" + loForm.txt_4c_Base.Value + ;
            "] (esperado vazio)")

    loForm.Release()
    loForm = .NULL.
ENDIF

*------------------------------------------------------------------
* 2) Modo PROCURAR - this_lPodeEditar = .F. (gate fecha tudo, botoes disabled)
*------------------------------------------------------------------
loForm = CREATEOBJECT("FormSigOpLcl", .NULL., "PROCURAR", "ORIGEM")
Log757b("2) CREATEOBJECT PROCURAR -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log757b("   btnLocalizar.Enabled=" + TRANSFORM(loForm.obj_4c_CmdAcoes.Buttons(1).Enabled) + ;
            " (esperado .F.) btnLimpar.Enabled=" + TRANSFORM(loForm.obj_4c_CmdAcoes.Buttons(2).Enabled) + ;
            " (esperado .F.)")

    Log757b("   VISIBLE: Label2=" + TRANSFORM(loForm.lbl_4c_Label2.Visible) + ;
            " Nvl3=" + TRANSFORM(loForm.txt_4c_Nvl3.Visible) + ;
            " Label4=" + TRANSFORM(loForm.lbl_4c_Label4.Visible) + ;
            " Nvl4=" + TRANSFORM(loForm.txt_4c_Nvl4.Visible) + ;
            " ShpFigura=" + TRANSFORM(loForm.shp_4c_ShpFigura.Visible) + ;
            " Label5=" + TRANSFORM(loForm.lbl_4c_Label5.Visible) + ;
            " OptOrdem=" + TRANSFORM(loForm.obj_4c_OptOrdem.Visible))
    Log757b("   ImgJpg segue oculta (TornarControlesVisiveis nao forca)? " + ;
            TRANSFORM(!loForm.img_4c_ImgJpg.Visible))

    *-- Botao de acao desabilitado -> Click defensivo nao deve gravar nada
    loForm.txt_4c_Base.Value = "01"
    loForm.BtnLocalizarClick()
    Log757b("   BtnLocalizarClick em modo PROCURAR (guard this_lPodeEditar): " + ;
            "txt_4c_Base.Value=[" + loForm.txt_4c_Base.Value + "] (esperado inalterado=01, guard bloqueou)")

    loForm.Release()
    loForm = .NULL.
ENDIF

Log757b("PROBE F6 task757 FIM")
QUIT

PROCEDURE Log757b(pcTexto)
    STRTOFILE(pcTexto + CHR(13) + CHR(10), gcOut757b, 1)
ENDPROC

PROCEDURE MedirObj757b(poForm, pcNome)
    LOCAL loObj
    IF !PEMSTATUS(poForm, pcNome, 5)
        Log757b("   [AUSENTE] " + pcNome)
        RETURN
    ENDIF
    loObj = EVALUATE("poForm." + pcNome)
    Log757b("   " + PADR(pcNome, 16) + " cls=" + PADR(loObj.BaseClass, 13) + ;
        " Top=" + PADL(TRANSFORM(loObj.Top), 4) + ;
        " Left=" + PADL(TRANSFORM(loObj.Left), 4) + ;
        " W=" + PADL(TRANSFORM(loObj.Width), 4) + ;
        " H=" + PADL(TRANSFORM(loObj.Height), 4) + ;
        IIF(PEMSTATUS(loObj, "Caption", 5), " Cap=[" + loObj.Caption + "]", "") + ;
        IIF(PEMSTATUS(loObj, "ForeColor", 5), " Fore=" + TRANSFORM(loObj.ForeColor), "") + ;
        IIF(PEMSTATUS(loObj, "Visible", 5), " Vis=" + TRANSFORM(loObj.Visible), ""))
ENDPROC
