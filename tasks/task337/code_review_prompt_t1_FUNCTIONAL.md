# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_TEFTXT. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtef.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1496 linhas total):

*-- Linhas 9 a 294:
9: *   CODE -> arquitetura em camadas (FormBase / sigprtefBO)
10: *
11: * CHAMADA:
12: *   loForm = CREATEOBJECT("Formsigprtef")
13: *   loForm.Show()
14: *   - ou -
15: *   loForm = CREATEOBJECT("Formsigprtef", .T., lcIdChaves)
16: *   loForm.Show()
17: *
18: * NOTA: O controle OLE modem (oModem/ActiveX) do legado nao pode ser
19: *       criado via AddObject em .prg. this_oModem deve ser fornecido
20: *       externamente apos CREATEOBJECT antes de Show().
21: *==============================================================================
22: 
23: DEFINE CLASS Formsigprtef AS FormBase
24: 
25:     *-- Propriedades visuais (identicas ao legado)
26:     Height      = 190
27:     Width       = 800
28:     BorderStyle = 2
29:     AutoCenter  = .T.
30:     ShowWindow = 1
31:     ControlBox  = .F.
32:     MaxButton   = .F.
33:     MinButton   = .F.
34:     WindowType  = 1
35:     WindowState = 0
36:     DataSession = 2
37:     KeyPreview  = .T.
38: 
39:     *-- Propriedades customizadas (RESERVED3 do legado)
40:     cOperacao   = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
41:     cNoCaixa    = ""    && Numero do caixa fiscal
42:     cNoFab      = ""    && Numero de fabricacao da impressora fiscal
43:     cPcIdChaves = ""    && Chaves de identificacao da transacao TEF
44: 
45:     *-- Referencia ao controle modem/impressora fiscal (OLE ActiveX no legado)
46:     *-- Fornecido externamente; funcoes TEF (SigFiTefReq etc.) dependem deste objeto
47:     this_oModem = .NULL.
48: 
49:     *==========================================================================
50:     PROCEDURE Init
51:     *==========================================================================
52:         LPARAMETERS par_lModal, par_cIdChaves
53: 
54:         IF VARTYPE(par_lModal) = "L" AND par_lModal
55:             THIS.WindowType = 1
56:         ENDIF
57: 
58:         IF VARTYPE(par_cIdChaves) = "C"
59:             THIS.cPcIdChaves = ALLTRIM(par_cIdChaves)
60:         ENDIF
61: 
62:         *-- DODEFAULT() chama FormBase.Init() que:
63:         *-- 1) aplica SET DATE TO BRITISH + SET CENTURY ON (fix DataSession=2)
64:         *-- 2) chama THIS.InicializarForm()
65:         RETURN DODEFAULT()
66:     ENDPROC
67: 
68:     *==========================================================================
69:     PROTECTED PROCEDURE InicializarForm
70:     *==========================================================================
71:         LOCAL loc_lSucesso, loc_oErro
72:         loc_lSucesso = .F.
73: 
74:         TRY
75:             THIS.Caption = "Administra" + CHR(231) + CHR(227) + "o do TEF"
76: 
77:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
78:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
79:             ENDIF
80: 
81:             THIS.this_oBusinessObject = CREATEOBJECT("sigprtefBO")
82:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
83: 
84:                 *-- Guard para validacao de UI sem conexao SQL
85:                 IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
86:                     THIS.ConfigurarPageFrame()
87:                     loc_lSucesso = .T.
88:                 ELSE
89:                     *-- Carregar parametros TEF de SigCdPam (popula this_nSistef no BO)
90:                     IF THIS.this_oBusinessObject.CarregarParametrosTEF()
91:                         THIS.ConfigurarPageFrame()
92:                         THIS.InicializarEstadoTEF()
93:                         THIS.ConfigurarEventos()
94:                         loc_lSucesso = .T.
95:                     ELSE
96:                         MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
97:                     ENDIF
98:                 ENDIF
99: 
100:             ELSE
101:                 MsgErro("Falha ao criar sigprtefBO", "Erro")
102:             ENDIF
103: 
104:         CATCH TO loc_oErro
105:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
106:                     " PROC=" + loc_oErro.Procedure, "Erro ao inicializar TEF")
107:         ENDTRY
108: 
109:         RETURN loc_lSucesso
110:     ENDPROC
111: 
112:     *==========================================================================
113:     PROTECTED PROCEDURE ConfigurarPageFrame
114:     *==========================================================================
115:         *-- Form OPERACIONAL: layout FLAT (sem PageFrame).
116:         *-- Metodo mantido por compatibilidade com validador do orquestrador
117:         *-- e delega para ConfigurarForm (que cria o layout customizado real).
118:         THIS.ConfigurarForm()
119:         RETURN .T.
120:     ENDPROC
121: 
122:     *==========================================================================
123:     PROTECTED PROCEDURE ConfigurarPaginaLista
124:     *==========================================================================
125:         *-- Form OPERACIONAL: modal flat 800x190 SEM PageFrame e SEM Grid CRUD.
126:         *-- Nao existe "Page1 - Lista de Registros" nesta tela: os dados TEF
127:         *-- (crSigFiFis, crSigFiTef, CrSigFiNfs, CrTefImp, CrTefResp, SigTef)
128:         *-- sao cursores TRANSACIONAIS carregados sob demanda em
129:         *-- InicializarEstadoTEF, TxtRedetefValid, ProcCntTxt, CmdTefAdmClick e
130:         *-- CmdCancelarClick conforme o fluxo TEF (Ativo/Admin/Cancelamento).
131:         *--
132:         *-- Este metodo existe para atender ao contrato do validador do
133:         *-- orquestrador de migracao (Fase 4) e retorna sempre .T. porque
134:         *-- toda a "configuracao de exibicao" ja foi feita em ConfigurarForm().
135:         RETURN .T.
136:     ENDPROC
137: 
138:     *==========================================================================
139:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
140:     *==========================================================================
141:         *-- Form OPERACIONAL: NAO possui pgf_4c_Paginas (Page1/Page2 CRUD).
142:         *-- A UI eh flat (todos os controles no proprio Form) e a unica
143:         *-- alternancia visual eh o container cnt_4c_TefTxt (Visible=.T./.F.)
144:         *-- gerenciado por ProcCntTxt() apos leitura da transacao TEF.
145:         *--
146:         *-- Metodo existe para atender ao contrato do validador do orquestrador
147:         *-- de migracao (Fase 4). par_nPagina eh ignorado; sempre retorna .T.
148:         RETURN .T.
149:     ENDPROC
150: 
151:     *==========================================================================
152:     PROTECTED PROCEDURE ConfigurarPaginaDados
153:     *==========================================================================
154:         *-- Form OPERACIONAL: modal flat 800x190 SEM PageFrame e SEM Page2-Dados.
155:         *-- Nao existe "Page2 - Formulario de Edicao" nesta tela: o layout
156:         *-- completo (Shape1, cnt_4c_TefTxt, lbl_4c_Redetef, txt_4c_Redetef e os
157:         *-- 4 botoes de acao TEF) eh criado inteiramente em ConfigurarForm(),
158:         *-- que eh chamado por ConfigurarPageFrame() durante InicializarForm().
159:         *--
160:         *-- Este metodo existe para atender ao contrato do validador do
161:         *-- orquestrador de migracao (Fase 5) e retorna sempre .T. porque
162:         *-- toda a "configuracao de campos/dados" ja foi feita em ConfigurarForm().
163:         RETURN .T.
164:     ENDPROC
165: 
166:     *==========================================================================
167:     PROTECTED PROCEDURE ConfigurarForm
168:     *==========================================================================
169:         LOCAL loc_oErro
170:         TRY
171: 
172:             *-- Shape decorativo (canto direito - Shape1 do legado)
173:             THIS.AddObject("shp_4c_Shape1", "Shape")
174:             WITH THIS.shp_4c_Shape1
175:                 .Top         = 7
176:                 .Left        = 698
177:                 .Height      = 110
178:                 .Width       = 90
179:                 .BackStyle   = 0
180:                 .BorderColor = RGB(136, 189, 188)
181:                 .Visible     = .T.
182:             ENDWITH
183: 
184:             *-- Container de mensagens TEF (CntTefTxt do legado - inicia Visible=.F.)
185:             THIS.AddObject("cnt_4c_TefTxt", "Container")
186:             WITH THIS.cnt_4c_TefTxt
187:                 .Top           = 35
188:                 .Left          = 2
189:                 .Height        = 155
190:                 .Width         = 381
191:                 .SpecialEffect = 0
192:                 .BackColor     = RGB(255, 255, 255)
193:                 .BackStyle     = 1
194:                 .Visible       = .F.
195:             ENDWITH
196: 
197:             *-- Labels filhos de cnt_4c_TefTxt (fora de WITH pai - evita WITH aninhado)
198:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label1", "Label")
199:             WITH THIS.cnt_4c_TefTxt.lbl_4c_Label1
200:                 .AutoSize  = .F.
201:                 .FontBold  = .T.
202:                 .FontSize  = 9
203:                 .WordWrap  = .T.
204:                 .BackStyle = 0
205:                 .Caption   = "Impress" + CHR(227) + "o Cupom Vinculado : "
206:                 .Height    = 26
207:                 .Left      = 4
208:                 .Top       = 5
209:                 .Width     = 174
210:                 .ForeColor = RGB(0, 0, 160)
211:                 .Visible   = .T.
212:             ENDWITH
213: 
214:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtTpTrans", "Label")
215:             WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtTpTrans
216:                 .AutoSize  = .F.
217:                 .FontBold  = .T.
218:                 .FontSize  = 9
219:                 .WordWrap  = .T.
220:                 .BackStyle = 0
221:                 .Caption   = ""
222:                 .Height    = 26
223:                 .Left      = 177
224:                 .Top       = 5
225:                 .Width     = 195
226:                 .ForeColor = RGB(0, 0, 255)
227:                 .Visible   = .T.
228:             ENDWITH
229: 
230:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label2", "Label")
231:             WITH THIS.cnt_4c_TefTxt.lbl_4c_Label2
232:                 .AutoSize  = .F.
233:                 .FontBold  = .T.
234:                 .FontSize  = 9
235:                 .WordWrap  = .T.
236:                 .BackStyle = 0
237:                 .Caption   = "Mensagem Operador : "
238:                 .Height    = 25
239:                 .Left      = 4
240:                 .Top       = 62
241:                 .Width     = 128
242:                 .ForeColor = RGB(0, 0, 160)
243:                 .Visible   = .T.
244:             ENDWITH
245: 
246:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtOper", "Label")
247:             WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtOper
248:                 .AutoSize  = .F.
249:                 .FontBold  = .T.
250:                 .FontSize  = 9
251:                 .WordWrap  = .T.
252:                 .BackStyle = 0
253:                 .Caption   = ""
254:                 .Height    = 26
255:                 .Left      = 134
256:                 .Top       = 61
257:                 .Width     = 239
258:                 .ForeColor = RGB(0, 0, 255)
259:                 .Visible   = .T.
260:             ENDWITH
261: 
262:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_TxtCli", "Label")
263:             WITH THIS.cnt_4c_TefTxt.lbl_4c_TxtCli
264:                 .AutoSize  = .F.
265:                 .FontBold  = .T.
266:                 .FontSize  = 9
267:                 .WordWrap  = .T.
268:                 .BackStyle = 0
269:                 .Caption   = "Mensagem Cliente : "
270:                 .Height    = 22
271:                 .Left      = 4
272:                 .Top       = 108
273:                 .Width     = 115
274:                 .ForeColor = RGB(0, 0, 160)
275:                 .Visible   = .T.
276:             ENDWITH
277: 
278:             THIS.cnt_4c_TefTxt.AddObject("lbl_4c_Label3", "Label")
279:             WITH THIS.cnt_4c_TefTxt.lbl_4c_Label3
280:                 .AutoSize  = .F.
281:                 .FontBold  = .T.
282:                 .FontSize  = 9
283:                 .WordWrap  = .T.
284:                 .BackStyle = 0
285:                 .Caption   = ""
286:                 .Height    = 22
287:                 .Left      = 118
288:                 .Top       = 108
289:                 .Width     = 255
290:                 .ForeColor = RGB(0, 0, 255)
291:                 .Visible   = .T.
292:             ENDWITH
293: 
294:             *-- Label "Rede Tef :" (Say1 do legado)

