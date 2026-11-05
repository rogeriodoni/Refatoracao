SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET ESCAPE OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe738f6_dialogs.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL lcLog, loBase, loF
lcLog = "C:\4c\automation\probe738f6.txt"
STRTOFILE("CK00 inicio" + CHR(13) + CHR(10), lcLog)

*-- (1) DEFAULTS da base class Shape, medidos no VFP9 (antes de qualquer
*--     carga do projeto) - para saber se BorderColor = RGB(90,90,90) no
*--     shp_4c_Shape2 eh transcricao ou invencao.
loBase = CREATEOBJECT("Form")
loBase.AddObject("sh", "Shape")
STRTOFILE("SHAPE default: BorderColor=" + TRANSFORM(loBase.sh.BorderColor) + ;
    " BorderStyle=" + TRANSFORM(loBase.sh.BorderStyle) + ;
    " BorderWidth=" + TRANSFORM(loBase.sh.BorderWidth) + ;
    " Curvature="   + TRANSFORM(loBase.sh.Curvature) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("   referencia: RGB(0,0,0)=" + TRANSFORM(RGB(0,0,0)) + ;
    "  RGB(90,90,90)=" + TRANSFORM(RGB(90,90,90)) + CHR(13)+CHR(10), lcLog, 1)
loBase = .NULL.

CD "C:\4c\projeto\app\start"
DO config.prg
STRTOFILE("CK01 config.prg OK (SEM ConfigurarAmbiente)" + CHR(13)+CHR(10), lcLog, 1)

gnConnHandle = -1

SET PROCEDURE TO (gc_4c_CaminhoUtils + "functions.prg")  ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "messages.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils + "validators.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigopgarBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigopgar.prg") ADDITIVE
STRTOFILE("CK02 SET PROCEDURE OK" + CHR(13)+CHR(10), lcLog, 1)

loF = CREATEOBJECT("Formsigopgar")
STRTOFILE("CK03 CREATEOBJECT VARTYPE=" + VARTYPE(loF) + CHR(13)+CHR(10), lcLog, 1)
IF VARTYPE(loF) != "O"
    STRTOFILE("FALHOU" + CHR(13)+CHR(10), lcLog, 1)
    QUIT
ENDIF

STRTOFILE("Form W=" + TRANSFORM(loF.Width) + " H=" + TRANSFORM(loF.Height) + CHR(13)+CHR(10), lcLog, 1)

*-- (2) CAMPO SOTERRADO: txt_4c_Arquivo esta CONTIDO em txt_4c_Dirs?
STRTOFILE("== cnt_4c_Xml: faixas (regra #28) ==" + CHR(13)+CHR(10), lcLog, 1)
WITH loF.cnt_4c_Xml
    STRTOFILE("txt_4c_Arquivo L=" + TRANSFORM(.txt_4c_Arquivo.Left) + ;
        " R=" + TRANSFORM(.txt_4c_Arquivo.Left + .txt_4c_Arquivo.Width) + ;
        " T=" + TRANSFORM(.txt_4c_Arquivo.Top) + ;
        " B=" + TRANSFORM(.txt_4c_Arquivo.Top + .txt_4c_Arquivo.Height) + CHR(13)+CHR(10), lcLog, 1)
    STRTOFILE("txt_4c_Dirs    L=" + TRANSFORM(.txt_4c_Dirs.Left) + ;
        " R=" + TRANSFORM(.txt_4c_Dirs.Left + .txt_4c_Dirs.Width) + ;
        " T=" + TRANSFORM(.txt_4c_Dirs.Top) + ;
        " B=" + TRANSFORM(.txt_4c_Dirs.Top + .txt_4c_Dirs.Height) + CHR(13)+CHR(10), lcLog, 1)
    STRTOFILE("CONTIDO? " + IIF(.txt_4c_Arquivo.Left >= .txt_4c_Dirs.Left AND ;
        (.txt_4c_Arquivo.Left + .txt_4c_Arquivo.Width) <= (.txt_4c_Dirs.Left + .txt_4c_Dirs.Width) AND ;
        .txt_4c_Arquivo.Top >= .txt_4c_Dirs.Top AND ;
        (.txt_4c_Arquivo.Top + .txt_4c_Arquivo.Height) <= (.txt_4c_Dirs.Top + .txt_4c_Dirs.Height), ;
        "SIM - inalcancavel ao clique", "NAO") + CHR(13)+CHR(10), lcLog, 1)
ENDWITH

*-- (3) shp_4c_Shape2 / botoes que passam da borda do form
STRTOFILE("== outros ==" + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("shp_4c_Shape2.BorderColor = " + TRANSFORM(loF.cnt_4c_TXT.shp_4c_Shape2.BorderColor) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_Cancela  L+W = " + TRANSFORM(loF.cmd_4c_Cancela.Left + loF.cmd_4c_Cancela.Width) + CHR(13)+CHR(10), lcLog, 1)
STRTOFILE("cmd_4c_Processa L+W = " + TRANSFORM(loF.cmd_4c_Processa.Left + loF.cmd_4c_Processa.Width) + CHR(13)+CHR(10), lcLog, 1)

loF.Release()
loF = .NULL.
STRTOFILE("CK99 FIM OK" + CHR(13)+CHR(10), lcLog, 1)
QUIT
