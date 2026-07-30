# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (10)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 173: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 196: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 219: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 265: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 301: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 377: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 401: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 437: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCsi.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (883 linhas total):

*-- Linhas 79 a 95:
79: 
80:         THIS.pgf_4c_Paginas.PageCount = 2
81:         WITH THIS.pgf_4c_Paginas
82:             .Top       = -29
83:             .Left      = 0
84:             .Width     = THIS.Width
85:             .Height    = THIS.Height + 29
86:             .Tabs      = .F.
87:             .Page1.Caption    = "Lista"
88:             .Page1.BackColor  = RGB(192, 192, 192)
89:             .Page1.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
90:             .Page2.Caption    = "Dados"
91:             .Page2.BackColor  = RGB(192, 192, 192)
92:             .Page2.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
93:             .Visible   = .T.
94:         ENDWITH
95:     ENDPROC

*-- Linhas 107 a 143:
107:         *-- Container Cabecalho (cntSombra no legado)
108:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
109:         WITH loc_oPagina.cnt_4c_Cabecalho
110:             .Top         = 2
111:             .Left        = 0
112:             .Width       = THIS.Width
113:             .Height      = 80
114:             .BackColor   = RGB(100, 100, 100)
115:             .BorderWidth = 0
116:             .Visible     = .T.
117:         ENDWITH
118: 
119:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
120:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
121:             .Caption   = THIS.Caption
122:             .Top       = 15
123:             .Left      = 12
124:             .Width     = 769
125:             .Height    = 40
126:             .FontName  = "Tahoma"
127:             .FontSize  = 16
128:             .FontBold  = .T.
129:             .ForeColor = RGB(0, 0, 0)
130:             .BackStyle = 0
131:             .AutoSize  = .F.
132:         ENDWITH
133: 
134:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
135:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
136:             .Caption   = THIS.Caption
137:             .Top       = 18
138:             .Left      = 10
139:             .Width     = 769
140:             .Height    = 46
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.

*-- Linhas 149 a 327:
149:         *-- Container Botoes CRUD (Grupo_Op no legado) - lado direito
150:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
151:         WITH loc_oPagina.cnt_4c_Botoes
152:             .Top         = 0
153:             .Left        = 542
154:             .Width       = 390
155:             .Height      = 85
156:             .BackStyle   = 1
157:             .BackColor   = RGB(53, 53, 53)
158:             .BorderWidth = 0
159:             .Visible     = .T.
160:         ENDWITH
161: 
162:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
163: 
164:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
165:         WITH loc_oCnt.cmd_4c_Incluir
166:             .Caption         = "Incluir"
167:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
168:             .PicturePosition = 13
169:             .Top             = 5
170:             .Left            = 5
171:             .Width           = 75
172:             .Height          = 75
173:             .FontName        = "Comic Sans MS"
174:             .FontSize        = 8
175:             .FontBold        = .T.
176:             .FontItalic      = .T.
177:             .ForeColor       = RGB(90, 90, 90)
178:             .BackColor       = RGB(255, 255, 255)
179:             .Themes          = .F.
180:             .SpecialEffect   = 0
181:             .MousePointer    = 15
182:             .WordWrap        = .T.
183:             .AutoSize        = .F.
184:         ENDWITH
185:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
186: 
187:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
188:         WITH loc_oCnt.cmd_4c_Visualizar
189:             .Caption         = "Visualizar"
190:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
191:             .PicturePosition = 13
192:             .Top             = 5
193:             .Left            = 80
194:             .Width           = 75
195:             .Height          = 75
196:             .FontName        = "Comic Sans MS"
197:             .FontSize        = 8
198:             .FontBold        = .T.
199:             .FontItalic      = .T.
200:             .ForeColor       = RGB(90, 90, 90)
201:             .BackColor       = RGB(255, 255, 255)
202:             .Themes          = .F.
203:             .SpecialEffect   = 0
204:             .MousePointer    = 15
205:             .WordWrap        = .T.
206:             .AutoSize        = .F.
207:         ENDWITH
208:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
209: 
210:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
211:         WITH loc_oCnt.cmd_4c_Alterar
212:             .Caption         = "Alterar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 155
217:             .Width           = 75
218:             .Height          = 75
219:             .FontName        = "Comic Sans MS"
220:             .FontSize        = 8
221:             .FontBold        = .T.
222:             .FontItalic      = .T.
223:             .ForeColor       = RGB(90, 90, 90)
224:             .BackColor       = RGB(255, 255, 255)
225:             .Themes          = .F.
226:             .SpecialEffect   = 0
227:             .MousePointer    = 15
228:             .WordWrap        = .T.
229:             .AutoSize        = .F.
230:         ENDWITH
231:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
232: 
233:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
234:         WITH loc_oCnt.cmd_4c_Excluir
235:             .Caption         = "Excluir"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
237:             .PicturePosition = 13
238:             .Top             = 5
239:             .Left            = 230
240:             .Width           = 75
241:             .Height          = 75
242:             .FontName        = "Comic Sans MS"
243:             .FontSize        = 8
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .ForeColor       = RGB(90, 90, 90)
247:             .BackColor       = RGB(255, 255, 255)
248:             .Themes          = .F.
249:             .SpecialEffect   = 0
250:             .MousePointer    = 15
251:             .WordWrap        = .T.
252:             .AutoSize        = .F.
253:         ENDWITH
254:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
255: 
256:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
257:         WITH loc_oCnt.cmd_4c_Buscar
258:             .Caption         = "Buscar"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 305
263:             .Width           = 75
264:             .Height          = 75
265:             .FontName        = "Comic Sans MS"
266:             .FontSize        = 8
267:             .FontBold        = .T.
268:             .FontItalic      = .T.
269:             .ForeColor       = RGB(90, 90, 90)
270:             .BackColor       = RGB(255, 255, 255)
271:             .Themes          = .F.
272:             .SpecialEffect   = 0
273:             .MousePointer    = 15
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:         ENDWITH
277:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
278: 
279:         *-- Container Saida - padrao canonico (Left=917, Width=90, cmd=75x75)
280:         *-- Top = 29 (compensacao PageFrame.Top=-29)
281:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
282:         WITH loc_oPagina.cnt_4c_Saida
283:             .Top         = 29
284:             .Left        = 917
285:             .Width       = 90
286:             .Height      = 85
287:             .BackStyle   = 0
288:             .BorderWidth = 0
289:             .Visible     = .T.
290:         ENDWITH
291: 
292:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
293:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
294:             .Caption         = "Encerrar"
295:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
296:             .PicturePosition = 13
297:             .Top             = 5
298:             .Left            = 5
299:             .Width           = 75
300:             .Height          = 75
301:             .FontName        = "Comic Sans MS"
302:             .FontSize        = 8
303:             .FontBold        = .T.
304:             .FontItalic      = .T.
305:             .ForeColor       = RGB(90, 90, 90)
306:             .BackColor       = RGB(255, 255, 255)
307:             .Themes          = .F.
308:             .SpecialEffect   = 0
309:             .MousePointer    = 15
310:             .WordWrap        = .T.
311:             .AutoSize        = .F.
312:         ENDWITH
313:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", ;
314:                   THIS, "BtnEncerrarClick")
315: 
316:         *-- Grid Lista (Grade no legado): Cods(80) + Descs(150)
317:         *-- Top = 121(original) + 29(compensacao PageFrame) = 150; Left = 12 (original)
318:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
319:         loc_oPagina.grd_4c_Lista.ColumnCount = 2
320:         WITH loc_oPagina.grd_4c_Lista
321:             .Top                = 150
322:             .Left               = 12
323:             .Width              = 900
324:             .Height             = 420
325:             .FontName           = "Verdana"
326:             .FontSize           = 8
327:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 357 a 464:
357:         *-- Top = 4+29 = 33 (original Top=4 + compensacao PageFrame)
358:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
359:         WITH loc_oPagina.cnt_4c_BotoesAcao
360:             .Top         = 33
361:             .Left        = 842
362:             .Width       = 160
363:             .Height      = 85
364:             .BackStyle   = 0
365:             .Visible     = .T.
366:         ENDWITH
367: 
368:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
369:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
370:             .Caption         = "Confirmar"
371:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
372:             .PicturePosition = 13
373:             .Top             = 5
374:             .Left            = 5
375:             .Width           = 75
376:             .Height          = 75
377:             .FontName        = "Comic Sans MS"
378:             .FontSize        = 8
379:             .FontBold        = .T.
380:             .FontItalic      = .T.
381:             .ForeColor       = RGB(90, 90, 90)
382:             .BackColor       = RGB(255, 255, 255)
383:             .Themes          = .F.
384:             .SpecialEffect   = 0
385:             .MousePointer    = 15
386:             .WordWrap        = .T.
387:             .AutoSize        = .F.
388:         ENDWITH
389:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", ;
390:                   THIS, "BtnSalvarClick")
391: 
392:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
393:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
394:             .Caption         = "Encerrar"
395:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
396:             .PicturePosition = 13
397:             .Top             = 5
398:             .Left            = 80
399:             .Width           = 75
400:             .Height          = 75
401:             .FontName        = "Comic Sans MS"
402:             .FontSize        = 8
403:             .FontBold        = .T.
404:             .FontItalic      = .T.
405:             .ForeColor       = RGB(90, 90, 90)
406:             .BackColor       = RGB(255, 255, 255)
407:             .Themes          = .F.
408:             .SpecialEffect   = 0
409:             .MousePointer    = 15
410:             .WordWrap        = .T.
411:             .AutoSize        = .F.
412:         ENDWITH
413:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", ;
414:                   THIS, "BtnCancelarClick")
415: 
416:         *-- Container Saida na Page2 - padrao canonico
417:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
418:         WITH loc_oPagina.cnt_4c_Saida
419:             .Top       = 29
420:             .Left      = 917
421:             .Width     = 90
422:             .Height    = 85
423:             .BackStyle = 0
424:             .BorderWidth = 0
425:             .Visible     = .T.
426:         ENDWITH
427: 
428:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
429:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
430:             .Caption         = "Encerrar"
431:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
432:             .PicturePosition = 13
433:             .Top             = 5
434:             .Left            = 5
435:             .Width           = 75
436:             .Height          = 75
437:             .FontName        = "Comic Sans MS"
438:             .FontSize        = 8
439:             .FontBold        = .T.
440:             .FontItalic      = .T.
441:             .ForeColor       = RGB(90, 90, 90)
442:             .BackColor       = RGB(255, 255, 255)
443:             .Themes          = .F.
444:             .SpecialEffect   = 0
445:             .MousePointer    = 15
446:             .WordWrap        = .T.
447:             .AutoSize        = .F.
448:         ENDWITH
449: 
450:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", ;
451:                   THIS, "BtnEncerrarClick")
452: 
453:         *-- Label e TextBox: Codigo (Say1 + getCods)
454:         *-- Original: Say1.Top=141, getCods.Top=137, Left=355/400 -> compensado +29
455:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
456:         WITH loc_oPagina.lbl_4c_Label1
457:             .Caption   = "C" + CHR(243) + "digo :"
458:             .Top       = 170
459:             .Left      = 355
460:             .Width     = 45
461:             .Height    = 17
462:             .FontName  = "Tahoma"
463:             .FontSize  = 8
464:             .FontBold  = .F.

