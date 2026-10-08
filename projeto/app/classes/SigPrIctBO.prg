*============================================================================
* SigPrIctBO.prg - Business Object para Integracao Contabil
*
* Form legado: SIGPRICT (form generico, OPERACIONAL - sem CRUD de registro)
* Processo em lote: concilia o movimento financeiro (SigMvCcr) do periodo
* informado contra o plano de contas (SigCdGcr/SigCdCli), monta um cursor de
* lancamentos contabeis (MovAux no legado) e grava arquivo(s) texto (CTPV*)
* no diretorio configurado em SigCdPam.DirContabv - um arquivo por empresa.
*
* Tabelas/cursores lidos pelo processamento (Processamento do legado):
*   SigMvCcr   (movimento de conta corrente do periodo)
*   SigCdGcr   (grupos de conta corrente - contabilizavel/conta contabil)
*   SigCdCli   (contas/clientes - conta contabil, razao social, CPF)
*   SigCdEmp   (empresas - Cemps/Razas, cabecalho do relatorio)
*   SigCdPam   (parametros: DirContabv, GrupoPags, GrupoRecs, MoedaCheqs)
*   SigCdPac   (parametros: CfgHisICs - config. do historico do lancamento)
*   SigCqChm   (lotes de cheques)
*   SigCdPit   (titulos pagos/recebidos no periodo)
*   SigMvPar/SigOpFp/SigCdFrm (forma de pagamento - numero do cheque)
*   SigCdEsp   (especies de nota fiscal - provisao)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
* Completado em: Fase 2 - carga dos parametros do sistema e logica real do
*                Processamento/Gravar legado (geracao do arquivo contabil)
*
* NOTA DE ARQUITETURA - Inserir()/Atualizar()/ExecutarExclusao():
* Este processo NAO grava um registro em tabela alguma do SQL Server - ele
* monta um cursor local de lancamentos e grava arquivo(s) de TEXTO (formato
* SDF) no diretorio contabil configurado em SigCdPam.DirContabv, para
* importacao em sistema contabil externo. Por isso nao ha "tabela principal"
* nem "campo chave" de persistencia (this_cTabela/this_cCampoChave ficam
* vazios) e os metodos Inserir()/Atualizar()/ExecutarExclusao() de
* BusinessBase NAO sao sobrescritos - o comportamento padrao herdado (recusar
* a operacao) ja eh o correto, porque o form nunca chama Salvar()/Excluir();
* ele chama os metodos proprios de processamento (Fase 2) diretamente.
*
* NOTA DE FIDELIDADE (regra #17 - transcrever, nunca reescrever):
* O legado suporta DOIS drivers (DBF local "foxpro" e SQL Server, testados
* via Thisform.poDataMgr.GetDriver()). O sistema novo so conecta via SQL
* Server (gnConnHandle), entao somente o ramo "Else" (SQL Server) de cada
* Do Case/If lcConexao='foxpro' do Processamento legado foi portado; o ramo
* "foxpro" (que usa USE/SEEK direto em .DBF) e as colunas auxiliares
* exclusivas dele (indice VOpers local, Order('crSigMvCcr'), etc.) nao se
* aplicam e foram omitidas.
*
* NOTA DE FIDELIDADE - campo EmpCont do cursor MovAux:
* No fonte original (SIGPRICT.Procedure processamento, bloco comentado com
* "*!*" e assinado "BRUNO"), a definicao de m.EmpCont (a partir de
* crSigCdEmp) esta DESATIVADA - o Gather Memvar nunca encontra uma memvar
* m.EmpCont e o campo fica em branco em TODOS os lancamentos gerados. Isso
* foi preservado literalmente (nao e bug deste BO, e o comportamento real
* do legado): na pratica MovAux inteiro pertence a um unico grupo EmpCont
* (vazio), e o Gravar() legado (aqui GravarArquivosContabeis) gera um UNICO
* arquivo CTPV<seq>. (extensao vazia) por execucao, nao "um por empresa"
* como a doc do sistema sugere. A carga de cursor_4c_Empresas foi mantida
* (SELECT Cemps FROM SigCdEmp) so para preservar o mesmo ponto de falha de
* conexao que o legado tem, ainda que o resultado nao seja mais consultado.
*============================================================================

DEFINE CLASS SigPrIctBO AS BusinessBase

    *==========================================================================
    * Propriedades - periodo de processamento (Get_DataI/Get_DataF do form
    * legado - unicos campos digitaveis da tela).
    *==========================================================================
    this_dDataI = {}    && date - Data Inicial do periodo (Thisform.Get_Datai.Value)
    this_dDataF = {}    && date - Data Final do periodo (Thisform.Get_Dataf.Value)

    *==========================================================================
    * Propriedades - parametros do sistema (SigCdPam/SigCdPac), carregados no
    * inicio do processamento (equivalente ao SqlExecute(crSigCdPam)/
    * SqlExecute(crSigCdPac) do Init legado) e usados durante toda a
    * conciliacao do movimento.
    *==========================================================================
    this_cDirContabv         = ""   && char - Diretorio de destino dos arquivos contabeis (SigCdPam.DirContabv)
    this_cGrupoPagamentos    = ""   && char - Grupo de contas de Pagamentos/contas transitorias (SigCdPam.GrupoPags)
    this_cGrupoRecebimentos  = ""   && char - Grupo de contas de Recebimentos/contas transitorias (SigCdPam.GrupoRecs)
    this_cMoedaCheque        = ""   && char - Moeda de referencia para conversao de cheques (SigCdPam.MoedaCheqs)
    this_nConfigHistorico    = 0    && numeric - Configuracao do historico do lancamento contabil (SigCdPac.CfgHisICs)

    *==========================================================================
    * Propriedades - resultado do ultimo processamento, usadas pelo form para
    * decidir a mensagem final e habilitar o grupo de botoes de Impressao/
    * Visualizacao/Encerrar (equivalente ao "Select SemConta / Go Top /
    * If Not Eof()" do final do Processamento legado).
    *==========================================================================
    this_lPossuiInconsistencia  = .F.   && .T. quando o cursor de contas sem configuracao (SemConta) tem registros
    this_nTotalInconsistencias  = 0     && quantidade de registros no cursor de inconsistencias
    this_lPossuiMovimento       = .F.   && .T. quando existe movimento contabilizavel no periodo (cursor MovAux)
    this_nTotalRegistrosGerados = 0     && quantidade de lancamentos gerados no cursor de movimento contabil
    this_lPossuiDiferenca       = .F.   && .T. quando alguma Transacaos ficou com Debs <> Creds (cursor diferenca)
    this_nTotalDiferencas       = 0     && quantidade de lancamentos envolvidos em transacoes desbalanceadas

    *==========================================================================
    * Sem tabela/chave de persistencia - ver nota de arquitetura no cabecalho
    * do arquivo (processo gera arquivo texto, nao grava registro em tabela).
    *==========================================================================
    this_cTabela     = ""
    this_cCampoChave = ""

    *==========================================================================
    * Propriedades - LINHA CORRENTE de um dos cursores de resultado, carregada
    * por CarregarDoCursor(). O FormSigPrIct usa isso para ler a linha que o
    * usuario selecionou na grade (lancamento contabil / inconsistencia) sem
    * depender do alias corrente do VFP, e ObterChavePrimaria() monta a chave
    * de auditoria a partir delas.
    *
    * Os nomes espelham as colunas dos cursores (regra de naming: preservar o
    * sufixo "s" do legado). ATENCAO ao TIPO: no cursor de lancamentos (MovAux
    * do legado) Debs/Creds/Valor sao CARACTERE C(12) - sao o campo ja
    * formatado para o arquivo SDF (centavos, sem separador), NAO numeros;
    * converter para numerico aqui mudaria o que vai para o arquivo contabil.
    *==========================================================================
    this_cAnoFis     = ""   && char(4)  - Ano fiscal do lancamento
    this_cDatas      = ""   && char(8)  - Data do lancamento no formato do arquivo contabil
    this_cContas     = ""   && char(9)  - Conta contabil do lancamento
    this_cDebs       = ""   && char(12) - Valor a DEBITO ja formatado para o arquivo (NAO numerico)
    this_cCreds      = ""   && char(12) - Valor a CREDITO ja formatado para o arquivo (NAO numerico)
    this_cDocto      = ""   && char(10) - Documento de origem
    this_cHists      = ""   && char(70) - Historico do lancamento
    this_cEmpCont    = ""   && char(3)  - Empresa contabil (grupo do arquivo gerado)
    this_cNumSeq     = ""   && char(6)  - Numero sequencial do lancamento
    this_cNums       = ""   && char(6)  - Numero do movimento
    this_cLams       = ""   && char(6)  - Numero do lancamento
    this_dData       = {}   && date     - Data do lancamento (coluna D do cursor)
    this_cValor      = ""   && char(12) - Valor do lancamento ja formatado (NAO numerico)
    this_cCecus      = ""   && char(3)  - Centro de custo
    this_cEmps       = ""   && char(3)  - Empresa do movimento de origem
    this_cTransacaos = ""   && char(10) - Transacao que amarra debito e credito (usada em VerificarDiferencas)
    this_cCpfs       = ""   && char(20) - CPF/CNPJ da conta
    this_cIClis      = ""   && char(10) - Codigo da conta/cliente
    this_cRazaos     = ""   && char(50) - Razao social da conta/cliente
    this_cCheque     = ""   && char(20) - Numero do cheque, quando o lancamento vem de lote de cheques

    *==========================================================================
    * Propriedades exclusivas do cursor de INCONSISTENCIAS (SemConta do
    * legado): la a coluna de data chama-se DataS e eh do tipo D, enquanto no
    * cursor de lancamentos Datas eh C(8). Os dois nomes colidem para o VFP
    * (comparacao de nome de campo eh case-insensitive), por isso
    * CarregarDoCursor() decide pelo VARTYPE da coluna, nunca pelo nome.
    *==========================================================================
    this_dDataS = {}   && date       - Data do movimento sem conta configurada
    this_nValors = 0   && numeric    - Valor do movimento sem conta configurada
    this_cOcors  = ""  && char(40)   - Texto da ocorrencia que impediu a contabilizacao

    *==========================================================================
    * Nome do cursor de onde a ultima linha foi carregada (usado por
    * ObterChavePrimaria para saber qual composicao de chave usar).
    *==========================================================================
    this_cCursorCarregado = ""

    *==========================================================================
    * Init - Inicializa o Business Object com o periodo padrao (equivalente
    * ao "Get_Datai.Value = Date() / Get_Dataf.Value = Date()" do Init
    * legado, que roda apos a conexao com o banco ser validada).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.this_dDataI      = DATE()
            THIS.this_dDataF      = DATE()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ValidarPeriodo - equivalente aos tres guards do Click do btnReport
    * legado (data inicial vazia / data final vazia / final menor que
    * inicial). O FormSigPrIct chama este metodo ANTES de confirmar
    * o processamento, para poder dar SetFocus no campo invalido; aqui serve
    * tambem de guarda defensiva dentro de Processar().
    *==========================================================================
    FUNCTION ValidarPeriodo()
        LOCAL loc_lValido
        loc_lValido = .T.
        THIS.this_cMensagemErro = ""

        IF EMPTY(THIS.this_dDataI)
            THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida!!!"
            loc_lValido = .F.
        ELSE
            IF EMPTY(THIS.this_dDataF)
                THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida!!!"
                loc_lValido = .F.
            ELSE
                IF THIS.this_dDataF < THIS.this_dDataI
                    THIS.this_cMensagemErro = "A Data Final N" + CHR(227) + "o Pode Ser Menor Que a Inicial!!!"
                    loc_lValido = .F.
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *==========================================================================
    * CarregarParametrosSistema - Carrega SigCdPam/SigCdPac (equivalente aos
    * dois SqlExecute do Init legado).
    *==========================================================================
    PROTECTED FUNCTION CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .T.

        loc_cSQL = "SELECT DirContabv, GrupoPags, GrupoRecs, MoedaCheqs FROM SigCdPam"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdPam)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "Erro")
            loc_lSucesso = .F.
        ELSE
            SELECT cursor_4c_SigCdPam
            THIS.this_cDirContabv        = ALLTRIM(TratarNulo(DirContabv, ""))
            THIS.this_cGrupoPagamentos   = TratarNulo(GrupoPags, "")
            THIS.this_cGrupoRecebimentos = TratarNulo(GrupoRecs, "")
            THIS.this_cMoedaCheque       = TratarNulo(MoedaCheqs, "")
            USE IN cursor_4c_SigCdPam

            loc_cSQL = "SELECT CfgHisICs FROM SigCdPac"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdPac)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro")
                loc_lSucesso = .F.
            ELSE
                SELECT cursor_4c_SigCdPac
                THIS.this_nConfigHistorico = NVL(CfgHisICs, 0)
                USE IN cursor_4c_SigCdPac
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * RegistrarSemConta - grava uma linha de inconsistencia (conta sem
    * configuracao contabil) no cursor_4c_SemConta. Extraido do bloco
    * "Select SemConta / Append Blank / Replace ... Ocors With Ocor1" que se
    * repete identico varias vezes no Processamento legado (PILAR 3 -
    * deduplicacao de bloco idENTICO, formula de negocio preservada).
    *==========================================================================
    PROTECTED PROCEDURE RegistrarSemConta(par_cConta, par_dData, par_cHist, par_nValor, par_cOcorrencia)
        IF !USED("cursor_4c_SemConta")
            RETURN
        ENDIF
        SELECT cursor_4c_SemConta
        APPEND BLANK
        REPLACE Contas WITH par_cConta, ;
            DataS  WITH par_dData, ;
            Hists  WITH par_cHist, ;
            Valors WITH par_nValor, ;
            Ocors  WITH par_cOcorrencia
    ENDPROC

    *==========================================================================
    * ResolverContaContabil - Do Case de definicao da conta contabil, repetido
    * (quase) identico 6x no Processamento legado:
    *   Case Not Empty(Grupo.ContConts)  -> usa a conta do GRUPO
    *   Case Not Empty(Cliente.CContabs) -> usa a conta do CLIENTE/CONTA
    *   Otherwise                        -> usa a propria conta e registra
    *                                       inconsistencia (Ocor1)
    *==========================================================================
    PROTECTED FUNCTION ResolverContaContabil(par_cContContaGrupo, par_cContaContabilCliente, ;
            par_cContaOriginal, par_dData, par_cHistInconsistencia, par_nValorInconsistencia)
        LOCAL loc_cResultado

        DO CASE
            CASE !EMPTY(par_cContContaGrupo)
                loc_cResultado = par_cContContaGrupo
            CASE !EMPTY(par_cContaContabilCliente)
                loc_cResultado = par_cContaContabilCliente
            OTHERWISE
                loc_cResultado = par_cContaOriginal
                THIS.RegistrarSemConta(par_cContaOriginal, par_dData, par_cHistInconsistencia, ;
                    par_nValorInconsistencia, THIS.ObterTextoOcorrencia(1))
        ENDCASE

        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * ObterTextoOcorrencia - textos fixos das inconsistencias (Ocor1..Ocor4
    * do Processamento legado), centralizados para evitar divergencia de
    * grafia entre os varios pontos que os usam.
    *==========================================================================
    PROTECTED FUNCTION ObterTextoOcorrencia(par_nCodigo)
        LOCAL loc_cTexto
        DO CASE
            CASE par_nCodigo = 1
                loc_cTexto = "Conta Cont" + CHR(225) + "bil n" + CHR(227) + "o Cadastrada "
            CASE par_nCodigo = 2
                loc_cTexto = "Empresa Cont" + CHR(225) + "bil n" + CHR(227) + "o Cadastrada "
            CASE par_nCodigo = 3
                loc_cTexto = "Item do Pagamento sem Centro de Custo "
            CASE par_nCodigo = 4
                loc_cTexto = "PagtoXTit, Emp ou Controle n" + CHR(227) + "o encontrado"
            OTHERWISE
                loc_cTexto = ""
        ENDCASE
        RETURN loc_cTexto
    ENDFUNC

    *==========================================================================
    * Processar - metodo PUBLICO chamado pelo form (equivalente ao
    * ThisForm.Processamento do Click do btnReport legado). So faz o TRY/
    * CATCH externo (regra #1 - nunca RETURN dentro de TRY/CATCH); a logica
    * real mora em ExecutarProcessamento(), que nao tem TRY proprio e pode
    * usar RETURN livremente.
    *==========================================================================
    FUNCTION Processar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.ExecutarProcessamento()
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Processar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarProcessamento - motor do processamento (traducao do PROCEDURE
    * processamento do SIGPRICT legado, ramo SQL Server). Sem TRY proprio -
    * qualquer excecao sobe para o CATCH de Processar().
    *==========================================================================
    PROTECTED FUNCTION ExecutarProcessamento()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        THIS.this_cMensagemErro          = ""
        THIS.this_lPossuiInconsistencia  = .F.
        THIS.this_nTotalInconsistencias  = 0
        THIS.this_lPossuiMovimento       = .F.
        THIS.this_nTotalRegistrosGerados = 0
        THIS.this_lPossuiDiferenca       = .F.
        THIS.this_nTotalDiferencas       = 0

        IF !THIS.ValidarPeriodo()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        IF !THIS.CarregarParametrosSistema()
            RETURN .F.
        ENDIF

        IF !THIS.PrepararCursoresProcesso()
            RETURN .F.
        ENDIF

        IF !THIS.CarregarMovimentoPeriodo()
            RETURN .F.
        ENDIF

        IF !THIS.ConciliarMovimento()
            RETURN .F.
        ENDIF

        THIS.VerificarDiferencas()

        SELECT cursor_4c_SemConta
        GO TOP
        THIS.this_nTotalInconsistencias = RECCOUNT("cursor_4c_SemConta")
        THIS.this_lPossuiInconsistencia = !EOF("cursor_4c_SemConta")

        SELECT cursor_4c_MovAux
        GO TOP
        THIS.this_nTotalRegistrosGerados = RECCOUNT("cursor_4c_MovAux")
        THIS.this_lPossuiMovimento       = !EOF("cursor_4c_MovAux")

        IF USED("cursor_4c_MvCcr")
            USE IN cursor_4c_MvCcr
        ENDIF

        loc_lSucesso = .T.
        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * PrepararCursoresProcesso - cria os cursores de trabalho do processo
    * (equivalente ao topo do Processamento legado: Create Cursor
    * Grupos/SemConta/LoteProc + Zap In MovAux + carga de crSigCdGcr/
    * crSigCdEmp).
    *==========================================================================
    PROTECTED FUNCTION PrepararCursoresProcesso()
        LOCAL loc_cSQL, loc_nResultado

        IF USED("cursor_4c_Grupos")
            USE IN cursor_4c_Grupos
        ENDIF
        IF USED("cursor_4c_TodosGrupos")
            USE IN cursor_4c_TodosGrupos
        ENDIF
        IF USED("cursor_4c_Empresas")
            USE IN cursor_4c_Empresas
        ENDIF
        IF USED("cursor_4c_SemConta")
            USE IN cursor_4c_SemConta
        ENDIF
        IF USED("cursor_4c_LoteProc")
            USE IN cursor_4c_LoteProc
        ENDIF
        IF USED("cursor_4c_MovAux")
            USE IN cursor_4c_MovAux
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_SemConta (Contas C(9), DataS D NULL, Hists C(70), Valors N(12,2), Ocors C(40))
        SET NULL OFF
        INDEX ON Contas + DTOS(DataS) TAG Conta

        CREATE CURSOR cursor_4c_LoteProc (Lotes N(6))
        INDEX ON Lotes TAG Lotes

        SET NULL ON
        CREATE CURSOR cursor_4c_MovAux (AnoFis C(4), Datas C(8), Contas C(9), Debs C(12), Creds C(12), ;
            Docto C(10), Hists C(70), EmpCont C(3), NumSeq C(6), Nums C(6), Lams C(6), Data D NULL, ;
            Valor C(12), Cecus C(3), Emps C(3), Transacaos C(10), Cpfs C(20), IClis C(10), Razaos C(50), ;
            Cheque C(20))
        SET NULL OFF
        INDEX ON EmpCont + Datas TAG EmpCont

        *-- Grupos de conta corrente CONTABILIZAVEIS (equivalente ao cursor "Grupos")
        loc_cSQL = "SELECT Codigos, ContConts FROM SigCdGcr WHERE IntConts = 1"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposTmp")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (Grupos)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF
        CREATE CURSOR cursor_4c_Grupos (Codigos C(10), ContConts C(9))
        SELECT cursor_4c_Grupos
        APPEND FROM DBF("cursor_4c_GruposTmp")
        USE IN cursor_4c_GruposTmp
        SELECT cursor_4c_Grupos
        INDEX ON Codigos TAG Codigos

        *-- Todos os grupos de conta corrente, para resolucao da contra-partida
        loc_cSQL = "SELECT Codigos, IntConts, ContConts FROM SigCdGcr"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TodosGrupos")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdGcr)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_TodosGrupos
        INDEX ON Codigos TAG Codigos

        *-- Empresas - mantido so para preservar o mesmo ponto de falha de
        *-- conexao do legado (ver nota de fidelidade do cabecalho: o
        *-- resultado nao e mais consultado, pois o bloco m.EmpCont do
        *-- legado esta desativado).
        loc_cSQL = "SELECT Cemps FROM SigCdEmp"
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Empresas")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdEmp)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF
        SELECT cursor_4c_Empresas
        INDEX ON Cemps TAG Cemps

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * CarregarMovimentoPeriodo - traz o movimento de conta corrente do
    * periodo informado (equivalente ao bloco "Else" / SQL Server do trecho
    * "Selecionando o Arquivo de Conta Corrente" do Processamento legado).
    * O cursor precisa ser READWRITE porque o final da conciliacao faz
    * "Delete For EmpDopnums=lcChave" sobre ele (ver ConciliarMovimento).
    *==========================================================================
    PROTECTED FUNCTION CarregarMovimentoPeriodo()
        LOCAL loc_cSQL, loc_nResultado, loc_cDataFim

        loc_cDataFim = FormatarDataSQL(DATETIME(YEAR(THIS.this_dDataF), MONTH(THIS.this_dDataF), ;
            DAY(THIS.this_dDataF), 23, 59, 59))

        loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
            "Hists, Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
            "EspecieNfs, EmpDopNcs, Cotacaos, SValors, Valocurs FROM SigMvCcr WHERE Datas BETWEEN " + ;
            FormatarDataSQL(THIS.this_dDataI) + " AND " + loc_cDataFim + " ORDER BY Datas, Nopers"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrTmp")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigMvCcr)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        IF USED("cursor_4c_MvCcr")
            USE IN cursor_4c_MvCcr
        ENDIF
        SELECT * FROM cursor_4c_MvCcrTmp INTO CURSOR cursor_4c_MvCcr READWRITE
        USE IN cursor_4c_MvCcrTmp
        SELECT cursor_4c_MvCcr
        INDEX ON Datas TAG Datas
        GO TOP

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ConciliarMovimento - laco principal (Scan) do Processamento legado,
    * ramo SQL Server. Para cada linha de movimento, define a conta contabil
    * do lancamento (do grupo ou do cadastro de contas), monta o
    * debito/credito e grava em cursor_4c_MovAux. Quando a operacao exige
    * contra-lancamento (lote de cheques, operacao simples por Nopers ou
    * rateio contra titulos pagos/recebidos), gera tambem os lancamentos
    * complementares.
    *==========================================================================
    PROTECTED FUNCTION ConciliarMovimento()
        LOCAL loc_cContabs, loc_nDebs, loc_nCreds, loc_cHists, loc_cAnoFis, loc_cDatas
        LOCAL loc_nNcont, loc_nOldNopers, loc_nValLan1, loc_nNumlote, loc_cControle
        LOCAL loc_cOpeAtual, loc_nControleAtu, loc_cEmpLanc, loc_lManual, loc_cSQL, loc_nResultado
        LOCAL loc_cOperacao, loc_nValorDesp, loc_nVTitCC, loc_nValOco, loc_cMoeDiv, loc_nCotDiv
        LOCAL loc_nPNop, loc_lProvis, loc_nValOcoTit, loc_nVpago, loc_nValContra, loc_nVrDif
        LOCAL loc_cLcKey, loc_cGrupoPag, loc_cDocto, loc_nRegMvCcr, loc_nRegCount, loc_nAtual
        LOCAL loc_oProg, loc_cTransacaos, loc_cChave, loc_cContContaGrupo, loc_cContaContabilCliente

        loc_nNcont      = 0
        loc_nOldNopers  = 0
        loc_nRegCount   = RECCOUNT("cursor_4c_MvCcr")
        loc_nAtual      = 0

        loc_oProg = CREATEOBJECT("fwprogressbar", "Processando Movimento de Conta Corrente...", loc_nRegCount)
        loc_oProg.Show()

        SELECT cursor_4c_MvCcr
        GO TOP
        SCAN WHILE !EOF("cursor_4c_MvCcr")
            loc_nAtual = loc_nAtual + 1
            loc_oProg.SubTitulo.Caption = "Processando dia : " + DTOC(cursor_4c_MvCcr.Datas) + " - " + ;
                TRANSFORM(cursor_4c_MvCcr.Nopers)
            loc_oProg.Update(.T.)

            loc_nRegMvCcr = RECNO("cursor_4c_MvCcr")

            *-- Verifica se o Grupo da Conta e contabilizavel; se nao for, a
            *-- conta precisa ser contabilizavel (crSigCdCli.IntConts = 1).
            loc_cSQL = "SELECT IClis, RClis, Razaos, Cpfs, IntConts, CContabs, TpHists, Hists " + ;
                "FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcr.Contas) + " ORDER BY CContabs"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDestino")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                loc_oProg.Complete(.T.)
                RETURN .F.
            ENDIF

            IF !SEEK(ALLTRIM(cursor_4c_MvCcr.Grupos), "cursor_4c_Grupos", "Codigos") OR cursor_4c_MvCcr.Valors = 0
                IF NVL(cursor_4c_CliDestino.IntConts, 0) != 1
                    USE IN cursor_4c_CliDestino
                    LOOP
                ENDIF
            ENDIF

            *-- Verifica se a contra-partida permite contabilizacao (determinado pelo grupo)
            IF SEEK(ALLTRIM(cursor_4c_MvCcr.SGrupos), "cursor_4c_TodosGrupos", "Codigos")
                IF cursor_4c_TodosGrupos.IntConts = 3
                    USE IN cursor_4c_CliDestino
                    LOOP
                ENDIF
            ENDIF

            *-- Definicao da conta contabil do lancamento principal
            IF USED("cursor_4c_Grupos") AND SEEK(ALLTRIM(cursor_4c_MvCcr.Grupos), "cursor_4c_Grupos", "Codigos")
                loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_Grupos.ContConts, ""))
            ELSE
                loc_cContContaGrupo = ""
            ENDIF
            loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino.CContabs, ""))

            loc_cHists = SUBSTR(TratarNulo(cursor_4c_MvCcr.Hists, "") + TratarNulo(cursor_4c_MvCcr.Hist2s, ""), 1, 70)
            loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                ALLTRIM(cursor_4c_MvCcr.Contas), cursor_4c_MvCcr.Datas, loc_cHists, cursor_4c_MvCcr.Valors)

            IF cursor_4c_MvCcr.Opers = "D"
                loc_nDebs  = cursor_4c_MvCcr.Valors
                loc_nCreds = 0
            ELSE
                loc_nDebs  = 0
                loc_nCreds = cursor_4c_MvCcr.Valors
            ENDIF

            loc_nValLan1 = cursor_4c_MvCcr.Valors
            loc_cAnoFis  = TRANSFORM(YEAR(cursor_4c_MvCcr.Datas))
            loc_cDatas   = STRTRAN(DTOC(cursor_4c_MvCcr.Datas), "/", "")
            loc_cHists   = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

            IF cursor_4c_MvCcr.Autos AND "LOTE" $ TratarNulo(cursor_4c_MvCcr.Hists, "")
                loc_cDocto   = TRANSFORM(VAL(RIGHT(ALLTRIM(cursor_4c_MvCcr.Hists), 6)))
                loc_nNumlote = VAL(SUBSTR(cursor_4c_MvCcr.Hists, AT("LOTE", cursor_4c_MvCcr.Hists) + 5, 6))
                IF loc_nNumlote = 0
                    loc_nNumlote = VAL(RIGHT(ALLTRIM(cursor_4c_MvCcr.Hists), 6))
                ENDIF
                IF SEEK(loc_nNumlote, "cursor_4c_LoteProc", "Lotes")
                    USE IN cursor_4c_CliDestino
                    LOOP
                ENDIF
            ELSE
                loc_cDocto = ALLTRIM(cursor_4c_MvCcr.Nfs)
            ENDIF

            IF cursor_4c_MvCcr.Nopers != loc_nOldNopers
                loc_nNcont = loc_nNcont + 1
                loc_nOldNopers = cursor_4c_MvCcr.Nopers
            ENDIF
            loc_cTransacaos = PADL(ALLTRIM(TRANSFORM(loc_nNcont)), 6, "0")

            *-- Lancamento 1
            SELECT cursor_4c_MovAux
            APPEND BLANK
            REPLACE AnoFis      WITH loc_cAnoFis, ;
                    Datas       WITH loc_cDatas, ;
                    Contas      WITH loc_cContabs, ;
                    Debs        WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                    Creds       WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                    Docto       WITH loc_cDocto, ;
                    Hists       WITH loc_cHists, ;
                    Emps        WITH cursor_4c_MvCcr.Emps, ;
                    Cecus       WITH cursor_4c_MvCcr.Emps, ;
                    Transacaos  WITH loc_cTransacaos, ;
                    IClis       WITH TratarNulo(cursor_4c_CliDestino.IClis, ""), ;
                    Razaos      WITH IIF(EMPTY(TratarNulo(cursor_4c_CliDestino.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliDestino.RClis, ""), ;
                                        TratarNulo(cursor_4c_CliDestino.Razaos, "")), ;
                    Cpfs        WITH TratarNulo(cursor_4c_CliDestino.Cpfs, "")

            IF cursor_4c_MvCcr.Nopers = 1
                USE IN cursor_4c_CliDestino
                LOOP
            ENDIF

            *-- Lancamento 2 (contra-partida)
            loc_cControle    = TRANSFORM(cursor_4c_MvCcr.Nopers)
            loc_nControleAtu = cursor_4c_MvCcr.Nopers
            loc_cOpeAtual    = cursor_4c_MvCcr.Opers
            loc_cEmpLanc     = cursor_4c_MvCcr.Emps
            loc_lManual      = .F.

            loc_cSQL = "SELECT Tipos FROM SigMvCcr WHERE Nopers = " + TRANSFORM(loc_nControleAtu)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrTipos")
            IF loc_nResultado >= 0 AND USED("cursor_4c_MvCcrTipos")
                SELECT cursor_4c_MvCcrTipos
                LOCATE FOR ALLTRIM(Tipos) == "M"
                loc_lManual = FOUND()
                USE IN cursor_4c_MvCcrTipos
            ENDIF

            DO CASE
                CASE cursor_4c_MvCcr.Autos AND "LOTE" $ TratarNulo(cursor_4c_MvCcr.Hists, "")
                    IF !THIS.ProcessarLoteCheques(loc_nNumlote, loc_cOpeAtual, loc_cEmpLanc)
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                CASE (ALLTRIM(cursor_4c_MvCcr.Dopes) != "PAGAMENTO" AND ALLTRIM(cursor_4c_MvCcr.Dopes) != "RECEBIMENTO") OR ;
                        (ALLTRIM(cursor_4c_MvCcr.Dopes) = "PAGAMENTO" AND loc_lManual) OR ;
                        (ALLTRIM(cursor_4c_MvCcr.Dopes) = "RECEBIMENTO" AND loc_lManual)

                    IF !THIS.ProcessarContraPartidaSimples(loc_cControle, loc_cOpeAtual)
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                OTHERWISE
                    loc_cOperacao = ALLTRIM(cursor_4c_MvCcr.Dopes)
                    loc_cLcKey = cursor_4c_MvCcr.Emps + cursor_4c_MvCcr.Dopes + STR(cursor_4c_MvCcr.Numes, 6)

                    loc_nValOcoTit = THIS.ProcessarRateioTitulos(loc_cLcKey, loc_cOperacao, loc_cOpeAtual, @loc_nValorDesp)
                    IF loc_nValOcoTit = -1
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                    IF loc_nValorDesp = 0
                        loc_nVpago = 0
                    ELSE
                        loc_nVpago = loc_nValLan1 / loc_nValorDesp
                    ENDIF

                    loc_nValContra = THIS.GerarLancamentosRateio(loc_cLcKey, loc_cOperacao, loc_nVpago)
                    IF loc_nValContra = -1
                        USE IN cursor_4c_CliDestino
                        loc_oProg.Complete(.T.)
                        RETURN .F.
                    ENDIF

                    *-- Acerto da diferenca (rateio pode nao fechar 100% por arredondamento)
                    loc_nVrDif = loc_nValLan1 - loc_nValContra
                    IF loc_nVrDif != 0
                        SELECT cursor_4c_MovAux
                        IF VAL(Debs) != 0
                            REPLACE Debs WITH TRANSFORM((VAL(Debs) / 100 + loc_nVrDif) * 100, "@L 999999999999")
                        ELSE
                            REPLACE Creds WITH TRANSFORM((VAL(Creds) / 100 + loc_nVrDif) * 100, "@L 999999999999")
                        ENDIF
                    ENDIF
            ENDCASE

            USE IN cursor_4c_CliDestino

            *-- Operacoes de PAGAMENTO/RECEBIMENTO ja tratadas por completo
            *-- nesta iteracao (todas as parcelas do mesmo titulo) nao devem
            *-- ser reprocessadas quando o Scan passar pelas demais linhas do
            *-- mesmo EmpDopNums.
            IF ALLTRIM(cursor_4c_MvCcr.Dopes) = "PAGAMENTO" OR ALLTRIM(cursor_4c_MvCcr.Dopes) = "RECEBIMENTO"
                loc_cChave = cursor_4c_MvCcr.EmpDopNums
                SELECT cursor_4c_MvCcr
                DELETE FOR EmpDopNums == loc_cChave
                GO loc_nRegMvCcr
            ENDIF
        ENDSCAN

        loc_oProg.Complete(.T.)
        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ProcessarLoteCheques - contra-lancamento para operacoes pagas/recebidas
    * por lote de cheques (SigCqChm), equivalente ao ramo SQL Server do
    * "Case crSigMvCcr.Autos And LOTE $ Hists" do Processamento legado.
    *==========================================================================
    PROTECTED FUNCTION ProcessarLoteCheques(par_nNumlote, par_cOpeAtual, par_cEmpLanc)
        LOCAL loc_cSQL, loc_nResultado, loc_cControle, loc_cContContaGrupo, loc_cContaContabilCliente
        LOCAL loc_cContabs, loc_nDebs, loc_nCreds, loc_cHists

        SELECT cursor_4c_LoteProc
        APPEND BLANK
        REPLACE Lotes WITH par_nNumlote

        loc_cSQL = "SELECT Emps, NumOs FROM SigCqChm WHERE NumLotes = " + TRANSFORM(par_nNumlote)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Chm")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCqChm)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Chm
        SCAN
            loc_cControle = ALLTRIM(cursor_4c_Chm.Emps) + ALLTRIM(STR(cursor_4c_Chm.NumOs, 7))

            loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, Hists, " + ;
                "Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, EspecieNfs, " + ;
                "EmpDopNcs FROM SigMvCcr WHERE VOpers = " + EscaparSQL(loc_cControle)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop")
            IF loc_nResultado < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (crSigMvCcr - VOpers)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                RETURN .F.
            ENDIF
            IF RECCOUNT("cursor_4c_MvCcrNop") = 0
                USE IN cursor_4c_MvCcrNop
                loc_cControle = par_cEmpLanc + ALLTRIM(STR(cursor_4c_Chm.NumOs, 7))
                loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, Hists, " + ;
                    "Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, EspecieNfs, " + ;
                    "EmpDopNcs FROM SigMvCcr WHERE VOpers = " + EscaparSQL(loc_cControle)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop")
                IF loc_nResultado < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (crSigMvCcr - VOpers)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    RETURN .F.
                ENDIF
            ENDIF

            SELECT cursor_4c_MvCcrNop
            SCAN
                IF (ALLTRIM(Opers) != par_cOpeAtual) AND ;
                        (ALLTRIM(Grupos) != THIS.this_cGrupoPagamentos) AND ;
                        (ALLTRIM(Grupos) != THIS.this_cGrupoRecebimentos)

                    *-- Definicao da conta contabil da contra-partida
                    loc_cContContaGrupo = ""
                    IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_TodosGrupos", "Codigos")
                        loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                    ENDIF

                    loc_cSQL = "SELECT IClis, RClis, Razaos, Cpfs FROM SigCdCli WHERE IClis = " + ;
                        EscaparSQL(cursor_4c_MvCcrNop.SContas) + " ORDER BY CContabs"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrigem") < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "Falha na Conex" + CHR(227) + "o (LocalCli)" + CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "")
                        RETURN .F.
                    ENDIF

                    loc_cSQL = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists FROM SigCdCli " + ;
                        "WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.Contas) + " ORDER BY CContabs"
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDestino2") < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                            "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "")
                        USE IN cursor_4c_CliOrigem
                        RETURN .F.
                    ENDIF

                    loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino2.CContabs, ""))
                    loc_cHists = SUBSTR(ALLTRIM(TratarNulo(cursor_4c_MvCcrNop.Hists, "")) + " " + ;
                        TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)

                    loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                        ALLTRIM(cursor_4c_MvCcrNop.Contas), cursor_4c_MvCcrNop.Datas, loc_cHists, cursor_4c_MvCcrNop.Valors)

                    IF cursor_4c_MvCcrNop.Opers = "D"
                        loc_nDebs  = cursor_4c_MvCcrNop.Valors
                        loc_nCreds = 0
                    ELSE
                        loc_nDebs  = 0
                        loc_nCreds = cursor_4c_MvCcrNop.Valors
                    ENDIF

                    loc_cHists = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

                    SELECT cursor_4c_MovAux
                    APPEND BLANK
                    REPLACE Contas WITH loc_cContabs, ;
                            Debs   WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                            Creds  WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                            Hists  WITH loc_cHists, ;
                            Emps   WITH cursor_4c_MvCcrNop.Emps, ;
                            Cecus  WITH cursor_4c_MvCcrNop.Emps, ;
                            IClis  WITH TratarNulo(cursor_4c_CliOrigem.IClis, ""), ;
                            Razaos WITH IIF(EMPTY(TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliOrigem.RClis, ""), ;
                                        TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                            Cpfs   WITH TratarNulo(cursor_4c_CliOrigem.Cpfs, "")

                    USE IN cursor_4c_CliOrigem
                    USE IN cursor_4c_CliDestino2
                ENDIF
                SELECT cursor_4c_MvCcrNop
            ENDSCAN
            USE IN cursor_4c_MvCcrNop
            SELECT cursor_4c_Chm
        ENDSCAN
        USE IN cursor_4c_Chm

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ProcessarContraPartidaSimples - contra-lancamento das demais operacoes
    * (que nao sao PAGAMENTO/RECEBIMENTO automatico), equivalente ao ramo SQL
    * Server da clausula "Case (Dopes <> PAGAMENTO...) Or (...Manual)".
    *==========================================================================
    PROTECTED FUNCTION ProcessarContraPartidaSimples(par_cControle, par_cOpeAtual)
        LOCAL loc_cSQL, loc_nResultado, loc_cContContaGrupo, loc_cContaContabilCliente
        LOCAL loc_cContabs, loc_nDebs, loc_nCreds, loc_cHists

        loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, Hists, " + ;
            "Hist2s, Valors, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, EspecieNfs, " + ;
            "EmpDopNcs, Cotacaos, SValors, Valocurs FROM SigMvCcr WHERE Nopers = " + par_cControle
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigMvCcr - Nopers)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_MvCcrNop
        SCAN
            IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_Grupos", "Codigos")
                LOOP
            ENDIF

            IF (ALLTRIM(Opers) != par_cOpeAtual) AND ;
                    (ALLTRIM(Grupos) != THIS.this_cGrupoPagamentos) AND ;
                    (ALLTRIM(Grupos) != THIS.this_cGrupoRecebimentos)

                loc_cContContaGrupo = ""
                IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_TodosGrupos", "Codigos")
                    loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                ENDIF

                loc_cSQL = "SELECT IClis, RClis, Razaos, Cpfs FROM SigCdCli WHERE IClis = " + ;
                    EscaparSQL(cursor_4c_MvCcrNop.SContas) + " ORDER BY CContabs"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliOrigem") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (LocalCli)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_MvCcrNop
                    RETURN .F.
                ENDIF

                loc_cSQL = "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, Hists FROM SigCdCli " + ;
                    "WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.Contas) + " ORDER BY CContabs"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CliDestino2") < 1
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_CliOrigem
                    USE IN cursor_4c_MvCcrNop
                    RETURN .F.
                ENDIF

                loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino2.CContabs, ""))
                loc_cHists = SUBSTR(ALLTRIM(TratarNulo(cursor_4c_MvCcrNop.Hists, "")) + " " + ;
                    TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)

                loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                    ALLTRIM(cursor_4c_MvCcrNop.Contas), cursor_4c_MvCcrNop.Datas, loc_cHists, cursor_4c_MvCcrNop.Valors)

                IF cursor_4c_MvCcrNop.Opers = "D"
                    loc_nDebs  = IIF(cursor_4c_MvCcrNop.Cotacaos != 0 AND cursor_4c_MvCcrNop.Cotacaos != 1, ;
                        cursor_4c_MvCcrNop.SValors, cursor_4c_MvCcrNop.Valors)
                    loc_nCreds = 0
                ELSE
                    loc_nDebs  = 0
                    loc_nCreds = IIF(cursor_4c_MvCcrNop.Cotacaos != 0 AND cursor_4c_MvCcrNop.Cotacaos != 1, ;
                        cursor_4c_MvCcrNop.SValors, cursor_4c_MvCcrNop.Valors)
                ENDIF

                loc_cHists = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

                SELECT cursor_4c_MovAux
                APPEND BLANK
                REPLACE Contas WITH loc_cContabs, ;
                        Debs   WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                        Creds  WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                        Docto  WITH ALLTRIM(cursor_4c_MvCcrNop.Nfs), ;
                        Hists  WITH loc_cHists, ;
                        Emps   WITH cursor_4c_MvCcrNop.Emps, ;
                        Cecus  WITH cursor_4c_MvCcrNop.Emps, ;
                        IClis  WITH TratarNulo(cursor_4c_CliOrigem.IClis, ""), ;
                        Razaos WITH IIF(EMPTY(TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                                    TratarNulo(cursor_4c_CliOrigem.RClis, ""), ;
                                    TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                        Cpfs   WITH TratarNulo(cursor_4c_CliOrigem.Cpfs, "")

                USE IN cursor_4c_CliOrigem
                USE IN cursor_4c_CliDestino2
            ENDIF
            SELECT cursor_4c_MvCcrNop
        ENDSCAN
        USE IN cursor_4c_MvCcrNop

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * ProcessarRateioTitulos - 1a passada do rateio contra SigCdPit (apenas
    * ACUMULA o total das despesas/recebimentos do titulo e registra
    * inconsistencias "sem centro de custo"/"nao encontrado"), equivalente
    * ao PRIMEIRO "Select crSigCdPit / Scan" do ramo Otherwise do legado.
    * Retorna o total de ocorrencias (ValOco acumulado) ou -1 em erro; o
    * total das despesas sai por referencia em par_nValorDesp.
    *==========================================================================
    PROTECTED FUNCTION ProcessarRateioTitulos(par_cLcKey, par_cOperacao, par_cOpeAtual, par_nValorDesp)
        LOCAL loc_cSQL, loc_nResultado, loc_nValorDesp, loc_nPNop, loc_cMoeDiv, loc_nCotDiv
        LOCAL loc_nVTitCC, loc_lProvis, loc_cChaveBusca, loc_nValor

        loc_nValorDesp = 0

        loc_cSQL = "SELECT Nopers, Emps, Dopes, Numes, Hists, Acertos, Grupos, Contas, Moedas, " + ;
            "Cotacaos FROM SigCdPit WHERE EmpDopNums = " + EscaparSQL(par_cLcKey)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pit")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdPit)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            par_nValorDesp = 0
            RETURN -1
        ENDIF

        SELECT cursor_4c_Pit
        SCAN
            IF (par_cOperacao = "PAGAMENTO" AND par_cOpeAtual = "D") OR ;
                    (par_cOperacao = "RECEBIMENTO" AND par_cOpeAtual = "C")
                *** Lancamento com valor inverso (devolucao de compra/venda)
                LOOP
            ENDIF

            loc_nVTitCC = 0
            loc_cMoeDiv = cursor_4c_Pit.Moedas
            loc_nCotDiv = cursor_4c_Pit.Cotacaos
            loc_nPNop   = cursor_4c_Pit.Nopers

            loc_cSQL = "SELECT * FROM SigMvCcr WHERE Nopers = " + TRANSFORM(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcr1") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpMccr1)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_Pit
                par_nValorDesp = 0
                RETURN -1
            ENDIF

            loc_lProvis = .T.
            IF SQLEXEC(gnConnHandle, "SELECT Provs FROM SigCdEsp WHERE Especies = " + ;
                    EscaparSQL(cursor_4c_MvCcr1.EspecieNfs), "cursor_4c_Espes") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpEspes)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_MvCcr1
                USE IN cursor_4c_Pit
                par_nValorDesp = 0
                RETURN -1
            ENDIF
            loc_lProvis = (RECCOUNT("cursor_4c_Espes") = 0 OR cursor_4c_Espes.Provs = 1)
            USE IN cursor_4c_Espes

            SELECT cursor_4c_MvCcr1
            GO TOP
            IF !EOF("cursor_4c_MvCcr1")
                IF cursor_4c_MvCcr1.Numcs = 0
                    loc_cChaveBusca = TRANSFORM(cursor_4c_MvCcr1.Nopers)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE Nopers = " + loc_cChaveBusca
                ELSE
                    loc_cChaveBusca = ALLTRIM(cursor_4c_MvCcr1.EmpDopNcs)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE EmpDopNcs = " + EscaparSQL(loc_cChaveBusca)
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop") < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (TmpMccr)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_MvCcr1
                    USE IN cursor_4c_Pit
                    par_nValorDesp = 0
                    RETURN -1
                ENDIF

                SELECT cursor_4c_MvCcrNop
                SCAN
                    IF ALLTRIM(Grupos) = THIS.this_cGrupoPagamentos OR ;
                            ALLTRIM(Grupos) = THIS.this_cGrupoRecebimentos OR ;
                            ALLTRIM(Tipos) = "O"
                        LOOP
                    ENDIF

                    IF (par_cOperacao = "PAGAMENTO" AND Opers = "D") OR ;
                            (par_cOperacao = "RECEBIMENTO" AND Opers = "C")
                        IF loc_cMoeDiv != THIS.this_cMoedaCheque
                            loc_nValor = ROUND((cursor_4c_MvCcrNop.Valors + cursor_4c_MvCcrNop.Valocurs) * loc_nCotDiv, 2)
                        ELSE
                            loc_nValor = cursor_4c_MvCcrNop.Valors + cursor_4c_MvCcrNop.Valocurs
                        ENDIF
                        loc_nValorDesp = loc_nValorDesp + loc_nValor
                        loc_nVTitCC    = loc_nVTitCC    + loc_nValor
                    ENDIF
                ENDSCAN
                USE IN cursor_4c_MvCcrNop

                IF loc_nVTitCC = 0
                    THIS.RegistrarSemConta(IIF(!loc_lProvis, ALLTRIM(cursor_4c_MvCcr1.Contas), ;
                        ALLTRIM(cursor_4c_MvCcr1.SContas)), cursor_4c_MvCcr1.Datas, ;
                        ALLTRIM(cursor_4c_Pit.Emps) + " / " + ALLTRIM(cursor_4c_Pit.Dopes) + " / " + ;
                        STR(cursor_4c_Pit.Numes, 6) + ALLTRIM(cursor_4c_Pit.Hists), ;
                        cursor_4c_Pit.Acertos, THIS.ObterTextoOcorrencia(3))
                ENDIF
            ELSE
                THIS.RegistrarSemConta(IIF(!loc_lProvis, ALLTRIM(cursor_4c_MvCcr1.Contas), ;
                    ALLTRIM(cursor_4c_MvCcr1.SContas)), cursor_4c_MvCcr1.Datas, ;
                    ALLTRIM(cursor_4c_Pit.Emps) + " / " + ALLTRIM(cursor_4c_Pit.Dopes) + " / " + ;
                    STR(cursor_4c_Pit.Numes, 6) + ALLTRIM(cursor_4c_Pit.Hists), ;
                    cursor_4c_Pit.Acertos, THIS.ObterTextoOcorrencia(4))
            ENDIF

            USE IN cursor_4c_MvCcr1
            SELECT cursor_4c_Pit
        ENDSCAN
        USE IN cursor_4c_Pit

        par_nValorDesp = loc_nValorDesp
        RETURN 0
    ENDFUNC

    *==========================================================================
    * GerarLancamentosRateio - 2a passada do rateio contra SigCdPit (gera de
    * fato os lancamentos contabeis proporcionais ao valor pago/recebido),
    * equivalente ao SEGUNDO "Select crSigCdPit / Scan" do ramo Otherwise.
    * Retorna o total lancado (ValContra) ou -1 em erro.
    *==========================================================================
    PROTECTED FUNCTION GerarLancamentosRateio(par_cLcKey, par_cOperacao, par_nVpago)
        LOCAL loc_cSQL, loc_nResultado, loc_nValContra, loc_nPNop, loc_cMoeDiv, loc_nCotDiv
        LOCAL loc_nValOcoTit, loc_cChaveBusca, loc_cContContaGrupo, loc_cContaContabilCliente
        LOCAL loc_cContabs, loc_nValor, loc_nDebs, loc_nCreds, loc_cHists, loc_cGrupoPag
        LOCAL loc_cNumeroCheque, loc_cHistPrinc, loc_nOrdemHist, loc_cHist, loc_lProvis

        loc_nValContra = 0

        loc_cSQL = "SELECT Nopers, Emps, Dopes, Numes, Hists, Acertos, Grupos, Contas, Moedas, " + ;
            "Cotacaos FROM SigCdPit WHERE EmpDopNums = " + EscaparSQL(par_cLcKey)
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pit")
        IF loc_nResultado < 1
            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                "Falha na Conex" + CHR(227) + "o (crSigCdPit)" + CHR(13) + CapturarErroSQL()
            MsgErro(THIS.this_cMensagemErro, "")
            RETURN -1
        ENDIF

        SELECT cursor_4c_Pit
        SCAN
            IF (par_cOperacao = "PAGAMENTO" AND Opers = "D") OR ;
                    (par_cOperacao = "RECEBIMENTO" AND Opers = "C")
                *** Lancamento com valor inverso (devolucao de compra/venda)
                LOOP
            ENDIF

            loc_cMoeDiv = cursor_4c_Pit.Moedas
            loc_nCotDiv = cursor_4c_Pit.Cotacaos
            loc_nPNop   = cursor_4c_Pit.Nopers
            loc_cGrupoPag = ALLTRIM(cursor_4c_Pit.Grupos)

            loc_cSQL = "SELECT * FROM SigMvCcr WHERE Nopers = " + TRANSFORM(loc_nPNop)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcr1") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpMccr1)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_Pit
                RETURN -1
            ENDIF

            loc_lProvis = .T.
            IF SQLEXEC(gnConnHandle, "SELECT Provs FROM SigCdEsp WHERE Especies = " + ;
                    EscaparSQL(cursor_4c_MvCcr1.EspecieNfs), "cursor_4c_Espes") < 1
                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    "Falha na Conex" + CHR(227) + "o (TmpEspes)" + CHR(13) + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "")
                USE IN cursor_4c_MvCcr1
                USE IN cursor_4c_Pit
                RETURN -1
            ENDIF
            loc_lProvis = (RECCOUNT("cursor_4c_Espes") = 0 OR cursor_4c_Espes.Provs = 1)
            USE IN cursor_4c_Espes

            SELECT cursor_4c_MvCcr1
            GO TOP
            IF !EOF("cursor_4c_MvCcr1")
                IF cursor_4c_MvCcr1.Numcs = 0
                    loc_cChaveBusca = TRANSFORM(cursor_4c_MvCcr1.Nopers)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE Nopers = " + loc_cChaveBusca
                ELSE
                    loc_cChaveBusca = ALLTRIM(cursor_4c_MvCcr1.EmpDopNcs)
                    loc_cSQL = "SELECT Emps, Dopes, Numes, Grupos, Contas, SGrupos, SContas, Datas, " + ;
                        "Hists, Hist2s, Valors, Valocurs, Opers, Autos, Nopers, Nfs, Titulos, Tipos, EmpDopNums, " + ;
                        "EspecieNfs, EmpDopNcs FROM SigMvCcr WHERE EmpDopNcs = " + EscaparSQL(loc_cChaveBusca)
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvCcrNop") < 0
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                        "Falha na Conex" + CHR(227) + "o (TmpMccr)" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "")
                    USE IN cursor_4c_MvCcr1
                    USE IN cursor_4c_Pit
                    RETURN -1
                ENDIF

                loc_nValOcoTit = 0
                SELECT cursor_4c_MvCcrNop
                SCAN
                    IF ALLTRIM(Grupos) = THIS.this_cGrupoPagamentos OR ;
                            ALLTRIM(Grupos) = THIS.this_cGrupoRecebimentos OR ALLTRIM(Tipos) = "O"
                        *-- Contas transitorias / lancamentos de ocorrencias.
                        *-- Descontar as ocorrencias do total das despesas
                        *-- quando existe transitoria (so quando NAO e tipo O)
                        IF ALLTRIM(Tipos) != "O" AND cursor_4c_MvCcrNop.Valocurs != 0
                            IF loc_cMoeDiv != THIS.this_cMoedaCheque
                                loc_nValOcoTit = loc_nValOcoTit + ROUND(cursor_4c_MvCcrNop.Valocurs * loc_nCotDiv, 2)
                            ELSE
                                loc_nValOcoTit = loc_nValOcoTit + cursor_4c_MvCcrNop.Valocurs
                            ENDIF
                        ENDIF
                        LOOP
                    ENDIF

                    IF (par_cOperacao = "PAGAMENTO" AND Opers = "D") OR ;
                            (par_cOperacao = "RECEBIMENTO" AND Opers = "C")

                        *-- Definicao da conta contabil
                        loc_cContContaGrupo = ""
                        IF !loc_lProvis
                            IF SEEK(ALLTRIM(cursor_4c_MvCcrNop.Grupos), "cursor_4c_TodosGrupos", "Codigos")
                                loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                            ENDIF
                        ELSE
                            IF SEEK(loc_cGrupoPag, "cursor_4c_TodosGrupos", "Codigos")
                                loc_cContContaGrupo = ALLTRIM(TratarNulo(cursor_4c_TodosGrupos.ContConts, ""))
                            ENDIF
                        ENDIF

                        IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.SContas) + ;
                                " ORDER BY CContabs", "cursor_4c_CliOrigem") < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (LocalCli)" + CHR(13) + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "")
                            USE IN cursor_4c_MvCcrNop
                            USE IN cursor_4c_MvCcr1
                            USE IN cursor_4c_Pit
                            RETURN -1
                        ENDIF

                        IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcrNop.Contas) + ;
                                " ORDER BY CContabs", "cursor_4c_CliDestino2") < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (crSigCdCli)" + CHR(13) + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "")
                            USE IN cursor_4c_CliOrigem
                            USE IN cursor_4c_MvCcrNop
                            USE IN cursor_4c_MvCcr1
                            USE IN cursor_4c_Pit
                            RETURN -1
                        ENDIF

                        *-- Numero do cheque do pagamento (diferenciar de debito automatico)
                        IF SQLEXEC(gnConnHandle, "SELECT Numeros FROM SigMvPar A, SigOpFp B, SigCdFrm C " + ;
                                "WHERE A.EmpDopNums = " + EscaparSQL(ALLTRIM(cursor_4c_MvCcrNop.EmpDopNums)) + ;
                                " AND A.FPags = B.FPags AND B.Formas = C.Formas AND C.Infos = 'C'", ;
                                "cursor_4c_Par") < 0
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                "Falha na Conex" + CHR(227) + "o (crSigMvPar)" + CHR(13) + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "")
                            USE IN cursor_4c_CliOrigem
                            USE IN cursor_4c_CliDestino2
                            USE IN cursor_4c_MvCcrNop
                            USE IN cursor_4c_MvCcr1
                            USE IN cursor_4c_Pit
                            RETURN -1
                        ENDIF

                        IF !loc_lProvis
                            loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliDestino2.CContabs, ""))
                        ELSE
                            loc_cContaContabilCliente = ALLTRIM(TratarNulo(cursor_4c_CliOrigem.CContabs, ""))
                        ENDIF
                        loc_cHists = SUBSTR(TratarNulo(cursor_4c_MvCcrNop.Hists, "") + TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)
                        loc_cContabs = THIS.ResolverContaContabil(loc_cContContaGrupo, loc_cContaContabilCliente, ;
                            ALLTRIM(cursor_4c_MvCcrNop.Contas), cursor_4c_MvCcrNop.Datas, loc_cHists, cursor_4c_MvCcrNop.Valors)

                        IF loc_cMoeDiv != THIS.this_cMoedaCheque
                            loc_nValor = ROUND((cursor_4c_MvCcrNop.Valors + loc_nValOcoTit) * loc_nCotDiv, 2)
                        ELSE
                            loc_nValor = cursor_4c_MvCcrNop.Valors + loc_nValOcoTit
                        ENDIF
                        loc_nValor = ROUND(loc_nValor * par_nVpago, 2)
                        loc_nValContra = loc_nValContra + loc_nValor

                        IF cursor_4c_MvCcrNop.Opers = "D"
                            loc_nDebs  = loc_nValor
                            loc_nCreds = 0
                        ELSE
                            loc_nDebs  = 0
                            loc_nCreds = loc_nValor
                        ENDIF

                        loc_cNumeroCheque = IIF(!EMPTY(TratarNulo(cursor_4c_Par.Numeros, "")), ;
                            "-Chq:" + ALLTRIM(cursor_4c_Par.Numeros), "")

                        IF THIS.this_nConfigHistorico = 2
                            *-- Historico composto (TpHists do cliente do titulo)
                            IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                    "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_Pit.Contas) + ;
                                    " ORDER BY CContabs", "cursor_4c_CliPit") < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                    "Falha na Conex" + CHR(227) + "o (crSigCdCli - 6)" + CHR(13) + CapturarErroSQL()
                                MsgErro(THIS.this_cMensagemErro, "")
                                USE IN cursor_4c_Par
                                USE IN cursor_4c_CliOrigem
                                USE IN cursor_4c_CliDestino2
                                USE IN cursor_4c_MvCcrNop
                                USE IN cursor_4c_MvCcr1
                                USE IN cursor_4c_Pit
                                RETURN -1
                            ENDIF

                            IF SQLEXEC(gnConnHandle, "SELECT CContabs, IClis, RClis, Razaos, Cpfs, TpHists, " + ;
                                    "Hists FROM SigCdCli WHERE IClis = " + EscaparSQL(cursor_4c_MvCcr1.Contems) + ;
                                    " ORDER BY CContabs", "cursor_4c_CliContem") < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!" + CHR(13) + ;
                                    "Falha na Conex" + CHR(227) + "o (TmpCliCONTEMS)" + CHR(13) + CapturarErroSQL()
                                MsgErro(THIS.this_cMensagemErro, "")
                                USE IN cursor_4c_CliPit
                                USE IN cursor_4c_Par
                                USE IN cursor_4c_CliOrigem
                                USE IN cursor_4c_CliDestino2
                                USE IN cursor_4c_MvCcrNop
                                USE IN cursor_4c_MvCcr1
                                USE IN cursor_4c_Pit
                                RETURN -1
                            ENDIF

                            loc_cHists = PROPER(SUBSTR(par_cOperacao, 1, 3))
                            loc_nOrdemHist = 1
                            loc_cHist = ""

                            DO CASE
                                CASE cursor_4c_CliPit.TpHists = 1
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                                    IF !EMPTY(TratarNulo(cursor_4c_CliPit.Hists, ""))
                                        loc_cHist = ALLTRIM(cursor_4c_CliPit.Hists) + " " + ALLTRIM(cursor_4c_MvCcrNop.Nfs)
                                    ELSE
                                        loc_cHist = ALLTRIM(cursor_4c_MvCcrNop.Nfs)
                                    ENDIF
                                    loc_nOrdemHist = 1
                                CASE cursor_4c_CliPit.TpHists = 2
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                                    IF !EMPTY(TratarNulo(cursor_4c_CliPit.Hists, ""))
                                        loc_cHist = ALLTRIM(cursor_4c_CliPit.Hists) + " " + ALLTRIM(cursor_4c_MvCcrNop.Titulos)
                                    ELSE
                                        loc_cHist = ALLTRIM(cursor_4c_MvCcrNop.Titulos)
                                    ENDIF
                                    loc_nOrdemHist = 1
                                CASE cursor_4c_CliPit.TpHists = 3
                                    IF !EMPTY(TratarNulo(cursor_4c_CliPit.Hists, ""))
                                        loc_cHist = ALLTRIM(cursor_4c_CliPit.Hists) + " " + SUBSTR(DTOC(cursor_4c_MvCcrNop.Datas), 4, 7)
                                    ELSE
                                        loc_cHist = SUBSTR(DTOC(cursor_4c_MvCcrNop.Datas), 4, 7)
                                    ENDIF
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                                    loc_nOrdemHist = 2
                                CASE cursor_4c_CliPit.TpHists = 4
                                    *-- nenhum
                                OTHERWISE
                                    loc_cHist  = ALLTRIM(cursor_4c_MvCcrNop.Nfs)
                                    loc_cHists = ALLTRIM(SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliContem.Razaos, "")), ;
                                        TratarNulo(cursor_4c_CliContem.RClis, ""), TratarNulo(cursor_4c_CliContem.Razaos, "")), 1, 20))
                            ENDCASE

                            DO CASE
                                CASE loc_nOrdemHist = 1
                                    loc_cHists = PROPER(SUBSTR(par_cOperacao, 1, 3)) + " " + loc_cHist + "-" + ;
                                        ALLTRIM(loc_cHists) + " " + loc_cNumeroCheque + " "
                                CASE loc_nOrdemHist = 2
                                    loc_cHists = PROPER(SUBSTR(par_cOperacao, 1, 3)) + " " + ALLTRIM(loc_cHists) + ;
                                        " " + loc_cHist + " " + loc_cNumeroCheque + " "
                            ENDCASE

                            USE IN cursor_4c_CliPit
                            USE IN cursor_4c_CliContem
                        ELSE
                            loc_cHists = SUBSTR(ALLTRIM(cursor_4c_MvCcrNop.Emps) + "-" + ;
                                TratarNulo(cursor_4c_MvCcrNop.Hists, "") + TratarNulo(cursor_4c_MvCcrNop.Hist2s, ""), 1, 70)
                        ENDIF

                        loc_cHists = STRTRAN(STRTRAN(STRTRAN(loc_cHists, CHR(1), ""), CHR(13), ""), CHR(10), "")

                        SELECT cursor_4c_MovAux
                        APPEND BLANK
                        REPLACE Contas WITH loc_cContabs, ;
                                Debs   WITH TRANSFORM(loc_nDebs * 100, "@L 999999999999"), ;
                                Creds  WITH TRANSFORM(loc_nCreds * 100, "@L 999999999999"), ;
                                Docto  WITH ALLTRIM(cursor_4c_MvCcrNop.Titulos), ;
                                Hists  WITH loc_cHists, ;
                                Emps   WITH cursor_4c_MvCcrNop.Emps, ;
                                Cecus  WITH cursor_4c_MvCcrNop.Emps, ;
                                IClis  WITH TratarNulo(cursor_4c_CliOrigem.IClis, ""), ;
                                Razaos WITH SUBSTR(IIF(EMPTY(TratarNulo(cursor_4c_CliOrigem.Razaos, "")), ;
                                            TratarNulo(cursor_4c_CliOrigem.RClis, ""), ;
                                            TratarNulo(cursor_4c_CliOrigem.Razaos, "")), 1, 20), ;
                                Cpfs   WITH TratarNulo(cursor_4c_CliDestino2.Cpfs, ""), ;
                                Cheque WITH loc_cNumeroCheque

                        USE IN cursor_4c_CliOrigem
                        USE IN cursor_4c_CliDestino2
                        USE IN cursor_4c_Par
                    ENDIF
                    SELECT cursor_4c_MvCcrNop
                ENDSCAN
                USE IN cursor_4c_MvCcrNop
            ENDIF

            USE IN cursor_4c_MvCcr1
            SELECT cursor_4c_Pit
        ENDSCAN
        USE IN cursor_4c_Pit

        RETURN loc_nValContra
    ENDFUNC

    *==========================================================================
    * VerificarDiferencas - traducao de:
    *   Select Transacaos, Sum(Val(Debs)/100) As Deb, Sum(Val(Creds)/100) As
    *   Cred From MovAux Group By Transacaos Into Cursor Dif1
    *   Select Transacaos From Dif1 Where Deb <> Cred Into Cursor dif2
    *   Select * From MovAux Where Transacaos In (Select Transacaos From
    *   dif2) Into Cursor diferenca
    * Opera 100% sobre o cursor LOCAL cursor_4c_MovAux (nao usa gnConnHandle -
    * SELECT local do VFP, nao SQLEXEC).
    *==========================================================================
    PROTECTED PROCEDURE VerificarDiferencas()
        IF USED("cursor_4c_Dif1")
            USE IN cursor_4c_Dif1
        ENDIF
        IF USED("cursor_4c_Dif2")
            USE IN cursor_4c_Dif2
        ENDIF
        IF USED("cursor_4c_Diferenca")
            USE IN cursor_4c_Diferenca
        ENDIF

        SELECT Transacaos, SUM(VAL(Debs) / 100) AS Deb, SUM(VAL(Creds) / 100) AS Cred ;
            FROM cursor_4c_MovAux GROUP BY Transacaos INTO CURSOR cursor_4c_Dif1

        SELECT Transacaos FROM cursor_4c_Dif1 WHERE Deb != Cred INTO CURSOR cursor_4c_Dif2

        SELECT * FROM cursor_4c_MovAux WHERE Transacaos IN (SELECT Transacaos FROM cursor_4c_Dif2) ;
            INTO CURSOR cursor_4c_Diferenca

        THIS.this_nTotalDiferencas = RECCOUNT("cursor_4c_Diferenca")
        THIS.this_lPossuiDiferenca = (THIS.this_nTotalDiferencas > 0)

        IF USED("cursor_4c_Dif1")
            USE IN cursor_4c_Dif1
        ENDIF
        IF USED("cursor_4c_Dif2")
            USE IN cursor_4c_Dif2
        ENDIF
    ENDPROC

    *==========================================================================
    * ObterCursorInconsistencias/ObterCursorMovimento/ObterCursorDiferencas -
    * expoem os nomes dos cursores de resultado ao FormSigPrIct, para
    * grid/relatorio de inconsistencias e para a tela de diferencas
    * (equivalente ao "Do Form SigReDif" do legado).
    *==========================================================================
    FUNCTION ObterCursorInconsistencias()
        RETURN "cursor_4c_SemConta"
    ENDFUNC

    FUNCTION ObterCursorMovimento()
        RETURN "cursor_4c_MovAux"
    ENDFUNC

    FUNCTION ObterCursorDiferencas()
        RETURN "cursor_4c_Diferenca"
    ENDFUNC

    *==========================================================================
    * GravarArquivosContabeis - traducao da PARTE DE NEGOCIO do PROCEDURE
    * gravar legado (a parte de UI - habilitar/desabilitar botoes do form -
    * fica no FormSigPrIct). Gera o(s) arquivo(s) texto CTPV*
    * (formato SDF) no diretorio configurado em SigCdPam.DirContabv, um grupo
    * por EmpCont (ver nota de fidelidade do cabecalho: na pratica, com o
    * EmpCont sempre vazio, sai um UNICO arquivo por execucao).
    *==========================================================================
    FUNCTION GravarArquivosContabeis()
        LOCAL loc_lSucesso, loc_oErro, loc_cEmpProc, loc_cNumAux, loc_cNomeArquivo, loc_dDataProc
        LOCAL loc_lGerouArquivo

        loc_lGerouArquivo = .F.

        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_MovAux")
                THIS.this_cMensagemErro = "Cursor de movimento cont" + CHR(225) + "bil n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                MsgErro(THIS.this_cMensagemErro, "")
            ELSE
                IF EMPTY(THIS.this_cDirContabv)
                    THIS.this_cMensagemErro = "Diret" + CHR(243) + "rio Cont" + CHR(225) + "bil (SigCdPam.DirContabv) n" + ;
                        CHR(227) + "o configurado"
                    MsgErro(THIS.this_cMensagemErro, "")
                ELSE
                    SELECT cursor_4c_MovAux
                    SET ORDER TO EmpCont
                    GO TOP

                    IF EOF("cursor_4c_MovAux")
                        loc_lSucesso = .T.
                    ELSE
                        loc_dDataProc = Datas
                        SCAN
                            loc_cEmpProc    = EmpCont
                            loc_cNumAux     = SUBSTR(SYS(3), 5)
                            loc_cNomeArquivo = ALLTRIM(THIS.this_cDirContabv) + "CTPV" + loc_cNumAux + "." + ALLTRIM(cursor_4c_MovAux.EmpCont)

                            IF !FILE(loc_cNomeArquivo)
                                COPY TO (loc_cNomeArquivo) WHILE EmpCont == loc_cEmpProc TYPE SDF
                                SKIP -1
                            ENDIF
                        ENDSCAN
                        loc_lSucesso      = .T.
                        loc_lGerouArquivo = .T.
                    ENDIF

                    SET ORDER TO
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
                CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em GravarArquivosContabeis")
        ENDTRY

        *-- Auditoria da exportacao: registrada FORA do TRY de proposito - o
        *-- arquivo contabil ja esta gravado neste ponto, e uma falha ao
        *-- escrever no LogAuditoria nao pode transformar uma geracao bem
        *-- sucedida em erro para o usuario. So registra quando arquivo foi
        *-- realmente gerado (periodo sem movimento nao gera nada e nao audita).
        IF loc_lSucesso AND loc_lGerouArquivo
            THIS.RegistrarAuditoria("EXPORT")
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * FinalizarProcesso - libera os cursores de resultado (SemConta/MovAux/
    * Diferenca/Grupos/TodosGrupos/Empresas/LoteProc); chamado pelo form ao
    * encerrar a tela (equivalente ao ThisForm.poDataMgr.Release do Release
    * legado, restrito aos cursores que este BO controla).
    *==========================================================================
    PROCEDURE FinalizarProcesso()
        LOCAL loc_aCursores, loc_nI
        loc_aCursores = "cursor_4c_SemConta,cursor_4c_MovAux,cursor_4c_Diferenca,cursor_4c_Dif1," + ;
            "cursor_4c_Dif2,cursor_4c_Grupos,cursor_4c_TodosGrupos,cursor_4c_Empresas,cursor_4c_LoteProc,cursor_4c_MvCcr"

        FOR loc_nI = 1 TO GETWORDCOUNT(loc_aCursores, ",")
            IF USED(GETWORDNUM(loc_aCursores, loc_nI, ","))
                USE IN (GETWORDNUM(loc_aCursores, loc_nI, ","))
            ENDIF
        ENDFOR
    ENDPROC

    *==========================================================================
    * LimparLinhaCarregada - zera as propriedades da linha corrente. Chamado
    * por CarregarDoCursor() ANTES de ler, para que colunas ausentes no cursor
    * recebido nao fiquem com o valor da leitura anterior (o BO vive enquanto
    * a tela estiver aberta e o usuario alterna entre as grades de
    * lancamentos, inconsistencias e diferencas).
    *==========================================================================
    PROTECTED PROCEDURE LimparLinhaCarregada()
        THIS.this_cAnoFis     = ""
        THIS.this_cDatas      = ""
        THIS.this_cContas     = ""
        THIS.this_cDebs       = ""
        THIS.this_cCreds      = ""
        THIS.this_cDocto      = ""
        THIS.this_cHists      = ""
        THIS.this_cEmpCont    = ""
        THIS.this_cNumSeq     = ""
        THIS.this_cNums       = ""
        THIS.this_cLams       = ""
        THIS.this_dData       = {}
        THIS.this_cValor      = ""
        THIS.this_cCecus      = ""
        THIS.this_cEmps       = ""
        THIS.this_cTransacaos = ""
        THIS.this_cCpfs       = ""
        THIS.this_cIClis      = ""
        THIS.this_cRazaos     = ""
        THIS.this_cCheque     = ""
        THIS.this_dDataS      = {}
        THIS.this_nValors     = 0
        THIS.this_cOcors      = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - carrega a linha CORRENTE do cursor recebido nas
    * propriedades da linha (acima). Atende os TRES cursores de resultado que
    * este BO publica, que tem layouts diferentes:
    *
    *   cursor_4c_MovAux    (lancamentos contabeis - MovAux do legado)
    *   cursor_4c_Diferenca (mesmo layout de MovAux, filtrado por transacao
    *                        desbalanceada)
    *   cursor_4c_SemConta  (inconsistencias - SemConta do legado)
    *
    * Por isso cada coluna eh testada com TYPE(<alias>.<coluna>) antes de ser
    * lida: a coluna que nao existe no cursor recebido simplesmente nao eh
    * carregada (e fica zerada pelo LimparLinhaCarregada acima). PEMSTATUS NAO
    * serve aqui - ele exige um OBJETO no 1o argumento e dispara o erro 11 do
    * VFP9 quando recebe nome de cursor.
    *
    * A colisao Datas/DataS eh resolvida pelo VARTYPE da coluna, nao pelo nome:
    * em MovAux "Datas" eh C(8) (data ja formatada para o arquivo contabil) e
    * em SemConta "DataS" eh D (data do movimento); para o VFP os dois nomes
    * sao o MESMO campo, entao decidir pelo nome carregaria o valor no tipo
    * errado e estouraria "Operator/operand type mismatch" no primeiro uso.
    *
    * Parametro: par_cAliasCursor - nome do cursor posicionado na linha desejada
    * Retorno  : .T. quando havia linha para carregar; .F. quando o cursor nao
    *            existe, esta vazio ou esta em EOF/BOF.
    *==========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAliasAnterior

        loc_lSucesso = .F.

        THIS.LimparLinhaCarregada()
        THIS.this_cCursorCarregado = ""

        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor n" + CHR(227) + "o informado para CarregarDoCursor"
        ELSE
            IF !USED(par_cAliasCursor)
                THIS.this_cMensagemErro = "Cursor [" + ALLTRIM(par_cAliasCursor) + "] n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel"
            ELSE
                *-- Preserva o alias corrente: o form chama este metodo a partir
                *-- de handlers de grade e devolver o foco de area errado faz o
                *-- SCAN/REPLACE seguinte agir no cursor errado.
                loc_cAliasAnterior = ALIAS()

                SELECT (par_cAliasCursor)

                IF RECCOUNT() = 0 OR EOF() OR BOF()
                    THIS.this_cMensagemErro = "Nenhuma linha selecionada em [" + ALLTRIM(par_cAliasCursor) + "]"
                ELSE
                    *-- Colunas do cursor de LANCAMENTOS (MovAux/Diferenca)
                    IF TYPE(par_cAliasCursor + ".AnoFis") = "C"
                        THIS.this_cAnoFis = ALLTRIM(TratarNulo(AnoFis, ""))
                    ENDIF

                    *-- Datas (C, lancamentos) x DataS (D, inconsistencias):
                    *-- mesmo nome para o VFP, tipos diferentes - decidir pelo VARTYPE.
                    DO CASE
                        CASE TYPE(par_cAliasCursor + ".Datas") = "C"
                            THIS.this_cDatas = ALLTRIM(TratarNulo(Datas, ""))
                        CASE TYPE(par_cAliasCursor + ".Datas") = "D"
                            THIS.this_dDataS = TratarNulo(Datas, {})
                        CASE TYPE(par_cAliasCursor + ".Datas") = "T"
                            THIS.this_dDataS = ConverterParaData(TratarNulo(Datas, {}))
                    ENDCASE

                    IF TYPE(par_cAliasCursor + ".Contas") = "C"
                        THIS.this_cContas = ALLTRIM(TratarNulo(Contas, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Debs") = "C"
                        THIS.this_cDebs = TratarNulo(Debs, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Creds") = "C"
                        THIS.this_cCreds = TratarNulo(Creds, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Docto") = "C"
                        THIS.this_cDocto = ALLTRIM(TratarNulo(Docto, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Hists") = "C"
                        THIS.this_cHists = TratarNulo(Hists, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".EmpCont") = "C"
                        THIS.this_cEmpCont = ALLTRIM(TratarNulo(EmpCont, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".NumSeq") = "C"
                        THIS.this_cNumSeq = ALLTRIM(TratarNulo(NumSeq, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Nums") = "C"
                        THIS.this_cNums = ALLTRIM(TratarNulo(Nums, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Lams") = "C"
                        THIS.this_cLams = ALLTRIM(TratarNulo(Lams, ""))
                    ENDIF
                    DO CASE
                        CASE TYPE(par_cAliasCursor + ".Data") = "D"
                            THIS.this_dData = TratarNulo(Data, {})
                        CASE TYPE(par_cAliasCursor + ".Data") = "T"
                            THIS.this_dData = ConverterParaData(TratarNulo(Data, {}))
                    ENDCASE
                    IF TYPE(par_cAliasCursor + ".Valor") = "C"
                        THIS.this_cValor = TratarNulo(Valor, "")
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Cecus") = "C"
                        THIS.this_cCecus = ALLTRIM(TratarNulo(Cecus, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Emps") = "C"
                        THIS.this_cEmps = ALLTRIM(TratarNulo(Emps, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Transacaos") = "C"
                        THIS.this_cTransacaos = ALLTRIM(TratarNulo(Transacaos, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Cpfs") = "C"
                        THIS.this_cCpfs = ALLTRIM(TratarNulo(Cpfs, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".IClis") = "C"
                        THIS.this_cIClis = ALLTRIM(TratarNulo(IClis, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Razaos") = "C"
                        THIS.this_cRazaos = ALLTRIM(TratarNulo(Razaos, ""))
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Cheque") = "C"
                        THIS.this_cCheque = ALLTRIM(TratarNulo(Cheque, ""))
                    ENDIF

                    *-- Colunas exclusivas do cursor de INCONSISTENCIAS (SemConta).
                    *-- Valors eh N(12,2) aqui (valor de verdade), diferente do
                    *-- Valor C(12) dos lancamentos.
                    IF TYPE(par_cAliasCursor + ".Valors") = "N"
                        THIS.this_nValors = TratarNulo(Valors, 0)
                    ENDIF
                    IF TYPE(par_cAliasCursor + ".Ocors") = "C"
                        THIS.this_cOcors = ALLTRIM(TratarNulo(Ocors, ""))
                    ENDIF

                    THIS.this_cCursorCarregado = ALLTRIM(par_cAliasCursor)
                    THIS.this_cMensagemErro    = ""
                    loc_lSucesso = .T.
                ENDIF

                *-- Devolve o alias que estava corrente antes da leitura
                IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
                    SELECT (loc_cAliasAnterior)
                ENDIF
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - chave de identificacao usada pelo log de auditoria
    * (BusinessBase.RegistrarAuditoria).
    *
    * Este processo nao grava registro em tabela, entao nao existe chave
    * primaria de persistencia; o que identifica uma execucao eh o PERIODO
    * processado, e o que identifica um lancamento dentro dela eh a
    * composicao Empresa + Transacao + Sequencia que o proprio legado usa
    * para amarrar debito e credito (ver VerificarDiferencas).
    *
    * Montagem com separador "/" de proposito: esta chave alimenta
    * LogAuditoria.ChaveRegistro (varchar(100)) e eh lida por gente, nao
    * comparada com coluna char(N) de largura fixa - nao eh chave posicional,
    * entao ALLTRIM nas partes aqui eh correto e nao quebra busca nenhuma.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        LOCAL loc_cChave, loc_cPeriodo

        loc_cPeriodo = DTOC(THIS.this_dDataI) + "-" + DTOC(THIS.this_dDataF)

        IF !EMPTY(THIS.this_cTransacaos) OR !EMPTY(THIS.this_cNumSeq)
            loc_cChave = loc_cPeriodo + "/" + ALLTRIM(THIS.this_cEmps) + "/" + ;
                ALLTRIM(THIS.this_cTransacaos) + "/" + ALLTRIM(THIS.this_cNumSeq)
        ELSE
            loc_cChave = loc_cPeriodo
        ENDIF

        *-- LogAuditoria.ChaveRegistro eh varchar(100)
        RETURN LEFT(loc_cChave, 100)
    ENDFUNC

    *==========================================================================
    * RegistrarAuditoria - registra no LogAuditoria a execucao do processo.
    *
    * Sobrescreve a versao de BusinessBase por UM motivo: a base grava
    * THIS.this_cTabela na coluna Tabela, e aqui this_cTabela eh vazio de
    * proposito (o processo nao tem tabela principal - ver nota de arquitetura
    * no cabecalho). Gravar string vazia numa coluna NOT NULL funciona mas
    * deixa o log inutil, entao o identificador do PROCESSO entra no lugar.
    *
    * Colunas NOT NULL de LogAuditoria (regra #22 - lista conferida no
    * schema): Tabela varchar(100), Operacao varchar(10), ChaveRegistro
    * varchar(100), Usuario varchar(50), DataHora datetime. Id eh IDENTITY.
    * DadosAnteriores/DadosNovos/IP/Estacao aceitam NULL e ficam de fora.
    * DataHora resolve no servidor, via GETDATE() - nunca formatando um
    * DATETIME do VFP no cliente (o formatador de data recusa o tipo T e
    * devolveria o literal NULL, que a coluna NOT NULL rejeita).
    *
    * Parametro: par_cOperacao - "EXPORT" na geracao do arquivo contabil
    *            (cabe em varchar(10); LEFT garante o limite).
    *==========================================================================
    PROTECTED FUNCTION RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_lSucesso, loc_cOperacao

        loc_lSucesso = .F.
        loc_cChave   = THIS.ObterChavePrimaria()
        loc_cOperacao = IIF(VARTYPE(par_cOperacao) = "C", ALLTRIM(par_cOperacao), "EXPORT")

        IF EMPTY(loc_cChave) OR TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            loc_lSucesso = .F.
        ELSE
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) VALUES (" + ;
                EscaparSQL(LEFT("SigPrIct - Integracao Contabil", 100)) + ", " + ;
                EscaparSQL(LEFT(loc_cOperacao, 10)) + ", " + ;
                EscaparSQL(LEFT(loc_cChave, 100)) + ", " + ;
                EscaparSQL(LEFT(IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA"), 50)) + ;
                ", GETDATE())"

            loc_lSucesso = (SQLEXEC(gnConnHandle, loc_cSQL) >= 0)
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE