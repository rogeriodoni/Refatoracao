*==============================================================================
* ProbeTfh683Fase8.prg - Probe da Fase 8 de FormSIGPRTFH (task683)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) escopos: FormParaBO/BOParaForm PROTECTED (FormBase os declara assim e o
*      VFP9 nao permite alargar) e BtnSaidaClick/ValidarParametros PUBLIC
*      (alvos de BINDEVENT / chamada externa - regra CLAUDE.md #3 e #51)
*   3) BOParaForm espelha as 9 properties do BO nos 9 TextBox e troca o rotulo
*      CPF/CGC (o bloco "With ThisForm / .GetPraca.Value = pcPraca / ..." do
*      Init legado)
*   4) FormParaBO le os 9 TextBox de volta para o BO
*   5) ROUND-TRIP BO -> tela -> BO devolve os MESMOS valores (a identidade que
*      o cabecalho de FormParaBO afirma - se falhar, o terminal receberia dado
*      diferente do que recebia no legado e o PILAR 1 estaria rompido)
*   6) a guarda de campo em BRANCO: TextBox vazio NAO apaga a property do BO
*   7) o rotulo vira "CGC :" quando TpPessoa <> "F"
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless. gb_4c_ModoTeste tambem impede o laco SiTef de disparar.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_tfh683.txt"
#DEFINE OUT "C:\4c\automation\probe_tfh683_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_nFalhas, loc_oE, loc_lOk
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSIGPRTFH (SiTef Consulta de Cheque) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gb_4c_ModoTeste     = .T.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRTFHBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRTFH.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeTfh683Fase8.prg"      ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao com os 24 parametros do Init legado
    *-- Ordem EXATA do Init legado (24 argumentos): pcIp, lcInicio, pcValor,
    *-- pcCupom, pcCaixa, pcIdent, pcPos, pcParcs, PcFuncoes, pcBanco,
    *-- pcAgencia, pcConta, pcnCheque, pcDtCheque, pcCpf, pcTpPessoa,
    *-- pcCupomnv, pcAgendc, pcContadc, pcNumdc, pcPraca, pcPesquisa,
    *-- pcCMC7, pcteste
    loc_oForm = CREATEOBJECT("ProbeTfhF8", ;
        "10.0.0.1", "41", 150.75, "000123", "CX01", 7, "POS001", 1, "1", ;
        "341", "1234", "567890", "000999", "20261020", "11122233344", "F", ;
        "000124", "5", "8", "3", "1700", "", "CMC7XYZ", "")

    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE("   FALHA: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        loc_oBO = loc_oForm.this_oBusinessObject
        STRTOFILE("   BO VARTYPE=" + VARTYPE(loc_oBO) + ;
                  "  SiTefDisponivel=" + TRANSFORM(loc_oBO.this_lSiTefDisponivel) + CHR(13) + CHR(10), OUT, 1)

        *-- 2) escopos
        STRTOFILE(CHR(13) + CHR(10) + "2) escopos (atributo 2 = PROTECTED):" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   FormParaBO PROTECTED   = " + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   BOParaForm PROTECTED   = " + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   BtnSaidaClick PROT     = " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnSaidaClick", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   ValidarParametros PROT = " + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarParametros", 2)) + CHR(13) + CHR(10), OUT, 1)
        IF !PEMSTATUS(loc_oForm, "FormParaBO", 2) OR !PEMSTATUS(loc_oForm, "BOParaForm", 2)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: hook de FormBase deveria ser PROTECTED" + CHR(13) + CHR(10), OUT, 1)
        ENDIF
        IF PEMSTATUS(loc_oForm, "BtnSaidaClick", 2) OR PEMSTATUS(loc_oForm, "ValidarParametros", 2)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: alvo de BINDEVENT nao pode ser PROTECTED" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 3) BOParaForm ja rodou no Init (via CarregarCamposNaTela)
        STRTOFILE(CHR(13) + CHR(10) + "3) BOParaForm (BO -> tela), ja executado no Init:" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   Praca=[" + loc_oForm.txt_4c_Praca.Value + "]" + ;
                  " Banco=[" + loc_oForm.txt_4c_Banco.Value + "]" + ;
                  " Ag=[" + loc_oForm.txt_4c_Agencia.Value + "/" + loc_oForm.txt_4c_DvAgencia.Value + "]" + ;
                  " Cta=[" + loc_oForm.txt_4c_Conta.Value + "/" + loc_oForm.txt_4c_DvConta.Value + "]" + ;
                  " Chq=[" + loc_oForm.txt_4c_Cheque.Value + "/" + loc_oForm.txt_4c_DvCheque.Value + "]" + ;
                  " Cpf=[" + loc_oForm.txt_4c_Cpf.Value + "]" + ;
                  " Rotulo=[" + loc_oForm.lbl_4c_LabelCpf.Caption + "]" + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (ALLTRIM(loc_oForm.txt_4c_Praca.Value)     == "1700"     AND ;
                   ALLTRIM(loc_oForm.txt_4c_Banco.Value)     == "341"      AND ;
                   ALLTRIM(loc_oForm.txt_4c_Agencia.Value)   == "1234"     AND ;
                   ALLTRIM(loc_oForm.txt_4c_DvAgencia.Value) == "5"        AND ;
                   ALLTRIM(loc_oForm.txt_4c_Conta.Value)     == "567890"   AND ;
                   ALLTRIM(loc_oForm.txt_4c_DvConta.Value)   == "8"        AND ;
                   ALLTRIM(loc_oForm.txt_4c_Cheque.Value)    == "000999"   AND ;
                   ALLTRIM(loc_oForm.txt_4c_DvCheque.Value)  == "3"        AND ;
                   ALLTRIM(loc_oForm.txt_4c_Cpf.Value)       == "11122233344" AND ;
                   loc_oForm.lbl_4c_LabelCpf.Caption         == "CPF :")
        STRTOFILE("   9 campos + rotulo conferem = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 4) FormParaBO le a tela de volta
        STRTOFILE(CHR(13) + CHR(10) + "4) FormParaBO (tela -> BO):" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   retorno = " + TRANSFORM(loc_oForm.TesteFormParaBO()) + CHR(13) + CHR(10), OUT, 1)

        *-- 5) ROUND-TRIP: BO -> tela -> BO tem de ser IDENTIDADE
        STRTOFILE(CHR(13) + CHR(10) + "5) round-trip BO -> tela -> BO (identidade):" + CHR(13) + CHR(10), OUT, 1)
        loc_oBO.this_cBanco   = "237"
        loc_oBO.this_cAgencia = "9876"
        loc_oBO.this_cCpf     = "11122233344"
        loc_oForm.TesteBOParaForm()
        loc_oForm.TesteFormParaBO()
        STRTOFILE("   BO depois do round-trip: Banco=[" + loc_oBO.this_cBanco + "]" + ;
                  " Agencia=[" + loc_oBO.this_cAgencia + "]" + ;
                  " Cpf=[" + loc_oBO.this_cCpf + "]" + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (loc_oBO.this_cBanco == "237" AND loc_oBO.this_cAgencia == "9876" AND ;
                   loc_oBO.this_cCpf == "11122233344")
        STRTOFILE("   identidade preservada = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: o round-trip alterou o valor" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 6) guarda de campo em BRANCO
        STRTOFILE(CHR(13) + CHR(10) + "6) guarda de campo em BRANCO:" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.txt_4c_Banco.Value = ""
        loc_oForm.TesteFormParaBO()
        STRTOFILE("   tela vazia -> BO.this_cBanco=[" + loc_oBO.this_cBanco + "]" + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (loc_oBO.this_cBanco == "237")
        STRTOFILE("   property PRESERVADA = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: campo vazio apagou a property do BO" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 7) rotulo CGC quando TpPessoa <> "F"
        STRTOFILE(CHR(13) + CHR(10) + "7) rotulo CPF/CGC:" + CHR(13) + CHR(10), OUT, 1)
        loc_oBO.this_cTpPessoa = "J"
        loc_oForm.TesteBOParaForm()
        STRTOFILE("   TpPessoa=J -> rotulo=[" + loc_oForm.lbl_4c_LabelCpf.Caption + "]" + CHR(13) + CHR(10), OUT, 1)
        IF loc_oForm.lbl_4c_LabelCpf.Caption != "CGC :"
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: rotulo nao virou CGC" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        loc_oForm = .NULL.
    ENDIF

    STRTOFILE(CHR(13) + CHR(10) + IIF(loc_nFalhas = 0, "PROBE_OK", ;
              "PROBE_FALHOU falhas=" + TRANSFORM(loc_nFalhas)) + CHR(13) + CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE(CHR(13) + CHR(10) + "EXCECAO: " + loc_oE.Message + ;
              "  Linha=" + TRANSFORM(loc_oE.LineNo) + ;
              "  Proc=" + loc_oE.Procedure + CHR(13) + CHR(10), OUT, 1)
ENDTRY

QUIT

DEFINE CLASS ProbeTfhF8 AS FormSIGPRTFH
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION TesteBOParaForm()
        RETURN THIS.BOParaForm()
    ENDFUNC
ENDDEFINE
