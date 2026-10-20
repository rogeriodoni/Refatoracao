# CODE REVIEW - PASS SQL: SQL Validation (colunas, tabelas, aspas, filtros)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **SQL Validation (colunas, tabelas, aspas, filtros)**.

## PROBLEMAS DETECTADOS (2)
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'BASECLASS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LPRECOS
- [SQL-FILTRO-INVENTADO] Condicao WHERE com coluna 'LMARCAS' existe no codigo migrado mas NAO existe no WHERE do codigo original. A LLM pode ter inventado esta condicao de filtro. VERIFICAR: comparar o WHERE do SQL migrado com o WHERE do codigo legado e REMOVER condicoes que nao existem no original. WHERE original usa: LPRECOS

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
  Column1.ControlSource = ""
	lStrQuery = [Select 0 As lMarcas,a.* From SigCdLpi a ]+;
	If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CsSigCdLpi') < 1
	Select CsSigCdLpi
	.Column1.ControlSource = 'CsSigCdLpi.lMarcas'
	.Column2.ControlSource = 'CsSigCdLpi.cpros'
	.Column3.ControlSource = 'CsSigCdLpi.dpros'
	.Column4.ControlSource = 'CsSigCdLpi.pvens'
	.Column5.ControlSource = 'CsSigCdLpi.moevs'
	.Column6.ControlSource = 'CsSigCdLpi.comiss'
lStrQuery = [Select * From SigCdLpc Where lprecos <> ']+pcLPreco+[' Order By lprecos ]
If ThisForm.ParentForm.poDataMgr.SqlExecute(lStrQuery,'CsSigCdLpc') < 1
	.Column1.ControlSource = 'CsSigCdLpc.lprecos'
Select CsSigCdLpc
Select CrSigCdLpi
Delete From CrSigCdLpi Where Empty(cpros)
Select CsSigCdLpi
	If CsSigCdLpi.lMarcas = 1 And !Seek(CsSigCdLpi.cpros,'CrSigCdLpi','CPros')
		Insert Into CrSigCdLpi From MemVar
	Select CsSigCdLpi
Select CsSigCdLpi
Select CsSigCdLpi

## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrSlp.prg) - TRECHOS RELEVANTES PARA PASS SQL (1470 linhas total):

*-- Linhas 24 a 42:
24: *   Load (=fConfigGeral())  NAO PORTADO - deliberado, ver (a)
25: *
26: * PONTES PARA O PAI MIGRADO (nomes que o PILAR 3 trocou) - ver (c)
27: *   "CrSigCdLpi" (destino do Insert)  -> ResolverCursorDestino
28: *   ParentForm.CompVenda              -> ObterCompVendaDoPai
29: *   ParentForm.Pagina.Dados.Grade     -> DevolverFocoAoPai + FocarPrimeiraGrade
30: *
31: * (c) O PILAR 3 RENOMEIA objetos e cursores, e este dialogo eh o unico do
32: *     projeto que escreve DENTRO de estrutura do form PAI. Os tres nomes que
33: *     o legado cita literalmente nao existem no pai migrado (FormLpr,
34: *     task461): o cursor de itens dele eh "cursor_4c_Itens" ("CrSigCdLpi" tem
35: *     ZERO ocorrencias no arquivo), a property eh "this_cCompVenda" e a
36: *     pagina de dados eh "pgf_4c_Paginas.Page2" com "grd_4c_Grade"/
37: *     "grd_4c_GradeC". Com os literais do legado fixos no codigo, o
38: *     AdicionarItensMarcados nao achava o destino e devolvia -1: o usuario
39: *     marcava os itens, clicava em "Adiciona os itens marcados" e so recebia
40: *     "Erro ao adicionar itens" - a UNICA funcao da tela falhava. Cada ponte
41: *     tenta PRIMEIRO o nome do legado (pai wrapper) e so depois o do migrado,
42: *     entao nenhum dos dois pais fica de fora.

