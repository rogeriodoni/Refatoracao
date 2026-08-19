# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 235: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 260: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 285: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 322: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 409: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 434: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMPL.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (878 linhas total):

*-- Linhas 53 a 65:
53:                 THIS.ConfigurarPageFrame()
54: 
55:                 IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho) = "O"
56:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra) = "O"
57:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                     ENDIF
59:                     IF VARTYPE(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo) = "O"
60:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                     ENDIF
62:                 ENDIF
63: 
64:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
65:                     THIS.CarregarLista()

*-- Linhas 84 a 103:
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85:         THIS.pgf_4c_Paginas.PageCount = 2
86:         WITH THIS.pgf_4c_Paginas
87:             .Top    = -29
88:             .Left   = 0
89:             .Width  = THIS.Width
90:             .Height = THIS.Height + 29
91:             .Tabs   = .F.
92:             .Visible = .T.
93: 
94:             .Page1.Caption   = "Lista"
95:             .Page1.BackColor = RGB(255, 255, 255)
96:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97: 
98:             .Page2.Caption   = "Dados"
99:             .Page2.BackColor = RGB(255, 255, 255)
100:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:         ENDWITH
102: 
103:         THIS.ConfigurarPaginaLista()

*-- Linhas 117 a 344:
117:         *-- Container Cabecalho
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top         = 31
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
130:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = 769
134:             .Height    = 40
135:             .FontName  = "Tahoma"
136:             .FontSize  = 16
137:             .FontBold  = .T.
138:             .ForeColor = RGB(0, 0, 0)
139:             .BackStyle = 0
140:             .AutoSize  = .F.
141:             .Caption   = THIS.Caption
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
147:             .Top       = 18
148:             .Left      = 10
149:             .Width     = 769
150:             .Height    = 46
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(255, 255, 255)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Caption   = THIS.Caption
158:             .Visible   = .T.
159:         ENDWITH
160: 
161:         *-- Container Botoes CRUD (lado direito, Left=542 canonico)
162:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
163:         WITH loc_oPagina.cnt_4c_Botoes
164:             .Top         = 29
165:             .Left        = 542
166:             .Width       = 390
167:             .Height      = 85
168:             .BackStyle = 0
169:             .BorderWidth = 0
170:             .Visible     = .T.
171:         ENDWITH
172: 
173:         *-- Botao Incluir
174:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
175:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
176:             .Caption         = "Incluir"
177:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
178:             .PicturePosition = 13
179:             .Top             = 5
180:             .Left            = 5
181:             .Width           = 75
182:             .Height          = 75
183:             .BackColor       = RGB(255, 255, 255)
184:             .ForeColor       = RGB(90, 90, 90)
185:             .FontName        = "Comic Sans MS"
186:             .FontSize        = 8
187:             .FontBold        = .T.
188:             .FontItalic      = .T.
189:             .Themes          = .F.
190:             .SpecialEffect   = 0
191:             .MousePointer    = 15
192:             .WordWrap        = .T.
193:             .AutoSize        = .F.
194:             .Visible         = .T.
195:         ENDWITH
196:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
197: 
198:         *-- Botao Visualizar
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
201:             .Caption         = "Visualizar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 80
206:             .Width           = 75
207:             .Height          = 75
208:             .BackColor       = RGB(255, 255, 255)
209:             .ForeColor       = RGB(90, 90, 90)
210:             .FontName        = "Comic Sans MS"
211:             .FontSize        = 8
212:             .FontBold        = .T.
213:             .FontItalic      = .T.
214:             .Themes          = .F.
215:             .SpecialEffect   = 0
216:             .MousePointer    = 15
217:             .WordWrap        = .T.
218:             .AutoSize        = .F.
219:             .Visible         = .T.
220:         ENDWITH
221:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
222: 
223:         *-- Botao Alterar
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .BackColor       = RGB(255, 255, 255)
234:             .ForeColor       = RGB(90, 90, 90)
235:             .FontName        = "Comic Sans MS"
236:             .FontSize        = 8
237:             .FontBold        = .T.
238:             .FontItalic      = .T.
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .MousePointer    = 15
242:             .WordWrap        = .T.
243:             .AutoSize        = .F.
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
247: 
248:         *-- Botao Excluir
249:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
250:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
251:             .Caption         = "Excluir"
252:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
253:             .PicturePosition = 13
254:             .Top             = 5
255:             .Left            = 230
256:             .Width           = 75
257:             .Height          = 75
258:             .BackColor       = RGB(255, 255, 255)
259:             .ForeColor       = RGB(90, 90, 90)
260:             .FontName        = "Comic Sans MS"
261:             .FontSize        = 8
262:             .FontBold        = .T.
263:             .FontItalic      = .T.
264:             .Themes          = .F.
265:             .SpecialEffect   = 0
266:             .MousePointer    = 15
267:             .WordWrap        = .T.
268:             .AutoSize        = .F.
269:             .Visible         = .T.
270:         ENDWITH
271:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
272: 
273:         *-- Botao Buscar
274:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
275:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
276:             .Caption         = "Buscar"
277:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
278:             .PicturePosition = 13
279:             .Top             = 5
280:             .Left            = 305
281:             .Width           = 75
282:             .Height          = 75
283:             .BackColor       = RGB(255, 255, 255)
284:             .ForeColor       = RGB(90, 90, 90)
285:             .FontName        = "Comic Sans MS"
286:             .FontSize        = 8
287:             .FontBold        = .T.
288:             .FontItalic      = .T.
289:             .Themes          = .F.
290:             .SpecialEffect   = 0
291:             .MousePointer    = 15
292:             .WordWrap        = .T.
293:             .AutoSize        = .F.
294:             .Visible         = .T.
295:         ENDWITH
296:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298:         *-- Container Saida (canonico: Left=917, Width=90)
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         *-- Botao Encerrar
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .BackColor       = RGB(255, 255, 255)
321:             .ForeColor       = RGB(90, 90, 90)
322:             .FontName        = "Comic Sans MS"
323:             .FontSize        = 8
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .MousePointer    = 15
329:             .WordWrap        = .T.
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid de Lista (SigPrCpl: Codigos 150px, Descrs 290px)
336:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
337:         loc_oGrid = loc_oPagina.grd_4c_Lista
338:         loc_oGrid.Top         = 117
339:         loc_oGrid.Left        = 26
340:         loc_oGrid.Width       = 890
341:         loc_oGrid.Height      = 498
342:         loc_oGrid.ColumnCount = 2
343:         WITH loc_oGrid
344:             .FontName           = "Verdana"

