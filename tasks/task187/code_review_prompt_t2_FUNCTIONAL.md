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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1989 linhas total):

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

*-- Linhas 117 a 181:
117:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption  = THIS.Caption
118:             THIS.ConfigurarShape()
119:             THIS.ConfigurarPaginaLista()
120:             THIS.TornarControlesVisiveis()
121:             THIS.PopularCamposIniciais()
122:             THIS.ConfigurarEventos()
123: 
124:             *-- Estado inicial: aguardando entrada do usuario
125:             THIS.AlternarPagina("ENTRADA")
126: 
127:             loc_lSucesso = .T.
128: 
129:         CATCH TO loc_oErro
130:             MsgErro("Erro ao inicializar formul" + CHR(225) + "rio: " + ;
131:                     loc_oErro.Message + " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
132:         ENDTRY
133: 
134:         RETURN loc_lSucesso
135:     ENDPROC
136: 
137:     *--------------------------------------------------------------------------
138:     * ConfigurarCabecalho - cabecalho cinza escuro com titulo (cntSombra legado)
139:     * Top=0, Left=0, Width=680, Height=80
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE ConfigurarCabecalho()
142:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
143:         WITH THIS.cnt_4c_Cabecalho
144:             .Top        = 0
145:             .Left       = 0
146:             .Width      = THIS.Width
147:             .Height     = 80
148:             .BackStyle  = 1
149:             .BackColor  = RGB(100,100,100)
150:             .BorderWidth = 0
151:             .Visible    = .T.
152: 
153:             *-- Sombra do titulo (deslocada 1px, cor preta)
154:             .AddObject("lbl_4c_Sombra", "Label")
155:             WITH .lbl_4c_Sombra
156:                 .AutoSize    = .F.
157:                 .FontBold    = .T.
158:                 .FontName    = "Tahoma"
159:                 .FontSize    = 18
160:                 .FontUnderline = .F.
161:                 .WordWrap    = .T.
162:                 .Alignment   = 0
163:                 .BackStyle   = 0
164:                 .Height      = 40
165:                 .Left        = 10
166:                 .Top         = 18
167:                 .Width       = THIS.Width
168:                 .ForeColor   = RGB(0,0,0)
169:                 .Caption     = THIS.Caption
170:                 .Visible     = .T.
171:             ENDWITH
172: 
173:             *-- Titulo principal (branco sobre fundo escuro)
174:             .AddObject("lbl_4c_Titulo", "Label")
175:             WITH .lbl_4c_Titulo
176:                 .AutoSize    = .F.
177:                 .FontBold    = .T.
178:                 .FontName    = "Tahoma"
179:                 .FontSize    = 18
180:                 .FontUnderline = .F.
181:                 .WordWrap    = .T.

*-- Linhas 196 a 258:
196:     * ConfigurarShape - shape decorativo por tras dos botoes (Shape3 legado)
197:     * Top=7, Left=486, Height=110, Width=173
198:     *--------------------------------------------------------------------------
199:     PROTECTED PROCEDURE ConfigurarShape()
200:         THIS.AddObject("shp_4c_Shape3", "Shape")
201:         WITH THIS.shp_4c_Shape3
202:             .Top         = 7
203:             .Left        = 486
204:             .Height      = 110
205:             .Width       = 173
206:             .BackStyle   = 0
207:             .BorderStyle = 0
208:             .BorderColor = RGB(90,90,90)
209:             .Visible     = .T.
210:         ENDWITH
211:     ENDPROC
212: 
213:     *--------------------------------------------------------------------------
214:     * ConfigurarBotoes - botoes principais Processar e Cancelar (Encerrar)
215:     * Processar: Top=3, Left=528, 75x75
216:     * Cancelar : Top=3, Left=603, 75x75
217:     *--------------------------------------------------------------------------
218:     PROTECTED PROCEDURE ConfigurarBotoes()
219:         *-- Botao Processar
220:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
221:         WITH THIS.cmd_4c_Processar
222:             .Top             = 3
223:             .Left            = 528
224:             .Height          = 75
225:             .Width           = 75
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
228:             .FontName        = "Tahoma"
229:             .FontSize        = 8
230:             .WordWrap        = .T.
231:             .Caption         = "Processar"
232:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
233:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
234:             .ForeColor       = RGB(90,90,90)
235:             .BackColor       = RGB(255,255,255)
236:             .Themes          = .T.
237:             .PicturePosition = 13
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .Visible         = .T.
241:         ENDWITH
242: 
243:         *-- Botao Cancelar (Encerrar) - Cancel=.T. ativa ESC (form sem TitleBar)
244:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
245:         WITH THIS.cmd_4c_Cancelar
246:             .Top             = 3
247:             .Left            = 603
248:             .Height          = 75
249:             .Width           = 75
250:             .FontBold        = .T.
251:             .FontItalic      = .T.
252:             .FontName        = "Tahoma"
253:             .FontSize        = 8
254:             .WordWrap        = .T.
255:             .Caption         = "Encerrar"
256:             .Cancel          = .T.
257:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
258:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 278 a 321:
278:     *   Cnt_Previsao-> cnt_4c_Previsao  (GetPrevisao + GetGeracao)
279:     *   Cnt_Op      -> cnt_4c_Op        (GetNop - visivel apenas se GlobAutos=2)
280:     *--------------------------------------------------------------------------
281:     PROTECTED PROCEDURE ConfigurarContainers()
282:         LOCAL loc_lGlobAutos2
283:         loc_lGlobAutos2 = .F.
284:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
285:             SELECT crSigCdPam
286:             loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
287:         ENDIF
288: 
289:         *-- Container1 legado: Tipo de O.P. - habilitado so no modo GerPorTp
290:         THIS.AddObject("cnt_4c_TipoOp", "Container")
291:         WITH THIS.cnt_4c_TipoOp
292:             .Top         = 164
293:             .Left        = 139
294:             .Width       = 346
295:             .Height      = 25
296:             .BackStyle   = 0
297:             .BorderWidth = 0
298:             .Enabled     = THIS.this_lGerPorTp
299:             .Visible     = .T.
300:         ENDWITH
301: 
302:         *-- Opera??o legado: codigo/faixa inicial/final de OP
303:         THIS.AddObject("cnt_4c_Operacao", "Container")
304:         WITH THIS.cnt_4c_Operacao
305:             .Top         = 191
306:             .Left        = 139
307:             .Width       = 350
308:             .Height      = 25
309:             .BackStyle   = 0
310:             .BorderWidth = 0
311:             .Visible     = .T.
312:         ENDWITH
313: 
314:         *-- Conta legado: grupo/conta/descricao para filtro de movimentacao
315:         THIS.AddObject("cnt_4c_Conta", "Container")
316:         WITH THIS.cnt_4c_Conta
317:             .Top         = 218
318:             .Left        = 139
319:             .Width       = 553
320:             .Height      = 25
321:             .BackStyle   = 0

*-- Linhas 377 a 503:
377:     ENDPROC
378: 
379:     *--------------------------------------------------------------------------
380:     * TornarControlesVisiveis - torna controles do form visiveis apos AddObject
381:     * Preserva Visible original de containers gerenciados individualmente
382:     * (cnt_4c_Op, cnt_4c_Cabecalho, cnt_4c_Previsao - cada um define seu Visible
383:     * proprio em ConfigurarContainers/ConfigurarCabecalho), mas recursa seus filhos
384:     * antes do LOOP para que estejam prontos quando o container vier a ser exibido.
385:     *--------------------------------------------------------------------------
386:     PROCEDURE TornarControlesVisiveis()
387:         LOCAL loc_i, loc_oCtrl, loc_lSkip
388:         FOR loc_i = 1 TO THIS.ControlCount
389:             loc_oCtrl = THIS.Controls(loc_i)
390:             IF VARTYPE(loc_oCtrl) != "O"
391:                 LOOP
392:             ENDIF
393:             loc_lSkip = INLIST(UPPER(loc_oCtrl.Name), "CNT_4C_OP", "CNT_4C_CABECALHO", "CNT_4C_PREVISAO")
394:             IF loc_lSkip
395:                 *-- Recursar filhos ANTES do LOOP (regra anti-ghost para containers hidden)
396:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
397:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
398:                 ENDIF
399:                 LOOP
400:             ENDIF
401:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
402:                 loc_oCtrl.Visible = .T.
403:             ENDIF
404:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
405:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
406:             ENDIF
407:         ENDFOR
408:     ENDPROC
409: 
410:     *--------------------------------------------------------------------------
411:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
412:         LOCAL loc_i, loc_oCtrl
413:         FOR loc_i = 1 TO par_oContainer.ControlCount
414:             loc_oCtrl = par_oContainer.Controls(loc_i)
415:             IF VARTYPE(loc_oCtrl) = "O"
416:                 IF PEMSTATUS(loc_oCtrl, "Visible", 5)
417:                     loc_oCtrl.Visible = .T.
418:                 ENDIF
419:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
420:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
421:                 ENDIF
422:             ENDIF
423:         ENDFOR
424:     ENDPROC
425: 
426:     *--------------------------------------------------------------------------
427:     * Destroy - libera cursores temporarios e BO antes de fechar
428:     *--------------------------------------------------------------------------
429:     PROCEDURE Destroy()
430:         IF USED("TmpOper")
431:             USE IN TmpOper
432:         ENDIF
433:         IF USED("TmpOper2")
434:             USE IN TmpOper2
435:         ENDIF
436:         IF USED("CrTmpTpGop")
437:             USE IN CrTmpTpGop
438:         ENDIF
439:         IF USED("TmpTpGop")
440:             USE IN TmpTpGop
441:         ENDIF
442:         IF USED("crSigCdPam")
443:             USE IN crSigCdPam
444:         ENDIF
445:         IF USED("crSigCdPac")
446:             USE IN crSigCdPac
447:         ENDIF
448:         IF USED("crSigCdOpd")
449:             USE IN crSigCdOpd
450:         ENDIF
451:         IF USED("DBParam")
452:             USE IN DBParam
453:         ENDIF
454:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
455:             THIS.this_oBusinessObject = .NULL.
456:         ENDIF
457:         DODEFAULT()
458:     ENDPROC
459: 
460:     *--------------------------------------------------------------------------
461:     * ConfigurarCamposForm - labels e textboxes de data diretamente no form
462:     *--------------------------------------------------------------------------
463:     PROTECTED PROCEDURE ConfigurarCamposForm()
464:         THIS.AddObject("lbl_4c_PeriodoEmissao", "Label")
465:         WITH THIS.lbl_4c_PeriodoEmissao
466:             .AutoSize  = .F.
467:             .BackStyle = 0
468:             .FontName  = "Tahoma"
469:             .FontSize  = 8
470:             .ForeColor = RGB(90,90,90)
471:             .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o :"
472:             .Height    = 15
473:             .Left      = 32
474:             .Top       = 115
475:             .Width     = 101
476:         ENDWITH
477: 
478:         THIS.AddObject("txt_4c_Dataei", "TextBox")
479:         WITH THIS.txt_4c_Dataei
480:             .Alignment     = 3
481:             .Value         = {}
482:             .Format        = "K"
483:             .Height        = 23
484:             .Left          = 142
485:             .Top           = 111
486:             .Width         = 80
487:             .SpecialEffect = 1
488:             .FontName      = "Tahoma"
489:             .FontSize      = 8
490:         ENDWITH
491: 
492:         THIS.AddObject("lbl_4c_Ate1", "Label")
493:         WITH THIS.lbl_4c_Ate1
494:             .AutoSize  = .F.
495:             .BackStyle = 0
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .ForeColor = RGB(90,90,90)
499:             .Caption   = "at" + CHR(233)
500:             .Height    = 15
501:             .Left      = 227
502:             .Top       = 115
503:             .Width     = 18

*-- Linhas 647 a 708:
647:     *--------------------------------------------------------------------------
648:     * ConfigurarContainerTipoOp - Get_TpGOp (Container1 legado)
649:     *--------------------------------------------------------------------------
650:     PROTECTED PROCEDURE ConfigurarContainerTipoOp()
651:         THIS.cnt_4c_TipoOp.AddObject("txt_4c_TpGOp", "TextBox")
652:         WITH THIS.cnt_4c_TipoOp.txt_4c_TpGOp
653:             .Left          = 3
654:             .Top           = 1
655:             .Width         = 80
656:             .Height        = 23
657:             .MaxLength     = 10
658:             .FontName      = "Courier New"
659:             .FontSize      = 9
660:             .Margin        = 2
661:             .SpecialEffect = 1
662:         ENDWITH
663:     ENDPROC
664: 
665:     *--------------------------------------------------------------------------
666:     * ConfigurarContainerOperacao - Opera_ao legado: codigo + faixa i/f
667:     *--------------------------------------------------------------------------
668:     PROTECTED PROCEDURE ConfigurarContainerOperacao()
669:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
670:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacao
671:             .Left          = 3
672:             .Top           = 1
673:             .Width         = 151
674:             .Height        = 23
675:             .MaxLength     = 20
676:             .FontName      = "Courier New"
677:             .FontSize      = 9
678:             .Margin        = 2
679:             .SpecialEffect = 1
680:         ENDWITH
681: 
682:         THIS.cnt_4c_Operacao.AddObject("lbl_4c_De", "Label")
683:         WITH THIS.cnt_4c_Operacao.lbl_4c_De
684:             .AutoSize  = .F.
685:             .BackStyle = 0
686:             .FontName  = "Tahoma"
687:             .FontSize  = 8
688:             .ForeColor = RGB(90,90,90)
689:             .Caption   = "de"
690:             .Height    = 15
691:             .Left      = 180
692:             .Top       = 5
693:             .Width     = 14
694:         ENDWITH
695: 
696:         THIS.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
697:         WITH THIS.cnt_4c_Operacao.txt_4c_Operacaoi
698:             .Alignment     = 3
699:             .Value         = 0
700:             .Format        = "K"
701:             .Height        = 23
702:             .InputMask     = "999999"
703:             .Left          = 201
704:             .Top           = 1
705:             .Width         = 55
706:             .MaxLength     = 6
707:             .SpecialEffect = 1
708:             .FontName      = "Courier New"

*-- Linhas 743 a 862:
743:     *--------------------------------------------------------------------------
744:     * ConfigurarContainerConta - Movimentacao: grupo/conta/descricao
745:     *--------------------------------------------------------------------------
746:     PROTECTED PROCEDURE ConfigurarContainerConta()
747:         THIS.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
748:         WITH THIS.cnt_4c_Conta.txt_4c_Grupo
749:             .Left          = 3
750:             .Top           = 1
751:             .Width         = 80
752:             .Height        = 23
753:             .SpecialEffect = 1
754:             .FontName      = "Tahoma"
755:             .FontSize      = 8
756:         ENDWITH
757: 
758:         THIS.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
759:         WITH THIS.cnt_4c_Conta.txt_4c_Conta
760:             .Left          = 86
761:             .Top           = 1
762:             .Width         = 80
763:             .Height        = 23
764:             .SpecialEffect = 1
765:             .FontName      = "Tahoma"
766:             .FontSize      = 8
767:         ENDWITH
768: 
769:         THIS.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
770:         WITH THIS.cnt_4c_Conta.txt_4c_Dconta
771:             .Left          = 170
772:             .Top           = 1
773:             .Width         = 360
774:             .Height        = 23
775:             .SpecialEffect = 1
776:             .FontName      = "Tahoma"
777:             .FontSize      = 8
778:         ENDWITH
779:     ENDPROC
780: 
781:     *--------------------------------------------------------------------------
782:     * ConfigurarContainerResponsavel - Vendedor: grupo/conta/descricao
783:     *--------------------------------------------------------------------------
784:     PROTECTED PROCEDURE ConfigurarContainerResponsavel()
785:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_GrupoResp", "TextBox")
786:         WITH THIS.cnt_4c_Responsavel.txt_4c_GrupoResp
787:             .Left          = 3
788:             .Top           = 1
789:             .Width         = 80
790:             .Height        = 23
791:             .SpecialEffect = 1
792:             .FontName      = "Tahoma"
793:             .FontSize      = 8
794:         ENDWITH
795: 
796:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_ContaResp", "TextBox")
797:         WITH THIS.cnt_4c_Responsavel.txt_4c_ContaResp
798:             .Left          = 86
799:             .Top           = 1
800:             .Width         = 80
801:             .Height        = 23
802:             .SpecialEffect = 1
803:             .FontName      = "Tahoma"
804:             .FontSize      = 8
805:         ENDWITH
806: 
807:         THIS.cnt_4c_Responsavel.AddObject("txt_4c_DcontaResp", "TextBox")
808:         WITH THIS.cnt_4c_Responsavel.txt_4c_DcontaResp
809:             .Left          = 170
810:             .Top           = 1
811:             .Width         = 360
812:             .Height        = 23
813:             .SpecialEffect = 1
814:             .FontName      = "Tahoma"
815:             .FontSize      = 8
816:         ENDWITH
817:     ENDPROC
818: 
819:     *--------------------------------------------------------------------------
820:     * ConfigurarContainerEmpresa - cd_empresa / ds_empresa / chk pedras
821:     *--------------------------------------------------------------------------
822:     PROTECTED PROCEDURE ConfigurarContainerEmpresa()
823:         THIS.cnt_4c_Empresa.AddObject("txt_4c_CdEmpresa", "TextBox")
824:         WITH THIS.cnt_4c_Empresa.txt_4c_CdEmpresa
825:             .Left          = 4
826:             .Top           = 1
827:             .Width         = 31
828:             .Height        = 23
829:             .InputMask     = "XXX"
830:             .MaxLength     = 3
831:             .Format        = "k"
832:             .BackStyle     = 1
833:             .BorderStyle   = 1
834:             .ForeColor     = RGB(0,0,0)
835:             .FontName      = "Courier New"
836:             .FontSize      = 9
837:             .SpecialEffect = 1
838:         ENDWITH
839: 
840:         THIS.cnt_4c_Empresa.AddObject("txt_4c_DsEmpresa", "TextBox")
841:         WITH THIS.cnt_4c_Empresa.txt_4c_DsEmpresa
842:             .Left          = 38
843:             .Top           = 1
844:             .Width         = 282
845:             .Height        = 23
846:             .MaxLength     = 40
847:             .Format        = "K"
848:             .FontName      = "Courier New"
849:             .FontSize      = 9
850:             .SpecialEffect = 1
851:         ENDWITH
852: 
853:         THIS.cnt_4c_Empresa.AddObject("chk_4c_NaoEmpPedra", "CheckBox")
854:         WITH THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra
855:             .Left      = 330
856:             .Top       = 5
857:             .Height    = 15
858:             .Width     = 124
859:             .FontName  = "Tahoma"
860:             .FontSize  = 8
861:             .BackStyle = 0
862:             .Caption   = "N" + CHR(227) + "o Empenhar Pedras"

*-- Linhas 869 a 912:
869:     *--------------------------------------------------------------------------
870:     * ConfigurarContainerPrevisao - data previsao entrega + data geracao
871:     *--------------------------------------------------------------------------
872:     PROTECTED PROCEDURE ConfigurarContainerPrevisao()
873:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblPrevisao", "Label")
874:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblPrevisao
875:             .AutoSize  = .F.
876:             .BackStyle = 0
877:             .FontName  = "Tahoma"
878:             .FontSize  = 8
879:             .ForeColor = RGB(90,90,90)
880:             .Caption   = "Previs" + CHR(227) + "o de Entrega :"
881:             .Height    = 15
882:             .Left      = 7
883:             .Top       = 9
884:             .Width     = 106
885:         ENDWITH
886: 
887:         THIS.cnt_4c_Previsao.AddObject("txt_4c_Previsao", "TextBox")
888:         WITH THIS.cnt_4c_Previsao.txt_4c_Previsao
889:             .Alignment     = 3
890:             .Value         = {}
891:             .Format        = "K"
892:             .Height        = 23
893:             .Left          = 134
894:             .Top           = 5
895:             .Width         = 80
896:             .SpecialEffect = 1
897:             .FontName      = "Tahoma"
898:             .FontSize      = 8
899:         ENDWITH
900: 
901:         THIS.cnt_4c_Previsao.AddObject("lbl_4c_LblGeracao", "Label")
902:         WITH THIS.cnt_4c_Previsao.lbl_4c_LblGeracao
903:             .AutoSize  = .F.
904:             .BackStyle = 0
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .ForeColor = RGB(90,90,90)
908:             .Caption   = "Data de Gera" + CHR(231) + CHR(227) + "o :"
909:             .Height    = 15
910:             .Left      = 244
911:             .Top       = 9
912:             .Width     = 90

*-- Linhas 930 a 1101:
930:     *--------------------------------------------------------------------------
931:     * ConfigurarContainerOp - numero da OP manual (Cnt_Op legado)
932:     *--------------------------------------------------------------------------
933:     PROTECTED PROCEDURE ConfigurarContainerOp()
934:         THIS.cnt_4c_Op.AddObject("lbl_4c_LblNop", "Label")
935:         WITH THIS.cnt_4c_Op.lbl_4c_LblNop
936:             .AutoSize  = .F.
937:             .BackStyle = 0
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .ForeColor = RGB(90,90,90)
941:             .Caption   = "N" + CHR(186) + " da O.P.:"
942:             .Height    = 15
943:             .Left      = 0
944:             .Top       = 5
945:             .Width     = 58
946:         ENDWITH
947: 
948:         THIS.cnt_4c_Op.AddObject("txt_4c_Nop", "TextBox")
949:         WITH THIS.cnt_4c_Op.txt_4c_Nop
950:             .Alignment     = 3
951:             .Value         = 0
952:             .Height        = 23
953:             .InputMask     = "999999"
954:             .Left          = 71
955:             .Top           = 1
956:             .Width         = 59
957:             .MaxLength     = 6
958:             .SpecialEffect = 1
959:             .FontName      = "Tahoma"
960:             .FontSize      = 8
961:         ENDWITH
962:     ENDPROC
963: 
964:     *--------------------------------------------------------------------------
965:     * PopularCamposIniciais - preenche valores iniciais apos criacao dos controles
966:     *--------------------------------------------------------------------------
967:     PROTECTED PROCEDURE PopularCamposIniciais()
968:         LOCAL loc_oErro
969:         TRY
970:             *-- Empresa: dados ja carregados pelo BO via CarregarEmpresa
971:             THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = THIS.this_oBusinessObject.this_cCdEmpresa
972:             THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = THIS.this_oBusinessObject.this_cDsEmpresa
973: 
974:             *-- Previsao de entrega: data atual + PrevProds dias (parametro SigCdPam)
975:             IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
976:                 SELECT crSigCdPam
977:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = DATE() + crSigCdPam.PrevProds
978:             ENDIF
979: 
980:             *-- Data de geracao: data atual (apenas se nao modo automatico)
981:             IF NOT THIS.this_lAutomatico
982:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value = DATE()
983:             ENDIF
984: 
985:             *-- Checkbox pedras: visibilidade calculada em InicializarForm
986:             THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Visible = THIS.this_lMostrarChkPedra
987: 
988:             *-- Tipo de OP: pre-selecionar se GerPorTp e apenas 1 tipo disponivel
989:             IF THIS.this_lGerPorTp AND NOT EMPTY(THIS.this_oBusinessObject.this_cTpGOp)
990:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = THIS.this_oBusinessObject.this_cTpGOp
991:             ENDIF
992:         CATCH TO loc_oErro
993:             MsgErro("Erro ao popular campos: " + loc_oErro.Message, "Erro")
994:         ENDTRY
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     * ConfigurarEventos - registra handlers via BINDEVENT (metodos PUBLIC)
999:     *--------------------------------------------------------------------------
1000:     PROTECTED PROCEDURE ConfigurarEventos()
1001:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "CmdProcessarClick")
1002:         BINDEVENT(THIS.cmd_4c_Cancelar,  "Click", THIS, "CmdCancelarClick")
1003:         BINDEVENT(THIS.cnt_4c_TipoOp.txt_4c_TpGOp,          "KeyPress", THIS, "TxtTpGOpKeyPress")
1004:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacao,      "KeyPress", THIS, "TxtOperacaoKeyPress")
1005:         BINDEVENT(THIS.cnt_4c_Operacao.txt_4c_Operacaoi,     "KeyPress", THIS, "TxtOperacaoiKeyPress")
1006:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Grupo,            "KeyPress", THIS, "TxtGrupoContaKeyPress")
1007:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Conta,            "KeyPress", THIS, "TxtContaKeyPress")
1008:         BINDEVENT(THIS.cnt_4c_Conta.txt_4c_Dconta,           "KeyPress", THIS, "TxtDcontaKeyPress")
1009:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp,  "KeyPress", THIS, "TxtGrupoRespKeyPress")
1010:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_ContaResp,  "KeyPress", THIS, "TxtContaRespKeyPress")
1011:         BINDEVENT(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp, "KeyPress", THIS, "TxtDcontaRespKeyPress")
1012:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa,      "KeyPress", THIS, "TxtCdEmpresaKeyPress")
1013:         BINDEVENT(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa,      "KeyPress", THIS, "TxtDsEmpresaKeyPress")
1014:         BINDEVENT(THIS.cnt_4c_Op.txt_4c_Nop,                 "KeyPress", THIS, "TxtNopKeyPress")
1015:     ENDPROC
1016: 
1017:     *--------------------------------------------------------------------------
1018:     * CmdProcessarClick - valida campos, copia ao BO e executa processamento
1019:     *
1020:     * Gerenciamento de estado (equivalente aos BtnIncluirClick/Alterar/etc. do CRUD):
1021:     *   1. Validacoes (retorna se falha - UI permanece em ENTRADA)
1022:     *   2. Copia campos do form para o BO
1023:     *   3. AlternarPagina("PROCESSANDO") - bloqueia UI durante operacao
1024:     *   4. BO.ProcessarOrdens() - logica de negocio
1025:     *   5. AlternarPagina("ENTRADA") - restaura UI (sempre, inclusive em erro)
1026:     *--------------------------------------------------------------------------
1027:     PROCEDURE CmdProcessarClick()
1028:         LOCAL loc_nGlobAutos, loc_oErro, loc_lProcessou
1029:         loc_nGlobAutos  = 0
1030:         loc_lProcessou  = .F.
1031: 
1032:         *-- Validar previsao e geracao (obrigatorias em modo normal)
1033:         IF NOT THIS.this_lReserva
1034:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Previsao.Value)
1035:                 MsgAviso("A Data de Previs" + CHR(227) + "o Deve Ser Preenchida!!!", "Aviso")
1036:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
1037:                 RETURN
1038:             ENDIF
1039:             IF EMPTY(THIS.cnt_4c_Previsao.txt_4c_Geracao.Value)
1040:                 MsgAviso("A Data de Gera" + CHR(231) + CHR(227) + "o Deve Ser Preenchida!!!", "Aviso")
1041:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.SetFocus
1042:                 RETURN
1043:             ENDIF
1044:         ENDIF
1045: 
1046:         *-- Validar numero OP manual (GlobAutos=2)
1047:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
1048:             SELECT crSigCdPam
1049:             loc_nGlobAutos = crSigCdPam.GlobAutos
1050:             IF loc_nGlobAutos = 2 AND NOT THIS.this_lReserva
1051:                 IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1052:                     MsgAviso("O N" + CHR(250) + "mero da OP " + CHR(233) + " Manual e Deve Ser Preenchido!!!", "Aviso")
1053:                     THIS.cnt_4c_Op.txt_4c_Nop.SetFocus
1054:                     RETURN
1055:                 ENDIF
1056:             ENDIF
1057:         ENDIF
1058: 
1059:         *-- Validar tipo de OP (obrigatorio no modo GerPorTp)
1060:         IF THIS.this_lGerPorTp AND EMPTY(ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value))
1061:             MsgAviso("O Tipo de Gera" + CHR(231) + CHR(227) + "o da OP " + CHR(233) + ;
1062:                      " Obrigat" + CHR(243) + "rio ser Preenchido!!!", "Aviso")
1063:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.SetFocus
1064:             RETURN
1065:         ENDIF
1066: 
1067:         *-- Copiar campos do form para o BO
1068:         WITH THIS.this_oBusinessObject
1069:             .this_dDataei      = THIS.txt_4c_Dataei.Value
1070:             .this_dDataef      = THIS.txt_4c_Dataef.Value
1071:             .this_dDatapi      = THIS.txt_4c_Datapi.Value
1072:             .this_dDatapf      = THIS.txt_4c_Datapf.Value
1073:             .this_cOperacao    = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1074:             .this_nOperacaoi   = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1075:             .this_nOperacaof   = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
1076:             .this_cGrupoConta  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1077:             .this_cConta       = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1078:             .this_cDconta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1079:             .this_cGrupoResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1080:             .this_cContaResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1081:             .this_cCdEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1082:             .this_nNaoEmpPedra = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
1083:             .this_cTpGOp       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1084:             .this_dPrevisao    = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
1085:             .this_dGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
1086:             .this_nNop         = THIS.cnt_4c_Op.txt_4c_Nop.Value
1087:         ENDWITH
1088: 
1089:         *-- Bloquear UI durante processamento (equivale ao "estado PROCESSANDO")
1090:         THIS.AlternarPagina("PROCESSANDO")
1091: 
1092:         TRY
1093:             loc_lProcessou = THIS.this_oBusinessObject.ProcessarOrdens()
1094:         CATCH TO loc_oErro
1095:             MsgErro("Erro no processamento: " + loc_oErro.Message + ;
1096:                     " [Ln:" + TRANSFORM(loc_oErro.LineNo) + "]", "Erro")
1097:             loc_lProcessou = .F.
1098:         ENDTRY
1099: 
1100:         *-- Restaurar UI (sempre - inclusive em caso de erro)
1101:         THIS.AlternarPagina("ENTRADA")

