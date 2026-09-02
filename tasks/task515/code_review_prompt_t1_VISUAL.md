# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 185: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 206: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 228: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 250: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 272: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 307: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 392: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRss.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1115 linhas total):

*-- Linhas 50 a 58:
50:         loc_lSucesso = .F.
51: 
52:         TRY
53:             THIS.Caption = "Restri" + CHR(231) + CHR(227) + "o de Setores"
54: 
55:             THIS.this_oBusinessObject = CREATEOBJECT("RssBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
58:                 MsgErro("Erro ao criar RssBO.", "FormRss.InicializarForm")

*-- Linhas 80 a 95:
80: 
81:     *--------------------------------------------------------------------------
82:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
83:     * PageFrame.Top = -29 para ocultar abas; containers compensam com +29
84:     *--------------------------------------------------------------------------
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 29
93:             .Tabs      = .F.
94:             .Visible   = .T.
95:             .Page1.BackColor = RGB(53, 53, 53)

*-- Linhas 115 a 153:
115:         loc_cIcones = gc_4c_CaminhoIcones
116: 
117:         *-- Container cabecalho escuro com titulo
118:         *-- cntSombra.Top=2 no legado + compensacao +29 = Top=31
119:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
120:         WITH loc_oPagina.cnt_4c_Cabecalho
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128: 
129:             .AddObject("lbl_4c_Sombra", "Label")
130:             WITH .lbl_4c_Sombra
131:                 .Caption   = "Restri" + CHR(231) + CHR(227) + "o de Setores"
132:                 .Top       = 15
133:                 .Left      = 10
134:                 .Width     = THIS.Width
135:                 .Height    = 40
136:                 .FontName  = "Tahoma"
137:                 .FontSize  = 16
138:                 .FontBold  = .T.
139:                 .ForeColor = RGB(0, 0, 0)
140:                 .BackStyle = 0
141:                 .Visible   = .T.
142:             ENDWITH
143: 
144:             .AddObject("lbl_4c_Titulo", "Label")
145:             WITH .lbl_4c_Titulo
146:                 .Caption   = "Restri" + CHR(231) + CHR(227) + "o de Setores"
147:                 .Top       = 18
148:                 .Left      = 10
149:                 .Width     = THIS.Width
150:                 .Height    = 46
151:                 .FontName  = "Tahoma"
152:                 .FontSize  = 16
153:                 .FontBold  = .T.

*-- Linhas 162 a 313:
162:         *-- Top=0 no legado + compensacao +29 = Top=29; usamos 28 conforme framework
163:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
164:         WITH loc_oPagina.cnt_4c_Botoes
165:             .Top         = 28
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackStyle   = 1
170:             .BackColor   = RGB(53, 53, 53)
171:             .BorderWidth = 0
172:             .Visible     = .T.
173: 
174:             .AddObject("cmd_4c_Incluir", "CommandButton")
175:             WITH .cmd_4c_Incluir
176:                 .Caption         = "Incluir"
177:                 .Picture         = loc_cIcones + "cadastro_inserir_26.jpg"
178:                 .PicturePosition = 13
179:                 .Top             = 5
180:                 .Left            =  542
181:                 .Width           = 75
182:                 .Height          = 75
183:                 .BackColor       = RGB(255, 255, 255)
184:                 .ForeColor       = RGB(90, 90, 90)
185:                 .FontName        = "Comic Sans MS"
186:                 .FontBold        = .T.
187:                 .FontItalic      = .T.
188:                 .FontSize        = 8
189:                 .SpecialEffect   = 0
190:                 .MousePointer    = 15
191:                 .WordWrap        = .T.
192:                 .Visible         = .T.
193:             ENDWITH
194: 
195:             .AddObject("cmd_4c_Visualizar", "CommandButton")
196:             WITH .cmd_4c_Visualizar
197:                 .Caption         = "Visualizar"
198:                 .Picture         = loc_cIcones + "cadastro_vizualizar_60.jpg"
199:                 .PicturePosition = 13
200:                 .Top             = 5
201:                 .Left            =  542
202:                 .Width           = 75
203:                 .Height          = 75
204:                 .BackColor       = RGB(255, 255, 255)
205:                 .ForeColor       = RGB(90, 90, 90)
206:                 .FontName        = "Comic Sans MS"
207:                 .FontBold        = .T.
208:                 .FontItalic      = .T.
209:                 .FontSize        = 8
210:                 .Themes          = .F.
211:                 .SpecialEffect   = 0
212:                 .MousePointer    = 15
213:                 .WordWrap        = .T.
214:                 .Visible         = .T.
215:             ENDWITH
216: 
217:             .AddObject("cmd_4c_Alterar", "CommandButton")
218:             WITH .cmd_4c_Alterar
219:                 .Caption         = "Alterar"
220:                 .Picture         = loc_cIcones + "cadastro_alterar_60.jpg"
221:                 .PicturePosition = 13
222:                 .Top             = 5
223:                 .Left            =  542
224:                 .Width           = 75
225:                 .Height          = 75
226:                 .BackColor       = RGB(255, 255, 255)
227:                 .ForeColor       = RGB(90, 90, 90)
228:                 .FontName        = "Comic Sans MS"
229:                 .FontBold        = .T.
230:                 .FontItalic      = .T.
231:                 .FontSize        = 8
232:                 .Themes          = .F.
233:                 .SpecialEffect   = 0
234:                 .MousePointer    = 15
235:                 .WordWrap        = .T.
236:                 .Visible         = .T.
237:             ENDWITH
238: 
239:             .AddObject("cmd_4c_Excluir", "CommandButton")
240:             WITH .cmd_4c_Excluir
241:                 .Caption         = "Excluir"
242:                 .Picture         = loc_cIcones + "cadastro_excluir_60.jpg"
243:                 .PicturePosition = 13
244:                 .Top             = 5
245:                 .Left            =  542
246:                 .Width           = 75
247:                 .Height          = 75
248:                 .BackColor       = RGB(255, 255, 255)
249:                 .ForeColor       = RGB(90, 90, 90)
250:                 .FontName        = "Comic Sans MS"
251:                 .FontBold        = .T.
252:                 .FontItalic      = .T.
253:                 .FontSize        = 8
254:                 .Themes          = .F.
255:                 .SpecialEffect   = 0
256:                 .MousePointer    = 15
257:                 .WordWrap        = .T.
258:                 .Visible         = .T.
259:             ENDWITH
260: 
261:             .AddObject("cmd_4c_Buscar", "CommandButton")
262:             WITH .cmd_4c_Buscar
263:                 .Caption         = "Buscar"
264:                 .Picture         = loc_cIcones + "cadastro_procurar_60.jpg"
265:                 .PicturePosition = 13
266:                 .Top             = 5
267:                 .Left            =  542
268:                 .Width           = 75
269:                 .Height          = 75
270:                 .BackColor       = RGB(255, 255, 255)
271:                 .ForeColor       = RGB(90, 90, 90)
272:                 .FontName        = "Comic Sans MS"
273:                 .FontBold        = .T.
274:                 .FontItalic      = .T.
275:                 .FontSize        = 8
276:                 .Themes          = .F.
277:                 .SpecialEffect   = 0
278:                 .MousePointer    = 15
279:                 .WordWrap        = .T.
280:                 .Visible         = .T.
281:             ENDWITH
282:         ENDWITH
283: 
284:         *-- Container saida - padrao canonico CLAUDE.md regra #10
285:         *-- Left=917, Width=90; cmd_4c_Encerrar Width=75
286:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
287:         WITH loc_oPagina.cnt_4c_Saida
288:             .Top         = 28
289:             .Left        = 917
290:             .Width       = 90
291:             .Height      = 85
292:             .BackStyle   = 0
293:             .BorderWidth = 0
294:             .Visible     = .T.
295: 
296:             .AddObject("cmd_4c_Encerrar", "CommandButton")
297:             WITH .cmd_4c_Encerrar
298:                 .Caption         = "Encerrar"
299:                 .Picture         = loc_cIcones + "cadastro_sair_60.jpg"
300:                 .PicturePosition = 13
301:                 .Top             = 5
302:                 .Left            = 917
303:                 .Width           = 90
304:                 .Height          = 75
305:                 .BackColor       = RGB(255, 255, 255)
306:                 .ForeColor       = RGB(90, 90, 90)
307:                 .FontName        = "Comic Sans MS"
308:                 .FontBold        = .T.
309:                 .FontItalic      = .T.
310:                 .FontSize        = 8
311:                 .SpecialEffect   = 0
312:                 .MousePointer    = 15
313:                 .WordWrap        = .T.

*-- Linhas 320 a 329:
320:         *-- Top=88+29=117 canonico; Width=890 (nao sobrepor cnt_4c_Saida)
321:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
322:         WITH loc_oPagina.grd_4c_Lista
323:             .Top                = 117
324:             .Left               = 12
325:             .Width              = 890
326:             .Height             = 450
327:             .ColumnCount        = 2
328:             .FontName           = "Verdana"
329:             .FontSize           = 8

*-- Linhas 345 a 456:
345:         ENDWITH
346: 
347:         *-- BINDEVENT para todos os botoes (metodos devem ser PUBLIC)
348:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
349:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
350:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
351:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
352:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
353:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
354: 
355:         THIS.TornarControlesVisiveis(loc_oPagina)
356:     ENDPROC
357: 
358:     *--------------------------------------------------------------------------
359:     * ConfigurarPaginaDados - Page2: botoes Confirmar/Cancelar + campos Origem
360:     * Fase 5: lbl_4c_Say2, txt_4c_Origem, txt_4c_Dorigem com lookup SigCdGcr
361:     *--------------------------------------------------------------------------
362:     PROTECTED PROCEDURE ConfigurarPaginaDados()
363:         LOCAL loc_oPagina
364:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
365: 
366:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
367:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
368: 
369:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva do legado)
370:         *-- Top=4+29=33 (compensacao), Left=842, Width=160
371:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
372:         WITH loc_oPagina.cnt_4c_BotoesAcao
373:             .Top         = 33
374:             .Left        = 842
375:             .Width       = 160
376:             .Height      = 85
377:             .BackStyle   = 0
378:             .BorderWidth = 0
379:             .Visible     = .T.
380: 
381:             .AddObject("cmd_4c_Confirmar", "CommandButton")
382:             WITH .cmd_4c_Confirmar
383:                 .Caption         = "Confirmar"
384:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
385:                 .PicturePosition = 13
386:                 .Top             = 5
387:                 .Left            = 5
388:                 .Width           = 75
389:                 .Height          = 75
390:                 .BackColor       = RGB(255, 255, 255)
391:                 .ForeColor       = RGB(90, 90, 90)
392:                 .FontName        = "Comic Sans MS"
393:                 .FontBold        = .T.
394:                 .FontItalic      = .T.
395:                 .FontSize        = 8
396:                 .SpecialEffect   = 0
397:                 .MousePointer    = 15
398:                 .WordWrap        = .T.
399:                 .Visible         = .T.
400:             ENDWITH
401: 
402:             .AddObject("cmd_4c_Cancelar", "CommandButton")
403:             WITH .cmd_4c_Cancelar
404:                 .Caption         = "Encerrar"
405:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
406:                 .PicturePosition = 13
407:                 .Top             = 5
408:                 .Left            = 80
409:                 .Width           = 75
410:                 .Height          = 75
411:                 .BackColor       = RGB(255, 255, 255)
412:                 .ForeColor       = RGB(90, 90, 90)
413:                 .FontName        = "Comic Sans MS"
414:                 .FontBold        = .T.
415:                 .FontItalic      = .T.
416:                 .FontSize        = 8
417:                 .Themes          = .F.
418:                 .SpecialEffect   = 0
419:                 .MousePointer    = 15
420:                 .WordWrap        = .T.
421:                 .Visible         = .T.
422:             ENDWITH
423:         ENDWITH
424: 
425:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
426:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
427: 
428:         *-- Label e TextBoxes para Grupo Origem (Say2, Get_Origem, Get_Dorigem)
429:         *-- Say2 original: Top=140, Left=181 -> compensado Top=169
430:         *-- Get_Origem original: Top=138, Left=232, W=80, H=23 -> Top=167
431:         *-- Get_Dorigem original: Top=138, Left=314, W=193, H=23 -> Top=167
432: 
433:         loc_oPagina.AddObject("lbl_4c_Say2", "Label")
434:         WITH loc_oPagina.lbl_4c_Say2
435:             .Caption   = "Origem : "
436:             .Top       = 169
437:             .Left      = 181
438:             .Width     = 50
439:             .Height    = 17
440:             .FontName  = "Tahoma"
441:             .FontSize  = 8
442:             .BackStyle = 0
443:             .ForeColor = RGB(255, 255, 255)
444:             .Visible   = .T.
445:         ENDWITH
446: 
447:         loc_oPagina.AddObject("txt_4c_Origem", "TextBox")
448:         WITH loc_oPagina.txt_4c_Origem
449:             .Value     = ""
450:             .Top       = 167
451:             .Left      = 232
452:             .Width     = 80
453:             .Height    = 23
454:             .MaxLength = 15
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8

