*==============================================================================
* InstantiateCheckCccF8.prg - valida a Fase 8 de FormSigPrCcc
*
* Prova, MEDINDO no VFP9 (nao por leitura de codigo):
*   1. o form ainda INSTANCIA depois das mudancas da fase;
*   2. o BINDEVENT dos dois botoes aponta para os handlers RENOMEADOS
*      (BtnProcessarClick / BtnCancelarClick) - rename que nao atualizasse o
*      BINDEVENT deixaria os dois botoes mudos sem erro nenhum;
*   3. Get_Registro.When -> txt_4c_Registro ReadOnly + TabStop=.F. e
*      AtualizarContadorRegistros AINDA consegue escrever nele;
*   4. Get_Descs.When nos TRES containers, nos TRES estados;
*   5. BtnProcessarClick destrava a tela mesmo com o processamento falhando
*      (regra #40), e BtnCancelarClick eh chamavel de fora (PUBLIC).
*
* Cada passo eh GRAVADO EM DISCO assim que termina (LogPasso -> STRTOFILE
* ADDITIVE): se o processo travar ou for morto, o log mostra exatamente onde
* parou - sem isso, um hang deixa arquivo nenhum e o diagnostico vira palpite.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste, gc_4c_LogPassoF8
gb_4c_ModoTeste        = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_cccf8.txt"
gc_4c_LogPassoF8       = "C:\4c\automation\instantiate_cccf8_result.txt"

IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF
IF FILE(gc_4c_LogPassoF8)
    DELETE FILE (gc_4c_LogPassoF8)
ENDIF

LOCAL loc_oForm, loc_oErro
LogPasso("v2 FASE8 CHECK - inicio " + TTOC(DATETIME()))

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
    LogPasso("0 AMBIENTE: OK (gnConnHandle=" + TRANSFORM(gnConnHandle) + ")")
CATCH TO loc_oErro
    LogPasso("0 AMBIENTE FALHOU: " + loc_oErro.Message)
ENDTRY

TRY
    loc_oForm = CREATEOBJECT("ProbeSigPrCccF8")
    LogPasso("1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width), ""))
CATCH TO loc_oErro
    LogPasso("1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 2. BINDEVENT dos dois botoes (nome NOVO)
    TRY
        LOCAL ARRAY loc_aEv[1, 5]
        LOCAL loc_nEv, loc_nI, loc_cAch
        loc_nEv  = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Processa)
        loc_cAch = ""
        FOR loc_nI = 1 TO loc_nEv
            loc_cAch = loc_cAch + ALLTRIM(loc_aEv[loc_nI, 3]) + "->" + ALLTRIM(loc_aEv[loc_nI, 4]) + " "
        ENDFOR
        LogPasso("2a BINDEVENT cmd_4c_Processa: n=" + TRANSFORM(loc_nEv) + " [" + loc_cAch + "]")

        loc_nEv  = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Cancela)
        loc_cAch = ""
        FOR loc_nI = 1 TO loc_nEv
            loc_cAch = loc_cAch + ALLTRIM(loc_aEv[loc_nI, 3]) + "->" + ALLTRIM(loc_aEv[loc_nI, 4]) + " "
        ENDFOR
        LogPasso("2b BINDEVENT cmd_4c_Cancela: n=" + TRANSFORM(loc_nEv) + " [" + loc_cAch + "]")
    CATCH TO loc_oErro
        LogPasso("2 BINDEVENT FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 3. txt_4c_Registro somente-leitura, mas escrevivel por codigo
    TRY
        LogPasso("3 txt_4c_Registro: ReadOnly=" + TRANSFORM(loc_oForm.txt_4c_Registro.ReadOnly) + ;
            " TabStop=" + TRANSFORM(loc_oForm.txt_4c_Registro.TabStop) + ;
            " Enabled=" + TRANSFORM(loc_oForm.txt_4c_Registro.Enabled))
        loc_oForm.AtualizarContadorRegistros(4321)
        LogPasso("3b AtualizarContadorRegistros(4321) -> Value=" + ;
            TRANSFORM(loc_oForm.txt_4c_Registro.Value))
    CATCH TO loc_oErro
        LogPasso("3 FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 4. Get_Descs.When nos TRES containers, nos TRES estados
    LOCAL loc_nC, loc_oCnt, loc_cNome
    LOCAL ARRAY loc_aCnt[3]
    loc_aCnt[1] = "cnt_4c_OpEstoque"
    loc_aCnt[2] = "cnt_4c_OpCusto"
    loc_aCnt[3] = "cnt_4c_OpCompra"
    LogPasso("4 When do Get_Descs (Descricao so digitavel com Produto vazio):")
    FOR loc_nC = 1 TO 3
        loc_cNome = loc_aCnt[loc_nC]
        TRY
            loc_oCnt = EVALUATE("loc_oForm." + loc_cNome)

            loc_oCnt.txt_4c_Produto.Value = ""
            loc_oForm.ProbeWhenDescricao(loc_oCnt)
            LogPasso("   " + PADR(loc_cNome, 18) + " Produto vazio         -> Desc.ReadOnly=" + ;
                TRANSFORM(loc_oCnt.txt_4c_Descricao.ReadOnly) + ;
                " TabStop=" + TRANSFORM(loc_oCnt.txt_4c_Descricao.TabStop))

            loc_oCnt.txt_4c_Produto.Value = "PRO123"
            loc_oForm.ProbeWhenDescricao(loc_oCnt)
            LogPasso("   " + PADR(loc_cNome, 18) + " Produto PRO123        -> Desc.ReadOnly=" + ;
                TRANSFORM(loc_oCnt.txt_4c_Descricao.ReadOnly) + ;
                " TabStop=" + TRANSFORM(loc_oCnt.txt_4c_Descricao.TabStop))

            loc_oCnt.txt_4c_Produto.Value = ""
            loc_oForm.ProbeWhenDescricao(loc_oCnt)
            LogPasso("   " + PADR(loc_cNome, 18) + " Produto limpo (volta) -> Desc.ReadOnly=" + ;
                TRANSFORM(loc_oCnt.txt_4c_Descricao.ReadOnly) + ;
                " TabStop=" + TRANSFORM(loc_oCnt.txt_4c_Descricao.TabStop))
        CATCH TO loc_oErro
            LogPasso("   " + loc_cNome + " FALHOU: " + loc_oErro.Message)
        ENDTRY
    ENDFOR

    *-- 4b. handlers PUBLIC de InteractiveChange chamados de FORA (como o
    *-- BINDEVENT faz) - PROTECTED falharia aqui mesmo com PEMSTATUS = .T.
    TRY
        loc_oForm.cnt_4c_OpCusto.txt_4c_Produto.Value = "XPTO"
        loc_oForm.ProdutoCustoInteractiveChange()
        LogPasso("4b ProdutoCustoInteractiveChange de FORA: OK Desc.ReadOnly=" + ;
            TRANSFORM(loc_oForm.cnt_4c_OpCusto.txt_4c_Descricao.ReadOnly))
        loc_oForm.cnt_4c_OpEstoque.txt_4c_Produto.Value = ""
        loc_oForm.ProdutoEstoqueInteractiveChange()
        loc_oForm.cnt_4c_OpCompra.txt_4c_Produto.Value = ""
        loc_oForm.ProdutoCompraInteractiveChange()
        LogPasso("4c Estoque/Compra InteractiveChange de FORA: OK")
    CATCH TO loc_oErro
        LogPasso("4b FALHOU: " + loc_oErro.Message)
    ENDTRY

    *-- 5. BtnProcessarClick destrava a tela mesmo falhando (regra #40)
    TRY
        loc_oForm.chk_4c_Conta.Value = 1
        loc_oForm.BtnProcessarClick()
        LogPasso("5 POS BtnProcessarClick: Processa=" + TRANSFORM(loc_oForm.cmd_4c_Processa.Enabled) + ;
            " Cancela=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Enabled) + ;
            " chkConta=" + TRANSFORM(loc_oForm.chk_4c_Conta.Enabled) + ;
            " LblEnd.Visible=" + TRANSFORM(loc_oForm.lbl_4c_LblEnd.Visible))
    CATCH TO loc_oErro
        LogPasso("5 BtnProcessarClick FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure)
    ENDTRY

    *-- 5b. BtnCancelarClick chamavel de fora (fecha a tela, como o legado)
    TRY
        loc_oForm.BtnCancelarClick()
        LogPasso("5b BtnCancelarClick de FORA: OK (VARTYPE pos=" + VARTYPE(loc_oForm) + ")")
    CATCH TO loc_oErro
        LogPasso("5b BtnCancelarClick FALHOU: " + loc_oErro.Message)
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    LogPasso("DIALOGOS SUPRIMIDOS:" + CHR(13) + CHR(10) + FILETOSTR(gc_4c_ArquivoErroTeste))
ELSE
    LogPasso("DIALOGOS: nenhum")
ENDIF

LogPasso("FIM " + TTOC(DATETIME()))
QUIT

*==============================================================================
* LogPasso - grava e FECHA o arquivo a cada passo (STRTOFILE ADDITIVE), para
* que um travamento deixe rastro em vez de arquivo nenhum
*==============================================================================
PROCEDURE LogPasso(par_cTexto)
    STRTOFILE(par_cTexto + CHR(13) + CHR(10), gc_4c_LogPassoF8, 1)
ENDPROC

*==============================================================================
* ProbeSigPrCccF8 - subclasse so para o harness: expoe o hook PROTECTED
* AplicarWhenDescricao. Subclasse alcanca membro protegido; script solto NAO.
*==============================================================================
DEFINE CLASS ProbeSigPrCccF8 AS FormSigPrCcc
    PROCEDURE ProbeWhenDescricao(par_oContainer)
        THIS.AplicarWhenDescricao(par_oContainer)
        RETURN .T.
    ENDPROC
ENDDEFINE
