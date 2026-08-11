# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 183: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 415: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 440: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (888 linhas total):

*-- Linhas 79 a 101:
79: 	PROTECTED PROCEDURE ConfigurarPageFrame()
80: 		THIS.AddObject("pgf_4c_Paginas", "PageFrame")
81: 
82: 		THIS.pgf_4c_Paginas.Top       = -29
83: 		THIS.pgf_4c_Paginas.Left      = 0
84: 		THIS.pgf_4c_Paginas.Width     = THIS.Width
85: 		THIS.pgf_4c_Paginas.Height    = THIS.Height + 29
86: 		THIS.pgf_4c_Paginas.Tabs      = .F.
87: 		THIS.pgf_4c_Paginas.PageCount = 2
88: 		THIS.pgf_4c_Paginas.Visible   = .T.
89: 
90: 		*-- Page1: Lista
91: 		THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
92: 		THIS.pgf_4c_Paginas.Page1.BackColor = RGB(160, 160, 160)
93: 		THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
94: 
95: 		*-- Page2: Dados
96: 		THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
97: 		THIS.pgf_4c_Paginas.Page2.BackColor = RGB(160, 160, 160)
98: 		THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
99: 
100: 		THIS.ConfigurarPaginaLista()
101: 		THIS.ConfigurarPaginaDados()

*-- Linhas 117 a 154:
117: 		*-- Container cabe" + CHR(231) + "alho (cntSombra: Top=1+29=30)
118: 		loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119: 		WITH loc_oPagina.cnt_4c_Cabecalho
120: 			.Top         = 30
121: 			.Left        = 0
122: 			.Width       = THIS.Width
123: 			.Height      = 80
124: 			.BackColor   = RGB(100, 100, 100)
125: 			.BorderWidth = 0
126: 			.Visible     = .T.
127: 		ENDWITH
128: 
129: 		loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
130: 		WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
131: 			.Caption   = THIS.Caption
132: 			.Top       = 15
133: 			.Left      = 10
134: 			.Width     = 769
135: 			.Height    = 40
136: 			.AutoSize  = .F.
137: 			.FontName  = "Tahoma"
138: 			.FontSize  = 16
139: 			.FontBold  = .T.
140: 			.ForeColor = RGB(0, 0, 0)
141: 			.BackStyle = 0
142: 			.Visible   = .T.
143: 		ENDWITH
144: 
145: 		loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
146: 		WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
147: 			.Caption   = THIS.Caption
148: 			.Top       = 18
149: 			.Left      = 10
150: 			.Width     = 769
151: 			.Height    = 46
152: 			.AutoSize  = .F.
153: 			.FontName  = "Tahoma"
154: 			.FontSize  = 16

*-- Linhas 161 a 349:
161: 		*-- Container bot" + CHR(245) + "es CRUD (canonical Left=542, Top=28)
162: 		loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163: 		WITH loc_oPagina.cnt_4c_Botoes
164: 			.Top         = 28
165: 			.Left        = 542
166: 			.Width       = 390
167: 			.Height      = 85
168: 			.BackStyle = 0
169: 			.BorderWidth = 0
170: 			.Visible     = .T.
171: 		ENDWITH
172: 
173: 		*-- Bot" + CHR(227) + "o Incluir
174: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
175: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
176: 			.Caption         = "Incluir"
177: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178: 			.PicturePosition = 13
179: 			.Top             = 5
180: 			.Left            = 5
181: 			.Width           = 75
182: 			.Height          = 75
183: 			.FontName        = "Comic Sans MS"
184: 			.FontSize        = 8
185: 			.FontBold        = .T.
186: 			.FontItalic      = .T.
187: 			.ForeColor       = RGB(90, 90, 90)
188: 			.BackColor       = RGB(255, 255, 255)
189: 			.Themes          = .F.
190: 			.SpecialEffect   = 0
191: 			.MousePointer    = 15
192: 			.WordWrap        = .T.
193: 			.AutoSize        = .F.
194: 			.Visible         = .T.
195: 		ENDWITH
196: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198: 		*-- Bot" + CHR(227) + "o Visualizar
199: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
201: 			.Caption         = "Visualizar"
202: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203: 			.PicturePosition = 13
204: 			.Top             = 5
205: 			.Left            = 80
206: 			.Width           = 75
207: 			.Height          = 75
208: 			.FontName        = "Comic Sans MS"
209: 			.FontSize        = 8
210: 			.FontBold        = .T.
211: 			.FontItalic      = .T.
212: 			.ForeColor       = RGB(90, 90, 90)
213: 			.BackColor       = RGB(255, 255, 255)
214: 			.Themes          = .F.
215: 			.SpecialEffect   = 0
216: 			.MousePointer    = 15
217: 			.WordWrap        = .T.
218: 			.AutoSize        = .F.
219: 			.Visible         = .T.
220: 		ENDWITH
221: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
222: 
223: 		*-- Bot" + CHR(227) + "o Alterar
224: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
225: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
226: 			.Caption         = "Alterar"
227: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228: 			.PicturePosition = 13
229: 			.Top             = 5
230: 			.Left            = 155
231: 			.Width           = 75
232: 			.Height          = 75
233: 			.FontName        = "Comic Sans MS"
234: 			.FontSize        = 8
235: 			.FontBold        = .T.
236: 			.FontItalic      = .T.
237: 			.ForeColor       = RGB(90, 90, 90)
238: 			.BackColor       = RGB(255, 255, 255)
239: 			.Themes          = .F.
240: 			.SpecialEffect   = 0
241: 			.MousePointer    = 15
242: 			.WordWrap        = .T.
243: 			.AutoSize        = .F.
244: 			.Visible         = .T.
245: 		ENDWITH
246: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248: 		*-- Bot" + CHR(227) + "o Excluir
249: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
250: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
251: 			.Caption         = "Excluir"
252: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253: 			.PicturePosition = 13
254: 			.Top             = 5
255: 			.Left            = 230
256: 			.Width           = 75
257: 			.Height          = 75
258: 			.FontName        = "Comic Sans MS"
259: 			.FontSize        = 8
260: 			.FontBold        = .T.
261: 			.FontItalic      = .T.
262: 			.ForeColor       = RGB(90, 90, 90)
263: 			.BackColor       = RGB(255, 255, 255)
264: 			.Themes          = .F.
265: 			.SpecialEffect   = 0
266: 			.MousePointer    = 15
267: 			.WordWrap        = .T.
268: 			.AutoSize        = .F.
269: 			.Visible         = .T.
270: 		ENDWITH
271: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
272: 
273: 		*-- Bot" + CHR(227) + "o Buscar
274: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
275: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
276: 			.Caption         = "Buscar"
277: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
278: 			.PicturePosition = 13
279: 			.Top             = 5
280: 			.Left            = 305
281: 			.Width           = 75
282: 			.Height          = 75
283: 			.FontName        = "Comic Sans MS"
284: 			.FontSize        = 8
285: 			.FontBold        = .T.
286: 			.FontItalic      = .T.
287: 			.ForeColor       = RGB(90, 90, 90)
288: 			.BackColor       = RGB(255, 255, 255)
289: 			.Themes          = .F.
290: 			.SpecialEffect   = 0
291: 			.MousePointer    = 15
292: 			.WordWrap        = .T.
293: 			.AutoSize        = .F.
294: 			.Visible         = .T.
295: 		ENDWITH
296: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298: 		*-- Container sa" + CHR(237) + "da - valores can" + CHR(244) + "nicos (CLAUDE.md Regra #10)
299: 		loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300: 		WITH loc_oPagina.cnt_4c_Saida
301: 			.Top         = 28
302: 			.Left        = 917
303: 			.Width       = 90
304: 			.Height      = 85
305: 			.BackStyle   = 0
306: 			.BorderWidth = 0
307: 			.Visible     = .T.
308: 		ENDWITH
309: 
310: 		*-- Bot" + CHR(227) + "o Encerrar (can" + CHR(244) + "nico)
311: 		loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312: 		WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313: 			.Caption         = "Encerrar"
314: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315: 			.PicturePosition = 13
316: 			.Top             = 5
317: 			.Left            = 5
318: 			.Width           = 75
319: 			.Height          = 75
320: 			.FontName        = "Comic Sans MS"
321: 			.FontSize        = 8
322: 			.FontBold        = .T.
323: 			.FontItalic      = .T.
324: 			.ForeColor       = RGB(90, 90, 90)
325: 			.BackColor       = RGB(255, 255, 255)
326: 			.Themes          = .F.
327: 			.SpecialEffect   = 0
328: 			.MousePointer    = 15
329: 			.WordWrap        = .T.
330: 			.AutoSize        = .F.
331: 			.Visible         = .T.
332: 		ENDWITH
333: 		BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335: 		*-- Grid de lista (Grade: Top=121+29=150, Left=12, Width=935, Height=470)
336: 		loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337: 		loc_oGrid = loc_oPagina.grd_4c_Lista
338: 
339: 		loc_oGrid.ColumnCount  = 2
340: 		loc_oGrid.RecordSource = "cursor_4c_Dados"
341: 
342: 		WITH loc_oGrid
343: 			.Top                = 150
344: 			.Left               = 12
345: 			.Width              = 935
346: 			.Height             = 470
347: 			.FontName           = "Tahoma"
348: 			.FontSize           = 8
349: 			.ForeColor          = RGB(90, 90, 90)

*-- Linhas 364 a 378:
364: 		WITH loc_oGrid.Column1
365: 			.ControlSource   = "cursor_4c_Dados.Cods"
366: 			.Width           = 60
367: 			.Header1.Caption = "C" + CHR(243) + "digos"
368: 		ENDWITH
369: 
370: 		WITH loc_oGrid.Column2
371: 			.ControlSource   = "cursor_4c_Dados.Descs"
372: 			.Width           = 150
373: 			.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
374: 		ENDWITH
375: 
376: 		THIS.TornarControlesVisiveis(loc_oPagina)
377: 	ENDPROC
378: 

*-- Linhas 392 a 464:
392: 		*-- Container bot" + CHR(245) + "es a" + CHR(231) + CHR(227) + "o (Grupo_Salva: Left=819, Top=10+29=39)
393: 		loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
394: 		WITH loc_oPagina.cnt_4c_BotoesAcao
395: 			.Top         = 39
396: 			.Left        = 819
397: 			.Width       = 160
398: 			.Height      = 85
399: 			.BackStyle   = 0
400: 			.BorderWidth = 0
401: 			.Visible     = .T.
402: 		ENDWITH
403: 
404: 		*-- Bot" + CHR(227) + "o Confirmar (Salvar)
405: 		loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
406: 		WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
407: 			.Caption         = "Confirmar"
408: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
409: 			.PicturePosition = 13
410: 			.Top             = 5
411: 			.Left            = 5
412: 			.Width           = 75
413: 			.Height          = 75
414: 			.FontName        = "Comic Sans MS"
415: 			.FontSize        = 8
416: 			.FontBold        = .T.
417: 			.FontItalic      = .T.
418: 			.ForeColor       = RGB(90, 90, 90)
419: 			.BackColor       = RGB(255, 255, 255)
420: 			.Themes          = .F.
421: 			.SpecialEffect   = 0
422: 			.MousePointer    = 15
423: 			.WordWrap        = .T.
424: 			.AutoSize        = .F.
425: 			.Visible         = .T.
426: 		ENDWITH
427: 		BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
428: 
429: 		*-- Bot" + CHR(227) + "o Cancelar
430: 		loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
431: 		WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
432: 			.Caption         = "Encerrar"
433: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
434: 			.PicturePosition = 13
435: 			.Top             = 5
436: 			.Left            = 80
437: 			.Width           = 75
438: 			.Height          = 75
439: 			.FontName        = "Comic Sans MS"
440: 			.FontSize        = 8
441: 			.FontBold        = .T.
442: 			.FontItalic      = .T.
443: 			.ForeColor       = RGB(90, 90, 90)
444: 			.BackColor       = RGB(255, 255, 255)
445: 			.Themes          = .F.
446: 			.SpecialEffect   = 0
447: 			.MousePointer    = 15
448: 			.WordWrap        = .T.
449: 			.AutoSize        = .F.
450: 			.Visible         = .T.
451: 		ENDWITH
452: 		BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
453: 
454: 		*-- Label C" + CHR(243) + "digo (Say1: Top=157+29=186, Left=374, Width=42, Height=15)
455: 		loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
456: 		WITH loc_oPagina.lbl_4c_Codigo
457: 			.Caption   = "C" + CHR(243) + "digo :"
458: 			.Top       = 186
459: 			.Left      = 374
460: 			.Width     = 42
461: 			.Height    = 15
462: 			.AutoSize  = .F.
463: 			.FontName  = "Tahoma"
464: 			.FontSize  = 8

*-- Linhas 473 a 499:
473: 		loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
474: 		WITH loc_oPagina.txt_4c_Codigo
475: 			.Value         = ""
476: 			.Top           = 182
477: 			.Left          = 422
478: 			.Width         = 31
479: 			.Height        = 24
480: 			.FontName      = "Tahoma"
481: 			.FontSize      = 8
482: 			.MaxLength     = 5
483: 			.Alignment     = 0
484: 			.BackColor     = RGB(255, 255, 255)
485: 			.ForeColor     = RGB(0, 0, 0)
486: 			.Visible       = .T.
487: 		ENDWITH
488: 
489: 		*-- Label Descricao (Say2: Top=185+29=214, Left=361, Width=55, Height=15)
490: 		loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
491: 		WITH loc_oPagina.lbl_4c_Descricao
492: 			.Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
493: 			.Top       = 214
494: 			.Left      = 361
495: 			.Width     = 55
496: 			.Height    = 15
497: 			.AutoSize  = .F.
498: 			.FontName  = "Tahoma"
499: 			.FontSize  = 8

*-- Linhas 508 a 517:
508: 		loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
509: 		WITH loc_oPagina.txt_4c_Descricao
510: 			.Value         = ""
511: 			.Top           = 210
512: 			.Left          = 422
513: 			.Width         = 150
514: 			.Height        = 24
515: 			.FontName      = "Tahoma"
516: 			.FontSize      = 8
517: 			.MaxLength     = 50

*-- Linhas 546 a 555:
546: 					loc_oGrid.RecordSource = "cursor_4c_Dados"
547: 					loc_oGrid.Column1.ControlSource   = "cursor_4c_Dados.Cods"
548: 					loc_oGrid.Column2.ControlSource   = "cursor_4c_Dados.Descs"
549: 					loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digos"
550: 					loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
551: 					loc_oGrid.Column1.Width           = 60
552: 					loc_oGrid.Column2.Width           = 150
553: 					THIS.FormatarGridLista(loc_oGrid)
554: 					loc_lResultado = .T.
555: 				ENDIF

*-- Linhas 671 a 680:
671: 	*====================================================================
672: 	PROTECTED PROCEDURE AjustarBotoesPorModo()
673: 		LOCAL loc_oBtnConf, loc_oBtnCanc
674: 		loc_oBtnConf = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
675: 		loc_oBtnCanc = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
676: 
677: 		DO CASE
678: 			CASE THIS.this_cModoAtual = "VISUALIZAR"
679: 				loc_oBtnConf.Enabled = .F.
680: 			OTHERWISE

*-- Linhas 720 a 728:
720: 			THIS.HabilitarCampos(.F.)
721: 			THIS.AjustarBotoesPorModo()
722: 			THIS.AlternarPagina(2)
723: 			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
724: 		ENDIF
725: 	ENDPROC
726: 
727: 	*====================================================================
728: 	* BtnAlterarClick - Abre Page2 para alterar registro selecionado

*-- Linhas 775 a 783:
775: 			THIS.HabilitarCampos(.F.)
776: 			THIS.AjustarBotoesPorModo()
777: 			THIS.AlternarPagina(2)
778: 			THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.SetFocus
779: 		ENDIF
780: 	ENDPROC
781: 
782: 	*====================================================================
783: 	* BtnBuscarClick - Abre Page2 em modo busca (equivale ao PROCURAR do legado)


### BO (C:\4c\projeto\app\classes\FprBO.prg):
*====================================================================
* FprBO.prg
*
* Business Object para Modelos de Produtos
* Tabela: SigCdFip
* Campos: Cods (PK), Descs
*====================================================================

DEFINE CLASS FprBO AS BusinessBase

	*-- Propriedades da entidade
	this_cCods  = ""
	this_cDescs = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela     = "SigCdFip"
			THIS.this_cCampoChave = "Cods"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "FprBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCods)
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades do BO a partir de cursor
	* REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCods  = TratarNulo(Cods,  "C")
				THIS.this_cDescs = TratarNulo(Descs, "C")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "FprBO.CarregarDoCursor")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarDados - Valida dados antes de salvar
	* Regras do original: Cods e Descs nao podem ser vazios nem ter aspas
	*====================================================================
	PROTECTED PROCEDURE ValidarDados()
		LOCAL loc_lValido
		loc_lValido = .T.

		IF EMPTY(THIS.this_cCods) OR (AT("'", THIS.this_cCods) + AT('"', THIS.this_cCods) > 0)
			MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
			loc_lValido = .F.
		ENDIF

		IF loc_lValido AND THIS.this_lNovoRegistro
			IF THIS.VerificarCodigoExistente(THIS.this_cCods)
				MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
				loc_lValido = .F.
			ENDIF
		ENDIF

		IF loc_lValido AND (EMPTY(THIS.this_cDescs) OR (AT("'", THIS.this_cDescs) + AT('"', THIS.this_cDescs) > 0))
			MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
			loc_lValido = .F.
		ENDIF

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* VerificarCodigoExistente - Verifica se Cods ja existe em SigCdFip
	*====================================================================
	PROCEDURE VerificarCodigoExistente(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lExiste
		loc_lExiste = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFpr")
			IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFpr")
				SELECT cursor_4c_ChkFpr
				loc_lExiste = (cursor_4c_ChkFpr.qtd > 0)
				USE IN cursor_4c_ChkFpr
			ENDIF
		CATCH TO loException
			MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "FprBO.VerificarCodigoExistente")
		ENDTRY

		RETURN loc_lExiste
	ENDPROC

	*====================================================================
	* Inserir - Insere novo registro na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdFip (Cods, Descs)" + ;
				" VALUES (" + EscaparSQL(THIS.this_cCods) + ", " + EscaparSQL(THIS.this_cDescs) + ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao inserir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "FprBO.Inserir")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - Atualiza registro existente na tabela SigCdFip
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdFip" + ;
				" SET Descs = " + EscaparSQL(THIS.this_cDescs) + ;
				" WHERE Cods = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MostrarErro("Erro ao atualizar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "FprBO.Atualizar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - Exclui registro de SigCdFip
	* Verifica se produtos usam este modelo (SigCdPro.CodFinP) antes de excluir
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso, loc_cMsg
		loc_lSucesso = .F.
		loc_nUso     = 0
		loc_cMsg     = ""

		TRY
			loc_cSQL = "SELECT CPros, DPros FROM SigCdPro" + ;
				" WHERE CodFinP = " + EscaparSQL(THIS.this_cCods)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")

			IF loc_nResultado < 0
				MostrarErro("Favor Reinicializar o Processo!!!" + CHR(13) + CapturarErroSQL(), "Falha na Conex" + CHR(227) + "o")
			ELSE
				IF USED("cursor_4c_ChkPro")
					SELECT cursor_4c_ChkPro
					GO TOP IN cursor_4c_ChkPro
					loc_nUso = IIF(!EOF("cursor_4c_ChkPro"), RECCOUNT("cursor_4c_ChkPro"), 0)

					IF loc_nUso > 1
						loc_cMsg = "Existem " + ALLTRIM(STR(loc_nUso)) + " Produtos Utilizando Esse Modelo!!!" + ;
							" Para Excluir o" + CHR(13) + ;
							"Modelo " + CHR(233) + " Necess" + CHR(225) + "rio Alterar o Cadastro de Produtos Primeiro!!!"
						MsgAviso(loc_cMsg)
					ELSE
						IF loc_nUso = 1
							loc_cMsg = "O Produto " + ALLTRIM(cursor_4c_ChkPro.CPros) + " - " + ;
								ALLTRIM(cursor_4c_ChkPro.DPros) + " Est" + CHR(225) + ;
								" Utilizando Esse Modelo!!!" + CHR(13) + ;
								"Para Excluir o Modelo " + CHR(233) + " Necess" + CHR(225) + ;
								"rio Alterar o Cadastro do Produto Primeiro!!!"
							MsgAviso(loc_cMsg)
						ELSE
							USE IN cursor_4c_ChkPro

							loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
							loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
							IF loc_nResultado >= 0
								THIS.RegistrarAuditoria("DELETE")
								loc_lSucesso = .T.
							ELSE
								MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							ENDIF
						ENDIF
					ENDIF

					IF USED("cursor_4c_ChkPro")
						USE IN cursor_4c_ChkPro
					ENDIF
				ELSE
					loc_cSQL = "DELETE FROM SigCdFip WHERE Cods = " + EscaparSQL(THIS.this_cCods)
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao excluir modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "FprBO.ExecutarExclusao")
			IF USED("cursor_4c_ChkPro")
				USE IN cursor_4c_ChkPro
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Buscar - Busca registros com filtro opcional
	* Retorna cursor_4c_Dados com Cods, Descs
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
				IF !USED("cursor_4c_Dados")
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (Cods C(5), Descs C(50))
					SET NULL OFF
				ENDIF
				loc_lSucesso = .T.
			ELSE
				loc_cSQL = "SELECT Cods, Descs FROM SigCdFip"

				IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
					loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
				ENDIF

				loc_cSQL = loc_cSQL + " ORDER BY Cods"

				IF USED("cursor_4c_Dados")
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
					IF loc_nResultado >= 0
						SELECT cursor_4c_Dados
						ZAP
						SET NULL ON
						APPEND FROM DBF("cursor_4c_DadosTmp")
						SET NULL OFF
						IF USED("cursor_4c_DadosTmp")
							USE IN cursor_4c_DadosTmp
						ENDIF
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ELSE
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
					IF loc_nResultado >= 0
						loc_lSucesso = .T.
					ELSE
						MostrarErro("Erro ao buscar modelos de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "FprBO.Buscar")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pela chave primaria (Cods)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Cods, Descs FROM SigCdFip" + ;
				" WHERE Cods = " + EscaparSQL(par_cCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado >= 0
				IF RECCOUNT("cursor_4c_Carrega") > 0
					loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
					THIS.this_lNovoRegistro = .F.
				ELSE
					MsgAviso("Modelo de Produto n" + CHR(227) + "o encontrado!")
				ENDIF

				IF USED("cursor_4c_Carrega")
					USE IN cursor_4c_Carrega
				ENDIF
			ELSE
				MostrarErro("Erro ao carregar modelo de produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF

		CATCH TO loException
			MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "FprBO.CarregarPorCodigo")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