*-- Linhas 1108 a 1598:
1108:     *--------------------------------------------------------------------------
1109:     * CmdCancelarClick - fecha o formulario (Encerrar)
1110:     *--------------------------------------------------------------------------
1111:     PROCEDURE CmdCancelarClick()
1112:         THIS.Release()
1113:     ENDPROC
1114: 
1115:     *--------------------------------------------------------------------------
1116:     * TxtTpGOpKeyPress - lookup tipo de OP (CrTmpTpGop - cursor VFP local)
1117:     *--------------------------------------------------------------------------
1118:     PROCEDURE TxtTpGOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1119:         LOCAL loc_cVal, loc_oBusca
1120:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1121:             RETURN
1122:         ENDIF
1123:         IF NOT THIS.cnt_4c_TipoOp.Enabled
1124:             RETURN
1125:         ENDIF
1126:         loc_cVal = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1127:         *-- Tentar SEEK direto antes de abrir picker
1128:         IF NOT EMPTY(loc_cVal) AND USED("CrTmpTpGop")
1129:             SELECT CrTmpTpGop
1130:             IF SEEK(loc_cVal, "CrTmpTpGop", "Codigos")
1131:                 RETURN
1132:             ENDIF
1133:         ENDIF
1134:         IF NOT USED("CrTmpTpGop")
1135:             MsgAviso("Tipos de O.P. n" + CHR(227) + "o carregados.", "Aviso")
1136:             RETURN
1137:         ENDIF
1138:         *-- Pre-popular cursor e abrir picker
1139:         IF USED("cursor_4c_TpGOp")
1140:             USE IN cursor_4c_TpGOp
1141:         ENDIF
1142:         SELECT Codigos, Descs FROM CrTmpTpGop INTO CURSOR cursor_4c_TpGOp READWRITE
1143:         SELECT cursor_4c_TpGOp
1144:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1145:         IF VARTYPE(loc_oBusca) = "O"
1146:             WITH loc_oBusca
1147:                 .this_cCursorDestino = "cursor_4c_TpGOp"
1148:                 .this_cTitulo        = "Tipos de Gera" + CHR(231) + CHR(227) + "o de OP"
1149:                 .this_cCampoBusca    = "Codigos"
1150:                 .this_cValorBusca    = loc_cVal
1151:                 .mAddColuna("Codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1152:                 .mAddColuna("Descs",   "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1153:                 .Show()
1154:                 IF .this_lSelecionou
1155:                     SELECT cursor_4c_TpGOp
1156:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ALLTRIM(cursor_4c_TpGOp.Codigos)
1157:                 ELSE
1158:                     THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1159:                 ENDIF
1160:             ENDWITH
1161:             loc_oBusca = .NULL.
1162:         ENDIF
1163:     ENDPROC
1164: 
1165:     *--------------------------------------------------------------------------
1166:     * TxtOperacaoKeyPress - lookup operacao (TmpOper - cursor VFP local)
1167:     *--------------------------------------------------------------------------
1168:     PROCEDURE TxtOperacaoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1169:         LOCAL loc_cVal, loc_cTpGOp, loc_oBusca
1170:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1171:             RETURN
1172:         ENDIF
1173:         loc_cVal = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1174:         *-- Vazio: limpar faixa inicial/final
1175:         IF EMPTY(loc_cVal)
1176:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1177:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1178:             RETURN
1179:         ENDIF
1180:         IF NOT USED("TmpOper")
1181:             MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o carregadas.", "Aviso")
1182:             RETURN
1183:         ENDIF
1184:         *-- Montar cursor filtrado por TpGOp se necessario
1185:         IF USED("cursor_4c_Oper")
1186:             USE IN cursor_4c_Oper
1187:         ENDIF
1188:         IF THIS.this_lGerPorTp
1189:             loc_cTpGOp = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1190:             SELECT Dopes, NDopes FROM TmpOper WHERE CodTgOps = loc_cTpGOp INTO CURSOR cursor_4c_Oper READWRITE
1191:         ELSE
1192:             SELECT Dopes, NDopes FROM TmpOper INTO CURSOR cursor_4c_Oper READWRITE
1193:         ENDIF
1194:         SELECT cursor_4c_Oper
1195:         INDEX ON Dopes TAG Dopes
1196:         *-- Tentar SEEK direto
1197:         IF SEEK(loc_cVal, "cursor_4c_Oper", "Dopes")
1198:             RETURN
1199:         ENDIF
1200:         *-- Abrir picker
1201:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
1202:         IF VARTYPE(loc_oBusca) = "O"
1203:             WITH loc_oBusca
1204:                 .this_cCursorDestino = "cursor_4c_Oper"
1205:                 .this_cTitulo        = "Cadastro de Opera" + CHR(231) + CHR(245) + "es"
1206:                 .this_cCampoBusca    = "Dopes"
1207:                 .this_cValorBusca    = loc_cVal
1208:                 .mAddColuna("Dopes",  "", "Opera" + CHR(231) + CHR(227) + "o")
1209:                 .mAddColuna("NDopes", "XXXXXX", "C" + CHR(243) + "digo")
1210:                 .Show()
1211:                 IF .this_lSelecionou
1212:                     SELECT cursor_4c_Oper
1213:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value = ALLTRIM(cursor_4c_Oper.Dopes)
1214:                 ELSE
1215:                     THIS.cnt_4c_Operacao.txt_4c_Operacao.Value   = ""
1216:                     THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value  = 0
1217:                     THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value  = 0
1218:                 ENDIF
1219:             ENDWITH
1220:             loc_oBusca = .NULL.
1221:         ENDIF
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * TxtOperacaoiKeyPress - auto-popula faixa final quando faixa inicial preenchida
1226:     *--------------------------------------------------------------------------
1227:     PROCEDURE TxtOperacaoiKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1228:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1229:             RETURN
1230:         ENDIF
1231:         IF THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value > 0 AND ;
1232:            THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1233:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1234:         ENDIF
1235:     ENDPROC
1236: 
1237:     *--------------------------------------------------------------------------
1238:     * TxtGrupoContaKeyPress - lookup grupo contabil (SigCdGcr) para Movimentacao
1239:     *--------------------------------------------------------------------------
1240:     PROCEDURE TxtGrupoContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1241:         LOCAL loc_cVal, loc_oBusca
1242:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1243:             RETURN
1244:         ENDIF
1245:         loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1246:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1247:             "cursor_4c_GrpConta", "codigos", loc_cVal, ;
1248:             "Grupos Cont" + CHR(225) + "beis", .F., .T., "")
1249:         IF VARTYPE(loc_oBusca) = "O"
1250:             WITH loc_oBusca
1251:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1252:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1253:                 .Show()
1254:                 IF .this_lSelecionou
1255:                     SELECT cursor_4c_GrpConta
1256:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_GrpConta.codigos)
1257:                 ELSE
1258:                     THIS.cnt_4c_Conta.txt_4c_Grupo.Value = ""
1259:                 ENDIF
1260:             ENDWITH
1261:             loc_oBusca = .NULL.
1262:         ENDIF
1263:     ENDPROC
1264: 
1265:     *--------------------------------------------------------------------------
1266:     * TxtContaKeyPress - lookup conta por codigo IClis (SigCdCli)
1267:     *--------------------------------------------------------------------------
1268:     PROCEDURE TxtContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1269:         LOCAL loc_cVal, loc_oBusca
1270:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1271:             RETURN
1272:         ENDIF
1273:         loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1274:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1275:             "cursor_4c_CliConta", "IClis", loc_cVal, ;
1276:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o", .F., .T., "")
1277:         IF VARTYPE(loc_oBusca) = "O"
1278:             WITH loc_oBusca
1279:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1280:                 .mAddColuna("RClis", "                                        ", "Nome")
1281:                 .Show()
1282:                 IF .this_lSelecionou
1283:                     SELECT cursor_4c_CliConta
1284:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliConta.IClis)
1285:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliConta.RClis)
1286:                 ELSE
1287:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1288:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1289:                 ENDIF
1290:             ENDWITH
1291:             loc_oBusca = .NULL.
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     *--------------------------------------------------------------------------
1296:     * TxtDcontaKeyPress - lookup conta por nome RClis (apenas quando Conta vazia)
1297:     *--------------------------------------------------------------------------
1298:     PROCEDURE TxtDcontaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1299:         LOCAL loc_cVal, loc_oBusca
1300:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1301:             RETURN
1302:         ENDIF
1303:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value))
1304:             RETURN
1305:         ENDIF
1306:         loc_cVal = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1307:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1308:             "cursor_4c_CliDconta", "RClis", loc_cVal, ;
1309:             "Clientes - Movimenta" + CHR(231) + CHR(227) + "o (Nome)", .F., .T., "")
1310:         IF VARTYPE(loc_oBusca) = "O"
1311:             WITH loc_oBusca
1312:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1313:                 .mAddColuna("RClis", "                                        ", "Nome")
1314:                 .Show()
1315:                 IF .this_lSelecionou
1316:                     SELECT cursor_4c_CliDconta
1317:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_CliDconta.IClis)
1318:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_CliDconta.RClis)
1319:                 ELSE
1320:                     THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1321:                     THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1322:                 ENDIF
1323:             ENDWITH
1324:             loc_oBusca = .NULL.
1325:         ENDIF
1326:     ENDPROC
1327: 
1328:     *--------------------------------------------------------------------------
1329:     * TxtGrupoRespKeyPress - lookup grupo contabil (SigCdGcr) para Vendedor
1330:     *--------------------------------------------------------------------------
1331:     PROCEDURE TxtGrupoRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1332:         LOCAL loc_cVal, loc_oBusca
1333:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1334:             RETURN
1335:         ENDIF
1336:         loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1337:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdGcr", ;
1338:             "cursor_4c_GrpResp", "codigos", loc_cVal, ;
1339:             "Grupos - Vendedor", .F., .T., "")
1340:         IF VARTYPE(loc_oBusca) = "O"
1341:             WITH loc_oBusca
1342:                 .mAddColuna("codigos", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1343:                 .mAddColuna("descrs",  "                              ", "Descri" + CHR(231) + CHR(227) + "o")
1344:                 .Show()
1345:                 IF .this_lSelecionou
1346:                     SELECT cursor_4c_GrpResp
1347:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ALLTRIM(cursor_4c_GrpResp.codigos)
1348:                 ELSE
1349:                     THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value = ""
1350:                 ENDIF
1351:             ENDWITH
1352:             loc_oBusca = .NULL.
1353:         ENDIF
1354:     ENDPROC
1355: 
1356:     *--------------------------------------------------------------------------
1357:     * TxtContaRespKeyPress - lookup vendedor por codigo IClis (SigCdCli)
1358:     *--------------------------------------------------------------------------
1359:     PROCEDURE TxtContaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1360:         LOCAL loc_cVal, loc_oBusca
1361:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1362:             RETURN
1363:         ENDIF
1364:         loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1365:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1366:             "cursor_4c_CliResp", "IClis", loc_cVal, ;
1367:             "Clientes - Vendedor", .F., .T., "")
1368:         IF VARTYPE(loc_oBusca) = "O"
1369:             WITH loc_oBusca
1370:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1371:                 .mAddColuna("RClis", "                                        ", "Nome")
1372:                 .Show()
1373:                 IF .this_lSelecionou
1374:                     SELECT cursor_4c_CliResp
1375:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliResp.IClis)
1376:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliResp.RClis)
1377:                 ELSE
1378:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1379:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1380:                 ENDIF
1381:             ENDWITH
1382:             loc_oBusca = .NULL.
1383:         ENDIF
1384:     ENDPROC
1385: 
1386:     *--------------------------------------------------------------------------
1387:     * TxtDcontaRespKeyPress - lookup vendedor por nome RClis (apenas quando ContaResp vazia)
1388:     *--------------------------------------------------------------------------
1389:     PROCEDURE TxtDcontaRespKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1390:         LOCAL loc_cVal, loc_oBusca
1391:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1392:             RETURN
1393:         ENDIF
1394:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value))
1395:             RETURN
1396:         ENDIF
1397:         loc_cVal = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1398:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdCli", ;
1399:             "cursor_4c_CliDcontaResp", "RClis", loc_cVal, ;
1400:             "Clientes - Vendedor (Nome)", .F., .T., "")
1401:         IF VARTYPE(loc_oBusca) = "O"
1402:             WITH loc_oBusca
1403:                 .mAddColuna("IClis", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1404:                 .mAddColuna("RClis", "                                        ", "Nome")
1405:                 .Show()
1406:                 IF .this_lSelecionou
1407:                     SELECT cursor_4c_CliDcontaResp
1408:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ALLTRIM(cursor_4c_CliDcontaResp.IClis)
1409:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ALLTRIM(cursor_4c_CliDcontaResp.RClis)
1410:                 ELSE
1411:                     THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1412:                     THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1413:                 ENDIF
1414:             ENDWITH
1415:             loc_oBusca = .NULL.
1416:         ENDIF
1417:     ENDPROC
1418: 
1419:     *--------------------------------------------------------------------------
1420:     * TxtCdEmpresaKeyPress - lookup empresa por codigo Cemps (SigCdEmp)
1421:     *   Apenas se AlterEmp = .T.
1422:     *--------------------------------------------------------------------------
1423:     PROCEDURE TxtCdEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1424:         LOCAL loc_cVal, loc_oBusca
1425:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1426:             RETURN
1427:         ENDIF
1428:         IF NOT THIS.this_lAlterEmp
1429:             RETURN
1430:         ENDIF
1431:         loc_cVal = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1432:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1433:             "cursor_4c_Emp", "Cemps", loc_cVal, ;
1434:             "Empresas", .F., .T., "")
1435:         IF VARTYPE(loc_oBusca) = "O"
1436:             WITH loc_oBusca
1437:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1438:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1439:                 .Show()
1440:                 IF .this_lSelecionou
1441:                     SELECT cursor_4c_Emp
1442:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_Emp.Cemps)
1443:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_Emp.Razas)
1444:                 ELSE
1445:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1446:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1447:                 ENDIF
1448:             ENDWITH
1449:             loc_oBusca = .NULL.
1450:         ENDIF
1451:     ENDPROC
1452: 
1453:     *--------------------------------------------------------------------------
1454:     * TxtDsEmpresaKeyPress - lookup empresa por razao social Razas (SigCdEmp)
1455:     *   Apenas se AlterEmp = .T. e CdEmpresa vazio
1456:     *--------------------------------------------------------------------------
1457:     PROCEDURE TxtDsEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1458:         LOCAL loc_cVal, loc_oBusca
1459:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1460:             RETURN
1461:         ENDIF
1462:         IF NOT THIS.this_lAlterEmp
1463:             RETURN
1464:         ENDIF
1465:         IF NOT EMPTY(ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value))
1466:             RETURN
1467:         ENDIF
1468:         loc_cVal = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1469:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdEmp", ;
1470:             "cursor_4c_EmpDs", "Razas", loc_cVal, ;
1471:             "Empresas (Raz" + CHR(227) + "o Social)", .F., .T., "")
1472:         IF VARTYPE(loc_oBusca) = "O"
1473:             WITH loc_oBusca
1474:                 .mAddColuna("Cemps", "XXX", "C" + CHR(243) + "digo")
1475:                 .mAddColuna("Razas", "                                        ", "Raz" + CHR(227) + "o Social")
1476:                 .Show()
1477:                 IF .this_lSelecionou
1478:                     SELECT cursor_4c_EmpDs
1479:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Cemps)
1480:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpDs.Razas)
1481:                 ELSE
1482:                     THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value = ""
1483:                     THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value = ""
1484:                 ENDIF
1485:             ENDWITH
1486:             loc_oBusca = .NULL.
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     *--------------------------------------------------------------------------
1491:     * TxtNopKeyPress - valida numero de OP: nao pode ja existir em SigOpPic
1492:     *--------------------------------------------------------------------------
1493:     PROCEDURE TxtNopKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1494:         IF par_nKeyCode != 13 AND par_nKeyCode != 9 AND par_nKeyCode != 115
1495:             RETURN
1496:         ENDIF
1497:         IF THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1498:             RETURN
1499:         ENDIF
1500:         IF NOT THIS.this_oBusinessObject.ValidarNumeroOP(THIS.cnt_4c_Op.txt_4c_Nop.Value)
1501:             MsgAviso("N" + CHR(250) + "mero de OP j" + CHR(225) + " existe. Favor Corrigir!!!", "Aviso")
1502:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1503:         ENDIF
1504:     ENDPROC
1505: 
1506:     *--------------------------------------------------------------------------
1507:     * ConfigurarPaginaLista - monta a "pagina de entrada" (equivalente da Lista em CRUD)
1508:     *
1509:     * Form OPERACIONAL nao possui Grid/CRUD. A "pagina de entrada" agrupa:
1510:     *   - botoes de acao (Processar / Encerrar)
1511:     *   - containers de filtros/parametros (Tipo OP, Operacao, Conta, Responsavel,
1512:     *     Empresa, Previsao, N. OP manual) e os campos avulsos de data (Emissao)
1513:     *
1514:     * Este metodo consolida a construcao visual da area principal, chamado uma
1515:     * unica vez em InicializarForm apos ConfigurarCabecalho/ConfigurarShape.
1516:     *--------------------------------------------------------------------------
1517:     PROTECTED PROCEDURE ConfigurarPaginaLista()
1518:         *-- Botoes de acao (Processar / Cancelar)
1519:         THIS.ConfigurarBotoes()
1520: 
1521:         *-- Containers principais (esqueletos vazios)
1522:         THIS.ConfigurarContainers()
1523: 
1524:         *-- Campos avulsos no form (labels + textboxes de data de emissao/previsao)
1525:         THIS.ConfigurarCamposForm()
1526: 
1527:         *-- Populacao interna de cada container
1528:         THIS.ConfigurarContainerTipoOp()
1529:         THIS.ConfigurarContainerOperacao()
1530:         THIS.ConfigurarContainerConta()
1531:         THIS.ConfigurarContainerResponsavel()
1532:         THIS.ConfigurarContainerEmpresa()
1533:         THIS.ConfigurarContainerPrevisao()
1534:         THIS.ConfigurarContainerOp()
1535:     ENDPROC
1536: 
1537:     *--------------------------------------------------------------------------
1538:     * ConfigurarPaginaDados - todos os containers de parametros (Fase 6)
1539:     *
1540:     * Form OPERACIONAL nao tem Page2 (Dados) como CRUD. Este metodo cobre
1541:     * TODOS os 7 containers de parametros em padrao idempotente (checa
1542:     * existencia antes de criar). Pode ser chamado de forma segura em
1543:     * qualquer ordem em relacao ao ConfigurarPaginaLista().
1544:     *
1545:     * Containers cobertos:
1546:     *   1. Cabecalho cinza (cnt_4c_Cabecalho)
1547:     *   2. Shape decorativo (shp_4c_Shape3)
1548:     *   3. Botoes principais (cmd_4c_Processar / cmd_4c_Cancelar)
1549:     *   4. Labels e campos de data avulsos no form
1550:     *   5. cnt_4c_TipoOp  - Tipo de O.P. (txt_4c_TpGOp)
1551:     *   6. cnt_4c_Operacao - Operacao + faixa i/f
1552:     *   7. cnt_4c_Conta    - Movimentacao: grupo/conta/dconta
1553:     *   8. cnt_4c_Responsavel - Vendedor: grupo/conta/dconta
1554:     *   9. cnt_4c_Empresa  - cd_empresa / ds_empresa / chk pedras
1555:     *  10. cnt_4c_Previsao - data previsao entrega + data geracao
1556:     *  11. cnt_4c_Op       - numero da OP manual (visivel em GlobAutos=2)
1557:     *--------------------------------------------------------------------------
1558:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1559:         LOCAL loc_lGlobAutos2
1560:         loc_lGlobAutos2 = .F.
1561:         IF USED("crSigCdPam") AND NOT EOF("crSigCdPam")
1562:             SELECT crSigCdPam
1563:             loc_lGlobAutos2 = (crSigCdPam.GlobAutos = 2 AND NOT THIS.this_lReserva)
1564:         ENDIF
1565: 
1566:         *-- 1. Cabecalho cinza (idempotente)
1567:         IF NOT PEMSTATUS(THIS, "cnt_4c_Cabecalho", 5)
1568:             THIS.ConfigurarCabecalho()
1569:         ENDIF
1570: 
1571:         *-- 2. Shape decorativo
1572:         IF NOT PEMSTATUS(THIS, "shp_4c_Shape3", 5)
1573:             THIS.ConfigurarShape()
1574:         ENDIF
1575: 
1576:         *-- 3. Botoes principais (Processar / Encerrar)
1577:         IF NOT PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1578:             THIS.ConfigurarBotoes()
1579:         ENDIF
1580: 
1581:         *-- 4. Campos avulsos (labels + datas de emissao/previsao)
1582:         IF NOT PEMSTATUS(THIS, "lbl_4c_PeriodoEmissao", 5)
1583:             THIS.ConfigurarCamposForm()
1584:         ENDIF
1585: 
1586:         *-- 5. Container Tipo de O.P.
1587:         IF NOT PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1588:             THIS.AddObject("cnt_4c_TipoOp", "Container")
1589:             WITH THIS.cnt_4c_TipoOp
1590:                 .Top         = 164
1591:                 .Left        = 139
1592:                 .Width       = 346
1593:                 .Height      = 25
1594:                 .BackStyle   = 0
1595:                 .BorderWidth = 0
1596:                 .Enabled     = THIS.this_lGerPorTp
1597:                 .Visible     = .T.
1598:             ENDWITH

