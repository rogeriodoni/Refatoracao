# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMDETQ.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (921 linhas total):

*-- Linhas 25 a 126:
25:     this_oBusinessObject = .NULL.
26: 
27:     *==========================================================================
28:     PROCEDURE Init()
29:     *==========================================================================
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *==========================================================================
34:     * InicializarForm - Chamado por FormBase.Init via DODEFAULT
35:     *==========================================================================
36:     PROTECTED PROCEDURE InicializarForm()
37:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
38:         loc_lSucesso   = .F.
39:         loc_lContinuar = .T.
40: 
41:         TRY
42:             THIS.this_oBusinessObject = CREATEOBJECT("SIGMDETQBO")
43: 
44:             THIS.Picture = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
45: 
46:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
47:                 loc_lContinuar = .T.
48:             ELSE
49:                 IF gnConnHandle <= 0
50:                 MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + "o " + ;
51:                         "Com o Servidor de Banco de Dados...", "Conex" + CHR(227) + "o")
52:                 loc_lContinuar = .F.
53:                 ENDIF
54:             ENDIF
55: 
56:             *-- DopCorTam obrigatorio para abertura do form (igual ao legado)
57:             IF loc_lContinuar
58:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
59:                     IF !THIS.this_oBusinessObject.CarregarParametros()
60:                         loc_lContinuar = .F.
61:                     ENDIF
62:                 ENDIF
63:             ENDIF
64: 
65:             IF loc_lContinuar
66:                 THIS.ConfigurarPageFrame()
67:                 THIS.ConfigurarPaginaLista()
68:                 THIS.TornarControlesVisiveis()
69:                 THIS.ConfigurarBINDEVENTs()
70:                 loc_lSucesso = .T.
71:             ENDIF
72: 
73:         CATCH TO loc_oErro
74:             MsgErro(loc_oErro.Message, "Erro InicializarForm")
75:         ENDTRY
76: 
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
82:     * cntSombra (cabecalho cinza) com labels de titulo.
83:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
84:     * estrutura fixa do topo (equivalente ao "frame" da tela).
85:     *==========================================================================
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         THIS.AddObject("cnt_4c_Sombra", "Container")
88:         WITH THIS.cnt_4c_Sombra
89:             .Top         = 0
90:             .Left        = 0
91:             .Width       = 800
92:             .Height      = 80
93:             .BackColor   = RGB(100, 100, 100)
94:             .BorderWidth = 0
95:             .Visible     = .T.
96: 
97:             .AddObject("lbl_4c_LblSombra", "Label")
98:             WITH .lbl_4c_LblSombra
99:                 .Top           = 18
100:                 .Left          = 10
101:                 .Width         = 769
102:                 .Height        = 40
103:                 .FontBold      = .T.
104:                 .FontName      = "Tahoma"
105:                 .FontSize      = 18
106:                 .FontUnderline = .F.
107:                 .BackStyle     = 0
108:                 .WordWrap      = .T.
109:                 .Alignment     = 0
110:                 .ForeColor     = RGB(0, 0, 0)
111:                 .Caption       = "Muda Cor / Tamanho Etiqueta"
112:                 .Visible       = .T.
113:             ENDWITH
114: 
115:             .AddObject("lbl_4c_LblTitulo", "Label")
116:             WITH .lbl_4c_LblTitulo
117:                 .Top       = 17
118:                 .Left      = 10
119:                 .Width     = 769
120:                 .Height    = 46
121:                 .FontBold  = .T.
122:                 .FontName  = "Tahoma"
123:                 .FontSize  = 18
124:                 .BackStyle = 0
125:                 .WordWrap  = .T.
126:                 .Alignment = 0

