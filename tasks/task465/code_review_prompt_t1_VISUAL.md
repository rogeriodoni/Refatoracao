# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMPD.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (5307 linhas total):

*-- Linhas 26 a 34:
26:         LOCAL loc_lSucesso
27:         loc_lSucesso = .F.
28:         TRY
29:             THIS.Caption = "Movimenta" + CHR(231) + CHR(245) + ;
30:                 "es de Produ" + CHR(231) + CHR(227) + "o"
31:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
32:             THIS.this_oBusinessObject = CREATEOBJECT("MPDBO")
33:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
34:                 MostrarErro("Erro ao criar MPDBO", "FormMPD.InicializarForm")

*-- Linhas 51 a 66:
51:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
52:             WITH THIS.pgf_4c_Paginas
53:                 .PageCount = 2
54:                 .Top       = -29
55:                 .Left      = 0
56:                 .Width     = THIS.Width
57:                 .Height    = THIS.Height + 29
58:                 .Tabs      = .F.
59:                 .Visible   = .T.
60:                 .Page1.Caption = "Lista"
61:                 .Page2.Caption = "Dados"
62:                 .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
63:                 .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
64:             ENDWITH
65:             THIS.ConfigurarContaineresPage1()
66:             THIS.ConfigurarContaineresPage2()

*-- Linhas 77 a 139:
77:         TRY
78:             loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
79:             WITH loc_oPg.cnt_4c_Cabecalho
80:                 .Top        = 31
81:                 .Left       = 0
82:                 .Width      = THIS.Width
83:                 .Height     = 80
84:                 .BackColor  = RGB(100, 100, 100)
85:                 .BorderWidth = 0
86:                 .Visible    = .T.
87:                 .AddObject("lbl_4c_Sombra", "Label")
88:                 WITH .lbl_4c_Sombra
89:                     .Top      = 15
90:                     .Left     = 12
91:                     .Width    = THIS.Width
92:                     .Height   = 40
93:                     .AutoSize = .F.
94:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
95:                         "es de Produ" + CHR(231) + CHR(227) + "o"
96:                     .FontName = "Tahoma"
97:                     .FontSize = 16
98:                     .FontBold = .T.
99:                     .ForeColor = RGB(0,0,0)
100:                     .BackStyle = 0
101:                     .Visible  = .T.
102:                 ENDWITH
103:                 .AddObject("lbl_4c_Titulo", "Label")
104:                 WITH .lbl_4c_Titulo
105:                     .Top      = 18
106:                     .Left     = 10
107:                     .Width    = THIS.Width
108:                     .Height   = 46
109:                     .AutoSize = .F.
110:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
111:                         "es de Produ" + CHR(231) + CHR(227) + "o"
112:                     .FontName = "Tahoma"
113:                     .FontSize = 16
114:                     .FontBold = .T.
115:                     .ForeColor = RGB(255,255,255)
116:                     .BackStyle = 0
117:                     .Visible  = .T.
118:                 ENDWITH
119:             ENDWITH
120:             loc_oPg.AddObject("cnt_4c_Botoes", "Container")
121:             WITH loc_oPg.cnt_4c_Botoes
122:                 .Top        = 29
123:                 .Left       = 542
124:                 .Width      = 390
125:                 .Height     = 85
126:                 .BackStyle  = 1
127:                 .BackColor  = RGB(53,53,53)
128:                 .BorderWidth = 0
129:                 .Visible    = .T.
130:             ENDWITH
131:             loc_oPg.AddObject("cnt_4c_Saida", "Container")
132:             WITH loc_oPg.cnt_4c_Saida
133:                 .Top        = 29
134:                 .Left       = 917
135:                 .Width      = 90
136:                 .Height     = 85
137:                 .BackStyle  = 0
138:                 .BorderWidth = 0
139:                 .Visible    = .T.

*-- Linhas 149 a 209:
149:         TRY
150:             loc_oPg.AddObject("cnt_4c_Cabecalho", "Container")
151:             WITH loc_oPg.cnt_4c_Cabecalho
152:                 .Top        = 31
153:                 .Left       = 0
154:                 .Width      = THIS.Width
155:                 .Height     = 80
156:                 .BackColor  = RGB(100, 100, 100)
157:                 .BorderWidth = 0
158:                 .Visible    = .T.
159:                 .AddObject("lbl_4c_Sombra", "Label")
160:                 WITH .lbl_4c_Sombra
161:                     .Top      = 15
162:                     .Left     = 12
163:                     .Width    = THIS.Width
164:                     .Height   = 40
165:                     .AutoSize = .F.
166:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
167:                         "es de Produ" + CHR(231) + CHR(227) + "o"
168:                     .FontName = "Tahoma"
169:                     .FontSize = 16
170:                     .FontBold = .T.
171:                     .ForeColor = RGB(0,0,0)
172:                     .BackStyle = 0
173:                     .Visible  = .T.
174:                 ENDWITH
175:                 .AddObject("lbl_4c_Titulo", "Label")
176:                 WITH .lbl_4c_Titulo
177:                     .Top      = 18
178:                     .Left     = 10
179:                     .Width    = THIS.Width
180:                     .Height   = 46
181:                     .AutoSize = .F.
182:                     .Caption  = "Movimenta" + CHR(231) + CHR(245) + ;
183:                         "es de Produ" + CHR(231) + CHR(227) + "o"
184:                     .FontName = "Tahoma"
185:                     .FontSize = 16
186:                     .FontBold = .T.
187:                     .ForeColor = RGB(255,255,255)
188:                     .BackStyle = 0
189:                     .Visible  = .T.
190:                 ENDWITH
191:             ENDWITH
192:             loc_oPg.AddObject("cnt_4c_BotoesAcao", "Container")
193:             WITH loc_oPg.cnt_4c_BotoesAcao
194:                 .Top         = 33
195:                 .Left        = 842
196:                 .Width       = 160
197:                 .Height      = 85
198:                 .BackStyle   = 0
199:                 .Visible     = .T.
200:             ENDWITH
201:             loc_oPg.AddObject("cnt_4c_Saida", "Container")
202:             WITH loc_oPg.cnt_4c_Saida
203:                 .Top        = 29
204:                 .Left       = 917
205:                 .Width      = 90
206:                 .Height     = 85
207:                 .BackStyle  = 0
208:                 .BorderWidth = 0
209:                 .Visible    = .T.

*-- Linhas 218 a 350:
218:         loc_oPg = THIS.pgf_4c_Paginas.Page1
219:         TRY
220:             loc_oCnt = loc_oPg.cnt_4c_Botoes
221:             loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
222:             WITH loc_oCnt.cmd_4c_Incluir
223:                 .Top      = 5
224:                 .Left     = 5
225:                 .Width    = 75
226:                 .Height   = 75
227:                 .Caption  = "Incluir"
228:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
229:                 .FontName = "Tahoma"
230:                 .FontSize = 8
231:                 .Themes   = .F.
232:                 .Visible  = .T.
233:             ENDWITH
234:             BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
235:             loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
236:             WITH loc_oCnt.cmd_4c_Visualizar
237:                 .Top      = 5
238:                 .Left     = 82
239:                 .Width    = 75
240:                 .Height   = 75
241:                 .Caption  = "Visualizar"
242:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
243:                 .FontName = "Tahoma"
244:                 .FontSize = 8
245:                 .Themes   = .F.
246:                 .Visible  = .T.
247:             ENDWITH
248:             BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
249:             loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
250:             WITH loc_oCnt.cmd_4c_Alterar
251:                 .Top      = 5
252:                 .Left     = 159
253:                 .Width    = 75
254:                 .Height   = 75
255:                 .Caption  = "Alterar"
256:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
257:                 .FontName = "Tahoma"
258:                 .FontSize = 8
259:                 .Themes   = .F.
260:                 .Visible  = .T.
261:             ENDWITH
262:             BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
263:             loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
264:             WITH loc_oCnt.cmd_4c_Excluir
265:                 .Top      = 5
266:                 .Left     = 236
267:                 .Width    = 75
268:                 .Height   = 75
269:                 .Caption  = "Excluir"
270:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
271:                 .FontName = "Tahoma"
272:                 .FontSize = 8
273:                 .Themes   = .F.
274:                 .Visible  = .T.
275:             ENDWITH
276:             BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
277:             loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
278:             WITH loc_oCnt.cmd_4c_Buscar
279:                 .Top      = 5
280:                 .Left     = 313
281:                 .Width    = 75
282:                 .Height   = 75
283:                 .Caption  = "Buscar"
284:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:                 .FontName = "Tahoma"
286:                 .FontSize = 8
287:                 .Themes   = .F.
288:                 .Visible  = .T.
289:             ENDWITH
290:             BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
291:             loc_oCnt = loc_oPg.cnt_4c_Saida
292:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
293:             WITH loc_oCnt.cmd_4c_Encerrar
294:                 .Top      = 5
295:                 .Left     = 5
296:                 .Width    = 75
297:                 .Height   = 75
298:                 .Caption  = "Encerrar"
299:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
300:                 .FontName = "Tahoma"
301:                 .FontSize = 8
302:                 .Themes   = .F.
303:                 .Visible  = .T.
304:             ENDWITH
305:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
306:             loc_oPg.AddObject("cmd_4c_CadOpe", "CommandButton")
307:             WITH loc_oPg.cmd_4c_CadOpe
308:                 .Top      = 33
309:                 .Left     = 324
310:                 .Width    = 60
311:                 .Height   = 75
312:                 .Caption  = "Estoque"
313:                 .FontName = "Tahoma"
314:                 .FontSize = 8
315:                 .Themes   = .T.
316:                 .Visible  = .T.
317:             ENDWITH
318:             loc_oPg.AddObject("cmd_4c_ExpXML", "CommandButton")
319:             WITH loc_oPg.cmd_4c_ExpXML
320:                 .Top      = 33
321:                 .Left     = 399
322:                 .Width    = 60
323:                 .Height   = 75
324:                 .Caption  = "Exporta XML"
325:                 .FontName = "Tahoma"
326:                 .FontSize = 8
327:                 .Themes   = .T.
328:                 .Visible  = .T.
329:             ENDWITH
330:             loc_oPg.AddObject("cmd_4c_ImpXML", "CommandButton")
331:             WITH loc_oPg.cmd_4c_ImpXML
332:                 .Top      = 33
333:                 .Left     = 474
334:                 .Width    = 60
335:                 .Height   = 75
336:                 .Caption  = "Importa XML"
337:                 .FontName = "Tahoma"
338:                 .FontSize = 8
339:                 .Themes   = .T.
340:                 .Visible  = .T.
341:             ENDWITH
342:             loc_oPg.AddObject("grd_4c_Lista", "Grid")
343:             WITH loc_oPg.grd_4c_Lista
344:                 .Top          = 117
345:                 .Left         = 26
346:                 .Width        = 890
347:                 .Height       = 450
348:                 .ReadOnly     = .T.
349:                 .GridLines    = 1
350:                 .RowHeight    = 20

*-- Linhas 377 a 394:
377:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
378:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
379:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
380:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
381:                     .Column1.Width           = 300
382:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
383:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
384:                     .Column2.Width           = 80
385:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
386:                     .Column3.Header1.Caption = "Ordem"
387:                     .Column3.Width           = 60
388:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
389:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
390:                     .Column4.Width           = 420
391:                 ENDWITH
392:                 loc_lSucesso = .T.
393:             ENDIF
394:             THIS.AjustarBotoesPorModo()

*-- Linhas 491 a 508:
491:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
492:                 WITH THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
493:                     .Column1.ControlSource   = "cursor_4c_Dados.Dopps"
494:                     .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
495:                     .Column1.Width           = 300
496:                     .Column2.ControlSource   = "cursor_4c_Dados.Ndopps"
497:                     .Column2.Header1.Caption = "No. Opera" + CHR(231) + CHR(227) + "o"
498:                     .Column2.Width           = 80
499:                     .Column3.ControlSource   = "cursor_4c_Dados.Ordes"
500:                     .Column3.Header1.Caption = "Ordem"
501:                     .Column3.Width           = 60
502:                     .Column4.ControlSource   = "cursor_4c_Dados.Hists"
503:                     .Column4.Header1.Caption = "Hist" + CHR(243) + "rico"
504:                     .Column4.Width           = 420
505:                 ENDWITH
506:             ENDIF
507:         CATCH TO loException
508:             MostrarErro(loException, "FormMPD.BtnBuscarClick")

