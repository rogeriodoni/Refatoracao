# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 170: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 195: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 220: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 245: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 306: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 382: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 407: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formgem.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (865 linhas total):

*-- Linhas 77 a 86:
77:         THIS.pgf_4c_Paginas.PageCount = 2
78: 
79:         WITH THIS.pgf_4c_Paginas
80:             .Top     = -29
81:             .Left    = 0
82:             .Width   = THIS.Width
83:             .Height  = THIS.Height + 29
84:             .Tabs    = .F.
85:             .Visible = .T.
86:             .Page1.BackColor = RGB(100, 100, 100)

*-- Linhas 103 a 328:
103:         *-- Container cabecalho (cntSombra do legado: Top=2+29=31)
104:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH loc_oPagina.cnt_4c_Cabecalho
106:             .Top         = 31
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113:         ENDWITH
114: 
115:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
116:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
117:             .Top       = 15
118:             .Left      = 10
119:             .Width     = THIS.Width - 20
120:             .Height    = 40
121:             .Caption   = THIS.Caption
122:             .FontName  = "Tahoma"
123:             .FontSize  = 16
124:             .FontBold  = .T.
125:             .ForeColor = RGB(0, 0, 0)
126:             .BackStyle = 0
127:             .AutoSize  = .F.
128:             .Visible   = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
133:             .Top       = 18
134:             .Left      = 10
135:             .Width     = THIS.Width - 20
136:             .Height    = 46
137:             .Caption   = THIS.Caption
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(255, 255, 255)
142:             .BackStyle = 0
143:             .AutoSize  = .F.
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         *-- Container de botoes CRUD (Grupo_op: Left=544, Top=-1+29=28, Width=385, Height=85)
148:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
149:         WITH loc_oPagina.cnt_4c_Botoes
150:             .Top         = 28
151:             .Left        =  542
152:             .Width       = 385
153:             .Height      = 85
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         *-- Botao Incluir (Inserir.Left=5, Top=5)
159:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
160:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
161:             .Caption         = "Incluir"
162:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
163:             .PicturePosition = 13
164:             .Top             = 5
165:             .Left            = 5
166:             .Width           = 75
167:             .Height          = 75
168:             .BackColor       = RGB(255, 255, 255)
169:             .ForeColor       = RGB(90, 90, 90)
170:             .FontName        = "Comic Sans MS"
171:             .FontSize        = 8
172:             .FontBold        = .T.
173:             .FontItalic      = .T.
174:             .Themes          = .F.
175:             .SpecialEffect   = 0
176:             .MousePointer    = 15
177:             .WordWrap        = .T.
178:             .AutoSize        = .F.
179:             .Visible         = .T.
180:         ENDWITH
181:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
182: 
183:         *-- Botao Visualizar (Consultar.Left=80, Top=5)
184:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
185:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
186:             .Caption         = "Visualizar"
187:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
188:             .PicturePosition = 13
189:             .Top             = 5
190:             .Left            = 80
191:             .Width           = 75
192:             .Height          = 75
193:             .BackColor       = RGB(255, 255, 255)
194:             .ForeColor       = RGB(90, 90, 90)
195:             .FontName        = "Comic Sans MS"
196:             .FontSize        = 8
197:             .FontBold        = .T.
198:             .FontItalic      = .T.
199:             .Themes          = .F.
200:             .SpecialEffect   = 0
201:             .MousePointer    = 15
202:             .WordWrap        = .T.
203:             .AutoSize        = .F.
204:             .Visible         = .T.
205:         ENDWITH
206:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
207: 
208:         *-- Botao Alterar (Alterar.Left=155, Top=5)
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
211:             .Caption         = "Alterar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
213:             .PicturePosition = 13
214:             .Top             = 5
215:             .Left            = 155
216:             .Width           = 75
217:             .Height          = 75
218:             .BackColor       = RGB(255, 255, 255)
219:             .ForeColor       = RGB(90, 90, 90)
220:             .FontName        = "Comic Sans MS"
221:             .FontSize        = 8
222:             .FontBold        = .T.
223:             .FontItalic      = .T.
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .MousePointer    = 15
227:             .WordWrap        = .T.
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
232: 
233:         *-- Botao Excluir (Excluir.Left=230, Top=5)
234:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
235:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
236:             .Caption         = "Excluir"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 230
241:             .Width           = 75
242:             .Height          = 75
243:             .BackColor       = RGB(255, 255, 255)
244:             .ForeColor       = RGB(90, 90, 90)
245:             .FontName        = "Comic Sans MS"
246:             .FontSize        = 8
247:             .FontBold        = .T.
248:             .FontItalic      = .T.
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
257: 
258:         *-- Botao Buscar (Procurar.Left=305, Top=5)
259:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
260:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
261:             .Caption         = "Buscar"
262:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
263:             .PicturePosition = 13
264:             .Top             = 5
265:             .Left            = 305
266:             .Width           = 75
267:             .Height          = 75
268:             .BackColor       = RGB(255, 255, 255)
269:             .ForeColor       = RGB(90, 90, 90)
270:             .FontName        = "Comic Sans MS"
271:             .FontSize        = 8
272:             .FontBold        = .T.
273:             .FontItalic      = .T.
274:             .Themes          = .F.
275:             .SpecialEffect   = 0
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:             .Visible         = .T.
280:         ENDWITH
281:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
282: 
283:         *-- Container de saida - padrao canonico (Left=917, Top=-1+29=28)
284:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
285:         WITH loc_oPagina.cnt_4c_Saida
286:             .Top         = 28
287:             .Left        = 917
288:             .Width       = 90
289:             .Height      = 85
290:             .BackStyle   = 0
291:             .BorderWidth = 0
292:             .Visible     = .T.
293:         ENDWITH
294: 
295:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
296:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
297:             .Caption         = "Encerrar"
298:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
299:             .PicturePosition = 13
300:             .Top             = 5
301:             .Left            = 5
302:             .Width           = 75
303:             .Height          = 75
304:             .BackColor       = RGB(255, 255, 255)
305:             .ForeColor       = RGB(90, 90, 90)
306:             .FontName        = "Comic Sans MS"
307:             .FontSize        = 8
308:             .FontBold        = .T.
309:             .FontItalic      = .T.
310:             .Themes          = .F.
311:             .SpecialEffect   = 0
312:             .MousePointer    = 15
313:             .WordWrap        = .T.
314:             .AutoSize        = .F.
315:             .Visible         = .T.
316:         ENDWITH
317:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
318: 
319:         *-- Grid (Grade: Top=97+29=126, Left=30, Width=938, Height=488)
320:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
321:         loc_oGrid = loc_oPagina.grd_4c_Lista
322:         loc_oGrid.Top         = 126
323:         loc_oGrid.Left        = 30
324:         loc_oGrid.Width       = 938
325:         loc_oGrid.Height      = 488
326:         loc_oGrid.ColumnCount = 2
327:         WITH loc_oGrid
328:             .FontName           = "Verdana"

