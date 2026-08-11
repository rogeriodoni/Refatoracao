# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 203: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 303: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 339: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 431: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 456: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJUS.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (964 linhas total):

*-- Linhas 45 a 53:
45: 
46:         IF VARTYPE(par_cRetrabalho) = "C" AND !EMPTY(ALLTRIM(par_cRetrabalho))
47:             THIS.this_cRetrabalho = ALLTRIM(par_cRetrabalho)
48:             THIS.Caption = "Cadastro de Justificativas do Retrabalho " + ;
49:                            PROPER(ALLTRIM(par_cRetrabalho))
50:         ENDIF
51: 
52:         TRY
53:             loc_lSucesso = DODEFAULT()

*-- Linhas 98 a 116:
98:     PROTECTED PROCEDURE ConfigurarPageFrame()
99:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
100:         WITH THIS.pgf_4c_Paginas
101:             .Top        = -29
102:             .Left       = 0
103:             .Width      = THIS.Width
104:             .Height     = THIS.Height + 29
105:             .PageCount  = 2
106:             .Tabs       = .F.
107:             .TabStretch = 1
108:             .Page1.Caption   = "Lista"
109:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:             .Page1.BackColor = RGB(255, 255, 255)
111:             .Page2.Caption   = "Dados"
112:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:             .Page2.BackColor = RGB(255, 255, 255)
114:             .Visible = .T.
115:         ENDWITH
116: 

