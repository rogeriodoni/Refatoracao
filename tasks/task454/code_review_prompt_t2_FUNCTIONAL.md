# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_BOTOESACAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormJrn.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2091 linhas total):

*-- Linhas 34 a 172:
34:     this_cMesAtual = ""
35: 
36:     *==========================================================================
37:     * Init - FormBase.Init() ja chama InicializarForm() automaticamente
38:     *==========================================================================
39:     PROCEDURE Init()
40:         RETURN DODEFAULT()
41:     ENDPROC
42: 
43:     *==========================================================================
44:     * InicializarForm - Configura estrutura completa (chamado por FormBase)
45:     *==========================================================================
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso
48:         loc_lSucesso = .F.
49: 
50:         TRY
51:             THIS.this_oBusinessObject = CREATEOBJECT("JrnBO")
52: 
53:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                     THIS.CarregarLista()
60:                 ENDIF
61: 
62:                 THIS.pgf_4c_Paginas.Visible = .T.
63:                 THIS.pgf_4c_Paginas.ActivePage = 1
64:                 THIS.this_cModoAtual = "LISTA"
65:                 loc_lSucesso = .T.
66:             ELSE
67:                 MsgErro("Erro ao criar JrnBO." + CHR(13) + ;
68:                         "VARTYPE: " + VARTYPE(THIS.this_oBusinessObject), ;
69:                         "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
70:             ENDIF
71:         CATCH TO loc_oErro
72:             MsgErro("Erro em FormJrn.InicializarForm:" + CHR(13) + ;
73:                     loc_oErro.Message + CHR(13) + ;
74:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
75:         ENDTRY
76: 
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * ConfigurarPageFrame - PageFrame Top=-29 oculta abas (compensar +29 no Top)
82:     *==========================================================================
83:     PROTECTED PROCEDURE ConfigurarPageFrame()
84:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
85: 
86:         WITH THIS.pgf_4c_Paginas
87:             .PageCount  = 2
88:             .Top        = -29
89:             .Left       = 0
90:             .Width      = THIS.Width
91:             .Height     = THIS.Height + 29
92:             .Tabs       = .F.
93:             .TabStretch = 1
94:             .Visible    = .T.
95:         ENDWITH
96: 
97:         WITH THIS.pgf_4c_Paginas.Page1
98:             .Caption   = "Lista"
99:             .BackColor = RGB(255, 255, 255)
100:         ENDWITH
101: 
102:         WITH THIS.pgf_4c_Paginas.Page2
103:             .Caption   = "Dados"
104:             .BackColor = RGB(255, 255, 255)
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()
108:         THIS.ConfigurarPaginaDados()
109:     ENDPROC
110: 
111:     *==========================================================================
112:     * ConfigurarPaginaLista - Page1 com cabecalho, botoes CRUD e Grid
113:     *
114:     * Referencia legado (SIGCDJRN 834px):
115:     *   cntSombra   : Top=1,  Left=-1, Width=840, Height=80
116:     *   Grupo_Op    : Top=-1, Left=375 (Width~390)  -> canonico Left=542
117:     *   Grupo_Saida : Top=-1, Left=750               -> canonico Left=917
118:     *   Command1    : Top=4,  Left=305 ("Copia Mes") -> Left=462 (proporcional)
119:     *   Grade       : Top=96, Left=32, Width=783, Height=470
120:     * Compensacao PageFrame (+29): grade.Top = 96+29 = 125
121:     *==========================================================================
122:     PROTECTED PROCEDURE ConfigurarPaginaLista()
123:         LOCAL loc_oPagina, loc_oGrid
124:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
125: 
126:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
127: 
128:         *-- Cabecalho cinza (cntSombra.Top=1 -> 1+29=30)
129:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
130:         WITH loc_oPagina.cnt_4c_Cabecalho
131:             .Top         = 30
132:             .Left        = 0
133:             .Width       = THIS.Width
134:             .Height      = 80
135:             .BackColor   = RGB(100, 100, 100)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
141:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
142:             .Caption   = "Jornadas de Trabalho"
143:             .Top       = 15
144:             .Left      = 11
145:             .Width     = THIS.Width - 20
146:             .Height    = 40
147:             .FontName  = "Tahoma"
148:             .FontSize  = 16
149:             .FontBold  = .T.
150:             .ForeColor = RGB(0, 0, 0)
151:             .BackStyle = 0
152:             .AutoSize  = .F.
153:             .Visible   = .T.
154:         ENDWITH
155: 
156:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
157:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
158:             .Caption   = "Jornadas de Trabalho"
159:             .Top       = 18
160:             .Left      = 10
161:             .Width     = THIS.Width - 20
162:             .Height    = 46
163:             .FontName  = "Tahoma"
164:             .FontSize  = 16
165:             .FontBold  = .T.
166:             .ForeColor = RGB(255, 255, 255)
167:             .BackStyle = 0
168:             .AutoSize  = .F.
169:             .Visible   = .T.
170:         ENDWITH
171: 
172:         *----------------------------------------------------------------------

*-- Linhas 207 a 418:
207:             .AutoSize        = .F.
208:             .Visible         = .T.
209:         ENDWITH
210:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
211: 
212:         *-- Visualizar (Consultar.Left=80)
213:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
214:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
215:             .Caption         = "Visualizar"
216:             .Top             = 5
217:             .Left            = 80
218:             .Width           = 75
219:             .Height          = 75
220:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
221:             .PicturePosition = 13
222:             .FontName        = "Tahoma"
223:             .FontSize        = 8
224:             .FontBold        = .T.
225:             .FontItalic      = .T.
226:             .ForeColor       = RGB(90, 90, 90)
227:             .BackColor       = RGB(255, 255, 255)
228:             .Themes          = .F.
229:             .SpecialEffect   = 0
230:             .MousePointer    = 15
231:             .WordWrap        = .T.
232:             .AutoSize        = .F.
233:             .Visible         = .T.
234:         ENDWITH
235:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
236: 
237:         *-- Alterar (Left=155)
238:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
239:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
240:             .Caption         = "Alterar"
241:             .Top             = 5
242:             .Left            = 155
243:             .Width           = 75
244:             .Height          = 75
245:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
246:             .PicturePosition = 13
247:             .FontName        = "Tahoma"
248:             .FontSize        = 8
249:             .FontBold        = .T.
250:             .FontItalic      = .T.
251:             .ForeColor       = RGB(90, 90, 90)
252:             .BackColor       = RGB(255, 255, 255)
253:             .Themes          = .F.
254:             .SpecialEffect   = 0
255:             .MousePointer    = 15
256:             .WordWrap        = .T.
257:             .AutoSize        = .F.
258:             .Visible         = .T.
259:         ENDWITH
260:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
261: 
262:         *-- Excluir (Left=230)
263:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
264:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
265:             .Caption         = "Excluir"
266:             .Top             = 5
267:             .Left            = 230
268:             .Width           = 75
269:             .Height          = 75
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
271:             .PicturePosition = 13
272:             .FontName        = "Tahoma"
273:             .FontSize        = 8
274:             .FontBold        = .T.
275:             .FontItalic      = .T.
276:             .ForeColor       = RGB(90, 90, 90)
277:             .BackColor       = RGB(255, 255, 255)
278:             .Themes          = .F.
279:             .SpecialEffect   = 0
280:             .MousePointer    = 15
281:             .WordWrap        = .T.
282:             .AutoSize        = .F.
283:             .Visible         = .T.
284:         ENDWITH
285:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
286: 
287:         *-- Buscar (Procurar.Left=305)
288:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
289:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
290:             .Caption         = "Buscar"
291:             .Top             = 5
292:             .Left            = 305
293:             .Width           = 75
294:             .Height          = 75
295:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
296:             .PicturePosition = 13
297:             .FontName        = "Tahoma"
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
310:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
311: 
312:         *----------------------------------------------------------------------
313:         * Container saida - padrao canonico CLAUDE.md #10
314:         * Grupo_Saida.Left=750, Top=-1 -> canonico Left=917, Top=28
315:         *----------------------------------------------------------------------
316:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
317:         WITH loc_oPagina.cnt_4c_Saida
318:             .Top         = 28
319:             .Left        = 917
320:             .Width       = 90
321:             .Height      = 85
322:             .BackStyle   = 0
323:             .BorderWidth = 0
324:             .Visible     = .T.
325:         ENDWITH
326: 
327:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
328:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
329:             .Caption         = "Encerrar"
330:             .Top             = 5
331:             .Left            = 5
332:             .Width           = 75
333:             .Height          = 75
334:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
335:             .PicturePosition = 13
336:             .FontName        = "Tahoma"
337:             .FontSize        = 8
338:             .FontBold        = .T.
339:             .FontItalic      = .T.
340:             .ForeColor       = RGB(90, 90, 90)
341:             .BackColor       = RGB(255, 255, 255)
342:             .Themes          = .F.
343:             .SpecialEffect   = 0
344:             .MousePointer    = 15
345:             .WordWrap        = .T.
346:             .AutoSize        = .F.
347:             .Visible         = .T.
348:         ENDWITH
349:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
350: 
351:         *----------------------------------------------------------------------
352:         * Botao "Copia Mes" (Command1 standalone no legado)
353:         * Original: Top=4, Left=305 em form 834px
354:         * Novo:     Top=4+29=33, Left proporcional ~462 (a esquerda de 542)
355:         *----------------------------------------------------------------------
356:         loc_oPagina.AddObject("cmd_4c_CopiarMes", "CommandButton")
357:         WITH loc_oPagina.cmd_4c_CopiarMes
358:             .Caption         = "Copia M" + CHR(234) + "s"
359:             .Top             = 33
360:             .Left            = 462
361:             .Width           = 75
362:             .Height          = 75
363:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
364:             .PicturePosition = 13
365:             .FontName        = "Tahoma"
366:             .FontSize        = 8
367:             .FontBold        = .T.
368:             .FontItalic      = .T.
369:             .ForeColor       = RGB(90, 90, 90)
370:             .BackColor       = RGB(255, 255, 255)
371:             .Themes          = .F.
372:             .SpecialEffect   = 0
373:             .MousePointer    = 15
374:             .WordWrap        = .T.
375:             .AutoSize        = .F.
376:             .Visible         = .T.
377:         ENDWITH
378:         BINDEVENT(loc_oPagina.cmd_4c_CopiarMes, "Click", THIS, "BtnCopiarMesClick")
379: 
380:         *----------------------------------------------------------------------
381:         * Grid (Grade no legado: Top=96, Left=32, Width=783, Height=470)
382:         * Novo: Top=96+29=125, Left=32, Width=880 (ate cnt_4c_Saida.Left=917)
383:         * 14 colunas: iclis, cargos, refers, hora01-04, cDom-cSab
384:         *
385:         * ColumnCount FORA do WITH (Problema 36: nao criar colunas dentro de WITH)
386:         * ControlSource redefinido em CarregarLista apos RecordSource (Problema 48)
387:         *----------------------------------------------------------------------
388:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
389:         loc_oGrid = loc_oPagina.grd_4c_Lista
390: 
391:         loc_oGrid.ColumnCount = 14
392: 
393:         WITH loc_oGrid
394:             .Top                = 125
395:             .Left               = 32
396:             .Width              = 880
397:             .Height             = 470
398:             .FontName           = "Verdana"
399:             .FontSize           = 8
400:             .ForeColor          = RGB(90, 90, 90)
401:             .BackColor          = RGB(255, 255, 255)
402:             .GridLineColor      = RGB(238, 238, 238)
403:             .HighlightBackColor = RGB(255, 255, 255)
404:             .HighlightForeColor = RGB(15, 41, 104)
405:             .HighlightStyle     = 2
406:             .DeleteMark         = .F.
407:             .RecordMark         = .F.
408:             .RowHeight          = 16
409:             .ScrollBars         = 2
410:             .GridLines          = 3
411:             .Visible            = .T.
412: 
413:             .Column1.Width           = 80
414:             .Column1.Alignment       = 0
415:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
416: 
417:             .Column2.Width           = 80
418:             .Column2.Alignment       = 0

*-- Linhas 593 a 673:
593:             .SpecialEffect = 0
594:             .Visible       = .T.
595:         ENDWITH
596:         BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesOK, "Click", THIS, "CopiaMesConfirmarClick")
597: 
598:         *-- Botao Cancelar (Command1 no legado: Top=80, Left=213, Width=40, Height=40)
599:         loc_oPagina.cnt_4c_CopiaMes.AddObject("cmd_4c_CopiarMesX", "CommandButton")
600:         WITH loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX
601:             .Caption       = "X"
602:             .Top           = 80
603:             .Left          = 213
604:             .Width         = 40
605:             .Height        = 40
606:             .FontName      = "Tahoma"
607:             .FontSize      = 8
608:             .FontBold      = .T.
609:             .ForeColor     = RGB(180, 0, 0)
610:             .BackColor     = RGB(255, 255, 255)
611:             .Themes        = .F.
612:             .SpecialEffect = 0
613:             .Visible       = .T.
614:         ENDWITH
615:         BINDEVENT(loc_oPagina.cnt_4c_CopiaMes.cmd_4c_CopiarMesX, "Click", THIS, "CopiaMesCancelarClick")
616: 
617:         THIS.TornarControlesVisiveis(loc_oPagina)
618:     ENDPROC
619: 
620:     *==========================================================================
621:     * ConfigurarPaginaDados - Page2 completa com todos os campos
622:     *
623:     * Referencia legado (834px, sem compensacao +29):
624:     *   Grupo_Salva : Left=635, Top=13  -> novo: Left=760, Top=42 (13+29)
625:     *   getCodCli   : Left=148, Top=163 -> Top=192 (+29)
626:     *   getDesCli   : Left=232, Top=163 -> Top=192 (+29), Width=360
627:     *   getCodCgo   : Left=148, Top=189 -> Top=218 (+29)
628:     *   cboMes/Ano  : Left=148/232, Top=136 -> Top=165 (+29)
629:     *   getHora01-04: Top=246 -> Top=275 (+29)
630:     *   checkboxes  : Top=295/318 -> Top=324/347 (+29)
631:     *   Shape(dias) : Top=287  -> Top=316 (+29), Width=433, Height=57
632:     *==========================================================================
633:     PROTECTED PROCEDURE ConfigurarPaginaDados()
634:         LOCAL loc_oPagina, loc_cAnos, loc_n, loc_cRowMes
635:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
636:         loc_cAnos   = ""
637:         loc_cRowMes = "Janeiro,01,Fevereiro,02,Mar" + CHR(231) + "o,03,Abril,04,Maio,05," + ;
638:                       "Junho,06,Julho,07,Agosto,08,Setembro,09,Outubro,10," + ;
639:                       "Novembro,11,Dezembro,12"
640: 
641:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
642: 
643:         *-- Anos: lista dinamica (ano-5 ate ano+5)
644:         FOR loc_n = YEAR(DATE()) - 5 TO YEAR(DATE()) + 5
645:             IF !EMPTY(loc_cAnos)
646:                 loc_cAnos = loc_cAnos + ","
647:             ENDIF
648:             loc_cAnos = loc_cAnos + STR(loc_n, 4)
649:         ENDFOR
650: 
651:         *----------------------------------------------------------------------
652:         * Container botoes acao (Grupo_Salva: Left=635->760, Top=13->42)
653:         * Confirmar.Left=5, Cancelar.Left=85, ambos Width=75, Height=75
654:         *----------------------------------------------------------------------
655:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
656:         WITH loc_oPagina.cnt_4c_BotoesAcao
657:             .Top         = 42
658:             .Left        = 760
659:             .Width       = 165
660:             .Height      = 85
661:             .BackStyle = 0
662:             .BorderWidth = 0
663:             .Visible     = .T.
664:         ENDWITH
665: 
666:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
667:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
668:             .Caption         = "Confirmar"
669:             .Top             = 5
670:             .Left            = 5
671:             .Width           = 75
672:             .Height          = 75
673:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"

*-- Linhas 685 a 752:
685:             .AutoSize        = .F.
686:             .Visible         = .T.
687:         ENDWITH
688:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
689: 
690:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
691:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
692:             .Caption         = "Encerrar"
693:             .Top             = 5
694:             .Left            = 85
695:             .Width           = 75
696:             .Height          = 75
697:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
698:             .PicturePosition = 13
699:             .FontName        = "Tahoma"
700:             .FontSize        = 8
701:             .FontBold        = .T.
702:             .FontItalic      = .T.
703:             .ForeColor       = RGB(90, 90, 90)
704:             .BackColor       = RGB(255, 255, 255)
705:             .Themes          = .F.
706:             .SpecialEffect   = 0
707:             .MousePointer    = 15
708:             .WordWrap        = .T.
709:             .AutoSize        = .F.
710:             .Visible         = .T.
711:         ENDWITH
712:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
713: 
714:         *----------------------------------------------------------------------
715:         * Referencia: label + combo Mes + combo Ano
716:         * Label8 "Referencia :" Left=83, Top=139 -> Top=168
717:         * cboMes: Left=148, Top=136 -> Top=165
718:         * cboAno: Left=232, Top=136 -> Top=165
719:         *----------------------------------------------------------------------
720:         loc_oPagina.AddObject("lbl_4c_LblReferencia", "Label")
721:         WITH loc_oPagina.lbl_4c_LblReferencia
722:             .Caption   = "Refer" + CHR(234) + "ncia :"
723:             .Top       = 168
724:             .Left      = 83
725:             .Height    = 15
726:             .Width     = 65
727:             .FontName  = "Tahoma"
728:             .FontSize  = 8
729:             .BackStyle = 0
730:             .ForeColor = RGB(0, 90, 90)
731:             .AutoSize  = .F.
732:             .Visible   = .T.
733:         ENDWITH
734: 
735:         loc_oPagina.AddObject("cbo_4c_CboMes", "ComboBox")
736:         WITH loc_oPagina.cbo_4c_CboMes
737:             .Top             = 165
738:             .Left            = 148
739:             .Width           = 80
740:             .Height          = 24
741:             .BoundColumn     = 2
742:             .ColumnCount     = 2
743:             .ColumnWidths    = "0,70"
744:             .RowSourceType   = 1
745:             .RowSource       = loc_cRowMes
746:             .Style           = 2
747:             .FontName        = "Tahoma"
748:             .FontSize        = 8
749:             .Visible         = .T.
750:         ENDWITH
751: 
752:         loc_oPagina.AddObject("cbo_4c_CboAno", "ComboBox")

*-- Linhas 799 a 896:
799:             .BackColor           = RGB(255, 255, 255)
800:             .Visible             = .T.
801:         ENDWITH
802:         BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress", THIS, "ValidarCodCli")
803:         BINDEVENT(loc_oPagina.txt_4c_CodCli, "KeyPress",  THIS, "TeclaLookupCodCli")
804: 
805:         loc_oPagina.AddObject("txt_4c_DesCli", "TextBox")
806:         WITH loc_oPagina.txt_4c_DesCli
807:             .Top                 = 192
808:             .Left                = 232
809:             .Width               = 360
810:             .Height              = 23
811:             .Value               = ""
812:             .Alignment           = 0
813:             .FontName            = "Tahoma"
814:             .FontSize            = 8
815:             .DisabledBackColor   = RGB(255, 255, 255)
816:             .BackColor           = RGB(255, 255, 255)
817:             .Visible             = .T.
818:         ENDWITH
819:         BINDEVENT(loc_oPagina.txt_4c_DesCli, "KeyPress", THIS, "ValidarDesCli")
820:         BINDEVENT(loc_oPagina.txt_4c_DesCli, "KeyPress",  THIS, "TeclaLookupDesCli")
821: 
822:         *----------------------------------------------------------------------
823:         * Cargo: label + codigo
824:         * Label3 "Cargo :" Left=106, Top=192 -> Top=221
825:         * getCodCgo: Left=148, Top=189 -> Top=218, Width=80, Height=23
826:         *----------------------------------------------------------------------
827:         loc_oPagina.AddObject("lbl_4c_LblCargo", "Label")
828:         WITH loc_oPagina.lbl_4c_LblCargo
829:             .Caption   = "Cargo :"
830:             .Top       = 221
831:             .Left      = 106
832:             .Height    = 15
833:             .Width     = 40
834:             .FontName  = "Tahoma"
835:             .FontSize  = 8
836:             .BackStyle = 0
837:             .ForeColor = RGB(0, 90, 90)
838:             .AutoSize  = .F.
839:             .Visible   = .T.
840:         ENDWITH
841: 
842:         loc_oPagina.AddObject("txt_4c_CodCgo", "TextBox")
843:         WITH loc_oPagina.txt_4c_CodCgo
844:             .Top                 = 218
845:             .Left                = 148
846:             .Width               = 80
847:             .Height              = 23
848:             .Value               = ""
849:             .FontName            = "Tahoma"
850:             .FontSize            = 8
851:             .DisabledBackColor   = RGB(255, 255, 255)
852:             .BackColor           = RGB(255, 255, 255)
853:             .Visible             = .T.
854:         ENDWITH
855:         BINDEVENT(loc_oPagina.txt_4c_CodCgo, "KeyPress", THIS, "ValidarCodCgo")
856:         BINDEVENT(loc_oPagina.txt_4c_CodCgo, "KeyPress",  THIS, "TeclaLookupCodCgo")
857: 
858:         *----------------------------------------------------------------------
859:         * Horarios: labels + 4 campos HH:MM
860:         * Label7 "Horarios :" Left=95, Top=249 -> Top=278
861:         * Labels Inicio/Intervalo/Fim: Top=225 -> Top=254
862:         * getHora01-04: Top=246 -> Top=275, Width=45
863:         *   Left: 148 / 205 / 262 / 320
864:         *----------------------------------------------------------------------
865:         loc_oPagina.AddObject("lbl_4c_LblHorarios", "Label")
866:         WITH loc_oPagina.lbl_4c_LblHorarios
867:             .Caption   = "Hor" + CHR(225) + "rios :"
868:             .Top       = 278
869:             .Left      = 95
870:             .Height    = 15
871:             .Width     = 52
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .BackStyle = 0
875:             .ForeColor = RGB(0, 90, 90)
876:             .AutoSize  = .F.
877:             .Visible   = .T.
878:         ENDWITH
879: 
880:         loc_oPagina.AddObject("lbl_4c_LblInicio", "Label")
881:         WITH loc_oPagina.lbl_4c_LblInicio
882:             .Caption   = "In" + CHR(237) + "cio"
883:             .Top       = 254
884:             .Left      = 155
885:             .Height    = 15
886:             .Width     = 30
887:             .FontName  = "Tahoma"
888:             .FontSize  = 8
889:             .BackStyle = 0
890:             .ForeColor = RGB(0, 90, 90)
891:             .AutoSize  = .F.
892:             .Visible   = .T.
893:         ENDWITH
894: 
895:         loc_oPagina.AddObject("lbl_4c_LblIntervalo", "Label")
896:         WITH loc_oPagina.lbl_4c_LblIntervalo

*-- Linhas 1142 a 1248:
1142:             .Visible   = .T.
1143:         ENDWITH
1144: 
1145:         THIS.TornarControlesVisiveis(loc_oPagina)
1146:     ENDPROC
1147: 
1148:     *==========================================================================
1149:     * CarregarLista - Busca dados no BO e vincula ao grid
1150:     * Sequencia obrigatoria: Buscar -> RecordSource (fora WITH) -> AtualizarBinding
1151:     *==========================================================================
1152:     PROCEDURE CarregarLista()
1153:         LOCAL loc_lSucesso, loc_oGrid
1154:         loc_lSucesso = .F.
1155: 
1156:         TRY
1157:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1158:                 loc_lSucesso = .T.
1159:             ELSE
1160:                 IF THIS.this_oBusinessObject.Buscar("")
1161:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1162: 
1163:                     *-- RecordSource e ColumnCount FORA do WITH (Problema 36/48)
1164:                     loc_oGrid.ColumnCount = 3
1165:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1166:                     loc_oGrid.ColumnCount  = 14
1167: 
1168:                     *-- Redefine ControlSource + Headers apos RecordSource (Problema 48)
1169:                     THIS.AtualizarBindingGrid(loc_oGrid)
1170:                     THIS.FormatarGridLista(loc_oGrid)
1171:                     loc_oGrid.Refresh()
1172:                     loc_lSucesso = .T.
1173:                 ENDIF
1174:             ENDIF
1175:         CATCH TO loc_oErro
1176:             MsgErro("Erro em FormJrn.CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
1177:         ENDTRY
1178: 
1179:         RETURN loc_lSucesso
1180:     ENDPROC
1181: 
1182:     *==========================================================================
1183:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1184:     *==========================================================================
1185:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1186:         LOCAL loc_lSucesso
1187:         loc_lSucesso = .F.
1188: 
1189:         TRY
1190:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1191:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1192:                 IF par_nPagina = 1
1193:                     THIS.CarregarLista()
1194:                 ENDIF
1195:                 loc_lSucesso = .T.
1196:             ENDIF
1197:         CATCH TO loc_oErro
1198:             MsgErro("Erro em FormJrn.AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
1199:         ENDTRY
1200: 
1201:         RETURN loc_lSucesso
1202:     ENDPROC
1203: 
1204:     *==========================================================================
1205:     * AtualizarBindingGrid - Redefine ControlSource, Width e Header das 14 colunas
1206:     * Chamado apos RecordSource (Problema 48: auto-bind reseta ControlSource)
1207:     *==========================================================================
1208:     PROTECTED PROCEDURE AtualizarBindingGrid(par_oGrid)
1209:         WITH par_oGrid
1210:             .Column1.ControlSource   = "cursor_4c_Dados.iclis"
1211:             .Column1.Width           = 80
1212:             .Column1.Alignment       = 0
1213:             .Column1.Header1.Caption = "Funcion" + CHR(225) + "rio"
1214: 
1215:             .Column2.ControlSource   = "cursor_4c_Dados.cargos"
1216:             .Column2.Width           = 80
1217:             .Column2.Alignment       = 0
1218:             .Column2.Header1.Caption = "Cargo"
1219: 
1220:             .Column3.ControlSource   = "cursor_4c_Dados.refers"
1221:             .Column3.Width           = 52
1222:             .Column3.Alignment       = 0
1223:             .Column3.Header1.Caption = "Ano/M" + CHR(234) + "s"
1224: 
1225:             .Column4.ControlSource   = "cursor_4c_Dados.hora01"
1226:             .Column4.Width           = 45
1227:             .Column4.Alignment       = 0
1228:             .Column4.Header1.Caption = "Inicio"
1229: 
1230:             .Column5.ControlSource   = "cursor_4c_Dados.hora02"
1231:             .Column5.Width           = 45
1232:             .Column5.Alignment       = 0
1233:             .Column5.Header1.Caption = "Intervalo"
1234: 
1235:             .Column6.ControlSource   = "cursor_4c_Dados.hora03"
1236:             .Column6.Width           = 45
1237:             .Column6.Alignment       = 0
1238:             .Column6.Header1.Caption = "Intervalo"
1239: 
1240:             .Column7.ControlSource   = "cursor_4c_Dados.hora04"
1241:             .Column7.Width           = 45
1242:             .Column7.Alignment       = 0
1243:             .Column7.Header1.Caption = "Fim"
1244: 
1245:             .Column8.ControlSource   = "cursor_4c_Dados.cDom"
1246:             .Column8.Width           = 20
1247:             .Column8.Alignment       = 2
1248:             .Column8.Header1.Caption = "Dom"

*-- Linhas 1282 a 1335:
1282:     *==========================================================================
1283:     * FormatarGridLista - Padroniza fonte de todas as colunas
1284:     *==========================================================================
1285:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1286:         WITH par_oGrid
1287:             .FontName = "Tahoma"
1288:             .FontSize = 8
1289:         ENDWITH
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * BOParaForm - Copia propriedades do BO para os controles de Page2
1294:     *==========================================================================
1295:     PROTECTED PROCEDURE BOParaForm()
1296:         LOCAL loc_lSucesso, loc_oPagina
1297:         loc_lSucesso = .F.
1298: 
1299:         TRY
1300:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1301: 
1302:             *-- Referencia: extrai ano (4) e mes (2) da string refers
1303:             IF LEN(ALLTRIM(THIS.this_oBusinessObject.this_cRefers)) = 6
1304:                 loc_oPagina.cbo_4c_CboAno.Value = SUBSTR(ALLTRIM(THIS.this_oBusinessObject.this_cRefers), 1, 4)
1305:                 loc_oPagina.cbo_4c_CboMes.Value = SUBSTR(ALLTRIM(THIS.this_oBusinessObject.this_cRefers), 5, 2)
1306:             ELSE
1307:                 loc_oPagina.cbo_4c_CboAno.Value = STR(YEAR(DATE()), 4)
1308:                 loc_oPagina.cbo_4c_CboMes.Value = PADL(LTRIM(STR(MONTH(DATE()))), 2, "0")
1309:             ENDIF
1310: 
1311:             *-- Funcionario
1312:             loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(THIS.this_oBusinessObject.this_cIclis)
1313:             loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescri)
1314: 
1315:             *-- Cargo
1316:             loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCargos)
1317: 
1318:             *-- Horarios
1319:             loc_oPagina.txt_4c_Hora01.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora01)
1320:             loc_oPagina.txt_4c_Hora02.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora02)
1321:             loc_oPagina.txt_4c_Hora03.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora03)
1322:             loc_oPagina.txt_4c_Hora04.Value = ALLTRIM(THIS.this_oBusinessObject.this_cHora04)
1323: 
1324:             *-- Dias da semana (BO = logical, CheckBox.Value = numeric 0/1)
1325:             loc_oPagina.chk_4c_ChkDom.Value = IIF(THIS.this_oBusinessObject.this_lDom, 1, 0)
1326:             loc_oPagina.chk_4c_ChkSeg.Value = IIF(THIS.this_oBusinessObject.this_lSeg, 1, 0)
1327:             loc_oPagina.chk_4c_ChkTer.Value = IIF(THIS.this_oBusinessObject.this_lTer, 1, 0)
1328:             loc_oPagina.chk_4c_ChkQua.Value = IIF(THIS.this_oBusinessObject.this_lQua, 1, 0)
1329:             loc_oPagina.chk_4c_ChkQui.Value = IIF(THIS.this_oBusinessObject.this_lQui, 1, 0)
1330:             loc_oPagina.chk_4c_ChkSex.Value = IIF(THIS.this_oBusinessObject.this_lSex, 1, 0)
1331:             loc_oPagina.chk_4c_ChkSab.Value = IIF(THIS.this_oBusinessObject.this_lSab, 1, 0)
1332: 
1333:             loc_lSucesso = .T.
1334:         CATCH TO loc_oErro
1335:             MsgErro("Erro em FormJrn.BOParaForm:" + CHR(13) + loc_oErro.Message, "Erro")

