*==============================================================================
* ProbeF8SigOpEnt731.prg - Exercita em RUNTIME os hooks canonicos entregues na
* Fase 8 do FormSigOpEnt (task731): FormParaBO, BOParaForm, LimparCampos e
* HabilitarCampos.
*
* Os tres primeiros sao PROTECTED (escopo herdado de FormBase) e por isso NAO
* podem ser chamados de um script solto - PEMSTATUS mentiria dizendo que
* existem. Por isso o probe usa uma SUBCLASSE do form: subclasse alcanca
* membro protegido.
*
* Setup conforme a receita medida nesta maquina: NAO chamar
* ConfigurarAmbiente() (nao retorna aqui) - DO config.prg + SET PATH +
* SET PROCEDURE a mao do que o form usa, mais PUBLIC gnConnHandle = 0.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\probe_f8_sigopent_erros.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\probe_f8_sigopent.txt"
loc_cOut = "=== PROBE Fase 8 - FormSigOpEnt (task731) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SigOpEntBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpEnt.prg") ADDITIVE

loc_cOut = loc_cOut + "[1] Setup concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_oForm, loc_oErro, loc_dPrz, loc_dNova
loc_dPrz  = DATE() + 10
loc_dNova = DATE() + 20

TRY
    *-- Mesma ordem posicional do Lparameters legado:
    *-- pEmp, pDop, pNum, pPrz, pFor, pMin, pDat, pBlqAlt, pMax
    loc_oForm = CREATEOBJECT("ProbeSigOpEnt", "001", "PEDIDO", 123, loc_dPrz, ;
        .NULL., 5, DATE(), .F., 30)
CATCH TO loc_oErro
    loc_oForm = .NULL.
    loc_cOut = loc_cOut + "[2] FALHA no CREATEOBJECT: " + loc_oErro.Message + ;
        " | Linha " + TRANSFORM(loc_oErro.LineNo) + ;
        " | Proc " + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) <> "O"
    loc_cOut = loc_cOut + "[2] Form NAO instanciado - VARTYPE = " + ;
        VARTYPE(loc_oForm) + CHR(13) + CHR(10)
    STRTOFILE(loc_cOut, loc_cLog)
    QUIT
ENDIF

loc_cOut = loc_cOut + "[2] Form instanciado OK" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + loc_oForm.RodarProbe()
STRTOFILE(loc_cOut, loc_cLog)

loc_oForm = .NULL.
QUIT

