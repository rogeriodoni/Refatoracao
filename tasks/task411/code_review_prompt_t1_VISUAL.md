# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 208: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 258: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 283: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 308: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 346: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 528: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 552: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 577: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFap.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2860 linhas total):

*-- Linhas 98 a 118:
98: 
99: 			WITH THIS.pgf_4c_Paginas
100: 				.PageCount  = 2
101: 				.Top        = -29
102: 				.Left       = 0
103: 				.Width      = THIS.Width
104: 				.Height     = THIS.Height + 29
105: 				.Tabs       = .F.
106: 				.TabStop    = .F.
107: 				.Visible    = .T.
108: 
109: 				.Page1.Caption    = "Lista"
110: 				.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111: 				.Page1.BackColor  = RGB(255, 255, 255)
112: 
113: 				.Page2.Caption    = "Dados"
114: 				.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
115: 				.Page2.BackColor  = RGB(255, 255, 255)
116: 			ENDWITH
117: 		CATCH TO loc_oErro
118: 			MsgErro("Erro em ConfigurarPageFrame: " + loc_oErro.Message, "Erro")

*-- Linhas 138 a 175:
138: 			*------------------------------------------------------------
139: 			loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
140: 			WITH loc_oPagina.cnt_4c_Cabecalho
141: 				.Top         = 31
142: 				.Left        = 0
143: 				.Width       = THIS.Width
144: 				.Height      = 80
145: 				.BackColor   = RGB(100, 100, 100)
146: 				.BorderWidth = 0
147: 				.Visible     = .T.
148: 			ENDWITH
149: 
150: 			loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
151: 			WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
152: 				.Caption    = THIS.Caption
153: 				.Top        = 15
154: 				.Left       = 10
155: 				.Width      = 769
156: 				.Height     = 40
157: 				.AutoSize   = .F.
158: 				.FontName   = "Tahoma"
159: 				.FontSize   = 16
160: 				.FontBold   = .T.
161: 				.ForeColor  = RGB(0, 0, 0)
162: 				.BackStyle  = 0
163: 				.Visible    = .T.
164: 			ENDWITH
165: 
166: 			loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
167: 			WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
168: 				.Caption    = THIS.Caption
169: 				.Top        = 18
170: 				.Left       = 10
171: 				.Width      = 769
172: 				.Height     = 46
173: 				.AutoSize   = .F.
174: 				.FontName   = "Tahoma"
175: 				.FontSize   = 16

*-- Linhas 184 a 362:
184: 			*------------------------------------------------------------
185: 			loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
186: 			WITH loc_oPagina.cnt_4c_Botoes
187: 				.Top         = 29
188: 				.Left        = 542
189: 				.Width       = 390
190: 				.Height      = 85
191: 				.BackStyle = 0
192: 				.BorderWidth = 0
193: 				.Visible     = .T.
194: 			ENDWITH
195: 
196: 			*-- Botao Incluir
197: 			loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
198: 			WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
199: 				.Caption         = "Incluir"
200: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
201: 				.PicturePosition = 13
202: 				.Top             = 5
203: 				.Left            = 5
204: 				.Width           = 75
205: 				.Height          = 75
206: 				.BackColor       = RGB(255, 255, 255)
207: 				.ForeColor       = RGB(90, 90, 90)
208: 				.FontName        = "Comic Sans MS"
209: 				.FontSize        = 8
210: 				.FontBold        = .T.
211: 				.FontItalic      = .T.
212: 				.Themes          = .F.
213: 				.SpecialEffect   = 0
214: 				.WordWrap        = .T.
215: 				.AutoSize        = .F.
216: 				.MousePointer    = 15
217: 				.Visible         = .T.
218: 			ENDWITH
219: 			BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
220: 
221: 			*-- Botao Visualizar
222: 			loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
223: 			WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
224: 				.Caption         = "Visualizar"
225: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
226: 				.PicturePosition = 13
227: 				.Top             = 5
228: 				.Left            = 80
229: 				.Width           = 75
230: 				.Height          = 75
231: 				.BackColor       = RGB(255, 255, 255)
232: 				.ForeColor       = RGB(90, 90, 90)
233: 				.FontName        = "Comic Sans MS"
234: 				.FontSize        = 8
235: 				.FontBold        = .T.
236: 				.FontItalic      = .T.
237: 				.Themes          = .F.
238: 				.SpecialEffect   = 0
239: 				.WordWrap        = .T.
240: 				.AutoSize        = .F.
241: 				.MousePointer    = 15
242: 				.Visible         = .T.
243: 			ENDWITH
244: 			BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
245: 
246: 			*-- Botao Alterar
247: 			loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
248: 			WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
249: 				.Caption         = "Alterar"
250: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
251: 				.PicturePosition = 13
252: 				.Top             = 5
253: 				.Left            = 155
254: 				.Width           = 75
255: 				.Height          = 75
256: 				.BackColor       = RGB(255, 255, 255)
257: 				.ForeColor       = RGB(90, 90, 90)
258: 				.FontName        = "Comic Sans MS"
259: 				.FontSize        = 8
260: 				.FontBold        = .T.
261: 				.FontItalic      = .T.
262: 				.Themes          = .F.
263: 				.SpecialEffect   = 0
264: 				.WordWrap        = .T.
265: 				.AutoSize        = .F.
266: 				.MousePointer    = 15
267: 				.Visible         = .T.
268: 			ENDWITH
269: 			BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
270: 
271: 			*-- Botao Excluir
272: 			loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
273: 			WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
274: 				.Caption         = "Excluir"
275: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
276: 				.PicturePosition = 13
277: 				.Top             = 5
278: 				.Left            = 230
279: 				.Width           = 75
280: 				.Height          = 75
281: 				.BackColor       = RGB(255, 255, 255)
282: 				.ForeColor       = RGB(90, 90, 90)
283: 				.FontName        = "Comic Sans MS"
284: 				.FontSize        = 8
285: 				.FontBold        = .T.
286: 				.FontItalic      = .T.
287: 				.Themes          = .F.
288: 				.SpecialEffect   = 0
289: 				.WordWrap        = .T.
290: 				.AutoSize        = .F.
291: 				.MousePointer    = 15
292: 				.Visible         = .T.
293: 			ENDWITH
294: 			BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
295: 
296: 			*-- Botao Buscar
297: 			loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
298: 			WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
299: 				.Caption         = "Buscar"
300: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
301: 				.PicturePosition = 13
302: 				.Top             = 5
303: 				.Left            = 305
304: 				.Width           = 75
305: 				.Height          = 75
306: 				.BackColor       = RGB(255, 255, 255)
307: 				.ForeColor       = RGB(90, 90, 90)
308: 				.FontName        = "Comic Sans MS"
309: 				.FontSize        = 8
310: 				.FontBold        = .T.
311: 				.FontItalic      = .T.
312: 				.Themes          = .F.
313: 				.SpecialEffect   = 0
314: 				.WordWrap        = .T.
315: 				.AutoSize        = .F.
316: 				.MousePointer    = 15
317: 				.Visible         = .T.
318: 			ENDWITH
319: 			BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
320: 
321: 			*------------------------------------------------------------
322: 			*-- Container saida - padrao canonico (Left=917, Width=90)
323: 			*------------------------------------------------------------
324: 			loc_oPagina.AddObject("cnt_4c_Saida", "Container")
325: 			WITH loc_oPagina.cnt_4c_Saida
326: 				.Top         = 29
327: 				.Left        = 917
328: 				.Width       = 90
329: 				.Height      = 85
330: 				.BackStyle   = 0
331: 				.BorderWidth = 0
332: 				.Visible     = .T.
333: 			ENDWITH
334: 
335: 			loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
336: 			WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
337: 				.Caption         = "Encerrar"
338: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
339: 				.PicturePosition = 13
340: 				.Top             = 5
341: 				.Left            = 5
342: 				.Width           = 75
343: 				.Height          = 75
344: 				.BackColor       = RGB(255, 255, 255)
345: 				.ForeColor       = RGB(90, 90, 90)
346: 				.FontName        = "Comic Sans MS"
347: 				.FontSize        = 8
348: 				.FontBold        = .T.
349: 				.FontItalic      = .T.
350: 				.Themes          = .F.
351: 				.SpecialEffect   = 0
352: 				.WordWrap        = .T.
353: 				.AutoSize        = .F.
354: 				.MousePointer    = 15
355: 				.Visible         = .T.
356: 			ENDWITH
357: 			BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
358: 
359: 			*------------------------------------------------------------
360: 			*-- Cursor placeholder para vincular ao grid antes da primeira carga
361: 			*-- SET NULL ON: aceita NULLs do SQL Server no APPEND FROM
362: 			*------------------------------------------------------------

