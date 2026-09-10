# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTml.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2262 linhas total):

*-- Linhas 23 a 166:
23: 
24:     *-- Guardas anti-repeticao para LostFocus (Problema 45: LostFocus dispara
25:     *-- sempre, ao contrario de Valid que so dispara quando o valor muda)
26:     this_cUltimoGrupo  = ""
27:     this_cUltimaConta  = ""
28: 
29:     *===========================================================================
30:     * Init - Inicializa o formulario
31:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
32:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
33:     *===========================================================================
34:     PROCEDURE Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *===========================================================================
39:     * InicializarForm - Configura estrutura completa
40:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
41:     *===========================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             THIS.this_oBusinessObject = CREATEOBJECT("TmlBO")
48: 
49:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
50:                 MostrarErro("Erro ao criar TmlBO" + CHR(13) + ;
51:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
52:                     "FormTml.InicializarForm")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Visible = .T.
60:                 THIS.pgf_4c_Paginas.ActivePage = 1
61:                 THIS.this_cModoAtual = "LISTA"
62: 
63:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
64:                     IF PEMSTATUS(THIS, "CarregarLista", 5)
65:                         THIS.CarregarLista()
66:                     ENDIF
67:                 ENDIF
68: 
69:                 loc_lSucesso = .T.
70:             ENDIF
71: 
72:         CATCH TO loException
73:             MostrarErro("Erro ao inicializar FormTml:" + CHR(13) + ;
74:                 loException.Message + CHR(13) + ;
75:                 "Linha: " + TRANSFORM(loException.LineNo), ;
76:                 "FormTml.InicializarForm")
77:         ENDTRY
78: 
79:         RETURN loc_lSucesso
80:     ENDPROC
81: 
82:     *===========================================================================
83:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
84:     * Top=-29 para esconder abas; controles compensam +29 no Top
85:     *===========================================================================
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page1.BackColor = RGB(255, 255, 255)
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()
108:         THIS.ConfigurarPaginaDados()
109:     ENDPROC
110: 
111:     *===========================================================================
112:     * ConfigurarPaginaLista - Page1: cabecalho + botoes CRUD (Grupo_op/Grupo_Saida
113:     * no legado) + Grid de listagem
114:     *===========================================================================
115:     PROTECTED PROCEDURE ConfigurarPaginaLista()
116:         LOCAL loc_oPagina
117:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
118: 
119:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina
122:         *-- Original: Top=1. Com compensacao +29: Top=31
123:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
124:         WITH loc_oPagina.cnt_4c_Cabecalho
125:             .Top         = 31
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackColor   = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:             .Caption   = THIS.Caption
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = 769
140:             .Height    = 40
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(0, 0, 0)
145:             .BackStyle = 0
146:             .AutoSize  = .F.
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:             .Caption   = THIS.Caption
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = 769
156:             .Height    = 46
157:             .FontName  = "Tahoma"
158:             .FontSize  = 16
159:             .FontBold  = .T.
160:             .ForeColor = RGB(255, 255, 255)
161:             .BackStyle = 0
162:             .AutoSize  = .F.
163:             .Visible   = .T.
164:         ENDWITH
165: 
166:         *-- Container Botoes CRUD (Grupo_op no legado: Left=339, Top=-1, Width=389, Height=85)

*-- Linhas 199 a 417:
199:             .AutoSize        = .F.
200:             .Visible         = .T.
201:         ENDWITH
202:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
203: 
204:         *-- Botao Visualizar (legado: Consultar, Left=81)
205:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
206:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
207:             .Caption         = "Visualizar"
208:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
209:             .PicturePosition = 13
210:             .Top             = 5
211:             .Left            = 80
212:             .Width           = 75
213:             .Height          = 75
214:             .FontName        = "Tahoma"
215:             .FontBold        = .T.
216:             .FontItalic      = .T.
217:             .FontSize        = 8
218:             .ForeColor       = RGB(90, 90, 90)
219:             .BackColor       = RGB(255, 255, 255)
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .MousePointer    = 15
223:             .WordWrap        = .T.
224:             .AutoSize        = .F.
225:             .Visible         = .T.
226:         ENDWITH
227:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
228: 
229:         *-- Botao Alterar (legado: Alterar, Left=157)
230:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
231:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
232:             .Caption         = "Alterar"
233:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
234:             .PicturePosition = 13
235:             .Top             = 5
236:             .Left            = 155
237:             .Width           = 75
238:             .Height          = 75
239:             .FontName        = "Tahoma"
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .FontSize        = 8
243:             .ForeColor       = RGB(90, 90, 90)
244:             .BackColor       = RGB(255, 255, 255)
245:             .Themes          = .F.
246:             .SpecialEffect   = 0
247:             .MousePointer    = 15
248:             .WordWrap        = .T.
249:             .AutoSize        = .F.
250:             .Visible         = .T.
251:         ENDWITH
252:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
253: 
254:         *-- Botao Excluir (legado: Excluir, Left=233)
255:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
256:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
257:             .Caption         = "Excluir"
258:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
259:             .PicturePosition = 13
260:             .Top             = 5
261:             .Left            = 230
262:             .Width           = 75
263:             .Height          = 75
264:             .FontName        = "Tahoma"
265:             .FontBold        = .T.
266:             .FontItalic      = .T.
267:             .FontSize        = 8
268:             .ForeColor       = RGB(90, 90, 90)
269:             .BackColor       = RGB(255, 255, 255)
270:             .Themes          = .F.
271:             .SpecialEffect   = 0
272:             .MousePointer    = 15
273:             .WordWrap        = .T.
274:             .AutoSize        = .F.
275:             .Visible         = .T.
276:         ENDWITH
277:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
278: 
279:         *-- Botao Buscar (legado: procurar, Left=309)
280:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
281:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
282:             .Caption         = "Buscar"
283:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
284:             .PicturePosition = 13
285:             .Top             = 5
286:             .Left            = 305
287:             .Width           = 75
288:             .Height          = 75
289:             .FontName        = "Tahoma"
290:             .FontBold        = .T.
291:             .FontItalic      = .T.
292:             .FontSize        = 8
293:             .ForeColor       = RGB(90, 90, 90)
294:             .BackColor       = RGB(255, 255, 255)
295:             .Themes          = .F.
296:             .SpecialEffect   = 0
297:             .MousePointer    = 15
298:             .WordWrap        = .T.
299:             .AutoSize        = .F.
300:             .Visible         = .T.
301:         ENDWITH
302:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
303: 
304:         *-- Container Saida - PADRAO CANONICO (prevalece sobre legado: Grupo_Saida.Left=719, Top=-1)
305:         *-- CLAUDE.md regra #10: Left=917, Top=29, Width=90, Height=85
306:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
307:         WITH loc_oPagina.cnt_4c_Saida
308:             .Top         = 29
309:             .Left        = 917
310:             .Width       = 90
311:             .Height      = 85
312:             .BackStyle   = 0
313:             .BorderWidth = 0
314:             .Visible     = .T.
315:         ENDWITH
316: 
317:         *-- Botao Encerrar (legado: Sair) - PADRAO CANONICO: Caption="Encerrar", Width=75, Height=75
318:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .FontName        = "Tahoma"
328:             .FontBold        = .T.
329:             .FontItalic      = .T.
330:             .FontSize        = 8
331:             .ForeColor       = RGB(90, 90, 90)
332:             .BackColor       = RGB(255, 255, 255)
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .MousePointer    = 15
336:             .WordWrap        = .T.
337:             .AutoSize        = .F.
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid de listagem (legado: Grade Top=121, Left=11, FontName=Tahoma, FontSize=8)
343:         *-- Canonico framework: Top=117 (88+29 compensacao), Left=26, Width=880, Height=498
344:         *-- Width=880: nao sobrepoe cnt_4c_Saida (Left=917), margem de 11px
345:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
346:         *-- ColumnCount FORA do WITH (Problema 36: dentro do WITH nao cria colunas imediatamente)
347:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
348:         WITH loc_oPagina.grd_4c_Lista
349:             .Top                = 117
350:             .Left               = 26
351:             .Width              = 880
352:             .Height             = 498
353:             .FontName           = "Tahoma"
354:             .FontSize           = 8
355:             .ForeColor          = RGB(90, 90, 90)
356:             .BackColor          = RGB(255, 255, 255)
357:             .GridLineColor      = RGB(238, 238, 238)
358:             .HighlightBackColor = RGB(255, 255, 255)
359:             .HighlightForeColor = RGB(15, 41, 104)
360:             .HighlightStyle     = 2
361:             .DeleteMark         = .F.
362:             .RecordMark         = .F.
363:             .RowHeight          = 16
364:             .ScrollBars         = 2
365:             .GridLines          = 3
366:             .Visible            = .T.
367:         ENDWITH
368:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
369: 
370:         THIS.TornarControlesVisiveis(loc_oPagina)
371:     ENDPROC
372: 
373:     *===========================================================================
374:     * ConfigurarPaginaDados - Page2: cabecalho + container de botoes de acao
375:     * (Campos de dados: Fases 5-6; botoes Confirmar/Cancelar: Fase 4)
376:     *===========================================================================
377:     PROTECTED PROCEDURE ConfigurarPaginaDados()
378:         LOCAL loc_oPagina
379:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
380: 
381:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
382: 
383:         *-- Cabecalho cinza (identico ao da pagina Lista) - PRIMEIRO AddObject da pagina
384:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
385:         WITH loc_oPagina.cnt_4c_Cabecalho
386:             .Top           = 29
387:             .Left          = 0
388:             .Width         = THIS.Width
389:             .Height        = 80
390:             .BackColor     = RGB(100, 100, 100)
391:             .BorderWidth   = 0
392:             .SpecialEffect = 0
393:             .Visible       = .T.
394: 
395:             .AddObject("lbl_4c_Sombra", "Label")
396:             WITH .lbl_4c_Sombra
397:                 .Caption   = THIS.Caption
398:                 .Top       = 15
399:                 .Left      = 10
400:                 .Width     = THIS.Width
401:                 .Height    = 40
402:                 .FontName  = "Tahoma"
403:                 .FontSize  = 16
404:                 .FontBold  = .T.
405:                 .ForeColor = RGB(0, 0, 0)
406:                 .BackStyle = 0
407:                 .AutoSize  = .F.
408:                 .Visible   = .T.
409:             ENDWITH
410: 
411:             .AddObject("lbl_4c_Titulo", "Label")
412:             WITH .lbl_4c_Titulo
413:                 .Caption   = THIS.Caption
414:                 .Top       = 18
415:                 .Left      = 10
416:                 .Width     = THIS.Width
417:                 .Height    = 46

