*==============================================================================
* probef8sigopflu735.prg - Exercita em RUNTIME os metodos entregues na Fase 8
* do FormSIGOPFLU (task735): FormParaBO/BOParaForm/CarregarLista/
* BtnSalvarClick/BtnCancelarClick.
*
* Setup conforme a receita medida nesta maquina (igual ao probe da Fase 7):
* NAO chamar ConfigurarAmbiente() (nao retorna aqui) - DO config.prg + SET
* PATH + SET PROCEDURE a mao do que o form usa, mais PUBLIC gnConnHandle.
* gb_4c_ModoTeste + gc_4c_ArquivoErroTeste SEMPRE em par.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\_m735\probe_f8_dialogs.txt"
gnConnHandle           = 0

LOCAL loc_cLog, loc_cOut
loc_cLog = "C:\4c\automation\_m735\probe_f8_sigopflu.txt"
loc_cOut = "=== PROBE Fase 8 - FormSIGOPFLU (task735) ===" + CHR(13) + CHR(10)

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

CD C:\4c\projeto\app\start
DO config.prg

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
             "," + gcCaminhoForms + "," + gcCaminhoIcones)

SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")  ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "relatoriobase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")      ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "SIGOPFLUBO.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "relatorios\FormSIGOPFLU.prg") ADDITIVE

loc_cOut = loc_cOut + "[1] Setup concluido" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

LOCAL loc_oForm, loc_oErro

TRY
    loc_oForm = CREATEOBJECT("FormSIGOPFLU")
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
STRTOFILE(loc_cOut, loc_cLog)

*-- [3] FormParaBO (alias de FormParaRelatorio)
LOCAL loc_oPg
loc_oPg = loc_oForm.pgf_4c_Paginas.Page1
loc_oPg.txt_4c_DtInicial.Value = DATE() - 30
loc_oPg.txt_4c_DtFinal.Value   = DATE()
loc_oPg.txt_4c_Grupo.Value     = "11101"
loc_oPg.txt_4c_DGrupo.Value    = "GRUPO TESTE"
loc_oPg.chk_4c_ChkData.Value   = 1

TRY
    loc_oForm.FormParaBO()
    loc_cOut = loc_cOut + "[3] FormParaBO OK - BO.this_cGrupo=[" + ;
        ALLTRIM(loc_oForm.this_oRelatorio.this_cGrupo) + "] this_lImpData=" + ;
        TRANSFORM(loc_oForm.this_oRelatorio.this_lImpData) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[3] FALHA no FormParaBO: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [4] BOParaForm - altera o BO direto e confere que volta para a tela
loc_oForm.this_oRelatorio.this_cGrupo   = "99999"
loc_oForm.this_oRelatorio.this_cDGrupo  = "GRUPO PROBE"
loc_oForm.this_oRelatorio.this_cConta   = "12345"
loc_oForm.this_oRelatorio.this_cDConta  = "CONTA PROBE"
loc_oForm.this_oRelatorio.this_lImpData = .F.

TRY
    loc_oForm.BOParaForm()
    loc_cOut = loc_cOut + "[4] BOParaForm OK - txt_4c_Grupo=[" + ;
        ALLTRIM(loc_oPg.txt_4c_Grupo.Value) + "] txt_4c_Conta=[" + ;
        ALLTRIM(loc_oPg.txt_4c_Conta.Value) + "] chk=" + ;
        TRANSFORM(loc_oPg.chk_4c_ChkData.Value) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[4] FALHA no BOParaForm: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [5] CarregarLista - no-op, deve retornar .T.
TRY
    loc_cOut = loc_cOut + "[5] CarregarLista retorno=" + ;
        TRANSFORM(loc_oForm.CarregarLista()) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[5] FALHA no CarregarLista: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [6] BtnSalvarClick - no-op, nao aplicavel a relatorio
TRY
    loc_oForm.BtnSalvarClick()
    loc_cOut = loc_cOut + "[6] BtnSalvarClick OK (sem erro)" + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[6] FALHA no BtnSalvarClick: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [7] BtnCancelarClick - retorna para Page1
TRY
    loc_oForm.BtnCancelarClick()
    loc_cOut = loc_cOut + "[7] BtnCancelarClick OK - ActivePage=" + ;
        TRANSFORM(loc_oForm.pgf_4c_Paginas.ActivePage) + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[7] FALHA no BtnCancelarClick: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY
STRTOFILE(loc_cOut, loc_cLog)

*-- [8] Encerrar e liberar
TRY
    loc_oForm.BtnEncerrarClick()
    loc_cOut = loc_cOut + "[8] Form liberado=" + TRANSFORM(VARTYPE(loc_oForm) <> "O") + CHR(13) + CHR(10)
CATCH TO loc_oErro
    loc_cOut = loc_cOut + "[8] FALHA no BtnEncerrarClick: " + loc_oErro.Message + CHR(13) + CHR(10)
ENDTRY

loc_cOut = loc_cOut + "=== FIM DO PROBE ===" + CHR(13) + CHR(10)
STRTOFILE(loc_cOut, loc_cLog)

QUIT
