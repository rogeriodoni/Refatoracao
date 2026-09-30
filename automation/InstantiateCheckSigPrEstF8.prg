*==============================================================================
* InstantiateCheckSigPrEstF8.prg - valida a Fase 8 de FormSIGPREST (task608)
*
* Prova MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA e reproduz a geometria do legado (600x191) e o
*      DataSession = 2 do SCX;
*   2. BOParaForm() rodou no Init - as duas caixas marcadas (Value=.T. no SCX)
*      e o rodape de status em branco;
*   3. HabilitarCampos() eh chamavel de FORA (PUBLIC) e move os DOIS botoes;
*   4. FormParaBO() transfere as caixas (numerico 1/0 -> property LOGICA do BO);
*   5. BOParaForm() devolve this_cMensagem ao rodape;
*   6. guard do legado "indices sem estrutura": Estrutura OFF + Indice ON sem
*      ArqDBF.DBF -> "Processamento Interrompido." e os botoes REABILITADOS;
*   7. caminho REAL de gravacao: BtnOKClick com as duas caixas marcadas GRAVA
*      ArqDBF.DBF e ArqInd.DBF com linhas (nao basta "abriu");
*   8. ISOLAMENTO: o CLOSE TABLES ALL do BO NAO fecha o cursor criado FORA do
*      form (era isto que o DataSession herdado quebrava);
*   9. o SET DEFAULT do BO eh REPOSTO (segunda abertura nao aninha o caminho);
*  10. BtnEncerrarClick() eh chamavel de fora (PUBLIC).
*
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina) - carrega a mao so
* as dependencias. gnConnHandle = -1: nenhum passo acima precisa de SQL, e o
* CarregarLogoTipo do BO tem guard "gnConnHandle > 0", entao ele nao tenta.
*
* ATENCAO ao rodar: apagar o .FXP antes - vfp9.exe roda o .FXP velho e o
* resultado vira diagnostico falso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF8, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprestf8.txt"
gc_4c_LogF8            = "C:\4c\automation\instantiate_sigprestf8_result.txt"
gnConnHandle           = -1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF8)
    DELETE FILE (gc_4c_LogF8)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_cBase, loc_cDirIni, loc_nArq, loc_nInd

LogP("FASE8 task608 / FormSIGPREST - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    LogP("0a config.prg OK - gc_4c_CaminhoBase=[" + gc_4c_CaminhoBase + "]")

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")  ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "fwprogressbar.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGPRESTBO.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGPREST.prg") ADDITIVE
    LogP("0b dependencias carregadas")
CATCH TO loc_oErro
    LogP("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

*-- Cenario de arquivos: basededados\ com DOIS .DBF indexados para varrer.
loc_cDirIni = FULLPATH(CURDIR())
loc_cBase   = ADDBS(gc_4c_CaminhoBase) + "basededados\"
TRY
    IF NOT DIRECTORY(loc_cBase)
        MD (loc_cBase)
    ENDIF
    IF FILE(loc_cBase + "ArqDBF.DBF")
        DELETE FILE (loc_cBase + "ArqDBF.DBF")
    ENDIF
    IF FILE(loc_cBase + "ArqDBF.CDX")
        DELETE FILE (loc_cBase + "ArqDBF.CDX")
    ENDIF
    IF FILE(loc_cBase + "ArqInd.DBF")
        DELETE FILE (loc_cBase + "ArqInd.DBF")
    ENDIF
    IF FILE(loc_cBase + "ArqInd.CDX")
        DELETE FILE (loc_cBase + "ArqInd.CDX")
    ENDIF

    CREATE TABLE (loc_cBase + "AlfaTst") FREE (cods C(3), descs C(20))
    INDEX ON cods TAG cods
    INSERT INTO AlfaTst VALUES ("001", "PRIMEIRO")
    USE
    CREATE TABLE (loc_cBase + "BetaTst") FREE (numes N(6,0), datas D)
    INDEX ON numes TAG numes
    INSERT INTO BetaTst VALUES (7, DATE())
    USE
    CLOSE TABLES ALL
    LogP("0c cenario: basededados com AlfaTst.DBF + BetaTst.DBF")
CATCH TO loc_oErro
    LogP("0c CENARIO FALHOU: " + loc_oErro.Message)
ENDTRY

*-- Cursor GLOBAL da aplicacao, criado FORA do form (sessao corrente)
CREATE CURSOR crGlobalProbe (x C(3))
INSERT INTO crGlobalProbe VALUES ("abc")
LogP("0d crGlobalProbe (fora do form) criado: " + TRANSFORM(USED("crGlobalProbe")))

TRY
    loc_oForm = CREATEOBJECT("ProbeSigPrEstF8")
    LogP("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height) + ;
        " DataSession=" + TRANSFORM(loc_oForm.DataSession), ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    TRY
        LogP("2 BOParaForm no Init -> Estrutura=" + TRANSFORM(loc_oForm.chk_4c_GeraArquivos.Value) + ;
            " Indice=" + TRANSFORM(loc_oForm.chk_4c_GeraIndices.Value) + ;
            " Rodape=[" + loc_oForm.lbl_4c_Mensagem.Caption + "] (esperado 1 / 1 / vazio)")
    CATCH TO loc_oErro
        LogP("2 FALHOU: " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oForm.HabilitarCampos(.F.)
        LogP("3a HabilitarCampos(.F.) -> OK=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
            " Encerrar=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.Enabled) + " (esperado .F./.F.)")
        loc_oForm.HabilitarCampos(.T.)
        LogP("3b HabilitarCampos(.T.) -> OK=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
            " Encerrar=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.Enabled) + " (esperado .T./.T.)")
    CATCH TO loc_oErro
        LogP("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.chk_4c_GeraArquivos.Value = 0
        loc_oForm.chk_4c_GeraIndices.Value  = 1
        loc_oForm.ProbeFormParaBO()
        LogP("4 FormParaBO -> this_lGeraArquivos=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lGeraArquivos) + ;
            " (tipo " + VARTYPE(loc_oForm.this_oBusinessObject.this_lGeraArquivos) + ")" + ;
            " this_lGeraIndices=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lGeraIndices) + ;
            " (esperado .F. tipo L / .T.)")
    CATCH TO loc_oErro
        LogP("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.this_oBusinessObject.this_cMensagem = "ECO DE TESTE"
        loc_oForm.ProbeBOParaForm()
        LogP("5 BOParaForm -> Rodape=[" + loc_oForm.lbl_4c_Mensagem.Caption + "]" + ;
            " Estrutura=" + TRANSFORM(loc_oForm.chk_4c_GeraArquivos.Value) + ;
            " Indice=" + TRANSFORM(loc_oForm.chk_4c_GeraIndices.Value))
    CATCH TO loc_oErro
        LogP("5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- (6) GUARD do legado: Indice sem Estrutura, sem ArqDBF.DBF em disco
    TRY
        loc_oForm.chk_4c_GeraArquivos.Value = 0
        loc_oForm.chk_4c_GeraIndices.Value  = 1
        loc_oForm.BtnOKClick()
        LogP("6 GUARD indices-sem-estrutura -> Rodape=[" + loc_oForm.lbl_4c_Mensagem.Caption + "]" + ;
            " OK.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled) + ;
            " Encerrar.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.Enabled) + ;
            " ArqDBF criado? " + TRANSFORM(FILE(loc_cBase + "ArqDBF.DBF")) + ;
            "  (esperado Interrompido / .T. / .T. / .F.)")
    CATCH TO loc_oErro
        LogP("6 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- (7) CAMINHO REAL: as duas caixas marcadas -> grava os dois .DBF
    TRY
        loc_oForm.chk_4c_GeraArquivos.Value = 1
        loc_oForm.chk_4c_GeraIndices.Value  = 1
        loc_oForm.BtnOKClick()
        LogP("7a PROCESSAMENTO -> Rodape=[" + loc_oForm.lbl_4c_Mensagem.Caption + "]" + ;
            " OK.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_OK.Enabled))

        loc_nArq = 0
        loc_nInd = 0
        IF FILE(loc_cBase + "ArqDBF.DBF")
            SELECT 0
            USE (loc_cBase + "ArqDBF.DBF") ALIAS ChkArqDBF AGAIN
            loc_nArq = RECCOUNT("ChkArqDBF")
            USE IN ChkArqDBF
        ENDIF
        IF FILE(loc_cBase + "ArqInd.DBF")
            SELECT 0
            USE (loc_cBase + "ArqInd.DBF") ALIAS ChkArqInd AGAIN
            loc_nInd = RECCOUNT("ChkArqInd")
            USE IN ChkArqInd
        ENDIF
        LogP("7b GRAVOU -> ArqDBF.DBF=" + TRANSFORM(FILE(loc_cBase + "ArqDBF.DBF")) + ;
            " linhas=" + TRANSFORM(loc_nArq) + " (4 campos esperados)" + ;
            " | ArqInd.DBF=" + TRANSFORM(FILE(loc_cBase + "ArqInd.DBF")) + ;
            " linhas=" + TRANSFORM(loc_nInd) + " (2 tags esperados)")
        LogP("7c contadores BO -> Arquivos=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalArquivos) + ;
            " Campos=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalCampos) + ;
            " Indices=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTotalIndices))
    CATCH TO loc_oErro
        LogP("7 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
            " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- (8) ISOLAMENTO: o CLOSE TABLES ALL do BO nao deve ter tocado o cursor de fora
    LogP("8 ISOLAMENTO DataSession=2 -> USED(crGlobalProbe)=" + TRANSFORM(USED("crGlobalProbe")) + ;
        " (esperado .T.)")

    *-- (9) SET DEFAULT reposto?
    LogP("9 CURDIR depois=[" + FULLPATH(CURDIR()) + "] antes=[" + loc_cDirIni + "]" + ;
        " reposto? " + TRANSFORM(UPPER(ALLTRIM(FULLPATH(CURDIR()))) == UPPER(ALLTRIM(loc_cDirIni))))

    TRY
        loc_oForm.BtnEncerrarClick()
        LogP("10 BtnEncerrarClick de FORA: OK")
    CATCH TO loc_oErro
        LogP("10 FALHOU: " + loc_oErro.Message)
    ENDTRY
ENDIF

*-- limpeza do cenario
TRY
    CLOSE TABLES ALL
    SET DEFAULT TO (loc_cDirIni)
    IF DIRECTORY(loc_cBase)
        ERASE (loc_cBase + "*.*")
        RD (loc_cBase)
    ENDIF
    LogP("LIMPEZA basededados removido? " + TRANSFORM(NOT DIRECTORY(loc_cBase)))
CATCH TO loc_oErro
    LogP("LIMPEZA parcial: " + loc_oErro.Message)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    LogP("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogP("DIALOGOS: nenhum")
ENDIF
LogP("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogP(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogF8, 1)
ENDPROC

*-- FormParaBO/BOParaForm sao PROTECTED (FormBase declara assim e subclasse nao
*-- alarga escopo) - esta subclasse so expoe wrappers para o harness chamar.
DEFINE CLASS ProbeSigPrEstF8 AS FormSIGPREST
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC
ENDDEFINE
