*==============================================================================
* SIGREINFBO.PRG
* Business Object para Impressao de Nota Fiscal (SigReInf)
* Herda de RelatorioBase
*
* Tabela principal: SigMvNfi
* Forma de uso: Recebe parametros de NF (empresa, operacao, numero, serie)
*               e delega impressao/visualizacao para SigPrNfs
*==============================================================================

DEFINE CLASS SigReInfBO AS RelatorioBase

    *-- Identificacao
    this_cTabela        = "SigMvNfi"
    this_cCampoChave    = "Nfis"

    *-- Parametros da Nota Fiscal (recebidos via Init)
    this_cEmps          = ""
    this_cDopes         = ""
    this_nNumes         = 0
    this_cSerie         = ""

    *-- Controle de habilitacao de botoes
    this_lVisualizarHabilitado = .F.
    this_lImprimirHabilitado   = .F.

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega configuracoes de SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta e executa SQL para obter NFs a imprimir
    * Retorna .T. se dados foram preparados com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_llFalse, loc_cSQL, loc_nResult
        loc_lSucesso = .F.
        loc_llFalse  = .F.

        TRY
            loc_cSQL = "Select c.Nfis, c.EmpdopNums From SigMvNfi c, SigCdOpe a " + ;
                       "Where c.emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " And c.series = " + EscaparSQL(THIS.this_cSerie) + ;
                       " And c.Impress = 0 and c.cancelas = 0" + ;
                       " And c.dopes = a.dopes" + ;
                       " and a.nfiscals in (1,2) and a.tiponfs <> 4 and a.agrupas = 1" + ;
                       " Union all " + ;
                       "Select c.Nfis, c.EmpDopNums From SigMvNfi c, SigCdOpe a, SigCdSer b " + ;
                       "Where c.emps = " + EscaparSQL(THIS.this_cEmps) + ;
                       " And c.series = " + EscaparSQL(THIS.this_cSerie) + ;
                       " And c.Impress = 0 And c.cancelas = 0" + ;
                       " and c.series = b.cods" + ;
                       " And c.dopes = a.dopes" + ;
                       " and a.nfiscals in (1,2) and a.tiponfs = 4 and b.impnfs = 1"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFiscal")

            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + "o ao buscar dados da NF"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Verifica SigCdPam e habilita botoes conforme regras
    * Equivalente ao Init() original que consultava SigCdPam
    *--------------------------------------------------------------------------
    PROCEDURE CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT nnfftlns, nnfftcls FROM SigCdPam", ;
                "cursor_4c_Pam")

            IF loc_nResult > 0
                SELECT cursor_4c_Pam
                IF !EOF()
                    IF nnfftlns = 999 OR nnfftcls = 999
                        THIS.this_lVisualizarHabilitado = .T.
                    ENDIF
                ENDIF
                USE IN cursor_4c_Pam
            ENDIF

            THIS.this_lImprimirHabilitado = .T.
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Executa preview da NF na tela
    * Equivalente ao metodo 'visualizacao' do form original (modo "V")
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            DO SigPrNfs WITH gnConnHandle, "V", THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Executa impressao direta da NF
    * Equivalente ao metodo 'impressao' do form original (modo "I")
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF

            DO SigPrNfs WITH gnConnHandle, "I", THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave de identificacao da NF
    * Formato: emps + dopes + numes (mesmo padrao do lcEdn no original)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmps + THIS.this_cDopes + STR(THIS.this_nNumes, 6)
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Override: relatorios nao escrevem dados, sem auditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpeza de recursos
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        DODEFAULT()
    ENDPROC

ENDDEFINE
