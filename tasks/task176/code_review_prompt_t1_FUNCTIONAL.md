# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (5)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRENV): Top original=179 vs migrado 'obj_4c_Opt_Tipo' Top=10 (diff=169px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRENV): Left original=140 vs migrado 'obj_4c_Opt_Tipo' Left=10 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRENV): Top original=180 vs migrado 'obj_4c_Opt_Impressora' Top=10 (diff=170px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRENV): Left original=396 vs migrado 'obj_4c_Opt_Impressora' Left=10 (diff=386px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1228 linhas total):

*-- Linhas 15 a 142:
15:     this_oBusinessObject = .NULL.
16: 
17:     *--------------------------------------------------------------------------
18:     PROCEDURE Init()
19:     *--------------------------------------------------------------------------
20:         RETURN DODEFAULT()
21:     ENDPROC
22: 
23:     *--------------------------------------------------------------------------
24:     * InicializarForm - Cria BO e layout base
25:     * Chamado por FormBase.Init() via DODEFAULT()
26:     *--------------------------------------------------------------------------
27:     PROTECTED PROCEDURE InicializarForm()
28:         LOCAL loc_lSucesso, loc_oErro
29:         loc_lSucesso = .F.
30: 
31:         TRY
32:             *-- Propriedades visuais do form (original: 800x400 flat, sem titlebar)
33:             THIS.Width       = 1000
34:             THIS.Height      = 500
35:             THIS.AutoCenter  = .T.
36:             THIS.BorderStyle = 2
37:             THIS.TitleBar    = 0
38:             THIS.ControlBox  = .F.
39:             THIS.MaxButton   = .F.
40:             THIS.MinButton   = .F.
41:             THIS.WindowType  = 1
42:             THIS.ShowTips    = .T.
43:             THIS.FontName    = "Tahoma"
44:             THIS.FontSize    = 8
45:             THIS.Caption     = "Impress" + CHR(227) + "o de etiquetas de envelopes"
46: 
47:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
48:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
49:             ENDIF
50: 
51:             *-- Criar Business Object
52:             THIS.this_oBusinessObject = CREATEOBJECT("sigprenvBO")
53:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
54:                 *-- Layout base
55:                 THIS.ConfigurarPageFrame()
56:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 THIS.TornarControlesVisiveis(THIS)
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarDados()
63:                 ENDIF
64: 
65:                 loc_lSucesso = .T.
66:             ELSE
67:                 MsgErro("Erro ao criar sigprenvBO.", "Erro")
68:             ENDIF
69: 
70:         CATCH TO loc_oErro
71:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
72:                     " PROC=" + loc_oErro.Procedure, "Erro ao inicializar form")
73:             loc_lSucesso = .F.
74:         ENDTRY
75: 
76:         RETURN loc_lSucesso
77:     ENDPROC
78: 
79:     *--------------------------------------------------------------------------
80:     * ConfigurarPageFrame - Orquestra layout do form OPERACIONAL (flat)
81:     * Form OPERACIONAL nao tem PageFrame - "PaginaLista" agrupa botoes de acao
82:     * (CommandGroup Imprimir/Encerrar) e "PaginaDados" agrupa campos de entrada
83:     * (Etiqueta Inicial/Quantidade, Tipo de Etiqueta, Impressora, Ajustes).
84:     *--------------------------------------------------------------------------
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         THIS.ConfigurarCabecalho()
87:         THIS.ConfigurarPaginaLista()
88:         THIS.ConfigurarPaginaDados()
89:     ENDPROC
90: 
91:     *--------------------------------------------------------------------------
92:     * AlternarPagina - Form OPERACIONAL nao alterna paginas (compatibilidade FormBase)
93:     *--------------------------------------------------------------------------
94:     PROCEDURE AlternarPagina(par_nPagina)
95:         RETURN .T.
96:     ENDPROC
97: 
98:     *--------------------------------------------------------------------------
99:     * ConfigurarCabecalho - Container cntSombra do original
100:     * Top=0, Left=0, Width=800, Height=80, BackColor=100,100,100
101:     *--------------------------------------------------------------------------
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH THIS.cnt_4c_Cabecalho
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Top       = 18
117:                 .Left      = 10
118:                 .Width     = THIS.Width
119:                 .Height    = 40
120:                 .AutoSize  = .F.
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 18
123:                 .FontBold  = .T.
124:                 .WordWrap  = .T.
125:                 .Alignment = 0
126:                 .BackStyle = 0
127:                 .ForeColor = RGB(0, 0, 0)
128:                 .Caption   = THIS.Caption
129:                 .Visible   = .T.
130:             ENDWITH
131: 
132:             .AddObject("lbl_4c_Titulo", "Label")
133:             WITH .lbl_4c_Titulo
134:                 .Top       = 17
135:                 .Left      = 10
136:                 .Width     = THIS.Width
137:                 .Height    = 46
138:                 .AutoSize  = .F.
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 18
141:                 .FontBold  = .T.
142:                 .WordWrap  = .T.

*-- Linhas 150 a 214:
150:     ENDPROC
151: 
152:     *--------------------------------------------------------------------------
153:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
154:     *--------------------------------------------------------------------------
155:     PROCEDURE TornarControlesVisiveis(par_oContainer)
156:         LOCAL loc_i, loc_oControl
157:         FOR loc_i = 1 TO par_oContainer.ControlCount
158:             loc_oControl = par_oContainer.Controls(loc_i)
159:             IF VARTYPE(loc_oControl) = "O"
160:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
161:                     loc_oControl.Visible = .T.
162:                 ENDIF
163:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
164:                     THIS.TornarControlesVisiveis(loc_oControl)
165:                 ENDIF
166:             ENDIF
167:         ENDFOR
168:     ENDPROC
169: 
170:     *--------------------------------------------------------------------------
171:     * ConfigurarPaginaLista - Adiciona controles principais do form OPERACIONAL
172:     * Botoes Imprimir/Encerrar, campos de etiqueta, tipos e sele??o de impressora
173:     *--------------------------------------------------------------------------
174:     PROTECTED PROCEDURE ConfigurarPaginaLista()
175:         LOCAL loc_oErro
176:         TRY
177:             *-- CommandGroup: Imprimir + Encerrar (lado direito, topo)
178:             THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
179:             WITH THIS.obj_4c_BtnReport
180:                 .Top           = 0
181:                 .Left          = 820
182:                 .Width         = 171
183:                 .Height        = 110
184:                 .BackStyle     = 0
185:                 .BorderStyle   = 0
186:                 .SpecialEffect = 1
187:                 .Themes        = .F.
188:                 .ButtonCount   = 2
189:                 .Visible       = .T.
190: 
191:                 WITH .Buttons(1)
192:                     .Caption         = "\<Imprimir"
193:                     .Top             = 5
194:                     .Left            = 10
195:                     .Width           = 75
196:                     .Height          = 75
197:                     .FontBold        = .T.
198:                     .FontItalic      = .T.
199:                     .ForeColor       = RGB(90, 90, 90)
200:                     .BackColor       = RGB(255, 255, 255)
201:                     .Themes          = .F.
202:                     .Picture         = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
203:                     .PicturePosition = 13
204:                     .WordWrap        = .T.
205:                     .MousePointer    = 15
206:                 ENDWITH
207: 
208:                 WITH .Buttons(2)
209:                     .Caption         = "Encerrar"
210:                     .Top             = 5
211:                     .Left            = 86
212:                     .Width           = 75
213:                     .Height          = 75
214:                     .FontName        = "Comic Sans MS"

