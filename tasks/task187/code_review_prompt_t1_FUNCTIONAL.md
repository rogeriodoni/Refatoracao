# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_PREVISAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1987 linhas total):

*-- Linhas 38 a 104:
38:     this_lPorDestino      = .F.
39:     this_lGerPorTp        = .F.
40:     this_lAlterEmp        = .T.
41:     *-- Controlado apos leitura de crSigCdPam em InicializarForm
42:     this_lMostrarChkPedra = .F.
43: 
44:     *--------------------------------------------------------------------------
45:     * Init - recebe flags de modo, seta propriedades e delega ao FormBase
46:     *--------------------------------------------------------------------------
47:     PROCEDURE Init(par_lReserva, par_lAutom, par_lPorDestino, par_pTipo)
48:         THIS.this_lReserva    = IIF(VARTYPE(par_lReserva)    = "L", par_lReserva,    .F.)
49:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)      = "L", par_lAutom,      .F.)
50:         THIS.this_lPorDestino = IIF(VARTYPE(par_lPorDestino) = "L", par_lPorDestino, .F.)
51:         THIS.this_lGerPorTp   = IIF(VARTYPE(par_pTipo)       = "L", par_pTipo,       .F.)
52:         RETURN DODEFAULT()
53:     ENDPROC
54: 
55:     *--------------------------------------------------------------------------
56:     * InicializarForm - cria BO, carrega parametros e monta estrutura visual
57:     *--------------------------------------------------------------------------
58:     PROTECTED PROCEDURE InicializarForm()
59:         LOCAL loc_lSucesso, loc_oErro, loc_cCaption, loc_cEmp
60:         loc_lSucesso = .F.
61: 
62:         TRY
63:             *-- Criar Business Object
64:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGloBO")
65:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
66:                 MsgErro("Falha ao criar SigPrGloBO.", "Erro")
67:                 loc_lSucesso = .F.
68:             ENDIF
69: 
70:             *-- Repassar flags de modo ao BO
71:             WITH THIS.this_oBusinessObject
72:                 .this_lReserva    = THIS.this_lReserva
73:                 .this_lAutomatico = THIS.this_lAutomatico
74:                 .this_lPorDestino = THIS.this_lPorDestino
75:                 .this_lGerPorTp   = THIS.this_lGerPorTp
76:                 .this_lAlterEmp   = THIS.this_lAlterEmp
77:             ENDWITH
78: 
79:             *-- Carregar parametros de configuracao:
80:             *-- TmpOper, crSigCdPam, crSigCdPac, TmpTpGop, CrTmpTpGop
81:             IF NOT THIS.this_oBusinessObject.CarregarParametros(THIS.this_lGerPorTp)
82:                 loc_lSucesso = .F.
83:             ENDIF
84: 
85:             *-- Caption dinamico conforme modo de operacao
86:             loc_cCaption = "Processamento de O.P."
87:             IF THIS.this_lReserva
88:                 loc_cCaption = "Processar Reserva Autom" + CHR(225) + "tica"
89:             ELSE
90:                 IF THIS.this_lGerPorTp
91:                 loc_cCaption = "Processar Ordem de Produ" + CHR(231) + CHR(227) + "o por Tipo"
92:                 ENDIF
93:             ENDIF
94:             THIS.Caption = loc_cCaption
95: 
96:             *-- Imagem de fundo
97:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
98: 
99:             *-- Determinar visibilidade futura do Chec_pedra (criado na Fase 4)
100:             *-- Condicao original: DopEmphs E DopReqcs E DopPedcs E TransfRes preenchidos
101:             IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
102:                 SELECT crSigCdPam
103:                 THIS.this_lMostrarChkPedra = ;
104:                     (NOT EMPTY(ALLTRIM(crSigCdPam.DopEmphs)) AND ;

*-- Linhas 115 a 179:
115:             THIS.ConfigurarCabecalho()
116:             THIS.ConfigurarShape()
117:             THIS.ConfigurarPaginaLista()
118:             THIS.TornarControlesVisiveis()
119:             THIS.PopularCamposIniciais()
120:             THIS.ConfigurarEventos()
121: 
122:             *-- Estado inicial: aguardando entrada do usuario
123:             THIS.AlternarPagina("ENTRADA")
124: 
125:             loc_lSucesso = .T.
126: 
127:         CATCH TO loc_oErro
128:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
129:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
130:         ENDTRY
131: 
132:         RETURN loc_lSucesso
133:     ENDPROC
134: 
135:     *--------------------------------------------------------------------------
136:     * ConfigurarCabecalho - cabecalho cinza escuro com titulo (cntSombra legado)
137:     * Top=0, Left=0, Width=680, Height=80
138:     *--------------------------------------------------------------------------
139:     PROTECTED PROCEDURE ConfigurarCabecalho()
140:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
141:         WITH THIS.cnt_4c_Cabecalho
142:             .Top        = 0
143:             .Left       = 0
144:             .Width      = THIS.Width
145:             .Height     = 80
146:             .BackStyle  = 1
147:             .BackColor  = RGB(100,100,100)
148:             .BorderWidth = 0
149:             .Visible    = .T.
150: 
151:             *-- Sombra do titulo (deslocada 1px, cor preta)
152:             .AddObject("lbl_4c_Sombra", "Label")
153:             WITH .lbl_4c_Sombra
154:                 .AutoSize    = .F.
155:                 .FontBold    = .T.
156:                 .FontName    = "Tahoma"
157:                 .FontSize    = 18
158:                 .FontUnderline = .F.
159:                 .WordWrap    = .T.
160:                 .Alignment   = 0
161:                 .BackStyle   = 0
162:                 .Height      = 40
163:                 .Left        = 10
164:                 .Top         = 18
165:                 .Width       = THIS.Width
166:                 .ForeColor   = RGB(0,0,0)
167:                 .Caption     = THIS.Caption
168:                 .Visible     = .T.
169:             ENDWITH
170: 
171:             *-- Titulo principal (branco sobre fundo escuro)
172:             .AddObject("lbl_4c_Titulo", "Label")
173:             WITH .lbl_4c_Titulo
174:                 .AutoSize    = .F.
175:                 .FontBold    = .T.
176:                 .FontName    = "Tahoma"
177:                 .FontSize    = 18
178:                 .FontUnderline = .F.
179:                 .WordWrap    = .T.

*-- Linhas 194 a 256:
194:     * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
195:     * Top=7, Left=486, Height=110, Width=173
196:     *--------------------------------------------------------------------------
197:     PROTECTED PROCEDURE ConfigurarShape()
198:         THIS.AddObject("shp_4c_Shape3", "Shape")
199:         WITH THIS.shp_4c_Shape3
200:             .Top         = 7
201:             .Left        = 486
202:             .Height      = 110
203:             .Width       = 173
204:             .BackStyle   = 0
205:             .BorderStyle = 0
206:             .BorderColor = RGB(90,90,90)
207:             .Visible     = .T.
208:         ENDWITH
209:     ENDPROC
210: 
211:     *--------------------------------------------------------------------------
212:     * ConfigurarBotoes - botoes principais Processar e Cancelar (Encerrar)
213:     * Processar: Top=3, Left=528, 75x75
214:     * Cancelar : Top=3, Left=603, 75x75
215:     *--------------------------------------------------------------------------
216:     PROTECTED PROCEDURE ConfigurarBotoes()
217:         *-- Botao Processar
218:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
219:         WITH THIS.cmd_4c_Processar
220:             .Top             = 3
221:             .Left            = 528
222:             .Height          = 75
223:             .Width           = 75
224:             .FontBold        = .T.
225:             .FontItalic      = .T.
226:             .FontName        = "Comic Sans MS"
227:             .FontSize        = 8
228:             .WordWrap        = .T.
229:             .Caption         = "Processar"
230:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
231:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
232:             .ForeColor       = RGB(90,90,90)
233:             .BackColor       = RGB(255,255,255)
234:             .Themes          = .T.
235:             .PicturePosition = 13
236:             .SpecialEffect   = 0
237:             .MousePointer    = 15
238:             .Visible         = .T.
239:         ENDWITH
240: 
241:         *-- Botao Cancelar (Encerrar) - Cancel=.T. ativa ESC (form sem TitleBar)
242:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
243:         WITH THIS.cmd_4c_Cancelar
244:             .Top             = 3
245:             .Left            = 603
246:             .Height          = 75
247:             .Width           = 75
248:             .FontBold        = .T.
249:             .FontItalic      = .T.
250:             .FontName        = "Comic Sans MS"
251:             .FontSize        = 8
252:             .WordWrap        = .T.
253:             .Caption         = "Encerrar"
254:             .Cancel          = .T.
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
256:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 276 a 319:
276:     *   Cnt_Previsao-> cnt_4c_Previsao  (GetPrevisao + GetGeracao)
277:     *   Cnt_Op      -> cnt_4c_Op        (GetNop - visivel apenas se GlobAutos=2)
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarContainers()
280:         LOCAL loc_lGlobAutos2
281:         loc_lGlobAutos2 = .F.
282:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
283:             SELECT crSigCdPam
284:             loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
285:         ENDIF
286: 
287:         *-- Container1 legado: Tipo de O.P. - habilitado so no modo GerPorTp
288:         THIS.AddObject("cnt_4c_TipoOp", "Container")
289:         WITH THIS.cnt_4c_TipoOp
290:             .Top         = 164
291:             .Left        = 139
292:             .Width       = 346
293:             .Height      = 25
294:             .BackStyle   = 0
295:             .BorderWidth = 0
296:             .Enabled     = THIS.this_lGerPorTp
297:             .Visible     = .T.
298:         ENDWITH
299: 
300:         *-- Opera??o legado: codigo/faixa inicial/final de OP
301:         THIS.AddObject("cnt_4c_Operacao", "Container")
302:         WITH THIS.cnt_4c_Operacao
303:             .Top         = 191
304:             .Left        = 139
305:             .Width       = 350
306:             .Height      = 25
307:             .BackStyle   = 0
308:             .BorderWidth = 0
309:             .Visible     = .T.
310:         ENDWITH
311: 
312:         *-- Conta legado: grupo/conta/descricao para filtro de movimentacao
313:         THIS.AddObject("cnt_4c_Conta", "Container")
314:         WITH THIS.cnt_4c_Conta
315:             .Top         = 218
316:             .Left        = 139
317:             .Width       = 553
318:             .Height      = 25
319:             .BackStyle   = 0

*-- Linhas 375 a 501:
375:     ENDPROC
376: 
377:     *--------------------------------------------------------------------------
378:     * TornarControlesVisiveis - torna controles do form visiveis apos AddObject
379:     * Preserva Visible=.F. de containers hidden-por-design (cnt_4c_Op,
380:     * cnt_4c_Previsao em modo Reserva), mas recursa seus filhos antes do LOOP
381:     * para que estejam prontos quando o container vier a ser exibido.
382:     *--------------------------------------------------------------------------
383:     PROCEDURE TornarControlesVisiveis()
384:         LOCAL loc_i, loc_oCtrl, loc_lSkip
385:         FOR loc_i = 1 TO THIS.ControlCount
386:             loc_oCtrl = THIS.Controls(loc_i)
387:             IF VARTYPE(loc_oCtrl) != "O"
388:                 LOOP
389:             ENDIF
390:             loc_lSkip = (UPPER(loc_oCtrl.Name) = "CNT_4C_OP") OR ;
391:                         (UPPER(loc_oCtrl.Name) = "CNT_4C_PREVISAO" AND THIS.this_lReserva)
392:             IF loc_lSkip
393:                 *-- Recursar filhos ANTES do LOOP (regra anti-ghost para containers hidden)
394:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
395:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
396:                 ENDIF
397:                 LOOP
398:             ENDIF
399:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
400:                 loc_oCtrl.Visible = .T.
401:             ENDIF
402:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
403:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
404:             ENDIF
405:         ENDFOR
406:     ENDPROC
407: 
408:     *--------------------------------------------------------------------------
409:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
410:         LOCAL loc_i, loc_oCtrl
411:         FOR loc_i = 1 TO par_oContainer.ControlCount
412:             loc_oCtrl = par_oContainer.Controls(loc_i)
413:             IF VARTYPE(loc_oCtrl) = "O"
414:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
415:                     loc_oCtrl.Visible = .T.
416:                 ENDIF
417:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
418:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
419:                 ENDIF
420:             ENDIF
421:         ENDFOR
422:     ENDPROC
423: 
424:     *--------------------------------------------------------------------------
425:     * Destroy - libera cursores temporarios e BO antes de fechar
426:     *--------------------------------------------------------------------------
427:     PROCEDURE Destroy()
428:         IF USED("TmpOper")
429:             USE IN TmpOper
430:         ENDIF
431:         IF USED("TmpOper2")
432:             USE IN TmpOper2
433:         ENDIF
434:         IF USED("CrTmpTpGop")
435:             USE IN CrTmpTpGop
436:         ENDIF
437:         IF USED("TmpTpGop")
438:             USE IN TmpTpGop
439:         ENDIF
440:         IF USED("crSigCdPam")
441:             USE IN crSigCdPam
442:         ENDIF
443:         IF USED("crSigCdPac")
444:             USE IN crSigCdPac
445:         ENDIF
446:         IF USED("crSigCdOpd")
447:             USE IN crSigCdOpd
448:         ENDIF
449:         IF USED("DBParam")
450:             USE IN DBParam
451:         ENDIF
452:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
453:             THIS.this_oBusinessObject = .NULL.
454:         ENDIF
455:         DODEFAULT()
456:     ENDPROC
457: 
458:     *--------------------------------------------------------------------------
459:     * ConfigurarCamposForm - labels e textboxes de data diretamente no form
460:     *--------------------------------------------------------------------------
461:     PROTECTED PROCEDURE ConfigurarCamposForm()
462:         THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
463:         WITH THIS.lbl_4c_PeriodoEmissao
464:             .AutoSize  = .F.
465:             .BackStyle = 0
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90,90,90)
469:             .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
470:             .Height    = 15
471:             .Left      = 32
472:             .Top       = 115
473:             .Width     = 101
474:         ENDWITH
475: 
476:         THIS.AddObject("txt_4c_Dataei", "TextBox")
477:         WITH THIS.txt_4c_Dataei
478:             .Alignment     = 3
479:             .Value         = {}
480:             .Format        = "K"
481:             .Height        = 23
482:             .Left          = 142
483:             .Top           = 111
484:             .Width         = 80
485:             .SpecialEffect = 1
486:             .FontName      = "Tahoma"
487:             .FontSize      = 8
488:         ENDWITH
489: 
490:         THIS.AddObject("lbl_4c_Ate1", "Label")
491:         WITH THIS.lbl_4c_Ate1
492:             .AutoSize  = .F.
493:             .BackStyle = 0
494:             .FontName  = "Tahoma"
495:             .FontSize  = 8
496:             .ForeColor = RGB(90,90,90)
497:             .Caption   = "at" + CHR(233)
498:             .Height    = 15
499:             .Left      = 227
500:             .Top       = 115
501:             .Width     = 18