*-- Linhas 360 a 374:
360:         WITH loc_oGrid.Column1
361:             .Width              = 150
362:             .Alignment          = 0
363:             .Header1.Caption    = "C" + CHR(243) + "digo"
364:         ENDWITH
365: 
366:         WITH loc_oGrid.Column2
367:             .Width              = 290
368:             .Alignment          = 0
369:             .Header1.Caption    = "Descri" + CHR(231) + CHR(227) + "o"
370:         ENDWITH
371: 
372:         THIS.TornarControlesVisiveis(loc_oPagina)
373:     ENDPROC
374: 

*-- Linhas 385 a 457:
385:         *-- Container BotoesAcao (Salvar/Cancelar) - canonico Top=33 (4+29 comp.)
386:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
387:         WITH loc_oPagina.cnt_4c_BotoesAcao
388:             .Top         = 33
389:             .Left        = 842
390:             .Width       = 160
391:             .Height      = 85
392:             .BackStyle   = 0
393:             .BorderWidth = 0
394:             .Visible     = .T.
395:         ENDWITH
396: 
397:         *-- Botao Salvar (Grupo_Salva.Salva: Left=5, Top=5)
398:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
399:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
400:             .Caption         = "Salvar"
401:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
402:             .PicturePosition = 13
403:             .Top             = 5
404:             .Left            = 5
405:             .Width           = 75
406:             .Height          = 75
407:             .BackColor       = RGB(255, 255, 255)
408:             .ForeColor       = RGB(90, 90, 90)
409:             .FontName        = "Comic Sans MS"
410:             .FontSize        = 8
411:             .FontBold        = .T.
412:             .FontItalic      = .T.
413:             .Themes          = .F.
414:             .SpecialEffect   = 0
415:             .MousePointer    = 15
416:             .WordWrap        = .T.
417:             .AutoSize        = .F.
418:             .Visible         = .T.
419:         ENDWITH
420:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
421: 
422:         *-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
423:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
424:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
425:             .Caption         = "Encerrar"
426:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
427:             .PicturePosition = 13
428:             .Top             = 5
429:             .Left            = 80
430:             .Width           = 75
431:             .Height          = 75
432:             .BackColor       = RGB(255, 255, 255)
433:             .ForeColor       = RGB(90, 90, 90)
434:             .FontName        = "Comic Sans MS"
435:             .FontSize        = 8
436:             .FontBold        = .T.
437:             .FontItalic      = .T.
438:             .Themes          = .F.
439:             .SpecialEffect   = 0
440:             .MousePointer    = 15
441:             .WordWrap        = .T.
442:             .AutoSize        = .F.
443:             .Visible         = .T.
444:         ENDWITH
445:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
446: 
447:         *-- Label Codigo (Say1: Top=186+29=215, Left=339, ForeColor=90,90,90)
448:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
449:         WITH loc_oPagina.lbl_4c_Label1
450:             .Caption   = "C" + CHR(243) + "digo :"
451:             .Top       = 215
452:             .Left      = 339
453:             .Width     = 56
454:             .Height    = 17
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .FontBold  = .F.

*-- Linhas 466 a 475:
466:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
467:         WITH loc_oPagina.txt_4c_Codigos
468:             .Value         = ""
469:             .Top           = 211
470:             .Left          = 383
471:             .Width         = 150
472:             .Height        = 23
473:             .FontName      = "Tahoma"
474:             .FontSize      = 8
475:             .MaxLength     = 20