*-- Linhas 137 a 359:
137:     * configuracao da "pagina unica" (equivalente logico da Page1 Lista)
138:     * para manter compatibilidade com o pipeline multi-fase.
139:     *==========================================================================
140:     PROTECTED PROCEDURE ConfigurarPaginaLista()
141:         THIS.ConfigurarBotoes()
142:         THIS.ConfigurarPaginaDados()
143:     ENDPROC
144: 
145:     *==========================================================================
146:     * AlternarPagina - Reinicia o fluxo do form limpando campos de entrada,
147:     * resetando o BO e posicionando o foco no campo inicial (Codigo de Barras).
148:     * Forms OPERACIONAIS nao possuem PageFrame; "alternar para pagina 1" equivale
149:     * a preparar o form para uma nova operacao do zero.
150:     *==========================================================================
151:     PROCEDURE AlternarPagina(par_nPagina)
152:         LOCAL loc_oErro
153: 
154:         TRY
155:             IF PEMSTATUS(THIS, "txt_4c_Barras", 5)
156:                 THIS.txt_4c_Barras.Value = ""
157:                 THIS.txt_4c_CorAnt.Value = ""
158:                 THIS.txt_4c_TamAnt.Value = ""
159:                 THIS.txt_4c_CorNew.Value = ""
160:                 THIS.txt_4c_TamNew.Value = ""
161: 
162:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
163:                     THIS.this_oBusinessObject.this_nCodBarras = 0
164:                     THIS.this_oBusinessObject.this_cCPros     = ""
165:                     THIS.this_oBusinessObject.this_cCorAnt    = ""
166:                     THIS.this_oBusinessObject.this_cTamAnt    = ""
167:                     THIS.this_oBusinessObject.this_cCorNew    = ""
168:                     THIS.this_oBusinessObject.this_cTamNew    = ""
169:                 ENDIF
170: 
171:                 THIS.txt_4c_Barras.SetFocus()
172:             ENDIF
173:         CATCH TO loc_oErro
174:             MsgErro(loc_oErro.Message, "Erro AlternarPagina")
175:         ENDTRY
176:     ENDPROC
177: 
178:     *==========================================================================
179:     * ConfigurarBotoes - Botoes Processar e Cancelar
180:     * Posicoes absolutas derivadas do CommandGroup original (Left=562, Top=-2):
181:     *   Processar (Command2): Left=562+5=567, Top=-2+5=3
182:     *   Cancelar  (Command1): Left=562+80=642, Top=-2+5=3
183:     *==========================================================================
184:     PROTECTED PROCEDURE ConfigurarBotoes()
185:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
186:         WITH THIS.cmd_4c_Processar
187:             .Top             = 3
188:             .Left            = 567
189:             .Height          = 75
190:             .Width           = 75
191:             .Caption         = "\<Processar"
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .FontName        = "Comic Sans MS"
195:             .FontSize        = 8
196:             .WordWrap        = .T.
197:             .ForeColor       = RGB(90, 90, 90)
198:             .BackColor       = RGB(255, 255, 255)
199:             .SpecialEffect   = 0
200:             .Themes          = .F.
201:             .MousePointer    = 15
202:             .PicturePosition = 13
203:             .Picture         = gc_4c_CaminhoBase + "Framework\imagens\geral_configuracao_60.jpg"
204:             .ToolTipText     = "Confirmar a Sele" + CHR(231) + CHR(227) + "o"
205:         ENDWITH
206: 
207:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
208:         WITH THIS.cmd_4c_Cancelar
209:             .Top             = 3
210:             .Left            = 642
211:             .Height          = 75
212:             .Width           = 75
213:             .Caption         = "\<Cancelar"
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .FontName        = "Comic Sans MS"
217:             .FontSize        = 8
218:             .WordWrap        = .T.
219:             .ForeColor       = RGB(90, 90, 90)
220:             .BackColor       = RGB(255, 255, 255)
221:             .SpecialEffect   = 0
222:             .Themes          = .F.
223:             .MousePointer    = 15
224:             .Cancel          = .T.
225:             .PicturePosition = 13
226:             .Picture         = gc_4c_CaminhoBase + "Framework\imagens\cadastro_sair_60.jpg"
227:             .ToolTipText     = "[Esc] Encerrar"
228:         ENDWITH
229:     ENDPROC
230: 
231:     *==========================================================================
232:     * TornarControlesVisiveis - Torna visiveis os controles de nivel raiz do form
233:     * cnt_4c_Sombra ja tem Visible=.T. definido em ConfigurarCabecalho
234:     *==========================================================================
235:     PROTECTED PROCEDURE TornarControlesVisiveis()
236:         LOCAL loc_i, loc_oCtrl
237:         FOR loc_i = 1 TO THIS.ControlCount
238:             loc_oCtrl = THIS.Controls(loc_i)
239:             IF VARTYPE(loc_oCtrl) = "O"
240:                 loc_oCtrl.Visible = .T.
241:             ENDIF
242:         NEXT
243:     ENDPROC
244: 
245:     *==========================================================================
246:     * ConfigurarBINDEVENTs - Vincula eventos dos botoes principais
247:     * Eventos dos campos de entrada sao vinculados em fases posteriores
248:     *==========================================================================
249:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
250:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
251:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
252:         BINDEVENT(THIS.txt_4c_Barras, "KeyPress",          THIS, "TxtBarrasKeyPress")
253:         BINDEVENT(THIS.txt_4c_Barras, "InteractiveChange", THIS, "TxtBarrasInteractiveChange")
254:         BINDEVENT(THIS.txt_4c_CorNew, "KeyPress",          THIS, "TxtCorNewKeyPress")
255:         BINDEVENT(THIS.txt_4c_TamNew, "KeyPress",          THIS, "TxtTamNewKeyPress")
256:     ENDPROC
257: 
258:     *==========================================================================
259:     * BtnCancelarClick - Encerra o formulario
260:     *==========================================================================
261:     PROCEDURE BtnCancelarClick()
262:         THIS.Release()
263:     ENDPROC
264: 
265:     *==========================================================================
266:     * BtnProcessarClick - Valida campos e chama ProcessarAlteracao no BO
267:     * Depende de txt_4c_Barras, txt_4c_CorNew, txt_4c_TamNew (criados na Fase 4)
268:     *==========================================================================
269:     PROCEDURE BtnProcessarClick()
270:         LOCAL loc_nCodBarras, loc_lContinuar, loc_oErro
271:         loc_lContinuar = .T.
272: 
273:         TRY
274:             loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
275:                                  VAL(THIS.txt_4c_Barras.Value), ;
276:                                  THIS.txt_4c_Barras.Value)
277: 
278:             IF EMPTY(loc_nCodBarras)
279:                 MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
280:                          "Aten" + CHR(231) + CHR(227) + "o")
281:                 loc_lContinuar = .F.
282:             ENDIF
283: 
284:             *-- Garante barras validado no banco antes de processar
285:             IF loc_lContinuar AND THIS.this_oBusinessObject.this_nCodBarras != loc_nCodBarras
286:                 IF !THIS.ValidarBarras()
287:                     loc_lContinuar = .F.
288:                 ENDIF
289:             ENDIF
290: 
291:             IF loc_lContinuar
292:                 IF !MsgConfirma("Confirma a altera" + CHR(231) + CHR(227) + "o dos Dados do Barra?", ;
293:                                 "Aten" + CHR(231) + CHR(227) + "o")
294:                     loc_lContinuar = .F.
295:                 ENDIF
296:             ENDIF
297: 
298:             IF loc_lContinuar
299:                 THIS.this_oBusinessObject.this_cCorNew = ALLTRIM(THIS.txt_4c_CorNew.Value)
300:                 THIS.this_oBusinessObject.this_cTamNew = ALLTRIM(THIS.txt_4c_TamNew.Value)
301: 
302:                 IF THIS.this_oBusinessObject.ProcessarAlteracao()
303:                     MsgInfo("Grava" + CHR(231) + CHR(227) + "o Realizada.", "Aviso")
304:                     THIS.AlternarPagina(1)
305:                 ENDIF
306:             ENDIF
307: 
308:         CATCH TO loc_oErro
309:             MsgErro(loc_oErro.Message, "Erro BtnProcessarClick")
310:         ENDTRY
311:     ENDPROC
312: 
313:     *==========================================================================
314:     * ConfigurarPaginaDados - Cria shapes, labels e textboxes do formulario.
315:     * Forms OPERACIONAIS nao tem PageFrame CRUD; este metodo contem a
316:     * configuracao de campos de dados (equivalente logico da Page2 Dados)
317:     * para manter compatibilidade com o pipeline multi-fase.
318:     *==========================================================================
319:     PROTECTED PROCEDURE ConfigurarPaginaDados()
320:         *-- Shape1: caixa ao redor do campo Codigo de Barra
321:         THIS.AddObject("shp_4c_Shape1", "Shape")
322:         WITH THIS.shp_4c_Shape1
323:             .Top       = 85
324:             .Left      = 28
325:             .Width     = 232
326:             .Height    = 31
327:             .BackStyle = 0
328:             .FillStyle = 1
329:         ENDWITH
330: 
331:         *-- Shape2: caixa externa Antigo+Novo
332:         THIS.AddObject("shp_4c_Shape2", "Shape")
333:         WITH THIS.shp_4c_Shape2
334:             .Top       = 118
335:             .Left      = 28
336:             .Width     = 399
337:             .Height    = 80
338:             .BackStyle = 0
339:             .FillStyle = 1
340:         ENDWITH
341: 
342:         *-- Shape4: caixa Antigo (metade esquerda)
343:         THIS.AddObject("shp_4c_Shape4", "Shape")
344:         WITH THIS.shp_4c_Shape4
345:             .Top       = 118
346:             .Left      = 28
347:             .Width     = 197
348:             .Height    = 80
349:             .BackStyle = 0
350:             .FillStyle = 1
351:         ENDWITH
352: 
353:         *-- Shape3: linha de header Antigo/Novo
354:         THIS.AddObject("shp_4c_Shape3", "Shape")
355:         WITH THIS.shp_4c_Shape3
356:             .Top       = 118
357:             .Left      = 28
358:             .Width     = 399
359:             .Height    = 24

