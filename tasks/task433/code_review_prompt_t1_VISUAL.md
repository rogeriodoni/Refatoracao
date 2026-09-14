# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 164: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 187: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 210: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 256: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 383: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 406: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFTF.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (909 linhas total):

*-- Linhas 67 a 83:
67:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
68:         WITH THIS.pgf_4c_Paginas
69:             .PageCount = 2
70:             .Top       = -29
71:             .Left      = 0
72:             .Width     = THIS.Width
73:             .Height    = THIS.Height + 29
74:             .Tabs      = .F.
75:             .Page1.Caption   = "Lista"
76:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
77:             .Page1.BackColor = RGB(100, 100, 100)
78:             .Page2.Caption   = "Dados"
79:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
80:             .Page2.BackColor = RGB(100, 100, 100)
81:             .Visible   = .T.
82:         ENDWITH
83: 

*-- Linhas 97 a 262:
97:         *-- Container cabecalho (cntSombra no legado)
98:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
99:         WITH loc_oPagina.cnt_4c_Cabecalho
100:             .Top         = 2 + 29
101:             .Left        = 0
102:             .Width       = THIS.Width
103:             .Height      = 80
104:             .BackColor   = RGB(100, 100, 100)
105:             .BorderWidth = 0
106:             .Visible     = .T.
107:         ENDWITH
108: 
109:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
110:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
111:             .Top       = 15
112:             .Left      = 12
113:             .Width     = 769
114:             .Height    = 40
115:             .Caption   = THIS.Caption
116:             .FontName  = "Tahoma"
117:             .FontSize  = 16
118:             .FontBold  = .T.
119:             .ForeColor = RGB(0, 0, 0)
120:             .BackStyle = 0
121:             .AutoSize  = .F.
122:             .Visible   = .T.
123:         ENDWITH
124: 
125:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
126:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
127:             .Top       = 18
128:             .Left      = 10
129:             .Width     = 769
130:             .Height    = 46
131:             .Caption   = THIS.Caption
132:             .FontName  = "Tahoma"
133:             .FontSize  = 16
134:             .FontBold  = .T.
135:             .ForeColor = RGB(255, 255, 255)
136:             .BackStyle = 0
137:             .AutoSize  = .F.
138:             .Visible   = .T.
139:         ENDWITH
140: 
141:         *-- Container botoes CRUD (Grupo_Op no legado)
142:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
143:         WITH loc_oPagina.cnt_4c_Botoes
144:             .Top         = 0 + 29
145:             .Left        = 542
146:             .Width       = 390
147:             .Height      = 85
148:             .BackStyle = 0
149:             .BorderWidth = 0
150:             .Visible     = .T.
151:         ENDWITH
152: 
153:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
154:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
155:             .Caption         = "Incluir"
156:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
157:             .PicturePosition = 13
158:             .Top             = 5
159:             .Left            = 5
160:             .Width           = 75
161:             .Height          = 75
162:             .BackColor       = RGB(255, 255, 255)
163:             .ForeColor       = RGB(90, 90, 90)
164:             .FontName        = "Comic Sans MS"
165:             .FontSize        = 8
166:             .FontBold        = .T.
167:             .FontItalic      = .T.
168:             .Themes          = .F.
169:             .SpecialEffect   = 0
170:             .MousePointer    = 15
171:             .WordWrap        = .T.
172:             .AutoSize        = .F.
173:             .Visible         = .T.
174:         ENDWITH
175: 
176:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
177:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
178:             .Caption         = "Visualizar"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 80
183:             .Width           = 75
184:             .Height          = 75
185:             .BackColor       = RGB(255, 255, 255)
186:             .ForeColor       = RGB(90, 90, 90)
187:             .FontName        = "Comic Sans MS"
188:             .FontSize        = 8
189:             .FontBold        = .T.
190:             .FontItalic      = .T.
191:             .Themes          = .F.
192:             .SpecialEffect   = 0
193:             .MousePointer    = 15
194:             .WordWrap        = .T.
195:             .AutoSize        = .F.
196:             .Visible         = .T.
197:         ENDWITH
198: 
199:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
200:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
201:             .Caption         = "Alterar"
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
203:             .PicturePosition = 13
204:             .Top             = 5
205:             .Left            = 155
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
221: 
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
224:             .Caption         = "Excluir"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 230
229:             .Width           = 75
230:             .Height          = 75
231:             .BackColor       = RGB(255, 255, 255)
232:             .ForeColor       = RGB(90, 90, 90)
233:             .FontName        = "Comic Sans MS"
234:             .FontSize        = 8
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .WordWrap        = .T.
241:             .AutoSize        = .F.
242:             .Visible         = .T.
243:         ENDWITH
244: 
245:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
246:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
247:             .Caption         = "Buscar"
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
249:             .PicturePosition = 13
250:             .Top             = 5
251:             .Left            = 305
252:             .Width           = 75
253:             .Height          = 75
254:             .BackColor       = RGB(255, 255, 255)
255:             .ForeColor       = RGB(90, 90, 90)
256:             .FontName        = "Comic Sans MS"
257:             .FontSize        = 8
258:             .FontBold        = .T.
259:             .FontItalic      = .T.
260:             .Themes          = .F.
261:             .SpecialEffect   = 0
262:             .MousePointer    = 15

*-- Linhas 268 a 298:
268:         *-- Container Saida - padrao canonico (prevalece sobre PILAR 1)
269:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
270:         WITH loc_oPagina.cnt_4c_Saida
271:             .Top         = 29
272:             .Left        = 917
273:             .Width       = 90
274:             .Height      = 85
275:             .BackStyle = 1
276:             .BackColor = RGB(255, 255, 255)
277:             .BorderWidth = 0
278:             .Visible     = .T.
279:         ENDWITH
280: 
281:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
282:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
283:             .Caption         = "Encerrar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 5
288:             .Width           = 75
289:             .Height          = 75
290:             .BackColor       = RGB(255, 255, 255)
291:             .ForeColor       = RGB(90, 90, 90)
292:             .FontName        = "Comic Sans MS"
293:             .FontSize        = 8
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .MousePointer    = 15

*-- Linhas 304 a 313:
304:         *-- Grid de lista (nordems=Ordem 80px, cdescrs=Descricao 337px)
305:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
306:         WITH loc_oPagina.grd_4c_Lista
307:             .Top                = 88 + 29
308:             .Left               = 26
309:             .Width              = 890
310:             .Height             = 498
311:             .FontName           = "Verdana"
312:             .FontSize           = 8
313:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 330 a 350:
330:         WITH loc_oGrid
331:             .Column1.Width           = 80
332:             .Column1.Alignment       = 0
333:             .Column1.Header1.Caption = "Ordem"
334:             .Column2.Width           = 337
335:             .Column2.Alignment       = 0
336:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
337:         ENDWITH
338: 
339:         *-- BINDEVENTs para botoes (metodos PUBLIC para funcionar com BINDEVENT)
340:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
341:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
342:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
343:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
344:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
345:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
346: 
347:         THIS.TornarControlesVisiveis(loc_oPagina)
348:     ENDPROC
349: 
350:     *==========================================================================