*-- Linhas 471 a 495:
471:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
472:         WITH loc_oPagina.txt_4c_Codigo
473:             .Value     = ""
474:             .Top       = 166
475:             .Left      = 400
476:             .Width     = 40
477:             .Height    = 24
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .MaxLength = 2
481:             .Enabled   = .F.
482:         ENDWITH
483: 
484:         *-- Label e TextBox: Descricao (Say2 + getDescs)
485:         *-- Original: Say2.Top=167, getDescs.Top=163, Left=342/400 -> compensado +29
486:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
487:         WITH loc_oPagina.lbl_4c_Label2
488:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
489:             .Top       = 196
490:             .Left      = 342
491:             .Width     = 58
492:             .Height    = 17
493:             .FontName  = "Tahoma"
494:             .FontSize  = 8
495:             .FontBold  = .F.

*-- Linhas 502 a 511:
502:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
503:         WITH loc_oPagina.txt_4c_Descricao
504:             .Value     = ""
505:             .Top       = 192
506:             .Left      = 400
507:             .Width     = 264
508:             .Height    = 24
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8
511:             .MaxLength = 30

*-- Linhas 535 a 546:
535:                     WITH loc_oGrid
536:                         .Column1.ControlSource   = "cursor_4c_Dados.Cods"
537:                         .Column1.Width           = 80
538:                         .Column1.Header1.Caption = "C" + CHR(243) + "digo"
539:                         .Column2.ControlSource   = "cursor_4c_Dados.Descs"
540:                         .Column2.Width           = 150
541:                         .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
542:                     ENDWITH
543: 
544:                     THIS.FormatarGridLista(loc_oGrid)
545:                     loc_oGrid.Refresh()
546:                     THIS.AjustarBotoesPorModo()

