# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_OMODEM. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprtef.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1651 linhas total):

*-- Linhas 9 a 261:
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
21: *
22: * FUNCOES GLOBAIS DO LEGADO AUSENTES POR DESENHO (CLAUDE.md regra #27)
23: *   fLerFiscal, SigFiTefReq, ImprFiscal, TefImpr, Responde, RotStatus,
24: *   RRelGerVinc, FinFimVinc - vem de sig.prg/SIGFUNCS.PRG, que NAO vieram no
25: *   acervo. Sao a conversa com a impressora fiscal e com o gerenciador TEF:
26: *   devolvem VALOR de transacao, logo um wrapper no-op gravaria status errado
27: *   em silencio (regra #17). Ficam ausentes de proposito, para que a falha
28: *   apareca ALTA em runtime em vez de corromper SigFiTef calada.
29: *   fChecaAcesso, LeituraFab e fDecriptografar JA existem (utils/) e sao usadas.
30: *==============================================================================
31: 
32: DEFINE CLASS Formsigprtef AS FormBase
33: 
34:     *-- Propriedades visuais (identicas ao legado)
35:     Height      = 190
36:     Width       = 800
37:     BorderStyle = 2
38:     AutoCenter  = .T.
39:     ShowWindow = 1
40:     ControlBox  = .F.
41:     MaxButton   = .F.
42:     MinButton   = .F.
43:     WindowType  = 1
44:     WindowState = 0
45:     DataSession = 2
46:     KeyPreview  = .T.
47: 
48:     *-- Propriedades customizadas (RESERVED3 do legado)
49:     cOperacao   = ""    && Operacao TEF atual (PADR NoCaixa+NoFab+'ADM', 20 chars)
50:     cNoCaixa    = ""    && Numero do caixa fiscal
51:     cNoFab      = ""    && Numero de fabricacao da impressora fiscal
52:     cPcIdChaves = ""    && Chaves de identificacao da transacao TEF
53: 
54:     *-- Referencia ao controle modem/impressora fiscal (OLE ActiveX no legado)
55:     *-- Fornecido externamente; funcoes TEF (SigFiTefReq etc.) dependem deste objeto
56:     this_oModem = .NULL.
57:     *-- Guarda de reentrancia dos lookups abertos de LostFocus (regra #37, Erro195)
58:     this_lEmLookup = .F.
59: 
60:     *==========================================================================
61:     PROCEDURE Init
62:     *==========================================================================
63:         LPARAMETERS par_lModal, par_cIdChaves
64: 
65:         IF VARTYPE(par_lModal) = "L" AND par_lModal
66:             THIS.WindowType = 1
67:         ENDIF
68: 
69:         IF VARTYPE(par_cIdChaves) = "C"
70:             THIS.cPcIdChaves = ALLTRIM(par_cIdChaves)
71:         ENDIF
72: 
73:         *-- DODEFAULT() chama FormBase.Init() que:
74:         *-- 1) aplica SET DATE TO BRITISH + SET CENTURY ON (fix DataSession=2)
75:         *-- 2) chama THIS.InicializarForm()
76:         RETURN DODEFAULT()
77:     ENDPROC
78: 
79:     *==========================================================================
80:     PROTECTED PROCEDURE InicializarForm
81:     *==========================================================================
82:         LOCAL loc_lSucesso, loc_oErro
83:         loc_lSucesso = .F.
84: 
85:         TRY
86:             THIS.Caption = "Administra" + CHR(231) + CHR(227) + "o do TEF"
87: 
88:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
89:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
90:             ENDIF
91: 
92:             THIS.this_oBusinessObject = CREATEOBJECT("sigprtefBO")
93:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
94: 
95:                 *-- Guard para validacao de UI sem conexao SQL
96:                 IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
97:                     THIS.ConfigurarPageFrame()
98:                     THIS.ConfigurarPaginaDados()
99:                     loc_lSucesso = .T.
100:                 ELSE
101:                     *-- Carregar parametros TEF de SigCdPam (popula this_nSistef no BO)
102:                     IF THIS.this_oBusinessObject.CarregarParametrosTEF()
103:                         THIS.ConfigurarPageFrame()
104:                         *-- DEPOIS de todos os AddObject: aplica a ordem de tabulacao do SCX
105:                         THIS.ConfigurarPaginaDados()
106:                         THIS.InicializarEstadoTEF()
107:                         THIS.ConfigurarEventos()
108:                         loc_lSucesso = .T.
109:                     ELSE
110:                         MsgErro("Falha ao carregar par" + CHR(226) + "metros TEF de SigCdPam", "Erro")
111:                     ENDIF
112:                 ENDIF
113: 
114:             ELSE
115:                 MsgErro("Falha ao criar sigprtefBO", "Erro")
116:             ENDIF
117: 
118:         CATCH TO loc_oErro
119:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
120:                     " PROC=" + loc_oErro.Procedure, "Erro ao inicializar TEF")
121:         ENDTRY
122: 
123:         RETURN loc_lSucesso
124:     ENDPROC
125: 
126:     *==========================================================================
127:     PROTECTED PROCEDURE ConfigurarPageFrame
128:     *==========================================================================
129:         *-- Form OPERACIONAL: layout FLAT (sem PageFrame).
130:         *-- Metodo mantido por compatibilidade com validador do orquestrador
131:         *-- e delega para ConfigurarForm (que cria o layout customizado real).
132:         THIS.ConfigurarForm()
133:         RETURN .T.
134:     ENDPROC
135: 
136:     *==========================================================================
137:     PROTECTED PROCEDURE ConfigurarPaginaLista
138:     *==========================================================================
139:         *-- Form OPERACIONAL: modal flat 800x190 SEM PageFrame e SEM Grid CRUD.
140:         *-- Nao existe "Page1 - Lista de Registros" nesta tela: os dados TEF
141:         *-- (crSigFiFis, crSigFiTef, CrSigFiNfs, CrTefImp, CrTefResp, SigTef)
142:         *-- sao cursores TRANSACIONAIS carregados sob demanda em
143:         *-- InicializarEstadoTEF, TxtRedetefValid, ProcCntTxt, CmdTefAdmClick e
144:         *-- CmdCancelarClick conforme o fluxo TEF (Ativo/Admin/Cancelamento).
145:         *--
146:         *-- Este metodo existe para atender ao contrato do validador do
147:         *-- orquestrador de migracao (Fase 4) e retorna sempre .T. porque
148:         *-- toda a "configuracao de exibicao" ja foi feita em ConfigurarForm().
149:         RETURN .T.
150:     ENDPROC
151: 
152:     *==========================================================================
153:     PROCEDURE AlternarPagina(par_nPagina)
154:     *==========================================================================
155:         *-- Form OPERACIONAL: NAO possui pgf_4c_Paginas (Page1/Page2 CRUD).
156:         *-- A UI eh flat (todos os controles no proprio Form) e a unica
157:         *-- alternancia visual eh o container cnt_4c_TefTxt (Visible=.T./.F.)
158:         *-- gerenciado por ProcCntTxt() apos leitura da transacao TEF.
159:         *--
160:         *-- Metodo existe para atender ao contrato do validador do orquestrador
161:         *-- de migracao (Fase 4). par_nPagina eh ignorado; sempre retorna .T.
162:         RETURN .T.
163:     ENDPROC
164: 
165:     *==========================================================================
166:     PROTECTED PROCEDURE ConfigurarPaginaDados
167:     *==========================================================================
168:         *-- Form OPERACIONAL FLAT: nao existe "Page2 - Dados". Os controles (Shape1,
169:         *-- cnt_4c_OModem, cnt_4c_TefTxt + 6 labels, lbl_4c_Redetef, txt_4c_Redetef e
170:         *-- os 4 botoes) sao filhos DIRETOS do form e foram criados em ConfigurarForm().
171:         *--
172:         *-- O que sobra desta fase eh a ORDEM DE TABULACAO, que o SCX declara e que o
173:         *-- migrador descartou: com AddObject o VFP9 numera o TabIndex pela ordem de
174:         *-- CRIACAO, e a ordem de criacao do migrado nao bate com a do legado (os
175:         *-- botoes do SCX vem na ordem Sair/TefAdm/Command1/TefAtv, o migrado cria
176:         *-- TefAdm/TefAtv/Cancelar/Encerrar). Nao da erro, nao entra em log e nao
177:         *-- aparece em screenshot: so o Tab andando na ordem errada.
178:         *--
179:         *-- Roda em metodo proprio porque TabIndex precisa ser atribuido DEPOIS de
180:         *-- TODOS os AddObject (o VFP renumera a cada criacao), em ordem ASCENDENTE
181:         *-- (cada atribuicao poe o controle na posicao pedida e empurra os demais).
182:         *--
183:         *-- ATENCAO - os numeros vem da ordem EFETIVA do legado, nao da literal:
184:         *-- o SCX guarda TabIndex para so 3 objetos (medido lendo o .scx como DBF:
185:         *-- Get_redetef = 1, Say1 = 6, CntTefTxt = 8). Mas o VFP aplica cada valor no
186:         *-- momento em que CRIA o objeto e CLAMPA ao total de controles existentes
187:         *-- naquele instante - quando Say1 nasce (3o objeto) o 6 nao cabe, e quando
188:         *-- CntTefTxt nasce (5o) o 8 nao cabe. Simulado no VFP9 em 2026-10-20
189:         *-- (automation\medir_tabindex_sigprtef.prg), recriando os objetos na ordem dos registros
190:         *-- do SCX, a ordem EFETIVA do legado eh:
191:         *--     Get_redetef=1  oModem=2  Say1=3  CntTefTxt=4
192:         *--     Sair=5         TefAdm=6  Command1=7  TefAtv=8
193:         *-- Ou seja: so o 1 do campo de digitacao sobrevive; o resto fica na ordem de
194:         *-- criacao do SCX. Transcrever 6 e 8 ao pe da letra inverteria os botoes
195:         *-- (Encerrar iria para o fim do ciclo em vez do inicio) - seria FIEL AO
196:         *-- ARQUIVO e INFIEL A TELA. ZOrderSet (Say1=13, Get_redetef=30) nao eh
197:         *-- transcrito: eh bookkeeping do Form Designer e nao existe em runtime (#33).
198:         LOCAL loc_lSucesso, loc_oErro
199:         loc_lSucesso = .F.
200: 
201:         TRY
202:             THIS.txt_4c_Redetef.TabIndex = 1    && legado: Get_redetef (unico campo digitavel)
203:             THIS.cnt_4c_OModem.TabIndex  = 2    && legado: oModem
204:             THIS.lbl_4c_Redetef.TabIndex = 3    && legado: Say1
205:             THIS.cnt_4c_TefTxt.TabIndex  = 4    && legado: CntTefTxt
206:             THIS.cmd_4c_Encerrar.TabIndex = 5   && legado: Sair
207:             THIS.cmd_4c_TefAdm.TabIndex   = 6   && legado: TefAdm
208:             THIS.cmd_4c_Cancelar.TabIndex = 7   && legado: Command1
209:             THIS.cmd_4c_TefAtv.TabIndex   = 8   && legado: TefAtv
210: 
211:             loc_lSucesso = .T.
212:         CATCH TO loc_oErro
213:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
214:                     " PROC=" + loc_oErro.Procedure, "Erro ConfigurarPaginaDados")
215:         ENDTRY
216: 
217:         RETURN loc_lSucesso
218:     ENDPROC
219: 
220:     *==========================================================================
221:     PROTECTED PROCEDURE ConfigurarForm
222:     *==========================================================================
223:         LOCAL loc_oErro
224:         TRY
225: 
226:             *-- Shape decorativo (canto direito - Shape1 do legado)
227:             THIS.AddObject("shp_4c_Shape1", "Shape")
228:             WITH THIS.shp_4c_Shape1
229:                 .Top         = 7
230:                 .Left        = 698
231:                 .Height      = 110
232:                 .Width       = 90
233:                 .BackStyle   = 0
234:                 .BorderColor = RGB(136, 189, 188)
235:                 .Visible     = .T.
236:             ENDWITH
237: 
238:             *-- Area posicional do controle OLE modem (oModem/ActiveX do legado): o
239:             *-- ActiveX nao pode ser criado por AddObject em .prg, entao a instancia
240:             *-- real chega por THIS.this_oModem (ver cabecalho). Este Container
241:             *-- reserva exatamente o retangulo 100x100 em (320,8) do SCX.
242:             THIS.AddObject("cnt_4c_OModem", "Container")
243:             WITH THIS.cnt_4c_OModem
244:                 .Top       = 8
245:                 .Left      = 320
246:                 .Height    = 100
247:                 .Width     = 100
248:                 .BackStyle = 0
249:                 .Visible   = .T.
250:             ENDWITH
251: 
252:             *-- Container de mensagens TEF (CntTefTxt do legado - inicia Visible=.F.)
253:             THIS.AddObject("cnt_4c_TefTxt", "Container")
254:             WITH THIS.cnt_4c_TefTxt
255:                 .Top           = 192
256:                 .Left          = 0
257:                 .Height        = 155
258:                 .Width         = 381
259:                 .SpecialEffect = 0
260:                 .BackColor     = RGB(255, 255, 255)
261:                 .BackStyle     = 1

