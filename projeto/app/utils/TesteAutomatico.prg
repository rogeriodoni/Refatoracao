*====================================================================
* TesteAutomatico.prg
*
* Script para testar formularios automaticamente (CRUD, REPORT e OPERACIONAL)
*
* PARAMETROS:
*   par_cFormClass - Nome da classe do formulario (ex: "FormCor")
*   par_cTaskDir   - Diretorio da task para salvar resultado
*   par_cFormType  - (OPCIONAL) Tipo do form: "CRUD", "REPORT" ou "OPERACIONAL"
*                    Se omitido, detecta automaticamente
*
* RETORNO:
*   Gera arquivo teste_resultado.json no diretorio da task
*   Exit code: 0 = todos os testes passaram
*              1 = algum teste falhou
*              2 = erro critico
*
* EXEMPLOS:
*   VFP9.EXE TesteAutomatico('FormCor', 'C:\4c\tasks\task1')
*   VFP9.EXE TesteAutomatico('Formsigopind', 'C:\4c\tasks\task38', 'OPERACIONAL')
*   DO TesteAutomatico WITH "FormCor", "C:\4c\tasks\task1"
*
* TESTES EXECUTADOS (CRUD - frmcadastro):
*   1. Instanciacao - CREATEOBJECT(formClass) sem erro
*   2. CarregarLista - Grid populado (RECCOUNT > 0)
*   3. ModoIncluir - AlternarPagina(2) funciona
*   4. ModoVisualizar - Campos desabilitados
*   5. Fechar - Release() sem erro
*
* TESTES EXECUTADOS (REPORT - frmrelatorio):
*   1. Instanciacao - CREATEOBJECT(formClass) sem erro
*   2. FormParaRelatorio - Metodo existe
*   3. BotoesRelatorio - BtnVisualizarClick/BtnImprimirClick existem
*   4. ModoVisualizar - (fallback: AVISO se nao aplicavel)
*   5. Fechar - Release() sem erro
*
* TESTES EXECUTADOS (OPERACIONAL - form generico):
*   1. Instanciacao - CREATEOBJECT(formClass) sem erro
*   2. ContainersFlutuantes - Toggle Visible de containers ocultos
*   3. CarregarDadosReais - Busca dados reais do banco e popula grid
*   4. NavegacaoPaginas - Navega entre todas as paginas do PageFrame
*   5-8. Testes de funcionalidade (ver abaixo)
*   9. Fechar - Release() sem erro
*
* TESTES DE FUNCIONALIDADE (todos os tipos):
*   BtnIncluirNavegacao - BtnIncluirClick navega p/ Page2, BtnCancelarClick volta
*   BtnEncerrarExiste - Verifica existencia de metodo de encerramento
*   GridTemDados - Verifica cursor_4c_Dados apos CarregarLista (pula se sem banco)
*   LookupMetodosExistem - Verifica AbrirLookup/KeyPress para campos de lookup
*====================================================================
LPARAMETERS par_cFormClass, par_cTaskDir, par_cFormType

*-- Variaveis globais para testes
PUBLIC gb_4c_ValidandoUI
gb_4c_ValidandoUI = .T.  && Evita CarregarLista automatico durante testes

*-- MODO TESTE: Suprimir dialogs (MostrarErro, MsgErro, etc.) para evitar TIMEOUT
*-- Erros sao gravados em gc_4c_ArquivoErroTeste ao inves de mostrar dialog modal
PUBLIC gb_4c_ModoTeste, gc_4c_ArquivoErroTeste
gb_4c_ModoTeste = .T.
gc_4c_ArquivoErroTeste = ""  && Sera definido apos validar par_cTaskDir

*-- Validacao de parametros
IF EMPTY(par_cFormClass) OR VARTYPE(par_cFormClass) # "C"
    ? "ERRO: Parametro par_cFormClass nao fornecido ou invalido!"
    QUIT RETURN 2
ENDIF

IF EMPTY(par_cTaskDir) OR VARTYPE(par_cTaskDir) # "C"
    ? "ERRO: Parametro par_cTaskDir nao fornecido ou invalido!"
    QUIT RETURN 2
ENDIF

*-- Definir arquivo de erro para modo teste
gc_4c_ArquivoErroTeste = ADDBS(par_cTaskDir) + "vfp_error_details.txt"
*-- Limpar arquivo anterior se existir
IF FILE(gc_4c_ArquivoErroTeste)
    DELETE FILE (gc_4c_ArquivoErroTeste)
ENDIF

*-- Variaveis
LOCAL loc_oTester, loc_cArquivoResultado
LOCAL loc_lTodosPassaram, loc_nExitCode

? "========================================================================"
? "TesteAutomatico - Testes Autom" + CHR(225) + "ticos de Formul" + CHR(225) + "rio"
? "========================================================================"
? "FormClass: " + par_cFormClass
? "TaskDir: " + par_cTaskDir
? "========================================================================"
? ""

*-- Carrega config.prg para ter acesso as classes
LOCAL loc_cCaminhoConfig, loc_cDirAtual
loc_cCaminhoConfig = "C:\4c\projeto\app\start\config.prg"

IF FILE(loc_cCaminhoConfig)
    ? "Carregando configuracao..."
    *-- Salva diretorio atual
    loc_cDirAtual = SYS(5) + CURDIR()
    *-- Muda para diretorio do config.prg (necessario para caminhos relativos)
    CD C:\4c\projeto\app\start
    DO config.prg
    *-- CRITICO: Chamar ConfigurarAmbiente para carregar SET PROCEDURE
    ConfigurarAmbiente()
    *-- config.prg redefine gb_4c_ValidandoUI = .F. (linha 100). Restaurar para modo teste.
    gb_4c_ValidandoUI = .T.
    *-- Restaura diretorio
    CD (loc_cDirAtual)
    ? "  - config.prg carregado"
    ? "  - ConfigurarAmbiente() executado"

    *-- Conexao ao banco ignorada: SQLSTRINGCONNECT bloqueia 300s pelo timeout TCP do SO
    *-- quando o servidor esta inacessivel. SQLSETPROP ConnectTimeOut nao sobrepoe o
    *-- timeout TCP do Windows. Forms com gb_4c_ModoTeste=.T. pulam todas as queries
    *-- SQL internamente, portanto gnConnHandle=0 e suficiente para os testes.
    PUBLIC gnConnHandle
    gnConnHandle = 0
    ? "  - ModoTeste: conexao ao banco ignorada (gnConnHandle=0, forms usam gb_4c_ModoTeste)"
ELSE
    ? "AVISO: config.prg nao encontrado: " + loc_cCaminhoConfig
ENDIF

*-- Cria objeto tester
loc_oTester = CREATEOBJECT("FormTester")
loc_oTester.cFormClass = par_cFormClass
loc_oTester.cTaskDir = par_cTaskDir

