*==============================================================================
* Probe727F6.prg - Probe da Fase 6 de Formsigopecm (task727)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA depois das mudancas da Fase 6
*   2) a ordem de tabulacao MEDIDA (1..8) sobreviveu a remocao dos literais
*      TabIndex 6/5 que ConfigurarBotoes gravava nos dois botoes de acao
*   3) this_lProcessando existe e nasce .F.
*   4) escopo REAL: BtnProcessarClick e BtnProcessarClickExec PUBLICOS
*      (PEMSTATUS ...,2 = .F.), porque BINDEVENT e o harness os alcancam de
*      fora da classe (regras #3/#51)
*   5) a guarda de REENTRANCIA BLOQUEIA o 2o acionamento: com a flag em .T.,
*      BtnProcessarClick devolve SEM entrar no TRY - prova-se porque o
*      FINALLY (que zeraria a flag) nao roda, logo a flag CONTINUA .T.
*   6) a guarda LIBERA a flag mesmo com RETURN antecipado: em modo teste
*      MsgConfirma devolve .F., entao BtnProcessarClickExec faz RETURN logo
*      na 1a linha - o caminho que travaria um set/clear simples (regra #47)
*   7) o BO ainda expoe this_lExportarImagens (property mantida de proposito)
*
* Toda chamada vai em TRY/CATCH proprio - sem isso um Program Error abre
* dialogo que ninguem fecha e o probe pendura MUDO.
*
* NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (o probe
* morreria por timeout antes do CREATEOBJECT). So DO config.prg mais as
* dependencias do form, como nos probes anteriores.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado

#DEFINE OUT "C:\4c\automation\probe_727f6.txt"

LOCAL loc_oE, loc_oForm, loc_nI, loc_cLinha, loc_oCtl, loc_lAntes, loc_lDepois

STRTOFILE("=== PROBE Fase 6 - Formsigopecm (task727) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_727f6.txt"
    gc_4c_UsuarioLogado    = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigopecmBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigopecm.prg") ADDITIVE
    gnConnHandle = -1
    STRTOFILE("[1] dependencias carregadas OK" + CHR(13) + CHR(10), OUT, .T.)
CATCH TO loc_oE
    STRTOFILE("[1] FALHA ao carregar: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10), OUT, .T.)
ENDTRY

*-- 2) INSTANCIACAO ---------------------------------------------------------
TRY
    loc_oForm = CREATEOBJECT("Formsigopecm")
    STRTOFILE("[2] CREATEOBJECT  VARTYPE=" + VARTYPE(loc_oForm) + "  (esperado O)" + CHR(13) + CHR(10), OUT, .T.)
CATCH TO loc_oE
    STRTOFILE("[2] EXCECAO: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, .T.)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 3) ControlCount e ordem de tabulacao -------------------------------
    TRY
        STRTOFILE("[3] ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + "  (esperado 10)" + CHR(13) + CHR(10), OUT, .T.)
        loc_cLinha = ""
        FOR loc_nI = 1 TO loc_oForm.ControlCount
            loc_oCtl = loc_oForm.Controls(loc_nI)
            IF PEMSTATUS(loc_oCtl, "TabIndex", 5)
                loc_cLinha = loc_cLinha + "    " + PADR(loc_oCtl.Name, 22) + " TabIndex=" + TRANSFORM(loc_oCtl.TabIndex) + "  Visible=" + TRANSFORM(loc_oCtl.Visible) + CHR(13) + CHR(10)
            ELSE
                loc_cLinha = loc_cLinha + "    " + PADR(loc_oCtl.Name, 22) + " [sem TabIndex]  Visible=" + TRANSFORM(loc_oCtl.Visible) + CHR(13) + CHR(10)
            ENDIF
        ENDFOR
        STRTOFILE(loc_cLinha, OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[3] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 4) property da guarda e escopo dos metodos -------------------------
    TRY
        STRTOFILE("[4] this_lProcessando existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "this_lProcessando", 5)) + "  valor=" + TRANSFORM(loc_oForm.this_lProcessando) + CHR(13) + CHR(10), OUT, .T.)
        STRTOFILE("[4] BtnProcessarClick     existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClick", 2)) + CHR(13) + CHR(10), OUT, .T.)
        STRTOFILE("[4] BtnProcessarClickExec existe=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClickExec", 5)) + "  Protected=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnProcessarClickExec", 2)) + CHR(13) + CHR(10), OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[4] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 5) a guarda BLOQUEIA a reentrancia ---------------------------------
    *    flag em .T. faz BtnProcessarClick devolver ANTES do TRY, logo o
    *    FINALLY nao roda e a flag CONTINUA .T.
    TRY
        loc_oForm.this_lProcessando = .T.
        loc_oForm.BtnProcessarClick()
        loc_lDepois = loc_oForm.this_lProcessando
        STRTOFILE("[5] reentrante: flag depois=" + TRANSFORM(loc_lDepois) + "  BLOQUEOU=" + TRANSFORM(loc_lDepois) + "  (esperado .T.)" + CHR(13) + CHR(10), OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[5] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 6) a guarda LIBERA a flag apesar do RETURN antecipado --------------
    *    em modo teste MsgConfirma devolve .F., entao Exec faz RETURN na 1a
    *    linha - exatamente o caminho que travaria um set/clear simples
    TRY
        loc_oForm.this_lProcessando = .F.
        loc_lAntes = loc_oForm.this_lProcessando
        loc_oForm.BtnProcessarClick()
        loc_lDepois = loc_oForm.this_lProcessando
        STRTOFILE("[6] 1a chamada: flag antes=" + TRANSFORM(loc_lAntes) + " depois=" + TRANSFORM(loc_lDepois) + "  LIBEROU=" + TRANSFORM(!loc_lDepois) + "  (esperado .T.)" + CHR(13) + CHR(10), OUT, .T.)
        loc_oForm.BtnProcessarClick()
        STRTOFILE("[6] 2a chamada sequencial: flag=" + TRANSFORM(loc_oForm.this_lProcessando) + "  (esperado .F. - o botao NAO morreu)" + CHR(13) + CHR(10), OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[6] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 7) BO: property mantida de proposito -------------------------------
    TRY
        STRTOFILE("[7] BO this_lExportarImagens existe=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "this_lExportarImagens", 5)) + "  valor=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lExportarImagens) + CHR(13) + CHR(10), OUT, .T.)
        STRTOFILE("[7] BO GerarArquivoExportacao Protected=" + TRANSFORM(PEMSTATUS(loc_oForm.this_oBusinessObject, "GerarArquivoExportacao", 2)) + "  (esperado .F.)" + CHR(13) + CHR(10), OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[7] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    TRY
        loc_oForm.Release()
    CATCH TO loc_oE
    ENDTRY
ENDIF

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), OUT, .T.)
QUIT
