# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 217: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 267: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 329: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 432: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 457: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormEvt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (925 linhas total):

*-- Linhas 60 a 69:
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

*-- Linhas 89 a 162:
89: 
90:         WITH loc_oPgf
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()
107:         THIS.ConfigurarPaginaDados()
108:     ENDPROC
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarPaginaLista - Configura Page1 completa: cabecalho, botoes, grid
112:     *
113:     * Coordenadas originais (SCX) + compensacao PageFrame.Top=-29:
114:     *   cntSombra.Top=1   -> Top=30  (1+29)
115:     *   Grupo_op.Top=-1   -> Top=28  (-1+29)
116:     *   Grade.Top=121     -> Top=150 (121+29)
117:     *   Grade.Left=12, Width=940 (sem compensacao horizontal)
118:     *--------------------------------------------------------------------------
119:     PROTECTED PROCEDURE ConfigurarPaginaLista()
120:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
121:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
122: 
123:         *-- Container cabecalho cinza
124:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
125:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
126:         WITH loc_oCab
127:             .Top         = 30
128:             .Left        = 0
129:             .Width       = THIS.Width
130:             .Height      = 80
131:             .BackColor   = RGB(100, 100, 100)
132:             .BorderWidth = 0
133:             .Visible     = .T.
134:         ENDWITH
135: 
136:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
137:         WITH loc_oCab.lbl_4c_Sombra
138:             .AutoSize  = .F.
139:             .Caption   = THIS.Caption
140:             .Top       = 15
141:             .Left      = 10
142:             .Width     = THIS.Width
143:             .Height    = 40
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.
147:             .ForeColor = RGB(0, 0, 0)
148:             .BackStyle = 0
149:             .Visible   = .T.
150:         ENDWITH
151: 
152:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
153:         WITH loc_oCab.lbl_4c_Titulo
154:             .AutoSize  = .F.
155:             .Caption   = THIS.Caption
156:             .Top       = 18
157:             .Left      = 10
158:             .Width     = THIS.Width
159:             .Height    = 46
160:             .FontName  = "Tahoma"
161:             .FontSize  = 16
162:             .FontBold  = .T.

