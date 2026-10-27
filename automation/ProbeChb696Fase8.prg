*==============================================================================
* ProbeChb696Fase8.prg - Probe da Fase 8 de FormSigOpChb (task696)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) escopos: FormParaBO/BOParaForm PROTECTED; CarregarLista,
*      BtnCancelarClick, CmdProcuraClick e LimparCampos PUBLIC (alvos de
*      BINDEVENT / chamados de fora pelo TesteAutomatico.prg - CLAUDE.md #3/#51)
*   3) o estado INICIAL dos nove campos depois do Init e o do Init legado
*      ("" nos seis char, {} no Vencimento, 0 no Valor, Space(6) no Arquivo)
*   4) FormParaBO le os nove campos da tela para o BO
*   5) ROUND-TRIP tela -> BO -> tela devolve os MESMOS valores
*   6) LimparCampos repoe os nove campos no estado do Init
*   7) CarregarLista com TODOS os criterios vazios devolve .T. sem consultar
*      o banco (o Do Case legado sem Case casado nao executa SqlExecute) e
*      sem criar o cursor de resultado
*   8) BtnCancelarClick fecha (Visible = .F.) e repoe os criterios
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ValidandoUI
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_chb696.txt"
#DEFINE OUT "C:\4c\automation\probe_chb696_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_nFalhas, loc_oE, loc_lOk, loc_lRet
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigOpChb (Procurar Cheque) ===" + CHR(13) + CHR(10), OUT)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    gb_4c_ModoTeste     = .T.
    gb_4c_ValidandoUI   = .T.
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpChbBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpChb.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeChb696Fase8.prg"      ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao com os 4 parametros do Init legado
    loc_oForm = CREATEOBJECT("ProbeChbF8", .F., "", .F., .NULL.)

    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE("   FALHA: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        loc_oBO = loc_oForm.this_oBusinessObject
        STRTOFILE("   BO VARTYPE=" + VARTYPE(loc_oBO) + "  Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10), OUT, 1)

        *-- 2) escopos (atributo 2 = PROTECTED)
        STRTOFILE(CHR(13) + CHR(10) + "2) escopos (atributo 2 = PROTECTED):" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   FormParaBO PROTECTED       = " + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   BOParaForm PROTECTED       = " + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarLista PROTECTED    = " + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   BtnCancelarClick PROTECTED = " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   LimparCampos PROTECTED     = " + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CmdProcuraClick PROTECTED  = " + TRANSFORM(PEMSTATUS(loc_oForm, "CmdProcuraClick", 2)) + CHR(13) + CHR(10), OUT, 1)
        *-- LimparCampos/FormParaBO/BOParaForm TEM de ser PROTECTED: FormBase
        *-- os declara assim e o VFP9 nao permite alargar (regra #51).
        IF !PEMSTATUS(loc_oForm, "FormParaBO", 2) OR !PEMSTATUS(loc_oForm, "BOParaForm", 2) ;
           OR !PEMSTATUS(loc_oForm, "LimparCampos", 2)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: hook de FormBase deveria ser PROTECTED" + CHR(13) + CHR(10), OUT, 1)
        ENDIF
        IF PEMSTATUS(loc_oForm, "CarregarLista", 2) OR PEMSTATUS(loc_oForm, "BtnCancelarClick", 2) ;
           OR PEMSTATUS(loc_oForm, "CmdProcuraClick", 2)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: metodo chamado de FORA nao pode ser PROTECTED" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 3) estado inicial dos nove campos (vindo do Init via LimparCampos)
        STRTOFILE(CHR(13) + CHR(10) + "3) estado inicial dos nove campos:" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   Bco=[" + loc_oForm.txt_4c_Banco.Value + "]" + ;
                  " Age=[" + loc_oForm.txt_4c_Agencia.Value + "]" + ;
                  " Con=[" + loc_oForm.txt_4c_Conta.Value + "]" + ;
                  " Che=[" + loc_oForm.txt_4c_Cheque.Value + "]" + ;
                  " Ven=[" + DTOC(loc_oForm.txt_4c_Vencimento.Value) + "]" + ;
                  " Val=[" + TRANSFORM(loc_oForm.txt_4c_Valor.Value) + "]" + ;
                  " Ctr=[" + loc_oForm.txt_4c_Controle.Value + "]" + ;
                  " Pro=[" + loc_oForm.txt_4c_Protocolo.Value + "]" + ;
                  " Arq=[" + loc_oForm.txt_4c_Arquivo.Value + "] len=" + ;
                  TRANSFORM(LEN(loc_oForm.txt_4c_Arquivo.Value)) + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (EMPTY(loc_oForm.txt_4c_Banco.Value)      AND EMPTY(loc_oForm.txt_4c_Agencia.Value) AND ;
                   EMPTY(loc_oForm.txt_4c_Conta.Value)      AND EMPTY(loc_oForm.txt_4c_Cheque.Value) AND ;
                   EMPTY(loc_oForm.txt_4c_Vencimento.Value) AND loc_oForm.txt_4c_Valor.Value = 0 AND ;
                   EMPTY(loc_oForm.txt_4c_Controle.Value)   AND EMPTY(loc_oForm.txt_4c_Protocolo.Value) AND ;
                   LEN(loc_oForm.txt_4c_Arquivo.Value) = 6  AND EMPTY(loc_oForm.txt_4c_Arquivo.Value) AND ;
                   VARTYPE(loc_oForm.txt_4c_Vencimento.Value) = "D" AND ;
                   VARTYPE(loc_oForm.txt_4c_Valor.Value) = "N")
        STRTOFILE("   estado inicial do legado conferido = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 4) FormParaBO (tela -> BO)
        STRTOFILE(CHR(13) + CHR(10) + "4) FormParaBO (tela -> BO):" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.txt_4c_Banco.Value      = "341"
        loc_oForm.txt_4c_Agencia.Value    = "1234"
        loc_oForm.txt_4c_Conta.Value      = "0056789012"
        loc_oForm.txt_4c_Cheque.Value     = "000777"
        loc_oForm.txt_4c_Vencimento.Value = DATE()
        loc_oForm.txt_4c_Valor.Value      = 1234.56
        loc_lRet = loc_oForm.TesteFormParaBO()
        STRTOFILE("   retorno = " + TRANSFORM(loc_lRet) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   BO: Bco=[" + loc_oBO.this_cBanco + "] Age=[" + loc_oBO.this_cAgencia + ;
                  "] Con=[" + loc_oBO.this_cConta + "] Che=[" + loc_oBO.this_cCheque + ;
                  "] Ven=[" + DTOC(loc_oBO.this_dVencimento) + "] Val=[" + ;
                  TRANSFORM(loc_oBO.this_nValor) + "]" + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (loc_lRet AND ALLTRIM(loc_oBO.this_cBanco) == "341" AND ;
                   ALLTRIM(loc_oBO.this_cAgencia) == "1234" AND ;
                   ALLTRIM(loc_oBO.this_cConta) == "0056789012" AND ;
                   ALLTRIM(loc_oBO.this_cCheque) == "000777" AND ;
                   loc_oBO.this_dVencimento = DATE() AND loc_oBO.this_nValor = 1234.56)
        STRTOFILE("   nove criterios no BO conferem = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 5) ROUND-TRIP tela -> BO -> tela (identidade)
        STRTOFILE(CHR(13) + CHR(10) + "5) round-trip tela -> BO -> tela (identidade):" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.TesteBOParaForm()
        STRTOFILE("   tela: Bco=[" + loc_oForm.txt_4c_Banco.Value + "] Age=[" + loc_oForm.txt_4c_Agencia.Value + ;
                  "] Con=[" + loc_oForm.txt_4c_Conta.Value + "] Che=[" + loc_oForm.txt_4c_Cheque.Value + ;
                  "] Ven=[" + DTOC(loc_oForm.txt_4c_Vencimento.Value) + "] Val=[" + ;
                  TRANSFORM(loc_oForm.txt_4c_Valor.Value) + "]" + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (ALLTRIM(loc_oForm.txt_4c_Banco.Value) == "341" AND ;
                   ALLTRIM(loc_oForm.txt_4c_Agencia.Value) == "1234" AND ;
                   ALLTRIM(loc_oForm.txt_4c_Conta.Value) == "0056789012" AND ;
                   ALLTRIM(loc_oForm.txt_4c_Cheque.Value) == "000777" AND ;
                   loc_oForm.txt_4c_Vencimento.Value = DATE() AND ;
                   loc_oForm.txt_4c_Valor.Value = 1234.56)
        STRTOFILE("   identidade preservada = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: o round-trip alterou o valor" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 6) LimparCampos repoe o estado do Init
        STRTOFILE(CHR(13) + CHR(10) + "6) LimparCampos:" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.TesteLimparCampos()
        loc_lOk = (EMPTY(loc_oForm.txt_4c_Banco.Value)     AND EMPTY(loc_oForm.txt_4c_Agencia.Value) AND ;
                   EMPTY(loc_oForm.txt_4c_Conta.Value)      AND EMPTY(loc_oForm.txt_4c_Cheque.Value) AND ;
                   EMPTY(loc_oForm.txt_4c_Vencimento.Value) AND loc_oForm.txt_4c_Valor.Value = 0 AND ;
                   EMPTY(loc_oForm.txt_4c_Controle.Value)   AND EMPTY(loc_oForm.txt_4c_Protocolo.Value) AND ;
                   LEN(loc_oForm.txt_4c_Arquivo.Value) = 6)
        STRTOFILE("   nove campos de volta ao estado do Init = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 7) CarregarLista com TODOS os criterios vazios
        STRTOFILE(CHR(13) + CHR(10) + "7) CarregarLista com criterios VAZIOS:" + CHR(13) + CHR(10), OUT, 1)
        IF USED("cursor_4c_SigChe")
            USE IN cursor_4c_SigChe
        ENDIF
        loc_lRet = loc_oForm.CarregarLista()
        STRTOFILE("   retorno = " + TRANSFORM(loc_lRet) + ;
                  "  cursor_4c_SigChe aberto = " + TRANSFORM(USED("cursor_4c_SigChe")) + ;
                  "  cursor_4c_SigCheTmp aberto = " + TRANSFORM(USED("cursor_4c_SigCheTmp")) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lRet OR USED("cursor_4c_SigChe") OR USED("cursor_4c_SigCheTmp")
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: criterio vazio deveria devolver .T. sem criar cursor" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 8) BtnCancelarClick fecha e repoe os criterios
        STRTOFILE(CHR(13) + CHR(10) + "8) BtnCancelarClick:" + CHR(13) + CHR(10), OUT, 1)
        loc_oForm.txt_4c_Controle.Value = "00012345"
        loc_oForm.BtnCancelarClick()
        STRTOFILE("   Visible=" + TRANSFORM(loc_oForm.Visible) + ;
                  "  Controle=[" + loc_oForm.txt_4c_Controle.Value + "]" + CHR(13) + CHR(10), OUT, 1)
        IF loc_oForm.Visible OR !EMPTY(loc_oForm.txt_4c_Controle.Value)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: fechar deveria esconder a tela e repor os criterios" + CHR(13) + CHR(10), OUT, 1)
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

DEFINE CLASS ProbeChbF8 AS FormSigOpChb
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION TesteBOParaForm()
        RETURN THIS.BOParaForm()
    ENDFUNC
    PROCEDURE TesteLimparCampos()
        THIS.LimparCampos()
    ENDPROC
ENDDEFINE
