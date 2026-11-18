*==============================================================================
* Probe809F6.prg - Probe da Fase 6 de Formsigoptef (task809)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA depois das mudancas da Fase 6
*   2) os 13 BINDEVENT da Fase 6 estao REALMENTE ligados - via AEVENTS com
*      DOIS argumentos, lendo o evento na coluna 3 (AEVENTS(a, oObjeto))
*   3) escopo REAL dos alvos de BINDEVENT: todos PUBLICOS
*      (PEMSTATUS ..., 2 = .F.), senao o delegate nunca roda (regra #3)
*   4) o gate de foco de GetValor (When = "Return .f." no legado) chegou ao
*      controle: ReadOnly = .T. e TabStop = .F., sem Enabled = .F.
*   5) ValidarParcela / ValidarCartao devolvem o que o legado devolve, por
*      ATRIBUICAO de .Value (nao por KEYBOARD, que nao dirige campo com
*      Format/InputMask em harness)
*   6) os dois GotFocus de rotulo escrevem no painel de instrucao
*   7) o Timer rearma o ESC e se DESLIGA
*   8) a camada de acesso a DLL do BO existe, eh publica, e devolve os
*      valores de FALHA do legado nesta maquina SEM a CliSiTef32I.DLL
*      (this_lSiTefDisponivel = .F. -> .F./.F./-1/-1)
*
* Toda chamada vai em TRY/CATCH proprio - sem isso um Program Error abre
* dialogo que ninguem fecha e o probe pendura MUDO.
*
* NAO chama ConfigurarAmbiente(): ela nao retorna nesta maquina (o probe
* morreria por timeout antes do CREATEOBJECT). So DO config.prg mais as
* dependencias do form.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado

#DEFINE OUT "C:\4c\automation\probe_809f6.txt"

LOCAL loc_oE, loc_oForm, loc_oBO, loc_nI, loc_cLinha, loc_nQtd
LOCAL ARRAY loc_aEv[1, 5]

STRTOFILE("=== PROBE Fase 6 - Formsigoptef (task809) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste        = .T.
    gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_809f6.txt"
    gc_4c_UsuarioLogado    = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "sigoptefBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigoptef.prg") ADDITIVE
    gnConnHandle = -1
    STRTOFILE("[1] dependencias carregadas OK" + CHR(13) + CHR(10), OUT, .T.)
