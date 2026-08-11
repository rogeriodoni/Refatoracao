# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (5)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDFPO): Top original=314 vs migrado 'lbl_4c_Say1' Top=510 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGCDFPO): Left original=107 vs migrado 'lbl_4c_Say1' Left=237 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDFPO): Top original=313 vs migrado 'lbl_4c_Say2' Top=510 (diff=197px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGCDFPO): Left original=219 vs migrado 'lbl_4c_Say2' Left=277 (diff=58px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGCDFPO): Top original=313 vs migrado 'lbl_4c_Say3' Top=510 (diff=197px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFpo.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1308 linhas total):

*-- Linhas 41 a 62:
41:         loc_lSucesso = .F.
42: 
43:         TRY
44:             THIS.Caption = "Condi" + CHR(231) + CHR(227) + ;
45:                 "o de Pagamento Por Opera" + CHR(231) + CHR(227) + "o"
46: 
47:             THIS.this_oBusinessObject = CREATEOBJECT("FpoBO")
48:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
49:                 MsgErro("Erro ao criar FpoBO", ;
50:                     "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
51:             ELSE
52:                 THIS.ConfigurarPageFrame()
53: 
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     IF !EMPTY(ALLTRIM(THIS.this_cDopes))
61:                         THIS.CarregarGrade()
62:                     ENDIF

*-- Linhas 83 a 100:
83:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
84:             WITH THIS.pgf_4c_Paginas
85:                 .PageCount  = 2
86:                 .Top        = -29
87:                 .Left       = 0
88:                 .Width      = THIS.Width
89:                 .Height     = THIS.Height + 29
90:                 .Tabs       = .F.
91:                 .Visible    = .T.
92:                 .Page1.Caption   = "Lista"
93:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:                 .Page1.BackColor = RGB(255, 255, 255)
95:                 .Page2.Caption   = "Dados"
96:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
97:                 .Page2.BackColor = RGB(255, 255, 255)
98:             ENDWITH
99: 
100:             THIS.ConfigurarPaginaLista()

*-- Linhas 119 a 191:
119:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
120: 
121:             *-- Cabecalho cinza escuro (cntSombra no legado)
122:             *-- Top=31 = 2 + 29 (compensacao PageFrame.Top = -29)
123:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
124:             WITH loc_oPagina.cnt_4c_Cabecalho
125:                 .Top         = 31
126:                 .Left        = 0
127:                 .Width       = THIS.Width
128:                 .Height      = 80
129:                 .BackColor   = RGB(100, 100, 100)
130:                 .BorderWidth = 0
131:                 .Visible     = .T.
132:             ENDWITH
133: 
134:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
135:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
136:                 .Top       = 18
137:                 .Left      = 10
138:                 .Width     = 769
139:                 .Height    = 40
140:                 .Caption   = THIS.Caption
141:                 .BackStyle = 0
142:                 .FontName  = "Tahoma"
143:                 .FontSize  = 18
144:                 .FontBold  = .T.
145:                 .ForeColor = RGB(0, 0, 0)
146:                 .AutoSize  = .F.
147:                 .Visible   = .T.
148:             ENDWITH
149: 
150:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
151:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
152:                 .Top       = 17
153:                 .Left      = 10
154:                 .Width     = 769
155:                 .Height    = 46
156:                 .Caption   = THIS.Caption
157:                 .BackStyle = 0
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 18
160:                 .FontBold  = .T.
161:                 .ForeColor = RGB(255, 255, 255)
162:                 .AutoSize  = .F.
163:                 .Visible   = .T.
164:             ENDWITH
165: 
166:             *-- Container de botoes operacionais (cmdInserir/cmdExcluir/cmdSair no legado)
167:             *-- Top=29 = 0 + 29 (compensacao PageFrame.Top = -29)
168:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
169:             WITH loc_oPagina.cnt_4c_Botoes
170:                 .Top         = 29
171:                 .Left        =  542
172:                 .Width       = 300
173:                 .Height      = 85
174:                 .BackStyle = 0
175:                 .BorderWidth = 0
176:                 .Visible     = .T.
177:             ENDWITH
178: 
179:             *-- Botao Inserir (cmdInserir no legado)
180:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
181:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir
182:                 .Caption         = "Inserir"
183:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
184:                 .PicturePosition = 13
185:                 .Top             = 5
186:                 .Left            = 5
187:                 .Width           = 75
188:                 .Height          = 75
189:                 .BackColor       = RGB(255, 255, 255)
190:                 .ForeColor       = RGB(90, 90, 90)
191:                 .FontName        = "Tahoma"

*-- Linhas 200 a 214:
200:             ENDWITH
201: 
202:             *-- Botao Excluir (cmdExcluir no legado)
203:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
204:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
205:                 .Caption         = "Excluir"
206:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
207:                 .PicturePosition = 13
208:                 .Top             = 5
209:                 .Left            = 80
210:                 .Width           = 75
211:                 .Height          = 75
212:                 .BackColor       = RGB(255, 255, 255)
213:                 .ForeColor       = RGB(90, 90, 90)
214:                 .FontName        = "Tahoma"

*-- Linhas 223 a 237:
223:             ENDWITH
224: 
225:             *-- Botao Encerrar/Sair - valida, salva e fecha (cmdSair no legado)
226:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
227:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar
228:                 .Caption         = "Encerrar"
229:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
230:                 .PicturePosition = 13
231:                 .Top             = 5
232:                 .Left            = 155
233:                 .Width           = 75
234:                 .Height          = 75
235:                 .BackColor       = RGB(255, 255, 255)
236:                 .ForeColor       = RGB(90, 90, 90)
237:                 .FontName        = "Tahoma"

*-- Linhas 246 a 264:
246:             ENDWITH
247: 
248:             *-- BINDEVENTs para botoes operacionais
249:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir,  "Click", THIS, "BtnInserirClick")
250:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,  "Click", THIS, "BtnExcluirClick")
251:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
252: 
253:             *-- Grade de dados (GradeFPagto no legado)
254:             *-- RecordSource sera definido em CarregarGrade() apos carga dos dados
255:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
256:             loc_oPagina.grd_4c_Dados.ColumnCount = 5
257:             WITH loc_oPagina.grd_4c_Dados
258:                 .Top                = 120
259:                 .Left               = 12
260:                 .Width              = 680
261:                 .Height             = 380
262:                 .FontName           = "Tahoma"
263:                 .FontSize           = 8
264:                 .DeleteMark         = .F.

