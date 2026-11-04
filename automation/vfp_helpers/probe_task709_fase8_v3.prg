*==============================================================================
* probe_task709_fase8.prg - Probe de RUNTIME da Fase 8 do FormSIGOPCPE
*
* Prova em execucao o que a compilacao nao prova:
*   - os 4 metodos da Fase 8 existem e sao PUBLIC (PEMSTATUS(...,2) = .F.)
*   - CarregarLista() abre, indexa, semeia e posiciona o cursor
*   - o Cmb_Tipo abre em BRANCO (fidelidade ao legado)
*   - ValidarTipo() reposiciona e alterna os blocos condicionais
*   - FormParaBO() descarrega a tela na linha do cursor E nas properties
*   - BOParaForm() repinta os controles a partir das properties
*   - CarregarLista() de RECARGA volta ao dispositivo escolhido
*   - FormParaBO() em EOF devolve .F. SEM escrever
*   - BtnCancelarClick() libera o form
*
* NAO chama ConfigurarAmbiente() - ela nao retorna nesta maquina; as
* dependencias sao carregadas a mao.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
CLOSE ALL
CLEAR ALL

PUBLIC gc_cSaida, gc_cTexto
gc_cSaida = "C:\4c\automation\vfp_helpers\probe_task709_fase8_v3_result.txt"
gc_cTexto = "PROBE FASE 8 - FormSIGOPCPE - " + TTOC(DATETIME()) + CHR(13) + CHR(10)
STRTOFILE(gc_cTexto, gc_cSaida)

PUBLIC gnConnHandle, gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gnConnHandle           = 0
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\probe_task709_fase8_v3_erros.txt"
STRTOFILE("", gc_4c_ArquivoErroTeste)

LOCAL loc_oForm, loc_oErro, loc_nDS, loc_nI, loc_cTipo

DO ("C:\4c\projeto\app\start\config.prg")

SET PATH TO (gc_4c_CaminhoBase + "," + gc_4c_CaminhoClasses + "," + ;
             gc_4c_CaminhoUtils + "," + gc_4c_CaminhoForms + "," + ;
             gc_4c_CaminhoIcones)

SET PROCEDURE TO (gc_4c_CaminhoClasses + "dataaccess.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "businessbase.prg") ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "formbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "gridbase.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "FormErro.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "functions.prg")    ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "messages.prg")     ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoUtils   + "validators.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoClasses + "SIGOPCPEBO.prg")   ADDITIVE
SET PROCEDURE TO (gc_4c_CaminhoForms + "operacionais\FormSIGOPCPE.prg") ADDITIVE

Anota("SETUP OK")

*------------------------------------------------------------------------------
* 1 - Instanciacao
*------------------------------------------------------------------------------
loc_oForm = .NULL.
TRY
    loc_oForm = CREATEOBJECT("ProbeFormSIGOPCPE")
CATCH TO loc_oErro
    Anota("FALHA CREATEOBJECT: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
        " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) != "O"
    Anota("ABORTADO - CREATEOBJECT devolveu " + VARTYPE(loc_oForm))
    QUIT
ENDIF

Anota("1 CREATEOBJECT OK  Caption=[" + loc_oForm.Caption + "]  DataSessionId=" + ;
    TRANSFORM(loc_oForm.DataSessionId))

*------------------------------------------------------------------------------
* 2 - Escopo dos metodos: 2 = Protected. TODOS tem de dar .F. (PUBLIC)
*------------------------------------------------------------------------------
DIMENSION loc_aMet[8]
loc_aMet[1] = "CarregarLista"
loc_aMet[2] = "BOParaForm"
loc_aMet[3] = "FormParaBO"
loc_aMet[4] = "BtnCancelarClick"
loc_aMet[5] = "BtnEncerrarClick"
loc_aMet[6] = "BtnConfirmarClick"
loc_aMet[7] = "ValidarTipo"
loc_aMet[8] = "AplicarVisibilidadePorTipo"

FOR loc_nI = 1 TO ALEN(loc_aMet)
    Anota("2 " + PADR(loc_aMet[loc_nI], 28) + ;
        " existe=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 5)) + ;
        " protected=" + TRANSFORM(PEMSTATUS(loc_oForm, loc_aMet[loc_nI], 2)) + ;
        "   (esperado .T. SO em BOParaForm/FormParaBO - hooks PROTECTED no FormBase)")
ENDFOR

*------------------------------------------------------------------------------
* 3 - Estado da abertura (dentro da datasession privada do form)
*------------------------------------------------------------------------------
loc_nDS = SET("DATASESSION")
SET DATASESSION TO loc_oForm.DataSessionId

Anota("3 cursor USED=" + TRANSFORM(USED("cursor_4c_Dados")) + ;
    " RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
    " TAG=[" + TAG(1, "cursor_4c_Dados") + "]" + ;
    " ORDER=[" + ORDER("cursor_4c_Dados") + "]")

SELECT cursor_4c_Dados
Anota("3 linha corrente na abertura: tipos=[" + ALLTRIM(cursor_4c_Dados.tipos) + "]" + ;
    " settings=[" + ALLTRIM(cursor_4c_Dados.settings) + "]")

Anota("3 Cmb_Tipo ListCount=" + TRANSFORM(loc_oForm.cbo_4c_Cmb_Tipo.ListCount) + ;
    " ListIndex=" + TRANSFORM(loc_oForm.cbo_4c_Cmb_Tipo.ListIndex) + ;
    "  (legado abre em BRANCO: ListIndex esperado = 0)")

Anota("3 blocos condicionais escondidos na abertura: Label12=" + ;
    TRANSFORM(loc_oForm.lbl_4c_Label12.Visible) + ;
    " Opt_leitor=" + TRANSFORM(loc_oForm.obj_4c_Opt_leitor.Visible))

*------------------------------------------------------------------------------
* 4 - ValidarTipo: escolhe "Leitora Cheques" (item 3) e confere
*------------------------------------------------------------------------------
loc_oForm.cbo_4c_Cmb_Tipo.ListIndex = 3
loc_cTipo = ALLTRIM(loc_oForm.cbo_4c_Cmb_Tipo.Value)
Anota("4 combo apos ListIndex=3 -> Value=[" + loc_cTipo + "]")

loc_oForm.ValidarTipo()

SELECT cursor_4c_Dados
Anota("4 apos ValidarTipo: linha=[" + ALLTRIM(cursor_4c_Dados.tipos) + "]" + ;
    " BO.this_cTipos=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cTipos) + "]" + ;
    " this_cTipoSelecionado=[" + ALLTRIM(loc_oForm.this_cTipoSelecionado) + "]")

