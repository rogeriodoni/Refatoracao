*==============================================================================
* InstantiateCheckSigPrChrF8.prg - Verificacao da Fase 8 de FormSigPrChr
*
* Instancia o form e exercita os metodos de consolidacao da Fase 8:
*   CarregarLista / FormParaBO / BOParaForm / LimparCampos /
*   HabilitarCampos / AjustarBotoesPorModo / BtnCancelarClick
*
* Os hooks FormParaBO/BOParaForm/LimparCampos sao PROTECTED (herdados de
* FormBase, subclasse NAO alarga escopo) - por isso o teste usa uma SUBCLASSE
* sonda: em VFP9 metodo PROTECTED eh acessivel de dentro da subclasse.
*
* Execucao unattended: SET SAFETY OFF + SET RESOURCE OFF (pipeline noturno).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprchr_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro
loc_cRes = "FAIL"

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()

    loc_oForm = CREATEOBJECT("SondaSigPrChrF8")

    IF VARTYPE(loc_oForm) = "O"
        loc_cRes = "OK W=" + TRANSFORM(loc_oForm.Width) + " H=" + TRANSFORM(loc_oForm.Height)

        *-- 1) BOParaForm ja rodou no InicializarForm: periodo semeado do BO
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[1] BOParaForm(Init): DtIni=" + TRANSFORM(loc_oForm.txt_4c_Dt_inicial.Value) + ;
            " DtFim=" + TRANSFORM(loc_oForm.txt_4c_Dt_final.Value) + ;
            " Grupo=[" + TRANSFORM(loc_oForm.txt_4c_CdGrupos.Value) + "]" + ;
            " Conta=[" + TRANSFORM(loc_oForm.txt_4c_CdContas.Value) + "]"

        *-- 2) FormParaBO: tela -> BO (inclui descricoes e justificativa)
        loc_oForm.txt_4c_CdGrupos.Value = "01"
        loc_oForm.txt_4c_DsGrupos.Value = "GRUPO TESTE"
        loc_oForm.txt_4c_CdContas.Value = "123"
        loc_oForm.txt_4c_DsContas.Value = "CONTA TESTE"
        loc_oForm.txt_4c_Dt_inicial.Value = DATE() - 10
        loc_oForm.ProbeFormParaBO()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[2] FormParaBO: CodGrupo=[" + loc_oForm.this_oBusinessObject.this_cCodGrupo + "]" + ;
            " DescGrupo=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDescGrupo) + "]" + ;
            " CodConta=[" + loc_oForm.this_oBusinessObject.this_cCodConta + "]" + ;
            " DescConta=[" + ALLTRIM(loc_oForm.this_oBusinessObject.this_cDescConta) + "]" + ;
            " DtIniBO=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dDataInicial) + ;
            " AntDtIni(intocado)=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_dAntDataInicial)

        *-- 3) BOParaForm de volta (BO -> tela) apos mexer nas properties
        loc_oForm.this_oBusinessObject.this_cCodGrupo  = "99"
        loc_oForm.this_oBusinessObject.this_cDescGrupo = "OUTRO GRUPO"
        loc_oForm.ProbeBOParaForm()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[3] BOParaForm: Grupo=[" + loc_oForm.txt_4c_CdGrupos.Value + "]" + ;
            " DsGrupo=[" + ALLTRIM(loc_oForm.txt_4c_DsGrupos.Value) + "]"

        *-- 4) HabilitarCampos(.F.) / (.T.) - conjunto do cntProcurar.Init legado
        loc_oForm.HabilitarCampos(.F.)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[4a] HabilitarCampos(.F.): Conta=" + TRANSFORM(loc_oForm.txt_4c_CdContas.Enabled) + ;
            " Grd=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
            " CmdGok=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " | Grupo(intocado)=" + TRANSFORM(loc_oForm.txt_4c_CdGrupos.Enabled) + ;
            " DtIni(intocado)=" + TRANSFORM(loc_oForm.txt_4c_Dt_inicial.Enabled) + ;
            " Processar(intocado)=" + TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled)
        loc_oForm.HabilitarCampos(.T.)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[4b] HabilitarCampos(.T.): Conta=" + TRANSFORM(loc_oForm.txt_4c_CdContas.Enabled) + ;
            " Grd=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
            " CmdGok=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled)

        *-- 5) AjustarBotoesPorModo - os 4 modos + volta a LISTA
        loc_oForm.AjustarBotoesPorModo("PROCURAR")
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[5a] Modo PROCURAR: modo=" + loc_oForm.this_cModoAtual + ;
            " PainelVis=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Visible) + ;
            " CmdGok=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " Grd=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled)

        loc_oForm.AjustarBotoesPorModo("LISTA")
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[5b] Modo LISTA: modo=" + loc_oForm.this_cModoAtual + ;
            " PainelVis=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Visible) + ;
            " CmdGok=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " Grd=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled) + ;
            " Conta=" + TRANSFORM(loc_oForm.txt_4c_CdContas.Enabled)

        loc_oForm.AjustarBotoesPorModo("IMPCHMAT")
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[5c] Modo IMPCHMAT: modo=" + loc_oForm.this_cModoAtual + ;
            " PainelVis=" + TRANSFORM(loc_oForm.cnt_4c_Impchmat.Visible) + ;
            " CmdGok=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " Grd(intocado)=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled)

        *-- 6) BtnCancelarClick SEM parametro: detecta o painel aberto (IMPCHMAT)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[6a] BtnCancelarClick() s/param -> fechou=" + TRANSFORM(loc_oForm.BtnCancelarClick()) + ;
            " ImpVis=" + TRANSFORM(loc_oForm.cnt_4c_Impchmat.Visible) + ;
            " CmdGok=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " modo=" + loc_oForm.this_cModoAtual

        *-- Sem painel aberto: nao ha o que cancelar (e NAO fecha o form)
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[6b] BtnCancelarClick() sem painel -> fechou=" + TRANSFORM(loc_oForm.BtnCancelarClick()) + ;
            " FormVis=" + TRANSFORM(loc_oForm.Visible)

        *-- 6c) BtnCancelarClick("PROCURAR") explicito
        loc_oForm.BtnProcurarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[6c] BtnProcurarClick: Vis=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Visible) + ;
            " modo=" + loc_oForm.this_cModoAtual + ;
            " -> BtnCancelarClick(PROCURAR)=" + TRANSFORM(loc_oForm.BtnCancelarClick("PROCURAR")) + ;
            " Vis=" + TRANSFORM(loc_oForm.cnt_4c_Procurar.Visible) + ;
            " CmdGok=" + TRANSFORM(loc_oForm.obj_4c_CmdGok.Enabled) + ;
            " Grd=" + TRANSFORM(loc_oForm.grd_4c_Dados.Enabled)

        *-- 7) CarregarLista: sem rota para o SQL Server nesta maquina a
        *-- consulta falha e o retorno tem de ser .F. SEM derrubar o form
        *-- (a mensagem vai para o arquivo de dialogos em modo teste).
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[7] CarregarLista(.F.)=" + TRANSFORM(loc_oForm.CarregarLista(.F.)) + ;
            " CursorCheques=" + TRANSFORM(USED("cursor_4c_Cheques")) + ;
            " Reccount=" + TRANSFORM(IIF(USED("cursor_4c_Cheques"), RECCOUNT("cursor_4c_Cheques"), -1))

        *-- 8) LimparCampos: volta ao estado do Init legado
        loc_oForm.ProbeLimparCampos()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[8] LimparCampos: Grupo=[" + loc_oForm.txt_4c_CdGrupos.Value + "]" + ;
            " DsGrupo=[" + ALLTRIM(loc_oForm.txt_4c_DsGrupos.Value) + "]" + ;
            " Conta=[" + loc_oForm.txt_4c_CdContas.Value + "]" + ;
            " DtIni=" + TRANSFORM(loc_oForm.txt_4c_Dt_inicial.Value) + ;
            " Favorecido=[" + ALLTRIM(loc_oForm.txt_4c_TxtFavorecido.Value) + "]" + ;
            " Just=[" + ALLTRIM(loc_oForm.cnt_4c_justificativa.obj_4c_Get_justificativa.Value) + "]" + ;
            " ProcBanco=[" + loc_oForm.cnt_4c_Procurar.txt_4c_Banco.Value + "]" + ;
            " ImpBanco=[" + loc_oForm.cnt_4c_Impchmat.txt_4c_Banco.Value + "]" + ;
            " PrimeiraExib=" + TRANSFORM(loc_oForm.this_oBusinessObject.this_lPrimeiraExibicao) + ;
            " Reccount=" + TRANSFORM(IIF(USED("cursor_4c_Cheques"), RECCOUNT("cursor_4c_Cheques"), -1))

        *-- 9) BtnProcessarClick pelo caminho real (valida periodo + funil)
        loc_oForm.txt_4c_Dt_inicial.Value = DATE() + 5
        loc_oForm.txt_4c_Dt_final.Value   = DATE()
        loc_oForm.BtnProcessarClick()
        loc_cRes = loc_cRes + CHR(13) + CHR(10) + ;
            "[9] BtnProcessarClick(periodo invertido): form vivo=" + TRANSFORM(VARTYPE(loc_oForm) = "O")

        loc_oForm.Release()
    ELSE
        loc_cRes = "FAIL VARTYPE=" + VARTYPE(loc_oForm)
    ENDIF
CATCH TO loc_oErro
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "EXCEPTION: " + loc_oErro.Message + ;
               " Linha:" + TRANSFORM(loc_oErro.LineNo) + " Proc:" + loc_oErro.Procedure
ENDTRY

IF FILE("C:\4c\automation\vfp_error_sigprchr_f8.txt")
    loc_cRes = loc_cRes + CHR(13) + CHR(10) + "DIALOGOS: " + ;
        FILETOSTR("C:\4c\automation\vfp_error_sigprchr_f8.txt")
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprchr_f8_result.txt")
QUIT

*==============================================================================
* SondaSigPrChrF8 - subclasse SO para teste: expoe os hooks PROTECTED
* herdados de FormBase (FormParaBO/BOParaForm/LimparCampos). Em VFP9 metodo
* PROTECTED eh acessivel de dentro da subclasse - HIDDEN nao seria.
*==============================================================================
DEFINE CLASS SondaSigPrChrF8 AS FormSigPrChr

    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC

    PROCEDURE ProbeBOParaForm()
        RETURN THIS.BOParaForm()
    ENDPROC

    PROCEDURE ProbeLimparCampos()
        RETURN THIS.LimparCampos()
    ENDPROC

ENDDEFINE
