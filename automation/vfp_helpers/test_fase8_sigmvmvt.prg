*==============================================================================
* test_fase8_sigmvmvt.prg - Harness da Fase 8 do FormSIGMVMVT
* Prova que o form INSTANCIA e que os ADAPTADORES de nome CRUD da Fase 8
* existem, tem o ESCOPO certo e FUNCIONAM em runtime (compilar limpo nao
* prova nada - metodo inexistente/propriedade ausente so estoura ao ser
* acionado).
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnI
LOCAL lcNome, lcEsc, lnFalhas, lcRet
lcCRLF   = CHR(13) + CHR(10)
lcLog    = "C:\4c\automation\vfp_helpers\test_fase8_sigmvmvt_resultado.txt"
lcCls    = "C:\4c\projeto\app\classes\"
lcUtl    = "C:\4c\projeto\app\utils\"
lnFalhas = 0

STRTOFILE("=== TESTE FASE 8 FormSIGMVMVT (adaptadores CRUD) ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1

*-- OBRIGATORIO junto com gb_4c_ModoTeste: EscreverErroParaArquivo exige as
*-- DUAS coisas (flag + nome de arquivo). Sem esta linha MsgErro/MsgAviso caem
*-- num MESSAGEBOX real e o teste TRAVA sem produzir resultado.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_fase8_sigmvmvt_dialogs.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado    = "TESTE"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg")  ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg")   ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (lcCls + "SIGMVMVTBO.prg")   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\FormSIGMVMVT.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