*-- Linhas 359 a 429:
359:         *-- Container botoes acao (Grupo_Salva no legado)
360:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
361:         WITH loc_oPagina.cnt_4c_BotoesAcao
362:             .Top         = 4 + 29
363:             .Left        = 842
364:             .Width       = 160
365:             .Height      = 85
366:             .BackStyle = 1
367:             .BackColor = RGB(255, 255, 255)
368:             .BorderWidth = 0
369:             .Visible     = .T.
370:         ENDWITH
371: 
372:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
373:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
374:             .Caption         = "Confirmar"
375:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
376:             .PicturePosition = 13
377:             .Top             = 5
378:             .Left            = 5
379:             .Width           = 75
380:             .Height          = 75
381:             .BackColor       = RGB(255, 255, 255)
382:             .ForeColor       = RGB(90, 90, 90)
383:             .FontName        = "Comic Sans MS"
384:             .FontSize        = 8
385:             .FontBold        = .T.
386:             .FontItalic      = .T.
387:             .Themes          = .F.
388:             .SpecialEffect   = 0
389:             .MousePointer    = 15
390:             .WordWrap        = .T.
391:             .AutoSize        = .F.
392:             .Visible         = .T.
393:         ENDWITH
394: 
395:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
396:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
397:             .Caption         = "Encerrar"
398:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
399:             .PicturePosition = 13
400:             .Top             = 5
401:             .Left            = 80
402:             .Width           = 75
403:             .Height          = 75
404:             .BackColor       = RGB(255, 255, 255)
405:             .ForeColor       = RGB(90, 90, 90)
406:             .FontName        = "Comic Sans MS"
407:             .FontSize        = 8
408:             .FontBold        = .T.
409:             .FontItalic      = .T.
410:             .Themes          = .F.
411:             .SpecialEffect   = 0
412:             .MousePointer    = 15
413:             .WordWrap        = .T.
414:             .AutoSize        = .F.
415:             .Visible         = .T.
416:         ENDWITH
417: 
418:         *-- Label e TextBox: Ordem (Say1 / Get_ordem - nordems numeric 2,0)
419:         *-- Posicoes do original compensadas +29 (PageFrame.Top=-29)
420:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
421:         WITH loc_oPagina.lbl_4c_Label1
422:             .Caption   = "Ordem : "
423:             .Top       = 147 + 29
424:             .Left      = 200
425:             .Width     = 50
426:             .Height    = 17
427:             .FontName  = "Verdana"
428:             .FontSize  = 8
429:             .ForeColor = RGB(36, 84, 155)

*-- Linhas 435 a 459:
435:         loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
436:         WITH loc_oPagina.txt_4c_Ordem
437:             .Value     = 0
438:             .Top       = 144 + 29
439:             .Left      = 251
440:             .Width     = 24
441:             .Height    = 21
442:             .FontName  = "Tahoma"
443:             .FontSize  = 8
444:             .InputMask = "99"
445:             .Enabled   = .F.
446:             .Visible   = .T.
447:         ENDWITH
448: 
449:         *-- Label e TextBox: Descricao (Say2 / Get_descr - cdescrs char 20)
450:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
451:         WITH loc_oPagina.lbl_4c_Label2
452:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
453:             .Top       = 172 + 29
454:             .Left      = 183
455:             .Width     = 67
456:             .Height    = 17
457:             .FontName  = "Verdana"
458:             .FontSize  = 8
459:             .ForeColor = RGB(36, 84, 155)

*-- Linhas 465 a 486:
465:         loc_oPagina.AddObject("txt_4c_Descr", "TextBox")
466:         WITH loc_oPagina.txt_4c_Descr
467:             .Value     = ""
468:             .Top       = 169 + 29
469:             .Left      = 252
470:             .Width     = 149
471:             .Height    = 23
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .MaxLength = 20
475:             .Enabled   = .F.
476:             .Visible   = .T.
477:         ENDWITH
478: 
479:         *-- BINDEVENTs botoes Page2 (metodos PUBLIC para BINDEVENT)
480:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
481:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
482: 
483:         THIS.TornarControlesVisiveis(loc_oPagina)
484:     ENDPROC
485: 
486:     *==========================================================================

*-- Linhas 505 a 516:
505:                 WITH loc_oGrid
506:                     .Column1.Width           = 80
507:                     .Column1.Alignment       = 0
508:                     .Column1.Header1.Caption = "Ordem"
509:                     .Column2.Width           = 337
510:                     .Column2.Alignment       = 0
511:                     .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
512:                 ENDWITH
513: 
514:                 THIS.FormatarGridLista(loc_oGrid)
515:                 loc_lResultado = .T.
516:             ENDIF

