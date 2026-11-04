# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'DOPES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FAIXAFS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'CIDCHAVES' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: FAIXAFS

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
  DeleteMark = .F.
  Column1.ControlSource = ""
Select crSigOpCrr
	Insert Into crSigOpCrr (Dopes, CidChaves) Values (crSigCdOpe.Dopes,fUniqueIds())
Select crSigOpCrr
		SELECT crSigOpCrr
Select CrSigOpCrr
	.Column1.ControlSource = 'crSigOpCrr.FaixaIs'
	.Column2.ControlSource = 'crSigOpCrr.FaixaFs'
	.Column3.ControlSource = 'crSigOpCrr.Percs'
	.Column4.ControlSource = 'crSigOpCrr.Multiplos'
Select CrSigOpCrr
Select CrSigOpCrr
Select crSigOpCrr
	Delete
	Select CrSigOpCrr
	Delete For Empty(Dopes) or Empty(faixafs)
			m.lnErro1 = Iif(.poDataMgr.UpDate('crSigOpCrr'),1,-1)

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCrd.prg) - TRECHOS RELEVANTES PARA PASS SQL (2301 linhas total):

*-- Linhas 44 a 62:
44: *
45: * A operacao dona das faixas chega por PARAMETRO: o legado a lia de
46: * crSigCdOpe.Dopes porque fazia "Set DataSession to pnDataSes" para entrar na
47: * datasession do PAI. Aqui o BO faz o proprio SQLEXEC e a grade vive em
48: * cursor_4c_Dados nesta datasession, entao o acoplamento com os cursores do
49: * pai desaparece - fica so o valor (PILAR 3).
50: *
51: *------------------------------------------------------------------------------
52: * ESCOPO JA ENTREGUE
53: *
54: * Fase 3/8 - estrutura base: DEFINE CLASS + propriedades visuais do dump, Init
55: * completo (contexto do pai + BO + InicializarForm), cabecalho cinza
56: * (cntSombra -> cnt_4c_Sombra com os dois labels) e Destroy.
57: *
58: * Fase 4/8 - corpo da tela: Shape1 decorativo, a grade de 4 colunas
59: * (GradeSubN -> grd_4c_Dados) com o bind do cursor, e os DOIS botoes do dump
60: * (cmdExcluir -> cmd_4c_Excluir, cmdSair -> cmd_4c_Encerrar) com os Click
61: * transcritos do legado.
62: *

*-- Linhas 78 a 96:
78: * depois do ULTIMO AddObject. Nao entram, com motivo medido: DoCreate (flag
79: * de design-time, nao eh property de Form), Column<N>.Name (renomear Column
80: * quebra toda referencia .ColumnN) e o Dataenvironment inteiro (a nova
81: * arquitetura usa BO + SQLEXEC).
82: *
83: * NAO existem aqui PageFrame, pagina Lista/Dados nem os cinco botoes CRUD
84: * canonicos: o dump tem 2 botoes, em Left 450 e 525, e nenhuma Page. Os
85: * metodos ConfigurarPageFrame / ConfigurarPaginaLista / ConfigurarPaginaDados
86: * mantem os nomes do contrato do pipeline, mas montam o que a tela de fato
87: * tem.
88: *
89: * EVENTOS DE CELULA DA GRADE (todos os do dump, nenhum a mais)
90: *
91: * O legado nao tem lookup algum - nenhum fwBuscaExt / fwBuscaSel / fwBuscaInt,
92: * nenhum sigacess, nenhum mAddColuna no dump inteiro. Os unicos handlers de
93: * campo sao dois LostFocus de celula, e estao transcritos:
94: *
95: *   Column2.Text1.LostFocus -> ValidarFaixaFinal : Faixa Final em branco manda
96: *                              o foco para o Encerrar (que eh quem grava)