*-- Linhas 358 a 430:
358:         *-- Container de botoes de acao (Grupo_Salva: Left=841, Top=-3+29=26, Width=165)
359:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
360:         WITH loc_oPagina.cnt_4c_BotoesAcao
361:             .Top         = 26
362:             .Left        = 841
363:             .Width       = 165
364:             .Height      = 85
365:             .BackStyle   = 0
366:             .BorderWidth = 0
367:             .Visible     = .T.
368:         ENDWITH
369: 
370:         *-- Botao Confirmar/Salvar (Salva: Left=5, Top=5)
371:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
372:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
373:             .Caption         = "Confirmar"
374:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
375:             .PicturePosition = 13
376:             .Top             = 5
377:             .Left            = 5
378:             .Width           = 75
379:             .Height          = 75
380:             .BackColor       = RGB(255, 255, 255)
381:             .ForeColor       = RGB(90, 90, 90)
382:             .FontName        = "Comic Sans MS"
383:             .FontSize        = 8
384:             .FontBold        = .T.
385:             .FontItalic      = .T.
386:             .Themes          = .F.
387:             .SpecialEffect   = 0
388:             .MousePointer    = 15
389:             .WordWrap        = .T.
390:             .AutoSize        = .F.
391:             .Visible         = .T.
392:         ENDWITH
393:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
394: 
395:         *-- Botao Cancelar (Cancelar: Left=80, Top=5)
396:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
397:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
398:             .Caption         = "Encerrar"
399:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
400:             .PicturePosition = 13
401:             .Top             = 5
402:             .Left            = 80
403:             .Width           = 75
404:             .Height          = 75
405:             .BackColor       = RGB(255, 255, 255)
406:             .ForeColor       = RGB(90, 90, 90)
407:             .FontName        = "Comic Sans MS"
408:             .FontSize        = 8
409:             .FontBold        = .T.
410:             .FontItalic      = .T.
411:             .Themes          = .F.
412:             .SpecialEffect   = 0
413:             .MousePointer    = 15
414:             .WordWrap        = .T.
415:             .AutoSize        = .F.
416:             .Visible         = .T.
417:         ENDWITH
418:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
419: 
420:         *-- Label Grupo (Say1: Top=176+29=205, Left=430)
421:         loc_oPagina.AddObject("lbl_4c_Grupo", "Label")
422:         WITH loc_oPagina.lbl_4c_Grupo
423:             .Caption   = "Grupo :"
424:             .Top       = 205
425:             .Left      = 430
426:             .Height    = 17
427:             .AutoSize  = .F.
428:             .FontName  = "Tahoma"
429:             .FontSize  = 8
430:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 436 a 445:
436:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
437:         WITH loc_oPagina.txt_4c_Grupo
438:             .Value         = ""
439:             .Top           = 202
440:             .Left          = 470
441:             .Width         = 115
442:             .Height        = 20
443:             .InputMask     = "!!!!!!!!!!!!!!!"
444:             .MaxLength     = 15
445:             .SpecialEffect = 1

