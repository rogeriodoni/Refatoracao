*====================================================================
* TCLBO.prg
*
* Business Object para Cadastro de Classes (SIGCDTCL)
* Tabela: SigCdCss
* Herda de: BusinessBase
*
* NOTA: o codigo fonte original (SIGCDTCL_form_codigo_fonte.txt) usa
* ThisForm.poDataMgr.AddCursor('SigCdCss','classes','crSigCdCss', ...)
* como cursor principal do form. O cursor 'crSigCdGcr' (SigCdGcr) e
* criado no Init original apenas como cursor auxiliar (nao possui
* nenhum controle vinculado no layout) e por isso NAO faz parte das
* propriedades desta entidade.
*====================================================================

DEFINE CLASS TCLBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdCss)
    this_cClasse    = ""    && classes    char(10) - PK
    this_cDescricao = ""    && descrs     char(30)
    this_cFf        = ""    && ff         char(10) - NOT NULL, sem controle no form original (grava SPACE(10))
    this_nNivel     = 0     && nivels     numeric(1,0) - dominio [1,2,3]
    this_nOpBalanco = 0     && opbalancos numeric(1,0) - OptionGroup optGreps  (1=Sim / 2=Nao) "Incluir em Inventario"
    this_nInvEmisCc = 0     && invemisccs numeric(1,0) - OptionGroup Fwoption1 (1=Sim / 2=Nao) "Trocar CC por Emissor"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCss"
            THIS.this_cCampoChave = "classes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TCLBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Valores default para novo registro
    * ff nao tem controle no form original: legado grava SPACE(10)
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_cFf = SPACE(10)
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cClasse)
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
                THIS.this_cClasse    = TratarNulo(classes,    "C")
                THIS.this_cDescricao = TratarNulo(descrs,     "C")
                THIS.this_cFf        = TratarNulo(ff,         "C")
                THIS.this_nNivel     = TratarNulo(nivels,     "N")
                THIS.this_nOpBalanco = TratarNulo(opbalancos, "N")
                THIS.this_nInvEmisCc = TratarNulo(invemisccs, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TCLBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Regras extraidas do legado (SIGCDTCL.Pagina.Dados.Get_nivel.Valid
    * e SIGCDTCL.Click do Confirmar - ver comportamento.json)
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido, loc_nTamanhoEsperado, loc_cClasseSemEspacos
        loc_lValido = .T.

        *-- Get_nivel.Valid: nivel fora do dominio [1,2,3]
        IF !INLIST(THIS.this_nNivel, 1, 2, 3)
            MsgAviso("N" + CHR(237) + "vel Inv" + CHR(225) + "lido !!")
            loc_lValido = .F.
        ENDIF

        *-- Get_nivel.Valid: se nivel <> 1, forca "Incluir em Invent" + CHR(225) + "rio" = Sim (1)
        IF loc_lValido AND THIS.this_nNivel != 1
            THIS.this_nOpBalanco = 1
        ENDIF

        IF loc_lValido
            *-- Click Confirmar: tamanho da classe depende do nivel
            *-- nivel 1 -> substr('124',1,1)='1' (1 digito) | nivel 2 -> '2' (2 digitos) | nivel 3 -> '4' (4 digitos)
            loc_cClasseSemEspacos = STRTRAN(ALLTRIM(THIS.this_cClasse), " ", "")
            loc_nTamanhoEsperado  = VAL(SUBSTR("124", THIS.this_nNivel, 1))
            IF LEN(loc_cClasseSemEspacos) != loc_nTamanhoEsperado
                MsgAviso("Classe Inv" + CHR(225) + "lida !!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDescricao)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarClasseExistente(THIS.this_cClasse)
                MsgAviso("Classe j" + CHR(225) + " Cadastrada!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarClasseExistente - Verifica se classes ja existe no banco
    * Equivalente ao ChkRegister('SigCdCss','classes',...) do legado
    *====================================================================
    PROCEDURE VerificarClasseExistente(par_cClasse)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCss" + ;
                " WHERE classes = " + EscaparSQL(par_cClasse)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCla")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCla")
                SELECT cursor_4c_ChkCla
                loc_lExiste = (cursor_4c_ChkCla.qtd > 0)
                USE IN cursor_4c_ChkCla
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar classe:" + CHR(13) + loException.Message, "TCLBO.VerificarClasseExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdCss
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCss (classes, descrs, ff, nivels, opbalancos, invemisccs)
                VALUES (
                    <<EscaparSQL(THIS.this_cClasse)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>,
                    <<EscaparSQL(THIS.this_cFf)>>,
                    <<FormatarNumeroSQL(THIS.this_nNivel, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nOpBalanco, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nInvEmisCc, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TCLBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdCss
    * classes eh chave primaria - nao entra no SET
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCss
                SET descrs     = <<EscaparSQL(THIS.this_cDescricao)>>,
                    ff         = <<EscaparSQL(THIS.this_cFf)>>,
                    nivels     = <<FormatarNumeroSQL(THIS.this_nNivel, 0)>>,
                    opbalancos = <<FormatarNumeroSQL(THIS.this_nOpBalanco, 0)>>,
                    invemisccs = <<FormatarNumeroSQL(THIS.this_nInvEmisCc, 0)>>
                WHERE classes = <<EscaparSQL(THIS.this_cClasse)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TCLBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdCss
    * Sem verificacao de dependencia no legado (framework generico)
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCss WHERE classes = " + EscaparSQL(THIS.this_cClasse)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TCLBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com classes, descrs, nivels (colunas da
    * grade original: pColuna('classes'...), pColuna('descrs'...),
    * pColuna('nivels'...))
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (classes C(10), descrs C(30), nivels N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT classes, descrs, nivels FROM SigCdCss"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY classes"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar classes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TCLBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (classes)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cClasse)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT classes, descrs, ff, nivels, opbalancos, invemisccs" + ;
                " FROM SigCdCss WHERE classes = " + EscaparSQL(par_cClasse)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Classe n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar classe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TCLBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
