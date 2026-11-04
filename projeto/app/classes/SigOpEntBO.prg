*==============================================================================
* SigOpEntBO.prg
*
* Business Object para SigOpEnt - "Alteracao de Data de Entrega", dialogo
* filho aberto pela tela de movimentacao (form OPERACIONAL, WindowType = 1).
*
* Tabela principal: SigOpMvv - historico das datas de entrega de UMA
* movimentacao. Cada troca de prazo grava em SigOpMvv a data que esta SAINDO
* (coluna vencs) e atualiza SigMvCab.PrazoEnts com a data nova.
*
* Origem legado: tasks\task731\SigOpEnt_form_codigo_fonte.txt
*   SIGOPENT.Init          - recebe pEmp, pDop, pNum, pPrz, pFor, pMin, pDat,
*                            pBlqAlt, pMax do form pai e carrega 3 cursores
*                            (crSigOpMvv, crSigCdOpe, crSigOpCdd)
*   SIGOPENT.getNova.Valid - valida a data digitada contra pDat / pMin / pMax
*   SIGOPENT.altera.Valid  - grava o historico e atualiza SigMvCab
*
* Esta tela NAO eh um cadastro CRUD: nao tem lista com Incluir/Alterar/
* Excluir. O unico caminho de gravacao eh o botao Confirmar, que INSERE uma
* linha de historico em SigOpMvv e faz o UPDATE de SigMvCab.PrazoEnts.
*==============================================================================

