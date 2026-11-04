SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF
SET DATE TO BRITISH
SET CENTURY ON
SET NULL ON

PUBLIC gc_4c_Log, gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_CaminhoIcones, gnConnHandle
gc_4c_Log           = "C:\4c\tasks\task704\logs\probe_f3.txt"
gb_4c_ModoTeste     = .T.
gb_4c_ValidandoUI   = .F.
gc_4c_CaminhoIcones = "C:\4c\vbmp\"
gnConnHandle        = -1

STRTOFILE("=== PROBE FASE 3 - FormSigOpClp ===" + CHR(13) + CHR(10), gc_4c_Log)

SET PROCEDURE TO ("C:\4c\projeto\app\utils\functions.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\utils\messages.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\businessbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\SigOpClpBO.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\classes\formbase.prg") ADDITIVE
SET PROCEDURE TO ("C:\4c\projeto\app\forms\operacionais\FormSigOpClp.prg") ADDITIVE

LOCAL loc_oPai, loc_oForm, loc_oErro, loc_oCnt, loc_oShp, loc_nI, loc_oSolto

TRY
    *-- Cursor que o form PAI entrega (mesma estrutura do probe da Fase 2)
    CREATE CURSOR cursor_4c_Operacoes ;
        (Emps C(3), Dopes C(20), MascNum C(10), Tipo C(10), Moeda C(3), Valos N(12,2), Datas T NULL)
    INDEX ON Emps + Dopes + MascNum TAG Num
    INDEX ON Datas TAG Datas
    INSERT INTO cursor_4c_Operacoes (Emps, Dopes, MascNum, Tipo, Moeda, Valos, Datas) ;
        VALUES ("001", "MALOTE", "0000000001", "Origem", "USD", 250.00, {^2026-09-25 00:00:00})

    *-- Duble do form PAI (FormSigOpCcl)
    loc_oPai = CREATEOBJECT("PaiFalso")

    STRTOFILE("0) Pai falso..........: " + VARTYPE(loc_oPai) + ;
        "  Enabled=" + TRANSFORM(loc_oPai.Enabled) + CHR(13) + CHR(10), gc_4c_Log, 1)

    *-- O pai se desabilita ANTES de abrir, igual a FormSigOpCcl.BtnConsultaClick
    loc_oPai.Enabled = .F.

    *-- 1) Instanciacao COM os dois parametros do legado
    loc_oForm = CREATEOBJECT("FormSigOpClp", loc_oPai, 1)

    STRTOFILE("1) Instanciou form....: " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), gc_4c_Log, 1)

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("   *** FALHOU: CREATEOBJECT nao devolveu objeto ***" + CHR(13) + CHR(10), gc_4c_Log, 1)
    ELSE
        STRTOFILE("   Width/Height.......: " + TRANSFORM(loc_oForm.Width) + " x " + ;
            TRANSFORM(loc_oForm.Height) + "  (esperado 700 x 400)" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   DataSession........: " + TRANSFORM(loc_oForm.DataSession) + ;
            "  DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   WindowType/TitleBar: " + TRANSFORM(loc_oForm.WindowType) + " / " + ;
            TRANSFORM(loc_oForm.TitleBar) + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   AlwaysOnTop........: " + TRANSFORM(loc_oForm.AlwaysOnTop) + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   Picture............: [" + loc_oForm.Picture + "]  existe=" + ;
            TRANSFORM(FILE(loc_oForm.Picture)) + CHR(13) + CHR(10), gc_4c_Log, 1)

        *-- 2) Caption montado a partir do PAI (Init do legado)
        STRTOFILE("2) Caption............: [" + loc_oForm.Caption + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   BO parametros......: grupo=[" + loc_oForm.this_oBusinessObject.this_cGrupo + ;
            "] conta=[" + loc_oForm.this_oBusinessObject.this_cConta + ;
            "] dconta=[" + loc_oForm.this_oBusinessObject.this_cDConta + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   DatSes guardado....: " + TRANSFORM(loc_oForm.this_nDataSessionPai) + CHR(13) + CHR(10), gc_4c_Log, 1)

        *-- 3) Cabecalho
        STRTOFILE("3) cnt_4c_Cabecalho...: " + TRANSFORM(PEMSTATUS(loc_oForm, "cnt_4c_Cabecalho", 5)) + CHR(13) + CHR(10), gc_4c_Log, 1)
        loc_oCnt = loc_oForm.cnt_4c_Cabecalho
        STRTOFILE("   Top/Left/W/H.......: " + TRANSFORM(loc_oCnt.Top) + "/" + TRANSFORM(loc_oCnt.Left) + ;
            "/" + TRANSFORM(loc_oCnt.Width) + "/" + TRANSFORM(loc_oCnt.Height) + ;
            "  (esperado 0/0/700/80)" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   BackColor/BackStyle: " + TRANSFORM(loc_oCnt.BackColor) + " / " + ;
            TRANSFORM(loc_oCnt.BackStyle) + "  (RGB(100,100,100)=" + ;
            TRANSFORM(RGB(100,100,100)) + ")" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   Visible............: " + TRANSFORM(loc_oCnt.Visible) + CHR(13) + CHR(10), gc_4c_Log, 1)

        STRTOFILE("   lbl_4c_Sombra  cap=[" + loc_oCnt.lbl_4c_Sombra.Caption + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("     T/L/W/H/AutoSize.: " + TRANSFORM(loc_oCnt.lbl_4c_Sombra.Top) + "/" + ;
            TRANSFORM(loc_oCnt.lbl_4c_Sombra.Left) + "/" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.Width) + "/" + ;
            TRANSFORM(loc_oCnt.lbl_4c_Sombra.Height) + "/" + TRANSFORM(loc_oCnt.lbl_4c_Sombra.AutoSize) + ;
            "  (esperado 25/10/680/40/.F.)" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("     ForeColor/Visible: " + TRANSFORM(loc_oCnt.lbl_4c_Sombra.ForeColor) + " / " + ;
            TRANSFORM(loc_oCnt.lbl_4c_Sombra.Visible) + CHR(13) + CHR(10), gc_4c_Log, 1)

        STRTOFILE("   lbl_4c_Titulo  cap=[" + loc_oCnt.lbl_4c_Titulo.Caption + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("     T/L/W/H/AutoSize.: " + TRANSFORM(loc_oCnt.lbl_4c_Titulo.Top) + "/" + ;
            TRANSFORM(loc_oCnt.lbl_4c_Titulo.Left) + "/" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.Width) + "/" + ;
            TRANSFORM(loc_oCnt.lbl_4c_Titulo.Height) + "/" + TRANSFORM(loc_oCnt.lbl_4c_Titulo.AutoSize) + ;
            "  (esperado 24/10/680/46/.F.)" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("     ForeColor/Visible: " + TRANSFORM(loc_oCnt.lbl_4c_Titulo.ForeColor) + " / " + ;
            TRANSFORM(loc_oCnt.lbl_4c_Titulo.Visible) + "  (branco=" + TRANSFORM(RGB(255,255,255)) + ")" + CHR(13) + CHR(10), gc_4c_Log, 1)

        *-- 4) Moldura
        STRTOFILE("4) shp_4c_Historico...: " + TRANSFORM(PEMSTATUS(loc_oForm, "shp_4c_Historico", 5)) + CHR(13) + CHR(10), gc_4c_Log, 1)
        loc_oShp = loc_oForm.shp_4c_Historico
        STRTOFILE("   Top/Left/W/H.......: " + TRANSFORM(loc_oShp.Top) + "/" + TRANSFORM(loc_oShp.Left) + ;
            "/" + TRANSFORM(loc_oShp.Width) + "/" + TRANSFORM(loc_oShp.Height) + ;
            "  (esperado 102/42/580/247)" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   BackStyle/SpecialEf: " + TRANSFORM(loc_oShp.BackStyle) + " / " + ;
            TRANSFORM(loc_oShp.SpecialEffect) + "  Visible=" + TRANSFORM(loc_oShp.Visible) + CHR(13) + CHR(10), gc_4c_Log, 1)

        *-- 5) Nenhum PageFrame inventado + z-order
        STRTOFILE("5) ControlCount.......: " + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10), gc_4c_Log, 1)
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            STRTOFILE("   [" + TRANSFORM(loc_nI) + "] " + loc_oForm.Controls(loc_nI).Name + ;
                "  (" + loc_oForm.Controls(loc_nI).BaseClass + ")" + CHR(13) + CHR(10), gc_4c_Log, 1)
        ENDFOR

        *-- 6) O cursor do pai eh alcancavel desta tela (DataSession = 1)
        STRTOFILE("6) USED(cursor pai)...: " + TRANSFORM(USED("cursor_4c_Operacoes")) + ;
            "  RECCOUNT=" + TRANSFORM(IIF(USED("cursor_4c_Operacoes"), RECCOUNT("cursor_4c_Operacoes"), -1)) + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   BO.CursorPronto....: " + TRANSFORM(loc_oForm.this_oBusinessObject.CursorPronto()) + CHR(13) + CHR(10), gc_4c_Log, 1)

        *-- 7) Destroy reabilita o pai
        STRTOFILE("7) Pai.Enabled ANTES.: " + TRANSFORM(loc_oPai.Enabled) + "  (deve ser .F.)" + CHR(13) + CHR(10), gc_4c_Log, 1)
        loc_oForm.Release()
        loc_oForm = .NULL.
        STRTOFILE("   Pai.Enabled DEPOIS.: " + TRANSFORM(loc_oPai.Enabled) + "  (deve ser .T.)" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   cursor sobreviveu..: " + TRANSFORM(USED("cursor_4c_Operacoes")) + "  (deve ser .T. - eh do pai)" + CHR(13) + CHR(10), gc_4c_Log, 1)
    ENDIF

    *-- 8) Instanciacao SEM parametros (harness / validacao de UI)
    loc_oSolto = CREATEOBJECT("FormSigOpClp")
    STRTOFILE("8) Sem parametros.....: " + VARTYPE(loc_oSolto) + CHR(13) + CHR(10), gc_4c_Log, 1)
    IF VARTYPE(loc_oSolto) = "O"
        STRTOFILE("   Caption fallback...: [" + loc_oSolto.Caption + "]" + CHR(13) + CHR(10), gc_4c_Log, 1)
        STRTOFILE("   cabecalho ok.......: " + TRANSFORM(PEMSTATUS(loc_oSolto, "cnt_4c_Cabecalho", 5)) + CHR(13) + CHR(10), gc_4c_Log, 1)
        loc_oSolto.Release()
        loc_oSolto = .NULL.
    ENDIF

    STRTOFILE("=== FIM OK ===" + CHR(13) + CHR(10), gc_4c_Log, 1)

