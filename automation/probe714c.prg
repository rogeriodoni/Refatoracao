SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
LOCAL lcOut, loForm, loErro, loPai, loBO
lcOut = "C:\Temp\probe714c.txt"
STRTOFILE("INICIO" + CHR(13)+CHR(10), lcOut)

CD C:\4c\projeto\app\start
DO config.prg
gb_4c_ValidandoUI = .T.
PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle = -1
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\Temp\probe714c_erros.txt"

SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SigOpCrpBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms   + "operacionais\FormSigOpCrp.prg") ADDITIVE

CREATE CURSOR CrSigMvCcr (Datas D, Valors N(11,2), Hists C(60))
INSERT INTO CrSigMvCcr VALUES ({^2026-10-28}, 100.00, "PRIMEIRO LANCAMENTO")
INSERT INTO CrSigMvCcr VALUES ({^2026-10-29}, 250.00, "PAGAMENTO FORNECEDOR")
INSERT INTO CrSigMvCcr VALUES ({^2026-10-30}, 500.00, "DEPOSITO EM CONTA")
GO TOP

loPai = CREATEOBJECT("Form")
loPai.Top = 50
loPai.Left = 100
loPai.Width = 1000

TRY
    loForm = CREATEOBJECT("FormSigOpCrp", SET("DATASESSION"), loPai)
CATCH TO loErro
    STRTOFILE("EXCECAO: " + loErro.Message + " LN=" + TRANSFORM(loErro.LineNo) + CHR(13)+CHR(10), lcOut, 1)
    loForm = .NULL.
ENDTRY
IF VARTYPE(loForm) != "O"
    STRTOFILE("INSTANCIACAO=FALHOU" + CHR(13)+CHR(10), lcOut, 1)
    QUIT
ENDIF

STRTOFILE("1) INSTANCIACAO=OK  Top=" + TRANSFORM(loForm.Top) + " Left=" + TRANSFORM(loForm.Left) + ;
          " (pai 50/100/W1000 -> 100+1000-520=580)" + CHR(13)+CHR(10), lcOut, 1)

STRTOFILE("2) TIPOS .Value = " + VARTYPE(loForm.txt_4c_Lancamento.Value) + ;
          VARTYPE(loForm.txt_4c_Valor.Value) + VARTYPE(loForm.txt_4c_Historico.Value) + ;
          "  (esperado DNC)" + CHR(13)+CHR(10), lcOut, 1)

STRTOFILE("3) LimparCampos (via Init) tela=[" + TRANSFORM(loForm.txt_4c_Lancamento.Value) + "|" + ;
          TRANSFORM(loForm.txt_4c_Valor.Value) + "|" + ALLTRIM(loForm.txt_4c_Historico.Value) + "]" + ;
          " BO=[" + TRANSFORM(loForm.this_oBusinessObject.this_dDatas) + "|" + ;
          TRANSFORM(loForm.this_oBusinessObject.this_nValors) + "|" + ;
          ALLTRIM(loForm.this_oBusinessObject.this_cHists) + "]" + ;
          " Continuar=[" + ALLTRIM(loForm.this_oBusinessObject.this_cContinuar) + "]" + CHR(13)+CHR(10), lcOut, 1)

*-- 4) BOParaForm pelo caminho PUBLICO (ValidarValor). Data e Historico
*--    preenchidos na tela; muda o VALOR -> o BO zera os outros dois e o
*--    BOParaForm tem de ESPELHAR isso na TELA.
loForm.txt_4c_Lancamento.Value = {^2026-10-29}
loForm.txt_4c_Historico.Value  = "ANTES DE MUDAR"
loForm.txt_4c_Valor.Value      = 0.00
loForm.TxtLancamentoGotFocus()
loForm.ValidarLancamento()
loForm.TxtValorGotFocus()
loForm.txt_4c_Valor.Value = 777.00
loForm.ValidarValor()
STRTOFILE("4) ValidarValor -> tela=[" + TRANSFORM(loForm.txt_4c_Lancamento.Value) + "|" + ;
          TRANSFORM(loForm.txt_4c_Valor.Value) + "|" + ALLTRIM(loForm.txt_4c_Historico.Value) + "]" + ;
          "  (esperado data e hist VAZIOS, valor 777)" + CHR(13)+CHR(10), lcOut, 1)

