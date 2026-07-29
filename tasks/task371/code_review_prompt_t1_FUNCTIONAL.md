# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH cursor_4c_TmpIva.cidChaves define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: cursor_4c_TmpIva.cidChaves.RecordSource).
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF Ori, UF Des, IVA, IVA Im, UF Dest, Aliq Red, Aliq B Red. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF Ori, UF Des, IVA, IVA Im, UF Dest, Aliq Red, Aliq B Red. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Alíq. IPI' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF Ori, UF Des, IVA, IVA Im, UF Dest, Aliq Red, Aliq B Red. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'UN' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF Ori, UF Des, IVA, IVA Im, UF Dest, Aliq Red, Aliq B Red. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'CEST' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: UF Ori, UF Des, IVA, IVA Im, UF Dest, Aliq Red, Aliq B Red. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'cmbIpi' (parent: SIGCDCLF.Pagina.Dados): Top original=179 vs migrado 'cbo_4c_CmbIPip' Top=237 (diff=58px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormClf.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2503 linhas total):

*-- Linhas 31 a 153:
31:     *--------------------------------------------------------------------------
32:     * Init - Inicializacao do formulario
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         *-- DODEFAULT() ja chama InicializarForm() atraves do FormBase.Init()
36:         RETURN DODEFAULT()
37:     ENDPROC
38: 
39:     *--------------------------------------------------------------------------
40:     * InicializarForm - Configuracao inicial do formulario
41:     *--------------------------------------------------------------------------
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             *-- Criar instancia do Business Object
48:             THIS.this_oBusinessObject = CREATEOBJECT("ClfBO")
49: 
50:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
51:                 MostrarErro("Erro ao criar Business Object ClfBO", "Erro Cr" + CHR(237) + "tico")
52:                 loc_lSucesso = .F.
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.ConfigurarPaginaLista()
56:                 THIS.ConfigurarPaginaDados()
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 *-- Pula CarregarLista() se estiver validando UI (sem conexao SQL)
60:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
61:                     IF !THIS.CarregarLista()
62:                         *-- Falha ao carregar nao impede abertura
63:                     ENDIF
64:                 ENDIF
65: 
66:                 THIS.pgf_4c_Paginas.Visible = .T.
67:                 THIS.pgf_4c_Paginas.ActivePage = 1
68:                 THIS.this_cModoAtual = "LISTA"
69:                 loc_lSucesso = .T.
70:             ENDIF
71: 
72:         CATCH TO loException
73:             MostrarErro("Erro ao inicializar FormClf:" + CHR(13) + "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + loException.Message, "Erro")
74:             loc_lSucesso = .F.
75:         ENDTRY
76: 
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *--------------------------------------------------------------------------
81:     * ConfigurarPageFrame - Configura o PageFrame principal
82:     * Legado: Pagina Width=1003, PageFrame.Top=-29 (oculta abas)
83:     *--------------------------------------------------------------------------
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .Top       = -29
89:             .Left      = 0
90:             .Width     = 1003
91:             .Height    = 629
92:             .PageCount = 2
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             *-- Page1 - Lista
97:             .Page1.Caption   = "Lista"
98:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
99:             .Page1.BackColor = RGB(255, 255, 255)
100: 
101:             *-- Page2 - Dados
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * ConfigurarPaginaLista - Configura Page1 (Lista)
110:     * Compensacao +29 aplicada: Top original 0 -> 29, Top 2 -> 31
111:     * Colunas lista legado: Codigos(94), Descricaos(290), Aipis(45), Unidades(31), Cest(70)
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPagina
115:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
116: 
117:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:         *-- Container de cabecalho (cntSombra: Top=2 -> 31)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = 1020
125:             .Height      = 80
126:             .BackColor   = RGB(192, 192, 192)
127:             .BackStyle   = 0
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
133:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
134:             .Caption   = "Cadastro de Classificacao Fiscal"
135:             .Top       = 20
136:             .Left      = 20
137:             .Width     = 600
138:             .Height    = 30
139:             .FontName  = "Tahoma"
140:             .FontSize  = 14
141:             .FontBold  = .T.
142:             .BackStyle = 0
143:             .ForeColor = RGB(90, 90, 90)
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         *-- Container de botoes CRUD (Grupo_op: Left=542, Top=0 -> 29)
148:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
149:         WITH loc_oPagina.cnt_4c_Botoes
150:             .Top         = 29
151:             .Left        = 542
152:             .Width       = 400
153:             .Height      = 85

*-- Linhas 174 a 421:
174:             .ForeColor       = RGB(90, 90, 90)
175:             .Visible         = .T.
176:         ENDWITH
177:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
178: 
179:         *-- Botao Visualizar (Left=80)
180:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
181:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
182:             .Caption         = "Visualizar"
183:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
184:             .PicturePosition = 13
185:             .Width           = 75
186:             .Height          = 75
187:             .Left            = 80
188:             .Top             = 5
189:             .FontName        = "Tahoma"
190:             .FontSize        = 8
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .BackColor       = RGB(255, 255, 255)
194:             .ForeColor       = RGB(90, 90, 90)
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
198: 
199:         *-- Botao Alterar (Left=155)
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
202:             .Caption         = "Alterar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
204:             .PicturePosition = 13
205:             .Width           = 75
206:             .Height          = 75
207:             .Left            = 155
208:             .Top             = 5
209:             .FontName        = "Tahoma"
210:             .FontSize        = 8
211:             .Themes          = .F.
212:             .SpecialEffect   = 0
213:             .BackColor       = RGB(255, 255, 255)
214:             .ForeColor       = RGB(90, 90, 90)
215:             .Visible         = .T.
216:         ENDWITH
217:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
218: 
219:         *-- Botao Excluir (Left=230)
220:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
221:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
222:             .Caption         = "Excluir"
223:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
224:             .PicturePosition = 13
225:             .Width           = 75
226:             .Height          = 75
227:             .Left            = 230
228:             .Top             = 5
229:             .FontName        = "Tahoma"
230:             .FontSize        = 8
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .Visible         = .T.
236:         ENDWITH
237:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
238: 
239:         *-- Botao Buscar (Left=305)
240:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
241:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
242:             .Caption         = "Buscar"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
244:             .PicturePosition = 13
245:             .Width           = 75
246:             .Height          = 75
247:             .Left            = 305
248:             .Top             = 5
249:             .FontName        = "Tahoma"
250:             .FontSize        = 8
251:             .Themes          = .F.
252:             .SpecialEffect   = 0
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .Visible         = .T.
256:         ENDWITH
257:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
258: 
259:         *-- Container de saida - canonico (Left=917, Top=29)
260:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
261:         WITH loc_oPagina.cnt_4c_Saida
262:             .Top         = 29
263:             .Left        = 917
264:             .Width       = 90
265:             .Height      = 85
266:             .BackStyle   = 0
267:             .BorderWidth = 0
268:             .Visible     = .T.
269:         ENDWITH
270: 
271:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
272:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
273:             .Caption         = "Encerrar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
275:             .PicturePosition = 13
276:             .Width           = 75
277:             .Height          = 75
278:             .Left            = 5
279:             .Top             = 5
280:             .FontName        = "Tahoma"
281:             .FontSize        = 8
282:             .Themes          = .F.
283:             .SpecialEffect   = 0
284:             .BackColor       = RGB(255, 255, 255)
285:             .ForeColor       = RGB(90, 90, 90)
286:             .Visible         = .T.
287:         ENDWITH
288:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
289: 
290:         *-- Grid de lista (Grade: Top=121, Left=12, Width=940, Height=470)
291:         *-- Colunas: Codigos(94), Descricaos(290), Aipis(45), Unidades(31), Cest(70)
292:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
293:         WITH loc_oPagina.grd_4c_Lista
294:             .Top               = 121
295:             .Left              = 12
296:             .Width             = 940
297:             .Height            = 470
298:             .ReadOnly          = .T.
299:             .DeleteMark        = .F.
300:             .RecordMark        = .F.
301:             .ScrollBars        = 3
302:             .GridLines         = 3
303:             .AllowHeaderSizing = .T.
304:             .Visible           = .T.
305:         ENDWITH
306: 
307:         *-- ColumnCount FORA do WITH para criacao imediata das colunas (Problema 36)
308:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
309:         loc_oPagina.grd_4c_Lista.Column1.Width = 94
310:         loc_oPagina.grd_4c_Lista.Column2.Width = 290
311:         loc_oPagina.grd_4c_Lista.Column3.Width = 45
312:         loc_oPagina.grd_4c_Lista.Column4.Width = 31
313:         loc_oPagina.grd_4c_Lista.Column5.Width = 70
314: 
315:         THIS.TornarControlesVisiveis(loc_oPagina)
316:     ENDPROC
317: 
318:     *--------------------------------------------------------------------------
319:     * ConfigurarPaginaDados - Configura Page2 (Dados)
320:     * Compensacao +29 em TODOS os controles (Top_original + 29)
321:     * Legado: campos em SIGCDCLF.Pagina.Dados.*
322:     * Nota: Grids filhos (GradIva, GradRed) serao adicionados nas proximas fases
323:     *--------------------------------------------------------------------------
324:     PROTECTED PROCEDURE ConfigurarPaginaDados()
325:         LOCAL loc_oPagina
326:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
327: 
328:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
329: 
330:         *-- Container de botoes de acao (Grupo_Salva: posicao aprox. Right side)
331:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
332:         WITH loc_oPagina.cnt_4c_BotoesDados
333:             .Top         = 38
334:             .Left        = 819
335:             .Width       = 165
336:             .Height      = 85
337:             .BackStyle = 1
338:             .BackColor   = RGB(255, 255, 255)
339:             .BorderWidth = 0
340:             .Visible     = .T.
341:         ENDWITH
342: 
343:         *-- Botao Salvar (Confirmar: Left=7, Top=5)
344:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
345:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar
346:             .Caption         = "Salvar"
347:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
348:             .PicturePosition = 13
349:             .Width           = 75
350:             .Height          = 75
351:             .Left            = 7
352:             .Top             = 5
353:             .FontName        = "Tahoma"
354:             .FontSize        = 8
355:             .Themes          = .F.
356:             .SpecialEffect   = 0
357:             .BackColor       = RGB(255, 255, 255)
358:             .ForeColor       = RGB(90, 90, 90)
359:             .Visible         = .T.
360:         ENDWITH
361:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
362: 
363:         *-- Botao Cancelar (Left=82, Top=5)
364:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
365:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
366:             .Caption         = "Encerrar"
367:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
368:             .PicturePosition = 13
369:             .Width           = 75
370:             .Height          = 75
371:             .Left            = 82
372:             .Top             = 5
373:             .FontName        = "Tahoma"
374:             .FontSize        = 8
375:             .Themes          = .F.
376:             .SpecialEffect   = 0
377:             .BackColor       = RGB(255, 255, 255)
378:             .ForeColor       = RGB(90, 90, 90)
379:             .Visible         = .T.
380:         ENDWITH
381:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
382: 
383:         *-- shp_4c_Shape2: fundo decorativo inferior (top=421+29=450)
384:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
385:         WITH loc_oPagina.shp_4c_Shape2
386:             .Top           = 450
387:             .Left          = 54
388:             .Width         = 912
389:             .Height        = 38
390:             .BackStyle     = 0
391:             .BorderWidth   = 1
392:             .SpecialEffect = 1
393:             .Visible       = .T.
394:         ENDWITH
395: 
396:         *-- lbl_4c_Label1: Say1 (Codigo) top=44+29=73
397:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
398:         WITH loc_oPagina.lbl_4c_Label1
399:             .Caption   = "C" + CHR(243) + "digo :"
400:             .Top       = 73
401:             .Left      = 223
402:             .Width     = 42
403:             .Height    = 15
404:             .BackStyle = 0
405:             .ForeColor = RGB(90, 90, 90)
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .Visible   = .T.
409:         ENDWITH
410: 
411:         *-- txt_4c_Codigo: getCodigo top=39+29=68; InputMask NCM 9999.99.9999
412:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
413:         WITH loc_oPagina.txt_4c_Codigo
414:             .Value         = ""
415:             .Top           = 68
416:             .Left          = 268
417:             .Width         = 94
418:             .Height        = 25
419:             .Format        = "R"
420:             .InputMask     = "9999.99.9999"
421:             .MaxLength     = 12

*-- Linhas 514 a 626:
514: 
515:         *-- opt_4c_Opt_TpSubSt: opt_TpSubSt top=66+29=95
516:         *-- Value=2 default (Valor Determinado); getIVAST habilitado quando Value=1 (IVA)
517:         loc_oPagina.AddObject("opt_4c_Opt_TpSubSt", "OptionGroup")
518:         WITH loc_oPagina.opt_4c_Opt_TpSubSt
519:             .ButtonCount = 2
520:             .Top         = 95
521:             .Left        = 527
522:             .Width       = 182
523:             .Height      = 27
524:             .AutoSize    = .F.
525:             .BackStyle   = 0
526:             .BorderStyle = 0
527:             .Value       = 2
528:             .Enabled     = .F.
529:             .Visible     = .T.
530:         ENDWITH
531:         WITH loc_oPagina.opt_4c_Opt_TpSubSt.Buttons(1)
532:             .Caption   = "IVA"
533:             .Left      = 5
534:             .Top       = 5
535:             .AutoSize  = .T.
536:             .BackStyle = 0
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .ForeColor = RGB(90, 90, 90)
540:         ENDWITH
541:         WITH loc_oPagina.opt_4c_Opt_TpSubSt.Buttons(2)
542:             .Caption   = "Valor Determinado"
543:             .Left      = 58
544:             .Top       = 5
545:             .AutoSize  = .T.
546:             .BackStyle = 0
547:             .FontName  = "Tahoma"
548:             .FontSize  = 8
549:             .ForeColor = RGB(90, 90, 90)
550:         ENDWITH
551:         BINDEVENT(loc_oPagina.opt_4c_Opt_TpSubSt, "InteractiveChange", THIS, "TpSubStChanged")
552: 
553:         *-- lbl_4c_Label11: Say11 (Tipo da Mercadoria label) top=100+29=129
554:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
555:         WITH loc_oPagina.lbl_4c_Label11
556:             .Caption   = "C" + CHR(243) + "digo do Tipo da Mercadoria :"
557:             .Top       = 129
558:             .Left      = 114
559:             .Width     = 151
560:             .Height    = 15
561:             .BackStyle = 0
562:             .ForeColor = RGB(90, 90, 90)
563:             .FontName  = "Tahoma"
564:             .FontSize  = 8
565:             .Visible   = .T.
566:         ENDWITH
567: 
568:         *-- cbo_4c_CmbTipoMerc: CmbTipoMerc top=95+29=124; itens 01-76 via PopularCmbTipoMerc
569:         loc_oPagina.AddObject("cbo_4c_CmbTipoMerc", "ComboBox")
570:         WITH loc_oPagina.cbo_4c_CmbTipoMerc
571:             .Top           = 124
572:             .Left          = 268
573:             .Width         = 54
574:             .Height        = 25
575:             .Style         = 2
576:             .SpecialEffect = 1
577:             .RowSourceType = 0
578:             .FontName      = "Tahoma"
579:             .FontSize      = 8
580:             .BackColor     = RGB(255, 255, 255)
581:             .ForeColor     = RGB(90, 90, 90)
582:             .Enabled       = .F.
583:             .Visible       = .T.
584:         ENDWITH
585:         THIS.PopularCmbTipoMerc()
586:         BINDEVENT(loc_oPagina.cbo_4c_CmbTipoMerc, "InteractiveChange", THIS, "CmbTipoMercChange")
587: 
588:         *-- lbl_4c_Label10: Say10 (IVAST label) top=100+29=129
589:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
590:         WITH loc_oPagina.lbl_4c_Label10
591:             .Caption   = "IVA-ST Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria SP :"
592:             .Top       = 129
593:             .Left      = 362
594:             .Width     = 167
595:             .Height    = 15
596:             .BackStyle = 0
597:             .ForeColor = RGB(90, 90, 90)
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         *-- txt_4c_IVAST: getIVAST top=95+29=124; habilitado somente quando TpSubSt=1 (IVA)
604:         loc_oPagina.AddObject("txt_4c_IVAST", "TextBox")
605:         WITH loc_oPagina.txt_4c_IVAST
606:             .Value         = 0
607:             .Top           = 124
608:             .Left          = 533
609:             .Width         = 70
610:             .Height        = 25
611:             .InputMask     = "9999.999"
612:             .MaxLength     = 8
613:             .SpecialEffect = 1
614:             .FontName      = "Tahoma"
615:             .FontSize      = 8
616:             .ForeColor     = RGB(90, 90, 90)
617:             .BackColor     = RGB(255, 255, 255)
618:             .Enabled       = .F.
619:             .Visible       = .T.
620:         ENDWITH
621: 
622:         *-- lbl_4c_LblTipoMerc: lblTipoMerc - descricao dinamica do tipo de mercadoria
623:         *-- Aparece sobre shp_4c_Shape2 (top=424+29=453)
624:         loc_oPagina.AddObject("lbl_4c_LblTipoMerc", "Label")
625:         WITH loc_oPagina.lbl_4c_LblTipoMerc
626:             .Caption   = ""

*-- Linhas 688 a 731:
688:             .Enabled       = .F.
689:             .Visible       = .T.
690:         ENDWITH
691:         BINDEVENT(loc_oPagina.txt_4c_Areduzida, "LostFocus", THIS, "ValidarAreduzida")
692: 
693:         *-- lbl_4c_Label8: Say8 (Aliquota Base Reduzida ICMS) top=128+29=157
694:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
695:         WITH loc_oPagina.lbl_4c_Label8
696:             .Caption   = "Al" + CHR(237) + "quota Base Reduzida de ICMS :"
697:             .Top       = 157
698:             .Left      = 365
699:             .Width     = 164
700:             .Height    = 15
701:             .BackStyle = 0
702:             .ForeColor = RGB(90, 90, 90)
703:             .FontName  = "Tahoma"
704:             .FontSize  = 8
705:             .Visible   = .T.
706:         ENDWITH
707: 
708:         *-- lbl_4c_Label6: Say6 (Aliquota Reduzida ICMS) top=156+29=185
709:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
710:         WITH loc_oPagina.lbl_4c_Label6
711:             .Caption   = "Al" + CHR(237) + "quota Reduzida ICMS :"
712:             .Top       = 185
713:             .Left      = 142
714:             .Width     = 123
715:             .Height    = 15
716:             .BackStyle = 0
717:             .ForeColor = RGB(90, 90, 90)
718:             .FontName  = "Tahoma"
719:             .FontSize  = 8
720:             .Visible   = .T.
721:         ENDWITH
722: 
723:         *-- cbo_4c_CmbAred: CmbAred top=151+29=180; aliq reducao S/N
724:         loc_oPagina.AddObject("cbo_4c_CmbAred", "ComboBox")
725:         WITH loc_oPagina.cbo_4c_CmbAred
726:             .Top           = 180
727:             .Left          = 268
728:             .Width         = 54
729:             .Height        = 24
730:             .Style         = 2
731:             .SpecialEffect = 1

*-- Linhas 756 a 799:
756:             .Enabled       = .F.
757:             .Visible       = .T.
758:         ENDWITH
759:         BINDEVENT(loc_oPagina.txt_4c_AreduzidaS, "LostFocus", THIS, "ValidarAreduzidaS")
760: 
761:         *-- lbl_4c_Label12: Say12 (Aliquota Base Reduzida de Subst) top=156+29=185
762:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
763:         WITH loc_oPagina.lbl_4c_Label12
764:             .Caption   = "Al" + CHR(237) + "quota Base Reduzida de Subst :"
765:             .Top       = 185
766:             .Left      = 363
767:             .Width     = 166
768:             .Height    = 15
769:             .BackStyle = 0
770:             .ForeColor = RGB(90, 90, 90)
771:             .FontName  = "Tahoma"
772:             .FontSize  = 8
773:             .Visible   = .T.
774:         ENDWITH
775: 
776:         *-- lbl_4c_Label7: Say7 (IPI) top=184+29=213
777:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
778:         WITH loc_oPagina.lbl_4c_Label7
779:             .Caption   = "IPI :"
780:             .Top       = 213
781:             .Left      = 242
782:             .Width     = 23
783:             .Height    = 15
784:             .BackStyle = 0
785:             .ForeColor = RGB(90, 90, 90)
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:             .Visible   = .T.
789:         ENDWITH
790: 
791:         *-- cbo_4c_CmbIpi: cmbIpi top=179+29=208; Tributado/Isento/Outros
792:         loc_oPagina.AddObject("cbo_4c_CmbIpi", "ComboBox")
793:         WITH loc_oPagina.cbo_4c_CmbIpi
794:             .Top           = 208
795:             .Left          = 268
796:             .Width         = 91
797:             .Height        = 25
798:             .Style         = 2
799:             .SpecialEffect = 1

*-- Linhas 922 a 965:
922:             .Enabled       = .F.
923:             .Visible       = .T.
924:         ENDWITH
925:         BINDEVENT(loc_oPagina.txt_4c_AliqFcp, "LostFocus", THIS, "ValidarAliqFcp")
926: 
927:         *-- lbl_4c_Label16: Say16 (CEST) top=268+29=297
928:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
929:         WITH loc_oPagina.lbl_4c_Label16
930:             .Caption   = "CEST :"
931:             .Top       = 297
932:             .Left      = 231
933:             .Width     = 34
934:             .Height    = 15
935:             .BackStyle = 0
936:             .ForeColor = RGB(90, 90, 90)
937:             .FontName  = "Tahoma"
938:             .FontSize  = 8
939:             .Visible   = .T.
940:         ENDWITH
941: 
942:         *-- txt_4c_Cest: getCest top=263+29=292; 7 digitos CEST
943:         loc_oPagina.AddObject("txt_4c_Cest", "TextBox")
944:         WITH loc_oPagina.txt_4c_Cest
945:             .Value         = ""
946:             .Top           = 292
947:             .Left          = 268
948:             .Width         = 94
949:             .Height        = 25
950:             .InputMask     = "9999999"
951:             .MaxLength     = 7
952:             .SpecialEffect = 1
953:             .FontName      = "Tahoma"
954:             .FontSize      = 8
955:             .ForeColor     = RGB(90, 90, 90)
956:             .BackColor     = RGB(255, 255, 255)
957:             .Enabled       = .F.
958:             .Visible       = .T.
959:         ENDWITH
960: 
961:         *-- lbl_4c_Label13: Say13 (IVA-ST para os estados) top=156+29=185
962:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
963:         WITH loc_oPagina.lbl_4c_Label13
964:             .Caption   = "IVA-ST para os estados :"
965:             .Top       = 185

*-- Linhas 1008 a 1191:
1008:             .Enabled       = .F.
1009:             .Visible       = .T.
1010:         ENDWITH
1011:         BINDEVENT(loc_oPagina.cmd_4c_Incluir, "Click", THIS, "BtnIncluirIvaClick")
1012: 
1013:         *-- cmd_4c_Excluir: excluir IVA top=291+29=320; Left=932
1014:         loc_oPagina.AddObject("cmd_4c_Excluir", "CommandButton")
1015:         WITH loc_oPagina.cmd_4c_Excluir
1016:             .Caption       = ""
1017:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1018:             .ToolTipText   = "Excluir"
1019:             .Top           = 320
1020:             .Left          = 932
1021:             .Width         = 45
1022:             .Height        = 45
1023:             .FontName      = "Verdana"
1024:             .FontSize      = 8
1025:             .FontBold      = .T.
1026:             .BackColor     = RGB(255, 255, 255)
1027:             .ForeColor     = RGB(36, 84, 155)
1028:             .Themes        = .F.
1029:             .SpecialEffect = 0
1030:             .Enabled       = .F.
1031:             .Visible       = .T.
1032:         ENDWITH
1033:         BINDEVENT(loc_oPagina.cmd_4c_Excluir, "Click", THIS, "BtnExcluirIvaClick")
1034: 
1035:         *-- cmd_4c_InsRed: InsRed top=315+29=344; Left=626
1036:         loc_oPagina.AddObject("cmd_4c_InsRed", "CommandButton")
1037:         WITH loc_oPagina.cmd_4c_InsRed
1038:             .Caption       = ""
1039:             .Picture       = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1040:             .ToolTipText   = "Inserir"
1041:             .Top           = 344
1042:             .Left          = 626
1043:             .Width         = 45
1044:             .Height        = 45
1045:             .FontName      = "Verdana"
1046:             .FontSize      = 8
1047:             .FontBold      = .T.
1048:             .BackColor     = RGB(255, 255, 255)
1049:             .ForeColor     = RGB(36, 84, 155)
1050:             .Themes        = .F.
1051:             .SpecialEffect = 0
1052:             .Enabled       = .F.
1053:             .Visible       = .T.
1054:         ENDWITH
1055:         BINDEVENT(loc_oPagina.cmd_4c_InsRed, "Click", THIS, "BtnInsRedClick")
1056: 
1057:         *-- cmd_4c_ExcRed: ExcRed top=360+29=389; Left=626
1058:         loc_oPagina.AddObject("cmd_4c_ExcRed", "CommandButton")
1059:         WITH loc_oPagina.cmd_4c_ExcRed
1060:             .Caption       = ""
1061:             .Picture       = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1062:             .ToolTipText   = "Excluir"
1063:             .Top           = 389
1064:             .Left          = 626
1065:             .Width         = 45
1066:             .Height        = 45
1067:             .FontName      = "Verdana"
1068:             .FontSize      = 8
1069:             .FontBold      = .T.
1070:             .BackColor     = RGB(255, 255, 255)
1071:             .ForeColor     = RGB(36, 84, 155)
1072:             .Themes        = .F.
1073:             .SpecialEffect = 0
1074:             .Enabled       = .F.
1075:             .Visible       = .T.
1076:         ENDWITH
1077:         BINDEVENT(loc_oPagina.cmd_4c_ExcRed, "Click", THIS, "BtnExcRedClick")
1078: 
1079:         *-- grd_4c_IVA: GradIva top=171+29=200; Left=693; Width=235; Height=234
1080:         loc_oPagina.AddObject("grd_4c_IVA", "Grid")
1081:         WITH loc_oPagina.grd_4c_IVA
1082:             .Top           = 200
1083:             .Left          = 693
1084:             .Width         = 235
1085:             .Height        = 234
1086:             .DeleteMark    = .F.
1087:             .RecordMark    = .F.
1088:             .ScrollBars    = 2
1089:             .GridLines     = 3
1090:             .GridLineWidth = 1
1091:             .GridLineColor = RGB(238, 238, 238)
1092:             .HeaderHeight  = 20
1093:             .FontName      = "Tahoma"
1094:             .FontSize      = 8
1095:             .Visible       = .T.
1096:         ENDWITH
1097: 
1098:         *-- ColumnCount FORA do WITH (Problema 36)
1099:         loc_oPagina.grd_4c_IVA.ColumnCount = 4
1100:         loc_oPagina.grd_4c_IVA.Column1.Width = 45
1101:         loc_oPagina.grd_4c_IVA.Column2.Width = 45
1102:         loc_oPagina.grd_4c_IVA.Column3.Width = 60
1103:         loc_oPagina.grd_4c_IVA.Column4.Width = 60
1104: 
1105:         WITH loc_oPagina.grd_4c_IVA.Column1
1106:             .FontName = "Tahoma"
1107:             .FontSize = 8
1108:         ENDWITH
1109:         WITH loc_oPagina.grd_4c_IVA.Column1.Header1
1110:             .Caption   = "UF Ori"
1111:             .Alignment = 2
1112:             .FontBold  = .F.
1113:             .FontName  = "Tahoma"
1114:             .FontSize  = 8
1115:         ENDWITH
1116:         WITH loc_oPagina.grd_4c_IVA.Column1.Controls(1)
1117:             .FontName    = "Tahoma"
1118:             .FontSize    = 8
1119:             .Alignment   = 3
1120:             .BorderStyle = 0
1121:             .Format      = "!"
1122:             .Margin      = 0
1123:             .Visible     = .T.
1124:         ENDWITH
1125:         BINDEVENT(loc_oPagina.grd_4c_IVA.Column1.Controls(1), "KeyPress", THIS, "IvaCol1KeyPress")
1126:         BINDEVENT(loc_oPagina.grd_4c_IVA.Column1.Controls(1), "KeyPress", THIS, "IvaLostFocusValidar")
1127: 
1128:         WITH loc_oPagina.grd_4c_IVA.Column2
1129:             .FontName = "Tahoma"
1130:             .FontSize = 8
1131:         ENDWITH
1132:         WITH loc_oPagina.grd_4c_IVA.Column2.Header1
1133:             .Caption   = "UF Des"
1134:             .Alignment = 2
1135:             .FontBold  = .F.
1136:             .FontName  = "Tahoma"
1137:             .FontSize  = 8
1138:         ENDWITH
1139:         WITH loc_oPagina.grd_4c_IVA.Column2.Controls(1)
1140:             .FontName    = "Tahoma"
1141:             .FontSize    = 8
1142:             .Alignment   = 3
1143:             .BorderStyle = 0
1144:             .Format      = "!"
1145:             .Margin      = 0
1146:             .Visible     = .T.
1147:             .ForeColor   = RGB(0, 0, 0)
1148:             .BackColor   = RGB(255, 255, 255)
1149:         ENDWITH
1150:         BINDEVENT(loc_oPagina.grd_4c_IVA.Column2.Controls(1), "KeyPress", THIS, "IvaCol2KeyPress")
1151:         BINDEVENT(loc_oPagina.grd_4c_IVA.Column2.Controls(1), "KeyPress", THIS, "IvaLostFocusValidar")
1152: 
1153:         WITH loc_oPagina.grd_4c_IVA.Column3
1154:             .FontName = "Tahoma"
1155:             .FontSize = 8
1156:         ENDWITH
1157:         WITH loc_oPagina.grd_4c_IVA.Column3.Header1
1158:             .Caption   = "IVA"
1159:             .Alignment = 2
1160:             .FontName  = "Tahoma"
1161:             .FontSize  = 8
1162:         ENDWITH
1163:         WITH loc_oPagina.grd_4c_IVA.Column3.Controls(1)
1164:             .FontName    = "Tahoma"
1165:             .BorderStyle = 0
1166:             .InputMask   = "999.999"
1167:             .Margin      = 0
1168:             .ForeColor   = RGB(0, 0, 0)
1169:             .BackColor   = RGB(255, 255, 255)
1170:         ENDWITH
1171: 
1172:         WITH loc_oPagina.grd_4c_IVA.Column4
1173:             .FontName = "Tahoma"
1174:             .FontSize = 8
1175:         ENDWITH
1176:         WITH loc_oPagina.grd_4c_IVA.Column4.Header1
1177:             .Caption   = "IVA Im"
1178:             .Alignment = 2
1179:             .FontName  = "Tahoma"
1180:             .FontSize  = 8
1181:         ENDWITH
1182:         WITH loc_oPagina.grd_4c_IVA.Column4.Controls(1)
1183:             .FontName    = "Tahoma"
1184:             .BorderStyle = 0
1185:             .InputMask   = "999.999"
1186:             .Margin      = 0
1187:             .ForeColor   = RGB(0, 0, 0)
1188:             .BackColor   = RGB(255, 255, 255)
1189:         ENDWITH
1190: 
1191:         *-- grd_4c_Reducao: GradRed top=262+29=291; Left=388; Width=235; Height=143

*-- Linhas 1233 a 1386:
1233:             .Margin      = 0
1234:             .Visible     = .T.
1235:         ENDWITH
1236:         BINDEVENT(loc_oPagina.grd_4c_Reducao.Column1.Controls(1), "KeyPress", THIS, "RedCol1KeyPress")
1237:         BINDEVENT(loc_oPagina.grd_4c_Reducao.Column1.Controls(1), "KeyPress", THIS, "RedLostFocusValidar")
1238: 
1239:         WITH loc_oPagina.grd_4c_Reducao.Column2
1240:             .FontName = "Tahoma"
1241:             .FontSize = 8
1242:         ENDWITH
1243:         WITH loc_oPagina.grd_4c_Reducao.Column2.Header1
1244:             .Caption   = "Aliq Red"
1245:             .Alignment = 2
1246:             .FontName  = "Tahoma"
1247:             .FontSize  = 8
1248:         ENDWITH
1249:         WITH loc_oPagina.grd_4c_Reducao.Column2.Controls(1)
1250:             .FontName    = "Tahoma"
1251:             .BorderStyle = 0
1252:             .InputMask   = "999.999"
1253:             .Margin      = 0
1254:             .ForeColor   = RGB(0, 0, 0)
1255:             .BackColor   = RGB(255, 255, 255)
1256:         ENDWITH
1257: 
1258:         WITH loc_oPagina.grd_4c_Reducao.Column3
1259:             .FontName = "Tahoma"
1260:             .FontSize = 8
1261:         ENDWITH
1262:         WITH loc_oPagina.grd_4c_Reducao.Column3.Header1
1263:             .Caption   = "Aliq B Red"
1264:             .Alignment = 2
1265:             .FontName  = "Tahoma"
1266:             .FontSize  = 8
1267:         ENDWITH
1268:         WITH loc_oPagina.grd_4c_Reducao.Column3.Controls(1)
1269:             .FontName    = "Tahoma"
1270:             .BorderStyle = 0
1271:             .InputMask   = "999.999"
1272:             .Margin      = 0
1273:             .ForeColor   = RGB(0, 0, 0)
1274:             .BackColor   = RGB(255, 255, 255)
1275:         ENDWITH
1276: 
1277:         *-- Popular combos apos criacao dos controles
1278:         THIS.PopularCombos()
1279: 
1280:         THIS.TornarControlesVisiveis(loc_oPagina)
1281:     ENDPROC
1282: 
1283:     *--------------------------------------------------------------------------
1284:     * Destroy - Liberacao de recursos
1285:     *--------------------------------------------------------------------------
1286:     PROCEDURE Destroy()
1287:         IF USED("crIva")
1288:             USE IN crIva
1289:         ENDIF
1290:         IF USED("crRed")
1291:             USE IN crRed
1292:         ENDIF
1293:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1294:             THIS.this_oBusinessObject = .NULL.
1295:         ENDIF
1296:         DODEFAULT()
1297:     ENDPROC
1298: 
1299:     *--------------------------------------------------------------------------
1300:     * FormatarGridLista - Formata visual do grid da lista
1301:     *--------------------------------------------------------------------------
1302:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1303:         WITH par_oGrid
1304:             IF .ColumnCount > 0
1305:                 .FontName = "Tahoma"
1306:                 .FontSize = 8
1307:             ENDIF
1308:         ENDWITH
1309:     ENDPROC
1310: 
1311:     *--------------------------------------------------------------------------
1312:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
1313:     *--------------------------------------------------------------------------
1314:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1315:         LOCAL loc_nI, loc_oObjeto
1316: 
1317:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1318:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1319: 
1320:             IF VARTYPE(loc_oObjeto) = "O"
1321:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1322:                     IF UPPER(loc_oObjeto.Name) != "LBL_4C__IPI"
1323:                         loc_oObjeto.Visible = .T.
1324:                     ENDIF
1325:                 ENDIF
1326: 
1327:                 *-- Trata PageFrame - itera Pages
1328:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1329:                     LOCAL loc_nP
1330:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1331:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1332:                     ENDFOR
1333:                 ENDIF
1334: 
1335:                 *-- Trata containers com ControlCount
1336:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1337:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1338:                 ENDIF
1339:             ENDIF
1340:         ENDFOR
1341:     ENDPROC
1342: 
1343:     *--------------------------------------------------------------------------
1344:     * Metodos CRUD - placeholders para fases 4-8
1345:     *--------------------------------------------------------------------------
1346:     PROCEDURE CarregarLista()
1347:         LOCAL loc_lResultado, loc_oGrid
1348:         loc_lResultado = .F.
1349: 
1350:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1351:             RETURN .T.
1352:         ENDIF
1353: 
1354:         TRY
1355:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1356: 
1357:             IF !THIS.this_oBusinessObject.Buscar("")
1358:                 loc_lResultado = .F.
1359:             ELSE
1360:                 *-- RecordSource PRIMEIRO (reseta ControlSource e Headers automaticamente)
1361:                 loc_oGrid.ColumnCount = 5
1362:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1363: 
1364:                 *-- ControlSource APOS RecordSource
1365:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1366:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
1367:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.aipis"
1368:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.unidades"
1369:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.cest"
1370: 
1371:                 *-- Larguras (legado: Codigos=94, Descricaos=290, Aipis=45, Unidades=31, Cest=70)
1372:                 loc_oGrid.Column1.Width = 94
1373:                 loc_oGrid.Column2.Width = 290
1374:                 loc_oGrid.Column3.Width = 45
1375:                 loc_oGrid.Column4.Width = 31
1376:                 loc_oGrid.Column5.Width = 70
1377: 
1378:                 *-- Headers OBRIGATORIO apos RecordSource (VFP reseta ao mudar RecordSource)
1379:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1380:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1381:                 loc_oGrid.Column3.Header1.Caption = "Al" + CHR(237) + "q. IPI"
1382:                 loc_oGrid.Column4.Header1.Caption = "UN"
1383:                 loc_oGrid.Column5.Header1.Caption = "CEST"
1384: 
1385:                 THIS.FormatarGridLista(loc_oGrid)
1386:                 loc_lResultado = .T.

*-- Linhas 1393 a 1848:
1393:         RETURN loc_lResultado
1394:     ENDPROC
1395: 
1396:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1397:         LOCAL loc_lResultado
1398:         loc_lResultado = .F.
1399: 
1400:         TRY
1401:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1402:                 loc_lResultado = .F.
1403:             ELSE
1404:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1405:                 IF par_nPagina = 1
1406:                     THIS.CarregarLista()
1407:                 ENDIF
1408:                 loc_lResultado = .T.
1409:             ENDIF
1410:         CATCH TO loException
1411:             MostrarErro("Erro ao alternar pagina:" + CHR(13) + loException.Message, "Erro")
1412:             loc_lResultado = .F.
1413:         ENDTRY
1414: 
1415:         RETURN loc_lResultado
1416:     ENDPROC
1417: 
1418:     PROCEDURE BtnIncluirClick()
1419:         LOCAL loc_lResultado
1420:         loc_lResultado = .F.
1421:         TRY
1422:             THIS.this_oBusinessObject.NovoRegistro()
1423:             THIS.this_lTemProduto = .F.
1424:             THIS.LimparCampos()
1425:             THIS.this_cModoAtual = "INCLUIR"
1426:             THIS.HabilitarCampos(.T.)
1427:             THIS.CriarCursoresFilhos()
1428:             THIS.VincularGridsFilhos()
1429:             THIS.AtualizarSayIPI()
1430:             THIS.pgf_4c_Paginas.ActivePage = 2
1431:             loc_lResultado = .T.
1432:         CATCH TO loException
1433:             MostrarErro("Erro ao incluir:" + CHR(13) + loException.Message, "Erro")
1434:         ENDTRY
1435:         RETURN loc_lResultado
1436:     ENDPROC
1437: 
1438:     PROCEDURE BtnVisualizarClick()
1439:         LOCAL loc_lResultado, loc_cCodigo
1440:         loc_lResultado = .F.
1441:         TRY
1442:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1443:                 SELECT cursor_4c_Dados
1444:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1445:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1446:                     THIS.BOParaForm()
1447:                     THIS.this_cModoAtual = "VISUALIZAR"
1448:                     THIS.HabilitarCampos(.F.)
1449:                     THIS.CarregarFilhos(loc_cCodigo)
1450:                     THIS.VincularGridsFilhos()
1451:                     THIS.VerificarTemProduto(loc_cCodigo)
1452:                     THIS.AtualizarSayIPI()
1453:                     THIS.pgf_4c_Paginas.ActivePage = 2
1454:                     loc_lResultado = .T.
1455:                 ENDIF
1456:             ELSE
1457:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
1458:             ENDIF
1459:         CATCH TO loException
1460:             MostrarErro("Erro ao visualizar:" + CHR(13) + loException.Message, "Erro")
1461:         ENDTRY
1462:         RETURN loc_lResultado
1463:     ENDPROC
1464: 
1465:     PROCEDURE BtnAlterarClick()
1466:         LOCAL loc_lResultado, loc_cCodigo
1467:         loc_lResultado = .F.
1468:         TRY
1469:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1470:                 SELECT cursor_4c_Dados
1471:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1472:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1473:                     THIS.this_oBusinessObject.EditarRegistro()
1474:                     THIS.BOParaForm()
1475:                     THIS.this_cModoAtual = "ALTERAR"
1476:                     THIS.HabilitarCampos(.T.)
1477:                     THIS.CarregarFilhos(loc_cCodigo)
1478:                     THIS.VincularGridsFilhos()
1479:                     THIS.VerificarTemProduto(loc_cCodigo)
1480:                     THIS.AtualizarSayIPI()
1481:                     THIS.pgf_4c_Paginas.ActivePage = 2
1482:                     loc_lResultado = .T.
1483:                 ENDIF
1484:             ELSE
1485:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
1486:             ENDIF
1487:         CATCH TO loException
1488:             MostrarErro("Erro ao alterar:" + CHR(13) + loException.Message, "Erro")
1489:         ENDTRY
1490:         RETURN loc_lResultado
1491:     ENDPROC
1492: 
1493:     PROCEDURE BtnExcluirClick()
1494:         LOCAL loc_lResultado, loc_cCodigo, loc_cSQL
1495:         loc_lResultado = .F.
1496:         TRY
1497:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1498:                 SELECT cursor_4c_Dados
1499:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1500:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do registro '" + loc_cCodigo + "'?", "Confirmar Exclus" + CHR(227) + "o")
1501:                     *-- Verifica se existem produtos usando esta classificacao fiscal
1502:                     loc_cSQL = "SELECT TOP 1 cpros FROM SigCdPro WHERE clfiscals = " + EscaparSQL(loc_cCodigo) + ;
1503:                                " UNION ALL " + ;
1504:                                "SELECT TOP 1 cpros FROM SigCdPrc WHERE clfiscals = " + EscaparSQL(loc_cCodigo)
1505:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExcPro") > 0
1506:                         IF USED("cursor_4c_ChkExcPro") AND !EOF("cursor_4c_ChkExcPro")
1507:                             IF USED("cursor_4c_ChkExcPro")
1508:                                 USE IN cursor_4c_ChkExcPro
1509:                             ENDIF
1510:                             MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Excluir, Classifica" + CHR(231) + CHR(227) + "o Fiscal J" + CHR(225) + " Informada em Produtos.", "Aviso")
1511:                         ELSE
1512:                             IF USED("cursor_4c_ChkExcPro")
1513:                                 USE IN cursor_4c_ChkExcPro
1514:                             ENDIF
1515:                             *-- Excluir filhos antes do registro principal
1516:                             SQLEXEC(gnConnHandle, "DELETE FROM SigCdIva WHERE codigos = " + EscaparSQL(loc_cCodigo))
1517:                             SQLEXEC(gnConnHandle, "DELETE FROM SigCdRed WHERE codigos = " + EscaparSQL(loc_cCodigo))
1518:                             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1519:                                 IF THIS.this_oBusinessObject.Excluir()
1520:                                     MsgInfo("Registro exclu" + CHR(237) + "do com sucesso.", "Sucesso")
1521:                                     THIS.CarregarLista()
1522:                                     loc_lResultado = .T.
1523:                                 ENDIF
1524:                             ENDIF
1525:                         ENDIF
1526:                     ELSE
1527:                         MostrarErro("Erro ao verificar produtos vinculados.", "Erro")
1528:                     ENDIF
1529:                 ENDIF
1530:             ELSE
1531:                 MsgAviso("Nenhum registro selecionado.", "Aviso")
1532:             ENDIF
1533:         CATCH TO loException
1534:             MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "Erro")
1535:         ENDTRY
1536:         RETURN loc_lResultado
1537:     ENDPROC
1538: 
1539:     PROCEDURE BtnBuscarClick()
1540:         LOCAL loc_lResultado, loc_oBusca, loc_cFiltro
1541:         loc_lResultado = .F.
1542:         TRY
1543:             loc_cFiltro = ""
1544:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1545:                 SELECT cursor_4c_Dados
1546:                 loc_cFiltro = ALLTRIM(cursor_4c_Dados.codigos)
1547:             ENDIF
1548: 
1549:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1550:                 "SIGCDCLF", "cursor_4c_BuscaClf", "codigos", loc_cFiltro, ;
1551:                 "Buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal")
1552: 
1553:             IF VARTYPE(loc_oBusca) = "O"
1554:                 IF !loc_oBusca.this_lAchouRegistro
1555:                     loc_oBusca.mAddColuna("codigos",    "", "C" + CHR(243) + "digo")
1556:                     loc_oBusca.mAddColuna("descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1557:                     loc_oBusca.Show()
1558:                 ENDIF
1559:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClf")
1560:                     SELECT cursor_4c_BuscaClf
1561:                     loc_cFiltro = ALLTRIM(cursor_4c_BuscaClf.codigos)
1562:                     IF THIS.this_oBusinessObject.Buscar("codigos = '" + ALLTRIM(loc_cFiltro) + "'")
1563:                         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1564:                             GO TOP IN cursor_4c_Dados
1565:                         ENDIF
1566:                     ENDIF
1567:                 ENDIF
1568:                 loc_oBusca.Release()
1569:             ENDIF
1570: 
1571:             IF USED("cursor_4c_BuscaClf")
1572:                 USE IN cursor_4c_BuscaClf
1573:             ENDIF
1574:             loc_lResultado = .T.
1575:         CATCH TO loException
1576:             MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "Erro")
1577:         ENDTRY
1578:         RETURN loc_lResultado
1579:     ENDPROC
1580: 
1581:     PROCEDURE BtnEncerrarClick()
1582:         TRY
1583:             THIS.Release()
1584:         CATCH TO loException
1585:             MostrarErro("Erro ao encerrar:" + CHR(13) + loException.Message, "Erro")
1586:         ENDTRY
1587:     ENDPROC
1588: 
1589:     PROCEDURE BtnSalvarClick()
1590:         LOCAL loc_lResultado, loc_oPg2, loc_cCodigo
1591:         loc_lResultado = .F.
1592:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1593: 
1594:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Codigo.Value))
1595:             MsgAviso("C" + CHR(243) + "digo obrigat" + CHR(243) + "rio.", "Aviso")
1596:             loc_oPg2.txt_4c_Codigo.SetFocus()
1597:             RETURN .F.
1598:         ENDIF
1599: 
1600:         IF EMPTY(ALLTRIM(loc_oPg2.txt_4c_Descricao.Value))
1601:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o obrigat" + CHR(243) + "ria.", "Aviso")
1602:             loc_oPg2.txt_4c_Descricao.SetFocus()
1603:             RETURN .F.
1604:         ENDIF
1605: 
1606:         TRY
1607:             THIS.FormParaBO()
1608: 
1609:             IF THIS.this_oBusinessObject.Salvar()
1610:                 loc_cCodigo = ALLTRIM(THIS.this_oBusinessObject.this_cCodigo)
1611:                 THIS.SalvarFilhos(loc_cCodigo)
1612:                 MsgInfo("Registro salvo com sucesso.", "Sucesso")
1613:                 THIS.pgf_4c_Paginas.ActivePage = 1
1614:                 THIS.CarregarLista()
1615:                 THIS.this_cModoAtual = "LISTA"
1616:                 loc_lResultado = .T.
1617:             ENDIF
1618:         CATCH TO loException
1619:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, "Erro")
1620:             loc_lResultado = .F.
1621:         ENDTRY
1622: 
1623:         RETURN loc_lResultado
1624:     ENDPROC
1625: 
1626:     PROCEDURE BtnCancelarClick()
1627:         TRY
1628:             THIS.pgf_4c_Paginas.ActivePage = 1
1629:             THIS.this_cModoAtual = "LISTA"
1630:             THIS.CarregarLista()
1631:         CATCH TO loException
1632:             MostrarErro("Erro ao cancelar:" + CHR(13) + loException.Message, "Erro")
1633:         ENDTRY
1634:     ENDPROC
1635: 
1636:     PROTECTED PROCEDURE FormParaBO()
1637:         LOCAL loc_oPg2
1638:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1639:         TRY
1640:             WITH THIS.this_oBusinessObject
1641:                 .this_cCodigo    = ALLTRIM(loc_oPg2.txt_4c_Codigo.Value)
1642:                 .this_cDescricao = ALLTRIM(loc_oPg2.txt_4c_Descricao.Value)
1643:                 .this_cUnidade   = ALLTRIM(loc_oPg2.txt_4c_Unidade.Value)
1644:                 .this_cCest      = ALLTRIM(loc_oPg2.txt_4c_Cest.Value)
1645:                 .this_nAipi      = loc_oPg2.txt_4c_Aipi.Value
1646:                 .this_nIndIVAST  = loc_oPg2.txt_4c_IVAST.Value
1647:                 .this_nBIcms     = loc_oPg2.txt_4c_Areduzida.Value
1648:                 .this_nBIcmss    = loc_oPg2.txt_4c_AreduzidaS.Value
1649:                 .this_nAliqFcp   = loc_oPg2.txt_4c_AliqFcp.Value
1650: 
1651:                 *-- ComboBoxes S/N (ListIndex 1=Sim/Tributado, 2=Nao/Isento, 3=Outros)
1652:                 .this_cBaseReds = IIF(loc_oPg2.cbo_4c_Cmbbred.ListIndex = 1, "S", "N")
1653:                 .this_cAliqReds = IIF(loc_oPg2.cbo_4c_CmbAred.ListIndex = 1, "S", "N")
1654:                 *-- cmbIpi: Tributado(1)="T", Isento(2)="I", Outros(3)="O"
1655:                 .this_cIpis     = IIF(loc_oPg2.cbo_4c_CmbIpi.ListIndex = 2, "I", ;
1656:                                       IIF(loc_oPg2.cbo_4c_CmbIpi.ListIndex = 3, "O", "T"))
1657:                 .this_cIpiProds = IIF(loc_oPg2.cbo_4c_CmbIPip.ListIndex = 1, "S", "N")
1658: 
1659:                 *-- TipoMercs via ComboBox
1660:                 .this_nTipoMercs = loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex
1661: 
1662:                 *-- TpSubSt via OptionGroup
1663:                 .this_nTpSubSt = loc_oPg2.opt_4c_Opt_TpSubSt.Value
1664:             ENDWITH
1665:         CATCH TO loException
1666:             MostrarErro("Erro em FormParaBO:" + CHR(13) + loException.Message, "Erro")
1667:         ENDTRY
1668:     ENDPROC
1669: 
1670:     PROTECTED PROCEDURE BOParaForm()
1671:         LOCAL loc_oPg2
1672:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1673:         TRY
1674:             WITH THIS.this_oBusinessObject
1675:                 loc_oPg2.txt_4c_Codigo.Value    = ALLTRIM(.this_cCodigo)
1676:                 loc_oPg2.txt_4c_Descricao.Value = ALLTRIM(.this_cDescricao)
1677:                 loc_oPg2.txt_4c_Unidade.Value   = ALLTRIM(.this_cUnidade)
1678:                 loc_oPg2.txt_4c_Cest.Value      = ALLTRIM(.this_cCest)
1679:                 loc_oPg2.txt_4c_Aipi.Value      = .this_nAipi
1680:                 loc_oPg2.txt_4c_IVAST.Value     = .this_nIndIVAST
1681:                 loc_oPg2.txt_4c_Areduzida.Value = .this_nBIcms
1682:                 loc_oPg2.txt_4c_AreduzidaS.Value= .this_nBIcmss
1683:                 loc_oPg2.txt_4c_AliqFcp.Value   = .this_nAliqFcp
1684: 
1685:                 *-- ComboBoxes S/N (plain strings - no \< prefix no sistema novo)
1686:                 loc_oPg2.cbo_4c_Cmbbred.Value = IIF(UPPER(ALLTRIM(.this_cBaseReds)) = "S", "Sim", "N" + CHR(227) + "o")
1687:                 loc_oPg2.cbo_4c_CmbAred.Value = IIF(UPPER(ALLTRIM(.this_cAliqReds)) = "S", "Sim", "N" + CHR(227) + "o")
1688:                 *-- cmbIpi: T=Tributado, I=Isento, O=Outros
1689:                 loc_oPg2.cbo_4c_CmbIpi.Value  = IIF(UPPER(ALLTRIM(.this_cIpis)) = "O", "Outros", ;
1690:                                                      IIF(UPPER(ALLTRIM(.this_cIpis)) = "I", "Isento", "Tributado"))
1691:                 loc_oPg2.cbo_4c_CmbIPip.Value = IIF(UPPER(ALLTRIM(.this_cIpiProds)) = "S", "Sim", "N" + CHR(227) + "o")
1692: 
1693:                 *-- TipoMercs
1694:                 loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex = .this_nTipoMercs
1695: 
1696:                 *-- TpSubSt
1697:                 loc_oPg2.opt_4c_Opt_TpSubSt.Value = IIF(.this_nTpSubSt > 0, .this_nTpSubSt, 1)
1698:             ENDWITH
1699:             THIS.TpSubStChanged()
1700:             THIS.CmbTipoMercChange()
1701:         CATCH TO loException
1702:             MostrarErro("Erro em BOParaForm:" + CHR(13) + loException.Message, "Erro")
1703:         ENDTRY
1704:     ENDPROC
1705: 
1706:     PROTECTED PROCEDURE LimparCampos()
1707:         LOCAL loc_oPg2
1708:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1709:         TRY
1710:             loc_oPg2.txt_4c_Codigo.Value     = ""
1711:             loc_oPg2.txt_4c_Descricao.Value  = ""
1712:             loc_oPg2.txt_4c_Unidade.Value    = ""
1713:             loc_oPg2.txt_4c_Cest.Value       = ""
1714:             loc_oPg2.txt_4c_Aipi.Value       = 0
1715:             loc_oPg2.txt_4c_IVAST.Value      = 0
1716:             loc_oPg2.txt_4c_Areduzida.Value  = 0
1717:             loc_oPg2.txt_4c_AreduzidaS.Value = 0
1718:             loc_oPg2.txt_4c_AliqFcp.Value    = 0
1719:             loc_oPg2.cbo_4c_Cmbbred.ListIndex = 2
1720:             loc_oPg2.cbo_4c_CmbAred.ListIndex = 2
1721:             loc_oPg2.cbo_4c_CmbIpi.ListIndex  = 1
1722:             loc_oPg2.cbo_4c_CmbIPip.ListIndex = 2
1723:             loc_oPg2.cbo_4c_CmbTipoMerc.ListIndex = 0
1724:             loc_oPg2.opt_4c_Opt_TpSubSt.Value = 1
1725:             IF USED("crIva")
1726:                 SELECT crIva
1727:                 ZAP
1728:             ENDIF
1729:             IF USED("crRed")
1730:                 SELECT crRed
1731:                 ZAP
1732:             ENDIF
1733:         CATCH TO loException
1734:             MostrarErro("Erro em LimparCampos:" + CHR(13) + loException.Message, "Erro")
1735:         ENDTRY
1736:     ENDPROC
1737: 
1738:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1739:         LOCAL loc_oPg2, loc_lCodigoHab
1740:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1741:         loc_lCodigoHab = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
1742:         TRY
1743:             loc_oPg2.txt_4c_Codigo.Enabled    = loc_lCodigoHab
1744:             loc_oPg2.txt_4c_Descricao.Enabled = par_lHabilitar
1745:             loc_oPg2.txt_4c_Unidade.Enabled   = par_lHabilitar
1746:             loc_oPg2.txt_4c_Cest.Enabled      = par_lHabilitar
1747:             loc_oPg2.txt_4c_Aipi.Enabled      = par_lHabilitar
1748:             loc_oPg2.txt_4c_IVAST.Enabled     = par_lHabilitar AND (loc_oPg2.opt_4c_Opt_TpSubSt.Value = 1)
1749:             loc_oPg2.txt_4c_Areduzida.Enabled = par_lHabilitar
1750:             loc_oPg2.txt_4c_AreduzidaS.Enabled= par_lHabilitar
1751:             loc_oPg2.txt_4c_AliqFcp.Enabled   = par_lHabilitar
1752:             loc_oPg2.cbo_4c_Cmbbred.Enabled   = par_lHabilitar
1753:             loc_oPg2.cbo_4c_CmbAred.Enabled   = par_lHabilitar
1754:             loc_oPg2.cbo_4c_CmbIpi.Enabled    = par_lHabilitar
1755:             loc_oPg2.cbo_4c_CmbIPip.Enabled   = par_lHabilitar AND !THIS.this_lTemProduto
1756:             loc_oPg2.cbo_4c_CmbTipoMerc.Enabled= par_lHabilitar
1757:             loc_oPg2.opt_4c_Opt_TpSubSt.Enabled= par_lHabilitar
1758:             *-- Botoes de grid IVA/RED habilitados so em INCLUIR/ALTERAR
1759:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Incluir", 5)
1760:             ENDIF
1761:             IF PEMSTATUS(loc_oPg2, "cmd_4c_Excluir", 5)
1762:             ENDIF
1763:             IF PEMSTATUS(loc_oPg2, "cmd_4c_InsRed", 5)
1764:             ENDIF
1765:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcRed", 5)
1766:             ENDIF
1767:         CATCH TO loException
1768:             MostrarErro("Erro em HabilitarCampos:" + CHR(13) + loException.Message, "Erro")
1769:         ENDTRY
1770:     ENDPROC
1771: 
1772:     *--------------------------------------------------------------------------
1773:     * PopularCmbTipoMerc - Popula ComboBox de Tipo de Mercadoria (76 itens)
1774:     *--------------------------------------------------------------------------
1775:     PROTECTED PROCEDURE PopularCmbTipoMerc()
1776:         LOCAL loc_oPg2, loc_i
1777:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1778:         TRY
1779:             loc_oPg2.cbo_4c_CmbTipoMerc.Clear()
1780:             FOR loc_i = 1 TO 76
1781:                 loc_oPg2.cbo_4c_CmbTipoMerc.AddItem(TRANSFORM(loc_i, "@L 99"))
1782:             ENDFOR
1783:         CATCH TO loException
1784:             MostrarErro("Erro em PopularCmbTipoMerc:" + CHR(13) + loException.Message, "Erro")
1785:         ENDTRY
1786:     ENDPROC
1787: 
1788:     *--------------------------------------------------------------------------
1789:     * TpSubStChanged - Handler InteractiveChange opt_4c_Opt_TpSubSt
1790:     * Legado: getIVAST.When = Return(This.Parent.opt_TpSubSt.Value == 1)
1791:     *--------------------------------------------------------------------------
1792:     PROCEDURE TpSubStChanged()
1793:         LOCAL loc_oPg2, loc_lHabilitar
1794:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1795:         TRY
1796:             loc_lHabilitar = (loc_oPg2.opt_4c_Opt_TpSubSt.Value = 1) AND ;
1797:                              INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1798:             loc_oPg2.txt_4c_IVAST.Enabled = loc_lHabilitar
1799:         CATCH TO loException
1800:             MostrarErro("Erro em TpSubStChanged:" + CHR(13) + loException.Message, "Erro")
1801:         ENDTRY
1802:     ENDPROC
1803: 
1804:     *--------------------------------------------------------------------------
1805:     * CmbTipoMercChange - Handler InteractiveChange cbo_4c_CmbTipoMerc
1806:     * Legado: CmbTipoMerc.InteractiveChange -> lblTipoMerc.Caption = ar_Msgs(This.Value)
1807:     *--------------------------------------------------------------------------
1808:     PROCEDURE CmbTipoMercChange()
1809:         LOCAL loc_oPg2, loc_nIdx
1810:         LOCAL ar_Msgs(76)
1811:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1812:         TRY
1813:             ar_Msgs(1)  = "Medicamentos constantes da Lista Positiva da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
1814:             ar_Msgs(2)  = "Medicamentos constantes da Lista Negativa da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
1815:             ar_Msgs(3)  = "Medicamentos constantes da Lista Neutra da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
1816:             ar_Msgs(4)  = "Produtos Cosm" + CHR(233) + "ticos e de Perfumaria Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 18%"
1817:             ar_Msgs(5)  = "Produtos Cosm" + CHR(233) + "ticos e de Perfumaria Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 25%"
1818:             ar_Msgs(6)  = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 18%, itens de 1 a 10 do artigo 313-G do RICMS"
1819:             ar_Msgs(7)  = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 12%, itens de 1 a 10 do artigo 313-G do RICMS"
1820:             ar_Msgs(8)  = "Bebida Alco" + CHR(243) + "lica, exceto cerveja e chope, sujeita ao IVA-ST"
1821:             ar_Msgs(9)  = "Bebida Alco" + CHR(243) + "lica, exceto cerveja e chope, sujeita ao Pre" + CHR(231) + "o Final ao Consumidor, divulgado pela SEFAZ/SP"
1822:             ar_Msgs(10) = "Prepara" + CHR(231) + CHR(245) + "es qu" + CHR(237) + "micas contraceptivas " + CHR(224) + " base de horm" + CHR(244) + "nios ou espermicidas, constantes da Lista Positiva da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
1823:             ar_Msgs(11) = "Prepara" + CHR(231) + CHR(245) + "es qu" + CHR(237) + "micas contraceptivas " + CHR(224) + " base de horm" + CHR(244) + "nios ou espermicidas, constantes da Lista Negativa da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
1824:             ar_Msgs(12) = "Prepara" + CHR(231) + CHR(245) + "es qu" + CHR(237) + "micas contraceptivas " + CHR(224) + " base de horm" + CHR(244) + "nios ou espermicidas, constantes da Lista Neutra da Incid" + CHR(234) + "ncia do PIS/PASEP e COFINS"
1825:             ar_Msgs(13) = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 18%, itens 11 a 19 do artigo 313-G do RICMS"
1826:             ar_Msgs(14) = "Produtos de Higiene Pessoal Sujeitos " + CHR(224) + " al" + CHR(237) + "quota de 12%, itens 11 a 19 do artigo 313-G do RICMS"
1827:             ar_Msgs(15) = "Produtos de Limpeza - " + CHR(193) + "gua sanit" + CHR(225) + "ria, branqueador ou alvejante"
1828:             ar_Msgs(16) = "Produtos de Limpeza - odorizante/desodorizante de ambiente e superf" + CHR(237) + "cie"
1829:             ar_Msgs(17) = "Produtos de Limpeza - sab" + CHR(245) + "es em barras, peda" + CHR(231) + "os ou figuras moldados"
1830:             ar_Msgs(18) = "Produtos de Limpeza - sab" + CHR(245) + "es ou detergentes em p" + CHR(243) + ", flocos, palhetas, gr" + CHR(226) + "nulos ou outras formas semelhantes"
1831:             ar_Msgs(19) = "Produtos de Limpeza - detergentes l" + CHR(237) + "quidos"
1832:             ar_Msgs(20) = "Produtos de Limpeza - outras prepara" + CHR(231) + CHR(245) + "es tensoativas para lavagem e limpeza (inclusive multiuso e limpadores)"
1833:             ar_Msgs(21) = "Produtos de Limpeza - pomadas, cremes e prepara" + CHR(231) + CHR(245) + "es semelhantes, para cal" + CHR(231) + "ados ou para couros"
1834:             ar_Msgs(22) = "Produtos de Limpeza - pastas, p" + CHR(243) + "s, sapon" + CHR(225) + "ceos e outras prepara" + CHR(231) + CHR(245) + "es para arear"
1835:             ar_Msgs(23) = "Produtos de Limpeza - facilitadores e goma para passar roupa"
1836:             ar_Msgs(24) = "Produtos de Limpeza - inseticidas, rodenticidas, fungicidas, raticidas e outros produtos semelhantes, apresentados em formas ou embalagens exclusivamente para uso domissanit" + CHR(225) + "rio direto"
1837:             ar_Msgs(25) = "Produtos de Limpeza - desinfetantes apresentados em formas ou embalagens exclusivamente para uso domissanit" + CHR(225) + "rio direto"
1838:             ar_Msgs(26) = "Produtos de Limpeza - amaciante/suavizante"
1839:             ar_Msgs(27) = "Produtos de Limpeza - esponjas para limpeza"
1840:             ar_Msgs(28) = "Papel para escrita, impress" + CHR(227) + "o ou outros fins gr" + CHR(225) + "ficos, em folhas, de peso entre 40 e 150g/m2"
1841:             ar_Msgs(29) = "L" + CHR(226) + "mpadas, tubos, v" + CHR(225) + "lvulas, reatores e " + CHR(34) + "starters" + CHR(34)
1842:             ar_Msgs(30) = "Pilhas e Baterias Novas"
1843:             ar_Msgs(31) = "Produtos Fonogr" + CHR(225) + "ficos"
1844:             ar_Msgs(32) = "Autope" + CHR(231) + "as - IVA ST de 26,50%"
1845:             ar_Msgs(33) = "Autope" + CHR(231) + "as - IVA ST de 40%"
1846:             ar_Msgs(34) = "Ra" + CHR(231) + CHR(227) + "o tipo " + CHR(34) + "pet" + CHR(34) + " para animais dom" + CHR(233) + "sticos"
1847:             ar_Msgs(35) = "Chocolates - IVA ST de 43,23%"
1848:             ar_Msgs(36) = "Chocolates - IVA ST de 24,73%"