CATCH TO loc_oErro
    STRTOFILE("*** ERRO: " + loc_oErro.Message + CHR(13) + CHR(10) + ;
        "    Linha...: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10) + ;
        "    Proc....: " + loc_oErro.Procedure + CHR(13) + CHR(10) + ;
        "    Detalhe.: " + loc_oErro.Details + CHR(13) + CHR(10), gc_4c_Log, 1)
ENDTRY

QUIT


*-- Duble do form PAI (FormSigOpCcl): so o que LerParametrosDoFormPai alcanca
DEFINE CLASS PaiFalso AS Form
    PROCEDURE Init()
        THIS.AddObject("cnt_4c_Origem", "Container")
        THIS.cnt_4c_Origem.AddObject("txt_4c_Grupo", "TextBox")
        THIS.cnt_4c_Origem.AddObject("txt_4c_Conta", "TextBox")
        THIS.cnt_4c_Origem.AddObject("txt_4c_DConta", "TextBox")
        THIS.cnt_4c_Origem.txt_4c_Grupo.Value  = "10        "
        THIS.cnt_4c_Origem.txt_4c_Conta.Value  = "1101      "
        THIS.cnt_4c_Origem.txt_4c_DConta.Value = "GAVETA - LOJA 001        "
        RETURN .T.
    ENDPROC
ENDDEFINE
