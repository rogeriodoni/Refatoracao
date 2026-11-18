SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
gb_4c_ModoTeste  = .T.
gb_4c_ValidandoUI = .T.
gnConnHandle = 0

LOCAL lcOut, loF, loE
lcOut = ""

DO ("C:\4c\projeto\app\start\config.prg")
SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpSlcBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpSlc.prg") ADDITIVE

TRY
    loF = CREATEOBJECT("FormSigOpSlc")
    lcOut = lcOut + "VARTYPE=" + VARTYPE(loF) + CHR(13) + CHR(10)

    IF VARTYPE(loF) = "O"
        lcOut = lcOut + "BaseClass=" + loF.BaseClass + " W=" + TRANSFORM(loF.Width) + ;
                " H=" + TRANSFORM(loF.Height) + CHR(13) + CHR(10)

        lcOut = lcOut + "tem cmd_4c_Confirma=" + TRANSFORM(PEMSTATUS(loF,"cmd_4c_Confirma",5)) + CHR(13) + CHR(10)
        lcOut = lcOut + "tem cmd_4c_Cancela =" + TRANSFORM(PEMSTATUS(loF,"cmd_4c_Cancela",5)) + CHR(13) + CHR(10)

        WITH loF.cmd_4c_Confirma
            lcOut = lcOut + "Confirma: L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + ;
                    " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                    " Cap=[" + .Caption + "]" + " Vis=" + TRANSFORM(.Visible) + ;
                    " Pic=" + IIF(EMPTY(.Picture),"VAZIO", IIF(FILE(.Picture),"OK","AUSENTE")) + ;
                    " Themes=" + TRANSFORM(.Themes) + CHR(13) + CHR(10)
        ENDWITH
        WITH loF.cmd_4c_Cancela
            lcOut = lcOut + "Cancela : L=" + TRANSFORM(.Left) + " T=" + TRANSFORM(.Top) + ;
                    " W=" + TRANSFORM(.Width) + " H=" + TRANSFORM(.Height) + ;
                    " Cap=[" + .Caption + "]" + " Vis=" + TRANSFORM(.Visible) + ;
                    " Cancel=" + TRANSFORM(.Cancel) + ;
                    " Pic=" + IIF(EMPTY(.Picture),"VAZIO", IIF(FILE(.Picture),"OK","AUSENTE")) + CHR(13) + CHR(10)
        ENDWITH
        lcOut = lcOut + "direita: Confirma fim=" + TRANSFORM(loF.cmd_4c_Confirma.Left + loF.cmd_4c_Confirma.Width) + ;
                " / Cancela fim=" + TRANSFORM(loF.cmd_4c_Cancela.Left + loF.cmd_4c_Cancela.Width) + ;
                " / Form.Width=" + TRANSFORM(loF.Width) + CHR(13) + CHR(10)

        *-- grade: geometria lida do objeto VIVO
        WITH loF.grd_4c_Dados
            lcOut = lcOut + "Grade: ColCount=" + TRANSFORM(.ColumnCount) + ;
                    " Vis=" + TRANSFORM(.Visible) + ;
                    " widths=" + TRANSFORM(.Column1.Width) + "/" + TRANSFORM(.Column2.Width) + ;
                    "/" + TRANSFORM(.Column3.Width) + ;
                    " hdr=[" + .Column1.Header1.Caption + "|" + .Column2.Header1.Caption + ;
                    "|" + .Column3.Header1.Caption + "]" + ;
                    " RecSrc=[" + .RecordSource + "]" + CHR(13) + CHR(10)
        ENDWITH

        *-- CarregarDados chamado de FORA (prova que eh PUBLIC) sem TmpCliente
        lcOut = lcOut + "CarregarDados() sem TmpCliente=" + TRANSFORM(loF.CarregarDados()) + CHR(13) + CHR(10)

        *-- agora COM o cursor do "form pai" aberto
        SET DATASESSION TO loF.DataSessionId
        CREATE CURSOR TmpCliente (Grupo C(3), Conta C(10), Nome C(40))
        INSERT INTO TmpCliente VALUES ("001", "1234567890", "CLIENTE TESTE A")
        INSERT INTO TmpCliente VALUES ("002", "0987654321", "CLIENTE TESTE B")
        lcOut = lcOut + "CarregarDados() com TmpCliente=" + TRANSFORM(loF.CarregarDados()) + CHR(13) + CHR(10)
        WITH loF.grd_4c_Dados
            lcOut = lcOut + "pos-carga: RecSrc=[" + .RecordSource + "]" + ;
                    " ctrlsrc=[" + .Column1.ControlSource + "|" + .Column2.ControlSource + ;
                    "|" + .Column3.ControlSource + "]" + ;
                    " widths=" + TRANSFORM(.Column1.Width) + "/" + TRANSFORM(.Column2.Width) + ;
                    "/" + TRANSFORM(.Column3.Width) + ;
                    " hdr=[" + .Column1.Header1.Caption + "|" + .Column2.Header1.Caption + ;
                    "|" + .Column3.Header1.Caption + "]" + ;
                    " Vis=" + TRANSFORM(.Visible) + CHR(13) + CHR(10)
        ENDWITH
        lcOut = lcOut + "RECNO apos GO TOP=" + TRANSFORM(RECNO("TmpCliente")) + ;
                " RECCOUNT=" + TRANSFORM(RECCOUNT("TmpCliente")) + CHR(13) + CHR(10)
        lcOut = lcOut + "AplicarFormatoGrade() de fora=" + TRANSFORM(loF.AplicarFormatoGrade()) + CHR(13) + CHR(10)
        SET DATASESSION TO 1

        loF.Release()
    ENDIF
CATCH TO loE
    lcOut = lcOut + "ERRO: " + loE.Message + " | Linha " + TRANSFORM(loE.LineNo) + ;
            " | Proc " + loE.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(lcOut, "C:\4c\tasks\task803\probe\probe_f4_out.txt")
QUIT
