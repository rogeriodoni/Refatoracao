*==============================================================================
* ProbeFase8Task662.prg
*
* Prova, instanciando de verdade (regra "a tela abriu so se prova
* instanciando"), que a Fase 8 de SIGPROER -> Formsigproer entrega:
*   1) o form ABRE (CREATEOBJECT devolve objeto, nao .F.);
*   2) o Init de OITO argumentos distribui os parametros como o legado -
*      com o 6o SOBRESCREVENDO o 4o (pcData aparece duas vezes na lista de
*      PARAMETERS) e o 8o chegando em this_cCodEstabs;
*   3) os dois hooks FormParaBO/BOParaForm existem, sao PROTECTED (como em
*      FormBase - [[feedback_formbase_hooks_protected_nao_alargam]]) e
*      FUNCIONAM: round-trip real pelo buffer do BO.
*
* Os hooks sao exercitados por uma SUBCLASSE (ProbeFormsigproer, no fim
* deste arquivo), nunca direto do script: PROTECTED herdado de FormBase
* nao pode ser alargado, e PEMSTATUS(...,5) responde "existe?", nao "da
* para chamar daqui?".
*
* SET SAFETY OFF / SET RESOURCE OFF: o pipeline roda sem supervisao.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

IF !DIRECTORY("C:\4c\automation\logs_task662")
    MD "C:\4c\automation\logs_task662"
ENDIF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\logs_task662\probe_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

CD C:\4c\projeto\app\start
DO config.prg

gb_4c_ValidandoUI = .T.
gb_4c_ModoTeste   = .T.

SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + "," + gcCaminhoForms + "," + gcCaminhoIcones)
SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoClasses + "sigproerBO.prg")   ADDITIVE
SET PROCEDURE TO (gcCaminhoForms + "operacionais\Formsigproer.prg") ADDITIVE

LOCAL loc_oForm, loc_oErro, loc_cOut, loc_lOk, loc_cNL
loc_cNL  = CHR(13) + CHR(10)
loc_cOut = ""
loc_lOk  = .T.

