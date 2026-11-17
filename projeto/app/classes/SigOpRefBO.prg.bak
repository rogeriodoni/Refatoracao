*============================================================================
* SigOpRefBO.prg - Business Object para Replicacao de Produto (Referencia)
*
* Legado  : SIGOPREF.SCX (form OPERACIONAL, DataSession privada, modal)
* Operacao: duplica um produto existente (origem) gerando um novo produto
*           (destino), opcionalmente em outro Grupo, copiando a composicao
*           (SigPrCpo) e as linhas (SigCdPrf) do produto origem.
*
* Tabelas afetadas : SigCdPro  (PK: cpros char(14) - o PRODUTO NOVO gerado;
*                     entidade real da operacao - ver nota na Fase 2/Inserir)
*                     SigPrCpo  (PK: cidchaves char(20) - composicao)
*                     SigCdPrf  (PK: cidchaves char(20) - linhas)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init / Fase 2 - Metodos CRUD
*============================================================================

DEFINE CLASS SigOpRefBO AS BusinessBase

    *==========================================================================
    * Propriedades de tela - produto ORIGEM (campos GetOldCPro/getOldCGrus/getolddpro)
    *==========================================================================
    this_cCodProdOrigem   = ""    && char(14) - SigCdPro.cpros do produto origem (csTmpPro.Cpros)
    this_cGrupoOrigem     = ""    && char(3)  - SigCdPro.cgrus do produto origem (csTmpPro.Cgrus)
    this_cDescProdOrigem  = ""    && char(65) - SigCdPro.dpros do produto origem (csTmpPro.Dpros)

    *==========================================================================
    * Propriedades de tela - produto DESTINO (campos getNewCpro/getNewCGrus/getnewdpro)
    *==========================================================================
    this_cCodProdDestino  = ""    && char(14) - novo codigo de produto (gerado ou digitado)
    this_cGrupoDestino    = ""    && char(3)  - grupo do novo produto (csTmpGru.Cgrus)
    this_cDescProdDestino = ""    && char(65) - descricao do novo produto (quando MontaGrDs = 5, manual)
    this_nQuantidade      = 1     && numeric(2,0) - quantidade de copias a gerar (Get_Qtd, InputMask "99")
    this_nSituacao        = 1     && 1 = Ativo / 2 = Inativo (Opc_situacao.Value -> SigCdPro.Situas)

    *==========================================================================
    * Propriedades de controle de processo (RESERVED3 do SCX legado)
    *==========================================================================
    this_lAcesGru        = .T.    && acesgru     - .T. permite digitar o Grupo de Destino
    this_cAntValue       = ""     && antvalue    - ultimo valor validado do Grupo de Destino (Valid/When)
    this_lAtualizaDescr  = .F.    && atualizadescr - sinaliza remontagem da descricao do produto
    this_lAutomatico     = .F.    && automatico  - .T. quando o codigo do novo produto foi auto-gerado
    this_nCadPro         = 0      && cadpro      - tipo de cadastro especial (5 = com foto/serial, via SigOpCdd)
    this_cDopes          = ""     && dopes       - codigo de operacao (SigOpCdd.Dopes) usado quando this_nCadPro = 5
    this_nIdentFixa      = 0      && identfixa   - identificador fixo repassado ao novo produto
    this_nInicio         = 0      && inicio      - sequencial de codigo de barras (fGerUniqueKey('SigCdPro'))
    this_nNewSeq         = 0      && newseq      - sequencial do novo codigo de produto (fGerUniqueKey)
    this_cRetCodProduto  = ""     && retcodproduto - retorno do processo: PADR(codigo,14) + STR(quantidade,2)
    this_lSaiAuto        = .F.    && saiauto     - .T. processa automaticamente sem confirmacao do usuario
    this_nSituacaoIt     = 0      && situacaoit  - situacao recebida por parametro (bloqueia Opc_situacao)

    *==========================================================================
    * Parametros do sistema (SigCdPam) - equivalente ao cursor crSigCdPam que o
    * Init legado carrega com CursorQuery([SigCdPam],[crSigCdPam],.f.,.f.,
    * [CodProds, DigProds, TpCbars, CUnis]). Sao as 4 colunas que o legado
    * pede, mesmo que CUnis nunca seja lido em metodo algum do SCX - manter a
    * lista identica evita divergir do legado se algum ramo passar a usa-la.
    *==========================================================================
    this_nPamCodProds = 0     && SigCdPam.CodProds numeric(2,0) - tipo de geracao de codigo padrao
    this_cPamDigProds = ""    && SigCdPam.DigProds char(1)      - digito/prefixo padrao do codigo
    this_nPamTpCbars  = 0     && SigCdPam.TpCbars  numeric(1,0) - tipo de codigo de barras
    this_cPamCUnis    = ""    && SigCdPam.CUnis    char(3)      - unidade padrao

    *==========================================================================
    * Grupo de DESTINO (SigCdGrp) - equivalente ao cursor csTmpGru do Init
    * legado (CursorQuery([SigCdGrp],[csTmpGru],[CGrus],lcGrp,[CGrus,DigGprs])).
    * DigGprs decide se o usuario pode DIGITAR o grupo de destino: o Init
    * legado faz "If (csTmpGru.DigGprs <> 1) Or .SaiAuto -> AcesGru = .f.".
    *==========================================================================
    this_nGrupoDestinoDigGprs = 0   && SigCdGrp.DigGprs numeric(1,0) do grupo de destino

    *==========================================================================
    * Buffer de trabalho (Fase 2) - NAO eh dado persistente: acumula o lote de
    * INSERTs que CopiarTabelaFilha() vai gerando ate Inserir() executar tudo
    * num SQLEXEC unico. Sempre zerado ao entrar/sair de Inserir() (mesmo
    * padrao de ProdutoBO.this_cLoteCopia - Erro188).
    *==========================================================================
    this_cLoteSQL = ""

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPrf"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Fase 2 - Metodos de carga e CRUD (equivalentes ao btnConfirmar.Click /
    * mSv_Inserir / Auxmontadescs do legado)
    *
    * SIGOPREF eh um dialogo que SEMPRE cria um PRODUTO NOVO a partir de um
    * existente - nao ha ramo de "alterar" no legado. O form (fase 3+) chama
    * THIS.NovoRegistro() + THIS.Salvar() (padrao canonico - regra #20 do
    * CLAUDE.md), e Salvar() delega para THIS.Inserir() porque
    * this_lNovoRegistro fica sempre .T. nesta tela.
    *
    *   Init (csTmpPro)                -> THIS.CarregarDoCursor()
    *   btnConfirmar.Click (validacao) -> THIS.ValidarDados()
    *   btnConfirmar.Click (copia)     -> THIS.Inserir()
    *   (nao existe no legado)         -> THIS.Atualizar() (recusa - regra #20)
    *   mSv_Inserir (Update/Commit)    -> THIS.Inserir() (SQLEXEC unico - ver
    *                                      comentario na execucao do lote)
    *==========================================================================

    *==========================================================================
    * CarregarDoCursor - Mapeia um cursor de PRODUTO (mesmo formato de
    * csTmpPro: CursorQuery([SigCdPro],[csTmpPro],[CPros],pPro,
    * [CPros, CGrus, Dpros])) para as propriedades do produto de ORIGEM.
    *
    * Quem monta esse cursor (SELECT cpros, cgrus, dpros FROM SigCdPro WHERE
    * cpros = <codigo>) eh o form, na fase seguinte - BusinessBase.
    * CarregarDoCursor() so recebe UM alias, por isso aqui ele mapeia sempre
    * o produto de ORIGEM (o unico que o legado le de cursor; o grupo de
    * DESTINO e o codigo do produto novo vem de digitacao/geracao, nunca de
    * CarregarDoCursor).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodProdOrigem  = TratarNulo(CPros, "")
            THIS.this_cGrupoOrigem    = TratarNulo(CGrus, "")
            THIS.this_cDescProdOrigem = TratarNulo(Dpros, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC


    *==========================================================================
    * CarregarParametrosSistema - Equivalente a
    *   .poDataMgr.CursorQuery([SigCdPam], [crSigCdPam], .f., .f.,
    *                          [CodProds, DigProds, TpCbars, CUnis])
    * do Init legado, inclusive o aborto quando o cursor nao vem
    * ("Favor Reinicializar o Processo!!!" + Return .f.). SigCdPam eh tabela de
    * UMA linha (parametros gerais) - o legado faz "Go Top In crSigCdPam" e le
    * os campos direto, sem WHERE (nunca inventar "WHERE Emps" em tabela de
    * parametro que nao tem essa coluna).
    *==========================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_PamRef")
                IF CURSORGETPROP("Buffering", "cursor_4c_PamRef") > 1
                    TABLEREVERT(.T., "cursor_4c_PamRef")
                ENDIF
                USE IN cursor_4c_PamRef
            ENDIF

            loc_cSQL = "SELECT CodProds, DigProds, TpCbars, CUnis FROM SigCdPam"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamRef")

            IF loc_nResultado < 1
                *-- legado: MessageBox('Favor Reinicializar o Processo!!!', 16,
                *--         'Falha na Conexao (CursorQuery - crSigCdPam)')
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdPam)")
            ELSE
                SELECT cursor_4c_PamRef
                GO TOP

                IF !EOF("cursor_4c_PamRef")
                    THIS.this_nPamCodProds = TratarNulo(CodProds, 0)
                    THIS.this_cPamDigProds = TratarNulo(DigProds, "")
                    THIS.this_nPamTpCbars  = TratarNulo(TpCbars, 0)
                    THIS.this_cPamCUnis    = TratarNulo(CUnis, "")
                ENDIF

                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_PamRef")
                USE IN cursor_4c_PamRef
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigOpRefBO.CarregarParametrosSistema")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarGrupoDestino - Equivalente a
    *   lcGrp = Iif(Type([pGru]) = [C], pGru, csTmpPro.Cgrus)
    *   .poDataMgr.CursorQuery([SigCdGrp],[csTmpGru],[CGrus],lcGrp,
    *                          [CGrus, DigGprs])
    * do Init legado (par_cGrupo ja chega resolvido pelo form, que aplica a
    * mesma regra do Iif). Grava o grupo em this_cGrupoDestino e o DigGprs
    * correspondente, que o form usa para decidir se o campo "Grupo de
    * Destino" eh digitavel.
    *
    * Devolve .F. quando a CONSULTA falha - o legado aborta o Init nesse caso.
    * Grupo informado que NAO existe em SigCdGrp nao eh falha: o cursor vem
    * vazio e DigGprs fica 0, exatamente como o legado, que le csTmpGru.DigGprs
    * em EOF (valor vazio) e cai no ramo "<> 1".
    *
    * Unica divergencia deliberada nesse caso de borda: o legado faz
    * ".GetNewCGrus.Value = csTmpGru.Cgrus" e portanto ESVAZIA o campo quando o
    * grupo nao existe; aqui o grupo pedido eh preservado, porque apagar o que
    * veio por parametro (ou o grupo do produto de origem) escondia do usuario
    * qual grupo foi recusado. Na pratica o ramo nao ocorre: o grupo vem de
    * pGru ou de SigCdPro.cgrus, que referenciam SigCdGrp.
    *==========================================================================
    PROCEDURE CarregarGrupoDestino(par_cGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGrupo, loc_oErro
        loc_lSucesso = .F.
        loc_cGrupo   = ALLTRIM(NVL(par_cGrupo, ""))

        TRY
            IF USED("cursor_4c_GrpDestRef")
                IF CURSORGETPROP("Buffering", "cursor_4c_GrpDestRef") > 1
                    TABLEREVERT(.T., "cursor_4c_GrpDestRef")
                ENDIF
                USE IN cursor_4c_GrpDestRef
            ENDIF

            loc_cSQL = "SELECT CGrus, DigGprs FROM SigCdGrp WHERE CGrus = " + ;
                EscaparSQL(loc_cGrupo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrpDestRef")

            IF loc_nResultado < 1
                *-- legado: MessageBox('Favor Reinicializar o Processo!!!', 16,
                *--         'Falha na Conexao (CursorQuery - csTmpGru)')
                MsgErro("Favor Reinicializar o Processo!!!" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdGrp)")
            ELSE
                SELECT cursor_4c_GrpDestRef
                GO TOP

                IF EOF("cursor_4c_GrpDestRef")
                    THIS.this_nGrupoDestinoDigGprs = 0
                ELSE
                    THIS.this_cGrupoDestino        = TratarNulo(CGrus, "")
                    THIS.this_nGrupoDestinoDigGprs = TratarNulo(DigGprs, 0)
                ENDIF

                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_GrpDestRef")
                USE IN cursor_4c_GrpDestRef
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigOpRefBO.CarregarGrupoDestino")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterDigitoGrandeGrupo - Equivalente ao par de linhas do legado
    *   CursorQuery('SigCdGpr','crSigCdGpr1','Codigos',TmpGruPro.Mercs)
    *   lcDigProds = Iif(Empty(crSigCdGpr1.DigAuts), crSigCdPam.DigProds,
    *                    crSigCdGpr1.DigAuts)
    * O legado faz a consulta ANTES do teste de tipo mas so LE o resultado no
    * ramo lnTpPro = 2; isolar num metodo mantem o ramo 2 identico ao legado
    * sem carregar cursor nos ramos que nao o leem.
    *
    * SigCdGpr.DigAuts e SigCdPam.DigProds sao ambos char(1) - o legado
    * concatena direto, sem ALLTRIM (o ALLTRIM final da expressao do codigo
    * cobre o caso de branco).
    *==========================================================================
    PROCEDURE ObterDigitoGrandeGrupo(par_cGrandeGrupo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDigProds, loc_cGpr, loc_oErro
        loc_cGpr      = ALLTRIM(NVL(par_cGrandeGrupo, ""))
        loc_cDigProds = THIS.this_cPamDigProds

        TRY
            IF USED("cursor_4c_GprRef")
                IF CURSORGETPROP("Buffering", "cursor_4c_GprRef") > 1
                    TABLEREVERT(.T., "cursor_4c_GprRef")
                ENDIF
                USE IN cursor_4c_GprRef
            ENDIF

            loc_cSQL = "SELECT Codigos, DigAuts FROM SigCdGpr WHERE Codigos = " + ;
                EscaparSQL(loc_cGpr)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GprRef")

            IF loc_nResultado < 1
                MsgErro("Favor reinicializar o processo !!!" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdGpr)")
            ELSE
                SELECT cursor_4c_GprRef
                GO TOP

                IF !EOF("cursor_4c_GprRef")
                    IF !EMPTY(TratarNulo(DigAuts, ""))
                        loc_cDigProds = TratarNulo(DigAuts, "")
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_GprRef")
                USE IN cursor_4c_GprRef
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigOpRefBO.ObterDigitoGrandeGrupo")
        ENDTRY

        RETURN loc_cDigProds
    ENDPROC

    *==========================================================================
    * GerarCodigoProdutoDestino - Transcricao do corpo de getNewCGrus.Valid,
    * a unica regra de negocio deste dialogo que CALCULA o codigo do produto
    * novo a partir do GRUPO de destino. Legado, literal:
    *
    *   lStrQuery = [Select CGrus, Mercs, CodProds, IdeCPros From SigCdGrp
    *                Where CGrus = '] + lcCGrus + [']
    *   lnTpPro = Iif(Empty(lcCGrus) Or Empty(TmpGruPro.CodProds),
    *                 crSigCdPam.CodProds, TmpGruPro.CodProds)
    *   If InList(lnTpPro,2,4,5) And Not Empty(lcCGrus)
    *       CursorQuery('SigCdGpr','crSigCdGpr1','Codigos',TmpGruPro.Mercs)
    *       If (lnTpPro = 2)
    *           lcDigProds = Iif(Empty(crSigCdGpr1.DigAuts),
    *                            crSigCdPam.DigProds, crSigCdGpr1.DigAuts)
    *           ThisForm.Newseq = fGerUniqueKey('PRODUTO' + Alltrim(lcCGrus))
    *           lcNewCPros = Alltrim(lcDigProds + lcCGrus +
    *                                Transform(ThisForm.NewSeq,'@L 99999'))
    *       Else
    *           ThisForm.NewSeq = fGerUniqueKey('PRODUTO' +
    *                                           Alltrim(TmpGruPro.IdeCPros))
    *           If (lnTpPro = 4)
    *               lcNewCPros = Alltrim(TmpGruPro.IdeCPros +
    *                              Transform(ThisForm.NewSeq,'@L 99999999'))
    *           Else
    *               lcNewCPros = Alltrim(TmpGruPro.IdeCPros +
    *                              Transform(ThisForm.NewSeq,'@L 99999'))
    *           EndIf
    *       EndIf
    *   EndIf
    *
    * A formula, a ordem dos operandos, as mascaras "@L" e o criterio
    * InList(2,4,5) sao REGRA DE NEGOCIO - transcritos literalmente (regra
    * #17: formula do legado se transcreve, nunca se reescreve). Tipo de
    * geracao fora de {2,4,5} NAO gera codigo: o usuario digita a mao. Por
    * isso retorno vazio NAO eh erro e o chamador nao avisa nada (regra #50:
    * universo vazio nao eh erro e nao se apaga o que o usuario digitou).
    *
    * Devolve o codigo gerado, ou "" quando o tipo nao gera automaticamente.
    * Efeito colateral fiel ao legado: grava this_nNewSeq.
    *==========================================================================
    PROCEDURE GerarCodigoProdutoDestino(par_cGrupo)
        LOCAL loc_cGrus, loc_cNewCPros, loc_cSQL, loc_nResultado, loc_nTpPro, ;
            loc_cDigProds, loc_cIdeCPros, loc_cMercs, loc_oErro
        loc_cGrus     = ALLTRIM(NVL(par_cGrupo, ""))
        loc_cNewCPros = ""
        loc_nTpPro    = 0
        loc_cIdeCPros = ""
        loc_cMercs    = ""
        loc_cDigProds = ""

        TRY
            IF USED("cursor_4c_GruProRef")
                IF CURSORGETPROP("Buffering", "cursor_4c_GruProRef") > 1
                    TABLEREVERT(.T., "cursor_4c_GruProRef")
                ENDIF
                USE IN cursor_4c_GruProRef
            ENDIF

            loc_cSQL = "SELECT CGrus, Mercs, CodProds, IdeCPros FROM SigCdGrp" + ;
                " WHERE CGrus = " + EscaparSQL(loc_cGrus)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruProRef")

            IF loc_nResultado < 1
                *-- legado: MessageBox('Favor reinicializar o processo !!!',16,
                *--         'Falha na Conexao (TmpGruPro)')
                MsgErro("Favor reinicializar o processo !!!" + CHR(13) + ;
                    CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o (SigCdGrp)")
            ELSE
                SELECT cursor_4c_GruProRef
                GO TOP

                *-- legado: lnTpPro = Iif(Empty(lcCGrus) Or
                *--             Empty(TmpGruPro.CodProds), crSigCdPam.CodProds,
                *--             TmpGruPro.CodProds)
                *-- Grupo inexistente deixa o cursor vazio: o legado le o campo
                *-- em EOF (valor vazio) e tambem cai no parametro do sistema.
                IF EOF("cursor_4c_GruProRef")
                    loc_nTpPro = THIS.this_nPamCodProds
                ELSE
                    loc_cMercs    = TratarNulo(Mercs, "")
                    loc_cIdeCPros = TratarNulo(IdeCPros, "")

                    IF EMPTY(loc_cGrus) OR EMPTY(TratarNulo(CodProds, 0))
                        loc_nTpPro = THIS.this_nPamCodProds
                    ELSE
                        loc_nTpPro = TratarNulo(CodProds, 0)
                    ENDIF
                ENDIF

                IF INLIST(loc_nTpPro, 2, 4, 5) AND !EMPTY(loc_cGrus)
                    IF loc_nTpPro = 2
                        loc_cDigProds     = THIS.ObterDigitoGrandeGrupo(loc_cMercs)
                        THIS.this_nNewSeq = fGerUniqueKey("PRODUTO" + ALLTRIM(loc_cGrus))

                        loc_cNewCPros = ALLTRIM(loc_cDigProds + loc_cGrus + ;
                            TRANSFORM(THIS.this_nNewSeq, "@L 99999"))
                    ELSE
                        THIS.this_nNewSeq = fGerUniqueKey("PRODUTO" + ALLTRIM(loc_cIdeCPros))

                        IF loc_nTpPro = 4
                            loc_cNewCPros = ALLTRIM(loc_cIdeCPros + ;
                                TRANSFORM(THIS.this_nNewSeq, "@L 99999999"))
                        ELSE
                            loc_cNewCPros = ALLTRIM(loc_cIdeCPros + ;
                                TRANSFORM(THIS.this_nNewSeq, "@L 99999"))
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_GruProRef")
                USE IN cursor_4c_GruProRef
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigOpRefBO.GerarCodigoProdutoDestino")
            loc_cNewCPros = ""
        ENDTRY

        RETURN loc_cNewCPros
    ENDPROC

    *==========================================================================
    * CancelarCodigoReservado - Transcricao do corpo de btnSair.Click, a
    * regra de negocio do CANCELAMENTO: devolve ao contador o sequencial que
    * GerarCodigoProdutoDestino tinha reservado, para o codigo nao ficar
    * "queimado" quando o usuario desiste da copia. Legado, literal:
    *
    *   lcCGrus = Thisform.GetNewCgrus.Value
    *   lcCPNew = Thisform.GetNewCPro.Value
    *   lStrQuery = [Select CGrus,CodProds,IdeCPros From SigCdGrp
    *                Where CGrus = ']+lcCGrus+[' ]
    *   If ThisForm.poDataMgr.SqlExecute(lStrQuery,'TmpGruPro') < 1
    *       ThisForm.Release
    *   EndIf
    *   lnTpPro = Iif(Empty(lcCGrus) Or Empty(TmpGruPro.CodProds),
    *                 crSigCdPam.CodProds, TmpGruPro.CodProds)
    *   If InList(lnTpPro,2,4,5) And !Empty(lcCGrus)
    *       lcCGrus = Alltrim(lcCGrus)
    *       If (lnTpPro = 2)
    *           _Codigo = Val(Substr(lcCPNew,Len(lcCGrus) + 2,5))
    *           =fCanUniqueKey(ThisForm.NewSeq,'PRODUTO' + Alltrim(lcCGrus))
    *       Else
    *           Select TmpGruPro
    *           Go Top
    *           If !Eof()
    *               =fCanUniqueKey(ThisForm.NewSeq,
    *                              'PRODUTO' + Alltrim(TmpGruPro.IdeCPros))
    *           EndIf
    *       EndIf
    *   EndIf
    *
    * O criterio InList(2,4,5) e as DUAS chaves de contador ('PRODUTO'+grupo
    * no tipo 2, 'PRODUTO'+IdeCPros nos tipos 4 e 5) sao os MESMOS de
    * GerarCodigoProdutoDestino - este metodo eh a inversa exata dele, e por
    * isso a chave tem de ser montada do mesmo jeito (regra #17: transcrever,
    * nunca reescrever; chave diferente devolveria o numero ao contador
    * ERRADO, em silencio).
    *
    * "_Codigo = Val(Substr(...))" do legado NAO foi transcrito: a variavel
    * recebe o valor e nunca eh lida em metodo nenhum do SCX (varrido o dump
    * inteiro) - eh codigo morto, nao efeito colateral.
    *
    * fCanUniqueKey eh CONSERVADORA de proposito (so devolve o numero quando
    * ele ainda eh o ultimo emitido para a chave) e ja trata sequencial <= 0,
    * entao chamar com this_nNewSeq zerado - usuario que fechou sem nunca ter
    * gerado codigo - eh inofensivo, igual ao legado, que tambem chama sempre.
    *
    * Devolve .T. quando o sequencial foi devolvido ao contador.
    *==========================================================================
    PROCEDURE CancelarCodigoReservado(par_cGrupo)
        LOCAL loc_cGrus, loc_cSQL, loc_nResultado, loc_nTpPro, loc_cIdeCPros, ;
            loc_lCancelou, loc_oErro
        loc_cGrus     = ALLTRIM(NVL(par_cGrupo, ""))
        loc_nTpPro    = 0
        loc_cIdeCPros = ""
        loc_lCancelou = .F.

        TRY
            IF USED("cursor_4c_GruCanRef")
                IF CURSORGETPROP("Buffering", "cursor_4c_GruCanRef") > 1
                    TABLEREVERT(.T., "cursor_4c_GruCanRef")
                ENDIF
                USE IN cursor_4c_GruCanRef
            ENDIF

            loc_cSQL = "SELECT CGrus, CodProds, IdeCPros FROM SigCdGrp" + ;
                " WHERE CGrus = " + EscaparSQL(loc_cGrus)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruCanRef")

            IF loc_nResultado < 1
                *-- legado: nao avisa nada - "If ... < 1 / ThisForm.Release",
                *-- ou seja, desiste do cancelamento e fecha a tela. Aqui so
                *-- devolvemos .F.; quem fecha eh o handler do botao.
                loc_lCancelou = .F.
            ELSE
                SELECT cursor_4c_GruCanRef
                GO TOP

                *-- legado: lnTpPro = Iif(Empty(lcCGrus) Or
                *--             Empty(TmpGruPro.CodProds), crSigCdPam.CodProds,
                *--             TmpGruPro.CodProds)
                IF EOF("cursor_4c_GruCanRef")
                    loc_nTpPro = THIS.this_nPamCodProds
                ELSE
                    loc_cIdeCPros = TratarNulo(IdeCPros, "")

                    IF EMPTY(loc_cGrus) OR EMPTY(TratarNulo(CodProds, 0))
                        loc_nTpPro = THIS.this_nPamCodProds
                    ELSE
                        loc_nTpPro = TratarNulo(CodProds, 0)
                    ENDIF
                ENDIF

                IF INLIST(loc_nTpPro, 2, 4, 5) AND !EMPTY(loc_cGrus)
                    IF loc_nTpPro = 2
                        loc_lCancelou = fCanUniqueKey(THIS.this_nNewSeq, ;
                            "PRODUTO" + ALLTRIM(loc_cGrus))
                    ELSE
                        *-- legado: "Select TmpGruPro / Go Top / If !Eof()" -
                        *-- sem linha em SigCdGrp nao ha IdeCPros, logo nao ha
                        *-- chave de contador a devolver.
                        IF !EOF("cursor_4c_GruCanRef")
                            loc_lCancelou = fCanUniqueKey(THIS.this_nNewSeq, ;
                                "PRODUTO" + ALLTRIM(loc_cIdeCPros))
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_GruCanRef")
                USE IN cursor_4c_GruCanRef
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                "SigOpRefBO.CancelarCodigoReservado")
            loc_lCancelou = .F.
        ENDTRY

        RETURN loc_lCancelou
    ENDPROC

    *==========================================================================
    * ObterRetorno - Contrato de retorno do dialogo, equivalente ao
    * PROCEDURE Unload legado ("Return ThisForm.RetCodProduto").
    *
    * Formato do legado, montado por Inserir(): PADR(codigo,14) +
    * STR(quantidade,2) - o chamador le com Left(<retorno>,14) para o codigo
    * e o resto para a quantidade de copias a imprimir (ver SIGOPPRO/SIGMVCAB,
    * que abrem este dialogo). Vazio = nada foi gerado.
    *
    * A fonte UNICA eh this_cRetCodProduto; este metodo so a expoe para o
    * form (que a espelha no proprio cache, porque o Unload dispara depois de
    * FormBase.Destroy liberar o BO).
    *==========================================================================
    FUNCTION ObterRetorno()
        RETURN NVL(THIS.this_cRetCodProduto, "")
    ENDFUNC

    *==========================================================================
    * ExisteProduto - .T. quando o codigo ja esta gravado em SigCdPro.
    * Usado tanto para confirmar que o produto de ORIGEM existe quanto para
    * recusar um codigo de DESTINO duplicado (btnConfirmar.Click legado:
    * "A Nova Referencia Informada Ja Esta Cadastrada!!!").
    *==========================================================================
    PROCEDURE ExisteProduto(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste, loc_oErro
        loc_lExiste = .F.

        TRY
            IF USED("cursor_4c_ExisteProRef")
                USE IN cursor_4c_ExisteProRef
            ENDIF

            loc_cSQL = "SELECT cpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(PADR(ALLTRIM(NVL(par_cCodigo, "")), 14))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExisteProRef")

            IF loc_nResultado >= 0
                loc_lExiste = (RECCOUNT("cursor_4c_ExisteProRef") > 0)
            ELSE
                MsgErro("Erro ao consultar o produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_ExisteProRef")
                USE IN cursor_4c_ExisteProRef
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigOpRefBO.ExisteProduto")
            loc_lExiste = .F.
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * ValidarDados - Equivalente as checagens do inicio de btnConfirmar.Click:
    *   1) produto de origem e produto novo informados
    *   2) produto de origem existe
    *   3) produto novo ainda nao cadastrado
    *
    * NAO sobrescreve fVerificarBarras(lcNewPros, crSigCdPam.TpCBars): a
    * funcao (SIGFUNCS.PRG) nao veio no acervo (regra #27) e so reforcava o
    * FORMATO do codigo digitado - no-op documentado, como em
    * Formsigoppro.TxtProdLostFocus. A duplicidade (ponto que de fato grava
    * dado errado se ignorado) continua verificada abaixo.
    *
    * So DEFINE this_cMensagemErro - quem EXIBE eh THIS.ExibirFalha(), chamado
    * pelo Salvar() de BusinessBase (regra #20: falha nunca eh muda).
    *==========================================================================
    FUNCTION ValidarDados()
        LOCAL loc_cOrigem, loc_cNovo

        THIS.this_cMensagemErro = ""

        loc_cOrigem = PADR(ALLTRIM(NVL(THIS.this_cCodProdOrigem, "")), 14)
        loc_cNovo   = PADR(ALLTRIM(NVL(THIS.this_cCodProdDestino, "")), 14)

        IF EMPTY(ALLTRIM(loc_cOrigem))
            THIS.this_cMensagemErro = "Produto de origem " + CHR(233) + ;
                " obrigat" + CHR(243) + "rio."
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(loc_cNovo))
            *-- legado: "Codigo de Produto Invalido!!!"
            THIS.this_cMensagemErro = "C" + CHR(243) + "digo de Produto Inv" + ;
                CHR(225) + "lido!!!"
            RETURN .F.
        ENDIF

        IF THIS.this_nQuantidade <= 0
            THIS.this_nQuantidade = 1
        ENDIF

        IF !THIS.ExisteProduto(loc_cOrigem)
            THIS.this_cMensagemErro = "O Produto de Origem Informado N" + ;
                CHR(227) + "o Existe!!!"
            RETURN .F.
        ENDIF

        IF THIS.ExisteProduto(loc_cNovo)
            *-- legado: "A Nova Referencia Informada Ja Esta Cadastrada!!!"
            THIS.this_cMensagemErro = "A Nova Refer" + CHR(234) + "ncia " + ;
                "Informada J" + CHR(225) + " Est" + CHR(225) + " Cadastrada!!!"
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *==========================================================================
    * GerarCodigoBarras - Cbars do produto NOVO. Transcricao de
    * btnConfirmar.Click:
    *   ThisForm.Inicio = fGerUniqueKey('SigCdPro')
    *   Cbar  = Transform(ThisForm.Inicio, '@L 9999999999999')
    *   Cbar1 = fDigVerificador(Cbar)
    *   Cbar2 = Cbar + Transform(Cbar1, '@L 9')
    *   Replace Cbars With Val(Cbar2)
    * (mesmo algoritmo de ProdutoBO.GerarCodigoBarras - Erro188)
    *==========================================================================
    PROCEDURE GerarCodigoBarras()
        LOCAL loc_nSeq, loc_cBar, loc_nDig, loc_cBar2

        loc_nSeq = fGerUniqueKey("SigCdPro")
        THIS.this_nInicio = loc_nSeq

        IF loc_nSeq <= 0
            RETURN 0
        ENDIF

        loc_cBar  = TRANSFORM(loc_nSeq, "@L 9999999999999")
        loc_nDig  = fDigVerificador(loc_cBar)
        loc_cBar2 = loc_cBar + TRANSFORM(loc_nDig, "@L 9")

        RETURN VAL(loc_cBar2)
    ENDPROC

    *==========================================================================
    * MontarInsertCopia - Monta "INSERT INTO T (cols) SELECT exprs FROM T
    * WHERE <where>", trocando por EXPRESSAO as colunas sobrepostas.
    *
    * par_cTabela    - tabela (origem E destino: eh auto-copia)
    * par_cOverrides - "col=<expr SQL>|col=<expr SQL>|..." (col sem aspas,
    *                  expr ja no formato final de SQL Server)
    * par_cWhere     - clausula WHERE, sem a palavra WHERE
    *
    * A lista de colunas vem do INFORMATION_SCHEMA em tempo de execucao de
    * proposito: SigCdPro tem mais de 170 colunas (varias "text") e fixa-las
    * aqui arrisca ficar desatualizado. Mesmo padrao de
    * ProdutoBO.MontarInsertCopia (Erro188), copiado aqui porque VFP9 nao tem
    * heranca entre BOs independentes.
    *
    * Devolve "" se nao conseguir ler as colunas, ou se algum override pedido
    * nao casar com coluna real (regra #22: erro de grafia nao pode passar
    * em silencio).
    *==========================================================================
    PROTECTED PROCEDURE MontarInsertCopia(par_cTabela, par_cOverrides, par_cWhere)
        LOCAL loc_cTab, loc_cCols, loc_cExprs, loc_cCol, loc_cOvr, loc_nPos, ;
            loc_cValor, loc_nResultado, loc_cSQL, loc_nUsados, loc_nPedidos

        loc_cTab = ALLTRIM(par_cTabela)

        IF USED("cursor_4c_ColsCopiaRef")
            USE IN cursor_4c_ColsCopiaRef
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, ;
            "SELECT COLUMN_NAME AS col FROM INFORMATION_SCHEMA.COLUMNS" + ;
            " WHERE TABLE_NAME = " + EscaparSQL(loc_cTab) + ;
            " ORDER BY ORDINAL_POSITION", "cursor_4c_ColsCopiaRef")

        IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ColsCopiaRef") = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                "vel ler as colunas de " + loc_cTab + ":" + CHR(13) + CapturarErroSQL()
            RETURN ""
        ENDIF

        loc_cCols   = ""
        loc_cExprs  = ""
        loc_nUsados = 0

        SELECT cursor_4c_ColsCopiaRef
        SCAN
            loc_cCol = ALLTRIM(cursor_4c_ColsCopiaRef.col)

            loc_cValor = ""
            loc_cOvr   = "|" + ALLTRIM(NVL(par_cOverrides, "")) + "|"
            loc_nPos   = AT("|" + LOWER(loc_cCol) + "=", LOWER(loc_cOvr))

            IF loc_nPos > 0
                loc_cValor  = SUBSTR(loc_cOvr, loc_nPos + LEN(loc_cCol) + 2)
                loc_cValor  = LEFT(loc_cValor, AT("|", loc_cValor) - 1)
                loc_nUsados = loc_nUsados + 1
            ELSE
                loc_cValor = loc_cCol
            ENDIF

            loc_cCols  = loc_cCols  + IIF(EMPTY(loc_cCols),  "", ", ") + loc_cCol
            loc_cExprs = loc_cExprs + IIF(EMPTY(loc_cExprs), "", ", ") + loc_cValor
        ENDSCAN

        IF USED("cursor_4c_ColsCopiaRef")
            USE IN cursor_4c_ColsCopiaRef
        ENDIF

        loc_nPedidos = 0
        IF !EMPTY(NVL(par_cOverrides, ""))
            loc_nPedidos = OCCURS("|", ALLTRIM(par_cOverrides)) + 1
        ENDIF

        IF loc_nUsados < loc_nPedidos
            THIS.this_cMensagemErro = "C" + CHR(243) + "pia de " + loc_cTab + ;
                ": " + TRANSFORM(loc_nPedidos - loc_nUsados) + " de " + ;
                TRANSFORM(loc_nPedidos) + " campos a sobrepor n" + CHR(227) + ;
                "o existem na tabela." + CHR(13) + ALLTRIM(par_cOverrides)
            RETURN ""
        ENDIF

        loc_cSQL = "INSERT INTO " + loc_cTab + " (" + loc_cCols + ")" + ;
            " SELECT " + loc_cExprs + " FROM " + loc_cTab + ;
            " WHERE " + par_cWhere

        RETURN loc_cSQL
    ENDPROC

    *==========================================================================
    * CopiarTabelaFilha - Clona as linhas de uma tabela filha do produto
    * (SigPrCpo/SigCdPrf), uma linha de origem por INSERT, para que cada
    * registro novo receba a SUA chave Fortyus (regra #22: chave repetida
    * colide no indice unico). Acumula em THIS.this_cLoteSQL - nao executa
    * aqui (ver execucao atomica em Inserir()).
    *
    * par_cTabela   - tabela filha
    * par_cCampoPro - coluna que guarda o produto (cpros / produtos)
    * par_cCampoPk  - coluna da chave Fortyus (cidchaves)
    * par_cOrigem   - produto de origem
    * par_cNovo     - produto novo
    * par_cExtra    - overrides ADICIONAIS ("col=expr|...") ou ""
    * par_cFiltro   - condicao extra no SELECT de origem, ou ""
    *==========================================================================
    PROTECTED PROCEDURE CopiarTabelaFilha(par_cTabela, par_cCampoPro, par_cCampoPk, ;
            par_cOrigem, par_cNovo, par_cExtra, par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_cPk, loc_cOvr, loc_lOk

        loc_lOk = .T.

        IF USED("cursor_4c_PkCopiaRef")
            USE IN cursor_4c_PkCopiaRef
        ENDIF

        loc_cSQL = "SELECT " + par_cCampoPk + " AS pk FROM " + par_cTabela + ;
            " WHERE " + par_cCampoPro + " = " + EscaparSQL(par_cOrigem)

        IF !EMPTY(NVL(par_cFiltro, ""))
            loc_cSQL = loc_cSQL + " AND " + par_cFiltro
        ENDIF

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PkCopiaRef")

        IF loc_nResultado < 0
            THIS.this_cMensagemErro = "Erro ao ler " + par_cTabela + ":" + ;
                CHR(13) + CapturarErroSQL()
            RETURN .F.
        ENDIF

        SELECT cursor_4c_PkCopiaRef
        SCAN WHILE loc_lOk
            loc_cPk = ALLTRIM(NVL(cursor_4c_PkCopiaRef.pk, ""))

            loc_cOvr = par_cCampoPro + "=" + EscaparSQL(par_cNovo) + ;
                "|" + par_cCampoPk + "=" + EscaparSQL(fUniqueIds())

            IF !EMPTY(NVL(par_cExtra, ""))
                loc_cOvr = loc_cOvr + "|" + par_cExtra
            ENDIF

            loc_cSQL = THIS.MontarInsertCopia(par_cTabela, loc_cOvr, ;
                par_cCampoPk + " = " + EscaparSQL(loc_cPk))

            IF EMPTY(loc_cSQL)
                loc_lOk = .F.
            ELSE
                THIS.this_cLoteSQL = THIS.this_cLoteSQL + loc_cSQL + ";" + CHR(13) + CHR(10)
            ENDIF
        ENDSCAN

        IF USED("cursor_4c_PkCopiaRef")
            USE IN cursor_4c_PkCopiaRef
        ENDIF

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * Inserir - Equivalente a btnConfirmar.Click + Auxmontadescs + mSv_Inserir
    *
    * Gera um PRODUTO NOVO (SigCdPro) a partir do produto de ORIGEM, copiando
    * tambem a composicao (SigPrCpo) e as linhas (SigCdPrf). Server-side
    * (INSERT...SELECT) em vez de Scatter/Insert From Memvar do legado - pelos
    * mesmos motivos de ProdutoBO.CopiarProduto: nao trazer ~170 colunas (text
    * inclusive) ao VFP so para devolver, e cobrir toda coluna NOT NULL sem
    * precisar listar/adivinhar (regra #22).
    *
    * Overrides transcritos do legado:
    *   Cpros                -> sempre o novo codigo
    *   CGrus                -> so muda se um grupo de destino foi informado
    *                           E eh diferente do grupo de origem (Mercs NAO
    *                           eh resincronizado - SIGOPREF legado nao faz
    *                           isso, diferente do cmdAcabado do Cadastro de
    *                           Produtos; regra #17 - transcrever, nao
    *                           reescrever)
    *   Situas                -> Opc_situacao.Value (this_nSituacao)
    *   nIdentFixa             -> IdentFixa recebido por parametro
    *   Datas / DtIncs         -> GETDATE()
    *   Flagctabs = 1 / Transps = 0
    *   UsuIncs                -> usuario logado
    *   CProEqs                -> codigo de ORIGEM, exceto quando CadPro = 5
    *                             (fica em branco)
    *   Cbars                  -> THIS.GerarCodigoBarras()
    *   CodFinP / Encoms / FigJpgs -> so quando CadPro = 5, lidos de SigOpCdd
    *   DPros                  -> so sobrescrita quando this_cDescProdDestino
    *                             foi preenchido manualmente (ramo MontaGrDs=5
    *                             "Manual" do Auxmontadescs legado). Nos
    *                             demais modos a descricao viria de
    *                             fGerarDescrs/fGerDescritivo (SIGFUNCS.PRG) -
    *                             funcoes que NAO vieram no acervo (regra #27)
    *                             e cujo algoritmo depende de SigCdPrd/
    *                             SigCdDic sem fonte disponivel: o produto
    *                             copiado mantem a descricao do ORIGINAL
    *                             nesses casos - no-op documentado, nunca um
    *                             palpite de formula (regra #17).
    *
    * this_cRetCodProduto fica no MESMO formato do legado (Padr(cod,14) +
    * Str(qtd,2)) - a quantidade eh so informacao devolvida ao chamador
    * (impressao de N copias/etiquetas), nunca gera N produtos aqui.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_cOrigem, loc_cNovo, loc_cGrupoOrigem, loc_cGrupoNovo, ;
            loc_cOvr, loc_cSQL, loc_nResultado, loc_lOk, loc_oErro, ;
            loc_nCbars, loc_cProEqs, loc_cDopes

        loc_lOk = .F.

        *-- A entidade produzida por esta operacao eh o PRODUTO (SigCdPro),
        *-- nao SigCdPrf (ultima tabela do AddCursor legado, fixada no Init da
        *-- Fase 1 so para dar algum valor a this_cTabela/this_cCampoChave) -
        *-- refinamos aqui para a auditoria registrar o registro certo.
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"

        TRY
            loc_cOrigem      = PADR(ALLTRIM(NVL(THIS.this_cCodProdOrigem, "")), 14)
            loc_cNovo        = PADR(ALLTRIM(NVL(THIS.this_cCodProdDestino, "")), 14)
            loc_cGrupoOrigem = PADR(ALLTRIM(NVL(THIS.this_cGrupoOrigem, "")), 3)
            loc_cGrupoNovo   = PADR(ALLTRIM(NVL(THIS.this_cGrupoDestino, "")), 3)

            loc_nCbars  = THIS.GerarCodigoBarras()
            loc_cProEqs = IIF(THIS.this_nCadPro = 5, SPACE(14), loc_cOrigem)

            THIS.this_cLoteSQL = ""

            *-- 1) o PRODUTO
            loc_cOvr = "cpros=" + EscaparSQL(loc_cNovo)

            IF !EMPTY(loc_cGrupoNovo) AND loc_cGrupoOrigem <> loc_cGrupoNovo
                loc_cOvr = loc_cOvr + "|cgrus=" + EscaparSQL(loc_cGrupoNovo)
            ENDIF

            loc_cOvr = loc_cOvr + ;
                "|situas="     + FormatarNumeroSQL(THIS.this_nSituacao, 0) + ;
                "|nidentfixa=" + FormatarNumeroSQL(THIS.this_nIdentFixa, 0) + ;
                "|datas="      + "GETDATE()" + ;
                "|dtincs="     + "GETDATE()" + ;
                "|flagctabs=1" + ;
                "|transps=0" + ;
                "|usuincs="    + EscaparSQL(LEFT(ALLTRIM(NVL(gc_4c_UsuarioLogado, "")), 10)) + ;
                "|cproeqs="    + EscaparSQL(loc_cProEqs) + ;
                "|cbars="      + FormatarNumeroSQL(loc_nCbars, 0)

            IF !EMPTY(ALLTRIM(NVL(THIS.this_cDescProdDestino, "")))
                loc_cOvr = loc_cOvr + "|dpros=" + ;
                    EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescProdDestino), 65))
            ENDIF

            *-- CadPro = 5: cadastro especial (foto/serial) via SigOpCdd
            IF THIS.this_nCadPro = 5
                loc_cDopes = PADR(ALLTRIM(NVL(THIS.this_cDopes, "")), 20)

                IF USED("cursor_4c_OpCddRef")
                    USE IN cursor_4c_OpCddRef
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT finpads, nlimpafoto, nseriapads FROM SigOpCdd" + ;
                    " WHERE dopes = " + EscaparSQL(loc_cDopes), "cursor_4c_OpCddRef")

                IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_OpCddRef") > 0
                    GO TOP IN cursor_4c_OpCddRef

                    loc_cOvr = loc_cOvr + "|codfinp=" + ;
                        EscaparSQL(LEFT(ALLTRIM(NVL(cursor_4c_OpCddRef.finpads, "")), 3))

                    IF INLIST(VAL(TRANSFORM(NVL(cursor_4c_OpCddRef.nseriapads, 0))), 1, 2)
                        loc_cOvr = loc_cOvr + "|encoms=" + ;
                            FormatarNumeroSQL(NVL(cursor_4c_OpCddRef.nseriapads, 0), 0)
                    ENDIF

                    IF VAL(TRANSFORM(NVL(cursor_4c_OpCddRef.nlimpafoto, 0))) = 1
                        loc_cOvr = loc_cOvr + "|figjpgs=NULL"
                    ENDIF
                ENDIF

                IF USED("cursor_4c_OpCddRef")
                    USE IN cursor_4c_OpCddRef
                ENDIF
            ENDIF

            loc_cSQL = THIS.MontarInsertCopia("SigCdPro", loc_cOvr, ;
                "cpros = " + EscaparSQL(loc_cOrigem))

            IF EMPTY(loc_cSQL)
                loc_lOk = .F.
            ELSE
                THIS.this_cLoteSQL = loc_cSQL + ";" + CHR(13) + CHR(10)
                loc_lOk = .T.
            ENDIF

            *-- 2) composicao e linhas, na mesma ordem do legado
            IF loc_lOk
                loc_lOk = THIS.CopiarTabelaFilha("SigPrCpo", "cpros", "cidchaves", ;
                    loc_cOrigem, loc_cNovo, "dtmovs=GETDATE()", "")
            ENDIF

            IF loc_lOk
                *-- SigCdPrf guarda o produto em "produtos", nao em "cpros"
                loc_lOk = THIS.CopiarTabelaFilha("SigCdPrf", "produtos", "cidchaves", ;
                    loc_cOrigem, loc_cNovo, "", "")
            ENDIF

            *-- 3) execucao ATOMICA do lote - SAVE TRANSACTION, nunca
            *-- BEGIN/COMMIT isolado via SQLEXEC (a conexao ja abre com
            *-- @@TRANCOUNT = 1 - memoria "begin_commit_via_sqlexec_nao_
            *-- protege" / Erro188 / ProdutoBO.CopiarProduto).
            IF loc_lOk AND !EMPTY(THIS.this_cLoteSQL)
                loc_cSQL = "SET NOCOUNT ON;" + CHR(13) + CHR(10) + ;
                    "DECLARE @nivel int = @@TRANCOUNT;" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN TRANSACTION" + CHR(13) + CHR(10) + ;
                    "ELSE SAVE TRANSACTION Ref4c;" + CHR(13) + CHR(10) + ;
                    "BEGIN TRY" + CHR(13) + CHR(10) + ;
                    THIS.this_cLoteSQL + ;
                    "IF @nivel = 0 COMMIT TRANSACTION;" + CHR(13) + CHR(10) + ;
                    "END TRY" + CHR(13) + CHR(10) + ;
                    "BEGIN CATCH" + CHR(13) + CHR(10) + ;
                    "IF @nivel = 0 BEGIN IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION; END" + CHR(13) + CHR(10) + ;
                    "ELSE BEGIN IF XACT_STATE() = 1 ROLLBACK TRANSACTION Ref4c; END;" + CHR(13) + CHR(10) + ;
                    "THROW;" + CHR(13) + CHR(10) + ;
                    "END CATCH"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao gerar o novo produto:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                    loc_lOk = .F.
                ELSE
                    THIS.this_cCodProdDestino = loc_cNovo
                    THIS.this_cRetCodProduto  = PADR(loc_cNovo, 14) + ;
                        STR(THIS.this_nQuantidade, 2)

                    THIS.RegistrarAuditoria("INSERT")
                    loc_lOk = .T.
                ENDIF
            ELSE
                IF EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
                    THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + ;
                        CHR(237) + "vel gerar o novo produto."
                ENDIF
                loc_lOk = .F.
            ENDIF

            THIS.this_cLoteSQL = ""

        CATCH TO loc_oErro
            THIS.this_cLoteSQL = ""
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao Replicar Produto")
            loc_lOk = .F.
        ENDTRY

        RETURN loc_lOk
    ENDPROC

    *==========================================================================
    * Atualizar - SIGOPREF nao tem ramo de alteracao no legado: btnConfirmar.
    * Click sempre cria um produto novo. this_lNovoRegistro fica sempre .T.
    * nesta tela (o form, na fase 3+, chama THIS.NovoRegistro() no Init), e
    * este metodo so existe para cumprir o contrato PUBLIC de BusinessBase
    * (regra #51 - nunca PROTECTED, mesmo sem uso real).
    *==========================================================================
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Esta opera" + CHR(231) + CHR(227) + "o " + ;
            "sempre gera um produto novo a partir de outro - n" + CHR(227) + ;
            "o h" + CHR(225) + " altera" + CHR(231) + CHR(227) + "o de " + ;
            "registro existente."
        RETURN .F.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Chave do registro criado por Inserir() (o produto
    * NOVO em SigCdPro). PADR ate 14 porque cpros eh char(14) (regra #42).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN PADR(ALLTRIM(NVL(THIS.this_cCodProdDestino, "")), 14)
    ENDFUNC

ENDDEFINE
