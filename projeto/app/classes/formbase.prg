*==============================================================================
* FORMBASE.PRG
* Classe base para formularios da aplicacao
* Responsabilidade: interface do usuario, bindings, controle de estado visual
*==============================================================================

DEFINE CLASS FormBase AS Form

    *-- Propriedades (nomenclatura: this_ + tipo)
    this_oBusinessObject = .NULL.   && Objeto de negocio associado
    this_lEmEdicao = .F.            && Indica se esta em modo de edicao
    this_cTituloForm = ""           && Titulo do formulario
    this_lNovoRegistro = .F.        && Indica se e novo registro
    this_cModoAtual = "LISTA"       && Modo atual: LISTA, INCLUIR, ALTERAR, VISUALIZAR
    this_cMensagemErro = ""         && Mensagem de erro capturada no Init

    *-- Configuracoes visuais padrao
    AutoCenter = .T.
    BorderStyle = 2            && Sizable
    MaxButton = .T.
    MinButton = .T.
    ShowTips = .T.

    *--------------------------------------------------------------------------
    * INIT - Inicializacao do formulario
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL llSucesso

        * Desativa confirmacao de ZAP/DELETE (evita travamento fora do main.prg)
        SET SAFETY OFF

        * Forca formato brasileiro de data na datasession do form
        * (forms com DataSession=2 ganham datasession privada com SETs default
        * AMERICAN/CENTURY OFF - causa "05/25/26" em vez de "25/05/2026")
        SET DATE TO BRITISH
        SET CENTURY ON
        SET CENTURY TO 19 ROLLOVER 50
        SET MARK TO "/"

        * Configura titulo se definido
        IF !EMPTY(THIS.this_cTituloForm)
            THIS.Caption = THIS.this_cTituloForm
        ENDIF

        * Chama inicializacao especifica da subclasse
        LOCAL loc_oInitErr
        TRY
            llSucesso = THIS.InicializarForm()
        CATCH TO loc_oInitErr
            llSucesso = .F.
            THIS.this_cMensagemErro = loc_oInitErr.Message
            MsgErro("Erro ao inicializar form: " + loc_oInitErr.Message + ;
                " | Linha: " + TRANSFORM(loc_oInitErr.LineNo) + ;
                " | Proc: " + loc_oInitErr.Procedure)
        ENDTRY

        * Se a inicializacao falhou, gravar detalhes para diagnostico e cancelar
        IF !llSucesso
            IF TYPE("gc_4c_ArquivoErroTeste") = "C" AND !EMPTY(gc_4c_ArquivoErroTeste)
                IF !EMPTY(THIS.this_cMensagemErro)
                    LOCAL loc_nHErr
                    loc_nHErr = FCREATE(gc_4c_ArquivoErroTeste)
                    IF loc_nHErr > 0
                        FPUTS(loc_nHErr, "FormBase.Init FALHOU - InicializarForm retornou .F.")
                        FPUTS(loc_nHErr, "Form: " + THIS.Name)
                        FPUTS(loc_nHErr, "Erro: " + THIS.this_cMensagemErro)
                        FCLOSE(loc_nHErr)
                    ENDIF
                ENDIF
            ENDIF
            RETURN .F.
        ENDIF

        * Atualiza estado inicial dos controles
        THIS.AtualizarEstadoControles()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarForm - Hook para inicializacao especifica
    * Subclasses devem sobrescrever este metodo
    * IMPORTANTE: Deve retornar .T. se sucesso, .F. se falha
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarForm()
        * Subclasses implementam suas inicializacoes especificas aqui
        * Ex: instanciar Business Object, configurar grid, etc.
        RETURN .T.  && Retorna sucesso por padrao
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarEstadoControles - Atualiza habilitacao/desabilitacao de controles
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarEstadoControles()
        * Este metodo deve ser sobrescrito nas subclasses para controlar
        * o estado dos botoes e campos conforme o modo (consulta/edicao)

        * Exemplo de logica padrao:
        * - Em modo edicao: habilita campos, desabilita busca
        * - Em modo consulta: desabilita campos, habilita busca
    ENDPROC

    *--------------------------------------------------------------------------
    * IniciarEdicao - Entra em modo de edicao
    *--------------------------------------------------------------------------
    PROCEDURE IniciarEdicao()
        THIS.this_lEmEdicao = .T.
        THIS.AtualizarEstadoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * EncerrarEdicao - Sai do modo de edicao
    *--------------------------------------------------------------------------
    PROCEDURE EncerrarEdicao()
        THIS.this_lEmEdicao = .F.
        THIS.AtualizarEstadoControles()
    ENDPROC

    *--------------------------------------------------------------------------
    * Novo - Inicia inclusao de novo registro
    *--------------------------------------------------------------------------
    PROCEDURE Novo()
        IF ISNULL(THIS.this_oBusinessObject)
            THIS.MostrarMensagem("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o inicializado", "Erro", 16)
            RETURN .F.
        ENDIF

        * Limpa campos do formulario
        THIS.LimparCampos()

        * Prepara Business Object para novo registro
        THIS.this_oBusinessObject.NovoRegistro()

        * Entra em modo de edicao
        THIS.IniciarEdicao()

        * Posiciona no primeiro campo editavel
        THIS.PosicionarPrimeiroCampo()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Salvar - Salva alteracoes
    *--------------------------------------------------------------------------
    PROCEDURE Salvar()
        LOCAL llResultado

        IF ISNULL(THIS.this_oBusinessObject)
            THIS.MostrarMensagem("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o inicializado", "Erro", 16)
            RETURN .F.
        ENDIF

        * Transfere dados do formulario para o Business Object
        THIS.FormParaBO()

        * Tenta salvar
        llResultado = THIS.this_oBusinessObject.Salvar()

        IF llResultado
            THIS.MostrarMensagem("Registro salvo com sucesso!", "Sucesso", 64)
            THIS.EncerrarEdicao()

            * Hook para acoes pos-salvamento
            THIS.DepoisDeSalvar()
        ELSE
            * Exibe mensagem de erro do Business Object
            THIS.MostrarMensagem(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro", 16)
        ENDIF

        RETURN llResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Excluir - Exclui registro atual
    *--------------------------------------------------------------------------
    PROCEDURE Excluir()
        LOCAL llResultado, lnResposta

        IF ISNULL(THIS.this_oBusinessObject)
            THIS.MostrarMensagem("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o inicializado", "Erro", 16)
            RETURN .F.
        ENDIF

        * Confirma exclusao
        lnResposta = MESSAGEBOX("Confirma a exclus" + CHR(227) + "o deste registro?", ;
                                36, ;
                                "Confirma" + CHR(231) + CHR(227) + "o")

        IF lnResposta != 6  && 6 = Sim
            RETURN .F.
        ENDIF

        * Tenta excluir
        llResultado = THIS.this_oBusinessObject.Excluir()

        IF llResultado
            THIS.MostrarMensagem("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso", 64)
            THIS.LimparCampos()
            THIS.DepoisDeExcluir()
        ELSE
            THIS.MostrarMensagem(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro", 16)
        ENDIF

        RETURN llResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Cancelar - Cancela edicao em andamento
    *--------------------------------------------------------------------------
    PROCEDURE Cancelar()
        LOCAL lnResposta

        IF THIS.this_lEmEdicao
            * Confirma cancelamento se houver alteracoes
            IF !ISNULL(THIS.this_oBusinessObject) AND THIS.this_oBusinessObject.this_lDadosAlterados
                lnResposta = MESSAGEBOX("H" + CHR(225) + " altera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o salvas. Deseja cancelar?", ;
                                        36, ;
                                        "Confirma" + CHR(231) + CHR(227) + "o")

                IF lnResposta != 6  && 6 = Sim
                    RETURN .F.
                ENDIF
            ENDIF

            * Cancela no Business Object
            IF !ISNULL(THIS.this_oBusinessObject)
                THIS.this_oBusinessObject.CancelarEdicao()
            ENDIF

            THIS.EncerrarEdicao()

            * Restaura dados anteriores ou limpa formulario
            THIS.BOParaForm()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Fechar - Fecha o formulario
    *--------------------------------------------------------------------------
    PROCEDURE Fechar()
        * Verifica se ha edicao em andamento
        IF THIS.this_lEmEdicao
            IF !THIS.Cancelar()
                RETURN .F.
            ENDIF
        ENDIF

        THIS.Release()
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MostrarMensagem - Exibe mensagem ao usuario
    *--------------------------------------------------------------------------
    PROCEDURE MostrarMensagem(pcMensagem, pcTitulo, pnIcone)
        LOCAL lcTitulo, lnIcone

        lcTitulo = IIF(VARTYPE(pcTitulo) = "C", pcTitulo, "Aten" + CHR(231) + CHR(227) + "o")
        lnIcone = IIF(VARTYPE(pnIcone) = "N", pnIcone, 64)

        IF EscreverErroParaArquivo(pcMensagem, lcTitulo)
            RETURN
        ENDIF

        MESSAGEBOX(pcMensagem, lnIcone, lcTitulo)
    ENDPROC

    *--------------------------------------------------------------------------
    * METODOS PROTEGIDOS (a serem implementados nas subclasses)
    *--------------------------------------------------------------------------

    PROTECTED PROCEDURE LimparCampos()
        * Subclasses devem implementar limpeza de seus campos especificos
    ENDPROC

    PROTECTED PROCEDURE BOParaForm()
        * Subclasses devem implementar transferencia de dados
        * do Business Object para os campos do formulario
    ENDPROC

    PROTECTED PROCEDURE FormParaBO()
        * Subclasses devem implementar transferencia de dados
        * dos campos do formulario para o Business Object
    ENDPROC

    PROTECTED PROCEDURE PosicionarPrimeiroCampo()
        * Subclasses devem implementar para posicionar no primeiro campo editavel
    ENDPROC

    PROTECTED PROCEDURE DepoisDeSalvar()
        * Hook para acoes apos salvar com sucesso
        * Ex: atualizar grid, recarregar dados, etc.
    ENDPROC

    PROTECTED PROCEDURE DepoisDeExcluir()
        * Hook para acoes apos excluir com sucesso
        * Ex: atualizar grid, limpar campos, etc.
    ENDPROC

    *--------------------------------------------------------------------------
    * AlternarPagina - Alterna entre as paginas do PageFrame
    * par_nPagina: 1 = Lista, 2 = Dados
    *--------------------------------------------------------------------------
    PROCEDURE AlternarPagina(par_nPagina)
        IF TYPE("THIS.pgf_4c_Paginas") = "O" AND !ISNULL(THIS.pgf_4c_Paginas)
            IF BETWEEN(par_nPagina, 1, THIS.pgf_4c_Paginas.PageCount)
                THIS.pgf_4c_Paginas.ActivePage = par_nPagina
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * QueryUnload - Evento de fechamento do formulario
    *--------------------------------------------------------------------------
    PROCEDURE QueryUnload()
        * Verifica se pode fechar
        IF THIS.this_lEmEdicao
            RETURN !THIS.Cancelar()
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * DESTROY - Destrutor
    *
    * FIX menu-shrinks (Erro58, 2026-07-21):
    * Apos fechar qualquer form modal (WindowType=1 ShowWindow=1), VFP9 mantem
    * cache visual dos popups de _MSYSMENU. Sintoma: CNTBAR reporta bars intactos
    * (ex: popMovimentos=105) mas o popup renderiza apenas ~40 items com line-height
    * maior, resultando em popup visualmente encolhido.
    * Fix: RELEASE POPUP explicito (libera cache visual) + CriarMenuPrincipal
    * (idempotente, redefine popups do zero). SEM o RELEASE, CriarMenuPrincipal
    * sozinha nao restaura o rendering — os popups precisam ser destruidos antes.
    * TRY/CATCH silencioso porque CriarMenuPrincipal pode nao estar no escopo em
    * cenarios de teste automatizado ou em forms auxiliares (ex: FormBuscaAuxiliar).
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF !ISNULL(THIS.this_oBusinessObject)
            THIS.this_oBusinessObject = .NULL.
        ENDIF

        *-- Em modo de teste nao ha HWND nem menu system inicializado; SET SYSMENU TO DEFAULT
        *-- bloqueia em VFP9 -T sem GUI. Pular toda a restauracao do menu em testes.
        IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
            TRY
                *-- SET SYSMENU TO DEFAULT restaura os pads default do VFP (Edit/View/
                *-- Tools/Program/Window/Help) que podem ter sido removidos por
                *-- REPORT FORM PREVIEW ou por form modal com SET SYSMENU TO/OFF.
                *-- Sem isso, CriarMenuPrincipal recria apenas os 6 pads da app,
                *-- deixando menu com "menos telas" que o startup. Padrao proven:
                *-- Formsigtosen.prg:1074 (Erro63 refinamento 2026-07-24).
                SET SYSMENU TO DEFAULT
                RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
                CriarMenuPrincipal()
            CATCH
                *-- CriarMenuPrincipal nao carregada no escopo (form auxiliar) - silencioso
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * AbrirLookupCanonico - Helper que encapsula o padrao Pattern A do
    *   FormBuscaAuxiliar (Erro114 2026-08-13). Evita boilerplate de 40+ linhas
    *   em cada AbrirBusca<X> do form. Substitui o Pattern B defeituoso
    *   `CREATEOBJECT("FormBuscaAuxiliar", conn, tabela, cursor, campo, val, titulo)`.
    *
    * Parametros:
    *   par_cTabela      - Nome da tabela SQL (ex: "SigCdEmp", "SigCdCli", "SigCdMoe")
    *   par_cCampoCod    - Coluna do codigo (ex: "cemps", "iclis", "cmoes")
    *   par_cCampoDesc   - Coluna da descricao (ex: "razas", "rclis", "dmoes")
    *   par_cTitulo      - Titulo da janela (ex: "Selecao de Empresa")
    *   par_cValorFiltro - Prefixo digitado pelo usuario (busca com LIKE 'valor%').
    *                       Se vazio, lista tudo. Se nao bater, fallback SHOW-ALL.
    *   par_oTxtCod      - Objeto TextBox onde o codigo selecionado sera gravado.
    *   par_oTxtDesc     - Objeto TextBox onde a descricao selecionada sera gravada.
    *   par_cFiltroExtra - (opcional) WHERE adicional sem "AND" prefixo. Ex:
    *                       "Emps = '01'" ou "Grupos = 'X'". Aplicado nas 2 queries.
    *
    * Retorno: .T. se o usuario selecionou algum registro, .F. caso contrario.
    *
    * Exemplo de uso:
    *   THIS.AbrirLookupCanonico("SigCdEmp", "cemps", "razas", ;
    *       "Sele" + CHR(231) + CHR(227) + "o de Empresa", ;
    *       loc_cValorTypedByUser, ;
    *       loc_oPag.txt_4c_Empresa, ;
    *       loc_oPag.txt_4c_EmpresaDesc)
    *--------------------------------------------------------------------------
    PROCEDURE AbrirLookupCanonico(par_cTabela, par_cCampoCod, par_cCampoDesc, ;
                                   par_cTitulo, par_cValorFiltro, ;
                                   par_oTxtCod, par_oTxtDesc, par_cFiltroExtra)
        LOCAL loc_oLookup, loc_cSQL, loc_nResult, loc_cCursor, loc_oErro
        LOCAL loc_lSelecionou, loc_cWhereExtra
        loc_lSelecionou = .F.
        loc_cCursor     = "cursor_4c_LkpCanonico"

        loc_cWhereExtra = ""
        IF VARTYPE(par_cFiltroExtra) = "C" AND !EMPTY(par_cFiltroExtra)
            loc_cWhereExtra = " AND (" + par_cFiltroExtra + ")"
        ENDIF

        TRY
            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF

            *-- 1a query: filtro por prefixo em codigo OR descricao
            IF VARTYPE(par_cValorFiltro) = "C" AND !EMPTY(par_cValorFiltro)
                loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + ;
                           par_cCampoDesc + " AS Descs FROM " + par_cTabela + ;
                           " WHERE (" + par_cCampoCod + " LIKE " + ;
                           EscaparSQL(ALLTRIM(par_cValorFiltro) + "%") + ;
                           " OR " + par_cCampoDesc + " LIKE " + ;
                           EscaparSQL(ALLTRIM(par_cValorFiltro) + "%") + ")" + ;
                           loc_cWhereExtra + ;
                           " ORDER BY " + par_cCampoCod
            ELSE
                loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + ;
                           par_cCampoDesc + " AS Descs FROM " + par_cTabela + ;
                           IIF(EMPTY(loc_cWhereExtra), "", " WHERE 1=1" + loc_cWhereExtra) + ;
                           " ORDER BY " + par_cCampoCod
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)

            *-- 2a query (fallback SHOW-ALL): se prefixo nao bateu, mostra tudo
            IF loc_nResult > 0 AND RECCOUNT(loc_cCursor) = 0 AND ;
               VARTYPE(par_cValorFiltro) = "C" AND !EMPTY(par_cValorFiltro)
                IF USED(loc_cCursor)
                    USE IN SELECT(loc_cCursor)
                ENDIF
                loc_cSQL = "SELECT " + par_cCampoCod + " AS Cods, " + ;
                           par_cCampoDesc + " AS Descs FROM " + par_cTabela + ;
                           IIF(EMPTY(loc_cWhereExtra), "", " WHERE 1=1" + loc_cWhereExtra) + ;
                           " ORDER BY " + par_cCampoCod
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor)
            ENDIF

            IF loc_nResult > 0 AND USED(loc_cCursor) AND RECCOUNT(loc_cCursor) > 0
                loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar")
                IF VARTYPE(loc_oLookup) = "O"
                    loc_oLookup.DefinirCursor(loc_cCursor, "Cods", "Descs", par_cTitulo)
                    IF loc_oLookup.Mostrar()
                        IF VARTYPE(par_oTxtCod) = "O"
                            par_oTxtCod.Value = ALLTRIM(loc_oLookup.cCodigoSelecionado)
                        ENDIF
                        IF VARTYPE(par_oTxtDesc) = "O"
                            par_oTxtDesc.Value = ALLTRIM(loc_oLookup.cDescricaoSelecionada)
                        ENDIF
                        loc_lSelecionou = .T.
                    ENDIF
                ENDIF
            ELSE
                MsgAviso("Nenhum registro encontrado.", ;
                         IIF(VARTYPE(par_cTitulo) = "C", par_cTitulo, "Busca"))
            ENDIF

            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro no Lookup")
            IF USED(loc_cCursor)
                USE IN SELECT(loc_cCursor)
            ENDIF
        ENDTRY

        RETURN loc_lSelecionou
    ENDPROC

ENDDEFINE