*-- Linhas 645 a 706:
645:     *--------------------------------------------------------------------------
646:     * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
647:     *--------------------------------------------------------------------------
648:     PROTECTED PROCEDURE ConfigurarContainerTipoOp()
649:         THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
650:         WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
651:             .Left          = 3
652:             .Top           = 1
653:             .Width         = 80
654:             .Height        = 23
655:             .MaxLength     = 10
656:             .FontName      = "Courier New"
657:             .FontSize      = 9
658:             .Margin        = 2
659:             .SpecialEffect = 1
660:         ENDWITH
661:     ENDPROC
662: 
663:     *--------------------------------------------------------------------------
664:     * ConfigurarContainerOperacao - Opera_ao legado: codigo + faixa i/f
665:     *--------------------------------------------------------------------------
666:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
667:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
668:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
669:             .Left          = 3
670:             .Top           = 1
671:             .Width         = 151
672:             .Height        = 23
673:             .MaxLength     = 20
674:             .FontName      = "Courier New"
675:             .FontSize      = 9
676:             .Margin        = 2
677:             .SpecialEffect = 1
678:         ENDWITH
679: 
680:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
681:         WITH THIS.cnt_4c_Operacao.lbl_4c_De
682:             .AutoSize  = .F.
683:             .BackStyle = 0
684:             .FontName  = "Tahoma"
685:             .FontSize  = 8
686:             .ForeColor = RGB(90,90,90)
687:             .Caption   = "de"
688:             .Height    = 15
689:             .Left      = 180
690:             .Top       = 5
691:             .Width     = 14
692:         ENDWITH
693: 
694:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
695:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
696:             .Alignment     = 3
697:             .Value         = 0
698:             .Format        = "K"
699:             .Height        = 23
700:             .InputMask     = "999999"
701:             .Left          = 201
702:             .Top           = 1
703:             .Width         = 55
704:             .MaxLength     = 6
705:             .SpecialEffect = 1
706:             .FontName      = "Courier New"

*-- Linhas 741 a 860:
741:     *--------------------------------------------------------------------------
742:     * ConfigurarContainerConta - Movimentacao: grupo/conta/descricao
743:     *--------------------------------------------------------------------------
744:     PROTECTED PROCEDURE ConfigurarContainerConta()
745:         THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
746:         WITH THIS.cnt_4c_Conta.txt_4c_Grupo
747:             .Left          = 3
748:             .Top           = 1
749:             .Width         = 80
750:             .Height        = 23
751:             .SpecialEffect = 1
752:             .FontName      = "Tahoma"
753:             .FontSize      = 8
754:         ENDWITH
755: 
756:         THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
757:         WITH THIS.cnt_4c_Conta.txt_4c_Conta
758:             .Left          = 86
759:             .Top           = 1
760:             .Width         = 80
761:             .Height        = 23
762:             .SpecialEffect = 1
763:             .FontName      = "Tahoma"
764:             .FontSize      = 8
765:         ENDWITH
766: 
767:         THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
768:         WITH THIS.cnt_4c_Conta.txt_4c_Dconta
769:             .Left          = 170
770:             .Top           = 1
771:             .Width         = 360
772:             .Height        = 23
773:             .SpecialEffect = 1
774:             .FontName      = "Tahoma"
775:             .FontSize      = 8
776:         ENDWITH
777:     ENDPROC
778: 
779:     *--------------------------------------------------------------------------
780:     * ConfigurarContainerResponsavel - Vendedor: grupo/conta/descricao
781:     *--------------------------------------------------------------------------
782:     PROTECTED PROCEDURE ConfigurarContainerResponsavel()
783:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
784:         WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
785:             .Left          = 3
786:             .Top           = 1
787:             .Width         = 80
788:             .Height        = 23
789:             .SpecialEffect = 1
790:             .FontName      = "Tahoma"
791:             .FontSize      = 8
792:         ENDWITH
793: 
794:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
795:         WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
796:             .Left          = 86
797:             .Top           = 1
798:             .Width         = 80
799:             .Height        = 23
800:             .SpecialEffect = 1
801:             .FontName      = "Tahoma"
802:             .FontSize      = 8
803:         ENDWITH
804: 
805:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
806:         WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
807:             .Left          = 170
808:             .Top           = 1
809:             .Width         = 360
810:             .Height        = 23
811:             .SpecialEffect = 1
812:             .FontName      = "Tahoma"
813:             .FontSize      = 8
814:         ENDWITH
815:     ENDPROC
816: 
817:     *--------------------------------------------------------------------------
818:     * ConfigurarContainerEmpresa - cd_empresa / ds_empresa / chk pedras
819:     *--------------------------------------------------------------------------
820:     PROTECTED PROCEDURE ConfigurarContainerEmpresa()
821:         THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
822:         WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
823:             .Left          = 4
824:             .Top           = 1
825:             .Width         = 31
826:             .Height        = 23
827:             .InputMask     = "XXX"
828:             .MaxLength     = 3
829:             .Format        = "k"
830:             .BackStyle     = 1
831:             .BorderStyle   = 1
832:             .ForeColor     = RGB(0,0,0)
833:             .FontName      = "Courier New"
834:             .FontSize      = 9
835:             .SpecialEffect = 1
836:         ENDWITH
837: 
838:         THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
839:         WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
840:             .Left          = 38
841:             .Top           = 1
842:             .Width         = 282
843:             .Height        = 23
844:             .MaxLength     = 40
845:             .Format        = "K"
846:             .FontName      = "Courier New"
847:             .FontSize      = 9
848:             .SpecialEffect = 1
849:         ENDWITH
850: 
851:         THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
852:         WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
853:             .Left      = 330
854:             .Top       = 5
855:             .Height    = 15
856:             .Width     = 124
857:             .FontName  = "Tahoma"
858:             .FontSize  = 8
859:             .BackStyle = 0
860:             .Caption   = "N" + CHR(227) + "o Empenhar Pedras"

*-- Linhas 867 a 910:
867:     *--------------------------------------------------------------------------
868:     * ConfigurarContainerPrevisao - data previsao entrega + data geracao
869:     *--------------------------------------------------------------------------
870:     PROTECTED PROCEDURE ConfigurarContainerPrevisao()
871:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
872:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
873:             .AutoSize  = .F.
874:             .BackStyle = 0
875:             .FontName  = "Tahoma"
876:             .FontSize  = 8
877:             .ForeColor = RGB(90,90,90)
878:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
879:             .Height    = 15
880:             .Left      = 7
881:             .Top       = 9
882:             .Width     = 106
883:         ENDWITH
884: 
885:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
886:         WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
887:             .Alignment     = 3
888:             .Value         = {}
889:             .Format        = "K"
890:             .Height        = 23
891:             .Left          = 134
892:             .Top           = 5
893:             .Width         = 80
894:             .SpecialEffect = 1
895:             .FontName      = "Tahoma"
896:             .FontSize      = 8
897:         ENDWITH
898: 
899:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
900:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
901:             .AutoSize  = .F.
902:             .BackStyle = 0
903:             .FontName  = "Tahoma"
904:             .FontSize  = 8
905:             .ForeColor = RGB(90,90,90)
906:             .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
907:             .Height    = 15
908:             .Left      = 244
909:             .Top       = 9
910:             .Width     = 90