*-- Linhas 278 a 332:
278:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column5.Text1, "KeyPress", THIS, "GradeCol5KeyPress")
279:             BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GradeAfterRowColChange")
280: 
281:             *-- BINDEVENTs para CheckBoxes das colunas O/A/C (KeyPress para toggle Enter/Space)
282:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Check1, "KeyPress", THIS, "GradeCol2CheckKeyPress")
283:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column3.Check1, "KeyPress", THIS, "GradeCol3CheckKeyPress")
284:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Check1, "KeyPress", THIS, "GradeCol4CheckKeyPress")
285: 
286:             *-- BINDEVENT para ordenacao por clique no Header e LostFocus de validacao
287:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Header1, "Click",     THIS, "GradeCol1HeaderClick")
288:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1,   "KeyPress", THIS, "GradeCol1TextLostFocus")
289: 
290:             *-- Labels de legenda (Say1/Say2/Say3 do legado)
291:             loc_oPagina.AddObject("lbl_4c_Say1", "Label")
292:             WITH loc_oPagina.lbl_4c_Say1
293:                 .Caption   = "O = Obrigat" + CHR(243) + "rio"
294:                 .Top       = 510
295:                 .Left      = 237
296:                 .Width     = 100
297:                 .Height    = 15
298:                 .BackStyle = 0
299:                 .ForeColor = RGB(216, 39, 70)
300:                 .FontName  = "Tahoma"
301:                 .FontSize  = 8
302:                 .FontBold  = .T.
303:                 .AutoSize  = .F.
304:                 .Visible   = .T.
305:             ENDWITH
306: 
307:             loc_oPagina.AddObject("lbl_4c_Say2", "Label")
308:             WITH loc_oPagina.lbl_4c_Say2
309:                 .Caption   = "A = S" + CHR(243) + " Auto"
310:                 .Top       = 510
311:                 .Left      = 277
312:                 .Width     = 80
313:                 .Height    = 15
314:                 .BackStyle = 0
315:                 .ForeColor = RGB(0, 0, 128)
316:                 .FontName  = "Tahoma"
317:                 .FontSize  = 8
318:                 .FontBold  = .T.
319:                 .AutoSize  = .F.
320:                 .Visible   = .T.
321:             ENDWITH
322: 
323:             loc_oPagina.AddObject("lbl_4c_Say3", "Label")
324:             WITH loc_oPagina.lbl_4c_Say3
325:                 .Caption   = "C = N" + CHR(195) + "O Contabilizar"
326:                 .Top       = 510
327:                 .Left      = 315
328:                 .Width     = 145
329:                 .Height    = 15
330:                 .BackStyle = 0
331:                 .ForeColor = RGB(0, 128, 255)
332:                 .FontName  = "Tahoma"

