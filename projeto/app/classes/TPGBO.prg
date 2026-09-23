*==============================================================================
* TPGBO.prg - Business Object para Tipos de Transporte Automatico
*==============================================================================
* Tabela   : SigPrTra
* PK real  : cidchaves (CHAR 20, gerado por fUniqueIds)
* Chave neg: emps + tptrans + tps
* Herda de : BusinessBase (app\classes\businessbase.prg)
*
* Fase 1/8 - Propriedades e Init
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS TPGBO AS BusinessBase

    *==========================================================================
    *-- PROPRIEDADES DA TABELA SigPrTra (schema exato)
    *==========================================================================

    *-- Chave primaria real (gerada por fUniqueIds)
    this_cCidChaves = ""    && cidchaves CHAR(20) - PK

    *-- Chave de negocio composta: Emps + TpTrans + Tps
    this_cEmps      = ""    && emps      CHAR(3)  - Codigo da Empresa
    this_cTpTrans   = ""    && tptrans   CHAR(6)  - Codigo do Tipo de Transporte (FK SigPrTrn.codigos)
    this_cTps       = ""    && tps       CHAR(1)  - Tipo (T=Transporte / R=Recepcao)

    *-- Coluna NOT NULL sem campo na tela original (regra #22 CLAUDE.md)
    this_cModulos   = ""    && modulos   CHAR(1)  - Modulo (nao exibido no legado)

    *==========================================================================
    *-- INICIALIZACAO
    *==========================================================================

    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrTra"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "TPGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- AUDITORIA: retorna PK real para RegistrarAuditoria()
    *==========================================================================

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *==========================================================================
    *-- CarregarDoCursor - Carrega propriedades a partir de uma linha do
    *-- cursor de dados (crSigPrTrn no legado / cursor_4c_Dados no migrado)
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cIdChaves, "C")
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_cTpTrans   = TratarNulo(TpTrans,   "C")
                THIS.this_cTps       = TratarNulo(Tps,       "C")
                THIS.this_cModulos   = TratarNulo(Modulos,   "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TPGBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Inserir - Grava novo registro na tabela SigPrTra
    *-- Cobre TODAS as colunas NOT NULL (emps, tptrans, tps, cidchaves, modulos)
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrTra (emps, tptrans, tps, cidchaves, modulos)
                VALUES (
                    <<EscaparSQL(THIS.this_cEmps)>>,
                    <<EscaparSQL(THIS.this_cTpTrans)>>,
                    <<EscaparSQL(THIS.this_cTps)>>,
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(THIS.this_cModulos)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TPGBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- Atualizar - Atualiza registro existente na tabela SigPrTra
    *-- Chave de localizacao: cidchaves (PK real, imutavel)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrTra
                SET emps    = <<EscaparSQL(THIS.this_cEmps)>>,
                    tptrans = <<EscaparSQL(THIS.this_cTpTrans)>>,
                    tps     = <<EscaparSQL(THIS.this_cTps)>>,
                    modulos = <<EscaparSQL(THIS.this_cModulos)>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TPGBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- CarregarLista - Popula cursor_4c_Dados (READWRITE) com todos os
    *-- registros de SigPrTra, na ordem Emps+TpTrans+Tps (Index EmpTp legado)
    *-- Cursor precisa ser READWRITE porque a grade do form eh EDITAVEL
    *-- diretamente sobre as celulas (regra: grid editavel + cursor de
    *-- SQLEXEC = somente leitura)
    *==========================================================================
    PROCEDURE CarregarLista()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            IF USED("cursor_4c_DadosTmp")
                USE IN cursor_4c_DadosTmp
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                SELECT cidchaves, emps, tptrans, tps
                FROM SigPrTra
                ORDER BY emps, tptrans, tps
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")

            IF loc_nResultado >= 0
                SELECT cidchaves, emps, tptrans, tps, .F. AS flagnovo ;
                    FROM cursor_4c_DadosTmp ;
                    INTO CURSOR cursor_4c_Dados READWRITE

                IF USED("cursor_4c_DadosTmp")
                    USE IN cursor_4c_DadosTmp
                ENDIF

                SELECT cursor_4c_Dados
                INDEX ON emps + tptrans + tps TAG EmpTp
                SET ORDER TO TAG EmpTp
                GO TOP

                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar tipos de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "TPGBO.CarregarLista")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;
                        "TPGBO.CarregarLista")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    *-- ExcluirPorChave - Exclui diretamente um registro ja persistido de
    *-- SigPrTra pela PK real (cidchaves). Usado pela grade editavel do form,
    *-- que grava/exclui linha a linha (NUNCA chamar ExecutarExclusao() daqui
    *-- - este metodo eh o caminho publico equivalente para exclusao por
    *-- linha de grade, fora do fluxo de registro unico de BusinessBase)
    *==========================================================================
    FUNCTION ExcluirPorChave(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(par_cCidChaves, "")))
            RETURN .F.
        ENDIF

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                DELETE FROM SigPrTra
                WHERE cidchaves = <<EscaparSQL(par_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cCidChaves = par_cCidChaves
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de transporte:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, ;
                        "TPGBO.ExcluirPorChave")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