*==============================================================================
* ProbeSigOpEnt - subclasse de FormSigOpEnt SO para o probe: expoe os hooks
* PROTECTED por um metodo publico. Subclasse alcanca membro protegido; script
* solto nao.
*==============================================================================
DEFINE CLASS ProbeSigOpEnt AS FormSigOpEnt

    FUNCTION RodarProbe()
        LOCAL loc_cR, loc_oBO, loc_lR
        loc_cR  = ""
        loc_oBO = THIS.this_oBusinessObject

        *-- (A) FormParaBO: campos -> BO
        THIS.txt_4c_PrazoAtual.Value = DATE() + 10
        THIS.txt_4c_PrazoNovo.Value  = DATE() + 20
        loc_lR = THIS.FormParaBO()
        loc_cR = loc_cR + "[A] FormParaBO retorno       = " + TRANSFORM(loc_lR) + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    BO.this_dPrazoAtual      = " + DTOC(loc_oBO.this_dPrazoAtual) + ;
            " (esp " + DTOC(DATE() + 10) + ")" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    BO.this_dPrazoNovo       = " + DTOC(loc_oBO.this_dPrazoNovo) + ;
            " (esp " + DTOC(DATE() + 20) + ")" + CHR(13) + CHR(10)

        *-- (B) LimparCampos: zera a data nova nas DUAS copias
        THIS.LimparCampos()
        loc_cR = loc_cR + "[B] campo PrazoNovo vazio    = " + ;
            TRANSFORM(EMPTY(THIS.txt_4c_PrazoNovo.Value)) + " (esp .T.)" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    BO.this_dPrazoNovo vazio = " + ;
            TRANSFORM(EMPTY(loc_oBO.this_dPrazoNovo)) + " (esp .T.)" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    PrazoAtual intacto       = " + ;
            TRANSFORM(THIS.txt_4c_PrazoAtual.Value = DATE() + 10) + " (esp .T.)" + CHR(13) + CHR(10)

        *-- (C) BOParaForm: BO -> campos
        loc_oBO.this_dPrazoAtual = DATE() + 77
        loc_oBO.this_dPrazoNovo  = DATE() + 88
        THIS.BOParaForm()
        loc_cR = loc_cR + "[C] campo PrazoAtual         = " + DTOC(THIS.txt_4c_PrazoAtual.Value) + ;
            " (esp " + DTOC(DATE() + 77) + ")" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    campo PrazoNovo          = " + DTOC(THIS.txt_4c_PrazoNovo.Value) + ;
            " (esp " + DTOC(DATE() + 88) + ")" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    tipo dos dois campos     = " + ;
            VARTYPE(THIS.txt_4c_PrazoAtual.Value) + VARTYPE(THIS.txt_4c_PrazoNovo.Value) + ;
            " (esp DD)" + CHR(13) + CHR(10)

        *-- (D) SincronizarCamposPrazo: a COMPOSICAO que o legado faz
        loc_oBO.this_dPrazoAtual = DATE() + 55
        loc_oBO.this_dPrazoNovo  = DATE() + 66
        THIS.SincronizarCamposPrazo()
        loc_cR = loc_cR + "[D] PrazoAtual na tela       = " + DTOC(THIS.txt_4c_PrazoAtual.Value) + ;
            " (esp " + DTOC(DATE() + 55) + ")" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    PrazoNovo na tela vazio  = " + ;
            TRANSFORM(EMPTY(THIS.txt_4c_PrazoNovo.Value)) + " (esp .T.)" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    BO.this_dPrazoNovo vazio = " + ;
            TRANSFORM(EMPTY(loc_oBO.this_dPrazoNovo)) + " (esp .T.)" + CHR(13) + CHR(10)

        *-- (E) HabilitarCampos nos tres modos
        THIS.HabilitarCampos(.F.)
        loc_cR = loc_cR + "[E] (.F.) PrazoNovo/Confirmar = " + ;
            TRANSFORM(THIS.txt_4c_PrazoNovo.Enabled) + "/" + ;
            TRANSFORM(THIS.cmd_4c_Confirmar.Enabled) + " (esp .F./.F.)" + CHR(13) + CHR(10)
        THIS.HabilitarCampos(.T.)
        loc_cR = loc_cR + "    (.T.) PrazoNovo/Confirmar = " + ;
            TRANSFORM(THIS.txt_4c_PrazoNovo.Enabled) + "/" + ;
            TRANSFORM(THIS.cmd_4c_Confirmar.Enabled) + " (esp .T./.T.)" + CHR(13) + CHR(10)
        THIS.HabilitarCampos(.F.)
        THIS.HabilitarCampos()
        loc_cR = loc_cR + "    (sem arg) PrazoNovo/Conf  = " + ;
            TRANSFORM(THIS.txt_4c_PrazoNovo.Enabled) + "/" + ;
            TRANSFORM(THIS.cmd_4c_Confirmar.Enabled) + " (esp .T./.T.)" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    Cancelar segue ligado     = " + ;
            TRANSFORM(THIS.cmd_4c_Cancelar.Enabled) + " (esp .T.)" + CHR(13) + CHR(10)
        loc_cR = loc_cR + "    PrazoAtual ReadOnly       = " + ;
            TRANSFORM(THIS.txt_4c_PrazoAtual.ReadOnly) + " (esp .T.)" + CHR(13) + CHR(10)

        *-- (F) AplicarBloqueioAlteracao delegando com o criterio do BO
        loc_oBO.this_lBloquear = .T.
        THIS.AplicarBloqueioAlteracao()
        loc_cR = loc_cR + "[F] Bloquear=.T. -> Novo/Conf = " + ;
            TRANSFORM(THIS.txt_4c_PrazoNovo.Enabled) + "/" + ;
            TRANSFORM(THIS.cmd_4c_Confirmar.Enabled) + " (esp .F./.F.)" + CHR(13) + CHR(10)
        loc_oBO.this_lBloquear = .F.
        THIS.AplicarBloqueioAlteracao()
        loc_cR = loc_cR + "    Bloquear=.F. -> Novo/Conf = " + ;
            TRANSFORM(THIS.txt_4c_PrazoNovo.Enabled) + "/" + ;
            TRANSFORM(THIS.cmd_4c_Confirmar.Enabled) + " (esp .T./.T.)" + CHR(13) + CHR(10)

        *-- (G) Confirmar SEM data nova: o "If Not Empty(ldNew)" do legado
        *--     torna o clique INOCUO - nao grava e nao estoura
        THIS.LimparCampos()
        THIS.BtnConfirmarClick()
        loc_cR = loc_cR + "[G] Confirmar sem data nova: BO.this_lGravouPrazo = " + ;
            TRANSFORM(loc_oBO.this_lGravouPrazo) + " (esp .F.)" + CHR(13) + CHR(10)

        RETURN loc_cR
    ENDFUNC

ENDDEFINE