*-- Linhas 355 a 425:
355:             loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
356: 
357:             *-- Cabecalho cinza (mesmo estilo da Page1)
358:             *-- Top=31 = 2 + 29 (compensacao PageFrame.Top = -29)
359:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
360:             WITH loc_oPagina.cnt_4c_Cabecalho
361:                 .Top         = 31
362:                 .Left        = 0
363:                 .Width       = THIS.Width
364:                 .Height      = 80
365:                 .BackColor   = RGB(100, 100, 100)
366:                 .BorderWidth = 0
367:                 .Visible     = .T.
368:             ENDWITH
369: 
370:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
371:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
372:                 .Top       = 18
373:                 .Left      = 10
374:                 .Width     = 769
375:                 .Height    = 40
376:                 .Caption   = THIS.Caption
377:                 .BackStyle = 0
378:                 .FontName  = "Tahoma"
379:                 .FontSize  = 18
380:                 .FontBold  = .T.
381:                 .ForeColor = RGB(0, 0, 0)
382:                 .AutoSize  = .F.
383:                 .Visible   = .T.
384:             ENDWITH
385: 
386:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
387:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
388:                 .Top       = 17
389:                 .Left      = 10
390:                 .Width     = 769
391:                 .Height    = 46
392:                 .Caption   = THIS.Caption
393:                 .BackStyle = 0
394:                 .FontName  = "Tahoma"
395:                 .FontSize  = 18
396:                 .FontBold  = .T.
397:                 .ForeColor = RGB(255, 255, 255)
398:                 .AutoSize  = .F.
399:                 .Visible   = .T.
400:             ENDWITH
401: 
402:             *-- Container de botoes de acao (Confirmar/Cancelar)
403:             *-- Top=33 = 4 + 29 (compensacao PageFrame.Top = -29)
404:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
405:             WITH loc_oPagina.cnt_4c_BotoesAcao
406:                 .Top         = 33
407:                 .Left        = 842
408:                 .Width       = 160
409:                 .Height      = 85
410:                 .BackStyle   = 0
411:                 .Visible     = .T.
412:             ENDWITH
413: 
414:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
415:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
416:                 .Caption         = "Confirmar"
417:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
418:                 .PicturePosition = 13
419:                 .Top             = 5
420:                 .Left            = 5
421:                 .Width           = 75
422:                 .Height          = 75
423:                 .BackColor       = RGB(255, 255, 255)
424:                 .ForeColor       = RGB(90, 90, 90)
425:                 .FontName        = "Tahoma"

