*==============================================================================
* ProbeNch770Fase8.prg - Probe da Fase 8 de FormSigOpNch (task770)
*
* Prova, MEDINDO em VFP9 (nao lendo o codigo):
*   1) o form INSTANCIA (CREATEOBJECT devolve objeto, nao .F.)
*   2) escopos: CelulaChequeWhen/CelulaChequeValid/BtnCancelarClick/
*      CarregarLista PUBLIC (chamados de FORA - pela subclasse do TextBox e
*      pelo harness); FormParaBO/BOParaForm PROTECTED (hooks de FormBase,
*      que o override nao alarga - regra #51)
*   3) a celula COM EVENTO esta instalada na Column5: txt_4c_Celula existe,
*      CurrentControl aponta para ela, Sparse = .F., ReadOnly = .F. e o
*      InputMask do dump ("999999") chegou ao controle instalado
*   4) a celula SOBREVIVE a um rebind da grade (CarregarGrade de novo)
*   5) CelulaChequeWhen guarda o valor anterior em this_nAntChqVal
*   6) CelulaChequeValid com numero NEGATIVO devolve 0 (numerico - eh o que
*      PRENDE o foco), restaura a celula e NAO marca a linha
*   7) CelulaChequeValid com numero MUDADO marca a linha (Marcas = .T.) e
*      BO.ContarChequesAlterados passa a enxergar 1 linha
*   8) CelulaChequeValid com numero IGUAL ao anterior NAO marca a linha
*
* NAO chama Show(): o form eh modal (WindowType = 1) e Show() BLOQUEARIA o
* harness headless.
*
* O cursor da grade vive na DATASESSION PRIVADA do form (DataSession = 2):
* sem o SET DATASESSION TO o probe nao o enxerga e mediria o nada.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gnConnHandle, gc_4c_UsuarioLogado, gb_4c_ValidandoUI
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_err_nch770.txt"
#DEFINE OUT "C:\4c\automation\probe_nch770_f8.txt"

LOCAL loc_oForm, loc_oBO, loc_nFalhas, loc_oE, loc_lOk, loc_uRet
LOCAL loc_oCol, loc_oCel, loc_nSessaoAnt, loc_cCursor
loc_nFalhas = 0

