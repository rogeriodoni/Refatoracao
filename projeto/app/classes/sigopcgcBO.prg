*==============================================================================
* sigopcgcBO.prg - Business Object para Consulta Generica de Compras
* Origem: SIGOPCGC.SCX
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta/relatorio - nao eh CRUD de tabela unica)
*==============================================================================

DEFINE CLASS sigopcgcBO AS BusinessBase

    *-- Filtros de consulta (Pagina Consulta)
    this_nAnalise  = 1     && Opt_Analise: 1=Compra, 2=Venda (indice 1-based do OptionGroup)
    this_dDataI    = {}    && Get_Datai - data inicial do periodo de analise
    this_dDataF    = {}    && Get_Dataf - data final do periodo de analise
    this_cMoeda    = ""    && Get_Moeda - codigo da moeda (SigCdMoe.cmoes)
    this_cEmpresa  = ""    && Get_Empresa - codigo da empresa (SigCdEmp.Cemps)

    *-- Origem (grupo/conta/cpf do fornecedor pesquisado)
    this_cGrupo    = ""    && Origem.Get_grupo - grupo de contas (SigCdGcr.codigos)
    this_cConta    = ""    && Origem.Get_conta - conta do fornecedor (SigCdCli.iclis)
    this_cDConta   = ""    && Origem.Get_dconta - descricao/nome do fornecedor (auto-preenchido)
    this_cCpf      = ""    && Origem.Get_cpf - CPF ou CGC do fornecedor

    *-- Dados cadastrais do fornecedor (Pagina Resultado - Cadastro.Dados)
    this_cCodFor   = ""    && Get_codfor - codigo do fornecedor
    this_cNome     = ""    && Get_nome - razao social/nome
    this_cEnd      = ""    && Get_end - endereco
    this_cBairro   = ""    && Get_bairro - bairro
    this_cCid      = ""    && Get_cid - cidade
    this_cCep      = ""    && Get_cep - CEP
    this_cEst      = ""    && Get_est - UF
    this_cTel1     = ""    && Get_tel1 - telefone 1
    this_cTel2     = ""    && Get_tel2 - telefone 2
    this_cFax      = ""    && Get_fax - fax
    this_cCgc      = ""    && Get_cgc - CGC/CNPJ
    this_cIe       = ""    && Get_ie - inscricao estadual

    *-- Controle de fluxo (equivalentes as PUBLIC vars do legado: pcMensagem, _Fornece, _Moeda, _Produto, ConsultaExecutada)
    this_lConsultaExecutada = .F.   && ConsultaExecutada - evita reprocessar a mesma consulta
    this_lMensagem          = .F.   && pcMensagem - .T. = modo Movimento, .F. = modo Fornecedor (impressao)
    this_cFornece           = ""    && _Fornece - cabecalho formatado "Conta : Grupo / Conta [ Nome ]" para impressao
    this_cMoedaRelatorio    = ""    && _Moeda - moeda selecionada no momento da impressao
    this_cProdutoAtual      = ""    && _Produto - produto corrente (dbProdFor.cpros) ao trocar de linha na grade
    this_lAutomatico        = .F.   && Automatico - .T. quando o form foi aberto via parametro (fecha ao concluir)

    *-- Estado da agregacao do metodo Processa() do legado
    this_lSemDados   = .T.   && llSemDados - .T. enquanto nenhuma das 9 consultas devolveu linha
    this_nCotaConv   = 1     && lnCotaConv - cotacao da moeda do filtro, divisor de TODA conversao
    this_cFigJpg     = ""    && TmpCli.figjpgs - foto do fornecedor (coluna text de SigCdCli)
    this_nMFotos     = 0     && CrSigCdGcr.mfotos do grupo pesquisado - 1 = o grupo exibe foto

    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdCli"
        THIS.this_cCampoChave = "Iclis"
        DODEFAULT()

        *-- Legado: PROCEDURE Load cria os 8 cursores locais de resultado;
        *-- PROCEDURE Init carrega os 9 cursores de apoio (parametros do
        *-- sistema, empresas, operacoes, moedas, cotacoes...). Aqui as duas
        *-- coisas acontecem no Init do BO porque o form migrado nao tem
        *-- evento Load. NUNCA devolver .F. daqui: BO.Init() falso mata o
        *-- form (o CREATEOBJECT do menu recebe .F. e nada abre).
        THIS.InicializarCursoresDados()

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            THIS.InicializarCursoresApoio()
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os dados cadastrais do fornecedor pesquisado
    *
    * Espelha o bloco "With ThisForm.Fld_Principal.Pag_Resultado.Cadastro.Dados"
    * do metodo Processa() do legado (SIGOPCGC.SCX), que roda a query:
    *   Select iclis, rclis, endes, bairs, cidas, ceps, estas, tel1s, tel2s,
    *          faxs, cpfs, rgs From SigCdCli Where grupos = ? And iclis = ?
    * e atribui coluna a coluna aos campos Get_CodFor/Get_Nome/Get_End/...
    *
    * Os campos Get_Cgc e Get_Ie do legado NAO leem colunas cgcs/ies (SigCdCli
    * nao tem essas colunas) - eles reaproveitam cpfs e rgs. Transcrito
    * literalmente (regra #17 do CLAUDE.md) - nao "corrigir" para colunas
    * inexistentes no schema.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        THIS.this_cCodFor = TratarNulo(iclis, "")
        THIS.this_cNome   = TratarNulo(rclis, "")
        THIS.this_cEnd    = TratarNulo(endes, "")
        THIS.this_cBairro = TratarNulo(bairs, "")
        THIS.this_cCid    = TratarNulo(cidas, "")
        THIS.this_cCep    = TratarNulo(ceps,  "")
        THIS.this_cEst    = TratarNulo(estas, "")
        THIS.this_cTel1   = TratarNulo(tel1s, "")
        THIS.this_cTel2   = TratarNulo(tel2s, "")
        THIS.this_cFax    = TratarNulo(faxs,  "")
        THIS.this_cCgc    = TratarNulo(cpfs,  "")
        THIS.this_cIe     = TratarNulo(rgs,   "")

        *-- figjpgs (coluna text) - foto do fornecedor. O legado le a mesma
        *-- coluna no bloco final de Processa (Copy Memo TmpCli.figjpgs To
        *-- lcArquivo1) e so a exibe quando CrSigCdGcr.mfotos = 1.
        THIS.this_cFigJpg = TratarNulo(figjpgs, "")

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Codigo do fornecedor (SigCdCli.Iclis) atualmente
    * carregado nos campos cadastrais da Pagina Resultado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cCodFor, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Consulta os dados cadastrais do fornecedor (Grupo + Conta),
    * espelhando a query "TmpCli" do metodo Processa() do legado (SIGOPCGC.
    * SCX, linhas 4319-4360):
    *   Select iclis, rclis, endes, bairs, cidas, ceps, estas, tel1s, tel2s,
    *          faxs, cpfs, rgs From SigCdCli Where grupos = ? And iclis = ?
    *
    * Sobrescreve (nao chama DODEFAULT) porque BusinessBase.Buscar() exige
    * this_oDataAccess inicializado via Init(pcTabela) - este BO e de
    * CONSULTA customizada (SigOpCgc nao e cadastro CRUD de uma tabela so)
    * e nunca passou pcTabela para DODEFAULT() no Init.
    *
    * Conta nao encontrada NAO e falha de conexao - o legado so devolve
    * .F. quando o SqlExecute falha (Else zera os campos e segue adiante,
    * regra #17 - comportamento transcrito literalmente).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        IF USED("cursor_4c_Fornecedor")
            USE IN cursor_4c_Fornecedor
        ENDIF

        loc_cSQL = "SELECT iclis, rclis, endes, bairs, cidas, ceps, estas, " + ;
                   "tel1s, tel2s, faxs, cpfs, rgs, figjpgs FROM SigCdCli " + ;
                   "WHERE grupos = " + EscaparSQL(ALLTRIM(NVL(par_cGrupo, ""))) + ;
                   " AND iclis = " + EscaparSQL(ALLTRIM(NVL(par_cConta, "")))

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Fornecedor")

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = CapturarErroSQL()
        ELSE
            IF USED("cursor_4c_Fornecedor") AND RECCOUNT("cursor_4c_Fornecedor") > 0
                THIS.CarregarDoCursor("cursor_4c_Fornecedor")
            ELSE
                THIS.this_cCodFor = ""
                THIS.this_cNome   = ""
                THIS.this_cEnd    = ""
                THIS.this_cBairro = ""
                THIS.this_cCid    = ""
                THIS.this_cCep    = ""
                THIS.this_cEst    = ""
                THIS.this_cTel1   = ""
                THIS.this_cTel2   = ""
                THIS.this_cFax    = ""
                THIS.this_cCgc    = ""
                THIS.this_cIe     = ""
                THIS.this_cFigJpg = ""
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        IF USED("cursor_4c_Fornecedor")
            USE IN cursor_4c_Fornecedor
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * EmModoTeste - .T. quando o processo esta rodando sem usuario (harness de
    * teste automatizado ou ValidarUIFidelity). Usado para suprimir WAIT
    * WINDOW / barra de progresso, que em execucao headless ficariam na tela
    * sem ninguem para fechar.
    *
    * Os IFs sao ANINHADOS de proposito: VFP9 nao garante short-circuit, e
    * "TYPE('x') = 'L' AND x" avaliaria x mesmo quando a variavel nao existe.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION EmModoTeste()
        LOCAL loc_lTeste
        loc_lTeste = .F.

        IF TYPE("gb_4c_ModoTeste") = "L"
            loc_lTeste = gb_4c_ModoTeste
        ENDIF

        IF !loc_lTeste
            IF TYPE("gb_4c_ValidandoUI") = "L"
                loc_lTeste = gb_4c_ValidandoUI
            ENDIF
        ENDIF

        RETURN loc_lTeste
    ENDFUNC

    *--------------------------------------------------------------------------
    * MostrarProgresso / LimparProgresso - equivalentes aos
    * "Wait Window '...' NoWait" e ao "Wait Clear" do metodo Processa do
    * legado (Processando Saldos / Historico / Produtos / Consertos /
    * Pendencias).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MostrarProgresso(par_cTexto)
        IF !THIS.EmModoTeste()
            WAIT WINDOW ALLTRIM(NVL(par_cTexto, "")) NOWAIT
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE LimparProgresso()
        IF !THIS.EmModoTeste()
            WAIT CLEAR
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CriarBarraProgresso / AtualizarBarra / FecharBarra - espelham os
    * CreateObject('fwprogressbar', <titulo>, Reccount(<cursor>)) do legado
    * (tres lacos: Movimentacoes por Destino/Origem, Verificando
    * Movimentacoes e Processando Estoque). Devolvem .NULL. em modo de teste
    * ou se a classe falhar, e os chamadores seguem processando - a barra eh
    * feedback visual, nunca pre-requisito do calculo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CriarBarraProgresso(par_cTitulo, par_nTotal)
        LOCAL loc_oBarra, loc_oErro
        loc_oBarra = .NULL.

        IF !THIS.EmModoTeste()
            TRY
                loc_oBarra = CREATEOBJECT("fwprogressbar", ;
                    ALLTRIM(NVL(par_cTitulo, "")), MAX(NVL(par_nTotal, 0), 1))
                loc_oBarra.Titulo.FontBold = .T.
                loc_oBarra.Show()
            CATCH TO loc_oErro
                loc_oBarra = .NULL.
            ENDTRY
        ENDIF

        RETURN loc_oBarra
    ENDFUNC

    PROTECTED PROCEDURE AtualizarBarra(par_oBarra, par_cTexto)
        LOCAL loc_oErro

        IF VARTYPE(par_oBarra) = "O"
            TRY
                par_oBarra.SubTitulo.Caption = ALLTRIM(NVL(par_cTexto, ""))
                par_oBarra.Update(.T.)
            CATCH TO loc_oErro
                *-- a barra eh so feedback visual: se a janela ja foi fechada
                *-- pelo usuario, o processamento continua sem ela
            ENDTRY
        ENDIF
    ENDPROC

    PROTECTED PROCEDURE FecharBarra(par_oBarra)
        LOCAL loc_oErro

        IF VARTYPE(par_oBarra) = "O"
            TRY
                par_oBarra.Complete(.T.)
            CATCH TO loc_oErro
                *-- idem AtualizarBarra
            ENDTRY
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ZapCursor - ZAP guardado por SET SAFETY.
    *
    * SET SAFETY eh ESCOPADO POR DATA SESSION e o form que consome este BO eh
    * DataSession = 2: o SET SAFETY OFF do main.prg NAO alcanca a sessao
    * privada, e com SAFETY ON o ZAP abre dialogo modal de confirmacao e
    * CONGELA a tela (em teste headless isso aparece como timeout sem
    * resultado nenhum, nao como erro). FormBase.Init ja faz SET SAFETY OFF
    * na sessao do form; o guard aqui cobre o uso do BO fora dele.
    *
    * ZAP eh a escolha CERTA aqui, nao USE IN + CREATE CURSOR: o legado faz
    * "Zap In <cursor>" exatamente para preservar a estrutura e o binding das
    * grades (Grid.RecordSource / Column.ControlSource). Fechar e recriar o
    * alias derrubaria o binding e a grade ficaria vazia com o cursor cheio.
    *
    * Usado tambem onde o legado faz "Delete All" (dbParcela): com ZAP o
    * resultado nao depende de SET DELETED, que a data session privada reseta
    * para OFF (default do VFP) - com DELETE ALL + DELETED OFF as linhas
    * apagadas continuariam aparecendo na grade.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ZapCursor(par_cCursor)
        LOCAL loc_cSafety

        IF USED(par_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            ZAP IN (par_cCursor)
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarConsulta - SQLEXEC com o tratamento de erro do legado
    * ("MessageBox('Favor reinicializar o processo.',16,'Falha na Conexao')"
    * repetido nas 20 consultas de Processa).
    *
    * O alias de destino eh fechado antes, com o guard de buffering: sem ele
    * o segundo SQLEXEC sobre o mesmo alias estoura "Table buffer contains
    * uncommitted changes", e TABLEREVERT em cursor sem buffering dispara o
    * erro 1586 ("Function requires row or table buffering mode").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarConsulta(par_cSQL, par_cCursor)
        LOCAL loc_nResultado

        IF USED(par_cCursor)
            IF CURSORGETPROP("Buffering", par_cCursor) > 1
                TABLEREVERT(.T., par_cCursor)
            ENDIF
            USE IN (par_cCursor)
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)

        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor reinicializar o processo." + ;
                CHR(13) + CapturarErroSQL()
        ENDIF

        RETURN (loc_nResultado >= 1)
    ENDFUNC

    *--------------------------------------------------------------------------
    * InicializarCursoresDados - espelha a PROCEDURE Load do legado, que cria
    * os 8 cursores locais de resultado com os indices usados pelas grades e
    * pelos SEEK de Processa.
    *
    * As LARGURAS sao as do legado, NAO as do schema: dbHistorico.hists eh
    * c(30) contra SigMvCcr.hists char(60), dbProdFor.reffs eh c(20) contra
    * SigCdPro.reffs char(40) e dpros eh c(40) contra char(65). Sao as
    * larguras de EXIBICAO que o legado escolheu - transcritas literalmente
    * (PILAR 1), nao "corrigidas" para o tamanho da coluna de origem.
    *
    * Somente datas/vencs sao NULL (como no legado): os demais campos sao
    * acumuladores (Replace x With x + y) e com NULL a soma viraria NULL.
    * Por isso TODO valor vindo do SQL Server entra via NVL nos INSERT.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarCursoresDados()
        LOCAL loc_cNullAnt, loc_oErro

        loc_cNullAnt = SET("NULL")
        SET NULL OFF

        TRY
            *-- dbSaldo - saldos por moeda (grade "Saldo por Moeda")
            IF !USED("cursor_4c_Saldo")
                CREATE CURSOR cursor_4c_Saldo ( ;
                    grupos C(10), contas C(10), moedas C(3), saldos N(12,3))
            ENDIF

            *-- dbHistorico - historico de conta corrente. Grade FILHA de
            *-- cursor_4c_Saldo pela moeda; o tag eh composto (moeda + data)
            *-- para a grade sair filtrada pela moeda selecionada E ordenada
            *-- por data. DTOS(NVL(datas,{})) protege o indice das datas NULL
            *-- que SigMvCcr.datas (datetime NULL) pode trazer.
            IF !USED("cursor_4c_Historico")
                CREATE CURSOR cursor_4c_Historico ( ;
                    emps C(3), datas D NULL, valors N(12,2), opers C(1), ;
                    saldos N(12,3), hists C(30), moedas C(3), hist2s C(40), ;
                    vencs D NULL, valpags N(12,2), nfs C(10))
                INDEX ON moedas + DTOS(NVL(datas, {})) TAG moedata
            ENDIF

            *-- dbEstoque - produtos do fornecedor em poder das empresas
            IF !USED("cursor_4c_Estoque")
                CREATE CURSOR cursor_4c_Estoque ( ;
                    cpros C(14), dpros C(40), sqtds N(12,3))
            ENDIF

            *-- dbConserto - consertos em aberto
            IF !USED("cursor_4c_Conserto")
                CREATE CURSOR cursor_4c_Conserto ( ;
                    datas D, emps C(3), opers C(27), obscon C(50))
            ENDIF

            *-- dbParcela - valores em aberto (parcelas + conta corrente)
            IF !USED("cursor_4c_Parcela")
                CREATE CURSOR cursor_4c_Parcela ( ;
                    vencs D NULL, emps C(3), fpags C(10), valos N(12,2), ;
                    moefpgs C(3), dopes C(20), numes N(6), hists C(50))
                INDEX ON DTOS(NVL(vencs, {})) TAG vencs
            ENDIF

            *-- dbProdFor - produtos do fornecedor (grade "Produtos" da aba
            *-- Movimentacao). Os 4 tags sao os usados pelos Click/DblClick
            *-- dos headers (ordenacao ascendente/descendente). cpros fica por
            *-- ULTIMO para ser o tag controlador inicial, que eh o que os
            *-- SEEK(<produto>, 'dbProdFor') de Processa pressupoem.
            IF !USED("cursor_4c_ProdFor")
                CREATE CURSOR cursor_4c_ProdFor ( ;
                    cpros C(14), custofs N(12,2), moecusfs C(3), marca C(1), ;
                    qtvend N(12,3), vlvend N(12,2), estoque N(12,3), ;
                    cunis C(3), pvens N(12,2), moedas C(3), reffs C(20), ;
                    dpros C(40), situas N(1))
                INDEX ON qtvend TAG qtvend
                INDEX ON vlvend TAG vlvend
                INDEX ON reffs  TAG reffs
                INDEX ON cpros  TAG cpros
            ENDIF

            *-- dbResumo - total por operacao
            IF !USED("cursor_4c_Resumo")
                CREATE CURSOR cursor_4c_Resumo ( ;
                    dopes C(20), qtds N(7,2), valos N(12,2), custofs N(12,2))
                INDEX ON dopes TAG dopes
            ENDIF

            *-- dbOperaProd - operacoes por produto (grade FILHA de
            *-- cursor_4c_ProdFor pelo produto)
            IF !USED("cursor_4c_OperaProd")
                CREATE CURSOR cursor_4c_OperaProd ( ;
                    cpros C(14), dopes C(20), valos N(12,2), qtds N(12,3))
                INDEX ON cpros + dopes TAG cprosdopes
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao criar os cursores da consulta:" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        IF loc_cNullAnt = "ON"
            SET NULL ON
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursoresApoio - espelha a PROCEDURE Init do legado, que
    * carrega uma unica vez os cursores de parametros/tabelas de apoio usados
    * pelos SEEK de Processa e pelas validacoes dos botoes.
    *
    * Os nomes crSigCd* sao preservados por serem a convencao ja adotada no
    * projeto para os cursores de apoio de cotacao (o CarregarCambio de
    * SigReAtmBO / SigReInvBO le crSigCdMoe / crSigCdCot com estes nomes).
    *
    * Cada cursor passa por "SELECT * INTO CURSOR ... READWRITE" antes do
    * INDEX ON: cursor de SQL pass-through nasce somente-leitura e nao aceita
    * a criacao de indice.
    *
    * crSigCdOpe NAO vem de "Select ... From SigCdOpe": o legado troca a
    * query antiga (comentada no SCX, com c.tipoops In (4,5,7,8)) por um JOIN
    * com SigCdTom para trazer GerGdmis, que eh o que decide se a operacao
    * gera movimento de estoque. Transcrito do JOIN vigente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InicializarCursoresApoio()
        LOCAL loc_oErro

        TRY
            IF THIS.ExecutarConsulta("SELECT * FROM SigCdPam", "crSigCdPam")
                SELECT crSigCdPam
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT cemps, razas, ativas FROM SigCdEmp", ;
                    "cursor_4c_EmpTmp")
                SELECT * FROM cursor_4c_EmpTmp INTO CURSOR crSigCdEmp READWRITE
                USE IN cursor_4c_EmpTmp
                SELECT crSigCdEmp
                INDEX ON cemps TAG Cemps
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT usuarios, supervis FROM SigCdUsu " + ;
                    "WHERE NOT cAtivos = 'N'", "cursor_4c_UsuTmp")
                SELECT * FROM cursor_4c_UsuTmp INTO CURSOR crUsuarios READWRITE
                USE IN cursor_4c_UsuTmp
                SELECT crUsuarios
                INDEX ON usuarios TAG Usuarios
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT codigos, tpcads, mfotos FROM SigCdGcr", ;
                    "cursor_4c_GcrTmp")
                SELECT * FROM cursor_4c_GcrTmp INTO CURSOR crSigCdGcr READWRITE
                USE IN cursor_4c_GcrTmp
                SELECT crSigCdGcr
                INDEX ON codigos TAG Codigos
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta( ;
                    "SELECT a.Dopes, a.Cmoes, a.Caixas, a.TipoOps, a.Pesovts, " + ;
                    "a.Precovts, a.Valpends, b.GerGdmis " + ;
                    "FROM SigCdOpe a, SigCdTom b " + ;
                    "WHERE a.TipoOps = b.Codigos", "cursor_4c_OpeTmp")
                SELECT * FROM cursor_4c_OpeTmp INTO CURSOR crSigCdOpe READWRITE
                USE IN cursor_4c_OpeTmp
                SELECT crSigCdOpe
                INDEX ON Dopes TAG Dopes
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT operacaos, tipos FROM SigCdOpt", ;
                    "cursor_4c_OptTmp")
                SELECT * FROM cursor_4c_OptTmp INTO CURSOR crSigCdOpt READWRITE
                USE IN cursor_4c_OptTmp
                SELECT crSigCdOpt
                INDEX ON operacaos TAG Operacaos
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT fpags, infos, valpends FROM SigOpFp", ;
                    "cursor_4c_FpTmp")
                SELECT * FROM cursor_4c_FpTmp INTO CURSOR crSigOpFp READWRITE
                USE IN cursor_4c_FpTmp
                SELECT crSigOpFp
                INDEX ON fpags TAG FPags
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT * FROM SigCdMoe", "cursor_4c_MoeTmp")
                SELECT * FROM cursor_4c_MoeTmp INTO CURSOR crSigCdMoe READWRITE
                USE IN cursor_4c_MoeTmp
                SELECT crSigCdMoe
                INDEX ON cmoes TAG CMoes
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT cmoes, datas, valos FROM SigCdCot", ;
                    "cursor_4c_CotTmp")
                SELECT * FROM cursor_4c_CotTmp INTO CURSOR crSigCdCot READWRITE
                USE IN cursor_4c_CotTmp
                SELECT crSigCdCot
                INDEX ON cmoes                        TAG CMoes
                INDEX ON cmoes + DTOS(NVL(datas, {})) TAG CMoeData
                GO TOP
            ENDIF

            IF THIS.ExecutarConsulta("SELECT linhas, tpcustos FROM SigCdLin", ;
                    "cursor_4c_LinTmp")
                SELECT * FROM cursor_4c_LinTmp INTO CURSOR crSigCdLin READWRITE
                USE IN cursor_4c_LinTmp
                SELECT crSigCdLin
                INDEX ON linhas TAG Linhas
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Favor reinicializar o processo." + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "Falha na Conex" + CHR(227) + "o")
            THIS.this_lErroExibido = .T.
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterGrupoPadrao - CrSigCdPam.grpadfors, o grupo de contas default que o
    * Init do legado joga em Origem.Get_Grupo.Value.
    *--------------------------------------------------------------------------
    FUNCTION ObterGrupoPadrao()
        LOCAL loc_cGrupo
        loc_cGrupo = ""

        IF USED("crSigCdPam") AND RECCOUNT("crSigCdPam") > 0
            SELECT crSigCdPam
            GO TOP
            loc_cGrupo = ALLTRIM(TratarNulo(crSigCdPam.grpadfors, ""))
        ENDIF

        RETURN loc_cGrupo
    ENDFUNC

    *--------------------------------------------------------------------------
    * GrupoExiste / MoedaExiste - as verificacoes do Do Case que abre
    * cmd_cadastro.Click e cmd_movimenta.Click do legado:
    *   Seek(Get_Grupo.Value, 'CrSigCdGcr', 'codigos')
    *   Seek(Get_Moeda.Value, 'CrSigCdMoe', 'cmoes')
    *--------------------------------------------------------------------------
    FUNCTION GrupoExiste(par_cGrupo)
        IF !USED("crSigCdGcr") OR EMPTY(NVL(par_cGrupo, ""))
            RETURN .F.
        ENDIF

        SELECT crSigCdGcr
        SET ORDER TO Codigos

        RETURN SEEK(PADR(ALLTRIM(par_cGrupo), 10))
    ENDFUNC

    FUNCTION MoedaExiste(par_cMoeda)
        IF !USED("crSigCdMoe") OR EMPTY(NVL(par_cMoeda, ""))
            RETURN .F.
        ENDIF

        SELECT crSigCdMoe
        SET ORDER TO CMoes

        RETURN SEEK(PADR(ALLTRIM(par_cMoeda), 3))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarCambio - substitui fCarregarCambio(cMoeda, dData) do framework
    * legado, que NAO foi portada para projeto\app\utils\functions.prg.
    *
    * Le a ultima cotacao com data <= dData em crSigCdCot (SigCdCot.valos),
    * so quando a moeda esta marcada como cotada em SigCdMoe (coluna cotas,
    * bit). Devolve 1 - nunca 0 - para poder ser usada como DIVISOR sem
    * estourar divisao por zero, que eh exatamente o uso em Processa
    * (lnValItem * lnCotOper / lnCotaConv).
    *--------------------------------------------------------------------------
    FUNCTION CarregarCambio(par_cMoeda, par_dData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(NVL(par_cMoeda, ""))
        loc_dData    = IIF(EMPTY(par_dData), DATE(), ConverterParaData(par_dData))

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        TRY
            IF USED("crSigCdMoe")
                SELECT crSigCdMoe
                SET ORDER TO CMoes
                IF SEEK(PADR(loc_cMoeda, 3)) AND THIS.BitParaLogico(crSigCdMoe.cotas)
                    IF USED("crSigCdCot")
                        SELECT crSigCdCot
                        SET ORDER TO CMoeData DESCENDING
                        SET NEAR ON
                        SEEK PADR(loc_cMoeda, 3) + DTOS(loc_dData)
                        SET NEAR OFF
                        IF !EOF() AND ALLTRIM(crSigCdCot.cmoes) == loc_cMoeda
                            loc_nCotacao = NVL(crSigCdCot.valos, 0)
                        ENDIF
                        SET ORDER TO CMoeData
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BitParaLogico - SigCdMoe.cotas eh "bit" no SQL Server e chega ao VFP ora
    * como Logico (.T./.F.), ora como Numerico (0/1), conforme o driver ODBC.
    * Testar VARTYPE antes de comparar - comparar Logico com 1 estoura
    * "Operator/operand type mismatch".
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BitParaLogico(par_uValor)
        IF ISNULL(par_uValor)
            RETURN .F.
        ENDIF

        DO CASE
            CASE VARTYPE(par_uValor) = "L"
                RETURN par_uValor
            CASE VARTYPE(par_uValor) = "N"
                RETURN (par_uValor != 0)
            CASE VARTYPE(par_uValor) = "C"
                RETURN INLIST(UPPER(LEFT(ALLTRIM(par_uValor), 1)), "S", "1", "T", "Y")
        ENDCASE

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimiteFinalDoDia - fDtoSQL(data, '23:59:59') do legado: o periodo fecha
    * no ULTIMO segundo do dia final, senao o BETWEEN descartaria tudo o que
    * foi lancado depois da meia-noite do dia F. Data vazia devolve {}, que
    * FormatarDataSQL converte em NULL (consulta sem linha, sem erro) - sem o
    * guard, DTOT({}) + 86399 estouraria em runtime.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION LimiteFinalDoDia(par_dData)
        LOCAL loc_dData
        loc_dData = ConverterParaData(par_dData)

        IF EMPTY(loc_dData)
            RETURN {}
        ENDIF

        RETURN DTOT(loc_dData) + 86399
    ENDFUNC

    *--------------------------------------------------------------------------
    * DataDoCursor - normaliza coluna datetime do SQL Server para o campo D
    * (nullable) dos cursores locais, preservando o NULL.
    *
    * TTOD so aceita DATETIME (com DATE dispara o erro 11 em runtime); aqui o
    * valor vem SEMPRE de cursor de SQLEXEC, que eh o unico caso em que TTOD
    * direto eh correto - mas o VARTYPE eh conferido de qualquer forma porque
    * o mesmo helper serve aos cursores locais.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION DataDoCursor(par_tValor)
        IF ISNULL(par_tValor)
            RETURN .NULL.
        ENDIF

        IF VARTYPE(par_tValor) = "T"
            RETURN ConverterParaData(par_tValor)
        ENDIF

        RETURN ConverterParaData(par_tValor)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Processar - espelha o metodo Processa() do legado (871 linhas), que monta
    * o conteudo INTEIRO da Pagina Resultado a partir dos filtros da Pagina
    * Consulta. A ordem das 9 etapas eh a do legado e NAO pode ser trocada:
    * Produtos popula cursor_4c_ProdFor, e Movimentacao / Verificacao /
    * Estoque Atual acumulam EM CIMA dele (qtvend / vlvend / estoque).
    *
    * O legado abandona o metodo inteiro ("Return(.F.)") na primeira consulta
    * que falha - reproduzido com os IF loc_lOk em cadeia (VFP9 nao garante
    * short-circuit em AND, entao nao se usa "A() AND B()").
    *
    * Os blocos de UI do fim de Processa (ActivePage, Refresh das grades,
    * Visible de Mensagem1/Mensagem2, caption das colunas com a moeda e a
    * foto do fornecedor) NAO vem para ca - sao do Form (CarregarLista).
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lOk, loc_oErro, loc_cGrupo, loc_cConta

        loc_lOk    = .F.
        loc_cGrupo = ALLTRIM(NVL(THIS.this_cGrupo, ""))
        loc_cConta = ALLTRIM(NVL(THIS.this_cConta, ""))

        TRY
            THIS.this_lSemDados     = .T.
            THIS.this_cMensagemErro = ""
            THIS.this_lErroExibido  = .F.

            *-- lnCotaConv: cotacao da moeda escolhida no filtro. Eh o DIVISOR
            *-- de toda conversao de Processa; CarregarCambio nunca devolve 0.
            IF !EMPTY(THIS.this_cMoeda)
                THIS.this_nCotaConv = THIS.CarregarCambio(THIS.this_cMoeda, DATE())
            ELSE
                THIS.this_nCotaConv = 1
            ENDIF

            loc_lOk = THIS.ProcessarSaldos(loc_cGrupo, loc_cConta)

            IF loc_lOk
                loc_lOk = THIS.ProcessarHistorico(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarProdutos(loc_cConta)
            ENDIF

            *-- "If lnAnalise = 1" do legado: a analise de vendas (movimento
            *-- por operacao e por produto) so roda quando o usuario pediu.
            IF loc_lOk AND THIS.this_nAnalise = 1
                loc_lOk = THIS.ProcessarMovimentacao(loc_cGrupo, loc_cConta)

                IF loc_lOk
                    loc_lOk = THIS.ProcessarVerificacaoMovimentacao()
                ENDIF
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarEstoqueAtual()
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarEstoqueFornecedor(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarConsertos(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                loc_lOk = THIS.ProcessarPendencias(loc_cGrupo, loc_cConta)
            ENDIF

            IF loc_lOk
                THIS.CarregarParametrosGrupo(loc_cGrupo)
                THIS.PosicionarCursores()
            ENDIF

            THIS.LimparProgresso()
        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.LimparProgresso()
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, ;
                "Erro ao processar a consulta")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarSaldos - "Wait Window 'Processando Saldos...'" do legado:
    * SigMvSlc -> dbSaldo (grade "Saldo por Moeda").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarSaldos(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_lOk

        THIS.MostrarProgresso("Processando Saldos...")
        THIS.ZapCursor("cursor_4c_Saldo")

        loc_cSQL = "SELECT grupos, contas, moedas, saldos FROM SigMvSlc " + ;
                   "WHERE grupos = " + EscaparSQL(par_cGrupo) + ;
                   " AND contas = " + EscaparSQL(par_cConta) + ;
                   " ORDER BY grupos, contas, moedas, saldos"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_SaldoSql")

        IF loc_lOk
            SELECT cursor_4c_SaldoSql
            SCAN
                INSERT INTO cursor_4c_Saldo (grupos, contas, moedas, saldos) ;
                    VALUES (NVL(cursor_4c_SaldoSql.grupos, ""), ;
                            NVL(cursor_4c_SaldoSql.contas, ""), ;
                            NVL(cursor_4c_SaldoSql.moedas, ""), ;
                            NVL(cursor_4c_SaldoSql.saldos, 0))
                THIS.this_lSemDados = .F.
                SELECT cursor_4c_SaldoSql
            ENDSCAN
            USE IN cursor_4c_SaldoSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarHistorico - "Processando Historico...": SigMvCcr -> dbHistorico
    * (grade FILHA de cursor_4c_Saldo pela moeda).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarHistorico(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_lOk

        THIS.MostrarProgresso("Processando Hist" + CHR(243) + "rico...")
        THIS.ZapCursor("cursor_4c_Historico")

        loc_cSQL = "SELECT emps, grupos, contas, datas, moedas, saldos, " + ;
                   "valors, opers, hists, hist2s, vencs, valpags, nfs " + ;
                   "FROM SigMvCcr " + ;
                   "WHERE grupos = " + EscaparSQL(par_cGrupo) + ;
                   " AND contas = " + EscaparSQL(par_cConta) + ;
                   " ORDER BY emps, grupos, contas, datas, opers, saldos, " + ;
                   "moedas, valors, hists, hist2s, vencs, valpags, nfs"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_HistSql")

        IF loc_lOk
            SELECT cursor_4c_HistSql
            SCAN
                INSERT INTO cursor_4c_Historico ;
                    (emps, datas, valors, opers, saldos, hists, moedas, ;
                     hist2s, vencs, valpags, nfs) ;
                    VALUES (NVL(cursor_4c_HistSql.emps, ""), ;
                            THIS.DataDoCursor(cursor_4c_HistSql.datas), ;
                            NVL(cursor_4c_HistSql.valors, 0), ;
                            NVL(cursor_4c_HistSql.opers, ""), ;
                            NVL(cursor_4c_HistSql.saldos, 0), ;
                            NVL(cursor_4c_HistSql.hists, ""), ;
                            NVL(cursor_4c_HistSql.moedas, ""), ;
                            NVL(cursor_4c_HistSql.hist2s, ""), ;
                            THIS.DataDoCursor(cursor_4c_HistSql.vencs), ;
                            NVL(cursor_4c_HistSql.valpags, 0), ;
                            NVL(cursor_4c_HistSql.nfs, ""))
                THIS.this_lSemDados = .F.
                SELECT cursor_4c_HistSql
            ENDSCAN
            USE IN cursor_4c_HistSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarProdutos - "Processando Produtos...": SigCdPro (ifors = conta)
    * -> dbProdFor, a grade "Produtos" da aba Movimentacao.
    *
    * A regra de custo eh do legado e vai TRANSCRITA: quando a LINHA do
    * produto tem tpcustos = '2' (custo por peso), o custo exibido eh
    * pesoms * custofs, nao custofs.
    *
    * Fecha zerando dbResumo/dbOperaProd, que no legado acontece aqui mesmo -
    * ANTES do "If lnAnalise = 1" -, ou seja as duas grades de totais ficam
    * vazias quando o usuario nao pediu a analise de vendas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarProdutos(par_cConta)
        LOCAL loc_cSQL, loc_lOk, loc_nCusto

        THIS.MostrarProgresso("Processando Produtos...")

        SELECT cursor_4c_ProdFor
        SET ORDER TO cpros
        THIS.ZapCursor("cursor_4c_ProdFor")

        loc_cSQL = "SELECT cpros, dpros, custofs, moecusfs, cunis, pvens, " + ;
                   "moedas, reffs, pesoms, linhas, situas FROM SigCdPro " + ;
                   "WHERE ifors = " + EscaparSQL(par_cConta) + ;
                   " ORDER BY cpros, dpros, custofs, moecusfs, cunis, " + ;
                   "pvens, moedas, reffs, pesoms, linhas"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ProSql")

        IF loc_lOk
            SELECT cursor_4c_ProSql
            SCAN
                loc_nCusto = NVL(cursor_4c_ProSql.custofs, 0)

                IF USED("crSigCdLin")
                    SELECT crSigCdLin
                    SET ORDER TO Linhas
                    IF SEEK(PADR(ALLTRIM(NVL(cursor_4c_ProSql.linhas, "")), 10))
                        IF ALLTRIM(NVL(crSigCdLin.tpcustos, "")) == "2"
                            loc_nCusto = NVL(cursor_4c_ProSql.pesoms, 0) * ;
                                         NVL(cursor_4c_ProSql.custofs, 0)
                        ENDIF
                    ENDIF
                ENDIF

                *-- marca = ' ': produto do PROPRIO fornecedor. O '*' eh posto
                *-- em ProcessarMovimentacao, para produto movimentado com este
                *-- fornecedor mas cadastrado em outro (TmpProFor.ifors <> conta).
                INSERT INTO cursor_4c_ProdFor ;
                    (cpros, custofs, moecusfs, marca, qtvend, vlvend, ;
                     estoque, cunis, pvens, moedas, reffs, dpros, situas) ;
                    VALUES (NVL(cursor_4c_ProSql.cpros, ""), ;
                            loc_nCusto, ;
                            NVL(cursor_4c_ProSql.moecusfs, ""), ;
                            " ", 0, 0, 0, ;
                            NVL(cursor_4c_ProSql.cunis, ""), ;
                            NVL(cursor_4c_ProSql.pvens, 0), ;
                            NVL(cursor_4c_ProSql.moedas, ""), ;
                            NVL(cursor_4c_ProSql.reffs, ""), ;
                            NVL(cursor_4c_ProSql.dpros, ""), ;
                            NVL(cursor_4c_ProSql.situas, 0))

                SELECT cursor_4c_ProSql
            ENDSCAN
            USE IN cursor_4c_ProSql
        ENDIF

        THIS.ZapCursor("cursor_4c_Resumo")
        THIS.ZapCursor("cursor_4c_OperaProd")

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarMovimentacao - o laco "For _FazEst = 1 To 2" do legado: varre
    * SigMvCab primeiro pelo par DESTINO (grupods/contads) e depois pelo par
    * ORIGEM (grupoos/contaos), e para cada operacao valida desce aos itens
    * (SigMvItn) acumulando dbResumo (total por operacao) e dbOperaProd
    * (operacao por produto).
    *
    * Filtros transcritos do legado:
    *   - so operacao de CAIXA (crSigCdOpe.caixas = 1) que gere movimento de
    *     estoque (GerGdmis 1 ou 2) - a versao antiga, por tipoops In
    *     (4,5,7,8), esta COMENTADA no SCX e nao foi portada;
    *   - quando o filtro Empresa esta preenchido, so a empresa dele.
    *
    * Conversao de moeda: quando a operacao NAO tem moeda propria, o legado
    * converte pela moeda padrao do sistema (CrSigCdPam.moedaps) e liga
    * _Converte; com moeda propria na operacao, usa a dela e NAO converte o
    * item. Tudo dividido por lnCotaConv (moeda do filtro) no fim.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarMovimentacao(par_cGrupo, par_cConta)
        LOCAL loc_lOk, loc_nFaz, loc_cSQL, loc_cDtIni, loc_cDtFim, loc_oBarra, ;
              loc_cOrigDest, loc_nCotaEst, loc_cEDNs, loc_nCotItem1, ;
              loc_nCotItem2, loc_nCotOper, loc_lConverte, loc_nValItem, ;
              loc_nCota, loc_nCusto, loc_cMarca, loc_cEmpresa, loc_cMoeda, ;
              loc_cOpeMoeda, loc_nPesoVts, loc_nPrecoVts

        loc_lOk      = .T.
        loc_cEmpresa = ALLTRIM(NVL(THIS.this_cEmpresa, ""))
        loc_cMoeda   = ALLTRIM(NVL(THIS.this_cMoeda, ""))

        *-- fDtoSQL(dataI) / fDtoSQL(dataF, '23:59:59') do legado: o periodo
        *-- fecha no ULTIMO segundo do dia final, senao o BETWEEN descartaria
        *-- tudo o que foi lancado depois da meia-noite do dia F.
        loc_cDtIni = FormatarDataSQL(ConverterParaData(THIS.this_dDataI))
        loc_cDtFim = FormatarDataSQL(THIS.LimiteFinalDoDia(THIS.this_dDataF))

        FOR loc_nFaz = 1 TO 2
            IF loc_nFaz = 1
                loc_cSQL = "SELECT emps, dopes, numes, valos FROM SigMvCab " + ;
                           "WHERE grupods = " + EscaparSQL(par_cGrupo) + ;
                           " AND contads = " + EscaparSQL(par_cConta) + ;
                           " AND datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                           " ORDER BY emps, dopes, numes, valos"
                loc_cOrigDest = "(Destino)..."
            ELSE
                loc_cSQL = "SELECT emps, dopes, numes, valos FROM SigMvCab " + ;
                           "WHERE grupoos = " + EscaparSQL(par_cGrupo) + ;
                           " AND contaos = " + EscaparSQL(par_cConta) + ;
                           " AND datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + ;
                           " ORDER BY emps, dopes, numes, valos"
                loc_cOrigDest = "(Origem)..."
            ENDIF

            loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_CabSql")

            IF !loc_lOk
                EXIT
            ENDIF

            loc_oBarra = THIS.CriarBarraProgresso( ;
                "Processando Movimenta" + CHR(231) + CHR(245) + "es - " + loc_cOrigDest, ;
                RECCOUNT("cursor_4c_CabSql"))

            SELECT cursor_4c_CabSql
            SCAN
                THIS.AtualizarBarra(loc_oBarra, ;
                    "Opera" + CHR(231) + CHR(227) + "o: " + ;
                    ALLTRIM(NVL(cursor_4c_CabSql.dopes, "")))

                SELECT crSigCdOpe
                SET ORDER TO Dopes
                =SEEK(PADR(ALLTRIM(NVL(cursor_4c_CabSql.dopes, "")), 20))
                loc_cOpeMoeda = ALLTRIM(NVL(crSigCdOpe.cmoes, ""))
                loc_nPesoVts  = NVL(crSigCdOpe.pesovts, 0)
                loc_nPrecoVts = NVL(crSigCdOpe.precovts, 0)

                IF !EMPTY(loc_cOpeMoeda) AND THIS.MoedaTemCotacao(loc_cOpeMoeda)
                    loc_nCotaEst = THIS.CarregarCambio(loc_cOpeMoeda, DATE())
                ELSE
                    loc_nCotaEst = 1
                ENDIF

                IF NVL(crSigCdOpe.caixas, 0) != 1 OR ;
                        !INLIST(NVL(crSigCdOpe.GerGdmis, 0), 1, 2)
                    SELECT cursor_4c_CabSql
                    LOOP
                ENDIF

                IF !EMPTY(loc_cEmpresa) AND ;
                        loc_cEmpresa != ALLTRIM(NVL(cursor_4c_CabSql.emps, ""))
                    SELECT cursor_4c_CabSql
                    LOOP
                ENDIF

                SELECT cursor_4c_Resumo
                SET ORDER TO dopes
                IF !SEEK(PADR(ALLTRIM(NVL(cursor_4c_CabSql.dopes, "")), 20))
                    INSERT INTO cursor_4c_Resumo (dopes) ;
                        VALUES (NVL(cursor_4c_CabSql.dopes, ""))
                ENDIF
                REPLACE valos WITH valos + ;
                    (NVL(cursor_4c_CabSql.valos, 0) * loc_nCotaEst / THIS.this_nCotaConv) ;
                    IN cursor_4c_Resumo

                *-- empdopnums eh chave POSICIONAL char(29) = emps char(3) +
                *-- dopes char(20) + Str(numes,6). O padding FAZ PARTE da
                *-- chave: ALLTRIM nas partes devolveria ZERO linhas em
                *-- silencio (3+20+6 = 29 = a largura da coluna destino).
                loc_cEDNs = PADR(NVL(cursor_4c_CabSql.emps, ""), 3) + ;
                            PADR(NVL(cursor_4c_CabSql.dopes, ""), 20) + ;
                            STR(NVL(cursor_4c_CabSql.numes, 0), 6)

                loc_cSQL = "SELECT cpros, qtds, moefats, moedas, tpesos, totas " + ;
                           "FROM SigMvItn WHERE empdopnums = " + EscaparSQL(loc_cEDNs) + ;
                           " ORDER BY cpros, qtds, moefats, moedas, tpesos, totas"

                loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ItnSql")

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_ItnSql
                SCAN
                    loc_cSQL = "SELECT cpros, ifors, custofs, moecusfs, pvens, " + ;
                               "reffs, dpros, cunis, moedas, situas FROM SigCdPro " + ;
                               "WHERE cpros = " + ;
                               EscaparSQL(ALLTRIM(NVL(cursor_4c_ItnSql.cpros, ""))) + ;
                               " ORDER BY cpros, ifors, custofs, moecusfs, " + ;
                               "pvens, reffs, dpros, cunis, moedas"

                    loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ProForSql")

                    IF !loc_lOk
                        EXIT
                    ENDIF

                    SELECT cursor_4c_OperaProd
                    SET ORDER TO cprosdopes
                    IF !SEEK(PADR(NVL(cursor_4c_ItnSql.cpros, ""), 14) + ;
                             PADR(NVL(cursor_4c_CabSql.dopes, ""), 20))
                        INSERT INTO cursor_4c_OperaProd (cpros, dopes) ;
                            VALUES (NVL(cursor_4c_ItnSql.cpros, ""), ;
                                    NVL(cursor_4c_CabSql.dopes, ""))
                    ENDIF

                    loc_nCotItem1 = THIS.CarregarCambio(cursor_4c_ItnSql.moefats, DATE())
                    loc_nCotItem2 = THIS.CarregarCambio(cursor_4c_ItnSql.moedas, DATE())

                    IF EMPTY(loc_cOpeMoeda)
                        loc_nCotOper  = THIS.CarregarCambio(THIS.ObterMoedaPadrao(), DATE())
                        loc_lConverte = .T.
                    ELSE
                        loc_nCotOper  = THIS.CarregarCambio(loc_cOpeMoeda, DATE())
                        loc_lConverte = .F.
                    ENDIF

                    loc_nValItem = 0
                    IF loc_nPesoVts = 1
                        loc_nValItem = loc_nValItem + (NVL(cursor_4c_ItnSql.tpesos, 0) * ;
                            IIF(loc_lConverte, loc_nCotItem1 / loc_nCotOper, 1))
                    ENDIF
                    IF loc_nPrecoVts = 1
                        loc_nValItem = loc_nValItem + (NVL(cursor_4c_ItnSql.totas, 0) * ;
                            IIF(loc_lConverte, loc_nCotItem2 / loc_nCotOper, 1))
                    ENDIF

                    loc_nValItem = ROUND(loc_nValItem * loc_nCotOper / THIS.this_nCotaConv, 2)

                    REPLACE valos WITH valos + loc_nValItem, ;
                            qtds  WITH qtds  + NVL(cursor_4c_ItnSql.qtds, 0) ;
                        IN cursor_4c_OperaProd

                    *-- Produto movimentado com este fornecedor mas que NAO esta
                    *-- na lista dele: entra no dbProdFor com marca '*' quando o
                    *-- cadastro aponta OUTRO fornecedor.
                    SELECT cursor_4c_ProdFor
                    SET ORDER TO cpros
                    IF !SEEK(PADR(NVL(cursor_4c_ItnSql.cpros, ""), 14))
                        SELECT cursor_4c_ProForSql
                        GO TOP

                        IF !EOF() AND ;
                                ALLTRIM(NVL(cursor_4c_ProForSql.ifors, "")) != par_cConta
                            loc_cMarca = "*"
                        ELSE
                            loc_cMarca = " "
                        ENDIF

                        *-- O legado usa "Scatter Fields ... MemVar" + "Insert
                        *-- From MemVar" com uma lista que NAO inclui cpros, e
                        *-- por isso grava o m.cpros que sobrou do Scatter do
                        *-- laco de Produtos (memvar obsoleto). Aqui as colunas
                        *-- sao explicitas e cpros eh o do produto que esta
                        *-- sendo processado - que eh a intencao do bloco.
                        INSERT INTO cursor_4c_ProdFor ;
                            (cpros, custofs, moecusfs, marca, qtvend, vlvend, ;
                             estoque, cunis, pvens, moedas, reffs, dpros, situas) ;
                            VALUES (NVL(cursor_4c_ProForSql.cpros, ""), ;
                                    NVL(cursor_4c_ProForSql.custofs, 0), ;
                                    NVL(cursor_4c_ProForSql.moecusfs, ""), ;
                                    loc_cMarca, 0, 0, 0, ;
                                    NVL(cursor_4c_ProForSql.cunis, ""), ;
                                    NVL(cursor_4c_ProForSql.pvens, 0), ;
                                    NVL(cursor_4c_ProForSql.moedas, ""), ;
                                    NVL(cursor_4c_ProForSql.reffs, ""), ;
                                    NVL(cursor_4c_ProForSql.dpros, ""), ;
                                    NVL(cursor_4c_ProForSql.situas, 0))
                    ENDIF

                    SELECT cursor_4c_ProForSql
                    IF ALLTRIM(NVL(cursor_4c_ProForSql.moecusfs, "")) != loc_cMoeda
                        loc_nCota  = THIS.CarregarCambio(cursor_4c_ProForSql.moecusfs, DATE())
                        loc_nCota  = IIF(loc_nCota = 0, 1, loc_nCota)
                        loc_nCusto = ROUND(NVL(cursor_4c_ProForSql.custofs, 0) * ;
                                           loc_nCota / THIS.this_nCotaConv, 2)
                    ELSE
                        loc_nCusto = NVL(cursor_4c_ProForSql.custofs, 0)
                    ENDIF

                    REPLACE custofs WITH custofs + ;
                                (loc_nCusto * NVL(cursor_4c_ItnSql.qtds, 0)), ;
                            qtds    WITH qtds + NVL(cursor_4c_ItnSql.qtds, 0) ;
                        IN cursor_4c_Resumo

                    THIS.this_lSemDados = .F.

                    USE IN cursor_4c_ProForSql
                    SELECT cursor_4c_ItnSql
                ENDSCAN

                IF USED("cursor_4c_ItnSql")
                    USE IN cursor_4c_ItnSql
                ENDIF

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_CabSql
            ENDSCAN

            THIS.FecharBarra(loc_oBarra)
            loc_oBarra = .NULL.

            IF USED("cursor_4c_CabSql")
                USE IN cursor_4c_CabSql
            ENDIF

            IF !loc_lOk
                EXIT
            ENDIF
        ENDFOR

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarVerificacaoMovimentacao - "Verificando Movimentacoes...": o
    * legado varre TODO o movimento do periodo (SigMvCab + SigMvItn +
    * SigCdOpe + SigCdTom, sem filtro de conta) e acumula em dbProdFor
    * APENAS os produtos que ja estao nele - isto eh, os do fornecedor
    * pesquisado - de onde saem as colunas Qt. Vendas / Valor Vendas.
    *
    * SAIDA (Opers = 'S') soma; ENTRADA (Opers = 'E') SUBTRAI - as duas com
    * GerGdmis = 1. O sinal eh regra de negocio e vai transcrito.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarVerificacaoMovimentacao()
        LOCAL loc_lOk, loc_cSQL, loc_cDtIni, loc_cDtFim, loc_oBarra, ;
              loc_nCotItem1, loc_nCotItem2, loc_nCotOper, loc_lConverte, ;
              loc_nValItem, loc_nCota, loc_nCusto, loc_cEmpresa, loc_cMoeda, ;
              loc_cOper, loc_nGerGdmis

        loc_cEmpresa = ALLTRIM(NVL(THIS.this_cEmpresa, ""))
        loc_cMoeda   = ALLTRIM(NVL(THIS.this_cMoeda, ""))

        THIS.MostrarProgresso("Verificando Movimenta" + CHR(231) + CHR(245) + "es...")

        loc_cDtIni = FormatarDataSQL(ConverterParaData(THIS.this_dDataI))
        loc_cDtFim = FormatarDataSQL(THIS.LimiteFinalDoDia(THIS.this_dDataF))

        loc_cSQL = "SELECT b.Opers, b.emps, b.dopes, b.numes, b.cpros, b.qtds, " + ;
                   "b.totas, b.moedas, b.moefats, b.tpesos, c.tipoops, c.cmoes, " + ;
                   "c.pesovts, c.precovts, t.GerGdmis " + ;
                   "FROM SigMvCab a, SigMvItn b, SigCdOpe c, SigCdTom t " + ;
                   "WHERE a.datas BETWEEN " + loc_cDtIni + " AND " + loc_cDtFim + " AND "

        IF !EMPTY(loc_cEmpresa)
            loc_cSQL = loc_cSQL + "a.emps = " + EscaparSQL(loc_cEmpresa) + " AND "
        ENDIF

        loc_cSQL = loc_cSQL + ;
                   "b.empdopnums = a.empdopnums AND " + ;
                   "c.dopes = b.dopes AND " + ;
                   "c.TipoOps = t.Codigos AND " + ;
                   "t.GerGdmis In (1, 2) AND " + ;
                   "c.caixas = 1 " + ;
                   "ORDER BY b.emps, b.dopes, b.numes, b.cpros, b.qtds, " + ;
                   "b.totas, b.moedas, b.moefats, b.tpesos, c.tipoops, " + ;
                   "c.cmoes, c.pesovts, c.precovts"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_MovSql")

        IF !loc_lOk
            RETURN .F.
        ENDIF

        loc_oBarra = THIS.CriarBarraProgresso( ;
            "Verificando Movimenta" + CHR(231) + CHR(245) + "es...", ;
            RECCOUNT("cursor_4c_MovSql"))

        SELECT cursor_4c_MovSql
        SCAN
            THIS.AtualizarBarra(loc_oBarra, ;
                ALLTRIM(NVL(cursor_4c_MovSql.emps, "")) + " - " + ;
                ALLTRIM(NVL(cursor_4c_MovSql.dopes, "")) + " - " + ;
                ALLTRIM(STR(NVL(cursor_4c_MovSql.numes, 0), 6)))

            loc_nCotItem1 = THIS.CarregarCambio(cursor_4c_MovSql.moefats, DATE())
            loc_nCotItem2 = THIS.CarregarCambio(cursor_4c_MovSql.moedas, DATE())

            IF EMPTY(ALLTRIM(NVL(cursor_4c_MovSql.cmoes, "")))
                loc_nCotOper  = THIS.CarregarCambio(THIS.ObterMoedaPadrao(), DATE())
                loc_lConverte = .T.
            ELSE
                loc_nCotOper  = THIS.CarregarCambio(cursor_4c_MovSql.cmoes, DATE())
                loc_lConverte = .F.
            ENDIF

            loc_nValItem = 0
            IF NVL(cursor_4c_MovSql.pesovts, 0) = 1
                loc_nValItem = loc_nValItem + (NVL(cursor_4c_MovSql.tpesos, 0) * ;
                    IIF(loc_lConverte, loc_nCotItem1 / loc_nCotOper, 1))
            ENDIF
            IF NVL(cursor_4c_MovSql.precovts, 0) = 1
                loc_nValItem = loc_nValItem + (NVL(cursor_4c_MovSql.totas, 0) * ;
                    IIF(loc_lConverte, loc_nCotItem2 / loc_nCotOper, 1))
            ENDIF

            loc_nValItem = ROUND(loc_nValItem * loc_nCotOper / THIS.this_nCotaConv, 2)
            loc_cOper    = UPPER(ALLTRIM(NVL(cursor_4c_MovSql.Opers, "")))
            loc_nGerGdmis = NVL(cursor_4c_MovSql.GerGdmis, 0)

            SELECT cursor_4c_ProdFor
            SET ORDER TO cpros
            IF SEEK(PADR(NVL(cursor_4c_MovSql.cpros, ""), 14))
                IF loc_cOper == "S" AND loc_nGerGdmis = 1
                    REPLACE qtvend WITH qtvend + NVL(cursor_4c_MovSql.qtds, 0), ;
                            vlvend WITH vlvend + loc_nValItem ;
                        IN cursor_4c_ProdFor
                ENDIF
                IF loc_cOper == "E" AND loc_nGerGdmis = 1
                    REPLACE qtvend WITH qtvend - NVL(cursor_4c_MovSql.qtds, 0), ;
                            vlvend WITH vlvend - loc_nValItem ;
                        IN cursor_4c_ProdFor
                ENDIF

                SELECT cursor_4c_OperaProd
                SET ORDER TO cprosdopes
                IF !SEEK(PADR(NVL(cursor_4c_MovSql.cpros, ""), 14) + ;
                         PADR(NVL(cursor_4c_MovSql.dopes, ""), 20))
                    INSERT INTO cursor_4c_OperaProd (cpros, dopes) ;
                        VALUES (NVL(cursor_4c_MovSql.cpros, ""), ;
                                NVL(cursor_4c_MovSql.dopes, ""))
                ENDIF
                REPLACE valos WITH valos + loc_nValItem, ;
                        qtds  WITH qtds  + NVL(cursor_4c_MovSql.qtds, 0) ;
                    IN cursor_4c_OperaProd

                SELECT cursor_4c_Resumo
                SET ORDER TO dopes
                IF !SEEK(PADR(NVL(cursor_4c_MovSql.dopes, ""), 20))
                    INSERT INTO cursor_4c_Resumo (dopes) ;
                        VALUES (NVL(cursor_4c_MovSql.dopes, ""))
                ENDIF
                REPLACE valos WITH valos + loc_nValItem IN cursor_4c_Resumo

                loc_cSQL = "SELECT cpros, ifors, custofs, moecusfs FROM SigCdPro " + ;
                           "WHERE cpros = " + ;
                           EscaparSQL(ALLTRIM(NVL(cursor_4c_MovSql.cpros, "")))

                loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_Pro2Sql")

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_Pro2Sql
                GO TOP
                IF !EOF()
                    IF ALLTRIM(NVL(cursor_4c_Pro2Sql.moecusfs, "")) != loc_cMoeda
                        loc_nCota  = THIS.CarregarCambio(cursor_4c_Pro2Sql.moecusfs, DATE())
                        loc_nCota  = IIF(loc_nCota = 0, 1, loc_nCota)
                        loc_nCusto = ROUND(NVL(cursor_4c_Pro2Sql.custofs, 0) * ;
                                           loc_nCota / THIS.this_nCotaConv, 2)
                    ELSE
                        loc_nCusto = NVL(cursor_4c_Pro2Sql.custofs, 0)
                    ENDIF

                    REPLACE custofs WITH custofs + ;
                                (loc_nCusto * NVL(cursor_4c_MovSql.qtds, 0)), ;
                            qtds    WITH qtds + NVL(cursor_4c_MovSql.qtds, 0) ;
                        IN cursor_4c_Resumo
                ENDIF

                USE IN cursor_4c_Pro2Sql
            ENDIF

            SELECT cursor_4c_MovSql
        ENDSCAN

        THIS.FecharBarra(loc_oBarra)

        IF USED("cursor_4c_MovSql")
            USE IN cursor_4c_MovSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarEstoqueAtual - "Processando Estoque Atual...": soma em
    * dbProdFor.estoque o saldo de SigMvEst da conta de ESTOQUE do sistema
    * (CrSigCdPam.grupoests/contaests), empresa por empresa quando o filtro
    * Empresa esta vazio, ou so a empresa escolhida.
    *
    * empgruests eh chave POSICIONAL char(23) = emps(3) + grupo(10) +
    * conta(10): montada com PADR, nunca com ALLTRIM nas partes.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarEstoqueAtual()
        LOCAL loc_lOk, loc_oBarra, loc_cEmpresa

        loc_lOk      = .T.
        loc_cEmpresa = ALLTRIM(NVL(THIS.this_cEmpresa, ""))

        IF !USED("crSigCdEmp") OR !USED("crSigCdPam")
            RETURN .T.
        ENDIF

        IF EMPTY(loc_cEmpresa)
            loc_oBarra = THIS.CriarBarraProgresso("Processando Estoque Atual...", ;
                RECCOUNT("crSigCdEmp"))

            SELECT crSigCdEmp
            GO TOP
            SCAN
                THIS.AtualizarBarra(loc_oBarra, "Empresa: " + ;
                    ALLTRIM(NVL(crSigCdEmp.cemps, "")) + " - " + ;
                    ALLTRIM(NVL(crSigCdEmp.razas, "")))

                IF NVL(crSigCdEmp.ativas, 0) = 1
                    loc_lOk = THIS.SomarEstoqueEmpresa(NVL(crSigCdEmp.cemps, ""))
                    IF !loc_lOk
                        EXIT
                    ENDIF
                ENDIF

                SELECT crSigCdEmp
            ENDSCAN

            THIS.FecharBarra(loc_oBarra)
        ELSE
            SELECT crSigCdEmp
            SET ORDER TO Cemps
            =SEEK(PADR(loc_cEmpresa, 3))
            loc_lOk = THIS.SomarEstoqueEmpresa(NVL(crSigCdEmp.cemps, ""))
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * SomarEstoqueEmpresa - corpo do laco de ProcessarEstoqueAtual para UMA
    * empresa. O cursor de SQL passa por "SELECT * INTO CURSOR ... READWRITE"
    * antes do INDEX ON porque cursor de pass-through nasce somente-leitura e
    * nao aceita a criacao do indice que o SEEK do legado pressupoe.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION SomarEstoqueEmpresa(par_cEmpresa)
        LOCAL loc_cSQL, loc_cChave, loc_lOk

        loc_cChave = PADR(NVL(par_cEmpresa, ""), 3) + ;
                     PADR(NVL(crSigCdPam.grupoests, ""), 10) + ;
                     PADR(NVL(crSigCdPam.contaests, ""), 10)

        loc_cSQL = "SELECT emps, cpros, sqtds FROM SigMvEst " + ;
                   "WHERE empgruests = " + EscaparSQL(loc_cChave) + ;
                   " ORDER BY emps, cpros, sqtds"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_Est1Sql")

        IF loc_lOk
            IF USED("cursor_4c_Est1")
                USE IN cursor_4c_Est1
            ENDIF
            SELECT * FROM cursor_4c_Est1Sql INTO CURSOR cursor_4c_Est1 READWRITE
            USE IN cursor_4c_Est1Sql

            SELECT cursor_4c_Est1
            INDEX ON emps + cpros TAG EmpPro
            GO TOP

            SELECT cursor_4c_ProdFor
            SET ORDER TO cpros
            GO TOP
            SCAN
                IF SEEK(PADR(NVL(par_cEmpresa, ""), 3) + ;
                        PADR(NVL(cursor_4c_ProdFor.cpros, ""), 14), ;
                        "cursor_4c_Est1", "EmpPro")
                    REPLACE estoque WITH estoque + NVL(cursor_4c_Est1.sqtds, 0) ;
                        IN cursor_4c_ProdFor
                ENDIF
                SELECT cursor_4c_ProdFor
            ENDSCAN

            USE IN cursor_4c_Est1
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarEstoqueFornecedor - "Processando Estoque do Fornecedor...":
    * SigMvEst da conta do PROPRIO fornecedor -> dbEstoque, a grade "Produtos
    * em seu poder" da aba Estoque. Varre TODAS as empresas ativas,
    * independentemente do filtro Empresa (assim faz o legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarEstoqueFornecedor(par_cGrupo, par_cConta)
        LOCAL loc_lOk, loc_oBarra, loc_cSQL, loc_cChave

        loc_lOk = .T.
        THIS.ZapCursor("cursor_4c_Estoque")

        IF !USED("crSigCdEmp")
            RETURN .T.
        ENDIF

        loc_oBarra = THIS.CriarBarraProgresso( ;
            "Processando Estoque do Fornecedor...", RECCOUNT("crSigCdEmp"))

        SELECT crSigCdEmp
        GO TOP
        SCAN
            THIS.AtualizarBarra(loc_oBarra, "Empresa: " + ;
                ALLTRIM(NVL(crSigCdEmp.cemps, "")) + " - " + ;
                ALLTRIM(NVL(crSigCdEmp.razas, "")))

            IF NVL(crSigCdEmp.ativas, 0) = 1
                loc_cChave = PADR(NVL(crSigCdEmp.cemps, ""), 3) + ;
                             PADR(par_cGrupo, 10) + PADR(par_cConta, 10)

                loc_cSQL = "SELECT cpros, sqtds FROM SigMvEst " + ;
                           "WHERE empgruests = " + EscaparSQL(loc_cChave) + ;
                           " ORDER BY cpros, sqtds"

                loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_Est2Sql")

                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT cursor_4c_Est2Sql
                SCAN
                    INSERT INTO cursor_4c_Estoque (cpros, sqtds) ;
                        VALUES (NVL(cursor_4c_Est2Sql.cpros, ""), ;
                                NVL(cursor_4c_Est2Sql.sqtds, 0))
                    THIS.this_lSemDados = .F.
                    SELECT cursor_4c_Est2Sql
                ENDSCAN

                USE IN cursor_4c_Est2Sql
            ENDIF

            SELECT crSigCdEmp
        ENDSCAN

        THIS.FecharBarra(loc_oBarra)

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarConsertos - "Processando Consertos...": operacoes de conserto
    * (CrSigCdPam.opconfors = conserto de cliente, opconsljs = conserto de
    * loja) AINDA NAO baixadas (chksubn falso) -> dbConserto. Varre os dois
    * pares de SigMvCab: ORIGEM (grupoos/contaos) e DESTINO (grupods/contads).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarConsertos(par_cGrupo, par_cConta)
        LOCAL loc_lOk

        THIS.MostrarProgresso("Processando Consertos...")
        THIS.ZapCursor("cursor_4c_Conserto")

        IF USED("crSigCdPam")
            SELECT crSigCdPam
            GO TOP
        ENDIF

        loc_lOk = THIS.CarregarConsertosPar(par_cGrupo, par_cConta, "grupoos", "contaos")

        IF loc_lOk
            loc_lOk = THIS.CarregarConsertosPar(par_cGrupo, par_cConta, "grupods", "contads")
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConsertosPar - corpo repetido duas vezes no legado (TprMvCab3 e
    * TprMvCab4), com as colunas de ORIGEM e de DESTINO.
    *
    * A comparacao da operacao usa ALLTRIM(...) == ALLTRIM(...) de proposito:
    * a data session privada do form (DataSession = 2) reseta SET EXACT para
    * OFF, e com EXACT OFF o "=" do legado viraria comparacao por PREFIXO -
    * com opconfors em branco, casaria com TODA operacao. O "==" reproduz o
    * comportamento do legado, que roda com SET EXACT ON.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarConsertosPar(par_cGrupo, par_cConta, par_cColGrupo, par_cColConta)
        LOCAL loc_cSQL, loc_lOk, loc_cOpe, loc_cOpConFor, loc_cOpConSlj, loc_cOperDesc

        loc_cOpConFor = ALLTRIM(NVL(crSigCdPam.opconfors, ""))
        loc_cOpConSlj = ALLTRIM(NVL(crSigCdPam.opconsljs, ""))

        loc_cSQL = "SELECT emps, dopes, numes, datas, chksubn, obses, MascNum " + ;
                   "FROM SigMvCab " + ;
                   "WHERE " + par_cColGrupo + " = " + EscaparSQL(PADR(par_cGrupo, 10)) + ;
                   " AND " + par_cColConta + " = " + EscaparSQL(PADR(par_cConta, 10)) + ;
                   " ORDER BY emps, dopes, numes, datas, chksubn"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ConSql")

        IF loc_lOk
            SELECT cursor_4c_ConSql
            SCAN
                loc_cOpe = ALLTRIM(NVL(cursor_4c_ConSql.dopes, ""))

                IF (loc_cOpe == loc_cOpConFor OR loc_cOpe == loc_cOpConSlj) AND ;
                        !THIS.BitParaLogico(cursor_4c_ConSql.chksubn)

                    IF loc_cOpe == loc_cOpConFor
                        loc_cOperDesc = "C.Cliente : " + ;
                            ALLTRIM(NVL(cursor_4c_ConSql.mascnum, ""))
                    ELSE
                        loc_cOperDesc = "C.Loja : " + ;
                            ALLTRIM(NVL(cursor_4c_ConSql.mascnum, ""))
                    ENDIF

                    INSERT INTO cursor_4c_Conserto (datas, emps, opers, obscon) ;
                        VALUES (THIS.DataDoCursor(cursor_4c_ConSql.datas), ;
                                NVL(cursor_4c_ConSql.emps, ""), ;
                                PADR(loc_cOperDesc, 27), ;
                                PADR(LEFT(NVL(cursor_4c_ConSql.obses, ""), 50), 50))

                    THIS.this_lSemDados = .F.
                ENDIF

                SELECT cursor_4c_ConSql
            ENDSCAN

            USE IN cursor_4c_ConSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarPendencias - "Processando Pendencias...": tres fontes somadas
    * em dbParcela (grade "Pendencias"):
    *   1. parcelas de SigMvPar das operacoes de ORIGEM  (grupoos/contaos);
    *   2. parcelas de SigMvPar das operacoes de DESTINO (grupods/contads);
    *   3. lancamentos em aberto de conta corrente (SigMvCcr).
    * So entra o que ainda tem saldo (valos - vpags > 0).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarPendencias(par_cGrupo, par_cConta)
        LOCAL loc_lOk

        THIS.MostrarProgresso("Processando Pend" + CHR(234) + "ncias...")
        THIS.ZapCursor("cursor_4c_Parcela")

        loc_lOk = THIS.CarregarParcelasPar(par_cGrupo, par_cConta, "grupoos", "contaos")

        IF loc_lOk
            loc_lOk = THIS.CarregarParcelasPar(par_cGrupo, par_cConta, "grupods", "contads")
        ENDIF

        IF loc_lOk
            loc_lOk = THIS.CarregarPendenciasContaCorrente(par_cGrupo, par_cConta)
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParcelasPar - corpo repetido duas vezes no legado (TprMvCab5 /
    * TmpPar1 e TprMvCab6 / TmpPar2).
    *
    * Dois filtros do legado que NAO se descartam:
    *   - a OPERACAO precisa gerar pendencia (crSigCdOpe.valpends = 1);
    *   - a FORMA DE PAGAMENTO tambem (crSigOpFp.valpends = 1); e quando ela
    *     eh cheque (infos = 'C'), o cheque so conta se ainda nao foi
    *     movimentado para fora de 'CR' (SigChe.umovs -> SigCdOpt.tipos).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarParcelasPar(par_cGrupo, par_cConta, par_cColGrupo, par_cColConta)
        LOCAL loc_cSQL, loc_lOk, loc_cEDNs, loc_nValor, loc_cHist, loc_lPula

        loc_cSQL = "SELECT emps, dopes, numes FROM SigMvCab " + ;
                   "WHERE " + par_cColGrupo + " = " + EscaparSQL(PADR(par_cGrupo, 10)) + ;
                   " AND " + par_cColConta + " = " + EscaparSQL(PADR(par_cConta, 10)) + ;
                   " ORDER BY emps, dopes, numes"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ParCabSql")

        IF !loc_lOk
            RETURN .F.
        ENDIF

        SELECT cursor_4c_ParCabSql
        SCAN
            SELECT crSigCdOpe
            SET ORDER TO Dopes
            =SEEK(PADR(ALLTRIM(NVL(cursor_4c_ParCabSql.dopes, "")), 20))

            IF NVL(crSigCdOpe.valpends, 0) != 1
                SELECT cursor_4c_ParCabSql
                LOOP
            ENDIF

            *-- empdopnums: chave POSICIONAL char(29), montada com PADR
            loc_cEDNs = PADR(NVL(cursor_4c_ParCabSql.emps, ""), 3) + ;
                        PADR(NVL(cursor_4c_ParCabSql.dopes, ""), 20) + ;
                        STR(NVL(cursor_4c_ParCabSql.numes, 0), 6)

            loc_cSQL = "SELECT emps, dopes, numes, bancos, agencias, contas, " + ;
                       "numeros, fpags, valos, vpags, vencs, moefpgs " + ;
                       "FROM SigMvPar WHERE empdopnums = " + EscaparSQL(loc_cEDNs) + ;
                       " ORDER BY vencs, emps, dopes, numes, bancos, agencias, " + ;
                       "contas, numeros, fpags, valos, vpags, moefpgs"

            loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_ParSql")

            IF !loc_lOk
                EXIT
            ENDIF

            SELECT cursor_4c_ParSql
            SCAN
                SELECT crSigOpFp
                SET ORDER TO FPags
                =SEEK(PADR(ALLTRIM(NVL(cursor_4c_ParSql.fpags, "")), 12))

                IF NVL(crSigOpFp.valpends, 0) != 1
                    SELECT cursor_4c_ParSql
                    LOOP
                ENDIF

                loc_lPula = .F.

                IF ALLTRIM(NVL(crSigOpFp.infos, "")) == "C"
                    loc_lPula = THIS.ChequeJaMovimentado( ;
                        NVL(cursor_4c_ParSql.bancos, ""), ;
                        NVL(cursor_4c_ParSql.agencias, ""), ;
                        NVL(cursor_4c_ParSql.contas, ""), ;
                        NVL(cursor_4c_ParSql.numeros, ""))
                ENDIF

                IF loc_lPula
                    SELECT cursor_4c_ParSql
                    LOOP
                ENDIF

                loc_cHist = ALLTRIM(NVL(cursor_4c_ParSql.fpags, "")) + " - " + ;
                            ALLTRIM(NVL(cursor_4c_ParSql.emps, "")) + ;
                            ALLTRIM(NVL(cursor_4c_ParSql.dopes, "")) + ":" + ;
                            fGerMascara(NVL(cursor_4c_ParSql.numes, 0))

                loc_nValor = NVL(cursor_4c_ParSql.valos, 0) - ;
                             NVL(cursor_4c_ParSql.vpags, 0)

                IF loc_nValor > 0
                    INSERT INTO cursor_4c_Parcela ;
                        (vencs, emps, fpags, valos, moefpgs, dopes, numes, hists) ;
                        VALUES (THIS.DataDoCursor(cursor_4c_ParSql.vencs), ;
                                NVL(cursor_4c_ParSql.emps, ""), ;
                                NVL(cursor_4c_ParSql.fpags, ""), ;
                                loc_nValor, ;
                                NVL(cursor_4c_ParSql.moefpgs, ""), ;
                                NVL(cursor_4c_ParSql.dopes, ""), ;
                                NVL(cursor_4c_ParSql.numes, 0), ;
                                loc_cHist)
                    THIS.this_lSemDados = .F.
                ENDIF

                SELECT cursor_4c_ParSql
            ENDSCAN

            USE IN cursor_4c_ParSql
            SELECT cursor_4c_ParCabSql
        ENDSCAN

        IF USED("cursor_4c_ParCabSql")
            USE IN cursor_4c_ParCabSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ChequeJaMovimentado - bloco "If CrSigOpFp.infos = 'C'" do legado: o
    * cheque da parcela deixa de ser pendencia quando ja foi movimentado para
    * uma operacao de caixa que nao eh 'CR'.
    *
    * Cheque NAO encontrado em SigChe nao pula a parcela (o legado so testa
    * dentro de "If !Eof()").
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ChequeJaMovimentado(par_cBanco, par_cAgencia, par_cConta, par_cNumero)
        LOCAL loc_cSQL, loc_lPula

        loc_lPula = .F.

        loc_cSQL = "SELECT umovs FROM SigChe " + ;
                   "WHERE bancos = " + EscaparSQL(ALLTRIM(par_cBanco)) + ;
                   " AND agencias = " + EscaparSQL(ALLTRIM(par_cAgencia)) + ;
                   " AND ncontas = " + EscaparSQL(ALLTRIM(par_cConta)) + ;
                   " AND ncheques = " + EscaparSQL(ALLTRIM(par_cNumero))

        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_CheSql")
            SELECT cursor_4c_CheSql
            GO TOP
            IF !EOF()
                SELECT crSigCdOpt
                SET ORDER TO Operacaos
                IF SEEK(PADR(ALLTRIM(NVL(cursor_4c_CheSql.umovs, "")), 15))
                    loc_lPula = (ALLTRIM(NVL(crSigCdOpt.tipos, "")) != "CR")
                ENDIF
            ENDIF
            USE IN cursor_4c_CheSql
        ENDIF

        RETURN loc_lPula
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPendenciasContaCorrente - terceira fonte de dbParcela: os
    * lancamentos de SigMvCcr ainda em aberto (valors - valpags > 0).
    *
    * ATENCAO ao tamanho da chave: o legado monta lcGCMs com Padr(grupo,10) +
    * Padr(conta,10) = 20 caracteres e compara com gruconmoes, que eh
    * char(23) (grupo + conta + MOEDA). Pelo padding ANSI do SQL Server, uma
    * chave de 20 caracteres casa apenas com as linhas cujo segmento de moeda
    * esta em branco. Transcrito literalmente (regra #17 - a abrangencia do
    * filtro eh regra de negocio, nao detalhe de migracao), mas registrado
    * aqui porque eh contra-intuitivo ao ler a tela de Pendencias.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarPendenciasContaCorrente(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_lOk, loc_cChave, loc_nValor

        loc_cChave = PADR(par_cGrupo, 10) + PADR(par_cConta, 10)

        loc_cSQL = "SELECT emps, dopes, numes, hists, vencs, " + ;
                   "moedas AS moefpgs, opers, nopers, valors, valpags " + ;
                   "FROM SigMvCcr " + ;
                   "WHERE gruconmoes = " + EscaparSQL(loc_cChave) + ;
                   " AND ( ( dopes = " + EscaparSQL(SPACE(20)) + " AND numes = 0 ) " + ;
                   "OR ( dopes <> ' ' AND numes <> 0 AND Tipos = 'X' ) ) " + ;
                   "AND opers <> 'D' AND nopers <> 0 " + ;
                   "ORDER BY vencs, emps, dopes, numes, hists, moedas, " + ;
                   "opers, nopers, valors, valpags"

        loc_lOk = THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_CcrSql")

        IF loc_lOk
            SELECT cursor_4c_CcrSql
            SCAN
                loc_nValor = NVL(cursor_4c_CcrSql.valors, 0) - ;
                             NVL(cursor_4c_CcrSql.valpags, 0)

                IF loc_nValor > 0
                    *-- fpags fica vazio: o legado usa "Insert From MemVar" e
                    *-- esta consulta nao traz a forma de pagamento.
                    INSERT INTO cursor_4c_Parcela ;
                        (vencs, emps, fpags, valos, moefpgs, dopes, numes, hists) ;
                        VALUES (THIS.DataDoCursor(cursor_4c_CcrSql.vencs), ;
                                NVL(cursor_4c_CcrSql.emps, ""), ;
                                "", ;
                                loc_nValor, ;
                                NVL(cursor_4c_CcrSql.moefpgs, ""), ;
                                NVL(cursor_4c_CcrSql.dopes, ""), ;
                                NVL(cursor_4c_CcrSql.numes, 0), ;
                                NVL(cursor_4c_CcrSql.hists, ""))
                    THIS.this_lSemDados = .F.
                ENDIF

                SELECT cursor_4c_CcrSql
            ENDSCAN

            USE IN cursor_4c_CcrSql
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MoedaTemCotacao - o "Seek(cmoes,'CrSigCdCot','cmoes')" que o legado faz
    * ANTES de chamar fCarregarCambio no laco de movimentacao (sem cotacao
    * cadastrada, a taxa fica 1).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MoedaTemCotacao(par_cMoeda)
        IF !USED("crSigCdCot") OR EMPTY(NVL(par_cMoeda, ""))
            RETURN .F.
        ENDIF

        SELECT crSigCdCot
        SET ORDER TO CMoes

        RETURN SEEK(PADR(ALLTRIM(par_cMoeda), 3))
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMoedaPadrao - CrSigCdPam.moedaps, a moeda padrao do sistema, usada
    * para converter item de operacao que nao tem moeda propria.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterMoedaPadrao()
        IF !USED("crSigCdPam") OR RECCOUNT("crSigCdPam") = 0
            RETURN ""
        ENDIF

        RETURN ALLTRIM(TratarNulo(crSigCdPam.moedaps, ""))
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarParametrosGrupo - "=Seek(lcGrEst,'CrSigCdGcr','Codigos')" do fim
    * de Processa: guarda mfotos, que decide se a Pagina Resultado mostra a
    * foto do fornecedor.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarParametrosGrupo(par_cGrupo)
        THIS.this_nMFotos = 0

        IF USED("crSigCdGcr")
            SELECT crSigCdGcr
            SET ORDER TO Codigos
            IF SEEK(PADR(ALLTRIM(NVL(par_cGrupo, "")), 10))
                THIS.this_nMFotos = NVL(crSigCdGcr.mfotos, 0)
            ENDIF
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PosicionarCursores - os "Select dbX / Go Top" do legado. Popular cursor
    * NAO repinta a grade: sem GO TOP + Grid.Refresh (que o Form faz em
    * CarregarLista) a grade fica visualmente vazia com o cursor cheio.
    *--------------------------------------------------------------------------
    PROCEDURE PosicionarCursores()
        LOCAL loc_aCur[8], loc_nI

        loc_aCur[1] = "cursor_4c_Saldo"
        loc_aCur[2] = "cursor_4c_Historico"
        loc_aCur[3] = "cursor_4c_ProdFor"
        loc_aCur[4] = "cursor_4c_Resumo"
        loc_aCur[5] = "cursor_4c_OperaProd"
        loc_aCur[6] = "cursor_4c_Estoque"
        loc_aCur[7] = "cursor_4c_Conserto"
        loc_aCur[8] = "cursor_4c_Parcela"

        FOR loc_nI = 1 TO 8
            IF USED(loc_aCur[loc_nI])
                SELECT (loc_aCur[loc_nI])
                GO TOP
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosImpressao - espelha o metodo ProcImp() do legado, que monta
    * os DOIS cursores que o FRX SigOpCgc consome.
    *
    * Os nomes TmpRelat e TmpFinal sao CONTRATO com o FRX, nao escolha de
    * nomenclatura: o .frt referencia TmpFinal.tEstoque / tCusto / tVenda
    * explicitamente, e o cursor de dados eh lido pelo alias corrente. O
    * mesmo vale para a variavel PUBLIC _Moeda, impressa no cabecalho.
    *
    * par_nOpcao  = ImprimeOpcoes.Opcao.Value - 1 = so o produto selecionado,
    *               2 = todos os produtos, 3 = todos COM movimentacao.
    * par_nFiltro = OptSituas.Value da aba Movimentacao - 1 = Ativo,
    *               2 = Inativo, 3 = Ambos (sem filtro).
    *
    * As variaveis locais aparecem com o prefixo "m." dentro dos SELECT VFP:
    * sem ele o otimizador resolve o identificador como COLUNA e estoura
    * "SQL: Column 'LOC_NFILTRO' is not found".
    *--------------------------------------------------------------------------
    FUNCTION PrepararDadosImpressao(par_nOpcao, par_nFiltro)
        LOCAL loc_lOk, loc_oErro, loc_nFiltro, loc_nOpcao

        loc_lOk     = .F.
        loc_nOpcao  = INT(NVL(par_nOpcao, 2))
        loc_nFiltro = INT(NVL(par_nFiltro, 3))

        TRY
            *-- _Fornece / _Moeda / _Produto: PUBLIC no legado porque o FRX as
            *-- le direto. Mantidas PUBLIC aqui pelo mesmo motivo, com espelho
            *-- nas properties do BO para quem precisar delas em codigo.
            PUBLIC _Fornece, _Moeda, _Produto

            THIS.this_cFornece = "Conta : " + ALLTRIM(NVL(THIS.this_cGrupo, "")) + ;
                " / " + ALLTRIM(NVL(THIS.this_cConta, "")) + " [ " + ;
                ALLTRIM(NVL(THIS.this_cDConta, "")) + " ] "

            THIS.this_cMoedaRelatorio = ALLTRIM(NVL(THIS.this_cMoeda, ""))

            THIS.this_cProdutoAtual = ""
            IF USED("cursor_4c_ProdFor") AND !EOF("cursor_4c_ProdFor")
                THIS.this_cProdutoAtual = cursor_4c_ProdFor.cpros
            ENDIF

            _Fornece = THIS.this_cFornece
            _Moeda   = THIS.this_cMoedaRelatorio
            _Produto = THIS.this_cProdutoAtual

            IF USED("TmpTot1")
                USE IN TmpTot1
            ENDIF
            SELECT SUM(custofs * estoque) AS custofs, moecusfs ;
                FROM cursor_4c_ProdFor ;
                GROUP BY moecusfs ;
                INTO CURSOR TmpTot1 READWRITE

            IF USED("TmpTot2")
                USE IN TmpTot2
            ENDIF
            SELECT SUM(pvens * estoque) AS pvens, moedas ;
                FROM cursor_4c_ProdFor ;
                GROUP BY moedas ;
                INTO CURSOR TmpTot2 READWRITE

            *-- Linha de TOTAIS do relatorio (coluna = 4). O cpros preenchido
            *-- com Chr(255) garante que ela ordene DEPOIS de qualquer produto.
            IF USED("TmpTot3")
                USE IN TmpTot3
            ENDIF
            SELECT 4 AS coluna, PADR(REPLICATE(CHR(255), 2), 14) AS cpros, ;
                   c.custofs, c.moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                   0 AS vlvend, 0 AS estoque, SPACE(3) AS cunis, v.pvens, ;
                   v.moedas, SPACE(40) AS reffs, SPACE(40) AS dpros, ;
                   SPACE(20) AS dopes, 0 AS qtds, 0 AS valos, ;
                   m._Fornece AS fornece ;
                FROM TmpTot1 c ;
                FULL JOIN TmpTot2 v ON c.moecusfs = v.moedas ;
                INTO CURSOR TmpTot3 READWRITE

            IF USED("TmpRelat")
                USE IN TmpRelat
            ENDIF

            DO CASE
                CASE loc_nOpcao = 1
                    *-- so o produto selecionado na grade
                    SELECT 1 AS coluna, a.*, b.dopes, b.qtds, b.valos, ;
                           m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor a ;
                        LEFT JOIN cursor_4c_OperaProd b ON a.cpros = b.cpros ;
                        WHERE a.cpros = m._Produto ;
                          AND IIF(m.loc_nFiltro != 3, a.situas = m.loc_nFiltro, .T.) ;
                        INTO CURSOR TmpRelat READWRITE

                CASE loc_nOpcao = 2
                    *-- todos os produtos + total por operacao + total por
                    *-- unidade + a linha de totais de TmpTot3
                    SELECT 1 AS coluna, a.*, b.dopes, b.qtds, b.valos, ;
                           m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor a ;
                        LEFT JOIN cursor_4c_OperaProd b ON a.cpros = b.cpros ;
                        WHERE IIF(m.loc_nFiltro != 3, a.situas = m.loc_nFiltro, .T.) ;
                    UNION ALL ;
                    SELECT 2 AS coluna, SPACE(14) AS cpros, c.custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, 0 AS estoque, SPACE(3) AS cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, 1 AS situas, c.dopes, 0 AS qtds, ;
                           c.valos, m._Fornece AS fornece ;
                        FROM cursor_4c_Resumo c ;
                    UNION ALL ;
                    SELECT 3 AS coluna, PADR(CHR(255), 14) AS cpros, 0 AS custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, SUM(d.estoque) AS estoque, d.cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, d.situas, SPACE(20) AS dopes, ;
                           0 AS qtds, 0 AS valos, m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor d ;
                        WHERE IIF(m.loc_nFiltro != 3, d.situas = m.loc_nFiltro, .T.) ;
                        GROUP BY d.cunis, d.situas ;
                    UNION ALL ;
                    SELECT e.coluna, e.cpros, IIF(ISNULL(e.custofs), 0, e.custofs) AS custofs, ;
                           IIF(ISNULL(e.moecusfs), SPACE(3), e.moecusfs) AS moecusfs, ;
                           e.marca, e.qtvend, e.vlvend, e.estoque, e.cunis, ;
                           IIF(ISNULL(e.pvens), 0, e.pvens) AS pvens, ;
                           IIF(ISNULL(e.moedas), SPACE(3), e.moedas) AS moedas, ;
                           e.reffs, e.dpros, 1 AS situas, e.dopes, e.qtds, ;
                           e.valos, e.fornece ;
                        FROM TmpTot3 e ;
                        ORDER BY 1, 2, 14 ;
                        INTO CURSOR TmpRelat READWRITE

                OTHERWISE
                    *-- Opcao 3 - identica a 2, mas o primeiro SELECT usa JOIN
                    *-- INTERNO: so produto que TEM movimentacao no periodo.
                    SELECT 1 AS coluna, a.*, b.dopes, b.qtds, b.valos, ;
                           m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor a, cursor_4c_OperaProd b ;
                        WHERE a.cpros = b.cpros ;
                          AND IIF(m.loc_nFiltro != 3, a.situas = m.loc_nFiltro, .T.) ;
                    UNION ALL ;
                    SELECT 2 AS coluna, SPACE(14) AS cpros, c.custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, 0 AS estoque, SPACE(3) AS cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, 1 AS situas, c.dopes, 0 AS qtds, ;
                           c.valos, m._Fornece AS fornece ;
                        FROM cursor_4c_Resumo c ;
                    UNION ALL ;
                    SELECT 3 AS coluna, PADR(CHR(255), 14) AS cpros, 0 AS custofs, ;
                           SPACE(3) AS moecusfs, SPACE(1) AS marca, 0 AS qtvend, ;
                           0 AS vlvend, SUM(d.estoque) AS estoque, d.cunis, ;
                           0 AS pvens, SPACE(3) AS moedas, SPACE(40) AS reffs, ;
                           SPACE(40) AS dpros, d.situas, SPACE(20) AS dopes, ;
                           0 AS qtds, 0 AS valos, m._Fornece AS fornece ;
                        FROM cursor_4c_ProdFor d ;
                        WHERE IIF(m.loc_nFiltro != 3, d.situas = m.loc_nFiltro, .T.) ;
                        GROUP BY d.cunis, d.situas ;
                    UNION ALL ;
                    SELECT e.coluna, e.cpros, IIF(ISNULL(e.custofs), 0, e.custofs) AS custofs, ;
                           IIF(ISNULL(e.moecusfs), SPACE(3), e.moecusfs) AS moecusfs, ;
                           e.marca, e.qtvend, e.vlvend, e.estoque, e.cunis, ;
                           IIF(ISNULL(e.pvens), 0, e.pvens) AS pvens, ;
                           IIF(ISNULL(e.moedas), SPACE(3), e.moedas) AS moedas, ;
                           e.reffs, e.dpros, 1 AS situas, e.dopes, e.qtds, ;
                           e.valos, e.fornece ;
                        FROM TmpTot3 e ;
                        ORDER BY 1, 2, 14 ;
                        INTO CURSOR TmpRelat READWRITE
            ENDCASE

            loc_lOk = THIS.MontarTotaisImpressao(loc_nOpcao, loc_nFiltro)
        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.this_cMensagemErro = loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure
            MsgErro(THIS.this_cMensagemErro, "Erro ao preparar a impress" + CHR(227) + "o")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarTotaisImpressao - o cursor TmpFinal do ProcImp legado (totais de
    * estoque, custo e venda convertidos para a moeda do filtro).
    *
    * O legado monta isso com um SELECT ... Sum(... fCarregarCambio(...) ...)
    * Group by 1. Aqui o somatorio eh feito por SCAN: fCarregarCambio nao
    * existe como funcao global (nao foi portada) e a cotacao vem de
    * THIS.CarregarCambio, que nao se pode chamar de dentro de um SELECT. O
    * resultado numerico eh o mesmo - muda apenas por onde a conta passa.
    *
    * Na Opcao 1 o legado cria TmpFinal VAZIO (o relatorio de um produto so
    * nao imprime totais) - reproduzido deixando o cursor sem registro.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MontarTotaisImpressao(par_nOpcao, par_nFiltro)
        LOCAL loc_nEstoque, loc_nCusto, loc_nVenda, loc_nCotMoeda, ;
              loc_nCotCusto, loc_nCotVenda

        IF USED("TmpFinal")
            USE IN TmpFinal
        ENDIF

        CREATE CURSOR TmpFinal ( ;
            Agrupar C(1), TEstoque N(16,3), TCusto N(16,2), TVenda N(16,2))

        IF par_nOpcao = 1
            RETURN .T.
        ENDIF

        loc_nEstoque  = 0
        loc_nCusto    = 0
        loc_nVenda    = 0
        loc_nCotMoeda = THIS.CarregarCambio(THIS.this_cMoedaRelatorio, DATE())

        IF USED("cursor_4c_ProdFor")
            SELECT cursor_4c_ProdFor
            GO TOP
            SCAN
                IF par_nFiltro != 3 AND NVL(cursor_4c_ProdFor.situas, 0) != par_nFiltro
                    SELECT cursor_4c_ProdFor
                    LOOP
                ENDIF

                loc_nCotCusto = THIS.CarregarCambio(cursor_4c_ProdFor.moecusfs, DATE())
                loc_nCotVenda = THIS.CarregarCambio(cursor_4c_ProdFor.moedas, DATE())

                loc_nEstoque = loc_nEstoque + NVL(cursor_4c_ProdFor.estoque, 0)

                loc_nCusto = loc_nCusto + (NVL(cursor_4c_ProdFor.estoque, 0) * ;
                    (NVL(cursor_4c_ProdFor.custofs, 0) * loc_nCotCusto / loc_nCotMoeda))

                loc_nVenda = loc_nVenda + (NVL(cursor_4c_ProdFor.estoque, 0) * ;
                    (NVL(cursor_4c_ProdFor.pvens, 0) * loc_nCotVenda / loc_nCotMoeda))

                SELECT cursor_4c_ProdFor
            ENDSCAN
        ENDIF

        INSERT INTO TmpFinal (Agrupar, TEstoque, TCusto, TVenda) ;
            VALUES (" ", loc_nEstoque, ROUND(loc_nCusto, 2), ROUND(loc_nVenda, 2))

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarRelatorio - "Report Form SIGOPCGC Preview NoConsole" e
    * "Report Form SIGOPCGC To PRINTER Prompt Noconsole" do legado, com os tres
    * cuidados obrigatorios do projeto:
    *   1. guard IF FILE() - FRX ausente tem de dizer QUAL arquivo falta;
    *   2. isolamento de locale (SET POINT/SEPARATOR/REPORTBEHAVIOR) - FRX
    *      legado Fortyus foi desenhado com POINT="." e REPORTBEHAVIOR 80, e
    *      no default do VFP9 os campos numericos saem como asteriscos;
    *   3. restauracao do menu - o _MREPORT do preview corrompe o _MSYSMENU.
    *
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT"
    *--------------------------------------------------------------------------
    FUNCTION ExecutarRelatorio(par_cModo)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_lOk

        loc_lOk  = .F.
        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + "SigOpCgc.frx")

        IF !FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o encontrado:" + CHR(13) + loc_cFRX, "Erro")
            RETURN .F.
        ENDIF

        IF !USED("TmpRelat") OR RECCOUNT("TmpRelat") = 0
            MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        SELECT TmpRelat
        GO TOP

        DO CASE
            CASE UPPER(ALLTRIM(NVL(par_cModo, ""))) == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE UPPER(ALLTRIM(NVL(par_cModo, ""))) == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            OTHERWISE
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        loc_lOk = .T.

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
                popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado)
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * LiberarCursoresImpressao - "Use In TmpRelat / Use In TmpFinal" que o
    * legado executa depois de cada Report Form.
    *--------------------------------------------------------------------------
    PROCEDURE LiberarCursoresImpressao()
        LOCAL loc_aCur[4], loc_nI

        loc_aCur[1] = "TmpRelat"
        loc_aCur[2] = "TmpFinal"
        loc_aCur[3] = "TmpTot1"
        loc_aCur[4] = "TmpTot2"

        FOR loc_nI = 1 TO 4
            IF USED(loc_aCur[loc_nI])
                USE IN (loc_aCur[loc_nI])
            ENDIF
        ENDFOR

        IF USED("TmpTot3")
            USE IN TmpTot3
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarImagemMemo - grava em arquivo o conteudo de uma coluna "text" de
    * imagem (SigCdCli.figjpgs / SigCdPro.figjpgs).
    *
    * As DUAS rotinas do legado leem a MESMA coluna de formas diferentes: o
    * fim de Processa usa "Copy Memo ... To arquivo" (conteudo BRUTO) e o
    * AfterRowColChange da aba Estoque faz Strconv(...,14), isto eh decodifica
    * BASE64 depois de tirar o prefixo "data:image/...;base64,". Em vez de
    * escolher uma e errar a outra, aqui o conteudo eh decodificado so quando
    * o resultado tem assinatura de imagem conhecida (JPEG/PNG/GIF/BMP);
    * fora disso vai bruto, como no caminho antigo.
    *--------------------------------------------------------------------------
    FUNCTION GravarImagemMemo(par_cConteudo, par_cArquivo)
        LOCAL loc_cDados, loc_cBase, loc_cDecod, loc_cSafety, loc_lOk, loc_oErro

        loc_lOk   = .F.
        loc_cDados = NVL(par_cConteudo, "")

        IF EMPTY(loc_cDados) OR EMPTY(NVL(par_cArquivo, ""))
            RETURN .F.
        ENDIF

        TRY
            loc_cBase = STRTRAN(loc_cDados, "data:image/png;base64,",  "")
            loc_cBase = STRTRAN(loc_cBase,  "data:image/jpeg;base64,", "")
            loc_cBase = STRTRAN(loc_cBase,  "data:image/jpg;base64,",  "")

            loc_cDecod = ""
            TRY
                loc_cDecod = STRCONV(loc_cBase, 14)
            CATCH TO loc_oErro
                loc_cDecod = ""
            ENDTRY

            IF THIS.TemAssinaturaDeImagem(loc_cDecod)
                loc_cDados = loc_cDecod
            ENDIF

            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            STRTOFILE(loc_cDados, par_cArquivo)
            IF loc_cSafety = "ON"
                SET SAFETY ON
            ENDIF

            loc_lOk = FILE(par_cArquivo)
        CATCH TO loc_oErro
            loc_lOk = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * TemAssinaturaDeImagem - confere os bytes iniciais de JPEG, PNG, GIF e
    * BMP. Eh o que decide, em GravarImagemMemo, se o conteudo da coluna
    * estava em BASE64 ou bruto.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION TemAssinaturaDeImagem(par_cDados)
        LOCAL loc_cIni

        IF EMPTY(NVL(par_cDados, "")) OR LEN(par_cDados) < 4
            RETURN .F.
        ENDIF

        loc_cIni = LEFT(par_cDados, 4)

        DO CASE
            CASE LEFT(loc_cIni, 2) == CHR(255) + CHR(216)                && JPEG
                RETURN .T.
            CASE loc_cIni == CHR(137) + "PNG"                            && PNG
                RETURN .T.
            CASE LEFT(loc_cIni, 3) == "GIF"                              && GIF
                RETURN .T.
            CASE LEFT(loc_cIni, 2) == "BM"                               && BMP
                RETURN .T.
        ENDCASE

        RETURN .F.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterArquivoFotoFornecedor - bloco final de Processa: a foto do
    * fornecedor so eh exibida quando o GRUPO de contas esta marcado para
    * mostrar foto (CrSigCdGcr.mfotos = 1). Devolve "" quando nao ha foto.
    * Arquivo temporario Temp4.jpg, o mesmo nome do legado.
    *--------------------------------------------------------------------------
    FUNCTION ObterArquivoFotoFornecedor()
        LOCAL loc_cArquivo

        IF THIS.this_nMFotos != 1 OR EMPTY(NVL(THIS.this_cFigJpg, ""))
            RETURN ""
        ENDIF

        loc_cArquivo = ADDBS(SYS(2023)) + "Temp4.jpg"

        IF THIS.GravarImagemMemo(THIS.this_cFigJpg, loc_cArquivo)
            RETURN loc_cArquivo
        ENDIF

        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarFotoProduto - AfterRowColChange da grade da aba Estoque:
    * le SigCdPro.figjpgs do produto da linha corrente e grava Temp5.jpg (o
    * mesmo nome do legado). Devolve "" quando o produto nao tem foto.
    *--------------------------------------------------------------------------
    FUNCTION CarregarFotoProduto(par_cProduto)
        LOCAL loc_cSQL, loc_cArquivo, loc_cConteudo, loc_cRetorno

        loc_cRetorno = ""

        IF EMPTY(ALLTRIM(NVL(par_cProduto, "")))
            RETURN ""
        ENDIF

        loc_cSQL = "SELECT figjpgs FROM SigCdPro WHERE cpros = " + ;
                   EscaparSQL(ALLTRIM(par_cProduto))

        IF THIS.ExecutarConsulta(loc_cSQL, "cursor_4c_FotoSql")
            SELECT cursor_4c_FotoSql
            GO TOP
            loc_cConteudo = ""
            IF !EOF()
                loc_cConteudo = TratarNulo(cursor_4c_FotoSql.figjpgs, "")
            ENDIF
            USE IN cursor_4c_FotoSql

            IF !EMPTY(loc_cConteudo)
                loc_cArquivo = ADDBS(SYS(2023)) + "Temp5.jpg"
                IF THIS.GravarImagemMemo(loc_cConteudo, loc_cArquivo)
                    loc_cRetorno = loc_cArquivo
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - NAO sobrescritos de proposito.
    *
    * SIGOPCGC eh form de CONSULTA (Consulta Generica de Compras): o codigo
    * legado inteiro (871 linhas do metodo Processa + os demais eventos de
    * comportamento.json) so executa SELECT/SqlExecute para exibir saldos,
    * historico, estoque, pendencias e conserto do fornecedor pesquisado -
    * nao ha nenhum Insert/Update/Delete no SCX original. O comportamento
    * padrao herdado de BusinessBase (recusar a operacao) ja eh o correto
    * aqui; sobrescrever esses metodos so para preencher criaria uma via de
    * gravacao que o sistema legado nunca teve.
    *--------------------------------------------------------------------------

ENDDEFINE