*-- Linhas 433 a 447:
433:                 .Visible         = .T.
434:             ENDWITH
435: 
436:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
437:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
438:                 .Caption         = "Encerrar"
439:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
440:                 .PicturePosition = 13
441:                 .Top             = 5
442:                 .Left            = 80
443:                 .Width           = 75
444:                 .Height          = 75
445:                 .BackColor       = RGB(255, 255, 255)
446:                 .ForeColor       = RGB(90, 90, 90)
447:                 .FontName        = "Tahoma"

*-- Linhas 455 a 464:
455:                 .Visible         = .T.
456:             ENDWITH
457: 
458:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
459:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
460: 
461:             THIS.TornarControlesVisiveis(loc_oPagina)
462:         CATCH TO loc_oErro
463:             MsgErro(loc_oErro.Message, "Erro em ConfigurarPaginaDados")
464:         ENDTRY

*-- Linhas 597 a 683:
597:                     .Column1.ControlSource   = "cursor_4c_Dados.FPags"
598:                     .Column1.Width           = 230
599:                     .Column1.Sparse          = .T.
600:                     .Column1.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o Pagto"
601:                     .Column1.Text1.MaxLength = 12
602: 
603:                     .Column2.ControlSource   = "cursor_4c_Dados.Obrigs"
604:                     .Column2.Width           = 42
605:                     .Column2.Sparse          = .F.
606:                     .AddObject("Check1", "CheckBox")
607:                     .Check1.Caption = ""
608:                     .Check1.Alignment = 0
609:                     .Check1.ReadOnly  = .F.
610:                     .Check1.Visible   = .T.
611:                     .Check1.Top       = 9
612:                     .Check1.Left      = 2
613:                     .Check1.Height    = 17
614:                     .Check1.Width     = 22
615:                     .Column2.CurrentControl  = "Check1"
616:                     .Column2.Header1.Caption = "O"
617:                     .Column2.Check1.Alignment = 0
618:                     .Column2.Check1.ReadOnly  = .F.
619:                     .Column2.Check1.Visible   = .T.
620:                     .Column2.Check1.Top       = 9
621:                     .Column2.Check1.Left      = 2
622:                     .Column2.Check1.Height    = 17
623:                     .Column2.Check1.Width     = 22
624:                     .Column2.Check1.Caption   = ""
625: 
626:                     .Column3.ControlSource   = "cursor_4c_Dados.Autos"
627:                     .Column3.Width           = 42
628:                     .Column3.Sparse          = .F.
629:                     .AddObject("Check1", "CheckBox")
630:                     .Check1.Caption = ""
631:                     .Check1.Alignment = 0
632:                     .Check1.ReadOnly  = .F.
633:                     .Check1.Visible   = .T.
634:                     .Check1.Top       = 9
635:                     .Check1.Left      = 2
636:                     .Check1.Height    = 17
637:                     .Check1.Width     = 22
638:                     .Column3.CurrentControl  = "Check1"
639:                     .Column3.Header1.Caption = "A"
640:                     .Column3.Check1.Alignment = 0
641:                     .Column3.Check1.ReadOnly  = .F.
642:                     .Column3.Check1.Visible   = .T.
643:                     .Column3.Check1.Top       = 9
644:                     .Column3.Check1.Left      = 2
645:                     .Column3.Check1.Height    = 17
646:                     .Column3.Check1.Width     = 22
647:                     .Column3.Check1.Caption   = ""
648: 
649:                     .Column4.ControlSource   = "cursor_4c_Dados.Contabs"
650:                     .Column4.Width           = 42
651:                     .Column4.Sparse          = .F.
652:                     .AddObject("Check1", "CheckBox")
653:                     .Check1.Caption = ""
654:                     .Check1.Alignment = 0
655:                     .Check1.ReadOnly  = .F.
656:                     .Check1.Visible   = .T.
657:                     .Check1.Top       = 9
658:                     .Check1.Left      = 2
659:                     .Check1.Height    = 17
660:                     .Check1.Width     = 22
661:                     .Column4.CurrentControl  = "Check1"
662:                     .Column4.Header1.Caption = "C"
663:                     .Column4.Check1.Alignment = 0
664:                     .Column4.Check1.ReadOnly  = .F.
665:                     .Column4.Check1.Visible   = .T.
666:                     .Column4.Check1.Top       = 9
667:                     .Column4.Check1.Left      = 2
668:                     .Column4.Check1.Height    = 17
669:                     .Column4.Check1.Width     = 22
670:                     .Column4.Check1.Caption   = ""
671: 
672:                     .Column5.ControlSource   = "cursor_4c_Dados.FPagss"
673:                     .Column5.Width           = 230
674:                     .Column5.Sparse          = .T.
675:                     .Column5.Header1.Caption = "Substituir"
676:                     .Column5.Text1.MaxLength = 12
677: 
678:                     *-- Cores das colunas CheckBox (fidelidade visual PILAR 1)
679:                     .Column2.BackColor = RGB(216, 39, 70)
680:                     .Column3.BackColor = RGB(0, 0, 128)
681:                     .Column4.BackColor = RGB(0, 128, 255)
682: 
683:                     *-- Propriedades visuais dos Headers (PILAR 1)

