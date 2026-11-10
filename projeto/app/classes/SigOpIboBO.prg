*==============================================================================
* SIGOPIBOBO.prg
*
* Business Object para SIGOPIBO (Impressao de Boleto / Protocolo / Duplicata-Carne)
*
* Este form NAO persiste dados em tabela propria - e um dialogo OPERACIONAL
* que recebe parametros do form chamador (tipo de boleto, empresa, operacao,
* numero da movimentacao, etc.), permite ao usuario escolher a impressora de
* boletos configurada na estacao e repassa tudo para a rotina legada de
* impressao (Do SigBlBol With ...).
*
* Tabela: (nenhuma - dialogo parametrizado, sem persistencia propria)
*
* Irmao direto de SigOpBolBO.prg (SIGOPBOL - "Selecao de Impressora de
* Boleto"), mesma familia de dialogo de impressao. Diferencas do legado
* (tasks\task746\SigOpIbo_form_codigo_fonte.txt) que as proximas fases
* precisam reproduzir:
*   - Tres checkboxes de OPCAO do proprio dialogo (chkCarne/chkObss/
*     chkAgrupa), que NAO sao parametro do chamador - sao o estado inicial
*     da tela (.T./.T./.F. no SCX) e a visibilidade de cada um depende do
*     tipo de boleto (vnTpBol). O legado SOBRESCREVE chkObss.Visible e
*     chkCarne.Visible duas vezes seguidas (TpBol=17 e depois TpBol=18)
*     sem IF entre as duas - so a ULTIMA atribuicao tem efeito observavel;
*     isso vale reproduzir tal como se comporta, nao como foi escrito.
*   - O Do Case do titulo tem DUAS opcoes que o irmao SigOpBolBO nao tem
*     (TpBol=16 "Impressao de Boleto de Vendas" e TpBol=18 "Impressao de
*     Duplicata/Carne").
*   - A escolha de impressora eh por COMBOBOX (Get_Printer, RowSource =
*     crImpreV, montado por UNION ALL de SigSyImp/SigCdAcG/SigCdmp cruzado
*     com APRINTERS) - o Opt_Impressora do SCX esta Visible = .F. e o bloco
*     que o preenchia esta todo comentado (*!*) no legado; nao reativar.
*   - Cmd_Imprimir.Click repassa DOIS parametros extras ao SigBlBol que o
*     SigOpBolBO nao tem: llObs (chkObss ou chkCarne, conforme TpBol=18) e
*     llAgrupa (chkAgrupa.Value).
*   - Ha um fallback de exibicao (Container1/Edit1) que mostra o conteudo de
*     BOLETO.txt quando o arquivo existe apos a chamada ao SigBlBol - efeito
*     colateral de UI, nao dado de negocio; fica para a fase do Form.
*
* poForm (referencia ao form chamador) e a checagem llSair (fChecaAcesso
*('SIGCHE','PROTSEMPRE') AND poForm.Op_Escolha = 'INSERIR', usada so no caso
* TpBol=1 para decidir se o botao Encerrar nasce habilitado) NAO entram neste
* BO - mesma decisao arquitetural de SigOpCtdBO.prg ("ONDE FICA O poForm"):
* guardar referencia ao form pai aqui fecharia um ciclo de referencias e essa
* checagem eh de UI (Enabled do botao), nao de dado. Fica no Form (fase 3+).
*
* Fase 1/8: APENAS propriedades e Init() basico, no mesmo padrao de
* SigOpBolBO.prg - Init() sem parametros, zera tudo, this_cTabela e
* this_cCampoChave vazios (nao ha tabela/chave propria). As proximas fases
* adicionam os metodos que reproduzem a logica REAL do Init/Cmd_Imprimir.Click
* do legado:
*   - DefinirTipoBoleto()               : guarda de tipo, igual ao irmao
*   - ObterTituloPorTipoBoleto()        : Do Case do titulo (com 16 e 18)
*   - DeveExibirImprimirCarne()/DeveExibirImprimirObservacoes()/
*     DeveExibirAgruparInformacoes()    : visibilidade dos 3 checkboxes
*   - CarregarImpressorasConfiguradas() : UNION ALL SigSyImp/SigCdAcG/SigCdmp
*     + cruzamento com APRINTERS (crImpre/crImp/crImpreV do legado)
*   - ExecutarImpressao()               : Do SigBlBol With ... (com llObs e
*     llAgrupa) - rotina legada
*
* SigBlBol e uma PROCEDURE global do Fortyus (sig.prg/SIGFUNCS.PRG) que NAO
* veio no acervo (sem .prg fonte, sem FRX - ver regra CLAUDE.md #27 "Funcao
* GLOBAL do legado"). Nao ha como reproduzir a impressao real (layout de
* boleto bancario) sem esse fonte. ExecutarImpressao() (fase futura) deve
* TRANSCREVER o "Do SigBlBol With ..." exatamente como o legado chama, dentro
* de TRY/CATCH que exibe a falha com MsgErro (regra #9, CATCH nunca
* silencioso) - a ausencia fica VISIVEL em vez de virar um stub que finge
* imprimir.
*==============================================================================

DEFINE CLASS SigOpIboBO AS BusinessBase

    *-- Propriedades da entidade (parametros recebidos do form chamador,
    *-- espelhando as properties customizadas do form legado SIGOPIBO)
    this_nTpBol = 0               && vnTpBol - Tipo de Boleto
    this_cTitEnvelope = ""        && vcTitEnvelope - Titulo do Envelope
    this_cEmp = ""                && vcEmp - Codigo da Empresa
    this_cDope = ""                && vcDope - Nome da Operacao de Estoque/Producao
    this_nNum = 0                 && vnNum - Numero da Movimentacao de Estoque/Producao
    this_nDev = 0                 && vnDev - Valor de Devolucao
    this_nVias = 0                && vnVias - Numero da Via
    this_nQBols = 0               && vnQBols - Quantidade de Boletos
    this_cCursor = ""             && vnCursor - Nome do Cursor/Tabela a Imprimir (apesar do "vn", eh CHAR)
    this_nQtdImp = 0              && Quantidade de Impressoras de Boleto Configuradas (lnCimp/RECCOUNT('crImpreV'))
    this_cImpressoraSelecionada = "" && Impressora escolhida no combo (Get_Printer / crImpreV.IDupla)

    *-- Opcoes do PROPRIO dialogo (chkCarne/chkObss/chkAgrupa) - NAO sao
    *-- parametro do chamador, sao o estado inicial da tela no SCX
    this_lImprimirCarne = .F.         && chkCarne.Value (SCX: .T.)
    this_lImprimirObservacoes = .F.   && chkObss.Value (SCX: .T.)
    this_lAgruparInformacoes = .F.    && chkAgrupa.Value (SCX: .F.)

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
        THIS.this_cCursor = ""
        THIS.this_nQtdImp = 0
        THIS.this_cImpressoraSelecionada = ""

        THIS.this_lImprimirCarne = .F.
        THIS.this_lImprimirObservacoes = .F.
        THIS.this_lAgruparInformacoes = .F.

        RETURN .T.
    ENDPROC

    *====================================================================
    * DefinirTipoBoleto - Recebe os parametros do form chamador e aplica
    * as mesmas guardas de tipo do Init() legado (Iif(Type(...)='C'/'N',
    * valor, default)). Equivalente ao bloco WITH Thisform do Init do
    * SIGOPIBO.SCX, sem o SQLEXEC/UI que ficam em outros metodos.
    *====================================================================
    PROCEDURE DefinirTipoBoleto(par_nTpBol, par_cTitEnvelope, par_cEmp, ;
            par_cDope, par_nNum, par_nDev, par_nVias, par_nQBols, par_cCursor)

        THIS.this_cTitEnvelope = IIF(VARTYPE(par_cTitEnvelope) = "C", par_cTitEnvelope, "")
        THIS.this_nTpBol = IIF(VARTYPE(par_nTpBol) = "N", par_nTpBol, 0)
        THIS.this_cEmp = IIF(VARTYPE(par_cEmp) = "C", par_cEmp, "")
        THIS.this_cDope = IIF(VARTYPE(par_cDope) = "C", par_cDope, "")
        THIS.this_nNum = IIF(VARTYPE(par_nNum) = "N", par_nNum, 0)
        THIS.this_nDev = IIF(VARTYPE(par_nDev) = "N", par_nDev, 0)
        THIS.this_nVias = IIF(VARTYPE(par_nVias) = "N" AND par_nVias > 0, par_nVias, 0)
        THIS.this_nQBols = IIF(VARTYPE(par_nQBols) = "N" AND par_nQBols > 0, par_nQBols, 1)
        THIS.this_cCursor = IIF(VARTYPE(par_cCursor) = "C", par_cCursor, "")

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterTituloPorTipoBoleto - Do Case do titulo/Caption do Init legado.
    * Caso 1 (Protocolo de Cheque) usa o titulo recebido do chamador quando
    * fornecido (pcTitEnvelope), senao cai no titulo fixo - os demais casos
    * SEMPRE usam titulo fixo, mesmo que pcTitEnvelope tenha sido informado
    * (fiel ao Do Case do legado, que so olha pcTitEnvelope no Case 1).
    *====================================================================
    PROCEDURE ObterTituloPorTipoBoleto()
        LOCAL loc_cTitulo

        DO CASE
            CASE THIS.this_nTpBol = 1
                loc_cTitulo = IIF(!EMPTY(THIS.this_cTitEnvelope), THIS.this_cTitEnvelope, ;
                    "Impress" + CHR(227) + "o de Protocolo de Cheque")

            CASE INLIST(THIS.this_nTpBol, 2, 3, 4, 5, 7, 9)
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto"

            CASE THIS.this_nTpBol = 6
                loc_cTitulo = "Impress" + CHR(227) + "o de Protocolo de Cart" + CHR(227) + "o de Cr" + CHR(233) + "dito"

            CASE THIS.this_nTpBol = 8
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Conserto"

            CASE THIS.this_nTpBol = 12
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Ordem de Servi" + CHR(231) + "o"

            CASE THIS.this_nTpBol = 16
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto de Vendas"

            CASE THIS.this_nTpBol = 18
                loc_cTitulo = "Impress" + CHR(227) + "o de Duplicata/Carne"

            OTHERWISE
                loc_cTitulo = "Impress" + CHR(227) + "o de Boleto (*)"
        ENDCASE

        RETURN loc_cTitulo
    ENDPROC

    *====================================================================
    * DeveExibirImprimirObservacoes / DeveExibirImprimirCarne /
    * DeveExibirAgruparInformacoes - visibilidade dos tres checkboxes do
    * Init legado. chkObss.Visible e chkCarne.Visible sao atribuidos DUAS
    * vezes seguidas, sem IF entre as duas atribuicoes (ver comentario no
    * cabecalho deste arquivo) - so a ULTIMA atribuicao tem efeito:
    *   chkObss.Visible  = (TpBol=17) depois sobrescrito por !(TpBol=18)
    *   chkCarne.Visible = !(TpBol=17) depois sobrescrito por (TpBol=18)
    * Os metodos abaixo reproduzem o resultado final observavel, nao a
    * sequencia intermediaria (que nunca chega a ser visivel na tela).
    *====================================================================
    PROCEDURE DeveExibirImprimirObservacoes()
        RETURN (THIS.this_nTpBol != 18)
    ENDPROC

    PROCEDURE DeveExibirImprimirCarne()
        RETURN (THIS.this_nTpBol = 18)
    ENDPROC

    PROCEDURE DeveExibirAgruparInformacoes()
        RETURN (THIS.this_nTpBol = 3)
    ENDPROC

    *====================================================================
    * CarregarImpressorasConfiguradas - Reproduz o bloco do Init legado que
    * monta crImpreV (ComboBox Get_Printer):
    *   1. SigSyImp+SigCdmp (acesso direto) UNION ALL SigCdAcG+SigSyImp+
    *      SigCdmp (acesso por grupo), filtrado pelo usuario logado
    *      (Usuar no legado -> gc_4c_UsuarioLogado aqui, regra #PUBLICvars).
    *   2. SELECT DISTINCT das impressoras de boleto configuradas.
    *   3. APRINTERS() para as impressoras do Windows na estacao.
    *   4. Cruzamento fuzzy (LIKE dos dois lados) entre as impressoras de
    *      boleto configuradas e as impressoras do Windows, e ORDER BY 1.
    * Preenche this_nQtdImp (lnCimp/RECCOUNT('crImpreV') do legado) e
    * this_cImpressoraSelecionada com o 1o registro (GO TOP), equivalente
    * ao "thisform.get_Printer.value = RECNO('crImpreV')" + BoundColumn=1
    * do legado (a 1a coluna do RowSource, IDupla, eh o Value do combo).
    *
    * Se nenhuma impressora de boleto estiver configurada para o usuario,
    * crSigCdmp nunca eh criado no legado e a consulta seguinte (crSigCdmp
    * JOIN crImpre) estouraria "Alias nao encontrado" - aqui, em vez de
    * reproduzir essa falha latente, cria-se cursor_4c_SigCdmp vazio com a
    * mesma estrutura para o cruzamento seguir e resultar em zero linhas
    * (mesmo efeito pratico do legado: nenhuma impressora disponivel).
    *====================================================================
    PROCEDURE CarregarImpressorasConfiguradas()
        LOCAL loc_cSQL, loc_nResultado, loc_nPrinters, loc_nI, loc_aPrinters

        IF USED("cursor_4c_TmpCimp")
            USE IN cursor_4c_TmpCimp
        ENDIF
        IF USED("cursor_4c_SigCdmp")
            USE IN cursor_4c_SigCdmp
        ENDIF
        IF USED("cursor_4c_Impre")
            USE IN cursor_4c_Impre
        ENDIF
        IF USED("cursor_4c_Imp")
            USE IN cursor_4c_Imp
        ENDIF
        IF USED("cursor_4c_ImpreV")
            USE IN cursor_4c_ImpreV
        ENDIF

        loc_cSQL = "SELECT b.* FROM SigSyImp a, SigCdmp b " + ;
                   "WHERE a.UsuAcess = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.Cimps = b.Impres " + ;
                   "UNION ALL " + ;
                   "SELECT c.* FROM SigCdAcG a, SigSyImp b, SigCdmp c " + ;
                   "WHERE a.Usuarios = " + EscaparSQL(gc_4c_UsuarioLogado) + " AND a.Grupos = b.GrAcess AND b.Cimps = c.Impres"

        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCimp")
        IF loc_nResultado < 0
            MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o com Servidor de Banco de Dados.", "Erro")
            RETURN .F.
        ENDIF

        IF RECCOUNT("cursor_4c_TmpCimp") > 0
            SELECT DISTINCT Impres, nTpImpres, TpBarra, MaxCols ;
                FROM cursor_4c_TmpCimp ;
                ORDER BY Impres ;
                INTO CURSOR cursor_4c_SigCdmp
        ELSE
            CREATE CURSOR cursor_4c_SigCdmp (Impres C(50), nTpImpres N(1,0), TpBarra N(1,0), MaxCols N(3,0))
        ENDIF

        loc_nPrinters = APRINTERS(loc_aPrinters)
        CREATE CURSOR cursor_4c_Impre (impres C(50))
        IF loc_nPrinters != 0
            FOR loc_nI = 1 TO loc_nPrinters
                INSERT INTO cursor_4c_Impre (impres) VALUES (UPPER(loc_aPrinters[loc_nI, 1]))
            ENDFOR
        ENDIF

        SELECT PADR(ALLTRIM(a.Impres), 15) + " " + ALLTRIM(b.impres) AS IDupla, b.impres, a.impres AS impresS ;
            FROM cursor_4c_SigCdmp a, cursor_4c_Impre b ;
            WHERE (ALLTRIM(UPPER(b.impres)) LIKE "%" + ALLTRIM(UPPER(a.impres)) + "%" OR ;
                   ALLTRIM(UPPER(a.impres)) LIKE "%" + ALLTRIM(UPPER(b.impres)) + "%") ;
            GROUP BY b.impres, a.impres ;
            INTO CURSOR cursor_4c_Imp READWRITE

        SELECT * FROM cursor_4c_Imp ORDER BY 1 INTO CURSOR cursor_4c_ImpreV

        THIS.this_nQtdImp = RECCOUNT("cursor_4c_ImpreV")

        IF THIS.this_nQtdImp > 0
            SELECT cursor_4c_ImpreV
            GO TOP
            THIS.this_cImpressoraSelecionada = cursor_4c_ImpreV.IDupla
        ELSE
            THIS.this_cImpressoraSelecionada = ""
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ExecutarImpressao - Transcreve o Do SigBlBol With ... do
    * Cmd_Imprimir.Click legado. SigBlBol e uma PROCEDURE global do
    * Fortyus (sig.prg/SIGFUNCS.PRG) que NAO veio no acervo (regra
    * CLAUDE.md #27) - nao ha fonte para reproduzir o layout real do
    * boleto bancario. A chamada fica dentro de TRY/CATCH que exibe a
    * falha com MsgErro (regra #9, CATCH nunca silencioso): a ausencia
    * fica VISIVEL ao usuario em vez de um stub que finge imprimir.
    *
    * llObs (11o parametro) segue a mesma expressao do legado:
    * IIF(vnTpBol=18, chkCarne.Value, chkObss.Value) - o 18o caso usa o
    * checkbox de carne no lugar do de observacoes.
    *====================================================================
    PROCEDURE ExecutarImpressao()
        LOCAL loc_lSucesso, loc_oErro, loc_lObs, loc_lAgrupa

        loc_lSucesso = .F.
        loc_lObs = IIF(THIS.this_nTpBol = 18, THIS.this_lImprimirCarne, THIS.this_lImprimirObservacoes)
        loc_lAgrupa = THIS.this_lAgruparInformacoes

        TRY
            DO SigBlBol WITH THIS.this_nTpBol, THIS.this_cTitEnvelope, THIS.this_cEmp, ;
                THIS.this_cDope, THIS.this_nNum, THIS.this_nDev, THIS.this_nVias, ;
                THIS.this_nQBols, THIS.this_cImpressoraSelecionada, THIS.this_cCursor, ;
                loc_lObs, loc_lAgrupa
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel executar a impress" + CHR(227) + "o do boleto:" + CHR(13) + ;
                loc_oErro.Message, "Erro ao Imprimir")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Este BO nao sobrescreve CarregarDoCursor()/Inserir()/Atualizar()/
    * ExecutarExclusao()/ObterChavePrimaria(): o dialogo nao tem tabela nem
    * chave primaria propria (ver cabecalho deste arquivo) - o comportamento
    * padrao herdado de BusinessBase ja eh o correto para este caso.
    *--------------------------------------------------------------------------

ENDDEFINE
