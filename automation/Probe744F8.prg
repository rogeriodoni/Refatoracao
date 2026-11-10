*-- Probe744F8.prg - instancia FormSigOpGvt headless e le os observaveis.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE CK_FILE  "C:\4c\automation\probe744f8_ck.txt"
#DEFINE OUT_FILE "C:\4c\automation\probe744f8_out.txt"

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe744f8_dialogs.txt"

IF FILE(CK_FILE)
    DELETE FILE (CK_FILE)
ENDIF
IF FILE(OUT_FILE)
    DELETE FILE (OUT_FILE)
ENDIF
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

STRTOFILE("CK01 inicio" + CHR(13) + CHR(10), CK_FILE, 1)

CD C:\4c\projeto\app\start
DO config.prg
STRTOFILE("CK02 config.prg ok" + CHR(13) + CHR(10), CK_FILE, 1)

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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpGvtBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpGvt.prg") ADDITIVE
STRTOFILE("CK03 set procedure ok" + CHR(13) + CHR(10), CK_FILE, 1)

LOCAL loc_cR, loc_oPai, loc_oF, loc_oF2, loc_oF3, loc_nI, loc_o
loc_cR = ""

*-- Form "pai" falso, so para provar que o objeto eh repassado ao BO
loc_oPai = CREATEOBJECT("Custom")
loc_oPai.AddProperty("cMarca", "PAI-FALSO")
STRTOFILE("CK04 pai falso ok" + CHR(13) + CHR(10), CK_FILE, 1)

*-- 1) Chamada de 3 ARGUMENTOS (como no sigmvcab legado, Gaveta Serial)
loc_oF = CREATEOBJECT("FormSigOpGvt", "Gaveta Serial", loc_oPai, 7)
STRTOFILE("CK05 createobject 3 args ok" + CHR(13) + CHR(10), CK_FILE, 1)

loc_cR = loc_cR + "A01 VARTYPE(oForm)=[" + VARTYPE(loc_oF) + "]" + CHR(13) + CHR(10)
IF VARTYPE(loc_oF) != "O"
    STRTOFILE(loc_cR + "ABORTADO: CREATEOBJECT nao devolveu objeto" + CHR(13) + CHR(10), OUT_FILE)
    QUIT
ENDIF

loc_cR = loc_cR + "A02 BaseClass=[" + loc_oF.BaseClass + "] Caption=[" + loc_oF.Caption + "]" + CHR(13) + CHR(10)
loc_cR = loc_cR + "A03 Form WxH=" + TRANSFORM(loc_oF.Width) + "x" + TRANSFORM(loc_oF.Height) + ;
         " TitleBar=" + TRANSFORM(loc_oF.TitleBar) + " WindowType=" + TRANSFORM(loc_oF.WindowType) + ;
         " Closable=" + TRANSFORM(loc_oF.Closable) + " DataSession=" + TRANSFORM(loc_oF.DataSession) + CHR(13) + CHR(10)
loc_cR = loc_cR + "A04 ControlCount=" + TRANSFORM(loc_oF.ControlCount) + CHR(13) + CHR(10)

FOR loc_nI = 1 TO loc_oF.ControlCount
    loc_o = loc_oF.Controls(loc_nI)
    loc_cR = loc_cR + "A05." + TRANSFORM(loc_nI) + " " + PADR(loc_o.Name, 18) + ;
             " " + PADR(loc_o.BaseClass, 14) + ;
             " T=" + PADL(TRANSFORM(loc_o.Top), 4) + " L=" + PADL(TRANSFORM(loc_o.Left), 4) + ;
             " W=" + PADL(TRANSFORM(loc_o.Width), 5) + " H=" + PADL(TRANSFORM(loc_o.Height), 4) + ;
             " Vis=" + TRANSFORM(loc_o.Visible) + CHR(13) + CHR(10)
ENDFOR
STRTOFILE("CK06 inventario ok" + CHR(13) + CHR(10), CK_FILE, 1)

*-- Captions da faixa (o Init legado copia ThisForm.Caption nas DUAS labels)
loc_cR = loc_cR + "A06 lblSombra.Caption=[" + loc_oF.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption + "]" + ;
         " lblTitulo.Caption=[" + loc_oF.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption + "]" + CHR(13) + CHR(10)
loc_cR = loc_cR + "A07 lbl_4c_Mensagem.Caption=[" + loc_oF.lbl_4c_Mensagem.Caption + "]" + ;
         " AutoSize=" + TRANSFORM(loc_oF.lbl_4c_Mensagem.AutoSize) + ;
         " WxH=" + TRANSFORM(loc_oF.lbl_4c_Mensagem.Width) + "x" + TRANSFORM(loc_oF.lbl_4c_Mensagem.Height) + CHR(13) + CHR(10)