*-- Linhas 452 a 464:
452:         ENDWITH
453: 
454:         *-- Label Classificacao (Say2: Top=203+29=232, Left=398)
455:         loc_oPagina.AddObject("lbl_4c_Class", "Label")
456:         WITH loc_oPagina.lbl_4c_Class
457:             .Caption   = "Classifica" + CHR(231) + CHR(227) + "o :"
458:             .Top       = 232
459:             .Left      = 398
460:             .Height    = 17
461:             .AutoSize  = .F.
462:             .FontName  = "Tahoma"
463:             .FontSize  = 8
464:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 470 a 479:
470:         loc_oPagina.AddObject("txt_4c_Class", "TextBox")
471:         WITH loc_oPagina.txt_4c_Class
472:             .Value         = ""
473:             .Top           = 228
474:             .Left          = 470
475:             .Width         = 115
476:             .Height        = 20
477:             .InputMask     = "!!!!!!!!!!!!!!!"
478:             .MaxLength     = 15
479:             .SpecialEffect = 1

*-- Linhas 486 a 498:
486:         ENDWITH
487: 
488:         *-- Label Tipo (Say3: Top=229+29=258, Left=439, Height=15)
489:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
490:         WITH loc_oPagina.lbl_4c_Tipo
491:             .Caption   = "Tipo :"
492:             .Top       = 258
493:             .Left      = 439
494:             .Height    = 15
495:             .AutoSize  = .F.
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 505 a 537:
505:         loc_oPagina.AddObject("opt_4c_Tipo", "OptionGroup")
506:         WITH loc_oPagina.opt_4c_Tipo
507:             .ButtonCount = 2
508:             .Top         = 254
509:             .Left        = 464
510:             .Width       = 136
511:             .Height      = 25
512:             .BackStyle   = 0
513:             .BorderStyle = 0
514:             .Value       = 1
515:             .Visible     = .T.
516:         ENDWITH
517:         WITH loc_oPagina.opt_4c_Tipo.Buttons(1)
518:             .Caption   = "Industrial"
519:             .BackStyle = 0
520:             .Left      = 5
521:             .Top       = 5
522:             .AutoSize  = .T.
523:             .FontName  = "Tahoma"
524:             .FontSize  = 8
525:             .ForeColor = RGB(90, 90, 90)
526:             .Themes    = .F.
527:         ENDWITH
528:         WITH loc_oPagina.opt_4c_Tipo.Buttons(2)
529:             .Caption   = "Diversos"
530:             .BackStyle = 0
531:             .Left      = 85
532:             .Top       = 5
533:             .AutoSize  = .T.
534:             .FontName  = "Tahoma"
535:             .FontSize  = 8
536:             .ForeColor = RGB(90, 90, 90)
537:             .Themes    = .F.