*-- 5) idem no sentido inverso: muda o HISTORICO -> zera data e valor
loForm.TxtHistoricoGotFocus()
loForm.txt_4c_Historico.Value = "DEPOSITO"
loForm.ValidarHistorico()
STRTOFILE("5) ValidarHistorico -> tela=[" + TRANSFORM(loForm.txt_4c_Lancamento.Value) + "|" + ;
          TRANSFORM(loForm.txt_4c_Valor.Value) + "|" + ALLTRIM(loForm.txt_4c_Historico.Value) + "]" + ;
          "  (esperado data vazia, valor 0, hist DEPOSITO)" + CHR(13)+CHR(10), lcOut, 1)

*-- 6) A NAVEGACAO - o que este dialogo existe para fazer. BtnProcurarClick nao
*--    pode ser chamado em headless porque termina em SetFocus/Release sobre
*--    form nunca exibido (o VFP pendura), entao a busca eh exercitada no BO,
*--    que eh exatamente o que o Click chama depois do FormParaBO.
loBO = loForm.this_oBusinessObject

loBO.this_dDatas = {}
loBO.this_nValors = 250.00
loBO.this_cHists = ""
loBO.this_cContinuar = ""
SELECT CrSigMvCcr
GO TOP
loBO.BuscarRegistro()
SELECT CrSigMvCcr
STRTOFILE("6a) VALOR 250  RECNO=" + TRANSFORM(RECNO()) + "/" + TRANSFORM(RECCOUNT()) + ;
          " Hists=[" + ALLTRIM(CrSigMvCcr.Hists) + "]" + ;
          " achou=" + TRANSFORM(loBO.this_lAchouRegistro) + ;
          " fechar=" + TRANSFORM(loBO.this_lFecharDialogo) + ;
          " foco=[" + ALLTRIM(loBO.this_cCampoFoco) + "]" + CHR(13)+CHR(10), lcOut, 1)

loBO.this_nValors = 0.00
loBO.this_cHists = "DEPOSITO"
loBO.this_cContinuar = ""
SELECT CrSigMvCcr
GO TOP
loBO.BuscarRegistro()
SELECT CrSigMvCcr
STRTOFILE("6b) HIST DEPOSITO  RECNO=" + TRANSFORM(RECNO()) + ;
          " Hists=[" + ALLTRIM(CrSigMvCcr.Hists) + "]" + ;
          " achou=" + TRANSFORM(loBO.this_lAchouRegistro) + CHR(13)+CHR(10), lcOut, 1)

loBO.this_cHists = ""
loBO.this_dDatas = {^2026-10-28}
SELECT CrSigMvCcr
GO BOTTOM
loBO.BuscarRegistro()
SELECT CrSigMvCcr
STRTOFILE("6c) DATA 28/10  RECNO=" + TRANSFORM(RECNO()) + ;
          " Hists=[" + ALLTRIM(CrSigMvCcr.Hists) + "]" + ;
          " achou=" + TRANSFORM(loBO.this_lAchouRegistro) + ;
          " fechar=" + TRANSFORM(loBO.this_lFecharDialogo) + ;
          "  (DATA fecha o dialogo)" + CHR(13)+CHR(10), lcOut, 1)

loBO = .NULL.
loForm = .NULL.

STRTOFILE("ERROS CAPTURADOS=" + IIF(FILE(gc_4c_ArquivoErroTeste), "SIM", "NAO") + CHR(13)+CHR(10), lcOut, 1)
IF FILE(gc_4c_ArquivoErroTeste)
    STRTOFILE(FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10), lcOut, 1)
ENDIF
STRTOFILE("FIM" + CHR(13)+CHR(10), lcOut, 1)
QUIT
