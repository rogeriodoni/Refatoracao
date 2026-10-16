*==============================================================================
* ProbeItbF8Hooks.prg - MEDE, no VFP9, os metodos da Fase 8 de FormSigPrItb
* contra os CONTROLES REAIS.
*
* InicializarForm de FormSigPrItb tem caminho "modo sem banco" que pula
* CarregarParametros() mas MONTA toda a estrutura visual, entao nao precisa de
* subclasse que substitua a inicializacao - basta gb_4c_ModoTeste. A subclasse
* existe apenas para expor os hooks FormParaBO/BOParaForm, que sao PROTECTED
* por heranca de FormBase (o VFP9 nao deixa a subclasse ALARGAR o escopo, e
* PEMSTATUS(...,5) responde "existe?", nao "da para chamar daqui?").
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogProbe
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_probeitbf8.txt"
gc_4c_LogProbe         = "C:\4c\automation\probe_itbf8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogProbe)
    DELETE FILE (gc_4c_LogProbe)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oCnt
LogProbe("PROBE FASE8 HOOKS FormSigPrItb - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
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
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrItbBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrItb.prg") ADDITIVE
    LogProbe("0 SETUP: OK")
CATCH TO loc_oErro
    LogProbe("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

*-- 1. Instancia: prova que o Init inteiro roda (a tela ABRE)
TRY
    loc_oForm = CREATEOBJECT("ProbeFormItbF8")
    LogProbe("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm))
CATCH TO loc_oErro
    LogProbe("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    loc_oCnt = loc_oForm.cnt_4c_Mvt1

    *-- 2. BOParaForm rodou na carga inicial (ConfigurarFiltroPeriodo):
    *-- as duas datas tem de ser DATE() e a empresa vazia (Space -> ALLTRIM)
    TRY
        LogProbe("2a Data1 .Value=[" + TRANSFORM(loc_oCnt.txt_4c_Data1.Value) + ;
            "] tipo=" + VARTYPE(loc_oCnt.txt_4c_Data1.Value) + " esperado=[" + TRANSFORM(DATE()) + "]")
        LogProbe("2b Data2 .Value=[" + TRANSFORM(loc_oCnt.txt_4c_Data2.Value) + "]")
        LogProbe("2c Emp1  .Value=[" + loc_oCnt.txt_4c_Emp1.Value + "] LEN=" + ;
            TRANSFORM(LEN(loc_oCnt.txt_4c_Emp1.Value)) + " (esperado 0)")
        LogProbe("2d Dsemp1 .Value=[" + loc_oCnt.txt_4c_Dsemp1.Value + "] LEN=" + ;
            TRANSFORM(LEN(loc_oCnt.txt_4c_Dsemp1.Value)) + " (esperado 0)")
    CATCH TO loc_oErro
        LogProbe("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 3. Estado inicial do Init legado via funil: filtro habilitado,
    *-- Processar habilitado, botoes de relatorio DESABILITADOS
    TRY
        LogProbe("3a modo=[" + loc_oForm.this_cModoAtual + "] (esperado FILTRO)")
        LogProbe("3b Data1.Enabled=" + TRANSFORM(loc_oCnt.txt_4c_Data1.Enabled) + ;
            " Data2=" + TRANSFORM(loc_oCnt.txt_4c_Data2.Enabled) + ;
            " Emp1=" + TRANSFORM(loc_oCnt.txt_4c_Emp1.Enabled) + ;
            " Dsemp1=" + TRANSFORM(loc_oCnt.txt_4c_Dsemp1.Enabled) + " (esperado .T. nos 4)")
        LogProbe("3c Processar.Enabled=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + " (esperado .T.)")
        LogProbe("3d btnImprimir=" + TRANSFORM(loc_oForm.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled) + ;
            " btnVisualizar=" + TRANSFORM(loc_oForm.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(2).Enabled) + ;
            " (esperado .F. nos 2)")
        LogProbe("3e cnt_4c_Aguarde.Visible=" + TRANSFORM(loc_oForm.cnt_4c_Aguarde.Visible) + " (esperado .F.)")
    CATCH TO loc_oErro
        LogProbe("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 4. FormParaBO: usuario digita periodo e empresa na TELA -> as quatro
    *-- properties do BO tem de refletir, com DATE preservado (nao TTOD)
    TRY
        loc_oCnt.txt_4c_Data1.Value  = {^2026-01-01}
        loc_oCnt.txt_4c_Data2.Value  = {^2026-01-31}
        loc_oCnt.txt_4c_Emp1.Value   = "001"
        loc_oCnt.txt_4c_Dsemp1.Value = "MARCELLA BAHIA"
        LogProbe("4a FormParaBO(): " + TRANSFORM(loc_oForm.ProbeFormParaBO()))
        LogProbe("4b BO DataInicial=[" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
            "] tipo=" + VARTYPE(loc_oForm.this_oBusinessObject.this_dDataInicial) + " (esperado D 01/01/2026)")
        LogProbe("4c BO DataFinal  =[" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataFinal) + "]")
        LogProbe("4d BO Empresa    =[" + loc_oForm.this_oBusinessObject.this_cEmpresa + "] (esperado 001)")
        LogProbe("4e BO DescEmpresa=[" + loc_oForm.this_oBusinessObject.this_cDescricaoEmpresa + "]")
    CATCH TO loc_oErro
        LogProbe("4 FORMPARABO FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 5. Round-trip: BOParaForm devolve o que FormParaBO levou
    TRY
        loc_oCnt.txt_4c_Data1.Value  = {}
        loc_oCnt.txt_4c_Emp1.Value   = ""
        loc_oCnt.txt_4c_Dsemp1.Value = ""
        LogProbe("5a BOParaForm(): " + TRANSFORM(loc_oForm.ProbeBOParaForm()))
        LogProbe("5b tela Data1=[" + TRANSFORM(loc_oCnt.txt_4c_Data1.Value) + "] (esperado 01/01/2026)")
        LogProbe("5c tela Emp1 =[" + loc_oCnt.txt_4c_Emp1.Value + "] (esperado 001)")
        LogProbe("5d tela Dsemp1=[" + loc_oCnt.txt_4c_Dsemp1.Value + "]")
    CATCH TO loc_oErro
        LogProbe("5 BOPARAFORM FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 6. ValidarPeriodo com as 3 recusas do legado (mesma ordem)
    TRY
        loc_oForm.this_oBusinessObject.this_dDataInicial = {}
        LogProbe("6a sem data inicial: " + TRANSFORM(loc_oForm.this_oBusinessObject.ValidarPeriodo()) + ;
            " msg=[" + loc_oForm.this_oBusinessObject.this_cMensagemErro + "]")
        loc_oForm.this_oBusinessObject.this_dDataInicial = {^2026-01-10}
        loc_oForm.this_oBusinessObject.this_dDataFinal   = {}
        LogProbe("6b sem data final  : " + TRANSFORM(loc_oForm.this_oBusinessObject.ValidarPeriodo()) + ;
            " msg=[" + loc_oForm.this_oBusinessObject.this_cMensagemErro + "]")
        loc_oForm.this_oBusinessObject.this_dDataFinal = {^2026-01-01}
        LogProbe("6c final < inicial : " + TRANSFORM(loc_oForm.this_oBusinessObject.ValidarPeriodo()) + ;
            " msg=[" + loc_oForm.this_oBusinessObject.this_cMensagemErro + "]")
        loc_oForm.this_oBusinessObject.this_dDataFinal = {^2026-01-31}
        LogProbe("6d periodo valido  : " + TRANSFORM(loc_oForm.this_oBusinessObject.ValidarPeriodo()))
    CATCH TO loc_oErro
        LogProbe("6 VALIDARPERIODO FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 7. HabilitarCampos / AjustarBotoesPorModo chamados de FORA da classe
    *-- (eh assim que o harness de teste automatizado os exercita - por isso
    *-- precisam ser PUBLIC de verdade, e nao so "sem PROTECTED escrito")
    TRY
        loc_oForm.HabilitarCampos(.F.)
        loc_oForm.this_cModoAtual = "INCONSISTENCIA"
        loc_oForm.AjustarBotoesPorModo()
        LogProbe("7a pos INCONSISTENCIA: filtro=" + TRANSFORM(loc_oCnt.txt_4c_Data1.Enabled) + ;
            "/" + TRANSFORM(loc_oCnt.txt_4c_Data2.Enabled) + ;
            "/" + TRANSFORM(loc_oCnt.txt_4c_Emp1.Enabled) + ;
            "/" + TRANSFORM(loc_oCnt.txt_4c_Dsemp1.Enabled) + " (esperado .F. nos 4)")
        LogProbe("7b Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + " (esperado .F.)")
        LogProbe("7c relatorio=" + TRANSFORM(loc_oForm.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled) + ;
            "/" + TRANSFORM(loc_oForm.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(2).Enabled) + " (esperado .T. nos 2)")

        loc_oForm.this_cModoAtual = "FILTRO"
        loc_oForm.HabilitarCampos(.T.)
        loc_oForm.AjustarBotoesPorModo()
        LogProbe("7d volta FILTRO: filtro=" + TRANSFORM(loc_oCnt.txt_4c_Data1.Enabled) + ;
            " Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " relatorio=" + TRANSFORM(loc_oForm.cnt_4c_Botoes.cmg_4c_Relatorio.Buttons(1).Enabled))

        *-- sem argumento tem de HABILITAR (PCOUNT() = 0), nao desabilitar
        loc_oForm.HabilitarCampos(.F.)
        loc_oForm.HabilitarCampos()
        LogProbe("7e HabilitarCampos() sem arg: Data1=" + TRANSFORM(loc_oCnt.txt_4c_Data1.Enabled) + " (esperado .T.)")
    CATCH TO loc_oErro
        LogProbe("7 FUNIL FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 8. Escopo real dos metodos: os dois hooks tem de ser PROTECTED (2) e
    *-- os dois funis PUBLIC (chamaveis de fora, como no passo 7)
    TRY
        LogProbe("8a FormParaBO           protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + " (esperado .T.)")
        LogProbe("8b BOParaForm           protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + " (esperado .T.)")
        LogProbe("8c HabilitarCampos      protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 2)) + " (esperado .F.)")
        LogProbe("8d AjustarBotoesPorModo protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 2)) + " (esperado .F.)")
        LogProbe("8e BtnProcessarClick    protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 2)) + " (esperado .F.)")
        LogProbe("8f BtnEncerrarClick     protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 2)) + " (esperado .F.)")
    CATCH TO loc_oErro
        LogProbe("8 PEMSTATUS FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 9. PrepararCursoresRelatorio sem inconsistencia: recusa SEM estourar
    TRY
        LogProbe("9 PrepararCursoresRelatorio() sem cursor: " + ;
            TRANSFORM(loc_oForm.ProbePrepararCursores()) + " (esperado .F.)")
    CATCH TO loc_oErro
        LogProbe("9 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 10. Release / Destroy (fecha cursores e encadeia DODEFAULT)
    TRY
        loc_oForm.Release()
        LogProbe("10 RELEASE: OK")
    CATCH TO loc_oErro
        LogProbe("10 RELEASE FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY
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
* ProbeFormItbF8 - subclasse SO DE MEDICAO: expoe os membros PROTECTED para o
* probe poder chama-los (subclasse alcanca protegido, script solto nao)
*==============================================================================
DEFINE CLASS ProbeFormItbF8 AS FormSigPrItb

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbePrepararCursores()
        RETURN THIS.PrepararCursoresRelatorio()
    ENDPROC

ENDDEFINE
