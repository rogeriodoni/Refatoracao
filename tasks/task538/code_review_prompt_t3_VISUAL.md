# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (34)
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [LAYOUT-POSITION] Controle 'optReposicaos' (parent: SIGCDTOP.Pagina.Dados): Top original=442 vs migrado 'obj_4c_OptReposicaos' Top=514 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label11' (parent: SIGCDTOP.Pagina.Dados): Top original=322 vs migrado 'lbl_4c_Label11' Top=394 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label9' (parent: SIGCDTOP.Pagina.Dados): Top original=298 vs migrado 'lbl_4c_Label9' Top=370 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDTOP.Pagina.Dados): Top original=211 vs migrado 'lbl_4c_Label3' Top=283 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDTOP.Pagina.Dados): Top original=154 vs migrado 'lbl_4c_Label2' Top=226 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTOP.Pagina.Dados): Top original=74 vs migrado 'lbl_4c_Label11' Top=394 (diff=320px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDTOP.Pagina.Dados): Left original=110 vs migrado 'lbl_4c_Label11' Left=57 (diff=53px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDTOP.Pagina.Dados): Top original=240 vs migrado 'lbl_4c_Label4' Top=312 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'getEntPends' (parent: SIGCDTOP.Pagina.Dados): Top original=324 vs migrado 'obj_4c_GetEntPends' Top=396 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDTOP.Pagina.Dados): Top original=240 vs migrado 'lbl_4c_Say1' Top=312 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption6' (parent: SIGCDTOP.Pagina.Dados): Top original=295 vs migrado 'obj_4c_Fwoption6' Top=367 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDTOP.Pagina.Dados): Top original=270 vs migrado 'lbl_4c_Say2' Top=342 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'ObjCancPdv' (parent: SIGCDTOP.Pagina.Dados): Top original=208 vs migrado 'obj_4c_ObjCancPdv' Top=280 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption1' (parent: SIGCDTOP.Pagina.Dados): Top original=237 vs migrado 'obj_4c_Fwoption1' Top=309 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption2' (parent: SIGCDTOP.Pagina.Dados): Top original=266 vs migrado 'obj_4c_Fwoption2' Top=338 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption5' (parent: SIGCDTOP.Pagina.Dados): Top original=295 vs migrado 'obj_4c_Fwoption5' Top=367 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption4' (parent: SIGCDTOP.Pagina.Dados): Top original=266 vs migrado 'obj_4c_Fwoption4' Top=338 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption3' (parent: SIGCDTOP.Pagina.Dados): Top original=237 vs migrado 'obj_4c_Fwoption3' Top=309 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDTOP.Pagina.Dados): Top original=440 vs migrado 'lbl_4c_Say3' Top=512 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say4' (parent: SIGCDTOP.Pagina.Dados): Top original=375 vs migrado 'lbl_4c_Say4' Top=447 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDTOP.Pagina.Dados): Top original=399 vs migrado 'lbl_4c_Label5' Top=471 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label6' (parent: SIGCDTOP.Pagina.Dados): Top original=399 vs migrado 'lbl_4c_Label6' Top=471 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say6' (parent: SIGCDTOP.Pagina.Dados): Top original=299 vs migrado 'lbl_4c_Say6' Top=371 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say5' (parent: SIGCDTOP.Pagina.Dados): Top original=270 vs migrado 'lbl_4c_Say5' Top=342 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label7' (parent: SIGCDTOP.Pagina.Dados): Top original=399 vs migrado 'lbl_4c_Label7' Top=471 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label8' (parent: SIGCDTOP.Pagina.Dados): Top original=183 vs migrado 'lbl_4c_Label8' Top=255 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'optTpMercs' (parent: SIGCDTOP.Pagina.Dados): Top original=179 vs migrado 'obj_4c_OptTpMercs' Top=251 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption7' (parent: SIGCDTOP.Pagina.Dados): Top original=324 vs migrado 'obj_4c_Fwoption7' Top=396 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say7' (parent: SIGCDTOP.Pagina.Dados): Top original=328 vs migrado 'lbl_4c_Say7' Top=400 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label10' (parent: SIGCDTOP.Pagina.Dados): Top original=125 vs migrado 'lbl_4c_Label10' Top=197 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwoption8' (parent: SIGCDTOP.Pagina.Dados): Top original=121 vs migrado 'obj_4c_Fwoption8' Top=193 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say8' (parent: SIGCDTOP.Pagina.Dados): Top original=356 vs migrado 'lbl_4c_Say8' Top=428 (diff=72px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Fwoption9' (parent: SIGCDTOP.Pagina.Dados): Top original=353 vs migrado 'obj_4c_Fwoption9' Top=425 (diff=72px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTop.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2306 linhas total):

*-- Linhas 54 a 65:
54:             ELSE
55:                 THIS.ConfigurarPageFrame()
56: 
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61: 
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65: 

*-- Linhas 86 a 105:
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 29
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()

*-- Linhas 123 a 160:
123:         *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
124:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
125:         WITH loc_oPagina.cnt_4c_Cabecalho
126:             .Top         = 29
127:             .Left        = 0
128:             .Width       = THIS.Width
129:             .Height      = 80
130:             .BackColor   = RGB(100, 100, 100)
131:             .BorderWidth = 0
132:             .Visible     = .T.
133:         ENDWITH
134: 
135:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
136:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
137:             .Caption   = THIS.Caption
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = 769
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .AutoSize  = .F.
148:             .Visible   = .T.
149:         ENDWITH
150: 
151:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
152:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
153:             .Caption   = THIS.Caption
154:             .Top       = 18
155:             .Left      = 10
156:             .Width     = 769
157:             .Height    = 46
158:             .FontName  = "Tahoma"
159:             .FontSize  = 16
160:             .FontBold  = .T.

*-- Linhas 168 a 190:
168:         *-- Canonico: Left=542, Top=29, Width=390, Height=85 (framework_frmcadastro_layout.md)
169:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
170:         WITH loc_oPagina.cnt_4c_Botoes
171:             .Top         = 29
172:             .Left        = 542
173:             .Width       = 390
174:             .Height      = 85
175:             .BackColor   = RGB(100, 100, 100)
176:             .BackStyle   = 0
177:             .BorderWidth = 0
178:             .Visible     = .T.
179:         ENDWITH
180: 
181:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Top             = 5
185:             .Left            = 5
186:             .Width           = 75
187:             .Height          = 75
188:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
189:             .PicturePosition = 13
190:             .FontName        = "Tahoma"

*-- Linhas 201 a 213:
201:             .Visible         = .T.
202:         ENDWITH
203: 
204:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
205:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
206:             .Caption         = "Visualizar"
207:             .Top             = 5
208:             .Left            = 80
209:             .Width           = 75
210:             .Height          = 75
211:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
212:             .PicturePosition = 13
213:             .FontName        = "Tahoma"

*-- Linhas 224 a 236:
224:             .Visible         = .T.
225:         ENDWITH
226: 
227:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
228:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
229:             .Caption         = "Alterar"
230:             .Top             = 5
231:             .Left            = 155
232:             .Width           = 75
233:             .Height          = 75
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .FontName        = "Tahoma"

*-- Linhas 247 a 259:
247:             .Visible         = .T.
248:         ENDWITH
249: 
250:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
251:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
252:             .Caption         = "Excluir"
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
258:             .PicturePosition = 13
259:             .FontName        = "Tahoma"

*-- Linhas 270 a 282:
270:             .Visible         = .T.
271:         ENDWITH
272: 
273:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
281:             .PicturePosition = 13
282:             .FontName        = "Tahoma"

*-- Linhas 297 a 318:
297:         *-- Transparente/flutuante sobre a Page; Page.Width NAO subtrai espaco por este container
298:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
299:         WITH loc_oPagina.cnt_4c_Saida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308: 
309:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Top             = 5
313:             .Left            = 5
314:             .Width           = 75
315:             .Height          = 75
316:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
317:             .PicturePosition = 13
318:             .FontName        = "Tahoma"

*-- Linhas 331 a 343:
331: 
332:         *-- Grid de lista (Grade no legado) - AddCursor('SigCdTom','Codigos','CrSigCdTom')
333:         *-- pColuna('Codigos',...,44) + pColuna('Descrs',...,279)
334:         *-- Original: Grade.Top=88. Com compensacao +29: Top=117
335:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
336:         WITH loc_oPagina.grd_4c_Lista
337:             .Top                = 117
338:             .Left               = 12
339:             .Width              = 895
340:             .Height             = 455
341:             .FontName           = "Verdana"
342:             .FontSize           = 8
343:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 359 a 382:
359:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
360: 
361:         WITH loc_oPagina.grd_4c_Lista
362:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
363:             .Column1.Width           = 120
364:             .Column1.Alignment       = 1
365: 
366:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
367:             .Column2.Width           = 770
368:             .Column2.Alignment       = 0
369:         ENDWITH
370: 
371:         *-- BINDEVENTs - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
372:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
373:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
374:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
375:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
376:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
377:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
378: 
379:         THIS.TornarControlesVisiveis(loc_oPagina)
380:     ENDPROC
381: 
382:     *===========================================================================