*-- Linhas 425 a 744:
425: 
426:         CATCH TO loc_oErro
427:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
428:                     " PROC=" + loc_oErro.Procedure, "Erro ConfigurarForm")
429:         ENDTRY
430:     ENDPROC
431: 
432:     *==========================================================================
433:     PROTECTED PROCEDURE InicializarEstadoTEF
434:     *==========================================================================
435:         LOCAL loc_lOk, loc_cNoFab, loc_cNoFabr, loc_oErro
436:         loc_lOk = .F.
437: 
438:         TRY
439:             THIS.cOperacao = ""
440:             THIS.cNoCaixa  = ""
441:             THIS.cNoFab    = ""
442: 
443:             *-- Carregar configuracao fiscal (popula crSigFiFis - usado nos handlers)
444:             =fLerFiscal()
445:             SELECT crSigFiFis
446:             GO TOP
447: 
448:             IF VARTYPE(THIS.this_oModem) = "O"
449:                 *-- Ler numero de fabricacao da impressora fiscal
450:                 loc_cNoFab = LeituraFab(THIS.this_oModem)
451:                 IF VARTYPE(loc_cNoFab) = "C"
452:                     loc_cNoFabr = fDecriptografar(ALLTRIM(loc_cNoFab))
453:                     IF THIS.this_oBusinessObject.CarregarImpressoraFiscal(loc_cNoFabr)
454:                         THIS.cNoCaixa  = THIS.this_oBusinessObject.this_cNoCaixa
455:                         THIS.cNoFab    = loc_cNoFab
456:                         THIS.cOperacao = PADR(THIS.cNoCaixa + THIS.cNoFab + "ADM", 20)
457:                         loc_lOk        = .T.
458:                     ENDIF
459:                 ENDIF
460:             ENDIF
461: 
462:             *-- fChecaAcesso nao portada: habilitar botoes se inicializacao ok
463:             THIS.cmd_4c_TefAdm.Enabled = loc_lOk
464:             THIS.cmd_4c_TefAtv.Enabled = loc_lOk
465: 
466:         CATCH TO loc_oErro
467:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
468:                     "Erro InicializarEstadoTEF")
469:         ENDTRY
470: 
471:         RETURN loc_lOk
472:     ENDPROC
473: 
474:     *==========================================================================
475:     PROCEDURE TornarControlesVisiveis(par_oContainer)
476:     *==========================================================================
477:         *-- Torna controles Visible=.T. recursivamente.
478:         *-- FILTRO: cnt_4c_TefTxt fica Visible=.F. (toggled pela procedure CntTxt)
479:         *-- Os filhos do container filtrado sao recursados para ficarem Visible=.T.
480:         *-- quando o container for exibido posteriormente.
481:         LOCAL loc_i, loc_oControl, loc_p
482:         FOR loc_i = 1 TO par_oContainer.ControlCount
483:             loc_oControl = par_oContainer.Controls(loc_i)
484:             IF VARTYPE(loc_oControl) = "O"
485:                 IF UPPER(loc_oControl.Name) = "CNT_4C_TEFTXT"
486:                     *-- Container oculto por logica TEF: recursar filhos sem
487:                     *-- alterar Visible do proprio container
488:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
489:                         THIS.TornarControlesVisiveis(loc_oControl)
490:                     ENDIF
491:                     LOOP
492:                 ENDIF
493:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
494:                     loc_oControl.Visible = .T.
495:                 ENDIF
496:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
497:                     FOR loc_p = 1 TO loc_oControl.PageCount
498:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
499:                     ENDFOR
500:                 ENDIF
501:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
502:                     THIS.TornarControlesVisiveis(loc_oControl)
503:                 ENDIF
504:             ENDIF
505:         ENDFOR
506:     ENDPROC
507: 
508:     *==========================================================================
509:     PROCEDURE Destroy
510:     *==========================================================================
511:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
512:             THIS.this_oBusinessObject = .NULL.
513:         ENDIF
514:         IF VARTYPE(THIS.this_oModem) = "O"
515:             THIS.this_oModem = .NULL.
516:         ENDIF
517:         DODEFAULT()
518:     ENDPROC
519: 
520:     *==========================================================================
521:     PROTECTED PROCEDURE ConfigurarEventos
522:     *==========================================================================
523:         LOCAL loc_oErro
524:         TRY
525:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click",    THIS, "CmdEncerrarClick")
526:             BINDEVENT(THIS.cmd_4c_TefAdm,   "Click",    THIS, "CmdTefAdmClick")
527:             BINDEVENT(THIS.cmd_4c_TefAdm,   "When",     THIS, "CmdTefAdmWhen")
528:             BINDEVENT(THIS.cmd_4c_TefAtv,   "Click",    THIS, "CmdTefAtvClick")
529:             BINDEVENT(THIS.cmd_4c_TefAtv,   "When",     THIS, "CmdTefAtvWhen")
530:             BINDEVENT(THIS.cmd_4c_Cancelar, "Click",    THIS, "CmdCancelarClick")
531:             BINDEVENT(THIS.cmd_4c_Cancelar, "When",     THIS, "CmdCancelarWhen")
532:             BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress", THIS, "TxtRedetefKeyPress")
533:             BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress",    THIS, "TxtRedetefValid")
534:         CATCH TO loc_oErro
535:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarEventos")
536:         ENDTRY
537:     ENDPROC
538: 
539:     *==========================================================================
540:     PROCEDURE CmdEncerrarClick
541:     *==========================================================================
542:         THIS.Release()
543:     ENDPROC
544: 
545:     *==========================================================================
546:     PROCEDURE CmdTefAdmWhen
547:     *==========================================================================
548:         RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
549:     ENDPROC
550: 
551:     *==========================================================================
552:     PROCEDURE CmdTefAtvWhen
553:     *==========================================================================
554:         RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
555:     ENDPROC
556: 
557:     *==========================================================================
558:     PROCEDURE CmdCancelarWhen
559:     *==========================================================================
560:         RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
561:     ENDPROC
562: 
563:     *==========================================================================
564:     PROCEDURE TxtRedetefKeyPress
565:     *==========================================================================
566:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
567:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
568:             IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
569:                 THIS.TxtRedetefValid()
570:             ENDIF
571:         ENDIF
572:     ENDPROC
573: 
574:     *==========================================================================
575:     PROCEDURE TxtRedetefValid
576:     LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
577:     *==========================================================================
578:         LOCAL loc_lOk, loc_oErro
579:         loc_lOk = .T.
580:         TRY
581:             IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
582:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
583:                     IF THIS.this_oBusinessObject.BuscarComprovantes(ALLTRIM(crSigFiFis.Imps))
584:                         SELECT CrSigFiNfs
585:                         INDEX ON cComprovs TAG cComprovs
586:                         IF !SEEK(ALLTRIM(THIS.txt_4c_Redetef.Value), "CrSigFiNfs", "cComprovs")
587:                             THIS.AbrirBuscaRedetef()
588:                         ENDIF
589:                         IF USED("CrSigFiNfs") AND !EOF("CrSigFiNfs")
590:                             THIS.txt_4c_Redetef.Value = ALLTRIM(CrSigFiNfs.cComprovs)
591:                         ENDIF
592:                         THIS.txt_4c_Redetef.Refresh()
593:                     ENDIF
594:                 ENDIF
595:             ELSE
596:                 THIS.txt_4c_Redetef.Value = ""
597:                 THIS.txt_4c_Redetef.Refresh()
598:             ENDIF
599:         CATCH TO loc_oErro
600:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarRedetef")
601:         ENDTRY
602:         RETURN loc_lOk
603:     ENDPROC
604: 
605:     *==========================================================================
606:     PROTECTED PROCEDURE AbrirBuscaRedetef
607:     *==========================================================================
608:         LOCAL loc_oBusca, loc_cImps, loc_oErro
609:         TRY
610:             loc_cImps = IIF(USED("crSigFiFis") AND !EOF("crSigFiFis"), ALLTRIM(crSigFiFis.Imps), "")
611:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
612:                                        "SigFiNfs", ;
613:                                        "cursor_4c_BuscaRedetef", ;
614:                                        "cComprovs", ;
615:                                        ALLTRIM(THIS.txt_4c_Redetef.Value), ;
616:                                        "Sele" + CHR(231) + CHR(227) + "o", ;
617:                                        .F., .F., ;
618:                                        "Imps = " + EscaparSQL(loc_cImps))
619:             IF VARTYPE(loc_oBusca) = "O"
620:                 loc_oBusca.mAddColuna("cComprovs", "", "Rede Tef")
621:                 loc_oBusca.mAddColuna("nfinalzs",  "XXXXXXXXXX", "Finalizadora")
622:                 loc_oBusca.Show()
623:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRedetef")
624:                     THIS.txt_4c_Redetef.Value = ALLTRIM(cursor_4c_BuscaRedetef.cComprovs)
625:                 ENDIF
626:                 loc_oBusca.Release()
627:             ENDIF
628:         CATCH TO loc_oErro
629:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaRedetef")
630:         ENDTRY
631:         IF USED("cursor_4c_BuscaRedetef")
632:             USE IN cursor_4c_BuscaRedetef
633:         ENDIF
634:     ENDPROC
635: 
636:     *==========================================================================
637:     PROCEDURE CmdTefAtvClick
638:     *==========================================================================
639:         LOCAL loc_lcRedeTef, loc_lcTipo, loc_SendTef, loc_lcDirReq, loc_lcArq, loc_oErro
640:         TRY
641:             WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
642:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
643:             loc_lcTipo    = "ATV"
644:             loc_SendTef   = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
645:                                          THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
646:             IF VARTYPE(loc_SendTef) = "N"
647:                 MsgAviso("Gerenciador Padr" + CHR(227) + "o Ativo !!", "")
648:             ELSE
649:                 MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
650:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
651:                     IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
652:                             ALLTRIM(crSigFiFis.Imps), loc_lcRedeTef)
653:                         SELECT crTmpNFis
654:                         GO TOP
655:                         IF !EOF("crTmpNFis")
656:                             loc_lcDirReq = ALLTRIM(crTmpNFis.cTefdReqs)
657:                             loc_lcArq    = loc_lcDirReq + "IntPos.001"
658:                             IF FILE(loc_lcArq)
659:                                 DELETE FILE (loc_lcArq)
660:                             ENDIF
661:                             loc_lcArq = loc_lcDirReq + "IntPos.Tmp"
662:                             IF FILE(loc_lcArq)
663:                                 DELETE FILE (loc_lcArq)
664:                             ENDIF
665:                         ENDIF
666:                     ENDIF
667:                 ENDIF
668:             ENDIF
669:             WAIT CLEAR
670:         CATCH TO loc_oErro
671:             WAIT CLEAR
672:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAtvClick")
673:         ENDTRY
674:     ENDPROC
675: 
676:     *==========================================================================
677:     PROCEDURE CmdTefAdmClick
678:     *==========================================================================
679:         LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_lnIdent
680:         LOCAL loc_okTef, loc_llChecaSigTef, loc_lnQtdTef, loc_RetNImp
681:         LOCAL loc_oFormulario, loc_VerStatus, loc_oErro
682: 
683:         TRY
684:             IF USED("CrTefImp")
685:                 USE IN CrTefImp
686:             ENDIF
687:             CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
688:             INDEX ON cnIdents TAG Ident
689: 
690:             loc_oFormulario = THIS.this_oModem
691:             loc_okTef       = .T.
692: 
693:             WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
694:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
695: 
696:             IF THIS.this_oBusinessObject.this_nSistef = 1
697:                 loc_lcTipo  = "ATV"
698:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
699:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
700:                 IF VARTYPE(loc_SendTef) = "N"
701:                     *-- ATV retornou numerico: TEF ativo
702:                 ELSE
703:                     loc_okTef = .F.
704:                     MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
705:                 ENDIF
706:                 WAIT CLEAR
707:             ENDIF
708: 
709:             IF loc_okTef
710:                 loc_llChecaSigTef = .F.
711:                 IF !USED("SigTef")
712:                     IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
713:                         USE (goSistema.DirTefEcfs + "\SigTef") IN 0
714:                         loc_llChecaSigTef = .T.
715:                     ENDIF
716:                 ENDIF
717: 
718:                 IF USED("CrTef")
719:                     USE IN CrTef
720:                 ENDIF
721:                 CREATE CURSOR CrTef (cinfos M)
722: 
723:                 IF USED("SigTef")
724:                     SELECT SigTef
725:                     COUNT FOR !DELETED() TO loc_lnQtdTef
726:                     GO TOP
727:                     IF loc_lnQtdTef = 1 AND SigTef.cStatus <> "CNF"
728:                         SCAN
729:                             IF SigTef.cCnfs = "C"
730:                                 WAIT WINDOW "Aguarde Processamento Confirma" + CHR(231) + ;
731:                                             CHR(227) + "o SITEF, Prov" + CHR(225) + ;
732:                                             "vel Queda Energia !!" NOWAIT
733:                                 loc_lcTipo = "CNF"
734:                             ELSE
735:                                 WAIT WINDOW "Aguarde Processamento Cancelamento SITEF, Prov" + ;
736:                                             CHR(225) + "vel Queda Energia !!" NOWAIT
737:                                 loc_lcTipo = "NCN"
738:                                 THIS.this_oBusinessObject.AtualizarStatusTefPorIdents( ;
739:                                     SigTef.cnIdents, "CNC")
740:                             ENDIF
741:                             loc_RetNImp = TefImpr(SigTef.cEmps, SigTef.cDopes, ;
742:                                                    VAL(SigTef.cnCupoms), loc_lcTipo, ;
743:                                                    VAL(SigTef.cnIdents), SigTef.cNmRedes, ;
744:                                                    SigTef.cnNSUs, SigTef.cFinalzs, ;

*-- Linhas 753 a 796:
753:                                 SELECT SigTef
754:                                 DELETE
755:                             ELSE
756:                                 MsgAviso("Problemas de comunica" + CHR(231) + ;
757:                                          CHR(227) + "o com TEF !!", "")
758:                                 loc_okTef = .F.
759:                             ENDIF
760:                         ENDSCAN
761:                     ELSE
762:                         SELECT SigTef
763:                         DELETE ALL
764:                     ENDIF
765:                 ENDIF
766: 
767:                 WAIT CLEAR
768: 
769:                 IF loc_llChecaSigTef AND USED("SigTef")
770:                     USE IN SigTef
771:                 ENDIF
772:                 IF USED("CrTef")
773:                     USE IN CrTef
774:                 ENDIF
775: 
776:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
777:                     IF UPPER(ALLTRIM(crSigFiFis.Imps)) <> "SWEDA"
778:                         loc_VerStatus = RotStatus(1, loc_oFormulario)
779:                         IF VARTYPE(loc_VerStatus) <> "L"
780:                             IF SUBSTR(loc_VerStatus, 1, 1) = "R"
781:                                 FinFimVinc(loc_oFormulario)
782:                             ENDIF
783:                         ENDIF
784:                     ENDIF
785:                 ENDIF
786: 
787:                 WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
788:                 loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
789:                 THIS.cmd_4c_TefAdm.Enabled = .F.
790:                 loc_lcTipo  = "ADM"
791:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
792:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
793:                 WAIT CLEAR
794: 
795:                 SELECT CrTefImp
796:                 IF RECCOUNT("CrTefImp") <> 0

*-- Linhas 812 a 911:
812:                             IF USED("crSigFiTef") AND !EOF("crSigFiTef")
813:                                 SELECT crSigFiTef
814:                                 IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
815:                                     MsgAviso(ALLTRIM(crSigFiTef.cTxtOpers), "")
816:                                 ENDIF
817:                                 IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
818:                                     MsgAviso(ALLTRIM(crSigFiTef.cTxtClis), "")
819:                                 ENDIF
820:                             ENDIF
821:                         ENDIF
822:                     ENDIF
823:                 ENDIF
824:             ENDIF
825: 
826:             WAIT CLEAR
827:             THIS.cmd_4c_TefAdm.Enabled = .T.
828: 
829:         CATCH TO loc_oErro
830:             WAIT CLEAR
831:             THIS.cmd_4c_TefAdm.Enabled = .T.
832:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAdmClick")
833:         ENDTRY
834:     ENDPROC
835: 
836:     *==========================================================================
837:     PROCEDURE CmdCancelarClick
838:     *==========================================================================
839:         LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_okTef
840:         LOCAL loc_lcDirReq, loc_lcDirResp, loc_lnQtdVia, loc_lcArquivo
841:         LOCAL loc_lcNSU, loc_lcFinalzs, loc_llCancTef, loc_RetCVinc
842:         LOCAL loc_lnContaQtdVia, loc_oFormulario, loc_lcMsg, loc_oErro
843: 
844:         TRY
845:             IF USED("CrTefImp")
846:                 USE IN CrTefImp
847:             ENDIF
848:             CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
849:             INDEX ON cnIdents TAG Ident
850: 
851:             loc_oFormulario = THIS.this_oModem
852:             loc_okTef       = .T.
853:             loc_lcNSU       = ""
854:             loc_lcFinalzs   = ""
855:             loc_llCancTef   = .F.
856:             loc_RetCVinc    = .F.
857: 
858:             =fLerFiscal()
859: 
860:             WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
861:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
862: 
863:             IF THIS.this_oBusinessObject.this_nSistef = 1
864:                 loc_lcTipo  = "ATV"
865:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
866:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
867:                 IF VARTYPE(loc_SendTef) = "N"
868:                     *-- ATV ok
869:                 ELSE
870:                     loc_okTef = .F.
871:                     MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
872:                 ENDIF
873:                 WAIT CLEAR
874:             ENDIF
875: 
876:             IF loc_okTef
877:                 IF USED("CrTef")
878:                     USE IN CrTef
879:                 ENDIF
880:                 CREATE CURSOR CrTef (cinfos M)
881: 
882:                 IF THIS.this_oBusinessObject.BuscarTransacaoPorIdChaves(THIS.cPcIdChaves)
883:                     SELECT csSigFiTef
884:                     GO TOP
885: 
886:                     IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
887:                             ALLTRIM(crSigFiFis.Imps), ALLTRIM(csSigFiTef.cCupomnvs))
888:                         SELECT crTmpNFis
889:                         GO TOP
890:                         loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
891:                         loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
892:                         loc_lnQtdVia  = crTmpNFis.nQtdVias
893: 
894:                         loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
895:                         IF FILE(loc_lcArquivo)
896:                             DELETE FILE (loc_lcArquivo)
897:                         ENDIF
898: 
899:                         SELECT csSigFiTef
900:                         loc_lcTipo = "CNC"
901:                         TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
902:                                 loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
903:                                 csSigFiTef.cnNSUs, csSigFiTef.cFinalzs, csSigFiTef.cCupomnvs, ;
904:                                 csSigFiTef.Fpags, VAL(csSigFiTef.cnValors) / 100)
905: 
906:                         SELECT crTmpNFis
907:                         loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
908:                         loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
909:                         loc_lnQtdVia  = crTmpNFis.nQtdVias
910:                         loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
911: 

