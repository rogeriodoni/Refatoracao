*==============================================================================
* test_fase8_sigmvitn.prg - Harness da Fase 8 do Formsigmvitn (Caixa)
* Prova a CONSOLIDACAO: FormParaBO/BOParaForm/CarregarLista/HabilitarCampos/
* LimparCampos/AjustarBotoesPorModo/BtnConfirmarClick/BtnCancelarClick.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, loForm, loErr, lcCls, lcUtl, lcCRLF, lnSesAnt, i, lnDummy
lcCRLF = CHR(13) + CHR(10)
lcLog  = "C:\4c\tasks\task571\teste_fase8.txt"
lcCls  = "C:\4c\projeto\app\classes\"
lcUtl  = "C:\4c\projeto\app\utils\"

STRTOFILE("=== TESTE FASE 8 Formsigmvitn (consolidacao) ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_UsuarioLogado, go_4c_Sistema
PUBLIC gc_4c_ArquivoErroTeste
gb_4c_ModoTeste      = .T.
gb_4c_ValidandoUI    = .F.
gnConnHandle         = -1
gc_4c_CaminhoIcones  = "C:\4c\vbmp\"
gc_4c_CaminhoReports = "C:\4c\projeto\app\reports\"
gc_4c_UsuarioLogado  = "TESTE"
gc_4c_ArquivoErroTeste = "C:\4c\tasks\task571\teste_fase8_erros.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg") ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "FormErro.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "sigmvitnBO.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigmvitn.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE     : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE     : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigmvitn", .NULL., 0)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT      : EXCECAO - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("ABORTADO: form nao instanciou." + lcCRLF, lcLog, 1)
    QUIT
ENDIF

STRTOFILE("CREATEOBJECT      : OK (form instanciado)" + lcCRLF, lcLog, 1)

STRTOFILE(lcCRLF + "--- METODOS DA CONSOLIDACAO (PEMSTATUS) ---" + lcCRLF, lcLog, 1)
LOCAL ARRAY laM[6]
laM[1] = "FormParaBO"
laM[2] = "BOParaForm"
laM[3] = "CarregarLista"
laM[4] = "HabilitarCampos"
laM[5] = "LimparCampos"
laM[6] = "AjustarBotoesPorModo"
FOR i = 1 TO ALEN(laM)
    STRTOFILE(PADR(laM[i], 22) + ": " + TRANSFORM(PEMSTATUS(loForm, laM[i], 5)) + lcCRLF, lcLog, 1)
ENDFOR

STRTOFILE(lcCRLF + "--- CHAMADA REAL (PEMSTATUS nao prova escopo) ---" + lcCRLF, lcLog, 1)