Anota("4 visibilidade apos ValidarTipo: Label12=" + TRANSFORM(loc_oForm.lbl_4c_Label12.Visible) + ;
    " Get_TpLeChq=" + TRANSFORM(loc_oForm.cbo_4c_Get_TpLeChq.Visible) + ;
    " Label13=" + TRANSFORM(loc_oForm.lbl_4c_Label13.Visible) + ;
    " Opt_leitor=" + TRANSFORM(loc_oForm.obj_4c_Opt_leitor.Visible) + ;
    "  (as 4 esperadas .T.)")

*------------------------------------------------------------------------------
* 5 - FormParaBO: edicao na TELA tem de chegar as PROPERTIES do BO
*
* O ControlSource ja leva o valor ao cursor; o que estava faltando - e eh o
* que este metodo entrega - eh a property do BO, que fica STALE sem ele.
*------------------------------------------------------------------------------
Anota("5 ANTES: BO.this_cSettings=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cSettings) + "]")

loc_oForm.txt_4c_Set.Value          = "4800,e,7,2"
loc_oForm.obj_4c_Spinner1.Value     = 5
loc_oForm.chk_4c_Chk_dtr.Value      = .T.
loc_oForm.chk_4c_Chk_Bompara.Value  = 1
loc_oForm.obj_4c_Opt_leitor.Value   = 3
loc_oForm.cbo_4c_Get_TpLeChq.Value  = "S"
loc_oForm.txt_4c_Inbuf.Value        = 1024

Anota("5 BO.this_cSettings SEM FormParaBO (stale esperado)=[" + ;
    ALLTRIM(loc_oForm.this_oBusinessObject.this_cSettings) + "]")

Anota("5 FormParaBO retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO()))

SELECT cursor_4c_Dados
Anota("5 CURSOR: settings=[" + ALLTRIM(cursor_4c_Dados.settings) + "]" + ;
    " portas=" + TRANSFORM(cursor_4c_Dados.portas) + ;
    " dtrs=" + TRANSFORM(cursor_4c_Dados.dtrs) + ;
    " bompara=" + TRANSFORM(cursor_4c_Dados.bompara) + ;
    " tpbarras=" + TRANSFORM(cursor_4c_Dados.tpbarras) + ;
    " tplechqs=[" + ALLTRIM(cursor_4c_Dados.tplechqs) + "]" + ;
    " inbufs=" + TRANSFORM(cursor_4c_Dados.inbufs))

Anota("5 BO    : this_cSettings=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cSettings) + "]" + ;
    " this_nPortas=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nPortas) + ;
    " this_lDtrs=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lDtrs) + ;
    " this_nBompara=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nBompara) + ;
    " this_nTpbarras=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTpbarras) + ;
    " this_cTplechqs=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cTplechqs) + "]" + ;
    " this_nInbufs=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nInbufs))

Anota("5 tipos NAO foi tocado pelo FormParaBO: linha=[" + ALLTRIM(cursor_4c_Dados.tipos) + "]")

