SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SYS(2335, 0)
PUBLIC gcOut, gcDir
gcDir = "C:\4c\refatoracao\origem\correcoes\erro327_tmp\"
gcOut = gcDir + "probe.txt"
STRTOFILE("", gcOut)
LOCAL loE, loForm, loPg, loT
TRY
    DO ("C:\4c\refatoracao\projeto\app\start\config.prg")
    ConfigurarAmbiente()
    PUBLIC gnConnHandle
    gnConnHandle = SQLSTRINGCONNECT(ObterStringConexao())
    go_4c_Sistema.cCodEmpresa = "001"
    SET PROCEDURE TO (gcDir + "sigrecrpBO.prg"), (gcDir + "Formsigrecrp.prg") ADDITIVE
    loForm = CREATEOBJECT("Formsigrecrp")
    L("form=" + VARTYPE(loForm))
    SET DATASESSION TO loForm.DataSessionId
    SET DATE TO BRITISH
    SET CENTURY ON
    loPg = loForm.pgf_4c_Paginas.Page1
    L("tela ao abrir: Opcao=" + TRANSFORM(loPg.obj_4c_Opt_oper.Value) + " Vencimento=[" + TRANSFORM(loPg.txt_4c__dt_inicial.Value) + "] a [" + TRANSFORM(loPg.txt_4c__dt_final.Value) + "]")
    loT = CREATEOBJECT("T327")

    Cen(loForm, loT, "Debito, datas padrao (hoje)",      1, .F., .F., "", "", "", "", "", "", .T.)
    Cen(loForm, loT, "Credito, datas padrao (hoje)",     2, .F., .F., "", "", "", "", "", "", .F.)
    Cen(loForm, loT, "Debito 01/11 a 30/11/2026",        1, DATE(2026,11,1), DATE(2026,11,30), "", "", "", "", "", "", .F.)
    Cen(loForm, loT, "Credito 01/11 a 30/11/2026",       2, DATE(2026,11,1), DATE(2026,11,30), "", "", "", "", "", "", .F.)
    Cen(loForm, loT, "Debito nov + Grupo 11201",         1, DATE(2026,11,1), DATE(2026,11,30), "11201", "", "", "", "", "", .F.)
    Cen(loForm, loT, "Debito nov + Conta C000001",       1, DATE(2026,11,1), DATE(2026,11,30), "", "C000001", "", "", "", "", .F.)
    Cen(loForm, loT, "Debito nov + Grupo CP TRANSITO",   1, DATE(2026,11,1), DATE(2026,11,30), "", "", "TRANSITO", "", "", "", .F.)
    Cen(loForm, loT, "Credito nov + Conta CP TRANS REC", 2, DATE(2026,11,1), DATE(2026,11,30), "", "", "", "TRANS REC", "", "", .F.)
    Cen(loForm, loT, "Debito nov + Empresa 001 + Moeda R", 1, DATE(2026,11,1), DATE(2026,11,30), "", "", "", "", "001", "R", .F.)
    Cen(loForm, loT, "Debito, vencimento vazio (imagem)", 1, {}, {}, "", "", "", "", "", "", .F.)
CATCH TO loE
    L("ERRO " + TRANSFORM(loE.ErrorNo) + " linha " + TRANSFORM(loE.LineNo) + " " + loE.Message + " | " + loE.Procedure)
ENDTRY
L("FIM")
QUIT

PROCEDURE Cen(par_oForm, par_oT, par_cNome, par_nOper, par_dIni, par_dFim, par_cGru, par_cCta, par_cSgr, par_cSct, par_cEmp, par_cMoe, par_lRender)
    LOCAL loPg
    loPg = par_oForm.pgf_4c_Paginas.Page1
    loPg.obj_4c_Opt_oper.Value = par_nOper
    IF VARTYPE(par_dIni) = "D"
        loPg.txt_4c__dt_inicial.Value = par_dIni
        loPg.txt_4c__dt_final.Value   = par_dFim
    ELSE
        loPg.txt_4c__dt_inicial.Value = DATE()
        loPg.txt_4c__dt_final.Value   = DATE()
    ENDIF
    loPg.txt_4c_Grupo.Value  = par_cGru
    loPg.txt_4c_Conta.Value  = par_cCta
    loPg.txt_4c_Sgrupo.Value = par_cSgr
    loPg.txt_4c_Sconta.Value = par_cSct
    loPg.txt_4c__cd_empresa.Value = par_cEmp
    loPg.txt_4c__cd_moeda.Value   = par_cMoe
    WITH par_oT
        .this_nOper      = loPg.obj_4c_Opt_oper.Value
        .this_cGrupo     = ALLTRIM(loPg.txt_4c_Grupo.Value)
        .this_cConta     = ALLTRIM(loPg.txt_4c_Conta.Value)
        .this_cSgrupo    = ALLTRIM(loPg.txt_4c_Sgrupo.Value)
        .this_cSconta    = ALLTRIM(loPg.txt_4c_Sconta.Value)
        .this_dDtInicial = loPg.txt_4c__dt_inicial.Value
        .this_dDtFinal   = loPg.txt_4c__dt_final.Value
        .this_cCdEmpresa = ALLTRIM(loPg.txt_4c__cd_empresa.Value)
        .this_cCdMoeda   = ALLTRIM(loPg.txt_4c__cd_moeda.Value)
    ENDWITH
    L(PADR(par_cNome, 36) + " -> " + par_oT.Rodar(par_lRender, gcDir + "rel.txt"))
ENDPROC

PROCEDURE L(par_c)
    STRTOFILE(par_c + CHR(13) + CHR(10), gcOut, .T.)
ENDPROC

DEFINE CLASS T327 AS sigrecrpBO
    PROCEDURE Rodar(par_lRender, par_cTxt)
        LOCAL lcR, loE2, lcN
        lcR = ""
        TRY
            IF THIS.PrepararDados()
                lcN = ""
                SELECT Resultado
                SCAN
                    IF Tipo = 1
                        lcN = lcN + ALLTRIM(Conta) + "=" + TRANSFORM(Pendente) + " "
                    ELSE
                        lcN = lcN + "[TOTAL " + ALLTRIM(Moeda) + " " + TRANSFORM(Pendente) + "] "
                    ENDIF
                ENDSCAN
                lcR = lcN
                IF par_lRender
                    SELECT Resultado
                    GO TOP
                    SET REPORTBEHAVIOR 80
                    REPORT FORM (THIS.this_cArquivoFRX) TO FILE (par_cTxt) ASCII NOCONSOLE
                    lcR = lcR + " | render OK"
                ENDIF
            ELSE
                lcR = "SEM DADOS: " + THIS.this_cMensagemErro
            ENDIF
        CATCH TO loE2
            lcR = lcR + " ERRO " + TRANSFORM(loE2.ErrorNo) + " " + loE2.Message
        ENDTRY
        RETURN lcR
    ENDPROC
ENDDEFINE
