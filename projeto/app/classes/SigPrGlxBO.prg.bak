*============================================================================
* SigPrGlxBO.prg - Business Object para Previa da Globalizacao (SIGPRGLX)
*
* Form OPERACIONAL (SIGPRGLX / FormSigPrGlx): processo de globalizacao de
* saldos de producao - consolida, por produto/cor/tamanho, o que esta em
* Estoque x em Producao x Pedido, permite ao usuario redistribuir saldo
* disponivel (Estoque/Producao em Fase/Requisicao de material - abas
* GradeDisp/GradeLinhas/GradeDisp-Pedras) e ao final grava os movimentos
* de transferencia/globalizacao (SigMvCab/SigMvItn/SigMvHst/SigBxEst/
* SigOpPic/SigPdMvf/SigCdNec/SigInAtz/SigCdNei) via Processar.Click do
* legado.
*
* NAO existe uma unica "tabela principal" para este processo (this_cTabela
* permanece vazio) - o BO opera sobre varios cursores temporarios (gerados
* a partir de SigMvHst/SigCdOpe/SigCdPro/TmpSaldo/TmpSaldG/etc, conforme
* tasks/task618/comportamento.json) e grava, ao confirmar, nas tabelas de
* movimento acima.
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - Metodos de carga/gravacao (CarregarDoCursor/
*                Inserir/Atualizar/ObterChavePrimaria/RegistrarAuditoria)
*============================================================================

DEFINE CLASS SigPrGlxBO AS BusinessBase

    *==========================================================================
    * Parametros recebidos do form que abre a previa (equivalente ao
    * Lparameters _ParentForm, _Data, _ReservaAuto, _nGerEmphPdr, _Autom,
    * _numeroOp, _PorDestino do Init legado). _ParentForm e _Data nao se
    * tornam propriedades do BO (referencia de form/ponto no tempo de
    * abertura, tratados pelo FormSigPrGlx); os demais pilotam o processo.
    *==========================================================================
    this_lReserva      = .F.       && thisform.Reserva    (_ReservaAuto) - reserva automatica de saldo
    this_nEmphPdr      = 0         && thisform.EmphPdr     (_nGerEmphPdr) - empresa padrao p/ geracao de movimento
    this_lAutomatico   = .F.       && thisform.Automatico  (_Autom) - globalizacao automatica (sem intervencao manual)
    this_nNumeroDaOp   = 0         && thisform.Numerodaop  (_numeroOp) - numero MANUAL da OP, NUMERICO (so usado se SigCdPam.GlobAutos=2)
    this_lPorDestino   = .F.       && thisform.PorDestino  (_PorDestino) - agrupa saldo por destino em vez de por linha (ThisForm.Pordestino)

    *==========================================================================
    * Parametros do sistema (SigCdPam), carregados uma unica vez no Init -
    * equivalente ao "Select CrSigCdPam / _Dopp = crSigCdPam.DoppPads /
    * _Dope = crSigCdPam.TransfRes / _DopEst = crSigCdPam.DopBxEsts" no
    * inicio do Processar.Click legado
    *==========================================================================
    this_cDoppPads     = SPACE(20) && SigCdPam.dopppads  - operacao padrao de producao
    this_cTransfRes    = SPACE(20) && SigCdPam.transfres - operacao padrao de transferencia/reserva
    this_cDopBxEsts    = SPACE(20) && SigCdPam.dopbxests - operacao padrao de baixa de estoque (nao usada por Processar - ver this_cPacDopEsts)

    *==========================================================================
    * Demais parametros de SigCdPam/SigCdPac usados por Processar() (dump
    * 4562-6466) - carregados em CarregarParametrosProcessamento(), igual ao
    * padrao ja adotado em SigPrGlpBO.Init/CarregarParametrosProcessamento.
    *==========================================================================
    this_cPamDopEmphs   = SPACE(20) && SigCdPam.dopemphs
    this_cPamDopReqcs   = SPACE(20) && SigCdPam.dopreqcs
    this_cPamDopPedcs   = SPACE(20) && SigCdPam.doppedcs
    this_cPamDopComps   = SPACE(20) && SigCdPam.dopcomps
    this_cPamDopTrfCps  = SPACE(20) && SigCdPam.doptrfcps
    this_cPamGruReservs = SPACE(10) && SigCdPam.grureservs
    this_cPamConReservs = SPACE(10) && SigCdPam.conreservs
    this_nPamAgrupEmph  = 0         && SigCdPam.agrupemph
    this_cPamOuros      = SPACE(14) && SigCdPam.ouros
    this_cPamTpOpEntAus = SPACE(15) && SigCdPam.tpopentaus
    this_cPamDopEntAus  = SPACE(20) && SigCdPam.dopentaus
    this_nPamAutComps   = 0         && SigCdPam.autcomps
    this_nPamGlobAutos  = 0         && SigCdPam.globautos
    this_cPamGruConfs   = SPACE(10) && SigCdPam.gruconfs
    this_cPamConConfs   = SPACE(10) && SigCdPam.conconfs

    this_cPacDopEsts    = SPACE(20) && SigCdPac.dopEsts    - operacao de baixa de estoque p/ fabricacao (_DopEst)
    this_cPacOpPdCompra = SPACE(20) && SigCdPac.OpPdCompra - operacao de pedido de compra de acabado
    this_nPacOpZers     = 0         && SigCdPac.OpZers
    this_nPacAgrupReqs  = 0         && SigCdPac.AgrupReqs  - 1=agrupa requisicao por fornecedor+prazo
    this_cSigKey        = SPACE(3)  && CrSigCdPac.sigKeys (Thisform.SigKey)
    this_nPacNMeses     = 0         && SigCdPac.nmeses numeric(2,0) - janela de analise de venda, exibida no rotulo "Periodo: NN meses" da Page1 (Init legado: Container5.lab_periodo.Caption)

    *==========================================================================
    * DbParam - o legado le um cursor "DBParam" de UMA linha (montado pelo
    * form avo - FormSigPrGlo - igual ao mesmo cursor que SigPrGlpBO
    * documenta) em CodTgOps/OpZers/EntPes. Nao portado; vira properties
    * resolvidas em CarregarDbParam() a partir do tipo de geracao que o FORM
    * le do grandparent (THIS.this_oFormPai.this_oParentForm).
    *==========================================================================
    this_cTipoGeracaoOP = SPACE(10) && _lcTpGOp (grandparent)
    this_lGerPorTp      = .F.       && ThisForm.GerPorTp do grandparent
    this_cDbCodTgOps    = SPACE(10) && DBParam.CodTgOps
    this_nDbOpZers      = 0         && DBParam.OpZers
    this_nDbEntPes      = 0         && DBParam.EntPes

    *==========================================================================
    * Previsao de entrega / data de geracao - no legado vem de
    * ThisForm.ParentForm.ParentForm.Cnt_Previsao.GetPrevisao/GetGeracao
    * (FormSigPrGl2.this_oParentForm = FormSigPrGlo). O FORM repassa para ca
    * em FormParaBO(), antes de chamar Processar() - mesmo padrao de
    * SigPrGlpBO.this_dPrevisao/this_dDataGeracao.
    *==========================================================================
    this_dPrevisao      = {}        && _Prev
    this_dDataGeracao   = {}        && _DtGera

    *==========================================================================
    * Resultado do processamento
    *==========================================================================
    this_nNumeroOpGerada = 0        && _Nump - numero da OP efetivada por Processar()

    *==========================================================================
    * Referencia do produto/cor/tamanho corrente na grade de itens
    * (TmpFinalg.Cpros/CodCors/CodTams - chave usada por quase todos os
    * metodos: Disponivel.Click, SelEstoque.Click, GradeItens.*, etc.)
    *==========================================================================
    this_cCpros        = SPACE(14) && TmpFinalg.Cpros  - SigCdPro.CPros
    this_cCodCors      = SPACE(10) && TmpFinalg.CodCors
    this_cCodTams      = SPACE(10) && TmpFinalg.CodTams

    *==========================================================================
    * Totais exibidos no rodape do form (Container1/Container3/Container5/
    * GradeItens) - somente leitura, recalculados a partir dos cursores
    * temporarios (TmpFinal/TmpFinalg) a cada alteracao de linha
    *==========================================================================
    this_nTotQtd       = 0  && Tot_Qtd  - saldo total selecionado
    this_nTotEst       = 0  && Tot_Est  - total em estoque
    this_nTotPrz       = 0  && Tot_Prz  - total disponivel/prioridade
    this_nTotPrdc      = 0  && Tot_prdc - total em producao
    this_nTotPrze      = 0  && Tot_prze - total em producao para estoque
    this_nTotVenda     = 0  && Tot_Venda - quantidade vendida no periodo analisado
    this_nQtdMinima    = 0  && Get_Minima - quantidade minima para producao

    *==========================================================================
    * Numero da operacao gerada durante o Processar (equivalente a _Rnop /
    * _Nump do legado) - preenchido ao gravar os movimentos de globalizacao
    *==========================================================================
    this_nNumeroOperacaoGerada = 0

    *==========================================================================
    * Init - Inicializa o Business Object. Nao ha tabela/chave primaria
    * unica para este processo (BO opera sobre cursores temporarios), mas
    * carrega os parametros padrao de operacao (SigCdPam) usados em todo o
    * fluxo de globalizacao
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                SQLEXEC(gnConnHandle, ;
                    "SELECT dopppads, transfres, dopbxests, dopemphs, dopreqcs, " + ;
                    "doppedcs, dopcomps, doptrfcps, grureservs, conreservs, " + ;
                    "agrupemph, ouros, tpopentaus, dopentaus, autcomps, " + ;
                    "globautos, gruconfs, conconfs FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")

                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    THIS.this_cDoppPads      = PADR(TratarNulo(cursor_4c_SigCdPam.dopppads, ""), 20)
                    THIS.this_cTransfRes     = PADR(TratarNulo(cursor_4c_SigCdPam.transfres, ""), 20)
                    THIS.this_cDopBxEsts     = PADR(TratarNulo(cursor_4c_SigCdPam.dopbxests, ""), 20)
                    THIS.this_cPamDopEmphs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopemphs, ""), 20)
                    THIS.this_cPamDopReqcs   = PADR(TratarNulo(cursor_4c_SigCdPam.dopreqcs, ""), 20)
                    THIS.this_cPamDopPedcs   = PADR(TratarNulo(cursor_4c_SigCdPam.doppedcs, ""), 20)
                    THIS.this_cPamDopComps   = PADR(TratarNulo(cursor_4c_SigCdPam.dopcomps, ""), 20)
                    THIS.this_cPamDopTrfCps  = PADR(TratarNulo(cursor_4c_SigCdPam.doptrfcps, ""), 20)
                    THIS.this_cPamGruReservs = PADR(TratarNulo(cursor_4c_SigCdPam.grureservs, ""), 10)
                    THIS.this_cPamConReservs = PADR(TratarNulo(cursor_4c_SigCdPam.conreservs, ""), 10)
                    THIS.this_nPamAgrupEmph  = TratarNulo(cursor_4c_SigCdPam.agrupemph, 0)
                    THIS.this_cPamOuros      = PADR(TratarNulo(cursor_4c_SigCdPam.ouros, ""), 14)
                    THIS.this_cPamTpOpEntAus = PADR(TratarNulo(cursor_4c_SigCdPam.tpopentaus, ""), 15)
                    THIS.this_cPamDopEntAus  = PADR(TratarNulo(cursor_4c_SigCdPam.dopentaus, ""), 20)
                    THIS.this_nPamAutComps   = TratarNulo(cursor_4c_SigCdPam.autcomps, 0)
                    THIS.this_nPamGlobAutos  = TratarNulo(cursor_4c_SigCdPam.globautos, 0)
                    THIS.this_cPamGruConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.gruconfs, ""), 10)
                    THIS.this_cPamConConfs   = PADR(TratarNulo(cursor_4c_SigCdPam.conconfs, ""), 10)
                ENDIF

                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF

                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT dopEsts, OpPdCompra, OpZers, AgrupReqs, sigKeys, nmeses FROM SigCdPac", ;
                    "cursor_4c_SigCdPac")
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    THIS.this_cPacDopEsts    = PADR(TratarNulo(cursor_4c_SigCdPac.dopEsts, ""), 20)
                    THIS.this_cPacOpPdCompra = PADR(TratarNulo(cursor_4c_SigCdPac.OpPdCompra, ""), 20)
                    THIS.this_nPacOpZers     = TratarNulo(cursor_4c_SigCdPac.OpZers, 0)
                    THIS.this_nPacAgrupReqs  = TratarNulo(cursor_4c_SigCdPac.AgrupReqs, 0)
                    THIS.this_cSigKey        = PADR(TratarNulo(cursor_4c_SigCdPac.sigKeys, ""), 3)
                    THIS.this_nPacNMeses     = TratarNulo(cursor_4c_SigCdPac.nmeses, 0)
                ENDIF
                IF USED("cursor_4c_SigCdPac")
                    USE IN cursor_4c_SigCdPac
                ENDIF

            ENDIF

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao inicializar: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - usada por RegistrarAuditoria() quando o processo
    * de globalizacao grava movimentos (SigMvCab/SigMvItn/SigMvHst/...).
    * Nao ha "registro desta entidade": a chave de auditoria eh o numero da
    * O.P. efetivada por Processar() (this_nNumeroOpGerada).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nNumeroOpGerada)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor() / Inserir() / Atualizar() / ExecutarExclusao():
    * este BO deliberadamente NAO sobrescreve esses metodos do BusinessBase.
    *
    * SigPrGlx eh um PROCESSO (previa/globalizacao de saldos), nao um
    * cadastro: nao existe uma unica tabela/cursor/registro que o form
    * carregue, edite e grave via Salvar()/Excluir(). O form OPERACIONAL
    * nao tem botoes de Incluir/Alterar/Excluir - a gravacao real ocorre
    * quando o usuario aciona Processar, que grava diretamente nas tabelas
    * de movimento (SigMvCab/SigMvItn/SigMvHst/SigBxEst/SigOpPic/SigPdMvf/
    * SigCdNec/SigInAtz/SigCdNei) atraves de um metodo proprio desta
    * classe, chamando RegistrarAuditoria() por conta propria quando essa
    * logica for incorporada. Ate la, os stubs herdados de BusinessBase
    * (que devolvem .F. com mensagem de erro) permanecem corretos, pois
    * Salvar()/Excluir() nunca sao acionados por este form.
    *==========================================================================

    *==========================================================================
    * CarregarFotoProduto - busca a figura tecnica do produto (SigCdPro.
    * FigJpgs) e grava decodificada em arquivo temporario, para exibicao em
    * Image (ImgFigJpg). Equivalente a Page1.ImgFigJpg.Click / Page2.
    * GradeItens.Procedure do legado:
    *   lcSql = "Select a.cpros,a.dpros,a.FigJpgs From SigCdPro a
    *             Where a.cpros = '<codigo>'"
    *   lcFoto = Strconv(Strtran(Strtran(Strtran(FigJpgs,
    *               "data:image/png;base64,", ""),
    *               "data:image/jpeg;base64,", ""),
    *               "data:image/jpg;base64,", ""), 14)
    *   StrToFile(lcFoto, lcArquivo)
    *
    * par_cCpros: SigCdPro.Cpros do produto corrente (TmpFinalg.Cpros)
    * par_cArquivoTemp: caminho completo do arquivo .jpg a gravar
    * Retorno: .T. se a figura existia e foi gravada; .F. se o produto nao
    * tem figura (nao eh erro) ou se a consulta falhou (this_cMensagemErro
    * descreve a falha neste ultimo caso)
    *==========================================================================
    FUNCTION CarregarFotoProduto(par_cCpros, par_cArquivoTemp)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFoto, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.FigJpgs FROM SigCdPro a " + ;
                "WHERE a.cpros = " + EscaparSQL(ALLTRIM(par_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoProduto")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao buscar figura do produto: " + CapturarErroSQL()
            ELSE
                IF USED("cursor_4c_FotoProduto") AND !EOF("cursor_4c_FotoProduto")
                    IF !EMPTY(cursor_4c_FotoProduto.FigJpgs) AND !ISNULL(cursor_4c_FotoProduto.FigJpgs)
                        loc_cFoto = STRTRAN(cursor_4c_FotoProduto.FigJpgs, "data:image/png;base64,", "")
                        loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
                        loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")
                        loc_cFoto = STRCONV(loc_cFoto, 14)

                        IF STRTOFILE(loc_cFoto, par_cArquivoTemp) > 0
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
            IF USED("cursor_4c_FotoProduto")
                USE IN cursor_4c_FotoProduto
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterTipoEstoqueProduto - resolve SigCdGrp.tipoestos do GRUPO do
    * produto, transcrevendo a cadeia de duas consultas do When de
    * GradeItens.Column10 (Page1, dump 7029-7043):
    *
    *   ThisForm.poDataMgr.CursorQuery('SigCdPro','crSigCdPro','CPros',
    *                                   TmpFinalg.Cpros,[Cgrus])
    *   ThisForm.poDataMgr.CursorQuery('SigCdGrp','crSigCdGrp','CGrus',
    *                                   crSigCdPro.CGrus,[TipoEstos])
    *   If InList(CrSigCdGrp.TipoEstos,3,4) ... Disponivel.Visible = .t.
    *
    * O form usa o retorno para decidir a visibilidade de cmd_4c_Disponivel
    * (o InList(.,3,4) fica no FORM, que eh quem conhece o botao).
    *
    * Retorna o tipo de estoque (numeric(1,0)) ou 0 quando o produto/grupo
    * nao for encontrado ou a conexao nao estiver disponivel - 0 nao esta em
    * (3,4), entao o caminho de falha mantem o botao oculto, que eh o estado
    * inicial do legado (Disponivel.Visible = .f. no SCX).
    *==========================================================================
    FUNCTION ObterTipoEstoqueProduto(par_cCpros)
        LOCAL loc_nTipo, loc_cGrupo, loc_oErro

        THIS.this_cMensagemErro = ""
        loc_nTipo = 0

        IF VARTYPE(par_cCpros) != "C" OR EMPTY(par_cCpros)
            RETURN 0
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN 0
        ENDIF

        TRY
            IF THIS.ConsultarTabela("SigCdPro", "cursor_4c_TipoEstPro", "cpros", ALLTRIM(par_cCpros))
                IF USED("cursor_4c_TipoEstPro") AND !EOF("cursor_4c_TipoEstPro")
                    loc_cGrupo = ALLTRIM(TratarNulo(cursor_4c_TipoEstPro.cgrus, ""))

                    IF !EMPTY(loc_cGrupo)
                        IF THIS.ConsultarTabela("SigCdGrp", "cursor_4c_TipoEstGrp", "cgrus", loc_cGrupo)
                            IF USED("cursor_4c_TipoEstGrp") AND !EOF("cursor_4c_TipoEstGrp")
                                loc_nTipo = TratarNulo(cursor_4c_TipoEstGrp.tipoestos, 0)
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_nTipo = 0
        ENDTRY

        IF USED("cursor_4c_TipoEstPro")
            USE IN cursor_4c_TipoEstPro
        ENDIF
        IF USED("cursor_4c_TipoEstGrp")
            USE IN cursor_4c_TipoEstGrp
        ENDIF

        RETURN loc_nTipo
    ENDFUNC

    *==========================================================================
    * Infraestrutura generica de Processar() - mesmos helpers (com a mesma
    * logica) ja adotados em SigPrGlpBO.prg para o form irmao SigPrGlp, que
    * resolve o mesmo problema (gerenciador de dados Fortyus com cursores
    * buferizados - poDataMgr.CursorQuery/SqlExecute/Update/Commit/RollBack -
    * que nao existe no sistema migrado).
    *==========================================================================

    *--------------------------------------------------------------------------
    * ExecutarSQL - substitui ThisForm.poDataMgr.SqlExecute(sql, cursor).
    * Preserva a area de trabalho corrente (o legado chama SqlExecute DENTRO
    * de SCAN sem reselecionar depois - SQLEXEC() troca a area selecionada).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarSQL(par_cSQL, par_cCursor, par_cRotulo)
        LOCAL loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        IF VARTYPE(par_cCursor) = "C" AND !EMPTY(par_cCursor)
            IF USED(par_cCursor)
                USE IN (par_cCursor)
            ENDIF
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL, par_cCursor)
        ELSE
            loc_nRet = SQLEXEC(gnConnHandle, par_cSQL)
        ENDIF

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0)

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + TRANSFORM(par_cRotulo) + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConsultarTabela - substitui ThisForm.poDataMgr.CursorQuery(tabela,
    * cursorDestino, campoChave, valorChave). Cursor fica ABERTO; com zero
    * linhas, leitura de campo devolve branco (igual ao legado).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConsultarTabela(par_cTabela, par_cCursor, par_cCampoChave, par_uValorChave)
        LOCAL loc_cValor, loc_nRet, loc_lOk, loc_cAliasAnt

        loc_cAliasAnt = ALIAS()

        DO CASE
            CASE VARTYPE(par_uValorChave) = "N"
                loc_cValor = FormatarNumeroSQL(par_uValorChave, 0)
            CASE VARTYPE(par_uValorChave) = "D" OR VARTYPE(par_uValorChave) = "T"
                loc_cValor = FormatarDataSQL(par_uValorChave)
            OTHERWISE
                loc_cValor = EscaparSQL(ALLTRIM(TratarNulo(par_uValorChave, "")))
        ENDCASE

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE " + par_cCampoChave + " = " + loc_cValor, par_cCursor)

        IF !EMPTY(loc_cAliasAnt) AND USED(loc_cAliasAnt)
            SELECT (loc_cAliasAnt)
        ENDIF

        loc_lOk = (loc_nRet >= 0 AND USED(par_cCursor))

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(" + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * AbrirCursorTabela - cria (ou recria VAZIO) um cursor READWRITE com a
    * estrutura COMPLETA da tabela informada (equivale ao AddCursor() do
    * gerenciador Fortyus) - garante que PersistirCursor() cubra toda coluna
    * NOT NULL da tabela destino (regra #22 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AbrirCursorTabela(par_cCursor, par_cTabela)
        LOCAL loc_nRet, loc_lOk
        loc_lOk = .F.

        IF USED(par_cCursor)
            USE IN (par_cCursor)
        ENDIF
        IF USED("cursor_4c_Estrut")
            USE IN cursor_4c_Estrut
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "SELECT * FROM " + par_cTabela + " WHERE 1 = 0", "cursor_4c_Estrut")

        IF loc_nRet >= 0 AND USED("cursor_4c_Estrut")
            SELECT * FROM cursor_4c_Estrut WHERE .F. INTO CURSOR (par_cCursor) READWRITE
            USE IN cursor_4c_Estrut
            loc_lOk = USED(par_cCursor)
        ENDIF

        IF !loc_lOk
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "(estrutura de " + par_cTabela + ") " + CapturarErroSQL()
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValorSQLDeCampo - formata UM campo do cursor para o VALUES do INSERT,
    * pelo TIPO VFP do campo (nunca por palpite de nome) - helpers canonicos
    * do projeto, que ja devolvem COM aspas.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValorSQLDeCampo(par_cCursor, par_cCampo, par_cTipo, par_nDec)
        LOCAL loc_uValor, loc_cRet

        loc_uValor = EVALUATE(par_cCursor + "." + par_cCampo)

        DO CASE
            CASE par_cTipo $ "CMVQ"
                loc_cRet = EscaparSQL(TratarNulo(loc_uValor, ""))
            CASE par_cTipo $ "NFIBY"
                loc_cRet = FormatarNumeroSQL(TratarNulo(loc_uValor, 0), par_nDec)
            CASE par_cTipo = "L"
                loc_cRet = IIF(TratarNulo(loc_uValor, .F.), "1", "0")
            CASE par_cTipo $ "DT"
                loc_cRet = FormatarDataSQL(TratarNulo(loc_uValor, {}))
            OTHERWISE
                loc_cRet = "NULL"
        ENDCASE

        RETURN loc_cRet
    ENDFUNC

    *--------------------------------------------------------------------------
    * PersistirCursor - substitui ThisForm.poDataMgr.Update('<cursor>'):
    * grava em par_cTabela, linha a linha, TODAS as colunas do cursor (que
    * AbrirCursorTabela criou com a estrutura completa da tabela).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PersistirCursor(par_cCursor, par_cTabela)
        LOCAL loc_lOk, loc_nI, loc_nCampos, loc_cCols, loc_cVals, loc_cSQL, loc_nRet
        LOCAL ARRAY loc_aCampos[1, 18]

        loc_lOk = .T.

        IF !USED(par_cCursor) OR RECCOUNT(par_cCursor) = 0
            RETURN .T.
        ENDIF

        loc_nCampos = AFIELDS(loc_aCampos, par_cCursor)
        loc_cCols   = ""
        FOR loc_nI = 1 TO loc_nCampos
            loc_cCols = loc_cCols + IIF(loc_nI = 1, "", ", ") + LOWER(ALLTRIM(loc_aCampos[loc_nI, 1]))
        ENDFOR

        SELECT (par_cCursor)
        GO TOP
        SCAN
            loc_cVals = ""
            FOR loc_nI = 1 TO loc_nCampos
                loc_cVals = loc_cVals + IIF(loc_nI = 1, "", ", ") + ;
                    THIS.ValorSQLDeCampo(par_cCursor, ALLTRIM(loc_aCampos[loc_nI, 1]), ;
                        loc_aCampos[loc_nI, 2], loc_aCampos[loc_nI, 4])
            ENDFOR

            loc_cSQL = "INSERT INTO " + par_cTabela + " (" + loc_cCols + ") VALUES (" + loc_cVals + ")"
            loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRet < 0
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Update - " + par_cCursor + ") " + CapturarErroSQL()
                loc_lOk = .F.
                EXIT
            ENDIF
        ENDSCAN

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ReservarSequencia - forma de BLOCO do fGerUniqueKey legado (que o
    * GravaHis legado chama com 4 argumentos, reservando N numeros de uma vez
    * e devolvendo o ULTIMO do bloco). O fGerUniqueKey portado emite UM
    * numero por chamada - o bloco eh reservado aqui, com o MESMO contador
    * (SIGSYSEQ) e a mesma instrucao atomica que ele usa.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ReservarSequencia(par_cChave, par_nQtd)
        LOCAL loc_cChave, loc_nQtd, loc_nRet, loc_nUltimo, loc_nI, loc_lManual

        loc_cChave  = ALLTRIM(TratarNulo(par_cChave, ""))
        loc_nQtd    = MAX(1, INT(TratarNulo(par_nQtd, 1)))
        loc_nUltimo = 0

        IF EMPTY(loc_cChave)
            RETURN 0
        ENDIF

        IF loc_nQtd = 1
            RETURN fGerUniqueKey(loc_cChave)
        ENDIF

        loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        loc_nRet = SQLEXEC(gnConnHandle, ;
            "UPDATE SIGSYSEQ SET conteudo = conteudo + " + FormatarNumeroSQL(loc_nQtd, 0) + ;
            " OUTPUT inserted.conteudo AS novo" + ;
            " WHERE valor = " + EscaparSQL(loc_cChave), ;
            "cursor_4c_SeqBloco")

        IF loc_nRet > 0 AND USED("cursor_4c_SeqBloco") AND RECCOUNT("cursor_4c_SeqBloco") > 0
            GO TOP IN cursor_4c_SeqBloco
            loc_nUltimo = INT(TratarNulo(cursor_4c_SeqBloco.novo, 0))
        ENDIF

        IF USED("cursor_4c_SeqBloco")
            USE IN cursor_4c_SeqBloco
        ENDIF

        IF loc_lManual
            IF loc_nUltimo > 0
                = SQLCOMMIT(gnConnHandle)
            ELSE
                = SQLROLLBACK(gnConnHandle)
            ENDIF
        ENDIF

        IF loc_nUltimo = 0
            FOR loc_nI = 1 TO loc_nQtd
                loc_nUltimo = fGerUniqueKey(loc_cChave)
                IF loc_nUltimo = 0
                    EXIT
                ENDIF
            ENDFOR
        ENDIF

        RETURN loc_nUltimo
    ENDFUNC

    *==========================================================================
    * NOTA DE ESCOPO - fRecalculaP / fRecalculaC (recalculo de custo/preco
    * medio de estoque, SigOpClP/SigOpClC)
    *
    * O Click legado (Processar) chama fRecalculaP/fRecalculaC apos cada
    * Insert Into crSigMvHst (retorno descartado, "=fRecalculaP(...)") e em
    * dois pares de fecho em lote, onde o retorno gateia llErro (dump linhas
    * 5875-5876, 5888-5889, 5960-5961, 5973-5974, 6048-6055, 6435-6442).
    *
    * As DUAS funcoes NAO existem no acervo migrado - mesma auditoria e
    * mesma decisao JA tomadas em SigPrGlpBO.prg (ver NOTA DE ESCOPO la: regra
    * #27 do CLAUDE.md, 3a linha da tabela - funcao que produz VALOR DE
    * CALCULO fica AUSENTE e visivel, nunca vira stub). As chamadas foram
    * OMITIDAS, nao stubadas; os pares de fecho NAO marcam llErro (abortar
    * desfaria toda a geracao de O.P. por causa de uma funcao inexistente).
    *
    * CONSEQUENCIA FUNCIONAL A REPORTAR: apos Processar(), o custo/preco medio
    * de estoque NAO eh recalculado. Os movimentos (SigMvHst/SigBxEst/
    * SigMvItn/SigMvIts/SigMvCab/SigOpPic/SigPdMvf/SigCdNec/SigCdNei/
    * SigOpPii/SigInAtz) sao gravados corretamente.
    *
    * Cada ponto esta marcado abaixo com
    * "*-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)".
    *==========================================================================

    *--------------------------------------------------------------------------
    * CarregarDbParam - resolve as tres colunas do cursor "DBParam" do
    * legado (montado no Click do grandparent FormSigPrGlo): CodTgOps =
    * _lcTpGOp; OpZers = Iif(GerPorTp, SigInTgo.OpZers, SigCdPac.OpZers);
    * EntPes = Iif(GerPorTp, SigInTgo.EntPes, 0). Mesmo padrao ja adotado em
    * SigPrGlpBO.CarregarDbParam.
    *--------------------------------------------------------------------------
    FUNCTION CarregarDbParam()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cDbCodTgOps = PADR(ALLTRIM(THIS.this_cTipoGeracaoOP), 10)

            IF THIS.this_lGerPorTp
                THIS.this_nDbOpZers = 0
                THIS.this_nDbEntPes = 0

                IF USED("cursor_4c_TpGOp")
                    USE IN cursor_4c_TpGOp
                ENDIF
                IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                    IF SQLEXEC(gnConnHandle, ;
                            "SELECT opzers, entpes FROM SigInTgo WHERE codigos = " + ;
                            EscaparSQL(ALLTRIM(THIS.this_cTipoGeracaoOP)), ;
                            "cursor_4c_TpGOp") >= 0 AND USED("cursor_4c_TpGOp")

                        IF !EOF("cursor_4c_TpGOp")
                            THIS.this_nDbOpZers = TratarNulo(cursor_4c_TpGOp.opzers, 0)
                            THIS.this_nDbEntPes = TratarNulo(cursor_4c_TpGOp.entpes, 0)
                        ENDIF
                        USE IN cursor_4c_TpGOp
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "(SigInTgo) " + CapturarErroSQL()
                    ENDIF
                ENDIF
            ELSE
                THIS.this_nDbOpZers = THIS.this_nPacOpZers
                THIS.this_nDbEntPes = 0
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "SigPrGlxBO.CarregarDbParam")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * AtualizaPeso - transcricao de SIGPRGLX.atualizapeso (dump 4109-4144).
    * Opera sobre o cursor CORRENTE (cCompo = Alias() no legado) e devolve o
    * peso/quantidade total dos componentes que entram no custo.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION AtualizaPeso()
        LOCAL loc_cCompo, loc_nTotQtd, loc_cQuery, loc_nFator, loc_cUni, loc_lFalhou

        loc_cCompo  = ALIAS()
        loc_nTotQtd = 0
        loc_lFalhou = .F.

        IF EMPTY(loc_cCompo) OR !USED(loc_cCompo)
            RETURN 0
        ENDIF

        IF THIS.this_nPamAutComps != 1
            SELECT (loc_cCompo)
            SCAN
                IF !USED("crSigCdCom")
                    LOOP
                ENDIF

                SELECT crSigCdCom
                GO TOP IN crSigCdCom
                LOCATE FOR crSigCdCom.CGrus = EVALUATE(loc_cCompo + ".CGrus") ;
                       AND crSigCdCom.Custos = 1

                IF !EOF("crSigCdCom")
                    loc_cQuery = "SELECT a.cUnis, a.cUnips, b.BPesos" + ;
                        " FROM SigCdPro a, SigCdGrp b" + ;
                        " WHERE a.CPros = " + EscaparSQL(ALLTRIM(EVALUATE(loc_cCompo + ".Mats"))) + ;
                        " AND a.CGrus = b.CGrus"

                    IF !THIS.ExecutarSQL(loc_cQuery, "crSomaGru", "crSomaGru - 1")
                        loc_lFalhou = .T.
                        EXIT
                    ENDIF

                    GO TOP IN crSomaGru

                    IF !EOF("crSomaGru") AND INLIST(TratarNulo(crSomaGru.BPesos, 0), 1, 3)
                        loc_cUni = IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                            TratarNulo(crSomaGru.cUnis, ""), TratarNulo(crSomaGru.cUnips, ""))

                        IF !THIS.ExecutarSQL( ;
                                "SELECT Fators FROM SigCdUni WHERE Cunis = " + ;
                                EscaparSQL(ALLTRIM(loc_cUni)), "LocalUni", "LocalUni")
                            loc_lFalhou = .T.
                            EXIT
                        ENDIF

                        loc_nFator = 1
                        IF USED("LocalUni") AND !EOF("LocalUni")
                            loc_nFator = IIF(TratarNulo(LocalUni.Fators, 0) = 0, 1, ;
                                TratarNulo(LocalUni.Fators, 0))
                        ENDIF

                        SELECT (loc_cCompo)
                        loc_nTotQtd = loc_nTotQtd + ( ;
                            IIF(TratarNulo(crSomaGru.BPesos, 0) = 1, ;
                                EVALUATE(loc_cCompo + ".Qtds"), ;
                                EVALUATE(loc_cCompo + ".Pesos")) * loc_nFator)
                    ENDIF
                ENDIF

                SELECT (loc_cCompo)
            ENDSCAN

            SELECT (loc_cCompo)
        ENDIF

        IF loc_lFalhou
            loc_nTotQtd = 0
        ENDIF

        RETURN loc_nTotQtd
    ENDFUNC

    *--------------------------------------------------------------------------
    * GravaHis - transcricao de SIGPRGLX.gravahis (dump 4149-4215). Atribui
    * as chaves primarias do historico de estoque (crSigMvHst): CidChaves =
    * Dtos(Datas) + <letra da operacao> + Transform(seq,"@L 999999") +
    * SigKey, e Seqs = sequencial 'HISTBAR'. As duas sequencias sao BLOCOS
    * reservados de uma vez (ReservarSequencia), equivalente ao
    * fGerUniqueKey de 4 argumentos do legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravaHis()
        LOCAL loc_lOk, loc_cSql, loc_nRegistro, loc_nReservado, loc_nInicio
        LOCAL loc_nRerSeq, loc_nIniSeq, loc_cNewOpe

        loc_lOk = .T.

        IF !USED("crSigMvHst")
            RETURN .T.
        ENDIF

        IF USED("LocalOpe")
            USE IN LocalOpe
        ENDIF
        IF THIS.ExecutarSQL( ;
                "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                " FROM SigCdOpe WHERE 1 = 0", "cursor_4c_OpeEstr", "LocalOpe")
            SELECT * FROM cursor_4c_OpeEstr WHERE .F. INTO CURSOR LocalOpe READWRITE
            USE IN cursor_4c_OpeEstr
        ELSE
            loc_lOk = .F.
        ENDIF

        IF loc_lOk
            SELECT DISTINCT Dopes FROM crSigMvHst INTO CURSOR SelOperacao

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopes, Estoqs, Origems, Destinos, EstOrigs, EstDests" + ;
                    " FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            SELECT LocalOpe
            INDEX ON Dopes TAG Dopes

            SELECT SelOperacao
            SCAN
                loc_cSql = "SELECT Dopps AS Dopes, 1 AS Estoqs, Origems, Destinos," + ;
                    " EstOrigs, EstDests FROM SigCdOpd WHERE Dopps = " + ;
                    EscaparSQL(ALLTRIM(SelOperacao.Dopes))
                IF !THIS.ExecutarSQL(loc_cSql, "xTmpOpe", "xTmpOpe - Opd")
                    loc_lOk = .F.
                    EXIT
                ENDIF
                IF USED("xTmpOpe") AND RECCOUNT("xTmpOpe") > 0
                    SELECT LocalOpe
                    APPEND FROM DBF("xTmpOpe")
                ENDIF
                SELECT SelOperacao
            ENDSCAN
        ENDIF

        IF loc_lOk
            WAIT WINDOW "Criando Chaves Prim" + CHR(225) + "rias no Arquivo de Hist" + CHR(243) + "rico " NOWAIT

            SELECT crSigMvHst
            GO TOP
            loc_nRegistro = RECCOUNT("crSigMvHst")

            IF loc_nRegistro > 0
                loc_nReservado = THIS.ReservarSequencia(DTOS(crSigMvHst.Datas), loc_nRegistro + 1)
                loc_nRerSeq    = 0
                IF loc_nReservado > 0
                    loc_nRerSeq = THIS.ReservarSequencia("HISTBAR", loc_nRegistro + 1)
                ENDIF

                IF loc_nReservado = 0 OR loc_nRerSeq = 0
                    WAIT CLEAR
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "N" + CHR(227) + "o foi poss" + CHR(237) + "vel reservar a numera" + ;
                        CHR(231) + CHR(227) + "o do hist" + CHR(243) + "rico de estoque."
                    RETURN .F.
                ENDIF

                loc_nInicio = loc_nReservado - loc_nRegistro
                loc_nIniSeq = loc_nRerSeq - loc_nRegistro

                SELECT crSigMvHst
                SCAN
                    loc_nInicio = loc_nInicio + 1
                    loc_nIniSeq = loc_nIniSeq + 1

                    loc_cNewOpe = TratarNulo(crSigMvHst.Opers, " ")

                    REPLACE CidChaves WITH DTOS(crSigMvHst.Datas) + loc_cNewOpe + ;
                            TRANSFORM(loc_nInicio, "@L 999999") + THIS.this_cSigKey, ;
                            Seqs      WITH loc_nIniSeq ;
                        IN crSigMvHst

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDSCAN
            ENDIF

            WAIT CLEAR
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursoresDestino - equivale ao "Select crXxx / Zap" do topo do
    * Click legado (dump 4574-4597): os cursores de gravacao nascem aqui,
    * VAZIOS e com a estrutura COMPLETA da tabela destino (AbrirCursorTabela),
    * em vez de ZAP num cursor pre-existente (ZAP em DataSession privada ja
    * travou a tela neste projeto). SigPrGlx usa as MESMAS 9 tabelas de
    * SigPrGlpBO + CrSigOpPii/CrSigInAtz (entrada automatica/producao com
    * selecao manual liberada).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION PrepararCursoresDestino()
        LOCAL loc_lOk

        loc_lOk = THIS.AbrirCursorTabela("crSigOpPic", "SigOpPic")
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvCab", "SigMvCab")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigBxEst", "SigBxEst")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvItn", "SigMvItn")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigMvIts", "SigMvIts")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigOpPii", "SigOpPii")
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crSigInAtz", "SigInAtz")
        ENDIF

        *-- Select * From CrSigCdNei Where 0=1 Into Cursor GrSigCdNei ReadWrite
        IF loc_lOk
            IF USED("GrSigCdNei")
                USE IN GrSigCdNei
            ENDIF
            SELECT * FROM crSigCdNei WHERE .F. INTO CURSOR GrSigCdNei READWRITE
            loc_lOk = USED("GrSigCdNei")
        ENDIF

        *-- crTplMvIts / crTpmMvItn: cursores de TRABALHO (consolidados em
        *-- crSigMvIts/crSigMvItn por ConsolidarMovimentoItens)
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTplMvIts", "SigMvIts")
            IF loc_lOk
                SELECT crTplMvIts
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF
        IF loc_lOk
            loc_lOk = THIS.AbrirCursorTabela("crTpmMvItn", "SigMvItn")
            IF loc_lOk
                SELECT crTpmMvItn
                INDEX ON Cpros TAG Cpros
            ENDIF
        ENDIF

        RETURN loc_lOk
    ENDFUNC

    *--------------------------------------------------------------------------
    * FecharCursoresProcessamento - libera os cursores de trabalho criados
    * por Processar(), tornando-o reexecutavel na mesma sessao do form.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FecharCursoresProcessamento()
        LOCAL ARRAY loc_aCursores[38]
        LOCAL loc_nI

        loc_aCursores[1]  = "crSigOpPic"
        loc_aCursores[2]  = "crSigPdMvf"
        loc_aCursores[3]  = "crSigCdNec"
        loc_aCursores[4]  = "crSigCdNei"
        loc_aCursores[5]  = "crSigMvCab"
        loc_aCursores[6]  = "crSigMvHst"
        loc_aCursores[7]  = "crSigBxEst"
        loc_aCursores[8]  = "crSigMvItn"
        loc_aCursores[9]  = "crSigMvIts"
        loc_aCursores[10] = "crSigOpPii"
        loc_aCursores[11] = "crSigInAtz"
        loc_aCursores[12] = "GrSigCdNei"
        loc_aCursores[13] = "crTplMvIts"
        loc_aCursores[14] = "crTpmMvItn"
        loc_aCursores[15] = "TmpEmpH"
        loc_aCursores[16] = "TmpPedra"
        loc_aCursores[17] = "TmpMatPrz"
        loc_aCursores[18] = "TmpEstoque"
        loc_aCursores[19] = "TmpOpePed"
        loc_aCursores[20] = "TmpOpi"
        loc_aCursores[21] = "TmpUltItn"
        loc_aCursores[22] = "TempEest"
        loc_aCursores[23] = "TempEestI"
        loc_aCursores[24] = "TempEsti2"
        loc_aCursores[25] = "LocalCompo"
        loc_aCursores[26] = "crSomaGru"
        loc_aCursores[27] = "LocalUni"
        loc_aCursores[28] = "LocalOpe"
        loc_aCursores[29] = "SelOperacao"
        loc_aCursores[30] = "xTmpOpe"
        loc_aCursores[31] = "crSigPrMtz"
        loc_aCursores[32] = "pEstoque"
        loc_aCursores[33] = "TmpNensi"
        loc_aCursores[34] = "xNensi"
        loc_aCursores[35] = "TmpLinF"
        loc_aCursores[36] = "TmpHis"
        loc_aCursores[37] = "crSigCdOpd"
        loc_aCursores[38] = "crSigCdOpe"

        FOR loc_nI = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_nI])
                USE IN (loc_aCursores[loc_nI])
            ENDIF
        ENDFOR
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - transcricao do Click do botao Processar (SIGPRGLX.
    * PageDados.Page1.Processar.Click, dump linhas 4562-6466). Efetiva a
    * geracao/transferencia de Ordens de Producao a partir dos cursores
    * TmpFinal/TmpFinalg (preparados pelo form pai - FormSigPrGl2BO.
    * ExecutarProcessamento) e, quando configurado, das grades de ajuste
    * manual (cursor_4c_TmpSaldo/TmpSaldg/TmpFabr e cursor_4c_Requisicao).
    *
    * CONTRATO (fixado em FormSigPrGlx.BtnProcessarClick): sem parametros. O
    * form preenche antes this_dPrevisao (_Prev) e this_dDataGeracao
    * (_DtGera) a partir do grandparent (FormSigPrGlo), e this_lPorDestino
    * ja vem do Init. Devolve .T. em sucesso, com this_nNumeroOpGerada =
    * _Nump; em falha devolve .F. com this_cMensagemErro preenchido.
    *
    * NAO transcrito (confirmado morto no dump): "Keyboard '{ESC}'" x3 do
    * fecho (fecha o form - fica no form, nao no BO) e os literais de
    * MessageBox substituidos por this_cMensagemErro.
    *
    * FICA NO FORM: ThisForm.Aguarde/Enabled dos botoes e o
    * "Do Form SigReGli"/Cancelar.Click() do fecho (SigReGli nao foi
    * migrado - FormSigPrGlx.BtnProcessarClick mostra o numero da O.P. via
    * MsgInfo e fecha o form, mesmo padrao ja adotado em FormSigPrGlp).
    *--------------------------------------------------------------------------
    FUNCTION Processar()
        LOCAL loc_lSucesso, loc_oErro, loc_cExactOrig

        *-- Estado compartilhado com os metodos de bloco (PRIVATE - visivel
        *-- para THIS.ProcessarXxx() chamados daqui, igual as Private/Local
        *-- do Click legado e ao mesmo padrao de SigPrGlpBO.Processar)
        PRIVATE loc_lAbortar, loc_tDay, loc_cEmpr, loc_cUsuar
        PRIVATE loc_cDopp, loc_cDope, loc_cDopEst, loc_nNump, loc_nRnop, loc_nNumpe, loc_nSeqs
        PRIVATE loc_cCpros, loc_cReff, loc_cCor, loc_cTam, loc_dPrev, loc_dDtGera
        PRIVATE loc_nTProd, loc_nTPeso, loc_cClinha, loc_cNota
        PRIVATE loc_cGrupoD, loc_cContaD, loc_nNume, loc_nCitens, loc_cDopePed, loc_lPedUtilz

        loc_lSucesso = .F.
        loc_lAbortar = .F.
        THIS.this_cMensagemErro   = ""
        THIS.this_nNumeroOpGerada = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Sem conex" + CHR(227) + "o com o banco de dados." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF
        IF !USED("TmpFinal") OR !USED("TmpFinalg")
            THIS.this_cMensagemErro = "Os dados da pr" + CHR(233) + "via n" + CHR(227) + ;
                "o est" + CHR(227) + "o dispon" + CHR(237) + "veis." + CHR(13) + ;
                "Favor Reinicializar o Processo!!!"
            RETURN .F.
        ENDIF

        *-- SET EXACT: o Click legado depende do default do VFP (EXACT OFF)
        *-- para os SEEK PARCIAIS sobre indices compostos (Seek(cPros) sobre
        *-- Cpros+CodCors+CodTams, etc). config.prg deste projeto liga SET
        *-- EXACT ON - com EXACT ON o SEEK parcial nunca casaria. Restaurado
        *-- no fim, inclusive no caminho do CATCH.
        loc_cExactOrig = SET("EXACT")
        SET EXACT OFF

        TRY
            loc_tDay   = DATETIME()
            loc_cEmpr  = PADR(go_4c_Sistema.cCodEmpresa, 3)
            loc_cUsuar = PADR(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10), 10)
            loc_lPedUtilz = .F.

            IF !THIS.PrepararCursoresDestino()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar AND !THIS.CarregarDbParam()
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                loc_cDopp   = PADR(THIS.this_cDoppPads, 20)
                loc_cDope   = PADR(THIS.this_cTransfRes, 20)
                loc_cDopEst = PADR(THIS.this_cPacDopEsts, 20)

                IF !THIS.ConsultarTabela("SigCdOpd", "crSigCdOpd", "Dopps", ALLTRIM(loc_cDopp))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Numero da O.P. (_Nump) ou da reserva (_Rnop) + conferencia de duplicidade
            IF !loc_lAbortar
                loc_nNump = 0
                loc_nRnop = 0
                IF !THIS.this_lReserva
                    IF THIS.this_nPamGlobAutos = 2 AND THIS.this_nNumeroDaOp > 0
                        loc_nNump = THIS.this_nNumeroDaOp
                    ELSE
                        loc_nNump = fGerUniqueKey(ALLTRIM(loc_cDopp))
                    ENDIF

                    IF !THIS.ExecutarSQL("SELECT Numps FROM SigOpPic WHERE Numps = " + ;
                            FormatarNumeroSQL(loc_nNump, 0), "TmpOpi", "TmpOpi")
                        loc_lAbortar = .T.
                    ELSE
                        IF RECCOUNT("TmpOpi") > 0
                            THIS.this_cMensagemErro = "N" + CHR(250) + "mero de Op j" + CHR(225) + ;
                                " existe. Favor Corrigir!!!"
                            loc_lAbortar = .T.
                        ENDIF
                    ENDIF
                ELSE
                    loc_nRnop = fGerUniqueKey("RESERVAPCP")
                ENDIF
            ENDIF

            IF !loc_lAbortar
                loc_nSeqs   = 0
                loc_cCpros  = ""
                loc_cReff   = SPACE(15)
                loc_cCor    = SPACE(4)
                loc_cTam    = SPACE(2)
                loc_dPrev   = ConverterParaData(THIS.this_dPrevisao)
                loc_dDtGera = ConverterParaData(THIS.this_dDataGeracao)
                loc_nTProd  = 0
                loc_nTPeso  = 0
                loc_cClinha = SPACE(10)
                loc_cNota   = SPACE(6)
                loc_cGrupoD = SPACE(10)
                loc_cContaD = SPACE(10)
                loc_nNumpe  = (loc_nNump * 10000) + 1
                loc_nNume   = 0
                loc_nCitens = 0

                IF USED("TmpEmpH")
                    USE IN TmpEmpH
                ENDIF
                CREATE CURSOR TmpEmpH (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3), ;
                    cpro2s C(14))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats + cpro2s TAG CMats

                IF USED("TmpPedra")
                    USE IN TmpPedra
                ENDIF
                CREATE CURSOR TmpPedra (Grupos C(10), Contas C(10), cGrus C(3), cMats C(14), ;
                    Qtds N(12,3), QtdReqs N(12,3), QtdEsts N(12,3), QtdMins N(12,3), ;
                    QtdPedcs N(12,3), QtdComps N(12,3), QtdEmphs N(12,3), QtdGReqs N(12,3))
                INDEX ON Cgrus + Cmats TAG GruMat
                INDEX ON CMats TAG CMats

                IF USED("TmpMatPrz")
                    USE IN TmpMatPrz
                ENDIF
                CREATE CURSOR TmpMatPrz (cMats C(14), Qtds N(12,3), Pesos N(12,3), ;
                    PrazoEnts D, QtBaixas N(12,3))
                INDEX ON DTOC(PrazoEnts) + Cmats TAG MatPrazo DESC

                loc_cDopePed = PADR(THIS.this_cPacOpPdCompra, 20)
                IF !THIS.ConsultarTabela("SigCdOpe", "TmpOpePed", "Dopes", ALLTRIM(loc_cDopePed))
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            *-- Cabecalho da operacao de baixa de estoque de fabricacao
            *-- (_DopEst) - equivalente ao Insert Into CrSigMvCab do topo do
            *-- Click legado (dump 4671-4681)
            IF !loc_lAbortar
                loc_nNume = fGerUniqueKey(ALLTRIM(loc_cDopEst) + loc_cEmpr)

                IF !THIS.ExecutarSQL("SELECT * FROM SigCdOpe WHERE Dopes = " + ;
                        EscaparSQL(ALLTRIM(loc_cDopEst)), "crSigCdOpe", "crSigCdOpe")
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                        Grupoos, Contaos, Grupods, Contads, Obses, CidChaves, Dtalts, ;
                        EmpDopNums, rNops, PrazoEnts) ;
                    VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                        loc_dDtGera, DATE(), loc_cUsuar, ;
                        crSigCdOpe.GruOrigs, crSigCdOpe.ConOrigs, crSigCdOpe.GruDests, crSigCdOpe.ConDests, ;
                        " [ Reserva Autom" + CHR(225) + "tica ] ", fUniqueIds(), DATE(), ;
                        loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), loc_nRnop, {})

                THIS.ProcessarProducao()
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarBaixaEstoque()
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarBaixaProducao()
            ENDIF

            IF !loc_lAbortar
                IF !loc_lPedUtilz
                    *-- "If Not llPedUtilz / Delete crSigMvCab do Dopest" -
                    *-- nada foi usado dessa operacao de baixa - desfaz o
                    *-- cabecalho que a abre (dump 5500-5508)
                    = fCanUniqueKey(loc_nNume, ALLTRIM(loc_cDopEst) + loc_cEmpr)
                    SELECT crSigMvCab
                    LOCATE FOR Dopes = loc_cDopEst
                    IF FOUND()
                        DELETE
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT crSigOpPic
                APPEND FROM DBF("TmpOpi")
                REPLACE ALL CodTgOps WITH THIS.this_cDbCodTgOps IN crSigOpPic
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarRequisicaoPedras()
            ENDIF

            IF !loc_lAbortar
                SELECT crTpmMvItn
                SCAN
                    INSERT INTO crSigMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, ;
                            Opers, Citens, EmpDopNums, CidChaves, DtAlts, cpro2s) ;
                        VALUES (crTpmMvItn.Emps, crTpmMvItn.Dopes, crTpmMvItn.Numes, crTpmMvItn.CPros, ;
                            crTpmMvItn.Qtds, crTpmMvItn.Cunis, crTpmMvItn.Dpros, crTpmMvItn.Opers, ;
                            crTpmMvItn.citens, crTpmMvItn.Emps + crTpmMvItn.Dopes + STR(crTpmMvItn.Numes, 6), ;
                            fUniqueIds(), DATETIME(), crTpmMvItn.Cpro2s)
                    SELECT crTpmMvItn
                ENDSCAN

                SELECT crTplMvIts
                SCAN
                    INSERT INTO CrSigMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, ;
                            CodTams, QtdEmbs) ;
                        VALUES (crTplMvIts.Citens, crTplMvIts.Emps, crTplMvIts.Dopes, crTplMvIts.Numes, ;
                            crTplMvIts.CPros, crTplMvIts.Qtds, crTplMvIts.CodCors, crTplMvIts.CodTams, 1)
                    SELECT crTplMvIts
                ENDSCAN
            ENDIF

            IF !loc_lAbortar
                THIS.ProcessarEntradaAutomatica()
            ENDIF

            IF !loc_lAbortar
                IF !THIS.GravaHis()
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT crSigMvHst
                GO TOP
                IF !EOF("crSigMvHst")
                    SCAN
                        REPLACE cIdChaves WITH DTOS(crSigMvHst.Datas) + crSigMvHst.Opers + ;
                                PADL(fGerUniqueKey(DTOS(crSigMvHst.Datas)), 6, "0") IN crSigMvHst
                    ENDSCAN
                ENDIF
            ENDIF

            IF !loc_lAbortar
                IF THIS.GravarMovimentos()
                    loc_lSucesso = .T.
                ELSE
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF loc_lSucesso AND THIS.this_lAutomatico
                IF !THIS.ProcessarModoAutomatico()
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            IF loc_lSucesso
                THIS.this_nNumeroOpGerada = loc_nNump
            ENDIF

        CATCH TO loc_oErro
            = SQLROLLBACK(gnConnHandle)
            THIS.this_cMensagemErro = loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + ;
                " / " + TRANSFORM(loc_oErro.Procedure) + "]"
            loc_lSucesso = .F.
        ENDTRY

        THIS.FecharCursoresProcessamento()

        IF loc_cExactOrig = "ON"
            SET EXACT ON
        ELSE
            SET EXACT OFF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarProducao - "If Not ThisForm.Reserva ... EndIf" (dump
    * 4683-5017): marca o cabecalho (Nops/Rnops), monta TmpFinal a partir de
    * TmpFinalg (Produzir2) e, por item com Produzir<>0, gera a O.P. de
    * producao (industrializacao, quebrada pela capacidade QtPcs da linha)
    * OU o pedido de compra do acabado (fornecedor externo).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarProducao()
        LOCAL loc_lOk, loc_nQtdLim, loc_nQtBaixar, loc_nLnVezes, loc_nQtBaixado
        LOCAL loc_nNopComp, loc_cCidC, loc_cQuery, loc_nQtdTb, loc_nQtdCpnt
        LOCAL loc_uUnits, loc_cMoedas, loc_cEpn, loc_nPesoCmp
        LOCAL loc_cForn, loc_nTotPed, loc_nCitensPed
        LOCAL loc_nBaixa, loc_cPEdn, loc_nPItn, loc_cPIds, loc_nPendente, loc_nPQtd, loc_cPId2, loc_nPQt2

        loc_lOk = .T.

        IF !THIS.this_lReserva

            REPLACE Nops WITH loc_nNump, Rnops WITH loc_nNump IN crSigMvCab

            SELECT TmpFinal
            DELETE FOR KeyPdes = .T.

            SELECT TmpFinalg
            SCAN
                IF TmpFinalg.Produzir2 = 0
                    LOOP
                ENDIF

                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinalg.CPros))

                loc_cGrupoD = IIF(THIS.this_lPorDestino AND !EMPTY(crSigMvCab.GrupoDs), ;
                    crSigMvCab.GrupoDs, crSigCdOpd.GruDests)
                loc_cContaD = IIF(THIS.this_lPorDestino AND !EMPTY(crSigMvCab.ContaDs), ;
                    crSigMvCab.ContaDs, crSigCdOpd.ConDests)

                INSERT INTO TmpFinal (Emps, Dopes, Numes, CPros, Qtds, Peso, Saldo, Estoque, ;
                        Produzir, Obsps, Obs, Datas, Entregas, CodCors, CodTams, Linhas, Citens, ;
                        Reffs, Notas, Dpros, GrupoDs, ContaDs, KeyPdes) ;
                    VALUES (crSigMvCab.Emps, crSigMvCab.Dopes, crSigMvCab.Numes, TmpFinalg.CPros, ;
                        TmpFinalg.Qtds, crSigCdPro.PesoMs, 0, 0, TmpFinalg.Produzir2, "", "", ;
                        crSigMvCab.Datas, crSigMvCab.PrazoEnts, TmpFinalg.CodCors, TmpFinalg.CodTams, ;
                        crSigCdPro.Linhas, 0, crSigCdPro.Reffs, "", crSigCdPro.Dpros, ;
                        loc_cGrupoD, loc_cContaD, .T.)

                SELECT TmpFinalg
            ENDSCAN

            SELECT TmpFinal
            INDEX ON Linhas + Reffs + Cpros + Notas + CodCors + CodTams + GrupoDs + ContaDs ;
                TAG Cpros FOR Produzir > 0
            SET ORDER TO Cpros
            GO TOP

            DO WHILE !EOF("TmpFinal")
                IF TmpFinal.Produzir != 0

                    = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinal.CPros))
                    = THIS.ConsultarTabela("SigCdLin", "CrSigCdLin", "Linhas", ALLTRIM(TmpFinal.Linhas))
                    = THIS.ConsultarTabela("SigCdGrp", "CrSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.Cgrus))
                    = THIS.ConsultarTabela("SigCdGpr", "CrSigCdGpr", "Codigos", ALLTRIM(CrSigCdGrp.Mercs))

                    IF EMPTY(THIS.this_cPacOpPdCompra) OR crSigCdPro.FabrProPrs = 1
                        *-- INDUSTRIALIZACAO: quebra Produzir pela capacidade
                        *-- (QtPcs) da linha de producao
                        loc_nQtdLim   = IIF(CrSigCdLin.QtPcs = 0, TmpFinal.Produzir, CrSigCdLin.QtPcs)
                        loc_nQtBaixar = TmpFinal.Produzir
                        loc_nLnVezes  = 0

                        DO WHILE loc_nQtBaixar > 0
                            loc_nLnVezes = loc_nLnVezes + 1

                            IF loc_nQtBaixar < loc_nQtdLim
                                loc_nQtBaixado = loc_nQtBaixar
                                loc_nQtBaixar  = 0
                            ELSE
                                loc_nQtBaixar  = loc_nQtBaixar - loc_nQtdLim
                                loc_nQtBaixado = loc_nQtdLim
                            ENDIF

                            IF (loc_cClinha + loc_cReff + loc_cCpros + loc_cNota + loc_cCor + ;
                                    loc_cGrupoD + loc_cContaD != TmpFinal.Linhas + TmpFinal.Reffs + ;
                                    TmpFinal.CPros + TmpFinal.Notas + TmpFinal.CodCors + ;
                                    TmpFinal.GrupoDs + TmpFinal.ContaDs) OR loc_nLnVezes > 1

                                loc_cClinha  = TmpFinal.Linhas
                                loc_cCpros   = TmpFinal.CPros
                                loc_cCor     = TmpFinal.CodCors
                                loc_cTam     = TmpFinal.CodTams
                                loc_cReff    = TmpFinal.Reffs
                                loc_cGrupoD  = TmpFinal.GrupoDs
                                loc_cContaD  = TmpFinal.ContaDs
                                loc_nSeqs    = loc_nSeqs + 1
                                loc_cNota    = TmpFinal.Notas
                                loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs
                                loc_cCidC    = DTOS(loc_dDtGera) + ;
                                    TRANSFORM(fGerUniqueKey(DTOS(loc_dDtGera)), "@L 999999") + THIS.this_cSigKey

                                INSERT INTO crSigPdMvf (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                        Grupoos, Contaos, Grupods, Contads, Nops, CodPds, Unids, ;
                                        Pesos, Qtds, Ordems, cIdChaves, EmpDopNums, EmpDNps) ;
                                    VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                        loc_cUsuar, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, loc_cGrupoD, ;
                                        loc_cContaD, loc_nNopComp, loc_cCpros, crSigCdPro.CUnis, ;
                                        IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), loc_nTProd, 1, loc_cCidC, ;
                                        loc_cEmpr + SPACE(20) + STR(0, 6), ;
                                        loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10))

                                INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, ;
                                        TotPesos, Grupoos, Contaos, Grupods, Contads, cIdChaves, ;
                                        EmpDNps, Jobs) ;
                                    VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, DATETIME(), loc_dDtGera, ;
                                        loc_cUsuar, loc_nTPeso, crSigCdOpd.GruOrigs, crSigCdOpd.ConOrigs, ;
                                        loc_cGrupoD, loc_cContaD, loc_cCidC, ;
                                        loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), TmpFinal.Jobs)

                                INSERT INTO GrSigCdNei (Emps, Dopps, Numps, Nops, Nenvs, Cmats, Cdescs, ;
                                        cUnis, Pesos, Qtds, TpOps, EmpDNps, cIdChaves, nenvs) ;
                                    VALUES (loc_cEmpr, loc_cDopp, loc_nNopComp, loc_nNopComp, loc_nNopComp, ;
                                        loc_cCpros, crSigCdPro.Dpros, crSigCdPro.Cunis, ;
                                        IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                        IIF(CrSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                        THIS.this_cPamTpOpEntAus, loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), ;
                                        fUniqueIds(), loc_nNopComp)

                                loc_nTProd = 0
                                loc_nTPeso = 0
                            ENDIF

                            loc_nNopComp = (loc_nNump * 10000) + loc_nSeqs

                            IF crSigCdGrp.GeraTubs != 2
                                loc_nQtdTb = crSigCdPro.QtdCpnts
                            ELSE
                                loc_lOk = THIS.ExecutarSQL("SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                    "WHERE Cpros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)), ;
                                    "crSigPrMtz", "crSigPrMtz")
                                IF !loc_lOk
                                    EXIT
                                ENDIF
                                loc_nQtdTb = TratarNulo(crSigPrMtz.Total, 0)
                            ENDIF
                            loc_nQtdCpnt = TratarNulo(loc_nQtdTb, 0) * loc_nQtBaixado

                            loc_uUnits  = 0
                            loc_cMoedas = SPACE(3)

                            loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                                EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)) + ;
                                " AND CPros = " + EscaparSQL(ALLTRIM(TmpFinal.Cpros))
                            loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            SELECT TempEestI
                            SCAN
                                IF TempEestI.CItens = TmpFinal.Citens
                                    loc_uUnits  = TempEestI.Units
                                    loc_cMoedas = TempEestI.Moedas
                                    EXIT
                                ENDIF
                            ENDSCAN
                            IF TmpFinal.KeyPdes
                                loc_uUnits  = crSigCdPro.pVens
                                loc_cMoedas = crSigCdPro.Moevs
                            ENDIF

                            INSERT INTO crSigOpPic (Emps, Dopps, Numps, Nops, Dopes, Numes, Dataes, ;
                                    Dataps, Obss, Qtds, Cpros, DtGeras, CodCors, CodTams, Pesos, ;
                                    QtdCpnts, Units, Moedas, cIdChaves, EmpDopNums, EmpDNps, Notas, ;
                                    Empds, EmpDopNops, Dpros, CodTgOps, Citens) ;
                                VALUES (loc_cEmpr, loc_cDopp, loc_nNump, loc_nNopComp, TmpFinal.Dopes, ;
                                    TmpFinal.Numes, loc_dPrev, TmpFinal.Datas, TmpFinal.Obsps, ;
                                    loc_nQtBaixado, loc_cCpros, loc_dDtGera, TmpFinal.CodCors, ;
                                    TmpFinal.CodTams, loc_nQtBaixado * TmpFinal.Peso, loc_nQtdCpnt, ;
                                    loc_uUnits, loc_cMoedas, fUniqueIds(), ;
                                    TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6), ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNump, 10), TmpFinal.Notas, TmpFinal.Emps, ;
                                    loc_cEmpr + loc_cDopp + STR(loc_nNopComp, 10), TmpFinal.Dpros, ;
                                    THIS.this_cDbCodTgOps, TmpFinal.Citens)

                            *-- Baixa QtProds em SigMvItn/SigMvIts pela
                            *-- quantidade deste lote (dump 4837-4914)
                            SELECT TempEestI
                            loc_nBaixa = loc_nQtBaixado
                            SCAN WHILE loc_nBaixa > 0
                                loc_cPEdn = TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6)
                                loc_nPItn = TempEestI.Citens
                                loc_cPIds = TempEestI.cIdChaves

                                IF (TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds) != 0
                                    loc_lOk = THIS.ExecutarSQL( ;
                                        "SELECT * FROM SigMvIts WHERE EmpDopNums = " + EscaparSQL(loc_cPEdn) + ;
                                        " AND CItens = " + FormatarNumeroSQL(loc_nPItn, 0), ;
                                        "TempEsti2", "TempEsti2 - 1")
                                    IF !loc_lOk
                                        EXIT
                                    ENDIF

                                    SELECT TempEsti2
                                    GO TOP
                                    IF EOF("TempEsti2")
                                        loc_nPendente = TempEestI.Qtds - TempEestI.QtBaixas - TempEestI.QtProds
                                        IF loc_nPendente > loc_nBaixa
                                            loc_nPQtd  = TempEestI.QtProds + loc_nBaixa
                                            loc_nBaixa = 0
                                        ELSE
                                            loc_nPQtd  = TempEestI.QtProds + loc_nPendente
                                            loc_nBaixa = loc_nBaixa - loc_nPendente
                                        ENDIF

                                        loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET DtAlts = " + ;
                                            FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                            FormatarNumeroSQL(loc_nPQtd, 3) + " WHERE cIdChaves = " + ;
                                            EscaparSQL(loc_cPIds), "", "Update - 1")
                                        IF !loc_lOk
                                            EXIT
                                        ENDIF
                                    ELSE
                                        SELECT TempEsti2
                                        SCAN WHILE loc_nBaixa > 0
                                            loc_cPId2     = TempEsti2.cIdChaves
                                            loc_nPendente = TempEsti2.Qtds - TempEsti2.QtBaixas - TempEsti2.QtProds
                                            IF loc_nPendente != 0
                                                IF loc_nPendente > loc_nBaixa
                                                    loc_nPQtd  = TempEestI.QtProds + loc_nBaixa
                                                    loc_nPQt2  = TempEsti2.QtProds + loc_nBaixa
                                                    loc_nBaixa = 0
                                                ELSE
                                                    loc_nPQtd  = TempEestI.QtProds + loc_nPendente
                                                    loc_nPQt2  = TempEsti2.QtProds + loc_nPendente
                                                    loc_nBaixa = loc_nBaixa - loc_nPendente
                                                ENDIF

                                                loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET DtAlts = " + ;
                                                    FormatarDataSQL(loc_tDay) + ", QtProds = " + ;
                                                    FormatarNumeroSQL(loc_nPQtd, 3) + " WHERE cIdChaves = " + ;
                                                    EscaparSQL(loc_cPIds), "", "Update - 2")
                                                IF loc_lOk
                                                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvIts SET QtProds = " + ;
                                                        FormatarNumeroSQL(loc_nPQt2, 3) + " WHERE cIdChaves = " + ;
                                                        EscaparSQL(loc_cPId2), "", "Update - 3")
                                                ENDIF
                                                IF !loc_lOk
                                                    EXIT
                                                ENDIF
                                            ENDIF
                                            SELECT TempEsti2
                                        ENDSCAN
                                    ENDIF
                                ENDIF
                                IF !loc_lOk
                                    EXIT
                                ENDIF
                                SELECT TempEestI
                            ENDSCAN
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Nops = " + ;
                                FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                                " WHERE EmpDopNums = " + ;
                                EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)), ;
                                "", "Update - 4")
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            *-- Composicao SUBSTITUIDA na O.P., se existir
                            loc_cEpn = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                            loc_lOk = THIS.ExecutarSQL("SELECT a.*, b.cgrus FROM SigSubMv a " + ;
                                "INNER JOIN SigCdPro b ON a.mats = b.cpros WHERE a.empdopnums = " + ;
                                EscaparSQL(loc_cEpn) + " AND a.cpros = " + EscaparSQL(ALLTRIM(TmpFinal.CPros)) + ;
                                " AND a.citem2 = " + FormatarNumeroSQL(TmpFinal.citens, 0), ;
                                "LocalCompo", "LocalCompo")
                            IF !loc_lOk
                                EXIT
                            ENDIF

                            IF THIS.this_nPamAutComps != 1 AND USED("LocalCompo") AND RECCOUNT("LocalCompo") > 0
                                SELECT LocalCompo
                                loc_nPesoCmp = THIS.AtualizaPeso()
                                loc_nTProd = loc_nTProd + loc_nQtBaixado
                                loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * loc_nPesoCmp)

                                SELECT crSigOpPic
                                REPLACE Pesos WITH loc_nQtBaixado * loc_nPesoCmp
                            ELSE
                                loc_nTProd = loc_nTProd + loc_nQtBaixado
                                loc_nTPeso = loc_nTPeso + (loc_nQtBaixado * TmpFinal.Peso)
                            ENDIF

                            SELECT crSigPdMvf
                            REPLACE Pesos WITH IIF(THIS.this_nDbOpZers = 1, 0, loc_nTPeso), Qtds WITH loc_nTProd

                            SELECT GrSigCdNei
                            REPLACE Pesos WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso), ;
                                    Qtds  WITH IIF(crSigCdGpr.cpqtds = 1, loc_nTProd, loc_nTPeso) ;
                                IN GrSigCdNei

                            SELECT crSigCdNec
                            REPLACE TotPesos WITH loc_nTPeso
                            IF THIS.this_lAutomatico
                                REPLACE Autos WITH .T.
                            ENDIF
                        ENDDO
                        IF !loc_lOk
                            EXIT
                        ENDIF
                    ELSE
                        *-- PEDIDO DE COMPRA do acabado (fornecedor externo)
                        loc_cForn   = IIF(!EMPTY(crSigCdPro.Ifors), crSigCdPro.Ifors, TmpOpePed.ConOrigs)
                        loc_nTotPed = TmpFinal.Produzir

                        SELECT crSigMvCab
                        GO TOP
                        LOCATE FOR Dopes = ALLTRIM(loc_cDopePed) AND ContaDs = loc_cForn
                        IF FOUND()
                            loc_nNume = crSigMvCab.Numes

                            IF USED("TmpUltItn")
                                USE IN TmpUltItn
                            ENDIF
                            SELECT MAX(Citens) AS Citens FROM crTpmMvItn ;
                                WHERE Emps = loc_cEmpr AND Dopes = ALLTRIM(loc_cDopePed) AND Numes = loc_nNume ;
                                INTO CURSOR TmpUltItn
                            loc_nCitensPed = TratarNulo(TmpUltItn.Citens, 0) + 1
                        ELSE
                            loc_nCitensPed = 9999
                        ENDIF

                        IF loc_nCitensPed >= 9999
                            loc_nCitensPed = 1
                            loc_nNume = fGerUniqueKey(ALLTRIM(loc_cEmpr) + ALLTRIM(loc_cDopePed))

                            INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                                    Grupoos, Contaos, Grupods, Contads, Nops, Obses, Empdopnums, ;
                                    cIdChaves, DtAlts) ;
                                VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                                    loc_dDtGera, DATETIME(), loc_cUsuar, TmpOpePed.GruOrigs, loc_cForn, ;
                                    TmpOpePed.GruDests, TmpOpePed.ConDests, loc_nNump, ;
                                    "[ OP: " + TRANSFORM(loc_nNump) + "] ", ;
                                    loc_cEmpr + loc_cDopePed + STR(loc_nNume, 6), fUniqueIds(), DATETIME())
                        ENDIF

                        INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, ;
                                Citens, Pesos, cUniPs, Obs) ;
                            VALUES (loc_cEmpr, loc_cDopePed, loc_nNume, TmpFinal.Cpros, loc_nTotPed, ;
                                crSigCdPro.Cunis, crSigCdPro.Dpros, "E", loc_nCitensPed, crSigCdPro.PesoMs, ;
                                crSigCdPro.cUniPs, TmpFinal.Obsps)

                        IF !EMPTY(TmpFinal.CodCors) OR !EMPTY(TmpFinal.CodTams)
                            INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, Pesos, ;
                                    CodCors, CodTams, QtdEmbs) ;
                                VALUES (loc_nCitensPed, loc_cEmpr, loc_cDopePed, loc_nNume, TmpFinal.CPros, ;
                                    loc_nTotPed, crSigCdPro.PesoMs, TmpFinal.CodCors, TmpFinal.CodTams, 1)
                        ENDIF

                        loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Nops = " + ;
                            FormatarNumeroSQL(loc_nNump, 0) + ", DtAlts = " + FormatarDataSQL(loc_tDay) + ;
                            " WHERE EmpDopNums = " + ;
                            EscaparSQL(TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)), ;
                            "", "Update - 4.1")
                        IF !loc_lOk
                            EXIT
                        ENDIF
                    ENDIF
                ENDIF
                SELECT TmpFinal
                SKIP
            ENDDO
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaEstoque - dump 5019-5273: empenha o Estoque reservado de
    * TmpFinal contra o saldo priorizado por grupo/conta (cursor_4c_TmpSaldg
    * - "TmpSaldG" do legado, cursor COMPARTILHADO deixado aberto por
    * SigPrGl2BO.ExecutarProcessamento), gera a transferencia (crSigMvCab +
    * crSigMvHst E/S) e baixa QtProds em SigMvItn/SigMvIts + crSigBxEst.
    *
    * Tambem recria TmpOpi (vazio, estrutura de SigOpPic) - acumulador usado
    * por ProcessarBaixaProducao e, no fim de Processar(), por
    * "Append From Dbf('TmpOpi')" em crSigOpPic.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaEstoque()
        LOCAL loc_lOk, loc_nXBaixa, loc_lGrvEest, loc_cChave, loc_cChave2
        LOCAL loc_cEdn, loc_cObses, loc_cQuery, loc_nQtBaixar, loc_nQtBaixado
        LOCAL loc_cChavBus, loc_lTemItem2, loc_cPIds

        loc_lOk = .T.

        IF USED("TmpOpi")
            USE IN TmpOpi
        ENDIF
        loc_lOk = THIS.ExecutarSQL("SELECT * FROM SigOpPic WHERE 1 = 0", "cursor_4c_OpiEstr", "TmpOpi")
        IF loc_lOk
            SELECT * FROM cursor_4c_OpiEstr WHERE .F. INTO CURSOR TmpOpi READWRITE
            USE IN cursor_4c_OpiEstr
        ENDIF

        IF loc_lOk
            *-- SET FILTER TO antes do REPLACE ALL: a tela deixa um filtro
            *-- por item corrente neste cursor (FormSigPrGlx.
            *-- GradeItensPage1AfterRowColChange, que reproduz o "Set Key To"
            *-- do legado). Medido no VFP9 em 2026-10-06: "SET ORDER TO"
            *-- limpa SET KEY mas NAO limpa SET FILTER, e "REPLACE ALL" sob
            *-- filtro altera SO as linhas visiveis - sem o SET FILTER TO
            *-- abaixo, a reserva de estoque seria gravada apenas para o
            *-- ultimo item que o usuario olhou, em silencio.
            SELECT cursor_4c_TmpSaldg
            SET ORDER TO
            SET FILTER TO
            REPLACE ALL Reservs WITH Saldo - Disps

            IF USED("TmpEstoque")
                USE IN TmpEstoque
            ENDIF
            CREATE CURSOR TmpEstoque (EmpDs C(3), Cpros C(14), CodCors C(4), CodTams C(4), ;
                Emps C(3), Dopes C(20), Numes N(6), grupos C(10), Estos C(10), Estoque N(12,3))
            INDEX ON EmpDs + Grupos + Estos + Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

            SELECT TmpFinal
            SET ORDER TO
            SCAN
                IF TmpFinal.Estoque != 0
                    loc_nXBaixa = TmpFinal.Estoque
                    SELECT cursor_4c_TmpSaldg
                    SET ORDER TO CPros
                    = SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
                    SCAN WHILE cursor_4c_TmpSaldg.Cpros = TmpFinal.Cpros AND ;
                            cursor_4c_TmpSaldg.CodCors = TmpFinal.CodCors AND ;
                            cursor_4c_TmpSaldg.CodTams = TmpFinal.CodTams AND loc_nXBaixa > 0
                        IF cursor_4c_TmpSaldg.Reservs >= loc_nXBaixa
                            REPLACE cursor_4c_TmpSaldg.Reservs WITH cursor_4c_TmpSaldg.Reservs - loc_nXBaixa ;
                                IN cursor_4c_TmpSaldg
                            INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, ;
                                    Grupos, Estos, Estoque, EmpDs) ;
                                VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                    TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpSaldg.Grupos, ;
                                    cursor_4c_TmpSaldg.Estos, loc_nXBaixa, cursor_4c_TmpSaldg.Emps)
                            loc_nXBaixa = 0
                        ELSE
                            IF cursor_4c_TmpSaldg.Reservs > 0
                                loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpSaldg.Reservs
                                INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, ;
                                        Grupos, Estos, Estoque, EmpDs) ;
                                    VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                        TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpSaldg.Grupos, ;
                                        cursor_4c_TmpSaldg.Estos, cursor_4c_TmpSaldg.Reservs, cursor_4c_TmpSaldg.Emps)
                                REPLACE cursor_4c_TmpSaldg.Reservs WITH 0 IN cursor_4c_TmpSaldg
                            ENDIF
                        ENDIF
                        SELECT cursor_4c_TmpSaldg
                    ENDSCAN
                    SELECT TmpFinal
                ENDIF
            ENDSCAN

            loc_lGrvEest = .F.
            loc_cChave   = SPACE(30)
            loc_cChave2  = SPACE(20)
            loc_nCitens  = 1

            SELECT TmpEstoque
            SET ORDER TO EmpDopNum

            SCAN
                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEstoque.CPros))
                = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))
                SELECT TmpEstoque

                IF (TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2) OR ;
                        (TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6) != loc_cChave)

                    IF (TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos != loc_cChave2)
                        loc_lGrvEest = .F.
                    ENDIF
                    loc_cChave2 = TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos
                    loc_cChave  = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                    loc_cEdn = TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Nops = " + FormatarNumeroSQL(loc_nNump, 0) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                        "", "Update - 5")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    = THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(TmpEstoque.Dopes))
                    = THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)

                    IF crSigCdOpe.Globalizas = 1
                        loc_cGrupoD = TempEest.Grupoos
                        loc_cContaD = TempEest.Contaos
                    ELSE
                        loc_cGrupoD = TempEest.Grupods
                        loc_cContaD = TempEest.Contads
                    ENDIF

                    IF !EMPTY(THIS.this_cPamGruReservs)
                        loc_cGrupoD = THIS.this_cPamGruReservs
                    ENDIF
                    IF !EMPTY(THIS.this_cPamConReservs)
                        loc_cContaD = THIS.this_cPamConReservs
                    ENDIF

                    IF (THIS.this_nPamAgrupEmph = 2 AND !EMPTY(THIS.this_cPamGruReservs) AND !loc_lGrvEest) OR ;
                            (THIS.this_nPamAgrupEmph != 2)
                        loc_nNume   = fGerUniqueKey(ALLTRIM(TmpEstoque.EmpDs) + ALLTRIM(loc_cDope))
                        loc_nCitens = 1

                        INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                                Grupoos, Contaos, Grupods, Contads, Nops, Obses, cIdChaves, Dtalts, ;
                                EmpDopNums, EmpDs, rNops) ;
                            VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                                loc_dDtGera, DATETIME(), loc_cUsuar, TmpEstoque.grupos, TmpEstoque.Estos, ;
                                loc_cGrupoD, loc_cContaD, loc_nNump, ;
                                IIF(THIS.this_lReserva, " [ Reserva Autom" + CHR(225) + "tica ] ", ;
                                    "[ OP: " + TRANSFORM(loc_nNump) + "] ") + loc_cChave, ;
                                fUniqueIds(), DATETIME(), TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), ;
                                loc_cEmpr, loc_nRnop)
                        loc_lGrvEest = .T.
                    ELSE
                        loc_cEdn = TmpEstoque.Emps + loc_cDope + STR(loc_nNume, 6)
                        = THIS.ConsultarTabela("SigMvCab", "TempEest", "EmpDopNums", loc_cEdn)

                        loc_cObses = TratarNulo(TempEest.Obses, "") + " / " + loc_cChave

                        loc_lOk = THIS.ExecutarSQL("UPDATE SigMvCab SET Obses = " + EscaparSQL(loc_cObses) + ;
                            ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE EmpDopNums = " + EscaparSQL(loc_cEdn), ;
                            "", "Update - 6")
                        IF !loc_lOk
                            EXIT
                        ENDIF
                    ENDIF
                ENDIF

                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens) ;
                    VALUES (TmpEstoque.EmpDs, loc_cDope, loc_nNume, TmpEstoque.CPros, TmpEstoque.Estoque, ;
                        crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens)

                IF crSigCdGrp.TipoEstos > 1
                    INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs) ;
                        VALUES (loc_nCitens, TmpEstoque.EmpDs, loc_cDope, loc_nNume, TmpEstoque.CPros, ;
                            TmpEstoque.Estoque, TmpEstoque.CodCors, TmpEstoque.CodTams, 1)
                ENDIF

                loc_nCitens = loc_nCitens + 1

                = THIS.ConsultarTabela("SigCdOpe", "crSigCdOpe", "Dopes", ALLTRIM(loc_cDope))

                IF crSigCdOpe.Estoqs = 1
                    INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, ;
                            Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, OriDopNums, ;
                            cIdChaves, Seqs) ;
                        VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), TmpEstoque.EmpDs, loc_cDope, loc_nNume, ;
                            loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "S", TmpEstoque.Grupos, ;
                            TmpEstoque.Estos, TmpEstoque.CodCors, TmpEstoque.CodTams, ;
                            TmpEstoque.Empds + loc_cDope + STR(loc_nNume, 6), ;
                            TmpEstoque.EmpDs + TmpEstoque.Grupos + TmpEstoque.Estos, ;
                            TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), fUniqueIds(), 0)

                    INSERT INTO crSigMvHst (Usuars, Datas, Datars, Emps, Dopes, Numes, Empos, Cpros, Qtds, ;
                            Opers, Grupos, Estos, CodCors, CodTams, EmpDopNums, EmpGruEsts, OriDopNums, ;
                            cIdChaves, Seqs) ;
                        VALUES (loc_cUsuar, loc_dDtGera, DATETIME(), loc_cEmpr, loc_cDope, loc_nNume, ;
                            loc_cEmpr, TmpEstoque.CPros, TmpEstoque.Estoque, "E", loc_cGrupoD, loc_cContaD, ;
                            TmpEstoque.CodCors, TmpEstoque.CodTams, loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                            loc_cEmpr + loc_cGrupoD + loc_cContaD, TmpEstoque.EmpDs + loc_cDope + STR(loc_nNume, 6), ;
                            fUniqueIds(), 0)

                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                *-- Baixar a quantidade para nao produzir (QtProds), em
                *-- SigMvItn e, em paralelo, em SigMvIts (dump 5175-5272)
                loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + ;
                    EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
                loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 2")
                IF !loc_lOk
                    EXIT
                ENDIF
                GO TOP IN TempEsti2
                loc_lTemItem2 = !EOF("TempEsti2")

                loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                    EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                    " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
                loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
                IF !loc_lOk
                    EXIT
                ENDIF

                loc_nQtBaixar = TmpEstoque.Estoque
                SELECT TempEestI
                SCAN WHILE loc_nQtBaixar > 0
                    loc_cPIds = TempEestI.cIdChaves
                    IF (TempEestI.QtProds + loc_nQtBaixar) <= TempEestI.Qtds
                        loc_nPQtd      = TempEestI.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEestI.Qtds - TempEestI.QtProds)
                        loc_nQtBaixado = TempEestI.Qtds - TempEestI.QtProds
                        loc_nPQtd      = TempEestI.Qtds
                    ENDIF

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET QtProds = " + ;
                        FormatarNumeroSQL(loc_nPQtd, 3) + ;
                        IIF(THIS.this_lReserva, ", QtReservas = " + FormatarNumeroSQL(loc_nPQtd, 3), ;
                            ", QtReservas = " + FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE cIdChaves = " + EscaparSQL(loc_cPIds), ;
                        "", "Update - 7")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    IF !loc_lTemItem2
                        INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, ;
                                Numebs, Qtdfs, CidChaves, EmpDopNums, EmpDopNumb) ;
                            VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEestI.CItens, TempEestI.Cpros, ;
                                loc_dDtGera, TempEestI.Emps, TempEestI.Dopes, TempEestI.Numes, loc_nQtBaixado, ;
                                fUniqueIds(), loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                                TempEestI.Emps + TempEestI.Dopes + STR(TempEestI.Numes, 6))
                    ENDIF
                    SELECT TempEestI
                ENDSCAN
                IF !loc_lOk
                    EXIT
                ENDIF

                loc_nQtBaixar = TmpEstoque.Estoque
                SELECT TempEsti2
                SCAN WHILE loc_nQtBaixar > 0
                    IF (TempEsti2.CodCors != TmpEstoque.CodCors) OR (TempEsti2.CodTams != TmpEstoque.CodTams)
                        LOOP
                    ENDIF

                    loc_cPIds = TempEsti2.cIdChaves
                    IF (TempEsti2.QtProds + loc_nQtBaixar) <= TempEsti2.Qtds
                        loc_nPQtd      = TempEsti2.QtProds + loc_nQtBaixar
                        loc_nQtBaixado = loc_nQtBaixar
                        loc_nQtBaixar  = 0
                    ELSE
                        loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2.Qtds - TempEsti2.QtProds)
                        loc_nQtBaixado = TempEsti2.Qtds - TempEsti2.QtProds
                        loc_nPQtd      = TempEsti2.Qtds
                    ENDIF

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigMvIts SET QtProds = " + ;
                        FormatarNumeroSQL(loc_nPQtd, 3) + ;
                        IIF(THIS.this_lReserva, ", QtReservas = " + FormatarNumeroSQL(loc_nPQtd, 3), ;
                            ", QtReservas = " + FormatarNumeroSQL(loc_nQtBaixado, 3)) + ;
                        ", DtAlts = " + FormatarDataSQL(loc_tDay) + " WHERE cIdChaves = " + EscaparSQL(loc_cPIds), ;
                        "", "Update - 8")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    INSERT INTO crSigBxEst (Emps, Dopes, Numes, CItens, Cpros, Datas, Empbs, Dopebs, Numebs, ;
                            Qtdfs, CodCors, CodTams, cIdChaves, EmpDopNums, EmpDopNumb) ;
                        VALUES (loc_cEmpr, loc_cDope, loc_nNume, TempEsti2.CItens, TempEsti2.cpros, loc_dDtGera, ;
                            TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, loc_nQtBaixado, TempEsti2.CodCors, ;
                            TempEsti2.CodTams, fUniqueIds(), loc_cEmpr + loc_cDope + STR(loc_nNume, 6), ;
                            TempEsti2.Emps + TempEsti2.Dopes + STR(TempEsti2.Numes, 6))
                    SELECT TempEsti2
                ENDSCAN
                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT TmpEstoque
            ENDSCAN
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarBaixaProducao - dump 5275-5498: empenha o Fabrs (producao em
    * fase) de TmpFinal contra cursor_4c_TmpFabr ("TmpFabr" do legado, idem
    * cursor_4c_TmpSaldg - compartilhado por SigPrGl2BO), grava a entrada de
    * liberacao manual (crSigInAtz, quando UsuLibs preenchido por
    * BtnAlteraqtdClick), gera os itens de producao (crTpmMvItn/crTplMvIts)
    * e baixa a quantidade usada contra as O.P.s de origem (CrSigOpPii +
    * TmpOpi + QtProds em SigMvItn/SigMvIts).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarBaixaProducao()
        LOCAL loc_lOk, loc_nXBaixa, loc_nQtdF, loc_cQuery, loc_nQtBaixar, loc_nQtBaixado, loc_nPQtd
        LOCAL ARRAY loc_aLinha[1]

        loc_lOk = .T.

        *-- SET FILTER TO: mesma razao do ProcessarBaixaEstoque - a tela
        *-- deixa um filtro por item corrente neste cursor e "SET ORDER TO"
        *-- nao o limpa; sem isto o REPLACE ALL cobriria so o ultimo item
        *-- visitado pelo usuario.
        SELECT cursor_4c_TmpFabr
        SET ORDER TO
        SET FILTER TO
        REPLACE ALL Reservs WITH Disps

        IF USED("TmpEstoque")
            USE IN TmpEstoque
        ENDIF
        CREATE CURSOR TmpEstoque (Cpros C(14), CodCors C(4), CodTams C(4), Emps C(3), Dopes C(20), ;
            Numes N(6), Nops N(10), Estoque N(12,3))
        INDEX ON Emps + Dopes + STR(Numes, 6) TAG EmpDopNum

        SELECT TmpFinal
        SET ORDER TO
        SCAN
            IF TmpFinal.Fabrs != 0
                loc_nXBaixa = TmpFinal.Fabrs
                SELECT cursor_4c_TmpFabr
                SET ORDER TO Cpros
                = SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams)
                SCAN WHILE cursor_4c_TmpFabr.Cpros = TmpFinal.Cpros AND ;
                        cursor_4c_TmpFabr.CodCors = TmpFinal.CodCors AND ;
                        cursor_4c_TmpFabr.CodTams = TmpFinal.CodTams AND loc_nXBaixa > 0
                    IF cursor_4c_TmpFabr.Reservs >= loc_nXBaixa
                        REPLACE cursor_4c_TmpFabr.Reservs WITH cursor_4c_TmpFabr.Reservs - loc_nXBaixa ;
                            IN cursor_4c_TmpFabr
                        INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Nops, Estoque) ;
                            VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpFabr.Nops, loc_nXBaixa)
                        loc_nXBaixa = 0
                    ELSE
                        IF cursor_4c_TmpFabr.Reservs > 0
                            loc_nXBaixa = loc_nXBaixa - cursor_4c_TmpFabr.Reservs
                            INSERT INTO TmpEstoque (Cpros, CodCors, CodTams, Emps, dopes, Numes, Nops, Estoque) ;
                                VALUES (TmpFinal.Cpros, TmpFinal.CodCors, TmpFinal.CodTams, TmpFinal.Emps, ;
                                    TmpFinal.Dopes, TmpFinal.Numes, cursor_4c_TmpFabr.Nops, cursor_4c_TmpFabr.Reservs)
                            REPLACE cursor_4c_TmpFabr.Reservs WITH 0 IN cursor_4c_TmpFabr
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_TmpFabr
                ENDSCAN
                SELECT TmpFinal
            ENDIF
        ENDSCAN

        SELECT crSigMvCab
        LOCATE FOR Dopes = loc_cDopEst
        IF FOUND()
            loc_nNume = crSigMvCab.Numes
        ENDIF

        loc_nCitens = 1
        SELECT TmpFinalg
        SET ORDER TO
        SCAN
            IF !EMPTY(TmpFinalg.UsuLibs)
                loc_nQtdF = IIF(TmpFinalg.QtdMins > 0 AND TmpFinalg.Produzir < TmpFinalg.QtdMins AND ;
                    TmpFinalg.Produzir > 0, TmpFinalg.QtdMins - TmpFinalg.Produzir, 0)

                INSERT INTO crSigInAtz (Emps, dopes, Numes, EmpDopNums, Cpros, Qtds, Qtdes, qtdps, ;
                        qtdfs, qtdms, qtdfes, qtdfins, usulibs, CidChaves) ;
                    VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), ;
                        TmpFinalg.CPros, TmpFinalg.Saldo, TmpFinalg.Estoque, TmpFinalg.fabrs, ;
                        TmpFinalg.Produzir, TmpFinalg.qtdmins, loc_nQtdF, TmpFinalg.Produzir2, ;
                        TmpFinalg.usuLibs, fUniqueIds())
                loc_lPedUtilz = .T.
            ENDIF

            IF TmpFinalg.Produzir2 = 0
                LOOP
            ENDIF

            = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpFinalg.CPros))
            = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))

            INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, cItens, ;
                    Pesos, Units, Moedas, Totas) ;
                VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, TmpFinalg.CPros, TmpFinalg.Produzir2, ;
                    crSigCdPro.Cunis, crSigCdPro.Dpros, "S", loc_nCitens, ;
                    (CrSigCdPro.PesoMs * TmpFinalg.Produzir2), CrSigCdPro.pVens, CrSigCdPro.Moevs, ;
                    TmpFinalg.Produzir2 * CrSigCdPro.Pvens)

            loc_lPedUtilz = .T.
            IF !THIS.this_lReserva
                REPLACE QtProds WITH Qtds IN crTpmMvItn
            ENDIF

            IF crSigCdGrp.TipoEstos > 1
                INSERT INTO crTplMvIts (cItens, Emps, Dopes, Numes, CPros, Qtds, CodCors, CodTams, QtdEmbs) ;
                    VALUES (loc_nCitens, loc_cEmpr, loc_cDopEst, loc_nNume, TmpFinalg.CPros, ;
                        TmpFinalg.produzir2, TmpFinalg.CodCors, TmpFinalg.CodTams, 1)
            ENDIF
            loc_nCitens = loc_nCitens + 1
            SELECT TmpFinalg
        ENDSCAN

        SELECT TmpEstoque
        SCAN
            loc_nXBaixa = TmpEstoque.Estoque

            loc_lOk = THIS.ExecutarSQL("SELECT * FROM SigOpPic WHERE Nops = " + ;
                FormatarNumeroSQL(TmpEstoque.Nops, 0), "LocalOpi", "LocalOpi")
            IF !loc_lOk
                EXIT
            ENDIF

            SELECT LocalOpi
            GO TOP
            SCAN WHILE loc_nXBaixa > 0
                IF LocalOpi.Dopes != loc_cDopEst
                    LOOP
                ENDIF
                IF LocalOpi.Qtds >= loc_nXBaixa
                    REPLACE Qtds WITH Qtds - loc_nXBaixa IN LocalOpi
                    SCATTER TO loc_aLinha

                    loc_lOk = THIS.ExecutarSQL("UPDATE SigOpPic SET Qtds = " + ;
                        FormatarNumeroSQL(LocalOpi.Qtds, 3) + " WHERE CidChaves = " + ;
                        EscaparSQL(LocalOpi.CidChaves), "", "Update SigOpPic")
                    IF !loc_lOk
                        EXIT
                    ENDIF

                    INSERT INTO CrSigOpPii (Emps, dopes, Numes, EmpDopNums, Empos, DopeOs, NumeOs, ;
                            EmpDs, DopeDs, Numeds, Qtds, Nops, Cidchaves) ;
                        VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), ;
                            LocalOpi.Empds, LocalOpi.Dopes, LocalOpi.Numes, TmpEstoque.Emps, TmpEstoque.Dopes, ;
                            TmpEstoque.Numes, loc_nXBaixa, LocalOpi.Nops, fUniqueIds())

                    loc_lPedUtilz = .T.

                    SELECT TmpOpi
                    APPEND FROM ARRAY loc_aLinha
                    REPLACE Empds WITH TmpEstoque.Emps, Dopes WITH TmpEstoque.Dopes, ;
                            Numes WITH TmpEstoque.Numes, Qtds WITH loc_nXBaixa, ;
                            EmpDopNums WITH TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6), ;
                            CidChaves  WITH fUniqueIds() IN TmpOpi
                    loc_nXBaixa = 0
                ELSE
                    IF LocalOpi.Qtds > 0
                        INSERT INTO CrSigOpPii (Emps, dopes, Numes, EmpDopNums, Empos, DopeOs, NumeOs, ;
                                EmpDs, DopeDs, Numeds, Qtds, Nops, Cidchaves) ;
                            VALUES (loc_cEmpr, loc_cDopEst, loc_nNume, loc_cEmpr + loc_cDopEst + STR(loc_nNume, 6), ;
                                LocalOpi.Empds, LocalOpi.Dopes, LocalOpi.Numes, TmpEstoque.Emps, TmpEstoque.Dopes, ;
                                TmpEstoque.Numes, LocalOpi.Qtds, LocalOpi.Nops, fUniqueIds())

                        loc_nXBaixa = loc_nXBaixa - LocalOpi.Qtds
                        REPLACE Empds WITH TmpEstoque.Emps, Dopes WITH TmpEstoque.Dopes, ;
                                Numes WITH TmpEstoque.Numes, ;
                                EmpDopNums WITH TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6) ;
                            IN LocalOpi

                        loc_lPedUtilz = .T.

                        SELECT LocalOpi
                        SCATTER TO loc_aLinha
                        SELECT TmpOpi
                        APPEND FROM ARRAY loc_aLinha
                    ENDIF
                ENDIF
                SELECT LocalOpi
            ENDSCAN
            IF !loc_lOk
                EXIT
            ENDIF

            *-- Baixar a quantidade para nao produzir (QtProds), em paralelo
            *-- em SigMvItn e SigMvIts (dump 5416-5497)
            loc_cQuery = "SELECT * FROM SigMvIts WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
            loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEsti2", "TempEsti2 - 2")
            IF !loc_lOk
                EXIT
            ENDIF

            loc_cQuery = "SELECT * FROM SigMvItn WHERE EmpDopNums = " + ;
                EscaparSQL(TmpEstoque.Emps + TmpEstoque.Dopes + STR(TmpEstoque.Numes, 6)) + ;
                " AND CPros = " + EscaparSQL(ALLTRIM(TmpEstoque.Cpros))
            loc_lOk = THIS.ExecutarSQL(loc_cQuery, "TempEestI", "TempEestI")
            IF !loc_lOk
                EXIT
            ENDIF

            loc_nQtBaixar = TmpEstoque.Estoque
            SELECT TempEestI
            SCAN WHILE loc_nQtBaixar > 0
                IF (TempEestI.QtProds + loc_nQtBaixar) <= TempEestI.Qtds
                    loc_nPQtd      = TempEestI.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEestI.Qtds - TempEestI.QtProds)
                    loc_nQtBaixado = TempEestI.Qtds - TempEestI.QtProds
                    loc_nPQtd      = TempEestI.Qtds
                ENDIF

                loc_lOk = THIS.ExecutarSQL("UPDATE SigMvItn SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    " WHERE cIdChaves = " + EscaparSQL(TempEestI.cIdChaves), "", "Update - 7b")
                IF !loc_lOk
                    EXIT
                ENDIF
                SELECT TempEestI
            ENDSCAN
            IF !loc_lOk
                EXIT
            ENDIF

            loc_nQtBaixar = TmpEstoque.Estoque
            SELECT TempEsti2
            SCAN WHILE loc_nQtBaixar > 0
                IF (TempEsti2.CodCors != TmpEstoque.CodCors) OR (TempEsti2.CodTams != TmpEstoque.CodTams)
                    LOOP
                ENDIF
                IF (TempEsti2.QtProds + loc_nQtBaixar) <= TempEsti2.Qtds
                    loc_nPQtd      = TempEsti2.QtProds + loc_nQtBaixar
                    loc_nQtBaixado = loc_nQtBaixar
                    loc_nQtBaixar  = 0
                ELSE
                    loc_nQtBaixar  = loc_nQtBaixar - (TempEsti2.Qtds - TempEsti2.QtProds)
                    loc_nQtBaixado = TempEsti2.Qtds - TempEsti2.QtProds
                    loc_nPQtd      = TempEsti2.Qtds
                ENDIF

                loc_lOk = THIS.ExecutarSQL("UPDATE SigMvIts SET QtProds = " + FormatarNumeroSQL(loc_nPQtd, 3) + ;
                    " WHERE cIdChaves = " + EscaparSQL(TempEsti2.cIdChaves), "", "Update - 8b")
                IF !loc_lOk
                    EXIT
                ENDIF
                SELECT TempEsti2
            ENDSCAN
            IF !loc_lOk
                EXIT
            ENDIF

            SELECT TmpEstoque
        ENDSCAN

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarRequisicaoPedras - dump 5500-5797: SO roda quando SigCdPam
    * tem as 4 operacoes de empenho/requisicao/pedido/compra configuradas E
    * this_nEmphPdr != 0 E nao eh Reserva Automatica. Acumula a necessidade
    * de material da requisicao manual (SelPedra/cursor_4c_Requisicao) e dos
    * componentes de TmpFinal (via BuscarCompos) em TmpPedra/TmpEmpH/
    * TmpMatPrz, deduz estoque/pedidos/compras ja em aberto e gera o empenho
    * (crSigMvCab + crTpmMvItn, Dopp = SigCdPam.DopEmphs).
    *
    * NAO TRANSCRITO: o "Do While lnTotReq > 0" do dump (5746-5795), que
    * gera requisicao de compra agrupada por fornecedor+prazo - a variavel
    * lnTotReq NUNCA eh atribuida antes desse ponto em todo o Click legado
    * (conferido linha a linha), caracterizando bug/codigo morto do proprio
    * legado (VFP estouraria "Variable LNTOTREQ is not found" numa sessao
    * nova). Reproduzido como loc_nTotReq = 0 (loop nunca executa) em vez de
    * replicar o erro do legado.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarRequisicaoPedras()
        LOCAL loc_lOk, loc_nQtde, loc_cQuery, loc_cBusca, loc_cEpn, loc_dDtEnt
        LOCAL loc_nX, loc_cOperBusca, loc_cCampo, loc_cEds, loc_cEdn, loc_nTotReq
        LOCAL loc_cForn, loc_cCgru, loc_nLnQtd

        loc_lOk = .T.

        IF !EMPTY(THIS.this_cPamDopEmphs) AND !EMPTY(THIS.this_cPamDopReqcs) AND ;
                !EMPTY(THIS.this_cPamDopPedcs) AND !THIS.this_lReserva AND THIS.this_nEmphPdr != 0

            IF USED("cursor_4c_Requisicao")
                SELECT cursor_4c_Requisicao
                SCAN
                    IF EMPTY(cursor_4c_Requisicao.Cpros) OR cursor_4c_Requisicao.Qtds <= 0
                        LOOP
                    ENDIF

                    = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(cursor_4c_Requisicao.Cpros))
                    = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                    = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))

                    IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND !EMPTY(crSigCdGrp.ConEstps)
                        loc_nQtde = cursor_4c_Requisicao.Qtds

                        SELECT TmpPedra
                        IF !SEEK(ALLTRIM(cursor_4c_Requisicao.Cpros))
                            INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                    cursor_4c_Requisicao.cpros, crSigCdPro.QMins)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde

                        SELECT TmpMatPrz
                        IF !SEEK(DTOC(DATE()) + ALLTRIM(cursor_4c_Requisicao.Cpros))
                            INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                                VALUES (cursor_4c_Requisicao.cpros, DATE())
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde

                        SELECT TmpEmpH
                        IF !SEEK(ALLTRIM(cursor_4c_Requisicao.Cpros) + ALLTRIM(cursor_4c_Requisicao.Cpro2s))
                            INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                    cursor_4c_Requisicao.cpros, crSigCdPro.QMins, cursor_4c_Requisicao.Cpro2s)
                        ENDIF
                        REPLACE Qtds WITH Qtds + loc_nQtde
                    ENDIF
                    SELECT cursor_4c_Requisicao
                ENDSCAN
            ENDIF

            SELECT TmpFinal
            SET ORDER TO Cpros
            SCAN
                IF TmpFinal.Produzir = 0
                    LOOP
                ENDIF

                = THIS.ExecutarSQL("SELECT GerEmphs FROM SigOpCdc WHERE Dopes = " + ;
                    EscaparSQL(ALLTRIM(TmpFinal.Dopes)), "TmpDcOpe", "TmpDcOpe")
                IF !USED("TmpDcOpe") OR TratarNulo(TmpDcOpe.GerEmphs, 0) != 1
                    SELECT TmpFinal
                    LOOP
                ENDIF

                loc_cEpn    = TmpFinal.Emps + TmpFinal.Dopes + STR(TmpFinal.Numes, 6)
                loc_cBusca  = THIS.BuscarCompos(loc_cEpn, ALLTRIM(TmpFinal.CPros), TmpFinal.citens, "")

                IF !EMPTY(loc_cBusca) AND USED(loc_cBusca)
                    IF USED("crSigPrCpo")
                        USE IN crSigPrCpo
                    ENDIF
                    SELECT * FROM (loc_cBusca) INTO CURSOR crSigPrCpo READWRITE

                    SELECT crSigPrCpo
                    SCAN
                        = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(crSigPrCpo.Mats))
                        = THIS.ConsultarTabela("SigCdUni", "crSigCdUni", "CUnis", ALLTRIM(crSigCdPro.CUnis))
                        = THIS.ConsultarTabela("SigCdGrp", "crSigCdGrp", "CGrus", ALLTRIM(crSigCdPro.CGrus))

                        IF crSigCdGrp.CEstoqs = 1 AND !EMPTY(crSigCdGrp.GruEstps) AND !EMPTY(crSigCdGrp.ConEstps)
                            loc_nQtde = TmpFinal.Produzir * crSigPrCpo.Qtds

                            SELECT TmpPedra
                            IF !SEEK(ALLTRIM(crSigPrCpo.Mats))
                                INSERT INTO TmpPedra (Grupos, Contas, cGrus, cMats, QtdMins) ;
                                    VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                        crSigPrCpo.Mats, crSigCdPro.QMins)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc_nQtde

                            SELECT TmpMatPrz
                            loc_dDtEnt = IIF(THIS.this_nPacAgrupReqs = 1, ;
                                TratarNulo(TmpFinal.Entregas, {}), DATE())
                            IF !SEEK(DTOC(loc_dDtEnt) + ALLTRIM(crSigPrCpo.Mats))
                                INSERT INTO TmpMatPrz (cMats, PrazoEnts) ;
                                    VALUES (crSigPrCpo.Mats, loc_dDtEnt)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc_nQtde

                            SELECT TmpEmpH
                            IF !SEEK(ALLTRIM(crSigPrCpo.Mats) + ALLTRIM(crSigPrCpo.Cpros))
                                INSERT INTO TmpEmpH (Grupos, Contas, cGrus, cMats, QtdMins, Cpro2s) ;
                                    VALUES (crSigCdGrp.GruEstps, crSigCdGrp.ConEstps, crSigCdPro.CGrus, ;
                                        crSigPrCpo.Mats, crSigCdPro.QMins, crSigPrCpo.Cpros)
                            ENDIF
                            REPLACE Qtds WITH Qtds + loc_nQtde
                        ENDIF
                        SELECT crSigPrCpo
                    ENDSCAN
                ENDIF
                SELECT TmpFinal
            ENDSCAN

            FOR loc_nX = 1 TO 5
                loc_cOperBusca = ICASE(loc_nX = 1, THIS.this_cPamDopEmphs, loc_nX = 2, THIS.this_cPamDopReqcs, ;
                    loc_nX = 3, THIS.this_cPamDopPedcs, loc_nX = 4, THIS.this_cPamDopComps, ;
                    THIS.this_cPamDopTrfCps)
                loc_cCampo = "Qtd" + ICASE(loc_nX = 1, "Emphs", loc_nX = 2, "Reqs", loc_nX = 3, "Pedcs", "Comps")

                IF EMPTY(loc_cOperBusca)
                    LOOP
                ENDIF

                loc_cEds = loc_cEmpr + ALLTRIM(loc_cOperBusca)
                loc_lOk = THIS.ExecutarSQL("SELECT * FROM SigMvCab WHERE EmpDopNums BETWEEN " + ;
                    EscaparSQL(loc_cEds + "     0") + " AND " + EscaparSQL(loc_cEds + "999999"), ;
                    "TempEest", "TempEest")
                IF !loc_lOk
                    EXIT
                ENDIF

                SELECT TempEest
                SCAN
                    loc_cEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                    = THIS.ConsultarTabela("SigMvItn", "TempEestI", "EmpDopNums", loc_cEdn)

                    SELECT TempEestI
                    SCAN
                        IF (TempEestI.Qtds - TempEestI.QtBaixas) > 0
                            SELECT TmpPedra
                            IF SEEK(ALLTRIM(TempEestI.Cpros))
                                REPLACE &loc_cCampo. WITH &loc_cCampo. + (TempEestI.Qtds - TempEestI.QtBaixas)
                            ENDIF
                        ENDIF
                        SELECT TempEestI
                    ENDSCAN
                    SELECT TempEest
                ENDSCAN
            ENDFOR
            IF !loc_lOk
                loc_lAbortar = .T.
                RETURN
            ENDIF

            loc_lOk = THIS.ExecutarSQL("SELECT b.* FROM SigMvEst b WHERE NOT b.Sqtds = 0 AND " + ;
                "b.Grupos + b.Estos IN (SELECT GruEstps + ConEstPs FROM SigCdGrp " + ;
                "WHERE NOT GruEstPs = " + EscaparSQL(SPACE(10)) + " AND NOT ConEstPs = " + ;
                EscaparSQL(SPACE(10)) + " GROUP BY GruEstPs, ConEstPs)", "pEstoque", "pEstoque")
            IF !loc_lOk
                loc_lAbortar = .T.
                RETURN
            ENDIF

            SELECT pEstoque
            SCAN
                SELECT TmpPedra
                IF SEEK(ALLTRIM(pEstoque.Cpros))
                    REPLACE QtdEsts WITH QtdEsts + pEstoque.Sqtds
                ENDIF
                SELECT pEstoque
            ENDSCAN

            SELECT TmpEmpH
            SET ORDER TO GruMat
            GO TOP
            loc_cCgru   = TmpEmpH.Cgrus
            loc_nCitens = 999
            SCAN
                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpEmpH.CMats))

                IF TmpEmpH.Cgrus != loc_cCgru
                    loc_nCitens = 999
                    loc_cCgru   = TmpEmpH.Cgrus
                ENDIF

                IF loc_nCitens >= 999
                    loc_nCitens = 1
                    loc_cDopp   = PADR(THIS.this_cPamDopEmphs, 20)
                    loc_nNume   = fGerUniqueKey(ALLTRIM(loc_cEmpr) + ALLTRIM(loc_cDopp))

                    INSERT INTO crSigMvCab (Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, ;
                            Grupoos, Contaos, Nops, Obses, EmpDopNums, cIdChaves, DtAlts, rNops) ;
                        VALUES (loc_cEmpr, loc_cDopp, loc_nNume, ALLTRIM(fGerMascara(loc_nNume)), ;
                            loc_dDtGera, DATETIME(), loc_cUsuar, TmpEmpH.Grupos, TmpEmpH.contas, loc_nNump, ;
                            "[ OP: " + TRANSFORM(loc_nNump) + "] ", loc_cEmpr + loc_cDopp + STR(loc_nNume, 6), ;
                            fUniqueIds(), DATETIME(), loc_nRnop)
                ENDIF

                INSERT INTO crTpmMvItn (Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros, Opers, Citens, cPro2s) ;
                    VALUES (loc_cEmpr, loc_cDopp, loc_nNume, TmpEmpH.cMats, TmpEmpH.Qtds, crSigCdPro.Cunis, ;
                        crSigCdPro.Dpros, "S", loc_nCitens, TmpEmpH.Cpro2s)

                loc_nCitens = loc_nCitens + 1
                SELECT TmpEmpH
            ENDSCAN

            SELECT TmpPedra
            SCAN
                loc_cDope = PADR(THIS.this_cPamDopReqcs, 20)
                = THIS.ConsultarTabela("SigOpCdc", "crSigOpCdc", "Dopes", ALLTRIM(loc_cDope))

                IF TratarNulo(crSigOpCdc.verests, 0) != 2
                    loc_nLnQtd = TmpPedra.Qtds - (TmpPedra.QtdEsts - TmpPedra.QtdMins + TmpPedra.QtdReqs + ;
                        TmpPedra.QtdPedcs + TmpPedra.QtdComps - TmpPedra.QtdEmphs)
                    IF loc_nLnQtd > 0
                        REPLACE QtdgReqs WITH loc_nLnQtd
                    ENDIF
                ELSE
                    REPLACE QtdgReqs WITH TmpPedra.Qtds
                ENDIF
                SELECT TmpPedra
            ENDSCAN

            SELECT TmpPedra
            SET ORDER TO GruMat
            GO TOP
            loc_cCgru = TmpPedra.Cgrus
            = THIS.ConsultarTabela("SigCdPro", "crTmpPro", "CPros", ALLTRIM(TmpPedra.CMats))
            loc_cForn   = TratarNulo(crTmpPro.Ifors, "")
            loc_nCitens = 999
            loc_nTotReq = 0

            SCAN
                IF TmpPedra.QtdGreqs <= 0
                    LOOP
                ENDIF

                = THIS.ConsultarTabela("SigCdPro", "crSigCdPro", "CPros", ALLTRIM(TmpPedra.CMats))

                *-- "Do While lnTotReq > 0" (dump 5746-5795) nao transcrito -
                *-- ver nota de escopo no cabecalho deste metodo
                SELECT TmpPedra
            ENDSCAN
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEntradaAutomatica - dump 5816-5979: SO roda quando SigCdPam
    * tem operacao/tipo de entrada antecipada configurados E this_nDbEntPes
    * (DbParam.EntPes) = 1. Consolida GrSigCdNei (peso/material acumulado
    * pelas fases da O.P.) em crSigCdNei/crSigCdNec e crSigMvHst, por DOIS
    * caminhos: destino UNICO configurado na operacao (CrSigCdOpd.GruDests/
    * ConDests) ou destino por NECESSIDADE (CrSigCdNec.EmpDnPs de cada
    * grupo de fases).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarEntradaAutomatica()
        LOCAL loc_lOk, loc_cDopEntAu, loc_cTpOp, loc_cGrupoC, loc_cContaC
        LOCAL loc_nNumEntAu, loc_nTPesoEnt, loc_lGravou, loc_cMat, loc_nQtde, loc_nPeso
        LOCAL loc_cOper, loc_cIds, loc_nEnv, loc_lPrimeiro

        loc_lOk = .T.
        loc_cDopEntAu = PADR(THIS.this_cPamDopEntAus, 20)
        loc_cTpOp     = PADR(THIS.this_cPamTpOpEntAus, 15)

        IF !EMPTY(loc_cDopEntAu) AND !EMPTY(loc_cTpOp) AND THIS.this_nDbEntPes = 1

            IF USED("crSigCdNec")
                *-- crSigCdNec nasce de AbrirCursorTabela() sem indice - os
                *-- dois usados pelos SEEK abaixo sao criados aqui
                SELECT crSigCdNec
                INDEX ON EmpDnPs TAG EmpDnPs
                INDEX ON Dopps + GrupoOs + ContaOs + GrupoDs + ContaDs TAG DopEntAu
            ENDIF

            = THIS.ConsultarTabela("SigCdOpd", "CrSigCdOpd", "Dopps", ALLTRIM(loc_cDopEntAu))

            IF !EMPTY(CrSigCdOpd.GruDests) AND !EMPTY(CrSigCdOpd.ConDests)
                loc_cGrupoC  = CrSigCdOpd.GruOrigs
                loc_cContaC  = CrSigCdOpd.ConOrigs
                loc_cGrupoD  = CrSigCdOpd.GruDests
                loc_cContaD  = CrSigCdOpd.ConDests
                loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))

                IF USED("TmpNensi")
                    USE IN TmpNensi
                ENDIF
                SELECT Cmats, Cdescs, cUnis, TpOps, Nops, Nenvs, SUM(Pesos) AS Pesos, SUM(Qtds) AS Qtds, ;
                        SUM(Peso2s) AS Peso2s FROM GrSigCdNei ;
                    GROUP BY 1, 2, 3, 4, 5, 6 INTO CURSOR TmpNensi

                loc_nTPesoEnt = 0
                loc_lGravou   = .F.

                SELECT TmpNensi
                SCAN
                    loc_lGravou = .T.
                    loc_cMat    = TmpNensi.Cmats

                    = THIS.ConsultarTabela("SigCdPro", "CrSigCdPro", "Cpros", ALLTRIM(loc_cMat))

                    INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, ;
                            EmpDNps, cIdChaves, Peso2s, Nenvs, Nops) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, TmpNensi.Cmats, TmpNensi.cDescs, ;
                            TmpNensi.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, loc_cTpOp, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), TmpNensi.peso2s, ;
                            TmpNensi.Nenvs, TmpNensi.Nops)

                    loc_nTPesoEnt = loc_nTPesoEnt + TmpNensi.Pesos
                    loc_nQtde = TmpNensi.Qtds
                    loc_nPeso = TmpNensi.Peso2s

                    IF CrSigCdOpd.Origems = 1 AND INLIST(CrSigCdOpd.EstOrigs, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstOrigs = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    IF CrSigCdOpd.Destinos = 1 AND INLIST(CrSigCdOpd.EstDests, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstDests = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    SELECT TmpNensi
                ENDSCAN

                IF loc_lGravou
                    loc_cIds = DTOS(DATE()) + TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + THIS.this_cSigKey

                    INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                            Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), loc_cUsuar, ;
                            loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, loc_nTPesoEnt, loc_nNumpe, ;
                            loc_cIds, loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10))
                ENDIF
            ELSE
                IF USED("TmpNensi")
                    USE IN TmpNensi
                ENDIF
                SELECT * FROM GrSigCdNei ORDER BY EmpDnPs, Nops INTO CURSOR TmpNensi

                loc_nTPesoEnt = 0

                SELECT TmpNensi
                SCAN
                    loc_nEnv = TmpNensi.nEnvs

                    = SEEK(TmpNensi.EmpDnPs, "crSigCdNec", "EmpDnPs")

                    loc_cGrupoC = crSigCdNec.GrupoOs
                    loc_cContaC = crSigCdNec.ContaOs
                    loc_cGrupoD = IIF(!EMPTY(CrSigCdOpd.GruDests), CrSigCdOpd.GruDests, crSigCdNec.GrupoDs)
                    loc_cContaD = crSigCdNec.ContaDs

                    loc_lPrimeiro = !SEEK(loc_cDopEntAu + loc_cGrupoC + loc_cContaC + loc_cGrupoD + loc_cContaD, ;
                        "crSigCdNec", "DopEntAu")
                    IF loc_lPrimeiro
                        loc_nNumEntAu = fGerUniqueKey(ALLTRIM(loc_cDopEntAu))
                        loc_cIds = DTOS(DATE()) + TRANSFORM(fGerUniqueKey(DTOS(DATE())), "@L 999999") + ;
                            THIS.this_cSigKey

                        INSERT INTO crSigCdNec (Emps, Dopps, Numps, Datars, Datas, Usuars, Grupoos, Contaos, ;
                                Grupods, Contads, TotPesos, Nops, cIdChaves, EmpDNps, Docus) ;
                            VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATETIME(), DATETIME(), loc_cUsuar, ;
                                loc_cGrupoC, loc_cContaC, loc_cGrupoD, loc_cContaD, loc_nTPesoEnt, loc_nNumpe, ;
                                loc_cIds, loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), TRANSFORM(loc_nNumpe))
                        loc_nTPesoEnt = 0
                    ENDIF

                    loc_nQtde = TmpNensi.Qtds
                    loc_nPeso = TmpNensi.Peso2s
                    loc_cMat  = TmpNensi.cMats
                    loc_nTPesoEnt = loc_nTPesoEnt + TmpNensi.Pesos

                    = THIS.ConsultarTabela("SigCdPro", "CrSigCdPro", "Cpros", ALLTRIM(loc_cMat))

                    INSERT INTO crSigCdNei (Emps, Dopps, Numps, Cmats, Cdescs, cUnis, Pesos, Qtds, TpOps, ;
                            EmpDNps, cIdChaves, nenvs, Peso2s, Nops) ;
                        VALUES (loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, loc_cMat, CrSigCdPro.Dpros, ;
                            CrSigCdPro.Cunis, TmpNensi.Pesos, TmpNensi.Qtds, loc_cTpOp, ;
                            loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 10), fUniqueIds(), loc_nEnv, ;
                            TmpNensi.Peso2s, TmpNensi.Nops)

                    IF CrSigCdOpd.Origems = 1 AND INLIST(CrSigCdOpd.EstOrigs, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstOrigs = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoC, loc_cContaC, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoC + loc_cContaC, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    IF CrSigCdOpd.Destinos = 1 AND INLIST(CrSigCdOpd.EstDests, 1, 2)
                        loc_cOper = IIF(CrSigCdOpd.EstDests = 1, "E", "S")
                        INSERT INTO crSigMvHst (Empos, Emps, Dopes, Numes, Datars, Datas, DtAudits, Grupos, ;
                                Estos, Cpros, Opers, Qtds, cidChaves, empdopnums, empgruests, OriDopNums, ;
                                Seqs, Pesos) ;
                            VALUES (loc_cEmpr, loc_cEmpr, loc_cDopEntAu, loc_nNumEntAu, DATE(), DATE(), ;
                                {}, loc_cGrupoD, loc_cContaD, loc_cMat, loc_cOper, loc_nQtde, " ", ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), ;
                                loc_cEmpr + loc_cGrupoD + loc_cContaD, ;
                                loc_cEmpr + loc_cDopEntAu + STR(loc_nNumEntAu, 6), 0, loc_nPeso)
                        *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    ENDIF
                    SELECT TmpNensi
                ENDSCAN
            ENDIF
        ENDIF

        IF !loc_lOk
            loc_lAbortar = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarMovimentos - dump 5981-6065: numera definitivamente o historico
    * (GravaHis - ja chamado por Processar() antes deste metodo), persiste
    * os 11 cursores de trabalho nas tabelas reais (PersistirCursor) e
    * efetiva com COMMIT - ou desfaz tudo com ROLLBACK em caso de falha.
    *
    * "Select TmpCabec / Scan / Update SigMvCab Set Rnops..." (dump
    * 5991-6000, so roda em ThisForm.Reserva) depende de um cursor TmpCabec
    * que o Click original nao cria - vem do form avo (fora do escopo desta
    * task) e eh protegido por USED() para nao quebrar quando ausente.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GravarMovimentos()
        LOCAL loc_lErro

        loc_lErro = .F.

        IF THIS.this_lReserva AND USED("TmpCabec")
            SELECT TmpCabec
            SCAN
                IF TmpCabec.Flag
                    = THIS.ExecutarSQL("UPDATE SigMvCab SET Rnops = " + FormatarNumeroSQL(loc_nRnop, 0) + ;
                        " WHERE EmpDopNums = " + ;
                        EscaparSQL(TmpCabec.Emps + TmpCabec.Dopes + STR(TmpCabec.Numes, 6)), "", "Update Rnops")
                ENDIF
                SELECT TmpCabec
            ENDSCAN
        ENDIF

        IF !loc_lErro AND !THIS.PersistirCursor("crSigOpPic", "SigOpPic")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvCab", "SigMvCab")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigBxEst", "SigBxEst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvItn", "SigMvItn")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvIts", "SigMvIts")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigOpPii", "SigOpPii")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigInAtz", "SigInAtz")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP(.t., ...) / fRecalculaC(.t.,.f.,.f., ...) de lote:
        *-- omitidos (ver NOTA DE ESCOPO) - nao marcam erro

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * ProcessarModoAutomatico - dump 6081-6458: SO roda quando
    * this_lAutomatico = .T. (chamado por Processar() apos o lote manual ja
    * ter sido commitado). Gera o fluxo de fases/transferencia por LINHA de
    * producao (SigCdLnf) a partir das O.P.s recem-criadas (SigOpPic entre
    * loc_nNopI/loc_nNopF) e grava um SEGUNDO lote (crSigPdMvf/crSigCdNec/
    * crSigCdNei/crSigMvHst), com commit proprio.
    *
    * Estrutura e correcao de defeito IDENTICAS as de SigPrGlpBO.
    * ProcessarModoAutomatico - os dumps legados de SIGPRGLX e SIGPRGLP sao,
    * neste bloco, o MESMO codigo (mesmos comentarios "Tiago"/datas,
    * confirmado linha a linha): a consulta que monta TmpOpi (dump 6147-
    * 6148) NAO traz EmpDopNums nem Citens, mas a consulta de composicao
    * logo abaixo (6159-6160) referencia TmpOpi.empdopnums e TmpOpi.citens
    * - em VFP isso estoura "Variable not found" em runtime. Igual ao
    * SigPrGlpBO, as duas colunas entram como MAX() no SELECT, e NAO no
    * GROUP BY, para nao alterar a granularidade do agrupamento original.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ProcessarModoAutomatico()
        LOCAL loc_lOk, loc_lErro, loc_cSql, loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD
        LOCAL loc_dDtGe, loc_cUsuarLin, loc_nQtAnt, loc_nPsAnt, loc_nTran, loc_nInicio
        LOCAL loc_cIds, loc_cOper, loc_cDpTrf, loc_nNopI, loc_nNopF, loc_nSeqAuto
        LOCAL ARRAY loc_aNensi[1, 18]

        loc_lOk   = .T.
        loc_lErro = .F.

        IF !THIS.ExecutarSQL("Select dopps From SigCdOpd where Autos = 1 ", ;
                "CrSigCdOpd", "CrSigCdOpd - Autos 1")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrSigCdOpd") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Movimento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrSigCdOpd

        IF !THIS.ExecutarSQL("Select Dopps From SigCdOpd Where Autos = 2 ", ;
                "CrTmpOpp", "CrTmpOpp - Autos 2")
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") = 0
            THIS.this_cMensagemErro = "Nenhuma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        IF RECCOUNT("CrTmpOpp") > 1
            THIS.this_cMensagemErro = "Mais de Uma Opera" + CHR(231) + CHR(227) + ;
                "o de Produ" + CHR(231) + CHR(227) + "o definida como autom" + CHR(225) + ;
                "tica de Encerramento!!!"
            RETURN .F.
        ENDIF
        GO TOP IN CrTmpOpp
        loc_cDpTrf = PADR(CrTmpOpp.Dopps, 20)

        IF !THIS.AbrirCursorTabela("crSigPdMvf", "SigPdMvf")
            RETURN .F.
        ENDIF
        SELECT crSigPdMvf
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigCdNec", "SigCdNec")
            RETURN .F.
        ENDIF
        SELECT crSigCdNec
        INDEX ON Grupoos + contaOs + GrupoDs + ContaDs + DTOS(Datas) + STR(nAceites, 10) TAG Gravacao

        IF !THIS.AbrirCursorTabela("crSigCdNei", "SigCdNei")
            RETURN .F.
        ENDIF
        SELECT crSigCdNei
        INDEX ON nTrans TAG nTrans

        IF !THIS.AbrirCursorTabela("crSigMvHst", "SigMvHst")
            RETURN .F.
        ENDIF

        SELECT crSigCdNei
        = AFIELDS(loc_aNensi, "crSigCdNei")
        IF USED("xNensi")
            USE IN xNensi
        ENDIF
        CREATE CURSOR xNensi FROM ARRAY loc_aNensi

        IF !THIS.ExecutarSQL("Select * From SigCdLnf ", "cursor_4c_LinfTmp", "TmpLinf")
            RETURN .F.
        ENDIF
        IF USED("TmpLinF")
            USE IN TmpLinF
        ENDIF
        SELECT * FROM cursor_4c_LinfTmp INTO CURSOR TmpLinF READWRITE
        USE IN cursor_4c_LinfTmp
        SELECT TmpLinF
        INDEX ON Linhas + STR(Ordems, 2) TAG Linhas

        loc_nNopI   = (loc_nNump * 10000) + 1
        loc_nNopF   = (loc_nNump * 10000) + 9999
        loc_nSeqAuto = 1

        *-- ATENCAO - CORRECAO DE DEFEITO DO LEGADO (ver cabecalho deste
        *-- metodo): EmpDopNums/Citens entram via MAX(), fora do GROUP BY.
        loc_cSql = "Select a.Cpros, a.Nops, b.Linhas, b.cUnis, a.EmpdopNops, a.CodTams," + ;
            " MAX(a.EmpDopNums) as EmpDopNums, MAX(a.Citens) as Citens," + ;
            " sum(a.Qtds) as Qtds, Sum(a.Pesos) as Pesos From SigOpPic a, SigCdPro b " + ;
            "Where a.Nops Between " + FormatarNumeroSQL(loc_nNopI, 0) + " And " + ;
            FormatarNumeroSQL(loc_nNopF, 0) + " And a.cpros = b.cpros " + ;
            "Group by a.Cpros, a.Nops, b.Linhas, b.Cunis, a.EmpDopNops, a.CodTams "

        IF !THIS.ExecutarSQL(loc_cSql, "cursor_4c_OpiTmp", "TmpOpi")
            RETURN .F.
        ENDIF
        IF USED("TmpOpi")
            USE IN TmpOpi
        ENDIF
        SELECT * FROM cursor_4c_OpiTmp INTO CURSOR TmpOpi READWRITE
        USE IN cursor_4c_OpiTmp
        SELECT TmpOpi
        INDEX ON Nops TAG Nops
        INDEX ON Linhas + cpros TAG Linha

        SELECT TmpOpi
        SCAN
            loc_cSql = "Select a.Mats, a.Qtds, b.cunis, b.Pesoms, b.Cgrus, b.dpros," + ;
                " c.Fators, b.Varias, d.Mercs " + ;
                "From SigSubMv a, SigCdPro b, SigCdUni c, SigCdGrp d " + ;
                "Where a.empdopnums = " + EscaparSQL(TmpOpi.empdopnums) + ;
                " and a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                " and a.citem2 = " + FormatarNumeroSQL(TmpOpi.citens, 0) + ;
                " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus "

            IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo")
                loc_lOk = .F.
                EXIT
            ENDIF

            IF RECCOUNT("TmpCompo") = 0
                loc_cSql = "Select a.Mats, b.cunis, b.Pesoms, b.Cgrus, b.dpros, c.Fators," + ;
                    " b.Varias, d.Mercs, " + ;
                    "Case When e.Qtds is null Then a.Qtds Else e.Qtds End as Qtds " + ;
                    "From SigPrCpo a inner Join SigCdPro b On a.mats = b.Cpros " + ;
                    "Inner Join SigCdUni c On b.Cunis = c.Cunis " + ;
                    "Inner Join SigCdGrp d On b.Cgrus = d.Cgrus " + ;
                    "Left Join SigSubCp e On a.mats = e.Mats And e.CodTams = " + ;
                    EscaparSQL(TmpOpi.CodTams) + " " + ;
                    "Where a.Cpros = " + EscaparSQL(TmpOpi.Cpros) + ;
                    " and a.mats = b.Cpros and b.Cunis = c.Cunis And b.Cgrus = d.Cgrus"

                IF !THIS.ExecutarSQL(loc_cSql, "TmpCompo", "TmpCompo - padrao")
                    loc_lOk = .F.
                    EXIT
                ENDIF
            ENDIF

            IF USED("xNensi")
                USE IN xNensi
            ENDIF
            CREATE CURSOR xNensi FROM ARRAY loc_aNensi

            SELECT TmpLinF
            IF !SEEK(TmpOpi.Linhas)
                MsgAviso("Linha :" + ALLTRIM(TmpOpi.Linhas) + " do Produto: " + ;
                    ALLTRIM(TmpOpi.cpros) + " nao Cadastrada!!!", "Aten" + CHR(231) + CHR(227) + "o")
                SELECT TmpOpi
                LOOP
            ENDIF
            loc_cGrpO     = PADR(TmpLinF.Grupos, 10)
            loc_cCtaO     = PADR(TmpLinF.Contas, 10)
            loc_dDtGe     = loc_dDtGera + TmpLinf.nDias
            loc_cUsuarLin = PADR(IIF(EMPTY(TmpLinf.Usuars), loc_cUsuar, TmpLinf.Usuars), 10)

            IF DOW(loc_dDtGe) = 7
                loc_dDtGe = loc_dDtGe + 2
            ELSE
                IF DOW(loc_dDtGe) = 1
                    loc_dDtGe = loc_dDtGe + 1
                ENDIF
            ENDIF

            SELECT TmpLinF
            SKIP
            SCAN WHILE TmpLinF.Linhas = TmpOpi.Linhas
                loc_cGrpD = PADR(TmpLinf.Grupos, 10)
                loc_cCtaD = PADR(TmpLinf.Contas, 10)

                SELECT crSigCdNec
                IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + ;
                        STR(TmpLinf.Ordems, 10))
                    APPEND BLANK
                    REPLACE GrupoOs  WITH loc_cGrpO, ;
                            ContaOs  WITH loc_cCtaO, ;
                            GrupoDs  WITH loc_cGrpD, ;
                            ContaDs  WITH loc_cCtaD, ;
                            Datas    WITH loc_dDtGe, ;
                            Dopps    WITH CrSigCdOpd.Dopps, ;
                            nTrans   WITH loc_nSeqAuto, ;
                            Usuars   WITH loc_cUsuarLin, ;
                            nAceites WITH TmpLinf.Ordems ;
                        IN crSigCdNec

                    loc_nSeqAuto = loc_nSeqAuto + 1
                ENDIF

                INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, ;
                        Codpds, Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                    VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, ;
                        TmpOpi.Nops, TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, ;
                        TmpLinf.Ordems, CrSigCdNec.nTrans, loc_cUsuarLin)

                IF !EMPTY(TmpLinf.Cgrus)
                    SELECT TmpCompo
                    SCAN
                        IF Cgrus = TmpLinf.Cgrus
                            IF TmpCompo.Varias = 1 AND TmpOpi.Cpros != THIS.this_cPamOuros
                                loc_nQtAnt = TmpOpi.Pesos
                                loc_nPsAnt = TmpOpi.Pesos
                            ELSE
                                loc_nQtAnt = TmpCompo.Qtds * TmpOpi.Qtds
                                loc_nPsAnt = IIF(TmpCompo.Fators != 0, ;
                                    loc_nQtAnt * Tmpcompo.Fators, TmpCompo.Pesoms * TmpOpi.Qtds)
                            ENDIF
                            INSERT INTO xNensi (Nops, NEnvs, CMats, CDescs, CUnis, CGrus, ;
                                    Qtds, Pesos) ;
                                VALUES (TmpOpi.Nops, TmpOpi.Nops, TmpCompo.Mats, ;
                                    TmpCompo.Dpros, TmpCompo.CUnis, TmpCompo.CGrus, ;
                                    loc_nQtAnt, loc_nPsAnt)
                        ENDIF
                        SELECT TmpCompo
                    ENDSCAN
                ENDIF
                SELECT xNensi
                SCAN
                    SCATTER MEMVAR
                    INSERT INTO crSigCdNei FROM MEMVAR
                    REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                    SELECT xNensi
                ENDSCAN
                SELECT TmpLinF
                loc_cGrpO = TmpLinF.Grupos
                loc_cCtaO = TmpLinF.Contas
                loc_dDtGe = loc_dDtGe + TmpLinf.nDias
                IF DOW(loc_dDtGe) = 7
                    loc_dDtGe = loc_dDtGe + 2
                ELSE
                    IF DOW(loc_dDtGe) = 1
                        loc_dDtGe = loc_dDtGe + 1
                    ENDIF
                ENDIF
            ENDSCAN

            loc_cGrpD = PADR(THIS.this_cPamGruConfs, 10)
            loc_cCtaD = PADR(THIS.this_cPamConConfs, 10)

            SELECT crSigCdNec
            IF !SEEK(loc_cGrpO + loc_cCtaO + loc_cGrpD + loc_cCtaD + DTOS(loc_dDtGe) + STR(99, 10))
                APPEND BLANK
                REPLACE GrupoOs  WITH loc_cGrpO, ;
                        ContaOs  WITH loc_cCtaO, ;
                        GrupoDs  WITH loc_cGrpD, ;
                        ContaDs  WITH loc_cCtaD, ;
                        Datas    WITH loc_dDtGe, ;
                        Dopps    WITH loc_cDpTrf, ;
                        Usuars   WITH loc_cUsuar, ;
                        nTrans   WITH loc_nSeqAuto, ;
                        nAceites WITH 99 ;
                    IN crSigCdNec

                loc_nSeqAuto = loc_nSeqAuto + 1
            ENDIF

            INSERT INTO CrSigPdMvf (Grupoos, Contaos, Grupods, Contads, NOps, NEnvs, Codpds, ;
                    Unids, Pesos, Qtds, Ordems, nTrans, Usuars) ;
                VALUES (loc_cGrpO, loc_cCtaO, loc_cGrpD, loc_cCtaD, TmpOpi.Nops, TmpOpi.Nops, ;
                    TmpOpi.Cpros, TmpOpi.Cunis, TmpOpi.Pesos, TmpOpi.Qtds, TmpLinf.Ordems, ;
                    CrSigCdNec.nTrans, loc_cUsuar)

            SELECT xNensi
            SCAN
                SCATTER MEMVAR
                INSERT INTO crSigCdNei FROM MEMVAR
                REPLACE nTrans WITH CrSigCdNec.nTrans IN crSigCdNei
                SELECT xNensi
            ENDSCAN

            SELECT TmpOpi
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        SELECT crSigCdNec
        INDEX ON DTOS(Datas) + STR(nAceites, 10) TAG Datas
        SCAN
            loc_nTran   = crSigCdNec.nTrans
            loc_nInicio = fGerUniqueKey(ALLTRIM(CrSigCdNec.Dopps) + loc_cEmpr)
            loc_cIds    = DTOS(CrSigCdNec.Datas) + ;
                TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + THIS.this_cSigKey

            REPLACE Emps      WITH loc_cEmpr, ;
                    Numps     WITH loc_nInicio, ;
                    Datars    WITH DATETIME(), ;
                    Nops      WITH loc_nNopI, ;
                    Autos     WITH .T., ;
                    CidChaves WITH loc_cIds, ;
                    EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                IN crSigCdNec

            SELECT crSigPdMvf
            = SEEK(loc_nTran)
            SCAN WHILE crSigPdMvf.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        Usuars    WITH CrSigCdNec.Usuars, ;
                        Datars    WITH DATETIME(), ;
                        Datas     WITH CrSigCdNec.Datas, ;
                        CidChaves WITH DTOS(CrSigCdNec.Datas) + ;
                            TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                            THIS.this_cSigKey, ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigPdMvf
                SELECT crSigPdMvf
            ENDSCAN

            loc_cSql = "Select * From SigCdOpd Where Dopps = " + ;
                EscaparSQL(ALLTRIM(CrSigCdNec.Dopps))
            IF !THIS.ExecutarSQL(loc_cSql, "CrSigCdOpd", "CrSigCdOpd - fase")
                loc_lOk = .F.
                EXIT
            ENDIF

            SELECT crSigCdNei
            = SEEK(loc_nTran)
            SCAN WHILE crSigCdNei.nTrans = loc_nTran
                REPLACE Emps      WITH loc_cEmpr, ;
                        Dopps     WITH CrSigCdNec.Dopps, ;
                        Numps     WITH loc_nInicio, ;
                        CidChaves WITH fUniqueIds(), ;
                        EmpDnPs   WITH loc_cEmpr + CrSigCdNec.Dopps + STR(loc_nInicio, 10) ;
                    IN crSigCdNei

                loc_cSql = "Select Cgrus From SigCdPro Where Cpros = " + ;
                    EscaparSQL(ALLTRIM(CrSigCdNei.Cmats))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalPro", "LocalPro")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                loc_cSql = "Select cEstoqs From SigCdGrp Where Cgrus = " + ;
                    EscaparSQL(ALLTRIM(LocalPro.Cgrus))
                IF !THIS.ExecutarSQL(loc_cSql, "LocalGru", "LocalGru")
                    loc_lOk = .F.
                    EXIT
                ENDIF

                IF INLIST(crSigCdOpd.EstOrigs, 1, 2) AND (crSigCdOpd.BxOEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper = IIF(crSigCdOpd.EstOrigs = 1, "E", "S")
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupoos, ;
                            CrSigCdNec.Contaos, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupoos + CrSigCdNec.Contaos, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)
                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 2) ;
                        AND (LocalGru.CEstoqs = 1)
                    loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNei.Numps, CrSigCdNec.Datas, ;
                            CrSigCdNei.CMats, loc_cEmpr, CrSigCdNei.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, ;
                            DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNei.Numps, 6), 0)
                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                ENDIF

                SELECT crSigCdNei
            ENDSCAN

            IF !loc_lOk
                EXIT
            ENDIF

            IF INLIST(crSigCdOpd.EstDests, 1, 2) AND (crSigCdOpd.BxDEsts = 1)
                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
                SELECT DISTINCT b.Nops, b.Cpros, b.Qtds ;
                    FROM crSigCdNei a, TmpOpi b ;
                    WHERE a.nTrans = m.loc_nTran AND a.Nops = b.Nops ;
                    INTO CURSOR TmpHis

                loc_cOper = IIF(crSigCdOpd.EstDests = 1, "E", "S")

                SELECT TmpHis
                SCAN
                    loc_cIds = DTOS(CrSigCdNec.Datas) + loc_cOper + ;
                        TRANSFORM(fGerUniqueKey(DTOS(CrSigCdNec.Datas)), "@L 999999") + ;
                        THIS.this_cSigKey

                    INSERT INTO crSigMvHst (Usuars, Datars, Emps, Opers, Dopes, Numes, Datas, ;
                            CPros, Empos, Qtds, Grupos, Estos, cIdChaves, EmpDopNums, ;
                            EmpGruEsts, DtAlts, OriDopNums, Seqs) ;
                        VALUES (CrSigCdNec.Usuars, DATETIME(), loc_cEmpr, loc_cOper, ;
                            CrSigCdNec.Dopps, CrSigCdNec.Numps, CrSigCdNec.Datas, ;
                            TmpHis.CPros, loc_cEmpr, TmpHis.Qtds, CrSigCdNec.Grupods, ;
                            CrSigCdNec.Contads, loc_cIds, ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), ;
                            loc_cEmpr + CrSigCdNec.Grupods + CrSigCdNec.Contads, DATETIME(), ;
                            loc_cEmpr + CrSigCdNec.Dopps + STR(CrSigCdNec.Numps, 6), 0)
                    *-- fRecalculaP/fRecalculaC: omitido (ver NOTA DE ESCOPO)
                    SELECT TmpHis
                ENDSCAN
            ENDIF

            SELECT crSigCdNec
        ENDSCAN

        IF !loc_lOk
            = SQLROLLBACK(gnConnHandle)
            RETURN .F.
        ENDIF

        SELECT crSigMvHst
        GO TOP

        SELECT TmpOpi
        SCAN
            loc_cSql = "Select CidChaves From SigCdNec Where EmpDnPs = " + ;
                EscaparSQL(TmpOpi.EmpDopNops)
            IF !THIS.ExecutarSQL(loc_cSql, "LocalNens", "Update - crSigCdNec")
                loc_lErro = .T.
                EXIT
            ENDIF

            SELECT LocalNens
            SCAN
                loc_cSql = "Update SigCdNec Set ChkSubn = 1 Where cidChaves = " + ;
                    EscaparSQL(LocalNens.CidChaves)
                IF !THIS.ExecutarSQL(loc_cSql, "", "Update - crSigCdNec 1")
                    loc_lErro = .T.
                    EXIT
                ENDIF
                SELECT LocalNens
            ENDSCAN
            IF loc_lErro
                EXIT
            ENDIF
            SELECT TmpOpi
        ENDSCAN

        IF !loc_lErro AND !THIS.PersistirCursor("crSigPdMvf", "SigPdMvf")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNec", "SigCdNec")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigMvHst", "SigMvHst")
            loc_lErro = .T.
        ENDIF
        IF !loc_lErro AND !THIS.PersistirCursor("crSigCdNei", "SigCdNei")
            loc_lErro = .T.
        ENDIF

        *-- fRecalculaP / fRecalculaC de lote: omitidos (ver NOTA DE ESCOPO)

        IF !loc_lErro
            IF SQLCOMMIT(gnConnHandle) < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "(Commit) " + CapturarErroSQL()
                loc_lErro = .T.
            ENDIF
        ENDIF

        IF loc_lErro
            = SQLROLLBACK(gnConnHandle)
        ENDIF

        RETURN !loc_lErro
    ENDFUNC

ENDDEFINE