*-- Linhas 242 a 321:
242:                 .Visible   = .T.
243:             ENDWITH
244: 
245:             *-- OptionGroup Impressora (ButtonCount dinamico - populado em CarregarDados)
246:             THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
247:             WITH THIS.obj_4c_Opt_Impressora
248:                 .Top           = 180
249:                 .Left          = 396
250:                 .Width         = 254
251:                 .Height        = 30
252:                 .BackStyle     = 0
253:                 .SpecialEffect = 1
254:                 .Themes        = .F.
255:                 .ButtonCount   = 1
256:                 .Value         = 1
257:                 .Enabled       = .F.
258:                 .Visible       = .T.
259:                 WITH .Buttons(1)
260:                     .BackStyle = 0
261:                     .ForeColor = RGB(90, 90, 90)
262:                     .Caption   = "1. Gen" + CHR(233) + "rico/Somente Texto"
263:                     .Height    = 17
264:                     .Left      = 10
265:                     .Top       = 10
266:                     .Width     = 238
267:                 ENDWITH
268:             ENDWITH
269: 
270:             *-- Container de configuracoes da impressora (Cnt_Impressora)
271:             THIS.AddObject("cnt_4c__Impressora", "Container")
272:             WITH THIS.cnt_4c__Impressora
273:                 .Top       = 289
274:                 .Left      = 396
275:                 .Width     = 254
276:                 .Height    = 67
277:                 .BackStyle = 0
278:                 .Visible   = .T.
279: 
280:                 *-- OptionGroup tipo de impressao: Allegro / Zebra ZPL / Zebra EPL
281:                 .AddObject("obj_4c_Opcao_imp", "OptionGroup")
282:                 WITH .obj_4c_Opcao_imp
283:                     .Top         = 3
284:                     .Left        = 3
285:                     .Width       = 249
286:                     .Height      = 22
287:                     .BackStyle   = 0
288:                     .ButtonCount = 3
289:                     .Value       = 1
290:                     .Visible     = .T.
291:                     WITH .Buttons(1)
292:                         .BackStyle = 0
293:                         .ForeColor = RGB(90, 90, 90)
294:                         .Caption   = "Allegro"
295:                         .Left      = 3
296:                         .Top       = 4
297:                         .Width     = 51
298:                     ENDWITH
299:                     WITH .Buttons(2)
300:                         .FontName  = "Tahoma"
301:                         .FontSize  = 8
302:                         .BackStyle = 0
303:                         .ForeColor = RGB(90, 90, 90)
304:                         .Caption   = "Zebra ZPL"
305:                         .Left      = 77
306:                         .Top       = 4
307:                         .Width     = 66
308:                         .Themes    = .F.
309:                     ENDWITH
310:                     WITH .Buttons(3)
311:                         .FontName  = "Tahoma"
312:                         .FontSize  = 8
313:                         .BackStyle = 0
314:                         .ForeColor = RGB(90, 90, 90)
315:                         .Caption   = "Zebra EPL"
316:                         .Left      = 170
317:                         .Top       = 4
318:                         .Width     = 66
319:                         .Themes    = .F.
320:                     ENDWITH
321:                 ENDWITH

