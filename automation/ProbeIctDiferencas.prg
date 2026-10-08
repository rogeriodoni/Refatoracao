*==============================================================================
* ProbeIctDiferencas.prg - Fase 8 / task625
*
* Prova as TRES coisas que a Fase 8 entregou no FormSigPrIct:
*   1. o form ainda INSTANCIA depois da mudanca (Init falha em cadeia);
*   2. ExibirDiferencas()/LiberarCursoresDiferencas() existem e sao
*      chamaveis de FORA da classe (metodo PROTECTED falharia aqui);
*   3. o CONTRATO de alias com a tela filha fecha: com movaux/dif2 montados
*      na data session do form, CREATEOBJECT("FormSigReDif", <DataSessionId>)
*      instancia e o SigReDifBO popula crGrid (sem Show() - modal travaria).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\logs\probe_ict_erros.txt"

LOCAL loc_oForm, loc_oFilho, loc_oErro, loc_cLog, loc_nSessaoScript, loc_lRet
loc_cLog = "C:\4c\automation\logs\probe_ict_diferencas.txt"
IF FILE(loc_cLog)
    DELETE FILE (loc_cLog)
ENDIF
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "relatoriobase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrIctBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigReDifBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrIct.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "relatorios\FormSigReDif.prg")   ADDITIVE
    Grava(loc_cLog, "0 SETUP OK")
CATCH TO loc_oErro
    Grava(loc_cLog, "0 SETUP FALHOU: " + loc_oErro.Message + " / LN " + TRANSFORM(loc_oErro.LineNo))
ENDTRY

loc_nSessaoScript = SET("Datasession")

*-- 1. INSTANCIAR o form
TRY
    loc_oForm = CREATEOBJECT("FormSigPrIct")
    IF VARTYPE(loc_oForm) = "O"
        Grava(loc_cLog, "1 FORM INSTANCIADO - BaseClass=" + loc_oForm.BaseClass + ;
            " Caption=[" + loc_oForm.Caption + "]" + ;
            " DataSession=" + TRANSFORM(loc_oForm.DataSession) + ;
            " DataSessionId=" + TRANSFORM(loc_oForm.DataSessionId) + ;
            " (script=" + TRANSFORM(loc_nSessaoScript) + ")")
    ELSE
        Grava(loc_cLog, "1 FORM FALHOU - CREATEOBJECT devolveu " + VARTYPE(loc_oForm))
    ENDIF