*-- Linhas 1700 a 1785:
1700:     *   - "ENTRADA"     : usuario preenche filtros; Processar habilitado
1701:     *   - "PROCESSANDO" : filtros bloqueados enquanto BO executa; evita re-entrada
1702:     *
1703:     * Chamado em InicializarForm (estado inicial) e pode ser chamado por
1704:     * CmdProcessarClick antes/depois do ProcessarOrdens() do BO.
1705:     *--------------------------------------------------------------------------
1706:     *--------------------------------------------------------------------------
1707:     * BtnIncluirClick - Dispara o processamento (equivalente ao Processar)
1708:     * Form OPERACIONAL: nao ha CRUD - o evento principal eh gerar as OPs
1709:     *--------------------------------------------------------------------------
1710:     PROCEDURE BtnIncluirClick()
1711:         THIS.CmdProcessarClick()
1712:     ENDPROC
1713: 
1714:     *--------------------------------------------------------------------------
1715:     * BtnAlterarClick - Restaura o modo de entrada e da foco na 1a data editavel
1716:     * Permite ao usuario ajustar parametros apos processamento ou cancelamento
1717:     *--------------------------------------------------------------------------
1718:     PROCEDURE BtnAlterarClick()
1719:         THIS.AlternarPagina("ENTRADA")
1720:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5) AND THIS.txt_4c_Dataei.Enabled
1721:             THIS.txt_4c_Dataei.SetFocus
1722:         ELSE
1723:             IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5) AND THIS.cnt_4c_Previsao.Enabled
1724:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.SetFocus
1725:             ENDIF
1726:         ENDIF
1727:     ENDPROC
1728: 
1729:     *--------------------------------------------------------------------------
1730:     * BtnVisualizarClick - Recarrega os defaults iniciais (previsao/geracao/empresa)
1731:     * Util para descartar edicoes locais e voltar aos valores calculados pelo BO
1732:     *--------------------------------------------------------------------------
1733:     PROCEDURE BtnVisualizarClick()
1734:         THIS.AlternarPagina("ENTRADA")
1735:         THIS.PopularCamposIniciais()
1736:     ENDPROC
1737: 
1738:     *--------------------------------------------------------------------------
1739:     * BtnExcluirClick - Encerra o formulario sem processar (equivalente Cancelar)
1740:     *--------------------------------------------------------------------------
1741:     PROCEDURE BtnExcluirClick()
1742:         THIS.CmdCancelarClick()
1743:     ENDPROC
1744: 
1745:     PROCEDURE AlternarPagina(par_cModo)
1746:         LOCAL loc_cModo, loc_lEditar
1747:         loc_cModo = IIF(VARTYPE(par_cModo) = "C", UPPER(ALLTRIM(par_cModo)), "ENTRADA")
1748:         loc_lEditar = (loc_cModo = "ENTRADA")
1749: 
1750:         *-- Botao Processar segue o modo (bloqueia durante processamento)
1751:         IF PEMSTATUS(THIS, "cmd_4c_Processar", 5)
1752:             THIS.cmd_4c_Processar.Enabled = loc_lEditar
1753:         ENDIF
1754: 
1755:         *-- Containers de filtro alternam Enabled conforme modo
1756:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1757:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEditar AND THIS.this_lGerPorTp)
1758:         ENDIF
1759:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1760:             THIS.cnt_4c_Operacao.Enabled = loc_lEditar
1761:         ENDIF
1762:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1763:             THIS.cnt_4c_Conta.Enabled = loc_lEditar
1764:         ENDIF
1765:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1766:             THIS.cnt_4c_Responsavel.Enabled = loc_lEditar
1767:         ENDIF
1768:         IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
1769:             THIS.cnt_4c_Empresa.Enabled = (loc_lEditar AND THIS.this_lAlterEmp)
1770:         ENDIF
1771:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1772:             THIS.cnt_4c_Previsao.Enabled = (loc_lEditar AND NOT THIS.this_lReserva)
1773:         ENDIF
1774:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1775:             THIS.cnt_4c_Op.Enabled = loc_lEditar
1776:         ENDIF
1777: 
1778:         *-- Datas de emissao/previsao avulsas no form
1779:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1780:             THIS.txt_4c_Dataei.Enabled = loc_lEditar
1781:         ENDIF
1782:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1783:             THIS.txt_4c_Dataef.Enabled = loc_lEditar
1784:         ENDIF
1785:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)