*-- Linhas 1901 a 2014:
1901:     *--------------------------------------------------------------------------
1902:     * PopularCombos - Popula os 4 ComboBoxes da Page2
1903:     *--------------------------------------------------------------------------
1904:     PROTECTED PROCEDURE PopularCombos
1905:         LOCAL loc_oPg2
1906:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1907:         TRY
1908:             loc_oPg2.cbo_4c_Cmbbred.Clear()
1909:             loc_oPg2.cbo_4c_Cmbbred.AddItem("Sim")
1910:             loc_oPg2.cbo_4c_Cmbbred.AddItem("N" + CHR(227) + "o")
1911: 
1912:             loc_oPg2.cbo_4c_CmbAred.Clear()
1913:             loc_oPg2.cbo_4c_CmbAred.AddItem("Sim")
1914:             loc_oPg2.cbo_4c_CmbAred.AddItem("N" + CHR(227) + "o")
1915: 
1916:             loc_oPg2.cbo_4c_CmbIpi.Clear()
1917:             loc_oPg2.cbo_4c_CmbIpi.AddItem("Tributado")
1918:             loc_oPg2.cbo_4c_CmbIpi.AddItem("Isento")
1919:             loc_oPg2.cbo_4c_CmbIpi.AddItem("Outros")
1920: 
1921:             loc_oPg2.cbo_4c_CmbIPip.Clear()
1922:             loc_oPg2.cbo_4c_CmbIPip.AddItem("Sim")
1923:             loc_oPg2.cbo_4c_CmbIPip.AddItem("N" + CHR(227) + "o")
1924:         CATCH TO loException
1925:             MostrarErro("Erro em PopularCombos:" + CHR(13) + loException.Message, "Erro")
1926:         ENDTRY
1927:     ENDPROC
1928: 
1929:     *--------------------------------------------------------------------------
1930:     * CriarCursoresFilhos - Cria cursores locais crIva e crRed com 1 linha em branco
1931:     *--------------------------------------------------------------------------
1932:     PROTECTED PROCEDURE CriarCursoresFilhos
1933:         TRY
1934:             IF USED("crIva")
1935:                 USE IN crIva
1936:             ENDIF
1937:             IF USED("crRed")
1938:                 USE IN crRed
1939:             ENDIF
1940: 
1941:             SET NULL OFF
1942:             CREATE CURSOR crIva (codigos c(12), estasO c(2), estasD c(2), ;
1943:                                  indivast n(7,3), indivastPi n(7,3), cidChaves c(10))
1944:             SELECT crIva
1945:             APPEND BLANK
1946: 
1947:             CREATE CURSOR crRed (codigos c(12), estas c(2), aReds n(7,3), ;
1948:                                  bReds n(7,3), cidChaves c(10))
1949:             SELECT crRed
1950:             APPEND BLANK
1951:             SET NULL ON
1952:         CATCH TO loException
1953:             SET NULL ON
1954:             MostrarErro("Erro em CriarCursoresFilhos:" + CHR(13) + loException.Message, "Erro")
1955:         ENDTRY
1956:     ENDPROC
1957: 
1958:     *--------------------------------------------------------------------------
1959:     * CarregarFilhos - Carrega crIva e crRed do banco para o codigo informado
1960:     *--------------------------------------------------------------------------
1961:     PROTECTED PROCEDURE CarregarFilhos
1962:         LPARAMETERS par_cCodigo
1963:         LOCAL loc_lResultado, loc_cSQL
1964:         loc_lResultado = .F.
1965:         TRY
1966:             IF USED("crIva")
1967:                 USE IN crIva
1968:             ENDIF
1969:             IF USED("crRed")
1970:                 USE IN crRed
1971:             ENDIF
1972: 
1973:             SET NULL OFF
1974:             CREATE CURSOR crIva (codigos c(12), estasO c(2), estasD c(2), ;
1975:                                  indivast n(7,3), indivastPi n(7,3), cidChaves c(10))
1976:             CREATE CURSOR crRed (codigos c(12), estas c(2), aReds n(7,3), ;
1977:                                  bReds n(7,3), cidChaves c(10))
1978:             SET NULL ON
1979: 
1980:             *-- Carregar IVAs do banco
1981:             loc_cSQL = "SELECT codigos, estasO, estasD, indivast, indivastPi, cidChaves " + ;
1982:                        "FROM SigCdIva WHERE codigos = " + EscaparSQL(par_cCodigo)
1983:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpIva") > 0
1984:                 IF USED("cursor_4c_TmpIva") AND RECCOUNT("cursor_4c_TmpIva") > 0
1985:                     SELECT cursor_4c_TmpIva
1986:                     SCAN
1987:                         SELECT crIva
1988:                         APPEND BLANK
1989:                         REPLACE crIva.codigos    WITH cursor_4c_TmpIva.codigos, ;
1990:                                 crIva.estasO     WITH cursor_4c_TmpIva.estasO, ;
1991:                                 crIva.estasD     WITH cursor_4c_TmpIva.estasD, ;
1992:                                 crIva.indivast   WITH cursor_4c_TmpIva.indivast, ;
1993:                                 crIva.indivastPi WITH cursor_4c_TmpIva.indivastPi, ;
1994:                                 crIva.cidChaves  WITH cursor_4c_TmpIva.cidChaves
1995:                         SELECT cursor_4c_TmpIva
1996:                     ENDSCAN
1997:                 ENDIF
1998:                 IF USED("cursor_4c_TmpIva")
1999:                     USE IN cursor_4c_TmpIva
2000:                 ENDIF
2001:             ENDIF
2002:             SELECT crIva
2003:             IF RECCOUNT() = 0
2004:                 APPEND BLANK
2005:             ENDIF
2006: 
2007:             *-- Carregar Reducoes do banco
2008:             loc_cSQL = "SELECT codigos, estas, aReds, bReds, cidChaves " + ;
2009:                        "FROM SigCdRed WHERE codigos = " + EscaparSQL(par_cCodigo)
2010:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpRed") > 0
2011:                 IF USED("cursor_4c_TmpRed") AND RECCOUNT("cursor_4c_TmpRed") > 0
2012:                     SELECT cursor_4c_TmpRed
2013:                     SCAN
2014:                         SELECT crRed

