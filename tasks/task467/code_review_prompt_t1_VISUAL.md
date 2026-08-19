# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 201: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 225: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 273: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 297: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 334: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 414: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
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

### FORM (C:\4c\projeto\app\forms\cadastros\Formmpp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (957 linhas total):

*-- Linhas 49 a 62:
49: 
50:         DO CASE
51:         CASE THIS.this_nTipo = 1
52:             THIS.Caption = "Complementos de Caracter" + CHR(237) + "sticas de Contas"
53:         CASE THIS.this_nTipo = 2
54:             THIS.Caption = "Complementos de Caracter" + CHR(237) + ;
55:                 "sticas de Movimenta" + CHR(231) + CHR(245) + "es"
56:         OTHERWISE
57:             THIS.Caption = "Complementos de Caracter" + CHR(237) + "sticas de Produtos"
58:         ENDCASE
59: 
60:         RETURN DODEFAULT()
61:     ENDPROC
62: 

*-- Linhas 102 a 124:
102:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
103:         loc_oPf = THIS.pgf_4c_Paginas
104: 
105:         loc_oPf.Top       = -29
106:         loc_oPf.Left      = 0
107:         loc_oPf.Height    = 629
108:         loc_oPf.Width     = THIS.Width
109:         loc_oPf.PageCount = 2
110:         loc_oPf.Tabs      = .F.
111:         loc_oPf.TabStop   = .F.
112: 
113:         loc_oPg1 = loc_oPf.Page1
114:         loc_oPg1.Caption   = "Lista"
115:         loc_oPg1.BackColor = RGB(255, 255, 255)
116:         loc_oPg1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
117: 
118:         loc_oPg2 = loc_oPf.Page2
119:         loc_oPg2.Caption   = "Dados"
120:         loc_oPg2.BackColor = RGB(255, 255, 255)
121:         loc_oPg2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122: 
123:         loc_oPf.Visible = .T.
124:     ENDPROC

*-- Linhas 135 a 170:
135:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
136:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
137:         WITH loc_oCab
138:             .Top           = 31
139:             .Left          = 0
140:             .Width         = THIS.Width
141:             .Height        = 80
142:             .BackColor     = RGB(100, 100, 100)
143:             .BorderWidth   = 0
144:             .SpecialEffect = 0
145:         ENDWITH
146:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
147:         WITH loc_oCab.lbl_4c_Sombra
148:             .Caption   = THIS.Caption
149:             .Top       = 15
150:             .Left      = 10
151:             .Width     = THIS.Width - 10
152:             .Height    = 40
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.
156:             .ForeColor = RGB(0, 0, 0)
157:             .BackStyle = 0
158:             .AutoSize  = .F.
159:             .Visible   = .T.
160:         ENDWITH
161:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
162:         WITH loc_oCab.lbl_4c_Titulo
163:             .Caption   = THIS.Caption
164:             .Top       = 18
165:             .Left      = 10
166:             .Width     = THIS.Width - 10
167:             .Height    = 46
168:             .FontName  = "Tahoma"
169:             .FontSize  = 16
170:             .FontBold  = .T.