*-- Linhas 1341 a 1977:
1341:     *==========================================================================
1342:     * FormParaBO - Copia valores dos controles de Page2 para o BO
1343:     *==========================================================================
1344:     PROTECTED PROCEDURE FormParaBO()
1345:         LOCAL loc_lSucesso, loc_oPagina, loc_cAno, loc_cMes
1346:         loc_lSucesso = .F.
1347: 
1348:         TRY
1349:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1350: 
1351:             *-- Referencia: combina ano e mes
1352:             loc_cAno = ALLTRIM(NVL(loc_oPagina.cbo_4c_CboAno.Value, ""))
1353:             loc_cMes = ALLTRIM(NVL(loc_oPagina.cbo_4c_CboMes.Value, ""))
1354:             THIS.this_oBusinessObject.this_cRefers = loc_cAno + loc_cMes
1355: 
1356:             *-- Funcionario
1357:             THIS.this_oBusinessObject.this_cIclis  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
1358:             THIS.this_oBusinessObject.this_cDescri = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)
1359: 
1360:             *-- Cargo
1361:             THIS.this_oBusinessObject.this_cCargos = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)
1362: 
1363:             *-- Horarios
1364:             THIS.this_oBusinessObject.this_cHora01 = ALLTRIM(loc_oPagina.txt_4c_Hora01.Value)
1365:             THIS.this_oBusinessObject.this_cHora02 = ALLTRIM(loc_oPagina.txt_4c_Hora02.Value)
1366:             THIS.this_oBusinessObject.this_cHora03 = ALLTRIM(loc_oPagina.txt_4c_Hora03.Value)
1367:             THIS.this_oBusinessObject.this_cHora04 = ALLTRIM(loc_oPagina.txt_4c_Hora04.Value)
1368: 
1369:             *-- Dias da semana (CheckBox.Value = 0/1 numeric -> logical via comparacao)
1370:             THIS.this_oBusinessObject.this_lDom = (loc_oPagina.chk_4c_ChkDom.Value = 1)
1371:             THIS.this_oBusinessObject.this_lSeg = (loc_oPagina.chk_4c_ChkSeg.Value = 1)
1372:             THIS.this_oBusinessObject.this_lTer = (loc_oPagina.chk_4c_ChkTer.Value = 1)
1373:             THIS.this_oBusinessObject.this_lQua = (loc_oPagina.chk_4c_ChkQua.Value = 1)
1374:             THIS.this_oBusinessObject.this_lQui = (loc_oPagina.chk_4c_ChkQui.Value = 1)
1375:             THIS.this_oBusinessObject.this_lSex = (loc_oPagina.chk_4c_ChkSex.Value = 1)
1376:             THIS.this_oBusinessObject.this_lSab = (loc_oPagina.chk_4c_ChkSab.Value = 1)
1377: 
1378:             loc_lSucesso = .T.
1379:         CATCH TO loc_oErro
1380:             MsgErro("Erro em FormJrn.FormParaBO:" + CHR(13) + loc_oErro.Message, "Erro")
1381:         ENDTRY
1382: 
1383:         RETURN loc_lSucesso
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     * LimparCampos - Limpa todos os campos de Page2 para novo registro
1388:     *==========================================================================
1389:     PROTECTED PROCEDURE LimparCampos()
1390:         LOCAL loc_oPagina, loc_cMesAtual, loc_cAnoAtual
1391: 
1392:         TRY
1393:             loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1394:             loc_cMesAtual = PADL(LTRIM(STR(MONTH(DATE()))), 2, "0")
1395:             loc_cAnoAtual = STR(YEAR(DATE()), 4)
1396: 
1397:             loc_oPagina.cbo_4c_CboMes.Value    = loc_cMesAtual
1398:             loc_oPagina.cbo_4c_CboAno.Value    = loc_cAnoAtual
1399:             loc_oPagina.txt_4c_CodCli.Value    = ""
1400:             loc_oPagina.txt_4c_DesCli.Value    = ""
1401:             loc_oPagina.txt_4c_CodCgo.Value    = ""
1402:             loc_oPagina.txt_4c_Hora01.Value    = ""
1403:             loc_oPagina.txt_4c_Hora02.Value    = ""
1404:             loc_oPagina.txt_4c_Hora03.Value    = ""
1405:             loc_oPagina.txt_4c_Hora04.Value    = ""
1406:             loc_oPagina.chk_4c_ChkDom.Value   = 0
1407:             loc_oPagina.chk_4c_ChkSeg.Value   = 0
1408:             loc_oPagina.chk_4c_ChkTer.Value   = 0
1409:             loc_oPagina.chk_4c_ChkQua.Value   = 0
1410:             loc_oPagina.chk_4c_ChkQui.Value   = 0
1411:             loc_oPagina.chk_4c_ChkSex.Value   = 0
1412:             loc_oPagina.chk_4c_ChkSab.Value   = 0
1413:         CATCH TO loc_oErro
1414:             MsgErro("Erro em FormJrn.LimparCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1415:         ENDTRY
1416:     ENDPROC
1417: 
1418:     *==========================================================================
1419:     * HabilitarCampos - Habilita/desabilita campos de edicao em Page2
1420:     * par_lHabilitar = .T.: INCLUIR/ALTERAR | .F.: VISUALIZAR
1421:     *==========================================================================
1422:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1423:         LOCAL loc_oPagina, loc_lReadOnly
1424: 
1425:         TRY
1426:             loc_oPagina   = THIS.pgf_4c_Paginas.Page2
1427:             loc_lReadOnly = !par_lHabilitar
1428: 
1429:             loc_oPagina.cbo_4c_CboMes.Enabled   = par_lHabilitar
1430:             loc_oPagina.cbo_4c_CboAno.Enabled   = par_lHabilitar
1431:             loc_oPagina.txt_4c_CodCli.ReadOnly  = loc_lReadOnly
1432:             loc_oPagina.txt_4c_DesCli.ReadOnly  = loc_lReadOnly
1433:             loc_oPagina.txt_4c_CodCgo.ReadOnly  = loc_lReadOnly
1434:             loc_oPagina.txt_4c_Hora01.ReadOnly  = loc_lReadOnly
1435:             loc_oPagina.txt_4c_Hora02.ReadOnly  = loc_lReadOnly
1436:             loc_oPagina.txt_4c_Hora03.ReadOnly  = loc_lReadOnly
1437:             loc_oPagina.txt_4c_Hora04.ReadOnly  = loc_lReadOnly
1438:             loc_oPagina.chk_4c_ChkDom.Enabled  = par_lHabilitar
1439:             loc_oPagina.chk_4c_ChkSeg.Enabled  = par_lHabilitar
1440:             loc_oPagina.chk_4c_ChkTer.Enabled  = par_lHabilitar
1441:             loc_oPagina.chk_4c_ChkQua.Enabled  = par_lHabilitar
1442:             loc_oPagina.chk_4c_ChkQui.Enabled  = par_lHabilitar
1443:             loc_oPagina.chk_4c_ChkSex.Enabled  = par_lHabilitar
1444:             loc_oPagina.chk_4c_ChkSab.Enabled  = par_lHabilitar
1445:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1446:         CATCH TO loc_oErro
1447:             MsgErro("Erro em FormJrn.HabilitarCampos:" + CHR(13) + loc_oErro.Message, "Erro")
1448:         ENDTRY
1449:     ENDPROC
1450: 
1451:     *==========================================================================
1452:     * BtnIncluirClick - Inicia inclusao de novo registro
1453:     *==========================================================================
1454:     PROCEDURE BtnIncluirClick()
1455:         THIS.this_oBusinessObject.NovoRegistro()
1456:         THIS.this_cModoAtual = "INCLUIR"
1457:         THIS.LimparCampos()
1458:         THIS.HabilitarCampos(.T.)
1459:         THIS.AjustarBotoesPorModo()
1460:         THIS.pgf_4c_Paginas.ActivePage = 2
1461:     ENDPROC
1462: 
1463:     *==========================================================================
1464:     * BtnVisualizarClick - Abre registro selecionado em modo leitura
1465:     *==========================================================================
1466:     PROCEDURE BtnVisualizarClick()
1467:         LOCAL loc_cPkChave
1468:         loc_cPkChave = ""
1469: 
1470:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1471:             SELECT cursor_4c_Dados
1472:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1473:         ENDIF
1474: 
1475:         IF EMPTY(loc_cPkChave)
1476:             MsgAviso("Selecione um registro na lista.")
1477:             RETURN
1478:         ENDIF
1479: 
1480:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1481:             THIS.this_cModoAtual = "VISUALIZAR"
1482:             THIS.BOParaForm()
1483:             THIS.HabilitarCampos(.F.)
1484:             THIS.AjustarBotoesPorModo()
1485:             THIS.pgf_4c_Paginas.ActivePage = 2
1486:         ENDIF
1487:     ENDPROC
1488: 
1489:     *==========================================================================
1490:     * BtnAlterarClick - Abre registro selecionado em modo edicao
1491:     *==========================================================================
1492:     PROCEDURE BtnAlterarClick()
1493:         LOCAL loc_cPkChave
1494:         loc_cPkChave = ""
1495: 
1496:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1497:             SELECT cursor_4c_Dados
1498:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1499:         ENDIF
1500: 
1501:         IF EMPTY(loc_cPkChave)
1502:             MsgAviso("Selecione um registro na lista.")
1503:             RETURN
1504:         ENDIF
1505: 
1506:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1507:             THIS.this_oBusinessObject.EditarRegistro()
1508:             THIS.this_cModoAtual = "ALTERAR"
1509:             THIS.BOParaForm()
1510:             THIS.HabilitarCampos(.T.)
1511:             THIS.AjustarBotoesPorModo()
1512:             THIS.pgf_4c_Paginas.ActivePage = 2
1513:         ENDIF
1514:     ENDPROC
1515: 
1516:     *==========================================================================
1517:     * BtnExcluirClick - Confirma e executa exclusao do registro selecionado
1518:     *==========================================================================
1519:     PROCEDURE BtnExcluirClick()
1520:         LOCAL loc_cPkChave
1521:         loc_cPkChave = ""
1522: 
1523:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1524:             SELECT cursor_4c_Dados
1525:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1526:         ENDIF
1527: 
1528:         IF EMPTY(loc_cPkChave)
1529:             MsgAviso("Selecione um registro na lista.")
1530:             RETURN
1531:         ENDIF
1532: 
1533:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o deste registro?", "Excluir")
1534:             RETURN
1535:         ENDIF
1536: 
1537:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1538:             IF THIS.this_oBusinessObject.Excluir()
1539:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
1540:                 THIS.CarregarLista()
1541:             ENDIF
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     *==========================================================================
1546:     * BtnBuscarClick - Filtra lista por funcionario, cargo ou referencia
1547:     *==========================================================================
1548:     PROCEDURE BtnBuscarClick()
1549:         LOCAL loc_cBusca, loc_cFiltro, loc_oGrid
1550:         loc_cBusca  = ""
1551:         loc_cFiltro = ""
1552: 
1553:         TRY
1554:             loc_cBusca = INPUTBOX("Buscar por funcion" + CHR(225) + ;
1555:                                   "rio, cargo ou refer" + CHR(234) + "ncia (AAAAMM):", ;
1556:                                   "Buscar Jornadas", "")
1557: 
1558:             IF VARTYPE(loc_cBusca) = "C"
1559:                 loc_cBusca = ALLTRIM(CHRTRAN(loc_cBusca, "'", ""))
1560: 
1561:                 IF !EMPTY(loc_cBusca)
1562:                     loc_cFiltro = "(a.iclis LIKE '%" + loc_cBusca + "%'" + ;
1563:                                   " OR a.cargos LIKE '%" + loc_cBusca + "%'" + ;
1564:                                   " OR a.refers LIKE '%" + loc_cBusca + "%'" + ;
1565:                                   " OR b.rclis LIKE '%" + loc_cBusca + "%')"
1566:                 ENDIF
1567: 
1568:                 IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1569:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1570:                     loc_oGrid.ColumnCount = 3
1571:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1572:                     loc_oGrid.ColumnCount  = 14
1573:                     THIS.AtualizarBindingGrid(loc_oGrid)
1574:                     THIS.FormatarGridLista(loc_oGrid)
1575:                     loc_oGrid.Refresh()
1576:                 ENDIF
1577:             ENDIF
1578:         CATCH TO loc_oErro
1579:             MsgErro("Erro em FormJrn.BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1580:         ENDTRY
1581:     ENDPROC
1582: 
1583:     *==========================================================================
1584:     * BtnEncerrarClick - Fecha o formulario
1585:     *==========================================================================
1586:     PROCEDURE BtnEncerrarClick()
1587:         THIS.Release()
1588:     ENDPROC
1589: 
1590:     *==========================================================================
1591:     * BtnCancelarClick - Cancela edicao e volta para lista
1592:     *==========================================================================
1593:     PROCEDURE BtnCancelarClick()
1594:         THIS.this_oBusinessObject.CancelarEdicao()
1595:         THIS.this_cModoAtual = "LISTA"
1596:         THIS.AlternarPagina(1)
1597:     ENDPROC
1598: 
1599:     *==========================================================================
1600:     * BtnSalvarClick - Salva o registro atual (Confirmar em Page2)
1601:     * Chama FormParaBO() + BO.Salvar() (que ja valida internamente)
1602:     *==========================================================================
1603:     PROCEDURE BtnSalvarClick()
1604:         TRY
1605:             IF THIS.FormParaBO()
1606:                 IF THIS.this_oBusinessObject.Salvar()
1607:                     MsgInfo("Registro salvo com sucesso!", "Sucesso")
1608:                     THIS.this_cModoAtual = "LISTA"
1609:                     THIS.AlternarPagina(1)
1610:                 ENDIF
1611:             ENDIF
1612:         CATCH TO loc_oErro
1613:             MsgErro("Erro em FormJrn.BtnSalvarClick:" + CHR(13) + loc_oErro.Message, "Erro")
1614:         ENDTRY
1615:     ENDPROC
1616: 
1617:     *==========================================================================
1618:     * BtnCopiarMesClick - Prepara painel de copia de jornada para outro mes
1619:     * Equivale ao Command1.Click na Page.Lista do legado
1620:     * Captura ano/mes do registro selecionado e exibe cnt_4c_CopiaMes
1621:     *==========================================================================
1622:     PROCEDURE BtnCopiarMesClick()
1623:         LOCAL loc_cRefers, loc_cIclis, loc_cCargos, loc_cPkChave, loc_oPagina
1624:         loc_cRefers  = ""
1625:         loc_cIclis   = ""
1626:         loc_cCargos  = ""
1627:         loc_cPkChave = ""
1628: 
1629:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1630:             SELECT cursor_4c_Dados
1631:             loc_cRefers  = ALLTRIM(cursor_4c_Dados.refers)
1632:             loc_cIclis   = ALLTRIM(cursor_4c_Dados.iclis)
1633:             loc_cCargos  = ALLTRIM(cursor_4c_Dados.cargos)
1634:             loc_cPkChave = ALLTRIM(cursor_4c_Dados.pkchave)
1635:         ENDIF
1636: 
1637:         IF EMPTY(loc_cRefers)
1638:             MsgAviso("Selecione um registro na lista para copiar.")
1639:             RETURN
1640:         ENDIF
1641: 
1642:         *-- Carregar BO com o registro selecionado (CopiarParaMes precisa dos dados do BO)
1643:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cPkChave)
1644:             RETURN
1645:         ENDIF
1646: 
1647:         THIS.this_cAnoAtual = SUBSTR(loc_cRefers, 1, 4)
1648:         THIS.this_cMesAtual = SUBSTR(loc_cRefers, 5, 2)
1649: 
1650:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1651: 
1652:         THIS.this_oBusinessObject.BuscarMesesDisponiveis(loc_cIclis, loc_cCargos)
1653:         THIS.PopularCombosCopiaMes()
1654: 
1655:         loc_oPagina.cmd_4c_CopiarMes.Enabled = .F.
1656:         loc_oPagina.cnt_4c_Saida.Enabled     = .F.
1657:         loc_oPagina.cnt_4c_Botoes.Enabled    = .F.
1658:         loc_oPagina.grd_4c_Lista.Enabled     = .F.
1659:         loc_oPagina.cnt_4c_CopiaMes.Visible  = .T.
1660:         loc_oPagina.cnt_4c_CopiaMes.SetFocus()
1661:     ENDPROC
1662: 
1663:     *==========================================================================
1664:     * Lookup Cargo (txt_4c_CodCgo -> SigCdCrg)
1665:     *==========================================================================
1666:     PROCEDURE AbrirLookupCargo()
1667:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1668:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1669:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value)
1670: 
1671:         TRY
1672:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1673:                 "SigCdCrg", "cursor_4c_Busca", "ccargs", loc_cValor, ;
1674:                 "Sele" + CHR(231) + CHR(227) + "o de Cargos")
1675: 
1676:             IF VARTYPE(loc_oForm) = "O"
1677:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1678:                     loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1679:                 ELSE
1680:                     IF !loc_oForm.this_lAchouRegistro
1681:                     loc_oForm.mAddColuna("ccargs", "", "C" + CHR(243) + "digo")
1682:                     loc_oForm.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
1683:                     loc_oForm.Show()
1684:                     IF loc_oForm.this_lSelecionou
1685:                         loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_Busca.ccargs)
1686:                     ENDIF
1687:                     ENDIF
1688:                 ENDIF
1689:                 IF USED("cursor_4c_Busca")
1690:                     USE IN cursor_4c_Busca
1691:                 ENDIF
1692:                 loc_oForm.Release()
1693:             ENDIF
1694:         CATCH TO loc_oErro
1695:             MsgErro("Erro em FormJrn.AbrirLookupCargo:" + CHR(13) + loc_oErro.Message, "Erro")
1696:         ENDTRY
1697:     ENDPROC
1698: 
1699:     PROCEDURE ValidarCodCgo(par_nKeyCode, par_nShiftAltCtrl)
1700:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
1701:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1702:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_CodCgo.Value))
1703: 
1704:         IF EMPTY(loc_cValor)
1705:             RETURN
1706:         ENDIF
1707: 
1708:         TRY
1709:             loc_cSQL    = "SELECT ccargs FROM SigCdCrg WHERE ccargs = " + EscaparSQL(loc_cValor)
1710:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCgo")
1711: 
1712:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCgo") > 0
1713:                 loc_oPagina.txt_4c_CodCgo.Value = ALLTRIM(cursor_4c_ValCgo.ccargs)
1714:             ELSE
1715:                 MsgAviso("Cargo n" + CHR(227) + "o encontrado.")
1716:                 loc_oPagina.txt_4c_CodCgo.Value = ""
1717:                 THIS.AbrirLookupCargo()
1718:             ENDIF
1719: 
1720:             IF USED("cursor_4c_ValCgo")
1721:                 USE IN cursor_4c_ValCgo
1722:             ENDIF
1723:         CATCH TO loc_oErro
1724:             MsgErro("Erro em FormJrn.ValidarCodCgo:" + CHR(13) + loc_oErro.Message, "Erro")
1725:             IF USED("cursor_4c_ValCgo")
1726:                 USE IN cursor_4c_ValCgo
1727:             ENDIF
1728:         ENDTRY
1729:     ENDPROC
1730: 
1731:     PROCEDURE TeclaLookupCodCgo(par_nKeyCode, par_nShiftAltCtrl)
1732:         IF INLIST(par_nKeyCode, 115, 116)
1733:             THIS.AbrirLookupCargo()
1734:         ENDIF
1735:     ENDPROC
1736: 
1737:     *==========================================================================
1738:     * Lookup Funcionario por codigo (txt_4c_CodCli -> SigCdCli.iclis)
1739:     *==========================================================================
1740:     PROCEDURE AbrirLookupFuncionario()
1741:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1742:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1743:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_CodCli.Value)
1744: 
1745:         TRY
1746:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1747:                 "SigCdCli", "cursor_4c_BuscaCli", "iclis", loc_cValor, ;
1748:                 "Sele" + CHR(231) + CHR(227) + "o de Funcion" + CHR(225) + "rios")
1749: 
1750:             IF VARTYPE(loc_oForm) = "O"
1751:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1752:                     loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1753:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1754:                 ELSE
1755:                     IF !loc_oForm.this_lAchouRegistro
1756:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1757:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1758:                     loc_oForm.Show()
1759:                     IF loc_oForm.this_lSelecionou
1760:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1761:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1762:                     ENDIF
1763:                     ENDIF
1764:                 ENDIF
1765:                 IF USED("cursor_4c_BuscaCli")
1766:                     USE IN cursor_4c_BuscaCli
1767:                 ENDIF
1768:                 loc_oForm.Release()
1769:             ENDIF
1770:         CATCH TO loc_oErro
1771:             MsgErro("Erro em FormJrn.AbrirLookupFuncionario:" + CHR(13) + loc_oErro.Message, "Erro")
1772:         ENDTRY
1773:     ENDPROC
1774: 
1775:     PROCEDURE ValidarCodCli(par_nKeyCode, par_nShiftAltCtrl)
1776:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
1777:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1778:         loc_cValor  = UPPER(ALLTRIM(loc_oPagina.txt_4c_CodCli.Value))
1779: 
1780:         IF EMPTY(loc_cValor)
1781:             loc_oPagina.txt_4c_DesCli.Value = ""
1782:             RETURN
1783:         ENDIF
1784: 
1785:         TRY
1786:             loc_cSQL    = "SELECT iclis, rclis FROM SigCdCli WHERE iclis = " + EscaparSQL(loc_cValor)
1787:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCli")
1788: 
1789:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValCli") > 0
1790:                 loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValCli.iclis)
1791:                 loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValCli.rclis)
1792:             ELSE
1793:                 MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
1794:                 loc_oPagina.txt_4c_CodCli.Value = ""
1795:                 loc_oPagina.txt_4c_DesCli.Value = ""
1796:                 THIS.AbrirLookupFuncionario()
1797:             ENDIF
1798: 
1799:             IF USED("cursor_4c_ValCli")
1800:                 USE IN cursor_4c_ValCli
1801:             ENDIF
1802:         CATCH TO loc_oErro
1803:             MsgErro("Erro em FormJrn.ValidarCodCli:" + CHR(13) + loc_oErro.Message, "Erro")
1804:             IF USED("cursor_4c_ValCli")
1805:                 USE IN cursor_4c_ValCli
1806:             ENDIF
1807:         ENDTRY
1808:     ENDPROC
1809: 
1810:     PROCEDURE TeclaLookupCodCli(par_nKeyCode, par_nShiftAltCtrl)
1811:         IF INLIST(par_nKeyCode, 115, 116)
1812:             THIS.AbrirLookupFuncionario()
1813:         ENDIF
1814:     ENDPROC
1815: 
1816:     *==========================================================================
1817:     * Lookup Funcionario por nome (txt_4c_DesCli -> SigCdCli.rclis)
1818:     *==========================================================================
1819:     PROCEDURE AbrirLookupFuncionarioPorNome()
1820:         LOCAL loc_oPagina, loc_cValor, loc_oForm
1821:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1822:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)
1823: 
1824:         TRY
1825:             loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1826:                 "SigCdCli", "cursor_4c_BuscaCli", "rclis", loc_cValor, ;
1827:                 "Sele" + CHR(231) + CHR(227) + "o de Funcion" + CHR(225) + "rios")
1828: 
1829:             IF VARTYPE(loc_oForm) = "O"
1830:                 IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1831:                     loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1832:                     loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1833:                 ELSE
1834:                     IF !loc_oForm.this_lAchouRegistro
1835:                     loc_oForm.mAddColuna("rclis", "", "Nome")
1836:                     loc_oForm.mAddColuna("iclis", "", "C" + CHR(243) + "digo")
1837:                     loc_oForm.Show()
1838:                     IF loc_oForm.this_lSelecionou
1839:                         loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_BuscaCli.iclis)
1840:                         loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_BuscaCli.rclis)
1841:                     ENDIF
1842:                     ENDIF
1843:                 ENDIF
1844:                 IF USED("cursor_4c_BuscaCli")
1845:                     USE IN cursor_4c_BuscaCli
1846:                 ENDIF
1847:                 loc_oForm.Release()
1848:             ENDIF
1849:         CATCH TO loc_oErro
1850:             MsgErro("Erro em FormJrn.AbrirLookupFuncionarioPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
1851:         ENDTRY
1852:     ENDPROC
1853: 
1854:     PROCEDURE ValidarDesCli(par_nKeyCode, par_nShiftAltCtrl)
1855:         LOCAL loc_oPagina, loc_cValor, loc_cSQL, loc_nResult
1856:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1857:         loc_cValor  = ALLTRIM(loc_oPagina.txt_4c_DesCli.Value)
1858: 
1859:         IF EMPTY(loc_cValor)
1860:             loc_oPagina.txt_4c_CodCli.Value = ""
1861:             RETURN
1862:         ENDIF
1863: 
1864:         TRY
1865:             loc_cSQL    = "SELECT TOP 1 iclis, rclis FROM SigCdCli WHERE rclis LIKE " + ;
1866:                           EscaparSQL(loc_cValor + "%") + " ORDER BY rclis"
1867:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValDes")
1868: 
1869:             IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValDes") > 0
1870:                 loc_oPagina.txt_4c_CodCli.Value = ALLTRIM(cursor_4c_ValDes.iclis)
1871:                 loc_oPagina.txt_4c_DesCli.Value = ALLTRIM(cursor_4c_ValDes.rclis)
1872:             ELSE
1873:                 MsgAviso("Funcion" + CHR(225) + "rio n" + CHR(227) + "o encontrado.")
1874:                 loc_oPagina.txt_4c_DesCli.Value = ""
1875:                 loc_oPagina.txt_4c_CodCli.Value = ""
1876:                 THIS.AbrirLookupFuncionarioPorNome()
1877:             ENDIF
1878: 
1879:             IF USED("cursor_4c_ValDes")
1880:                 USE IN cursor_4c_ValDes
1881:             ENDIF
1882:         CATCH TO loc_oErro
1883:             MsgErro("Erro em FormJrn.ValidarDesCli:" + CHR(13) + loc_oErro.Message, "Erro")
1884:             IF USED("cursor_4c_ValDes")
1885:                 USE IN cursor_4c_ValDes
1886:             ENDIF
1887:         ENDTRY
1888:     ENDPROC
1889: 
1890:     PROCEDURE TeclaLookupDesCli(par_nKeyCode, par_nShiftAltCtrl)
1891:         IF INLIST(par_nKeyCode, 115, 116)
1892:             THIS.AbrirLookupFuncionarioPorNome()
1893:         ENDIF
1894:     ENDPROC
1895: 
1896:     *==========================================================================
1897:     * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
1898:     * Necessario pois AddObject() cria controles com Visible=.F. por padrao
1899:     *==========================================================================
1900:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1901:         LOCAL loc_i, loc_oObjeto, loc_p, loc_cNome
1902: 
1903:         FOR loc_i = 1 TO par_oContainer.ControlCount
1904:             loc_oObjeto = par_oContainer.Controls(loc_i)
1905: 
1906:             IF VARTYPE(loc_oObjeto) = "O"
1907:                 loc_cNome = UPPER(loc_oObjeto.Name)
1908: 
1909:                 *-- Containers com visibilidade gerenciada externamente: recursao nos filhos mas
1910:                 *-- nao forcamos Visible=.T. neste nivel (evita sobrescrever estado gerenciado)
1911:                 IF INLIST(loc_cNome, "CNT_4C_COPIAMES", "CNT_4C_CABECALHO", "CNT_4C_BOTOESACAO")
1912:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1913:                     LOOP
1914:                 ENDIF
1915: 
1916:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1917:                     loc_oObjeto.Visible = .T.
1918:                 ENDIF
1919: 
1920:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1921:                     FOR loc_p = 1 TO loc_oObjeto.PageCount
1922:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_p))
1923:                     ENDFOR
1924:                 ENDIF
1925: 
1926:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1927:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1928:                 ENDIF
1929:             ENDIF
1930:         ENDFOR
1931:     ENDPROC
1932: 
1933:     *==========================================================================
1934:     * PopularCombosCopiaMes - Popula combos De/Para a partir de cursor_4c_Meses
1935:     * Cursor deve ser criado por JrnBO.BuscarMesesDisponiveis antes de chamar
1936:     *==========================================================================
1937:     PROTECTED PROCEDURE PopularCombosCopiaMes()
1938:         LOCAL loc_oCnt, loc_cMesCombo, loc_cMesRef, loc_cNomeMes
1939:         loc_oCnt      = THIS.pgf_4c_Paginas.Page1.cnt_4c_CopiaMes
1940:         loc_cMesCombo = ""
1941:         loc_cNomeMes  = ""
1942: 
1943:         TRY
1944:             IF USED("cursor_4c_Meses") AND RECCOUNT("cursor_4c_Meses") > 0
1945:                 SELECT cursor_4c_Meses
1946:                 GO TOP
1947:                 SCAN
1948:                     loc_cMesRef = SUBSTR(ALLTRIM(refers), 5, 2)
1949:                     DO CASE
1950:                         CASE loc_cMesRef = "01"
1951:                             loc_cNomeMes = "Janeiro"
1952:                         CASE loc_cMesRef = "02"
1953:                             loc_cNomeMes = "Fevereiro"
1954:                         CASE loc_cMesRef = "03"
1955:                             loc_cNomeMes = "Mar" + CHR(231) + "o"
1956:                         CASE loc_cMesRef = "04"
1957:                             loc_cNomeMes = "Abril"
1958:                         CASE loc_cMesRef = "05"
1959:                             loc_cNomeMes = "Maio"
1960:                         CASE loc_cMesRef = "06"
1961:                             loc_cNomeMes = "Junho"
1962:                         CASE loc_cMesRef = "07"
1963:                             loc_cNomeMes = "Julho"
1964:                         CASE loc_cMesRef = "08"
1965:                             loc_cNomeMes = "Agosto"
1966:                         CASE loc_cMesRef = "09"
1967:                             loc_cNomeMes = "Setembro"
1968:                         CASE loc_cMesRef = "10"
1969:                             loc_cNomeMes = "Outubro"
1970:                         CASE loc_cMesRef = "11"
1971:                             loc_cNomeMes = "Novembro"
1972:                         CASE loc_cMesRef = "12"
1973:                             loc_cNomeMes = "Dezembro"
1974:                         OTHERWISE
1975:                             loc_cNomeMes = "M" + CHR(234) + "s " + loc_cMesRef
1976:                     ENDCASE
1977:                     IF !EMPTY(loc_cMesCombo)

