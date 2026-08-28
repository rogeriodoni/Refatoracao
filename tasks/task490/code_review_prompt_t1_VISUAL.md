# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 260: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 285: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 323: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 413: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 438: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormOrg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (965 linhas total):

*-- Linhas 49 a 58:
49:                     "FormOrg.InicializarForm")
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Visible    = .T.
55:                 THIS.pgf_4c_Paginas.ActivePage = 1
56:                 THIS.this_cModoAtual           = "LISTA"
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 74 a 100:
74: 
75:     *===========================================================================
76:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
77:     * PageFrame.Top=-29 para esconder abas; controles compensam +29 no Top
78:     *===========================================================================
79:     PROTECTED PROCEDURE ConfigurarPageFrame()
80:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81: 
82:         WITH THIS.pgf_4c_Paginas
83:             .PageCount = 2
84:             .Top       = -29
85:             .Left      = 0
86:             .Width     = THIS.Width
87:             .Height    = THIS.Height + 29
88:             .Tabs      = .F.
89:             .Visible   = .T.
90: 
91:             .Page1.Caption   = "Lista"
92:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Page1.BackColor = RGB(255, 255, 255)
94: 
95:             .Page2.Caption   = "Dados"
96:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:             .Page2.BackColor = RGB(255, 255, 255)
98:         ENDWITH
99: 
100:         THIS.ConfigurarPaginaLista()

*-- Linhas 115 a 155:
115:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116: 
117:         *-- Container Cabecalho (cntSombra no legado: Top=1, Left=-1, Width=1008, Height=80)
118:         *-- Compensacao PageFrame.Top=-29: Top = 1 + 29 = 30
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 30
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = 769
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .AutoSize  = .F.
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = 769
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 163 a 349:
163:         *-- Canonico: Left=542, Top=28 (-1+29), Width=390, Height=85
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
165:         WITH loc_oPagina.cnt_4c_Botoes
166:             .Top         = 28
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackStyle   = 0
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         *-- Botao Incluir (Left=5)
176:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 75
185:             .FontName        = "Comic Sans MS"
186:             .FontBold        = .T.
187:             .FontItalic      = .T.
188:             .FontSize        = 8
189:             .ForeColor       = RGB(90, 90, 90)
190:             .BackColor       = RGB(255, 255, 255)
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .MousePointer    = 15
194:             .WordWrap        = .T.
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
199: 
200:         *-- Botao Visualizar (Left=80)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
203:             .Caption         = "Visualizar"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 80
208:             .Width           = 75
209:             .Height          = 75
210:             .FontName        = "Comic Sans MS"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .ForeColor       = RGB(90, 90, 90)
215:             .BackColor       = RGB(255, 255, 255)
216:             .Themes          = .F.
217:             .SpecialEffect   = 0
218:             .MousePointer    = 15
219:             .WordWrap        = .T.
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
224: 
225:         *-- Botao Alterar (Left=155)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
228:             .Caption         = "Alterar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 155
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Comic Sans MS"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
249: 
250:         *-- Botao Excluir (Left=230)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
253:             .Caption         = "Excluir"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 230
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Comic Sans MS"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontSize        = 8
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
274: 
275:         *-- Botao Buscar (Left=305)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
278:             .Caption         = "Buscar"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 305
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Comic Sans MS"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .FontSize        = 8
289:             .ForeColor       = RGB(90, 90, 90)
290:             .BackColor       = RGB(255, 255, 255)
291:             .Themes          = .F.
292:             .SpecialEffect   = 0
293:             .MousePointer    = 15
294:             .WordWrap        = .T.
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
299: 
300:         *-- Container Saida - PADRAO CANONICO (CLAUDE.md regra #10 - prevalece sobre legado)
301:         *-- Left=917, Width=90, Height=85, Top=28 (-1+29)
302:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
303:         WITH loc_oPagina.cnt_4c_Saida
304:             .Top         = 28
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         *-- Botao Encerrar - PADRAO CANONICO: Width=75, Height=75, Caption="Encerrar"
314:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
315:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
316:             .Caption         = "Encerrar"
317:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
318:             .PicturePosition = 13
319:             .Top             = 5
320:             .Left            = 5
321:             .Width           = 75
322:             .Height          = 75
323:             .FontName        = "Comic Sans MS"
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .FontSize        = 8
327:             .ForeColor       = RGB(90, 90, 90)
328:             .BackColor       = RGB(255, 255, 255)
329:             .Themes          = .F.
330:             .SpecialEffect   = 0
331:             .MousePointer    = 15
332:             .WordWrap        = .T.
333:             .AutoSize        = .F.
334:             .Visible         = .T.
335:         ENDWITH
336:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid grd_4c_Lista (grade no legado: 2 colunas Codigos/Descricaos)
339:         *-- Legado: Top=121, Left=12; compensado +29 = 150; usando framework Top=117 (abaixo dos ~113)
340:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
341:         loc_oGrid = loc_oPagina.grd_4c_Lista
342: 
343:         loc_oGrid.Top                = 117
344:         loc_oGrid.Left               = 10
345:         loc_oGrid.Width              = 900
346:         loc_oGrid.Height             = 475
347:         loc_oGrid.ColumnCount        = 2
348:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
349:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)