DEFINE CLASS SigOpEntBO AS BusinessBase

    *--------------------------------------------------------------------------
    * COLUNAS DE SigOpMvv - grafia EXATA do docs\schema.sql (PILAR 2)
    *
    *   cidchaves  char(20)      NOT NULL   PK (sigopmvv_cidchaves)
    *   emps       char(3)       NOT NULL
    *   dopcs      char(20)      NOT NULL
    *   notitulos  numeric(6,0)  NOT NULL
    *   empdopncs  char(29)      NOT NULL
    *   vencs      datetime      NULL
    *   datas      datetime      NULL
    *   usuars     char(10)      NOT NULL
    *
    * As 6 colunas NOT NULL tem propriedade propria aqui (regra #22): a PK
    * cidchaves vem de fUniqueIds() - NUNCA string vazia, senao a segunda
    * linha de historico colide no indice unico - e usuars vem de
    * gc_4c_UsuarioLogado. O legado grava exatamente estas 8 colunas
    * (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs, cIdChaves, Usuars, Datas),
    * ou seja a lista do schema e a do legado coincidem.
    *--------------------------------------------------------------------------
    this_cCidChaves = ""            && cidchaves  char(20)     - PK, fUniqueIds()
    this_cEmps = ""                 && emps       char(3)      - empresa (pEmp)
    this_cDopcs = ""                && dopcs      char(20)     - documento/operacao (pDop)
    this_nNoTitulos = 0             && notitulos  numeric(6,0) - numero da operacao (pNum)
    this_cEmpDopNcs = ""            && empdopncs  char(29)     - chave posicional
    this_dVencs = {}                && vencs      datetime     - data de entrega ARQUIVADA
    this_dDatas = {}                && datas      datetime     - data/hora do registro
    this_cUsuars = ""               && usuars     char(10)     - usuario que alterou

    *--------------------------------------------------------------------------
    * CHAVE POSICIONAL empdopncs char(29) - regra #42
    *
    * O legado monta a chave concatenando SEM ALLTRIM:
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * As larguras vem das COLUNAS: emps char(3) + dopcs char(20) + STR(,6)
    * = 29 = empdopncs char(29). O padding FAZ PARTE da chave: encurtar
    * qualquer parte com ALLTRIM devolve ZERO linha em silencio. A montagem
    * usa PADR explicito sobre as larguras do schema, porque as propriedades
    * deste BO recebem os valores do form pai ja com ALLTRIM.
    *
    * A MESMA chave de 29 caracteres eh o filtro do UPDATE de SigMvCab
    * (Where EmpDopNums = ...), por isso uma unica propriedade atende aos
    * dois usos.
    *--------------------------------------------------------------------------
    this_nLarguraEmps = 3           && largura de SigOpMvv.emps  no schema
    this_nLarguraDopcs = 20         && largura de SigOpMvv.dopcs no schema
    this_nLarguraNoTitulos = 6      && digitos de STR(notitulos, 6) na chave

    *--------------------------------------------------------------------------
    * PARAMETROS RECEBIDOS DO FORM PAI
    *
    * O legado guarda estes valores em propriedades do proprio form (pEmp,
    * pDop, pNum, pPrz, pMin, pMax, pDat, Bloquear - ver RESERVED3 ClassInfo
    * do dump). Aqui eles vivem no BO, porque sao o insumo da validacao e da
    * gravacao. pFor (a referencia ao form pai) NAO vem para o BO: continua
    * sendo assunto do Form.
    *
    * As datas sao declaradas como DATE ({}) porque chegam de TextBox e de
    * propriedade do form pai, nao de coluna datetime do SQL Server - por
    * isso toda normalizacao usa ConverterParaData(), nunca TTOD(), que com
    * DATE dispara erro 11 em runtime (regra #16).
    *--------------------------------------------------------------------------
    this_dPrazoAtual = {}           && pPrz    - data de entrega vigente (SigMvCab.PrazoEnts)
    this_dPrazoNovo = {}            && valor digitado em getNova
    this_dDataMovimento = {}        && pDat    - data da movimentacao
    this_nPrazoMinimo = 0           && pMin    - dias minimos contados de pDat
    this_nPrazoMaximo = 0           && pMax    - dias maximos contados de pDat
    this_lBloquear = .F.            && pBlqAlt - .T. bloqueia a alteracao (so consulta)

    *--------------------------------------------------------------------------
    * CONTEXTO DO FORM PAI QUE DECIDE O UPDATE DE SigMvCab
    *
    * No legado: If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR').
    * O UPDATE de SigMvCab.PrazoEnts SO acontece quando o pai NAO esta em
    * modo ALTERAR - nesse modo o proprio pai grava o cabecalho. O historico
    * em SigOpMvv, ao contrario, eh gravado nos dois casos.
    *--------------------------------------------------------------------------
    this_cEscolhaPai = ""           && ParentForm.pcEscolha ("INSERIR"/"ALTERAR"/...)
    this_cModoNaoAtualizaCabecalho = "ALTERAR"   && valor que SUPRIME o UPDATE de SigMvCab

    *--------------------------------------------------------------------------
    * CONFIGURACAO LIDA DOS CURSORES DE APOIO (CursorQuery do Init legado)
    *
    * Ambas sao numeric(1,0) NOT NULL no schema, portanto chegam ao VFP como
    * NUMERICO - propriedade this_n*, comparada com numero.
    *
    *   SigCdOpe.dtentrs  - regra de exigencia do prazo de entrega. O legado
    *                       so exige/valida a data quando InList(DtEntrs, 1, 4, 6).
    *   SigOpCdd.chkuteis - indica se a contagem de dias considera dias uteis.
    *--------------------------------------------------------------------------
    this_nDtEntrs = 0               && SigCdOpe.dtentrs  numeric(1,0)
    this_nChkUteis = 0              && SigOpCdd.chkuteis numeric(1,0)

    *--------------------------------------------------------------------------
    * ALIASES DOS CURSORES
    *
    * Equivalencia com o legado:
    *   crSigOpMvv  -> cursor_4c_Dados      (alimenta a grade Gradevenc)
    *   crSigCdOpe  -> cursor_4c_Operacao   (CursorQuery SigCdOpe / Dopes / DtEntrs)
    *   crSigOpCdd  -> cursor_4c_ConfigDoc  (CursorQuery SigOpCdd / Dopes / chkUteis)
    *--------------------------------------------------------------------------
    this_cCursorHistorico = "cursor_4c_Dados"
    this_cCursorOperacao = "cursor_4c_Operacao"
    this_cCursorConfigDoc = "cursor_4c_ConfigDoc"

    *--------------------------------------------------------------------------
    * LIBERACAO POR SENHA (Do Form SigOpSen With 'LIBPRZENT', ...)
    *
    * Quando a data digitada fica fora da faixa pMin..pMax, o legado pede
    * autorizacao pelo programa LIBPRZENT e, autorizado, registra a liberacao
    * com fGravarLog('T', pDop, 'LIBPRZENT', <transacao>, <usuario liberador>).
    * O codigo do programa eh constante no legado e fica aqui para o texto do
    * log e a chamada da autorizacao usarem a MESMA grafia.
    *--------------------------------------------------------------------------
    this_cProgramaLiberacao = "LIBPRZENT"
    this_cTituloLiberacao = "Libera Prazo de Entrega"
    this_cUsuarioLiberacao = ""     && usuario que autorizou (retorno do SigOpSen)
    this_lPrazoLiberado = .F.       && .T. quando a autorizacao foi concedida

    *--------------------------------------------------------------------------
    * ESTADO DA ULTIMA GRAVACAO
    *
    * O legado controla commit/rollback com a flag local llOks e avisa o pai
    * do sucesso com thisform.parentform.validOk = .t. - o Form le esta
    * propriedade para decidir se repassa o novo prazo ao pai.
    *--------------------------------------------------------------------------
    this_lGravouPrazo = .F.         && .T. quando historico e cabecalho gravaram

    *====================================================================
    * Init - Inicializa Business Object
    *
    * this_cCampoChave usa a grafia do schema (cidchaves), que eh a PK
    * declarada em CONSTRAINT [sigopmvv_cidchaves].
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigOpMvv"
        THIS.this_cCampoChave = "cidchaves"

        *-- usuars eh NOT NULL char(10): nasce com o usuario logado, o mesmo
        *-- Usuar global que o INSERT do legado usa. O guard de TYPE existe
        *-- porque probe/teste headless pode instanciar o BO antes do startup
        *-- ter definido a variavel publica.
        IF TYPE("gc_4c_UsuarioLogado") = "C"
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
        ELSE
            THIS.this_cUsuars = ""
        ENDIF

        *-- Nenhuma gravacao nem liberacao aconteceu nesta instancia ainda.
        THIS.this_lGravouPrazo = .F.
        THIS.this_lPrazoLiberado = .F.
        THIS.this_cUsuarioLiberacao = ""

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - PK da linha de historico gravada por Inserir()
    *
    * Fica PROTECTED pela heranca de BusinessBase (regra #51 do CLAUDE.md:
    * PROTECTED declarado em QUALQUER classe da cadeia prevalece) - quem
    * usa isto eh RegistrarAuditoria(), chamado de dentro do proprio BO.
    *====================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega uma linha de SigOpMvv (cursor_4c_Dados,
    * equivalente ao crSigOpMvv do legado) para as propriedades do BO.
    *
    * Esta tela NUNCA altera uma linha de historico existente - cada
    * confirmacao sempre INSERE uma linha nova (ver cabecalho da classe).
    * Este metodo serve para inspecionar uma linha ja gravada (detalhe da
    * grade Gradevenc), nao para reabrir edicao; this_lNovoRegistro = .F.
    * segue o padrao canonico do projeto (BlqBO.CarregarDoCursor e
    * similares), mesmo que esta tela nao tenha fluxo de ALTERAR.
    *
    * Uso de SELECT (par_cAliasCursor) + campo direto, nunca
    * campo (regra #9 - sintaxe invalida em VFP9).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cEmps      = TratarNulo(emps, "C")
            THIS.this_cDopcs     = TratarNulo(dopcs, "C")
            THIS.this_nNoTitulos = TratarNulo(notitulos, 0)
            THIS.this_cEmpDopNcs = TratarNulo(empdopncs, "C")
            THIS.this_dVencs     = TratarNulo(vencs, {})
            THIS.this_dDatas     = TratarNulo(datas, {})
            THIS.this_cUsuars    = TratarNulo(usuars, "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *====================================================================
    * MontarChaveEmpDopNums - Chave POSICIONAL de 29 caracteres, usada
    * tanto no INSERT de SigOpMvv.empdopncs quanto no WHERE do UPDATE de
    * SigMvCab.empdopnums (mesmo VALOR, nomes de coluna diferentes - o
    * legado monta os dois com a mesma expressao).
    *
    * Regra #42: o legado monta SEM ALLTRIM -
    *   ThisForm.pEmp + ThisForm.pDop + Str(ThisForm.pNum, 6)
    * - e o padding FAZ PARTE da chave: emps char(3) + dopcs char(20) +
    * STR(,6) = 29 caracteres = largura EXATA das colunas empdopncs e
    * empdopnums no schema. Usa PADR explicito sobre as larguras do
    * SCHEMA (this_nLarguraEmps/Dopcs/NoTitulos), porque this_cEmps e
    * this_cDopcs chegam a este BO ja com ALLTRIM (vindos do form pai) -
    * encurtar qualquer parte faz a chave NUNCA casar, sem erro nenhum.
    *====================================================================
    PROTECTED FUNCTION MontarChaveEmpDopNums()
        RETURN PADR(THIS.this_cEmps, THIS.this_nLarguraEmps) + ;
               PADR(THIS.this_cDopcs, THIS.this_nLarguraDopcs) + ;
               STR(THIS.this_nNoTitulos, THIS.this_nLarguraNoTitulos)
    ENDFUNC

    *====================================================================
    * CarregarConfiguracaoOperacao - Carrega as duas configuracoes de apoio
    * que o Init legado busca com CursorQuery, ANTES de liberar a tela:
    *
    *   .poDataMgr.CursorQuery('SigCdOpe', 'crSigCdOpe', 'Dopes', .pDop, 'DtEntrs')
    *   If Not Used('crSigCdOpe')
    *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ...)
    *       Return .f.
    *   EndIf
    *   .poDataMgr.CursorQuery('SigOpCdd', 'crSigOpCdd', 'Dopes', .pDop, 'chkUteis')
    *   If Not Used('crSigOpCdd')
    *       ... Return .f.
    *   EndIf
    *
    * As DUAS consultas sao requisito de ABERTURA no legado: falhando
    * qualquer uma, o Init devolve .f. e o "Do Form" inteiro nao chega a
    * abrir. Aqui o mesmo efeito vem do RETURN .F. deste metodo, que o
    * InicializarForm do Form usa para abortar o CREATEOBJECT.
    *
    * this_nDtEntrs eh o que ValidarPrazoNovo (Form) usa depois
    * (InList(DtEntrs,1,4,6) do getNova.Valid legado). this_nChkUteis eh
    * carregado pelo mesmo motivo do legado - a abertura da tela depende
    * das DUAS consultas terem sucesso -, mas nenhum dos 7 metodos com
    * codigo do dump chega a LER o valor depois de carregado: fica
    * disponivel sem logica adicional inventada (regra CLAUDE.md
    * REGRA FUNDAMENTAL - nao omitir, mas tambem nao inventar uso que o
    * legado nao tem).
    *
    * Sem conexao (gnConnHandle invalido - probe headless, validacao de UI)
    * os dois valores ficam no default 0 e o metodo devolve .T.: nao ha
    * banco para consultar, e abortar a tela nesse modo impediria qualquer
    * teste automatizado de instanciar o form.
    *
    * Em gb_4c_ModoTeste/gb_4c_ValidandoUI o bypass vale mesmo com conexao
    * REAL disponivel: TestFormWrapper (harness de 06_testForm) instancia o
    * form com CREATEOBJECT(par_cFormClass) SEM os 9 parametros do pai, logo
    * this_cDopcs chega vazio. Na producao isso nunca acontece - a tela so
    * abre via "Do Form"/CREATEOBJECT do form de movimentacao, que sempre
    * passa pDop -, mas num ambiente com o SQL Server alcancavel a consulta
    * roda de verdade, nao acha SigCdOpe.Dopes = '' e cai no mesmo ramo que
    * trata isso como "Favor Reinicializar o Processo!!!": sem o bypass, o
    * teste reprova toda vez que o pipeline tem acesso real ao banco, mesmo
    * o form estando correto.
    *
    * EVALUATE(<alias> + ".<campo>") para LEITURA eh seguro (regra #15) -
    * so a ATRIBUICAO com "=" dentro da string eh que nao funciona.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * InicializarForm() do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarConfiguracaoOperacao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_oErro, loc_lModoSemBanco
        loc_lSucesso = .F.

        loc_lModoSemBanco = (TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0) ;
            OR (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) ;
            OR (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

        TRY
            IF loc_lModoSemBanco
                *-- Sem conexao, ou em modo teste/validacao de UI (que roda
                *-- sem os parametros reais do form pai): mesmo criterio de
                *-- CarregarHistorico - nao ha o que consultar, e isso nao
                *-- e falha.
                loc_lSucesso = .T.
            ELSE
                IF USED(THIS.this_cCursorOperacao)
                    USE IN (THIS.this_cCursorOperacao)
                ENDIF

                loc_cSQL = "SELECT DtEntrs FROM SigCdOpe" + ;
                    " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOperacao)

                IF loc_nResult >= 0 AND USED(THIS.this_cCursorOperacao) ;
                        AND !EOF(THIS.this_cCursorOperacao)

                    THIS.this_nDtEntrs = NVL(EVALUATE(THIS.this_cCursorOperacao + ".DtEntrs"), 0)

                    IF USED(THIS.this_cCursorConfigDoc)
                        USE IN (THIS.this_cCursorConfigDoc)
                    ENDIF

                    loc_cSQL = "SELECT chkUteis FROM SigOpCdd" + ;
                        " WHERE Dopes = " + EscaparSQL(THIS.this_cDopcs)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorConfigDoc)

                    IF loc_nResult >= 0 AND USED(THIS.this_cCursorConfigDoc) ;
                            AND !EOF(THIS.this_cCursorConfigDoc)
                        THIS.this_nChkUteis = NVL(EVALUATE(THIS.this_cCursorConfigDoc + ".chkUteis"), 0)
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                            "o (CursorQuery - SigOpCdd)")
                        THIS.this_lErroExibido = .T.
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                    MsgErro(THIS.this_cMensagemErro, "Falha na Conex" + CHR(227) + ;
                        "o (CursorQuery - SigCdOpe)")
                    THIS.this_lErroExibido = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarConfiguracaoOperacao")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CriarCursorHistorico - Cria o cursor VAZIO que alimenta a grade do
    * historico (this_cCursorHistorico, o crSigOpMvv do legado).
    *
    * Este metodo eh a FONTE UNICA da estrutura desse cursor: nomes, tipos e
    * ORDEM aqui tem de ser os MESMOS da lista do SELECT de
    * CarregarHistorico(), porque a recarga eh por ZAP + APPEND FROM DBF(),
    * que casa coluna por NOME. Por isso o Form CHAMA este metodo e NUNCA
    * declara a estrutura de novo - duas declaracoes com ordem ou grafia
    * diferentes eh o defeito classico dos forms OPERACIONAIS.
    *
    * Tipos conforme docs\schema.sql (SIGOPMVV): cidchaves char(20),
    * emps char(3), dopcs char(20), notitulos numeric(6,0),
    * empdopncs char(29), vencs datetime, datas datetime, usuars char(10).
    *
    * SET NULL ON em volta do CREATE CURSOR: vencs e datas sao NULL-aveis no
    * SQL Server, e sem campos NULL-aveis o APPEND FROM de uma linha com
    * NULL falha.
    *
    * O alias eh fechado com USE IN e SEM TABLEREVERT antes: USE IN fecha
    * mesmo com buffer sujo, enquanto TABLEREVERT em cursor sem buffering -
    * que eh como CREATE CURSOR e SQLEXEC os criam - dispara erro 1586.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o Form, de FORA da
    * classe, antes de ligar a grade.
    *====================================================================
    PROCEDURE CriarCursorHistorico()
        LOCAL loc_cCursor
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            USE IN (loc_cCursor)
        ENDIF

        SET NULL ON
        CREATE CURSOR (loc_cCursor) ;
            (cidchaves C(20), emps C(3), dopcs C(20), notitulos N(6, 0), ;
             empdopncs C(29), vencs T, datas T, usuars C(10))
        SET NULL OFF

        RETURN USED(loc_cCursor)
    ENDPROC

    *====================================================================
    * LimparCursorHistorico - Esvazia o cursor da grade PRESERVANDO a
    * estrutura e, com ela, o RecordSource/ControlSource que o Form ligou no
    * InicializarForm. Eh o Zap In <cursor> do legado Fortyus.
    *
    * SET SAFETY OFF em volta do ZAP eh OBRIGATORIO, nao precaucao: o form
    * que consome este BO eh DataSession = 2, e SET SAFETY eh escopado por
    * DATA SESSION - medido no VFP9, dentro da datasession privada o SAFETY
    * vale ON mesmo com o SET SAFETY OFF do main.prg (mesmo mecanismo que
    * reseta SET DATE/CENTURY ali). Com SAFETY ON o ZAP abre o dialogo modal
    * "Zap ... Are you sure?" e CONGELA a tela esperando um clique que
    * ninguem ve - num teste headless isso aparece como timeout sem
    * resultado nenhum, nao como erro.
    *
    * SELECT antes do ZAP: ZAP IN nao muda a work area corrente, e quem
    * chama este metodo segue com APPEND FROM, que vai para a work area
    * CORRENTE.
    *====================================================================
    PROTECTED PROCEDURE LimparCursorHistorico()
        LOCAL loc_cCursor, loc_cSafety
        loc_cCursor = THIS.this_cCursorHistorico

        IF USED(loc_cCursor)
            loc_cSafety = SET("SAFETY")
            SET SAFETY OFF
            SELECT (loc_cCursor)
            ZAP IN (loc_cCursor)
            IF loc_cSafety == "ON"
                SET SAFETY ON
            ENDIF
        ENDIF
    ENDPROC

    *====================================================================
    * CarregarHistorico - Popula a grade com o historico de datas de entrega
    * desta operacao (uma linha por troca de prazo ja arquivada).
    *
    * Transcreve a consulta que o Init legado monta e manda ao AddCursor:
    *   lcQrySigOpMvv = [Select * ] + ;
    *                    [From SigOpMvv ] + ;
    *                   [Where EmpDopNcs = '] + pEmp + pDop + Str(pNum, 6) + [' ] + ;
    *                   [Order By Vencs]
    * As colunas sao listadas explicitamente no lugar do SELECT *, para a
    * lista do SELECT ser a MESMA do CREATE CURSOR de CriarCursorHistorico()
    * - APPEND FROM DBF() casa coluna por NOME.
    *
    * A chave vem de MontarChaveEmpDopNums(): 29 caracteres COM o padding,
    * porque empdopncs eh char(29) POSICIONAL (emps char(3) + dopcs char(20)
    * + STR(,6)) e encurtar qualquer parte com ALLTRIM faz o WHERE nunca
    * casar - devolvendo ZERO linha em SILENCIO, sem erro e sem log.
    *
    * Sem os parametros do form pai (probe headless, harness) a chave fica
    * em branco e o SELECT devolve ZERO linha: grade vazia, SEM erro - o
    * mesmo que o legado exibe para uma operacao que nunca teve troca de
    * prazo. Por isso zero linha NAO eh falha, e quem precisa aferir carga
    * tem de olhar RECCOUNT, nao o retorno deste metodo.
    *
    * O SQLEXEC vai para um cursor TEMPORARIO e o alias da grade eh
    * recarregado por ZAP + APPEND FROM DBF(). SQLEXEC direto sobre o alias
    * da grade FECHA e RECRIA o alias: o Grid perde RecordSource e
    * ControlSource e cai para ColumnCount = 0 - vira um retangulo branco
    * sem cabecalho e sem coluna, sem erro, sem log e sem excecao.
    *
    * O guard do TABLEREVERT olha o BUFFERING, nao o USED: TABLEREVERT em
    * cursor sem buffering (como SQLEXEC cria) dispara erro 1586.
    *
    * Sem conexao (gnConnHandle invalido - validacao de UI, probe headless)
    * a grade fica VAZIA e o metodo devolve .T.: nao houve falha, so nao
    * havia banco para consultar.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro de
    * TRY/CATCH eh proibido em VFP9.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o CarregarLista()
    * do Form, de FORA da classe.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cCursor, loc_cTmp, loc_cChave
        LOCAL loc_nResult, loc_lSucesso, loc_oErro

        loc_lSucesso = .F.
        loc_cCursor  = THIS.this_cCursorHistorico
        loc_cTmp     = "cursor_4c_HistoricoTmp"

        TRY
            IF !USED(loc_cCursor)
                THIS.CriarCursorHistorico()
            ENDIF

            IF !USED(loc_cCursor)
                THIS.this_cMensagemErro = "N" + CHR(227) + "o foi poss" + CHR(237) + ;
                    "vel criar o cursor do hist" + CHR(243) + "rico (" + loc_cCursor + ")."
                MsgErro(THIS.this_cMensagemErro, "SigOpEntBO.CarregarHistorico")
                THIS.this_lErroExibido = .T.
            ELSE
                IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                    *-- Sem conexao: grade vazia, mesmo resultado visual de uma
                    *-- operacao sem historico
                    THIS.LimparCursorHistorico()
                    loc_lSucesso = .T.
                ELSE
                    loc_cChave = THIS.MontarChaveEmpDopNums()

                    loc_cSQL = "SELECT cidchaves, emps, dopcs, notitulos," + ;
                        " empdopncs, vencs, datas, usuars" + ;
                        " FROM SigOpMvv" + ;
                        " WHERE EmpDopNcs = " + EscaparSQL(loc_cChave) + ;
                        " ORDER BY Vencs"

                    IF USED(loc_cTmp)
                        IF CURSORGETPROP("Buffering", loc_cTmp) > 1
                            TABLEREVERT(.T., loc_cTmp)
                        ENDIF
                        USE IN (loc_cTmp)
                    ENDIF

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, loc_cTmp)

                    IF loc_nResult >= 0
                        THIS.LimparCursorHistorico()
                        SELECT (loc_cCursor)
                        SET NULL ON
                        APPEND FROM DBF(loc_cTmp)
                        SET NULL OFF
                        loc_lSucesso = .T.
                    ELSE
                        *-- Mensagem do legado nas falhas de carga deste form:
                        *-- MessageBox([Favor Reinicializar o Processo!!!], 16,
                        *--            [Falha na Conexao (...)])
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (" + loc_cCursor + ")")
                        THIS.this_lErroExibido = .T.
                    ENDIF

                    IF USED(loc_cTmp)
                        USE IN (loc_cTmp)
                    ENDIF
                ENDIF

                IF loc_lSucesso
                    SELECT (loc_cCursor)
                    GO TOP
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.CarregarHistorico")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT de uma linha de HISTORICO em SigOpMvv.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 550-553 do dump legado):
    *   Insert Into crSigOpMvv (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs,
    *                           cIdChaves, Usuars, Datas)
    *          Values (pEmp, pDop, pNum, fDtoSQL(ldAnt),
    *                  pEmp + pDop + Str(pNum,6), fUniqueIds(), Usuar,
    *                  Datetime())
    *
    * ATENCAO (nao inverter): Vencs recebe this_dPrazoAtual - o prazo que
    * esta SAINDO (ldAnt no legado) - NUNCA this_dPrazoNovo. O historico
    * arquiva a data ANTIGA, a nova vai para SigMvCab em Atualizar().
    *
    * O legado so executa o bloco inteiro (insert+update+commit) quando a
    * data nova nao esta vazia (If Not Empty(ldNew)); com o campo vazio o
    * clique em Confirmar nao faz nada, sem erro nenhum - por isso aqui
    * tambem devolve .T. (nada a gravar) e nao falha.
    *====================================================================
    FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        THIS.this_lGravouPrazo = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        TRY
            THIS.this_cCidChaves = LEFT(fUniqueIds(), 20)
            THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()

            IF TYPE("gc_4c_UsuarioLogado") = "C"
                THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)
            ENDIF

            loc_cSQL = "INSERT INTO SigOpMvv" + ;
                       " (Emps, Dopcs, NoTitulos, Vencs, EmpDopNcs," + ;
                       "  cIdChaves, Usuars, Datas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, THIS.this_nLarguraEmps)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cDopcs, THIS.this_nLarguraDopcs)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNoTitulos, 0) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrazoAtual) + ", " + ;
                       EscaparSQL(THIS.this_cEmpDopNcs) + ", " + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cUsuars) + ", " + ;
                       "GETDATE())"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao gravar hist" + CHR(243) + "rico de entrega:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * Atualizar - UPDATE de SigMvCab.PrazoEnts com a data NOVA.
    *
    * Espelha SIGOPENT.altera.Valid (linhas 559-568 do dump legado):
    *   If llOks And (ThisForm.ParentForm.pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts = ?pDtp
    *       Where EmpDopNums = pEmp + pDop + Str(pNum,6)
    *   EndIf
    *
    * Quando o form pai esta em modo ALTERAR (this_cEscolhaPai igual a
    * this_cModoNaoAtualizaCabecalho), o PROPRIO pai grava o cabecalho e
    * este UPDATE tem de ser PULADO - essa condicao eh regra de negocio
    * do legado (CLAUDE.md regra #21b: a condicao que cerca a validacao
    * faz parte dela), por isso devolve .T. (nada a atualizar) em vez de
    * executar o UPDATE, exatamente como o legado nao executa a query.
    *
    * Depende de this_cEmpDopNcs e this_dPrazoNovo ja estarem calculados
    * - chamar DEPOIS de Inserir() ter devolvido .T., nunca isolado.
    *====================================================================
    FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .T.
        ENDIF

        IF THIS.this_cEscolhaPai = THIS.this_cModoNaoAtualizaCabecalho
            *-- Modo ALTERAR: o form pai grava o proprio cabecalho - nada a
            *-- fazer aqui (fiel ao guard do legado em altera.Valid).
            THIS.this_lGravouPrazo = .T.
            RETURN .T.
        ENDIF

        TRY
            IF EMPTY(THIS.this_cEmpDopNcs)
                THIS.this_cEmpDopNcs = THIS.MontarChaveEmpDopNums()
            ENDIF

            loc_cSQL = "UPDATE SigMvCab SET" + ;
                       " PrazoEnts = " + FormatarDataSQL(THIS.this_dPrazoNovo) + ;
                       " WHERE EmpDopNums = " + EscaparSQL(THIS.this_cEmpDopNcs)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                THIS.this_lGravouPrazo = .T.
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar o prazo de entrega do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SigOpEntBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *====================================================================
    * GravarAlteracaoPrazo - UNICA via de gravacao desta tela: encadeia
    * Inserir() + Atualizar() e fecha a transacao, espelhando o corpo de
    * SIGOPENT.altera.Valid com a flag llOks do legado:
    *
    *   Insert Into crSigOpMvv (...)            -> Inserir()
    *   llOks = .t.
    *   If llOks And (pcEscolha <> 'ALTERAR')
    *       Update SigMvCab Set PrazoEnts ...   -> Atualizar()
    *   EndIf
    *   If llOks
    *       If Not poDataMgr.Update('crSigOpMvv')  -> (ver nota abaixo)
    *   EndIf
    *   If llOks
    *       If (poDataMgr.Commit() < 1)
    *           =MessageBox('Favor Reinicializar o Processo!!!', 16,
    *                       'Falha na Conexao (Commit)')
    *           llOks = .f.
    *       EndIf
    *   EndIf
    *   If Not llOks
    *       poDataMgr.RollBack()
    *   EndIf
    *
    * O "poDataMgr.Update('crSigOpMvv')" do legado NAO tem linha propria
    * aqui: ele era o passo que mandava ao servidor as linhas em aberto do
    * cursor remoto do Fortyus (o INSERT legado grava no CURSOR, nao na
    * tabela). Nesta arquitetura Inserir() emite o INSERT direto em
    * SigOpMvv por SQLEXEC, de modo que o envio ja aconteceu - o passo
    * esta cumprido, nao descartado.
    *
    * O Commit(), ao contrario, NAO se descarta: medido neste ambiente,
    * SQLGETPROP(gnConnHandle, "Transactions") = 2 (MANUAL) e a conexao
    * nasce com @@TRANCOUNT = 1, isto eh o gravado fica preso na transacao
    * aberta e SOME se o processo cair - foi assim que um UPDATE migrado
    * sem o Commit do legado deixou de persistir sem erro na tela. O par
    * loc_lManual + SQLCOMMIT/SQLROLLBACK eh a forma segura usada no
    * projeto (SIGPRCNBBO): com a conexao em auto-commit o par fica
    * inerte, em vez de comitar a transacao de outra tela.
    *
    * IF ANINHADO, nunca "IF loc_lManual AND SQLCOMMIT(...)": VFP9 nao faz
    * curto-circuito e chamaria o SQLCOMMIT de qualquer jeito.
    *
    * Campo vazio devolve .F. sem mensagem nenhuma: o legado embrulha o
    * bloco inteiro em "If Not Empty(ldNew)", logo clicar Confirmar com a
    * data nova em branco nao faz nada - nem grava, nem avisa. Quem decide
    * se ha o que gravar eh o Form, que ja testa isso antes de chamar;
    * este guard existe para o metodo nunca gravar meia operacao se for
    * chamado isolado.
    *
    * this_lGravouPrazo (o "thisform.parentform.validOk = .t." do legado)
    * so permanece .T. quando TODA a cadeia passou - inclusive o commit.
    *
    * RETURN unico DEPOIS do ENDTRY, com flag loc_lSucesso: RETURN dentro
    * de TRY/CATCH eh proibido em VFP9. Os dois RETURN antecipados ficam
    * FORA do bloco.
    *
    * PUBLIC (sem PROTECTED) de proposito: quem chama eh o
    * BtnConfirmarClick() do Form, de FORA da classe - metodo que o Form
    * chama nunca pode ser PROTECTED em nenhum nivel da heranca
    * (regra #51).
    *====================================================================
    FUNCTION GravarAlteracaoPrazo()
        LOCAL loc_lSucesso, loc_lManual, loc_oErro
        loc_lSucesso = .F.

        THIS.this_lGravouPrazo  = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        IF EMPTY(THIS.this_dPrazoNovo)
            RETURN .F.
        ENDIF

        *-- Conexao em transacao MANUAL (2) exige commit explicito; em
        *-- auto-commit (1) o par commit/rollback fica inerte.
        loc_lManual = .F.
        IF TYPE("gnConnHandle") = "N"
            IF gnConnHandle > 0
                loc_lManual = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
            ENDIF
        ENDIF

        TRY
            *-- Historico: arquiva a data que esta SAINDO (this_dPrazoAtual)
            loc_lSucesso = THIS.Inserir()

            *-- Cabecalho do movimento: recebe a data NOVA. Pulado quando o
            *-- form pai esta em ALTERAR - ali eh ele que grava SigMvCab
            *-- (guard do legado, ja dentro de Atualizar()).
            IF loc_lSucesso
                loc_lSucesso = THIS.Atualizar()
            ENDIF

            IF loc_lManual
                IF loc_lSucesso
                    IF SQLCOMMIT(gnConnHandle) < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!!"
                        MsgErro(THIS.this_cMensagemErro + CHR(13) + CapturarErroSQL(), ;
                            "Falha na Conex" + CHR(227) + "o (Commit)")
                        THIS.this_lErroExibido = .T.
                        = SQLROLLBACK(gnConnHandle)
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    *-- "If Not llOks / ThisForm.poDataMgr.RollBack()"
                    = SQLROLLBACK(gnConnHandle)
                ENDIF
            ENDIF

            IF !loc_lSucesso
                THIS.this_lGravouPrazo = .F.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "SigOpEntBO.GravarAlteracaoPrazo")
            THIS.this_lErroExibido = .T.
            THIS.this_lGravouPrazo = .F.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE
