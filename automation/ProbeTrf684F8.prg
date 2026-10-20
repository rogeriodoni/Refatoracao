*==============================================================================
* ProbeTrf684F8.prg - Instancia FormSIGPRTRF headless (Fase 8 / task684) e
* exercita o que a Fase 8 acrescentou:
*   (1) ValidarParametros() devolve .T. em modo de teste (bypass) - se nao
*       devolvesse, InicializarForm daria .F. e CREATEOBJECT devolveria logico;
*   (2) escopo: os metodos que o harness chama de FORA tem de ser PUBLIC;
*   (3) FormParaBO() le a linha corrente da grade para o BO;
*   (4) BOParaForm() grava o produto do BO no cursor E nas duas celulas;
*   (5) ObterCelulaCodigo() alcanca Column1.txt_4c_CelCodigo;
*   (6) HabilitarCampos(.F./.T.) liga/desliga grade e os 2 botoes;
*   (7) LimparCampos() com ZAP sob DataSession=2 NAO congela (guarda de
*       SET SAFETY) e devolve a grade a 1 linha em branco;
*   (8) Unload()/ObterRetorno()/ObterListaProdutos() devolvem o contrato;
*   (9) BtnOkClick com a grade VAZIA recusa (conta do legado "x=0");
*  (10) MontarListaProdutos monta a lista com produto na grade.
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina).
* Nao depende de SQL Server: gb_4c_ValidandoUI pula o SQLEXEC do BO.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_trf684_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oErro, loc_oGrd, loc_oCel, loc_nIni
loc_cOut = "C:\4c\automation\probe_trf684_f8_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "TextBoxGridLookup.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGPRTRFBO.prg")   ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "operacionais\FormSIGPRTRF.prg") ADDITIVE
    STRTOFILE(CHR(13) + CHR(10) + "deps OK", loc_cOut, 1)

    *-- SAFETY da sessao 1 (o form roda em DataSession=2, onde vale ON)
    STRTOFILE(CHR(13) + CHR(10) + "SAFETY_sessao1=" + SET("SAFETY"), loc_cOut, 1)

    *-- (1) Init completo, ja passando por ValidarParametros().
    *-- Instancia a SUBCLASSE de teste (fim deste arquivo): FormParaBO,
    *-- BOParaForm e LimparCampos sao PROTECTED no FormBase e, por heranca,
    *-- PROTECTED tambem aqui (regra #51) - nao se alcancam de fora da
    *-- classe. A subclasse so expoe wrappers finos para o probe; o codigo
    *-- de producao fica intocado.
    loc_oForm = CREATEOBJECT("FormTrfProbe_4c")
    STRTOFILE(CHR(13) + CHR(10) + "CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oGrd = loc_oForm.cnt_4c__Referencia.grd_4c_Dados

        *-- (2) escopo: PEMSTATUS(...,2) = Protected. Harness chama de fora.
        STRTOFILE(CHR(13) + CHR(10) + "PROT_ValidarParametros="  + TRANSFORM(PEMSTATUS(loc_oForm, "ValidarParametros", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_HabilitarCampos="    + TRANSFORM(PEMSTATUS(loc_oForm, "HabilitarCampos", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_ObterCelulaCodigo="  + TRANSFORM(PEMSTATUS(loc_oForm, "ObterCelulaCodigo", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_ObterRetorno="       + TRANSFORM(PEMSTATUS(loc_oForm, "ObterRetorno", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_ObterListaProdutos=" + TRANSFORM(PEMSTATUS(loc_oForm, "ObterListaProdutos", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_CarregarLista="      + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 2)) + ;
                  CHR(13) + CHR(10) + "PROT_BtnOkClick="         + TRANSFORM(PEMSTATUS(loc_oForm, "BtnOkClick", 2)), loc_cOut, 1)

        STRTOFILE(CHR(13) + CHR(10) + "ValidarParametros()=" + TRANSFORM(loc_oForm.ValidarParametros()), loc_cOut, 1)

        *-- (5) ObterCelulaCodigo
        loc_oCel = loc_oForm.ObterCelulaCodigo()
        STRTOFILE(CHR(13) + CHR(10) + "ObterCelulaCodigo=" + VARTYPE(loc_oCel) + ;
                  " classe=" + IIF(VARTYPE(loc_oCel) = "O", loc_oCel.Class, "-"), loc_cOut, 1)

        *-- (9) BtnOkClick com a grade VAZIA tem de RECUSAR (legado: x=0)
        loc_oForm.BtnOkClick()
        STRTOFILE(CHR(13) + CHR(10) + "OK_gradeVazia_Retorno=[" + loc_oForm.ObterRetorno() + "]" + ;
                  " EmConfirmacao=" + TRANSFORM(loc_oForm.this_lEmConfirmacao), loc_cOut, 1)

        *-- (4) BOParaForm: produto do BO vai para o cursor e as 2 celulas
        loc_oForm.this_oBusinessObject.this_cCodigoProduto    = "12345"
        loc_oForm.this_oBusinessObject.this_cDescricaoProduto = "PRODUTO DE TESTE"
        STRTOFILE(CHR(13) + CHR(10) + "estado antes de BOParaForm: " + loc_oForm.ProbeEstadoCursor(), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "BOParaForm()=" + TRANSFORM(loc_oForm.ProbeBOParaForm()), loc_cOut, 1)
        *-- O cursor vive na datasession PRIVADA do form (DataSession = 2) e
        *-- NAO eh alcancavel da sessao 1 do probe - ler por dentro.
        STRTOFILE(CHR(13) + CHR(10) + "pos BOParaForm: " + loc_oForm.ProbeEstadoCursor() + ;
                  CHR(13) + CHR(10) + "celCodigo.Value=[" + ALLTRIM(loc_oCel.Value) + "]" + ;
                  " col2.Text1.Value=[" + ALLTRIM(loc_oGrd.Column2.Text1.Value) + "]", loc_cOut, 1)

        *-- (3) FormParaBO: linha corrente volta para o BO
        loc_oForm.this_oBusinessObject.this_cCodigoProduto    = "ZERADO"
        loc_oForm.this_oBusinessObject.this_cDescricaoProduto = "ZERADO"
        STRTOFILE(CHR(13) + CHR(10) + "FormParaBO()=" + TRANSFORM(loc_oForm.ProbeFormParaBO()), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "BO.Codigo=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cCodigoProduto) + "]" + ;
                  " BO.Descricao=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDescricaoProduto) + "]", loc_cOut, 1)

        *-- (6) HabilitarCampos
        loc_oForm.HabilitarCampos(.F.)
        STRTOFILE(CHR(13) + CHR(10) + "desligado grd=" + TRANSFORM(loc_oGrd.Enabled) + ;
                  " ok=" + TRANSFORM(loc_oForm.cmd_4c_Altera.Enabled) + ;
                  " cancela=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled), loc_cOut, 1)
        loc_oForm.HabilitarCampos(.T.)
        STRTOFILE(CHR(13) + CHR(10) + "religado grd=" + TRANSFORM(loc_oGrd.Enabled) + ;
                  " ok=" + TRANSFORM(loc_oForm.cmd_4c_Altera.Enabled) + ;
                  " cancela=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled), loc_cOut, 1)

        *-- (10) lista montada a partir da grade preenchida
        STRTOFILE(CHR(13) + CHR(10) + "TempoEspera=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_nTempoEspera), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "MontarLista_qtde=" + ;
                  TRANSFORM(loc_oForm.ProbeMontarLista()) + ;
                  " lista=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cListaProdutos) + "]", loc_cOut, 1)

        *-- (7) LimparCampos: ZAP sob DataSession=2 (se congelar, o probe nao
        *--     chega na linha seguinte e o arquivo fica truncado aqui)
        STRTOFILE(CHR(13) + CHR(10) + "antes LimparCampos: " + loc_oForm.ProbeEstadoCursor(), loc_cOut, 1)
        loc_oForm.ProbeLimparCampos()
        STRTOFILE(CHR(13) + CHR(10) + "LimparCampos VOLTOU - " + loc_oForm.ProbeEstadoCursor() + ;
                  " ColumnCount=" + TRANSFORM(loc_oGrd.ColumnCount) + ;
                  " RecordSource=[" + loc_oGrd.RecordSource + "]" + ;
                  " CS1=[" + loc_oGrd.Column1.ControlSource + "]" + ;
                  " W1=" + TRANSFORM(loc_oGrd.Column1.Width) + ;
                  " Fmt1=[" + loc_oGrd.Column1.Format + "]" + ;
                  " Col2RO=" + TRANSFORM(loc_oGrd.Column2.ReadOnly), loc_cOut, 1)

        *-- (8) contrato de retorno
        STRTOFILE(CHR(13) + CHR(10) + "Unload()=[" + loc_oForm.Unload() + "]" + ;
                  " ObterRetorno()=[" + loc_oForm.ObterRetorno() + "]" + ;
                  " ObterListaProdutos()=[" + loc_oForm.ObterListaProdutos() + "]", loc_cOut, 1)

        *-- Cancelar: contrato " " do legado + Destroy cacheando a lista
        loc_oForm.BtnCancelarClick()
        STRTOFILE(CHR(13) + CHR(10) + "pos-Cancelar VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)
        STRTOFILE(CHR(13) + CHR(10) + "pos-Cancelar Retorno=[" + loc_oForm.ObterRetorno() + "]" + ;
                  " ListaCacheada=[" + loc_oForm.ObterListaProdutos() + "]" + ;
                  " BO=" + VARTYPE(loc_oForm.this_oBusinessObject), loc_cOut, 1)

        loc_oForm.Release()

        *-- (11) FLUXO COMPLETO DO Ok, em instancia nova: produto na grade,
        *--      clique no Ok, e o chamador lendo o resultado depois - que
        *--      eh exatamente o que o form chamador da transmissao ECF faz.
        loc_oForm = CREATEOBJECT("FormTrfProbe_4c")
        loc_oForm.this_oBusinessObject.this_cCodigoProduto    = "7891234"
        loc_oForm.this_oBusinessObject.this_cDescricaoProduto = "CAMISA AZUL M"
        loc_oForm.ProbeBOParaForm()
        loc_oForm.BtnOkClick()
        STRTOFILE(CHR(13) + CHR(10) + "FLUXO_OK VARTYPE=" + VARTYPE(loc_oForm) + ;
                  " Retorno=[" + loc_oForm.ObterRetorno() + "]" + ;
                  " Lista=[" + loc_oForm.ObterListaProdutos() + "]" + ;
                  " EmConfirmacao=" + TRANSFORM(loc_oForm.this_lEmConfirmacao) + ;
                  " Unload=[" + loc_oForm.Unload() + "]", loc_cOut, 1)
        loc_oForm.Release()
        STRTOFILE(CHR(13) + CHR(10) + "apos Release do chamador VARTYPE=" + VARTYPE(loc_oForm), loc_cOut, 1)

        *-- (12) ANIMACAO DE VERDADE: em modo de teste o ClockEcfs nao eh
        *--      lido do banco e fica 0, o que PULA a animacao inteira.
        *--      Forcando 1 segundo, exercita o laco, o lockout de entrada
        *--      (HabilitarCampos(.F.)) e a religada no fim.
        loc_oForm = CREATEOBJECT("FormTrfProbe_4c")
        loc_oForm.this_oBusinessObject.this_nTempoEspera      = 1
        loc_oForm.this_oBusinessObject.this_cCodigoProduto    = "555"
        loc_oForm.this_oBusinessObject.this_cDescricaoProduto = "BERMUDA G"
        loc_oForm.ProbeBOParaForm()
        loc_oGrd = loc_oForm.cnt_4c__Referencia.grd_4c_Dados
        loc_nIni = SECONDS()
        loc_oForm.BtnOkClick()
        STRTOFILE(CHR(13) + CHR(10) + "ANIMACAO durou=" + TRANSFORM(ROUND(SECONDS() - loc_nIni, 1)) + "s" + ;
                  " Retorno=[" + loc_oForm.ObterRetorno() + "]" + ;
                  " Lista=[" + loc_oForm.ObterListaProdutos() + "]" + ;
                  CHR(13) + CHR(10) + "  pos-animacao EmConfirmacao=" + TRANSFORM(loc_oForm.this_lEmConfirmacao) + ;
                  " grd=" + TRANSFORM(loc_oGrd.Enabled) + ;
                  " ok=" + TRANSFORM(loc_oForm.cmd_4c_Altera.Enabled) + ;
                  " cancela=" + TRANSFORM(loc_oForm.cmd_4c_Sair.Enabled) + ;
                  " painelAguarde=" + TRANSFORM(loc_oForm.cnt_4c__Mensagem.Visible), loc_cOut, 1)
        loc_oForm.Release()

        STRTOFILE(CHR(13) + CHR(10) + "FIM_OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13) + CHR(10) + "FALHA: CREATEOBJECT nao devolveu objeto", loc_cOut, 1)
    ENDIF
CATCH TO loc_oErro
    STRTOFILE(CHR(13) + CHR(10) + "ERRO=" + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

*==============================================================================
* FormTrfProbe_4c - SUBCLASSE DE TESTE, exclusiva deste probe.
*
* FormParaBO, BOParaForm e LimparCampos sao PROTECTED no FormBase e, por
* heranca, continuam PROTECTED no FormSIGPRTRF (regra #51: o PROTECTED de
* qualquer classe da cadeia prevalece). Chamados de fora da classe eles
* estouram "Property BOPARAFORM is not found" - medido neste proprio probe
* antes desta subclasse existir.
*
* Uma SUBCLASSE, ao contrario, alcanca membro PROTECTED do pai. Os tres
* wrappers abaixo existem so para o probe poder exercitar os metodos reais;
* nenhuma linha disto entra no codigo de producao.
*==============================================================================
DEFINE CLASS FormTrfProbe_4c AS FormSIGPRTRF

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeLimparCampos()
        RETURN THIS.LimparCampos()
    ENDPROC

    *-- MontarListaProdutos tambem precisa rodar na sessao do form: o BO
    *-- varre o cursor da grade, que eh privado (DataSession = 2).
    PROCEDURE ProbeMontarLista()
        RETURN THIS.this_oBusinessObject.MontarListaProdutos(THIS.this_cCursorGrade)
    ENDPROC

    *-- Le o cursor da grade POR DENTRO do form: ele vive na datasession
    *-- PRIVADA (DataSession = 2) e um SELECT na sessao 1 do probe estoura
    *-- "Alias 'CURSOR_4C_PRODUTOS' is not found" - falha do PROBE, nao do
    *-- form. Devolve string para o probe so registrar.
    PROCEDURE ProbeEstadoCursor()
        LOCAL loc_cEstado

        IF !USED(THIS.this_cCursorGrade)
            RETURN "cursor AUSENTE"
        ENDIF

        SELECT (THIS.this_cCursorGrade)

        loc_cEstado = "reccount=" + TRANSFORM(RECCOUNT(THIS.this_cCursorGrade)) + ;
                      " recno=" + TRANSFORM(RECNO(THIS.this_cCursorGrade)) + ;
                      " eof=" + TRANSFORM(EOF(THIS.this_cCursorGrade)) + ;
                      " Cpros=[" + ALLTRIM(NVL(Cpros, "")) + "]" + ;
                      " Dpros=[" + ALLTRIM(NVL(Dpros, "")) + "]"

        RETURN loc_cEstado
    ENDPROC

ENDDEFINE