*-- Linhas 928 a 1099:
928:     *--------------------------------------------------------------------------
929:     * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
930:     *--------------------------------------------------------------------------
931:     PROTECTED PROCEDURE ConfigurarContainerOp()
932:         THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
933:         WITH THIS.cnt_4c_Op.lbl_4c_LblNop
934:             .AutoSize  = .F.
935:             .BackStyle = 0
936:             .FontName  = "Tahoma"
937:             .FontSize  = 8
938:             .ForeColor = RGB(90,90,90)
939:             .Caption   = "N" + CHR(186) + " da O.P.:"
940:             .Height    = 15
941:             .Left      = 0
942:             .Top       = 5
943:             .Width     = 58
944:         ENDWITH
945: 
946:         THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
947:         WITH THIS.cnt_4c_Op.txt_4c_Nop
948:             .Alignment     = 3
949:             .Value         = 0
950:             .Height        = 23
951:             .InputMask     = "999999"
952:             .Left          = 71
953:             .Top           = 1
954:             .Width         = 59
955:             .MaxLength     = 6
956:             .SpecialEffect = 1
957:             .FontName      = "Tahoma"
958:             .FontSize      = 8
959:         ENDWITH
960:     ENDPROC
961: 
962:     *--------------------------------------------------------------------------
963:     * PopularCamposIniciais - preenche valores iniciais apos criacao dos controles
964:     *--------------------------------------------------------------------------
965:     PROTECTED PROCEDURE PopularCamposIniciais()
966:         LOCAL loc_oErro
967:         TRY
968:             *-- Empresa: dados ja carregados pelo BO via CarregarEmpresa
969:             THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = THIS.this_oBusinessObject.this_cCdEmpresa
970:             THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = THIS.this_oBusinessObject.this_cDsEmpresa
971: 
972:             *-- Previsao de entrega: data atual + PrevProds dias (parametro SigCdPam)
973:             IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
974:                 SELECT crSigCdPam
975:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + crSigCdPam.PrevProds
976:             ENDIF
977: 
978:             *-- Data de geracao: data atual (apenas se nao modo automatico)
979:             IF NOT THIS.this_lAutomatico
980:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
981:             ENDIF
982: 
983:             *-- Checkbox pedras: visibilidade calculada em InicializarForm
984:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
985: 
986:             *-- Tipo de OP: pre-selecionar se GerPorTp e apenas 1 tipo disponivel
987:             IF THIS.this_lGerPorTp AND NOT EMPTY(THIS.this_oBusinessObject.this_cTpGOp)
988:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = THIS.this_oBusinessObject.this_cTpGOp
989:             ENDIF
990:         CATCH TO loc_oErro
991:             MsgErro("Erro ao popular campos: " + loc_oErro.Message, "Erro")
992:         ENDTRY
993:     ENDPROC
994: 
995:     *--------------------------------------------------------------------------
996:     * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
997:     *--------------------------------------------------------------------------
998:     PROTECTED PROCEDURE ConfigurarEventos()
999:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1000:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
1001:         BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
1002:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
1003:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
1004:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
1005:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")
1006:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta,           "KeyPress", THIS, "TxtDcontaKeyPress")
1007:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "TxtGrupoRespKeyPress")
1008:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "TxtContaRespKeyPress")
1009:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "TxtDcontaRespKeyPress")
1010:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa,      "KeyPress", THIS, "TxtCdEmpresaKeyPress")
1011:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa,      "KeyPress", THIS, "TxtDsEmpresaKeyPress")
1012:         BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop,                 "KeyPress", THIS, "TxtNopKeyPress")
1013:     ENDPROC
1014: 
1015:     *--------------------------------------------------------------------------
1016:     * CmdProcessarClick - valida campos, copia ao BO e executa processamento
1017:     *
1018:     * Gerenciamento de estado (equivalente aos BtnIncluirClick/Alterar/etc. do CRUD):
1019:     *   1. Validacoes (retorna se falha - UI permanece em ENTRADA)
1020:     *   2. Copia campos do form para o BO
1021:     *   3. AlternarPagina("PROCESSANDO") - bloqueia UI durante operacao
1022:     *   4. BO.ProcessarOrdens() - logica de negocio
1023:     *   5. AlternarPagina("ENTRADA") - restaura UI (sempre, inclusive em erro)
1024:     *--------------------------------------------------------------------------
1025:     PROCEDURE CmdProcessarClick()
1026:         LOCAL loc_nGlobAutos, loc_oErro, loc_lProcessou
1027:         loc_nGlobAutos  = 0
1028:         loc_lProcessou  = .F.
1029: 
1030:         *-- Validar previsao e geracao (obrigatorias em modo normal)
1031:         IF NOT THIS.this_lReserva
1032:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
1033:                 MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!", "Aviso")
1034:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
1035:                 RETURN
1036:             ENDIF
1037:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
1038:                 MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!", "Aviso")
1039:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
1040:                 RETURN
1041:             ENDIF
1042:         ENDIF
1043: 
1044:         *-- Validar numero OP manual (GlobAutos=2)
1045:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
1046:             SELECT crSigCdPam
1047:             loc_nGlobAutos = crSigCdPam.GlobAutos
1048:             IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
1049:                 IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1050:                     MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!", "Aviso")
1051:                     THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
1052:                     RETURN
1053:                 ENDIF
1054:             ENDIF
1055:         ENDIF
1056: 
1057:         *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
1058:         IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
1059:             MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
1060:                      " Obrigat" + CHR(243) + "rio ser Preenchido!!!", "Aviso")
1061:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus
1062:             RETURN
1063:         ENDIF
1064: 
1065:         *-- Copiar campos do form para o BO
1066:         WITH THIS.this_oBusinessObject
1067:             .this_dDataei      = THIS.txt_4c_Dataei.Value
1068:             .this_dDataef      = THIS.txt_4c_Dataef.Value
1069:             .this_dDatapi      = THIS.txt_4c_Datapi.Value
1070:             .this_dDatapf      = THIS.txt_4c_Datapf.Value
1071:             .this_cOperacao    = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1072:             .this_nOperacaoi   = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1073:             .this_nOperacaof   = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
1074:             .this_cGrupoConta  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1075:             .this_cConta       = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1076:             .this_cDconta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1077:             .this_cGrupoResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1078:             .this_cContaResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1079:             .this_cCdEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1080:             .this_nNaoEmpPedra = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
1081:             .this_cTpGOp       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1082:             .this_dPrevisao    = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
1083:             .this_dGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
1084:             .this_nNop         = THIS.cnt_4c_Op.txt_4c_Nop.Value
1085:         ENDWITH
1086: 
1087:         *-- Bloquear UI durante processamento (equivale ao "estado PROCESSANDO")
1088:         THIS.AlternarPagina("PROCESSANDO")
1089: 
1090:         TRY
1091:             loc_lProcessou = THIS.this_oBusinessObject.ProcessarOrdens()
1092:         CATCH TO loc_oErro
1093:             MsgErro("Erro no processamento: " + loc_oErro.Message + ;
1094:                     " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1095:             loc_lProcessou = .F.
1096:         ENDTRY
1097: 
1098:         *-- Restaurar UI (sempre - inclusive em caso de erro)
1099:         THIS.AlternarPagina("ENTRADA")

*-- Linhas 1106 a 1596:
1106:     *--------------------------------------------------------------------------
1107:     * CmdCancelarClick - fecha o formulario (Encerrar)
1108:     *--------------------------------------------------------------------------
1109:     PROCEDURE CmdCancelarClick()
1110:         THIS.Release()
1111:     ENDPROC
1112: 
1113:     *--------------------------------------------------------------------------
1114:     * TxtTpGOpKeyPress - lookup tipo de OP (CrTmpTpGop - cursor VFP local)
1115:     *--------------------------------------------------------------------------
1116:     PROCEDURE TxtTpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1117:         LOCAL loc_cVal, loc_oBusca
1118:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1119:             RETURN
1120:         ENDIF
1121:         IF NOT THIS.cnt_4c_TipoOp.Enabled
1122:             RETURN
1123:         ENDIF
1124:         loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1125:         *-- Tentar SEEK direto antes de abrir picker
1126:         IF NOT EMPTY(loc_cVal) AND USED("CrTmpTpGop")
1127:             SELECT CrTmpTpGop
1128:             IF SEEK(loc_cVal, "CrTmpTpGop", "Codigos")
1129:                 RETURN
1130:             ENDIF
1131:         ENDIF
1132:         IF NOT USED("CrTmpTpGop")
1133:             MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.", "Aviso")
1134:             RETURN
1135:         ENDIF
1136:         *-- Pre-popular cursor e abrir picker
1137:         IF USED("cursor_4c_TpGOp")
1138:             USE IN cursor_4c_TpGOp
1139:         ENDIF
1140:         SELECT Codigos, Descs FROM CrTmpTpGop INTO CURSOR cursor_4c_TpGOp READWRITE
1141:         SELECT cursor_4c_TpGOp
1142:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1143:         IF VARTYPE(loc_oBusca) = "O"
1144:             WITH loc_oBusca
1145:                 .this_cCursorDestino = "cursor_4c_TpGOp"
1146:                 .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
1147:                 .this_cCampoBusca    = "Codigos"
1148:                 .this_cValorBusca    = loc_cVal
1149:                 .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1150:                 .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1151:                 .Show()
1152:                 IF .this_lSelecionou
1153:                     SELECT cursor_4c_TpGOp
1154:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
1155:                 ELSE
1156:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1157:                 ENDIF
1158:             ENDWITH
1159:             loc_oBusca = .NULL.
1160:         ENDIF
1161:     ENDPROC
1162: 
1163:     *--------------------------------------------------------------------------
1164:     * TxtOperacaoKeyPress - lookup operacao (TmpOper - cursor VFP local)
1165:     *--------------------------------------------------------------------------
1166:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1167:         LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
1168:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1169:             RETURN
1170:         ENDIF
1171:         loc_cVal = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1172:         *-- Vazio: limpar faixa inicial/final
1173:         IF EMPTY(loc_cVal)
1174:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1175:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1176:             RETURN
1177:         ENDIF
1178:         IF NOT USED("TmpOper")
1179:             MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas.", "Aviso")
1180:             RETURN
1181:         ENDIF
1182:         *-- Montar cursor filtrado por TpGOp se necessario
1183:         IF USED("cursor_4c_Oper")
1184:             USE IN cursor_4c_Oper
1185:         ENDIF
1186:         IF THIS.this_lGerPorTp
1187:             loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1188:             SELECT Dopes, NDopes FROM TmpOper WHERE CodTgOps = loc_cTpGOp INTO CURSOR cursor_4c_Oper READWRITE
1189:         ELSE
1190:             SELECT Dopes, NDopes FROM TmpOper INTO CURSOR cursor_4c_Oper READWRITE
1191:         ENDIF
1192:         SELECT cursor_4c_Oper
1193:         INDEX ON Dopes TAG Dopes
1194:         *-- Tentar SEEK direto
1195:         IF SEEK(loc_cVal, "cursor_4c_Oper", "Dopes")
1196:             RETURN
1197:         ENDIF
1198:         *-- Abrir picker
1199:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1200:         IF VARTYPE(loc_oBusca) = "O"
1201:             WITH loc_oBusca
1202:                 .this_cCursorDestino = "cursor_4c_Oper"
1203:                 .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
1204:                 .this_cCampoBusca    = "Dopes"
1205:                 .this_cValorBusca    = loc_cVal
1206:                 .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
1207:                 .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
1208:                 .Show()
1209:                 IF .this_lSelecionou
1210:                     SELECT cursor_4c_Oper
1211:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_Oper.Dopes)
1212:                 ELSE
1213:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value   = ""
1214:                     THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value  = 0
1215:                     THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value  = 0
1216:                 ENDIF
1217:             ENDWITH
1218:             loc_oBusca = .NULL.
1219:         ENDIF
1220:     ENDPROC
1221: 
1222:     *--------------------------------------------------------------------------
1223:     * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
1224:     *--------------------------------------------------------------------------
1225:     PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1226:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1227:             RETURN
1228:         ENDIF
1229:         IF THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value > 0 AND ;
1230:            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1231:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1232:         ENDIF
1233:     ENDPROC
1234: 
1235:     *--------------------------------------------------------------------------
1236:     * TxtGrupoContaKeyPress - lookup grupo contabil (SigCdGcr) para Movimentacao
1237:     *--------------------------------------------------------------------------
1238:     PROCEDURE TxtGrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1239:         LOCAL loc_cVal, loc_oBusca
1240:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1241:             RETURN
1242:         ENDIF
1243:         loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1244:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1245:             "cursor_4c_GrpConta", "codigos", loc_cVal, ;
1246:             "Grupos Cont" + CHR(225) + "beis", .F., .T., "")
1247:         IF VARTYPE(loc_oBusca) = "O"
1248:             WITH loc_oBusca
1249:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1250:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1251:                 .Show()
1252:                 IF .this_lSelecionou
1253:                     SELECT cursor_4c_GrpConta
1254:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpConta.codigos)
1255:                 ELSE
1256:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
1257:                 ENDIF
1258:             ENDWITH
1259:             loc_oBusca = .NULL.
1260:         ENDIF
1261:     ENDPROC
1262: 
1263:     *--------------------------------------------------------------------------
1264:     * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
1265:     *--------------------------------------------------------------------------
1266:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1267:         LOCAL loc_cVal, loc_oBusca
1268:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1269:             RETURN
1270:         ENDIF
1271:         loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1272:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1273:             "cursor_4c_CliConta", "IClis", loc_cVal, ;
1274:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o", .F., .T., "")
1275:         IF VARTYPE(loc_oBusca) = "O"
1276:             WITH loc_oBusca
1277:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1278:                 .mAddColuna("RClis", "                                        ", "Nome")
1279:                 .Show()
1280:                 IF .this_lSelecionou
1281:                     SELECT cursor_4c_CliConta
1282:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliConta.IClis)
1283:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliConta.RClis)
1284:                 ELSE
1285:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1286:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1287:                 ENDIF
1288:             ENDWITH
1289:             loc_oBusca = .NULL.
1290:         ENDIF
1291:     ENDPROC
1292: 
1293:     *--------------------------------------------------------------------------
1294:     * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
1295:     *--------------------------------------------------------------------------
1296:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1297:         LOCAL loc_cVal, loc_oBusca
1298:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1299:             RETURN
1300:         ENDIF
1301:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value))
1302:             RETURN
1303:         ENDIF
1304:         loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1305:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1306:             "cursor_4c_CliDconta", "RClis", loc_cVal, ;
1307:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o (Nome)", .F., .T., "")
1308:         IF VARTYPE(loc_oBusca) = "O"
1309:             WITH loc_oBusca
1310:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1311:                 .mAddColuna("RClis", "                                        ", "Nome")
1312:                 .Show()
1313:                 IF .this_lSelecionou
1314:                     SELECT cursor_4c_CliDconta
1315:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDconta.IClis)
1316:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDconta.RClis)
1317:                 ELSE
1318:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1319:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1320:                 ENDIF
1321:             ENDWITH
1322:             loc_oBusca = .NULL.
1323:         ENDIF
1324:     ENDPROC
1325: 
1326:     *--------------------------------------------------------------------------
1327:     * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
1328:     *--------------------------------------------------------------------------
1329:     PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1330:         LOCAL loc_cVal, loc_oBusca
1331:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1332:             RETURN
1333:         ENDIF
1334:         loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1335:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1336:             "cursor_4c_GrpResp", "codigos", loc_cVal, ;
1337:             "Grupos - Vendedor", .F., .T., "")
1338:         IF VARTYPE(loc_oBusca) = "O"
1339:             WITH loc_oBusca
1340:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1341:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1342:                 .Show()
1343:                 IF .this_lSelecionou
1344:                     SELECT cursor_4c_GrpResp
1345:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpResp.codigos)
1346:                 ELSE
1347:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
1348:                 ENDIF
1349:             ENDWITH
1350:             loc_oBusca = .NULL.
1351:         ENDIF
1352:     ENDPROC
1353: 
1354:     *--------------------------------------------------------------------------
1355:     * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
1356:     *--------------------------------------------------------------------------
1357:     PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1358:         LOCAL loc_cVal, loc_oBusca
1359:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1360:             RETURN
1361:         ENDIF
1362:         loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1363:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1364:             "cursor_4c_CliResp", "IClis", loc_cVal, ;
1365:             "Clientes - Vendedor", .F., .T., "")
1366:         IF VARTYPE(loc_oBusca) = "O"
1367:             WITH loc_oBusca
1368:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1369:                 .mAddColuna("RClis", "                                        ", "Nome")
1370:                 .Show()
1371:                 IF .this_lSelecionou
1372:                     SELECT cursor_4c_CliResp
1373:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliResp.IClis)
1374:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliResp.RClis)
1375:                 ELSE
1376:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1377:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1378:                 ENDIF
1379:             ENDWITH
1380:             loc_oBusca = .NULL.
1381:         ENDIF
1382:     ENDPROC
1383: 
1384:     *--------------------------------------------------------------------------
1385:     * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
1386:     *--------------------------------------------------------------------------
1387:     PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1388:         LOCAL loc_cVal, loc_oBusca
1389:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1390:             RETURN
1391:         ENDIF
1392:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value))
1393:             RETURN
1394:         ENDIF
1395:         loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1396:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1397:             "cursor_4c_CliDcontaResp", "RClis", loc_cVal, ;
1398:             "Clientes - Vendedor (Nome)", .F., .T., "")
1399:         IF VARTYPE(loc_oBusca) = "O"
1400:             WITH loc_oBusca
1401:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1402:                 .mAddColuna("RClis", "                                        ", "Nome")
1403:                 .Show()
1404:                 IF .this_lSelecionou
1405:                     SELECT cursor_4c_CliDcontaResp
1406:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaResp.IClis)
1407:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaResp.RClis)
1408:                 ELSE
1409:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1410:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1411:                 ENDIF
1412:             ENDWITH
1413:             loc_oBusca = .NULL.
1414:         ENDIF
1415:     ENDPROC
1416: 
1417:     *--------------------------------------------------------------------------
1418:     * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
1419:     *   Apenas se AlterEmp = .T.
1420:     *--------------------------------------------------------------------------
1421:     PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1422:         LOCAL loc_cVal, loc_oBusca
1423:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1424:             RETURN
1425:         ENDIF
1426:         IF NOT THIS.this_lAlterEmp
1427:             RETURN
1428:         ENDIF
1429:         loc_cVal = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1430:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1431:             "cursor_4c_Emp", "Cemps", loc_cVal, ;
1432:             "Empresas", .F., .T., "")
1433:         IF VARTYPE(loc_oBusca) = "O"
1434:             WITH loc_oBusca
1435:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1436:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1437:                 .Show()
1438:                 IF .this_lSelecionou
1439:                     SELECT cursor_4c_Emp
1440:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_Emp.Cemps)
1441:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1442:                 ELSE
1443:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1444:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1445:                 ENDIF
1446:             ENDWITH
1447:             loc_oBusca = .NULL.
1448:         ENDIF
1449:     ENDPROC
1450: 
1451:     *--------------------------------------------------------------------------
1452:     * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
1453:     *   Apenas se AlterEmp = .T. e CdEmpresa vazio
1454:     *--------------------------------------------------------------------------
1455:     PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1456:         LOCAL loc_cVal, loc_oBusca
1457:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1458:             RETURN
1459:         ENDIF
1460:         IF NOT THIS.this_lAlterEmp
1461:             RETURN
1462:         ENDIF
1463:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value))
1464:             RETURN
1465:         ENDIF
1466:         loc_cVal = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1467:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1468:             "cursor_4c_EmpDs", "Razas", loc_cVal, ;
1469:             "Empresas (Raz" + CHR(227) + "o Social)", .F., .T., "")
1470:         IF VARTYPE(loc_oBusca) = "O"
1471:             WITH loc_oBusca
1472:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1473:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1474:                 .Show()
1475:                 IF .this_lSelecionou
1476:                     SELECT cursor_4c_EmpDs
1477:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Cemps)
1478:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Razas)
1479:                 ELSE
1480:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1481:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1482:                 ENDIF
1483:             ENDWITH
1484:             loc_oBusca = .NULL.
1485:         ENDIF
1486:     ENDPROC
1487: 
1488:     *--------------------------------------------------------------------------
1489:     * TxtNopKeyPress - valida numero de OP: nao pode ja existir em SigOpPic
1490:     *--------------------------------------------------------------------------
1491:     PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1492:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1493:             RETURN
1494:         ENDIF
1495:         IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1496:             RETURN
1497:         ENDIF
1498:         IF NOT THIS.this_oBusinessObject.ValidarNumeroOP(THIS.cnt_4c_Op.txt_4c_Nop.Value)
1499:             MsgAviso("N" + CHR(250) + "mero de OP j" + CHR(225) + " existe. Favor Corrigir!!!", "Aviso")
1500:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1501:         ENDIF
1502:     ENDPROC
1503: 
1504:     *--------------------------------------------------------------------------
1505:     * ConfigurarPaginaLista - monta a "pagina de entrada" (equivalente da Lista em CRUD)
1506:     *
1507:     * Form OPERACIONAL nao possui Grid/CRUD. A "pagina de entrada" agrupa:
1508:     *   - botoes de acao (Processar / Encerrar)
1509:     *   - containers de filtros/parametros (Tipo OP, Operacao, Conta, Responsavel,
1510:     *     Empresa, Previsao, N. OP manual) e os campos avulsos de data (Emissao)
1511:     *
1512:     * Este metodo consolida a construcao visual da area principal, chamado uma
1513:     * unica vez em InicializarForm apos ConfigurarCabecalho/ConfigurarShape.
1514:     *--------------------------------------------------------------------------
1515:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1516:         *-- Botoes de acao (Processar / Cancelar)
1517:         THIS.ConfigurarBotoes()
1518: 
1519:         *-- Containers principais (esqueletos vazios)
1520:         THIS.ConfigurarContainers()
1521: 
1522:         *-- Campos avulsos no form (labels + textboxes de data de emissao/previsao)
1523:         THIS.ConfigurarCamposForm()
1524: 
1525:         *-- Populacao interna de cada container
1526:         THIS.ConfigurarContainerTipoOp()
1527:         THIS.ConfigurarContainerOperacao()
1528:         THIS.ConfigurarContainerConta()
1529:         THIS.ConfigurarContainerResponsavel()
1530:         THIS.ConfigurarContainerEmpresa()
1531:         THIS.ConfigurarContainerPrevisao()
1532:         THIS.ConfigurarContainerOp()
1533:     ENDPROC
1534: 
1535:     *--------------------------------------------------------------------------
1536:     * ConfigurarPaginaDados - todos os containers de parametros (Fase 6)
1537:     *
1538:     * Form OPERACIONAL nao tem Page2 (Dados) como CRUD. Este metodo cobre
1539:     * TODOS os 7 containers de parametros em padrao idempotente (checa
1540:     * existencia antes de criar). Pode ser chamado de forma segura em
1541:     * qualquer ordem em relacao ao ConfigurarPaginaLista().
1542:     *
1543:     * Containers cobertos:
1544:     *   1. Cabecalho cinza (cnt_4c_Cabecalho)
1545:     *   2. Shape decorativo (shp_4c_Shape3)
1546:     *   3. Botoes principais (cmd_4c_Processar / cmd_4c_Cancelar)
1547:     *   4. Labels e campos de data avulsos no form
1548:     *   5. cnt_4c_TipoOp  - Tipo de O.P. (txt_4c_TpGOp)
1549:     *   6. cnt_4c_Operacao - Operacao + faixa i/f
1550:     *   7. cnt_4c_Conta    - Movimentacao: grupo/conta/dconta
1551:     *   8. cnt_4c_Responsavel - Vendedor: grupo/conta/dconta
1552:     *   9. cnt_4c_Empresa  - cd_empresa / ds_empresa / chk pedras
1553:     *  10. cnt_4c_Previsao - data previsao entrega + data geracao
1554:     *  11. cnt_4c_Op       - numero da OP manual (visivel em GlobAutos=2)
1555:     *--------------------------------------------------------------------------
1556:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1557:         LOCAL loc_lGlobAutos2
1558:         loc_lGlobAutos2 = .F.
1559:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
1560:             SELECT crSigCdPam
1561:             loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
1562:         ENDIF
1563: 
1564:         *-- 1. Cabecalho cinza (idempotente)
1565:         IF NOT PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
1566:             THIS.ConfigurarCabecalho()
1567:         ENDIF
1568: 
1569:         *-- 2. Shape decorativo
1570:         IF NOT PEMSTATUS(THIS, "shp_4c_Shape3", 5)
1571:             THIS.ConfigurarShape()
1572:         ENDIF
1573: 
1574:         *-- 3. Botoes principais (Processar / Encerrar)
1575:         IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1576:             THIS.ConfigurarBotoes()
1577:         ENDIF
1578: 
1579:         *-- 4. Campos avulsos (labels + datas de emissao/previsao)
1580:         IF NOT PEMSTATUS(THIS, "lbl_4c_PeriodoEmissao", 5)
1581:             THIS.ConfigurarCamposForm()
1582:         ENDIF
1583: 
1584:         *-- 5. Container Tipo de O.P.
1585:         IF NOT PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1586:             THIS.AddObject("cnt_4c_TipoOp", "Container")
1587:             WITH THIS.cnt_4c_TipoOp
1588:                 .Top         = 164
1589:                 .Left        = 139
1590:                 .Width       = 346
1591:                 .Height      = 25
1592:                 .BackStyle   = 0
1593:                 .BorderWidth = 0
1594:                 .Enabled     = THIS.this_lGerPorTp
1595:                 .Visible     = .T.
1596:             ENDWITH

