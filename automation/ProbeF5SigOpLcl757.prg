*-- Probe da FASE 5 do FormSigOpLcl (task757): instancia o form de verdade e
*-- mede os 7 objetos acrescentados (Shape1 + Base + Segundo Nivel), alem do
*-- gate AtualizarDependenciaNiveis nos dois modos (editavel e somente-leitura)
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gcOut757
gcOut757 = "C:\4c\automation\probef5sigoplcl757.txt"
STRTOFILE("PROBE F5 task757 INICIO" + CHR(13) + CHR(10), gcOut757)

DO ("C:\4c\projeto\app\start\config.prg")
ConfigurarAmbiente()
GarantirClasse("FormSigOpLcl")

*-- Modo teste DEPOIS do config.prg (ele reseta as flags) e com arquivo de erro
*-- definido: sem os DOIS, MsgErro cai em MESSAGEBOX modal e o probe trava.
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probef5sigoplcl757_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

Log757("ambiente OK")

*-- Cursor do form CHAMADOR (contrato externo - nome do legado)
CREATE CURSOR crTpmMvItn (cItens N(10,0), Cpros C(14), Dpros C(65), ;
                          Locals C(10), Localos C(10))
INSERT INTO crTpmMvItn VALUES (1, "PROD001", "PRODUTO UM",   "", "")
INSERT INTO crTpmMvItn VALUES (2, "PROD002", "PRODUTO DOIS", "", "")

LOCAL loForm, lnI, lcNome, laCtl(1)

*------------------------------------------------------------------
* 1) Modo INSERIR - this_lPodeEditar = .T.
*------------------------------------------------------------------
loForm = CREATEOBJECT("FormSigOpLcl", .NULL., "INSERIR", "")
Log757("1) CREATEOBJECT INSERIR -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log757("   PodeEditar=" + TRANSFORM(loForm.this_lPodeEditar) + ;
           "  Form W=" + TRANSFORM(loForm.Width) + " H=" + TRANSFORM(loForm.Height))

    MedirObj757(loForm, "shp_4c_Shape1")
    MedirObj757(loForm, "lbl_4c_Label3")
    MedirObj757(loForm, "txt_4c_Base")
    MedirObj757(loForm, "txt_4c_DBase")
    MedirObj757(loForm, "lbl_4c_Label1")
    MedirObj757(loForm, "txt_4c_Nvl2")
    MedirObj757(loForm, "txt_4c_DNvl2")

    *-- Gate: Base habilitada (modo permite), Nvl2 bloqueada (Base vazia)
    Log757("   GATE inicial: Base.Enabled=" + TRANSFORM(loForm.txt_4c_Base.Enabled) + ;
           " (esperado .T.)  Nvl2.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl2.Enabled) + ;
           " (esperado .F.)")

    *-- Base preenchida libera o segundo nivel (If Empty(getBase.Value) do When)
    loForm.txt_4c_Base.Value = "01"
    loForm.AtualizarDependenciaNiveis()
    Log757("   GATE com Base=01: Nvl2.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl2.Enabled) + ;
           " (esperado .T.)")

    loForm.txt_4c_Base.Value = ""
    loForm.AtualizarDependenciaNiveis()
    Log757("   GATE Base limpa: Nvl2.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl2.Enabled) + ;
           " (esperado .F.)")

    *-- MaxLength efetivo: atribuir mais do que cabe nao eh truncado por codigo,
    *-- mas o valor DIGITADO fica limitado - so registra o que foi configurado
    Log757("   MaxLength: Base=" + TRANSFORM(loForm.txt_4c_Base.MaxLength) + ;
           " DBase=" + TRANSFORM(loForm.txt_4c_DBase.MaxLength) + ;
           " Nvl2=" + TRANSFORM(loForm.txt_4c_Nvl2.MaxLength) + ;
           " DNvl2=" + TRANSFORM(loForm.txt_4c_DNvl2.MaxLength))

    *-- Descricoes: ReadOnly de nascimento (When = .F. no legado)
    Log757("   DESCRICAO: DBase.ReadOnly=" + TRANSFORM(loForm.txt_4c_DBase.ReadOnly) + ;
           " TabStop=" + TRANSFORM(loForm.txt_4c_DBase.TabStop) + ;
           " | DNvl2.ReadOnly=" + TRANSFORM(loForm.txt_4c_DNvl2.ReadOnly) + ;
           " TabStop=" + TRANSFORM(loForm.txt_4c_DNvl2.TabStop))

    *-- Nenhum dos novos controles pode invadir a area da grade (Left 12..587)
    *-- nem a faixa do cabecalho (Top 0..80)
    Log757("   LIMITES: grade termina em Left=" + ;
           TRANSFORM(loForm.grd_4c_Dados.Left + loForm.grd_4c_Dados.Width) + ;
           "  cabecalho termina em Top=" + ;
           TRANSFORM(loForm.cnt_4c_Sombra.Top + loForm.cnt_4c_Sombra.Height))

    *-- Ordem de criacao: a moldura tem de vir ANTES dos campos que ela envolve
    FOR lnI = 1 TO loForm.ControlCount
        lcNome = UPPER(ALLTRIM(loForm.Controls(lnI).Name))
        IF INLIST(lcNome, "SHP_4C_SHAPE1", "LBL_4C_LABEL3", "TXT_4C_BASE", ;
                          "TXT_4C_DBASE", "LBL_4C_LABEL1", "TXT_4C_NVL2", "TXT_4C_DNVL2")
            Log757("   ordem[" + TRANSFORM(lnI) + "] = " + lcNome)
        ENDIF
    ENDFOR

    loForm.Release()
    loForm = .NULL.
