# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGloT.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1777 linhas total):

*-- Linhas 10 a 233:
10: *
11: * CHAMADA:
12: *   DO FORM FormSigPrGloT WITH _Reserva, _Autom, _PorDestino, lcNomeFrm, pTipo
13: *   Ou via CreateObject("FormSigPrGloT", lReserva, lAutom, lPorDestino, pTipo)
14: *
15: * Parametros:
16: *   par_lReserva    - .T. = modo Reserva Automatica
17: *   par_lAutom      - .T. = modo automatico
18: *   par_lPorDestino - .T. = por destino
19: *   par_pTipo       - .T. = processa por tipo de geracao de OP
20: *==============================================================================
21: 
22: DEFINE CLASS FormSigPrGloT AS FormBase
23: 
24:     *-- Dimensoes identicas ao legado (Width=680, Height=379)
25:     Width        = 680
26:     Height       = 379
27:     AutoCenter   = .T.
28:     TitleBar     = 0
29:     ShowWindow   = 1
30:     WindowType   = 1
31:     ControlBox   = .F.
32:     Closable     = .F.
33:     MaxButton    = .F.
34:     MinButton    = .F.
35:     BorderStyle  = 2
36:     DataSession  = 2
37:     ClipControls = .F.
38:     Caption      = "Processamento de O.P. por Totais"
39:     FontName     = "Tahoma"
40:     FontSize     = 8
41: 
42:     *-- Flags de modo de operacao (recebidos via Init)
43:     this_lReserva         = .F.
44:     this_lAutomatico      = .F.
45:     this_lPorDestino      = .F.
46:     this_lGerPorTp        = .F.
47:     this_lAlterEmp        = .T.
48:     *-- Controlado apos leitura de cursor_4c_CrSigCdPamT em InicializarForm
49:     this_lMostrarChkPedra = .F.
50: 
51:     *--------------------------------------------------------------------------
52:     * Init - recebe flags de modo, seta propriedades e delega ao FormBase
53:     *--------------------------------------------------------------------------
54:     PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
55:         THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
56:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
57:         THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
58:         THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
59:         DODEFAULT()
60:     ENDPROC
61: 
62:     *--------------------------------------------------------------------------
63:     * Destroy - libera cursores temporarios e BO antes de fechar
64:     *--------------------------------------------------------------------------
65:     PROCEDURE Destroy()
66:         IF USED("cursor_4c_TmpOperT")
67:             USE IN cursor_4c_TmpOperT
68:         ENDIF
69:         IF USED("cursor_4c_CrTmpTpGopT")
70:             USE IN cursor_4c_CrTmpTpGopT
71:         ENDIF
72:         IF USED("cursor_4c_CrSigCdPamT")
73:             USE IN cursor_4c_CrSigCdPamT
74:         ENDIF
75:         IF USED("cursor_4c_CrSigCdPacT")
76:             USE IN cursor_4c_CrSigCdPacT
77:         ENDIF
78:         IF USED("cursor_4c_TmpCabecT")
79:             USE IN cursor_4c_TmpCabecT
80:         ENDIF
81:         IF USED("cursor_4c_TmpItensT")
82:             USE IN cursor_4c_TmpItensT
83:         ENDIF
84:         IF USED("TmpCabec")
85:             USE IN TmpCabec
86:         ENDIF
87:         IF USED("TmpItens")
88:             USE IN TmpItens
89:         ENDIF
90:         IF USED("cursor_4c_OperT")
91:             USE IN cursor_4c_OperT
92:         ENDIF
93:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
94:             THIS.this_oBusinessObject = .NULL.
95:         ENDIF
96:         DODEFAULT()
97:     ENDPROC
98: 
99:     *--------------------------------------------------------------------------
100:     * InicializarForm - cria BO, carrega parametros e monta estrutura visual
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE InicializarForm()
103:         LOCAL loc_lSucesso, loc_oErro, loc_cCaption
104:         loc_lSucesso = .F.
105: 
106:         TRY
107:             *-- Criar Business Object
108:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloTBO")
109:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
110:                 MsgErro("Falha ao criar SigPrGloTBO.", "Erro")
111:             ELSE
112:                 *-- Repassar flags de modo ao BO
113:                 WITH THIS.this_oBusinessObject
114:                     .this_lReserva    = THIS.this_lReserva
115:                     .this_lAutomatico = THIS.this_lAutomatico
116:                     .this_lPorDestino = THIS.this_lPorDestino
117:                     .this_lGerPorTp   = THIS.this_lGerPorTp
118:                     .this_lAlterEmp   = THIS.this_lAlterEmp
119:                 ENDWITH
120: 
121:                 *-- Carregar operacoes (obrigatorio - form nao funciona sem elas)
122:                 IF NOT THIS.this_oBusinessObject.CarregarOperacoes()
123:                     MsgErro("Nenhuma Opera" + CHR(231) + CHR(227) + ;
124:                             "o configurada para Processamento de O.P. por Totais.", "Erro")
125:                 ELSE
126:                     *-- Carregar demais parametros do sistema
127:                     THIS.this_oBusinessObject.CarregarParametros()
128:                     THIS.this_oBusinessObject.CarregarPacotes()
129:                     THIS.this_oBusinessObject.CarregarTiposGeracao()
130: 
131:                     *-- Caption dinamico conforme modo de operacao
132:                     loc_cCaption = "Processamento de O.P. por Totais"
133:                     IF THIS.this_lReserva
134:                         loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica (Totais)"
135:                     ELSE
136:                         IF THIS.this_lGerPorTp
137:                             loc_cCaption = "Processar O.P. por Tipo (Totais)"
138:                         ENDIF
139:                     ENDIF
140:                     THIS.Caption = loc_cCaption
141: 
142:                     *-- Imagem de fundo
143:                     THIS.ConfigurarPageFrame()
144: 
145:                     *-- Calcular visibilidade do chk_pedra (antes de criar controles)
146:                     IF USED("cursor_4c_CrSigCdPamT") AND NOT EOF("cursor_4c_CrSigCdPamT")
147:                         SELECT cursor_4c_CrSigCdPamT
148:                         THIS.this_lMostrarChkPedra = ;
149:                             (NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPamT.DopEmphs)) AND ;
150:                              NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPamT.DopReqcs)) AND ;
151:                              NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPamT.DopPedcs)) AND ;
152:                              NOT EMPTY(ALLTRIM(cursor_4c_CrSigCdPamT.TransfRes)))
153:                     ENDIF
154: 
155:                     *-- Montar estrutura visual do form
156:                     THIS.ConfigurarCabecalho()
157:                     THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
158:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
159:                     THIS.ConfigurarShape()
160:                     THIS.ConfigurarPaginaLista()
161:                     THIS.TornarControlesVisiveis()
162:                     THIS.PopularCamposIniciais()
163:                     THIS.ConfigurarEventos()
164:                     THIS.AlternarPagina("ENTRADA")
165: 
166:                     loc_lSucesso = .T.
167:                 ENDIF
168:             ENDIF
169:         CATCH TO loc_oErro
170:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
171:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
172:         ENDTRY
173: 
174:         RETURN loc_lSucesso
175:     ENDPROC
176: 
177:     *--------------------------------------------------------------------------
178:     * ConfigurarPageFrame - aplica imagem de fundo (form plano OPERACIONAL)
179:     *--------------------------------------------------------------------------
180:     PROTECTED PROCEDURE ConfigurarPageFrame()
181:         LOCAL loc_cImg
182:         loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
183:         IF FILE(loc_cImg)
184:             THIS.Picture = loc_cImg
185:         ENDIF
186:         THIS.ScrollBars = 0
187:     ENDPROC
188: 
189:     *--------------------------------------------------------------------------
190:     * ConfigurarCabecalho - cabecalho cinza escuro com titulo (cntSombra legado)
191:     * Top=0, Left=0, Width=680, Height=80
192:     *--------------------------------------------------------------------------
193:     PROTECTED PROCEDURE ConfigurarCabecalho()
194:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
195:         WITH THIS.cnt_4c_Cabecalho
196:             .Top         = 0
197:             .Left        = 0
198:             .Width       = THIS.Width
199:             .Height      = 80
200:             .BackStyle   = 1
201:             .BackColor   = RGB(100,100,100)
202:             .BorderWidth = 0
203:             .Visible     = .T.
204: 
205:             .AddObject("lbl_4c_Sombra", "Label")
206:             WITH .lbl_4c_Sombra
207:                 .AutoSize      = .F.
208:                 .FontBold      = .T.
209:                 .FontName      = "Tahoma"
210:                 .FontSize      = 18
211:                 .FontUnderline = .F.
212:                 .WordWrap      = .T.
213:                 .Alignment     = 0
214:                 .BackStyle     = 0
215:                 .Height        = 40
216:                 .Left          = 10
217:                 .Top           = 18
218:                 .Width         = THIS.Width
219:                 .ForeColor     = RGB(0,0,0)
220:                 .Caption       = THIS.Caption
221:                 .Visible       = .T.
222:             ENDWITH
223: 
224:             .AddObject("lbl_4c_Titulo", "Label")
225:             WITH .lbl_4c_Titulo
226:                 .AutoSize      = .F.
227:                 .FontBold      = .T.
228:                 .FontName      = "Tahoma"
229:                 .FontSize      = 18
230:                 .FontUnderline = .F.
231:                 .WordWrap      = .T.
232:                 .Alignment     = 0
233:                 .BackStyle     = 0

*-- Linhas 246 a 308:
246:     * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
247:     * Top=7, Left=486, Height=110, Width=173
248:     *--------------------------------------------------------------------------
249:     PROTECTED PROCEDURE ConfigurarShape()
250:         THIS.AddObject("shp_4c_Shape3", "Shape")
251:         WITH THIS.shp_4c_Shape3
252:             .Top         = 7
253:             .Left        = 486
254:             .Height      = 110
255:             .Width       = 173
256:             .BackStyle   = 0
257:             .BorderStyle = 0
258:             .BorderColor = RGB(90,90,90)
259:             .Visible     = .T.
260:         ENDWITH
261:     ENDPROC
262: 
263:     *--------------------------------------------------------------------------
264:     * ConfigurarBotoes - botoes Processar e Cancelar
265:     * Processar: Top=3, Left=528, 75x75
266:     * Cancelar : Top=3, Left=603, 75x75
267:     *--------------------------------------------------------------------------
268:     PROTECTED PROCEDURE ConfigurarBotoes()
269:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
270:         WITH THIS.cmd_4c_Processar
271:             .Top             = 3
272:             .Left            = 528
273:             .Height          = 75
274:             .Width           = 75
275:             .FontBold        = .T.
276:             .FontItalic      = .T.
277:             .FontName        = "Tahoma"
278:             .FontSize        = 8
279:             .WordWrap        = .T.
280:             .Caption         = "Processar"
281:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
282:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
283:             .ForeColor       = RGB(90,90,90)
284:             .BackColor       = RGB(255,255,255)
285:             .Themes          = .T.
286:             .PicturePosition = 13
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15
289:             .Visible         = .T.
290:         ENDWITH
291: 
292:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
293:         WITH THIS.cmd_4c_Cancelar
294:             .Top             = 3
295:             .Left            = 603
296:             .Height          = 75
297:             .Width           = 75
298:             .FontBold        = .T.
299:             .FontItalic      = .T.
300:             .FontName        = "Tahoma"
301:             .FontSize        = 8
302:             .WordWrap        = .T.
303:             .Caption         = "Encerrar"
304:             .Cancel          = .T.
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
306:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:             .ForeColor       = RGB(90,90,90)
308:             .BackColor       = RGB(255,255,255)