*-- Linhas 481 a 493:
481:         ENDWITH
482: 
483:         *-- Label Descricao (Say2: Top=211+29=240, Left=326)
484:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
485:         WITH loc_oPagina.lbl_4c_Label2
486:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
487:             .Top       = 240
488:             .Left      = 326
489:             .Width     = 72
490:             .Height    = 17
491:             .FontName  = "Tahoma"
492:             .FontSize  = 8
493:             .FontBold  = .F.

*-- Linhas 502 a 511:
502:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
503:         WITH loc_oPagina.txt_4c_Descrs
504:             .Value         = ""
505:             .Top           = 236
506:             .Left          = 383
507:             .Width         = 290
508:             .Height        = 23
509:             .FontName      = "Tahoma"
510:             .FontSize      = 8
511:             .MaxLength     = 40

*-- Linhas 542 a 551:
542:                         loc_oGrid.Column1.Width = 150
543:                         loc_oGrid.Column2.Width = 290
544: 
545:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
546:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
547: 
548:                         THIS.FormatarGridLista(loc_oGrid)
549:                         loc_lResultado = .T.
550:                     ENDIF
551:                 ENDIF

*-- Linhas 674 a 686:
674: 
675:         DO CASE
676:             CASE THIS.this_cModoAtual = "VISUALIZAR"
677:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled   = .F.
678:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
679:             OTHERWISE
680:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled   = .T.
681:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
682:         ENDCASE
683:     ENDPROC
684: 
685:     *==========================================================================
686:     * BtnIncluirClick - Incluir novo registro

*-- Linhas 718 a 726:
718:             THIS.HabilitarCampos(.F.)
719:             THIS.AjustarBotoesPorModo()
720:             THIS.AlternarPagina(2)
721:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus
722:         ENDIF
723:     ENDPROC
724: 
725:     *==========================================================================
726:     * BtnAlterarClick - Alterar registro selecionado

*-- Linhas 773 a 781:
773:             THIS.HabilitarCampos(.F.)
774:             THIS.AjustarBotoesPorModo()
775:             THIS.AlternarPagina(2)
776:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Salvar.SetFocus
777:         ENDIF
778:     ENDPROC
779: 
780:     *==========================================================================
781:     * BtnBuscarClick - Posicionar lista por codigo (original: Procurar/msv_procurar)


### BO (C:\4c\projeto\app\classes\MPLBO.prg):
*==============================================================================
* MPLBO.prg - Business Object para Complementos de Caracteristicas
* Tabela: SigPrCpl
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS MPLBO AS BusinessBase

    *-- Propriedades de dados
    this_cCodigos = ""
    this_cDescrs  = ""

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCpl"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com filtro opcional (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cFiltro) != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigPrCpl"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY Codigos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar complementos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro especifico pela PK (PUBLIC)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Descrs FROM SigPrCpl" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cCodigo))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos = TratarNulo(Codigos, "C")
            THIS.this_cDescrs  = TratarNulo(Descrs,  "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigPrCpl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nVerifica
        loc_lSucesso = .F.

        TRY
            *-- Verificar duplicidade
            loc_cSQL = "SELECT Codigos FROM SigPrCpl" + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            IF USED("cursor_4c_Verifica")
                USE IN cursor_4c_Verifica
            ENDIF

            loc_nVerifica = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Verifica")

            IF loc_nVerifica >= 0 AND RECCOUNT("cursor_4c_Verifica") > 0
                MsgErro("Complemento de Caracter" + CHR(237) + "stica J" + CHR(225) + " Cadastrado!!!", "")
                IF USED("cursor_4c_Verifica")
                    USE IN cursor_4c_Verifica
                ENDIF
            ELSE
                IF USED("cursor_4c_Verifica")
                    USE IN cursor_4c_Verifica
                ENDIF

                loc_cSQL = "INSERT INTO SigPrCpl (Codigos, Descrs)" + ;
                           " VALUES (" + EscaparSQL(ALLTRIM(THIS.this_cCodigos)) + ;
                           ", " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigPrCpl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCpl SET" + ;
                       " Descrs = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs)) + ;
                       " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigPrCpl (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nVerifica
        loc_lSucesso = .F.

        TRY
            *-- Verificar uso em SigClCrc (campo Compls = descricao do complemento)
            loc_cSQL = "SELECT Compls FROM SigClCrc" + ;
                       " WHERE Compls = " + EscaparSQL(ALLTRIM(THIS.this_cDescrs))

            IF USED("cursor_4c_VerifUso")
                USE IN cursor_4c_VerifUso
            ENDIF

            loc_nVerifica = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifUso")

            IF loc_nVerifica >= 0 AND RECCOUNT("cursor_4c_VerifUso") > 0
                MsgErro("Complemento de Caracter" + CHR(237) + "stica Sendo Utilizada!!!", "")
                IF USED("cursor_4c_VerifUso")
                    USE IN cursor_4c_VerifUso
                ENDIF
            ELSE
                IF USED("cursor_4c_VerifUso")
                    USE IN cursor_4c_VerifUso
                ENDIF

                loc_cSQL = "DELETE FROM SigPrCpl" + ;
                           " WHERE Codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCodigos))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigos)
    ENDPROC

ENDDEFINE

