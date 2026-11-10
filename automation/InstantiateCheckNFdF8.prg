* InstantiateCheckNFdF8.prg
* Fase 8 de FormSigOpNFd (task771): prova a instanciacao e exercita TODOS os
* metodos novos/alterados da fase - HabilitarCampos, CarregarLista,
* FormParaBO, BOParaForm, LimparCampos, AtualizarCursorEvento,
* ValidarDescricaoEvento, ValidarDataEvento, ChkVeraoChange, ChkRefazerClick
* e BtnEnviarClick.
*
* Uso: vfp9.exe -t "C:\4c\automation\InstantiateCheckNFdF8.prg"
*
* Monta as dependencias A MAO em vez de chamar ConfigurarAmbiente(), que
* BLOQUEIA nesta maquina (o probe morreria por timeout antes do
* CREATEOBJECT). gb_4c_ModoTeste + gc_4c_ArquivoErroTeste sao os DOIS
* requisitos de EscreverErroParaArquivo: sem o segundo, MsgAviso/MsgErro
* caem num MESSAGEBOX real e o processo trava sem produzir resultado.
*
* NAO ha subclasse de probe para chamar FormParaBO/BOParaForm/LimparCampos
* direto (sao PROTECTED em FormBase): medido nesta maquina, um .prg carregado
* por SET PROCEDURE que faz "DEFINE CLASS X AS FormSigOpNFd" MATA o vfp9.exe
* no primeiro CREATEOBJECT, sem erro e sem log. Os tres sao exercitados pelo
* caminho REAL - o bloco [16]..[19] preenche o contexto da nota a mao para a
* guarda do BO deixar passar, e dai CarregarLista() percorre
* FormParaBO -> AtualizarUltimoEvento -> LimparCampos -> BOParaForm.
SET SAFETY OFF
SET RESOURCE OFF

PUBLIC gc_4c_LogProbe
gc_4c_LogProbe = "C:\4c\automation\InstantiateCheckNFdF8_result.txt"
IF FILE(gc_4c_LogProbe)
    DELETE FILE (gc_4c_LogProbe)
ENDIF

ON ERROR DO LogErroProbe WITH ERROR(), MESSAGE(), LINENO(), PROGRAM()

DO config.prg

