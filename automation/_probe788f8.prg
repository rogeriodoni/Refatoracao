*==============================================================================
* _probe788f8.prg - Probe de runtime do FormSigOpPrL (Fase 8 / task788)
* Descartavel. NAO chama ConfigurarAmbiente() (bloqueia nesta maquina).
* Usa STUB de SigOpPrLBO: o SQL Server 192.168.200.10 eh inalcancavel aqui.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOGF "C:\4c\automation\_probe788f8.txt"

LOCAL loc_oForm, loc_oErro, loc_oPai, loc_cArq, loc_cOrig, loc_cGrav, loc_nMarc

STRTOFILE("PROBE 788 F8 INICIO " + TTOC(DATETIME()) + CHR(13) + CHR(10), LOGF)

DO config.prg
SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + gc_4c_CaminhoUtils + ;
             "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpPrL.prg") ADDITIVE
=STRTOFILE("CK01 ambiente OK" + CHR(13) + CHR(10), LOGF, 1)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe788f8_erros.txt"
gc_4c_UsuarioLogado    = "PROBE788"

*-- Cursor de selecao que o form CHAMADOR deixa aberto (legado: LocalBusLin)
CREATE CURSOR cursor_4c_BusLin ( ;
    Selecao L, DPros C(60), PVens N(14,2), MoeVs C(3), ;
    Sqtds N(14,3), CPros C(20), CGrus C(3))
INSERT INTO cursor_4c_BusLin (Selecao, DPros, PVens, MoeVs, Sqtds, CPros, CGrus) ;
    VALUES (.F., "PRODUTO UM", 10.50, "R$", 3.000, "P001", "G01")
INSERT INTO cursor_4c_BusLin (Selecao, DPros, PVens, MoeVs, Sqtds, CPros, CGrus) ;
    VALUES (.F., "PRODUTO DOIS", 22.00, "R$", 7.000, "P002", "G02")
GO TOP IN cursor_4c_BusLin
=STRTOFILE("CK02 cursor_4c_BusLin reccount=" + TRANSFORM(RECCOUNT("cursor_4c_BusLin")) + CHR(13) + CHR(10), LOGF, 1)

*-- Figura CRUA (bytes de JPG), como o FormLin grava em SigCdLin.figjpgs
loc_cOrig = FILETOSTR("C:\4c\vbmp\acsp_70.jpg")
=STRTOFILE("CK03 figura origem bytes=" + TRANSFORM(LEN(loc_cOrig)) + CHR(13) + CHR(10), LOGF, 1)

*-- Form PAI falso, so para medir Enabled
loc_oPai = CREATEOBJECT("Form")
loc_oPai.Enabled = .T.

loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSigOpPrL", loc_oPai, "LIN788", .NULL.)
    =STRTOFILE("CK04 CREATEOBJECT VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), LOGF, 1)
CATCH TO loc_oErro
    =STRTOFILE("CK04 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10), LOGF, 1)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    =STRTOFILE("CK05 Caption=[" + loc_oForm.Caption + "] W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height) + " DataSession=" + TRANSFORM(loc_oForm.DataSession) + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK06 pai desabilitado=" + TRANSFORM(loc_oPai.Enabled) + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK07 cabecalho titulo=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + ;
        "] sombra=[" + loc_oForm.cnt_4c_Sombra.lbl_4c_LblSombra.Caption + "]" + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK08 lblLinha=[" + loc_oForm.lbl_4c_LblLinha.Caption + "] imgVisible=" + ;
        TRANSFORM(loc_oForm.img_4c_ImgLinhas.Visible) + CHR(13) + CHR(10), LOGF, 1)

    loc_cArq  = loc_oForm.img_4c_ImgLinhas.Picture
    loc_cGrav = IIF(FILE(loc_cArq), FILETOSTR(loc_cArq), "")
    =STRTOFILE("CK09 figura gravados=" + TRANSFORM(LEN(loc_cGrav)) + " origem=" + ;
        TRANSFORM(LEN(loc_cOrig)) + " IDENTICA=" + IIF(loc_cGrav == loc_cOrig, "SIM", "NAO") + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK10 grid ColumnCount=" + TRANSFORM(loc_oForm.grd_4c_Dados.ColumnCount) + ;
        " RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
        " CurrentControl=[" + loc_oForm.grd_4c_Dados.Column1.CurrentControl + "]" + ;
        " Sparse=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Sparse) + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK11 ControlSource C1=[" + loc_oForm.grd_4c_Dados.Column1.ControlSource + ;
        "] C2=[" + loc_oForm.grd_4c_Dados.Column2.ControlSource + ;
        "] C7=[" + loc_oForm.grd_4c_Dados.Column7.ControlSource + "]" + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK12 widths=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.Width) + "/" + ;
        TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + "/" + ;
        TRANSFORM(loc_oForm.grd_4c_Dados.Column7.Width) + ;
        " captions=[" + loc_oForm.grd_4c_Dados.Column2.Header1.Caption + "][" + ;
        loc_oForm.grd_4c_Dados.Column6.Header1.Caption + "]" + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK13 fonte grid=[" + loc_oForm.grd_4c_Dados.FontName + "/" + ;
        TRANSFORM(loc_oForm.grd_4c_Dados.FontSize) + "] HeaderHeight=" + ;
        TRANSFORM(loc_oForm.grd_4c_Dados.HeaderHeight) + " RowHeight=" + ;
        TRANSFORM(loc_oForm.grd_4c_Dados.RowHeight) + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK14 ReadOnly C1=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column1.ReadOnly) + ;
        " C2=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.ReadOnly) + ;
        " C7=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column7.ReadOnly) + CHR(13) + CHR(10), LOGF, 1)

    =STRTOFILE("CK15 botao=[" + loc_oForm.cmg_4c_Saida.Buttons(1).Caption + "] ButtonCount=" + ;
        TRANSFORM(loc_oForm.cmg_4c_Saida.ButtonCount) + " Picture existe=" + ;
        IIF(FILE(loc_oForm.cmg_4c_Saida.Buttons(1).Picture), "SIM", "NAO") + ;
        " headerpic existe=" + IIF(FILE(loc_oForm.grd_4c_Dados.Column1.Header1.Picture), "SIM", "NAO") + CHR(13) + CHR(10), LOGF, 1)

    *-- Marcar tudo / desmarcar tudo (Column1.Header1.Click do legado)
    loc_oForm.HeaderSelecaoClick()
    SELECT cursor_4c_BusLin
    COUNT TO loc_nMarc FOR Selecao
    =STRTOFILE("CK16 marcar tudo -> marcados=" + TRANSFORM(loc_nMarc) + " Tag=[" + ;
        loc_oForm.grd_4c_Dados.Column1.Header1.Tag + "]" + CHR(13) + CHR(10), LOGF, 1)

    loc_oForm.HeaderSelecaoClick()
    SELECT cursor_4c_BusLin
    COUNT TO loc_nMarc FOR Selecao
    =STRTOFILE("CK17 desmarcar tudo -> marcados=" + TRANSFORM(loc_nMarc) + " Tag=[" + ;
        loc_oForm.grd_4c_Dados.Column1.Header1.Tag + "]" + CHR(13) + CHR(10), LOGF, 1)

    *-- Alternar a linha corrente (CheckBox da Column1)
    GO TOP IN cursor_4c_BusLin
    loc_oForm.ChkSelecaoKeyPress(13, 0)
    =STRTOFILE("CK18 alternar linha1 -> Selecao=" + TRANSFORM(cursor_4c_BusLin.Selecao) + CHR(13) + CHR(10), LOGF, 1)
    loc_oForm.ChkSelecaoKeyPress(32, 0)
    =STRTOFILE("CK19 alternar de novo -> Selecao=" + TRANSFORM(cursor_4c_BusLin.Selecao) + CHR(13) + CHR(10), LOGF, 1)
    loc_oForm.ChkSelecaoKeyPress(65, 0)
    =STRTOFILE("CK20 tecla nao-toggle ignorada -> Selecao=" + TRANSFORM(cursor_4c_BusLin.Selecao) + CHR(13) + CHR(10), LOGF, 1)

    *-- CarregarLista idempotente (CheckBox e larguras sobrevivem)
    =STRTOFILE("CK21 CarregarLista repetido=" + TRANSFORM(loc_oForm.CarregarLista()) + ;
        " CurrentControl=[" + loc_oForm.grd_4c_Dados.Column1.CurrentControl + "]" + ;
        " C2.Width=" + TRANSFORM(loc_oForm.grd_4c_Dados.Column2.Width) + CHR(13) + CHR(10), LOGF, 1)

    *-- Escopo: 2 = PROTECTED. Metodos chamados de fora (BINDEVENT/harness)
    *-- tem de devolver .F. aqui.
    =STRTOFILE("CK22 PROTECTED? CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2)) + ;
        " HeaderSelecaoClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"HeaderSelecaoClick",2)) + ;
        " FocarCheckboxSelecao=" + TRANSFORM(PEMSTATUS(loc_oForm,"FocarCheckboxSelecao",2)) + ;
        " ChkSelecaoKeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm,"ChkSelecaoKeyPress",2)) + ;
        " ChkSelecaoClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"ChkSelecaoClick",2)) + ;
        " ChkSelecaoMouseUp=" + TRANSFORM(PEMSTATUS(loc_oForm,"ChkSelecaoMouseUp",2)) + ;
        " BtnEncerrarClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnEncerrarClick",2)) + ;
        " CmdBotoesClick=" + TRANSFORM(PEMSTATUS(loc_oForm,"CmdBotoesClick",2)) + CHR(13) + CHR(10), LOGF, 1)

    *-- Encerrar pelo dispatcher do CommandGroup: reabilita o pai e libera
    loc_oForm.CmdBotoesClick(1)
    =STRTOFILE("CK23 Encerrar -> pai reabilitado=" + TRANSFORM(loc_oPai.Enabled) + ;
        " formVartype=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), LOGF, 1)
ENDIF

=STRTOFILE("FIM" + CHR(13) + CHR(10), LOGF, 1)
QUIT

*==============================================================================
* STUB do BO - substitui SigOpPrLBO.prg (que NAO eh carregado por SET
* PROCEDURE neste probe), para o form nao depender do SQL Server.
*==============================================================================
DEFINE CLASS SigOpPrLBO AS BusinessBase
    this_cCodigoLinha    = ""
    this_cDescricaoLinha = ""
    this_cFiguraLinha    = ""

    PROCEDURE BuscarLinha(par_cCodigoLinha)
        THIS.this_cCodigoLinha    = ALLTRIM(par_cCodigoLinha)
        THIS.this_cDescricaoLinha = "LINHA DE TESTE 788"
        THIS.this_cFiguraLinha    = FILETOSTR("C:\4c\vbmp\acsp_70.jpg")
        RETURN .T.
    ENDPROC
ENDDEFINE
