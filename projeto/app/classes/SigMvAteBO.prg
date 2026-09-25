*====================================================================
* SigMvAteBO.prg
*
* Business Object para Atendimentos de Vendedores por Documento
* Tabela: SigMvAte
* Herda de: BusinessBase
*
* Form OPERACIONAL chamado a partir de um documento de movimento
* (SigMvCab): permite escolher, na grade, os vendedores que
* atenderam o pedido/documento e quantos atendimentos cada um teve.
* Ao Confirmar, o legado apaga os registros de SigMvAte do documento
* (empdopnums) e reinsere as linhas atuais da grade.
*====================================================================

DEFINE CLASS SigMvAteBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvAte)
    this_cCodVends   = ""    && codvends   char(10) - codigo do vendedor
    this_cEmps       = ""    && emps       char(3)  - empresa do documento
    this_cEmpDopNums = ""    && empdopnums char(29) - chave do documento pai (SigMvCab)
    this_nAtends     = 0     && natends    numeric(4,0) - quantidade de atendimentos
    this_cPkChaves   = ""    && pkchaves   char(20) - PK

    *-- Propriedade de exibicao (NAO persistida - descricao do vendedor,
    *-- obtida via lookup em SigCdCli.rclis Where grupos = this_cGrVends
    *-- and iclis = this_cCodVends)
    this_cDescVends  = ""

    *-- Contexto do documento pai (TprMvCab no legado), necessario para
    *-- filtrar/validar os vendedores deste documento nas proximas fases
    this_cGrVends    = ""    && grvends do SigMvCab - grupo de vendedores aceito

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvAte"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigMvAteBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * LimparDados - Reseta as propriedades da entidade
    * (chamado por NovoRegistro() antes de cada Inserir() do laco de
    * Confirmar - sem isso this_cPkChaves manteria o valor da linha
    * anterior e o segundo INSERT colidiria no indice unico)
    *====================================================================
    PROCEDURE LimparDados()
        THIS.this_cCodVends   = ""
        THIS.this_cEmps       = ""
        THIS.this_cEmpDopNums = ""
        THIS.this_nAtends     = 0
        THIS.this_cPkChaves   = ""
        THIS.this_cDescVends  = ""
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    * (usado ao percorrer a grade local de atendimentos - ver Formcomp.
    * cursor tipico: crSigMvAte, populado via SELECT * FROM SigMvAte)
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodVends   = TratarNulo(codvends,   "C")
                THIS.this_cEmps       = TratarNulo(emps,       "C")
                THIS.this_cEmpDopNums = TratarNulo(empdopnums, "C")
                THIS.this_nAtends     = TratarNulo(natends,    "N")
                THIS.this_cPkChaves   = TratarNulo(pkchaves,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria do registro atual
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *====================================================================
    * Inserir - Grava novo atendimento de vendedor para o documento
    * (equivale ao INSERT INTO crSigmvAte (...) do legado, feito para
    * cada linha da grade nao-zerada ao Confirmar; gera pkchaves novo)
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cPkChaves)
                THIS.this_cPkChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigMvAte (codvends, emps, empdopnums, natends, pkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodVends)>>,
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>,
                    <<EscaparSQL(THIS.this_cPkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigMvAteBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza a quantidade de atendimentos do vendedor
    * para o documento (o legado nunca faz UPDATE de linha - apaga e
    * reinsere a grade inteira -, mas o metodo eh mantido para permitir
    * corrigir uma linha isolada sem afetar as demais do documento)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigMvAte
                SET codvends   = <<EscaparSQL(THIS.this_cCodVends)>>,
                    emps       = <<EscaparSQL(THIS.this_cEmps)>>,
                    empdopnums = <<EscaparSQL(THIS.this_cEmpDopNums)>>,
                    natends    = <<FormatarNumeroSQL(THIS.this_nAtends, 0)>>
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigMvAteBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui o atendimento do vendedor pela pkchaves
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE pkchaves = <<EscaparSQL(THIS.this_cPkChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimento de vendedor:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigMvAteBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExcluirTodosDoDocumento - Apaga TODOS os atendimentos ja gravados
    * para o documento (empdopnums), replicando o
    * "Delete all for empdopnums = pcEDN" do legado antes de reinserir
    * a grade atual ao Confirmar (ver FormSigMvAte.BtnConfirmarClick)
    *====================================================================
    PROCEDURE ExcluirTodosDoDocumento(par_cEmpDopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir atendimentos do documento:" + CHR(13) + loException.Message, "SigMvAteBO.ExcluirTodosDoDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarAtendimentosDocumento - Popula cursor_4c_LocalVen (cursor
    * local, editavel) com os vendedores ja gravados em SigMvAte para o
    * documento informado, buscando a descricao (Rclis) de cada vendedor
    * em SigCdCli filtrado pelo grupo de vendedores do documento.
    * Equivale ao trecho do Init do legado:
    *   SELECT codvends, SPACE(40) as desVends, nAtends FROM crSigmvate
    *   INTO CURSOR LocalVen READWRITE
    *   SCAN
    *       (busca RClis em SigCdCli where grupos=... and iclis=...)
    *   ENDSCAN
    * IMPORTANTE: a ordem dos campos do CREATE CURSOR abaixo tem de ser
    * IDENTICA ao cursor placeholder criado em
    * FormSigMvAte.InicializarForm (CodVends, DesVends, NAtends).
    *====================================================================
    PROCEDURE CarregarAtendimentosDocumento(par_cEmpDopNums, par_cGrVends)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cDesc

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_AtendTemp")
                USE IN cursor_4c_AtendTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT codvends, natends FROM SigMvAte
                WHERE empdopnums = <<EscaparSQL(par_cEmpDopNums)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AtendTemp")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_LocalVen")
                    USE IN cursor_4c_LocalVen
                ENDIF
                SET NULL ON
                CREATE CURSOR cursor_4c_LocalVen ;
                    (CodVends C(10) NULL, DesVends C(40) NULL, NAtends N(4,0) NULL)
                SET NULL OFF

                IF USED("cursor_4c_AtendTemp")
                    SELECT cursor_4c_AtendTemp
                    GO TOP
                    SCAN
                        loc_cDesc = THIS.ObterDescricaoVendedor(par_cGrVends, ;
                            TratarNulo(cursor_4c_AtendTemp.codvends, "C"))

                        INSERT INTO cursor_4c_LocalVen (CodVends, DesVends, NAtends) ;
                            VALUES (TratarNulo(cursor_4c_AtendTemp.codvends, "C"), ;
                                    loc_cDesc, ;
                                    TratarNulo(cursor_4c_AtendTemp.natends, "N"))
                    ENDSCAN
                    USE IN cursor_4c_AtendTemp
                ENDIF

                SELECT cursor_4c_LocalVen
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar atendimentos do documento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar atendimentos:" + CHR(13) + loException.Message, "SigMvAteBO.CarregarAtendimentosDocumento")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterDescricaoVendedor - Busca a razao social (Rclis) do vendedor
    * em SigCdCli, filtrando pelo grupo de vendedores do documento
    * (equivale a SqlExecute("Select rclis From SigCdCli where grupos =
    * ... and iclis = ...") do legado). Retorna "" se nao encontrado -
    * PUBLIC porque o Form chama para revalidar codigos digitados na grade.
    *====================================================================
    PROCEDURE ObterDescricaoVendedor(par_cGrVends, par_cCodVends)
        LOCAL loc_cSQL, loc_nResultado, loc_cRetorno

        loc_cRetorno = ""

        IF EMPTY(par_cCodVends)
            RETURN loc_cRetorno
        ENDIF

        TRY
            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT rclis FROM SigCdCli
                WHERE grupos = <<EscaparSQL(par_cGrVends)>>
                  AND iclis  = <<EscaparSQL(par_cCodVends)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VenTemp")

            IF loc_nResultado > 0 AND USED("cursor_4c_VenTemp") AND RECCOUNT("cursor_4c_VenTemp") > 0
                loc_cRetorno = TratarNulo(cursor_4c_VenTemp.rclis, "C")
            ENDIF

            IF USED("cursor_4c_VenTemp")
                USE IN cursor_4c_VenTemp
            ENDIF
        CATCH TO loException
            loc_cRetorno = ""
        ENDTRY

        RETURN loc_cRetorno
    ENDPROC

ENDDEFINE
