# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CPROS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNBOT
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DEPO' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LNBOT

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
		lcSql = [Select ClockEcfs From SigCdPac ]
		ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac')
			.Column1.ControlSource = 'CrProduto.Cpros'
			.Column2.ControlSource = 'CrProduto.Dpros'
		Select CrProduto
	Select CrProduto
Select CrProduto

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGPRTRF.prg) - TRECHOS RELEVANTES PARA PASS SQL (1374 linhas total):

*-- Linhas 87 a 120:
87:             RETURN .F.
88:         ENDIF
89: 
90:         *-- Equivalente ao SQLEXEC de LocalParac no Init do legado (parametro
91:         *-- de tempo de espera usado na animacao de confirmacao do botao Ok)
92:         IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
93:             THIS.this_oBusinessObject.CarregarParametroTempoEspera()
94:         ENDIF
95: 
96:         *-- Equivalente ao "Create Cursor CrProduto" do Load legado - tem
97:         *-- de existir ANTES do Grid ser ligado a ele (regra do ControlSource
98:         *-- de cursor ainda inexistente derrubando o Init)
99:         THIS.CriarCursorProdutos()
100: 
101:         THIS.ConfigurarContainerReferencia()
102: 
103:         *-- Vincula a grade ao cursor e a repinta - equivalente ao bloco
104:         *-- "With Thisform.Cnt_Referencia.Grade / .RecordSource /
105:         *-- .ControlSource / .Refresh / EndWith" do Init legado. Fica em
106:         *-- metodo proprio para poder ser rechamado em TODO caminho que
107:         *-- recria ou repopula o cursor da grade.
108:         THIS.CarregarLista()
109: 
110:         *-- sigprtrf.oModem (OLE 100x100, Secao 1 do dump) nao tem nenhum
111:         *-- metodo/evento no dump (Secao 3) nem referencia em Secao 4 alem
112:         *-- do proprio form - objeto decorativo sem comportamento algum,
113:         *-- por isso omitido aqui; nenhuma funcionalidade do dialogo
114:         *-- depende dele (Ok/Cancelar e a grade nao o referenciam).
115:         THIS.ConfigurarBotoesPrincipais()
116: 
117:         THIS.ConfigurarContainerMensagem()
118: 
119:         THIS.TornarControlesVisiveis(THIS)
120: 

*-- Linhas 182 a 211:
182: 
183:     *====================================================================
184:     * CriarCursorProdutos - Cria o cursor local que alimenta a grade de
185:     * selecao de produtos (equivalente ao "Create Cursor CrProduto" do
186:     * Load legado) e inicia com uma linha vazia, pronta para digitacao
187:     * (equivalente ao "Select CrProduto / Append Blank" do Init legado).
188:     *====================================================================
189:     PROTECTED PROCEDURE CriarCursorProdutos()
190:         IF USED("cursor_4c_Produtos")
191:             USE IN cursor_4c_Produtos
192:         ENDIF
193: 
194:         CREATE CURSOR cursor_4c_Produtos (Cpros C(14), Dpros C(40))
195: 
196:         SELECT (THIS.this_cCursorGrade)
197:         APPEND BLANK
198:     ENDPROC
199: 
200:     *====================================================================
201:     * ConfigurarContainerReferencia - Cria o container principal (ja
202:     * existente desde a Fase 3) e adiciona seus filhos visuais: label de
203:     * identificacao e grade de produtos (Fase 4).
204:     *====================================================================
205:     PROTECTED PROCEDURE ConfigurarContainerReferencia()
206:         THIS.AddObject("cnt_4c__Referencia", "Container")
207:         WITH THIS.cnt_4c__Referencia
208:             .Top         = 1
209:             .Left        = 2
210:             .Width       = 433
211:             .Height      = 392