*-- Linhas 1698 a 1783:
1698:     *   - "ENTRADA"     : usuario preenche filtros; Processar habilitado
1699:     *   - "PROCESSANDO" : filtros bloqueados enquanto BO executa; evita re-entrada
1700:     *
1701:     * Chamado em InicializarForm (estado inicial) e pode ser chamado por
1702:     * CmdProcessarClick antes/depois do ProcessarOrdens() do BO.
1703:     *--------------------------------------------------------------------------
1704:     *--------------------------------------------------------------------------
1705:     * BtnIncluirClick - Dispara o processamento (equivalente ao Processar)
1706:     * Form OPERACIONAL: nao ha CRUD - o evento principal eh gerar as OPs
1707:     *--------------------------------------------------------------------------
1708:     PROCEDURE BtnIncluirClick()
1709:         THIS.CmdProcessarClick()
1710:     ENDPROC
1711: 
1712:     *--------------------------------------------------------------------------
1713:     * BtnAlterarClick - Restaura o modo de entrada e da foco na 1a data editavel
1714:     * Permite ao usuario ajustar parametros apos processamento ou cancelamento
1715:     *--------------------------------------------------------------------------
1716:     PROCEDURE BtnAlterarClick()
1717:         THIS.AlternarPagina("ENTRADA")
1718:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5) AND THIS.txt_4c_Dataei.Enabled
1719:             THIS.txt_4c_Dataei.SetFocus
1720:         ELSE
1721:             IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5) AND THIS.cnt_4c_Previsao.Enabled
1722:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
1723:             ENDIF
1724:         ENDIF
1725:     ENDPROC
1726: 
1727:     *--------------------------------------------------------------------------
1728:     * BtnVisualizarClick - Recarrega os defaults iniciais (previsao/geracao/empresa)
1729:     * Util para descartar edicoes locais e voltar aos valores calculados pelo BO
1730:     *--------------------------------------------------------------------------
1731:     PROCEDURE BtnVisualizarClick()
1732:         THIS.AlternarPagina("ENTRADA")
1733:         THIS.PopularCamposIniciais()
1734:     ENDPROC
1735: 
1736:     *--------------------------------------------------------------------------
1737:     * BtnExcluirClick - Encerra o formulario sem processar (equivalente Cancelar)
1738:     *--------------------------------------------------------------------------
1739:     PROCEDURE BtnExcluirClick()
1740:         THIS.CmdCancelarClick()
1741:     ENDPROC
1742: 
1743:     PROCEDURE AlternarPagina(par_cModo)
1744:         LOCAL loc_cModo, loc_lEditar
1745:         loc_cModo = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
1746:         loc_lEditar = (loc_cModo = "ENTRADA")
1747: 
1748:         *-- Botao Processar segue o modo (bloqueia durante processamento)
1749:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1750:             THIS.cmd_4c_Processar.Enabled = loc_lEditar
1751:         ENDIF
1752: 
1753:         *-- Containers de filtro alternam Enabled conforme modo
1754:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1755:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)
1756:         ENDIF
1757:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1758:             THIS.cnt_4c_Operacao.Enabled = loc_lEditar
1759:         ENDIF
1760:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1761:             THIS.cnt_4c_Conta.Enabled = loc_lEditar
1762:         ENDIF
1763:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1764:             THIS.cnt_4c_Responsavel.Enabled = loc_lEditar
1765:         ENDIF
1766:         IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
1767:             THIS.cnt_4c_Empresa.Enabled = (loc_lEditar AND THIS.this_lAlterEmp)
1768:         ENDIF
1769:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1770:             THIS.cnt_4c_Previsao.Enabled = (loc_lEditar AND NOT THIS.this_lReserva)
1771:         ENDIF
1772:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1773:             THIS.cnt_4c_Op.Enabled = loc_lEditar
1774:         ENDIF
1775: 
1776:         *-- Datas de emissao/previsao avulsas no form
1777:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1778:             THIS.txt_4c_Dataei.Enabled = loc_lEditar
1779:         ENDIF
1780:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1781:             THIS.txt_4c_Dataef.Enabled = loc_lEditar
1782:         ENDIF
1783:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)

