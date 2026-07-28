# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 230: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 312: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 390: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 413: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBCC.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (858 linhas total):

*-- Linhas 59 a 68:
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
66:                     THIS.CarregarLista()
67:                 ENDIF
68: 

*-- Linhas 88 a 105:
88: 
89:         WITH loc_oPgf
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97:             .Page1.Caption   = "Lista"
98:             .Page1.BackColor = RGB(100, 100, 100)
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.Caption   = "Dados"
101:             .Page2.BackColor = RGB(100, 100, 100)
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()

*-- Linhas 113 a 155:
113:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
114:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Container cabecalho cinza (Top=31 = 2+29 compensacao PageFrame.Top=-29)
117:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
118:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
119:         WITH loc_oCab
120:             .Top         = 31
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
130:         WITH loc_oCab.lbl_4c_Sombra
131:             .AutoSize  = .F.
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oCab.lbl_4c_Titulo
147:             .AutoSize  = .F.
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 162 a 335:
162:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
163:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
164:         WITH loc_oBotoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackColor   = RGB(53, 53, 53)
170:             .BackStyle   = 1
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oBotoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .FontName        = "Comic Sans MS"
185:             .FontSize        = 8
186:             .FontBold        = .T.
187:             .FontItalic      = .T.
188:             .ForeColor       = RGB(90, 90, 90)
189:             .BackColor       = RGB(255, 255, 255)
190:             .Themes          = .F.
191:             .SpecialEffect   = 0
192:             .WordWrap        = .T.
193:             .MousePointer    = 15
194:             .Visible         = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oBotoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .FontName        = "Comic Sans MS"
208:             .FontSize        = 8
209:             .FontBold        = .T.
210:             .FontItalic      = .T.
211:             .ForeColor       = RGB(90, 90, 90)
212:             .BackColor       = RGB(255, 255, 255)
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .WordWrap        = .T.
216:             .MousePointer    = 15
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oBotoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .FontName        = "Comic Sans MS"
231:             .FontSize        = 8
232:             .FontBold        = .T.
233:             .FontItalic      = .T.
234:             .ForeColor       = RGB(90, 90, 90)
235:             .BackColor       = RGB(255, 255, 255)
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .WordWrap        = .T.
239:             .MousePointer    = 15
240:             .Visible         = .T.
241:         ENDWITH
242:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
243: 
244:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oBotoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .FontName        = "Comic Sans MS"
254:             .FontSize        = 8
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .WordWrap        = .T.
262:             .MousePointer    = 15
263:             .Visible         = .T.
264:         ENDWITH
265:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
266: 
267:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
268:         WITH loc_oBotoes.cmd_4c_Buscar
269:             .Caption         = "Buscar"
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
271:             .PicturePosition = 13
272:             .Top             = 5
273:             .Left            = 305
274:             .Width           = 75
275:             .Height          = 75
276:             .FontName        = "Comic Sans MS"
277:             .FontSize        = 8
278:             .FontBold        = .T.
279:             .FontItalic      = .T.
280:             .ForeColor       = RGB(90, 90, 90)
281:             .BackColor       = RGB(255, 255, 255)
282:             .Themes          = .F.
283:             .SpecialEffect   = 0
284:             .WordWrap        = .T.
285:             .MousePointer    = 15
286:             .Visible         = .T.
287:         ENDWITH
288:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
289: 
290:         *-- Container Encerrar (canonico: Left=917, Width=90)
291:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
292:         loc_oSaida = loc_oPg1.cnt_4c_Saida
293:         WITH loc_oSaida
294:             .Top         = 29
295:             .Left        = 917
296:             .Width       = 90
297:             .Height      = 85
298:             .BackStyle   = 0
299:             .BorderWidth = 0
300:             .Visible     = .T.
301:         ENDWITH
302: 
303:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
304:         WITH loc_oSaida.cmd_4c_Encerrar
305:             .Caption         = "Encerrar"
306:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:             .PicturePosition = 13
308:             .Top             = 5
309:             .Left            = 5
310:             .Width           = 75
311:             .Height          = 75
312:             .FontName        = "Comic Sans MS"
313:             .FontSize        = 8
314:             .FontBold        = .T.
315:             .FontItalic      = .T.
316:             .ForeColor       = RGB(90, 90, 90)
317:             .BackColor       = RGB(255, 255, 255)
318:             .Themes          = .F.
319:             .SpecialEffect   = 0
320:             .WordWrap        = .T.
321:             .MousePointer    = 15
322:             .Visible         = .T.
323:         ENDWITH
324:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
325: 
326:         *-- Grid de listagem (Top=117=88+29, Left=26, Width=890, Height=498)
327:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
328:         loc_oGrid = loc_oPg1.grd_4c_Lista
329:         loc_oGrid.Top         = 117
330:         loc_oGrid.Left        = 26
331:         loc_oGrid.Width       = 890
332:         loc_oGrid.Height      = 498
333:         loc_oGrid.ColumnCount = 2
334:         WITH loc_oGrid
335:             .FontName           = "Verdana"

*-- Linhas 348 a 358:
348:             .ReadOnly           = .T.
349:             .Visible            = .T.
350:             .Column1.Width              = 80
351:             .Column1.Header1.Caption    = "C" + CHR(243) + "digo"
352:             .Column2.Width              = 150
353:             .Column2.Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
354:         ENDWITH
355:         BINDEVENT(loc_oGrid, "DblClick", THIS, "GridDblClick")
356: 
357:         THIS.TornarControlesVisiveis(loc_oPg1)
358:     ENDPROC

*-- Linhas 369 a 437:
369:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
370:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
371:         WITH loc_oBotoesAcao
372:             .Top         = 33
373:             .Left        = 842
374:             .Width       = 160
375:             .Height      = 85
376:             .BackStyle   = 0
377:             .BorderWidth = 0
378:             .Visible     = .T.
379:         ENDWITH
380: 
381:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
382:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
383:             .Caption         = "Confirmar"
384:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
385:             .PicturePosition = 13
386:             .Top             = 5
387:             .Left            = 5
388:             .Width           = 75
389:             .Height          = 75
390:             .FontName        = "Comic Sans MS"
391:             .FontSize        = 8
392:             .FontBold        = .T.
393:             .FontItalic      = .T.
394:             .ForeColor       = RGB(90, 90, 90)
395:             .BackColor       = RGB(255, 255, 255)
396:             .Themes          = .F.
397:             .SpecialEffect   = 0
398:             .WordWrap        = .T.
399:             .MousePointer    = 15
400:             .Visible         = .T.
401:         ENDWITH
402:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
403: 
404:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
405:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
406:             .Caption         = "Encerrar"
407:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
408:             .PicturePosition = 13
409:             .Top             = 5
410:             .Left            = 80
411:             .Width           = 75
412:             .Height          = 75
413:             .FontName        = "Comic Sans MS"
414:             .FontSize        = 8
415:             .FontBold        = .T.
416:             .FontItalic      = .T.
417:             .ForeColor       = RGB(90, 90, 90)
418:             .BackColor       = RGB(255, 255, 255)
419:             .Themes          = .F.
420:             .SpecialEffect   = 0
421:             .WordWrap        = .T.
422:             .MousePointer    = 15
423:             .Visible         = .T.
424:         ENDWITH
425:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
426: 
427:         *-- Label "Codigo :" (Say1: Top=170+29=199, Left=187, ForeColor=36,84,155)
428:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
429:         WITH loc_oPg2.lbl_4c_Label1
430:             .Caption   = "C" + CHR(243) + "digo :"
431:             .Top       = 199
432:             .Left      = 187
433:             .Width     = 60
434:             .Height    = 17
435:             .FontName  = "Verdana"
436:             .FontSize  = 8
437:             .FontBold  = .F.

*-- Linhas 445 a 469:
445:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
446:         WITH loc_oPg2.txt_4c_Codigo
447:             .Value     = ""
448:             .Top       = 195
449:             .Left      = 239
450:             .Width     = 45
451:             .Height    = 24
452:             .MaxLength = 5
453:             .FontName  = "Tahoma"
454:             .FontSize  = 8
455:             .TabIndex  = 2
456:             .Visible   = .T.
457:         ENDWITH
458: 
459:         *-- Label "Descricao :" (Say2: Top=197+29=226, Left=171, ForeColor=36,84,155)
460:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
461:         WITH loc_oPg2.lbl_4c_Label2
462:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
463:             .Top       = 226
464:             .Left      = 171
465:             .Width     = 70
466:             .Height    = 17
467:             .FontName  = "Verdana"
468:             .FontSize  = 8
469:             .FontBold  = .F.

*-- Linhas 477 a 486:
477:         loc_oPg2.AddObject("txt_4c_Descricao", "TextBox")
478:         WITH loc_oPg2.txt_4c_Descricao
479:             .Value     = ""
480:             .Top       = 222
481:             .Left      = 239
482:             .Width     = 220
483:             .Height    = 24
484:             .MaxLength = 0
485:             .FontName  = "Tahoma"
486:             .FontSize  = 8

*-- Linhas 513 a 522:
513:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
514:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
515:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
516:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
517:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
518:                         loc_oGrid.Column1.Width = 80
519:                         loc_oGrid.Column2.Width = 150
520:                         THIS.FormatarGridLista(loc_oGrid)
521:                     ENDIF
522:                     loc_lResultado = .T.

*-- Linhas 693 a 702:
693:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
694:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cods"
695:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descs"
696:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
697:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
698:                     loc_oGrid.Column1.Width = 80
699:                     loc_oGrid.Column2.Width = 150
700:                     THIS.FormatarGridLista(loc_oGrid)
701:                 ENDIF
702:             ENDIF

*-- Linhas 755 a 764:
755:             loc_oPg2.txt_4c_Descricao.ReadOnly = !loc_lHab
756:         ENDIF
757:         IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao) = "O"
758:             IF VARTYPE(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar) = "O"
759:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHab
760:             ENDIF
761:         ENDIF
762:     ENDPROC
763: 
764:     *--------------------------------------------------------------------------

*-- Linhas 790 a 798:
790:     ENDPROC
791: 
792:     *--------------------------------------------------------------------------
793:     * BtnSalvarClick - Valida e salva o registro (handler do cmd_4c_Confirmar)
794:     *--------------------------------------------------------------------------
795:     PROCEDURE BtnSalvarClick()
796:         LOCAL loc_oPg2, loc_cCodigo, loc_cDescricao
797:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
798: 


### BO (C:\4c\projeto\app\classes\BCCBO.prg):
*==============================================================================
* BCCBO.prg - Business Object para Bandeiras de Cartao de Credito
* Tabela: SIGCDCRT (cods char(5) PK, descs char(30))
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS BCCBO AS BusinessBase

    *-- Propriedades da entidade
    this_cCodigo    = ""    && cods  char(5)  PK
    this_cDescricao = ""    && descs char(30)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela    = "SIGCDCRT"
            THIS.this_cCampoChave = "cods"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao inicializar BCCBO: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna o valor da chave primaria (para auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades a partir de cursor aberto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = TratarNulo(cods,  "C")
                THIS.this_cDescricao = TratarNulo(descs, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BCCBO.CarregarDoCursor: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Retorna todos os registros em cursor_4c_Dados
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            loc_cSQL = "SELECT cods, descs FROM SIGCDCRT"
            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY cods"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar bandeiras de cart" + CHR(227) + "o: " + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BCCBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pela chave primaria
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descs FROM SIGCDCRT" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar bandeira: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BCCBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SIGCDCRT (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCDCRT (cods, descs)" + ;
                " VALUES (" + EscaparSQL(THIS.this_cCodigo) + ;
                ", " + EscaparSQL(THIS.this_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir bandeira: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BCCBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SIGCDCRT (chamado pelo BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCDCRT SET" + ;
                " descs = " + EscaparSQL(THIS.this_cDescricao) + ;
                " WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar bandeira: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BCCBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SIGCDCRT (chamado pelo BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCDCRT WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir bandeira: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em BCCBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