*-- Linhas 1793 a 1989:
1793:     *--------------------------------------------------------------------------
1794:     * FormParaBO - copia todos os campos do formulario para as propriedades do BO
1795:     *--------------------------------------------------------------------------
1796:     PROCEDURE FormParaBO()
1797:         WITH THIS.this_oBusinessObject
1798:             .this_dDataei      = THIS.txt_4c_Dataei.Value
1799:             .this_dDataef      = THIS.txt_4c_Dataef.Value
1800:             .this_dDatapi      = THIS.txt_4c_Datapi.Value
1801:             .this_dDatapf      = THIS.txt_4c_Datapf.Value
1802:             .this_cOperacao    = ALLTRIM(THIS.cnt_4c_Operacao.txt_4c_Operacao.Value)
1803:             .this_nOperacaoi   = THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value
1804:             .this_nOperacaof   = THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value
1805:             .this_cGrupoConta  = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Grupo.Value)
1806:             .this_cConta       = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Conta.Value)
1807:             .this_cDconta      = ALLTRIM(THIS.cnt_4c_Conta.txt_4c_Dconta.Value)
1808:             .this_cGrupoResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value)
1809:             .this_cContaResp   = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value)
1810:             .this_cDcontaResp  = ALLTRIM(THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value)
1811:             .this_cCdEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value)
1812:             .this_cDsEmpresa   = ALLTRIM(THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value)
1813:             .this_nNaoEmpPedra = THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value
1814:             .this_cTpGOp       = ALLTRIM(THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value)
1815:             .this_dPrevisao    = THIS.cnt_4c_Previsao.txt_4c_Previsao.Value
1816:             .this_dGeracao     = THIS.cnt_4c_Previsao.txt_4c_Geracao.Value
1817:             .this_nNop         = THIS.cnt_4c_Op.txt_4c_Nop.Value
1818:         ENDWITH
1819:     ENDPROC
1820: 
1821:     *--------------------------------------------------------------------------
1822:     * BOParaForm - popula os campos do formulario a partir das propriedades do BO
1823:     *--------------------------------------------------------------------------
1824:     PROCEDURE BOParaForm()
1825:         LOCAL loc_oErro
1826:         TRY
1827:             WITH THIS.this_oBusinessObject
1828:                 THIS.txt_4c_Dataei.Value = .this_dDataei
1829:                 THIS.txt_4c_Dataef.Value = .this_dDataef
1830:                 THIS.txt_4c_Datapi.Value = .this_dDatapi
1831:                 THIS.txt_4c_Datapf.Value = .this_dDatapf
1832:                 THIS.cnt_4c_Operacao.txt_4c_Operacao.Value      = .this_cOperacao
1833:                 THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value     = .this_nOperacaoi
1834:                 THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value     = .this_nOperacaof
1835:                 THIS.cnt_4c_Conta.txt_4c_Grupo.Value            = .this_cGrupoConta
1836:                 THIS.cnt_4c_Conta.txt_4c_Conta.Value            = .this_cConta
1837:                 THIS.cnt_4c_Conta.txt_4c_Dconta.Value           = .this_cDconta
1838:                 THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = .this_cGrupoResp
1839:                 THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = .this_cContaResp
1840:                 THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = .this_cDcontaResp
1841:                 THIS.cnt_4c_Empresa.txt_4c_CdEmpresa.Value      = .this_cCdEmpresa
1842:                 THIS.cnt_4c_Empresa.txt_4c_DsEmpresa.Value      = .this_cDsEmpresa
1843:                 THIS.cnt_4c_Empresa.chk_4c_NaoEmpPedra.Value    = .this_nNaoEmpPedra
1844:                 THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value           = .this_cTpGOp
1845:                 THIS.cnt_4c_Previsao.txt_4c_Previsao.Value      = .this_dPrevisao
1846:                 THIS.cnt_4c_Previsao.txt_4c_Geracao.Value       = .this_dGeracao
1847:                 THIS.cnt_4c_Op.txt_4c_Nop.Value                 = .this_nNop
1848:             ENDWITH
1849:         CATCH TO loc_oErro
1850:             MsgErro("Erro ao carregar campos: " + loc_oErro.Message, "Erro")
1851:         ENDTRY
1852:     ENDPROC
1853: 
1854:     *--------------------------------------------------------------------------
1855:     * HabilitarCampos - habilita/desabilita todos os campos editaveis
1856:     * par_lEditar = .T. para habilitar; .F. para somente leitura
1857:     *--------------------------------------------------------------------------
1858:     PROCEDURE HabilitarCampos(par_lEditar)
1859:         LOCAL loc_lEdit
1860:         loc_lEdit = IIF(VARTYPE(par_lEditar) = "L", par_lEditar, .T.)
1861: 
1862:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1863:             THIS.txt_4c_Dataei.Enabled = loc_lEdit
1864:         ENDIF
1865:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1866:             THIS.txt_4c_Dataef.Enabled = loc_lEdit
1867:         ENDIF
1868:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1869:             THIS.txt_4c_Datapi.Enabled = loc_lEdit
1870:         ENDIF
1871:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1872:             THIS.txt_4c_Datapf.Enabled = loc_lEdit
1873:         ENDIF
1874:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1875:             THIS.cnt_4c_TipoOp.Enabled = (loc_lEdit AND THIS.this_lGerPorTp)
1876:         ENDIF
1877:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1878:             THIS.cnt_4c_Operacao.Enabled = loc_lEdit
1879:         ENDIF
1880:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1881:             THIS.cnt_4c_Conta.Enabled = loc_lEdit
1882:         ENDIF
1883:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1884:             THIS.cnt_4c_Responsavel.Enabled = loc_lEdit
1885:         ENDIF
1886:         IF PEMSTATUS(THIS, "cnt_4c_Empresa", 5)
1887:             THIS.cnt_4c_Empresa.Enabled = (loc_lEdit AND THIS.this_lAlterEmp)
1888:         ENDIF
1889:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1890:             THIS.cnt_4c_Previsao.Enabled = (loc_lEdit AND NOT THIS.this_lReserva)
1891:         ENDIF
1892:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1893:             THIS.cnt_4c_Op.Enabled = loc_lEdit
1894:         ENDIF
1895:     ENDPROC
1896: 
1897:     *--------------------------------------------------------------------------
1898:     * LimparCampos - limpa todos os campos de filtro do formulario
1899:     *--------------------------------------------------------------------------
1900:     PROCEDURE LimparCampos()
1901:         IF PEMSTATUS(THIS, "txt_4c_Dataei", 5)
1902:             THIS.txt_4c_Dataei.Value = {}
1903:         ENDIF
1904:         IF PEMSTATUS(THIS, "txt_4c_Dataef", 5)
1905:             THIS.txt_4c_Dataef.Value = {}
1906:         ENDIF
1907:         IF PEMSTATUS(THIS, "txt_4c_Datapi", 5)
1908:             THIS.txt_4c_Datapi.Value = {}
1909:         ENDIF
1910:         IF PEMSTATUS(THIS, "txt_4c_Datapf", 5)
1911:             THIS.txt_4c_Datapf.Value = {}
1912:         ENDIF
1913:         IF PEMSTATUS(THIS, "cnt_4c_TipoOp", 5)
1914:             THIS.cnt_4c_TipoOp.txt_4c_TpGOp.Value = ""
1915:         ENDIF
1916:         IF PEMSTATUS(THIS, "cnt_4c_Operacao", 5)
1917:             THIS.cnt_4c_Operacao.txt_4c_Operacao.Value  = ""
1918:             THIS.cnt_4c_Operacao.txt_4c_Operacaoi.Value = 0
1919:             THIS.cnt_4c_Operacao.txt_4c_Operacaof.Value = 0
1920:         ENDIF
1921:         IF PEMSTATUS(THIS, "cnt_4c_Conta", 5)
1922:             THIS.cnt_4c_Conta.txt_4c_Grupo.Value  = ""
1923:             THIS.cnt_4c_Conta.txt_4c_Conta.Value  = ""
1924:             THIS.cnt_4c_Conta.txt_4c_Dconta.Value = ""
1925:         ENDIF
1926:         IF PEMSTATUS(THIS, "cnt_4c_Responsavel", 5)
1927:             THIS.cnt_4c_Responsavel.txt_4c_GrupoResp.Value  = ""
1928:             THIS.cnt_4c_Responsavel.txt_4c_ContaResp.Value  = ""
1929:             THIS.cnt_4c_Responsavel.txt_4c_DcontaResp.Value = ""
1930:         ENDIF
1931:         IF PEMSTATUS(THIS, "cnt_4c_Previsao", 5)
1932:             THIS.cnt_4c_Previsao.txt_4c_Previsao.Value = {}
1933:             THIS.cnt_4c_Previsao.txt_4c_Geracao.Value  = {}
1934:         ENDIF
1935:         IF PEMSTATUS(THIS, "cnt_4c_Op", 5)
1936:             THIS.cnt_4c_Op.txt_4c_Nop.Value = 0
1937:         ENDIF
1938:     ENDPROC
1939: 
1940:     *--------------------------------------------------------------------------
1941:     * CarregarLista - recarrega dados iniciais (form OPERACIONAL sem grid de lista)
1942:     * Existe para compatibilidade com o ciclo de vida do FormBase
1943:     *--------------------------------------------------------------------------
1944:     PROCEDURE CarregarLista()
1945:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1946:             THIS.PopularCamposIniciais()
1947:         ENDIF
1948:     ENDPROC
1949: 
1950:     *--------------------------------------------------------------------------
1951:     * AjustarBotoesPorModo - ajusta estado dos botoes conforme modo do form
1952:     *--------------------------------------------------------------------------
1953:     PROCEDURE AjustarBotoesPorModo()
1954:         THIS.AlternarPagina("ENTRADA")
1955:     ENDPROC
1956: 
1957:     *--------------------------------------------------------------------------
1958:     * BtnBuscarClick - limpa filtros e recarrega valores iniciais padrao
1959:     *--------------------------------------------------------------------------
1960:     PROCEDURE BtnBuscarClick()
1961:         THIS.LimparCampos()
1962:         THIS.PopularCamposIniciais()
1963:         THIS.AlternarPagina("ENTRADA")
1964:     ENDPROC
1965: 
1966:     *--------------------------------------------------------------------------
1967:     * BtnEncerrarClick - fecha o formulario
1968:     *--------------------------------------------------------------------------
1969:     PROCEDURE BtnEncerrarClick()
1970:         THIS.CmdCancelarClick()
1971:     ENDPROC
1972: 
1973:     *--------------------------------------------------------------------------
1974:     * BtnSalvarClick - executa o processamento (equivalente ao Processar)
1975:     *--------------------------------------------------------------------------
1976:     PROCEDURE BtnSalvarClick()
1977:         THIS.CmdProcessarClick()
1978:     ENDPROC
1979: 
1980:     *--------------------------------------------------------------------------
1981:     * BtnCancelarClick - cancela o estado atual e restaura o modo de entrada
1982:     *--------------------------------------------------------------------------
1983:     PROCEDURE BtnCancelarClick()
1984:         THIS.AlternarPagina("ENTRADA")
1985:         THIS.LimparCampos()
1986:         THIS.PopularCamposIniciais()
1987:     ENDPROC
1988: 
1989: ENDDEFINE


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