*-- Linhas 1791 a 1987:
1791:     *--------------------------------------------------------------------------
1792:     * FormParaBO - copia todos os campos do formulario para as propriedades do BO
1793:     *--------------------------------------------------------------------------
1794:     PROCEDURE FormParaBO()
1795:         WITH THIS.this_oBusinessObject
1796:             .this_dDataei      = THIS.txt_4c_Dataei.Value
1797:             .this_dDataef      = THIS.txt_4c_Dataef.Value
1798:             .this_dDatapi      = THIS.txt_4c_Datapi.Value
1799:             .this_dDatapf      = THIS.txt_4c_Datapf.Value
1800:             .this_cOperacao    = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1801:             .this_nOperacaoi   = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1802:             .this_nOperacaof   = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
1803:             .this_cGrupoConta  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1804:             .this_cConta       = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1805:             .this_cDconta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1806:             .this_cGrupoResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1807:             .this_cContaResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1808:             .this_cDcontaResp  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1809:             .this_cCdEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1810:             .this_cDsEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1811:             .this_nNaoEmpPedra = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
1812:             .this_cTpGOp       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1813:             .this_dPrevisao    = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
1814:             .this_dGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
1815:             .this_nNop         = THIS.cnt_4c_Op.txt_4c_Nop.Value
1816:         ENDWITH
1817:     ENDPROC
1818: 
1819:     *--------------------------------------------------------------------------
1820:     * BOParaForm - popula os campos do formulario a partir das propriedades do BO
1821:     *--------------------------------------------------------------------------
1822:     PROCEDURE BOParaForm()
1823:         LOCAL loc_oErro
1824:         TRY
1825:             WITH THIS.this_oBusinessObject
1826:                 THIS.txt_4c_Dataei.Value = .this_dDataei
1827:                 THIS.txt_4c_Dataef.Value = .this_dDataef
1828:                 THIS.txt_4c_Datapi.Value = .this_dDatapi
1829:                 THIS.txt_4c_Datapf.Value = .this_dDatapf
1830:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
1831:                 THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
1832:                 THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
1833:                 THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
1834:                 THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
1835:                 THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDconta
1836:                 THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
1837:                 THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
1838:                 THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDcontaResp
1839:                 THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCdEmpresa
1840:                 THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
1841:                 THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpPedra
1842:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTpGOp
1843:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
1844:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
1845:                 THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNop
1846:             ENDWITH
1847:         CATCH TO loc_oErro
1848:             MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
1849:         ENDTRY
1850:     ENDPROC
1851: 
1852:     *--------------------------------------------------------------------------
1853:     * HabilitarCampos - habilita/desabilita todos os campos editaveis
1854:     * par_lEditar = .T. para habilitar; .F. para somente leitura
1855:     *--------------------------------------------------------------------------
1856:     PROCEDURE HabilitarCampos(par_lEditar)
1857:         LOCAL loc_lEdit
1858:         loc_lEdit = IIF(VARTYPE(par_lEditar) = "L", par_lEditar, .T.)
1859: 
1860:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1861:             THIS.txt_4c_Dataei.Enabled = loc_lEdit
1862:         ENDIF
1863:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1864:             THIS.txt_4c_Dataef.Enabled = loc_lEdit
1865:         ENDIF
1866:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1867:             THIS.txt_4c_Datapi.Enabled = loc_lEdit
1868:         ENDIF
1869:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1870:             THIS.txt_4c_Datapf.Enabled = loc_lEdit
1871:         ENDIF
1872:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1873:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEdit AND THIS.this_lGerPorTp)
1874:         ENDIF
1875:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1876:             THIS.cnt_4c_Operacao.Enabled = loc_lEdit
1877:         ENDIF
1878:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1879:             THIS.cnt_4c_Conta.Enabled = loc_lEdit
1880:         ENDIF
1881:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1882:             THIS.cnt_4c_Responsavel.Enabled = loc_lEdit
1883:         ENDIF
1884:         IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
1885:             THIS.cnt_4c_Empresa.Enabled = (loc_lEdit AND THIS.this_lAlterEmp)
1886:         ENDIF
1887:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1888:             THIS.cnt_4c_Previsao.Enabled = (loc_lEdit AND NOT THIS.this_lReserva)
1889:         ENDIF
1890:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1891:             THIS.cnt_4c_Op.Enabled = loc_lEdit
1892:         ENDIF
1893:     ENDPROC
1894: 
1895:     *--------------------------------------------------------------------------
1896:     * LimparCampos - limpa todos os campos de filtro do formulario
1897:     *--------------------------------------------------------------------------
1898:     PROCEDURE LimparCampos()
1899:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1900:             THIS.txt_4c_Dataei.Value = {}
1901:         ENDIF
1902:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1903:             THIS.txt_4c_Dataef.Value = {}
1904:         ENDIF
1905:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1906:             THIS.txt_4c_Datapi.Value = {}
1907:         ENDIF
1908:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1909:             THIS.txt_4c_Datapf.Value = {}
1910:         ENDIF
1911:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1912:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1913:         ENDIF
1914:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1915:             THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
1916:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1917:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1918:         ENDIF
1919:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1920:             THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ""
1921:             THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1922:             THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1923:         ENDIF
1924:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1925:             THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = ""
1926:             THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1927:             THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1928:         ENDIF
1929:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1930:             THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = {}
1931:             THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = {}
1932:         ENDIF
1933:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1934:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1935:         ENDIF
1936:     ENDPROC
1937: 
1938:     *--------------------------------------------------------------------------
1939:     * CarregarLista - recarrega dados iniciais (form OPERACIONAL sem grid de lista)
1940:     * Existe para compatibilidade com o ciclo de vida do FormBase
1941:     *--------------------------------------------------------------------------
1942:     PROCEDURE CarregarLista()
1943:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1944:             THIS.PopularCamposIniciais()
1945:         ENDIF
1946:     ENDPROC
1947: 
1948:     *--------------------------------------------------------------------------
1949:     * AjustarBotoesPorModo - ajusta estado dos botoes conforme modo do form
1950:     *--------------------------------------------------------------------------
1951:     PROCEDURE AjustarBotoesPorModo()
1952:         THIS.AlternarPagina("ENTRADA")
1953:     ENDPROC
1954: 
1955:     *--------------------------------------------------------------------------
1956:     * BtnBuscarClick - limpa filtros e recarrega valores iniciais padrao
1957:     *--------------------------------------------------------------------------
1958:     PROCEDURE BtnBuscarClick()
1959:         THIS.LimparCampos()
1960:         THIS.PopularCamposIniciais()
1961:         THIS.AlternarPagina("ENTRADA")
1962:     ENDPROC
1963: 
1964:     *--------------------------------------------------------------------------
1965:     * BtnEncerrarClick - fecha o formulario
1966:     *--------------------------------------------------------------------------
1967:     PROCEDURE BtnEncerrarClick()
1968:         THIS.CmdCancelarClick()
1969:     ENDPROC
1970: 
1971:     *--------------------------------------------------------------------------
1972:     * BtnSalvarClick - executa o processamento (equivalente ao Processar)
1973:     *--------------------------------------------------------------------------
1974:     PROCEDURE BtnSalvarClick()
1975:         THIS.CmdProcessarClick()
1976:     ENDPROC
1977: 
1978:     *--------------------------------------------------------------------------
1979:     * BtnCancelarClick - cancela o estado atual e restaura o modo de entrada
1980:     *--------------------------------------------------------------------------
1981:     PROCEDURE BtnCancelarClick()
1982:         THIS.AlternarPagina("ENTRADA")
1983:         THIS.LimparCampos()
1984:         THIS.PopularCamposIniciais()
1985:     ENDPROC
1986: 
1987: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrGloBO.prg):
*==============================================================================
* SigPrGloBO.prg - Business Object para Processamento de O.P.
* Data: 2026-07-03
* Tabela: SigMvCab (principal - registros processados)
* Legado: SigPrGlo.SCX (form operacional)
*==============================================================================

