*-- medir_fase5_sigprimp.prg
*-- (1) Mede a largura REAL do texto do label "Arquivos Importacao :" em
*--     Tahoma 8 bold, para conferir se .Width = 125 nao corta a legenda
*--     (regra #23 - AutoSize eh no-op em Label criado por AddObject).
*-- (2) Instancia o FormSIGPRIMP carregando SO a cadeia dele (sem
*--     ConfigurarAmbiente, que trava o VFP9 headless) e dumpa os controles.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET CONSOLE OFF

LOCAL loc_cSaida, loc_cBase, loc_cTexto, loc_nLarg, loc_oForm, loc_nI, loc_oObj

loc_cSaida = ""
loc_cBase  = "C:\4c\projeto\app\"

*-- (1) MEDICAO DA LARGURA DO TEXTO -------------------------------------------
loc_cTexto = "Arquivos Importa" + CHR(231) + CHR(227) + "o :"

*-- Form invisivel so para hospedar um Label com a fonte certa
loc_oForm = CREATEOBJECT("Form")
loc_oForm.AddObject("lblM", "Label")
WITH loc_oForm.lblM
    .FontName = "Tahoma"
    .FontSize = 8
    .FontBold = .T.
    .AutoSize = .T.
    .Caption  = loc_cTexto
ENDWITH
loc_cSaida = loc_cSaida + "[1] MEDICAO DO LABEL" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "    Caption          : [" + loc_cTexto + "] (" + ;
    ALLTRIM(STR(LEN(loc_cTexto))) + " chars)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "    AutoSize=.T. Width: " + ;
    ALLTRIM(STR(loc_oForm.lblM.Width)) + "  (regra #23: no-op => fica no default)" + CHR(13) + CHR(10)

*-- TXTWIDTH mede em unidades de caractere da fonte corrente do form
loc_oForm.FontName = "Tahoma"
loc_oForm.FontSize = 8
loc_oForm.FontBold = .T.
loc_nLarg = TXTWIDTH(loc_cTexto, "Tahoma", 8, "B") * FONTMETRIC(6, "Tahoma", 8, "B")
loc_cSaida = loc_cSaida + "    TXTWIDTH*FONTMETRIC: " + ALLTRIM(STR(loc_nLarg, 10, 2)) + " px" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "    .Width atual no prg: 125" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "    Vao ate o TextBox  : 130 (Say4.Left=310 -> Get_Arquivo.Left=440)" + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "    CORTA com 125?     : " + IIF(loc_nLarg > 125, "SIM", "nao") + CHR(13) + CHR(10)
loc_cSaida = loc_cSaida + "    CORTA com 130?     : " + IIF(loc_nLarg > 130, "SIM", "nao") + CHR(13) + CHR(10)
loc_oForm.Release()
loc_oForm = .NULL.

*-- (2) INSTANCIACAO DO FORM --------------------------------------------------
PUBLIC gc_4c_CaminhoBase, gc_4c_CaminhoClasses, gc_4c_CaminhoUtils
PUBLIC gc_4c_CaminhoForms, gc_4c_CaminhoIcones, gc_4c_CaminhoReports
PUBLIC gc_4c_CaminhoFramework, gc_4c_UsuarioLogado, gnConnHandle
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste, go_4c_Sistema

gc_4c_CaminhoBase      = loc_cBase + "start"
gc_4c_CaminhoClasses   = loc_cBase + "classes\"
gc_4c_CaminhoUtils     = loc_cBase + "utils\"
gc_4c_CaminhoForms     = loc_cBase + "forms\"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = loc_cBase + "reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado    = "TESTE"
gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\logs\medir_fase5_erros.txt"

SET PATH TO (gc_4c_CaminhoUtils + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoForms + "," + loc_cBase + "forms\operacionais\")

SET PROCEDURE TO (gc_4c_CaminhoUtils + "functions.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "messages.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "validators.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGPRIMPBO.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "forms\FormErro.prg") ADDITIVE
SET PROCEDURE TO (loc_cBase + "forms\operacionais\FormSIGPRIMP.prg") ADDITIVE

loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "[2] INSTANCIACAO" + CHR(13) + CHR(10)
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("FormSIGPRIMP")
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "    EXCECAO: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    loc_cSaida = loc_cSaida + "    CREATEOBJECT     : OK" + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    BaseClass        : [" + loc_oForm.BaseClass + "]" + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    Caption          : [" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    Width x Height   : " + ALLTRIM(STR(loc_oForm.Width)) + ;
        " x " + ALLTRIM(STR(loc_oForm.Height)) + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    ControlCount     : " + ALLTRIM(STR(loc_oForm.ControlCount)) + CHR(13) + CHR(10)
    FOR loc_nI = 1 TO loc_oForm.ControlCount
        loc_oObj = loc_oForm.Controls(loc_nI)
        loc_cSaida = loc_cSaida + "      - " + PADR(loc_oObj.Name, 20) + ;
            PADR(loc_oObj.BaseClass, 15) + ;
            "L=" + PADL(TRANSFORM(loc_oObj.Left), 5) + ;
            " T=" + PADL(TRANSFORM(loc_oObj.Top), 5) + ;
            " W=" + PADL(TRANSFORM(loc_oObj.Width), 5) + ;
            " H=" + PADL(TRANSFORM(loc_oObj.Height), 5) + ;
            " Vis=" + TRANSFORM(loc_oObj.Visible) + CHR(13) + CHR(10)
    ENDFOR
    loc_cSaida = loc_cSaida + "    lbl_4c_Label4.Width (efetivo): " + ;
        TRANSFORM(loc_oForm.lbl_4c_Label4.Width) + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    txt_4c_Arquivo.ReadOnly      : " + ;
        TRANSFORM(loc_oForm.txt_4c_Arquivo.ReadOnly) + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    txt_4c_Arquivo.TabIndex      : " + ;
        TRANSFORM(loc_oForm.txt_4c_Arquivo.TabIndex) + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    obj_4c_Arquivos.TabIndex     : " + ;
        TRANSFORM(loc_oForm.obj_4c_Arquivos.TabIndex) + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    obj_4c_Arquivos.RowSourceType: " + ;
        TRANSFORM(loc_oForm.obj_4c_Arquivos.RowSourceType) + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    cmd_4c_Visualizar.Visible    : " + ;
        TRANSFORM(loc_oForm.cmd_4c_Visualizar.Visible) + " (legado: .F. sempre)" + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    cmd_4c_Imprimir.Visible      : " + ;
        TRANSFORM(loc_oForm.cmd_4c_Imprimir.Visible) + " (legado: .F. sempre)" + CHR(13) + CHR(10)
    loc_cSaida = loc_cSaida + "    cnt_4c_Sombra.lbl_4c_LblTitulo.Caption: [" + ;
        loc_oForm.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption + "]" + CHR(13) + CHR(10)
    loc_oForm.Release()
ELSE
    loc_cSaida = loc_cSaida + "    CREATEOBJECT     : FALHOU (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
ENDIF

STRTOFILE(loc_cSaida, "C:\4c\automation\medir_fase5_sigprimp_result.txt")
SET CONSOLE ON
QUIT