*-- Linhas 822 a 831:
822:                 ENDIF
823: 
824:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "cnt_4c_Botoes", 5)
825:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
826:                         THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = !loc_lBloqueado
827:                     ENDIF
828:                 ENDIF
829:             ENDIF
830:         CATCH TO loc_oErro
831:             MsgErro(loc_oErro.Message, "Erro em GradeAfterRowColChange")

*-- Linhas 939 a 947:
939:     ENDPROC
940: 
941:     *--------------------------------------------------------------------------
942:     * GradeCol2CheckKeyPress - KeyPress no CheckBox da coluna Obrigatorio (Column2)
943:     * Enter (13) ou Space (32) alterna Obrigs do registro atual (mirror do KeyPress legado)
944:     *--------------------------------------------------------------------------
945:     PROCEDURE GradeCol2CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
946:         LOCAL loc_oErro
947:         IF INLIST(par_nKeyCode, 13, 32)

*-- Linhas 958 a 966:
958:     ENDPROC
959: 
960:     *--------------------------------------------------------------------------
961:     * GradeCol3CheckKeyPress - KeyPress no CheckBox da coluna Auto (Column3)
962:     * Enter (13) ou Space (32) alterna Autos do registro atual (mirror do KeyPress legado)
963:     *--------------------------------------------------------------------------
964:     PROCEDURE GradeCol3CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
965:         LOCAL loc_oErro
966:         IF INLIST(par_nKeyCode, 13, 32)

*-- Linhas 977 a 985:
977:     ENDPROC
978: 
979:     *--------------------------------------------------------------------------
980:     * GradeCol4CheckKeyPress - KeyPress no CheckBox da coluna Nao Contabilizar (Column4)
981:     * Enter (13) ou Space (32) alterna Contabs do registro atual (mirror do KeyPress legado)
982:     *--------------------------------------------------------------------------
983:     PROCEDURE GradeCol4CheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
984:         LOCAL loc_oErro
985:         IF INLIST(par_nKeyCode, 13, 32)

*-- Linhas 1006 a 1014:
1006:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1007:                 SELECT cursor_4c_Dados
1008:                 IF EMPTY(ALLTRIM(cursor_4c_Dados.FPags))
1009:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes.cmd_4c_Encerrar.SetFocus()
1010:                 ENDIF
1011:             ENDIF
1012:         CATCH TO loc_oErro
1013:             MsgErro(loc_oErro.Message, "Erro em GradeCol1TextLostFocus")
1014:         ENDTRY

