# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODS, FIXOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'TIPOS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: EMPS, CODS, FIXOS

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES SQL
- [GRID-SQL] Campos no ControlSource que nao existem no CREATE CURSOR/SELECT
- [SQL-COLUNA] Nomes de colunas que NAO existem na tabela (validado contra banco real)
  - A mensagem mostra colunas VALIDAS - usar nome EXATO
  - Se sugere "voce quis dizer 'X'?", usar X
- [SQL-TABELA] Tabela inventada que nao existe no original
- [SQL-ASPAS] Aspas duplicadas ou concatenacao sem EscaparSQL
  - EscaparSQL() JA retorna com aspas. FormatarDataSQL() idem.
- [SQL-FILTRO-INVENTADO] Condicao WHERE inventada pela LLM - REMOVER
- [TRANSACAO-AVULSA] COMMIT/ROLLBACK sem BEGIN TRANSACTION - REMOVER

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos

### LINHAS SQL/CONTROLSOURCE DO CODIGO ORIGINAL (referencia):
	lcSql = [Select * From SigCdNcf Where (Emps = ']+_Empr+[' Or Emps = ' ') And ]+;
	ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigCdNcf')
	Select CrSigCdNcf
	If Not Seek(This.Value, 'CrSigCdNcf', 'Cods')
lcSql = [Select * From SigCdNcf Where cods = ']+lcCod+[']
ThisForm.Podatamgr.Sqlexecute(lcsql,'CrSigCdNcf')

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLib.prg) - TRECHOS RELEVANTES PARA PASS SQL (1713 linhas total):