*-- 1) INSTANCIACAO (modo filtro manual - Automatico = .F.)
loForm = .NULL.
TRY
    loForm = CREATEOBJECT("FormSIGMVMVT")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : FALHA - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT      : FALHA - retornou " + VARTYPE(loForm) + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ELSE
    STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + lcCRLF, lcLog, 1)

    *==========================================================================
    * 2) EXISTENCIA + ESCOPO dos nomes que o pipeline cobra
    *    PEMSTATUS(...,5) so diz que EXISTE (nao diz o escopo) - por isso o
    *    teste de escopo vem da CHAMADA real mais abaixo.
    *==========================================================================
    STRTOFILE(lcCRLF + "--- EXISTENCIA DOS ADAPTADORES ---" + lcCRLF, lcLog, 1)

    LOCAL ARRAY laNomes[10]
    laNomes[1]  = "FormParaBO"
    laNomes[2]  = "BOParaForm"
    laNomes[3]  = "CarregarLista"
    laNomes[4]  = "BtnCancelarClick"
    laNomes[5]  = "BtnExecutarClick"
    laNomes[6]  = "BtnBuscarClick"
    laNomes[7]  = "HabilitarCampos"
    laNomes[8]  = "LimparCampos"
    laNomes[9]  = "AjustarBotoesPorModo"
    laNomes[10] = "DefinirFiltroPorChave"

    FOR lnI = 1 TO ALEN(laNomes)
        lcNome = laNomes[lnI]
        IF PEMSTATUS(loForm, lcNome, 5)
            STRTOFILE(PADR(lcNome, 24) + ": EXISTE" + lcCRLF, lcLog, 1)
        ELSE
            STRTOFILE(PADR(lcNome, 24) + ": AUSENTE  <<< FALHA" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ENDIF
    ENDFOR

    *==========================================================================
    * 3) PROTECTED de verdade? FormParaBO/BOParaForm tem de RECUSAR chamada
    *    externa (o FormBase os declara PROTECTED e a protecao eh herdada).
    *==========================================================================
    STRTOFILE(lcCRLF + "--- ESCOPO (FormParaBO/BOParaForm devem ser PROTECTED) ---" + lcCRLF, lcLog, 1)

    TRY
        lcRet = TRANSFORM(loForm.FormParaBO())
        STRTOFILE("FormParaBO externo: ACEITOU (" + lcRet + ") <<< deveria ser PROTECTED" + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    CATCH TO loErr
        STRTOFILE("FormParaBO externo: RECUSADO (PROTECTED ok) - " + loErr.Message + lcCRLF, lcLog, 1)
    ENDTRY

    TRY
        lcRet = TRANSFORM(loForm.BOParaForm())
        STRTOFILE("BOParaForm externo: ACEITOU (" + lcRet + ") <<< deveria ser PROTECTED" + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    CATCH TO loErr
        STRTOFILE("BOParaForm externo: RECUSADO (PROTECTED ok) - " + loErr.Message + lcCRLF, lcLog, 1)
    ENDTRY

    *==========================================================================
    * 4) CarregarLista com a tela EM BRANCO (o caminho do harness):
    *    tem de devolver .T., limpar a arvore e NAO abrir dialogo.
    *==========================================================================
    STRTOFILE(lcCRLF + "--- CarregarLista() com filtro VAZIO (caminho do harness) ---" + lcCRLF, lcLog, 1)
    TRY
        lcRet = TRANSFORM(loForm.CarregarLista())
        STRTOFILE("CarregarLista()   : retornou " + lcRet + ;
            IIF(lcRet == ".T.", " (OK)", " <<< esperado .T.") + lcCRLF, lcLog, 1)
        IF lcRet != ".T."
            lnFalhas = lnFalhas + 1
        ENDIF
    CATCH TO loErr
        STRTOFILE("CarregarLista()   : FALHA - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 5) FormParaBO transferiu de verdade? Preenche Empresa+Operacao (SEM
    *    Numero e SEM periodo, para NAO disparar SQL com handle -1) e confere
    *    as properties do BO depois de CarregarLista.
    *==========================================================================
    STRTOFILE(lcCRLF + "--- TRANSFERENCIA filtro -> BO (FormParaBO) ---" + lcCRLF, lcLog, 1)
    TRY
        loForm.txt_4c_CEmp.Value  = "001"
        loForm.txt_4c_Dopes.Value = "CORTE"
        loForm.txt_4c_Numes.Value = 0

        lcRet = TRANSFORM(loForm.CarregarLista())

        STRTOFILE("CarregarLista()   : retornou " + lcRet + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_cEmps     : [" + loForm.this_oBusinessObject.this_cEmps + "]" + ;
            IIF(loForm.this_oBusinessObject.this_cEmps == "001", " OK", " <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_cDopes    : [" + loForm.this_oBusinessObject.this_cDopes + "]" + ;
            IIF(loForm.this_oBusinessObject.this_cDopes == "CORTE", " OK", " <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("BO.this_cEmpDopNums len: " + TRANSFORM(LEN(loForm.this_oBusinessObject.this_cEmpDopNums)) + ;
            IIF(LEN(loForm.this_oBusinessObject.this_cEmpDopNums) = 29, " OK (3+20+6)", " <<< FALHA") + lcCRLF, lcLog, 1)

        IF loForm.this_oBusinessObject.this_cEmps != "001" OR ;
           loForm.this_oBusinessObject.this_cDopes != "CORTE" OR ;
           LEN(loForm.this_oBusinessObject.this_cEmpDopNums) != 29
            lnFalhas = lnFalhas + 1
        ENDIF
    CATCH TO loErr
        STRTOFILE("TRANSFERENCIA     : FALHA - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 6) DefinirFiltroPorChave -> BOParaForm: a chave volta para os 3 campos
    *    (caminho de Anterior/Proximo). Chamado de DENTRO por BtnProximoClick,
    *    aqui exercitado pelo efeito observavel nos campos.
    *==========================================================================
    STRTOFILE(lcCRLF + "--- BOParaForm via DefinirFiltroPorChave (Anterior/Proximo) ---" + lcCRLF, lcLog, 1)
    TRY
        *-- Empilha uma chave e aciona o Anterior (Command4 do legado), que
        *-- desempilha -> DefinirFiltroPorChave -> BOParaForm -> campos.
        loForm.this_lRetorno = .T.
        DIMENSION loForm.this_aEmpDopNums[1]
        loForm.this_aEmpDopNums[1] = PADR("002", 3) + PADR("MONTAGEM", 20) + STR(77, 6)

        loForm.BtnAnteriorClick()

        STRTOFILE("txt_4c_CEmp      : [" + ALLTRIM(TRANSFORM(loForm.txt_4c_CEmp.Value)) + "]" + ;
            IIF(ALLTRIM(TRANSFORM(loForm.txt_4c_CEmp.Value)) == "002", " OK", " <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("txt_4c_Dopes     : [" + ALLTRIM(TRANSFORM(loForm.txt_4c_Dopes.Value)) + "]" + ;
            IIF(ALLTRIM(TRANSFORM(loForm.txt_4c_Dopes.Value)) == "MONTAGEM", " OK", " <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("txt_4c_Numes     : [" + TRANSFORM(loForm.txt_4c_Numes.Value) + "]" + ;
            IIF(loForm.txt_4c_Numes.Value = 77, " OK", " <<< FALHA") + lcCRLF, lcLog, 1)

        IF ALLTRIM(TRANSFORM(loForm.txt_4c_CEmp.Value)) != "002" OR ;
           ALLTRIM(TRANSFORM(loForm.txt_4c_Dopes.Value)) != "MONTAGEM" OR ;
           loForm.txt_4c_Numes.Value != 77
            lnFalhas = lnFalhas + 1
        ENDIF
    CATCH TO loErr
        STRTOFILE("BOParaForm        : FALHA - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 7) BtnCancelarClick: limpa o filtro e NAO fecha a tela (o harness
    *    continua usando o objeto depois de aciona-lo).
    *==========================================================================
    STRTOFILE(lcCRLF + "--- BtnCancelarClick() limpa e NAO fecha ---" + lcCRLF, lcLog, 1)
    TRY
        loForm.BtnCancelarClick()

        STRTOFILE("form ainda vivo   : " + IIF(VARTYPE(loForm) = "O", "SIM (OK)", "NAO <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("txt_4c_CEmp vazio : " + IIF(EMPTY(loForm.txt_4c_CEmp.Value), "SIM (OK)", ;
            "NAO [" + ALLTRIM(TRANSFORM(loForm.txt_4c_CEmp.Value)) + "] <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("txt_4c_Dopes vazio: " + IIF(EMPTY(loForm.txt_4c_Dopes.Value), "SIM (OK)", ;
            "NAO <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("txt_4c_Numes zero : " + IIF(loForm.txt_4c_Numes.Value = 0, "SIM (OK)", "NAO <<< FALHA") + lcCRLF, lcLog, 1)
        STRTOFILE("pilha reiniciada  : " + IIF(EMPTY(loForm.this_aEmpDopNums[1]), "SIM (OK)", "NAO <<< FALHA") + lcCRLF, lcLog, 1)

        IF !EMPTY(loForm.txt_4c_CEmp.Value) OR !EMPTY(loForm.txt_4c_Dopes.Value) OR ;
           loForm.txt_4c_Numes.Value != 0 OR !EMPTY(loForm.this_aEmpDopNums[1])
            lnFalhas = lnFalhas + 1
        ENDIF
    CATCH TO loErr
        STRTOFILE("BtnCancelarClick  : FALHA - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *==========================================================================
    * 8) Os demais adaptadores acionados de verdade (o harness chama
    *    AjustarBotoesPorModo; BtnExecutar/BtnBuscar sao a acao da tela).
    *    Com o filtro vazio nenhum deles chega ao SQL.
    *==========================================================================
    STRTOFILE(lcCRLF + "--- CHAMADA REAL dos demais adaptadores ---" + lcCRLF, lcLog, 1)

    TRY
        loForm.AjustarBotoesPorModo()
        STRTOFILE("AjustarBotoesPorModo : OK" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("AjustarBotoesPorModo : FALHA - " + loErr.Message + " | Linha " + ;
            TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    TRY
        loForm.HabilitarCampos(.F.)
        STRTOFILE("HabilitarCampos(.F.) : OK (CEmp.Enabled=" + ;
            TRANSFORM(loForm.txt_4c_CEmp.Enabled) + ")" + lcCRLF, lcLog, 1)
        loForm.HabilitarCampos(.T.)
        STRTOFILE("HabilitarCampos(.T.) : OK (CEmp.Enabled=" + ;
            TRANSFORM(loForm.txt_4c_CEmp.Enabled) + ")" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("HabilitarCampos      : FALHA - " + loErr.Message + " | Linha " + ;
            TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    TRY
        lcRet = TRANSFORM(loForm.BtnExecutarClick())
        STRTOFILE("BtnExecutarClick()   : OK (retornou " + lcRet + ")" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("BtnExecutarClick()   : FALHA - " + loErr.Message + " | Linha " + ;
            TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    TRY
        lcRet = TRANSFORM(loForm.BtnBuscarClick())
        STRTOFILE("BtnBuscarClick()     : OK (retornou " + lcRet + ")" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("BtnBuscarClick()     : FALHA - " + loErr.Message + " | Linha " + ;
            TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *-- LimparCampos eh PROTECTED no FormBase (formbase.prg:276) e a protecao
    *-- eh HERDADA: chamada externa DEVE ser recusada. Quem limpa de fora eh
    *-- BtnCancelarClick (exercitado no passo 7, que passou).
    TRY
        loForm.LimparCampos()
        STRTOFILE("LimparCampos externo : ACEITOU <<< deveria ser PROTECTED" + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    CATCH TO loErr
        STRTOFILE("LimparCampos externo : RECUSADO (PROTECTED ok) - " + loErr.Message + lcCRLF, lcLog, 1)
    ENDTRY

    *==========================================================================
    * 9) Drill direto (Automatico = .T.): HabilitarCampos/LimparCampos NAO
    *    podem destravar nem apagar o filtro que abriu a tela.
    *==========================================================================
    STRTOFILE(lcCRLF + "--- Automatico = .T. (drill direto): filtro fica TRAVADO ---" + lcCRLF, lcLog, 1)
    loForm.Release()
    loForm = .NULL.

    TRY
        loForm = CREATEOBJECT("FormSIGMVMVT", .T., "003", "TINGIMENTO", 12)
    CATCH TO loErr
        STRTOFILE("CREATEOBJECT(auto)   : FALHA - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    IF VARTYPE(loForm) = "O"
        STRTOFILE("CREATEOBJECT(auto)   : OK (Automatico=" + TRANSFORM(loForm.this_lAutomatico) + ")" + lcCRLF, lcLog, 1)

        TRY
            loForm.HabilitarCampos(.T.)
            STRTOFILE("HabilitarCampos(.T.) em Automatico -> CEmp.Enabled=" + ;
                TRANSFORM(loForm.txt_4c_CEmp.Enabled) + ;
                IIF(loForm.txt_4c_CEmp.Enabled, " <<< FALHA (destravou)", " OK (continua travado)") + lcCRLF, lcLog, 1)
            IF loForm.txt_4c_CEmp.Enabled
                lnFalhas = lnFalhas + 1
            ENDIF

            *-- LimparCampos eh PROTECTED: exercitado pelo caminho PUBLIC que o
            *-- usuario/harness realmente usa (BtnCancelarClick -> LimparCampos).
            loForm.BtnCancelarClick()
            STRTOFILE("BtnCancelarClick() em Automatico -> CEmp=[" + ;
                ALLTRIM(TRANSFORM(loForm.txt_4c_CEmp.Value)) + "]" + ;
                IIF(ALLTRIM(TRANSFORM(loForm.txt_4c_CEmp.Value)) == "003", " OK (preservado)", ;
                    " <<< FALHA (apagou o filtro do drill)") + lcCRLF, lcLog, 1)
            IF ALLTRIM(TRANSFORM(loForm.txt_4c_CEmp.Value)) != "003"
                lnFalhas = lnFalhas + 1
            ENDIF
        CATCH TO loErr
            STRTOFILE("Automatico           : FALHA - " + loErr.Message + " | Linha " + ;
                TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ENDTRY

        loForm.Release()
    ENDIF

    loForm = .NULL.
ENDIF

STRTOFILE(lcCRLF + "=== RESULTADO: " + IIF(lnFalhas = 0, "TODOS OS TESTES PASSARAM", ;
    TRANSFORM(lnFalhas) + " FALHA(S)") + " ===" + lcCRLF, lcLog, 1)

QUIT
