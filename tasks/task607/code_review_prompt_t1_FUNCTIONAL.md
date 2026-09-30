# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CABECALHO, CNT_4C_OBSERVACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CARGA-DADOS] Metodo ValidarContaOrigem faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.this_oBusinessObject.this_cEmpresaDestino define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.this_oBusinessObject.this_cEmpresaDestino.RecordSource).
- [LAYOUT-POSITION] Controle 'Origem' (parent: SIGPRES2.Pagina.Dados): Top original=173 vs migrado 'cnt_4c_Origem' Top=5 (diff=168px, tolerancia=30px)

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigpres2.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2041 linhas total):

*-- Linhas 42 a 174:
42:     *===========================================================================
43:     * Init - Recebe os mesmos 3 parametros posicionais do Init legado
44:     * (Lparameters _Chave, pDataSes, poForm). Guarda os valores em properties
45:     * ANTES de chamar DODEFAULT(), pois FormBase.Init() -> InicializarForm()
46:     * ja precisa deles (this_cTituloForm define o Caption do form).
47:     *===========================================================================
48:     PROCEDURE Init(par_cChave, par_cCidChaveMovimento, par_oFormPai)
49:         IF VARTYPE(par_cChave) = "C"
50:             THIS.this_cChaveRecebida = par_cChave
51:             THIS.this_cTituloForm    = par_cChave
52:         ENDIF
53: 
54:         IF VARTYPE(par_cCidChaveMovimento) = "C"
55:             THIS.this_cCidChaveRecebida = par_cCidChaveMovimento
56:         ENDIF
57: 
58:         IF VARTYPE(par_oFormPai) = "O"
59:             THIS.this_oFormPai = par_oFormPai
60:         ENDIF
61: 
62:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
63:         RETURN DODEFAULT()
64:     ENDPROC
65: 
66:     *===========================================================================
67:     * InicializarForm - Configura estrutura completa
68:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
69:     *===========================================================================
70:     PROTECTED PROCEDURE InicializarForm()
71:         LOCAL loc_lSucesso
72:         loc_lSucesso = .F.
73: 
74:         TRY
75:             THIS.this_oBusinessObject = CREATEOBJECT("sigpres2BO")
76: 
77:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
78:                 MostrarErro("Erro ao criar sigpres2BO" + CHR(13) + ;
79:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
80:                     "Formsigpres2.InicializarForm")
81:             ELSE
82:                 THIS.ConfigurarPageFrame()
83:                 THIS.pgf_4c_Paginas.Visible = .T.
84:                 THIS.AlternarPagina(1)
85: 
86:                 loc_lSucesso = .T.
87:             ENDIF
88: 
89:         CATCH TO loException
90:             MostrarErro("Erro ao inicializar Formsigpres2:" + CHR(13) + ;
91:                 loException.Message + CHR(13) + ;
92:                 "Linha: " + TRANSFORM(loException.LineNo), ;
93:                 "Formsigpres2.InicializarForm")
94:         ENDTRY
95: 
96:         RETURN loc_lSucesso
97:     ENDPROC
98: 
99:     *===========================================================================
100:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
101:     * Top=-29 para esconder abas; controles compensam +29 no Top
102:     *===========================================================================
103:     PROTECTED PROCEDURE ConfigurarPageFrame()
104:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
105: 
106:         WITH THIS.pgf_4c_Paginas
107:             .PageCount = 2
108:             .Top       = -29
109:             .Left      = 0
110:             .Width     = THIS.Width
111:             .Height    = THIS.Height + 29
112:             .Tabs      = .F.
113:             .Visible   = .T.
114: 
115:             .Page1.Caption   = "Lista"
116:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117:             .Page1.BackColor = RGB(255, 255, 255)
118: 
119:             .Page2.Caption   = "Dados"
120:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
121:             .Page2.BackColor = RGB(255, 255, 255)
122:         ENDWITH
123: 
124:         THIS.ConfigurarPaginaLista()
125:         THIS.ConfigurarPaginaDados()
126:     ENDPROC
127: 
128:     *===========================================================================
129:     * ConfigurarPaginaLista - Estrutura base de Page1 (grid e botoes CRUD
130:     * entram na Fase seguinte). No legado, a maior parte dos botoes deste
131:     * grupo (Inserir/Alterar/Procurar/Excluir) fica oculta - o dialogo so
132:     * mantem a consulta do movimento ja selecionado pelo form pai.
133:     *===========================================================================
134:     PROTECTED PROCEDURE ConfigurarPaginaLista()
135:         LOCAL loc_oPagina
136:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
137: 
138:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
139: 
140:         *-- Container Cabecalho (cntSombra no legado, herdado do frmcadastro)
141:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
142:         WITH loc_oPagina.cnt_4c_Cabecalho
143:             .Top         = 31
144:             .Left        = 0
145:             .Width       = THIS.Width
146:             .Height      = 80
147:             .BackColor   = RGB(100, 100, 100)
148:             .BorderWidth = 0
149:             .Visible     = .T.
150: 
151:             .AddObject("lbl_4c_Sombra", "Label")
152:             WITH .lbl_4c_Sombra
153:                 .Caption   = THIS.Caption
154:                 .Top       = 15
155:                 .Left      = 10
156:                 .Width     = THIS.Width
157:                 .Height    = 40
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 16
160:                 .FontBold  = .T.
161:                 .ForeColor = RGB(0, 0, 0)
162:                 .BackStyle = 0
163:                 .AutoSize  = .F.
164:                 .Visible   = .T.
165:             ENDWITH
166: 
167:             .AddObject("lbl_4c_Titulo", "Label")
168:             WITH .lbl_4c_Titulo
169:                 .Caption   = THIS.Caption
170:                 .Top       = 18
171:                 .Left      = 10
172:                 .Width     = THIS.Width
173:                 .Height    = 46
174:                 .FontName  = "Tahoma"