*-- Linhas 388 a 397:
388: 			loc_oPagina.AddObject("grd_4c_Lista", "Grid")
389: 			loc_oGrid = loc_oPagina.grd_4c_Lista
390: 
391: 			loc_oGrid.Top          = 117
392: 			loc_oGrid.Left         = 26
393: 			loc_oGrid.Width        = 890
394: 			loc_oGrid.Height       = 450
395: 			loc_oGrid.ColumnCount  = 12
396: 			loc_oGrid.RecordSource = "cursor_4c_Dados"
397: 

*-- Linhas 413 a 472:
413: 
414: 				.Column1.ControlSource   = "cursor_4c_Dados.numes"
415: 				.Column1.Width           = 55
416: 				.Column1.Header1.Caption = "N" + CHR(250) + "mero"
417: 				.Column1.Alignment       = 1
418: 
419: 				.Column2.ControlSource   = "cursor_4c_Dados.datas"
420: 				.Column2.Width           = 78
421: 				.Column2.Header1.Caption = "Data"
422: 				.Column2.Alignment       = 1
423: 
424: 				.Column3.ControlSource   = "cursor_4c_Dados.grupos"
425: 				.Column3.Width           = 65
426: 				.Column3.Header1.Caption = "Grupo"
427: 
428: 				.Column4.ControlSource   = "cursor_4c_Dados.contas"
429: 				.Column4.Width           = 75
430: 				.Column4.Header1.Caption = "Conta"
431: 
432: 				.Column5.ControlSource   = "cursor_4c_Dados.ifors"
433: 				.Column5.Width           = 100
434: 				.Column5.Header1.Caption = "Recuperadora"
435: 
436: 				.Column6.ControlSource   = "cursor_4c_Dados.tpmats"
437: 				.Column6.Width           = 68
438: 				.Column6.Header1.Caption = "Tp. Material"
439: 
440: 				.Column7.ControlSource   = "cursor_4c_Dados.brutos"
441: 				.Column7.Width           = 68
442: 				.Column7.Header1.Caption = "Bruto (g)"
443: 				.Column7.Alignment       = 1
444: 
445: 				.Column8.ControlSource   = "cursor_4c_Dados.trabs"
446: 				.Column8.Width           = 78
447: 				.Column8.Header1.Caption = "Trabalhado (g)"
448: 				.Column8.Alignment       = 1
449: 
450: 				.Column9.ControlSource   = "cursor_4c_Dados.falhas"
451: 				.Column9.Width           = 65
452: 				.Column9.Header1.Caption = "Falha (g)"
453: 				.Column9.Alignment       = 1
454: 
455: 				.Column10.ControlSource   = "cursor_4c_Dados.produzidos"
456: 				.Column10.Width           = 75
457: 				.Column10.Header1.Caption = "Produzido (g)"
458: 				.Column10.Alignment       = 1
459: 
460: 				.Column11.ControlSource   = "cursor_4c_Dados.pesoccbs"
461: 				.Column11.Width           = 72
462: 				.Column11.Header1.Caption = "Total C/Cob."
463: 				.Column11.Alignment       = 1
464: 
465: 				.Column12.ControlSource   = "cursor_4c_Dados.pesoscbs"
466: 				.Column12.Width           = 71
467: 				.Column12.Header1.Caption = "Total S/Cob."
468: 				.Column12.Alignment       = 1
469: 			ENDWITH
470: 
471: 			THIS.TornarControlesVisiveis(loc_oPagina)
472: 		CATCH TO loc_oErro

*-- Linhas 490 a 603:
490: 			*-- Container botoes de acao (Confirmar/Cancelar)
491: 			loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
492: 			WITH loc_oPagina.cnt_4c_BotoesAcao
493: 				.Top         = 33
494: 				.Left        = 842
495: 				.Width       = 160
496: 				.Height      = 85
497: 				.BackStyle   = 0
498: 				.BorderWidth = 0
499: 				.Visible     = .T.
500: 			ENDWITH
501: 
502: 			*-- Container saida na pagina de dados (padrao canonico)
503: 			loc_oPagina.AddObject("cnt_4c_Saida", "Container")
504: 			WITH loc_oPagina.cnt_4c_Saida
505: 				.Top         = 29
506: 				.Left        = 917
507: 				.Width       = 90
508: 				.Height      = 85
509: 				.BackStyle   = 0
510: 				.BorderWidth = 0
511: 				.Visible     = .T.
512: 			ENDWITH
513: 
514: 			*------------------------------------------------------------
515: 			*-- Botoes de acao: Confirmar e Cancelar
516: 			*------------------------------------------------------------
517: 			loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
518: 			WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
519: 				.Caption         = "Confirmar"
520: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
521: 				.PicturePosition = 13
522: 				.Top             = 5
523: 				.Left            = 5
524: 				.Width           = 75
525: 				.Height          = 75
526: 				.BackColor       = RGB(255, 255, 255)
527: 				.ForeColor       = RGB(90, 90, 90)
528: 				.FontName        = "Comic Sans MS"
529: 				.FontSize        = 8
530: 				.FontBold        = .T.
531: 				.FontItalic      = .T.
532: 				.Themes          = .F.
533: 				.SpecialEffect   = 0
534: 				.WordWrap        = .T.
535: 				.AutoSize        = .F.
536: 				.MousePointer    = 15
537: 				.Visible         = .T.
538: 			ENDWITH
539: 			BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
540: 
541: 			loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
542: 			WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
543: 				.Caption         = "Encerrar"
544: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
545: 				.PicturePosition = 13
546: 				.Top             = 5
547: 				.Left            = 80
548: 				.Width           = 75
549: 				.Height          = 75
550: 				.BackColor       = RGB(255, 255, 255)
551: 				.ForeColor       = RGB(90, 90, 90)
552: 				.FontName        = "Comic Sans MS"
553: 				.FontSize        = 8
554: 				.FontBold        = .T.
555: 				.FontItalic      = .T.
556: 				.Themes          = .F.
557: 				.SpecialEffect   = 0
558: 				.WordWrap        = .T.
559: 				.AutoSize        = .F.
560: 				.MousePointer    = 15
561: 				.Visible         = .T.
562: 			ENDWITH
563: 			BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
564: 
565: 			*-- Botao Encerrar na pagina de dados (padrao canonico)
566: 			loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
567: 			WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
568: 				.Caption         = "Encerrar"
569: 				.Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
570: 				.PicturePosition = 13
571: 				.Top             = 5
572: 				.Left            = 5
573: 				.Width           = 75
574: 				.Height          = 75
575: 				.BackColor       = RGB(255, 255, 255)
576: 				.ForeColor       = RGB(90, 90, 90)
577: 				.FontName        = "Comic Sans MS"
578: 				.FontSize        = 8
579: 				.FontBold        = .T.
580: 				.FontItalic      = .T.
581: 				.Themes          = .F.
582: 				.SpecialEffect   = 0
583: 				.WordWrap        = .T.
584: 				.AutoSize        = .F.
585: 				.MousePointer    = 15
586: 				.Visible         = .T.
587: 			ENDWITH
588: 			BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
589: 
590: 			*------------------------------------------------------------
591: 			*-- Label e campo Numero/Codigo
592: 			*-- getCodigos -> txt_4c_Codigos: editavel somente no modo BUSCAR
593: 			*------------------------------------------------------------
594: 			loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
595: 			WITH loc_oPagina.lbl_4c_Codigo
596: 				.Caption   = "C" + CHR(243) + "digo :"
597: 				.Top       = 221
598: 				.Left      = 189
599: 				.Width     = 42
600: 				.Height    = 17
601: 				.AutoSize  = .T.
602: 				.FontName  = "Tahoma"
603: 				.FontSize  = 8

*-- Linhas 610 a 636:
610: 				.Value     = ""
611: 				.InputMask = "999999"
612: 				.MaxLength = 7
613: 				.Top       = 216
614: 				.Left      = 242
615: 				.Width     = 52
616: 				.Height    = 25
617: 				.FontName  = "Tahoma"
618: 				.FontSize  = 8
619: 				.ReadOnly  = .T.
620: 				.Visible   = .T.
621: 			ENDWITH
622: 
623: 			*------------------------------------------------------------
624: 			*-- Label e campo Data
625: 			*-- getDatas -> txt_4c_Datas: editavel em INCLUIR/ALTERAR
626: 			*------------------------------------------------------------
627: 			loc_oPagina.AddObject("lbl_4c_Data", "Label")
628: 			WITH loc_oPagina.lbl_4c_Data
629: 				.Caption   = "Data :"
630: 				.Top       = 220
631: 				.Left      = 496
632: 				.Width     = 32
633: 				.Height    = 17
634: 				.AutoSize  = .T.
635: 				.FontName  = "Tahoma"
636: 				.FontSize  = 8

*-- Linhas 642 a 651:
642: 			WITH loc_oPagina.txt_4c_Datas
643: 				.Value     = {}
644: 				.MaxLength = 10
645: 				.Top       = 216
646: 				.Left      = 534
647: 				.Width     = 79
648: 				.Height    = 25
649: 				.FontName  = "Tahoma"
650: 				.FontSize  = 8
651: 				.ReadOnly  = .T.

*-- Linhas 657 a 666:
657: 			*------------------------------------------------------------
658: 			loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
659: 			WITH loc_oPagina.shp_4c_Shape1
660: 				.Top         = 203
661: 				.Left        = 166
662: 				.Width       = 466
663: 				.Height      = 296
664: 				.BackStyle   = 0
665: 				.BorderStyle = 0
666: 				.BorderColor = RGB(136, 189, 188)

*-- Linhas 672 a 684:
672: 			*-- getCdGrupo -> txt_4c_CdGrupo: lookup SigCdGcr (BalFalPers=1)
673: 			*-- getDsGrupo -> txt_4c_DsGrupo: descricao somente leitura
674: 			*------------------------------------------------------------
675: 			loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
676: 			WITH loc_oPagina.lbl_4c_Grupo
677: 				.Caption   = "Grupo :"
678: 				.Top       = 247
679: 				.Left      = 195
680: 				.Width     = 38
681: 				.Height    = 17
682: 				.AutoSize  = .T.
683: 				.FontName  = "Tahoma"
684: 				.FontSize  = 8

*-- Linhas 690 a 699:
690: 			WITH loc_oPagina.txt_4c_CdGrupo
691: 				.Value     = ""
692: 				.MaxLength = 10
693: 				.Top       = 243
694: 				.Left      = 242
695: 				.Width     = 79
696: 				.Height    = 25
697: 				.FontName  = "Courier New"
698: 				.FontSize  = 9
699: 				.ReadOnly  = .T.

*-- Linhas 707 a 716:
707: 			WITH loc_oPagina.txt_4c_DsGrupo
708: 				.Value     = ""
709: 				.MaxLength = 20
710: 				.Top       = 243
711: 				.Left      = 323
712: 				.Width     = 290
713: 				.Height    = 25
714: 				.FontName  = "Courier New"
715: 				.FontSize  = 9
716: 				.ReadOnly  = .T.

*-- Linhas 722 a 734:
722: 			*-- getCdConta -> txt_4c_CdConta: lookup SigCdCli filtrado por Grupo
723: 			*-- getDsConta -> txt_4c_DsConta: descricao somente leitura
724: 			*------------------------------------------------------------
725: 			loc_oPagina.AddObject("lbl_4c_Conta", "Label")
726: 			WITH loc_oPagina.lbl_4c_Conta
727: 				.Caption   = "Conta :"
728: 				.Top       = 275
729: 				.Left      = 196
730: 				.Width     = 38
731: 				.Height    = 17
732: 				.AutoSize  = .T.
733: 				.FontName  = "Tahoma"
734: 				.FontSize  = 8

*-- Linhas 740 a 749:
740: 			WITH loc_oPagina.txt_4c_CdConta
741: 				.Value     = ""
742: 				.MaxLength = 10
743: 				.Top       = 270
744: 				.Left      = 242
745: 				.Width     = 79
746: 				.Height    = 25
747: 				.FontName  = "Courier New"
748: 				.FontSize  = 9
749: 				.ReadOnly  = .T.

*-- Linhas 757 a 766:
757: 			WITH loc_oPagina.txt_4c_DsConta
758: 				.Value     = ""
759: 				.MaxLength = 40
760: 				.Top       = 270
761: 				.Left      = 323
762: 				.Width     = 290
763: 				.Height    = 25
764: 				.FontName  = "Courier New"
765: 				.FontSize  = 9
766: 				.ReadOnly  = .T.

*-- Linhas 773 a 809:
773: 			*------------------------------------------------------------
774: 			loc_oPagina.AddObject("cnt_4c_Container4", "Container")
775: 			WITH loc_oPagina.cnt_4c_Container4
776: 				.Top         = 298
777: 				.Left        = 192
778: 				.Width       = 421
779: 				.Height      = 29
780: 				.BackStyle   = 0
781: 				.BorderWidth = 0
782: 				.Visible     = .T.
783: 			ENDWITH
784: 
785: 			loc_oPagina.cnt_4c_Container4.AddObject("lbl_4c_Produzido", "Label")
786: 			WITH loc_oPagina.cnt_4c_Container4.lbl_4c_Produzido
787: 				.Caption   = "Produzido (g) :"
788: 				.Top       = 6
789: 				.Left      = 15
790: 				.Width     = 73
791: 				.Height    = 15
792: 				.AutoSize  = .F.
793: 				.FontName  = "Tahoma"
794: 				.FontSize  = 8
795: 				.BackStyle = 0
796: 				.Visible   = .T.
797: 			ENDWITH
798: 
799: 			loc_oPagina.cnt_4c_Container4.AddObject("txt_4c_Prdz", "TextBox")
800: 			WITH loc_oPagina.cnt_4c_Container4.txt_4c_Prdz
801: 				.Value     = .F.
802: 				.MaxLength = 15
803: 				.Top       = 3
804: 				.Left      = 104
805: 				.Width     = 80
806: 				.Height    = 23
807: 				.FontName  = "Tahoma"
808: 				.FontSize  = 8
809: 				.ReadOnly  = .T.

*-- Linhas 816 a 880:
816: 			*------------------------------------------------------------
817: 			loc_oPagina.AddObject("cnt_4c_Container3", "Container")
818: 			WITH loc_oPagina.cnt_4c_Container3
819: 				.Top         = 330
820: 				.Left        = 192
821: 				.Width       = 421
822: 				.Height      = 29
823: 				.BackStyle   = 0
824: 				.BorderWidth = 0
825: 				.Visible     = .T.
826: 			ENDWITH
827: 
828: 			loc_oPagina.cnt_4c_Container3.AddObject("lbl_4c_Trabalhado", "Label")
829: 			WITH loc_oPagina.cnt_4c_Container3.lbl_4c_Trabalhado
830: 				.Caption   = "Trabalhado (g) :"
831: 				.Top       = 6
832: 				.Left      = 9
833: 				.Width     = 80
834: 				.Height    = 15
835: 				.AutoSize  = .F.
836: 				.FontName  = "Tahoma"
837: 				.FontSize  = 8
838: 				.BackStyle = 0
839: 				.Visible   = .T.
840: 			ENDWITH
841: 
842: 			loc_oPagina.cnt_4c_Container3.AddObject("txt_4c_PTrab", "TextBox")
843: 			WITH loc_oPagina.cnt_4c_Container3.txt_4c_PTrab
844: 				.Value     = .F.
845: 				.MaxLength = 15
846: 				.Top       = 3
847: 				.Left      = 104
848: 				.Width     = 80
849: 				.Height    = 23
850: 				.FontName  = "Tahoma"
851: 				.FontSize  = 8
852: 				.ReadOnly  = .T.
853: 				.Visible   = .T.
854: 			ENDWITH
855: 
856: 			loc_oPagina.cnt_4c_Container3.AddObject("lbl_4c_Falha", "Label")
857: 			WITH loc_oPagina.cnt_4c_Container3.lbl_4c_Falha
858: 				.Caption   = "Falha  (g):"
859: 				.Top       = 6
860: 				.Left      = 233
861: 				.Width     = 55
862: 				.Height    = 15
863: 				.AutoSize  = .F.
864: 				.FontName  = "Tahoma"
865: 				.FontSize  = 8
866: 				.BackStyle = 0
867: 				.Visible   = .T.
868: 			ENDWITH
869: 
870: 			loc_oPagina.cnt_4c_Container3.AddObject("txt_4c_Pfalha", "TextBox")
871: 			WITH loc_oPagina.cnt_4c_Container3.txt_4c_Pfalha
872: 				.Value     = .F.
873: 				.MaxLength = 15
874: 				.Top       = 3
875: 				.Left      = 295
876: 				.Width     = 80
877: 				.Height    = 23
878: 				.FontName  = "Tahoma"
879: 				.FontSize  = 8
880: 				.ReadOnly  = .T.

*-- Linhas 887 a 936:
887: 			*------------------------------------------------------------
888: 			loc_oPagina.AddObject("cnt_4c_Container1", "Container")
889: 			WITH loc_oPagina.cnt_4c_Container1
890: 				.Top         = 362
891: 				.Left        = 192
892: 				.Width       = 421
893: 				.Height      = 58
894: 				.BackStyle   = 0
895: 				.BorderWidth = 0
896: 				.Visible     = .T.
897: 			ENDWITH
898: 
899: 			loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_PesoBruto", "Label")
900: 			WITH loc_oPagina.cnt_4c_Container1.lbl_4c_PesoBruto
901: 				.Caption   = "Peso Bruto (g) :"
902: 				.Top       = 8
903: 				.Left      = 9
904: 				.Width     = 78
905: 				.Height    = 15
906: 				.AutoSize  = .F.
907: 				.FontName  = "Tahoma"
908: 				.FontSize  = 8
909: 				.BackStyle = 0
910: 				.Visible   = .T.
911: 			ENDWITH
912: 
913: 			loc_oPagina.cnt_4c_Container1.AddObject("txt_4c_pesob", "TextBox")
914: 			WITH loc_oPagina.cnt_4c_Container1.txt_4c_pesob
915: 				.Value     = .F.
916: 				.MaxLength = 15
917: 				.Top       = 5
918: 				.Left      = 103
919: 				.Width     = 80
920: 				.Height    = 23
921: 				.FontName  = "Tahoma"
922: 				.FontSize  = 8
923: 				.ReadOnly  = .T.
924: 				.Visible   = .T.
925: 			ENDWITH
926: 
927: 			loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_Recuperadora", "Label")
928: 			WITH loc_oPagina.cnt_4c_Container1.lbl_4c_Recuperadora
929: 				.Caption   = "Recuperadora :"
930: 				.Top       = 32
931: 				.Left      = 11
932: 				.Width     = 77
933: 				.Height    = 15
934: 				.AutoSize  = .F.
935: 				.FontName  = "Tahoma"
936: 				.FontSize  = 8

*-- Linhas 942 a 967:
942: 			WITH loc_oPagina.cnt_4c_Container1.txt_4c_ifor
943: 				.Value     = ""
944: 				.MaxLength = 20
945: 				.Top       = 30
946: 				.Left      = 103
947: 				.Width     = 80
948: 				.Height    = 23
949: 				.FontName  = "Courier New"
950: 				.FontSize  = 9
951: 				.ReadOnly  = .T.
952: 				.Visible   = .T.
953: 			ENDWITH
954: 			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_ifor, "KeyPress", THIS, "ValidarIfor")
955: 			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_ifor, "KeyPress", THIS, "IforKeyPress")
956: 			BINDEVENT(loc_oPagina.cnt_4c_Container1.txt_4c_ifor, "DblClick", THIS, "IforDblClick")
957: 
958: 			loc_oPagina.cnt_4c_Container1.AddObject("lbl_4c_TpMat", "Label")
959: 			WITH loc_oPagina.cnt_4c_Container1.lbl_4c_TpMat
960: 				.Caption   = "Tipo de Material :"
961: 				.Top       = 8
962: 				.Left      = 193
963: 				.Width     = 85
964: 				.Height    = 15
965: 				.AutoSize  = .F.
966: 				.FontName  = "Tahoma"
967: 				.FontSize  = 8

*-- Linhas 973 a 982:
973: 			WITH loc_oPagina.cnt_4c_Container1.txt_4c_tpmat
974: 				.Value     = ""
975: 				.MaxLength = 10
976: 				.Top       = 5
977: 				.Left      = 294
978: 				.Width     = 115
979: 				.Height    = 23
980: 				.FontName  = "Courier New"
981: 				.FontSize  = 9
982: 				.ReadOnly  = .T.

*-- Linhas 990 a 999:
990: 			WITH loc_oPagina.cnt_4c_Container1.txt_4c_dfor
991: 				.Value     = ""
992: 				.MaxLength = 40
993: 				.Top       = 30
994: 				.Left      = 184
995: 				.Width     = 225
996: 				.Height    = 23
997: 				.FontName  = "Courier New"
998: 				.FontSize  = 9
999: 				.ReadOnly  = .T.

*-- Linhas 1010 a 1089:
1010: 			*------------------------------------------------------------
1011: 			loc_oPagina.AddObject("cnt_4c_Container2", "Container")
1012: 			WITH loc_oPagina.cnt_4c_Container2
1013: 				.Top         = 423
1014: 				.Left        = 192
1015: 				.Width       = 421
1016: 				.Height      = 53
1017: 				.BackStyle   = 0
1018: 				.BorderWidth = 0
1019: 				.Visible     = .T.
1020: 			ENDWITH
1021: 
1022: 			loc_oPagina.cnt_4c_Container2.AddObject("lbl_4c_MatRec", "Label")
1023: 			WITH loc_oPagina.cnt_4c_Container2.lbl_4c_MatRec
1024: 				.Caption   = "Material Recuperado"
1025: 				.Top       = 4
1026: 				.Left      = 146
1027: 				.Width     = 120
1028: 				.Height    = 15
1029: 				.AutoSize  = .F.
1030: 				.FontName  = "Tahoma"
1031: 				.FontSize  = 8
1032: 				.BackStyle = 0
1033: 				.Visible   = .T.
1034: 			ENDWITH
1035: 
1036: 			loc_oPagina.cnt_4c_Container2.AddObject("lbl_4c_TotCCob", "Label")
1037: 			WITH loc_oPagina.cnt_4c_Container2.lbl_4c_TotCCob
1038: 				.Caption   = "Total C/ Cobran" + CHR(231) + "a :"
1039: 				.Top       = 28
1040: 				.Left      = 14
1041: 				.Width     = 96
1042: 				.Height    = 15
1043: 				.AutoSize  = .F.
1044: 				.FontName  = "Tahoma"
1045: 				.FontSize  = 8
1046: 				.BackStyle = 0
1047: 				.Visible   = .T.
1048: 			ENDWITH
1049: 
1050: 			loc_oPagina.cnt_4c_Container2.AddObject("txt_4c_Totccb", "TextBox")
1051: 			WITH loc_oPagina.cnt_4c_Container2.txt_4c_Totccb
1052: 				.Value     = .F.
1053: 				.MaxLength = 15
1054: 				.Top       = 24
1055: 				.Left      = 129
1056: 				.Width     = 80
1057: 				.Height    = 23
1058: 				.FontName  = "Tahoma"
1059: 				.FontSize  = 8
1060: 				.ReadOnly  = .T.
1061: 				.Visible   = .T.
1062: 			ENDWITH
1063: 			BINDEVENT(loc_oPagina.cnt_4c_Container2.txt_4c_Totccb, "LostFocus", THIS, "AtualizarBaixas")
1064: 
1065: 			loc_oPagina.cnt_4c_Container2.AddObject("lbl_4c_TotSCob", "Label")
1066: 			WITH loc_oPagina.cnt_4c_Container2.lbl_4c_TotSCob
1067: 				.Caption   = "Total S/ Cobran" + CHR(231) + "a :"
1068: 				.Top       = 27
1069: 				.Left      = 217
1070: 				.Width     = 95
1071: 				.Height    = 15
1072: 				.AutoSize  = .F.
1073: 				.FontName  = "Tahoma"
1074: 				.FontSize  = 8
1075: 				.BackStyle = 0
1076: 				.Visible   = .T.
1077: 			ENDWITH
1078: 
1079: 			loc_oPagina.cnt_4c_Container2.AddObject("txt_4c_totscb", "TextBox")
1080: 			WITH loc_oPagina.cnt_4c_Container2.txt_4c_totscb
1081: 				.Value     = .F.
1082: 				.MaxLength = 15
1083: 				.Top       = 23
1084: 				.Left      = 332
1085: 				.Width     = 80
1086: 				.Height    = 23
1087: 				.FontName  = "Tahoma"
1088: 				.FontSize  = 8
1089: 				.ReadOnly  = .T.

*-- Linhas 1389 a 1398:
1389: 
1390: 			*-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
1391: 			IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1392: 				IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1393: 					loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1394: 				ENDIF
1395: 			ENDIF
1396: 
1397: 			*-- Campo Codigo: editavel somente no modo BUSCAR
1398: 			IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)

*-- Linhas 1482 a 1495:
1482: 		TRY
1483: 			loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
1484: 
1485: 			IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
1486: 				loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lEdicao
1487: 			ENDIF
1488: 
1489: 			IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
1490: 				loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
1491: 			ENDIF
1492: 		CATCH TO loc_oErro
1493: 			MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
1494: 		ENDTRY
1495: 	ENDPROC

*-- Linhas 2390 a 2398:
2390: 					loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.ReadOnly = loc_lReadOnly
2391: 					*-- Se passou a ser read-only, limpar valor (grupo/conta preenchem o fluxo)
2392: 					IF loc_lReadOnly
2393: 						loc_oPagina.cnt_4c_Container4.txt_4c_Prdz.Value = .F.
2394: 					ENDIF
2395: 				ENDIF
2396: 			ENDIF
2397: 		CATCH TO loc_oErro
2398: 			MsgErro("Erro em AjustarPrdzReadOnly: " + loc_oErro.Message, "Erro")


### BO (C:\4c\projeto\app\classes\FapBO.prg):
*====================================================================
* FapBO.prg
*
* Business Object para Envio para Recuperacao
* Tabela: SigCdFea
* PK: cidchaves (char 20)
*====================================================================

DEFINE CLASS FapBO AS BusinessBase

	*-- Chave primaria (char 20, gerada via fGerUniqueKey no legado)
	this_cCidChaves = ""

	*-- Numero sequencial visivel ao usuario
	this_nNumes     = 0

	*-- Empresa
	this_cEmps      = ""

	*-- Tipo ('F' ou outro - recebido como parametro ao abrir o form)
	this_cTipos     = ""

	*-- Data do envio
	this_dDatas     = {}

	*-- Grupo de conta corrente (codigo + descricao de lookup)
	this_cGrupos    = ""
	this_cDsGrupos  = ""

	*-- Conta corrente (codigo + descricao de lookup)
	this_cContas    = ""
	this_cDsContas  = ""

	*-- Recuperadora - codigo e nome (SigCdCli.IClis / RClis)
	this_cIfors     = ""
	this_cDsIfors   = ""

	*-- Tipo de material (SigOpOpt.Cods)
	this_cTpmats    = ""

	*-- Pesos em gramas
	this_nBrutos    = 0     && Peso Bruto
	this_nTrabs     = 0     && Peso Trabalhado
	this_nFalhas    = 0     && Peso Falha
	this_nProduzidos= 0     && Produzido

	*-- Totais de material recuperado
	this_nPesoccbs  = 0     && Total Com Cobranca
	this_nPesoscbs  = 0     && Total Sem Cobranca

	*-- Flag de baixa (bit -> logical)
	this_lBaixas    = .F.

	*-- Numero do balancete relacionado
	this_nNumbals   = 0

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lResultado
		loc_lResultado = .F.

		TRY
			DODEFAULT()
			THIS.this_cTabela    = "SigCdFea"
			THIS.this_cCampoChave = "cidchaves"
			loc_lResultado = .T.
		CATCH TO loException
			MsgErro("Erro ao inicializar FapBO: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lResultado
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna valor da PK para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN THIS.this_cCidChaves
	ENDPROC

	*====================================================================
	* Buscar - SELECT lista de registros (filtrado por empresa + tipo)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
					   " a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
					   " a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
					   " a.emps, a.tipos, a.numbals" + ;
					   " FROM SigCdFea a" + ;
					   " WHERE a.emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
					   " AND a.tipos = " + EscaparSQL(THIS.this_cTipos)

			IF !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " AND " + par_cFiltro
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.numes"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

			IF loc_nResultado > 0
				GO TOP IN cursor_4c_Dados
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Buscar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega registro pelo cidchaves
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.numes, a.datas, a.ifors, a.grupos, a.contas," + ;
					   " a.tpmats, a.brutos, a.trabs, a.falhas, a.produzidos," + ;
					   " a.pesoccbs, a.pesoscbs, a.baixas, a.cidchaves," + ;
					   " a.emps, a.tipos, a.numbals," + ;
					   " ISNULL(b.Descrs, '') AS ds_grupos," + ;
					   " ISNULL(c.RClis, '') AS ds_contas," + ;
					   " ISNULL(d.RClis, '') AS ds_ifors" + ;
					   " FROM SigCdFea a" + ;
					   " LEFT JOIN SigCdGcr b ON b.Codigos = a.grupos" + ;
					   " LEFT JOIN SigCdCli c ON c.IClis = a.contas" + ;
					   " LEFT JOIN SigCdCli d ON d.IClis = a.ifors" + ;
					   " WHERE a.cidchaves = " + EscaparSQL(par_cCodigo)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Registro n" + CHR(227) + "o encontrado.", "Erro")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED(par_cAliasCursor)
				SELECT (par_cAliasCursor)
				THIS.this_cCidChaves  = TratarNulo(cidchaves, "C")
				THIS.this_nNumes      = TratarNulo(numes, "N")
				THIS.this_cEmps       = TratarNulo(emps, "C")
				THIS.this_cTipos      = TratarNulo(tipos, "C")
				THIS.this_dDatas      = TratarNulo(datas, "D")
				THIS.this_cGrupos     = TratarNulo(grupos, "C")
				THIS.this_cContas     = TratarNulo(contas, "C")
				THIS.this_cIfors      = TratarNulo(ifors, "C")
				THIS.this_cTpmats     = TratarNulo(tpmats, "C")
				THIS.this_nBrutos     = TratarNulo(brutos, "N")
				THIS.this_nTrabs      = TratarNulo(trabs, "N")
				THIS.this_nFalhas     = TratarNulo(falhas, "N")
				THIS.this_nProduzidos = TratarNulo(produzidos, "N")
				THIS.this_nPesoccbs   = TratarNulo(pesoccbs, "N")
				THIS.this_nPesoscbs   = TratarNulo(pesoscbs, "N")
				THIS.this_lBaixas     = (TratarNulo(baixas, "N") = 1)
				THIS.this_nNumbals    = TratarNulo(numbals, "N")

				*-- Descricoes (apenas disponiveis no cursor de CarregarPorCodigo com JOIN)
				TRY
					THIS.this_cDsGrupos = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_grupos"))
					THIS.this_cDsContas = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_contas"))
					THIS.this_cDsIfors  = ALLTRIM(EVALUATE(par_cAliasCursor + ".ds_ifors"))
				CATCH
					&& Cursor sem descricoes - normal para Buscar()
				ENDTRY

				loc_lSucesso = .T.
			ENDIF
		CATCH TO loException
			MsgErro("Erro em CarregarDoCursor: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cChave, loc_nNumes
		loc_lSucesso = .F.

		TRY
			*-- Gerar cidchaves unico (20 chars)
			loc_cChave = LEFT(SYS(2015) + SYS(2015), 20)

			*-- Gerar proximo numes sequencial para empresa+tipo
			loc_nNumes = THIS.GerarProximoNumes()
			IF loc_nNumes <= 0
				MsgErro("Erro ao gerar n" + CHR(250) + "mero sequencial.", "Erro")
			ELSE
				THIS.this_cCidChaves = loc_cChave
				THIS.this_nNumes     = loc_nNumes
				THIS.this_cEmps      = go_4c_Sistema.cCodEmpresa

				loc_cSQL = "INSERT INTO SigCdFea" + ;
						   " (cidchaves, numes, emps, tipos, datas," + ;
						   "  grupos, contas, ifors, tpmats," + ;
						   "  brutos, trabs, falhas, produzidos," + ;
						   "  pesoccbs, pesoscbs, baixas, numbals)" + ;
						   " VALUES (" + ;
						   EscaparSQL(THIS.this_cCidChaves) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nNumes) + ", " + ;
						   EscaparSQL(THIS.this_cEmps) + ", " + ;
						   EscaparSQL(THIS.this_cTipos) + ", " + ;
						   FormatarDataSQL(THIS.this_dDatas) + ", " + ;
						   EscaparSQL(THIS.this_cGrupos) + ", " + ;
						   EscaparSQL(THIS.this_cContas) + ", " + ;
						   EscaparSQL(THIS.this_cIfors) + ", " + ;
						   EscaparSQL(THIS.this_cTpmats) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nBrutos) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nTrabs) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nFalhas) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nProduzidos) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nPesoccbs) + ", " + ;
						   FormatarNumeroSQL(THIS.this_nPesoscbs) + ", " + ;
						   IIF(THIS.this_lBaixas, "1", "0") + ", " + ;
						   FormatarNumeroSQL(THIS.this_nNumbals) + ;
						   ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")

				IF loc_nResultado >= 0
					THIS.RegistrarAuditoria("INSERT")
					loc_lSucesso = .T.
				ELSE
					MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
				ENDIF

				IF USED("cursor_4c_Ins")
					USE IN cursor_4c_Ins
				ENDIF
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Inserir: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdFea SET" + ;
					   " datas = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
					   " grupos = " + EscaparSQL(THIS.this_cGrupos) + ", " + ;
					   " contas = " + EscaparSQL(THIS.this_cContas) + ", " + ;
					   " ifors = " + EscaparSQL(THIS.this_cIfors) + ", " + ;
					   " tpmats = " + EscaparSQL(THIS.this_cTpmats) + ", " + ;
					   " brutos = " + FormatarNumeroSQL(THIS.this_nBrutos) + ", " + ;
					   " trabs = " + FormatarNumeroSQL(THIS.this_nTrabs) + ", " + ;
					   " falhas = " + FormatarNumeroSQL(THIS.this_nFalhas) + ", " + ;
					   " produzidos = " + FormatarNumeroSQL(THIS.this_nProduzidos) + ", " + ;
					   " pesoccbs = " + FormatarNumeroSQL(THIS.this_nPesoccbs) + ", " + ;
					   " pesoscbs = " + FormatarNumeroSQL(THIS.this_nPesoscbs) + ", " + ;
					   " baixas = " + IIF(THIS.this_lBaixas, "1", "0") + ", " + ;
					   " numbals = " + FormatarNumeroSQL(THIS.this_nNumbals) + ;
					   " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Upd")
				USE IN cursor_4c_Upd
			ENDIF
		CATCH TO loException
			MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE em SigCdFea
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdFea" + ;
					   " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")

			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Del")
				USE IN cursor_4c_Del
			ENDIF
		CATCH TO loException
			MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarGrupos - Carrega cursor de grupos disponiveis (BalFalPers=1)
	*====================================================================
	PROCEDURE BuscarGrupos()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr" + ;
					   " WHERE BalFalPers = 1 ORDER BY Codigos"

			IF USED("cursor_4c_Grupos")
				USE IN cursor_4c_Grupos
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar grupos: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarGrupos: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarContas - Carrega cursor de contas para um grupo (BalFalPers=1)
	*====================================================================
	PROCEDURE BuscarContas(par_cGrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.IClis, a.RClis" + ;
					   " FROM SigCdCli a" + ;
					   " JOIN SigCdGcr b ON b.Codigos = a.Grupos" + ;
					   " WHERE b.BalFalPers = 1"

			IF !EMPTY(par_cGrupo)
				loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(par_cGrupo)
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.IClis"

			IF USED("cursor_4c_Contas")
				USE IN cursor_4c_Contas
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Contas")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar contas: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarContas: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* BuscarTiposMaterial - Carrega cursor de tipos de material (Situas=3)
	*====================================================================
	PROCEDURE BuscarTiposMaterial()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT Cods, Descs FROM SigOpOpt ORDER BY Cods"

			IF USED("cursor_4c_TpMats")
				USE IN cursor_4c_TpMats
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TpMats")
			loc_lSucesso = (loc_nResultado > 0)

			IF !loc_lSucesso
				MsgErro("Erro ao carregar tipos de material: " + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loException
			MsgErro("Erro em BuscarTiposMaterial: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoNumes - Retorna proximo numero sequencial para empresa+tipo
	*====================================================================
	PROTECTED PROCEDURE GerarProximoNumes()
		LOCAL loc_cSQL, loc_nResultado, loc_nProximo
		loc_nProximo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(numes), 0) + 1 AS proximo" + ;
					   " FROM SigCdFea" + ;
					   " WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
					   " AND tipos = " + EscaparSQL(THIS.this_cTipos)

			IF USED("cursor_4c_Numes")
				USE IN cursor_4c_Numes
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Numes")

			IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Numes") > 0
				SELECT cursor_4c_Numes
				loc_nProximo = proximo
			ELSE
				MsgErro("Erro ao gerar n" + CHR(250) + "mero: " + CapturarErroSQL(), "Erro SQL")
			ENDIF

			IF USED("cursor_4c_Numes")
				USE IN cursor_4c_Numes
			ENDIF
		CATCH TO loException
			MsgErro("Erro em GerarProximoNumes: " + loException.Message, "Erro")
		ENDTRY

		RETURN loc_nProximo
	ENDPROC

ENDDEFINE