*-- Linhas 463 a 472:
463:         loc_oPagina.AddObject("txt_4c_Dorigem", "TextBox")
464:         WITH loc_oPagina.txt_4c_Dorigem
465:             .Value     = ""
466:             .Top       = 167
467:             .Left      = 314
468:             .Width     = 193
469:             .Height    = 23
470:             .ReadOnly  = .T.
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8

*-- Linhas 484 a 510:
484:         *-- Get_Destino original: Top=174, Left=232, W=80, H=23 -> Top=203
485:         *-- Get_ddestino original: Top=174, Left=314, W=193, H=23 -> Top=203
486: 
487:         loc_oPagina.AddObject("lbl_4c_Say1", "Label")
488:         WITH loc_oPagina.lbl_4c_Say1
489:             .Caption   = "Destino : "
490:             .Top       = 205
491:             .Left      = 179
492:             .Width     = 52
493:             .Height    = 17
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .BackStyle = 0
497:             .ForeColor = RGB(255, 255, 255)
498:             .Visible   = .T.
499:         ENDWITH
500: 
501:         loc_oPagina.AddObject("txt_4c_Destino", "TextBox")
502:         WITH loc_oPagina.txt_4c_Destino
503:             .Value     = ""
504:             .Top       = 203
505:             .Left      = 232
506:             .Width     = 80
507:             .Height    = 23
508:             .MaxLength = 15
509:             .FontName  = "Tahoma"
510:             .FontSize  = 8