*-- Linhas 462 a 555:
462:             .AutoSize        = .F.
463:             .Visible         = .T.
464:         ENDWITH
465:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
466: 
467:         *-- Botao Cancelar (legado: Cancelar, Left=80)
468:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
469:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
470:             .Caption         = "Encerrar"
471:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
472:             .PicturePosition = 13
473:             .Top             = 5
474:             .Left            = 80
475:             .Width           = 75
476:             .Height          = 75
477:             .FontName        = "Tahoma"
478:             .FontBold        = .T.
479:             .FontItalic      = .T.
480:             .FontSize        = 8
481:             .ForeColor       = RGB(90, 90, 90)
482:             .BackColor       = RGB(255, 255, 255)
483:             .Themes          = .F.
484:             .SpecialEffect   = 0
485:             .MousePointer    = 15
486:             .WordWrap        = .T.
487:             .AutoSize        = .F.
488:             .Visible         = .T.
489:         ENDWITH
490:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
491: 
492:         *===========================================================================
493:         * CAMPOS DA PAGINA DADOS (FASE 5/8 - Primeira metade)
494:         * Compensacao PageFrame.Top=-29: Top_migrado = Top_original + 29
495:         * Ordem: Situacao, Codigo, Descricao, Falha Admitida, P/Q, Indice
496:         * Produtividade, Grupo, Conta, Tipo Acabamento
497:         *===========================================================================
498: 
499:         *-- Say19 "Situacao :" (Top=150+29=179, Left=331)
500:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
501:         WITH loc_oPagina.lbl_4c_Label19
502:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o : "
503:             .Top       = 179
504:             .Left      = 331
505:             .AutoSize  = .T.
506:             .BackStyle = 0
507:             .FontName  = "Tahoma"
508:             .FontSize  = 8
509:             .ForeColor = RGB(90, 90, 90)
510:             .Visible   = .T.
511:         ENDWITH
512: 
513:         *-- Opc_situacao (OptionGroup: Ativo/Inativo/Falhas-Perdas) - crSigOpOpt.Situas -> this_nSituas
514:         *-- Original: Left=389 Top=144 Width=213 Height=28 (compensado Top=173)
515:         loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
516:         WITH loc_oPagina.obj_4c_Opc_situacao
517:             .ButtonCount = 3
518:             .Top         = 173
519:             .Left        = 389
520:             .Width       = 223
521:             .Height      = 28
522:             .BackStyle   = 0
523:             .BorderStyle = 0
524:             .Value       = 1
525:             .Visible     = .T.
526:         ENDWITH
527:         WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(1)
528:             .Caption   = "Ativ\<o"
529:             .BackStyle = 0
530:             .Left      = 5
531:             .Top       = 5
532:             .AutoSize  = .T.
533:             .FontName  = "Tahoma"
534:             .FontSize  = 8
535:             .ForeColor = RGB(90, 90, 90)
536:             .Themes    = .F.
537:         ENDWITH
538:         WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(2)
539:             .Caption   = "I\<nativo"
540:             .BackStyle = 0
541:             .Left      = 54
542:             .Top       = 5
543:             .Width     = 60
544:             .AutoSize  = .F.
545:             .FontName  = "Tahoma"
546:             .FontSize  = 8
547:             .ForeColor = RGB(90, 90, 90)
548:             .Themes    = .F.
549:         ENDWITH
550:         WITH loc_oPagina.obj_4c_Opc_situacao.Buttons(3)
551:             .Caption   = "Falhas/Perdas"
552:             .Left      = 114
553:             .Top       = 6
554:             .Width     = 99
555:             .Height    = 15

*-- Linhas 1124 a 1253:
1124:         ENDWITH
1125: 
1126:         *===========================================================================
1127:         * LOOKUPS (FASE 6/8) - BINDEVENT de KeyPress para todos os campos com
1128:         * lookup no legado (fAcessoContab/fAcessoContas/fwBuscaExt)
1129:         *===========================================================================
1130: 
1131:         *-- Grupo (SigCdGcr): txt_4c_Grupo=codigo, txt_4c_G=descricao (reversa)
1132:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
1133:         BINDEVENT(loc_oPagina.txt_4c_G,     "KeyPress", THIS, "GrupoDescKeyPress")
1134: 
1135:         *-- Conta (SigCdCli, com controle de acesso fAcessoContas filtrado por Grupo):
1136:         *-- txt_4c_Contas=codigo, txt_4c_C=descricao (reversa)
1137:         BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ContaKeyPress")
1138:         BINDEVENT(loc_oPagina.txt_4c_C,      "KeyPress", THIS, "ContaDescKeyPress")
1139: 
1140:         *-- Tipo de Acabamento (SigCdAca): txt_4c__codacb=codigo, txt_4c__Dacb=descricao (readonly)
1141:         *-- Habilitado apenas quando Grupo estiver preenchido (When do legado)
1142:         BINDEVENT(loc_oPagina.txt_4c__codacb, "KeyPress", THIS, "CodAcbKeyPress")
1143:         loc_oPagina.txt_4c__codacb.Enabled = !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
1144: 
1145:         *-- Empresa Padrao (SigCdEmp): txt_4c_EmpPad
1146:         BINDEVENT(loc_oPagina.txt_4c_EmpPad, "KeyPress", THIS, "EmpPadKeyPress")
1147: 
1148:         THIS.TornarControlesVisiveis(loc_oPagina)
1149:     ENDPROC
1150: 
1151:     *===========================================================================
1152:     * LOOKUPS DE GRUPO (SigCdGcr) - txt_4c_Grupo (codigo) + txt_4c_G (descricao)
1153:     * Legado: Get_Grupos.Valid chamava fAcessoContab(Usuar,'C',valor,cod,desc).
1154:     * fAcessoContab tem bug de UX conhecido (auto-carrega 1o registro sem
1155:     * selecao explicita quando o SEEK falha parcialmente - mesma familia do
1156:     * bug documentado para fAcessoContas). Substituido por SQL exato +
1157:     * FormBuscaAuxiliar, no padrao consolidado em FormBch.prg (Erro155).
1158:     *===========================================================================
1159:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1160:         IF THIS.this_cModoAtual = "VISUALIZAR"
1161:             RETURN
1162:         ENDIF
1163:         DO CASE
1164:             CASE par_nKeyCode = 115
1165:                 THIS.AbrirLookupGrupo()
1166:             CASE INLIST(par_nKeyCode, 13, 9)
1167:                 THIS.ValidarGrupo()
1168:         ENDCASE
1169:     ENDPROC
1170: 
1171:     PROTECTED PROCEDURE ValidarGrupo()
1172:         LOCAL loc_oPagina, loc_cCodigo, loc_nResultado
1173:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1174:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1175: 
1176:         IF EMPTY(loc_cCodigo)
1177:             loc_oPagina.txt_4c_G.Value = ""
1178:             loc_oPagina.txt_4c__codacb.Enabled = .F.
1179:             RETURN
1180:         ENDIF
1181: 
1182:         TRY
1183:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1184:                 "SELECT codigos, descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(loc_cCodigo), ;
1185:                 "cursor_4c_ChkGcr")
1186: 
1187:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
1188:                 SELECT cursor_4c_ChkGcr
1189:                 loc_oPagina.txt_4c_G.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
1190:                 loc_oPagina.txt_4c__codacb.Enabled = .T.
1191:             ELSE
1192:                 loc_oPagina.txt_4c_G.Value = ""
1193:                 THIS.AbrirLookupGrupo()
1194:             ENDIF
1195: 
1196:             IF USED("cursor_4c_ChkGcr")
1197:                 USE IN cursor_4c_ChkGcr
1198:             ENDIF
1199:         CATCH TO loException
1200:             MsgErro("Erro ao validar grupo:" + CHR(13) + loException.Message, "Erro")
1201:             IF USED("cursor_4c_ChkGcr")
1202:                 USE IN cursor_4c_ChkGcr
1203:             ENDIF
1204:         ENDTRY
1205:     ENDPROC
1206: 
1207:     PROTECTED PROCEDURE AbrirLookupGrupo()
1208:         LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
1209:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1210:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1211: 
1212:         TRY
1213:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1214:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", loc_cCodigo, "Grupo")
1215: 
1216:             IF VARTYPE(loc_oBusca) = "O"
1217:                 *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
1218:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
1219:                         AND USED("cursor_4c_BuscaGcr")
1220:                     SELECT cursor_4c_BuscaGcr
1221:                     loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1222:                     loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1223:                     loc_oPagina.txt_4c__codacb.Enabled = .T.
1224:                 ELSE
1225:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1226:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1227:                     loc_oBusca.Show()
1228: 
1229:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1230:                         SELECT cursor_4c_BuscaGcr
1231:                         IF !EOF("cursor_4c_BuscaGcr")
1232:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1233:                             loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1234:                             loc_oPagina.txt_4c__codacb.Enabled = .T.
1235:                         ELSE
1236:                             loc_oPagina.txt_4c_Grupo.Value = ""
1237:                             loc_oPagina.txt_4c_G.Value     = ""
1238:                             loc_oPagina.txt_4c__codacb.Enabled = .F.
1239:                         ENDIF
1240:                     ELSE
1241:                         loc_oPagina.txt_4c_Grupo.Value = ""
1242:                         loc_oPagina.txt_4c_G.Value     = ""
1243:                         loc_oPagina.txt_4c__codacb.Enabled = .F.
1244:                     ENDIF
1245:                 ENDIF
1246: 
1247:                 loc_oBusca.Release()
1248:             ENDIF
1249: 
1250:             IF USED("cursor_4c_BuscaGcr")
1251:                 USE IN cursor_4c_BuscaGcr
1252:             ENDIF
1253:         CATCH TO loException

