*==============================================================================
* ImpBO.prg - Business Object para Cadastro de Impressoras
* Tabela: SigCdmp
* Migrado de: SIGCDIMP.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS ImpBO AS BusinessBase

    *-- Identificacao
    this_cImpres    = ""    && Impressora (C30) - PK visivel
    this_cIdChaves  = ""    && Chave interna do framework (C)

    *-- Dados principais (pg1)
    this_nRates     = 0     && Rate
    this_nTitulos   = 0     && Titulo (linhas por pagina)
    this_nBarras    = 0     && Barra (cpi)
    this_nMaxcols   = 0     && Maximo de Colunas

    *-- Checkboxes
    this_lExps      = .F.   && Expandido
    this_lGraficos  = .F.   && Graficos habilitado
    this_lChkChqf   = .F.   && Cheque Formulario Continuo

    *-- OptionGroups
    this_nTpImpres  = 0     && Tipo de Impressora (1=Boleto, 2=Etiqueta, 3=Boleto Zebra, 4=Padrao)
    this_nImpEtis   = 0     && Tipo Etiqueta (1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)

    *-- Tipo grafico e etiqueta padrao
    this_cTipos         = ""    && Tipo de Grafico (C - dropdown: Epson Esc K, Epson Esc * m n, Mecaf)
    this_cCetiquetas    = ""    && Etiqueta Padrao (C - vem de SigCdTpe.Cetiquetas)

    *-- Ajustes de etiqueta
    this_nAjVerts   = 0     && Ajuste Vertical (0-999)
    this_nAjHorzs   = 0     && Ajuste Horizontal (0-9999)
    this_nAjVelos   = 3     && Velocidade (1-3, default 3)
    this_nAjDens    = 20    && Densidade (10-20, default 20)

    *-- Comandos de controle (M - memo/editbox)
    this_cExpds     = ""    && Desativar Negrito
    this_cExpas     = ""    && Ativar Negrito
    this_cBarcmds   = ""    && Codigo de Barras
    this_cFontes    = ""    && Inicializacao
    this_cFonte2s   = ""    && Ativar Fonte Pequena
    this_cFontemp1s = ""    && Aciona Guilhotina

    *-- Posicionamento cheque (pg2) - coordenadas linha/coluna
    *-- Valor em Numeros
    this_nNlivl1s   = 0     && Linha
    this_nNclvl1s   = 0     && Coluna

    *-- Valor por Extenso (1a Linha)
    this_nNlivext1s = 0     && Linha
    this_nNclvext1s = 0     && Coluna

    *-- Valor por Extenso (2a Linha)
    this_nNlivext2s = 0     && Linha
    this_nNclvext2s = 0     && Coluna

    *-- Favorecido
    this_nNlinom1s  = 0     && Linha
    this_nNclnom1s  = 0     && Coluna

    *-- Cidade
    this_nNlicid1s  = 0     && Linha
    this_nNclcid1s  = 0     && Coluna

    *-- Dia
    this_nNlidia1s  = 0     && Linha
    this_nNcldia1s  = 0     && Coluna

    *-- Mes
    this_nNlimes1s  = 0     && Linha
    this_nNclmes1s  = 0     && Coluna

    *-- Ano
    this_nNliano1s  = 0     && Linha
    this_nNclano1s  = 0     && Coluna

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "SigCdmp"
        THIS.this_cCampoChave  = "Impres"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cImpres
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
                THIS.this_cImpres      = TratarNulo(impres,     "C")
                THIS.this_cIdChaves    = TratarNulo(cIdChaves,  "C")
                THIS.this_nRates       = TratarNulo(rates,      "N")
                THIS.this_nTitulos     = TratarNulo(titulos,    "N")
                THIS.this_nBarras      = TratarNulo(barras,     "N")
                THIS.this_nMaxcols     = TratarNulo(maxcols,    "N")
                THIS.this_lExps        = (TratarNulo(exps,      "N") = 1)
                THIS.this_lGraficos    = (TratarNulo(graficos,  "N") = 1)
                THIS.this_lChkChqf     = (TratarNulo(nchqfs,    "N") = 1)
                THIS.this_nTpImpres    = TratarNulo(nTpImpres,  "N")
                THIS.this_nImpEtis     = TratarNulo(ImpEtis,    "N")
                THIS.this_cTipos       = TratarNulo(Tipos,      "C")
                THIS.this_cCetiquetas  = TratarNulo(cetiquetas, "C")
                THIS.this_nAjVerts     = TratarNulo(AjVerts,    "N")
                THIS.this_nAjHorzs     = TratarNulo(AjHorzs,    "N")
                THIS.this_nAjVelos     = TratarNulo(AjVelos,    "N")
                THIS.this_nAjDens      = TratarNulo(AjDens,     "N")
                THIS.this_cExpds       = TratarNulo(expds,      "C")
                THIS.this_cExpas       = TratarNulo(expas,      "C")
                THIS.this_cBarcmds     = TratarNulo(barcmds,    "C")
                THIS.this_cFontes      = TratarNulo(fontes,     "C")
                THIS.this_cFonte2s     = TratarNulo(fonte2s,    "C")
                THIS.this_cFontemp1s   = TratarNulo(fontemp1s,  "C")
                THIS.this_nNlivl1s     = TratarNulo(nlivl1s,    "N")
                THIS.this_nNclvl1s     = TratarNulo(nclvl1s,    "N")
                THIS.this_nNlivext1s   = TratarNulo(nlivext1s,  "N")
                THIS.this_nNclvext1s   = TratarNulo(nclvext1s,  "N")
                THIS.this_nNlivext2s   = TratarNulo(nlivext2s,  "N")
                THIS.this_nNclvext2s   = TratarNulo(nclvext2s,  "N")
                THIS.this_nNlinom1s    = TratarNulo(nlinom1s,   "N")
                THIS.this_nNclnom1s    = TratarNulo(nclnom1s,   "N")
                THIS.this_nNlicid1s    = TratarNulo(nlicid1s,   "N")
                THIS.this_nNclcid1s    = TratarNulo(nclcid1s,   "N")
                THIS.this_nNlidia1s    = TratarNulo(nlidia1s,   "N")
                THIS.this_nNcldia1s    = TratarNulo(ncldia1s,   "N")
                THIS.this_nNlimes1s    = TratarNulo(nlimes1s,   "N")
                THIS.this_nNclmes1s    = TratarNulo(nclmes1s,   "N")
                THIS.this_nNliano1s    = TratarNulo(nliano1s,   "N")
                THIS.this_nNclano1s    = TratarNulo(nclano1s,   "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ImpBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cImpres))
            MsgAviso("Impressora n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarImpressoraExistente(THIS.this_cImpres)
                MsgAviso("Impressora j" + CHR(225) + " cadastrada!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarImpressoraExistente - Verifica se Impres ja existe
    *====================================================================
    PROCEDURE VerificarImpressoraExistente(par_cImpres)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdmp WHERE impres = " + ;
                EscaparSQL(par_cImpres)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkImp")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkImp")
                SELECT cursor_4c_ChkImp
                loc_lExiste = (cursor_4c_ChkImp.qtd > 0)
                USE IN cursor_4c_ChkImp
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar impressora:" + CHR(13) + loException.Message, "ImpBO.VerificarImpressoraExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cChave = fUniqueIds()
            THIS.this_cIdChaves = loc_cChave

            loc_cSQL = "INSERT INTO SigCdmp (impres, cIdChaves, rates, titulos, barras, maxcols," + ;
                " exps, graficos, nchqfs, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
                " AjVerts, AjHorzs, AjVelos, AjDens," + ;
                " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
                " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
                " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
                " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cImpres) + ", " + ;
                EscaparSQL(loc_cChave) + ", " + ;
                FormatarNumeroSQL(THIS.this_nRates,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTitulos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nBarras,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nMaxcols, 0) + ", " + ;
                IIF(THIS.this_lExps,     "1", "0") + ", " + ;
                IIF(THIS.this_lGraficos, "1", "0") + ", " + ;
                IIF(THIS.this_lChkChqf,  "1", "0") + ", " + ;
                FormatarNumeroSQL(THIS.this_nTpImpres, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nImpEtis,   0) + ", " + ;
                EscaparSQL(THIS.this_cTipos) + ", " + ;
                EscaparSQL(THIS.this_cCetiquetas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjVerts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjHorzs, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjVelos, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nAjDens,  0) + ", " + ;
                EscaparSQL(THIS.this_cExpds) + ", " + ;
                EscaparSQL(THIS.this_cExpas) + ", " + ;
                EscaparSQL(THIS.this_cBarcmds) + ", " + ;
                EscaparSQL(THIS.this_cFontes) + ", " + ;
                EscaparSQL(THIS.this_cFonte2s) + ", " + ;
                EscaparSQL(THIS.this_cFontemp1s) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivl1s,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvl1s,   0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivext1s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvext1s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlivext2s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclvext2s, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlinom1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclnom1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlicid1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclcid1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlidia1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNcldia1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNlimes1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclmes1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNliano1s,  0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNclano1s,  0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ImpBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdmp SET" + ;
                " rates    = " + FormatarNumeroSQL(THIS.this_nRates,   0) + "," + ;
                " titulos  = " + FormatarNumeroSQL(THIS.this_nTitulos, 0) + "," + ;
                " barras   = " + FormatarNumeroSQL(THIS.this_nBarras,  0) + "," + ;
                " maxcols  = " + FormatarNumeroSQL(THIS.this_nMaxcols, 0) + "," + ;
                " exps     = " + IIF(THIS.this_lExps,     "1", "0") + "," + ;
                " graficos = " + IIF(THIS.this_lGraficos, "1", "0") + "," + ;
                " nchqfs   = " + IIF(THIS.this_lChkChqf,  "1", "0") + "," + ;
                " nTpImpres = " + FormatarNumeroSQL(THIS.this_nTpImpres, 0) + "," + ;
                " ImpEtis  = " + FormatarNumeroSQL(THIS.this_nImpEtis,   0) + "," + ;
                " Tipos    = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                " cetiquetas = " + EscaparSQL(THIS.this_cCetiquetas) + "," + ;
                " AjVerts  = " + FormatarNumeroSQL(THIS.this_nAjVerts, 0) + "," + ;
                " AjHorzs  = " + FormatarNumeroSQL(THIS.this_nAjHorzs, 0) + "," + ;
                " AjVelos  = " + FormatarNumeroSQL(THIS.this_nAjVelos, 0) + "," + ;
                " AjDens   = " + FormatarNumeroSQL(THIS.this_nAjDens,  0) + "," + ;
                " expds    = " + EscaparSQL(THIS.this_cExpds) + "," + ;
                " expas    = " + EscaparSQL(THIS.this_cExpas) + "," + ;
                " barcmds  = " + EscaparSQL(THIS.this_cBarcmds) + "," + ;
                " fontes   = " + EscaparSQL(THIS.this_cFontes) + "," + ;
                " fonte2s  = " + EscaparSQL(THIS.this_cFonte2s) + "," + ;
                " fontemp1s = " + EscaparSQL(THIS.this_cFontemp1s) + "," + ;
                " nlivl1s  = " + FormatarNumeroSQL(THIS.this_nNlivl1s,   0) + "," + ;
                " nclvl1s  = " + FormatarNumeroSQL(THIS.this_nNclvl1s,   0) + "," + ;
                " nlivext1s = " + FormatarNumeroSQL(THIS.this_nNlivext1s, 0) + "," + ;
                " nclvext1s = " + FormatarNumeroSQL(THIS.this_nNclvext1s, 0) + "," + ;
                " nlivext2s = " + FormatarNumeroSQL(THIS.this_nNlivext2s, 0) + "," + ;
                " nclvext2s = " + FormatarNumeroSQL(THIS.this_nNclvext2s, 0) + "," + ;
                " nlinom1s = " + FormatarNumeroSQL(THIS.this_nNlinom1s,  0) + "," + ;
                " nclnom1s = " + FormatarNumeroSQL(THIS.this_nNclnom1s,  0) + "," + ;
                " nlicid1s = " + FormatarNumeroSQL(THIS.this_nNlicid1s,  0) + "," + ;
                " nclcid1s = " + FormatarNumeroSQL(THIS.this_nNclcid1s,  0) + "," + ;
                " nlidia1s = " + FormatarNumeroSQL(THIS.this_nNlidia1s,  0) + "," + ;
                " ncldia1s = " + FormatarNumeroSQL(THIS.this_nNcldia1s,  0) + "," + ;
                " nlimes1s = " + FormatarNumeroSQL(THIS.this_nNlimes1s,  0) + "," + ;
                " nclmes1s = " + FormatarNumeroSQL(THIS.this_nNclmes1s,  0) + "," + ;
                " nliano1s = " + FormatarNumeroSQL(THIS.this_nNliano1s,  0) + "," + ;
                " nclano1s = " + FormatarNumeroSQL(THIS.this_nNclano1s,  0) + ;
                " WHERE impres = " + EscaparSQL(THIS.this_cImpres)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ImpBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdmp
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "DELETE FROM SigCdmp WHERE impres = " + EscaparSQL(THIS.this_cImpres)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ImpBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros para o grid da lista
    * Retorna cursor_4c_Dados com impres e maxcols
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (impres C(40), maxcols N(5,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT impres, maxcols FROM SigCdmp"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY impres"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar impressoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar impressoras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ImpBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro completo pela chave primaria
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cImpres)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT impres, cIdChaves, rates, titulos, barras, maxcols," + ;
                " exps, graficos, nchqfs, nTpImpres, ImpEtis, Tipos, cetiquetas," + ;
                " AjVerts, AjHorzs, AjVelos, AjDens," + ;
                " expds, expas, barcmds, fontes, fonte2s, fontemp1s," + ;
                " nlivl1s, nclvl1s, nlivext1s, nclvext1s, nlivext2s, nclvext2s," + ;
                " nlinom1s, nclnom1s, nlicid1s, nclcid1s," + ;
                " nlidia1s, ncldia1s, nlimes1s, nclmes1s, nliano1s, nclano1s" + ;
                " FROM SigCdmp WHERE impres = " + EscaparSQL(par_cImpres)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Impressora n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar impressora:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ImpBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarTiposEtiqueta - Carrega cursor crSigCdTpe (writable) para combo etiqueta
    * Fonte: SigCdTpe WHERE nSituas=1, acrescenta linha em branco no topo
    *====================================================================
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("crSigCdTpe")
                USE IN crSigCdTpe
            ENDIF

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                CREATE CURSOR crSigCdTpe (Cetiquetas C(100), nTipos N(5,0))
                APPEND BLANK
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Cetiquetas, nTipos FROM SigCdTpe WHERE nSituas = 1"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdTpeTmp")

                IF loc_nResultado >= 0
                    CREATE CURSOR crSigCdTpe (Cetiquetas C(100), nTipos N(5,0))
                    IF USED("crSigCdTpeTmp")
                        APPEND FROM DBF("crSigCdTpeTmp")
                        USE IN crSigCdTpeTmp
                    ENDIF
                    APPEND BLANK
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao carregar tipos de etiqueta:" + CHR(13) + CapturarErroSQL(), "ImpBO.CarregarTiposEtiqueta")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar tipos de etiqueta:" + CHR(13) + loException.Message, "ImpBO.CarregarTiposEtiqueta")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
