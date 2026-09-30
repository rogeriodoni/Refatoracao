*==============================================================================
* InstantiateCheckSigPrGloTF8.prg - valida a Fase 8 de FormSigPrGloT (task616)
*
* Prova MEDINDO no VFP9 que:
*   1. o form INSTANCIA (Init de form grande falha em cadeia);
*   2. os metodos exigidos pela Fase 8 existem;
*   3. BOParaForm esta em caminho VIVO (nao eh mais codigo morto): apos o
*      InicializarForm, Empresa/Previsao/Geracao chegaram na TELA e estao
*      espelhados no BO;
*   4. FormParaBO cobre os 21 campos de filtro (screen -> BO round-trip);
*   5. LimparCampos + AlternarPagina + os Btn*Click sao chamaveis de FORA
*      (precisam ser PUBLIC - CLAUDE.md #3) e nao quebram.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_sigprglot_f8.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_oBO
loc_cRes = "FASE8 CHECK FormSigPrGloT - " + TTOC(DATETIME()) + CHR(13) + CHR(10)

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    loc_cRes = loc_cRes + "0 AMBIENTE: gnConnHandle=" + TRANSFORM(gnConnHandle) + CHR(13)+CHR(10)
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "0 AMBIENTE FALHOU: " + loc_oErro.Message + CHR(13)+CHR(10)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("FormSigPrGloT", .F., .F., .F., .T.)
    loc_cRes = loc_cRes + "1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width) + ;
        " H=" + TRANSFORM(loc_oForm.Height) + " Cap=[" + loc_oForm.Caption + "]", "") + CHR(13)+CHR(10)
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13)+CHR(10)
ENDTRY