*-- Linhas 603 a 612:
603: 
604:         *-- Botao Confirmar: desabilitado em modo VISUALIZAR
605:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
606:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
607:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
608:             ENDIF
609:         ENDIF
610:     ENDPROC
611: 
612:     *==========================================================================

*-- Linhas 638 a 662:
638: 
639:         IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
640:             WITH loc_oPg1.cnt_4c_Botoes
641:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
642:                     .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
643:                 ENDIF
644:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
645:                     .cmd_4c_Alterar.Enabled = loc_lTemRegistro
646:                 ENDIF
647:                 IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
648:                     .cmd_4c_Excluir.Enabled = loc_lTemRegistro
649:                 ENDIF
650:                 .Visible     = .T.
651:             ENDWITH
652:         ENDIF
653: 
654:         *-- Page2: ajustar Confirmar conforme modo (desabilitado em VISUALIZAR)
655:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
656:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
657:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
658:                     (THIS.this_cModoAtual != "VISUALIZAR")
659:             ENDIF
660:         ENDIF
661: 
662:         *-- Posicionar foco conforme modo (replica logica do legado)

*-- Linhas 671 a 680:
671:                 ENDIF
672:             CASE INLIST(THIS.this_cModoAtual, "VISUALIZAR")
673:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
674:                     IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
675:                         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.SetFocus()
676:                     ENDIF
677:                 ENDIF
678:         ENDCASE
679:     ENDPROC
680: 


### BO (C:\4c\projeto\app\classes\FTFBO.prg):
*==============================================================================
* FTFBO.prg - Business Object para Finalizadoras (Tef)
* Tabela: SigFiNz
* PK: nordems (numeric 2,0)
*==============================================================================

DEFINE CLASS FTFBO AS BusinessBase

    *-- Propriedades da tabela SigFiNz
    this_nOrdem    = 0    && nordems numeric(2,0) - PK
    this_cDescricao = ""  && cdescrs char(20)

    *==========================================================================
    * Init - Configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela    = "SigFiNz"
        THIS.this_cCampoChave = "nordems"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nOrdem)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nOrdem     = TratarNulo(nordems, "N")
            THIS.this_cDescricao = ALLTRIM(TratarNulo(cdescrs, "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Buscar - Lista registros (PUBLIC)
    *==========================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT nordems, cdescrs" + ;
                       " FROM SigFiNz" + ;
                       " ORDER BY nordems"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT nordems, cdescrs" + ;
                           " FROM SigFiNz" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY nordems"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiNz")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar Finalizadoras (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela PK (PUBLIC)
    *==========================================================================
    FUNCTION CarregarPorCodigo(par_nOrdem)
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT nordems, cdescrs" + ;
                       " FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(par_nOrdem)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Inserir - INSERT na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigFiNz (nordems, cdescrs)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nOrdem) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * Atualizar - UPDATE na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigFiNz" + ;
                       " SET cdescrs = " + EscaparSQL(THIS.this_cDescricao) + ;
                       " WHERE nordems = " + FormatarNumeroSQL(THIS.this_nOrdem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ExecutarExclusao - DELETE na tabela (PROTECTED)
    *==========================================================================
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(THIS.this_nOrdem)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir Finalizadora (Tef):" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * VerificarOrdemExistente - Valida unicidade do campo Ordem (PUBLIC)
    *==========================================================================
    FUNCTION VerificarOrdemExistente(par_nOrdem)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigFiNz" + ;
                       " WHERE nordems = " + FormatarNumeroSQL(par_nOrdem)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkOrdem")
                TABLEREVERT(.T., "cursor_4c_ChkOrdem")
                USE IN cursor_4c_ChkOrdem
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOrdem")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ChkOrdem") > 0
                SELECT cursor_4c_ChkOrdem
                loc_lExiste = (cursor_4c_ChkOrdem.Total > 0)
            ENDIF

            IF USED("cursor_4c_ChkOrdem")
                USE IN cursor_4c_ChkOrdem
            ENDIF
        CATCH TO loException
            MsgErro("Erro em FTFBO.VerificarOrdemExistente:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDFUNC

ENDDEFINE