*-- Linhas 1260 a 1648:
1260: 
1261:     *-- Busca reversa por descricao (txt_4c_G) - ativa apenas quando Grupo vazio
1262:     *-- (legado: Get_G.When = IsEmpty(get_grupos.Value) AND INSERIR/ALTERAR)
1263:     PROCEDURE GrupoDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1264:         LOCAL loc_oPagina
1265:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1266: 
1267:         IF THIS.this_cModoAtual = "VISUALIZAR"
1268:             RETURN
1269:         ENDIF
1270: 
1271:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
1272:             RETURN
1273:         ENDIF
1274: 
1275:         IF INLIST(par_nKeyCode, 13, 9, 115)
1276:             THIS.ValidarGrupoDesc()
1277:         ENDIF
1278:     ENDPROC
1279: 
1280:     PROTECTED PROCEDURE ValidarGrupoDesc()
1281:         LOCAL loc_oPagina, loc_oBusca
1282:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1283: 
1284:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_G.Value))
1285:             RETURN
1286:         ENDIF
1287: 
1288:         TRY
1289:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1290:                 "SigCdGcr", "cursor_4c_BuscaGcr", "codigos", "", "Grupo")
1291: 
1292:             IF VARTYPE(loc_oBusca) = "O"
1293:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1294:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1295:                 loc_oBusca.Show()
1296: 
1297:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
1298:                     SELECT cursor_4c_BuscaGcr
1299:                     IF !EOF("cursor_4c_BuscaGcr")
1300:                         loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGcr.codigos)
1301:                         loc_oPagina.txt_4c_G.Value     = ALLTRIM(cursor_4c_BuscaGcr.descrs)
1302:                         loc_oPagina.txt_4c__codacb.Enabled = .T.
1303:                     ELSE
1304:                         loc_oPagina.txt_4c_G.Value = ""
1305:                     ENDIF
1306:                 ELSE
1307:                     loc_oPagina.txt_4c_G.Value = ""
1308:                 ENDIF
1309: 
1310:                 loc_oBusca.Release()
1311:             ENDIF
1312: 
1313:             IF USED("cursor_4c_BuscaGcr")
1314:                 USE IN cursor_4c_BuscaGcr
1315:             ENDIF
1316:         CATCH TO loException
1317:             MsgErro("Erro ao localizar grupo:" + CHR(13) + loException.Message, "Erro")
1318:             IF USED("cursor_4c_BuscaGcr")
1319:                 USE IN cursor_4c_BuscaGcr
1320:             ENDIF
1321:         ENDTRY
1322:     ENDPROC
1323: 
1324:     *===========================================================================
1325:     * LOOKUPS DE CONTA (SigCdCli) - txt_4c_Contas (codigo) + txt_4c_C (descricao)
1326:     * Legado: Get_Contas.Valid / Get_C.Valid chamavam
1327:     * fAcessoContas(Usuar, Grupo, 'C'/'D', valor, cod, desc). Mantido: o GRUPO
1328:     * faz parte da regra de ACESSO (fAcessoContas cruza SigSyAgc/SigSyAcc com
1329:     * SigCdAcG para decidir quais contas o usuario enxerga naquele grupo) -
1330:     * excecao consciente da regra "fAcessoContas proibido em lookup UX", que
1331:     * se aplica a autocomplete puro sem filtro de acesso. Mesmo padrao de
1332:     * FormBch.prg (Erro155).
1333:     *===========================================================================
1334:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1335:         IF THIS.this_cModoAtual = "VISUALIZAR"
1336:             RETURN
1337:         ENDIF
1338:         IF INLIST(par_nKeyCode, 13, 9, 115)
1339:             THIS.ValidarConta()
1340:         ENDIF
1341:     ENDPROC
1342: 
1343:     PROTECTED PROCEDURE ValidarConta()
1344:         LOCAL loc_oPagina, loc_cCodigo, loc_cGrupo
1345:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1346:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1347: 
1348:         IF EMPTY(loc_cCodigo)
1349:             loc_oPagina.txt_4c_C.Value = ""
1350:             RETURN
1351:         ENDIF
1352: 
1353:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1354: 
1355:         TRY
1356:             IF !fAcessoContas(Usuar, loc_cGrupo, "C", loc_cCodigo, ;
1357:                               loc_oPagina.txt_4c_Contas, loc_oPagina.txt_4c_C)
1358:                 MsgAviso("Acesso Negado !!", "")
1359:                 loc_oPagina.txt_4c_Contas.Value = ""
1360:                 loc_oPagina.txt_4c_C.Value      = ""
1361:             ENDIF
1362:         CATCH TO loException
1363:             MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
1364:         ENDTRY
1365:     ENDPROC
1366: 
1367:     *-- Busca reversa por descricao (txt_4c_C) - ativa apenas quando Conta vazia
1368:     *-- (legado: Get_C.When = IsEmpty(get_Contas.Value) AND INSERIR/ALTERAR)
1369:     PROCEDURE ContaDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1370:         LOCAL loc_oPagina
1371:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1372: 
1373:         IF THIS.this_cModoAtual = "VISUALIZAR"
1374:             RETURN
1375:         ENDIF
1376: 
1377:         IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Contas.Value))
1378:             RETURN
1379:         ENDIF
1380: 
1381:         IF INLIST(par_nKeyCode, 13, 9, 115)
1382:             THIS.ValidarContaDesc()
1383:         ENDIF
1384:     ENDPROC
1385: 
1386:     PROTECTED PROCEDURE ValidarContaDesc()
1387:         LOCAL loc_oPagina, loc_cDesc, loc_cGrupo
1388:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1389:         loc_cDesc   = ALLTRIM(loc_oPagina.txt_4c_C.Value)
1390: 
1391:         IF EMPTY(loc_cDesc)
1392:             loc_oPagina.txt_4c_Contas.Value = ""
1393:             RETURN
1394:         ENDIF
1395: 
1396:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1397: 
1398:         TRY
1399:             IF !fAcessoContas(Usuar, loc_cGrupo, "D", loc_cDesc, ;
1400:                               loc_oPagina.txt_4c_Contas, loc_oPagina.txt_4c_C)
1401:                 MsgAviso("Acesso Negado !!", "")
1402:                 loc_oPagina.txt_4c_C.Value      = ""
1403:                 loc_oPagina.txt_4c_Contas.Value = ""
1404:             ENDIF
1405:         CATCH TO loException
1406:             MsgErro("Erro ao validar conta:" + CHR(13) + loException.Message, "Erro")
1407:         ENDTRY
1408:     ENDPROC
1409: 
1410:     *===========================================================================
1411:     * LOOKUP DE TIPO DE ACABAMENTO (SigCdAca) - txt_4c__codacb (codigo) +
1412:     * txt_4c__Dacb (descricao, readonly). Legado: get_codacb.Valid usava
1413:     * CreateObject('fwBuscaExt', ..., 'SigCdAca', ..., 'Cods', ...).
1414:     *===========================================================================
1415:     PROCEDURE CodAcbKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1416:         IF THIS.this_cModoAtual = "VISUALIZAR"
1417:             RETURN
1418:         ENDIF
1419:         DO CASE
1420:             CASE par_nKeyCode = 115
1421:                 THIS.AbrirLookupCodAcb()
1422:             CASE INLIST(par_nKeyCode, 13, 9)
1423:                 THIS.ValidarCodAcb()
1424:         ENDCASE
1425:     ENDPROC
1426: 
1427:     PROTECTED PROCEDURE ValidarCodAcb()
1428:         LOCAL loc_oPagina, loc_cCodigo, loc_nResultado
1429:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1430:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__codacb.Value)
1431: 
1432:         IF EMPTY(loc_cCodigo)
1433:             loc_oPagina.txt_4c__Dacb.Value = ""
1434:             RETURN
1435:         ENDIF
1436: 
1437:         TRY
1438:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1439:                 "SELECT cods, descrs FROM SigCdAca WHERE cods = " + EscaparSQL(loc_cCodigo), ;
1440:                 "cursor_4c_ChkAcb")
1441: 
1442:             IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkAcb") > 0
1443:                 SELECT cursor_4c_ChkAcb
1444:                 loc_oPagina.txt_4c__Dacb.Value = ALLTRIM(cursor_4c_ChkAcb.descrs)
1445:             ELSE
1446:                 loc_oPagina.txt_4c__Dacb.Value = ""
1447:                 THIS.AbrirLookupCodAcb()
1448:             ENDIF
1449: 
1450:             IF USED("cursor_4c_ChkAcb")
1451:                 USE IN cursor_4c_ChkAcb
1452:             ENDIF
1453:         CATCH TO loException
1454:             MsgErro("Erro ao validar tipo de acabamento:" + CHR(13) + loException.Message, "Erro")
1455:             IF USED("cursor_4c_ChkAcb")
1456:                 USE IN cursor_4c_ChkAcb
1457:             ENDIF
1458:         ENDTRY
1459:     ENDPROC
1460: 
1461:     PROTECTED PROCEDURE AbrirLookupCodAcb()
1462:         LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
1463:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1464:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c__codacb.Value)
1465: 
1466:         TRY
1467:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1468:                 "SigCdAca", "cursor_4c_BuscaAcb", "cods", loc_cCodigo, ;
1469:                 "Tipo de Acabamento")
1470: 
1471:             IF VARTYPE(loc_oBusca) = "O"
1472:                 *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
1473:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
1474:                         AND USED("cursor_4c_BuscaAcb")
1475:                     SELECT cursor_4c_BuscaAcb
1476:                     loc_oPagina.txt_4c__codacb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
1477:                     loc_oPagina.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
1478:                 ELSE
1479:                     loc_oBusca.mAddColuna("cods",   "", "C" + CHR(243) + "digo")
1480:                     loc_oBusca.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
1481:                     loc_oBusca.Show()
1482: 
1483:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaAcb")
1484:                         SELECT cursor_4c_BuscaAcb
1485:                         IF !EOF("cursor_4c_BuscaAcb")
1486:                             loc_oPagina.txt_4c__codacb.Value = ALLTRIM(cursor_4c_BuscaAcb.cods)
1487:                             loc_oPagina.txt_4c__Dacb.Value   = ALLTRIM(cursor_4c_BuscaAcb.descrs)
1488:                         ELSE
1489:                             loc_oPagina.txt_4c__codacb.Value = ""
1490:                             loc_oPagina.txt_4c__Dacb.Value   = ""
1491:                         ENDIF
1492:                     ELSE
1493:                         loc_oPagina.txt_4c__codacb.Value = ""
1494:                         loc_oPagina.txt_4c__Dacb.Value   = ""
1495:                     ENDIF
1496:                 ENDIF
1497: 
1498:                 loc_oBusca.Release()
1499:             ENDIF
1500: 
1501:             IF USED("cursor_4c_BuscaAcb")
1502:                 USE IN cursor_4c_BuscaAcb
1503:             ENDIF
1504:         CATCH TO loException
1505:             MsgErro("Erro ao abrir busca de tipo de acabamento:" + CHR(13) + loException.Message, "Erro")
1506:             IF USED("cursor_4c_BuscaAcb")
1507:                 USE IN cursor_4c_BuscaAcb
1508:             ENDIF
1509:         ENDTRY
1510:     ENDPROC
1511: 
1512:     *===========================================================================
1513:     * LOOKUP DE EMPRESA PADRAO (SigCdEmp) - txt_4c_EmpPad. Legado:
1514:     * Get_EmpPad.Valid usava CreateObject('fwBuscaExt', ..., 'SigCdEmp', ...,
1515:     * 'cEmps', ...).
1516:     *===========================================================================
1517:     PROCEDURE EmpPadKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1518:         IF THIS.this_cModoAtual = "VISUALIZAR"
1519:             RETURN
1520:         ENDIF
1521:         DO CASE
1522:             CASE par_nKeyCode = 115
1523:                 THIS.AbrirLookupEmpPad()
1524:             CASE INLIST(par_nKeyCode, 13, 9)
1525:                 THIS.ValidarEmpPad()
1526:         ENDCASE
1527:     ENDPROC
1528: 
1529:     PROTECTED PROCEDURE ValidarEmpPad()
1530:         LOCAL loc_oPagina, loc_cCodigo, loc_nResultado
1531:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1532:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)
1533: 
1534:         IF EMPTY(loc_cCodigo)
1535:             RETURN
1536:         ENDIF
1537: 
1538:         TRY
1539:             loc_nResultado = SQLEXEC(gnConnHandle, ;
1540:                 "SELECT cEmps FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cCodigo), ;
1541:                 "cursor_4c_ChkEmp")
1542: 
1543:             IF loc_nResultado < 0 OR RECCOUNT("cursor_4c_ChkEmp") = 0
1544:                 THIS.AbrirLookupEmpPad()
1545:             ENDIF
1546: 
1547:             IF USED("cursor_4c_ChkEmp")
1548:                 USE IN cursor_4c_ChkEmp
1549:             ENDIF
1550:         CATCH TO loException
1551:             MsgErro("Erro ao validar empresa:" + CHR(13) + loException.Message, "Erro")
1552:             IF USED("cursor_4c_ChkEmp")
1553:                 USE IN cursor_4c_ChkEmp
1554:             ENDIF
1555:         ENDTRY
1556:     ENDPROC
1557: 
1558:     PROTECTED PROCEDURE AbrirLookupEmpPad()
1559:         LOCAL loc_oPagina, loc_cCodigo, loc_oBusca
1560:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1561:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)
1562: 
1563:         TRY
1564:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1565:                 "SigCdEmp", "cursor_4c_BuscaEmp", "cEmps", loc_cCodigo, "Empresas")
1566: 
1567:             IF VARTYPE(loc_oBusca) = "O"
1568:                 *-- Init() ja fez a busca exata: se achou, usa direto sem exibir o grid
1569:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro ;
1570:                         AND USED("cursor_4c_BuscaEmp")
1571:                     SELECT cursor_4c_BuscaEmp
1572:                     loc_oPagina.txt_4c_EmpPad.Value = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1573:                 ELSE
1574:                     loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
1575:                     loc_oBusca.mAddColuna("Razas", "", "Descri" + CHR(231) + CHR(227) + "o")
1576:                     loc_oBusca.Show()
1577: 
1578:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
1579:                         SELECT cursor_4c_BuscaEmp
1580:                         loc_oPagina.txt_4c_EmpPad.Value = IIF(!EOF("cursor_4c_BuscaEmp"), ;
1581:                             ALLTRIM(cursor_4c_BuscaEmp.cEmps), "")
1582:                     ELSE
1583:                         loc_oPagina.txt_4c_EmpPad.Value = ""
1584:                     ENDIF
1585:                 ENDIF
1586: 
1587:                 loc_oBusca.Release()
1588:             ENDIF
1589: 
1590:             IF USED("cursor_4c_BuscaEmp")
1591:                 USE IN cursor_4c_BuscaEmp
1592:             ENDIF
1593:         CATCH TO loException
1594:             MsgErro("Erro ao abrir busca de empresa:" + CHR(13) + loException.Message, "Erro")
1595:             IF USED("cursor_4c_BuscaEmp")
1596:                 USE IN cursor_4c_BuscaEmp
1597:             ENDIF
1598:         ENDTRY
1599:     ENDPROC
1600: 
1601:     *===========================================================================
1602:     * CarregarLista - Carrega dados no grid da Page1
1603:     * OBRIGATORIO: Reconfigura ControlSource e Headers APOS RecordSource (Problema 2/48)
1604:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
1605:     * Colunas (legado SIGCDTML.Init): Cods(115), descs(270), pfalhas(80),
1606:     * Grupos(80), CodAcbs(40, invisivel no legado - .f. no pColuna)
1607:     *===========================================================================
1608:     PROCEDURE CarregarLista()
1609:         LOCAL loc_lResultado, loc_oGrid
1610:         loc_lResultado = .F.
1611: 
1612:         TRY
1613:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1614:                 loc_lResultado = .T.
1615:             ELSE
1616:                 IF !THIS.this_oBusinessObject.Buscar("")
1617:                     loc_lResultado = .F.
1618:                 ELSE
1619:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1620: 
1621:                     *-- PROBLEMA 48: RecordSource ANTES de ControlSource (FORA do WITH per Problema 36)
1622:                     loc_oGrid.ColumnCount = 5
1623:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1624: 
1625:                     *-- PROBLEMA 48: ControlSource APOS RecordSource (auto-bind seria sobrescrito)
1626:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
1627:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
1628:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.pfalhas"
1629:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.grupos"
1630:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.codacbs"
1631: 
1632:                     loc_oGrid.Column1.Width = 115
1633:                     loc_oGrid.Column2.Width = 270
1634:                     loc_oGrid.Column3.Width = 80
1635:                     loc_oGrid.Column4.Width = 80
1636:                     loc_oGrid.Column5.Width = 40
1637: 
1638:                     *-- Coluna CodAcbs eh invisivel no legado (pColuna(..., .f.))
1639:                     loc_oGrid.Column5.Visible = .F.
1640: 
1641:                     *-- PROBLEMA 2/32: Headers APOS RecordSource (OBRIGATORIO - RecordSource reseta captions)
1642:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1643:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1644:                     loc_oGrid.Column3.Header1.Caption = "Falha"
1645:                     loc_oGrid.Column4.Header1.Caption = "Grupo"
1646:                     loc_oGrid.Column5.Header1.Caption = "Acab."
1647: 
1648:                     THIS.FormatarGridLista(loc_oGrid)