CATCH TO loc_oErro
    Grava(loc_cLog, "1 FORM FALHOU: " + loc_oErro.Message + " / LN " + TRANSFORM(loc_oErro.LineNo) + ;
        " / PROC " + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    *-- 2. os dois metodos novos existem e sao chamaveis de FORA
    Grava(loc_cLog, "2 PEMSTATUS ExibirDiferencas          = " + ;
        TRANSFORM(PEMSTATUS(loc_oForm, "ExibirDiferencas", 5)))
    Grava(loc_cLog, "2 PEMSTATUS LiberarCursoresDiferencas = " + ;
        TRANSFORM(PEMSTATUS(loc_oForm, "LiberarCursoresDiferencas", 5)))

    *-- Chamada REAL de fora (PEMSTATUS nao prova escopo - CLAUDE.md #3).
    *-- Sem diferenca calculada, this_lPossuiDiferenca = .F. -> devolve .F.
    *-- na primeira guarda, sem abrir nada.
    TRY
        loc_lRet = loc_oForm.ExibirDiferencas()
        Grava(loc_cLog, "2 CHAMADA EXTERNA ExibirDiferencas() -> " + TRANSFORM(loc_lRet) + ;
            " (esperado .F. - sem diferenca)")
    CATCH TO loc_oErro
        Grava(loc_cLog, "2 CHAMADA EXTERNA FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 3. CONTRATO de alias com a tela filha, dentro da sessao do form
    TRY
        SET DATASESSION TO (loc_oForm.DataSessionId)

        IF USED("movaux")
            USE IN movaux
        ENDIF
        IF USED("dif2")
            USE IN dif2
        ENDIF
        IF USED("crGrid")
            USE IN crGrid
        ENDIF

        *-- estrutura IDENTICA ao cursor_4c_MovAux do SigPrIctBO
        CREATE CURSOR movaux (AnoFis C(4), Datas C(8), Contas C(9), Debs C(12), Creds C(12), ;
            Docto C(10), Hists C(70), EmpCont C(3), NumSeq C(6), Nums C(6), Lams C(6), Data D, ;
            Valor C(12), Cecus C(3), Emps C(3), Transacaos C(10), Cpfs C(20), IClis C(10), ;
            Razaos C(50), Cheque C(20))
        INSERT INTO movaux (AnoFis, Datas, Contas, Debs, Creds, Docto, Hists, EmpCont, ;
            NumSeq, Nums, Lams, Data, Valor, Cecus, Emps, Transacaos) VALUES ;
            ("2026", "07102026", "1101001", "000000010000", "000000000000", "0000000123", ;
             "Lancamento de teste", "001", "000001", "000001", "000001", DATE(), ;
             "000000010000", "001", "001", "TRX0000001")
        INSERT INTO movaux (AnoFis, Datas, Contas, Debs, Creds, Docto, Hists, EmpCont, ;
            NumSeq, Nums, Lams, Data, Valor, Cecus, Emps, Transacaos) VALUES ;
            ("2026", "07102026", "2201001", "000000000000", "000000009000", "0000000123", ;
             "Contrapartida de teste", "001", "000002", "000001", "000001", DATE(), ;
             "000000009000", "001", "001", "TRX0000001")

        CREATE CURSOR dif2 (Transacaos C(10))
        INSERT INTO dif2 (Transacaos) VALUES ("TRX0000001")

        Grava(loc_cLog, "3 alias de contrato montados - movaux=" + TRANSFORM(RECCOUNT("movaux")) + ;
            " dif2=" + TRANSFORM(RECCOUNT("dif2")))

        loc_oFilho = CREATEOBJECT("FormSigReDif", loc_oForm.DataSessionId)
        IF VARTYPE(loc_oFilho) = "O"
            Grava(loc_cLog, "3 FormSigReDif INSTANCIADO - Caption=[" + loc_oFilho.Caption + "]" + ;
                " DataSessionId=" + TRANSFORM(loc_oFilho.DataSessionId))
            Grava(loc_cLog, "3 crGrid USED=" + TRANSFORM(USED("crGrid")) + ;
                " RECCOUNT=" + TRANSFORM(IIF(USED("crGrid"), RECCOUNT("crGrid"), -1)) + ;
                " (esperado 2 - as duas linhas da transacao desbalanceada)")
            loc_oFilho.Release()
        ELSE
            Grava(loc_cLog, "3 FormSigReDif FALHOU - VARTYPE=" + VARTYPE(loc_oFilho))
        ENDIF
    CATCH TO loc_oErro
        Grava(loc_cLog, "3 CONTRATO FALHOU: " + loc_oErro.Message + " / LN " + ;
            TRANSFORM(loc_oErro.LineNo) + " / PROC " + loc_oErro.Procedure)
    ENDTRY

    *-- 4. Em modo de teste MsgConfirma devolve .F., entao ExibirDiferencas
    *-- recusa na 3a guarda: NAO abre a tela filha (Show() modal travaria o
    *-- harness) e NAO mexe em alias nenhum. Com this_lPossuiDiferenca = .T.
    *-- forcado, a unica coisa que pode barrar eh o MsgConfirma - se ele
    *-- passasse, este probe nao terminaria.
    TRY
        loc_oForm.this_oBusinessObject.this_lPossuiDiferenca = .T.
        loc_lRet = loc_oForm.ExibirDiferencas()
        SET DATASESSION TO (loc_oForm.DataSessionId)
        Grava(loc_cLog, "4 com this_lPossuiDiferenca=.T. em modo teste -> " + TRANSFORM(loc_lRet) + ;
            " (esperado .F.: MsgConfirma recusa, tela filha NAO abre)")
        Grava(loc_cLog, "4 alias preservados (recusa nao mexe em nada): movaux=" + ;
            TRANSFORM(USED("movaux")) + " dif2=" + TRANSFORM(USED("dif2")) + ;
            " crGrid=" + TRANSFORM(USED("crGrid")) + " (esperado .T. .T. .T.)")
    CATCH TO loc_oErro
        Grava(loc_cLog, "4 FALHOU: " + loc_oErro.Message)
    ENDTRY

    SET DATASESSION TO (loc_nSessaoScript)
    loc_oForm.Release()
    Grava(loc_cLog, "5 Form liberado - FIM")
ENDIF

QUIT

PROCEDURE Grava(par_cArquivo, par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), par_cArquivo, 1)
ENDPROC
