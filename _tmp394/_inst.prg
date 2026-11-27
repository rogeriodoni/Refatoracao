SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
_SCREEN.WindowState = 0
_SCREEN.Left = 0
_SCREEN.Top = 0
_SCREEN.Width = 1020
_SCREEN.Height = 640
_SCREEN.Caption = "HOST CNAB2"

#DEFINE SAIDA "C:\4c\_tmp394\_inst.txt"

PUBLIC gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle = 0
gc_4c_UsuarioLogado = "4CONTROL"
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\_tmp394\_erros.txt"

LOCAL lcOut, loF, loE, loP1
lcOut = ""

CD C:\4c\projeto\app\start
DO config.prg
SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + ;
             gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGPGCNBBO.prg")        ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPGCNB.prg") ADDITIVE

gnConnHandle = SQLSTRINGCONNECT("Driver={SQL Server};Server=192.168.200.10;Database=DB_MBAHIA;Uid=4control;Pwd=f2016jstcr%@;")
lcOut = lcOut + "conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10)

TRY
    loF = CREATEOBJECT("FormSIGPGCNB")
    lcOut = lcOut + "form=" + VARTYPE(loF) + CHR(13)+CHR(10)
    IF VARTYPE(loF) = "O"
        loP1 = loF.pgf_4c_Principal.pgfiltro
        lcOut = lcOut + "Form " + TRANSFORM(loF.Width) + "x" + TRANSFORM(loF.Height) + CHR(13)+CHR(10)
        lcOut = lcOut + "PageFrame Top=" + TRANSFORM(loF.pgf_4c_Principal.Top) + ;
                " Height=" + TRANSFORM(loF.pgf_4c_Principal.Height) + ;
                " PageHeight=" + TRANSFORM(loF.pgf_4c_Principal.PageHeight) + ;
                " Tabs=" + TRANSFORM(loF.pgf_4c_Principal.Tabs) + CHR(13)+CHR(10)
        lcOut = lcOut + "offset do conteudo no form = " + ;
                TRANSFORM(loF.pgf_4c_Principal.Top + ;
                (loF.pgf_4c_Principal.Height - loF.pgf_4c_Principal.PageHeight)) + ;
                "   (legado = 6)" + CHR(13)+CHR(10)
        lcOut = lcOut + "faixa cnt_4c_Sombra Top=" + TRANSFORM(loP1.cnt_4c_Sombra.Top) + ;
                " Height=" + TRANSFORM(loP1.cnt_4c_Sombra.Height) + CHR(13)+CHR(10)
        lcOut = lcOut + "botoes cgp_4c_Filtro Top=" + TRANSFORM(loP1.cgp_4c_Filtro.Top) + ;
                " Height=" + TRANSFORM(loP1.cgp_4c_Filtro.Height) + CHR(13)+CHR(10)
    ENDIF
CATCH TO loE
    lcOut = lcOut + "ERRO: " + loE.Message + " LN " + TRANSFORM(loE.LineNo) + " PROC " + loE.Procedure + CHR(13)+CHR(10)
ENDTRY

STRTOFILE(lcOut, SAIDA)

IF VARTYPE(loF) = "O"
    loF.Show(1)
    INKEY(14)
ENDIF
QUIT
