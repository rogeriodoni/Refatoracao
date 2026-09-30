*-- Fase 8 task606: instancia FormSigPrEs1 headless e le os observaveis do
*-- BOParaForm (estado inicial dos filtros). Carrega SO as dependencias do
*-- form - ConfigurarAmbiente() BLOQUEIA nesta maquina.
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_sigpres1_dialogs.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_oE, loc_cSaida
#DEFINE OUT_ "C:\4c\automation\probe_sigpres1_f8.txt"
STRTOFILE("A: inicio" + CHR(13)+CHR(10), OUT_)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- SQL Server 192.168.200.10 eh inalcancavel nesta maquina; o guard do
    *-- InicializarForm so exige gnConnHandle > 0. Handle falso: os SQLEXEC
    *-- estouram e sao engolidos pelos TRY/CATCH do BO, que eh o que se quer
    *-- aqui - o alvo do probe eh o Init + BOParaForm + FormParaBO.
    gnConnHandle = 1
    STRTOFILE("B: config.prg OK conn=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10), OUT_, 1)

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrEs1BO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrEs1.prg") ADDITIVE
    STRTOFILE("C: deps carregadas" + CHR(13)+CHR(10), OUT_, 1)

    STRTOFILE(Exercitar() + CHR(13)+CHR(10), OUT_, 1)
CATCH TO loc_oE
    STRTOFILE("EXCEPTION: " + loc_oE.Message + " Linha:" + TRANSFORM(loc_oE.LineNo) + ;
              " Proc:" + loc_oE.Procedure + CHR(13)+CHR(10), OUT_, 1)
ENDTRY

IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE("DIALOGOS: " + FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), OUT_, 1)
ENDIF
STRTOFILE("Z: fim" + CHR(13)+CHR(10), OUT_, 1)
QUIT

FUNCTION Exercitar()
    LOCAL loc_oForm, loc_cOut, loc_oCnt, loc_oBO

    loc_cOut = ""
    loc_oForm = CREATEOBJECT("FormSigPrEs1")
    IF VARTYPE(loc_oForm) != "O"
        RETURN "NAO INSTANCIOU (VARTYPE=" + VARTYPE(loc_oForm) + ")"
    ENDIF
    loc_cOut = "Init OK Caption=[" + loc_oForm.Caption + "]" + CHR(13)+CHR(10)

    loc_oBO  = loc_oForm.this_oBusinessObject
    loc_oCnt = loc_oForm.cnt_4c_Container1

    *-- Observaveis do BOParaForm (bloco "With .Container1" do Init legado)
    loc_cOut = loc_cOut + "BO.this_cCodigoEmpresa=[" + loc_oBO.this_cCodigoEmpresa + "]" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "txt_cd_empresa=[" + TRANSFORM(loc_oCnt.txt_4c__cd_empresa.Value) + "] tipo=" + ;
               VARTYPE(loc_oCnt.txt_4c__cd_empresa.Value) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "txt_dt_inicial=[" + TRANSFORM(loc_oCnt.txt_4c__dt_inicial.Value) + "] tipo=" + ;
               VARTYPE(loc_oCnt.txt_4c__dt_inicial.Value) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "txt_dt_final=[" + TRANSFORM(loc_oCnt.txt_4c__dt_final.Value) + "] tipo=" + ;
               VARTYPE(loc_oCnt.txt_4c__dt_final.Value) + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "txt_nm_operacao=[" + TRANSFORM(loc_oCnt.txt_4c__nm_operacao.Value) + "]" + CHR(13)+CHR(10)
    loc_cOut = loc_cOut + "txt_Grupo=[" + TRANSFORM(loc_oCnt.txt_4c_Grupo.Value) + "]" + CHR(13)+CHR(10)

    *-- FormParaBO: muda um controle e confere que chega no BO
    loc_oCnt.txt_4c__nm_operacao.Value = "TESTE-OP"
    loc_oCnt.obj_4c_Opt_nr_periodo.Value = 2
    loc_oCnt.txt_4c__cd_empresa.Value = "001"
    loc_oForm.BtnConsultarClick()   && PUBLIC; chama FormParaBO antes do SQL
    loc_cOut = loc_cOut + "apos FormParaBO: BO.this_cNomeOperacao=[" + loc_oBO.this_cNomeOperacao + ;
               "] BO.this_nOpcaoPeriodo=" + TRANSFORM(loc_oBO.this_nOpcaoPeriodo) + CHR(13)+CHR(10)

    loc_oForm.Release()
    RETURN loc_cOut
ENDFUNC