*-- Linhas 363 a 463:
363:         WITH loc_oGrid
364:             .Column1.Width             = 80
365:             .Column1.Alignment         = 2
366:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
367:             .Column1.Header1.Alignment = 2
368:             .Column2.Width             = 800
369:             .Column2.Alignment         = 1
370:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
371:             .Column2.Header1.Alignment = 1
372:         ENDWITH
373: 
374:         THIS.TornarControlesVisiveis(loc_oPagina)
375:     ENDPROC
376: 
377:     *===========================================================================
378:     * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar + campos
379:     * Fase 5: BotoesAcao (Confirmar/Cancelar) + campo Codigo (50% dos campos)
380:     * Fase 6: campo Descricao (50% restante)
381:     * Compensacao PageFrame.Top=-29: todos os Tops += 29
382:     *===========================================================================
383:     PROTECTED PROCEDURE ConfigurarPaginaDados()
384:         LOCAL loc_oPagina
385:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
386: 
387:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
388:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
389: 
390:         *-- Container BotoesAcao (Grupo_Salva: Left=816, Top=11+29=40, Width=160, Height=85)
391:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
392:         WITH loc_oPagina.cnt_4c_BotoesAcao
393:             .Top         = 40
394:             .Left        = 816
395:             .Width       = 160
396:             .Height      = 85
397:             .BackStyle = 0
398:             .BackColor   = RGB(255, 255, 255)
399:             .BorderWidth = 0
400:             .Visible     = .T.
401:         ENDWITH
402: 
403:         *-- Botao Confirmar (salva no legado: Left=5, Top=5)
404:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
405:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
406:             .Caption         = "Confirmar"
407:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
408:             .PicturePosition = 13
409:             .Top             = 5
410:             .Left            = 5
411:             .Width           = 75
412:             .Height          = 75
413:             .FontName        = "Comic Sans MS"
414:             .FontBold        = .T.
415:             .FontItalic      = .T.
416:             .FontSize        = 8
417:             .ForeColor       = RGB(90, 90, 90)
418:             .BackColor       = RGB(255, 255, 255)
419:             .Themes          = .F.
420:             .SpecialEffect   = 0
421:             .MousePointer    = 15
422:             .WordWrap        = .T.
423:             .AutoSize        = .F.
424:             .Visible         = .T.
425:         ENDWITH
426:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
427: 
428:         *-- Botao Cancelar (cancela no legado: Left=80, Top=5)
429:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
430:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
431:             .Caption         = "Encerrar"
432:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
433:             .PicturePosition = 13
434:             .Top             = 5
435:             .Left            = 80
436:             .Width           = 75
437:             .Height          = 75
438:             .FontName        = "Comic Sans MS"
439:             .FontBold        = .T.
440:             .FontItalic      = .T.
441:             .FontSize        = 8
442:             .ForeColor       = RGB(90, 90, 90)
443:             .BackColor       = RGB(255, 255, 255)
444:             .Themes          = .F.
445:             .SpecialEffect   = 0
446:             .MousePointer    = 15
447:             .WordWrap        = .T.
448:             .AutoSize        = .F.
449:             .Visible         = .T.
450:         ENDWITH
451:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
452: 
453:         *-- Label Codigo (Say1: Top=134, Left=291, Width=42, Height=15 -> +29 = Top=163)
454:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
455:         WITH loc_oPagina.lbl_4c_Codigo
456:             .Caption   = "C" + CHR(243) + "digo :"
457:             .Top       = 163
458:             .Left      = 291
459:             .Width     = 42
460:             .Height    = 15
461:             .FontName  = "Tahoma"
462:             .FontSize  = 8
463:             .FontBold  = .F.

*-- Linhas 474 a 483:
474:         WITH loc_oPagina.txt_4c_Codigo
475:             .Value         = ""
476:             .MaxLength     = 1
477:             .Top           = 158
478:             .Left          = 335
479:             .Width         = 17
480:             .Height        = 25
481:             .FontName      = "Tahoma"
482:             .FontSize      = 8
483:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 489 a 501:
489:         ENDWITH
490: 
491:         *-- Label Descricao (Say2: Top=162, Left=278, Width=55, Height=15 -> +29 = Top=191)
492:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
493:         WITH loc_oPagina.lbl_4c_Descricao
494:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
495:             .Top       = 191
496:             .Left      = 278
497:             .Width     = 55
498:             .Height    = 15
499:             .FontName  = "Tahoma"
500:             .FontSize  = 8
501:             .FontBold  = .F.

