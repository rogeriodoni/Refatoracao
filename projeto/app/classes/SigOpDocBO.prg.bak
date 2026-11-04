*==============================================================================
* SigOpDocBO.prg - Business Object para Relacao de Arquivos e Documentos
* Form OPERACIONAL - dialogo filho instanciado com DO FORM SigOpDoc WITH
* par_cChave, par_cEscolha (legado: Lparameters pKey, pEsc)
* Legado: SIGOPDOC.SCX
* Tabela principal: SigOpArq | PK: pkChaves (gerada por fUniqueIds())
* Chave de amarracao (fkChaves): recebida do form pai - EmpDopNums, CPros,
* IClis, etc., conforme a tela que abriu este dialogo
*==============================================================================

DEFINE CLASS SigOpDocBO AS BusinessBase

    *-- Propriedades de SigOpArq (registro corrente da grade de arquivos)
    this_cPkChaves = ""    && pkChaves  CHAR(20) NOT NULL - chave primaria (fUniqueIds)
    this_cFkChaves = ""    && fkChaves  CHAR(30)          - chave de amarracao ao registro pai
    this_cArquivos = ""    && Arquivos  CHAR(250) NOT NULL - caminho/nome do arquivo vinculado
    this_cObsArqs  = ""    && ObsArqs   TEXT             - observacao sobre o arquivo
    this_cUsuars   = ""    && Usuars    CHAR(10) NOT NULL - usuario que incluiu o vinculo
    this_dDatas    = {}    && Datas     DATETIME          - data/hora de inclusao do vinculo

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela     = "SigOpArq"
        THIS.this_cCampoChave = "pkChaves"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria (pkChaves) para uso em
    * RegistrarAuditoria(). PROTECTED (regra #51 - nunca chamado de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cPkChaves, ""))
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia todas as colunas de SigOpArq (vindas do
    * cursor crSigOpArq/cursor_4c_Dados, uma linha = um arquivo vinculado)
    * para as propriedades do BO. SEMPRE SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #9 do CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cPkChaves = TratarNulo(pkChaves, "")
                THIS.this_cFkChaves = TratarNulo(fkChaves, "")
                THIS.this_cArquivos = TratarNulo(Arquivos, "")
                THIS.this_cObsArqs  = TratarNulo(ObsArqs, "")
                THIS.this_cUsuars   = TratarNulo(Usuars, "")
                THIS.this_dDatas    = TratarNulo(Datas, {})

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista os arquivos vinculados a chave de amarracao recebida do
    * form pai (fkChaves). Retorna cursor_4c_Dados com pkChaves/fkChaves/
    * Arquivos/ObsArqs/Usuars/Datas (regra #42 - chave char(30), PADR ao
    * montar o WHERE, nunca ALLTRIM nas partes). Equivalente a
    * "Select * From SigOpArq Where fkChaves = Padr(pKey, 30)" do Init legado.
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), fkChaves C(30), ;
                        Arquivos C(250), ObsArqs M, Usuars C(10), Datas T)
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
                loc_cSQL = loc_cSQL + " FROM SigOpArq"
                loc_cSQL = loc_cSQL + " WHERE fkchaves = " + ;
                    EscaparSQL(PADR(ALLTRIM(NVL(par_cChave, "")), 30))

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

                IF loc_nResultado >= 0
                    *-- Cursor de SQL pass-through nasce SOMENTE-LEITURA. O
                    *-- EditBox da observacao (getObsArqs) esta ligado a este
                    *-- cursor por ControlSource: sem READWRITE ele nao aceita
                    *-- uma tecla sequer e SalvarDados nunca teria o que gravar
                    *-- - e nao ha erro nenhum na tela, so o campo inerte.
                    *-- O legado liga crSigOpArq por .AddCursor (cursor COM
                    *-- buffering, gravavel - a prova esta no proprio Init,
                    *-- que faz "Update crSigOpArq Set ObsArqs = ..."), entao
                    *-- converter para READWRITE eh o que REPRODUZ o legado.
                    *-- SQLEXEC vai para alias TEMPORARIO porque derrubar o
                    *-- alias ligado ao Grid zera o ColumnCount.
                    IF USED("cursor_4c_Dados")
                        USE IN cursor_4c_Dados
                    ENDIF

                    SELECT * FROM cursor_4c_DadosTmp INTO CURSOR cursor_4c_Dados READWRITE

                    IF USED("cursor_4c_DadosTmp")
                        USE IN cursor_4c_DadosTmp
                    ENDIF

                    *-- Legado, logo depois do Requery: "Update crSigOpArq Set
                    *-- ObsArqs = Nvl(ObsArqs, [])". Sem isto a coluna TEXT
                    *-- nula chega ao EditBox como .NULL. e eh isso que o
                    *-- usuario le na tela.
                    SELECT cursor_4c_Dados
                    SCAN FOR ISNULL(cursor_4c_Dados.ObsArqs)
                        REPLACE cursor_4c_Dados.ObsArqs WITH ""
                    ENDSCAN

                    *-- Legado: "Go Top In crSigOpArq"
                    SELECT cursor_4c_Dados
                    GO TOP

                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar os arquivos vinculados:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo vinculo de arquivo em SigOpArq.
    * PK (pkChaves) gerada via fUniqueIds() se ainda nao preenchida -
    * equivalente a "fUniqueIds()" do btnInsArqs.Click legado.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cPkChaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Usuars/Datas = usuario e data/hora da inclusao do vinculo
            *-- (equivalente a "Usuar, Datetime()" do legado)
            IF EMPTY(ALLTRIM(NVL(THIS.this_cUsuars, "")))
                THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF
            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpArq ("
            loc_cSQL = loc_cSQL + "pkchaves, fkchaves, arquivos, obsarqs, usuars, datas"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPkChaves, 20)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cFkChaves, 30)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza vinculo de arquivo existente em SigOpArq
    * (por pkChaves). fkChaves nao muda depois de gravado - o UPDATE cobre
    * apenas os campos que a tela permite editar (Arquivos, ObsArqs).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigOpArq SET"
            loc_cSQL = loc_cSQL + " arquivos = " + EscaparSQL(LEFT(THIS.this_cArquivos, 250)) + ","
            loc_cSQL = loc_cSQL + " obsarqs = " + EscaparSQL(THIS.this_cObsArqs) + ","
            loc_cSQL = loc_cSQL + " usuars = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas)
            loc_cSQL = loc_cSQL + " WHERE pkchaves = " + EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar o v" + CHR(237) + "nculo do arquivo:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Remove o vinculo de arquivo corrente de SigOpArq
    * (por pkChaves). PROTECTED (regra #51 - de fora sempre Excluir()).
    * Equivalente a "Delete In crSigOpArq" do btnExcArqs.Click legado, mas
    * gravando a exclusao direto no SQL Server (nao ha mais commit em lote).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cPkChaves, "")))
                THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + ;
                    " v" + CHR(237) + "nculo de arquivo selecionado para excluir."
            ELSE
                loc_cSQL = "DELETE FROM SigOpArq WHERE pkchaves = " + ;
                    EscaparSQL(LEFT(THIS.this_cPkChaves, 20))

                IF USED("cursor_4c_Delete")
                    USE IN cursor_4c_Delete
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir o v" + CHR(237) + "nculo do arquivo:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em SigOpDocBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