CATCH TO loc_oE
    STRTOFILE("[1] FALHA ao carregar: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10), OUT, .T.)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("Formsigoptef")
    STRTOFILE("[2] CREATEOBJECT  VARTYPE=" + VARTYPE(loc_oForm) + "  (esperado O)" + CHR(13) + CHR(10), OUT, .T.)
CATCH TO loc_oE
    STRTOFILE("[2] EXCECAO: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, .T.)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 3) BINDEVENT realmente ligados -------------------------------------
    TRY
        loc_cLinha = ""
        loc_nQtd   = AEVENTS(loc_aEv, loc_oForm.txt_4c_Digitos)
        loc_cLinha = loc_cLinha + "    txt_4c_Digitos  binds=" + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_nQtd
            loc_cLinha = loc_cLinha + "        " + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + CHR(13) + CHR(10)
        ENDFOR

        loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_Parcela)
        loc_cLinha = loc_cLinha + "    txt_4c_Parcela  binds=" + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_nQtd
            loc_cLinha = loc_cLinha + "        " + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + CHR(13) + CHR(10)
        ENDFOR

        loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_Cartao)
        loc_cLinha = loc_cLinha + "    txt_4c_Cartao   binds=" + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_nQtd
            loc_cLinha = loc_cLinha + "        " + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + CHR(13) + CHR(10)
        ENDFOR

        loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_Codigo)
        loc_cLinha = loc_cLinha + "    txt_4c_Codigo   binds=" + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_nQtd
            loc_cLinha = loc_cLinha + "        " + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + CHR(13) + CHR(10)
        ENDFOR

        loc_nQtd = AEVENTS(loc_aEv, loc_oForm.txt_4c_Text1)
        loc_cLinha = loc_cLinha + "    txt_4c_Text1    binds=" + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_nQtd
            loc_cLinha = loc_cLinha + "        " + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + CHR(13) + CHR(10)
        ENDFOR

        loc_nQtd = AEVENTS(loc_aEv, loc_oForm.obj_4c_Timer1)
        loc_cLinha = loc_cLinha + "    obj_4c_Timer1   binds=" + TRANSFORM(loc_nQtd) + CHR(13) + CHR(10)
        FOR loc_nI = 1 TO loc_nQtd
            loc_cLinha = loc_cLinha + "        " + UPPER(loc_aEv[loc_nI, 3]) + " -> " + UPPER(loc_aEv[loc_nI, 4]) + CHR(13) + CHR(10)
        ENDFOR

        STRTOFILE("[3] BINDEVENT medidos por AEVENTS:" + CHR(13) + CHR(10) + loc_cLinha, OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[3] EXCECAO: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 4) escopo dos alvos de BINDEVENT (tem de ser PUBLICO) --------------
    TRY
        loc_cLinha = ""
        loc_cLinha = loc_cLinha + "    DigitosWhen        Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "DigitosWhen", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    DigitosLostFocus   Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "DigitosLostFocus", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ParcelaWhen        Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "ParcelaWhen", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ParcelaKeyPress    Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "ParcelaKeyPress", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    CartaoKeyPress     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "CartaoKeyPress", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    CodSegWhen         Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "CodSegWhen", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    CodSegGotFocus     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "CodSegGotFocus", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    Text1When          Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "Text1When", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    Text1LostFocus     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "Text1LostFocus", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    Text1GotFocus      Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "Text1GotFocus", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    TimerLiberarEsc    Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "TimerLiberarEsc", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ValidarParcela     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarParcela", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ValidarCartao      Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarCartao", 2)) + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ExibirMensagemTef  Prot=" + TRANSFORM(PEMSTATUS(loc_oForm, "ExibirMensagemTef", 2)) + "  (esperado .T.)" + CHR(13) + CHR(10)
        STRTOFILE("[4] escopo (Prot=.F. => PUBLICO):" + CHR(13) + CHR(10) + loc_cLinha, OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[4] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 5) gate de foco de GetValor ----------------------------------------
    TRY
        STRTOFILE("[5] txt_4c_Valor  ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Valor.ReadOnly) + ;
            "  TabStop=" + TRANSFORM(loc_oForm.txt_4c_Valor.TabStop) + ;
            "  Enabled=" + TRANSFORM(loc_oForm.txt_4c_Valor.Enabled) + ;
            "   (esperado .T./.F./.T.)" + CHR(13) + CHR(10), OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[5] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 6) ValidarParcela / ValidarCartao ----------------------------------
    TRY
        loc_cLinha = ""
        loc_oForm.txt_4c_Parcela.Value = "1"
        loc_cLinha = loc_cLinha + "    Parcela='1' -> " + TRANSFORM(loc_oForm.ValidarParcela()) + "  (esperado .T.)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Parcela.Value = "2"
        loc_cLinha = loc_cLinha + "    Parcela='2' -> " + TRANSFORM(loc_oForm.ValidarParcela()) + "  (esperado .T.)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Parcela.Value = " "
        loc_cLinha = loc_cLinha + "    Parcela=' ' -> " + TRANSFORM(loc_oForm.ValidarParcela()) + "  (esperado .T.)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Parcela.Value = "3"
        loc_cLinha = loc_cLinha + "    Parcela='3' -> " + TRANSFORM(loc_oForm.ValidarParcela()) + "  (esperado .F.)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Parcela.Value = ""
        loc_cLinha = loc_cLinha + "    Parcela=''  -> " + TRANSFORM(loc_oForm.ValidarParcela()) + ;
            "  (esperado .T. com SET EXACT ON: '' casa com o ' ' da lista - ver Probe809F6b)" + CHR(13) + CHR(10)

        loc_oForm.txt_4c_Cartao.Value = REPLICATE("9", 19)
        loc_cLinha = loc_cLinha + "    Cartao 19 dig -> " + TRANSFORM(loc_oForm.ValidarCartao()) + "  (esperado .T.)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Cartao.Value = REPLICATE("9", 20)
        loc_cLinha = loc_cLinha + "    Cartao 20 dig -> " + TRANSFORM(loc_oForm.ValidarCartao()) + "  (esperado .F.)" + CHR(13) + CHR(10)
        loc_oForm.txt_4c_Cartao.Value = ""
        STRTOFILE("[6] validacoes por atribuicao:" + CHR(13) + CHR(10) + loc_cLinha, OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[6] EXCECAO: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 7) rotulos do painel de instrucao ----------------------------------
    TRY
        loc_oForm.CodSegGotFocus()
        loc_cLinha = "    apos CodSegGotFocus : [" + STRTRAN(loc_oForm.cnt_4c_Container1.lbl_4c_Label1.Caption, CHR(13), "|") + "]" + CHR(13) + CHR(10)
        loc_oForm.Text1GotFocus()
        loc_cLinha = loc_cLinha + "    apos Text1GotFocus  : [" + STRTRAN(loc_oForm.cnt_4c_Container1.lbl_4c_Label1.Caption, CHR(13), "|") + "]" + CHR(13) + CHR(10)
        STRTOFILE("[7] painel de instrucao:" + CHR(13) + CHR(10) + loc_cLinha, OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[7] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 8) Timer rearma o ESC e se desliga ---------------------------------
    TRY
        loc_oForm.this_lPermiteEsc = .F.
        loc_oForm.obj_4c_Timer1.Enabled = .T.
        loc_oForm.TimerLiberarEsc()
        STRTOFILE("[8] apos TimerLiberarEsc: this_lPermiteEsc=" + TRANSFORM(loc_oForm.this_lPermiteEsc) + ;
            "  Timer.Enabled=" + TRANSFORM(loc_oForm.obj_4c_Timer1.Enabled) + "   (esperado .T./.F.)" + CHR(13) + CHR(10), OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[8] EXCECAO: " + loc_oE.Message + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    *-- 9) camada de acesso a DLL no BO ------------------------------------
    TRY
        loc_oBO = loc_oForm.this_oBusinessObject
        loc_cLinha = ""
        loc_cLinha = loc_cLinha + "    this_lSiTefDisponivel = " + TRANSFORM(loc_oBO.this_lSiTefDisponivel) + "  (maquina sem a DLL -> .F.)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    DeclararFuncoesSiTef  Prot=" + TRANSFORM(PEMSTATUS(loc_oBO, "DeclararFuncoesSiTef", 2)) + "  (esperado .T.)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ConectarSiTef         Prot=" + TRANSFORM(PEMSTATUS(loc_oBO, "ConectarSiTef", 2)) + "  -> " + TRANSFORM(loc_oBO.ConectarSiTef()) + "  (esperado .F./.F.)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    IniciarSiTef          Prot=" + TRANSFORM(PEMSTATUS(loc_oBO, "IniciarSiTef", 2)) + "  -> " + TRANSFORM(loc_oBO.IniciarSiTef("", "")) + "  (esperado .F./.F.)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ContinuarSiTef        Prot=" + TRANSFORM(PEMSTATUS(loc_oBO, "ContinuarSiTef", 2)) + "  -> " + TRANSFORM(loc_oBO.ContinuarSiTef(0)) + "  (esperado .F./-1)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    FinalizarTransacao    Prot=" + TRANSFORM(PEMSTATUS(loc_oBO, "FinalizarTransacaoSiTef", 2)) + "  -> " + TRANSFORM(loc_oBO.FinalizarTransacaoSiTef(0, "1", "", "")) + "  (esperado .F./-1)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ObterDataSiTef        -> [" + loc_oBO.ObterDataSiTef() + "]  (AAAAMMDD)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    ObterHoraSiTef        -> [" + loc_oBO.ObterHoraSiTef() + "]  (HHMMSS)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    MontarBufferSiTef('12') LEN=" + TRANSFORM(LEN(loc_oBO.MontarBufferSiTef("12"))) + "  (esperado 2000)" + CHR(13) + CHR(10)
        loc_cLinha = loc_cLinha + "    MontarBufferSiTef('0',1999) LEN=" + TRANSFORM(LEN(loc_oBO.MontarBufferSiTef("0", 1999))) + "  (esperado 2000)" + CHR(13) + CHR(10)
        loc_oBO.this_nChkBins = 0
        loc_cLinha = loc_cLinha + "    ValidarBinCartao (ChkBins=0) -> " + TRANSFORM(loc_oBO.ValidarBinCartao("123456")) + "  (esperado .T. - checagem desligada)" + CHR(13) + CHR(10)
        STRTOFILE("[9] camada de acesso a DLL (BO):" + CHR(13) + CHR(10) + loc_cLinha, OUT, .T.)
    CATCH TO loc_oE
        STRTOFILE("[9] EXCECAO: " + loc_oE.Message + " LN=" + TRANSFORM(loc_oE.LineNo) + " PROC=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, .T.)
    ENDTRY

    TRY
        loc_oForm.Release()
    CATCH TO loc_oE
    ENDTRY
ENDIF

STRTOFILE("=== FIM ===" + CHR(13) + CHR(10), OUT, .T.)
QUIT
