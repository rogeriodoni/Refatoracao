*==============================================================================
* Probe712F7.prg - Instancia o FormSigOpCpr (Fase 7, task712) e exercita o
* BtnCopiarClick nos quatro caminhos: guard de destino vazio, sucesso, recusa
* do BO e reentrancia. Script auxiliar de pipeline: SET SAFETY OFF +
* SET RESOURCE OFF obrigatorios (regra #6 - execucao unattended).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoFramework, gc_4c_ArquivoErroTeste
PUBLIC gc_4c_UsuarioLogado

gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_712_f7_dialogs.txt"
gc_4c_UsuarioLogado    = "TESTE"

ERASE C:\4c\automation\probe_712_f7_dialogs.txt

SET PROCEDURE TO C:\4c\projeto\app\utils\functions.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\messages.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\utils\validators.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\dataaccess.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\businessbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\formbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\gridbase.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\classes\SigOpCprBO.prg ADDITIVE
SET PROCEDURE TO C:\4c\projeto\app\forms\operacionais\FormSigOpCpr.prg ADDITIVE


LOCAL loF, loPai, loErr, loBO, lnI
*-- AEVENTS exige LOCAL ARRAY: com variavel escalar o VFP9 abre dialogo de erro
*-- MODAL e trava a sessao -T (irma da regra de ADIR/AFIELDS exigir LOCAL ARRAY)
LOCAL ARRAY laEv[1, 5]

*-- Cada etapa eh DESCARREGADA na hora com STRTOFILE (modo append): assim a
*-- saida sobrevive a uma morte do processo e aponta EXATAMENTE onde parou.
#DEFINE CPO "C:\4c\automation\probe_712_f7_out.txt"
STRTOFILE("=== 1. ABERTURA com o BO REAL ===" + CHR(13) + CHR(10), CPO)

loPai = CREATEOBJECT("StubPaiLista")
TRY
    loF = CREATEOBJECT("FormSigOpCpr", loPai, "PROC ORIGEM 1", .F.)
CATCH TO loErr
    loF = .NULL.
    STRTOFILE("  EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), CPO, 1)
ENDTRY
STRTOFILE("  VARTYPE(loF)          = " + VARTYPE(loF) + " (esperado O)" + CHR(13) + CHR(10) + ;
    "  BtnCopiarClick existe = " + TRANSFORM(PEMSTATUS(loF, "BtnCopiarClick", 5)) + CHR(13) + CHR(10) + ;
    "  this_lEmCopia existe  = " + TRANSFORM(PEMSTATUS(loF, "this_lEmCopia", 5)) + CHR(13) + CHR(10) + ;
    "  origem na tela        = [" + loF.txt_4c_Origem.Value + "]" + CHR(13) + CHR(10), CPO, 1)

lnI = AEVENTS(laEv, loF.cmg_4c_Botoes.Buttons(1))
STRTOFILE("  binds em Buttons(1)   = " + TRANSFORM(lnI) + " (esperado 1)" + ;
    IIF(lnI > 0, "  ev=" + laEv[1, 3] + " dg=" + laEv[1, 4], "") + CHR(13) + CHR(10), CPO, 1)
lnI = AEVENTS(laEv, loF.cmg_4c_Botoes.Buttons(2))
STRTOFILE("  binds em Buttons(2)   = " + TRANSFORM(lnI) + " (esperado 1)" + ;
    IIF(lnI > 0, "  ev=" + laEv[1, 3] + " dg=" + laEv[1, 4], "") + CHR(13) + CHR(10), CPO, 1)

*------------------------------------------------------------------------------
* 2. GUARD do Click legado: destino VAZIO recusa e NAO chama o copiador
*------------------------------------------------------------------------------
STRTOFILE(CHR(13) + CHR(10) + "=== 2. DESTINO VAZIO (guard da nota 34) ===" + CHR(13) + CHR(10), CPO, 1)
loBO = CREATEOBJECT("StubBOCopia")
loF.this_oBusinessObject = loBO
loF.txt_4c_Destino.Value = ""
TRY
    loF.BtnCopiarClick()
    STRTOFILE("  rodou sem excecao" + CHR(13) + CHR(10), CPO, 1)
CATCH TO loErr
    STRTOFILE("  EXCECAO: " + loErr.Message + " LN=" + TRANSFORM(loErr.LineNo) + ;
        " PROC=" + loErr.Procedure + CHR(13) + CHR(10), CPO, 1)
ENDTRY
STRTOFILE("  ExecutarCopia chamado = " + TRANSFORM(loBO.lCopiou) + " (esperado .F.)" + CHR(13) + CHR(10) + ;
    "  pai recarregado       = " + TRANSFORM(loPai.nRecargas) + " (esperado 0)" + CHR(13) + CHR(10) + ;
    "  form ainda vivo       = " + TRANSFORM(!ISNULL(loF)) + " (esperado .T.)" + CHR(13) + CHR(10) + ;
    "  guarda liberada       = " + TRANSFORM(loF.this_lEmCopia) + " (esperado .F.)" + CHR(13) + CHR(10), CPO, 1)

*------------------------------------------------------------------------------
* 3. REENTRANCIA: guarda ligada bloqueia a 2a entrada e NAO a libera
*------------------------------------------------------------------------------
STRTOFILE(CHR(13) + CHR(10) + "=== 3. REENTRANCIA (nota 35) ===" + CHR(13) + CHR(10), CPO, 1)
loBO.lCopiou = .F.
loF.txt_4c_Destino.Value = "PROC NOVO 1"
loF.this_lEmCopia = .T.
loF.BtnCopiarClick()
STRTOFILE("  ExecutarCopia chamado = " + TRANSFORM(loBO.lCopiou) + " (esperado .F.)" + CHR(13) + CHR(10) + ;
    "  guarda intacta        = " + TRANSFORM(loF.this_lEmCopia) + " (esperado .T.)" + CHR(13) + CHR(10), CPO, 1)
loF.this_lEmCopia = .F.

*------------------------------------------------------------------------------
* 4. RECUSA do BO com this_lErroExibido = .T.: nao repete mensagem, NAO fecha
*------------------------------------------------------------------------------
STRTOFILE(CHR(13) + CHR(10) + "=== 4. RECUSA do BO (regra #20) ===" + CHR(13) + CHR(10), CPO, 1)
loBO.lCopiou           = .F.
loBO.lRetorno          = .F.
loBO.this_lErroExibido = .T.
loF.BtnCopiarClick()
STRTOFILE("  ExecutarCopia chamado = " + TRANSFORM(loBO.lCopiou) + " (esperado .T.)" + CHR(13) + CHR(10) + ;
    "  pai recarregado       = " + TRANSFORM(loPai.nRecargas) + " (esperado 0)" + CHR(13) + CHR(10) + ;
    "  form ainda vivo       = " + TRANSFORM(!ISNULL(loF)) + " (esperado .T.)" + CHR(13) + CHR(10) + ;
    "  guarda liberada       = " + TRANSFORM(loF.this_lEmCopia) + " (esperado .F.)" + CHR(13) + CHR(10) + ;
    "  Value preservado      = [" + loF.txt_4c_Destino.Value + "] (NUNCA apagar)" + CHR(13) + CHR(10), CPO, 1)

*------------------------------------------------------------------------------
* 5. SUCESSO: espelho tela -> BO, repinte do pai e fechamento da tela
*------------------------------------------------------------------------------
STRTOFILE(CHR(13) + CHR(10) + "=== 5. SUCESSO (notas 33, 36 e 37) ===" + CHR(13) + CHR(10), CPO, 1)
loBO.lCopiou           = .F.
loBO.lRetorno          = .T.
loBO.this_lErroExibido = .F.
loF.txt_4c_Destino.Value = "PROC NOVO 1"
loF.BtnCopiarClick()
STRTOFILE("  ConfigurarModalidade  = " + TRANSFORM(loBO.lModalidade) + " (esperado .T.)" + CHR(13) + CHR(10) + ;
    "    origem recebida     = [" + loBO.cOrigem + "] (esperado PROC ORIGEM 1)" + CHR(13) + CHR(10) + ;
    "    comissao recebida   = " + TRANSFORM(loBO.lComissaoRec) + " (esperado .F.)" + CHR(13) + CHR(10) + ;
    "  ExecutarCopia chamado = " + TRANSFORM(loBO.lCopiou) + " (esperado .T.)" + CHR(13) + CHR(10) + ;
    "    destino recebido    = [" + loBO.cDestino + "] (esperado PROC NOVO 1)" + CHR(13) + CHR(10) + ;
    "  pai recarregado       = " + TRANSFORM(loPai.nRecargas) + " (esperado 1)" + CHR(13) + CHR(10) + ;
    "    metodo usado        = [" + loPai.cMetodo + "] (esperado CarregarLista)" + CHR(13) + CHR(10) + ;
    "  form fechado (ISNULL) = " + TRANSFORM(ISNULL(loF)) + " (esperado .T.)" + CHR(13) + CHR(10), CPO, 1)

STRTOFILE(CHR(13) + CHR(10) + "=== FIM ===" + CHR(13) + CHR(10), CPO, 1)
QUIT

DEFINE CLASS StubPaiLista AS Form
    nRecargas = 0
    cMetodo   = ""

    PROCEDURE CarregarLista()
        THIS.nRecargas = THIS.nRecargas + 1
        THIS.cMetodo   = "CarregarLista"
    ENDPROC
ENDDEFINE

DEFINE CLASS StubBOCopia AS Custom
    lRetorno           = .T.
    lCopiou            = .F.
    lModalidade        = .F.
    cOrigem            = ""
    cDestino           = ""
    lComissaoRec       = .F.
    this_lComissao     = .F.
    this_cMensagemErro = ""
    this_lErroExibido  = .F.

    PROCEDURE ConfigurarModalidade(par_lComissao, par_cOperacao)
        THIS.lModalidade  = .T.
        THIS.lComissaoRec = IIF(VARTYPE(par_lComissao) = "L", par_lComissao, .T.)
        THIS.cOrigem      = IIF(VARTYPE(par_cOperacao) = "C", par_cOperacao, "<nao-C>")
        RETURN .T.
    ENDPROC

    FUNCTION ExecutarCopia(par_cDestino)
        THIS.lCopiou  = .T.
        THIS.cDestino = IIF(VARTYPE(par_cDestino) = "C", par_cDestino, "<nao-C>")
        RETURN THIS.lRetorno
    ENDFUNC
ENDDEFINE
