*==============================================================================
* ProbePpc665Scope.prg - Mede o ESCOPO de LimparCampos em FormSigPrPpc
*
* Pergunta: "Property LIMPARCAMPOS is not found" vem de (a) chamada de FORA
* (esperado - PROTECTED na FormBase, regra #51) ou (b) THIS.LimparCampos()
* de DENTRO de BtnCancelarClick (seria defeito real do form)?
*
* Mede os dois caminhos isoladamente, cada um no seu TRY, para que a falha de
* um nao esconda o resultado do outro.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ppc665s.txt"
#DEFINE OUT "C:\4c\automation\probe_ppc665_scope.txt"

LOCAL loc_oForm, loc_oE, loc_cL

STRTOFILE("=== ESCOPO de LimparCampos - FormSigPrPpc ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbuscaauxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigPrPpcBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigPrPpc.prg") ADDITIVE
    gnConnHandle = -1
    loc_oForm = CREATEOBJECT("FormSigPrPpc")
CATCH TO loc_oE
    STRTOFILE("SETUP FALHOU: " + loc_oE.Message + CHR(13) + CHR(10), OUT, 1)
    QUIT
ENDTRY

STRTOFILE("PEMSTATUS(form, 'LimparCampos', 2) Protected = " + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + CHR(13) + CHR(10) + ;
          "PEMSTATUS(form, 'InicializarValores', 2) Protected = " + ;
          TRANSFORM(PEMSTATUS(loc_oForm, "InicializarValores", 2)) + CHR(13) + CHR(10), OUT, 1)

*-- (a) chamada de FORA: esperado ERRO (regra #51)
loc_cL = "(a) loc_oForm.LimparCampos() de FORA -> "
TRY
    loc_oForm.LimparCampos()
    loc_cL = loc_cL + "OK (nao deu erro)"
CATCH TO loc_oE
    loc_cL = loc_cL + "ERRO: " + loc_oE.Message
ENDTRY
STRTOFILE(loc_cL + CHR(13) + CHR(10), OUT, 1)

*-- (b) THIS.LimparCampos() de DENTRO de BtnCancelarClick
loc_cL = "(b) loc_oForm.BtnCancelarClick() (chama THIS.LimparCampos() de DENTRO) -> "
TRY
    loc_oForm.BtnCancelarClick()
    loc_cL = loc_cL + "OK (nao deu erro)"
CATCH TO loc_oE
    loc_cL = loc_cL + "ERRO: " + loc_oE.Message + " | Proc " + loc_oE.Procedure
ENDTRY
STRTOFILE(loc_cL + CHR(13) + CHR(10), OUT, 1)

*-- (c) THIS.InicializarValores() de DENTRO (BtnExcluirClick), para comparar
loc_cL = "(c) loc_oForm.BtnExcluirClick() (chama THIS.InicializarValores()) -> "
TRY
    loc_oForm.BtnExcluirClick()
    loc_cL = loc_cL + "OK (nao deu erro)"
CATCH TO loc_oE
    loc_cL = loc_cL + "ERRO: " + loc_oE.Message + " | Proc " + loc_oE.Procedure
ENDTRY
STRTOFILE(loc_cL + CHR(13) + CHR(10), OUT, 1)

QUIT