DEFINE CLASS SigPrGloBO AS BusinessBase

    *--------------------------------------------------------------------------
    *-- Modo de operacao (passados via parametros na abertura do form)
    *--------------------------------------------------------------------------
    this_lReserva     = .F.    && Modo reserva automatica (_Reserva)
    this_lAutomatico  = .F.    && Modo automatico (_Autom)
    this_lPorDestino  = .F.    && Por destino (_PorDestino)
    this_lGerPorTp    = .F.    && Gerar por tipo de OP (pTipo)
    this_lAlterEmp    = .T.    && Permite alterar empresa (AlterEmp)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de emissao
    *--------------------------------------------------------------------------
    this_dDataei      = {}     && Data emissao inicial (GetDataei)
    this_dDataef      = {}     && Data emissao final (GetDataef)

    *--------------------------------------------------------------------------
    *-- Filtros de periodo de previsao de entrega
    *--------------------------------------------------------------------------
    this_dDatapi      = {}     && Data previsao entrega inicial (GetDatapi)
    this_dDatapf      = {}     && Data previsao entrega final (GetDatapf)

    *--------------------------------------------------------------------------
    *-- Filtro de operacao
    *--------------------------------------------------------------------------
    this_cOperacao    = ""     && Codigo da operacao (Get_Operacao)
    this_nOperacaoi   = 0      && Numero OP inicial - faixa (Get_Operacaoi)
    this_nOperacaof   = 0      && Numero OP final - faixa (Get_Operacaof)

    *--------------------------------------------------------------------------
    *-- Conta / Movimentacao (cliente)
    *--------------------------------------------------------------------------
    this_cGrupoConta  = ""     && Grupo da conta (Conta.Get_grupo)
    this_cConta       = ""     && Conta (Conta.Get_conta)
    this_cDconta      = ""     && Descricao da conta (Conta.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Responsavel / Vendedor
    *--------------------------------------------------------------------------
    this_cGrupoResp   = ""     && Grupo do responsavel (Responsavel.Get_grupo)
    this_cContaResp   = ""     && Conta do responsavel (Responsavel.Get_conta)
    this_cDcontaResp  = ""     && Descricao do responsavel (Responsavel.Get_dconta)

    *--------------------------------------------------------------------------
    *-- Empresa
    *--------------------------------------------------------------------------
    this_cCdEmpresa   = ""     && Codigo da empresa (Empresa.get_cd_empresa)
    this_cDsEmpresa   = ""     && Razao social da empresa (Empresa.get_ds_empresa)
    this_nNaoEmpPedra = 0      && Nao empenhar pedras: 0=nao, 1=sim (Empresa.Chec_pedra)

    *--------------------------------------------------------------------------
    *-- Tipo de geracao de OP
    *--------------------------------------------------------------------------
    this_cTpGOp       = ""     && Codigo do tipo de geracao (Container1.Get_TpGOp)

    *--------------------------------------------------------------------------
    *-- Previsao de entrega e data de geracao
    *--------------------------------------------------------------------------
    this_dPrevisao    = {}     && Data de previsao de entrega (Cnt_Previsao.GetPrevisao)
    this_dGeracao     = {}     && Data de geracao (Cnt_Previsao.GetGeracao)

    *--------------------------------------------------------------------------
    *-- Numero da OP manual (GlobAutos = 2)
    *--------------------------------------------------------------------------
    this_nNop         = 0      && Numero da OP manual (Cnt_Op.GetNop)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "Numes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - carrega propriedades a partir de cursor com registros de OP
    * Usado quando o form recarrega um contexto ja gerado a partir de SigOpPic
    * ou de cursor temporario TmpCabec/TmpItens. Popula filtros base.
    * Retorna .T. se pelo menos os campos essenciais foram carregados.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(par_cAliasCursor) OR NOT USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)
        IF EOF()
            RETURN .F.
        ENDIF

        *-- Empresa (todos os cursores relevantes tem coluna Emps)
        IF TYPE(par_cAliasCursor + ".Emps") = "C"
            THIS.this_cCdEmpresa = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Emps")), "")
            loc_lSucesso = .T.
        ENDIF

        *-- Operacao (Dopes) e movimento (Numes) - opcionais conforme cursor origem
        IF TYPE(par_cAliasCursor + ".Dopes") = "C"
            THIS.this_cOperacao  = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Dopes")), "")
            THIS.this_nOperacaoi = 0
            THIS.this_nOperacaof = 0
        ENDIF
        IF TYPE(par_cAliasCursor + ".Datas") = "D"
            THIS.this_dGeracao = NVL(EVALUATE(par_cAliasCursor + ".Datas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Entregas") = "D"
            THIS.this_dPrevisao = NVL(EVALUATE(par_cAliasCursor + ".Entregas"), DATE())
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupo") = "C"
            THIS.this_cGrupoConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupo")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Conta") = "C"
            THIS.this_cConta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Conta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".DConta") = "C"
            THIS.this_cDconta = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".DConta")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Grupov") = "C"
            THIS.this_cGrupoResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Grupov")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Contav") = "C"
            THIS.this_cContaResp = NVL(ALLTRIM(EVALUATE(par_cAliasCursor + ".Contav")), "")
        ENDIF
        IF TYPE(par_cAliasCursor + ".Numes") = "N"
            THIS.this_nNop = NVL(EVALUATE(par_cAliasCursor + ".Numes"), 0)
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * FormatarDataHoraSQL - retorna 'YYYY-MM-DD HH:MM:SS' com aspas simples
    * par_cHora: ex "23:59:59" ou "00:00:00"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE FormatarDataHoraSQL(par_dData, par_cHora)
        LOCAL loc_cBase
        IF EMPTY(par_dData) OR VARTYPE(par_dData) != "D"
            RETURN "NULL"
        ENDIF
        *-- FormatarDataSQL retorna 'YYYY-MM-DD' (12 chars, com aspas)
        *-- Remove aspas de fechamento e adiciona hora
        loc_cBase = FormatarDataSQL(par_dData)
        RETURN SUBSTR(loc_cBase, 1, LEN(loc_cBase)-1) + " " + par_cHora + "'"
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - carrega dados de configuracao para o processamento
    * Cria cursores: crSigCdPam, crSigCdPac, TmpOper, CrTmpTpGop
    * par_lGerPorTp: .T. se modo de geracao por tipo de OP
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros(par_lGerPorTp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cCampos, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Parametros de OP (SigCdPam)
            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, " + ;
                          "DoppPads, DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, " + ;
                          "GruReservs, ConReservs, AgrupEmph, DoppServs, mascnums, GruEstps, " + ;
                          "ConEstps, transfencs, Ouros, GruConfs, ConConfs, GlobAutos, " + ;
                          "DopEntAus, TpOpEntAus, AutComps"
            loc_cSQL = "SELECT " + loc_cCampos + " FROM SigCdPam"
            IF USED("crSigCdPam")
                USE IN crSigCdPam
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPam") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de OP (SigCdPam).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Parametros de componentes (SigCdPac)
            loc_cSQL = "SELECT * FROM SigCdPac"
            IF USED("crSigCdPac")
                USE IN crSigCdPac
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPac") < 1
                MsgErro("Falha ao carregar par" + CHR(226) + "metros de componentes (SigCdPac).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Operacoes disponiveis (SigCdOpe + SigOpCdd + SigOpCdc -> TmpOper)
            loc_cSQL = "SELECT b.OpeGops, b.CodTgOps, a.Dopes, a.NDopes, a.Globalizas, " + ;
                       "a.Reservas, a.Opers, 0 AS Acesso, b.chkObs, c.carcompos " + ;
                       "FROM SigCdOpe a " + ;
                       "LEFT JOIN SigOpCdd b ON b.dopes = a.dopes " + ;
                       "LEFT JOIN SigOpCdc c ON a.dopes = c.dopes " + ;
                       "WHERE a.Globalizas IN (1, 2)"
            IF USED("TmpOper2")
                USE IN TmpOper2
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOper2") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(245) + "es (SigCdOpe).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            *-- Normalizar NULLs nos campos opcionais
            SELECT TmpOper2
            SCAN
                REPLACE CodTgOps WITH NVL(CodTgOps, " "), ;
                        OpeGops  WITH NVL(OpeGops, " ") IN TmpOper2
            ENDSCAN
            *-- Mover para TmpOper com indice
            IF USED("TmpOper")
                USE IN TmpOper
            ENDIF
            SELECT * FROM TmpOper2 INTO CURSOR TmpOper READWRITE
            USE IN TmpOper2
            SELECT TmpOper
            INDEX ON Dopes TAG Dopes
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Tipos de OP com filtro de acesso (SigInTgo -> CrTmpTpGop)
            loc_cSQL = "SELECT 0 AS Acesso, * FROM SigInTgo"
            IF USED("TmpTpGop")
                USE IN TmpTpGop
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpTpGop") < 1
                MsgErro("Falha ao carregar tipos de OP (SigInTgo).", "Erro")
                loc_lSucesso = .F.
            ENDIF
            SELECT TmpTpGop
            SCAN
                IF fChecaAcesso("SIGPRGLOT", ALLTRIM(TmpTpGop.Codigos))
                    REPLACE Acesso WITH 1 IN TmpTpGop
                ENDIF
            ENDSCAN
            IF USED("CrTmpTpGop")
                USE IN CrTmpTpGop
            ENDIF
            SELECT * FROM TmpTpGop WHERE Acesso = 1 INTO CURSOR CrTmpTpGop READWRITE
            USE IN TmpTpGop
            SELECT CrTmpTpGop
            INDEX ON Codigos TAG Codigos
            GO TOP

            *-- Auto-selecionar tipo se GerPorTp e so ha um disponivel
            IF par_lGerPorTp AND RECCOUNT("CrTmpTpGop") = 1
                THIS.this_cTpGOp = ALLTRIM(CrTmpTpGop.Codigos)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao carregar par" + CHR(226) + "metros: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresa - carrega dados da empresa pelo codigo
    * Popula this_cCdEmpresa e this_cDsEmpresa
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresa(par_cCodEmp)
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + EscaparSQL(ALLTRIM(par_cCodEmp))
            IF USED("TempEmp")
                USE IN TempEmp
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEmp") >= 1
                SELECT TempEmp
                IF NOT EOF()
                    THIS.this_cCdEmpresa = ALLTRIM(TempEmp.Cemps)
                    THIS.this_cDsEmpresa = ALLTRIM(TempEmp.Razas)
                    loc_lSucesso = .T.
                ENDIF
                USE IN TempEmp
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar empresa: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarNumeroOP - verifica se numero de OP ja existe em SigOpPic
    * Retorna .T. se DISPONIVEL (nao existe), .F. se JA EXISTE ou erro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarNumeroOP(par_nNop)
        LOCAL loc_cSQL, loc_lDisponivel, loc_oErro
        loc_lDisponivel = .T.

        TRY
            loc_cSQL = "SELECT Numps FROM SigOpPic WHERE Numps = " + TRANSFORM(par_nNop)
            IF USED("TmpOpi")
                USE IN TmpOpi
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "TmpOpi") >= 1
                IF RECCOUNT("TmpOpi") > 0
                    loc_lDisponivel = .F.
                ENDIF
                USE IN TmpOpi
            ELSE
                loc_lDisponivel = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao validar n" + CHR(250) + "mero de OP: " + loc_oErro.Message, "Erro")
            loc_lDisponivel = .F.
        ENDTRY

        RETURN loc_lDisponivel
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresProcessamento - cria cursores temporarios para Processar
    * TmpCabec, TmpItens, DBParam, SelPedra, Produtos
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresProcessamento()
        LOCAL loc_oErro
        TRY
            IF USED("DBParam")
                USE IN DBParam
            ENDIF
            IF USED("TmpCabec")
                USE IN TmpCabec
            ENDIF
            IF USED("TmpItens")
                USE IN TmpItens
            ENDIF
            IF USED("SelPedra")
                USE IN SelPedra
            ENDIF
            IF USED("Produtos")
                USE IN Produtos
            ENDIF

            SET NULL ON
            CREATE CURSOR DBParam (CodTgOps C(10) NULL, OpZers N(1,0) NULL, EntPes N(1,0) NULL)
            SET NULL OFF

            SET NULL ON
            CREATE CURSOR TmpCabec (Flag L, Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     Grupo C(10), Conta C(10), Datas D NULL, ;
                                     Entregas D NULL, Grupov C(10), Contav C(10), ;
                                     Obs M NULL, Peso N(12,2), ;
                                     GrupoDs C(10), ContaDs C(10), DConta C(40), ;
                                     Notas C(6), Jobs C(10))
            SET NULL OFF
            INDEX ON DTOS(Entregas) + Emps + Dopes + STR(Numes,6) TAG Entrega
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

            SET NULL ON
            CREATE CURSOR SelPedra (Cpros C(14), Dpros C(40), Cunis C(3), ;
                                     Qtds N(12,3), Cpro2s C(14))
            SET NULL OFF

            CREATE CURSOR Produtos (Cpros C(14), Dpros C(40), cmats C(14))
            INDEX ON Cpros TAG Cpros

            SET NULL ON
            CREATE CURSOR TmpItens (Emps C(3), Dopes C(20), Numes N(6,0), ;
                                     CPros C(14), Qtds N(12,3), Saldo N(12,3), ;
                                     Peso N(9,3), Obs M NULL, Linhas C(10), ;
                                     CodCors C(4), CodTams C(4), Citens N(10,0), ;
                                     Notas C(6), dpros C(40), Reffs C(40))
            SET NULL OFF
            INDEX ON Linhas + Cpros TAG LinPro
            INDEX ON Cpros TAG Cpros
            INDEX ON Emps + Dopes + STR(Numes,6) TAG Empdopnum
            SET ORDER TO TAG Empdopnum

        CATCH TO loc_oErro
            MsgErro("Erro ao preparar cursores de processamento: " + loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarOrdens - logica principal de processamento de OP
    * Usa this_* properties definidas pela form para os filtros.
    * Popula TmpCabec e TmpItens para uso pelo form SigPrGl2.
    * Retorna .T. se ha registros a processar, .F. caso contrario.
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarOrdens()
        LOCAL loc_lSucesso, loc_oErro
        LOCAL loc_Conde, loc_Condp, loc_cSQL
        LOCAL loc_cDateiSQL, loc_cDatefSQL, loc_cDatepiSQL, loc_cDatepfSQL
        LOCAL loc_Dopp, loc_lcTpGOp, loc_lcEmp
        LOCAL loc_Grupo, loc_Conta, loc_GrupoV, loc_ContaV
        LOCAL loc_GrupoG, loc_ContaG, loc_GrupoD, loc_ContaD
        LOCAL loc_Operacao, loc_Operacaoi, loc_Operacaof
        LOCAL loc_TPeso, loc_Processa, loc_Saldo, loc_Peso
        LOCAL loc_lcEdn, loc_lcCpo, loc_oProg, loc_xBaixa, loc_lnQtdTb
        LOCAL loc_pItn, loc_cDConta

        loc_lSucesso = .F.

        TRY
            THIS.PrepararCursoresProcessamento()

            *-- Coletar filtros das propriedades do BO
            SELECT crSigCdPam
            loc_Dopp       = crSigCdPam.DoppPads
            loc_lcTpGOp    = THIS.this_cTpGOp
            loc_lcEmp      = IIF(EMPTY(THIS.this_cCdEmpresa), go_4c_Sistema.cCodEmpresa, THIS.this_cCdEmpresa)
            loc_Grupo      = THIS.this_cGrupoConta
            loc_Conta      = THIS.this_cConta
            loc_GrupoV     = THIS.this_cGrupoResp
            loc_ContaV     = THIS.this_cContaResp
            loc_Operacao   = THIS.this_cOperacao
            loc_Operacaoi  = THIS.this_nOperacaoi
            loc_Operacaof  = THIS.this_nOperacaof

            *-- Carregar operacao padrao (SigCdOpd)
            loc_cSQL = "SELECT * FROM SigCdOpd WHERE Dopps = " + EscaparSQL(ALLTRIM(loc_Dopp))
            IF USED("crSigCdOpd")
                USE IN crSigCdOpd
            ENDIF
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdOpd") < 1
                MsgErro("Falha ao carregar opera" + CHR(231) + CHR(227) + "o padr" + CHR(227) + "o (SigCdOpd).", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Formatar datas para SQL
            loc_cDateiSQL  = IIF(EMPTY(THIS.this_dDataei), "NULL", FormatarDataSQL(THIS.this_dDataei))
            loc_cDatefSQL  = IIF(EMPTY(THIS.this_dDataef), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDataef, "23:59:59"))
            loc_cDatepiSQL = IIF(EMPTY(THIS.this_dDatapi), "NULL", FormatarDataSQL(THIS.this_dDatapi))
            loc_cDatepfSQL = IIF(EMPTY(THIS.this_dDatapf), "NULL", THIS.FormatarDataHoraSQL(THIS.this_dDatapf, "23:59:59"))

            *-- Condicao de periodo de emissao
            IF EMPTY(THIS.this_dDataef)
                loc_Conde = ""
            ELSE
                IF EMPTY(THIS.this_dDataei)
                loc_Conde = "Datas <= " + loc_cDatefSQL + " AND "
            ELSE
                loc_Conde = "Datas BETWEEN " + loc_cDateiSQL + " AND " + loc_cDatefSQL + " AND "
                ENDIF
            ENDIF

            *-- Condicao de periodo de previsao de entrega
            IF EMPTY(THIS.this_dDatapi)
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = ""
                ELSE
                    loc_Condp = "PrazoEnts <= " + loc_cDatepfSQL + " AND "
                ENDIF
            ELSE
                IF EMPTY(THIS.this_dDatapf)
                    loc_Condp = "PrazoEnts >= " + loc_cDatepiSQL + " AND "
                ELSE
                    loc_Condp = "PrazoEnts BETWEEN " + loc_cDatepiSQL + " AND " + loc_cDatepfSQL + " AND "
                ENDIF
            ENDIF

            *-- Inserir parametros de geracao em DBParam
            IF SEEK(ALLTRIM(loc_lcTpGOp), "CrTmpTpGop", "Codigos")
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.OpZers, crSigCdPac.OpZers), ;
                            IIF(THIS.this_lGerPorTp, CrTmpTpGop.EntPes, 0))
            ELSE
                INSERT INTO DBParam (CodTgOps, OpZers, EntPes) ;
                    VALUES (loc_lcTpGOp, crSigCdPac.OpZers, 0)
            ENDIF

            *-- Verificar operacoes dispon?veis
            SELECT TmpOper
            GO TOP
            IF EOF()
                MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o Configurada Para Processar " + ;
                         "Ordem de Produ" + CHR(231) + CHR(227) + "o!!!", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Aplicar filtro de operacao especifica
            SET ORDER TO TAG Dopes IN TmpOper
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO loc_Operacao IN TmpOper
            ENDIF

            *-- Iterar operacoes
            SELECT TmpOper
            SCAN
                IF THIS.this_lGerPorTp AND ALLTRIM(TmpOper.CodTgOps) <> ALLTRIM(loc_lcTpGOp)
                    LOOP
                ENDIF

                *-- Montar SQL para buscar movimentos desta operacao
                loc_cSQL = "SELECT Emps, Dopes, Numes, Datas, PrazoEnts, GrupoOs, " + ;
                           "ContaOs, GrupoDs, ContaDs, GrVends, Vends, Obses, rNops, Notas, Jobs " + ;
                           "FROM SigMvCab " + ;
                           "WHERE " + loc_Conde + loc_Condp + ;
                           "Emps = " + EscaparSQL(ALLTRIM(loc_lcEmp)) + " AND " + ;
                           "Dopes = " + EscaparSQL(ALLTRIM(TmpOper.Dopes)) + " AND "

                *-- Filtros de conta (cliente/destino conforme Globalizas)
                IF NOT EMPTY(loc_Grupo)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "GrupoOs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "GrupoDs = " + EscaparSQL(ALLTRIM(loc_Grupo)) + " AND "
                    ENDIF
                ENDIF
                IF NOT EMPTY(loc_Conta)
                    IF TmpOper.Globalizas = 1
                        loc_cSQL = loc_cSQL + "ContaOs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                    IF TmpOper.Globalizas = 2
                        loc_cSQL = loc_cSQL + "ContaDs = " + EscaparSQL(ALLTRIM(loc_Conta)) + " AND "
                    ENDIF
                ENDIF
                *-- Filtros de vendedor (Responsavel)
                IF NOT EMPTY(loc_GrupoV)
                    loc_cSQL = loc_cSQL + "GrVends = " + EscaparSQL(ALLTRIM(loc_GrupoV)) + " AND "
                ENDIF
                IF NOT EMPTY(loc_ContaV)
                    loc_cSQL = loc_cSQL + "Vends = " + EscaparSQL(ALLTRIM(loc_ContaV)) + " AND "
                ENDIF
                *-- Apenas movimentos sem OP gerada
                loc_cSQL = loc_cSQL + "Nops = 0"

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEest") < 1
                    MsgErro("Falha na conex" + CHR(227) + "o ao buscar movimentos (TempEest).", "Erro")
                    loc_lSucesso = .F.
                ENDIF

                *-- Barra de progresso por operacao
                SELECT TempEest
                loc_oProg = CREATEOBJECT("fwprogressbar", ;
                    "Processando Opera" + CHR(231) + CHR(227) + "o " + ALLTRIM(TmpOper.Dopes) + "...", ;
                    RECCOUNT())
                loc_oProg.Show()

                SCAN
                    loc_oProg.Update(.T.)

                    *-- Filtrar por faixa de numero de OP se especificada
                    IF NOT EMPTY(loc_Operacao)
                        IF loc_Operacaoi != 0 AND loc_Operacaof != 0 AND ;
                           NOT BETWEEN(TempEest.Numes, loc_Operacaoi, loc_Operacaof)
                            LOOP
                        ENDIF
                    ENDIF

                    *-- Grupo/Conta conforme tipo de globalizacao
                    IF TmpOper.Globalizas = 1
                        loc_GrupoG = ALLTRIM(TempEest.GrupoOs)
                        loc_ContaG = ALLTRIM(TempEest.ContaOs)
                    ELSE
                        loc_GrupoG = ALLTRIM(TempEest.GrupoDs)
                        loc_ContaG = ALLTRIM(TempEest.ContaDs)
                    ENDIF

                    *-- Pular movimentos com reserva automatica ja processada
                    IF THIS.this_lReserva AND TempEest.rNops > 0
                        LOOP
                    ENDIF

                    loc_TPeso    = 0
                    loc_Processa = .F.

                    *-- Buscar itens do movimento (SigMvItn)
                    loc_lcEdn = TempEest.Emps + TempEest.Dopes + STR(TempEest.Numes, 6)
                    loc_lcCpo = "CPros, CItens, Qtds, QtBaixas, QtProds, Pesos, " + ;
                                "Emps, Dopes, Numes, Obs, Notas, Dpros, Opers, Citem2"
                    loc_cSQL = "SELECT " + loc_lcCpo + " FROM SigMvItn " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn)
                    IF USED("TempEestI")
                        USE IN TempEestI
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEestI") < 1
                        MsgErro("Falha ao buscar itens do movimento (TempEestI).", "Erro")
                        loc_lSucesso = .F.
                    ENDIF

                    SELECT TempEestI
                    SCAN
                        *-- Filtrar por operacao interna se OPers = 3
                        IF TmpOper.OPers = 3 AND NOT EMPTY(TmpOper.OpeGops) AND ;
                           ALLTRIM(TempEestI.Opers) <> ALLTRIM(TmpOper.OpeGops)
                            LOOP
                        ENDIF
                        *-- Pular componentes de sub-montagem se carcompos = 5
                        IF TmpOper.carcompos = 5 AND TempEestI.Citem2 <> 0
                            LOOP
                        ENDIF

                        *-- Carregar dados do produto
                        loc_cSQL = "SELECT Pesoms, Linhas, QtdCpnts, DPros, Reffs, Cgrus " + ;
                                   "FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                        IF USED("crSigCdPro")
                            USE IN crSigCdPro
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdPro") < 1
                            MsgErro("Falha ao carregar produto (SigCdPro).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        *-- Carregar grupo do produto
                        loc_cSQL = "SELECT GeraTubs FROM SigCdGrp " + ;
                                   "WHERE CGrus = " + EscaparSQL(ALLTRIM(crSigCdPro.CGrus))
                        IF USED("crSigCdGrp")
                            USE IN crSigCdGrp
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdGrp") < 1
                            MsgErro("Falha ao carregar grupo do produto (SigCdGrp).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        loc_pItn   = TempEestI.CItens
                        loc_lnQtdTb = 0

                        *-- Buscar sub-itens (SigMvIts)
                        loc_cSQL = "SELECT * FROM SigMvIts " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_lcEdn) + ;
                                   " AND CItens = " + FormatarNumeroSQL(loc_pItn)
                        IF USED("TempEsti2")
                            USE IN TempEsti2
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "TempEsti2") < 1
                            MsgErro("Falha ao buscar sub-itens (TempEsti2).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF

                        SELECT TempEsti2
                        GO TOP
                        IF EOF("TempEsti2")
                            *-- Sem sub-itens: processar item principal
                            SELECT TempEestI
                            loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                             QtBaixas - QtProds, 0) + QtProds
                            loc_Saldo  = TempEestI.Qtds - loc_xBaixa
                            loc_Peso   = IIF(EMPTY(TempEestI.Pesos), crSigCdPro.Pesoms, TempEestI.Pesos)
                            IF loc_Saldo <> 0
                                INSERT INTO TmpItens ;
                                    (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                     Linhas, Citens, Notas, Dpros, Reffs) ;
                                    VALUES (TempEestI.Emps, TempEestI.Dopes, TempEestI.Numes, ;
                                            TempEestI.CPros, TempEestI.Qtds, loc_Saldo, ;
                                            TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                            TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                            crSigCdPro.Reffs)
                                loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                loc_Processa = .T.
                                *-- Verificar qtd de tubos por grupo
                                IF crSigCdGrp.GeraTubs <> 2
                                    loc_lnQtdTb = crSigCdPro.QtdCpnts
                                ELSE
                                    loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                               "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                    IF USED("crSigPrMtz")
                                        USE IN crSigPrMtz
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                        SELECT crSigPrMtz
                                        loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                    ENDIF
                                ENDIF
                                IF loc_lnQtdTb = 0
                                    SELECT Produtos
                                    IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                        INSERT INTO Produtos (Cpros, DPros) ;
                                            VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                    ENDIF
                                ENDIF
                            ENDIF
                        ELSE
                            *-- Com sub-itens: processar cada sub-item
                            SELECT TempEsti2
                            SCAN
                                loc_xBaixa = IIF(QtBaixas > 0 AND QtBaixas >= QtProds, ;
                                                 QtBaixas - QtProds, 0) + QtProds
                                loc_Saldo  = TempEsti2.Qtds - loc_xBaixa
                                loc_Peso   = IIF(EMPTY(TempEsti2.Pesos), crSigCdPro.Pesoms, TempEsti2.Pesos)
                                IF loc_Saldo <> 0
                                    INSERT INTO TmpItens ;
                                        (Emps, Dopes, Numes, CPros, Qtds, Saldo, Obs, Peso, ;
                                         Linhas, CodCors, CodTams, Citens, Notas, Dpros, Reffs) ;
                                        VALUES (TempEsti2.Emps, TempEsti2.Dopes, TempEsti2.Numes, ;
                                                TempEsti2.CPros, TempEsti2.Qtds, loc_Saldo, ;
                                                TempEestI.Obs, loc_Peso, crSigCdPro.Linhas, ;
                                                TempEsti2.CodCors, TempEsti2.CodTams, ;
                                                TempEestI.Citens, TempEestI.Notas, TempEestI.Dpros, ;
                                                crSigCdPro.Reffs)
                                    loc_TPeso    = loc_TPeso + (loc_Peso * loc_Saldo)
                                    loc_Processa = .T.
                                    *-- Verificar qtd de tubos por grupo
                                    IF crSigCdGrp.GeraTubs <> 2
                                        loc_lnQtdTb = crSigCdPro.QtdCpnts
                                    ELSE
                                        loc_cSQL = "SELECT SUM(qtds) AS total FROM SigPrMtz " + ;
                                                   "WHERE Cpros = " + EscaparSQL(ALLTRIM(TempEestI.CPros))
                                        IF USED("crSigPrMtz")
                                            USE IN crSigPrMtz
                                        ENDIF
                                        IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrMtz") >= 1
                                            SELECT crSigPrMtz
                                            loc_lnQtdTb = NVL(crSigPrMtz.total, 0)
                                        ENDIF
                                    ENDIF
                                    IF loc_lnQtdTb = 0
                                        SELECT Produtos
                                        IF NOT SEEK(ALLTRIM(TempEestI.Cpros), "Produtos", "CPros")
                                            INSERT INTO Produtos (Cpros, DPros) ;
                                                VALUES (TempEestI.Cpros, crSigCdPro.Dpros)
                                        ENDIF
                                    ENDIF
                                ENDIF
                            ENDSCAN
                        ENDIF
                    ENDSCAN

                    *-- Inserir cabecalho se ha itens para processar neste movimento
                    IF loc_Processa
                        *-- Destino: preferencia pelo SigCdOpd, fallback para o movimento
                        loc_GrupoD = IIF(EMPTY(crSigCdOpd.GruDests), ;
                                         ALLTRIM(TempEest.GrupoDs), ALLTRIM(crSigCdOpd.GruDests))
                        loc_ContaD = IIF(EMPTY(crSigCdOpd.ConDests), ;
                                         ALLTRIM(TempEest.ContaDs), ALLTRIM(crSigCdOpd.ConDests))

                        *-- Buscar razao social do cliente
                        loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli " + ;
                                   "WHERE IClis = " + EscaparSQL(loc_ContaG)
                        IF USED("LocalCli")
                            USE IN LocalCli
                        ENDIF
                        IF SQLEXEC(gnConnHandle, loc_cSQL, "LocalCli") < 1
                            MsgErro("Falha ao buscar cliente (SigCdCli).", "Erro")
                            loc_lSucesso = .F.
                        ENDIF
                        SELECT LocalCli
                        loc_cDConta = IIF(EOF(), "", ALLTRIM(LocalCli.RClis))
                        USE IN LocalCli

                        INSERT INTO TmpCabec ;
                            (Flag, Emps, Dopes, Numes, Grupo, Conta, Grupov, Contav, ;
                             Datas, Entregas, Peso, Obs, GrupoDs, ContaDs, DConta, ;
                             Notas, Jobs) ;
                            VALUES (.T., TempEest.Emps, TempEest.Dopes, TempEest.Numes, ;
                                    loc_GrupoG, loc_ContaG, ;
                                    ALLTRIM(TempEest.GrVends), ALLTRIM(TempEest.Vends), ;
                                    TempEest.Datas, TempEest.PrazoEnts, ;
                                    loc_TPeso, TempEest.Obses, ;
                                    loc_GrupoD, loc_ContaD, loc_cDConta, ;
                                    ALLTRIM(TempEest.Notas), ALLTRIM(TempEest.Jobs))
                    ENDIF
                ENDSCAN

                loc_oProg.Complete()

                IF USED("TempEest")
                    USE IN TempEest
                ENDIF
            ENDSCAN

            *-- Limpar filtro de operacao
            IF NOT EMPTY(loc_Operacao)
                SET KEY TO IN TmpOper
            ENDIF

            *-- Posicionar cursores no inicio
            GO TOP IN TmpCabec
            GO TOP IN TmpItens

            *-- Verificar se ha registros para processar
            loc_lSucesso = NOT EOF("TmpItens") AND NOT EOF("TmpCabec")
            IF NOT loc_lSucesso
                MsgAviso("Nenhum Item Selecionado Para Processar!!!", "Aviso")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro ao processar ordens: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - retorna chave identificadora do contexto de processamento
    * Formato: Emp + TpGOp + Numps (evita colisao entre empresas/tipos)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ALLTRIM(THIS.this_cCdEmpresa) + "|" + ;
                     ALLTRIM(THIS.this_cTpGOp) + "|" + ;
                     TRANSFORM(THIS.this_nNop)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - grava uma OP gerada em SigOpPic (Ordens de Producao)
    * Chamada apos usuario confirmar selecao em SigPrGl2.
    * par_nNumps: numero da OP a gravar
    * par_cDope: operacao (Dopes) do item
    * par_cCpro: codigo do produto
    * par_nQtds: quantidade da OP
    * par_nNumes: numero do movimento origem (SigMvCab.Numes)
    * par_cCodTgOp: tipo de geracao (opcional; usa this_cTpGOp se vazio)
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir(par_nNumps, par_cDope, par_cCpro, par_nQtds, par_nNumes, par_cCodTgOp)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmp, loc_cDopp
        LOCAL loc_cCodTgOp, loc_cIdChave, loc_dGeracao, loc_dPrev
        LOCAL loc_cEmpDopNums, loc_cEmpDopNops, loc_cEmpDnps
        LOCAL loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros obrigatorios
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cDope))
                MsgErro("Opera" + CHR(231) + CHR(227) + "o (Dopes) obrigat" + CHR(243) + "ria para inser" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Verificar duplicidade antes de inserir
            IF NOT THIS.ValidarNumeroOP(par_nNumps)
                MsgAviso("N" + CHR(250) + "mero de OP " + TRANSFORM(par_nNumps) + " j" + CHR(225) + " existe em SigOpPic.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Preparar valores
            loc_cEmp      = ALLTRIM(THIS.this_cCdEmpresa)
            IF EMPTY(loc_cEmp)
                loc_cEmp = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            ENDIF
            loc_dGeracao  = IIF(EMPTY(THIS.this_dGeracao), DATE(), THIS.this_dGeracao)
            loc_dPrev     = IIF(EMPTY(THIS.this_dPrevisao), loc_dGeracao, THIS.this_dPrevisao)
            loc_cCodTgOp  = IIF(EMPTY(ALLTRIM(par_cCodTgOp)), ALLTRIM(THIS.this_cTpGOp), ALLTRIM(par_cCodTgOp))
            loc_cUsuario  = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            *-- Recuperar Dopp da operacao padrao (usa CarregarParametros previamente)
            loc_cDopp = ""
            IF USED("crSigCdPam")
                SELECT crSigCdPam
                loc_cDopp = ALLTRIM(crSigCdPam.DoppPads)
            ENDIF

            *-- Composicao das chaves compostas (padrao do sistema)
            loc_cEmpDopNums = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")
            loc_cEmpDopNops = loc_cEmp + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cEmpDnps    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")
            loc_cIdChave    = loc_cEmp + PADL(TRANSFORM(par_nNumps), 10, "0")

            *-- Montar INSERT em SigOpPic (colunas NOT NULL preenchidas)
            loc_cSQL = "INSERT INTO SigOpPic " + ;
                       "(cIdChaves, Emps, Dopes, Dopps, Nops, Numes, Numps, " + ;
                       " Datas, Datap, Datages, Cpros, Empds, Locals, Ntrans, " + ;
                       " Seqdivs, CodCors, CodTams, Divs, Imprs, Usuars, Nopmaes, " + ;
                       " Pesos, CodBarras, QtdCpnts, QtdTubos, iImprs, Moedas, Units, " + ;
                       " Nfunds, Dpros, Empdnps, EmpDopNops, EmpDopNums, Notas, " + ;
                       " CodTgOps, Citens, Qtds) VALUES ("
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL(loc_cIdChave) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cDope)) + ", " + ;
                       EscaparSQL(loc_cDopp) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarNumeroSQL(par_nNumes) + ", " + ;
                       FormatarNumeroSQL(par_nNumps) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       FormatarDataSQL(loc_dPrev) + ", " + ;
                       FormatarDataSQL(loc_dGeracao) + ", " + ;
                       EscaparSQL(ALLTRIM(par_cCpro)) + ", " + ;
                       EscaparSQL(loc_cEmp) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, "
            loc_cSQL = loc_cSQL + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       "0, 0, 0, 0, 0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       "0, 0, " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cEmpDnps) + ", " + ;
                       EscaparSQL(loc_cEmpDopNops) + ", " + ;
                       EscaparSQL(loc_cEmpDopNums) + ", " + ;
                       EscaparSQL("") + ", " + ;
                       EscaparSQL(loc_cCodTgOp) + ", " + ;
                       "0, " + ;
                       FormatarNumeroSQL(par_nQtds) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao gravar OP em SigOpPic (n" + CHR(250) + "mero " + TRANSFORM(par_nNumps) + ").", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da insercao
            THIS.RegistrarAuditoria("INCLUIR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao inserir OP: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - vincula movimento origem (SigMvCab) ao numero da OP gerada
    * Em modo Reserva: atualiza rNops (reserva). Modo normal: atualiza Nops.
    * par_cEmp: empresa do movimento
    * par_cDope: operacao do movimento
    * par_nNumes: numero do movimento
    * par_nNumps: numero da OP gerada
    * Retorna .T. em caso de sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar(par_cEmp, par_cDope, par_nNumes, par_nNumps)
        LOCAL loc_lSucesso, loc_cSQL, loc_cEmpDopNums, loc_cCampo
        LOCAL loc_dAlt, loc_cUsuario, loc_oErro
        loc_lSucesso = .F.

        TRY
            *-- Validar parametros
            IF EMPTY(par_nNumps) OR par_nNumps <= 0
                MsgErro("N" + CHR(250) + "mero da OP inv" + CHR(225) + "lido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
                loc_lSucesso = .F.
            ENDIF
            IF EMPTY(ALLTRIM(par_cEmp)) OR EMPTY(ALLTRIM(par_cDope)) OR par_nNumes <= 0
                MsgErro("Chave do movimento (Emp/Dope/Numes) obrigat" + CHR(243) + "ria.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Campo destino: rNops em reserva automatica, Nops caso contrario
            loc_cCampo = IIF(THIS.this_lReserva, "rNops", "Nops")

            *-- Chave composta EmpDopNums
            loc_cEmpDopNums = ALLTRIM(par_cEmp) + ALLTRIM(par_cDope) + PADL(TRANSFORM(par_nNumes), 6, "0")

            *-- Dados de auditoria embutidos no proprio UPDATE
            loc_dAlt     = DATE()
            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "SISTEMA")

            loc_cSQL = "UPDATE SigMvCab SET " + loc_cCampo + " = " + FormatarNumeroSQL(par_nNumps)
            IF NOT THIS.this_lReserva
                loc_cSQL = loc_cSQL + ", Dtalts = " + FormatarDataSQL(loc_dAlt) + ;
                           ", Usualts = " + EscaparSQL(loc_cUsuario)
            ENDIF
            loc_cSQL = loc_cSQL + " WHERE EmpDopNums = " + EscaparSQL(loc_cEmpDopNums)

            IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                MsgErro("Falha ao atualizar movimento " + loc_cEmpDopNums + " com OP " + TRANSFORM(par_nNumps) + ".", "Erro")
                loc_lSucesso = .F.
            ENDIF

            *-- Auditoria da atualizacao
            THIS.RegistrarAuditoria("ALTERAR")

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar movimento: " + loc_oErro.Message + ;
                    " Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