*-- Linhas 559 a 568:
559:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.class"
560:                 loc_oGrid.Column1.Width         = 115
561:                 loc_oGrid.Column2.Width         = 115
562:                 loc_oGrid.Column1.Header1.Caption = "Grupo"
563:                 loc_oGrid.Column2.Header1.Caption = "Classifica" + CHR(231) + CHR(227) + "o"
564:                 THIS.FormatarGridLista(loc_oGrid)
565:                 loc_lResultado = .T.
566:                 ENDIF
567:             ENDIF
568:         CATCH TO loc_oErro

*-- Linhas 625 a 633:
625:             THIS.HabilitarCampos(.F.)
626:             THIS.AjustarBotoesPorModo()
627:             THIS.AlternarPagina(2)
628:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
629:         ENDIF
630:     ENDPROC
631: 
632:     *==========================================================================
633:     * BtnAlterarClick - Inicia alteracao do registro selecionado

*-- Linhas 849 a 857:
849:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
850:         loc_lPermiteSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
851: 
852:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lPermiteSalvar
853:     ENDPROC
854: 
855:     *==========================================================================
856:     * Destroy - Libera recursos
857:     *==========================================================================


### BO (C:\4c\projeto\app\classes\gemBO.prg):
*==============================================================================
* gemBO.prg - Business Object para Grupo Empresarial (SigCdGre)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS gemBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos da tabela SigCdGre
    *--------------------------------------------------------------------------
    this_cCidChaves = ""   && cidchaves C(20) - PK gerada
    this_cClass     = ""   && class     C(15) - Classificacao
    this_cGruClass  = ""   && gruclass  C(30) - grupo+class concatenado
    this_cGrupo     = ""   && grupo     C(15) - Grupo
    this_nTipos     = 1    && tipos     N(1,0) - 1=Industrial, 2=Diversos

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdGre"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupo, class, gruclass, tipos" + ;
                       " FROM SigCdGre"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY grupo, class"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar dados: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo gruclass (grupo+class)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupo, class, gruclass, tipos" + ;
                       " FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cGrupo     = TratarNulo(grupo,     "C")
            THIS.this_cClass     = TratarNulo(class,     "C")
            THIS.this_cGruClass  = TratarNulo(gruclass,  "C")
            THIS.this_nTipos     = TratarNulo(tipos,     "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna cidchaves para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicata - Verifica se grupo+class ja existe (usar antes de INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicata()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicata, loc_cGruClass
        loc_lDuplicata = .F.

        TRY
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdGre" + ;
                       " WHERE gruclass = " + EscaparSQL(loc_cGruClass)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_DupCheck") > 0
                SELECT cursor_4c_DupCheck
                loc_lDuplicata = (qtd > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar duplicata: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_DupCheck")
            USE IN cursor_4c_DupCheck
        ENDIF

        RETURN loc_lDuplicata
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdGre (PROTECTED)
    * Logica original: gera cidchaves via fUniqueIds(), seta gruclass=grupo+class
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cGruClass
        loc_lSucesso = .F.

        TRY
            *-- Gerar ID unico para cidchaves (equivalente ao fUniqueIds() do legado)
            THIS.this_cCidChaves = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)

            *-- gruclass = grupo+class concatenado (indice da tabela)
            loc_cGruClass = ALLTRIM(THIS.this_cGrupo) + ALLTRIM(THIS.this_cClass)
            THIS.this_cGruClass = loc_cGruClass

            loc_cSQL = "INSERT INTO SigCdGre (cidchaves, grupo, class, gruclass, tipos)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cGrupo) + ", " + ;
                       EscaparSQL(THIS.this_cClass) + ", " + ;
                       EscaparSQL(loc_cGruClass) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTipos) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdGre (PROTECTED)
    * Nota: grupo e class nao sao editaveis no ALTERAR (apenas tipos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdGre SET" + ;
                       " tipos = " + FormatarNumeroSQL(THIS.this_nTipos) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigCdGre (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdGre" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

