# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [BINDEVENT-PARAMS] Handler 'ValidarCidade' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCidade(par_nKeyCode, par_nShiftAltCtrl)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFre.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1155 linhas total):

*-- Linhas 4 a 205:
4: * Legado:  SigCdFre.SCX (frmcadastro)
5: * Tabelas: SigCdFrt (modo global, PK=cidas)
6: *          SigOpFrt (modo operacional, PK=cidchaves, filtrado por dopes)
7: * Uso:     Standalone -> CREATEOBJECT("FormFre")
8: *          Operacional -> CREATEOBJECT("FormFre", oParent, "DOPES")
9: *==============================================================================
10: 
11: DEFINE CLASS FormFre AS FormBase
12: 
13:     *-- Propriedades visuais (PILAR 1 - UX Fidelity, EXATO do legado)
14:     Height      = 600
15:     Width       = 1000
16:     Caption     = "Cadastro de Fretes x Cidades"
17:     AutoCenter  = .T.
18:     ShowWindow  = 1
19:     WindowType  = 1
20:     ControlBox  = .F.
21:     TitleBar    = 0
22:     Themes      = .F.
23:     BorderStyle = 2
24: 
25:     *-- Propriedades de estado
26:     this_oBusinessObject = .NULL.
27:     this_cModoAtual      = "LISTA"
28: 
29:     *-- Propriedades especificas do FormFre
30:     this_cDopes      = ""      && Tipo de operacao (vazio = modo global SigCdFrt)
31:     this_oParentForm = .NULL.  && Form pai desabilitado enquanto este esta aberto
32: 
33:     *===========================================================================
34:     * Init - Inicializa o formulario
35:     *   par_oParentForm: form pai a ser desabilitado (opcional)
36:     *   par_cOperacao:   tipo de operacao/dopes para modo operacional (opcional)
37:     * Captura parametros ANTES do DODEFAULT() pois InicializarForm() usa this_cDopes
38:     *===========================================================================
39:     PROCEDURE Init(par_oParentForm, par_cOperacao)
40:         LOCAL loc_lSucesso
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             *-- Capturar referencia ao form pai
45:             IF PCOUNT() >= 1 AND VARTYPE(par_oParentForm) = "O"
46:                 THIS.this_oParentForm = par_oParentForm
47:             ENDIF
48: 
49:             *-- Capturar tipo de operacao (modo operacional)
50:             IF PCOUNT() >= 2 AND VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao)
51:                 THIS.this_cDopes = ALLTRIM(par_cOperacao)
52:             ENDIF
53: 
54:             *-- Ajustar caption e variavel global pDopFrt (compatibilidade legado)
55:             IF !EMPTY(THIS.this_cDopes)
56:                 THIS.Caption = "Frete por Cidade " + THIS.this_cDopes
57:             ENDIF
58: 
59:             PUBLIC pDopFrt
60:             pDopFrt = THIS.this_cDopes
61: 
62:             *-- FormBase.Init() chama THIS.InicializarForm() via DODEFAULT()
63:             loc_lSucesso = DODEFAULT()
64:         CATCH TO loException
65:             MostrarErro(loException, "FormFre.Init")
66:         ENDTRY
67: 
68:         RETURN loc_lSucesso
69:     ENDPROC
70: 
71:     *===========================================================================
72:     * InicializarForm - Configura estrutura completa
73:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
74:     *===========================================================================
75:     PROTECTED PROCEDURE InicializarForm()
76:         LOCAL loc_lSucesso
77:         loc_lSucesso = .F.
78: 
79:         TRY
80:             *-- 1. Criar BO e propagar modo operacional
81:             THIS.this_oBusinessObject = CREATEOBJECT("FreBO")
82: 
83:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
84:                 MostrarErro("Erro ao criar FreBO" + CHR(13) + ;
85:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
86:                     "FormFre.InicializarForm")
87:             ELSE
88:                 THIS.this_oBusinessObject.this_cDopes = THIS.this_cDopes
89: 
90:                 *-- 2. Criar estrutura de paginas
91:                 THIS.ConfigurarPageFrame()
92: 
93:                 *-- 3. Propagar caption para labels do cabecalho
94:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
95:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
96: 
97:                 THIS.pgf_4c_Paginas.Visible   = .T.
98:                 THIS.pgf_4c_Paginas.ActivePage = 1
99:                 THIS.this_cModoAtual           = "LISTA"
100: 
101:                 *-- 4. Carregar cursor TmpCep e lista de registros
102:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
103:                     THIS.CarregarTmpCep()
104:                     THIS.CarregarLista()
105:                 ENDIF
106: 
107:                 loc_lSucesso = .T.
108:             ENDIF
109: 
110:         CATCH TO loException
111:             MostrarErro("Erro ao inicializar FormFre:" + CHR(13) + ;
112:                 loException.Message + CHR(13) + ;
113:                 "Linha: " + TRANSFORM(loException.LineNo), ;
114:                 "FormFre.InicializarForm")
115:         ENDTRY
116: 
117:         RETURN loc_lSucesso
118:     ENDPROC
119: 
120:     *===========================================================================
121:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
122:     * Top=-29 esconde as abas; controles compensam +29 no Top
123:     *===========================================================================
124:     PROTECTED PROCEDURE ConfigurarPageFrame()
125:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
126: 
127:         WITH THIS.pgf_4c_Paginas
128:             .PageCount = 2
129:             .Top       = -29
130:             .Left      = 0
131:             .Width     = THIS.Width
132:             .Height    = THIS.Height + 29
133:             .Tabs      = .F.
134:             .Visible   = .T.
135: 
136:             .Page1.Caption   = "Lista"
137:             .Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
138:             .Page1.BackColor = RGB(255, 255, 255)
139: 
140:             .Page2.Caption   = "Dados"
141:             .Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
142:             .Page2.BackColor = RGB(255, 255, 255)
143:         ENDWITH
144: 
145:         THIS.ConfigurarPaginaLista()
146:         THIS.ConfigurarPaginaDados()
147:     ENDPROC
148: 
149:     *===========================================================================
150:     * ConfigurarPaginaLista - Configura Page1 (Lista)
151:     * Containers: cnt_4c_Cabecalho, cnt_4c_Botoes (5 botoes CRUD), cnt_4c_Saida (Encerrar)
152:     * Grid: grd_4c_Lista (grade no legado: Top=121, Left=12, Width=971, Height=470)
153:     *===========================================================================
154:     PROTECTED PROCEDURE ConfigurarPaginaLista()
155:         LOCAL loc_oPagina
156:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
157: 
158:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
159:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
160: 
161:         *-- Container cabecalho (cntSombra no legado: Top=1, compensado +29 = 30)
162:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
163:         WITH loc_oPagina.cnt_4c_Cabecalho
164:             .Top         = 30
165:             .Left        = 0
166:             .Width       = THIS.Width
167:             .Height      = 80
168:             .BackColor   = RGB(100, 100, 100)
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
174:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
175:             .Caption   = THIS.Caption
176:             .Top       = 15
177:             .Left      = 10
178:             .Width     = THIS.Width - 20
179:             .Height    = 40
180:             .FontName  = "Tahoma"
181:             .FontSize  = 16
182:             .FontBold  = .T.
183:             .ForeColor = RGB(0, 0, 0)
184:             .BackStyle = 0
185:             .AutoSize  = .F.
186:             .Visible   = .T.
187:         ENDWITH
188: 
189:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
190:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
191:             .Caption   = THIS.Caption
192:             .Top       = 18
193:             .Left      = 10
194:             .Width     = THIS.Width - 20
195:             .Height    = 46
196:             .FontName  = "Tahoma"
197:             .FontSize  = 16
198:             .FontBold  = .T.
199:             .ForeColor = RGB(255, 255, 255)
200:             .BackStyle = 0
201:             .AutoSize  = .F.
202:             .Visible   = .T.
203:         ENDWITH
204: 
205:         *-- Container botoes CRUD (Grupo_op no legado: Left=543, Top=-1, compensado +29 = 28)

