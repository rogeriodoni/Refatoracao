# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [METODO-INEXISTENTE] Metodo 'THIS.ContarOcorrenciasPreenchidas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DescGrupoPodeDigitar()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.DescContaPodeDigitar()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSIGPRLNC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2261 linhas total):

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

*-- Linhas 746 a 909:
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
783:                 CREATE CURSOR cursor_4c_Dados (grupos C(10), contas C(10), cocos C(2), ;
784:                                                cidchaves C(20), grucontas C(20))
785:                 loc_lSucesso = .T.
786:             ELSE
787:                 IF THIS.this_oBusinessObject.Buscar("")
788:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
789: 
790:                     *-- RecordSource e ColumnCount ANTES do WITH (Problema 48/36)
791:                     loc_oGrid.ColumnCount = 4
792:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
793:                     loc_oGrid.ColumnCount  = 3
794: 
795:                     *-- Colunas do legado (Init): Grupos / Contas / Cocos ("Operacao"), 80px cada
796:                     WITH loc_oGrid
797:                         .Column1.ControlSource   = "cursor_4c_Dados.grupos"
798:                         .Column1.Width           = 80
799:                         .Column1.Header1.Caption = "Grupos"
800: 
801:                         .Column2.ControlSource   = "cursor_4c_Dados.contas"
802:                         .Column2.Width           = 80
803:                         .Column2.Header1.Caption = "Contas"
804: 
805:                         .Column3.ControlSource   = "cursor_4c_Dados.cocos"
806:                         .Column3.Width           = 80
807:                         .Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
808:                     ENDWITH
809: 
810:                     THIS.FormatarGridLista(loc_oGrid)
811:                     THIS.AjustarBotoesPorModo()
812:                     loc_lSucesso = .T.
813:                 ENDIF
814:             ENDIF
815:         CATCH TO loException
816:             MsgErro("Erro em FormSIGPRLNC.CarregarLista: " + loException.Message, "Erro")
817:             loc_lSucesso = .F.
818:         ENDTRY
819: 
820:         RETURN loc_lSucesso
821:     ENDPROC
822: 
823:     *--------------------------------------------------------------------------
824:     * AlternarPagina - Alterna entre Page1 (lista) e Page2 (dados)
825:     *--------------------------------------------------------------------------
826:     PROCEDURE AlternarPagina(par_nPagina)
827:         LOCAL loc_lSucesso
828:         loc_lSucesso = .F.
829: 
830:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
831:             RETURN .F.
832:         ENDIF
833: 
834:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
835: 
836:         IF par_nPagina = 1
837:             *-- Regra #40: o modo eh normalizado AQUI, no FUNIL, nao em cada caller.
838:             *-- Toda chamada de AlternarPagina(1) deste form eh caminho de VOLTA
839:             *-- (Salvar / Cancelar); sem repor o modo, AjustarBotoesPorModo
840:             *-- trabalharia com "INSERIR"/"ALTERAR" ja de volta na Lista.
841:             THIS.this_cModoAtual = "LISTA"
842:             THIS.CarregarLista()
843:         ELSE
844:             *-- repintar com a Page2 JA visivel (Refresh em pagina oculta nao pinta)
845:             THIS.AtualizarGradeOcorrencias()
846:         ENDIF
847: 
848:         *-- Fora do ramo de sucesso do CarregarLista: se o Buscar do BO falhar, os
849:         *-- botoes da Lista ainda precisam terminar num estado coerente (regra #40).
850:         THIS.AjustarBotoesPorModo()
851: 
852:         loc_lSucesso = .T.
853:         RETURN loc_lSucesso
854:     ENDPROC
855: 
856:     *--------------------------------------------------------------------------
857:     * FormatarGridLista - Aplica formatacao visual uniforme ao grid da Page1
858:     *--------------------------------------------------------------------------
859:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
860:         WITH par_oGrid
861:             .FontName = "Tahoma"
862:             .FontSize = 8
863:         ENDWITH
864:     ENDPROC
865: 
866:     *--------------------------------------------------------------------------
867:     * CarregarPaginaDados - Carrega campos de identificacao e ocorrencias na Page2
868:     *--------------------------------------------------------------------------
869:     PROTECTED PROCEDURE CarregarPaginaDados(par_cGruContas)
870:         LOCAL loc_lSucesso, loc_oPagina, loc_cGrupos, loc_cContas
871:         loc_lSucesso = .F.
872:         loc_oPagina  = THIS.pgf_4c_Paginas.Page2
873:         loc_cGrupos  = ALLTRIM(LEFT(par_cGruContas, 10))
874:         loc_cContas  = ALLTRIM(RIGHT(par_cGruContas, 10))
875: 
876:         TRY
877:             *-- Preencher campos de identificacao (criados na Fase 5)
878:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
879:                 loc_oPagina.txt_4c_Grupo.Value = loc_cGrupos
880:             ENDIF
881:             IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
882:                 loc_oPagina.txt_4c_Contas.Value = loc_cContas
883:             ENDIF
884: 
885:             *-- Carregar descricoes via SQL
886:             THIS.IniciarDescricoes()
887:             THIS.AtualizarCamposDescricao()
888: 
889:             *-- Carregar ocorrencias no cursor local (grid vinculado na Fase 6)
890:             IF USED("cursor_4c_OcoLocal")
891:                 ZAP IN cursor_4c_OcoLocal
892:             ENDIF
893: 
894:             IF THIS.this_oBusinessObject.BuscarOcorrencias(par_cGruContas)
895:                 *-- Copiar ocorrencias do cursor SQL para cursor local (preserva grid)
896:                 IF USED("cursor_4c_Ocorrencias") AND RECCOUNT("cursor_4c_Ocorrencias") > 0
897:                     SELECT cursor_4c_Ocorrencias
898:                     GO TOP
899:                     DO WHILE !EOF()
900:                         SELECT cursor_4c_OcoLocal
901:                         APPEND BLANK
902:                         REPLACE Grupos WITH ALLTRIM(cursor_4c_Ocorrencias.grupos)
903:                         REPLACE Contas WITH ALLTRIM(cursor_4c_Ocorrencias.contas)
904:                         REPLACE Cocos  WITH ALLTRIM(cursor_4c_Ocorrencias.cocos)
905:                         REPLACE descs  WITH ALLTRIM(cursor_4c_Ocorrencias.descs)
906:                         SELECT cursor_4c_Ocorrencias
907:                         SKIP
908:                     ENDDO
909:                 ENDIF

*-- Linhas 925 a 1179:
925:     * (Erro192, regra #21). Legado: "GradeOco.Refresh()" no Grupo_op.Click.
926:     * Chamado em TODO caminho que popula o cursor e ao exibir a Page2.
927:     *--------------------------------------------------------------------------
928:     PROTECTED PROCEDURE AtualizarGradeOcorrencias()
929:         IF USED("cursor_4c_OcoLocal")
930:             GO TOP IN cursor_4c_OcoLocal
931:         ENDIF
932:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
933:             THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Refresh()
934:         ENDIF
935:     ENDPROC
936: 
937:     *--------------------------------------------------------------------------
938:     * LimparCampos - Zera propriedades do BO e campos da Page2 para modo de inclusao
939:     *--------------------------------------------------------------------------
940:     PROTECTED PROCEDURE LimparCampos()
941:         LOCAL loc_oPagina
942:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
943: 
944:         THIS.this_oBusinessObject.this_cGrupos    = ""
945:         THIS.this_oBusinessObject.this_cContas    = ""
946:         THIS.this_oBusinessObject.this_cCocos     = ""
947:         THIS.this_oBusinessObject.this_cCidChaves = ""
948:         THIS.this_oBusinessObject.this_cGruContas = ""
949: 
950:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
951:             loc_oPagina.txt_4c_Grupo.Value    = ""
952:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
953:             loc_oPagina.txt_4c_Contas.Value   = ""
954:             loc_oPagina.txt_4c_Desc_Con.Value = ""
955:         ENDIF
956: 
957:         IF USED("cursor_4c_OcoLocal")
958:             ZAP IN cursor_4c_OcoLocal
959:         ENDIF
960:         THIS.AtualizarGradeOcorrencias()
961:         THIS.AtualizarCamposDescricao()
962:     ENDPROC
963: 
964:     *--------------------------------------------------------------------------
965:     * BtnIncluirClick - Navega para Page2 em modo de inclusao de novo grupo+conta
966:     *--------------------------------------------------------------------------
967:     PROCEDURE BtnIncluirClick()
968:         THIS.this_oBusinessObject.NovoRegistro()
969:         THIS.this_cModoAtual      = "INSERIR"
970:         THIS.this_cGrupoAtual     = ""
971:         THIS.this_cContaAtual     = ""
972:         THIS.this_cGruContasAtual = ""
973:         THIS.LimparCampos()
974:         THIS.HabilitarCampos(.T.)
975:         THIS.AlternarPagina(2)
976:     ENDPROC
977: 
978:     *--------------------------------------------------------------------------
979:     * BtnVisualizarClick - Navega para Page2 em modo consulta (somente leitura)
980:     *--------------------------------------------------------------------------
981:     PROCEDURE BtnVisualizarClick()
982:         LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
983:         loc_cGrupos    = ""
984:         loc_cContas    = ""
985:         loc_cGruContas = ""
986: 
987:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
988:             SELECT cursor_4c_Dados
989:             loc_cGrupos    = ALLTRIM(grupos)
990:             loc_cContas    = ALLTRIM(contas)
991:             loc_cGruContas = ALLTRIM(grucontas)
992:         ELSE
993:             MsgAviso("Selecione um registro na lista.", "Selecionar")
994:             RETURN
995:         ENDIF
996: 
997:         THIS.this_cModoAtual      = "PROCURAR"
998:         THIS.this_cGrupoAtual     = loc_cGrupos
999:         THIS.this_cContaAtual     = loc_cContas
1000:         THIS.this_cGruContasAtual = loc_cGruContas
1001:         THIS.HabilitarCampos(.T.)
1002: 
1003:         THIS.CarregarPaginaDados(loc_cGruContas)
1004:         THIS.AlternarPagina(2)
1005:     ENDPROC
1006: 
1007:     *--------------------------------------------------------------------------
1008:     * BtnAlterarClick - Navega para Page2 em modo de alteracao
1009:     *--------------------------------------------------------------------------
1010:     PROCEDURE BtnAlterarClick()
1011:         LOCAL loc_cGrupos, loc_cContas, loc_cGruContas
1012:         loc_cGrupos    = ""
1013:         loc_cContas    = ""
1014:         loc_cGruContas = ""
1015: 
1016:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1017:             SELECT cursor_4c_Dados
1018:             loc_cGrupos    = ALLTRIM(grupos)
1019:             loc_cContas    = ALLTRIM(contas)
1020:             loc_cGruContas = ALLTRIM(grucontas)
1021:         ELSE
1022:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1023:             RETURN
1024:         ENDIF
1025: 
1026:         THIS.this_cModoAtual      = "ALTERAR"
1027:         THIS.this_cGrupoAtual     = loc_cGrupos
1028:         THIS.this_cContaAtual     = loc_cContas
1029:         THIS.this_cGruContasAtual = loc_cGruContas
1030:         THIS.HabilitarCampos(.T.)
1031: 
1032:         THIS.CarregarPaginaDados(loc_cGruContas)
1033:         THIS.AlternarPagina(2)
1034:     ENDPROC
1035: 
1036:     *--------------------------------------------------------------------------
1037:     * BtnExcluirClick - Exclui todos os lancamentos do grupo+conta selecionado
1038:     *--------------------------------------------------------------------------
1039:     PROCEDURE BtnExcluirClick()
1040:         LOCAL loc_cGrupos, loc_cContas, loc_cCocos, loc_cCidChaves, loc_lConfirmar
1041:         loc_cGrupos    = ""
1042:         loc_cContas    = ""
1043:         loc_cCocos     = ""
1044:         loc_cCidChaves = ""
1045:         loc_lConfirmar = .F.
1046: 
1047:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1048:             SELECT cursor_4c_Dados
1049:             loc_cGrupos    = ALLTRIM(grupos)
1050:             loc_cContas    = ALLTRIM(contas)
1051:             loc_cCocos     = ALLTRIM(cocos)
1052:             loc_cCidChaves = ALLTRIM(cidchaves)
1053:         ELSE
1054:             MsgAviso("Selecione um registro na lista.", "Selecionar")
1055:             RETURN
1056:         ENDIF
1057: 
1058:         *-- Legado: a lista mostra UMA linha por lancamento e Excluir remove apenas o
1059:         *-- registro corrente (chave cidchaves). Excluir o grupo+conta inteiro fica
1060:         *-- por conta de Alterar (remover as ocorrencias) — Erro148.
1061:         loc_lConfirmar = MsgConfirma("Confirma a exclus" + CHR(227) + "o do lan" + CHR(231) + "amento" + CHR(13) + ;
1062:                                      "grupo '" + loc_cGrupos + "' / conta '" + loc_cContas + ;
1063:                                      "' / opera" + CHR(231) + CHR(227) + "o '" + loc_cCocos + "'?", ;
1064:                                      "Confirmar Exclus" + CHR(227) + "o")
1065: 
1066:         IF loc_lConfirmar
1067:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1068:                 IF THIS.this_oBusinessObject.Excluir()
1069:                     MsgInfo("Lan" + CHR(231) + "amento exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1070:                     THIS.CarregarLista()
1071:                 ENDIF
1072:             ELSE
1073:                 MsgErro("Erro ao carregar lan" + CHR(231) + "amento para exclus" + CHR(227) + "o.", "Erro")
1074:             ENDIF
1075:         ENDIF
1076:     ENDPROC
1077: 
1078:     *--------------------------------------------------------------------------
1079:     * BtnBuscarClick - Recarrega a lista aplicando filtro atual
1080:     *--------------------------------------------------------------------------
1081:     PROCEDURE BtnBuscarClick()
1082:         THIS.CarregarLista()
1083:     ENDPROC
1084: 
1085:     *--------------------------------------------------------------------------
1086:     * BtnEncerrarClick - Fecha o formulario
1087:     *--------------------------------------------------------------------------
1088:     PROCEDURE BtnEncerrarClick()
1089:         THIS.Release()
1090:     ENDPROC
1091: 
1092:     *--------------------------------------------------------------------------
1093:     * BtnSalvarClick - Salva ocorrencias do grupo+conta (modo INSERIR/ALTERAR)
1094:     *                  ou habilita grid de pesquisa (modo PROCURAR)
1095:     *--------------------------------------------------------------------------
1096:     PROCEDURE BtnSalvarClick()
1097:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas, loc_cGruContas
1098:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1099:         loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1100:         loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1101: 
1102:         IF THIS.this_cModoAtual = "PROCURAR"
1103:             IF !EMPTY(loc_cGrupos) AND EMPTY(loc_cContas)
1104:                 MsgAviso("Aten" + CHR(231) + CHR(227) + "o ! Para pesquisar " + CHR(233) + ;
1105:                          " necess" + CHR(225) + "rio escolher tamb" + CHR(233) + "m a Conta.", ;
1106:                          "Aten" + CHR(231) + CHR(227) + "o")
1107:                 loc_oPagina.txt_4c_Contas.SetFocus
1108:                 RETURN
1109:             ENDIF
1110:             *-- Recarregar ocorrencias para o grupo+conta informado
1111:             loc_cGruContas = PADR(loc_cGrupos, 10) + PADR(loc_cContas, 10)
1112:             THIS.this_cGruContasAtual = loc_cGruContas
1113:             THIS.CarregarPaginaDados(loc_cGruContas)
1114:             *-- Habilitar grid para visualizacao (criado na Fase 6)
1115:             IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1116:                 loc_oPagina.grd_4c_Ocorrencias.Enabled = .T.
1117:             ENDIF
1118:             RETURN
1119:         ENDIF
1120: 
1121:         IF INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1122:             IF EMPTY(loc_cGrupos)
1123:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar o Grupo", "Aten" + CHR(231) + CHR(227) + "o")
1124:                 loc_oPagina.txt_4c_Grupo.SetFocus
1125:                 RETURN
1126:             ENDIF
1127:             IF EMPTY(loc_cContas)
1128:                 MsgAviso("Obrigat" + CHR(243) + "rio Informar a Conta", "Aten" + CHR(231) + CHR(227) + "o")
1129:                 loc_oPagina.txt_4c_Contas.SetFocus
1130:                 RETURN
1131:             ENDIF
1132: 
1133:             *-- O registro deste cadastro E a associacao grupo+conta+ocorrencia: sem
1134:             *-- nenhuma ocorrencia preenchida nao ha o que gravar. Antes o Salvar
1135:             *-- seguia adiante, o BO nao inseria nada e mesmo assim era exibido
1136:             *-- "Lancamentos salvos com sucesso!" (Erro148). Em ALTERAR a lista vazia
1137:             *-- continua valida: significa remover todas as ocorrencias do grupo+conta.
1138:             IF THIS.this_cModoAtual = "INSERIR" AND THIS.ContarOcorrenciasPreenchidas() = 0
1139:                 MsgAviso("Informe ao menos uma ocorr" + CHR(234) + "ncia antes de gravar.", ;
1140:                          "Aten" + CHR(231) + CHR(227) + "o")
1141:                 IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5) AND ;
1142:                         loc_oPagina.grd_4c_Ocorrencias.Enabled
1143:                     loc_oPagina.grd_4c_Ocorrencias.SetFocus
1144:                 ENDIF
1145:                 RETURN
1146:             ENDIF
1147: 
1148:             *-- Espelha a ficha no BO antes de gravar. SalvarOcorrencias recebe
1149:             *-- grupo/conta por parametro, mas ObterChavePrimaria (auditoria) le as
1150:             *-- PROPERTIES - sem isto a auditoria sairia com a chave do registro
1151:             *-- anterior. FormParaBO eh o override do hook PROTECTED do FormBase.
1152:             THIS.FormParaBO()
1153: 
1154:             *-- 4o parametro: lista vazia so eh aceita em ALTERAR (remove todas as ocorrencias)
1155:             IF THIS.this_oBusinessObject.SalvarOcorrencias(loc_cGrupos, loc_cContas, ;
1156:                     "cursor_4c_OcoLocal", (THIS.this_cModoAtual = "ALTERAR"))
1157:                 MsgInfo("Lan" + CHR(231) + "amentos salvos com sucesso!", "Sucesso")
1158:                 THIS.this_cModoAtual = "LISTA"
1159:                 THIS.AlternarPagina(1)
1160:             ENDIF
1161:         ENDIF
1162:     ENDPROC
1163: 
1164:     *--------------------------------------------------------------------------
1165:     * ContarOcorrenciasPreenchidas - Quantas linhas do cursor local tem Cocos
1166:     * preenchido (as unicas que o BO grava em SigClLan)
1167:     *--------------------------------------------------------------------------
1168:     PROTECTED FUNCTION ContarOcorrenciasPreenchidas()
1169:         LOCAL loc_nTotal, loc_nPonteiro
1170:         loc_nTotal = 0
1171: 
1172:         IF !USED("cursor_4c_OcoLocal")
1173:             RETURN 0
1174:         ENDIF
1175: 
1176:         SELECT cursor_4c_OcoLocal
1177:         loc_nPonteiro = IIF(RECCOUNT("cursor_4c_OcoLocal") > 0, RECNO(), 0)
1178:         COUNT TO loc_nTotal FOR !EMPTY(ALLTRIM(cursor_4c_OcoLocal.Cocos))
1179: 

*-- Linhas 1187 a 1245:
1187:     *--------------------------------------------------------------------------
1188:     * BtnCancelarClick - Cancela a operacao e volta para a lista (Page1)
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE BtnCancelarClick()
1191:         THIS.this_cModoAtual      = "LISTA"
1192:         THIS.this_cGrupoAtual     = ""
1193:         THIS.this_cContaAtual     = ""
1194:         THIS.this_cGruContasAtual = ""
1195:         IF USED("cursor_4c_OcoLocal")
1196:             ZAP IN cursor_4c_OcoLocal
1197:         ENDIF
1198:         THIS.AlternarPagina(1)
1199:     ENDPROC
1200: 
1201:     *--------------------------------------------------------------------------
1202:     * IniciarDescricoes - Carrega descricoes de Grupo (SigCdGcr) e Conta (SigCdCli)
1203:     * Equivalente ao procedure inicdesc do legado
1204:     *--------------------------------------------------------------------------
1205:     PROCEDURE IniciarDescricoes()
1206:         LOCAL loc_oPagina, loc_cGrupo, loc_cConta, loc_nRes, loc_cSQL
1207:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1208: 
1209:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1210:             RETURN
1211:         ENDIF
1212: 
1213:         loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1214:         loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1215: 
1216:         *-- Busca descricao do grupo em SigCdGcr (Codigos/Descrs com 'r')
1217:         IF !EMPTY(loc_cGrupo)
1218:             TRY
1219:                 loc_cSQL = "SELECT Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1220:                 IF USED("cursor_4c_TmpGrupo")
1221:                     USE IN cursor_4c_TmpGrupo
1222:                 ENDIF
1223:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpGrupo")
1224:                 IF loc_nRes >= 0 AND USED("cursor_4c_TmpGrupo") AND RECCOUNT("cursor_4c_TmpGrupo") > 0
1225:                     SELECT cursor_4c_TmpGrupo
1226:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1227:                 ELSE
1228:                     loc_oPagina.txt_4c_Desc_Gru.Value = ""
1229:                 ENDIF
1230:             CATCH TO loException
1231:                 MsgErro("Erro ao carregar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1232:             ENDTRY
1233:             IF USED("cursor_4c_TmpGrupo")
1234:                 USE IN cursor_4c_TmpGrupo
1235:             ENDIF
1236:         ELSE
1237:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1238:         ENDIF
1239: 
1240:         *-- Busca descricao da conta em SigCdCli (Iclis/Rclis)
1241:         IF !EMPTY(loc_cConta)
1242:             TRY
1243:                 loc_cSQL = "SELECT Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1244:                 IF USED("cursor_4c_TmpConta")
1245:                     USE IN cursor_4c_TmpConta

*-- Linhas 1264 a 1864:
1264: 
1265:     *--------------------------------------------------------------------------
1266:     * ValidarGrupoLostFocus - Valida/lookup do codigo de Grupo ao sair do campo
1267:     * Substitui fAcessoContab() do legado usando SQL + FormBuscaAuxiliar
1268:     *
1269:     * Wrapper FINO: o corpo tem RETURN antecipado (campo vazio) e o picker eh
1270:     * MODAL - setar/limpar a flag no proprio corpo deixaria ela ligada para
1271:     * sempre nesse caminho, matando o lookup pelo resto da vida do form.
1272:     * Liberar aqui eh imune a RETURN (regra #47).
1273:     *--------------------------------------------------------------------------
1274:     PROCEDURE ValidarGrupoLostFocus
1275:         IF THIS.this_lEmLookup
1276:             RETURN
1277:         ENDIF
1278:         THIS.this_lEmLookup = .T.
1279:         THIS.ValidarGrupoLostFocusExec()
1280:         THIS.this_lEmLookup = .F.
1281:     ENDPROC
1282: 
1283:     *--------------------------------------------------------------------------
1284:     * ValidarGrupoLostFocusExec - Corpo da validacao de Grupo
1285:     *--------------------------------------------------------------------------
1286:     PROCEDURE ValidarGrupoLostFocusExec
1287:         LOCAL loc_oPagina, loc_cGrupo, loc_cSQL, loc_nRes, loc_oBusca
1288:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1289:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1290: 
1291:         IF EMPTY(loc_cGrupo)
1292:             loc_oPagina.txt_4c_Desc_Gru.Value = ""
1293:             RETURN
1294:         ENDIF
1295: 
1296:         TRY
1297:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
1298:             IF USED("cursor_4c_BuscaGrupo")
1299:                 USE IN cursor_4c_BuscaGrupo
1300:             ENDIF
1301:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1302: 
1303:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1304:                 SELECT cursor_4c_BuscaGrupo
1305:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1306:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1307:             ELSE
1308:                 IF USED("cursor_4c_BuscaGrupo")
1309:                     USE IN cursor_4c_BuscaGrupo
1310:                 ENDIF
1311:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1312:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cGrupo, ;
1313:                     "Grupo de Conta Corrente")
1314:                 IF VARTYPE(loc_oBusca) = "O"
1315:                     IF !loc_oBusca.this_lAchouRegistro
1316:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1317:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1318:                         loc_oBusca.Show()
1319:                     ENDIF
1320:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1321:                         SELECT cursor_4c_BuscaGrupo
1322:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1323:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1324:                     ELSE
1325:                         *-- Regra #50: dispensar o picker NAO eh erro. O codigo
1326:                         *-- DIGITADO fica (o legado nunca limpa: o Valid do
1327:                         *-- Get_Grupos so chama fAcessoContab). Apagar aqui obriga
1328:                         *-- o usuario a redigitar e ainda perde o prefixo LIKE da
1329:                         *-- proxima abertura. Limpar SO a descricao.
1330:                         loc_oPagina.txt_4c_Desc_Gru.Value = ""
1331:                     ENDIF
1332:                     loc_oBusca.Release()
1333:                 ENDIF
1334:             ENDIF
1335:         CATCH TO loException
1336:             MsgErro("Erro ao validar grupo: " + loException.Message, "Erro")
1337:         ENDTRY
1338: 
1339:         IF USED("cursor_4c_BuscaGrupo")
1340:             USE IN cursor_4c_BuscaGrupo
1341:         ENDIF
1342:     ENDPROC
1343: 
1344:     *--------------------------------------------------------------------------
1345:     * ValidarContaLostFocus - Valida/lookup do codigo de Conta ao sair do campo
1346:     * Substitui fAcessoContas() do legado usando SQL + FormBuscaAuxiliar
1347:     * Wrapper FINO pelo mesmo motivo do ValidarGrupoLostFocus (regra #47).
1348:     *--------------------------------------------------------------------------
1349:     PROCEDURE ValidarContaLostFocus
1350:         IF THIS.this_lEmLookup
1351:             RETURN
1352:         ENDIF
1353:         THIS.this_lEmLookup = .T.
1354:         THIS.ValidarContaLostFocusExec()
1355:         THIS.this_lEmLookup = .F.
1356:     ENDPROC
1357: 
1358:     *--------------------------------------------------------------------------
1359:     * ValidarContaLostFocusExec - Corpo da validacao de Conta
1360:     *--------------------------------------------------------------------------
1361:     PROCEDURE ValidarContaLostFocusExec
1362:         LOCAL loc_oPagina, loc_cConta, loc_cSQL, loc_nRes, loc_oBusca
1363:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1364:         loc_cConta  = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1365: 
1366:         IF EMPTY(loc_cConta)
1367:             loc_oPagina.txt_4c_Desc_Con.Value = ""
1368:             RETURN
1369:         ENDIF
1370: 
1371:         TRY
1372:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli WHERE Iclis = " + EscaparSQL(loc_cConta)
1373:             IF USED("cursor_4c_BuscaConta")
1374:                 USE IN cursor_4c_BuscaConta
1375:             ENDIF
1376:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
1377: 
1378:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1379:                 SELECT cursor_4c_BuscaConta
1380:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1381:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1382:             ELSE
1383:                 IF USED("cursor_4c_BuscaConta")
1384:                     USE IN cursor_4c_BuscaConta
1385:                 ENDIF
1386:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1387:                     "SigCdCli", "cursor_4c_BuscaConta", "Iclis", loc_cConta, ;
1388:                     "Conta Corrente")
1389:                 IF VARTYPE(loc_oBusca) = "O"
1390:                     IF !loc_oBusca.this_lAchouRegistro
1391:                         loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1392:                         loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1393:                         loc_oBusca.Show()
1394:                     ENDIF
1395:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1396:                         SELECT cursor_4c_BuscaConta
1397:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1398:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1399:                     ELSE
1400:                         *-- Regra #50: idem Grupo. O legado (Get_Contas.Valid) so
1401:                         *-- AVISA "Conta Invalida (Acesso Negado)!!" quando
1402:                         *-- fAcessoContas recusa - nunca apaga o que foi digitado.
1403:                         loc_oPagina.txt_4c_Desc_Con.Value = ""
1404:                     ENDIF
1405:                     loc_oBusca.Release()
1406:                 ENDIF
1407:             ENDIF
1408:         CATCH TO loException
1409:             MsgErro("Erro ao validar conta: " + loException.Message, "Erro")
1410:         ENDTRY
1411: 
1412:         IF USED("cursor_4c_BuscaConta")
1413:             USE IN cursor_4c_BuscaConta
1414:         ENDIF
1415:     ENDPROC
1416: 
1417:     *--------------------------------------------------------------------------
1418:     * HabilitarCampos - Habilita/desabilita campos e botoes de acordo com o modo
1419:     *--------------------------------------------------------------------------
1420:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1421:         LOCAL loc_oPagina, loc_lEditarIdentif, loc_lEditarOco
1422:         loc_oPagina        = THIS.pgf_4c_Paginas.Page2
1423:         loc_lEditarIdentif = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
1424:         loc_lEditarOco     = par_lHabilitar AND INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1425: 
1426:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1427:             loc_oPagina.txt_4c_Grupo.Enabled = loc_lEditarIdentif
1428:         ENDIF
1429:         IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1430:             loc_oPagina.txt_4c_Contas.Enabled = loc_lEditarIdentif
1431:         ENDIF
1432:         *-- Descricoes NAO sao sempre read-only: o legado as abre como 2a porta de
1433:         *-- entrada (When de Get_Desc_Gru/Get_Desc_Con). Condicao num lugar so.
1434:         THIS.AtualizarCamposDescricao()
1435: 
1436:         *-- Grid de ocorrencias: editavel apenas em INSERIR/ALTERAR
1437:         IF PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1438:             IF loc_lEditarOco
1439:                 loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .F.
1440:                 loc_oPagina.grd_4c_Ocorrencias.Enabled  = .T.
1441:                 *-- Grid.ReadOnly propaga para as colunas: repor DEPOIS. Descricao
1442:                 *-- nao eh digitavel (legado: Column1.Text1.When = .F.)
1443:                 loc_oPagina.grd_4c_Ocorrencias.Column1.ReadOnly = .F.
1444:                 loc_oPagina.grd_4c_Ocorrencias.Column2.ReadOnly = .T.
1445:             ELSE
1446:                 loc_oPagina.grd_4c_Ocorrencias.ReadOnly = .T.
1447:                 loc_oPagina.grd_4c_Ocorrencias.Enabled  = .F.
1448:             ENDIF
1449:         ENDIF
1450: 
1451:         *-- Botoes inserir/excluir de ocorrencias: visiveis apenas em INSERIR/ALTERAR
1452:         IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirOco", 5)
1453:             loc_oPagina.cmd_4c_InserirOco.Visible = loc_lEditarOco
1454:         ENDIF
1455:         IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirOco", 5)
1456:             loc_oPagina.cmd_4c_ExcluirOco.Visible = loc_lEditarOco
1457:         ENDIF
1458:     ENDPROC
1459: 
1460:     *--------------------------------------------------------------------------
1461:     * ValidarOcorrenciaGrade - Valid da celula Ocorrencia (TextBoxOcorrencia_4c)
1462:     * Transcreve Gradeoco.Column2.Text1.Valid do legado: so age se o valor mudou;
1463:     * lookup em SigCcCco (exato -> picker); ESC limpa; duplicidade limpa e
1464:     * mantem o foco na celula. PUBLIC: chamado pelo Valid do TextBox (Erro191).
1465:     * O valor digitado esta em par_oTxt.Value - o cursor so recebe DEPOIS do Valid.
1466:     *--------------------------------------------------------------------------
1467:     PROCEDURE ValidarOcorrenciaGrade(par_oTxt)
1468:         LOCAL loc_cCocos, loc_cSQL, loc_nRes, loc_lRetorno
1469:         LOCAL loc_cCocosOk, loc_cDescsOk, loc_oBusca
1470:         LOCAL loc_nPonteiro, loc_lDuplicado
1471:         loc_lRetorno = .T.
1472: 
1473:         IF !USED("cursor_4c_OcoLocal") OR EOF("cursor_4c_OcoLocal")
1474:             RETURN .T.
1475:         ENDIF
1476: 
1477:         loc_cCocos = ALLTRIM(par_oTxt.Value)
1478: 
1479:         *-- Legado: IF This.Value = ThisForm.CodAnt -> RETURN
1480:         IF loc_cCocos == ALLTRIM(par_oTxt.this_cValorAnterior)
1481:             RETURN .T.
1482:         ENDIF
1483: 
1484:         SELECT cursor_4c_OcoLocal
1485: 
1486:         *-- Cocos vazio: limpar descs e sair
1487:         IF EMPTY(loc_cCocos)
1488:             REPLACE descs WITH ""
1489:             RETURN .T.
1490:         ENDIF
1491: 
1492:         loc_cCocosOk = ""
1493:         loc_cDescsOk = ""
1494: 
1495:         TRY
1496:             loc_cSQL = "SELECT Cods, Descs FROM SigCcCco WHERE Cods = " + EscaparSQL(loc_cCocos)
1497:             IF USED("cursor_4c_BuscaCoco")
1498:                 USE IN cursor_4c_BuscaCoco
1499:             ENDIF
1500:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1501: 
1502:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1503:                 SELECT cursor_4c_BuscaCoco
1504:                 loc_cCocosOk = ALLTRIM(Cods)
1505:                 loc_cDescsOk = ALLTRIM(Descs)
1506:             ELSE
1507:                 *-- Pattern A canonico (Erro114/Pattern #166): a SQL fica no caller e o
1508:                 *-- picker recebe um cursor JA populado. O Pattern B (CREATEOBJECT com
1509:                 *-- parametros) fechava o cursor quando nem o codigo exato nem o prefixo
1510:                 *-- batiam, e a janela "Selecao" abria vazia, sem colunas e sem explicacao
1511:                 *-- (Erro149). Aqui: prefixo em Cods OU Descs -> fallback mostrando tudo
1512:                 *-- -> aviso explicito quando nao ha ocorrencia cadastrada.
1513:                 IF USED("cursor_4c_BuscaCoco")
1514:                     USE IN cursor_4c_BuscaCoco
1515:                 ENDIF
1516: 
1517:                 loc_cSQL = "SELECT Cods, Descs FROM SigCcCco" + ;
1518:                            " WHERE Cods LIKE "  + EscaparSQL(loc_cCocos + "%") + ;
1519:                            " OR Descs LIKE " + EscaparSQL(loc_cCocos + "%") + ;
1520:                            " ORDER BY Cods"
1521:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1522: 
1523:                 *-- Fallback SHOW-ALL: prefixo nao bateu, mas pode haver outras ocorrencias
1524:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") = 0
1525:                     USE IN cursor_4c_BuscaCoco
1526:                     loc_cSQL = "SELECT Cods, Descs FROM SigCcCco ORDER BY Cods"
1527:                     loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaCoco")
1528:                 ENDIF
1529: 
1530:                 IF loc_nRes >= 0 AND USED("cursor_4c_BuscaCoco") AND RECCOUNT("cursor_4c_BuscaCoco") > 0
1531:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1532:                     IF VARTYPE(loc_oBusca) = "O"
1533:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaCoco", "Cods", "Descs", ;
1534:                             "Sele" + CHR(231) + CHR(227) + "o")
1535:                         *-- DefinirCursor titula as colunas com o nome do campo; repor os
1536:                         *-- titulos do legado (fwBuscaExt: 'Codigo' / 'Descricao')
1537:                         loc_oBusca.this_nColunas = 0
1538:                         loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
1539:                         loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
1540: 
1541:                         IF loc_oBusca.Mostrar()
1542:                             loc_cCocosOk = ALLTRIM(loc_oBusca.cCodigoSelecionado)
1543:                             loc_cDescsOk = ALLTRIM(loc_oBusca.cDescricaoSelecionada)
1544:                         ELSE
1545:                             loc_cCocosOk = ""
1546:                             loc_cDescsOk = ""
1547:                         ENDIF
1548:                         loc_oBusca.Release()
1549:                     ENDIF
1550:                 ELSE
1551:                     MsgAviso("Nenhuma ocorr" + CHR(234) + "ncia cadastrada.", ;
1552:                              "Sele" + CHR(231) + CHR(227) + "o")
1553:                 ENDIF
1554:             ENDIF
1555: 
1556:             *-- Verificar duplicidade de cocos no cursor local
1557:             SELECT cursor_4c_OcoLocal
1558:             loc_nPonteiro  = RECNO()
1559:             loc_lDuplicado = .F.
1560: 
1561:             IF !EMPTY(loc_cCocosOk)
1562:                 SET ORDER TO Cocos
1563:                 IF SEEK(PADR(loc_cCocosOk, 2))
1564:                     IF RECNO() != loc_nPonteiro
1565:                         loc_lDuplicado = .T.
1566:                     ENDIF
1567:                 ENDIF
1568:                 SET ORDER TO
1569:                 GO loc_nPonteiro
1570:             ENDIF
1571: 
1572:             *-- O TextBox grava no ControlSource DEPOIS do Valid: o .Value tem de
1573:             *-- receber o mesmo que o cursor, senao o texto digitado volta por cima
1574:             IF loc_lDuplicado
1575:                 MsgAviso("J" + CHR(225) + " existe um registro com este grupo, conta e ocorr" + CHR(234) + "ncia ...", ;
1576:                          "Aten" + CHR(231) + CHR(227) + "o")
1577:                 REPLACE Cocos WITH ""
1578:                 REPLACE descs WITH ""
1579:                 par_oTxt.Value = ""
1580:                 loc_lRetorno   = .F.     && legado: Return 0 - fica na celula
1581:             ELSE
1582:                 REPLACE Cocos WITH loc_cCocosOk
1583:                 REPLACE descs WITH loc_cDescsOk
1584:                 par_oTxt.Value = loc_cCocosOk
1585:             ENDIF
1586:             par_oTxt.this_cValorAnterior = par_oTxt.Value
1587: 
1588:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Ocorrencias", 5)
1589:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Ocorrencias.Column2.Refresh()
1590:             ENDIF
1591: 
1592:         CATCH TO loException
1593:             MsgErro("Erro ao validar ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1594:         ENDTRY
1595: 
1596:         IF USED("cursor_4c_BuscaCoco")
1597:             USE IN cursor_4c_BuscaCoco
1598:         ENDIF
1599: 
1600:         RETURN loc_lRetorno
1601:     ENDPROC
1602: 
1603:     *--------------------------------------------------------------------------
1604:     * BtnInserirOcoClick - Insere linha em branco no cursor de ocorrencias
1605:     *--------------------------------------------------------------------------
1606:     PROCEDURE BtnInserirOcoClick()
1607:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas
1608:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1609: 
1610:         IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1611:             RETURN
1612:         ENDIF
1613: 
1614:         IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1615:             RETURN
1616:         ENDIF
1617: 
1618:         loc_cGrupos = ""
1619:         loc_cContas = ""
1620:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1621:             loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1622:             loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1623:         ENDIF
1624: 
1625:         TRY
1626:             SELECT cursor_4c_OcoLocal
1627:             APPEND BLANK
1628:             REPLACE Grupos WITH loc_cGrupos
1629:             REPLACE Contas WITH loc_cContas
1630:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1631:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1632:         CATCH TO loException
1633:             MsgErro("Erro ao inserir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1634:         ENDTRY
1635:     ENDPROC
1636: 
1637:     *--------------------------------------------------------------------------
1638:     * BtnExcluirOcoClick - Exclui linha corrente do cursor de ocorrencias
1639:     * Mantem ao menos uma linha em branco para nova entrada (padrao legado)
1640:     *--------------------------------------------------------------------------
1641:     PROCEDURE BtnExcluirOcoClick()
1642:         LOCAL loc_oPagina, loc_cGrupos, loc_cContas
1643:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1644: 
1645:         IF NOT INLIST(THIS.this_cModoAtual, "INSERIR", "ALTERAR")
1646:             RETURN
1647:         ENDIF
1648: 
1649:         IF NOT PEMSTATUS(loc_oPagina, "grd_4c_Ocorrencias", 5)
1650:             RETURN
1651:         ENDIF
1652: 
1653:         IF NOT USED("cursor_4c_OcoLocal") OR RECCOUNT("cursor_4c_OcoLocal") = 0
1654:             RETURN
1655:         ENDIF
1656: 
1657:         loc_cGrupos = ""
1658:         loc_cContas = ""
1659:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1660:             loc_cGrupos = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1661:             loc_cContas = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
1662:         ENDIF
1663: 
1664:         TRY
1665:             SELECT cursor_4c_OcoLocal
1666:             DELETE
1667:             GO BOTTOM
1668:             IF EOF()
1669:                 APPEND BLANK
1670:                 REPLACE Grupos WITH loc_cGrupos
1671:                 REPLACE Contas WITH loc_cContas
1672:             ENDIF
1673:             loc_oPagina.grd_4c_Ocorrencias.Refresh()
1674:             loc_oPagina.grd_4c_Ocorrencias.Column1.SetFocus
1675:         CATCH TO loException
1676:             MsgErro("Erro ao excluir ocorr" + CHR(234) + "ncia: " + loException.Message, "Erro")
1677:         ENDTRY
1678:     ENDPROC
1679: 
1680:     *--------------------------------------------------------------------------
1681:     * GrupoKeyPress - Handler KeyPress de txt_4c_Grupo: F4 abre lookup
1682:     *--------------------------------------------------------------------------
1683:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1684:         IF par_nKeyCode = 28  && F4
1685:             THIS.AbrirLookupGrupo()
1686:         ENDIF
1687:     ENDPROC
1688: 
1689:     *--------------------------------------------------------------------------
1690:     * GrupoDblClick - Handler DblClick de txt_4c_Grupo
1691:     *--------------------------------------------------------------------------
1692:     PROCEDURE GrupoDblClick()
1693:         THIS.AbrirLookupGrupo()
1694:     ENDPROC
1695: 
1696:     *--------------------------------------------------------------------------
1697:     * AbrirLookupGrupo - Abre FormBuscaAuxiliar para Grupo (SigCdGcr)
1698:     *--------------------------------------------------------------------------
1699:     PROCEDURE AbrirLookupGrupo()
1700:         LOCAL loc_oPagina
1701:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1702:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1703:             RETURN
1704:         ENDIF
1705:         IF NOT loc_oPagina.txt_4c_Grupo.Enabled
1706:             RETURN
1707:         ENDIF
1708: 
1709:         *-- Guarda de reentrancia SAVE/RESTORE (regra #47): este funil tambem eh
1710:         *-- chamado de F4/DblClick enquanto o LostFocus pode estar no ar; clear
1711:         *-- fixo liberaria a flag cedo demais e abriria um 2o picker.
1712:         *-- Setada DEPOIS dos RETURN de guarda acima, por isso nao trava ligada.
1713:         LOCAL loc_oBusca, loc_lEmLookupAnt
1714:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1715:         THIS.this_lEmLookup = .T.
1716: 
1717:         TRY
1718:             IF USED("cursor_4c_BuscaGrupo")
1719:                 USE IN cursor_4c_BuscaGrupo
1720:             ENDIF
1721:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1722:                 "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", "", ;
1723:                 "Grupo de Conta Corrente")
1724: 
1725:             IF VARTYPE(loc_oBusca) = "O"
1726:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1727:                 loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1728:                 loc_oBusca.Show()
1729:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1730:                     SELECT cursor_4c_BuscaGrupo
1731:                     loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1732:                     loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1733:                 ENDIF
1734:                 loc_oBusca.Release()
1735:             ENDIF
1736:         CATCH TO loException
1737:             MsgErro("Erro ao abrir lookup de Grupo: " + loException.Message, "Erro")
1738:         ENDTRY
1739: 
1740:         IF USED("cursor_4c_BuscaGrupo")
1741:             USE IN cursor_4c_BuscaGrupo
1742:         ENDIF
1743: 
1744:         THIS.this_lEmLookup = loc_lEmLookupAnt
1745:     ENDPROC
1746: 
1747:     *--------------------------------------------------------------------------
1748:     * ContaKeyPress - Handler KeyPress de txt_4c_Contas: F4 abre lookup
1749:     *--------------------------------------------------------------------------
1750:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1751:         IF par_nKeyCode = 28  && F4
1752:             THIS.AbrirLookupConta()
1753:         ENDIF
1754:     ENDPROC
1755: 
1756:     *--------------------------------------------------------------------------
1757:     * ContaDblClick - Handler DblClick de txt_4c_Contas
1758:     *--------------------------------------------------------------------------
1759:     PROCEDURE ContaDblClick()
1760:         THIS.AbrirLookupConta()
1761:     ENDPROC
1762: 
1763:     *--------------------------------------------------------------------------
1764:     * AbrirLookupConta - Abre FormBuscaAuxiliar para Conta (SigCdCli)
1765:     *--------------------------------------------------------------------------
1766:     PROCEDURE AbrirLookupConta()
1767:         LOCAL loc_oPagina
1768:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1769:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1770:             RETURN
1771:         ENDIF
1772:         IF NOT loc_oPagina.txt_4c_Contas.Enabled
1773:             RETURN
1774:         ENDIF
1775: 
1776:         *-- Guarda de reentrancia SAVE/RESTORE - ver AbrirLookupGrupo (regra #47)
1777:         LOCAL loc_oBusca, loc_lEmLookupAnt
1778:         loc_lEmLookupAnt    = THIS.this_lEmLookup
1779:         THIS.this_lEmLookup = .T.
1780: 
1781:         TRY
1782:             IF USED("cursor_4c_BuscaConta")
1783:                 USE IN cursor_4c_BuscaConta
1784:             ENDIF
1785:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1786:                 "SigCdCli", "cursor_4c_BuscaConta", "Iclis", "", ;
1787:                 "Conta Corrente")
1788: 
1789:             IF VARTYPE(loc_oBusca) = "O"
1790:                 loc_oBusca.mAddColuna("Iclis",  "", "Conta")
1791:                 loc_oBusca.mAddColuna("Rclis",  "", "Nome")
1792:                 loc_oBusca.Show()
1793:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
1794:                     SELECT cursor_4c_BuscaConta
1795:                     loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
1796:                     loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
1797:                 ENDIF
1798:                 loc_oBusca.Release()
1799:             ENDIF
1800:         CATCH TO loException
1801:             MsgErro("Erro ao abrir lookup de Conta: " + loException.Message, "Erro")
1802:         ENDTRY
1803: 
1804:         IF USED("cursor_4c_BuscaConta")
1805:             USE IN cursor_4c_BuscaConta
1806:         ENDIF
1807: 
1808:         THIS.this_lEmLookup = loc_lEmLookupAnt
1809:     ENDPROC
1810: 
1811:     *--------------------------------------------------------------------------
1812:     * AtualizarCamposDescricao - Reavalia o "When" legado dos campos de descricao
1813:     *
1814:     * Legado:
1815:     *   Get_Desc_Gru.When = IsEmpty(get_grupos.value) AND Inlist(pcEscolha,"PROCURAR")
1816:     *   Get_Desc_Con.When = IsEmpty(get_contas.value) AND Inlist(pcEscolha,"INSERIR","PROCURAR")
1817:     *
1818:     * O When eh reavaliado pelo VFP a CADA chegada de foco. Aqui a condicao mora
1819:     * num metodo PUBLIC unico (regra #45), chamado em TODO caminho que mexe nos
1820:     * codigos: fim do ConfigurarPaginaDados, HabilitarCampos, LimparCampos,
1821:     * CarregarPaginaDados, os lookups e o InteractiveChange dos codigos.
1822:     * PUBLIC porque eh alvo de BINDEVENT (regra #3).
1823:     *--------------------------------------------------------------------------
1824:     PROCEDURE AtualizarCamposDescricao()
1825:         LOCAL loc_oPagina
1826:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1827: 
1828:         IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Gru", 5)
1829:             loc_oPagina.txt_4c_Desc_Gru.ReadOnly = !THIS.DescGrupoPodeDigitar()
1830:         ENDIF
1831:         IF PEMSTATUS(loc_oPagina, "txt_4c_Desc_Con", 5)
1832:             loc_oPagina.txt_4c_Desc_Con.ReadOnly = !THIS.DescContaPodeDigitar()
1833:         ENDIF
1834:     ENDPROC
1835: 
1836:     *--------------------------------------------------------------------------
1837:     * DescGrupoPodeDigitar - Condicao do Get_Desc_Gru.When legado
1838:     *--------------------------------------------------------------------------
1839:     PROTECTED FUNCTION DescGrupoPodeDigitar()
1840:         LOCAL loc_oPagina, loc_lPode
1841:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1842:         loc_lPode   = .F.
1843: 
1844:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1845:             loc_lPode = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)) AND ;
1846:                         INLIST(THIS.this_cModoAtual, "PROCURAR")
1847:         ENDIF
1848: 
1849:         RETURN loc_lPode
1850:     ENDFUNC
1851: 
1852:     *--------------------------------------------------------------------------
1853:     * DescContaPodeDigitar - Condicao do Get_Desc_Con.When legado
1854:     *--------------------------------------------------------------------------
1855:     PROTECTED FUNCTION DescContaPodeDigitar()
1856:         LOCAL loc_oPagina, loc_lPode
1857:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1858:         loc_lPode   = .F.
1859: 
1860:         IF PEMSTATUS(loc_oPagina, "txt_4c_Contas", 5)
1861:             loc_lPode = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Contas.Value)) AND ;
1862:                         INLIST(THIS.this_cModoAtual, "INSERIR", "PROCURAR")
1863:         ENDIF
1864: 

*-- Linhas 1872 a 2261:
1872:     * setar/limpar a flag dentro do corpo a deixaria ligada nesses caminhos,
1873:     * matando o lookup pelo resto da vida do form.
1874:     *--------------------------------------------------------------------------
1875:     PROCEDURE ValidarDescGrupoLostFocus
1876:         IF THIS.this_lEmLookup
1877:             RETURN
1878:         ENDIF
1879:         THIS.this_lEmLookup = .T.
1880:         THIS.ValidarDescGrupoLostFocusExec()
1881:         THIS.this_lEmLookup = .F.
1882:     ENDPROC
1883: 
1884:     *--------------------------------------------------------------------------
1885:     * ValidarDescGrupoLostFocusExec - Corpo do Valid de Get_Desc_Gru
1886:     *
1887:     * Legado: fAcessoContab(Usuar, 'C', this.value, get_grupos, get_desc_gru).
1888:     * O pTip = "C" do legado busca por SigCdGcr.Codigos (ver utils\functions.prg:
1889:     * "pTip - Tipo busca: C=Codigo, D=Descricao") - TRANSCRITO como esta, sem
1890:     * reescrever para "D" (regra #17). Eh divergencia PROPOSITAL do legado em
1891:     * relacao ao Get_Desc_Con, que passa "D"; o efeito util eh o mesmo porque o
1892:     * FormBuscaAuxiliar cai no fallback show-all quando nada casa, e a escolha no
1893:     * picker preenche codigo + descricao.
1894:     * fAcessoContab/fAcessoContas NAO servem como handler de lookup: elas
1895:     * auto-populam o primeiro registro sem o usuario escolher.
1896:     *--------------------------------------------------------------------------
1897:     PROCEDURE ValidarDescGrupoLostFocusExec
1898:         LOCAL loc_oPagina, loc_cTexto, loc_cSQL, loc_nRes, loc_oBusca
1899:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1900: 
1901:         *-- Campo ReadOnly ainda RECEBE foco e dispara LostFocus: reavaliar o When
1902:         IF NOT THIS.DescGrupoPodeDigitar()
1903:             RETURN
1904:         ENDIF
1905: 
1906:         loc_cTexto = ALLTRIM(loc_oPagina.txt_4c_Desc_Gru.Value)
1907:         IF EMPTY(loc_cTexto)
1908:             RETURN
1909:         ENDIF
1910: 
1911:         TRY
1912:             loc_cSQL = "SELECT Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cTexto)
1913:             IF USED("cursor_4c_BuscaGrupo")
1914:                 USE IN cursor_4c_BuscaGrupo
1915:             ENDIF
1916:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
1917: 
1918:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1919:                 SELECT cursor_4c_BuscaGrupo
1920:                 loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1921:                 loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1922:             ELSE
1923:                 IF USED("cursor_4c_BuscaGrupo")
1924:                     USE IN cursor_4c_BuscaGrupo
1925:                 ENDIF
1926:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1927:                     "SigCdGcr", "cursor_4c_BuscaGrupo", "Codigos", loc_cTexto, ;
1928:                     "Grupo de Conta Corrente")
1929:                 IF VARTYPE(loc_oBusca) = "O"
1930:                     IF !loc_oBusca.this_lAchouRegistro
1931:                         loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1932:                         loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1933:                         loc_oBusca.Show()
1934:                     ENDIF
1935:                     *-- Nada escolhido: o texto digitado FICA (regra #50) - o legado
1936:                     *-- nao avisa nem limpa; limpar deixaria o usuario sem saida.
1937:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo") AND RECCOUNT("cursor_4c_BuscaGrupo") > 0
1938:                         SELECT cursor_4c_BuscaGrupo
1939:                         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(Codigos)
1940:                         loc_oPagina.txt_4c_Desc_Gru.Value = ALLTRIM(Descrs)
1941:                     ENDIF
1942:                     loc_oBusca.Release()
1943:                 ENDIF
1944:             ENDIF
1945:         CATCH TO loException
1946:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o do grupo: " + loException.Message, "Erro")
1947:         ENDTRY
1948: 
1949:         IF USED("cursor_4c_BuscaGrupo")
1950:             USE IN cursor_4c_BuscaGrupo
1951:         ENDIF
1952: 
1953:         *-- Codigo preenchido -> o When fecha o campo de descricao
1954:         THIS.AtualizarCamposDescricao()
1955:     ENDPROC
1956: 
1957:     *--------------------------------------------------------------------------
1958:     * DescGrupoKeyPress - F4 no campo de descricao abre o picker de Grupo
1959:     *--------------------------------------------------------------------------
1960:     PROCEDURE DescGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1961:         IF par_nKeyCode = 28  && F4
1962:             THIS.AbrirLookupDescGrupo()
1963:         ENDIF
1964:     ENDPROC
1965: 
1966:     *--------------------------------------------------------------------------
1967:     * DescGrupoDblClick - Handler DblClick de txt_4c_Desc_Gru
1968:     *--------------------------------------------------------------------------
1969:     PROCEDURE DescGrupoDblClick()
1970:         THIS.AbrirLookupDescGrupo()
1971:     ENDPROC
1972: 
1973:     *--------------------------------------------------------------------------
1974:     * AbrirLookupDescGrupo - Picker de Grupo acionado pelo campo de descricao
1975:     * So age quando o When legado permite digitar ali; o picker em si eh o mesmo
1976:     * do campo de codigo (AbrirLookupGrupo), que ja traz a guarda SAVE/RESTORE.
1977:     *--------------------------------------------------------------------------
1978:     PROCEDURE AbrirLookupDescGrupo()
1979:         IF NOT THIS.DescGrupoPodeDigitar()
1980:             RETURN
1981:         ENDIF
1982:         THIS.AbrirLookupGrupo()
1983:         THIS.AtualizarCamposDescricao()
1984:     ENDPROC
1985: 
1986:     *--------------------------------------------------------------------------
1987:     * ValidarDescContaLostFocus - Valid de Get_Desc_Con (2a porta de entrada)
1988:     * Wrapper FINO pelo mesmo motivo do ValidarDescGrupoLostFocus (regra #47).
1989:     *--------------------------------------------------------------------------
1990:     PROCEDURE ValidarDescContaLostFocus
1991:         IF THIS.this_lEmLookup
1992:             RETURN
1993:         ENDIF
1994:         THIS.this_lEmLookup = .T.
1995:         THIS.ValidarDescContaLostFocusExec()
1996:         THIS.this_lEmLookup = .F.
1997:     ENDPROC
1998: 
1999:     *--------------------------------------------------------------------------
2000:     * ValidarDescContaLostFocusExec - Corpo do Valid de Get_Desc_Con
2001:     *
2002:     * Legado: fAcessoContas(Usuar, get_grupos.value, 'D', this.value,
2003:     *                       get_contas, get_desc_con)
2004:     * - pTip = "D" -> busca pela DESCRICAO (SigCdCli.rclis)
2005:     * - pGrp = get_grupos.value -> a consulta eh FILTRADA pelo grupo corrente
2006:     *   ("And a.Grupos = <grupo>" em utils\functions.prg), por isso o filtro
2007:     *   adicional do FormBuscaAuxiliar (9o argumento).
2008:     *--------------------------------------------------------------------------
2009:     PROCEDURE ValidarDescContaLostFocusExec
2010:         LOCAL loc_oPagina, loc_cTexto, loc_cGrupo, loc_cFiltro
2011:         LOCAL loc_cSQL, loc_nRes, loc_oBusca
2012:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2013: 
2014:         IF NOT THIS.DescContaPodeDigitar()
2015:             RETURN
2016:         ENDIF
2017: 
2018:         loc_cTexto = ALLTRIM(loc_oPagina.txt_4c_Desc_Con.Value)
2019:         IF EMPTY(loc_cTexto)
2020:             RETURN
2021:         ENDIF
2022: 
2023:         loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2024:         loc_cFiltro = ""
2025:         IF !EMPTY(loc_cGrupo)
2026:             loc_cFiltro = "grupos = " + EscaparSQL(PADR(loc_cGrupo, 10))
2027:         ENDIF
2028: 
2029:         TRY
2030:             loc_cSQL = "SELECT Iclis, Rclis FROM SigCdCli" + ;
2031:                        " WHERE RTRIM(Rclis) = " + EscaparSQL(loc_cTexto)
2032:             IF !EMPTY(loc_cFiltro)
2033:                 loc_cSQL = loc_cSQL + " AND " + loc_cFiltro
2034:             ENDIF
2035:             IF USED("cursor_4c_BuscaConta")
2036:                 USE IN cursor_4c_BuscaConta
2037:             ENDIF
2038:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
2039: 
2040:             IF loc_nRes >= 0 AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") = 1
2041:                 SELECT cursor_4c_BuscaConta
2042:                 loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2043:                 loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2044:             ELSE
2045:                 IF USED("cursor_4c_BuscaConta")
2046:                     USE IN cursor_4c_BuscaConta
2047:                 ENDIF
2048:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2049:                     "SigCdCli", "cursor_4c_BuscaConta", "Rclis", loc_cTexto, ;
2050:                     "Conta Corrente", .F., .F., loc_cFiltro)
2051:                 IF VARTYPE(loc_oBusca) = "O"
2052:                     IF !loc_oBusca.this_lAchouRegistro
2053:                         loc_oBusca.mAddColuna("Iclis", "", "Conta")
2054:                         loc_oBusca.mAddColuna("Rclis", "", "Nome")
2055:                         loc_oBusca.Show()
2056:                     ENDIF
2057:                     *-- Nada escolhido: o texto digitado FICA (regra #50)
2058:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta") AND RECCOUNT("cursor_4c_BuscaConta") > 0
2059:                         SELECT cursor_4c_BuscaConta
2060:                         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(Iclis)
2061:                         loc_oPagina.txt_4c_Desc_Con.Value = ALLTRIM(Rclis)
2062:                     ENDIF
2063:                     loc_oBusca.Release()
2064:                 ENDIF
2065:             ENDIF
2066:         CATCH TO loException
2067:             MsgErro("Erro ao validar descri" + CHR(231) + CHR(227) + "o da conta: " + loException.Message, "Erro")
2068:         ENDTRY
2069: 
2070:         IF USED("cursor_4c_BuscaConta")
2071:             USE IN cursor_4c_BuscaConta
2072:         ENDIF
2073: 
2074:         THIS.AtualizarCamposDescricao()
2075:     ENDPROC
2076: 
2077:     *--------------------------------------------------------------------------
2078:     * DescContaKeyPress - F4 no campo de descricao abre o picker de Conta
2079:     *--------------------------------------------------------------------------
2080:     PROCEDURE DescContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2081:         IF par_nKeyCode = 28  && F4
2082:             THIS.AbrirLookupDescConta()
2083:         ENDIF
2084:     ENDPROC
2085: 
2086:     *--------------------------------------------------------------------------
2087:     * DescContaDblClick - Handler DblClick de txt_4c_Desc_Con
2088:     *--------------------------------------------------------------------------
2089:     PROCEDURE DescContaDblClick()
2090:         THIS.AbrirLookupDescConta()
2091:     ENDPROC
2092: 
2093:     *--------------------------------------------------------------------------
2094:     * AbrirLookupDescConta - Picker de Conta acionado pelo campo de descricao
2095:     *--------------------------------------------------------------------------
2096:     PROCEDURE AbrirLookupDescConta()
2097:         IF NOT THIS.DescContaPodeDigitar()
2098:             RETURN
2099:         ENDIF
2100:         THIS.AbrirLookupConta()
2101:         THIS.AtualizarCamposDescricao()
2102:     ENDPROC
2103: 
2104:     *--------------------------------------------------------------------------
2105:     * TornarControlesVisiveis - Percorre controles recursivamente definindo Visible=.T.
2106:     *--------------------------------------------------------------------------
2107:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2108:         LOCAL loc_nI, loc_oObjeto, loc_nP
2109: 
2110:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2111:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2112: 
2113:             IF VARTYPE(loc_oObjeto) = "O"
2114:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2115:                     loc_oObjeto.Visible = .T.
2116:                 ENDIF
2117: 
2118:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2119:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2120:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2121:                     ENDFOR
2122:                 ENDIF
2123: 
2124:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2125:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2126:                 ENDIF
2127:             ENDIF
2128:         ENDFOR
2129:     ENDPROC
2130: 
2131:     *--------------------------------------------------------------------------
2132:     * FormParaBO - Transfere valores dos campos da Page2 para as propriedades do BO
2133:     *--------------------------------------------------------------------------
2134:     PROTECTED PROCEDURE FormParaBO()
2135:         LOCAL loc_oPagina
2136:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2137: 
2138:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
2139:             RETURN
2140:         ENDIF
2141: 
2142:         THIS.this_oBusinessObject.this_cGrupos    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
2143:         THIS.this_oBusinessObject.this_cContas    = ALLTRIM(loc_oPagina.txt_4c_Contas.Value)
2144:         THIS.this_oBusinessObject.this_cGruContas = PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), 10) + ;
2145:                                                     PADR(ALLTRIM(loc_oPagina.txt_4c_Contas.Value), 10)
2146:     ENDPROC
2147: 
2148:     *--------------------------------------------------------------------------
2149:     * BOParaForm - Transfere valores do BO para os campos da Page2
2150:     *--------------------------------------------------------------------------
2151:     PROTECTED PROCEDURE BOParaForm()
2152:         LOCAL loc_oPagina
2153:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2154: 
2155:         IF NOT PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
2156:             RETURN
2157:         ENDIF
2158: 
2159:         loc_oPagina.txt_4c_Grupo.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cGrupos)
2160:         loc_oPagina.txt_4c_Contas.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cContas)
2161:         loc_oPagina.txt_4c_Desc_Gru.Value = ""
2162:         loc_oPagina.txt_4c_Desc_Con.Value = ""
2163:         THIS.IniciarDescricoes()
2164:     ENDPROC
2165: 
2166:     *--------------------------------------------------------------------------
2167:     * AjustarBotoesPorModo - Habilita/desabilita botoes de Page1 conforme dados
2168:     *--------------------------------------------------------------------------
2169:     PROCEDURE AjustarBotoesPorModo()
2170:         LOCAL loc_oPagina, loc_lTemRegistro
2171:         loc_oPagina      = THIS.pgf_4c_Paginas.Page1
2172:         loc_lTemRegistro = USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
2173: 
2174:         IF NOT PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
2175:             RETURN
2176:         ENDIF
2177: 
2178:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
2179:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir.Enabled = .T.
2180:         ENDIF
2181:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Visualizar", 5)
2182:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
2183:         ENDIF
2184:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Alterar", 5)
2185:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
2186:         ENDIF
2187:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
2188:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
2189:         ENDIF
2190:         IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Buscar", 5)
2191:             loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar.Enabled = .T.
2192:         ENDIF
2193:     ENDPROC
2194: 
2195:     *--------------------------------------------------------------------------
2196:     * Destroy - Libera o Business Object e chama destruicao da classe pai
2197:     *--------------------------------------------------------------------------
2198:     PROCEDURE Destroy()
2199:         *-- O form NAO declara DataSession = 2, entao roda na sessao CORRENTE: os
2200:         *-- cursores criados aqui SOBREVIVEM ao Release e ficariam abertos na
2201:         *-- sessao global, colidindo na proxima abertura da tela.
2202:         TRY
2203:             IF USED("cursor_4c_OcoLocal")
2204:                 USE IN cursor_4c_OcoLocal
2205:             ENDIF
2206:             IF USED("cursor_4c_Dados")
2207:                 USE IN cursor_4c_Dados
2208:             ENDIF
2209:             IF USED("cursor_4c_Ocorrencias")
2210:                 USE IN cursor_4c_Ocorrencias
2211:             ENDIF
2212:             IF USED("cursor_4c_TmpGrupo")
2213:                 USE IN cursor_4c_TmpGrupo
2214:             ENDIF
2215:             IF USED("cursor_4c_TmpConta")
2216:                 USE IN cursor_4c_TmpConta
2217:             ENDIF
2218:             IF USED("cursor_4c_BuscaGrupo")
2219:                 USE IN cursor_4c_BuscaGrupo
2220:             ENDIF
2221:             IF USED("cursor_4c_BuscaConta")
2222:                 USE IN cursor_4c_BuscaConta
2223:             ENDIF
2224:             IF USED("cursor_4c_BuscaCoco")
2225:                 USE IN cursor_4c_BuscaCoco
2226:             ENDIF
2227:         CATCH TO loc_oErro
2228:             MsgErro(loc_oErro.Message, "FormSIGPRLNC.Destroy")
2229:         ENDTRY
2230: 
2231:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2232:             THIS.this_oBusinessObject = .NULL.
2233:         ENDIF
2234:         DODEFAULT()
2235:     ENDPROC
2236: 
2237: ENDDEFINE
2238: 
2239: *==============================================================================
2240: * TextBoxOcorrencia_4c - celula Ocorrencia da grd_4c_Ocorrencias (Erro191)
2241: * Transcreve Gradeoco.Column2.Text1 do legado: When guarda o valor anterior
2242: * (ThisForm.CodAnt) e Valid delega ao form. Eventos embutidos na classe porque
2243: * BINDEVENT em Valid de TextBox dentro de Column nao dispara de forma confiavel.
2244: *==============================================================================
2245: DEFINE CLASS TextBoxOcorrencia_4c AS TextBox
2246:     this_cValorAnterior = ""
2247: 
2248:     PROCEDURE When()
2249:         THIS.this_cValorAnterior = NVL(THIS.Value, "")
2250:         RETURN .T.
2251:     ENDPROC
2252: 
2253:     PROCEDURE Valid()
2254:         LOCAL loc_lRetorno
2255:         loc_lRetorno = .T.
2256:         IF PEMSTATUS(THISFORM, "ValidarOcorrenciaGrade", 5)
2257:             loc_lRetorno = THISFORM.ValidarOcorrenciaGrade(THIS)
2258:         ENDIF
2259:         RETURN loc_lRetorno
2260:     ENDPROC
2261: ENDDEFINE


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

