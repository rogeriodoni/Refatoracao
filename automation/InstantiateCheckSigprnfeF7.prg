*==============================================================================
* InstantiateCheckSigprnfeF7.prg - valida a Fase 7 de Formsigprnfe (task659)
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo), que o form continua
* instanciando depois dos novos BINDEVENT/metodos de eventos principais
* (Selecionar/Limpar/Processar/Encerrar, A Inutilizar, grade de acoes,
* painel de inutilizacao) e que os metodos/propriedades referenciados
* existem (PEMSTATUS).
*
* gnConnHandle = 1 eh handle FALSO: InicializarForm nao faz SQL (so monta o
* layout e aplica filtros default), entao nao precisa de handle real.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogF7, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprnfef7.txt"
gc_4c_LogF7            = "C:\4c\automation\instantiate_sigprnfef7_result.txt"
gnConnHandle           = 1

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogF7)
    DELETE FILE (gc_4c_LogF7)
ENDIF

IF FILE("C:\4c\projeto\app\forms\operacionais\formsigprnfe.fxp")
    DELETE FILE "C:\4c\projeto\app\forms\operacionais\formsigprnfe.fxp"
ENDIF
IF FILE("C:\4c\projeto\app\classes\sigprnfebo.fxp")
    DELETE FILE "C:\4c\projeto\app\classes\sigprnfebo.fxp"
ENDIF

LOCAL loc_oForm, loc_oErro
LogP("FASE7 task659 - inicio " + TTOC(DATETIME()))

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
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigprnfeBO.prg")   ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigprnfe.prg") ADDITIVE
    LogP("0b dependencias carregadas")
CATCH TO loc_oErro
    LogP("0 SETUP FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("Formsigprnfe")
    LogP("1 INSTANCIA VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm)="O", " Caption=[" + loc_oForm.Caption + "]" + ;
        " W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height), ""))
CATCH TO loc_oErro
    LogP("1 INSTANCIA FALHOU: " + loc_oErro.Message + " LN=" + ;
        TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    *-- 2. Botoes principais existem e tem o ButtonCount esperado
    TRY
        LogP("2 obj_4c_CmdBtnForm.ButtonCount=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnForm.ButtonCount) + ;
             " obj_4c_CmdBtnGrade.ButtonCount=" + TRANSFORM(loc_oForm.obj_4c_CmdBtnGrade.ButtonCount) + ;
             " obj_4c_Commandgroup1.ButtonCount=" + TRANSFORM(loc_oForm.obj_4c_Commandgroup1.ButtonCount))
    CATCH TO loc_oErro
        LogP("2 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 3. Metodos de evento existem (PEMSTATUS) e sao PUBLIC (nao PROTECTED)
    LOCAL loc_aMetodos[14], loc_i, loc_cMsg
    loc_aMetodos[1]  = "BtnSelecionarClick"
    loc_aMetodos[2]  = "AjustarVisibilidadeInutilizar"
    loc_aMetodos[3]  = "BtnAcaoFormClick"
    loc_aMetodos[4]  = "Processamento"
    loc_aMetodos[5]  = "BtnPrepararInutilizacaoClick"
    loc_aMetodos[6]  = "AbrirPainelInutilizacao"
    loc_aMetodos[7]  = "FecharPainelInutilizacao"
    loc_aMetodos[8]  = "BtnProcessarInutilizacaoClick"
    loc_aMetodos[9]  = "BtnAcaoGradeClick"
    loc_aMetodos[10] = "ImprimirDanfeSimplificado"
    loc_aMetodos[11] = "ExecutarReportForm"
    loc_aMetodos[12] = "MarcarTodasOperacoes"
    loc_aMetodos[13] = "DesmarcarTodasOperacoes"
    loc_aMetodos[14] = "CarregarLista"

    loc_cMsg = ""
    FOR loc_i = 1 TO ALEN(loc_aMetodos)
        loc_cMsg = loc_cMsg + loc_aMetodos[loc_i] + "=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm, loc_aMetodos[loc_i], 5)) + " "
    ENDFOR
    LogP("3 PEMSTATUS(existe): " + loc_cMsg)

    *-- 4. BO: metodos novos existem
    TRY
        LogP("4 BO metodos: InutilizarNumeracao=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "InutilizarNumeracao", 5)) + ;
            " InutilizarNumeracaoNfce=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "InutilizarNumeracaoNfce", 5)) + ;
            " CodIBGEUF=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "CodIBGEUF", 5)) + ;
            " RegistrarInutilizacao=" + ;
            TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "RegistrarInutilizacao", 5)))
    CATCH TO loc_oErro
        LogP("4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    *-- 5. Simula clique nos botoes "seguros" sem SQL (AjustarVisibilidadeInutilizar,
    *--    LimparSelecao via BtnAcaoFormClick Value=1, Marcar/Desmarcar da grade)
    TRY
        loc_oForm.cnt_4c_Operacoes.obj_4c_OptAcao.Value = 4
        loc_oForm.AjustarVisibilidadeInutilizar()
        LogP("5a AjustarVisibilidadeInutilizar OK - cmdInu.Visible=" + ;
            TRANSFORM(loc_oForm.cnt_4c_Operacoes.cmd_4c_CmdInu.Visible))
    CATCH TO loc_oErro
        LogP("5a FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.obj_4c_CmdBtnForm.Value = 1
        loc_oForm.BtnAcaoFormClick()
        LogP("5b BtnAcaoFormClick(Limpar) OK")
    CATCH TO loc_oErro
        LogP("5b FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.obj_4c_CmdBtnGrade.Value = 1
        loc_oForm.BtnAcaoGradeClick()
        LogP("5c BtnAcaoGradeClick(Marcar) OK")
    CATCH TO loc_oErro
        LogP("5c FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.FecharPainelInutilizacao()
        LogP("5d FecharPainelInutilizacao OK - cnt_4c_Inu.Visible=" + ;
            TRANSFORM(loc_oForm.cnt_4c_Inu.Visible))
    CATCH TO loc_oErro
        LogP("5d FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.cnt_4c_Operacoes.txt_4c_Emps.Value = "001"
        loc_oForm.BtnPrepararInutilizacaoClick()
        LogP("5e BtnPrepararInutilizacaoClick OK (depende de SQL real - handle fake eh esperado falhar com mensagem)")
    CATCH TO loc_oErro
        LogP("5e FALHOU (exception, nao mensagem): " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo))
    ENDTRY

    TRY
        loc_oForm.Release()
        LogP("6 Release() OK")
    CATCH TO loc_oErro
        LogP("6 FALHOU: " + loc_oErro.Message)
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
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogF7, 1)
ENDPROC
