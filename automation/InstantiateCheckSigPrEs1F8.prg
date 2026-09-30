*==============================================================================
* InstantiateCheckSigPrEs1F8.prg - valida a Fase 8 de FormSigPrEs1 (task606)
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form INSTANCIA e reproduz a geometria do legado (823x400);
*   2. BOParaForm rodou no Init e preencheu a Empresa (sem ele o primeiro
*      Consultar batia em 'Empresa Invalida!!!'); datas saem como DATE;
*   3. BtnConsultarClick com Empresa vazia BLOQUEIA a consulta e deixa
*      Form.Enabled = .T. - o form eh modal com TitleBar = 0, entao ficar
*      desabilitado deixaria o usuario SEM SAIDA;
*   4. FormParaBO transfere os filtros para o BO (OptionGroup numerico,
*      CheckBox convertido para logico);
*   5. BtnEncerrarClick eh chamavel de FORA (PUBLIC).
*
* NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (trava antes
* do CREATEOBJECT). Carrega a mao so as dependencias do form.
*
* gnConnHandle = 1 eh handle FALSO, so para passar o guard de conexao do
* InicializarForm - nenhum passo acima executa SQL. Nesta maquina nao ha rota
* para o SQL Server 192.168.200.10, entao com handle real o form (corretamente)
* recusa abrir.
*
* Cada passo eh GRAVADO EM DISCO assim que termina (LogP -> STRTOFILE
* ADDITIVE): se o processo travar, o log mostra onde parou.
*
* ATENCAO ao rodar: apagar o .FXP antes (a extensao gravada eh .FXP MAIUSCULO)
* - vfp9.exe roda o .FXP velho e o resultado vira diagnostico falso.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF8, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigpres1f8.txt"
gc_4c_LogF8            = "C:\4c\automation\instantiate_sigpres1f8_result.txt"
gnConnHandle           = 1   && handle FALSO: passa o guard de conexao; nenhum passo abaixo executa SQL

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF8)
    DELETE FILE (gc_4c_LogF8)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oCnt
LogP("FASE8 task606 - inicio " + TTOC(DATETIME()))

*-- NAO chamar ConfigurarAmbiente(): ela nao retorna nesta maquina.
*-- Carregar a mao so as dependencias do form.
TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    LogP("0a config.prg OK")

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
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrEs1BO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrEs1.prg") ADDITIVE
    LogP("0b dependencias carregadas")
CATCH TO loc_oErro
    LogP("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("ProbeSigPrEs1F8")
    LogP("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm)="O", " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    loc_oCnt = loc_oForm.cnt_4c_Container1

    TRY
        LogP("2 BOParaForm -> Empresa=[" + TRANSFORM(loc_oCnt.txt_4c__cd_empresa.Value) + "]" + ;
            " dtIni=[" + TRANSFORM(loc_oCnt.txt_4c__dt_inicial.Value) + "]" + ;
            " tipo=" + VARTYPE(loc_oCnt.txt_4c__dt_inicial.Value) + ;
            " dtFim=[" + TRANSFORM(loc_oCnt.txt_4c__dt_final.Value) + "]")
    CATCH TO loc_oErro
        LogP("2 FALHOU: " + loc_oErro.Message)
    ENDTRY

    TRY
        loc_oCnt.txt_4c__cd_empresa.Value = ""
        loc_oForm.BtnConsultarClick()
        LogP("3 Consultar c/ Empresa VAZIA -> Form.Enabled=" + TRANSFORM(loc_oForm.Enabled) + ;
            " (esperado .T.)")
    CATCH TO loc_oErro
        LogP("3 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oCnt.txt_4c__cd_empresa.Value  = "01"
        loc_oCnt.txt_4c__nm_operacao.Value = "TESTE-OP"
        loc_oCnt.txt_4c_Grupo.Value        = "G1"
        loc_oCnt.obj_4c_Opt_nr_periodo.Value = 2
        loc_oCnt.chk_4c_ChkEmpD.Value      = 1
        loc_oForm.ProbeFormParaBO()
        LogP("4 FormParaBO -> Op=[" + loc_oForm.this_oBusinessObject.this_cNomeOperacao + "]" + ;
            " Emp=[" + loc_oForm.this_oBusinessObject.this_cCodigoEmpresa + "]" + ;
            " Grupo=[" + loc_oForm.this_oBusinessObject.this_cGrupo + "]" + ;
            " Periodo=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nOpcaoPeriodo) + ;
            " EmpDest=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lEmpresaDestino))
    CATCH TO loc_oErro
        LogP("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.BtnEncerrarClick()
        LogP("5 BtnEncerrarClick de FORA: OK")
    CATCH TO loc_oErro
        LogP("5 FALHOU: " + loc_oErro.Message)
    ENDTRY
ENDIF

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

DEFINE CLASS ProbeSigPrEs1F8 AS FormSigPrEs1
    PROCEDURE ProbeFormParaBO()
        THIS.FormParaBO()
        RETURN .T.
    ENDPROC
ENDDEFINE
