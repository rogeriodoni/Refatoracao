*==============================================================================
* InstantiateCheckCccF7.prg - valida a Fase 7 de FormSigPrCcc/SigPrCccBO
*
* Prova, medindo no VFP9 (nao por leitura de codigo):
*   1. o form ainda INSTANCIA depois das mudancas da fase;
*   2. cmd_4c_Processa tem o BINDEVENT de Click apontando para
*      CmdProcessaClick (sem ele o botao principal nao faz nada);
*   3. os 4 metodos de processamento do BO sao PUBLICOS de verdade - sao
*      chamados de FORA da classe (pelo form), e PEMSTATUS mente sobre escopo;
*   4. AtualizarContadorRegistros eh PUBLICO - o BO o chama de fora;
*   5. FormParaBO/HabilitarControlesProcessamento (PROTECTED, escopo herdado
*      de FormBase) rodam de dentro de uma subclasse Probe, e o round-trip
*      tela -> BO fecha com os valores digitados;
*   6. o CmdProcessaClick DESTRAVA a tela mesmo quando o processamento falha
*      (regra #40: quem desabilita botao tem de reabilitar no funil de volta).
*
* Marcador de versao na saida (v1) para nao confundir resultado velho com novo.
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF

PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_error_cccf7.txt"
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

LOCAL loc_cRes, loc_oForm, loc_oErro, loc_cNL
loc_cNL  = CHR(13) + CHR(10)
loc_cRes = "v1 FASE7 CHECK" + loc_cNL

TRY
    CD C:\4c\projeto\app\start
    DO config.prg
    ConfigurarAmbiente()
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "AMBIENTE FALHOU: " + loc_oErro.Message + loc_cNL
ENDTRY

*-- 1. Instanciar (TRY por chamada, para distinguir "nao rodou" de "falhou")
TRY
    loc_oForm = CREATEOBJECT("ProbeSigPrCcc")
    loc_cRes = loc_cRes + "1 INSTANCIA: VARTYPE=" + VARTYPE(loc_oForm) + ;
        IIF(VARTYPE(loc_oForm) = "O", " W=" + TRANSFORM(loc_oForm.Width), "") + loc_cNL
CATCH TO loc_oErro
    loc_cRes = loc_cRes + "1 INSTANCIA FALHOU: " + loc_oErro.Message + ;
        " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + loc_cNL
ENDTRY

IF VARTYPE(loc_oForm) = "O"

    *-- 2. BINDEVENT do botao Processar
    TRY
        LOCAL ARRAY loc_aEv[1, 5]
        LOCAL loc_nEv, loc_nI, loc_cAch
        *-- AEVENTS tem DOIS argumentos (com 3 da "Too many arguments"); o
        *-- nome do evento eh a coluna 3 e o metodo delegate a coluna 4
        loc_nEv = AEVENTS(loc_aEv, loc_oForm.cmd_4c_Processa)
        loc_cAch = ""
        FOR loc_nI = 1 TO loc_nEv
            loc_cAch = loc_cAch + ALLTRIM(loc_aEv[loc_nI, 3]) + "->" + ;
                ALLTRIM(loc_aEv[loc_nI, 4]) + " "
        ENDFOR
        loc_cRes = loc_cRes + "2 BINDEVENT Processa: n=" + TRANSFORM(loc_nEv) + ;
            " [" + loc_cAch + "]" + loc_cNL
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "2 BINDEVENT FALHOU: " + loc_oErro.Message + loc_cNL
    ENDTRY

    *-- 3. Metodos do BO chamaveis de FORA (escopo real, nao PEMSTATUS)
    LOCAL loc_oBO, loc_cMet, loc_nM
    LOCAL ARRAY loc_aMet[4]
    loc_aMet[1] = "RecalcularContaCorrente"
    loc_aMet[2] = "RecalcularEstoque"
    loc_aMet[3] = "RecalcularCustoProduto"
    loc_aMet[4] = "AtualizarUltimaCompra"
    loc_oBO = loc_oForm.this_oBusinessObject
    loc_cRes = loc_cRes + "3 BO metodos (PEMSTATUS vs chamada real):" + loc_cNL
    FOR loc_nM = 1 TO 4
        loc_cMet = loc_aMet[loc_nM]
        LOCAL loc_cPem, loc_cCall
        loc_cPem = TRANSFORM(PEMSTATUS(loc_oBO, loc_cMet, 5))
        loc_cCall = "?"
        TRY
            *-- Sem conexao o metodo devolve .F. sem gravar nada; o que
            *-- importa aqui eh NAO estourar "Property X is not found"
            loc_cCall = "retornou " + TRANSFORM(EVALUATE("loc_oBO." + loc_cMet + "()"))
        CATCH TO loc_oErro
            loc_cCall = "ERRO: " + loc_oErro.Message
        ENDTRY
        loc_cRes = loc_cRes + "   " + PADR(loc_cMet, 26) + " PEMSTATUS=" + ;
            loc_cPem + " chamada=" + loc_cCall + loc_cNL
    ENDFOR

    *-- 4. AtualizarContadorRegistros chamado de FORA (como o BO faz)
    TRY
        loc_oForm.AtualizarContadorRegistros(4321)
        loc_cRes = loc_cRes + "4 AtualizarContadorRegistros(4321) de FORA: OK" + ;
            " txt_4c_Registro.Value=" + TRANSFORM(loc_oForm.txt_4c_Registro.Value) + loc_cNL
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "4 AtualizarContadorRegistros FALHOU: " + ;
            loc_oErro.Message + loc_cNL
    ENDTRY

    *-- 5. FormParaBO via Probe (round-trip tela -> BO)
    TRY
        loc_oForm.cnt_4c_OpConta.txt_4c_Empresa.Value    = "001"
        loc_oForm.cnt_4c_OpConta.txt_4c_TxtGrupos.Value  = "GRP1"
        loc_oForm.cnt_4c_OpConta.txt_4c_TxtContas.Value  = "CTA9"
        loc_oForm.cnt_4c_OpConta.txt_4c_TxtMoedas.Value  = "BRL"
        loc_oForm.cnt_4c_OpConta.txt_4c_TxtData.Value    = DATE()
        loc_oForm.cnt_4c_OpEstoque.txt_4c_Produto.Value  = "PRO123"
        loc_oForm.chk_4c_BtnCusto.Value                  = 1

        loc_cRes = loc_cRes + "5 FormParaBO: retorno=" + ;
            TRANSFORM(loc_oForm.ProbeFormParaBO()) + loc_cNL + ;
            "   ContaEmpresa=[" + loc_oBO.this_cContaEmpresa + "]" + ;
            " ContaGrupo=[" + loc_oBO.this_cContaGrupo + "]" + ;
            " ContaConta=[" + loc_oBO.this_cContaConta + "]" + ;
            " ContaMoeda=[" + loc_oBO.this_cContaMoeda + "]" + loc_cNL + ;
            "   ContaData=" + TRANSFORM(loc_oBO.this_dContaData) + ;
            " tipo=" + VARTYPE(loc_oBO.this_dContaData) + ;
            " EstoqueProduto=[" + ALLTRIM(loc_oBO.this_cEstoqueProduto) + "]" + ;
            " lCusto=" + TRANSFORM(loc_oBO.this_lCusto) + ;
            " lConta=" + TRANSFORM(loc_oBO.this_lConta) + loc_cNL
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "5 FormParaBO FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + loc_cNL
    ENDTRY

    *-- 6. Travar/destravar: estado dos botoes antes e depois de uma passada
    TRY
        loc_oForm.chk_4c_Conta.Value = 1
        loc_oForm.ProbeTravar(.F.)
        loc_cRes = loc_cRes + "6 TRAVADO: Processa=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Processa.Enabled) + ;
            " Cancela=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Enabled) + ;
            " chkConta=" + TRANSFORM(loc_oForm.chk_4c_Conta.Enabled) + loc_cNL
        loc_oForm.ProbeTravar(.T.)
        loc_cRes = loc_cRes + "  DESTRAVADO: Processa=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Processa.Enabled) + ;
            " Cancela=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Enabled) + ;
            " chkConta=" + TRANSFORM(loc_oForm.chk_4c_Conta.Enabled) + loc_cNL
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "6 TRAVAR FALHOU: " + loc_oErro.Message + loc_cNL
    ENDTRY

    *-- 6b. CmdProcessaClick completo: com o processamento falhando (sem
    *-- conexao valida), a tela TEM de voltar destravada
    TRY
        loc_oForm.chk_4c_Conta.Value = 1
        loc_oForm.CmdProcessaClick()
        loc_cRes = loc_cRes + "6b POS CmdProcessaClick: Processa=" + ;
            TRANSFORM(loc_oForm.cmd_4c_Processa.Enabled) + ;
            " Cancela=" + TRANSFORM(loc_oForm.cmd_4c_Cancela.Enabled) + ;
            " chkConta=" + TRANSFORM(loc_oForm.chk_4c_Conta.Enabled) + ;
            " LblEnd.Visible=" + TRANSFORM(loc_oForm.lbl_4c_LblEnd.Visible) + loc_cNL
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "6b CmdProcessaClick FALHOU: " + loc_oErro.Message + ;
            " LN=" + TRANSFORM(loc_oErro.LineNo) + " PROC=" + loc_oErro.Procedure + loc_cNL
    ENDTRY

    TRY
        loc_oForm.Release()
    CATCH TO loc_oErro
        loc_cRes = loc_cRes + "RELEASE FALHOU: " + loc_oErro.Message + loc_cNL
    ENDTRY
ENDIF

IF FILE(gc_4c_ArquivoErroTeste)
    loc_cRes = loc_cRes + "DIALOGOS SUPRIMIDOS: " + loc_cNL + ;
        FILETOSTR(gc_4c_ArquivoErroTeste) + loc_cNL
ELSE
    loc_cRes = loc_cRes + "DIALOGOS: nenhum" + loc_cNL
ENDIF

STRTOFILE(loc_cRes, "C:\4c\automation\instantiate_cccf7_result.txt")

*==============================================================================
* ProbeSigPrCcc - subclasse so para o harness: expoe os hooks PROTECTED
* (FormParaBO / HabilitarControlesProcessamento). Subclasse alcanca membro
* protegido; script solto NAO - por isso o probe existe.
*==============================================================================
DEFINE CLASS ProbeSigPrCcc AS FormSigPrCcc
    PROCEDURE ProbeFormParaBO()
        RETURN THIS.FormParaBO()
    ENDPROC
    PROCEDURE ProbeTravar(par_lHabilitar)
        THIS.HabilitarControlesProcessamento(par_lHabilitar)
        RETURN .T.
    ENDPROC
ENDDEFINE

QUIT