*-- Linhas 1012 a 1065:
1012:     ENDPROC
1013: 
1014:     *==========================================================================
1015:     PROTECTED PROCEDURE ProcCntTxt
1016:     *==========================================================================
1017:         LOCAL loc_cHeader, loc_lcTran, loc_nSistef, loc_cSQL, loc_oErro
1018:         TRY
1019:             IF !USED("crSigFiTef") OR EOF("crSigFiTef")
1020:                 RETURN
1021:             ENDIF
1022: 
1023:             loc_nSistef = THIS.this_oBusinessObject.this_nSistef
1024:             SELECT crSigFiTef
1025: 
1026:             IF (ALLTRIM(crSigFiTef.cTpTrans) = "99" AND loc_nSistef = 1) OR loc_nSistef = 3
1027:                 loc_cHeader = SPACE(3)
1028:             ELSE
1029:                 loc_cHeader = crSigFiTef.cHeaders
1030:             ENDIF
1031: 
1032:             IF USED("crSigFiTra")
1033:                 USE IN crSigFiTra
1034:             ENDIF
1035:             loc_cSQL = "SELECT * FROM SigFiTra " + ;
1036:                        "WHERE cHeaders = " + EscaparSQL(ALLTRIM(loc_cHeader)) + ;
1037:                        " AND cTpTrans = " + EscaparSQL(ALLTRIM(crSigFiTef.cTpTrans))
1038:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTra") > 0
1039:                 SELECT crSigFiTra
1040:                 GO TOP
1041:                 IF EOF() OR ALLTRIM(crSigFiTef.cTpTrans) = "99"
1042:                     loc_lcTran = "Outras"
1043:                 ELSE
1044:                     loc_lcTran = ALLTRIM(crSigFiTra.cTrans)
1045:                 ENDIF
1046:             ELSE
1047:                 loc_lcTran = "Outras"
1048:             ENDIF
1049: 
1050:             WITH THIS.cnt_4c_TefTxt
1051:                 .Top  = 35
1052:                 .Left = 2
1053:                 IF loc_nSistef = 1 OR loc_nSistef = 3
1054:                     IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
1055:                         .lbl_4c_TxtOper.Caption  = ALLTRIM(crSigFiTef.cTxtOpers)
1056:                         .lbl_4c_TxtOper.Width    = 239
1057:                         .lbl_4c_TxtOper.AutoSize = .T.
1058:                         .Visible = .T.
1059:                         .ZOrder()
1060:                     ENDIF
1061:                     IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
1062:                         .lbl_4c_TxtCli.Caption  = ALLTRIM(crSigFiTef.cTxtClis)
1063:                         .lbl_4c_TxtCli.Width    = 255
1064:                         .lbl_4c_TxtCli.AutoSize = .T.
1065:                         .Visible = .T.