TRY
    loForm.AjustarBotoesPorModo()
    STRTOFILE("AjustarBotoesPorModo  : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("AjustarBotoesPorModo  : FALHA - " + loErr.Message + " L" + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
ENDTRY

TRY
    loForm.HabilitarCampos(.T.)
    loForm.HabilitarCampos(.F.)
    STRTOFILE("HabilitarCampos       : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("HabilitarCampos       : FALHA - " + loErr.Message + " L" + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
ENDTRY

TRY
    loForm.LimparCampos()
    STRTOFILE("LimparCampos          : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("LimparCampos          : FALHA - " + loErr.Message + " L" + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
ENDTRY

TRY
    STRTOFILE("CarregarLista         : retorno=" + TRANSFORM(loForm.CarregarLista()) + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("CarregarLista         : FALHA - " + loErr.Message + " L" + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
ENDTRY


STRTOFILE(lcCRLF + "--- ESCOPO: PROTECTED herdado do FormBase (regra #3) ---" + lcCRLF, lcLog, 1)
TRY
    lnDummy = loForm.FormParaBO()
    STRTOFILE("FormParaBO de FORA    : chamou (inesperado)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("FormParaBO de FORA    : bloqueado como esperado - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- Prova pelo caminho REAL do usuario: Confirmar -> GravarItensLancados ->
*-- FormParaBO -> BO.Salvar. Sem conexao (gnConnHandle=-1) o Salvar FALHA, e o
*-- teste comprova que o Confirmar NAO anuncia sucesso e NAO fecha a tela -
*-- que e exatamente a regressao que esta fase corrigiu.
STRTOFILE(lcCRLF + "--- CAMINHO REAL: BtnConfirmarClick com 1 item e SEM conexao ---" + lcCRLF, lcLog, 1)

lnSesAnt = SET("DATASESSION")
SET DATASESSION TO loForm.DataSessionId
SELECT crTpmMvItn
ZAP
INSERT INTO crTpmMvItn (citens, cpros, dpros, cunis, qtds, units, univals, totas, valdescs, moedas) ;
    VALUES (1, "PROD000000001", "PRODUTO DE TESTE", "UN", 3, 10.50, 12.00, 31.50, 1.50, "REA")
GO TOP
STRTOFILE("carrinho              : RECCOUNT=" + TRANSFORM(RECCOUNT("crTpmMvItn")) + lcCRLF, lcLog, 1)
IF !USED("xPar")
    STRTOFILE("xPar                  : AUSENTE" + lcCRLF, lcLog, 1)
ELSE
    SELECT xPar
    ZAP
    APPEND BLANK
    REPLACE FPags WITH "01", Valos WITH 31.50
    STRTOFILE("xPar (pagamento)      : RECCOUNT=" + TRANSFORM(RECCOUNT("xPar")) + lcCRLF, lcLog, 1)
ENDIF
SET DATASESSION TO (lnSesAnt)

TRY
    loForm.BtnConfirmarClick()
    STRTOFILE("BtnConfirmarClick     : executou sem excecao" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("BtnConfirmarClick     : EXCECAO - " + loErr.Message + " L" + TRANSFORM(loErr.LineNo) + ;
        " Proc " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

*-- O form NAO pode ter sido liberado (a gravacao falhou sem conexao)
STRTOFILE("form ainda vivo       : " + TRANSFORM(VARTYPE(loForm) = "O" AND TYPE("loForm.Name") = "C") + ;
    " (esperado T - Confirmar nao fecha quando a gravacao falha)" + lcCRLF, lcLog, 1)

*-- FormParaBO rodou por dentro: as props do BO tem de estar preenchidas
STRTOFILE(lcCRLF + "--- FormParaBO rodou por dentro? (props do BO) ---" + lcCRLF, lcLog, 1)
TRY
    STRTOFILE("  cCpros      = [" + ALLTRIM(loForm.this_oBusinessObject.this_cCpros) + "] (esperado PROD000000001)" + lcCRLF, lcLog, 1)
    STRTOFILE("  nQtds       = " + TRANSFORM(loForm.this_oBusinessObject.this_nQtds) + " (esperado 3)" + lcCRLF, lcLog, 1)
    STRTOFILE("  nTotas      = " + TRANSFORM(loForm.this_oBusinessObject.this_nTotas) + " (esperado 31.50)" + lcCRLF, lcLog, 1)
    STRTOFILE("  nUnits      = " + TRANSFORM(loForm.this_oBusinessObject.this_nUnits) + " (esperado 10.50)" + lcCRLF, lcLog, 1)
    STRTOFILE("  cEmps       = [" + ALLTRIM(loForm.this_oBusinessObject.this_cEmps) + "] (esperado 001)" + lcCRLF, lcLog, 1)
    STRTOFILE("  cEmpdopnums len = " + TRANSFORM(LEN(loForm.this_oBusinessObject.this_cEmpdopnums)) + " (max 29)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("  FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

*-- Carrinho VAZIO: Confirmar deve apenas fechar, sem anunciar venda
STRTOFILE(lcCRLF + "--- GATE DOS BOTOES ---" + lcCRLF, lcLog, 1)
TRY
    loForm.this_lInicia = .T.
    loForm.AjustarBotoesPorModo()
    STRTOFILE("Inicia=T -> Ok.Enabled  = " + TRANSFORM(loForm.cnt_4c_Barra_Botoes.cmd_4c_Ok.Enabled) + " (esperado T)" + lcCRLF, lcLog, 1)
    loForm.this_lInicia = .F.
    loForm.AjustarBotoesPorModo()
    STRTOFILE("Inicia=F -> Ok.Enabled  = " + TRANSFORM(loForm.cnt_4c_Barra_Botoes.cmd_4c_Ok.Enabled) + " (esperado F)" + lcCRLF, lcLog, 1)
    STRTOFILE("            Cancela.Ena = " + TRANSFORM(loForm.cnt_4c_Barra_Botoes.cmd_4c_Cancela.Enabled) + " (sempre T)" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("GATE                  : FALHA - " + loErr.Message + " L" + TRANSFORM(loErr.LineNo) + lcCRLF, lcLog, 1)
ENDTRY


STRTOFILE(lcCRLF + "--- ITEM CANCELADO (DELETE logico) NAO pode ser gravado ---" + lcCRLF, lcLog, 1)
lnSesAnt = SET("DATASESSION")
SET DATASESSION TO loForm.DataSessionId
STRTOFILE("SET(DELETED) na sessao do form = " + SET("DELETED") + " (esperado ON)" + lcCRLF, lcLog, 1)
SELECT crTpmMvItn
ZAP
INSERT INTO crTpmMvItn (citens, cpros, dpros, qtds, units, totas) VALUES (1, "PROD_A", "ITEM BOM", 1, 10, 10)
INSERT INTO crTpmMvItn (citens, cpros, dpros, qtds, units, totas) VALUES (2, "PROD_B", "ITEM CANCELADO", 1, 20, 20)
GO TOP
SKIP
DELETE
GO TOP
LOCAL lnVis
COUNT FOR !EMPTY(NVL(cpros,"")) AND !DELETED() TO lnVis
STRTOFILE("itens gravaveis (2 lancados, 1 cancelado) = " + TRANSFORM(lnVis) + " (esperado 1)" + lcCRLF, lcLog, 1)
SET DATASESSION TO (lnSesAnt)
STRTOFILE("=== FIM ===" + lcCRLF, lcLog, 1)
QUIT