*-- Linhas 317 a 360:
317:     *--------------------------------------------------------------------------
318:     * ConfigurarContainers - cria containers principais vazios
319:     *--------------------------------------------------------------------------
320:     PROTECTED PROCEDURE ConfigurarContainers()
321:         LOCAL loc_lGlobAutos2
322:         loc_lGlobAutos2 = .F.
323:         IF USED("cursor_4c_CrSigCdPamT") AND NOT EOF("cursor_4c_CrSigCdPamT")
324:             SELECT cursor_4c_CrSigCdPamT
325:             loc_lGlobAutos2 = (cursor_4c_CrSigCdPamT.GlobAutos = 2 AND NOT THIS.this_lReserva)
326:         ENDIF
327: 
328:         *-- Container1: Tipo de O.P.
329:         THIS.AddObject("cnt_4c_TipoOp", "Container")
330:         WITH THIS.cnt_4c_TipoOp
331:             .Top         = 164
332:             .Left        = 139
333:             .Width       = 346
334:             .Height      = 25
335:             .BackStyle   = 0
336:             .BorderWidth = 0
337:             .Enabled     = THIS.this_lGerPorTp
338:             .Visible     = .T.
339:         ENDWITH
340: 
341:         *-- Opera_ao: codigo + faixa i/f
342:         THIS.AddObject("cnt_4c_Operacao", "Container")
343:         WITH THIS.cnt_4c_Operacao
344:             .Top         = 191
345:             .Left        = 139
346:             .Width       = 350
347:             .Height      = 25
348:             .BackStyle   = 0
349:             .BorderWidth = 0
350:             .Visible     = .T.
351:         ENDWITH
352: 
353:         *-- Conta: grupo/conta/descricao para filtro de movimentacao
354:         THIS.AddObject("cnt_4c_Conta", "Container")
355:         WITH THIS.cnt_4c_Conta
356:             .Top         = 218
357:             .Left        = 139
358:             .Width       = 553
359:             .Height      = 25
360:             .BackStyle   = 0

*-- Linhas 415 a 458:
415:     *--------------------------------------------------------------------------
416:     * ConfigurarCamposForm - labels e textboxes de data diretamente no form
417:     *--------------------------------------------------------------------------
418:     PROTECTED PROCEDURE ConfigurarCamposForm()
419:         THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
420:         WITH THIS.lbl_4c_PeriodoEmissao
421:             .AutoSize  = .F.
422:             .BackStyle = 0
423:             .FontName  = "Tahoma"
424:             .FontSize  = 8
425:             .ForeColor = RGB(90,90,90)
426:             .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
427:             .Height    = 15
428:             .Left      = 32
429:             .Top       = 115
430:             .Width     = 101
431:         ENDWITH
432: 
433:         THIS.AddObject("txt_4c_Dataei", "TextBox")
434:         WITH THIS.txt_4c_Dataei
435:             .Alignment     = 3
436:             .Value         = {}
437:             .Format        = "K"
438:             .Height        = 23
439:             .Left          = 142
440:             .Top           = 111
441:             .Width         = 80
442:             .SpecialEffect = 1
443:             .FontName      = "Tahoma"
444:             .FontSize      = 8
445:         ENDWITH
446: 
447:         THIS.AddObject("lbl_4c_Ate1", "Label")
448:         WITH THIS.lbl_4c_Ate1
449:             .AutoSize  = .F.
450:             .BackStyle = 0
451:             .FontName  = "Tahoma"
452:             .FontSize  = 8
453:             .ForeColor = RGB(90,90,90)
454:             .Caption   = "at" + CHR(233)
455:             .Height    = 15
456:             .Left      = 227
457:             .Top       = 115
458:             .Width     = 18

*-- Linhas 602 a 663:
602:     *--------------------------------------------------------------------------
603:     * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
604:     *--------------------------------------------------------------------------
605:     PROTECTED PROCEDURE ConfigurarContainerTipoOp()
606:         THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
607:         WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
608:             .Left          = 3
609:             .Top           = 1
610:             .Width         = 80
611:             .Height        = 23
612:             .MaxLength     = 10
613:             .FontName      = "Courier New"
614:             .FontSize      = 9
615:             .Margin        = 2
616:             .SpecialEffect = 1
617:         ENDWITH
618:     ENDPROC
619: 
620:     *--------------------------------------------------------------------------
621:     * ConfigurarContainerOperacao - Opera_ao: codigo + faixa i/f
622:     *--------------------------------------------------------------------------
623:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
624:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
625:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
626:             .Left          = 3
627:             .Top           = 1
628:             .Width         = 151
629:             .Height        = 23
630:             .MaxLength     = 20
631:             .FontName      = "Courier New"
632:             .FontSize      = 9
633:             .Margin        = 2
634:             .SpecialEffect = 1
635:         ENDWITH
636: 
637:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
638:         WITH THIS.cnt_4c_Operacao.lbl_4c_De
639:             .AutoSize  = .F.
640:             .BackStyle = 0
641:             .FontName  = "Tahoma"
642:             .FontSize  = 8
643:             .ForeColor = RGB(90,90,90)
644:             .Caption   = "de"
645:             .Height    = 15
646:             .Left      = 180
647:             .Top       = 5
648:             .Width     = 14
649:         ENDWITH
650: 
651:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
652:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
653:             .Alignment     = 3
654:             .Value         = 0
655:             .Format        = "K"
656:             .Height        = 23
657:             .InputMask     = "999999"
658:             .Left          = 201
659:             .Top           = 1
660:             .Width         = 55
661:             .MaxLength     = 6
662:             .SpecialEffect = 1
663:             .FontName      = "Courier New"

*-- Linhas 698 a 817:
698:     *--------------------------------------------------------------------------
699:     * ConfigurarContainerConta - Movimentacao: grupo/conta/descricao
700:     *--------------------------------------------------------------------------
701:     PROTECTED PROCEDURE ConfigurarContainerConta()
702:         THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
703:         WITH THIS.cnt_4c_Conta.txt_4c_Grupo
704:             .Left          = 3
705:             .Top           = 1
706:             .Width         = 80
707:             .Height        = 23
708:             .SpecialEffect = 1
709:             .FontName      = "Tahoma"
710:             .FontSize      = 8
711:         ENDWITH
712: 
713:         THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
714:         WITH THIS.cnt_4c_Conta.txt_4c_Conta
715:             .Left          = 86
716:             .Top           = 1
717:             .Width         = 80
718:             .Height        = 23
719:             .SpecialEffect = 1
720:             .FontName      = "Tahoma"
721:             .FontSize      = 8
722:         ENDWITH
723: 
724:         THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
725:         WITH THIS.cnt_4c_Conta.txt_4c_Dconta
726:             .Left          = 170
727:             .Top           = 1
728:             .Width         = 360
729:             .Height        = 23
730:             .SpecialEffect = 1
731:             .FontName      = "Tahoma"
732:             .FontSize      = 8
733:         ENDWITH
734:     ENDPROC
735: 
736:     *--------------------------------------------------------------------------
737:     * ConfigurarContainerResponsavel - Vendedor: grupo/conta/descricao
738:     *--------------------------------------------------------------------------
739:     PROTECTED PROCEDURE ConfigurarContainerResponsavel()
740:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
741:         WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
742:             .Left          = 3
743:             .Top           = 1
744:             .Width         = 80
745:             .Height        = 23
746:             .SpecialEffect = 1
747:             .FontName      = "Tahoma"
748:             .FontSize      = 8
749:         ENDWITH
750: 
751:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
752:         WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
753:             .Left          = 86
754:             .Top           = 1
755:             .Width         = 80
756:             .Height        = 23
757:             .SpecialEffect = 1
758:             .FontName      = "Tahoma"
759:             .FontSize      = 8
760:         ENDWITH
761: 
762:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
763:         WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
764:             .Left          = 170
765:             .Top           = 1
766:             .Width         = 360
767:             .Height        = 23
768:             .SpecialEffect = 1
769:             .FontName      = "Tahoma"
770:             .FontSize      = 8
771:         ENDWITH
772:     ENDPROC
773: 
774:     *--------------------------------------------------------------------------
775:     * ConfigurarContainerEmpresa - cd_empresa / ds_empresa / chk pedras
776:     *--------------------------------------------------------------------------
777:     PROTECTED PROCEDURE ConfigurarContainerEmpresa()
778:         THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
779:         WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
780:             .Left          = 4
781:             .Top           = 1
782:             .Width         = 31
783:             .Height        = 23
784:             .InputMask     = "XXX"
785:             .MaxLength     = 3
786:             .Format        = "k"
787:             .BackStyle     = 1
788:             .BorderStyle   = 1
789:             .ForeColor     = RGB(0,0,0)
790:             .FontName      = "Courier New"
791:             .FontSize      = 9
792:             .SpecialEffect = 1
793:         ENDWITH
794: 
795:         THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
796:         WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
797:             .Left          = 38
798:             .Top           = 1
799:             .Width         = 282
800:             .Height        = 23
801:             .MaxLength     = 40
802:             .Format        = "K"
803:             .FontName      = "Courier New"
804:             .FontSize      = 9
805:             .SpecialEffect = 1
806:         ENDWITH
807: 
808:         THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
809:         WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
810:             .Left      = 330
811:             .Top       = 5
812:             .Height    = 15
813:             .Width     = 124
814:             .FontName  = "Tahoma"
815:             .FontSize  = 8
816:             .BackStyle = 0
817:             .Caption   = "N" + CHR(227) + "o Empenhar Pedras"

*-- Linhas 824 a 867:
824:     *--------------------------------------------------------------------------
825:     * ConfigurarContainerPrevisao - data previsao entrega + data geracao
826:     *--------------------------------------------------------------------------
827:     PROTECTED PROCEDURE ConfigurarContainerPrevisao()
828:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
829:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
830:             .AutoSize  = .F.
831:             .BackStyle = 0
832:             .FontName  = "Tahoma"
833:             .FontSize  = 8
834:             .ForeColor = RGB(90,90,90)
835:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
836:             .Height    = 15
837:             .Left      = 7
838:             .Top       = 9
839:             .Width     = 106
840:         ENDWITH
841: 
842:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
843:         WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
844:             .Alignment     = 3
845:             .Value         = {}
846:             .Format        = "K"
847:             .Height        = 23
848:             .Left          = 134
849:             .Top           = 5
850:             .Width         = 80
851:             .SpecialEffect = 1
852:             .FontName      = "Tahoma"
853:             .FontSize      = 8
854:         ENDWITH
855: 
856:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
857:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
858:             .AutoSize  = .F.
859:             .BackStyle = 0
860:             .FontName  = "Tahoma"
861:             .FontSize  = 8
862:             .ForeColor = RGB(90,90,90)
863:             .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
864:             .Height    = 15
865:             .Left      = 244
866:             .Top       = 9
867:             .Width     = 90

