*==============================================================================
* ProbeRsa671F6.prg - Mede a Fase 6 do task671 (campos restantes + lookups) no
* FormSigPrRsa, DEPOIS das correcoes desta fase:
*   (1) o form continua instanciando (Init nao quebrou);
*   (2) os dois controles de dados do legado (Label2 -> lbl_4c_LblPrioridade e
*       Get_Prioridade -> txt_4c_Prioridade) batem PROPRIEDADE A PROPRIEDADE
*       com o dump do SCX;
*   (3) os handlers chamados de fora / por BINDEVENT sao PUBLIC (regra #3);
*   (4) o aviso "Prioridade Invalida!!!" sai UMA vez por TENTATIVA e nao uma
*       por evento - mede CONTANDO o que o MsgAviso grava no
*       gc_4c_ArquivoErroTeste em modo teste;
*   (5) valor aceito propaga para o form E para o BO; valor recusado NAO
*       propaga;
*   (6) FormParaBO nao deixa valor fora de 0/1 chegar ao BO;
*   (7) HabilitarCampos(.T.) em modo PARAMETRIZADO mantem o Processar
*       habilitado - eh o modo em que o Activate() clica nele sozinho.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_avisos_rsa671_f6.txt"

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oTxt, loc_oLbl, loc_nAv
loc_cOut = "C:\4c\automation\probe_rsa671_f6_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    PUBLIC gnConnHandle
    gnConnHandle = 0

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrRsaBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrRsa.prg") ADDITIVE

    *-- (1) Instanciacao
    loc_oForm = CREATEOBJECT("FormSigPrRsa")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"

        *-- (2) Campos de dados contra o dump do SCX
        loc_oLbl = loc_oForm.lbl_4c_LblPrioridade
        STRTOFILE(CHR(13)+CHR(10)+"LABEL2 dump(T=154 L=134 W=102 H=15) -> T=" + ;
                  TRANSFORM(loc_oLbl.Top) + " L=" + TRANSFORM(loc_oLbl.Left) + ;
                  " W=" + TRANSFORM(loc_oLbl.Width) + " H=" + TRANSFORM(loc_oLbl.Height) + ;
                  " AutoSize=" + TRANSFORM(loc_oLbl.AutoSize) + ;
                  " BackStyle=" + TRANSFORM(loc_oLbl.BackStyle) + ;
                  " Fore=" + TRANSFORM(loc_oLbl.ForeColor) + ;
                  " (RGB(90,90,90)=" + TRANSFORM(RGB(90,90,90)) + ")" + ;
                  " Font=" + ALLTRIM(loc_oLbl.FontName) + "/" + TRANSFORM(loc_oLbl.FontSize) + ;
                  " Bold=" + TRANSFORM(loc_oLbl.FontBold) + ;
                  " TabIndex=" + TRANSFORM(loc_oLbl.TabIndex) + ;
                  " Cap=[" + loc_oLbl.Caption + "]", loc_cOut, 1)

        loc_oTxt = loc_oForm.txt_4c_Prioridade
        STRTOFILE(CHR(13)+CHR(10)+"GETPRIORIDADE dump(T=150 L=238 W=17 H=23 Mask=9 MaxLen=1 Tab=1) -> T=" + ;
                  TRANSFORM(loc_oTxt.Top) + " L=" + TRANSFORM(loc_oTxt.Left) + ;
                  " W=" + TRANSFORM(loc_oTxt.Width) + " H=" + TRANSFORM(loc_oTxt.Height) + ;
                  " InputMask=[" + loc_oTxt.InputMask + "]" + ;
                  " MaxLength=" + TRANSFORM(loc_oTxt.MaxLength) + ;
                  " TabIndex=" + TRANSFORM(loc_oTxt.TabIndex) + ;
                  " Font=" + ALLTRIM(loc_oTxt.FontName) + "/" + TRANSFORM(loc_oTxt.FontSize) + ;
                  " Bold=" + TRANSFORM(loc_oTxt.FontBold) + ;
                  " ReadOnly=" + TRANSFORM(loc_oTxt.ReadOnly) + ;
                  " ValueType=" + VARTYPE(loc_oTxt.Value) + ;
                  " Value=" + TRANSFORM(loc_oTxt.Value), loc_cOut, 1)

        *-- (3) Escopo PUBLIC dos handlers (atributo 2 = Protected -> .F.)
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO(prot) ValidarPrioridade=" + ;
                  TRANSFORM(PEMSTATUS(loc_oForm, "ValidarPrioridade", 2)) + ;
                  " ValidarPrioridadeExec=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarPrioridadeExec", 2)) + ;
                  " TxtPrioridadeKeyPress=" + TRANSFORM(PEMSTATUS(loc_oForm, "TxtPrioridadeKeyPress", 2)) + ;
                  " TxtPrioridadeInteractiveChange=" + TRANSFORM(PEMSTATUS(loc_oForm, "TxtPrioridadeInteractiveChange", 2)) + ;
                  " FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + ;
                  " HabilitarCampos=" + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 2)), loc_cOut, 1)

        *-- (4) Um aviso por TENTATIVA. O SetFocus() do ramo invalido estoura em
        *-- form que nunca foi Show()n - irrelevante em producao (a validacao so
        *-- roda com a tela visivel) e POSTERIOR ao MsgAviso e ao memo, entao a
        *-- medicao nao se perde.
        IF FILE(gc_4c_ArquivoErroTeste)
            DELETE FILE (gc_4c_ArquivoErroTeste)
        ENDIF

        loc_oTxt.Value = 5
        TRY
            loc_oForm.ValidarPrioridade()
        CATCH
        ENDTRY
        loc_nAv = IIF(FILE(gc_4c_ArquivoErroTeste), OCCURS("Prioridade", FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
        STRTOFILE(CHR(13)+CHR(10)+"DEDUP 1a tentativa(5): avisos=" + TRANSFORM(loc_nAv) + ;
                  " memo=" + TRANSFORM(loc_oForm.this_nPrioridadeAvisada) + ;
                  " (esperado 1 / 5)", loc_cOut, 1)

        *-- 2o evento do MESMO gesto (LostFocus logo depois do KeyPress)
        TRY
            loc_oForm.ValidarPrioridade()
        CATCH
        ENDTRY
        loc_nAv = IIF(FILE(gc_4c_ArquivoErroTeste), OCCURS("Prioridade", FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
        STRTOFILE(CHR(13)+CHR(10)+"DEDUP 2o evento do mesmo gesto: avisos=" + TRANSFORM(loc_nAv) + ;
                  " (esperado 1 - NAO repetir)", loc_cOut, 1)

        *-- Usuario mexe no campo: volta a avisar
        loc_oForm.TxtPrioridadeInteractiveChange()
        TRY
            loc_oForm.ValidarPrioridade()
        CATCH
        ENDTRY
        loc_nAv = IIF(FILE(gc_4c_ArquivoErroTeste), OCCURS("Prioridade", FILETOSTR(gc_4c_ArquivoErroTeste)), 0)
        STRTOFILE(CHR(13)+CHR(10)+"DEDUP apos InteractiveChange: avisos=" + TRANSFORM(loc_nAv) + ;
                  " (esperado 2 - nova tentativa avisa)", loc_cOut, 1)

        *-- (5) Valor aceito propaga para form e BO e libera o memo
        loc_oTxt.Value = 1
        STRTOFILE(CHR(13)+CHR(10)+"VALIDO(1) retorno=" + TRANSFORM(loc_oForm.ValidarPrioridade()) + ;
                  " form=" + TRANSFORM(loc_oForm.this_nPrioridade) + ;
                  " BO=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade) + ;
                  " memo=" + TRANSFORM(loc_oForm.this_nPrioridadeAvisada) + ;
                  " (esperado .T. / 1 / 1 / -1)", loc_cOut, 1)

        loc_oTxt.Value = 0
        STRTOFILE(CHR(13)+CHR(10)+"VALIDO(0) retorno=" + TRANSFORM(loc_oForm.ValidarPrioridade()) + ;
                  " form=" + TRANSFORM(loc_oForm.this_nPrioridade) + ;
                  " BO=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade) + ;
                  " (esperado .T. / 0 / 0)", loc_cOut, 1)

        *-- Recusado NAO propaga - fica a ultima prioridade valida
        loc_oTxt.Value = 9
        TRY
            loc_oForm.ValidarPrioridade()
        CATCH
        ENDTRY
        STRTOFILE(CHR(13)+CHR(10)+"INVALIDO(9) nao propaga: form=" + ;
                  TRANSFORM(loc_oForm.this_nPrioridade) + ;
                  " BO=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade) + ;
                  " (esperado 0 / 0)", loc_cOut, 1)

        *-- Ordem de tabulacao efetiva: o VFP RENUMERA o TabIndex a cada
        *-- AddObject, entao o valor que o .prg atribui nao eh necessariamente
        *-- o que vale em runtime. Interessa a ordem dos controles FOCAVEIS
        *-- (Label nao recebe foco): dump = Get_Prioridade 1, OK 2, SAIR 3.
        STRTOFILE(CHR(13)+CHR(10)+"TABORDER txt=" + TRANSFORM(loc_oTxt.TabIndex) + ;
                  " Processar=" + TRANSFORM(loc_oForm.cmd_4c_Processar.TabIndex) + ;
                  " Encerrar=" + TRANSFORM(loc_oForm.cmd_4c_Encerrar.TabIndex) + ;
                  " (dump: 1 < 2 < 3)", loc_cOut, 1)

        loc_oForm.Release()

        *-- (6) FormParaBO nao deixa passar valor fora de 0/1.
        *-- FormBase declara os hooks FormParaBO/BOParaForm/LimparCampos como
        *-- PROTECTED e o VFP9 nao deixa a subclasse alargar o escopo: chamar
        *-- do script estoura "Property FORMPARABO is not found". Exercitar
        *-- por SUBCLASSE, que alcanca membro protegido.
        loc_oForm = CREATEOBJECT("ProbeRsaHooks")
        STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT(subclasse hooks)=" + VARTYPE(loc_oForm), loc_cOut, 1)
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.this_oBusinessObject.this_nPrioridade = 1
            loc_oForm.this_nPrioridade = 1
            loc_oForm.txt_4c_Prioridade.Value = 9
            loc_oForm.ExercitarFormParaBO()
            STRTOFILE(CHR(13)+CHR(10)+"FORMPARABO(9) BO=" + ;
                      TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade) + ;
                      " form=" + TRANSFORM(loc_oForm.this_nPrioridade) + ;
                      " (esperado 1 / 1 - nao propagou)", loc_cOut, 1)

            loc_oForm.txt_4c_Prioridade.Value = 0
            loc_oForm.ExercitarFormParaBO()
            STRTOFILE(CHR(13)+CHR(10)+"FORMPARABO(0) BO=" + ;
                      TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade) + ;
                      " (esperado 0 - propagou)", loc_cOut, 1)

            *-- LimparCampos e BOParaForm pelo mesmo caminho
            loc_oForm.this_oBusinessObject.this_nPrioridade = 1
            loc_oForm.ExercitarBOParaForm()
            STRTOFILE(CHR(13)+CHR(10)+"BOPARAFORM(1) txt=" + ;
                      TRANSFORM(loc_oForm.txt_4c_Prioridade.Value) + ;
                      " form=" + TRANSFORM(loc_oForm.this_nPrioridade) + ;
                      " (esperado 1 / 1)", loc_cOut, 1)

            loc_oForm.ExercitarLimparCampos()
            STRTOFILE(CHR(13)+CHR(10)+"LIMPARCAMPOS txt=" + ;
                      TRANSFORM(loc_oForm.txt_4c_Prioridade.Value) + ;
                      " form=" + TRANSFORM(loc_oForm.this_nPrioridade) + ;
                      " BO=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPrioridade) + ;
                      " (esperado 0 / 0 / 0)", loc_cOut, 1)
            loc_oForm.Release()
        ENDIF

        *-- (7) Modo PARAMETRIZADO: HabilitarCampos nao pode matar o Processar
        loc_oForm = CREATEOBJECT("FormSigPrRsa", "LOTE", 1)
        STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT(param)=" + VARTYPE(loc_oForm), loc_cOut, 1)
        IF VARTYPE(loc_oForm) = "O"
            loc_oForm.HabilitarCampos(.T.)
            STRTOFILE(CHR(13)+CHR(10)+"PARAM HabilitarCampos(.T.): Processar.Enabled=" + ;
                      TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
                      " txt.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Prioridade.ReadOnly) + ;
                      " (esperado .T. / .T.)", loc_cOut, 1)
            loc_oForm.HabilitarCampos(.F.)
            STRTOFILE(CHR(13)+CHR(10)+"PARAM HabilitarCampos(.F.): Processar.Enabled=" + ;
                      TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
                      " (esperado .F.)", loc_cOut, 1)
            loc_oForm.Release()
        ENDIF

        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

*==============================================================================
* ProbeRsaHooks - Subclasse de teste. Os hooks FormParaBO/BOParaForm/
* LimparCampos sao PROTECTED (escopo herdado de FormBase, que a subclasse nao
* pode alargar): script solto nao os alcanca, subclasse sim.
*==============================================================================
DEFINE CLASS ProbeRsaHooks AS FormSigPrRsa

    PROCEDURE ExercitarFormParaBO()
        THIS.FormParaBO()
    ENDPROC

    PROCEDURE ExercitarBOParaForm()
        THIS.BOParaForm()
    ENDPROC

    PROCEDURE ExercitarLimparCampos()
        THIS.LimparCampos()
    ENDPROC

ENDDEFINE
