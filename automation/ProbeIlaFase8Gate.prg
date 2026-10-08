*==============================================================================
* ProbeIlaFase8Gate.prg - Probe da Fase 8 de Formsigprila (task627)
*
* Prova, medindo em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA com o BOParaForm novo rodando dentro do InicializarForm
*   2) o painel abre no estado dos criterios do BO (fonte unica)
*   3) ida-e-volta FormParaBO -> BOParaForm preserva os 4 criterios
*   4) o piso 1-based do OptionGroup protege contra property fora de faixa
*   5) a cauda do Processamento limpa o arquivo em UM lugar so (BO) e o
*      BOParaForm reflete no campo - sem SetFocus (form nao esta Show())
*   6) os handlers renomeados existem e sao PUBLIC (BINDEVENT exige - regra #3)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ilagate.txt"
#DEFINE OUT "C:\4c\automation\probe_ilagate.txt"

LOCAL loc_oE, loc_oForm, loc_cL, loc_oPnl, loc_oBO, loc_nFalhas
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - Formsigprila (BOParaForm + handlers Btn*) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "fwprogressbar.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigprilaBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigprila.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeIlaFase8Gate.prg"     ADDITIVE

    gnConnHandle = -1

    *-- 1) o form ABRE com o BOParaForm dentro do InicializarForm?
    loc_oForm = CREATEOBJECT("ProbeIlaGate")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
              IIF(VARTYPE(loc_oForm) = "O", " Caption=[" + loc_oForm.Caption + "]", ;
                  " *** NAO ABRIU ***") + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("ABORTADO" + CHR(13) + CHR(10), OUT, 1)
        QUIT
    ENDIF

    loc_oPnl = loc_oForm.cnt_4c_planilha
    loc_oBO  = loc_oForm.this_oBusinessObject

    *-- 2) painel abriu no estado do BO?
    loc_cL = "2) estado pos-Init (tela <-> BO):" + CHR(13) + CHR(10) + ;
             "   txt_4c_Planilha=[" + loc_oPnl.txt_4c_Planilha.Value + "]" + ;
             " BO.this_cArquivoPlanilha=[" + loc_oBO.this_cArquivoPlanilha + "]" + CHR(13) + CHR(10) + ;
             "   chk.Value=" + TRANSFORM(loc_oPnl.chk_4c_ChkCabecalho.Value) + ;
             " (tipo " + VARTYPE(loc_oPnl.chk_4c_ChkCabecalho.Value) + ")" + ;
             " BO.this_lIncluiCabecalho=" + TRANSFORM(loc_oBO.this_lIncluiCabecalho) + CHR(13) + CHR(10) + ;
             "   OptTipo.Value=" + TRANSFORM(loc_oPnl.obj_4c_OptTipo.Value) + ;
             " BO.this_nTipoBusca=" + TRANSFORM(loc_oBO.this_nTipoBusca) + CHR(13) + CHR(10) + ;
             "   OptPreco.Value=" + TRANSFORM(loc_oPnl.obj_4c_OptPreco.Value) + ;
             " BO.this_nTipoPreco=" + TRANSFORM(loc_oBO.this_nTipoPreco) + CHR(13) + CHR(10)
    IF loc_oPnl.obj_4c_OptTipo.Value != loc_oBO.this_nTipoBusca OR ;
       loc_oPnl.obj_4c_OptPreco.Value != loc_oBO.this_nTipoPreco
        loc_cL = loc_cL + "   *** FALHA: tela e BO divergem no Init" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) ida-e-volta dos 4 criterios
    loc_oForm.CompletaLista()
    loc_oPnl.txt_4c_Planilha.Value     = "C:\4c\automation\_nao_existe_.xls"
    loc_oPnl.chk_4c_ChkCabecalho.Value = 1
    loc_oPnl.obj_4c_OptTipo.Value      = 3
    loc_oPnl.obj_4c_OptPreco.Value     = 2
    loc_oForm.TesteFormParaBO()

    loc_cL = "3) depois do FormParaBO - BO recebeu:" + CHR(13) + CHR(10) + ;
             "   arquivo=[" + loc_oBO.this_cArquivoPlanilha + "]" + ;
             " cabecalho=" + TRANSFORM(loc_oBO.this_lIncluiCabecalho) + ;
             " tipoBusca=" + TRANSFORM(loc_oBO.this_nTipoBusca) + ;
             " tipoPreco=" + TRANSFORM(loc_oBO.this_nTipoPreco) + ;
             " rotina=[" + ALLTRIM(loc_oBO.this_cRotina) + "]" + CHR(13) + CHR(10)
    IF loc_oBO.this_nTipoBusca != 3 OR loc_oBO.this_nTipoPreco != 2 OR ;
       !loc_oBO.this_lIncluiCabecalho OR EMPTY(loc_oBO.this_cArquivoPlanilha)
        loc_cL = loc_cL + "   *** FALHA: FormParaBO nao transferiu tudo" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF

    *-- zera os controles e manda o BO reconstruir a tela
    loc_oPnl.txt_4c_Planilha.Value     = ""
    loc_oPnl.chk_4c_ChkCabecalho.Value = 0
    loc_oPnl.obj_4c_OptTipo.Value      = 1
    loc_oPnl.obj_4c_OptPreco.Value     = 1
    loc_oForm.TesteBOParaForm()

    loc_cL = loc_cL + "   depois do BOParaForm - tela reconstruida:" + CHR(13) + CHR(10) + ;
             "   arquivo=[" + loc_oPnl.txt_4c_Planilha.Value + "]" + ;
             " chk=" + TRANSFORM(loc_oPnl.chk_4c_ChkCabecalho.Value) + ;
             " OptTipo=" + TRANSFORM(loc_oPnl.obj_4c_OptTipo.Value) + ;
             " OptPreco=" + TRANSFORM(loc_oPnl.obj_4c_OptPreco.Value) + CHR(13) + CHR(10)
    IF loc_oPnl.obj_4c_OptTipo.Value != 3 OR loc_oPnl.obj_4c_OptPreco.Value != 2 OR ;
       loc_oPnl.chk_4c_ChkCabecalho.Value != 1 OR ;
       ALLTRIM(loc_oPnl.txt_4c_Planilha.Value) != ALLTRIM(loc_oBO.this_cArquivoPlanilha)
        loc_cL = loc_cL + "   *** FALHA: BOParaForm nao devolveu os criterios" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) piso 1-based do OptionGroup (property fora de faixa)
    loc_oBO.this_nTipoBusca = 0
    loc_oBO.this_nTipoPreco = 99
    loc_oForm.TesteBOParaForm()
    loc_cL = "4) guarda 1-based: BO 0/99 -> OptTipo=" + TRANSFORM(loc_oPnl.obj_4c_OptTipo.Value) + ;
             " OptPreco=" + TRANSFORM(loc_oPnl.obj_4c_OptPreco.Value) + " (esperado 1 e 1)" + CHR(13) + CHR(10)
    IF loc_oPnl.obj_4c_OptTipo.Value != 1 OR loc_oPnl.obj_4c_OptPreco.Value != 1
        loc_cL = loc_cL + "   *** FALHA: guarda de faixa nao protegeu" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) cauda do Processamento: limpa no BO e reflete no campo
    loc_oBO.this_nTipoBusca            = 2
    loc_oBO.this_nTipoPreco            = 2
    loc_oPnl.obj_4c_OptTipo.Value      = 2
    loc_oPnl.obj_4c_OptPreco.Value     = 2
    loc_oPnl.chk_4c_ChkCabecalho.Value = 1
    loc_oPnl.txt_4c_Planilha.Value     = "C:\4c\automation\_nao_existe_.xls"
    loc_oForm.Processamento()
    loc_cL = "5) depois do Processamento (CriaPlanilha falha - .xls inexistente):" + CHR(13) + CHR(10) + ;
             "   campo arquivo=[" + loc_oPnl.txt_4c_Planilha.Value + "]" + ;
             " BO.arquivo=[" + loc_oBO.this_cArquivoPlanilha + "] (ambos vazios = cauda do legado)" + CHR(13) + CHR(10) + ;
             "   criterios preservados: OptTipo=" + TRANSFORM(loc_oPnl.obj_4c_OptTipo.Value) + ;
             " OptPreco=" + TRANSFORM(loc_oPnl.obj_4c_OptPreco.Value) + ;
             " chk=" + TRANSFORM(loc_oPnl.chk_4c_ChkCabecalho.Value) + CHR(13) + CHR(10)
    IF !EMPTY(loc_oPnl.txt_4c_Planilha.Value) OR !EMPTY(loc_oBO.this_cArquivoPlanilha)
        loc_cL = loc_cL + "   *** FALHA: a cauda nao limpou o arquivo" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    IF loc_oPnl.obj_4c_OptTipo.Value != 2 OR loc_oPnl.obj_4c_OptPreco.Value != 2 OR ;
       loc_oPnl.chk_4c_ChkCabecalho.Value != 1
        loc_cL = loc_cL + "   *** FALHA: a cauda stompou criterio do usuario" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5b) o criterio do usuario sobrevive quando CriaPlanilha recusa.
    *--     Com o FormParaBO rodando DEPOIS do CriaPlanilha (como era antes),
    *--     o BOParaForm da cauda devolveria o valor VELHO do BO por cima do
    *--     que o usuario acabou de marcar. Aqui tela e BO comecam
    *--     DIVERGENTES de proposito, para o teste saber diferenciar.
    loc_oBO.this_nTipoBusca            = 1
    loc_oBO.this_nTipoPreco            = 1
    loc_oBO.this_lIncluiCabecalho      = .F.
    loc_oPnl.obj_4c_OptTipo.Value      = 3
    loc_oPnl.obj_4c_OptPreco.Value     = 2
    loc_oPnl.chk_4c_ChkCabecalho.Value = 1
    loc_oPnl.txt_4c_Planilha.Value     = ""
    loc_oForm.Processamento()
    loc_cL = "5b) CriaPlanilha recusa com tela(3/2/1) x BO(1/1/.F.) divergentes:" + CHR(13) + CHR(10) + ;
             "    OptTipo=" + TRANSFORM(loc_oPnl.obj_4c_OptTipo.Value) + ;
             " OptPreco=" + TRANSFORM(loc_oPnl.obj_4c_OptPreco.Value) + ;
             " chk=" + TRANSFORM(loc_oPnl.chk_4c_ChkCabecalho.Value) + ;
             " (esperado 3 / 2 / 1 - o que o usuario marcou)" + CHR(13) + CHR(10)
    IF loc_oPnl.obj_4c_OptTipo.Value != 3 OR loc_oPnl.obj_4c_OptPreco.Value != 2 OR ;
       loc_oPnl.chk_4c_ChkCabecalho.Value != 1
        loc_cL = loc_cL + "    *** FALHA: a cauda devolveu criterio VELHO por cima da tela" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) handlers renomeados existem e sao PUBLIC (chamaveis de FORA)
    loc_cL = "6) handlers (PEMSTATUS 5 = existe / chamada real = PUBLIC):" + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   BtnProcessarClick   existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   BtnEncerrarClick    existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   BtnGetPlanilhaClick existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnGetPlanilhaClick", 5)) + CHR(13) + CHR(10)
    loc_cL = loc_cL + "   CboTiposInteractiveChange existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "CboTiposInteractiveChange", 5)) + CHR(13) + CHR(10)
    IF !PEMSTATUS(loc_oForm, "BtnProcessarClick", 5) OR !PEMSTATUS(loc_oForm, "BtnEncerrarClick", 5) OR ;
       !PEMSTATUS(loc_oForm, "BtnGetPlanilhaClick", 5)
        loc_cL = loc_cL + "   *** FALHA: handler ausente" + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    *-- chamada REAL de fora da classe: PROTECTED estouraria aqui (regra #3)
    TRY
        loc_oForm.CboTiposInteractiveChange()
        loc_cL = loc_cL + "   CboTiposInteractiveChange() chamado de fora: OK (PUBLIC)" + CHR(13) + CHR(10)
    CATCH TO loc_oE
        loc_cL = loc_cL + "   *** FALHA ao chamar CboTiposInteractiveChange: " + loc_oE.Message + CHR(13) + CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDTRY
    STRTOFILE(loc_cL, OUT, 1)

    *-- BtnEncerrarClick por ultimo: ele faz Release()
    loc_oForm.BtnEncerrarClick()
    STRTOFILE("7) BtnEncerrarClick() chamado de fora: OK (PUBLIC) - form liberado" + CHR(13) + CHR(10), OUT, 1)

    STRTOFILE("=== FIM - FALHAS: " + TRANSFORM(loc_nFalhas) + " ===" + CHR(13) + CHR(10), OUT, 1)

CATCH TO loc_oE
    STRTOFILE("EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10) + ;
              "  Linha: " + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10) + ;
              "  Proc : " + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT


*==============================================================================
* ProbeIlaGate - subclasse so para alcancar os hooks PROTECTED (FormParaBO /
* BOParaForm devem CONTINUAR PROTECTED: FormBase os declara assim e o VFP9
* nao deixa a subclasse alargar o escopo)
*==============================================================================
DEFINE CLASS ProbeIlaGate AS Formsigprila

    PROCEDURE TesteFormParaBO()
        THIS.FormParaBO()
    ENDPROC

    PROCEDURE TesteBOParaForm()
        THIS.BOParaForm()
    ENDPROC

ENDDEFINE