*-- Linhas 547 a 921:
547:     * ValidarBarras - Busca etiqueta no banco e preenche campos Antigo
548:     * Retorna .T. se barras encontrado e valido
549:     *==========================================================================
550:     PROTECTED PROCEDURE ValidarBarras()
551:         LOCAL loc_nCodBarras, loc_lSucesso, loc_oErro
552:         loc_lSucesso = .F.
553: 
554:         TRY
555:             loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
556:                                  VAL(THIS.txt_4c_Barras.Value), ;
557:                                  THIS.txt_4c_Barras.Value)
558: 
559:             IF !EMPTY(loc_nCodBarras)
560:                 IF THIS.this_oBusinessObject.BuscarPorBarras(loc_nCodBarras)
561:                     THIS.txt_4c_CorAnt.Value = THIS.this_oBusinessObject.this_cCorAnt
562:                     THIS.txt_4c_TamAnt.Value = THIS.this_oBusinessObject.this_cTamAnt
563:                     THIS.txt_4c_CorNew.Value = ""
564:                     THIS.txt_4c_TamNew.Value = ""
565:                     THIS.txt_4c_CorNew.SetFocus()
566:                     loc_lSucesso = .T.
567:                 ELSE
568:                     THIS.txt_4c_Barras.SetFocus()
569:                 ENDIF
570:             ENDIF
571: 
572:         CATCH TO loc_oErro
573:             MsgErro(loc_oErro.Message, "Erro ValidarBarras")
574:         ENDTRY
575: 
576:         RETURN loc_lSucesso
577:     ENDPROC
578: 
579:     *==========================================================================
580:     * TxtBarrasKeyPress - Dispara ValidarBarras em ENTER (13) e TAB (9)
581:     *==========================================================================
582:     PROCEDURE TxtBarrasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
583:         IF INLIST(par_nKeyCode, 13, 9)
584:             THIS.ValidarBarras()
585:         ENDIF
586:     ENDPROC
587: 
588:     *==========================================================================
589:     * TxtBarrasInteractiveChange - Limpa campos derivados ao editar barras
590:     *==========================================================================
591:     PROCEDURE TxtBarrasInteractiveChange()
592:         THIS.txt_4c_CorAnt.Value = ""
593:         THIS.txt_4c_TamAnt.Value = ""
594:         THIS.txt_4c_CorNew.Value = ""
595:         THIS.txt_4c_TamNew.Value = ""
596:         THIS.this_oBusinessObject.this_nCodBarras = 0
597:     ENDPROC
598: 
599:     *==========================================================================
600:     * AbrirBuscaCor - Lookup de Cores (SigCdCor) via FormBuscaAuxiliar
601:     *==========================================================================
602:     PROTECTED PROCEDURE AbrirBuscaCor()
603:         LOCAL loc_cValor, loc_oBusca, loc_oErro
604: 
605:         TRY
606:             loc_cValor = ALLTRIM(THIS.txt_4c_CorNew.Value)
607: 
608:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
609:                 "SigCdCor", "cursor_4c_BuscaCor", "cods", loc_cValor, ;
610:                 "Sele" + CHR(231) + CHR(227) + "o de Cores")
611: 
612:             IF VARTYPE(loc_oBusca) = "O"
613:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
614:                     IF USED("cursor_4c_BuscaCor") AND RECCOUNT("cursor_4c_BuscaCor") > 0
615:                         SELECT cursor_4c_BuscaCor
616:                         THIS.txt_4c_CorNew.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
617:                     ENDIF
618:                 ELSE
619:                     IF !loc_oBusca.this_lAchouRegistro
620:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
621:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
622:                     loc_oBusca.Show()
623:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCor") AND RECCOUNT("cursor_4c_BuscaCor") > 0
624:                         SELECT cursor_4c_BuscaCor
625:                         THIS.txt_4c_CorNew.Value = ALLTRIM(cursor_4c_BuscaCor.cods)
626:                     ELSE
627:                         THIS.txt_4c_CorNew.Value = ""
628:                     ENDIF
629:                     ENDIF
630:                 ENDIF
631:                 IF USED("cursor_4c_BuscaCor")
632:                     USE IN cursor_4c_BuscaCor
633:                 ENDIF
634:                 loc_oBusca.Release()
635:             ENDIF
636: 
637:         CATCH TO loc_oErro
638:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaCor")
639:             IF USED("cursor_4c_BuscaCor")
640:                 USE IN cursor_4c_BuscaCor
641:             ENDIF
642:         ENDTRY
643:     ENDPROC
644: 
645:     *==========================================================================
646:     * TxtCorNewKeyPress - Dispara lookup de Cor em F4 (115), ENTER (13), TAB (9)
647:     *==========================================================================
648:     PROCEDURE TxtCorNewKeyPress(par_nKeyCode, par_nShiftAltCtrl)
649:         IF INLIST(par_nKeyCode, 115, 13, 9)
650:             THIS.AbrirBuscaCor()
651:         ENDIF
652:     ENDPROC
653: 
654:     *==========================================================================
655:     * AbrirBuscaTam - Lookup de Tamanhos (SigCdTam) via FormBuscaAuxiliar
656:     *==========================================================================
657:     PROTECTED PROCEDURE AbrirBuscaTam()
658:         LOCAL loc_cValor, loc_oBusca, loc_oErro
659: 
660:         TRY
661:             loc_cValor = ALLTRIM(THIS.txt_4c_TamNew.Value)
662: 
663:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
664:                 "SigCdTam", "cursor_4c_BuscaTam", "cods", loc_cValor, ;
665:                 "Sele" + CHR(231) + CHR(227) + "o de Tamanhos")
666: 
667:             IF VARTYPE(loc_oBusca) = "O"
668:                 IF loc_oBusca.this_lSelecionou AND loc_oBusca.this_lAchouRegistro
669:                     IF USED("cursor_4c_BuscaTam") AND RECCOUNT("cursor_4c_BuscaTam") > 0
670:                         SELECT cursor_4c_BuscaTam
671:                         THIS.txt_4c_TamNew.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
672:                     ENDIF
673:                 ELSE
674:                     IF !loc_oBusca.this_lAchouRegistro
675:                     loc_oBusca.mAddColuna("cods",  "", "C" + CHR(243) + "digo")
676:                     loc_oBusca.mAddColuna("descs", "", "Descri" + CHR(231) + CHR(227) + "o")
677:                     loc_oBusca.Show()
678:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTam") AND RECCOUNT("cursor_4c_BuscaTam") > 0
679:                         SELECT cursor_4c_BuscaTam
680:                         THIS.txt_4c_TamNew.Value = ALLTRIM(cursor_4c_BuscaTam.cods)
681:                     ELSE
682:                         THIS.txt_4c_TamNew.Value = ""
683:                     ENDIF
684:                     ENDIF
685:                 ENDIF
686:                 IF USED("cursor_4c_BuscaTam")
687:                     USE IN cursor_4c_BuscaTam
688:                 ENDIF
689:                 loc_oBusca.Release()
690:             ENDIF
691: 
692:         CATCH TO loc_oErro
693:             MsgErro(loc_oErro.Message, "Erro AbrirBuscaTam")
694:             IF USED("cursor_4c_BuscaTam")
695:                 USE IN cursor_4c_BuscaTam
696:             ENDIF
697:         ENDTRY
698:     ENDPROC
699: 
700:     *==========================================================================
701:     * TxtTamNewKeyPress - Dispara lookup de Tamanho em F4 (115), ENTER (13), TAB (9)
702:     *==========================================================================
703:     PROCEDURE TxtTamNewKeyPress(par_nKeyCode, par_nShiftAltCtrl)
704:         IF INLIST(par_nKeyCode, 115, 13, 9)
705:             THIS.AbrirBuscaTam()
706:         ENDIF
707:     ENDPROC
708: 
709:     *==========================================================================
710:     * BtnIncluirClick - Inicia nova opera" + CHR(231) + CHR(227) + "o de altera" + CHR(231) + CHR(227) + "o
711:     * Form OPERACIONAL: "Incluir" equivale a resetar o form para nova entrada
712:     * de c" + CHR(243) + "digo de barras (equivalente a AlternarPagina no pipeline CRUD)
713:     *==========================================================================
714:     PROCEDURE BtnIncluirClick()
715:         LOCAL loc_oErro
716: 
717:         TRY
718:             THIS.AlternarPagina(1)
719:         CATCH TO loc_oErro
720:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
721:         ENDTRY
722:     ENDPROC
723: 
724:     *==========================================================================
725:     * BtnAlterarClick - Executa a altera" + CHR(231) + CHR(227) + "o de Cor/Tamanho da etiqueta
726:     * Form OPERACIONAL: "Alterar" e' a opera" + CHR(231) + CHR(227) + "o principal (Processar)
727:     * Delega para BtnProcessarClick que valida campos e grava via BO
728:     *==========================================================================
729:     PROCEDURE BtnAlterarClick()
730:         LOCAL loc_oErro
731: 
732:         TRY
733:             THIS.BtnProcessarClick()
734:         CATCH TO loc_oErro
735:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
736:         ENDTRY
737:     ENDPROC
738: 
739:     *==========================================================================
740:     * BtnVisualizarClick - Consulta dados da etiqueta pelo c" + CHR(243) + "digo de barras
741:     * Form OPERACIONAL: "Visualizar" = buscar barcode e exibir Cor/Tam antigos
742:     * Delega para ValidarBarras que faz SELECT em SigOpEtq e preenche os campos
743:     *==========================================================================
744:     PROCEDURE BtnVisualizarClick()
745:         LOCAL loc_nCodBarras, loc_oErro
746: 
747:         TRY
748:             loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
749:                                  VAL(THIS.txt_4c_Barras.Value), ;
750:                                  THIS.txt_4c_Barras.Value)
751: 
752:             IF EMPTY(loc_nCodBarras)
753:                 MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
754:                          "Aten" + CHR(231) + CHR(227) + "o")
755:             ELSE
756:                 THIS.ValidarBarras()
757:             ENDIF
758:         CATCH TO loc_oErro
759:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
760:         ENDTRY
761:     ENDPROC
762: 
763:     *==========================================================================
764:     * BtnExcluirClick - Encerra a opera" + CHR(231) + CHR(227) + "o e fecha o formul" + CHR(225) + "rio
765:     * Form OPERACIONAL: o legado SIGMDETQ n" + CHR(227) + "o possui opera" + CHR(231) + CHR(227) + "o de exclus" + CHR(227) + "o
766:     * (s" + CHR(243) + " alteracao via Processar). Aqui equivale ao bot" + CHR(227) + "o Cancelar do original.
767:     *==========================================================================
768:     PROCEDURE BtnExcluirClick()
769:         LOCAL loc_oErro
770: 
771:         TRY
772:             THIS.BtnCancelarClick()
773:         CATCH TO loc_oErro
774:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
775:         ENDTRY
776:     ENDPROC
777: 
778:     *==========================================================================
779:     * FormParaBO - Transfere valores editaveis do form para o BO
780:     *==========================================================================
781:     PROCEDURE FormParaBO()
782:         LOCAL loc_oErro
783:         TRY
784:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
785:                 THIS.this_oBusinessObject.this_cCorNew = ALLTRIM(THIS.txt_4c_CorNew.Value)
786:                 THIS.this_oBusinessObject.this_cTamNew = ALLTRIM(THIS.txt_4c_TamNew.Value)
787:             ENDIF
788:         CATCH TO loc_oErro
789:             MsgErro(loc_oErro.Message, "Erro FormParaBO")
790:         ENDTRY
791:     ENDPROC
792: 
793:     *==========================================================================
794:     * BOParaForm - Transfere valores do BO para os campos do form
795:     *==========================================================================
796:     PROCEDURE BOParaForm()
797:         LOCAL loc_oErro
798:         TRY
799:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
800:                 THIS.txt_4c_CorAnt.Value = THIS.this_oBusinessObject.this_cCorAnt
801:                 THIS.txt_4c_TamAnt.Value = THIS.this_oBusinessObject.this_cTamAnt
802:                 THIS.txt_4c_CorNew.Value = THIS.this_oBusinessObject.this_cCorNew
803:                 THIS.txt_4c_TamNew.Value = THIS.this_oBusinessObject.this_cTamNew
804:             ENDIF
805:         CATCH TO loc_oErro
806:             MsgErro(loc_oErro.Message, "Erro BOParaForm")
807:         ENDTRY
808:     ENDPROC
809: 
810:     *==========================================================================
811:     * HabilitarCampos - Habilita ou desabilita campos editaveis do form
812:     * txt_4c_CorAnt e txt_4c_TamAnt sao sempre somente leitura (ReadOnly=.T.)
813:     *==========================================================================
814:     PROCEDURE HabilitarCampos(par_lHabilitar)
815:         LOCAL loc_oErro
816:         TRY
817:             THIS.txt_4c_Barras.Enabled    = par_lHabilitar
818:             THIS.txt_4c_CorNew.Enabled    = par_lHabilitar
819:             THIS.txt_4c_TamNew.Enabled    = par_lHabilitar
820:             THIS.cmd_4c_Processar.Enabled = par_lHabilitar
821:         CATCH TO loc_oErro
822:             MsgErro(loc_oErro.Message, "Erro HabilitarCampos")
823:         ENDTRY
824:     ENDPROC
825: 
826:     *==========================================================================
827:     * LimparCampos - Limpa todos os campos e reseta propriedades do BO
828:     *==========================================================================
829:     PROCEDURE LimparCampos()
830:         LOCAL loc_oErro
831:         TRY
832:             THIS.txt_4c_Barras.Value = ""
833:             THIS.txt_4c_CorAnt.Value = ""
834:             THIS.txt_4c_TamAnt.Value = ""
835:             THIS.txt_4c_CorNew.Value = ""
836:             THIS.txt_4c_TamNew.Value = ""
837:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
838:                 THIS.this_oBusinessObject.this_nCodBarras = 0
839:                 THIS.this_oBusinessObject.this_cCPros     = ""
840:                 THIS.this_oBusinessObject.this_cCorAnt    = ""
841:                 THIS.this_oBusinessObject.this_cTamAnt    = ""
842:                 THIS.this_oBusinessObject.this_cCorNew    = ""
843:                 THIS.this_oBusinessObject.this_cTamNew    = ""
844:             ENDIF
845:         CATCH TO loc_oErro
846:             MsgErro(loc_oErro.Message, "Erro LimparCampos")
847:         ENDTRY
848:     ENDPROC
849: 
850:     *==========================================================================
851:     * CarregarLista - Form OPERACIONAL: sem lista paginada CRUD.
852:     * Presente por compatibilidade com o pipeline multi-fase.
853:     *==========================================================================
854:     PROCEDURE CarregarLista()
855:         RETURN .T.
856:     ENDPROC
857: 
858:     *==========================================================================
859:     * AjustarBotoesPorModo - Form OPERACIONAL: botoes Processar/Cancelar
860:     * permanecem habilitados. Presente por compatibilidade com o pipeline.
861:     *==========================================================================
862:     PROCEDURE AjustarBotoesPorModo()
863:         LOCAL loc_oErro
864:         TRY
865:             IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
866:                 THIS.cmd_4c_Processar.Enabled = .T.
867:             ENDIF
868:             IF PEMSTATUS(THIS, "cmd_4c_Cancelar", 5)
869:                 THIS.cmd_4c_Cancelar.Enabled = .T.
870:             ENDIF
871:         CATCH TO loc_oErro
872:             MsgErro(loc_oErro.Message, "Erro AjustarBotoesPorModo")
873:         ENDTRY
874:     ENDPROC
875: 
876:     *==========================================================================
877:     * BtnBuscarClick - Valida etiqueta pelo codigo de barras digitado
878:     * Equivalente semantico de "Buscar/Consultar" em forms CRUD
879:     *==========================================================================
880:     PROCEDURE BtnBuscarClick()
881:         LOCAL loc_nCodBarras, loc_oErro
882:         TRY
883:             loc_nCodBarras = IIF(VARTYPE(THIS.txt_4c_Barras.Value) = "C", ;
884:                                  VAL(THIS.txt_4c_Barras.Value), ;
885:                                  THIS.txt_4c_Barras.Value)
886:             IF EMPTY(loc_nCodBarras)
887:                 MsgAviso("Favor Informar o C" + CHR(243) + "digo de Barras.", ;
888:                          "Aten" + CHR(231) + CHR(227) + "o")
889:             ELSE
890:                 THIS.ValidarBarras()
891:             ENDIF
892:         CATCH TO loc_oErro
893:             MsgErro(loc_oErro.Message, "Erro BtnBuscarClick")
894:         ENDTRY
895:     ENDPROC
896: 
897:     *==========================================================================
898:     * BtnEncerrarClick - Encerra o formulario
899:     *==========================================================================
900:     PROCEDURE BtnEncerrarClick()
901:         THIS.BtnCancelarClick()
902:     ENDPROC
903: 
904:     *==========================================================================
905:     * BtnSalvarClick - Processa a alteracao de Cor/Tamanho
906:     * Alias para BtnProcessarClick (compatibilidade com pipeline multi-fase)
907:     *==========================================================================
908:     PROCEDURE BtnSalvarClick()
909:         THIS.BtnProcessarClick()
910:     ENDPROC
911: 
912:     *==========================================================================
913:     PROCEDURE Destroy()
914:     *==========================================================================
915:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
916:             THIS.this_oBusinessObject = .NULL.
917:         ENDIF
918:         DODEFAULT()
919:     ENDPROC
920: 
921: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGMDETQBO.prg):
*------------------------------------------------------------------------------
* SIGMDETQBO.prg - Business Object: Mudanca de Cor/Tamanho de Etiqueta
* Herda de BusinessBase
* Tabela principal: SigOpEtq (etiquetas de operacao)
*------------------------------------------------------------------------------
DEFINE CLASS SIGMDETQBO AS BusinessBase

    *-- Codigo de barras da etiqueta (numerico)
    this_nCodBarras  = 0

    *-- Codigo do produto (de CrSigOpEtq.CPros / CrSigMvHst.CPros)
    this_cCPros      = ""

    *-- Codigo da empresa (de CrSigMvHst.Emps)
    this_cEmps       = ""

    *-- Cor e Tamanho ANTIGOS (lidos de CrSigOpEtq.CodCors / .CodTams)
    this_cCorAnt     = ""
    this_cTamAnt     = ""

    *-- Cor e Tamanho NOVOS (informados pelo usuario, lookup SigCdCor / SigCdTam)
    this_cCorNew     = ""
    this_cTamNew     = ""

    *-- Chave de sessao do sistema (de crSigCdPac.SigKeys)
    this_cSigKey     = ""

    *-- Codigo da operacao padrao para mudanca cor/tamanho (de crSigCdPac.DopCorTam)
    this_cDopCorTam  = ""

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = "SigOpEtq"
        this_cCampoChave = "CBars"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdPac: SigKeys e DopCorTam
    * Deve ser chamado no InicializarForm do Form antes de qualquer operacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT TOP 1 SigKeys, DopCorTam FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") >= 1
                IF RECCOUNT("cursor_4c_Pac") > 0
                    SELECT cursor_4c_Pac
                    THIS.this_cSigKey    = ALLTRIM(cursor_4c_Pac.SigKeys)
                    THIS.this_cDopCorTam = ALLTRIM(cursor_4c_Pac.DopCorTam)
                    IF EMPTY(THIS.this_cDopCorTam)
                        MsgAviso("Opera" + CHR(231) + CHR(227) + "o Padr" + CHR(227) + "o para Mudan" + CHR(231) + "a de Cor/Tamanho n" + CHR(227) + "o definida nos Par" + CHR(226) + "metros do Sistema.", "Aten" + CHR(231) + CHR(227) + "o")
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ELSE
                    MsgErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o encontrados em SigCdPac.", "Erro")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema (SigCdPac).", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro CarregarParametros")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarPorBarras - Valida e carrega dados da etiqueta pelo codigo de barras
    * Popula: this_nCodBarras, this_cCPros, this_cEmps, this_cCorAnt, this_cTamAnt
    * Retorna .T. se encontrado e valido
    *--------------------------------------------------------------------------
    PROCEDURE BuscarPorBarras(par_nCodBarras)
        LOCAL loc_lSucesso, loc_lContinuar, loc_nCodBars, loc_cSQL, loc_oErro

        loc_lSucesso   = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBars = IIF(VARTYPE(par_nCodBarras) = "C", VAL(par_nCodBarras), par_nCodBarras)

            IF EMPTY(loc_nCodBars)
                loc_lContinuar = .F.
            ENDIF

            *-- Passo 1: Localiza em SigOpEtq + SigOpEta (trata barcode antigo)
            IF loc_lContinuar
                loc_cSQL = "SELECT a.CPros, a.CBars, b.cbars_old " + ;
                           "FROM SigOpEtq a " + ;
                           "LEFT JOIN sigopeta b ON a.cpros = b.cpros AND a.cbars = b.cbars_new " + ;
                           "WHERE (a.CBars = " + TRANSFORM(loc_nCodBars) + ;
                           " OR b.cbars_old = " + TRANSFORM(loc_nCodBars) + ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Etiqs") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrEtiqs)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_Etiqs
                GO TOP
                IF RECCOUNT("cursor_4c_Etiqs") > 0
                    loc_nCodBars = cursor_4c_Etiqs.CBars
                ENDIF
                IF USED("cursor_4c_Etiqs")
                    USE IN cursor_4c_Etiqs
                ENDIF
            ENDIF

            *-- Passo 2: Carrega dados completos da etiqueta
            IF loc_lContinuar
                loc_cSQL = "SELECT * FROM SigOpEtq WHERE CBars = " + TRANSFORM(loc_nCodBars)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigOpEtq") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (CrSigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                IF RECCOUNT("cursor_4c_SigOpEtq") = 0
                    MsgAviso("Barra N" + CHR(227) + "o Localizado!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                IF EMPTY(cursor_4c_SigOpEtq.Contas) OR EMPTY(cursor_4c_SigOpEtq.Grupos)
                    MsgAviso("Barra j" + CHR(225) + " Vendido!", "Aviso")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 3: Valida conta transitoria no historico
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Estos FROM SigMvHst WHERE codbarras = " + ;
                           TRANSFORM(loc_nCodBars) + " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstVal") >= 1
                    IF RECCOUNT("cursor_4c_MvHstVal") > 0
                        SELECT cursor_4c_MvHstVal
                        IF INLIST(ALLTRIM(cursor_4c_MvHstVal.Estos), "15000100", "15000150", "15000113")
                            MsgAviso("O Barra Informado Est" + CHR(225) + " Em Uma Conta Transit" + CHR(243) + "ria/" + ;
                                     "Transferencia e N" + CHR(227) + "o Pode Realizar a Altera" + CHR(231) + CHR(227) + "o " + ;
                                     "Dos Dados. Favor Verificar.", "Aten" + CHR(231) + CHR(227) + "o")
                            loc_lContinuar = .F.
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_MvHstVal")
                        USE IN cursor_4c_MvHstVal
                    ENDIF
                ENDIF
            ENDIF

            *-- Passo 4: Popula propriedades do BO
            IF loc_lContinuar
                SELECT cursor_4c_SigOpEtq
                THIS.this_nCodBarras = loc_nCodBars
                THIS.this_cCPros     = ALLTRIM(cursor_4c_SigOpEtq.CPros)
                THIS.this_cCorAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodCors)
                THIS.this_cTamAnt    = ALLTRIM(cursor_4c_SigOpEtq.CodTams)
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro BuscarPorBarras")
            IF USED("cursor_4c_Etiqs")
                USE IN cursor_4c_Etiqs
            ENDIF
            IF USED("cursor_4c_SigOpEtq")
                USE IN cursor_4c_SigOpEtq
            ENDIF
            IF USED("cursor_4c_MvHstVal")
                USE IN cursor_4c_MvHstVal
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia cursor SigOpEtq para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodBarras = TratarNulo(CBars,    "N")
            THIS.this_cCPros     = ALLTRIM(TratarNulo(CPros,   "C"))
            THIS.this_cCorAnt    = ALLTRIM(TratarNulo(CodCors, "C"))
            THIS.this_cTamAnt    = ALLTRIM(TratarNulo(CodTams, "C"))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna codigo de barras como string
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodBarras)
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarAlteracao - Processa mudanca de Cor/Tamanho da etiqueta
    * Pre-condicao: BuscarPorBarras() e CarregarParametros() ja executados
    *               this_cCorNew e this_cTamNew devem estar preenchidos
    * Fluxo: INSERT SigMvCab + INSERT SigMvHst(S) + INSERT SigMvHst(E) + UPDATE SigOpEtq
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarAlteracao()
        LOCAL loc_lSucesso, loc_lTransacao, loc_lContinuar
        LOCAL loc_nCodBarras, loc_cCorOld, loc_cTamOld, loc_cCorNew, loc_cTamNew
        LOCAL loc_cProd, loc_cEmps, loc_nTipoEstos
        LOCAL loc_cIds, loc_nPSeq, loc_nNume
        LOCAL loc_dtData, loc_dData, loc_cSQL, loc_cMsg, loc_oErro
        *-- Campos capturados do historico anterior
        LOCAL loc_cUnits, loc_cMoedas, loc_nTotas, loc_dDataTrans
        LOCAL loc_cEmpos, loc_nCodBarrasHist, loc_nQtds, loc_cGrupos
        LOCAL loc_cEstos, loc_nRecalMeds, loc_cObs, loc_nPesos
        LOCAL loc_cEmpGruEsts, loc_cOriDopNums, loc_nBcIpis, loc_dDtAudits

        loc_lSucesso   = .F.
        loc_lTransacao = .F.
        loc_lContinuar = .T.

        TRY
            loc_nCodBarras = THIS.this_nCodBarras
            loc_cCorOld    = ALLTRIM(THIS.this_cCorAnt)
            loc_cTamOld    = ALLTRIM(THIS.this_cTamAnt)
            loc_cCorNew    = ALLTRIM(THIS.this_cCorNew)
            loc_cTamNew    = ALLTRIM(THIS.this_cTamNew)
            loc_dtData     = DATETIME()
            loc_dData      = DATE()

            *-- Passo 1: Carrega historico mais recente para obter campos de cabecalho
            IF loc_lContinuar
                loc_cSQL = "SELECT TOP 1 Emps, CPros, Units, Moedas, Totas, DataTrans, Empos, " + ;
                           "CodBarras, Qtds, Grupos, Estos, RecalMeds, Obs, Pesos, " + ;
                           "DtAudits, EmpGruEsts, OriDopNums, BcIpis " + ;
                           "FROM SigMvHst WHERE codbarras = " + TRANSFORM(loc_nCodBarras) + ;
                           " ORDER BY Seqs DESC"
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MvHstProc") < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvHst)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar AND RECCOUNT("cursor_4c_MvHstProc") = 0
                MsgErro("Hist" + CHR(243) + "rico n" + CHR(227) + "o encontrado para o barras.", "Erro")
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT cursor_4c_MvHstProc
                loc_cEmps          = ALLTRIM(cursor_4c_MvHstProc.Emps)
                loc_cProd          = ALLTRIM(cursor_4c_MvHstProc.CPros)
                loc_cUnits         = ALLTRIM(cursor_4c_MvHstProc.Units)
                loc_cMoedas        = ALLTRIM(cursor_4c_MvHstProc.Moedas)
                loc_nTotas         = cursor_4c_MvHstProc.Totas
                loc_dDataTrans     = cursor_4c_MvHstProc.DataTrans
                loc_cEmpos         = ALLTRIM(cursor_4c_MvHstProc.Empos)
                loc_nCodBarrasHist = cursor_4c_MvHstProc.CodBarras
                loc_nQtds          = cursor_4c_MvHstProc.Qtds
                loc_cGrupos        = ALLTRIM(cursor_4c_MvHstProc.Grupos)
                loc_cEstos         = ALLTRIM(cursor_4c_MvHstProc.Estos)
                loc_nRecalMeds     = IIF(VARTYPE(cursor_4c_MvHstProc.RecalMeds) = "L", ;
                                         IIF(cursor_4c_MvHstProc.RecalMeds, 1, 0), ;
                                         cursor_4c_MvHstProc.RecalMeds)
                loc_cObs           = ALLTRIM(cursor_4c_MvHstProc.Obs)
                loc_nPesos         = cursor_4c_MvHstProc.Pesos
                loc_cEmpGruEsts    = ALLTRIM(cursor_4c_MvHstProc.EmpGruEsts)
                loc_cOriDopNums    = ALLTRIM(cursor_4c_MvHstProc.OriDopNums)
                loc_nBcIpis        = cursor_4c_MvHstProc.BcIpis
                loc_dDtAudits      = cursor_4c_MvHstProc.DtAudits
                IF USED("cursor_4c_MvHstProc")
                    USE IN cursor_4c_MvHstProc
                ENDIF
            ENDIF

            *-- Passo 2: Valida TipoEstos do grupo do produto
            IF loc_lContinuar
                loc_cSQL = "SELECT b.tipoestos " + ;
                           "FROM sigcdpro a " + ;
                           "JOIN sigcdgrp b ON a.cgrus = b.cgrus " + ;
                           "WHERE a.cpros = " + EscaparSQL(loc_cProd)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProc") >= 1 AND RECCOUNT("cursor_4c_GruposProc") > 0
                    SELECT cursor_4c_GruposProc
                    loc_nTipoEstos = cursor_4c_GruposProc.TipoEstos
                    IF INLIST(loc_nTipoEstos, 2, 4) AND EMPTY(loc_cCorNew)
                        MsgAviso("Favor Informar a Cor.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND INLIST(loc_nTipoEstos, 3, 4) AND EMPTY(loc_cTamNew)
                        MsgAviso("Favor Informar o Tamanho.", "Aten" + CHR(231) + CHR(227) + "o")
                        loc_lContinuar = .F.
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 3 AND !EMPTY(loc_cCorNew)
                        loc_cCorNew = ""
                    ENDIF
                    IF loc_lContinuar AND loc_nTipoEstos = 2 AND !EMPTY(loc_cTamNew)
                        loc_cTamNew = ""
                    ENDIF
                ENDIF
                IF USED("cursor_4c_GruposProc")
                    USE IN cursor_4c_GruposProc
                ENDIF
            ENDIF

            *-- Passo 3: Gera chaves unicas
            IF loc_lContinuar
                loc_nNume = fGerUniqueKey(ALLTRIM(THIS.this_cDopCorTam) + loc_cEmps)
                loc_cIds  = DTOS(loc_dData) + "S" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")
            ENDIF

            *-- Passo 4: Inicia transacao
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "BEGIN TRANSACTION") >= 1
                    loc_lTransacao = .T.
                ELSE
                    MsgErro("Falha ao iniciar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 5: INSERT em SigMvCab
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvCab " + ;
                           "(Emps, Dopes, Numes, Usuars, Datars, DataS, Mascnum, CidChaves, EmpDopNums) " + ;
                           "VALUES (" + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           EscaparSQL(ALLTRIM(fGerMascara(loc_nNume))) + ", " + ;
                           EscaparSQL(fUniqueIds()) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigMvCab)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 6: INSERT SigMvHst Saida (Opers='S', CodCors/CodTams ANTIGOS)
            IF loc_lContinuar
                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, EmpDopNums, " + ;
                           "EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'S', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorOld) + ", " + ;
                           EscaparSQL(loc_cTamOld) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Sa" + CHR(237) + "da")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 7: INSERT SigMvHst Entrada (Opers='E', CodCors/CodTams NOVOS)
            IF loc_lContinuar
                loc_cIds  = DTOS(loc_dData) + "E" + ;
                            TRANSFORM(fGerUniqueKey(DTOS(loc_dData)), "@L 999999") + ;
                            ALLTRIM(THIS.this_cSigKey)
                loc_nPSeq = fGerUniqueKey("HISTBAR")

                loc_cSQL = "INSERT INTO SigMvHst " + ;
                           "(Usuars, DataRs, Emps, Opers, Dopes, Numes, DataS, DtAudits, CPros, Units, " + ;
                           "Moedas, Totas, DataTrans, Empos, CodBarras, Qtds, Grupos, " + ;
                           "Estos, RecalMeds, Obs, CodCors, CodTams, Pesos, CidChaves, " + ;
                           "EmpDopNums, EmpGruEsts, OriDopNums, BcIpis, Seqs) " + ;
                           "VALUES (" + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           THIS.FormatarDatetimeSQL(loc_dtData) + ", " + ;
                           EscaparSQL(loc_cEmps) + ", " + ;
                           "'E', " + ;
                           EscaparSQL(ALLTRIM(THIS.this_cDopCorTam)) + ", " + ;
                           FormatarNumeroSQL(loc_nNume) + ", " + ;
                           "'" + SUBSTR(DTOS(loc_dData), 1, 4) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 5, 2) + "-" + ;
                                 SUBSTR(DTOS(loc_dData), 7, 2) + "', " + ;
                           FormatarDataSQL(loc_dDtAudits) + ", " + ;
                           EscaparSQL(loc_cProd) + ", " + ;
                           EscaparSQL(loc_cUnits) + ", " + ;
                           EscaparSQL(loc_cMoedas) + ", " + ;
                           FormatarNumeroSQL(loc_nTotas) + ", " + ;
                           FormatarDataSQL(loc_dDataTrans) + ", " + ;
                           EscaparSQL(loc_cEmpos) + ", " + ;
                           FormatarNumeroSQL(loc_nCodBarrasHist) + ", " + ;
                           FormatarNumeroSQL(loc_nQtds) + ", " + ;
                           EscaparSQL(loc_cGrupos) + ", " + ;
                           EscaparSQL(loc_cEstos) + ", " + ;
                           FormatarNumeroSQL(loc_nRecalMeds) + ", " + ;
                           EscaparSQL(loc_cObs) + ", " + ;
                           EscaparSQL(loc_cCorNew) + ", " + ;
                           EscaparSQL(loc_cTamNew) + ", " + ;
                           FormatarNumeroSQL(loc_nPesos) + ", " + ;
                           EscaparSQL(loc_cIds) + ", " + ;
                           EscaparSQL(loc_cEmps + ALLTRIM(THIS.this_cDopCorTam) + STR(loc_nNume, 6)) + ", " + ;
                           EscaparSQL(loc_cEmpGruEsts) + ", " + ;
                           EscaparSQL(loc_cOriDopNums) + ", " + ;
                           FormatarNumeroSQL(loc_nBcIpis) + ", " + ;
                           FormatarNumeroSQL(loc_nPSeq) + ;
                           ")"
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha Hist Entrada")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 8: UPDATE SigOpEtq com novos CodCors/CodTams
            IF loc_lContinuar
                loc_cSQL = "UPDATE SigOpEtq SET " + ;
                           "CodCors = " + EscaparSQL(loc_cCorNew) + ", " + ;
                           "CodTams = " + EscaparSQL(loc_cTamNew) + ;
                           " WHERE CBars = " + TRANSFORM(loc_nCodBarras)
                IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                    MsgErro("Favor reinicializar o processo!!!", "Falha (SigOpEtq)")
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            *-- Passo 9: Recalculo de estoque via SqlCalcP2 e fRecalculaC
            IF loc_lContinuar
                CREATE CURSOR cursor_4c_LocalHis ;
                    (Emps C(10), Grupos C(10), Estos C(20), CPros C(15), DataS D, CodCors C(6), CodTams C(6))
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorOld, loc_cTamOld)
                INSERT INTO cursor_4c_LocalHis VALUES ;
                    (loc_cEmps, loc_cGrupos, loc_cEstos, loc_cProd, loc_dData, loc_cCorNew, loc_cTamNew)
                SELECT cursor_4c_LocalHis
                GO TOP
                SCAN
                    =SqlCalcP2(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.Grupos, ;
                               cursor_4c_LocalHis.Estos, cursor_4c_LocalHis.CPros, ;
                               cursor_4c_LocalHis.DataS, cursor_4c_LocalHis.CodCors, ;
                               cursor_4c_LocalHis.CodTams, gnConnHandle)
                    =SqlCalcP2(.T., gnConnHandle, .T.)
                    =fRecalculaC(cursor_4c_LocalHis.Emps, cursor_4c_LocalHis.CPros, ;
                                 cursor_4c_LocalHis.DataS, gnConnHandle)
                    SELECT cursor_4c_LocalHis
                ENDSCAN
                IF USED("cursor_4c_LocalHis")
                    USE IN cursor_4c_LocalHis
                ENDIF
            ENDIF

            *-- Passo 10: Commit ou Rollback
            IF loc_lContinuar
                IF SQLEXEC(gnConnHandle, "COMMIT") >= 1
                    loc_lTransacao = .F.
                    loc_lSucesso   = .T.
                ELSE
                    MsgErro("Falha ao confirmar transa" + CHR(231) + CHR(227) + "o.", "Erro")
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ELSE
                IF loc_lTransacao
                    SQLEXEC(gnConnHandle, "ROLLBACK")
                    loc_lTransacao = .F.
                ENDIF
            ENDIF

            *-- Passo 11: Log de auditoria (somente apos sucesso)
            IF loc_lSucesso
                loc_cMsg = "Barra : " + TRANSFORM(loc_nCodBarras) + ;
                           " *** Anterior(C:" + loc_cCorOld + ",T:" + loc_cTamOld + ;
                           ") Novo(C:" + loc_cCorNew + ",T:" + loc_cTamNew + ") *** "
                =fGravarLog("T", "SIGMDETQ", ALLTRIM(THIS.this_cDopCorTam), loc_cMsg, gc_4c_UsuarioLogado)
                THIS.RegistrarAuditoria("ALTERAR")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ProcessarAltera" + CHR(231) + CHR(227) + "o")
            IF loc_lTransacao
                SQLEXEC(gnConnHandle, "ROLLBACK")
            ENDIF
            IF USED("cursor_4c_MvHstProc")
                USE IN cursor_4c_MvHstProc
            ENDIF
            IF USED("cursor_4c_GruposProc")
                USE IN cursor_4c_GruposProc
            ENDIF
            IF USED("cursor_4c_LocalHis")
                USE IN cursor_4c_LocalHis
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * Form SIGMDETQ nao possui insert tradicional. A operacao unica eh a
    * mudanca de cor/tamanho da etiqueta, que gera INSERT em SigMvCab/SigMvHst
    * e UPDATE em SigOpEtq atomicamente dentro de ProcessarAlteracao().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Operacao CRUD (form OPERACIONAL): delega para ProcessarAlteracao
    * A "atualizacao" da etiqueta (troca de cor/tamanho) segue o mesmo fluxo
    * transacional de ProcessarAlteracao (UPDATE SigOpEtq + historico).
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN THIS.ProcessarAlteracao()
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, ChavePrimaria, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpEtq") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(TRANSFORM(THIS.this_nCodBarras)) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       THIS.FormatarDatetimeSQL(DATETIME()) + ;
                       ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro RegistrarAuditoria")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDatetimeSQL - Converte DATETIME VFP para CONVERT SQL Server
    * Retorna: CONVERT(DATETIME, 'AAAA-MM-DD HH:MM:SS', 120)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDatetimeSQL(par_dtVal)
        LOCAL loc_cDate, loc_cTime
        loc_cDate = PADL(TRANSFORM(YEAR(par_dtVal)),   4, "0") + "-" + ;
                    PADL(TRANSFORM(MONTH(par_dtVal)),  2, "0") + "-" + ;
                    PADL(TRANSFORM(DAY(par_dtVal)),    2, "0")
        loc_cTime = PADL(TRANSFORM(HOUR(par_dtVal)),   2, "0") + ":" + ;
                    PADL(TRANSFORM(MINUTE(par_dtVal)), 2, "0") + ":" + ;
                    PADL(TRANSFORM(SEC(par_dtVal)),    2, "0")
        RETURN "CONVERT(DATETIME, '" + loc_cDate + " " + loc_cTime + "', 120)"
    ENDPROC

ENDDEFINE