*-- Linhas 129 a 363:
129:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
130: 
131:         *-- Container cabecalho escuro (cntSombra no legado)
132:         *-- Compensa PageFrame.Top=-29: Top_original=2 + 29 = 31
133:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
134:         WITH loc_oPagina.cnt_4c_Cabecalho
135:             .Top         = 31
136:             .Left        = 0
137:             .Width       = THIS.Width
138:             .Height      = 80
139:             .BackColor   = RGB(100, 100, 100)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Caption   = THIS.Caption
147:             .Top       = 15
148:             .Left      = 10
149:             .Width     = THIS.Width - 12
150:             .Height    = 40
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
161:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
162:             .Caption   = THIS.Caption
163:             .Top       = 18
164:             .Left      = 10
165:             .Width     = THIS.Width - 12
166:             .Height    = 46
167:             .FontName  = "Tahoma"
168:             .FontSize  = 16
169:             .FontBold  = .T.
170:             .ForeColor = RGB(255, 255, 255)
171:             .BackStyle = 0
172:             .AutoSize  = .F.
173:             .Visible   = .T.
174:         ENDWITH
175: 
176:         *-- Container botoes CRUD (Grupo_op no legado)
177:         *-- Grupo_op.Left=307; escalonado para form 1000px
178:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
179:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
180:         WITH loc_oCnt
181:             .Top         = 29
182:             .Left        =  542
183:             .Width       = 390
184:             .Height      = 85
185:             .BackColor   = RGB(53, 53, 53)
186:             .BackStyle   = 1
187:             .BorderWidth = 0
188:             .Visible     = .T.
189:         ENDWITH
190: 
191:         *-- Botao Incluir (INSERIR no legado)
192:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
193:         WITH loc_oCnt.cmd_4c_Incluir
194:             .Caption         = "Incluir"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
196:             .PicturePosition = 13
197:             .Top             = 5
198:             .Left            = 5
199:             .Width           = 75
200:             .Height          = 75
201:             .BackColor       = RGB(255, 255, 255)
202:             .ForeColor       = RGB(90, 90, 90)
203:             .FontName        = "Comic Sans MS"
204:             .FontBold        = .T.
205:             .FontItalic      = .T.
206:             .FontSize        = 8
207:             .Themes          = .F.
208:             .SpecialEffect   = 0
209:             .MousePointer    = 15
210:             .WordWrap        = .T.
211:             .AutoSize        = .F.
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
215: 
216:         *-- Botao Visualizar (PROCURAR readonly no legado)
217:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
218:         WITH loc_oCnt.cmd_4c_Visualizar
219:             .Caption         = "Visualizar"
220:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
221:             .PicturePosition = 13
222:             .Top             = 5
223:             .Left            = 80
224:             .Width           = 75
225:             .Height          = 75
226:             .BackColor       = RGB(255, 255, 255)
227:             .ForeColor       = RGB(90, 90, 90)
228:             .FontName        = "Comic Sans MS"
229:             .FontBold        = .T.
230:             .FontItalic      = .T.
231:             .FontSize        = 8
232:             .Themes          = .F.
233:             .SpecialEffect   = 0
234:             .MousePointer    = 15
235:             .WordWrap        = .T.
236:             .AutoSize        = .F.
237:             .Visible         = .T.
238:         ENDWITH
239:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
240: 
241:         *-- Botao Alterar (ALTERAR no legado)
242:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
243:         WITH loc_oCnt.cmd_4c_Alterar
244:             .Caption         = "Alterar"
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
246:             .PicturePosition = 13
247:             .Top             = 5
248:             .Left            = 155
249:             .Width           = 75
250:             .Height          = 75
251:             .BackColor       = RGB(255, 255, 255)
252:             .ForeColor       = RGB(90, 90, 90)
253:             .FontName        = "Comic Sans MS"
254:             .FontBold        = .T.
255:             .FontItalic      = .T.
256:             .FontSize        = 8
257:             .Themes          = .F.
258:             .SpecialEffect   = 0
259:             .MousePointer    = 15
260:             .WordWrap        = .T.
261:             .AutoSize        = .F.
262:             .Visible         = .T.
263:         ENDWITH
264:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
265: 
266:         *-- Botao Excluir
267:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
268:         WITH loc_oCnt.cmd_4c_Excluir
269:             .Caption         = "Excluir"
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
271:             .PicturePosition = 13
272:             .Top             = 5
273:             .Left            = 230
274:             .Width           = 75
275:             .Height          = 75
276:             .BackColor       = RGB(255, 255, 255)
277:             .ForeColor       = RGB(90, 90, 90)
278:             .FontName        = "Comic Sans MS"
279:             .FontBold        = .T.
280:             .FontItalic      = .T.
281:             .FontSize        = 8
282:             .Themes          = .F.
283:             .SpecialEffect   = 0
284:             .MousePointer    = 15
285:             .WordWrap        = .T.
286:             .AutoSize        = .F.
287:             .Visible         = .T.
288:         ENDWITH
289:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
290: 
291:         *-- Botao Buscar (PROCURAR picker no legado)
292:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
293:         WITH loc_oCnt.cmd_4c_Buscar
294:             .Caption         = "Buscar"
295:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
296:             .PicturePosition = 13
297:             .Top             = 5
298:             .Left            = 305
299:             .Width           = 75
300:             .Height          = 75
301:             .BackColor       = RGB(255, 255, 255)
302:             .ForeColor       = RGB(90, 90, 90)
303:             .FontName        = "Comic Sans MS"
304:             .FontBold        = .T.
305:             .FontItalic      = .T.
306:             .FontSize        = 8
307:             .Themes          = .F.
308:             .SpecialEffect   = 0
309:             .MousePointer    = 15
310:             .WordWrap        = .T.
311:             .AutoSize        = .F.
312:             .Visible         = .T.
313:         ENDWITH
314:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
315: 
316:         *-- Container saida canonico - padrao CLAUDE.md regra #10
317:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
318:         WITH loc_oPagina.cnt_4c_Saida
319:             .Top         = 29
320:             .Left        = 917
321:             .Width       = 90
322:             .Height      = 85
323:             .BackStyle   = 0
324:             .BorderWidth = 0
325:             .Visible     = .T.
326:         ENDWITH
327: 
328:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
329:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
330:             .Caption         = "Encerrar"
331:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
332:             .PicturePosition = 13
333:             .Top             = 5
334:             .Left            = 5
335:             .Width           = 75
336:             .Height          = 75
337:             .BackColor       = RGB(255, 255, 255)
338:             .ForeColor       = RGB(90, 90, 90)
339:             .FontName        = "Comic Sans MS"
340:             .FontBold        = .T.
341:             .FontItalic      = .T.
342:             .FontSize        = 8
343:             .Themes          = .F.
344:             .SpecialEffect   = 0
345:             .MousePointer    = 15
346:             .WordWrap        = .T.
347:             .AutoSize        = .F.
348:             .Visible         = .T.
349:         ENDWITH
350:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:         *-- Grid de listagem (Grade no legado)
353:         *-- Top = 88 (framework original) + 29 (compensacao PageFrame) = 117
354:         *-- Tabela SigPrJst: Cods (PK), Descrs, cRetrabs
355:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
356:         loc_oGrid = loc_oPagina.grd_4c_Dados
357:         loc_oGrid.Top         = 117
358:         loc_oGrid.Left        = 12
359:         loc_oGrid.Width       = 890
360:         loc_oGrid.Height      = 470
361:         loc_oGrid.ColumnCount = 3
362:         WITH loc_oGrid
363:             .FontName           = "Verdana"

