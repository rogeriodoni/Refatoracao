*==============================================================================
* SIGOPCFLBO.PRG
* Business Object para Consulta de FollowUp de Cheques (SigOpCfl)
* Tabela principal: SigCheh (historico de followup do cheque)
* Tabelas auxiliares (somente leitura, cabecalho do form): SigChe, SigCdCli
*==============================================================================

DEFINE CLASS SigOpCflBO AS BusinessBase

    *-- Propriedades da entidade SigCheh (historico de followup)
    this_cCidChaves = ""            && SigCheh.cidchaves - chave primaria (char 20)
    this_cNums = ""                 && SigCheh.nums / SigChe.nums - numero do titulo (parametro "conta" do legado)
    this_dDatas = {}                && SigCheh.datas - data/hora do lancamento de followup
    this_cEmps = ""                 && SigCheh.emps - empresa
    this_cHists = ""                && SigCheh.hists - observacao do followup
    this_nNumlotes = 0              && SigCheh.numlotes
    this_lAutos = .F.               && SigCheh.autos - .T. quando o historico foi gerado automaticamente

    *-- Propriedades auxiliares de cabecalho (somente leitura - SigChe/SigCdCli)
    this_cIclis = ""                && SigCdCli.iclis - codigo do cliente/emissor do cheque
    this_cRclis = ""                && SigCdCli.rclis - razao/nome do cliente
    this_cBancos = ""                && SigChe.bancos - codigo do banco
    this_cAgencias = ""             && SigChe.agencias - agencia
    this_cNContas = ""              && SigChe.ncontas - conta bancaria
    this_cNCheques = ""             && SigChe.ncheques - numero do cheque

    *==========================================================================
    * Init - Inicializa Business Object
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCheh"
        THIS.this_cCampoChave = "cidchaves"

        RETURN .T.
    ENDPROC

    *==========================================================================
    * LimparDados - Reseta as propriedades da entidade (NovoRegistro/CancelarEdicao)
    *==========================================================================
    PROCEDURE LimparDados()
        DODEFAULT()

        THIS.this_cCidChaves = ""
        THIS.this_cNums      = ""
        THIS.this_dDatas     = {}
        THIS.this_cEmps      = ""
        THIS.this_cHists     = ""
        THIS.this_nNumlotes  = 0
        THIS.this_lAutos     = .F.
    ENDPROC

    *==========================================================================
    * InicializarValoresPadrao - Defaults do ramo pcEscolha = 'INSERIR' do
    * legado (cmdApagaitem.Click): GetData.Value = DateTime(), Hists em branco.
    * Autos sempre .F. - followup manual nunca nasce como automatico.
    *==========================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_dDatas    = DATETIME()
        THIS.this_lAutos    = .F.
        THIS.this_nNumlotes = 0
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave primaria (cidchaves) para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor de
    * SigCheh (crSigCheh/cursor_4c_Dados)
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    * PUBLIC de proposito (regra #51): o form chama este metodo de FORA, em
    * BtnExcluirClick (loc_oBO.CarregarDoCursor("cursor_4c_Dados")). Como
    * BusinessBase.CarregarDoCursor eh PUBLIC, declarar PROTECTED aqui faria
    * a chamada estourar em RUNTIME com "Property CARREGARDOCURSOR is not
    * found." ao clicar Excluir - compila limpo. NAO reintroduzir PROTECTED.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves = TratarNulo(cidchaves, "")
                THIS.this_cNums      = TratarNulo(nums,      "")
                THIS.this_dDatas     = TratarNulo(datas,     {})
                THIS.this_cEmps      = TratarNulo(emps,      "")
                THIS.this_cHists     = TratarNulo(hists,     "")
                THIS.this_nNumlotes  = TratarNulo(numlotes,  0)
                THIS.this_lAutos     = TratarNulo(autos,     .F.)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "SigOpCflBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Regra de gravacao do legado, em FONTE UNICA.
    * O legado so grava quando a observacao esta preenchida:
    *     If !Empty(This.Value)   (GetHist.LostFocus)
    * e o followup pertence SEMPRE a um cheque (SigCheh.nums -> SigChe.nums,
    * char(8) NOT NULL): sem o numero do cheque o registro nasceria orfao.
    * Chamado por BusinessBase.Salvar(), que exibe a falha sozinho via
    * ExibirFalha() quando este metodo devolve .F. - por isso aqui so se
    * preenche this_cMensagemErro, sem MsgAviso proprio (regra #20).
    * PUBLIC (sem modificador): BusinessBase.ValidarDados tambem eh PUBLIC e
    * em VFP9 PROTECTED em QUALQUER nivel da heranca ja bloqueia a chamada
    * externa (regra #51).
    *==========================================================================
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .F.

        THIS.this_cMensagemErro = ""

        DO CASE
        CASE EMPTY(ALLTRIM(THIS.this_cNums))
            THIS.this_cMensagemErro = "Cheque n" + CHR(227) + "o informado - " + ;
                "n" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel gravar " + ;
                "followup sem o t" + CHR(237) + "tulo de origem."
        CASE EMPTY(ALLTRIM(THIS.this_cHists))
            THIS.this_cMensagemErro = "Observa" + CHR(231) + CHR(227) + "o " + ;
                "necessita ser preenchida."
        OTHERWISE
            loc_lValido = .T.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * CarregarHistorico - Consulta o historico de followup do cheque e devolve
    * as linhas em par_cCursorDestino (cursor TEMPORARIO do chamador, que
    * depois faz ZAP + APPEND FROM DBF() no alias ligado ao Grid - SQLEXEC
    * sobre o alias do Grid zera o ColumnCount).
    * Legado (SIGOPCFL.Init):
    *     lcQueryCheh = [Select * From SigCheh Where Nums = ?lcNum ]
    *     .AddCursor('SigCheh','CidChaves','CrSigCheh','','',lcQueryCheh)
    *     =ThisForm.Podatamgr.Requery('CrSigCheh')
    * O filtro eh aplicado SEMPRE, inclusive com Nums vazio - a consulta nao
    * casa nada e a grade abre vazia, de proposito (regra #35a).
    * A lista de colunas (nome E ordem) eh IDENTICA a de CarregarDoCursor e a
    * do CREATE CURSOR do form - APPEND FROM casa por NOME.
    * Devolve .T. quando a consulta rodou (inclusive com ZERO linhas: lista
    * vazia nao eh erro) e .F. quando o SQL Server recusou.
    * PUBLIC: o form chama de FORA, em CarregarLista (regra #51).
    *==========================================================================
    PROCEDURE CarregarHistorico(par_cNums, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Fecha o destino antes do SQLEXEC. O TABLEREVERT vai guardado
            *-- pelo Buffering: cursor com Buffering = 1 (o default de
            *-- CREATE CURSOR e de cursor de SQLEXEC) faz TABLEREVERT estourar
            *-- erro 1586 "Function requires row or table buffering mode", e
            *-- USE IN fecha o alias de qualquer jeito (regra #52).
            IF USED(par_cCursorDestino)
                IF CURSORGETPROP("Buffering", par_cCursorDestino) > 1
                    TABLEREVERT(.T., par_cCursorDestino)
                ENDIF
                USE IN (par_cCursorDestino)
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
SELECT cidchaves, nums, datas, emps, hists, numlotes, autos
  FROM SigCheh
 WHERE nums = <<EscaparSQL(LEFT(par_cNums, 8))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar o hist" + CHR(243) + ;
                    "rico do cheque:" + CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "SigOpCflBO.CarregarHistorico")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar hist" + CHR(243) + "rico:" + CHR(13) + ;
                loException.Message, "SigOpCflBO.CarregarHistorico")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarCabecalho - Carrega os dados FIXOS do cheque consultado nas
    * propriedades auxiliares (somente leitura) deste BO.
    * Legado (SIGOPCFL.Init):
    *     =ThisForm.Podatamgr.Cursorquery('SigChe','CrTmpChe','Nums',lcNum)
    *     =ThisForm.Podatamgr.Cursorquery('SigCdCli','CrTmpCli','Iclis',CrTmpChe.Iclis)
    * O cliente so eh consultado quando o cheque traz Iclis preenchido - eh o
    * encadeamento do legado, nao uma otimizacao.
    * PUBLIC: o form chama de FORA, em CarregarCabecalhoCheque (regra #51).
    *==========================================================================
    PROCEDURE CarregarCabecalho(par_cNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cIclis    = ""
            THIS.this_cRclis    = ""
            THIS.this_cBancos   = ""
            THIS.this_cAgencias = ""
            THIS.this_cNContas  = ""
            THIS.this_cNCheques = ""

            IF USED("cursor_4c_CflChe")
                USE IN cursor_4c_CflChe
            ENDIF
            IF USED("cursor_4c_CflCli")
                USE IN cursor_4c_CflCli
            ENDIF

            loc_cSQL = "SELECT iclis, bancos, agencias, ncontas, ncheques" + ;
                " FROM SigChe WHERE nums = " + EscaparSQL(LEFT(par_cNums, 8))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CflChe")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar os dados do cheque:" + ;
                    CHR(13) + CapturarErroSQL()
                MostrarErro(THIS.this_cMensagemErro, "SigOpCflBO.CarregarCabecalho")
            ELSE
                *-- IFs ANINHADOS de proposito: VFP9 nao faz short-circuit,
                *-- entao 'USED(x) AND RECCOUNT(x) > 0' avaliaria o RECCOUNT
                *-- mesmo com o alias fechado e estouraria "Alias is not found".
                IF USED("cursor_4c_CflChe")
                    IF RECCOUNT("cursor_4c_CflChe") > 0
                        SELECT cursor_4c_CflChe
                        GO TOP

                        THIS.this_cIclis    = TratarNulo(iclis,    "")
                        THIS.this_cBancos   = TratarNulo(bancos,   "")
                        THIS.this_cAgencias = TratarNulo(agencias, "")
                        THIS.this_cNContas  = TratarNulo(ncontas,  "")
                        THIS.this_cNCheques = TratarNulo(ncheques, "")

                        loc_lSucesso = .T.

                        IF !EMPTY(ALLTRIM(THIS.this_cIclis))
                            loc_cSQL = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + ;
                                EscaparSQL(THIS.this_cIclis)

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CflCli")

                            IF loc_nResultado >= 0 AND USED("cursor_4c_CflCli")
                                IF RECCOUNT("cursor_4c_CflCli") > 0
                                    SELECT cursor_4c_CflCli
                                    GO TOP
                                    THIS.this_cRclis = TratarNulo(rclis, "")
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

            IF USED("cursor_4c_CflChe")
                USE IN cursor_4c_CflChe
            ENDIF
            IF USED("cursor_4c_CflCli")
                USE IN cursor_4c_CflCli
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar cabe" + CHR(231) + "alho do cheque:" + ;
                CHR(13) + loException.Message, "SigOpCflBO.CarregarCabecalho")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Inclui novo registro de followup em SigCheh
    * Espelha o ramo pcEscolha = 'INSERIR' do GetHist.LostFocus legado: gera a
    * chave com fUniqueIds() e grava Nums/Datas/Emps/CidChaves/Hists. Autos
    * sempre 0 (bit) - followup manual nunca nasce automatico.
    *==========================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCheh (cidchaves, nums, datas, emps, hists, autos, numlotes)
                VALUES (
                    <<EscaparSQL(THIS.this_cCidChaves)>>,
                    <<EscaparSQL(LEFT(THIS.this_cNums, 8))>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<EscaparSQL(LEFT(THIS.this_cEmps, 3))>>,
                    <<EscaparSQL(LEFT(THIS.this_cHists, 76))>>,
                    0,
                    <<FormatarNumeroSQL(THIS.this_nNumlotes, 0)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao incluir followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigOpCflBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * Atualizar - Atualiza registro de followup existente em SigCheh
    * Espelha o ramo pcEscolha = 'ALTERAR' do legado: so o historico (Hists)
    * eh regravado; Nums/Datas/Emps/Autos do registro original sao preservados.
    *==========================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCheh
                SET hists = <<EscaparSQL(LEFT(THIS.this_cHists, 76))>>
                WHERE cidchaves = <<EscaparSQL(THIS.this_cCidChaves)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigOpCflBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de followup de SigCheh
    * Guarda do legado (cmdApagaitem.Click): so permite excluir quando o
    * historico NAO foi gerado automaticamente (Autos = .F.) OU quando
    * Hists/Datas estao vazios. Historico automatico com Hists/Datas
    * preenchidos NAO pode ser excluido ("Historico automatico!!!").
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.this_lAutos AND !EMPTY(THIS.this_cHists) AND !EMPTY(THIS.this_dDatas)
                MsgAviso("Hist" + CHR(243) + "rico autom" + CHR(225) + "tico !!!", ;
                    "Imposs" + CHR(237) + "vel")
            ELSE
                loc_cSQL = "DELETE FROM SigCheh WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir followup:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigOpCflBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE
