*==============================================================================
* SigPrDscBO.prg - Business Object para Montagem de Descricao de Produtos
* Herda de BusinessBase
* Tabela principal: SigCdPro (atualiza DscCompras/ObsCompras/DPros)
* Tabelas auxiliares: SigCdDic (dicionario), SigCdGrp, SigCdCor, SigPrPrt
*==============================================================================

DEFINE CLASS SigPrDscBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Configuracao da entidade
    *--------------------------------------------------------------------------
    this_cTabela     = "SigCdPro"
    this_cCampoChave = "CPros"

    *--------------------------------------------------------------------------
    * Filtros de selecao de produtos
    *--------------------------------------------------------------------------
    this_cCProsI = ""  && produto inicial do intervalo C(14)
    this_cCProsF = ""  && produto final do intervalo   C(14)
    this_cCGrus  = ""  && grupo de produto (filtro alternativo) C(3)

    *--------------------------------------------------------------------------
    * Controle de processamento e gravacao
    *--------------------------------------------------------------------------
    this_nTotalProcessados = 0
    this_nTotalGravados    = 0
    this_lGravadoOk        = .F.

    *--------------------------------------------------------------------------
    * Init
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "CPros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCProsI + "-" + THIS.this_cCProsF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - mapeia campos do cursor para propriedades do BO
    * Cursor esperado: alias de SigCdPro com ao menos CPros/CGrus
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCProsI = TratarNulo(CPros, "C")
                THIS.this_cCProsF = TratarNulo(CPros, "C")
                THIS.this_cCGrus  = TratarNulo(CGrus, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDicionario - carrega dicionario de traducoes de SigCdDic
    * Popula cursor_4c_Dicionario (Expressao/Traducao, ordenado por tamanho desc)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarDicionario()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dicionario")
                USE IN cursor_4c_Dicionario
            ENDIF
            loc_cSQL = "SELECT Expressao, Traducao " + ;
                       "FROM SigCdDic " + ;
                       "WHERE Idioma = 'INGLES    ' " + ;
                       "ORDER BY LEN(Expressao) DESC, Expressao"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dicionario") < 1
                MsgErro("Falha ao carregar dicion" + CHR(225) + "rio de tradu" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProdutos - SELECT de produtos baseado nos filtros do BO
    * Popula cursor_4c_ProdTemp (CPros apenas - lista de codigos)
    * Pre-requisito: this_cCProsI/F e this_cCGrus ja setados pelo form
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProdutos()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPrI, loc_cPrF, loc_cGru, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cPrI = PADR(THIS.this_cCProsI, 14)
            loc_cPrF = PADR(THIS.this_cCProsF, 14)
            loc_cGru = PADR(THIS.this_cCGrus, 3)

            IF !EMPTY(ALLTRIM(loc_cGru))
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CGrus = " + EscaparSQL(ALLTRIM(loc_cGru)) + " " + ;
                           "ORDER BY CPros"
            ELSE
                loc_cSQL = "SELECT CPros FROM SigCdPro " + ;
                           "WHERE CPros BETWEEN " + EscaparSQL(loc_cPrI) + " AND " + EscaparSQL(loc_cPrF) + " " + ;
                           "ORDER BY CPros"
            ENDIF

            IF USED("cursor_4c_ProdTemp")
                USE IN cursor_4c_ProdTemp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdTemp") < 1
                MsgErro("Falha ao buscar produtos.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarTraducoes - processa produtos e preenche cursor_4c_Produtos
    * Equivalente ao PROCEDURE processamento do legado (SIGPRDSC.processamento)
    * Pre-requisito: cursor_4c_Dicionario carregado via BuscarDicionario()
    * Pre-requisito: cursor_4c_Produtos criado pelo form (CREATE CURSOR)
    * Pos-execucao: cursor_4c_Produtos contem (CPros/Portugues/Traduzido/DscCompras/ObsCompras)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarTraducoes()
        LOCAL loc_lSucesso, loc_cSQL, loc_cPro, loc_cDes, loc_cIni
        LOCAL loc_cIng, loc_nGrD, loc_oProg, loc_oErro
        loc_lSucesso = .F.
        TRY
            *-- Busca lista de produtos no SQL Server
            IF !THIS.BuscarProdutos()
                loc_lSucesso = .F.
            ENDIF

            IF !USED("cursor_4c_ProdTemp") OR RECCOUNT("cursor_4c_ProdTemp") = 0
                MsgAviso("Nenhum produto encontrado para os filtros informados.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            *-- Zera cursor de resultado do form
            IF USED("cursor_4c_Produtos")
                SELECT cursor_4c_Produtos
                ZAP
            ENDIF

            THIS.this_nTotalProcessados = 0

            loc_oProg = CREATEOBJECT("fwprogressbar", ;
                "Processando Tradu" + CHR(231) + CHR(245) + "es...", ;
                RECCOUNT("cursor_4c_ProdTemp"))
            loc_oProg.Show

            SELECT cursor_4c_ProdTemp
            GO TOP
            SCAN
                loc_cPro = ALLTRIM(cursor_4c_ProdTemp.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                IF !EMPTY(loc_cPro)
                    loc_cDes = ""

                    *-- Busca dados complementares: grupo + cor do produto
                    loc_cSQL = "SELECT a.CPros, a.CGrus, a.CodCors, " + ;
                               "b.DGrus, b.Mercs, b.MontaGrDs, c.Descs " + ;
                               "FROM SigCdPro a " + ;
                               "LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus " + ;
                               "LEFT JOIN SigCdCor c ON c.Cods = a.CodCors " + ;
                               "WHERE a.CPros = " + EscaparSQL(loc_cPro)

                    IF USED("cursor_4c_LocalPro")
                        USE IN cursor_4c_LocalPro
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LocalPro") >= 1
                        SELECT cursor_4c_LocalPro
                        GO TOP
                        loc_nGrD = NVL(cursor_4c_LocalPro.MontaGrDs, 0)
                        IF loc_nGrD = 1
                            *-- MontaGrDs=1: incluir descricao do grupo (DGrus) + cor (Descs)
                            loc_cDes = ALLTRIM(;
                                ALLTRIM(NVL(cursor_4c_LocalPro.DGrus, "")) + " " + ;
                                ALLTRIM(NVL(cursor_4c_LocalPro.Descs, "")))
                        ELSE
                            *-- MontaGrDs=0: apenas descricao de cor (Descs)
                            loc_cDes = ALLTRIM(NVL(cursor_4c_LocalPro.Descs, ""))
                        ENDIF

                        IF !EMPTY(loc_cDes)
                            loc_cIng = loc_cDes

                            *-- Aplica substituicoes do dicionario portugues->ingles
                            IF USED("cursor_4c_Dicionario")
                                SELECT cursor_4c_Dicionario
                                GO TOP
                                SCAN
                                    loc_cIng = STRTRAN(loc_cIng, ;
                                        ALLTRIM(cursor_4c_Dicionario.Expressao), ;
                                        ALLTRIM(cursor_4c_Dicionario.Traducao))
                                ENDSCAN
                            ENDIF

                            *-- Remove aspas simples e duplas (protecao SQL)
                            loc_cDes = STRTRAN(STRTRAN(loc_cDes, "'", " "), '"', " ")
                            loc_cIng = STRTRAN(STRTRAN(loc_cIng, "'", " "), '"', " ")

                            *-- Insere no cursor de produtos (DscCompras=traduzido, ObsCompras=portugues)
                            SELECT cursor_4c_Produtos
                            INSERT INTO cursor_4c_Produtos ;
                                (CPros, Portugues, Traduzido, DscCompras, ObsCompras) ;
                                VALUES (loc_cPro, loc_cDes, loc_cIng, loc_cIng, loc_cDes)

                            THIS.this_nTotalProcessados = THIS.this_nTotalProcessados + 1
                        ENDIF

                        IF USED("cursor_4c_LocalPro")
                            USE IN cursor_4c_LocalPro
                        ENDIF
                    ENDIF
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            SELECT cursor_4c_Produtos
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GravarDescricoes - grava descricoes nos produtos (UPDATE SigCdPro)
    * Equivalente ao PROCEDURE gravacao do legado (SIGPRDSC.gravacao)
    * Pre-requisito: cursor_4c_Produtos populado por ProcessarTraducoes()
    * Cada produto: UPDATE SigCdPro + DELETE SigPrPrt com commit individual
    *--------------------------------------------------------------------------
    PROCEDURE GravarDescricoes()
        LOCAL loc_lSucesso, loc_lOks, loc_cSQL, loc_cPro
        LOCAL loc_oProg, loc_nTotal, loc_oErro
        loc_lSucesso = .F.
        loc_lOks     = .T.
        TRY
            IF !USED("cursor_4c_Produtos")
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_nTotal = RECCOUNT("cursor_4c_Produtos")
            IF loc_nTotal = 0
                MsgAviso("Nenhum produto para gravar.", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            THIS.this_nTotalGravados = 0
            THIS.this_lGravadoOk     = .F.

            loc_oProg = CREATEOBJECT("fwprogressbar", "Gravando Produtos...", loc_nTotal)
            loc_oProg.Show

            SELECT cursor_4c_Produtos
            GO TOP
            SCAN WHILE loc_lOks
                loc_cPro = ALLTRIM(cursor_4c_Produtos.CPros)

                loc_oProg.SubTitulo.Caption = "Produto : " + loc_cPro
                loc_oProg.Update(.T.)

                *-- UPDATE SigCdPro: DscCompras, ObsCompras, DPros
                loc_cSQL = "UPDATE SigCdPro " + ;
                           "SET DscCompras = " + EscaparSQL(cursor_4c_Produtos.DscCompras) + ", " + ;
                               "ObsCompras = " + EscaparSQL(cursor_4c_Produtos.ObsCompras) + ", " + ;
                               "DPros = " + EscaparSQL(PADR(ALLTRIM(cursor_4c_Produtos.Portugues), 40)) + " " + ;
                           "WHERE CPros = " + EscaparSQL(loc_cPro)

                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Falha ao atualizar produto " + loc_cPro + " em SigCdPro.", "Erro")
                    loc_lOks = .F.
                ENDIF

                IF loc_lOks
                    *-- DELETE FROM SigPrPrt: remove produto enviado
                    loc_cSQL = "DELETE FROM SigPrPrt WHERE CPros = " + EscaparSQL(loc_cPro)
                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        MsgErro("Falha ao excluir produto " + loc_cPro + " de SigPrPrt.", "Erro")
                        loc_lOks = .F.
                    ENDIF
                ENDIF

                IF loc_lOks
                    SQLCOMMIT(gnConnHandle)
                    THIS.this_nTotalGravados = THIS.this_nTotalGravados + 1
                ELSE
                    SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDSCAN

            loc_oProg.Complete

            IF loc_lOks
                THIS.this_lGravadoOk = .T.
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - grava as descricoes traduzidas (equivalente a UPDATE em lote)
    * Form OPERACIONAL: unico caminho de persistencia disponivel.
    * Espelha o botao btnAtualizar do legado -> chama gravacao/GravarDescricoes.
    * RegistrarAuditoria eh disparada dentro de GravarDescricoes ao final do lote.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.GravarDescricoes()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - nao aplicavel a este form OPERACIONAL (nao cria produtos novos)
    * O form atualiza descricoes de produtos ja existentes em SigCdPro.
    * Delegamos a Atualizar para manter contrato de BusinessBase e evitar
    * insercao acidental de registros pelo fluxo padrao Salvar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.Atualizar()
    ENDPROC

ENDDEFINE