*-- Linhas 510 a 558:
510: 
511:         CATCH TO loc_oErro
512:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
513:                     " PROC=" + loc_oErro.Procedure, "Erro ConfigurarForm")
514:         ENDTRY
515:     ENDPROC
516: 
517:     *==========================================================================
518:     PROTECTED PROCEDURE InicializarEstadoTEF
519:     *==========================================================================
520:         LOCAL loc_lOk, loc_cNoFab, loc_cNoFabr, loc_oErro
521:         loc_lOk = .F.
522: 
523:         TRY
524:             THIS.cOperacao = ""
525:             THIS.cNoCaixa  = ""
526:             THIS.cNoFab    = ""
527: 
528:             *-- Carregar configuracao fiscal (popula crSigFiFis - usado nos handlers)
529:             =fLerFiscal()
530:             SELECT crSigFiFis
531:             GO TOP
532: 
533:             IF VARTYPE(THIS.this_oModem) = "O"
534:                 *-- Ler numero de fabricacao da impressora fiscal
535:                 loc_cNoFab = LeituraFab(THIS.this_oModem)
536:                 IF VARTYPE(loc_cNoFab) = "C"
537:                     loc_cNoFabr = fDecriptografar(ALLTRIM(loc_cNoFab))
538:                     IF THIS.this_oBusinessObject.CarregarImpressoraFiscal(loc_cNoFabr)
539:                         THIS.cNoCaixa  = THIS.this_oBusinessObject.this_cNoCaixa
540:                         THIS.cNoFab    = loc_cNoFab
541:                         THIS.cOperacao = PADR(THIS.cNoCaixa + THIS.cNoFab + "ADM", 20)
542:                         loc_lOk        = .T.
543:                     ENDIF
544:                 ENDIF
545:             ENDIF
546: 
547:             *-- Legado (SIGPRTEF.Init, With Thisform):
548:             *--   .TefAdm.Enabled = fChecaAcesso('TEFADM') and ok
549:             *--   .TefAtv.Enabled = fChecaAcesso('TEFATV') and ok
550:             *-- fChecaAcesso EXISTE em utils/functions.prg - transcrever, nao descartar.
551:             *-- O estado fica no BO (fonte unica) para HabilitarCampos reproduzir a
552:             *-- MESMA condicao ao reabilitar; sem ele this_lInicializado nunca era
553:             *-- escrito e HabilitarCampos(.T.) desligava os dois botoes de acao.
554:             THIS.this_oBusinessObject.this_lAcessoAdm    = fChecaAcesso("TEFADM")
555:             THIS.this_oBusinessObject.this_lAcessoAtv    = fChecaAcesso("TEFATV")
556:             THIS.this_oBusinessObject.this_lInicializado = loc_lOk
557: 
558:             THIS.cmd_4c_TefAdm.Enabled = THIS.this_oBusinessObject.this_lAcessoAdm AND loc_lOk