*-- Linhas 1997 a 2091:
1997:     * CopiaMesCancelarClick - Fecha painel CopiaMes e reabilita controles da lista
1998:     * Equivale ao Command1.Click de cntCopiaMes no legado
1999:     *==========================================================================
2000:     PROCEDURE CopiaMesCancelarClick()
2001:         LOCAL loc_oPagina
2002:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
2003: 
2004:         TRY
2005:             loc_oPagina.cnt_4c_CopiaMes.Visible  = .F.
2006:             loc_oPagina.cmd_4c_CopiarMes.Enabled = .T.
2007:             loc_oPagina.cnt_4c_Saida.Enabled     = .T.
2008:             loc_oPagina.cnt_4c_Botoes.Enabled    = .T.
2009:             loc_oPagina.grd_4c_Lista.Enabled     = .T.
2010:             loc_oPagina.grd_4c_Lista.SetFocus()
2011:             loc_oPagina.grd_4c_Lista.Refresh()
2012:         CATCH TO loc_oErro
2013:             MsgErro("Erro em FormJrn.CopiaMesCancelarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2014:         ENDTRY
2015:     ENDPROC
2016: 
2017:     *==========================================================================
2018:     * CopiaMesConfirmarClick - Executa copia da jornada para o mes selecionado
2019:     * Equivale ao Command2.Click de cntCopiaMes no legado
2020:     * Usa JrnBO.CopiarParaMes(ano, mes) com o registro carregado em BtnCopiarMesClick
2021:     *==========================================================================
2022:     PROCEDURE CopiaMesConfirmarClick()
2023:         LOCAL loc_oPagina, loc_cMesPara, loc_cRefsDest
2024:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
2025:         loc_cMesPara = ALLTRIM(NVL(loc_oPagina.cnt_4c_CopiaMes.cbo_4c_Para.Value, ""))
2026: 
2027:         IF EMPTY(loc_cMesPara)
2028:             MsgAviso("Selecione o m" + CHR(234) + "s destino.", ;
2029:                     "Valida" + CHR(231) + CHR(227) + "o")
2030:             RETURN
2031:         ENDIF
2032: 
2033:         loc_cRefsDest = THIS.this_cAnoAtual + loc_cMesPara
2034: 
2035:         IF loc_cRefsDest == THIS.this_cAnoAtual + THIS.this_cMesAtual
2036:             MsgErro("O m" + CHR(234) + "s destino " + CHR(233) + " igual ao de origem.", ;
2037:                     "Valida" + CHR(231) + CHR(227) + "o")
2038:             RETURN
2039:         ENDIF
2040: 
2041:         IF MsgConfirma("Confirma c" + CHR(243) + "pia da jornada para " + ;
2042:                        SUBSTR(loc_cRefsDest, 5, 2) + "/" + SUBSTR(loc_cRefsDest, 1, 4) + "?", ;
2043:                        "Copiar Jornada")
2044:             IF THIS.this_oBusinessObject.CopiarParaMes(THIS.this_cAnoAtual, loc_cMesPara)
2045:                 MsgInfo("Jornada copiada com sucesso!", "Sucesso")
2046:                 THIS.CopiaMesCancelarClick()
2047:                 THIS.CarregarLista()
2048:             ENDIF
2049:         ENDIF
2050:     ENDPROC
2051: 
2052:     *==========================================================================
2053:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes conforme this_cModoAtual
2054:     * LISTA    : sem efeito (Page1 visivel)
2055:     * INCLUIR  : Confirmar=habilitado, Cancelar=habilitado
2056:     * ALTERAR  : Confirmar=habilitado, Cancelar=habilitado
2057:     * VISUALIZAR: Confirmar=desabilitado, Cancelar=habilitado
2058:     *==========================================================================
2059:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2060:         LOCAL loc_oPagina, loc_lEdicao
2061:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2062:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2063: 
2064:         TRY
2065:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
2066:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2067:         CATCH TO loc_oErro
2068:             MsgErro("Erro em FormJrn.AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "Erro")
2069:         ENDTRY
2070:     ENDPROC
2071: 
2072:     *==========================================================================
2073:     * Destroy - Libera recursos do formulario
2074:     *==========================================================================
2075:     PROCEDURE Destroy()
2076:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2077:             THIS.this_oBusinessObject = .NULL.
2078:         ENDIF
2079:         IF USED("cursor_4c_Dados")
2080:             USE IN cursor_4c_Dados
2081:         ENDIF
2082:         IF USED("cursor_4c_Meses")
2083:             USE IN cursor_4c_Meses
2084:         ENDIF
2085:         IF USED("cursor_4c_BuscaCli")
2086:             USE IN cursor_4c_BuscaCli
2087:         ENDIF
2088:         DODEFAULT()
2089:     ENDPROC
2090: 
2091: ENDDEFINE


### BO (C:\4c\projeto\app\classes\JrnBO.prg):
*==============================================================================
* JrnBO.prg - Business Object para Cadastro de Jornadas (SigCdJrn)
* Herda de BusinessBase
* Tabela: SigCdJrn
* PK: pkchave (composto: refers + cargos_padded + iclis_padded)
*==============================================================================

DEFINE CLASS JrnBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdJrn
    *--------------------------------------------------------------------------

    *-- Chave primaria composta (calculada)
    this_cPkChave    = ""  && pkchave  char - refers + cargos(0pad) + iclis(0pad)

    *-- Campos de identificacao do registro
    this_cRefers     = ""  && refers   char(6)  - periodo referencia (YYYYMM)
    this_cIclis      = ""  && iclis    char     - codigo do funcionario (FK SigCdCli)
    this_cCargos     = ""  && cargos   char     - codigo do cargo (FK SigCdCrg.ccargs)

    *-- Campo dias (string 7 chars: dom/seg/ter/qua/qui/sex/sab = 'X' ou ' ')
    this_cDias       = "       "  && dias  char(7)

    *-- Horarios (formato HH:MM)
    this_cHora01     = ""  && hora01  char(5) - inicio
    this_cHora02     = ""  && hora02  char(5) - inicio intervalo
    this_cHora03     = ""  && hora03  char(5) - fim intervalo
    this_cHora04     = ""  && hora04  char(5) - fim

    *-- Flags de dias da semana (computados de this_cDias)
    this_lDom        = .F.  && Domingo    (posicao 1 de dias)
    this_lSeg        = .F.  && Segunda    (posicao 2 de dias)
    this_lTer        = .F.  && Terca      (posicao 3 de dias)
    this_lQua        = .F.  && Quarta     (posicao 4 de dias)
    this_lQui        = .F.  && Quinta     (posicao 5 de dias)
    this_lSex        = .F.  && Sexta      (posicao 6 de dias)
    this_lSab        = .F.  && Sabado     (posicao 7 de dias)

    *-- Auditoria de criacao
    this_dDatas      = {}   && datas   datetime - data/hora de inclusao
    this_cUsuars     = ""   && usuars  char     - usuario que incluiu

    *-- Auditoria de alteracao
    this_dDtalts     = {}   && dtalts  datetime - data/hora da ultima alteracao
    this_cUsualts    = ""   && usualts char     - usuario da ultima alteracao

    *-- Descricao do funcionario (calculada via JOIN com SigCdCli)
    this_cDescri     = ""   && descri  char - rclis do funcionario (nao eh campo fisico)

    *--------------------------------------------------------------------------
    * Configuracao da classe
    *--------------------------------------------------------------------------

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdJrn"
        THIS.this_cCampoChave = "pkchave"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cPkChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * CalcularPkChave - constroi a PK composta a partir dos campos
    * refers(6) + cargos(substituindo espacos por "0") + iclis(idem)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CalcularPkChave()
        LOCAL loc_cPk
        loc_cPk = ALLTRIM(THIS.this_cRefers) + ;
                  STRTRAN(THIS.this_cCargos, " ", "0") + ;
                  STRTRAN(THIS.this_cIclis,  " ", "0")
        RETURN loc_cPk
    ENDFUNC

    *--------------------------------------------------------------------------
    * ConstruirDias - constroi string dias (7 chars) a partir dos flags logicos
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ConstruirDias()
        LOCAL loc_cDias
        loc_cDias = IIF(THIS.this_lDom, "X", " ") + ;
                    IIF(THIS.this_lSeg, "X", " ") + ;
                    IIF(THIS.this_lTer, "X", " ") + ;
                    IIF(THIS.this_lQua, "X", " ") + ;
                    IIF(THIS.this_lQui, "X", " ") + ;
                    IIF(THIS.this_lSex, "X", " ") + ;
                    IIF(THIS.this_lSab, "X", " ")
        RETURN loc_cDias
    ENDFUNC

    *--------------------------------------------------------------------------
    * ParsearDias - converte string dias para flags logicos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ParsearDias(par_cDias)
        LOCAL loc_cStr
        loc_cStr = PADR(NVL(par_cDias, "       "), 7)
        THIS.this_lDom = (SUBSTR(loc_cStr, 1, 1) == "X")
        THIS.this_lSeg = (SUBSTR(loc_cStr, 2, 1) == "X")
        THIS.this_lTer = (SUBSTR(loc_cStr, 3, 1) == "X")
        THIS.this_lQua = (SUBSTR(loc_cStr, 4, 1) == "X")
        THIS.this_lQui = (SUBSTR(loc_cStr, 5, 1) == "X")
        THIS.this_lSex = (SUBSTR(loc_cStr, 6, 1) == "X")
        THIS.this_lSab = (SUBSTR(loc_cStr, 7, 1) == "X")
        THIS.this_cDias = loc_cStr
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cPkChave   = TratarNulo(pkchave, "C")
            THIS.this_cRefers    = TratarNulo(refers,  "C")
            THIS.this_cIclis     = TratarNulo(iclis,   "C")
            THIS.this_cCargos    = TratarNulo(cargos,  "C")
            THIS.this_cHora01    = TratarNulo(hora01,  "C")
            THIS.this_cHora02    = TratarNulo(hora02,  "C")
            THIS.this_cHora03    = TratarNulo(hora03,  "C")
            THIS.this_cHora04    = TratarNulo(hora04,  "C")
            THIS.this_dDatas     = TratarNulo(datas,   "D")
            THIS.this_cUsuars    = TratarNulo(usuars,  "C")
            THIS.this_dDtalts    = TratarNulo(dtalts,  "D")
            THIS.this_cUsualts   = TratarNulo(usualts, "C")
            THIS.ParsearDias(TratarNulo(dias, "C"))
            *-- descri eh calculado via JOIN - carrega se existir no cursor
            IF TYPE("descri") != "U"
                THIS.this_cDescri = TratarNulo(descri, "C")
            ENDIF
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT geral com JOIN para descricao do funcionario
    * par_cFiltro: condicao WHERE adicional (sem a palavra WHERE)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri," + ;
                       " SUBSTRING(a.dias,1,1) AS cDom," + ;
                       " CASE WHEN SUBSTRING(a.dias,1,1)='X' THEN 1 ELSE 0 END AS dom," + ;
                       " SUBSTRING(a.dias,2,1) AS cSeg," + ;
                       " CASE WHEN SUBSTRING(a.dias,2,1)='X' THEN 1 ELSE 0 END AS seg," + ;
                       " SUBSTRING(a.dias,3,1) AS cTer," + ;
                       " CASE WHEN SUBSTRING(a.dias,3,1)='X' THEN 1 ELSE 0 END AS ter," + ;
                       " SUBSTRING(a.dias,4,1) AS cQua," + ;
                       " CASE WHEN SUBSTRING(a.dias,4,1)='X' THEN 1 ELSE 0 END AS qua," + ;
                       " SUBSTRING(a.dias,5,1) AS cQui," + ;
                       " CASE WHEN SUBSTRING(a.dias,5,1)='X' THEN 1 ELSE 0 END AS qui," + ;
                       " SUBSTRING(a.dias,6,1) AS cSex," + ;
                       " CASE WHEN SUBSTRING(a.dias,6,1)='X' THEN 1 ELSE 0 END AS sex," + ;
                       " SUBSTRING(a.dias,7,1) AS cSab," + ;
                       " CASE WHEN SUBSTRING(a.dias,7,1)='X' THEN 1 ELSE 0 END AS sab" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       loc_cWhere + ;
                       " ORDER BY a.pkchave"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar jornadas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - carrega registro pelo pkchave
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cPkChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT a.pkchave, a.refers, a.iclis, a.cargos," + ;
                       " a.dias, a.hora01, a.hora02, a.hora03, a.hora04," + ;
                       " a.datas, a.usuars, a.dtalts, a.usualts," + ;
                       " ISNULL(b.rclis, '') AS descri" + ;
                       " FROM SigCdJrn a" + ;
                       " LEFT JOIN SigCdCli b ON b.iclis = a.iclis" + ;
                       " WHERE a.pkchave = " + EscaparSQL(par_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                IF loc_nResult <= 0
                    MsgErro("Erro ao carregar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdJrn
    * Constroi pkchave composto e registra auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cPkChave, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cPkChave = THIS.CalcularPkChave()
            loc_cDias    = THIS.ConstruirDias()

            loc_cSQL = "INSERT INTO SigCdJrn" + ;
                       " (pkchave, refers, iclis, cargos, dias," + ;
                       "  hora01, hora02, hora03, hora04," + ;
                       "  datas, usuars)" + ;
                       " VALUES (" + ;
                       EscaparSQL(loc_cPkChave) + ", " + ;
                       EscaparSQL(THIS.this_cRefers) + ", " + ;
                       EscaparSQL(THIS.this_cIclis) + ", " + ;
                       EscaparSQL(THIS.this_cCargos) + ", " + ;
                       EscaparSQL(loc_cDias) + ", " + ;
                       EscaparSQL(THIS.this_cHora01) + ", " + ;
                       EscaparSQL(THIS.this_cHora02) + ", " + ;
                       EscaparSQL(THIS.this_cHora03) + ", " + ;
                       EscaparSQL(THIS.this_cHora04) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.this_cPkChave = loc_cPkChave
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao incluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigCdJrn
    * Altera apenas: dias, refers, dtalts, usualts (conforme logica original)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDias
        loc_lSucesso = .F.

        TRY
            loc_cDias = THIS.ConstruirDias()

            loc_cSQL = "UPDATE SigCdJrn SET" + ;
                       " refers  = " + EscaparSQL(THIS.this_cRefers) + "," + ;
                       " dias    = " + EscaparSQL(loc_cDias) + "," + ;
                       " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                       " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                       " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                       " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                       " dtalts  = GETDATE()," + ;
                       " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao alterar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdJrn
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdJrn" + ;
                       " WHERE pkchave = " + EscaparSQL(THIS.this_cPkChave)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarParaMes - copia a jornada do registro atual para outro mes/ano
    * par_cAno:  ano destino (4 chars, ex: "2025")
    * par_cMes:  mes destino (2 chars, ex: "03")
    * Retorna .T. se copiou com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE CopiarParaMes(par_cAno, par_cMes)
        LOCAL loc_cNovoRefers, loc_cNovoPk, loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cAno)) OR EMPTY(ALLTRIM(par_cMes))
                MsgErro("Ano e m" + CHR(234) + "s s" + CHR(227) + "o obrigat" + ;
                        CHR(243) + "rios para copiar jornada.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cNovoRefers = ALLTRIM(par_cAno) + ALLTRIM(par_cMes)
            loc_cNovoPk     = loc_cNovoRefers + ;
                              STRTRAN(THIS.this_cCargos, " ", "0") + ;
                              STRTRAN(THIS.this_cIclis,  " ", "0")

            *-- Verifica se ja existe registro para o mes destino
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdJrn WHERE pkchave = " + ;
                       EscaparSQL(loc_cNovoPk)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCopia") > 0
                SELECT cursor_4c_ChkCopia
                IF cursor_4c_ChkCopia.qtd > 0
                    *-- Registro existente: UPDATE
                    loc_cSQL = "UPDATE SigCdJrn SET" + ;
                               " refers  = " + EscaparSQL(loc_cNovoRefers) + "," + ;
                               " dias    = " + EscaparSQL(THIS.ConstruirDias()) + "," + ;
                               " hora01  = " + EscaparSQL(THIS.this_cHora01) + "," + ;
                               " hora02  = " + EscaparSQL(THIS.this_cHora02) + "," + ;
                               " hora03  = " + EscaparSQL(THIS.this_cHora03) + "," + ;
                               " hora04  = " + EscaparSQL(THIS.this_cHora04) + "," + ;
                               " dtalts  = GETDATE()," + ;
                               " usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                               " WHERE pkchave = " + EscaparSQL(loc_cNovoPk)
                ELSE
                    *-- Registro novo: INSERT
                    loc_cSQL = "INSERT INTO SigCdJrn" + ;
                               " (pkchave, refers, iclis, cargos, dias," + ;
                               "  hora01, hora02, hora03, hora04," + ;
                               "  datas, usuars)" + ;
                               " VALUES (" + ;
                               EscaparSQL(loc_cNovoPk) + ", " + ;
                               EscaparSQL(loc_cNovoRefers) + ", " + ;
                               EscaparSQL(THIS.this_cIclis) + ", " + ;
                               EscaparSQL(THIS.this_cCargos) + ", " + ;
                               EscaparSQL(THIS.ConstruirDias()) + ", " + ;
                               EscaparSQL(THIS.this_cHora01) + ", " + ;
                               EscaparSQL(THIS.this_cHora02) + ", " + ;
                               EscaparSQL(THIS.this_cHora03) + ", " + ;
                               EscaparSQL(THIS.this_cHora04) + ", " + ;
                               "GETDATE(), " + ;
                               EscaparSQL(gc_4c_UsuarioLogado) + ")"
                ENDIF
                USE IN cursor_4c_ChkCopia
            ELSE
                MsgErro("Erro ao verificar registro destino:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ChkCopia")
                    USE IN cursor_4c_ChkCopia
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao copiar jornada:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.CopiarParaMes:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkCopia")
                USE IN cursor_4c_ChkCopia
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarMesesDisponiveis - retorna cursor com meses existentes para
    * funcionario/cargo especificados (para o painel Copiar Mes)
    * par_cIclis:  codigo do funcionario (pode ser vazio = todos)
    * par_cCargos: codigo do cargo (pode ser vazio = todos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarMesesDisponiveis(par_cIclis, par_cCargos)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Meses")
                USE IN cursor_4c_Meses
            ENDIF

            loc_cWhere = " WHERE (iclis = " + EscaparSQL(par_cIclis) + ;
                         " OR " + EscaparSQL(par_cIclis) + " = '')" + ;
                         " AND (cargos = " + EscaparSQL(par_cCargos) + ;
                         " OR " + EscaparSQL(par_cCargos) + " = '')"

            loc_cSQL = "SELECT refers FROM SigCdJrn" + ;
                       loc_cWhere + ;
                       " ORDER BY refers ASC"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Meses")

            IF loc_nResult > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar meses:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em JrnBO.BuscarMesesDisponiveis:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - valida campos obrigatorios antes de salvar
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cRefers))
            MsgErro("Refer" + CHR(234) + "ncia (Ano/M" + CHR(234) + "s) " + ;
                    CHR(233) + " obrigat" + CHR(243) + "ria.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cIclis)) AND EMPTY(ALLTRIM(THIS.this_cCargos))
            MsgAviso("Informe o Funcion" + CHR(225) + "rio ou o Cargo.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido
            IF EMPTY(ALLTRIM(THIS.this_cHora01)) OR EMPTY(ALLTRIM(THIS.this_cHora02)) OR ;
               EMPTY(ALLTRIM(THIS.this_cHora03)) OR EMPTY(ALLTRIM(THIS.this_cHora04))
                MsgAviso("Aten" + CHR(231) + CHR(227) + "o!! Todos os hor" + CHR(225) + ;
                        "rios devem ser preenchidos.", "Valida" + CHR(231) + CHR(227) + "o")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - limpeza de cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        IF USED("cursor_4c_Meses")
            USE IN cursor_4c_Meses
        ENDIF
        IF USED("cursor_4c_ChkCopia")
            USE IN cursor_4c_ChkCopia
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