*-- Linhas 32 a 50:
32: *     BaseClass: grid        ZERO     AddCursor      ZERO
33: *     BaseClass: pageframe   ZERO     pColuna        ZERO
34: *     BaseClass: listbox     ZERO     RecordSource   ZERO
35: *     Grade / grd            ZERO     ControlSource  ZERO
36: *
37: * Ou seja: nao ha o que listar. Inventar um PageFrame Lista/Dados com 6 botoes
38: * CRUD violaria o PILAR 1 e a regra "NUNCA inventar", e escrever
39: * metodo de pagina de Lista ou de alternancia que nao liste nada seria o "stub
40: * disfarcado" que a regra de completude proibe. Os botoes CRUD canonicos ficam
41: * em Left=542..932 (regra #10): num form de Width=550 seriam invisiveis e
42: * mortos. Dos 7 ramos do gate da Fase 4 o unico que se aplica eh o CAPTURA -
43: * sem lista pelo teste ESTRITO, com campo de ENTRADA (os 2 fwget, nenhum
44: * ReadOnly) e sem API de nos.
45: *
46: * NAO escrever aqui os nomes dos metodos do ramo PAGINADO: o gate da Fase 4
47: * casa o TEXTO CRU do .prg e nao distingue codigo de comentario, entao
48: * cita-los no proprio comentario que EXPLICA a ausencia deles faz o gate
49: * aprovar como PAGINADO - pelo motivo errado, escondendo que o ramo real eh o
50: * CAPTURA. Medido nesta task: com os nomes no comentario o gate dava

*-- Linhas 108 a 136:
108: * ABANDONO, o metodo de carga da LISTA, o par de habilitar/limpar campos e o
109: * ajuste de botoes POR MODO. Nenhum dos quatro tem referente aqui, e a medicao
110: * esta no mesmo lugar: o dump do SCX tem 12 objetos, com ZERO grid, ZERO
111: * pageframe, ZERO AddCursor e ZERO ControlSource (contagem no bloco da Fase 4,
112: * acima).
113: *
114: *   botao de abandono   O SCX tem UM UNICO CommandButton - o "ok", com
115: *                       Cancel = .T. -, e o Click dele eh "ThisForm.Release" e
116: *                       MAIS NADA. Isto eh: a tecla ESC aciona o PROPRIO botao
117: *                       de acao, e nao existe segundo botao que descarte
118: *                       alguma coisa. Nao ha o que descartar: este dialogo nao
119: *                       mantem registro em edicao e nao grava em tabela
120: *                       nenhuma (comportamento.json: zero INSERT/UPDATE/
121: *                       DELETE). O handler desse botao existe e esta entregue
122: *                       (BtnOkClick); batiza-lo de "abandono" faria o nome
123: *                       MENTIR sobre o que o metodo faz.
124: *
125: *   carga da lista      Nao ha grade NEM cursor de listagem. As duas unicas
126: *                       consultas do legado (get_codigo.Valid e
127: *                       get_descr.When) alimentam o PICKER e a decisao de
128: *                       editabilidade, nao uma lista na tela - e quem as
129: *                       executa eh o BO. Inventar um metodo de carga aqui
130: *                       criaria uma SEGUNDA fonte para a consulta que o BO
131: *                       ja faz.
132: *
133: *   habilitar campos    Nao ha MODO (incluir/alterar/visualizar) nesta tela:
134: *                       o dialogo so existe no estado de entrada. A unica
135: *                       regra de editabilidade que o legado tem eh o
136: *                       get_descr.When, e ela ja esta entregue, no metodo

*-- Linhas 1208 a 1226:
1208: 
1209:                 *-- Passo 2: browse do legado (fwBuscaSel)
1210:                 IF !loc_lFalhouConsulta AND USED(loc_cCursor)
1211:                     SELECT (loc_cCursor)
1212: 
1213:                     *-- Ordem do legado: o browse lista por Cods. A BO deixa o
1214:                     *-- cursor com DOIS tags (Cods e Descs) e o ultimo INDEX ON
1215:                     *-- fica controlando, entao a ordem tem de ser reposta aqui.
1216:                     SET ORDER TO TAG Cods
1217:                     GO TOP
1218: 
1219:                     *-- 4o argumento do fwBuscaSel legado era This.Value: ele
1220:                     *-- posiciona o browse no que foi digitado. Prefixo com
1221:                     *-- LEFT/== porque SET EXACT ON (config.prg) faz o "="
1222:                     *-- exigir a chave inteira. Nao achando prefixo, volta ao
1223:                     *-- topo - LOCATE sem FOUND() deixaria o ponteiro em EOF.
1224:                     IF !EMPTY(loc_cCodigo)
1225:                         LOCATE FOR LEFT(UPPER(ALLTRIM(Cods)), LEN(m.loc_cCodigo)) == UPPER(m.loc_cCodigo)
1226:                         IF !FOUND()

*-- Linhas 1502 a 1520:
1502:     *
1503:     * Legado:
1504:     *     lcCod = ThisForm.Get_codigo.Value
1505:     *     Select * From SigCdNcf Where cods = '<lcCod>'
1506:     *     Return (NOt Empty(lcCod) And CrSigCdNcf.Fixos = 2 )
1507:     *
1508:     * Isto NAO vira BINDEVENT: When nao eh evento ligavel, e o BINDEVENT
1509:     * DESCARTA o retorno do delegate - um "When" assim ligado nao bloquearia
1510:     * edicao nenhuma. O equivalente em runtime eh reconfigurar o campo, e eh
1511:     * por isso que este metodo roda na inicializacao (estado de abertura, com a
1512:     * semente de codigo que o chamador passou) e no fim do funil de lookup
1513:     * (unico lugar onde o codigo muda).
1514:     *
1515:     * ReadOnly + TabStop no lugar de Enabled: o "When = .F." do legado impede o
1516:     * FOCO mas NAO muda a aparencia do controle (ele continua habilitado).
1517:     * Enabled = .F. acrescentaria o fundo cinza de controle desabilitado, que o
1518:     * legado nao tem. Com ReadOnly = .T. + TabStop = .F. o campo sai do ciclo
1519:     * de Tab e nao aceita digitacao, mantendo as cores - divergencia residual:
1520:     * clique do mouse ainda posiciona o cursor nele, sem permitir alteracao.

*-- Linhas 1528 a 1546:
1528:     * Codigo vazio dispensa a consulta - o proprio legado curto-circuita com
1529:     * "Not Empty(lcCod)". E sem conexao viva (gnConnHandle = 0 no harness de
1530:     * teste, -1 no ValidarUIFidelity) o campo fica nao-editavel sem ir ao
1531:     * banco: SQLEXEC com handle invalido DISPARA EXCECAO, e gastar o CATCH da
1532:     * BO para redescobrir isso a cada abertura do form seria desperdicio.
1533:     *
1534:     * PUBLIC (sem PROTECTED): chamado de fora da cadeia de criacao (pelo funil
1535:     * de lookup) e candidato natural a alvo de BINDEVENT (regra #3).
1536:     *--------------------------------------------------------------------------
1537:     PROCEDURE AtualizarEstadoDescricao()
1538:         LOCAL loc_cCodigo, loc_lEditavel, loc_oErro
1539: 
1540:         TRY
1541:             loc_cCodigo   = ALLTRIM(THIS.txt_4c__codigo.Value)
1542:             loc_lEditavel = .F.
1543: 
1544:             *-- Legado: Return (Not Empty(lcCod) And CrSigCdNcf.Fixos = 2)
1545:             IF !EMPTY(loc_cCodigo)
1546:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0


### BO (C:\4c\projeto\app\classes\SigOpLibBO.prg):
*====================================================================
* SigOpLibBO.prg
*
* Business Object de SIGOPLIB - Liberacao de Peso
* (dialogo modal que escolhe o TIPO DE LIBERACAO a ser aplicado e
*  devolve ao form chamador o par codigo + descricao)
*
* Tabela principal : SigCdNcf - chave primaria cods
*
* Origem legado : SIGOPLIB.SCX
*                 tasks\task760\SIGOPLIB_form_codigo_fonte.txt
*
* Chamado por   : form pai que mantem o cursor de trabalho xNensi
*                 (itens da OP, vindos de SigCdNei). O Init do legado
*                 semeia o campo codigo com xNensi.CodnConfs, que eh
*                 SigCdNei.codnconfs char(10) - a MESMA largura de
*                 SigCdNcf.cods char(10).
*
* Consultas do legado espelhadas pelas propriedades abaixo:
*
*   get_codigo.Valid (lista de tipos permitidos ao _Tipo recebido)
*       Select * From SigCdNcf
*        Where (Emps = '<empresa>' Or Emps = ' ')
*          And <Tipos = <Tipo>  quando Tipo esta em (2, 3, 4)>
*          And <Tipos <= <Tipo> nos demais casos>
*       -> cursor CrSigCdNcf, indexado por Cods e por Descs
*
*   get_descr.When (a descricao so eh digitavel em tipo NAO fixo)
*       Select * From SigCdNcf Where cods = '<codigo digitado>'
*       Return (Not Empty(codigo) And CrSigCdNcf.Fixos = 2)
*
* ATENCAO a coluna de empresa (regra #48 do CLAUDE.md): em SigCdNcf
* ela eh "emps", SEM o C inicial - conferido em docs/schema.sql, e eh
* a mesma grafia que o legado usa no Where. NAO trocar por "cemps"
* por analogia com as tabelas mestre: o prefixo da tabela nao decide.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigOpLibBO AS BusinessBase

    *----------------------------------------------------------------
    * Colunas de SigCdNcf (entidade consultada por esta tela)
    * Tipos conferidos em docs/schema.sql:
    *   cods   char(10)      NOT NULL  - PRIMARY KEY sigcdncf_cods
    *   descs  char(60)      NOT NULL
    *   fixos  numeric(1, 0) NOT NULL
    *   tipos  numeric(1, 0) NOT NULL
    *   emps   char(3)       NOT NULL
    *----------------------------------------------------------------

    *-- cods char(10) - codigo do tipo de liberacao (chave primaria).
    *-- Alimenta o Get_codigo da tela e eh a 1a metade do valor que o
    *-- dialogo devolve ao chamador.
    this_cCods = ""

    *-- descs char(60) - descricao do tipo de liberacao.
    *-- Alimenta o Get_descr e eh a 2a metade do valor devolvido.
    *-- Em tipo FIXO (fixos <> 2) o texto vem da tabela; em tipo NAO
    *-- fixo (fixos = 2) o proprio usuario digita, por isso o When do
    *-- Get_descr do legado libera o campo apenas nesse caso.
    this_cDescs = ""

    *-- fixos numeric(1, 0) - decide a origem da descricao.
    *-- NUMERICA de proposito: o legado compara com os literais 2
    *-- ("Fixos <> 2" no Valid do codigo e "Fixos = 2" no When da
    *-- descricao), e coluna numeric(1,0) de mais de uma opcao NAO eh
    *-- booleana - achatar em logico gravaria/leria valor errado.
    this_nFixos = 0

    *-- tipos numeric(1, 0) - faixa de aplicacao do tipo de liberacao.
    *-- Eh a coluna comparada contra o parametro de abertura
    *-- (this_nTipoFiltro) no Where da consulta do Get_codigo.
    *-- NUMERICA pelo mesmo motivo de this_nFixos.
    this_nTipos = 0

    *-- emps char(3) - empresa dona do tipo de liberacao.
    *-- O legado aceita DOIS valores no filtro: a empresa corrente OU
    *-- um unico espaco (" "), que marca o tipo valido para todas as
    *-- empresas - as duas pernas do Or tem de ser transcritas juntas,
    *-- senao os tipos globais desaparecem da lista.
    this_cEmps = ""

    *----------------------------------------------------------------
    * Parametro de abertura do dialogo
    *----------------------------------------------------------------

    *-- ThisForm.Tipo do legado, recebido como _Tipo no Init:
    *--     Tipo = Iif(Type("_Tipo") # 'N', 0, _Tipo)
    *-- ou seja, parametro ausente ou nao-numerico vale ZERO.
    *--
    *-- NOME PROPOSITALMENTE DISTINTO de this_nTipos (a coluna): os
    *-- dois numeros se encontram na MESMA comparacao do Where, e um
    *-- par de nomes separado por uma unica letra convida ao erro de
    *-- digitacao que o compilador nao pega.
    *--
    *-- Governa qual das duas comparacoes entra no Where:
    *--     Tipo em (2, 3, 4)  ->  Tipos =  Tipo   (so a faixa exata)
    *--     qualquer outro     ->  Tipos <= Tipo   (faixa acumulada)
    this_nTipoFiltro = 0

    *-- Semente do campo codigo: no legado,
    *--     ThisForm.Get_codigo.Value = xNensi.CodnConfs
    *-- lida da linha corrente do cursor de trabalho do form PAI.
    *-- Guardada aqui para o form migrado nao depender de cursor
    *-- global do legado, que o sistema novo nao pre-carrega.
    this_cCodigoInicial = ""

    *----------------------------------------------------------------
    * Resultado devolvido ao form chamador
    *----------------------------------------------------------------

    *-- ThisForm.Retorno do legado, que o Unload devolve ao chamador:
    *--     Init                 -> Space(10)
    *--     Valid do codigo      -> cods + Descs   (quando Fixos <> 2)
    *--     Valid da descricao   -> Get_codigo.Value + Get_descr.Value
    *--
    *-- Eh concatenacao POSICIONAL (codigo de 10 + descricao), entao o
    *-- padding do codigo faz parte do valor: montar com PADR sobre a
    *-- largura do schema, nunca com ALLTRIM nas partes (regra #42).
    this_cRetorno = ""

    *----------------------------------------------------------------
    * Estado da ultima consulta
    *----------------------------------------------------------------

    *-- Resultado do "Seek(This.Value, 'CrSigCdNcf', 'Cods')" do
    *-- legado: fica .T. quando o codigo digitado existe na lista
    *-- filtrada, e eh o que decide se o dialogo de escolha precisa
    *-- ser aberto. Eh estado de SESSAO - o dialogo migrado nao fecha
    *-- entre uma consulta e a seguinte, logo tem de ser reposto no
    *-- inicio de cada carga, nunca acumulado.
    this_lRegistroEncontrado = .F.

    *-- Alias do cursor que recebe a lista filtrada de SigCdNcf
    *-- (CrSigCdNcf no legado). Centralizado numa propriedade para que
    *-- carga, indexacao, busca e fechamento usem o MESMO nome.
    this_cCursorNcf = "cursor_4c_SigCdNcf"

    *====================================================================
    * Init - Inicializa o Business Object
    *
    * DODEFAULT() primeiro: eh ele que instancia o DataAccess e zera os
    * flags de edicao da BusinessBase.
    *
    * this_cTabela / this_cCampoChave usam a grafia EXATA do schema
    * (SigCdNcf / cods) - PILAR 2.
    *
    * this_cRetorno nasce com SPACE(10), igual ao "ThisForm.Retorno =
    * Space(10)" do Init legado: dez espacos sao a largura de cods, e eh
    * esse valor que o chamador recebe quando o usuario fecha o dialogo
    * sem escolher nada. A atribuicao fica AQUI e nao no cabecalho da
    * classe porque inicializador de propriedade em DEFINE CLASS aceita
    * constante, nao chamada de funcao.
    *
    * RETURN fica FORA do TRY/CATCH (regra #1): dentro do bloco usa-se a
    * flag loc_lSucesso.
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()

            THIS.this_cTabela     = "SigCdNcf"
            THIS.this_cCampoChave = "cods"

            *-- Alias da lista filtrada de tipos de liberacao
            THIS.this_cCursorNcf = "cursor_4c_SigCdNcf"

            *-- Colunas da entidade em estado inicial
            THIS.this_cCods  = ""
            THIS.this_cDescs = ""
            THIS.this_nFixos = 0
            THIS.this_nTipos = 0
            THIS.this_cEmps  = ""

            *-- Parametro de abertura: sem chamador, vale ZERO, o que
            *-- deixa o Where na perna "Tipos <= 0"
            THIS.this_nTipoFiltro    = 0
            THIS.this_cCodigoInicial = ""

            *-- Retorno vazio = dez espacos (largura de cods)
            THIS.this_cRetorno = SPACE(10)

            *-- Estado de sessao da consulta
            THIS.this_lRegistroEncontrado = .F.

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SigOpLibBO.Init")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia uma linha de cursor_4c_SigCdNcf (ou
    * qualquer alias com as mesmas colunas de SigCdNcf) para as
    * propriedades desta BO.
    *
    * SELECT (par_cAliasCursor) + acesso direto aos campos. NUNCA alcancar
    * o campo escrevendo o nome da VARIAVEL de alias entre parenteses e
    * ponto antes do nome da coluna: eh sintaxe invalida em VFP9
    * (Problema 9) e estoura "Function name is missing )".
    *
    * A frase acima descreve a forma proibida em palavras em vez de
    * mostra-la: o CorretorAutomatico eh comment-blind e o pattern que
    * conserta esse defeito casa o TEXTO CRU do .prg - escrita por extenso,
    * a forma errada era MUTILADA dentro deste proprio comentario a cada
    * sweep (medido em 2026-11-08), e o comentario deixava de ensinar a
    * regra que existe para ensinar.
    *
    * TratarNulo recebe o VALOR PADRAO do tipo da coluna (nao um codigo
    * de tipo): "" para char, 0 para numeric.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_cCods  = TratarNulo(cods, "")
                THIS.this_cDescs = TratarNulo(descs, "")
                THIS.this_nFixos = TratarNulo(fixos, 0)
                THIS.this_nTipos = TratarNulo(tipos, 0)
                THIS.this_cEmps  = TratarNulo(emps, "")
                loc_lSucesso = .T.
            ENDIF
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - chave primaria de SigCdNcf eh cods.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCods)
    ENDPROC

    *====================================================================
    * Inserir() / Atualizar() / ExecutarExclusao() / RegistrarAuditoria()
    * NAO sao sobrescritos nesta BO.
    *
    * O SIGOPLIB.SCX legado nunca grava em SigCdNcf: o Init so CONSULTA a
    * tabela (get_codigo.Valid e get_descr.When sao os dois unicos pontos
    * que tocam o banco, e ambos sao SELECT). SigCdNcf eh mantida por
    * outro cadastro (Natureza/Classificacao Fiscal); este dialogo apenas
    * escolhe um tipo ja existente e devolve o par codigo+descricao ao
    * form chamador via this_cRetorno.
    *
    * Por isso o comportamento padrao herdado de BusinessBase (recusar a
    * operacao, preenchendo this_cMensagemErro) ja eh o correto aqui -
    * nao ha SQL de INSERT/UPDATE/DELETE para reproduzir, e inventar um
    * violaria o PILAR 2 (schema identico, sem gravacoes alem das que o
    * legado faz). RegistrarAuditoria tambem nao se aplica, porque so eh
    * chamada apos Inserir/Atualizar/ExecutarExclusao terem sucesso.
    *====================================================================

    *====================================================================
    * CarregarTiposPermitidos - espelha o SELECT do get_codigo.Valid:
    *
    *   Select * From SigCdNcf
    *    Where (Emps = '<empresa>' Or Emps = ' ')
    *      And <Tipos = <Tipo>  quando Tipo esta em (2, 3, 4)>
    *      And <Tipos <= <Tipo> nos demais casos>
    *
    * Recarrega this_cCursorNcf do zero a cada chamada (o legado tambem
    * reexecuta o SQLEXECUTE a cada Valid) e indexa por Cods e por Descs,
    * igual ao "Index On Cods tag Cods" / "Index On Descs tag descs" do
    * legado - necessario para o SEEK de ValidarCodigoDigitado e para a
    * ordenacao do picker que o form abrira quando nao achar o codigo.
    *====================================================================
    PROCEDURE CarregarTiposPermitidos()
        LOCAL loc_cSQL, loc_cCondTipos, loc_nResultado, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        *-- Limpa a mensagem ANTES de tentar: eh ela que o form usa para
        *-- distinguir "a consulta FALHOU" de "o codigo nao existe no universo
        *-- filtrado" - os dois casos devolvem .F. aqui. Mensagem sobrando de
        *-- uma chamada anterior faria o funil de lookup reportar erro de um
        *-- SELECT que desta vez funcionou.
        *--
        *-- loc_oErro declarado no LOCAL acima: sem a declaracao, o CATCH TO
        *-- cria a variavel como PRIVATE e ela VAZA para quem chamou.
        THIS.this_cMensagemErro = ""

        TRY
            IF USED(THIS.this_cCursorNcf)
                USE IN (THIS.this_cCursorNcf)
            ENDIF

            IF INLIST(THIS.this_nTipoFiltro, 2, 3, 4)
                loc_cCondTipos = "Tipos = " + FormatarNumeroSQL(THIS.this_nTipoFiltro, 0)
            ELSE
                loc_cCondTipos = "Tipos <= " + FormatarNumeroSQL(THIS.this_nTipoFiltro, 0)
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdNcf " + ;
                "WHERE (Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                " OR Emps = " + EscaparSQL(" ") + ") " + ;
                "AND " + loc_cCondTipos

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorNcf)

            IF loc_nResultado >= 0 AND USED(THIS.this_cCursorNcf)
                SELECT (THIS.this_cCursorNcf)
                INDEX ON Cods  TAG Cods
                INDEX ON Descs TAG Descs
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar tipos de libera" + CHR(231) + CHR(227) + "o: " + CapturarErroSQL()
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarCodigoDigitado - espelha o restante do get_codigo.Valid:
    *
    *   If Not Seek(This.Value, 'CrSigCdNcf', 'Cods')
    *       <abre o picker - responsabilidade do FORM, nao desta BO>
    *   Endif
    *   This.Value = CrSigCdNcf.Cods
    *   If CrSigCdNcf.Fixos <> 2
    *       ThisForm.Get_descr.Value = CrSigCdNcf.Descs
    *       ThisForm.Retorno = CrSigCdNcf.cods + CrSigCdNcf.Descs
    *   Endif
    *
    * Recarrega o universo filtrado (CarregarTiposPermitidos) e faz o
    * SEEK por Cods. Achando, atualiza this_cCods/this_cDescs/this_nFixos
    * /this_nTipos/this_cEmps a partir da linha encontrada e, quando o
    * tipo NAO eh de descricao livre (Fixos <> 2), ja monta o retorno
    * final. Quando Fixos = 2, quem monta o retorno eh
    * ConfirmarDescricaoDigitada, quando o usuario validar a descricao.
    *
    * Retorna .T./.F. (achou/nao achou) para o form decidir se abre o
    * picker (fwBuscaSel/FormBuscaAuxiliar sobre THIS.this_cCursorNcf).
    *====================================================================
    FUNCTION ValidarCodigoDigitado(par_cCodigo)
        LOCAL loc_cCodigo, loc_lAchou
        loc_lAchou = .F.
        THIS.this_lRegistroEncontrado = .F.

        loc_cCodigo = ALLTRIM(NVL(par_cCodigo, ""))

        IF EMPTY(loc_cCodigo)
            RETURN .F.
        ENDIF

        IF !THIS.CarregarTiposPermitidos()
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorNcf)

        *-- PADR ate a largura da COLUNA - SigCdNcf.cods eh char(10) no schema.
        *-- Sem o padding este SEEK NUNCA acha: o config.prg faz SET EXACT ON
        *-- (linha 242) e, sob EXACT ON, o SEEK exige que a expressao tenha o
        *-- tamanho da chave do indice (INDEX ON Cods = 10 chars) - procurar
        *-- "01" numa chave "01        " devolve .F., sem erro e sem log.
        *--
        *-- O legado nao sofria disso por DOIS motivos: rodava com o SET EXACT
        *-- OFF default do VFP, onde o SEEK casa por PREFIXO, e passava
        *-- This.Value, vindo de um campo com InputMask de 10 posicoes.
        *--
        *-- Sintoma de nao padear: o usuario digita um codigo VALIDO, sai do
        *-- campo e o picker abre do mesmo jeito - sempre, para todo codigo com
        *-- menos de 10 caracteres.
        loc_lAchou = SEEK(PADR(loc_cCodigo, 10), THIS.this_cCursorNcf, "Cods")

        IF loc_lAchou
            THIS.this_lRegistroEncontrado = .T.
            THIS.CarregarDoCursor(THIS.this_cCursorNcf)
            THIS.FecharRetornoDoTipo()
        ENDIF

        RETURN loc_lAchou
    ENDFUNC

    *====================================================================
    * FecharRetornoDoTipo - bloco "If CrSigCdNcf.Fixos <> 2" do
    * get_codigo.Valid legado, na parte que monta o RETORNO:
    *
    *   If CrSigCdNcf.Fixos <> 2
    *       ThisForm.Retorno = CrSigCdNcf.cods + CrSigCdNcf.Descs
    *   Endif
    *
    * Extraido para metodo proprio porque o legado alcanca este mesmo bloco
    * por DOIS caminhos - o Seek que acerta de primeira e a linha que o
    * usuario escolhe no browse -, e no legado os dois executam o MESMO
    * trecho (o browse apenas reposiciona o cursor; a atribuicao que vem
    * depois dele eh uma so). Com a regra de negocio em UM lugar, o form
    * nao precisa reescrever a conta: ele chama este metodo e depois
    * espelha o resultado na tela. Totais/valores derivados tem FONTE
    * UNICA - o BO calcula, o form so exibe.
    *
    * Fixos = 2 (descricao LIVRE) nao mexe no retorno DE PROPOSITO: nesse
    * caso quem o fecha eh ConfirmarDescricaoDigitada, quando o usuario
    * validar a descricao que digitou. Eh o que o legado faz.
    *
    * Concatenacao POSICIONAL (regra #42): this_cCods e this_cDescs vem de
    * cods char(10) / descs char(60) e chegam PADDED do SQL Server - somar
    * os valores CRUS eh exatamente o "CrSigCdNcf.cods + CrSigCdNcf.Descs"
    * do legado. NUNCA ALLTRIM nas partes.
    *
    * PUBLIC (sem PROTECTED): o form chama este metodo de FORA, no caminho
    * em que a linha veio do picker - e metodo protegido em QUALQUER nivel
    * da heranca estoura "Property FECHARRETORNODOTIPO is not found" ao ser
    * chamado de fora (regra #51).
    *====================================================================
    FUNCTION FecharRetornoDoTipo()
        IF THIS.this_nFixos <> 2
            THIS.this_cRetorno = THIS.this_cCods + THIS.this_cDescs
        ENDIF

        RETURN THIS.this_cRetorno
    ENDFUNC

    *====================================================================
    * VerificarDescricaoEditavel - espelha o get_descr.When:
    *
    *   lcCod = ThisForm.Get_codigo.Value
    *   Select * From SigCdNcf Where cods = '<lcCod>'
    *   Return (Not Empty(lcCod) And CrSigCdNcf.Fixos = 2)
    *
    * Consulta NAO FILTRADA por empresa/tipo (so por cods) - por isso usa
    * um cursor temporario proprio, sem tocar em this_cCursorNcf (que
    * continua sendo o universo filtrado do picker). Decide se o campo
    * de descricao do form pode ser digitado (Fixos = 2) ou fica
    * read-only com o texto que vier da tabela.
    *====================================================================
    FUNCTION VerificarDescricaoEditavel(par_cCodigo)
        LOCAL loc_cCodigo, loc_cSQL, loc_nResultado, loc_lEditavel, loc_oErro
        loc_lEditavel = .F.

        *-- Mesma razao de CarregarTiposPermitidos: mensagem limpa na entrada e
        *-- loc_oErro declarado para o CATCH TO nao criar PRIVATE que vaza.
        THIS.this_cMensagemErro = ""

        loc_cCodigo = ALLTRIM(NVL(par_cCodigo, ""))

        IF EMPTY(loc_cCodigo)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_SigCdNcfTmp")
                USE IN cursor_4c_SigCdNcfTmp
            ENDIF

            loc_cSQL = "SELECT * FROM SigCdNcf WHERE cods = " + EscaparSQL(loc_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdNcfTmp")

            IF loc_nResultado >= 0 AND USED("cursor_4c_SigCdNcfTmp")
                SELECT cursor_4c_SigCdNcfTmp
                IF !EOF()
                    loc_lEditavel = (TratarNulo(fixos, 0) = 2)
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigCdNcfTmp")
                USE IN cursor_4c_SigCdNcfTmp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lEditavel = .F.
        ENDTRY

        RETURN loc_lEditavel
    ENDFUNC

    *====================================================================
    * ConfirmarDescricaoDigitada - espelha o get_descr.Valid:
    *
    *   If Not Empty(This.Value)
    *       ThisForm.Retorno = ThisForm.Get_codigo.Value + ThisForm.get_descr.Value
    *   EndIf
    *
    * Concatenacao POSICIONAL (regra #42): this_cCods, vindo do SEEK em
    * cursor_4c_SigCdNcf (coluna cods char(10) do SQL Server), ja chega
    * com a largura de 10 - PADR aqui eh so defesa para o caso de
    * this_cCods ter sido preenchido por outro caminho sem o padding.
    *====================================================================
    FUNCTION ConfirmarDescricaoDigitada(par_cDescricaoDigitada)
        LOCAL loc_cDescricao
        loc_cDescricao = ALLTRIM(NVL(par_cDescricaoDigitada, ""))

        IF !EMPTY(loc_cDescricao)
            THIS.this_cDescs   = par_cDescricaoDigitada
            THIS.this_cRetorno = PADR(THIS.this_cCods, 10) + THIS.this_cDescs
        ENDIF

        RETURN THIS.this_cRetorno
    ENDFUNC

ENDDEFINE

