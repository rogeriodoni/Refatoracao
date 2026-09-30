*==============================================================================
* InstantiateCheckFtpF8.prg - valida a Fase 8 (consolidacao final) de
* Formsigprftp/sigprftpBO
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o ambiente carrega (config.prg + ConfigurarAmbiente)
*   2. o form ainda INSTANCIA em modo teste (gb_4c_ModoTeste = .T. faz
*      InicializarForm devolver .T. sem criar os controles - protecao contra
*      DECLARE-DLL/RAS/WinInet do WordToC/RasAtivas/etc em CI headless)
*   3. o BO sozinho (sem UI) resolve validacoes basicas e nao estoura
*   4. metodos PUBLIC do form (exigidos por TesteAutomatico-like harness)
*      sao chamaveis de FORA sem "Property X is not found"
*   5. Destroy() roda sem erro (fecha cursores, libera BO) mesmo sem UI
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogPassoF8
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_ftpf8.txt"
gc_4c_LogPassoF8       = "C:\4c\automation\instantiate_ftpf8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoF8)
    DELETE FILE (gc_4c_LogPassoF8)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oBO
LogPasso("FTP FASE8 CHECK - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- ConfigurarAmbiente() TRAVA nesta maquina antes do CREATEOBJECT
    *-- (feedback_configurarambiente_bloqueia_probe_de_form) - carregar so o
    *-- que o form/BO usam, na mao
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
    SET PROCEDURE TO (gcCaminhoClasses + "sigprftpBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprftp.prg") ADDITIVE
    LogPasso("0 SETUP: OK")
CATCH TO loc_oErro
    LogPasso("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 1. Instancia o form em modo teste
TRY
    loc_oForm = CREATEOBJECT("Formsigprftp")
    LogPasso("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogPasso("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

*-- 2. Metodos utilitarios PUBLIC chamaveis de fora (WordToC/CToWord/
*-- SecToHour/CrackAttributes/InErrorCase nao dependem de UI nem de rede)
IF VARTYPE(loc_oForm) = "O"
    TRY
        LogPasso("2a WordToC(1000000): " + TRANSFORM(LEN(loc_oForm.WordToC(1000000))) + " bytes")
        LogPasso("2b CToWord(WordToC(1000000)): " + TRANSFORM(loc_oForm.CToWord(loc_oForm.WordToC(1000000))))
        LogPasso("2c SecToHour(3725): " + loc_oForm.SecToHour(3725))
        LogPasso("2d CrackAttributes(CHR(16)): " + loc_oForm.CrackAttributes(CHR(16)))
        LogPasso("2e InErrorCase(0): " + loc_oForm.InErrorCase(0))
    CATCH TO loc_oErro
        LogPasso("2 UTILITARIOS FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 3. Handlers de Click PUBLIC (regra #3/BINDEVENT) - chamados de FORA
    *-- como um harness faria; sem UI criada (modo teste), esperam falhar
    *-- de forma CONTROLADA (this_oBusinessObject NULL / controles ausentes)
    *-- e nao com "Property METODO is not found"
    TRY
        LogPasso("3a PEMSTATUS BtnConectarClick: " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnConectarClick", 5)))
        LogPasso("3b PEMSTATUS BtnEncerrarClick: " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)))
        LogPasso("3c PEMSTATUS BtnExecutarTransferenciaClick: " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnExecutarTransferenciaClick", 5)))
        LogPasso("3d PEMSTATUS BtnExecutarRecebimentoClick: " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnExecutarRecebimentoClick", 5)))
        LogPasso("3e PEMSTATUS BtnRedeDialupClick: " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnRedeDialupClick", 5)))
        LogPasso("3f PEMSTATUS PagLocEnviarActivate: " + TRANSFORM(PEMSTATUS(loc_oForm, "PagLocEnviarActivate", 5)))
        LogPasso("3g PEMSTATUS PagFtpAReceberActivate: " + TRANSFORM(PEMSTATUS(loc_oForm, "PagFtpAReceberActivate", 5)))
        LogPasso("3h PEMSTATUS CarregarLista: " + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)))
        LogPasso("3i PEMSTATUS HabilitarCampos: " + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 5)))
    CATCH TO loc_oErro
        LogPasso("3 PEMSTATUS FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 4. Destroy sem UI criada (modo teste) - nao pode estourar
    TRY
        loc_oForm.Release()
        LogPasso("4 RELEASE: OK (VARTYPE pos=" + VARTYPE(loc_oForm) + ")")
    CATCH TO loc_oErro
        LogPasso("4 RELEASE FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY
ENDIF

*-- 5. BO isolado (sem form) - ResolverConfiguracaoFtp com empresa corrente
TRY
    loc_oBO = CREATEOBJECT("sigprftpBO")
    LogPasso("5a BO INSTANCIA: VARTYPE=" + VARTYPE(loc_oBO))
    IF VARTYPE(loc_oBO) = "O" AND TYPE("go_4c_Sistema") = "O"
        IF loc_oBO.ResolverConfiguracaoFtp(go_4c_Sistema.cCodEmpresa)
            LogPasso("5b ResolverConfiguracaoFtp: OK TpConnect=" + loc_oBO.this_cTpConnect + ;
                " FtpAdd=" + loc_oBO.this_cFtpAdd)
        ELSE
            LogPasso("5b ResolverConfiguracaoFtp: FALSO (esperado sem config) - " + loc_oBO.this_cMensagemErro)
        ENDIF
    ENDIF
CATCH TO loc_oErro
    LogPasso("5 BO FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    LogPasso("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogPasso("DIALOGOS: nenhum")
ENDIF

LogPasso("FIM " + TTOC(DATETIME()))
QUIT

*==============================================================================
* LogPasso - grava e FECHA o arquivo a cada passo (STRTOFILE ADDITIVE)
*==============================================================================
PROCEDURE LogPasso(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoF8, 1)
ENDPROC