*-- Linhas 1664 a 1814:
1664:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1665:     * Ao voltar para Page1, recarrega a lista
1666:     *===========================================================================
1667:     PROCEDURE AlternarPagina(par_nPagina)
1668:         LOCAL loc_lResultado
1669:         loc_lResultado = .F.
1670: 
1671:         TRY
1672:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1673:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
1674:             ELSE
1675:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1676: 
1677:                 IF par_nPagina = 1
1678:                     THIS.this_cModoAtual = "LISTA"
1679:                     THIS.CarregarLista()
1680:                 ENDIF
1681: 
1682:                 loc_lResultado = .T.
1683:             ENDIF
1684: 
1685:         CATCH TO loException
1686:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loException.Message, ;
1687:                 "FormTml.AlternarPagina")
1688:         ENDTRY
1689: 
1690:         RETURN loc_lResultado
1691:     ENDPROC
1692: 
1693:     *===========================================================================
1694:     * TornarControlesVisiveis - Torna visiveis, recursivamente, todos os
1695:     * controles de um container (Pages de PageFrames incluidas)
1696:     *===========================================================================
1697:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1698:         LOCAL loc_nI, loc_oObjeto, loc_nP
1699: 
1700:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1701:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1702: 
1703:             IF VARTYPE(loc_oObjeto) = "O"
1704:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1705:                     loc_oObjeto.Visible = .T.
1706:                 ENDIF
1707: 
1708:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1709:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1710:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1711:                     ENDFOR
1712:                 ENDIF
1713: 
1714:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1715:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1716:                 ENDIF
1717:             ENDIF
1718:         ENDFOR
1719:     ENDPROC
1720: 
1721:     *===========================================================================
1722:     * FormatarGridLista - Formata visual do grid da lista (fonte/tamanho)
1723:     *===========================================================================
1724:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1725:         TRY
1726:             WITH par_oGrid
1727:                 .FontName = "Tahoma"
1728:                 .FontSize = 8
1729:             ENDWITH
1730:         CATCH TO loException
1731:             MostrarErro("Erro ao formatar grid:" + CHR(13) + loException.Message, ;
1732:                 "FormTml.FormatarGridLista")
1733:         ENDTRY
1734:     ENDPROC
1735: 
1736:     *===========================================================================
1737:     * LimparCampos - Reseta todos os campos da Page2 para os valores default
1738:     *===========================================================================
1739:     PROCEDURE LimparCampos()
1740:         LOCAL loc_oPagina
1741:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1742: 
1743:         loc_oPagina.obj_4c_Opc_situacao.Value      = 1
1744:         loc_oPagina.txt_4c_Codigo.Value            = ""
1745:         loc_oPagina.txt_4c_Descricao.Value         = ""
1746:         loc_oPagina.txt_4c_Pfalhas.Value           = 0
1747:         loc_oPagina.txt_4c_Tfalhas.Value           = ""
1748:         loc_oPagina.txt_4c__IndProd.Value          = 0
1749:         loc_oPagina.txt_4c_Grupo.Value             = ""
1750:         loc_oPagina.txt_4c_G.Value                 = ""
1751:         loc_oPagina.txt_4c_Contas.Value            = ""
1752:         loc_oPagina.txt_4c_C.Value                 = ""
1753:         loc_oPagina.txt_4c__codacb.Value           = ""
1754:         loc_oPagina.txt_4c__Dacb.Value             = ""
1755:         loc_oPagina.txt_4c__codacb.Enabled         = .F.
1756:         loc_oPagina.txt_4c_EntSai.Value            = ""
1757:         loc_oPagina.txt_4c_AnProds.Value           = ""
1758:         loc_oPagina.txt_4c_Valor.Value             = 0
1759:         loc_oPagina.chk_4c_Chk_produzido.Value     = 0
1760:         loc_oPagina.chk_4c_Chk_trabalhado.Value    = 0
1761:         loc_oPagina.chk_4c_Chk_modelagem.Value     = 0
1762:         loc_oPagina.txt_4c_Dev.Value                = ""
1763:         loc_oPagina.txt_4c_EmpPad.Value             = ""
1764:         loc_oPagina.chk_4c_Chk_duplicidade.Value    = 0
1765:         loc_oPagina.chk_4c_Chk_retrabalho.Value     = 0
1766:     ENDPROC
1767: 
1768:     *===========================================================================
1769:     * BOParaForm - Transfere as propriedades do TmlBO para os campos da Page2
1770:     * As descricoes de Grupo/Conta/Tipo Acabamento sao buscadas diretamente por
1771:     * SQL (SEM abrir FormBuscaAuxiliar) para nao disparar picker ao carregar
1772:     * um registro ja existente.
1773:     *===========================================================================
1774:     PROCEDURE BOParaForm()
1775:         LOCAL loc_oPagina, loc_oBO, loc_nResultado
1776:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1777:         loc_oBO     = THIS.this_oBusinessObject
1778: 
1779:         TRY
1780:             loc_oPagina.obj_4c_Opc_situacao.Value = IIF(INLIST(loc_oBO.this_nSituas, 1, 2, 3), ;
1781:                 loc_oBO.this_nSituas, 1)
1782:             loc_oPagina.txt_4c_Codigo.Value       = loc_oBO.this_cCods
1783:             loc_oPagina.txt_4c_Descricao.Value    = loc_oBO.this_cDescs
1784:             loc_oPagina.txt_4c_Pfalhas.Value      = loc_oBO.this_nPfalhas
1785:             loc_oPagina.txt_4c_Tfalhas.Value      = loc_oBO.this_cTfalhas
1786:             loc_oPagina.txt_4c__IndProd.Value     = loc_oBO.this_nIndProds
1787:             loc_oPagina.txt_4c_Grupo.Value        = loc_oBO.this_cGrupos
1788:             loc_oPagina.txt_4c_Contas.Value       = loc_oBO.this_cContas
1789:             loc_oPagina.txt_4c__codacb.Value      = loc_oBO.this_cCodAcbs
1790:             loc_oPagina.txt_4c_EntSai.Value       = loc_oBO.this_cAnaEsGrps
1791:             loc_oPagina.txt_4c_AnProds.Value      = loc_oBO.this_cCtrlpds
1792:             loc_oPagina.txt_4c_Valor.Value        = loc_oBO.this_nValors
1793:             loc_oPagina.chk_4c_Chk_produzido.Value  = (loc_oBO.this_nProdzs .Value  = IIF(loc_oBO.this_nProdzs = 1, 1, 0))
1794:             loc_oPagina.chk_4c_Chk_trabalhado.Value = (loc_oBO.this_nTrabas .Value = IIF(loc_oBO.this_nTrabas = 1, 1, 0))
1795:             loc_oPagina.chk_4c_Chk_modelagem.Value  = (loc_oBO.this_nModels .Value  = IIF(loc_oBO.this_nModels = 1, 1, 0))
1796:             loc_oPagina.txt_4c_Dev.Value           = loc_oBO.this_cChkDevs
1797:             loc_oPagina.txt_4c_EmpPad.Value        = loc_oBO.this_cEmps
1798:             loc_oPagina.chk_4c_Chk_duplicidade.Value = (loc_oBO.this_nDupTpOps .Value = IIF(loc_oBO.this_nDupTpOps = 1, 1, 0))
1799:             loc_oPagina.chk_4c_Chk_retrabalho.Value  = (loc_oBO.this_nRetrab .Value  = IIF(loc_oBO.this_nRetrab = 1, 1, 0))
1800: 
1801:             *-- Descricao do Grupo (SigCdGcr.descrs) - somente consulta, sem abrir lookup
1802:             loc_oPagina.txt_4c_G.Value = ""
1803:             IF !EMPTY(ALLTRIM(loc_oBO.this_cGrupos))
1804:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1805:                     "SELECT descrs FROM SigCdGcr WHERE codigos = " + EscaparSQL(ALLTRIM(loc_oBO.this_cGrupos)), ;
1806:                     "cursor_4c_ChkGcr")
1807:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkGcr") > 0
1808:                     loc_oPagina.txt_4c_G.Value = ALLTRIM(cursor_4c_ChkGcr.descrs)
1809:                 ENDIF
1810:                 IF USED("cursor_4c_ChkGcr")
1811:                     USE IN cursor_4c_ChkGcr
1812:                 ENDIF
1813:             ENDIF
1814:             loc_oPagina.txt_4c__codacb.Enabled = !EMPTY(ALLTRIM(loc_oBO.this_cGrupos))