*-- Linhas 799 a 808:
799:             loc_oPagina.txt_4c_Descricao.Enabled = par_lHabilitar
800:         ENDIF
801:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
802:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
803:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
804:             ENDIF
805:         ENDIF
806:     ENDPROC
807: 
808:     *==========================================================================

*-- Linhas 844 a 859:
844:         loc_oCnt      = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
845:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
846: 
847:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
848:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
849:         ENDIF
850:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
851:             loc_oCnt.cmd_4c_Alterar.Enabled = loc_lTemRegistro
852:         ENDIF
853:         IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
854:             loc_oCnt.cmd_4c_Excluir.Enabled = loc_lTemRegistro
855:         ENDIF
856:     ENDPROC
857: 
858:     *==========================================================================
859:     * FormatarGridLista - Formata visual do grid da lista (Tahoma 8)


### BO (C:\4c\projeto\app\classes\CsiBO.prg):
*------------------------------------------------------------------------------
* CsiBO.prg - Business Object: Categoria do Site
* Tabela: sigcdcsi | PK: pkchaves char(20) | Campos: cods char(2), descs char(30)
*------------------------------------------------------------------------------

DEFINE CLASS CsiBO AS BusinessBase

    *-- Propriedades de dados
    this_cCodigo    = ""    && cods     char(2) - codigo da categoria
    this_cDescricao = ""    && descs    char(30) - descricao da categoria
    this_cPkChaves  = ""    && pkchaves char(20) - PK tecnica gerada no insert

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "sigcdcsi"
            THIS.this_cCampoChave = "pkchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "CsiBO.Init")
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
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cPkChaves  = TratarNulo(pkChaves, "C")
                THIS.this_cCodigo    = TratarNulo(Cods,     "C")
                THIS.this_cDescricao = TratarNulo(Descs,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "CsiBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    * Replica logica do Salva.Click original: valida Cods e Descs obrigatorios
    * + verificacao de duplicidade no INSERT
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo Inv" + CHR(225) + "lido!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo J" + CHR(225) + " Cadastrado!!!", ;
                         "Aten" + CHR(231) + CHR(227) + "o!!!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida!!!", ;
                     "Aten" + CHR(231) + CHR(227) + "o!!!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoExistente - Verifica se cods ja existe na tabela
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM sigcdcsi" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "CsiBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela sigcdcsi
    * Gera pkChaves unico via SYS(2015) (substituto do fUniqueIds legado)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO sigcdcsi (pkChaves, Cods, Descs)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChaves)>>,
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "CsiBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela sigcdcsi
    * Nota: Cods e readonly em ALTERAR (getCods.When = .F. no original)
    * UPDATE apenas Descs, identificando pelo Cods (chave natural)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE sigcdcsi
                SET Descs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE Cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "CsiBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela sigcdcsi
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM sigcdcsi" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "CsiBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT registros com filtro opcional
    * Retorna cursor_4c_Dados com pkChaves, Cods, Descs
    * Grid mostra: Cods (Codigo, 80px), Descs (Descricao, 150px)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (pkChaves C(20), Cods C(2), Descs C(30))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT pkChaves, Cods, Descs FROM sigcdcsi"

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
                        MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "CsiBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo natural (Cods)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT pkChaves, Cods, Descs FROM sigcdcsi" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Categoria n" + CHR(227) + "o encontrada!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "CsiBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

