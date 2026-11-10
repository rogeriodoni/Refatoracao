SET SAFETY OFF
SET RESOURCE OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste   = .T.
gb_4c_ValidandoUI = .F.
gnConnHandle      = -1
gc_4c_UsuarioLogado = "PROBE"

LOCAL loc_cOut, loc_cArq, loForm, loPai, loErr
loc_cArq = "C:\4c\automation\probeF8_756.txt"
loc_cOut = ""
STRTOFILE("CK00 inicio" + CHR(13) + CHR(10), loc_cArq)

DO config.prg
STRTOFILE("CK01 config.prg ok" + CHR(13) + CHR(10), loc_cArq, 1)

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpLbCBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpLbC.prg") ADDITIVE
STRTOFILE("CK02 dependencias carregadas" + CHR(13) + CHR(10), loc_cArq, 1)

loPai = CREATEOBJECT("Form")      && form pai falso (contexto so eh guardado)

TRY
    loForm = CREATEOBJECT("FormSigOpLbC", loPai, "VENDA", .NULL.)
CATCH TO loErr
    STRTOFILE("CKERR CREATEOBJECT: " + loErr.Message + " LN=" + ;
        TRANSFORM(loErr.LineNo) + " PROC=" + loErr.Procedure + CHR(13) + CHR(10), loc_cArq, 1)
ENDTRY
STRTOFILE("CK03 VARTYPE(loForm) = " + VARTYPE(loForm) + CHR(13) + CHR(10), loc_cArq, 1)

IF VARTYPE(loForm) = "O"
    loc_cOut = loc_cOut + "P1 Caption .................... [" + loForm.Caption + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P2 Width/Height ............... " + TRANSFORM(loForm.Width) + ;
               " x " + TRANSFORM(loForm.Height) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P3 ControlCount ............... " + TRANSFORM(loForm.ControlCount) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P4 CarregarLista eh PUBLIC? ... " + ;
               TRANSFORM(!PEMSTATUS(loForm, "CarregarLista", 2)) + CHR(13) + CHR(10)

    *-- O funil, chamado DE FORA da classe (como o harness faz)
    loc_cOut = loc_cOut + "P5 CarregarLista() ............ " + ;
               TRANSFORM(loForm.CarregarLista()) + CHR(13) + CHR(10)

    loc_cOut = loc_cOut + "P6 Grade RecordSource ......... [" + ;
               loForm.grd_4c_Dados.RecordSource + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P7 ColumnCount / ControlSource  " + ;
               TRANSFORM(loForm.grd_4c_Dados.ColumnCount) + " | [" + ;
               loForm.grd_4c_Dados.Column1.ControlSource + "] [" + ;
               loForm.grd_4c_Dados.Column2.ControlSource + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P8 Column Width / Header ...... " + ;
               TRANSFORM(loForm.grd_4c_Dados.Column1.Width) + "/" + ;
               TRANSFORM(loForm.grd_4c_Dados.Column2.Width) + " | [" + ;
               ALLTRIM(loForm.grd_4c_Dados.Column1.Header1.Caption) + "] [" + ;
               ALLTRIM(loForm.grd_4c_Dados.Column2.Header1.Caption) + "]" + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P9 TabIndex grd / cmd / cnt ... " + ;
               TRANSFORM(loForm.grd_4c_Dados.TabIndex) + " / " + ;
               TRANSFORM(loForm.cmd_4c_Ok.TabIndex) + " / " + ;
               TRANSFORM(loForm.cnt_4c_Sombra.TabIndex) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P10 TabStop dos 9 TextBox ..... " + ;
               TRANSFORM(loForm.txt_4c__moeda.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__cotacao.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__limcred.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__PendOutr.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__pendente.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__chqpend.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__contac.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__cheque.TabStop) + " " + ;
               TRANSFORM(loForm.txt_4c__disponivel.TabStop) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P11 AtualizarCamposComposicao() " + ;
               TRANSFORM(loForm.AtualizarCamposComposicao()) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P12 CarregarDados() ........... " + ;
               TRANSFORM(loForm.CarregarDados()) + CHR(13) + CHR(10)
    loc_cOut = loc_cOut + "P13 cursor da grade USED? ..... " + ;
               TRANSFORM(USED("cursor_4c_Operacoes")) + " reccount=" + ;
               TRANSFORM(IIF(USED("cursor_4c_Operacoes"), RECCOUNT("cursor_4c_Operacoes"), -1)) + ;
               CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cArq, 1)
    loForm.Release()
    STRTOFILE("CK99 Release ok" + CHR(13) + CHR(10), loc_cArq, 1)
ENDIF
QUIT