*-- Linhas 491 a 509:
491:                 ENDIF
492: 
493:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProdutoTrf") AND RECCOUNT("cursor_4c_BuscaProdutoTrf") > 0
494:                     SELECT cursor_4c_BuscaProdutoTrf
495: 
496:                     *-- Produto escolhido entra no BO e sai dele para a linha
497:                     *-- da grade por BOParaForm(), que concentra as TRES
498:                     *-- atribuicoes do legado (cursor.Dpros, This.Value da
499:                     *-- celula do Codigo e Column2.Text1.Value). Fonte unica:
500:                     *-- este caminho e o do Valid gravam pelo MESMO metodo.
501:                     THIS.this_oBusinessObject.this_cCodigoProduto    = ALLTRIM(NVL(cpros, ""))
502:                     THIS.this_oBusinessObject.this_cDescricaoProduto = ALLTRIM(NVL(dpros, ""))
503: 
504:                     THIS.BOParaForm()
505:                 ENDIF
506: 
507:                 loc_oBusca.Release()
508:             ENDIF
509:         CATCH TO loc_oErro

*-- Linhas 575 a 593:
575:             RETURN
576:         ENDIF
577: 
578:         SELECT (THIS.this_cCursorGrade)
579: 
580:         IF EMPTY(cpros)
581:             THIS.cmd_4c_Altera.SetFocus()
582:         ELSE
583:             loc_nRecnoAtual = RECNO()
584: 
585:             LOCATE FOR EMPTY(cpros)
586:             IF EOF()
587:                 APPEND BLANK
588:             ENDIF
589: 
590:             LOCATE FOR RECNO() = loc_nRecnoAtual
591:             KEYBOARD "{DNARROW}"
592:         ENDIF
593:     ENDPROC

*-- Linhas 733 a 751:
733:     * do legado: "Count to x for Not Empty(Cpros) / If x=0"), exibe a
734:     * animacao de confirmacao e fecha o dialogo com this_cRetorno = "Ok".
735:     *
736:     *   Select CrProduto
737:     *   Count to x for Not Empty(Cpros)
738:     *   If x=0
739:     *       MessageBox('Nenhum Produto Informado!!!',0+16,'')
740:     *       Return .f.
741:     *   Endif
742:     *   ... animacao ...
743:     *   ThisForm.Retorno = 'Ok'
744:     *   ThisForm.Release
745:     *
746:     * PUBLIC: ligado por BINDEVENT em ConfigurarBotoesPrincipais.
747:     *====================================================================
748:     PROCEDURE BtnOkClick()
749:         LOCAL loc_nQtde
750: 
751:         *-- Reentrancia: a animacao chama DOEVENTS, entao um segundo clique

