*------------------------------------------------------------------------------
* SigOpVdiBO - Business Object de "Pesquisa Detalhada" (vendas x cadastro)
* Baseado no formulario legado SIGOPVDI (SigOpVdi.SCX)
*
* Form OPERACIONAL de CONSULTA (sem INSERT/UPDATE/DELETE no legado): o
* Init() legado so monta cursores auxiliares de filtro (empresas, tipos de
* operacao, grande grupo, grupo de produtos, operacoes, moedas) e os
* resultados finais (crPgRes01/crPgRes02/crPgRes03) sao populados por
* Processamento() a partir dos filtros da Pagina 1. Nao ha tabela/PK
* principal - this_cTabela/this_cCampoChave ficam vazios de proposito.
*------------------------------------------------------------------------------
DEFINE CLASS SigOpVdiBO AS BusinessBase

    *-- Filtros de periodo (Get_DcI / Get_DcF)
    this_dDataIni = {}
    this_dDataFim = {}

    *-- Filtro de moeda de conversao (getCMoes / getDMoes)
    this_cMoeda     = ""
    this_cDescMoeda = ""

    *-- Filtro de grupo de venda / colecao (getCdGrVda / getDsGrVda)
    this_cGrupoVenda     = ""
    this_cDescGrupoVenda = ""

    *-- Filtro de subgrupo (get_cd_sgrupo / get_ds_sgrupo)
    this_cSubGrupo     = ""
    this_cDescSubGrupo = ""

    *-- Configuracao de larguras/colunas da grade (getCfgGrade - uso restrito ao usuario 4CONTROL)
    this_cConfigGrade = ""

    *-- Listas de codigos marcados nas grades de filtro da Pagina 1 (concatenadas
    *-- separadas por virgula, alimentadas a partir de crSigCdEmp/crTpOpe/
    *-- crGrdGpr/crGrdGru/crOpera - usadas para montar o WHERE de Processamento)
    this_cFiltroEmpresas     = ""
    this_cFiltroTipos        = ""
    this_cFiltroGrandeGrupo  = ""
    this_cFiltroGrupoProduto = ""
    this_cFiltroOperacoes    = ""

    *-- optValor1 (Pagina de resultados - ButtonCount=3): indice 1-based do
    *-- OptionGroup, nunca booleano (regra #188)
    this_nTipoValor = 1

    *==========================================================================
    * REGISTRO CORRENTE da grade de resultados (o "crPgRes01" sobre o qual o
    * legado opera depois que o usuario escolhe uma linha).
    *
    * No SCX legado SEIS pontos diferentes leem a linha corrente DIRETO do
    * cursor (grdDados1.AfterRowColChange, ImgFigJpg.Click, btnProduto.Click,
    * CmdConta.Click, SubNiveis.Click e cmdOperacao.btnOperacao.Valid), cada um
    * repetindo o seu proprio Nvl()/Empty(). Aqui essa leitura fica concentrada
    * em CarregarDoCursor(), que eh a fonte UNICA: o Form le estas properties e
    * nao toca no cursor.
    *==========================================================================
    this_cRegEmpresa         = ""
    this_cRegMovimentacao    = ""
    this_nRegNumero          = 0
    this_nRegItem            = 0
    this_dRegDataVenda       = {}
    this_cRegCodigoItem      = ""
    this_cRegDescItem        = ""
    this_cRegEquivalente     = ""
    this_cRegGdeGrupo        = ""
    this_cRegGrupo           = ""
    this_cRegSubGrupo        = ""
    this_cRegCodCliente      = ""
    this_cRegNomeCliente     = ""
    this_cRegCodVendedora    = ""
    this_cRegObsItem         = ""
    this_nRegDescAcres       = 0
    this_nRegVendaCadastroR  = 0
    this_mRegImagem          = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BusinessObject. Form de consulta pura: nao ha
    * tabela/campo-chave (confirmado em analise.json: "tabela": "", "cursorName": "").
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""
            THIS.AplicarFiltrosPadrao()
            THIS.CriarCursoresResultado()
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * AplicarFiltrosPadrao - valores iniciais dos filtros, transcritos do
    * bloco de defaults do Init do SCX legado (dentro do "If (.poDataMgr.pnIdconn > 0)"):
    *
    *   .pgfPrincipal.pgFiltros.getDcI.Value = Date()
    *   .pgfPrincipal.pgFiltros.getDcF.Value = Date()
    *
    * A moeda padrao (getCMoes/getDMoes) vem do primeiro registro de
    * "Select CMoes, DMoes, nOrdRels From SigCdMoe Order By nOrdRels" (SQL,
    * depende de gnConnHandle) - carregada por metodo proprio em fase
    * posterior, nao aqui. Demais filtros (empresas/tipos/grande grupo/
    * grupo/operacoes/subgrupo) nascem vazios, que no legado significa
    * "nenhuma restricao adicional alem do que a grade de marcacao define".
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE AplicarFiltrosPadrao()
        THIS.this_dDataIni = DATE()
        THIS.this_dDataFim = DATE()
        THIS.this_cMoeda     = ""
        THIS.this_cDescMoeda = ""
        THIS.this_cGrupoVenda     = ""
        THIS.this_cDescGrupoVenda = ""
        THIS.this_cSubGrupo     = ""
        THIS.this_cDescSubGrupo = ""
        THIS.this_cConfigGrade = ""
        THIS.this_cFiltroEmpresas     = ""
        THIS.this_cFiltroTipos        = ""
        THIS.this_cFiltroGrandeGrupo  = ""
        THIS.this_cFiltroGrupoProduto = ""
        THIS.this_cFiltroOperacoes    = ""
        THIS.this_nTipoValor = 1

        RETURN .T.
    ENDPROC

    *==========================================================================
    * METODOS DE DADOS (equivalentes de CRUD para este form de CONSULTA)
    *
    * SIGOPVDI nao tem INSERT/UPDATE/DELETE no legado (confirmado em
    * analise.json: "tabela": "" e no dump do codigo fonte, que so Le dados
    * para montar o relatorio). Por isso Inserir()/Atualizar()/
    * ExecutarExclusao() NAO sao sobrescritos aqui - o comportamento padrao
    * herdado de BusinessBase ja eh o correto (recusar a operacao).
    *
    * Os metodos abaixo transcrevem, com a mesma estrutura e nomes do
    * legado, as rotinas de carga/filtro/calculo que sao a "logica de
    * negocio" real deste form (SigOpVdi.SCX):
    *   acertacolunas    -> fica no Form (Fase 3+, eh persistencia de Grid)
    *   buscaantigos     -> THIS.BuscarDadosAntigos()
    *   filgdegrupo      -> THIS.FiltrarGrandeGrupo()
    *   filgrupo         -> THIS.FiltrarGrupo()
    *   flimpa           -> fica no Form (Fase 3+, eh formatacao de exportacao)
    *   gerartxt/gerarxls-> ficam no Form (Fase 3+, sao exportacao/UI)
    *   gradepadrao      -> fica no Form (Fase 3+, eh largura de Grid)
    *   limpaemps        -> THIS.LimparEmpresasSemAcesso() (ver nota na Processar)
    *   montaemps        -> THIS.MontarFiltroEmpresas()
    *   montagrades      -> fica no Form (Fase 3+, eh bind de Grid)
    *   montapgres01     -> THIS.MontarResultadoDetalhe()
    *   montapgres02     -> THIS.MontarResultadoPorEmpresa()
    *   montapgres03     -> THIS.MontarResultadoPorVendedora()
    *   processamento    -> THIS.Processar() (orquestrador, sem UI)
    *   Init (SCX)       -> THIS.CarregarFiltrosIniciais()
    *   Load (SCX)       -> THIS.CriarCursoresResultado() (chamado no Init do BO)
    *
    * Nomes de cursor (CREATE CURSOR/SQLEXEC) usados por estes metodos -
    * MANTER estes nomes ao ligar os Grids no Form (Fase 3+):
    *   cursor_4c_TiposOperacao  (crTpOpe)   - nMarcas, CCodigos, Codigos, CDescricaos
    *   cursor_4c_GrandeGrupo    (crGrdGpr)  - nMarcas, Codigos, CDescricaos
    *   cursor_4c_GrupoProduto   (crGrdGru)  - nMarcas, Mercs, Codigos, CDescricaos
    *   cursor_4c_Operacoes      (crOpera)   - nMarcas, * (SigCdOpe), inclui Dopes/TipoOps
    *   cursor_4c_Empresas       (crSigCdEmp)- Imps, cemps, razas
    *   cursor_4c_GrupoAcesso    (crSigCdGre)- GruEmps, Tipos (paridade, sem consumo identificado)
    *   cursor_4c_Bruto          (crCursor1) - resultado da consulta principal
    *   cursor_4c_Detalhe        (crPgRes01) - grade "Detalhamento dos Produtos"
    *   cursor_4c_TotalEmpresa   (crPgRes02) - grade "Totais por Empresa"
    *   cursor_4c_TotalVendedora (crPgRes03) - grade "Totais por Vendedora"
    *==========================================================================

    *--------------------------------------------------------------------------
    * CriarCursoresResultado - Cria os cursores de resultado (equivalente ao
    * metodo Load() do SCX legado, que roda automaticamente apos o Init).
    * Chamado pelo proprio Init() deste BO - nao depende de conexao SQL.
    *--------------------------------------------------------------------------
    PROCEDURE CriarCursoresResultado()
        IF USED("cursor_4c_Detalhe")
            USE IN cursor_4c_Detalhe
        ENDIF
        IF USED("cursor_4c_TotalEmpresa")
            USE IN cursor_4c_TotalEmpresa
        ENDIF
        IF USED("cursor_4c_TotalVendedora")
            USE IN cursor_4c_TotalVendedora
        ENDIF

        *-- SigMvCab.Datas (origem de Data_Venda, SigOpVdiBO.prg:1179) e
        *-- NULLABLE no schema (docs/schema.sql) - sem SET NULL ON a
        *-- INSERT INTO...FROM MEMVAR (linha 822) estoura "Field DATA_VENDA
        *-- does not accept null values" quando a venda vem sem data.
        SET NULL ON
        CREATE CURSOR cursor_4c_Detalhe (Ordem C(1), Filtro N(1), Empresa C(3), Movimentacao C(20), ;
            Numero N(6), Data_Venda D, Codigo_Vendedora C(10), Item N(10), Tipo C(1), ;
            Codigo_Item C(14), Desc_Item C(40), Obs_Item M, Quantidade N(16,2), ;
            Val_Unitario N(16,2), Total N(16,2), Total_Geral N(16,2), Moeda C(3), ;
            Operacao C(1), Barras N(14), Gde_Grupo C(3), Grupo C(3), SubGrupo C(30), ;
            Custo_Cadastro N(16,2), Moe_Cus_Cadastro C(3), Markup N(16,2), Venda_Cadastro N(16,2), ;
            Moe_Vda_Cadastro C(3), Imagem M, Tamanho C(4), Cor C(4), Cod_Cliente C(10), ;
            Nome_Cliente C(50), Cod_Fornecedor C(10), Nome_Fornecedor C(50), Tkt_Medio N(16,2), ;
            Ref_Fornecedor C(20), Valor_Diferenca N(16,2), Perc_Diferenca N(16,2), Pct_Dif_Chr C(20), ;
            Parcelas N(3), Cond_Pagto C(100), Venda_CadastroR N(16,2), Desc_Acres N(16,2), ;
            Local_Itn C(10), Equivalente C(14), Nome_Vendedora C(40), Categoria C(6), ;
            Desc_Categoria C(40), Descritivo C(45), Local C(10), Qtde N(12,0), Colecao C(60), ;
            Destino C(3), ContaOrigem C(10), Tam_De C(3), Tam_Para C(3))
        SET NULL OFF

        SELECT cursor_4c_Detalhe
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro = 1 OR (Perc_Diferenca > 0 AND Filtro <> 3) TAG Ordem1
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro = 2 OR (Perc_Diferenca < 0 AND Filtro <> 3) TAG Ordem2
        INDEX ON Empresa + Ordem + DTOS(Data_Venda) + Movimentacao + STR(Numero, 6) + STR(Item, 10) ;
            FOR Filtro <> 1 AND Filtro <> 2 TAG Ordem3

        SELECT * FROM cursor_4c_Detalhe INTO CURSOR cursor_4c_TotalEmpresa READWRITE
        SELECT cursor_4c_TotalEmpresa
        INDEX ON Empresa + Ordem + Movimentacao TAG Ordem

        SELECT * FROM cursor_4c_Detalhe INTO CURSOR cursor_4c_TotalVendedora READWRITE
        SELECT cursor_4c_TotalVendedora
        INDEX ON Empresa + Ordem + Codigo_Vendedora TAG Ordem

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarFiltrosIniciais - Popula os cursores das grades de filtro da
    * Pagina 1 (equivalente ao bloco SQL do Init() do SCX legado). Depende
    * de gnConnHandle - o Form deve chamar isto fora do modo de teste de UI
    * (gb_4c_ValidandoUI), igual aos demais forms do projeto.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarFiltrosIniciais()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        *-- 1) Tipos de Operacao (crTpOpe) - nasce com nMarcas = 0
        IF loc_lResultado
            loc_cSQL = "SELECT Codigos, Descrs, GerGdmis FROM SigCdTom"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TiposOpBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Tipos de Opera" + CHR(231) + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_TiposOperacao")
                    USE IN cursor_4c_TiposOperacao
                ENDIF
                SELECT 0 AS nMarcas, STR(a.Codigos, 2) AS CCodigos, a.Codigos, ;
                       PADR(STR(a.Codigos, 2) + "-" + a.Descrs, 50) AS CDescricaos ;
                  FROM cursor_4c_TiposOpBruto a ;
                 ORDER BY 2 ;
                  INTO CURSOR cursor_4c_TiposOperacao READWRITE
                USE IN cursor_4c_TiposOpBruto
            ENDIF
        ENDIF

        *-- 2) Grande Grupo de Produtos (crGrdGpr) - nasce com nMarcas = 1
        IF loc_lResultado
            loc_cSQL = "SELECT Codigos, Descs FROM SigCdGpr"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GdeGrupoBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Grande Grupo de Produtos." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_GrandeGrupo")
                    USE IN cursor_4c_GrandeGrupo
                ENDIF
                SELECT 1 AS nMarcas, a.Codigos, a.Codigos + "-" + a.Descs AS CDescricaos ;
                  FROM cursor_4c_GdeGrupoBruto a ;
                 ORDER BY 2 ;
                  INTO CURSOR cursor_4c_GrandeGrupo READWRITE
                USE IN cursor_4c_GdeGrupoBruto
            ENDIF
        ENDIF

        *-- 3) Grupo de Produtos (crGrdGru) - nasce com nMarcas = 1
        IF loc_lResultado
            loc_cSQL = "SELECT Mercs, CGrus AS Codigos, DGrus AS Descs FROM SigCdGrp"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Grupo de Produtos." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_GrupoProduto")
                    USE IN cursor_4c_GrupoProduto
                ENDIF
                SELECT 1 AS nMarcas, a.Mercs, a.Codigos, a.Codigos + "-" + a.Descs AS CDescricaos ;
                  FROM cursor_4c_GrupoBruto a ;
                 ORDER BY 2 ;
                  INTO CURSOR cursor_4c_GrupoProduto READWRITE
                USE IN cursor_4c_GrupoBruto
            ENDIF
        ENDIF

        *-- 4) Operacoes (crOpera) - nasce com nMarcas = 0
        *-- Cursor de SQLEXEC nasce SOMENTE-LEITURA: a Column1 deste cursor
        *-- hospeda um CheckBox (grd_4c_Operacoes) e os handlers de marcacao
        *-- fazem REPLACE/UPDATE em nMarcas. Por isso o SQLEXEC vai para um
        *-- alias TEMPORARIO e o cursor final eh convertido com READWRITE,
        *-- igual aos itens 1 a 3 acima.
        IF loc_lResultado
            IF USED("cursor_4c_OperacoesBruto")
                USE IN cursor_4c_OperacoesBruto
            ENDIF
            loc_cSQL = "SELECT 0 AS nMarcas, * FROM SigCdOpe"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OperacoesBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Opera" + CHR(231) + CHR(245) + "es." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Operacoes")
                    USE IN cursor_4c_Operacoes
                ENDIF
                SELECT * ;
                  FROM cursor_4c_OperacoesBruto ;
                  INTO CURSOR cursor_4c_Operacoes READWRITE
                USE IN cursor_4c_OperacoesBruto
                SELECT cursor_4c_Operacoes
                INDEX ON Dopes TAG Dopes
                INDEX ON TipoOps TAG IdxTipoOps
                GO TOP
            ENDIF
        ENDIF

        *-- 5) Empresas (crSigCdEmp) - restrito pelo acesso do usuario
        *-- (SigCdAce), exceto para o usuario tecnico 4CONTROL
        IF loc_lResultado
            *-- Mesma conversao para READWRITE do item 4: a Column1 de
            *-- grd_4c_Empresas eh um CheckBox EDITAVEL (no legado o
            *-- montagrades deixa grdEmps.Column1.ReadOnly = .F.) e o
            *-- cmg_4c_Empresas / chk_4c_Ck_MarcaEmp fazem UPDATE em Imps.
            *-- "0 AS Imps" (numerico), nao CONVERT(bit,0): CheckBox.Value
            *-- eh NUMERICO - bit chegaria como Logico e o IIF/comparacao
            *-- com 1 dos handlers estouraria type mismatch.
            IF USED("cursor_4c_EmpresasBruto")
                USE IN cursor_4c_EmpresasBruto
            ENDIF
            loc_cSQL = "SELECT 0 AS Imps, cemps, razas FROM SigCdEmp ORDER BY cemps"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Empresas." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Empresas")
                    USE IN cursor_4c_Empresas
                ENDIF
                SELECT * ;
                  FROM cursor_4c_EmpresasBruto ;
                  INTO CURSOR cursor_4c_Empresas READWRITE
                USE IN cursor_4c_EmpresasBruto
                IF UPPER(ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))) <> "4CONTROL"
                    loc_cSQL = "SELECT 0 AS Imps, a.emps AS cemps, b.razas " + ;
                               "FROM SigCdAce a INNER JOIN SigCdEmp b ON a.emps = b.cemps " + ;
                               "WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpresasAcesso")
                    IF loc_nResultado < 0
                        MsgErro("Falha ao carregar Empresas por acesso." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                        loc_lResultado = .F.
                    ELSE
                        IF RECCOUNT("cursor_4c_EmpresasAcesso") > 0
                            SELECT cursor_4c_Empresas
                            ZAP
                            SELECT cursor_4c_EmpresasAcesso
                            SCAN
                                SCATTER MEMVAR
                                SELECT cursor_4c_Empresas
                                APPEND BLANK
                                GATHER MEMVAR
                                SELECT cursor_4c_EmpresasAcesso
                            ENDSCAN
                        ENDIF
                        USE IN cursor_4c_EmpresasAcesso
                    ENDIF
                ENDIF
                IF loc_lResultado
                    SELECT cursor_4c_Empresas
                    INDEX ON cemps TAG cemps
                    GO TOP
                ENDIF
            ENDIF
        ENDIF

        *-- 6) Moeda padrao de conversao - primeiro registro de SigCdMoe
        *-- ordenado por nOrdRels
        IF loc_lResultado
            loc_cSQL = "SELECT CMoes, DMoes, nOrdRels FROM SigCdMoe ORDER BY nOrdRels"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MoedaBruto")
            IF loc_nResultado < 0
                MsgErro("Falha ao carregar Moeda padr" + CHR(227) + "o." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                IF RECCOUNT("cursor_4c_MoedaBruto") > 0
                    GO TOP IN cursor_4c_MoedaBruto
                    THIS.this_cMoeda     = ALLTRIM(cursor_4c_MoedaBruto.CMoes)
                    THIS.this_cDescMoeda = ALLTRIM(cursor_4c_MoedaBruto.DMoes)
                ENDIF
                USE IN cursor_4c_MoedaBruto
            ENDIF
        ENDIF

        *-- 7) Grupos de empresa com acesso (crSigCdGre) - mantido para
        *-- paridade com o Init legado; sem consumo direto identificado no
        *-- dump deste form (possivelmente usado pela classe-base do VCX).
        *-- Falha aqui NAO bloqueia o carregamento dos demais filtros.
        IF loc_lResultado
            IF USED("cursor_4c_GrupoAcesso")
                USE IN cursor_4c_GrupoAcesso
            ENDIF
            loc_cSQL = "SELECT DISTINCT a.grupo AS GruEmps, b.tipos " + ;
                       "FROM SigCdEmp a, SigCdGre b " + ;
                       "WHERE a.grupo = b.grupo AND a.cemps IN " + ;
                       "(SELECT g.emps FROM SigCdAce g WHERE g.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoAcesso")
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarFiltroEmpresas - Equivalente a montaemps() do legado. Le o
    * cursor de empresas marcadas (Imps <> 0) e devolve o fragmento SQL
    * (" AND c.Emps = ..." / " AND c.Emps IN (...)") a concatenar na
    * consulta principal. Devolve "" quando nenhuma empresa esta marcada
    * (= nenhum filtro adicional, igual ao legado).
    *--------------------------------------------------------------------------
    PROCEDURE MontarFiltroEmpresas(par_cCursorEmpresas)
        LOCAL loc_cFiltro, loc_cVirgula

        loc_cFiltro = ""

        IF PCOUNT() < 1 OR EMPTY(par_cCursorEmpresas)
            par_cCursorEmpresas = "cursor_4c_Empresas"
        ENDIF

        IF USED(par_cCursorEmpresas)
            *-- "Imps <> 0" e nao "Imps": a coluna eh NUMERICA (CheckBox.Value
            *-- eh numerico) e VFP exige expressao LOGICA no WHERE.
            SELECT cemps FROM (par_cCursorEmpresas) WHERE Imps <> 0 INTO CURSOR cursor_4c_EmpsMarcadas

            IF USED("cursor_4c_EmpsMarcadas")
                DO CASE
                    CASE RECCOUNT("cursor_4c_EmpsMarcadas") = 1
                        loc_cFiltro = " AND c.Emps = " + EscaparSQL(ALLTRIM(cursor_4c_EmpsMarcadas.cemps))
                    CASE RECCOUNT("cursor_4c_EmpsMarcadas") > 1
                        loc_cFiltro = " AND c.Emps IN ("
                        loc_cVirgula = ""
                        SELECT cursor_4c_EmpsMarcadas
                        SCAN
                            loc_cFiltro = loc_cFiltro + loc_cVirgula + EscaparSQL(ALLTRIM(cemps))
                            loc_cVirgula = ", "
                        ENDSCAN
                        loc_cFiltro = loc_cFiltro + ")"
                ENDCASE
                USE IN cursor_4c_EmpsMarcadas
            ENDIF
        ENDIF

        RETURN loc_cFiltro
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarGrandeGrupo - Equivalente a filgdegrupo() do legado. Exclui de
    * par_cCursorDados as linhas cujo Gde_Grupo esta DESMARCADO na grade de
    * filtro (par_cCursorFiltro). Se nada estiver desmarcado, nao filtra
    * nada (mesma regra do legado).
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarGrandeGrupo(par_cCursorDados, par_cCursorFiltro)
        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF
        IF PCOUNT() < 2 OR EMPTY(par_cCursorFiltro)
            par_cCursorFiltro = "cursor_4c_GrandeGrupo"
        ENDIF

        IF !USED(par_cCursorFiltro) OR !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        SELECT (par_cCursorFiltro)
        LOCATE FOR nMarcas = 0
        IF EOF()
            RETURN .T.
        ENDIF

        SELECT Codigos FROM (par_cCursorFiltro) WHERE nMarcas = 0 INTO CURSOR cursor_4c_NaoMarcados
        SELECT cursor_4c_NaoMarcados
        SCAN
            DELETE FROM (par_cCursorDados) WHERE Gde_Grupo = cursor_4c_NaoMarcados.Codigos
        ENDSCAN
        USE IN cursor_4c_NaoMarcados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * FiltrarGrupo - Equivalente a filgrupo() do legado. Exclui de
    * par_cCursorDados as linhas cujo Grupo esta DESMARCADO na grade de
    * filtro (par_cCursorFiltro).
    *--------------------------------------------------------------------------
    PROCEDURE FiltrarGrupo(par_cCursorDados, par_cCursorFiltro)
        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF
        IF PCOUNT() < 2 OR EMPTY(par_cCursorFiltro)
            par_cCursorFiltro = "cursor_4c_GrupoProduto"
        ENDIF

        IF !USED(par_cCursorFiltro) OR !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        SELECT (par_cCursorFiltro)
        LOCATE FOR nMarcas = 0
        IF EOF()
            RETURN .T.
        ENDIF

        SELECT Codigos FROM (par_cCursorFiltro) WHERE nMarcas = 0 INTO CURSOR cursor_4c_NaoMarcados
        SELECT cursor_4c_NaoMarcados
        SCAN
            DELETE FROM (par_cCursorDados) WHERE Grupo = cursor_4c_NaoMarcados.Codigos
        ENDSCAN
        USE IN cursor_4c_NaoMarcados

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparEmpresasSemAcesso - Equivalente a limpaemps() do legado. Exclui
    * de par_cCursorDados as linhas de empresas que o usuario logado nao
    * tem acesso (SigCdAce). NAO e chamado por THIS.Processar() - no
    * Processamento() legado esta chamada esta COMENTADA
    * ("*ThisForm.LimpaEmps([crCursor1])"), ou seja, desativada em producao.
    * Mantido aqui so para paridade com o metodo nomeado do legado.
    *--------------------------------------------------------------------------
    PROCEDURE LimparEmpresasSemAcesso(par_cCursorDados)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF

        IF UPPER(ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))) <> "4CONTROL"
            loc_cSQL = "SELECT e.cemps AS Cemps FROM SigCdEmp e " + ;
                       "WHERE e.cemps NOT IN (SELECT a.emps FROM SigCdAce a WHERE a.usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsSemAcesso")
            IF loc_nResultado < 0
                loc_lResultado = .F.
            ELSE
                IF USED(par_cCursorDados)
                    SELECT cursor_4c_EmpsSemAcesso
                    SCAN
                        DELETE FROM (par_cCursorDados) WHERE Empresa = cursor_4c_EmpsSemAcesso.Cemps
                    ENDSCAN
                ENDIF
                USE IN cursor_4c_EmpsSemAcesso
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDadosAntigos - Equivalente a buscaantigos() do legado. Para
    * cada linha de par_cCursorDados, busca o cadastro do produto (SigCdPrc)
    * e do tamanho (SigPrTa2) vigentes NA DATA DA VENDA, e sobrescreve os
    * campos de custo/venda/markup/fornecedor com esses valores historicos
    * quando encontrados (o cadastro atual do produto pode ter mudado desde
    * a venda).
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDadosAntigos(par_cCursorDados)
        LOCAL loc_lResultado, loc_cProduto, loc_cTamanho, loc_dDataRef, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        IF PCOUNT() < 1 OR EMPTY(par_cCursorDados)
            par_cCursorDados = "cursor_4c_Bruto"
        ENDIF

        IF !USED(par_cCursorDados)
            RETURN .F.
        ENDIF

        SELECT (par_cCursorDados)
        SCAN
            loc_cProduto = NVL(Codigo_Item, "")
            loc_cTamanho = NVL(Tamanho, "")
            loc_dDataRef = NVL(Data_Venda, DATETIME())

            loc_cSQL = "SELECT TOP 1 p.Mercs AS Gde_Grupo, p.CGrus AS Grupo, p.SGrus AS SubGrupo, " + ;
                       "p.CustoFs AS Custo_Cadastro, p.MoeCusfs AS Moe_Cus_Cadastro, " + ;
                       "p.MarkupA AS Markup_Cadastro, p.Reffs AS Ref_Fornecedor, " + ;
                       "p.PVens AS Venda_Cadastro, p.PVens AS Desc_Acres, p.PVens AS Venda_CadastroR, " + ;
                       "p.Moevs AS Moe_Vda_Cadastro, p.FigJpgs AS Imagem, p.IFors AS Cod_Fornecedor " + ;
                       "FROM SigCdPrc p " + ;
                       "WHERE p.CPros = " + EscaparSQL(loc_cProduto) + ;
                       " AND p.DataAlts >= " + FormatarDataSQL(loc_dDataRef) + ;
                       " ORDER BY p.DataAlts DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Antigo")
            IF loc_nResultado < 0
                loc_lResultado = .F.
            ELSE
                IF RECCOUNT("cursor_4c_Antigo") > 0
                    GO TOP IN cursor_4c_Antigo
                    REPLACE Gde_Grupo        WITH cursor_4c_Antigo.Gde_Grupo, ;
                            Grupo            WITH cursor_4c_Antigo.Grupo, ;
                            SubGrupo         WITH cursor_4c_Antigo.SubGrupo, ;
                            Custo_Cadastro   WITH cursor_4c_Antigo.Custo_Cadastro, ;
                            Moe_Cus_Cadastro WITH cursor_4c_Antigo.Moe_Cus_Cadastro, ;
                            Markup_Cadastro  WITH cursor_4c_Antigo.Markup_Cadastro, ;
                            Ref_Fornecedor   WITH cursor_4c_Antigo.Ref_Fornecedor, ;
                            Venda_Cadastro   WITH cursor_4c_Antigo.Venda_Cadastro, ;
                            Desc_Acres       WITH cursor_4c_Antigo.Desc_Acres, ;
                            Venda_CadastroR  WITH cursor_4c_Antigo.Venda_CadastroR, ;
                            Moe_Vda_Cadastro WITH cursor_4c_Antigo.Moe_Vda_Cadastro, ;
                            Imagem           WITH cursor_4c_Antigo.Imagem, ;
                            Cod_Fornecedor   WITH cursor_4c_Antigo.Cod_Fornecedor ;
                            IN (par_cCursorDados)

                    loc_cSQL = "SELECT TOP 1 t.Percs AS Markup_Tamanho, t.Valor AS Valor_Tamanho, " + ;
                               "t.PesoMs AS Peso_Tamanho " + ;
                               "FROM SigPrTa2 t " + ;
                               "WHERE t.CPros = " + EscaparSQL(loc_cProduto) + ;
                               " AND t.CodTams = " + EscaparSQL(loc_cTamanho) + ;
                               " AND t.DataAlts >= " + FormatarDataSQL(loc_dDataRef) + ;
                               " ORDER BY t.DataAlts DESC"

                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AntigoTam")
                    IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_AntigoTam") > 0
                        GO TOP IN cursor_4c_AntigoTam
                        REPLACE Markup_Tamanho WITH cursor_4c_AntigoTam.Markup_Tamanho, ;
                                Valor_Tamanho  WITH cursor_4c_AntigoTam.Valor_Tamanho, ;
                                Peso_Tamanho   WITH cursor_4c_AntigoTam.Peso_Tamanho ;
                                IN (par_cCursorDados)
                    ENDIF
                    IF USED("cursor_4c_AntigoTam")
                        USE IN cursor_4c_AntigoTam
                    ENDIF
                ENDIF
                IF USED("cursor_4c_Antigo")
                    USE IN cursor_4c_Antigo
                ENDIF
            ENDIF

            SELECT (par_cCursorDados)
        ENDSCAN

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarResultadoDetalhe - Equivalente a montapgres01() do legado.
    * Converte cada linha de cursor_4c_Bruto para a moeda par_cMoeda,
    * calcula parcelas/condicao de pagamento, aplica a regra de
    * acrescimo/desconto por numero de parcelas (regra fixa do cliente que
    * usa este relatorio - grupos "JOI" e "REL") e grava em
    * cursor_4c_Detalhe. No final, gera as linhas de totais (Filtro 1/2/3).
    *--------------------------------------------------------------------------
    PROCEDURE MontarResultadoDetalhe(par_cMoeda)
        LOCAL loc_lResultado, loc_nCotacaoRef, loc_nCotacaoOutra, loc_cEdn, loc_cSQL, loc_nResultado
        LOCAL loc_cPontoAnt, loc_cSeparadorAnt, loc_cCondPagto, loc_cVirgula, loc_lEntrada
        LOCAL loc_nParcelas, loc_nDiferenca, loc_nAdicional, loc_nFiltro, loc_cCondicao
        LOCAL loc_cMovimento, loc_nMarkupTot, loc_nPercTot
        loc_lResultado = .T.

        IF !USED("cursor_4c_Detalhe") OR !USED("cursor_4c_Bruto")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Detalhe
        SET ORDER TO
        ZAP

        SELECT cursor_4c_Bruto
        SCAN
            SCATTER MEMVAR MEMO

            loc_nCotacaoRef = fBuscarCotacao(par_cMoeda, m.Data_Venda, gnConnHandle)

            m.Ordem            = "A"
            m.Moeda            = NVL(m.Moeda, par_cMoeda)
            m.Moeda            = IIF(EMPTY(m.Moeda), par_cMoeda, m.Moeda)
            m.Quantidade       = NVL(m.Quantidade, 0.00)
            m.Val_Unitario     = NVL(m.Val_Unitario, 0.00)
            m.Total            = NVL(m.Total, 0.00)
            m.Custo_Cadastro   = NVL(m.Custo_Cadastro, 0.00)
            m.Moe_Cus_Cadastro = NVL(m.Moe_Cus_Cadastro, par_cMoeda)
            m.Moe_Cus_Cadastro = IIF(EMPTY(m.Moe_Cus_Cadastro), par_cMoeda, m.Moe_Cus_Cadastro)
            m.Venda_Cadastro   = NVL(m.Venda_Cadastro, 0.00)
            m.Moe_Vda_Cadastro = NVL(m.Moe_Vda_Cadastro, par_cMoeda)
            m.Moe_Vda_Cadastro = IIF(EMPTY(m.Moe_Vda_Cadastro), par_cMoeda, m.Moe_Vda_Cadastro)
            m.Valor_Tamanho    = NVL(m.Valor_Tamanho, 0.00)

            IF !EMPTY(m.Valor_Tamanho)
                m.Venda_Cadastro = m.Valor_Tamanho
            ENDIF

            IF par_cMoeda <> m.Moeda
                loc_nCotacaoOutra = fBuscarCotacao(m.Moeda, m.Data_Venda, gnConnHandle)
                m.Val_Unitario = ROUND((m.Val_Unitario * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
                m.Total        = ROUND((m.Total        * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
            ENDIF

            IF par_cMoeda <> m.Moe_Cus_Cadastro
                loc_nCotacaoOutra = fBuscarCotacao(m.Moe_Cus_Cadastro, m.Data_Venda, gnConnHandle)
                m.Custo_Cadastro = ROUND((m.Custo_Cadastro * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
            ENDIF

            IF par_cMoeda <> m.Moe_Vda_Cadastro
                loc_nCotacaoOutra = fBuscarCotacao(m.Moe_Vda_Cadastro, m.Data_Venda, gnConnHandle)
                m.Venda_Cadastro = ROUND((m.Venda_Cadastro * loc_nCotacaoOutra) / loc_nCotacaoRef, 2)
            ENDIF

            m.Desc_Acres      = 0
            m.Venda_CadastroR = m.Venda_Cadastro

            *-- Chave posicional (char(3)+char(20)+str(6) = char(29), igual
            *-- a SigMvPar.EmpDopNums) - NUNCA usar ALLTRIM aqui (regra #42)
            loc_cEdn = m.Empresa + m.Movimentacao + STR(m.Numero, 6)

            loc_cSQL = "SELECT p.EmpDopNums, p.FPags, p.TParcs, p.Datas, p.Vencs, f.Infos " + ;
                       "FROM SigMvPar p, SigOpFp f " + ;
                       "WHERE p.EmpDopNums = " + EscaparSQL(loc_cEdn) + " AND p.FPags = f.FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Parcelas")
            IF loc_nResultado < 0
                loc_lResultado = .F.
            ELSE
                loc_lEntrada = .F.
                *-- Verifica se alguma parcela foi para o dia da venda (ENTRADA) OU
                *-- se foi cartao de credito - considera A VISTA tambem (Infos = "T")
                SELECT * FROM cursor_4c_Parcelas WHERE TTOD(Datas) = TTOD(Vencs) OR Infos = "T" INTO CURSOR cursor_4c_Entradas
                GO TOP IN cursor_4c_Entradas
                IF !EOF("cursor_4c_Entradas")
                    loc_lEntrada = .T.
                ENDIF
                IF USED("cursor_4c_Entradas")
                    USE IN cursor_4c_Entradas
                ENDIF

                SELECT DISTINCT FPags FROM cursor_4c_Parcelas ORDER BY FPags INTO CURSOR cursor_4c_FormasPagto
                loc_cCondPagto = ""
                loc_cVirgula   = ""
                SELECT cursor_4c_FormasPagto
                SCAN
                    loc_cCondPagto = ALLTRIM(loc_cCondPagto) + loc_cVirgula + ALLTRIM(FPags)
                    loc_cVirgula   = " / "
                ENDSCAN
                USE IN cursor_4c_FormasPagto

                SELECT MAX(TParcs) AS TParcs FROM cursor_4c_Parcelas INTO CURSOR cursor_4c_MaxParcelas
                m.Parcelas   = NVL(cursor_4c_MaxParcelas.TParcs, 0)
                m.Cond_Pagto = loc_cCondPagto
                USE IN cursor_4c_MaxParcelas
                USE IN cursor_4c_Parcelas

                *-- Calculo de acrescimo/desconto por numero de parcelas - regra
                *-- fixa do cliente que usa este relatorio (unico que usa). Caso
                *-- outro cliente venha a usar, mover para parametro do sistema.
                *-- Grupo "JOI": acrescenta 2% ao valor de cadastro por parcela
                IF m.Gde_Grupo = "JOI"
                    IF m.Parcelas > 1
                        loc_nParcelas = IIF(loc_lEntrada, 1, 0)
                        FOR loc_nAdicional = 1 TO (m.Parcelas - loc_nParcelas)
                            loc_nDiferenca   = ((m.Venda_Cadastro * 2) / 100)
                            m.Venda_Cadastro = m.Venda_Cadastro + loc_nDiferenca
                            m.Desc_Acres     = m.Desc_Acres     + loc_nDiferenca
                        ENDFOR
                    ENDIF
                ENDIF

                *-- Grupo "REL": desconta 10% se 1 parcela, ou 5% de 2 a 5 parcelas
                IF m.Gde_Grupo = "REL"
                    IF m.Parcelas = 1
                        loc_nDiferenca   = ((m.Venda_Cadastro * 10) / 100)
                        m.Venda_Cadastro = m.Venda_Cadastro - loc_nDiferenca
                        m.Desc_Acres     = m.Desc_Acres     - loc_nDiferenca
                    ENDIF
                    IF BETWEEN(m.Parcelas, 2, 5)
                        loc_nDiferenca   = ((m.Venda_Cadastro * 5) / 100)
                        m.Venda_Cadastro = m.Venda_Cadastro - loc_nDiferenca
                        m.Desc_Acres     = m.Desc_Acres     - loc_nDiferenca
                    ENDIF
                ENDIF
            ENDIF

            m.Barras          = IIF(EMPTY(m.Barra_Individual), NVL(m.Barra_Geral, 0), NVL(m.Barra_Individual, 0))
            m.Imagem          = NVL(m.Imagem, "")
            m.Tamanho         = NVL(m.Tamanho, "")
            m.Cor             = NVL(m.Cor, "")
            m.Cod_Fornecedor  = NVL(m.Cod_Fornecedor, "")
            m.Nome_Fornecedor = NVL(m.Nome_Fornecedor, "")
            m.Obs_Item        = NVL(m.Obs_Item, "")
            m.Tipo            = NVL(m.Tipo, "")
            m.Item            = NVL(m.Item, 0)
            m.Valor_Diferenca = m.Val_Unitario - m.Venda_Cadastro
            m.Markup          = ROUND(IIF(EMPTY(m.Custo_Cadastro), 0, m.Val_Unitario / m.Custo_Cadastro), 2)
            m.Perc_Diferenca  = ROUND(IIF(EMPTY(m.Venda_Cadastro), 0, (100 - ((m.Val_Unitario / m.Venda_Cadastro) * 100)) * -1), 2)
            m.Codigo_Item     = NVL(m.Codigo_Item, "")
            m.Equivalente     = NVL(m.Equivalente, "")
            m.Desc_Item       = NVL(m.Desc_Item, "")
            m.Operacao        = NVL(m.Operacao, "O")
            m.Gde_Grupo       = NVL(m.Gde_Grupo, "")
            m.Grupo           = NVL(m.Grupo, "")
            m.SubGrupo        = ALLTRIM(NVL(m.SubDescrs, "")) + IIF(EMPTY(NVL(m.SubGrupo, "")), "", " (" + ALLTRIM(NVL(m.SubGrupo, "")) + ")")
            m.Ref_Fornecedor  = NVL(m.Ref_Fornecedor, "")
            m.Cod_Cliente     = NVL(m.Cod_Cliente, "")
            m.Nome_Cliente    = NVL(m.Nome_Cliente, "")
            m.Nome_Vendedora  = NVL(m.Nome_Vendedora, "")
            m.Categoria       = NVL(m.Categoria, "")
            m.Desc_Categoria  = NVL(m.Desc_Categoria, "")

            loc_cPontoAnt     = SET("POINT")
            loc_cSeparadorAnt = SET("SEPARATOR")
            SET POINT TO ","
            SET SEPARATOR TO "."
            m.Pct_Dif_Chr = TRANSFORM(m.Perc_Diferenca, "999,999,999.99")
            SET POINT     TO (loc_cPontoAnt)
            SET SEPARATOR TO (loc_cSeparadorAnt)

            INSERT INTO cursor_4c_Detalhe FROM MEMVAR

            SELECT cursor_4c_Bruto
        ENDSCAN

        *-- Total geral de cada venda (soma de todos os itens; saida soma
        *-- positivo, entrada soma negativo)
        UPDATE cursor_4c_Detalhe SET Total_Geral = 0

        SELECT Empresa, Movimentacao, Numero, SUM(Total * IIF(Operacao = "E", -1, 1)) AS Total ;
          FROM cursor_4c_Detalhe ;
         GROUP BY Empresa, Movimentacao, Numero ;
          INTO CURSOR cursor_4c_TotalPorVenda

        SELECT cursor_4c_TotalPorVenda
        SCAN
            UPDATE cursor_4c_Detalhe ;
               SET Total_Geral = cursor_4c_TotalPorVenda.Total ;
             WHERE Empresa = cursor_4c_TotalPorVenda.Empresa AND ;
                   Movimentacao = cursor_4c_TotalPorVenda.Movimentacao AND ;
                   Numero = cursor_4c_TotalPorVenda.Numero
        ENDSCAN
        USE IN cursor_4c_TotalPorVenda

        *-- Linhas de totais (Filtro 1 = acima do cadastro, 2 = abaixo, 3 =
        *-- geral), que entram no MESMO cursor de detalhe sem item vinculado
        *-- - usadas pelos indices Ordem1/Ordem2/Ordem3
        SELECT * FROM cursor_4c_Detalhe WHERE .F. INTO CURSOR cursor_4c_TotaisTmp READWRITE

        FOR loc_nFiltro = 1 TO 3
            DO CASE
                CASE loc_nFiltro = 1
                    loc_cCondicao = "Perc_Diferenca > 0"
                CASE loc_nFiltro = 2
                    loc_cCondicao = "Perc_Diferenca < 0"
                OTHERWISE
                    loc_cCondicao = ".T."
            ENDCASE

            SELECT Empresa, ;
                   Operacao AS Ordem, ;
                   SUM(Quantidade * IIF(Operacao = "E", -1, 1)) AS Quantidade, ;
                   SUM(Total * IIF(Operacao = "E", -1, 1)) AS Total, ;
                   SUM((Custo_Cadastro * Quantidade)  * IIF(Operacao = "E", -1, 1)) AS Custo_Cadastro, ;
                   SUM((Venda_Cadastro * Quantidade)  * IIF(Operacao = "E", -1, 1)) AS Venda_Cadastro, ;
                   SUM((Valor_Diferenca * Quantidade) * IIF(Operacao = "E", -1, 1)) AS Valor_Diferenca ;
              FROM cursor_4c_Detalhe ;
             WHERE &loc_cCondicao. ;
             GROUP BY 1, 2 ;
             ORDER BY 1, 2 ;
              INTO CURSOR cursor_4c_SubTotal

            SELECT cursor_4c_SubTotal
            SCAN
                loc_cMovimento = "TOTAL DE " + IIF(cursor_4c_SubTotal.Ordem = "E", "ENTRADAS", "SAIDAS")
                loc_nMarkupTot = IIF(EMPTY(cursor_4c_SubTotal.Custo_Cadastro), 0, cursor_4c_SubTotal.Total / cursor_4c_SubTotal.Custo_Cadastro)
                loc_nPercTot   = IIF(EMPTY(cursor_4c_SubTotal.Venda_Cadastro), 0, (100 - ((cursor_4c_SubTotal.Total / cursor_4c_SubTotal.Venda_Cadastro) * 100)) * -1)

                INSERT INTO cursor_4c_TotaisTmp (Filtro, Movimentacao, Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                                  Valor_Diferenca, Markup, Perc_Diferenca) ;
                                          VALUES (loc_nFiltro, loc_cMovimento, cursor_4c_SubTotal.Empresa, cursor_4c_SubTotal.Ordem, cursor_4c_SubTotal.Quantidade, cursor_4c_SubTotal.Total, ;
                                                  cursor_4c_SubTotal.Custo_Cadastro, cursor_4c_SubTotal.Venda_Cadastro, cursor_4c_SubTotal.Valor_Diferenca, ;
                                                  loc_nMarkupTot, loc_nPercTot)
            ENDSCAN
            USE IN cursor_4c_SubTotal
        ENDFOR

        SELECT cursor_4c_TotaisTmp
        SCAN
            INSERT INTO cursor_4c_Detalhe (Filtro, Movimentacao, Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                            Valor_Diferenca, Markup, Perc_Diferenca) ;
                                    VALUES (cursor_4c_TotaisTmp.Filtro, cursor_4c_TotaisTmp.Movimentacao, cursor_4c_TotaisTmp.Empresa, cursor_4c_TotaisTmp.Ordem, ;
                                            cursor_4c_TotaisTmp.Quantidade, cursor_4c_TotaisTmp.Total, cursor_4c_TotaisTmp.Custo_Cadastro, cursor_4c_TotaisTmp.Venda_Cadastro, ;
                                            cursor_4c_TotaisTmp.Valor_Diferenca, cursor_4c_TotaisTmp.Markup, cursor_4c_TotaisTmp.Perc_Diferenca)
        ENDSCAN
        USE IN cursor_4c_TotaisTmp

        SELECT cursor_4c_Detalhe
        GO TOP

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarResultadoPorEmpresa - Equivalente a montapgres02() do legado.
    * Agrega as linhas de totais gerais (Filtro = 3) de cursor_4c_Detalhe
    * por Empresa, calculando Ticket Medio e Markup, e grava em
    * cursor_4c_TotalEmpresa. Inclui uma linha de total geral (todas as
    * empresas, marcada com Empresa = CHR(255) / Ordem = "T").
    *--------------------------------------------------------------------------
    PROCEDURE MontarResultadoPorEmpresa()
        LOCAL loc_nQtdeVendas, loc_nPercTot, loc_nTktMedioTot

        IF !USED("cursor_4c_TotalEmpresa") OR !USED("cursor_4c_Detalhe")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_TotalEmpresa
        SET ORDER TO
        ZAP

        SELECT * FROM cursor_4c_Detalhe WHERE Filtro = 3 INTO CURSOR cursor_4c_DetalheFiltro3

        SELECT cursor_4c_DetalheFiltro3
        SCAN
            SCATTER MEMVAR MEMO

            SELECT DISTINCT Empresa, Movimentacao, Numero ;
              FROM cursor_4c_Detalhe ;
             WHERE Ordem = "A" AND Empresa = m.Empresa ;
              INTO CURSOR cursor_4c_AgrupamentoVendas
            loc_nQtdeVendas = RECCOUNT("cursor_4c_AgrupamentoVendas")
            USE IN cursor_4c_AgrupamentoVendas

            m.Tkt_Medio = IIF(loc_nQtdeVendas > 0, m.Total / loc_nQtdeVendas, 0)
            m.Markup    = IIF(EMPTY(m.Custo_Cadastro), 0, m.Total / m.Custo_Cadastro)
            m.Ordem     = "A"

            INSERT INTO cursor_4c_TotalEmpresa FROM MEMVAR

            SELECT cursor_4c_DetalheFiltro3
        ENDSCAN
        USE IN cursor_4c_DetalheFiltro3

        SELECT CHR(255) AS Empresa, ;
               "T" AS Ordem, ;
               SUM(Quantidade) AS Quantidade, ;
               SUM(Total) AS Total, ;
               SUM(Custo_Cadastro)  AS Custo_Cadastro, ;
               SUM(Venda_Cadastro)  AS Venda_Cadastro, ;
               SUM(Valor_Diferenca) AS Valor_Diferenca ;
          FROM cursor_4c_TotalEmpresa ;
         GROUP BY 1, 2 ;
         ORDER BY 1, 2 ;
          INTO CURSOR cursor_4c_TotalGeralEmpresa

        SELECT cursor_4c_TotalGeralEmpresa
        SCAN
            loc_nPercTot = IIF(EMPTY(cursor_4c_TotalGeralEmpresa.Venda_Cadastro), 0, (100 - ((cursor_4c_TotalGeralEmpresa.Total / cursor_4c_TotalGeralEmpresa.Venda_Cadastro) * 100)) * -1)

            SELECT DISTINCT Empresa, Movimentacao, Numero ;
              FROM cursor_4c_Detalhe ;
             WHERE Ordem = "A" ;
              INTO CURSOR cursor_4c_AgrupamentoVendas
            loc_nQtdeVendas = RECCOUNT("cursor_4c_AgrupamentoVendas")
            USE IN cursor_4c_AgrupamentoVendas

            loc_nTktMedioTot = IIF(loc_nQtdeVendas > 0, cursor_4c_TotalGeralEmpresa.Total / loc_nQtdeVendas, 0)

            INSERT INTO cursor_4c_TotalEmpresa (Empresa, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                                 Valor_Diferenca, Markup, Perc_Diferenca, Tkt_Medio) ;
                                         VALUES (cursor_4c_TotalGeralEmpresa.Empresa, cursor_4c_TotalGeralEmpresa.Ordem, cursor_4c_TotalGeralEmpresa.Quantidade, cursor_4c_TotalGeralEmpresa.Total, ;
                                                 cursor_4c_TotalGeralEmpresa.Custo_Cadastro, cursor_4c_TotalGeralEmpresa.Venda_Cadastro, cursor_4c_TotalGeralEmpresa.Valor_Diferenca, ;
                                                 0, loc_nPercTot, loc_nTktMedioTot)
        ENDSCAN
        USE IN cursor_4c_TotalGeralEmpresa

        SELECT cursor_4c_TotalEmpresa
        SET ORDER TO Ordem
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarResultadoPorVendedora - Equivalente a montapgres03() do legado.
    * Agrega cursor_4c_Detalhe (Ordem = "A") por Empresa+Vendedora e faz
    * UNION ALL com as linhas de total por empresa (Ordem = "A" de
    * cursor_4c_TotalEmpresa), gravando o resultado em
    * cursor_4c_TotalVendedora.
    *--------------------------------------------------------------------------
    PROCEDURE MontarResultadoPorVendedora()
        LOCAL loc_nMarkup, loc_nPerc, loc_nQtdeVendas, loc_nTktMedio

        IF !USED("cursor_4c_TotalVendedora") OR !USED("cursor_4c_Detalhe") OR !USED("cursor_4c_TotalEmpresa")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_TotalVendedora
        SET ORDER TO
        ZAP

        SELECT Empresa, ;
               Codigo_Vendedora, ;
               "A" AS Ordem, ;
               SUM(Quantidade) AS Quantidade, ;
               SUM(Total) AS Total, ;
               SUM(Custo_Cadastro * Quantidade) AS Custo_Cadastro, ;
               SUM(Venda_Cadastro * Quantidade) AS Venda_Cadastro, ;
               SUM(Val_Unitario   * Quantidade) AS Val_Unitario, ;
               SUM(Valor_Diferenca) AS Valor_Diferenca, ;
               0000000000000.00 AS Tkt_Medio ;
          FROM cursor_4c_Detalhe ;
         WHERE Ordem = "A" ;
         GROUP BY 1, 2 ;
         UNION ALL ;
        SELECT Empresa, ;
               Codigo_Vendedora, ;
               "Z" AS Ordem, ;
               Quantidade, ;
               Total, ;
               Custo_Cadastro, ;
               Venda_Cadastro, ;
               Val_Unitario, ;
               Valor_Diferenca, ;
               Tkt_Medio ;
          FROM cursor_4c_TotalEmpresa ;
         WHERE Ordem = "A" ;
          INTO CURSOR cursor_4c_TotalVendPreparo READWRITE

        SELECT cursor_4c_TotalVendPreparo
        INDEX ON Empresa + Ordem + Codigo_Vendedora TAG Ordem

        SELECT cursor_4c_TotalVendPreparo
        SCAN
            loc_nMarkup = ROUND(IIF(EMPTY(Custo_Cadastro), 0, Val_Unitario / Custo_Cadastro), 2)
            loc_nPerc   = IIF(EMPTY(Venda_Cadastro), 0, (100 - ((Total / Venda_Cadastro) * 100)) * -1)

            IF Ordem = "A"
                SELECT DISTINCT Empresa, Movimentacao, Numero ;
                  FROM cursor_4c_Detalhe ;
                 WHERE Ordem = "A" AND ;
                       Empresa = cursor_4c_TotalVendPreparo.Empresa AND ;
                       Codigo_Vendedora = cursor_4c_TotalVendPreparo.Codigo_Vendedora ;
                  INTO CURSOR cursor_4c_AgrupamentoVendas
                loc_nQtdeVendas = RECCOUNT("cursor_4c_AgrupamentoVendas")
                USE IN cursor_4c_AgrupamentoVendas

                loc_nTktMedio = IIF(loc_nQtdeVendas > 0, cursor_4c_TotalVendPreparo.Total / loc_nQtdeVendas, 0)
            ELSE
                loc_nTktMedio = cursor_4c_TotalVendPreparo.Tkt_Medio
            ENDIF

            INSERT INTO cursor_4c_TotalVendedora (Empresa, Codigo_Vendedora, Ordem, Quantidade, Total, Custo_Cadastro, Venda_Cadastro, ;
                                                   Valor_Diferenca, Markup, Perc_Diferenca, Tkt_Medio) ;
                                           VALUES (cursor_4c_TotalVendPreparo.Empresa, cursor_4c_TotalVendPreparo.Codigo_Vendedora, cursor_4c_TotalVendPreparo.Ordem, cursor_4c_TotalVendPreparo.Quantidade, ;
                                                   cursor_4c_TotalVendPreparo.Total, cursor_4c_TotalVendPreparo.Custo_Cadastro, cursor_4c_TotalVendPreparo.Venda_Cadastro, cursor_4c_TotalVendPreparo.Valor_Diferenca, ;
                                                   loc_nMarkup, loc_nPerc, loc_nTktMedio)

            SELECT cursor_4c_TotalVendPreparo
        ENDSCAN
        USE IN cursor_4c_TotalVendPreparo

        SELECT cursor_4c_TotalVendedora
        SET ORDER TO Ordem
        GO TOP

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Equivalente a processamento() do legado (orquestrador).
    * Sem nenhuma chamada de UI (progressbar/Refresh/ActivePage) - isso fica
    * a cargo do Form (Fase 3+), que deve trocar para a pagina de resultados
    * e posicionar a grade (optValor1.Value = 3 + Filtros(1,3) do legado)
    * depois de receber .T. aqui.
    *
    * par_cCursorEmpresas/Tipos/Operacoes/GrandeGrupo/GrupoProduto - aliases
    * dos cursores das grades de filtro da Pagina 1 (omitir para usar os
    * nomes padrao: cursor_4c_Empresas/TiposOperacao/Operacoes/GrandeGrupo/
    * GrupoProduto, que sao os mesmos criados por CarregarFiltrosIniciais).
    *--------------------------------------------------------------------------
    PROCEDURE Processar(par_dDataIni, par_dDataFim, par_cMoeda, par_cColecao, par_cSubGrupo, ;
                         par_cCursorEmpresas, par_cCursorTipos, par_cCursorOperacoes, ;
                         par_cCursorGrandeGrupo, par_cCursorGrupoProduto)
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cDataIniSQL, loc_cDataFimSQL, loc_dDataFimCompleta
        LOCAL loc_cWhereTipos, loc_cWhereOperacoes, loc_cWhereEmpresas, loc_cVirgula

        IF PCOUNT() < 6 OR EMPTY(par_cCursorEmpresas)
            par_cCursorEmpresas = "cursor_4c_Empresas"
        ENDIF
        IF PCOUNT() < 7 OR EMPTY(par_cCursorTipos)
            par_cCursorTipos = "cursor_4c_TiposOperacao"
        ENDIF
        IF PCOUNT() < 8 OR EMPTY(par_cCursorOperacoes)
            par_cCursorOperacoes = "cursor_4c_Operacoes"
        ENDIF
        IF PCOUNT() < 9 OR EMPTY(par_cCursorGrandeGrupo)
            par_cCursorGrandeGrupo = "cursor_4c_GrandeGrupo"
        ENDIF
        IF PCOUNT() < 10 OR EMPTY(par_cCursorGrupoProduto)
            par_cCursorGrupoProduto = "cursor_4c_GrupoProduto"
        ENDIF

        IF !USED("cursor_4c_Detalhe") OR !USED("cursor_4c_TotalEmpresa") OR !USED("cursor_4c_TotalVendedora")
            THIS.CriarCursoresResultado()
        ENDIF

        IF USED("cursor_4c_Bruto")
            USE IN cursor_4c_Bruto
        ENDIF

        SELECT cursor_4c_Detalhe
        ZAP
        SELECT cursor_4c_TotalEmpresa
        ZAP
        SELECT cursor_4c_TotalVendedora
        ZAP

        *-- Tipos de Operacao marcados (equivalente ao bloco em linha do
        *-- Processamento legado)
        loc_cWhereTipos = ""
        IF USED(par_cCursorTipos)
            SELECT CCodigos FROM (par_cCursorTipos) WHERE nMarcas = 1 INTO CURSOR cursor_4c_TiposMarcados
            DO CASE
                CASE RECCOUNT("cursor_4c_TiposMarcados") = 1
                    loc_cWhereTipos = "o.TipoOps = " + ALLTRIM(cursor_4c_TiposMarcados.CCodigos)
                CASE RECCOUNT("cursor_4c_TiposMarcados") > 1
                    loc_cWhereTipos = "o.TipoOps IN ("
                    loc_cVirgula = ""
                    SELECT cursor_4c_TiposMarcados
                    SCAN
                        loc_cWhereTipos = loc_cWhereTipos + loc_cVirgula + ALLTRIM(CCodigos)
                        loc_cVirgula = ", "
                    ENDSCAN
                    loc_cWhereTipos = loc_cWhereTipos + ")"
            ENDCASE
            USE IN cursor_4c_TiposMarcados
        ENDIF

        IF EMPTY(loc_cWhereTipos)
            MsgAviso("Nenhum Tipo de Opera" + CHR(231) + CHR(227) + "o Foi Selecionado!!!", "Dados Inv" + CHR(225) + "lidos!!!")
            RETURN .F.
        ENDIF

        *-- Operacoes marcadas (c.Dopes) - sem marcacao = sem filtro adicional
        loc_cWhereOperacoes = ""
        IF USED(par_cCursorOperacoes)
            SELECT Dopes FROM (par_cCursorOperacoes) WHERE nMarcas = 1 INTO CURSOR cursor_4c_OperacoesMarcadas
            DO CASE
                CASE RECCOUNT("cursor_4c_OperacoesMarcadas") = 1
                    loc_cWhereOperacoes = " AND c.Dopes = " + EscaparSQL(cursor_4c_OperacoesMarcadas.Dopes)
                CASE RECCOUNT("cursor_4c_OperacoesMarcadas") > 1
                    loc_cWhereOperacoes = " AND c.Dopes IN ("
                    loc_cVirgula = ""
                    SELECT cursor_4c_OperacoesMarcadas
                    SCAN
                        loc_cWhereOperacoes = loc_cWhereOperacoes + loc_cVirgula + EscaparSQL(Dopes)
                        loc_cVirgula = ", "
                    ENDSCAN
                    loc_cWhereOperacoes = loc_cWhereOperacoes + ")"
            ENDCASE
            USE IN cursor_4c_OperacoesMarcadas
        ENDIF

        loc_cWhereEmpresas = THIS.MontarFiltroEmpresas(par_cCursorEmpresas)

        loc_cDataIniSQL = FormatarDataSQL(par_dDataIni)
        loc_dDataFimCompleta = DATETIME(YEAR(par_dDataFim), MONTH(par_dDataFim), DAY(par_dDataFim), 23, 59, 59)
        loc_cDataFimSQL = FormatarDataSQL(loc_dDataFimCompleta)

        *-- Consulta principal (crCursor1 do legado) - detalhamento de venda
        *-- x cadastro do produto na data da venda
        loc_cSQL = "SELECT c.Emps AS Empresa, " + ;
                   "c.Dopes AS Movimentacao, " + ;
                   "c.Numes AS Numero, " + ;
                   "c.Datas AS Data_Venda, " + ;
                   "c.Vends AS Codigo_Vendedora, " + ;
                   "c3.RClis AS Nome_Vendedora, " + ;
                   "c.Valos AS Total_Geral, " + ;
                   "i.CItens AS Item, " + ;
                   "i.opers AS Tipo, " + ;
                   "i.CPros AS Codigo_Item, " + ;
                   "p.cproeqs AS Equivalente, " + ;
                   "i.DPros AS Desc_Item, " + ;
                   "i.Obs AS Obs_Item, " + ;
                   "i.Qtds AS Quantidade, " + ;
                   "i.Units AS Val_Unitario, " + ;
                   "i.Totas AS Total, " + ;
                   "i.Moedas AS Moeda, " + ;
                   "i.Opers AS Operacao, " + ;
                   "i.Codbarras AS Barra_Geral, " + ;
                   "s.CodBarras AS Barra_Individual, " + ;
                   "p.Mercs AS Gde_Grupo, " + ;
                   "p.CGrus AS Grupo, " + ;
                   "p.SGrus AS SubGrupo, " + ;
                   "sg.Descricaos AS SubDescrs, " + ;
                   "p.CustoFs AS Custo_Cadastro, " + ;
                   "p.MoeCusfs AS Moe_Cus_Cadastro, " + ;
                   "p.MarkupA AS Markup_Cadastro, " + ;
                   "p.Reffs AS Ref_Fornecedor, " + ;
                   "p.PVens AS Venda_Cadastro, " + ;
                   "p.PVens AS Desc_Acres, " + ;
                   "p.PVens AS Venda_CadastroR, " + ;
                   "p.Moevs AS Moe_Vda_Cadastro, " + ;
                   "p.FigJpgs AS Imagem, " + ;
                   "p.Categoria, " + ;
                   "g.Descs AS Desc_Categoria, " + ;
                   "s.CodTams AS Tamanho, " + ;
                   "s.CodCors AS Cor, " + ;
                   "t.Percs AS Markup_Tamanho, " + ;
                   "t.Valor AS Valor_Tamanho, " + ;
                   "t.PesoMs AS Peso_Tamanho, " + ;
                   "p.IFors AS Cod_Fornecedor, " + ;
                   "c2.RClis AS Nome_Fornecedor, " + ;
                   "c.ContaDs AS Cod_Cliente, " + ;
                   "c1.RClis AS Nome_Cliente, " + ;
                   "ISNULL(p.dpro2s,'') AS Descritivo, " + ;
                   "c.ContaOs AS ContaOrigem, " + ;
                   "RTRIM(ISNULL(p.colecoes,'')) + ' - ' + ISNULL(co.descs,'') AS Colecoes, " + ;
                   "i.localos AS LocalItn, " + ;
                   "ISNULL(b.tamde,'') AS tam_de, " + ;
                   "ISNULL(b.tampara,'') AS tam_para " + ;
              "FROM SigMvCab c " + ;
              "LEFT JOIN SigCdOpe o ON c.Dopes = o.Dopes " + ;
              "LEFT JOIN SigMvItn i ON c.EmpDopNums = i.EmpDopNums " + ;
              "LEFT JOIN SigMvIts s ON i.EmpDopNums = s.EmpDopNums AND i.CItens = s.CItens AND s.cpros = i.cpros " + ;
              "LEFT JOIN SigMvItp b ON i.EmpDopNums = b.EmpDopNums AND i.CItens = b.CItens " + ;
              "LEFT JOIN SigPrTam t ON s.CPros = t.CPros AND s.CodTams = t.CodTams " + ;
              "LEFT JOIN SigCdPro p ON i.CPros = p.CPros " + ;
              "LEFT JOIN SigCdCtg g ON g.Cods = p.Categoria " + ;
              "LEFT JOIN SigCdCli c1 ON c1.ICLis = c.ContaDs " + ;
              "LEFT JOIN SigCdCli c2 ON c2.ICLis = p.IFors " + ;
              "LEFT JOIN SigCdPsg sg ON sg.CGruCods = p.CGrus + p.SGrus " + ;
              "LEFT JOIN SigCdCli c3 ON c3.ICLis = c.Vends " + ;
              "LEFT JOIN SigCdCol co ON p.colecoes = co.colecoes " + ;
              "WHERE " + loc_cWhereTipos + " AND " + ;
              "c.Datas BETWEEN " + loc_cDataIniSQL + " AND " + loc_cDataFimSQL + " AND " + ;
              "p.CPros IS NOT NULL" + loc_cWhereEmpresas + ;
              IIF(!EMPTY(par_cColecao), " AND p.Colecoes = " + EscaparSQL(par_cColecao), "") + ;
              IIF(!EMPTY(par_cSubGrupo), " AND p.Sgrus = " + EscaparSQL(par_cSubGrupo), "") + ;
              loc_cWhereOperacoes

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Bruto")
        IF loc_nResultado < 0
            MsgErro("Falha ao consultar vendas no per" + CHR(237) + "odo." + CHR(13) + CapturarErroSQL(), "Erro de Conex" + CHR(227) + "o")
            RETURN .F.
        ENDIF

        *-- Reaproveita dados de cadastro do produto na data da venda, quando
        *-- o cadastro atual nao traz informacao (produto alterado depois)
        IF !THIS.BuscarDadosAntigos("cursor_4c_Bruto")
            RETURN .F.
        ENDIF

        *-- Filtros de Grande Grupo e Grupo de Produto (exclui o que foi
        *-- desmarcado nas grades de filtro)
        THIS.FiltrarGrandeGrupo("cursor_4c_Bruto", par_cCursorGrandeGrupo)
        THIS.FiltrarGrupo("cursor_4c_Bruto", par_cCursorGrupoProduto)

        *-- Limpeza de empresas sem acesso: o Processamento legado tem esta
        *-- chamada COMENTADA ("*ThisForm.LimpaEmps([crCursor1])") - mantida
        *-- desativada aqui tambem, por fidelidade ao comportamento real
        * THIS.LimparEmpresasSemAcesso("cursor_4c_Bruto")

        IF !THIS.MontarResultadoDetalhe(par_cMoeda)
            RETURN .F.
        ENDIF

        IF !THIS.MontarResultadoPorEmpresa()
            RETURN .F.
        ENDIF

        IF !THIS.MontarResultadoPorVendedora()
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Le a LINHA CORRENTE do cursor de resultados para as
    * properties this_cReg*/this_nReg*/this_dReg*/this_mReg*.
    *
    * Equivale ao que o legado faz espalhado em seis lugares sobre crPgRes01:
    *
    *   grdDados1.AfterRowColChange
    *       .getObsItn.Value      = Nvl(crPgRes01.Obs_Item, [])
    *       .getDesc_Acres.Value  = crPgRes01.Desc_Acres
    *       .getVdaCadastro.Value = crPgRes01.Venda_CadastroR
    *       (+ a figura, que sai por ExtrairImagemRegistro())
    *   ImgFigJpg.Click      -> Codigo_Item, Desc_Item, Grupo, SubGrupo
    *   btnProduto.Click     -> Codigo_Item
    *   CmdConta.Click       -> Cod_Cliente
    *   SubNiveis.Click      -> Empresa, Movimentacao, Numero
    *   cmdOperacao.btnOperacao.Valid -> Empresa, Movimentacao, Numero
    *
    * par_cAliasCursor eh opcional: sem ele vale "cursor_4c_Detalhe" (crPgRes01).
    * As grades de totais (cursor_4c_TotalEmpresa / cursor_4c_TotalVendedora)
    * tem a MESMA estrutura (sao derivadas por SELECT * no CriarCursoresResultado),
    * por isso o mesmo metodo atende as tres.
    *
    * Devolve .F. e LIMPA as properties quando nao ha linha corrente - assim o
    * Form nunca exibe no painel lateral o dado da linha anterior, e os botoes
    * de acao enxergam campo vazio, que eh exatamente a condicao que o legado
    * testa com Empty(crPgRes01.Empresa) / Not Eof([crPgRes01]).
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado, loc_nAreaAnterior

        loc_lResultado = .F.

        IF PCOUNT() < 1 OR VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor)
            par_cAliasCursor = "cursor_4c_Detalhe"
        ENDIF

        *-- Sem cursor aberto, ou cursor posicionado em BOF/EOF (grade vazia ou
        *-- linha fantasma), nao ha registro corrente: limpa e sai.
        IF !USED(par_cAliasCursor)
            THIS.LimparRegistroCorrente()
        ELSE
            loc_nAreaAnterior = SELECT()
            SELECT (par_cAliasCursor)

            IF EOF() OR BOF() OR RECCOUNT() = 0
                THIS.LimparRegistroCorrente()
            ELSE
                *-- Problema 9: com alias dinamico, SELECT (alias) primeiro e
                *-- campo acessado DIRETO - "campo" eh sintaxe invalida.
                THIS.this_cRegEmpresa        = ALLTRIM(TratarNulo(Empresa, ""))
                THIS.this_cRegMovimentacao   = ALLTRIM(TratarNulo(Movimentacao, ""))
                THIS.this_nRegNumero         = TratarNulo(Numero, 0)
                THIS.this_nRegItem           = TratarNulo(Item, 0)
                THIS.this_dRegDataVenda      = ConverterParaData(Data_Venda)
                THIS.this_cRegCodigoItem     = ALLTRIM(TratarNulo(Codigo_Item, ""))
                THIS.this_cRegDescItem       = ALLTRIM(TratarNulo(Desc_Item, ""))
                THIS.this_cRegEquivalente    = ALLTRIM(TratarNulo(Equivalente, ""))
                THIS.this_cRegGdeGrupo       = ALLTRIM(TratarNulo(Gde_Grupo, ""))
                THIS.this_cRegGrupo          = ALLTRIM(TratarNulo(Grupo, ""))
                THIS.this_cRegSubGrupo       = ALLTRIM(TratarNulo(SubGrupo, ""))
                THIS.this_cRegCodCliente     = ALLTRIM(TratarNulo(Cod_Cliente, ""))
                THIS.this_cRegNomeCliente    = ALLTRIM(TratarNulo(Nome_Cliente, ""))
                THIS.this_cRegCodVendedora   = ALLTRIM(TratarNulo(Codigo_Vendedora, ""))

                *-- Obs_Item eh MEMO: o legado usa Nvl(..., []) justamente porque
                *-- vem NULL do SigMvItn.Obs. Sem ALLTRIM, para preservar a
                *-- formatacao que o usuario digitou no pedido.
                THIS.this_cRegObsItem        = TratarNulo(Obs_Item, "")

                THIS.this_nRegDescAcres      = TratarNulo(Desc_Acres, 0)
                THIS.this_nRegVendaCadastroR = TratarNulo(Venda_CadastroR, 0)
                THIS.this_mRegImagem         = TratarNulo(Imagem, "")

                loc_lResultado = .T.
            ENDIF

            *-- Repoe a area de trabalho: quem chama eh o AfterRowColChange de
            *-- um Grid, e trocar o alias corrente por baixo dele desposiciona
            *-- outras grades ligadas a cursores irmaos.
            SELECT (loc_nAreaAnterior)
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparRegistroCorrente - Zera as properties do registro corrente.
    * Usado por CarregarDoCursor() quando nao ha linha valida.
    *--------------------------------------------------------------------------
    PROCEDURE LimparRegistroCorrente()
        THIS.this_cRegEmpresa        = ""
        THIS.this_cRegMovimentacao   = ""
        THIS.this_nRegNumero         = 0
        THIS.this_nRegItem           = 0
        THIS.this_dRegDataVenda      = {}
        THIS.this_cRegCodigoItem     = ""
        THIS.this_cRegDescItem       = ""
        THIS.this_cRegEquivalente    = ""
        THIS.this_cRegGdeGrupo       = ""
        THIS.this_cRegGrupo          = ""
        THIS.this_cRegSubGrupo       = ""
        THIS.this_cRegCodCliente     = ""
        THIS.this_cRegNomeCliente    = ""
        THIS.this_cRegCodVendedora   = ""
        THIS.this_cRegObsItem        = ""
        THIS.this_nRegDescAcres      = 0
        THIS.this_nRegVendaCadastroR = 0
        THIS.this_mRegImagem         = ""

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ExtrairImagemRegistro - Gera o arquivo .jpg temporario da figura do
    * registro corrente e devolve o caminho; devolve "" quando nao ha figura.
    *
    * Transcricao do bloco que o legado repete em grdDados1.AfterRowColChange
    * e em ImgFigJpg.Click:
    *
    *   lcArq = Sys(2023) + [\] + goSistema.Sys2015Tmp + Sys(2015) + [.jpg]
    *   If Not Empty(crPgRes01.Imagem) And Not IsNull(crPgRes01.Imagem)
    *       lcFoto = Strconv(Strtran(Strtran(Strtran(crPgRes01.Imagem,
    *                [data:image/png;base64,],[]),[data:image/jpeg;base64,],[]),
    *                [data:image/jpg;base64,],[]), 14)
    *       If (StrToFile(lcFoto, lcArq) > 0)
    *           .ImgFigJpg.Picture = (lcArq)
    *
    * SigCdPro.figjpgs guarda base64 (eventualmente com o prefixo data URI), e
    * por isso o STRCONV(..., 14) acontece UMA unica vez aqui - o mesmo padrao
    * de sigrecgpBO e sigtosenBO. Decodificar de novo o resultado corromperia o
    * JPEG, que a essa altura ja eh binario.
    *
    * O prefixo do nome do arquivo vem de go_4c_Sistema.Sys2015Tmp; a leitura
    * eh cercada por PEMSTATUS porque go_4c_Sistema eh objeto Empty e ler
    * membro ausente estoura em runtime.
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE ExtrairImagemRegistro()
        LOCAL loc_cArquivo, loc_cFoto, loc_cPrefixo, loc_nBytes, loc_cRetorno

        loc_cRetorno = ""

        IF !ISNULL(THIS.this_mRegImagem) AND !EMPTY(THIS.this_mRegImagem)
            loc_cPrefixo = "4c_tmp_"
            IF TYPE("go_4c_Sistema") = "O"
                IF PEMSTATUS(go_4c_Sistema, "Sys2015Tmp", 5)
                    loc_cPrefixo = go_4c_Sistema.Sys2015Tmp
                ENDIF
            ENDIF

            loc_cArquivo = ADDBS(SYS(2023)) + loc_cPrefixo + SYS(2015) + ".jpg"

            loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN( ;
                THIS.this_mRegImagem, ;
                "data:image/png;base64,", ""), ;
                "data:image/jpeg;base64,", ""), ;
                "data:image/jpg;base64,", ""), 14)

            loc_nBytes = STRTOFILE(loc_cFoto, loc_cArquivo)
            IF loc_nBytes > 0
                loc_cRetorno = loc_cArquivo
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterTituloZoomRegistro / ObterSubtituloZoomRegistro - Legendas que o
    * legado monta ao abrir o zoom da figura (ImgFigJpg.Click):
    *
    *   Do Form SigOpZom With lcArq, ;
    *        [Produto : ] + Alltrim(crPgRes01.Codigo_Item) + [ - ] + Alltrim(crPgRes01.Desc_Item), ;
    *        [Grupo : ]   + crPgRes01.Grupo + [ - SubGrupo : ] + crPgRes01.SubGrupo
    *
    * PUBLIC (regra #51): o Form chama estes metodos de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE ObterTituloZoomRegistro()
        RETURN "Produto : " + THIS.this_cRegCodigoItem + " - " + THIS.this_cRegDescItem
    ENDPROC

    PROCEDURE ObterSubtituloZoomRegistro()
        RETURN "Grupo : " + THIS.this_cRegGrupo + " - SubGrupo : " + THIS.this_cRegSubGrupo
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterFormularioOperacaoRegistro - Decide QUAL tela de movimentacao abrir
    * para o registro corrente, transcrevendo cmdOperacao.btnOperacao.Valid:
    *
    *   lcQuery = [Select Dopes From SigCdOpe Where Dopes = '] + crPgRes01.Movimentacao + [']
    *   ... If Not Eof([TmpOpe]) -> Do Form SigMvExp
    *   senao
    *   lcQuery = [Select Dopps From SigCdOpd Where Dopps = '] + crPgRes01.Movimentacao + [']
    *   ... If Not Eof([TmpOpe]) -> Do Form SigMvPdt
    *
    * Devolve "SigMvExp", "SigMvPdt" ou "" (movimentacao nao cadastrada em
    * nenhuma das duas tabelas - no legado o botao simplesmente nao abre nada).
    * O par_cMensagem volta preenchido quando ha o que avisar ao usuario; eh
    * BYREF, e por isso o Form precisa chamar com "@" (VFP9 passa por valor).
    *
    * A guarda de registro valido eh a MESMA do legado (Empty nos tres campos
    * da chave), agora lendo as properties que CarregarDoCursor() alimentou.
    *
    * PUBLIC (regra #51): o Form chama este metodo de FORA da classe.
    *--------------------------------------------------------------------------
    PROCEDURE ObterFormularioOperacaoRegistro(par_cMensagem)
        LOCAL loc_cRetorno, loc_cSQL, loc_nResultado, loc_lSegue

        loc_cRetorno   = ""
        par_cMensagem  = ""
        loc_lSegue     = .T.

        IF EMPTY(THIS.this_cRegEmpresa) OR EMPTY(THIS.this_cRegMovimentacao) ;
                OR THIS.this_nRegNumero = 0
            par_cMensagem = "Selecione Um Registro V" + CHR(225) + "lido Na Grade de " + ;
                            "Itens!!!"
            loc_lSegue = .F.
        ENDIF

        IF loc_lSegue
            IF USED("cursor_4c_Operacao")
                USE IN cursor_4c_Operacao
            ENDIF

            loc_cSQL = "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + ;
                       EscaparSQL(THIS.this_cRegMovimentacao)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado < 0
                par_cMensagem = "Falha ao identificar a opera" + CHR(231) + CHR(227) + "o " + ;
                                THIS.this_cRegMovimentacao + "." + CHR(13) + CapturarErroSQL()
                loc_lSegue = .F.
            ENDIF
        ENDIF

        IF loc_lSegue
            SELECT cursor_4c_Operacao
            GO TOP
            IF !EOF("cursor_4c_Operacao")
                loc_cRetorno = "SigMvExp"
            ENDIF
            USE IN cursor_4c_Operacao
        ENDIF

        *-- Nao estando em SigCdOpe, o legado tenta SigCdOpd (operacoes de
        *-- pedido) e abre a tela SigMvPdt.
        IF loc_lSegue AND EMPTY(loc_cRetorno)
            loc_cSQL = "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + ;
                       EscaparSQL(THIS.this_cRegMovimentacao)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacao")
            IF loc_nResultado < 0
                par_cMensagem = "Falha ao identificar a opera" + CHR(231) + CHR(227) + "o " + ;
                                THIS.this_cRegMovimentacao + "." + CHR(13) + CapturarErroSQL()
            ELSE
                SELECT cursor_4c_Operacao
                GO TOP
                IF !EOF("cursor_4c_Operacao")
                    loc_cRetorno = "SigMvPdt"
                ENDIF
                USE IN cursor_4c_Operacao
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave do registro corrente, no formato EmpDopNums
    * que o SigMvCab/SigMvItn/SigMvPec usam (regra #42): chave POSICIONAL de
    * char(29) = Emps char(3) + Dopes char(20) + Str(Numes, 6).
    *
    * O padding FAZ PARTE da chave: as properties guardam o valor com ALLTRIM
    * (CarregarDoCursor), entao o PADR explicito aqui eh obrigatorio - ALLTRIM
    * nas partes interiores produziria uma chave curta que nunca casa, e a
    * consulta devolveria ZERO linha sem erro nenhum.
    *
    * PROTECTED: segue a visibilidade de BusinessBase (regra #51) - o Form usa
    * as properties this_cReg*, nunca este metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN PADR(THIS.this_cRegEmpresa, 3) + ;
               PADR(THIS.this_cRegMovimentacao, 20) + ;
               STR(THIS.this_nRegNumero, 6)
    ENDPROC

ENDDEFINE