*-- Linhas 549 a 684:
549:         TRY
550:             loc_oPg.cnt_4c_Cabecalho.Visible = .F.
551:             loc_oCnt = loc_oPg.cnt_4c_BotoesAcao
552:             loc_oCnt.AddObject("cmd_4c_Salvar", "CommandButton")
553:             WITH loc_oCnt.cmd_4c_Salvar
554:                 .Top      = 5
555:                 .Left     = 5
556:                 .Width    = 75
557:                 .Height   = 75
558:                 .Caption  = "Salvar"
559:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_gravar_60.jpg"
560:                 .FontName = "Tahoma"
561:                 .FontSize = 8
562:                 .Themes   = .F.
563:                 .Visible  = .T.
564:             ENDWITH
565:             BINDEVENT(loc_oCnt.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
566:             loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
567:             WITH loc_oCnt.cmd_4c_Cancelar
568:                 .Top      = 5
569:                 .Left     = 82
570:                 .Width    = 75
571:                 .Height   = 75
572:                 .Caption  = "Encerrar"
573:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
574:                 .FontName = "Tahoma"
575:                 .FontSize = 8
576:                 .Themes   = .F.
577:                 .Visible  = .T.
578:             ENDWITH
579:             BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
580:             loc_oCnt = loc_oPg.cnt_4c_Saida
581:             loc_oCnt.AddObject("cmd_4c_Encerrar", "CommandButton")
582:             WITH loc_oCnt.cmd_4c_Encerrar
583:                 .Top      = 5
584:                 .Left     = 5
585:                 .Width    = 75
586:                 .Height   = 75
587:                 .Caption  = "Encerrar"
588:                 .Picture  = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
589:                 .FontName = "Tahoma"
590:                 .FontSize = 8
591:                 .Themes   = .F.
592:                 .Visible  = .T.
593:             ENDWITH
594:             BINDEVENT(loc_oCnt.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
595:             * Campos de cabecalho da aba Dados (top + 29 compensa pgf_4c_Paginas.Top=-29)
596:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
597:             WITH loc_oPg.lbl_4c_Label1
598:                 .Top       = 74
599:                 .Left      = 64
600:                 .Width     = 58
601:                 .Height    = 15
602:                 .AutoSize  = .F.
603:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o : "
604:                 .BackStyle = 0
605:                 .Visible   = .T.
606:             ENDWITH
607:             loc_oPg.AddObject("txt_4c_Desc", "TextBox")
608:             WITH loc_oPg.txt_4c_Desc
609:                 .Top       = 70
610:                 .Left      = 132
611:                 .Width     = 150
612:                 .Height    = 23
613:                 .MaxLength = 40
614:                 .Visible   = .T.
615:             ENDWITH
616:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
617:             WITH loc_oPg.lbl_4c_Label25
618:                 .Top       = 74
619:                 .Left      = 332
620:                 .Width     = 71
621:                 .Height    = 15
622:                 .AutoSize  = .F.
623:                 .Caption   = "N" + CHR(186) + " Opera" + CHR(231) + CHR(227) + "o :"
624:                 .BackStyle = 0
625:                 .Visible   = .T.
626:             ENDWITH
627:             loc_oPg.AddObject("txt_4c_Nope", "TextBox")
628:             WITH loc_oPg.txt_4c_Nope
629:                 .Top      = 70
630:                 .Left     = 416
631:                 .Width    = 29
632:                 .Height   = 23
633:                 .ReadOnly = .T.
634:                 .Visible  = .T.
635:             ENDWITH
636:             loc_oPg.AddObject("lbl_4c_Label28", "Label")
637:             WITH loc_oPg.lbl_4c_Label28
638:                 .Top       = 74
639:                 .Left      = 466
640:                 .Width     = 44
641:                 .Height    = 15
642:                 .AutoSize  = .F.
643:                 .Caption   = "Ordem : "
644:                 .BackStyle = 0
645:                 .Visible   = .T.
646:             ENDWITH
647:             loc_oPg.AddObject("txt_4c_Ordem", "TextBox")
648:             WITH loc_oPg.txt_4c_Ordem
649:                 .Top     = 71
650:                 .Left    = 518
651:                 .Width   = 27
652:                 .Height  = 21
653:                 .Visible = .T.
654:             ENDWITH
655:             loc_oPg.AddObject("obj_4c_CmdGarqicone", "CommandButton")
656:             WITH loc_oPg.obj_4c_CmdGarqicone
657:                 .Top     = 69
658:                 .Left    = 287
659:                 .Width   = 25
660:                 .Height  = 25
661:                 .Caption = "..."
662:                 .Themes  = .T.
663:                 .Visible = .T.
664:             ENDWITH
665:             BINDEVENT(loc_oPg.obj_4c_CmdGarqicone, "Click", THIS, "CmdGarqiconeClick")
666:             * PageFrame interno: 5 abas (Operacao, Estoque, Componente, Documento, Diversas)
667:             loc_oPg.AddObject("pgf_4c_PagDados", "PageFrame")
668:             WITH loc_oPg.pgf_4c_PagDados
669:                 .Top       = 150
670:                 .Left      = 6
671:                 .Width     = 987
672:                 .Height    = 475
673:                 .PageCount = 5
674:                 .Visible   = .T.
675:                 .Page1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
676:                 .Page2.Caption = "Estoque"
677:                 .Page3.Caption = "Componente"
678:                 .Page4.Caption = "Documento"
679:                 .Page5.Caption = "Diversas"
680:             ENDWITH
681:             THIS.ConfigurarPgOperacao()
682:             THIS.ConfigurarPgEstoque()
683:             THIS.ConfigurarPgComponente()
684:             THIS.ConfigurarPgDocumento()

*-- Linhas 695 a 1688:
695:         TRY
696:             loc_oPg.AddObject("shp_4c_Shape7", "Shape")
697:             WITH loc_oPg.shp_4c_Shape7
698:                 .Top     = 192
699:                 .Left    = 7
700:                 .Width   = 287
701:                 .Height  = 162
702:                 .Visible = .T.
703:             ENDWITH
704:             * Labels coluna esquerda
705:             loc_oPg.AddObject("lbl_4c_Label36", "Label")
706:             WITH loc_oPg.lbl_4c_Label36
707:                 .Top       = 15
708:                 .Left      = 60
709:                 .Width     = 60
710:                 .Height    = 15
711:                 .AutoSize  = .F.
712:                 .Caption   = "Imagem : "
713:                 .BackStyle = 0
714:                 .Visible   = .T.
715:             ENDWITH
716:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
717:             WITH loc_oPg.lbl_4c_Label2
718:                 .Top       = 34
719:                 .Left      = 68
720:                 .Width     = 60
721:                 .Height    = 15
722:                 .AutoSize  = .F.
723:                 .Caption   = "Boleto : "
724:                 .BackStyle = 0
725:                 .Visible   = .T.
726:             ENDWITH
727:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
728:             WITH loc_oPg.lbl_4c_Label31
729:                 .Top       = 54
730:                 .Left      = 44
731:                 .Width     = 80
732:                 .Height    = 15
733:                 .AutoSize  = .F.
734:                 .Caption   = "Documento : "
735:                 .BackStyle = 0
736:                 .Visible   = .T.
737:             ENDWITH
738:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
739:             WITH loc_oPg.lbl_4c_Label6
740:                 .Top       = 74
741:                 .Left      = 84
742:                 .Width     = 30
743:                 .Height    = 15
744:                 .AutoSize  = .F.
745:                 .Caption   = "OP : "
746:                 .BackStyle = 0
747:                 .Visible   = .T.
748:             ENDWITH
749:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
750:             WITH loc_oPg.lbl_4c_Label7
751:                 .Top       = 94
752:                 .Left      = 32
753:                 .Width     = 90
754:                 .Height    = 15
755:                 .AutoSize  = .F.
756:                 .Caption   = "Componentes : "
757:                 .BackStyle = 0
758:                 .Visible   = .T.
759:             ENDWITH
760:             loc_oPg.AddObject("lbl_4c_Label9", "Label")
761:             WITH loc_oPg.lbl_4c_Label9
762:                 .Top       = 116
763:                 .Left      = 14
764:                 .Width     = 105
765:                 .Height    = 15
766:                 .AutoSize  = .F.
767:                 .Caption   = "Aparece no Menu : "
768:                 .BackStyle = 0
769:                 .Visible   = .T.
770:             ENDWITH
771:             loc_oPg.AddObject("lbl_4c_Label21", "Label")
772:             WITH loc_oPg.lbl_4c_Label21
773:                 .Top       = 136
774:                 .Left      = 23
775:                 .Width     = 100
776:                 .Height    = 15
777:                 .AutoSize  = .F.
778:                 .Caption   = "Op. Autom" + CHR(225) + "tica : "
779:                 .BackStyle = 0
780:                 .Visible   = .T.
781:             ENDWITH
782:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
783:             WITH loc_oPg.lbl_4c_Label10
784:                 .Top       = 158
785:                 .Left      = 20
786:                 .Width     = 87
787:                 .Height    = 15
788:                 .AutoSize  = .F.
789:                 .Caption   = "Hist" + CHR(243) + "rico Padr" + CHR(227) + "o : "
790:                 .BackStyle = 0
791:                 .Visible   = .T.
792:             ENDWITH
793:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
794:             WITH loc_oPg.lbl_4c_Label8
795:                 .Top       = 178
796:                 .Left      = 7
797:                 .Width     = 138
798:                 .Height    = 15
799:                 .AutoSize  = .F.
800:                 .Caption   = "Tratamento do SubN" + CHR(237) + "vel"
801:                 .BackStyle = 0
802:                 .Visible   = .T.
803:             ENDWITH
804:             loc_oPg.AddObject("lbl_4c_Label34", "Label")
805:             WITH loc_oPg.lbl_4c_Label34
806:                 .Top       = 198
807:                 .Left      = 61
808:                 .Width     = 100
809:                 .Height    = 15
810:                 .AutoSize  = .F.
811:                 .Caption   = "Tem SubN" + CHR(237) + "vel : "
812:                 .BackStyle = 0
813:                 .Visible   = .T.
814:             ENDWITH
815:             loc_oPg.AddObject("lbl_4c_Label35", "Label")
816:             WITH loc_oPg.lbl_4c_Label35
817:                 .Top       = 220
818:                 .Left      = 84
819:                 .Width     = 70
820:                 .Height    = 15
821:                 .AutoSize  = .F.
822:                 .Caption   = "SubN" + CHR(237) + "vel : "
823:                 .BackStyle = 0
824:                 .Visible   = .T.
825:             ENDWITH
826:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
827:             WITH loc_oPg.lbl_4c_Label4
828:                 .Top       = 241
829:                 .Left      = 40
830:                 .Width     = 97
831:                 .Height    = 15
832:                 .AutoSize  = .F.
833:                 .Caption   = "T" + CHR(237) + "tulo do SubN" + CHR(237) + "vel : "
834:                 .BackStyle = 0
835:                 .Visible   = .T.
836:             ENDWITH
837:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
838:             WITH loc_oPg.lbl_4c_Label5
839:                 .Top       = 262
840:                 .Left      = 37
841:                 .Width     = 100
842:                 .Height    = 15
843:                 .AutoSize  = .F.
844:                 .Caption   = "Artigo do SubN" + CHR(237) + "vel : "
845:                 .BackStyle = 0
846:                 .Visible   = .T.
847:             ENDWITH
848:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
849:             WITH loc_oPg.lbl_4c_Label1
850:                 .Top       = 285
851:                 .Left      = 21
852:                 .Width     = 130
853:                 .Height    = 15
854:                 .AutoSize  = .F.
855:                 .Caption   = "Faz Baixa Autom" + CHR(225) + "tica ? "
856:                 .BackStyle = 0
857:                 .Visible   = .T.
858:             ENDWITH
859:             loc_oPg.AddObject("lbl_4c_Label23", "Label")
860:             WITH loc_oPg.lbl_4c_Label23
861:                 .Top       = 305
862:                 .Left      = 53
863:                 .Width     = 90
864:                 .Height    = 15
865:                 .AutoSize  = .F.
866:                 .Caption   = "Excluir Subnivel ?"
867:                 .BackStyle = 0
868:                 .Visible   = .T.
869:             ENDWITH
870:             loc_oPg.AddObject("lbl_4c_Label28", "Label")
871:             WITH loc_oPg.lbl_4c_Label28
872:                 .Top       = 325
873:                 .Left      = 54
874:                 .Width     = 83
875:                 .Height    = 15
876:                 .AutoSize  = .F.
877:                 .Caption   = "Checa SubN" + CHR(237) + "vel : "
878:                 .BackStyle = 0
879:                 .Visible   = .T.
880:             ENDWITH
881:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
882:             WITH loc_oPg.lbl_4c_Label25
883:                 .Top       = 360
884:                 .Left      = 18
885:                 .Width     = 140
886:                 .Height    = 15
887:                 .AutoSize  = .F.
888:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o Bx Empenho : "
889:                 .BackStyle = 0
890:                 .Visible   = .T.
891:             ENDWITH
892:             loc_oPg.AddObject("lbl_4c_Label27", "Label")
893:             WITH loc_oPg.lbl_4c_Label27
894:                 .Top       = 384
895:                 .Left      = 47
896:                 .Width     = 108
897:                 .Height    = 15
898:                 .AutoSize  = .F.
899:                 .Caption   = "Somente p/ Empresa : "
900:                 .BackStyle = 0
901:                 .Visible   = .T.
902:             ENDWITH
903:             * Labels coluna direita
904:             loc_oPg.AddObject("lbl_4c_Label3", "Label")
905:             WITH loc_oPg.lbl_4c_Label3
906:                 .Top       = 14
907:                 .Left      = 497
908:                 .Width     = 160
909:                 .Height    = 15
910:                 .AutoSize  = .F.
911:                 .Caption   = "Checa Sequ" + CHR(234) + "ncia de Produ" + CHR(231) + CHR(227) + "o : "
912:                 .BackStyle = 0
913:                 .Visible   = .T.
914:             ENDWITH
915:             loc_oPg.AddObject("lbl_4c_Label11", "Label")
916:             WITH loc_oPg.lbl_4c_Label11
917:                 .Top       = 35
918:                 .Left      = 538
919:                 .Width     = 120
920:                 .Height    = 15
921:                 .AutoSize  = .F.
922:                 .Caption   = "Agrega Mat" + CHR(233) + "ria-Prima : "
923:                 .BackStyle = 0
924:                 .Visible   = .T.
925:             ENDWITH
926:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
927:             WITH loc_oPg.lbl_4c_Label12
928:                 .Top       = 55
929:                 .Left      = 523
930:                 .Width     = 135
931:                 .Height    = 15
932:                 .AutoSize  = .F.
933:                 .Caption   = "Checa Repeti" + CHR(231) + CHR(227) + "o de Fase : "
934:                 .BackStyle = 0
935:                 .Visible   = .T.
936:             ENDWITH
937:             loc_oPg.AddObject("lbl_4c_Label14", "Label")
938:             WITH loc_oPg.lbl_4c_Label14
939:                 .Top       = 75
940:                 .Left      = 529
941:                 .Width     = 130
942:                 .Height    = 15
943:                 .AutoSize  = .F.
944:                 .Caption   = "Checa Saldo de Estoque : "
945:                 .BackStyle = 0
946:                 .Visible   = .T.
947:             ENDWITH
948:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
949:             WITH loc_oPg.lbl_4c_Label15
950:                 .Top       = 95
951:                 .Left      = 514
952:                 .Width     = 145
953:                 .Height    = 15
954:                 .AutoSize  = .F.
955:                 .Caption   = "Inibir Mensagens Seq. Prod : "
956:                 .BackStyle = 0
957:                 .Visible   = .T.
958:             ENDWITH
959:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
960:             WITH loc_oPg.lbl_4c_Label16
961:                 .Top       = 116
962:                 .Left      = 547
963:                 .Width     = 115
964:                 .Height    = 15
965:                 .AutoSize  = .F.
966:                 .Caption   = "Mensagem de Falha : "
967:                 .BackStyle = 0
968:                 .Visible   = .T.
969:             ENDWITH
970:             loc_oPg.AddObject("lbl_4c_Label17", "Label")
971:             WITH loc_oPg.lbl_4c_Label17
972:                 .Top       = 137
973:                 .Left      = 493
974:                 .Width     = 165
975:                 .Height    = 15
976:                 .AutoSize  = .F.
977:                 .Caption   = "Busca No. Envelope Autom" + CHR(225) + "tico : "
978:                 .BackStyle = 0
979:                 .Visible   = .T.
980:             ENDWITH
981:             loc_oPg.AddObject("lbl_4c_Label19", "Label")
982:             WITH loc_oPg.lbl_4c_Label19
983:                 .Top       = 157
984:                 .Left      = 546
985:                 .Width     = 115
986:                 .Height    = 15
987:                 .AutoSize  = .F.
988:                 .Caption   = "Bot" + CHR(227) + "o de Retrabalho : "
989:                 .BackStyle = 0
990:                 .Visible   = .T.
991:             ENDWITH
992:             loc_oPg.AddObject("lbl_4c_Label20", "Label")
993:             WITH loc_oPg.lbl_4c_Label20
994:                 .Top       = 176
995:                 .Left      = 530
996:                 .Width     = 130
997:                 .Height    = 15
998:                 .AutoSize  = .F.
999:                 .Caption   = "Bot" + CHR(227) + "o de N" + CHR(227) + "o Conforme : "
1000:                 .BackStyle = 0
1001:                 .Visible   = .T.
1002:             ENDWITH
1003:             loc_oPg.AddObject("lbl_4c_Label22", "Label")
1004:             WITH loc_oPg.lbl_4c_Label22
1005:                 .Top       = 194
1006:                 .Left      = 559
1007:                 .Width     = 100
1008:                 .Height    = 15
1009:                 .AutoSize  = .F.
1010:                 .Caption   = "Bot" + CHR(227) + "o de Servi" + CHR(231) + "os : "
1011:                 .BackStyle = 0
1012:                 .Visible   = .T.
1013:             ENDWITH
1014:             loc_oPg.AddObject("lbl_4c_Label24", "Label")
1015:             WITH loc_oPg.lbl_4c_Label24
1016:                 .Top       = 214
1017:                 .Left      = 559
1018:                 .Width     = 95
1019:                 .Height    = 15
1020:                 .AutoSize  = .F.
1021:                 .Caption   = "Bot" + CHR(227) + "o de Etiqueta : "
1022:                 .BackStyle = 0
1023:                 .Visible   = .T.
1024:             ENDWITH
1025:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
1026:             WITH loc_oPg.lbl_4c_Label13
1027:                 .Top       = 234
1028:                 .Left      = 580
1029:                 .Width     = 74
1030:                 .Height    = 15
1031:                 .AutoSize  = .F.
1032:                 .Caption   = "Apontamento : "
1033:                 .BackStyle = 0
1034:                 .Visible   = .T.
1035:             ENDWITH
1036:             loc_oPg.AddObject("lbl_4c_Label26", "Label")
1037:             WITH loc_oPg.lbl_4c_Label26
1038:                 .Top       = 255
1039:                 .Left      = 647
1040:                 .Width     = 120
1041:                 .Height    = 15
1042:                 .AutoSize  = .F.
1043:                 .Caption   = CHR(205) + "cone Barra Acesso : "
1044:                 .BackStyle = 0
1045:                 .Visible   = .T.
1046:             ENDWITH
1047:             loc_oPg.AddObject("lbl_4c_Label18", "Label")
1048:             WITH loc_oPg.lbl_4c_Label18
1049:                 .Top       = 304
1050:                 .Left      = 538
1051:                 .Width     = 130
1052:                 .Height    = 15
1053:                 .AutoSize  = .F.
1054:                 .Caption   = "Tipo de Movimenta" + CHR(231) + CHR(227) + "o : "
1055:                 .BackStyle = 0
1056:                 .Visible   = .T.
1057:             ENDWITH
1058:             * TextBoxes
1059:             loc_oPg.AddObject("txt_4c_Hists", "TextBox")
1060:             WITH loc_oPg.txt_4c_Hists
1061:                 .Top       = 154
1062:                 .Left      = 108
1063:                 .Width     = 223
1064:                 .Height    = 23
1065:                 .MaxLength = 30
1066:                 .Visible   = .T.
1067:             ENDWITH
1068:             loc_oPg.AddObject("txt_4c_Nivel", "TextBox")
1069:             WITH loc_oPg.txt_4c_Nivel
1070:                 .Top     = 216
1071:                 .Left    = 141
1072:                 .Width   = 150
1073:                 .Height  = 21
1074:                 .Visible = .T.
1075:             ENDWITH
1076:             loc_oPg.AddObject("txt_4c_Titulo", "TextBox")
1077:             WITH loc_oPg.txt_4c_Titulo
1078:                 .Top       = 238
1079:                 .Left      = 141
1080:                 .Width     = 124
1081:                 .Height    = 21
1082:                 .MaxLength = 15
1083:                 .Visible   = .T.
1084:             ENDWITH
1085:             loc_oPg.AddObject("txt_4c_Artigo", "TextBox")
1086:             WITH loc_oPg.txt_4c_Artigo
1087:                 .Top       = 260
1088:                 .Left      = 141
1089:                 .Width     = 17
1090:                 .Height    = 21
1091:                 .MaxLength = 1
1092:                 .Visible   = .T.
1093:             ENDWITH
1094:             loc_oPg.AddObject("txt_4c_ArqIcone", "TextBox")
1095:             WITH loc_oPg.txt_4c_ArqIcone
1096:                 .Top       = 270
1097:                 .Left      = 645
1098:                 .Width     = 110
1099:                 .Height    = 21
1100:                 .MaxLength = 64
1101:                 .ReadOnly  = .T.
1102:                 .Visible   = .T.
1103:             ENDWITH
1104:             loc_oPg.AddObject("txt_4c__Empenho", "TextBox")
1105:             WITH loc_oPg.txt_4c__Empenho
1106:                 .Top       = 357
1107:                 .Left      = 160
1108:                 .Width     = 134
1109:                 .Height    = 23
1110:                 .MaxLength = 20
1111:                 .FontName  = "Courier New"
1112:                 .Visible   = .T.
1113:             ENDWITH
1114:             loc_oPg.AddObject("txt_4c_EmpLanc", "TextBox")
1115:             WITH loc_oPg.txt_4c_EmpLanc
1116:                 .Top      = 381
1117:                 .Left     = 160
1118:                 .Width    = 34
1119:                 .Height   = 23
1120:                 .FontName = "Courier New"
1121:                 .Visible  = .T.
1122:             ENDWITH
1123:             * Image e CommandButton para icone da barra de acesso
1124:             loc_oPg.AddObject("img_4c_ImgIcone", "Image")
1125:             WITH loc_oPg.img_4c_ImgIcone
1126:                 .Top     = 263
1127:                 .Left    = 785
1128:                 .Width   = 32
1129:                 .Height  = 32
1130:                 .Visible = .T.
1131:             ENDWITH
1132:             loc_oPg.AddObject("cmd_4c_CmdIcone", "CommandButton")
1133:             WITH loc_oPg.cmd_4c_CmdIcone
1134:                 .Top     = 268
1135:                 .Left    = 755
1136:                 .Width   = 24
1137:                 .Height  = 24
1138:                 .Caption = "..."
1139:                 .Themes  = .T.
1140:                 .Visible = .T.
1141:             ENDWITH
1142:             BINDEVENT(loc_oPg.cmd_4c_CmdIcone, "Click", THIS, "CmdIconeClick")
1143:             * OptionGroups coluna esquerda
1144:             loc_oPg.AddObject("obj_4c_Op_imagem", "OptionGroup")
1145:             WITH loc_oPg.obj_4c_Op_imagem
1146:                 .Top         = 13
1147:                 .Left        = 108
1148:                 .Width       = 89
1149:                 .Height      = 20
1150:                 .ButtonCount = 2
1151:                 .Visible     = .T.
1152:                 WITH .Buttons(1)
1153:                     .Left    = 3
1154:                     .Caption = "Sim"
1155:                     .Width   = 40
1156:                 ENDWITH
1157:                 WITH .Buttons(2)
1158:                     .Left    = 46
1159:                     .Caption = "N" + CHR(227) + "o"
1160:                     .Width   = 40
1161:                 ENDWITH
1162:             ENDWITH
1163:             loc_oPg.AddObject("obj_4c_Op_boleto", "OptionGroup")
1164:             WITH loc_oPg.obj_4c_Op_boleto
1165:                 .Top         = 32
1166:                 .Left        = 108
1167:                 .Width       = 130
1168:                 .Height      = 17
1169:                 .ButtonCount = 3
1170:                 .Visible     = .T.
1171:                 WITH .Buttons(1)
1172:                     .Left    = 3
1173:                     .Caption = "Sim"
1174:                     .Width   = 38
1175:                 ENDWITH
1176:                 WITH .Buttons(2)
1177:                     .Left    = 44
1178:                     .Caption = "N" + CHR(227) + "o"
1179:                     .Width   = 38
1180:                 ENDWITH
1181:                 WITH .Buttons(3)
1182:                     .Left    = 88
1183:                     .Caption = "Tela"
1184:                     .Width   = 38
1185:                 ENDWITH
1186:             ENDWITH
1187:             loc_oPg.AddObject("obj_4c_Fwoption8", "OptionGroup")
1188:             WITH loc_oPg.obj_4c_Fwoption8
1189:                 .Top         = 52
1190:                 .Left        = 108
1191:                 .Width       = 89
1192:                 .Height      = 20
1193:                 .ButtonCount = 2
1194:                 .Visible     = .T.
1195:                 WITH .Buttons(1)
1196:                     .Left    = 3
1197:                     .Caption = "Sim"
1198:                     .Width   = 40
1199:                 ENDWITH
1200:                 WITH .Buttons(2)
1201:                     .Left    = 46
1202:                     .Caption = "N" + CHR(227) + "o"
1203:                     .Width   = 40
1204:                 ENDWITH
1205:             ENDWITH
1206:             loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
1207:             WITH loc_oPg.obj_4c_Fwoption5
1208:                 .Top         = 73
1209:                 .Left        = 107
1210:                 .Width       = 92
1211:                 .Height      = 20
1212:                 .ButtonCount = 2
1213:                 .Visible     = .T.
1214:                 WITH .Buttons(1)
1215:                     .Left    = 3
1216:                     .Caption = "Sim"
1217:                     .Width   = 40
1218:                 ENDWITH
1219:                 WITH .Buttons(2)
1220:                     .Left    = 46
1221:                     .Caption = "N" + CHR(227) + "o"
1222:                     .Width   = 40
1223:                 ENDWITH
1224:             ENDWITH
1225:             loc_oPg.AddObject("obj_4c_Opt_compo", "OptionGroup")
1226:             WITH loc_oPg.obj_4c_Opt_compo
1227:                 .Top         = 90
1228:                 .Left        = 107
1229:                 .Width       = 89
1230:                 .Height      = 20
1231:                 .ButtonCount = 2
1232:                 .Visible     = .T.
1233:                 WITH .Buttons(1)
1234:                     .Left    = 3
1235:                     .Caption = "Sim"
1236:                     .Width   = 40
1237:                 ENDWITH
1238:                 WITH .Buttons(2)
1239:                     .Left    = 46
1240:                     .Caption = "N" + CHR(227) + "o"
1241:                     .Width   = 40
1242:                 ENDWITH
1243:             ENDWITH
1244:             loc_oPg.AddObject("obj_4c_Opt_Menu", "OptionGroup")
1245:             WITH loc_oPg.obj_4c_Opt_Menu
1246:                 .Top         = 114
1247:                 .Left        = 108
1248:                 .Width       = 89
1249:                 .Height      = 20
1250:                 .ButtonCount = 2
1251:                 .Visible     = .T.
1252:                 WITH .Buttons(1)
1253:                     .Left    = 3
1254:                     .Caption = "Sim"
1255:                     .Width   = 40
1256:                 ENDWITH
1257:                 WITH .Buttons(2)
1258:                     .Left    = 46
1259:                     .Caption = "N" + CHR(227) + "o"
1260:                     .Width   = 40
1261:                 ENDWITH
1262:             ENDWITH
1263:             loc_oPg.AddObject("obj_4c_ObjAutos", "OptionGroup")
1264:             WITH loc_oPg.obj_4c_ObjAutos
1265:                 .Top         = 134
1266:                 .Left        = 108
1267:                 .Width       = 193
1268:                 .Height      = 20
1269:                 .ButtonCount = 3
1270:                 .Visible     = .T.
1271:                 WITH .Buttons(1)
1272:                     .Left    = 3
1273:                     .Caption = "Movim."
1274:                     .Width   = 60
1275:                 ENDWITH
1276:                 WITH .Buttons(2)
1277:                     .Left    = 66
1278:                     .Caption = "Encerra"
1279:                     .Width   = 60
1280:                 ENDWITH
1281:                 WITH .Buttons(3)
1282:                     .Left    = 130
1283:                     .Caption = "Nenhum"
1284:                     .Width   = 60
1285:                 ENDWITH
1286:             ENDWITH
1287:             loc_oPg.AddObject("obj_4c_Op_subn", "OptionGroup")
1288:             WITH loc_oPg.obj_4c_Op_subn
1289:                 .Top         = 195
1290:                 .Left        = 141
1291:                 .Width       = 88
1292:                 .Height      = 20
1293:                 .ButtonCount = 2
1294:                 .Visible     = .T.
1295:                 WITH .Buttons(1)
1296:                     .Left    = 3
1297:                     .Caption = "Sim"
1298:                     .Width   = 40
1299:                 ENDWITH
1300:                 WITH .Buttons(2)
1301:                     .Left    = 46
1302:                     .Caption = "N" + CHR(227) + "o"
1303:                     .Width   = 40
1304:                 ENDWITH
1305:             ENDWITH
1306:             loc_oPg.AddObject("obj_4c_Op_BxAuto", "OptionGroup")
1307:             WITH loc_oPg.obj_4c_Op_BxAuto
1308:                 .Top         = 283
1309:                 .Left        = 141
1310:                 .Width       = 88
1311:                 .Height      = 20
1312:                 .ButtonCount = 2
1313:                 .Visible     = .T.
1314:                 WITH .Buttons(1)
1315:                     .Left    = 3
1316:                     .Caption = "Sim"
1317:                     .Width   = 40
1318:                 ENDWITH
1319:                 WITH .Buttons(2)
1320:                     .Left    = 46
1321:                     .Caption = "N" + CHR(227) + "o"
1322:                     .Width   = 40
1323:                 ENDWITH
1324:             ENDWITH
1325:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
1326:             WITH loc_oPg.obj_4c_Fwoption2
1327:                 .Top         = 303
1328:                 .Left        = 141
1329:                 .Width       = 88
1330:                 .Height      = 20
1331:                 .ButtonCount = 2
1332:                 .Visible     = .T.
1333:                 WITH .Buttons(1)
1334:                     .Left    = 3
1335:                     .Caption = "Sim"
1336:                     .Width   = 40
1337:                 ENDWITH
1338:                 WITH .Buttons(2)
1339:                     .Left    = 46
1340:                     .Caption = "N" + CHR(227) + "o"
1341:                     .Width   = 40
1342:                 ENDWITH
1343:             ENDWITH
1344:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
1345:             WITH loc_oPg.obj_4c_Fwoption1
1346:                 .Top         = 323
1347:                 .Left        = 141
1348:                 .Width       = 88
1349:                 .Height      = 20
1350:                 .ButtonCount = 2
1351:                 .Visible     = .T.
1352:                 WITH .Buttons(1)
1353:                     .Left    = 3
1354:                     .Caption = "Sim"
1355:                     .Width   = 40
1356:                 ENDWITH
1357:                 WITH .Buttons(2)
1358:                     .Left    = 46
1359:                     .Caption = "N" + CHR(227) + "o"
1360:                     .Width   = 40
1361:                 ENDWITH
1362:             ENDWITH
1363:             * OptionGroups coluna direita
1364:             loc_oPg.AddObject("obj_4c_GetSequencia", "OptionGroup")
1365:             WITH loc_oPg.obj_4c_GetSequencia
1366:                 .Top         = 12
1367:                 .Left        = 656
1368:                 .Width       = 88
1369:                 .Height      = 21
1370:                 .ButtonCount = 2
1371:                 .Visible     = .T.
1372:                 WITH .Buttons(1)
1373:                     .Left    = 3
1374:                     .Caption = "Sim"
1375:                     .Width   = 40
1376:                 ENDWITH
1377:                 WITH .Buttons(2)
1378:                     .Left    = 46
1379:                     .Caption = "N" + CHR(227) + "o"
1380:                     .Width   = 40
1381:                 ENDWITH
1382:             ENDWITH
1383:             loc_oPg.AddObject("obj_4c_Op_agregas", "OptionGroup")
1384:             WITH loc_oPg.obj_4c_Op_agregas
1385:                 .Top         = 33
1386:                 .Left        = 656
1387:                 .Width       = 88
1388:                 .Height      = 20
1389:                 .ButtonCount = 2
1390:                 .Visible     = .T.
1391:                 WITH .Buttons(1)
1392:                     .Left    = 3
1393:                     .Caption = "Sim"
1394:                     .Width   = 40
1395:                 ENDWITH
1396:                 WITH .Buttons(2)
1397:                     .Left    = 46
1398:                     .Caption = "N" + CHR(227) + "o"
1399:                     .Width   = 40
1400:                 ENDWITH
1401:             ENDWITH
1402:             loc_oPg.AddObject("obj_4c_Op_repete", "OptionGroup")
1403:             WITH loc_oPg.obj_4c_Op_repete
1404:                 .Top         = 53
1405:                 .Left        = 656
1406:                 .Width       = 160
1407:                 .Height      = 20
1408:                 .ButtonCount = 3
1409:                 .Visible     = .T.
1410:                 WITH .Buttons(1)
1411:                     .Left    = 3
1412:                     .Caption = "Sim"
1413:                     .Width   = 50
1414:                 ENDWITH
1415:                 WITH .Buttons(2)
1416:                     .Left    = 56
1417:                     .Caption = "N" + CHR(227) + "o"
1418:                     .Width   = 50
1419:                 ENDWITH
1420:                 WITH .Buttons(3)
1421:                     .Left    = 109
1422:                     .Caption = "Por Setor"
1423:                     .Width   = 50
1424:                 ENDWITH
1425:             ENDWITH
1426:             loc_oPg.AddObject("obj_4c_Op_Saldo", "OptionGroup")
1427:             WITH loc_oPg.obj_4c_Op_Saldo
1428:                 .Top         = 73
1429:                 .Left        = 656
1430:                 .Width       = 88
1431:                 .Height      = 20
1432:                 .ButtonCount = 2
1433:                 .Visible     = .T.
1434:                 WITH .Buttons(1)
1435:                     .Left    = 3
1436:                     .Caption = "Sim"
1437:                     .Width   = 40
1438:                 ENDWITH
1439:                 WITH .Buttons(2)
1440:                     .Left    = 46
1441:                     .Caption = "N" + CHR(227) + "o"
1442:                     .Width   = 40
1443:                 ENDWITH
1444:             ENDWITH
1445:             loc_oPg.AddObject("obj_4c_Op_inib", "OptionGroup")
1446:             WITH loc_oPg.obj_4c_Op_inib
1447:                 .Top         = 93
1448:                 .Left        = 656
1449:                 .Width       = 88
1450:                 .Height      = 20
1451:                 .ButtonCount = 2
1452:                 .Visible     = .T.
1453:                 WITH .Buttons(1)
1454:                     .Left    = 3
1455:                     .Caption = "Sim"
1456:                     .Width   = 40
1457:                 ENDWITH
1458:                 WITH .Buttons(2)
1459:                     .Left    = 46
1460:                     .Caption = "N" + CHR(227) + "o"
1461:                     .Width   = 40
1462:                 ENDWITH
1463:             ENDWITH
1464:             loc_oPg.AddObject("obj_4c_ObjMenFalha", "OptionGroup")
1465:             WITH loc_oPg.obj_4c_ObjMenFalha
1466:                 .Top         = 114
1467:                 .Left        = 656
1468:                 .Width       = 88
1469:                 .Height      = 20
1470:                 .ButtonCount = 2
1471:                 .Visible     = .T.
1472:                 WITH .Buttons(1)
1473:                     .Left    = 3
1474:                     .Caption = "Sim"
1475:                     .Width   = 40
1476:                 ENDWITH
1477:                 WITH .Buttons(2)
1478:                     .Left    = 46
1479:                     .Caption = "N" + CHR(227) + "o"
1480:                     .Width   = 40
1481:                 ENDWITH
1482:             ENDWITH
1483:             loc_oPg.AddObject("obj_4c_ObjBusEnv", "OptionGroup")
1484:             WITH loc_oPg.obj_4c_ObjBusEnv
1485:                 .Top         = 135
1486:                 .Left        = 656
1487:                 .Width       = 88
1488:                 .Height      = 20
1489:                 .ButtonCount = 2
1490:                 .Visible     = .T.
1491:                 WITH .Buttons(1)
1492:                     .Left    = 3
1493:                     .Caption = "Sim"
1494:                     .Width   = 40
1495:                 ENDWITH
1496:                 WITH .Buttons(2)
1497:                     .Left    = 46
1498:                     .Caption = "N" + CHR(227) + "o"
1499:                     .Width   = 40
1500:                 ENDWITH
1501:             ENDWITH
1502:             loc_oPg.AddObject("obj_4c_ObjRetrabs", "OptionGroup")
1503:             WITH loc_oPg.obj_4c_ObjRetrabs
1504:                 .Top         = 155
1505:                 .Left        = 656
1506:                 .Width       = 88
1507:                 .Height      = 20
1508:                 .ButtonCount = 2
1509:                 .Visible     = .T.
1510:                 WITH .Buttons(1)
1511:                     .Left    = 3
1512:                     .Caption = "Sim"
1513:                     .Width   = 40
1514:                 ENDWITH
1515:                 WITH .Buttons(2)
1516:                     .Left    = 46
1517:                     .Caption = "N" + CHR(227) + "o"
1518:                     .Width   = 40
1519:                 ENDWITH
1520:             ENDWITH
1521:             loc_oPg.AddObject("obj_4c_Objnaoconform", "OptionGroup")
1522:             WITH loc_oPg.obj_4c_Objnaoconform
1523:                 .Top         = 174
1524:                 .Left        = 656
1525:                 .Width       = 88
1526:                 .Height      = 20
1527:                 .ButtonCount = 2
1528:                 .Visible     = .T.
1529:                 WITH .Buttons(1)
1530:                     .Left    = 3
1531:                     .Caption = "Sim"
1532:                     .Width   = 40
1533:                 ENDWITH
1534:                 WITH .Buttons(2)
1535:                     .Left    = 46
1536:                     .Caption = "N" + CHR(227) + "o"
1537:                     .Width   = 40
1538:                 ENDWITH
1539:             ENDWITH
1540:             loc_oPg.AddObject("obj_4c_Objpagamento", "OptionGroup")
1541:             WITH loc_oPg.obj_4c_Objpagamento
1542:                 .Top         = 192
1543:                 .Left        = 656
1544:                 .Width       = 88
1545:                 .Height      = 20
1546:                 .ButtonCount = 2
1547:                 .Visible     = .T.
1548:                 WITH .Buttons(1)
1549:                     .Left    = 3
1550:                     .Caption = "Sim"
1551:                     .Width   = 40
1552:                 ENDWITH
1553:                 WITH .Buttons(2)
1554:                     .Left    = 46
1555:                     .Caption = "N" + CHR(227) + "o"
1556:                     .Width   = 40
1557:                 ENDWITH
1558:             ENDWITH
1559:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
1560:             WITH loc_oPg.obj_4c_Fwoption3
1561:                 .Top         = 212
1562:                 .Left        = 656
1563:                 .Width       = 88
1564:                 .Height      = 20
1565:                 .ButtonCount = 2
1566:                 .Visible     = .T.
1567:                 WITH .Buttons(1)
1568:                     .Left    = 3
1569:                     .Caption = "Sim"
1570:                     .Width   = 40
1571:                 ENDWITH
1572:                 WITH .Buttons(2)
1573:                     .Left    = 46
1574:                     .Caption = "N" + CHR(227) + "o"
1575:                     .Width   = 40
1576:                 ENDWITH
1577:             ENDWITH
1578:             loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
1579:             WITH loc_oPg.obj_4c_Fwoption4
1580:                 .Top         = 232
1581:                 .Left        = 656
1582:                 .Width       = 155
1583:                 .Height      = 23
1584:                 .ButtonCount = 3
1585:                 .Visible     = .T.
1586:                 WITH .Buttons(1)
1587:                     .Left    = 3
1588:                     .Caption = "Op"
1589:                     .Width   = 47
1590:                 ENDWITH
1591:                 WITH .Buttons(2)
1592:                     .Left    = 53
1593:                     .Caption = "Env"
1594:                     .Width   = 47
1595:                 ENDWITH
1596:                 WITH .Buttons(3)
1597:                     .Left    = 103
1598:                     .Caption = "Nenhum"
1599:                     .Width   = 47
1600:                 ENDWITH
1601:             ENDWITH
1602:             loc_oPg.AddObject("obj_4c_Opt_tipomov", "OptionGroup")
1603:             WITH loc_oPg.obj_4c_Opt_tipomov
1604:                 .Top         = 302
1605:                 .Left        = 665
1606:                 .Width       = 237
1607:                 .Height      = 98
1608:                 .ButtonCount = 11
1609:                 .Visible     = .T.
1610:                 WITH .Buttons(1)
1611:                     .Left    = 3
1612:                     .Top     = 2
1613:                     .Caption = "Envelopagem"
1614:                     .Width   = 100
1615:                     .Height  = 14
1616:                 ENDWITH
1617:                 WITH .Buttons(2)
1618:                     .Left    = 107
1619:                     .Top     = 2
1620:                     .Caption = "Nenhum"
1621:                     .Width   = 100
1622:                     .Height  = 14
1623:                 ENDWITH
1624:                 WITH .Buttons(3)
1625:                     .Left    = 3
1626:                     .Top     = 17
1627:                     .Caption = "Encerra"
1628:                     .Width   = 100
1629:                     .Height  = 14
1630:                 ENDWITH
1631:                 WITH .Buttons(4)
1632:                     .Left    = 107
1633:                     .Top     = 17
1634:                     .Caption = "Dev.Pedra"
1635:                     .Width   = 100
1636:                     .Height  = 14
1637:                 ENDWITH
1638:                 WITH .Buttons(5)
1639:                     .Left    = 3
1640:                     .Top     = 33
1641:                     .Caption = "Sep. Pedra"
1642:                     .Width   = 100
1643:                     .Height  = 14
1644:                 ENDWITH
1645:                 WITH .Buttons(6)
1646:                     .Left    = 107
1647:                     .Top     = 33
1648:                     .Caption = "Reposi" + CHR(231) + CHR(227) + "o"
1649:                     .Width   = 100
1650:                     .Height  = 14
1651:                 ENDWITH
1652:                 WITH .Buttons(7)
1653:                     .Left    = 3
1654:                     .Top     = 49
1655:                     .Caption = "Mov. Externa"
1656:                     .Width   = 100
1657:                     .Height  = 14
1658:                 ENDWITH
1659:                 WITH .Buttons(8)
1660:                     .Left    = 107
1661:                     .Top     = 49
1662:                     .Caption = "Mov.Pedra"
1663:                     .Width   = 100
1664:                     .Height  = 14
1665:                 ENDWITH
1666:                 WITH .Buttons(9)
1667:                     .Left    = 3
1668:                     .Top     = 64
1669:                     .Caption = "Muda de Fase"
1670:                     .Width   = 100
1671:                     .Height  = 14
1672:                 ENDWITH
1673:                 WITH .Buttons(10)
1674:                     .Left    = 107
1675:                     .Top     = 64
1676:                     .Caption = "Mov Op Envelopado"
1677:                     .Width   = 114
1678:                     .Height  = 14
1679:                 ENDWITH
1680:                 WITH .Buttons(11)
1681:                     .Left    = 3
1682:                     .Top     = 80
1683:                     .Caption = "Mov Material"
1684:                     .Width   = 100
1685:                     .Height  = 14
1686:                 ENDWITH
1687:             ENDWITH
1688:             * BINDEVENTs lookups Operacao

*-- Linhas 1784 a 2457:
1784:             * Shapes
1785:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
1786:             WITH loc_oPg.shp_4c_Shape1
1787:                 .Top = 84
1788:                 .Left = 5
1789:                 .Width = 671
1790:                 .Height = 72
1791:                 .Visible = .T.
1792:             ENDWITH
1793:             loc_oPg.AddObject("shp_4c_Shape3", "Shape")
1794:             WITH loc_oPg.shp_4c_Shape3
1795:                 .Top = 205
1796:                 .Left = 5
1797:                 .Width = 671
1798:                 .Height = 73
1799:                 .Visible = .T.
1800:             ENDWITH
1801:             loc_oPg.AddObject("shp_4c_Shape2", "Shape")
1802:             WITH loc_oPg.shp_4c_Shape2
1803:                 .Top = 317
1804:                 .Left = 10
1805:                 .Width = 303
1806:                 .Height = 29
1807:                 .Visible = .T.
1808:             ENDWITH
1809:             * Labels
1810:             loc_oPg.AddObject("lbl_4c_Label21", "Label")
1811:             WITH loc_oPg.lbl_4c_Label21
1812:                 .Top = 15
1813:                 .Left = 27
1814:                 .Width = 90
1815:                 .Height = 15
1816:                 .AutoSize = .F.
1817:                 .Caption = "Numera" + CHR(231) + CHR(227) + "o : "
1818:                 .BackStyle = 0
1819:                 .Visible = .T.
1820:             ENDWITH
1821:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
1822:             WITH loc_oPg.lbl_4c_Label25
1823:                 .Top = 15
1824:                 .Left = 521
1825:                 .Width = 106
1826:                 .Height = 15
1827:                 .AutoSize = .F.
1828:                 .Caption = "Tipo de Opera" + CHR(231) + CHR(227) + "o :"
1829:                 .BackStyle = 0
1830:                 .Visible = .T.
1831:             ENDWITH
1832:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
1833:             WITH loc_oPg.lbl_4c_Label7
1834:                 .Top = 71
1835:                 .Left = 6
1836:                 .Width = 120
1837:                 .Height = 15
1838:                 .AutoSize = .F.
1839:                 .Caption = "Origem da Opera" + CHR(231) + CHR(227) + "o"
1840:                 .BackStyle = 0
1841:                 .Visible = .T.
1842:             ENDWITH
1843:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
1844:             WITH loc_oPg.lbl_4c_Label1
1845:                 .Top = 49
1846:                 .Left = 38
1847:                 .Width = 64
1848:                 .Height = 15
1849:                 .AutoSize = .F.
1850:                 .Caption = "Tem Origem?"
1851:                 .BackStyle = 0
1852:                 .Visible = .T.
1853:             ENDWITH
1854:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
1855:             WITH loc_oPg.lbl_4c_Label6
1856:                 .Top = 94
1857:                 .Left = 10
1858:                 .Width = 42
1859:                 .Height = 15
1860:                 .AutoSize = .F.
1861:                 .Caption = "Grupo : "
1862:                 .BackStyle = 0
1863:                 .Visible = .T.
1864:             ENDWITH
1865:             loc_oPg.AddObject("lbl_4c_Label22", "Label")
1866:             WITH loc_oPg.lbl_4c_Label22
1867:                 .Top = 115
1868:                 .Left = 11
1869:                 .Width = 41
1870:                 .Height = 15
1871:                 .AutoSize = .F.
1872:                 .Caption = "Conta : "
1873:                 .BackStyle = 0
1874:                 .Visible = .T.
1875:             ENDWITH
1876:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
1877:             WITH loc_oPg.lbl_4c_Label16
1878:                 .Top = 116
1879:                 .Left = 411
1880:                 .Width = 55
1881:                 .Height = 15
1882:                 .AutoSize = .F.
1883:                 .Caption = "Fase Ant : "
1884:                 .BackStyle = 0
1885:                 .Visible = .T.
1886:             ENDWITH
1887:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
1888:             WITH loc_oPg.lbl_4c_Label10
1889:                 .Top = 92
1890:                 .Left = 391
1891:                 .Width = 72
1892:                 .Height = 15
1893:                 .AutoSize = .F.
1894:                 .Caption = "Op. Estoque : "
1895:                 .BackStyle = 0
1896:                 .Visible = .T.
1897:             ENDWITH
1898:             loc_oPg.AddObject("lbl_4c_Label18", "Label")
1899:             WITH loc_oPg.lbl_4c_Label18
1900:                 .Top = 135
1901:                 .Left = 253
1902:                 .Width = 52
1903:                 .Height = 15
1904:                 .AutoSize = .F.
1905:                 .Caption = "M" + CHR(225) + "scara : "
1906:                 .BackStyle = 0
1907:                 .Visible = .T.
1908:             ENDWITH
1909:             loc_oPg.AddObject("lbl_4c_Label14", "Label")
1910:             WITH loc_oPg.lbl_4c_Label14
1911:                 .Top = 192
1912:                 .Left = 6
1913:                 .Width = 120
1914:                 .Height = 15
1915:                 .AutoSize = .F.
1916:                 .Caption = "Destino da Opera" + CHR(231) + CHR(227) + "o"
1917:                 .BackStyle = 0
1918:                 .Visible = .T.
1919:             ENDWITH
1920:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
1921:             WITH loc_oPg.lbl_4c_Label12
1922:                 .Top = 171
1923:                 .Left = 12
1924:                 .Width = 66
1925:                 .Height = 15
1926:                 .AutoSize = .F.
1927:                 .Caption = "Tem Destino?"
1928:                 .BackStyle = 0
1929:                 .Visible = .T.
1930:             ENDWITH
1931:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
1932:             WITH loc_oPg.lbl_4c_Label4
1933:                 .Top = 171
1934:                 .Left = 221
1935:                 .Width = 133
1936:                 .Height = 15
1937:                 .AutoSize = .F.
1938:                 .Caption = "Repete Origem no Destino?"
1939:                 .BackStyle = 0
1940:                 .Visible = .T.
1941:             ENDWITH
1942:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
1943:             WITH loc_oPg.lbl_4c_Label2
1944:                 .Top = 215
1945:                 .Left = 10
1946:                 .Width = 42
1947:                 .Height = 15
1948:                 .AutoSize = .F.
1949:                 .Caption = "Grupo : "
1950:                 .BackStyle = 0
1951:                 .Visible = .T.
1952:             ENDWITH
1953:             loc_oPg.AddObject("lbl_4c_Label3", "Label")
1954:             WITH loc_oPg.lbl_4c_Label3
1955:                 .Top = 236
1956:                 .Left = 11
1957:                 .Width = 41
1958:                 .Height = 15
1959:                 .AutoSize = .F.
1960:                 .Caption = "Conta : "
1961:                 .BackStyle = 0
1962:                 .Visible = .T.
1963:             ENDWITH
1964:             loc_oPg.AddObject("lbl_4c_Label17", "Label")
1965:             WITH loc_oPg.lbl_4c_Label17
1966:                 .Top = 237
1967:                 .Left = 411
1968:                 .Width = 55
1969:                 .Height = 15
1970:                 .AutoSize = .F.
1971:                 .Caption = "Fase Ant : "
1972:                 .BackStyle = 0
1973:                 .Visible = .T.
1974:             ENDWITH
1975:             loc_oPg.AddObject("lbl_4c_Label11", "Label")
1976:             WITH loc_oPg.lbl_4c_Label11
1977:                 .Top = 213
1978:                 .Left = 391
1979:                 .Width = 72
1980:                 .Height = 15
1981:                 .AutoSize = .F.
1982:                 .Caption = "Op. Estoque : "
1983:                 .BackStyle = 0
1984:                 .Visible = .T.
1985:             ENDWITH
1986:             loc_oPg.AddObject("lbl_4c_Label20", "Label")
1987:             WITH loc_oPg.lbl_4c_Label20
1988:                 .Top = 256
1989:                 .Left = 252
1990:                 .Width = 52
1991:                 .Height = 15
1992:                 .AutoSize = .F.
1993:                 .Caption = "M" + CHR(225) + "scara : "
1994:                 .BackStyle = 0
1995:                 .Visible = .T.
1996:             ENDWITH
1997:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
1998:             WITH loc_oPg.lbl_4c_Label13
1999:                 .Top = 323
2000:                 .Left = 15
2001:                 .Width = 50
2002:                 .Height = 15
2003:                 .AutoSize = .F.
2004:                 .Caption = "Grupo : "
2005:                 .BackStyle = 0
2006:                 .Visible = .T.
2007:             ENDWITH
2008:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
2009:             WITH loc_oPg.lbl_4c_Label15
2010:                 .Top = 304
2011:                 .Left = 11
2012:                 .Width = 100
2013:                 .Height = 15
2014:                 .AutoSize = .F.
2015:                 .Caption = "Respons" + CHR(225) + "vel "
2016:                 .BackStyle = 0
2017:                 .Visible = .T.
2018:             ENDWITH
2019:             loc_oPg.AddObject("lbl_4c_Label19", "Label")
2020:             WITH loc_oPg.lbl_4c_Label19
2021:                 .Top = 284
2022:                 .Left = 12
2023:                 .Width = 91
2024:                 .Height = 15
2025:                 .AutoSize = .F.
2026:                 .Caption = "Tem Respons" + CHR(225) + "vel?"
2027:                 .BackStyle = 0
2028:                 .Visible = .T.
2029:             ENDWITH
2030:             * OptionGroups
2031:             loc_oPg.AddObject("obj_4c_Op_Numeracao", "OptionGroup")
2032:             WITH loc_oPg.obj_4c_Op_Numeracao
2033:                 .Top = 10
2034:                 .Left = 100
2035:                 .Width = 373
2036:                 .Height = 27
2037:                 .ButtonCount = 4
2038:                 .Visible = .T.
2039:                 WITH .Buttons(1)
2040:                     .Left = 3
2041:                     .Width = 88
2042:                     .Caption = "Manual"
2043:                 ENDWITH
2044:                 WITH .Buttons(2)
2045:                     .Left = 94
2046:                     .Width = 88
2047:                     .Caption = "Autom" + CHR(225) + "tica"
2048:                 ENDWITH
2049:                 WITH .Buttons(3)
2050:                     .Left = 185
2051:                     .Width = 88
2052:                     .Caption = "SubN" + CHR(237) + "vel"
2053:                 ENDWITH
2054:                 WITH .Buttons(4)
2055:                     .Left = 276
2056:                     .Width = 88
2057:                     .Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
2058:                 ENDWITH
2059:             ENDWITH
2060:             loc_oPg.AddObject("obj_4c_Op_origem", "OptionGroup")
2061:             WITH loc_oPg.obj_4c_Op_origem
2062:                 .Top = 49
2063:                 .Left = 94
2064:                 .Width = 106
2065:                 .Height = 20
2066:                 .ButtonCount = 2
2067:                 .Visible = .T.
2068:                 WITH .Buttons(1)
2069:                     .Left = 3
2070:                     .Caption = "Sim"
2071:                     .Width = 48
2072:                 ENDWITH
2073:                 WITH .Buttons(2)
2074:                     .Left = 54
2075:                     .Caption = "N" + CHR(227) + "o"
2076:                     .Width = 48
2077:                 ENDWITH
2078:             ENDWITH
2079:             loc_oPg.AddObject("obj_4c_Op_EstOrig", "OptionGroup")
2080:             WITH loc_oPg.obj_4c_Op_EstOrig
2081:                 .Top = 87
2082:                 .Left = 468
2083:                 .Width = 200
2084:                 .Height = 25
2085:                 .ButtonCount = 3
2086:                 .Visible = .T.
2087:                 WITH .Buttons(1)
2088:                     .Left = 3
2089:                     .Width = 62
2090:                     .Caption = "Entrada"
2091:                 ENDWITH
2092:                 WITH .Buttons(2)
2093:                     .Left = 68
2094:                     .Width = 62
2095:                     .Caption = "Sa" + CHR(237) + "da"
2096:                 ENDWITH
2097:                 WITH .Buttons(3)
2098:                     .Left = 133
2099:                     .Width = 62
2100:                     .Caption = "Nenhuma"
2101:                 ENDWITH
2102:             ENDWITH
2103:             loc_oPg.AddObject("obj_4c_Op_ConOSub", "OptionGroup")
2104:             WITH loc_oPg.obj_4c_Op_ConOSub
2105:                 .Top = 110
2106:                 .Left = 467
2107:                 .Width = 201
2108:                 .Height = 25
2109:                 .ButtonCount = 3
2110:                 .Visible = .T.
2111:                 WITH .Buttons(1)
2112:                     .Left = 3
2113:                     .Width = 62
2114:                     .Caption = "Origem"
2115:                 ENDWITH
2116:                 WITH .Buttons(2)
2117:                     .Left = 68
2118:                     .Width = 62
2119:                     .Caption = "Destino"
2120:                 ENDWITH
2121:                 WITH .Buttons(3)
2122:                     .Left = 133
2123:                     .Width = 62
2124:                     .Caption = "Nenhuma"
2125:                 ENDWITH
2126:             ENDWITH
2127:             loc_oPg.AddObject("obj_4c_Op_BxOEst", "OptionGroup")
2128:             WITH loc_oPg.obj_4c_Op_BxOEst
2129:                 .Top = 133
2130:                 .Left = 467
2131:                 .Width = 186
2132:                 .Height = 25
2133:                 .ButtonCount = 2
2134:                 .Visible = .T.
2135:                 WITH .Buttons(1)
2136:                     .Left = 3
2137:                     .Caption = "Prod. Acabado"
2138:                     .Width = 88
2139:                 ENDWITH
2140:                 WITH .Buttons(2)
2141:                     .Left = 94
2142:                     .Caption = "Mat. Prima"
2143:                     .Width = 88
2144:                 ENDWITH
2145:             ENDWITH
2146:             loc_oPg.AddObject("obj_4c_Op_destino", "OptionGroup")
2147:             WITH loc_oPg.obj_4c_Op_destino
2148:                 .Top = 169
2149:                 .Left = 94
2150:                 .Width = 106
2151:                 .Height = 20
2152:                 .ButtonCount = 2
2153:                 .Visible = .T.
2154:                 WITH .Buttons(1)
2155:                     .Left = 3
2156:                     .Caption = "Sim"
2157:                     .Width = 48
2158:                 ENDWITH
2159:                 WITH .Buttons(2)
2160:                     .Left = 54
2161:                     .Caption = "N" + CHR(227) + "o"
2162:                     .Width = 48
2163:                 ENDWITH
2164:             ENDWITH
2165:             loc_oPg.AddObject("obj_4c_Get_Repete", "OptionGroup")
2166:             WITH loc_oPg.obj_4c_Get_Repete
2167:                 .Top = 169
2168:                 .Left = 380
2169:                 .Width = 106
2170:                 .Height = 20
2171:                 .ButtonCount = 2
2172:                 .Visible = .T.
2173:                 WITH .Buttons(1)
2174:                     .Left = 3
2175:                     .Caption = "Sim"
2176:                     .Width = 48
2177:                 ENDWITH
2178:                 WITH .Buttons(2)
2179:                     .Left = 54
2180:                     .Caption = "N" + CHR(227) + "o"
2181:                     .Width = 48
2182:                 ENDWITH
2183:             ENDWITH
2184:             loc_oPg.AddObject("obj_4c_Op_EstDest", "OptionGroup")
2185:             WITH loc_oPg.obj_4c_Op_EstDest
2186:                 .Top = 208
2187:                 .Left = 468
2188:                 .Width = 200
2189:                 .Height = 25
2190:                 .ButtonCount = 3
2191:                 .Visible = .T.
2192:                 WITH .Buttons(1)
2193:                     .Left = 3
2194:                     .Width = 62
2195:                     .Caption = "Entrada"
2196:                 ENDWITH
2197:                 WITH .Buttons(2)
2198:                     .Left = 68
2199:                     .Width = 62
2200:                     .Caption = "Sa" + CHR(237) + "da"
2201:                 ENDWITH
2202:                 WITH .Buttons(3)
2203:                     .Left = 133
2204:                     .Width = 62
2205:                     .Caption = "Nenhuma"
2206:                 ENDWITH
2207:             ENDWITH
2208:             loc_oPg.AddObject("obj_4c_Op_ConDSub", "OptionGroup")
2209:             WITH loc_oPg.obj_4c_Op_ConDSub
2210:                 .Top = 231
2211:                 .Left = 468
2212:                 .Width = 200
2213:                 .Height = 25
2214:                 .ButtonCount = 3
2215:                 .Visible = .T.
2216:                 WITH .Buttons(1)
2217:                     .Left = 3
2218:                     .Width = 62
2219:                     .Caption = "Origem"
2220:                 ENDWITH
2221:                 WITH .Buttons(2)
2222:                     .Left = 68
2223:                     .Width = 62
2224:                     .Caption = "Destino"
2225:                 ENDWITH
2226:                 WITH .Buttons(3)
2227:                     .Left = 133
2228:                     .Width = 62
2229:                     .Caption = "Nenhuma"
2230:                 ENDWITH
2231:             ENDWITH
2232:             loc_oPg.AddObject("obj_4c_Op_BxDEst", "OptionGroup")
2233:             WITH loc_oPg.obj_4c_Op_BxDEst
2234:                 .Top = 254
2235:                 .Left = 468
2236:                 .Width = 187
2237:                 .Height = 25
2238:                 .ButtonCount = 2
2239:                 .Visible = .T.
2240:                 WITH .Buttons(1)
2241:                     .Left = 3
2242:                     .Caption = "Prod. Acabado"
2243:                     .Width = 88
2244:                 ENDWITH
2245:                 WITH .Buttons(2)
2246:                     .Left = 94
2247:                     .Caption = "Mat. Prima"
2248:                     .Width = 88
2249:                 ENDWITH
2250:             ENDWITH
2251:             loc_oPg.AddObject("obj_4c_Op_vende", "OptionGroup")
2252:             WITH loc_oPg.obj_4c_Op_vende
2253:                 .Top = 282
2254:                 .Left = 104
2255:                 .Width = 106
2256:                 .Height = 20
2257:                 .ButtonCount = 2
2258:                 .Visible = .T.
2259:                 WITH .Buttons(1)
2260:                     .Left = 3
2261:                     .Caption = "Sim"
2262:                     .Width = 48
2263:                 ENDWITH
2264:                 WITH .Buttons(2)
2265:                     .Left = 54
2266:                     .Caption = "N" + CHR(227) + "o"
2267:                     .Width = 48
2268:                 ENDWITH
2269:             ENDWITH
2270:             * CheckBoxes
2271:             loc_oPg.AddObject("chk_4c_Chk_Grupoo", "CheckBox")
2272:             WITH loc_oPg.chk_4c_Chk_Grupoo
2273:                 .Top = 89
2274:                 .Left = 53
2275:                 .Width = 20
2276:                 .Height = 19
2277:                 .Caption = ""
2278:                 .Value = 0
2279:                 .Visible = .T.
2280:             ENDWITH
2281:             loc_oPg.AddObject("chk_4c_Chk_Contao", "CheckBox")
2282:             WITH loc_oPg.chk_4c_Chk_Contao
2283:                 .Top = 110
2284:                 .Left = 53
2285:                 .Width = 20
2286:                 .Height = 19
2287:                 .Caption = ""
2288:                 .Value = 0
2289:                 .Visible = .T.
2290:             ENDWITH
2291:             loc_oPg.AddObject("chk_4c_ChkSenhaO", "CheckBox")
2292:             WITH loc_oPg.chk_4c_ChkSenhaO
2293:                 .Top = 134
2294:                 .Left = 71
2295:                 .Width = 120
2296:                 .Height = 19
2297:                 .Caption = "Verificar Senha"
2298:                 .Value = 0
2299:                 .Visible = .T.
2300:             ENDWITH
2301:             loc_oPg.AddObject("chk_4c_Chk_Grupod", "CheckBox")
2302:             WITH loc_oPg.chk_4c_Chk_Grupod
2303:                 .Top = 210
2304:                 .Left = 53
2305:                 .Width = 20
2306:                 .Height = 19
2307:                 .Caption = ""
2308:                 .Value = 0
2309:                 .Visible = .T.
2310:             ENDWITH
2311:             loc_oPg.AddObject("chk_4c_Chk_Contad", "CheckBox")
2312:             WITH loc_oPg.chk_4c_Chk_Contad
2313:                 .Top = 231
2314:                 .Left = 53
2315:                 .Width = 20
2316:                 .Height = 19
2317:                 .Caption = ""
2318:                 .Value = 0
2319:                 .Visible = .T.
2320:             ENDWITH
2321:             loc_oPg.AddObject("chk_4c_ChkSenhaD", "CheckBox")
2322:             WITH loc_oPg.chk_4c_ChkSenhaD
2323:                 .Top = 255
2324:                 .Left = 71
2325:                 .Width = 120
2326:                 .Height = 19
2327:                 .Caption = "Verificar Senha"
2328:                 .Value = 0
2329:                 .Visible = .T.
2330:             ENDWITH
2331:             loc_oPg.AddObject("chk_4c_Chk_Grupov", "CheckBox")
2332:             WITH loc_oPg.chk_4c_Chk_Grupov
2333:                 .Top = 322
2334:                 .Left = 58
2335:                 .Width = 20
2336:                 .Height = 19
2337:                 .Caption = ""
2338:                 .Value = 0
2339:                 .Visible = .T.
2340:             ENDWITH
2341:             * TextBoxes
2342:             loc_oPg.AddObject("txt_4c_GrupoOrig", "TextBox")
2343:             WITH loc_oPg.txt_4c_GrupoOrig
2344:                 .Top = 88
2345:                 .Left = 73
2346:                 .Width = 78
2347:                 .Height = 21
2348:                 .Visible = .T.
2349:             ENDWITH
2350:             loc_oPg.AddObject("txt_4c_Dgrupoo", "TextBox")
2351:             WITH loc_oPg.txt_4c_Dgrupoo
2352:                 .Top = 88
2353:                 .Left = 152
2354:                 .Width = 150
2355:                 .Height = 21
2356:                 .ReadOnly = .T.
2357:                 .DisabledBackColor = RGB(240,240,240)
2358:                 .Visible = .T.
2359:             ENDWITH
2360:             loc_oPg.AddObject("txt_4c_ContaOrig", "TextBox")
2361:             WITH loc_oPg.txt_4c_ContaOrig
2362:                 .Top = 109
2363:                 .Left = 73
2364:                 .Width = 78
2365:                 .Height = 21
2366:                 .Visible = .T.
2367:             ENDWITH
2368:             loc_oPg.AddObject("txt_4c_Dcontao", "TextBox")
2369:             WITH loc_oPg.txt_4c_Dcontao
2370:                 .Top = 109
2371:                 .Left = 152
2372:                 .Width = 231
2373:                 .Height = 21
2374:                 .ReadOnly = .T.
2375:                 .DisabledBackColor = RGB(240,240,240)
2376:                 .Visible = .T.
2377:             ENDWITH
2378:             loc_oPg.AddObject("txt_4c_Mascos", "TextBox")
2379:             WITH loc_oPg.txt_4c_Mascos
2380:                 .Top = 131
2381:                 .Left = 305
2382:                 .Width = 78
2383:                 .Height = 21
2384:                 .Visible = .T.
2385:             ENDWITH
2386:             loc_oPg.AddObject("txt_4c_GrupoDest", "TextBox")
2387:             WITH loc_oPg.txt_4c_GrupoDest
2388:                 .Top = 209
2389:                 .Left = 73
2390:                 .Width = 78
2391:                 .Height = 21
2392:                 .Visible = .T.
2393:             ENDWITH
2394:             loc_oPg.AddObject("txt_4c_Dgrupod", "TextBox")
2395:             WITH loc_oPg.txt_4c_Dgrupod
2396:                 .Top = 209
2397:                 .Left = 152
2398:                 .Width = 150
2399:                 .Height = 21
2400:                 .ReadOnly = .T.
2401:                 .DisabledBackColor = RGB(240,240,240)
2402:                 .Visible = .T.
2403:             ENDWITH
2404:             loc_oPg.AddObject("txt_4c_ContaDest", "TextBox")
2405:             WITH loc_oPg.txt_4c_ContaDest
2406:                 .Top = 230
2407:                 .Left = 73
2408:                 .Width = 78
2409:                 .Height = 21
2410:                 .Visible = .T.
2411:             ENDWITH
2412:             loc_oPg.AddObject("txt_4c_Dcontad", "TextBox")
2413:             WITH loc_oPg.txt_4c_Dcontad
2414:                 .Top = 230
2415:                 .Left = 152
2416:                 .Width = 231
2417:                 .Height = 21
2418:                 .ReadOnly = .T.
2419:                 .DisabledBackColor = RGB(240,240,240)
2420:                 .Visible = .T.
2421:             ENDWITH
2422:             loc_oPg.AddObject("txt_4c_Mascds", "TextBox")
2423:             WITH loc_oPg.txt_4c_Mascds
2424:                 .Top = 253
2425:                 .Left = 304
2426:                 .Width = 78
2427:                 .Height = 21
2428:                 .Visible = .T.
2429:             ENDWITH
2430:             loc_oPg.AddObject("txt_4c_GrupoVend", "TextBox")
2431:             WITH loc_oPg.txt_4c_GrupoVend
2432:                 .Top = 321
2433:                 .Left = 78
2434:                 .Width = 78
2435:                 .Height = 21
2436:                 .Visible = .T.
2437:             ENDWITH
2438:             loc_oPg.AddObject("txt_4c_Dgrupov", "TextBox")
2439:             WITH loc_oPg.txt_4c_Dgrupov
2440:                 .Top = 321
2441:                 .Left = 157
2442:                 .Width = 150
2443:                 .Height = 21
2444:                 .ReadOnly = .T.
2445:                 .DisabledBackColor = RGB(240,240,240)
2446:                 .Visible = .T.
2447:             ENDWITH
2448:             * ComboBox
2449:             loc_oPg.AddObject("cbo_4c_CmbTOpers", "ComboBox")
2450:             WITH loc_oPg.cbo_4c_CmbTOpers
2451:                 .Top = 11
2452:                 .Left = 630
2453:                 .Width = 208
2454:                 .Height = 24
2455:                 .Style = 2
2456:                 .Visible = .T.
2457:             ENDWITH

*-- Linhas 2503 a 3529:
2503:         loc_oPg = THIS.pgf_4c_Paginas.Page2.pgf_4c_PagDados.Page3
2504:         TRY
2505:             * Labels
2506:             loc_oPg.AddObject("lbl_4c_Label15", "Label")
2507:             WITH loc_oPg.lbl_4c_Label15
2508:                 .Top = 13
2509:                 .Left = 38
2510:                 .Width = 145
2511:                 .Height = 15
2512:                 .AutoSize = .F.
2513:                 .Caption = "Grade Ordens de Produ" + CHR(231) + CHR(227) + "o : "
2514:                 .BackStyle = 0
2515:                 .Visible = .T.
2516:             ENDWITH
2517:             loc_oPg.AddObject("lbl_4c_Label14", "Label")
2518:             WITH loc_oPg.lbl_4c_Label14
2519:                 .Top = 33
2520:                 .Left = 55
2521:                 .Width = 130
2522:                 .Height = 15
2523:                 .AutoSize = .F.
2524:                 .Caption = "Grade de Componentes : "
2525:                 .BackStyle = 0
2526:                 .Visible = .T.
2527:             ENDWITH
2528:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
2529:             WITH loc_oPg.lbl_4c_Label5
2530:                 .Top = 53
2531:                 .Left = 64
2532:                 .Width = 115
2533:                 .Height = 15
2534:                 .AutoSize = .F.
2535:                 .Caption = "Agrupa Componentes : "
2536:                 .BackStyle = 0
2537:                 .Visible = .T.
2538:             ENDWITH
2539:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
2540:             WITH loc_oPg.lbl_4c_Label8
2541:                 .Top = 73
2542:                 .Left = 66
2543:                 .Width = 113
2544:                 .Height = 15
2545:                 .AutoSize = .F.
2546:                 .Caption = "Separa" + CHR(231) + CHR(227) + "o de Pedras : "
2547:                 .BackStyle = 0
2548:                 .Visible = .T.
2549:             ENDWITH
2550:             loc_oPg.AddObject("lbl_4c_Label12", "Label")
2551:             WITH loc_oPg.lbl_4c_Label12
2552:                 .Top = 13
2553:                 .Left = 487
2554:                 .Width = 135
2555:                 .Height = 15
2556:                 .AutoSize = .F.
2557:                 .Caption = "Tipo de Opera" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o : "
2558:                 .BackStyle = 0
2559:                 .Visible = .T.
2560:             ENDWITH
2561:             loc_oPg.AddObject("lbl_4c_Label35", "Label")
2562:             WITH loc_oPg.lbl_4c_Label35
2563:                 .Top = 35
2564:                 .Left = 507
2565:                 .Width = 115
2566:                 .Height = 15
2567:                 .AutoSize = .F.
2568:                 .Caption = "Opera" + CHR(231) + CHR(227) + "o de Retalho : "
2569:                 .BackStyle = 0
2570:                 .Visible = .T.
2571:             ENDWITH
2572:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
2573:             WITH loc_oPg.lbl_4c_Label6
2574:                 .Top = 56
2575:                 .Left = 548
2576:                 .Width = 75
2577:                 .Height = 15
2578:                 .AutoSize = .F.
2579:                 .Caption = "Fase do PCC : "
2580:                 .BackStyle = 0
2581:                 .Visible = .T.
2582:             ENDWITH
2583:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
2584:             WITH loc_oPg.lbl_4c_Label4
2585:                 .Top = 105
2586:                 .Left = 529
2587:                 .Width = 95
2588:                 .Height = 15
2589:                 .AutoSize = .F.
2590:                 .Caption = "Checar Fundi" + CHR(231) + CHR(227) + "o : "
2591:                 .BackStyle = 0
2592:                 .Visible = .T.
2593:             ENDWITH
2594:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
2595:             WITH loc_oPg.lbl_4c_Label2
2596:                 .Top = 124
2597:                 .Left = 545
2598:                 .Width = 80
2599:                 .Height = 15
2600:                 .AutoSize = .F.
2601:                 .Caption = "Peso Vari" + CHR(225) + "vel : "
2602:                 .BackStyle = 0
2603:                 .Visible = .T.
2604:             ENDWITH
2605:             loc_oPg.AddObject("lbl_4c_Label7", "Label")
2606:             WITH loc_oPg.lbl_4c_Label7
2607:                 .Top = 161
2608:                 .Left = 512
2609:                 .Width = 112
2610:                 .Height = 15
2611:                 .AutoSize = .F.
2612:                 .Caption = "Pagamento Servi" + CHR(231) + "os : "
2613:                 .BackStyle = 0
2614:                 .Visible = .T.
2615:             ENDWITH
2616:             loc_oPg.AddObject("lbl_4c_Label9", "Label")
2617:             WITH loc_oPg.lbl_4c_Label9
2618:                 .Top = 181
2619:                 .Left = 555
2620:                 .Width = 70
2621:                 .Height = 15
2622:                 .AutoSize = .F.
2623:                 .Caption = "Mensagens : "
2624:                 .BackStyle = 0
2625:                 .Visible = .T.
2626:             ENDWITH
2627:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
2628:             WITH loc_oPg.lbl_4c_Label10
2629:                 .Top = 201
2630:                 .Left = 508
2631:                 .Width = 117
2632:                 .Height = 15
2633:                 .AutoSize = .F.
2634:                 .Caption = "Envelope Obrigat" + CHR(243) + "rio : "
2635:                 .BackStyle = 0
2636:                 .Visible = .T.
2637:             ENDWITH
2638:             loc_oPg.AddObject("lbl_4c_Label21", "Label")
2639:             WITH loc_oPg.lbl_4c_Label21
2640:                 .Top = 191
2641:                 .Left = 78
2642:                 .Width = 107
2643:                 .Height = 15
2644:                 .AutoSize = .F.
2645:                 .Caption = "Diferen" + CHR(231) + "a de  Peso : "
2646:                 .BackStyle = 0
2647:                 .Visible = .T.
2648:             ENDWITH
2649:             loc_oPg.AddObject("lbl_4c_Label11", "Label")
2650:             WITH loc_oPg.lbl_4c_Label11
2651:                 .Top = 242
2652:                 .Left = 488
2653:                 .Width = 137
2654:                 .Height = 15
2655:                 .AutoSize = .F.
2656:                 .Caption = "Peso somente via Balan" + CHR(231) + "a: "
2657:                 .BackStyle = 0
2658:                 .Visible = .T.
2659:             ENDWITH
2660:             loc_oPg.AddObject("lbl_4c_Label3", "Label")
2661:             WITH loc_oPg.lbl_4c_Label3
2662:                 .Top = 274
2663:                 .Left = 85
2664:                 .Width = 95
2665:                 .Height = 15
2666:                 .AutoSize = .F.
2667:                 .Caption = "Grupo Transit" + CHR(243) + "rio : "
2668:                 .BackStyle = 0
2669:                 .Visible = .T.
2670:             ENDWITH
2671:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
2672:             WITH loc_oPg.lbl_4c_Label13
2673:                 .Top = 310
2674:                 .Left = 29
2675:                 .Width = 150
2676:                 .Height = 15
2677:                 .AutoSize = .F.
2678:                 .Caption = "Checar Separa" + CHR(231) + CHR(227) + "o de Pedras : "
2679:                 .BackStyle = 0
2680:                 .Visible = .T.
2681:             ENDWITH
2682:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
2683:             WITH loc_oPg.lbl_4c_Label1
2684:                 .Top = 359
2685:                 .Left = 128
2686:                 .Width = 55
2687:                 .Height = 15
2688:                 .AutoSize = .F.
2689:                 .Caption = "Etiqueta : "
2690:                 .BackStyle = 0
2691:                 .Visible = .T.
2692:             ENDWITH
2693:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
2694:             WITH loc_oPg.lbl_4c_Label16
2695:                 .Top = 380
2696:                 .Left = 71
2697:                 .Width = 110
2698:                 .Height = 15
2699:                 .AutoSize = .F.
2700:                 .Caption = "Desagregar Material : "
2701:                 .BackStyle = 0
2702:                 .Visible = .T.
2703:             ENDWITH
2704:             loc_oPg.AddObject("lbl_4c_Label17", "Label")
2705:             WITH loc_oPg.lbl_4c_Label17
2706:                 .Top = 416
2707:                 .Left = 25
2708:                 .Width = 155
2709:                 .Height = 15
2710:                 .AutoSize = .F.
2711:                 .Caption = "Quebra Impress" + CHR(227) + "o por Pedido : "
2712:                 .BackStyle = 0
2713:                 .Visible = .T.
2714:             ENDWITH
2715:             loc_oPg.AddObject("lbl_4c_Label18", "Label")
2716:             WITH loc_oPg.lbl_4c_Label18
2717:                 .Top = 259
2718:                 .Left = 539
2719:                 .Width = 90
2720:                 .Height = 15
2721:                 .AutoSize = .F.
2722:                 .Caption = "Transfere Peso:"
2723:                 .BackStyle = 0
2724:                 .Visible = .T.
2725:             ENDWITH
2726:             loc_oPg.AddObject("lbl_4c_Label19", "Label")
2727:             WITH loc_oPg.lbl_4c_Label19
2728:                 .Top = 254
2729:                 .Left = 81
2730:                 .Width = 100
2731:                 .Height = 15
2732:                 .AutoSize = .F.
2733:                 .Caption = "Crava" + CHR(231) + CHR(227) + "o na Cera : "
2734:                 .BackStyle = 0
2735:                 .Visible = .T.
2736:             ENDWITH
2737:             loc_oPg.AddObject("lbl_4c_Label20", "Label")
2738:             WITH loc_oPg.lbl_4c_Label20
2739:                 .Top = 127
2740:                 .Left = 51
2741:                 .Width = 135
2742:                 .Height = 15
2743:                 .AutoSize = .F.
2744:                 .Caption = "% toler" + CHR(226) + "ncia Sep. Pedra : "
2745:                 .BackStyle = 0
2746:                 .Visible = .T.
2747:             ENDWITH
2748:             loc_oPg.AddObject("lbl_4c_Label22", "Label")
2749:             WITH loc_oPg.lbl_4c_Label22
2750:                 .Top = 168
2751:                 .Left = 70
2752:                 .Width = 115
2753:                 .Height = 15
2754:                 .AutoSize = .F.
2755:                 .Caption = "Limite de Qtd Por Os : "
2756:                 .BackStyle = 0
2757:                 .Visible = .T.
2758:             ENDWITH
2759:             loc_oPg.AddObject("lbl_4c_Label23", "Label")
2760:             WITH loc_oPg.lbl_4c_Label23
2761:                 .Top = 190
2762:                 .Left = 322
2763:                 .Width = 40
2764:                 .Height = 15
2765:                 .AutoSize = .F.
2766:                 .Caption = "( P/Q )"
2767:                 .BackStyle = 0
2768:                 .Visible = .T.
2769:             ENDWITH
2770:             loc_oPg.AddObject("lbl_4c_Label24", "Label")
2771:             WITH loc_oPg.lbl_4c_Label24
2772:                 .Top = 233
2773:                 .Left = 60
2774:                 .Width = 120
2775:                 .Height = 15
2776:                 .AutoSize = .F.
2777:                 .Caption = "Solicita  Cod.Libera" + CHR(231) + CHR(227) + "o : "
2778:                 .BackStyle = 0
2779:                 .Visible = .T.
2780:             ENDWITH
2781:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
2782:             WITH loc_oPg.lbl_4c_Label25
2783:                 .Top = 221
2784:                 .Left = 491
2785:                 .Width = 135
2786:                 .Height = 15
2787:                 .AutoSize = .F.
2788:                 .Caption = "Valor do Item Obrigat" + CHR(243) + "rio :"
2789:                 .BackStyle = 0
2790:                 .Visible = .T.
2791:             ENDWITH
2792:             loc_oPg.AddObject("lbl_4c_Label26", "Label")
2793:             WITH loc_oPg.lbl_4c_Label26
2794:                 .Top = 147
2795:                 .Left = 35
2796:                 .Width = 145
2797:                 .Height = 15
2798:                 .AutoSize = .F.
2799:                 .Caption = "Baixar Pedras na Finaliza" + CHR(231) + CHR(227) + "o :"
2800:                 .BackStyle = 0
2801:                 .Visible = .T.
2802:             ENDWITH
2803:             loc_oPg.AddObject("lbl_4c_Label27", "Label")
2804:             WITH loc_oPg.lbl_4c_Label27
2805:                 .Top = 356
2806:                 .Left = 542
2807:                 .Width = 80
2808:                 .Height = 15
2809:                 .AutoSize = .F.
2810:                 .Caption = "Bloqueia Qtde : "
2811:                 .BackStyle = 0
2812:                 .Visible = .T.
2813:             ENDWITH
2814:             loc_oPg.AddObject("lbl_4c_Label28", "Label")
2815:             WITH loc_oPg.lbl_4c_Label28
2816:                 .Top = 80
2817:                 .Left = 537
2818:                 .Width = 90
2819:                 .Height = 15
2820:                 .AutoSize = .F.
2821:                 .Caption = "Material Padr" + CHR(227) + "o :"
2822:                 .BackStyle = 0
2823:                 .Visible = .T.
2824:             ENDWITH
2825:             loc_oPg.AddObject("lbl_4c_Label29", "Label")
2826:             WITH loc_oPg.lbl_4c_Label29
2827:                 .Top = 214
2828:                 .Left = 60
2829:                 .Width = 120
2830:                 .Height = 15
2831:                 .AutoSize = .F.
2832:                 .Caption = "Checar Somente Metal : "
2833:                 .BackStyle = 0
2834:                 .Visible = .T.
2835:             ENDWITH
2836:             loc_oPg.AddObject("lbl_4c_Label30", "Label")
2837:             WITH loc_oPg.lbl_4c_Label30
2838:                 .Top = 376
2839:                 .Left = 535
2840:                 .Width = 80
2841:                 .Height = 15
2842:                 .AutoSize = .F.
2843:                 .Caption = "Resumo por OP : "
2844:                 .BackStyle = 0
2845:                 .Visible = .T.
2846:             ENDWITH
2847:             loc_oPg.AddObject("lbl_4c_Label31", "Label")
2848:             WITH loc_oPg.lbl_4c_Label31
2849:                 .Top = 396
2850:                 .Left = 458
2851:                 .Width = 170
2852:                 .Height = 15
2853:                 .AutoSize = .F.
2854:                 .Caption = "Permite Mat. Principal Diferente : "
2855:                 .BackStyle = 0
2856:                 .Visible = .T.
2857:             ENDWITH
2858:             * OptionGroups
2859:             loc_oPg.AddObject("obj_4c_Op_grprod", "OptionGroup")
2860:             WITH loc_oPg.obj_4c_Op_grprod
2861:                 .Top = 9
2862:                 .Left = 183
2863:                 .Width = 92
2864:                 .Height = 25
2865:                 .ButtonCount = 2
2866:                 .Visible = .T.
2867:                 WITH .Buttons(1)
2868:                     .Left = 3
2869:                     .Caption = "Sim"
2870:                     .Width = 40
2871:                 ENDWITH
2872:                 WITH .Buttons(2)
2873:                     .Left = 46
2874:                     .Caption = "N" + CHR(227) + "o"
2875:                     .Width = 40
2876:                 ENDWITH
2877:             ENDWITH
2878:             loc_oPg.AddObject("obj_4c_Op_grcomp", "OptionGroup")
2879:             WITH loc_oPg.obj_4c_Op_grcomp
2880:                 .Top = 29
2881:                 .Left = 183
2882:                 .Width = 92
2883:                 .Height = 25
2884:                 .ButtonCount = 2
2885:                 .Visible = .T.
2886:                 WITH .Buttons(1)
2887:                     .Left = 3
2888:                     .Caption = "Sim"
2889:                     .Width = 40
2890:                 ENDWITH
2891:                 WITH .Buttons(2)
2892:                     .Left = 46
2893:                     .Caption = "N" + CHR(227) + "o"
2894:                     .Width = 40
2895:                 ENDWITH
2896:             ENDWITH
2897:             loc_oPg.AddObject("obj_4c_Op_compagru", "OptionGroup")
2898:             WITH loc_oPg.obj_4c_Op_compagru
2899:                 .Top = 49
2900:                 .Left = 183
2901:                 .Width = 178
2902:                 .Height = 25
2903:                 .ButtonCount = 3
2904:                 .Visible = .T.
2905:                 WITH .Buttons(1)
2906:                     .Left = 3
2907:                     .Width = 55
2908:                 ENDWITH
2909:                 WITH .Buttons(2)
2910:                     .Left = 61
2911:                     .Width = 55
2912:                 ENDWITH
2913:                 WITH .Buttons(3)
2914:                     .Left = 119
2915:                     .Width = 55
2916:                 ENDWITH
2917:             ENDWITH
2918:             loc_oPg.AddObject("obj_4c_Op_SepPedra", "OptionGroup")
2919:             WITH loc_oPg.obj_4c_Op_SepPedra
2920:                 .Top = 69
2921:                 .Left = 183
2922:                 .Width = 140
2923:                 .Height = 42
2924:                 .ButtonCount = 4
2925:                 .Visible = .T.
2926:                 WITH .Buttons(1)
2927:                     .Left = 3
2928:                     .Top = 2
2929:                     .Width = 65
2930:                     .Height = 14
2931:                 ENDWITH
2932:                 WITH .Buttons(2)
2933:                     .Left = 71
2934:                     .Top = 2
2935:                     .Width = 65
2936:                     .Height = 14
2937:                 ENDWITH
2938:                 WITH .Buttons(3)
2939:                     .Left = 3
2940:                     .Top = 22
2941:                     .Width = 65
2942:                     .Height = 14
2943:                 ENDWITH
2944:                 WITH .Buttons(4)
2945:                     .Left = 71
2946:                     .Top = 22
2947:                     .Width = 65
2948:                     .Height = 14
2949:                 ENDWITH
2950:             ENDWITH
2951:             loc_oPg.AddObject("obj_4c_OptBxPedFins", "OptionGroup")
2952:             WITH loc_oPg.obj_4c_OptBxPedFins
2953:                 .Top = 142
2954:                 .Left = 182
2955:                 .Width = 107
2956:                 .Height = 25
2957:                 .ButtonCount = 2
2958:                 .Visible = .T.
2959:                 WITH .Buttons(1)
2960:                     .Left = 3
2961:                     .Caption = "Sim"
2962:                     .Width = 48
2963:                 ENDWITH
2964:                 WITH .Buttons(2)
2965:                     .Left = 54
2966:                     .Caption = "N" + CHR(227) + "o"
2967:                     .Width = 48
2968:                 ENDWITH
2969:             ENDWITH
2970:             loc_oPg.AddObject("obj_4c_Op_GrTrans", "OptionGroup")
2971:             WITH loc_oPg.obj_4c_Op_GrTrans
2972:                 .Top = 270
2973:                 .Left = 182
2974:                 .Width = 133
2975:                 .Height = 40
2976:                 .ButtonCount = 3
2977:                 .Visible = .T.
2978:                 WITH .Buttons(1)
2979:                     .Left = 3
2980:                     .Top = 2
2981:                     .Width = 40
2982:                     .Height = 14
2983:                 ENDWITH
2984:                 WITH .Buttons(2)
2985:                     .Left = 46
2986:                     .Top = 2
2987:                     .Width = 40
2988:                     .Height = 14
2989:                 ENDWITH
2990:                 WITH .Buttons(3)
2991:                     .Left = 3
2992:                     .Top = 22
2993:                     .Width = 83
2994:                     .Height = 14
2995:                 ENDWITH
2996:             ENDWITH
2997:             loc_oPg.AddObject("obj_4c_ObjChkQP", "OptionGroup")
2998:             WITH loc_oPg.obj_4c_ObjChkQP
2999:                 .Top = 306
3000:                 .Left = 182
3001:                 .Width = 171
3002:                 .Height = 39
3003:                 .ButtonCount = 4
3004:                 .Visible = .T.
3005:                 WITH .Buttons(1)
3006:                     .Left = 3
3007:                     .Top = 2
3008:                     .Width = 80
3009:                     .Height = 14
3010:                 ENDWITH
3011:                 WITH .Buttons(2)
3012:                     .Left = 86
3013:                     .Top = 2
3014:                     .Width = 80
3015:                     .Height = 14
3016:                 ENDWITH
3017:                 WITH .Buttons(3)
3018:                     .Left = 3
3019:                     .Top = 22
3020:                     .Width = 80
3021:                     .Height = 14
3022:                 ENDWITH
3023:                 WITH .Buttons(4)
3024:                     .Left = 86
3025:                     .Top = 22
3026:                     .Width = 80
3027:                     .Height = 14
3028:                 ENDWITH
3029:             ENDWITH
3030:             loc_oPg.AddObject("obj_4c_ObjReinop", "OptionGroup")
3031:             WITH loc_oPg.obj_4c_ObjReinop
3032:                 .Top = 378
3033:                 .Left = 182
3034:                 .Width = 204
3035:                 .Height = 25
3036:                 .ButtonCount = 3
3037:                 .Visible = .T.
3038:                 WITH .Buttons(1)
3039:                     .Left = 3
3040:                     .Width = 62
3041:                 ENDWITH
3042:                 WITH .Buttons(2)
3043:                     .Left = 68
3044:                     .Width = 62
3045:                 ENDWITH
3046:                 WITH .Buttons(3)
3047:                     .Left = 133
3048:                     .Width = 62
3049:                 ENDWITH
3050:             ENDWITH
3051:             loc_oPg.AddObject("obj_4c_Op_etiq", "OptionGroup")
3052:             WITH loc_oPg.obj_4c_Op_etiq
3053:                 .Top = 356
3054:                 .Left = 182
3055:                 .Width = 275
3056:                 .Height = 25
3057:                 .ButtonCount = 4
3058:                 .Visible = .T.
3059:                 WITH .Buttons(1)
3060:                     .Left = 3
3061:                     .Width = 65
3062:                 ENDWITH
3063:                 WITH .Buttons(2)
3064:                     .Left = 71
3065:                     .Width = 65
3066:                 ENDWITH
3067:                 WITH .Buttons(3)
3068:                     .Left = 139
3069:                     .Width = 65
3070:                 ENDWITH
3071:                 WITH .Buttons(4)
3072:                     .Left = 207
3073:                     .Width = 65
3074:                 ENDWITH
3075:             ENDWITH
3076:             loc_oPg.AddObject("obj_4c_Opt_quebraimp", "OptionGroup")
3077:             WITH loc_oPg.obj_4c_Opt_quebraimp
3078:                 .Top = 412
3079:                 .Left = 182
3080:                 .Width = 92
3081:                 .Height = 25
3082:                 .ButtonCount = 2
3083:                 .Visible = .T.
3084:                 WITH .Buttons(1)
3085:                     .Left = 3
3086:                     .Caption = "Sim"
3087:                     .Width = 40
3088:                 ENDWITH
3089:                 WITH .Buttons(2)
3090:                     .Left = 46
3091:                     .Caption = "N" + CHR(227) + "o"
3092:                     .Width = 40
3093:                 ENDWITH
3094:             ENDWITH
3095:             loc_oPg.AddObject("obj_4c_Opt_codlib", "OptionGroup")
3096:             WITH loc_oPg.obj_4c_Opt_codlib
3097:                 .Top = 229
3098:                 .Left = 182
3099:                 .Width = 92
3100:                 .Height = 25
3101:                 .ButtonCount = 2
3102:                 .Visible = .T.
3103:                 WITH .Buttons(1)
3104:                     .Left = 3
3105:                     .Caption = "Sim"
3106:                     .Width = 40
3107:                 ENDWITH
3108:                 WITH .Buttons(2)
3109:                     .Left = 46
3110:                     .Caption = "N" + CHR(227) + "o"
3111:                     .Width = 40
3112:                 ENDWITH
3113:             ENDWITH
3114:             loc_oPg.AddObject("obj_4c_Opt_cravacera", "OptionGroup")
3115:             WITH loc_oPg.obj_4c_Opt_cravacera
3116:                 .Top = 250
3117:                 .Left = 182
3118:                 .Width = 92
3119:                 .Height = 25
3120:                 .ButtonCount = 2
3121:                 .Visible = .T.
3122:                 WITH .Buttons(1)
3123:                     .Left = 3
3124:                     .Caption = "Sim"
3125:                     .Width = 40
3126:                 ENDWITH
3127:                 WITH .Buttons(2)
3128:                     .Left = 46
3129:                     .Caption = "N" + CHR(227) + "o"
3130:                     .Width = 40
3131:                 ENDWITH
3132:             ENDWITH
3133:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
3134:             WITH loc_oPg.obj_4c_Fwoption2
3135:                 .Top = 210
3136:                 .Left = 181
3137:                 .Width = 92
3138:                 .Height = 25
3139:                 .ButtonCount = 2
3140:                 .Visible = .T.
3141:                 WITH .Buttons(1)
3142:                     .Left = 3
3143:                     .Caption = "Sim"
3144:                     .Width = 40
3145:                 ENDWITH
3146:                 WITH .Buttons(2)
3147:                     .Left = 46
3148:                     .Caption = "N" + CHR(227) + "o"
3149:                     .Width = 40
3150:                 ENDWITH
3151:             ENDWITH
3152:             * Right column OptionGroups
3153:             loc_oPg.AddObject("obj_4c_Opc_Chkf", "OptionGroup")
3154:             WITH loc_oPg.obj_4c_Opc_Chkf
3155:                 .Top = 100
3156:                 .Left = 626
3157:                 .Width = 110
3158:                 .Height = 25
3159:                 .ButtonCount = 2
3160:                 .Visible = .T.
3161:                 WITH .Buttons(1)
3162:                     .Left = 3
3163:                     .Caption = "Sim"
3164:                     .Width = 48
3165:                 ENDWITH
3166:                 WITH .Buttons(2)
3167:                     .Left = 54
3168:                     .Caption = "N" + CHR(227) + "o"
3169:                     .Width = 48
3170:                 ENDWITH
3171:             ENDWITH
3172:             loc_oPg.AddObject("obj_4c_Opc_fix", "OptionGroup")
3173:             WITH loc_oPg.obj_4c_Opc_fix
3174:                 .Top = 119
3175:                 .Left = 626
3176:                 .Width = 202
3177:                 .Height = 25
3178:                 .ButtonCount = 3
3179:                 .Visible = .T.
3180:                 WITH .Buttons(1)
3181:                     .Left = 3
3182:                     .Width = 62
3183:                 ENDWITH
3184:                 WITH .Buttons(2)
3185:                     .Left = 68
3186:                     .Width = 62
3187:                 ENDWITH
3188:                 WITH .Buttons(3)
3189:                     .Left = 133
3190:                     .Width = 62
3191:                 ENDWITH
3192:             ENDWITH
3193:             loc_oPg.AddObject("obj_4c_Opc_PagSer", "OptionGroup")
3194:             WITH loc_oPg.obj_4c_Opc_PagSer
3195:                 .Top = 155
3196:                 .Left = 626
3197:                 .Width = 206
3198:                 .Height = 25
3199:                 .ButtonCount = 3
3200:                 .Visible = .T.
3201:                 WITH .Buttons(1)
3202:                     .Left = 3
3203:                     .Width = 62
3204:                 ENDWITH
3205:                 WITH .Buttons(2)
3206:                     .Left = 68
3207:                     .Width = 62
3208:                 ENDWITH
3209:                 WITH .Buttons(3)
3210:                     .Left = 133
3211:                     .Width = 62
3212:                 ENDWITH
3213:             ENDWITH
3214:             loc_oPg.AddObject("obj_4c_Opc_mens", "OptionGroup")
3215:             WITH loc_oPg.obj_4c_Opc_mens
3216:                 .Top = 175
3217:                 .Left = 626
3218:                 .Width = 110
3219:                 .Height = 25
3220:                 .ButtonCount = 2
3221:                 .Visible = .T.
3222:                 WITH .Buttons(1)
3223:                     .Left = 3
3224:                     .Caption = "Sim"
3225:                     .Width = 48
3226:                 ENDWITH
3227:                 WITH .Buttons(2)
3228:                     .Left = 54
3229:                     .Caption = "N" + CHR(227) + "o"
3230:                     .Width = 48
3231:                 ENDWITH
3232:             ENDWITH
3233:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
3234:             WITH loc_oPg.obj_4c_Fwoption1
3235:                 .Top = 215
3236:                 .Left = 626
3237:                 .Width = 209
3238:                 .Height = 25
3239:                 .ButtonCount = 2
3240:                 .Visible = .T.
3241:                 WITH .Buttons(1)
3242:                     .Left = 3
3243:                     .Caption = "Sim"
3244:                     .Width = 96
3245:                 ENDWITH
3246:                 WITH .Buttons(2)
3247:                     .Left = 102
3248:                     .Caption = "N" + CHR(227) + "o"
3249:                     .Width = 96
3250:                 ENDWITH
3251:             ENDWITH
3252:             loc_oPg.AddObject("obj_4c_Opc_env", "OptionGroup")
3253:             WITH loc_oPg.obj_4c_Opc_env
3254:                 .Top = 195
3255:                 .Left = 626
3256:                 .Width = 209
3257:                 .Height = 25
3258:                 .ButtonCount = 3
3259:                 .Visible = .T.
3260:                 WITH .Buttons(1)
3261:                     .Left = 3
3262:                     .Width = 62
3263:                 ENDWITH
3264:                 WITH .Buttons(2)
3265:                     .Left = 68
3266:                     .Width = 62
3267:                 ENDWITH
3268:                 WITH .Buttons(3)
3269:                     .Left = 133
3270:                     .Width = 62
3271:                 ENDWITH
3272:             ENDWITH
3273:             loc_oPg.AddObject("obj_4c_Opc_pesobal", "OptionGroup")
3274:             WITH loc_oPg.obj_4c_Opc_pesobal
3275:                 .Top = 236
3276:                 .Left = 626
3277:                 .Width = 209
3278:                 .Height = 25
3279:                 .ButtonCount = 3
3280:                 .Visible = .T.
3281:                 WITH .Buttons(1)
3282:                     .Left = 3
3283:                     .Width = 62
3284:                 ENDWITH
3285:                 WITH .Buttons(2)
3286:                     .Left = 68
3287:                     .Width = 62
3288:                 ENDWITH
3289:                 WITH .Buttons(3)
3290:                     .Left = 133
3291:                     .Width = 62
3292:                 ENDWITH
3293:             ENDWITH
3294:             loc_oPg.AddObject("obj_4c_Chk_TrfPeso", "OptionGroup")
3295:             WITH loc_oPg.obj_4c_Chk_TrfPeso
3296:                 .Top = 253
3297:                 .Left = 626
3298:                 .Width = 203
3299:                 .Height = 87
3300:                 .ButtonCount = 7
3301:                 .Visible = .T.
3302:                 WITH .Buttons(1)
3303:                     .Left = 3
3304:                     .Top = 2
3305:                     .Width = 95
3306:                     .Height = 14
3307:                 ENDWITH
3308:                 WITH .Buttons(2)
3309:                     .Left = 101
3310:                     .Top = 2
3311:                     .Width = 95
3312:                     .Height = 14
3313:                 ENDWITH
3314:                 WITH .Buttons(3)
3315:                     .Left = 3
3316:                     .Top = 18
3317:                     .Width = 95
3318:                     .Height = 14
3319:                 ENDWITH
3320:                 WITH .Buttons(4)
3321:                     .Left = 101
3322:                     .Top = 18
3323:                     .Width = 95
3324:                     .Height = 14
3325:                 ENDWITH
3326:                 WITH .Buttons(5)
3327:                     .Left = 3
3328:                     .Top = 34
3329:                     .Width = 95
3330:                     .Height = 14
3331:                 ENDWITH
3332:                 WITH .Buttons(6)
3333:                     .Left = 101
3334:                     .Top = 34
3335:                     .Width = 95
3336:                     .Height = 14
3337:                 ENDWITH
3338:                 WITH .Buttons(7)
3339:                     .Left = 3
3340:                     .Top = 50
3341:                     .Width = 193
3342:                     .Height = 14
3343:                 ENDWITH
3344:             ENDWITH
3345:             loc_oPg.AddObject("obj_4c_Optqtdneg", "OptionGroup")
3346:             WITH loc_oPg.obj_4c_Optqtdneg
3347:                 .Top = 351
3348:                 .Left = 626
3349:                 .Width = 291
3350:                 .Height = 25
3351:                 .ButtonCount = 3
3352:                 .Visible = .T.
3353:                 WITH .Buttons(1)
3354:                     .Left = 3
3355:                     .Width = 90
3356:                 ENDWITH
3357:                 WITH .Buttons(2)
3358:                     .Left = 96
3359:                     .Width = 90
3360:                 ENDWITH
3361:                 WITH .Buttons(3)
3362:                     .Left = 189
3363:                     .Width = 90
3364:                 ENDWITH
3365:             ENDWITH
3366:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
3367:             WITH loc_oPg.obj_4c_Fwoption3
3368:                 .Top = 370
3369:                 .Left = 626
3370:                 .Width = 110
3371:                 .Height = 25
3372:                 .ButtonCount = 2
3373:                 .Visible = .T.
3374:                 WITH .Buttons(1)
3375:                     .Left = 3
3376:                     .Caption = "Sim"
3377:                     .Width = 48
3378:                 ENDWITH
3379:                 WITH .Buttons(2)
3380:                     .Left = 54
3381:                     .Caption = "N" + CHR(227) + "o"
3382:                     .Width = 48
3383:                 ENDWITH
3384:             ENDWITH
3385:             loc_oPg.AddObject("obj_4c_OptMatPrncDif", "OptionGroup")
3386:             WITH loc_oPg.obj_4c_OptMatPrncDif
3387:                 .Top = 390
3388:                 .Left = 627
3389:                 .Width = 110
3390:                 .Height = 25
3391:                 .ButtonCount = 2
3392:                 .Visible = .T.
3393:                 WITH .Buttons(1)
3394:                     .Left = 3
3395:                     .Caption = "Sim"
3396:                     .Width = 48
3397:                 ENDWITH
3398:                 WITH .Buttons(2)
3399:                     .Left = 54
3400:                     .Caption = "N" + CHR(227) + "o"
3401:                     .Width = 48
3402:                 ENDWITH
3403:             ENDWITH
3404:             * CheckBoxes
3405:             loc_oPg.AddObject("chk_4c_ChkCarQtde", "CheckBox")
3406:             WITH loc_oPg.chk_4c_ChkCarQtde
3407:                 .Top = 105
3408:                 .Left = 199
3409:                 .Width = 160
3410:                 .Height = 19
3411:                 .Caption = "N" + CHR(227) + "o carrega Qtde e Peso"
3412:                 .Value = 0
3413:                 .Visible = .T.
3414:             ENDWITH
3415:             loc_oPg.AddObject("chk_4c_OptChkPeso", "CheckBox")
3416:             WITH loc_oPg.chk_4c_OptChkPeso
3417:                 .Top = 339
3418:                 .Left = 198
3419:                 .Width = 80
3420:                 .Height = 19
3421:                 .Caption = "Checa peso"
3422:                 .Value = 0
3423:                 .Visible = .T.
3424:             ENDWITH
3425:             loc_oPg.AddObject("chk_4c_Chk_LibRein", "CheckBox")
3426:             WITH loc_oPg.chk_4c_Chk_LibRein
3427:                 .Top = 398
3428:                 .Left = 198
3429:                 .Width = 145
3430:                 .Height = 19
3431:                 .Caption = "Liberar Peso/Qtde (+/-)"
3432:                 .Value = 0
3433:                 .Visible = .T.
3434:             ENDWITH
3435:             loc_oPg.AddObject("chk_4c_ObjAgSep", "CheckBox")
3436:             WITH loc_oPg.chk_4c_ObjAgSep
3437:                 .Top = 337
3438:                 .Left = 632
3439:                 .Width = 120
3440:                 .Height = 19
3441:                 .Caption = "Agrupa Sep. Pedra"
3442:                 .Value = 0
3443:                 .Visible = .T.
3444:             ENDWITH
3445:             loc_oPg.AddObject("chk_4c_ChkMatPrinc", "CheckBox")
3446:             WITH loc_oPg.chk_4c_ChkMatPrinc
3447:                 .Top = 81
3448:                 .Left = 738
3449:                 .Width = 180
3450:                 .Height = 19
3451:                 .Caption = "Checar Material Principal"
3452:                 .Value = 0
3453:                 .Visible = .T.
3454:             ENDWITH
3455:             * TextBoxes
3456:             loc_oPg.AddObject("txt_4c_TpPadrao", "TextBox")
3457:             WITH loc_oPg.txt_4c_TpPadrao
3458:                 .Top = 10
3459:                 .Left = 624
3460:                 .Width = 150
3461:                 .Height = 21
3462:                 .Visible = .T.
3463:             ENDWITH
3464:             loc_oPg.AddObject("txt_4c_Retalho", "TextBox")
3465:             WITH loc_oPg.txt_4c_Retalho
3466:                 .Top = 32
3467:                 .Left = 624
3468:                 .Width = 150
3469:                 .Height = 21
3470:                 .Visible = .T.
3471:             ENDWITH
3472:             loc_oPg.AddObject("txt_4c_GrupoPcc", "TextBox")
3473:             WITH loc_oPg.txt_4c_GrupoPcc
3474:                 .Top = 54
3475:                 .Left = 624
3476:                 .Width = 78
3477:                 .Height = 21
3478:                 .Visible = .T.
3479:             ENDWITH
3480:             loc_oPg.AddObject("txt_4c__produto", "TextBox")
3481:             WITH loc_oPg.txt_4c__produto
3482:                 .Top = 77
3483:                 .Left = 623
3484:                 .Width = 108
3485:                 .Height = 23
3486:                 .Visible = .T.
3487:             ENDWITH
3488:             loc_oPg.AddObject("txt_4c_Difp", "TextBox")
3489:             WITH loc_oPg.txt_4c_Difp
3490:                 .Top = 123
3491:                 .Left = 186
3492:                 .Width = 58
3493:                 .Height = 23
3494:                 .Visible = .T.
3495:             ENDWITH
3496:             loc_oPg.AddObject("txt_4c__limqtd", "TextBox")
3497:             WITH loc_oPg.txt_4c__limqtd
3498:                 .Top = 166
3499:                 .Left = 186
3500:                 .Width = 80
3501:                 .Height = 21
3502:                 .Visible = .T.
3503:             ENDWITH
3504:             loc_oPg.AddObject("txt_4c_DifPeso", "TextBox")
3505:             WITH loc_oPg.txt_4c_DifPeso
3506:                 .Top = 187
3507:                 .Left = 186
3508:                 .Width = 68
3509:                 .Height = 23
3510:                 .Visible = .T.
3511:             ENDWITH
3512:             loc_oPg.AddObject("txt_4c_Tfalhas", "TextBox")
3513:             WITH loc_oPg.txt_4c_Tfalhas
3514:                 .Top = 187
3515:                 .Left = 305
3516:                 .Width = 17
3517:                 .Height = 23
3518:                 .Visible = .T.
3519:             ENDWITH
3520:             * ComboBox
3521:             loc_oPg.AddObject("cbo_4c_Get_Sinal", "ComboBox")
3522:             WITH loc_oPg.cbo_4c_Get_Sinal
3523:                 .Top = 187
3524:                 .Left = 255
3525:                 .Width = 48
3526:                 .Height = 24
3527:                 .Style = 2
3528:                 .Visible = .T.
3529:                 .AddItem("+")

*-- Linhas 3552 a 3671:
3552:         TRY
3553:             loc_oPg.AddObject("shp_4c_Shape1", "Shape")
3554:             WITH loc_oPg.shp_4c_Shape1
3555:                 .Top           = 26
3556:                 .Left          = 23
3557:                 .Width         = 329
3558:                 .Height        = 131
3559:                 .BackStyle     = 0
3560:                 .SpecialEffect = 0
3561:                 .Visible       = .T.
3562:             ENDWITH
3563:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
3564:             WITH loc_oPg.lbl_4c_Label25
3565:                 .Top      = 35
3566:                 .Left     = 33
3567:                 .Width    = 119
3568:                 .Height   = 15
3569:                 .AutoSize = .F.
3570:                 .FontBold = .T.
3571:                 .Caption  = "Impress" + CHR(227) + "o de Boleto"
3572:                 .BackStyle = 0
3573:                 .Visible  = .T.
3574:             ENDWITH
3575:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3576:             WITH loc_oPg.lbl_4c_Label1
3577:                 .Top = 69
3578:                 .Left = 88
3579:                 .Width = 64
3580:                 .Height = 15
3581:                 .AutoSize = .F.
3582:                 .Caption = "Imprimir OP :"
3583:                 .BackStyle = 0
3584:                 .Visible = .T.
3585:             ENDWITH
3586:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
3587:             WITH loc_oPg.lbl_4c_Label2
3588:                 .Top = 95
3589:                 .Left = 64
3590:                 .Width = 88
3591:                 .Height = 15
3592:                 .AutoSize = .F.
3593:                 .Caption = "Imprimir Material :"
3594:                 .BackStyle = 0
3595:                 .Visible = .T.
3596:             ENDWITH
3597:             loc_oPg.AddObject("lbl_4c_Label3", "Label")
3598:             WITH loc_oPg.lbl_4c_Label3
3599:                 .Top = 122
3600:                 .Left = 67
3601:                 .Width = 85
3602:                 .Height = 15
3603:                 .AutoSize = .F.
3604:                 .Caption = "Imprimir Servi" + CHR(231) + "o :"
3605:                 .BackStyle = 0
3606:                 .Visible = .T.
3607:             ENDWITH
3608:             loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
3609:             WITH loc_oPg.obj_4c_Optiongroup1
3610:                 .Top = 64
3611:                 .Left = 176
3612:                 .Width = 102
3613:                 .Height = 26
3614:                 .ButtonCount = 2
3615:                 .Visible = .T.
3616:                 WITH .Buttons(1)
3617:                     .Left = 3
3618:                     .Caption = "Sim"
3619:                     .Width = 44
3620:                 ENDWITH
3621:                 WITH .Buttons(2)
3622:                     .Left = 50
3623:                     .Caption = "N" + CHR(227) + "o"
3624:                     .Width = 44
3625:                 ENDWITH
3626:             ENDWITH
3627:             loc_oPg.AddObject("obj_4c_Optiongroup2", "OptionGroup")
3628:             WITH loc_oPg.obj_4c_Optiongroup2
3629:                 .Top = 90
3630:                 .Left = 176
3631:                 .Width = 164
3632:                 .Height = 26
3633:                 .ButtonCount = 3
3634:                 .Visible = .T.
3635:                 WITH .Buttons(1)
3636:                     .Left    = 3
3637:                     .Width   = 50
3638:                     .Caption = "Sim"
3639:                 ENDWITH
3640:                 WITH .Buttons(2)
3641:                     .Left    = 56
3642:                     .Width   = 50
3643:                     .Caption = "N" + CHR(227) + "o"
3644:                 ENDWITH
3645:                 WITH .Buttons(3)
3646:                     .Left    = 109
3647:                     .Width   = 50
3648:                     .Caption = "Pedra"
3649:                 ENDWITH
3650:             ENDWITH
3651:             loc_oPg.AddObject("obj_4c_Optiongroup3", "OptionGroup")
3652:             WITH loc_oPg.obj_4c_Optiongroup3
3653:                 .Top = 116
3654:                 .Left = 176
3655:                 .Width = 102
3656:                 .Height = 26
3657:                 .ButtonCount = 2
3658:                 .Visible = .T.
3659:                 WITH .Buttons(1)
3660:                     .Left = 3
3661:                     .Caption = "Sim"
3662:                     .Width = 44
3663:                 ENDWITH
3664:                 WITH .Buttons(2)
3665:                     .Left = 50
3666:                     .Caption = "N" + CHR(227) + "o"
3667:                     .Width = 44
3668:                 ENDWITH
3669:             ENDWITH
3670:         CATCH TO loException
3671:             MostrarErro(loException, "FormMPD.ConfigurarPgDocumento")

*-- Linhas 3682 a 4151:
3682:             * Line
3683:             loc_oPg.AddObject("lin_4c_Line1", "Line")
3684:             WITH loc_oPg.lin_4c_Line1
3685:                 .Top = 11
3686:                 .Left = 591
3687:                 .Width = 0
3688:                 .Height = 418
3689:                 .Visible = .T.
3690:             ENDWITH
3691:             * Labels
3692:             loc_oPg.AddObject("lbl_4c_Label26", "Label")
3693:             WITH loc_oPg.lbl_4c_Label26
3694:                 .Top = 16
3695:                 .Left = 8
3696:                 .Width = 101
3697:                 .Height = 15
3698:                 .AutoSize = .F.
3699:                 .Caption = "Casas Decimais qtd :"
3700:                 .BackStyle = 0
3701:                 .Visible = .T.
3702:             ENDWITH
3703:             loc_oPg.AddObject("lbl_4c_LblObspads", "Label")
3704:             WITH loc_oPg.lbl_4c_LblObspads
3705:                 .Top = 45
3706:                 .Left = 12
3707:                 .Width = 104
3708:                 .Height = 15
3709:                 .AutoSize = .F.
3710:                 .Caption = "Observa" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o :"
3711:                 .BackStyle = 0
3712:                 .Visible = .T.
3713:             ENDWITH
3714:             loc_oPg.AddObject("lbl_4c_Label6", "Label")
3715:             WITH loc_oPg.lbl_4c_Label6
3716:                 .Top = 45
3717:                 .Left = 160
3718:                 .Width = 22
3719:                 .Height = 15
3720:                 .AutoSize = .F.
3721:                 .Caption = "De :"
3722:                 .BackStyle = 0
3723:                 .Visible = .T.
3724:             ENDWITH
3725:             loc_oPg.AddObject("lbl_4c_Label10", "Label")
3726:             WITH loc_oPg.lbl_4c_Label10
3727:                 .Top = 45
3728:                 .Left = 217
3729:                 .Width = 18
3730:                 .Height = 15
3731:                 .AutoSize = .F.
3732:                 .Caption = "at" + CHR(233)
3733:                 .BackStyle = 0
3734:                 .Visible = .T.
3735:             ENDWITH
3736:             loc_oPg.AddObject("lbl_4c_Label17", "Label")
3737:             WITH loc_oPg.lbl_4c_Label17
3738:                 .Top = 72
3739:                 .Left = 12
3740:                 .Width = 170
3741:                 .Height = 15
3742:                 .AutoSize = .F.
3743:                 .Caption = "Checar Unidade  p/gerar Etiqueta :"
3744:                 .BackStyle = 0
3745:                 .Visible = .T.
3746:             ENDWITH
3747:             loc_oPg.AddObject("lbl_4c_Label1", "Label")
3748:             WITH loc_oPg.lbl_4c_Label1
3749:                 .Top = 93
3750:                 .Left = 29
3751:                 .Width = 150
3752:                 .Height = 15
3753:                 .AutoSize = .F.
3754:                 .Caption = "Divis" + CHR(227) + "o de Op C/Envelopagem :"
3755:                 .BackStyle = 0
3756:                 .Visible = .T.
3757:             ENDWITH
3758:             loc_oPg.AddObject("lbl_4c_Label13", "Label")
3759:             WITH loc_oPg.lbl_4c_Label13
3760:                 .Top = 117
3761:                 .Left = 40
3762:                 .Width = 142
3763:                 .Height = 15
3764:                 .AutoSize = .F.
3765:                 .Caption = "Tipo de Ordem de Produ" + CHR(231) + CHR(227) + "o :"
3766:                 .BackStyle = 0
3767:                 .Visible = .T.
3768:             ENDWITH
3769:             loc_oPg.AddObject("lbl_4c_Label8", "Label")
3770:             WITH loc_oPg.lbl_4c_Label8
3771:                 .Top = 144
3772:                 .Left = 92
3773:                 .Width = 90
3774:                 .Height = 15
3775:                 .AutoSize = .F.
3776:                 .Caption = "Grupo Financeiro :"
3777:                 .BackStyle = 0
3778:                 .Visible = .T.
3779:             ENDWITH
3780:             loc_oPg.AddObject("lbl_4c_Label35", "Label")
3781:             WITH loc_oPg.lbl_4c_Label35
3782:                 .Top = 170
3783:                 .Left = 74
3784:                 .Width = 108
3785:                 .Height = 15
3786:                 .AutoSize = .F.
3787:                 .Caption = "Opera" + CHR(231) + CHR(227) + "o do Contas :"
3788:                 .BackStyle = 0
3789:                 .Visible = .T.
3790:             ENDWITH
3791:             loc_oPg.AddObject("lbl_4c_Label2", "Label")
3792:             WITH loc_oPg.lbl_4c_Label2
3793:                 .Top = 197
3794:                 .Left = 32
3795:                 .Width = 145
3796:                 .Height = 15
3797:                 .AutoSize = .F.
3798:                 .Caption = "Aceite - Agrupa por Envelope :"
3799:                 .BackStyle = 0
3800:                 .Visible = .T.
3801:             ENDWITH
3802:             loc_oPg.AddObject("lbl_4c_Label3", "Label")
3803:             WITH loc_oPg.lbl_4c_Label3
3804:                 .Top = 221
3805:                 .Left = 88
3806:                 .Width = 90
3807:                 .Height = 15
3808:                 .AutoSize = .F.
3809:                 .Caption = "Controle de Lotes :"
3810:                 .BackStyle = 0
3811:                 .Visible = .T.
3812:             ENDWITH
3813:             loc_oPg.AddObject("lbl_4c_Label16", "Label")
3814:             WITH loc_oPg.lbl_4c_Label16
3815:                 .Top = 254
3816:                 .Left = 119
3817:                 .Width = 63
3818:                 .Height = 15
3819:                 .AutoSize = .F.
3820:                 .Caption = "Grupo C.C. :"
3821:                 .BackStyle = 0
3822:                 .Visible = .T.
3823:             ENDWITH
3824:             loc_oPg.AddObject("lbl_4c_Label4", "Label")
3825:             WITH loc_oPg.lbl_4c_Label4
3826:                 .Top = 278
3827:                 .Left = 119
3828:                 .Width = 63
3829:                 .Height = 15
3830:                 .AutoSize = .F.
3831:                 .Caption = "Conta C.C. :"
3832:                 .BackStyle = 0
3833:                 .Visible = .T.
3834:             ENDWITH
3835:             loc_oPg.AddObject("lbl_4c_Label25", "Label")
3836:             WITH loc_oPg.lbl_4c_Label25
3837:                 .Top = 318
3838:                 .Left = 55
3839:                 .Width = 128
3840:                 .Height = 15
3841:                 .AutoSize = .F.
3842:                 .Caption = "Opera" + CHR(231) + CHR(227) + "o Semiacabados :"
3843:                 .BackStyle = 0
3844:                 .Visible = .T.
3845:             ENDWITH
3846:             loc_oPg.AddObject("lbl_4c_Label5", "Label")
3847:             WITH loc_oPg.lbl_4c_Label5
3848:                 .Top = 341
3849:                 .Left = 93
3850:                 .Width = 85
3851:                 .Height = 15
3852:                 .AutoSize = .F.
3853:                 .Caption = "Utiliza Peso Total :"
3854:                 .BackStyle = 0
3855:                 .Visible = .T.
3856:             ENDWITH
3857:             * Spinner
3858:             loc_oPg.AddObject("obj_4c_Spn_NCqtd", "Spinner")
3859:             WITH loc_oPg.obj_4c_Spn_NCqtd
3860:                 .Top = 11
3861:                 .Left = 111
3862:                 .Width = 52
3863:                 .Height = 25
3864:                 .SpinnerLowValue = 0
3865:                 .SpinnerHighValue = 9
3866:                 .Increment = 1
3867:                 .Visible = .T.
3868:             ENDWITH
3869:             * TextBoxes
3870:             loc_oPg.AddObject("txt_4c_Obspads", "TextBox")
3871:             WITH loc_oPg.txt_4c_Obspads
3872:                 .Top = 42
3873:                 .Left = 121
3874:                 .Width = 31
3875:                 .Height = 21
3876:                 .Visible = .T.
3877:             ENDWITH
3878:             loc_oPg.AddObject("txt_4c_ObsInis", "TextBox")
3879:             WITH loc_oPg.txt_4c_ObsInis
3880:                 .Top = 42
3881:                 .Left = 182
3882:                 .Width = 31
3883:                 .Height = 21
3884:                 .Visible = .T.
3885:             ENDWITH
3886:             loc_oPg.AddObject("txt_4c_ObsFins", "TextBox")
3887:             WITH loc_oPg.txt_4c_ObsFins
3888:                 .Top = 42
3889:                 .Left = 236
3890:                 .Width = 31
3891:                 .Height = 21
3892:                 .Visible = .T.
3893:             ENDWITH
3894:             loc_oPg.AddObject("txt_4c_TpOp", "TextBox")
3895:             WITH loc_oPg.txt_4c_TpOp
3896:                 .Top = 113
3897:                 .Left = 187
3898:                 .Width = 80
3899:                 .Height = 23
3900:                 .Visible = .T.
3901:             ENDWITH
3902:             loc_oPg.AddObject("txt_4c_GruFin", "TextBox")
3903:             WITH loc_oPg.txt_4c_GruFin
3904:                 .Top = 140
3905:                 .Left = 187
3906:                 .Width = 80
3907:                 .Height = 21
3908:                 .Visible = .T.
3909:             ENDWITH
3910:             loc_oPg.AddObject("txt_4c_DGruFin", "TextBox")
3911:             WITH loc_oPg.txt_4c_DGruFin
3912:                 .Top = 140
3913:                 .Left = 270
3914:                 .Width = 150
3915:                 .Height = 21
3916:                 .ReadOnly = .T.
3917:                 .DisabledBackColor = RGB(240,240,240)
3918:                 .Visible = .T.
3919:             ENDWITH
3920:             loc_oPg.AddObject("txt_4c_OpConta", "TextBox")
3921:             WITH loc_oPg.txt_4c_OpConta
3922:                 .Top = 168
3923:                 .Left = 187
3924:                 .Width = 233
3925:                 .Height = 21
3926:                 .Visible = .T.
3927:             ENDWITH
3928:             loc_oPg.AddObject("txt_4c__gruccus", "TextBox")
3929:             WITH loc_oPg.txt_4c__gruccus
3930:                 .Top = 250
3931:                 .Left = 186
3932:                 .Width = 80
3933:                 .Height = 23
3934:                 .Visible = .T.
3935:             ENDWITH
3936:             loc_oPg.AddObject("txt_4c__dgruccus", "TextBox")
3937:             WITH loc_oPg.txt_4c__dgruccus
3938:                 .Top = 250
3939:                 .Left = 268
3940:                 .Width = 318
3941:                 .Height = 23
3942:                 .ReadOnly = .T.
3943:                 .DisabledBackColor = RGB(240,240,240)
3944:                 .Visible = .T.
3945:             ENDWITH
3946:             loc_oPg.AddObject("txt_4c__contaccus", "TextBox")
3947:             WITH loc_oPg.txt_4c__contaccus
3948:                 .Top = 275
3949:                 .Left = 186
3950:                 .Width = 80
3951:                 .Height = 23
3952:                 .Visible = .T.
3953:             ENDWITH
3954:             loc_oPg.AddObject("txt_4c__dcontaccus", "TextBox")
3955:             WITH loc_oPg.txt_4c__dcontaccus
3956:                 .Top = 275
3957:                 .Left = 268
3958:                 .Width = 318
3959:                 .Height = 23
3960:                 .ReadOnly = .T.
3961:                 .DisabledBackColor = RGB(240,240,240)
3962:                 .Visible = .T.
3963:             ENDWITH
3964:             loc_oPg.AddObject("txt_4c_Semi", "TextBox")
3965:             WITH loc_oPg.txt_4c_Semi
3966:                 .Top = 315
3967:                 .Left = 186
3968:                 .Width = 134
3969:                 .Height = 23
3970:                 .Visible = .T.
3971:             ENDWITH
3972:             * OptionGroups
3973:             loc_oPg.AddObject("obj_4c_Fwoption1", "OptionGroup")
3974:             WITH loc_oPg.obj_4c_Fwoption1
3975:                 .Top = 71
3976:                 .Left = 181
3977:                 .Width = 92
3978:                 .Height = 20
3979:                 .ButtonCount = 2
3980:                 .Visible = .T.
3981:                 WITH .Buttons(1)
3982:                     .Left = 3
3983:                     .Caption = "Sim"
3984:                     .Width = 40
3985:                 ENDWITH
3986:                 WITH .Buttons(2)
3987:                     .Left = 46
3988:                     .Caption = "N" + CHR(227) + "o"
3989:                     .Width = 40
3990:                 ENDWITH
3991:             ENDWITH
3992:             loc_oPg.AddObject("obj_4c_Fwoption2", "OptionGroup")
3993:             WITH loc_oPg.obj_4c_Fwoption2
3994:                 .Top = 92
3995:                 .Left = 181
3996:                 .Width = 92
3997:                 .Height = 20
3998:                 .ButtonCount = 2
3999:                 .Visible = .T.
4000:                 WITH .Buttons(1)
4001:                     .Left = 3
4002:                     .Caption = "Sim"
4003:                     .Width = 40
4004:                 ENDWITH
4005:                 WITH .Buttons(2)
4006:                     .Left = 46
4007:                     .Caption = "N" + CHR(227) + "o"
4008:                     .Width = 40
4009:                 ENDWITH
4010:             ENDWITH
4011:             loc_oPg.AddObject("obj_4c_Fwoption3", "OptionGroup")
4012:             WITH loc_oPg.obj_4c_Fwoption3
4013:                 .Top = 196
4014:                 .Left = 180
4015:                 .Width = 92
4016:                 .Height = 20
4017:                 .ButtonCount = 2
4018:                 .Visible = .T.
4019:                 WITH .Buttons(1)
4020:                     .Left = 3
4021:                     .Caption = "Sim"
4022:                     .Width = 40
4023:                 ENDWITH
4024:                 WITH .Buttons(2)
4025:                     .Left = 46
4026:                     .Caption = "N" + CHR(227) + "o"
4027:                     .Width = 40
4028:                 ENDWITH
4029:             ENDWITH
4030:             loc_oPg.AddObject("obj_4c_Fwoption4", "OptionGroup")
4031:             WITH loc_oPg.obj_4c_Fwoption4
4032:                 .Top = 220
4033:                 .Left = 180
4034:                 .Width = 92
4035:                 .Height = 20
4036:                 .ButtonCount = 2
4037:                 .Visible = .T.
4038:                 WITH .Buttons(1)
4039:                     .Left = 3
4040:                     .Caption = "Sim"
4041:                     .Width = 40
4042:                 ENDWITH
4043:                 WITH .Buttons(2)
4044:                     .Left = 46
4045:                     .Caption = "N" + CHR(227) + "o"
4046:                     .Width = 40
4047:                 ENDWITH
4048:             ENDWITH
4049:             loc_oPg.AddObject("obj_4c_Fwoption5", "OptionGroup")
4050:             WITH loc_oPg.obj_4c_Fwoption5
4051:                 .Top = 338
4052:                 .Left = 184
4053:                 .Width = 182
4054:                 .Height = 21
4055:                 .ButtonCount = 3
4056:                 .Visible = .T.
4057:                 WITH .Buttons(1)
4058:                     .Left = 3
4059:                     .Width = 55
4060:                 ENDWITH
4061:                 WITH .Buttons(2)
4062:                     .Left = 61
4063:                     .Width = 55
4064:                 ENDWITH
4065:                 WITH .Buttons(3)
4066:                     .Left = 119
4067:                     .Width = 55
4068:                 ENDWITH
4069:             ENDWITH
4070:             loc_oPg.AddObject("obj_4c_Optiongroup1", "OptionGroup")
4071:             WITH loc_oPg.obj_4c_Optiongroup1
4072:                 .Top = 80
4073:                 .Left = 818
4074:                 .Width = 119
4075:                 .Height = 19
4076:                 .ButtonCount = 2
4077:                 .Visible = .T.
4078:                 WITH .Buttons(1)
4079:                     .Left = 3
4080:                     .Caption = "Sim"
4081:                     .Width = 54
4082:                 ENDWITH
4083:                 WITH .Buttons(2)
4084:                     .Left = 60
4085:                     .Caption = "N" + CHR(227) + "o"
4086:                     .Width = 54
4087:                 ENDWITH
4088:             ENDWITH
4089:             * CheckBoxes
4090:             loc_oPg.AddObject("chk_4c_Chk_Pcc", "CheckBox")
4091:             WITH loc_oPg.chk_4c_Chk_Pcc
4092:                 .Top = 12
4093:                 .Left = 604
4094:                 .Width = 200
4095:                 .Height = 19
4096:                 .Caption = "Marcar OP como cancelada"
4097:                 .Value = 0
4098:                 .Visible = .T.
4099:             ENDWITH
4100:             loc_oPg.AddObject("chk_4c_Chk_imp", "CheckBox")
4101:             WITH loc_oPg.chk_4c_Chk_imp
4102:                 .Top = 29
4103:                 .Left = 604
4104:                 .Width = 250
4105:                 .Height = 19
4106:                 .Caption = "Imprimir Somente Peso do Material Principal"
4107:                 .Value = 0
4108:                 .Visible = .T.
4109:             ENDWITH
4110:             loc_oPg.AddObject("chk_4c_Chk_InibAlt", "CheckBox")
4111:             WITH loc_oPg.chk_4c_Chk_InibAlt
4112:                 .Top = 46
4113:                 .Left = 604
4114:                 .Width = 280
4115:                 .Height = 19
4116:                 .Caption = "Inibir Inserir/Alterar/Excluir Dos Componentes"
4117:                 .Value = 0
4118:                 .Visible = .T.
4119:             ENDWITH
4120:             loc_oPg.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
4121:             WITH loc_oPg.chk_4c_Fwcheckbox1
4122:                 .Top = 64
4123:                 .Left = 604
4124:                 .Width = 230
4125:                 .Height = 19
4126:                 .Caption = "Checar Conta Destino (Sep.Pedra)"
4127:                 .Value = 0
4128:                 .Visible = .T.
4129:             ENDWITH
4130:             loc_oPg.AddObject("chk_4c_Fwcheckbox8", "CheckBox")
4131:             WITH loc_oPg.chk_4c_Fwcheckbox8
4132:                 .Top = 81
4133:                 .Left = 604
4134:                 .Width = 210
4135:                 .Height = 19
4136:                 .Caption = "Pedir Senha para Exclus" + CHR(227) + "o da Opera" + CHR(231) + CHR(227) + "o"
4137:                 .Value = 0
4138:                 .Visible = .T.
4139:             ENDWITH
4140:             loc_oPg.AddObject("chk_4c_ChkOpLote", "CheckBox")
4141:             WITH loc_oPg.chk_4c_ChkOpLote
4142:                 .Top = 223
4143:                 .Left = 337
4144:                 .Width = 135
4145:                 .Height = 19
4146:                 .Caption = "Checar OP do Lote"
4147:                 .Value = 0
4148:                 .Visible = .T.
4149:             ENDWITH
4150:             * BINDEVENTs lookups Diversas
4151:             BINDEVENT(loc_oPg.txt_4c_Obspads,   "KeyPress", THIS, "ObspadsKeyPress")

*-- Linhas 4311 a 4320:
4311:             THIS.this_oBusinessObject.this_nPccs       = IIF(loc_oPDiv.chk_4c_Chk_Pcc.Value = 1, 1, 0)
4312:             THIS.this_oBusinessObject.this_nPesmatps   = IIF(loc_oPDiv.chk_4c_Chk_imp.Value = 1, 1, 0)
4313:             THIS.this_oBusinessObject.this_nInibAlts   = IIF(loc_oPDiv.chk_4c_Chk_InibAlt.Value = 1, 1, 0)
4314:             THIS.this_oBusinessObject.this_nChkctdes   = IIF(loc_oPDiv.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
4315:             THIS.this_oBusinessObject.this_nChksenexc  = IIF(loc_oPDiv.chk_4c_Fwcheckbox8.Value = 1, 1, 0)
4316:             THIS.this_oBusinessObject.this_nChkoplts   = IIF(loc_oPDiv.chk_4c_ChkOpLote.Value = 1, 1, 0)
4317:         CATCH TO loException
4318:             MostrarErro(loException, "FormMPD.FormParaBO")
4319:         ENDTRY
4320:     ENDPROC

*-- Linhas 4466 a 4475:
4466:             loc_oPDiv.chk_4c_Chk_Pcc.Value      = loc_oBO.this_nPccs
4467:             loc_oPDiv.chk_4c_Chk_imp.Value       = loc_oBO.this_nPesmatps
4468:             loc_oPDiv.chk_4c_Chk_InibAlt.Value  = loc_oBO.this_nInibAlts
4469:             loc_oPDiv.chk_4c_Fwcheckbox1.Value   = loc_oBO.this_nChkctdes
4470:             loc_oPDiv.chk_4c_Fwcheckbox8.Value   = loc_oBO.this_nChksenexc
4471:             loc_oPDiv.chk_4c_ChkOpLote.Value     = loc_oBO.this_nChkoplts
4472:         CATCH TO loException
4473:             MostrarErro(loException, "FormMPD.BOParaForm")
4474:         ENDTRY
4475:     ENDPROC

*-- Linhas 4484 a 4492:
4484:             loc_oPD.txt_4c_Desc.Enabled                      = par_lHabilitar
4485:             loc_oPD.txt_4c_Nope.Enabled                      = par_lHabilitar
4486:             loc_oPD.txt_4c_Ordem.Enabled                     = par_lHabilitar
4487:             loc_oPD.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled  = par_lHabilitar
4488:         CATCH TO loException
4489:             MostrarErro(loException, "FormMPD.HabilitarCampos")
4490:         ENDTRY
4491:     ENDPROC
4492: 

*-- Linhas 5286 a 5298:
5286:             loc_oBotoes     = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
5287:             loc_lTemSelecao = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
5288:             WITH loc_oBotoes
5289:                 .cmd_4c_Incluir.Enabled    = .T.
5290:                 .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
5291:                 .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
5292:                 .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
5293:                 .cmd_4c_Buscar.Enabled     = .T.
5294:             ENDWITH
5295:         CATCH TO loc_oErro
5296:             MsgErro(loc_oErro.Message, "FormMPD.AjustarBotoesPorModo")
5297:         ENDTRY
5298:     ENDPROC


### BO (C:\4c\projeto\app\classes\MPDBO.prg):
* MPDBO.prg
* BO: Movimentacoes de Producao (SigCdOpd)

DEFINE CLASS MPDBO AS BusinessBase

  * ============================================================
  * IDENTIFICACAO
  * ============================================================
  this_cDopps      = ""    && char(20) - codigo da operacao (chave de negocio)
  this_nNdopps     = 0     && numeric(3) - numero da operacao
  this_nOrdes      = 0     && numeric(3) - ordem
  this_cCidchaves  = ""    && char(20) - PK tecnica do banco

  * ============================================================
  * ABA OPERACAO
  * ============================================================
  this_nSubns      = 0     && numeric(1) - tem subnivel (1=Sim 2=Nao)
  this_cNivels     = ""    && char(20) - subnivel
  this_cTnivels    = ""    && char(15) - titulo do subnivel
  this_cArtigos    = ""    && char(1)  - artigo do subnivel
  this_cCarqIcones = ""    && char(64) - arquivo icone
  this_nImagems    = 0     && numeric(1) - usa imagem
  this_nBoletos    = 0     && numeric(1) - gera boleto
  this_nMenus      = 0     && numeric(1) - exibe no menu
  this_nAutos      = 0     && numeric(1) - lancamento automatico
  this_nBxautos    = 0     && numeric(1) - baixa automatica
  this_nBtnpags    = 0     && numeric(1) - botao pagamento
  this_nBuscaenvs  = 0     && numeric(1) - busca envio
  this_nApontas    = 0     && numeric(1) - apontamento
  this_nChkdests   = 0     && numeric(2) - checkdests
  this_nCestoqs    = 0     && numeric(1) - centraliza estoques
  this_nChkfases   = 0     && numeric(1) - check fases
  this_nSeqs       = 0     && numeric(1) - sequencia
  this_nInibmens   = 0     && numeric(1) - inibe mensagem
  this_cHists      = ""    && char(30) - historico
  this_nMenfalhas  = 0     && numeric(1) - mensagem de falhas
  this_nBtnrets    = 0     && numeric(1) - botao retrabalho
  this_nBtnincs    = 0     && numeric(1) - botao inserir componente
  this_nExclsubns  = 0     && numeric(1) - excluir subnivel
  this_nEtiqenvs   = 0     && numeric(1) - etiqueta envio
  this_nChktemsubn = 0     && numeric(1) - tem subnivel check
  this_cDopemphs   = ""    && char(20) - operacao empenho
  this_cEmplancs   = ""    && char(3)  - empresa lancamento
  this_nBolops     = 0     && numeric(1) - boleto operacao
  this_nBolcomps   = 0     && numeric(1) - boleto componente
  this_nAgregas    = 0     && numeric(1) - agrega
  this_nTipoops    = 0     && numeric(2) - tipo operacao

  * ============================================================
  * ABA ESTOQUE
  * ============================================================
  this_nDocus      = 0     && numeric(1) - documentos
  this_nEstorigs   = 0     && numeric(1) - estoque origem
  this_nDestinos   = 0     && numeric(1) - destino
  this_nEstdests   = 0     && numeric(1) - estoque destino
  this_nCrepls     = 0     && numeric(1) - crepls
  this_nOrigems    = 0     && numeric(1) - origem (1=usa)
  this_nVends      = 0     && numeric(1) - venda
  this_nFixgorigs  = 0     && bit - fixa grupo origem
  this_nFixcorigs  = 0     && bit - fixa conta origem
  this_nFixgdests  = 0     && bit - fixa grupo destino
  this_nFixcdests  = 0     && bit - fixa conta destino
  this_nConosubs   = 0     && numeric(1) - con ori sub
  this_nCondsubs   = 0     && numeric(1) - con dest sub
  this_nBxoests    = 0     && numeric(1) - baixa estoque origem
  this_nBxdests    = 0     && numeric(1) - baixa estoque destino
  this_cGruorigs   = ""    && char(10) - grupo origem
  this_cGrudests   = ""    && char(10) - grupo destino
  this_cGrvends    = ""    && char(10) - grupo venda
  this_cConorigs   = ""    && char(10) - conta origem
  this_cCondests   = ""    && char(10) - conta destino
  this_nFixgvends  = 0     && bit - fixa grupo venda
  this_nSenhaos    = 0     && numeric(1) - senha origem
  this_nSenhads    = 0     && numeric(1) - senha destino
  this_cMascos     = ""    && char(10) - mascara origem
  this_cMascds     = ""    && char(10) - mascara destino
  this_nNumeras    = 0     && numeric(1) - numeracao

  * ============================================================
  * ABA COMPONENTE
  * ============================================================
  this_nGrcomps    = 0     && numeric(1) - grade componente
  this_nEtiqs      = 0     && numeric(1) - etiqueta
  this_nChkfunds   = 0     && numeric(1) - check fundo
  this_nGrodns     = 0     && numeric(1) - grade ordem
  this_nReinops    = 0     && numeric(1) - reinoperacao
  this_nMatprncdif = 0     && numeric(1) - mat principal diferente
  this_nResumopop  = 0     && numeric(1) - resumo op
  this_nQtdnegs    = 0     && numeric(1) - quantidade negativa
  this_nSeppedras  = 0     && numeric(1) - separacao pedras (1/3/4=sim)
  this_nTrfpesas   = 0     && numeric(1) - transfere pesas
  this_cPqs        = ""    && char(1) - pqs
  this_nPesobals   = 0     && numeric(1) - peso balanca
  this_nEnvobrigs  = 0     && numeric(1) - envio obrigatorio
  this_nMensagens  = 0     && numeric(1) - mensagens
  this_nPagservs   = 0     && numeric(1) - pagamento servico
  this_nGrprods    = 0     && numeric(1) - grade produto
  this_nCompagrus  = 0     && numeric(1) - componente agrupado
  this_nPesofixs   = 0     && numeric(1) - peso fixo
  this_nChkqtdps   = 0     && numeric(1) - chk qtd pcs
  this_cTppadraos  = ""    && char(15) - tipo padrao
  this_cRetalhos   = ""    && char(15) - retalho
  this_nValobrigs  = 0     && numeric(1) - valor obrigatorio
  this_nBxpedfins  = 0     && numeric(1) - baixa ped fins
  this_cPccfases   = ""    && char(10) - pcc fases
  this_nLimqtds    = 0     && numeric(9,3) - limite quantidade
  this_nDiflancs   = 0     && numeric(4,2) - diferenca lancamentos
  this_nDifpesags  = 0     && numeric(9,3) - diferenca pesagem
  this_nSinals     = 0     && numeric(1) - sinal
  this_nLibrpqs    = 0     && numeric(1) - libera pqs
  this_nAgseps     = 0     && numeric(1) - agrupamento separacao
  this_nQuebras    = 0     && numeric(1) - quebra
  this_nCravcers   = 0     && numeric(1) - cravacao cera
  this_nSolcdlbs   = 0     && numeric(1) - sol cd libs
  this_nNcarqtds   = 0     && numeric(1) - n car qtds
  this_cMatpads    = ""    && char(14) - material padrao
  this_nChkpesos   = 0     && numeric(1) - check pesos
  this_nChkmtprs   = 0     && numeric(1) - check mat principal
  this_nChkmetal   = 0     && numeric(1) - check metal

  * ============================================================
  * ABA DOCUMENTO
  * ============================================================
  this_nDckcabec   = 0     && numeric(1) - dck cabecalho
  this_nDckitens   = 0     && numeric(1) - dck itens
  this_nDckresu    = 0     && numeric(1) - dck resumo

  * ============================================================
  * ABA DIVERSAS
  * ============================================================
  this_nCasqtds    = 0     && numeric(2) - casas decimais qtd
  this_nObspads    = 0     && numeric(3) - obs padrao
  this_nObsinis    = 0     && numeric(3) - obs iniciais
  this_nObsfins    = 0     && numeric(3) - obs finais
  this_nCtrlotes   = 0     && numeric(1) - controle lotes
  this_nAcenvs     = 0     && numeric(1) - ac envios
  this_nEnvelopes  = 0     && numeric(1) - envelopes
  this_nChkunis    = 0     && numeric(1) - check unidade
  this_cGrufins    = ""    && char(10) - grupo financeiro
  this_nChkpesotot = 0     && numeric(1) - check peso total
  this_cDopcs      = ""    && char(20) - dop cs
  this_nPccs       = 0     && bit - pccs
  this_nPesmatps   = 0     && bit - peso mat principal
  this_nInibAlts   = 0     && bit - inibe alteracao
  this_nChkctdes   = 0     && numeric(1) - check ct des
  this_cCodtgops   = ""    && char(10) - cod tg ops
  this_cGruccus    = ""    && char(10) - grupo custo cus
  this_cContaccus  = ""    && char(10) - conta custo cus
  this_nChkoplts   = 0     && numeric(1) - check op lotes
  this_cDopsemis   = ""    && char(20) - dop semis
  this_nChksenexc  = 0     && numeric(1) - check senha exclusao
  this_nTpsenexc   = 0     && numeric(1) - tipo senha exclusao

  * ============================================================
  * INIT
  * ============================================================
  FUNCTION Init()
    DODEFAULT()
    this_cTabela     = "SigCdOpd"
    this_cCampoChave = "Dopps"
  ENDFUNC

  *--------------------------------------------------------------------------
  FUNCTION ObterChavePrimaria()
    RETURN THIS.this_cDopps
  ENDFUNC

  *--------------------------------------------------------------------------
  PROCEDURE Buscar(par_cFiltro)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT Dopps, Ndopps, Ordes, hists FROM SigCdOpd"
      IF !EMPTY(ALLTRIM(par_cFiltro))
        loc_cSQL = loc_cSQL + " WHERE Dopps LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%")
      ENDIF
      loc_cSQL = loc_cSQL + " ORDER BY Ndopps, Ordes"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
      IF loc_nResultado >= 0
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROCEDURE CarregarPorCodigo(par_cDopps)
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(par_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
      IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
        loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
        THIS.this_lNovoRegistro = .F.
      ENDIF
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
      IF USED("cursor_4c_Carrega")
        USE IN cursor_4c_Carrega
      ENDIF
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
    LOCAL loc_lSucesso
    loc_lSucesso = .F.
    IF USED(par_cAliasCursor)
      SELECT (par_cAliasCursor)
      THIS.this_cDopps        = TratarNulo(Dopps,        "C")
      THIS.this_nNdopps       = TratarNulo(Ndopps,       "N")
      THIS.this_nOrdes        = TratarNulo(Ordes,        "N")
      THIS.this_cCidchaves    = TratarNulo(Cidchaves,    "C")
      THIS.this_nSubns        = TratarNulo(subns,        "N")
      THIS.this_nAgregas      = TratarNulo(agregas,      "N")
      THIS.this_cNivels       = TratarNulo(nivels,       "C")
      THIS.this_cTnivels      = TratarNulo(Tnivels,      "C")
      THIS.this_cArtigos      = TratarNulo(Artigos,      "C")
      THIS.this_cCarqIcones   = TratarNulo(cArqIcones,   "C")
      THIS.this_nImagems      = TratarNulo(imagems,      "N")
      THIS.this_nBoletos      = TratarNulo(boletos,      "N")
      THIS.this_nMenus        = TratarNulo(menus,        "N")
      THIS.this_nAutos        = TratarNulo(autos,        "N")
      THIS.this_nBxautos      = TratarNulo(bxautos,      "N")
      THIS.this_nBtnpags      = TratarNulo(btnpags,      "N")
      THIS.this_nBuscaenvs    = TratarNulo(BuscaEnvs,    "N")
      THIS.this_nApontas      = TratarNulo(apontas,      "N")
      THIS.this_nChkdests     = TratarNulo(ChkDests,     "N")
      THIS.this_nCestoqs      = TratarNulo(cestoqs,      "N")
      THIS.this_nChkfases     = TratarNulo(chkfases,     "N")
      THIS.this_nSeqs         = TratarNulo(seqs,         "N")
      THIS.this_nInibmens     = TratarNulo(Inibmens,     "N")
      THIS.this_cHists        = TratarNulo(hists,        "C")
      THIS.this_nMenfalhas    = TratarNulo(Menfalhas,    "N")
      THIS.this_nBtnrets      = TratarNulo(btnrets,      "N")
      THIS.this_nBtnincs      = TratarNulo(btnincs,      "N")
      THIS.this_nExclsubns    = TratarNulo(exclsubns,    "N")
      THIS.this_nEtiqenvs     = TratarNulo(etiqenvs,     "N")
      THIS.this_nChktemsubn   = TratarNulo(chkTemSubn,   "N")
      THIS.this_cDopemphs     = TratarNulo(dopemphs,     "C")
      THIS.this_cEmplancs     = TratarNulo(emplancs,     "C")
      THIS.this_nBolops       = TratarNulo(bolops,       "N")
      THIS.this_nBolcomps     = TratarNulo(bolcomps,     "N")
      THIS.this_nTipoops      = TratarNulo(tipoops,      "N")
      THIS.this_nDocus        = TratarNulo(Docus,        "N")
      THIS.this_nEstorigs     = TratarNulo(EstOrigs,     "N")
      THIS.this_nDestinos     = TratarNulo(Destinos,     "N")
      THIS.this_nEstdests     = TratarNulo(EstDests,     "N")
      THIS.this_nCrepls       = TratarNulo(CRepls,       "N")
      THIS.this_nOrigems      = TratarNulo(Origems,      "N")
      THIS.this_nVends        = TratarNulo(Vends,        "N")
      THIS.this_nFixgorigs    = TratarNulo(FixGOrigs,    "N")
      THIS.this_nFixcorigs    = TratarNulo(FixCOrigs,    "N")
      THIS.this_nFixgdests    = TratarNulo(FixGDests,    "N")
      THIS.this_nFixcdests    = TratarNulo(FixCDests,    "N")
      THIS.this_nConosubs     = TratarNulo(conosubs,     "N")
      THIS.this_nCondsubs     = TratarNulo(condsubs,     "N")
      THIS.this_nBxoests      = TratarNulo(BxOEsts,      "N")
      THIS.this_nBxdests      = TratarNulo(BxDEsts,      "N")
      THIS.this_cGruorigs     = TratarNulo(GruOrigs,     "C")
      THIS.this_cGrudests     = TratarNulo(GruDests,     "C")
      THIS.this_cGrvends      = TratarNulo(grvends,      "C")
      THIS.this_cConorigs     = TratarNulo(ConOrigs,     "C")
      THIS.this_cCondests     = TratarNulo(ConDests,     "C")
      THIS.this_nFixgvends    = TratarNulo(FixGVends,    "N")
      THIS.this_nSenhaos      = TratarNulo(Senhaos,      "N")
      THIS.this_nSenhads      = TratarNulo(Senhads,      "N")
      THIS.this_cMascos       = TratarNulo(mascos,       "C")
      THIS.this_cMascds       = TratarNulo(mascds,       "C")
      THIS.this_nNumeras      = TratarNulo(Numeras,      "N")
      THIS.this_nGrcomps      = TratarNulo(grcomps,      "N")
      THIS.this_nEtiqs        = TratarNulo(etiqs,        "N")
      THIS.this_nChkfunds     = TratarNulo(chkfunds,     "N")
      THIS.this_nGrodns       = TratarNulo(grodns,       "N")
      THIS.this_nReinops      = TratarNulo(reinops,      "N")
      THIS.this_nMatprncdif   = TratarNulo(MatPrncDif,   "N")
      THIS.this_nResumopop    = TratarNulo(ResumoPOp,    "N")
      THIS.this_nQtdnegs      = TratarNulo(QtdNegs,      "N")
      THIS.this_nSeppedras    = TratarNulo(seppedras,    "N")
      THIS.this_nTrfpesas     = TratarNulo(trfpesas,     "N")
      THIS.this_cPqs          = TratarNulo(Pqs,          "C")
      THIS.this_nPesobals     = TratarNulo(PesoBals,     "N")
      THIS.this_nEnvobrigs    = TratarNulo(EnvObrigs,    "N")
      THIS.this_nMensagens    = TratarNulo(mensagens,    "N")
      THIS.this_nPagservs     = TratarNulo(pagservs,     "N")
      THIS.this_nGrprods      = TratarNulo(grprods,      "N")
      THIS.this_nCompagrus    = TratarNulo(compagrus,    "N")
      THIS.this_nPesofixs     = TratarNulo(pesofixs,     "N")
      THIS.this_nChkqtdps     = TratarNulo(CHKQTDPS,    "N")
      THIS.this_cTppadraos    = TratarNulo(TpPadraos,    "C")
      THIS.this_cRetalhos     = TratarNulo(retalhos,     "C")
      THIS.this_nValobrigs    = TratarNulo(ValObrigs,    "N")
      THIS.this_nBxpedfins    = TratarNulo(BxPedFins,    "N")
      THIS.this_cPccfases     = TratarNulo(PccFases,     "C")
      THIS.this_nLimqtds      = TratarNulo(LimQtds,      "N")
      THIS.this_nDiflancs     = TratarNulo(diflancs,     "N")
      THIS.this_nDifpesags    = TratarNulo(difpesags,    "N")
      THIS.this_nSinals       = TratarNulo(Sinals,       "N")
      THIS.this_nLibrpqs      = TratarNulo(Librpqs,      "N")
      THIS.this_nAgseps       = TratarNulo(agseps,       "N")
      THIS.this_nQuebras      = TratarNulo(quebras,      "N")
      THIS.this_nCravcers     = TratarNulo(CravCers,     "N")
      THIS.this_nSolcdlbs     = TratarNulo(SolCdlbs,    "N")
      THIS.this_nNcarqtds     = TratarNulo(nCarQtds,    "N")
      THIS.this_cMatpads      = TratarNulo(MatPads,     "C")
      THIS.this_nChkpesos     = TratarNulo(chkPesos,    "N")
      THIS.this_nChkmtprs     = TratarNulo(ChkMtPrs,    "N")
      THIS.this_nChkmetal     = TratarNulo(chkMetal,    "N")
      THIS.this_nDckcabec     = TratarNulo(dckcabec,    "N")
      THIS.this_nDckitens     = TratarNulo(dckItens,    "N")
      THIS.this_nDckresu      = TratarNulo(dckResu,     "N")
      THIS.this_nCasqtds      = TratarNulo(CasQtds,    "N")
      THIS.this_nObspads      = TratarNulo(obspads,     "N")
      THIS.this_nObsinis      = TratarNulo(obsinis,     "N")
      THIS.this_nObsfins      = TratarNulo(obsfins,     "N")
      THIS.this_nCtrlotes     = TratarNulo(CtrLotes,    "N")
      THIS.this_nAcenvs       = TratarNulo(AcEnvs,      "N")
      THIS.this_nEnvelopes    = TratarNulo(envelopes,   "N")
      THIS.this_nChkunis      = TratarNulo(chkunis,     "N")
      THIS.this_cGrufins      = TratarNulo(grufins,     "C")
      THIS.this_nChkpesotot   = TratarNulo(chkPesoTot, "N")
      THIS.this_cDopcs        = TratarNulo(dopcs,       "C")
      THIS.this_nPccs         = TratarNulo(pccs,        "N")
      THIS.this_nPesmatps     = TratarNulo(pesmatps,    "N")
      THIS.this_nInibAlts     = TratarNulo(InibAlts,    "N")
      THIS.this_nChkctdes     = TratarNulo(ChkCtDes,   "N")
      THIS.this_cCodtgops     = TratarNulo(CodTgOps,   "C")
      THIS.this_cGruccus      = TratarNulo(gruccus,    "C")
      THIS.this_cContaccus    = TratarNulo(contaccus,  "C")
      THIS.this_nChkoplts     = TratarNulo(chkoplts,   "N")
      THIS.this_cDopsemis     = TratarNulo(dopsemis,   "C")
      THIS.this_nChksenexc    = TratarNulo(chksenexc,  "N")
      THIS.this_nTpsenexc     = TratarNulo(tpsenexc,   "N")
      loc_lSucesso = .T.
    ENDIF
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Inserir()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "INSERT INTO SigCdOpd (" + ;
                 "Dopps, Ndopps, Ordes, Cidchaves," + ;
                 " subns, agregas, nivels, Tnivels, Artigos, cArqIcones," + ;
                 " imagems, boletos, menus, autos, bxautos, btnpags, BuscaEnvs," + ;
                 " apontas, ChkDests, cestoqs, chkfases, seqs, Inibmens, hists," + ;
                 " Menfalhas, btnrets, btnincs, exclsubns, etiqenvs, chkTemSubn," + ;
                 " dopemphs, emplancs, bolops, bolcomps, tipoops," + ;
                 " Docus, EstOrigs, Destinos, EstDests, CRepls, Origems, Vends," + ;
                 " FixGOrigs, FixCOrigs, FixGDests, FixCDests, conosubs, condsubs," + ;
                 " BxOEsts, BxDEsts, GruOrigs, GruDests, grvends, ConOrigs, ConDests," + ;
                 " FixGVends, Senhaos, Senhads, mascos, mascds, Numeras," + ;
                 " grcomps, etiqs, chkfunds, grodns, reinops, MatPrncDif, ResumoPOp," + ;
                 " QtdNegs, seppedras, trfpesas, Pqs, PesoBals, EnvObrigs, mensagens," + ;
                 " pagservs, grprods, compagrus, pesofixs, CHKQTDPS, TpPadraos, retalhos," + ;
                 " ValObrigs, BxPedFins, PccFases, LimQtds, diflancs, difpesags, Sinals," + ;
                 " Librpqs, agseps, quebras, CravCers, SolCdlbs, nCarQtds, MatPads," + ;
                 " chkPesos, ChkMtPrs, chkMetal," + ;
                 " dckcabec, dckItens, dckResu," + ;
                 " CasQtds, obspads, obsinis, obsfins, CtrLotes, AcEnvs, envelopes," + ;
                 " chkunis, grufins, chkPesoTot, dopcs, pccs, pesmatps, InibAlts," + ;
                 " ChkCtDes, CodTgOps, gruccus, contaccus, chkoplts, dopsemis, chksenexc, tpsenexc" + ;
                 ") VALUES (" + ;
                 EscaparSQL(THIS.this_cDopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 EscaparSQL(THIS.this_cCidchaves) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 EscaparSQL(THIS.this_cNivels) + "," + ;
                 EscaparSQL(THIS.this_cTnivels) + "," + ;
                 EscaparSQL(THIS.this_cArtigos) + "," + ;
                 EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 EscaparSQL(THIS.this_cHists) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 EscaparSQL(THIS.this_cGrudests) + "," + ;
                 EscaparSQL(THIS.this_cGrvends) + "," + ;
                 EscaparSQL(THIS.this_cConorigs) + "," + ;
                 EscaparSQL(THIS.this_cCondests) + "," + ;
                 FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 EscaparSQL(THIS.this_cMascos) + "," + ;
                 EscaparSQL(THIS.this_cMascds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 EscaparSQL(THIS.this_cPqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 EscaparSQL(THIS.this_cPccfases) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 EscaparSQL(THIS.this_cMatpads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 EscaparSQL(THIS.this_cGrufins) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 EscaparSQL(THIS.this_cDopcs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 EscaparSQL(THIS.this_cGruccus) + "," + ;
                 EscaparSQL(THIS.this_cContaccus) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 ")"
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("INSERT")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE Atualizar()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "UPDATE SigCdOpd SET" + ;
                 " Ndopps = " + FormatarNumeroSQL(THIS.this_nNdopps) + "," + ;
                 " Ordes = " + FormatarNumeroSQL(THIS.this_nOrdes) + "," + ;
                 " subns = " + FormatarNumeroSQL(THIS.this_nSubns) + "," + ;
                 " agregas = " + FormatarNumeroSQL(THIS.this_nAgregas) + "," + ;
                 " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
                 " Tnivels = " + EscaparSQL(THIS.this_cTnivels) + "," + ;
                 " Artigos = " + EscaparSQL(THIS.this_cArtigos) + "," + ;
                 " cArqIcones = " + EscaparSQL(THIS.this_cCarqIcones) + "," + ;
                 " imagems = " + FormatarNumeroSQL(THIS.this_nImagems) + "," + ;
                 " boletos = " + FormatarNumeroSQL(THIS.this_nBoletos) + "," + ;
                 " menus = " + FormatarNumeroSQL(THIS.this_nMenus) + "," + ;
                 " autos = " + FormatarNumeroSQL(THIS.this_nAutos) + "," + ;
                 " bxautos = " + FormatarNumeroSQL(THIS.this_nBxautos) + "," + ;
                 " btnpags = " + FormatarNumeroSQL(THIS.this_nBtnpags) + "," + ;
                 " BuscaEnvs = " + FormatarNumeroSQL(THIS.this_nBuscaenvs) + "," + ;
                 " apontas = " + FormatarNumeroSQL(THIS.this_nApontas) + "," + ;
                 " ChkDests = " + FormatarNumeroSQL(THIS.this_nChkdests) + "," + ;
                 " cestoqs = " + FormatarNumeroSQL(THIS.this_nCestoqs) + "," + ;
                 " chkfases = " + FormatarNumeroSQL(THIS.this_nChkfases) + "," + ;
                 " seqs = " + FormatarNumeroSQL(THIS.this_nSeqs) + "," + ;
                 " Inibmens = " + FormatarNumeroSQL(THIS.this_nInibmens) + "," + ;
                 " hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                 " Menfalhas = " + FormatarNumeroSQL(THIS.this_nMenfalhas) + "," + ;
                 " btnrets = " + FormatarNumeroSQL(THIS.this_nBtnrets) + "," + ;
                 " btnincs = " + FormatarNumeroSQL(THIS.this_nBtnincs) + "," + ;
                 " exclsubns = " + FormatarNumeroSQL(THIS.this_nExclsubns) + "," + ;
                 " etiqenvs = " + FormatarNumeroSQL(THIS.this_nEtiqenvs) + "," + ;
                 " chkTemSubn = " + FormatarNumeroSQL(THIS.this_nChktemsubn) + "," + ;
                 " dopemphs = " + EscaparSQL(THIS.this_cDopemphs) + "," + ;
                 " emplancs = " + EscaparSQL(THIS.this_cEmplancs) + "," + ;
                 " bolops = " + FormatarNumeroSQL(THIS.this_nBolops) + "," + ;
                 " bolcomps = " + FormatarNumeroSQL(THIS.this_nBolcomps) + "," + ;
                 " tipoops = " + FormatarNumeroSQL(THIS.this_nTipoops) + "," + ;
                 " Docus = " + FormatarNumeroSQL(THIS.this_nDocus) + "," + ;
                 " EstOrigs = " + FormatarNumeroSQL(THIS.this_nEstorigs) + "," + ;
                 " Destinos = " + FormatarNumeroSQL(THIS.this_nDestinos) + "," + ;
                 " EstDests = " + FormatarNumeroSQL(THIS.this_nEstdests) + "," + ;
                 " CRepls = " + FormatarNumeroSQL(THIS.this_nCrepls) + "," + ;
                 " Origems = " + FormatarNumeroSQL(THIS.this_nOrigems) + "," + ;
                 " Vends = " + FormatarNumeroSQL(THIS.this_nVends) + "," + ;
                 " FixGOrigs = " + FormatarNumeroSQL(THIS.this_nFixgorigs) + "," + ;
                 " FixCOrigs = " + FormatarNumeroSQL(THIS.this_nFixcorigs) + "," + ;
                 " FixGDests = " + FormatarNumeroSQL(THIS.this_nFixgdests) + "," + ;
                 " FixCDests = " + FormatarNumeroSQL(THIS.this_nFixcdests) + "," + ;
                 " conosubs = " + FormatarNumeroSQL(THIS.this_nConosubs) + "," + ;
                 " condsubs = " + FormatarNumeroSQL(THIS.this_nCondsubs) + "," + ;
                 " BxOEsts = " + FormatarNumeroSQL(THIS.this_nBxoests) + "," + ;
                 " BxDEsts = " + FormatarNumeroSQL(THIS.this_nBxdests) + "," + ;
                 " GruOrigs = " + EscaparSQL(THIS.this_cGruorigs) + "," + ;
                 " GruDests = " + EscaparSQL(THIS.this_cGrudests) + "," + ;
                 " grvends = " + EscaparSQL(THIS.this_cGrvends) + "," + ;
                 " ConOrigs = " + EscaparSQL(THIS.this_cConorigs) + "," + ;
                 " ConDests = " + EscaparSQL(THIS.this_cCondests) + "," + ;
                 " FixGVends = " + FormatarNumeroSQL(THIS.this_nFixgvends) + "," + ;
                 " Senhaos = " + FormatarNumeroSQL(THIS.this_nSenhaos) + "," + ;
                 " Senhads = " + FormatarNumeroSQL(THIS.this_nSenhads) + "," + ;
                 " mascos = " + EscaparSQL(THIS.this_cMascos) + "," + ;
                 " mascds = " + EscaparSQL(THIS.this_cMascds) + "," + ;
                 " Numeras = " + FormatarNumeroSQL(THIS.this_nNumeras) + "," + ;
                 " grcomps = " + FormatarNumeroSQL(THIS.this_nGrcomps) + "," + ;
                 " etiqs = " + FormatarNumeroSQL(THIS.this_nEtiqs) + "," + ;
                 " chkfunds = " + FormatarNumeroSQL(THIS.this_nChkfunds) + "," + ;
                 " grodns = " + FormatarNumeroSQL(THIS.this_nGrodns) + "," + ;
                 " reinops = " + FormatarNumeroSQL(THIS.this_nReinops) + "," + ;
                 " MatPrncDif = " + FormatarNumeroSQL(THIS.this_nMatprncdif) + "," + ;
                 " ResumoPOp = " + FormatarNumeroSQL(THIS.this_nResumopop) + "," + ;
                 " QtdNegs = " + FormatarNumeroSQL(THIS.this_nQtdnegs) + "," + ;
                 " seppedras = " + FormatarNumeroSQL(THIS.this_nSeppedras) + "," + ;
                 " trfpesas = " + FormatarNumeroSQL(THIS.this_nTrfpesas) + "," + ;
                 " Pqs = " + EscaparSQL(THIS.this_cPqs) + "," + ;
                 " PesoBals = " + FormatarNumeroSQL(THIS.this_nPesobals) + "," + ;
                 " EnvObrigs = " + FormatarNumeroSQL(THIS.this_nEnvobrigs) + "," + ;
                 " mensagens = " + FormatarNumeroSQL(THIS.this_nMensagens) + "," + ;
                 " pagservs = " + FormatarNumeroSQL(THIS.this_nPagservs) + "," + ;
                 " grprods = " + FormatarNumeroSQL(THIS.this_nGrprods) + "," + ;
                 " compagrus = " + FormatarNumeroSQL(THIS.this_nCompagrus) + "," + ;
                 " pesofixs = " + FormatarNumeroSQL(THIS.this_nPesofixs) + "," + ;
                 " CHKQTDPS = " + FormatarNumeroSQL(THIS.this_nChkqtdps) + "," + ;
                 " TpPadraos = " + EscaparSQL(THIS.this_cTppadraos) + "," + ;
                 " retalhos = " + EscaparSQL(THIS.this_cRetalhos) + "," + ;
                 " ValObrigs = " + FormatarNumeroSQL(THIS.this_nValobrigs) + "," + ;
                 " BxPedFins = " + FormatarNumeroSQL(THIS.this_nBxpedfins) + "," + ;
                 " PccFases = " + EscaparSQL(THIS.this_cPccfases) + "," + ;
                 " LimQtds = " + FormatarNumeroSQL(THIS.this_nLimqtds) + "," + ;
                 " diflancs = " + FormatarNumeroSQL(THIS.this_nDiflancs) + "," + ;
                 " difpesags = " + FormatarNumeroSQL(THIS.this_nDifpesags) + "," + ;
                 " Sinals = " + FormatarNumeroSQL(THIS.this_nSinals) + "," + ;
                 " Librpqs = " + FormatarNumeroSQL(THIS.this_nLibrpqs) + "," + ;
                 " agseps = " + FormatarNumeroSQL(THIS.this_nAgseps) + "," + ;
                 " quebras = " + FormatarNumeroSQL(THIS.this_nQuebras) + "," + ;
                 " CravCers = " + FormatarNumeroSQL(THIS.this_nCravcers) + "," + ;
                 " SolCdlbs = " + FormatarNumeroSQL(THIS.this_nSolcdlbs) + "," + ;
                 " nCarQtds = " + FormatarNumeroSQL(THIS.this_nNcarqtds) + "," + ;
                 " MatPads = " + EscaparSQL(THIS.this_cMatpads) + "," + ;
                 " chkPesos = " + FormatarNumeroSQL(THIS.this_nChkpesos) + "," + ;
                 " ChkMtPrs = " + FormatarNumeroSQL(THIS.this_nChkmtprs) + "," + ;
                 " chkMetal = " + FormatarNumeroSQL(THIS.this_nChkmetal) + "," + ;
                 " dckcabec = " + FormatarNumeroSQL(THIS.this_nDckcabec) + "," + ;
                 " dckItens = " + FormatarNumeroSQL(THIS.this_nDckitens) + "," + ;
                 " dckResu = " + FormatarNumeroSQL(THIS.this_nDckresu) + "," + ;
                 " CasQtds = " + FormatarNumeroSQL(THIS.this_nCasqtds) + "," + ;
                 " obspads = " + FormatarNumeroSQL(THIS.this_nObspads) + "," + ;
                 " obsinis = " + FormatarNumeroSQL(THIS.this_nObsinis) + "," + ;
                 " obsfins = " + FormatarNumeroSQL(THIS.this_nObsfins) + "," + ;
                 " CtrLotes = " + FormatarNumeroSQL(THIS.this_nCtrlotes) + "," + ;
                 " AcEnvs = " + FormatarNumeroSQL(THIS.this_nAcenvs) + "," + ;
                 " envelopes = " + FormatarNumeroSQL(THIS.this_nEnvelopes) + "," + ;
                 " chkunis = " + FormatarNumeroSQL(THIS.this_nChkunis) + "," + ;
                 " grufins = " + EscaparSQL(THIS.this_cGrufins) + "," + ;
                 " chkPesoTot = " + FormatarNumeroSQL(THIS.this_nChkpesotot) + "," + ;
                 " dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                 " pccs = " + FormatarNumeroSQL(THIS.this_nPccs) + "," + ;
                 " pesmatps = " + FormatarNumeroSQL(THIS.this_nPesmatps) + "," + ;
                 " InibAlts = " + FormatarNumeroSQL(THIS.this_nInibAlts) + "," + ;
                 " ChkCtDes = " + FormatarNumeroSQL(THIS.this_nChkctdes) + "," + ;
                 " CodTgOps = " + EscaparSQL(THIS.this_cCodtgops) + "," + ;
                 " gruccus = " + EscaparSQL(THIS.this_cGruccus) + "," + ;
                 " contaccus = " + EscaparSQL(THIS.this_cContaccus) + "," + ;
                 " chkoplts = " + FormatarNumeroSQL(THIS.this_nChkoplts) + "," + ;
                 " dopsemis = " + EscaparSQL(THIS.this_cDopsemis) + "," + ;
                 " chksenexc = " + FormatarNumeroSQL(THIS.this_nChksenexc) + "," + ;
                 " tpsenexc = " + FormatarNumeroSQL(THIS.this_nTpsenexc) + ;
                 " WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("UPDATE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

  *--------------------------------------------------------------------------
  PROTECTED PROCEDURE ExecutarExclusao()
    LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
    loc_lSucesso = .F.
    TRY
      loc_cSQL = "DELETE FROM SigCdOpd WHERE Dopps = " + EscaparSQL(THIS.this_cDopps)
      loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
      IF loc_nResultado >= 0
        THIS.RegistrarAuditoria("DELETE")
        loc_lSucesso = .T.
      ELSE
        MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
      ENDIF
    CATCH TO loc_oErro
      MsgErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, "Erro")
    ENDTRY
    RETURN loc_lSucesso
  ENDPROC

ENDDEFINE