*-- Linhas 111 a 129:
111: *
112: * Fase 8/8 - consolidacao: os hooks canonicos de transferencia e de estado,
113: * reconhecendo que nesta tela a FICHA eh a LINHA da grade (as quatro colunas
114: * tem ControlSource direto no cursor, nao ha painel de campos soltos):
115: *
116: *   FormParaBO     linha corrente -> properties do BO; faz o FLUSH da celula
117: *                  em edicao, que eh o unico pedaco do estado que ainda nao
118: *                  chegou ao cursor. So a coluna ATIVA eh lida do controle -
119: *                  com Sparse = .F. o controle eh por COLUNA e, fora da ativa,
120: *                  o .Value so vale para a linha pintada por ultimo.
121: *   BOParaForm     properties do BO -> linha corrente, com guarda de
122: *                  identidade por cidchaves, e repintando (regra #21).
123: *   HabilitarCampos  abre/fecha a digitacao na grade: Grid.ReadOnly ANTES das
124: *                  colunas (regra #18/#46) e as QUATRO reabertas, porque
125: *                  Column1/Column3 nao passam por InstalarCelulasFaixa.
126: *   LimparCampos   devolve a linha corrente ao estado "em branco" (faixafs = 0,
127: *                  o criterio do inserelinha legado), composto dos dois hooks.
128: *
129: * ESCOPO - os quatro NAO sao iguais, e nao da para escolher: FormBase declara

*-- Linhas 378 a 396:
378:             CASE EMPTY(ALLTRIM(THIS.this_cOperacao))
379:                 *-- Sem a operacao dona nao ha faixa a editar: o legado lia
380:                 *-- crSigCdOpe.Dopes da datasession do pai e sem isso o
381:                 *-- Insert Into crSigOpCrr (Dopes, ...) gravaria orfao.
382:                 THIS.this_cMotivoBloqueio = "Opera" + CHR(231) + CHR(227) + ;
383:                     "o inv" + CHR(225) + "lida. Selecione a opera" + CHR(231) + CHR(227) + ;
384:                     "o antes de editar as faixas de valores."
385:                 loc_lValido = .F.
386:         ENDCASE
387: 
388:         IF !loc_lValido
389:             MsgAviso(THIS.this_cMotivoBloqueio, "Aten" + CHR(231) + CHR(227) + "o")
390:         ENDIF
391: 
392:         RETURN loc_lValido
393:     ENDPROC
394: 
395: 
396:     *==========================================================================

*-- Linhas 411 a 436:
411: 
412:         TRY
413:             *-- Datasession privada (DataSession = 2) nasce com os SETs no
414:             *-- DEFAULT do VFP: o SET DELETED ON / SET EXACT ON do config.prg
415:             *-- ficou na sessao 1 e NAO eh herdado. FormBase.Init() repoe so
416:             *-- DATE/CENTURY. Repor os dois aqui eh obrigatorio nesta tela:
417:             *-- cmdExcluir faz DELETE local na linha da grade e o cmdSair faz
418:             *-- "Delete For Empty(Dopes) or Empty(faixafs)" - com DELETED OFF
419:             *-- a linha apagada CONTINUA aparecendo na grade e sendo vista por
420:             *-- LOCATE/SCAN, sem erro e sem log.
421:             SET DELETED ON
422:             SET EXACT ON
423: 
424:             *-- Business Object com o contexto recebido do pai
425:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCrdBO", ;
426:                                                      THIS.this_cOperacao, ;
427:                                                      THIS.this_cEscolha)
428: 
429:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
430:                 *-- Titulo dinamico, como o legado:
431:                 *-- 'Faixa de Valores da Operacao ' + AllTrim(Proper(Dopes))
432:                 THIS.AjustarCaption()
433: 
434:                 *-- Aparencia base do form (fundo/scroll)
435:                 THIS.ConfigurarPageFrame()
436: 

*-- Linhas 456 a 474:
456:                 THIS.TornarControlesVisiveis()
457: 
458:                 *-- Carga e bind da grade: so AQUI, nunca em
459:                 *-- ConfigurarPaginaLista. Column.ControlSource exige o cursor
460:                 *-- JA ABERTO, e quando a grade eh criada nao existe cursor
461:                 *-- nenhum - atribuir ali estoura "Alias ... is not found"
462:                 *-- dentro deste TRY, InicializarForm devolve .F. e a tela nao
463:                 *-- abre, sem erro visivel (regra #41).
464:                 THIS.CarregarLista()
465: 
466:                 *-- POR ULTIMO: TornarControlesVisiveis acabou de forcar
467:                 *-- Visible = .T. em cada controle, inclusive no Excluir que o
468:                 *-- legado ESCONDE quando o usuario nao tem acesso. Ajustar
469:                 *-- antes dele seria simplesmente apagado.
470:                 THIS.AjustarBotoesPorModo()
471: 
472:                 loc_lSucesso = .T.
473:             ELSE
474:                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + ;

*-- Linhas 767 a 841:
767:     *==========================================================================
768:     * ConfigurarGrade - GradeSubN do legado (grd_4c_Dados)
769:     *
770:     * Dump: ColumnCount=4 FontName="Tahoma" FontSize=8 DeleteMark=.F.
771:     *       Top=103 Left=118 Width=363 Height=227 RowHeight=16
772:     *       ScrollBars=2 TabIndex=1 GridLineColor=238,238,238
773:     *
774:     * O TabIndex = 1 do dump NAO eh atribuido aqui: TabIndex tem de ser
775:     * aplicado DEPOIS de todos os AddObject, senao cada AddObject seguinte
776:     * renumera os irmaos. Mora em ConfigurarPaginaDados().
777:     *
778:     * Tahoma, e nao Verdana: Verdana eh o canonico da grade de LISTA do
779:     * frmcadastro, e esta tela nao eh um cadastro paginado - o dump declara
780:     * Tahoma 8 no proprio Grid.
781:     *
782:     * Sem compensacao de +29 no Top: sem PageFrame, os Top do dump sao
783:     * absolutos (os -29 do pgf_4c_Paginas nao existem aqui).
784:     *
785:     * RecordMark: o dump declara DeleteMark = .F. e eh SILENCIOSO sobre
786:     * RecordMark, que na BaseClass grid vale .T. - ou seja, a seta de registro
787:     * corrente aparecia no legado, e as larguras fecham com ela (100+100+48+80
788:     * = 328, mais a marca e a barra de rolagem, nos 363 do Grid). Mesmo assim
789:     * fica .F.: eh a regra do projeto para grade de form OPERACIONAL, e o
790:     * CorretorAutomatico (#58/GridRecordMarkDeleteMark) INJETA .F. quando a
791:     * propriedade esta ausente. Declarar explicitamente deixa a decisao
792:     * visivel no codigo em vez de ser acrescentada em silencio no proximo
793:     * sweep. As larguras das colunas seguem as do dump, intocadas.
794:     *
795:     * Nada de RecordSource / ControlSource aqui - ver CarregarLista.
796:     *==========================================================================
797:     PROTECTED PROCEDURE ConfigurarGrade()
798:         THIS.AddObject("grd_4c_Dados", "Grid")
799:         WITH THIS.grd_4c_Dados
800:             .ColumnCount    = 4
801:             .Top            = 103
802:             .Left           = 118
803:             .Width          = 363
804:             .Height         = 227
805:             .FontName       = "Tahoma"
806:             .FontSize       = 8
807:             .RowHeight      = 16
808:             .ScrollBars     = 2
809:             .GridLineColor  = RGB(238, 238, 238)
810:             .RecordMark     = .F.
811:             .DeleteMark     = .F.
812:             .Visible        = .T.
813:         ENDWITH
814: 
815:         *-- Propriedades de COLUNA num metodo proprio: elas sao reaplicadas
816:         *-- depois de cada RecordSource (ver ConfigurarColunasGrade).
817:         THIS.ConfigurarColunasGrade()
818: 
819:         RETURN .T.
820:     ENDPROC
821: 
822: 
823:     *==========================================================================
824:     * ConfigurarColunasGrade - propriedades de COLUNA, reaplicaveis
825:     *
826:     * Mexer em RecordSource (e nos ControlSource) faz o VFP RECALCULAR as
827:     * larguras para o default 90 e devolver os cabecalhos a "Header1" -
828:     * silenciosamente. Por isso tudo que eh de coluna mora aqui e este metodo
829:     * eh chamado DUAS vezes: ao criar a grade (para ela ja nascer certa) e de
830:     * novo logo depois de cada bind, em VincularGrade.
831:     *
832:     * Dump, coluna por coluna:
833:     *   Column1 "Faixa Inicial" Width=100 Movable=.F. Resizable=.F.
834:     *           InputMask="999,999,999.99"
835:     *   Column2 "Faixa Final"   Width=100 Movable=.F. Resizable=.F.
836:     *           InputMask="999,999,999.99"   Text1.ReadOnly=.F.
837:     *   Column3 "%"             Width=48  InputMask="999.99"
838:     *           (NAO declara Movable/Resizable - ficam no default .T.)
839:     *   Column4 "Multiplos"     Width=80  Movable=.F. Resizable=.F.
840:     *           InputMask="999,999,999.99"
841:     *   Header1 de todas: Tahoma 8, Alignment=2 (centralizado)

*-- Linhas 1106 a 1132:
1106:     *
1107:     * Transcricao do trecho de carga do Init legado:
1108:     *     With SigCdOpe.poDatamgr
1109:     *         .ReQuery('crSigOpCrr') / SELECT crSigOpCrr / Go Top
1110:     *     EndWith
1111:     *     Select CrSigOpCrr / Goto Top
1112:     *     If Reccount() = 0 And InList(Thisform.PcEscolha,'INSERIR','ALTERAR')
1113:     *         ThisForm.inserelinha()
1114:     *     Endif
1115:     *     With Thisform.GradeSubN
1116:     *         .RecordSource          = 'crSigOpCrr'
1117:     *         .Column1.ControlSource = 'crSigOpCrr.FaixaIs'
1118:     *         ... .Refresh
1119:     *     EndWith
1120:     *
1121:     * A ordem eh regra: carregar -> garantir a linha de digitacao -> LIGAR a
1122:     * grade -> repintar. Ligar antes de o cursor existir estoura o Init
1123:     * (regra #41), e repintar sem o GO TOP deixa a grade visualmente vazia com
1124:     * o cursor cheio (regra #21).
1125:     *
1126:     * Sem SetFocus na Column1 aqui, embora o inserelinha legado o faca: este
1127:     * caminho roda dentro do Init, com o form ainda invisivel, e SetFocus em
1128:     * controle de form nao mostrado falha. O foco inicial eh assunto do fluxo
1129:     * interativo de insercao de linha.
1130:     *
1131:     * PUBLIC: o harness chama THIS.oForm.CarregarLista() de fora (regra #3).
1132:     *==========================================================================

*-- Linhas 1164 a 1269:
1164: 
1165:             *-- GO TOP + Refresh: popular o cursor NAO repinta a grade.
1166:             IF USED(loc_cAlias)
1167:                 SELECT (loc_cAlias)
1168:                 GO TOP
1169:             ENDIF
1170:             THIS.RepintarGrade()
1171:         CATCH TO loc_oErro
1172:             THIS.this_cMensagemErro = loc_oErro.Message
1173:             MsgErro("Erro ao carregar as faixas de valores:" + CHR(13) + ;
1174:                     loc_oErro.Message + CHR(13) + ;
1175:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1176:                     "Procedure: " + loc_oErro.Procedure, ;
1177:                     "Faixas de Valores")
1178:             loc_lSucesso = .F.
1179:         ENDTRY
1180: 
1181:         RETURN loc_lSucesso
1182:     ENDPROC
1183: 
1184: 
1185:     *==========================================================================
1186:     * VincularGrade - RecordSource + ControlSource das 4 colunas
1187:     *
1188:     * Transcricao do With Thisform.GradeSubN do Init legado, com os mesmos
1189:     * pares coluna/campo:
1190:     *     Column1 -> FaixaIs    Column3 -> Percs
1191:     *     Column2 -> FaixaFs    Column4 -> Multiplos
1192:     *
1193:     * ColumnCount eh reposto ANTES do RecordSource porque o cursor tem SETE
1194:     * colunas (as seis de SigOpCrr mais o marcador lnovos) e sem ele a grade
1195:     * se auto-expande para todas - o usuario veria cidchaves, dopes e lnovos
1196:     * na tela. O guard IF != 4 existe porque atribuir ColumnCount RECRIA os
1197:     * objetos Column, descartando tudo o que foi posto neles; reatribuir o
1198:     * mesmo valor sem necessidade so cria risco.
1199:     *
1200:     * ConfigurarColunasGrade() por ULTIMO: RecordSource e ControlSource
1201:     * acabaram de devolver as larguras ao default 90 e os cabecalhos a
1202:     * "Header1".
1203:     *
1204:     * PUBLIC porque tambem eh o ponto de religacao quando o BO avisa, por
1205:     * this_lCursorRecriado, que FECHOU e recriou o alias - fechar o alias
1206:     * derruba o binding da grade EM SILENCIO.
1207:     *==========================================================================
1208:     PROCEDURE VincularGrade()
1209:         LOCAL loc_lSucesso, loc_cAlias, loc_oGrade, loc_oErro
1210: 
1211:         loc_lSucesso = .F.
1212: 
1213:         IF VARTYPE(THIS.this_oBusinessObject) != "O" ;
1214:            OR !PEMSTATUS(THIS, "grd_4c_Dados", 5)
1215:             RETURN .F.
1216:         ENDIF
1217: 
1218:         loc_cAlias = ALLTRIM(THIS.this_oBusinessObject.this_cCursorDados)
1219:         loc_oGrade = THIS.grd_4c_Dados
1220: 
1221:         IF !USED(loc_cAlias)
1222:             *-- Sem cursor nao ha o que ligar, e atribuir ControlSource agora
1223:             *-- estouraria "Alias ... is not found".
1224:             RETURN .F.
1225:         ENDIF
1226: 
1227:         TRY
1228:             *-- ColumnCount e RecordSource FORA do WITH: colunas recriadas por
1229:             *-- ColumnCount nao ficam disponiveis de forma confiavel dentro do
1230:             *-- mesmo bloco WITH que acabou de abrir, e o acesso a .ColumnN
1231:             *-- logo depois estouraria "Unknown member COLUMNN".
1232:             IF loc_oGrade.ColumnCount != 4
1233:                 loc_oGrade.ColumnCount = 4
1234:             ENDIF
1235: 
1236:             loc_oGrade.RecordSource = loc_cAlias
1237: 
1238:             WITH loc_oGrade
1239:                 .Column1.ControlSource = loc_cAlias + ".faixais"
1240:                 .Column2.ControlSource = loc_cAlias + ".faixafs"
1241:                 .Column3.ControlSource = loc_cAlias + ".percs"
1242:                 .Column4.ControlSource = loc_cAlias + ".multiplos"
1243:             ENDWITH
1244: 
1245:             *-- Larguras e cabecalhos DEPOIS do bind, sempre
1246:             THIS.ConfigurarColunasGrade()
1247: 
1248:             *-- Celulas com evento DEPOIS de ConfigurarColunasGrade: o
1249:             *-- ColumnCount acima pode ter RECRIADO os objetos Column, e com
1250:             *-- eles o CurrentControl e o TextBox instalado.
1251:             THIS.InstalarCelulasFaixa(loc_oGrade)
1252: 
1253:             *-- Reabre a digitacao nas QUATRO colunas. O bloco acima mexeu em
1254:             *-- RecordSource/ControlSource e pode ter reatribuido ColumnCount,
1255:             *-- e Grid.ReadOnly propaga para as colunas (regra #18/#46):
1256:             *-- Column1 e Column3, que seguem com o Text1 nativo, nao passam
1257:             *-- por InstalarCelulasFaixa e ficariam com o que o grid propagou.
1258:             THIS.HabilitarCampos(.T.)
1259: 
1260:             THIS.this_oBusinessObject.this_lCursorRecriado = .F.
1261: 
1262:             loc_lSucesso = .T.
1263:         CATCH TO loc_oErro
1264:             THIS.this_cMensagemErro = loc_oErro.Message
1265:             MsgErro("Erro ao vincular a grade das faixas de valores:" + CHR(13) + ;
1266:                     loc_oErro.Message + CHR(13) + ;
1267:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1268:                     "Procedure: " + loc_oErro.Procedure, ;
1269:                     "Faixas de Valores")

*-- Linhas 1494 a 1517:
1494:     *
1495:     * Legado, LITERAL:
1496:     *     PROCEDURE LostFocus
1497:     *     Select CrSigOpCrr
1498:     *     Locate for faixafs = 0
1499:     *     If Eof()
1500:     *         Thisform.Inserelinha()
1501:     *     EndIf
1502:     *     Select CrSigOpCrr
1503:     *
1504:     * Multiplos eh a ULTIMA coluna: ao sair dela o legado garante que exista
1505:     * sempre UMA linha em branco esperando digitacao - se nenhuma linha tem
1506:     * faixafs = 0, ele cria. Eh assim que o usuario acrescenta faixas sem
1507:     * nenhum botao de "inserir": preenche a linha e a proxima aparece.
1508:     *
1509:     * Esse LOCATE eh tambem o que, na pratica, liga o marcador de alteracao
1510:     * a gravar que o Encerrar consulta - as linhas vindas do servidor nunca
1511:     * tem faixafs = 0, entao InserirLinha roda e marca this_lHouveInsercao
1512:     * (ver HaAlteracaoPendente no BO). Por isso adiar este handler deixaria a
1513:     * tela gravando MENOS do que o legado grava.
1514:     *
1515:     * O LOCATE roda sobre o CURSOR (nao sobre par_oTxt.Value): aqui a pergunta
1516:     * eh "existe linha em branco na grade?", nao "o que foi digitado?".
1517:     *

*-- Linhas 1548 a 1615:
1548:         ENDIF
1549: 
1550:         TRY
1551:             SELECT (loc_cAlias)
1552:             LOCATE FOR faixafs = 0
1553: 
1554:             IF EOF()
1555:                 loc_lPrecisaLinha = .T.
1556:             ENDIF
1557: 
1558:             IF loc_lPrecisaLinha
1559:                 THIS.InserirLinha()
1560:             ENDIF
1561: 
1562:             *-- Select final do legado: o LOCATE pode ter deixado o alias
1563:             *-- corrente em outro lugar e o resto da tela conta com este.
1564:             IF USED(loc_cAlias)
1565:                 SELECT (loc_cAlias)
1566:             ENDIF
1567:         CATCH TO loc_oErro
1568:             THIS.this_cMensagemErro = loc_oErro.Message
1569:             MsgErro("Erro ao sair do campo M" + CHR(250) + "ltiplos:" + CHR(13) + ;
1570:                     loc_oErro.Message + CHR(13) + ;
1571:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1572:                     "Procedure: " + loc_oErro.Procedure, ;
1573:                     "Faixas de Valores")
1574:         ENDTRY
1575: 
1576:         RETURN .T.
1577:     ENDPROC
1578: 
1579: 
1580:     *==========================================================================
1581:     * InserirLinha - parte de TELA do inserelinha legado
1582:     *
1583:     * Legado COMPLETO:
1584:     *     PROCEDURE inserelinha
1585:     *     Thisform.lHouveIns = .T.
1586:     *     Select crSigOpCrr
1587:     *     Locate for faixafs=0
1588:     *     If Eof()
1589:     *         Insert Into crSigOpCrr (Dopes, CidChaves) ;
1590:     *             Values (crSigCdOpe.Dopes, fUniqueIds())
1591:     *     EndIf
1592:     *     Select crSigOpCrr
1593:     *     Keyboard '{DNARROW}'
1594:     *     ThisForm.GradeSubN.Refresh
1595:     *     Thisform.GradeSubN.Column1.SetFocus
1596:     *
1597:     * A parte de DADOS (marcador lHouveIns, LOCATE, INSERT com a chave de
1598:     * fUniqueIds) esta em InserirLinhaCursor, no BO - inclusive o marcador
1599:     * ligado INCONDICIONALMENTE na primeira linha, como no legado: ele vale
1600:     * mesmo quando a linha em branco ja existia e o INSERT nao roda.
1601:     *
1602:     * Aqui ficam as TRES ultimas linhas, que sao de tela e que o migrador
1603:     * costuma descartar junto com o resto do handler - e sao elas que tornam a
1604:     * linha nova USAVEL: sem o Refresh a grade continua mostrando o cursor
1605:     * antigo (popular cursor NAO repinta a grade, regra #21a) e sem o SetFocus
1606:     * o usuario tem de ir com o mouse ate a primeira coluna da linha nova.
1607:     *
1608:     * O Keyboard '{DNARROW}' eh transcrito como esta: ele enfileira a tecla
1609:     * para DEPOIS deste metodo, e eh o que leva o cursor da grade para a linha
1610:     * recem-criada.
1611:     *
1612:     * SetFocus so com o form MOSTRADO: este metodo tambem eh alcancavel pelo
1613:     * caminho de carga (grade vazia), onde o form ainda nao foi exibido e o
1614:     * SetFocus falharia. Eh a mesma razao pela qual CarregarLista chama
1615:     * InserirLinhaCursor direto, sem passar por aqui.

*-- Linhas 1625 a 1643:
1625:             RETURN .F.
1626:         ENDIF
1627: 
1628:         *-- Dados: marcador + LOCATE + INSERT (transcritos no BO)
1629:         loc_lSucesso = THIS.this_oBusinessObject.InserirLinhaCursor()
1630: 
1631:         IF !loc_lSucesso
1632:             *-- InserirLinhaCursor ja exibiu o motivo; sem linha nova nao ha
1633:             *-- navegacao a fazer.
1634:             RETURN .F.
1635:         ENDIF
1636: 
1637:         TRY
1638:             *-- Keyboard do legado: leva a grade para a linha nova
1639:             KEYBOARD "{DNARROW}"
1640: 
1641:             THIS.RepintarGrade()
1642: 
1643:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND THIS.Visible

*-- Linhas 1664 a 1693:
1664:     * CmdExcluirClick - cmdExcluir.Click do legado
1665:     *
1666:     * Legado:
1667:     *     Select crSigOpCrr
1668:     *     If Not Eof()
1669:     *         Thisform.lHouveExcl = .T.
1670:     *         Delete / Skip / Skip - 1
1671:     *     Endif
1672:     *     ThisForm.GradeSubN.Refresh
1673:     *
1674:     * A parte de DADOS (marcador, DELETE e reposicionamento do ponteiro) mora
1675:     * em ExcluirLinhaCursor, no BO; aqui fica o que eh da TELA. O Refresh vem
1676:     * FORA do IF, como no legado: ele repinta tambem quando nada foi excluido.
1677:     *
1678:     * A remocao eh LOCAL - no legado o DELETE so chega ao servidor junto com a
1679:     * gravacao do Encerrar, e eh isso que GravarFaixas reproduz. Nao ha
1680:     * confirmacao porque o legado nao pede nenhuma, e o Encerrar eh a ultima
1681:     * chance de desistir (fechar sem clicar nele descarta tudo).
1682:     *==========================================================================
1683:     PROCEDURE CmdExcluirClick()
1684:         LOCAL loc_lSucesso
1685: 
1686:         loc_lSucesso = .F.
1687: 
1688:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1689:             loc_lSucesso = THIS.this_oBusinessObject.ExcluirLinhaCursor()
1690:         ENDIF
1691: 
1692:         THIS.RepintarGrade()
1693: 

*-- Linhas 1700 a 1720:
1700:     *
1701:     * Legado:
1702:     *     If ( Thisform.lHouveExcl Or Thisform.lHouveIns )
1703:     *         ... Delete For Empty(Dopes) or Empty(faixafs)
1704:     *         ... Replace CidChaves with fUniqueIds() For Empty(CidChaves)
1705:     *         ... poDataMgr.UpDate / Commit / RollBack
1706:     *         If Not m.lnErro1>0
1707:     *             = MessageBox('Erro na Gravacao dos Dados do Cadastro de Operacoes.',48)
1708:     *         EndIf
1709:     *     EndIf
1710:     *     Thisform.ParentForm.Enabled = .T.
1711:     *     ThisForm.Release
1712:     *
1713:     * Tudo o que esta dentro do If (guard de alteracao a gravar, descarte das
1714:     * linhas em branco, geracao das chaves e o lote atomico) esta em
1715:     * GravarFaixas; aqui fica a sequencia da TELA.
1716:     *
1717:     * TRANSCRICAO FIEL, inclusive no ponto incomodo: o legado LIBERA O PAI E
1718:     * FECHA A TELA MESMO QUANDO A GRAVACAO FALHA - o RollBack desfaz no
1719:     * servidor, a MessageBox avisa, e o que foi digitado se perde. Fica igual
1720:     * de proposito (PILAR 1). GravarFaixas sempre exibe o motivo real do SQL

*-- Linhas 1825 a 1843:
1825:     * FormParaBO - transfere a LINHA CORRENTE da grade para o BO
1826:     *
1827:     * Nesta tela a "ficha" nao eh um painel de campos soltos: eh a LINHA da
1828:     * grade. As quatro colunas tem ControlSource ligado direto ao cursor
1829:     * (VincularGrade), entao o estado dos campos JA mora no cursor - o que
1830:     * este hook acrescenta eh o unico pedaco que ainda nao chegou nele: a
1831:     * celula que o usuario esta digitando AGORA.
1832:     *
1833:     * POR QUE SO A COLUNA ATIVA EH LIDA DO CONTROLE
1834:     *
1835:     * Com Sparse = .F. a coluna desenha o MESMO objeto de controle em todas as
1836:     * linhas (eh um controle por COLUNA, nao por celula). Na coluna ATIVA esse
1837:     * controle guarda o valor em edicao, que pode ainda nao ter chegado ao
1838:     * cursor - eh a mesma razao pela qual os handlers de celula leem
1839:     * par_oTxt.Value e nao a coluna do cursor (regra #46). Nas OUTRAS colunas o
1840:     * .Value so eh garantido para a linha que foi PINTADA por ultimo; copiar
1841:     * dali para o cursor poderia gravar na linha corrente um valor de OUTRA
1842:     * linha. Por isso o flush eh cirurgico: coluna ATIVA, e so ela.
1843:     *

*-- Linhas 1886 a 1904:
1886:         loc_oGrade = THIS.grd_4c_Dados
1887: 
1888:         TRY
1889:             SELECT (loc_cAlias)
1890: 
1891:             IF !EOF()
1892:                 loc_nAtiva = loc_oGrade.ActiveColumn
1893: 
1894:                 IF loc_nAtiva >= 1 AND loc_nAtiva <= 4 ;
1895:                    AND loc_nAtiva <= loc_oGrade.ColumnCount
1896:                     loc_oColuna   = loc_oGrade.Columns(loc_nAtiva)
1897:                     loc_cControle = ALLTRIM(NVL(loc_oColuna.CurrentControl, ""))
1898:                     loc_oCelula   = .NULL.
1899: 
1900:                     *-- Membro alcancado por NOME: EVALUATE na LEITURA, nunca
1901:                     *-- Controls(<nome>) - Controls eh indexado por NUMERO e o
1902:                     *-- nome estoura em runtime (regra #34).
1903:                     IF !EMPTY(loc_cControle) ;
1904:                        AND PEMSTATUS(loc_oColuna, loc_cControle, 5)

*-- Linhas 1959 a 1987:
1959:     * BOParaForm - escreve as properties do BO na LINHA CORRENTE da grade
1960:     *
1961:     * Sentido inverso do FormParaBO, com o MESMO par coluna/campo de
1962:     * VincularGrade. Como as colunas tem ControlSource, escrever no CURSOR eh
1963:     * escrever "no campo da tela" - nao existe .Value avulso a atualizar; o que
1964:     * falta depois eh so repintar, porque mexer no cursor NAO repinta a grade
1965:     * (regra #21).
1966:     *
1967:     * SO as QUATRO colunas visiveis sao escritas. cidchaves e dopes ficam de
1968:     * fora de proposito: eles sao a IDENTIDADE da linha (a chave gerada por
1969:     * fUniqueIds no InserirLinhaCursor e a operacao dona das faixas), nao
1970:     * campos de tela. Sobrescreve-los aqui trocaria a linha de registro - ou,
1971:     * pior, a deixaria com dopes vazio, que eh justamente o que o
1972:     * "Delete For Empty(Dopes)" do Encerrar legado joga fora.
1973:     *
1974:     * GUARDA DE IDENTIDADE: com this_cCidchaves preenchido, a escrita so
1975:     * acontece se a linha corrente for essa mesma. O BO eh carregado linha a
1976:     * linha pelo SCAN de GravarFaixas, entao sem essa conferencia uma chamada
1977:     * fora de hora escreveria os valores de uma faixa sobre outra. Com
1978:     * this_cCidchaves VAZIO (o que LimparDados produz) a guarda nao se aplica:
1979:     * ali a intencao eh justamente zerar a linha corrente.
1980:     *
1981:     * PROTECTED EXPLICITO pelo mesmo motivo do FormParaBO: FormBase declara
1982:     * PROTECTED PROCEDURE BOParaForm e o escopo vem da HERANCA - omitir o
1983:     * modificador nao alarga nada. Chamado por THIS. de dentro da classe
1984:     * (LimparCampos e o funil do Encerrar).
1985:     *==========================================================================
1986:     PROTECTED PROCEDURE BOParaForm()
1987:         LOCAL loc_lSucesso, loc_cAlias, loc_oBO, loc_cChaveBO, loc_oErro

*-- Linhas 2001 a 2019:
2001:         ENDIF
2002: 
2003:         TRY
2004:             SELECT (loc_cAlias)
2005: 
2006:             DO CASE
2007:             CASE EOF()
2008:                 *-- Sem linha corrente nao ha o que escrever.
2009:                 loc_lSucesso = .F.
2010: 
2011:             CASE !EMPTY(loc_cChaveBO) ;
2012:                  AND ALLTRIM(NVL(cidchaves, "")) != loc_cChaveBO
2013:                 *-- A linha corrente nao eh a que o BO carregou.
2014:                 loc_lSucesso = .F.
2015: 
2016:             OTHERWISE
2017:                 REPLACE faixais   WITH loc_oBO.this_nFaixais,   ;
2018:                         faixafs   WITH loc_oBO.this_nFaixafs,   ;
2019:                         percs     WITH loc_oBO.this_nPercs,     ;