*-- Linhas 885 a 1027:
885:     *--------------------------------------------------------------------------
886:     * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
887:     *--------------------------------------------------------------------------
888:     PROTECTED PROCEDURE ConfigurarContainerOp()
889:         THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
890:         WITH THIS.cnt_4c_Op.lbl_4c_LblNop
891:             .AutoSize  = .F.
892:             .BackStyle = 0
893:             .FontName  = "Tahoma"
894:             .FontSize  = 8
895:             .ForeColor = RGB(90,90,90)
896:             .Caption   = "N" + CHR(186) + " da O.P.:"
897:             .Height    = 15
898:             .Left      = 0
899:             .Top       = 5
900:             .Width     = 58
901:         ENDWITH
902: 
903:         THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
904:         WITH THIS.cnt_4c_Op.txt_4c_Nop
905:             .Alignment     = 3
906:             .Value         = 0
907:             .Height        = 23
908:             .InputMask     = "999999"
909:             .Left          = 71
910:             .Top           = 1
911:             .Width         = 59
912:             .MaxLength     = 6
913:             .SpecialEffect = 1
914:             .FontName      = "Tahoma"
915:             .FontSize      = 8
916:         ENDWITH
917:     ENDPROC
918: 
919:     *--------------------------------------------------------------------------
920:     * ConfigurarPaginaLista - monta a area principal (botoes + containers + campos)
921:     *--------------------------------------------------------------------------
922:     PROTECTED PROCEDURE ConfigurarPaginaLista()
923:         THIS.ConfigurarBotoes()
924:         THIS.ConfigurarContainers()
925:         THIS.ConfigurarCamposForm()
926:         THIS.ConfigurarContainerTipoOp()
927:         THIS.ConfigurarContainerOperacao()
928:         THIS.ConfigurarContainerConta()
929:         THIS.ConfigurarContainerResponsavel()
930:         THIS.ConfigurarContainerEmpresa()
931:         THIS.ConfigurarContainerPrevisao()
932:         THIS.ConfigurarContainerOp()
933:     ENDPROC
934: 
935:     *--------------------------------------------------------------------------
936:     * ConfigurarPaginaDados - stub de compatibilidade (OPERACIONAL nao tem Page2)
937:     *--------------------------------------------------------------------------
938:     PROTECTED PROCEDURE ConfigurarPaginaDados()
939:         RETURN
940:     ENDPROC
941: 
942:     *--------------------------------------------------------------------------
943:     * TornarControlesVisiveis - torna controles do form visiveis apos AddObject
944:     * Preserva Visible de cnt_4c_Op (gerenciado por GlobAutos) mas recursas filhos
945:     *--------------------------------------------------------------------------
946:     PROCEDURE TornarControlesVisiveis()
947:         LOCAL loc_i, loc_oCtrl, loc_lSkip
948:         FOR loc_i = 1 TO THIS.ControlCount
949:             loc_oCtrl = THIS.Controls(loc_i)
950:             IF VARTYPE(loc_oCtrl) != "O"
951:                 LOOP
952:             ENDIF
953:             loc_lSkip = (UPPER(loc_oCtrl.Name) = "CNT_4C_OP")
954:             IF loc_lSkip
955:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
956:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
957:                 ENDIF
958:                 LOOP
959:             ENDIF
960:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
961:                 loc_oCtrl.Visible = .T.
962:             ENDIF
963:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
964:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
965:             ENDIF
966:         ENDFOR
967:     ENDPROC
968: 
969:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
970:         LOCAL loc_i, loc_oCtrl
971:         FOR loc_i = 1 TO par_oContainer.ControlCount
972:             loc_oCtrl = par_oContainer.Controls(loc_i)
973:             IF VARTYPE(loc_oCtrl) = "O"
974:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
975:                     loc_oCtrl.Visible = .T.
976:                 ENDIF
977:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
978:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
979:                 ENDIF
980:             ENDIF
981:         ENDFOR
982:     ENDPROC
983: 
984:     *--------------------------------------------------------------------------
985:     * PopularCamposIniciais - preenche valores iniciais apos criacao dos controles
986:     *--------------------------------------------------------------------------
987:     PROTECTED PROCEDURE PopularCamposIniciais()
988:         LOCAL loc_oErro, loc_cEmp, loc_cRazas
989:         TRY
990:             *-- Empresa padrao: go_4c_Sistema.cCodEmpresa
991:             loc_cEmp   = ALLTRIM(go_4c_Sistema.cCodEmpresa)
992:             loc_cRazas = ""
993:             IF USED("cursor_4c_TmpEmpInitT")
994:                 USE IN cursor_4c_TmpEmpInitT
995:             ENDIF
996:             IF SQLEXEC(gnConnHandle, ;
997:                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
998:                "cursor_4c_TmpEmpInitT") >= 1
999:                 IF RECCOUNT("cursor_4c_TmpEmpInitT") > 0
1000:                     SELECT cursor_4c_TmpEmpInitT
1001:                     loc_cRazas = ALLTRIM(cursor_4c_TmpEmpInitT.Razas)
1002:                 ENDIF
1003:                 USE IN cursor_4c_TmpEmpInitT
1004:             ENDIF
1005:             THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = loc_cEmp
1006:             THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = loc_cRazas
1007: 
1008:             *-- Previsao de entrega: data atual + PrevProds dias
1009:             IF USED("cursor_4c_CrSigCdPamT") AND NOT EOF("cursor_4c_CrSigCdPamT")
1010:                 SELECT cursor_4c_CrSigCdPamT
1011:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + cursor_4c_CrSigCdPamT.PrevProds
1012:             ENDIF
1013: 
1014:             *-- Data de geracao: data atual (apenas se nao modo automatico)
1015:             IF NOT THIS.this_lAutomatico
1016:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
1017:             ENDIF
1018: 
1019:             *-- Visibilidade do checkbox pedras
1020:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
1021: 
1022:             *-- Pre-selecionar tipo de OP se GerPorTp e houver apenas 1 tipo disponivel
1023:             IF THIS.this_lGerPorTp AND ;
1024:                USED("cursor_4c_CrTmpTpGopT") AND ;
1025:                RECCOUNT("cursor_4c_CrTmpTpGopT") = 1
1026:                 SELECT cursor_4c_CrTmpTpGopT
1027:                 GO TOP

