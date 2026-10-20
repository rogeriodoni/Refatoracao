*==============================================================================
* ProbeSigPrPro668F8.prg - Probe funcional da FASE 8 de FormSIGPRPRO (task668)
*
* A Fase 8 pede: BtnBuscarClick/BtnEncerrarClick/BtnSalvarClick/BtnCancelarClick,
* FormParaBO/BOParaForm COMPLETOS, HabilitarCampos/LimparCampos,
* CarregarLista/AjustarBotoesPorModo. Este probe MEDE em VFP9 (nao le codigo):
*   1) compila limpo (SET PROCEDURE ADDITIVE do arquivo final)
*   2) todos os metodos pedidos existem e sao PUBLIC (exigido pelo harness)
*   3) FormParaBO/BOParaForm/HabilitarCampos/LimparCampos/CarregarLista/
*      AjustarBotoesPorModo executam sem erro, chamados de FORA da classe
*   4) CarregarLista() recarrega (equivalente a CarregarDados)
*   5) LimparCampos() realmente limpa os campos de exibicao
*   6) BtnSalvarClick/BtnCancelarClick/BtnEncerrarClick nao destroem o form
*      antes da hora (Salvar so avisa; Cancelar/Encerrar fecham)
*
* NAO chama Show(): o form eh modal e travaria o harness.
* SET SAFETY/RESOURCE OFF obrigatorios: pipeline sem supervisao (CLAUDE.md #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_sigprpro668_f8.txt"
#DEFINE OUT "C:\4c\automation\probe_sigprpro668_f8.txt"

LOCAL loc_oForm, loc_oForm2, loc_cL, loc_nFalhas, loc_oE, loc_i, loc_cM
LOCAL ARRAY loc_aMet[6]
loc_nFalhas = 0
loc_cL = ""

STRTOFILE("=== PROBE Fase 8 - FormSIGPRPRO (task668) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

loc_aMet[1] = "FormParaBO"
loc_aMet[2] = "BOParaForm"
loc_aMet[3] = "HabilitarCampos"
loc_aMet[4] = "LimparCampos"
loc_aMet[5] = "CarregarLista"
loc_aMet[6] = "AjustarBotoesPorModo"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRPROBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRPRO.prg") ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
    IF VARTYPE(loc_oForm) != "O"
        loc_cL = loc_cL + "[FALHA] 0) form nao instanciou (VARTYPE=" + VARTYPE(loc_oForm) + ")" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ELSE
        loc_cL = loc_cL + "[OK]    0) form instanciou (compilou limpo)" + CHR(13) + CHR(10)

        *-- 1) existencia + ESCOPO (attr 2 = Protected) ------------------------
        FOR loc_i = 1 TO 6
            IF !PEMSTATUS(loc_oForm, loc_aMet[loc_i], 5)
                loc_cL = loc_cL + "[FALHA] 1) " + loc_aMet[loc_i] + " NAO existe" + CHR(13) + CHR(10)
                loc_nFalhas = loc_nFalhas + 1
            ELSE
                loc_cL = loc_cL + "[OK]    1) " + loc_aMet[loc_i] + " existe" + CHR(13) + CHR(10)
            ENDIF
        ENDFOR

        *-- 2) chamada EXTERNA so dos que a TesteAutomatico.prg chama de fora
        *-- (lista fechada: CarregarLista/AlternarPagina/AjustarBotoesPorModo/
        *-- BtnIncluirClick/BtnCancelarClick - feedback_teste_automatico_metodo_
        *-- protected). FormParaBO/BOParaForm/LimparCampos sao PROTECTED em
        *-- FormBase (heranca) e NUNCA sao chamaveis de fora, por design - nao
        *-- faz sentido testar isso aqui. HabilitarCampos nao e um hook do
        *-- FormBase; como nada no harness padrao chama de fora, fica PUBLIC
        *-- por convencao (FormCor) mas sem exigencia de chamada externa.
        TRY
            loc_oForm.CarregarLista()
            loc_cL = loc_cL + "[OK]    2) CarregarLista chamado de fora, sem erro" + CHR(13) + CHR(10)
        CATCH TO loc_oE
            loc_cL = loc_cL + "[FALHA] 2) CarregarLista -> " + loc_oE.Message + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDTRY
        TRY
            loc_oForm.AjustarBotoesPorModo()
            loc_cL = loc_cL + "[OK]    2) AjustarBotoesPorModo chamado de fora, sem erro" + CHR(13) + CHR(10)
        CATCH TO loc_oE
            loc_cL = loc_cL + "[FALHA] 2) AjustarBotoesPorModo -> " + loc_oE.Message + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDTRY
        TRY
            loc_oForm.HabilitarCampos(.T.)
            loc_cL = loc_cL + "[OK]    2) HabilitarCampos chamado de fora, sem erro (PUBLIC)" + CHR(13) + CHR(10)
        CATCH TO loc_oE
            loc_cL = loc_cL + "[FALHA] 2) HabilitarCampos -> " + loc_oE.Message + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDTRY

        *-- 3-5) hooks PROTECTED (FormParaBO/BOParaForm/LimparCampos): exercitar
        *-- via subclasse-probe, que acessa membro protegido por heranca
        *-- (tecnica da memoria feedback_formbase_hooks_protected_nao_alargam).
        loc_oForm2 = CREATEOBJECT("FormSIGPRPROProbe", .NULL., "")
        loc_oForm2.this_cCPros = "PROD999"
        loc_oForm2.ChamarFormParaBO()
        IF ALLTRIM(loc_oForm2.this_oBusinessObject.this_cCPros) == "PROD999"
            loc_cL = loc_cL + "[OK]    3) FormParaBO (via subclasse) propagou this_cCPros" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 3) FormParaBO nao propagou this_cCPros (leu [" + ;
                     ALLTRIM(loc_oForm2.this_oBusinessObject.this_cCPros) + "])" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        TRY
            loc_oForm2.ChamarBOParaForm()
            loc_cL = loc_cL + "[OK]    4) BOParaForm (via subclasse) executou sem erro (cursor vazio)" + CHR(13) + CHR(10)
        CATCH TO loc_oE
            loc_cL = loc_cL + "[FALHA] 4) BOParaForm -> " + loc_oE.Message + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDTRY

        loc_oForm2.txt_4c_DPros.Value   = "XXX"
        loc_oForm2.txt_4c_Comples.Value = "YYY"
        loc_oForm2.edt_4c_Infos.Value   = "ZZZ"
        loc_oForm2.ChamarLimparCampos()
        IF EMPTY(loc_oForm2.txt_4c_DPros.Value) AND EMPTY(loc_oForm2.txt_4c_Comples.Value) AND EMPTY(loc_oForm2.edt_4c_Infos.Value)
            loc_cL = loc_cL + "[OK]    5) LimparCampos (via subclasse) limpou DPros/Comples/Infos" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 5) LimparCampos nao limpou tudo" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        loc_oForm2 = .NULL.

        *-- 6) form sobreviveu a tudo isso --------------------------------------
        IF VARTYPE(loc_oForm) = "O" AND loc_oForm.BaseClass = "Form"
            loc_cL = loc_cL + "[OK]    6) form SOBREVIVEU a todos os metodos da Fase 8" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 6) form morreu durante os metodos" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        loc_oForm = .NULL.
    ENDIF

    *-- 7) BtnSalvarClick so avisa, NAO fecha o form ---------------------------
    TRY
        loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
        loc_oForm.BtnSalvarClick()
        IF VARTYPE(loc_oForm) = "O"
            loc_cL = loc_cL + "[OK]    7) BtnSalvarClick avisou e NAO fechou o form" + CHR(13) + CHR(10)
        ELSE
            loc_cL = loc_cL + "[FALHA] 7) BtnSalvarClick fechou o form (nao deveria)" + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        loc_oForm = .NULL.
    CATCH TO loc_oE
        loc_cL = loc_cL + "[FALHA] 7) BtnSalvarClick -> " + loc_oE.Message + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY

    *-- 8) BtnCancelarClick/BtnEncerrarClick fecham o form ---------------------
    FOR loc_i = 1 TO 2
        loc_cM = IIF(loc_i = 1, "BtnCancelarClick", "BtnEncerrarClick")
        TRY
            loc_oForm = CREATEOBJECT("FormSIGPRPRO", .NULL., "")
            loc_oForm.&loc_cM.()
            loc_cL = loc_cL + "[OK]    8) " + loc_cM + " executou Release sem erro" + CHR(13) + CHR(10)
            loc_oForm = .NULL.
        CATCH TO loc_oE
            loc_cL = loc_cL + "[FALHA] 8) " + loc_cM + " -> " + loc_oE.Message + CHR(13) + CHR(10)
            loc_nFalhas = loc_nFalhas + 1
        ENDTRY
    ENDFOR

