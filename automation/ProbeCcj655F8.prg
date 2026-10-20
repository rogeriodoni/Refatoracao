*==============================================================================
* ProbeCcj655F8.prg - Probe funcional da Fase 8 de FormSigOpCcj (task655)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA com os 5 parametros do legado e cria os 5 campos
*   2) SEM form de origem valido o Init RECUSA (guard do Init legado)
*   3) escopos: BtnConfirmarClick/BtnSairClick/handlers de lookup PUBLIC
*      (chamados de fora / alvos de BINDEVENT - regra #3);
*      FormParaBO/BOParaForm PROTECTED (FormBase os declara assim)
*   4) FormParaBO: as 5 caixas -> as 5 properties do BO
*   5) BOParaForm: as properties do BO -> as 5 caixas
*   6) BOParaForm NAO sobrescreve a Conta quando o BO nao achou nada
*      (equivalente ao guard Not Empty(IClis) do Valid legado)
*   7) LimparBlocoConjugeEConta zera caixas E properties do BO
*   8) AtualizarEstadoCampoConjuge reproduz o When legado
*      (a caixa de R.G. vem da coluna Rgs, nao de RgConjuges - regra #17)
*      (getRgConjuges habilitado so com getConjuges vazio)
*   9) BtnConfirmarClick DEVOLVE os 3 valores + a flag ao form CHAMADOR
*      pelos NOMES recebidos como parametro, e fecha o dialogo
*  10) BtnConfirmarClick sem form de origem valido nao estoura
*
* NAO chama Show(): o form eh modal (WindowType = 1) e travaria o harness.
* Em gb_4c_ModoTeste, MsgAviso/MsgErro gravam em arquivo - nada bloqueia.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_ccj655.txt"
#DEFINE OUT "C:\4c\automation\probe_ccj655_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_oPai, loc_cL, loc_nFalhas, loc_oE, loc_oSemPai
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigOpCcj (task655) ===" + CHR(13) + CHR(10), OUT)
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gc_4c_UsuarioLogado = "TESTE"
    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpCcjBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCcj.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeCcj655F8.prg"    ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    *-- form CHAMADOR simulado, com os 3 controles de destino e a property
    *-- de retorno - exatamente o que o legado espera receber por NOME.
    loc_oPai = CREATEOBJECT("ProbePaiCcj")

    *-- 1) instanciacao COM parametros validos
    loc_oForm = CREATEOBJECT("ProbeCcjF8", loc_oPai, "txt_Destino_IClis", ;
        "txt_Destino_Cpfs", "txt_Destino_RClis", "plAchouConta")
    loc_cL = "1) CREATEOBJECT com parametros -> VARTYPE=" + VARTYPE(loc_oForm)
    IF VARTYPE(loc_oForm) = "O"
        loc_cL = loc_cL + " Width=" + TRANSFORM(loc_oForm.Width) + ;
            " Height=" + TRANSFORM(loc_oForm.Height) + ;
            " ControlCount=" + TRANSFORM(loc_oForm.ControlCount) + CHR(13)+CHR(10) + ;
            "   campos: Conjuges=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_Conjuges",5)) + ;
            " RgConjuges=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_RgConjuges",5)) + ;
            " IClis=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_IClis",5)) + ;
            " Cpfs=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_Cpfs",5)) + ;
            " RClis=" + TRANSFORM(PEMSTATUS(loc_oForm,"txt_4c_RClis",5)) + CHR(13)+CHR(10) + ;
            "   botoes: Confirmar=" + TRANSFORM(PEMSTATUS(loc_oForm,"cmd_4c_Btnconfirmar",5)) + ;
            " Sair=" + TRANSFORM(PEMSTATUS(loc_oForm,"cmd_4c_Btnsair",5)) + CHR(13)+CHR(10)
    ELSE
        loc_cL = loc_cL + " *** NAO ABRIU ***" + CHR(13)+CHR(10)
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) SEM form de origem o Init RECUSA (guard do legado)
    loc_oSemPai = CREATEOBJECT("ProbeCcjF8")
    loc_cL = "2) CREATEOBJECT sem parametros -> VARTYPE=" + VARTYPE(loc_oSemPai) + ;
        " (esperado L = recusado pelo guard do Init legado)" + CHR(13)+CHR(10)
    IF VARTYPE(loc_oSemPai) = "O"
        loc_cL = loc_cL + "   *** FALHA: abriu sem form de origem valido" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) escopos (atributo 2 = Protected)
    loc_cL = "3) escopos (Protected=.T. significa inacessivel de fora):" + CHR(13)+CHR(10) + ;
        "   BtnConfirmarClick    Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnConfirmarClick",2))    + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnSairClick         Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnSairClick",2))         + " esperado .F." + CHR(13)+CHR(10) + ;
        "   ConjugesLostFocus    Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ConjugesLostFocus",2))    + " esperado .F." + CHR(13)+CHR(10) + ;
        "   RgConjugesLostFocus  Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"RgConjugesLostFocus",2))  + " esperado .F." + CHR(13)+CHR(10) + ;
        "   ConjugesKeyPress     Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ConjugesKeyPress",2))     + " esperado .F." + CHR(13)+CHR(10) + ;
        "   RgConjugesKeyPress   Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"RgConjugesKeyPress",2))   + " esperado .F." + CHR(13)+CHR(10) + ;
        "   ValidarConjuges      Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"ValidarConjuges",2))      + " esperado .F." + CHR(13)+CHR(10) + ;
        "   AtualizarEstadoCampoConjuge Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AtualizarEstadoCampoConjuge",2)) + " esperado .T. (so chamada internamente por THIS., nao eh alvo de BINDEVENT)" + CHR(13)+CHR(10) + ;
        "   FormParaBO           Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2))           + " esperado .T." + CHR(13)+CHR(10) + ;
        "   BOParaForm           Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2))           + " esperado .T." + CHR(13)+CHR(10)
    IF PEMSTATUS(loc_oForm,"BtnConfirmarClick",2) OR PEMSTATUS(loc_oForm,"BtnSairClick",2) ;
       OR PEMSTATUS(loc_oForm,"ConjugesLostFocus",2) OR PEMSTATUS(loc_oForm,"RgConjugesLostFocus",2) ;
       OR PEMSTATUS(loc_oForm,"ConjugesKeyPress",2) OR PEMSTATUS(loc_oForm,"RgConjugesKeyPress",2) ;
       OR PEMSTATUS(loc_oForm,"ValidarConjuges",2) OR !PEMSTATUS(loc_oForm,"AtualizarEstadoCampoConjuge",2) ;
       OR !PEMSTATUS(loc_oForm,"FormParaBO",2) OR !PEMSTATUS(loc_oForm,"BOParaForm",2)
        loc_cL = loc_cL + "   *** FALHA de escopo" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) FormParaBO: caixas -> BO
    loc_oForm.txt_4c_Conjuges.Value   = "MARIA DA SILVA"
    loc_oForm.txt_4c_RgConjuges.Value = "123456789"
    loc_oForm.txt_4c_IClis.Value      = "0000000042"
    loc_oForm.txt_4c_Cpfs.Value       = "11122233344"
    loc_oForm.txt_4c_RClis.Value      = "JOAO DA SILVA"
    loc_oForm.TesteFormParaBO()
    loc_cL = "4) FormParaBO:" + CHR(13)+CHR(10) + ;
        "   BO.this_cConjuges   = [" + loc_oBO.this_cConjuges   + "]" + CHR(13)+CHR(10) + ;
        "   BO.this_cRgConjuges = [" + loc_oBO.this_cRgConjuges + "]  BO.this_cRgs = [" + loc_oBO.this_cRgs + "]" + CHR(13)+CHR(10) + ;
        "   BO.this_cIClis      = [" + loc_oBO.this_cIClis      + "]" + CHR(13)+CHR(10) + ;
        "   BO.this_cCpfs       = [" + loc_oBO.this_cCpfs       + "]" + CHR(13)+CHR(10) + ;
        "   BO.this_cRClis      = [" + loc_oBO.this_cRClis      + "]" + CHR(13)+CHR(10)
    IF loc_oBO.this_cConjuges != "MARIA DA SILVA" OR loc_oBO.this_cRgConjuges != "123456789" ;
       OR loc_oBO.this_cRgs != "123456789" ;
       OR loc_oBO.this_cIClis != "0000000042" OR loc_oBO.this_cCpfs != "11122233344" ;
       OR loc_oBO.this_cRClis != "JOAO DA SILVA"
        loc_cL = loc_cL + "   *** FALHA no FormParaBO" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) BOParaForm: BO -> caixas
    loc_oForm.txt_4c_Conjuges.Value   = ""
    loc_oForm.txt_4c_RgConjuges.Value = ""
    loc_oForm.txt_4c_IClis.Value      = ""
    loc_oForm.txt_4c_Cpfs.Value       = ""
    loc_oForm.txt_4c_RClis.Value      = ""
    loc_oBO.this_cConjuges   = "ANA PEREIRA"
    loc_oBO.this_cRgConjuges = "RGCONJ-IGNORADO"
    loc_oBO.this_cRgs        = "987654321"
    loc_oBO.this_cIClis      = "0000000099"
    loc_oBO.this_cCpfs       = "55566677788"
    loc_oBO.this_cRClis      = "CARLOS PEREIRA"
    loc_oForm.TesteBOParaForm()
    loc_cL = "5) BOParaForm:" + CHR(13)+CHR(10) + ;
        "   Conjuges=["   + ALLTRIM(loc_oForm.txt_4c_Conjuges.Value)   + "]" + ;
        " RgConjuges(da coluna Rgs)=["   + ALLTRIM(loc_oForm.txt_4c_RgConjuges.Value) + "]" + CHR(13)+CHR(10) + ;
        "   IClis=["      + ALLTRIM(loc_oForm.txt_4c_IClis.Value)      + "]" + ;
        " Cpfs=["         + ALLTRIM(loc_oForm.txt_4c_Cpfs.Value)       + "]" + ;
        " RClis=["        + ALLTRIM(loc_oForm.txt_4c_RClis.Value)      + "]" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_Conjuges.Value) != "ANA PEREIRA" ;
       OR ALLTRIM(loc_oForm.txt_4c_RgConjuges.Value) != "987654321" ;
       OR ALLTRIM(loc_oForm.txt_4c_IClis.Value) != "0000000099" ;
       OR ALLTRIM(loc_oForm.txt_4c_Cpfs.Value) != "55566677788" ;
       OR ALLTRIM(loc_oForm.txt_4c_RClis.Value) != "CARLOS PEREIRA"
        loc_cL = loc_cL + "   *** FALHA no BOParaForm" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) BO sem conta encontrada: BOParaForm NAO mexe no bloco Conta
    loc_oBO.this_cIClis    = ""
    loc_oBO.this_cCpfs     = ""
    loc_oBO.this_cRClis    = ""
    loc_oBO.this_cConjuges = "ZULMIRA"
    loc_oForm.TesteBOParaForm()
    loc_cL = "6) BOParaForm com BO sem conta (this_cIClis vazio):" + CHR(13)+CHR(10) + ;
        "   Conjuges=[" + ALLTRIM(loc_oForm.txt_4c_Conjuges.Value) + "] (deve ser ZULMIRA)" + CHR(13)+CHR(10) + ;
        "   IClis=["    + ALLTRIM(loc_oForm.txt_4c_IClis.Value) + "] (deve CONTINUAR 0000000099)" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oForm.txt_4c_Conjuges.Value) != "ZULMIRA" ;
       OR ALLTRIM(loc_oForm.txt_4c_IClis.Value) != "0000000099"
        loc_cL = loc_cL + "   *** FALHA: nao reproduz o guard Not Empty(IClis) do Valid legado" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) LimparBlocoConjugeEConta zera caixas E BO
    loc_oForm.TesteLimpar()
    loc_cL = "7) LimparBlocoConjugeEConta:" + CHR(13)+CHR(10) + ;
        "   caixas vazias = " + TRANSFORM(EMPTY(loc_oForm.txt_4c_Conjuges.Value) ;
            AND EMPTY(loc_oForm.txt_4c_RgConjuges.Value) AND EMPTY(loc_oForm.txt_4c_IClis.Value) ;
            AND EMPTY(loc_oForm.txt_4c_Cpfs.Value) AND EMPTY(loc_oForm.txt_4c_RClis.Value)) + CHR(13)+CHR(10) + ;
        "   BO vazio      = " + TRANSFORM(EMPTY(loc_oBO.this_cConjuges) AND EMPTY(loc_oBO.this_cRgConjuges) ;
            AND EMPTY(loc_oBO.this_cIClis) AND EMPTY(loc_oBO.this_cCpfs) AND EMPTY(loc_oBO.this_cRClis)) + CHR(13)+CHR(10)
    IF !(EMPTY(loc_oForm.txt_4c_Conjuges.Value) AND EMPTY(loc_oForm.txt_4c_IClis.Value) ;
         AND EMPTY(loc_oBO.this_cConjuges) AND EMPTY(loc_oBO.this_cIClis))
        loc_cL = loc_cL + "   *** FALHA: residuo depois de limpar" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 8) When legado: getRgConjuges habilitado so com getConjuges vazio
    loc_oForm.txt_4c_Conjuges.Value = ""
    loc_oForm.TesteAtualizarEstado()
    loc_cL = "8) When legado (Empty(getConjuges.Value)) - replicado via .ReadOnly:" + CHR(13)+CHR(10) + ;
        "   Conjuges vazio      -> RgConjuges.ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_RgConjuges.ReadOnly) + " esperado .F. (editavel)" + CHR(13)+CHR(10)
    IF loc_oForm.txt_4c_RgConjuges.ReadOnly
        loc_cL = loc_cL + "   *** FALHA" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.txt_4c_Conjuges.Value = "ALGUEM"
    loc_oForm.TesteAtualizarEstado()
    loc_cL = loc_cL + "   Conjuges preenchido -> RgConjuges.ReadOnly=" + ;
        TRANSFORM(loc_oForm.txt_4c_RgConjuges.ReadOnly) + " esperado .T. (travado)" + CHR(13)+CHR(10)
    IF !loc_oForm.txt_4c_RgConjuges.ReadOnly
        loc_cL = loc_cL + "   *** FALHA" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 9) BtnConfirmarClick devolve ao form CHAMADOR e fecha
    loc_oForm.txt_4c_Conjuges.Value   = "MARIA"
    loc_oForm.txt_4c_RgConjuges.Value = ""
    loc_oForm.txt_4c_IClis.Value      = "0000000777"
    loc_oForm.txt_4c_Cpfs.Value       = "99988877766"
    loc_oForm.txt_4c_RClis.Value      = "PEDRO ALVES"
    loc_oForm.BtnConfirmarClick()
    loc_cL = "9) BtnConfirmarClick -> form CHAMADOR:" + CHR(13)+CHR(10) + ;
        "   pai.txt_Destino_IClis.Value = [" + ALLTRIM(loc_oPai.txt_Destino_IClis.Value) + "] esperado [0000000777]" + CHR(13)+CHR(10) + ;
        "   pai.txt_Destino_Cpfs.Value  = [" + ALLTRIM(loc_oPai.txt_Destino_Cpfs.Value)  + "] esperado [99988877766]" + CHR(13)+CHR(10) + ;
        "   pai.txt_Destino_RClis.Value = [" + ALLTRIM(loc_oPai.txt_Destino_RClis.Value) + "] esperado [PEDRO ALVES]" + CHR(13)+CHR(10) + ;
        "   pai.plAchouConta            = " + TRANSFORM(loc_oPai.plAchouConta) + " esperado .T." + CHR(13)+CHR(10) + ;
        "   dialogo fechado (VARTYPE)   = " + VARTYPE(loc_oForm) + " esperado X (objeto liberado)" + CHR(13)+CHR(10)
    IF ALLTRIM(loc_oPai.txt_Destino_IClis.Value) != "0000000777" ;
       OR ALLTRIM(loc_oPai.txt_Destino_Cpfs.Value) != "99988877766" ;
       OR ALLTRIM(loc_oPai.txt_Destino_RClis.Value) != "PEDRO ALVES" ;
       OR !loc_oPai.plAchouConta
        loc_cL = loc_cL + "   *** FALHA: nao devolveu ao form chamador" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    IF VARTYPE(loc_oForm) = "O"
        loc_cL = loc_cL + "   *** FALHA: dialogo nao fechou (legado faz ThisForm.Release)" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 10) Confirmar com form de origem invalido nao estoura
    loc_oForm = CREATEOBJECT("ProbeCcjF8", loc_oPai, "txt_Destino_IClis", ;
        "txt_Destino_Cpfs", "txt_Destino_RClis", "plAchouConta")
    loc_oForm.this_oParentForm = .NULL.
    loc_oForm.BtnConfirmarClick()
    STRTOFILE("10) BtnConfirmarClick com this_oParentForm NULL -> sem excecao, VARTYPE=" + ;
        VARTYPE(loc_oForm) + " (esperado X: fecha sem copiar)" + CHR(13)+CHR(10), OUT, 1)

    STRTOFILE(CHR(13)+CHR(10) + IIF(loc_nFalhas = 0, "PROBE_OK", ;
        "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas)) + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | Proc " + loc_oE.Procedure + CHR(13)+CHR(10) + "PROBE_FALHAS=EXCECAO" + CHR(13)+CHR(10), OUT, 1)
ENDTRY

QUIT

*-- Subclasse para alcancar os hooks PROTECTED (script solto nao alcanca
*-- membro protegido; subclasse alcanca - tecnica padrao do projeto).
DEFINE CLASS ProbeCcjF8 AS FormSigOpCcj
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION TesteBOParaForm()
        RETURN THIS.BOParaForm()
    ENDFUNC
    FUNCTION TesteAtualizarEstado()
        RETURN THIS.AtualizarEstadoCampoConjuge()
    ENDFUNC
    FUNCTION TesteLimpar()
        RETURN THIS.LimparBlocoConjugeEConta()
    ENDFUNC
ENDDEFINE

*-- Form CHAMADOR simulado: os 3 controles de destino e a property de
*-- retorno, com os MESMOS nomes passados ao Init - eh por esses nomes que
*-- o legado escreve de volta no form de origem.
DEFINE CLASS ProbePaiCcj AS Form
    plAchouConta = .F.
    ADD OBJECT txt_Destino_IClis AS TextBox WITH Value = ""
    ADD OBJECT txt_Destino_Cpfs  AS TextBox WITH Value = ""
    ADD OBJECT txt_Destino_RClis AS TextBox WITH Value = ""
ENDDEFINE