*-- Linhas 436 a 497:
436:                 ENDWITH
437:             ENDWITH
438: 
439:             *-- BINDEVENTs de botoes e selecao de impressora
440:             BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "BtnImprimeClick")
441:             BINDEVENT(THIS.obj_4c_BtnReport.Buttons(2), "Click", THIS, "BtnEncerrarClick")
442:             BINDEVENT(THIS.obj_4c_Opt_Impressora, "InteractiveChange", THIS, "OptImpressoraInteractiveChange")
443: 
444:         CATCH TO loc_oErro
445:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
446:                     " PROC=" + loc_oErro.Procedure, "Erro ao configurar layout")
447:         ENDTRY
448:     ENDPROC
449: 
450:     *--------------------------------------------------------------------------
451:     * ConfigurarPaginaDados - Adiciona campos de entrada de dados do form
452:     * Form OPERACIONAL flat: agrupa campos de entrada (Etiqueta Inicial/Quantidade,
453:     * OptionGroup Tipo de Etiqueta). Impressora + Container de ajustes ficam em
454:     * ConfigurarPaginaLista (junto com botoes de acao) por serem parte do bloco
455:     * de configuracao de impressao.
456:     *--------------------------------------------------------------------------
457:     PROTECTED PROCEDURE ConfigurarPaginaDados()
458:         LOCAL loc_oErro
459:         TRY
460:             *-- Label "Etiqueta Inicial :"
461:             THIS.AddObject("lbl_4c_Lbl_Etq", "Label")
462:             WITH THIS.lbl_4c_Lbl_Etq
463:                 .Top       = 129
464:                 .Left      = 155
465:                 .AutoSize  = .T.
466:                 .FontName  = "Tahoma"
467:                 .FontSize  = 8
468:                 .BackStyle = 0
469:                 .ForeColor = RGB(90, 90, 90)
470:                 .Caption   = "Etiqueta Inicial :"
471:                 .Visible   = .T.
472:             ENDWITH
473: 
474:             *-- TextBox Etiqueta Inicial (valor inicial da numeracao das etiquetas)
475:             THIS.AddObject("txt_4c_Etq_Ini", "TextBox")
476:             WITH THIS.txt_4c_Etq_Ini
477:                 .Top                = 125
478:                 .Left               = 237
479:                 .Width              = 66
480:                 .Height             = 23
481:                 .FontName           = "Tahoma"
482:                 .InputMask          = "99999999"
483:                 .DisabledBackColor  = RGB(255, 255, 255)
484:                 .Value              = 1
485:                 .Visible            = .T.
486:             ENDWITH
487: 
488:             *-- Label "Quantidade :"
489:             THIS.AddObject("lbl_4c_Lbl_Qtd", "Label")
490:             WITH THIS.lbl_4c_Lbl_Qtd
491:                 .Top       = 129
492:                 .Left      = 328
493:                 .AutoSize  = .T.
494:                 .FontName  = "Tahoma"
495:                 .FontSize  = 8
496:                 .BackStyle = 0
497:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 530 a 608:
530:                 .Visible   = .T.
531:             ENDWITH
532: 
533:             *-- OptionGroup Tipo de Etiqueta (ButtonCount dinamico - populado em CarregarDados)
534:             THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
535:             WITH THIS.obj_4c_Opt_Tipo
536:                 .Top           = 179
537:                 .Left          = 140
538:                 .Width         = 240
539:                 .Height        = 30
540:                 .BackStyle     = 0
541:                 .SpecialEffect = 1
542:                 .Themes        = .F.
543:                 .ButtonCount   = 1
544:                 .Value         = 1
545:                 .Enabled       = .F.
546:                 .Visible       = .T.
547:                 WITH .Buttons(1)
548:                     .BackStyle = 0
549:                     .ForeColor = RGB(90, 90, 90)
550:                     .Caption   = ""
551:                     .Height    = 22
552:                     .Left      = 10
553:                     .Top       = 10
554:                     .Width     = 222
555:                 ENDWITH
556:             ENDWITH
557: 
558:         CATCH TO loc_oErro
559:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
560:                     " PROC=" + loc_oErro.Procedure, "Erro ao configurar campos de dados")
561:         ENDTRY
562:     ENDPROC
563: 
564:     *--------------------------------------------------------------------------
565:     * CarregarDados - Popula controles dinamicos (tipos de etiqueta e impressoras)
566:     * Executa queries SQL e constroi buttons dos OptionGroups dinamicamente
567:     *--------------------------------------------------------------------------
568:     PROCEDURE CarregarDados()
569:         LOCAL loc_oErro, loc_laPrinters(1, 2), loc_nPrinters
570:         LOCAL loc_nTipos, loc_nI, loc_nTop, loc_nHeight
571:         LOCAL loc_nBottom1, loc_nBottom2, loc_nImpres, loc_nOk, loc_nPIdx
572:         LOCAL loc_cCaption, loc_cTag, loc_cImpres, loc_laImpOk(1), loc_nJ
573: 
574:         TRY
575:             *-- Carregar configuracoes de SigCdPam e SigCdPac
576:             THIS.this_oBusinessObject.CarregarConfiguracoes()
577:             THIS.this_oBusinessObject.CarregarTiposEtiqueta()
578: 
579:             *-- Construir botoes de tipo de etiqueta
580:             loc_nTop    = 10
581:             loc_nHeight = 40
582: 
583:             IF THIS.this_oBusinessObject.this_lTiposOk
584:                 loc_nTipos = THIS.this_oBusinessObject.this_nTotalTipos
585:                 THIS.obj_4c_Opt_Tipo.ButtonCount = ;
586:                     MIN(loc_nTipos, MAX(THIS.this_oBusinessObject.this_nMaxTpEtis, 5))
587: 
588:                 SELECT cursor_4c_SigCdTpe
589:                 GO TOP
590:                 loc_nI = 1
591:                 SCAN WHILE loc_nI <= THIS.obj_4c_Opt_Tipo.ButtonCount
592:                     loc_cCaption = "\<" + CHR(96 + loc_nI) + ". " + ALLTRIM(cursor_4c_SigCdTpe.cetiquetas)
593:                     loc_cTag     = ALLTRIM(STR(cursor_4c_SigCdTpe.ntipos))
594:                     WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
595:                         .AutoSize  = .F.
596:                         .Width     = 160
597:                         .Caption   = loc_cCaption
598:                         .FontSize  = 8
599:                         .Tag       = loc_cTag
600:                         .Top       = loc_nTop
601:                         .FontName  = "Tahoma"
602:                         .BackStyle = 0
603:                         .ForeColor = RGB(90, 90, 90)
604:                     ENDWITH
605:                     loc_nTop    = loc_nTop + 20
606:                     loc_nHeight = loc_nHeight + 20
607:                     loc_nI      = loc_nI + 1
608:                 ENDSCAN

