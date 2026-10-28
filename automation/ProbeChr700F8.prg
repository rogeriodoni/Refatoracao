*==============================================================================
* ProbeChr700F8.prg - Instancia FormSIGOPCHR headless (Fase 8 / task700) e
* exercita o que a fase acrescentou:
*   (1) o form AINDA ABRE depois de InicializarForm passar a chamar
*       LimparCampos() + AjustarBotoesPorModo();
*   (2) os defaults do Init legado (Oper vazio, Date()-30 .. Date(), Tipo=1,
*       Grupo/Conta vazios, ImpNConta desmarcado);
*   (3) AtualizarEstadoCampos reproduz os DOIS When do SCX
*       (getDGrupo/getDConta so editaveis com o codigo correspondente vazio);
*   (4) FormParaBO -> properties do BO, e BOParaForm de volta (round-trip);
*   (5) HabilitarCampos(.F./.T.) e BtnCancelarClick;
*   (6) escopo dos metodos (os chamados de fora tem de ser PUBLIC - regra #3).
* NAO chama ConfigurarAmbiente() (nao retorna nesta maquina) e NAO dispara
* lookup nenhum: todo picker eh MODAL e travaria o script.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_chr700_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cOut, loc_oForm, loc_oPg, loc_oErro
loc_cOut = "C:\4c\automation\probe_chr700_f8_result.txt"
STRTOFILE("INICIO", loc_cOut)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    gb_4c_ModoTeste   = .T.
    gb_4c_ValidandoUI = .T.

    SET PATH TO (gcCaminhoBase + "," + gcCaminhoClasses + "," + gcCaminhoUtils + ;
                 "," + gcCaminhoForms + "," + gcCaminhoIcones)
    SET PROCEDURE TO (gcCaminhoClasses + "dataaccess.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "businessbase.prg")      ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "relatoriobase.prg")     ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "formbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "gridbase.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormErro.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "FormBuscaAuxiliar.prg") ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "functions.prg")         ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "messages.prg")          ADDITIVE
    SET PROCEDURE TO (gcCaminhoUtils   + "validators.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoClasses + "SIGOPCHRBO.prg")        ADDITIVE
    SET PROCEDURE TO (gcCaminhoForms + "relatorios\FormSIGOPCHR.prg") ADDITIVE
    STRTOFILE(CHR(13)+CHR(10)+"deps OK", loc_cOut, 1)

    *-- (1) O form ainda ABRE? Esta eh a prova que a Fase 8 precisa: as duas
    *   chamadas novas no InicializarForm rodam ANTES do loc_lSucesso = .T.,
    *   logo um erro nelas faria CREATEOBJECT devolver .F. (tipo L).
    loc_oForm = CREATEOBJECT("FormSIGOPCHR_Probe")
    STRTOFILE(CHR(13)+CHR(10)+"CREATEOBJECT=" + VARTYPE(loc_oForm), loc_cOut, 1)

    IF VARTYPE(loc_oForm) = "O"
        loc_oPg = loc_oForm.pgf_4c_Paginas.Page1

        *-- (2) Defaults do Init legado, repostos por LimparCampos
        STRTOFILE(CHR(13)+CHR(10)+"DEFAULTS Oper=[" + ALLTRIM(loc_oPg.txt_4c_Oper.Value) + "]" + ;
                  " DataI=" + DTOC(loc_oPg.txt_4c_DataI.Value) + ;
                  " DataIok=" + TRANSFORM(loc_oPg.txt_4c_DataI.Value = DATE() - 30) + ;
                  " DataF=" + DTOC(loc_oPg.txt_4c_DataF.Value) + ;
                  " DataFok=" + TRANSFORM(loc_oPg.txt_4c_DataF.Value = DATE()) + ;
                  " Tipo=" + TRANSFORM(loc_oPg.obj_4c_GetTipo.Value) + ;
                  " Grupo=[" + ALLTRIM(loc_oPg.txt_4c_Grupo.Value) + "]" + ;
                  " Conta=[" + ALLTRIM(loc_oPg.txt_4c_Conta.Value) + "]" + ;
                  " ImpNConta=" + TRANSFORM(loc_oPg.chk_4c_ImpNConta.Value) + ;
                  " TipoDataI=" + VARTYPE(loc_oPg.txt_4c_DataI.Value), loc_cOut, 1)

        *-- (3) Os DOIS When do legado, via AtualizarEstadoCampos.
        *   Codigo VAZIO -> descricao EDITAVEL (ReadOnly = .F.)
        STRTOFILE(CHR(13)+CHR(10)+"WHEN vazio DGrupoRO=" + TRANSFORM(loc_oPg.txt_4c_DGrupo.ReadOnly) + ;
                  " DContaRO=" + TRANSFORM(loc_oPg.txt_4c_DConta.ReadOnly), loc_cOut, 1)

        *   Codigo PREENCHIDO -> descricao TRAVADA (ReadOnly = .T.)
        loc_oPg.txt_4c_Grupo.Value = "01"
        loc_oPg.txt_4c_Conta.Value = "11101"
        loc_oForm.AtualizarEstadoCampos()
        STRTOFILE(CHR(13)+CHR(10)+"WHEN cheio DGrupoRO=" + TRANSFORM(loc_oPg.txt_4c_DGrupo.ReadOnly) + ;
                  " DContaRO=" + TRANSFORM(loc_oPg.txt_4c_DConta.ReadOnly), loc_cOut, 1)

        *   Codigo de CODIGO nunca travado (o legado nao tem When neles)
        STRTOFILE(CHR(13)+CHR(10)+"CODIGOS GrupoRO=" + TRANSFORM(loc_oPg.txt_4c_Grupo.ReadOnly) + ;
                  " ContaRO=" + TRANSFORM(loc_oPg.txt_4c_Conta.ReadOnly) + ;
                  " OperRO=" + TRANSFORM(loc_oPg.txt_4c_Oper.ReadOnly), loc_cOut, 1)

        *-- (4) FormParaBO: os filtros da tela tem de chegar ao BO
        loc_oPg.txt_4c_Oper.Value         = "VENDA"
        loc_oPg.txt_4c_DGrupo.Value       = "DESC GRUPO"
        loc_oPg.txt_4c_DConta.Value       = "DESC CONTA"
        loc_oPg.obj_4c_GetTipo.Value      = 2
        loc_oPg.chk_4c_ImpNConta.Value    = 1
        loc_oPg.txt_4c_DataI.Value        = DATE() - 10
        loc_oForm.ExpoeFormParaBO()
        STRTOFILE(CHR(13)+CHR(10)+"FORMPARABO Oper=[" + ALLTRIM(loc_oForm.this_oRelatorio.this_cOperacao) + "]" + ;
                  " Grupo=[" + ALLTRIM(loc_oForm.this_oRelatorio.this_cGrupo) + "]" + ;
                  " Conta=[" + ALLTRIM(loc_oForm.this_oRelatorio.this_cConta) + "]" + ;
                  " DescGrupo=[" + ALLTRIM(loc_oForm.this_oRelatorio.this_cDescGrupo) + "]" + ;
                  " Tipo=" + TRANSFORM(loc_oForm.this_oRelatorio.this_nTipo) + ;
                  " ImpNConta=" + TRANSFORM(loc_oForm.this_oRelatorio.this_lImpNConta) + ;
                  " TipoImp=" + VARTYPE(loc_oForm.this_oRelatorio.this_lImpNConta) + ;
                  " DataI=" + DTOC(loc_oForm.this_oRelatorio.this_dDataInicial), loc_cOut, 1)

        *-- (4b) BOParaForm: zera a tela e repoe a partir do BO (round-trip)
        loc_oPg.txt_4c_Oper.Value      = "LIXO"
        loc_oPg.txt_4c_Grupo.Value     = "ZZ"
        loc_oPg.obj_4c_GetTipo.Value   = 1
        loc_oPg.chk_4c_ImpNConta.Value = 0
        loc_oPg.txt_4c_DataI.Value     = {}
        loc_oForm.ExpoeBOParaForm()
        STRTOFILE(CHR(13)+CHR(10)+"BOPARAFORM Oper=[" + ALLTRIM(loc_oPg.txt_4c_Oper.Value) + "]" + ;
                  " Grupo=[" + ALLTRIM(loc_oPg.txt_4c_Grupo.Value) + "]" + ;
                  " Tipo=" + TRANSFORM(loc_oPg.obj_4c_GetTipo.Value) + ;
                  " ImpNConta=" + TRANSFORM(loc_oPg.chk_4c_ImpNConta.Value) + ;
                  " DataI=" + DTOC(loc_oPg.txt_4c_DataI.Value) + ;
                  " DataIok=" + TRANSFORM(loc_oPg.txt_4c_DataI.Value = DATE() - 10) + ;
                  " TipoDataI=" + VARTYPE(loc_oPg.txt_4c_DataI.Value) + ;
                  " DGrupoRO=" + TRANSFORM(loc_oPg.txt_4c_DGrupo.ReadOnly), loc_cOut, 1)

        *-- (5a) HabilitarCampos(.F.) trava TUDO; (.T.) devolve o refinamento
        loc_oForm.HabilitarCampos(.F.)
        STRTOFILE(CHR(13)+CHR(10)+"HAB .F. OperRO=" + TRANSFORM(loc_oPg.txt_4c_Oper.ReadOnly) + ;
                  " DataIRO=" + TRANSFORM(loc_oPg.txt_4c_DataI.ReadOnly) + ;
                  " TipoEnab=" + TRANSFORM(loc_oPg.obj_4c_GetTipo.Enabled) + ;
                  " ChkEnab=" + TRANSFORM(loc_oPg.chk_4c_ImpNConta.Enabled), loc_cOut, 1)

        loc_oForm.HabilitarCampos(.T.)
        STRTOFILE(CHR(13)+CHR(10)+"HAB .T. OperRO=" + TRANSFORM(loc_oPg.txt_4c_Oper.ReadOnly) + ;
                  " DataIRO=" + TRANSFORM(loc_oPg.txt_4c_DataI.ReadOnly) + ;
                  " TipoEnab=" + TRANSFORM(loc_oPg.obj_4c_GetTipo.Enabled) + ;
                  " DGrupoRO_refinado=" + TRANSFORM(loc_oPg.txt_4c_DGrupo.ReadOnly), loc_cOut, 1)

        *-- (5b) BtnCancelarClick volta a tela aos defaults, SEM fechar
        loc_oForm.BtnCancelarClick()
        STRTOFILE(CHR(13)+CHR(10)+"CANCELAR Oper=[" + ALLTRIM(loc_oPg.txt_4c_Oper.Value) + "]" + ;
                  " Grupo=[" + ALLTRIM(loc_oPg.txt_4c_Grupo.Value) + "]" + ;
                  " Tipo=" + TRANSFORM(loc_oPg.obj_4c_GetTipo.Value) + ;
                  " ImpNConta=" + TRANSFORM(loc_oPg.chk_4c_ImpNConta.Value) + ;
                  " DataIok=" + TRANSFORM(loc_oPg.txt_4c_DataI.Value = DATE() - 30) + ;
                  " FormVivo=" + VARTYPE(loc_oForm), loc_cOut, 1)

        *-- (5c) CarregarLista eh contrato: devolve .T. sem lista a carregar
        STRTOFILE(CHR(13)+CHR(10)+"CARREGARLISTA=" + TRANSFORM(loc_oForm.CarregarLista()), loc_cOut, 1)

        *-- (5d) AjustarBotoesPorModo: os 4 botoes seguem habilitados
        loc_oForm.AjustarBotoesPorModo()
        STRTOFILE(CHR(13)+CHR(10)+"BOTOES b1=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(1).Enabled) + ;
                  " b2=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(2).Enabled) + ;
                  " b3=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(3).Enabled) + ;
                  " b4=" + TRANSFORM(loc_oForm.cmg_4c_Botoes.Buttons(4).Enabled), loc_cOut, 1)

        *-- (6) Escopo (atributo 2 = PROTECTED). Tudo que o pipeline/harness
        *   chama de FORA da classe tem de dar .F. aqui (regra #3).
        STRTOFILE(CHR(13)+CHR(10)+"ESCOPO CarregarLista prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"CarregarLista",2)) + ;
                  " FormParaBO prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"FormParaBO",2)) + ;
                  " BOParaForm prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BOParaForm",2)) + ;
                  " BtnCancelarClick prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnCancelarClick",2)) + ;
                  " BtnSalvarClick prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnSalvarClick",2)) + ;
                  " BtnBuscarClick prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"BtnBuscarClick",2)) + ;
                  " LimparCampos prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"LimparCampos",2)) + ;
                  " HabilitarCampos prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"HabilitarCampos",2)) + ;
                  " AjustarBotoes prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AjustarBotoesPorModo",2)) + ;
                  " AlternarPagina prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AlternarPagina",2)) + ;
                  " AtualizarEstado prot=" + TRANSFORM(PEMSTATUS(loc_oForm,"AtualizarEstadoCampos",2)), loc_cOut, 1)

        loc_oForm.Release()
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=OK", loc_cOut, 1)
    ELSE
        STRTOFILE(CHR(13)+CHR(10)+"RESULTADO=FALHA_CREATEOBJECT", loc_cOut, 1)
    ENDIF

CATCH TO loc_oErro
    STRTOFILE(CHR(13)+CHR(10)+"EXCECAO: " + loc_oErro.Message + ;
              " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
              " PROC=" + loc_oErro.Procedure, loc_cOut, 1)
ENDTRY

QUIT

*==============================================================================
* FormSIGOPCHR_Probe - subclasse SO de teste.
* FormParaBO/BOParaForm/LimparCampos sao PROTECTED (declarados assim na
* FormBase), portanto nao podem ser chamados de fora da classe. A tecnica
* canonica para medi-los eh uma subclasse que os exponha por wrapper PUBLIC
* (mesma abordagem indicada na regra #51 do CLAUDE.md). O form de producao
* NAO ganha metodo nenhum por causa do teste.
*==============================================================================
DEFINE CLASS FormSIGOPCHR_Probe AS FormSIGOPCHR

    PROCEDURE ExpoeFormParaBO()
        THIS.FormParaBO()
    ENDPROC

    PROCEDURE ExpoeBOParaForm()
        THIS.BOParaForm()
    ENDPROC

    PROCEDURE ExpoeLimparCampos()
        THIS.LimparCampos()
    ENDPROC

ENDDEFINE
