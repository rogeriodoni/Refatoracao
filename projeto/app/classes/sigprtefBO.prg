*==============================================================================
* sigprtefBO.prg - Business Object para Administracao do TEF
* Fase 1/8 - Propriedades e Init
*==============================================================================
DEFINE CLASS sigprtefBO AS BusinessBase

    *-- Identificacao da operacao TEF
    this_cOperacao      = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
    this_cNoCaixa       = ""    && Numero do caixa fiscal (crSigFiMpf.cnCaixas)
    this_cNoFab         = ""    && Numero de fabricacao da impressora fiscal (LeituraFab)
    this_cPcIdChaves    = ""    && Chaves de identificacao da transacao TEF (param Init)

    *-- Parametros do sistema TEF carregados de SigCdPam
    this_nSistef        = 0     && Tipo sistema TEF: 1=SiTef/Autoritec, 3=VeriFone
    this_cImps          = ""    && Modelo impressora fiscal (ex: SWEDA) de crSigFiFis

    *-- Campo de busca / validacao TEF
    this_cRedeTef       = ""    && Comprovante / rede TEF selecionada (Get_redetef)

    *-- Flags de controle de acesso e estado
    this_lAcessoAdm     = .F.   && Acesso habilitado para operacao Admin TEF
    this_lAcessoAtv     = .F.   && Acesso habilitado para verificacao TEF Ativo
    this_lInicializado  = .F.   && Inicializacao concluida com sucesso (impressora OK)

    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor coSigCdPam
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nSistef = NVL(Sistef, 0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao TEF corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cOperacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL TEF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL TEF (usar AtualizarStatusTef)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao TEF em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, Usuario, DataHora, ChaveRegistro) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigFiTef") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosTEF - Carrega Sistef de SigCdPam e popula this_nSistef
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosTEF()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("coSigCdPam")
                USE IN coSigCdPam
            ENDIF
            loc_cSQL = "SELECT Sistef FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "coSigCdPam") > 0
                SELECT coSigCdPam
                GOTO TOP
                IF !EOF()
                    this_nSistef = NVL(Sistef, 0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoraFiscal - Carrega SigFiMpF pelo numero de fabricacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiMpF")
                USE IN crSigFiMpF
            ENDIF
            loc_cSQL = "SELECT cnCaixas FROM SigFiMpF"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF") > 0
                SELECT crSigFiMpF
                GOTO TOP
                IF !EOF()
                    this_cNoCaixa = NVL(cnCaixas, "")
                    this_cNoFab   = ALLTRIM(par_cNoFab)
                    loc_lSucesso  = .T.
                ELSE
                    MsgAviso("Impressora Fiscal Inv" + CHR(225) + "lida para esta Loja !!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComprovantes - Busca comprovantes TEF em SigFiNfs por modelo impressora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComprovantes(par_cImps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigFiNfs")
                USE IN CrSigFiNfs
            ENDIF
            loc_cSQL = "SELECT * FROM SigFiNfs WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigFiNfs") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o ao buscar comprovantes TEF", "Falha na Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNFiscalPorComprovante - Busca SigFiNfs por Imps e cComprovs
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNFiscalPorComprovante(par_cImps, par_cComprovs)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crTmpNFis")
                USE IN crTmpNFis
            ENDIF
            loc_cSQL = "SELECT Imps, cComprovs, cTefdReqs, cTefdResps, nQtdVias " + ;
                       "FROM SigFiNfs " + ;
                       "WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps)) + ;
                       " AND cComprovs = " + EscaparSQL(ALLTRIM(par_cComprovs))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpNFis") > 0
                SELECT crTmpNFis
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoTEF - Busca SigFiTef pelos campos chave (tipo/empresa/operacao/ident)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoTEF(par_cTipo, par_cEmps, par_cDopes, par_cIdents)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiTef")
                USE IN crSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTef") > 0
                SELECT crSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoPorIdChaves - Busca SigFiTef por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoPorIdChaves(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("csSigFiTef")
                USE IN csSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "csSigFiTef") > 0
                SELECT csSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTef - UPDATE SigFiTef SET cStatus por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTef(par_cIdChaves, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cIdChaves", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorRede - UPDATE SigFiTef SET cStatus por cnmredes/cnnsus (CRT)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorRede(par_cNmRedes, par_cNSUs, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnmredes = " + EscaparSQL(par_cNmRedes) + ;
                       " AND cnnsus = " + EscaparSQL(par_cNSUs) + ;
                       " AND cHeaders = 'CRT'"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por rede", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorIdents - UPDATE SigFiTef SET cStatus por cnIdents
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorIdents(par_cIdents, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cnIdents", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