*-- Linhas 2040 a 2123:
2040:     *--------------------------------------------------------------------------
2041:     * VincularGridsFilhos - Vincula grids grd_4c_IVA e grd_4c_Reducao aos cursores
2042:     *--------------------------------------------------------------------------
2043:     PROTECTED PROCEDURE VincularGridsFilhos
2044:         LOCAL loc_oPg2, loc_oGrdIva, loc_oGrdRed
2045:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2046:         loc_oGrdIva = loc_oPg2.grd_4c_IVA
2047:         loc_oGrdRed = loc_oPg2.grd_4c_Reducao
2048:         TRY
2049:             loc_oGrdIva.RecordSource = "crIva"
2050:             loc_oGrdIva.Column1.ControlSource = "crIva.estasO"
2051:             loc_oGrdIva.Column2.ControlSource = "crIva.estasD"
2052:             loc_oGrdIva.Column3.ControlSource = "crIva.indivast"
2053:             loc_oGrdIva.Column4.ControlSource = "crIva.indivastPi"
2054:             loc_oGrdIva.Column1.Width = 45
2055:             loc_oGrdIva.Column2.Width = 45
2056:             loc_oGrdIva.Column3.Width = 60
2057:             loc_oGrdIva.Column4.Width = 60
2058:             loc_oGrdIva.Column1.Header1.Caption = "UF Ori"
2059:             loc_oGrdIva.Column2.Header1.Caption = "UF Des"
2060:             loc_oGrdIva.Column3.Header1.Caption = "IVA"
2061:             loc_oGrdIva.Column4.Header1.Caption = "IVA Im"
2062:             loc_oGrdIva.Refresh()
2063: 
2064:             loc_oGrdRed.RecordSource = "crRed"
2065:             loc_oGrdRed.Column1.ControlSource = "crRed.estas"
2066:             loc_oGrdRed.Column2.ControlSource = "crRed.aReds"
2067:             loc_oGrdRed.Column3.ControlSource = "crRed.bReds"
2068:             loc_oGrdRed.Column1.Width = 51
2069:             loc_oGrdRed.Column2.Width = 72
2070:             loc_oGrdRed.Column3.Width = 72
2071:             loc_oGrdRed.Column1.Header1.Caption = "UF Dest"
2072:             loc_oGrdRed.Column2.Header1.Caption = "Aliq Red"
2073:             loc_oGrdRed.Column3.Header1.Caption = "Aliq B Red"
2074:             loc_oGrdRed.Refresh()
2075:         CATCH TO loException
2076:             MostrarErro("Erro em VincularGridsFilhos:" + CHR(13) + loException.Message, "Erro")
2077:         ENDTRY
2078:     ENDPROC
2079: 
2080:     *--------------------------------------------------------------------------
2081:     * SalvarFilhos - Salva SigCdIva e SigCdRed via DELETE+INSERT
2082:     *--------------------------------------------------------------------------
2083:     PROTECTED PROCEDURE SalvarFilhos
2084:         LPARAMETERS par_cCodigo
2085:         LOCAL loc_lResultado, loc_cSQL, loc_cChave
2086:         loc_lResultado = .T.
2087:         TRY
2088:             SQLEXEC(gnConnHandle, "DELETE FROM SigCdIva WHERE codigos = " + EscaparSQL(par_cCodigo))
2089: 
2090:             IF USED("crIva")
2091:                 SELECT crIva
2092:                 GO TOP
2093:                 SCAN
2094:                     IF !EMPTY(ALLTRIM(crIva.estasO)) AND !EMPTY(ALLTRIM(crIva.estasD))
2095:                         loc_cChave = IIF(EMPTY(ALLTRIM(crIva.cidChaves)), ;
2096:                                          LEFT(SYS(2015) + SYS(2015), 10), ;
2097:                                          ALLTRIM(crIva.cidChaves))
2098:                         loc_cSQL = "INSERT INTO SigCdIva (codigos, estasO, estasD, indivast, indivastPi, cidchaves) " + ;
2099:                                    "VALUES (" + EscaparSQL(par_cCodigo) + ", " + ;
2100:                                    EscaparSQL(PADR(ALLTRIM(crIva.estasO), 2)) + ", " + ;
2101:                                    EscaparSQL(PADR(ALLTRIM(crIva.estasD), 2)) + ", " + ;
2102:                                    FormatarNumeroSQL(crIva.indivast) + ", " + ;
2103:                                    FormatarNumeroSQL(crIva.indivastPi) + ", " + ;
2104:                                    EscaparSQL(loc_cChave) + ")"
2105:                         SQLEXEC(gnConnHandle, loc_cSQL)
2106:                     ENDIF
2107:                 ENDSCAN
2108:             ENDIF
2109: 
2110:             SQLEXEC(gnConnHandle, "DELETE FROM SigCdRed WHERE codigos = " + EscaparSQL(par_cCodigo))
2111: 
2112:             IF USED("crRed")
2113:                 SELECT crRed
2114:                 GO TOP
2115:                 SCAN
2116:                     IF !EMPTY(ALLTRIM(crRed.estas))
2117:                         loc_cChave = IIF(EMPTY(ALLTRIM(crRed.cidChaves)), ;
2118:                                          LEFT(SYS(2015) + SYS(2015), 10), ;
2119:                                          ALLTRIM(crRed.cidChaves))
2120:                         loc_cSQL = "INSERT INTO SigCdRed (codigos, estas, aReds, bReds, cidchaves) " + ;
2121:                                    "VALUES (" + EscaparSQL(par_cCodigo) + ", " + ;
2122:                                    EscaparSQL(PADR(ALLTRIM(crRed.estas), 2)) + ", " + ;
2123:                                    FormatarNumeroSQL(crRed.aReds) + ", " + ;