*-- Linhas 512 a 521:
512:         WITH loc_oPagina.txt_4c_Descricao
513:             .Value         = ""
514:             .MaxLength     = 40
515:             .Top           = 186
516:             .Left          = 335
517:             .Width         = 290
518:             .Height        = 25
519:             .FontName      = "Tahoma"
520:             .FontSize      = 8
521:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 549 a 559:
549:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
550:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descricaos"
551: 
552:                     loc_oGrid.Column1.Header1.Caption   = "C" + CHR(243) + "digo"
553:                     loc_oGrid.Column1.Header1.Alignment = 2
554:                     loc_oGrid.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
555:                     loc_oGrid.Column2.Header1.Alignment = 1
556: 
557:                     THIS.FormatarGridLista(loc_oGrid)
558:                     loc_lResultado = .T.
559:                 ENDIF

*-- Linhas 895 a 904:
895:             loc_oPg2.txt_4c_Descricao.ReadOnly = !par_lHabilitar
896: 
897:             *-- Botao Confirmar: habilitado apenas em modo de edicao
898:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
899:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
900:         CATCH TO loException
901:             MostrarErro("Erro ao habilitar campos:" + CHR(13) + loException.Message, "FormOrg.HabilitarCampos")
902:         ENDTRY
903:     ENDPROC
904: 

*-- Linhas 932 a 952:
932:         TRY
933:             DO CASE
934:             CASE THIS.this_cModoAtual = "LISTA"
935:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
936:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
937:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
938:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
939:                 loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
940: 
941:             CASE THIS.this_cModoAtual = "INCLUIR" OR THIS.this_cModoAtual = "ALTERAR"
942:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
943:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
944: 
945:             CASE THIS.this_cModoAtual = "VISUALIZAR"
946:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
947:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
948:             ENDCASE
949:         CATCH TO loException
950:             MostrarErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + ;
951:                 loException.Message, "FormOrg.AjustarBotoesPorModo")
952:         ENDTRY


### BO (C:\4c\projeto\app\classes\OrgBO.prg):
*==============================================================================
* OrgBO.prg - Business Object para Origens de Mercadoria
* Tabela: SigCdOrg
* Migrado de: SigCdOrg.SCX (frmcadastro)
*==============================================================================

DEFINE CLASS OrgBO AS BusinessBase

    *-- Propriedades de dados
    this_cCodigo    = ""    && codigos  char(1)  - chave primaria
    this_cDescricao = ""    && descricaos char(40)

    *--------------------------------------------------------------------------
    * Init - Inicializa BO
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOrg"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

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
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros ou filtrados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos" + ;
                       " FROM SigCdOrg a"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Origens:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.codigos, a.descricaos" + ;
                       " FROM SigCdOrg a" + ;
                       " WHERE a.codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdOrg (codigos, descricaos)" + ;
                       " VALUES (" + EscaparSQL(THIS.this_cCodigo) + ;
                       ", " + EscaparSQL(THIS.this_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOrg SET" + ;
                       " descricaos = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro (chamado pelo BusinessBase.Excluir)
    * Valida: nao pode excluir se usado em SigCdPro ou SigCdPrc (origmercs)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado, loc_cSQL2, loc_nResult2, loc_lPodeExcluir
        loc_lResultado   = .F.
        loc_lPodeExcluir = .T.

        TRY
            *-- Verificar uso em SigCdPro
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPro" + ;
                       " WHERE origmercs = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkPro") > 0
                SELECT cursor_4c_ChkPro
                IF cursor_4c_ChkPro.qtd > 0
                    MsgErro("Origem n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da pois est" + CHR(225) + " sendo usada em Produtos!", "")
                    loc_lPodeExcluir = .F.
                ENDIF
            ENDIF
            IF USED("cursor_4c_ChkPro")
                USE IN cursor_4c_ChkPro
            ENDIF

            *-- Verificar uso em SigCdPrc (somente se ainda pode excluir)
            IF loc_lPodeExcluir
                loc_cSQL2 = "SELECT COUNT(*) AS qtd FROM SigCdPrc" + ;
                            " WHERE origmercs = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL2, "cursor_4c_ChkPrc")
                IF loc_nResult2 >= 0 AND RECCOUNT("cursor_4c_ChkPrc") > 0
                    SELECT cursor_4c_ChkPrc
                    IF cursor_4c_ChkPrc.qtd > 0
                        MsgErro("Origem n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da pois est" + CHR(225) + " sendo usada em Produtos!", "")
                        loc_lPodeExcluir = .F.
                    ENDIF
                ENDIF
                IF USED("cursor_4c_ChkPrc")
                    USE IN cursor_4c_ChkPrc
                ENDIF
            ENDIF

            *-- Executar exclusao somente se passou nas validacoes
            IF loc_lPodeExcluir
                loc_cSQL = "DELETE FROM SigCdOrg WHERE codigos = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir Origem:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe (para INSERIR)
    *--------------------------------------------------------------------------
    FUNCTION ValidarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOrg" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrg")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkOrg") > 0
                SELECT cursor_4c_ChkOrg
                loc_lExiste = (cursor_4c_ChkOrg.qtd > 0)
            ENDIF
            IF USED("cursor_4c_ChkOrg")
                USE IN cursor_4c_ChkOrg
            ENDIF
        CATCH TO loException
            MsgErro("Erro:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