*-- Linhas 517 a 526:
517:         loc_oPagina.AddObject("txt_4c_Ddestino", "TextBox")
518:         WITH loc_oPagina.txt_4c_Ddestino
519:             .Value     = ""
520:             .Top       = 203
521:             .Left      = 314
522:             .Width     = 193
523:             .Height    = 23
524:             .ReadOnly  = .T.
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8

*-- Linhas 557 a 566:
557:                     loc_oGrid.Column2.ControlSource    = "cursor_4c_Dados.grupods"
558: 
559:                     *-- OBRIGATORIO: Redefinir cabecalhos apos RecordSource (VFP9 reseta)
560:                     loc_oGrid.Column1.Header1.Caption  = "Grupo Origem"
561:                     loc_oGrid.Column2.Header1.Caption  = "Grupo Destino"
562: 
563:                     THIS.FormatarGridLista(loc_oGrid)
564:                     loc_lResultado = .T.
565:                 ENDIF
566:             ENDIF

*-- Linhas 695 a 707:
695:         LOCAL loc_oCnt
696:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "cnt_4c_BotoesAcao", 5)
697:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
698:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
699:                 loc_oCnt.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
700:             ENDIF
701:             IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
702:                 loc_oCnt.cmd_4c_Cancelar.Enabled = .T.
703:             ENDIF
704:         ENDIF
705:     ENDPROC
706: 
707:     *==========================================================================