*-- Linhas 2137 a 2482:
2137:     *--------------------------------------------------------------------------
2138:     * BtnIncluirIvaClick - Adiciona linha em branco ao grid IVA
2139:     *--------------------------------------------------------------------------
2140:     PROCEDURE BtnIncluirIvaClick
2141:         LOCAL loc_lResultado
2142:         loc_lResultado = .F.
2143:         TRY
2144:             IF USED("crIva")
2145:                 SELECT crIva
2146:                 LOCATE FOR EMPTY(ALLTRIM(estasO))
2147:                 IF EOF()
2148:                     APPEND BLANK
2149:                     REPLACE crIva.estasO    WITH SPACE(2), ;
2150:                             crIva.estasD    WITH SPACE(2), ;
2151:                             crIva.indivast  WITH 0, ;
2152:                             crIva.indivastPi WITH 0
2153:                 ENDIF
2154:                 THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Refresh()
2155:                 loc_lResultado = .T.
2156:             ENDIF
2157:         CATCH TO loException
2158:             MostrarErro("Erro ao incluir IVA:" + CHR(13) + loException.Message, "Erro")
2159:         ENDTRY
2160:         RETURN loc_lResultado
2161:     ENDPROC
2162: 
2163:     *--------------------------------------------------------------------------
2164:     * BtnExcluirIvaClick - Exclui linha corrente do grid IVA
2165:     *--------------------------------------------------------------------------
2166:     PROCEDURE BtnExcluirIvaClick
2167:         LOCAL loc_lResultado
2168:         loc_lResultado = .F.
2169:         TRY
2170:             IF USED("crIva")
2171:                 SELECT crIva
2172:                 IF !EOF() AND !BOF()
2173:                     DELETE
2174:                     THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Refresh()
2175:                     loc_lResultado = .T.
2176:                 ENDIF
2177:             ENDIF
2178:         CATCH TO loException
2179:             MostrarErro("Erro ao excluir IVA:" + CHR(13) + loException.Message, "Erro")
2180:         ENDTRY
2181:         RETURN loc_lResultado
2182:     ENDPROC
2183: 
2184:     *--------------------------------------------------------------------------
2185:     * BtnInsRedClick - Adiciona linha em branco ao grid Reducao
2186:     *--------------------------------------------------------------------------
2187:     PROCEDURE BtnInsRedClick
2188:         LOCAL loc_lResultado
2189:         loc_lResultado = .F.
2190:         TRY
2191:             IF USED("crRed")
2192:                 SELECT crRed
2193:                 LOCATE FOR EMPTY(ALLTRIM(estas))
2194:                 IF EOF()
2195:                     APPEND BLANK
2196:                     REPLACE crRed.estas WITH SPACE(2), ;
2197:                             crRed.aReds WITH 0, ;
2198:                             crRed.bReds WITH 0
2199:                 ENDIF
2200:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Refresh()
2201:                 loc_lResultado = .T.
2202:             ENDIF
2203:         CATCH TO loException
2204:             MostrarErro("Erro ao incluir Redu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
2205:         ENDTRY
2206:         RETURN loc_lResultado
2207:     ENDPROC
2208: 
2209:     *--------------------------------------------------------------------------
2210:     * BtnExcRedClick - Exclui linha corrente do grid Reducao
2211:     *--------------------------------------------------------------------------
2212:     PROCEDURE BtnExcRedClick
2213:         LOCAL loc_lResultado
2214:         loc_lResultado = .F.
2215:         TRY
2216:             IF USED("crRed")
2217:                 SELECT crRed
2218:                 IF !EOF() AND !BOF()
2219:                     DELETE
2220:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Refresh()
2221:                     loc_lResultado = .T.
2222:                 ENDIF
2223:             ENDIF
2224:         CATCH TO loException
2225:             MostrarErro("Erro ao excluir Redu" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "Erro")
2226:         ENDTRY
2227:         RETURN loc_lResultado
2228:     ENDPROC
2229: 
2230:     *--------------------------------------------------------------------------
2231:     * IvaCol1KeyPress - Handler KeyPress para grd_4c_IVA.Column1 (estasO)
2232:     *--------------------------------------------------------------------------
2233:     PROCEDURE IvaCol1KeyPress
2234:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2235:         IF par_nKeyCode = 115  && F4
2236:             THIS.AbrirLookupUF(THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Column1.Controls(1))
2237:         ENDIF
2238:     ENDPROC
2239: 
2240:     *--------------------------------------------------------------------------
2241:     * IvaCol2KeyPress - Handler KeyPress para grd_4c_IVA.Column2 (estasD)
2242:     *--------------------------------------------------------------------------
2243:     PROCEDURE IvaCol2KeyPress
2244:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2245:         IF par_nKeyCode = 115  && F4
2246:             THIS.AbrirLookupUF(THIS.pgf_4c_Paginas.Page2.grd_4c_IVA.Column2.Controls(1))
2247:         ENDIF
2248:     ENDPROC
2249: 
2250:     *--------------------------------------------------------------------------
2251:     * RedCol1KeyPress - Handler KeyPress para grd_4c_Reducao.Column1 (estas)
2252:     *--------------------------------------------------------------------------
2253:     PROCEDURE RedCol1KeyPress
2254:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2255:         IF par_nKeyCode = 115  && F4
2256:             THIS.AbrirLookupUF(THIS.pgf_4c_Paginas.Page2.grd_4c_Reducao.Column1.Controls(1))
2257:         ENDIF
2258:     ENDPROC
2259: 
2260:     *--------------------------------------------------------------------------
2261:     * AbrirLookupUF - Abre FormBuscaAuxiliar em SigCdUfs para selecao de estado
2262:     *--------------------------------------------------------------------------
2263:     PROTECTED PROCEDURE AbrirLookupUF
2264:         LPARAMETERS par_oCampo
2265:         LOCAL loc_lResultado, loc_oBusca, loc_cAtual
2266:         loc_lResultado = .F.
2267:         TRY
2268:             IF VARTYPE(par_oCampo) != "O"
2269:                 loc_lResultado = .F.
2270:             ELSE
2271:                 loc_cAtual = PADR(ALLTRIM(par_oCampo.Value), 2)
2272:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2273:                     "SigCdUfs", "cursor_4c_BuscaUf", "Estados", loc_cAtual, ;
2274:                     "Sele" + CHR(231) + CHR(227) + "o")
2275:                 IF VARTYPE(loc_oBusca) = "O"
2276:                     IF !loc_oBusca.this_lAchouRegistro
2277:                         loc_oBusca.mAddColuna("Estados", "", "UF")
2278:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2279:                         loc_oBusca.Show()
2280:                     ENDIF
2281:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaUf")
2282:                         SELECT cursor_4c_BuscaUf
2283:                         par_oCampo.Value = ALLTRIM(cursor_4c_BuscaUf.Estados)
2284:                         par_oCampo.Refresh()
2285:                     ENDIF
2286:                     loc_oBusca.Release()
2287:                 ENDIF
2288:                 IF USED("cursor_4c_BuscaUf")
2289:                     USE IN cursor_4c_BuscaUf
2290:                 ENDIF
2291:                 loc_lResultado = .T.
2292:             ENDIF
2293:         CATCH TO loException
2294:             MostrarErro("Erro ao abrir lookup UF:" + CHR(13) + loException.Message, "Erro")
2295:         ENDTRY
2296:         RETURN loc_lResultado
2297:     ENDPROC
2298: 
2299:     *--------------------------------------------------------------------------
2300:     * IvaLostFocusValidar - Verifica duplicatas em crIva (estasO+estasD)
2301:     *--------------------------------------------------------------------------
2302:     PROCEDURE IvaLostFocusValidar
2303:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2304:         TRY
2305:             IF USED("crIva")
2306:                 SELECT estasO, estasD FROM crIva ;
2307:                     INTO CURSOR cursor_4c_DupIva ;
2308:                     GROUP BY estasO, estasD HAVING COUNT(1) > 1
2309:                 SELECT cursor_4c_DupIva
2310:                 IF RECCOUNT() > 0
2311:                     MsgAviso("IVA j" + CHR(225) + " lan" + CHR(231) + "ado!!!", "Aviso")
2312:                 ENDIF
2313:                 IF USED("cursor_4c_DupIva")
2314:                     USE IN cursor_4c_DupIva
2315:                 ENDIF
2316:                 SELECT crIva
2317:             ENDIF
2318:         CATCH TO loException
2319:             MostrarErro("Erro em IvaLostFocusValidar:" + CHR(13) + loException.Message, "Erro")
2320:         ENDTRY
2321:     ENDPROC
2322: 
2323:     *--------------------------------------------------------------------------
2324:     * RedLostFocusValidar - Verifica duplicatas em crRed (estas)
2325:     *--------------------------------------------------------------------------
2326:     PROCEDURE RedLostFocusValidar
2327:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2328:         TRY
2329:             IF USED("crRed")
2330:                 SELECT estas FROM crRed ;
2331:                     INTO CURSOR cursor_4c_DupRed ;
2332:                     GROUP BY estas HAVING COUNT(1) > 1
2333:                 SELECT cursor_4c_DupRed
2334:                 IF RECCOUNT() > 0
2335:                     MsgAviso("Redu" + CHR(231) + CHR(227) + "o j" + CHR(225) + " lan" + CHR(231) + "ada!!!", "Aviso")
2336:                 ENDIF
2337:                 IF USED("cursor_4c_DupRed")
2338:                     USE IN cursor_4c_DupRed
2339:                 ENDIF
2340:                 SELECT crRed
2341:             ENDIF
2342:         CATCH TO loException
2343:             MostrarErro("Erro em RedLostFocusValidar:" + CHR(13) + loException.Message, "Erro")
2344:         ENDTRY
2345:     ENDPROC
2346: 
2347:     *--------------------------------------------------------------------------
2348:     * ValidarAliqFcp - Valida range 0-2 para AliqFcp (LostFocus)
2349:     *--------------------------------------------------------------------------
2350:     PROTECTED PROCEDURE ValidarAliqFcp
2351:         LOCAL loc_oPg2
2352:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2353:         TRY
2354:             IF loc_oPg2.txt_4c_AliqFcp.Value < 0 OR loc_oPg2.txt_4c_AliqFcp.Value > 2
2355:                 MsgAviso("Valor da Al" + CHR(237) + "quota Inv" + CHR(225) + "lida.", "Aviso")
2356:                 loc_oPg2.txt_4c_AliqFcp.SetFocus()
2357:             ENDIF
2358:         CATCH TO loException
2359:             MostrarErro("Erro em ValidarAliqFcp:" + CHR(13) + loException.Message, "Erro")
2360:         ENDTRY
2361:     ENDPROC
2362: 
2363:     *--------------------------------------------------------------------------
2364:     * ValidarAreduzida - Valida >= 0 para BIcms (LostFocus)
2365:     *--------------------------------------------------------------------------
2366:     PROTECTED PROCEDURE ValidarAreduzida
2367:         LOCAL loc_oPg2
2368:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2369:         TRY
2370:             IF loc_oPg2.txt_4c_Areduzida.Value < 0
2371:                 MsgAviso("Valor da Al" + CHR(237) + "quota Inv" + CHR(225) + "lida.", "Aviso")
2372:                 loc_oPg2.txt_4c_Areduzida.SetFocus()
2373:             ENDIF
2374:         CATCH TO loException
2375:             MostrarErro("Erro em ValidarAreduzida:" + CHR(13) + loException.Message, "Erro")
2376:         ENDTRY
2377:     ENDPROC
2378: 
2379:     *--------------------------------------------------------------------------
2380:     * ValidarAreduzidaS - Valida >= 0 para BIcmss (LostFocus)
2381:     *--------------------------------------------------------------------------
2382:     PROTECTED PROCEDURE ValidarAreduzidaS
2383:         LOCAL loc_oPg2
2384:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2385:         TRY
2386:             IF loc_oPg2.txt_4c_AreduzidaS.Value < 0
2387:                 MsgAviso("Valor da Al" + CHR(237) + "quota Inv" + CHR(225) + "lida.", "Aviso")
2388:                 loc_oPg2.txt_4c_AreduzidaS.SetFocus()
2389:             ENDIF
2390:         CATCH TO loException
2391:             MostrarErro("Erro em ValidarAreduzidaS:" + CHR(13) + loException.Message, "Erro")
2392:         ENDTRY
2393:     ENDPROC
2394: 
2395:     *--------------------------------------------------------------------------
2396:     * VerificarTemProduto - Verifica se ha produtos com AliqIPI<>0 para este CLF
2397:     *--------------------------------------------------------------------------
2398:     PROTECTED PROCEDURE VerificarTemProduto
2399:         LPARAMETERS par_cCodigo
2400:         LOCAL loc_lResultado, loc_cSQL
2401:         loc_lResultado = .F.
2402:         TRY
2403:             loc_cSQL = "SELECT COUNT(*) AS QtProd FROM SigCdPro " + ;
2404:                        "WHERE clfiscals = " + EscaparSQL(par_cCodigo)
2405:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkProd") > 0
2406:                 IF USED("cursor_4c_ChkProd")
2407:                     SELECT cursor_4c_ChkProd
2408:                     THIS.this_lTemProduto = (cursor_4c_ChkProd.QtProd > 0)
2409:                     USE IN cursor_4c_ChkProd
2410:                 ELSE
2411:                     THIS.this_lTemProduto = .F.
2412:                 ENDIF
2413:             ELSE
2414:                 THIS.this_lTemProduto = .F.
2415:             ENDIF
2416:             loc_lResultado = .T.
2417:         CATCH TO loException
2418:             MostrarErro("Erro em VerificarTemProduto:" + CHR(13) + loException.Message, "Erro")
2419:         ENDTRY
2420:         RETURN loc_lResultado
2421:     ENDPROC
2422: 
2423:     *--------------------------------------------------------------------------
2424:     * AtualizarSayIPI - Exibe/oculta lbl_4c__IPI conforme this_lTemProduto
2425:     *--------------------------------------------------------------------------
2426:     PROTECTED PROCEDURE AtualizarSayIPI
2427:         LOCAL loc_oPg2
2428:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2429:         TRY
2430:             IF PEMSTATUS(loc_oPg2, "lbl_4c__IPI", 5)
2431:                 loc_oPg2.lbl_4c__IPI.Visible = THIS.this_lTemProduto
2432:             ENDIF
2433:         CATCH TO loException
2434:             MostrarErro("Erro em AtualizarSayIPI:" + CHR(13) + loException.Message, "Erro")
2435:         ENDTRY
2436:     ENDPROC
2437: 
2438:     *--------------------------------------------------------------------------
2439:     * AjustarBotoesPorModo - Ajusta estado dos botoes CRUD conforme modo atual
2440:     * Modos: LISTA, INCLUIR, ALTERAR, VISUALIZAR
2441:     *--------------------------------------------------------------------------
2442:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2443:         LOCAL loc_oPg1, loc_oPg2, loc_lModoEdicao, loc_lModoLista
2444:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
2445:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2446:         TRY
2447:             loc_lModoLista  = (THIS.this_cModoAtual = "LISTA")
2448:             loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2449: 
2450:             *-- Botoes da Page1 (CRUD)
2451:             IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
2452:                 WITH loc_oPg1.cnt_4c_Botoes
2453:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
2454:                         .cmd_4c_Incluir.Enabled   = loc_lModoLista
2455:                     ENDIF
2456:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
2457:                         .cmd_4c_Visualizar.Enabled = loc_lModoLista
2458:                     ENDIF
2459:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
2460:                         .cmd_4c_Alterar.Enabled   = loc_lModoLista
2461:                     ENDIF
2462:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
2463:                         .cmd_4c_Excluir.Enabled   = loc_lModoLista
2464:                     ENDIF
2465:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
2466:                         .cmd_4c_Buscar.Enabled    = loc_lModoLista
2467:                     ENDIF
2468:                     .Visible     = .T.
2469:                 ENDWITH
2470:             ENDIF
2471: 
2472:             *-- Botoes da Page2 (Salvar/Cancelar)
2473:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesDados", 5)
2474:                 WITH loc_oPg2.cnt_4c_BotoesDados
2475:                     IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesDados, "cmd_4c_Salvar", 5)
2476:                         .cmd_4c_Salvar.Enabled   = loc_lModoEdicao
2477:                     ENDIF
2478:                     IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesDados, "cmd_4c_Cancelar", 5)
2479:                         .cmd_4c_Cancelar.Enabled = .T.
2480:                     ENDIF
2481:                     .Visible     = .T.
2482:                 ENDWITH


