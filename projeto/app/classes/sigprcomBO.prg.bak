*====================================================================
* sigprcomBO.prg
*
* Business Object para Estoque Maximo por Produto/Empresa/Tamanho/Cor
* Tabela: SigCdMax
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigprcomBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdMax)
    this_cCidChaves = ""    && cidchaves char(20) - PK
    this_cCPros     = ""    && cpros char(14)
    this_cEmps      = ""    && emps char(3)
    this_cCodTams   = ""    && codtams char(4)
    this_cCodCores  = ""    && codcores char(4)
    this_cDeptos    = ""    && deptos char(10)
    this_cOrdems    = ""    && ordems char(1)
    this_nQMaxs     = 0     && qmaxs numeric(7,2)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdMax"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprcomBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *====================================================================
    * LimparDados - Reseta as propriedades da entidade
    * CRITICO: sem este override, this_cCidChaves sobrevive entre chamadas
    * de NovoRegistro() e o Inserir() reaproveita a MESMA chave gerada na
    * linha anterior (EMPTY() so gera nova se estiver vazia) - a 2a linha
    * de uma grade com N linhas estoura violacao de PK unica em silencio
    * (o loop do form para no primeiro Salvar() que falhar).
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves = ""
        THIS.this_cCPros     = ""
        THIS.this_cEmps      = ""
        THIS.this_cCodTams   = ""
        THIS.this_cCodCores  = ""
        THIS.this_cDeptos    = ""
        THIS.this_cOrdems    = ""
        THIS.this_nQMaxs     = 0
    ENDPROC

    *====================================================================
    * Buscar - Lista, na Pagina Lista, os Produtos com registro em SigCdMax
    * Legado: lcQProds (Init) -> AddCursor('SigCdMax','cpros','CrProdutos',...)
    * Cursor de saida: cursor_4c_Lista (cpros/dpros/ifors/reffs/sgrus)
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Lista")
                USE IN cursor_4c_Lista
            ENDIF

            loc_cSQL = "SELECT a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " FROM SigCdMax a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " GROUP BY a.cpros, b.dpros, b.ifors, b.reffs, b.sgrus" + ;
                " ORDER BY a.cpros"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")

            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Estoque M" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "sigprcomBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            *-- TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR de retorno
            *-- quando a coluna vem NULL - NAO um codigo de tipo. Passar "C"/"N"
            *-- gravaria a letra na property (e a STRING "N" em this_nQMaxs, que
            *-- depois estoura no FormatarNumeroSQL do Inserir/Atualizar).
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cCPros     = TratarNulo(cpros, "")
            THIS.this_cEmps      = TratarNulo(emps, "")
            THIS.this_cCodTams   = TratarNulo(codtams, "")
            THIS.this_cCodCores  = TratarNulo(codcores, "")
            THIS.this_cDeptos    = TratarNulo(deptos, "")
            THIS.this_cOrdems    = TratarNulo(ordems, "")
            THIS.this_nQMaxs     = TratarNulo(qmaxs, 0)
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdMax
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                       " (cidchaves, cpros, emps, codtams, codcores, deptos, ordems, qmaxs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + "," + ;
                       EscaparSQL(THIS.this_cCPros) + "," + ;
                       EscaparSQL(THIS.this_cEmps) + "," + ;
                       EscaparSQL(THIS.this_cCodTams) + "," + ;
                       EscaparSQL(THIS.this_cCodCores) + "," + ;
                       EscaparSQL(THIS.this_cDeptos) + "," + ;
                       EscaparSQL(THIS.this_cOrdems) + "," + ;
                       FormatarNumeroSQL(THIS.this_nQMaxs, 2) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdMax
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdMax SET" + ;
                       " cpros = "    + EscaparSQL(THIS.this_cCPros) + "," + ;
                       " emps = "     + EscaparSQL(THIS.this_cEmps) + "," + ;
                       " codtams = "  + EscaparSQL(THIS.this_cCodTams) + "," + ;
                       " codcores = " + EscaparSQL(THIS.this_cCodCores) + "," + ;
                       " deptos = "   + EscaparSQL(THIS.this_cDeptos) + "," + ;
                       " ordems = "   + EscaparSQL(THIS.this_cOrdems) + "," + ;
                       " qmaxs = "    + FormatarNumeroSQL(THIS.this_nQMaxs, 2) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExistemItensParaProduto - Verifica se o Produto ja possui registros
    * gravados em SigCdMax (legado: ThisForm.AcertaGrade requery + !Eof())
    *====================================================================
    FUNCTION ExistemItensParaProduto(par_cCodigo)
        LOCAL loc_lExiste, loc_nResultado
        loc_lExiste = .F.

        TRY
            loc_nResultado = SQLEXEC(gnConnHandle, ;
                "SELECT cidchaves FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCodigo), ;
                "cursor_4c_VerificaMax")
            IF loc_nResultado > 0
                loc_lExiste = (RECCOUNT("cursor_4c_VerificaMax") > 0)
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "sigprcomBO.ExistemItensParaProduto")
        ENDTRY

        IF USED("cursor_4c_VerificaMax")
            USE IN cursor_4c_VerificaMax
        ENDIF

        RETURN loc_lExiste
    ENDFUNC

    *====================================================================
    * ExcluirItensRemovidos - Apaga de SigCdMax as linhas do Produto que
    * NAO estao mais na grade (o usuario removeu com btnExcluir no modo
    * ALTERAR). No legado o cursor CrSigCdMax eh uma view atualizavel e o
    * Delete local + Update/Commit levava a remocao ao banco; aqui a grade
    * eh um cursor local, entao a remocao tem de ser dita ao SQL Server.
    *
    * par_cProduto        - cpros do Produto em edicao
    * par_cChavesMantidas - cidchaves que PERMANECEM, separadas por virgula
    *                       (vazio = nenhuma linha gravada permaneceu)
    *====================================================================
    FUNCTION ExcluirItensRemovidos(par_cProduto, par_cChavesMantidas)
        LOCAL loc_cSQL, loc_cLista, loc_nResultado, loc_lSucesso, loc_nI, loc_nQtde
        LOCAL ARRAY loc_aChaves[1]
        loc_lSucesso = .F.
        loc_cLista   = ""

        TRY
            IF VARTYPE(par_cChavesMantidas) = "C" AND !EMPTY(par_cChavesMantidas)
                loc_nQtde = ALINES(loc_aChaves, par_cChavesMantidas, 1, ",")
                FOR loc_nI = 1 TO loc_nQtde
                    IF !EMPTY(loc_aChaves[loc_nI])
                        loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ;
                            EscaparSQL(ALLTRIM(loc_aChaves[loc_nI]))
                    ENDIF
                ENDFOR
            ENDIF

            loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cProduto)
            IF !EMPTY(loc_cLista)
                loc_cSQL = loc_cSQL + " AND cidchaves NOT IN (" + loc_cLista + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao remover itens do estoque m" + CHR(225) + "ximo:" + CHR(13) + ;
                    CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "sigprcomBO.ExcluirItensRemovidos")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