### BO (C:\4c\projeto\app\classes\RssBO.prg):
*==============================================================================
* RssBO.prg - Business Object para Restricao de Setores (SigCdRps)
* Tabela principal: SigCdRps
* Chave primaria : cidchaves (char 20, gerada por fUniqueIds())
*==============================================================================

DEFINE CLASS RssBO AS BusinessBase

    *-- Propriedades mapeadas para colunas de SigCdRps
    this_cCidChaves = ""        && cidchaves char(20) - PK
    this_cGrupoos   = ""        && grupoos   char(10) - Grupo Origem (FK SigCdGcr.codigos)
    this_cGrupods   = ""        && grupods   char(10) - Grupo Destino (FK SigCdGcr.codigos)
    this_cUsuars    = ""        && usuars    char(10) - usuario
    this_dDatars    = {}        && datars    datetime - data/hora do registro

    *-- Propriedades auxiliares para exibicao (lookup SigCdGcr.descrs)
    this_cDescOrigem  = ""      && descricao do Grupo Origem
    this_cDescDestino = ""      && descricao do Grupo Destino

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRps"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loException
            MsgErro(loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *==========================================================================
    * LimparDados - Limpa todas as propriedades da entidade
    *==========================================================================
    PROTECTED PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cCidChaves    = ""
        THIS.this_cGrupoos      = ""
        THIS.this_cGrupods      = ""
        THIS.this_cUsuars       = ""
        THIS.this_dDatars       = {}
        THIS.this_cDescOrigem   = ""
        THIS.this_cDescDestino  = ""
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves   = TratarNulo(cidchaves, "C")
                THIS.this_cGrupoos     = TratarNulo(grupoos,   "C")
                THIS.this_cGrupods     = TratarNulo(grupods,   "C")
                THIS.this_cUsuars      = TratarNulo(usuars,    "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar do cursor:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida dados antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cGrupoos))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Origem.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cGrupods))
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo Destino.")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarDuplicidade()
                MsgAviso("Grupo Origem , Grupo Destino j" + CHR(225) + " Cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarDuplicidade - Verifica se par (grupoos + grupods) ja existe
    *==========================================================================
    PROCEDURE VerificarDuplicidade()
        LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT cidchaves FROM SigCdRps" + ;
                " WHERE grupoos = " + EscaparSQL(THIS.this_cGrupoos) + ;
                " AND   grupods = " + EscaparSQL(THIS.this_cGrupods)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                SELECT cursor_4c_ChkDup
                loc_lDuplicado = !EOF("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "RssBO.VerificarDuplicidade")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *==========================================================================
    * GerarChaveUnica - Gera cidchaves unico via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT CAST(NEWID() AS varchar(36)) AS nova_chave", ;
                "cursor_4c_NovaChave")
            IF loc_nResult >= 0 AND USED("cursor_4c_NovaChave")
                SELECT cursor_4c_NovaChave
                loc_cChave = LEFT(ALLTRIM(cursor_4c_NovaChave.nova_chave), 20)
                USE IN cursor_4c_NovaChave
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "RssBO.GerarChaveUnica")
        ENDTRY

        RETURN loc_cChave
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cCidChaves = THIS.GerarChaveUnica()
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gerar chave para o registro.", "RssBO.Inserir")
            ELSE
                loc_cSQL = "INSERT INTO SigCdRps" + ;
                    " (cidchaves, grupoos, grupods, datars, usuars)" + ;
                    " VALUES (" + ;
                    EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                    EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                    EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                    "GETDATE(), " + ;
                    EscaparSQL(gc_4c_UsuarioLogado)  + ;
                    ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir restri" + CHR(231) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir:" + CHR(13) + loc_oErro.Message, "RssBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdRps SET" + ;
                " grupoos = " + EscaparSQL(THIS.this_cGrupoos)   + ", " + ;
                " grupods = " + EscaparSQL(THIS.this_cGrupods)   + ", " + ;
                " datars  = GETDATE(), " + ;
                " usuars  = " + EscaparSQL(gc_4c_UsuarioLogado)  + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar:" + CHR(13) + loc_oErro.Message, "RssBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdRps
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdRps WHERE cidchaves = " + ;
                EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir restri" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao excluir:" + CHR(13) + loc_oErro.Message, "RssBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Busca todos os registros para o grid da lista
    * Colunas do grid: grupoos (Grupo Origem), grupods (Grupo Destino)
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados ( ;
                        grupoos   C(10), ;
                        grupods   C(10), ;
                        cidchaves C(20)  ;
                    )
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT grupoos, grupods, cidchaves" + ;
                    " FROM SigCdRps"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY grupoos, grupods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao buscar restri" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao buscar:" + CHR(13) + loc_oErro.Message, "RssBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, grupoos, grupods, usuars, datars" + ;
                " FROM SigCdRps WHERE cidchaves = " + EscaparSQL(par_cChave)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega")
                SELECT cursor_4c_Carrega
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                USE IN cursor_4c_Carrega
            ELSE
                MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar por chave:" + CHR(13) + loc_oErro.Message, "RssBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarDescricaoGrupo - Busca descricao de um grupo em SigCdGcr
    * Retorna a descricao ou string vazia se nao encontrado
    *==========================================================================
    PROCEDURE BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescrs
        loc_cDescrs = ""

        TRY
            IF !EMPTY(ALLTRIM(par_cCodigo))
                loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + ;
                    EscaparSQL(par_cCodigo)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGcr")
                IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaGcr")
                    SELECT cursor_4c_BuscaGcr
                    IF !EOF("cursor_4c_BuscaGcr")
                        loc_cDescrs = ALLTRIM(cursor_4c_BuscaGcr.Descrs)
                    ENDIF
                    USE IN cursor_4c_BuscaGcr
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o do grupo:" + ;
                CHR(13) + loc_oErro.Message, "RssBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescrs
    ENDPROC

ENDDEFINE

