*==============================================================================
* probef7sigopflp734.prg - Exercita em RUNTIME os eventos entregues na Fase 7
* do FormSigOpFlp (task734): os 4 Click da barra de acao, o funil de estado
* (AjustarBotoesPorModo) e o bloco de permissoes (AplicarAcessos, via Init).
*
* Setup conforme a receita medida nesta maquina: NAO chamar
* ConfigurarAmbiente() (nao retorna aqui) - DO config.prg + SET PATH +
* SET PROCEDURE a mao do que o form usa, mais PUBLIC gnConnHandle.
* gb_4c_ModoTeste + gc_4c_ArquivoErroTeste SEMPRE em par, senao MsgAviso cai
* num MESSAGEBOX real e o processo trava sem produzir resultado.
*
* Script auxiliar de pipeline: SET SAFETY OFF + SET RESOURCE OFF (regra #6).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m734\probe_f7_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m734\probe_f7_sigopflp.txt"
loc_cOut = "=== PROBE Fase 7 - FormSigOpFlp (task734) ===" + CHR(13) + CHR(10)

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
SET PROCEDURE TO (gcCaminhoClasses + "SigOpFlpBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpFlp.prg") ADDITIVE

loc_cOut = loc_cOut + "[1] Setup concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_oForm, loc_oErro

TRY
    *-- Mesma ordem do LParameters legado: pConta, pData, pNoper
    loc_oForm = CREATEOBJECT("FormSigOpFlp", "", {}, 0)
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

*-- [3] Os handlers precisam ser PUBLIC: BINDEVENT ignora PROTECTED em
*-- silencio e o harness os chama de FORA da classe (regras #3 e #51).
*-- PEMSTATUS(..., 2) = Protected.
LOCAL loc_nI
LOCAL ARRAY loc_aMet[7]
loc_aMet[1] = "BtnIncluirClick"
loc_aMet[2] = "BtnAlterarClick"
loc_aMet[3] = "BtnExcluirClick"
loc_aMet[4] = "BtnImprimirClick"
loc_aMet[5] = "AjustarBotoesPorModo"
loc_aMet[6] = "HabilitarCampos"
loc_aMet[7] = "TemLinhaSelecionada"
FOR loc_nI = 1 TO ALEN(loc_aMet)
    loc_cOut = loc_cOut + "[3] " + PADR(loc_aMet[loc_nI], 22) + ;
        " existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5)) + ;
        " protegido=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 2)) + ;
        CHR(13) + CHR(10)
ENDFOR

*-- [4] Controles de Agendamento do painel (perdidos na Fase 6)
loc_cOut = loc_cOut + "[4] txt_4c_Agenda no painel = " + ;
    TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c__Inserir, "txt_4c_Agenda", 5)) + ;
    " | lbl_4c_LblAgenda = " + ;
    TRANSFORM(PEMSTATUS(loc_oForm.cnt_4c__Inserir, "lbl_4c_LblAgenda", 5)) + ;
    CHR(13) + CHR(10)

*-- [5] Estado inicial (AplicarAcessos ja rodou no Init)
loc_cOut = loc_cOut + "[5] inicial: painel=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
    " grade=" + TRANSFORM(loc_oForm.grd_4c_Dados.Visible) + ;
    " barra=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Visible) + ;
    " encerrar=" + TRANSFORM(loc_oForm.cmg_4c_Encerrar.Visible) + ;
    " contato=" + TRANSFORM(loc_oForm.cnt_4c_Contato.Visible) + ;
    " obs=" + TRANSFORM(loc_oForm.cnt_4c_Obs.Visible) + ;
    " agenda=" + TRANSFORM(loc_oForm.cnt_4c_Agenda.Visible) + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "[5] Left dos botoes: Inc=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(3).Left) + ;
    " Alt=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(4).Left) + ;
    " Exc=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(1).Left) + ;
    " Imp=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(2).Left) + ;
    " Width=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Width) + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [6] Incluir SEM conta: recusa e NAO abre o painel
loc_oForm.BtnIncluirClick()
loc_cOut = loc_cOut + "[6] Incluir sem conta: painel=" + ;
    TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
    " tipo=[" + loc_oForm.this_cTipo + "]" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [7] Alterar sem linha na grade: avisa e NAO abre o painel
loc_oForm.BtnAlterarClick()
loc_cOut = loc_cOut + "[7] Alterar sem linha: painel=" + ;
    TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
    " tipo=[" + loc_oForm.this_cTipo + "]" + CHR(13) + CHR(10)

*-- [8] Excluir sem linha na grade: nada acontece, como no legado
loc_oForm.BtnExcluirClick()
loc_cOut = loc_cOut + "[8] Excluir sem linha: OK (sem excecao)" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [9] Incluir COM conta: abre o painel, esconde a consulta e preenche os
*-- defaults do ramo INSERIR
loc_oForm.this_cConta = "0000000001"
loc_oForm.BtnIncluirClick()
loc_cOut = loc_cOut + "[9] Incluir com conta: painel=" + ;
    TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
    " grade=" + TRANSFORM(loc_oForm.grd_4c_Dados.Visible) + ;
    " barra=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Visible) + ;
    " encerrar=" + TRANSFORM(loc_oForm.cmg_4c_Encerrar.Visible) + ;
    " obs=" + TRANSFORM(loc_oForm.cnt_4c_Obs.Visible) + ;
    " tipo=[" + loc_oForm.this_cTipo + "]" + CHR(13) + CHR(10)
loc_cOut = loc_cOut + "[9] campos: data=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.txt_4c_Data.Value) + ;
    " agenda=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.txt_4c_Agenda.Value) + ;
    " usuario=[" + TRANSFORM(loc_oForm.cnt_4c__Inserir.txt_4c_Usuario.Value) + "]" + ;
    " histReadOnly=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.txt_4c_Hist.ReadOnly) + ;
    " obsReadOnly=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.obj_4c_GetObs.ReadOnly) + ;
    CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

*-- [10] Caminho de VOLTA pelo funil (o que a Fase 8 vai usar no Confirmar e
*-- no Cancelar): a consulta tem de reaparecer e os campos travarem (regra #40)
loc_oForm.this_cTipo = ""
loc_oForm.AjustarBotoesPorModo()
loc_cOut = loc_cOut + "[10] volta: painel=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.Visible) + ;
    " grade=" + TRANSFORM(loc_oForm.grd_4c_Dados.Visible) + ;
    " barra=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Visible) + ;
    " encerrar=" + TRANSFORM(loc_oForm.cmg_4c_Encerrar.Visible) + ;
    " obs=" + TRANSFORM(loc_oForm.cnt_4c_Obs.Visible) + ;
    " agenda=" + TRANSFORM(loc_oForm.cnt_4c_Agenda.Visible) + ;
    " histReadOnly=" + TRANSFORM(loc_oForm.cnt_4c__Inserir.txt_4c_Hist.ReadOnly) + ;
    CHR(13) + CHR(10)

*-- [11] Imprimir: SIGOPFLU ainda nao foi migrado - a falha tem de ser
*-- VISIVEL (mensagem), nunca silenciosa
loc_oForm.BtnImprimirClick()
loc_cOut = loc_cOut + "[11] Imprimir: OK (sem excecao nao tratada)" + CHR(13) + CHR(10)

loc_oForm.Release()
loc_cOut = loc_cOut + "[12] Release OK" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

QUIT