PUBLIC gnConnHandle, gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gnConnHandle           = -1
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\InstantiateCheckNFdF8_erros.txt"

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpNFdBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSigOpNFd.prg") ADDITIVE
=STRTOFILE("[1] dependencias carregadas" + CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

LOCAL loc_oForm
loc_oForm = .NULL.
loc_oForm = CREATEOBJECT("FormSigOpNFd", .NULL., .NULL., 1, "CAN")
=STRTOFILE("[2] VARTYPE(loForm)=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

IF VARTYPE(loc_oForm) = "O"
    =STRTOFILE("[3] Caption=[" + loc_oForm.Caption + "]" + ;
               " Evento=[" + loc_oForm.txt_4c_Evento.Value + "]" + ;
               " Nfe=[" + TRANSFORM(loc_oForm.cnt_4c_NFe.txt_4c_Nfe.Value) + "]" + ;
               " Seq=" + TRANSFORM(loc_oForm.cnt_4c_Seq.txt_4c_Seq.Value) + ;
               " Data=[" + TRANSFORM(loc_oForm.cnt_4c_Data.txt_4c_Data.Value) + "]" + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    *-- Estado Enabled derivado do When de cada campo no dump
    =STRTOFILE("[4] Enabled inicial: desc=" + TRANSFORM(loc_oForm.cnt_4c_Observacao.obj_4c_GetDesc.Enabled) + ;
               " data=" + TRANSFORM(loc_oForm.cnt_4c_Data.txt_4c_Data.Enabled) + ;
               " refazer=" + TRANSFORM(loc_oForm.chk_4c_Refazer.Enabled) + ;
               " verao=" + TRANSFORM(loc_oForm.chk_4c_Verao.Enabled) + ;
               " nfe=" + TRANSFORM(loc_oForm.cnt_4c_NFe.txt_4c_Nfe.Enabled) + ;
               " seq=" + TRANSFORM(loc_oForm.cnt_4c_Seq.txt_4c_Seq.Enabled) + ;
               " evento=" + TRANSFORM(loc_oForm.txt_4c_Evento.Enabled) + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    =STRTOFILE("[5] HabilitarCampos(.F.)=" + TRANSFORM(loc_oForm.HabilitarCampos(.F.)) + ;
               " -> desc=" + TRANSFORM(loc_oForm.cnt_4c_Observacao.obj_4c_GetDesc.Enabled) + ;
               " data=" + TRANSFORM(loc_oForm.cnt_4c_Data.txt_4c_Data.Enabled) + ;
               " nfe=" + TRANSFORM(loc_oForm.cnt_4c_NFe.txt_4c_Nfe.Enabled) + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    *-- Campo de exibicao tem de continuar .F. mesmo com o parametro .T.
    =STRTOFILE("[6] HabilitarCampos(.T.)=" + TRANSFORM(loc_oForm.HabilitarCampos(.T.)) + ;
               " -> desc=" + TRANSFORM(loc_oForm.cnt_4c_Observacao.obj_4c_GetDesc.Enabled) + ;
               " nfe=" + TRANSFORM(loc_oForm.cnt_4c_NFe.txt_4c_Nfe.Enabled) + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    *-- Sem o contexto da nota, a guarda do BO devolve .F. e a tela nao muda
    =STRTOFILE("[7] CarregarLista()=" + TRANSFORM(loc_oForm.CarregarLista()) + ;
               " AtualizarCursorEvento()=" + TRANSFORM(loc_oForm.AtualizarCursorEvento()) + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    loc_oForm.cnt_4c_Observacao.obj_4c_GetDesc.Value = "Justificativa com mais de quinze caracteres"
    loc_oForm.ValidarDescricaoEvento()
    loc_oForm.chk_4c_Verao.Value = 1
    loc_oForm.ChkVeraoChange()
    =STRTOFILE("[8] apos ValidarDescricaoEvento/ChkVeraoChange: descBO=[" + ;
               ALLTRIM(loc_oForm.this_oBusinessObject.this_cNfedesc) + "]" + ;
               " fuso=[" + loc_oForm.this_oBusinessObject.this_cFusoHorario + "]" + ;
               " verao=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lHorarioVerao) + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    *-- Data VALIDA: normaliza o controle e espelha no BO como DATETIME
    loc_oForm.cnt_4c_Data.txt_4c_Data.Value = TTOC(DATETIME())
    loc_oForm.ValidarDataEvento()
    =STRTOFILE("[9] data valida -> ctrl=[" + TRANSFORM(loc_oForm.cnt_4c_Data.txt_4c_Data.Value) + "]" + ;
               " nfedte=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dNfedte) + ;
               " vartype=" + VARTYPE(loc_oForm.this_oBusinessObject.this_dNfedte) + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    *-- Data VAZIA: estado valido (NullDisplay = "//" no dump)
    loc_oForm.cnt_4c_Data.txt_4c_Data.Value = ""
    loc_oForm.ValidarDataEvento()
    =STRTOFILE("[10] data vazia -> ctrl=[" + TRANSFORM(loc_oForm.cnt_4c_Data.txt_4c_Data.Value) + "]" + ;
               " nfedte_empty=" + TRANSFORM(EMPTY(loc_oForm.this_oBusinessObject.this_dNfedte)) + ;
               " anterior=[" + loc_oForm.this_cDataEventoAnterior + "]" + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    loc_oForm.chk_4c_Refazer.Value = 1
    loc_oForm.ChkRefazerClick()
    =STRTOFILE("[11] Refazer=1 -> this_lRefazer=" + ;
               TRANSFORM(loc_oForm.this_oBusinessObject.this_lRefazer) + CHR(13) + CHR(10), gc_4c_LogProbe, .T.)
    loc_oForm.chk_4c_Refazer.Value = 0
    loc_oForm.ChkRefazerClick()
    =STRTOFILE("[12] Refazer=0 -> this_lRefazer=" + ;
               TRANSFORM(loc_oForm.this_oBusinessObject.this_lRefazer) + CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    *-- Guarda do legado (LEN < 15): recusa e NAO grava
    loc_oForm.cnt_4c_Observacao.obj_4c_GetDesc.Value = "curta"
    loc_oForm.BtnEnviarClick()
    =STRTOFILE("[13] BtnEnviarClick com descricao curta: guarda do legado recusou" + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    loc_oForm.Release()
ENDIF

*-- Com o CONTEXTO DA NOTA preenchido a mao, a guarda do BO deixa passar e o
*-- caminho completo do atucur roda: FormParaBO -> AtualizarUltimoEvento ->
*-- LimparCampos (ramo da sequencia nova) -> BOParaForm(this_nUltimaSequencia)
LOCAL loc_oForm2
loc_oForm2 = .NULL.
loc_oForm2 = CREATEOBJECT("FormSigOpNFd", .NULL., .NULL., 1, "CAR")
IF VARTYPE(loc_oForm2) = "O"
    WITH loc_oForm2.this_oBusinessObject
        .this_cNfiEmpDopNums = PADR("001", 3) + PADR("VENDA", 20) + STR(123, 6)
        .this_cNfiEmps       = "001"
        .this_cNfiDopes      = "VENDA"
        .this_nNfiNumes      = 123
        .this_cNfiNfis       = "000456"
    ENDWITH
    loc_oForm2.cnt_4c_Observacao.obj_4c_GetDesc.Value = "Texto que LimparCampos deve apagar no ramo novo"
    loc_oForm2.ValidarDescricaoEvento()
    =STRTOFILE("[14] antes: descBO=[" + ALLTRIM(loc_oForm2.this_oBusinessObject.this_cNfedesc) + "]" + ;
               " descCtrl=[" + ALLTRIM(loc_oForm2.cnt_4c_Observacao.obj_4c_GetDesc.Value) + "]" + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    =STRTOFILE("[15] CarregarLista()=" + TRANSFORM(loc_oForm2.CarregarLista()) + CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    =STRTOFILE("[16] depois: Nfe=[" + ALLTRIM(loc_oForm2.cnt_4c_NFe.txt_4c_Nfe.Value) + "]" + ;
               " Seq=" + TRANSFORM(loc_oForm2.cnt_4c_Seq.txt_4c_Seq.Value) + ;
               " UltSeq=" + TRANSFORM(loc_oForm2.this_oBusinessObject.this_nUltimaSequencia) + ;
               " descBO=[" + ALLTRIM(loc_oForm2.this_oBusinessObject.this_cNfedesc) + "]" + ;
               " descCtrl=[" + ALLTRIM(loc_oForm2.cnt_4c_Observacao.obj_4c_GetDesc.Value) + "]" + ;
               " novoReg=" + TRANSFORM(loc_oForm2.this_oBusinessObject.this_lNovoRegistro) + ;
               " emEdicao=" + TRANSFORM(loc_oForm2.this_oBusinessObject.this_lEmEdicao) + ;
               " EmpDopNums=[" + ALLTRIM(loc_oForm2.this_oBusinessObject.this_cEmpDopNums) + "]" + ;
               " len=" + TRANSFORM(LEN(loc_oForm2.this_oBusinessObject.this_cEmpDopNums)) + ;
               " nfeeve=[" + loc_oForm2.this_oBusinessObject.this_cNfeeve + "]" + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    *-- 2a passada pelo MESMO funil: prova que o funil eh reentrante
    =STRTOFILE("[17] 2a CarregarLista()=" + TRANSFORM(loc_oForm2.CarregarLista()) + ;
               " novoReg=" + TRANSFORM(loc_oForm2.this_oBusinessObject.this_lNovoRegistro) + ;
               " Seq=" + TRANSFORM(loc_oForm2.cnt_4c_Seq.txt_4c_Seq.Value) + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)

    loc_oForm2.Release()
ENDIF

=STRTOFILE("[FIM]" + CHR(13) + CHR(10), gc_4c_LogProbe, .T.)
QUIT

PROCEDURE LogErroProbe(par_nErro, par_cMsg, par_nLinha, par_cProg)
    =STRTOFILE("[ON ERROR] " + TRANSFORM(par_nErro) + " - " + par_cMsg + ;
               " | LN=" + TRANSFORM(par_nLinha) + " | PROG=" + par_cProg + ;
               CHR(13) + CHR(10), gc_4c_LogProbe, .T.)
ENDPROC
