*==============================================================================
* SIGREAAIVBO.PRG
* Business Object para Relatorio de Analise Entre Inventarios
*
* Herda de RelatorioBase
* Formulario original: SIGREAIV.SCX (frmrelatorio)
* Tabelas: SigIvTrh (movimentacao inventario), SigCdBal (cadastro balanco),
*          SigCdPro (descricao do produto)
* Filtros: Empresa, 1o Inventario, 2o Inventario, Tipo (Analitico/Sintetico)
*==============================================================================

DEFINE CLASS SigReAivBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa           = ""   && Codigo da empresa (Get_Empresa)
    this_cDempresa          = ""   && Descricao da empresa (Get_Dempresa)
    this_nInv1              = 0    && Codigo do 1o inventario (Get_Inv1)
    this_nInv2              = 0    && Codigo do 2o inventario (Get_Inv2)
    this_nTipo              = 1    && Tipo: 1=Analitico, 2=Sintetico (OptTipo)

    *-- Descricoes dos inventarios exibidas apos selecao (Say2/Say5)
    this_cDescInv1          = ""   && "Grupo - Conta" do 1o inventario
    this_cDescInv2          = ""   && "Grupo - Conta" do 2o inventario

    *-- Cursores utilizados
    this_cCursorDados       = "cursor_4c_DbImp"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"

    *-- Configuracao do relatorio
    this_cFRXPath           = ""
    this_cTituloRel         = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do FRX e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF DODEFAULT()
                IF TYPE("gc_4c_CaminhoReports") = "U"
                    gc_4c_CaminhoReports = ""
                ENDIF
                THIS.this_cFRXPath   = gc_4c_CaminhoReports + "SigReAiv.frx"
                THIS.this_cTituloRel = "An" + CHR(225) + "lise Entre Invent" + CHR(225) + "rios"
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem do ultimo erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida campos obrigatorios antes de gerar relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
            THIS.this_cMensagemErro = "Informe a empresa"
            RETURN .F.
        ENDIF
        IF THIS.this_nInv1 = 0
            THIS.this_cMensagemErro = "Informe o 1" + CHR(186) + ;
                                      " Invent" + CHR(225) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nInv2 = 0
            THIS.this_cMensagemErro = "Informe o 2" + CHR(186) + ;
                                      " Invent" + CHR(225) + "rio"
            RETURN .F.
        ENDIF
        IF THIS.this_nInv1 = THIS.this_nInv2
            THIS.this_cMensagemErro = "Invent" + CHR(225) + "rio 2 deve ser diferente do 1" + CHR(186)
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Executa SQL e monta cursor de dados do relatorio
    * Logica: busca movimentacoes dos 2 inventarios, agrupa por produto/local,
    * calcula sobras (cnInvs1 > cnInvs2) e faltas (cnInvs2 > cnInvs1),
    * remove registros sem diferenca.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL lacPros, laLocal, loc_nInv1, loc_nInv2

        loc_lSucesso = .F.

        TRY
            loc_nInv1 = THIS.this_nInv1
            loc_nInv2 = THIS.this_nInv2

            loc_cSQL = "SELECT a.*, b.dPros " + ;
                       "FROM SigIvTrh a " + ;
                       "LEFT JOIN SigCdPro b ON a.cPros = b.cPros " + ;
                       "WHERE Emps = " + EscaparSQL(THIS.this_cEmpresa) + ;
                       " AND NOT a.cPros = Space(14)" + ;
                       " AND (codigos = " + ALLTRIM(STR(loc_nInv1)) + ;
                       " OR codigos = " + ALLTRIM(STR(loc_nInv2)) + ;
                       ") ORDER BY a.cPros, a.localis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigIvTr")

            IF loc_nResult >= 0
                *-- Limpa cursores de execucao anterior
                IF USED(THIS.this_cCursorCabecalho)
                    USE IN (THIS.this_cCursorCabecalho)
                ENDIF
                IF USED(THIS.this_cCursorDados)
                    USE IN (THIS.this_cCursorDados)
                ENDIF

                *-- Cursor cabecalho: guarda codigos dos dois inventarios (usado pelo FRX)
                SET NULL ON
                CREATE CURSOR cursor_4c_Cabecalho (cnInvs1 N(10), cnInvs2 N(10))
                SET NULL OFF
                INSERT INTO cursor_4c_Cabecalho VALUES (loc_nInv1, loc_nInv2)

                *-- Cursor resultado: uma linha por produto/localizacao com qtds de cada inventario
                SET NULL ON
                CREATE CURSOR cursor_4c_DbImp ;
                    (cPros C(14), dPros C(40), cLocals C(10), ;
                     cnInvs1 N(6), cnInvs2 N(6), Sobras N(6), Faltas N(6), Tipos N(1))
                SET NULL OFF

                *-- Processa registros agrupando por produto (e localizacao no modo analitico)
                SELECT cursor_4c_SigIvTr
                lacPros = ''
                laLocal = ''

                SCAN
                    SCATTER MEMVAR
                    SELECT cursor_4c_DbImp
                    IF cursor_4c_SigIvTr.codigos = loc_nInv1
                        m.cnInvs1 = cursor_4c_SigIvTr.Qtds
                        m.cnInvs2 = 0
                    ELSE
                        m.cnInvs1 = 0
                        m.cnInvs2 = cursor_4c_SigIvTr.Qtds
                    ENDIF
                    IF lacPros <> cursor_4c_SigIvTr.cPros OR ;
                       IIF(THIS.this_nTipo = 1, laLocal <> cursor_4c_SigIvTr.localis, .F.)
                        IF ISNULL(m.dPros)
                            m.dPros = ''
                        ENDIF
                        APPEND BLANK
                        GATHER MEMVAR
                        REPLACE cLocals WITH cursor_4c_SigIvTr.localis
                        REPLACE Tipos WITH THIS.this_nTipo
                        lacPros = cursor_4c_SigIvTr.cPros
                        laLocal = cursor_4c_SigIvTr.localis
                    ELSE
                        IF cursor_4c_SigIvTr.codigos = loc_nInv1
                            REPLACE cnInvs1 WITH cnInvs1 + m.cnInvs1
                        ELSE
                            REPLACE cnInvs2 WITH cnInvs2 + m.cnInvs2
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigIvTr
                ENDSCAN

                *-- Calcula sobras/faltas e elimina registros sem diferenca
                SELECT cursor_4c_DbImp
                REPLACE ALL Sobras WITH cnInvs1 - cnInvs2 FOR cnInvs1 - cnInvs2 > 0
                REPLACE ALL Faltas WITH cnInvs2 - cnInvs1 FOR cnInvs2 - cnInvs1 > 0
                DELETE ALL FOR Sobras = 0 AND Faltas = 0
                GO TOP

                IF USED("cursor_4c_SigIvTr")
                    USE IN cursor_4c_SigIvTr
                ENDIF

                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar dados do invent" + CHR(225) + "rio"
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                IF THIS.PrepararDados()
                    IF FILE(THIS.this_cFRXPath)
                        REPORT FORM (THIS.this_cFRXPath) PREVIEW NOCONSOLE
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                                  CHR(227) + "o encontrado"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF THIS.ValidarFiltros()
                IF THIS.PrepararDados()
                    IF FILE(THIS.this_cFRXPath)
                        REPORT FORM (THIS.this_cFRXPath) TO PRINTER NOCONSOLE
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Arquivo de relat" + CHR(243) + "rio n" + ;
                                                  CHR(227) + "o encontrado"
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Identifica a execucao do relatorio para auditoria
    * Retorna string com filtros aplicados (empresa + invs)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpresa) + "|" + ;
               ALLTRIM(STR(THIS.this_nInv1)) + "|" + ;
               ALLTRIM(STR(THIS.this_nInv2))
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra emissao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cChave   = THIS.ObterChavePrimaria()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            loc_cSQL = "INSERT INTO LogAuditoria (Usuario, Operacao, Tabela, ChaveRegistro, DataHora) " + ;
                       "VALUES (" + EscaparSQL(loc_cUsuario) + ", " + ;
                                    EscaparSQL(par_cOperacao) + ", " + ;
                                    EscaparSQL("SigReAiv") + ", " + ;
                                    EscaparSQL(loc_cChave) + ", GETDATE())"
            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                IF SQLEXEC(gnConnHandle, loc_cSQL) >= 0
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao persiste)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * Em relatorios, a carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel a relatorios (frmrelatorio nao persiste dados)
    * Mantido para compatibilidade com padrao de validacao do pipeline.
    * A acao equivalente em relatorios eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                  "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_DbImp")
            USE IN cursor_4c_DbImp
        ENDIF
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_SigIvTr")
            USE IN cursor_4c_SigIvTr
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE
