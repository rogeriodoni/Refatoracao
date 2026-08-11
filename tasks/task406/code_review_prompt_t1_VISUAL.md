# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 190: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 215: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 240: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 265: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 290: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 327: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 417: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 441: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormENR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1074 linhas total):

*-- Linhas 51 a 69:
51:         loc_lResultado = .F.
52: 
53:         TRY
54:             THIS.Caption = "Endere" + CHR(231) + CHR(111) + "s"
55: 
56:             THIS.this_oBusinessObject = CREATEOBJECT("ENRBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MsgErro("Falha ao criar ENRBO", "Erro")
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                     THIS.CarregarLista()
68:                 ENDIF
69: 

*-- Linhas 88 a 107:
88:         loc_oPgf = THIS.pgf_4c_Paginas
89: 
90:         loc_oPgf.PageCount = 2
91:         loc_oPgf.Top       = -29
92:         loc_oPgf.Left      = 0
93:         loc_oPgf.Width     = THIS.Width
94:         loc_oPgf.Height    = THIS.Height + 29
95:         loc_oPgf.Tabs      = .F.
96:         loc_oPgf.Visible   = .T.
97: 
98:         WITH loc_oPgf
99:             .Page1.Caption   = "Lista"
100:             .Page1.BackColor = RGB(100, 100, 100)
101:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.Caption   = "Dados"
103:             .Page2.BackColor = RGB(100, 100, 100)
104:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()

*-- Linhas 120 a 158:
120:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
121:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
122:         WITH loc_oCab
123:             .Top         = 31
124:             .Left        = 0
125:             .Width       = THIS.Width
126:             .Height      = 80
127:             .BackColor   = RGB(100, 100, 100)
128:             .BorderWidth = 0
129:             .Visible     = .T.
130:         ENDWITH
131: 
132:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oCab.lbl_4c_Sombra
134:             .AutoSize  = .F.
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = THIS.Width
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oCab.lbl_4c_Titulo
150:             .AutoSize  = .F.
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10
154:             .Width     = THIS.Width
155:             .Height    = 46
156:             .FontName  = "Tahoma"
157:             .FontSize  = 16
158:             .FontBold  = .T.

*-- Linhas 165 a 355:
165:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
166:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
167:         WITH loc_oBotoes
168:             .Top         = 29
169:             .Left        = 542
170:             .Width       = 390
171:             .Height      = 85
172:             .BackColor   = RGB(53, 53, 53)
173:             .BackStyle   = 1
174:             .BorderWidth = 0
175:             .Visible     = .T.
176:         ENDWITH
177: 
178:         *-- Botao Incluir (Left=5)
179:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
180:         WITH loc_oBotoes.cmd_4c_Incluir
181:             .Caption         = "Incluir"
182:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
183:             .PicturePosition = 13
184:             .Top             = 5
185:             .Left            = 5
186:             .Width           = 75
187:             .Height          = 75
188:             .BackColor       = RGB(255, 255, 255)
189:             .ForeColor       = RGB(90, 90, 90)
190:             .FontName        = "Comic Sans MS"
191:             .FontSize        = 8
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .Themes          = .F.
195:             .SpecialEffect   = 0
196:             .MousePointer    = 15
197:             .WordWrap        = .T.
198:             .AutoSize        = .F.
199:             .Visible         = .T.
200:         ENDWITH
201:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
202: 
203:         *-- Botao Visualizar (Left=80)
204:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
205:         WITH loc_oBotoes.cmd_4c_Visualizar
206:             .Caption         = "Visualizar"
207:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
208:             .PicturePosition = 13
209:             .Top             = 5
210:             .Left            = 80
211:             .Width           = 75
212:             .Height          = 75
213:             .BackColor       = RGB(255, 255, 255)
214:             .ForeColor       = RGB(90, 90, 90)
215:             .FontName        = "Comic Sans MS"
216:             .FontSize        = 8
217:             .FontBold        = .T.
218:             .FontItalic      = .T.
219:             .Themes          = .F.
220:             .SpecialEffect   = 0
221:             .MousePointer    = 15
222:             .WordWrap        = .T.
223:             .AutoSize        = .F.
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
227: 
228:         *-- Botao Alterar (Left=155)
229:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
230:         WITH loc_oBotoes.cmd_4c_Alterar
231:             .Caption         = "Alterar"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
233:             .PicturePosition = 13
234:             .Top             = 5
235:             .Left            = 155
236:             .Width           = 75
237:             .Height          = 75
238:             .BackColor       = RGB(255, 255, 255)
239:             .ForeColor       = RGB(90, 90, 90)
240:             .FontName        = "Comic Sans MS"
241:             .FontSize        = 8
242:             .FontBold        = .T.
243:             .FontItalic      = .T.
244:             .Themes          = .F.
245:             .SpecialEffect   = 0
246:             .MousePointer    = 15
247:             .WordWrap        = .T.
248:             .AutoSize        = .F.
249:             .Visible         = .T.
250:         ENDWITH
251:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
252: 
253:         *-- Botao Excluir (Left=230)
254:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
255:         WITH loc_oBotoes.cmd_4c_Excluir
256:             .Caption         = "Excluir"
257:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
258:             .PicturePosition = 13
259:             .Top             = 5
260:             .Left            = 230
261:             .Width           = 75
262:             .Height          = 75
263:             .BackColor       = RGB(255, 255, 255)
264:             .ForeColor       = RGB(90, 90, 90)
265:             .FontName        = "Comic Sans MS"
266:             .FontSize        = 8
267:             .FontBold        = .T.
268:             .FontItalic      = .T.
269:             .Themes          = .F.
270:             .SpecialEffect   = 0
271:             .MousePointer    = 15
272:             .WordWrap        = .T.
273:             .AutoSize        = .F.
274:             .Visible         = .T.
275:         ENDWITH
276:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
277: 
278:         *-- Botao Buscar (Left=305)
279:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
280:         WITH loc_oBotoes.cmd_4c_Buscar
281:             .Caption         = "Buscar"
282:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
283:             .PicturePosition = 13
284:             .Top             = 5
285:             .Left            = 305
286:             .Width           = 75
287:             .Height          = 75
288:             .BackColor       = RGB(255, 255, 255)
289:             .ForeColor       = RGB(90, 90, 90)
290:             .FontName        = "Comic Sans MS"
291:             .FontSize        = 8
292:             .FontBold        = .T.
293:             .FontItalic      = .T.
294:             .Themes          = .F.
295:             .SpecialEffect   = 0
296:             .MousePointer    = 15
297:             .WordWrap        = .T.
298:             .AutoSize        = .F.
299:             .Visible         = .T.
300:         ENDWITH
301:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
302: 
303:         *-- Container Encerrar (canonico: Top=29, Left=917, Width=90)
304:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
305:         loc_oSaida = loc_oPg1.cnt_4c_Saida
306:         WITH loc_oSaida
307:             .Top         = 29
308:             .Left        = 917
309:             .Width       = 90
310:             .Height      = 85
311:             .BackStyle   = 0
312:             .BorderWidth = 0
313:             .Visible     = .T.
314:         ENDWITH
315: 
316:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
317:         WITH loc_oSaida.cmd_4c_Encerrar
318:             .Caption         = "Encerrar"
319:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
320:             .PicturePosition = 13
321:             .Top             = 5
322:             .Left            = 5
323:             .Width           = 75
324:             .Height          = 75
325:             .BackColor       = RGB(255, 255, 255)
326:             .ForeColor       = RGB(90, 90, 90)
327:             .FontName        = "Comic Sans MS"
328:             .FontSize        = 8
329:             .FontBold        = .T.
330:             .FontItalic      = .T.
331:             .Themes          = .F.
332:             .SpecialEffect   = 0
333:             .MousePointer    = 15
334:             .WordWrap        = .T.
335:             .AutoSize        = .F.
336:             .Visible         = .T.
337:         ENDWITH
338:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
339: 
340:         *-- Grid de lista (Top = 88+29 = 117, Width nao alcanca cnt_4c_Saida)
341:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
342:         loc_oGrid = loc_oPg1.grd_4c_Lista
343: 
344:         *-- RecordSource e ColumnCount FORA de WITH (problema #36)
345:         loc_oGrid.RecordSource = ""
346:         loc_oGrid.ColumnCount  = 3
347: 
348:         WITH loc_oGrid
349:             .Top               = 117
350:             .Left              = 26
351:             .Width             = 880
352:             .Height            = 455
353:             .FontName          = "Verdana"
354:             .FontSize          = 8
355:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 394 a 464:
394:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
395:         loc_oSalva = loc_oPg2.cnt_4c_Salva
396:         WITH loc_oSalva
397:             .Top         = 33
398:             .Left        = 842
399:             .Width       = 160
400:             .Height      = 85
401:             .BackStyle   = 0
402:             .BorderWidth = 0
403:             .Visible     = .T.
404:         ENDWITH
405: 
406:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
407:         WITH loc_oSalva.cmd_4c_Confirmar
408:             .Caption         = "Confirmar"
409:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
410:             .PicturePosition = 13
411:             .Top             = 5
412:             .Left            = 5
413:             .Width           = 75
414:             .Height          = 75
415:             .BackColor       = RGB(255, 255, 255)
416:             .ForeColor       = RGB(90, 90, 90)
417:             .FontName        = "Comic Sans MS"
418:             .FontSize        = 8
419:             .FontBold        = .T.
420:             .FontItalic      = .T.
421:             .Themes          = .F.
422:             .SpecialEffect   = 0
423:             .MousePointer    = 15
424:             .WordWrap        = .T.
425:             .AutoSize        = .F.
426:             .Visible         = .T.
427:         ENDWITH
428:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
429: 
430:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
431:         WITH loc_oSalva.cmd_4c_Cancelar
432:             .Caption         = "Encerrar"
433:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
434:             .PicturePosition = 13
435:             .Top             = 5
436:             .Left            = 80
437:             .Width           = 75
438:             .Height          = 75
439:             .BackColor       = RGB(255, 255, 255)
440:             .ForeColor       = RGB(90, 90, 90)
441:             .FontName        = "Comic Sans MS"
442:             .FontSize        = 8
443:             .FontBold        = .T.
444:             .FontItalic      = .T.
445:             .Themes          = .F.
446:             .SpecialEffect   = 0
447:             .MousePointer    = 15
448:             .WordWrap        = .T.
449:             .AutoSize        = .F.
450:             .Visible         = .T.
451:         ENDWITH
452:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
453: 
454:         *-- Label CEP (Say6: top=196+29=225, left=196)
455:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
456:         WITH loc_oPg2.lbl_4c_Label6
457:             .Caption   = "CEP :"
458:             .Top       = 225
459:             .Left      = 196
460:             .Width     = 30
461:             .Height    = 17
462:             .AutoSize  = .F.
463:             .FontName  = "Tahoma"
464:             .FontSize  = 8

*-- Linhas 473 a 482:
473:         loc_oPg2.AddObject("txt_4c_CEP", "TextBox")
474:         WITH loc_oPg2.txt_4c_CEP
475:             .Value       = ""
476:             .Top         = 222
477:             .Left        = 226
478:             .Width       = 80
479:             .Height      = 23
480:             .MaxLength   = 9
481:             .InputMask   = "99999-999"
482:             .FontName    = "Tahoma"

*-- Linhas 490 a 502:
490:         BINDEVENT(loc_oPg2.txt_4c_CEP, "LostFocus", THIS, "LostFocusCEP")
491: 
492:         *-- Label Endere?o (Say4: top=219+29=248, left=170)
493:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
494:         WITH loc_oPg2.lbl_4c_Label4
495:             .Caption   = "Endere" + CHR(231) + "o :"
496:             .Top       = 248
497:             .Left      = 170
498:             .Width     = 56
499:             .Height    = 17
500:             .AutoSize  = .F.
501:             .FontName  = "Tahoma"
502:             .FontSize  = 8

*-- Linhas 511 a 520:
511:         loc_oPg2.AddObject("txt_4c_Endereco", "TextBox")
512:         WITH loc_oPg2.txt_4c_Endereco
513:             .Value       = ""
514:             .Top         = 245
515:             .Left        = 226
516:             .Width       = 403
517:             .Height      = 23
518:             .MaxLength   = 60
519:             .FontName    = "Tahoma"
520:             .FontSize    = 8

*-- Linhas 528 a 540:
528:         BINDEVENT(loc_oPg2.txt_4c_Endereco, "LostFocus", THIS, "LostFocusEndereco")
529: 
530:         *-- Label Bairro (Say5: top=242+29=271, left=187)
531:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
532:         WITH loc_oPg2.lbl_4c_Label5
533:             .Caption   = "Bairro :"
534:             .Top       = 271
535:             .Left      = 187
536:             .Width     = 40
537:             .Height    = 17
538:             .AutoSize  = .F.
539:             .FontName  = "Tahoma"
540:             .FontSize  = 8

*-- Linhas 549 a 558:
549:         loc_oPg2.AddObject("txt_4c_Bairro", "TextBox")
550:         WITH loc_oPg2.txt_4c_Bairro
551:             .Value       = ""
552:             .Top         = 268
553:             .Left        = 226
554:             .Width       = 272
555:             .Height      = 23
556:             .MaxLength   = 60
557:             .FontName    = "Tahoma"
558:             .FontSize    = 8

*-- Linhas 590 a 600:
590:                     loc_oGrid.Column3.ControlSource = "crSigCdEnr.bairs"
591: 
592:                     *-- Reconfigura??o de headers apos RecordSource (obrigatorio - problema #32)
593:                     loc_oGrid.Column1.Header1.Caption = "CEP"
594:                     loc_oGrid.Column2.Header1.Caption = "Endere" + CHR(231) + "o"
595:                     loc_oGrid.Column3.Header1.Caption = "Bairro"
596: 
597:                     *-- Larguras das colunas
598:                     loc_oGrid.Column1.Width = 100
599:                     loc_oGrid.Column2.Width = 450
600:                     loc_oGrid.Column3.Width = 300

*-- Linhas 713 a 741:
713:             loc_oPg2.txt_4c_Bairro.Enabled   = par_lHabilitar
714:         ENDIF
715: 
716:         IF PEMSTATUS(loc_oSalva, "cmd_4c_Confirmar", 5)
717:             loc_oSalva.cmd_4c_Confirmar.Enabled = par_lHabilitar
718:         ENDIF
719:         IF PEMSTATUS(loc_oSalva, "cmd_4c_Cancelar", 5)
720:             loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
721:         ENDIF
722:     ENDPROC
723: 
724:     *====================================================================
725:     * AjustarBotoesPorModo - Configura botoes conforme o modo atual
726:     *====================================================================
727:     PROTECTED PROCEDURE AjustarBotoesPorModo()
728:         LOCAL loc_lPodeEditar, loc_oSalva
729:         loc_lPodeEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
730:         loc_oSalva = THIS.pgf_4c_Paginas.Page2.cnt_4c_Salva
731: 
732:         IF PEMSTATUS(loc_oSalva, "cmd_4c_Confirmar", 5)
733:             loc_oSalva.cmd_4c_Confirmar.Enabled = loc_lPodeEditar
734:         ENDIF
735:         IF PEMSTATUS(loc_oSalva, "cmd_4c_Cancelar", 5)
736:             loc_oSalva.cmd_4c_Cancelar.Enabled = .T.
737:         ENDIF
738:     ENDPROC
739: 
740:     *====================================================================
741:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente


### BO (C:\4c\projeto\app\classes\ENRBO.prg):
*====================================================================
* ENRBO.prg
*
* Business Object para Enderecos (Cadastro de Enderecos - SigCdEnr)
* Tabela principal: SigCdEnr (pkchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS ENRBO AS BusinessBase

	*-- Propriedades da entidade (tabela: SigCdEnr)
	this_cPkChaves  = ""   && pkchaves char(20) - PK (ID gerado via SQL NEWID)
	this_cCep       = ""   && ceps     char(9)  - CEP (formato 99999-999)
	this_cEndereco  = ""   && endes    char(60) - Endereco
	this_cBairro    = ""   && bairs    char(40) - Bairro

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdEnr"
		THIS.this_cCampoChave = "pkchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cPkChaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de enderecos no cursor crSigCdEnr
	* par_cFiltro: trecho de CEP ou endereco para filtrar (vazio = todos)
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " ORDER BY ceps"
			ELSE
				loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
				           " FROM SigCdEnr" + ;
				           " WHERE ceps LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " OR endes LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
				           " ORDER BY ceps"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEnr")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar endere" + CHR(231) + "os:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo pkchaves (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cPkChaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT pkchaves, ceps, endes, bairs" + ;
			           " FROM SigCdEnr" + ;
			           " WHERE pkchaves = " + EscaparSQL(ALLTRIM(par_cPkChaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cPkChaves  = TratarNulo(pkchaves, "C")
			THIS.this_cCep       = TratarNulo(ceps,     "C")
			THIS.this_cEndereco  = TratarNulo(endes,    "C")
			THIS.this_cBairro    = TratarNulo(bairs,    "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicado - Verifica se endereco ja esta cadastrado
	* Retorna .T. se ja existe (duplicado), .F. se pode inserir
	*====================================================================
	PROTECTED PROCEDURE VerificarDuplicado()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS total FROM SigCdEnr" + ;
			           " WHERE ceps  = " + EscaparSQL(THIS.this_cCep)      + ;
			           " AND   endes = " + EscaparSQL(THIS.this_cEndereco) + ;
			           " AND   bairs = " + EscaparSQL(THIS.this_cBairro)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
				SELECT cursor_4c_DupCheck
				loc_lDuplicado = (cursor_4c_DupCheck.total > 0)
			ENDIF

			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_DupCheck")
				USE IN cursor_4c_DupCheck
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(ALLTRIM(THIS.this_cCep))
				MsgAviso("Obrigat" + CHR(243) + "rio informar o CEP.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
			    IF THIS.VerificarDuplicado()
				MsgErro("Endere" + CHR(231) + "o j" + CHR(225) + " cadastrado.", "Valida" + CHR(231) + CHR(227) + "o")
			ELSE
				*-- Gerar chave unica via SQL Server NEWID()
				loc_nResultado = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_Uuid")
				IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
					SELECT cursor_4c_Uuid
					THIS.this_cPkChaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
				ENDIF
				IF USED("cursor_4c_Uuid")
					USE IN cursor_4c_Uuid
				ENDIF

				IF EMPTY(THIS.this_cPkChaves)
					MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				ELSE
					loc_cSQL = "INSERT INTO SigCdEnr (pkchaves, ceps, endes, bairs)" + ;
					           " VALUES (" + ;
					           EscaparSQL(THIS.this_cPkChaves)  + "," + ;
					           EscaparSQL(THIS.this_cCep)       + "," + ;
					           EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
					           EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
					           ")"

					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			    ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdEnr SET" + ;
			           " ceps  = " + EscaparSQL(THIS.this_cCep)                      + "," + ;
			           " endes = " + EscaparSQL(LEFT(THIS.this_cEndereco, 60)) + "," + ;
			           " bairs = " + EscaparSQL(LEFT(THIS.this_cBairro, 40))   + ;
			           " WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdEnr
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdEnr WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir endere" + CHR(231) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

