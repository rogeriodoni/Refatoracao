*==============================================================================
* InstantiateCheckSigPrDscF8.prg - Fase 8 / task601
* Prova que FormSigPrDsc ABRE e exercita o que a Fase 8 acrescentou:
*   - handlers renomeados (BtnGravarClick / BtnCancelarClick) sao PUBLIC
*   - funil AjustarBotoesPorModo nos estados do botao Atualizar
*   - par FormParaBO -> BO.NormalizarFiltros -> BOParaForm (espelha a faixa)
*   - BO.TemFiltro como guarda de "Nenhum Filtro Foi Informado"
*
* NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (memoria
* feedback_configurarambiente_bloqueia_probe_de_form) - o probe carrega a mao
* so as dependencias deste form. STRTOFILE a cada etapa para que, se algo
* pendurar, o log diga QUAL chamada foi.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

#DEFINE LOG_FILE "C:\4c\automation\instantiate_sigprdsc_f8_result.txt"

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gb_4c_ValidandoUI
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprdsc_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_oForm, loc_oErro, loc_oBO, loc_lEnab1, loc_lEnab2, loc_lEnab3
STRTOFILE("ETAPA 0: inicio" + CHR(13) + CHR(10), LOG_FILE)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg

    *-- DEPOIS do config.prg: ele proprio faz gb_4c_ValidandoUI = .F. (linha
    *-- 118), entao setar antes nao vale nada. Com a flag ligada o
    *-- InicializarForm pula o SELECT do dicionario (sem banco neste probe -
    *-- gnConnHandle nem existe, porque ConfigurarAmbiente nao foi chamada).
    gb_4c_ValidandoUI = .T.
    STRTOFILE("ETAPA 1: config.prg OK, ValidandoUI=" + ;
              TRANSFORM(gb_4c_ValidandoUI) + CHR(13) + CHR(10), LOG_FILE, 1)

    SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
                 gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
                 gc_4c_CaminhoIcones)

    SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg")  ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "fwprogressbar.prg") ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")     ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")      ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigPrDscBO.prg")    ADDITIVE
    SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigPrDsc.prg") ADDITIVE
    STRTOFILE("ETAPA 2: SET PROCEDURE OK" + CHR(13) + CHR(10), LOG_FILE, 1)

    loc_oForm = CREATEOBJECT("FormSigPrDsc")
    STRTOFILE("ETAPA 3: CREATEOBJECT devolveu " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), LOG_FILE, 1)

    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("FAIL: form nao instanciou" + CHR(13) + CHR(10), LOG_FILE, 1)
    ELSE
        STRTOFILE("OK ABRIU W=" + TRANSFORM(loc_oForm.Width) + ;
                  " H=" + TRANSFORM(loc_oForm.Height) + CHR(13) + CHR(10), LOG_FILE, 1)

        *-- 1) membros da Fase 8 existem
        STRTOFILE("MEMBROS:" + ;
            " BtnGravarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnGravarClick", 5)) + ;
            " BtnCancelarClick=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 5)) + ;
            " AjustarBotoesPorModo=" + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 5)) + ;
            " FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
            " BOParaForm=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
            " CarregarLista=" + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
            " this_lListaPronta=" + TRANSFORM(PEMSTATUS(loc_oForm, "this_lListaPronta", 5)) + ;
            CHR(13) + CHR(10), LOG_FILE, 1)

        *-- 2) estado inicial: lista vazia e nao pronta -> Atualizar desligado
        STRTOFILE("INICIAL: ListaPronta=" + TRANSFORM(loc_oForm.this_lListaPronta) + ;
            " AtualizarEnabled=" + TRANSFORM(loc_oForm.cmd_4c_BtnAtualizar.Enabled) + ;
            CHR(13) + CHR(10), LOG_FILE, 1)

        *-- O cursor vive na sessao PRIVADA do form (DataSession = 2): para
        *-- mexer nele de fora eh preciso entrar na sessao.
        SET DATASESSION TO loc_oForm.DataSessionId

        *-- 3) funil: com linha na lista e selecao PRONTA -> liga
        SELECT cursor_4c_Produtos
        INSERT INTO cursor_4c_Produtos (CPros, Portugues, Traduzido) ;
            VALUES ("TESTE01", "CAMISA AZUL", "BLUE SHIRT")
        loc_oForm.this_lListaPronta = .T.
        loc_oForm.AjustarBotoesPorModo()
        loc_lEnab1 = loc_oForm.cmd_4c_BtnAtualizar.Enabled

        *-- 4) funil: mesma linha, mas selecao NAO pronta -> desliga
        loc_oForm.this_lListaPronta = .F.
        loc_oForm.AjustarBotoesPorModo()
        loc_lEnab2 = loc_oForm.cmd_4c_BtnAtualizar.Enabled

        *-- 5) funil: pronta mas lista VAZIA -> desliga (If Not Eof legado)
        SELECT cursor_4c_Produtos
        ZAP
        loc_oForm.this_lListaPronta = .T.
        loc_oForm.AjustarBotoesPorModo()
        loc_lEnab3 = loc_oForm.cmd_4c_BtnAtualizar.Enabled

        STRTOFILE("FUNIL: prontaComLinha=" + TRANSFORM(loc_lEnab1) + ;
            " naoProntaComLinha=" + TRANSFORM(loc_lEnab2) + ;
            " prontaSemLinha=" + TRANSFORM(loc_lEnab3) + ;
            " (esperado .T. .F. .F.)" + CHR(13) + CHR(10), LOG_FILE, 1)

        *-- 6) guarda de filtro vazio: BtnSelecionarClick com os 3 campos em
        *--    branco passa por FormParaBO, BO.TemFiltro devolve .F. e o metodo
        *--    sai sem chamar Processamento (nao ha banco neste probe).
        loc_oForm.txt_4c_CProsI.Value = ""
        loc_oForm.txt_4c_CProsF.Value = ""
        loc_oForm.txt_4c_CGrus.Value  = ""
        loc_oForm.BtnSelecionarClick()
        STRTOFILE("FILTRO VAZIO: saiu sem excecao, BO.CProsI=[" + ;
            loc_oForm.this_oBusinessObject.this_cCProsI + "]" + CHR(13) + CHR(10), LOG_FILE, 1)

        *-- 7) par FormParaBO -> NormalizarFiltros -> BOParaForm: so a ponta
        *--    inicial preenchida; ao voltar, a ponta final tem de estar
        *--    espelhada NA TELA. Processamento() estoura por falta de conexao
        *--    (probe sem banco) DEPOIS de BOParaForm, entao o TRY eh local.
        loc_oForm.txt_4c_CProsI.Value = "PRD0001"
        loc_oForm.txt_4c_CProsF.Value = ""
        loc_oForm.txt_4c_CGrus.Value  = ""
        TRY
            loc_oForm.BtnSelecionarClick()
        CATCH
        ENDTRY
        STRTOFILE("ESPELHO: telaI=[" + ALLTRIM(loc_oForm.txt_4c_CProsI.Value) + ;
            "] telaF=[" + ALLTRIM(loc_oForm.txt_4c_CProsF.Value) + ;
            "] boI=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cCProsI) + ;
            "] boF=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cCProsF) + ;
            "] (esperado PRD0001 nos quatro)" + CHR(13) + CHR(10), LOG_FILE, 1)

        *-- 8) BtnGravarClick com lista vazia: sai logo, sem tocar no banco
        loc_oForm.BtnGravarClick()
        STRTOFILE("GRAVAR LISTA VAZIA: saiu sem excecao" + CHR(13) + CHR(10), LOG_FILE, 1)

        SET DATASESSION TO 1

        *-- 9) BO isolado: espelho da outra ponta e TemFiltro
        loc_oBO = CREATEOBJECT("SigPrDscBO")
        loc_oBO.this_cCProsI = ""
        loc_oBO.this_cCProsF = "PRD0009"
        loc_oBO.NormalizarFiltros()
        STRTOFILE("BO ESPELHO INVERSO: I=[" + ALLTRIM(loc_oBO.this_cCProsI) + ;
            "] F=[" + ALLTRIM(loc_oBO.this_cCProsF) + "]" + CHR(13) + CHR(10), LOG_FILE, 1)

        loc_oBO.this_cCProsI = ""
        loc_oBO.this_cCProsF = ""
        loc_oBO.this_cCGrus  = ""
        STRTOFILE("BO TemFiltro vazio=" + TRANSFORM(loc_oBO.TemFiltro()), LOG_FILE, 1)
        loc_oBO.this_cCGrus = "001"
        STRTOFILE(" soGrupo=" + TRANSFORM(loc_oBO.TemFiltro()) + ;
            " (esperado .F. .T.)" + CHR(13) + CHR(10), LOG_FILE, 1)

        *-- 10) fechar pelo handler do botao Encerrar (Cancel = .T. no legado)
        loc_oForm.BtnCancelarClick()
        STRTOFILE("BtnCancelarClick: fechou sem excecao" + CHR(13) + CHR(10), LOG_FILE, 1)
        STRTOFILE("PROBE COMPLETO" + CHR(13) + CHR(10), LOG_FILE, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE("EXCEPTION: " + loc_oErro.Message + ;
              " Linha:" + TRANSFORM(loc_oErro.LineNo) + ;
              " Proc:" + loc_oErro.Procedure + CHR(13) + CHR(10), LOG_FILE, 1)
ENDTRY

QUIT