*-- Pictures: o arquivo EXISTE? (regra #25 - Picture inexistente falha em silencio)
loc_cR = loc_cR + "A08 Form.Picture=[" + loc_oF.Picture + "] FILE=" + TRANSFORM(FILE(loc_oF.Picture)) + CHR(13) + CHR(10)
loc_cR = loc_cR + "A09 img.Picture=[" + loc_oF.img_4c_Imagem.Picture + "] FILE=" + TRANSFORM(FILE(loc_oF.img_4c_Imagem.Picture)) + CHR(13) + CHR(10)
loc_cR = loc_cR + "A10 cmd.Picture=[" + loc_oF.cmd_4c_Ok.Picture + "] FILE=" + TRANSFORM(FILE(loc_oF.cmd_4c_Ok.Picture)) + CHR(13) + CHR(10)

*-- Botao: cabe na area do form (regra #30) e Cancel = .T. (unica saida)
loc_cR = loc_cR + "A11 cmd dir=" + TRANSFORM(loc_oF.cmd_4c_Ok.Left + loc_oF.cmd_4c_Ok.Width) + ;
         " base=" + TRANSFORM(loc_oF.cmd_4c_Ok.Top + loc_oF.cmd_4c_Ok.Height) + ;
         " Cancel=" + TRANSFORM(loc_oF.cmd_4c_Ok.Cancel) + ;
         " Caption=[" + loc_oF.cmd_4c_Ok.Caption + "]" + CHR(13) + CHR(10)

*-- Parametros repassados ao BO
loc_cR = loc_cR + "A12 BO.Impressora=[" + loc_oF.this_oBusinessObject.this_cImpressora + "]" + ;
         " BO.PortaSerial=" + TRANSFORM(loc_oF.this_oBusinessObject.this_nPortaSerial) + ;
         " BO.oFormulario=" + VARTYPE(loc_oF.this_oBusinessObject.this_oFormulario) + CHR(13) + CHR(10)
IF VARTYPE(loc_oF.this_oBusinessObject.this_oFormulario) = "O"
    loc_cR = loc_cR + "A13 BO.oFormulario.cMarca=[" + loc_oF.this_oBusinessObject.this_oFormulario.cMarca + "]" + CHR(13) + CHR(10)
ENDIF

*-- Visibilidade dos metodos chamados de FORA (regras #3 e #51): 2 = Protected
loc_cR = loc_cR + "A14 PEMSTATUS(oForm,CmdOkClick,2)=" + TRANSFORM(PEMSTATUS(loc_oF, "CmdOkClick", 2)) + CHR(13) + CHR(10)
loc_cR = loc_cR + "A15 PEMSTATUS(BO,VerificarStatusGaveta,2)=" + ;
         TRANSFORM(PEMSTATUS(loc_oF.this_oBusinessObject, "VerificarStatusGaveta", 2)) + CHR(13) + CHR(10)
STRTOFILE("CK07 asserts estaticos ok" + CHR(13) + CHR(10), CK_FILE, 1)

*-- 2) Exercita o Click. fChecarSerial AUSENTE POR DESENHO -> cai no CATCH ->
*--    MsgConfirma suprimido devolve .F. -> o dialogo PERMANECE aberto.
loc_oF.CmdOkClick()
STRTOFILE("CK08 CmdOkClick retornou" + CHR(13) + CHR(10), CK_FILE, 1)
loc_cR = loc_cR + "A16 pos-Click VARTYPE(oForm)=[" + VARTYPE(loc_oF) + "]" + CHR(13) + CHR(10)
IF VARTYPE(loc_oF) = "O"
    loc_cR = loc_cR + "A17 pos-Click Mensagem=[" + loc_oF.lbl_4c_Mensagem.Caption + "]" + CHR(13) + CHR(10)
ENDIF

*-- 3) Chamada de 2 ARGUMENTOS (como sigmvitn/sigmvits: porta OMITIDA)
loc_oF2 = CREATEOBJECT("FormSigOpGvt", "BEMATECH", loc_oPai)
STRTOFILE("CK09 createobject 2 args ok" + CHR(13) + CHR(10), CK_FILE, 1)
loc_cR = loc_cR + "A18 2args VARTYPE=[" + VARTYPE(loc_oF2) + "]" + CHR(13) + CHR(10)
IF VARTYPE(loc_oF2) = "O"
    loc_cR = loc_cR + "A19 2args BO.Impressora=[" + loc_oF2.this_oBusinessObject.this_cImpressora + "]" + ;
             " BO.PortaSerial=" + TRANSFORM(loc_oF2.this_oBusinessObject.this_nPortaSerial) + ;
             " VARTYPE=" + VARTYPE(loc_oF2.this_oBusinessObject.this_nPortaSerial) + CHR(13) + CHR(10)
    loc_oF2.Release()
ENDIF

*-- 4) Impressora NAO suportada: o DO CASE nao casa ramo nenhum, nao chama
*--    funcao de hardware e devolve .T. - o dialogo FECHA (igual ao legado)
loc_oF3 = CREATEOBJECT("FormSigOpGvt", "IMPRESSORA-INEXISTENTE", loc_oPai, 0)
IF VARTYPE(loc_oF3) = "O"
    loc_cR = loc_cR + "A20 semramo VerificarStatusGaveta()=" + ;
             TRANSFORM(loc_oF3.this_oBusinessObject.VerificarStatusGaveta()) + CHR(13) + CHR(10)
    loc_oF3.Release()
ENDIF
STRTOFILE("CK10 cenario sem ramo ok" + CHR(13) + CHR(10), CK_FILE, 1)

STRTOFILE(loc_cR + "FIM-OK" + CHR(13) + CHR(10), OUT_FILE)
STRTOFILE("CK11 fim" + CHR(13) + CHR(10), CK_FILE, 1)
QUIT
