# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGPRGLO): Left original=139 vs migrado 'lbl_4c_LblConta' Left=95 (diff=44px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1733 linhas total):

*-- Linhas 6 a 138:
6: *
7: * CHAMADA:
8: *   DO FORM FormSigPrGlo WITH _Reserva, _Autom, _PorDestino, lcNomeFrm, pTipo
9: *   Ou via CreateObject("FormSigPrGlo", lReserva, lAutom, lPorDestino, pTipo)
10: *
11: * Parametros:
12: *   par_lReserva    - .T. = modo Reserva Automatica
13: *   par_lAutom      - .T. = modo automatico
14: *   par_lPorDestino - .T. = por destino
15: *   par_pTipo       - .T. = processa por tipo de geracao de OP
16: *==============================================================================
17: 
18: DEFINE CLASS FormSigPrGlo AS FormBase
19: 
20:     *-- Dimensoes identicas ao legado (Width=680, Height=379)
21:     Width        = 680
22:     Height       = 379
23:     AutoCenter   = .T.
24:     TitleBar     = 0
25:     ShowWindow   = 1
26:     WindowType   = 1
27:     ControlBox   = .F.
28:     Closable     = .F.
29:     MaxButton    = .F.
30:     MinButton    = .F.
31:     BorderStyle  = 2
32:     DataSession  = 2
33:     ClipControls = .F.
34:     Caption      = "Processamento de O.P."
35:     FontName     = "Tahoma"
36:     FontSize     = 8
37: 
38:     *-- Flags de modo de operacao (recebidos via Init)
39:     this_lReserva         = .F.
40:     this_lAutomatico      = .F.
41:     this_lPorDestino      = .F.
42:     this_lGerPorTp        = .F.
43:     this_lAlterEmp        = .T.
44:     *-- Controlado apos leitura de cursor_4c_CrSigCdPam em InicializarForm
45:     this_lMostrarChkPedra = .F.
46: 
47:     *--------------------------------------------------------------------------
48:     * Init - recebe flags de modo, seta propriedades e delega ao FormBase
49:     *--------------------------------------------------------------------------
50:     PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
51:         THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
52:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
53:         THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
54:         THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
55:         RETURN DODEFAULT()
56:     ENDPROC
57: 
58:     *--------------------------------------------------------------------------
59:     * Destroy - libera cursores temporarios e BO antes de fechar
60:     *--------------------------------------------------------------------------
61:     PROCEDURE Destroy()
62:         IF USED("cursor_4c_TmpOper")
63:             USE IN cursor_4c_TmpOper
64:         ENDIF
65:         IF USED("cursor_4c_CrTmpTpGop")
66:             USE IN cursor_4c_CrTmpTpGop
67:         ENDIF
68:         IF USED("cursor_4c_CrSigCdPam")
69:             USE IN cursor_4c_CrSigCdPam
70:         ENDIF
71:         IF USED("cursor_4c_CrSigCdPac")
72:             USE IN cursor_4c_CrSigCdPac
73:         ENDIF
74:         IF USED("cursor_4c_TmpCabec")
75:             USE IN cursor_4c_TmpCabec
76:         ENDIF
77:         IF USED("cursor_4c_TmpItens")
78:             USE IN cursor_4c_TmpItens
79:         ENDIF
80:         IF USED("cursor_4c_Oper")
81:             USE IN cursor_4c_Oper
82:         ENDIF
83:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
84:             THIS.this_oBusinessObject = .NULL.
85:         ENDIF
86:         DODEFAULT()
87:     ENDPROC
88: 
89:     *--------------------------------------------------------------------------
90:     * InicializarForm - cria BO, carrega parametros e monta estrutura visual
91:     *--------------------------------------------------------------------------
92:     PROTECTED PROCEDURE InicializarForm()
93:         LOCAL loc_lSucesso, loc_oErro, loc_cCaption
94:         loc_lSucesso = .F.
95: 
96:         TRY
97:             *-- Criar Business Object
98:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloBO")
99:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
100:                 MsgErro("Falha ao criar SigPrGloBO.", "Erro")
101:             ELSE
102:                 *-- Repassar flags de modo ao BO
103:                 WITH THIS.this_oBusinessObject
104:                     .this_lReserva    = THIS.this_lReserva
105:                     .this_lAutomatico = THIS.this_lAutomatico
106:                     .this_lPorDestino = THIS.this_lPorDestino
107:                     .this_lGerPorTp   = THIS.this_lGerPorTp
108:                     .this_lAlterEmp   = THIS.this_lAlterEmp
109:                 ENDWITH
110: 
111:                 *-- Carregar operacoes (obrigatorio - form nao funciona sem elas)
112:                 IF NOT THIS.this_oBusinessObject.CarregarOperacoes()
113:                     MsgErro("Nenhuma Opera" + CHR(231) + CHR(227) + ;
114:                             "o configurada para Processamento de O.P.", "Erro")
115:                 ELSE
116:                     *-- Carregar demais parametros do sistema
117:                     THIS.this_oBusinessObject.CarregarParametros()
118:                     THIS.this_oBusinessObject.CarregarPacotes()
119:                     THIS.this_oBusinessObject.CarregarTiposGeracao()
120: 
121:                     *-- Caption dinamico conforme modo de operacao
122:                     loc_cCaption = "Processamento de O.P."
123:                     IF THIS.this_lReserva
124:                         loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica"
125:                     ELSE
126:                         IF THIS.this_lGerPorTp
127:                             loc_cCaption = "Processar Ordem de Produ" + CHR(231) + ;
128:                                            CHR(227) + "o por Tipo"
129:                         ENDIF
130:                     ENDIF
131:                     THIS.Caption = loc_cCaption
132: 
133:                     *-- Imagem de fundo
134:                     THIS.ConfigurarPageFrame()
135: 
136:                     *-- Calcular visibilidade do chk_pedra (antes de criar controles)
137:                     IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
138:                         SELECT cursor_4c_CrSigCdPam

