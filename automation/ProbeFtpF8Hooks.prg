*==============================================================================
* ProbeFtpF8Hooks.prg - MEDE, no VFP9, os metodos da Fase 8 de Formsigprftp
* contra os CONTROLES REAIS (nao em modo teste, que nao cria controle nenhum).
*
* Como: subclasse de teste que substitui InicializarForm por um caminho SEM
* SQL (o BO recebe a configuracao na mao, como se ResolverConfiguracaoFtp
* tivesse lido SigCdEmp) e depois chama os MESMOS Configurar* que o form usa
* em producao. Os hooks FormParaBO/BOParaForm sao PROTECTED (FormBase nao
* permite alargar escopo), por isso a subclasse expoe wrappers so para medir.
*
* TpConnect = "B" de proposito: com "D" o ConfigurarProvedorDialUp chama a
* RAS API, que nao tem o que enumerar em CI headless.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogProbe
gb_4c_ModoTeste        = .T.   && suprime dialogo modal (exige gc_4c_ArquivoErroTeste);
*-- a subclasse do probe sobrescreve InicializarForm, entao os controles sao
*-- criados mesmo em modo teste
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_probeftpf8.txt"
gc_4c_LogProbe         = "C:\4c\automation\probe_ftpf8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogProbe)
    DELETE FILE (gc_4c_LogProbe)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_cPastaA, loc_cPastaB
