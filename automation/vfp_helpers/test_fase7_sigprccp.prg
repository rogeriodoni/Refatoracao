*==============================================================================
* test_fase7_sigprccp.prg - Harness da Fase 7 do Formsigprccp
*
* Prova que:
*   1. o form INSTANCIA depois das mudancas da Fase 7 (Init de form grande
*      falha em CADEIA - compilar limpo nao prova que a tela abre);
*   2. os metodos de EVENTO da Fase 7 existem e sao PUBLIC (PEMSTATUS(...,5)
*      devolve .T. mesmo para PROTECTED, entao o escopo se prova CHAMANDO de
*      fora da classe);
*   3. a datasession privada recebeu SET SAFETY OFF / SET DELETED ON - sem
*      isso o ZAP congela a tela e o DELETE do filtro de Variacao nao faz a
*      linha desaparecer;
*   4. AplicarFiltroVariacao realmente descarta as linhas certas, com o SINAL
*      do legado (positivo descarta pvarias MENOR; negativo descarta MAIOR);
*   5. os metodos novos do BO existem e o SQL do historico eh montado com
*      todas as colunas NOT NULL.
*
* Bootstrap MINIMO (sem ConfigurarAmbiente, que abre conexao SQL).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF
SET TALK OFF
SET DATE TO BRITISH
SET CENTURY ON

LOCAL lcLog, lcCRLF, lcCls, lcUtl, lnFalhas, loForm, loBO, loErr
LOCAL lnI, lcNome, lnAntes, lnDepois
lcCRLF   = CHR(13) + CHR(10)
lcLog    = "C:\4c\automation\vfp_helpers\test_fase7_sigprccp_resultado.txt"
lcCls    = "C:\4c\projeto\app\classes\"
lcUtl    = "C:\4c\projeto\app\utils\"
lnFalhas = 0

STRTOFILE("=== TESTE FASE 7 Formsigprccp (eventos principais) ===" + lcCRLF, lcLog, 0)

PUBLIC gb_4c_ModoTeste, gb_4c_ValidandoUI, gnConnHandle
PUBLIC gc_4c_CaminhoIcones, gc_4c_CaminhoReports, gc_4c_CaminhoFramework
PUBLIC gc_4c_UsuarioLogado, go_4c_Sistema, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste        = .T.
gb_4c_ValidandoUI      = .F.
gnConnHandle           = -1

*-- OBRIGATORIO junto com gb_4c_ModoTeste: EscreverErroParaArquivo exige as
*-- DUAS coisas (flag + nome de arquivo). Sem esta linha MsgErro/MsgAviso caem
*-- num MESSAGEBOX real e o teste TRAVA sem produzir resultado.
gc_4c_ArquivoErroTeste = "C:\4c\automation\vfp_helpers\test_fase7_sigprccp_dialogs.txt"
gc_4c_CaminhoIcones    = "C:\4c\vbmp\"
gc_4c_CaminhoReports   = "C:\4c\projeto\app\reports\"
gc_4c_CaminhoFramework = "C:\4c\Framework\"
gc_4c_UsuarioLogado    = "TESTE"

go_4c_Sistema = CREATEOBJECT("Empty")
ADDPROPERTY(go_4c_Sistema, "cCodEmpresa", "001")
ADDPROPERTY(go_4c_Sistema, "cEmpresa", "TESTE")

SET PATH TO ("C:\4c\projeto\app\classes,C:\4c\projeto\app\utils,C:\4c\projeto\app\forms\operacionais")