*-- Linhas 1033 a 1777:
1033:     ENDPROC
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
1037:     *--------------------------------------------------------------------------
1038:     PROTECTED PROCEDURE ConfigurarEventos()
1039:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1040:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
1041:         BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
1042:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
1043:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
1044:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
1045:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")
1046:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta,           "KeyPress", THIS, "TxtDcontaKeyPress")
1047:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "TxtGrupoRespKeyPress")
1048:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "TxtContaRespKeyPress")
1049:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "TxtDcontaRespKeyPress")
1050:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa,      "KeyPress", THIS, "TxtCdEmpresaKeyPress")
1051:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa,      "KeyPress", THIS, "TxtDsEmpresaKeyPress")
1052:         BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop,                 "KeyPress", THIS, "TxtNopKeyPress")
1053:     ENDPROC
1054: 
1055:     *--------------------------------------------------------------------------
1056:     * CmdProcessarClick - valida campos, copia ao BO e executa processamento
1057:     *--------------------------------------------------------------------------
1058:     PROCEDURE CmdProcessarClick()
1059:         LOCAL loc_nGlobAutos, loc_oErro, loc_lProcessou, loc_lErroOcorreu, loc_oGl2
1060:         loc_nGlobAutos   = 0
1061:         loc_lProcessou   = .F.
1062:         loc_lErroOcorreu = .F.
1063: 
1064:         *-- Validar previsao e geracao (obrigatorias em modo normal)
1065:         IF NOT THIS.this_lReserva
1066:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
1067:                 MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!")
1068:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
1069:                 RETURN
1070:             ENDIF
1071:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
1072:                 MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!")
1073:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
1074:                 RETURN
1075:             ENDIF
1076:         ENDIF
1077: 
1078:         *-- Validar numero OP manual (GlobAutos=2)
1079:         IF USED("cursor_4c_CrSigCdPamT") AND NOT EOF("cursor_4c_CrSigCdPamT")
1080:             SELECT cursor_4c_CrSigCdPamT
1081:             loc_nGlobAutos = cursor_4c_CrSigCdPamT.GlobAutos
1082:             IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
1083:                 IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1084:                     MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!")
1085:                     THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
1086:                     RETURN
1087:                 ENDIF
1088:             ENDIF
1089:         ENDIF
1090: 
1091:         *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
1092:         IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
1093:             MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
1094:                      " Obrigat" + CHR(243) + "rio ser Preenchido!!!")
1095:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus
1096:             RETURN
1097:         ENDIF
1098: 
1099:         *-- Copiar campos do form para o BO
1100:         THIS.FormParaBO()
1101: 
1102:         *-- Bloquear UI durante processamento
1103:         THIS.AlternarPagina("PROCESSANDO")
1104: 
1105:         TRY
1106:             loc_lProcessou = THIS.this_oBusinessObject.ProcessarOP()
1107:         CATCH TO loc_oErro
1108:             MsgErro("Erro no processamento: " + loc_oErro.Message + ;
1109:                     " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1110:             loc_lErroOcorreu = .T.
1111:         ENDTRY
1112: 
1113:         *-- Restaurar UI (sempre - inclusive em erro)
1114:         THIS.AlternarPagina("ENTRADA")
1115: 
1116:         IF loc_lProcessou
1117:             *-- Criar cursores TmpCabec/TmpItens esperados por FormSigPrGl2/SigPrGl2BO
1118:             THIS.PrepararCursoresParaGl2()
1119: 
1120:             *-- Abrir FormSigPrGl2 para exibir/confirmar resultados
1121:             loc_oGl2 = CREATEOBJECT("FormSigPrGl2", THIS, THIS.DataSessionId, ;
1122:                 THIS.this_lReserva, .NULL., 0, ;
1123:                 THIS.this_lAutomatico, THIS.this_oBusinessObject.this_nNumeroOP)
1124:             IF VARTYPE(loc_oGl2) = "O"
1125:                 loc_oGl2.Show()
1126:                 loc_oGl2 = .NULL.
1127:             ENDIF
1128:         ELSE
1129:             IF NOT loc_lErroOcorreu
1130:                 MsgAviso("Nenhum Item Selecionado Para Processar!!!")
1131:                 IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1132:                     THIS.txt_4c_Dataei.SetFocus
1133:                 ENDIF
1134:             ENDIF
1135:         ENDIF
1136:     ENDPROC
1137: 
1138:     *--------------------------------------------------------------------------
1139:     * PrepararCursoresParaGl2 - cria TmpCabec/TmpItens a partir dos cursores
1140:     * com sufixo T gerados pelo SigPrGloTBO, para compatibilidade com SigPrGl2BO
1141:     *--------------------------------------------------------------------------
1142:     PROTECTED PROCEDURE PrepararCursoresParaGl2()
1143:         LOCAL loc_cCabecT, loc_cItensT, loc_oErro
1144:         loc_cCabecT = THIS.this_oBusinessObject.this_cCursorCabec
1145:         loc_cItensT = THIS.this_oBusinessObject.this_cCursorItens
1146:         TRY
1147:             IF USED("TmpCabec")
1148:                 USE IN TmpCabec
1149:             ENDIF
1150:             IF USED(loc_cCabecT)
1151:                 SELECT * FROM (loc_cCabecT) INTO CURSOR TmpCabec READWRITE
1152:                 SELECT TmpCabec
1153:                 INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
1154:                 INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
1155:                 SET ORDER TO TAG Empdopnum
1156:                 GO TOP
1157:             ENDIF
1158: 
1159:             IF USED("TmpItens")
1160:                 USE IN TmpItens
1161:             ENDIF
1162:             IF USED(loc_cItensT)
1163:                 SELECT * FROM (loc_cItensT) INTO CURSOR TmpItens READWRITE
1164:                 SELECT TmpItens
1165:                 INDEX ON Linhas + Cpros TAG LinPro
1166:                 INDEX ON Cpros TAG Cpros
1167:                 INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
1168:                 SET ORDER TO TAG Empdopnum
1169:                 GO TOP
1170:             ENDIF
1171:         CATCH TO loc_oErro
1172:             MsgErro("Erro ao preparar cursores para visualiza" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
1173:         ENDTRY
1174:     ENDPROC
1175: 
1176:     *--------------------------------------------------------------------------
1177:     * CmdCancelarClick - fecha o formulario
1178:     *--------------------------------------------------------------------------
1179:     PROCEDURE CmdCancelarClick()
1180:         THIS.Release()
1181:     ENDPROC
1182: 
1183:     *--------------------------------------------------------------------------
1184:     * FormParaBO - copia todos os campos do formulario para as propriedades do BO
1185:     *--------------------------------------------------------------------------
1186:     PROCEDURE FormParaBO()
1187:         WITH THIS.this_oBusinessObject
1188:             .this_dDataei          = THIS.txt_4c_Dataei.Value
1189:             .this_dDataef          = THIS.txt_4c_Dataef.Value
1190:             .this_dDatapi          = THIS.txt_4c_Datapi.Value
1191:             .this_dDatapf          = THIS.txt_4c_Datapf.Value
1192:             .this_cOperacao        = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1193:             .this_nOperacaoi       = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1194:             .this_nOperacaof       = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
1195:             .this_cGrupoConta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1196:             .this_cConta           = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1197:             .this_cDConta          = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1198:             .this_cGrupoResp       = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1199:             .this_cContaResp       = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1200:             .this_cDContaResp      = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1201:             .this_cCodEmpresa      = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1202:             .this_cDsEmpresa       = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1203:             .this_nNaoEmpenharPedras = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
1204:             .this_cTipoGerOP       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1205:             .this_dPrevisao        = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
1206:             .this_dGeracao         = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
1207:             .this_nNumeroOP        = THIS.cnt_4c_Op.txt_4c_Nop.Value
1208:         ENDWITH
1209:     ENDPROC
1210: 
1211:     *--------------------------------------------------------------------------
1212:     * BOParaForm - popula os campos do formulario a partir das propriedades do BO
1213:     *--------------------------------------------------------------------------
1214:     PROCEDURE BOParaForm()
1215:         LOCAL loc_oErro
1216:         TRY
1217:             WITH THIS.this_oBusinessObject
1218:                 THIS.txt_4c_Dataei.Value = .this_dDataei
1219:                 THIS.txt_4c_Dataef.Value = .this_dDataef
1220:                 THIS.txt_4c_Datapi.Value = .this_dDatapi
1221:                 THIS.txt_4c_Datapf.Value = .this_dDatapf
1222:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
1223:                 THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
1224:                 THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
1225:                 THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
1226:                 THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
1227:                 THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDConta
1228:                 THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
1229:                 THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
1230:                 THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDContaResp
1231:                 THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCodEmpresa
1232:                 THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
1233:                 THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpenharPedras
1234:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTipoGerOP
1235:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
1236:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
1237:                 THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNumeroOP
1238:             ENDWITH
1239:         CATCH TO loc_oErro
1240:             MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
1241:         ENDTRY
1242:     ENDPROC
1243: 
1244:     *--------------------------------------------------------------------------
1245:     * AlternarPagina - alterna estado visual entre "ENTRADA" e "PROCESSANDO"
1246:     *--------------------------------------------------------------------------
1247:     PROCEDURE AlternarPagina(par_cModo)
1248:         LOCAL loc_cModo, loc_lEditar
1249:         loc_cModo   = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
1250:         loc_lEditar = (loc_cModo = "ENTRADA")
1251: 
1252:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1253:             THIS.cmd_4c_Processar.Enabled = loc_lEditar
1254:         ENDIF
1255:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1256:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)
1257:         ENDIF
1258:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1259:             THIS.cnt_4c_Operacao.Enabled = loc_lEditar
1260:         ENDIF
1261:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1262:             THIS.cnt_4c_Conta.Enabled = loc_lEditar
1263:         ENDIF
1264:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1265:             THIS.cnt_4c_Responsavel.Enabled = loc_lEditar
1266:         ENDIF
1267:         IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
1268:             THIS.cnt_4c_Empresa.Enabled = (loc_lEditar AND THIS.this_lAlterEmp)
1269:         ENDIF
1270:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1271:             THIS.cnt_4c_Previsao.Enabled = (loc_lEditar AND NOT THIS.this_lReserva)
1272:         ENDIF
1273:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1274:             THIS.cnt_4c_Op.Enabled = loc_lEditar
1275:         ENDIF
1276:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1277:             THIS.txt_4c_Dataei.Enabled = loc_lEditar
1278:         ENDIF
1279:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1280:             THIS.txt_4c_Dataef.Enabled = loc_lEditar
1281:         ENDIF
1282:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1283:             THIS.txt_4c_Datapi.Enabled = loc_lEditar
1284:         ENDIF
1285:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1286:             THIS.txt_4c_Datapf.Enabled = loc_lEditar
1287:         ENDIF
1288:     ENDPROC
1289: 
1290:     *--------------------------------------------------------------------------
1291:     * LimparCampos - limpa todos os campos de filtro do formulario
1292:     *--------------------------------------------------------------------------
1293:     PROCEDURE LimparCampos()
1294:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1295:             THIS.txt_4c_Dataei.Value = {}
1296:         ENDIF
1297:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1298:             THIS.txt_4c_Dataef.Value = {}
1299:         ENDIF
1300:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1301:             THIS.txt_4c_Datapi.Value = {}
1302:         ENDIF
1303:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1304:             THIS.txt_4c_Datapf.Value = {}
1305:         ENDIF
1306:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1307:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1308:         ENDIF
1309:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1310:             THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
1311:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1312:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1313:         ENDIF
1314:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1315:             THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ""
1316:             THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1317:             THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1318:         ENDIF
1319:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1320:             THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = ""
1321:             THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1322:             THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1323:         ENDIF
1324:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1325:             THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = {}
1326:             THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = {}
1327:         ENDIF
1328:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1329:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1330:         ENDIF
1331:     ENDPROC
1332: 
1333:     *--------------------------------------------------------------------------
1334:     * TxtTpGOpKeyPress - lookup tipo de OP (cursor_4c_CrTmpTpGopT - VFP local)
1335:     *--------------------------------------------------------------------------
1336:     PROCEDURE TxtTpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1337:         LOCAL loc_cVal, loc_oBusca
1338:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1339:             RETURN
1340:         ENDIF
1341:         IF NOT THIS.cnt_4c_TipoOp.Enabled
1342:             RETURN
1343:         ENDIF
1344:         loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1345:         *-- Tentar SEEK direto antes de abrir picker
1346:         IF NOT EMPTY(loc_cVal) AND USED("cursor_4c_CrTmpTpGopT")
1347:             SELECT cursor_4c_CrTmpTpGopT
1348:             IF SEEK(loc_cVal, "cursor_4c_CrTmpTpGopT", "Codigos")
1349:                 RETURN
1350:             ENDIF
1351:         ENDIF
1352:         IF NOT USED("cursor_4c_CrTmpTpGopT")
1353:             MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.")
1354:             RETURN
1355:         ENDIF
1356:         IF USED("cursor_4c_TpGOpT")
1357:             USE IN cursor_4c_TpGOpT
1358:         ENDIF
1359:         SELECT Codigos, Descs FROM cursor_4c_CrTmpTpGopT INTO CURSOR cursor_4c_TpGOpT READWRITE
1360:         SELECT cursor_4c_TpGOpT
1361:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1362:         IF VARTYPE(loc_oBusca) = "O"
1363:             WITH loc_oBusca
1364:                 .this_cCursorDestino = "cursor_4c_TpGOpT"
1365:                 .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
1366:                 .this_cCampoBusca    = "Codigos"
1367:                 .this_cValorBusca    = loc_cVal
1368:                 .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1369:                 .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1370:                 .Show()
1371:                 IF .this_lSelecionou
1372:                     SELECT cursor_4c_TpGOpT
1373:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOpT.Codigos)
1374:                 ELSE
1375:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1376:                 ENDIF
1377:             ENDWITH
1378:             loc_oBusca = .NULL.
1379:         ENDIF
1380:     ENDPROC
1381: 
1382:     *--------------------------------------------------------------------------
1383:     * TxtOperacaoKeyPress - lookup operacao (cursor_4c_TmpOperT - VFP local)
1384:     *--------------------------------------------------------------------------
1385:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1386:         LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
1387:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1388:             RETURN
1389:         ENDIF
1390:         loc_cVal = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1391:         *-- Vazio: limpar faixa inicial/final
1392:         IF EMPTY(loc_cVal)
1393:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1394:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1395:             RETURN
1396:         ENDIF
1397:         IF NOT USED("cursor_4c_TmpOperT")
1398:             MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas.")
1399:             RETURN
1400:         ENDIF
1401:         IF USED("cursor_4c_OperT")
1402:             USE IN cursor_4c_OperT
1403:         ENDIF
1404:         IF THIS.this_lGerPorTp
1405:             loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1406:             SELECT Dopes, NDopes FROM cursor_4c_TmpOperT ;
1407:                 WHERE CodTgOps = m.loc_cTpGOp ;
1408:                 INTO CURSOR cursor_4c_OperT READWRITE
1409:         ELSE
1410:             SELECT Dopes, NDopes FROM cursor_4c_TmpOperT INTO CURSOR cursor_4c_OperT READWRITE
1411:         ENDIF
1412:         SELECT cursor_4c_OperT
1413:         INDEX ON Dopes TAG Dopes
1414:         *-- Tentar SEEK direto
1415:         IF SEEK(loc_cVal, "cursor_4c_OperT", "Dopes")
1416:             RETURN
1417:         ENDIF
1418:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1419:         IF VARTYPE(loc_oBusca) = "O"
1420:             WITH loc_oBusca
1421:                 .this_cCursorDestino = "cursor_4c_OperT"
1422:                 .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
1423:                 .this_cCampoBusca    = "Dopes"
1424:                 .this_cValorBusca    = loc_cVal
1425:                 .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
1426:                 .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
1427:                 .Show()
1428:                 IF .this_lSelecionou
1429:                     SELECT cursor_4c_OperT
1430:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_OperT.Dopes)
1431:                 ELSE
1432:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
1433:                     THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1434:                     THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1435:                 ENDIF
1436:             ENDWITH
1437:             loc_oBusca = .NULL.
1438:         ENDIF
1439:     ENDPROC
1440: 
1441:     *--------------------------------------------------------------------------
1442:     * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
1443:     *--------------------------------------------------------------------------
1444:     PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1445:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1446:             RETURN
1447:         ENDIF
1448:         IF THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value > 0 AND ;
1449:            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1450:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1451:         ENDIF
1452:     ENDPROC
1453: 
1454:     *--------------------------------------------------------------------------
1455:     * TxtGrupoContaKeyPress - lookup grupo contabil (SigCdGcr) para Movimentacao
1456:     *--------------------------------------------------------------------------
1457:     PROCEDURE TxtGrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1458:         LOCAL loc_cVal, loc_oBusca
1459:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1460:             RETURN
1461:         ENDIF
1462:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1463:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1464:             "cursor_4c_GrpContaT", "codigos", loc_cVal, ;
1465:             "Grupos Cont" + CHR(225) + "beis", .F., .T., "")
1466:         IF VARTYPE(loc_oBusca) = "O"
1467:             WITH loc_oBusca
1468:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1469:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1470:                 .Show()
1471:                 IF .this_lSelecionou
1472:                     SELECT cursor_4c_GrpContaT
1473:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpContaT.codigos)
1474:                 ELSE
1475:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
1476:                 ENDIF
1477:             ENDWITH
1478:             loc_oBusca = .NULL.
1479:         ENDIF
1480:     ENDPROC
1481: 
1482:     *--------------------------------------------------------------------------
1483:     * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
1484:     *--------------------------------------------------------------------------
1485:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1486:         LOCAL loc_cVal, loc_oBusca
1487:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1488:             RETURN
1489:         ENDIF
1490:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1491:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1492:             "cursor_4c_CliContaT", "IClis", loc_cVal, ;
1493:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o", .F., .T., "")
1494:         IF VARTYPE(loc_oBusca) = "O"
1495:             WITH loc_oBusca
1496:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1497:                 .mAddColuna("RClis", "                                        ", "Nome")
1498:                 .Show()
1499:                 IF .this_lSelecionou
1500:                     SELECT cursor_4c_CliContaT
1501:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliContaT.IClis)
1502:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliContaT.RClis)
1503:                 ELSE
1504:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1505:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1506:                 ENDIF
1507:             ENDWITH
1508:             loc_oBusca = .NULL.
1509:         ENDIF
1510:     ENDPROC
1511: 
1512:     *--------------------------------------------------------------------------
1513:     * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
1514:     *--------------------------------------------------------------------------
1515:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1516:         LOCAL loc_cVal, loc_oBusca
1517:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1518:             RETURN
1519:         ENDIF
1520:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value))
1521:             RETURN
1522:         ENDIF
1523:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1524:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1525:             "cursor_4c_CliDcontaT", "RClis", loc_cVal, ;
1526:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o (Nome)", .F., .T., "")
1527:         IF VARTYPE(loc_oBusca) = "O"
1528:             WITH loc_oBusca
1529:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1530:                 .mAddColuna("RClis", "                                        ", "Nome")
1531:                 .Show()
1532:                 IF .this_lSelecionou
1533:                     SELECT cursor_4c_CliDcontaT
1534:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDcontaT.IClis)
1535:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDcontaT.RClis)
1536:                 ELSE
1537:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1538:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1539:                 ENDIF
1540:             ENDWITH
1541:             loc_oBusca = .NULL.
1542:         ENDIF
1543:     ENDPROC
1544: 
1545:     *--------------------------------------------------------------------------
1546:     * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
1547:     *--------------------------------------------------------------------------
1548:     PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1549:         LOCAL loc_cVal, loc_oBusca
1550:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1551:             RETURN
1552:         ENDIF
1553:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1554:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1555:             "cursor_4c_GrpRespT", "codigos", loc_cVal, ;
1556:             "Grupos - Vendedor", .F., .T., "")
1557:         IF VARTYPE(loc_oBusca) = "O"
1558:             WITH loc_oBusca
1559:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1560:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1561:                 .Show()
1562:                 IF .this_lSelecionou
1563:                     SELECT cursor_4c_GrpRespT
1564:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpRespT.codigos)
1565:                 ELSE
1566:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
1567:                 ENDIF
1568:             ENDWITH
1569:             loc_oBusca = .NULL.
1570:         ENDIF
1571:     ENDPROC
1572: 
1573:     *--------------------------------------------------------------------------
1574:     * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
1575:     *--------------------------------------------------------------------------
1576:     PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1577:         LOCAL loc_cVal, loc_oBusca
1578:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1579:             RETURN
1580:         ENDIF
1581:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1582:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1583:             "cursor_4c_CliRespT", "IClis", loc_cVal, ;
1584:             "Clientes - Vendedor", .F., .T., "")
1585:         IF VARTYPE(loc_oBusca) = "O"
1586:             WITH loc_oBusca
1587:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1588:                 .mAddColuna("RClis", "                                        ", "Nome")
1589:                 .Show()
1590:                 IF .this_lSelecionou
1591:                     SELECT cursor_4c_CliRespT
1592:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliRespT.IClis)
1593:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliRespT.RClis)
1594:                 ELSE
1595:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1596:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1597:                 ENDIF
1598:             ENDWITH
1599:             loc_oBusca = .NULL.
1600:         ENDIF
1601:     ENDPROC
1602: 
1603:     *--------------------------------------------------------------------------
1604:     * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
1605:     *--------------------------------------------------------------------------
1606:     PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1607:         LOCAL loc_cVal, loc_oBusca
1608:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1609:             RETURN
1610:         ENDIF
1611:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value))
1612:             RETURN
1613:         ENDIF
1614:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1615:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1616:             "cursor_4c_CliDcontaRespT", "RClis", loc_cVal, ;
1617:             "Clientes - Vendedor (Nome)", .F., .T., "")
1618:         IF VARTYPE(loc_oBusca) = "O"
1619:             WITH loc_oBusca
1620:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1621:                 .mAddColuna("RClis", "                                        ", "Nome")
1622:                 .Show()
1623:                 IF .this_lSelecionou
1624:                     SELECT cursor_4c_CliDcontaRespT
1625:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaRespT.IClis)
1626:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaRespT.RClis)
1627:                 ELSE
1628:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1629:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1630:                 ENDIF
1631:             ENDWITH
1632:             loc_oBusca = .NULL.
1633:         ENDIF
1634:     ENDPROC
1635: 
1636:     *--------------------------------------------------------------------------
1637:     * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
1638:     * Apenas se AlterEmp = .T.
1639:     *--------------------------------------------------------------------------
1640:     PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1641:         LOCAL loc_cVal, loc_oBusca
1642:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1643:             RETURN
1644:         ENDIF
1645:         IF NOT THIS.this_lAlterEmp
1646:             RETURN
1647:         ENDIF
1648:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1649:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1650:             "cursor_4c_EmpT", "Cemps", loc_cVal, ;
1651:             "Empresas", .F., .T., "")
1652:         IF VARTYPE(loc_oBusca) = "O"
1653:             WITH loc_oBusca
1654:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1655:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1656:                 .Show()
1657:                 IF .this_lSelecionou
1658:                     SELECT cursor_4c_EmpT
1659:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpT.Cemps)
1660:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpT.Razas)
1661:                 ELSE
1662:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1663:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1664:                 ENDIF
1665:             ENDWITH
1666:             loc_oBusca = .NULL.
1667:         ENDIF
1668:     ENDPROC
1669: 
1670:     *--------------------------------------------------------------------------
1671:     * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
1672:     * Apenas se AlterEmp = .T. e CdEmpresa vazio
1673:     *--------------------------------------------------------------------------
1674:     PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1675:         LOCAL loc_cVal, loc_oBusca
1676:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1677:             RETURN
1678:         ENDIF
1679:         IF NOT THIS.this_lAlterEmp
1680:             RETURN
1681:         ENDIF
1682:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value))
1683:             RETURN
1684:         ENDIF
1685:         loc_cVal   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1686:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1687:             "cursor_4c_EmpDsT", "Razas", loc_cVal, ;
1688:             "Empresas (Raz" + CHR(227) + "o Social)", .F., .T., "")
1689:         IF VARTYPE(loc_oBusca) = "O"
1690:             WITH loc_oBusca
1691:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1692:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1693:                 .Show()
1694:                 IF .this_lSelecionou
1695:                     SELECT cursor_4c_EmpDsT
1696:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDsT.Cemps)
1697:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDsT.Razas)
1698:                 ELSE
1699:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1700:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1701:                 ENDIF
1702:             ENDWITH
1703:             loc_oBusca = .NULL.
1704:         ENDIF
1705:     ENDPROC
1706: 
1707:     *--------------------------------------------------------------------------
1708:     * TxtNopKeyPress - valida numero de OP (nao pode ja existir em SigOpPic)
1709:     *--------------------------------------------------------------------------
1710:     PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1711:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1712:             RETURN
1713:         ENDIF
1714:         IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1715:             RETURN
1716:         ENDIF
1717:         IF THIS.this_oBusinessObject.VerificarNumeroOP(THIS.cnt_4c_Op.txt_4c_Nop.Value)
1718:             MsgAviso("N" + CHR(250) + "mero de OP j" + CHR(225) + " existe. Favor Corrigir!!!")
1719:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1720:         ENDIF
1721:     ENDPROC
1722: 
1723:     *--------------------------------------------------------------------------
1724:     * CarregarLista - compatibilidade FormBase (OPERACIONAL nao tem grid de lista)
1725:     *--------------------------------------------------------------------------
1726:     PROCEDURE CarregarLista()
1727:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1728:             THIS.PopularCamposIniciais()
1729:         ENDIF
1730:     ENDPROC
1731: 
1732:     *--------------------------------------------------------------------------
1733:     * AjustarBotoesPorModo - compatibilidade FormBase
1734:     *--------------------------------------------------------------------------
1735:     PROCEDURE AjustarBotoesPorModo()
1736:         THIS.AlternarPagina("ENTRADA")
1737:     ENDPROC
1738: 
1739:     *-- Stubs de compatibilidade com FormBase (OPERACIONAL nao tem CRUD)
1740:     PROCEDURE BtnIncluirClick()
1741:         THIS.CmdProcessarClick()
1742:     ENDPROC
1743: 
1744:     PROCEDURE BtnAlterarClick()
1745:         THIS.AlternarPagina("ENTRADA")
1746:     ENDPROC
1747: 
1748:     PROCEDURE BtnVisualizarClick()
1749:         THIS.AlternarPagina("ENTRADA")
1750:         THIS.PopularCamposIniciais()
1751:     ENDPROC
1752: 
1753:     PROCEDURE BtnExcluirClick()
1754:         THIS.CmdCancelarClick()
1755:     ENDPROC
1756: 
1757:     PROCEDURE BtnEncerrarClick()
1758:         THIS.CmdCancelarClick()
1759:     ENDPROC
1760: 
1761:     PROCEDURE BtnBuscarClick()
1762:         THIS.LimparCampos()
1763:         THIS.PopularCamposIniciais()
1764:         THIS.AlternarPagina("ENTRADA")
1765:     ENDPROC
1766: 
1767:     PROCEDURE BtnSalvarClick()
1768:         THIS.CmdProcessarClick()
1769:     ENDPROC
1770: 
1771:     PROCEDURE BtnCancelarClick()
1772:         THIS.AlternarPagina("ENTRADA")
1773:         THIS.LimparCampos()
1774:         THIS.PopularCamposIniciais()
1775:     ENDPROC
1776: 
1777: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGloTBO.prg):
*==============================================================================
* SigPrGloTBO.prg - Business Object para Processamento de O.P. por Totais
* Form OPERACIONAL: processa SigMvCab por totais e gera entradas em SigOpPic
* Variante de SigPrGloBO - mesmo esquema de dados, processamento por totais
*==============================================================================

