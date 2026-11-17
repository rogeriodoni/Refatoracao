* ProbeSigOpPagF6.prg
* Instancia Formsigoppag (task782, Fase 6) headless e confere os campos e
* lookups entregues nesta fase.
SET SAFETY OFF
SET RESOURCE OFF

#DEFINE OUTFILE "C:\4c\automation\_probe782f6.txt"

STRTOFILE("[1] inicio" + CHR(13) + CHR(10), OUTFILE)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_probe782f6_dialogs.txt"

DO (ADDBS("C:\4c\projeto\app\start") + "config.prg")
STRTOFILE("[2] config.prg ok" + CHR(13) + CHR(10), OUTFILE, 1)

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formerro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "sigoppagBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\Formsigoppag.prg") ADDITIVE
STRTOFILE("[3] SET PROCEDURE ok" + CHR(13) + CHR(10), OUTFILE, 1)

LOCAL loc_oForm, loc_oErro, loc_cMsg, loc_nI, loc_cNome, loc_aCampos
loc_cMsg = ""

DIMENSION loc_aCampos[20]
loc_aCampos[1]  = "lbl_4c_ValoresTotais"
loc_aCampos[2]  = "txt_4c_TotServico"
loc_aCampos[3]  = "txt_4c_ValTrans"
loc_aCampos[4]  = "txt_4c_Variacao"
loc_aCampos[5]  = "txt_4c_ValTot"
loc_aCampos[6]  = "txt_4c_TotForma"
loc_aCampos[7]  = "txt_4c_Saldo"
loc_aCampos[8]  = "txt_4c_PVaria"
loc_aCampos[9]  = "txt_4c_TVaria"
loc_aCampos[10] = "txt_4c_PDescP"
loc_aCampos[11] = "txt_4c_VDescP"
loc_aCampos[12] = "txt_4c_ValUtiCsh"
loc_aCampos[13] = "chk_4c_BtnCash"
loc_aCampos[14] = "txt_4c_Cotacao"
loc_aCampos[15] = "cmd_4c_AlteraCotacao"
loc_aCampos[16] = "chk_4c_BotTotForma"
loc_aCampos[17] = "chk_4c_BotTotItem"
loc_aCampos[18] = "chk_4c_BotCotacoes"
loc_aCampos[19] = "chk_4c_BotCpg"
loc_aCampos[20] = "chk_4c_BtnMascPgto"

TRY
	loc_oForm = CREATEOBJECT("Formsigoppag")
	STRTOFILE("[4] CREATEOBJECT retornou: " + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUTFILE, 1)

	IF VARTYPE(loc_oForm) = "O"
		FOR loc_nI = 1 TO ALEN(loc_aCampos, 1)
			loc_cNome = loc_aCampos[loc_nI]
			loc_cMsg = loc_cMsg + loc_cNome + "=" + ;
				TRANSFORM(PEMSTATUS(loc_oForm, loc_cNome, 5)) + CHR(13) + CHR(10)
		ENDFOR

		loc_cMsg = loc_cMsg + "txt_4c_AvisoPortaS=" + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_AvisoPortaS", 5)) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "txt_4c_AvisoPortaK=" + TRANSFORM(PEMSTATUS(loc_oForm, "txt_4c_AvisoPortaK", 5)) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "img_4c_Imagem1=" + TRANSFORM(PEMSTATUS(loc_oForm, "img_4c_Imagem1", 5)) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "lbl_4c_Movimentacao=" + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Movimentacao", 5)) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "lbl_4c_Recebimento=" + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Recebimento", 5)) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "lbl_4c_Mensagem=" + TRANSFORM(PEMSTATUS(loc_oForm, "lbl_4c_Mensagem", 5)) + CHR(13) + CHR(10)

		* Metodos de lookup existem e sao Method (regra #3 - escopo PUBLIC
		* confirmado por leitura do fonte: nenhum PROTECTED antes do PROCEDURE)
		loc_cMsg = loc_cMsg + "ValidarModfpgLostFocus(IsMethod)=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarModfpgLostFocus", 1)) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "ValidarFpgLostFocus(IsMethod)=" + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarFpgLostFocus", 1)) + CHR(13) + CHR(10)

		* Visibilidade dos ocultos (devem ficar .F.)
		loc_cMsg = loc_cMsg + "txt_4c_Cotacao.Visible=" + TRANSFORM(loc_oForm.txt_4c_Cotacao.Visible) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "lbl_4c_Mensagem.Visible=" + TRANSFORM(loc_oForm.lbl_4c_Mensagem.Visible) + CHR(13) + CHR(10)
		loc_cMsg = loc_cMsg + "chk_4c_BtnMascPgto.Visible=" + TRANSFORM(loc_oForm.chk_4c_BtnMascPgto.Visible) + CHR(13) + CHR(10)

		* Exercita o lookup de Moeda sem conexao real (gnConnHandle=0): nao
		* deve estourar, so nao deve achar nada e abrir o picker vazio.
		loc_oForm.txt_4c_Modfpg.Value = "USD"
		loc_oForm.ValidarModfpgLostFocus()
		loc_cMsg = loc_cMsg + "ValidarModfpgLostFocus executou sem erro" + CHR(13) + CHR(10)

		loc_oForm.Release()
	ENDIF
CATCH TO loc_oErro
	loc_cMsg = loc_cMsg + "ERRO: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
		" PROC=" + loc_oErro.Procedure + CHR(13) + CHR(10)
ENDTRY

STRTOFILE("[5] resultado:" + CHR(13) + CHR(10) + loc_cMsg, OUTFILE, 1)
STRTOFILE("[6] fim" + CHR(13) + CHR(10), OUTFILE, 1)

QUIT
