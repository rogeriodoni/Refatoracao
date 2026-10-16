# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (7)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.ContarOcorrenciasPreenchidas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DescGrupoPodeDigitar()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DescContaPodeDigitar()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'Grupos' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ocorrência, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Contas' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ocorrência, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Ocorrência, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2263 linhas total):

*-- Linhas 26 a 160:
26:     this_cContaAtual     = ""
27:     this_cGruContasAtual = ""
28: 
29:     *-- Guarda de reentrancia dos lookups (regra #37/#47): FormBuscaAuxiliar eh
30:     *-- MODAL, tira o foco e redispara o proprio LostFocus - sem a flag abrem
31:     *-- DOIS dialogos. Liberada em wrapper fino, imune a RETURN antecipado.
32:     this_lEmLookup       = .F.
33: 
34:     *--------------------------------------------------------------------------
35:     * Init - DODEFAULT() ja chama InicializarForm() via FormBase.Init()
36:     *--------------------------------------------------------------------------
37:     PROCEDURE Init()
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *--------------------------------------------------------------------------
42:     * InicializarForm - Configuracao completa do formulario
43:     *--------------------------------------------------------------------------
44:     PROTECTED PROCEDURE InicializarForm()
45:         LOCAL loc_lSucesso
46:         loc_lSucesso = .F.
47: 
48:         TRY
49:             *-- Criar cursor local para lista de ocorrencias (equivalente ao csSigClLan do legado)
50:             IF USED("cursor_4c_OcoLocal")
51:                 USE IN cursor_4c_OcoLocal
52:             ENDIF
53:             SET NULL ON
54:             CREATE CURSOR cursor_4c_OcoLocal (Grupos C(10), Contas C(10), Cocos C(2), descs C(30))
55:             SET NULL OFF
56:             INDEX ON Cocos TAG Cocos
57: 
58:             THIS.this_oBusinessObject = CREATEOBJECT("SIGPRLNCBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MostrarErro("Erro ao criar SIGPRLNCBO", "Erro Cr" + CHR(237) + "tico")
62:             ELSE
63:                 THIS.Caption = "Cadastro de Lan" + CHR(231) + "amentos"
64: 
65:                 THIS.ConfigurarPageFrame()
66:                 THIS.ConfigurarPaginaLista()
67:                 THIS.ConfigurarPaginaDados()
68: 
69:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
70: 
71:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
72:                     IF !THIS.CarregarLista()
73:                         *-- Falha ao carregar nao impede abertura do formulario
74:                     ENDIF
75:                 ENDIF
76: 
77:                 THIS.pgf_4c_Paginas.Visible    = .T.
78:                 THIS.pgf_4c_Paginas.ActivePage = 1
79:                 THIS.this_cModoAtual           = "LISTA"
80:                 loc_lSucesso = .T.
81:             ENDIF
82: 
83:         CATCH TO loException
84:             MostrarErro("Erro ao inicializar FormSIGPRLNC:" + CHR(13) + ;
85:                         "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
86:                         loException.Message, "Erro")
87:             loc_lSucesso = .F.
88:         ENDTRY
89: 
90:         RETURN loc_lSucesso
91:     ENDPROC
92: 
93:     *--------------------------------------------------------------------------
94:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
95:     *--------------------------------------------------------------------------
96:     PROTECTED PROCEDURE ConfigurarPageFrame()
97:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
98:         WITH THIS.pgf_4c_Paginas
99:             .Top        = -29
100:             .Left       = 0
101:             .Width      = 1003
102:             .Height     = 629
103:             .PageCount  = 2
104:             .Tabs       = .F.
105:             .Visible    = .T.
106: 
107:             .Page1.Caption   = "Lista"
108:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:             .Page1.BackColor = RGB(255, 255, 255)
110: 
111:             .Page2.Caption   = "Dados"
112:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113:             .Page2.BackColor = RGB(255, 255, 255)
114:         ENDWITH
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de lancamentos
119:     *--------------------------------------------------------------------------
120:     PROTECTED PROCEDURE ConfigurarPaginaLista()
121:         LOCAL loc_oPagina
122:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
123: 
124:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125: 
126:         *-- Container cabecalho escuro (cntSombra: Top=2+29=31)
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BackStyle   = 1
135:             .BorderWidth = 0
136:             .Visible     = .T.
137:         ENDWITH
138: 
139:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
140:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
141:             .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
142:             .Top       = 15
143:             .Left      = 10
144:             .Width     = THIS.Width
145:             .Height    = 40
146:             .AutoSize  = .F.
147:             .FontName  = "Tahoma"
148:             .FontSize  = 16
149:             .FontBold  = .T.
150:             .BackStyle = 0
151:             .ForeColor = RGB(0, 0, 0)
152:             .Visible   = .T.
153:         ENDWITH
154: 
155:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
156:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
157:             .Caption   = "Cadastro de Lan" + CHR(231) + "amentos"
158:             .Top       = 18
159:             .Left      = 10
160:             .Width     = THIS.Width

*-- Linhas 201 a 407:
201:             .WordWrap        = .T.
202:             .Visible         = .T.
203:         ENDWITH
204:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
205: 
206:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .BackColor       = RGB(255, 255, 255)
216:             .ForeColor       = RGB(90, 90, 90)
217:             .FontName        = "Tahoma"
218:             .FontSize        = 8
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .Themes          = .F.
222:             .SpecialEffect   = 0
223:             .MousePointer    = 15
224:             .WordWrap        = .T.
225:             .Visible         = .T.
226:         ENDWITH
227:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
228: 
229:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
230:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
231:             .Caption         = "Alterar"
232:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
233:             .PicturePosition = 13
234:             .Top             = 5
235:             .Left            = 155
236:             .Width           = 75
237:             .Height          = 75
238:             .BackColor       = RGB(255, 255, 255)
239:             .ForeColor       = RGB(90, 90, 90)
240:             .FontName        = "Tahoma"
241:             .FontSize        = 8
242:             .FontBold        = .T.
243:             .FontItalic      = .T.
244:             .Themes          = .F.
245:             .SpecialEffect   = 0
246:             .MousePointer    = 15
247:             .WordWrap        = .T.
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
251: 
252:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
253:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
254:             .Caption         = "Excluir"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
256:             .PicturePosition = 13
257:             .Top             = 5
258:             .Left            = 230
259:             .Width           = 75
260:             .Height          = 75
261:             .BackColor       = RGB(255, 255, 255)
262:             .ForeColor       = RGB(90, 90, 90)
263:             .FontName        = "Tahoma"
264:             .FontSize        = 8
265:             .FontBold        = .T.
266:             .FontItalic      = .T.
267:             .Themes          = .F.
268:             .SpecialEffect   = 0
269:             .MousePointer    = 15
270:             .WordWrap        = .T.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
274: 
275:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
276:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
277:             .Caption         = "Buscar"
278:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
279:             .PicturePosition = 13
280:             .Top             = 5
281:             .Left            = 305
282:             .Width           = 75
283:             .Height          = 75
284:             .BackColor       = RGB(255, 255, 255)
285:             .ForeColor       = RGB(90, 90, 90)
286:             .FontName        = "Tahoma"
287:             .FontSize        = 8
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .Themes          = .F.
291:             .SpecialEffect   = 0
292:             .MousePointer    = 15
293:             .WordWrap        = .T.
294:             .Visible         = .T.
295:         ENDWITH
296:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
297: 
298:         *-- Container saida canonico (Left=917, Width=90, cmd_4c_Encerrar 75x75)
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
310:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
311:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
312:             .Caption         = "Encerrar"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
314:             .PicturePosition = 13
315:             .Top             = 5
316:             .Left            = 5
317:             .Width           = 75
318:             .Height          = 75
319:             .BackColor       = RGB(255, 255, 255)
320:             .ForeColor       = RGB(90, 90, 90)
321:             .FontName        = "Tahoma"
322:             .FontSize        = 8
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .Themes          = .F.
326:             .SpecialEffect   = 0
327:             .MousePointer    = 15
328:             .WordWrap        = .T.
329:             .Visible         = .T.
330:         ENDWITH
331:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de lancamentos: Grupos/Contas distintos de SigClLan
334:         *-- Geometria transcrita dos overrides do SCX legado (Pagina.Lista.Grade):
335:         *-- Top=101 / Left=29 / Width=940 / Height=480; Top recebe +29 da
336:         *-- compensacao do PageFrame (pgf_4c_Paginas.Top = -29) -> 101+29 = 130.
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         WITH loc_oPagina.grd_4c_Lista
339:             .Top                = 130
340:             .Left               = 29
341:             .Width              = 940
342:             .Height             = 480
343:             .ColumnCount        = 3
344:             .FontName           = "Verdana"
345:             .FontSize           = 8
346:             .ForeColor          = RGB(90, 90, 90)
347:             .BackColor          = RGB(255, 255, 255)
348:             .GridLineColor      = RGB(238, 238, 238)
349:             .HighlightBackColor = RGB(255, 255, 255)
350:             .HighlightForeColor = RGB(15, 41, 104)
351:             .HighlightStyle     = 2
352:             .DeleteMark         = .F.
353:             .RecordMark         = .F.
354:             .RowHeight          = 16
355:             .ScrollBars         = 2
356:             .GridLines          = 3
357:             .Visible            = .T.
358:         ENDWITH
359: 
360:         THIS.TornarControlesVisiveis(loc_oPagina)
361:     ENDPROC
362: 
363:     *--------------------------------------------------------------------------
364:     * ConfigurarPaginaDados - Page2: campos de identificacao (Grupo/Conta) e botoes
365:     * Fase 5/8: Container botoes + labels/textboxes de Grupo e Conta
366:     *--------------------------------------------------------------------------
367:     PROTECTED PROCEDURE ConfigurarPaginaDados()
368:         LOCAL loc_oPagina
369:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
370: 
371:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
372:         *-- Cabecalho cinza (identico ao da pagina Lista) - Erro152
373:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
374:         WITH loc_oPagina.cnt_4c_Cabecalho
375:             .Top           = 29
376:             .Left          = 0
377:             .Width         = THIS.Width
378:             .Height        = 80
379:             .BackColor     = RGB(100, 100, 100)
380:             .BorderWidth   = 0
381:             .SpecialEffect = 0
382:             .Visible       = .T.
383: 
384:             .AddObject("lbl_4c_Sombra", "Label")
385:             WITH .lbl_4c_Sombra
386:                 .Caption   = THIS.Caption
387:                 .Top       = 15
388:                 .Left      = 10
389:                 .Width     = THIS.Width
390:                 .Height    = 40
391:                 .FontName  = "Tahoma"
392:                 .FontSize  = 16
393:                 .FontBold  = .T.
394:                 .ForeColor = RGB(0, 0, 0)
395:                 .BackStyle = 0
396:                 .AutoSize  = .F.
397:                 .Visible   = .T.
398:             ENDWITH
399: 
400:             .AddObject("lbl_4c_Titulo", "Label")
401:             WITH .lbl_4c_Titulo
402:                 .Caption   = THIS.Caption
403:                 .Top       = 18
404:                 .Left      = 10
405:                 .Width     = THIS.Width
406:                 .Height    = 46
407:                 .FontName  = "Tahoma"

*-- Linhas 454 a 523:
454:             .WordWrap        = .T.
455:             .Visible         = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
458: 
459:         *-- Botao Cancelar (Grupo_Salva.Cancelar: Left=80, Top=5)
460:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
461:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
462:             *-- Grupo_Salva.Cancelar do legado - "Encerrar" eh o botao de SAIDA da
463:             *-- pagina Lista (cmd_4c_Encerrar/regra #10), nao este.
464:             .Caption         = "Encerrar"
465:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
466:             .PicturePosition = 13
467:             .Top             = 5
468:             .Left            = 80
469:             .Width           = 75
470:             .Height          = 75
471:             .BackColor       = RGB(255, 255, 255)
472:             .ForeColor       = RGB(90, 90, 90)
473:             .FontName        = "Tahoma"
474:             .FontSize        = 8
475:             .FontBold        = .T.
476:             .FontItalic      = .T.
477:             .Themes          = .F.
478:             .SpecialEffect   = 0
479:             .MousePointer    = 15
480:             .WordWrap        = .T.
481:             .Visible         = .T.
482:         ENDWITH
483:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
484: 
485:         *-- Label "Grupo : " (Say2: Top=130+29=159, Left=257, TabIndex=1)
486:         *-- Say da classe 'say' eh AutoSize/esquerda: o dump nao declara Width nem
487:         *-- Alignment, entao Alignment fica 0 (regra #23) - NAO inventar Alignment=1.
488:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
489:         WITH loc_oPagina.lbl_4c_Label2
490:             .Caption   = "Grupo : "
491:             .Top       = 159
492:             .Left      = 257
493:             .Width     = 80
494:             .Height    = 18
495:             .AutoSize  = .F.
496:             .Alignment = 0
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .FontBold  = .F.
500:             .BackStyle = 0
501:             .ForeColor = RGB(90, 90, 90)
502:             .TabIndex  = 1
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         *-- TextBox Grupo (Get_Grupos: Top=127+29=156, Left=300, Width=80, TabIndex=2)
507:         *-- Format="K" transcrito do dump (regra #49). InputMask="" no dump eh
508:         *-- override VAZIO do Form Designer - NAO transcrever.
509:         *-- MaxLength vem da COLUNA do schema (SigClLan.grupos char(10)), nunca
510:         *-- do Width em pixels (regra #19).
511:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
512:         WITH loc_oPagina.txt_4c_Grupo
513:             .Value         = ""
514:             .Top           = 156
515:             .Left          = 300
516:             .Width         = 80
517:             .Height        = 23
518:             .FontName      = "Tahoma"
519:             .FontSize      = 8
520:             .ForeColor     = RGB(0, 0, 0)
521:             .BorderColor   = RGB(100, 100, 100)
522:             .SpecialEffect = 1
523:             .Format        = "K"

*-- Linhas 529 a 727:
529:         *-- Ligado a "KeyPress" (como estava) o handler so rodava com Enter/Tab e
530:         *-- sair com o MOUSE nunca validava: a descricao ficava vazia e o codigo
531:         *-- invalido passava. Evento certo eh LostFocus (regra #47).
532:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "LostFocus", THIS, "ValidarGrupoLostFocus")
533:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
534:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
535:         *-- O When legado eh reavaliado a CADA chegada de foco: esvaziar o codigo
536:         *-- tem de REABRIR o campo de descricao, e preenche-lo tem de fecha-lo.
537:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "InteractiveChange", THIS, "AtualizarCamposDescricao")
538: 
539:         *-- TextBox Descricao do Grupo (Get_Desc_Gru: Top=127+29=156, Left=382, Width=360, TabIndex=3)
540:         *-- MaxLength = SigCdGcr.descrs char(40)
541:         loc_oPagina.AddObject("txt_4c_Desc_Gru", "TextBox")
542:         WITH loc_oPagina.txt_4c_Desc_Gru
543:             .Value         = ""
544:             .Top           = 156
545:             .Left          = 382
546:             .Width         = 360
547:             .Height        = 23
548:             .FontName      = "Tahoma"
549:             .FontSize      = 8
550:             .ForeColor     = RGB(0, 0, 0)
551:             .BorderColor   = RGB(100, 100, 100)
552:             .SpecialEffect = 1
553:             .Format        = "K"
554:             .MaxLength     = 40
555:             .TabIndex      = 3
556:             .ReadOnly      = .T.     && estado INICIAL (modo LISTA) - ver AtualizarCamposDescricao
557:             .Visible       = .T.
558:         ENDWITH
559:         *-- O legado NAO deixa a descricao travada para sempre: o Get_Desc_Gru tem
560:         *-- When = IsEmpty(get_grupos.value) AND Inlist(pcEscolha, "PROCURAR") e um
561:         *-- Valid proprio que chama fAcessoContab(...) - ou seja, o campo eh uma
562:         *-- SEGUNDA porta de entrada do grupo, nao um rotulo. ReadOnly fixo apagava
563:         *-- essa funcionalidade. Quem reavalia a condicao do When eh
564:         *-- AtualizarCamposDescricao() (regra #45: dependencia num metodo unico).
565:         BINDEVENT(loc_oPagina.txt_4c_Desc_Gru, "LostFocus", THIS, "ValidarDescGrupoLostFocus")
566:         BINDEVENT(loc_oPagina.txt_4c_Desc_Gru, "KeyPress",  THIS, "DescGrupoKeyPress")
567:         BINDEVENT(loc_oPagina.txt_4c_Desc_Gru, "DblClick",  THIS, "DescGrupoDblClick")
568: 
569:         *-- Label "Conta : " (Say3: Top=155+29=184, Left=257, TabIndex=4)
570:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
571:         WITH loc_oPagina.lbl_4c_Label3
572:             .Caption   = "Conta : "
573:             .Top       = 184
574:             .Left      = 257
575:             .Width     = 80
576:             .Height    = 18
577:             .AutoSize  = .F.
578:             .Alignment = 0
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .FontBold  = .F.
582:             .BackStyle = 0
583:             .ForeColor = RGB(90, 90, 90)
584:             .TabIndex  = 4
585:             .Visible   = .T.
586:         ENDWITH
587: 
588:         *-- TextBox Conta (Get_Contas: Top=152+29=181, Left=300, Width=80, TabIndex=5)
589:         *-- MaxLength = SigClLan.contas char(10)
590:         loc_oPagina.AddObject("txt_4c_Contas", "TextBox")
591:         WITH loc_oPagina.txt_4c_Contas
592:             .Value         = ""
593:             .Top           = 181
594:             .Left          = 300
595:             .Width         = 80
596:             .Height        = 23
597:             .FontName      = "Tahoma"
598:             .FontSize      = 8
599:             .ForeColor     = RGB(0, 0, 0)
600:             .BorderColor   = RGB(100, 100, 100)
601:             .SpecialEffect = 1
602:             .Format        = "K"
603:             .MaxLength     = 10
604:             .TabIndex      = 5
605:             .Visible       = .T.
606:         ENDWITH
607:         *-- Lookup no LostFocus, nao no KeyPress - ver comentario do txt_4c_Grupo
608:         BINDEVENT(loc_oPagina.txt_4c_Contas, "LostFocus", THIS, "ValidarContaLostFocus")
609:         BINDEVENT(loc_oPagina.txt_4c_Contas, "KeyPress", THIS, "ContaKeyPress")
610:         BINDEVENT(loc_oPagina.txt_4c_Contas, "DblClick", THIS, "ContaDblClick")
611:         BINDEVENT(loc_oPagina.txt_4c_Contas, "InteractiveChange", THIS, "AtualizarCamposDescricao")
612: 
613:         *-- TextBox Descricao da Conta (Get_Desc_Con: Top=152+29=181, Left=382, Width=360, TabIndex=6)
614:         *-- MaxLength = SigCdCli.rclis char(50)
615:         loc_oPagina.AddObject("txt_4c_Desc_Con", "TextBox")
616:         WITH loc_oPagina.txt_4c_Desc_Con
617:             .Value         = ""
618:             .Top           = 181
619:             .Left          = 382
620:             .Width         = 360
621:             .Height        = 23
622:             .FontName      = "Tahoma"
623:             .FontSize      = 8
624:             .ForeColor     = RGB(0, 0, 0)
625:             .BorderColor   = RGB(100, 100, 100)
626:             .SpecialEffect = 1
627:             .Format        = "K"
628:             .MaxLength     = 50
629:             .TabIndex      = 6
630:             .ReadOnly      = .T.     && estado INICIAL (modo LISTA) - ver AtualizarCamposDescricao
631:             .Visible       = .T.
632:         ENDWITH
633:         *-- Get_Desc_Con.When = IsEmpty(get_contas.value) AND
634:         *-- Inlist(pcEscolha, "INSERIR", "PROCURAR"); o Valid chama
635:         *-- fAcessoContas(Usuar, get_grupos.value, 'D', ...) - busca pela
636:         *-- DESCRICAO (pTip='D') e FILTRADA pelo grupo corrente (pGrp).
637:         BINDEVENT(loc_oPagina.txt_4c_Desc_Con, "LostFocus", THIS, "ValidarDescContaLostFocus")
638:         BINDEVENT(loc_oPagina.txt_4c_Desc_Con, "KeyPress",  THIS, "DescContaKeyPress")
639:         BINDEVENT(loc_oPagina.txt_4c_Desc_Con, "DblClick",  THIS, "DescContaDblClick")
640: 
641:         *-- Botao Inserir Ocorrencia (inserir: Top=335+29=364, Left=629, 40x40)
642:         loc_oPagina.AddObject("cmd_4c_InserirOco", "CommandButton")
643:         WITH loc_oPagina.cmd_4c_InserirOco
644:             .Caption         = ""
645:             .Picture         = gc_4c_CaminhoIcones + "geral_selecionar_26.jpg"
646:             .PicturePosition = 7
647:             .Top             = 364
648:             .Left            = 629
649:             .Width           = 40
650:             .Height          = 40
651:             .FontName        = "Arial"
652:             .FontSize        = 9
653:             .FontBold        = .T.
654:             .BackColor       = RGB(255, 255, 255)
655:             .ForeColor       = RGB(0, 128, 0)
656:             .Themes          = .T.
657:             .SpecialEffect   = 0
658:             .MousePointer    = 15
659:             .ToolTipText     = "Inserir"
660:             .TabIndex        = 8
661:             .Visible         = .T.
662:         ENDWITH
663:         BINDEVENT(loc_oPagina.cmd_4c_InserirOco, "Click", THIS, "BtnInserirOcoClick")
664: 
665:         *-- Botao Excluir Ocorrencia (excluir: Top=375+29=404, Left=629, 40x40)
666:         loc_oPagina.AddObject("cmd_4c_ExcluirOco", "CommandButton")
667:         WITH loc_oPagina.cmd_4c_ExcluirOco
668:             .Caption         = ""
669:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
670:             .PicturePosition = 7
671:             .Top             = 404
672:             .Left            = 629
673:             .Width           = 40
674:             .Height          = 40
675:             .FontName        = "Arial"
676:             .FontSize        = 9
677:             .FontBold        = .T.
678:             .BackColor       = RGB(255, 255, 255)
679:             .ForeColor       = RGB(255, 0, 0)
680:             .Themes          = .T.
681:             .SpecialEffect   = 0
682:             .MousePointer    = 15
683:             .ToolTipText     = "Excluir"
684:             .TabIndex        = 9
685:             .Visible         = .T.
686:         ENDWITH
687:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirOco, "Click", THIS, "BtnExcluirOcoClick")
688: 
689:         *-- Grid de Ocorrencias (Gradeoco: Top=181+29=210, Left=300, Width=324, Height=403)
690:         LOCAL loc_oGrid
691:         loc_oPagina.AddObject("grd_4c_Ocorrencias", "Grid")
692:         loc_oGrid = loc_oPagina.grd_4c_Ocorrencias
693:         loc_oGrid.ColumnCount = 3
694:         loc_oGrid.RecordSource = "cursor_4c_OcoLocal"
695:         loc_oGrid.ColumnCount  = 2
696:         WITH loc_oGrid
697:             .Top                = 210
698:             .Left               = 300
699:             .Width              = 324
700:             .Height             = 403
701:             .FontName           = "Verdana"
702:             .FontSize           = 8
703:             .Panel              = 1
704:             .RowHeight          = 16
705:             .TabIndex           = 7
706:             .ScrollBars         = 2
707:             .GridLines          = 3
708:             .GridLineColor      = RGB(238, 238, 238)
709:             .DeleteMark         = .F.
710:             .RecordMark         = .F.
711:             .HighlightStyle     = 2
712:             .HighlightBackColor = RGB(255, 255, 255)
713:             .HighlightForeColor = RGB(15, 41, 104)
714:             .Visible            = .T.
715: 
716:             .Column1.ControlSource     = "cursor_4c_OcoLocal.Cocos"
717:             .Column1.Width             = 70
718:             .Column1.Movable           = .F.
719:             .Column1.Resizable         = .F.
720:             .Column1.Visible           = .T.
721:             .Column1.Sparse            = .F.
722:             .Column1.Header1.Caption   = "Ocorr" + CHR(234) + "ncia"
723:             .Column1.Header1.FontName  = "Tahoma"
724:             .Column1.Header1.FontSize  = 8
725:             .Column1.Header1.Alignment = 2
726:             .Column1.Text1.FontName    = "Verdana"
727:             .Column1.Text1.FontSize    = 8

*-- Linhas 746 a 814:
746:         ENDWITH
747: 
748:         *-- Celula Ocorrencia com Valid PROPRIO (legado: Gradeoco.Column2.Text1.Valid
749:         *-- abre o fwBuscaExt). Antes a validacao estava num BINDEVENT de
750:         *-- AfterRowColChange, que recebe a coluna de DESTINO: ao sair da Ocorrencia
751:         *-- chegava 2 e o picker nunca abria (Erro191). BINDEVENT em Valid de
752:         *-- TextBox de Column nao eh confiavel -> classe com o evento embutido.
753:         loc_oGrid.Column1.AddObject("txt_4c_Ocorrencia", "TextBoxOcorrencia_4c")
754:         WITH loc_oGrid.Column1.txt_4c_Ocorrencia
755:             .FontName    = "Verdana"
756:             .FontSize    = 8
757:             .BorderStyle = 0
758:             .Margin      = 0
759:             .MaxLength   = 2        && SigClLan.cocos char(2)
760:             .Visible     = .T.
761:         ENDWITH
762:         loc_oGrid.Column1.CurrentControl = "txt_4c_Ocorrencia"   && regra #18
763:         loc_oGrid.Column1.Sparse         = .F.
764: 
765:         *-- Estado inicial dos campos de descricao conforme o When legado
766:         THIS.AtualizarCamposDescricao()
767: 
768:         THIS.TornarControlesVisiveis(loc_oPagina)
769:     ENDPROC
770: 
771:     *--------------------------------------------------------------------------
772:     * CarregarLista - Busca lancamentos distintos e vincula ao grd_4c_Lista
773:     *--------------------------------------------------------------------------
774:     PROCEDURE CarregarLista()
775:         LOCAL loc_lSucesso, loc_oGrid
776:         loc_lSucesso = .F.
777: 
778:         TRY
779:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
780:                 IF USED("cursor_4c_Dados")
781:                     USE IN cursor_4c_Dados
782:                 ENDIF
783:                 SET NULL ON
784:                 CREATE CURSOR cursor_4c_Dados (grupos C(10), contas C(10), cocos C(2), ;
785:                                                cidchaves C(20), grucontas C(20))
786:                 SET NULL OFF
787:                 loc_lSucesso = .T.
788:             ELSE
789:                 IF THIS.this_oBusinessObject.Buscar("")
790:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
791: 
792:                     *-- RecordSource e ColumnCount ANTES do WITH (Problema 48/36)
793:                     loc_oGrid.ColumnCount = 4
794:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
795:                     loc_oGrid.ColumnCount  = 3
796: 
797:                     *-- Colunas do legado (Init): Grupos / Contas / Cocos ("Operacao"), 80px cada
798:                     WITH loc_oGrid
799:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
800:                         .Column1.Width           = 80
801:                         .Column1.Header1.Caption = "Grupos"
802: 
803:                         .Column2.ControlSource   = "cursor_4c_Dados.contas"
804:                         .Column2.Width           = 80
805:                         .Column2.Header1.Caption = "Contas"
806: 
807:                         .Column3.ControlSource   = "cursor_4c_Dados.cocos"
808:                         .Column3.Width           = 80
809:                         .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
810:                     ENDWITH
811: 
812:                     THIS.FormatarGridLista(loc_oGrid)
813:                     THIS.AjustarBotoesPorModo()
814:                     loc_lSucesso = .T.

*-- Linhas 825 a 911:
825:     *--------------------------------------------------------------------------
826:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
827:     *--------------------------------------------------------------------------
828:     PROCEDURE AlternarPagina(par_nPagina)
829:         LOCAL loc_lSucesso
830:         loc_lSucesso = .F.
831: 
832:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
833:             RETURN .F.
834:         ENDIF
835: 
836:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
837: 
838:         IF par_nPagina = 1
839:             *-- Regra #40: o modo eh normalizado AQUI, no FUNIL, nao em cada caller.
840:             *-- Toda chamada de AlternarPagina(1) deste form eh caminho de VOLTA
841:             *-- (Salvar / Cancelar); sem repor o modo, AjustarBotoesPorModo
842:             *-- trabalharia com "INSERIR"/"ALTERAR" ja de volta na Lista.
843:             THIS.this_cModoAtual = "LISTA"
844:             THIS.CarregarLista()
845:         ELSE
846:             *-- repintar com a Page2 JA visivel (Refresh em pagina oculta nao pinta)
847:             THIS.AtualizarGradeOcorrencias()
848:         ENDIF
849: 
850:         *-- Fora do ramo de sucesso do CarregarLista: se o Buscar do BO falhar, os
851:         *-- botoes da Lista ainda precisam terminar num estado coerente (regra #40).
852:         THIS.AjustarBotoesPorModo()
853: 
854:         loc_lSucesso = .T.
855:         RETURN loc_lSucesso
856:     ENDPROC
857: 
858:     *--------------------------------------------------------------------------
859:     * FormatarGridLista - Aplica formatacao visual uniforme ao grid da Page1
860:     *--------------------------------------------------------------------------
861:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
862:         WITH par_oGrid
863:             .FontName = "Tahoma"
864:             .FontSize = 8
865:         ENDWITH
866:     ENDPROC
867: 
868:     *--------------------------------------------------------------------------
869:     * CarregarPaginaDados - Carrega campos de identificacao e ocorrencias na Page2
870:     *--------------------------------------------------------------------------
871:     PROTECTED PROCEDURE CarregarPaginaDados(par_cGruContas)
872:         LOCAL loc_lSucesso, loc_oPagina, loc_cGrupos, loc_cContas
873:         loc_lSucesso = .F.
874:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
875:         loc_cGrupos  = ALLTRIM(LEFT(par_cGruContas, 10))
876:         loc_cContas  = ALLTRIM(RIGHT(par_cGruContas, 10))
877: 
878:         TRY
879:             *-- Preencher campos de identificacao (criados na Fase 5)
880:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
881:                 loc_oPagina.txt_4c_Grupo.Value = loc_cGrupos
882:             ENDIF
883:             IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
884:                 loc_oPagina.txt_4c_Contas.Value = loc_cContas
885:             ENDIF
886: 
887:             *-- Carregar descricoes via SQL
888:             THIS.IniciarDescricoes()
889:             THIS.AtualizarCamposDescricao()
890: 
891:             *-- Carregar ocorrencias no cursor local (grid vinculado na Fase 6)
892:             IF USED("cursor_4c_OcoLocal")
893:                 ZAP IN cursor_4c_OcoLocal
894:             ENDIF
895: 
896:             IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
897:                 *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
898:                 IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
899:                     SELECT cursor_4c_Ocorrencias
900:                     GO TOP
901:                     DO WHILE !EOF()
902:                         SELECT cursor_4c_OcoLocal
903:                         APPEND BLANK
904:                         REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
905:                         REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
906:                         REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
907:                         REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
908:                         SELECT cursor_4c_Ocorrencias
909:                         SKIP
910:                     ENDDO
911:                 ENDIF

*-- Linhas 927 a 1181:
927:     * (Erro192, regra #21). Legado: "GradeOco.Refresh()" no Grupo_op.Click.
928:     * Chamado em TODO caminho que popula o cursor e ao exibir a Page2.
929:     *--------------------------------------------------------------------------
930:     PROTECTED PROCEDURE AtualizarGradeOcorrencias()
931:         IF USED("cursor_4c_OcoLocal")
932:             GO TOP IN cursor_4c_OcoLocal
933:         ENDIF
934:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
935:             THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Refresh()
936:         ENDIF
937:     ENDPROC
938: 
939:     *--------------------------------------------------------------------------
940:     * LimparCampos - Zera propriedades do BO e campos da Page2 para modo de inclusao
941:     *--------------------------------------------------------------------------
942:     PROTECTED PROCEDURE LimparCampos()
943:         LOCAL loc_oPagina
944:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
945: 
946:         THIS.this_oBusinessObject.this_cGrupos    = ""
947:         THIS.this_oBusinessObject.this_cContas    = ""
948:         THIS.this_oBusinessObject.this_cCocos     = ""
949:         THIS.this_oBusinessObject.this_cCidChaves = ""
950:         THIS.this_oBusinessObject.this_cGruContas = ""
951: 
952:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
953:             loc_oPagina.txt_4c_Grupo.Value    = ""
954:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
955:             loc_oPagina.txt_4c_Contas.Value   = ""
956:             loc_oPagina.txt_4c_Desc_Con.Value = ""
957:         ENDIF
958: 
959:         IF USED("cursor_4c_OcoLocal")
960:             ZAP IN cursor_4c_OcoLocal
961:         ENDIF
962:         THIS.AtualizarGradeOcorrencias()
963:         THIS.AtualizarCamposDescricao()
964:     ENDPROC
965: 
966:     *--------------------------------------------------------------------------
967:     * BtnIncluirClick - Navega para Page2 em modo de inclusao de novo grupo+conta
968:     *--------------------------------------------------------------------------
969:     PROCEDURE BtnIncluirClick()
970:         THIS.this_oBusinessObject.NovoRegistro()
971:         THIS.this_cModoAtual      = "INSERIR"
972:         THIS.this_cGrupoAtual     = ""
973:         THIS.this_cContaAtual     = ""
974:         THIS.this_cGruContasAtual = ""
975:         THIS.LimparCampos()
976:         THIS.HabilitarCampos(.T.)
977:         THIS.AlternarPagina(2)
978:     ENDPROC
979: 
980:     *--------------------------------------------------------------------------
981:     * BtnVisualizarClick - Navega para Page2 em modo consulta (somente leitura)
982:     *--------------------------------------------------------------------------
983:     PROCEDURE BtnVisualizarClick()
984:         LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
985:         loc_cGrupos    = ""
986:         loc_cContas    = ""
987:         loc_cGruContas = ""
988: 
989:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
990:             SELECT cursor_4c_Dados
991:             loc_cGrupos    = ALLTRIM(grupos)
992:             loc_cContas    = ALLTRIM(contas)
993:             loc_cGruContas = ALLTRIM(grucontas)
994:         ELSE
995:             MsgAviso("Selecione um registro na lista.", "Selecionar")
996:             RETURN
997:         ENDIF
998: 
999:         THIS.this_cModoAtual      = "PROCURAR"
1000:         THIS.this_cGrupoAtual     = loc_cGrupos
1001:         THIS.this_cContaAtual     = loc_cContas
1002:         THIS.this_cGruContasAtual = loc_cGruContas
1003:         THIS.HabilitarCampos(.T.)
1004: 
1005:         THIS.CarregarPaginaDados(loc_cGruContas)
1006:         THIS.AlternarPagina(2)
1007:     ENDPROC
1008: 
1009:     *--------------------------------------------------------------------------
1010:     * BtnAlterarClick - Navega para Page2 em modo de alteracao
1011:     *--------------------------------------------------------------------------
1012:     PROCEDURE BtnAlterarClick()
1013:         LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
1014:         loc_cGrupos    = ""
1015:         loc_cContas    = ""
1016:         loc_cGruContas = ""
1017: 
1018:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1019:             SELECT cursor_4c_Dados
1020:             loc_cGrupos    = ALLTRIM(grupos)
1021:             loc_cContas    = ALLTRIM(contas)
1022:             loc_cGruContas = ALLTRIM(grucontas)
1023:         ELSE
1024:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1025:             RETURN
1026:         ENDIF
1027: 
1028:         THIS.this_cModoAtual      = "ALTERAR"
1029:         THIS.this_cGrupoAtual     = loc_cGrupos
1030:         THIS.this_cContaAtual     = loc_cContas
1031:         THIS.this_cGruContasAtual = loc_cGruContas
1032:         THIS.HabilitarCampos(.T.)
1033: 
1034:         THIS.CarregarPaginaDados(loc_cGruContas)
1035:         THIS.AlternarPagina(2)
1036:     ENDPROC
1037: 
1038:     *--------------------------------------------------------------------------
1039:     * BtnExcluirClick - Exclui todos os lancamentos do grupo+conta selecionado
1040:     *--------------------------------------------------------------------------
1041:     PROCEDURE BtnExcluirClick()
1042:         LOCAL loc_cGrupos, loc_cContas, loc_cCocos, loc_cCidChaves, loc_lConfirmar
1043:         loc_cGrupos    = ""
1044:         loc_cContas    = ""
1045:         loc_cCocos     = ""
1046:         loc_cCidChaves = ""
1047:         loc_lConfirmar = .F.
1048: 
1049:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1050:             SELECT cursor_4c_Dados
1051:             loc_cGrupos    = ALLTRIM(grupos)
1052:             loc_cContas    = ALLTRIM(contas)
1053:             loc_cCocos     = ALLTRIM(cocos)
1054:             loc_cCidChaves = ALLTRIM(cidchaves)
1055:         ELSE
1056:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1057:             RETURN
1058:         ENDIF
1059: 
1060:         *-- Legado: a lista mostra UMA linha por lancamento e Excluir remove apenas o
1061:         *-- registro corrente (chave cidchaves). Excluir o grupo+conta inteiro fica
1062:         *-- por conta de Alterar (remover as ocorrencias) — Erro148.
1063:         loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do lan" + CHR(231) + "amento" + CHR(13) + ;
1064:                                      "grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + ;
1065:                                      "' / opera" + CHR(231) + CHR(227) + "o '" + loc_cCocos + "'?", ;
1066:                                      "Confirmar Exclus" + CHR(227) + "o")
1067: 
1068:         IF loc_lConfirmar
1069:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1070:                 IF THIS.this_oBusinessObject.Excluir()
1071:                     MsgInfo("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1072:                     THIS.CarregarLista()
1073:                 ENDIF
1074:             ELSE
1075:                 MsgErro("Erro ao carregar lan" + CHR(231) + "amento para exclus" + CHR(227) + "o.", "Erro")
1076:             ENDIF
1077:         ENDIF
1078:     ENDPROC
1079: 
1080:     *--------------------------------------------------------------------------
1081:     * BtnBuscarClick - Recarrega a lista aplicando filtro atual
1082:     *--------------------------------------------------------------------------
1083:     PROCEDURE BtnBuscarClick()
1084:         THIS.CarregarLista()
1085:     ENDPROC
1086: 
1087:     *--------------------------------------------------------------------------
1088:     * BtnEncerrarClick - Fecha o formulario
1089:     *--------------------------------------------------------------------------
1090:     PROCEDURE BtnEncerrarClick()
1091:         THIS.Release()
1092:     ENDPROC
1093: 
1094:     *--------------------------------------------------------------------------
1095:     * BtnSalvarClick - Salva ocorrencias do grupo+conta (modo INSERIR/ALTERAR)
1096:     *                  ou habilita grid de pesquisa (modo PROCURAR)
1097:     *--------------------------------------------------------------------------
1098:     PROCEDURE BtnSalvarClick()
1099:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas, loc_cGruContas
1100:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1101:         loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1102:         loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1103: 
1104:         IF THIS.this_cModoAtual = "PROCURAR"
1105:             IF !EMPTY(loc_cGrupos) AND EMPTY(loc_cContas)
1106:                 MsgAviso("Aten" + CHR(231) + CHR(227) + "o ! Para pesquisar " + CHR(233) + ;
1107:                          " necess" + CHR(225) + "rio escolher tamb" + CHR(233) + "m a Conta.", ;
1108:                          "Aten" + CHR(231) + CHR(227) + "o")
1109:                 loc_oPagina.txt_4c_Contas.SetFocus
1110:                 RETURN
1111:             ENDIF
1112:             *-- Recarregar ocorrencias para o grupo+conta informado
1113:             loc_cGruContas = PADR(loc_cGrupos, 10) + PADR(loc_cContas, 10)
1114:             THIS.this_cGruContasAtual = loc_cGruContas
1115:             THIS.CarregarPaginaDados(loc_cGruContas)
1116:             *-- Habilitar grid para visualizacao (criado na Fase 6)
1117:             IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1118:                 loc_oPagina.grd_4c_Ocorrencias.Enabled = .T.
1119:             ENDIF
1120:             RETURN
1121:         ENDIF
1122: 
1123:         IF INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1124:             IF EMPTY(loc_cGrupos)
1125:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo", "Aten" + CHR(231) + CHR(227) + "o")
1126:                 loc_oPagina.txt_4c_Grupo.SetFocus
1127:                 RETURN
1128:             ENDIF
1129:             IF EMPTY(loc_cContas)
1130:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conta", "Aten" + CHR(231) + CHR(227) + "o")
1131:                 loc_oPagina.txt_4c_Contas.SetFocus
1132:                 RETURN
1133:             ENDIF
1134: 
1135:             *-- O registro deste cadastro E a associacao grupo+conta+ocorrencia: sem
1136:             *-- nenhuma ocorrencia preenchida nao ha o que gravar. Antes o Salvar
1137:             *-- seguia adiante, o BO nao inseria nada e mesmo assim era exibido
1138:             *-- "Lancamentos salvos com sucesso!" (Erro148). Em ALTERAR a lista vazia
1139:             *-- continua valida: significa remover todas as ocorrencias do grupo+conta.
1140:             IF THIS.this_cModoAtual = "INSERIR" AND THIS.ContarOcorrenciasPreenchidas() = 0
1141:                 MsgAviso("Informe ao menos uma ocorr" + CHR(234) + "ncia antes de gravar.", ;
1142:                          "Aten" + CHR(231) + CHR(227) + "o")
1143:                 IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5) AND ;
1144:                         loc_oPagina.grd_4c_Ocorrencias.Enabled
1145:                     loc_oPagina.grd_4c_Ocorrencias.SetFocus
1146:                 ENDIF
1147:                 RETURN
1148:             ENDIF
1149: 
1150:             *-- Espelha a ficha no BO antes de gravar. SalvarOcorrencias recebe
1151:             *-- grupo/conta por parametro, mas ObterChavePrimaria (auditoria) le as
1152:             *-- PROPERTIES - sem isto a auditoria sairia com a chave do registro
1153:             *-- anterior. FormParaBO eh o override do hook PROTECTED do FormBase.
1154:             THIS.FormParaBO()
1155: 
1156:             *-- 4o parametro: lista vazia so eh aceita em ALTERAR (remove todas as ocorrencias)
1157:             IF THIS.this_oBusinessObject.SalvarOcorrencias(loc_cGrupos, loc_cContas, ;
1158:                     "cursor_4c_OcoLocal", (THIS.this_cModoAtual = "ALTERAR"))
1159:                 MsgInfo("Lan" + CHR(231) + "amentos salvos com sucesso!", "Sucesso")
1160:                 THIS.this_cModoAtual = "LISTA"
1161:                 THIS.AlternarPagina(1)
1162:             ENDIF
1163:         ENDIF
1164:     ENDPROC
1165: 
1166:     *--------------------------------------------------------------------------
1167:     * ContarOcorrenciasPreenchidas - Quantas linhas do cursor local tem Cocos
1168:     * preenchido (as unicas que o BO grava em SigClLan)
1169:     *--------------------------------------------------------------------------
1170:     PROTECTED FUNCTION ContarOcorrenciasPreenchidas()
1171:         LOCAL loc_nTotal, loc_nPonteiro
1172:         loc_nTotal = 0
1173: 
1174:         IF !USED("cursor_4c_OcoLocal")
1175:             RETURN 0
1176:         ENDIF
1177: 
1178:         SELECT cursor_4c_OcoLocal
1179:         loc_nPonteiro = IIF(RECCOUNT("cursor_4c_OcoLocal") > 0, RECNO(), 0)
1180:         COUNT TO loc_nTotal FOR !EMPTY(ALLTRIM(cursor_4c_OcoLocal.Cocos))
1181: 

*-- Linhas 1189 a 1247:
1189:     *--------------------------------------------------------------------------
1190:     * BtnCancelarClick - Cancela a operacao e volta para a lista (Page1)
1191:     *--------------------------------------------------------------------------
1192:     PROCEDURE BtnCancelarClick()
1193:         THIS.this_cModoAtual      = "LISTA"
1194:         THIS.this_cGrupoAtual     = ""
1195:         THIS.this_cContaAtual     = ""
1196:         THIS.this_cGruContasAtual = ""
1197:         IF USED("cursor_4c_OcoLocal")
1198:             ZAP IN cursor_4c_OcoLocal
1199:         ENDIF
1200:         THIS.AlternarPagina(1)
1201:     ENDPROC
1202: 
1203:     *--------------------------------------------------------------------------
1204:     * IniciarDescricoes - Carrega descricoes de Grupo (SigCdGcr) e Conta (SigCdCli)
1205:     * Equivalente ao procedure inicdesc do legado
1206:     *--------------------------------------------------------------------------
1207:     PROCEDURE IniciarDescricoes()
1208:         LOCAL loc_oPagina, loc_cGrupo, loc_cConta, loc_nRes, loc_cSQL
1209:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1210: 
1211:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1212:             RETURN
1213:         ENDIF
1214: 
1215:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1216:         loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1217: 
1218:         *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
1219:         IF !EMPTY(loc_cGrupo)
1220:             TRY
1221:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1222:                 IF USED("cursor_4c_TmpGrupo")
1223:                     USE IN cursor_4c_TmpGrupo
1224:                 ENDIF
1225:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
1226:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
1227:                     SELECT cursor_4c_TmpGrupo
1228:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1229:                 ELSE
1230:                     loc_oPagina.txt_4c_Desc_Gru.Value = ""
1231:                 ENDIF
1232:             CATCH TO loException
1233:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1234:             ENDTRY
1235:             IF USED("cursor_4c_TmpGrupo")
1236:                 USE IN cursor_4c_TmpGrupo
1237:             ENDIF
1238:         ELSE
1239:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1240:         ENDIF
1241: 
1242:         *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
1243:         IF !EMPTY(loc_cConta)
1244:             TRY
1245:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1246:                 IF USED("cursor_4c_TmpConta")
1247:                     USE IN cursor_4c_TmpConta

*-- Linhas 1266 a 1866:
1266: 
1267:     *--------------------------------------------------------------------------
1268:     * ValidarGrupoLostFocus - Valida/lookup do codigo de Grupo ao sair do campo
1269:     * Substitui fAcessoContab() do legado usando SQL + FormBuscaAuxiliar
1270:     *
1271:     * Wrapper FINO: o corpo tem RETURN antecipado (campo vazio) e o picker eh
1272:     * MODAL - setar/limpar a flag no proprio corpo deixaria ela ligada para
1273:     * sempre nesse caminho, matando o lookup pelo resto da vida do form.
1274:     * Liberar aqui eh imune a RETURN (regra #47).
1275:     *--------------------------------------------------------------------------
1276:     PROCEDURE ValidarGrupoLostFocus
1277:         IF THIS.this_lEmLookup
1278:             RETURN
1279:         ENDIF
1280:         THIS.this_lEmLookup = .T.
1281:         THIS.ValidarGrupoLostFocusExec()
1282:         THIS.this_lEmLookup = .F.
1283:     ENDPROC
1284: 
1285:     *--------------------------------------------------------------------------
1286:     * ValidarGrupoLostFocusExec - Corpo da validacao de Grupo
1287:     *--------------------------------------------------------------------------
1288:     PROCEDURE ValidarGrupoLostFocusExec
1289:         LOCAL loc_oPagina, loc_cGrupo, loc_cSQL, loc_nRes, loc_oBusca
1290:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1291:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1292: 
1293:         IF EMPTY(loc_cGrupo)
1294:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1295:             RETURN
1296:         ENDIF
1297: 
1298:         TRY
1299:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1300:             IF USED("cursor_4c_BuscaGrupo")
1301:                 USE IN cursor_4c_BuscaGrupo
1302:             ENDIF
1303:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1304: 
1305:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1306:                 SELECT cursor_4c_BuscaGrupo
1307:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1308:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1309:             ELSE
1310:                 IF USED("cursor_4c_BuscaGrupo")
1311:                     USE IN cursor_4c_BuscaGrupo
1312:                 ENDIF
1313:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1314:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1315:                     "Grupo de Conta Corrente")
1316:                 IF VARTYPE(loc_oBusca) = "O"
1317:                     IF !loc_oBusca.this_lAchouRegistro
1318:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1319:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1320:                         loc_oBusca.Show()
1321:                     ENDIF
1322:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1323:                         SELECT cursor_4c_BuscaGrupo
1324:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1325:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1326:                     ELSE
1327:                         *-- Regra #50: dispensar o picker NAO eh erro. O codigo
1328:                         *-- DIGITADO fica (o legado nunca limpa: o Valid do
1329:                         *-- Get_Grupos so chama fAcessoContab). Apagar aqui obriga
1330:                         *-- o usuario a redigitar e ainda perde o prefixo LIKE da
1331:                         *-- proxima abertura. Limpar SO a descricao.
1332:                         loc_oPagina.txt_4c_Desc_Gru.Value = ""
1333:                     ENDIF
1334:                     loc_oBusca.Release()
1335:                 ENDIF
1336:             ENDIF
1337:         CATCH TO loException
1338:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
1339:         ENDTRY
1340: 
1341:         IF USED("cursor_4c_BuscaGrupo")
1342:             USE IN cursor_4c_BuscaGrupo
1343:         ENDIF
1344:     ENDPROC
1345: 
1346:     *--------------------------------------------------------------------------
1347:     * ValidarContaLostFocus - Valida/lookup do codigo de Conta ao sair do campo
1348:     * Substitui fAcessoContas() do legado usando SQL + FormBuscaAuxiliar
1349:     * Wrapper FINO pelo mesmo motivo do ValidarGrupoLostFocus (regra #47).
1350:     *--------------------------------------------------------------------------
1351:     PROCEDURE ValidarContaLostFocus
1352:         IF THIS.this_lEmLookup
1353:             RETURN
1354:         ENDIF
1355:         THIS.this_lEmLookup = .T.
1356:         THIS.ValidarContaLostFocusExec()
1357:         THIS.this_lEmLookup = .F.
1358:     ENDPROC
1359: 
1360:     *--------------------------------------------------------------------------
1361:     * ValidarContaLostFocusExec - Corpo da validacao de Conta
1362:     *--------------------------------------------------------------------------
1363:     PROCEDURE ValidarContaLostFocusExec
1364:         LOCAL loc_oPagina, loc_cConta, loc_cSQL, loc_nRes, loc_oBusca
1365:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1366:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1367: 
1368:         IF EMPTY(loc_cConta)
1369:             loc_oPagina.txt_4c_Desc_Con.Value = ""
1370:             RETURN
1371:         ENDIF
1372: 
1373:         TRY
1374:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1375:             IF USED("cursor_4c_BuscaConta")
1376:                 USE IN cursor_4c_BuscaConta
1377:             ENDIF
1378:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1379: 
1380:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1381:                 SELECT cursor_4c_BuscaConta
1382:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1383:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1384:             ELSE
1385:                 IF USED("cursor_4c_BuscaConta")
1386:                     USE IN cursor_4c_BuscaConta
1387:                 ENDIF
1388:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1389:                     "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
1390:                     "Conta Corrente")
1391:                 IF VARTYPE(loc_oBusca) = "O"
1392:                     IF !loc_oBusca.this_lAchouRegistro
1393:                         loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1394:                         loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1395:                         loc_oBusca.Show()
1396:                     ENDIF
1397:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1398:                         SELECT cursor_4c_BuscaConta
1399:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1400:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1401:                     ELSE
1402:                         *-- Regra #50: idem Grupo. O legado (Get_Contas.Valid) so
1403:                         *-- AVISA "Conta Invalida (Acesso Negado)!!" quando
1404:                         *-- fAcessoContas recusa - nunca apaga o que foi digitado.
1405:                         loc_oPagina.txt_4c_Desc_Con.Value = ""
1406:                     ENDIF
1407:                     loc_oBusca.Release()
1408:                 ENDIF
1409:             ENDIF
1410:         CATCH TO loException
1411:             MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
1412:         ENDTRY
1413: 
1414:         IF USED("cursor_4c_BuscaConta")
1415:             USE IN cursor_4c_BuscaConta
1416:         ENDIF
1417:     ENDPROC
1418: 
1419:     *--------------------------------------------------------------------------
1420:     * HabilitarCampos - Habilita/desabilita campos e botoes de acordo com o modo
1421:     *--------------------------------------------------------------------------
1422:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1423:         LOCAL loc_oPagina, loc_lEditarIdentif, loc_lEditarOco
1424:         loc_oPagina        = THIS.pgf_4c_Paginas.Page2
1425:         loc_lEditarIdentif = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
1426:         loc_lEditarOco     = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1427: 
1428:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1429:             loc_oPagina.txt_4c_Grupo.Enabled = loc_lEditarIdentif
1430:         ENDIF
1431:         IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1432:             loc_oPagina.txt_4c_Contas.Enabled = loc_lEditarIdentif
1433:         ENDIF
1434:         *-- Descricoes NAO sao sempre read-only: o legado as abre como 2a porta de
1435:         *-- entrada (When de Get_Desc_Gru/Get_Desc_Con). Condicao num lugar so.
1436:         THIS.AtualizarCamposDescricao()
1437: 
1438:         *-- Grid de ocorrencias: editavel apenas em INSERIR/ALTERAR
1439:         IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1440:             IF loc_lEditarOco
1441:                 loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .F.
1442:                 loc_oPagina.grd_4c_Ocorrencias.Enabled  = .T.
1443:                 *-- Grid.ReadOnly propaga para as colunas: repor DEPOIS. Descricao
1444:                 *-- nao eh digitavel (legado: Column1.Text1.When = .F.)
1445:                 loc_oPagina.grd_4c_Ocorrencias.Column1.ReadOnly = .F.
1446:                 loc_oPagina.grd_4c_Ocorrencias.Column2.ReadOnly = .T.
1447:             ELSE
1448:                 loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .T.
1449:                 loc_oPagina.grd_4c_Ocorrencias.Enabled  = .F.
1450:             ENDIF
1451:         ENDIF
1452: 
1453:         *-- Botoes inserir/excluir de ocorrencias: visiveis apenas em INSERIR/ALTERAR
1454:         IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirOco", 5)
1455:             loc_oPagina.cmd_4c_InserirOco.Visible = loc_lEditarOco
1456:         ENDIF
1457:         IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirOco", 5)
1458:             loc_oPagina.cmd_4c_ExcluirOco.Visible = loc_lEditarOco
1459:         ENDIF
1460:     ENDPROC
1461: 
1462:     *--------------------------------------------------------------------------
1463:     * ValidarOcorrenciaGrade - Valid da celula Ocorrencia (TextBoxOcorrencia_4c)
1464:     * Transcreve Gradeoco.Column2.Text1.Valid do legado: so age se o valor mudou;
1465:     * lookup em SigCcCco (exato -> picker); ESC limpa; duplicidade limpa e
1466:     * mantem o foco na celula. PUBLIC: chamado pelo Valid do TextBox (Erro191).
1467:     * O valor digitado esta em par_oTxt.Value - o cursor so recebe DEPOIS do Valid.
1468:     *--------------------------------------------------------------------------
1469:     PROCEDURE ValidarOcorrenciaGrade(par_oTxt)
1470:         LOCAL loc_cCocos, loc_cSQL, loc_nRes, loc_lRetorno
1471:         LOCAL loc_cCocosOk, loc_cDescsOk, loc_oBusca
1472:         LOCAL loc_nPonteiro, loc_lDuplicado
1473:         loc_lRetorno = .T.
1474: 
1475:         IF !USED("cursor_4c_OcoLocal") OR EOF("cursor_4c_OcoLocal")
1476:             RETURN .T.
1477:         ENDIF
1478: 
1479:         loc_cCocos = ALLTRIM(par_oTxt.Value)
1480: 
1481:         *-- Legado: IF This.Value = ThisForm.CodAnt -> RETURN
1482:         IF loc_cCocos == ALLTRIM(par_oTxt.this_cValorAnterior)
1483:             RETURN .T.
1484:         ENDIF
1485: 
1486:         SELECT cursor_4c_OcoLocal
1487: 
1488:         *-- Cocos vazio: limpar descs e sair
1489:         IF EMPTY(loc_cCocos)
1490:             REPLACE descs WITH ""
1491:             RETURN .T.
1492:         ENDIF
1493: 
1494:         loc_cCocosOk = ""
1495:         loc_cDescsOk = ""
1496: 
1497:         TRY
1498:             loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
1499:             IF USED("cursor_4c_BuscaCoco")
1500:                 USE IN cursor_4c_BuscaCoco
1501:             ENDIF
1502:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1503: 
1504:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1505:                 SELECT cursor_4c_BuscaCoco
1506:                 loc_cCocosOk = ALLTRIM(Cods)
1507:                 loc_cDescsOk = ALLTRIM(Descs)
1508:             ELSE
1509:                 *-- Pattern A canonico (Erro114/Pattern #166): a SQL fica no caller e o
1510:                 *-- picker recebe um cursor JA populado. O Pattern B (CREATEOBJECT com
1511:                 *-- parametros) fechava o cursor quando nem o codigo exato nem o prefixo
1512:                 *-- batiam, e a janela "Selecao" abria vazia, sem colunas e sem explicacao
1513:                 *-- (Erro149). Aqui: prefixo em Cods OU Descs -> fallback mostrando tudo
1514:                 *-- -> aviso explicito quando nao ha ocorrencia cadastrada.
1515:                 IF USED("cursor_4c_BuscaCoco")
1516:                     USE IN cursor_4c_BuscaCoco
1517:                 ENDIF
1518: 
1519:                 loc_cSQL = "SELECT Cods, Descs FROM SigCcCco" + ;
1520:                            " WHERE Cods LIKE "  + EscaparSQL(loc_cCocos + "%") + ;
1521:                            " OR Descs LIKE " + EscaparSQL(loc_cCocos + "%") + ;
1522:                            " ORDER BY Cods"
1523:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1524: 
1525:                 *-- Fallback SHOW-ALL: prefixo nao bateu, mas pode haver outras ocorrencias
1526:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") = 0
1527:                     USE IN cursor_4c_BuscaCoco
1528:                     loc_cSQL = "SELECT Cods, Descs FROM SigCcCco ORDER BY Cods"
1529:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1530:                 ENDIF
1531: 
1532:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1533:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1534:                     IF VARTYPE(loc_oBusca) = "O"
1535:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaCoco", "Cods", "Descs", ;
1536:                             "Sele" + CHR(231) + CHR(227) + "o")
1537:                         *-- DefinirCursor titula as colunas com o nome do campo; repor os
1538:                         *-- titulos do legado (fwBuscaExt: 'Codigo' / 'Descricao')
1539:                         loc_oBusca.this_nColunas = 0
1540:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1541:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1542: 
1543:                         IF loc_oBusca.Mostrar()
1544:                             loc_cCocosOk = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1545:                             loc_cDescsOk = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1546:                         ELSE
1547:                             loc_cCocosOk = ""
1548:                             loc_cDescsOk = ""
1549:                         ENDIF
1550:                         loc_oBusca.Release()
1551:                     ENDIF
1552:                 ELSE
1553:                     MsgAviso("Nenhuma ocorr" + CHR(234) + "ncia cadastrada.", ;
1554:                              "Sele" + CHR(231) + CHR(227) + "o")
1555:                 ENDIF
1556:             ENDIF
1557: 
1558:             *-- Verificar duplicidade de cocos no cursor local
1559:             SELECT cursor_4c_OcoLocal
1560:             loc_nPonteiro  = RECNO()
1561:             loc_lDuplicado = .F.
1562: 
1563:             IF !EMPTY(loc_cCocosOk)
1564:                 SET ORDER TO Cocos
1565:                 IF SEEK(PADR(loc_cCocosOk, 2))
1566:                     IF RECNO() != loc_nPonteiro
1567:                         loc_lDuplicado = .T.
1568:                     ENDIF
1569:                 ENDIF
1570:                 SET ORDER TO
1571:                 GO loc_nPonteiro
1572:             ENDIF
1573: 
1574:             *-- O TextBox grava no ControlSource DEPOIS do Valid: o .Value tem de
1575:             *-- receber o mesmo que o cursor, senao o texto digitado volta por cima
1576:             IF loc_lDuplicado
1577:                 MsgAviso("J" + CHR(225) + " existe um registro com este grupo, conta e ocorr" + CHR(234) + "ncia ...", ;
1578:                          "Aten" + CHR(231) + CHR(227) + "o")
1579:                 REPLACE Cocos WITH ""
1580:                 REPLACE descs WITH ""
1581:                 par_oTxt.Value = ""
1582:                 loc_lRetorno   = .F.     && legado: Return 0 - fica na celula
1583:             ELSE
1584:                 REPLACE Cocos WITH loc_cCocosOk
1585:                 REPLACE descs WITH loc_cDescsOk
1586:                 par_oTxt.Value = loc_cCocosOk
1587:             ENDIF
1588:             par_oTxt.this_cValorAnterior = par_oTxt.Value
1589: 
1590:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
1591:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Column2.Refresh()
1592:             ENDIF
1593: 
1594:         CATCH TO loException
1595:             MsgErro("Erro ao validar ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1596:         ENDTRY
1597: 
1598:         IF USED("cursor_4c_BuscaCoco")
1599:             USE IN cursor_4c_BuscaCoco
1600:         ENDIF
1601: 
1602:         RETURN loc_lRetorno
1603:     ENDPROC
1604: 
1605:     *--------------------------------------------------------------------------
1606:     * BtnInserirOcoClick - Insere linha em branco no cursor de ocorrencias
1607:     *--------------------------------------------------------------------------
1608:     PROCEDURE BtnInserirOcoClick()
1609:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas
1610:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1611: 
1612:         IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1613:             RETURN
1614:         ENDIF
1615: 
1616:         IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1617:             RETURN
1618:         ENDIF
1619: 
1620:         loc_cGrupos = ""
1621:         loc_cContas = ""
1622:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1623:             loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1624:             loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1625:         ENDIF
1626: 
1627:         TRY
1628:             SELECT cursor_4c_OcoLocal
1629:             APPEND BLANK
1630:             REPLACE Grupos WITH loc_cGrupos
1631:             REPLACE Contas WITH loc_cContas
1632:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1633:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1634:         CATCH TO loException
1635:             MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1636:         ENDTRY
1637:     ENDPROC
1638: 
1639:     *--------------------------------------------------------------------------
1640:     * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
1641:     * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
1642:     *--------------------------------------------------------------------------
1643:     PROCEDURE BtnExcluirOcoClick()
1644:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas
1645:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1646: 
1647:         IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1648:             RETURN
1649:         ENDIF
1650: 
1651:         IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1652:             RETURN
1653:         ENDIF
1654: 
1655:         IF NOT USED("cursor_4c_OcoLocal") OR RECCOUNT("cursor_4c_OcoLocal") = 0
1656:             RETURN
1657:         ENDIF
1658: 
1659:         loc_cGrupos = ""
1660:         loc_cContas = ""
1661:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1662:             loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1663:             loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1664:         ENDIF
1665: 
1666:         TRY
1667:             SELECT cursor_4c_OcoLocal
1668:             DELETE
1669:             GO BOTTOM
1670:             IF EOF()
1671:                 APPEND BLANK
1672:                 REPLACE Grupos WITH loc_cGrupos
1673:                 REPLACE Contas WITH loc_cContas
1674:             ENDIF
1675:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1676:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1677:         CATCH TO loException
1678:             MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1679:         ENDTRY
1680:     ENDPROC
1681: 
1682:     *--------------------------------------------------------------------------
1683:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup
1684:     *--------------------------------------------------------------------------
1685:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1686:         IF par_nKeyCode = 28  && F4
1687:             THIS.AbrirLookupGrupo()
1688:         ENDIF
1689:     ENDPROC
1690: 
1691:     *--------------------------------------------------------------------------
1692:     * GrupoDblClick - Handler DblClick de txt_4c_Grupo
1693:     *--------------------------------------------------------------------------
1694:     PROCEDURE GrupoDblClick()
1695:         THIS.AbrirLookupGrupo()
1696:     ENDPROC
1697: 
1698:     *--------------------------------------------------------------------------
1699:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para Grupo (SigCdGcr)
1700:     *--------------------------------------------------------------------------
1701:     PROCEDURE AbrirLookupGrupo()
1702:         LOCAL loc_oPagina
1703:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1704:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1705:             RETURN
1706:         ENDIF
1707:         IF NOT loc_oPagina.txt_4c_Grupo.Enabled
1708:             RETURN
1709:         ENDIF
1710: 
1711:         *-- Guarda de reentrancia SAVE/RESTORE (regra #47): este funil tambem eh
1712:         *-- chamado de F4/DblClick enquanto o LostFocus pode estar no ar; clear
1713:         *-- fixo liberaria a flag cedo demais e abriria um 2o picker.
1714:         *-- Setada DEPOIS dos RETURN de guarda acima, por isso nao trava ligada.
1715:         LOCAL loc_oBusca, loc_lEmLookupAnt
1716:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1717:         THIS.this_lEmLookup = .T.
1718: 
1719:         TRY
1720:             IF USED("cursor_4c_BuscaGrupo")
1721:                 USE IN cursor_4c_BuscaGrupo
1722:             ENDIF
1723:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1724:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
1725:                 "Grupo de Conta Corrente")
1726: 
1727:             IF VARTYPE(loc_oBusca) = "O"
1728:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1729:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1730:                 loc_oBusca.Show()
1731:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1732:                     SELECT cursor_4c_BuscaGrupo
1733:                     loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1734:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1735:                 ENDIF
1736:                 loc_oBusca.Release()
1737:             ENDIF
1738:         CATCH TO loException
1739:             MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
1740:         ENDTRY
1741: 
1742:         IF USED("cursor_4c_BuscaGrupo")
1743:             USE IN cursor_4c_BuscaGrupo
1744:         ENDIF
1745: 
1746:         THIS.this_lEmLookup = loc_lEmLookupAnt
1747:     ENDPROC
1748: 
1749:     *--------------------------------------------------------------------------
1750:     * ContaKeyPress - Handler KeyPress de txt_4c_Contas: F4 abre lookup
1751:     *--------------------------------------------------------------------------
1752:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1753:         IF par_nKeyCode = 28  && F4
1754:             THIS.AbrirLookupConta()
1755:         ENDIF
1756:     ENDPROC
1757: 
1758:     *--------------------------------------------------------------------------
1759:     * ContaDblClick - Handler DblClick de txt_4c_Contas
1760:     *--------------------------------------------------------------------------
1761:     PROCEDURE ContaDblClick()
1762:         THIS.AbrirLookupConta()
1763:     ENDPROC
1764: 
1765:     *--------------------------------------------------------------------------
1766:     * AbrirLookupConta - Abre FormBuscaAuxiliar para Conta (SigCdCli)
1767:     *--------------------------------------------------------------------------
1768:     PROCEDURE AbrirLookupConta()
1769:         LOCAL loc_oPagina
1770:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1771:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1772:             RETURN
1773:         ENDIF
1774:         IF NOT loc_oPagina.txt_4c_Contas.Enabled
1775:             RETURN
1776:         ENDIF
1777: 
1778:         *-- Guarda de reentrancia SAVE/RESTORE - ver AbrirLookupGrupo (regra #47)
1779:         LOCAL loc_oBusca, loc_lEmLookupAnt
1780:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1781:         THIS.this_lEmLookup = .T.
1782: 
1783:         TRY
1784:             IF USED("cursor_4c_BuscaConta")
1785:                 USE IN cursor_4c_BuscaConta
1786:             ENDIF
1787:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1788:                 "SigCdCli", "cursor_4c_BuscaConta", "Iclis", "", ;
1789:                 "Conta Corrente")
1790: 
1791:             IF VARTYPE(loc_oBusca) = "O"
1792:                 loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1793:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1794:                 loc_oBusca.Show()
1795:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1796:                     SELECT cursor_4c_BuscaConta
1797:                     loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1798:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1799:                 ENDIF
1800:                 loc_oBusca.Release()
1801:             ENDIF
1802:         CATCH TO loException
1803:             MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
1804:         ENDTRY
1805: 
1806:         IF USED("cursor_4c_BuscaConta")
1807:             USE IN cursor_4c_BuscaConta
1808:         ENDIF
1809: 
1810:         THIS.this_lEmLookup = loc_lEmLookupAnt
1811:     ENDPROC
1812: 
1813:     *--------------------------------------------------------------------------
1814:     * AtualizarCamposDescricao - Reavalia o "When" legado dos campos de descricao
1815:     *
1816:     * Legado:
1817:     *   Get_Desc_Gru.When = IsEmpty(get_grupos.value) AND Inlist(pcEscolha,"PROCURAR")
1818:     *   Get_Desc_Con.When = IsEmpty(get_contas.value) AND Inlist(pcEscolha,"INSERIR","PROCURAR")
1819:     *
1820:     * O When eh reavaliado pelo VFP a CADA chegada de foco. Aqui a condicao mora
1821:     * num metodo PUBLIC unico (regra #45), chamado em TODO caminho que mexe nos
1822:     * codigos: fim do ConfigurarPaginaDados, HabilitarCampos, LimparCampos,
1823:     * CarregarPaginaDados, os lookups e o InteractiveChange dos codigos.
1824:     * PUBLIC porque eh alvo de BINDEVENT (regra #3).
1825:     *--------------------------------------------------------------------------
1826:     PROCEDURE AtualizarCamposDescricao()
1827:         LOCAL loc_oPagina
1828:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1829: 
1830:         IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Gru", 5)
1831:             loc_oPagina.txt_4c_Desc_Gru.ReadOnly = !THIS.DescGrupoPodeDigitar()
1832:         ENDIF
1833:         IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Con", 5)
1834:             loc_oPagina.txt_4c_Desc_Con.ReadOnly = !THIS.DescContaPodeDigitar()
1835:         ENDIF
1836:     ENDPROC
1837: 
1838:     *--------------------------------------------------------------------------
1839:     * DescGrupoPodeDigitar - Condicao do Get_Desc_Gru.When legado
1840:     *--------------------------------------------------------------------------
1841:     PROTECTED FUNCTION DescGrupoPodeDigitar()
1842:         LOCAL loc_oPagina, loc_lPode
1843:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1844:         loc_lPode   = .F.
1845: 
1846:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1847:             loc_lPode = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)) AND ;
1848:                         INLIST(THIS.this_cModoAtual, "PROCURAR")
1849:         ENDIF
1850: 
1851:         RETURN loc_lPode
1852:     ENDFUNC
1853: 
1854:     *--------------------------------------------------------------------------
1855:     * DescContaPodeDigitar - Condicao do Get_Desc_Con.When legado
1856:     *--------------------------------------------------------------------------
1857:     PROTECTED FUNCTION DescContaPodeDigitar()
1858:         LOCAL loc_oPagina, loc_lPode
1859:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1860:         loc_lPode   = .F.
1861: 
1862:         IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1863:             loc_lPode = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Contas.Value)) AND ;
1864:                         INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
1865:         ENDIF
1866: 

*-- Linhas 1874 a 2263:
1874:     * setar/limpar a flag dentro do corpo a deixaria ligada nesses caminhos,
1875:     * matando o lookup pelo resto da vida do form.
1876:     *--------------------------------------------------------------------------
1877:     PROCEDURE ValidarDescGrupoLostFocus
1878:         IF THIS.this_lEmLookup
1879:             RETURN
1880:         ENDIF
1881:         THIS.this_lEmLookup = .T.
1882:         THIS.ValidarDescGrupoLostFocusExec()
1883:         THIS.this_lEmLookup = .F.
1884:     ENDPROC
1885: 
1886:     *--------------------------------------------------------------------------
1887:     * ValidarDescGrupoLostFocusExec - Corpo do Valid de Get_Desc_Gru
1888:     *
1889:     * Legado: fAcessoContab(Usuar, 'C', this.value, get_grupos, get_desc_gru).
1890:     * O pTip = "C" do legado busca por SigCdGcr.Codigos (ver utils\functions.prg:
1891:     * "pTip - Tipo busca: C=Codigo, D=Descricao") - TRANSCRITO como esta, sem
1892:     * reescrever para "D" (regra #17). Eh divergencia PROPOSITAL do legado em
1893:     * relacao ao Get_Desc_Con, que passa "D"; o efeito util eh o mesmo porque o
1894:     * FormBuscaAuxiliar cai no fallback show-all quando nada casa, e a escolha no
1895:     * picker preenche codigo + descricao.
1896:     * fAcessoContab/fAcessoContas NAO servem como handler de lookup: elas
1897:     * auto-populam o primeiro registro sem o usuario escolher.
1898:     *--------------------------------------------------------------------------
1899:     PROCEDURE ValidarDescGrupoLostFocusExec
1900:         LOCAL loc_oPagina, loc_cTexto, loc_cSQL, loc_nRes, loc_oBusca
1901:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1902: 
1903:         *-- Campo ReadOnly ainda RECEBE foco e dispara LostFocus: reavaliar o When
1904:         IF NOT THIS.DescGrupoPodeDigitar()
1905:             RETURN
1906:         ENDIF
1907: 
1908:         loc_cTexto = ALLTRIM(loc_oPagina.txt_4c_Desc_Gru.Value)
1909:         IF EMPTY(loc_cTexto)
1910:             RETURN
1911:         ENDIF
1912: 
1913:         TRY
1914:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cTexto)
1915:             IF USED("cursor_4c_BuscaGrupo")
1916:                 USE IN cursor_4c_BuscaGrupo
1917:             ENDIF
1918:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1919: 
1920:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1921:                 SELECT cursor_4c_BuscaGrupo
1922:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1923:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1924:             ELSE
1925:                 IF USED("cursor_4c_BuscaGrupo")
1926:                     USE IN cursor_4c_BuscaGrupo
1927:                 ENDIF
1928:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1929:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cTexto, ;
1930:                     "Grupo de Conta Corrente")
1931:                 IF VARTYPE(loc_oBusca) = "O"
1932:                     IF !loc_oBusca.this_lAchouRegistro
1933:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1934:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1935:                         loc_oBusca.Show()
1936:                     ENDIF
1937:                     *-- Nada escolhido: o texto digitado FICA (regra #50) - o legado
1938:                     *-- nao avisa nem limpa; limpar deixaria o usuario sem saida.
1939:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1940:                         SELECT cursor_4c_BuscaGrupo
1941:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1942:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1943:                     ENDIF
1944:                     loc_oBusca.Release()
1945:                 ENDIF
1946:             ENDIF
1947:         CATCH TO loException
1948:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1949:         ENDTRY
1950: 
1951:         IF USED("cursor_4c_BuscaGrupo")
1952:             USE IN cursor_4c_BuscaGrupo
1953:         ENDIF
1954: 
1955:         *-- Codigo preenchido -> o When fecha o campo de descricao
1956:         THIS.AtualizarCamposDescricao()
1957:     ENDPROC
1958: 
1959:     *--------------------------------------------------------------------------
1960:     * DescGrupoKeyPress - F4 no campo de descricao abre o picker de Grupo
1961:     *--------------------------------------------------------------------------
1962:     PROCEDURE DescGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1963:         IF par_nKeyCode = 28  && F4
1964:             THIS.AbrirLookupDescGrupo()
1965:         ENDIF
1966:     ENDPROC
1967: 
1968:     *--------------------------------------------------------------------------
1969:     * DescGrupoDblClick - Handler DblClick de txt_4c_Desc_Gru
1970:     *--------------------------------------------------------------------------
1971:     PROCEDURE DescGrupoDblClick()
1972:         THIS.AbrirLookupDescGrupo()
1973:     ENDPROC
1974: 
1975:     *--------------------------------------------------------------------------
1976:     * AbrirLookupDescGrupo - Picker de Grupo acionado pelo campo de descricao
1977:     * So age quando o When legado permite digitar ali; o picker em si eh o mesmo
1978:     * do campo de codigo (AbrirLookupGrupo), que ja traz a guarda SAVE/RESTORE.
1979:     *--------------------------------------------------------------------------
1980:     PROCEDURE AbrirLookupDescGrupo()
1981:         IF NOT THIS.DescGrupoPodeDigitar()
1982:             RETURN
1983:         ENDIF
1984:         THIS.AbrirLookupGrupo()
1985:         THIS.AtualizarCamposDescricao()
1986:     ENDPROC
1987: 
1988:     *--------------------------------------------------------------------------
1989:     * ValidarDescContaLostFocus - Valid de Get_Desc_Con (2a porta de entrada)
1990:     * Wrapper FINO pelo mesmo motivo do ValidarDescGrupoLostFocus (regra #47).
1991:     *--------------------------------------------------------------------------
1992:     PROCEDURE ValidarDescContaLostFocus
1993:         IF THIS.this_lEmLookup
1994:             RETURN
1995:         ENDIF
1996:         THIS.this_lEmLookup = .T.
1997:         THIS.ValidarDescContaLostFocusExec()
1998:         THIS.this_lEmLookup = .F.
1999:     ENDPROC
2000: 
2001:     *--------------------------------------------------------------------------
2002:     * ValidarDescContaLostFocusExec - Corpo do Valid de Get_Desc_Con
2003:     *
2004:     * Legado: fAcessoContas(Usuar, get_grupos.value, 'D', this.value,
2005:     *                       get_contas, get_desc_con)
2006:     * - pTip = "D" -> busca pela DESCRICAO (SigCdCli.rclis)
2007:     * - pGrp = get_grupos.value -> a consulta eh FILTRADA pelo grupo corrente
2008:     *   ("And a.Grupos = <grupo>" em utils\functions.prg), por isso o filtro
2009:     *   adicional do FormBuscaAuxiliar (9o argumento).
2010:     *--------------------------------------------------------------------------
2011:     PROCEDURE ValidarDescContaLostFocusExec
2012:         LOCAL loc_oPagina, loc_cTexto, loc_cGrupo, loc_cFiltro
2013:         LOCAL loc_cSQL, loc_nRes, loc_oBusca
2014:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2015: 
2016:         IF NOT THIS.DescContaPodeDigitar()
2017:             RETURN
2018:         ENDIF
2019: 
2020:         loc_cTexto = ALLTRIM(loc_oPagina.txt_4c_Desc_Con.Value)
2021:         IF EMPTY(loc_cTexto)
2022:             RETURN
2023:         ENDIF
2024: 
2025:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2026:         loc_cFiltro = ""
2027:         IF !EMPTY(loc_cGrupo)
2028:             loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
2029:         ENDIF
2030: 
2031:         TRY
2032:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli" + ;
2033:                        " WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cTexto)
2034:             IF !EMPTY(loc_cFiltro)
2035:                 loc_cSQL = loc_cSQL + " AND " + loc_cFiltro
2036:             ENDIF
2037:             IF USED("cursor_4c_BuscaConta")
2038:                 USE IN cursor_4c_BuscaConta
2039:             ENDIF
2040:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2041: 
2042:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") = 1
2043:                 SELECT cursor_4c_BuscaConta
2044:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2045:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2046:             ELSE
2047:                 IF USED("cursor_4c_BuscaConta")
2048:                     USE IN cursor_4c_BuscaConta
2049:                 ENDIF
2050:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2051:                     "SigCdCli", "cursor_4c_BuscaConta", "Rclis", loc_cTexto, ;
2052:                     "Conta Corrente", .F., .F., loc_cFiltro)
2053:                 IF VARTYPE(loc_oBusca) = "O"
2054:                     IF !loc_oBusca.this_lAchouRegistro
2055:                         loc_oBusca.mAddColuna("Iclis", "", "Conta")
2056:                         loc_oBusca.mAddColuna("Rclis", "", "Nome")
2057:                         loc_oBusca.Show()
2058:                     ENDIF
2059:                     *-- Nada escolhido: o texto digitado FICA (regra #50)
2060:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
2061:                         SELECT cursor_4c_BuscaConta
2062:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2063:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2064:                     ENDIF
2065:                     loc_oBusca.Release()
2066:                 ENDIF
2067:             ENDIF
2068:         CATCH TO loException
2069:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
2070:         ENDTRY
2071: 
2072:         IF USED("cursor_4c_BuscaConta")
2073:             USE IN cursor_4c_BuscaConta
2074:         ENDIF
2075: 
2076:         THIS.AtualizarCamposDescricao()
2077:     ENDPROC
2078: 
2079:     *--------------------------------------------------------------------------
2080:     * DescContaKeyPress - F4 no campo de descricao abre o picker de Conta
2081:     *--------------------------------------------------------------------------
2082:     PROCEDURE DescContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2083:         IF par_nKeyCode = 28  && F4
2084:             THIS.AbrirLookupDescConta()
2085:         ENDIF
2086:     ENDPROC
2087: 
2088:     *--------------------------------------------------------------------------
2089:     * DescContaDblClick - Handler DblClick de txt_4c_Desc_Con
2090:     *--------------------------------------------------------------------------
2091:     PROCEDURE DescContaDblClick()
2092:         THIS.AbrirLookupDescConta()
2093:     ENDPROC
2094: 
2095:     *--------------------------------------------------------------------------
2096:     * AbrirLookupDescConta - Picker de Conta acionado pelo campo de descricao
2097:     *--------------------------------------------------------------------------
2098:     PROCEDURE AbrirLookupDescConta()
2099:         IF NOT THIS.DescContaPodeDigitar()
2100:             RETURN
2101:         ENDIF
2102:         THIS.AbrirLookupConta()
2103:         THIS.AtualizarCamposDescricao()
2104:     ENDPROC
2105: 
2106:     *--------------------------------------------------------------------------
2107:     * TornarControlesVisiveis - Percorre controles recursivamente definindo Visible=.T.
2108:     *--------------------------------------------------------------------------
2109:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2110:         LOCAL loc_nI, loc_oObjeto, loc_nP
2111: 
2112:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2113:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2114: 
2115:             IF VARTYPE(loc_oObjeto) = "O"
2116:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2117:                     loc_oObjeto.Visible = .T.
2118:                 ENDIF
2119: 
2120:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2121:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2122:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2123:                     ENDFOR
2124:                 ENDIF
2125: 
2126:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2127:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2128:                 ENDIF
2129:             ENDIF
2130:         ENDFOR
2131:     ENDPROC
2132: 
2133:     *--------------------------------------------------------------------------
2134:     * FormParaBO - Transfere valores dos campos da Page2 para as propriedades do BO
2135:     *--------------------------------------------------------------------------
2136:     PROTECTED PROCEDURE FormParaBO()
2137:         LOCAL loc_oPagina
2138:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2139: 
2140:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
2141:             RETURN
2142:         ENDIF
2143: 
2144:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2145:         THIS.this_oBusinessObject.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
2146:         THIS.this_oBusinessObject.this_cGruContas = PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), 10) + ;
2147:                                                     PADR(ALLTRIM(loc_oPagina.txt_4c_Contas.Value), 10)
2148:     ENDPROC
2149: 
2150:     *--------------------------------------------------------------------------
2151:     * BOParaForm - Transfere valores do BO para os campos da Page2
2152:     *--------------------------------------------------------------------------
2153:     PROTECTED PROCEDURE BOParaForm()
2154:         LOCAL loc_oPagina
2155:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2156: 
2157:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
2158:             RETURN
2159:         ENDIF
2160: 
2161:         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
2162:         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
2163:         loc_oPagina.txt_4c_Desc_Gru.Value = ""
2164:         loc_oPagina.txt_4c_Desc_Con.Value = ""
2165:         THIS.IniciarDescricoes()
2166:     ENDPROC
2167: 
2168:     *--------------------------------------------------------------------------
2169:     * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme dados
2170:     *--------------------------------------------------------------------------
2171:     PROCEDURE AjustarBotoesPorModo()
2172:         LOCAL loc_oPagina, loc_lTemRegistro
2173:         loc_oPagina      = THIS.pgf_4c_Paginas.Page1
2174:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2175: 
2176:         IF NOT PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
2177:             RETURN
2178:         ENDIF
2179: 
2180:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
2181:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = .T.
2182:         ENDIF
2183:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
2184:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
2185:         ENDIF
2186:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
2187:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
2188:         ENDIF
2189:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
2190:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
2191:         ENDIF
2192:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
2193:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
2194:         ENDIF
2195:     ENDPROC
2196: 
2197:     *--------------------------------------------------------------------------
2198:     * Destroy - Libera o Business Object e chama destruicao da classe pai
2199:     *--------------------------------------------------------------------------
2200:     PROCEDURE Destroy()
2201:         *-- O form NAO declara DataSession = 2, entao roda na sessao CORRENTE: os
2202:         *-- cursores criados aqui SOBREVIVEM ao Release e ficariam abertos na
2203:         *-- sessao global, colidindo na proxima abertura da tela.
2204:         TRY
2205:             IF USED("cursor_4c_OcoLocal")
2206:                 USE IN cursor_4c_OcoLocal
2207:             ENDIF
2208:             IF USED("cursor_4c_Dados")
2209:                 USE IN cursor_4c_Dados
2210:             ENDIF
2211:             IF USED("cursor_4c_Ocorrencias")
2212:                 USE IN cursor_4c_Ocorrencias
2213:             ENDIF
2214:             IF USED("cursor_4c_TmpGrupo")
2215:                 USE IN cursor_4c_TmpGrupo
2216:             ENDIF
2217:             IF USED("cursor_4c_TmpConta")
2218:                 USE IN cursor_4c_TmpConta
2219:             ENDIF
2220:             IF USED("cursor_4c_BuscaGrupo")
2221:                 USE IN cursor_4c_BuscaGrupo
2222:             ENDIF
2223:             IF USED("cursor_4c_BuscaConta")
2224:                 USE IN cursor_4c_BuscaConta
2225:             ENDIF
2226:             IF USED("cursor_4c_BuscaCoco")
2227:                 USE IN cursor_4c_BuscaCoco
2228:             ENDIF
2229:         CATCH TO loc_oErro
2230:             MsgErro(loc_oErro.Message, "FormSIGPRLNC.Destroy")
2231:         ENDTRY
2232: 
2233:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2234:             THIS.this_oBusinessObject = .NULL.
2235:         ENDIF
2236:         DODEFAULT()
2237:     ENDPROC
2238: 
2239: ENDDEFINE
2240: 
2241: *==============================================================================
2242: * TextBoxOcorrencia_4c - celula Ocorrencia da grd_4c_Ocorrencias (Erro191)
2243: * Transcreve Gradeoco.Column2.Text1 do legado: When guarda o valor anterior
2244: * (ThisForm.CodAnt) e Valid delega ao form. Eventos embutidos na classe porque
2245: * BINDEVENT em Valid de TextBox dentro de Column nao dispara de forma confiavel.
2246: *==============================================================================
2247: DEFINE CLASS TextBoxOcorrencia_4c AS TextBox
2248:     this_cValorAnterior = ""
2249: 
2250:     PROCEDURE When()
2251:         THIS.this_cValorAnterior = NVL(THIS.Value, "")
2252:         RETURN .T.
2253:     ENDPROC
2254: 
2255:     PROCEDURE Valid()
2256:         LOCAL loc_lRetorno
2257:         loc_lRetorno = .T.
2258:         IF PEMSTATUS(THISFORM, "ValidarOcorrenciaGrade", 5)
2259:             loc_lRetorno = THISFORM.ValidarOcorrenciaGrade(THIS)
2260:         ENDIF
2261:         RETURN loc_lRetorno
2262:     ENDPROC
2263: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGPRLNCBO.prg):
*==============================================================================
* SIGPRLNCBO.prg - Business Object para Lancamentos de Conta Corrente
*
* Tabela principal: SigClLan
*   grupos    char(10) NOT NULL  - Grupo da conta corrente (SigCdGcr.codigos)
*   contas    char(10) NOT NULL  - Conta corrente          (SigCdCli.iclis)
*   cocos     char(2)  NOT NULL  - Codigo da ocorrencia    (SIGCCCCO.cods)
*   cidchaves char(20) NOT NULL  - Chave primaria (fUniqueIds)
*   grucontas char(20) NOT NULL  - Chave POSICIONAL grupos(10)+contas(10)
*
* Tabelas auxiliares (somente leitura):
*   SIGCCCCO  (cods char(2),       descs char(30))  - descricao da ocorrencia
*   SigCdGcr  (codigos char(10),   descrs char(40)) - descricao do grupo
*   SigCdCli  (iclis char(10),     rclis char(50))  - nome da conta/cliente
*==============================================================================
DEFINE CLASS SIGPRLNCBO AS BusinessBase

    *-- Campos de SigClLan
    this_cGrupos    = ""    && char(10) - Grupo da conta corrente
    this_cContas    = ""    && char(10) - Conta corrente
    this_cCocos     = ""    && char(2)  - Codigo da ocorrencia
    this_cCidChaves = ""    && char(20) - Chave primaria (gerada por fUniqueIds)
    this_cGruContas = ""    && char(20) - Chave posicional grupos+contas

    *-- Campo auxiliar (descricao da ocorrencia, vem de SIGCCCCO)
    this_cDescs     = ""    && char(30) - Descricao da ocorrencia (SIGCCCCO.descs)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO configurando tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigClLan"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparDados - Zera as propriedades (chamado por NovoRegistro/CancelarEdicao)
    *--------------------------------------------------------------------------
    PROCEDURE LimparDados()
        DODEFAULT()
        THIS.this_cGrupos    = ""
        THIS.this_cContas    = ""
        THIS.this_cCocos     = ""
        THIS.this_cCidChaves = ""
        THIS.this_cGruContas = ""
        THIS.this_cDescs     = ""
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    * PROTECTED na BusinessBase: so eh chamado de dentro do BO (RegistrarAuditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * MontarGruContas - Monta a chave POSICIONAL grucontas char(20)
    *
    * O legado grava "csSigClLan.Grupos + csSigClLan.Contas", colunas c(10) de um
    * cursor, ou seja o PADDING FAZ PARTE da chave: 10 + 10 = 20 = char(20).
    * ALLTRIM nas partes encurtaria a chave e o WHERE nunca casaria (ZERO linhas,
    * sem erro nenhum). Por isso PADR explicito nas duas partes.
    *--------------------------------------------------------------------------
    FUNCTION MontarGruContas(par_cGrupos, par_cContas)
        LOCAL loc_cGrupos, loc_cContas

        loc_cGrupos = IIF(VARTYPE(par_cGrupos) = "C", par_cGrupos, "")
        loc_cContas = IIF(VARTYPE(par_cContas) = "C", par_cContas, "")

        RETURN PADR(ALLTRIM(loc_cGrupos), 10) + PADR(ALLTRIM(loc_cContas), 10)
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes obrigatorias antes de gravar
    *
    * Transcrito de Pagina.Dados.Grupo_Salva.Salva.Click (INSERIR / ALTERAR):
    *   IF IsEmpty(Get_Grupos.Value) -> "Obrigatorio Informar o Grupo"
    *   IF IsEmpty(Get_Contas.Value) -> "Obrigatorio Informar a Conta"
    * A ocorrencia (cocos) eh NOT NULL na tabela e o legado so grava linha com
    * Cocos preenchido ("If !Empty(csSigClLan.cocos)").
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        DO CASE
            CASE EMPTY(ALLTRIM(NVL(THIS.this_cGrupos, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar o Grupo"
                loc_lValido = .F.

            CASE EMPTY(ALLTRIM(NVL(THIS.this_cContas, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar a Conta"
                loc_lValido = .F.

            CASE EMPTY(ALLTRIM(NVL(THIS.this_cCocos, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar a Ocorr" + ;
                    CHR(234) + "ncia"
                loc_lValido = .F.
        ENDCASE

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor existente
    *
    * TratarNulo(valor, PADRAO): o 2o argumento eh o VALOR PADRAO, nao um codigo
    * de tipo - para coluna char o padrao eh "" (string vazia).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos    = TratarNulo(grupos,    "")
            THIS.this_cContas    = TratarNulo(contas,    "")
            THIS.this_cCocos     = TratarNulo(cocos,     "")
            THIS.this_cCidChaves = TratarNulo(cidchaves, "")
            THIS.this_cGruContas = TratarNulo(grucontas, "")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega a grade da pagina LISTA
    *
    * O legado liga a grade a "Select * From SigClLan" SEM filtro nenhum
    * (AddCursor com o 4o argumento ''), e exibe UMA LINHA POR LANCAMENTO com as
    * colunas Grupos / Contas / Cocos (pColuna do Init). NAO agrupar, NAO usar
    * DISTINCT: a pagina LISTA segue o Init do legado.
    *
    * par_cFiltro eh opcional e so entra quando vier preenchido; a chamada normal
    * do form eh Buscar("") e reproduz exatamente o legado (lista inteira).
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cFiltro
        loc_lSucesso = .F.

        loc_cFiltro = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves, a.grucontas" + ;
                       " FROM SigClLan a"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + loc_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.contas, a.cocos"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar lan" + CHR(231) + "amentos: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.Buscar: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LocalizarPorGruContas - Posiciona cursor_4c_Dados no 1o lancamento do
    * grupo+conta informado, SEM refazer a consulta.
    *
    * Transcreve LocateCursor('crSigClLan','grucontas',sGruContas) do legado:
    * a PROCURAR do frmcadastro apenas POSICIONA a grade ja carregada.
    * Retorna .T. quando encontrou (cursor posicionado no registro).
    *--------------------------------------------------------------------------
    FUNCTION LocalizarPorGruContas(par_cGrupos, par_cContas)
        LOCAL loc_cChave, loc_lAchou, loc_nRegAnterior
        loc_lAchou = .F.

        TRY
            IF USED("cursor_4c_Dados")
                loc_cChave = THIS.MontarGruContas(par_cGrupos, par_cContas)

                SELECT cursor_4c_Dados
                loc_nRegAnterior = IIF(RECNO() >= 1 AND RECNO() <= RECCOUNT(), RECNO(), 1)

                LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.grucontas)) == ;
                           UPPER(ALLTRIM(loc_cChave))

                IF FOUND()
                    loc_lAchou = .T.
                ELSE
                    IF RECCOUNT("cursor_4c_Dados") >= loc_nRegAnterior
                        GO loc_nRegAnterior IN cursor_4c_Dados
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em SIGPRLNCBO.LocalizarPorGruContas: " + loException.Message, ;
                "Erro")
        ENDTRY

        RETURN loc_lAchou
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarOcorrencias - Ocorrencias de um grupo+conta, com a descricao
    *
    * Transcreve a query do Grupo_op.Click do legado:
    *   Select a.*, b.descs from SigClLan a, SigCcCco b
    *    where a.grucontas = '<gruconta>' and a.cocos = b.cods
    * O "from A, B where A.cocos = B.cods" do legado eh INNER JOIN.
    * Retorna o cursor cursor_4c_Ocorrencias.
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOcorrencias(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Ocorrencias")
                USE IN cursor_4c_Ocorrencias
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves," + ;
                       " a.grucontas, b.descs" + ;
                       " FROM SigClLan a" + ;
                       " INNER JOIN SIGCCCCO b ON b.cods = a.cocos" + ;
                       " WHERE a.grucontas = " + EscaparSQL(par_cGruContas) + ;
                       " ORDER BY a.cocos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ocorrencias")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar ocorr" + CHR(234) + "ncias: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.BuscarOcorrencias: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoAuxiliar - Le UMA descricao de tabela auxiliar
    * Retorna a descricao encontrada, ou "" quando o codigo nao existe.
    * Codigo vazio nao consulta o banco e devolve "" (nao eh erro).
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION BuscarDescricaoAuxiliar(par_cTabela, par_cCampoCod, ;
            par_cCampoDesc, par_cValor)

        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_cValor
        loc_cDescricao = ""

        loc_cValor = IIF(VARTYPE(par_cValor) = "C", ALLTRIM(par_cValor), "")

        IF !EMPTY(loc_cValor)
            TRY
                IF USED("cursor_4c_Descricao")
                    USE IN cursor_4c_Descricao
                ENDIF

                loc_cSQL = "SELECT " + par_cCampoCod + ", " + par_cCampoDesc + ;
                           " FROM " + par_cTabela + ;
                           " WHERE RTRIM(" + par_cCampoCod + ") = " + EscaparSQL(loc_cValor)

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Descricao")

                IF loc_nResultado >= 0 AND USED("cursor_4c_Descricao") ;
                        AND RECCOUNT("cursor_4c_Descricao") > 0
                    SELECT cursor_4c_Descricao
                    GO TOP
                    loc_cDescricao = ALLTRIM(TratarNulo(EVALUATE("cursor_4c_Descricao." + ;
                        par_cCampoDesc), ""))
                ENDIF
            CATCH TO loException
                MsgErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o em " + ;
                    par_cTabela + ": " + loException.Message, "Erro")
            ENDTRY

            IF USED("cursor_4c_Descricao")
                USE IN cursor_4c_Descricao
            ENDIF
        ENDIF

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoOcorrencia - Descricao de uma ocorrencia pelo codigo
    * SIGCCCCO (cods char(2), descs char(30))
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoOcorrencia(par_cCodOco)
        RETURN THIS.BuscarDescricaoAuxiliar("SIGCCCCO", "cods", "descs", par_cCodOco)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Descricao do grupo de conta corrente
    *
    * Transcreve o inicdesc do legado:
    *   cursorquery('SigCdGcr','crTmpgccr','codigos', iGrupo)
    *   get_Desc_Gru.Value = crTmpgccr.Descrs
    * SigCdGcr (codigos char(10), descrs char(40))
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoGrupo(par_cGrupo)
        RETURN THIS.BuscarDescricaoAuxiliar("SigCdGcr", "codigos", "descrs", par_cGrupo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta - Nome da conta corrente (cliente)
    *
    * Transcreve o inicdesc do legado:
    *   cursorquery('SigCdCli','crTmpSigCdCli','iclis', iContas)
    *   get_Desc_Con.Value = crTmpSigCdCli.rclis
    * SigCdCli (iclis char(10), rclis char(50))
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cConta)
        RETURN THIS.BuscarDescricaoAuxiliar("SigCdCli", "iclis", "rclis", par_cConta)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.grupos, a.contas, a.cocos, a.cidchaves, a.grucontas" + ;
                       " FROM SigClLan a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao carregar lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ELSE
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    IF loc_lSucesso
                        *-- Registro EXISTENTE: o proximo Salvar() tem de ser UPDATE,
                        *-- senao o INSERT viola a PK cidchaves.
                        THIS.this_lNovoRegistro = .F.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.CarregarPorCodigo: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigClLan
    *
    * PUBLIC (sem PROTECTED): Inserir/Atualizar sao PUBLIC na BusinessBase e o
    * form pode chama-los direto. Declarar PROTECTED aqui tornaria o metodo
    * protegido em TODA a cadeia de heranca e a chamada de fora estouraria com
    * "Property INSERIR is not found".
    *
    * As 5 colunas de SigClLan sao NOT NULL e TODAS entram no INSERT.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- cidchaves NUNCA pode ir vazio: eh PK e o 2o registro colidiria
            *-- no indice unico.
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidChaves, "")))
                THIS.this_cCidChaves = PADR(ALLTRIM(fUniqueIds()), 20)
            ENDIF

            THIS.this_cGruContas = THIS.MontarGruContas(THIS.this_cGrupos, THIS.this_cContas)

            loc_cSQL = "INSERT INTO SigClLan (grupos, contas, cocos, cidchaves, grucontas)" + ;
                       " VALUES (" + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10))    + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))      + ", " + ;
                       EscaparSQL(PADR(ALLTRIM(THIS.this_cCidChaves), 20)) + ", " + ;
                       EscaparSQL(THIS.this_cGruContas)                    + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.Inserir: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigClLan
    * PUBLIC pelo mesmo motivo de Inserir() (ver comentario acima).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_cGruContas = THIS.MontarGruContas(THIS.this_cGrupos, THIS.this_cContas)

            loc_cSQL = "UPDATE SigClLan SET" + ;
                       " grupos = "     + EscaparSQL(PADR(ALLTRIM(THIS.this_cGrupos), 10)) + ;
                       ", contas = "    + EscaparSQL(PADR(ALLTRIM(THIS.this_cContas), 10)) + ;
                       ", cocos = "     + EscaparSQL(PADR(ALLTRIM(THIS.this_cCocos), 2))   + ;
                       ", grucontas = " + EscaparSQL(THIS.this_cGruContas)                 + ;
                       " WHERE cidchaves = " + EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.Atualizar: " + loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigClLan
    * PROTECTED: o form chama Excluir() (PUBLIC), que chama este metodo.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE cidchaves = " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cCidChaves))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir lan" + CHR(231) + "amento: " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.ExecutarExclusao: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirPorGruContas - Remove TODOS os lancamentos de um grupo+conta
    *
    * Transcreve o delete do Salva.Click do legado:
    *   delete from SigClLan where grucontas = '<lcgrucon>'
    *   If ... < 1 -> MessageBox('Favor Reiniciar o Processo!!!')
    * Usado por SalvarOcorrencias (o legado apaga tudo e reinsere).
    *--------------------------------------------------------------------------
    PROCEDURE ExcluirPorGruContas(par_cGruContas)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigClLan WHERE grucontas = " + ;
                       EscaparSQL(par_cGruContas)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                THIS.this_cMensagemErro = "Favor Reiniciar o Processo!!! " + ;
                    CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro Conexao")
                THIS.this_lErroExibido = .T.
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.ExcluirPorGruContas: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarOcorrencias - Grava o conjunto de ocorrencias de um grupo+conta
    *
    * Transcreve Pagina.Dados.Grupo_Salva.Salva.Click (INSERIR / ALTERAR):
    *   1) delete from SigClLan where grucontas = grupos+contas
    *   2) Scan no cursor local; para cada linha com Cocos NAO vazio,
    *      Insert Into SigClLan (Grupos, Contas, Cocos, cIdChaves, Grucontas)
    *      Values (..., fUniqueIds(), Grupos+Contas)
    *
    * par_cGrupos         - codigo do grupo (char 10)
    * par_cContas         - codigo da conta (char 10)
    * par_cCursorOco      - cursor VFP com a lista de ocorrencias (campo cocos)
    * par_lPermitirVazio  - .T. em ALTERAR (cursor vazio = remover tudo)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarOcorrencias(par_cGrupos, par_cContas, par_cCursorOco, par_lPermitirVazio)
        LOCAL loc_cGruContas, loc_lSucesso, loc_cCocos, loc_lAbortar, loc_lPermitirVazio
        LOCAL loc_cSQLIns, loc_nResIns, loc_cCidChaves
        loc_lSucesso = .F.
        loc_lAbortar = .F.

        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        *-- Cursor vazio significa "remover todas as ocorrencias do grupo+conta" e so
        *-- eh valido em ALTERAR (o legado apaga e reinsere). Em INCLUSAO nao ha o que
        *-- gravar: retornar .F. em vez de sucesso, para o form nao anunciar que salvou
        *-- um registro que nao existe.
        loc_lPermitirVazio = (VARTYPE(par_lPermitirVazio) = "L" AND par_lPermitirVazio)

        TRY
            *-- Validacoes do legado (Obrigatorio Informar o Grupo / a Conta)
            IF EMPTY(ALLTRIM(NVL(par_cGrupos, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar o Grupo"
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar AND EMPTY(ALLTRIM(NVL(par_cContas, "")))
                THIS.this_cMensagemErro = "Obrigat" + CHR(243) + "rio Informar a Conta"
                loc_lAbortar = .T.
            ENDIF

            IF !loc_lAbortar
                loc_cGruContas = THIS.MontarGruContas(par_cGrupos, par_cContas)

                IF !THIS.ExcluirPorGruContas(loc_cGruContas)
                    loc_lAbortar = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortar
                IF VARTYPE(par_cCursorOco) != "C" OR !USED(par_cCursorOco) ;
                        OR RECCOUNT(par_cCursorOco) = 0
                    loc_lSucesso = loc_lPermitirVazio
                    loc_lAbortar = .T.
                    IF !loc_lPermitirVazio
                        THIS.this_cMensagemErro = "Nenhuma ocorr" + CHR(234) + ;
                            "ncia informada."
                    ENDIF
                ENDIF
            ENDIF

            IF !loc_lAbortar
                SELECT (par_cCursorOco)
                GO TOP

                DO WHILE !EOF() AND !loc_lAbortar
                    SELECT (par_cCursorOco)
                    loc_cCocos = ALLTRIM(TratarNulo(cocos, ""))

                    IF !EMPTY(loc_cCocos)
                        loc_cCidChaves = PADR(ALLTRIM(fUniqueIds()), 20)

                        THIS.this_cGrupos    = par_cGrupos
                        THIS.this_cContas    = par_cContas
                        THIS.this_cCocos     = loc_cCocos
                        THIS.this_cGruContas = loc_cGruContas
                        THIS.this_cCidChaves = loc_cCidChaves

                        loc_cSQLIns = "INSERT INTO SigClLan" + ;
                                      " (grupos, contas, cocos, cidchaves, grucontas)" + ;
                                      " VALUES (" + ;
                                      EscaparSQL(PADR(ALLTRIM(par_cGrupos), 10)) + ", " + ;
                                      EscaparSQL(PADR(ALLTRIM(par_cContas), 10)) + ", " + ;
                                      EscaparSQL(PADR(loc_cCocos, 2))            + ", " + ;
                                      EscaparSQL(loc_cCidChaves)                 + ", " + ;
                                      EscaparSQL(loc_cGruContas)                 + ;
                                      ")"

                        loc_nResIns = SQLEXEC(gnConnHandle, loc_cSQLIns)

                        IF loc_nResIns < 0
                            THIS.this_cMensagemErro = "Erro ao inserir ocorr" + CHR(234) + ;
                                "ncia '" + loc_cCocos + "': " + CapturarErroSQL()
                            MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                            THIS.this_lErroExibido = .T.
                            loc_lAbortar = .T.
                        ELSE
                            THIS.RegistrarAuditoria("INSERT")
                        ENDIF
                    ENDIF

                    IF !loc_lAbortar
                        SELECT (par_cCursorOco)
                        SKIP
                    ENDIF
                ENDDO

                IF !loc_lAbortar
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            THIS.this_cMensagemErro = "Erro em SIGPRLNCBO.SalvarOcorrencias: " + ;
                loException.Message
            MsgErro(THIS.this_cMensagemErro, "Erro")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        *-- Falha NUNCA eh muda: se sobrou mensagem sem ter sido exibida, exibe agora.
        IF !loc_lSucesso AND !THIS.this_lErroExibido ;
                AND !EMPTY(ALLTRIM(NVL(THIS.this_cMensagemErro, "")))
            THIS.ExibirFalha("Confirmar")
        ENDIF

        IF loc_lSucesso
            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

