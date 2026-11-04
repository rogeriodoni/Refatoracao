*-- ProbeTask717F3.prg - instanciacao do FormSigOpCts (Fase 3 da task717)
SET SAFETY OFF
SET RESOURCE OFF

LOCAL loc_cOut, loc_cLog
loc_cOut = "C:\4c\automation\probe_task717_f3.txt"
loc_cLog = ""

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_task717_f3_erro.txt"
gb_4c_ValidandoUI      = .T.
gnConnHandle           = 0

DO ("C:\4c\projeto\app\start\config.prg")

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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpCtsBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCts.prg") ADDITIVE

loc_cLog = loc_cLog + "[SETUP] config + SET PROCEDURE OK" + CHR(13) + CHR(10)

*-- Cenario 1: modo CONSULTA (_Altera = .F.), alias omitido -> BO aplica default
LOCAL loc_oF1
loc_oF1 = .NULL.
TRY
    loc_oF1 = CREATEOBJECT("FormSigOpCts", "11101", .F.)
CATCH TO loc_oE
    loc_cLog = loc_cLog + "[C1] EXCECAO: " + loc_oE.Message + " LN=" + ;
        TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cLog = loc_cLog + "[C1] VARTYPE        = " + VARTYPE(loc_oF1) + CHR(13) + CHR(10)
IF VARTYPE(loc_oF1) = "O"
    loc_cLog = loc_cLog + "[C1] Width/Height   = " + TRANSFORM(loc_oF1.Width) + " x " + ;
        TRANSFORM(loc_oF1.Height) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] DataSession    = " + TRANSFORM(loc_oF1.DataSession) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] WindowType     = " + TRANSFORM(loc_oF1.WindowType) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] TitleBar       = " + TRANSFORM(loc_oF1.TitleBar) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] Closable       = " + TRANSFORM(loc_oF1.Closable) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] MaxButton      = " + TRANSFORM(loc_oF1.MaxButton) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] Picture        = [" + loc_oF1.Picture + "]" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] PictureEXISTE  = " + TRANSFORM(FILE(loc_oF1.Picture)) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] ControlCount   = " + TRANSFORM(loc_oF1.ControlCount) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] BO VARTYPE     = " + VARTYPE(loc_oF1.this_oBusinessObject) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] this_cArquivo  = [" + loc_oF1.this_cArquivo + "]" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] this_cTitulo   = [" + loc_oF1.this_cTitulo + "]" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] this_lAltera   = " + TRANSFORM(loc_oF1.this_lAltera) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C1] ObterResultado = " + TRANSFORM(loc_oF1.ObterResultado()) + CHR(13) + CHR(10)

    *-- faixa do cabecalho
    loc_cLog = loc_cLog + "[C1] cnt_4c_Sombra  = " + ;
        TRANSFORM(PEMSTATUS(loc_oF1, "cnt_4c_Sombra", 5)) + CHR(13) + CHR(10)
    IF PEMSTATUS(loc_oF1, "cnt_4c_Sombra", 5)
        WITH loc_oF1.cnt_4c_Sombra
            loc_cLog = loc_cLog + "[C1]   cnt T/L/W/H  = " + TRANSFORM(.Top) + "/" + ;
                TRANSFORM(.Left) + "/" + TRANSFORM(.Width) + "/" + TRANSFORM(.Height) + CHR(13) + CHR(10)
            loc_cLog = loc_cLog + "[C1]   cnt BackColor= " + TRANSFORM(.BackColor) + ;
                " (esperado " + TRANSFORM(RGB(100,100,100)) + ")" + CHR(13) + CHR(10)
            loc_cLog = loc_cLog + "[C1]   cnt Visible  = " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
            loc_cLog = loc_cLog + "[C1]   cnt Controls = " + TRANSFORM(.ControlCount) + CHR(13) + CHR(10)
        ENDWITH
        WITH loc_oF1.cnt_4c_Sombra.lbl_4c_LblSombra
            loc_cLog = loc_cLog + "[C1]   SombraT/L/W/H= " + TRANSFORM(.Top) + "/" + ;
                TRANSFORM(.Left) + "/" + TRANSFORM(.Width) + "/" + TRANSFORM(.Height) + CHR(13) + CHR(10)
            loc_cLog = loc_cLog + "[C1]   SombraFonte  = " + .FontName + " " + ;
                TRANSFORM(.FontSize) + " bold=" + TRANSFORM(.FontBold) + ;
                " auto=" + TRANSFORM(.AutoSize) + " fore=" + TRANSFORM(.ForeColor) + CHR(13) + CHR(10)
            loc_cLog = loc_cLog + "[C1]   SombraVisible= " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
        ENDWITH
        WITH loc_oF1.cnt_4c_Sombra.lbl_4c_LblTitulo
            loc_cLog = loc_cLog + "[C1]   TituloT/L/W/H= " + TRANSFORM(.Top) + "/" + ;
                TRANSFORM(.Left) + "/" + TRANSFORM(.Width) + "/" + TRANSFORM(.Height) + CHR(13) + CHR(10)
            loc_cLog = loc_cLog + "[C1]   TituloFonte  = " + .FontName + " " + ;
                TRANSFORM(.FontSize) + " bold=" + TRANSFORM(.FontBold) + ;
                " auto=" + TRANSFORM(.AutoSize) + " fore=" + TRANSFORM(.ForeColor) + CHR(13) + CHR(10)
            loc_cLog = loc_cLog + "[C1]   TituloVisible= " + TRANSFORM(.Visible) + CHR(13) + CHR(10)
        ENDWITH
    ENDIF