*------------------------------------------------------------------------------
* 6 - BOParaForm: property -> controle (e, pelo ControlSource, -> cursor)
*------------------------------------------------------------------------------
loc_oForm.this_oBusinessObject.this_nPortas   = 7
loc_oForm.this_oBusinessObject.this_cSettings = "19200,n,8,1"
loc_oForm.this_oBusinessObject.this_nTpbarras = 1

Anota("6 BOParaForm retorno=" + TRANSFORM(loc_oForm.ProbeBOParaForm()))

SELECT cursor_4c_Dados
Anota("6 CONTROLES: Spinner=" + TRANSFORM(loc_oForm.obj_4c_Spinner1.Value) + ;
    " txt_Set=[" + ALLTRIM(loc_oForm.txt_4c_Set.Value) + "]" + ;
    " Opt_leitor=" + TRANSFORM(loc_oForm.obj_4c_Opt_leitor.Value) + ;
    " Cmb_Tipo.ListIndex=" + TRANSFORM(loc_oForm.cbo_4c_Cmb_Tipo.ListIndex))
Anota("6 CURSOR   : portas=" + TRANSFORM(cursor_4c_Dados.portas) + ;
    " settings=[" + ALLTRIM(cursor_4c_Dados.settings) + "]" + ;
    " tpbarras=" + TRANSFORM(cursor_4c_Dados.tpbarras))

*------------------------------------------------------------------------------
* 7 - BOParaForm NAO promove zero (regra #45)
*------------------------------------------------------------------------------
loc_oForm.this_oBusinessObject.this_nTpbarras = 0
loc_oForm.ProbeBOParaForm()
SELECT cursor_4c_Dados
Anota("7 tpbarras = 0 preservado: Opt_leitor.Value=" + ;
    TRANSFORM(loc_oForm.obj_4c_Opt_leitor.Value) + ;
    " cursor.tpbarras=" + TRANSFORM(cursor_4c_Dados.tpbarras) + ;
    "  (esperado 0 nos dois - nao promover para 1)")

*------------------------------------------------------------------------------
* 8 - CarregarLista de RECARGA: tem de voltar ao dispositivo escolhido
*------------------------------------------------------------------------------
Anota("8 CarregarLista retorno=" + TRANSFORM(loc_oForm.CarregarLista()))
SELECT cursor_4c_Dados
Anota("8 apos recarga: RECCOUNT=" + TRANSFORM(RECCOUNT("cursor_4c_Dados")) + ;
    " linha=[" + ALLTRIM(cursor_4c_Dados.tipos) + "]" + ;
    " ORDER=[" + ORDER("cursor_4c_Dados") + "]" + ;
    " Cmb_Tipo.ListIndex=" + TRANSFORM(loc_oForm.cbo_4c_Cmb_Tipo.ListIndex) + ;
    "  (esperado: 6 linhas, linha=Leitora Cheques, ListIndex=3)")

*------------------------------------------------------------------------------
* 9 - FormParaBO em EOF devolve .F. SEM escrever
*------------------------------------------------------------------------------
SELECT cursor_4c_Dados
GO BOTTOM
SKIP
Anota("9 EOF=" + TRANSFORM(EOF("cursor_4c_Dados")) + ;
    " FormParaBO retorno=" + TRANSFORM(loc_oForm.ProbeFormParaBO()) + "  (esperado .F.)")

SELECT cursor_4c_Dados
GO TOP

SET DATASESSION TO loc_nDS

*------------------------------------------------------------------------------
* 10 - BtnCancelarClick libera o form
*------------------------------------------------------------------------------
loc_oForm.BtnCancelarClick()
Anota("10 apos BtnCancelarClick: VARTYPE(loForm)=" + VARTYPE(loc_oForm) + ;
    " objeto vivo=" + TRANSFORM(TYPE("loc_oForm.Caption") = "C") + ;
    "  (esperado: referencia morta)")

Anota("10 cursor_4c_Dados na sessao default USED=" + TRANSFORM(USED("cursor_4c_Dados")))

Anota("FIM - erros capturados em modo teste:")
Anota(FILETOSTR(gc_4c_ArquivoErroTeste))

QUIT

PROCEDURE Anota(par_cLinha)
    gc_cTexto = gc_cTexto + par_cLinha + CHR(13) + CHR(10)
    STRTOFILE(gc_cTexto, gc_cSaida)
ENDPROC

*==============================================================================
* Subclasse SO de probe: os hooks FormParaBO/BOParaForm sao PROTECTED por
* heranca do FormBase (formbase.prg:280/285), entao nao da para chama-los de
* fora. Os wrappers abaixo os alcancam de DENTRO da classe, que eh o unico
* caminho valido, e devolvem o retorno para o probe conferir.
*==============================================================================
DEFINE CLASS ProbeFormSIGOPCPE AS FormSIGOPCPE

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

ENDDEFINE