*-- Linhas 235 a 405:
235:             .MousePointer    = 15
236:             .WordWrap        = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
239: 
240:         *-- Botao Visualizar (Left=80)
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
243:             .Caption         = "Visualizar"
244:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
245:             .PicturePosition = 13
246:             .Top             = 5
247:             .Left            = 80
248:             .Width           = 75
249:             .Height          = 75
250:             .BackColor       = RGB(255, 255, 255)
251:             .ForeColor       = RGB(90, 90, 90)
252:             .FontName        = "Comic Sans MS"
253:             .FontSize        = 8
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .Themes          = .F.
257:             .SpecialEffect   = 0
258:             .MousePointer    = 15
259:             .WordWrap        = .T.
260:         ENDWITH
261:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
262: 
263:         *-- Botao Alterar (Left=155)
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
266:             .Caption         = "Alterar"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 155
271:             .Width           = 75
272:             .Height          = 75
273:             .BackColor       = RGB(255, 255, 255)
274:             .ForeColor       = RGB(90, 90, 90)
275:             .FontName        = "Comic Sans MS"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:         ENDWITH
284:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
285: 
286:         *-- Botao Excluir (Left=230)
287:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
288:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
289:             .Caption         = "Excluir"
290:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
291:             .PicturePosition = 13
292:             .Top             = 5
293:             .Left            = 230
294:             .Width           = 75
295:             .Height          = 75
296:             .BackColor       = RGB(255, 255, 255)
297:             .ForeColor       = RGB(90, 90, 90)
298:             .FontName        = "Comic Sans MS"
299:             .FontSize        = 8
300:             .FontBold        = .T.
301:             .FontItalic      = .T.
302:             .Themes          = .F.
303:             .SpecialEffect   = 0
304:             .MousePointer    = 15
305:             .WordWrap        = .T.
306:         ENDWITH
307:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
308: 
309:         *-- Botao Buscar (Left=305)
310:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
311:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
312:             .Caption         = "Buscar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
314:             .PicturePosition = 13
315:             .Top             = 5
316:             .Left            = 305
317:             .Width           = 75
318:             .Height          = 75
319:             .BackColor       = RGB(255, 255, 255)
320:             .ForeColor       = RGB(90, 90, 90)
321:             .FontName        = "Comic Sans MS"
322:             .FontSize        = 8
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .Themes          = .F.
326:             .SpecialEffect   = 0
327:             .MousePointer    = 15
328:             .WordWrap        = .T.
329:         ENDWITH
330:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
331: 
332:         *-- Container saida canonico (CLAUDE.md regra #10 - Left=917, Width=90)
333:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
334:         WITH loc_oPagina.cnt_4c_Saida
335:             .Top         = 29
336:             .Left        = 917
337:             .Width       = 90
338:             .Height      = 85
339:             .BackStyle   = 0
340:             .BorderWidth = 0
341:             .Visible     = .T.
342:         ENDWITH
343: 
344:         *-- Botao Encerrar canonico (Left=5, Top=5, Width=75, Height=75, Caption="Encerrar")
345:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
346:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
347:             .Caption         = "Encerrar"
348:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
349:             .PicturePosition = 13
350:             .Top             = 5
351:             .Left            = 5
352:             .Width           = 75
353:             .Height          = 75
354:             .BackColor       = RGB(255, 255, 255)
355:             .ForeColor       = RGB(90, 90, 90)
356:             .FontName        = "Comic Sans MS"
357:             .FontSize        = 8
358:             .FontBold        = .T.
359:             .FontItalic      = .T.
360:             .Themes          = .F.
361:             .SpecialEffect   = 0
362:             .MousePointer    = 15
363:             .WordWrap        = .T.
364:         ENDWITH
365:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
366: 
367:         *-- Botao "Aguarde" visivel apenas durante carga do TmpCep
368:         *-- (btnAguarde no legado: Top=266, Left=338, Height=72, Width=322, Visible=.F.)
369:         loc_oPagina.AddObject("cmd_4c_BtnAguarde", "CommandButton")
370:         WITH loc_oPagina.cmd_4c_BtnAguarde
371:             .Top           = 295
372:             .Left          = 338
373:             .Width         = 322
374:             .Height        = 72
375:             .Caption       = "Aguarde!  Atualizando  Tabela de Cidades . . ."
376:             .FontBold      = .T.
377:             .FontName      = "Tahoma"
378:             .FontSize      = 9
379:             .ForeColor     = RGB(90, 90, 90)
380:             .BackColor     = RGB(255, 255, 255)
381:             .SpecialEffect = 1
382:             .Themes        = .F.
383:             .Visible       = .F.
384:             .Enabled       = .F.
385:         ENDWITH
386: 
387:         *-- Grid da lista (grade no legado: Top=121, Left=12, Width=971, Height=470)
388:         *-- Compensacao PageFrame +29: Top=150; Width=970 para nao ultrapassar borda
389:         *-- RecordSource/ColumnCount definidos FORA do WITH (Problema 36)
390:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
391:         loc_oPagina.grd_4c_Lista.RecordSource = ""
392:         loc_oPagina.grd_4c_Lista.ColumnCount  = 2
393:         WITH loc_oPagina.grd_4c_Lista
394:             .Top                = 117
395:             .Left               = 12
396:             .Width              = 970
397:             .Height             = 470
398:             .DeleteMark         = .F.
399:             .RecordMark         = .F.
400:             .GridLines          = 3
401:             .RowHeight          = 16
402:             .ScrollBars         = 2
403:             .HighlightStyle     = 2
404:             .HighlightBackColor = RGB(255, 255, 255)
405:             .HighlightForeColor = RGB(15, 41, 104)

*-- Linhas 413 a 617:
413:             .Column2.Width           = 120
414:             .Column2.Alignment       = 1
415:         ENDWITH
416:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
417: 
418:         THIS.TornarControlesVisiveis(loc_oPagina)
419: 
420:         *-- Garantir BtnAguarde oculto apos TornarControlesVisiveis
421:         loc_oPagina.cmd_4c_BtnAguarde.Visible = .F.
422:     ENDPROC
423: 
424:     *===========================================================================
425:     * ConfigurarPaginaDados - Configura Page2 (Dados)
426:     * Grupo_Salva: Left=836, Top=-5, compensado +29 = 24
427:     * Campos fase5: lbl_4c_Cidade (Say7) + txt_4c_Cidade (GetCidade)
428:     * Campos fase6: lbl_4c_ValorFrete (Say2) + txt_4c_Frete (get_Frete)
429:     *===========================================================================
430:     PROTECTED PROCEDURE ConfigurarPaginaDados()
431:         LOCAL loc_oPagina
432:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
433: 
434:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
435:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
436: 
437:         *-- Container botoes Confirmar/Cancelar
438:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
439:         WITH loc_oPagina.cnt_4c_BotoesAcao
440:             .Top         = 24
441:             .Left        = 836
442:             .Width       = 161
443:             .Height      = 85
444:             .BackStyle   = 0
445:             .BorderWidth = 0
446:             .Visible     = .T.
447:         ENDWITH
448: 
449:         *-- Botao Confirmar (Grupo_Salva.Salva: Top=5, Left=5)
450:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
451:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
452:             .Caption         = "Confirmar"
453:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
454:             .PicturePosition = 13
455:             .Top             = 5
456:             .Left            = 5
457:             .Width           = 75
458:             .Height          = 75
459:             .BackColor       = RGB(255, 255, 255)
460:             .ForeColor       = RGB(90, 90, 90)
461:             .FontName        = "Comic Sans MS"
462:             .FontSize        = 8
463:             .FontBold        = .T.
464:             .FontItalic      = .T.
465:             .Themes          = .F.
466:             .SpecialEffect   = 0
467:             .MousePointer    = 15
468:             .WordWrap        = .T.
469:         ENDWITH
470:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
471: 
472:         *-- Botao Cancelar (Grupo_Salva.Cancelar: Top=5, Left=81)
473:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
474:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
475:             .Caption         = "Encerrar"
476:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
477:             .PicturePosition = 13
478:             .Top             = 5
479:             .Left            = 81
480:             .Width           = 75
481:             .Height          = 75
482:             .BackColor       = RGB(255, 255, 255)
483:             .ForeColor       = RGB(90, 90, 90)
484:             .FontName        = "Comic Sans MS"
485:             .FontSize        = 8
486:             .FontBold        = .T.
487:             .FontItalic      = .T.
488:             .Themes          = .F.
489:             .SpecialEffect   = 0
490:             .MousePointer    = 15
491:             .WordWrap        = .T.
492:         ENDWITH
493:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
494: 
495:         *-- Label Cidade (Say7: Top=148, Left=314, compensado +29 = 177)
496:         loc_oPagina.AddObject("lbl_4c_Cidade", "Label")
497:         WITH loc_oPagina.lbl_4c_Cidade
498:             .Caption   = "Cidade :"
499:             .Top       = 177
500:             .Left      = 314
501:             .Width     = 55
502:             .Height    = 17
503:             .FontName  = "Tahoma"
504:             .FontSize  = 8
505:             .ForeColor = RGB(90, 90, 90)
506:             .BackStyle = 0
507:             .AutoSize  = .F.
508:             .Visible   = .T.
509:         ENDWITH
510: 
511:         *-- TextBox Cidade (GetCidade: Top=145, Left=359, Width=220, compensado +29 = 174)
512:         *-- ControlSource legado: crSigCdFrt.cidas | Format="K!" (uppercase)
513:         loc_oPagina.AddObject("txt_4c_Cidade", "TextBox")
514:         WITH loc_oPagina.txt_4c_Cidade
515:             .Value         = ""
516:             .Top           = 174
517:             .Left          = 359
518:             .Width         = 220
519:             .Height        = 25
520:             .MaxLength     = 30
521:             .SpecialEffect = 1
522:             .FontName      = "Tahoma"
523:             .FontSize      = 8
524:             .ForeColor     = RGB(0, 0, 0)
525:             .BackColor     = RGB(255, 255, 255)
526:             .Themes        = .F.
527:             .ReadOnly      = .F.
528:             .Visible       = .T.
529:         ENDWITH
530:         BINDEVENT(loc_oPagina.txt_4c_Cidade, "KeyPress", THIS, "ValidarCidade")
531: 
532:         *-- Label Valor do Frete (Say2: Top=176, Left=279, Height=15, Width=77, compensado +29 = 205)
533:         loc_oPagina.AddObject("lbl_4c_ValorFrete", "Label")
534:         WITH loc_oPagina.lbl_4c_ValorFrete
535:             .Caption   = "Valor do Frete :"
536:             .Top       = 205
537:             .Left      = 279
538:             .Width     = 77
539:             .Height    = 15
540:             .FontName  = "Tahoma"
541:             .FontSize  = 8
542:             .ForeColor = RGB(90, 90, 90)
543:             .BackStyle = 0
544:             .AutoSize  = .F.
545:             .Visible   = .T.
546:         ENDWITH
547: 
548:         *-- TextBox Valor do Frete (get_Frete: Top=171+29=200, Left=359, Width=100, Height=25)
549:         *-- Habilitado apenas em INCLUIR e ALTERAR (get_Frete.When do legado)
550:         loc_oPagina.AddObject("txt_4c_Frete", "TextBox")
551:         WITH loc_oPagina.txt_4c_Frete
552:             .Value         = 0
553:             .Top           = 200
554:             .Left          = 359
555:             .Width         = 100
556:             .Height        = 25
557:             .InputMask     = "999,999.99"
558:             .MaxLength     = 10
559:             .SpecialEffect = 1
560:             .FontName      = "Tahoma"
561:             .FontSize      = 8
562:             .ForeColor     = RGB(0, 0, 0)
563:             .BackColor     = RGB(255, 255, 255)
564:             .Themes        = .F.
565:             .ReadOnly      = .F.
566:             .Visible       = .T.
567:         ENDWITH
568: 
569:         THIS.TornarControlesVisiveis(loc_oPagina)
570:     ENDPROC
571: 
572:     *===========================================================================
573:     * CarregarTmpCep - Carrega cursor TmpCep com cidades do banco de dados
574:     * Substitui: poDataMg2.SqlExecute + CREATE CURSOR TmpCep do legado
575:     * Exibir btnAguarde durante carga (fidelidade UX ao legado)
576:     *===========================================================================
577:     PROTECTED PROCEDURE CarregarTmpCep()
578:         LOCAL loc_nResult, loc_oPagina
579: 
580:         TRY
581:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
582: 
583:             IF USED("TmpCep")
584:                 USE IN TmpCep
585:             ENDIF
586: 
587:             *-- Exibir indicador de progresso (equivalente ao btnAguarde do legado)
588:             IF VARTYPE(loc_oPagina) = "O" AND ;
589:                PEMSTATUS(loc_oPagina, "cmd_4c_BtnAguarde", 5)
590:                 loc_oPagina.cmd_4c_BtnAguarde.Visible = .T.
591:                 THIS.Refresh()
592:             ENDIF
593: 
594:             *-- Tentar carregar cidades do banco Cep
595:             SET NULL ON
596:             CREATE CURSOR TmpCep (Cidades C(30))
597:             SET NULL OFF
598: 
599:             loc_nResult = SQLEXEC(gnConnHandle, ;
600:                 "SELECT DISTINCT Cidades FROM Cep ORDER BY Cidades", ;
601:                 "cursor_4c_TmpCepLoad")
602: 
603:             IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpCepLoad") > 0
604:                 SELECT cursor_4c_TmpCepLoad
605:                 SCAN
606:                     INSERT INTO TmpCep VALUES (ALLTRIM(cursor_4c_TmpCepLoad.Cidades))
607:                 ENDSCAN
608:             ENDIF
609: 
610:             IF USED("cursor_4c_TmpCepLoad")
611:                 USE IN cursor_4c_TmpCepLoad
612:             ENDIF
613: 
614:             *-- Indexar para busca rapida no lookup de GetCidade
615:             IF USED("TmpCep") AND RECCOUNT("TmpCep") > 0
616:                 SELECT TmpCep
617:                 INDEX ON Cidades TAG Cidades

*-- Linhas 637 a 1155:
637:     *===========================================================================
638:     * CarregarLista - Carrega dados no grid da Page1 via FreBO.Buscar()
639:     *===========================================================================
640:     PROCEDURE CarregarLista()
641:         LOCAL loc_lResultado, loc_oGrid
642:         loc_lResultado = .F.
643: 
644:         TRY
645:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
646:                 loc_lResultado = .T.
647:             ELSE
648:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
649:                     IF THIS.this_oBusinessObject.Buscar("")
650:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
651:                         loc_oGrid.ColumnCount = 2
652:                         loc_oGrid.RecordSource          = "cursor_4c_Dados"
653:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
654:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
655:                         *-- Redefinir headers apos RecordSource (auto-bind os sobrescreve)
656:                         loc_oGrid.Column1.Header1.Caption = "Cidade"
657:                         loc_oGrid.Column1.Width           = 400
658:                         loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
659:                         loc_oGrid.Column2.Width           = 120
660:                         loc_oGrid.Column2.Alignment       = 1
661:                         THIS.FormatarGridLista(loc_oGrid)
662:                         loc_lResultado = .T.
663:                     ENDIF
664:                 ENDIF
665:             ENDIF
666:         CATCH TO loException
667:             MostrarErro(loException, "FormFre.CarregarLista")
668:         ENDTRY
669: 
670:         RETURN loc_lResultado
671:     ENDPROC
672: 
673:     *===========================================================================
674:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
675:     *===========================================================================
676:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
677:         LOCAL loc_nI, loc_oObjeto, loc_nP
678:         FOR loc_nI = 1 TO par_oContainer.ControlCount
679:             loc_oObjeto = par_oContainer.Controls(loc_nI)
680:             IF VARTYPE(loc_oObjeto) = "O"
681:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
682:                     loc_oObjeto.Visible = .T.
683:                 ENDIF
684:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
685:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
686:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
687:                     ENDFOR
688:                 ENDIF
689:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
690:                     THIS.TornarControlesVisiveis(loc_oObjeto)
691:                 ENDIF
692:             ENDIF
693:         ENDFOR
694:     ENDPROC
695: 
696:     *===========================================================================
697:     * FormatarGridLista - Formata visual do grid (fonte Verdana, igual ao legado)
698:     *===========================================================================
699:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
700:         WITH par_oGrid
701:             .FontName = "Verdana"
702:             .FontSize = 8
703:         ENDWITH
704:     ENDPROC
705: 
706:     *===========================================================================
707:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
708:     *===========================================================================
709:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
710:         LOCAL loc_lResultado
711:         loc_lResultado = .F.
712: 
713:         TRY
714:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
715:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
716:                 IF par_nPagina = 1
717:                     THIS.this_cModoAtual = "LISTA"
718:                     THIS.CarregarLista()
719:                 ENDIF
720:                 loc_lResultado = .T.
721:             ENDIF
722:         CATCH TO loException
723:             MostrarErro(loException, "FormFre.AlternarPagina")
724:         ENDTRY
725: 
726:         RETURN loc_lResultado
727:     ENDPROC
728: 
729:     *===========================================================================
730:     * FormParaBO - Transfere valores dos campos do Form para as propriedades do BO
731:     *===========================================================================
732:     PROTECTED PROCEDURE FormParaBO()
733:         LOCAL loc_oPag2
734:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
735: 
736:         TRY
737:             THIS.this_oBusinessObject.this_cCidade = ALLTRIM(loc_oPag2.txt_4c_Cidade.Value)
738:             THIS.this_oBusinessObject.this_nFrete  = loc_oPag2.txt_4c_Frete.Value
739:         CATCH TO loException
740:             MostrarErro(loException, "FormFre.FormParaBO")
741:         ENDTRY
742:     ENDPROC
743: 
744:     *===========================================================================
745:     * BOParaForm - Transfere propriedades do BO para os campos do Form
746:     *===========================================================================
747:     PROTECTED PROCEDURE BOParaForm()
748:         LOCAL loc_oPag2
749:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
750: 
751:         TRY
752:             loc_oPag2.txt_4c_Cidade.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCidade)
753:             loc_oPag2.txt_4c_Frete.Value  = THIS.this_oBusinessObject.this_nFrete
754:         CATCH TO loException
755:             MostrarErro(loException, "FormFre.BOParaForm")
756:         ENDTRY
757:     ENDPROC
758: 
759:     *===========================================================================
760:     * LimparCampos - Limpa todos os campos editaveis da Page2
761:     *===========================================================================
762:     PROTECTED PROCEDURE LimparCampos()
763:         LOCAL loc_oPag2
764:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
765: 
766:         TRY
767:             loc_oPag2.txt_4c_Cidade.Value = ""
768:             loc_oPag2.txt_4c_Frete.Value  = 0
769:         CATCH TO loException
770:             MostrarErro(loException, "FormFre.LimparCampos")
771:         ENDTRY
772:     ENDPROC
773: 
774:     *===========================================================================
775:     * HabilitarCampos - Habilita/desabilita campos conforme o modo atual
776:     *   Cidade:  editavel apenas em INCLUIR (e PK, nao altera em ALTERAR)
777:     *   Frete:   editavel em INCLUIR e ALTERAR (nao em VISUALIZAR)
778:     *   Confirmar: sempre habilitado (age como navegacao em VISUALIZAR)
779:     *===========================================================================
780:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
781:         LOCAL loc_oPag2, loc_lHabFrete
782:         loc_oPag2     = THIS.pgf_4c_Paginas.Page2
783:         loc_lHabFrete = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
784: 
785:         TRY
786:             IF PEMSTATUS(loc_oPag2, "txt_4c_Cidade", 5)
787:                 *-- Cidade editavel apenas em INCLUIR (e PK nao pode ser alterada)
788:                 loc_oPag2.txt_4c_Cidade.ReadOnly = (THIS.this_cModoAtual != "INCLUIR")
789:             ENDIF
790: 
791:             IF PEMSTATUS(loc_oPag2, "txt_4c_Frete", 5)
792:                 *-- Frete editavel em INCLUIR e ALTERAR, somente leitura em VISUALIZAR
793:                 loc_oPag2.txt_4c_Frete.ReadOnly = !loc_lHabFrete
794:             ENDIF
795: 
796:             IF PEMSTATUS(loc_oPag2, "cnt_4c_BotoesAcao", 5)
797:                 IF PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
798:                     *-- Confirmar sempre habilitado (em VISUALIZAR navega de volta para lista)
799:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
800:                 ENDIF
801:                 IF PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
802:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
803:                 ENDIF
804:             ENDIF
805:         CATCH TO loException
806:             MostrarErro(loException, "FormFre.HabilitarCampos")
807:         ENDTRY
808:     ENDPROC
809: 
810:     *===========================================================================
811:     * AjustarBotoesPorModo - Ajusta caption/estado dos botoes de acao conforme modo
812:     *   INCLUIR/ALTERAR: Confirmar = "Confirmar" (salva)
813:     *   VISUALIZAR:      Confirmar = "OK" (apenas navega de volta)
814:     *===========================================================================
815:     PROTECTED PROCEDURE AjustarBotoesPorModo()
816:         LOCAL loc_oPag2
817:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
818: 
819:         TRY
820:             IF PEMSTATUS(loc_oPag2, "cnt_4c_BotoesAcao", 5) AND ;
821:                PEMSTATUS(loc_oPag2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
822:                 IF THIS.this_cModoAtual = "VISUALIZAR"
823:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "OK"
824:                 ELSE
825:                     loc_oPag2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Caption = "Confirmar"
826:                 ENDIF
827:             ENDIF
828:         CATCH TO loException
829:             MostrarErro(loException, "FormFre.AjustarBotoesPorModo")
830:         ENDTRY
831:     ENDPROC
832: 
833:     *===========================================================================
834:     * BtnIncluirClick - Prepara form para incluir novo registro
835:     * Legado: pcEscolha='INSERIR', GetCidade.SetFocus
836:     *===========================================================================
837:     PROCEDURE BtnIncluirClick()
838:         TRY
839:             THIS.this_oBusinessObject.NovoRegistro()
840:             IF PEMSTATUS(THIS, "LimparCampos", 5)
841:                 THIS.LimparCampos()
842:             ENDIF
843:             THIS.this_cModoAtual = "INCLUIR"
844:             IF PEMSTATUS(THIS, "HabilitarCampos", 5)
845:                 THIS.HabilitarCampos(.T.)
846:             ENDIF
847:             IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
848:                 THIS.AjustarBotoesPorModo()
849:             ENDIF
850:             THIS.pgf_4c_Paginas.ActivePage = 2
851:             *-- Foco no campo Cidade (legado: GetCidade.SetFocus no INSERIR)
852:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Cidade", 5)
853:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Cidade.SetFocus()
854:             ENDIF
855:         CATCH TO loException
856:             MostrarErro(loException, "FormFre.BtnIncluirClick")
857:         ENDTRY
858:     ENDPROC
859: 
860:     *===========================================================================
861:     * BtnVisualizarClick - Carrega registro selecionado em modo somente leitura
862:     * Legado: pcEscolha='PROCURAR', Grupo_salva.Salva.setfocus
863:     *===========================================================================
864:     PROCEDURE BtnVisualizarClick()
865:         LOCAL loc_cCodigo
866:         loc_cCodigo = ""
867: 
868:         TRY
869:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
870:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
871:             ELSE
872:                 SELECT cursor_4c_Dados
873:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidas)
874: 
875:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
876:                     THIS.this_cModoAtual = "VISUALIZAR"
877:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
878:                         THIS.BOParaForm()
879:                     ENDIF
880:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
881:                         THIS.HabilitarCampos(.F.)
882:                     ENDIF
883:                     IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
884:                         THIS.AjustarBotoesPorModo()
885:                     ENDIF
886:                     THIS.pgf_4c_Paginas.ActivePage = 2
887:                     *-- Foco no botao Confirmar (legado: Grupo_salva.Salva.setfocus)
888:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5) AND ;
889:                        PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
890:                         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
891:                     ENDIF
892:                 ENDIF
893:             ENDIF
894:         CATCH TO loException
895:             MostrarErro(loException, "FormFre.BtnVisualizarClick")
896:         ENDTRY
897:     ENDPROC
898: 
899:     *===========================================================================
900:     * BtnAlterarClick - Carrega registro selecionado para alteracao
901:     * Legado: pcEscolha='ALTERAR', Get_Frete.SetFocus
902:     *===========================================================================
903:     PROCEDURE BtnAlterarClick()
904:         LOCAL loc_cCodigo
905:         loc_cCodigo = ""
906: 
907:         TRY
908:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
909:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
910:             ELSE
911:                 SELECT cursor_4c_Dados
912:                 loc_cCodigo = ALLTRIM(cursor_4c_Dados.cidas)
913: 
914:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
915:                     THIS.this_oBusinessObject.EditarRegistro()
916:                     THIS.this_cModoAtual = "ALTERAR"
917:                     IF PEMSTATUS(THIS, "BOParaForm", 5)
918:                         THIS.BOParaForm()
919:                     ENDIF
920:                     IF PEMSTATUS(THIS, "HabilitarCampos", 5)
921:                         THIS.HabilitarCampos(.T.)
922:                     ENDIF
923:                     IF PEMSTATUS(THIS, "AjustarBotoesPorModo", 5)
924:                         THIS.AjustarBotoesPorModo()
925:                     ENDIF
926:                     THIS.pgf_4c_Paginas.ActivePage = 2
927:                     *-- Foco no campo Frete (legado: Get_Frete.SetFocus no ALTERAR)
928:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Frete", 5)
929:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Frete.SetFocus()
930:                     ENDIF
931:                 ENDIF
932:             ENDIF
933:         CATCH TO loException
934:             MostrarErro(loException, "FormFre.BtnAlterarClick")
935:         ENDTRY
936:     ENDPROC
937: 
938:     *===========================================================================
939:     * BtnExcluirClick - Confirma e exclui registro selecionado
940:     *===========================================================================
941:     PROCEDURE BtnExcluirClick()
942:         LOCAL loc_cCodigo, loc_cCidade
943:         loc_cCodigo = ""
944:         loc_cCidade = ""
945: 
946:         TRY
947:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
948:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
949:             ELSE
950:                 SELECT cursor_4c_Dados
951:                 loc_cCidade = ALLTRIM(cursor_4c_Dados.cidas)
952:                 loc_cCodigo = loc_cCidade
953: 
954:                 IF MsgConfirma("Excluir o frete da cidade " + CHR(34) + loc_cCidade + CHR(34) + "?", ;
955:                     "Confirmar Exclus" + CHR(227) + "o")
956:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
957:                         IF THIS.this_oBusinessObject.Excluir()
958:                             MsgInfo("Frete exclu" + CHR(237) + "do com sucesso.", "Sucesso")
959:                             THIS.CarregarLista()
960:                         ENDIF
961:                     ENDIF
962:                 ENDIF
963:             ENDIF
964:         CATCH TO loException
965:             MostrarErro(loException, "FormFre.BtnExcluirClick")
966:         ENDTRY
967:     ENDPROC
968: 
969:     *===========================================================================
970:     * BtnBuscarClick - Filtra registros por cidade (INPUTBOX simples)
971:     * Legado: poDataMgr.AddCursor com filtro em Cidas
972:     *===========================================================================
973:     PROCEDURE BtnBuscarClick()
974:         LOCAL loc_cFiltro, loc_oGrid
975:         loc_cFiltro = ""
976: 
977:         TRY
978:             loc_cFiltro = ALLTRIM(INPUTBOX("Buscar cidade:", "Busca de Fretes", ""))
979:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
980:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
981:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
982:                     loc_oGrid.ColumnCount = 2
983:                     loc_oGrid.RecordSource          = "cursor_4c_Dados"
984:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cidas"
985:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.valors"
986:                     *-- Redefinir headers apos RecordSource
987:                     loc_oGrid.Column1.Header1.Caption = "Cidade"
988:                     loc_oGrid.Column1.Width           = 400
989:                     loc_oGrid.Column2.Header1.Caption = "Valor do Frete"
990:                     loc_oGrid.Column2.Width           = 120
991:                     loc_oGrid.Column2.Alignment       = 1
992:                     THIS.FormatarGridLista(loc_oGrid)
993:                 ENDIF
994:             ENDIF
995:         CATCH TO loException
996:             MostrarErro(loException, "FormFre.BtnBuscarClick")
997:         ENDTRY
998:     ENDPROC
999: 
1000:     *===========================================================================
1001:     * BtnEncerrarClick - Fecha o formulario
1002:     * Legado (Destroy): reabilita this_oParentForm.Enabled = .T.
1003:     *===========================================================================
1004:     PROCEDURE BtnEncerrarClick()
1005:         TRY
1006:             THIS.Release()
1007:         CATCH TO loException
1008:             MostrarErro(loException, "FormFre.BtnEncerrarClick")
1009:         ENDTRY
1010:     ENDPROC
1011: 
1012:     *===========================================================================
1013:     * Destroy - Libera recursos e reabilita form pai
1014:     *===========================================================================
1015:     PROCEDURE Destroy()
1016:         TRY
1017:             *-- Reabilitar form pai (PROCEDURE Release do legado: oForm.Enabled = .T.)
1018:             IF VARTYPE(THIS.this_oParentForm) = "O"
1019:                 THIS.this_oParentForm.Enabled = .T.
1020:                 THIS.this_oParentForm         = .NULL.
1021:             ENDIF
1022: 
1023:             *-- Liberar BO
1024:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1025:                 THIS.this_oBusinessObject = .NULL.
1026:             ENDIF
1027: 
1028:             *-- Liberar cursor TmpCep (criado no CarregarTmpCep)
1029:             IF USED("TmpCep")
1030:                 USE IN TmpCep
1031:             ENDIF
1032: 
1033:         CATCH TO loException
1034:             MostrarErro(loException, "FormFre.Destroy")
1035:         ENDTRY
1036: 
1037:         DODEFAULT()
1038:     ENDPROC
1039: 
1040:     *===========================================================================
1041:     * ValidarCidade - Abre picker de cidades ao sair do campo txt_4c_Cidade
1042:     * Legado: GetCidade.Valid - fwBuscaSel em TmpCep cursor local
1043:     *===========================================================================
1044:     PROCEDURE ValidarCidade(par_nKeyCode, par_nShiftAltCtrl)
1045:         LOCAL loc_cCidade, loc_oBusca, loc_oPag2
1046:         loc_cCidade = ""
1047:         loc_oPag2   = THIS.pgf_4c_Paginas.Page2
1048: 
1049:         TRY
1050:             IF !PEMSTATUS(loc_oPag2, "txt_4c_Cidade", 5)
1051:                 RETURN
1052:             ENDIF
1053: 
1054:             loc_cCidade = ALLTRIM(loc_oPag2.txt_4c_Cidade.Value)
1055: 
1056:             IF EMPTY(loc_cCidade) OR !USED("TmpCep") OR RECCOUNT("TmpCep") = 0
1057:                 RETURN
1058:             ENDIF
1059: 
1060:             *-- Lookup em TmpCep pre-carregado (FormBuscaAuxiliar Modo 2 - cursor local)
1061:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1062:             IF VARTYPE(loc_oBusca) = "O"
1063:                 loc_oBusca.this_cCursorDestino = "TmpCep"
1064:                 loc_oBusca.this_cTitulo        = "Cadastro de Cidades"
1065:                 loc_oBusca.mAddColuna("Cidades", "", "Cidade")
1066:                 loc_oBusca.Show()
1067: 
1068:                 IF loc_oBusca.this_lSelecionou AND USED("TmpCep")
1069:                     loc_oPag2.txt_4c_Cidade.Value = ALLTRIM(TmpCep.Cidades)
1070:                 ENDIF
1071:                 loc_oBusca.Release()
1072:             ENDIF
1073:         CATCH TO loException
1074:             MostrarErro(loException, "FormFre.ValidarCidade")
1075:         ENDTRY
1076:     ENDPROC
1077: 
1078:     *===========================================================================
1079:     * BtnSalvarClick - Valida e salva o registro (INCLUIR/ALTERAR)
1080:     * Legado: Grupo_Salva.Salva.Click
1081:     *   - INSERIR: valida Cidade obrigatoria; valida Frete>0 (modo global)
1082:     *   - ALTERAR: valida Frete>0 (modo global)
1083:     *   - VISUALIZAR: apenas volta para lista
1084:     *===========================================================================
1085:     PROCEDURE BtnSalvarClick()
1086:         LOCAL loc_oPag2, loc_cCidade, loc_nFrete, loc_lSalvou
1087:         loc_cCidade = ""
1088:         loc_nFrete  = 0
1089:         loc_lSalvou = .F.
1090: 
1091:         *-- VISUALIZAR: apenas retornar para lista sem salvar
1092:         IF THIS.this_cModoAtual = "VISUALIZAR"
1093:             THIS.AlternarPagina(1)
1094:             RETURN
1095:         ENDIF
1096: 
1097:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1098:             RETURN
1099:         ENDIF
1100: 
1101:         loc_oPag2 = THIS.pgf_4c_Paginas.Page2
1102: 
1103:         *-- Validacoes antes do TRY (CLAUDE.md Problema 16)
1104:         *-- INCLUIR: Cidade e obrigatoria
1105:         IF THIS.this_cModoAtual = "INCLUIR" AND PEMSTATUS(loc_oPag2, "txt_4c_Cidade", 5)
1106:             loc_cCidade = ALLTRIM(loc_oPag2.txt_4c_Cidade.Value)
1107:             IF EMPTY(loc_cCidade)
1108:                 MsgAviso("Cidade Inv" + CHR(225) + "lida!!!", ;
1109:                     "Aten" + CHR(231) + CHR(227) + "o")
1110:                 loc_oPag2.txt_4c_Cidade.SetFocus()
1111:                 RETURN
1112:             ENDIF
1113:         ENDIF
1114: 
1115:         *-- Frete obrigatorio em modo global (pDopes vazio)
1116:         IF PEMSTATUS(loc_oPag2, "txt_4c_Frete", 5)
1117:             loc_nFrete = loc_oPag2.txt_4c_Frete.Value
1118:         ENDIF
1119:         IF EMPTY(THIS.this_oBusinessObject.this_cDopes) AND loc_nFrete <= 0
1120:             MsgAviso("Valor do Frete Inv" + CHR(225) + "lido.", ;
1121:                 "Aten" + CHR(231) + CHR(227) + "o")
1122:             IF PEMSTATUS(loc_oPag2, "txt_4c_Frete", 5)
1123:                 loc_oPag2.txt_4c_Frete.SetFocus()
1124:             ENDIF
1125:             RETURN
1126:         ENDIF
1127: 
1128:         TRY
1129:             THIS.FormParaBO()
1130:             loc_lSalvou = THIS.this_oBusinessObject.Salvar()
1131:             IF loc_lSalvou
1132:                 MsgInfo("Frete salvo com sucesso.", "Sucesso")
1133:                 THIS.CarregarLista()
1134:                 THIS.AlternarPagina(1)
1135:             ENDIF
1136:         CATCH TO loException
1137:             MostrarErro(loException, "FormFre.BtnSalvarClick")
1138:         ENDTRY
1139:     ENDPROC
1140: 
1141:     *===========================================================================
1142:     * BtnCancelarClick - Cancela edicao e retorna para lista
1143:     * Legado: Grupo_Salva.Cancelar.Click -> DoDefault() + mAtivapagina1
1144:     *===========================================================================
1145:     PROCEDURE BtnCancelarClick()
1146:         TRY
1147:             THIS.this_cModoAtual = "LISTA"
1148:             THIS.CarregarLista()
1149:             THIS.AlternarPagina(1)
1150:         CATCH TO loException
1151:             MostrarErro(loException, "FormFre.BtnCancelarClick")
1152:         ENDTRY
1153:     ENDPROC
1154: 
1155: ENDDEFINE