*-- Linhas 169 a 361:
169:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
170:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
171:         WITH loc_oBotoes
172:             .Top         = 28
173:             .Left        =  542
174:             .Width       = 385
175:             .Height      = 85
176:             .BackColor   = RGB(100, 100, 100)
177:             .BackStyle   = 1
178:             .BorderWidth = 0
179:             .Visible     = .T.
180:         ENDWITH
181: 
182:         *-- Botao Incluir
183:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
184:         WITH loc_oBotoes.cmd_4c_Incluir
185:             .Caption         = "Incluir"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 5
190:             .Width           = 75
191:             .Height          = 75
192:             .FontName        = "Comic Sans MS"
193:             .FontBold        = .T.
194:             .FontItalic      = .T.
195:             .FontSize        = 8
196:             .ForeColor       = RGB(90, 90, 90)
197:             .BackColor       = RGB(255, 255, 255)
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:             .Visible         = .T.
204:         ENDWITH
205:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
206: 
207:         *-- Botao Visualizar
208:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
209:         WITH loc_oBotoes.cmd_4c_Visualizar
210:             .Caption         = "Visualizar"
211:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
212:             .PicturePosition = 13
213:             .Top             = 5
214:             .Left            = 80
215:             .Width           = 75
216:             .Height          = 75
217:             .FontName        = "Comic Sans MS"
218:             .FontBold        = .T.
219:             .FontItalic      = .T.
220:             .FontSize        = 8
221:             .ForeColor       = RGB(90, 90, 90)
222:             .BackColor       = RGB(255, 255, 255)
223:             .Themes          = .F.
224:             .SpecialEffect   = 0
225:             .MousePointer    = 15
226:             .WordWrap        = .T.
227:             .AutoSize        = .F.
228:             .Visible         = .T.
229:         ENDWITH
230:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
231: 
232:         *-- Botao Alterar
233:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
234:         WITH loc_oBotoes.cmd_4c_Alterar
235:             .Caption         = "Alterar"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
237:             .PicturePosition = 13
238:             .Top             = 5
239:             .Left            = 155
240:             .Width           = 75
241:             .Height          = 75
242:             .FontName        = "Comic Sans MS"
243:             .FontBold        = .T.
244:             .FontItalic      = .T.
245:             .FontSize        = 8
246:             .ForeColor       = RGB(90, 90, 90)
247:             .BackColor       = RGB(255, 255, 255)
248:             .Themes          = .F.
249:             .SpecialEffect   = 0
250:             .MousePointer    = 15
251:             .WordWrap        = .T.
252:             .AutoSize        = .F.
253:             .Visible         = .T.
254:         ENDWITH
255:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
256: 
257:         *-- Botao Excluir
258:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
259:         WITH loc_oBotoes.cmd_4c_Excluir
260:             .Caption         = "Excluir"
261:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
262:             .PicturePosition = 13
263:             .Top             = 5
264:             .Left            = 230
265:             .Width           = 75
266:             .Height          = 75
267:             .FontName        = "Comic Sans MS"
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontSize        = 8
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .MousePointer    = 15
276:             .WordWrap        = .T.
277:             .AutoSize        = .F.
278:             .Visible         = .T.
279:         ENDWITH
280:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
281: 
282:         *-- Botao Buscar
283:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
284:         WITH loc_oBotoes.cmd_4c_Buscar
285:             .Caption         = "Buscar"
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
287:             .PicturePosition = 13
288:             .Top             = 5
289:             .Left            = 305
290:             .Width           = 75
291:             .Height          = 75
292:             .FontName        = "Comic Sans MS"
293:             .FontBold        = .T.
294:             .FontItalic      = .T.
295:             .FontSize        = 8
296:             .ForeColor       = RGB(90, 90, 90)
297:             .BackColor       = RGB(255, 255, 255)
298:             .Themes          = .F.
299:             .SpecialEffect   = 0
300:             .MousePointer    = 15
301:             .WordWrap        = .T.
302:             .AutoSize        = .F.
303:             .Visible         = .T.
304:         ENDWITH
305:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
306: 
307:         *-- Container saida/encerrar (canonico: Left=917, Width=90)
308:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
309:         loc_oSaida = loc_oPg1.cnt_4c_Saida
310:         WITH loc_oSaida
311:             .Top         = 28
312:             .Left        = 917
313:             .Width       = 90
314:             .Height      = 85
315:             .BackStyle   = 0
316:             .BorderWidth = 0
317:             .Visible     = .T.
318:         ENDWITH
319: 
320:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
321:         WITH loc_oSaida.cmd_4c_Encerrar
322:             .Caption         = "Encerrar"
323:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
324:             .PicturePosition = 13
325:             .Top             = 5
326:             .Left            = 5
327:             .Width           = 75
328:             .Height          = 75
329:             .FontName        = "Comic Sans MS"
330:             .FontBold        = .T.
331:             .FontItalic      = .T.
332:             .FontSize        = 8
333:             .ForeColor       = RGB(90, 90, 90)
334:             .BackColor       = RGB(255, 255, 255)
335:             .Themes          = .F.
336:             .SpecialEffect   = 0
337:             .MousePointer    = 15
338:             .WordWrap        = .T.
339:             .AutoSize        = .F.
340:             .Visible         = .T.
341:         ENDWITH
342:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
343: 
344:         *-- Pre-criar cursor placeholder para grid (evita erro em RecordSource)
345:         IF !USED("cursor_4c_Dados")
346:             SET NULL ON
347:             CREATE CURSOR cursor_4c_Dados (Cods C(3), Descs C(30))
348:             SET NULL OFF
349:         ENDIF
350: 
351:         *-- Grid de listagem (Grade.Top=121+29=150, Left=12, Width=940)
352:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
353:         loc_oGrid = loc_oPg1.grd_4c_Lista
354:         WITH loc_oGrid
355:             .Top                = 150
356:             .Left               = 12
357:             .Width              = 940
358:             .Height             = 440
359:             .FontName           = "Verdana"
360:             .FontSize           = 8
361:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 380 a 482:
380:         WITH loc_oGrid
381:             .Column1.ControlSource   = "cursor_4c_Dados.Cods"
382:             .Column1.Width           = 80
383:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
384:             .Column2.ControlSource   = "cursor_4c_Dados.Descs"
385:             .Column2.Width           = 856
386:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
387:         ENDWITH
388: 
389:         BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
390: 
391:         THIS.TornarControlesVisiveis(loc_oPg1)
392:     ENDPROC
393: 
394:     *--------------------------------------------------------------------------
395:     * ConfigurarPaginaDados - Configura Page2: botoes Confirmar/Cancelar e
396:     * primeira metade dos campos: lbl_4c_Codigo + txt_4c_Codigo
397:     *
398:     * Coordenadas originais (SCX) + compensacao PageFrame.Top=-29:
399:     *   Grupo_Salva.Top=11   -> Top=40  (11+29)
400:     *   Grupo_Salva.Left=817
401:     *   Say1.Top=141  -> Top=170  (141+29), Left=397, ForeColor=90,90,90
402:     *   getCods.Top=137 -> Top=166 (137+29), Left=443, Width=96, Height=24
403:     *--------------------------------------------------------------------------
404:     PROTECTED PROCEDURE ConfigurarPaginaDados()
405:         LOCAL loc_oPg2, loc_oBotoesAcao
406:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
407: 
408:         *-- Container botoes acao: Confirmar/Cancelar
409:         *-- Grupo_Salva: Left=817, Top=11+29=40, Width=160, Height=85
410:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
411:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
412:         WITH loc_oBotoesAcao
413:             .Top         = 40
414:             .Left        = 817
415:             .Width       = 160
416:             .Height      = 85
417:             .BackStyle   = 0
418:             .BorderWidth = 0
419:             .Visible     = .T.
420:         ENDWITH
421: 
422:         *-- Botao Confirmar (Salva.Left=5, Salva.Top=5)
423:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
424:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
425:             .Caption         = "Confirmar"
426:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
427:             .PicturePosition = 13
428:             .Top             = 5
429:             .Left            = 5
430:             .Width           = 75
431:             .Height          = 75
432:             .FontName        = "Comic Sans MS"
433:             .FontBold        = .T.
434:             .FontItalic      = .T.
435:             .FontSize        = 8
436:             .ForeColor       = RGB(90, 90, 90)
437:             .BackColor       = RGB(255, 255, 255)
438:             .Themes          = .F.
439:             .SpecialEffect   = 0
440:             .MousePointer    = 15
441:             .WordWrap        = .T.
442:             .AutoSize        = .F.
443:             .Visible         = .T.
444:         ENDWITH
445:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
446: 
447:         *-- Botao Cancelar (Cancelar.Left=80, Cancelar.Top=5)
448:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
449:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
450:             .Caption         = "Encerrar"
451:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
452:             .PicturePosition = 13
453:             .Top             = 5
454:             .Left            = 80
455:             .Width           = 75
456:             .Height          = 75
457:             .FontName        = "Comic Sans MS"
458:             .FontBold        = .T.
459:             .FontItalic      = .T.
460:             .FontSize        = 8
461:             .ForeColor       = RGB(90, 90, 90)
462:             .BackColor       = RGB(255, 255, 255)
463:             .Themes          = .F.
464:             .SpecialEffect   = 0
465:             .MousePointer    = 15
466:             .WordWrap        = .T.
467:             .AutoSize        = .F.
468:             .Visible         = .T.
469:         ENDWITH
470:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
471: 
472:         *-- Label Codigo (Say1: Top=141+29=170, Left=397, ForeColor=90,90,90)
473:         loc_oPg2.AddObject("lbl_4c_Codigo", "Label")
474:         WITH loc_oPg2.lbl_4c_Codigo
475:             .Caption   = "C" + CHR(243) + "digo :"
476:             .Top       = 170
477:             .Left      = 397
478:             .Width     = 45
479:             .Height    = 17
480:             .FontName  = "Tahoma"
481:             .FontSize  = 8
482:             .FontBold  = .F.