*-- Linhas 179 a 359:
179:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
180:         loc_oBtns = loc_oPg1.cnt_4c_Botoes
181:         WITH loc_oBtns
182:             .Top           = 29
183:             .Left          = 542
184:             .Width         = 375
185:             .Height        = 85
186:             .BackStyle     = 1
187:             .BackColor     = RGB(53, 53, 53)
188:             .BorderWidth   = 0
189:             .SpecialEffect = 0
190:         ENDWITH
191: 
192:         loc_oBtns.AddObject("cmd_4c_Incluir", "CommandButton")
193:         WITH loc_oBtns.cmd_4c_Incluir
194:             .Caption         = "Incluir"
195:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
196:             .PicturePosition = 13
197:             .Top             = 5
198:             .Left            = 5
199:             .Width           = 75
200:             .Height          = 75
201:             .FontName        = "Comic Sans MS"
202:             .FontSize        = 8
203:             .FontBold        = .T.
204:             .FontItalic      = .T.
205:             .ForeColor       = RGB(90, 90, 90)
206:             .BackColor       = RGB(255, 255, 255)
207:             .Themes          = .F.
208:             .SpecialEffect   = 0
209:             .MousePointer    = 15
210:             .WordWrap        = .T.
211:             .AutoSize        = .F.
212:             .Visible         = .T.
213:         ENDWITH
214:         BINDEVENT(loc_oBtns.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
215: 
216:         loc_oBtns.AddObject("cmd_4c_Visualizar", "CommandButton")
217:         WITH loc_oBtns.cmd_4c_Visualizar
218:             .Caption         = "Visualizar"
219:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
220:             .PicturePosition = 13
221:             .Top             = 5
222:             .Left            = 80
223:             .Width           = 75
224:             .Height          = 75
225:             .FontName        = "Comic Sans MS"
226:             .FontSize        = 8
227:             .FontBold        = .T.
228:             .FontItalic      = .T.
229:             .ForeColor       = RGB(90, 90, 90)
230:             .BackColor       = RGB(255, 255, 255)
231:             .Themes          = .F.
232:             .SpecialEffect   = 0
233:             .MousePointer    = 15
234:             .WordWrap        = .T.
235:             .AutoSize        = .F.
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oBtns.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
239: 
240:         loc_oBtns.AddObject("cmd_4c_Alterar", "CommandButton")
241:         WITH loc_oBtns.cmd_4c_Alterar
242:             .Caption         = "Alterar"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 155
247:             .Width           = 75
248:             .Height          = 75
249:             .FontName        = "Comic Sans MS"
250:             .FontSize        = 8
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .ForeColor       = RGB(90, 90, 90)
254:             .BackColor       = RGB(255, 255, 255)
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oBtns.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
263: 
264:         loc_oBtns.AddObject("cmd_4c_Excluir", "CommandButton")
265:         WITH loc_oBtns.cmd_4c_Excluir
266:             .Caption         = "Excluir"
267:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
268:             .PicturePosition = 13
269:             .Top             = 5
270:             .Left            = 230
271:             .Width           = 75
272:             .Height          = 75
273:             .FontName        = "Comic Sans MS"
274:             .FontSize        = 8
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .ForeColor       = RGB(90, 90, 90)
278:             .BackColor       = RGB(255, 255, 255)
279:             .Themes          = .F.
280:             .SpecialEffect   = 0
281:             .MousePointer    = 15
282:             .WordWrap        = .T.
283:             .AutoSize        = .F.
284:             .Visible         = .T.
285:         ENDWITH
286:         BINDEVENT(loc_oBtns.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
287: 
288:         loc_oBtns.AddObject("cmd_4c_Buscar", "CommandButton")
289:         WITH loc_oBtns.cmd_4c_Buscar
290:             .Caption         = "Buscar"
291:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
292:             .PicturePosition = 13
293:             .Top             = 5
294:             .Left            = 305
295:             .Width           = 75
296:             .Height          = 75
297:             .FontName        = "Comic Sans MS"
298:             .FontSize        = 8
299:             .FontBold        = .T.
300:             .FontItalic      = .T.
301:             .ForeColor       = RGB(90, 90, 90)
302:             .BackColor       = RGB(255, 255, 255)
303:             .Themes          = .F.
304:             .SpecialEffect   = 0
305:             .MousePointer    = 15
306:             .WordWrap        = .T.
307:             .AutoSize        = .F.
308:             .Visible         = .T.
309:         ENDWITH
310:         BINDEVENT(loc_oBtns.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
311:         loc_oBtns.Visible = .T.
312: 
313:         *-- Container de saida com botao Encerrar (canonico left=917)
314:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
315:         loc_oSaida = loc_oPg1.cnt_4c_Saida
316:         WITH loc_oSaida
317:             .Top           = 29
318:             .Left          = 917
319:             .Width         = 90
320:             .Height        = 85
321:             .BackStyle     = 0
322:             .BorderWidth   = 0
323:             .SpecialEffect = 0
324:         ENDWITH
325:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
326:         WITH loc_oSaida.cmd_4c_Encerrar
327:             .Caption         = "Encerrar"
328:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
329:             .PicturePosition = 13
330:             .Top             = 5
331:             .Left            = 5
332:             .Width           = 75
333:             .Height          = 75
334:             .FontName        = "Comic Sans MS"
335:             .FontSize        = 8
336:             .FontBold        = .T.
337:             .FontItalic      = .T.
338:             .ForeColor       = RGB(90, 90, 90)
339:             .BackColor       = RGB(255, 255, 255)
340:             .Themes          = .F.
341:             .SpecialEffect   = 0
342:             .MousePointer    = 15
343:             .WordWrap        = .T.
344:             .AutoSize        = .F.
345:             .Visible         = .T.
346:         ENDWITH
347:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
348:         loc_oSaida.Visible = .T.
349: 
350:         *-- Grid de lista (Codigos + Descrs)
351:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
352:         loc_oGrid = loc_oPg1.grd_4c_Lista
353:         loc_oGrid.Top             = 117
354:         loc_oGrid.Left            = 26
355:         loc_oGrid.Width           = 890
356:         loc_oGrid.Height          = 498
357:         loc_oGrid.ColumnCount     = 2
358:         WITH loc_oGrid
359:             .FontName             = "Verdana"

*-- Linhas 371 a 464:
371:             .GridLines            = 3
372:             .ReadOnly             = .T.
373:             .Column1.Width        = 120
374:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
375:             .Column2.Width        = 400
376:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
377:             .Visible              = .T.
378:         ENDWITH
379: 
380:         THIS.TornarControlesVisiveis(loc_oPg1)
381:     ENDPROC
382: 
383:     *--------------------------------------------------------------------------
384:     * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar e campos (Parte 1)
385:     *   Campos: lbl_4c_Label1 (Codigo) + txt_4c_Codigos
386:     *--------------------------------------------------------------------------
387:     PROTECTED PROCEDURE ConfigurarPaginaDados()
388:         LOCAL loc_oPg2, loc_oSalva
389: 
390:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
391: 
392:         *-- Container Confirmar/Cancelar (canonico: Top=33, Left=842, Width=160, Height=85)
393:         loc_oPg2.AddObject("cnt_4c_Salva", "Container")
394:         loc_oSalva = loc_oPg2.cnt_4c_Salva
395:         WITH loc_oSalva
396:             .Top           = 33
397:             .Left          = 842
398:             .Width         = 160
399:             .Height        = 85
400:             .BackStyle     = 0
401:             .BorderWidth   = 0
402:             .SpecialEffect = 0
403:         ENDWITH
404: 
405:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
406:         WITH loc_oSalva.cmd_4c_Confirmar
407:             .Caption         = "Confirmar"
408:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
409:             .PicturePosition = 13
410:             .Top             = 5
411:             .Left            = 5
412:             .Width           = 75
413:             .Height          = 75
414:             .FontName        = "Comic Sans MS"
415:             .FontSize        = 8
416:             .FontBold        = .T.
417:             .FontItalic      = .T.
418:             .ForeColor       = RGB(90, 90, 90)
419:             .BackColor       = RGB(255, 255, 255)
420:             .Themes          = .F.
421:             .SpecialEffect   = 0
422:             .MousePointer    = 15
423:             .WordWrap        = .T.
424:             .AutoSize        = .F.
425:             .Visible         = .T.
426:         ENDWITH
427:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
428: 
429:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")
430:         WITH loc_oSalva.cmd_4c_Cancelar
431:             .Caption         = "Encerrar"
432:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
433:             .PicturePosition = 13
434:             .Top             = 5
435:             .Left            = 80
436:             .Width           = 75
437:             .Height          = 75
438:             .FontName        = "Comic Sans MS"
439:             .FontSize        = 8
440:             .FontBold        = .T.
441:             .FontItalic      = .T.
442:             .ForeColor       = RGB(90, 90, 90)
443:             .BackColor       = RGB(255, 255, 255)
444:             .Themes          = .F.
445:             .SpecialEffect   = 0
446:             .MousePointer    = 15
447:             .WordWrap        = .T.
448:             .AutoSize        = .F.
449:             .Visible         = .T.
450:         ENDWITH
451:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
452:         loc_oSalva.Visible = .T.
453: 
454:         *-- Label "Código :" (Say1 - top=187+29=216, left=339)
455:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
456:         WITH loc_oPg2.lbl_4c_Label1
457:             .Caption   = "C" + CHR(243) + "digo :"
458:             .Top       = 216
459:             .Left      = 339
460:             .Width     = 60
461:             .Height    = 17
462:             .FontName  = "Tahoma"
463:             .FontSize  = 8
464:             .FontBold  = .F.

*-- Linhas 472 a 481:
472:         loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
473:         WITH loc_oPg2.txt_4c_Codigos
474:             .Value         = ""
475:             .Top           = 213
476:             .Left          = 383
477:             .Width         = 150
478:             .Height        = 23
479:             .MaxLength     = 20
480:             .SpecialEffect = 1
481:             .FontName      = "Tahoma"

*-- Linhas 487 a 499:
487:         ENDWITH
488: 
489:         *-- Label "Descrição :" (Say2 - top=212+29=241, left=326)
490:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
491:         WITH loc_oPg2.lbl_4c_Label2
492:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
493:             .Top       = 241
494:             .Left      = 326
495:             .Width     = 65
496:             .Height    = 17
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .FontBold  = .F.

*-- Linhas 507 a 516:
507:         loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
508:         WITH loc_oPg2.txt_4c_Descrs
509:             .Value         = ""
510:             .Top           = 238
511:             .Left          = 383
512:             .Width         = 290
513:             .Height        = 23
514:             .MaxLength     = 40
515:             .SpecialEffect = 1
516:             .FontName      = "Tahoma"

*-- Linhas 566 a 575:
566:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
567:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
568:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
569:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
570:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
571:                 THIS.FormatarGridLista(loc_oGrid)
572:                 THIS.AjustarBotoesPorModo()
573:                 loc_lResultado = .T.
574:             ENDIF
575:         CATCH TO loc_oErro

*-- Linhas 773 a 782:
773:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
774:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
775:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
776:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
777:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
778:                     THIS.FormatarGridLista(loc_oGrid)
779:                 ENDIF
780: 
781:                 loc_oBusca.Release()
782:             ENDIF

*-- Linhas 897 a 905:
897:             loc_oPg2.txt_4c_Descrs.Enabled = par_lHabilitar
898:         ENDIF
899:         IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
900:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
901:                 (par_lHabilitar AND THIS.this_cModoAtual != "VISUALIZAR")
902:         ENDIF
903:     ENDPROC
904: 
905:     *--------------------------------------------------------------------------

*-- Linhas 927 a 942:
927: 
928:         TRY
929:             loc_oBtns = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
930:             IF PEMSTATUS(loc_oBtns, "cmd_4c_Visualizar", 5)
931:                 loc_oBtns.cmd_4c_Visualizar.Enabled = loc_lTemRegistros
932:             ENDIF
933:             IF PEMSTATUS(loc_oBtns, "cmd_4c_Alterar", 5)
934:                 loc_oBtns.cmd_4c_Alterar.Enabled = loc_lTemRegistros
935:             ENDIF
936:             IF PEMSTATUS(loc_oBtns, "cmd_4c_Excluir", 5)
937:                 loc_oBtns.cmd_4c_Excluir.Enabled = loc_lTemRegistros
938:             ENDIF
939:         CATCH TO loc_oErro
940:             MsgErro("Erro em Formmpp.AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
941:         ENDTRY
942:     ENDPROC


### BO (C:\4c\projeto\app\classes\mppBO.prg):
*==============================================================================
* mppBO.prg - Business Object para Complementos de Caracteristicas
* Tabela  : SigPrCpP
* PK      : CidChaves (UUID gerado por fUniqueIds)
* nTipos  : 0=Produtos  1=Contas  2=Movimentacoes
*==============================================================================

DEFINE CLASS mppBO AS BusinessBase

    *-- Chave primaria (UUID)
    this_cCidChaves     = ""    && char(20)    CidChaves - PK gerada por fUniqueIds()

    *-- Dados cadastrais
    this_cCodigos       = ""    && char(20)    Codigos   - Codigo do complemento
    this_cDescrs        = ""    && char(40)    Descrs    - Descricao

    *-- Tipo de complemento
    this_nTipos         = 0     && numeric(1)  nTipos    - 0=Produto 1=Conta 2=Movimentacao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCpP"
        THIS.this_cCampoChave = "CidChaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Retorna lista de complementos filtrados por nTipos
    *   par_cFiltro : filtro SQL adicional (sem WHERE) ou "" para todos
    *   par_nTipos  : 0/1/2 conforme tipo; -1 = sem filtro de tipo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP"

            loc_cWhere = ""

            IF VARTYPE(par_nTipos) = "N" AND par_nTipos >= 0
                loc_cWhere = "nTipos = " + ALLTRIM(STR(par_nTipos, 1))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                IF EMPTY(loc_cWhere)
                    loc_cWhere = par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            IF !EMPTY(loc_cWhere)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega complemento pela PK (CidChaves)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP" + ;
                       " WHERE CidChaves = " + EscaparSQL(par_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigosETipo - Busca por Codigos + nTipos (chave natural)
    *   Usada para verificar duplicata antes de inserir
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigosETipo(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT CidChaves, Codigos, Descrs, nTipos FROM SigPrCpP" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.CarregarPorCodigosETipo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCodigoDuplicado - Retorna .T. se Codigos+nTipos ja existe
    *   (chamado antes do INSERT para barrar duplicatas - logica do legado)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCodigoDuplicado(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            IF USED("cursor_4c_Duplica")
                USE IN cursor_4c_Duplica
            ENDIF

            loc_cSQL = "SELECT TOP 1 CidChaves FROM SigPrCpP" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplica")
            IF loc_nResult > 0
                loc_lDuplicado = (RECCOUNT("cursor_4c_Duplica") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarCodigoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Duplica")
            USE IN cursor_4c_Duplica
        ENDIF
        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoEmCaracteristicasContas - Verifica uso em SigClCrc.Compls
    *   Legado: antes de excluir registro com nTipos=1, verificar uso
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoEmCaracteristicasContas(par_cDescrs)
        LOCAL loc_cSQL, loc_nResult, loc_lEmUso
        loc_lEmUso = .F.
        TRY
            IF USED("cursor_4c_VerUso")
                USE IN cursor_4c_VerUso
            ENDIF

            loc_cSQL = "SELECT TOP 1 Compls FROM SigClCrc" + ;
                       " WHERE Compls = " + EscaparSQL(par_cDescrs)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerUso")
            IF loc_nResult > 0
                loc_lEmUso = (RECCOUNT("cursor_4c_VerUso") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarUsoEmCaracteristicasContas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerUso")
            USE IN cursor_4c_VerUso
        ENDIF
        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarUsoEmFichasTecnicas - Verifica uso em SigCdFtc.CTits + nTipos
    *   Legado: antes de excluir, verificar se codigo e titulo de ficha tecnica
    *--------------------------------------------------------------------------
    FUNCTION VerificarUsoEmFichasTecnicas(par_cCodigos, par_nTipos)
        LOCAL loc_cSQL, loc_nResult, loc_lEmUso
        loc_lEmUso = .F.
        TRY
            IF USED("cursor_4c_VerFtc")
                USE IN cursor_4c_VerFtc
            ENDIF

            loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdFtc" + ;
                       " WHERE CTits = " + EscaparSQL(par_cCodigos) + ;
                       " AND nTipos = " + ALLTRIM(STR(par_nTipos, 1))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerFtc")
            IF loc_nResult > 0
                loc_lEmUso = (RECCOUNT("cursor_4c_VerFtc") > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.VerificarUsoEmFichasTecnicas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerFtc")
            USE IN cursor_4c_VerFtc
        ENDIF
        RETURN loc_lEmUso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cDescrs    = TratarNulo(Descrs,    "C")
            THIS.this_nTipos     = TratarNulo(nTipos,    "N")
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cChave
        loc_lSucesso = .F.
        TRY
            loc_cChave           = fUniqueIds()
            THIS.this_cCidChaves = loc_cChave

            loc_cSQL = "INSERT INTO SigPrCpP (CidChaves, Codigos, Descrs, nTipos) VALUES (" + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ", " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ", " + ;
                       ALLTRIM(STR(THIS.this_nTipos, 1)) + ")"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Ins")
                TABLEREVERT(.T., "cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Legado so permite alterar Descrs (Codigos e readonly em modo ALTERAR)
            loc_cSQL = "UPDATE SigPrCpP SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Upd")
            USE IN cursor_4c_Upd
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "DELETE FROM SigPrCpP WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir complemento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em mppBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Del")
            USE IN cursor_4c_Del
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