*-- Linhas 745 a 1228:
745:             THIS.Height = MAX(loc_nBottom1, loc_nBottom2) + 20
746: 
747:             *-- Carregar configuracoes da primeira impressora selecionada
748:             THIS.OptImpressoraInteractiveChange()
749: 
750:         CATCH TO loc_oErro
751:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
752:                     " PROC=" + loc_oErro.Procedure, "Erro ao carregar dados")
753:         ENDTRY
754:     ENDPROC
755: 
756:     *--------------------------------------------------------------------------
757:     * BtnImprimeClick - Valida e executa a impressao de etiquetas de envelope
758:     * Chama SigOpEtq do Framework via proxy pnIdconn
759:     *--------------------------------------------------------------------------
760:     PROCEDURE BtnImprimeClick()
761:         LOCAL loc_lSucesso, loc_oErro, loc_nIni, loc_nQtd
762:         LOCAL loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos
763:         LOCAL loc_cNomeImp, loc_nImpres, loc_oDataMgr
764:         loc_lSucesso = .F.
765: 
766:         TRY
767:             loc_nQtd = THIS.txt_4c_Etq_Qtd.Value
768: 
769:             IF loc_nQtd <= 0
770:                 MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!")
771:                 THIS.txt_4c_Etq_Qtd.SetFocus()
772:             ELSE
773:                 IF MsgConfirma("Confirma a Impress" + CHR(227) + "o Das Etiquetas ?", "Confirmar")
774:                     loc_nIni = THIS.txt_4c_Etq_Ini.Value
775: 
776:                     IF THIS.this_oBusinessObject.PrepararCursorImpressao(loc_nIni, loc_nQtd)
777:                         *-- Obter configuracoes de impressao atuais
778:                         WITH THIS.cnt_4c__Impressora
779:                             loc_nTpImp   = .obj_4c_Opcao_imp.Value
780:                             loc_nAjVerts = .obj_4c_Spn_AjVerts.Value
781:                             loc_nAjHorzs = .obj_4c_Spn_AjHorzs.Value
782:                             loc_nAjDenss = .obj_4c_Spn_AjDenss.Value
783:                             loc_nAjVelos = .obj_4c_Spn_AjVelos.Value
784:                             .Visible     = .T.
785:                         ENDWITH
786: 
787:                         loc_nImpres  = THIS.obj_4c_Opt_Impressora.Value
788:                         loc_cNomeImp = THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag
789: 
790:                         *-- Proxy minimo para compatibilidade com SigOpEtq (espera pnIdconn)
791:                         loc_oDataMgr = CREATEOBJECT("Empty")
792:                         ADDPROPERTY(loc_oDataMgr, "pnIdconn", gnConnHandle)
793:                         ADDPROPERTY(loc_oDataMgr, "pnIdConn", gnConnHandle)
794: 
795:                         *-- Executar impressao via funcao do Framework (requer SigOpEtq.prg)
796:                         SigOpEtq(loc_oDataMgr, .F., .F., 6, ;
797:                                  loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, ;
798:                                  .NULL., .NULL., .NULL., loc_cNomeImp, .NULL., .NULL., loc_nAjVelos)
799: 
800:                         MsgInfo("Impress" + CHR(227) + "o conclu" + CHR(237) + "da com sucesso!")
801: 
802:                         *-- Atualizar etiqueta inicial e zerar quantidade
803:                         THIS.txt_4c_Etq_Ini.Value = loc_nIni + loc_nQtd
804:                         THIS.txt_4c_Etq_Qtd.Value = 0
805:                         THIS.txt_4c_Etq_Ini.Refresh()
806:                         THIS.txt_4c_Etq_Qtd.Refresh()
807: 
808:                         THIS.this_oBusinessObject.LimparCursorImpressao()
809:                         THIS.txt_4c_Etq_Qtd.SetFocus()
810:                         loc_lSucesso = .T.
811:                     ENDIF
812:                 ENDIF
813:             ENDIF
814: 
815:         CATCH TO loc_oErro
816:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
817:                     " PROC=" + loc_oErro.Procedure, "Erro ao imprimir etiquetas")
818:         ENDTRY
819:         RETURN loc_lSucesso
820:     ENDPROC
821: 
822:     *--------------------------------------------------------------------------
823:     * BtnEncerrarClick - Fecha o formulario
824:     *--------------------------------------------------------------------------
825:     PROCEDURE BtnEncerrarClick()
826:         THIS.Release()
827:     ENDPROC
828: 
829:     *--------------------------------------------------------------------------
830:     * OptImpressoraInteractiveChange - Atualiza spinners ao trocar impressora
831:     *--------------------------------------------------------------------------
832:     PROCEDURE OptImpressoraInteractiveChange()
833:         LOCAL loc_oErro, loc_nImpres, loc_cNomeImp, loc_lValido
834:         loc_lValido = .F.
835: 
836:         TRY
837:             IF VARTYPE(THIS.obj_4c_Opt_Impressora) = "O"
838:                 loc_nImpres = THIS.obj_4c_Opt_Impressora.Value
839:                 IF loc_nImpres >= 1 AND loc_nImpres <= THIS.obj_4c_Opt_Impressora.ButtonCount
840:                     loc_cNomeImp = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
841:                     IF !EMPTY(loc_cNomeImp)
842:                         THIS.this_oBusinessObject.CarregarConfigImpressora(loc_cNomeImp)
843:                         WITH THIS.cnt_4c__Impressora
844:                             .obj_4c_Opcao_imp.Value   = THIS.this_oBusinessObject.this_nTpImp
845:                             .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
846:                             .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
847:                             .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
848:                             .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
849:                             .Visible     = .T.
850:                         ENDWITH
851:                         loc_lValido = .T.
852:                     ENDIF
853:                 ENDIF
854:             ENDIF
855: 
856:         CATCH TO loc_oErro
857:             MsgErro(loc_oErro.Message, ;
858:                     "Erro ao carregar configura" + CHR(231) + CHR(245) + "es da impressora")
859:         ENDTRY
860:     ENDPROC
861: 
862:     *--------------------------------------------------------------------------
863:     * BtnIncluirClick - Iniciar nova impressao (form OPERACIONAL)
864:     * Mapeia para: incluir novo lote de etiquetas na fila de impressao.
865:     * Zera a quantidade, avanca a etiqueta inicial para o proximo bloco livre
866:     * e devolve o foco para o campo Quantidade.
867:     *--------------------------------------------------------------------------
868:     PROCEDURE BtnIncluirClick()
869:         LOCAL loc_oErro, loc_nProxIni
870: 
871:         TRY
872:             *-- Se ha quantidade digitada, avancar a etiqueta inicial
873:             IF THIS.txt_4c_Etq_Qtd.Value > 0
874:                 loc_nProxIni = THIS.txt_4c_Etq_Ini.Value + THIS.txt_4c_Etq_Qtd.Value
875:                 THIS.txt_4c_Etq_Ini.Value = loc_nProxIni
876:             ENDIF
877: 
878:             *-- Zerar quantidade para novo lote
879:             THIS.txt_4c_Etq_Qtd.Value = 0
880:             THIS.txt_4c_Etq_Ini.Refresh()
881:             THIS.txt_4c_Etq_Qtd.Refresh()
882: 
883:             *-- Habilitar campos de entrada
884:             THIS.txt_4c_Etq_Ini.Enabled = .T.
885:             THIS.txt_4c_Etq_Qtd.Enabled = .T.
886: 
887:             *-- Liberar cursor de impressao previa (se houver)
888:             THIS.this_oBusinessObject.LimparCursorImpressao()
889: 
890:             *-- Focar quantidade para digitacao
891:             THIS.txt_4c_Etq_Qtd.SetFocus()
892: 
893:         CATCH TO loc_oErro
894:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
895:                     " PROC=" + loc_oErro.Procedure, "Erro ao iniciar novo lote")
896:         ENDTRY
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------
900:     * BtnAlterarClick - Alterar parametros de impressao (form OPERACIONAL)
901:     * Mapeia para: habilitar edicao dos ajustes (spinners) e OptionGroup de
902:     * tipo de impressao para que o usuario possa modificar os valores padrao
903:     * carregados de SigCdPam/SigCdPac antes de imprimir.
904:     *--------------------------------------------------------------------------
905:     PROCEDURE BtnAlterarClick()
906:         LOCAL loc_oErro
907: 
908:         TRY
909:             *-- Habilitar campos de entrada
910:             THIS.txt_4c_Etq_Ini.Enabled = .T.
911:             THIS.txt_4c_Etq_Qtd.Enabled = .T.
912: 
913:             *-- Habilitar OptionGroups de tipo de etiqueta e impressora
914:             IF THIS.obj_4c_Opt_Tipo.ButtonCount > 1
915:                 THIS.obj_4c_Opt_Tipo.Enabled = .T.
916:             ENDIF
917:             IF THIS.obj_4c_Opt_Impressora.ButtonCount > 1
918:                 THIS.obj_4c_Opt_Impressora.Enabled = .T.
919:             ENDIF
920: 
921:             *-- Habilitar ajustes da impressora (spinners e tipo de impressao)
922:             WITH THIS.cnt_4c__Impressora
923:                 .obj_4c_Opcao_imp.Enabled  = .T.
924:                 .obj_4c_Spn_AjVerts.Enabled = .T.
925:                 .obj_4c_Spn_AjHorzs.Enabled = .T.
926:                 .obj_4c_Spn_AjDenss.Enabled = .T.
927:                 .obj_4c_Spn_AjVelos.Enabled = .T.
928:                 .Visible     = .T.
929:             ENDWITH
930: 
931:             *-- Focar tipo de impressao para inicio da alteracao
932:             THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.SetFocus()
933: 
934:         CATCH TO loc_oErro
935:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
936:                     " PROC=" + loc_oErro.Procedure, "Erro ao habilitar altera" + CHR(231) + CHR(227) + "o")
937:         ENDTRY
938:     ENDPROC
939: 
940:     *--------------------------------------------------------------------------
941:     * BtnVisualizarClick - Visualizar impressao (form OPERACIONAL)
942:     * Mapeia para: preparar o cursor de impressao sem enviar para a impressora
943:     * e apresentar ao usuario o resumo do que sera impresso (faixa de etiquetas
944:     * + tipo + impressora destino).
945:     *--------------------------------------------------------------------------
946:     PROCEDURE BtnVisualizarClick()
947:         LOCAL loc_oErro, loc_nIni, loc_nQtd, loc_nFim
948:         LOCAL loc_cResumo, loc_nImpres, loc_cNomeImp, loc_cTpImp
949:         LOCAL loc_nTipoEtq
950: 
951:         TRY
952:             loc_nIni = THIS.txt_4c_Etq_Ini.Value
953:             loc_nQtd = THIS.txt_4c_Etq_Qtd.Value
954: 
955:             IF loc_nQtd <= 0
956:                 MsgAviso("Informe uma quantidade maior que 0 (zero) para visualizar.")
957:                 THIS.txt_4c_Etq_Qtd.SetFocus()
958:             ELSE
959:                 *-- Preparar cursor sem imprimir (mesma logica do BtnImprime, sem SigOpEtq)
960:                 IF THIS.this_oBusinessObject.PrepararCursorImpressao(loc_nIni, loc_nQtd)
961:                     loc_nFim     = loc_nIni + loc_nQtd - 1
962:                     loc_nImpres  = THIS.obj_4c_Opt_Impressora.Value
963:                     loc_cNomeImp = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
964:                     loc_nTipoEtq = THIS.obj_4c_Opt_Tipo.Value
965: 
966:                     DO CASE
967:                         CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 1
968:                             loc_cTpImp = "Allegro"
969:                         CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 2
970:                             loc_cTpImp = "Zebra ZPL"
971:                         CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 3
972:                             loc_cTpImp = "Zebra EPL"
973:                         OTHERWISE
974:                             loc_cTpImp = "N" + CHR(227) + "o definido"
975:                     ENDCASE
976: 
977:                     loc_cResumo = "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o da impress" + CHR(227) + "o" + CHR(13) + CHR(13) + ;
978:                                   "Etiqueta inicial : " + TRANSFORM(loc_nIni) + CHR(13) + ;
979:                                   "Etiqueta final   : " + TRANSFORM(loc_nFim) + CHR(13) + ;
980:                                   "Quantidade       : " + TRANSFORM(loc_nQtd) + CHR(13) + ;
981:                                   "Tipo de etiqueta : " + ALLTRIM(TRANSFORM(loc_nTipoEtq)) + CHR(13) + ;
982:                                   "Modo de impress" + CHR(227) + "o: " + loc_cTpImp + CHR(13) + ;
983:                                   "Impressora       : " + loc_cNomeImp
984: 
985:                     MsgInfo(loc_cResumo, "Visualiza" + CHR(231) + CHR(227) + "o")
986: 
987:                     *-- Liberar cursor apos preview (usuario ainda pode confirmar impressao)
988:                     THIS.this_oBusinessObject.LimparCursorImpressao()
989:                 ENDIF
990:             ENDIF
991: 
992:         CATCH TO loc_oErro
993:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
994:                     " PROC=" + loc_oErro.Procedure, "Erro ao visualizar impress" + CHR(227) + "o")
995:         ENDTRY
996:     ENDPROC
997: 
998:     *--------------------------------------------------------------------------
999:     * BtnExcluirClick - Cancelar/limpar impressao em andamento (form OPERACIONAL)
1000:     * Mapeia para: descartar cursor de impressao ja preparado e restaurar
1001:     * valores padrao de spinners e OptionGroups (mesmo comportamento do
1002:     * legado quando o usuario abandona o processo).
1003:     *--------------------------------------------------------------------------
1004:     PROCEDURE BtnExcluirClick()
1005:         LOCAL loc_oErro
1006: 
1007:         TRY
1008:             IF MsgConfirma("Cancelar a impress" + CHR(227) + "o e limpar os valores digitados ?", ;
1009:                            "Confirmar cancelamento")
1010:                 *-- Descartar cursor de impressao
1011:                 THIS.this_oBusinessObject.LimparCursorImpressao()
1012: 
1013:                 *-- Restaurar valores padrao dos campos de entrada
1014:                 THIS.txt_4c_Etq_Ini.Value = 1
1015:                 THIS.txt_4c_Etq_Qtd.Value = 0
1016:                 THIS.txt_4c_Etq_Ini.Refresh()
1017:                 THIS.txt_4c_Etq_Qtd.Refresh()
1018: 
1019:                 *-- Restaurar valores padrao dos ajustes (SigCdPam/SigCdPac)
1020:                 WITH THIS.cnt_4c__Impressora
1021:                     .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVertsPad
1022:                     .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzsPad
1023:                     .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDensPad
1024:                     .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelosPad
1025:                     .obj_4c_Opcao_imp.Value   = IIF(THIS.this_oBusinessObject.this_nImpEtis <> 0, ;
1026:                                                     THIS.this_oBusinessObject.this_nImpEtis, 1)
1027:                     .Visible     = .T.
1028:                 ENDWITH
1029: 
1030:                 *-- Voltar OptionGroups ao primeiro item
1031:                 IF THIS.obj_4c_Opt_Tipo.ButtonCount >= 1
1032:                     THIS.obj_4c_Opt_Tipo.Value = 1
1033:                 ENDIF
1034:                 IF THIS.obj_4c_Opt_Impressora.ButtonCount >= 1
1035:                     THIS.obj_4c_Opt_Impressora.Value = 1
1036:                     THIS.OptImpressoraInteractiveChange()
1037:                 ENDIF
1038: 
1039:                 *-- Devolver foco para inicio do fluxo
1040:                 THIS.txt_4c_Etq_Qtd.SetFocus()
1041:             ENDIF
1042: 
1043:         CATCH TO loc_oErro
1044:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1045:                     " PROC=" + loc_oErro.Procedure, "Erro ao cancelar impress" + CHR(227) + "o")
1046:         ENDTRY
1047:     ENDPROC
1048: 
1049:     *--------------------------------------------------------------------------
1050:     * FormParaBO - Transfere valores do form para o Business Object
1051:     *--------------------------------------------------------------------------
1052:     PROTECTED PROCEDURE FormParaBO()
1053:         LOCAL loc_nTipoVal, loc_nImpVal
1054: 
1055:         THIS.this_oBusinessObject.this_nEtqIni = THIS.txt_4c_Etq_Ini.Value
1056:         THIS.this_oBusinessObject.this_nEtqQtd = THIS.txt_4c_Etq_Qtd.Value
1057: 
1058:         loc_nTipoVal = THIS.obj_4c_Opt_Tipo.Value
1059:         THIS.this_oBusinessObject.this_nTipoEtq = loc_nTipoVal
1060:         IF loc_nTipoVal >= 1 AND loc_nTipoVal <= THIS.obj_4c_Opt_Tipo.ButtonCount
1061:             THIS.this_oBusinessObject.this_cTagTipoEtq = ;
1062:                 ALLTRIM(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipoVal).Tag)
1063:         ENDIF
1064: 
1065:         loc_nImpVal = THIS.obj_4c_Opt_Impressora.Value
1066:         THIS.this_oBusinessObject.this_nImpressora = loc_nImpVal
1067:         IF loc_nImpVal >= 1 AND loc_nImpVal <= THIS.obj_4c_Opt_Impressora.ButtonCount
1068:             THIS.this_oBusinessObject.this_cNomeImpressora = ;
1069:                 ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpVal).Tag)
1070:         ENDIF
1071: 
1072:         WITH THIS.cnt_4c__Impressora
1073:             THIS.this_oBusinessObject.this_nTpImp   = .obj_4c_Opcao_imp.Value
1074:             THIS.this_oBusinessObject.this_nAjVerts = .obj_4c_Spn_AjVerts.Value
1075:             THIS.this_oBusinessObject.this_nAjHorzs = .obj_4c_Spn_AjHorzs.Value
1076:             THIS.this_oBusinessObject.this_nAjDenss = .obj_4c_Spn_AjDenss.Value
1077:             THIS.this_oBusinessObject.this_nAjVelos = .obj_4c_Spn_AjVelos.Value
1078:             .Visible     = .T.
1079:         ENDWITH
1080:     ENDPROC
1081: 
1082:     *--------------------------------------------------------------------------
1083:     * BOParaForm - Transfere valores do Business Object para o form
1084:     *--------------------------------------------------------------------------
1085:     PROTECTED PROCEDURE BOParaForm()
1086:         THIS.txt_4c_Etq_Ini.Value = THIS.this_oBusinessObject.this_nEtqIni
1087:         THIS.txt_4c_Etq_Qtd.Value = THIS.this_oBusinessObject.this_nEtqQtd
1088: 
1089:         IF THIS.this_oBusinessObject.this_nTipoEtq >= 1 AND ;
1090:            THIS.this_oBusinessObject.this_nTipoEtq <= THIS.obj_4c_Opt_Tipo.ButtonCount
1091:             THIS.obj_4c_Opt_Tipo.Value = THIS.this_oBusinessObject.this_nTipoEtq
1092:         ENDIF
1093: 
1094:         IF THIS.this_oBusinessObject.this_nImpressora >= 1 AND ;
1095:            THIS.this_oBusinessObject.this_nImpressora <= THIS.obj_4c_Opt_Impressora.ButtonCount
1096:             THIS.obj_4c_Opt_Impressora.Value = THIS.this_oBusinessObject.this_nImpressora
1097:         ENDIF
1098: 
1099:         WITH THIS.cnt_4c__Impressora
1100:             .obj_4c_Opcao_imp.Value   = THIS.this_oBusinessObject.this_nTpImp
1101:             .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
1102:             .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
1103:             .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
1104:             .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
1105:             .Visible     = .T.
1106:         ENDWITH
1107:     ENDPROC
1108: 
1109:     *--------------------------------------------------------------------------
1110:     * HabilitarCampos - Habilita ou desabilita campos de entrada
1111:     *--------------------------------------------------------------------------
1112:     PROCEDURE HabilitarCampos(par_lHabilitar)
1113:         THIS.txt_4c_Etq_Ini.Enabled = par_lHabilitar
1114:         THIS.txt_4c_Etq_Qtd.Enabled = par_lHabilitar
1115: 
1116:         IF par_lHabilitar
1117:             THIS.obj_4c_Opt_Tipo.Enabled      = (THIS.obj_4c_Opt_Tipo.ButtonCount > 1)
1118:             THIS.obj_4c_Opt_Impressora.Enabled = (THIS.obj_4c_Opt_Impressora.ButtonCount > 1)
1119:         ELSE
1120:             THIS.obj_4c_Opt_Tipo.Enabled      = .F.
1121:             THIS.obj_4c_Opt_Impressora.Enabled = .F.
1122:         ENDIF
1123: 
1124:         WITH THIS.cnt_4c__Impressora
1125:             .obj_4c_Opcao_imp.Enabled   = par_lHabilitar
1126:             .obj_4c_Spn_AjVerts.Enabled = par_lHabilitar
1127:             .obj_4c_Spn_AjHorzs.Enabled = par_lHabilitar
1128:             .obj_4c_Spn_AjDenss.Enabled = par_lHabilitar
1129:             .obj_4c_Spn_AjVelos.Enabled = par_lHabilitar
1130:             .Visible     = .T.
1131:         ENDWITH
1132:     ENDPROC
1133: 
1134:     *--------------------------------------------------------------------------
1135:     * LimparCampos - Restaura campos ao estado inicial padrao
1136:     *--------------------------------------------------------------------------
1137:     PROCEDURE LimparCampos()
1138:         THIS.txt_4c_Etq_Ini.Value = 1
1139:         THIS.txt_4c_Etq_Qtd.Value = 0
1140:         THIS.txt_4c_Etq_Ini.Refresh()
1141:         THIS.txt_4c_Etq_Qtd.Refresh()
1142: 
1143:         IF THIS.obj_4c_Opt_Tipo.ButtonCount >= 1
1144:             THIS.obj_4c_Opt_Tipo.Value = 1
1145:         ENDIF
1146:         IF THIS.obj_4c_Opt_Impressora.ButtonCount >= 1
1147:             THIS.obj_4c_Opt_Impressora.Value = 1
1148:             THIS.OptImpressoraInteractiveChange()
1149:         ENDIF
1150: 
1151:         THIS.this_oBusinessObject.LimparCursorImpressao()
1152:         THIS.txt_4c_Etq_Qtd.SetFocus()
1153:     ENDPROC
1154: 
1155:     *--------------------------------------------------------------------------
1156:     * CarregarLista - Alias de CarregarDados para compatibilidade com FormBase
1157:     *--------------------------------------------------------------------------
1158:     PROCEDURE CarregarLista()
1159:         THIS.CarregarDados()
1160:     ENDPROC
1161: 
1162:     *--------------------------------------------------------------------------
1163:     * AjustarBotoesPorModo - Habilita botao Imprimir conforme disponibilidade
1164:     *--------------------------------------------------------------------------
1165:     PROCEDURE AjustarBotoesPorModo()
1166:         LOCAL loc_lPodeImprimir
1167:         loc_lPodeImprimir = (THIS.this_oBusinessObject.this_lTiposOk AND ;
1168:                              THIS.this_oBusinessObject.this_lImpressorasOk)
1169:         THIS.obj_4c_BtnReport.Buttons(1).Enabled = loc_lPodeImprimir
1170:     ENDPROC
1171: 
1172:     *--------------------------------------------------------------------------
1173:     * BtnBuscarClick - Recarrega dados de tipos e impressoras do banco
1174:     *--------------------------------------------------------------------------
1175:     PROCEDURE BtnBuscarClick()
1176:         THIS.CarregarDados()
1177:         THIS.AjustarBotoesPorModo()
1178:     ENDPROC
1179: 
1180:     *--------------------------------------------------------------------------
1181:     * BtnSalvarClick - Alias para BtnImprimeClick (acao principal do OPERACIONAL)
1182:     *--------------------------------------------------------------------------
1183:     PROCEDURE BtnSalvarClick()
1184:         THIS.BtnImprimeClick()
1185:     ENDPROC
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * BtnCancelarClick - Cancela operacao em andamento e limpa os campos
1189:     *--------------------------------------------------------------------------
1190:     PROCEDURE BtnCancelarClick()
1191:         IF MsgConfirma("Cancelar a impress" + CHR(227) + "o e limpar os valores digitados ?", ;
1192:                        "Confirmar")
1193:             THIS.LimparCampos()
1194:         ENDIF
1195:     ENDPROC
1196: 
1197:     *--------------------------------------------------------------------------
1198:     * Destroy - Libera recursos e cursores
1199:     *--------------------------------------------------------------------------
1200:     PROCEDURE Destroy()
1201:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1202:             THIS.this_oBusinessObject = .NULL.
1203:         ENDIF
1204:         IF USED("cursor_4c_SigCdTpe")
1205:             USE IN cursor_4c_SigCdTpe
1206:         ENDIF
1207:         IF USED("cursor_4c_ImpAcessiveis")
1208:             USE IN cursor_4c_ImpAcessiveis
1209:         ENDIF
1210:         IF USED("cursor_4c_ImpTemp")
1211:             USE IN cursor_4c_ImpTemp
1212:         ENDIF
1213:         IF USED("cursor_4c_ConfigImp")
1214:             USE IN cursor_4c_ConfigImp
1215:         ENDIF
1216:         IF USED("cursor_4c_SigCdPam")
1217:             USE IN cursor_4c_SigCdPam
1218:         ENDIF
1219:         IF USED("cursor_4c_SigCdPac")
1220:             USE IN cursor_4c_SigCdPac
1221:         ENDIF
1222:         IF USED("dbImpressao")
1223:             USE IN dbImpressao
1224:         ENDIF
1225:         DODEFAULT()
1226:     ENDPROC
1227: 
1228: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprenvBO.prg):
*==============================================================================
* sigprenvBO.prg
* Business Object - Impressao de Etiquetas de Envelopes
* Tipo: OPERACIONAL
* Migrado de: sigprenv.SCX
*==============================================================================

DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Campos de entrada do usuario
    this_nEtqIni           = 1     && Etiqueta Inicial
    this_nEtqQtd           = 0     && Quantidade de etiquetas

    *-- Selecao de tipo de etiqueta (Opt_Tipo)
    this_nTipoEtq          = 1     && Value do OptionGroup de tipo
    this_cTagTipoEtq       = ""    && Tag da opcao selecionada (nTipos como string)

    *-- Selecao de impressora (Opt_Impressora)
    this_nImpressora       = 1     && Value do OptionGroup de impressora
    this_cNomeImpressora   = ""    && Tag/nome da impressora selecionada

    *-- Configuracoes de impressao (Cnt_Impressora)
    this_nTpImp            = 1     && Tipo: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL
    this_nAjVerts          = 0     && Ajuste Vertical (Spn_AjVerts)
    this_nAjHorzs          = 0     && Ajuste Horizontal (Spn_AjHorzs)
    this_nAjDenss          = 10    && Ajuste Densidade (Spn_AjDenss)
    this_nAjVelos          = 3     && Ajuste Velocidade (spn_AjVelos)

    *-- Flags de estado
    this_lImpressorasOk    = .F.   && .T. se ha impressoras disponiveis
    this_lTiposOk          = .F.   && .T. se ha tipos de etiqueta configurados
    this_nTotalTipos       = 0     && Total de tipos de etiqueta disponiveis
    this_nTotalImpressoras = 0     && Total de impressoras disponiveis

    *-- Configuracoes lidas de SigCdPam/SigCdPac
    this_nMaxTpEtis        = 5     && Maximo de tipos de etiqueta (SigCdPam.nMaxTpEtis)
    this_nMaxImpEti        = 5     && Maximo de impressoras para etiqueta (SigCdPam.nMaxImpEti)
    this_nImpEtis          = 1     && Tipo de impressao padrao (SigCdPam.ImpEtis)
    this_nAjVertsPad       = 0     && Ajuste vertical padrao (SigCdPam.AjVerts)
    this_nAjHorzsPad       = 0     && Ajuste horizontal padrao (SigCdPam.AjHorzs)
    this_nAjDensPad        = 10    && Ajuste densidade padrao (SigCdPac.AjDens)
    this_nAjVelosPad       = 1     && Ajuste velocidade padrao (SigCdPac.AjVelos)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO; form operacional sem tabela/chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia configuracoes de SigCdPam para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
            THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
            THIS.this_nImpEtis    = NVL(impetis, 1)
            THIS.this_nAjVertsPad = NVL(ajverts, 0)
            THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Le SigCdPam e SigCdPac, popula propriedades this_
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT TOP 1 nmaxtpetis, nmaximpeti, impetis, ajverts, ajhorzs, " + ;
                       "tpetipads, tpcbars FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
                    THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
                    THIS.this_nImpEtis    = NVL(impetis, 1)
                    THIS.this_nAjVertsPad = NVL(ajverts, 0)
                    THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigCdPac")
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_cSQL = "SELECT TOP 1 ajdens, ajvelos FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDensPad  = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelosPad = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(245) + "es")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega tipos de etiqueta (ntipos=6, nsituas=1)
    * Cria cursor_4c_SigCdTpe ordenado por cordems
    * Retorna .T. se sucesso (mesmo sem registros)
    *--------------------------------------------------------------------------
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdTpe")
                USE IN cursor_4c_SigCdTpe
            ENDIF

            loc_cSQL = "SELECT cetiquetas, ntipos, nsituas, cordems " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE ntipos = 6 AND nsituas = 1 " + ;
                       "ORDER BY cordems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTpe") > 0
                SELECT cursor_4c_SigCdTpe
                THIS.this_lTiposOk     = !EOF()
                THIS.this_nTotalTipos  = _TALLY
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar tipos de etiqueta")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras acessiveis pelo usuario logado
    * Cria cursor_4c_ImpAcessiveis com colunas impres, ntpimpres
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            IF USED("cursor_4c_ImpAcessiveis")
                USE IN cursor_4c_ImpAcessiveis
            ENDIF
            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
                       "FROM SIGSYIMP a " + ;
                       "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
                       "WHERE a.usuacess = " + loc_cUsuario + ;
                       " UNION " + ;
                       "SELECT DISTINCT c.impres, c.ntpimpres " + ;
                       "FROM sigcdacg a " + ;
                       "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;
                       "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;
                       "WHERE a.usuarios = " + loc_cUsuario

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                IF USED("cursor_4c_ImpTemp") AND !EOF("cursor_4c_ImpTemp")
                    SELECT impres, ntpimpres FROM cursor_4c_ImpTemp ;
                        INTO CURSOR cursor_4c_ImpAcessiveis READWRITE
                    SELECT cursor_4c_ImpAcessiveis
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                    THIS.this_lImpressorasOk     = !EOF()
                    THIS.this_nTotalImpressoras  = _TALLY
                ELSE
                    THIS.this_lImpressorasOk    = .F.
                    THIS.this_nTotalImpressoras = 0
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar impressoras")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfigImpressora - Carrega ajustes de uma impressora especifica
    * Substitui fCarregarImps do Framework legado
    * Popula this_nTpImp, this_nAjVerts, this_nAjHorzs, this_nAjDenss, this_nAjVelos
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfigImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cNome
        loc_lSucesso = .F.
        TRY
            loc_cNome = EscaparSQL(UPPER(ALLTRIM(par_cNomeImpressora)))

            IF USED("cursor_4c_ConfigImp")
                USE IN cursor_4c_ConfigImp
            ENDIF

            loc_cSQL = "SELECT TOP 1 impetis, ajverts, ajhorzs, ajdens, ajvelos " + ;
                       "FROM SIGCDMP " + ;
                       "WHERE UPPER(RTRIM(impres)) = " + loc_cNome

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigImp") > 0
                IF USED("cursor_4c_ConfigImp") AND !EOF("cursor_4c_ConfigImp")
                    SELECT cursor_4c_ConfigImp
                    THIS.this_nTpImp   = NVL(impetis, THIS.this_nImpEtis)
                    THIS.this_nAjVerts = NVL(ajverts, THIS.this_nAjVertsPad)
                    THIS.this_nAjHorzs = NVL(ajhorzs, THIS.this_nAjHorzsPad)
                    THIS.this_nAjDenss = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelos = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ELSE
                    *-- Impressora sem config especifica: usar valores padrao
                    THIS.this_nTpImp   = THIS.this_nImpEtis
                    THIS.this_nAjVerts = THIS.this_nAjVertsPad
                    THIS.this_nAjHorzs = THIS.this_nAjHorzsPad
                    THIS.this_nAjDenss = THIS.this_nAjDensPad
                    THIS.this_nAjVelos = THIS.this_nAjVelosPad
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar config da impressora")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursorImpressao - Cria/limpa dbImpressao e insere registros
    * par_nIni - numero inicial da etiqueta
    * par_nQtd - quantidade de etiquetas
    * Retorna .T. se sucesso; cursor dbImpressao fica disponivel para SigOpEtq
    *--------------------------------------------------------------------------
    FUNCTION PrepararCursorImpressao(par_nIni, par_nQtd)
        LOCAL loc_lSucesso, loc_oErro, loc_nI, loc_nFim, loc_cCpro
        loc_lSucesso = .F.
        TRY
            IF par_nQtd <= 0
                MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!")
            ELSE
                IF USED("dbImpressao")
                    SELECT dbImpressao
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR dbImpressao ;
                        (Cpros C(10), DPros C(40) NULL, Qtds N(10,3), ;
                         QtdeEtiq N(10,3), Pedido C(30) NULL, Obs C(10) NULL)
                    SET NULL OFF
                    INDEX ON Cpros TAG Cpros
                    SET ORDER TO
                ENDIF

                loc_nFim = par_nIni + par_nQtd - 1
                FOR loc_nI = par_nIni TO loc_nFim
                    loc_cCpro = PADL(ALLTRIM(STR(loc_nI, 8)), 8, "0")
                    INSERT INTO dbImpressao (Cpros, Qtds, Pedido, QtdeEtiq) ;
                        VALUES (loc_cCpro, 1, "", 1)
                ENDFOR

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar cursor de impress" + CHR(227) + "o")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursorImpressao - Limpa dbImpressao apos impressao concluida
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorImpressao()
        IF USED("dbImpressao")
            SELECT dbImpressao
            ZAP
        ENDIF
    ENDPROC

ENDDEFINE