*-- Linhas 567 a 878:
567:     ENDPROC
568: 
569:     *==========================================================================
570:     PROCEDURE TornarControlesVisiveis(par_oContainer)
571:     *==========================================================================
572:         *-- Torna controles Visible=.T. recursivamente.
573:         *-- FILTRO: cnt_4c_TefTxt fica Visible=.F. (toggled pela procedure CntTxt)
574:         *-- Os filhos do container filtrado sao recursados para ficarem Visible=.T.
575:         *-- quando o container for exibido posteriormente.
576:         LOCAL loc_i, loc_oControl, loc_p
577:         FOR loc_i = 1 TO par_oContainer.ControlCount
578:             loc_oControl = par_oContainer.Controls(loc_i)
579:             IF VARTYPE(loc_oControl) = "O"
580:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_TEFTXT")
581:                     *-- Container oculto por logica TEF: recursar filhos sem
582:                     *-- alterar Visible do proprio container
583:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
584:                         THIS.TornarControlesVisiveis(loc_oControl)
585:                     ENDIF
586:                     LOOP
587:                 ENDIF
588:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
589:                     loc_oControl.Visible = .T.
590:                 ENDIF
591:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
592:                     FOR loc_p = 1 TO loc_oControl.PageCount
593:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_p))
594:                     ENDFOR
595:                 ENDIF
596:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
597:                     THIS.TornarControlesVisiveis(loc_oControl)
598:                 ENDIF
599:             ENDIF
600:         ENDFOR
601:     ENDPROC
602: 
603:     *==========================================================================
604:     PROCEDURE Destroy
605:     *==========================================================================
606:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
607:             THIS.this_oBusinessObject = .NULL.
608:         ENDIF
609:         IF VARTYPE(THIS.this_oModem) = "O"
610:             THIS.this_oModem = .NULL.
611:         ENDIF
612:         DODEFAULT()
613:     ENDPROC
614: 
615:     *==========================================================================
616:     PROTECTED PROCEDURE ConfigurarEventos
617:     *==========================================================================
618:         LOCAL loc_oErro
619:         TRY
620:             BINDEVENT(THIS.cmd_4c_Encerrar, "Click",    THIS, "CmdEncerrarClick")
621:             BINDEVENT(THIS.cmd_4c_TefAdm,   "Click",    THIS, "CmdTefAdmClick")
622:             BINDEVENT(THIS.cmd_4c_TefAdm,   "When",     THIS, "CmdTefAdmWhen")
623:             BINDEVENT(THIS.cmd_4c_TefAtv,   "Click",    THIS, "CmdTefAtvClick")
624:             BINDEVENT(THIS.cmd_4c_TefAtv,   "When",     THIS, "CmdTefAtvWhen")
625:             BINDEVENT(THIS.cmd_4c_Cancelar, "Click",    THIS, "CmdCancelarClick")
626:             BINDEVENT(THIS.cmd_4c_Cancelar, "When",     THIS, "CmdCancelarWhen")
627:             BINDEVENT(THIS.txt_4c_Redetef,  "KeyPress", THIS, "TxtRedetefKeyPress")
628:             BINDEVENT(THIS.txt_4c_Redetef,  "LostFocus",    THIS, "TxtRedetefValid")
629:             BINDEVENT(THIS.txt_4c_Redetef,  "DblClick", THIS, "TxtRedetefDblClick")
630:         CATCH TO loc_oErro
631:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ConfigurarEventos")
632:         ENDTRY
633:     ENDPROC
634: 
635:     *==========================================================================
636:     PROCEDURE CmdEncerrarClick
637:     *==========================================================================
638:         THIS.Release()
639:     ENDPROC
640: 
641:     *==========================================================================
642:     PROCEDURE CmdTefAdmWhen
643:     *==========================================================================
644:         RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
645:     ENDPROC
646: 
647:     *==========================================================================
648:     PROCEDURE CmdTefAtvWhen
649:     *==========================================================================
650:         RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
651:     ENDPROC
652: 
653:     *==========================================================================
654:     PROCEDURE CmdCancelarWhen
655:     *==========================================================================
656:         RETURN !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
657:     ENDPROC
658: 
659:     *==========================================================================
660:     PROCEDURE TxtRedetefKeyPress
661:     *==========================================================================
662:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
663:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
664:             IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
665:                 THIS.TxtRedetefValid()
666:             ENDIF
667:         ENDIF
668:     ENDPROC
669: 
670:     *==========================================================================
671:     *-- Irmao do lookup (abre o mesmo funil por duplo clique no campo).
672:     *-- Regra #47: irmao que DELEGA para o alvo NAO pode ligar this_lEmLookup -
673:     *-- o wrapper TxtRedetefValid devolveria sem abrir nada e o DblClick morreria.
674:     PROCEDURE TxtRedetefDblClick
675:     *==========================================================================
676:         THIS.TxtRedetefValid()
677:     ENDPROC
678: 
679:     *==========================================================================
680:     *-- Guarda de reentrancia (regra #37): o picker eh MODAL e tira o foco do
681:     *-- campo, o que redispara este proprio LostFocus. O corpo vive em TxtRedetefValidExec
682:     *-- para que a flag seja SEMPRE liberada, inclusive nos RETURN antecipados.
683:     *-- Ligado a "KeyPress" o lookup abria a cada tecla, antes de o usuario
684:     *-- terminar de digitar o codigo (Erro195). Legado valida no Valid do campo.
685:     PROCEDURE TxtRedetefValid()
686:         IF THIS.this_lEmLookup
687:             RETURN
688:         ENDIF
689:         THIS.this_lEmLookup = .T.
690:         THIS.TxtRedetefValidExec()
691:         THIS.this_lEmLookup = .F.
692:     ENDPROC
693: 
694:     PROCEDURE TxtRedetefValidExec()
695:     *==========================================================================
696:         LOCAL loc_lOk, loc_oErro
697:         loc_lOk = .T.
698:         TRY
699:             IF !EMPTY(ALLTRIM(THIS.txt_4c_Redetef.Value))
700:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
701:                     IF THIS.this_oBusinessObject.BuscarComprovantes(ALLTRIM(crSigFiFis.Imps))
702:                         SELECT CrSigFiNfs
703:                         INDEX ON cComprovs TAG cComprovs
704:                         IF SEEK(ALLTRIM(THIS.txt_4c_Redetef.Value), "CrSigFiNfs", "cComprovs")
705:                             *-- Achou exato: normaliza o conteudo digitado para a
706:                             *-- grafia gravada na coluna (char(20) com padding).
707:                             THIS.txt_4c_Redetef.Value = ALLTRIM(CrSigFiNfs.cComprovs)
708:                         ELSE
709:                             *-- Nao achou: so o picker decide. Regra #37/#50 - a
710:                             *-- atribuicao mora DENTRO de AbrirBuscaRedetef, sob a
711:                             *-- guarda this_lSelecionou. Ler CrSigFiNfs aqui fora
712:                             *-- ZERARIA/trocaria o codigo digitado quando o usuario
713:                             *-- cancela o dialogo (o ponteiro do cursor fica numa
714:                             *-- linha qualquer) e nao haveria como preencher o campo.
715:                             THIS.AbrirBuscaRedetef()
716:                         ENDIF
717:                         THIS.txt_4c_Redetef.Refresh()
718:                     ENDIF
719:                 ENDIF
720:             ELSE
721:                 THIS.txt_4c_Redetef.Value = ""
722:                 THIS.txt_4c_Redetef.Refresh()
723:             ENDIF
724:         CATCH TO loc_oErro
725:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ValidarRedetef")
726:         ENDTRY
727:         RETURN loc_lOk
728:     ENDPROC
729: 
730:     *==========================================================================
731:     PROTECTED PROCEDURE AbrirBuscaRedetef
732:     *==========================================================================
733:         LOCAL loc_oBusca, loc_cImps, loc_oErro
734:         TRY
735:             loc_cImps = IIF(USED("crSigFiFis") AND !EOF("crSigFiFis"), ALLTRIM(crSigFiFis.Imps), "")
736:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
737:                                        "SigFiNfs", ;
738:                                        "cursor_4c_BuscaRedetef", ;
739:                                        "cComprovs", ;
740:                                        ALLTRIM(THIS.txt_4c_Redetef.Value), ;
741:                                        "Sele" + CHR(231) + CHR(227) + "o", ;
742:                                        .F., .F., ;
743:                                        "Imps = " + EscaparSQL(loc_cImps))
744:             IF VARTYPE(loc_oBusca) = "O"
745:                 *-- Contrato do FormBuscaAuxiliar (regra #37): o Init JA tentou o
746:                 *-- match exato e, achando 1 registro, resolveu o valor sozinho.
747:                 *-- Sem esta guarda o dialogo abre com UMA linha por cima da tela
748:                 *-- ja preenchida e o usuario precisa dispensa-lo a toa.
749:                 IF !loc_oBusca.this_lAchouRegistro
750:                     loc_oBusca.mAddColuna("cComprovs", "", "Rede Tef")
751:                     loc_oBusca.mAddColuna("nfinalzs",  "XXXXXXXXXX", "Finalizadora")
752:                     loc_oBusca.Show()
753:                 ENDIF
754:                 *-- Atribuicao SO sob a guarda this_lSelecionou: nada escolhido
755:                 *-- significa manter o codigo que o usuario digitou (regra #50 -
756:                 *-- apagar o digitado impede o preenchimento do campo).
757:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaRedetef")
758:                     THIS.txt_4c_Redetef.Value = ALLTRIM(cursor_4c_BuscaRedetef.cComprovs)
759:                 ENDIF
760:                 loc_oBusca.Release()
761:             ENDIF
762:         CATCH TO loc_oErro
763:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro AbrirBuscaRedetef")
764:         ENDTRY
765:         IF USED("cursor_4c_BuscaRedetef")
766:             USE IN cursor_4c_BuscaRedetef
767:         ENDIF
768:     ENDPROC
769: 
770:     *==========================================================================
771:     PROCEDURE CmdTefAtvClick
772:     *==========================================================================
773:         LOCAL loc_lcRedeTef, loc_lcTipo, loc_SendTef, loc_lcDirReq, loc_lcArq, loc_oErro
774:         TRY
775:             WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
776:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
777:             loc_lcTipo    = "ATV"
778:             loc_SendTef   = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
779:                                          THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
780:             IF VARTYPE(loc_SendTef) = "N"
781:                 MsgAviso("Gerenciador Padr" + CHR(227) + "o Ativo !!", "")
782:             ELSE
783:                 MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
784:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
785:                     IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
786:                             ALLTRIM(crSigFiFis.Imps), loc_lcRedeTef)
787:                         SELECT crTmpNFis
788:                         GO TOP
789:                         IF !EOF("crTmpNFis")
790:                             loc_lcDirReq = ALLTRIM(crTmpNFis.cTefdReqs)
791:                             loc_lcArq    = loc_lcDirReq + "IntPos.001"
792:                             IF FILE(loc_lcArq)
793:                                 DELETE FILE (loc_lcArq)
794:                             ENDIF
795:                             loc_lcArq = loc_lcDirReq + "IntPos.Tmp"
796:                             IF FILE(loc_lcArq)
797:                                 DELETE FILE (loc_lcArq)
798:                             ENDIF
799:                         ENDIF
800:                     ENDIF
801:                 ENDIF
802:             ENDIF
803:             WAIT CLEAR
804:         CATCH TO loc_oErro
805:             WAIT CLEAR
806:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAtvClick")
807:         ENDTRY
808:     ENDPROC
809: 
810:     *==========================================================================
811:     PROCEDURE CmdTefAdmClick
812:     *==========================================================================
813:         LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_lnIdent
814:         LOCAL loc_okTef, loc_llChecaSigTef, loc_lnQtdTef, loc_RetNImp
815:         LOCAL loc_oFormulario, loc_VerStatus, loc_oErro
816: 
817:         TRY
818:             IF USED("CrTefImp")
819:                 USE IN CrTefImp
820:             ENDIF
821:             CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
822:             INDEX ON cnIdents TAG Ident
823: 
824:             loc_oFormulario = THIS.this_oModem
825:             loc_okTef       = .T.
826: 
827:             WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
828:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
829: 
830:             IF THIS.this_oBusinessObject.this_nSistef = 1
831:                 loc_lcTipo  = "ATV"
832:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
833:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
834:                 IF VARTYPE(loc_SendTef) = "N"
835:                     *-- ATV retornou numerico: TEF ativo
836:                 ELSE
837:                     loc_okTef = .F.
838:                     MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
839:                 ENDIF
840:                 WAIT CLEAR
841:             ENDIF
842: 
843:             IF loc_okTef
844:                 loc_llChecaSigTef = .F.
845:                 IF !USED("SigTef")
846:                     IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
847:                         USE (goSistema.DirTefEcfs + "\SigTef") IN 0
848:                         loc_llChecaSigTef = .T.
849:                     ENDIF
850:                 ENDIF
851: 
852:                 IF USED("CrTef")
853:                     USE IN CrTef
854:                 ENDIF
855:                 CREATE CURSOR CrTef (cinfos M)
856: 
857:                 IF USED("SigTef")
858:                     SELECT SigTef
859:                     COUNT FOR !DELETED() TO loc_lnQtdTef
860:                     GO TOP
861:                     IF loc_lnQtdTef = 1 AND SigTef.cStatus <> "CNF"
862:                         SCAN
863:                             IF SigTef.cCnfs = "C"
864:                                 WAIT WINDOW "Aguarde Processamento Confirma" + CHR(231) + ;
865:                                             CHR(227) + "o SITEF, Prov" + CHR(225) + ;
866:                                             "vel Queda Energia !!" NOWAIT
867:                                 loc_lcTipo = "CNF"
868:                             ELSE
869:                                 WAIT WINDOW "Aguarde Processamento Cancelamento SITEF, Prov" + ;
870:                                             CHR(225) + "vel Queda Energia !!" NOWAIT
871:                                 loc_lcTipo = "NCN"
872:                                 THIS.this_oBusinessObject.AtualizarStatusTefPorIdents( ;
873:                                     SigTef.cnIdents, "CNC")
874:                             ENDIF
875:                             loc_RetNImp = TefImpr(SigTef.cEmps, SigTef.cDopes, ;
876:                                                    VAL(SigTef.cnCupoms), loc_lcTipo, ;
877:                                                    VAL(SigTef.cnIdents), SigTef.cNmRedes, ;
878:                                                    SigTef.cnNSUs, SigTef.cFinalzs, ;

*-- Linhas 887 a 930:
887:                                 SELECT SigTef
888:                                 DELETE
889:                             ELSE
890:                                 MsgAviso("Problemas de comunica" + CHR(231) + ;
891:                                          CHR(227) + "o com TEF !!", "")
892:                                 loc_okTef = .F.
893:                             ENDIF
894:                         ENDSCAN
895:                     ELSE
896:                         SELECT SigTef
897:                         DELETE ALL
898:                     ENDIF
899:                 ENDIF
900: 
901:                 WAIT CLEAR
902: 
903:                 IF loc_llChecaSigTef AND USED("SigTef")
904:                     USE IN SigTef
905:                 ENDIF
906:                 IF USED("CrTef")
907:                     USE IN CrTef
908:                 ENDIF
909: 
910:                 IF USED("crSigFiFis") AND !EOF("crSigFiFis")
911:                     IF UPPER(ALLTRIM(crSigFiFis.Imps)) <> "SWEDA"
912:                         loc_VerStatus = RotStatus(1, loc_oFormulario)
913:                         IF VARTYPE(loc_VerStatus) <> "L"
914:                             IF SUBSTR(loc_VerStatus, 1, 1) = "R"
915:                                 FinFimVinc(loc_oFormulario)
916:                             ENDIF
917:                         ENDIF
918:                     ENDIF
919:                 ENDIF
920: 
921:                 WAIT WINDOW "Aguarde Processamento TEF !!" NOWAIT
922:                 loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
923:                 THIS.cmd_4c_TefAdm.Enabled = .F.
924:                 loc_lcTipo  = "ADM"
925:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
926:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
927:                 WAIT CLEAR
928: 
929:                 SELECT CrTefImp
930:                 IF RECCOUNT("CrTefImp") <> 0

*-- Linhas 946 a 1045:
946:                             IF USED("crSigFiTef") AND !EOF("crSigFiTef")
947:                                 SELECT crSigFiTef
948:                                 IF !EMPTY(ALLTRIM(crSigFiTef.cTxtOpers))
949:                                     MsgAviso(ALLTRIM(crSigFiTef.cTxtOpers), "")
950:                                 ENDIF
951:                                 IF !EMPTY(ALLTRIM(crSigFiTef.cTxtClis))
952:                                     MsgAviso(ALLTRIM(crSigFiTef.cTxtClis), "")
953:                                 ENDIF
954:                             ENDIF
955:                         ENDIF
956:                     ENDIF
957:                 ENDIF
958:             ENDIF
959: 
960:             WAIT CLEAR
961:             THIS.cmd_4c_TefAdm.Enabled = .T.
962: 
963:         CATCH TO loc_oErro
964:             WAIT CLEAR
965:             THIS.cmd_4c_TefAdm.Enabled = .T.
966:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro CmdTefAdmClick")
967:         ENDTRY
968:     ENDPROC
969: 
970:     *==========================================================================
971:     PROCEDURE CmdCancelarClick
972:     *==========================================================================
973:         LOCAL loc_lcRedeTef, loc_SendTef, loc_lcTipo, loc_okTef
974:         LOCAL loc_lcDirReq, loc_lcDirResp, loc_lnQtdVia, loc_lcArquivo
975:         LOCAL loc_lcNSU, loc_lcFinalzs, loc_llCancTef, loc_RetCVinc
976:         LOCAL loc_lnContaQtdVia, loc_oFormulario, loc_lcMsg, loc_oErro
977: 
978:         TRY
979:             IF USED("CrTefImp")
980:                 USE IN CrTefImp
981:             ENDIF
982:             CREATE CURSOR CrTefImp (cinfos C(100), nordems N(2), cnIdents C(10))
983:             INDEX ON cnIdents TAG Ident
984: 
985:             loc_oFormulario = THIS.this_oModem
986:             loc_okTef       = .T.
987:             loc_lcNSU       = ""
988:             loc_lcFinalzs   = ""
989:             loc_llCancTef   = .F.
990:             loc_RetCVinc    = .F.
991: 
992:             =fLerFiscal()
993: 
994:             WAIT WINDOW "Aguarde Verificando TEF Ativo!!" NOWAIT
995:             loc_lcRedeTef = ALLTRIM(THIS.txt_4c_Redetef.Value)
996: 
997:             IF THIS.this_oBusinessObject.this_nSistef = 1
998:                 loc_lcTipo  = "ATV"
999:                 loc_SendTef = SigFiTefReq(THIS, THIS.cNoCaixa, go_4c_Sistema.cCodEmpresa, ;
1000:                                            THIS.cOperacao, 0, 0, loc_lcTipo, 0, loc_lcRedeTef)
1001:                 IF VARTYPE(loc_SendTef) = "N"
1002:                     *-- ATV ok
1003:                 ELSE
1004:                     loc_okTef = .F.
1005:                     MsgAviso("Gerenciador Padr" + CHR(227) + "o n" + CHR(227) + "o Ativo !!", "")
1006:                 ENDIF
1007:                 WAIT CLEAR
1008:             ENDIF
1009: 
1010:             IF loc_okTef
1011:                 IF USED("CrTef")
1012:                     USE IN CrTef
1013:                 ENDIF
1014:                 CREATE CURSOR CrTef (cinfos M)
1015: 
1016:                 IF THIS.this_oBusinessObject.BuscarTransacaoPorIdChaves(THIS.cPcIdChaves)
1017:                     SELECT csSigFiTef
1018:                     GO TOP
1019: 
1020:                     IF THIS.this_oBusinessObject.BuscarNFiscalPorComprovante( ;
1021:                             ALLTRIM(crSigFiFis.Imps), ALLTRIM(csSigFiTef.cCupomnvs))
1022:                         SELECT crTmpNFis
1023:                         GO TOP
1024:                         loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
1025:                         loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
1026:                         loc_lnQtdVia  = crTmpNFis.nQtdVias
1027: 
1028:                         loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
1029:                         IF FILE(loc_lcArquivo)
1030:                             DELETE FILE (loc_lcArquivo)
1031:                         ENDIF
1032: 
1033:                         SELECT csSigFiTef
1034:                         loc_lcTipo = "CNC"
1035:                         TefImpr(csSigFiTef.cEmps, csSigFiTef.cDopes, VAL(csSigFiTef.cnCupoms), ;
1036:                                 loc_lcTipo, VAL(csSigFiTef.cnIdents), csSigFiTef.cNmRedes, ;
1037:                                 csSigFiTef.cnNSUs, csSigFiTef.cFinalzs, csSigFiTef.cCupomnvs, ;
1038:                                 csSigFiTef.Fpags, VAL(csSigFiTef.cnValors) / 100)
1039: 
1040:                         SELECT crTmpNFis
1041:                         loc_lcDirReq  = ALLTRIM(crTmpNFis.cTefdReqs)
1042:                         loc_lcDirResp = ALLTRIM(crTmpNFis.cTefdResps)
1043:                         loc_lnQtdVia  = crTmpNFis.nQtdVias
1044:                         loc_lcArquivo = LOWER(loc_lcDirResp + "IntPos.001")
1045: 

*-- Linhas 1146 a 1189:
1146:     ENDPROC
1147: 
1148:     *==========================================================================
1149:     PROTECTED PROCEDURE ProcCntTxt
1150:     *==========================================================================
1151:         LOCAL loc_cHeader, loc_lcTran, loc_nSistef, loc_cSQL, loc_oErro, loc_lContinuar
1152:         loc_lContinuar = .T.
1153:         TRY
1154:             IF !USED("crSigFiTef") OR EOF("crSigFiTef")
1155:                 loc_lContinuar = .F.
1156:             ENDIF
1157:             IF loc_lContinuar
1158: 
1159:             loc_nSistef = THIS.this_oBusinessObject.this_nSistef
1160:             SELECT crSigFiTef
1161: 
1162:             IF (ALLTRIM(crSigFiTef.cTpTrans) = "99" AND loc_nSistef = 1) OR loc_nSistef = 3
1163:                 loc_cHeader = SPACE(3)
1164:             ELSE
1165:                 loc_cHeader = crSigFiTef.cHeaders
1166:             ENDIF
1167: 
1168:             IF USED("crSigFiTra")
1169:                 USE IN crSigFiTra
1170:             ENDIF
1171:             loc_cSQL = "SELECT * FROM SigFiTra " + ;
1172:                        "WHERE cHeaders = " + EscaparSQL(ALLTRIM(loc_cHeader)) + ;
1173:                        " AND cTpTrans = " + EscaparSQL(ALLTRIM(crSigFiTef.cTpTrans))
1174:             IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigFiTra") > 0
1175:                 SELECT crSigFiTra
1176:                 GO TOP
1177:                 IF EOF() OR ALLTRIM(crSigFiTef.cTpTrans) = "99"
1178:                     loc_lcTran = "Outras"
1179:                 ELSE
1180:                     loc_lcTran = ALLTRIM(crSigFiTra.cTrans)
1181:                 ENDIF
1182:             ELSE
1183:                 loc_lcTran = "Outras"
1184:             ENDIF
1185: 
1186:             WITH THIS.cnt_4c_TefTxt
1187:                 .Top  = 35
1188:                 .Left = 2
1189:                 IF loc_nSistef = 1 OR loc_nSistef = 3

*-- Linhas 1217 a 1288:
1217:     ENDPROC
1218: 
1219:     *==========================================================================
1220:     PROTECTED PROCEDURE ExcluirTef(par_cIdent)
1221:     *==========================================================================
1222:         LOCAL loc_llChecaSigTef, loc_cChave, loc_oErro
1223:         loc_llChecaSigTef = .F.
1224:         TRY
1225:             IF !USED("SigTef")
1226:                 IF TYPE("goSistema") = "O" AND !EMPTY(goSistema.DirTefEcfs)
1227:                     USE (goSistema.DirTefEcfs + "\SigTef") IN 0
1228:                     loc_llChecaSigTef = .T.
1229:                 ENDIF
1230:             ENDIF
1231:             IF USED("SigTef")
1232:                 loc_cChave = "R" + go_4c_Sistema.cCodEmpresa + THIS.cOperacao + ALLTRIM(par_cIdent)
1233:                 =SEEK(loc_cChave, "SigTef", "Ident")
1234:                 SELECT SigTef
1235:                 IF !EOF("SigTef")
1236:                     DELETE IN SigTef
1237:                 ENDIF
1238:             ENDIF
1239:         CATCH TO loc_oErro
1240:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ExcluirTef")
1241:         ENDTRY
1242:         IF loc_llChecaSigTef AND USED("SigTef")
1243:             USE IN SigTef
1244:         ENDIF
1245:     ENDPROC
1246: 
1247:     *==========================================================================
1248:     PROTECTED PROCEDURE ImprFiscalProc(par_nIdent)
1249:     *==========================================================================
1250:         LOCAL loc_lRetCVinc, loc_lLoopCVinc, loc_lRetNImp, loc_lPrimeira, loc_lRetFim
1251:         LOCAL loc_lnValor, loc_lcCancTef, loc_lcNSUs, loc_lcTipo, loc_VerStatus
1252:         LOCAL loc_oFormulario, loc_lcRedes, loc_oErro
1253: 
1254:         TRY
1255:             IF USED("crSigFiFis")
1256:                 SELECT crSigFiFis
1257:                 GO TOP
1258:             ENDIF
1259: 
1260:             loc_oFormulario = THIS.this_oModem
1261: 
1262:             IF !EMPTY(THIS.cOperacao)
1263:                 loc_lRetCVinc  = .F.
1264:                 loc_lLoopCVinc = .T.
1265:                 loc_lPrimeira  = .T.
1266:                 loc_lRetFim    = .T.
1267: 
1268:                 DO WHILE loc_lLoopCVinc
1269:                     CLEAR TYPEAHEAD
1270:                     THIS.ProcCntTxt()
1271: 
1272:                     SELECT CrTefImp
1273:                     loc_lnValor = "0"
1274:                     GO TOP
1275:                     LOCATE FOR cinfos = " VALOR VENDA"
1276:                     IF EOF()
1277:                         LOCATE FOR cinfos = "    FINAL"
1278:                         IF !EOF()
1279:                             loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 10)), ",", ""), ".", "")
1280:                         ENDIF
1281:                     ELSE
1282:                         loc_lnValor = STRTRAN(STRTRAN(ALLTRIM(SUBSTR(cinfos, 16)), ",", ""), ".", "")
1283:                     ENDIF
1284:                     GO TOP
1285: 
1286:                     IF !loc_lPrimeira
1287:                         IF USED("crSigFiFis") AND UPPER(ALLTRIM(crSigFiFis.Imps)) = "SWEDA"
1288:                             loc_lRetFim = FinFimVinc(loc_oFormulario)