*-- Linhas 376 a 393:
376:             .Visible            = .T.
377:         ENDWITH
378:         WITH loc_oGrid.Column1
379:             .Header1.Caption = "C" + CHR(243) + "digo"
380:             .Width           = 80
381:             .Alignment       = 0
382:         ENDWITH
383:         WITH loc_oGrid.Column2
384:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
385:             .Width           = 650
386:         ENDWITH
387:         WITH loc_oGrid.Column3
388:             .Header1.Caption = "Retrabalho"
389:             .Width           = 120
390:         ENDWITH
391: 
392:         THIS.TornarControlesVisiveis(loc_oPagina)
393:     ENDPROC

*-- Linhas 404 a 480:
404:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
405: 
406:         *-- Container botoes acao (Grupo_Salva no legado)
407:         *-- Grupo_Salva.Left=619, Top=13; compensacao PageFrame (+29): Top=42
408:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
409:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
410:         WITH loc_oCnt
411:             .Top         = 42
412:             .Left        = 619
413:             .Width       = 160
414:             .Height      = 85
415:             .BackStyle   = 0
416:             .Visible     = .T.
417:         ENDWITH
418: 
419:         *-- Botao Confirmar (Grupo_Salva.Salva no legado: Top=5, Left=5)
420:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
421:         WITH loc_oCnt.cmd_4c_Confirmar
422:             .Caption         = "Confirmar"
423:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
424:             .PicturePosition = 13
425:             .Top             = 5
426:             .Left            = 5
427:             .Width           = 75
428:             .Height          = 75
429:             .BackColor       = RGB(255, 255, 255)
430:             .ForeColor       = RGB(90, 90, 90)
431:             .FontName        = "Comic Sans MS"
432:             .FontBold        = .T.
433:             .FontItalic      = .T.
434:             .FontSize        = 8
435:             .Themes          = .F.
436:             .SpecialEffect   = 0
437:             .MousePointer    = 15
438:             .WordWrap        = .T.
439:             .AutoSize        = .F.
440:             .Visible         = .T.
441:         ENDWITH
442:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
443: 
444:         *-- Botao Cancelar (Grupo_Salva.Cancelar no legado: Top=5, Left=80)
445:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
446:         WITH loc_oCnt.cmd_4c_Cancelar
447:             .Caption         = "Encerrar"
448:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
449:             .PicturePosition = 13
450:             .Top             = 5
451:             .Left            = 80
452:             .Width           = 75
453:             .Height          = 75
454:             .BackColor       = RGB(255, 255, 255)
455:             .ForeColor       = RGB(90, 90, 90)
456:             .FontName        = "Comic Sans MS"
457:             .FontBold        = .T.
458:             .FontItalic      = .T.
459:             .FontSize        = 8
460:             .Themes          = .F.
461:             .SpecialEffect   = 0
462:             .MousePointer    = 15
463:             .WordWrap        = .T.
464:             .AutoSize        = .F.
465:             .Visible         = .T.
466:         ENDWITH
467:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
468: 
469:         *-- Label "Codigo :" (Say7 no legado: Top=89, Left=161)
470:         *-- Compensacao PageFrame (+29): Top=118
471:         loc_oPagina.AddObject("lbl_4c_Codigo", "Label")
472:         WITH loc_oPagina.lbl_4c_Codigo
473:             .Caption   = "C" + CHR(243) + "digo :"
474:             .Top       = 118
475:             .Left      = 161
476:             .Height    = 17
477:             .Width     = 58
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .FontBold  = .F.

*-- Linhas 490 a 499:
490:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
491:         WITH loc_oPagina.txt_4c_Codigo
492:             .Value     = ""
493:             .Top       = 115
494:             .Left      = 215
495:             .Width     = 31
496:             .Height    = 23
497:             .MaxLength = 3
498:             .ForeColor = RGB(0, 0, 0)
499:             .FontName  = "Tahoma"

*-- Linhas 505 a 517:
505: 
506:         *-- Label "Descricao :" (Say2 no legado: Top=117, Left=148, Width=58, Height=15)
507:         *-- Compensacao PageFrame (+29): Top=146
508:         loc_oPagina.AddObject("lbl_4c_Descricao", "Label")
509:         WITH loc_oPagina.lbl_4c_Descricao
510:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
511:             .Top       = 146
512:             .Left      = 148
513:             .Width     = 58
514:             .Height    = 15
515:             .FontName  = "Tahoma"
516:             .FontSize  = 8
517:             .FontBold  = .F.