ENDIF

*-- Cenario 2: modo ALTERAR (_Altera = .T.) com alias explicito -> Height = 250
LOCAL loc_oF2
loc_oF2 = .NULL.
TRY
    loc_oF2 = CREATEOBJECT("FormSigOpCts", "22202", .T., "LocalCli")
CATCH TO loc_oE2
    loc_cLog = loc_cLog + "[C2] EXCECAO: " + loc_oE2.Message + " LN=" + ;
        TRANSFORM(loc_oE2.LineNo) + " PROC=" + loc_oE2.Procedure + CHR(13) + CHR(10)
ENDTRY

loc_cLog = loc_cLog + "[C2] VARTYPE        = " + VARTYPE(loc_oF2) + CHR(13) + CHR(10)
IF VARTYPE(loc_oF2) = "O"
    loc_cLog = loc_cLog + "[C2] Height         = " + TRANSFORM(loc_oF2.Height) + ;
        " (esperado 250)" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C2] this_lAltera   = " + TRANSFORM(loc_oF2.this_lAltera) + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C2] this_cArquivo  = [" + loc_oF2.this_cArquivo + "]" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C2] cnt Width      = " + ;
        TRANSFORM(loc_oF2.cnt_4c_Sombra.Width) + CHR(13) + CHR(10)
ENDIF

*-- Cenario 3: visibilidade dos metodos PROTECTED/PUBLIC (regra #3/#51)
IF VARTYPE(loc_oF1) = "O"
    loc_cLog = loc_cLog + "[C3] ObterResultado protegido = " + ;
        TRANSFORM(PEMSTATUS(loc_oF1, "ObterResultado", 2)) + " (esperado .F.)" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C3] InicializarForm protegido= " + ;
        TRANSFORM(PEMSTATUS(loc_oF1, "InicializarForm", 2)) + " (esperado .T.)" + CHR(13) + CHR(10)
    loc_cLog = loc_cLog + "[C3] ConfigurarCabecalho prot = " + ;
        TRANSFORM(PEMSTATUS(loc_oF1, "ConfigurarCabecalho", 2)) + " (esperado .T.)" + CHR(13) + CHR(10)
ENDIF

*-- Cenario 4: Destroy/cache do resultado - o BO devolve ZSen antes de ser liberado
IF VARTYPE(loc_oF2) = "O"
    loc_oF2.this_oBusinessObject.this_lZSen = .T.
    loc_cLog = loc_cLog + "[C4] ObterResultado(BO vivo)  = " + ;
        TRANSFORM(loc_oF2.ObterResultado()) + " (esperado .T.)" + CHR(13) + CHR(10)
    loc_oF2.Release()
    loc_cLog = loc_cLog + "[C4] VARTYPE pos-Release      = " + VARTYPE(loc_oF2) + CHR(13) + CHR(10)
ENDIF

IF VARTYPE(loc_oF1) = "O"
    loc_oF1.Release()
ENDIF

loc_cLog = loc_cLog + "[FIM] probe concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cLog, loc_cOut)
QUIT