*-- Linhas 149 a 224:
149:                     THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
150:                     THIS.ConfigurarShape()
151:                     THIS.ConfigurarPaginaLista()
152:                     THIS.TornarControlesVisiveis()
153:                     THIS.PopularCamposIniciais()
154:                     THIS.ConfigurarEventos()
155:                     THIS.AlternarPagina("ENTRADA")
156: 
157:                     loc_lSucesso = .T.
158:                 ENDIF
159:             ENDIF
160:         CATCH TO loc_oErro
161:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
162:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
163:         ENDTRY
164: 
165:         RETURN loc_lSucesso
166:     ENDPROC
167: 
168:     *--------------------------------------------------------------------------
169:     * ConfigurarPageFrame - aplica imagem de fundo (form plano OPERACIONAL)
170:     *--------------------------------------------------------------------------
171:     PROTECTED PROCEDURE ConfigurarPageFrame()
172:         LOCAL loc_cImg
173:         loc_cImg = gc_4c_CaminhoIcones + "new_background.jpg"
174:         IF FILE(loc_cImg)
175:             THIS.Picture = loc_cImg
176:         ENDIF
177:         THIS.ScrollBars = 0
178:     ENDPROC
179: 
180:     *--------------------------------------------------------------------------
181:     * ConfigurarCabecalho - cabecalho cinza escuro com titulo (cntSombra legado)
182:     * Top=0, Left=0, Width=680, Height=80
183:     *--------------------------------------------------------------------------
184:     PROTECTED PROCEDURE ConfigurarCabecalho()
185:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
186:         WITH THIS.cnt_4c_Cabecalho
187:             .Top         = 0
188:             .Left        = 0
189:             .Width       = THIS.Width
190:             .Height      = 80
191:             .BackStyle   = 1
192:             .BackColor   = RGB(100,100,100)
193:             .BorderWidth = 0
194:             .Visible     = .T.
195: 
196:             .AddObject("lbl_4c_Sombra", "Label")
197:             WITH .lbl_4c_Sombra
198:                 .AutoSize      = .F.
199:                 .FontBold      = .T.
200:                 .FontName      = "Tahoma"
201:                 .FontSize      = 18
202:                 .FontUnderline = .F.
203:                 .WordWrap      = .T.
204:                 .Alignment     = 0
205:                 .BackStyle     = 0
206:                 .Height        = 40
207:                 .Left          = 10
208:                 .Top           = 18
209:                 .Width         = THIS.Width
210:                 .ForeColor     = RGB(0,0,0)
211:                 .Caption       = THIS.Caption
212:                 .Visible       = .T.
213:             ENDWITH
214: 
215:             .AddObject("lbl_4c_Titulo", "Label")
216:             WITH .lbl_4c_Titulo
217:                 .AutoSize      = .F.
218:                 .FontBold      = .T.
219:                 .FontName      = "Tahoma"
220:                 .FontSize      = 18
221:                 .FontUnderline = .F.
222:                 .WordWrap      = .T.
223:                 .Alignment     = 0
224:                 .BackStyle     = 0

*-- Linhas 237 a 299:
237:     * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
238:     * Top=7, Left=486, Height=110, Width=173
239:     *--------------------------------------------------------------------------
240:     PROTECTED PROCEDURE ConfigurarShape()
241:         THIS.AddObject("shp_4c_Shape3", "Shape")
242:         WITH THIS.shp_4c_Shape3
243:             .Top         = 7
244:             .Left        = 486
245:             .Height      = 110
246:             .Width       = 173
247:             .BackStyle   = 0
248:             .BorderStyle = 0
249:             .BorderColor = RGB(90,90,90)
250:             .Visible     = .T.
251:         ENDWITH
252:     ENDPROC
253: 
254:     *--------------------------------------------------------------------------
255:     * ConfigurarBotoes - botoes Processar e Cancelar
256:     * Processar: Top=3, Left=528, 75x75
257:     * Cancelar : Top=3, Left=603, 75x75
258:     *--------------------------------------------------------------------------
259:     PROTECTED PROCEDURE ConfigurarBotoes()
260:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
261:         WITH THIS.cmd_4c_Processar
262:             .Top             = 3
263:             .Left            = 528
264:             .Height          = 75
265:             .Width           = 75
266:             .FontBold        = .T.
267:             .FontItalic      = .T.
268:             .FontName        = "Comic Sans MS"
269:             .FontSize        = 8
270:             .WordWrap        = .T.
271:             .Caption         = "Processar"
272:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
273:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
274:             .ForeColor       = RGB(90,90,90)
275:             .BackColor       = RGB(255,255,255)
276:             .Themes          = .T.
277:             .PicturePosition = 13
278:             .SpecialEffect   = 0
279:             .MousePointer    = 15
280:             .Visible         = .T.
281:         ENDWITH
282: 
283:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
284:         WITH THIS.cmd_4c_Cancelar
285:             .Top             = 3
286:             .Left            = 603
287:             .Height          = 75
288:             .Width           = 75
289:             .FontBold        = .T.
290:             .FontItalic      = .T.
291:             .FontName        = "Comic Sans MS"
292:             .FontSize        = 8
293:             .WordWrap        = .T.
294:             .Caption         = "Encerrar"
295:             .Cancel          = .T.
296:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
297:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .ForeColor       = RGB(90,90,90)
299:             .BackColor       = RGB(255,255,255)