*-- Linhas 932 a 974:
932:     * Este dialogo nao tem campos soltos: a unica superficie de dados eh a
933:     * grade, e as duas colunas dela (Cpros/Dpros) sao exatamente as duas
934:     * propriedades do BO (this_cCodigoProduto/this_cDescricaoProduto). O
935:     * equivalente do legado eh o par de ControlSource que o Init declara
936:     * ('CrProduto.Cpros' / 'CrProduto.Dpros') - com ControlSource o VFP
937:     * transfere sozinho, e sem ele a transferencia tem de ser escrita.
938:     *
939:     * O valor digitado na celula do Codigo so chega ao CURSOR depois do
940:     * Valid (regra #46), entao a celula ativa tem precedencia sobre o
941:     * cursor enquanto o usuario ainda esta dentro dela - do contrario o
942:     * BO receberia o valor ANTERIOR da linha.
943:     *
944:     * A lista final de codigos (this_cListaProdutos) continua sendo
945:     * montada pelo BO varrendo o cursor INTEIRO em MontarListaProdutos(),
946:     * porque ela nao eh dado de uma linha e sim o resultado do dialogo.
947:     *====================================================================
948:     PROCEDURE FormParaBO()
949:         LOCAL loc_oCelula
950: 
951:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
952:             RETURN .F.
953:         ENDIF
954: 
955:         IF !USED(THIS.this_cCursorGrade)
956:             RETURN .F.
957:         ENDIF
958: 
959:         SELECT (THIS.this_cCursorGrade)
960: 
961:         IF EOF() OR BOF()
962:             RETURN .F.
963:         ENDIF
964: 
965:         THIS.this_oBusinessObject.this_cCodigoProduto    = ALLTRIM(NVL(Cpros, ""))
966:         THIS.this_oBusinessObject.this_cDescricaoProduto = ALLTRIM(NVL(Dpros, ""))
967: 
968:         *-- Celula ativa do Codigo tem precedencia: dentro do Valid o
969:         *-- digitado esta nela e ainda nao foi gravado no cursor
970:         loc_oCelula = THIS.ObterCelulaCodigo()
971: 
972:         IF VARTYPE(loc_oCelula) = "O" AND !EMPTY(ALLTRIM(loc_oCelula.Value))
973:             THIS.this_oBusinessObject.this_cCodigoProduto = ALLTRIM(loc_oCelula.Value)
974:         ENDIF

*-- Linhas 1003 a 1021:
1003:             RETURN .F.
1004:         ENDIF
1005: 
1006:         SELECT (THIS.this_cCursorGrade)
1007: 
1008:         IF EOF() OR BOF()
1009:             RETURN .F.
1010:         ENDIF
1011: 
1012:         REPLACE Cpros WITH THIS.this_oBusinessObject.this_cCodigoProduto, ;
1013:                 Dpros WITH THIS.this_oBusinessObject.this_cDescricaoProduto ;
1014:                 IN (THIS.this_cCursorGrade)
1015: 
1016:         loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
1017: 
1018:         *-- "This.Value = ..." do legado: o codigo escolhido tem de voltar
1019:         *-- para a CELULA tambem, senao o texto digitado sobrescreve o
1020:         *-- cursor quando o foco sair dela (regra #46)
1021:         loc_oCelula = THIS.ObterCelulaCodigo()

*-- Linhas 1100 a 1145:
1100:     * unica linha em branco, pronta para digitacao.
1101:     *
1102:     * Equivale ao par que o legado executa ao abrir a tela - o
1103:     * "Create Cursor CrProduto (Cpros c(14), dpros c(40))" do Load mais o
1104:     * "Select CrProduto / Append Blank" do Init - e eh o override do hook
1105:     * de mesmo nome do FormBase, que o chama em Novo()/Excluir()/
1106:     * Cancelar(). Zera tambem o snapshot do codigo anterior, senao o
1107:     * Valid da primeira celula compararia o valor novo com o da sessao
1108:     * descartada e nao abriria o lookup.
1109:     *
1110:     * ZAP (e nao USE IN + CREATE CURSOR) de proposito: ele preserva a
1111:     * estrutura do cursor e, com ela, o RecordSource do Grid e os
1112:     * ControlSource das duas colunas. Derrubar o alias deixaria a grade
1113:     * permanentemente vazia com o cursor cheio.
1114:     *
1115:     * SET SAFETY eh escopado por DATA SESSION, e este form eh
1116:     * DataSession = 2: o "SET SAFETY OFF" do main.prg NAO alcanca a sessao
1117:     * privada, onde SAFETY vale ON. Sem o par salvar/restaurar abaixo o ZAP
1118:     * abre o dialogo modal "Zap ... Are you sure?" e CONGELA a tela,
1119:     * esperando um clique que ninguem ve.
1120:     *====================================================================
1121:     PROCEDURE LimparCampos()
1122:         LOCAL loc_cSafety
1123: 
1124:         IF !USED(THIS.this_cCursorGrade)
1125:             THIS.CriarCursorProdutos()
1126:         ELSE
1127:             loc_cSafety = SET("SAFETY")
1128:             SET SAFETY OFF
1129: 
1130:             SELECT (THIS.this_cCursorGrade)
1131:             ZAP
1132:             APPEND BLANK
1133: 
1134:             IF loc_cSafety = "ON"
1135:                 SET SAFETY ON
1136:             ENDIF
1137:         ENDIF
1138: 
1139:         THIS.this_cCodigoAnterior = ""
1140: 
1141:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1142:             THIS.this_oBusinessObject.this_cCodigoProduto    = ""
1143:             THIS.this_oBusinessObject.this_cDescricaoProduto = ""
1144:             THIS.this_oBusinessObject.this_cListaProdutos    = ""
1145:         ENDIF

*-- Linhas 1262 a 1335:
1262:     * Transcricao do bloco do Init legado:
1263:     *     With Thisform.Cnt_Referencia.Grade
1264:     *         .RecordSource          = 'CrProduto'
1265:     *         .Column1.ControlSource = 'CrProduto.Cpros'
1266:     *         .Column2.ControlSource = 'CrProduto.Dpros'
1267:     *         .Refresh
1268:     *     EndWith
1269:     *     Select CrProduto
1270:     *     Append Blank
1271:     *
1272:     * Metodo UNICO de vinculo/repintura: tem de ser chamado em todo
1273:     * caminho que recria ou repopula cursor_4c_Produtos, porque popular o
1274:     * cursor NAO repinta a grade por si so - ela fica visualmente vazia
1275:     * com o cursor cheio. PUBLIC de proposito: o harness de teste
1276:     * automatizado chama THIS.oForm.CarregarLista() de fora da classe.
1277:     *====================================================================
1278:     PROCEDURE CarregarLista()
1279:         LOCAL loc_oGrade, loc_lSucesso, loc_oErro
1280:         loc_lSucesso = .F.
1281: 
1282:         TRY
1283:             *-- O cursor tem de existir ANTES do ControlSource: atribuir
1284:             *-- ControlSource de alias inexistente derruba o Init.
1285:             IF !USED(THIS.this_cCursorGrade)
1286:                 THIS.CriarCursorProdutos()
1287:             ENDIF
1288: 
1289:             *-- Linha em branco para digitar, como o "Append Blank" do Init
1290:             *-- legado: sem ela a grade abre sem nenhuma celula editavel.
1291:             IF RECCOUNT(THIS.this_cCursorGrade) = 0
1292:                 SELECT (THIS.this_cCursorGrade)
1293:                 APPEND BLANK
1294:             ENDIF
1295: 
1296:             loc_oGrade = THIS.cnt_4c__Referencia.grd_4c_Dados
1297: 
1298:             WITH loc_oGrade
1299:                 *-- O ColumnCount cai a 0 quando o alias da grade eh
1300:                 *-- derrubado (medido no VFP9): sem repor, .ColumnN nao
1301:                 *-- existe e o vinculo logo abaixo estoura.
1302:                 IF .ColumnCount != 2
1303:                     .ColumnCount = 2
1304:                 ENDIF
1305: 
1306:                 .RecordSource          = THIS.this_cCursorGrade
1307:                 .Column1.ControlSource = THIS.this_cCursorGrade + ".Cpros"
1308:                 .Column2.ControlSource = THIS.this_cCursorGrade + ".Dpros"
1309:             ENDWITH
1310: 
1311:             *-- Formato das colunas DEPOIS do vinculo: se o ColumnCount
1312:             *-- teve de ser reposto, os objetos Column nasceram de novo
1313:             *-- com o default do VFP9 e perderam Format, InputMask,
1314:             *-- fontes, Movable/Resizable, largura, Caption do cabecalho e
1315:             *-- o ReadOnly da coluna da Descricao
1316:             THIS.AplicarFormatoColunas()
1317: 
1318:             *-- "Go Top" + Refresh do legado: sem isso a grade fica
1319:             *-- visualmente vazia mesmo com o cursor populado
1320:             SELECT (THIS.this_cCursorGrade)
1321:             GO TOP
1322:             loc_oGrade.Refresh()
1323: 
1324:             loc_lSucesso = .T.
1325:         CATCH TO loc_oErro
1326:             MsgErro("Erro ao carregar a grade de produtos:" + CHR(13) + ;
1327:                     loc_oErro.Message + CHR(13) + ;
1328:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1329:                     "Procedure: " + loc_oErro.Procedure, "Erro")
1330:         ENDTRY
1331: 
1332:         RETURN loc_lSucesso
1333:     ENDPROC
1334: 
1335:     *====================================================================


### BO (C:\4c\projeto\app\classes\SIGPRTRFBO.prg):
*====================================================================
* SIGPRTRFBO.prg
*
* Business Object para Relacao de Produtos (Transferencia)
* Tabelas: SigCdPro (validacao/lookup de produto), SigCdPac (parametro ClockEcfs)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGPRTRFBO AS BusinessBase

    *-- Propriedades da entidade (produto sendo incluido na relacao)
    this_cCodigoProduto    = ""    && SigCdPro.cpros char(14) - PK
    this_cDescricaoProduto = ""    && SigCdPro.dpros char(40)

    *-- Propriedade de parametro de sistema (usada no aguarde de confirmacao)
    this_nTempoEspera = 0          && SigCdPac.ClockEcfs numeric

    *-- Propriedade de resultado (lista de codigos de produto separados por virgula)
    this_cListaProdutos = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPro"
            THIS.this_cCampoChave = "cpros"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGPRTRFBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * SIGPRTRF eh um dialogo de selecao (sem INSERT/UPDATE/DELETE no
    * legado): o Click do botao "Ok" so conta/monta a lista de produtos
    * informados na grade (THIS.MontarListaProdutos) e fecha o form com
    * ThisForm.Retorno = 'Ok'. Inserir()/Atualizar()/ExecutarExclusao()
    * NAO sao sobrescritos aqui - o comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto, porque este BO
    * nao grava em tabela nenhuma; quem persiste a transferencia eh o
    * processo que consome THIS.this_cListaProdutos apos o form fechar.
    *====================================================================

    *====================================================================
    * ValidarProduto - Valida codigo de produto contra SigCdPro
    *
    * Equivalente ao legado (Grade.Column1.Text1.Valid):
    *   CreateObject('fwBuscaExt', poDataMgr.pnIdConn, 'SigCdPro',
    *                 'CrProds', 'cpros', This.Value, 'Produtos', 1000)
    *
    * Parametros: par_cCodigo - codigo digitado (coluna SigCdPro.cpros)
    * Retorno: .T. se encontrou o produto (preenche this_cCodigoProduto/
    *          this_cDescricaoProduto), .F. caso contrario
    *====================================================================
    FUNCTION ValidarProduto(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        IF VARTYPE(par_cCodigo) != "C" OR EMPTY(ALLTRIM(par_cCodigo))
            RETURN .F.
        ENDIF

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF

            loc_cSQL = "SELECT cpros, dpros FROM SigCdPro WHERE cpros = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaProduto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ValidaProduto") > 0
                SELECT cursor_4c_ValidaProduto
                GO TOP
                THIS.this_cCodigoProduto    = ALLTRIM(TratarNulo(cpros, ""))
                THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(dpros, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cCodigoProduto    = ""
                THIS.this_cDescricaoProduto = ""
                THIS.this_cMensagemErro = "Produto n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_ValidaProduto")
                USE IN cursor_4c_ValidaProduto
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRTRFBO.ValidarProduto")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarParametroTempoEspera - Le SigCdPac.ClockEcfs
    *
    * Equivalente ao legado (PROCEDURE Init do form):
    *   lcSql = [Select ClockEcfs From SigCdPac]
    *   ThisForm.Podatamgr.Sqlexecute(lcSql,'LocalParac')
    *
    * Tempo de espera (segundos), em numeric(4,0), usado na animacao de
    * confirmacao do botao "Ok".
    * Retorno: .T. se encontrou o parametro (preenche this_nTempoEspera)
    *====================================================================
    FUNCTION CarregarParametroTempoEspera()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_nTempoEspera = 0

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_ParamTempo")
                USE IN cursor_4c_ParamTempo
            ENDIF

            loc_cSQL = "SELECT clockecfs FROM SigCdPac"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ParamTempo")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ParamTempo") > 0
                SELECT cursor_4c_ParamTempo
                GO TOP
                THIS.this_nTempoEspera = NVL(clockecfs, 0)
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_ParamTempo")
                USE IN cursor_4c_ParamTempo
            ENDIF
        CATCH TO loc_oErro
            MostrarErro(loc_oErro, "SIGPRTRFBO.CarregarParametroTempoEspera")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * MontarListaProdutos - Conta os produtos informados na grade e monta
    * a lista final separada por virgula (this_cListaProdutos)
    *
    * Equivalente ao legado (PROCEDURE Click do botao "Ok"):
    *   Select CrProduto
    *   Count to x for Not Empty(Cpros)
    *   If x=0
    *       MessageBox('Nenhum Produto Informado!!!',0+16,'')
    *       Return .f.
    *   Endif
    *
    * Parametros: par_cCursorProdutos - alias do cursor da grade (coluna
    *             cpros, igual ao CrProduto do legado)
    * Retorno: numero de produtos validos encontrados (0 = nenhum)
    *====================================================================
    FUNCTION MontarListaProdutos(par_cCursorProdutos)
        LOCAL loc_nQtde, loc_cLista, loc_cAliasAnterior, loc_nRecnoAnterior

        loc_nQtde  = 0
        loc_cLista = ""
        THIS.this_cListaProdutos = ""

        IF VARTYPE(par_cCursorProdutos) != "C" OR !USED(par_cCursorProdutos)
            RETURN 0
        ENDIF

        loc_cAliasAnterior = ALIAS()

        SELECT (par_cCursorProdutos)

        *-- COUNT e SCAN varrem o cursor INTEIRO e deixam o ponteiro em EOF.
        *-- Guardar a LINHA CORRENTE (nao basta guardar o ALIAS): o chamador
        *-- eh a grade, e devolve-la posicionada em EOF faz a transferencia
        *-- da linha corrente (FormParaBO/BOParaForm do form) deixar de achar
        *-- registro - nada eh gravado, sem erro e sem aviso.
        loc_nRecnoAnterior = RECNO(par_cCursorProdutos)

        COUNT TO loc_nQtde FOR !EMPTY(cpros)

        IF loc_nQtde > 0
            SCAN FOR !EMPTY(cpros)
                IF !EMPTY(loc_cLista)
                    loc_cLista = loc_cLista + ","
                ENDIF
                loc_cLista = loc_cLista + ALLTRIM(cpros)
            ENDSCAN
        ENDIF

        THIS.this_cListaProdutos = loc_cLista

        *-- Repoe a linha corrente. GO so eh valido dentro do intervalo de
        *-- registros: RECNO() devolve RECCOUNT()+1 quando o ponteiro ja
        *-- estava em EOF ao entrar no metodo.
        IF BETWEEN(loc_nRecnoAnterior, 1, RECCOUNT(par_cCursorProdutos))
            GO loc_nRecnoAnterior IN (par_cCursorProdutos)
        ENDIF

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_nQtde
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega this_cCodigoProduto/this_cDescricaoProduto
    * a partir do registro corrente do cursor informado (usado apos o
    * lookup de produto preencher cpros/dpros na linha da grade)
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE("cpros") != "U"
            THIS.this_cCodigoProduto = ALLTRIM(TratarNulo(cpros, ""))
        ENDIF

        IF TYPE("dpros") != "U"
            THIS.this_cDescricaoProduto = ALLTRIM(TratarNulo(dpros, ""))
        ENDIF

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave do produto corrente (usada so se algum
    * dia este BO vier a registrar auditoria de uma linha especifica)
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigoProduto
    ENDPROC

ENDDEFINE