*-- Linhas 1850 a 2149:
1850:     * FormParaBO - Transfere os campos da Page2 para as propriedades do TmlBO
1851:     * (usado pelo BtnSalvarClick - Fase 8)
1852:     *===========================================================================
1853:     PROCEDURE FormParaBO()
1854:         LOCAL loc_oPagina, loc_oBO
1855:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1856:         loc_oBO     = THIS.this_oBusinessObject
1857: 
1858:         loc_oBO.this_nSituas    = loc_oPagina.obj_4c_Opc_situacao.Value
1859:         loc_oBO.this_cCods      = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
1860:         loc_oBO.this_cDescs     = ALLTRIM(loc_oPagina.txt_4c_Descricao.Value)
1861:         loc_oBO.this_nPfalhas   = loc_oPagina.txt_4c_Pfalhas.Value
1862:         loc_oBO.this_cTfalhas   = loc_oPagina.txt_4c_Tfalhas.Value
1863:         loc_oBO.this_nIndProds  = loc_oPagina.txt_4c__IndProd.Value
1864:         loc_oBO.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1865:         loc_oBO.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1866:         loc_oBO.this_cCodAcbs   = ALLTRIM(loc_oPagina.txt_4c__codacb.Value)
1867:         loc_oBO.this_cAnaEsGrps = loc_oPagina.txt_4c_EntSai.Value
1868:         loc_oBO.this_cCtrlpds   = loc_oPagina.txt_4c_AnProds.Value
1869:         loc_oBO.this_nValors    = loc_oPagina.txt_4c_Valor.Value
1870:         loc_oBO.this_nProdzs    = IIF(loc_oPagina.chk_4c_Chk_produzido.Value = 1, 1, 0)
1871:         loc_oBO.this_nTrabas    = IIF(loc_oPagina.chk_4c_Chk_trabalhado.Value = 1, 1, 0)
1872:         loc_oBO.this_nModels    = IIF(loc_oPagina.chk_4c_Chk_modelagem.Value = 1, 1, 0)
1873:         loc_oBO.this_cChkDevs   = loc_oPagina.txt_4c_Dev.Value
1874:         loc_oBO.this_cEmps      = ALLTRIM(loc_oPagina.txt_4c_EmpPad.Value)
1875:         loc_oBO.this_nDupTpOps  = IIF(loc_oPagina.chk_4c_Chk_duplicidade.Value = 1, 1, 0)
1876:         loc_oBO.this_nRetrab    = IIF(loc_oPagina.chk_4c_Chk_retrabalho.Value = 1, 1, 0)
1877:     ENDPROC
1878: 
1879:     *===========================================================================
1880:     * HabilitarCampos - Habilita/desabilita os campos da Page2
1881:     * Codigo (cods) so eh editavel em modo INCLUIR (legado: Get_Cods.When
1882:     * retorna INSERIR/PROCURAR)
1883:     *===========================================================================
1884:     PROCEDURE HabilitarCampos(par_lHabilitar)
1885:         LOCAL loc_oPagina, loc_lHab, loc_lCodEditavel
1886:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1887:         loc_lHab    = (par_lHabilitar = .T.)
1888:         loc_lCodEditavel = loc_lHab AND THIS.this_cModoAtual = "INCLUIR"
1889: 
1890:         loc_oPagina.txt_4c_Codigo.Enabled          = loc_lCodEditavel
1891:         loc_oPagina.txt_4c_Descricao.Enabled       = loc_lHab
1892:         loc_oPagina.obj_4c_Opc_situacao.Enabled    = loc_lHab
1893:         loc_oPagina.txt_4c_Pfalhas.Enabled         = loc_lHab
1894:         loc_oPagina.txt_4c_Tfalhas.Enabled         = loc_lHab
1895:         loc_oPagina.txt_4c__IndProd.Enabled        = loc_lHab
1896:         loc_oPagina.txt_4c_Grupo.Enabled           = loc_lHab
1897:         loc_oPagina.txt_4c_G.Enabled               = loc_lHab
1898:         loc_oPagina.txt_4c_Contas.Enabled          = loc_lHab
1899:         loc_oPagina.txt_4c_C.Enabled               = loc_lHab
1900:         loc_oPagina.txt_4c__codacb.Enabled         = loc_lHab AND !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
1901:         loc_oPagina.txt_4c_EntSai.Enabled          = loc_lHab
1902:         loc_oPagina.txt_4c_AnProds.Enabled         = loc_lHab
1903:         loc_oPagina.txt_4c_Valor.Enabled           = loc_lHab
1904:         loc_oPagina.chk_4c_Chk_produzido.Enabled   = loc_lHab
1905:         loc_oPagina.chk_4c_Chk_trabalhado.Enabled  = loc_lHab
1906:         loc_oPagina.chk_4c_Chk_modelagem.Enabled   = loc_lHab
1907:         loc_oPagina.txt_4c_Dev.Enabled             = loc_lHab
1908:         loc_oPagina.txt_4c_EmpPad.Enabled          = loc_lHab
1909:         loc_oPagina.chk_4c_Chk_duplicidade.Enabled = loc_lHab
1910:         loc_oPagina.chk_4c_Chk_retrabalho.Enabled  = loc_lHab
1911:     ENDPROC
1912: 
1913:     *===========================================================================
1914:     * AjustarBotoesPorModo - Ajusta Confirmar/Cancelar conforme this_cModoAtual
1915:     * VISUALIZAR: Confirmar desabilitado, Cancelar habilitado (padrao frmcadastro)
1916:     * Chamado diretamente por TesteAutomatico.prg - DEVE ser PUBLIC
1917:     *===========================================================================
1918:     PROCEDURE AjustarBotoesPorModo()
1919:         LOCAL loc_oBotoes
1920:         loc_oBotoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1921: 
1922:         DO CASE
1923:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1924:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .F.
1925:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
1926:             OTHERWISE
1927:                 loc_oBotoes.cmd_4c_Confirmar.Enabled = .T.
1928:                 loc_oBotoes.cmd_4c_Cancelar.Enabled  = .T.
1929:         ENDCASE
1930:     ENDPROC
1931: 
1932:     *===========================================================================
1933:     * BtnIncluirClick - Prepara o BO e o formulario para inclusao de novo
1934:     * registro e navega para a Page2 (Dados)
1935:     * Legado (SIGCDTML.Click com pcEscolha='INSERIR'): foco em Get_Cods
1936:     *===========================================================================
1937:     PROCEDURE BtnIncluirClick()
1938:         TRY
1939:             THIS.this_oBusinessObject.NovoRegistro()
1940:             THIS.LimparCampos()
1941:             THIS.this_cModoAtual = "INCLUIR"
1942:             THIS.HabilitarCampos(.T.)
1943:             THIS.AjustarBotoesPorModo()
1944:             THIS.AlternarPagina(2)
1945:             THIS.pgf_4c_Paginas.Page2.txt_4c_Codigo.SetFocus()
1946:         CATCH TO loException
1947:             MsgErro("Erro ao incluir registro:" + CHR(13) + loException.Message, "Erro")
1948:         ENDTRY
1949:     ENDPROC
1950: 
1951:     *===========================================================================
1952:     * BtnAlterarClick - Carrega o registro selecionado no grid, prepara o BO
1953:     * para edicao e navega para a Page2 (Dados)
1954:     * Legado (SIGCDTML.Click com pcEscolha='ALTERAR'): foco em Get_Descs
1955:     *===========================================================================
1956:     PROCEDURE BtnAlterarClick()
1957:         LOCAL loc_cCidchaves
1958:         TRY
1959:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1960:                 MsgAviso("Selecione um registro para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
1961:             ELSE
1962:                 SELECT cursor_4c_Dados
1963:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1964: 
1965:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1966:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.", "Erro")
1967:                 ELSE
1968:                     THIS.this_oBusinessObject.EditarRegistro()
1969:                     THIS.BOParaForm()
1970:                     THIS.this_cModoAtual = "ALTERAR"
1971:                     THIS.HabilitarCampos(.T.)
1972:                     THIS.AjustarBotoesPorModo()
1973:                     THIS.AlternarPagina(2)
1974:                     THIS.pgf_4c_Paginas.Page2.txt_4c_Descricao.SetFocus()
1975:                 ENDIF
1976:             ENDIF
1977:         CATCH TO loException
1978:             MsgErro("Erro ao alterar registro:" + CHR(13) + loException.Message, "Erro")
1979:         ENDTRY
1980:     ENDPROC
1981: 
1982:     *===========================================================================
1983:     * BtnVisualizarClick - Carrega o registro selecionado (somente leitura) e
1984:     * navega para a Page2 (Dados). Tambem vinculado ao DblClick do grid.
1985:     * Legado (SIGCDTML.Click com pcEscolha='CONSULTAR'): foco em Grupo_Salva.Salva
1986:     *===========================================================================
1987:     PROCEDURE BtnVisualizarClick()
1988:         LOCAL loc_cCidchaves
1989:         TRY
1990:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
1991:                 MsgAviso("Selecione um registro para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
1992:             ELSE
1993:                 SELECT cursor_4c_Dados
1994:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1995: 
1996:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
1997:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel carregar o registro selecionado.", "Erro")
1998:                 ELSE
1999:                     THIS.BOParaForm()
2000:                     THIS.this_cModoAtual = "VISUALIZAR"
2001:                     THIS.HabilitarCampos(.F.)
2002:                     THIS.AjustarBotoesPorModo()
2003:                     THIS.AlternarPagina(2)
2004:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus()
2005:                 ENDIF
2006:             ENDIF
2007:         CATCH TO loException
2008:             MsgErro("Erro ao visualizar registro:" + CHR(13) + loException.Message, "Erro")
2009:         ENDTRY
2010:     ENDPROC
2011: 
2012:     *===========================================================================
2013:     * BtnExcluirClick - Confirma e exclui o registro selecionado no grid
2014:     * (this_oBusinessObject.Excluir() eh PUBLIC e chama ExecutarExclusao()
2015:     * internamente - NUNCA chamar ExecutarExclusao() diretamente do Form)
2016:     *===========================================================================
2017:     PROCEDURE BtnExcluirClick()
2018:         LOCAL loc_cCidchaves, loc_cCodigo
2019:         TRY
2020:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")
2021:                 MsgAviso("Selecione um registro para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
2022:             ELSE
2023:                 SELECT cursor_4c_Dados
2024:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
2025:                 loc_cCodigo    = ALLTRIM(cursor_4c_Dados.cods)
2026: 
2027:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do tipo de material " + ;
2028:                         loc_cCodigo + " ?", "Confirma" + CHR(231) + CHR(227) + "o de Exclus" + CHR(227) + "o")
2029:                     IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
2030:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro para " + ;
2031:                             "exclus" + CHR(227) + "o.", "Erro")
2032:                     ELSE
2033:                         IF THIS.this_oBusinessObject.Excluir()
2034:                             MsgExcluidoSucesso()
2035:                             THIS.CarregarLista()
2036:                         ELSE
2037:                             MsgErro("Erro ao excluir registro:" + CHR(13) + ;
2038:                                 THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
2039:                         ENDIF
2040:                     ENDIF
2041:                 ENDIF
2042:             ENDIF
2043:         CATCH TO loException
2044:             MsgErro("Erro ao excluir registro:" + CHR(13) + loException.Message, "Erro")
2045:         ENDTRY
2046:     ENDPROC
2047: 
2048:     *===========================================================================
2049:     * BtnBuscarClick - Abre picker para localizar registro na lista
2050:     * Apos selecao, posiciona o cursor no registro encontrado (LOCATE em
2051:     * cursor_4c_Dados, sem nova consulta ao servidor)
2052:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2053:     *===========================================================================
2054:     PROCEDURE BtnBuscarClick()
2055:         LOCAL loc_oBusca, loc_cCodigo
2056:         loc_cCodigo = ""
2057: 
2058:         TRY
2059:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2060:                 "SigOpOpt", "cursor_4c_BuscaTml", "cods", "", ;
2061:                 "Buscar Tipo de Material")
2062: 
2063:             IF VARTYPE(loc_oBusca) = "O"
2064:                 loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
2065:                 loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
2066:                 loc_oBusca.Show()
2067: 
2068:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTml")
2069:                     SELECT cursor_4c_BuscaTml
2070:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaTml.cods)
2071:                 ENDIF
2072: 
2073:                 loc_oBusca.Release()
2074:             ENDIF
2075: 
2076:             IF USED("cursor_4c_BuscaTml")
2077:                 USE IN cursor_4c_BuscaTml
2078:             ENDIF
2079: 
2080:             IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2081:                 SELECT cursor_4c_Dados
2082:                 LOCATE FOR ALLTRIM(cods) == loc_cCodigo
2083:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2084:             ENDIF
2085: 
2086:         CATCH TO loException
2087:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, "FormTml.BtnBuscarClick")
2088:             IF USED("cursor_4c_BuscaTml")
2089:                 USE IN cursor_4c_BuscaTml
2090:             ENDIF
2091:         ENDTRY
2092:     ENDPROC
2093: 
2094:     *===========================================================================
2095:     * BtnEncerrarClick - Fecha o formulario
2096:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2097:     *===========================================================================
2098:     PROCEDURE BtnEncerrarClick()
2099:         THIS.Release()
2100:     ENDPROC
2101: 
2102:     *===========================================================================
2103:     * BtnSalvarClick - Valida e confirma o registro atual (Confirmar)
2104:     * Legado (SIGCDTML.Click, pcEscolha='INSERIR'): exige Get_Cods preenchido e
2105:     * verifica duplicidade via CursorQuery('SigOpOpt', ..., 'cods', ...) ANTES
2106:     * de gerar cIdChaves/gravar. Validacoes ficam FORA do TRY (Problema 16).
2107:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2108:     *===========================================================================
2109:     PROCEDURE BtnSalvarClick()
2110:         LOCAL loc_oPagina, loc_cCodigo, loc_nResultado, loc_lDuplicado, loc_lErroValidacao
2111: 
2112:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2113:             RETURN
2114:         ENDIF
2115: 
2116:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2117:         loc_cCodigo = ALLTRIM(loc_oPagina.txt_4c_Codigo.Value)
2118: 
2119:         *-- Validacao OBRIGATORIA (legado: IsEmpty(Get_Cods.Value))
2120:         IF EMPTY(loc_cCodigo)
2121:             MsgCampoObrigatorio("Tipo de Material")
2122:             loc_oPagina.txt_4c_Codigo.SetFocus()
2123:             RETURN
2124:         ENDIF
2125: 
2126:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Descricao.Value))
2127:             MsgCampoObrigatorio("Descri" + CHR(231) + CHR(227) + "o")
2128:             loc_oPagina.txt_4c_Descricao.SetFocus()
2129:             RETURN
2130:         ENDIF
2131: 
2132:         *-- Validacao de duplicidade - somente em modo INCLUIR (legado: CursorQuery
2133:         *-- antes do Replace cIdChaves With fUniqueIds())
2134:         loc_lDuplicado     = .F.
2135:         loc_lErroValidacao = .F.
2136: 
2137:         IF THIS.this_cModoAtual = "INCLUIR"
2138:             TRY
2139:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2140:                     "SELECT cidchaves FROM SigOpOpt WHERE RTRIM(cods) = " + EscaparSQL(loc_cCodigo), ;
2141:                     "cursor_4c_ChkDup")
2142: 
2143:                 IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkDup") > 0
2144:                     loc_lDuplicado = .T.
2145:                 ENDIF
2146: 
2147:                 IF USED("cursor_4c_ChkDup")
2148:                     USE IN cursor_4c_ChkDup
2149:                 ENDIF