DEFINE CLASS SigPrGloTBO AS BusinessBase

    *-- Tabela alvo de persistencia (Ordem de Producao gerada)
    this_cTabela      = "SigOpPic"
    this_cCampoChave  = "Cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades de SigOpPic (registro individual da OP para CRUD)
    *--------------------------------------------------------------------------
    this_cCidChaves   = ""
    this_cEmps        = ""
    this_cDopes       = ""
    this_cDopps       = ""
    this_nNumes       = 0
    this_nNumps       = 0
    this_nNops        = 0
    this_cCpros       = ""
    this_cDpros       = ""
    this_nQtds        = 0
    this_dDataes      = {}
    this_dDataps      = {}
    this_dDataTrans   = {}
    this_dDtGeras     = {}
    this_dDtFunds     = {}
    this_cLocals      = ""
    this_nNtrans      = 0
    this_cEmpDs       = ""
    this_nSeqDivs     = 0
    this_cCodCors     = ""
    this_cCodTams     = ""
    this_lDivs        = .F.
    this_lImprs       = .F.
    this_lIimprs      = .F.
    this_cUsuars      = ""
    this_nNopMaes     = 0
    this_nPesos       = 0
    this_nCodBarras   = 0
    this_nQtdCpnts    = 0
    this_nQtdTubos    = 0
    this_cMoedas      = ""
    this_nUnits       = 0
    this_nNfunds      = 0
    this_cEmpDnps     = ""
    this_cEmpDopnops  = ""
    this_cEmpDopnums  = ""
    this_cNotas       = ""
    this_cCodTgOps    = ""
    this_nCitens      = 0
    this_cObss        = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Periodo de Emissao
    *--------------------------------------------------------------------------
    this_dDataei    = {}
    this_dDataef    = {}

    *-- Periodo de Previsao de Entrega
    this_dDatapi    = {}
    this_dDatapf    = {}

    *-- Previsao de Entrega e Data de Geracao
    this_dPrevisao  = {}
    this_dGeracao   = {}

    *--------------------------------------------------------------------------
    * Parametros de filtro - Operacao
    *--------------------------------------------------------------------------
    this_cOperacao   = ""
    this_nOperacaoi  = 0
    this_nOperacaof  = 0

    *--------------------------------------------------------------------------
    * Parametros de filtro - Conta (cliente)
    *--------------------------------------------------------------------------
    this_cGrupoConta = ""
    this_cConta      = ""
    this_cDConta     = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Responsavel/Vendedor
    *--------------------------------------------------------------------------
    this_cGrupoResp  = ""
    this_cContaResp  = ""
    this_cDContaResp = ""

    *--------------------------------------------------------------------------
    * Parametros de filtro - Empresa
    *--------------------------------------------------------------------------
    this_cCodEmpresa = ""
    this_cDsEmpresa  = ""

    *-- Checkbox "Nao Empenhar Pedras" (0=empenhar, 1=nao empenhar)
    this_nNaoEmpenharPedras = 0

    *--------------------------------------------------------------------------
    * Parametros de filtro - Numero da OP e Tipo de Geracao
    *--------------------------------------------------------------------------
    this_nNumeroOP  = 0
    this_cTipoGerOP = ""

    *--------------------------------------------------------------------------
    * Propriedades de modo de execucao
    *--------------------------------------------------------------------------
    this_lReserva    = .F.
    this_lAutomatico = .F.
    this_lPorDestino = .F.
    this_lGerPorTp   = .F.
    this_lAlterEmp   = .T.

    *--------------------------------------------------------------------------
    * Cursores internos de trabalho
    *--------------------------------------------------------------------------
    this_cCursorOper    = "cursor_4c_TmpOperT"
    this_cCursorTiposGO = "cursor_4c_CrTmpTpGopT"
    this_cCursorParam   = "cursor_4c_CrSigCdPamT"
    this_cCursorCabec   = "cursor_4c_TmpCabecT"
    this_cCursorItens   = "cursor_4c_TmpItensT"

    *==========================================================================
    * Init - configura tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigOpPic"
            THIS.this_cCampoChave = "Cidchaves"
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - retorna Cidchaves (PK de SigOpPic) para auditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidChaves)
    ENDPROC

    *==========================================================================
    * MontarCidChaves - Gera Cidchaves = Emps + Dopes + Numps (padrao SigOpPic)
    *==========================================================================
    PROTECTED PROCEDURE MontarCidChaves()
        LOCAL loc_cResultado
        loc_cResultado = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                         PADR(ALLTRIM(THIS.this_cDopes), 6) + ;
                         PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
        RETURN LEFT(loc_cResultado, 20)
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades a partir de cursor de SigOpPic
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCidChaves  = TratarNulo(Cidchaves, "C")
                THIS.this_cEmps       = TratarNulo(Emps, "C")
                THIS.this_cDopes      = TratarNulo(Dopes, "C")
                THIS.this_cDopps      = TratarNulo(Dopps, "C")
                THIS.this_nNumes      = TratarNulo(Numes, "N")
                THIS.this_nNumps      = TratarNulo(Numps, "N")
                THIS.this_nNops       = TratarNulo(Nops, "N")
                THIS.this_cCpros      = TratarNulo(Cpros, "C")
                THIS.this_cDpros      = TratarNulo(Dpros, "C")
                THIS.this_nQtds       = TratarNulo(Qtds, "N")
                THIS.this_dDataes     = TratarNulo(Dataes, "D")
                THIS.this_dDataps     = TratarNulo(Dataps, "D")
                THIS.this_dDataTrans  = TratarNulo(DataTrans, "D")
                THIS.this_dDtGeras    = TratarNulo(DtGeras, "D")
                THIS.this_dDtFunds    = TratarNulo(DtFunds, "D")
                THIS.this_cLocals     = TratarNulo(Locals, "C")
                THIS.this_nNtrans     = TratarNulo(Ntrans, "N")
                THIS.this_cEmpDs      = TratarNulo(Empds, "C")
                THIS.this_nSeqDivs    = TratarNulo(SeqDivs, "N")
                THIS.this_cCodCors    = TratarNulo(CodCors, "C")
                THIS.this_cCodTams    = TratarNulo(CodTams, "C")
                IF VARTYPE(Divs) = "L"
                    THIS.this_lDivs = NVL(Divs, .F.)
                ELSE
                    IF VARTYPE(Divs) = "L"
                        THIS.this_lDivs = Divs
                    ELSE
                        THIS.this_lDivs = (NVL(Divs, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(Imprs) = "L"
                    THIS.this_lImprs = NVL(Imprs, .F.)
                ELSE
                    IF VARTYPE(Imprs) = "L"
                        THIS.this_lImprs = Imprs
                    ELSE
                        THIS.this_lImprs = (NVL(Imprs, 0) = 1)
                    ENDIF
                ENDIF
                IF VARTYPE(Iimprs) = "L"
                    THIS.this_lIimprs = NVL(Iimprs, .F.)
                ELSE
                    IF VARTYPE(Iimprs) = "L"
                        THIS.this_lIimprs = Iimprs
                    ELSE
                        THIS.this_lIimprs = (NVL(Iimprs, 0) = 1)
                    ENDIF
                ENDIF
                THIS.this_cUsuars     = TratarNulo(Usuars, "C")
                THIS.this_nNopMaes    = TratarNulo(NopMaes, "N")
                THIS.this_nPesos      = TratarNulo(Pesos, "N")
                THIS.this_nCodBarras  = TratarNulo(CodBarras, "N")
                THIS.this_nQtdCpnts   = TratarNulo(QtdCpnts, "N")
                THIS.this_nQtdTubos   = TratarNulo(QtdTubos, "N")
                THIS.this_cMoedas     = TratarNulo(Moedas, "C")
                THIS.this_nUnits      = TratarNulo(Units, "N")
                THIS.this_nNfunds     = TratarNulo(Nfunds, "N")
                THIS.this_cEmpDnps    = TratarNulo(Empdnps, "C")
                THIS.this_cEmpDopnops = TratarNulo(Empdopnops, "C")
                THIS.this_cEmpDopnums = TratarNulo(Empdopnums, "C")
                THIS.this_cNotas      = TratarNulo(Notas, "C")
                THIS.this_cCodTgOps   = TratarNulo(CodTgOps, "C")
                THIS.this_nCitens     = TratarNulo(Citens, "N")
                IF TYPE(par_cAliasCursor + ".Obss") <> "U"
                    THIS.this_cObss = TratarNulo(Obss, "C")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere um registro na tabela SigOpPic
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cEmps)
                THIS.this_cEmps = go_4c_Sistema.cCodEmpresa
            ENDIF
            IF EMPTY(THIS.this_cUsuars)
                THIS.this_cUsuars = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")
            ENDIF
            IF EMPTY(THIS.this_dDtGeras)
                THIS.this_dDtGeras = DATE()
            ENDIF
            IF EMPTY(THIS.this_cEmpDs)
                THIS.this_cEmpDs = THIS.this_cEmps
            ENDIF
            IF EMPTY(THIS.this_cLocals)
                THIS.this_cLocals = ""
            ENDIF
            IF EMPTY(THIS.this_cDopps)
                THIS.this_cDopps = THIS.this_cDopes
            ENDIF
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cCidChaves = THIS.MontarCidChaves()
            ENDIF
            IF EMPTY(THIS.this_cEmpDopnums)
                THIS.this_cEmpDopnums = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        PADR(ALLTRIM(THIS.this_cDopes), 20) + ;
                                        PADL(ALLTRIM(TRANSFORM(THIS.this_nNumes)), 6, "0")
            ENDIF
            IF EMPTY(THIS.this_cEmpDnps)
                THIS.this_cEmpDnps = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                     PADR(ALLTRIM(THIS.this_cDopps), 20) + ;
                                     PADL(ALLTRIM(TRANSFORM(THIS.this_nNumps)), 10, "0")
            ENDIF
            IF EMPTY(THIS.this_cEmpDopnops)
                THIS.this_cEmpDopnops = PADR(ALLTRIM(THIS.this_cEmps), 3) + ;
                                        PADR(ALLTRIM(THIS.this_cDopes), 20) + ;
                                        PADL(ALLTRIM(TRANSFORM(THIS.this_nNops)), 10, "0")
            ENDIF

            loc_cSQL = "INSERT INTO SigOpPic " + ;
                "(Cidchaves, Emps, Dopes, Dopps, Numes, Numps, Nops, Cpros, Dpros, Qtds, " + ;
                "Dataes, Dataps, DataTrans, DtGeras, DtFunds, Locals, Ntrans, Empds, SeqDivs, " + ;
                "CodCors, CodTams, Divs, Imprs, Iimprs, Usuars, NopMaes, Pesos, CodBarras, " + ;
                "QtdCpnts, QtdTubos, Moedas, Units, Nfunds, Empdnps, Empdopnops, " + ;
                "Empdopnums, Notas, CodTgOps, Citens, Obss) VALUES ("
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                EscaparSQL(THIS.this_cEmps) + ", " + ;
                EscaparSQL(THIS.this_cDopes) + ", " + ;
                EscaparSQL(THIS.this_cDopps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                EscaparSQL(THIS.this_cCpros) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtds, 3) + ", "
            loc_cSQL = loc_cSQL + ;
                FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                FormatarDataSQL(THIS.this_dDataps) + ", " + ;
                FormatarDataSQL(THIS.this_dDataTrans) + ", " + ;
                FormatarDataSQL(THIS.this_dDtGeras) + ", " + ;
                FormatarDataSQL(THIS.this_dDtFunds) + ", " + ;
                EscaparSQL(THIS.this_cLocals) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nSeqDivs, 0) + ", "
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCodCors) + ", " + ;
                EscaparSQL(THIS.this_cCodTams) + ", " + ;
                IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                IIF(THIS.this_lImprs, "1", "0") + ", " + ;
                IIF(THIS.this_lIimprs, "1", "0") + ", " + ;
                EscaparSQL(THIS.this_cUsuars) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNopMaes, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ", "
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nQtdCpnts, 0) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdTubos, 3) + ", " + ;
                EscaparSQL(THIS.this_cMoedas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNfunds, 0) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDnps, 33)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopnops, 33)) + ", " + ;
                EscaparSQL(LEFT(THIS.this_cEmpDopnums, 29)) + ", " + ;
                EscaparSQL(THIS.this_cNotas) + ", " + ;
                EscaparSQL(THIS.this_cCodTgOps) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                EscaparSQL(THIS.this_cObss) + ")"

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                loc_lSucesso = .T.
                THIS.RegistrarAuditoria("INSERT")
            ELSE
                THIS.this_cMensagemErro = "Falha ao inserir Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Inserir OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigOpPic (pela PK Cidchaves)
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave (Cidchaves) obrigat" + CHR(243) + "ria para atualizar."
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "UPDATE SigOpPic SET " + ;
                    "Emps = "      + EscaparSQL(THIS.this_cEmps)  + ", " + ;
                    "Dopes = "     + EscaparSQL(THIS.this_cDopes) + ", " + ;
                    "Dopps = "     + EscaparSQL(THIS.this_cDopps) + ", " + ;
                    "Numes = "     + FormatarNumeroSQL(THIS.this_nNumes, 0) + ", " + ;
                    "Numps = "     + FormatarNumeroSQL(THIS.this_nNumps, 0) + ", " + ;
                    "Nops = "      + FormatarNumeroSQL(THIS.this_nNops, 0) + ", " + ;
                    "Cpros = "     + EscaparSQL(THIS.this_cCpros) + ", " + ;
                    "Dpros = "     + EscaparSQL(LEFT(THIS.this_cDpros, 65)) + ", " + ;
                    "Qtds = "      + FormatarNumeroSQL(THIS.this_nQtds, 3) + ", " + ;
                    "Dataes = "    + FormatarDataSQL(THIS.this_dDataes) + ", " + ;
                    "Dataps = "    + FormatarDataSQL(THIS.this_dDataps) + ", " + ;
                    "DataTrans = " + FormatarDataSQL(THIS.this_dDataTrans) + ", " + ;
                    "DtGeras = "   + FormatarDataSQL(THIS.this_dDtGeras) + ", " + ;
                    "DtFunds = "   + FormatarDataSQL(THIS.this_dDtFunds) + ", " + ;
                    "Locals = "    + EscaparSQL(THIS.this_cLocals) + ", " + ;
                    "Ntrans = "    + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ", " + ;
                    "Empds = "     + EscaparSQL(THIS.this_cEmpDs) + ", " + ;
                    "SeqDivs = "   + FormatarNumeroSQL(THIS.this_nSeqDivs, 0) + ", " + ;
                    "CodCors = "   + EscaparSQL(THIS.this_cCodCors) + ", " + ;
                    "CodTams = "   + EscaparSQL(THIS.this_cCodTams) + ", " + ;
                    "Divs = "      + IIF(THIS.this_lDivs, "1", "0") + ", " + ;
                    "Imprs = "     + IIF(THIS.this_lImprs, "1", "0") + ", " + ;
                    "Iimprs = "    + IIF(THIS.this_lIimprs, "1", "0") + ", " + ;
                    "Usuars = "    + EscaparSQL(THIS.this_cUsuars) + ", " + ;
                    "NopMaes = "   + FormatarNumeroSQL(THIS.this_nNopMaes, 0) + ", " + ;
                    "Pesos = "     + FormatarNumeroSQL(THIS.this_nPesos, 3) + ", " + ;
                    "CodBarras = " + FormatarNumeroSQL(THIS.this_nCodBarras, 0) + ", " + ;
                    "QtdCpnts = "  + FormatarNumeroSQL(THIS.this_nQtdCpnts, 0) + ", " + ;
                    "QtdTubos = "  + FormatarNumeroSQL(THIS.this_nQtdTubos, 3) + ", " + ;
                    "Moedas = "    + EscaparSQL(THIS.this_cMoedas) + ", " + ;
                    "Units = "     + FormatarNumeroSQL(THIS.this_nUnits, 6) + ", " + ;
                    "Nfunds = "    + FormatarNumeroSQL(THIS.this_nNfunds, 0) + ", " + ;
                    "Notas = "     + EscaparSQL(THIS.this_cNotas) + ", " + ;
                    "CodTgOps = "  + EscaparSQL(THIS.this_cCodTgOps) + ", " + ;
                    "Citens = "    + FormatarNumeroSQL(THIS.this_nCitens, 0) + ", " + ;
                    "Obss = "      + EscaparSQL(THIS.this_cObss) + " " + ;
                    "WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("UPDATE")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao atualizar Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Atualizar OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Remove registro de SigOpPic pela PK Cidchaves
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_nRes
        loc_lSucesso = .F.
        TRY
            IF EMPTY(THIS.this_cCidChaves)
                THIS.this_cMensagemErro = "Chave (Cidchaves) obrigat" + CHR(243) + "ria para excluir."
                loc_lSucesso = .F.
            ELSE
                loc_cSQL = "DELETE FROM SigOpPic WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidChaves)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    loc_lSucesso = .T.
                    THIS.RegistrarAuditoria("DELETE")
                ELSE
                    THIS.this_cMensagemErro = "Falha ao excluir Ordem de Produ" + CHR(231) + CHR(227) + "o em SigOpPic."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Excluir OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorChave - Carrega um registro de SigOpPic pela PK Cidchaves
    *==========================================================================
    PROCEDURE CarregarPorChave(par_cCidChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = "cursor_4c_CarregaOpT"
        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF
            loc_cSQL = "SELECT * FROM SigOpPic WHERE Cidchaves = " + EscaparSQL(par_cCidChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, loc_cCursor) < 1
                THIS.this_cMensagemErro = "Falha ao carregar registro de SigOpPic."
            ELSE
                IF RECCOUNT(loc_cCursor) > 0
                    loc_lSucesso = THIS.CarregarDoCursor(loc_cCursor)
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado em SigOpPic."
                ENDIF
                USE IN (loc_cCursor)
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro ao Carregar OP")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarOperacoes - Carrega cursor de operacoes validas (cursor_4c_TmpOperT)
    * Retorna .T. se encontrou ao menos uma operacao configurada
    *==========================================================================
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOper)
                USE IN (THIS.this_cCursorOper)
            ENDIF

            loc_cSQL = "SELECT ISNULL(b.OpeGops, ' ') AS OpeGops, " + ;
                       "ISNULL(b.CodTgOps, ' ') AS CodTgOps, " + ;
                       "a.Dopes, a.NDopes, a.Globalizas, a.Reservas, a.Opers, " + ;
                       "0 AS Acesso, b.chkObs, c.carcompos " + ;
                       "FROM SigCdOpe a " + ;
                       "LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                       "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                       "WHERE a.Globalizas IN (1, 2)"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorOper) < 1
                MsgErro("Falha ao carregar Opera" + CHR(231) + CHR(245) + "es.", "Erro")
            ELSE
                SELECT (THIS.this_cCursorOper)
                INDEX ON Dopes TAG Dopes
                GO TOP
                IF EOF()
                    MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar Ordem de Produ" + CHR(231) + CHR(227) + "o!!!")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarTiposGeracao - Carrega cursor de tipos de geracao de OP
    * Resultado em cursor_4c_CrTmpTpGopT
    *==========================================================================
    PROCEDURE CarregarTiposGeracao()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorTiposGO)
                USE IN (THIS.this_cCursorTiposGO)
            ENDIF
            IF USED("cursor_4c_TmpTpGopT_raw")
                USE IN cursor_4c_TmpTpGopT_raw
            ENDIF

            loc_cSQL = "SELECT 1 AS Acesso, * FROM SigInTgo"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTpGopT_raw") < 1
                MsgErro("Falha ao carregar Tipos de Gera" + CHR(231) + CHR(227) + "o.", "Erro")
            ELSE
                SELECT * FROM cursor_4c_TmpTpGopT_raw ;
                    WHERE Acesso = 1 ;
                    INTO CURSOR (THIS.this_cCursorTiposGO) READWRITE
                USE IN cursor_4c_TmpTpGopT_raw

                SELECT (THIS.this_cCursorTiposGO)
                INDEX ON Codigos TAG Codigos
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarParametros - Carrega parametros do sistema de SigCdPam
    * Resultado em cursor_4c_CrSigCdPamT
    *==========================================================================
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampos
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorParam)
                USE IN (THIS.this_cCursorParam)
            ENDIF

            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, " + ;
                          "DoppPads, DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, " + ;
                          "GruReservs, ConReservs, AgrupEmph, DoppServs, mascnums, GruEstps, " + ;
                          "ConEstps, transfencs, Ouros, GruConfs, ConConfs, " + ;
                          "GlobAutos, DopEntAus, TpOpEntAus, AutComps"

            loc_cSQL = "SELECT TOP 1 " + loc_cCampos + " FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorParam) < 1
                MsgErro("Falha ao carregar Par" + CHR(226) + "metros (SigCdPam).", "Erro")
            ELSE
                IF RECCOUNT(THIS.this_cCursorParam) = 0
                    MsgErro("Par" + CHR(226) + "metros do sistema n" + CHR(227) + "o configurados (SigCdPam vazio).", "Erro")
                ELSE
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPacotes - Carrega SigCdPac (configuracoes de pacote)
    * Resultado em cursor_4c_CrSigCdPacT
    *==========================================================================
    PROCEDURE CarregarPacotes()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_CrSigCdPacT")
                USE IN cursor_4c_CrSigCdPacT
            ENDIF
            loc_cSQL = "SELECT * FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CrSigCdPacT") < 1
                MsgErro("Falha ao carregar SigCdPac.", "Erro")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida parametros obrigatorios antes do processamento
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.
        TRY
            IF !THIS.this_lReserva
                IF EMPTY(THIS.this_dPrevisao)
                    MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!")
                    loc_lValido = .F.
                ENDIF
                IF loc_lValido AND !THIS.this_lAutomatico AND EMPTY(THIS.this_dGeracao)
                    MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido AND !EMPTY(THIS.this_dDataef)
                IF !EMPTY(THIS.this_dDataei) AND THIS.this_dDataef < THIS.this_dDataei
                    MsgAviso("A Data Final de Emiss" + CHR(227) + "o Deve Ser Maior Que a Inicial!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
            IF loc_lValido AND !EMPTY(THIS.this_dDatapf)
                IF !EMPTY(THIS.this_dDatapi) AND THIS.this_dDatapf < THIS.this_dDatapi
                    MsgAviso("A Data Final de Previs" + CHR(227) + "o de Entrega Deve Ser Maior Que a Inicial!!!")
                    loc_lValido = .F.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lValido = .F.
        ENDTRY
        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarNumeroOP - Verifica se numero de OP ja existe em SigOpPic
    * Retorna .T. se o numero JA existe (impede uso)
    *==========================================================================
    PROCEDURE VerificarNumeroOP(par_nNumeroOP)
        LOCAL loc_lExiste, loc_cSQL
        loc_lExiste = .F.
        TRY
            IF par_nNumeroOP > 0
                loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + FormatarNumeroSQL(par_nNumeroOP, 0)
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpiT") >= 1
                    loc_lExiste = (RECCOUNT("cursor_4c_TmpOpiT") > 0)
                ENDIF
                IF USED("cursor_4c_TmpOpiT")
                    USE IN cursor_4c_TmpOpiT
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * ProcessarOP - Processa ordens de producao por totais conforme parametros
    * Popula cursor_4c_TmpCabecT e cursor_4c_TmpItensT para visualizacao
    * Retorna .T. se encontrou registros para processar
    * Difere de SigPrGloBO.ProcessarOP: agrupa itens por produto (totalizacao)
    *==========================================================================
    PROCEDURE ProcessarOP()
        LOCAL loc_lSucesso, loc_lAbort, loc_cSQL
        LOCAL loc_cConde, loc_cCondp, loc_cDopp, loc_cLcEmp, loc_cTpGOp
        LOCAL loc_cOperacao, loc_nOperacaoi, loc_nOperacaof
        LOCAL loc_cGrupo, loc_cConta, loc_cGrupoV, loc_cContaV
        LOCAL loc_nOpZers, loc_nEntPes
        LOCAL loc_cDopes, loc_nGlobalizas, loc_cOpers, loc_cOpeGops, loc_nCarCompos
        LOCAL loc_cCodTgOps
        LOCAL loc_lBrk1

        loc_lSucesso = .F.
        loc_lAbort   = .F.
        TRY
            *-- Verificar pre-requisitos
            IF !USED(THIS.this_cCursorOper)
                MsgErro("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas. Execute CarregarOperacoes() antes.", "Erro")
                loc_lAbort = .T.
            ENDIF
            IF !loc_lAbort AND !USED(THIS.this_cCursorParam)
                MsgErro("Par" + CHR(226) + "metros n" + CHR(227) + "o carregados. Execute CarregarParametros() antes.", "Erro")
                loc_lAbort = .T.
            ENDIF

            IF !loc_lAbort
                *-- Fechar cursores de saida anteriores
                IF USED(THIS.this_cCursorCabec)
                    USE IN (THIS.this_cCursorCabec)
                ENDIF
                IF USED(THIS.this_cCursorItens)
                    USE IN (THIS.this_cCursorItens)
                ENDIF
                IF USED("cursor_4c_DbParamT")
                    USE IN cursor_4c_DbParamT
                ENDIF
                IF USED("cursor_4c_TotaisTemp")
                    USE IN cursor_4c_TotaisTemp
                ENDIF

                *-- Copiar parametros para variaveis locais
                loc_cOperacao  = ALLTRIM(THIS.this_cOperacao)
                loc_nOperacaoi = THIS.this_nOperacaoi
                loc_nOperacaof = THIS.this_nOperacaof
                loc_cGrupo     = ALLTRIM(THIS.this_cGrupoConta)
                loc_cConta     = ALLTRIM(THIS.this_cConta)
                loc_cGrupoV    = ALLTRIM(THIS.this_cGrupoResp)
                loc_cContaV    = ALLTRIM(THIS.this_cContaResp)
                loc_cTpGOp     = ALLTRIM(THIS.this_cTipoGerOP)
                loc_cLcEmp     = IIF(EMPTY(THIS.this_cCodEmpresa), go_4c_Sistema.cCodEmpresa, ALLTRIM(THIS.this_cCodEmpresa))

                *-- Preparar DbParam
                loc_nOpZers = 0
                loc_nEntPes = 0
                IF THIS.this_lGerPorTp AND USED(THIS.this_cCursorTiposGO)
                    IF SEEK(loc_cTpGOp, THIS.this_cCursorTiposGO, "Codigos")
                        SELECT (THIS.this_cCursorTiposGO)
                        loc_nOpZers = NVL(OpZers, 0)
                        loc_nEntPes = NVL(EntPes, 0)
                    ENDIF
                ELSE
                    IF USED("cursor_4c_CrSigCdPacT")
                        SELECT cursor_4c_CrSigCdPacT
                        GO TOP
                        IF !EOF()
                            loc_nOpZers = NVL(OpZers, 0)
                        ENDIF
                    ENDIF
                ENDIF

                SET NULL ON
                CREATE CURSOR cursor_4c_DbParamT (CodTgOps C(10) NULL, OpZers N(1) NULL, EntPes N(1) NULL)
                INSERT INTO cursor_4c_DbParamT (CodTgOps, OpZers, EntPes) VALUES (loc_cTpGOp, loc_nOpZers, loc_nEntPes)
                SET NULL OFF

                *-- Construir condicao de data de emissao
                IF EMPTY(THIS.this_dDataef)
                    loc_cConde = ""
                ELSE
                    IF !EMPTY(THIS.this_dDataei)
                        loc_cConde = "Datas >= " + FormatarDataSQL(THIS.this_dDataei) + ;
                                     " AND Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDataef) + ") AND "
                    ELSE
                        loc_cConde = "Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDataef) + ") AND "
                    ENDIF
                ENDIF

                *-- Construir condicao de data de previsao de entrega
                IF EMPTY(THIS.this_dDatapi)
                    IF EMPTY(THIS.this_dDatapf)
                        loc_cCondp = ""
                    ELSE
                        loc_cCondp = "PrazoEnts < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDatapf) + ") AND "
                    ENDIF
                ELSE
                    IF EMPTY(THIS.this_dDatapf)
                        loc_cCondp = "PrazoEnts >= " + FormatarDataSQL(THIS.this_dDatapi) + " AND "
                    ELSE
                        loc_cCondp = "PrazoEnts >= " + FormatarDataSQL(THIS.this_dDatapi) + ;
                                     " AND PrazoEnts < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dDatapf) + ") AND "
                    ENDIF
                ENDIF

                *-- Cursor de totais por produto (diferencial da versao Totais)
                SET NULL ON
                CREATE CURSOR cursor_4c_TotaisTemp ;
                    (Dopes C(20) NULL, CPros C(14) NULL, Dpros C(40) NULL, ;
                     Linhas C(10) NULL, TotalQtds N(12,3) NULL, TotalPeso N(12,2) NULL, ;
                     Emps C(3) NULL)
                SET NULL OFF
                INDEX ON Dopes + CPros TAG DopesPro

                *-- Criar cursor de cabecalhos por operacao (agrupado/totalizado)
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorCabec) ;
                    (Flag L NULL, Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, ;
                     Grupo C(10) NULL, Conta C(10) NULL, Datas D NULL, Entregas D NULL, ;
                     Grupov C(10) NULL, Contav C(10) NULL, Obs M NULL, Peso N(12,2) NULL, ;
                     GrupoDs C(10) NULL, ContaDs C(10) NULL, DConta C(40) NULL, ;
                     Notas C(6) NULL, Jobs C(10) NULL)
                SET NULL OFF
                INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes, 6) TAG Entrega
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
                SET ORDER TO TAG Empdopnum

                *-- Criar cursor de itens totalizados por produto
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorItens) ;
                    (Emps C(3) NULL, Dopes C(20) NULL, Numes N(6) NULL, CPros C(14) NULL, ;
                     Qtds N(12,3) NULL, Saldo N(12,3) NULL, Peso N(9,3) NULL, Obs M NULL, ;
                     Linhas C(10) NULL, CodCors C(4) NULL, CodTams C(4) NULL, ;
                     Citens N(10) NULL, Notas C(6) NULL, dpros C(40) NULL, Reffs C(40) NULL)
                SET NULL OFF
                INDEX ON Linhas + Cpros TAG LinPro
                INDEX ON Cpros TAG Cpros
                INDEX ON Emps + Dopes + STR(Numes, 6) TAG Empdopnum
                SET ORDER TO TAG Empdopnum

                *-- Loop principal: percorre cada operacao
                SELECT (THIS.this_cCursorOper)
                SET ORDER TO TAG Dopes
                IF !EMPTY(loc_cOperacao)
                    SET KEY TO loc_cOperacao
                ENDIF

                loc_lBrk1 = .F.
                SCAN WHILE !loc_lBrk1

                    loc_cDopes      = ALLTRIM(Dopes)
                    loc_nGlobalizas = NVL(Globalizas, 0)
                    loc_cOpers      = ALLTRIM(NVL(Opers, ""))
                    loc_cOpeGops    = ALLTRIM(NVL(OpeGops, ""))
                    loc_nCarCompos  = NVL(carcompos, 0)
                    loc_cCodTgOps   = ALLTRIM(NVL(CodTgOps, ""))

                    *-- Filtrar por tipo de geracao se GerPorTp
                    IF THIS.this_lGerPorTp AND loc_cCodTgOps <> loc_cTpGOp
                        LOOP
                    ENDIF

                    *-- Construir SQL totalizador por produto (diferencial da versao Totais)
                    loc_cSQL = "SELECT a.Emps, a.Dopes, b.CPros, MAX(b.Dpros) AS Dpros, " + ;
                               "SUM(b.Qtds) AS TotalQtds, a.GrupoOs, a.ContaOs, " + ;
                               "a.GrupoDs, a.ContaDs, a.GrVends, a.Vends " + ;
                               "FROM SigMvCab a " + ;
                               "INNER JOIN SigMvItn b ON b.EmpDopNums = " + ;
                               "a.Emps + a.Dopes + RIGHT('000000' + CAST(a.Numes AS VARCHAR(6)), 6) " + ;
                               "WHERE " + loc_cConde + loc_cCondp + ;
                               "a.Emps = " + EscaparSQL(loc_cLcEmp) + ;
                               " AND a.Dopes = " + EscaparSQL(loc_cDopes) + ;
                               " AND a.Nops = 0"

                    IF !EMPTY(loc_cGrupo)
                        IF loc_nGlobalizas = 1
                            loc_cSQL = loc_cSQL + " AND a.GrupoOs = " + EscaparSQL(loc_cGrupo)
                        ENDIF
                        IF loc_nGlobalizas = 2
                            loc_cSQL = loc_cSQL + " AND a.GrupoDs = " + EscaparSQL(loc_cGrupo)
                        ENDIF
                    ENDIF
                    IF !EMPTY(loc_cConta)
                        IF loc_nGlobalizas = 1
                            loc_cSQL = loc_cSQL + " AND a.ContaOs = " + EscaparSQL(loc_cConta)
                        ENDIF
                        IF loc_nGlobalizas = 2
                            loc_cSQL = loc_cSQL + " AND a.ContaDs = " + EscaparSQL(loc_cConta)
                        ENDIF
                    ENDIF
                    IF !EMPTY(loc_cGrupoV)
                        loc_cSQL = loc_cSQL + " AND a.GrVends = " + EscaparSQL(loc_cGrupoV)
                    ENDIF
                    IF !EMPTY(loc_cContaV)
                        loc_cSQL = loc_cSQL + " AND a.Vends = " + EscaparSQL(loc_cContaV)
                    ENDIF

                    IF !EMPTY(loc_cOperacao)
                        IF loc_nOperacaoi > 0 AND loc_nOperacaof > 0
                            loc_cSQL = loc_cSQL + " AND a.Numes BETWEEN " + ;
                                FormatarNumeroSQL(loc_nOperacaoi, 0) + " AND " + ;
                                FormatarNumeroSQL(loc_nOperacaof, 0)
                        ENDIF
                    ENDIF

                    IF THIS.this_lReserva
                        loc_cSQL = loc_cSQL + " AND a.rNops = 0"
                    ENDIF

                    loc_cSQL = loc_cSQL + " GROUP BY a.Emps, a.Dopes, b.CPros, " + ;
                               "a.GrupoOs, a.ContaOs, a.GrupoDs, a.ContaDs, a.GrVends, a.Vends"

                    IF USED("cursor_4c_TmpTotaisOp")
                        USE IN cursor_4c_TmpTotaisOp
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTotaisOp") < 1
                        MsgErro("Falha na Conex" + CHR(227) + "o (TotaisOp - Dopes=" + loc_cDopes + ")", "Erro")
                        loc_lBrk1 = .T.
                        EXIT
                    ENDIF

                    *-- Inserir totais no cursor de itens
                    SELECT cursor_4c_TmpTotaisOp
                    GO TOP
                    SCAN
                        IF NVL(TotalQtds, 0) > 0
                            SELECT (THIS.this_cCursorItens)
                            INSERT INTO (THIS.this_cCursorItens) ;
                                (Emps, Dopes, CPros, Qtds, Saldo, dpros) ;
                                VALUES (cursor_4c_TmpTotaisOp.Emps, ;
                                        cursor_4c_TmpTotaisOp.Dopes, ;
                                        cursor_4c_TmpTotaisOp.CPros, ;
                                        NVL(cursor_4c_TmpTotaisOp.TotalQtds, 0), ;
                                        NVL(cursor_4c_TmpTotaisOp.TotalQtds, 0), ;
                                        ALLTRIM(NVL(cursor_4c_TmpTotaisOp.Dpros, "")))
                        ENDIF
                        SELECT cursor_4c_TmpTotaisOp
                    ENDSCAN

                    IF USED("cursor_4c_TmpTotaisOp")
                        USE IN cursor_4c_TmpTotaisOp
                    ENDIF

                    *-- Reposicionar em CursorOper para continuar o SCAN
                    SELECT (THIS.this_cCursorOper)
                ENDSCAN

                *-- Restaurar SET KEY e SET ORDER
                SELECT (THIS.this_cCursorOper)
                SET KEY TO
                SET ORDER TO

                IF !loc_lBrk1
                    IF USED(THIS.this_cCursorCabec)
                        GO TOP IN (THIS.this_cCursorCabec)
                    ENDIF
                    IF USED(THIS.this_cCursorItens)
                        GO TOP IN (THIS.this_cCursorItens)
                    ENDIF

                    loc_lSucesso = USED(THIS.this_cCursorItens) AND ;
                                   !EOF(THIS.this_cCursorItens)

                    IF !loc_lSucesso
                        MsgAviso("Nenhum Item Selecionado Para Processar!!!")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " Linha=" + TRANSFORM(loc_oErro.LineNo) + ;
                    " Proc=" + loc_oErro.Procedure, "Erro ao ProcessarOP Totais")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

