*====================================================================
* SigPrCarBO.prg
*
* Business Object para SigPrCar (Caracteristicas do Produto)
* Tabela: SigPrCar (codigos char(20), cpros char(14), pkchaves char(20) - PK)
* Sub-formulario modal chamado de dentro do Cadastro de Produtos (SigCdPro)
* para gerenciar as caracteristicas vinculadas ao produto corrente.
* A descricao (Descrs) nao existe na tabela SigPrCar - vem do lookup em
* SigCrRap (tabela de caracteristicas) filtrado pelo Cgrus do produto.
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCar)
    this_cPkChaves = ""    && pkchaves char(20) - PK (fUniqueIds())
    this_cCpros    = ""    && cpros char(14) - FK para SigCdPro.CPros
    this_cCodigos  = ""    && codigos char(20) - FK para SigCrRap.Codigos

    *-- Propriedade de apoio (NAO persistida em SigPrCar - vem do JOIN com SigCrRap)
    this_cDescrs   = ""    && descrs - descricao da caracteristica (SigCrRap.Descrs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCar"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCarBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
                THIS.this_cCpros    = TratarNulo(cpros,    "C")
                THIS.this_cCodigos  = TratarNulo(codigos,  "C")

                *-- descrs so existe se o cursor veio de um JOIN com SigCrRap
                IF TYPE(par_cAliasCursor + ".descrs") = "C"
                    THIS.this_cDescrs = TratarNulo(descrs, "C")
                ELSE
                    THIS.this_cDescrs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigPrCarBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCpros)
            MsgAviso("Produto n" + CHR(227) + "o informado!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCodigos)
            MsgAviso("Caracter" + CHR(237) + "stica n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCar (codigos, cpros, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCar
                SET codigos = <<EscaparSQL(THIS.this_cCodigos)>>,
                    cpros   = <<EscaparSQL(THIS.this_cCpros)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigPrCar
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCar WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir caracter" + CHR(237) + "stica:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCarBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca as caracteristicas vinculadas a um produto (par_cCpros)
    * Retorna cursor_4c_Dados com pkchaves, cpros, codigos, descrs
    * (descrs vem do JOIN com SigCrRap)
    *====================================================================
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT a.pkchaves, a.cpros, a.codigos, b.descrs
                FROM SigPrCar a
                INNER JOIN SigCrRap b ON b.codigos = a.codigos
                WHERE a.cpros = <<EscaparSQL(par_cCpros)>>
                ORDER BY b.descrs
            ENDTEXT

            *-- SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            *-- (Inserir) e apagar (Excluir) linhas localmente, entao o
            *-- resultado eh copiado para um cursor READWRITE (CLAUDE.md:
            *-- "Grid com coluna EDITAVEL exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MostrarErro("Erro ao buscar caracter" + CHR(237) + "sticas:" + CHR(13) + THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loException
            THIS.this_cMensagemErro = loException.Message
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "SigPrCarBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