LogProbe("PROBE FASE8 HOOKS - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- ConfigurarAmbiente() trava nesta maquina: carregar so o necessario
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
    LogProbe("0 SETUP: OK")
CATCH TO loc_oErro
    LogProbe("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

*-- Duas pastas locais que EXISTEM, para a validacao DIRECTORY() de FormParaBO
loc_cPastaA = ADDBS(SYS(2023)) + "ftpf8_env"
loc_cPastaB = ADDBS(SYS(2023)) + "ftpf8_rec"
IF !DIRECTORY(loc_cPastaA)
    MKDIR (loc_cPastaA)
ENDIF
IF !DIRECTORY(loc_cPastaB)
    MKDIR (loc_cPastaB)
ENDIF

PUBLIC gc_PastaA, gc_PastaB
gc_PastaA = LOWER(loc_cPastaA)
gc_PastaB = LOWER(loc_cPastaB)

*-- 1. Instancia a subclasse que constroi os controles REAIS sem SQL
TRY
    loc_oForm = CREATEOBJECT("ProbeFormFtpF8")
    LogProbe("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm))
CATCH TO loc_oErro
    LogProbe("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O" AND loc_oForm.plControlesCriados
    LOCAL loc_oL1, loc_oL2, loc_oF1, loc_oF2

    loc_oL1 = loc_oForm.cnt_4c_Navegacao.pgf_4c_Loc.Page1
    loc_oL2 = loc_oForm.cnt_4c_Navegacao.pgf_4c_Loc.Page2
    loc_oF1 = loc_oForm.cnt_4c_Navegacao.pgf_4c_Ftp.Page1
    loc_oF2 = loc_oForm.cnt_4c_Navegacao.pgf_4c_Ftp.Page2

    *-- 2. BOParaForm: os 4 TextBox tem de espelhar as 4 properties do BO
    TRY
        LogProbe("2a txt DirEnvFtp .Value=[" + loc_oL1.txt_4c_DirEnvFtp.Value + ;
            "] BO=[" + loc_oForm.this_oBusinessObject.this_cDirEnvFtp + "] TIP=[" + ;
            loc_oL1.txt_4c_DirEnvFtp.ToolTipText + "]")
        LogProbe("2b txt DirRecFtp .Value=[" + loc_oL2.txt_4c_DirRecFtp.Value + ;
            "] BO=[" + loc_oForm.this_oBusinessObject.this_cDirRecFtp + "]")
        LogProbe("2c txt DirRecLoc .Value=[" + loc_oF1.txt_4c_DirRecLoc.Value + ;
            "] BO=[" + loc_oForm.this_oBusinessObject.this_cDirRecLoc + "]")
        LogProbe("2d txt DirEnvLoc .Value=[" + loc_oF2.txt_4c_DirEnvLoc.Value + ;
            "] BO=[" + loc_oForm.this_oBusinessObject.this_cDirEnvLoc + "]")
    CATCH TO loc_oErro
        LogProbe("2 BOPARAFORM FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 3. FormParaBO: usuario edita a pasta remota SEM a barra final e a
    *-- pasta local SEM a barra invertida final - as duas tem de voltar
    *-- normalizadas (a remota com "/", a local com "\"), como o Init legado
    TRY
        loc_oF1.txt_4c_DirRecLoc.Value   = "/DESTINO/NOVO"
        loc_oL1.txt_4c_DirEnvFtp.Value   = SUBSTR(gc_PastaA, 1, LEN(gc_PastaA))
        LogProbe("3a FormParaBO(): " + TRANSFORM(loc_oForm.ProbeFormParaBO()))
        LogProbe("3b BO DirRecLoc pos=[" + loc_oForm.this_oBusinessObject.this_cDirRecLoc + "] (esperado /destino/novo/)")
        LogProbe("3c BO DirEnvFtp pos=[" + loc_oForm.this_oBusinessObject.this_cDirEnvFtp + "] (esperado " + ADDBS(gc_PastaA) + ")")
        LogProbe("3d tela DirRecLoc pos=[" + loc_oF1.txt_4c_DirRecLoc.Value + "] (BOParaForm reescreveu normalizado)")
    CATCH TO loc_oErro
        LogProbe("3 FORMPARABO FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 4. FormParaBO com campo em BRANCO: NAO pode zerar a property
    TRY
        loc_oF1.txt_4c_DirRecLoc.Value = ""
        LogProbe("4a FormParaBO() com campo vazio: " + TRANSFORM(loc_oForm.ProbeFormParaBO()))
        LogProbe("4b BO DirRecLoc preservado=[" + loc_oForm.this_oBusinessObject.this_cDirRecLoc + "]")
    CATCH TO loc_oErro
        LogProbe("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 5. FormParaBO com pasta local INEXISTENTE: tem de recusar (.F.)
    TRY
        loc_oL1.txt_4c_DirEnvFtp.Value = "z:\pasta\que\nao\existe"
        LogProbe("5a FormParaBO() pasta inexistente: " + TRANSFORM(loc_oForm.ProbeFormParaBO()) + " (esperado .F.)")
        LogProbe("5b BO DirEnvFtp preservado=[" + loc_oForm.this_oBusinessObject.this_cDirEnvFtp + "]")
        loc_oL1.txt_4c_DirEnvFtp.Value = ADDBS(gc_PastaA)
    CATCH TO loc_oErro
        LogProbe("5 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 6. HabilitarCampos: chamado de FORA da classe (como o harness faz)
    TRY
        loc_oForm.HabilitarCampos(.F.)
        LogProbe("6a HabilitarCampos(.F.): Transferir=" + TRANSFORM(loc_oForm.cmd_4c_Transferir.Enabled) + ;
            " Receber=" + TRANSFORM(loc_oForm.cmd_4c_Receber.Enabled) + ;
            " Encerrar=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.Enabled) + ;
            " Navegacao=" + TRANSFORM(loc_oForm.cnt_4c_Navegacao.Enabled))
        loc_oForm.HabilitarCampos(.T.)
        LogProbe("6b HabilitarCampos(.T.): Transferir=" + TRANSFORM(loc_oForm.cmd_4c_Transferir.Enabled) + ;
            " Receber=" + TRANSFORM(loc_oForm.cmd_4c_Receber.Enabled) + ;
            " Encerrar=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.Enabled))
    CATCH TO loc_oErro
        LogProbe("6 HABILITARCAMPOS FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 7. Handlers renomeados existem e SAO PUBLIC (BINDEVENT exige)
    TRY
        LogProbe("7a BtnExecutarTransferenciaClick: " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnExecutarTransferenciaClick", 5)))
        LogProbe("7b BtnExecutarRecebimentoClick  : " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnExecutarRecebimentoClick", 5)))
        LogProbe("7c CarregarLista                : " + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)))
        LogProbe("7d HabilitarCampos              : " + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 5)))
        LogProbe("7e BtnTransferirClick (antigo)  : " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnTransferirClick", 5)) + " (esperado .F.)")
    CATCH TO loc_oErro
        LogProbe("7 PEMSTATUS FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 8. CarregarLista com pasta local existente mas SEM FTP: o caminho
    *-- remoto falha (sem servidor), mas o lado LOCAL tem de listar e a
    *-- chamada nao pode estourar
    TRY
        *-- Desliga o lado FTP pela TELA (e ela a fonte de verdade agora que
        *-- CarregarLista chama FormParaBO antes de MontaContainer). O legado
        *-- faz "return .f." quando a listagem do FTP falha, e o migrado
        *-- reproduz isso - por isso o lado local so lista com o FTP desligado.
        loc_oF2.txt_4c_DirEnvLoc.Value = ""
        loc_oForm.this_oBusinessObject.this_cDirEnvLoc = ""
        =STRTOFILE("teste", ADDBS(gc_PastaA) + "arquivo1.txt")
        =STRTOFILE("teste", ADDBS(gc_PastaA) + "arquivo2.txt")
        LogProbe("8a CarregarLista(): " + TRANSFORM(loc_oForm.CarregarLista()))
        LogProbe("8b lst_4c_EnvFtp.ListCount=" + TRANSFORM(loc_oL1.lst_4c_EnvFtp.ListCount) + " (esperado 2)")
        IF loc_oL1.lst_4c_EnvFtp.ListCount > 0
            LogProbe("8c item1=[" + loc_oL1.lst_4c_EnvFtp.List(1, 1) + "] tam=[" + loc_oL1.lst_4c_EnvFtp.List(1, 2) + "]")
        ENDIF
    CATCH TO loc_oErro
        LogProbe("8 CARREGARLISTA FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 9. Release
    TRY
        loc_oForm.Release()
        LogProbe("9 RELEASE: OK")
    CATCH TO loc_oErro
        LogProbe("9 RELEASE FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY
ELSE
    LogProbe("CONTROLES NAO FORAM CRIADOS - " + ;
        IIF(VARTYPE(loc_oForm) = "O", loc_oForm.pcMotivo, "form nao instanciou"))
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogProbe("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogProbe("DIALOGOS: nenhum")
ENDIF

LogProbe("FIM " + TTOC(DATETIME()))
QUIT

PROCEDURE LogProbe(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogProbe, 1)
ENDPROC

*==============================================================================
* ProbeFormFtpF8 - subclasse SO DE MEDICAO: troca o InicializarForm por um
* caminho sem SQL e expoe os hooks PROTECTED para o probe poder cha-los
*==============================================================================
DEFINE CLASS ProbeFormFtpF8 AS Formsigprftp

    plControlesCriados = .F.
    pcMotivo           = ""

    PROTECTED FUNCTION InicializarForm()
        LOCAL loc_oErro

        TRY
            THIS.Caption = "Transfer" + CHR(234) + "ncia e Recebimento de arquivos via FTP"
            THIS.this_oBusinessObject = CREATEOBJECT("sigprftpBO")

            *-- Configuracao na mao, no lugar do ResolverConfiguracaoFtp (que
            *-- precisaria de SigCdPam/SigCdEmp no SQL Server)
            WITH THIS.this_oBusinessObject
                .this_cTpConnect = "B"
                .this_cFtpAdd    = "ftp.exemplo.local"
                .this_cFtpUser   = "usuario"
                .this_cFtpPass   = "senha"
                .this_cTpEnv     = "*.*"
                .this_cTpRec     = "*.*"
                .this_cDirEnvFtp = ADDBS(gc_PastaA)
                .this_cDirRecFtp = ADDBS(gc_PastaB)
                .this_cDirRecLoc = "/remoto/destino/"
                .this_cDirEnvLoc = "/remoto/origem/"
            ENDWITH

            THIS.ConfigurarPageFrame()
            THIS.ConfigurarCursoresAuxiliares()
            THIS.ConfigurarGrids()
            THIS.ConfigurarBotoesAcao()
            THIS.ConfigurarPaginaDados()

            THIS.plControlesCriados = .T.
        CATCH TO loc_oErro
            THIS.pcMotivo = loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure
        ENDTRY

        RETURN .T.
    ENDFUNC

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        THIS.BOParaForm()
    ENDPROC

ENDDEFINE