### BO (C:\4c\projeto\app\classes\FreBO.prg):
*==============================================================================
* FreBO.prg - Business Object: Fretes por Cidade
*==============================================================================
* Tabelas:
*   SigCdFrt  - modo global (this_cDopes vazio): PK = cidas
*   SigOpFrt  - modo operacional (this_cDopes preenchido): chave composta cidas+dopes
*==============================================================================

DEFINE CLASS FreBO AS BusinessBase

    *-- Campos compartilhados (SigCdFrt e SigOpFrt)
    this_cCidade     = ""   && cidas       CHAR(30)       - nome da cidade
    this_nFrete      = 0    && valors      NUMERIC(11,2)  - valor do frete

    *-- Campos exclusivos modo operacional (SigOpFrt)
    this_cDopes      = ""   && dopes       CHAR(20)       - tipo de operacao (vazio = modo global)

    *===========================================================================
    * Init - Inicializa BO no modo global (SigCdFrt / PK = cidas)
    *        Para modo operacional: setar this_cDopes apos Init()
    *===========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFrt"
            THIS.this_cCampoChave = "cidas"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "FreBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *===========================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *   Ambos os modos: cidas (cidade)
    *===========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidade)
    ENDFUNC

    *===========================================================================
    * Buscar - Lista registros no cursor cursor_4c_Dados
    *   par_cFiltro: filtro opcional em cidas (LIKE)
    *===========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: SigCdFrt
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                        " WHERE cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ELSE
                *-- Modo operacional: SigOpFrt filtrado por dopes
                IF EMPTY(par_cFiltro)
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " ORDER BY cidas"
                ELSE
                    loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                        " WHERE dopes = " + EscaparSQL(THIS.this_cDopes) + ;
                        " AND cidas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                        " ORDER BY cidas"
                ENDIF
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar fretes:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarPorCodigo - Carrega registro por cidas no cursor cursor_4c_Carrega
    *   Modo global:      WHERE cidas = par_cCodigo
    *   Modo operacional: WHERE cidas = par_cCodigo AND dopes = this_cDopes
    *===========================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "SELECT cidas, valors FROM SigCdFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo)
            ELSE
                loc_cSQL = "SELECT cidas, dopes, valors FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(par_cCodigo) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *===========================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidade = TratarNulo(cidas, "C")
                THIS.this_nFrete  = TratarNulo(valors, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Inserir - INSERT em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: INSERT em SigCdFrt
                loc_cSQL = "INSERT INTO SigCdFrt (cidas, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ELSE
                *-- Modo operacional: INSERT em SigOpFrt com chave composta cidas+dopes
                loc_cSQL = "INSERT INTO SigOpFrt (cidas, dopes, valors) VALUES (" + ;
                    EscaparSQL(THIS.this_cCidade) + ", " + ;
                    EscaparSQL(THIS.this_cDopes) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nFrete) + ")"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * Atualizar - UPDATE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                *-- Modo global: UPDATE SigCdFrt por cidas (PK nao alteravel, so valors)
                loc_cSQL = "UPDATE SigCdFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                *-- Modo operacional: UPDATE SigOpFrt pela chave composta cidas+dopes
                loc_cSQL = "UPDATE SigOpFrt SET" + ;
                    " valors = " + FormatarNumeroSQL(THIS.this_nFrete) + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *===========================================================================
    * ExecutarExclusao - DELETE em SigCdFrt (global) ou SigOpFrt (operacional) [PROTECTED]
    *===========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cDopes)
                loc_cSQL = "DELETE FROM SigCdFrt WHERE cidas = " + EscaparSQL(THIS.this_cCidade)
            ELSE
                loc_cSQL = "DELETE FROM SigOpFrt" + ;
                    " WHERE cidas = " + EscaparSQL(THIS.this_cCidade) + ;
                    " AND dopes = " + EscaparSQL(THIS.this_cDopes)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir frete:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FreBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