*-- Linhas 493 a 502:
493:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
494:         WITH loc_oPg2.txt_4c_Codigo
495:             .Value         = ""
496:             .Top           = 166
497:             .Left          = 443
498:             .Width         = 96
499:             .Height        = 24
500:             .FontName      = "Tahoma"
501:             .FontSize      = 8
502:             .MaxLength     = 3

*-- Linhas 509 a 521:
509:         ENDWITH
510: 
511:         *-- Label Descricao (Say2: Top=167+29=196, Left=384, ForeColor=90,90,90)
512:         loc_oPg2.AddObject("lbl_4c_Descricao", "Label")
513:         WITH loc_oPg2.lbl_4c_Descricao
514:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
515:             .Top       = 196
516:             .Left      = 384
517:             .Width     = 55
518:             .Height    = 17
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .FontBold  = .F.

*-- Linhas 531 a 540:
531:         loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
532:         WITH loc_oPg2.txt_4c_Descricao
533:             .Value         = ""
534:             .Top           = 192
535:             .Left          = 443
536:             .Width         = 179
537:             .Height        = 24
538:             .FontName      = "Tahoma"
539:             .FontSize      = 8
540:             .MaxLength     = 30

*-- Linhas 592 a 601:
592:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
593: 
594:                 IF VARTYPE(loc_oGrid) = "O"
595:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
596:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
597:                     THIS.FormatarGridLista(loc_oGrid)
598:                     loc_oGrid.Refresh()
599:                 ENDIF
600: 
601:                 loc_lResultado = .T.