*-- Linhas 1252 a 1264:
1252:             ENDIF
1253: 
1254:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1255:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Inserir", 5)
1256:                     loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir.Enabled = par_lHabilitar
1257:                 ENDIF
1258:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1259:                     loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled = par_lHabilitar
1260:                 ENDIF
1261:             ENDIF
1262:         CATCH TO loc_oErro
1263:             MsgErro(loc_oErro.Message, "Erro em HabilitarCampos")
1264:         ENDTRY

*-- Linhas 1290 a 1305:
1290:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
1291: 
1292:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1293:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Inserir", 5)
1294:                     loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir.Enabled  = .T.
1295:                 ENDIF
1296:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Excluir", 5)
1297:                     loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir.Enabled  = .T.
1298:                 ENDIF
1299:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Botoes, "cmd_4c_Encerrar", 5)
1300:                     loc_oPagina.cnt_4c_Botoes.cmd_4c_Encerrar.Enabled = .T.
1301:                 ENDIF
1302:             ENDIF
1303:         CATCH TO loc_oErro
1304:             MsgErro(loc_oErro.Message, "Erro em AjustarBotoesPorModo")
1305:         ENDTRY


### BO (C:\4c\projeto\app\classes\FpoBO.prg):
*==============================================================================
* FpoBO.prg - Business Object de Condicao de Pagamento Por Operacao
* Tabela: SigOpFpo
* PK: cidchaves
*==============================================================================