TRY
    *-- Mesmos 8 argumentos do call site real (Formsigproef, migrado de
    *-- SIGPROEF:1066): NumIps, CnCaixas, NSU, lcData, cnValors, cndttrans,
    *-- cnhrtrans, CodEstabs. Todos CHARACTER, como o schema declara.
    *-- Instanciado ja como ProbeFormsigproer para que os hooks PROTECTED
    *-- possam ser exercitados de dentro da classe.
    loc_oForm = CREATEOBJECT("ProbeFormsigproer", ;
        "10.0.0.1", "001", "000000012345", "01012026", ;
        "      123.45", "31122025", "1530", "ESTAB001")

    loc_cOut = loc_cOut + "VARTYPE_FORM=" + VARTYPE(loc_oForm) + loc_cNL

    IF VARTYPE(loc_oForm) <> "O"
        loc_lOk = .F.
    ELSE
        *-- (2) distribuicao dos 8 argumentos
        loc_cOut = loc_cOut + "this_cEndSitef=["  + ALLTRIM(loc_oForm.this_cEndSitef)  + "]" + loc_cNL
        loc_cOut = loc_cOut + "this_cCaixa=["     + ALLTRIM(loc_oForm.this_cCaixa)     + "]" + loc_cNL
        loc_cOut = loc_cOut + "this_cNSU=["       + ALLTRIM(loc_oForm.this_cNSU)       + "]" + loc_cNL
        loc_cOut = loc_cOut + "this_cDataSitef=[" + ALLTRIM(loc_oForm.this_cDataSitef) + "]  (legado: 6o arg sobrescreve o 4o)" + loc_cNL
        loc_cOut = loc_cOut + "this_cValor=["     + ALLTRIM(loc_oForm.this_cValor)     + "]" + loc_cNL
        loc_cOut = loc_cOut + "this_cHora=["      + ALLTRIM(loc_oForm.this_cHora)      + "]" + loc_cNL
        loc_cOut = loc_cOut + "this_cCodEstabs=[" + ALLTRIM(loc_oForm.this_cCodEstabs) + "]" + loc_cNL

        IF !(ALLTRIM(loc_oForm.this_cDataSitef) == "31122025")
            loc_lOk  = .F.
            loc_cOut = loc_cOut + "FALHA: 6o argumento nao sobrescreveu o 4o" + loc_cNL
        ENDIF
        IF !(ALLTRIM(loc_oForm.this_cCodEstabs) == "ESTAB001")
            loc_lOk  = .F.
            loc_cOut = loc_cOut + "FALHA: 8o argumento nao chegou em this_cCodEstabs" + loc_cNL
        ENDIF
        IF !(ALLTRIM(loc_oForm.this_cValor) == "123.45")
            loc_lOk  = .F.
            loc_cOut = loc_cOut + "FALHA: 5o argumento (char) nao chegou em this_cValor" + loc_cNL
        ENDIF

        *-- (3) hooks: existem e sao PROTECTED (atributo 2), como em FormBase
        loc_cOut = loc_cOut + "PEM_FORMPARABO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
                   "  PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 2)) + loc_cNL
        loc_cOut = loc_cOut + "PEM_BOPARAFORM=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
                   "  PROTECTED=" + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 2)) + loc_cNL
        loc_cOut = loc_cOut + "PEM_BTNCANCELAR=" + TRANSFORM(PEMSTATUS(loc_oForm, "BtnCancelarClick", 5)) + loc_cNL

        IF !PEMSTATUS(loc_oForm, "FormParaBO", 5) OR !PEMSTATUS(loc_oForm, "BOParaForm", 5)
            loc_lOk  = .F.
            loc_cOut = loc_cOut + "FALHA: hook ausente" + loc_cNL
        ENDIF

        *-- (3b) round-trip real pelo buffer do BO, por dentro da classe
        loc_oForm.txt_4c_SenhaSupervisor.Value = "9876"
        loc_cOut = loc_cOut + "FormParaBO()=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + loc_cNL
        loc_cOut = loc_cOut + "  BO.Buffer(1:4)=[" + LEFT(loc_oForm.this_oBusinessObject.this_cBuffer, 4) + "]" + ;
                   "  LEN=" + TRANSFORM(LEN(loc_oForm.this_oBusinessObject.this_cBuffer)) + ;
                   "  Continua=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nContinua) + loc_cNL

        IF !(LEFT(loc_oForm.this_oBusinessObject.this_cBuffer, 4) == "9876") ;
           OR LEN(loc_oForm.this_oBusinessObject.this_cBuffer) <> 2000 ;
           OR loc_oForm.this_oBusinessObject.this_nContinua <> 1000
            loc_lOk  = .F.
            loc_cOut = loc_cOut + "FALHA: FormParaBO nao montou o buffer do legado" + loc_cNL
        ENDIF

        loc_oForm.ProbeBOParaForm()
        loc_cOut = loc_cOut + "BOParaForm -> this_cMensagem(1:4)=[" + LEFT(loc_oForm.this_cMensagem, 4) + "]" + ;
                   "  BO.Continua=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nContinua) + ;
                   "  BO.Buffer limpo=" + TRANSFORM(LEFT(loc_oForm.this_oBusinessObject.this_cBuffer, 1) == CHR(0)) + loc_cNL

        IF !(LEFT(loc_oForm.this_cMensagem, 4) == "9876") ;
           OR loc_oForm.this_oBusinessObject.this_nContinua <> 0 ;
           OR !(LEFT(loc_oForm.this_oBusinessObject.this_cBuffer, 1) == CHR(0))
            loc_lOk  = .F.
            loc_cOut = loc_cOut + "FALHA: BOParaForm nao reproduziu o ELSE do laco legado" + loc_cNL
        ENDIF

        *-- (4) FormParaBO devolve .F. sem nada a enviar
        *--     (IF EMPTY(This.Value) / RETURN dos dois LostFocus legado)
        loc_oForm.txt_4c_SenhaSupervisor.Value = ""
        loc_cOut = loc_cOut + "FormParaBO() com campo vazio=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + loc_cNL
        IF loc_oForm.ProbeFormParaBO()
            loc_lOk  = .F.
            loc_cOut = loc_cOut + "FALHA: FormParaBO devolveu .T. com campo vazio" + loc_cNL
        ENDIF

        loc_oForm.Release()
    ENDIF
CATCH TO loc_oErro
    loc_lOk  = .F.
    loc_cOut = loc_cOut + "EXCECAO: " + loc_oErro.Message + ;
               "  Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
               "  Procedure: " + loc_oErro.Procedure + loc_cNL
ENDTRY

loc_cOut = loc_cOut + IIF(loc_lOk, "VEREDITO=PASSA", "VEREDITO=REPROVA") + loc_cNL
loc_cOut = loc_cOut + "ERROS_RUNTIME=[" + ALLTRIM(FILETOSTR(gc_4c_ArquivoErroTeste)) + "]" + loc_cNL

STRTOFILE(loc_cOut, "C:\4c\automation\logs_task662\saida_probe.txt")
QUIT

*==============================================================================
* ProbeFormsigproer - subclasse SO do harness. Os hooks FormParaBO/BOParaForm
* sao PROTECTED (vem assim de FormBase e o VFP9 nao deixa a subclasse alargar
* o escopo), entao a unica forma legitima de exercita-los eh por DENTRO da
* classe - [[feedback_formbase_hooks_protected_nao_alargam]].
*==============================================================================
DEFINE CLASS ProbeFormsigproer AS Formsigproer

    FUNCTION ProbeFormParaBO(par_oCampo)
        RETURN THIS.FormParaBO(par_oCampo)
    ENDFUNC

    PROCEDURE ProbeBOParaForm()
        THIS.BOParaForm()
    ENDPROC

ENDDEFINE