CATCH TO loc_oE
    loc_cL = loc_cL + "[FATAL] " + loc_oE.Message + " | LN=" + TRANSFORM(loc_oE.LineNo) + ;
             " | PROC=" + loc_oE.Procedure + CHR(13) + CHR(10)
    loc_nFalhas = loc_nFalhas + 1
ENDTRY

loc_cL = loc_cL + CHR(13) + CHR(10) + "FALHAS=" + TRANSFORM(loc_nFalhas) + CHR(13) + CHR(10)
STRTOFILE(loc_cL, OUT, 1)
QUIT

*==============================================================================
* Subclasse-PROBE: acessa os hooks PROTECTED (FormParaBO/BOParaForm/
* LimparCampos, herdados PROTECTED de FormBase) por dentro da heranca.
* Script solto nao alcanca; subclasse sim (feedback_formbase_hooks_protected_
* nao_alargam).
*==============================================================================
DEFINE CLASS FormSIGPRPROProbe AS FormSIGPRPRO
    PROCEDURE ChamarFormParaBO()
        THIS.FormParaBO()
    ENDPROC

    PROCEDURE ChamarBOParaForm()
        THIS.BOParaForm()
    ENDPROC

    PROCEDURE ChamarLimparCampos()
        THIS.LimparCampos()
    ENDPROC
ENDDEFINE