*-- Linhas 527 a 536:
527:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
528:         WITH loc_oPagina.txt_4c_Descr
529:             .Value     = ""
530:             .Top       = 141
531:             .Left      = 215
532:             .Width     = 220
533:             .Height    = 25
534:             .MaxLength = 30
535:             .ForeColor = RGB(0, 0, 0)
536:             .FontName  = "Tahoma"

*-- Linhas 568 a 578:
568:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
569:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cRetrabs"
570:                     *-- Reconfigurar headers: RecordSource reseta captions
571:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
572:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
573:                     loc_oGrid.Column3.Header1.Caption = "Retrabalho"
574:                     THIS.FormatarGridLista(loc_oGrid)
575:                     loc_lResultado = .T.
576:                 ENDIF
577:             ENDIF
578: 

*-- Linhas 888 a 897:
888:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
889:         loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
890: 
891:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
892:             loc_oCnt.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
893:         ENDIF
894:     ENDPROC
895: 
896:     *==========================================================================
897:     * BtnSalvarClick - Valida, salva e volta para lista


### BO (C:\4c\projeto\app\classes\JUSBO.prg):
*==============================================================================
* JUSBO.prg - Business Object para Justificativas do Retrabalho (SigPrJst)
*==============================================================================

DEFINE CLASS JUSBO AS BusinessBase

    *-- Chave primaria
    this_cCidChaves = ""   && cidchaves char(20) - PK gerada por fUniqueIds()

    *-- Campos da tabela SigPrJst
    this_cCods      = ""   && cods char(3) - codigo da justificativa
    this_cRetrabs   = ""   && cretrabs char(6) - tipo de retrabalho (FK)
    this_cDescrs    = ""   && descrs char(30) - descricao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrJst"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * REGRA: Sempre SELECT (alias) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCods      = TratarNulo(cods, "C")
            THIS.this_cRetrabs   = TratarNulo(cRetrabs, "C")
            THIS.this_cDescrs    = TratarNulo(descrs, "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista justificativas com filtro WHERE opcional
    * par_cFiltro: condicao sem a palavra WHERE (ex: "cRetrabs = 'X'")
    * Resultado em cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cods, cRetrabs, descrs" + ;
                       " FROM SigPrJst"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + ALLTRIM(par_cFiltro)
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cods"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar justificativas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega justificativa pelo codigo (cods) - igual ao legado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCods)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cods, cRetrabs, descrs" + ;
                       " FROM SigPrJst" + ;
                       " WHERE cods = " + EscaparSQL(ALLTRIM(par_cCods))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos obrigatorios e unicidade antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .T.

        TRY
            *-- Codigo obrigatorio
            IF EMPTY(ALLTRIM(THIS.this_cCods))
                MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ENDIF

            *-- Validar duplicidade no INSERT: cods+cretrabs devem ser unicos
            IF loc_lResultado AND THIS.this_lNovoRegistro
                loc_cSQL = "SELECT cidchaves FROM SigPrJst" + ;
                           " WHERE cods = " + EscaparSQL(THIS.this_cCods) + ;
                           " AND cRetrabs = " + EscaparSQL(THIS.this_cRetrabs)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
                IF loc_nResultado >= 0 AND USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    SELECT cursor_4c_Dup
                    MsgAviso("Justificativa j" + CHR(225) + " cadastrada para o Retrabalho " + ;
                             ALLTRIM(THIS.this_cRetrabs), "")
                    loc_lResultado = .F.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrJst
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            THIS.this_cCidChaves = fUniqueIds()

            loc_cSQL = "INSERT INTO SigPrJst" + ;
                       " (cidchaves, cods, cRetrabs, descrs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCods) + ", " + ;
                       EscaparSQL(THIS.this_cRetrabs) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrJst (cods nao atualiza em modo ALTERAR pois
    * o original so habilita get_Descr no ALTERAR, mantendo cods readonly)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrJst SET" + ;
                       " descrs = " + EscaparSQL(THIS.this_cDescrs) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigPrJst
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrJst" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir justificativa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Del")
            USE IN cursor_4c_Del
        ENDIF

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

