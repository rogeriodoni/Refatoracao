*==============================================================================
* sigprtamBO.prg - Business Object para Tamanhos do Produto (SIGPRTAM)
* Tabela Principal: SigPrTam (PK: cidchaves)
* Tabela Relacionada: SigCdTam (cadastro de tamanhos - cods/descs/varias)
*
* SIGPRTAM e um dialogo filho chamado pelo cadastro de produtos para
* manter a grade de tamanhos (codigo, descricao, peso medio, percentual,
* valor e prazo de entrega) de UM produto por vez (filtro por cpros).
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS sigprtamBO AS BusinessBase

    *-- Propriedades: SigPrTam
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCodTams    = ""   && codtams   char(4)  NOT NULL - FK SigCdTam.cods
    this_cCpros      = ""   && cpros     char(14) NOT NULL - FK SigCdPro.cPros (produto filtrado)
    this_dDataAlts   = {}   && dataalts  datetime NULL
    this_dDataTrans  = {}   && datatrans datetime NULL
    this_dDtMovs     = {}   && dtmovs    datetime NULL
    this_nPesoMs     = 0    && pesoms    numeric(7,3) NOT NULL - peso medio do tamanho
    this_nPercs      = 0    && percs     numeric(5,2) NOT NULL - percentual sobre o preco de venda
    this_nValor      = 0    && valor     numeric(11,5) NOT NULL - valor calculado a partir do percentual
    this_nDiasPrz    = 0    && diasprz   numeric(2,0) NOT NULL - prazo de entrega em dias

    *-- Propriedade NAO persistida: descricao do tamanho (join com SigCdTam.descs)
    this_cDescs      = ""   && descs char(20) - vem de SigCdTam, exibida na grade

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigPrTam"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega as propriedades a partir de uma linha do
    * cursor (cursor_4c_Dados, populado pelo Form a partir de SigPrTam)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cCodTams   = TratarNulo(codtams,   "")
                THIS.this_cCpros     = TratarNulo(cpros,     "")
                THIS.this_dDataAlts  = TratarNulo(dataalts,  {})
                THIS.this_dDataTrans = TratarNulo(datatrans, {})
                THIS.this_dDtMovs    = TratarNulo(dtmovs,    {})
                THIS.this_nPesoMs    = TratarNulo(pesoms,    0)
                THIS.this_nPercs     = TratarNulo(percs,     0)
                THIS.this_nValor     = TratarNulo(valor,     0)
                THIS.this_nDiasPrz   = TratarNulo(diasprz,   0)

                * Descs vem de um JOIN com SigCdTam (nao existe na tabela
                * SigPrTam) - so esta presente quando o SELECT do Form a traz
                IF TYPE("descs") = "C"
                    THIS.this_cDescs = TratarNulo(descs, "")
                ELSE
                    THIS.this_cDescs = ""
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigprtamBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave primaria de SigPrTam (cidchaves)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigPrTam (novo tamanho para o produto filtrado)
    * O legado gera a PK com fUniqueIds() no clique do botao Inserir, antes
    * de o usuario preencher qualquer coluna da grade (regra #22).
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTam (cidchaves, codtams, cpros, dataalts, datatrans, dtmovs, pesoms, percs, valor, diasprz)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigPrTam (cpros e cidchaves nao mudam depois do
    * Inserir - sao a chave e o filtro de origem do registro)
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTam
                SET codtams   = <<EscaparSQL(THIS.this_cCodTams)>>,
                    dataalts  = <<FormatarDataSQL(THIS.this_dDataAlts)>>,
                    datatrans = <<FormatarDataSQL(THIS.this_dDataTrans)>>,
                    dtmovs    = <<FormatarDataSQL(THIS.this_dDtMovs)>>,
                    pesoms    = <<FormatarNumeroSQL(THIS.this_nPesoMs, 3)>>,
                    percs     = <<FormatarNumeroSQL(THIS.this_nPercs, 2)>>,
                    valor     = <<FormatarNumeroSQL(THIS.this_nValor, 5)>>,
                    diasprz   = <<FormatarNumeroSQL(THIS.this_nDiasPrz, 0)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM SigPrTam (equivalente ao Delete do
    * cursor buferizado no cmdExcluir.Click do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrTam WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tamanho do produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "sigprtamBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca os tamanhos vinculados a um produto (par_cCpros).
    * Retorna cursor_4c_Dados com cidchaves/codtams/cpros/.../descs.
    *
    * NAO faz JOIN com SigCdTam para preencher descs: o legado tambem nao
    * faz (Init: "Select a.*, Space(40) as Descs From SigPrTam a Where
    * a.cPros = ...") - a descricao so e preenchida em runtime pelo lookup
    * da celula de Codigo/Descricao (Column1/Column2.Text1.Valid), nunca
    * pela carga inicial. Transcricao literal (CLAUDE.md regra #17).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, codtams, cpros, dataalts, datatrans, dtmovs,
                       pesoms, percs, valor, diasprz, SPACE(20) AS descs
                FROM SigPrTam
                WHERE cpros = <<EscaparSQL(par_cCpros)>>
            ENDTEXT

            * SQLEXEC cria cursor SOMENTE-LEITURA - a grade precisa inserir
            * (Inserir) e apagar (Excluir) linhas localmente, alem de editar
            * peso/percentual/valor/prazo, entao o resultado eh copiado para
            * um cursor READWRITE (CLAUDE.md: "Grid com coluna EDITAVEL
            * exige cursor READWRITE")
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE
                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro("Erro ao buscar tamanhos do produto:" + CHR(13) + ;
                        THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "sigprtamBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
