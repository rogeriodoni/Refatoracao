*==============================================================================
* Classe  : sigprmdpBO
* Herda de: BusinessBase
* Descricao: BO para substituicao de referencias (codigos) de produtos.
*            Valida pares CprosAnt/CprosNov, importa de XLS e aplica UPDATE
*            em multiplas tabelas do banco conforme catalogo ArqDBF, alem de
*            registrar controle de recalculo de custo em SigOpClC.
*            Form OPERACIONAL - sem Lista/Page1/Buscar(); this_cTabela so
*            identifica SigOpClC, unica tabela gravada por Inserir/Atualizar.
*==============================================================================
DEFINE CLASS sigprmdpBO AS BusinessBase

    *-- Flags de configuracao do processamento (legado: checkcadpro/manterbarra/calculacusto)
    this_lCheckCadPro   = .F.   && Pula a validacao do codigo de produto contra SigCdPro
    this_lManterBarra   = .F.   && Mantem o codigo de barras do produto antigo no produto novo
    this_lCalculaCusto  = .T.   && Recalcula custo (legado le de SigCdPaC.CalcCustos <> 3)

    *-- Estado do progresso (lido pelo Form para atualizar UI - cntResult/cntBarra)
    this_cArquivoAtual  = ""    && Arquivo/campo em processamento (getArquivo.Value)
    this_cProdutoAtual  = ""    && Produto em processamento (Get_Cpros.Value)
    this_nProgresso     = 0     && Progresso 0-100 (lblPorcento.Caption / shpBarra.Width)

    *-- Caminho completo do ArqDBF.DBF (sem extensao) - setado por ValidarArqDBF
    this_cArqDBFPath    = ""

    *-- Par corrente de produtos (usado por CarregarDoCursor - espelha o cursor
    *-- da grade csContas: CprosAnt C(14), CprosNov C(14), Flag L, BarraAnt N(8))
    this_cProsAnt       = ""    && Codigo de referencia antigo (SigCdPro.Cpros, char(14))
    this_cProsNov       = ""    && Codigo de referencia novo (SigCdPro.Cpros, char(14))
    this_lFlag          = .F.   && Linha ja processada com sucesso (csContas.Flag)
    this_nBarraAnt      = 0     && Codigo de barras do produto antigo (SigCdPro.Cbars)

    *-- Dados do registro de controle de custo gerado no processamento (tabela
    *-- SigOpClC, unica tabela gravada diretamente por este BO - Inserir/Atualizar)
    this_cCidChaves     = ""    && Chave unica do registro (SigOpClC.cidchaves, PK)
    this_cCpros         = ""    && Codigo do produto enfileirado p/ recalculo (SigOpClC.cpros)
    this_cEmps          = ""    && Empresa do registro de custo (SigOpClC.emps)
    this_cEmpCpros      = ""    && Empresa + codigo do produto (SigOpClC.empcpros)
    this_dDatas         = {}    && Data base do recalculo de custo (SigOpClC.datas)
    this_cUsuars        = ""    && Usuario que gerou o registro (SigOpClC.usuars)

    *-- .T. quando o par processado tinha linha(s) em SigMvEst referenciando
    *-- o codigo antigo (ver ProcessarPar - regra #27: fRecalculaP/fRecalculaC
    *-- nao vieram no acervo, e SigMvEst nao e tocado sem elas). O Form usa
    *-- esta flag para avisar o usuario que o saldo precisa de revisao manual.
    this_lSigMvEstPendente = .F.

    *--------------------------------------------------------------------------
    * Init - sem Buscar()/this_oDataAccess (form OPERACIONAL, sem Lista/Page1).
    * this_cTabela/this_cCampoChave apontam para SigOpClC so porque e a UNICA
    * tabela que Inserir()/Atualizar() gravam diretamente (fila de recalculo
    * de custo) - usados por RegistrarAuditoria() para montar o log.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigOpClC"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor da
    * grade de pares de substituicao (equivalente a csContas do legado).
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cProsAnt  = TratarNulo(CprosAnt,  "")
                THIS.this_cProsNov  = TratarNulo(CprosNov,  "")
                THIS.this_lFlag     = TratarNulo(Flag,      .F.)
                THIS.this_nBarraAnt = TratarNulo(BarraAnt,  0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "sigprmdpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Grava na fila de recalculo de custo (tabela SigOpClC), um
    * registro por produto/empresa cujo custo precisa ser reprocessado apos a
    * substituicao de referencia (legado: Insert Into CrSigOpClC no btnProcessar).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigOpClC (cidchaves, cpros, datas, empcpros, emps, usuars)
                VALUES (
                    <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>,
                    <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "sigprmdpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza um registro existente da fila de recalculo de custo
    * (SigOpClC), localizado pela chave unica this_cCidChaves.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cEmpCpros)
                THIS.this_cEmpCpros = THIS.this_cEmps + THIS.this_cCpros
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigOpClC
                SET cpros    = <<EscaparSQL(LEFT(THIS.this_cCpros, 14))>>,
                    datas    = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    empcpros = <<EscaparSQL(LEFT(THIS.this_cEmpCpros, 17))>>,
                    emps     = <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    usuars   = <<EscaparSQL(LEFT(THIS.this_cUsuars, 10))>>
                WHERE cidchaves = <<EscaparSQL(LEFT(THIS.this_cCidChaves, 20))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro de recalculo de custo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "sigprmdpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - chave real do registro gravado por Inserir/Atualizar
    * (SigOpClC.cidchaves), usada por RegistrarAuditoria().
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarParSubstituicao - replica as 4 validacoes do SCAN csContas do
    * btnProcessar.Click legado, na MESMA ordem. Devolve um codigo em vez de
    * exibir a mensagem/posicionar o foco - isso e decisao do FORM (camadas).
    * Grava THIS.this_nBarraAnt quando acha o produto antigo em SigCdPro
    * (equivalente a "Replace BarraAnt With CrTmpPro.Cbars in CsContas").
    *
    * Retorno:
    *   0 = par valido
    *   1 = codigo antigo vazio, ou nao cadastrado em SigCdPro (e
    *       this_lCheckCadPro = .F.)
    *   2 = produto antigo sem codigo de barras (so quando this_lManterBarra)
    *   3 = codigo novo vazio
    *   4 = codigo antigo e novo iguais
    *   5 = grupos do produto antigo/novo com controle de estoque (Cestoqs)
    *       diferentes
    *--------------------------------------------------------------------------
    FUNCTION ValidarParSubstituicao(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado, loc_nRetorno, loc_lProsseguir
        loc_nRetorno = 0
        loc_lProsseguir = .T.
        THIS.this_nBarraAnt = 0

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            IF EMPTY(par_cProsAnt)
                loc_nRetorno = 1
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !THIS.this_lCheckCadPro
                loc_cSQL = "SELECT Cpros, Cbars FROM SigCdPro WHERE Cpros = " + ;
                    EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValPro")
                IF loc_nResultado < 1 OR !USED("cursor_4c_ValPro") OR RECCOUNT("cursor_4c_ValPro") = 0
                    IF USED("cursor_4c_ValPro")
                        USE IN cursor_4c_ValPro
                    ENDIF
                    loc_nRetorno = 1
                    loc_lProsseguir = .F.
                ELSE
                    THIS.this_nBarraAnt = TratarNulo(cursor_4c_ValPro.Cbars, 0)
                    USE IN cursor_4c_ValPro
                ENDIF
            ENDIF

            IF loc_lProsseguir AND THIS.this_lManterBarra AND THIS.this_nBarraAnt = 0
                loc_nRetorno = 2
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND EMPTY(par_cProsNov)
                loc_nRetorno = 3
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND UPPER(ALLTRIM(par_cProsAnt)) == UPPER(ALLTRIM(par_cProsNov))
                loc_nRetorno = 4
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                *-- Grupos com controle de estoque (Cestoqs) diferentes entre o
                *-- produto novo e o antigo bloqueiam a troca (legado: LocalPro/
                *-- LocalPro2, Select a.Cgrus,b.Cestoqs From SigCdPro a, SigCdGrp b)
                loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                    " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
                SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro")
                IF USED("cursor_4c_LocalPro") AND RECCOUNT("cursor_4c_LocalPro") > 0
                    loc_cSQL = "SELECT b.Cestoqs FROM SigCdPro a INNER JOIN SigCdGrp b ON a.Cgrus = b.Cgrus" + ;
                        " WHERE a.Cpros = " + EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro2")
                    IF USED("cursor_4c_LocalPro2")
                        IF RECCOUNT("cursor_4c_LocalPro2") > 0 AND ;
                           cursor_4c_LocalPro2.Cestoqs != cursor_4c_LocalPro.Cestoqs
                            loc_nRetorno = 5
                        ENDIF
                        USE IN cursor_4c_LocalPro2
                    ENDIF
                ENDIF
                IF USED("cursor_4c_LocalPro")
                    USE IN cursor_4c_LocalPro
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao validar par de refer" + CHR(234) + "ncias:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ValidarParSubstituicao")
            loc_nRetorno = 1
        ENDTRY

        RETURN loc_nRetorno
    ENDFUNC

    *--------------------------------------------------------------------------
    * MapearTabelasAlvo - Equivalente ao
    *     Select Arquivos, Campos From ArqDBF
    *     Where (Tamanhos=10 Or Tamanhos=14) And Upper(Tipos)='C' And
    *           Arquivos not in (...) And InList(Alltrim(Campos), <14 nomes>)
    * do btnProcessar.Click legado. ArqDBF.DBF era um CATALOGO LOCAL do FoxPro
    * (Sys(5)+Sys(2003)+'\ArqDBF.dbf') - nao existe no SQL Server (regra #14:
    * so o schema.sql/INFORMATION_SCHEMA decide, nunca arquivo local). A MESMA
    * lista de nomes de coluna e o MESMO filtro de tamanho sao aplicados aqui
    * contra o metadado REAL e ATUAL do banco, em vez de um catalogo que podia
    * estar desatualizado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION MapearTabelasAlvo()
        LOCAL loc_cSQL, loc_nResultado

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        TEXT TO loc_cSQL NOSHOW
            SELECT TABLE_NAME AS Arquivos, COLUMN_NAME AS Campos
            FROM INFORMATION_SCHEMA.COLUMNS
            WHERE DATA_TYPE IN ('char', 'varchar')
              AND CHARACTER_MAXIMUM_LENGTH IN (10, 14)
              AND UPPER(COLUMN_NAME) IN ('CMATS','CODCONPADS','CODPDS','CODPROPADS',
                  'CPROS','PRODUTO','PRODUTOS','CPROEQS','MATPRINCS','MATS',
                  'MATSUBS','CODGARRAS','OUROS','BRILHANTES')
              AND UPPER(TABLE_NAME) NOT IN ('SIGTEMPD','SIGTEMPC','SIGTEMPR')
            ORDER BY TABLE_NAME
        ENDTEXT

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Campos")
        IF loc_nResultado < 0
            MostrarErro("Erro ao mapear tabelas com refer" + CHR(234) + "ncia a produto:" + CHR(13) + ;
                CapturarErroSQL(), "Erro SQL")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExisteReferencia - .T. se existe ao menos 1 linha de par_cTabela com
    * par_cColuna = par_cValor. Equivalente ao
    *     ThisForm.PodataMgr.CursorQuery('SigCdPro','CrTmpPro','Cpros', ... )
    * e ao padrao "Select X From Y Where Y.X = 'valor' / Reccount(...) > 0"
    * repetido no btnProcessar.Click legado.
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExisteReferencia(par_cTabela, par_cColuna, par_cValor)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        loc_cSQL = "SELECT TOP 1 " + par_cColuna + " FROM " + par_cTabela + ;
            " WHERE " + par_cColuna + " = " + EscaparSQL(LEFT(ALLTRIM(par_cValor), 14))
        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Existe")
        IF loc_nResultado > 0 AND USED("cursor_4c_Existe")
            loc_lExiste = (RECCOUNT("cursor_4c_Existe") > 0)
        ENDIF
        IF USED("cursor_4c_Existe")
            USE IN cursor_4c_Existe
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * EnfileirarRecalculoPorPar - Equivalente ao bloco final do legado
    * ("If Used('TmpCustPro') And Thisform.Calculacusto / Scan / Insert Into
    * CrSigOpClC (...) "). TmpCustPro era populado DENTRO de fRecalculaC
    * (funcao global do Fortyus que nao veio no acervo - regra #27); como nao
    * ha como reproduzir o calculo em si, enfileiramos para recalculo externo
    * TODA empresa que tem movimento historico (SigMvHst) para o codigo
    * antigo OU o novo - e' o mesmo universo (Emps) que o legado varria via
    * fRecalculaP/fRecalculaC para montar TmpCustPro.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cSQL, loc_nResultado

        IF !THIS.this_lCalculaCusto
            RETURN
        ENDIF

        TRY
            loc_cSQL = "SELECT DISTINCT Emps FROM SigMvHst WHERE Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14)) + " OR Cpros = " + ;
                EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsRecalc")
            IF loc_nResultado > 0 AND USED("cursor_4c_EmpsRecalc")
                SELECT cursor_4c_EmpsRecalc
                SCAN
                    THIS.this_cEmps   = TratarNulo(cursor_4c_EmpsRecalc.Emps, "")
                    THIS.this_dDatas  = DATE()
                    THIS.this_cUsuars = TratarNulo(gc_4c_UsuarioLogado, "")

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsAnt)
                    THIS.Inserir()

                    THIS.this_cCidChaves = ""
                    THIS.this_cEmpCpros  = ""
                    THIS.this_cCpros     = ALLTRIM(par_cProsNov)
                    THIS.Inserir()
                ENDSCAN
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao enfileirar recalculo de custo:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.EnfileirarRecalculoPorPar")
        ENDTRY

        IF USED("cursor_4c_EmpsRecalc")
            USE IN cursor_4c_EmpsRecalc
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPar - substitui par_cProsAnt por par_cProsNov em todas as
    * tabelas mapeadas por MapearTabelasAlvo() (equivalente ao "Select
    * Arquivos,Campos" + Scan do btnProcessar.Click legado).
    *
    * Casos especiais transcritos literalmente do legado:
    *   SIGPRPRT          -> nunca atualizado (Loop incondicional).
    *   SIGCDPRO/SIGPRCPO/SIGCDPRF/SIGCDPFT -> quando o codigo NOVO ja existe
    *     como produto cadastrado em SigCdPro: se for SigCdPro.Cpros e
    *     this_lManterBarra, transfere o codigo de barras (Cbars) do antigo
    *     para o novo em vez de renomear; senao, se o codigo ANTIGO tambem
    *     existir como produto distinto, pula a troca (preserva os dois
    *     registros); caso contrario segue para o UPDATE generico.
    *   SIGMVHST/SIGMVEST -> NAO recebem UPDATE/DELETE aqui. O legado dispara
    *     fRecalculaP()/fRecalculaC() (recalculo de custo/estoque) e, so para
    *     SIGMVEST, exclui as linhas do saldo antigo (a recriacao sob o
    *     codigo novo acontecia DENTRO de fRecalculaP). Essas duas funcoes
    *     globais do Fortyus NAO vieram no acervo (regra #27) - excluir
    *     SIGMVEST sem a recriacao destruiria saldo de estoque em SILENCIO,
    *     o que e pior que nao fazer nada. Em vez disso: SigMvHst participa
    *     do UPDATE generico (o legado tambem faz isso - o bloco SIGMVHST
    *     cai no Else por nao ter "Loop"); SigMvEst e so verificado (seta a
    *     flag de alerta correspondente) para o FORM avisar o usuario.
    *
    * Toda a troca das demais tabelas vai num UNICO SQLEXEC (lote T-SQL com
    * SAVE TRANSACTION) - BEGIN/COMMIT em chamadas SEPARADAS de SQLEXEC NAO
    * dao atomicidade nesta conexao (Transactions=2, @@TRANCOUNT ja nasce 1,
    * ver Erro188/ProdutoBO.CopiarProduto).
    *--------------------------------------------------------------------------
    FUNCTION ProcessarPar(par_cProsAnt, par_cProsNov)
        LOCAL loc_cProsAntSQL, loc_cProsNovSQL, loc_cLote, loc_cSQL, ;
              loc_cTabela, loc_cColuna, loc_nResultado, loc_lSucesso, loc_lProsseguir

        loc_lSucesso = .F.
        loc_lProsseguir = .T.
        loc_cProsAntSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsAnt), 14))
        loc_cProsNovSQL = EscaparSQL(LEFT(ALLTRIM(par_cProsNov), 14))
        THIS.this_lSigMvEstPendente = .F.
        THIS.this_cMensagemErro = ""

        IF !THIS.MapearTabelasAlvo()
            RETURN .F.
        ENDIF

        *-- REGRA CRITICA: nunca RETURN dentro de TRY/CATCH - usa flag
        *-- loc_lProsseguir e um unico RETURN apos o ENDTRY.
        TRY
            loc_cLote = ""

            SELECT cursor_4c_Campos
            SCAN
                loc_cTabela = ALLTRIM(cursor_4c_Campos.Arquivos)
                loc_cColuna = ALLTRIM(cursor_4c_Campos.Campos)

                IF UPPER(loc_cTabela) == "SIGPRPRT"
                    LOOP
                ENDIF

                IF UPPER(loc_cTabela) == "SIGMVEST"
                    THIS.this_lSigMvEstPendente = THIS.this_lSigMvEstPendente OR ;
                        THIS.ExisteReferencia(loc_cTabela, loc_cColuna, par_cProsAnt)
                    LOOP
                ENDIF

                IF INLIST(UPPER(loc_cTabela), "SIGCDPRO", "SIGPRCPO", "SIGCDPRF", "SIGCDPFT") ;
                   AND THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsNov)

                    IF UPPER(loc_cTabela) == "SIGCDPRO" AND UPPER(loc_cColuna) == "CPROS" ;
                       AND THIS.this_lManterBarra
                        loc_cLote = loc_cLote + ;
                            "UPDATE SigCdPro SET Cbars = " + FormatarNumeroSQL(THIS.this_nBarraAnt, 0) + ;
                            " WHERE Cpros = " + loc_cProsNovSQL + "; " + ;
                            "UPDATE SigCdPro SET Cbars = 0 WHERE Cpros = " + loc_cProsAntSQL + "; "
                        LOOP
                    ENDIF

                    IF THIS.ExisteReferencia("SigCdPro", "Cpros", par_cProsAnt)
                        *-- codigo antigo TAMBEM existe como produto distinto -
                        *-- preserva os dois, nao mexe nesta coluna
                        LOOP
                    ENDIF
                ENDIF

                *-- UPDATE generico (legado: Update <tabela> Set <coluna> =
                *-- 'novo' Where <coluna> = 'antigo' - com ou sem chave
                *-- primaria o resultado final e o mesmo conjunto de linhas)
                loc_cLote = loc_cLote + ;
                    "UPDATE " + loc_cTabela + " SET " + loc_cColuna + " = " + loc_cProsNovSQL + ;
                    " WHERE " + loc_cColuna + " = " + loc_cProsAntSQL + "; "
            ENDSCAN

            IF !EMPTY(loc_cLote)
                TEXT TO loc_cSQL TEXTMERGE NOSHOW
                    SET NOCOUNT ON;
                    DECLARE @nivel4c int = @@TRANCOUNT;
                    IF @nivel4c = 0 BEGIN TRANSACTION ELSE SAVE TRANSACTION Mdp4c;
                    BEGIN TRY
                        <<loc_cLote>>
                        IF @nivel4c = 0 COMMIT TRANSACTION;
                    END TRY
                    BEGIN CATCH
                        IF @nivel4c = 0
                            BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION END
                        ELSE
                            BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Mdp4c END;
                        THROW;
                    END CATCH
                ENDTEXT

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    THIS.this_cMensagemErro = "Erro ao atualizar refer" + CHR(234) + "ncias de produto:" + ;
                        CHR(13) + CapturarErroSQL()
                    MostrarErro(THIS.this_cMensagemErro, "Erro SQL")
                    loc_lProsseguir = .F.
                ENDIF
            ENDIF

            IF loc_lProsseguir
                THIS.EnfileirarRecalculoPorPar(par_cProsAnt, par_cProsNov)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao processar substitui" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                loException.Message, "sigprmdpBO.ProcessarPar")
        ENDTRY

        IF USED("cursor_4c_Campos")
            USE IN cursor_4c_Campos
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
