*==============================================================================
* ProbeDes719F8.prg - instancia FormSigOpDes em modo de teste e exercita os
* metodos entregues na Fase 8/8 (task719).
*
* "A tela abre" so se prova INSTANCIANDO: Init de form grande falha em
* cadeia. E PEMSTATUS(obj, "M", 5) devolve .T. ate para metodo PROTECTED
* (regra CLAUDE.md #3) - por isso o teste mede o ESCOPO com o atributo 2
* (Protected), nao so a existencia com o 5.
*
* FormParaBO/BOParaForm sao PROTECTED por HERANCA de FormBase e NAO podem
* ser chamados por script solto: o caminho e' a subclasse ProbeSigOpDes
* abaixo, que alcanca membro protegido do pai.
*
* TRY/CATCH POR CHAMADA: sem isso nao se distingue "nao rodou" de "rodou e
* falhou", e em VFP headless um Program Error nao tratado abre um dialogo que
* ninguem fecha e PENDURA o processo ate o timeout, sem log nenhum.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_des719_f8_erro.txt"

LOCAL loc_cSaida, loc_oForm, loc_oErro, loc_i, loc_cM
LOCAL ARRAY loc_aMetodos[8]

loc_aMetodos[1] = "FormParaBO"
loc_aMetodos[2] = "BOParaForm"
loc_aMetodos[3] = "BtnCancelarClick"
loc_aMetodos[4] = "BtnConfirmarClick"
loc_aMetodos[5] = "CarregarLista"
loc_aMetodos[6] = "MontaGrade"
loc_aMetodos[7] = "CalcularTotais"
loc_aMetodos[8] = "Destroy"

loc_cSaida = "=== PROBE task719 FASE 8 (v2) ===" + CHR(13) + CHR(10)

CD C:\4c\projeto\app\start

TRY
    DO config.prg
    ConfigurarAmbiente()
    GarantirClasse("FormSigOpDes")
    loc_cSaida = loc_cSaida + "Ambiente: OK" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "Ambiente FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

TRY
    *-- A subclasse eh instanciada no lugar do form: ela herda TUDO e
    *-- acrescenta so os dois wrappers publicos que o script precisa para
    *-- alcancar os hooks protegidos.
    loc_oForm = CREATEOBJECT("ProbeSigOpDes", "001", "VENDA", 1, "0000000001", ;
        DATE(), "001VENDA                   1", "00000000000001", 1, ;
        100.00, 1, 100.00, "001", "01", "01", "001", "01", 100.00, ;
        DATE(), .F., 0, 0)

    loc_cSaida = loc_cSaida + "CREATEOBJECT VARTYPE: " + VARTYPE(loc_oForm) + CHR(13) + CHR(10)

    IF VARTYPE(loc_oForm) = "O"
        loc_cSaida = loc_cSaida + "Caption: [" + loc_oForm.Caption + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "BaseClass: [" + loc_oForm.BaseClass + "]" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "ControlCount: " + TRANSFORM(loc_oForm.ControlCount) + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + "--- metodos (existe / PROTECTED) ---" + CHR(13) + CHR(10)

        FOR loc_i = 1 TO ALEN(loc_aMetodos)
            loc_cM = loc_aMetodos[loc_i]
            loc_cSaida = loc_cSaida + PADR(loc_cM, 22) + ;
                " existe=" + IIF(PEMSTATUS(loc_oForm, loc_cM, 5), "SIM", "NAO") + ;
                " protected=" + IIF(PEMSTATUS(loc_oForm, loc_cM, 2), "SIM", "NAO") + ;
                CHR(13) + CHR(10)
        ENDFOR

        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + ;
            "--- hooks protegidos, via subclasse ---" + CHR(13) + CHR(10)

        TRY
            loc_cSaida = loc_cSaida + "FormParaBO() -> " + ;
                TRANSFORM(loc_oForm.ProbeFormParaBO()) + CHR(13) + CHR(10)
        CATCH TO loc_oErro
            loc_cSaida = loc_cSaida + "FormParaBO() FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY

        TRY
            loc_cSaida = loc_cSaida + "BOParaForm() -> " + ;
                TRANSFORM(loc_oForm.ProbeBOParaForm()) + CHR(13) + CHR(10)
        CATCH TO loc_oErro
            loc_cSaida = loc_cSaida + "BOParaForm() FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY

        *-- Round-trip: o contexto do form chegou mesmo ao BO?
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + ;
            "--- contexto no BO apos FormParaBO ---" + CHR(13) + CHR(10)
        TRY
            WITH loc_oForm.this_oBusinessObject
                loc_cSaida = loc_cSaida + ;
                    "BO.this_cEmps      = [" + TRANSFORM(.this_cEmps) + "]" + CHR(13) + CHR(10) + ;
                    "BO.this_cCpros     = [" + TRANSFORM(.this_cCpros) + "]" + CHR(13) + CHR(10) + ;
                    "BO.this_nCitens    = " + TRANSFORM(.this_nCitens) + CHR(13) + CHR(10) + ;
                    "BO.this_nUnitOrigs = " + TRANSFORM(.this_nUnitOrigs) + CHR(13) + CHR(10) + ;
                    "BO.this_nValor     = " + TRANSFORM(.this_nValor) + CHR(13) + CHR(10) + ;
                    "BO.this_nTDesc     = " + TRANSFORM(.this_nTDesc) + CHR(13) + CHR(10) + ;
                    "BO.this_nSaldo     = " + TRANSFORM(.this_nSaldo) + CHR(13) + CHR(10)
            ENDWITH
        CATCH TO loc_oErro
            loc_cSaida = loc_cSaida + "leitura do BO FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY

        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + ;
            "--- totais na tela apos BOParaForm ---" + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "txt_4c_LnValor = " + TRANSFORM(loc_oForm.txt_4c_LnValor.Value) + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "txt_4c_LnTDesc = " + TRANSFORM(loc_oForm.txt_4c_LnTDesc.Value) + CHR(13) + CHR(10)
        loc_cSaida = loc_cSaida + "txt_4c_LnSaldo = " + TRANSFORM(loc_oForm.txt_4c_LnSaldo.Value) + CHR(13) + CHR(10)

        *-- Chamadas PUBLICAS de fora, como o harness do pipeline faz
        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + ;
            "--- metodos publicos, de FORA ---" + CHR(13) + CHR(10)
        TRY
            loc_oForm.MontaGrade()
            loc_cSaida = loc_cSaida + "MontaGrade(): OK" + CHR(13) + CHR(10)
        CATCH TO loc_oErro
            loc_cSaida = loc_cSaida + "MontaGrade() FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY

        TRY
            loc_oForm.BtnCancelarClick()
            loc_cSaida = loc_cSaida + "BtnCancelarClick(): OK (liberou o dialogo)" + CHR(13) + CHR(10)
        CATCH TO loc_oErro
            loc_cSaida = loc_cSaida + "BtnCancelarClick() FALHOU: " + loc_oErro.Message + CHR(13) + CHR(10)
        ENDTRY

        loc_oForm = .NULL.

        loc_cSaida = loc_cSaida + CHR(13) + CHR(10) + ;
            "--- limpeza do Destroy (PROCEDURE Release do legado) ---" + CHR(13) + CHR(10) + ;
            "cursor_4c_Dados ainda aberto: " + ;
            IIF(USED("cursor_4c_Dados"), "SIM (NAO fechou)", "NAO (fechou)") + CHR(13) + CHR(10) + ;
            "cursor_4c_Cota  ainda aberto: " + ;
            IIF(USED("cursor_4c_Cota"), "SIM (NAO fechou)", "NAO (fechou)") + CHR(13) + CHR(10)
    ENDIF
CATCH TO loc_oErro
    loc_cSaida = loc_cSaida + "EXCECAO: " + loc_oErro.Message + CHR(13) + CHR(10) + ;
        "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + CHR(10) + ;
        "Procedure: " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE(loc_cSaida, "C:\4c\automation\probe_des719_f8.txt")

QUIT


*==============================================================================
* ProbeSigOpDes - subclasse SO de teste. Existe porque FormParaBO e
* BOParaForm sao PROTECTED (herdados assim de FormBase) e script solto nao
* alcanca membro protegido; subclasse alcanca.
*
* NAO faz parte da aplicacao - vive neste .prg de probe, nao em
* projeto\app\.
*==============================================================================
DEFINE CLASS ProbeSigOpDes AS FormSigOpDes

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