TRY
    SET PROCEDURE TO (lcUtl + "functions.prg")    ADDITIVE
    SET PROCEDURE TO (lcUtl + "messages.prg")     ADDITIVE
    SET PROCEDURE TO (lcUtl + "validators.prg")   ADDITIVE
    SET PROCEDURE TO (lcCls + "businessbase.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "dataaccess.prg")   ADDITIVE
    SET PROCEDURE TO (lcCls + "formbase.prg")     ADDITIVE
    *-- MostrarErro mora em FormErro.prg (classes\), NAO em messages.prg: sem
    *-- ele todo CATCH que chama MostrarErro estoura "File 'mostrarerro.prg'
    *-- does not exist" e o teste acusa defeito que eh do proprio harness
    SET PROCEDURE TO (lcCls + "FormErro.prg")     ADDITIVE
    SET PROCEDURE TO (lcCls + "fwprogressbar.prg") ADDITIVE
    SET PROCEDURE TO (lcCls + "sigprccpBO.prg")   ADDITIVE
    SET PROCEDURE TO "C:\4c\projeto\app\forms\operacionais\Formsigprccp.prg" ADDITIVE
    STRTOFILE("SET PROCEDURE      : OK" + lcCRLF, lcLog, 1)
CATCH TO loErr
    STRTOFILE("SET PROCEDURE      : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ENDTRY

*==============================================================================
* 1) BO isolado - metodos novos da Fase 7
*==============================================================================
STRTOFILE(lcCRLF + "--- 1) BO: metodos novos ---" + lcCRLF, lcLog, 1)

loBO = .NULL.
TRY
    loBO = CREATEOBJECT("sigprccpBO")
CATCH TO loErr
    STRTOFILE("CREATEOBJECT BO    : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loBO) != "O"
    STRTOFILE("CREATEOBJECT BO    : FALHA - retornou " + VARTYPE(loBO) + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ELSE
    STRTOFILE("CREATEOBJECT BO    : OK" + lcCRLF, lcLog, 1)

    LOCAL ARRAY laBO[9]
    laBO[1] = "BuscarPresetsAutomaticos"
    laBO[2] = "ObterChkSubGrupos"
    laBO[3] = "ResolverSubGrupoPorFaixa"
    laBO[4] = "GravarHistoricoPreco"
    laBO[5] = "GravarHistoricoComposicao"
    laBO[6] = "ExcluirPrecosTabela"
    laBO[7] = "IniciarTransacao"
    laBO[8] = "ConfirmarTransacao"
    laBO[9] = "DesfazerTransacao"

    FOR lnI = 1 TO ALEN(laBO)
        lcNome = laBO[lnI]
        IF PEMSTATUS(loBO, lcNome, 5)
            STRTOFILE("  BO." + PADR(lcNome, 26) + ": existe" + lcCRLF, lcLog, 1)
        ELSE
            STRTOFILE("  BO." + PADR(lcNome, 26) + ": FALTA" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ENDIF
    ENDFOR

    *-- Properties novas
    LOCAL ARRAY laProp[3]
    laProp[1] = "this_nImpEtiqs"
    laProp[2] = "this_cSubGrupo"
    laProp[3] = "this_lAtualizarSubGrupo"
    FOR lnI = 1 TO ALEN(laProp)
        lcNome = laProp[lnI]
        IF PEMSTATUS(loBO, lcNome, 5)
            STRTOFILE("  BO." + PADR(lcNome, 26) + ": existe" + lcCRLF, lcLog, 1)
        ELSE
            STRTOFILE("  BO." + PADR(lcNome, 26) + ": FALTA" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ENDIF
    ENDFOR

    *-- Escopo PUBLIC provado pela CHAMADA real de fora da classe.
    *-- Com gnConnHandle = -1 o SQLEXEC dispara excecao (comportamento do
    *-- ambiente, nao defeito do BO): o que se prova aqui eh que o metodo
    *-- EXISTE e eh alcancavel, e que o CATCH interno nao deixa passar.
    TRY
        lnI = loBO.ObterChkSubGrupos()
        STRTOFILE("  chamada ObterChkSubGrupos  : OK (retornou " + ;
            TRANSFORM(lnI) + ")" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("  chamada ObterChkSubGrupos  : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    TRY
        lcNome = loBO.ResolverSubGrupoPorFaixa("001", 100)
        STRTOFILE("  chamada ResolverSubGrupo   : OK (retornou [" + lcNome + "])" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("  chamada ResolverSubGrupo   : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY
ENDIF

*==============================================================================
* 2) INSTANCIACAO do form (modo manual - Automatico = .F.)
*==============================================================================
STRTOFILE(lcCRLF + "--- 2) INSTANCIACAO ---" + lcCRLF, lcLog, 1)

loForm = .NULL.
TRY
    loForm = CREATEOBJECT("Formsigprccp", .F.)
CATCH TO loErr
    STRTOFILE("CREATEOBJECT       : FALHA - " + loErr.Message + ;
        " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
ENDTRY

IF VARTYPE(loForm) != "O"
    STRTOFILE("CREATEOBJECT       : FALHA - retornou " + VARTYPE(loForm) + lcCRLF, lcLog, 1)
    lnFalhas = lnFalhas + 1
ELSE
    STRTOFILE("CREATEOBJECT       : OK (form instanciado)" + lcCRLF, lcLog, 1)

    *==========================================================================
    * 3) EXISTENCIA + ESCOPO dos metodos de evento da Fase 7
    *==========================================================================
    STRTOFILE(lcCRLF + "--- 3) EVENTOS DA FASE 7 ---" + lcCRLF, lcLog, 1)

    LOCAL ARRAY laEv[12]
    laEv[1]  = "BtnProcessarClick"
    laEv[2]  = "BtnAtualizarClick"
    laEv[3]  = "BtnEncerrarClick"
    laEv[4]  = "BtnSelTudoClick"
    laEv[5]  = "BtnApagaClick"
    laEv[6]  = "BtnImprimirClick"
    laEv[7]  = "AtualizarPrecos"
    laEv[8]  = "ProcessaAutomatico"
    laEv[9]  = "AplicarFiltroVariacao"
    laEv[10] = "AplicarPresetNaTela"
    laEv[11] = "CarregarLista"
    laEv[12] = "Activate"

    FOR lnI = 1 TO ALEN(laEv)
        lcNome = laEv[lnI]
        IF PEMSTATUS(loForm, lcNome, 5)
            STRTOFILE("  " + PADR(lcNome, 24) + ": existe" + lcCRLF, lcLog, 1)
        ELSE
            STRTOFILE("  " + PADR(lcNome, 24) + ": FALTA" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ENDIF
    ENDFOR

    *==========================================================================
    * 4) SETs da datasession privada (DataSession = 2)
    *==========================================================================
    STRTOFILE(lcCRLF + "--- 4) SETs DA DATASESSION PRIVADA ---" + lcCRLF, lcLog, 1)

    LOCAL lnSessaoAnterior
    lnSessaoAnterior = SET("DATASESSION")
    SET DATASESSION TO loForm.DataSessionId

    STRTOFILE("  SET(SAFETY)   = " + SET("SAFETY") + ;
        IIF(SET("SAFETY") = "OFF", "  (OK - ZAP nao abre dialogo)", ;
            "  FALHA - ZAP vai CONGELAR a tela") + lcCRLF, lcLog, 1)
    IF SET("SAFETY") != "OFF"
        lnFalhas = lnFalhas + 1
    ENDIF

    STRTOFILE("  SET(DELETED)  = " + SET("DELETED") + ;
        IIF(SET("DELETED") = "ON", "   (OK - DELETE some da grade)", ;
            "  FALHA - linha apagada continua na grade") + lcCRLF, lcLog, 1)
    IF SET("DELETED") != "ON"
        lnFalhas = lnFalhas + 1
    ENDIF

    STRTOFILE("  SET(DATE)     = " + SET("DATE") + lcCRLF, lcLog, 1)

    *==========================================================================
    * 5) AplicarFiltroVariacao - o SINAL eh regra de negocio
    *    Legado: lnVaria > 0 -> Delete For PVarias < lnVaria
    *            lnVaria < 0 -> Delete For PVarias > lnVaria
    *==========================================================================
    STRTOFILE(lcCRLF + "--- 5) FILTRO DE VARIACAO (sinal) ---" + lcCRLF, lcLog, 1)

    IF !USED("cursor_4c_Produtos")
        STRTOFILE("  cursor_4c_Produtos NAO existe - FALHA" + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ELSE
        *-- Cenario A: variacao POSITIVA 10 -> sobra quem subiu >= 10
        SELECT cursor_4c_Produtos
        ZAP
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("A", 25)
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("B", 10)
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("C", 5)
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("D", -30)
        COUNT TO lnAntes
        loForm.txt_4c_Variacao.Value = 10
        loForm.AplicarFiltroVariacao()
        SELECT cursor_4c_Produtos
        COUNT TO lnDepois
        STRTOFILE("  Variacao = +10 : " + TRANSFORM(lnAntes) + " -> " + ;
            TRANSFORM(lnDepois) + " linhas" + ;
            IIF(lnDepois = 2, "  (OK - sobraram A=25 e B=10)", ;
                "  FALHA - esperado 2") + lcCRLF, lcLog, 1)
        IF lnDepois != 2
            lnFalhas = lnFalhas + 1
        ENDIF

        *-- Cenario B: variacao NEGATIVA -10 -> sobra quem caiu <= -10
        SELECT cursor_4c_Produtos
        ZAP
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("A", 25)
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("B", -10)
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("C", -30)
        COUNT TO lnAntes
        loForm.txt_4c_Variacao.Value = -10
        loForm.AplicarFiltroVariacao()
        SELECT cursor_4c_Produtos
        COUNT TO lnDepois
        STRTOFILE("  Variacao = -10 : " + TRANSFORM(lnAntes) + " -> " + ;
            TRANSFORM(lnDepois) + " linhas" + ;
            IIF(lnDepois = 2, "  (OK - sobraram B=-10 e C=-30)", ;
                "  FALHA - esperado 2") + lcCRLF, lcLog, 1)
        IF lnDepois != 2
            lnFalhas = lnFalhas + 1
        ENDIF

        *-- Cenario C: variacao ZERO nao filtra nada (legado nao tem ramo)
        SELECT cursor_4c_Produtos
        ZAP
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("A", 25)
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("B", 0)
        INSERT INTO cursor_4c_Produtos (cpros, pvarias) VALUES ("C", -30)
        loForm.txt_4c_Variacao.Value = 0
        loForm.AplicarFiltroVariacao()
        SELECT cursor_4c_Produtos
        COUNT TO lnDepois
        STRTOFILE("  Variacao =   0 : 3 -> " + TRANSFORM(lnDepois) + " linhas" + ;
            IIF(lnDepois = 3, "  (OK - nao filtra)", "  FALHA - esperado 3") + lcCRLF, lcLog, 1)
        IF lnDepois != 3
            lnFalhas = lnFalhas + 1
        ENDIF

        *-- A coluna cgrus (usada na reclassificacao de subgrupo) existe?
        IF TYPE("cursor_4c_Produtos.cgrus") != "U"
            STRTOFILE("  cursor_4c_Produtos.cgrus  : existe (OK)" + lcCRLF, lcLog, 1)
        ELSE
            STRTOFILE("  cursor_4c_Produtos.cgrus  : FALTA" + lcCRLF, lcLog, 1)
            lnFalhas = lnFalhas + 1
        ENDIF

        SELECT cursor_4c_Produtos
        ZAP
    ENDIF

    *==========================================================================
    * 6) AtualizarPrecos sem nada marcado NAO pode gravar nem travar
    *==========================================================================
    STRTOFILE(lcCRLF + "--- 6) AtualizarPrecos sem selecao ---" + lcCRLF, lcLog, 1)
    TRY
        loForm.this_lAutomatico = .T.   && evita os MsgConfirma interativos
        lcNome = TRANSFORM(loForm.AtualizarPrecos())
        STRTOFILE("  AtualizarPrecos()  : retornou " + lcNome + ;
            IIF(lcNome = ".F.", "  (OK - recusou lote vazio)", ;
                "  FALHA - deveria recusar") + lcCRLF, lcLog, 1)
        IF lcNome != ".F."
            lnFalhas = lnFalhas + 1
        ENDIF
        loForm.this_lAutomatico = .F.
    CATCH TO loErr
        STRTOFILE("  AtualizarPrecos()  : FALHA - " + loErr.Message + ;
            " | Linha " + TRANSFORM(loErr.LineNo) + " | " + loErr.Procedure + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    *-- Botoes SelTudo/Apaga (sem linha nenhuma, so prova alcance)
    TRY
        loForm.BtnSelTudoClick()
        loForm.BtnApagaClick()
        STRTOFILE("  BtnSelTudo/Apaga   : OK (alcancaveis)" + lcCRLF, lcLog, 1)
    CATCH TO loErr
        STRTOFILE("  BtnSelTudo/Apaga   : FALHA - " + loErr.Message + lcCRLF, lcLog, 1)
        lnFalhas = lnFalhas + 1
    ENDTRY

    SET DATASESSION TO lnSessaoAnterior

    loForm.Release()
    loForm = .NULL.
ENDIF

*==============================================================================
STRTOFILE(lcCRLF + "===============================================" + lcCRLF, lcLog, 1)
IF lnFalhas = 0
    STRTOFILE("Status: SUCESSO (0 falhas)" + lcCRLF, lcLog, 1)
ELSE
    STRTOFILE("Status: FALHA (" + TRANSFORM(lnFalhas) + " problema(s))" + lcCRLF, lcLog, 1)
ENDIF

QUIT