*-- Linhas 2185 a 2246:
2185:     * BtnCancelarClick - Cancela edicao e volta para a lista
2186:     * Legado (SIGCDTML.Click, botao Cancelar): =DoDefault() seguido de
2187:     * ThisForm.mAtivapagina1 quando ThisForm.plCancelar
2188:     * PUBLIC: BINDEVENT requer metodo publico (Problema 17)
2189:     *===========================================================================
2190:     PROCEDURE BtnCancelarClick()
2191:         TRY
2192:             THIS.this_oBusinessObject.CancelarEdicao()
2193:         CATCH TO loException
2194:             MsgErro("Erro ao cancelar edi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2195:                 loException.Message, "Erro")
2196:         ENDTRY
2197: 
2198:         THIS.AlternarPagina(1)
2199:         THIS.this_cModoAtual = "LISTA"
2200:         THIS.CarregarLista()
2201:     ENDPROC
2202: 
2203:     *===========================================================================
2204:     * Destroy - Libera Business Object e cursores abertos
2205:     *===========================================================================
2206:     PROCEDURE Destroy()
2207:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2208:             THIS.this_oBusinessObject = .NULL.
2209:         ENDIF
2210: 
2211:         IF USED("cursor_4c_Dados")
2212:             USE IN cursor_4c_Dados
2213:         ENDIF
2214: 
2215:         IF USED("cursor_4c_Carrega")
2216:             USE IN cursor_4c_Carrega
2217:         ENDIF
2218: 
2219:         IF USED("cursor_4c_Busca")
2220:             USE IN cursor_4c_Busca
2221:         ENDIF
2222: 
2223:         IF USED("cursor_4c_ChkGcr")
2224:             USE IN cursor_4c_ChkGcr
2225:         ENDIF
2226: 
2227:         IF USED("cursor_4c_BuscaGcr")
2228:             USE IN cursor_4c_BuscaGcr
2229:         ENDIF
2230: 
2231:         IF USED("cursor_4c_ChkCli")
2232:             USE IN cursor_4c_ChkCli
2233:         ENDIF
2234: 
2235:         IF USED("cursor_4c_ChkAcb")
2236:             USE IN cursor_4c_ChkAcb
2237:         ENDIF
2238: 
2239:         IF USED("cursor_4c_BuscaAcb")
2240:             USE IN cursor_4c_BuscaAcb
2241:         ENDIF
2242: 
2243:         IF USED("cursor_4c_ChkEmp")
2244:             USE IN cursor_4c_ChkEmp
2245:         ENDIF
2246: 


### BO (C:\4c\projeto\app\classes\TmlBO.prg):
*====================================================================
* TmlBO.prg
*
* Business Object para Tipos de Material (SigCdTml / SIGCDTML)
* Tabela principal: SigOpOpt (cidchaves PK tecnica, cods chave de negocio)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TmlBO AS BusinessBase

	*-- Propriedades da entidade (SigOpOpt) - todas as 21 colunas da tabela
	this_cCidchaves  = ""    && cidchaves char(20)  - PK tecnica (UUID fUniqueIds, Replace no legado)
	this_cCods       = ""    && cods char(15)       - codigo (chave de negocio, unicidade validada no Salvar)
	this_cDescs      = ""    && descs char(40)      - descricao do tipo de material
	this_cGeraccs    = " "   && geraccs char(1)     - NOT NULL, sem campo na UI legada (default espaco)
	this_nPfalhas    = 0     && pfalhas numeric(5,2)  - falha admitida
	this_cGrupos     = ""    && grupos char(10)     - grupo (FK SigCdGcr.Codigos)
	this_cContas     = ""    && contas char(10)     - conta (FK SigCdCli.Iclis)
	this_cTfalhas    = ""    && tfalhas char(1)     - [P]ercentual ou [Q]uantidade
	this_cCtrlpds    = ""    && ctrlpds char(1)     - Analisa Producao (S/N)
	this_nValors     = 0     && valors numeric(7,2)   - valor
	this_nSituas     = 1     && situas numeric(1,0)   - situacao (OptionGroup: 1=Ativo,2=Inativo,3=Falhas/Perdas)
	this_nProdzs     = 0     && prodzs numeric(1,0)   - checkbox Produzido
	this_nTrabas     = 0     && trabas numeric(1,0)   - checkbox Trabalhado
	this_cAnaEsGrps  = ""    && anaesgrps char(1)   - Lancar Somente (E/S)
	this_cChkDevs    = ""    && chkdevs char(1)     - Checar Devolucao (S/N)
	this_cCodAcbs    = ""    && codacbs char(3)     - Tipo Acabamento (FK SigCdAca.Cods)
	this_nModels     = 0     && models numeric(1,0)   - checkbox Modelagem
	this_cEmps       = ""    && cemps char(3)        - Empresa (FK SigCdEmp.CEmps)
	this_nDupTpOps   = 0     && duptpops numeric(1,0) - checkbox Checar Duplicidade
	this_nRetrab     = 0     && retrab numeric(1,0)   - checkbox Aceita Retrabalho
	this_nIndProds   = 0     && indprods numeric(4,2)  - indice de produtividade

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		*-- CRITICO: Usar nomes CORRETOS das propriedades herdadas
		THIS.this_cTabela     = "SigOpOpt"
		THIS.this_cCampoChave = "cidchaves"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de tipos de material no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
				           " grupos, contas, tfalhas, ctrlpds, valors," + ;
				           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
				           " codacbs, models, emps, duptpops, retrab, indprods" + ;
				           " FROM SigOpOpt" + ;
				           " ORDER BY cods"
			ELSE
				loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
				           " grupos, contas, tfalhas, ctrlpds, valors," + ;
				           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
				           " codacbs, models, emps, duptpops, retrab, indprods" + ;
				           " FROM SigOpOpt" + ;
				           " WHERE RTRIM(cods) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY cods"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar tipos de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar tipos de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT cidchaves, cods, descs, geraccs, pfalhas," + ;
			           " grupos, contas, tfalhas, ctrlpds, valors," + ;
			           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
			           " codacbs, models, emps, duptpops, retrab, indprods" + ;
			           " FROM SigOpOpt" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cCods      = TratarNulo(cods, "C")
			THIS.this_cDescs     = TratarNulo(descs, "C")
			THIS.this_cGeraccs   = TratarNulo(geraccs, "C")
			THIS.this_nPfalhas   = TratarNulo(pfalhas, "N")
			THIS.this_cGrupos    = TratarNulo(grupos, "C")
			THIS.this_cContas    = TratarNulo(contas, "C")
			THIS.this_cTfalhas   = TratarNulo(tfalhas, "C")
			THIS.this_cCtrlpds   = TratarNulo(ctrlpds, "C")
			THIS.this_nValors    = TratarNulo(valors, "N")
			THIS.this_nSituas    = TratarNulo(situas, "N")
			THIS.this_nProdzs    = TratarNulo(prodzs, "N")
			THIS.this_nTrabas    = TratarNulo(trabas, "N")
			THIS.this_cAnaEsGrps = TratarNulo(anaesgrps, "C")
			THIS.this_cChkDevs   = TratarNulo(chkdevs, "C")
			THIS.this_cCodAcbs   = TratarNulo(codacbs, "C")
			THIS.this_nModels    = TratarNulo(models, "N")
			THIS.this_cEmps      = TratarNulo(emps, "C")
			THIS.this_nDupTpOps  = TratarNulo(duptpops, "N")
			THIS.this_nRetrab    = TratarNulo(retrab, "N")
			THIS.this_nIndProds  = TratarNulo(indprods, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SigOpOpt (cidchaves, cods, descs, geraccs, pfalhas," + ;
			           " grupos, contas, tfalhas, ctrlpds, valors," + ;
			           " situas, prodzs, trabas, anaesgrps, chkdevs," + ;
			           " codacbs, models, emps, duptpops, retrab, indprods)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 15)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 40)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cGeraccs, " ")), 1)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPfalhas, 2) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cTfalhas), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtrlpds), 1)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nValors, 2) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nProdzs, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrabas, 0) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cAnaEsGrps), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cChkDevs), 1)) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodAcbs), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nModels, 0) + "," + ;
			           EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nDupTpOps, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nRetrab, 0) + "," + ;
			           FormatarNumeroSQL(THIS.this_nIndProds, 2) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigOpOpt SET" + ;
			           " cods = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCods), 15)) + "," + ;
			           " descs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cDescs), 40)) + "," + ;
			           " geraccs = " + EscaparSQL(LEFT(ALLTRIM(NVL(THIS.this_cGeraccs, " ")), 1)) + "," + ;
			           " pfalhas = " + FormatarNumeroSQL(THIS.this_nPfalhas, 2) + "," + ;
			           " grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + "," + ;
			           " contas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cContas), 10)) + "," + ;
			           " tfalhas = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTfalhas), 1)) + "," + ;
			           " ctrlpds = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCtrlpds), 1)) + "," + ;
			           " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + "," + ;
			           " situas = " + FormatarNumeroSQL(THIS.this_nSituas, 0) + "," + ;
			           " prodzs = " + FormatarNumeroSQL(THIS.this_nProdzs, 0) + "," + ;
			           " trabas = " + FormatarNumeroSQL(THIS.this_nTrabas, 0) + "," + ;
			           " anaesgrps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cAnaEsGrps), 1)) + "," + ;
			           " chkdevs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cChkDevs), 1)) + "," + ;
			           " codacbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodAcbs), 3)) + "," + ;
			           " models = " + FormatarNumeroSQL(THIS.this_nModels, 0) + "," + ;
			           " emps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmps), 3)) + "," + ;
			           " duptpops = " + FormatarNumeroSQL(THIS.this_nDupTpOps, 0) + "," + ;
			           " retrab = " + FormatarNumeroSQL(THIS.this_nRetrab, 0) + "," + ;
			           " indprods = " + FormatarNumeroSQL(THIS.this_nIndProds, 2) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigOpOpt
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigOpOpt WHERE RTRIM(cidchaves) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir tipo de material:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir tipo de material:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