### BO (C:\4c\projeto\app\classes\ClfBO.prg):
*==============================================================================
* ClfBO.prg - Business Object para Classificacao Fiscal
* Tabela: SIGCDCLF
* Tabelas filhas: sigcdiva (IVAs por estado), sigcdred (Reducoes por estado)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS ClfBO AS BusinessBase

    *-- Propriedades da entidade (SIGCDCLF)
    this_cCodigo    = ""   && codigos char(10) PK
    this_cDescricao = ""   && descricaos char(40)
    this_nAipi      = 0    && aipis numeric(9,2) - Aliq. IPI padrao
    this_cUnidade   = ""   && unidades char(3)
    this_cAliqReds  = ""   && aliqreds char(1) S/N - Aliquota Reduzida ICMS
    this_cBaseReds  = ""   && basereds char(1) S/N - Base Reduzida ICMS
    this_cIpis      = ""   && ipis char(1) S/N - flag IPI
    this_cSitRibs   = ""   && sitribs char(3) - Situacao Tributaria
    this_nBIcms     = 0    && bicms numeric(9,6) - percentual Base Reduzida ICMS
    this_nIndIVAST  = 0    && indivast numeric(7,3) - IVA-ST SP
    this_cIpiProds  = ""   && ipiprods char(1) S/N - IPI por produto
    this_nTipoMercs = 0    && tipoMercs numeric(2,0) - Codigo Tipo Mercadoria
    this_nTpSubSt   = 0    && TpSubSt numeric(1,0) - 1=IVA 2=Valor Determinado
    this_nBIcmss    = 0    && bicmss numeric(9,6) - Base Reduzida Substituicao
    this_nAliqFcp   = 0    && aliqfcp numeric(6,3) - Aliquota ICMS FCP
    this_cCest      = ""   && cest char(7) - CEST
    this_cUniTrib   = ""   && unitrib char(6) - Unidade Tributaria

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDCLF"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(codigos,    "C")
            THIS.this_cDescricao = TratarNulo(descricaos, "C")
            THIS.this_nAipi      = TratarNulo(aipis,      "N")
            THIS.this_cUnidade   = TratarNulo(unidades,   "C")
            THIS.this_cAliqReds  = TratarNulo(aliqreds,   "C")
            THIS.this_cBaseReds  = TratarNulo(basereds,   "C")
            THIS.this_cIpis      = TratarNulo(ipis,       "C")
            THIS.this_cSitRibs   = TratarNulo(sitribs,    "C")
            THIS.this_nBIcms     = TratarNulo(bicms,      "N")
            THIS.this_nIndIVAST  = TratarNulo(indivast,   "N")
            THIS.this_cIpiProds  = TratarNulo(ipiprods,   "C")
            THIS.this_nTipoMercs = TratarNulo(tipoMercs,  "N")
            THIS.this_nTpSubSt   = TratarNulo(TpSubSt,    "N")
            THIS.this_nBIcmss    = TratarNulo(bicmss,     "N")
            THIS.this_nAliqFcp   = TratarNulo(aliqfcp,    "N")
            THIS.this_cCest      = TratarNulo(cest,        "C")
            THIS.this_cUniTrib   = TratarNulo(unitrib,    "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SIGCDCLF
    * par_cFiltro: condicao WHERE adicional (vazio = todos)
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades, cest" + ;
                " FROM SIGCDCLF"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY codigos"
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT codigos, descricaos, aipis, unidades," + ;
                " aliqreds, basereds, ipis, sitribs, bicms, indivast," + ;
                " ipiprods, tipoMercs, TpSubSt, bicmss, aliqfcp, cest, unitrib" + ;
                " FROM SIGCDCLF WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarIVAsPorCodigo - Carrega registros de sigcdiva para cursor local
    * Retorna cursor crIva readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarIVAsPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdiva WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpIva_4c")
            IF loc_nResultado >= 0
                IF USED("crIva")
                    SELECT crIva
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crIva ;
                        (cidchaves C(20), codigos C(10), estasO C(2), estasD C(2), ;
                         indivast N(7,3), indivastpi N(7,3), diasprz N(3,0))
                    SET NULL OFF
                ENDIF
                SELECT TmpIva_4c
                SCAN
                    SELECT crIva
                    APPEND BLANK
                    REPLACE codigos    WITH ALLTRIM(TmpIva_4c.codigos), ;
                            estasO     WITH ALLTRIM(TmpIva_4c.estaso), ;
                            estasD     WITH ALLTRIM(TmpIva_4c.estasd), ;
                            cidchaves  WITH ALLTRIM(TmpIva_4c.cidchaves), ;
                            indivast   WITH TmpIva_4c.indivast, ;
                            indivastpi WITH TmpIva_4c.indivastpi, ;
                            diasprz    WITH TmpIva_4c.diasprz
                ENDSCAN
                USE IN TmpIva_4c
                IF RECCOUNT("crIva") = 0
                    SELECT crIva
                    APPEND BLANK
                ENDIF
                SELECT crIva
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar IVAs:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarIVAsPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpIva_4c")
                USE IN TmpIva_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarReducoesPorCodigo - Carrega registros de sigcdred para cursor local
    * Retorna cursor crRed readwrite
    *--------------------------------------------------------------------------
    FUNCTION CarregarReducoesPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT * FROM sigcdred WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "TmpRed_4c")
            IF loc_nResultado >= 0
                IF USED("crRed")
                    SELECT crRed
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR crRed ;
                        (cidchaves C(20), codigos C(10), estas C(2), ;
                         areds N(6,3), breds N(6,3))
                    SET NULL OFF
                ENDIF
                SELECT TmpRed_4c
                SCAN
                    SELECT crRed
                    APPEND BLANK
                    REPLACE codigos   WITH ALLTRIM(TmpRed_4c.codigos), ;
                            estas     WITH ALLTRIM(TmpRed_4c.estas), ;
                            cidchaves WITH ALLTRIM(TmpRed_4c.cidchaves), ;
                            areds     WITH TmpRed_4c.areds, ;
                            breds     WITH TmpRed_4c.breds
                ENDSCAN
                USE IN TmpRed_4c
                SELECT crRed
                GO TOP
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar Redu" + CHR(231) + CHR(245) + "es:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.CarregarReducoesPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("TmpRed_4c")
                USE IN TmpRed_4c
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Validar - Valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Validar()
        LOCAL loc_lValido
        loc_lValido = .T.
        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND (THIS.this_nAliqFcp < 0 OR THIS.this_nAliqFcp > 2)
            MsgAviso("Valor da Al" + CHR(237) + "quota FCP Inv" + CHR(225) + "lida. Deve ser entre 0 e 2.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcms < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida ICMS inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        IF loc_lValido AND THIS.this_nBIcmss < 0
            MsgAviso("Al" + CHR(237) + "quota Base Reduzida Substitui" + CHR(231) + CHR(227) + "o inv" + CHR(225) + "lida.", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF
        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarDuplicata - Verifica se codigo ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION VerificarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SIGCDCLF WHERE codigos = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dup")
                TABLEREVERT(.T., "cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Dup") > 0
                SELECT cursor_4c_Dup
                loc_lExiste = (cursor_4c_Dup.qtde > 0)
            ENDIF
            IF USED("cursor_4c_Dup")
                USE IN cursor_4c_Dup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarDuplicata:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cCidChave
        loc_lResultado = .F.
        TRY
            IF THIS.VerificarDuplicata()
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SIGCDCLF" + ;
                    " (codigos, descricaos, aipis, unidades, aliqreds, basereds," + ;
                    " ipis, sitribs, bicms, indivast, ipiprods, tipoMercs," + ;
                    " TpSubSt, bicmss, aliqfcp, cest, unitrib)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCodigo)    + ", " + ;
                    EscaparSQL(THIS.this_cDescricao) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAipi)      + ", " + ;
                    EscaparSQL(THIS.this_cUnidade)   + ", " + ;
                    EscaparSQL(THIS.this_cAliqReds)  + ", " + ;
                    EscaparSQL(THIS.this_cBaseReds)  + ", " + ;
                    EscaparSQL(THIS.this_cIpis)      + ", " + ;
                    EscaparSQL(THIS.this_cSitRibs)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcms)     + ", " + ;
                    FormatarNumeroSQL(THIS.this_nIndIVAST)  + ", " + ;
                    EscaparSQL(THIS.this_cIpiProds)  + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTipoMercs) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpSubSt)   + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBIcmss)    + ", " + ;
                    FormatarNumeroSQL(THIS.this_nAliqFcp)   + ", " + ;
                    EscaparSQL(THIS.this_cCest)      + ", " + ;
                    EscaparSQL(THIS.this_cUniTrib)   + ")"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.SalvarIVAs(THIS.this_cCodigo)
                    THIS.SalvarReducoes(THIS.this_cCodigo)
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE SIGCDCLF SET" + ;
                " descricaos = "  + EscaparSQL(THIS.this_cDescricao) + "," + ;
                " aipis = "       + FormatarNumeroSQL(THIS.this_nAipi)     + "," + ;
                " unidades = "    + EscaparSQL(THIS.this_cUnidade)   + "," + ;
                " aliqreds = "    + EscaparSQL(THIS.this_cAliqReds)  + "," + ;
                " basereds = "    + EscaparSQL(THIS.this_cBaseReds)  + "," + ;
                " ipis = "        + EscaparSQL(THIS.this_cIpis)      + "," + ;
                " sitribs = "     + EscaparSQL(THIS.this_cSitRibs)   + "," + ;
                " bicms = "       + FormatarNumeroSQL(THIS.this_nBIcms)    + "," + ;
                " indivast = "    + FormatarNumeroSQL(THIS.this_nIndIVAST) + "," + ;
                " ipiprods = "    + EscaparSQL(THIS.this_cIpiProds)  + "," + ;
                " tipoMercs = "   + FormatarNumeroSQL(THIS.this_nTipoMercs)+ "," + ;
                " TpSubSt = "     + FormatarNumeroSQL(THIS.this_nTpSubSt)  + "," + ;
                " bicmss = "      + FormatarNumeroSQL(THIS.this_nBIcmss)   + "," + ;
                " aliqfcp = "     + FormatarNumeroSQL(THIS.this_nAliqFcp)  + "," + ;
                " cest = "        + EscaparSQL(THIS.this_cCest)      + "," + ;
                " unitrib = "     + EscaparSQL(THIS.this_cUniTrib)   + ;
                " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.SalvarIVAs(THIS.this_cCodigo)
                THIS.SalvarReducoes(THIS.this_cCodigo)
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na SIGCDCLF e tabelas filhas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_cSQL = "DELETE FROM SIGCDCLF WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Classifica" + CHR(231) + CHR(227) + "o Fiscal:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarIVAs - Salva registros do cursor crIva em sigcdiva
    * Estrategia: DELETE todos os IVAs do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarIVAs(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdiva WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crIva")
                SELECT crIva
                SCAN
                    IF !EMPTY(ALLTRIM(crIva.estasO)) OR !EMPTY(ALLTRIM(crIva.estasD))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdiva" + ;
                            " (cidchaves, codigos, estaso, estasd, indivast, indivastpi, diasprz)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)            + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))     + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasO))    + ", " + ;
                            EscaparSQL(ALLTRIM(crIva.estasD))    + ", " + ;
                            FormatarNumeroSQL(crIva.indivast)    + ", " + ;
                            FormatarNumeroSQL(crIva.indivastpi)  + ", " + ;
                            FormatarNumeroSQL(crIva.diasprz)     + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar IVA:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarIVAs:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarReducoes - Salva registros do cursor crRed em sigcdred
    * Estrategia: DELETE todas as reducoes do codigo + INSERT dos do cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE SalvarReducoes(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cCidChave, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigcdred WHERE codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))
            SQLEXEC(gnConnHandle, loc_cSQL)
            IF USED("crRed")
                SELECT crRed
                SCAN
                    IF !EMPTY(ALLTRIM(crRed.estas))
                        loc_cCidChave = SYS(2015)
                        loc_cSQL = "INSERT INTO sigcdred" + ;
                            " (cidchaves, codigos, estas, areds, breds)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cCidChave)         + ", " + ;
                            EscaparSQL(ALLTRIM(par_cCodigo))  + ", " + ;
                            EscaparSQL(ALLTRIM(crRed.estas))  + ", " + ;
                            FormatarNumeroSQL(crRed.areds)    + ", " + ;
                            FormatarNumeroSQL(crRed.breds)    + ")"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao salvar Redu" + CHR(231) + CHR(227) + "o:" + ;
                                CHR(13) + CapturarErroSQL(), "Erro SQL")
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.SalvarReducoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarTemProduto - Verifica se existem produtos com aliquota IPI
    * Retorna .T. se ha produtos com IPI associados a este codigo
    *--------------------------------------------------------------------------
    FUNCTION VerificarTemProduto(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lTem
        loc_lTem = .F.
        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtde FROM SigCdPro" + ;
                " WHERE clfiscals = " + EscaparSQL(ALLTRIM(par_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmPro")
                TABLEREVERT(.T., "cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmPro")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_TmPro") > 0
                SELECT cursor_4c_TmPro
                loc_lTem = (cursor_4c_TmPro.qtde > 0)
            ENDIF
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ClfBO.VerificarTemProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_TmPro")
                USE IN cursor_4c_TmPro
            ENDIF
        ENDTRY
        RETURN loc_lTem
    ENDFUNC

ENDDEFINE