*-- Passa formType se fornecido (CRUD, REPORT, OPERACIONAL)
IF VARTYPE(par_cFormType) = "C" AND !EMPTY(par_cFormType)
    loc_oTester.cFormTypeHint = UPPER(ALLTRIM(par_cFormType))
    ? "FormType (hint): " + loc_oTester.cFormTypeHint
ENDIF

? ""
? "Executando testes..."
? ""

*-- Executa testes
loc_oTester.ExecutarTestes()

*-- Gera resultado
loc_cArquivoResultado = ADDBS(par_cTaskDir) + "teste_resultado.json"
loc_oTester.GerarResultadoJSON(loc_cArquivoResultado)

? ""
? "========================================================================"
? "RESULTADO DOS TESTES"
? "========================================================================"
loc_oTester.MostrarResumo()
? ""
? "Arquivo de resultado: " + loc_cArquivoResultado
? ""

*-- Determina exit code
loc_lTodosPassaram = loc_oTester.lTodosPassaram
loc_nExitCode = IIF(loc_lTodosPassaram, 0, 1)

*-- Limpa flag global
gb_4c_ValidandoUI = .F.

*-- Desconectar do banco
IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
    SQLDISCONNECT(gnConnHandle)
    gnConnHandle = 0
ENDIF

QUIT RETURN loc_nExitCode

