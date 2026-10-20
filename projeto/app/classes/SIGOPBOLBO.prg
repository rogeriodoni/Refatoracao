*==============================================================================
* SIGOPBOLBO.prg
*
* Business Object para SIGOPBOL (Selecao de Impressora de Boleto)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe parametros do form chamador (tipo de boleto, empresa, operacao,
* numero da movimentacao, etc.), permite ao usuario escolher a impressora de
* boletos configurada na estacao e repassa tudo para a rotina legada de
* impressao (Do SigBlBol With ...).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Fase 2/8: Inserir(), Atualizar() e ExecutarExclusao() permanecem SEM
* override - o comportamento padrao herdado de BusinessBase (recusar a
* operacao com mensagem clara) ja eh o correto para este BO, porque nao ha
* NENHUMA tabela proprietaria para gravar (regra CLAUDE.md "BO
* somente-leitura"). CarregarDoCursor()/ObterChavePrimaria() tambem nao se
* aplicam - o dialogo nao exibe/edita um registro de tabela, ele recebe
* parametros do form chamador e exibe uma lista de impressoras.
*
* Nesta fase sao adicionados os metodos que reproduzem a logica REAL do
* Init/Cmd_Imprimir.Click do legado (tasks\task648\SIGOPBOL_form_codigo_fonte.txt):
*   - DefinirTipoBoleto()              : guarda de tipo (Iif(Type()='N',...))
*   - ObterTituloPorTipoBoleto()       : Do Case do titulo da janela
*   - CarregarImpressorasConfiguradas(): consulta SigSyImp/SigCdAcG/SigCdmp
*   - ObterImpressorasDisponiveis()    : cruza APRINTERS() com SigCdmp
*   - ExecutarImpressao()              : Do SigBlBol With ... (rotina legada)
*
* SigBlBol e uma PROCEDURE global do Fortyus (sig.prg/SIGFUNCS.PRG) que NAO
* veio no acervo (sem .prg fonte, sem FRX - ver regra CLAUDE.md #27 "Funcao
* GLOBAL do legado"). Nao ha como reproduzir a impressao real (layout de
* boleto bancario) sem esse fonte. Por isso ExecutarImpressao() TRANSCREVE o
* "Do SigBlBol With ..." exatamente como o legado chama (mesma ordem de
* parametros), dentro de TRY/CATCH que exibe a falha com MsgErro (regra #9,
* CATCH nunca silencioso) - a ausencia fica VISIVEL em vez de virar um stub
* que finge imprimir.
*==============================================================================

DEFINE CLASS SIGOPBOLBO AS BusinessBase

    *-- Propriedades da entidade (parametros recebidos do form chamador,
    *-- espelhando as properties customizadas do form legado SIGOPBOL)
    this_nTpBol = 0              && vnTpBol - Tipo de Boleto
    this_cTitEnvelope = ""       && vcTitEnvelope - Titulo do Envelope
    this_cEmp = ""               && vcEmp - Codigo da Empresa
    this_cDope = ""              && vcDope - Nome da Operacao de Estoque/Producao
    this_nNum = 0                && vnNum - Numero da Movimentacao de Estoque/Producao
    this_nDev = 0                && vnDev - Valor de Devolucao
    this_nVias = 0               && vnVias - Numero da Via
    this_nQBols = 0              && vnQBols - Quantidade de Boletos
    this_nQtdImp = 0             && vnQtdImp - Quantidade de Impressoras de Boleto Configuradas
    this_cCursor = ""            && vnCursor - Nome do Cursor/Tabela a Imprimir
    this_cImpressoraSelecionada = "" && Nome da impressora escolhida pelo usuario (laPrinters)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        *-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
        *-- Dialogo parametrizado: nao ha tabela nem campo chave proprios
        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.this_nTpBol = 0
        THIS.this_cTitEnvelope = ""
        THIS.this_cEmp = ""
        THIS.this_cDope = ""
        THIS.this_nNum = 0
        THIS.this_nDev = 0
        THIS.this_nVias = 0
        THIS.this_nQBols = 0
        THIS.this_nQtdImp = 0
        THIS.this_cCursor = ""
        THIS.this_cImpressoraSelecionada = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * DefinirTipoBoleto - Guarda de tipo do parametro recebido do form
    * chamador, igual ao legado: Iif(Type('pnTpBol') = 'N', pnTpBol, 0)
    *====================================================================
    PROCEDURE DefinirTipoBoleto(par_nTpBol)
        THIS.this_nTpBol = IIF(VARTYPE(par_nTpBol) = "N", par_nTpBol, 0)
    ENDPROC

    *====================================================================
    * ObterTituloPorTipoBoleto - Reproduz o Do Case do Init legado que
    * define o Caption da janela conforme o tipo de boleto
    *====================================================================
    FUNCTION ObterTituloPorTipoBoleto(par_nTpBol)
        LOCAL loc_cTitulo

        DO CASE
            CASE par_nTpBol = 1
                loc_cTitulo = "Impress" + CHR(227) + "o de Protocolo de Cheque"

            CASE INLIST(par_nTpBol, 2, 3, 4, 5, 7, 9)
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto"

            CASE par_nTpBol = 6
                loc_cTitulo = "Impress" + CHR(227) + "o de Protocolo de Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"

            CASE par_nTpBol = 8
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Conserto"

            CASE par_nTpBol = 12
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Ordem de Servi" + CHR(231) + CHR(227) + "o"

            OTHERWISE
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto (*)"
        ENDCASE

        RETURN loc_cTitulo
    ENDFUNC

    *====================================================================
    * CarregarImpressorasConfiguradas - Reproduz a consulta do Init legado
    * que traz as impressoras de boleto liberadas para o usuario, via
    * acesso direto (SigSyImp) ou via grupo de acesso (SigCdAcG), e monta
    * a lista DISTINCT por impressora (crSigCdmp no legado).
    *====================================================================
    FUNCTION CarregarImpressorasConfiguradas(par_cUsuario)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        IF USED("cursor_4c_SigOpBol_Acesso")
            USE IN cursor_4c_SigOpBol_Acesso
        ENDIF
        IF USED("cursor_4c_SigCdmp")
            USE IN cursor_4c_SigCdmp
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b " + ;
                "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " AND a.cImps = b.impres " + ;
                "UNION ALL " + ;
                "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario) + " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpBol_Acesso")

            IF loc_nResultado >= 0
                SET NULL ON
                IF RECCOUNT("cursor_4c_SigOpBol_Acesso") > 0
                    SELECT DISTINCT Impres, nTpImpres, TpBarra, MaxCols ;
                        FROM cursor_4c_SigOpBol_Acesso ;
                        ORDER BY Impres ;
                        INTO CURSOR cursor_4c_SigCdmp READWRITE
                ELSE
                    CREATE CURSOR cursor_4c_SigCdmp (Impres C(30), nTpImpres N(2,0), TpBarra N(2,0), MaxCols N(3,0))
                ENDIF
                SET NULL OFF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao consultar impressoras configuradas" + CHR(13) + CapturarErroSQL()
                loc_lResultado = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_SigOpBol_Acesso")
            USE IN cursor_4c_SigOpBol_Acesso
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * ObterImpressorasDisponiveis - Cruza as impressoras instaladas na
    * estacao (APRINTERS) com as impressoras de boleto configuradas em
    * cursor_4c_SigCdmp (CarregarImpressorasConfiguradas), aplicando o
    * mesmo filtro do legado: tipo texto (vazio ou 1), sem barra e largura
    * minima de 40 colunas. Preenche this_nQtdImp e o cursor
    * cursor_4c_SigOpBol_Opcoes (Ordem/NomeExibicao/NomeReal), que o Form
    * usa para montar os botoes do Opt_Impressora. Retorna a quantidade
    * de impressoras configuradas que tambem estao instaladas na estacao.
    *====================================================================
    FUNCTION ObterImpressorasDisponiveis()
        LOCAL loc_aPrinters[1], loc_nPrinters, loc_nI, loc_nCImp, loc_nImpres
        loc_nPrinters = APRINTERS(loc_aPrinters)
        loc_nCImp = 0
        loc_nImpres = 0

        IF USED("cursor_4c_SigOpBol_Opcoes")
            USE IN cursor_4c_SigOpBol_Opcoes
        ENDIF
        SET NULL ON
        CREATE CURSOR cursor_4c_SigOpBol_Opcoes (Ordem N(3,0), NomeExibicao C(60), NomeReal C(254))
        SET NULL OFF

        IF USED("cursor_4c_SigCdmp")
            SELECT cursor_4c_SigCdmp
            SCAN FOR (EMPTY(cursor_4c_SigCdmp.nTpImpres) OR cursor_4c_SigCdmp.nTpImpres = 1) ;
                AND cursor_4c_SigCdmp.TpBarra = 0 ;
                AND cursor_4c_SigCdmp.MaxCols > 39

                loc_nCImp = loc_nCImp + 1

                IF loc_nPrinters > 0
                    FOR loc_nI = 1 TO loc_nPrinters
                        IF UPPER(ALLTRIM(loc_aPrinters[loc_nI, 1])) == UPPER(ALLTRIM(cursor_4c_SigCdmp.Impres))
                            loc_nImpres = loc_nImpres + 1
                            INSERT INTO cursor_4c_SigOpBol_Opcoes VALUES ;
                                (loc_nImpres, ALLTRIM(cursor_4c_SigCdmp.Impres), loc_aPrinters[loc_nI, 1])
                            EXIT
                        ENDIF
                    ENDFOR
                ENDIF
            ENDSCAN
        ENDIF

        THIS.this_nQtdImp = loc_nCImp

        RETURN loc_nImpres
    ENDFUNC

    *====================================================================
    * ExecutarImpressao - Reproduz o Cmd_Imprimir.Click do legado: repassa
    * os parametros do dialogo para a rotina global SigBlBol, que efetua a
    * impressao fisica do boleto. SigBlBol.prg nao esta no acervo (ver
    * comentario de cabecalho) - o erro de arquivo ausente, se ocorrer, e
    * capturado e exibido explicitamente, nunca escondido.
    *====================================================================
    FUNCTION ExecutarImpressao()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DO SigBlBol WITH THIS.this_nTpBol, THIS.this_cTitEnvelope, THIS.this_cEmp, ;
                THIS.this_cDope, THIS.this_nNum, THIS.this_nDev, THIS.this_nVias, ;
                THIS.this_nQBols, THIS.this_cImpressoraSelecionada, THIS.this_cCursor

            loc_lResultado = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao executar a impress" + CHR(227) + "o do boleto (SigBlBol):" + CHR(13) + ;
                loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE
