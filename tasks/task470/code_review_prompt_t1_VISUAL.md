# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 179: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 203: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 251: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 275: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 310: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 391: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 415: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMtt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (979 linhas total):

*-- Linhas 88 a 97:
88: 		THIS.AddObject("pgf_4c_Paginas", "PageFrame")
89: 		THIS.pgf_4c_Paginas.PageCount = 2
90: 		WITH THIS.pgf_4c_Paginas
91: 			.Top     = -29
92: 			.Left    = 0
93: 			.Width   = THIS.Width
94: 			.Height  = THIS.Height + 29
95: 			.Tabs    = .F.
96: 			.TabStop = .F.
97: 			.Visible = .T.

*-- Linhas 111 a 148:
111: 		*-- Cabecalho escuro com sombra e titulo
112: 		loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
113: 		WITH loc_oPagina.cnt_4c_Cabecalho
114: 			.Top         = 1 + 29
115: 			.Left        = 0
116: 			.Width       = THIS.Width
117: 			.Height      = 80
118: 			.BackColor   = RGB(100, 100, 100)
119: 			.BorderWidth = 0
120: 			.Visible     = .T.
121: 		ENDWITH
122: 
123: 		loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
124: 		WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
125: 			.Caption   = THIS.Caption
126: 			.Top       = 15
127: 			.Left      = 10
128: 			.Width     = THIS.Width - 30
129: 			.Height    = 40
130: 			.FontName  = "Tahoma"
131: 			.FontSize  = 16
132: 			.FontBold  = .T.
133: 			.ForeColor = RGB(0, 0, 0)
134: 			.BackStyle = 0
135: 			.AutoSize  = .F.
136: 			.Visible   = .T.
137: 		ENDWITH
138: 
139: 		loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
140: 		WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
141: 			.Caption   = THIS.Caption
142: 			.Top       = 18
143: 			.Left      = 10
144: 			.Width     = THIS.Width - 30
145: 			.Height    = 46
146: 			.FontName  = "Tahoma"
147: 			.FontSize  = 16
148: 			.FontBold  = .T.

*-- Linhas 155 a 281:
155: 		*-- Container de botoes CRUD (Grupo_op: Left=543, Top=29)
156: 		loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
157: 		WITH loc_oPagina.cnt_4c_Botoes
158: 			.Top         = 0 + 29
159: 			.Left        =  542
160: 			.Width       = 385
161: 			.Height      = 85
162: 			.BackStyle = 0
163: 			.BorderWidth = 0
164: 			.Visible     = .T.
165: 		ENDWITH
166: 
167: 		*-- Botao Incluir
168: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
169: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
170: 			.Caption         = "Incluir"
171: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
172: 			.PicturePosition = 13
173: 			.Top             = 5
174: 			.Left            = 5
175: 			.Width           = 75
176: 			.Height          = 75
177: 			.BackColor       = RGB(255, 255, 255)
178: 			.ForeColor       = RGB(90, 90, 90)
179: 			.FontName        = "Comic Sans MS"
180: 			.FontSize        = 8
181: 			.FontBold        = .T.
182: 			.FontItalic      = .T.
183: 			.Themes          = .F.
184: 			.SpecialEffect   = 0
185: 			.MousePointer    = 15
186: 			.WordWrap        = .T.
187: 			.AutoSize        = .F.
188: 			.Visible         = .T.
189: 		ENDWITH
190: 
191: 		*-- Botao Visualizar
192: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
193: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
194: 			.Caption         = "Visualizar"
195: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
196: 			.PicturePosition = 13
197: 			.Top             = 5
198: 			.Left            = 80
199: 			.Width           = 75
200: 			.Height          = 75
201: 			.BackColor       = RGB(255, 255, 255)
202: 			.ForeColor       = RGB(90, 90, 90)
203: 			.FontName        = "Comic Sans MS"
204: 			.FontSize        = 8
205: 			.FontBold        = .T.
206: 			.FontItalic      = .T.
207: 			.Themes          = .F.
208: 			.SpecialEffect   = 0
209: 			.MousePointer    = 15
210: 			.WordWrap        = .T.
211: 			.AutoSize        = .F.
212: 			.Visible         = .T.
213: 		ENDWITH
214: 
215: 		*-- Botao Alterar
216: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
217: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
218: 			.Caption         = "Alterar"
219: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220: 			.PicturePosition = 13
221: 			.Top             = 5
222: 			.Left            = 155
223: 			.Width           = 75
224: 			.Height          = 75
225: 			.BackColor       = RGB(255, 255, 255)
226: 			.ForeColor       = RGB(90, 90, 90)
227: 			.FontName        = "Comic Sans MS"
228: 			.FontSize        = 8
229: 			.FontBold        = .T.
230: 			.FontItalic      = .T.
231: 			.Themes          = .F.
232: 			.SpecialEffect   = 0
233: 			.MousePointer    = 15
234: 			.WordWrap        = .T.
235: 			.AutoSize        = .F.
236: 			.Visible         = .T.
237: 		ENDWITH
238: 
239: 		*-- Botao Excluir
240: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
241: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
242: 			.Caption         = "Excluir"
243: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
244: 			.PicturePosition = 13
245: 			.Top             = 5
246: 			.Left            = 230
247: 			.Width           = 75
248: 			.Height          = 75
249: 			.BackColor       = RGB(255, 255, 255)
250: 			.ForeColor       = RGB(90, 90, 90)
251: 			.FontName        = "Comic Sans MS"
252: 			.FontSize        = 8
253: 			.FontBold        = .T.
254: 			.FontItalic      = .T.
255: 			.Themes          = .F.
256: 			.SpecialEffect   = 0
257: 			.MousePointer    = 15
258: 			.WordWrap        = .T.
259: 			.AutoSize        = .F.
260: 			.Visible         = .T.
261: 		ENDWITH
262: 
263: 		*-- Botao Buscar
264: 		loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
265: 		WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
266: 			.Caption         = "Buscar"
267: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
268: 			.PicturePosition = 13
269: 			.Top             = 5
270: 			.Left            = 305
271: 			.Width           = 75
272: 			.Height          = 75
273: 			.BackColor       = RGB(255, 255, 255)
274: 			.ForeColor       = RGB(90, 90, 90)
275: 			.FontName        = "Comic Sans MS"
276: 			.FontSize        = 8
277: 			.FontBold        = .T.
278: 			.FontItalic      = .T.
279: 			.Themes          = .F.
280: 			.SpecialEffect   = 0
281: 			.MousePointer    = 15

*-- Linhas 287 a 316:
287: 		*-- Container de saida - padrao canonico (Left=917, Width=90)
288: 		loc_oPagina.AddObject("cnt_4c_Saida", "Container")
289: 		WITH loc_oPagina.cnt_4c_Saida
290: 			.Top         = 0 + 29
291: 			.Left        = 917
292: 			.Width       = 90
293: 			.Height      = 85
294: 			.BackStyle   = 0
295: 			.BorderWidth = 0
296: 			.Visible     = .T.
297: 		ENDWITH
298: 
299: 		loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
300: 		WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
301: 			.Caption         = "Encerrar"
302: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
303: 			.PicturePosition = 13
304: 			.Top             = 5
305: 			.Left            = 5
306: 			.Width           = 75
307: 			.Height          = 75
308: 			.BackColor       = RGB(255, 255, 255)
309: 			.ForeColor       = RGB(90, 90, 90)
310: 			.FontName        = "Comic Sans MS"
311: 			.FontSize        = 8
312: 			.FontBold        = .T.
313: 			.FontItalic      = .T.
314: 			.Themes          = .F.
315: 			.SpecialEffect   = 0
316: 			.MousePointer    = 15

*-- Linhas 323 a 332:
323: 		*-- RecordSource/ControlSources configurados em CarregarLista()
324: 		loc_oPagina.AddObject("grd_4c_Lista", "Grid")
325: 		WITH loc_oPagina.grd_4c_Lista
326: 			.Top                = 117
327: 			.Left               = 26
328: 			.Width              = 890
329: 			.Height             = 490
330: 			.FontName           = "Verdana"
331: 			.FontSize           = 8
332: 			.ForeColor          = RGB(90, 90, 90)

*-- Linhas 346 a 359:
346: 		loc_oPagina.grd_4c_Lista.ColumnCount = 3
347: 
348: 		*-- BINDEVENTs para botoes CRUD e Encerrar
349: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
350: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
351: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
352: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
353: 		BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
354: 		BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
355: 
356: 		THIS.TornarControlesVisiveis(loc_oPagina)
357: 	ENDPROC
358: 
359: 	*====================================================================

*-- Linhas 368 a 441:
368: 		*-- Container de botoes Confirmar/Cancelar (Grupo_Salva: Left=821, Top=8)
369: 		loc_oPagina.AddObject("cnt_4c_Salva", "Container")
370: 		WITH loc_oPagina.cnt_4c_Salva
371: 			.Top         = 8 + 29
372: 			.Left        = 821
373: 			.Width       = 160
374: 			.Height      = 85
375: 			.BackStyle   = 0
376: 			.Visible     = .T.
377: 		ENDWITH
378: 
379: 		*-- Botao Confirmar (Grupo_Salva.Salva: Left=5, Top=5)
380: 		loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
381: 		WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
382: 			.Caption         = "Confirmar"
383: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
384: 			.PicturePosition = 13
385: 			.Top             = 5
386: 			.Left            = 5
387: 			.Width           = 75
388: 			.Height          = 75
389: 			.BackColor       = RGB(255, 255, 255)
390: 			.ForeColor       = RGB(90, 90, 90)
391: 			.FontName        = "Comic Sans MS"
392: 			.FontSize        = 8
393: 			.FontBold        = .T.
394: 			.FontItalic      = .T.
395: 			.Themes          = .F.
396: 			.SpecialEffect   = 0
397: 			.MousePointer    = 15
398: 			.WordWrap        = .T.
399: 			.AutoSize        = .F.
400: 			.Visible         = .T.
401: 		ENDWITH
402: 
403: 		*-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
404: 		loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
405: 		WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
406: 			.Caption         = "Encerrar"
407: 			.Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
408: 			.PicturePosition = 13
409: 			.Top             = 5
410: 			.Left            = 80
411: 			.Width           = 75
412: 			.Height          = 75
413: 			.BackColor       = RGB(255, 255, 255)
414: 			.ForeColor       = RGB(90, 90, 90)
415: 			.FontName        = "Comic Sans MS"
416: 			.FontSize        = 8
417: 			.FontBold        = .T.
418: 			.FontItalic      = .T.
419: 			.Themes          = .F.
420: 			.SpecialEffect   = 0
421: 			.MousePointer    = 15
422: 			.WordWrap        = .T.
423: 			.AutoSize        = .F.
424: 			.Visible         = .T.
425: 		ENDWITH
426: 
427: 		*-- BINDEVENTs dos botoes de Page2
428: 		BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
429: 		BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
430: 
431: 		*-- Label [M]etal / [T]eor (Say3: Top=120, Left=296, Width=83, ForeColor=90,90,90)
432: 		loc_oPagina.AddObject("lbl_4c_Label3", "Label")
433: 		WITH loc_oPagina.lbl_4c_Label3
434: 			.Caption   = "[M]etal / [T]eor :"
435: 			.Top       = 120 + 29
436: 			.Left      = 296
437: 			.Width     = 83
438: 			.Height    = 17
439: 			.FontName  = "Tahoma"
440: 			.FontSize  = 8
441: 			.ForeColor = RGB(90, 90, 90)

*-- Linhas 449 a 473:
449: 		loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
450: 		WITH loc_oPagina.txt_4c_Tipos
451: 			.Value         = ""
452: 			.Top           = 117 + 29
453: 			.Left          = 383
454: 			.Width         = 17
455: 			.Height        = 23
456: 			.MaxLength     = 1
457: 			.SpecialEffect = 1
458: 			.FontName      = "Tahoma"
459: 			.FontSize      = 8
460: 			.Visible       = .T.
461: 		ENDWITH
462: 
463: 		*-- Label Codigo (Say1: Top=146, Left=337, Width=42, ForeColor=90,90,90)
464: 		loc_oPagina.AddObject("lbl_4c_Label1", "Label")
465: 		WITH loc_oPagina.lbl_4c_Label1
466: 			.Caption   = "C" + CHR(243) + "digo :"
467: 			.Top       = 146 + 29
468: 			.Left      = 337
469: 			.Width     = 42
470: 			.Height    = 17
471: 			.FontName  = "Tahoma"
472: 			.FontSize  = 8
473: 			.ForeColor = RGB(90, 90, 90)

*-- Linhas 483 a 507:
483: 		loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
484: 		WITH loc_oPagina.txt_4c_Codigos
485: 			.Value         = ""
486: 			.Top           = 143 + 29
487: 			.Left          = 383
488: 			.Width         = 30
489: 			.Height        = 23
490: 			.MaxLength     = 10
491: 			.SpecialEffect = 1
492: 			.FontName      = "Tahoma"
493: 			.FontSize      = 8
494: 			.Visible       = .T.
495: 		ENDWITH
496: 
497: 		*-- Label Descricao (Say2: Top=172, Left=324, Caption="Descricao :")
498: 		loc_oPagina.AddObject("lbl_4c_Label2", "Label")
499: 		WITH loc_oPagina.lbl_4c_Label2
500: 			.Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
501: 			.Top       = 172 + 29
502: 			.Left      = 324
503: 			.Width     = 55
504: 			.Height    = 17
505: 			.FontName  = "Tahoma"
506: 			.FontSize  = 8
507: 			.ForeColor = RGB(90, 90, 90)

*-- Linhas 514 a 523:
514: 		loc_oPagina.AddObject("txt_4c_Descs", "TextBox")
515: 		WITH loc_oPagina.txt_4c_Descs
516: 			.Value         = ""
517: 			.Top           = 169 + 29
518: 			.Left          = 383
519: 			.Width         = 150
520: 			.Height        = 23
521: 			.MaxLength     = 60
522: 			.SpecialEffect = 1
523: 			.FontName      = "Tahoma"

*-- Linhas 557 a 567:
557: 						.Column3.Width     = 300
558: 
559: 						*-- Headers reconfigurados apos RecordSource (Problem 6/32)
560: 						.Column1.Header1.Caption = "Tipo"
561: 						.Column2.Header1.Caption = "C" + CHR(243) + "digo"
562: 						.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
563: 
564: 						.Column1.Alignment = 2
565: 						.Column2.Alignment = 2
566: 						.Column3.Alignment = 0
567: 					ENDWITH

*-- Linhas 847 a 859:
847: 		loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
848: 		loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
849: 
850: 		IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
851: 			loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEditando
852: 		ENDIF
853: 		IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
854: 			loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
855: 		ENDIF
856: 	ENDPROC
857: 
858: 	*====================================================================
859: 	* BtnSalvarClick - Confirmar: valida, transfere para BO e salva

*-- Linhas 906 a 916:
906: 					.Column1.Width           = 30
907: 					.Column2.Width           = 75
908: 					.Column3.Width           = 300
909: 					.Column1.Header1.Caption = "Tipo"
910: 					.Column2.Header1.Caption = "C" + CHR(243) + "digo"
911: 					.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
912: 					.Column1.Alignment       = 2
913: 					.Column2.Alignment       = 2
914: 					.Column3.Alignment       = 0
915: 				ENDWITH
916: 				THIS.FormatarGridLista(loc_oGrid)


### BO (C:\4c\projeto\app\classes\MttBO.prg):
*====================================================================
* MttBO.prg
*
* Business Object para Metal/Teor
* Tabela: SigCdMtl
* PK: cidchaves (gerado via SYS(2015))
* Chave de negocio: tipos + codigos (unicos juntos)
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS MttBO AS BusinessBase

	*-- Propriedades da entidade (SigCdMtl)
	this_cCidchaves   = ""   && cidchaves char      - PK auto-gerada
	this_cTipos       = ""   && tipos char(1)       - [M]etal ou [T]eor
	this_cCodigos     = ""   && codigos char        - Codigo do metal/teor
	this_cDescs       = ""   && descs char          - Descricao

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela      = "SigCdMtl"
		THIS.this_cCampoChave  = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de registros no cursor_4c_Dados
	* par_cFiltro: condicao WHERE adicional (sem a palavra WHERE)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT tipos, codigos, descs, cidchaves" + ;
			           " FROM SigCdMtl"

			IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
				loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY tipos, codigos"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao buscar Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		IF VARTYPE(par_cCidchaves) != "C" OR EMPTY(ALLTRIM(par_cCidchaves))
			RETURN .F.
		ENDIF

		TRY
			loc_cSQL = "SELECT tipos, codigos, descs, cidchaves" + ;
			           " FROM SigCdMtl" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				IF loc_nResultado < 0
					MsgErro("Erro ao carregar Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao carregar Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cTipos     = TratarNulo(tipos,     "C")
			THIS.this_cCodigos   = TratarNulo(codigos,   "C")
			THIS.this_cDescs     = TratarNulo(descs,     "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* ValidarDados - Valida campos obrigatorios e regras de negocio
	*====================================================================
	PROCEDURE ValidarDados()
		IF !INLIST(UPPER(ALLTRIM(THIS.this_cTipos)), "M", "T")
			MsgAviso("[M]etal / [T]eor: informe M ou T!", "")
			RETURN .F.
		ENDIF

		IF EMPTY(ALLTRIM(THIS.this_cCodigos))
			MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!", "")
			RETURN .F.
		ENDIF

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Inserir - INSERT no SigCdMtl (PROTECTED - chamado por BusinessBase.Salvar)
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
		loc_lSucesso = .F.

		TRY
			*-- Verificar duplicidade de tipos + codigos
			IF THIS.VerificarDuplicidade()
				MsgAviso("Tipo e C" + CHR(243) + "digo j" + CHR(225) + " Cadastrado!", "")
				loc_lSucesso = .F.
			ELSE
				*-- Gerar PK unica (substitui fUniqueIds do legado)
				loc_cCidchaves = SYS(2015)

				loc_cSQL = "INSERT INTO SigCdMtl (cidchaves, tipos, codigos, descs)" + ;
				           " VALUES (" + ;
				           EscaparSQL(loc_cCidchaves) + ", " + ;
				           EscaparSQL(UPPER(ALLTRIM(THIS.this_cTipos))) + ", " + ;
				           EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
				           EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
				           ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
				IF loc_nResultado >= 0
					THIS.this_cCidchaves = loc_cCidchaves
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
				ENDIF

				IF USED("cursor_4c_Ins")
					USE IN cursor_4c_Ins
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao inserir Metal/Teor: " + loException.Message, "Erro")
			IF USED("cursor_4c_Ins")
				USE IN cursor_4c_Ins
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE no SigCdMtl (PROTECTED - chamado por BusinessBase.Salvar)
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdMtl SET" + ;
			           " tipos = "   + EscaparSQL(UPPER(ALLTRIM(THIS.this_cTipos)))   + "," + ;
			           " codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + "," + ;
			           " descs = "   + EscaparSQL(ALLTRIM(THIS.this_cDescs)) + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao atualizar Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Upd")
			USE IN cursor_4c_Upd
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE do SigCdMtl (PROTECTED - chamado por BusinessBase.Excluir)
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdMtl" + ;
			           " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir Metal/Teor: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao excluir Metal/Teor: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Del")
			USE IN cursor_4c_Del
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Checa se tipos+codigos ja existem
	*====================================================================
	PROTECTED PROCEDURE VerificarDuplicidade()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdMtl" + ;
			           " WHERE tipos = "   + EscaparSQL(UPPER(ALLTRIM(THIS.this_cTipos))) + ;
			           " AND codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

			*-- Em UPDATE, excluir o proprio registro da verificacao
			IF !EMPTY(ALLTRIM(THIS.this_cCidchaves)) AND !THIS.this_lNovoRegistro
				loc_cSQL = loc_cSQL + " AND cidchaves <> " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Duplic")
				SELECT cursor_4c_Duplic
				loc_lDuplicado = (cursor_4c_Duplic.Total > 0)
			ENDIF
		CATCH TO loException
			MsgErro("Erro ao verificar duplicidade: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Duplic")
			USE IN cursor_4c_Duplic
		ENDIF

		RETURN loc_lDuplicado
	ENDPROC

ENDDEFINE