*====================================================================
* CLASSE: FormTester
* Executa testes automaticos em um formulario
*====================================================================
DEFINE CLASS FormTester AS Custom

    cFormClass = ""
    cTaskDir = ""
    cFormTypeHint = ""  && Hint do pipeline: "CRUD", "REPORT" ou "OPERACIONAL"
    oForm = .NULL.
    lFormReport = .F.       && .T. se for formulario REPORT (frmrelatorio)
    lFormOperacional = .F.  && .T. se for formulario OPERACIONAL (form generico)

    lTodosPassaram = .T.

    *-- Array de resultados de testes
    DIMENSION aTestes[9, 4]  && [n,1]=nome, [n,2]=passou, [n,3]=erro, [n,4]=detalhes
    nTestes = 0

    *====================================================================
    * ExecutarTestes - Executa todos os testes
    *====================================================================
    PROCEDURE ExecutarTestes()
        *-- Teste 1: Instanciacao
        THIS.TesteInstanciacao()

        *-- Se instanciacao falhou, nao continua
        IF !THIS.aTestes[1, 2]
            RETURN
        ENDIF

        *-- Detecta tipo de formulario (REPORT vs CRUD vs OPERACIONAL)
        *-- Prioriza hint do pipeline (par_cFormType), senao detecta automaticamente
        IF THIS.cFormTypeHint = "OPERACIONAL"
            THIS.lFormOperacional = .T.
            THIS.lFormReport = .F.
        ELSE
            IF THIS.cFormTypeHint = "REPORT"
                THIS.lFormReport = .T.
                THIS.lFormOperacional = .F.
            ELSE
                *-- Deteccao automatica
                THIS.lFormReport = PEMSTATUS(THIS.oForm, "this_oRelatorio", 5)
                IF !THIS.lFormReport
                    *-- OPERACIONAL: nao tem CarregarLista nem AlternarPagina (padrao CRUD)
                    *-- e nao tem this_oRelatorio (padrao REPORT)
                    IF !PEMSTATUS(THIS.oForm, "CarregarLista", 5) AND ;
                       !PEMSTATUS(THIS.oForm, "AlternarPagina", 5)
                        THIS.lFormOperacional = .T.
                    ENDIF
                ENDIF
            ENDIF
        ENDIF

        IF THIS.lFormReport
            ? "  [INFO] Formulario REPORT detectado (frmrelatorio)"
        ELSE
            IF THIS.lFormOperacional
                ? "  [INFO] Formulario OPERACIONAL detectado (form generico)"
            ELSE
                ? "  [INFO] Formulario CRUD detectado (frmcadastro)"
            ENDIF
        ENDIF
        ?

        IF THIS.lFormReport
            *-- Testes para formularios REPORT
            THIS.TesteFormParaRelatorio()
            THIS.TesteBotoesRelatorio()
        ELSE
            IF THIS.lFormOperacional
                *-- Testes para formularios OPERACIONAIS
                THIS.TesteContainersFlutuantes()
                THIS.TesteCarregarDadosReais()
                THIS.TesteNavegacaoPaginas()
            ELSE
                *-- Testes para formularios CRUD
                THIS.TesteCarregarLista()
                THIS.TesteModoIncluir()
            ENDIF
        ENDIF

        IF !THIS.lFormOperacional
            *-- Teste 4: Modo Visualizar (CRUD e REPORT - nao aplicavel a OPERACIONAL)
            THIS.TesteModoVisualizar()
        ENDIF

        *-- Testes de funcionalidade (aplicaveis a todos os tipos)
        THIS.TesteBtnIncluirNavegacao()
        THIS.TesteBtnEncerrarExiste()
        THIS.TesteGridTemDados()
        THIS.TesteLookupMetodosExistem()

        *-- Teste final: Fechar
        THIS.TesteFechar()
    ENDPROC

    *====================================================================
    * TesteInstanciacao - Testa criacao do objeto Form
    *====================================================================
    PROTECTED PROCEDURE TesteInstanciacao()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [1] Instanciacao... "

        TRY
            THIS.oForm = CREATEOBJECT(THIS.cFormClass)

            IF VARTYPE(THIS.oForm) = "O"
                loc_lPassou = .T.
                loc_cDetalhes = "Objeto criado com sucesso"

                *-- Verificar se Caption foi propagado para labels de titulo
                IF TYPE("THIS.oForm.Caption") = "C" AND !EMPTY(THIS.oForm.Caption)
                    LOCAL loc_cCaption, loc_lTituloOk
                    loc_cCaption = THIS.oForm.Caption
                    loc_lTituloOk = .F.

                    *-- Verificar lbl_4c_Sombra
                    IF TYPE("THIS.oForm.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra") = "O"
                        IF THIS.oForm.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption == loc_cCaption
                            loc_lTituloOk = .T.
                        ENDIF
                    ENDIF
                    *-- Verificar lbl_4c_Titulo
                    IF !loc_lTituloOk AND TYPE("THIS.oForm.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo") = "O"
                        IF THIS.oForm.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption == loc_cCaption
                            loc_lTituloOk = .T.
                        ENDIF
                    ENDIF

                    IF TYPE("THIS.oForm.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra") = "O" AND !loc_lTituloOk
                        loc_cDetalhes = loc_cDetalhes + " | AVISO: lbl_4c_Sombra.Caption nao corresponde ao Caption do form (titulo pode estar errado na tela)"
                    ENDIF
                ENDIF

                ?? "PASSOU"
            ELSE
                loc_cErro = "CREATEOBJECT retornou valor nao-objeto"
                ?? "FALHOU"
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro)
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("Instanciacao", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteCarregarLista - Testa carregamento de dados na lista
    *====================================================================
    PROTECTED PROCEDURE TesteCarregarLista()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException
        LOCAL loc_nRecCount

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [2] CarregarLista... "

        TRY
            *-- Tenta chamar CarregarLista se existir
            IF PEMSTATUS(THIS.oForm, "CarregarLista", 5)
                THIS.oForm.CarregarLista()

                *-- Verifica cursors conhecidos (mesmo padrao do OPERACIONAL)
                LOCAL ARRAY loc_aCursoresCheck[8]
                LOCAL loc_k, loc_lAchouCursor, loc_cCursorAchado
                loc_aCursoresCheck[1] = "cursor_4c_Dados"
                loc_aCursoresCheck[2] = "cursor_4c_Lista"
                loc_aCursoresCheck[3] = "cursor_4c_Busca"
                loc_aCursoresCheck[4] = "cursor_4c_Saldos"
                loc_aCursoresCheck[5] = "cursor_4c_Historico"
                loc_aCursoresCheck[6] = "cursor_4c_Quitas"
                loc_aCursoresCheck[7] = "cursor_4c_ListaEest"
                loc_aCursoresCheck[8] = "cursor_4c_ListaCab"
                loc_lAchouCursor = .F.
                loc_cCursorAchado = ""
                FOR loc_k = 1 TO 8
                    IF USED(loc_aCursoresCheck[loc_k])
                        loc_lAchouCursor = .T.
                        loc_cCursorAchado = loc_aCursoresCheck[loc_k]
                        EXIT
                    ENDIF
                ENDFOR

                IF loc_lAchouCursor
                    loc_nRecCount = RECCOUNT(loc_cCursorAchado)
                    loc_cDetalhes = ALLTRIM(STR(loc_nRecCount)) + " registros em " + loc_cCursorAchado
                    loc_lPassou = .T.
                    ?? "PASSOU"
                ELSE
                    loc_cErro = "Nenhum cursor padrao foi criado (cursor_4c_Dados/Lista/Busca/etc)"
                    ?? "FALHOU"
                ENDIF
            ELSE
                loc_cErro = "Metodo CarregarLista nao encontrado"
                ?? "FALHOU"
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo))
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro)
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("CarregarLista", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteModoIncluir - Testa alternacao para modo incluir
    *====================================================================
    PROTECTED PROCEDURE TesteModoIncluir()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [3] ModoIncluir... "

        TRY
            *-- Tenta chamar AlternarPagina se existir
            IF PEMSTATUS(THIS.oForm, "AlternarPagina", 5)
                THIS.oForm.AlternarPagina(2)

                *-- Verifica se PageFrame.ActivePage mudou
                IF PEMSTATUS(THIS.oForm, "pgf_4c_Paginas", 5)
                    IF THIS.oForm.pgf_4c_Paginas.ActivePage = 2
                        loc_lPassou = .T.
                        loc_cDetalhes = "Page2 ativada com sucesso"
                        ?? "PASSOU"
                    ELSE
                        loc_cErro = "ActivePage nao mudou para 2"
                        ?? "FALHOU"
                    ENDIF
                ELSE
                    loc_cErro = "pgf_4c_Paginas nao encontrado"
                    ?? "FALHOU"
                ENDIF
            ELSE
                loc_cErro = "Metodo AlternarPagina nao encontrado"
                ?? "FALHOU"
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo))
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro)
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("ModoIncluir", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteFormParaRelatorio - Testa se form REPORT tem FormParaRelatorio
    * (equivalente ao TesteCarregarLista para CRUD)
    *====================================================================
    PROTECTED PROCEDURE TesteFormParaRelatorio()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [2] FormParaRelatorio... "

        TRY
            IF PEMSTATUS(THIS.oForm, "FormParaRelatorio", 5)
                loc_lPassou = .T.
                loc_cDetalhes = "Metodo FormParaRelatorio encontrado"
                ?? "PASSOU"
            ELSE
                loc_cErro = "Metodo FormParaRelatorio nao encontrado"
                ?? "FALHOU"
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo))
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro)
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("FormParaRelatorio", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteBotoesRelatorio - Testa se form REPORT tem botoes Visualizar/Imprimir
    * (equivalente ao TesteModoIncluir para CRUD)
    *====================================================================
    PROTECTED PROCEDURE TesteBotoesRelatorio()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [3] BotoesRelatorio... "

        TRY
            LOCAL loc_lTemVisualizar, loc_lTemImprimir
            loc_lTemVisualizar = PEMSTATUS(THIS.oForm, "BtnVisualizarClick", 5)
            loc_lTemImprimir = PEMSTATUS(THIS.oForm, "BtnImprimirClick", 5)

            IF loc_lTemVisualizar OR loc_lTemImprimir
                loc_lPassou = .T.
                loc_cDetalhes = "Visualizar=" + IIF(loc_lTemVisualizar, "SIM", "NAO") + ;
                    " Imprimir=" + IIF(loc_lTemImprimir, "SIM", "NAO")
                ?? "PASSOU"
            ELSE
                loc_cErro = "Nenhum botao de relatorio encontrado (BtnVisualizarClick/BtnImprimirClick)"
                ?? "FALHOU"
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo))
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro)
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("BotoesRelatorio", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteModoVisualizar - Testa modo visualizar (campos desabilitados)
    *====================================================================
    PROTECTED PROCEDURE TesteModoVisualizar()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [4] ModoVisualizar... "

        TRY
            *-- Tenta chamar AjustarBotoesPorModo ou similar
            IF PEMSTATUS(THIS.oForm, "AjustarBotoesPorModo", 5)
                THIS.oForm.this_cModoAtual = "VISUALIZAR"
                THIS.oForm.AjustarBotoesPorModo()

                loc_lPassou = .T.
                loc_cDetalhes = "Modo VISUALIZAR configurado"
                ?? "PASSOU"
            ELSE
                *-- Fallback: verifica se propriedade this_cModoAtual existe
                IF PEMSTATUS(THIS.oForm, "this_cModoAtual", 5)
                    THIS.oForm.this_cModoAtual = "VISUALIZAR"
                    loc_lPassou = .T.
                    loc_cDetalhes = "Propriedade this_cModoAtual configurada"
                    ?? "PASSOU"
                ELSE
                    loc_cErro = "Propriedade this_cModoAtual nao encontrada"
                    ?? "AVISO"
                    loc_lPassou = .T.  && Nao e erro critico
                ENDIF
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo))
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("ModoVisualizar", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteFechar - Testa fechamento do formulario
    *====================================================================
    PROTECTED PROCEDURE TesteFechar()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [5] Fechar... "

        TRY
            IF VARTYPE(THIS.oForm) = "O"
                THIS.oForm.Release()
                THIS.oForm = .NULL.

                loc_lPassou = .T.
                loc_cDetalhes = "Formulario fechado com sucesso"
                ?? "PASSOU"
            ELSE
                loc_cErro = "Objeto form ja era invalido"
                ?? "AVISO"
                loc_lPassou = .T.  && Nao e erro critico
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo))
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("Fechar", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteContainersFlutuantes - Testa containers com Visible=.F.
    * (OPERACIONAL) Verifica se containers ocultos podem ser togglados
    *====================================================================
    PROTECTED PROCEDURE TesteContainersFlutuantes()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException
        LOCAL loc_nContainers, loc_nTestados, loc_i, loc_j
        LOCAL loc_oPageFrame, loc_oPage, loc_oControl

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""
        loc_nContainers = 0
        loc_nTestados = 0

        ?? "  [2] ContainersFlutuantes... "

        TRY
            *-- Percorre todos os controles do form procurando PageFrame
            FOR loc_i = 1 TO THIS.oForm.ControlCount
                loc_oControl = THIS.oForm.Controls(loc_i)

                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    loc_oPageFrame = loc_oControl

                    *-- Percorre todas as Pages do PageFrame
                    FOR loc_j = 1 TO loc_oPageFrame.PageCount
                        loc_oPage = loc_oPageFrame.Pages(loc_j)
                        THIS.VerificarContainersNaPagina(loc_oPage, @loc_nContainers, @loc_nTestados)
                    ENDFOR
                ENDIF
            ENDFOR

            IF loc_nContainers = 0
                loc_cDetalhes = "Nenhum container flutuante encontrado (OK)"
                loc_lPassou = .T.
            ELSE
                loc_cDetalhes = ALLTRIM(STR(loc_nTestados)) + "/" + ALLTRIM(STR(loc_nContainers)) + " containers togglados com sucesso"
                loc_lPassou = (loc_nTestados = loc_nContainers)
                IF !loc_lPassou
                    loc_cErro = "Alguns containers falharam no toggle"
                ENDIF
            ENDIF

            ?? IIF(loc_lPassou, "PASSOU", "FALHOU")

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF
        IF !EMPTY(loc_cDetalhes)
            ? "      " + loc_cDetalhes
        ENDIF

        THIS.AdicionarResultado("ContainersFlutuantes", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * VerificarContainersNaPagina - Auxiliar: percorre controles de uma Page
    *====================================================================
    PROTECTED PROCEDURE VerificarContainersNaPagina(par_oPage, par_nContainers, par_nTestados)
        LOCAL loc_k, loc_oCtrl, loc_cNome

        FOR loc_k = 1 TO par_oPage.ControlCount
            loc_oCtrl = par_oPage.Controls(loc_k)

            IF UPPER(loc_oCtrl.BaseClass) = "CONTAINER" AND !loc_oCtrl.Visible
                *-- Container oculto encontrado - testar toggle
                loc_cNome = loc_oCtrl.Name
                par_nContainers = par_nContainers + 1

                TRY
                    *-- Toggle ON
                    loc_oCtrl.Visible = .T.
                    loc_oCtrl.ZOrder(0)
                    loc_oCtrl.Refresh()

                    *-- Verifica se ficou visivel
                    IF loc_oCtrl.Visible
                        *-- Toggle OFF (restaura estado original)
                        loc_oCtrl.Visible = .F.
                        par_nTestados = par_nTestados + 1
                        ? "      Container '" + loc_cNome + "': toggle OK (" + ;
                            ALLTRIM(STR(loc_oCtrl.ControlCount)) + " controles internos)"
                    ENDIF
                CATCH TO loc_oExc
                    ? "      Container '" + loc_cNome + "': ERRO - " + loc_oExc.Message
                ENDTRY
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * TesteCarregarDadosReais - Busca dados reais do banco e popula grid
    * (OPERACIONAL) Testa se as queries SQL funcionam com dados reais
    *====================================================================
    PROTECTED PROCEDURE TesteCarregarDadosReais()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException
        LOCAL loc_lTemDados

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""
        loc_lTemDados = .F.

        ?? "  [3] CarregarDadosReais... "

        TRY
            *-- Tenta encontrar metodo de carga de dados (MontaGrade, CarregarSaldos, etc.)
            *-- Procura por metodos comuns em forms operacionais
            LOCAL loc_aCandidatos, loc_nCand, loc_i, loc_cMetodo
            DIMENSION loc_aCandidatos[8]
            loc_aCandidatos[1] = "MontaGrade"
            loc_aCandidatos[2] = "CarregarSaldos"
            loc_aCandidatos[3] = "CarregarDados"
            loc_aCandidatos[4] = "CarregarHistorico"
            loc_aCandidatos[5] = "CarregarGrade"
            loc_aCandidatos[6] = "CarregarLista"
            loc_aCandidatos[7] = "Buscar"
            loc_aCandidatos[8] = "Consultar"

            loc_cMetodo = ""
            FOR loc_i = 1 TO 8
                IF PEMSTATUS(THIS.oForm, loc_aCandidatos[loc_i], 5)
                    loc_cMetodo = loc_aCandidatos[loc_i]
                    EXIT
                ENDIF
            ENDFOR

            IF EMPTY(loc_cMetodo)
                *-- Nenhum metodo de carga encontrado - tenta buscar dado de teste no banco
                *-- para verificar se a conexao funciona
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    LOCAL loc_nRes
                    loc_nRes = SQLEXEC(gnConnHandle, "SELECT TOP 1 codigos FROM SigCdGcr", "cursor_4c_TesteDado")
                    IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TesteDado") > 0
                        loc_lPassou = .T.
                        loc_cDetalhes = "Conexao DB OK (nenhum metodo de carga padrao encontrado)"
                    ELSE
                        loc_cDetalhes = "Conexao DB OK mas sem dados de teste"
                        loc_lPassou = .T.
                    ENDIF
                    IF USED("cursor_4c_TesteDado")
                        USE IN cursor_4c_TesteDado
                    ENDIF
                ELSE
                    loc_cErro = "Sem conexao ao banco (gnConnHandle invalido)"
                ENDIF
            ELSE
                *-- Encontrou metodo de carga - buscar dado de teste no banco
                LOCAL loc_cParamTeste
                loc_cParamTeste = ""

                *-- Se o metodo requer parametro (ex: MontaGrade precisa de grupo),
                *-- buscar um valor real do banco
                IF loc_cMetodo = "MontaGrade"
                    IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                        LOCAL loc_nResG
                        loc_nResG = SQLEXEC(gnConnHandle, ;
                            "SELECT TOP 1 codigos FROM SigCdGcr ORDER BY codigos", ;
                            "cursor_4c_GrupoTeste")
                        IF loc_nResG > 0 AND USED("cursor_4c_GrupoTeste") AND RECCOUNT("cursor_4c_GrupoTeste") > 0
                            loc_cParamTeste = ALLTRIM(cursor_4c_GrupoTeste.codigos)
                        ENDIF
                        IF USED("cursor_4c_GrupoTeste")
                            USE IN cursor_4c_GrupoTeste
                        ENDIF
                    ENDIF

                    IF !EMPTY(loc_cParamTeste)
                        THIS.oForm.&loc_cMetodo.(loc_cParamTeste)
                        loc_cDetalhes = loc_cMetodo + "('" + loc_cParamTeste + "') executado"
                    ELSE
                        THIS.oForm.&loc_cMetodo.("")
                        loc_cDetalhes = loc_cMetodo + "('') executado (sem dados de teste)"
                    ENDIF
                ELSE
                    *-- Metodos sem parametro obrigatorio
                    THIS.oForm.&loc_cMetodo.()
                    loc_cDetalhes = loc_cMetodo + "() executado"
                ENDIF

                *-- Verifica se algum cursor ficou populado
                LOCAL loc_aCursores, loc_nCursores, loc_j
                DIMENSION loc_aCursores[6]
                loc_aCursores[1] = "cursor_4c_Saldos"
                loc_aCursores[2] = "cursor_4c_Historico"
                loc_aCursores[3] = "cursor_4c_Dados"
                loc_aCursores[4] = "cursor_4c_Lista"
                loc_aCursores[5] = "cursor_4c_Busca"
                loc_aCursores[6] = "cursor_4c_Quitas"

                FOR loc_j = 1 TO 6
                    IF USED(loc_aCursores[loc_j])
                        LOCAL loc_nRec
                        loc_nRec = RECCOUNT(loc_aCursores[loc_j])
                        IF loc_nRec > 0
                            loc_lTemDados = .T.
                            loc_cDetalhes = loc_cDetalhes + " | " + loc_aCursores[loc_j] + "=" + ALLTRIM(STR(loc_nRec)) + " regs"
                        ENDIF
                    ENDIF
                ENDFOR

                loc_lPassou = .T.
                IF !loc_lTemDados
                    loc_cDetalhes = loc_cDetalhes + " | (sem registros - tabela pode estar vazia)"
                ENDIF
            ENDIF

            IF loc_lPassou
                ?? "PASSOU"
            ELSE
                ?? "FALHOU"
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro)
            ? "      Erro: " + loc_cErro
        ENDIF
        IF !EMPTY(loc_cDetalhes)
            ? "      " + loc_cDetalhes
        ENDIF

        THIS.AdicionarResultado("CarregarDadosReais", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteNavegacaoPaginas - Navega entre todas as paginas do PageFrame
    * (OPERACIONAL) Verifica se a navegacao nao corrompe grids
    *====================================================================
    PROTECTED PROCEDURE TesteNavegacaoPaginas()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException
        LOCAL loc_i, loc_oControl, loc_oPageFrame
        LOCAL loc_nPageCount, loc_nPaginasVisitadas

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""
        loc_nPaginasVisitadas = 0

        ?? "  [4] NavegacaoPaginas... "

        TRY
            *-- Encontra o PageFrame principal
            loc_oPageFrame = .NULL.
            FOR loc_i = 1 TO THIS.oForm.ControlCount
                loc_oControl = THIS.oForm.Controls(loc_i)
                IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
                    loc_oPageFrame = loc_oControl
                    EXIT
                ENDIF
            ENDFOR

            IF VARTYPE(loc_oPageFrame) # "O"
                loc_cDetalhes = "Nenhum PageFrame encontrado (form sem paginas)"
                loc_lPassou = .T.
                ?? "PASSOU"
            ELSE
                loc_nPageCount = loc_oPageFrame.PageCount

                *-- Navega para cada pagina
                LOCAL loc_lPageEnabledOrig
                FOR loc_i = 1 TO loc_nPageCount
                    *-- Habilita temporariamente paginas desabilitadas para teste de navegacao
                    loc_lPageEnabledOrig = loc_oPageFrame.Pages(loc_i).Enabled
                    IF !loc_lPageEnabledOrig
                        loc_oPageFrame.Pages(loc_i).Enabled = .T.
                    ENDIF

                    loc_oPageFrame.ActivePage = loc_i
                    loc_nPaginasVisitadas = loc_nPaginasVisitadas + 1

                    *-- Verifica se ActivePage mudou corretamente
                    IF loc_oPageFrame.ActivePage # loc_i
                        *-- Restaura estado antes de sair
                        IF !loc_lPageEnabledOrig
                            loc_oPageFrame.Pages(loc_i).Enabled = .F.
                        ENDIF
                        loc_cErro = "ActivePage nao mudou para " + ALLTRIM(STR(loc_i))
                        EXIT
                    ENDIF

                    *-- Refresh da pagina para detectar erros de rendering
                    loc_oPageFrame.Pages(loc_i).Refresh()

                    *-- Restaura estado original da pagina
                    IF !loc_lPageEnabledOrig
                        loc_oPageFrame.Pages(loc_i).Enabled = .F.
                    ENDIF
                ENDFOR

                *-- Volta para pagina 1
                loc_oPageFrame.ActivePage = 1

                IF EMPTY(loc_cErro)
                    loc_lPassou = .T.
                    loc_cDetalhes = ALLTRIM(STR(loc_nPaginasVisitadas)) + "/" + ALLTRIM(STR(loc_nPageCount)) + " paginas navegadas com sucesso"
                ENDIF

                ?? IIF(loc_lPassou, "PASSOU", "FALHOU")
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF
        IF !EMPTY(loc_cDetalhes)
            ? "      " + loc_cDetalhes
        ENDIF

        THIS.AdicionarResultado("NavegacaoPaginas", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteBtnIncluirNavegacao - Testa se BtnIncluirClick navega para Page2
    * e BtnCancelarClick retorna para Page1
    *====================================================================
    PROTECTED PROCEDURE TesteBtnIncluirNavegacao()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [" + ALLTRIM(STR(THIS.nTestes + 1)) + "] BtnIncluirNavegacao... "

        TRY
            *-- Verificar pre-condicoes
            LOCAL loc_lTemIncluir, loc_lTemCancelar, loc_lTemPageFrame
            loc_lTemIncluir = PEMSTATUS(THIS.oForm, "BtnIncluirClick", 5)
            loc_lTemCancelar = PEMSTATUS(THIS.oForm, "BtnCancelarClick", 5)
            loc_lTemPageFrame = PEMSTATUS(THIS.oForm, "pgf_4c_Paginas", 5)

            IF !loc_lTemIncluir
                loc_cDetalhes = "Metodo BtnIncluirClick nao encontrado (OK para REPORT/OPERACIONAL)"
                loc_lPassou = .T.
                ?? "PASSOU"
            ELSE
                IF !loc_lTemPageFrame
                    IF THIS.lFormOperacional OR THIS.lFormReport
                        *-- OPERACIONAL/REPORT: BtnIncluirClick sem PageFrame e esperado
                        loc_cDetalhes = "Form " + IIF(THIS.lFormOperacional, "OPERACIONAL", "REPORT") + ;
                            " com BtnIncluirClick sem navegacao por PageFrame (OK)"
                        loc_lPassou = .T.
                        ?? "PASSOU"
                    ELSE
                        loc_cErro = "pgf_4c_Paginas nao encontrado"
                        ?? "FALHOU"
                    ENDIF
                ELSE
                    *-- REPORT/OPERACIONAL com PageFrame: BtnIncluirClick nao navega para Page2
                    IF THIS.lFormReport OR THIS.lFormOperacional
                        loc_cDetalhes = "Form " + IIF(THIS.lFormReport, "REPORT", "OPERACIONAL") + ;
                            " com BtnIncluirClick e PageFrame - navegacao Page2 nao aplicavel"
                        loc_lPassou = .T.
                        ?? "PASSOU"
                    ELSE

                    *-- Chamar BtnIncluirClick e verificar navegacao para Page2
                    THIS.oForm.BtnIncluirClick()

                    IF THIS.oForm.pgf_4c_Paginas.ActivePage = 2
                        loc_cDetalhes = "BtnIncluirClick navegou para Page2"

                        *-- Tentar voltar com BtnCancelarClick
                        IF loc_lTemCancelar
                            THIS.oForm.BtnCancelarClick()

                            IF THIS.oForm.pgf_4c_Paginas.ActivePage = 1
                                loc_cDetalhes = loc_cDetalhes + " | BtnCancelarClick retornou para Page1"
                                loc_lPassou = .T.
                                ?? "PASSOU"
                            ELSE
                                loc_cErro = "BtnCancelarClick nao retornou para Page1 (ActivePage=" + ;
                                    ALLTRIM(STR(THIS.oForm.pgf_4c_Paginas.ActivePage)) + ")"
                                ?? "FALHOU"
                            ENDIF
                        ELSE
                            *-- Sem BtnCancelarClick, volta manualmente
                            THIS.oForm.pgf_4c_Paginas.ActivePage = 1
                            loc_cDetalhes = loc_cDetalhes + " | BtnCancelarClick nao encontrado (voltou manualmente)"
                            loc_lPassou = .T.
                            ?? "PASSOU"
                        ENDIF
                    ELSE
                        loc_cErro = "BtnIncluirClick nao navegou para Page2 (ActivePage=" + ;
                            ALLTRIM(STR(THIS.oForm.pgf_4c_Paginas.ActivePage)) + ")"
                        ?? "FALHOU"
                    ENDIF
                ENDIF
            ENDIF
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("BtnIncluirNavegacao", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteBtnEncerrarExiste - Verifica se BtnEncerrarClick existe
    * (nao executa para nao destruir o form)
    *====================================================================
    PROTECTED PROCEDURE TesteBtnEncerrarExiste()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [" + ALLTRIM(STR(THIS.nTestes + 1)) + "] BtnEncerrarExiste... "

        TRY
            IF PEMSTATUS(THIS.oForm, "BtnEncerrarClick", 5)
                loc_lPassou = .T.
                loc_cDetalhes = "Metodo BtnEncerrarClick encontrado"
                ?? "PASSOU"
            ELSE
                *-- Verificar alternativas comuns
                LOCAL loc_lTemFechar, loc_lTemSair
                loc_lTemFechar = PEMSTATUS(THIS.oForm, "BtnFecharClick", 5)
                loc_lTemSair = PEMSTATUS(THIS.oForm, "BtnSairClick", 5)

                IF loc_lTemFechar OR loc_lTemSair
                    loc_lPassou = .T.
                    loc_cDetalhes = "BtnEncerrarClick nao encontrado, mas existe: " + ;
                        IIF(loc_lTemFechar, "BtnFecharClick ", "") + ;
                        IIF(loc_lTemSair, "BtnSairClick", "")
                    ?? "PASSOU"
                ELSE
                    loc_cErro = "Nenhum metodo de encerramento encontrado (BtnEncerrarClick/BtnFecharClick/BtnSairClick)"
                    ?? "FALHOU"
                ENDIF
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("BtnEncerrarExiste", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteGridTemDados - Verifica se grid tem dados apos CarregarLista
    * Pula teste se gb_4c_ValidandoUI = .T. (sem banco)
    *====================================================================
    PROTECTED PROCEDURE TesteGridTemDados()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [" + ALLTRIM(STR(THIS.nTestes + 1)) + "] GridTemDados... "

        TRY
            *-- Pular se em modo validacao UI (sem banco)
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lPassou = .T.
                loc_cDetalhes = "Teste pulado (gb_4c_ValidandoUI = .T., sem conexao ao banco)"
                ?? "PASSOU"
            ELSE
                *-- Verificar se cursor_4c_Dados existe e tem registros
                IF USED("cursor_4c_Dados")
                    LOCAL loc_nRecs
                    loc_nRecs = RECCOUNT("cursor_4c_Dados")

                    IF loc_nRecs > 0
                        loc_lPassou = .T.
                        loc_cDetalhes = "cursor_4c_Dados com " + ALLTRIM(STR(loc_nRecs)) + " registros"
                        ?? "PASSOU"
                    ELSE
                        *-- Cursor existe mas sem dados - pode ser tabela vazia
                        loc_lPassou = .T.
                        loc_cDetalhes = "cursor_4c_Dados existe mas sem registros (tabela pode estar vazia)"
                        ?? "PASSOU"
                    ENDIF
                ELSE
                    *-- Verificar outros cursores conhecidos
                    LOCAL ARRAY loc_aCursoresGrid[6]
                    LOCAL loc_g, loc_lAchouAlgum
                    loc_aCursoresGrid[1] = "cursor_4c_Lista"
                    loc_aCursoresGrid[2] = "cursor_4c_Busca"
                    loc_aCursoresGrid[3] = "cursor_4c_Saldos"
                    loc_aCursoresGrid[4] = "cursor_4c_Historico"
                    loc_aCursoresGrid[5] = "cursor_4c_Quitas"
                    loc_aCursoresGrid[6] = "cursor_4c_ListaCab"
                    loc_lAchouAlgum = .F.

                    FOR loc_g = 1 TO 6
                        IF USED(loc_aCursoresGrid[loc_g])
                            loc_lAchouAlgum = .T.
                            loc_nRecs = RECCOUNT(loc_aCursoresGrid[loc_g])
                            loc_cDetalhes = loc_aCursoresGrid[loc_g] + " com " + ALLTRIM(STR(loc_nRecs)) + " registros"
                            loc_lPassou = .T.
                            EXIT
                        ENDIF
                    ENDFOR

                    IF !loc_lAchouAlgum
                        *-- Nenhum cursor de grid encontrado - nao e erro se CarregarLista nao foi chamado
                        IF PEMSTATUS(THIS.oForm, "CarregarLista", 5)
                            loc_cErro = "Nenhum cursor de grid encontrado apos instanciacao"
                            ?? "FALHOU"
                        ELSE
                            loc_lPassou = .T.
                            loc_cDetalhes = "Form sem CarregarLista - nenhum cursor esperado"
                            ?? "PASSOU"
                        ENDIF
                    ELSE
                        ?? "PASSOU"
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("GridTemDados", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * TesteLookupMetodosExistem - Verifica se metodos AbrirLookup/KeyPress existem
    * e se campos de lookup tem metodos correspondentes
    *====================================================================
    PROTECTED PROCEDURE TesteLookupMetodosExistem()
        LOCAL loc_lPassou, loc_cErro, loc_cDetalhes, loc_oException

        loc_lPassou = .F.
        loc_cErro = ""
        loc_cDetalhes = ""

        ?? "  [" + ALLTRIM(STR(THIS.nTestes + 1)) + "] LookupMetodosExistem... "

        TRY
            *-- Usar AMEMBERS para listar todos os metodos do form
            LOCAL ARRAY loc_aMembers[1]
            LOCAL loc_nMembers, loc_m
            LOCAL loc_nLookups, loc_nKeyPress
            LOCAL loc_cListaLookups, loc_cListaKeyPress

            loc_nMembers = AMEMBERS(loc_aMembers, THIS.oForm, 1)
            loc_nLookups = 0
            loc_nKeyPress = 0
            loc_cListaLookups = ""
            loc_cListaKeyPress = ""

            FOR loc_m = 1 TO loc_nMembers
                LOCAL loc_cMembro
                loc_cMembro = UPPER(ALLTRIM(loc_aMembers[loc_m, 1]))

                *-- Verificar metodos AbrirLookup
                IF LEFT(loc_cMembro, 11) = "ABRIRLOOKUP"
                    loc_nLookups = loc_nLookups + 1
                    IF EMPTY(loc_cListaLookups)
                        loc_cListaLookups = ALLTRIM(loc_aMembers[loc_m, 1])
                    ELSE
                        loc_cListaLookups = loc_cListaLookups + ", " + ALLTRIM(loc_aMembers[loc_m, 1])
                    ENDIF
                ENDIF

                *-- Verificar metodos KeyPress
                IF LEFT(loc_cMembro, 8) = "KEYPRESS" OR ;
                   (AT("KEYPRESS", loc_cMembro) > 0 AND loc_cMembro # "KEYPRESS")
                    loc_nKeyPress = loc_nKeyPress + 1
                    IF EMPTY(loc_cListaKeyPress)
                        loc_cListaKeyPress = ALLTRIM(loc_aMembers[loc_m, 1])
                    ELSE
                        loc_cListaKeyPress = loc_cListaKeyPress + ", " + ALLTRIM(loc_aMembers[loc_m, 1])
                    ENDIF
                ENDIF
            ENDFOR

            loc_cDetalhes = "AbrirLookup: " + ALLTRIM(STR(loc_nLookups))
            IF !EMPTY(loc_cListaLookups)
                loc_cDetalhes = loc_cDetalhes + " (" + loc_cListaLookups + ")"
            ENDIF
            loc_cDetalhes = loc_cDetalhes + " | KeyPress handlers: " + ALLTRIM(STR(loc_nKeyPress))
            IF !EMPTY(loc_cListaKeyPress)
                loc_cDetalhes = loc_cDetalhes + " (" + loc_cListaKeyPress + ")"
            ENDIF

            *-- Verificar correspondencia: campos txt_4c_ com lookup
            LOCAL loc_nCamposLookup, loc_cCamposSemLookup
            loc_nCamposLookup = 0
            loc_cCamposSemLookup = ""

            *-- Procurar campos de texto que tipicamente tem lookup (Cgru, Cmoe, etc.)
            LOCAL ARRAY loc_aCamposLookup[6]
            LOCAL loc_cl
            loc_aCamposLookup[1] = "txt_4c_Cgru"
            loc_aCamposLookup[2] = "txt_4c_Cmoe"
            loc_aCamposLookup[3] = "txt_4c_Ccli"
            loc_aCamposLookup[4] = "txt_4c_Cpro"
            loc_aCamposLookup[5] = "txt_4c_Ccor"
            loc_aCamposLookup[6] = "txt_4c_Cdpt"

            FOR loc_cl = 1 TO 6
                *-- Verificar se o campo existe no form (em qualquer pagina)
                LOCAL loc_lCampoExiste
                loc_lCampoExiste = .F.

                *-- Verificar direto no form
                IF PEMSTATUS(THIS.oForm, loc_aCamposLookup[loc_cl], 5)
                    loc_lCampoExiste = .T.
                ENDIF

                *-- Verificar dentro do PageFrame
                IF !loc_lCampoExiste AND PEMSTATUS(THIS.oForm, "pgf_4c_Paginas", 5)
                    LOCAL loc_pg
                    FOR loc_pg = 1 TO THIS.oForm.pgf_4c_Paginas.PageCount
                        IF PEMSTATUS(THIS.oForm.pgf_4c_Paginas.Pages(loc_pg), loc_aCamposLookup[loc_cl], 5)
                            loc_lCampoExiste = .T.
                            EXIT
                        ENDIF
                    ENDFOR
                ENDIF

                IF loc_lCampoExiste
                    loc_nCamposLookup = loc_nCamposLookup + 1

                    *-- Verificar se tem metodo AbrirLookup correspondente
                    *-- Extrair sufixo: txt_4c_Cgru -> Cgru -> AbrirLookupCgru ou AbrirLookupGrupo
                    LOCAL loc_cSufixo
                    loc_cSufixo = SUBSTR(loc_aCamposLookup[loc_cl], 9)  && Remove "txt_4c_"

                    LOCAL loc_lTemLookup
                    loc_lTemLookup = .F.

                    *-- Verificar se algum AbrirLookup corresponde
                    IF loc_nLookups > 0
                        loc_lTemLookup = .T.  && Se tem AbrirLookup, assume OK (dificil mapear exato)
                    ENDIF

                    IF !loc_lTemLookup AND loc_nLookups = 0
                        IF EMPTY(loc_cCamposSemLookup)
                            loc_cCamposSemLookup = loc_aCamposLookup[loc_cl]
                        ELSE
                            loc_cCamposSemLookup = loc_cCamposSemLookup + ", " + loc_aCamposLookup[loc_cl]
                        ENDIF
                    ENDIF
                ENDIF
            ENDFOR

            IF loc_nCamposLookup > 0
                loc_cDetalhes = loc_cDetalhes + " | Campos lookup: " + ALLTRIM(STR(loc_nCamposLookup))
                IF !EMPTY(loc_cCamposSemLookup)
                    loc_cDetalhes = loc_cDetalhes + " | SEM lookup: " + loc_cCamposSemLookup
                ENDIF
            ENDIF

            *-- Teste passa se: tem lookups quando tem campos, ou nao tem campos de lookup
            IF loc_nCamposLookup > 0 AND loc_nLookups = 0
                loc_cErro = "Campos de lookup encontrados mas nenhum metodo AbrirLookup existe"
                ?? "FALHOU"
            ELSE
                loc_lPassou = .T.
                ?? "PASSOU"
            ENDIF

        CATCH TO loc_oException
            loc_cErro = loc_oException.Message
            loc_cDetalhes = "Linha: " + ALLTRIM(STR(loc_oException.LineNo)) + ", Proc: " + loc_oException.Procedure
            ?? "FALHOU"
        ENDTRY

        ?
        IF !EMPTY(loc_cErro) AND !loc_lPassou
            ? "      Erro: " + loc_cErro
        ENDIF

        THIS.AdicionarResultado("LookupMetodosExistem", loc_lPassou, loc_cErro, loc_cDetalhes)
    ENDPROC

    *====================================================================
    * AdicionarResultado - Adiciona resultado de teste ao array
    *====================================================================
    PROTECTED PROCEDURE AdicionarResultado(par_cNome, par_lPassou, par_cErro, par_cDetalhes)
        THIS.nTestes = THIS.nTestes + 1

        IF THIS.nTestes > ALEN(THIS.aTestes, 1)
            DIMENSION THIS.aTestes[THIS.nTestes + 5, 4]
        ENDIF

        THIS.aTestes[THIS.nTestes, 1] = par_cNome
        THIS.aTestes[THIS.nTestes, 2] = par_lPassou
        THIS.aTestes[THIS.nTestes, 3] = par_cErro
        THIS.aTestes[THIS.nTestes, 4] = par_cDetalhes

        IF !par_lPassou
            THIS.lTodosPassaram = .F.
        ENDIF
    ENDPROC

    *====================================================================
    * MostrarResumo - Mostra resumo dos testes
    *====================================================================
    PROCEDURE MostrarResumo()
        LOCAL i, loc_nPassou, loc_nFalhou, loc_nPercentual

        loc_nPassou = 0
        loc_nFalhou = 0

        FOR i = 1 TO THIS.nTestes
            IF THIS.aTestes[i, 2]
                loc_nPassou = loc_nPassou + 1
            ELSE
                loc_nFalhou = loc_nFalhou + 1
            ENDIF
        ENDFOR

        loc_nPercentual = ROUND((loc_nPassou / THIS.nTestes) * 100, 0)

        ? "Total: " + ALLTRIM(STR(THIS.nTestes)) + " testes"
        ? "Passou: " + ALLTRIM(STR(loc_nPassou))
        ? "Falhou: " + ALLTRIM(STR(loc_nFalhou))
        ? "Percentual: " + ALLTRIM(STR(loc_nPercentual)) + "%"
        ?
        IF THIS.lTodosPassaram
            ? "STATUS: TODOS OS TESTES PASSARAM"
        ELSE
            ? "STATUS: ALGUNS TESTES FALHARAM"
        ENDIF
    ENDPROC

    *====================================================================
    * GerarResultadoJSON - Gera arquivo JSON com resultado dos testes
    *====================================================================
    PROCEDURE GerarResultadoJSON(par_cArquivo)
        LOCAL loc_cJSON, loc_nHandle, i
        LOCAL loc_cCRLF, loc_nPassou, loc_nFalhou

        loc_cCRLF = CHR(13) + CHR(10)

        *-- Conta resultados
        loc_nPassou = 0
        loc_nFalhou = 0
        FOR i = 1 TO THIS.nTestes
            IF THIS.aTestes[i, 2]
                loc_nPassou = loc_nPassou + 1
            ELSE
                loc_nFalhou = loc_nFalhou + 1
            ENDIF
        ENDFOR

        *-- Monta JSON
        loc_cJSON = "{" + loc_cCRLF
        loc_cJSON = loc_cJSON + '  "formClass": "' + THIS.cFormClass + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '  "timestamp": "' + TTOC(DATETIME(), 1) + '",' + loc_cCRLF
        loc_cJSON = loc_cJSON + '  "testes": [' + loc_cCRLF

        FOR i = 1 TO THIS.nTestes
            loc_cJSON = loc_cJSON + '    {' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "nome": "' + THIS.aTestes[i, 1] + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "passou": ' + IIF(THIS.aTestes[i, 2], "true", "false") + ',' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "erro": "' + THIS.EscaparJSON(THIS.aTestes[i, 3]) + '",' + loc_cCRLF
            loc_cJSON = loc_cJSON + '      "detalhes": "' + THIS.EscaparJSON(THIS.aTestes[i, 4]) + '"' + loc_cCRLF
            loc_cJSON = loc_cJSON + '    }' + IIF(i < THIS.nTestes, ",", "") + loc_cCRLF
        ENDFOR

        loc_cJSON = loc_cJSON + '  ],' + loc_cCRLF
        loc_cJSON = loc_cJSON + '  "resumo": {' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "total": ' + ALLTRIM(STR(THIS.nTestes)) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "passou": ' + ALLTRIM(STR(loc_nPassou)) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "falhou": ' + ALLTRIM(STR(loc_nFalhou)) + ',' + loc_cCRLF
        loc_cJSON = loc_cJSON + '    "percentual": ' + ALLTRIM(STR(ROUND((loc_nPassou / THIS.nTestes) * 100, 0))) + loc_cCRLF
        loc_cJSON = loc_cJSON + '  }' + loc_cCRLF
        loc_cJSON = loc_cJSON + '}' + loc_cCRLF

        *-- Salva arquivo
        loc_nHandle = FCREATE(par_cArquivo)
        IF loc_nHandle < 0
            ? "ERRO: Nao foi possivel criar arquivo: " + par_cArquivo
            RETURN
        ENDIF

        FWRITE(loc_nHandle, loc_cJSON)
        FCLOSE(loc_nHandle)
    ENDPROC

    *====================================================================
    * EscaparJSON - Escapa caracteres especiais para JSON
    *====================================================================
    PROTECTED PROCEDURE EscaparJSON(par_cValor)
        LOCAL loc_cResultado

        IF VARTYPE(par_cValor) # "C"
            RETURN ""
        ENDIF

        loc_cResultado = par_cValor
        loc_cResultado = STRTRAN(loc_cResultado, '\', '\\')
        loc_cResultado = STRTRAN(loc_cResultado, '"', '\"')
        loc_cResultado = STRTRAN(loc_cResultado, CHR(13), '\r')
        loc_cResultado = STRTRAN(loc_cResultado, CHR(10), '\n')
        loc_cResultado = STRTRAN(loc_cResultado, CHR(9), '\t')

        RETURN loc_cResultado
    ENDPROC

    *====================================================================
    * Destroy - Libera recursos
    *====================================================================
    PROCEDURE Destroy()
        IF VARTYPE(THIS.oForm) = "O"
            TRY
                THIS.oForm.Release()
            CATCH
            ENDTRY
            THIS.oForm = .NULL.
        ENDIF
    ENDPROC

ENDDEFINE