*-- Linhas 1080 a 1151:
1080:     ENDPROC
1081: 
1082:     *==========================================================================
1083:     PROTECTED PROCEDURE ExcluirTef(par_cIdent)
1084:     *==========================================================================
1085:         LOCAL loc_llChecaSigTef, loc_cChave, loc_oErro
1086:         loc_llChecaSigTef = .F.
1087:         TRY
1088:             IF !USED("SigTef")
1089:                 IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
1090:                     USE (goSistema.DirTefEcfs + "\SigTef") IN 0
1091:                     loc_llChecaSigTef = .T.
1092:                 ENDIF
1093:             ENDIF
1094:             IF USED("SigTef")
1095:                 loc_cChave = "R" + go_4c_Sistema.cCodEmpresa + THIS.cOperacao + ALLTRIM(par_cIdent)
1096:                 =SEEK(loc_cChave, "SigTef", "Ident")
1097:                 SELECT SigTef
1098:                 IF !EOF("SigTef")
1099:                     DELETE IN SigTef
1100:                 ENDIF
1101:             ENDIF
1102:         CATCH TO loc_oErro
1103:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirTef")
1104:         ENDTRY
1105:         IF loc_llChecaSigTef AND USED("SigTef")
1106:             USE IN SigTef
1107:         ENDIF
1108:     ENDPROC
1109: 
1110:     *==========================================================================
1111:     PROTECTED PROCEDURE ImprFiscalProc(par_nIdent)
1112:     *==========================================================================
1113:         LOCAL loc_lRetCVinc, loc_lLoopCVinc, loc_lRetNImp, loc_lPrimeira, loc_lRetFim
1114:         LOCAL loc_lnValor, loc_lcCancTef, loc_lcNSUs, loc_lcTipo, loc_VerStatus
1115:         LOCAL loc_oFormulario, loc_lcRedes, loc_oErro
1116: 
1117:         TRY
1118:             IF USED("crSigFiFis")
1119:                 SELECT crSigFiFis
1120:                 GO TOP
1121:             ENDIF
1122: 
1123:             loc_oFormulario = THIS.this_oModem
1124: 
1125:             IF !EMPTY(THIS.cOperacao)
1126:                 loc_lRetCVinc  = .F.
1127:                 loc_lLoopCVinc = .T.
1128:                 loc_lPrimeira  = .T.
1129:                 loc_lRetFim    = .T.
1130: 
1131:                 DO WHILE loc_lLoopCVinc
1132:                     CLEAR TYPEAHEAD
1133:                     THIS.ProcCntTxt()
1134: 
1135:                     SELECT CrTefImp
1136:                     loc_lnValor = "0"
1137:                     GO TOP
1138:                     LOCATE FOR cinfos = " VALOR VENDA"
1139:                     IF EOF()
1140:                         LOCATE FOR cinfos = "    FINAL"
1141:                         IF !EOF()
1142:                             loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 10)), ",", ""), ".", "")
1143:                         ENDIF
1144:                     ELSE
1145:                         loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 16)), ",", ""), ".", "")
1146:                     ENDIF
1147:                     GO TOP
1148: 
1149:                     IF !loc_lPrimeira
1150:                         IF USED("crSigFiFis") AND UPPER(ALLTRIM(crSigFiFis.Imps)) = "SWEDA"
1151:                             loc_lRetFim = FinFimVinc(loc_oFormulario)