*-- Linhas 896 a 905:
896:         loc_lEditando   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
897: 
898:         TRY
899:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
900:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
901:         CATCH TO loc_oErro
902:             MsgErro(loc_oErro.Message, "FormEvt.AjustarBotoesPorModo")
903:         ENDTRY
904:     ENDPROC
905: 


### BO (C:\4c\projeto\app\classes\EvtBO.prg):
*==============================================================================
* EvtBO.prg - Business Object para Cadastro de Eventos
* Tabela: SigCdEvt
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS EvtBO AS BusinessBase

    *-- Propriedades da entidade (SigCdEvt)
    this_cCodigo    = ""   && Cods      char(3)  - codigo do evento (chave usuario)
    this_cDescricao = ""   && Descs     char(30) - descricao do evento
    this_cIdChaves  = ""   && cIdChaves char(20) - chave tecnica interna (PK tabela)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdEvt"
            THIS.this_cCampoChave = "cIdChaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "EvtBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cIdChaves  = TratarNulo(cIdChaves, "C")
                THIS.this_cCodigo    = TratarNulo(Cods,      "C")
                THIS.this_cDescricao = TratarNulo(Descs,     "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "EvtBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Reproduz validacoes do legado: codigo vazio, duplicado, descricao vazia
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se Cods ja existe no banco
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdEvt" + ;
                " WHERE Cods = " + EscaparSQL(PADR(par_cCodigo, 3))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkEvt")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkEvt")
                SELECT cursor_4c_ChkEvt
                loc_lExiste = (cursor_4c_ChkEvt.qtd > 0)
                USE IN cursor_4c_ChkEvt
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "EvtBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdEvt
    * Gera cIdChaves via SYS(2015) (equivalente ao fUniqueIds do legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cIdChaves
        loc_lSucesso  = .F.
        loc_cIdChaves = LEFT(SYS(2015) + SYS(2015), 20)

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdEvt (cIdChaves, Cods, Descs)
                VALUES (
                    <<EscaparSQL(loc_cIdChaves)>>,
                    <<EscaparSQL(PADR(THIS.this_cCodigo, 3))>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.this_cIdChaves = loc_cIdChaves
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "EvtBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdEvt
    * Cods nao e alterado (chave usuario imutavel apos criacao)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdEvt
                SET Descs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE Cods = <<EscaparSQL(PADR(THIS.this_cCodigo, 3))>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "EvtBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdEvt
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdEvt WHERE Cods = " + ;
                EscaparSQL(PADR(THIS.this_cCodigo, 3))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "EvtBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com Cods e Descs (colunas exibidas no grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Cods C(3), Descs C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Cods, Descs FROM SigCdEvt"

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
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar eventos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "EvtBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo do evento (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cIdChaves, Cods, Descs FROM SigCdEvt" + ;
                " WHERE Cods = " + EscaparSQL(PADR(par_cCodigo, 3))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Evento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar evento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "EvtBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

