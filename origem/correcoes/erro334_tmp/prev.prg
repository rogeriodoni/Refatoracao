SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro334_tmp\"
gcOut = gcDir + "calib.txt"
STRTOFILE("", gcOut)
LOCAL loE, loHost, loForm, lnT
TRY
    _SCREEN.Visible = .T.
    _SCREEN.WindowState = 2
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "SigReDifBO.prg"), (gcDir + "FormSigReDif.prg") ADDITIVE
    *-- "FormSigPrIct" de mentira: data session privada com movaux/dif2
    loHost = CREATEOBJECT("HostDif")
    SET DATASESSION TO loHost.DataSessionId
    SET DATE TO BRITISH
    SET CENTURY ON
    SET NULL ON
    CREATE CURSOR movaux (AnoFis C(4), Datas C(8), Contas C(9), Debs C(12), Creds C(12), ;
        Docto C(10), Hists C(70), EmpCont C(3), NumSeq C(6), Nums C(6), Lams C(6), Data D NULL, ;
        Valor C(12), Cecus C(3), Emps C(3), Transacaos C(10), Cpfs C(20), IClis C(10), Razaos C(50), Cheque C(20))
    SET NULL OFF
    *-- T0000001 balanceada (nao deve aparecer); T0000002 e T0000003 desbalanceadas
    INSERT INTO movaux VALUES ("2026","05112026","111010001","000000150000","000000000000","0000012345","VENDA 933301 - DEBITO CAIXA","001","000001","000001","000001",DATE(2026,11,5),"1500.00","001","001","T0000001","","","","")
    INSERT INTO movaux VALUES ("2026","05112026","301011000","000000000000","000000150000","0000012345","VENDA 933301 - CREDITO RECEITA","001","000002","000001","000001",DATE(2026,11,5),"1500.00","001","001","T0000001","","","","")
    INSERT INTO movaux VALUES ("2026","06112026","112100001","000000200000","000000000000","0000012400","COMPRA METAL NUOVA - ESTOQUE","001","000003","000002","000002",DATE(2026,11,6),"2000.00","001","001","T0000002","","","","")
    INSERT INTO movaux VALUES ("2026","06112026","211010318","000000000000","000000195000","0000012400","COMPRA METAL NUOVA - FORNECEDOR","001","000004","000002","000002",DATE(2026,11,6),"1950.00","001","001","T0000002","","","","")
    INSERT INTO movaux VALUES ("2026","07112026","111010001","000000080000","000000000000","0000012500","RECEBIMENTO CARTAO - SEM CONTRAPARTIDA","001","000005","000003","000003",DATE(2026,11,7),"800.00","001","001","T0000003","","","","")
    SELECT Transacaos, SUM(VAL(Debs) / 100) AS Deb, SUM(VAL(Creds) / 100) AS Cred FROM movaux GROUP BY Transacaos INTO CURSOR Dif1
    SELECT Transacaos FROM Dif1 WHERE Deb != Cred INTO CURSOR dif2
    L("dif2=" + TRANSFORM(RECCOUNT("dif2")))
    loForm = CREATEOBJECT("FormSigReDif", loHost.DataSessionId)
    L("form=" + VARTYPE(loForm) + " crGrid=" + IIF(USED("crGrid"), TRANSFORM(RECCOUNT("crGrid")), "nao"))
    loForm.Visible = .T.
    LOCAL lnI, lcW
    lcW = ""
    FOR lnI = 1 TO loForm.grd_4c_Dados.ColumnCount
        lcW = lcW + TRANSFORM(loForm.grd_4c_Dados.Columns(lnI).Width) + "/" + loForm.grd_4c_Dados.Columns(lnI).Header1.Caption + " "
    ENDFOR
    L("larguras: " + lcW + " | RecordSource=" + loForm.grd_4c_Dados.RecordSource + " ColumnCount=" + TRANSFORM(loForm.grd_4c_Dados.ColumnCount))
    L("PRONTO")
    lnT = SECONDS()
    DO WHILE SECONDS() - lnT < 25
        DOEVENTS
    ENDDO
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS HostDif AS Form
    DataSession = 2
ENDDEFINE