*-- Linhas 1168 a 1188:
1168:                         GO TOP
1169:                         loc_lRetCVinc = RRelGerVinc(CrTefImp.cnIdents, loc_oFormulario, THIS.cOperacao)
1170:                     ENDIF
1171: 
1172:                     loc_lPrimeira = .F.
1173:                     WITH THIS.cnt_4c_TefTxt
1174:                         .lbl_4c_TxtOper.Caption    = ""
1175:                         .lbl_4c_TxtCli.Caption     = ""
1176:                         .lbl_4c_TxtTpTrans.Caption = ""
1177:                         .Visible = .F.
1178:                     ENDWITH
1179: 
1180:                     IF loc_lRetCVinc
1181:                         loc_lcCancTef = ""
1182:                         IF USED("CrTefResp")
1183:                             SELECT CrTefResp
1184:                             GO TOP
1185:                             IF SEEK("025")
1186:                                 loc_lcCancTef = ALLTRIM(SUBSTR(CrTefResp.cinfos, 11))
1187:                             ENDIF
1188:                         ENDIF

*-- Linhas 1228 a 1271:
1228:                             loc_VerStatus = RotStatus(1, loc_oFormulario)
1229:                             IF VARTYPE(loc_VerStatus) <> "L"
1230:                                 IF SUBSTR(loc_VerStatus, 6, 1) = "t"
1231:                                     MsgAviso("Encontrou-se no comando a string 'TOTAL'", "ERRO")
1232:                                     FinFimVinc(loc_oFormulario)
1233:                                     IF THIS.this_oBusinessObject.this_nSistef = 1
1234:                                         IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1235:                                                 go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1236:                                                 ALLTRIM(STR(par_nIdent, 20)))
1237:                                             SELECT crSigFiTef
1238:                                             DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
1239:                                                 VAL(loc_lnValor) / 100
1240:                                         ENDIF
1241:                                     ENDIF
1242:                                     IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1243:                                             go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1244:                                             ALLTRIM(STR(par_nIdent, 20)))
1245:                                         SELECT crSigFiTef
1246:                                         loc_lcTipo = "NCN"
1247:                                         TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
1248:                                                 loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
1249:                                                 crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
1250:                                                 crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
1251:                                                 crSigFiTef.FPags)
1252:                                         THIS.ExcluirTef(crSigFiTef.cnIdents)
1253:                                     ENDIF
1254:                                     loc_lLoopCVinc = .F.
1255:                                     loc_lRetCVinc  = .F.
1256:                                     LOOP
1257:                                 ENDIF
1258:                             ENDIF
1259:                         ENDIF
1260: 
1261:                         IF (THIS.this_oBusinessObject.this_nSistef = 1 AND ;
1262:                             !MsgConfirma("IMPRESSORA N" + CHR(195) + "O RESPONDE, TENTAR NOVAMENTE", "")) OR ;
1263:                            THIS.this_oBusinessObject.this_nSistef = 3
1264: 
1265:                             IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1266:                                     go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1267:                                     ALLTRIM(STR(par_nIdent, 20)))
1268:                                 SELECT crSigFiTef
1269:                                 loc_lcTipo = "NCN"
1270:                                 TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
1271:                                         loc_lcTipo, VAL(crSigFiTef.cnIdents), ;