*-- Linhas 1365 a 1408:
1365:                             loc_VerStatus = RotStatus(1, loc_oFormulario)
1366:                             IF VARTYPE(loc_VerStatus) <> "L"
1367:                                 IF SUBSTR(loc_VerStatus, 6, 1) = "t"
1368:                                     MsgAviso("Encontrou-se no comando a string 'TOTAL'", "ERRO")
1369:                                     FinFimVinc(loc_oFormulario)
1370:                                     IF THIS.this_oBusinessObject.this_nSistef = 1
1371:                                         IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1372:                                                 go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1373:                                                 ALLTRIM(STR(par_nIdent, 20)))
1374:                                             SELECT crSigFiTef
1375:                                             DO FORM SIGCNTEF WITH crSigFiTef.cnNSUs, crSigFiTef.cNmRedes, ;
1376:                                                 VAL(loc_lnValor) / 100
1377:                                         ENDIF
1378:                                     ENDIF
1379:                                     IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1380:                                             go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1381:                                             ALLTRIM(STR(par_nIdent, 20)))
1382:                                         SELECT crSigFiTef
1383:                                         loc_lcTipo = "NCN"
1384:                                         TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
1385:                                                 loc_lcTipo, VAL(crSigFiTef.cnIdents), ;
1386:                                                 crSigFiTef.cNmRedes, crSigFiTef.cnNSUs, ;
1387:                                                 crSigFiTef.cFinalzs, crSigFiTef.cCupomnvs, ;
1388:                                                 crSigFiTef.FPags)
1389:                                         THIS.ExcluirTef(crSigFiTef.cnIdents)
1390:                                     ENDIF
1391:                                     loc_lLoopCVinc = .F.
1392:                                     loc_lRetCVinc  = .F.
1393:                                     LOOP
1394:                                 ENDIF
1395:                             ENDIF
1396:                         ENDIF
1397: 
1398:                         IF (THIS.this_oBusinessObject.this_nSistef = 1 AND ;
1399:                             !MsgConfirma("IMPRESSORA N" + CHR(195) + "O RESPONDE, TENTAR NOVAMENTE", "")) OR ;
1400:                            THIS.this_oBusinessObject.this_nSistef = 3
1401: 
1402:                             IF THIS.this_oBusinessObject.BuscarTransacaoTEF("R", ;
1403:                                     go_4c_Sistema.cCodEmpresa, THIS.cOperacao, ;
1404:                                     ALLTRIM(STR(par_nIdent, 20)))
1405:                                 SELECT crSigFiTef
1406:                                 loc_lcTipo = "NCN"
1407:                                 TefImpr(go_4c_Sistema.cCodEmpresa, THIS.cOperacao, 0, ;
1408:                                         loc_lcTipo, VAL(crSigFiTef.cnIdents), ;

*-- Linhas 1427 a 1651:
1427: 
1428:                 WAIT CLEAR
1429:             ELSE
1430:                 MsgAviso("Nenhuma Opera" + CHR(231) + CHR(227) + "o de Cupom Fiscal !!", "ERRO")
1431:             ENDIF
1432:         CATCH TO loc_oErro
1433:             WAIT CLEAR
1434:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro ImprFiscalProc")
1435:         ENDTRY
1436:     ENDPROC
1437: 
1438:     *==========================================================================
1439:     * ENTRADAS DE NOME CRUD - o legado SIGPRTEF NAO possui CRUD
1440:     *
1441:     * O SCX legado tem exatamente QUATRO acoes (Admin / Tef Ativo / Cancelar /
1442:     * Encerrar), todas ja ligadas aos seus proprios botoes em ConfigurarEventos.
1443:     * Nao ha grade, nao ha registro, nao ha Incluir / Alterar / Excluir: o dump
1444:     * de SIGPRTEF nao tem um unico BaseClass grid ou pageframe, nem AddCursor,
1445:     * pColuna, RecordSource ou ControlSource.
1446:     *
1447:     * Estes metodos existem porque o harness de teste os chama por NOME, de fora
1448:     * da classe (CLAUDE.md regra #3). Eles NAO podem disparar transacao TEF:
1449:     * CmdTefAdmClick / CmdTefAtvClick / CmdCancelarClick chamam SigFiTefReq(),
1450:     * que abre transacao REAL no gerenciador padrao, sem guarda de modo de teste.
1451:     * Acionar pagamento a partir de um nome "Incluir" ou "Salvar" seria efeito
1452:     * colateral invisivel ao operador. As operacoes TEF ficam exclusivamente nos
1453:     * quatro botoes reais, como no legado.
1454:     *==========================================================================
1455: 
1456:     *==========================================================================
1457:     * BtnIncluirClick / BtnAlterarClick / BtnSalvarClick / BtnBuscarClick
1458:     * Sem registro a manter nesta tela: devolvem o foco a unica entrada de
1459:     * dados existente (Rede TEF), de onde partem as quatro acoes do legado.
1460:     *==========================================================================
1461:     PROCEDURE BtnIncluirClick
1462:         THIS.FocarEntradaTef()
1463:     ENDPROC
1464: 
1465:     PROCEDURE BtnAlterarClick
1466:         THIS.FocarEntradaTef()
1467:     ENDPROC
1468: 
1469:     PROCEDURE BtnSalvarClick
1470:         THIS.FocarEntradaTef()
1471:     ENDPROC
1472: 
1473:     PROCEDURE BtnBuscarClick
1474:         THIS.FocarEntradaTef()
1475:     ENDPROC
1476: 
1477:     *==========================================================================
1478:     * BtnVisualizarClick - esta tela nao tem registro para visualizar.
1479:     * O painel de texto da transacao (cnt_4c_TefTxt) e governado EXCLUSIVAMENTE
1480:     * por ProcCntTxt, que reproduz o fluxo do legado (inclusive o 'If !empty()'
1481:     * por mensagem e a sobrescrita do caption de TxtCli). Forcar .Visible aqui
1482:     * exibiria painel vazio ou desatualizado, divergindo do legado.
1483:     *==========================================================================
1484:     PROCEDURE BtnVisualizarClick
1485:         THIS.FocarEntradaTef()
1486:     ENDPROC
1487: 
1488:     *==========================================================================
1489:     * BtnExcluirClick / BtnCancelarClick
1490:     * O legado nao tem Excluir, e o "Cancelar" dele (Command1) eh CANCELAMENTO
1491:     * DE TRANSACAO TEF, nao cancelamento de edicao - ja ligado ao proprio botao
1492:     * em ConfigurarEventos. Estes dois aliases tambem NAO podem fechar a tela:
1493:     * "Excluir"/"Cancelar" acionado por NOME derrubaria a janela do operador,
1494:     * o mesmo tipo de efeito colateral invisivel que esta secao proibe para as
1495:     * acoes TEF. Ficam inertes, como os demais aliases: so devolvem o foco.
1496:     *==========================================================================
1497:     PROCEDURE BtnExcluirClick
1498:         THIS.FocarEntradaTef()
1499:     ENDPROC
1500: 
1501:     PROCEDURE BtnCancelarClick
1502:         THIS.FocarEntradaTef()
1503:     ENDPROC
1504: 
1505:     *==========================================================================
1506:     * BtnEncerrarClick - alias do botao REAL "Encerrar" do legado (Sair.Click),
1507:     * unico nome CRUD cuja acao coincide com um botao existente na tela.
1508:     *==========================================================================
1509:     PROCEDURE BtnEncerrarClick
1510:         THIS.CmdEncerrarClick()
1511:     ENDPROC
1512: 
1513:     *==========================================================================
1514:     * FocarEntradaTef - devolve o foco ao campo Rede TEF
1515:     *==========================================================================
1516:     PROCEDURE FocarEntradaTef
1517:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1518:             IF THIS.txt_4c_Redetef.Enabled AND THIS.txt_4c_Redetef.Visible
1519:                 THIS.txt_4c_Redetef.SetFocus()
1520:             ENDIF
1521:         ENDIF
1522:     ENDPROC
1523: 
1524:     *==========================================================================
1525:     PROTECTED PROCEDURE FormParaBO
1526:     *==========================================================================
1527:         LOCAL loc_lSucesso
1528:         loc_lSucesso = .F.
1529:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1530:             THIS.this_oBusinessObject.this_cRedeTef = ;
1531:                 IIF(VARTYPE(THIS.txt_4c_Redetef) = "O", ;
1532:                     ALLTRIM(THIS.txt_4c_Redetef.Value), "")
1533:             loc_lSucesso = .T.
1534:         ENDIF
1535:         RETURN loc_lSucesso
1536:     ENDPROC
1537: 
1538:     *==========================================================================
1539:     PROTECTED PROCEDURE BOParaForm
1540:     *==========================================================================
1541:         LOCAL loc_lSucesso
1542:         loc_lSucesso = .F.
1543:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1544:             IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1545:                 THIS.txt_4c_Redetef.Value = ;
1546:                     IIF(EMPTY(THIS.this_oBusinessObject.this_cRedeTef), ;
1547:                         "", THIS.this_oBusinessObject.this_cRedeTef)
1548:                 THIS.txt_4c_Redetef.Refresh()
1549:             ENDIF
1550:             loc_lSucesso = .T.
1551:         ENDIF
1552:         RETURN loc_lSucesso
1553:     ENDPROC
1554: 
1555:     *==========================================================================
1556:     PROCEDURE HabilitarCampos(par_lHabilitar)
1557:     *==========================================================================
1558:         LOCAL loc_lHab, loc_lAdm, loc_lAtv
1559:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
1560: 
1561:         *-- Estado TEF vem do BO, escrito por InicializarEstadoTEF (fonte unica).
1562:         *-- Guard de VARTYPE obrigatorio: sem BO criado, ler a property estoura.
1563:         loc_lAdm = .F.
1564:         loc_lAtv = .F.
1565:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1566:             WITH THIS.this_oBusinessObject
1567:                 loc_lAdm = .this_lInicializado AND .this_lAcessoAdm
1568:                 loc_lAtv = .this_lInicializado AND .this_lAcessoAtv
1569:             ENDWITH
1570:         ENDIF
1571: 
1572:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1573:             THIS.txt_4c_Redetef.Enabled = loc_lHab
1574:         ENDIF
1575:         *-- Mesma condicao do legado (fChecaAcesso AND ok), agora preservada
1576:         *-- na reabilitacao em vez de desligar os dois botoes de acao.
1577:         IF VARTYPE(THIS.cmd_4c_TefAdm) = "O"
1578:             THIS.cmd_4c_TefAdm.Enabled = loc_lHab AND loc_lAdm
1579:         ENDIF
1580:         IF VARTYPE(THIS.cmd_4c_TefAtv) = "O"
1581:             THIS.cmd_4c_TefAtv.Enabled = loc_lHab AND loc_lAtv
1582:         ENDIF
1583:     ENDPROC
1584: 
1585:     *==========================================================================
1586:     PROCEDURE LimparCampos
1587:     *==========================================================================
1588:         IF VARTYPE(THIS.txt_4c_Redetef) = "O"
1589:             THIS.txt_4c_Redetef.Value = ""
1590:             THIS.txt_4c_Redetef.Refresh()
1591:         ENDIF
1592:         IF VARTYPE(THIS.cnt_4c_TefTxt) = "O"
1593:             WITH THIS.cnt_4c_TefTxt
1594:                 IF VARTYPE(.lbl_4c_TxtOper) = "O"
1595:                     .lbl_4c_TxtOper.Caption = ""
1596:                 ENDIF
1597:                 IF VARTYPE(.lbl_4c_TxtCli) = "O"
1598:                     .lbl_4c_TxtCli.Caption = ""
1599:                 ENDIF
1600:                 IF VARTYPE(.lbl_4c_TxtTpTrans) = "O"
1601:                     .lbl_4c_TxtTpTrans.Caption = ""
1602:                 ENDIF
1603:                 .Visible = .F.
1604:             ENDWITH
1605:         ENDIF
1606:         IF USED("CrTefImp")
1607:             USE IN CrTefImp
1608:         ENDIF
1609:         IF USED("CrTefResp")
1610:             USE IN CrTefResp
1611:         ENDIF
1612:         IF USED("CrTef")
1613:             USE IN CrTef
1614:         ENDIF
1615:         IF USED("crSigFiTra")
1616:             USE IN crSigFiTra
1617:         ENDIF
1618:         IF USED("CrSigFiNfs")
1619:             USE IN CrSigFiNfs
1620:         ENDIF
1621:         IF USED("csSigFiTef")
1622:             USE IN csSigFiTef
1623:         ENDIF
1624:         IF USED("crTmpNFis")
1625:             USE IN crTmpNFis
1626:         ENDIF
1627:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1628:             THIS.this_oBusinessObject.this_cRedeTef = ""
1629:         ENDIF
1630:     ENDPROC
1631: 
1632:     *==========================================================================
1633:     PROCEDURE CarregarLista
1634:     *==========================================================================
1635:         *-- Form OPERACIONAL TEF: sem lista de registros CRUD.
1636:         *-- InicializarEstadoTEF gerencia o carregamento de dados transacionais.
1637:         RETURN .T.
1638:     ENDPROC
1639: 
1640:     *==========================================================================
1641:     PROCEDURE AjustarBotoesPorModo
1642:     *==========================================================================
1643:         *-- Form OPERACIONAL TEF: sem modos CRUD (INCLUIR/ALTERAR/VISUALIZAR).
1644:         *-- Ainda assim este eh o FUNIL de reabilitacao (regra #40): recalcula
1645:         *-- a condicao do legado (fChecaAcesso AND impressora OK) a partir do
1646:         *-- estado guardado no BO, sem efeito colateral e sem transacao TEF.
1647:         THIS.HabilitarCampos(.T.)
1648:         RETURN .T.
1649:     ENDPROC
1650: 
1651: ENDDEFINE


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
                       "(Tabela, Operacao, Usuario, DataHora, ChaveRegistro) " + ;
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