STRTOFILE("=== PROBE Fase 8 - FormSigOpNch (Numeracao de Cheques) ===" + CHR(13) + CHR(10), OUT)

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
    SET PROCEDURE TO (gcCaminhoClasses + "SigOpNchBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSigOpNch.prg") ADDITIVE

    gnConnHandle = -1

    *-- 1) instanciacao
    loc_oForm = CREATEOBJECT("FormSigOpNch")
    STRTOFILE("1) CREATEOBJECT -> VARTYPE=" + VARTYPE(loc_oForm) + CHR(13) + CHR(10), OUT, 1)

    IF VARTYPE(loc_oForm) != "O"
        loc_nFalhas = loc_nFalhas + 1
        STRTOFILE("   FALHA: form nao instanciou" + CHR(13) + CHR(10), OUT, 1)
    ELSE
        loc_oBO = loc_oForm.this_oBusinessObject
        loc_cCursor = loc_oBO.this_cCursorCheques
        STRTOFILE("   BO VARTYPE=" + VARTYPE(loc_oBO) + "  Caption=[" + loc_oForm.Caption + "]" + CHR(13) + CHR(10), OUT, 1)

        *-- 2) escopos (atributo 2 = PROTECTED)
        STRTOFILE(CHR(13) + CHR(10) + "2) escopos (atributo 2 = PROTECTED):" + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CelulaChequeWhen  PROT = " + TRANSFORM(PEMSTATUS(loc_oForm, "CelulaChequeWhen", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CelulaChequeValid PROT = " + TRANSFORM(PEMSTATUS(loc_oForm, "CelulaChequeValid", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   BtnCancelarClick  PROT = " + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   CarregarLista     PROT = " + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   FormParaBO        PROT = " + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + CHR(13) + CHR(10), OUT, 1)
        STRTOFILE("   BOParaForm        PROT = " + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + CHR(13) + CHR(10), OUT, 1)
        IF PEMSTATUS(loc_oForm, "CelulaChequeWhen", 2) OR PEMSTATUS(loc_oForm, "CelulaChequeValid", 2) ;
           OR PEMSTATUS(loc_oForm, "BtnCancelarClick", 2) OR PEMSTATUS(loc_oForm, "CarregarLista", 2)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: metodo chamado de FORA nao pode ser PROTECTED" + CHR(13) + CHR(10), OUT, 1)
        ENDIF
        IF !PEMSTATUS(loc_oForm, "FormParaBO", 2) OR !PEMSTATUS(loc_oForm, "BOParaForm", 2)
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: hook de FormBase deveria continuar PROTECTED" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 3) a celula COM EVENTO na Column5
        STRTOFILE(CHR(13) + CHR(10) + "3) celula instalada na Column5:" + CHR(13) + CHR(10), OUT, 1)
        loc_oCol = loc_oForm.grd_4c_Dados.Columns(5)
        loc_lOk  = PEMSTATUS(loc_oCol, "txt_4c_Celula", 5)
        STRTOFILE("   txt_4c_Celula existe = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF loc_lOk
            loc_oCel = loc_oCol.txt_4c_Celula
            STRTOFILE("   BaseClass=[" + loc_oCel.BaseClass + "] Class=[" + loc_oCel.Class + "]" + ;
                      " CurrentControl=[" + loc_oCol.CurrentControl + "]" + ;
                      " Sparse=" + TRANSFORM(loc_oCol.Sparse) + ;
                      " Col.ReadOnly=" + TRANSFORM(loc_oCol.ReadOnly) + ;
                      " InputMask=[" + loc_oCel.InputMask + "]" + CHR(13) + CHR(10), OUT, 1)
            loc_lOk = (UPPER(loc_oCel.Class) == "TEXTBOXCHEQUESIGOPNCH_4C" AND ;
                       UPPER(ALLTRIM(loc_oCol.CurrentControl)) == "TXT_4C_CELULA" AND ;
                       !loc_oCol.Sparse AND !loc_oCol.ReadOnly AND ;
                       ALLTRIM(loc_oCel.InputMask) == "999999")
        ENDIF
        STRTOFILE("   contrato da regra #18 conferido = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 4) a celula sobrevive a um REBIND da grade
        STRTOFILE(CHR(13) + CHR(10) + "4) rebind da grade (CarregarGrade de novo):" + CHR(13) + CHR(10), OUT, 1)
        loc_uRet = loc_oForm.CarregarLista()
        loc_oCol = loc_oForm.grd_4c_Dados.Columns(5)
        loc_lOk  = PEMSTATUS(loc_oCol, "txt_4c_Celula", 5) AND ;
                   UPPER(ALLTRIM(loc_oCol.CurrentControl)) == "TXT_4C_CELULA" AND !loc_oCol.Sparse
        STRTOFILE("   CarregarLista=" + TRANSFORM(loc_uRet) + ;
                  "  RecordSource=[" + loc_oForm.grd_4c_Dados.RecordSource + "]" + ;
                  "  celula sobreviveu = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: o rebind levou a celula e o Valid nunca rodaria" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- entra na datasession PRIVADA do form para mexer no cursor da grade
        loc_nSessaoAnt = SET("Datasession")
        SET DATASESSION TO loc_oForm.DataSessionId

        INSERT INTO (loc_cCursor) (FPags, Bancos, Agencias, NContas, Cheques, Marcas) ;
               VALUES ("DINHEIRO    ", "341", "1234", "0056789012", 100, .F.)
        INSERT INTO (loc_cCursor) (FPags, Bancos, Agencias, NContas, Cheques, Marcas) ;
               VALUES ("CHEQUE      ", "237", "5678", "0099887766", 200, .F.)
        SELECT (loc_cCursor)
        GO TOP

        loc_oCel = loc_oForm.grd_4c_Dados.Columns(5).txt_4c_Celula

        *-- 5) When guarda o valor anterior
        STRTOFILE(CHR(13) + CHR(10) + "5) CelulaChequeWhen guarda o anterior:" + CHR(13) + CHR(10), OUT, 1)
        loc_oCel.Value = 100
        loc_uRet = loc_oForm.CelulaChequeWhen(loc_oCel)
        STRTOFILE("   retorno=" + TRANSFORM(loc_uRet) + "  this_nAntChqVal=" + ;
                  TRANSFORM(loc_oForm.this_nAntChqVal) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_uRet OR loc_oForm.this_nAntChqVal != 100
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: o When deveria devolver .T. e guardar 100" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 6) Valid com NEGATIVO: devolve 0, restaura e NAO marca
        STRTOFILE(CHR(13) + CHR(10) + "6) CelulaChequeValid com numero NEGATIVO:" + CHR(13) + CHR(10), OUT, 1)
        loc_oCel.Value = -5
        loc_uRet = loc_oForm.CelulaChequeValid(loc_oCel)
        SELECT (loc_cCursor)
        GO TOP
        STRTOFILE("   retorno=[" + TRANSFORM(loc_uRet) + "] VARTYPE=" + VARTYPE(loc_uRet) + ;
                  "  celula=" + TRANSFORM(loc_oCel.Value) + ;
                  "  Marcas=" + TRANSFORM(EVALUATE(loc_cCursor + ".Marcas")) + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (VARTYPE(loc_uRet) = "N" AND loc_uRet = 0 AND loc_oCel.Value = 100 AND ;
                   !EVALUATE(loc_cCursor + ".Marcas"))
        STRTOFILE("   recusa do legado reproduzida = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
        ENDIF

        *-- 7) Valid com numero MUDADO: marca a linha
        STRTOFILE(CHR(13) + CHR(10) + "7) CelulaChequeValid com numero MUDADO:" + CHR(13) + CHR(10), OUT, 1)
        SELECT (loc_cCursor)
        GO TOP
        loc_oCel.Value = 100
        loc_oForm.CelulaChequeWhen(loc_oCel)
        loc_oCel.Value = 150
        loc_uRet = loc_oForm.CelulaChequeValid(loc_oCel)
        SELECT (loc_cCursor)
        GO TOP
        STRTOFILE("   retorno=" + TRANSFORM(loc_uRet) + ;
                  "  Marcas=" + TRANSFORM(EVALUATE(loc_cCursor + ".Marcas")) + ;
                  "  BO.this_nProxCheque=" + TRANSFORM(loc_oBO.this_nProxCheque) + ;
                  "  BO.this_nConteudo=" + TRANSFORM(loc_oBO.this_nConteudo) + ;
                  "  BO.this_cValor=[" + loc_oBO.this_cValor + "] len=" + ;
                  TRANSFORM(LEN(loc_oBO.this_cValor)) + CHR(13) + CHR(10), OUT, 1)
        loc_lOk = (VARTYPE(loc_uRet) = "L" AND loc_uRet AND EVALUATE(loc_cCursor + ".Marcas") AND ;
                   loc_oBO.this_nProxCheque = 150 AND loc_oBO.this_nConteudo = 149 AND ;
                   LEN(loc_oBO.this_cValor) = 25)
        STRTOFILE("   linha marcada e BO carregado = " + TRANSFORM(loc_lOk) + CHR(13) + CHR(10), OUT, 1)
        IF !loc_lOk
            loc_nFalhas = loc_nFalhas + 1
        ENDIF
        STRTOFILE("   BO.ContarChequesAlterados=" + ;
                  TRANSFORM(loc_oBO.ContarChequesAlterados(loc_cCursor)) + CHR(13) + CHR(10), OUT, 1)
        IF loc_oBO.ContarChequesAlterados(loc_cCursor) != 1
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: contagem de linhas marcadas diferente de 1" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        *-- 8) Valid com numero IGUAL: NAO marca (2a linha, ainda limpa)
        STRTOFILE(CHR(13) + CHR(10) + "8) CelulaChequeValid com numero IGUAL (2a linha):" + CHR(13) + CHR(10), OUT, 1)
        SELECT (loc_cCursor)
        GO BOTTOM
        loc_oCel.Value = 200
        loc_oForm.CelulaChequeWhen(loc_oCel)
        loc_uRet = loc_oForm.CelulaChequeValid(loc_oCel)
        SELECT (loc_cCursor)
        GO BOTTOM
        STRTOFILE("   retorno=" + TRANSFORM(loc_uRet) + ;
                  "  Marcas=" + TRANSFORM(EVALUATE(loc_cCursor + ".Marcas")) + CHR(13) + CHR(10), OUT, 1)
        IF EVALUATE(loc_cCursor + ".Marcas")
            loc_nFalhas = loc_nFalhas + 1
            STRTOFILE("   FALHA: passar o foco sem mudar nada marcou a linha" + CHR(13) + CHR(10), OUT, 1)
        ENDIF

        SET DATASESSION TO loc_nSessaoAnt
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