*-- Linhas 303 a 444:
303: 
304:         ENDWITH
305: 
306:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
308:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
309:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
310:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
311: 
312:         *-- Container Saida (Grupo_Saida no legado) - padrao canonico do
313:         *-- sistema novo, prevalece sobre o PILAR 1 (regra #10 CLAUDE.md)
314:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
315:         WITH loc_oPagina.cnt_4c_Saida
316:             .Top         = 29
317:             .Left        = 917
318:             .Width       = 90
319:             .Height      = 85
320:             .BackStyle   = 0
321:             .BorderWidth = 0
322:             .Visible     = .T.
323: 
324:             .AddObject("cmd_4c_Encerrar", "CommandButton")
325:             WITH .cmd_4c_Encerrar
326:                 .Caption          = "Encerrar"
327:                 .Picture          = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
328:                 .PicturePosition  = 13
329:                 .Top              = 5
330:                 .Left             = 5
331:                 .Width            = 75
332:                 .Height           = 75
333:                 .BackColor        = RGB(255, 255, 255)
334:                 .ForeColor        = RGB(90, 90, 90)
335:                 .FontName         = "Comic Sans MS"
336:                 .FontBold         = .T.
337:                 .FontItalic       = .T.
338:                 .FontSize         = 8
339:                 .SpecialEffect    = 0
340:                 .MousePointer     = 15
341:                 .WordWrap         = .T.
342:                 .AutoSize         = .F.
343:             ENDWITH
344:         ENDWITH
345: 
346:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
347: 
348:         *-- Grid da Lista (Grade no legado) - somente leitura, mostra o
349:         *-- resumo do movimento (Origem/Destino/Doc.Op/Usuario/Status/EmpO/
350:         *-- EmpD) que o form pai ja selecionou. ControlSource/Header sao
351:         *-- (re)definidos em CarregarLista(), apos o RecordSource - regra
352:         *-- "Grade perde cabecalhos apos RecordSource" (FORMCOR_LICOES).
353:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
354:         WITH loc_oPagina.grd_4c_Lista
355:             .Top             = 150
356:             .Left            = 35
357:             .Width           = 944
358:             .Height          = 470
359:             .ColumnCount     = 11
360:             .ReadOnly        = .T.
361:             .DeleteMark      = .F.
362:             .RecordMark      = .F.
363:             .FontName        = "Tahoma"
364:             .FontSize        = 8
365:             .ForeColor       = RGB(0, 0, 0)
366:             .BackColor       = RGB(255, 255, 255)
367:             .GridLineColor   = RGB(238, 238, 238)
368:             .HighlightBackColor = RGB(255, 255, 255)
369:             .HighlightForeColor = RGB(15, 41, 104)
370:             .HighlightStyle  = 2
371:             .RowHeight       = 16
372:             .ScrollBars      = 2
373:             .Visible         = .T.
374:         ENDWITH
375: 
376:         THIS.TornarControlesVisiveis(loc_oPagina)
377: 
378:         *-- AcertaBotoes (legado): este dialogo NAO permite Incluir/Alterar/
379:         *-- Excluir/Procurar sobre o registro ja selecionado pelo form pai -
380:         *-- so "Consultar" (aqui Visualizar) fica ativo, e o grupo encolhe
381:         *-- para Width=90 (10+80), com Visualizar reposicionado para Left=5.
382:         *-- Transcricao literal de Pagina.Lista.Grupo_op.AcertaBotoes (regra
383:         *-- #17 CLAUDE.md - regra de negocio do legado, nao PILAR 1). Aplicado
384:         *-- DEPOIS de TornarControlesVisiveis (regra "Problema 26" - senao a
385:         *-- rotina generica reexibe estes botoes).
386:         WITH loc_oPagina.cnt_4c_Botoes
387:             .cmd_4c_Incluir.Enabled = .F.
388:             .cmd_4c_Incluir.Visible = .F.
389:             .cmd_4c_Alterar.Enabled = .F.
390:             .cmd_4c_Alterar.Visible = .F.
391:             .cmd_4c_Excluir.Enabled = .F.
392:             .cmd_4c_Excluir.Visible = .F.
393:             .cmd_4c_Buscar.Enabled  = .F.
394:             .cmd_4c_Buscar.Visible  = .F.
395:             .cmd_4c_Visualizar.Left = 5
396:             .Width                  = 90
397:         ENDWITH
398:     ENDPROC
399: 
400:     *===========================================================================
401:     * ConfigurarPaginaDados - Estrutura base de Page2 (campos entram nas
402:     * Fases seguintes)
403:     *===========================================================================
404:     PROTECTED PROCEDURE ConfigurarPaginaDados()
405:         LOCAL loc_oPagina
406:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
407: 
408:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
409: 
410:         *-- Cabecalho cinza (identico ao da pagina Lista - regra #11 CLAUDE.md)
411:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
412:         WITH loc_oPagina.cnt_4c_Cabecalho
413:             .Top         = 29
414:             .Left        = 0
415:             .Width       = THIS.Width
416:             .Height      = 80
417:             .BackColor   = RGB(100, 100, 100)
418:             .BorderWidth = 0
419:             .Visible     = .T.
420: 
421:             .AddObject("lbl_4c_Sombra", "Label")
422:             WITH .lbl_4c_Sombra
423:                 .Caption   = THIS.Caption
424:                 .Top       = 15
425:                 .Left      = 10
426:                 .Width     = THIS.Width
427:                 .Height    = 40
428:                 .FontName  = "Tahoma"
429:                 .FontSize  = 16
430:                 .FontBold  = .T.
431:                 .ForeColor = RGB(0, 0, 0)
432:                 .BackStyle = 0
433:                 .AutoSize  = .F.
434:                 .Visible   = .T.
435:             ENDWITH
436: 
437:             .AddObject("lbl_4c_Titulo", "Label")
438:             WITH .lbl_4c_Titulo
439:                 .Caption   = THIS.Caption
440:                 .Top       = 18
441:                 .Left      = 10
442:                 .Width     = THIS.Width
443:                 .Height    = 46
444:                 .FontName  = "Tahoma"

*-- Linhas 518 a 562:
518:             ENDWITH
519:         ENDWITH
520: 
521:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
522:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
523: 
524:         *-- FASE 5/8 - Campos principais (parte 1): bloco de cabecalho do
525:         *-- movimento (Codigo/Docto/Data/Prazo Entrega/OP/Status/Tb.Desconto)
526:         *-- e o container Origem/Destino/Representante. Todos os Top sao os
527:         *-- valores do SCX legado (Pagina.Dados.*) + 29 de compensacao do
528:         *-- PageFrame.Top=-29 (regra CLAUDE.md - "Compensacao PageFrame.Top").
529:         *-- Descricao do item (Get_descr), grades (fwgrade1/GradeOperacao),
530:         *-- imagem (FigJpg) e observacao geral (Container1) ficam para a
531:         *-- FASE 6/8 (segunda metade dos campos).
532: 
533:         *-- Botao "Entrega" (cmdEntrega no legado) - CommandGroup com 1
534:         *-- botao que abre "Do Form SigOpEnt" para alterar o Prazo de
535:         *-- Entrega (comportamento.json). Handler de Click fica para fase
536:         *-- posterior (chama form ainda nao migrado nesta tarefa).
537:         loc_oPagina.AddObject("cmg_4c_Entrega", "CommandGroup")
538:         WITH loc_oPagina.cmg_4c_Entrega
539:             .Top         = 36
540:             .Left        = 23
541:             .Width       = 90
542:             .Height      = 110
543:             .ButtonCount = 1
544:             .BackStyle   = 0
545:             .BorderStyle = 0
546:             .Themes      = .F.
547:             .Visible     = .T.
548:         ENDWITH
549:         WITH loc_oPagina.cmg_4c_Entrega.Buttons(1)
550:             .Top             = 5
551:             .Left            = 5
552:             .Width           = 75
553:             .Height          = 75
554:             .Caption         = "\<Entrega"
555:             .Picture         = gc_4c_CaminhoIcones + "geral_relogio_60.jpg"
556:             .PicturePosition = 13
557:             .ToolTipText     = "Alterar Prazo de Entrega"
558:             .FontName        = "Comic Sans MS"
559:             .FontBold        = .T.
560:             .FontItalic      = .T.
561:             .FontSize        = 8
562:             .ForeColor       = RGB(90, 90, 90)

*-- Linhas 793 a 814:
793:             .Alignment = 0
794:             .Visible   = .T.
795:         ENDWITH
796: 
797:         *-- Container Origem/Destino/Representante (Origem no legado)
798:         loc_oPagina.AddObject("cnt_4c_Origem", "Container")
799:         WITH loc_oPagina.cnt_4c_Origem
800:             .Top         = 202
801:             .Left        = 27
802:             .Width       = 582
803:             .Height      = 164
804:             .BackStyle   = 1
805:             .BackColor   = RGB(255, 255, 255)
806:             .BorderColor = RGB(136, 188, 189)
807:             .SpecialEffect = 0
808:             .Visible     = .T.
809: 
810:             *-- Titulos de secao
811:             .AddObject("lbl_4c_Origem", "Label")
812:             WITH .lbl_4c_Origem
813:                 .Caption   = "Origem"
814:                 .Top       = 5

*-- Linhas 1175 a 1218:
1175:             .Visible         = .T.
1176:         ENDWITH
1177: 
1178:         BINDEVENT(loc_oPagina.grd_4c_Itens, "AfterRowColChange", THIS, "GridItensAfterRowColChange")
1179: 
1180:         *-- Descricao do item selecionado (Get_descr -> xEestI.DPros)
1181:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
1182:         WITH loc_oPagina.txt_4c_Descr
1183:             .Top       = 591
1184:             .Left      = 23
1185:             .Width     = 454
1186:             .Height    = 23
1187:             .ReadOnly  = .T.
1188:             .MaxLength = 65
1189:             .ForeColor = RGB(0, 0, 0)
1190:             .BackColor = RGB(255, 255, 255)
1191:             .Value     = ""
1192:             .Visible   = .T.
1193:         ENDWITH
1194:         loc_oPagina.AddObject("lbl_4c_Descr", "Label")
1195:         WITH loc_oPagina.lbl_4c_Descr
1196:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1197:             .Top       = 575
1198:             .Left      = 23
1199:             .Width     = 200
1200:             .Height    = 15
1201:             .FontName  = "Tahoma"
1202:             .FontSize  = 8
1203:             .ForeColor = RGB(90, 90, 90)
1204:             .BackStyle = 0
1205:             .AutoSize  = .F.
1206:             .Alignment = 0
1207:             .Visible   = .T.
1208:         ENDWITH
1209: 
1210:         *-- Observacao do item selecionado (Get_obs -> xEestI.OBS)
1211:         loc_oPagina.AddObject("edt_4c_ObservacaoItem", "EditBox")
1212:         WITH loc_oPagina.edt_4c_ObservacaoItem
1213:             .Top       = 590
1214:             .Left      = 496
1215:             .Width     = 454
1216:             .Height    = 24
1217:             .ReadOnly  = .T.
1218:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 1328 a 1440:
1328:         *-- chamadas diretamente com os proprios TextBox (pCod/pDsc) -
1329:         *-- mesmo padrao ja em producao em FormSigPrEs1.prg
1330:         *-- (ValidarGrupoCodigo/ValidarContaCodigo): a funcao faz o SEEK
1331:         *-- exato e so abre o picker interno (FormBuscaSimples) quando
1332:         *-- nao acha, preenchendo os TextBox sozinha.
1333:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_GrupoOrigem, "LostFocus", THIS, "ValidarGrupoOrigem")
1334:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaOrigem, "LostFocus", THIS, "ValidarContaOrigem")
1335:         BINDEVENT(loc_oPagina.cnt_4c_Origem.txt_4c_ContaDestino, "LostFocus", THIS, "ValidarContaDestino")
1336:         BINDEVENT(loc_oPagina.cnt_4c_Origem.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosClick")
1337: 
1338:         THIS.TornarControlesVisiveis(loc_oPagina)
1339:     ENDPROC
1340: 
1341:     *===========================================================================
1342:     * AlternarPagina - Alterna entre Page1 (Lista, 1) e Page2 (Dados, 2).
1343:     * Ao voltar para a Lista, recarrega o resumo do movimento (regra "Popular
1344:     * cursor NAO repinta a grade" - FORMCOR_LICOES / CLAUDE.md).
1345:     *===========================================================================
1346:     PROCEDURE AlternarPagina(par_nPagina)
1347:         LOCAL loc_lResultado
1348:         loc_lResultado = .F.
1349: 
1350:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1351:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1352: 
1353:             IF par_nPagina = 1
1354:                 THIS.this_cModoAtual = "LISTA"
1355:                 THIS.CarregarLista()
1356:             ENDIF
1357: 
1358:             loc_lResultado = .T.
1359:         ENDIF
1360: 
1361:         RETURN loc_lResultado
1362:     ENDPROC
1363: 
1364:     *===========================================================================
1365:     * CarregarLista - Popula grd_4c_Lista com o resumo do movimento (Origem/
1366:     * Destino/Doc.Op/Usuario/Status/EmpO/EmpD) equivalente ao csTemporario do
1367:     * legado (MontaGrades). Esta tela NAO tem Buscar/lote de registros - o
1368:     * form pai ja identificou o movimento (this_cCidChaveRecebida) antes de
1369:     * abrir este dialogo, entao a "lista" e sempre a linha unica desse
1370:     * movimento (por isso o Grupo_op so mantem "Visualizar" ativo).
1371:     *===========================================================================
1372:     PROCEDURE CarregarLista()
1373:         LOCAL loc_lResultado, loc_oGrid
1374:         loc_lResultado = .F.
1375: 
1376:         TRY
1377:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1378:                 loc_lResultado = .T.
1379:             ELSE
1380:                 IF EMPTY(ALLTRIM(THIS.this_cCidChaveRecebida))
1381:                     loc_lResultado = .F.
1382:                 ELSE
1383:                     IF ALLTRIM(TratarNulo(THIS.this_oBusinessObject.this_cCidChave, "")) != ;
1384:                             ALLTRIM(THIS.this_cCidChaveRecebida)
1385:                         THIS.this_oBusinessObject.CarregarPorCodigo(THIS.this_cCidChaveRecebida)
1386:                     ENDIF
1387: 
1388:                     IF USED("cursor_4c_Dados")
1389:                         USE IN cursor_4c_Dados
1390:                     ENDIF
1391: 
1392:                     CREATE CURSOR cursor_4c_Dados ;
1393:                         (numes N(6,0), datas T, grupoos C(10), contaos C(10), ;
1394:                          grupods C(10), contads C(10), nops N(10,0), usuars C(10), ;
1395:                          pstatus C(1), emps C(3), empds C(3))
1396: 
1397:                     APPEND BLANK IN cursor_4c_Dados
1398:                     SELECT cursor_4c_Dados
1399:                     REPLACE numes   WITH THIS.this_oBusinessObject.this_nNumero, ;
1400:                             datas   WITH THIS.this_oBusinessObject.this_dData, ;
1401:                             grupoos WITH THIS.this_oBusinessObject.this_cGrupoOrigem, ;
1402:                             contaos WITH THIS.this_oBusinessObject.this_cContaOrigem, ;
1403:                             grupods WITH THIS.this_oBusinessObject.this_cGrupoDestino, ;
1404:                             contads WITH THIS.this_oBusinessObject.this_cContaDestino, ;
1405:                             nops    WITH THIS.this_oBusinessObject.this_nNumeroOP, ;
1406:                             usuars  WITH THIS.this_oBusinessObject.this_cUsuario, ;
1407:                             pstatus WITH THIS.this_oBusinessObject.this_cStatus, ;
1408:                             emps    WITH THIS.this_oBusinessObject.this_cEmpresa, ;
1409:                             empds   WITH THIS.this_oBusinessObject.this_cEmpresaDestino
1410:                     GO TOP IN cursor_4c_Dados
1411: 
1412:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1413: 
1414:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1415:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Dados.numes"
1416:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Dados.datas"
1417:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Dados.grupoos"
1418:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Dados.contaos"
1419:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Dados.grupods"
1420:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Dados.contads"
1421:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Dados.nops"
1422:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Dados.usuars"
1423:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Dados.pstatus"
1424:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Dados.emps"
1425:                     loc_oGrid.Column11.ControlSource = "cursor_4c_Dados.empds"
1426: 
1427:                     loc_oGrid.Column1.Width  = 80
1428:                     loc_oGrid.Column2.Width  = 80
1429:                     loc_oGrid.Column3.Width  = 80
1430:                     loc_oGrid.Column4.Width  = 80
1431:                     loc_oGrid.Column5.Width  = 80
1432:                     loc_oGrid.Column6.Width  = 80
1433:                     loc_oGrid.Column7.Width  = 80
1434:                     loc_oGrid.Column8.Width  = 80
1435:                     loc_oGrid.Column9.Width  = 40
1436:                     loc_oGrid.Column9.Alignment = 2
1437:                     loc_oGrid.Column10.Width = 50
1438:                     loc_oGrid.Column11.Width = 50
1439: 
1440:                     loc_oGrid.Column1.Header1.Caption  = "C" + CHR(243) + "digo"

*-- Linhas 1469 a 1688:
1469:     * Dados em modo somente-leitura para o movimento ja carregado, com o
1470:     * grid de itens e a grade de operacoes (FASE 6/8).
1471:     *===========================================================================
1472:     PROCEDURE BtnVisualizarClick()
1473:         THIS.this_cModoAtual = "VISUALIZAR"
1474:         THIS.BOParaForm()
1475:         THIS.CarregarItensGrid()
1476:         THIS.CarregarOperacoesGrid()
1477:         THIS.HabilitarCampos(.T.)
1478:         THIS.AjustarBotoesPorModo()
1479:         THIS.AlternarPagina(2)
1480:     ENDPROC
1481: 
1482:     *===========================================================================
1483:     * BtnIncluirClick - Equivalente ao Grupo_op.Click(Opcao=1) do legado: este
1484:     * dialogo NAO permite Incluir sobre o movimento ja selecionado pelo form
1485:     * pai. AcertaBotoes (ConfigurarPaginaLista) ja deixa cmd_4c_Incluir com
1486:     * Enabled=.F./Visible=.F. - este metodo transcreve o proprio "Inlist(
1487:     * This.Value, 1, 3, 4, 5)" do legado, que apenas volta para a Pagina 1
1488:     * (ThisForm.mAtivaPagina1), sem abrir a Pagina de Dados (regra #17
1489:     * CLAUDE.md - regra de negocio, nao PILAR 1).
1490:     *===========================================================================
1491:     PROCEDURE BtnIncluirClick()
1492:         THIS.AlternarPagina(1)
1493:     ENDPROC
1494: 
1495:     *===========================================================================
1496:     * BtnAlterarClick - Equivalente ao Grupo_op.Click(Opcao=3) do legado: mesma
1497:     * transcricao do "Inlist(This.Value, 1, 3, 4, 5)" - cmd_4c_Alterar ja esta
1498:     * Enabled=.F./Visible=.F. via AcertaBotoes, este dialogo NAO permite Alterar
1499:     * o movimento.
1500:     *===========================================================================
1501:     PROCEDURE BtnAlterarClick()
1502:         THIS.AlternarPagina(1)
1503:     ENDPROC
1504: 
1505:     *===========================================================================
1506:     * BtnExcluirClick - Equivalente ao Grupo_op.Click(Opcao=4) do legado: mesma
1507:     * transcricao do "Inlist(This.Value, 1, 3, 4, 5)" - cmd_4c_Excluir ja esta
1508:     * Enabled=.F./Visible=.F. via AcertaBotoes, este dialogo NAO permite Excluir
1509:     * o movimento.
1510:     *===========================================================================
1511:     PROCEDURE BtnExcluirClick()
1512:         THIS.AlternarPagina(1)
1513:     ENDPROC
1514: 
1515:     *===========================================================================
1516:     * BtnEncerrarClick - Equivalente ao Grupo_Saida.Sair do legado: encerra o
1517:     * dialogo e devolve o controle ao form pai.
1518:     *===========================================================================
1519:     PROCEDURE BtnEncerrarClick()
1520:         THIS.Release()
1521:     ENDPROC
1522: 
1523:     *===========================================================================
1524:     * BtnBuscarClick - Equivalente ao Grupo_op.Click(Opcao=5) do legado (botao
1525:     * "procurar"): mesma transcricao do "Inlist(This.Value, 1, 3, 4, 5)" -
1526:     * cmd_4c_Buscar ja esta Enabled=.F./Visible=.F. via AcertaBotoes (o ramo
1527:     * 'PROCURAR' do Do Case abaixo do Inlist e codigo morto no legado - o
1528:     * proprio Inlist ja intercepta Value=5 antes de chegar la). Este dialogo
1529:     * NAO permite Buscar/Procurar sobre o movimento ja selecionado.
1530:     *===========================================================================
1531:     PROCEDURE BtnBuscarClick()
1532:         THIS.AlternarPagina(1)
1533:     ENDPROC
1534: 
1535:     *===========================================================================
1536:     * BtnSalvarClick - Equivalente a Grupo_Salva.Salva.Click do legado
1537:     * (=DoDefault() + Thisform.mAtivapagina1): nenhuma gravacao acontece -
1538:     * o Salva.Click do legado nao chama SQL nenhum, so volta para a Lista.
1539:     * Na pratica cmd_4c_Confirmar fica sempre desabilitado (ver
1540:     * AjustarBotoesPorModo), pois pcEscolha so chega a 'CONSULTAR' neste
1541:     * dialogo; o metodo e implementado por completude/fidelidade ao evento
1542:     * do legado, nao porque seja alcancavel pela UI.
1543:     *===========================================================================
1544:     PROCEDURE BtnSalvarClick()
1545:         THIS.AlternarPagina(1)
1546:     ENDPROC
1547: 
1548:     *===========================================================================
1549:     * BtnCancelarClick - Equivalente a Grupo_Salva.Cancelar.Click do legado
1550:     * (=DoDefault() + If ThisForm.plCancelar Then mAtivapagina1). plCancelar
1551:     * e property herdada do frmcadastro (Framework), nunca reatribuida neste
1552:     * form - default .T. no Framework, por isso a transcricao e incondicional.
1553:     * Unico botao realmente clicavel de cnt_4c_BotoesAcao neste dialogo.
1554:     *===========================================================================
1555:     PROCEDURE BtnCancelarClick()
1556:         THIS.LimparCampos()
1557:         THIS.AlternarPagina(1)
1558:     ENDPROC
1559: 
1560:     *===========================================================================
1561:     * AjustarBotoesPorModo - Habilita/desabilita cmd_4c_Confirmar/Cancelar de
1562:     * cnt_4c_BotoesAcao. Transcricao de Grupo_op.Click: "loGBotaosalva.Salva.
1563:     * Enabled = (Not .pcEscolha = 'CONSULTAR')". Como pcEscolha so assume
1564:     * 'CONSULTAR' neste dialogo (regra #17 CLAUDE.md - so a formula, sem
1565:     * reinterpretar: o ramo 'PROCURAR' e inalcancavel, ver BtnBuscarClick),
1566:     * a formula colapsa em constante: Confirmar SEMPRE desabilitado.
1567:     *===========================================================================
1568:     PROCEDURE AjustarBotoesPorModo()
1569:         LOCAL loc_oBotoesAcao
1570:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1571: 
1572:         loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1573:         loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1574:     ENDPROC
1575: 
1576:     *===========================================================================
1577:     * HabilitarCampos - Transcricao de ".mObjEnabled(.Pagina.Dados, .t.)"
1578:     * chamado em Grupo_op.Click antes de exibir a Pagina de Dados. Alcanca os
1579:     * campos interativos (cabecalho do movimento + Grupo/Conta de Origem e
1580:     * Destino, que tem lookup via LostFocus - ValidarGrupoOrigem/
1581:     * ValidarContaOrigem/ValidarContaDestino). txt_4c_Codigo permanece SEMPRE
1582:     * ReadOnly (Get_codigo.When retorna .F. no legado - nao faz parte deste
1583:     * toggle) e os campos Desc*/Representante permanecem ReadOnly (regra
1584:     * propria, ja fixada na criacao dos controles).
1585:     *===========================================================================
1586:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1587:         LOCAL loc_oPg2, loc_oOrigem, loc_lHabilitar
1588:         loc_lHabilitar = (par_lHabilitar = .T.)
1589:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
1590:         loc_oOrigem    = loc_oPg2.cnt_4c_Origem
1591: 
1592:         loc_oPg2.txt_4c_Nota.Enabled           = loc_lHabilitar
1593:         loc_oPg2.txt_4c_Data.Enabled           = loc_lHabilitar
1594:         loc_oPg2.txt_4c_PrazoEntrega.Enabled   = loc_lHabilitar
1595:         loc_oPg2.txt_4c_NumeroOP.Enabled       = loc_lHabilitar
1596:         loc_oPg2.txt_4c_TabelaDesconto.Enabled = loc_lHabilitar
1597:         loc_oPg2.txt_4c_Status.Enabled         = loc_lHabilitar
1598:         loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Enabled = loc_lHabilitar
1599: 
1600:         loc_oOrigem.txt_4c_GrupoOrigem.Enabled        = loc_lHabilitar
1601:         loc_oOrigem.txt_4c_ContaOrigem.Enabled        = loc_lHabilitar
1602:         loc_oOrigem.txt_4c_GrupoDestino.Enabled       = loc_lHabilitar
1603:         loc_oOrigem.txt_4c_ContaDestino.Enabled       = loc_lHabilitar
1604:         loc_oOrigem.txt_4c_GrupoRepresentante.Enabled = loc_lHabilitar
1605:     ENDPROC
1606: 
1607:     *===========================================================================
1608:     * LimparCampos - Limpa os campos de Page2 antes de voltar para a Lista
1609:     * (BtnCancelarClick), evitando que dados do movimento anterior fiquem
1610:     * visiveis por um instante ate o proximo CarregarLista/BOParaForm.
1611:     *===========================================================================
1612:     PROTECTED PROCEDURE LimparCampos()
1613:         LOCAL loc_oPg2, loc_oOrigem
1614:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1615:         loc_oOrigem = loc_oPg2.cnt_4c_Origem
1616: 
1617:         loc_oPg2.txt_4c_Codigo.Value         = ""
1618:         loc_oPg2.txt_4c_Nota.Value           = ""
1619:         loc_oPg2.txt_4c_Data.Value           = {}
1620:         loc_oPg2.txt_4c_PrazoEntrega.Value   = {}
1621:         loc_oPg2.txt_4c_NumeroOP.Value       = 0
1622:         loc_oPg2.txt_4c_TabelaDesconto.Value = ""
1623:         loc_oPg2.txt_4c_Status.Value         = ""
1624:         loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Value = ""
1625:         loc_oPg2.txt_4c_Descr.Value           = ""
1626:         loc_oPg2.edt_4c_ObservacaoItem.Value  = ""
1627:         loc_oPg2.img_4c_FigJpg.Picture        = ""
1628:         loc_oPg2.img_4c_FigJpg.Visible        = .F.
1629: 
1630:         loc_oOrigem.txt_4c_GrupoOrigem.Value        = ""
1631:         loc_oOrigem.txt_4c_ContaOrigem.Value        = ""
1632:         loc_oOrigem.txt_4c_DescContaOrigem.Value    = ""
1633:         loc_oOrigem.txt_4c_GrupoDestino.Value       = ""
1634:         loc_oOrigem.txt_4c_ContaDestino.Value       = ""
1635:         loc_oOrigem.txt_4c_DescContaDestino.Value   = ""
1636:         loc_oOrigem.txt_4c_Representante.Value      = ""
1637:         loc_oOrigem.txt_4c_GrupoRepresentante.Value = ""
1638:         loc_oOrigem.txt_4c_DescRepresentante.Value  = ""
1639:     ENDPROC
1640: 
1641:     *===========================================================================
1642:     * CarregarItensGrid - Popula grd_4c_Itens a partir de cursor_4c_Itens
1643:     * (sigpres2BO.CarregarItens) e reconfigura RecordSource/ControlSource/
1644:     * Header/Width - regra "Grade perde cabecalhos apos RecordSource"
1645:     * (FORMCOR_LICOES/CLAUDE.md). Ao final, posiciona no 1o item e atualiza
1646:     * Descricao/Observacao/Imagem (AtualizarItemSelecionado).
1647:     *===========================================================================
1648:     PROTECTED PROCEDURE CarregarItensGrid()
1649:         LOCAL loc_lResultado, loc_oGrid, loc_oPagina
1650:         loc_lResultado = .F.
1651: 
1652:         TRY
1653:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1654:                 loc_lResultado = .T.
1655:             ELSE
1656:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
1657: 
1658:                 IF !THIS.this_oBusinessObject.CarregarItens()
1659:                     loc_lResultado = .F.
1660:                 ELSE
1661:                     loc_oGrid = loc_oPagina.grd_4c_Itens
1662:                     loc_oGrid.ColumnCount = 10
1663:                     loc_oGrid.RecordSource = "cursor_4c_Itens"
1664: 
1665:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Itens.cpros"
1666:                     loc_oGrid.Column2.ControlSource  = "cursor_4c_Itens.qtbxprods"
1667:                     loc_oGrid.Column3.ControlSource  = "cursor_4c_Itens.qtds"
1668:                     loc_oGrid.Column4.ControlSource  = "cursor_4c_Itens.saldo"
1669:                     loc_oGrid.Column5.ControlSource  = "cursor_4c_Itens.qtbaixas"
1670:                     loc_oGrid.Column6.ControlSource  = "cursor_4c_Itens.qtprods"
1671:                     loc_oGrid.Column7.ControlSource  = "cursor_4c_Itens.citens"
1672:                     loc_oGrid.Column8.ControlSource  = "cursor_4c_Itens.tpesos"
1673:                     loc_oGrid.Column9.ControlSource  = "cursor_4c_Itens.descvals"
1674:                     loc_oGrid.Column10.ControlSource = "cursor_4c_Itens.codtams"
1675: 
1676:                     loc_oGrid.Column1.Width  = 90
1677:                     loc_oGrid.Column2.Width  = 70
1678:                     loc_oGrid.Column3.Width  = 60
1679:                     loc_oGrid.Column4.Width  = 60
1680:                     loc_oGrid.Column5.Width  = 70
1681:                     loc_oGrid.Column6.Width  = 70
1682:                     loc_oGrid.Column7.Width  = 60
1683:                     loc_oGrid.Column8.Width  = 70
1684:                     loc_oGrid.Column9.Width  = 60
1685:                     loc_oGrid.Column10.Width = 60
1686: 
1687:                     loc_oGrid.Column1.Header1.Caption  = "Produto"
1688:                     loc_oGrid.Column2.Header1.Caption  = "Produzido"

*-- Linhas 1719 a 2041:
1719:     * CarregarOperacoesGrid - Popula grd_4c_Operacoes a partir de
1720:     * cursor_4c_Operacoes (sigpres2BO.CarregarOperacoes).
1721:     *===========================================================================
1722:     PROTECTED PROCEDURE CarregarOperacoesGrid()
1723:         LOCAL loc_lResultado, loc_oGrid, loc_oPagina
1724:         loc_lResultado = .F.
1725: 
1726:         TRY
1727:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1728:                 loc_lResultado = .T.
1729:             ELSE
1730:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
1731: 
1732:                 IF !THIS.this_oBusinessObject.CarregarOperacoes()
1733:                     loc_lResultado = .F.
1734:                 ELSE
1735:                     loc_oGrid = loc_oPagina.grd_4c_Operacoes
1736:                     loc_oGrid.ColumnCount = 1
1737:                     loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1738:                     loc_oGrid.Column1.ControlSource  = "cursor_4c_Operacoes.codigos"
1739:                     loc_oGrid.Column1.Width          = 100
1740:                     loc_oGrid.Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1741:                     loc_oGrid.Column1.FontName        = "Courier New"
1742:                     loc_oGrid.Refresh()
1743: 
1744:                     loc_lResultado = .T.
1745:                 ENDIF
1746:             ENDIF
1747:         CATCH TO loException
1748:             MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "Formsigpres2.CarregarOperacoesGrid")
1749:             loc_lResultado = .F.
1750:         ENDTRY
1751: 
1752:         RETURN loc_lResultado
1753:     ENDPROC
1754: 
1755:     *===========================================================================
1756:     * GridItensAfterRowColChange - Equivalente ao PROCEDURE (AfterRowColChange)
1757:     * de fwgrade1 no legado: ao mudar a linha selecionada, atualiza
1758:     * Descricao/Observacao/Imagem do item corrente.
1759:     *===========================================================================
1760:     PROCEDURE GridItensAfterRowColChange(par_nColIndex)
1761:         THIS.AtualizarItemSelecionado()
1762:     ENDPROC
1763: 
1764:     *===========================================================================
1765:     * AtualizarItemSelecionado - Le a linha corrente de cursor_4c_Itens e
1766:     * atualiza txt_4c_Descr (xEestI.DPros), edt_4c_ObservacaoItem
1767:     * (xEestI.OBS) e img_4c_FigJpg (CursorQuery SigCdPro por Cpros + STRTOFILE
1768:     * de FigJpgs em arquivo temporario) - transcricao do PROCEDURE do
1769:     * fwgrade1 legado.
1770:     *===========================================================================
1771:     PROTECTED PROCEDURE AtualizarItemSelecionado()
1772:         LOCAL loc_oPagina, loc_cArquivo, loc_cCodigoProduto
1773:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1774: 
1775:         loc_oPagina.img_4c_FigJpg.Picture = ""
1776:         loc_oPagina.img_4c_FigJpg.Visible = .F.
1777: 
1778:         IF !USED("cursor_4c_Itens") OR EOF("cursor_4c_Itens") OR RECCOUNT("cursor_4c_Itens") = 0
1779:             loc_oPagina.txt_4c_Descr.Value          = ""
1780:             loc_oPagina.edt_4c_ObservacaoItem.Value = ""
1781:             RETURN
1782:         ENDIF
1783: 
1784:         SELECT cursor_4c_Itens
1785:         loc_oPagina.txt_4c_Descr.Value          = ALLTRIM(TratarNulo(cursor_4c_Itens.dpros, ""))
1786:         loc_oPagina.edt_4c_ObservacaoItem.Value = TratarNulo(cursor_4c_Itens.obs, "")
1787:         loc_cCodigoProduto                       = ALLTRIM(cursor_4c_Itens.cpros)
1788: 
1789:         IF !EMPTY(loc_cCodigoProduto)
1790:             IF USED("cursor_4c_Produto")
1791:                 USE IN cursor_4c_Produto
1792:             ENDIF
1793:             IF SQLEXEC(gnConnHandle, "SELECT figjpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodigoProduto), "cursor_4c_Produto") >= 1
1794:                 IF RECCOUNT("cursor_4c_Produto") > 0 AND !EMPTY(TratarNulo(cursor_4c_Produto.figjpgs, ""))
1795:                     loc_cArquivo = SYS(2023) + "\sigpres2_" + SYS(2015) + ".jpg"
1796:                     IF STRTOFILE(cursor_4c_Produto.figjpgs, loc_cArquivo) > 0
1797:                         loc_oPagina.img_4c_FigJpg.Picture = loc_cArquivo
1798:                         loc_oPagina.img_4c_FigJpg.Visible = .T.
1799:                     ENDIF
1800:                 ENDIF
1801:             ENDIF
1802:             IF USED("cursor_4c_Produto")
1803:                 USE IN cursor_4c_Produto
1804:             ENDIF
1805:         ENDIF
1806:     ENDPROC
1807: 
1808:     *===========================================================================
1809:     * ValidarGrupoOrigem - Equivalente a Origem.Get_grupo.Valid do legado:
1810:     * chama fAcessoContab (portada em utils/functions.prg), que faz o SEEK
1811:     * exato e so abre o picker interno (FormBuscaSimples) quando nao acha,
1812:     * preenchendo o proprio TextBox. pCta (6o arg) reproduz a checagem de
1813:     * "Grupo Vinculado" contra a Conta de Origem ja digitada.
1814:     *===========================================================================
1815:     PROCEDURE ValidarGrupoOrigem()
1816:         LOCAL loc_oOrigem
1817:         loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1818: 
1819:         IF !EMPTY(ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value))
1820:             = fAcessoContab(gc_4c_UsuarioLogado, "C", ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value), ;
1821:                 loc_oOrigem.txt_4c_GrupoOrigem, "", ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value))
1822:         ENDIF
1823:     ENDPROC
1824: 
1825:     *===========================================================================
1826:     * ValidarContaOrigem - Equivalente a Origem.Get_conta.Valid do legado:
1827:     * fAcessoContas (portada) faz o SEEK exato + picker interno, preenchendo
1828:     * Conta/DescConta. Se o Grupo de Origem estiver vazio, e preenchido com
1829:     * o grupo da conta encontrada (mesmo "If Empty(get_grupo.Value) ...
1830:     * get_grupo.Value = crSigCdCli.Grupos" do legado).
1831:     *===========================================================================
1832:     PROCEDURE ValidarContaOrigem()
1833:         LOCAL loc_oOrigem, loc_cGrupo, loc_cConta, loc_cSQL
1834:         loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1835:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value)
1836:         loc_cConta  = ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value)
1837: 
1838:         IF EMPTY(loc_cConta)
1839:             loc_oOrigem.txt_4c_DescContaOrigem.Value = ""
1840:             RETURN
1841:         ENDIF
1842: 
1843:         IF fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cConta, ;
1844:                 loc_oOrigem.txt_4c_ContaOrigem, loc_oOrigem.txt_4c_DescContaOrigem)
1845:             IF EMPTY(loc_cGrupo)
1846:                 loc_cSQL = "SELECT grupos FROM SigCdCli WHERE iclis = " + ;
1847:                     EscaparSQL(ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value))
1848: 
1849:                 IF USED("cursor_4c_GrupoConta")
1850:                     USE IN cursor_4c_GrupoConta
1851:                 ENDIF
1852:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrupoConta") >= 1 AND RECCOUNT("cursor_4c_GrupoConta") > 0
1853:                     loc_oOrigem.txt_4c_GrupoOrigem.Value = ALLTRIM(TratarNulo(cursor_4c_GrupoConta.grupos, ""))
1854:                 ENDIF
1855:                 IF USED("cursor_4c_GrupoConta")
1856:                     USE IN cursor_4c_GrupoConta
1857:                 ENDIF
1858:             ENDIF
1859:         ELSE
1860:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1861:             loc_oOrigem.txt_4c_ContaOrigem.Value     = ""
1862:             loc_oOrigem.txt_4c_DescContaOrigem.Value = ""
1863:         ENDIF
1864:     ENDPROC
1865: 
1866:     *===========================================================================
1867:     * ValidarContaDestino - Equivalente a Origem.Get_ContaD.Valid do legado:
1868:     * fAcessoContas (portada) faz o SEEK exato + picker interno, preenchendo
1869:     * Conta/DescConta de Destino. NOTA: o fonte legado deste handler
1870:     * referencia por engano os objetos da Conta de Origem (Get_Conta/
1871:     * Get_DConta, provavelmente copy-paste de Get_conta.Valid sem ajustar
1872:     * os "This.Parent.Get_*") - aqui a gravacao e feita nos proprios campos
1873:     * de Destino (comportamento correto/simetrico), nao no defeito herdado.
1874:     *===========================================================================
1875:     PROCEDURE ValidarContaDestino()
1876:         LOCAL loc_oOrigem, loc_cGrupo, loc_cConta
1877:         loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1878:         loc_cGrupo  = ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value)
1879:         loc_cConta  = ALLTRIM(loc_oOrigem.txt_4c_ContaDestino.Value)
1880: 
1881:         IF EMPTY(loc_cConta)
1882:             loc_oOrigem.txt_4c_DescContaDestino.Value = ""
1883:             RETURN
1884:         ENDIF
1885: 
1886:         IF fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_cConta, ;
1887:                 loc_oOrigem.txt_4c_ContaDestino, loc_oOrigem.txt_4c_DescContaDestino)
1888:             * Acesso liberado - Conta/DescConta ja preenchidos pela funcao
1889:         ELSE
1890:             MsgAviso("Acesso Negado!!!", "Aten" + CHR(231) + CHR(227) + "o")
1891:             loc_oOrigem.txt_4c_ContaDestino.Value     = ""
1892:             loc_oOrigem.txt_4c_DescContaDestino.Value = ""
1893:         ENDIF
1894:     ENDPROC
1895: 
1896:     *===========================================================================
1897:     * BtnCadastrosClick - Equivalente a Origem.btnCadastros.Click do legado
1898:     * ("Acessa o Cadastro Desta Conta"): abre o cadastro de Contas Correntes
1899:     * (FormCTA, migrado de SIGCDCTA) quando ha uma Conta de Destino
1900:     * preenchida. FormCTA nao expõe parametro de filtro/valor inicial (API
1901:     * atual so tem Init() sem argumentos) - abre a lista geral, sem o
1902:     * preenchimento automatico que o "With ... 0, [SIGCDCTA], valor, ..."
1903:     * fazia no legado.
1904:     *===========================================================================
1905:     PROCEDURE BtnCadastrosClick()
1906:         LOCAL loc_oOrigem, loc_oForm
1907:         loc_oOrigem = THIS.pgf_4c_Paginas.Page2.cnt_4c_Origem
1908: 
1909:         IF EMPTY(ALLTRIM(loc_oOrigem.txt_4c_ContaDestino.Value))
1910:             RETURN
1911:         ENDIF
1912: 
1913:         loc_oForm = .NULL.
1914:         TRY
1915:             loc_oForm = CREATEOBJECT("FormCTA")
1916:         CATCH TO loException
1917:             MostrarErro("Erro ao abrir cadastro de contas:" + CHR(13) + loException.Message, "Formsigpres2.BtnCadastrosClick")
1918:             loc_oForm = .NULL.
1919:         ENDTRY
1920: 
1921:         IF VARTYPE(loc_oForm) = "O"
1922:             loc_oForm.Show()
1923:         ENDIF
1924:     ENDPROC
1925: 
1926:     *===========================================================================
1927:     * FormParaBO - Transfere dados do Form para o Business Object.
1928:     * FASE 6/8: acrescenta a observacao geral do cabecalho (cnt_4c_Observacao.
1929:     * edt_4c_Observacao -> this_cObservacao). Campos de descricao
1930:     * (txt_4c_DescConta*) e os campos de item/grades (FASE 6/8, cursores
1931:     * cursor_4c_Itens/cursor_4c_Operacoes) nao tem property escalar
1932:     * equivalente no BO e ficam de fora (ver cabecalho de sigpres2BO.prg).
1933:     *===========================================================================
1934:     PROTECTED PROCEDURE FormParaBO()
1935:         LOCAL loc_oPg2, loc_oOrigem
1936:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1937:         loc_oOrigem = loc_oPg2.cnt_4c_Origem
1938: 
1939:         WITH THIS.this_oBusinessObject
1940:             .this_cCodigoMascarado    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1941:             .this_cDocumento          = ALLTRIM(loc_oPg2.txt_4c_Nota.Value)
1942:             .this_dData               = loc_oPg2.txt_4c_Data.Value
1943:             .this_dPrazoEntrega       = loc_oPg2.txt_4c_PrazoEntrega.Value
1944:             .this_nNumeroOP           = loc_oPg2.txt_4c_NumeroOP.Value
1945:             .this_cTabelaDesconto     = ALLTRIM(loc_oPg2.txt_4c_TabelaDesconto.Value)
1946:             .this_cStatus             = ALLTRIM(loc_oPg2.txt_4c_Status.Value)
1947:             .this_cObservacao         = loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Value
1948: 
1949:             .this_cGrupoOrigem        = ALLTRIM(loc_oOrigem.txt_4c_GrupoOrigem.Value)
1950:             .this_cContaOrigem        = ALLTRIM(loc_oOrigem.txt_4c_ContaOrigem.Value)
1951:             .this_cGrupoDestino       = ALLTRIM(loc_oOrigem.txt_4c_GrupoDestino.Value)
1952:             .this_cContaDestino       = ALLTRIM(loc_oOrigem.txt_4c_ContaDestino.Value)
1953:             .this_cRepresentante      = ALLTRIM(loc_oOrigem.txt_4c_Representante.Value)
1954:             .this_cGrupoRepresentante = ALLTRIM(loc_oOrigem.txt_4c_GrupoRepresentante.Value)
1955:         ENDWITH
1956:     ENDPROC
1957: 
1958:     *===========================================================================
1959:     * BOParaForm - Transfere dados do Business Object para o Form.
1960:     * FASE 6/8: mesmos campos wireados em FormParaBO (ver comentario acima).
1961:     *===========================================================================
1962:     PROTECTED PROCEDURE BOParaForm()
1963:         LOCAL loc_oPg2, loc_oOrigem
1964:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1965:         loc_oOrigem = loc_oPg2.cnt_4c_Origem
1966: 
1967:         WITH THIS.this_oBusinessObject
1968:             loc_oPg2.txt_4c_Codigo.Value           = .this_cCodigoMascarado
1969:             loc_oPg2.txt_4c_Nota.Value             = .this_cDocumento
1970:             loc_oPg2.txt_4c_Data.Value              = .this_dData
1971:             loc_oPg2.txt_4c_PrazoEntrega.Value     = .this_dPrazoEntrega
1972:             loc_oPg2.txt_4c_NumeroOP.Value          = .this_nNumeroOP
1973:             loc_oPg2.txt_4c_TabelaDesconto.Value    = .this_cTabelaDesconto
1974:             loc_oPg2.txt_4c_Status.Value             = .this_cStatus
1975:             loc_oPg2.cnt_4c_Observacao.edt_4c_Observacao.Value = .this_cObservacao
1976: 
1977:             loc_oOrigem.txt_4c_GrupoOrigem.Value        = .this_cGrupoOrigem
1978:             loc_oOrigem.txt_4c_ContaOrigem.Value        = .this_cContaOrigem
1979:             loc_oOrigem.txt_4c_GrupoDestino.Value       = .this_cGrupoDestino
1980:             loc_oOrigem.txt_4c_ContaDestino.Value       = .this_cContaDestino
1981:             loc_oOrigem.txt_4c_Representante.Value      = .this_cRepresentante
1982:             loc_oOrigem.txt_4c_GrupoRepresentante.Value = .this_cGrupoRepresentante
1983:         ENDWITH
1984:     ENDPROC
1985: 
1986:     *===========================================================================
1987:     * TornarControlesVisiveis - Torna todos os controles visiveis
1988:     * recursivamente (Pages de PageFrames E Controls de Containers)
1989:     *===========================================================================
1990:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1991:         LOCAL loc_nI, loc_oObjeto, loc_nP
1992: 
1993:         IF VARTYPE(par_oContainer) != "O"
1994:             RETURN
1995:         ENDIF
1996: 
1997:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1998:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1999: 
2000:             IF VARTYPE(loc_oObjeto) = "O"
2001:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2002:                     loc_oObjeto.Visible = .T.
2003:                 ENDIF
2004: 
2005:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2006:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2007:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2008:                     ENDFOR
2009:                 ENDIF
2010: 
2011:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2012:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2013:                 ENDIF
2014:             ENDIF
2015:         ENDFOR
2016:     ENDPROC
2017: 
2018:     *===========================================================================
2019:     * FormatarGridLista - Formata visual do grid da lista
2020:     *===========================================================================
2021:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2022:         IF VARTYPE(par_oGrid) != "O"
2023:             RETURN
2024:         ENDIF
2025: 
2026:         WITH par_oGrid
2027:             .FontName = "Tahoma"
2028:             .FontSize = 8
2029:         ENDWITH
2030:     ENDPROC
2031: 
2032:     *===========================================================================
2033:     * Destroy - Libera referencia do form pai antes do encerramento padrao
2034:     * (FormBase.Destroy cuida do this_oBusinessObject e da restauracao do menu)
2035:     *===========================================================================
2036:     PROCEDURE Destroy()
2037:         THIS.this_oFormPai = .NULL.
2038:         RETURN DODEFAULT()
2039:     ENDPROC
2040: 
2041: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpres2BO.prg):
*==============================================================================
* SIGPRES2BO.PRG
* Business Object para o dialogo de Origem/Destino/Representante de Movimento
* (SIGPRES2 - dialogo filho aberto por um form OPERACIONAL pai via
*  "Do Form SigPrEs2 With ThisForm, ...", NAO acessivel direto pelo menu)
*
* Tabela Principal : SigMvCab (cabecalho de movimentacao)
* Chave Real (PK)  : CidChaves    CHAR(20)
* Chave Posicional : EmpDopNums   CHAR(29) = Emps CHAR(3) + Dopes CHAR(20) + Str(Numes, 6)
*                     (NUNCA usar ALLTRIM nas partes - ver CLAUDE.md regra #42)
*
* Logica do legado: o form pai ja populou um cursor local (csTemporario) com o
* registro (ou lote de registros) de SigMvCab a editar; o SIGPRES2 apenas edita
* os campos de cabecalho abaixo (Origem/Destino/Representante/Status/Prazo) e
* delega o commit ao TableUpdate do buffer do framework (Grupo_Salva.Salva.Click
* so chama DoDefault() + mAtivapagina1 - nao ha INSERT/UPDATE/DELETE proprios no
* codigo fonte do SIGPRES2). Os campos de item (grid fwgrade1/xEestI, vindos de
* SigMvItn/SigMvIts) e a grade de operacoes (TmpOperacao/SigMvPec) sao
* somente-leitura e pertencem a um cursor de detalhe, nao a properties escalares
* deste BO.
*==============================================================================

DEFINE CLASS sigpres2BO AS BusinessBase

    *-- Chave composta do movimento (SigMvCab)
    this_cEmpresa            = ""   && Emps        CHAR(3)  - Empresa (parte da chave posicional)
    this_cTipoDocumento      = ""   && Dopes        CHAR(20) - Tipo de documento (parte da chave posicional)
    this_nNumero             = 0    && Numes        NUMERIC(6,0) - Numero do documento (parte da chave posicional)
    this_cEmpresaDestino     = ""   && Empds        CHAR(3)  - Empresa de destino (grid Lista, coluna "EmpD")
    this_cChaveMovimento     = ""   && EmpDopNums   CHAR(29) - Chave posicional (Emps+Dopes+Str(Numes,6))
    this_cCidChave           = ""   && CidChaves    CHAR(20) - Chave primaria real da tabela

    *-- Origem / Destino / Representante (container "Origem" da Pagina Dados)
    this_cGrupoOrigem        = ""   && Grupoos      CHAR(10)
    this_cContaOrigem        = ""   && Contaos      CHAR(10)
    this_cGrupoDestino       = ""   && Grupods      CHAR(10)
    this_cContaDestino       = ""   && Contads      CHAR(10)
    this_cRepresentante      = ""   && Vends        CHAR(10)
    this_cGrupoRepresentante = ""   && Grvends      CHAR(10)

    *-- Demais campos de cabecalho editaveis na Pagina Dados
    this_cTabelaDesconto     = ""   && Tabds        CHAR(10)
    this_cStatus             = ""   && PStatus      CHAR(1)
    this_cUsuario            = ""   && Usuars       CHAR(10) - usuario do movimento (grid Lista, coluna "Usuario")
    this_nNumeroOP           = 0    && Nops         NUMERIC(10,0)
    this_dPrazoEntrega       = {}   && PrazoEnts    DATETIME
    this_cCodigoMascarado    = ""   && MascNum      CHAR(10) - exibicao formatada (Get_codigo), somente leitura
    this_cDocumento          = ""   && Notas        CHAR(6)  - numero do documento/nota (Get_nota)
    this_dData               = {}   && Datas        DATETIME
    this_cObservacao         = ""   && Obses        TEXT (memo)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Chave real da tabela (CidChaves), usada por
    * RegistrarAuditoria() e pela clausula WHERE de Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChave)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia as colunas de SigMvCab que este dialogo edita
    * (Origem/Destino/Representante/cabecalho) para as properties do BO.
    * SELECT (par_cAliasCursor) ANTES de acessar os campos (regra #8 CLAUDE.md).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cEmpresa            = TratarNulo(emps, "")
                THIS.this_cTipoDocumento      = TratarNulo(dopes, "")
                THIS.this_nNumero             = TratarNulo(numes, 0)
                THIS.this_cEmpresaDestino     = TratarNulo(empds, "")
                THIS.this_cChaveMovimento     = TratarNulo(empdopnums, "")
                THIS.this_cCidChave           = TratarNulo(cidchaves, "")

                THIS.this_cGrupoOrigem        = TratarNulo(grupoos, "")
                THIS.this_cContaOrigem        = TratarNulo(contaos, "")
                THIS.this_cGrupoDestino       = TratarNulo(grupods, "")
                THIS.this_cContaDestino       = TratarNulo(contads, "")
                THIS.this_cRepresentante      = TratarNulo(vends, "")
                THIS.this_cGrupoRepresentante = TratarNulo(grvends, "")

                THIS.this_cTabelaDesconto     = TratarNulo(tabds, "")
                THIS.this_cStatus             = TratarNulo(pstatus, "")
                THIS.this_cUsuario            = TratarNulo(usuars, "")
                THIS.this_nNumeroOP           = TratarNulo(nops, 0)
                THIS.this_dPrazoEntrega       = TratarNulo(prazoents, {})
                THIS.this_cCodigoMascarado    = TratarNulo(mascnum, "")
                THIS.this_cDocumento          = TratarNulo(notas, "")
                THIS.this_dData               = TratarNulo(datas, {})
                THIS.this_cObservacao         = TratarNulo(obses, "")

                THIS.this_lNovoRegistro = .F.
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega o movimento pela chave real (CidChaves).
    * SELECT * (como no legado, que abre o registro inteiro via csTemporario)
    * para que CarregarDoCursor sempre encontre as colunas que le.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT * FROM SigMvCab WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                ELSE
                    MsgAviso("Movimenta" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "sigpres2BO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE parcial em SigMvCab, restrito aos campos que este
    * dialogo de fato edita (Origem/Destino/Representante/Status/Prazo/
    * Documento/Data/Observacao). Equivalente ao TableUpdate() do buffer
    * otimista do framework legado: Grupo_Salva.Salva.Click do SIGPRES2 nao
    * tem SQL proprio (so DoDefault() + mAtivapagina1 - ver cabecalho do
    * arquivo), mas o buffer so envia ao SQL Server as colunas realmente
    * alteradas na tela - por isso o UPDATE aqui cobre so essas colunas,
    * nunca a linha inteira (colunas de identificacao como Emps/Dopes/Numes/
    * EmpDopNums/MascNum sao somente leitura nesta tela e ficam de fora).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCab SET"
            loc_cSQL = loc_cSQL + " grupoos = "   + EscaparSQL(LEFT(THIS.this_cGrupoOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " contaos = "   + EscaparSQL(LEFT(THIS.this_cContaOrigem, 10)) + ","
            loc_cSQL = loc_cSQL + " grupods = "   + EscaparSQL(LEFT(THIS.this_cGrupoDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " contads = "   + EscaparSQL(LEFT(THIS.this_cContaDestino, 10)) + ","
            loc_cSQL = loc_cSQL + " vends = "     + EscaparSQL(LEFT(THIS.this_cRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " grvends = "   + EscaparSQL(LEFT(THIS.this_cGrupoRepresentante, 10)) + ","
            loc_cSQL = loc_cSQL + " tabds = "     + EscaparSQL(LEFT(THIS.this_cTabelaDesconto, 10)) + ","
            loc_cSQL = loc_cSQL + " pstatus = "   + EscaparSQL(LEFT(THIS.this_cStatus, 1)) + ","
            loc_cSQL = loc_cSQL + " nops = "      + FormatarNumeroSQL(THIS.this_nNumeroOP, 0) + ","
            loc_cSQL = loc_cSQL + " prazoents = " + FormatarDataSQL(THIS.this_dPrazoEntrega) + ","
            loc_cSQL = loc_cSQL + " notas = "     + EscaparSQL(LEFT(THIS.this_cDocumento, 6)) + ","
            loc_cSQL = loc_cSQL + " datas = "     + FormatarDataSQL(THIS.this_dData) + ","
            loc_cSQL = loc_cSQL + " obses = "     + EscaparSQL(THIS.this_cObservacao)
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChave)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigpres2BO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir() e ExecutarExclusao() permanecem com o comportamento herdado
    * de BusinessBase (recusar a operacao): no fonte legado do SIGPRES2 nao
    * ha Append/Delete contra SigMvCab - o dialogo so edita um registro que
    * o form pai ja havia populado em csTemporario antes de abri-lo (ver
    * cabecalho do arquivo). Este BO nunca cria nem exclui movimentos.
    *--------------------------------------------------------------------------

    *--------------------------------------------------------------------------
    * CarregarItens - Carrega os itens do movimento (grid fwgrade1/xEestI do
    * legado) em cursor_4c_Itens. Fonte: SigMvItn (a) LEFT JOIN SigMvIts (b)
    * por EmpDopNums+Cpros+CItens (mesma juncao do PROCEDURE Init legado -
    * regra #42 CLAUDE.md, nunca ALLTRIM na chave posicional). Saldo =
    * Qtds - QtBaixas ja calculado no SELECT (equivalente ao
    * Column4.ControlSource legado 'xEestI.Qtds - xEestI.QtBaixas', ramo
    * Else de montagrades - o ramo If(gcTpInstalas='V') nao foi portado:
    * essa global de configuracao nao existe na nova arquitetura, e o ramo
    * Else e o que bate com os headers estaticos do SCX/layout.json).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarItens()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Itens")
                USE IN cursor_4c_Itens
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.dpros, a.qtds, a.qtprods," + ;
                " a.qtbaixas, a.qtbxprods, a.citens, a.tpesos," + ;
                " a.descvals, ISNULL(b.codtams, '') AS codtams," + ;
                " a.obs, (a.qtds - a.qtbaixas) AS saldo" + ;
                " FROM sigmvitn a" + ;
                " LEFT JOIN sigmvits b ON b.empdopnums = a.empdopnums" + ;
                " AND b.cpros = a.cpros AND b.citens = a.citens" + ;
                " WHERE a.empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY a.citens"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Itens")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar itens do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar itens:" + CHR(13) + loException.Message, "sigpres2BO.CarregarItens")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega os codigos de operacao vinculados ao
    * movimento (grid GradeOperacao/TmpOperacao do legado). Fonte: SigMvPec
    * filtrado por EmpDopNums (mesmo filtro do legado
    * CursorQuery('SigMvPec', 'TmpOperacao', 'EmpDopNums', pEdn)).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Operacoes")
                USE IN cursor_4c_Operacoes
            ENDIF

            loc_cSQL = "SELECT DISTINCT codigos FROM sigmvpec" + ;
                " WHERE empdopnums = " + EscaparSQL(THIS.this_cChaveMovimento) + ;
                " ORDER BY codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es do movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loException.Message, "sigpres2BO.CarregarOperacoes")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

