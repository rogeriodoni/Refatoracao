*==============================================================================
* SIGREAPRBO.PRG
* Business Object para Relatorio de Alteracoes de Produtos
*
* Herda de RelatorioBase
* Formulario original: SIGREAPR.SCX (frmrelatorio)
*==============================================================================

DEFINE CLASS SIGREAPRBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDtInicial     = {}    && Data Inicial (obrigatorio)
    this_cGrupo         = ""    && Codigo do Grupo (SigCdGrp.CGrus, max 3)
    this_cDGrupo        = ""    && Descricao do Grupo (SigCdGrp.DGrus, max 20)
    this_cCPros         = ""    && Codigo do Produto (SigCdPro.CPros, max 14)
    this_cDPros         = ""    && Descricao do Produto (SigCdPro.DPros, max 40)
    this_cLin           = ""    && Codigo da Linha (SigCdLin.Linhas, max 10)
    this_cDLin          = ""    && Descricao da Linha (SigCdLin.Descs, max 40)
    this_cFornecedor    = ""    && Codigo do Fornecedor (max 10)
    this_cDFornecedor   = ""    && Descricao do Fornecedor (max 40)
    this_nMinVendas     = 0     && Diferenca minima vendas em %
    this_nMinCustos     = 0     && Diferenca minima custos em %

    *-- Controle interno do relatorio
    this_cArquivoFRX    = ""    && Caminho completo do FRX
    this_cTitulo        = ""    && Titulo exibido no relatorio
    this_cCursorDados   = "cursor_4c_SIGREAPRDados"  && Cursor resultado do SQLEXEC

    *--------------------------------------------------------------------------
    * Init - Configura caminhos e valores iniciais dos filtros
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cArquivoFRX = gc_4c_CaminhoReports + "RelSIGREAPR.frx"
            THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Altera" + CHR(231) + CHR(245) + "es de Produtos"
            THIS.this_dDtInicial  = DATE()
            THIS.this_nMinVendas  = 0
            THIS.this_nMinCustos  = 0
            loc_lSucesso = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Compara SigCdPro (atual) vs bkp_sigcdpro (historico)
    * Retorna produtos com variacao de preco acima dos minimos informados
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_cSub, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial " + CHR(233) + " obrigat" + CHR(243) + "ria"
            ELSE
                loc_cWhere = "p.datas >= " + FormatarDataSQL(THIS.this_dDtInicial)

                IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.cgrus = " + EscaparSQL(ALLTRIM(THIS.this_cGrupo))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cCPros))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCPros))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cLin))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.linhas = " + EscaparSQL(ALLTRIM(THIS.this_cLin))
                ENDIF

                IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
                    loc_cWhere = loc_cWhere + ;
                                 " AND p.ifors = " + EscaparSQL(ALLTRIM(THIS.this_cFornecedor))
                ENDIF

                loc_cSub = "SELECT p.cpros, p.dpros, p.cgrus, p.linhas, p.ifors," + ;
                           " p.datas AS dtAlteracao," + ;
                           " b.pvens AS pvAnt, p.pvens AS pvAtual," + ;
                           " b.pcuss AS pcAnt, p.pcuss AS pcAtual," + ;
                           " CASE WHEN b.pvens <> 0 THEN ABS((p.pvens - b.pvens) / b.pvens)" + ;
                           " * 100 ELSE 0 END AS varVendas," + ;
                           " CASE WHEN b.pcuss <> 0 THEN ABS((p.pcuss - b.pcuss) / b.pcuss)" + ;
                           " * 100 ELSE 0 END AS varCustos" + ;
                           " FROM SigCdPro p" + ;
                           " INNER JOIN bkp_sigcdpro b ON p.cpros = b.cpros" + ;
                           " WHERE " + loc_cWhere

                loc_cSQL = "SELECT sub.cpros, sub.dpros, sub.cgrus, sub.linhas, sub.ifors," + ;
                           " sub.dtAlteracao, sub.pvAnt, sub.pvAtual," + ;
                           " sub.pcAnt, sub.pcAtual, sub.varVendas, sub.varCustos" + ;
                           " FROM (" + loc_cSub + ") sub" + ;
                           " WHERE (sub.varVendas >= " + ALLTRIM(TRANSFORM(THIS.this_nMinVendas)) + ;
                           " OR sub.varCustos >= " + ALLTRIM(TRANSFORM(THIS.this_nMinCustos)) + ")" + ;
                           " ORDER BY sub.dpros"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                IF loc_nResult >= 0
                    SELECT (THIS.this_cCursorDados)
                    IF EOF()
                        THIS.this_cMensagemErro = "Nenhum dado encontrado para os filtros informados"
                    ELSE
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao buscar dados do relat" + CHR(243) + "rio"
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) TO PRINT NOCONSOLE
                THIS.RegistrarAuditoria("IMPRIMIR")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao imprimir: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                REPORT FORM (THIS.this_cArquivoFRX) PREVIEW NOCONSOLE
                THIS.RegistrarAuditoria("VISUALIZAR")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao visualizar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de auditoria da execucao do relatorio
    * Compoe identificador unico com empresa + filtros + data inicial + minimos
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave, loc_cEmpresa

        loc_cEmpresa = IIF(TYPE("go_4c_Sistema.cCodEmpresa") = "C", ;
                           ALLTRIM(go_4c_Sistema.cCodEmpresa), "TODAS")

        loc_cChave = loc_cEmpresa + "/SIGREAPR/" + DTOC(THIS.this_dDtInicial)

        IF !EMPTY(ALLTRIM(THIS.this_cGrupo))
            loc_cChave = loc_cChave + "/G:" + ALLTRIM(THIS.this_cGrupo)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cCPros))
            loc_cChave = loc_cChave + "/P:" + ALLTRIM(THIS.this_cCPros)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cLin))
            loc_cChave = loc_cChave + "/L:" + ALLTRIM(THIS.this_cLin)
        ENDIF

        IF !EMPTY(ALLTRIM(THIS.this_cFornecedor))
            loc_cChave = loc_cChave + "/F:" + ALLTRIM(THIS.this_cFornecedor)
        ENDIF

        loc_cChave = loc_cChave + ;
                     "/MV:" + ALLTRIM(STR(THIS.this_nMinVendas, 6, 2)) + ;
                     "/MC:" + ALLTRIM(STR(THIS.this_nMinCustos, 6, 2))

        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_cUsuario, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", ;
                               gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SIGREAPR") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(loc_cUsuario) + ", GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Aviso: falha ao registrar auditoria - " + ;
                                       loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / CarregarDoCursor
    *
    * Operacoes nao aplicaveis a BOs de relatorio. Sao implementadas aqui
    * apenas para manter o contrato uniforme com BusinessBase (auditoria,
    * dispatchers genericos, validadores automatizados) e para sinalizar
    * explicitamente a restricao via this_cMensagemErro.
    *
    * Para relatorios o fluxo correto eh:
    *   - PrepararDados() monta o cursor de saida via SQLEXEC comparando
    *     SigCdPro (atual) vs bkp_sigcdpro (historico) no periodo filtrado
    *   - Imprimir() / Visualizar() consomem esse cursor atraves do RelSIGREAPR.frx
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o insere registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio n" + CHR(227) + ;
            "o atualiza registros. Use PrepararDados()/Imprimir()/Visualizar()."
        RETURN .F.
    ENDPROC

    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
            "o suportada: BO de relat" + CHR(243) + "rio processa o per" + ;
            CHR(237) + "odo inteiro em PrepararDados(), n" + CHR(227) + ;
            "o registro a registro."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro da ultima operacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ExportarExcel - Prepara dados e exporta para planilha Excel (XL5)
    *   Usa PUTFILE para escolha interativa do arquivo destino
    *--------------------------------------------------------------------------
    PROCEDURE ExportarExcel()
        LOCAL loc_lResultado, loc_cArquivo, loc_lSafetyEra
        loc_lResultado = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cArquivo = PUTFILE("Exportar para Excel", ;
                               "RelAlteracoesProdutos.xls", "xls")
                IF !EMPTY(loc_cArquivo)
                    IF LOWER(RIGHT(loc_cArquivo, 4)) != ".xls"
                        loc_cArquivo = loc_cArquivo + ".xls"
                    ENDIF
                    SELECT (THIS.this_cCursorDados)
                    loc_lSafetyEra = (SET("SAFETY") = "ON")
                    SET SAFETY OFF
                    COPY TO (loc_cArquivo) TYPE XL5
                    IF loc_lSafetyEra
                        SET SAFETY ON
                    ENDIF
                    THIS.RegistrarAuditoria("EXCEL")
                    MsgInfo("Arquivo exportado com sucesso!", ;
                            "Informa" + CHR(231) + CHR(227) + "o")
                    loc_lResultado = .T.
                ENDIF
            ELSE
                IF !EMPTY(THIS.this_cMensagemErro)
			*-- REMOVIDO (self-assignment causa erro VFP9): THIS.this_cMensagemErro = THIS.this_cMensagemErro
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao exportar: " + loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursor de dados ao destruir objeto
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