DEFINE CLASS FpoBO AS BusinessBase

    *-- Propriedades da tabela SigOpFpo
    this_cCidChaves  = ""    && PK char(20) - chave unica gerada
    this_cDopes      = ""    && char(20) - codigo da operacao (FK SigCdOpe)
    this_cFPags      = ""    && char(12) - condicao de pagamento (FK SigOpFp)
    this_nObrigs     = 0     && numeric(1,0) - obrigatorio (0/1)
    this_nAutos      = 0     && numeric(1,0) - so automatico (0/1)
    this_nContabs    = 0     && numeric(1,0) - nao contabilizar (0/1)
    this_cFPagss     = ""    && char(12) - condicao substituta
    this_nBlqAltExc  = 0     && numeric(1,0) - bloqueado para alterar/excluir (0/1)

    *-- Contexto de operacao corrente (preenchido pelo Form antes de Buscar)
    this_cDopesAtual = ""    && codigo da operacao em edicao

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigOpFpo"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(CidChaves, "C")
            THIS.this_cDopes      = TratarNulo(Dopes,     "C")
            THIS.this_cFPags      = TratarNulo(FPags,     "C")
            THIS.this_nObrigs     = TratarNulo(Obrigs,    "N")
            THIS.this_nAutos      = TratarNulo(Autos,     "N")
            THIS.this_nContabs    = TratarNulo(Contabs,   "N")
            THIS.this_cFPagss     = TratarNulo(FPagss,    "C")
            THIS.this_nBlqAltExc  = TratarNulo(BlqAltExc, "N")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo CidChaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cChave)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo" + ;
                       " WHERE CidChaves = " + EscaparSQL(ALLTRIM(par_cChave))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaFpo")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_CarregaFpo") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_CarregaFpo")
                IF loc_lResultado
                    THIS.this_lNovoRegistro = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_CarregaFpo")
            USE IN cursor_4c_CarregaFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega registros de SigOpFpo filtrados por Dopes
    * Retorna cursor_4c_Dados com as condicoes de pagamento da operacao
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cWhere
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""

            IF !EMPTY(ALLTRIM(THIS.this_cDopesAtual))
                loc_cWhere = "WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopesAtual))
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                IF EMPTY(loc_cWhere)
                    loc_cWhere = "WHERE " + par_cFiltro
                ELSE
                    loc_cWhere = loc_cWhere + " AND " + par_cFiltro
                ENDIF
            ENDIF

            loc_cSQL = "SELECT CidChaves, Dopes, FPags, Obrigs, Autos, Contabs," + ;
                       " FPagss, BlqAltExc" + ;
                       " FROM SigOpFpo " + loc_cWhere + ;
                       " ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Buscar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarCondicoesPagamento - Carrega SigOpFp disponivel em crSigOpFp
    * Usado pelo lookup do campo FPags no grid
    *--------------------------------------------------------------------------
    PROCEDURE BuscarCondicoesPagamento()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT FPags, Fparcs, Situas FROM SigOpFp ORDER BY FPags"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crSigOpFp")
            IF loc_nResultado >= 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - BuscarCondicoesPagamento")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - BuscarCondicoesPagamento")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDuplicados - Valida se ha FPags duplicados no cursor
    * Retorna .T. se valido (sem duplicatas), .F. se ha duplicatas
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDuplicados(par_cCursorDados)
        LOCAL loc_lResultado, loc_cFPagsAnt, loc_cFPagsAtual
        loc_lResultado = .T.

        IF !USED(par_cCursorDados)
            RETURN .T.
        ENDIF

        TRY
            *-- Ordena copia do cursor por FPags para detectar adjacentes iguais
            SELECT FPags FROM (par_cCursorDados) ;
                WHERE !EMPTY(ALLTRIM(FPags)) ORDER BY FPags ;
                INTO CURSOR cursor_4c_SortFpo

            IF USED("cursor_4c_SortFpo")
                SELECT cursor_4c_SortFpo
                GO TOP
                loc_cFPagsAnt = ""
                SCAN
                    loc_cFPagsAtual = ALLTRIM(FPags)
                    IF loc_cFPagsAtual == loc_cFPagsAnt
                        MsgAviso("Condi" + CHR(231) + CHR(227) + "o de Pagamento " + ;
                            loc_cFPagsAtual + " Digitada em Duplicidade!!!!", ;
                            "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lResultado = .F.
                        EXIT
                    ENDIF
                    loc_cFPagsAnt = loc_cFPagsAtual
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ValidarDuplicados")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_SortFpo")
            USE IN cursor_4c_SortFpo
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarLote - Salva todos os registros do grid de volta ao SigOpFpo
    * par_cDopes: codigo da operacao
    * par_cCursorDados: alias do cursor com os dados do grid (ex: crSigOpFpo)
    * Logica: valida duplicatas, gera chaves, delete+insert atomico no SQL Server
    *--------------------------------------------------------------------------
    PROCEDURE SalvarLote(par_cDopes, par_cCursorDados)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_lTransacaoAberta, loc_lErroInsert
        loc_lResultado    = .F.
        loc_lTransacaoAberta = .F.
        loc_lErroInsert   = .F.

        *-- Validacoes de entrada ANTES do TRY (retornos validos aqui)
        IF EMPTY(ALLTRIM(par_cDopes))
            MsgAviso("C" + CHR(243) + "digo da opera" + CHR(231) + CHR(227) + ;
                "o n" + CHR(227) + "o informado", "")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorDados)
            MsgAviso("Cursor de dados n" + CHR(227) + "o encontrado", "")
            RETURN .F.
        ENDIF

        IF !THIS.ValidarDuplicados(par_cCursorDados)
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar CidChaves para linhas novas (FPags nao vazio, CidChaves vazio)
            SELECT (par_cCursorDados)
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(FPags)) AND EMPTY(ALLTRIM(CidChaves))
                    loc_cCidChaves = fUniqueIds()
                    REPLACE CidChaves WITH loc_cCidChaves IN (par_cCursorDados)
                ENDIF
            ENDSCAN

            *-- Abrir transacao atomica
            loc_nResultado = SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            IF loc_nResultado >= 0
                loc_lTransacaoAberta = .T.

                *-- Deletar todos os registros existentes da operacao
                loc_cSQL = "DELETE FROM SigOpFpo WHERE Dopes = " + ;
                    EscaparSQL(ALLTRIM(par_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    *-- Reinserir as linhas validas (com FPags preenchido)
                    SELECT (par_cCursorDados)
                    GO TOP
                    SCAN WHILE !loc_lErroInsert
                        IF !EMPTY(ALLTRIM(FPags))
                            THIS.this_cCidChaves = ALLTRIM(CidChaves)
                            THIS.this_cDopes     = ALLTRIM(Dopes)
                            THIS.this_cFPags     = ALLTRIM(FPags)
                            THIS.this_nObrigs    = NVL(Obrigs, 0)
                            THIS.this_nAutos     = NVL(Autos, 0)
                            THIS.this_nContabs   = NVL(Contabs, 0)
                            THIS.this_cFPagss    = ALLTRIM(NVL(FPagss, ""))
                            THIS.this_nBlqAltExc = NVL(BlqAltExc, 0)
                            IF !THIS.Inserir()
                                loc_lErroInsert = .T.
                            ENDIF
                        ENDIF
                    ENDSCAN
                ELSE
                    THIS.this_cMensagemErro = CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao excluir registros anteriores")
                    loc_lErroInsert = .T.
                ENDIF

                IF !loc_lErroInsert
                    loc_nResultado = SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
                    IF loc_nResultado >= 0
                        loc_lTransacaoAberta = .F.
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ELSE
                        THIS.this_cMensagemErro = CapturarErroSQL()
                        MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote COMMIT")
                    ENDIF
                ENDIF

                IF loc_lTransacaoAberta
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                ENDIF
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - SalvarLote BEGIN TRANSACTION")
            ENDIF

        CATCH TO loc_oErro
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - SalvarLote")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um unico registro em SigOpFpo
    * Chamado por SalvarLote e por BusinessBase.Salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCidChaves))
                THIS.this_cCidChaves = fUniqueIds()
            ENDIF

            loc_cSQL = "INSERT INTO SigOpFpo" + ;
                " (CidChaves, Dopes, FPags, Obrigs, Autos, Contabs, FPagss, BlqAltExc)" + ;
                " VALUES (" + ;
                EscaparSQL(THIS.this_cCidChaves)  + ", " + ;
                EscaparSQL(THIS.this_cDopes)       + ", " + ;
                EscaparSQL(THIS.this_cFPags)       + ", " + ;
                FormatarNumeroSQL(THIS.this_nObrigs)   + ", " + ;
                FormatarNumeroSQL(THIS.this_nAutos)    + ", " + ;
                FormatarNumeroSQL(THIS.this_nContabs)  + ", " + ;
                EscaparSQL(THIS.this_cFPagss)      + ", " + ;
                FormatarNumeroSQL(THIS.this_nBlqAltExc) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Inserir")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro em SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigOpFpo SET" + ;
                " Dopes    = " + EscaparSQL(THIS.this_cDopes)          + ", " + ;
                " FPags    = " + EscaparSQL(THIS.this_cFPags)          + ", " + ;
                " Obrigs   = " + FormatarNumeroSQL(THIS.this_nObrigs)  + ", " + ;
                " Autos    = " + FormatarNumeroSQL(THIS.this_nAutos)   + ", " + ;
                " Contabs  = " + FormatarNumeroSQL(THIS.this_nContabs) + ", " + ;
                " FPagss   = " + EscaparSQL(THIS.this_cFPagss)         + ", " + ;
                " BlqAltExc= " + FormatarNumeroSQL(THIS.this_nBlqAltExc) + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - Atualizar")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de um registro de SigOpFpo pelo CidChaves
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigOpFpo" + ;
                " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro - ExecutarExclusao")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro - ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

