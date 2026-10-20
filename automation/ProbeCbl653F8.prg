*==============================================================================
* ProbeCbl653F8.prg - Probe funcional da Fase 8 de FormSigOpCbl (task653)
*
* MEDE em VFP9 (nao le o codigo):
*   1) o form INSTANCIA
*   2) escopos: CarregarLista/BtnConfirmarClick/BtnCancelarClick/Text*LostFocus
*      PUBLIC (chamados de fora / alvos de BINDEVENT - regra #3);
*      FormParaBO/BOParaForm PROTECTED (FormBase os declara assim)
*   3) GetPaperSize() RESOLVE e honra o contrato SUBSTR(x,11)=descricao
*   4) Text29LostFocus com impressora INSTALADA: nao abre dialogo, preserva
*      o valor (prova o fix APRINTERS + LOCAL ARRAY - erro 232 antes)
*   5) Text30LostFocus com fonte INSTALADA: idem (prova o fix AFONT/ALEN -
*      erro 107 antes, por comparar LOGICO com 0)
*   6) Text40LostFocus com campo vazio: preenche descricao e guarda o
*      composto CRU em BO.this_cTamfolha
*   7) guarda de reentrancia this_lEmDialogo bloqueia o 2o disparo
*   8) FormParaBO/BOParaForm ida-e-volta
*   9) MontarTamanhoFolhaComFonte / ExtrairDescricaoTamanhoFolha contra a
*      formula do legado
*  10) CarregarLista sem conexao nao derruba o form
*  11) BtnCancelarClick com confirmacao declinada nao libera o form
*
* NAO chama Show(): o form eh modal (WindowType = 1) e travaria o harness.
* Em gb_4c_ModoTeste, MsgConfirma devolve .F. e MsgAviso/MsgErro gravam em
* arquivo - nenhum dialogo bloqueia.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_cbl653.txt"
#DEFINE OUT "C:\4c\automation\probe_cbl653_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_cL, loc_nFalhas, loc_oE, loc_cTam, loc_cImp, loc_cFnt
LOCAL loc_lRet, loc_cRes
LOCAL ARRAY loc_aP[1], loc_aF[1]
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigOpCbl (task653) ===" + CHR(13) + CHR(10), OUT)
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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpCblBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpCbl.prg") ADDITIVE
    SET PROCEDURE TO "C:\4c\automation\ProbeCbl653F8.prg"    ADDITIVE

    gnConnHandle = -1
    gb_4c_ModoTeste = .T.

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("ProbeCblF8")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " Width=" + TRANSFORM(loc_oForm.Width) + ;
        " Height=" + TRANSFORM(loc_oForm.Height) + " ControlCount=" + ;
        TRANSFORM(loc_oForm.ControlCount), " *** NAO ABRIU ***") + CHR(13)+CHR(10), OUT, 1)
    IF VARTYPE(loc_oForm) != "O"
        STRTOFILE("PROBE_FALHAS=NAO_ABRIU" + CHR(13)+CHR(10), OUT, 1)
        QUIT
    ENDIF
    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2) escopos (atributo 2 = Protected)
    loc_cL = "2) escopos (Protected=.T. significa inacessivel de fora):" + CHR(13)+CHR(10) + ;
        "   CarregarLista      Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2))     + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnConfirmarClick  Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnConfirmarClick",2)) + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnCancelarClick   Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2))  + " esperado .F." + CHR(13)+CHR(10) + ;
        "   Text29LostFocus    Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"Text29LostFocus",2))   + " esperado .F." + CHR(13)+CHR(10) + ;
        "   Text30LostFocus    Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"Text30LostFocus",2))   + " esperado .F." + CHR(13)+CHR(10) + ;
        "   Text40LostFocus    Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"Text40LostFocus",2))   + " esperado .F." + CHR(13)+CHR(10) + ;
        "   BtnEncerrarClick   Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnEncerrarClick",2))  + " esperado .F. (existe=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnEncerrarClick",5)) + ")" + CHR(13)+CHR(10) + ;
        "   FormParaBO         Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2))        + " esperado .T." + CHR(13)+CHR(10) + ;
        "   BOParaForm         Prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2))        + " esperado .T." + CHR(13)+CHR(10)
    IF PEMSTATUS(loc_oForm,"CarregarLista",2) OR PEMSTATUS(loc_oForm,"BtnConfirmarClick",2) ;
       OR PEMSTATUS(loc_oForm,"BtnCancelarClick",2) OR PEMSTATUS(loc_oForm,"Text29LostFocus",2) ;
       OR PEMSTATUS(loc_oForm,"Text30LostFocus",2) OR PEMSTATUS(loc_oForm,"Text40LostFocus",2) ;
       OR PEMSTATUS(loc_oForm,"BtnEncerrarClick",2) OR !PEMSTATUS(loc_oForm,"BtnEncerrarClick",5)
        loc_cL = loc_cL + "   *** FALHA: metodo chamado de fora esta PROTECTED" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 3) GetPaperSize resolve + contrato
    loc_cTam = GetPaperSize()
    loc_cL = "3) GetPaperSize() -> tipo=" + VARTYPE(loc_cTam) + " len=" + TRANSFORM(LEN(loc_cTam)) + ;
        " cod=[" + LEFT(loc_cTam,10) + "] desc=[" + SUBSTR(loc_cTam,11) + "]" + CHR(13)+CHR(10)
    IF VARTYPE(loc_cTam) != "C" OR LEN(loc_cTam) <= 10 OR EMPTY(SUBSTR(loc_cTam,11))
        loc_cL = loc_cL + "   *** FALHA: contrato (10 chars de codigo + descricao) nao atendido" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 4) Text29LostFocus com impressora INSTALADA (sem dialogo)
    = APRINTERS(loc_aP)
    loc_cImp = ALLTRIM(loc_aP[1,1])
    loc_oForm.txt_4c_Text29.Value = loc_cImp
    loc_oForm.Text29LostFocus()
    loc_cL = "4) Text29LostFocus com impressora instalada [" + loc_cImp + "]" + CHR(13)+CHR(10) + ;
        "   valor depois = [" + ALLTRIM(loc_oForm.txt_4c_Text29.Value) + "] (deve ser igual)" + CHR(13)+CHR(10)
    IF UPPER(ALLTRIM(loc_oForm.txt_4c_Text29.Value)) != UPPER(loc_cImp)
        loc_cL = loc_cL + "   *** FALHA: handler alterou impressora valida" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 5) Text30LostFocus com fonte INSTALADA (sem dialogo)
    = AFONT(loc_aF)
    loc_cFnt = ALLTRIM(loc_aF[ALEN(loc_aF,1)])
    loc_oForm.txt_4c_Text30.Value = loc_cFnt
    loc_oForm.txt_4c_Text31.Value = 10
    loc_oForm.Text30LostFocus()
    loc_cL = "5) Text30LostFocus com fonte instalada [" + loc_cFnt + "]" + CHR(13)+CHR(10) + ;
        "   valor depois = [" + ALLTRIM(loc_oForm.txt_4c_Text30.Value) + "] tam=" + ;
        TRANSFORM(loc_oForm.txt_4c_Text31.Value) + " LockScreen=" + ;
        TRANSFORM(loc_oForm.LockScreen) + " (LockScreen deve voltar .F.)" + CHR(13)+CHR(10)
    IF UPPER(ALLTRIM(loc_oForm.txt_4c_Text30.Value)) != UPPER(loc_cFnt) OR loc_oForm.LockScreen
        loc_cL = loc_cL + "   *** FALHA: handler alterou fonte valida ou deixou LockScreen ligado" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 6) Text40LostFocus com campo vazio
    loc_oForm.txt_4c_Text40.Value = ""
    loc_oBO.this_cTamfolha = ""
    loc_oForm.Text40LostFocus()
    loc_cL = "6) Text40LostFocus com campo vazio:" + CHR(13)+CHR(10) + ;
        "   Text40 = [" + ALLTRIM(loc_oForm.txt_4c_Text40.Value) + "]" + CHR(13)+CHR(10) + ;
        "   BO.this_cTamfolha (CRU) = [" + loc_oBO.this_cTamfolha + "]" + CHR(13)+CHR(10)
    IF EMPTY(loc_oForm.txt_4c_Text40.Value) OR EMPTY(loc_oBO.this_cTamfolha) ;
       OR ALLTRIM(loc_oForm.txt_4c_Text40.Value) != ALLTRIM(SUBSTR(loc_oBO.this_cTamfolha,11))
        loc_cL = loc_cL + "   *** FALHA: campo/BO nao refletem o contrato do GetPaperSize" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 7) guarda de reentrancia
    loc_oForm.this_lEmDialogo = .T.
    loc_oForm.txt_4c_Text40.Value = ""
    loc_oForm.Text40LostFocus()
    loc_cL = "7) reentrancia: this_lEmDialogo=.T. -> Text40 = [" + ;
        ALLTRIM(loc_oForm.txt_4c_Text40.Value) + "] (deve continuar VAZIO)" + CHR(13)+CHR(10)
    IF !EMPTY(loc_oForm.txt_4c_Text40.Value)
        loc_cL = loc_cL + "   *** FALHA: guarda nao bloqueou o 2o disparo" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.this_lEmDialogo = .F.
    STRTOFILE(loc_cL, OUT, 1)

    *-- 8) FormParaBO / BOParaForm ida-e-volta
    loc_oForm.txt_4c_Text1.Value  = 12.34
    loc_oForm.txt_4c_Text13.Value = 40
    loc_oForm.txt_4c_Text14.Value = 3
    loc_oForm.txt_4c_Text28.Value = 55.25
    loc_oForm.txt_4c_Text31.Value = 9
    loc_oForm.TesteFormParaBO()
    loc_cL = "8) FormParaBO:" + CHR(13)+CHR(10) + ;
        "   Text1=12.34  -> BO.this_nNlnlocals=" + TRANSFORM(loc_oBO.this_nNlnlocals) + CHR(13)+CHR(10) + ;
        "   Text13=40    -> BO.this_nNtxtcols=" + TRANSFORM(loc_oBO.this_nNtxtcols) + CHR(13)+CHR(10) + ;
        "   Text14=3     -> BO.this_nNtxtlins=" + TRANSFORM(loc_oBO.this_nNtxtlins) + CHR(13)+CHR(10) + ;
        "   Text28=55.25 -> BO.this_nNclcepcobs=" + TRANSFORM(loc_oBO.this_nNclcepcobs) + CHR(13)+CHR(10) + ;
        "   Text31=9     -> BO.this_nTamfontes=" + TRANSFORM(loc_oBO.this_nTamfontes) + CHR(13)+CHR(10)
    IF loc_oBO.this_nNlnlocals != 12.34 OR loc_oBO.this_nNtxtcols != 40 ;
       OR loc_oBO.this_nNtxtlins != 3 OR loc_oBO.this_nNclcepcobs != 55.25 ;
       OR loc_oBO.this_nTamfontes != 9
        loc_cL = loc_cL + "   *** FALHA no FormParaBO" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_oForm.txt_4c_Text1.Value  = 0
    loc_oForm.txt_4c_Text28.Value = 0
    loc_oBO.this_nNlnlocals  = 77.77
    loc_oBO.this_nNclcepcobs = 88.88
    loc_oBO.this_cTamfolha   = "Arial/       256/Personalizado"
    loc_oForm.TesteBOParaForm()
    loc_cL = loc_cL + "   BOParaForm: BO 77.77/88.88 -> Text1=" + TRANSFORM(loc_oForm.txt_4c_Text1.Value) + ;
        " Text28=" + TRANSFORM(loc_oForm.txt_4c_Text28.Value) + ;
        " Text40=[" + ALLTRIM(loc_oForm.txt_4c_Text40.Value) + "] esperado [Personalizado]" + CHR(13)+CHR(10)
    IF loc_oForm.txt_4c_Text1.Value != 77.77 OR loc_oForm.txt_4c_Text28.Value != 88.88 ;
       OR ALLTRIM(loc_oForm.txt_4c_Text40.Value) != "Personalizado"
        loc_cL = loc_cL + "   *** FALHA no BOParaForm" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 9) formulas do legado (cmdOk.Click e Init)
    loc_cL = "9) formulas do legado:" + CHR(13)+CHR(10)
    loc_cRes = loc_oForm.TesteMontar("Arial", STR(256,10) + "Personalizado")
    loc_cL = loc_cL + "   Montar(cru sem separador) = [" + loc_cRes + "]" + CHR(13)+CHR(10)
    IF loc_cRes != "Arial/       256/Personalizado"
        loc_cL = loc_cL + "   *** FALHA: ramo sem separador do cmdOk.Click" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_cRes = loc_oForm.TesteMontar("Tahoma", "Arial/256/Personalizado")
    loc_cL = loc_cL + "   Montar(ja remontado)      = [" + loc_cRes + "] esperado [Tahoma/256/Personalizado]" + CHR(13)+CHR(10)
    IF loc_cRes != "Tahoma/256/Personalizado"
        loc_cL = loc_cL + "   *** FALHA: ramo de troca de fonte" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_cRes = loc_oForm.TesteMontar("Tahoma", "")
    loc_cL = loc_cL + "   Montar(vazio)             = [" + loc_cRes + "] esperado [Tahoma/]" + CHR(13)+CHR(10)
    IF loc_cRes != "Tahoma/"
        loc_cL = loc_cL + "   *** FALHA: ramo de ctamfolha vazio" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_cRes = loc_oForm.TesteExtrair("Arial/256/A4 210 x 297 mm")
    loc_cL = loc_cL + "   Extrair(3 segmentos)      = [" + loc_cRes + "] esperado [A4 210 x 297 mm]" + CHR(13)+CHR(10)
    IF loc_cRes != "A4 210 x 297 mm"
        loc_cL = loc_cL + "   *** FALHA: Extrair" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    loc_cRes = loc_oForm.TesteExtrair("Arial/")
    loc_cL = loc_cL + "   Extrair(sem 2o separador) = [" + loc_cRes + "] esperado vazio" + CHR(13)+CHR(10)
    IF !EMPTY(loc_cRes)
        loc_cL = loc_cL + "   *** FALHA: Extrair sem 2o separador" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 10) CarregarLista sem conexao nao derruba o form
    loc_lRet = loc_oForm.CarregarLista()
    loc_cL = "10) CarregarLista() sem conexao -> retorno=" + TRANSFORM(loc_lRet) + ;
        " form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O") + CHR(13)+CHR(10)
    IF VARTYPE(loc_oForm) != "O"
        loc_cL = loc_cL + "   *** FALHA: form morreu" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    *-- 11) BtnCancelarClick com MsgConfirma devolvendo .F. (modo teste):
    *--     nao libera o form e repoe o LockScreen
    loc_oForm.BtnEncerrarClick()
    loc_cL = "11) BtnEncerrarClick -> BtnCancelarClick (declinada): form vivo=" + ;
        TRANSFORM(VARTYPE(loc_oForm) = "O") + " LockScreen=" + TRANSFORM(loc_oForm.LockScreen) + ;
        " (deve ser .F.)" + CHR(13)+CHR(10)
    IF VARTYPE(loc_oForm) != "O" OR loc_oForm.LockScreen
        loc_cL = loc_cL + "   *** FALHA: form liberado sem confirmar ou LockScreen preso" + CHR(13)+CHR(10)
        loc_nFalhas = loc_nFalhas + 1
    ENDIF
    STRTOFILE(loc_cL, OUT, 1)

    STRTOFILE(CHR(13)+CHR(10) + IIF(loc_nFalhas = 0, "PROBE_OK", ;
        "PROBE_FALHAS=" + TRANSFORM(loc_nFalhas)) + CHR(13)+CHR(10), OUT, 1)
CATCH TO loc_oE
    STRTOFILE("*** EXCECAO: " + loc_oE.Message + " | Linha " + TRANSFORM(loc_oE.LineNo) + ;
        " | Proc " + loc_oE.Procedure + CHR(13)+CHR(10) + "PROBE_FALHAS=EXCECAO" + CHR(13)+CHR(10), OUT, 1)
ENDTRY

QUIT

*-- Subclasse para alcancar os hooks PROTECTED (script solto nao alcanca
*-- membro protegido; subclasse alcanca - tecnica padrao do projeto).
DEFINE CLASS ProbeCblF8 AS FormSigOpCbl
    FUNCTION TesteFormParaBO()
        RETURN THIS.FormParaBO()
    ENDFUNC
    FUNCTION TesteBOParaForm()
        RETURN THIS.BOParaForm()
    ENDFUNC
    FUNCTION TesteMontar(par_cFonte, par_cTam)
        RETURN THIS.MontarTamanhoFolhaComFonte(par_cFonte, par_cTam)
    ENDFUNC
    FUNCTION TesteExtrair(par_cTam)
        RETURN THIS.ExtrairDescricaoTamanhoFolha(par_cTam)
    ENDFUNC
ENDDEFINE