ENDIF

*------------------------------------------------------------------
* 2) Modo PROCURAR - this_lPodeEditar = .F. (gate fecha tudo)
*------------------------------------------------------------------
loForm = CREATEOBJECT("FormSigOpLcl", .NULL., "PROCURAR", "ORIGEM")
Log757("2) CREATEOBJECT PROCURAR -> VARTYPE=" + VARTYPE(loForm))

IF VARTYPE(loForm) = "O"
    Log757("   PodeEditar=" + TRANSFORM(loForm.this_lPodeEditar) + ;
           "  Base.Enabled=" + TRANSFORM(loForm.txt_4c_Base.Enabled) + ;
           " (esperado .F.)  Nvl2.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl2.Enabled) + ;
           " (esperado .F.)")

    *-- Mesmo com a Base preenchida, modo nao editavel mantem tudo fechado
    loForm.txt_4c_Base.Value = "01"
    loForm.AtualizarDependenciaNiveis()
    Log757("   com Base=01: Base.Enabled=" + TRANSFORM(loForm.txt_4c_Base.Enabled) + ;
           " Nvl2.Enabled=" + TRANSFORM(loForm.txt_4c_Nvl2.Enabled) + " (ambos .F.)")

    *-- TornarControlesVisiveis nao pode ter deixado nada invisivel
    Log757("   VISIBLE: Shape1=" + TRANSFORM(loForm.shp_4c_Shape1.Visible) + ;
           " Label3=" + TRANSFORM(loForm.lbl_4c_Label3.Visible) + ;
           " Base=" + TRANSFORM(loForm.txt_4c_Base.Visible) + ;
           " DBase=" + TRANSFORM(loForm.txt_4c_DBase.Visible) + ;
           " Label1=" + TRANSFORM(loForm.lbl_4c_Label1.Visible) + ;
           " Nvl2=" + TRANSFORM(loForm.txt_4c_Nvl2.Visible) + ;
           " DNvl2=" + TRANSFORM(loForm.txt_4c_DNvl2.Visible))
    Log757("   ImgJpg segue oculta? " + TRANSFORM(PEMSTATUS(loForm, "img_4c_ImgJpg", 5)))

    loForm.Release()
    loForm = .NULL.
ENDIF

Log757("PROBE F5 task757 FIM")
QUIT

PROCEDURE Log757(pcTexto)
    STRTOFILE(pcTexto + CHR(13) + CHR(10), gcOut757, 1)
ENDPROC

PROCEDURE MedirObj757(poForm, pcNome)
    LOCAL loObj
    IF !PEMSTATUS(poForm, pcNome, 5)
        Log757("   [AUSENTE] " + pcNome)
        RETURN
    ENDIF
    loObj = EVALUATE("poForm." + pcNome)
    Log757("   " + PADR(pcNome, 16) + " cls=" + PADR(loObj.BaseClass, 13) + ;
        " Top=" + PADL(TRANSFORM(loObj.Top), 4) + ;
        " Left=" + PADL(TRANSFORM(loObj.Left), 4) + ;
        " W=" + PADL(TRANSFORM(loObj.Width), 4) + ;
        " H=" + PADL(TRANSFORM(loObj.Height), 4) + ;
        IIF(PEMSTATUS(loObj, "Caption", 5), " Cap=[" + loObj.Caption + "]", "") + ;
        IIF(PEMSTATUS(loObj, "ForeColor", 5), " Fore=" + TRANSFORM(loObj.ForeColor), "") + ;
        IIF(PEMSTATUS(loObj, "AutoSize", 5), " AutoSize=" + TRANSFORM(loObj.AutoSize), "") + ;
        IIF(PEMSTATUS(loObj, "TabIndex", 5), " TabIdx=" + TRANSFORM(loObj.TabIndex), ""))
ENDPROC
