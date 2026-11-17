*==============================================================================
* SIGOPPENBO.prg - Business Object para Pendencias Em Subniveis (SIGOPPEN)
* Tabela principal: SigMvCab (cabecalho da movimentacao em aberto)
* Tabelas relacionadas: SigMvItn, SigCdOpe, SigCdEmp, SigCdPro, SigPrTrp,
*                        SigOpCdd, SigClJob, SigBxEst, SigSubMv
*==============================================================================

DEFINE CLASS SIGOPPENBO AS BusinessBase

    *-- Identificacao da movimentacao em aberto (SigMvCab) -------------------
    this_cEmps          = ""    && char(3)  - Empresa da movimentacao
    this_cDopes         = ""    && char(20) - Codigo da operacao (Dopes)
    this_nNumes         = 0     && numeric(6,0) - Numero sequencial da movimentacao
    this_cEmpDopNums    = ""    && char(29) - Chave combinada Emps+Dopes+Str(Numes,6)
    this_cCidChaves     = ""    && char(20) - Chave unica (PK de SigMvCab)
    this_cMascNum       = ""    && char(10) - Numero mascarado para exibicao em tela
    this_dDatas         = {}    && datetime - Data da movimentacao
    this_cNotas         = ""    && char(6)  - Numero da nota fiscal (legado)
    this_cNumeroNota    = ""    && char(10) - Numero da nota fiscal (NF-e)
    this_cPedidoWeb     = ""    && char(50) - Identificacao do pedido Web
    this_cIdTransp      = ""    && char(15) - Identificacao da transportadora
    this_cObsCabMovs    = ""    && char(40) - Observacao do cabecalho da movimentacao
    this_cObses         = ""    && text     - Observacoes gerais (memo)
    this_cPStatus       = ""    && char(1)  - Status de aprovacao da movimentacao
    this_cStatusAprRep  = ""    && char(1)  - Status aplicado na ultima Aprovacao/Reprovacao
    this_lChkSubn       = .F.   && bit      - Indica se ja foi baixada em subniveis
    this_lChkBxParcs    = .F.   && bit      - Indica baixa parcial permitida
    this_lChkQtdss      = .F.   && bit      - Indica conferencia de quantidades habilitada
    this_cGrupoOs       = ""    && char(10) - Grupo de origem
    this_cContaOs       = ""    && char(10) - Conta de origem
    this_cGrupoDs       = ""    && char(10) - Grupo de destino
    this_cContaDs       = ""    && char(10) - Conta de destino
    this_cGrResps       = ""    && char(10) - Grupo responsavel
    this_cVends         = ""    && char(10) - Responsavel/Vendedor
    this_dPrazoEnts     = {}    && datetime - Prazo de entrega
    this_nValOs         = 0     && numeric(11,2) - Valor da operacao de origem

    *-- Configuracao da operacao vigente (SigCdOpe / SigOpCdd) --------------
    this_cDopesAtual    = ""    && char(20) - Operacao vigente sendo tratada
    this_nDopesNivel    = 0     && numeric  - Nivel da operacao (Nivels)
    this_cOpera         = ""    && char(1)  - Tipo de operacao (Opers)
    this_nPuxaOrigem    = 0     && numeric  - ConOSubs: forma de puxar origem
    this_nPuxaDestino   = 0     && numeric  - ConDSubs: forma de puxar destino
    this_cOpePad        = ""    && char(20) - Operacao padrao associada (OpePads)
    this_cOpePadC       = ""    && char(20) - Operacao padrao de componentes (OpePadcs)
    this_lBaixaSubN     = .F.   && bit      - BaixaSns: baixa automatica em subniveis
    this_lBxParc        = .F.   && bit      - BxParcials: permite baixa parcial
    this_lBxAutos       = .F.   && bit      - BxAutos: baixa automatica
    this_cCarOpCr       = ""    && char(1)  - Opcrs: tipo de carga de operacao credito
    this_nMarcaSubns    = 0     && numeric  - MarcaSubns: marca subniveis ao localizar
    this_nCupFis        = 0     && numeric(1,0) - CupFis: tipo de cupom fiscal
    this_nDigItens      = 0     && numeric  - DigItens: permite digitar itens manualmente
    this_nVars          = 0     && numeric(9,4) - Vars: variacao percentual da operacao
    this_cCfos          = ""    && char     - Cfos: codigo fiscal da operacao
    this_nNDopes        = 0     && numeric  - nDopes: nivel numerico da operacao
    this_nParcs         = 0     && numeric  - parcs: quantidade de parcelas
    this_cCMoes         = ""    && char(3)  - cMoes: moeda da operacao
    this_nNDdVals       = 0     && numeric  - nDdVals: dias de vencimento padrao
    this_lValpres       = .F.   && bit      - Valpres: valores pre-definidos
    this_cCadprods      = ""    && char     - cadprods: cadastra produto na operacao

    *-- Filtros e parametros de tela (Init/Carregar do legado) --------------
    this_nMeses         = 0     && numeric  - Qtd. de meses do filtro de periodo
    this_dAntValue      = {}    && date     - Valor anterior do filtro de meses
    this_lLibPend       = .F.   && logical  - Libera visualizacao de subniveis bloqueados
    this_lChkPends      = .F.   && logical  - Filtra apenas pendencias marcadas
    this_lDdBloqueado   = .F.   && logical  - Indica filtro de datas bloqueado
    this_nNfServicos    = 0     && numeric  - Tipo de nota fiscal de servicos
    this_lBuscProd      = .F.   && logical  - Indica busca restrita por produto (pbusprod)
    this_lSelecStatus   = .F.   && logical  - Indica que o status foi selecionado no painel
    this_nItemMov       = 0     && numeric  - Item de movimentacao em edicao (ItemMov)
    this_cCfgTitOrigem      = "" && char   - Titulo configurado para "Origem"
    this_cCfgTitDestino     = "" && char   - Titulo configurado para "Destino"
    this_cCfgTitVendedor    = "" && char   - Titulo configurado para "Vendedor"
    this_cCfgTitResponsavel = "" && char   - Titulo configurado para "Responsavel"
    this_cCfgTitJob         = "" && char   - Titulo configurado para "Job"
    this_cCfgTitListaVends  = "" && char   - Titulo configurado para lista de vendedores
    this_cCodigo        = ""    && char    - Codigo digitado no filtro "Procura"
    this_cDoc           = ""    && char(6) - Documento digitado no filtro "Documento"
    this_cLocPed        = ""    && char    - Pedido/Localizacao digitada no filtro
    this_cCpros         = ""    && char(10)- Produto filtrado na pesquisa
    this_cIdTranspFiltro= ""    && char    - Transportadora filtrada na pesquisa
    this_lLiberaConsulta= .F.   && logical - Autorizacao para liberar consulta de subniveis

    *-- Itens da movimentacao (crTpmMvItn / SigMvItn) ------------------------
    this_nCItem         = 0     && numeric - Contador de itens no processo de carga
    this_nQtds          = 0     && numeric - Quantidade do item corrente
    this_nQtdsP         = 0     && numeric - Quantidade original do item (antes de ajuste)
    this_nValCars       = 0     && numeric - Valor carregado do item corrente
    this_nTotCar        = 0     && numeric - Total carregado (rateio de frete/despesas)
    this_nTotite        = 0     && numeric - Total de itens apos agrupamento

    *-- Configuracao de status de gravacao (SigOpCdd.StsGrvs/GrvAutos) ------
    this_cStsGrvs       = ""    && char(3) - pos1=Aprovado pos2=Reprovado pos3=Cancelado
    this_lGrvAutos      = .F.   && bit - fecha a tela automaticamente apos gravar o status

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado

        loc_lResultado = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "EmpDopNums"

            THIS.this_nMeses  = 0
            THIS.this_dAntValue = DATE()

            loc_lResultado = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar SIGOPPENBO: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna a chave usada nos UPDATE/auditoria (EmpDopNums,
    * o this_cCampoChave configurado no Init). char(29) posicional (Emps+Dopes+
    * Str(Numes,6)) lido direto da coluna - ALLTRIM na chave INTEIRA eh inofensivo
    * (char no SQL Server compara com blank-padding ANSI); regra #42 so proibe
    * ALLTRIM nas PARTES internas de uma montagem manual.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos de SigMvCab (cabecalho da movimentacao
    * em aberto) do cursor informado para as propriedades do BO.
    * this_cStatusAprRep (status aplicado na ultima Aprovacao/Reprovacao) e
    * this_lChkQtdss (ChkQtdss) NAO sao colunas de SigMvCab - o primeiro eh
    * variavel de trabalho do form, o segundo vem da config da operacao em
    * SigCdOpe - por isso ficam fora deste mapeamento.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cEmps        = ALLTRIM(TratarNulo(Emps,       "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(Dopes,      "C"))
            THIS.this_nNumes       = TratarNulo(Numes,              "N")
            THIS.this_cEmpDopNums  = ALLTRIM(TratarNulo(EmpDopNums, "C"))
            THIS.this_cCidChaves   = ALLTRIM(TratarNulo(CidChaves,  "C"))
            THIS.this_cMascNum     = ALLTRIM(TratarNulo(MascNum,    "C"))
            THIS.this_dDatas       = ConverterParaData(TratarNulo(Datas, "D"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(Notas,       "C"))
            THIS.this_cNumeroNota  = ALLTRIM(TratarNulo(NumeroNota,  "C"))
            THIS.this_cPedidoWeb   = ALLTRIM(TratarNulo(PedidoWeb,   "C"))
            THIS.this_cIdTransp    = ALLTRIM(TratarNulo(IdTransp,    "C"))
            THIS.this_cObsCabMovs  = ALLTRIM(TratarNulo(ObsCabMovs,  "C"))
            THIS.this_cObses       = TratarNulo(Obses, "C")
            THIS.this_cPStatus     = ALLTRIM(TratarNulo(PStatus,     "C"))
            THIS.this_lChkSubn     = ConverterParaLogico(ChkSubn)
            THIS.this_lChkBxParcs  = ConverterParaLogico(ChkBxParcs)
            THIS.this_cGrupoOs     = ALLTRIM(TratarNulo(GrupoOs,     "C"))
            THIS.this_cContaOs     = ALLTRIM(TratarNulo(ContaOs,     "C"))
            THIS.this_cGrupoDs     = ALLTRIM(TratarNulo(GrupoDs,     "C"))
            THIS.this_cContaDs     = ALLTRIM(TratarNulo(ContaDs,     "C"))
            THIS.this_cGrResps     = ALLTRIM(TratarNulo(GrResps,     "C"))
            THIS.this_cVends       = ALLTRIM(TratarNulo(Vends,       "C"))
            THIS.this_dPrazoEnts   = ConverterParaData(TratarNulo(PrazoEnts, "D"))
            THIS.this_nValOs       = TratarNulo(ValOs, "N")

            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Mantem o comportamento padrao herdado de BusinessBase (recusa a
    * operacao). Conferido no codigo fonte legado (SIGOPPEN_form_codigo_fonte.txt)
    * e no comportamento.json: a tela so aprova/reprova/cancela/baixa movimentos
    * EM ABERTO que ja existem em SigMvCab (varios "Update SigMvCab Set ...") -
    * em nenhum ponto o legado faz "Insert Into SigMvCab". Sobrescrever Inserir()
    * aqui exigiria inventar valores para as ~140 colunas NOT NULL de SigMvCab
    * que esta tela nunca grava, violando o PILAR 2 (schema identico) e o
    * PILAR 1 (a tela nao cria movimentacao nova).
    *==========================================================================

    *==========================================================================
    * Atualizar - UPDATE SigMvCab com os campos que as acoes de Aprovar/
    * Reprovar/Cancelar/Baixar Subnivel do legado alteram (Cnt_Status.
    * Commandgroup1.Click Command1/2/3 e o fluxo de SubNiveis), consolidados
    * num unico UPDATE pela chave EmpDopNums.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_lContinuar, loc_cSQL, loc_cChave, loc_oErro
        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_cChave = THIS.ObterChavePrimaria()

            IF EMPTY(loc_cChave)
                MsgErro("Chave do movimento (EmpDopNums) n" + CHR(227) + "o definida " + ;
                        "para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                loc_cSQL = "UPDATE SigMvCab SET " + ;
                           "Usuals = "     + EscaparSQL(PADR(gc_4c_UsuarioLogado, 10)) + ", " + ;
                           "DtAlts = GETDATE(), " + ;
                           "Obses = "      + EscaparSQL(THIS.this_cObses) + ", " + ;
                           "pStatus = "    + EscaparSQL(PADR(THIS.this_cPStatus, 1)) + ", " + ;
                           "ChkSubn = "    + IIF(THIS.this_lChkSubn, "1", "0") + ", " + ;
                           "ChkBxParcs = " + IIF(THIS.this_lChkBxParcs, "1", "0") + ", " + ;
                           "DtBaixas = "   + IIF(THIS.this_lChkSubn, "GETDATE()", "NULL") + " " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cChave)

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd") >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Falha ao atualizar a pend" + CHR(234) + "ncia em subn" + ;
                            CHR(237) + "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Carrega a worklist de pendencias em subniveis (Page1/
    * grd_4c_Dados) a partir de SigMvCab. Equivalente REDUZIDO do metodo
    * "Carregar" do legado (SIGOPPEN_form_codigo_fonte.txt, PROCEDURE
    * carregar, ~650 linhas).
    *
    * ESCOPO DELIBERADAMENTE REDUZIDO (documentado, NAO omitido em
    * silencio - REGRA FUNDAMENTAL do CLAUDE.md): o "Carregar" legado so
    * roda dentro de um dialogo FILHO aberto por uma tela de movimentacao
    * especifica ("Do Form SigOpPen With ThisForm, ..."), que fixa a
    * variavel de modulo TprMvCab (cabecalho da movimentacao do
    * CHAMADOR) e carrega quatro cursores de configuracao POR OPERACAO
    * (crSigCdOpe/CrSigOpCdc/CrSigOpCdd/CrSigOpCdI) antes de montar a
    * consulta - sao eles que decidem, operacao por operacao, qual conta
    * vale como "origem"/"destino" (_PuxaOrigem/_PuxaDestino), quais
    * status ficam visiveis (StsSubs), o filtro de acesso por empresa
    * (fAcessoEmpresa) e o agrupamento por nivel de subnivel (SigOpCsn).
    * Esta task expoe FormSIGOPPEN como tela INDEPENDENTE no menu
    * (popMovimentos - "Pendencias em Subniveis"), sem nenhum form
    * chamador: TprMvCab e crSigCdOpe NUNCA existem neste caminho, e
    * fabricar os dois so para preencher o metodo seria inventar regra
    * de negocio (tambem PROIBIDO pelo CLAUDE.md).
    *
    * O que fica, fiel ao legado e sem depender do contexto ausente: a
    * condicao-base de pendencia - "ChkSubn = 0" - eh, em TODA variante
    * do WHERE do legado, o filtro que sempre aparece (Iif(crSigCdOpe.
    * Subns = 1,[a.ChkSubn = ?llsubnt And ],...) com llsubnt = .F." -
    * aqui aplicada a TODAS as operacoes de uma vez, no lugar de uma
    * unica operacao escolhida pelo form chamador. Origem/Destino usam
    * Grupo+Conta diretos de SigMvCab (sem o desvio _PuxaOrigem/
    * _PuxaDestino, que depende de configuracao por operacao) e a
    * descricao da conta vem de SigCdCli.Rclis - mesma tabela/coluna que
    * o legado consulta por CrEest.ContaOs/contads (dump, linha ~3480).
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_cFiltro, loc_oErro
        loc_lSucesso = .F.
        loc_cFiltro  = TratarNulo(par_cFiltro, "C")

        TRY
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Dopes, a.Numes, a.MascNum, a.Datas, a.TpFats, " + ;
                       "RTRIM(a.GrupoOs) + '/' + RTRIM(a.ContaOs) AS Origem, " + ;
                       "RTRIM(a.GrupoDs) + '/' + RTRIM(a.ContaDs) AS Destino, " + ;
                       "a.Valos, a.Notas, a.ChkSubn AS ChkSubN, " + ;
                       "CONVERT(VARCHAR(8000), a.Obses) AS Obss, " + ;
                       "ISNULL(co.Rclis, '') AS DescsO, ISNULL(cd.Rclis, '') AS DescsD, " + ;
                       "LEFT(a.CidChaves, 10) AS cIdChaves, a.Usuars, a.EmpDs, a.pStatus, " + ;
                       "a.PrazoEnts AS DtEnts, a.ObsCabMovs, a.Jobs, a.PedidoWeb, " + ;
                       "a.IDEntrega, a.ChaveNota, a.IDTransp, a.NumeroNota, a.EmpRet " + ;
                       "FROM SigMvCab a " + ;
                       "LEFT JOIN SigCdCli co ON co.Iclis = a.ContaOs " + ;
                       "LEFT JOIN SigCdCli cd ON cd.Iclis = a.ContaDs " + ;
                       "WHERE a.ChkSubn = 0"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " AND (" + loc_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Datas, a.Emps, a.Dopes, a.Numes"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp") >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    ZAP
                    IF USED("cursor_4c_DadosTmp") AND RECCOUNT("cursor_4c_DadosTmp") > 0
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                    ENDIF
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao buscar pend" + CHR(234) + "ncias em subn" + CHR(237) + ;
                        "veis." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarConfigOperacao - Le StsGrvs/GrvAutos de SigOpCdd para a operacao
    * informada. StsGrvs eh char(3) posicional: pos1 = status gravado ao
    * Aprovar, pos2 = status gravado ao Reprovar, pos3 = status gravado ao
    * Cancelar (legado: Cnt_Status.Commandgroup1.Command1/2/3.Click -
    * Substr(crSigOpCdd.StsGrvs, 1|2|3, 1)). Usado pelo form antes de montar
    * o UPDATE de aprovacao/reprovacao/cancelamento.
    *==========================================================================
    PROCEDURE CarregarConfigOperacao(par_cDopes)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            THIS.this_cStsGrvs  = ""
            THIS.this_lGrvAutos = .F.

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

            loc_cSQL = "SELECT StsGrvs, GrvAutos FROM SigOpCdd " + ;
                       "WHERE Dopes = " + EscaparSQL(PADR(par_cDopes, 20))

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CfgOpe") >= 0
                IF USED("cursor_4c_CfgOpe") AND RECCOUNT("cursor_4c_CfgOpe") > 0
                    SELECT cursor_4c_CfgOpe
                    GO TOP
                    THIS.this_cStsGrvs  = PADR(TratarNulo(StsGrvs, "C"), 3)
                    THIS.this_lGrvAutos = (TratarNulo(GrvAutos, "N") = 1)
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Configura" + CHR(231) + CHR(227) + "o da opera" + CHR(231) + ;
                            CHR(227) + "o " + ALLTRIM(par_cDopes) + " n" + CHR(227) + ;
                            "o encontrada em SigOpCdd.", "Erro")
                ENDIF
            ELSE
                MsgErro("Falha ao carregar a configura" + CHR(231) + CHR(227) + "o da " + ;
                        "opera" + CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_CfgOpe")
                USE IN cursor_4c_CfgOpe
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro SIGOPPENBO.CarregarConfigOperacao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