*-- Linhas 308 a 351:
308:     *--------------------------------------------------------------------------
309:     * ConfigurarContainers - cria containers principais vazios
310:     *--------------------------------------------------------------------------
311:     PROTECTED PROCEDURE ConfigurarContainers()
312:         LOCAL loc_lGlobAutos2
313:         loc_lGlobAutos2 = .F.
314:         IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
315:             SELECT cursor_4c_CrSigCdPam
316:             loc_lGlobAutos2 = (cursor_4c_CrSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
317:         ENDIF
318: 
319:         *-- Container1 legado: Tipo de O.P.
320:         THIS.AddObject("cnt_4c_TipoOp", "Container")
321:         WITH THIS.cnt_4c_TipoOp
322:             .Top         = 164
323:             .Left        = 139
324:             .Width       = 346
325:             .Height      = 25
326:             .BackStyle   = 0
327:             .BorderWidth = 0
328:             .Enabled     = THIS.this_lGerPorTp
329:             .Visible     = .T.
330:         ENDWITH
331: 
332:         *-- Opera_ao legado: codigo + faixa i/f
333:         THIS.AddObject("cnt_4c_Operacao", "Container")
334:         WITH THIS.cnt_4c_Operacao
335:             .Top         = 191
336:             .Left        = 139
337:             .Width       = 350
338:             .Height      = 25
339:             .BackStyle   = 0
340:             .BorderWidth = 0
341:             .Visible     = .T.
342:         ENDWITH
343: 
344:         *-- Conta legado: grupo/conta/descricao para filtro de movimentacao
345:         THIS.AddObject("cnt_4c_Conta", "Container")
346:         WITH THIS.cnt_4c_Conta
347:             .Top         = 218
348:             .Left        = 139
349:             .Width       = 553
350:             .Height      = 25
351:             .BackStyle   = 0

*-- Linhas 408 a 451:
408:     *--------------------------------------------------------------------------
409:     * ConfigurarCamposForm - labels e textboxes de data diretamente no form
410:     *--------------------------------------------------------------------------
411:     PROTECTED PROCEDURE ConfigurarCamposForm()
412:         THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
413:         WITH THIS.lbl_4c_PeriodoEmissao
414:             .AutoSize  = .F.
415:             .BackStyle = 0
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .ForeColor = RGB(90,90,90)
419:             .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
420:             .Height    = 15
421:             .Left      = 32
422:             .Top       = 115
423:             .Width     = 101
424:         ENDWITH
425: 
426:         THIS.AddObject("txt_4c_Dataei", "TextBox")
427:         WITH THIS.txt_4c_Dataei
428:             .Alignment     = 3
429:             .Value         = {}
430:             .Format        = "K"
431:             .Height        = 23
432:             .Left          = 142
433:             .Top           = 111
434:             .Width         = 80
435:             .SpecialEffect = 1
436:             .FontName      = "Tahoma"
437:             .FontSize      = 8
438:         ENDWITH
439: 
440:         THIS.AddObject("lbl_4c_Ate1", "Label")
441:         WITH THIS.lbl_4c_Ate1
442:             .AutoSize  = .F.
443:             .BackStyle = 0
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .ForeColor = RGB(90,90,90)
447:             .Caption   = "at" + CHR(233)
448:             .Height    = 15
449:             .Left      = 227
450:             .Top       = 115
451:             .Width     = 18

*-- Linhas 595 a 656:
595:     *--------------------------------------------------------------------------
596:     * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
597:     *--------------------------------------------------------------------------
598:     PROTECTED PROCEDURE ConfigurarContainerTipoOp()
599:         THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
600:         WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
601:             .Left          = 3
602:             .Top           = 1
603:             .Width         = 80
604:             .Height        = 23
605:             .MaxLength     = 10
606:             .FontName      = "Courier New"
607:             .FontSize      = 9
608:             .Margin        = 2
609:             .SpecialEffect = 1
610:         ENDWITH
611:     ENDPROC
612: 
613:     *--------------------------------------------------------------------------
614:     * ConfigurarContainerOperacao - Opera_ao legado: codigo + faixa i/f
615:     *--------------------------------------------------------------------------
616:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
617:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
618:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
619:             .Left          = 3
620:             .Top           = 1
621:             .Width         = 151
622:             .Height        = 23
623:             .MaxLength     = 20
624:             .FontName      = "Courier New"
625:             .FontSize      = 9
626:             .Margin        = 2
627:             .SpecialEffect = 1
628:         ENDWITH
629: 
630:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
631:         WITH THIS.cnt_4c_Operacao.lbl_4c_De
632:             .AutoSize  = .F.
633:             .BackStyle = 0
634:             .FontName  = "Tahoma"
635:             .FontSize  = 8
636:             .ForeColor = RGB(90,90,90)
637:             .Caption   = "de"
638:             .Height    = 15
639:             .Left      = 180
640:             .Top       = 5
641:             .Width     = 14
642:         ENDWITH
643: 
644:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
645:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
646:             .Alignment     = 3
647:             .Value         = 0
648:             .Format        = "K"
649:             .Height        = 23
650:             .InputMask     = "999999"
651:             .Left          = 201
652:             .Top           = 1
653:             .Width         = 55
654:             .MaxLength     = 6
655:             .SpecialEffect = 1
656:             .FontName      = "Courier New"

*-- Linhas 691 a 810:
691:     *--------------------------------------------------------------------------
692:     * ConfigurarContainerConta - Movimentacao: grupo/conta/descricao
693:     *--------------------------------------------------------------------------
694:     PROTECTED PROCEDURE ConfigurarContainerConta()
695:         THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
696:         WITH THIS.cnt_4c_Conta.txt_4c_Grupo
697:             .Left          = 3
698:             .Top           = 1
699:             .Width         = 80
700:             .Height        = 23
701:             .SpecialEffect = 1
702:             .FontName      = "Tahoma"
703:             .FontSize      = 8
704:         ENDWITH
705: 
706:         THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
707:         WITH THIS.cnt_4c_Conta.txt_4c_Conta
708:             .Left          = 86
709:             .Top           = 1
710:             .Width         = 80
711:             .Height        = 23
712:             .SpecialEffect = 1
713:             .FontName      = "Tahoma"
714:             .FontSize      = 8
715:         ENDWITH
716: 
717:         THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
718:         WITH THIS.cnt_4c_Conta.txt_4c_Dconta
719:             .Left          = 170
720:             .Top           = 1
721:             .Width         = 360
722:             .Height        = 23
723:             .SpecialEffect = 1
724:             .FontName      = "Tahoma"
725:             .FontSize      = 8
726:         ENDWITH
727:     ENDPROC
728: 
729:     *--------------------------------------------------------------------------
730:     * ConfigurarContainerResponsavel - Vendedor: grupo/conta/descricao
731:     *--------------------------------------------------------------------------
732:     PROTECTED PROCEDURE ConfigurarContainerResponsavel()
733:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
734:         WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
735:             .Left          = 3
736:             .Top           = 1
737:             .Width         = 80
738:             .Height        = 23
739:             .SpecialEffect = 1
740:             .FontName      = "Tahoma"
741:             .FontSize      = 8
742:         ENDWITH
743: 
744:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
745:         WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
746:             .Left          = 86
747:             .Top           = 1
748:             .Width         = 80
749:             .Height        = 23
750:             .SpecialEffect = 1
751:             .FontName      = "Tahoma"
752:             .FontSize      = 8
753:         ENDWITH
754: 
755:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
756:         WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
757:             .Left          = 170
758:             .Top           = 1
759:             .Width         = 360
760:             .Height        = 23
761:             .SpecialEffect = 1
762:             .FontName      = "Tahoma"
763:             .FontSize      = 8
764:         ENDWITH
765:     ENDPROC
766: 
767:     *--------------------------------------------------------------------------
768:     * ConfigurarContainerEmpresa - cd_empresa / ds_empresa / chk pedras
769:     *--------------------------------------------------------------------------
770:     PROTECTED PROCEDURE ConfigurarContainerEmpresa()
771:         THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
772:         WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
773:             .Left          = 4
774:             .Top           = 1
775:             .Width         = 31
776:             .Height        = 23
777:             .InputMask     = "XXX"
778:             .MaxLength     = 3
779:             .Format        = "k"
780:             .BackStyle     = 1
781:             .BorderStyle   = 1
782:             .ForeColor     = RGB(0,0,0)
783:             .FontName      = "Courier New"
784:             .FontSize      = 9
785:             .SpecialEffect = 1
786:         ENDWITH
787: 
788:         THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
789:         WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
790:             .Left          = 38
791:             .Top           = 1
792:             .Width         = 282
793:             .Height        = 23
794:             .MaxLength     = 40
795:             .Format        = "K"
796:             .FontName      = "Courier New"
797:             .FontSize      = 9
798:             .SpecialEffect = 1
799:         ENDWITH
800: 
801:         THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
802:         WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
803:             .Left      = 330
804:             .Top       = 5
805:             .Height    = 15
806:             .Width     = 124
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .BackStyle = 0
810:             .Caption   = "N" + CHR(227) + "o Empenhar Pedras"

*-- Linhas 817 a 860:
817:     *--------------------------------------------------------------------------
818:     * ConfigurarContainerPrevisao - data previsao entrega + data geracao
819:     *--------------------------------------------------------------------------
820:     PROTECTED PROCEDURE ConfigurarContainerPrevisao()
821:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
822:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
823:             .AutoSize  = .F.
824:             .BackStyle = 0
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .ForeColor = RGB(90,90,90)
828:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
829:             .Height    = 15
830:             .Left      = 7
831:             .Top       = 9
832:             .Width     = 106
833:         ENDWITH
834: 
835:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
836:         WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
837:             .Alignment     = 3
838:             .Value         = {}
839:             .Format        = "K"
840:             .Height        = 23
841:             .Left          = 134
842:             .Top           = 5
843:             .Width         = 80
844:             .SpecialEffect = 1
845:             .FontName      = "Tahoma"
846:             .FontSize      = 8
847:         ENDWITH
848: 
849:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
850:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
851:             .AutoSize  = .F.
852:             .BackStyle = 0
853:             .FontName  = "Tahoma"
854:             .FontSize  = 8
855:             .ForeColor = RGB(90,90,90)
856:             .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
857:             .Height    = 15
858:             .Left      = 244
859:             .Top       = 9
860:             .Width     = 90

*-- Linhas 878 a 1023:
878:     *--------------------------------------------------------------------------
879:     * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
880:     *--------------------------------------------------------------------------
881:     PROTECTED PROCEDURE ConfigurarContainerOp()
882:         THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
883:         WITH THIS.cnt_4c_Op.lbl_4c_LblNop
884:             .AutoSize  = .F.
885:             .BackStyle = 0
886:             .FontName  = "Tahoma"
887:             .FontSize  = 8
888:             .ForeColor = RGB(90,90,90)
889:             .Caption   = "N" + CHR(186) + " da O.P.:"
890:             .Height    = 15
891:             .Left      = 0
892:             .Top       = 5
893:             .Width     = 58
894:         ENDWITH
895: 
896:         THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
897:         WITH THIS.cnt_4c_Op.txt_4c_Nop
898:             .Alignment     = 3
899:             .Value         = 0
900:             .Height        = 23
901:             .InputMask     = "999999"
902:             .Left          = 71
903:             .Top           = 1
904:             .Width         = 59
905:             .MaxLength     = 6
906:             .SpecialEffect = 1
907:             .FontName      = "Tahoma"
908:             .FontSize      = 8
909:         ENDWITH
910:     ENDPROC
911: 
912:     *--------------------------------------------------------------------------
913:     * ConfigurarPaginaLista - monta a area principal (botoes + containers + campos)
914:     *--------------------------------------------------------------------------
915:     PROTECTED PROCEDURE ConfigurarPaginaLista()
916:         THIS.ConfigurarBotoes()
917:         THIS.ConfigurarContainers()
918:         THIS.ConfigurarCamposForm()
919:         THIS.ConfigurarContainerTipoOp()
920:         THIS.ConfigurarContainerOperacao()
921:         THIS.ConfigurarContainerConta()
922:         THIS.ConfigurarContainerResponsavel()
923:         THIS.ConfigurarContainerEmpresa()
924:         THIS.ConfigurarContainerPrevisao()
925:         THIS.ConfigurarContainerOp()
926:     ENDPROC
927: 
928:     *--------------------------------------------------------------------------
929:     * ConfigurarPaginaDados - stub de compatibilidade (OPERACIONAL nao tem Page2)
930:     *--------------------------------------------------------------------------
931:     PROTECTED PROCEDURE ConfigurarPaginaDados()
932:         RETURN
933:     ENDPROC
934: 
935:     *--------------------------------------------------------------------------
936:     * TornarControlesVisiveis - torna controles do form visiveis apos AddObject
937:     * Preserva Visible original de containers com visibilidade gerenciada
938:     * (cnt_4c_Op e cnt_4c_Previsao) mas recursa seus filhos antes do LOOP
939:     * para evitar ghost trails (feedback_tcv_skip_recursao.md)
940:     *--------------------------------------------------------------------------
941:     PROCEDURE TornarControlesVisiveis()
942:         LOCAL loc_i, loc_oCtrl, loc_lSkip
943:         FOR loc_i = 1 TO THIS.ControlCount
944:             loc_oCtrl = THIS.Controls(loc_i)
945:             IF VARTYPE(loc_oCtrl) != "O"
946:                 LOOP
947:             ENDIF
948:             loc_lSkip = INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_OP", "CNT_4C_PREVISAO")
949:             IF loc_lSkip
950:                 *-- Recursar filhos ANTES do LOOP (anti-ghost para containers hidden)
951:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
952:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
953:                 ENDIF
954:                 LOOP
955:             ENDIF
956:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
957:                 loc_oCtrl.Visible = .T.
958:             ENDIF
959:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
960:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
961:             ENDIF
962:         ENDFOR
963:     ENDPROC
964: 
965:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
966:         LOCAL loc_i, loc_oCtrl
967:         FOR loc_i = 1 TO par_oContainer.ControlCount
968:             loc_oCtrl = par_oContainer.Controls(loc_i)
969:             IF VARTYPE(loc_oCtrl) = "O"
970:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
971:                     loc_oCtrl.Visible = .T.
972:                 ENDIF
973:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
974:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
975:                 ENDIF
976:             ENDIF
977:         ENDFOR
978:     ENDPROC
979: 
980:     *--------------------------------------------------------------------------
981:     * PopularCamposIniciais - preenche valores iniciais apos criacao dos controles
982:     *--------------------------------------------------------------------------
983:     PROTECTED PROCEDURE PopularCamposIniciais()
984:         LOCAL loc_oErro, loc_cEmp, loc_cRazas
985:         TRY
986:             *-- Empresa padrao: go_4c_Sistema.cCodEmpresa
987:             loc_cEmp   = ALLTRIM(go_4c_Sistema.cCodEmpresa)
988:             loc_cRazas = ""
989:             IF USED("cursor_4c_TmpEmpInit")
990:                 USE IN cursor_4c_TmpEmpInit
991:             ENDIF
992:             IF SQLEXEC(gnConnHandle, ;
993:                "SELECT TOP 1 Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmp), ;
994:                "cursor_4c_TmpEmpInit") >= 1
995:                 IF RECCOUNT("cursor_4c_TmpEmpInit") > 0
996:                     SELECT cursor_4c_TmpEmpInit
997:                     loc_cRazas = ALLTRIM(cursor_4c_TmpEmpInit.Razas)
998:                 ENDIF
999:                 USE IN cursor_4c_TmpEmpInit
1000:             ENDIF
1001:             THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = loc_cEmp
1002:             THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = loc_cRazas
1003: 
1004:             *-- Previsao de entrega: data atual + PrevProds dias
1005:             IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
1006:                 SELECT cursor_4c_CrSigCdPam
1007:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + cursor_4c_CrSigCdPam.PrevProds
1008:             ENDIF
1009: 
1010:             *-- Data de geracao: data atual (apenas se nao modo automatico)
1011:             IF NOT THIS.this_lAutomatico
1012:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
1013:             ENDIF
1014: 
1015:             *-- Visibilidade do checkbox pedras
1016:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
1017: 
1018:             *-- Pre-selecionar tipo de OP se GerPorTp e houver apenas 1 tipo disponivel
1019:             IF THIS.this_lGerPorTp AND ;
1020:                USED("cursor_4c_CrTmpTpGop") AND ;
1021:                RECCOUNT("cursor_4c_CrTmpTpGop") = 1
1022:                 SELECT cursor_4c_CrTmpTpGop
1023:                 GO TOP

*-- Linhas 1029 a 1733:
1029:     ENDPROC
1030: 
1031:     *--------------------------------------------------------------------------
1032:     * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
1033:     *--------------------------------------------------------------------------
1034:     PROTECTED PROCEDURE ConfigurarEventos()
1035:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1036:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
1037:         BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
1038:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
1039:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
1040:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
1041:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")
1042:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta,           "KeyPress", THIS, "TxtDcontaKeyPress")
1043:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "TxtGrupoRespKeyPress")
1044:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "TxtContaRespKeyPress")
1045:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "TxtDcontaRespKeyPress")
1046:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa,      "KeyPress", THIS, "TxtCdEmpresaKeyPress")
1047:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa,      "KeyPress", THIS, "TxtDsEmpresaKeyPress")
1048:         BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop,                 "KeyPress", THIS, "TxtNopKeyPress")
1049:     ENDPROC
1050: 
1051:     *--------------------------------------------------------------------------
1052:     * CmdProcessarClick - valida campos, copia ao BO e executa processamento
1053:     *--------------------------------------------------------------------------
1054:     PROCEDURE CmdProcessarClick()
1055:         LOCAL loc_nGlobAutos, loc_oErro, loc_lProcessou, loc_lErroOcorreu, loc_oGl2
1056:         loc_nGlobAutos    = 0
1057:         loc_lProcessou    = .F.
1058:         loc_lErroOcorreu  = .F.
1059: 
1060:         *-- Validar previsao e geracao (obrigatorias em modo normal)
1061:         IF NOT THIS.this_lReserva
1062:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
1063:                 MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!")
1064:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
1065:                 RETURN
1066:             ENDIF
1067:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
1068:                 MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!")
1069:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
1070:                 RETURN
1071:             ENDIF
1072:         ENDIF
1073: 
1074:         *-- Validar numero OP manual (GlobAutos=2)
1075:         IF USED("cursor_4c_CrSigCdPam") AND NOT EOF("cursor_4c_CrSigCdPam")
1076:             SELECT cursor_4c_CrSigCdPam
1077:             loc_nGlobAutos = cursor_4c_CrSigCdPam.GlobAutos
1078:             IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
1079:                 IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1080:                     MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!")
1081:                     THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
1082:                     RETURN
1083:                 ENDIF
1084:             ENDIF
1085:         ENDIF
1086: 
1087:         *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
1088:         IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
1089:             MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
1090:                      " Obrigat" + CHR(243) + "rio ser Preenchido!!!")
1091:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus
1092:             RETURN
1093:         ENDIF
1094: 
1095:         *-- Copiar campos do form para o BO
1096:         THIS.FormParaBO()
1097: 
1098:         *-- Bloquear UI durante processamento
1099:         THIS.AlternarPagina("PROCESSANDO")
1100: 
1101:         TRY
1102:             loc_lProcessou = THIS.this_oBusinessObject.ProcessarOP()
1103:         CATCH TO loc_oErro
1104:             MsgErro("Erro no processamento: " + loc_oErro.Message + ;
1105:                     " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1106:             loc_lErroOcorreu = .T.
1107:         ENDTRY
1108: 
1109:         *-- Restaurar UI (sempre - inclusive em erro)
1110:         THIS.AlternarPagina("ENTRADA")
1111: 
1112:         IF loc_lProcessou
1113:             *-- Abrir FormSigPrGl2 para exibir/confirmar resultados
1114:             loc_oGl2 = CREATEOBJECT("FormSigPrGl2", THIS, THIS.DataSessionId, ;
1115:                 THIS.this_lReserva, .NULL., 0, ;
1116:                 THIS.this_lAutomatico, THIS.this_oBusinessObject.this_nNumeroOP)
1117:             IF VARTYPE(loc_oGl2) = "O"
1118:                 loc_oGl2.Show()
1119:                 loc_oGl2 = .NULL.
1120:             ENDIF
1121:         ELSE
1122:             IF NOT loc_lErroOcorreu
1123:                 *-- Processamento rodou sem exception mas nao encontrou itens
1124:                 MsgAviso("Nenhum Item Selecionado Para Processar!!!")
1125:                 IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1126:                     THIS.txt_4c_Dataei.SetFocus
1127:                 ENDIF
1128:             ENDIF
1129:         ENDIF
1130:     ENDPROC
1131: 
1132:     *--------------------------------------------------------------------------
1133:     * CmdCancelarClick - fecha o formulario
1134:     *--------------------------------------------------------------------------
1135:     PROCEDURE CmdCancelarClick()
1136:         THIS.Release()
1137:     ENDPROC
1138: 
1139:     *--------------------------------------------------------------------------
1140:     * FormParaBO - copia todos os campos do formulario para as propriedades do BO
1141:     *--------------------------------------------------------------------------
1142:     PROCEDURE FormParaBO()
1143:         WITH THIS.this_oBusinessObject
1144:             .this_dDataei          = THIS.txt_4c_Dataei.Value
1145:             .this_dDataef          = THIS.txt_4c_Dataef.Value
1146:             .this_dDatapi          = THIS.txt_4c_Datapi.Value
1147:             .this_dDatapf          = THIS.txt_4c_Datapf.Value
1148:             .this_cOperacao        = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1149:             .this_nOperacaoi       = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1150:             .this_nOperacaof       = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
1151:             .this_cGrupoConta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1152:             .this_cConta           = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1153:             .this_cDConta          = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1154:             .this_cGrupoResp       = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1155:             .this_cContaResp       = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1156:             .this_cDContaResp      = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1157:             .this_cCodEmpresa      = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1158:             .this_cDsEmpresa       = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1159:             .this_nNaoEmpenharPedras = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
1160:             .this_cTipoGerOP       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1161:             .this_dPrevisao        = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
1162:             .this_dGeracao         = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
1163:             .this_nNumeroOP        = THIS.cnt_4c_Op.txt_4c_Nop.Value
1164:         ENDWITH
1165:     ENDPROC
1166: 
1167:     *--------------------------------------------------------------------------
1168:     * BOParaForm - popula os campos do formulario a partir das propriedades do BO
1169:     *--------------------------------------------------------------------------
1170:     PROCEDURE BOParaForm()
1171:         LOCAL loc_oErro
1172:         TRY
1173:             WITH THIS.this_oBusinessObject
1174:                 THIS.txt_4c_Dataei.Value = .this_dDataei
1175:                 THIS.txt_4c_Dataef.Value = .this_dDataef
1176:                 THIS.txt_4c_Datapi.Value = .this_dDatapi
1177:                 THIS.txt_4c_Datapf.Value = .this_dDatapf
1178:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
1179:                 THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
1180:                 THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
1181:                 THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
1182:                 THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
1183:                 THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDConta
1184:                 THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
1185:                 THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
1186:                 THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDContaResp
1187:                 THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCodEmpresa
1188:                 THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
1189:                 THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpenharPedras
1190:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTipoGerOP
1191:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
1192:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
1193:                 THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNumeroOP
1194:             ENDWITH
1195:         CATCH TO loc_oErro
1196:             MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
1197:         ENDTRY
1198:     ENDPROC
1199: 
1200:     *--------------------------------------------------------------------------
1201:     * AlternarPagina - alterna estado visual entre "ENTRADA" e "PROCESSANDO"
1202:     *--------------------------------------------------------------------------
1203:     PROCEDURE AlternarPagina(par_cModo)
1204:         LOCAL loc_cModo, loc_lEditar
1205:         loc_cModo  = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
1206:         loc_lEditar = (loc_cModo = "ENTRADA")
1207: 
1208:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1209:             THIS.cmd_4c_Processar.Enabled = loc_lEditar
1210:         ENDIF
1211:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1212:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)
1213:         ENDIF
1214:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1215:             THIS.cnt_4c_Operacao.Enabled = loc_lEditar
1216:         ENDIF
1217:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1218:             THIS.cnt_4c_Conta.Enabled = loc_lEditar
1219:         ENDIF
1220:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1221:             THIS.cnt_4c_Responsavel.Enabled = loc_lEditar
1222:         ENDIF
1223:         IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
1224:             THIS.cnt_4c_Empresa.Enabled = (loc_lEditar AND THIS.this_lAlterEmp)
1225:         ENDIF
1226:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1227:             THIS.cnt_4c_Previsao.Enabled = (loc_lEditar AND NOT THIS.this_lReserva)
1228:         ENDIF
1229:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1230:             THIS.cnt_4c_Op.Enabled = loc_lEditar
1231:         ENDIF
1232:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1233:             THIS.txt_4c_Dataei.Enabled = loc_lEditar
1234:         ENDIF
1235:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1236:             THIS.txt_4c_Dataef.Enabled = loc_lEditar
1237:         ENDIF
1238:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1239:             THIS.txt_4c_Datapi.Enabled = loc_lEditar
1240:         ENDIF
1241:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1242:             THIS.txt_4c_Datapf.Enabled = loc_lEditar
1243:         ENDIF
1244:     ENDPROC
1245: 
1246:     *--------------------------------------------------------------------------
1247:     * LimparCampos - limpa todos os campos de filtro do formulario
1248:     *--------------------------------------------------------------------------
1249:     PROCEDURE LimparCampos()
1250:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1251:             THIS.txt_4c_Dataei.Value = {}
1252:         ENDIF
1253:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1254:             THIS.txt_4c_Dataef.Value = {}
1255:         ENDIF
1256:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1257:             THIS.txt_4c_Datapi.Value = {}
1258:         ENDIF
1259:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1260:             THIS.txt_4c_Datapf.Value = {}
1261:         ENDIF
1262:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1263:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1264:         ENDIF
1265:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1266:             THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
1267:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1268:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1269:         ENDIF
1270:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1271:             THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ""
1272:             THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1273:             THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1274:         ENDIF
1275:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1276:             THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = ""
1277:             THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1278:             THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1279:         ENDIF
1280:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1281:             THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = {}
1282:             THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = {}
1283:         ENDIF
1284:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1285:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1286:         ENDIF
1287:     ENDPROC
1288: 
1289:     *--------------------------------------------------------------------------
1290:     * TxtTpGOpKeyPress - lookup tipo de OP (cursor_4c_CrTmpTpGop - VFP local)
1291:     *--------------------------------------------------------------------------
1292:     PROCEDURE TxtTpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1293:         LOCAL loc_cVal, loc_oBusca
1294:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1295:             RETURN
1296:         ENDIF
1297:         IF NOT THIS.cnt_4c_TipoOp.Enabled
1298:             RETURN
1299:         ENDIF
1300:         loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1301:         *-- Tentar SEEK direto antes de abrir picker
1302:         IF NOT EMPTY(loc_cVal) AND USED("cursor_4c_CrTmpTpGop")
1303:             SELECT cursor_4c_CrTmpTpGop
1304:             IF SEEK(loc_cVal, "cursor_4c_CrTmpTpGop", "Codigos")
1305:                 RETURN
1306:             ENDIF
1307:         ENDIF
1308:         IF NOT USED("cursor_4c_CrTmpTpGop")
1309:             MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.")
1310:             RETURN
1311:         ENDIF
1312:         IF USED("cursor_4c_TpGOp")
1313:             USE IN cursor_4c_TpGOp
1314:         ENDIF
1315:         SELECT Codigos, Descs FROM cursor_4c_CrTmpTpGop INTO CURSOR cursor_4c_TpGOp READWRITE
1316:         SELECT cursor_4c_TpGOp
1317:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1318:         IF VARTYPE(loc_oBusca) = "O"
1319:             WITH loc_oBusca
1320:                 .this_cCursorDestino = "cursor_4c_TpGOp"
1321:                 .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
1322:                 .this_cCampoBusca    = "Codigos"
1323:                 .this_cValorBusca    = loc_cVal
1324:                 .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1325:                 .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1326:                 .Show()
1327:                 IF .this_lSelecionou
1328:                     SELECT cursor_4c_TpGOp
1329:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
1330:                 ELSE
1331:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1332:                 ENDIF
1333:             ENDWITH
1334:             loc_oBusca = .NULL.
1335:         ENDIF
1336:     ENDPROC
1337: 
1338:     *--------------------------------------------------------------------------
1339:     * TxtOperacaoKeyPress - lookup operacao (cursor_4c_TmpOper - VFP local)
1340:     *--------------------------------------------------------------------------
1341:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1342:         LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
1343:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1344:             RETURN
1345:         ENDIF
1346:         loc_cVal = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1347:         *-- Vazio: limpar faixa inicial/final
1348:         IF EMPTY(loc_cVal)
1349:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1350:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1351:             RETURN
1352:         ENDIF
1353:         IF NOT USED("cursor_4c_TmpOper")
1354:             MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas.")
1355:             RETURN
1356:         ENDIF
1357:         IF USED("cursor_4c_Oper")
1358:             USE IN cursor_4c_Oper
1359:         ENDIF
1360:         IF THIS.this_lGerPorTp
1361:             loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1362:             SELECT Dopes, NDopes FROM cursor_4c_TmpOper ;
1363:                 WHERE CodTgOps = m.loc_cTpGOp ;
1364:                 INTO CURSOR cursor_4c_Oper READWRITE
1365:         ELSE
1366:             SELECT Dopes, NDopes FROM cursor_4c_TmpOper INTO CURSOR cursor_4c_Oper READWRITE
1367:         ENDIF
1368:         SELECT cursor_4c_Oper
1369:         INDEX ON Dopes TAG Dopes
1370:         *-- Tentar SEEK direto
1371:         IF SEEK(loc_cVal, "cursor_4c_Oper", "Dopes")
1372:             RETURN
1373:         ENDIF
1374:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1375:         IF VARTYPE(loc_oBusca) = "O"
1376:             WITH loc_oBusca
1377:                 .this_cCursorDestino = "cursor_4c_Oper"
1378:                 .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
1379:                 .this_cCampoBusca    = "Dopes"
1380:                 .this_cValorBusca    = loc_cVal
1381:                 .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
1382:                 .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
1383:                 .Show()
1384:                 IF .this_lSelecionou
1385:                     SELECT cursor_4c_Oper
1386:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_Oper.Dopes)
1387:                 ELSE
1388:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
1389:                     THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1390:                     THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1391:                 ENDIF
1392:             ENDWITH
1393:             loc_oBusca = .NULL.
1394:         ENDIF
1395:     ENDPROC
1396: 
1397:     *--------------------------------------------------------------------------
1398:     * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
1399:     *--------------------------------------------------------------------------
1400:     PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1401:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1402:             RETURN
1403:         ENDIF
1404:         IF THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value > 0 AND ;
1405:            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1406:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1407:         ENDIF
1408:     ENDPROC
1409: 
1410:     *--------------------------------------------------------------------------
1411:     * TxtGrupoContaKeyPress - lookup grupo contabil (SigCdGcr) para Movimentacao
1412:     *--------------------------------------------------------------------------
1413:     PROCEDURE TxtGrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1414:         LOCAL loc_cVal, loc_oBusca
1415:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1416:             RETURN
1417:         ENDIF
1418:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1419:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1420:             "cursor_4c_GrpConta", "codigos", loc_cVal, ;
1421:             "Grupos Cont" + CHR(225) + "beis", .F., .T., "")
1422:         IF VARTYPE(loc_oBusca) = "O"
1423:             WITH loc_oBusca
1424:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1425:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1426:                 .Show()
1427:                 IF .this_lSelecionou
1428:                     SELECT cursor_4c_GrpConta
1429:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpConta.codigos)
1430:                 ELSE
1431:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
1432:                 ENDIF
1433:             ENDWITH
1434:             loc_oBusca = .NULL.
1435:         ENDIF
1436:     ENDPROC
1437: 
1438:     *--------------------------------------------------------------------------
1439:     * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
1440:     *--------------------------------------------------------------------------
1441:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1442:         LOCAL loc_cVal, loc_oBusca
1443:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1444:             RETURN
1445:         ENDIF
1446:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1447:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1448:             "cursor_4c_CliConta", "IClis", loc_cVal, ;
1449:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o", .F., .T., "")
1450:         IF VARTYPE(loc_oBusca) = "O"
1451:             WITH loc_oBusca
1452:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1453:                 .mAddColuna("RClis", "                                        ", "Nome")
1454:                 .Show()
1455:                 IF .this_lSelecionou
1456:                     SELECT cursor_4c_CliConta
1457:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliConta.IClis)
1458:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliConta.RClis)
1459:                 ELSE
1460:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1461:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1462:                 ENDIF
1463:             ENDWITH
1464:             loc_oBusca = .NULL.
1465:         ENDIF
1466:     ENDPROC
1467: 
1468:     *--------------------------------------------------------------------------
1469:     * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
1470:     *--------------------------------------------------------------------------
1471:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1472:         LOCAL loc_cVal, loc_oBusca
1473:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1474:             RETURN
1475:         ENDIF
1476:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value))
1477:             RETURN
1478:         ENDIF
1479:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1480:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1481:             "cursor_4c_CliDconta", "RClis", loc_cVal, ;
1482:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o (Nome)", .F., .T., "")
1483:         IF VARTYPE(loc_oBusca) = "O"
1484:             WITH loc_oBusca
1485:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1486:                 .mAddColuna("RClis", "                                        ", "Nome")
1487:                 .Show()
1488:                 IF .this_lSelecionou
1489:                     SELECT cursor_4c_CliDconta
1490:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDconta.IClis)
1491:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDconta.RClis)
1492:                 ELSE
1493:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1494:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1495:                 ENDIF
1496:             ENDWITH
1497:             loc_oBusca = .NULL.
1498:         ENDIF
1499:     ENDPROC
1500: 
1501:     *--------------------------------------------------------------------------
1502:     * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
1503:     *--------------------------------------------------------------------------
1504:     PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1505:         LOCAL loc_cVal, loc_oBusca
1506:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1507:             RETURN
1508:         ENDIF
1509:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1510:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1511:             "cursor_4c_GrpResp", "codigos", loc_cVal, ;
1512:             "Grupos - Vendedor", .F., .T., "")
1513:         IF VARTYPE(loc_oBusca) = "O"
1514:             WITH loc_oBusca
1515:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1516:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1517:                 .Show()
1518:                 IF .this_lSelecionou
1519:                     SELECT cursor_4c_GrpResp
1520:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpResp.codigos)
1521:                 ELSE
1522:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
1523:                 ENDIF
1524:             ENDWITH
1525:             loc_oBusca = .NULL.
1526:         ENDIF
1527:     ENDPROC
1528: 
1529:     *--------------------------------------------------------------------------
1530:     * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
1531:     *--------------------------------------------------------------------------
1532:     PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1533:         LOCAL loc_cVal, loc_oBusca
1534:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1535:             RETURN
1536:         ENDIF
1537:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1538:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1539:             "cursor_4c_CliResp", "IClis", loc_cVal, ;
1540:             "Clientes - Vendedor", .F., .T., "")
1541:         IF VARTYPE(loc_oBusca) = "O"
1542:             WITH loc_oBusca
1543:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1544:                 .mAddColuna("RClis", "                                        ", "Nome")
1545:                 .Show()
1546:                 IF .this_lSelecionou
1547:                     SELECT cursor_4c_CliResp
1548:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliResp.IClis)
1549:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliResp.RClis)
1550:                 ELSE
1551:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1552:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1553:                 ENDIF
1554:             ENDWITH
1555:             loc_oBusca = .NULL.
1556:         ENDIF
1557:     ENDPROC
1558: 
1559:     *--------------------------------------------------------------------------
1560:     * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
1561:     *--------------------------------------------------------------------------
1562:     PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1563:         LOCAL loc_cVal, loc_oBusca
1564:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1565:             RETURN
1566:         ENDIF
1567:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value))
1568:             RETURN
1569:         ENDIF
1570:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1571:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1572:             "cursor_4c_CliDcontaResp", "RClis", loc_cVal, ;
1573:             "Clientes - Vendedor (Nome)", .F., .T., "")
1574:         IF VARTYPE(loc_oBusca) = "O"
1575:             WITH loc_oBusca
1576:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1577:                 .mAddColuna("RClis", "                                        ", "Nome")
1578:                 .Show()
1579:                 IF .this_lSelecionou
1580:                     SELECT cursor_4c_CliDcontaResp
1581:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaResp.IClis)
1582:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaResp.RClis)
1583:                 ELSE
1584:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1585:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1586:                 ENDIF
1587:             ENDWITH
1588:             loc_oBusca = .NULL.
1589:         ENDIF
1590:     ENDPROC
1591: 
1592:     *--------------------------------------------------------------------------
1593:     * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
1594:     * Apenas se AlterEmp = .T.
1595:     *--------------------------------------------------------------------------
1596:     PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1597:         LOCAL loc_cVal, loc_oBusca
1598:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1599:             RETURN
1600:         ENDIF
1601:         IF NOT THIS.this_lAlterEmp
1602:             RETURN
1603:         ENDIF
1604:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1605:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1606:             "cursor_4c_Emp", "Cemps", loc_cVal, ;
1607:             "Empresas", .F., .T., "")
1608:         IF VARTYPE(loc_oBusca) = "O"
1609:             WITH loc_oBusca
1610:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1611:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1612:                 .Show()
1613:                 IF .this_lSelecionou
1614:                     SELECT cursor_4c_Emp
1615:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_Emp.Cemps)
1616:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1617:                 ELSE
1618:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1619:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1620:                 ENDIF
1621:             ENDWITH
1622:             loc_oBusca = .NULL.
1623:         ENDIF
1624:     ENDPROC
1625: 
1626:     *--------------------------------------------------------------------------
1627:     * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
1628:     * Apenas se AlterEmp = .T. e CdEmpresa vazio
1629:     *--------------------------------------------------------------------------
1630:     PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1631:         LOCAL loc_cVal, loc_oBusca
1632:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1633:             RETURN
1634:         ENDIF
1635:         IF NOT THIS.this_lAlterEmp
1636:             RETURN
1637:         ENDIF
1638:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value))
1639:             RETURN
1640:         ENDIF
1641:         loc_cVal  = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1642:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1643:             "cursor_4c_EmpDs", "Razas", loc_cVal, ;
1644:             "Empresas (Raz" + CHR(227) + "o Social)", .F., .T., "")
1645:         IF VARTYPE(loc_oBusca) = "O"
1646:             WITH loc_oBusca
1647:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1648:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1649:                 .Show()
1650:                 IF .this_lSelecionou
1651:                     SELECT cursor_4c_EmpDs
1652:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Cemps)
1653:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Razas)
1654:                 ELSE
1655:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1656:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1657:                 ENDIF
1658:             ENDWITH
1659:             loc_oBusca = .NULL.
1660:         ENDIF
1661:     ENDPROC
1662: 
1663:     *--------------------------------------------------------------------------
1664:     * TxtNopKeyPress - valida numero de OP (nao pode ja existir em SigOpPic)
1665:     *--------------------------------------------------------------------------
1666:     PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1667:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1668:             RETURN
1669:         ENDIF
1670:         IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1671:             RETURN
1672:         ENDIF
1673:         IF THIS.this_oBusinessObject.VerificarNumeroOP(THIS.cnt_4c_Op.txt_4c_Nop.Value)
1674:             MsgAviso("N" + CHR(250) + "mero de OP j" + CHR(225) + " existe. Favor Corrigir!!!")
1675:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1676:         ENDIF
1677:     ENDPROC
1678: 
1679:     *--------------------------------------------------------------------------
1680:     * CarregarLista - compatibilidade FormBase (OPERACIONAL nao tem grid de lista)
1681:     *--------------------------------------------------------------------------
1682:     PROCEDURE CarregarLista()
1683:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1684:             THIS.PopularCamposIniciais()
1685:         ENDIF
1686:     ENDPROC
1687: 
1688:     *--------------------------------------------------------------------------
1689:     * AjustarBotoesPorModo - compatibilidade FormBase
1690:     *--------------------------------------------------------------------------
1691:     PROCEDURE AjustarBotoesPorModo()
1692:         THIS.AlternarPagina("ENTRADA")
1693:     ENDPROC
1694: 
1695:     *-- Stubs de compatibilidade com FormBase (OPERACIONAL nao tem CRUD)
1696:     PROCEDURE BtnIncluirClick()
1697:         THIS.CmdProcessarClick()
1698:     ENDPROC
1699: 
1700:     PROCEDURE BtnAlterarClick()
1701:         THIS.AlternarPagina("ENTRADA")
1702:     ENDPROC
1703: 
1704:     PROCEDURE BtnVisualizarClick()
1705:         THIS.AlternarPagina("ENTRADA")
1706:         THIS.PopularCamposIniciais()
1707:     ENDPROC
1708: 
1709:     PROCEDURE BtnExcluirClick()
1710:         THIS.CmdCancelarClick()
1711:     ENDPROC
1712: 
1713:     PROCEDURE BtnEncerrarClick()
1714:         THIS.CmdCancelarClick()
1715:     ENDPROC
1716: 
1717:     PROCEDURE BtnBuscarClick()
1718:         THIS.LimparCampos()
1719:         THIS.PopularCamposIniciais()
1720:         THIS.AlternarPagina("ENTRADA")
1721:     ENDPROC
1722: 
1723:     PROCEDURE BtnSalvarClick()
1724:         THIS.CmdProcessarClick()
1725:     ENDPROC
1726: 
1727:     PROCEDURE BtnCancelarClick()
1728:         THIS.AlternarPagina("ENTRADA")
1729:         THIS.LimparCampos()
1730:         THIS.PopularCamposIniciais()
1731:     ENDPROC
1732: 
1733: ENDDEFINE