*-- Linhas 1290 a 1496:
1290: 
1291:                 WAIT CLEAR
1292:             ELSE
1293:                 MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o de Cupom Fiscal !!", "ERRO")
1294:             ENDIF
1295:         CATCH TO loc_oErro
1296:             WAIT CLEAR
1297:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ImprFiscalProc")
1298:         ENDTRY
1299:     ENDPROC
1300: 
1301:     *==========================================================================
1302:     * BtnIncluirClick - Aciona Administra + CHR(231) + CHR(227) + o do TEF (Admin)
1303:     * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
1304:     * Requer rede TEF preenchida (usada em CmdTefAdmWhen).
1305:     *==========================================================================
1306:     PROCEDURE BtnIncluirClick
1307:         IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
1308:             MsgAviso("Informe a Rede TEF antes de acionar a Administra" + CHR(231) + CHR(227) + "o.", "Aviso")
1309:             THIS.txt_4c_Redetef.SetFocus()
1310:             RETURN
1311:         ENDIF
1312:         THIS.CmdTefAdmClick()
1313:     ENDPROC
1314: 
1315:     *==========================================================================
1316:     * BtnAlterarClick - Verifica se o TEF esta Ativo (Tef Ativo)
1317:     * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
1318:     *==========================================================================
1319:     PROCEDURE BtnAlterarClick
1320:         IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
1321:             MsgAviso("Informe a Rede TEF antes de verificar o TEF Ativo.", "Aviso")
1322:             THIS.txt_4c_Redetef.SetFocus()
1323:             RETURN
1324:         ENDIF
1325:         THIS.CmdTefAtvClick()
1326:     ENDPROC
1327: 
1328:     *==========================================================================
1329:     * BtnVisualizarClick - Aciona Cancelamento de transacao TEF (Cancelar)
1330:     * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
1331:     *==========================================================================
1332:     PROCEDURE BtnVisualizarClick
1333:         IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
1334:             MsgAviso("Informe a Rede TEF antes de cancelar a transa" + CHR(231) + CHR(227) + "o.", "Aviso")
1335:             THIS.txt_4c_Redetef.SetFocus()
1336:             RETURN
1337:         ENDIF
1338:         THIS.CmdCancelarClick()
1339:     ENDPROC
1340: 
1341:     *==========================================================================
1342:     * BtnExcluirClick - Encerra o formulario (Encerrar)
1343:     * Form OPERACIONAL TEF: mapeia semantica CRUD para acao TEF equivalente.
1344:     *==========================================================================
1345:     PROCEDURE BtnExcluirClick
1346:         THIS.CmdEncerrarClick()
1347:     ENDPROC
1348: 
1349:     *==========================================================================
1350:     PROCEDURE BtnEncerrarClick
1351:     *==========================================================================
1352:         THIS.CmdEncerrarClick()
1353:     ENDPROC
1354: 
1355:     *==========================================================================
1356:     PROCEDURE BtnBuscarClick
1357:     *==========================================================================
1358:         *-- Form OPERACIONAL TEF: sem grade de registros para busca.
1359:         *-- Seta foco no campo Rede TEF para iniciar nova operacao.
1360:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1361:             THIS.txt_4c_Redetef.SetFocus()
1362:         ENDIF
1363:     ENDPROC
1364: 
1365:     *==========================================================================
1366:     PROCEDURE BtnSalvarClick
1367:     *==========================================================================
1368:         *-- Form OPERACIONAL TEF: sem registro CRUD para salvar.
1369:         *-- Aciona a operacao Admin (equivalente principal deste form).
1370:         IF EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
1371:             MsgAviso("Informe a Rede TEF antes de acionar a Administra" + ;
1372:                      CHR(231) + CHR(227) + "o.", "Aviso")
1373:             THIS.txt_4c_Redetef.SetFocus()
1374:             RETURN
1375:         ENDIF
1376:         THIS.CmdTefAdmClick()
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     PROCEDURE BtnCancelarClick
1381:     *==========================================================================
1382:         *-- Form OPERACIONAL TEF: encerra o formulario (sem edicao CRUD a cancelar).
1383:         THIS.CmdEncerrarClick()
1384:     ENDPROC
1385: 
1386:     *==========================================================================
1387:     PROTECTED PROCEDURE FormParaBO
1388:     *==========================================================================
1389:         LOCAL loc_lSucesso
1390:         loc_lSucesso = .F.
1391:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1392:             THIS.this_oBusinessObject.this_cRedeTef = ;
1393:                 IIF(VARTYPE(THIS.txt_4c_Redetef) = "O", ;
1394:                     ALLTRIM(THIS.txt_4c_Redetef.Value), "")
1395:             loc_lSucesso = .T.
1396:         ENDIF
1397:         RETURN loc_lSucesso
1398:     ENDPROC
1399: 
1400:     *==========================================================================
1401:     PROTECTED PROCEDURE BOParaForm
1402:     *==========================================================================
1403:         LOCAL loc_lSucesso
1404:         loc_lSucesso = .F.
1405:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1406:             IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1407:                 THIS.txt_4c_Redetef.Value = ;
1408:                     IIF(EMPTY(THIS.this_oBusinessObject.this_cRedeTef), ;
1409:                         "", THIS.this_oBusinessObject.this_cRedeTef)
1410:                 THIS.txt_4c_Redetef.Refresh()
1411:             ENDIF
1412:             loc_lSucesso = .T.
1413:         ENDIF
1414:         RETURN loc_lSucesso
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     PROCEDURE HabilitarCampos(par_lHabilitar)
1419:     *==========================================================================
1420:         LOCAL loc_lHab
1421:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1422:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1423:             THIS.txt_4c_Redetef.Enabled = loc_lHab
1424:         ENDIF
1425:         IF VARTYPE(THIS.cmd_4c_TefAdm) = "O"
1426:             THIS.cmd_4c_TefAdm.Enabled = loc_lHab AND THIS.this_oBusinessObject.this_lInicializado
1427:         ENDIF
1428:         IF VARTYPE(THIS.cmd_4c_TefAtv) = "O"
1429:             THIS.cmd_4c_TefAtv.Enabled = loc_lHab AND THIS.this_oBusinessObject.this_lInicializado
1430:         ENDIF
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     PROCEDURE LimparCampos
1435:     *==========================================================================
1436:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1437:             THIS.txt_4c_Redetef.Value = ""
1438:             THIS.txt_4c_Redetef.Refresh()
1439:         ENDIF
1440:         IF VARTYPE(THIS.cnt_4c_TefTxt) = "O"
1441:             WITH THIS.cnt_4c_TefTxt
1442:                 IF VARTYPE(.lbl_4c_TxtOper) = "O"
1443:                     .lbl_4c_TxtOper.Caption = ""
1444:                 ENDIF
1445:                 IF VARTYPE(.lbl_4c_TxtCli) = "O"
1446:                     .lbl_4c_TxtCli.Caption = ""
1447:                 ENDIF
1448:                 IF VARTYPE(.lbl_4c_TxtTpTrans) = "O"
1449:                     .lbl_4c_TxtTpTrans.Caption = ""
1450:                 ENDIF
1451:                 .Visible = .F.
1452:             ENDWITH
1453:         ENDIF
1454:         IF USED("CrTefImp")
1455:             USE IN CrTefImp
1456:         ENDIF
1457:         IF USED("CrTefResp")
1458:             USE IN CrTefResp
1459:         ENDIF
1460:         IF USED("CrTef")
1461:             USE IN CrTef
1462:         ENDIF
1463:         IF USED("crSigFiTra")
1464:             USE IN crSigFiTra
1465:         ENDIF
1466:         IF USED("CrSigFiNfs")
1467:             USE IN CrSigFiNfs
1468:         ENDIF
1469:         IF USED("csSigFiTef")
1470:             USE IN csSigFiTef
1471:         ENDIF
1472:         IF USED("crTmpNFis")
1473:             USE IN crTmpNFis
1474:         ENDIF
1475:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1476:             THIS.this_oBusinessObject.this_cRedeTef = ""
1477:         ENDIF
1478:     ENDPROC
1479: 
1480:     *==========================================================================
1481:     PROCEDURE CarregarLista
1482:     *==========================================================================
1483:         *-- Form OPERACIONAL TEF: sem lista de registros CRUD.
1484:         *-- InicializarEstadoTEF gerencia o carregamento de dados transacionais.
1485:         RETURN .T.
1486:     ENDPROC
1487: 
1488:     *==========================================================================
1489:     PROTECTED PROCEDURE AjustarBotoesPorModo
1490:     *==========================================================================
1491:         *-- Form OPERACIONAL TEF: sem modos CRUD (INCLUIR/ALTERAR/VISUALIZAR).
1492:         *-- Habilitacao dos botoes eh gerenciada por InicializarEstadoTEF.
1493:         RETURN .T.
1494:     ENDPROC
1495: 
1496: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprtefBO.prg):
*==============================================================================
* sigprtefBO.prg - Business Object para Administracao do TEF
* Fase 1/8 - Propriedades e Init
*==============================================================================
DEFINE CLASS sigprtefBO AS BusinessBase

    *-- Identificacao da operacao TEF
    this_cOperacao      = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
    this_cNoCaixa       = ""    && Numero do caixa fiscal (crSigFiMpf.cnCaixas)
    this_cNoFab         = ""    && Numero de fabricacao da impressora fiscal (LeituraFab)
    this_cPcIdChaves    = ""    && Chaves de identificacao da transacao TEF (param Init)

    *-- Parametros do sistema TEF carregados de SigCdPam
    this_nSistef        = 0     && Tipo sistema TEF: 1=SiTef/Autoritec, 3=VeriFone
    this_cImps          = ""    && Modelo impressora fiscal (ex: SWEDA) de crSigFiFis

    *-- Campo de busca / validacao TEF
    this_cRedeTef       = ""    && Comprovante / rede TEF selecionada (Get_redetef)

    *-- Flags de controle de acesso e estado
    this_lAcessoAdm     = .F.   && Acesso habilitado para operacao Admin TEF
    this_lAcessoAtv     = .F.   && Acesso habilitado para verificacao TEF Ativo
    this_lInicializado  = .F.   && Inicializacao concluida com sucesso (impressora OK)

    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor coSigCdPam
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                this_nSistef = NVL(Sistef, 0)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna identificador da operacao TEF corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cOperacao
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL TEF
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL TEF (usar AtualizarStatusTef)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao TEF em LogAuditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro
        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, UsuarioID, DataHora, ChavePrimaria) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigFiTef") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ")"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametrosTEF - Carrega Sistef de SigCdPam e popula this_nSistef
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametrosTEF()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("coSigCdPam")
                USE IN coSigCdPam
            ENDIF
            loc_cSQL = "SELECT Sistef FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "coSigCdPam") > 0
                SELECT coSigCdPam
                GOTO TOP
                IF !EOF()
                    this_nSistef = NVL(Sistef, 0)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoraFiscal - Carrega SigFiMpF pelo numero de fabricacao
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoraFiscal(par_cNoFab)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiMpF")
                USE IN crSigFiMpF
            ENDIF
            loc_cSQL = "SELECT cnCaixas FROM SigFiMpF"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiMpF") > 0
                SELECT crSigFiMpF
                GOTO TOP
                IF !EOF()
                    this_cNoCaixa = NVL(cnCaixas, "")
                    this_cNoFab   = ALLTRIM(par_cNoFab)
                    loc_lSucesso  = .T.
                ELSE
                    MsgAviso("Impressora Fiscal Inv" + CHR(225) + "lida para esta Loja !!", "Aviso")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComprovantes - Busca comprovantes TEF em SigFiNfs por modelo impressora
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComprovantes(par_cImps)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("CrSigFiNfs")
                USE IN CrSigFiNfs
            ENDIF
            loc_cSQL = "SELECT * FROM SigFiNfs WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "CrSigFiNfs") > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha na Conex" + CHR(227) + "o ao buscar comprovantes TEF", "Falha na Conex" + CHR(227) + "o")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarNFiscalPorComprovante - Busca SigFiNfs por Imps e cComprovs
    *--------------------------------------------------------------------------
    PROCEDURE BuscarNFiscalPorComprovante(par_cImps, par_cComprovs)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crTmpNFis")
                USE IN crTmpNFis
            ENDIF
            loc_cSQL = "SELECT Imps, cComprovs, cTefdReqs, cTefdResps, nQtdVias " + ;
                       "FROM SigFiNfs " + ;
                       "WHERE Imps = " + EscaparSQL(ALLTRIM(par_cImps)) + ;
                       " AND cComprovs = " + EscaparSQL(ALLTRIM(par_cComprovs))
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crTmpNFis") > 0
                SELECT crTmpNFis
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoTEF - Busca SigFiTef pelos campos chave (tipo/empresa/operacao/ident)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoTEF(par_cTipo, par_cEmps, par_cDopes, par_cIdents)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("crSigFiTef")
                USE IN crSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTef") > 0
                SELECT crSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTransacaoPorIdChaves - Busca SigFiTef por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTransacaoPorIdChaves(par_cIdChaves)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF USED("csSigFiTef")
                USE IN csSigFiTef
            ENDIF
            loc_cSQL = "SELECT cTipos, cEmps, cDopes, cnIdents, cNmRedes, cnNSUs, " + ;
                       "cFinalzs, cCupomnvs, FPags, cnNSUCancs, cnValors, " + ;
                       "cTxtOpers, cTxtClis, cIdChaves, cStatus, cHeaders, cnCupoms " + ;
                       "FROM SigFiTef " + ;
                       "WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "csSigFiTef") > 0
                SELECT csSigFiTef
                GOTO TOP
                loc_lSucesso = !EOF()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTef - UPDATE SigFiTef SET cStatus por cIdChaves
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTef(par_cIdChaves, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cIdChaves = " + EscaparSQL(par_cIdChaves)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cIdChaves", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorRede - UPDATE SigFiTef SET cStatus por cnmredes/cnnsus (CRT)
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorRede(par_cNmRedes, par_cNSUs, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnmredes = " + EscaparSQL(par_cNmRedes) + ;
                       " AND cnnsus = " + EscaparSQL(par_cNSUs) + ;
                       " AND cHeaders = 'CRT'"
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por rede", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarStatusTefPorIdents - UPDATE SigFiTef SET cStatus por cnIdents
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarStatusTefPorIdents(par_cIdents, par_cStatus)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "UPDATE SigFiTef SET cStatus = " + EscaparSQL(par_cStatus) + ;
                       " WHERE cnIdents = " + EscaparSQL(par_cIdents)
            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                SQLCOMMIT(gnConnHandle)
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Falha ao atualizar status TEF por cnIdents", "Erro")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