*-- Linhas 394 a 431:
394:         *-- Faixa do Cabecalho (PRIMEIRO AddObject da pagina - CLAUDE.md #11)
395:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
396:         WITH loc_oPagina.cnt_4c_Cabecalho
397:             .Top         = 29
398:             .Left        = 0
399:             .Width       = THIS.Width
400:             .Height      = 80
401:             .BackColor   = RGB(100, 100, 100)
402:             .BorderWidth = 0
403:             .Visible     = .T.
404:         ENDWITH
405: 
406:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
407:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
408:             .Caption   = THIS.Caption
409:             .Top       = 15
410:             .Left      = 10
411:             .Width     = 769
412:             .Height    = 40
413:             .FontName  = "Tahoma"
414:             .FontSize  = 16
415:             .FontBold  = .T.
416:             .ForeColor = RGB(0, 0, 0)
417:             .BackStyle = 0
418:             .AutoSize  = .F.
419:             .Visible   = .T.
420:         ENDWITH
421: 
422:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
423:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
424:             .Caption   = THIS.Caption
425:             .Top       = 18
426:             .Left      = 10
427:             .Width     = 769
428:             .Height    = 46
429:             .FontName  = "Tahoma"
430:             .FontSize  = 16
431:             .FontBold  = .T.

*-- Linhas 439 a 461:
439:         *-- Posicao base equivalente ao Grupo_Salva do framework (Top=33, Left=842)
440:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
441:         WITH loc_oPagina.cnt_4c_BotoesAcao
442:             .Top         = 33
443:             .Left        = 842
444:             .Width       = 160
445:             .Height      = 85
446:             .BackStyle = 1
447:             .BackColor = RGB(255, 255, 255)
448:             .BorderWidth = 0
449:             .Visible     = .T.
450:         ENDWITH
451: 
452:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
453:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
454:             .Caption         = "Confirmar"
455:             .Top             = 5
456:             .Left            = 5
457:             .Width           = 75
458:             .Height          = 75
459:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
460:             .PicturePosition = 13
461:             .FontName        = "Tahoma"

*-- Linhas 472 a 484:
472:             .Visible         = .T.
473:         ENDWITH
474: 
475:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
476:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
477:             .Caption         = "Encerrar"
478:             .Top             = 5
479:             .Left            = 80
480:             .Width           = 75
481:             .Height          = 75
482:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
483:             .PicturePosition = 13
484:             .FontName        = "Tahoma"

*-- Linhas 496 a 509:
496:         ENDWITH
497: 
498:         *-- BINDEVENTs dos botoes de acao (metodos PUBLIC implementados em fase posterior)
499:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
500:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
501: 
502:         *-- Campos principais - Page2 (FASE 5/8 - primeira metade)
503:         *-- Original: SIGCDTOP.Pagina.Dados.* -- Top_novo = Top_original + 72
504:         *-- (compensa PageFrame.Top=-29 [+29] e a faixa de cabecalho canonica
505:         *-- Top=29/Height=80 [+43], ficando o 1o controle em Top=115 - CLAUDE.md #11)
506:         THIS.AdicionarCamposPrincipais1(loc_oPagina)
507: 
508:         *-- Campos restantes - Page2 (FASE 6/8 - segunda metade)
509:         THIS.AdicionarCamposPrincipais2(loc_oPagina)

*-- Linhas 532 a 574:
532:     PROTECTED PROCEDURE AdicionarCamposPrincipais1(par_oPagina)
533: 
534:         *-- Codigo (PK - crSigCdTom.Codigos - numeric(2,0) - InputMask "99")
535:         par_oPagina.AddObject("lbl_4c_Codigos", "Label")
536:         WITH par_oPagina.lbl_4c_Codigos
537:             .Caption   = "C" + CHR(243) + "digo :"
538:             .Top       = 118
539:             .Left      = 210
540:             .Width     = 42
541:             .Height    = 15
542:             .FontName  = "Tahoma"
543:             .FontSize  = 8
544:             .BackStyle = 0
545:             .ForeColor = RGB(90, 90, 90)
546:             .AutoSize  = .T.
547:             .Visible   = .T.
548:         ENDWITH
549: 
550:         par_oPagina.AddObject("txt_4c_Codigos", "TextBox")
551:         WITH par_oPagina.txt_4c_Codigos
552:             .Top           = 115
553:             .Left          = 257
554:             .Width         = 25
555:             .Height        = 23
556:             .MaxLength     = 2
557:             .InputMask     = "99"
558:             .SpecialEffect = 1
559:             .ForeColor     = RGB(0, 0, 0)
560:             .Value         = 0
561:             .Visible       = .T.
562:         ENDWITH
563: 
564:         *-- Descricao (crSigCdTom.Descrs - char(30))
565:         par_oPagina.AddObject("lbl_4c_Descrs", "Label")
566:         WITH par_oPagina.lbl_4c_Descrs
567:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
568:             .Top       = 118
569:             .Left      = 304
570:             .Width     = 55
571:             .Height    = 15
572:             .FontName  = "Tahoma"
573:             .FontSize  = 8
574:             .Alignment = 1

*-- Linhas 580 a 604:
580: 
581:         par_oPagina.AddObject("txt_4c_Descrs", "TextBox")
582:         WITH par_oPagina.txt_4c_Descrs
583:             .Top           = 115
584:             .Left          = 373
585:             .Width         = 220
586:             .Height        = 23
587:             .MaxLength     = 30
588:             .SpecialEffect = 1
589:             .ForeColor     = RGB(0, 0, 0)
590:             .Value         = ""
591:             .Visible       = .T.
592:         ENDWITH
593: 
594:         *-- Gravacao de Movimentacao (crSigCdTom.gergdmis - Op_Gdmi - 6 opcoes)
595:         par_oPagina.AddObject("lbl_4c_Label1", "Label")
596:         WITH par_oPagina.lbl_4c_Label1
597:             .Caption   = "Grava" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + CHR(227) + "o: "
598:             .Top       = 146
599:             .Left      = 110
600:             .Width     = 142
601:             .Height    = 15
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .BackStyle = 0

*-- Linhas 610 a 718:
610:         par_oPagina.AddObject("obj_4c_OpGdmi", "OptionGroup")
611:         WITH par_oPagina.obj_4c_OpGdmi
612:             .ButtonCount = 6
613:             .Top         = 143
614:             .Left        = 257
615:             .Width       = 251
616:             .Height      = 44
617:             .BackStyle   = 0
618:             .BorderStyle = 1
619:             .SpecialEffect = 1
620:             .Themes      = .F.
621:             .Value       = 5
622:             .Visible     = .T.
623:         ENDWITH
624:         WITH par_oPagina.obj_4c_OpGdmi.Buttons(1)
625:             .Caption   = "Venda"
626:             .Left      = 3
627:             .Top       = 4
628:             .Width     = 64
629:             .Height    = 16
630:             .Style     = 0
631:             .AutoSize  = .F.
632:             .BackStyle = 0
633:             .FontName  = "Tahoma"
634:             .FontSize  = 8
635:             .ForeColor = RGB(90, 90, 90)
636:             .Themes    = .F.
637:         ENDWITH
638:         WITH par_oPagina.obj_4c_OpGdmi.Buttons(2)
639:             .Caption   = "Compra"
640:             .Left      = 67
641:             .Top       = 4
642:             .Width     = 64
643:             .Height    = 16
644:             .Style     = 0
645:             .AutoSize  = .F.
646:             .BackStyle = 0
647:             .FontName  = "Tahoma"
648:             .FontSize  = 8
649:             .ForeColor = RGB(90, 90, 90)
650:             .Themes    = .F.
651:         ENDWITH
652:         WITH par_oPagina.obj_4c_OpGdmi.Buttons(3)
653:             .Caption   = "Pedido de Venda"
654:             .Left      = 136
655:             .Top       = 4
656:             .Width     = 98
657:             .Height    = 15
658:             .Style     = 0
659:             .AutoSize  = .T.
660:             .BackStyle = 0
661:             .FontName  = "Tahoma"
662:             .FontSize  = 8
663:             .ForeColor = RGB(90, 90, 90)
664:             .Themes    = .F.
665:         ENDWITH
666:         WITH par_oPagina.obj_4c_OpGdmi.Buttons(4)
667:             .Caption   = "Estoque"
668:             .Left      = 3
669:             .Top       = 22
670:             .Width     = 64
671:             .Height    = 16
672:             .Style     = 0
673:             .AutoSize  = .F.
674:             .BackStyle = 0
675:             .FontName  = "Tahoma"
676:             .FontSize  = 8
677:             .ForeColor = RGB(90, 90, 90)
678:             .Themes    = .F.
679:         ENDWITH
680:         WITH par_oPagina.obj_4c_OpGdmi.Buttons(5)
681:             .Caption   = "Nenhum"
682:             .Left      = 67
683:             .Top       = 22
684:             .Width     = 64
685:             .Height    = 16
686:             .Style     = 0
687:             .AutoSize  = .F.
688:             .BackStyle = 0
689:             .FontName  = "Tahoma"
690:             .FontSize  = 8
691:             .ForeColor = RGB(90, 90, 90)
692:             .Themes    = .F.
693:         ENDWITH
694:         WITH par_oPagina.obj_4c_OpGdmi.Buttons(6)
695:             .Caption   = "Pedido de Compra"
696:             .Left      = 136
697:             .Top       = 22
698:             .Width     = 105
699:             .Height    = 15
700:             .AutoSize  = .T.
701:             .BackStyle = 0
702:             .FontName  = "Tahoma"
703:             .FontSize  = 8
704:             .ForeColor = RGB(90, 90, 90)
705:             .Themes    = .F.
706:         ENDWITH
707: 
708:         *-- Vendedor (crSigCdTom.GerVds - fwoption8 - 2 opcoes)
709:         par_oPagina.AddObject("lbl_4c_Label10", "Label")
710:         WITH par_oPagina.lbl_4c_Label10
711:             .Caption   = "Vendedor :"
712:             .Top       = 197
713:             .Left      = 197
714:             .Width     = 55
715:             .Height    = 15
716:             .FontName  = "Tahoma"
717:             .FontSize  = 8
718:             .BackStyle = 0

*-- Linhas 724 a 769:
724:         par_oPagina.AddObject("obj_4c_Fwoption8", "OptionGroup")
725:         WITH par_oPagina.obj_4c_Fwoption8
726:             .ButtonCount   = 2
727:             .Top           = 193
728:             .Left          = 257
729:             .Width         = 251
730:             .Height        = 24
731:             .BackStyle     = 0
732:             .BorderStyle   = 1
733:             .SpecialEffect = 1
734:             .Themes        = .F.
735:             .Value         = 1
736:             .Visible       = .T.
737:         ENDWITH
738:         WITH par_oPagina.obj_4c_Fwoption8.Buttons(1)
739:             .Caption   = "Pr" + CHR(243) + "pria Opera" + CHR(231) + CHR(227) + "o"
740:             .Left      = 3
741:             .Top       = 5
742:             .AutoSize  = .T.
743:             .BackStyle = 0
744:             .FontSize  = 8
745:             .ForeColor = RGB(90, 90, 90)
746:             .Themes    = .F.
747:         ENDWITH
748:         WITH par_oPagina.obj_4c_Fwoption8.Buttons(2)
749:             .Caption   = "SubNivel"
750:             .Left      = 137
751:             .Top       = 5
752:             .AutoSize  = .T.
753:             .BackStyle = 0
754:             .FontSize  = 8
755:             .ForeColor = RGB(90, 90, 90)
756:             .Themes    = .F.
757:         ENDWITH
758: 
759:         *-- Situacao (crSigCdTom.Flagpgs - Op_Situacao - 3 opcoes)
760:         par_oPagina.AddObject("lbl_4c_Label2", "Label")
761:         WITH par_oPagina.lbl_4c_Label2
762:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
763:             .Top       = 226
764:             .Left      = 202
765:             .Width     = 50
766:             .Height    = 15
767:             .FontName  = "Tahoma"
768:             .FontSize  = 8
769:             .BackStyle = 0

*-- Linhas 775 a 835:
775:         par_oPagina.AddObject("obj_4c_OpSituacao", "OptionGroup")
776:         WITH par_oPagina.obj_4c_OpSituacao
777:             .ButtonCount   = 3
778:             .Top           = 222
779:             .Left          = 257
780:             .Width         = 251
781:             .Height        = 24
782:             .BackStyle     = 0
783:             .BorderStyle   = 1
784:             .SpecialEffect = 1
785:             .Themes        = .F.
786:             .Value         = 3
787:             .Visible       = .T.
788:         ENDWITH
789:         WITH par_oPagina.obj_4c_OpSituacao.Buttons(1)
790:             .Caption   = "Pagos"
791:             .Left      = 3
792:             .Top       = 5
793:             .AutoSize  = .T.
794:             .BackStyle = 0
795:             .FontName  = "Tahoma"
796:             .FontSize  = 8
797:             .ForeColor = RGB(90, 90, 90)
798:             .Themes    = .F.
799:         ENDWITH
800:         WITH par_oPagina.obj_4c_OpSituacao.Buttons(2)
801:             .Caption   = "N" + CHR(227) + "o Pagos"
802:             .Left      = 63
803:             .Top       = 5
804:             .AutoSize  = .T.
805:             .BackStyle = 0
806:             .FontName  = "Tahoma"
807:             .FontSize  = 8
808:             .ForeColor = RGB(90, 90, 90)
809:             .Themes    = .F.
810:         ENDWITH
811:         WITH par_oPagina.obj_4c_OpSituacao.Buttons(3)
812:             .Caption   = "Todos"
813:             .Left      = 136
814:             .Top       = 5
815:             .Width     = 47
816:             .Height    = 15
817:             .AutoSize  = .T.
818:             .BackStyle = 0
819:             .FontName  = "Tahoma"
820:             .FontSize  = 8
821:             .ForeColor = RGB(90, 90, 90)
822:             .Themes    = .F.
823:         ENDWITH
824: 
825:         *-- Mercadoria (crSigCdTom.TpMercs - optTpMercs - 3 opcoes)
826:         par_oPagina.AddObject("lbl_4c_Label8", "Label")
827:         WITH par_oPagina.lbl_4c_Label8
828:             .Caption   = "Mercadoria :"
829:             .Top       = 255
830:             .Left      = 190
831:             .Width     = 62
832:             .Height    = 15
833:             .FontName  = "Tahoma"
834:             .FontSize  = 8
835:             .BackStyle = 0

*-- Linhas 841 a 901:
841:         par_oPagina.AddObject("obj_4c_OptTpMercs", "OptionGroup")
842:         WITH par_oPagina.obj_4c_OptTpMercs
843:             .ButtonCount   = 3
844:             .Top           = 251
845:             .Left          = 257
846:             .Width         = 251
847:             .Height        = 24
848:             .BackStyle     = 0
849:             .BorderStyle   = 1
850:             .SpecialEffect = 1
851:             .Themes        = .F.
852:             .Value         = 1
853:             .Visible       = .T.
854:         ENDWITH
855:         WITH par_oPagina.obj_4c_OptTpMercs.Buttons(1)
856:             .Caption   = "Nenhuma"
857:             .Left      = 3
858:             .Top       = 5
859:             .AutoSize  = .T.
860:             .BackStyle = 0
861:             .FontName  = "Tahoma"
862:             .FontSize  = 8
863:             .ForeColor = RGB(90, 90, 90)
864:             .Themes    = .F.
865:         ENDWITH
866:         WITH par_oPagina.obj_4c_OptTpMercs.Buttons(2)
867:             .Caption   = "Separada"
868:             .Left      = 68
869:             .Top       = 5
870:             .AutoSize  = .T.
871:             .BackStyle = 0
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .ForeColor = RGB(90, 90, 90)
875:             .Themes    = .F.
876:         ENDWITH
877:         WITH par_oPagina.obj_4c_OptTpMercs.Buttons(3)
878:             .Caption   = "N" + CHR(227) + "o Separada"
879:             .Left      = 135
880:             .Top       = 5
881:             .Width     = 86
882:             .Height    = 15
883:             .AutoSize  = .T.
884:             .BackStyle = 0
885:             .FontName  = "Tahoma"
886:             .FontSize  = 8
887:             .ForeColor = RGB(90, 90, 90)
888:             .Themes    = .F.
889:         ENDWITH
890: 
891:         *-- Cancelamento de Pedido (crSigCdTom.cancPeds - ObjCancPdv - 3 opcoes)
892:         par_oPagina.AddObject("lbl_4c_Label3", "Label")
893:         WITH par_oPagina.lbl_4c_Label3
894:             .Caption   = "Cancelamento de Pedido :"
895:             .Top       = 283
896:             .Left      = 125
897:             .Width     = 127
898:             .Height    = 15
899:             .FontName  = "Tahoma"
900:             .FontSize  = 8
901:             .BackStyle = 0

*-- Linhas 907 a 967:
907:         par_oPagina.AddObject("obj_4c_ObjCancPdv", "OptionGroup")
908:         WITH par_oPagina.obj_4c_ObjCancPdv
909:             .ButtonCount   = 3
910:             .Top           = 280
911:             .Left          = 257
912:             .Width         = 249
913:             .Height        = 24
914:             .BackStyle     = 0
915:             .BorderStyle   = 1
916:             .SpecialEffect = 1
917:             .Themes        = .F.
918:             .Value         = 1
919:             .Visible       = .T.
920:         ENDWITH
921:         WITH par_oPagina.obj_4c_ObjCancPdv.Buttons(1)
922:             .Caption   = "Sim"
923:             .Left      = 3
924:             .Top       = 4
925:             .AutoSize  = .T.
926:             .BackStyle = 0
927:             .FontName  = "Tahoma"
928:             .FontSize  = 8
929:             .ForeColor = RGB(90, 90, 90)
930:             .Themes    = .F.
931:         ENDWITH
932:         WITH par_oPagina.obj_4c_ObjCancPdv.Buttons(2)
933:             .Caption   = "N" + CHR(227) + "o"
934:             .Left      = 63
935:             .Top       = 4
936:             .AutoSize  = .T.
937:             .BackStyle = 0
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .ForeColor = RGB(90, 90, 90)
941:             .Themes    = .F.
942:         ENDWITH
943:         WITH par_oPagina.obj_4c_ObjCancPdv.Buttons(3)
944:             .Caption   = "Excluir Opera" + CHR(231) + CHR(227) + "o"
945:             .Left      = 120
946:             .Top       = 4
947:             .Width     = 99
948:             .Height    = 15
949:             .AutoSize  = .T.
950:             .BackStyle = 0
951:             .FontName  = "Tahoma"
952:             .FontSize  = 8
953:             .ForeColor = RGB(90, 90, 90)
954:             .Themes    = .F.
955:         ENDWITH
956: 
957:         *-- Tipo de Operacao (crSigCdTom.TpGdmis - fwoption1 - Soma/Subtrai)
958:         par_oPagina.AddObject("lbl_4c_Label4", "Label")
959:         WITH par_oPagina.lbl_4c_Label4
960:             .Caption   = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
961:             .Top       = 312
962:             .Left      = 158
963:             .Width     = 94
964:             .Height    = 15
965:             .FontName  = "Tahoma"
966:             .FontSize  = 8
967:             .BackStyle = 0

*-- Linhas 973 a 1018:
973:         par_oPagina.AddObject("obj_4c_Fwoption1", "OptionGroup")
974:         WITH par_oPagina.obj_4c_Fwoption1
975:             .ButtonCount   = 2
976:             .Top           = 309
977:             .Left          = 257
978:             .Width         = 125
979:             .Height        = 24
980:             .BackStyle     = 0
981:             .BorderStyle   = 1
982:             .SpecialEffect = 1
983:             .Themes        = .F.
984:             .Value         = 1
985:             .Visible       = .T.
986:         ENDWITH
987:         WITH par_oPagina.obj_4c_Fwoption1.Buttons(1)
988:             .Caption   = "Soma"
989:             .Left      = 3
990:             .Top       = 4
991:             .AutoSize  = .T.
992:             .BackStyle = 0
993:             .FontSize  = 8
994:             .ForeColor = RGB(90, 90, 90)
995:             .Themes    = .F.
996:         ENDWITH
997:         WITH par_oPagina.obj_4c_Fwoption1.Buttons(2)
998:             .Caption   = "Subtrai"
999:             .Left      = 63
1000:             .Top       = 4
1001:             .AutoSize  = .T.
1002:             .BackStyle = 0
1003:             .FontSize  = 8
1004:             .ForeColor = RGB(90, 90, 90)
1005:             .Themes    = .F.
1006:         ENDWITH
1007: 
1008:         *-- Atualiza Data/Valor Ult Compra (crSigCdTom.AtuCompras - fwoption3 - Sim/Nao/Peso-Custo)
1009:         par_oPagina.AddObject("lbl_4c_Say1", "Label")
1010:         WITH par_oPagina.lbl_4c_Say1
1011:             .Caption   = "Atualiza Data/Valor Ult Compra :"
1012:             .Top       = 312
1013:             .Left      = 422
1014:             .Width     = 157
1015:             .Height    = 15
1016:             .FontName  = "Tahoma"
1017:             .FontSize  = 8
1018:             .Alignment = 1

*-- Linhas 1025 a 1084:
1025:         par_oPagina.AddObject("obj_4c_Fwoption3", "OptionGroup")
1026:         WITH par_oPagina.obj_4c_Fwoption3
1027:             .ButtonCount   = 3
1028:             .Top           = 309
1029:             .Left          = 584
1030:             .Width         = 201
1031:             .Height        = 24
1032:             .BackStyle     = 0
1033:             .BorderStyle   = 1
1034:             .SpecialEffect = 1
1035:             .Themes        = .F.
1036:             .Value         = 1
1037:             .Visible       = .T.
1038:         ENDWITH
1039:         WITH par_oPagina.obj_4c_Fwoption3.Buttons(1)
1040:             .Caption   = "Sim"
1041:             .Left      = 3
1042:             .Top       = 4
1043:             .AutoSize  = .T.
1044:             .BackStyle = 0
1045:             .FontName  = "Tahoma"
1046:             .FontSize  = 8
1047:             .ForeColor = RGB(90, 90, 90)
1048:             .Themes    = .F.
1049:         ENDWITH
1050:         WITH par_oPagina.obj_4c_Fwoption3.Buttons(2)
1051:             .Caption   = "N" + CHR(227) + "o"
1052:             .Left      = 55
1053:             .Top       = 4
1054:             .AutoSize  = .T.
1055:             .BackStyle = 0
1056:             .FontName  = "Tahoma"
1057:             .FontSize  = 8
1058:             .ForeColor = RGB(90, 90, 90)
1059:             .Themes    = .F.
1060:         ENDWITH
1061:         WITH par_oPagina.obj_4c_Fwoption3.Buttons(3)
1062:             .Caption   = "Peso/Custo"
1063:             .Left      = 107
1064:             .Top       = 3
1065:             .Width     = 84
1066:             .Height    = 17
1067:             .BackStyle = 0
1068:             .FontName  = "Tahoma"
1069:             .FontSize  = 8
1070:             .ForeColor = RGB(90, 90, 90)
1071:             .Themes    = .F.
1072:         ENDWITH
1073: 
1074:         *-- Buscar Valor Total Pelo Notas (crSigCdTom.OpVlUnis - fwoption2 - Sim/Nao)
1075:         par_oPagina.AddObject("lbl_4c_Say2", "Label")
1076:         WITH par_oPagina.lbl_4c_Say2
1077:             .Caption   = "Buscar Valor Total  Pelo Notas :"
1078:             .Top       = 342
1079:             .Left      = 100
1080:             .Width     = 152
1081:             .Height    = 15
1082:             .FontName  = "Tahoma"
1083:             .FontSize  = 8
1084:             .BackStyle = 0

*-- Linhas 1090 a 1135:
1090:         par_oPagina.AddObject("obj_4c_Fwoption2", "OptionGroup")
1091:         WITH par_oPagina.obj_4c_Fwoption2
1092:             .ButtonCount   = 2
1093:             .Top           = 338
1094:             .Left          = 257
1095:             .Width         = 125
1096:             .Height        = 24
1097:             .BackStyle     = 0
1098:             .BorderStyle   = 1
1099:             .SpecialEffect = 1
1100:             .Themes        = .F.
1101:             .Value         = 1
1102:             .Visible       = .T.
1103:         ENDWITH
1104:         WITH par_oPagina.obj_4c_Fwoption2.Buttons(1)
1105:             .Caption   = "Sim"
1106:             .Left      = 3
1107:             .Top       = 4
1108:             .AutoSize  = .T.
1109:             .BackStyle = 0
1110:             .FontSize  = 8
1111:             .ForeColor = RGB(90, 90, 90)
1112:             .Themes    = .F.
1113:         ENDWITH
1114:         WITH par_oPagina.obj_4c_Fwoption2.Buttons(2)
1115:             .Caption   = "N" + CHR(227) + "o"
1116:             .Left      = 63
1117:             .Top       = 4
1118:             .AutoSize  = .T.
1119:             .BackStyle = 0
1120:             .FontSize  = 8
1121:             .ForeColor = RGB(90, 90, 90)
1122:             .Themes    = .F.
1123:         ENDWITH
1124: 
1125:         *-- Exibe no limites de entregas (crSigCdTom.ExibLims - fwoption4 - Sim/Nao)
1126:         par_oPagina.AddObject("lbl_4c_Say5", "Label")
1127:         WITH par_oPagina.lbl_4c_Say5
1128:             .Caption   = "Exibe no limites de entregas:"
1129:             .Top       = 342
1130:             .Left      = 439
1131:             .Width     = 140
1132:             .Height    = 15
1133:             .FontName  = "Tahoma"
1134:             .FontSize  = 8
1135:             .BackStyle = 0

*-- Linhas 1141 a 1173:
1141:         par_oPagina.AddObject("obj_4c_Fwoption4", "OptionGroup")
1142:         WITH par_oPagina.obj_4c_Fwoption4
1143:             .ButtonCount   = 2
1144:             .Top           = 338
1145:             .Left          = 584
1146:             .Width         = 121
1147:             .Height        = 24
1148:             .BackStyle     = 0
1149:             .BorderStyle   = 1
1150:             .SpecialEffect = 1
1151:             .Themes        = .F.
1152:             .Value         = 1
1153:             .Visible       = .T.
1154:         ENDWITH
1155:         WITH par_oPagina.obj_4c_Fwoption4.Buttons(1)
1156:             .Caption   = "Sim"
1157:             .Left      = 3
1158:             .Top       = 4
1159:             .AutoSize  = .T.
1160:             .BackStyle = 0
1161:             .FontSize  = 8
1162:             .ForeColor = RGB(90, 90, 90)
1163:             .Themes    = .F.
1164:         ENDWITH
1165:         WITH par_oPagina.obj_4c_Fwoption4.Buttons(2)
1166:             .Caption   = "N" + CHR(227) + "o"
1167:             .Left      = 63
1168:             .Top       = 4
1169:             .AutoSize  = .T.
1170:             .BackStyle = 0
1171:             .FontSize  = 8
1172:             .ForeColor = RGB(90, 90, 90)
1173:             .Themes    = .F.

*-- Linhas 1198 a 1210:
1198:     PROTECTED PROCEDURE AdicionarCamposPrincipais2(par_oPagina)
1199: 
1200:         *-- Baixa de Estoque (crSigCdTom.BxVendas - fwoption6 - 2 opcoes)
1201:         par_oPagina.AddObject("lbl_4c_Label9", "Label")
1202:         WITH par_oPagina.lbl_4c_Label9
1203:             .Caption   = "Baixa de Estoque :"
1204:             .Top       = 370
1205:             .Left      = 160
1206:             .Width     = 92
1207:             .Height    = 15
1208:             .FontName  = "Tahoma"
1209:             .FontSize  = 8
1210:             .BackStyle = 0

*-- Linhas 1216 a 1261:
1216:         par_oPagina.AddObject("obj_4c_Fwoption6", "OptionGroup")
1217:         WITH par_oPagina.obj_4c_Fwoption6
1218:             .ButtonCount   = 2
1219:             .Top           = 367
1220:             .Left          = 257
1221:             .Width         = 125
1222:             .Height        = 24
1223:             .BackStyle     = 0
1224:             .BorderStyle   = 1
1225:             .SpecialEffect = 1
1226:             .Themes        = .F.
1227:             .Value         = 1
1228:             .Visible       = .T.
1229:         ENDWITH
1230:         WITH par_oPagina.obj_4c_Fwoption6.Buttons(1)
1231:             .Caption   = "Sim"
1232:             .Left      = 3
1233:             .Top       = 4
1234:             .AutoSize  = .T.
1235:             .BackStyle = 0
1236:             .FontSize  = 8
1237:             .ForeColor = RGB(90, 90, 90)
1238:             .Themes    = .F.
1239:         ENDWITH
1240:         WITH par_oPagina.obj_4c_Fwoption6.Buttons(2)
1241:             .Caption   = "N" + CHR(227) + "o"
1242:             .Left      = 63
1243:             .Top       = 4
1244:             .AutoSize  = .T.
1245:             .BackStyle = 0
1246:             .FontSize  = 8
1247:             .ForeColor = RGB(90, 90, 90)
1248:             .Themes    = .F.
1249:         ENDWITH
1250: 
1251:         *-- Calcular Rel. de Comissao (crSigCdTom.nChkSDFs - fwoption5 - 2 opcoes)
1252:         par_oPagina.AddObject("lbl_4c_Say6", "Label")
1253:         WITH par_oPagina.lbl_4c_Say6
1254:             .Caption   = "Calcular Rel. de Comiss" + CHR(227) + "o :"
1255:             .Top       = 371
1256:             .Left      = 447
1257:             .Width     = 132
1258:             .Height    = 15
1259:             .FontName  = "Tahoma"
1260:             .FontSize  = 8
1261:             .BackStyle = 0

*-- Linhas 1267 a 1313:
1267:         par_oPagina.AddObject("obj_4c_Fwoption5", "OptionGroup")
1268:         WITH par_oPagina.obj_4c_Fwoption5
1269:             .ButtonCount   = 2
1270:             .Top           = 367
1271:             .Left          = 584
1272:             .Width         = 121
1273:             .Height        = 24
1274:             .BackStyle     = 0
1275:             .BorderStyle   = 1
1276:             .SpecialEffect = 1
1277:             .Themes        = .F.
1278:             .Value         = 1
1279:             .ToolTipText   = "Entra no Relat" + CHR(243) + "rio de Comiss" + CHR(227) + "o"
1280:             .Visible       = .T.
1281:         ENDWITH
1282:         WITH par_oPagina.obj_4c_Fwoption5.Buttons(1)
1283:             .Caption   = "Sim"
1284:             .Left      = 3
1285:             .Top       = 4
1286:             .AutoSize  = .T.
1287:             .BackStyle = 0
1288:             .FontSize  = 8
1289:             .ForeColor = RGB(90, 90, 90)
1290:             .Themes    = .F.
1291:         ENDWITH
1292:         WITH par_oPagina.obj_4c_Fwoption5.Buttons(2)
1293:             .Caption   = "N" + CHR(227) + "o"
1294:             .Left      = 63
1295:             .Top       = 4
1296:             .AutoSize  = .T.
1297:             .BackStyle = 0
1298:             .FontSize  = 8
1299:             .ForeColor = RGB(90, 90, 90)
1300:             .Themes    = .F.
1301:         ENDWITH
1302: 
1303:         *-- Marcacao de registro em espera de processamento (crSigCdTom.EntPends - getEntPends - 2 opcoes)
1304:         par_oPagina.AddObject("lbl_4c_Label11", "Label")
1305:         WITH par_oPagina.lbl_4c_Label11
1306:             .Caption   = "Exibir como entrada pendente na consulta gen" + CHR(233) + "rica de produtos :"
1307:             .Top       = 394
1308:             .Left      = 57
1309:             .Width     = 195
1310:             .Height    = 28
1311:             .FontName  = "Tahoma"
1312:             .FontSize  = 8
1313:             .WordWrap  = .T.

*-- Linhas 1321 a 1366:
1321:         par_oPagina.AddObject("obj_4c_GetEntPends", "OptionGroup")
1322:         WITH par_oPagina.obj_4c_GetEntPends
1323:             .ButtonCount   = 2
1324:             .Top           = 396
1325:             .Left          = 257
1326:             .Width         = 125
1327:             .Height        = 24
1328:             .BackStyle     = 0
1329:             .BorderStyle   = 1
1330:             .SpecialEffect = 1
1331:             .Themes        = .F.
1332:             .Value         = 1
1333:             .Visible       = .T.
1334:         ENDWITH
1335:         WITH par_oPagina.obj_4c_GetEntPends.Buttons(1)
1336:             .Caption   = "Sim"
1337:             .Left      = 3
1338:             .Top       = 4
1339:             .AutoSize  = .T.
1340:             .BackStyle = 0
1341:             .FontSize  = 8
1342:             .ForeColor = RGB(90, 90, 90)
1343:             .Themes    = .F.
1344:         ENDWITH
1345:         WITH par_oPagina.obj_4c_GetEntPends.Buttons(2)
1346:             .Caption   = "N" + CHR(227) + "o"
1347:             .Left      = 63
1348:             .Top       = 4
1349:             .AutoSize  = .T.
1350:             .BackStyle = 0
1351:             .FontSize  = 8
1352:             .ForeColor = RGB(90, 90, 90)
1353:             .Themes    = .F.
1354:         ENDWITH
1355: 
1356:         *-- Fluxo de Caixa (crSigCdTom.nFlxCaixa - fwoption7 - 3 opcoes)
1357:         par_oPagina.AddObject("lbl_4c_Say7", "Label")
1358:         WITH par_oPagina.lbl_4c_Say7
1359:             .Caption   = "Fluxo de Caixa :"
1360:             .Top       = 400
1361:             .Left      = 499
1362:             .Width     = 80
1363:             .Height    = 15
1364:             .FontName  = "Tahoma"
1365:             .FontSize  = 8
1366:             .BackStyle = 0

*-- Linhas 1372 a 1432:
1372:         par_oPagina.AddObject("obj_4c_Fwoption7", "OptionGroup")
1373:         WITH par_oPagina.obj_4c_Fwoption7
1374:             .ButtonCount   = 3
1375:             .Top           = 396
1376:             .Left          = 584
1377:             .Width         = 184
1378:             .Height        = 24
1379:             .BackStyle     = 0
1380:             .BorderStyle   = 1
1381:             .SpecialEffect = 1
1382:             .Themes        = .F.
1383:             .Value         = 1
1384:             .Visible       = .T.
1385:         ENDWITH
1386:         WITH par_oPagina.obj_4c_Fwoption7.Buttons(1)
1387:             .Caption   = "Sim"
1388:             .Left      = 3
1389:             .Top       = 4
1390:             .AutoSize  = .T.
1391:             .BackStyle = 0
1392:             .FontName  = "Tahoma"
1393:             .FontSize  = 8
1394:             .ForeColor = RGB(90, 90, 90)
1395:             .Themes    = .F.
1396:         ENDWITH
1397:         WITH par_oPagina.obj_4c_Fwoption7.Buttons(2)
1398:             .Caption   = "Sim-Pago"
1399:             .Left      = 59
1400:             .Top       = 4
1401:             .AutoSize  = .T.
1402:             .BackStyle = 0
1403:             .FontName  = "Tahoma"
1404:             .FontSize  = 8
1405:             .ForeColor = RGB(90, 90, 90)
1406:             .Themes    = .F.
1407:         ENDWITH
1408:         WITH par_oPagina.obj_4c_Fwoption7.Buttons(3)
1409:             .Caption   = "N" + CHR(227) + "o"
1410:             .Left      = 137
1411:             .Top       = 4
1412:             .Width     = 37
1413:             .Height    = 15
1414:             .AutoSize  = .T.
1415:             .BackStyle = 0
1416:             .FontName  = "Tahoma"
1417:             .FontSize  = 8
1418:             .ForeColor = RGB(90, 90, 90)
1419:             .Themes    = .F.
1420:         ENDWITH
1421: 
1422:         *-- Gera CMV (crSigCdTom.GeraCmvs - Fwoption9 - 2 opcoes)
1423:         par_oPagina.AddObject("lbl_4c_Say8", "Label")
1424:         WITH par_oPagina.lbl_4c_Say8
1425:             .Caption   = "Gera CMV :"
1426:             .Top       = 428
1427:             .Left      = 523
1428:             .Width     = 56
1429:             .Height    = 15
1430:             .FontName  = "Tahoma"
1431:             .FontSize  = 8
1432:             .BackStyle = 0

*-- Linhas 1438 a 1496:
1438:         par_oPagina.AddObject("obj_4c_Fwoption9", "OptionGroup")
1439:         WITH par_oPagina.obj_4c_Fwoption9
1440:             .ButtonCount   = 2
1441:             .Top           = 425
1442:             .Left          = 584
1443:             .Width         = 121
1444:             .Height        = 24
1445:             .BackStyle     = 0
1446:             .BorderStyle   = 1
1447:             .SpecialEffect = 1
1448:             .Themes        = .F.
1449:             .Value         = 1
1450:             .Visible       = .T.
1451:         ENDWITH
1452:         WITH par_oPagina.obj_4c_Fwoption9.Buttons(1)
1453:             .Caption   = "Sim"
1454:             .Left      = 3
1455:             .Top       = 4
1456:             .AutoSize  = .T.
1457:             .BackStyle = 0
1458:             .FontSize  = 8
1459:             .ForeColor = RGB(90, 90, 90)
1460:             .Themes    = .F.
1461:         ENDWITH
1462:         WITH par_oPagina.obj_4c_Fwoption9.Buttons(2)
1463:             .Caption   = "N" + CHR(227) + "o"
1464:             .Left      = 63
1465:             .Top       = 4
1466:             .AutoSize  = .T.
1467:             .BackStyle = 0
1468:             .FontSize  = 8
1469:             .ForeColor = RGB(90, 90, 90)
1470:             .Themes    = .F.
1471:         ENDWITH
1472: 
1473:         *-- Linha divisoria acima da secao "Quantidade Maxima de Entregas"
1474:         par_oPagina.AddObject("shp_4c_Shape1", "Shape")
1475:         WITH par_oPagina.shp_4c_Shape1
1476:             .Top           = 461
1477:             .Left          = 54
1478:             .Width         = 652
1479:             .Height        = 2
1480:             .BackStyle     = 0
1481:             .BorderWidth   = 2
1482:             .SpecialEffect = 1
1483:             .Visible       = .T.
1484:         ENDWITH
1485: 
1486:         *-- Quantidade Maxima de Entregas (titulo)
1487:         par_oPagina.AddObject("lbl_4c_Say4", "Label")
1488:         WITH par_oPagina.lbl_4c_Say4
1489:             .Caption   = " Quantidade M" + CHR(225) + "xima de Entregas "
1490:             .Top       = 447
1491:             .Left      = 54
1492:             .Width     = 191
1493:             .Height    = 15
1494:             .FontName  = "Tahoma"
1495:             .FontSize  = 8
1496:             .FontBold  = .T.

*-- Linhas 1502 a 1514:
1502:         ENDWITH
1503: 
1504:         *-- Dias Uteis (crSigCdTom.MaxEnts - getMaxEnts)
1505:         par_oPagina.AddObject("lbl_4c_Label5", "Label")
1506:         WITH par_oPagina.lbl_4c_Label5
1507:             .Caption   = "Dias " + CHR(218) + "teis :"
1508:             .Top       = 471
1509:             .Left      = 161
1510:             .Width     = 56
1511:             .Height    = 15
1512:             .FontName  = "Tahoma"
1513:             .FontSize  = 8
1514:             .Alignment = 1

*-- Linhas 1520 a 1546:
1520: 
1521:         par_oPagina.AddObject("txt_4c_MaxEnts", "TextBox")
1522:         WITH par_oPagina.txt_4c_MaxEnts
1523:             .Top           = 468
1524:             .Left          = 223
1525:             .Width         = 38
1526:             .Height        = 24
1527:             .InputMask     = "9999"
1528:             .Alignment     = 3
1529:             .FontName      = "Courier New"
1530:             .SpecialEffect = 1
1531:             .ForeColor     = RGB(0, 0, 0)
1532:             .Value         = 0
1533:             .Visible       = .T.
1534:         ENDWITH
1535: 
1536:         *-- Sabados (crSigCdTom.MaxEnt2s - getMaxEnt2s)
1537:         par_oPagina.AddObject("lbl_4c_Label6", "Label")
1538:         WITH par_oPagina.lbl_4c_Label6
1539:             .Caption   = "S" + CHR(225) + "bados :"
1540:             .Top       = 471
1541:             .Left      = 297
1542:             .Width     = 50
1543:             .Height    = 15
1544:             .FontName  = "Tahoma"
1545:             .FontSize  = 8
1546:             .Alignment = 1

*-- Linhas 1552 a 1578:
1552: 
1553:         par_oPagina.AddObject("txt_4c_MaxEnt2s", "TextBox")
1554:         WITH par_oPagina.txt_4c_MaxEnt2s
1555:             .Top           = 468
1556:             .Left          = 349
1557:             .Width         = 38
1558:             .Height        = 24
1559:             .InputMask     = "9999"
1560:             .Alignment     = 3
1561:             .FontName      = "Courier New"
1562:             .SpecialEffect = 1
1563:             .ForeColor     = RGB(0, 0, 0)
1564:             .Value         = 0
1565:             .Visible       = .T.
1566:         ENDWITH
1567: 
1568:         *-- Domingos / Feriados (crSigCdTom.MaxEnt3s - getMaxEnt3s)
1569:         par_oPagina.AddObject("lbl_4c_Label7", "Label")
1570:         WITH par_oPagina.lbl_4c_Label7
1571:             .Caption   = "Domigos / Feriados :"
1572:             .Top       = 471
1573:             .Left      = 432
1574:             .Width     = 100
1575:             .Height    = 15
1576:             .FontName  = "Tahoma"
1577:             .FontSize  = 8
1578:             .Alignment = 1

*-- Linhas 1584 a 1593:
1584: 
1585:         par_oPagina.AddObject("txt_4c_MaxEnt3s", "TextBox")
1586:         WITH par_oPagina.txt_4c_MaxEnt3s
1587:             .Top           = 468
1588:             .Left          = 547
1589:             .Width         = 38
1590:             .Height        = 24
1591:             .InputMask     = "9999"
1592:             .Alignment     = 3
1593:             .FontName      = "Courier New"

*-- Linhas 1600 a 1623:
1600:         *-- Linha divisoria acima da secao "Geracao de Reposicao"
1601:         par_oPagina.AddObject("shp_4c_Shape2", "Shape")
1602:         WITH par_oPagina.shp_4c_Shape2
1603:             .Top           = 526
1604:             .Left          = 54
1605:             .Width         = 652
1606:             .Height        = 2
1607:             .BackStyle     = 0
1608:             .BorderWidth   = 2
1609:             .SpecialEffect = 1
1610:             .Visible       = .T.
1611:         ENDWITH
1612: 
1613:         *-- Geracao de Reposicao (titulo)
1614:         par_oPagina.AddObject("lbl_4c_Say3", "Label")
1615:         WITH par_oPagina.lbl_4c_Say3
1616:             .Caption   = " Gera" + CHR(231) + CHR(227) + "o de Reposi" + CHR(231) + CHR(227) + "o "
1617:             .Top       = 512
1618:             .Left      = 54
1619:             .Width     = 133
1620:             .Height    = 15
1621:             .FontName  = "Tahoma"
1622:             .FontSize  = 8
1623:             .FontBold  = .T.

*-- Linhas 1632 a 1741:
1632:         par_oPagina.AddObject("obj_4c_OptReposicaos", "OptionGroup")
1633:         WITH par_oPagina.obj_4c_OptReposicaos
1634:             .ButtonCount   = 8
1635:             .Top           = 514
1636:             .Left          = 54
1637:             .Width         = 506
1638:             .Height        = 62
1639:             .BackStyle     = 0
1640:             .BorderStyle   = 0
1641:             .SpecialEffect = 1
1642:             .Themes        = .F.
1643:             .Value         = 1
1644:             .Visible       = .T.
1645:         ENDWITH
1646:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(1)
1647:             .Caption   = "Nenhum"
1648:             .Left      = 35
1649:             .Top       = 19
1650:             .AutoSize  = .T.
1651:             .BackStyle = 0
1652:             .FontName  = "Tahoma"
1653:             .FontSize  = 8
1654:             .ForeColor = RGB(90, 90, 90)
1655:             .Themes    = .F.
1656:         ENDWITH
1657:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(2)
1658:             .Caption   = "Solicitado"
1659:             .Left      = 150
1660:             .Top       = 19
1661:             .AutoSize  = .T.
1662:             .BackStyle = 0
1663:             .FontName  = "Tahoma"
1664:             .FontSize  = 8
1665:             .ForeColor = RGB(90, 90, 90)
1666:             .Themes    = .F.
1667:         ENDWITH
1668:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(3)
1669:             .Caption   = "Tr" + CHR(226) + "nsito"
1670:             .Left      = 282
1671:             .Top       = 19
1672:             .Width     = 57
1673:             .Height    = 15
1674:             .AutoSize  = .T.
1675:             .BackStyle = 0
1676:             .FontName  = "Tahoma"
1677:             .FontSize  = 8
1678:             .ForeColor = RGB(90, 90, 90)
1679:             .Themes    = .F.
1680:         ENDWITH
1681:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(4)
1682:             .Caption   = "Pedido Geral"
1683:             .Left      = 382
1684:             .Top       = 19
1685:             .Width     = 78
1686:             .Height    = 15
1687:             .AutoSize  = .T.
1688:             .BackStyle = 0
1689:             .FontName  = "Tahoma"
1690:             .FontSize  = 8
1691:             .ForeColor = RGB(90, 90, 90)
1692:             .Themes    = .F.
1693:         ENDWITH
1694:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(5)
1695:             .Caption   = "Pedido Empresa"
1696:             .Left      = 35
1697:             .Top       = 39
1698:             .Width     = 94
1699:             .Height    = 15
1700:             .AutoSize  = .T.
1701:             .BackStyle = 0
1702:             .FontName  = "Tahoma"
1703:             .FontSize  = 8
1704:             .ForeColor = RGB(90, 90, 90)
1705:             .Themes    = .F.
1706:         ENDWITH
1707:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(6)
1708:             .Caption   = "Pedido de Compra"
1709:             .Left      = 150
1710:             .Top       = 39
1711:             .Width     = 105
1712:             .Height    = 15
1713:             .AutoSize  = .T.
1714:             .BackStyle = 0
1715:             .FontName  = "Tahoma"
1716:             .FontSize  = 8
1717:             .ForeColor = RGB(90, 90, 90)
1718:             .Themes    = .F.
1719:         ENDWITH
1720:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(7)
1721:             .Caption   = "Entrada"
1722:             .Left      = 282
1723:             .Top       = 39
1724:             .Width     = 56
1725:             .Height    = 15
1726:             .AutoSize  = .T.
1727:             .BackStyle = 0
1728:             .FontName  = "Tahoma"
1729:             .FontSize  = 8
1730:             .ForeColor = RGB(90, 90, 90)
1731:             .Themes    = .F.
1732:         ENDWITH
1733:         WITH par_oPagina.obj_4c_OptReposicaos.Buttons(8)
1734:             .Caption   = "Sa" + CHR(237) + "da"
1735:             .Left      = 382
1736:             .Top       = 39
1737:             .Width     = 44
1738:             .Height    = 15
1739:             .AutoSize  = .T.
1740:             .BackStyle = 0
1741:             .FontName  = "Tahoma"

*-- Linhas 1794 a 1803:
1794:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1795: 
1796:                     *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
1797:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1798:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1799: 
1800:                     loc_oGrid.Column1.Width     = 120
1801:                     loc_oGrid.Column1.Alignment = 1
1802:                     loc_oGrid.Column2.Width     = 770
1803:                     loc_oGrid.Column2.Alignment = 0

*-- Linhas 1936 a 1963:
1936:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1937: 
1938:         WITH THIS.this_oBusinessObject
1939:             loc_oPg2.txt_4c_Codigos.Value       = .this_nCodigos
1940:             loc_oPg2.txt_4c_Descrs.Value        = .this_cDescrs
1941:             loc_oPg2.obj_4c_OpGdmi.Value        = .this_nGergdmis
1942:             loc_oPg2.obj_4c_Fwoption8.Value     = .this_nGerVds
1943:             loc_oPg2.obj_4c_OpSituacao.Value    = .this_nFlagpgs
1944:             loc_oPg2.obj_4c_OptTpMercs.Value    = .this_nTpMercs
1945:             loc_oPg2.obj_4c_ObjCancPdv.Value    = .this_nCancPeds
1946:             loc_oPg2.obj_4c_Fwoption1.Value     = .this_nTpGdmis
1947:             loc_oPg2.obj_4c_Fwoption3.Value     = .this_nAtuCompras
1948:             loc_oPg2.obj_4c_Fwoption2.Value     = .this_nOpVlUnis
1949:             loc_oPg2.obj_4c_Fwoption4.Value     = .this_nExibLims
1950:             loc_oPg2.obj_4c_Fwoption6.Value     = .this_nBxVendas
1951:             loc_oPg2.obj_4c_Fwoption5.Value     = .this_nChkSDFs
1952:             loc_oPg2.obj_4c_GetEntPends.Value   = .this_nEntPends
1953:             loc_oPg2.obj_4c_Fwoption7.Value     = .this_nFlxCaixa
1954:             loc_oPg2.obj_4c_Fwoption9.Value     = .this_nGeraCmvs
1955:             loc_oPg2.obj_4c_OptReposicaos.Value = .this_nReposicaos
1956:             loc_oPg2.txt_4c_MaxEnts.Value       = .this_nMaxEnts
1957:             loc_oPg2.txt_4c_MaxEnt2s.Value      = .this_nMaxEnt2s
1958:             loc_oPg2.txt_4c_MaxEnt3s.Value      = .this_nMaxEnt3s
1959:         ENDWITH
1960:     ENDPROC
1961: 
1962:     *===========================================================================
1963:     * FormParaBO - Transfere os controles da Page2 para as propriedades do TopBO

*-- Linhas 2004 a 2017:
2004:         loc_lLista = (THIS.this_cModoAtual = "LISTA")
2005: 
2006:         TRY
2007:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lLista
2008:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lLista
2009:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lLista
2010:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lLista
2011:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lLista
2012:             loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lLista
2013:         CATCH TO loException
2014:             MostrarErro("Erro em FormTop.AjustarBotoesPorModo:" + CHR(13) + loException.Message, "Erro")
2015:         ENDTRY
2016:     ENDPROC
2017: 

*-- Linhas 2233 a 2242:
2233:         loc_oPg2.txt_4c_MaxEnt3s.Enabled      = loc_lEditavel
2234: 
2235:         *-- Confirmar so fica habilitado quando ha algo para gravar (INCLUIR/ALTERAR)
2236:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditavel OR (THIS.this_cModoAtual = "EXCLUIR")
2237:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2238:     ENDPROC
2239: 
2240:     *===========================================================================
2241:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2242:     * REGRA: Chamar SEMPRE com parametro: THIS.TornarControlesVisiveis(loc_oPagina)


### BO (C:\4c\projeto\app\classes\TopBO.prg):
*====================================================================
* TopBO.prg
*
* Business Object para Top (Tipos de Operacoes)
* Tabela: SigCdTom
*
* FASE 1/8: Propriedades e Init
*====================================================================

DEFINE CLASS TopBO AS BusinessBase

    *-- Propriedades da entidade (colunas de SigCdTom)
    this_nCodigos    = 0     && codigos      numeric(2,0)  NOT NULL - PK
    this_cDescrs     = ""    && descrs       char(30)      NOT NULL
    this_lLalts      = .F.   && lalts        bit           NOT NULL - registro automatico (nao editavel na tela)
    this_nFlagpgs    = 0     && flagpgs      numeric(1,0)  NOT NULL - Situacao (Pagos/Nao Pagos/Todos)
    this_nGergdmis   = 0     && gergdmis     numeric(1,0)  NOT NULL - Gravacao de Movimentacao
    this_nCancPeds   = 0     && cancpeds     numeric(1,0)  NOT NULL - Cancelamento de Pedido
    this_nTpGdmis    = 0     && tpgdmis      numeric(1,0)  NOT NULL - Tipo Gravacao Movimentacao (Soma/Subtrai)
    this_nOpVlUnis   = 0     && opvlunis     numeric(1,0)  NOT NULL - Atualiza Data/Valor Ult Compra
    this_nAtuCompras = 0     && atucompras   numeric(1,0)  NOT NULL - Atualiza Compras (Sim/Nao/Peso-Custo)
    this_nReposicaos = 0     && reposicaos   numeric(1,0)  NOT NULL - Geracao de Reposicao
    this_nMaxEnts    = 0     && maxents      numeric(4,0)  NOT NULL - Qtde Max Entregas (Dias Uteis)
    this_nExibLims   = 0     && exiblims     numeric(1,0)  NOT NULL - Exibe no limites de entregas
    this_nMaxEnt2s   = 0     && maxent2s     numeric(4,0)  NOT NULL - Qtde Max Entregas (Sabados)
    this_nMaxEnt3s   = 0     && maxent3s     numeric(4,0)  NOT NULL - Qtde Max Entregas (Domingos/Feriados)
    this_nBxVendas   = 0     && bxvendas     numeric(1,0)  NOT NULL - Baixa de Estoque
    this_nChkSDFs    = 0     && nchksdfs     numeric(1,0)  NOT NULL - Calcular Rel. de Comissao
    this_nTpMercs    = 0     && tpmercs      numeric(1,0)  NOT NULL - Mercadoria (Nenhuma/Separada/Nao Separada)
    this_nFlxCaixa   = 0     && nflxcaixa    numeric(1,0)  NOT NULL - Fluxo de Caixa
    this_nEntPends   = 0     && entpends     numeric(1,0)  NOT NULL - Exibir como entrada pendente
    this_nGerVds     = 0     && gervds       numeric(1,0)  NOT NULL - Vendedor (Propria Operacao/SubNivel)
    this_nGeraCmvs   = 0     && geracmvs     numeric(1,0)  NOT NULL - Gera CMV
    this_nOpIgnRelFc = 0     && opignrelfc   numeric(1,0)  NOT NULL - nao exibido no form, mas existe na tabela

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = "SigCdTom"
        THIS.this_cCampoChave = "Codigos"

        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria (codigos) para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

    *====================================================================
    * InicializarValoresPadrao - Valores default ao iniciar novo registro
    * Legado (Click): Replace CrSigCdTom.lAlts with .t. quando pcEscolha='INSERIR'
    * lAlts = .T. marca o registro como alteravel/exclusivo do usuario (nao
    * automatico do sistema) - todo registro incluido manualmente nasce assim.
    *====================================================================
    PROTECTED PROCEDURE InicializarValoresPadrao()
        THIS.this_lLalts = .T.
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_nCodigos    = TratarNulo(codigos,    "N")
                THIS.this_cDescrs     = TratarNulo(descrs,     "C")
                THIS.this_lLalts      = ConverterParaLogico(lalts)
                THIS.this_nFlagpgs    = TratarNulo(flagpgs,    "N")
                THIS.this_nGergdmis   = TratarNulo(gergdmis,   "N")
                THIS.this_nCancPeds   = TratarNulo(cancpeds,   "N")
                THIS.this_nTpGdmis    = TratarNulo(tpgdmis,    "N")
                THIS.this_nOpVlUnis   = TratarNulo(opvlunis,   "N")
                THIS.this_nAtuCompras = TratarNulo(atucompras, "N")
                THIS.this_nReposicaos = TratarNulo(reposicaos, "N")
                THIS.this_nMaxEnts    = TratarNulo(maxents,    "N")
                THIS.this_nExibLims   = TratarNulo(exiblims,   "N")
                THIS.this_nMaxEnt2s   = TratarNulo(maxent2s,   "N")
                THIS.this_nMaxEnt3s   = TratarNulo(maxent3s,   "N")
                THIS.this_nBxVendas   = TratarNulo(bxvendas,   "N")
                THIS.this_nChkSDFs    = TratarNulo(nchksdfs,   "N")
                THIS.this_nTpMercs    = TratarNulo(tpmercs,    "N")
                THIS.this_nFlxCaixa   = TratarNulo(nflxcaixa,  "N")
                THIS.this_nEntPends   = TratarNulo(entpends,   "N")
                THIS.this_nGerVds     = TratarNulo(gervds,     "N")
                THIS.this_nGeraCmvs   = TratarNulo(geracmvs,   "N")
                THIS.this_nOpIgnRelFc = TratarNulo(opignrelfc, "N")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT na tabela SigCdTom
    * Todas as colunas sao NOT NULL - nenhuma pode ficar de fora do INSERT
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdTom (codigos, descrs, lalts, flagpgs, gergdmis," + ;
                       " cancpeds, tpgdmis, opvlunis, atucompras, reposicaos," + ;
                       " maxents, exiblims, maxent2s, maxent3s, bxvendas," + ;
                       " nchksdfs, tpmercs, nflxcaixa, entpends, gervds," + ;
                       " geracmvs, opignrelfc)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos, 0) + "," + ;
                       EscaparSQL(THIS.this_cDescrs) + "," + ;
                       FormatarNumeroSQL(IIF(THIS.this_lLalts, 1, 0), 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFlagpgs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGergdmis, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nCancPeds, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpGdmis, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpVlUnis, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nAtuCompras, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nReposicaos, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaxEnts, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nExibLims, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaxEnt2s, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nMaxEnt3s, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nBxVendas, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nChkSDFs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTpMercs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFlxCaixa, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nEntPends, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGerVds, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nGeraCmvs, 0) + "," + ;
                       FormatarNumeroSQL(THIS.this_nOpIgnRelFc, 0) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE na tabela SigCdTom
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdTom SET" + ;
                       " descrs = "     + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       " lalts = "      + FormatarNumeroSQL(IIF(THIS.this_lLalts, 1, 0), 0) + "," + ;
                       " flagpgs = "    + FormatarNumeroSQL(THIS.this_nFlagpgs, 0) + "," + ;
                       " gergdmis = "   + FormatarNumeroSQL(THIS.this_nGergdmis, 0) + "," + ;
                       " cancpeds = "   + FormatarNumeroSQL(THIS.this_nCancPeds, 0) + "," + ;
                       " tpgdmis = "    + FormatarNumeroSQL(THIS.this_nTpGdmis, 0) + "," + ;
                       " opvlunis = "   + FormatarNumeroSQL(THIS.this_nOpVlUnis, 0) + "," + ;
                       " atucompras = " + FormatarNumeroSQL(THIS.this_nAtuCompras, 0) + "," + ;
                       " reposicaos = " + FormatarNumeroSQL(THIS.this_nReposicaos, 0) + "," + ;
                       " maxents = "    + FormatarNumeroSQL(THIS.this_nMaxEnts, 0) + "," + ;
                       " exiblims = "   + FormatarNumeroSQL(THIS.this_nExibLims, 0) + "," + ;
                       " maxent2s = "   + FormatarNumeroSQL(THIS.this_nMaxEnt2s, 0) + "," + ;
                       " maxent3s = "   + FormatarNumeroSQL(THIS.this_nMaxEnt3s, 0) + "," + ;
                       " bxvendas = "   + FormatarNumeroSQL(THIS.this_nBxVendas, 0) + "," + ;
                       " nchksdfs = "   + FormatarNumeroSQL(THIS.this_nChkSDFs, 0) + "," + ;
                       " tpmercs = "    + FormatarNumeroSQL(THIS.this_nTpMercs, 0) + "," + ;
                       " nflxcaixa = "  + FormatarNumeroSQL(THIS.this_nFlxCaixa, 0) + "," + ;
                       " entpends = "   + FormatarNumeroSQL(THIS.this_nEntPends, 0) + "," + ;
                       " gervds = "     + FormatarNumeroSQL(THIS.this_nGerVds, 0) + "," + ;
                       " geracmvs = "   + FormatarNumeroSQL(THIS.this_nGeraCmvs, 0) + "," + ;
                       " opignrelfc = " + FormatarNumeroSQL(THIS.this_nOpIgnRelFc, 0) + ;
                       " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE da tabela SigCdTom
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdTom WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Carrega lista de tipos de operacoes no cursor_4c_Dados
    * par_cFiltro: se numerico/preenchido, filtra por codigos exato
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, lalts, flagpgs, gergdmis," + ;
                       " cancpeds, tpgdmis, opvlunis, atucompras, reposicaos," + ;
                       " maxents, exiblims, maxent2s, maxent3s, bxvendas," + ;
                       " nchksdfs, tpmercs, nflxcaixa, entpends, gervds," + ;
                       " geracmvs, opignrelfc" + ;
                       " FROM SigCdTom"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro)), 0)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar tipos de opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, lalts, flagpgs, gergdmis," + ;
                       " cancpeds, tpgdmis, opvlunis, atucompras, reposicaos," + ;
                       " maxents, exiblims, maxent2s, maxent3s, bxvendas," + ;
                       " nchksdfs, tpmercs, nflxcaixa, entpends, gervds," + ;
                       " geracmvs, opignrelfc" + ;
                       " FROM SigCdTom" + ;
                       " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo, 0)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar tipo de opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

