*==============================================================================
* SIGPRCPRBO.prg - Business Object para Conferencia e Reserva de Producao
* Origem legada: SIGPRCPR.SCX (dialogo modal chamado por um form pai de
*                Ordem de Producao - recebe ParentForm, Get_Data.Value e
*                crSigCdPac.SigKeys do form que o abre)
* Herda de: BusinessBase
*
* Este dialogo NAO eh um CRUD de registro unico: ele confere (leitura de
* codigo de barra) etiquetas de producao ainda nao confirmadas e, ao
* confirmar, GERA em lote um cabecalho SigMvCab por combinacao Grupo/Conta
* de destino, com os detalhes SigMvItn e os DOIS historicos SigMvHst (saida
* da conta de confirmacao, entrada na conta de destino), alem de mover as
* etiquetas em SigOpEtq. Por isso a "gravacao" real fica em
* ConfirmarConferencia() (equivalente ao Click do Ok legado), e nao em
* Inserir()/Atualizar() por registro - ver comentario acima desses metodos.
*
* Fase 2/8: Metodos de negocio (equivalentes a CarregaBars/Valid do
* Get_Leitura/Click do Conferencia/Click do Ok do legado), CarregarDoCursor,
* ObterChavePrimaria.
*==============================================================================
DEFINE CLASS SIGPRCPRBO AS BusinessBase

    *-- Identificacao - a "entidade" persistida por este dialogo eh o
    *-- cabecalho de movimento gerado na confirmacao (equivalente ao Salvar)
    this_cTabela      = "SigMvCab"
    this_cCampoChave  = "cidchaves"

    *-- Contexto recebido do form pai (fluxo modal legado via ParentForm)
    this_cEmpresa         = ""    && Empresa (Emps) - equivalente a go_4c_Sistema.cCodEmpresa do legado
    this_cUsuario         = ""    && Usuario logado (Usuar do legado)
    this_dDataBase        = {}    && Data (Get_Data.Value do form pai) - exibicao readonly
    this_cSigKey          = ""    && SigKeys (crSigCdPac.SigKeys do form pai/CarregarParametrosSistema)

    *-- Nome do cursor com as operacoes selecionadas no form pai (Dopps/Numps),
    *-- equivalente a TmpEnc do legado. O CALLER (form/BO chamador) deve
    *-- popular este cursor ANTES de chamar o metodo de carga de etiquetas.
    this_cCursorOperacoes = "cursor_4c_Operacoes"

    *-- Parametros do sistema (SigCdPam) usados na conferencia/reserva -
    *-- carregados por CarregarParametrosSistema()
    this_cGrupoConfirmacao   = ""    && GruConfs
    this_cContaConfirmacao   = ""    && ConConfs
    this_cDopeCitens         = ""    && DopeCitens (operacao de cite/transferencia parcial)
    this_cGrupoReserva       = ""    && GruReservs
    this_cContaReserva       = ""    && ConReservs
    this_cGrupoEstoque       = ""    && GrupoEsts
    this_cContaEstoque       = ""    && ContaEsts
    this_cDopeTransferencia  = ""    && TransfEncs (operacao do documento gerado ao confirmar)

    *-- Estado da grade de etiquetas (cursor equivalente a TmpBaixa do legado)
    this_cCursorBaixa      = "cursor_4c_Baixa"    && Nome fixo do cursor da grade
    this_lPossuiEtiquetas  = .F.                  && .T. quando ha pelo menos 1 etiqueta pendente

    *-- Leitura de codigo de barras
    this_cCodigoBarraLido  = ""

    *-- Linha CORRENTE do cursor de baixa (grid), populada por CarregarDoCursor
    *-- - espelha os campos de TmpBaixa do registro em foco na grade
    this_cCodigoBarraAtual    = ""
    this_cProdutoAtual        = ""
    this_cOperacaoAtual       = ""
    this_nNumeroAtual         = 0
    this_nQuantidadeAtual     = 0
    this_nQuantidadeLidaAtual = 0
    this_nSequenciaAtual      = 0
    this_cGrupoContaAtual     = ""    && Grupods da linha corrente
    this_cContaContaAtual     = ""    && Contads da linha corrente

    *-- Chave do ultimo documento de conferencia gerado (SigMvCab.cidchaves) -
    *-- usada por ObterChavePrimaria()/RegistrarAuditoria() ao confirmar
    this_cCidChaveGerada = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = DODEFAULT()

            THIS.this_cTabela     = "SigMvCab"
            THIS.this_cCampoChave = "cidchaves"

            IF EMPTY(THIS.this_cCursorOperacoes)
                THIS.this_cCursorOperacoes = "cursor_4c_Operacoes"
            ENDIF
            IF EMPTY(THIS.this_cCursorBaixa)
                THIS.this_cCursorBaixa = "cursor_4c_Baixa"
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, ;
                "Erro em SIGPRCPRBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * MontarEmpDopNums / MontarEmpGruEsts - chaves POSICIONAIS concatenadas.
    * NUNCA usar ALLTRIM nas partes: o padding faz parte da chave (regra do
    * projeto sobre chaves posicionais - Erro177). EmpDopNums = Emps(3) +
    * Dopes(20) + Str(Numes,6) = 29 (bate com char(29) do schema). EmpGruEsts
    * = Emp(3) + Grupo(10) + Conta(10) = 23 (bate com char(23) do schema).
    *==========================================================================
    PROTECTED PROCEDURE MontarEmpDopNums(par_cEmp, par_cDope, par_nNume)
        RETURN PADR(par_cEmp, 3) + PADR(par_cDope, 20) + STR(par_nNume, 6)
    ENDPROC

    PROTECTED PROCEDURE MontarEmpGruEsts(par_cEmp, par_cGrupo, par_cConta)
        RETURN PADR(par_cEmp, 3) + PADR(par_cGrupo, 10) + PADR(par_cConta, 10)
    ENDPROC

    *==========================================================================
    * ConsultarRegistro - helper generico equivalente ao
    * ThisForm.poDataMgr.CursorQuery(tabela, alias, campoChave, valor, campos)
    * do legado: SELECT <campos> FROM <tabela> WHERE <condicao> INTO CURSOR
    * <alias>. Fecha o cursor anterior (se existir) antes de reconsultar.
    * Devolve .T. apenas quando a consulta teve sucesso E trouxe pelo menos
    * 1 linha (equivalente ao "If Not Eof()" que cerca cada CursorQuery no
    * legado).
    *==========================================================================
    PROTECTED PROCEDURE ConsultarRegistro(par_cTabela, par_cAlias, par_cWhere, par_cCampos)
        LOCAL loc_cSQL, loc_nResultado, loc_cCampos

        IF USED(par_cAlias)
            USE IN (par_cAlias)
        ENDIF

        loc_cCampos = IIF(VARTYPE(par_cCampos) = "C" AND !EMPTY(par_cCampos), par_cCampos, "*")

        loc_cSQL = "SELECT " + loc_cCampos + " FROM " + par_cTabela + " WHERE " + par_cWhere

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cAlias)

        RETURN (loc_nResultado >= 0) AND USED(par_cAlias) AND RECCOUNT(par_cAlias) > 0
    ENDPROC

    *==========================================================================
    * CarregarParametrosSistema - carrega os parametros de SigCdPam
    * (equivalente ao acesso direto a crSigCdPam no legado, que ja vinha
    * pre-carregado no startup do Fortyus - ver regra do projeto sobre
    * cursores globais Fortyus) e a SigKey de SigCdPac (Thisform.SigKey =
    * CrSigCdPac.SigKeys no Init legado). Chamado no inicio da
    * carga de etiquetas.
    *==========================================================================
    PROCEDURE CarregarParametrosSistema()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF THIS.ConsultarRegistro("SigCdPam", "cursor_4c_Pam", "1 = 1", ;
                    "GruConfs, ConConfs, DopeCitens, GruReservs, ConReservs, GrupoEsts, ContaEsts, TransfEncs")
                SELECT cursor_4c_Pam
                THIS.this_cGrupoConfirmacao  = TratarNulo(GruConfs, "")
                THIS.this_cContaConfirmacao  = TratarNulo(ConConfs, "")
                THIS.this_cDopeCitens        = TratarNulo(DopeCitens, "")
                THIS.this_cGrupoReserva      = TratarNulo(GruReservs, "")
                THIS.this_cContaReserva      = TratarNulo(ConReservs, "")
                THIS.this_cGrupoEstoque      = TratarNulo(GrupoEsts, "")
                THIS.this_cContaEstoque      = TratarNulo(ContaEsts, "")
                THIS.this_cDopeTransferencia = TratarNulo(TransfEncs, "")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Configura" + CHR(231) + CHR(227) + "o de Par" + CHR(226) + ;
                    "metros do Sistema N" + CHR(227) + "o Encontrada (SigCdPam)."
            ENDIF

            IF loc_lSucesso AND THIS.ConsultarRegistro("SigCdPac", "cursor_4c_Pac", "1 = 1", "SigKeys")
                THIS.this_cSigKey = TratarNulo(cursor_4c_Pac.SigKeys, "")
            ENDIF
        CATCH TO loc_oErro
            loc_lSucesso = .F.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarParametrosSistema")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CalcularQtdeBaixaCitacao - equivalente ao bloco "If Not
    * Empty(_DopeCit) ... EndIf" do CarregaBars legado. Quando existe uma
    * operacao de citacao (DopeCitens) e o documento gerador tambem existe
    * como movimento de citacao, aloca a quantidade da etiqueta contra as
    * linhas ainda nao baixadas (SigMvItn para produto simples - lnTipoEstos
    * = 1, SigMvIts+SigMvItn para produto com grade - lnTipoEstos 2/3/4) e
    * devolve a quantidade que foi baixada via citacao (_QtCit do legado).
    * Devolve -1 se uma escrita no SQL Server falhar (o caller deve abortar
    * o carregamento).
    *==========================================================================
    PROTECTED FUNCTION CalcularQtdeBaixaCitacao(par_cEmpos, par_cCPros, par_cCodCors, par_cCodTams, ;
            par_nNumeOs, par_nTipoEstos, par_nQtdeEtiqueta, par_dAgora)
        LOCAL loc_cChaveCite, loc_nBaixa, loc_nPendente, loc_nVal
        LOCAL loc_lBaixouTudo, loc_lPendenteMaior, loc_cSQL

        loc_nBaixa = par_nQtdeEtiqueta

        IF EMPTY(THIS.this_cDopeCitens)
            RETURN 0
        ENDIF

        loc_cChaveCite = THIS.MontarEmpDopNums(par_cEmpos, THIS.this_cDopeCitens, par_nNumeOs)

        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovCite", "EmpDopNums = " + EscaparSQL(loc_cChaveCite), "cidchaves")
            RETURN 0
        ENDIF

        IF par_nTipoEstos = 1
            IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItensCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + " AND CPros = " + EscaparSQL(par_cCPros), ;
                    "cIdChaves, QtBaixas, Qtds")
                SELECT cursor_4c_ItensCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF (cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas) != 0
                        loc_nPendente = cursor_4c_ItensCite.Qtds - cursor_4c_ItensCite.QtBaixas
                        IF loc_nPendente > loc_nBaixa
                            loc_nVal   = loc_nBaixa
                            loc_nBaixa = 0
                        ELSE
                            loc_nVal   = loc_nPendente
                            loc_nBaixa = loc_nBaixa - loc_nPendente
                        ENDIF
                        loc_lBaixouTudo = (cursor_4c_ItensCite.QtBaixas + loc_nVal = cursor_4c_ItensCite.Qtds)

                        loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                            "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + ", DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                            "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItensCite.cIdChaves)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI)" + CHR(13) + CapturarErroSQL()
                            RETURN -1
                        ENDIF
                        SQLCOMMIT(gnConnHandle)
                    ENDIF
                    SELECT cursor_4c_ItensCite
                ENDSCAN
            ENDIF
        ELSE
            IF THIS.ConsultarRegistro("SigMvIts", "cursor_4c_GradesCite", ;
                    "EmpDopNums = " + EscaparSQL(loc_cChaveCite) + ;
                    " AND CPros = " + EscaparSQL(par_cCPros) + ;
                    " AND CodCors = " + EscaparSQL(par_cCodCors) + ;
                    " AND CodTams = " + EscaparSQL(par_cCodTams), ;
                    "cIdChaves, EmpDopNums, CItens, QtBaixas, Qtds")
                SELECT cursor_4c_GradesCite
                GO TOP
                SCAN WHILE loc_nBaixa > 0
                    IF THIS.ConsultarRegistro("SigMvItn", "cursor_4c_ItenCiteItn", ;
                            "EmpDopNums = " + EscaparSQL(cursor_4c_GradesCite.EmpDopNums) + ;
                            " AND CItens = " + FormatarNumeroSQL(cursor_4c_GradesCite.CItens, 0), ;
                            "cIdChaves, QtBaixas, Qtds")

                        loc_nPendente = cursor_4c_GradesCite.Qtds - cursor_4c_GradesCite.QtBaixas
                        IF loc_nPendente != 0
                            loc_lPendenteMaior = (loc_nPendente > loc_nBaixa)
                            loc_nVal        = IIF(loc_lPendenteMaior, loc_nBaixa, loc_nPendente)
                            loc_lBaixouTudo = (cursor_4c_GradesCite.QtBaixas + loc_nVal = cursor_4c_GradesCite.Qtds)

                            loc_cSQL = "UPDATE SigMvIts SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "ChkSubn = " + IIF(loc_lBaixouTudo, "1", "0") + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_GradesCite.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEstI2)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_cSQL = "UPDATE SigMvItn SET QtBaixas = QtBaixas + " + FormatarNumeroSQL(loc_nVal, 3) + ", " + ;
                                "DtAlts = " + FormatarDataSQL(par_dAgora) + " " + ;
                                "WHERE cIdChaves = " + EscaparSQL(cursor_4c_ItenCiteItn.cIdChaves)
                            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (LocalEestI - CItens)" + CHR(13) + CapturarErroSQL()
                                RETURN -1
                            ENDIF
                            SQLCOMMIT(gnConnHandle)

                            loc_nBaixa = IIF(loc_lPendenteMaior, 0, loc_nBaixa - loc_nPendente)
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_GradesCite
                ENDSCAN
            ENDIF
        ENDIF

        RETURN par_nQtdeEtiqueta - loc_nBaixa
    ENDFUNC

    *==========================================================================
    * Carga das etiquetas do documento - equivalente a CarregaBars() do legado.
    * Para cada operacao (Dopps/Numps) do cursor THIS.this_cCursorOperacoes
    * (equivalente a TmpEnc, populado pelo CALLER), busca as etiquetas de
    * SigOpEtq atualmente na conta de confirmacao (GruConfs/ConConfs) e
    * calcula, para cada uma, a conta de destino (reserva do parametro, do
    * cliente ou do movimento de origem) e a parcela ja baixada por citacao
    * (CalcularQtdeBaixaCitacao), inserindo 1 ou 2 linhas por etiqueta em
    * THIS.this_cCursorBaixa (equivalente a TmpBaixa).
    *
    * Nao repinta grade nem mostra mensagem de "nenhuma etiqueta" - isso e
    * responsabilidade do Form (equivalente ao final de CarregaBars que
    * mexe em Visible/SetFocus), que deve checar THIS.this_lPossuiEtiquetas
    * apos chamar este metodo.
    *==========================================================================
    PROCEDURE CarregarEtiquetasPendentes()
        LOCAL loc_lSucesso, loc_oErro, loc_lProsseguir, loc_lFalhouCarga
        LOCAL loc_cChaveDoc, loc_dAgora
        LOCAL loc_nCBars, loc_cGrupos, loc_cContas, loc_cCPros, loc_cDopeOs, loc_cEmposE
        LOCAL loc_nNumeOs, loc_nNopsE, loc_nQtds, loc_cCodCorsE, loc_cCodTamsE
        LOCAL loc_cDopesOrigem, loc_cGrupoosOrig, loc_cContaosOrig, loc_cGrupodsOrig, loc_cContadsOrig
        LOCAL loc_lGlobalOuServico, loc_cTGrupo, loc_cTConta, loc_cGrupo, loc_cConta
        LOCAL loc_nTipoEstos, loc_cCGrus, loc_cGruProds, loc_cConProds
        LOCAL loc_nQtEti, loc_nQtCit

        loc_lSucesso     = .F.
        loc_lProsseguir  = .T.
        loc_lFalhouCarga = .F.

        TRY
            IF USED(THIS.this_cCursorBaixa)
                USE IN (THIS.this_cCursorBaixa)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorBaixa) ;
                (CodBarra N(14,0), CPros C(14), Dopes C(20), Numes N(6,0), ;
                 Qtde N(9,3), QtdeLido N(9,3), Nops N(10,0), Grupods C(10), Contads C(10))
            INDEX ON CodBarra TAG CodBarra
            INDEX ON Grupods + Contads TAG GruConta

            IF !THIS.CarregarParametrosSistema()
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir AND !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Nenhuma opera" + CHR(231) + CHR(227) + "o selecionada para confer" + CHR(234) + "ncia."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                loc_dAgora = DATETIME()

                SELECT (THIS.this_cCursorOperacoes)
                SCAN FOR !EMPTY(Dopps) AND !EMPTY(Numps)
                    loc_cChaveDoc = THIS.MontarEmpDopNums(THIS.this_cEmpresa, Dopps, Numps)

                    IF !THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_Etiqueta", ;
                            "EmpDopNums = " + EscaparSQL(loc_cChaveDoc), "*")
                        SELECT (THIS.this_cCursorOperacoes)
                        LOOP
                    ENDIF

                    SELECT cursor_4c_Etiqueta
                    SCAN
                        loc_nCBars    = cursor_4c_Etiqueta.CBars
                        loc_cGrupos   = cursor_4c_Etiqueta.Grupos
                        loc_cContas   = cursor_4c_Etiqueta.Contas
                        loc_cCPros    = cursor_4c_Etiqueta.CPros
                        loc_cDopeOs   = cursor_4c_Etiqueta.DopeOs
                        loc_cEmposE   = cursor_4c_Etiqueta.Empos
                        loc_nNumeOs   = cursor_4c_Etiqueta.NumeOs
                        loc_nNopsE    = cursor_4c_Etiqueta.Nops
                        loc_nQtds     = cursor_4c_Etiqueta.Qtds
                        loc_cCodCorsE = cursor_4c_Etiqueta.CodCors
                        loc_cCodTamsE = cursor_4c_Etiqueta.CodTams

                        IF loc_cGrupos + loc_cContas != THIS.this_cGrupoConfirmacao + THIS.this_cContaConfirmacao
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF

                        IF !THIS.ConsultarRegistro("SigMvCab", "cursor_4c_MovOrigem", ;
                                "EmpDopNums = " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmposE, loc_cDopeOs, loc_nNumeOs)), "*")
                            SELECT cursor_4c_Etiqueta
                            LOOP
                        ENDIF
                        loc_cDopesOrigem = cursor_4c_MovOrigem.Dopes
                        loc_cGrupoosOrig = cursor_4c_MovOrigem.Grupoos
                        loc_cContaosOrig = cursor_4c_MovOrigem.Contaos
                        loc_cGrupodsOrig = cursor_4c_MovOrigem.Grupods
                        loc_cContadsOrig = cursor_4c_MovOrigem.Contads

                        loc_lGlobalOuServico = .F.
                        IF THIS.ConsultarRegistro("SigCdOpe", "cursor_4c_TipoOper", ;
                                "Dopes = " + EscaparSQL(loc_cDopesOrigem), "Globalizas, Servicos")
                            loc_lGlobalOuServico = (cursor_4c_TipoOper.Globalizas = 1 OR cursor_4c_TipoOper.Servicos = 1)
                        ENDIF

                        IF loc_lGlobalOuServico
                            loc_cTGrupo = loc_cGrupoosOrig
                            loc_cTConta = loc_cContaosOrig
                        ELSE
                            loc_cTGrupo = loc_cGrupodsOrig
                            loc_cTConta = loc_cContadsOrig
                        ENDIF

                        loc_cGrupo = IIF(EMPTY(THIS.this_cGrupoReserva), loc_cTGrupo, THIS.this_cGrupoReserva)
                        loc_cConta = IIF(EMPTY(THIS.this_cContaReserva), loc_cTConta, THIS.this_cContaReserva)

                        loc_nTipoEstos = 1
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_Produto", "CPros = " + EscaparSQL(loc_cCPros), "CGrus")
                            loc_cCGrus = cursor_4c_Produto.CGrus
                            IF THIS.ConsultarRegistro("SigCdGrp", "cursor_4c_Grupo", "CGrus = " + EscaparSQL(loc_cCGrus), "TipoEstos")
                                loc_nTipoEstos = IIF(INLIST(cursor_4c_Grupo.TipoEstos, 2, 3, 4), cursor_4c_Grupo.TipoEstos, 1)
                            ENDIF
                        ENDIF

                        IF THIS.ConsultarRegistro("SigCdCli", "cursor_4c_Cliente", "IClis = " + EscaparSQL(loc_cTConta), "GruProds, ConProds")
                            loc_cGruProds = TratarNulo(cursor_4c_Cliente.GruProds, "")
                            loc_cConProds = TratarNulo(cursor_4c_Cliente.ConProds, "")
                        ELSE
                            loc_cGruProds = ""
                            loc_cConProds = ""
                        ENDIF

                        loc_nQtCit = THIS.CalcularQtdeBaixaCitacao(loc_cEmposE, loc_cCPros, loc_cCodCorsE, loc_cCodTamsE, ;
                                        loc_nNumeOs, loc_nTipoEstos, loc_nQtds, loc_dAgora)

                        IF loc_nQtCit < 0
                            THIS.this_cMensagemErro = "Falha ao processar baixa de cita" + CHR(231) + CHR(227) + ;
                                "o para a etiqueta " + TRANSFORM(loc_nCBars) + "."
                            loc_lFalhouCarga = .T.
                            SELECT cursor_4c_Etiqueta
                            EXIT
                        ENDIF

                        loc_nQtEti = loc_nQtds - loc_nQtCit

                        loc_cGrupo = IIF(EMPTY(loc_cGruProds), loc_cGrupo, loc_cGruProds)
                        loc_cConta = IIF(EMPTY(loc_cConProds), loc_cConta, loc_cConProds)

                        IF loc_nQtEti != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtEti, 0, loc_nNopsE, loc_cGrupo, loc_cConta)
                        ENDIF

                        IF loc_nQtCit != 0
                            INSERT INTO (THIS.this_cCursorBaixa) (CodBarra, CPros, Dopes, Numes, Qtde, QtdeLido, Nops, Grupods, Contads) ;
                                VALUES (loc_nCBars, loc_cCPros, loc_cDopeOs, loc_nNumeOs, loc_nQtCit, 0, loc_nNopsE, ;
                                        THIS.this_cGrupoEstoque, THIS.this_cContaEstoque)
                        ENDIF

                        SELECT cursor_4c_Etiqueta
                    ENDSCAN

                    SELECT (THIS.this_cCursorOperacoes)

                    IF loc_lFalhouCarga
                        EXIT
                    ENDIF
                ENDSCAN

                THIS.this_lPossuiEtiquetas = (RECCOUNT(THIS.this_cCursorBaixa) > 0)
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhouCarga = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao carregar etiquetas pendentes")
        ENDTRY

        loc_lSucesso = loc_lProsseguir AND !loc_lFalhouCarga

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ProcessarLeituraCodigoBarra - equivalente ao Valid do Get_Leitura.
    * Recebe o codigo de barra digitado/lido e devolve um status para o
    * Form decidir a mensagem/refresh (o dialogo MsgAviso e o Refresh() do
    * Grid sao responsabilidade da UI, nao do BO):
    *   "VAZIO"          - nada foi digitado (o legado nao faz nada)
    *   "SEM_CURSOR"     - a carga de etiquetas ainda nao rodou
    *   "LIDO"           - encontrou a etiqueta e marcou QtdeLido = Qtde
    *   "JA_LIDO"        - encontrou a etiqueta mas ja estava conferida
    *   "NAO_CADASTRADO" - codigo de barra nao existe no cursor de baixa
    *==========================================================================
    FUNCTION ProcessarLeituraCodigoBarra(par_nCodigoBarra)
        LOCAL loc_cResultado

        loc_cResultado = "VAZIO"

        IF VARTYPE(par_nCodigoBarra) != "N" OR par_nCodigoBarra = 0
            RETURN loc_cResultado
        ENDIF

        THIS.this_cCodigoBarraLido = TRANSFORM(par_nCodigoBarra)

        IF !USED(THIS.this_cCursorBaixa)
            RETURN "SEM_CURSOR"
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra

        IF SEEK(par_nCodigoBarra)
            IF EVALUATE(THIS.this_cCursorBaixa + ".QtdeLido") = 0
                REPLACE QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)
                loc_cResultado = "LIDO"
            ELSE
                loc_cResultado = "JA_LIDO"
            ENDIF
        ELSE
            loc_cResultado = "NAO_CADASTRADO"
        ENDIF

        RETURN loc_cResultado
    ENDFUNC

    *==========================================================================
    * ConferenciaAutomatica - equivalente ao Click do botao "Conf. Auto"
    * (Conferencia): marca TODAS as etiquetas em aberto como conferidas.
    *==========================================================================
    PROCEDURE ConferenciaAutomatica()
        IF !USED(THIS.this_cCursorBaixa)
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorBaixa)
        SET ORDER TO TAG CodBarra
        REPLACE ALL QtdeLido WITH Qtde IN (THIS.this_cCursorBaixa)

        RETURN .T.
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - mapeia a linha CORRENTE de THIS.this_cCursorBaixa
    * (equivalente a TmpBaixa) para as properties this_*Atual, usadas pelo
    * Form para exibir/realcar a linha em foco na grade.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cCodigoBarraAtual    = TRANSFORM(TratarNulo(CodBarra, 0))
            THIS.this_cProdutoAtual        = TratarNulo(CPros, "")
            THIS.this_cOperacaoAtual       = TratarNulo(Dopes, "")
            THIS.this_nNumeroAtual         = TratarNulo(Numes, 0)
            THIS.this_nQuantidadeAtual     = TratarNulo(Qtde, 0)
            THIS.this_nQuantidadeLidaAtual = TratarNulo(QtdeLido, 0)
            THIS.this_nSequenciaAtual      = TratarNulo(Nops, 0)
            THIS.this_cGrupoContaAtual     = TratarNulo(Grupods, "")
            THIS.this_cContaContaAtual     = TratarNulo(Contads, "")

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - chave do documento de confirmacao gerado por
    * ConfirmarConferencia() (SigMvCab.cidchaves). So fica preenchida DEPOIS
    * de uma confirmacao com sucesso - eh o que RegistrarAuditoria() usa.
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaveGerada
    ENDPROC

    *==========================================================================
    * Inserir()/Atualizar()/ExecutarExclusao() - este dialogo NAO grava um
    * registro por vez: a "gravacao" real (equivalente ao Click do Ok
    * legado) e uma confirmacao em LOTE que cria 1 cabecalho SigMvCab por
    * combinacao Grupods/Contads presente no cursor de etiquetas conferidas,
    * mais os detalhes SigMvItn/SigMvHst e o reposicionamento das etiquetas
    * em SigOpEtq - por isso vive em ConfirmarConferencia(), que chama
    * THIS.RegistrarAuditoria() ao final com sucesso. O comportamento padrao
    * herdado de BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao
    * isolados) ja eh o correto para este dialogo.
    *==========================================================================

    *==========================================================================
    * ConfirmarConferencia - equivalente ao Click do Ok. Para cada
    * combinacao Grupods/Contads com QtdeLido <> 0 no cursor de baixa, gera
    * 1 cabecalho SigMvCab (documento TransfEncs), e para cada etiqueta
    * conferida daquele grupo/conta grava o detalhe SigMvItn e os 2
    * historicos SigMvHst (S = saida da conta de confirmacao, E = entrada
    * na conta de destino), recalculando custo/posicao (fRecalculaP/
    * fRecalculaC) e movendo a etiqueta em SigOpEtq para o grupo/conta de
    * destino. Tudo dentro de uma unica transacao manual (Transactions=2
    * neste ambiente): falha em qualquer passo faz SQLROLLBACK, sucesso
    * completo faz SQLCOMMIT + RegistrarAuditoria.
    *==========================================================================
    FUNCTION ConfirmarConferencia()
        LOCAL loc_lSucesso, loc_oErro, loc_lFalhou, loc_lProsseguir
        LOCAL loc_cDope, loc_nNume, loc_cChaveCab, loc_cGrupoCab, loc_cContaCab
        LOCAL loc_nItem, loc_cSQL, loc_dAgora, loc_cCidC, loc_nSeq, loc_cCidCE, loc_nSeqE
        LOCAL loc_cCunis, loc_cDpros, loc_cCodCors, loc_cCodTams, loc_cEmpos
        LOCAL loc_nCodBarraLin, loc_cCProsLin, loc_nQtdeLidaLin

        loc_lSucesso    = .F.
        loc_lFalhou     = .F.
        loc_lProsseguir = .T.

        IF !USED(THIS.this_cCursorBaixa) OR RECCOUNT(THIS.this_cCursorBaixa) = 0
            THIS.this_cMensagemErro = "N" + CHR(227) + "o h" + CHR(225) + " etiquetas carregadas para confirmar."
            RETURN .F.
        ENDIF

        TRY
            loc_dAgora = DATETIME()
            loc_cDope  = THIS.this_cDopeTransferencia

            IF USED("cursor_4c_ConfCabec")
                USE IN cursor_4c_ConfCabec
            ENDIF
            SELECT DISTINCT Grupods, Contads ;
                FROM (THIS.this_cCursorBaixa) ;
                WHERE QtdeLido != 0 ;
                INTO CURSOR cursor_4c_ConfCabec READWRITE

            IF RECCOUNT("cursor_4c_ConfCabec") = 0
                THIS.this_cMensagemErro = "Nenhuma etiqueta foi conferida - realize a leitura antes de confirmar."
                loc_lProsseguir = .F.
            ENDIF

            IF loc_lProsseguir
                SELECT cursor_4c_ConfCabec
                SCAN
                    loc_cGrupoCab = cursor_4c_ConfCabec.Grupods
                    loc_cContaCab = cursor_4c_ConfCabec.Contads

                    loc_nNume     = fGerUniqueKey(THIS.this_cEmpresa + loc_cDope)
                    loc_cChaveCab = THIS.MontarEmpDopNums(THIS.this_cEmpresa, loc_cDope, loc_nNume)

                    *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
                    *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
                    *-- com limite de 8192 caracteres ("Line is too long" em runtime).
                    *-- Colunas NOT NULL sem property nesta rotina (regra #22): char = EscaparSQL(""),
                    *-- numeric = FormatarNumeroSQL(0, <dec>), bit = "0".
                    loc_cSQL = "INSERT INTO SigMvCab ("
                    loc_cSQL = loc_cSQL + "Emps, Dopes, Numes, MascNum, Datas, Datars, Usuars, Grupoos,"
                    loc_cSQL = loc_cSQL + "Contaos, Grupods, Contads, EmpDopNums, cidchaves, DtAlts, EmpGopNums, npedclis,"
                    loc_cSQL = loc_cSQL + "acres, antecs, chksubn, codpeds, desc2s, descs, devols, empds,"
                    loc_cSQL = loc_cSQL + "grresps, grupos, grvends, iclis, ifors, locals, lotechqs, lprecos,"
                    loc_cSQL = loc_cSQL + "ncarnecs, nemps, nops, notas, nrcons, ntrans, numolds, opers,"
                    loc_cSQL = loc_cSQL + "resps, tabds, tpfats, transps, usuals, usulibs, valacres, valdes2s,"
                    loc_cSQL = loc_cSQL + "valdescs, valdevs, valencs, valinis, valos, valservs, valvars, vars,"
                    loc_cSQL = loc_cSQL + "vends, cotusus, espes, qtdes, lcancelas, cofs, livros, chkbxparcs,"
                    loc_cSQL = loc_cSQL + "ecfs, codobs, dgopes, trfisicos, utilizados, valndevs, valobxs, noforms,"
                    loc_cSQL = loc_cSQL + "auditors, contaes, localents, localizas, chkpagos, chkpgs, codtrans, empdnbxs,"
                    loc_cSQL = loc_cSQL + "empdncrds, obsagends, operadors, vcompensas, motdscs, ndeclaras, numbalds, numbals,"
                    loc_cSQL = loc_cSQL + "priors, procbals, procdbal, protats, usupagos, ultgrvs, moeits, rnops,"
                    loc_cSQL = loc_cSQL + "impress, pstatus, valvarps, cifccfs, cupfis, idconta, ncupoms, status,"
                    loc_cSQL = loc_cSQL + "valtrans, impcpfs, ccfgnfs, fpubls, jobs, ptax1s, ptax2s, ptax3s,"
                    loc_cSQL = loc_cSQL + "obscabmovs, codobs2"
                    loc_cSQL = loc_cSQL + ") VALUES ("
                    loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", " + FormatarNumeroSQL(loc_nNume, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuario) + ", " + EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", " + EscaparSQL(loc_cChaveCab) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL(fUniqueIds()) + ", " + FormatarDataSQL(loc_dAgora) + ", " + EscaparSQL(THIS.MontarEmpDopNums(THIS.this_cEmpresa, "", 0)) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 4) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 4) + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 4) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + "0" + ", " + "0" + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + "0" + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", " + "0" + ", "
                    loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + EscaparSQL("") + ", "
                    loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                    loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", " + EscaparSQL("")
                    loc_cSQL = loc_cSQL + ")"

                    IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvCab)" + CHR(13) + CapturarErroSQL()
                        loc_lFalhou = .T.
                        SELECT cursor_4c_ConfCabec
                        EXIT
                    ENDIF

                    THIS.this_cCidChaveGerada = loc_cChaveCab

                    loc_nItem = 0
                    SELECT (THIS.this_cCursorBaixa)
                    SCAN FOR Grupods + Contads == loc_cGrupoCab + loc_cContaCab AND QtdeLido != 0
                        loc_nItem        = loc_nItem + 1
                        loc_nCodBarraLin = CodBarra
                        loc_cCProsLin    = CPros
                        loc_nQtdeLidaLin = QtdeLido

                        loc_cCunis = ""
                        loc_cDpros = ""
                        IF THIS.ConsultarRegistro("SigCdPro", "cursor_4c_ProdutoConf", "CPros = " + EscaparSQL(loc_cCProsLin), "Cunis, Dpros")
                            loc_cCunis = TratarNulo(cursor_4c_ProdutoConf.Cunis, "")
                            loc_cDpros = TratarNulo(cursor_4c_ProdutoConf.Dpros, "")
                        ENDIF

                        loc_cCodCors = ""
                        loc_cCodTams = ""
                        loc_cEmpos   = ""
                        IF THIS.ConsultarRegistro("SigOpEtq", "cursor_4c_EtiquetaConf", ;
                                "CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0), "CodCors, CodTams, Empos")
                            loc_cCodCors = TratarNulo(cursor_4c_EtiquetaConf.CodCors, "")
                            loc_cCodTams = TratarNulo(cursor_4c_EtiquetaConf.CodTams, "")
                            loc_cEmpos   = TratarNulo(cursor_4c_EtiquetaConf.Empos, "")
                        ENDIF

                        loc_cSQL = "INSERT INTO SigMvItn ("
                        loc_cSQL = loc_cSQL + "CItens, Emps, Dopes, Numes, CPros, Qtds, Cunis, DPros,"
                        loc_cSQL = loc_cSQL + "Opers, CodBarras, EmpDopNums, cIdChaves, DtAlts, aqtds, descvals, etiesps,"
                        loc_cSQL = loc_cSQL + "fators, fatvals, fvals, iconfs, locals, moedas, moefats, moevals,"
                        loc_cSQL = loc_cSQL + "notas, nrcons, ntrans, numolds, pesos, qtbaixas, qtbxprods, qtprods,"
                        loc_cSQL = loc_cSQL + "totas, tpesos, unitembs, units, univals, vcoms, aliqs, sitribs,"
                        loc_cSQL = loc_cSQL + "tpipis, valipis, aliqicms, valdescs, empos, moevs, utilizas, ncodigos,"
                        loc_cSQL = loc_cSQL + "qtreservas, nlotes, baseicms, chksubn, unit2s, usulibs, valrats, codlprecs,"
                        loc_cSQL = loc_cSQL + "cunips, motdscs, tipos, unitinfs, cpro2s, abrevis, bcicmss, bcipis,"
                        loc_cSQL = loc_cSQL + "icms, icmss, pdescs, nchvtbds, idpro, unitorigs, origmercs, baseicm2s,"
                        loc_cSQL = loc_cSQL + "baseicm3s, baseipi2s, baseipi3s, cfops, ratdacs, ratfrts, raticmds, raticms,"
                        loc_cSQL = loc_cSQL + "ratsegs, sittricms, aliqiis, citem2, taxaiis, vcofins, vpis, aliqorigs,"
                        loc_cSQL = loc_cSQL + "lcancelas, compris, codfabs, nadis, niadis, aliqcofs, aliqpis, cssl,"
                        loc_cSQL = loc_cSQL + "inss, irrf, iss, valbases, localos"
                        loc_cSQL = loc_cSQL + ") VALUES ("
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nItem, 0) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cCunis) + ", " + EscaparSQL(loc_cDpros) + ", " + EscaparSQL("S") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cChaveCab) + ", " + EscaparSQL(fUniqueIds()) + ", "
                        loc_cSQL = loc_cSQL + FormatarDataSQL(loc_dAgora) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + "0" + ", " + "0" + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 4) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + "0" + ", " + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + "0" + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 2) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + EscaparSQL("")
                        loc_cSQL = loc_cSQL + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvItn)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        loc_nSeq  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidC = DTOS(DATE()) + "S" + TRANSFORM(loc_nSeq, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst ("
                        loc_cSQL = loc_cSQL + "Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros,"
                        loc_cSQL = loc_cSQL + "Qtds, Opers, Grupos, Estos, CodBarras, CodCors, CodTams, cIdChaves,"
                        loc_cSQL = loc_cSQL + "EmpDopNums, EmpGruEsts, OriDopNums, Seqs, sqtds, teqtds, totas, tsqtds,"
                        loc_cSQL = loc_cSQL + "units, moedas, numolds, ntrans, locals, unitmeds, moedmeds, recalmeds,"
                        loc_cSQL = loc_cSQL + "auditors, pesos, spesos, unitmfis, bcipis, medipis"
                        loc_cSQL = loc_cSQL + ") VALUES ("
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("S") + ", " + EscaparSQL(THIS.this_cGrupoConfirmacao) + ", " + EscaparSQL(THIS.this_cContaConfirmacao) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + EscaparSQL(loc_cCodTams) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidC) + ", " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao)) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeq, 0) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 6)
                        loc_cSQL = loc_cSQL + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - S)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, THIS.this_cGrupoConfirmacao, THIS.this_cContaConfirmacao, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_nSeqE  = fGerUniqueKey(DTOS(DATE()))
                        loc_cCidCE = DTOS(DATE()) + "E" + TRANSFORM(loc_nSeqE, "@L 999999") + THIS.this_cSigKey

                        loc_cSQL = "INSERT INTO SigMvHst ("
                        loc_cSQL = loc_cSQL + "Usuars, Datas, Datars, Emps, Empos, Dopes, Numes, Cpros,"
                        loc_cSQL = loc_cSQL + "Qtds, Opers, Grupos, Estos, CodBarras, CodCors, CodTams, CidChaves,"
                        loc_cSQL = loc_cSQL + "EmpDopNums, EmpGruEsts, OriDopNums, Seqs, sqtds, teqtds, totas, tsqtds,"
                        loc_cSQL = loc_cSQL + "units, moedas, numolds, ntrans, locals, unitmeds, moedmeds, recalmeds,"
                        loc_cSQL = loc_cSQL + "auditors, pesos, spesos, unitmfis, bcipis, medipis"
                        loc_cSQL = loc_cSQL + ") VALUES ("
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cUsuario) + ", " + FormatarDataSQL(loc_dAgora) + ", " + FormatarDataSQL(loc_dAgora) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cEmpos) + ", " + EscaparSQL(THIS.this_cEmpresa) + ", " + EscaparSQL(loc_cDope) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nNume, 0) + ", " + EscaparSQL(loc_cCProsLin) + ", " + FormatarNumeroSQL(loc_nQtdeLidaLin, 3) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("E") + ", " + EscaparSQL(loc_cGrupoCab) + ", " + EscaparSQL(loc_cContaCab) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(loc_nCodBarraLin, 0) + ", " + EscaparSQL(loc_cCodCors) + ", " + EscaparSQL(loc_cCodTams) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(loc_cCidCE) + ", " + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + EscaparSQL(THIS.MontarEmpGruEsts(loc_cEmpos, loc_cGrupoCab, loc_cContaCab)) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL(THIS.MontarEmpDopNums(loc_cEmpos, loc_cDope, loc_nNume)) + ", " + FormatarNumeroSQL(loc_nSeqE, 0) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 3) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 6) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 0) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 0) + ", " + EscaparSQL("") + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + EscaparSQL("") + ", " + "0" + ", " + EscaparSQL("") + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 3) + ", " + FormatarNumeroSQL(0, 6) + ", "
                        loc_cSQL = loc_cSQL + FormatarNumeroSQL(0, 2) + ", " + FormatarNumeroSQL(0, 6)
                        loc_cSQL = loc_cSQL + ")"

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigMvHst - E)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        fRecalculaP(loc_cEmpos, loc_cGrupoCab, loc_cContaCab, ;
                            loc_cCProsLin, loc_dAgora, loc_cCodCors, loc_cCodTams, gnConnHandle)
                        fRecalculaC(loc_cEmpos, loc_cCProsLin, loc_dAgora, gnConnHandle)

                        loc_cSQL = "UPDATE SigOpEtq SET Grupos = " + EscaparSQL(loc_cGrupoCab) + ", " + ;
                            "Contas = " + EscaparSQL(loc_cContaCab) + ", DtMovs = " + FormatarDataSQL(loc_dAgora) + " " + ;
                            "WHERE CBars = " + FormatarNumeroSQL(loc_nCodBarraLin, 0)

                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (SigOpEtq)" + CHR(13) + CapturarErroSQL()
                            loc_lFalhou = .T.
                            SELECT (THIS.this_cCursorBaixa)
                            EXIT
                        ENDIF

                        SELECT (THIS.this_cCursorBaixa)
                    ENDSCAN

                    SELECT cursor_4c_ConfCabec

                    IF loc_lFalhou
                        EXIT
                    ENDIF
                ENDSCAN
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaP(.T., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClP)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF

            IF loc_lProsseguir AND !loc_lFalhou
                IF !fRecalculaC(.T., .T., .F., gnConnHandle, .T.)
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Consolida" + CHR(231) + CHR(227) + "o SigOpClC)"
                    loc_lFalhou = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            loc_lFalhou = .T.
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro ao confirmar confer" + CHR(234) + "ncia")
        ENDTRY

        IF !loc_lProsseguir OR loc_lFalhou
            SQLROLLBACK(gnConnHandle)
            loc_lSucesso = .F.
        ELSE
            SQLCOMMIT(gnConnHandle)
            THIS.RegistrarAuditoria("CONFIRMAR")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