*-- Linhas 262 a 280:
262:     *
263:     * A Column nasce apenas com Header1/Text1, entao o CheckBox tem de ser
264:     * adicionado (regra #18). E, MEDIDO no VFP9 em 2026-10-19: quando o BO
265:     * derruba e recria o alias (USE IN + SQLEXEC) com a grade ainda vinculada,
266:     * o VFP RECONSTROI os objetos Column e o Check1 DEIXA DE EXISTIR
267:     * (PEMSTATUS passa de .T. para .F.) - reatribuir propriedades nao traz o
268:     * controle de volta, so recria-lo. Sem isso, da segunda lista selecionada
269:     * em diante a coluna desenha o Text1 com o 0/1 cru e nao ha como marcar.
270:     *
271:     * Geometria: o SCX declara Width=60 para o Check1, mas a coluna tem 22px e
272:     * recorta o excedente; usar 22 evita o clipping sem alterar o que o usuario
273:     * ve (a caixa de marcacao fica identica).
274:     *--------------------------------------------------------------------------
275:     PROTECTED PROCEDURE GarantirCheckBoxItens()
276:         LOCAL loc_oColuna
277: 
278:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
279:             RETURN
280:         ENDIF

*-- Linhas 313 a 331:
313:     * AplicarContratoGradeItens - (Re)aplica o contrato visual de grd_4c_Itens
314:     *
315:     * OBRIGATORIO em TODO caminho que (re)vincula o RecordSource. O BO RECRIA o
316:     * cursor de itens a cada troca de lista (USE IN + SQLEXEC dentro de
317:     * BuscarItensDaLista) e, com o cursor recriado, o VFP9 reseta Column.Width
318:     * para o default, perde Column.Sparse e devolve CurrentControl para "Text1".
319:     * Sem esta reaplicacao, da SEGUNDA lista selecionada em diante o CheckBox de
320:     * marcacao DESAPARECE (a coluna volta a desenhar o Text1 com o 0/1 cru) e o
321:     * usuario nao consegue marcar item nenhum - sem erro e sem log.
322:     * Referencia: CLAUDE.md regras #18 e #41 + Problema 48 (FormCor).
323:     *--------------------------------------------------------------------------
324:     PROTECTED PROCEDURE AplicarContratoGradeItens()
325:         LOCAL loc_oGrid
326: 
327:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
328:             RETURN
329:         ENDIF
330: 
331:         loc_oGrid = THIS.grd_4c_Itens

*-- Linhas 409 a 427:
409:     *--------------------------------------------------------------------------
410:     * AplicarContratoGradeListas - (Re)aplica o contrato visual de grd_4c_Listas
411:     * Mesmo motivo de AplicarContratoGradeItens: BuscarListasDisponiveis recria
412:     * o cursor (USE IN + SQLEXEC), o que zera Column1.Width (220 -> default) e
413:     * o Header1. Chamar depois de cada rebind do RecordSource.
414:     *--------------------------------------------------------------------------
415:     PROTECTED PROCEDURE AplicarContratoGradeListas()
416:         LOCAL loc_oGrid
417: 
418:         IF !PEMSTATUS(THIS, "grd_4c_Listas", 5)
419:             RETURN
420:         ENDIF
421: 
422:         loc_oGrid = THIS.grd_4c_Listas
423: 
424:         *-- Grid.ReadOnly ANTES da coluna: ele propaga e sobrescreve (regra #18)
425:         loc_oGrid.ReadOnly = .T.
426: 
427:         WITH loc_oGrid.Column1

*-- Linhas 487 a 505:
487:             .TabIndex    = 1       && SCX: GradeLista.TabIndex = 1
488:             .FontName    = "Courier New"
489:             .FontSize    = 9
490:             .DeleteMark  = .F.
491:             .RecordMark  = .F.
492:             .HighlightStyle     = 2
493:             .HighlightBackColor = RGB(255, 255, 255)
494:             .HighlightForeColor = RGB(15, 41, 104)
495:             .GridLineColor      = RGB(238, 238, 238)
496:             .ScrollBars  = 2
497:             .RowHeight   = 16
498:             .Visible     = .T.
499:         ENDWITH
500: 
501:         *-- Larguras, header e estilo da coluna ficam no contrato reaplicavel
502:         *-- (ReadOnly do grid eh aplicado la, ANTES do da coluna - regra #18)
503:         THIS.AplicarContratoGradeListas()
504:     ENDPROC
505: 

*-- Linhas 522 a 540:
522:             .TabIndex    = 2       && SCX: GradeItens.TabIndex = 2
523:             .FontName    = "Courier New"
524:             .FontSize    = 9
525:             .DeleteMark  = .F.
526:             .RecordMark  = .F.
527:             .HighlightStyle     = 2
528:             .HighlightBackColor = RGB(255, 255, 255)
529:             .HighlightForeColor = RGB(15, 41, 104)
530:             .GridLineColor      = RGB(238, 238, 238)
531:             .ScrollBars  = 2
532:             .RowHeight   = 16
533:         ENDWITH
534: 
535:         *-- Column1 (CheckBox de marcacao), larguras, headers, mascaras,
536:         *-- Sparse e CurrentControl ficam no contrato reaplicavel, que eh
537:         *-- chamado tambem apos cada rebind do cursor
538:         THIS.AplicarContratoGradeItens()
539: 
540:         loc_oGrid.Visible = .T.

*-- Linhas 639 a 668:
639:         IF loc_lSucesso
640:             loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
641: 
642:             *-- Ordem canonica (regra #41): RecordSource ANTES do ControlSource
643:             THIS.grd_4c_Listas.RecordSource = ""
644:             THIS.grd_4c_Listas.RecordSource = loc_cCursorListas
645:             THIS.grd_4c_Listas.Column1.ControlSource = loc_cCursorListas + ".lprecos"
646:             *-- Cursor RECRIADO pelo BO: reaplicar largura/header da coluna
647:             THIS.AplicarContratoGradeListas()
648: 
649:             *-- Carregar itens da primeira lista disponivel. O legado testa o
650:             *-- retorno do MontaGrade2 no Init (If !(ThisForm.MontaGrade2(...)))
651:             *-- - descartar o retorno aqui esconde a falha e o dialogo abre com
652:             *-- a grade de itens vazia.
653:             SELECT (loc_cCursorListas)
654:             GO TOP
655:             IF !EOF()
656:                 loc_lSucesso = THIS.MontaGrade2(ALLTRIM(lprecos))
657:             ENDIF
658:         ENDIF
659: 
660:         *-- FUNIL (regra #40): repor o estado dos controles em TODO caminho que
661:         *-- recarrega os cursores - inclusive no caminho de falha, senao uma
662:         *-- grade fica habilitada apontando para cursor que nao existe mais.
663:         THIS.AjustarBotoesPorModo()
664: 
665:         RETURN loc_lSucesso
666:     ENDPROC
667: 
668:     *--------------------------------------------------------------------------

*-- Linhas 678 a 728:
678:             loc_cCursorItens = THIS.this_oBusinessObject.this_cCursorItens
679: 
680:             *-- Ordem canonica (regra #41): RecordSource ANTES dos
681:             *-- ControlSource - atribuir RecordSource depois RESETA os
682:             *-- ControlSource ja definidos e a grade exibe colunas erradas
683:             THIS.grd_4c_Itens.RecordSource = ""
684:             THIS.grd_4c_Itens.RecordSource = loc_cCursorItens
685:             THIS.grd_4c_Itens.Column1.ControlSource = loc_cCursorItens + ".lMarcas"
686:             THIS.grd_4c_Itens.Column2.ControlSource = loc_cCursorItens + ".cpros"
687:             THIS.grd_4c_Itens.Column3.ControlSource = loc_cCursorItens + ".dpros"
688:             THIS.grd_4c_Itens.Column4.ControlSource = loc_cCursorItens + ".pvens"
689:             THIS.grd_4c_Itens.Column5.ControlSource = loc_cCursorItens + ".moevs"
690:             THIS.grd_4c_Itens.Column6.ControlSource = loc_cCursorItens + ".comiss"
691:             *-- O cursor foi RECRIADO (USE IN + SQLEXEC no BO): o rebind zera
692:             *-- Column.Width, perde Sparse e devolve CurrentControl para "Text1".
693:             *-- Sem reaplicar o contrato, o CheckBox de marcacao desaparece.
694:             THIS.AplicarContratoGradeItens()
695:             THIS.grd_4c_Itens.Refresh()
696:         ENDIF
697: 
698:         *-- FUNIL (regra #40): o cursor de itens foi recriado, repor o estado
699:         THIS.AjustarBotoesPorModo()
700: 
701:         RETURN loc_lSucesso
702:     ENDPROC
703: 
704:     *--------------------------------------------------------------------------
705:     * GradeListasAfterRowColChange - Atualiza grd_4c_Itens ao trocar linha em grd_4c_Listas
706:     *--------------------------------------------------------------------------
707:     PROCEDURE GradeListasAfterRowColChange(par_nColIndex)
708:         LOCAL loc_cCursorListas, loc_cLPrecos
709: 
710:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
711: 
712:         IF USED(loc_cCursorListas)
713:             SELECT (loc_cCursorListas)
714:             IF !EOF()
715:                 loc_cLPrecos = ALLTRIM(lprecos)
716:                 IF !EMPTY(loc_cLPrecos)
717:                     *-- Legado: If !(ThisForm.MontaGrade2(lcLPrec)) -> MessageBox
718:                     *-- "Favor reinicializar o processo." + ThisForm.Release()
719:                     IF !THIS.MontaGrade2(loc_cLPrecos)
720:                         THIS.ReportarFalhaProcesso()
721:                         THIS.Release()
722:                     ENDIF
723:                 ENDIF
724:             ENDIF
725:         ENDIF
726:     ENDPROC
727: 
728:     *--------------------------------------------------------------------------

*-- Linhas 803 a 821:
803:     * itens marcados serao inseridos.
804:     *
805:     * O legado insere no literal "CrSigCdLpi" (Command1.Click:
806:     * "Insert Into CrSigCdLpi From MemVar"), que eh o cursor que o
807:     * frmcadastro Fortyus do SIGCDLPR cria via AddCursor. O PILAR 3 RENOMEIA
808:     * os cursores: no pai migrado (FormLpr, task461) o cursor de itens chama
809:     * "cursor_4c_Itens" e "CrSigCdLpi" NAO EXISTE em lugar nenhum do arquivo
810:     * (medido: zero ocorrencias). Com o nome do legado fixo no codigo, o
811:     * AdicionarItensMarcados do BO nao achava o destino, devolvia -1 e o
812:     * dialogo exibia "Erro ao adicionar itens" - ou seja, a UNICA funcao desta
813:     * tela falhava contra o unico pai que a chama.
814:     *
815:     * Ordem de resolucao (a 1a que estiver ABERTA ganha):
816:     *   1. this_cCursorDestino, quando o pai informou no Init (explicito)
817:     *   2. property this_cCursorItens do pai, se ele publicar o nome
818:     *   3. "CrSigCdLpi" - nome do legado (pai wrapper que ainda carrega o
819:     *      cursor Fortyus)
820:     *   4. "cursor_4c_Itens" - nome que o pai migrado realmente usa
821:     *

*-- Linhas 973 a 1000:
973:             *-- Legado (PROCEDURE Release): alem de reabilitar o pai, ele
974:             *-- reposiciona o alias corrente no cursor de itens do pai e
975:             *-- devolve o foco a grade da pagina de Dados dele -
976:             *--     Select CrSigCdLpi
977:             *--     With ThisForm.ParentForm.Pagina.Dados
978:             *--         .Refresh / .SetFocus / .Grade.Column1.SetFocus
979:             *-- Sem isso o usuario volta ao pedido com a grade de itens sem
980:             *-- foco e, por o alias corrente ter ficado nos cursores deste
981:             *-- dialogo (ja fechados), com a grade do pai sem reposicionar.
982:             *-- Nome do cursor RESOLVIDO (o literal do legado nao existe no
983:             *-- pai migrado - ver ResolverCursorDestino)
984:             IF !EMPTY(loc_cCursorDestino) AND USED(loc_cCursorDestino)
985:                 SELECT (loc_cCursorDestino)
986:             ENDIF
987: 
988:             IF VARTYPE(THIS.this_oParentForm) = "O" AND !ISNULL(THIS.this_oParentForm)
989:                 *-- Enabled ANTES do foco: SetFocus em form desabilitado nao
990:                 *-- pega (o legado faz na ordem inversa e perde o foco)
991:                 THIS.this_oParentForm.Enabled = .T.
992: 
993:                 IF PEMSTATUS(THIS.this_oParentForm, "Refresh", 5)
994:                     THIS.this_oParentForm.Refresh()
995:                 ENDIF
996: 
997:                 *-- Caminho do legado so existe quando o pai tem a pagina de
998:                 *-- Dados: o PILAR 3 renomeia os objetos, entao cada nivel eh
999:                 *-- testado por PEMSTATUS antes de ser alcancado
1000:                 THIS.DevolverFocoAoPai()

*-- Linhas 1140 a 1158:
1140:         loc_cCursor   = THIS.this_oBusinessObject.this_cCursorItens
1141: 
1142:         IF USED(loc_cCursor)
1143:             SELECT (loc_cCursor)
1144:             IF !EOF()
1145:                 loc_lPermitir = (lMarcas = 0)
1146:             ENDIF
1147:         ENDIF
1148: 
1149:         RETURN loc_lPermitir
1150:     ENDPROC
1151: 
1152:     *--------------------------------------------------------------------------
1153:     * BtnIncluirClick - Adiciona os itens marcados a lista de preco atual do
1154:     * form pai. Neste dialogo OPERACIONAL "incluir" significa incluir itens
1155:     * marcados no cursor CrSigCdLpi do form pai (mesma acao do Command1 do SCX
1156:     * original "Adiciona os itens marcados a Lista atual").
1157:     *--------------------------------------------------------------------------
1158:     PROCEDURE BtnIncluirClick()

*-- Linhas 1175 a 1193:
1175:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorItens
1176: 
1177:         IF USED(loc_cCursor)
1178:             SELECT (loc_cCursor)
1179:             GO TOP
1180:             THIS.grd_4c_Itens.Refresh()
1181:             THIS.grd_4c_Itens.SetFocus()
1182:         ELSE
1183:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o selecionada.", "Aviso")
1184:         ENDIF
1185:     ENDPROC
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * BtnVisualizarClick - Move o foco para grd_4c_Listas permitindo ao
1189:     * usuario visualizar as listas de preco disponiveis para importacao.
1190:     * Neste dialogo de selecao, "visualizar" corresponde a navegar entre as
1191:     * listas de preco de origem (o SCX original faz isso via GradeLista).
1192:     *--------------------------------------------------------------------------
1193:     PROCEDURE BtnVisualizarClick()

*-- Linhas 1200 a 1218:
1200:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
1201: 
1202:         IF USED(loc_cCursor)
1203:             SELECT (loc_cCursor)
1204:             GO TOP
1205:             THIS.grd_4c_Listas.Refresh()
1206:             THIS.grd_4c_Listas.SetFocus()
1207:         ELSE
1208:             MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
1209:         ENDIF
1210:     ENDPROC
1211: 
1212:     *--------------------------------------------------------------------------
1213:     * BtnExcluirClick - Desmarca todos os itens marcados de grd_4c_Itens.
1214:     * Neste dialogo de selecao, "excluir" corresponde a remover as marcacoes
1215:     * feitas pelo usuario (mesma acao do CmdApgTudo do SCX original), com
1216:     * confirmacao previa se houver itens marcados.
1217:     *--------------------------------------------------------------------------
1218:     PROCEDURE BtnExcluirClick()

*-- Linhas 1224 a 1242:
1224:             RETURN
1225:         ENDIF
1226: 
1227:         SELECT (loc_cCursor)
1228:         COUNT FOR lMarcas = 1 TO loc_nMarcados
1229: 
1230:         IF loc_nMarcados = 0
1231:             MsgAviso("Nenhum item marcado para remover.", "Aviso")
1232:             RETURN
1233:         ENDIF
1234: 
1235:         IF MsgConfirma("Desmarcar todos os " + TRANSFORM(loc_nMarcados) + ;
1236:                        " itens marcados?", "Confirma" + CHR(231) + CHR(227) + "o")
1237:             THIS.CmdApgaTudoClick()
1238:         ENDIF
1239:     ENDPROC
1240: 
1241:     *--------------------------------------------------------------------------
1242:     * CarregarLista - Recarrega o grid de listas de preco disponiveis

*-- Linhas 1282 a 1321:
1282:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
1283: 
1284:         IF USED(loc_cCursor)
1285:             SELECT (loc_cCursor)
1286:             GO TOP
1287:             THIS.grd_4c_Listas.Refresh()
1288:             THIS.grd_4c_Listas.SetFocus()
1289:         ELSE
1290:             IF !THIS.CarregarGradeLista()
1291:                 MsgAviso("Nenhuma lista de pre" + CHR(231) + "o dispon" + CHR(237) + "vel.", "Aviso")
1292:             ENDIF
1293:         ENDIF
1294:     ENDPROC
1295: 
1296:     *--------------------------------------------------------------------------
1297:     * FormParaBO - Copia dados do form para o Business Object
1298:     * Neste dialogo OPERACIONAL, popula this_cLprecos com a lista selecionada
1299:     *--------------------------------------------------------------------------
1300:     PROCEDURE FormParaBO()
1301:         LOCAL loc_cCursor
1302: 
1303:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorListas
1304: 
1305:         IF USED(loc_cCursor)
1306:             SELECT (loc_cCursor)
1307:             IF !EOF()
1308:                 THIS.this_oBusinessObject.this_cLprecos = ALLTRIM(lprecos)
1309:             ENDIF
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     *--------------------------------------------------------------------------
1314:     * BOParaForm - Atualiza o form com dados do Business Object
1315:     * Refresca os grids com os cursores atuais do BO
1316:     *--------------------------------------------------------------------------
1317:     PROCEDURE BOParaForm()
1318:         LOCAL loc_cCursorListas, loc_cCursorItens
1319: 
1320:         loc_cCursorListas = THIS.this_oBusinessObject.this_cCursorListas
1321:         loc_cCursorItens  = THIS.this_oBusinessObject.this_cCursorItens

*-- Linhas 1441 a 1459:
1441:         IF VARTYPE(loc_cCur) != "C" OR !USED(loc_cCur) OR EOF(loc_cCur)
1442:             RETURN
1443:         ENDIF
1444:         SELECT (loc_cCur)
1445:         *-- Gate do When legado: so a transicao 0 -> 1 eh permitida
1446:         IF VARTYPE(lMarcas) == "L"
1447:             IF !lMarcas
1448:                 REPLACE lMarcas WITH .T.
1449:             ENDIF
1450:         ELSE
1451:             IF lMarcas = 0
1452:                 REPLACE lMarcas WITH 1
1453:             ENDIF
1454:         ENDIF
1455:         THIS.grd_4c_Itens.Refresh()
1456:     ENDPROC
1457: 
1458:     PROCEDURE TgItens1MouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1459:         THIS.TgItens1KeyPress(13, 0)


### BO (C:\4c\projeto\app\classes\SigPrSlpBO.prg):
*==============================================================================
* SigPrSlpBO.prg - Business Object: Selecao Lista de Preco
* Herda de: BusinessBase
* Tabelas: SigCdLpc (listas de preco), SigCdLpi (itens da lista)
* Tipo: OPERACIONAL - dialogo filho do form de pedido
*==============================================================================

DEFINE CLASS SigPrSlpBO AS BusinessBase

    *-- Configuracao da tabela base
    this_cTabela     = "SigCdLpi"
    this_cCampoChave = "cidchaves"

    *-- Cursores internos
    this_cCursorListas = "cursor_4c_Listas"
    this_cCursorItens  = "cursor_4c_Itens"

    *-- Propriedades mapeadas para colunas de SigCdLpi
    this_cCidchaves   = ""
    this_cCgrus       = ""
    this_nComiss      = 0
    this_cCpros       = ""
    this_cDpros       = ""
    this_lFlagutabs   = .F.
    this_cLprecos     = ""
    this_cMoevs       = ""
    this_nPvens       = 0
    this_dVencis      = {}
    this_dVencfs      = {}
    this_cOrdems      = ""
    this_cCcontroles  = ""
    this_nEan13       = 0
    this_nPcuss       = 0
    this_cReffs       = ""
    this_nPrecode     = 0

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdLpi"
        THIS.this_cCampoChave = "cidchaves"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarListasDisponiveis - Carrega SigCdLpc excluindo a lista atual
    * par_cLPrecoExcluir: codigo da lista de preco atual (a ser excluida)
    * Popula cursor_4c_Listas com colunas: lprecos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarListasDisponiveis(par_cLPrecoExcluir)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF USED(THIS.this_cCursorListas)
                USE IN (THIS.this_cCursorListas)
            ENDIF

            loc_cSQL = "SELECT lprecos FROM SigCdLpc " + ;
                       "WHERE lprecos <> " + EscaparSQL(par_cLPrecoExcluir) + " " + ;
                       "ORDER BY lprecos"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorListas) > 0
                SELECT (THIS.this_cCursorListas)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                *-- Sem modal aqui: quem reporta eh o form, com a mensagem
                *-- do legado + este detalhe (evita dois dialogos)
                THIS.this_cMensagemErro = "Falha ao carregar listas de pre" + ;
                                          CHR(231) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensDaLista - Carrega SigCdLpi de uma lista especifica
    * par_cLPrecos: codigo da lista de preco selecionada
    * Popula cursor_4c_Itens com lMarcas=0 e todos os campos de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensDaLista(par_cLPrecos)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            IF USED(THIS.this_cCursorItens)
                USE IN (THIS.this_cCursorItens)
            ENDIF

            loc_cSQL = "SELECT 0 AS lMarcas, a.cgrus, a.comiss, a.cpros, a.dpros, " + ;
                       "a.flagutabs, a.lprecos, a.moevs, a.pvens, a.vencis, a.vencfs, " + ;
                       "a.ordems, a.ccontroles, a.cidchaves, a.ean13, a.pcuss, " + ;
                       "a.reffs, a.precode " + ;
                       "FROM SigCdLpi a " + ;
                       "WHERE a.lprecos = " + EscaparSQL(par_cLPrecos) + " " + ;
                       "ORDER BY a.cpros"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorItens) > 0
                SELECT (THIS.this_cCursorItens)
                GO TOP
                loc_lSucesso = .T.
            ELSE
                *-- Sem modal aqui: quem reporta eh o form (ver acima)
                THIS.this_cMensagemErro = "Falha ao carregar itens da lista de " + ;
                                          "pre" + CHR(231) + "o." + CHR(13) + CapturarErroSQL()
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AdicionarItensMarcados - Copia itens marcados para o cursor de destino
    * par_cLPrecoAtual:        codigo da lista atual (destino)
    * par_cCursorDestino:      nome do cursor VFP local do form pai (CrSigCdLpi)
    * par_lAplicarArredond:    .T. se deve arredondar pvens (CompVenda <> "C")
    * Retorna: numero de itens adicionados, -1 em caso de erro
    *--------------------------------------------------------------------------
    PROCEDURE AdicionarItensMarcados(par_cLPrecoAtual, par_cCursorDestino, par_lAplicarArredond)
        LOCAL loc_nAdicionados, loc_oErro, loc_cLPrecoAtual, loc_lPodeExecutar
        LOCAL loc_lTemTag

        loc_nAdicionados    = 0
        loc_lTemTag         = .F.
        loc_lPodeExecutar   = .T.
        loc_cLPrecoAtual    = ALLTRIM(par_cLPrecoAtual)

        IF !USED(THIS.this_cCursorItens)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF
        IF loc_lPodeExecutar AND !USED(par_cCursorDestino)
            loc_lPodeExecutar = .F.
            loc_nAdicionados  = -1
        ENDIF

        IF loc_lPodeExecutar
            TRY
                *-- Remove itens vazios do cursor destino (sem cpros)
                *-- Legado: "Delete From CrSigCdLpi Where Empty(cpros)". A
                *-- forma SQL com NOME DE CURSOR EM EXPRESSAO - DELETE FROM
                *-- (var) - nao tem precedente nenhum no projeto; o padrao
                *-- estabelecido eh SELECT (alias) + DELETE FOR <cond>
                *-- (FpdBO:282, GcpBO:406).
                SELECT (par_cCursorDestino)
                DELETE FOR EMPTY(cpros)

                SELECT (THIS.this_cCursorItens)
                GO TOP

                *-- O legado usa Seek(...,'CrSigCdLpi','CPros'), que pressupoe a
                *-- TAG "CPros" sempre presente - verdade no cursor que o
                *-- AddCursor do frmcadastro Fortyus cria. No pai MIGRADO a tag
                *-- eh condicional: o FormLpr so faz "INDEX ON PADR(cpros,14)
                *-- TAG cpros" quando CarregarItens teve sucesso, entao em
                *-- INCLUIR (cursor recem-criado por CREATE CURSOR) ela NAO
                *-- existe e o SEEK estouraria dentro do TRY, devolvendo -1 e
                *-- exibindo "Erro ao adicionar itens" - sem nada ter sido
                *-- adicionado. Medir a tag UMA vez, fora do SCAN, e cair para
                *-- LOCATE quando faltar: os dois respondem a MESMA pergunta do
                *-- legado ("este produto ja esta no destino?").
                loc_lTemTag = THIS.DestinoTemTagCPros(par_cCursorDestino)

                SCAN
                    *-- Campos lidos do alias CORRENTE (o SELECT acima posiciona
                    *-- em this_cCursorItens): o nome do cursor eh PROPRIEDADE,
                    *-- citar "cursor_4c_Itens" literal quebra se ela mudar
                    IF lMarcas = 1
                        *-- Verifica se cpros ja existe no cursor destino
                        IF !THIS.ExisteProdutoNoDestino(cpros, par_cCursorDestino, loc_lTemTag)
                            SCATTER MEMVAR

                            m.lMarcas   = 0
                            m.lprecos   = loc_cLPrecoAtual
                            m.cidchaves = fUniqueIds()
                            m.vencis    = NVL(m.vencis, {})
                            m.vencfs    = NVL(m.vencfs, {})

                            *-- PENDENCIA DELIBERADA (regras #17 e #27)
                            *-- Legado: m.pvens = fArredondamento(m.pvens,
                            *-- ThisForm.ParentForm.poDataMgr) quando
                            *-- CompVenda <> "C". fArredondamento eh funcao
                            *-- GLOBAL do legado (SIGFUNCS) que NAO veio no
                            *-- acervo - nao existe na pasta Framework nem em
                            *-- app/utils. Ela devolve VALOR DE CALCULO, e a
                            *-- regra #27 manda DEIXAR AUSENTE em vez de
                            *-- inventar stub: ROUND(m.pvens, 2) nao eh a regra
                            *-- do legado (o arredondamento real vem de
                            *-- parametro gravado no banco, lido via poDataMgr)
                            *-- e gravaria PRECO ERRADO em silencio.
                            *-- par_lAplicarArredond continua chegando do form
                            *-- para que ligar fArredondamento seja uma linha
                            *-- so quando a funcao for portada.
                            *-- Mesmo tratamento em FormLpr.prg:2810 (mesma
                            *-- coluna pvens, mesma tabela SigCdLpi).

                            INSERT INTO (par_cCursorDestino) FROM MEMVAR
                            loc_nAdicionados = loc_nAdicionados + 1

                            SELECT (THIS.this_cCursorItens)
                        ENDIF
                    ENDIF
                ENDSCAN

            CATCH TO loc_oErro
                MsgErro(loc_oErro.Message, "Erro")
                loc_nAdicionados = -1
            ENDTRY
        ENDIF

        RETURN loc_nAdicionados
    ENDPROC

    *--------------------------------------------------------------------------
    * DestinoTemTagCPros - .T. quando o cursor de destino tem a TAG "CPros"
    * que o Seek do legado pressupoe.
    *
    * Enumera as tags por NUMERO com TAG(n), que devolve "" passado o ultimo
    * indice - mesma forma ja usada em SIGPRESTBO.prg:365. Evita de proposito
    * TAGNO("CPros") / TAGCOUNT(cCDX, alias): a 1a dispara erro com tag
    * inexistente (que eh exatamente o caso a detectar) e a 2a exige o
    * argumento do .CDX, sem precedente no projeto.
    *
    * TAG(n) le a work area CORRENTE, por isso o SELECT - com o alias salvo e
    * restaurado, ja que o chamador esta posicionado no cursor de itens.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE DestinoTemTagCPros(par_cCursorDestino)
        LOCAL loc_lTem, loc_cAliasAnterior, loc_nTag

        loc_lTem           = .F.
        loc_cAliasAnterior = ALIAS()

        IF !USED(par_cCursorDestino)
            RETURN .F.
        ENDIF

        SELECT (par_cCursorDestino)

        loc_nTag = 1
        DO WHILE !EMPTY(TAG(loc_nTag))
            IF UPPER(ALLTRIM(TAG(loc_nTag))) == "CPROS"
                loc_lTem = .T.
                EXIT
            ENDIF
            loc_nTag = loc_nTag + 1
        ENDDO

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lTem
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteProdutoNoDestino - Responde a pergunta do Seek legado: o produto
    * par_cCpros ja esta no cursor de destino?
    *
    * par_lTemTag = .T.  -> usa SEEK pela TAG "CPros" (caminho do legado)
    * par_lTemTag = .F.  -> usa LOCATE FOR, para o cursor que nao foi indexado
    *
    * O LOCATE exige SELECT do destino, o que TROCA o alias corrente; como
    * quem chama esta no meio de um SCAN do cursor de itens, o alias eh
    * salvo e restaurado aqui - sem isso o SCAN passaria a andar no cursor
    * errado e o laco nao terminaria onde deve.
    *
    * A comparacao usa PADR na largura da coluna do destino: cpros eh char de
    * largura fixa e o LOCATE tem de casar o MESMO valor que a tag
    * "INDEX ON PADR(cpros, 14)" casaria (regra #42 - chave posicional).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExisteProdutoNoDestino(par_cCpros, par_cCursorDestino, par_lTemTag)
        LOCAL loc_lExiste, loc_cAliasAnterior, loc_cChave, loc_nLargura

        IF par_lTemTag
            RETURN SEEK(par_cCpros, par_cCursorDestino, "CPros")
        ENDIF

        loc_lExiste        = .F.
        loc_cAliasAnterior = ALIAS()

        SELECT (par_cCursorDestino)

        loc_nLargura = FSIZE("cpros", par_cCursorDestino)
        IF loc_nLargura <= 0
            loc_nLargura = LEN(par_cCpros)
        ENDIF
        loc_cChave = PADR(par_cCpros, loc_nLargura)

        LOCATE FOR PADR(cpros, loc_nLargura) == loc_cChave
        loc_lExiste = FOUND()

        IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
            SELECT (loc_cAliasAnterior)
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 1
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os itens do cursor de itens
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        LOCAL loc_oErro

        TRY
            IF USED(THIS.this_cCursorItens)
                SELECT (THIS.this_cCursorItens)
                REPLACE ALL lMarcas WITH 0
                GO TOP
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        IF USED(THIS.this_cCursorListas)
            USE IN (THIS.this_cCursorListas)
        ENDIF
        IF USED(THIS.this_cCursorItens)
            USE IN (THIS.this_cCursorItens)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega dados do cursor para as propriedades this_*
    * par_cAliasCursor: nome do cursor com os dados de SigCdLpi
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves  = TratarNulo(cidchaves, "C")
                THIS.this_cCgrus      = TratarNulo(cgrus, "C")
                THIS.this_nComiss     = TratarNulo(comiss, "N")
                THIS.this_cCpros      = TratarNulo(cpros, "C")
                THIS.this_cDpros      = TratarNulo(dpros, "C")

                IF VARTYPE(flagutabs) = "L"
                    THIS.this_lFlagutabs = flagutabs
                ELSE
                    IF VARTYPE(flagutabs) = "N"
                        IF VARTYPE(flagutabs) = "L"
                            THIS.this_lFlagutabs = flagutabs
                        ELSE
                            THIS.this_lFlagutabs = (NVL(flagutabs, 0) = 1)
                        ENDIF
                    ELSE
                        THIS.this_lFlagutabs = NVL(flagutabs, .F.)
                    ENDIF
                ENDIF

                THIS.this_cLprecos    = TratarNulo(lprecos, "C")
                THIS.this_cMoevs      = TratarNulo(moevs, "C")
                THIS.this_nPvens      = TratarNulo(pvens, "N")
                THIS.this_dVencis     = NVL(vencis, {})
                THIS.this_dVencfs     = NVL(vencfs, {})
                THIS.this_cOrdems     = TratarNulo(ordems, "C")
                THIS.this_cCcontroles = TratarNulo(ccontroles, "C")
                THIS.this_nEan13      = TratarNulo(ean13, "N")
                THIS.this_nPcuss      = TratarNulo(pcuss, "N")
                THIS.this_cReffs      = TratarNulo(reffs, "C")
                THIS.this_nPrecode    = TratarNulo(precode, "N")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves do registro atual
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdLpi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cCidchaves)
                THIS.this_cCidchaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigCdLpi (cgrus, comiss, cpros, dpros, flagutabs, " + ;
                       "lprecos, moevs, pvens, vencis, vencfs, ordems, ccontroles, " + ;
                       "cidchaves, ean13, pcuss, reffs, precode) VALUES (" + ;
                       EscaparSQL(THIS.this_cCgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nComiss, 2) + ", " + ;
                       EscaparSQL(THIS.this_cCpros) + ", " + ;
                       EscaparSQL(THIS.this_cDpros) + ", " + ;
                       IIF(THIS.this_lFlagutabs, "1", "0") + ", " + ;
                       EscaparSQL(THIS.this_cLprecos) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPvens, 6) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencis), "NULL", FormatarDataSQL(THIS.this_dVencis)) + ", " + ;
                       IIF(EMPTY(THIS.this_dVencfs), "NULL", FormatarDataSQL(THIS.this_dVencfs)) + ", " + ;
                       EscaparSQL(THIS.this_cOrdems) + ", " + ;
                       EscaparSQL(THIS.this_cCcontroles) + ", " + ;
                       EscaparSQL(THIS.this_cCidchaves) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEan13, 0) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPcuss, 6) + ", " + ;
                       EscaparSQL(THIS.this_cReffs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPrecode, 5) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir item da lista de pre" + CHR(231) + "o."
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa recursos ao destruir o BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