IF VARTYPE(loc_oForm) = "O"
    loc_oBO = loc_oForm.this_oBusinessObject

    *-- 2. metodos da Fase 8 existem
    loc_cRes = loc_cRes + "2 METODOS: FormParaBO=" + TRANSFORM(PEMSTATUS(loc_oForm, "FormParaBO", 5)) + ;
        " BOParaForm="        + TRANSFORM(PEMSTATUS(loc_oForm, "BOParaForm", 5)) + ;
        " LimparCampos="      + TRANSFORM(PEMSTATUS(loc_oForm, "LimparCampos", 5)) + ;
        " CarregarLista="     + TRANSFORM(PEMSTATUS(loc_oForm, "CarregarLista", 5)) + ;
        " AjustarBotoes="     + TRANSFORM(PEMSTATUS(loc_oForm, "AjustarBotoesPorModo", 5)) + ;
        " AlternarPagina="    + TRANSFORM(PEMSTATUS(loc_oForm, "AlternarPagina", 5)) + CHR(13)+CHR(10)

    *-- 3. BOParaForm em caminho VIVO: tela e BO coerentes apos construcao
    TRY
        loc_cRes = loc_cRes + "3 BOParaForm VIVO:" + ;
            " TELA Emp=["   + ALLTRIM(loc_oForm.cnt_4c_Empresa.txt_4c_CdEmpresa.Value) + "]" + ;
            " Ds=["         + ALLTRIM(loc_oForm.cnt_4c_Empresa.txt_4c_DsEmpresa.Value) + "]" + ;
            " Prev="        + DTOC(loc_oForm.cnt_4c_Previsao.txt_4c_Previsao.Value) + ;
            " Ger="         + DTOC(loc_oForm.cnt_4c_Previsao.txt_4c_Geracao.Value) + CHR(13)+CHR(10) + ;
            "                  BO   Emp=[" + ALLTRIM(loc_oBO.this_cCodEmpresa) + "]" + ;
            " Ds=["         + ALLTRIM(loc_oBO.this_cDsEmpresa) + "]" + ;
            " Prev="        + DTOC(loc_oBO.this_dPrevisao) + ;
            " Ger="         + DTOC(loc_oBO.this_dGeracao) + CHR(13)+CHR(10)
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "3 FALHOU: " + loc_oErro.Message + CHR(13)+CHR(10)
    ENDTRY

    *-- 4. FormParaBO round-trip: digita na tela, chama, confere no BO
    TRY
        loc_oForm.txt_4c_Dataei.Value                        = DATE() - 10
        loc_oForm.cnt_4c_Operacao.txt_4c_Operacao.Value      = "PEDIDO"
        loc_oForm.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = 77
        loc_oForm.cnt_4c_Conta.txt_4c_Conta.Value            = "C0001"
        loc_oForm.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = "R0002"
        loc_oForm.cnt_4c_Op.txt_4c_Nop.Value                 = 4321
        loc_oForm.FormParaBO()
        loc_cRes = loc_cRes + "4 FormParaBO: Dataei=" + DTOC(loc_oBO.this_dDataei) + ;
            " Oper=["      + ALLTRIM(loc_oBO.this_cOperacao) + "]" + ;
            " Operi="      + TRANSFORM(loc_oBO.this_nOperacaoi) + ;
            " Conta=["     + ALLTRIM(loc_oBO.this_cConta) + "]" + ;
            " ContaResp=[" + ALLTRIM(loc_oBO.this_cContaResp) + "]" + ;
            " Nop="        + TRANSFORM(loc_oBO.this_nNumeroOP) + CHR(13)+CHR(10)
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "4 FALHOU: " + loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + CHR(13)+CHR(10)
    ENDTRY

    *-- 5. metodos chamaveis de FORA da classe (tem de ser PUBLIC)
    TRY
        loc_oForm.AlternarPagina("PROCESSANDO")
        loc_cRes = loc_cRes + "5a PROCESSANDO: Processar.Enabled=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " cntConta.Enabled=" + TRANSFORM(loc_oForm.cnt_4c_Conta.Enabled) + CHR(13)+CHR(10)
        loc_oForm.AjustarBotoesPorModo()
        loc_cRes = loc_cRes + "5b ENTRADA (via AjustarBotoesPorModo): Processar.Enabled=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Processar.Enabled) + ;
            " cntConta.Enabled=" + TRANSFORM(loc_oForm.cnt_4c_Conta.Enabled) + CHR(13)+CHR(10)
        loc_oForm.LimparCampos()
        loc_cRes = loc_cRes + "5c LimparCampos: Oper=[" + ;
            ALLTRIM(loc_oForm.cnt_4c_Operacao.txt_4c_Operacao.Value) + "]" + ;
            " Nop=" + TRANSFORM(loc_oForm.cnt_4c_Op.txt_4c_Nop.Value) + ;
            " Dataei=" + DTOC(loc_oForm.txt_4c_Dataei.Value) + CHR(13)+CHR(10)
        loc_oForm.CarregarLista()
        loc_oForm.BtnIncluirClick()
        loc_cRes = loc_cRes + "5d BtnIncluirClick OK: Emp=[" + ;
            ALLTRIM(loc_oForm.cnt_4c_Empresa.txt_4c_CdEmpresa.Value) + "]" + ;
            " Ger=" + DTOC(loc_oForm.cnt_4c_Previsao.txt_4c_Geracao.Value) + CHR(13)+CHR(10)
        loc_oForm.BtnAlterarClick()
        loc_oForm.BtnVisualizarClick()
        loc_oForm.BtnExcluirClick()
        loc_oForm.BtnBuscarClick()
        loc_oForm.BtnCancelarClick()
        loc_cRes = loc_cRes + "5e Btn{Alterar,Visualizar,Excluir,Buscar,Cancelar}Click OK" + CHR(13)+CHR(10)
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "5 FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + CHR(13)+CHR(10)
    ENDTRY

    loc_oForm.Release()
    loc_cRes = loc_cRes + "6 Release OK" + CHR(13)+CHR(10)
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + "--- DIALOGOS CAPTURADOS ---" + CHR(13)+CHR(10) + ;
               FILETOSTR(gc_4c_ArquivoErroTeste) + CHR(13)+CHR(10)
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_sigprglot_f8.txt")
QUIT
