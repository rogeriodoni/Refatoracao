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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1244 linhas total):

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
214:                     .FontName        = "Tahoma"

*-- Linhas 242 a 323:
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
260:                     .AutoSize  = .F.
261:                     .BackStyle = 0
262:                     .ForeColor = RGB(90, 90, 90)
263:                     .Caption   = "1. Gen" + CHR(233) + "rico/Somente Texto"
264:                     .Height    = 17
265:                     .Left      = 10
266:                     .Top       = 10
267:                     .Width     = 238
268:                     .Themes    = .F.
269:                 ENDWITH
270:             ENDWITH
271: 
272:             *-- Container de configuracoes da impressora (Cnt_Impressora)
273:             THIS.AddObject("cnt_4c__Impressora", "Container")
274:             WITH THIS.cnt_4c__Impressora
275:                 .Top       = 289
276:                 .Left      = 396
277:                 .Width     = 254
278:                 .Height    = 67
279:                 .BackStyle = 0
280:                 .Visible   = .T.
281: 
282:                 *-- OptionGroup tipo de impressao: Allegro / Zebra ZPL / Zebra EPL
283:                 .AddObject("obj_4c_Opcao_imp", "OptionGroup")
284:                 WITH .obj_4c_Opcao_imp
285:                     .Top         = 3
286:                     .Left        = 3
287:                     .Width       = 249
288:                     .Height      = 22
289:                     .BackStyle   = 0
290:                     .ButtonCount = 3
291:                     .Value       = 1
292:                     .Visible     = .T.
293:                     WITH .Buttons(1)
294:                         .AutoSize  = .F.
295:                         .BackStyle = 0
296:                         .ForeColor = RGB(90, 90, 90)
297:                         .Caption   = "Allegro"
298:                         .Left      = 3
299:                         .Top       = 4
300:                         .Width     = 51
301:                     ENDWITH
302:                     WITH .Buttons(2)
303:                         .AutoSize  = .F.
304:                         .FontName  = "Tahoma"
305:                         .FontSize  = 8
306:                         .BackStyle = 0
307:                         .ForeColor = RGB(90, 90, 90)
308:                         .Caption   = "Zebra ZPL"
309:                         .Left      = 77
310:                         .Top       = 4
311:                         .Width     = 66
312:                         .Themes    = .F.
313:                     ENDWITH
314:                     WITH .Buttons(3)
315:                         .AutoSize  = .F.
316:                         .FontName  = "Tahoma"
317:                         .FontSize  = 8
318:                         .BackStyle = 0
319:                         .ForeColor = RGB(90, 90, 90)
320:                         .Caption   = "Zebra EPL"
321:                         .Left      = 170
322:                         .Top       = 4
323:                         .Width     = 66

*-- Linhas 441 a 502:
441:                 ENDWITH
442:             ENDWITH
443: 
444:             *-- BINDEVENTs de botoes e selecao de impressora
445:             BINDEVENT(THIS.obj_4c_BtnReport.Buttons(1), "Click", THIS, "BtnImprimeClick")
446:             BINDEVENT(THIS.obj_4c_BtnReport.Buttons(2), "Click", THIS, "BtnEncerrarClick")
447:             BINDEVENT(THIS.obj_4c_Opt_Impressora, "InteractiveChange", THIS, "OptImpressoraInteractiveChange")
448: 
449:         CATCH TO loc_oErro
450:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
451:                     " PROC=" + loc_oErro.Procedure, "Erro ao configurar layout")
452:         ENDTRY
453:     ENDPROC
454: 
455:     *--------------------------------------------------------------------------
456:     * ConfigurarPaginaDados - Adiciona campos de entrada de dados do form
457:     * Form OPERACIONAL flat: agrupa campos de entrada (Etiqueta Inicial/Quantidade,
458:     * OptionGroup Tipo de Etiqueta). Impressora + Container de ajustes ficam em
459:     * ConfigurarPaginaLista (junto com botoes de acao) por serem parte do bloco
460:     * de configuracao de impressao.
461:     *--------------------------------------------------------------------------
462:     PROTECTED PROCEDURE ConfigurarPaginaDados()
463:         LOCAL loc_oErro
464:         TRY
465:             *-- Label "Etiqueta Inicial :"
466:             THIS.AddObject("lbl_4c_Lbl_Etq", "Label")
467:             WITH THIS.lbl_4c_Lbl_Etq
468:                 .Top       = 129
469:                 .Left      = 155
470:                 .AutoSize  = .T.
471:                 .FontName  = "Tahoma"
472:                 .FontSize  = 8
473:                 .BackStyle = 0
474:                 .ForeColor = RGB(90, 90, 90)
475:                 .Caption   = "Etiqueta Inicial :"
476:                 .Visible   = .T.
477:             ENDWITH
478: 
479:             *-- TextBox Etiqueta Inicial (valor inicial da numeracao das etiquetas)
480:             THIS.AddObject("txt_4c_Etq_Ini", "TextBox")
481:             WITH THIS.txt_4c_Etq_Ini
482:                 .Top                = 125
483:                 .Left               = 237
484:                 .Width              = 66
485:                 .Height             = 23
486:                 .FontName           = "Tahoma"
487:                 .InputMask          = "99999999"
488:                 .DisabledBackColor  = RGB(255, 255, 255)
489:                 .Value              = 1
490:                 .Visible            = .T.
491:             ENDWITH
492: 
493:             *-- Label "Quantidade :"
494:             THIS.AddObject("lbl_4c_Lbl_Qtd", "Label")
495:             WITH THIS.lbl_4c_Lbl_Qtd
496:                 .Top       = 129
497:                 .Left      = 328
498:                 .AutoSize  = .T.
499:                 .FontName  = "Tahoma"
500:                 .FontSize  = 8
501:                 .BackStyle = 0
502:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 535 a 615:
535:                 .Visible   = .T.
536:             ENDWITH
537: 
538:             *-- OptionGroup Tipo de Etiqueta (ButtonCount dinamico - populado em CarregarDados)
539:             THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
540:             WITH THIS.obj_4c_Opt_Tipo
541:                 .Top           = 179
542:                 .Left          = 140
543:                 .Width         = 240
544:                 .Height        = 30
545:                 .BackStyle     = 0
546:                 .SpecialEffect = 1
547:                 .Themes        = .F.
548:                 .ButtonCount   = 1
549:                 .Value         = 1
550:                 .Enabled       = .F.
551:                 .Visible       = .T.
552:                 WITH .Buttons(1)
553:                     .AutoSize  = .F.
554:                     .BackStyle = 0
555:                     .ForeColor = RGB(90, 90, 90)
556:                     .Caption   = ""
557:                     .Height    = 22
558:                     .Left      = 10
559:                     .Top       = 10
560:                     .Width     = 222
561:                     .Themes    = .F.
562:                 ENDWITH
563:             ENDWITH
564: 
565:         CATCH TO loc_oErro
566:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
567:                     " PROC=" + loc_oErro.Procedure, "Erro ao configurar campos de dados")
568:         ENDTRY
569:     ENDPROC
570: 
571:     *--------------------------------------------------------------------------
572:     * CarregarDados - Popula controles dinamicos (tipos de etiqueta e impressoras)
573:     * Executa queries SQL e constroi buttons dos OptionGroups dinamicamente
574:     *--------------------------------------------------------------------------
575:     PROCEDURE CarregarDados()
576:         LOCAL loc_oErro, loc_laPrinters(1, 2), loc_nPrinters
577:         LOCAL loc_nTipos, loc_nI, loc_nTop, loc_nHeight
578:         LOCAL loc_nBottom1, loc_nBottom2, loc_nImpres, loc_nOk, loc_nPIdx
579:         LOCAL loc_cCaption, loc_cTag, loc_cImpres, loc_laImpOk(1), loc_nJ
580: 
581:         TRY
582:             *-- Carregar configuracoes de SigCdPam e SigCdPac
583:             THIS.this_oBusinessObject.CarregarConfiguracoes()
584:             THIS.this_oBusinessObject.CarregarTiposEtiqueta()
585: 
586:             *-- Construir botoes de tipo de etiqueta
587:             loc_nTop    = 10
588:             loc_nHeight = 40
589: 
590:             IF THIS.this_oBusinessObject.this_lTiposOk
591:                 loc_nTipos = THIS.this_oBusinessObject.this_nTotalTipos
592:                 THIS.obj_4c_Opt_Tipo.ButtonCount = ;
593:                     MIN(loc_nTipos, MAX(THIS.this_oBusinessObject.this_nMaxTpEtis, 5))
594: 
595:                 SELECT cursor_4c_SigCdTpe
596:                 GO TOP
597:                 loc_nI = 1
598:                 SCAN WHILE loc_nI <= THIS.obj_4c_Opt_Tipo.ButtonCount
599:                     loc_cCaption = "\<" + CHR(96 + loc_nI) + ". " + ALLTRIM(cursor_4c_SigCdTpe.cetiquetas)
600:                     loc_cTag     = ALLTRIM(STR(cursor_4c_SigCdTpe.ntipos))
601:                     WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
602:                         .AutoSize  = .F.
603:                         .Left      = 10
604:                         .Top       = loc_nTop
605:                         .Width     = 160
606:                         .Caption   = loc_cCaption
607:                         .FontSize  = 8
608:                         .FontName  = "Tahoma"
609:                         .Tag       = loc_cTag
610:                         .BackStyle = 0
611:                         .ForeColor = RGB(90, 90, 90)
612:                         .Themes    = .F.
613:                     ENDWITH
614:                     loc_nTop    = loc_nTop + 20
615:                     loc_nHeight = loc_nHeight + 20

*-- Linhas 761 a 1244:
761:             THIS.Height = MAX(loc_nBottom1, loc_nBottom2) + 20
762: 
763:             *-- Carregar configuracoes da primeira impressora selecionada
764:             THIS.OptImpressoraInteractiveChange()
765: 
766:         CATCH TO loc_oErro
767:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
768:                     " PROC=" + loc_oErro.Procedure, "Erro ao carregar dados")
769:         ENDTRY
770:     ENDPROC
771: 
772:     *--------------------------------------------------------------------------
773:     * BtnImprimeClick - Valida e executa a impressao de etiquetas de envelope
774:     * Chama SigOpEtq do Framework via proxy pnIdconn
775:     *--------------------------------------------------------------------------
776:     PROCEDURE BtnImprimeClick()
777:         LOCAL loc_lSucesso, loc_oErro, loc_nIni, loc_nQtd
778:         LOCAL loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, loc_nAjVelos
779:         LOCAL loc_cNomeImp, loc_nImpres, loc_oDataMgr
780:         loc_lSucesso = .F.
781: 
782:         TRY
783:             loc_nQtd = THIS.txt_4c_Etq_Qtd.Value
784: 
785:             IF loc_nQtd <= 0
786:                 MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!")
787:                 THIS.txt_4c_Etq_Qtd.SetFocus()
788:             ELSE
789:                 IF MsgConfirma("Confirma a Impress" + CHR(227) + "o Das Etiquetas ?", "Confirmar")
790:                     loc_nIni = THIS.txt_4c_Etq_Ini.Value
791: 
792:                     IF THIS.this_oBusinessObject.PrepararCursorImpressao(loc_nIni, loc_nQtd)
793:                         *-- Obter configuracoes de impressao atuais
794:                         WITH THIS.cnt_4c__Impressora
795:                             loc_nTpImp   = .obj_4c_Opcao_imp.Value
796:                             loc_nAjVerts = .obj_4c_Spn_AjVerts.Value
797:                             loc_nAjHorzs = .obj_4c_Spn_AjHorzs.Value
798:                             loc_nAjDenss = .obj_4c_Spn_AjDenss.Value
799:                             loc_nAjVelos = .obj_4c_Spn_AjVelos.Value
800:                             .Visible     = .T.
801:                         ENDWITH
802: 
803:                         loc_nImpres  = THIS.obj_4c_Opt_Impressora.Value
804:                         loc_cNomeImp = THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag
805: 
806:                         *-- Proxy minimo para compatibilidade com SigOpEtq (espera pnIdconn)
807:                         loc_oDataMgr = CREATEOBJECT("Empty")
808:                         ADDPROPERTY(loc_oDataMgr, "pnIdconn", gnConnHandle)
809:                         ADDPROPERTY(loc_oDataMgr, "pnIdConn", gnConnHandle)
810: 
811:                         *-- Executar impressao via funcao do Framework (requer SigOpEtq.prg)
812:                         SigOpEtq(loc_oDataMgr, .F., .F., 6, ;
813:                                  loc_nTpImp, loc_nAjVerts, loc_nAjHorzs, loc_nAjDenss, ;
814:                                  .NULL., .NULL., .NULL., loc_cNomeImp, .NULL., .NULL., loc_nAjVelos)
815: 
816:                         MsgInfo("Impress" + CHR(227) + "o conclu" + CHR(237) + "da com sucesso!")
817: 
818:                         *-- Atualizar etiqueta inicial e zerar quantidade
819:                         THIS.txt_4c_Etq_Ini.Value = loc_nIni + loc_nQtd
820:                         THIS.txt_4c_Etq_Qtd.Value = 0
821:                         THIS.txt_4c_Etq_Ini.Refresh()
822:                         THIS.txt_4c_Etq_Qtd.Refresh()
823: 
824:                         THIS.this_oBusinessObject.LimparCursorImpressao()
825:                         THIS.txt_4c_Etq_Qtd.SetFocus()
826:                         loc_lSucesso = .T.
827:                     ENDIF
828:                 ENDIF
829:             ENDIF
830: 
831:         CATCH TO loc_oErro
832:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
833:                     " PROC=" + loc_oErro.Procedure, "Erro ao imprimir etiquetas")
834:         ENDTRY
835:         RETURN loc_lSucesso
836:     ENDPROC
837: 
838:     *--------------------------------------------------------------------------
839:     * BtnEncerrarClick - Fecha o formulario
840:     *--------------------------------------------------------------------------
841:     PROCEDURE BtnEncerrarClick()
842:         THIS.Release()
843:     ENDPROC
844: 
845:     *--------------------------------------------------------------------------
846:     * OptImpressoraInteractiveChange - Atualiza spinners ao trocar impressora
847:     *--------------------------------------------------------------------------
848:     PROCEDURE OptImpressoraInteractiveChange()
849:         LOCAL loc_oErro, loc_nImpres, loc_cNomeImp, loc_lValido
850:         loc_lValido = .F.
851: 
852:         TRY
853:             IF VARTYPE(THIS.obj_4c_Opt_Impressora) = "O"
854:                 loc_nImpres = THIS.obj_4c_Opt_Impressora.Value
855:                 IF loc_nImpres >= 1 AND loc_nImpres <= THIS.obj_4c_Opt_Impressora.ButtonCount
856:                     loc_cNomeImp = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
857:                     IF !EMPTY(loc_cNomeImp)
858:                         THIS.this_oBusinessObject.CarregarConfigImpressora(loc_cNomeImp)
859:                         WITH THIS.cnt_4c__Impressora
860:                             .obj_4c_Opcao_imp.Value   = THIS.this_oBusinessObject.this_nTpImp
861:                             .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
862:                             .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
863:                             .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
864:                             .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
865:                             .Visible     = .T.
866:                         ENDWITH
867:                         loc_lValido = .T.
868:                     ENDIF
869:                 ENDIF
870:             ENDIF
871: 
872:         CATCH TO loc_oErro
873:             MsgErro(loc_oErro.Message, ;
874:                     "Erro ao carregar configura" + CHR(231) + CHR(245) + "es da impressora")
875:         ENDTRY
876:     ENDPROC
877: 
878:     *--------------------------------------------------------------------------
879:     * BtnIncluirClick - Iniciar nova impressao (form OPERACIONAL)
880:     * Mapeia para: incluir novo lote de etiquetas na fila de impressao.
881:     * Zera a quantidade, avanca a etiqueta inicial para o proximo bloco livre
882:     * e devolve o foco para o campo Quantidade.
883:     *--------------------------------------------------------------------------
884:     PROCEDURE BtnIncluirClick()
885:         LOCAL loc_oErro, loc_nProxIni
886: 
887:         TRY
888:             *-- Se ha quantidade digitada, avancar a etiqueta inicial
889:             IF THIS.txt_4c_Etq_Qtd.Value > 0
890:                 loc_nProxIni = THIS.txt_4c_Etq_Ini.Value + THIS.txt_4c_Etq_Qtd.Value
891:                 THIS.txt_4c_Etq_Ini.Value = loc_nProxIni
892:             ENDIF
893: 
894:             *-- Zerar quantidade para novo lote
895:             THIS.txt_4c_Etq_Qtd.Value = 0
896:             THIS.txt_4c_Etq_Ini.Refresh()
897:             THIS.txt_4c_Etq_Qtd.Refresh()
898: 
899:             *-- Habilitar campos de entrada
900:             THIS.txt_4c_Etq_Ini.Enabled = .T.
901:             THIS.txt_4c_Etq_Qtd.Enabled = .T.
902: 
903:             *-- Liberar cursor de impressao previa (se houver)
904:             THIS.this_oBusinessObject.LimparCursorImpressao()
905: 
906:             *-- Focar quantidade para digitacao
907:             THIS.txt_4c_Etq_Qtd.SetFocus()
908: 
909:         CATCH TO loc_oErro
910:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
911:                     " PROC=" + loc_oErro.Procedure, "Erro ao iniciar novo lote")
912:         ENDTRY
913:     ENDPROC
914: 
915:     *--------------------------------------------------------------------------
916:     * BtnAlterarClick - Alterar parametros de impressao (form OPERACIONAL)
917:     * Mapeia para: habilitar edicao dos ajustes (spinners) e OptionGroup de
918:     * tipo de impressao para que o usuario possa modificar os valores padrao
919:     * carregados de SigCdPam/SigCdPac antes de imprimir.
920:     *--------------------------------------------------------------------------
921:     PROCEDURE BtnAlterarClick()
922:         LOCAL loc_oErro
923: 
924:         TRY
925:             *-- Habilitar campos de entrada
926:             THIS.txt_4c_Etq_Ini.Enabled = .T.
927:             THIS.txt_4c_Etq_Qtd.Enabled = .T.
928: 
929:             *-- Habilitar OptionGroups de tipo de etiqueta e impressora
930:             IF THIS.obj_4c_Opt_Tipo.ButtonCount > 1
931:                 THIS.obj_4c_Opt_Tipo.Enabled = .T.
932:             ENDIF
933:             IF THIS.obj_4c_Opt_Impressora.ButtonCount > 1
934:                 THIS.obj_4c_Opt_Impressora.Enabled = .T.
935:             ENDIF
936: 
937:             *-- Habilitar ajustes da impressora (spinners e tipo de impressao)
938:             WITH THIS.cnt_4c__Impressora
939:                 .obj_4c_Opcao_imp.Enabled  = .T.
940:                 .obj_4c_Spn_AjVerts.Enabled = .T.
941:                 .obj_4c_Spn_AjHorzs.Enabled = .T.
942:                 .obj_4c_Spn_AjDenss.Enabled = .T.
943:                 .obj_4c_Spn_AjVelos.Enabled = .T.
944:                 .Visible     = .T.
945:             ENDWITH
946: 
947:             *-- Focar tipo de impressao para inicio da alteracao
948:             THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.SetFocus()
949: 
950:         CATCH TO loc_oErro
951:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
952:                     " PROC=" + loc_oErro.Procedure, "Erro ao habilitar altera" + CHR(231) + CHR(227) + "o")
953:         ENDTRY
954:     ENDPROC
955: 
956:     *--------------------------------------------------------------------------
957:     * BtnVisualizarClick - Visualizar impressao (form OPERACIONAL)
958:     * Mapeia para: preparar o cursor de impressao sem enviar para a impressora
959:     * e apresentar ao usuario o resumo do que sera impresso (faixa de etiquetas
960:     * + tipo + impressora destino).
961:     *--------------------------------------------------------------------------
962:     PROCEDURE BtnVisualizarClick()
963:         LOCAL loc_oErro, loc_nIni, loc_nQtd, loc_nFim
964:         LOCAL loc_cResumo, loc_nImpres, loc_cNomeImp, loc_cTpImp
965:         LOCAL loc_nTipoEtq
966: 
967:         TRY
968:             loc_nIni = THIS.txt_4c_Etq_Ini.Value
969:             loc_nQtd = THIS.txt_4c_Etq_Qtd.Value
970: 
971:             IF loc_nQtd <= 0
972:                 MsgAviso("Informe uma quantidade maior que 0 (zero) para visualizar.")
973:                 THIS.txt_4c_Etq_Qtd.SetFocus()
974:             ELSE
975:                 *-- Preparar cursor sem imprimir (mesma logica do BtnImprime, sem SigOpEtq)
976:                 IF THIS.this_oBusinessObject.PrepararCursorImpressao(loc_nIni, loc_nQtd)
977:                     loc_nFim     = loc_nIni + loc_nQtd - 1
978:                     loc_nImpres  = THIS.obj_4c_Opt_Impressora.Value
979:                     loc_cNomeImp = ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpres).Tag)
980:                     loc_nTipoEtq = THIS.obj_4c_Opt_Tipo.Value
981: 
982:                     DO CASE
983:                         CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 1
984:                             loc_cTpImp = "Allegro"
985:                         CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 2
986:                             loc_cTpImp = "Zebra ZPL"
987:                         CASE THIS.cnt_4c__Impressora.obj_4c_Opcao_imp.Value = 3
988:                             loc_cTpImp = "Zebra EPL"
989:                         OTHERWISE
990:                             loc_cTpImp = "N" + CHR(227) + "o definido"
991:                     ENDCASE
992: 
993:                     loc_cResumo = "Pr" + CHR(233) + "-visualiza" + CHR(231) + CHR(227) + "o da impress" + CHR(227) + "o" + CHR(13) + CHR(13) + ;
994:                                   "Etiqueta inicial : " + TRANSFORM(loc_nIni) + CHR(13) + ;
995:                                   "Etiqueta final   : " + TRANSFORM(loc_nFim) + CHR(13) + ;
996:                                   "Quantidade       : " + TRANSFORM(loc_nQtd) + CHR(13) + ;
997:                                   "Tipo de etiqueta : " + ALLTRIM(TRANSFORM(loc_nTipoEtq)) + CHR(13) + ;
998:                                   "Modo de impress" + CHR(227) + "o: " + loc_cTpImp + CHR(13) + ;
999:                                   "Impressora       : " + loc_cNomeImp
1000: 
1001:                     MsgInfo(loc_cResumo, "Visualiza" + CHR(231) + CHR(227) + "o")
1002: 
1003:                     *-- Liberar cursor apos preview (usuario ainda pode confirmar impressao)
1004:                     THIS.this_oBusinessObject.LimparCursorImpressao()
1005:                 ENDIF
1006:             ENDIF
1007: 
1008:         CATCH TO loc_oErro
1009:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1010:                     " PROC=" + loc_oErro.Procedure, "Erro ao visualizar impress" + CHR(227) + "o")
1011:         ENDTRY
1012:     ENDPROC
1013: 
1014:     *--------------------------------------------------------------------------
1015:     * BtnExcluirClick - Cancelar/limpar impressao em andamento (form OPERACIONAL)
1016:     * Mapeia para: descartar cursor de impressao ja preparado e restaurar
1017:     * valores padrao de spinners e OptionGroups (mesmo comportamento do
1018:     * legado quando o usuario abandona o processo).
1019:     *--------------------------------------------------------------------------
1020:     PROCEDURE BtnExcluirClick()
1021:         LOCAL loc_oErro
1022: 
1023:         TRY
1024:             IF MsgConfirma("Cancelar a impress" + CHR(227) + "o e limpar os valores digitados ?", ;
1025:                            "Confirmar cancelamento")
1026:                 *-- Descartar cursor de impressao
1027:                 THIS.this_oBusinessObject.LimparCursorImpressao()
1028: 
1029:                 *-- Restaurar valores padrao dos campos de entrada
1030:                 THIS.txt_4c_Etq_Ini.Value = 1
1031:                 THIS.txt_4c_Etq_Qtd.Value = 0
1032:                 THIS.txt_4c_Etq_Ini.Refresh()
1033:                 THIS.txt_4c_Etq_Qtd.Refresh()
1034: 
1035:                 *-- Restaurar valores padrao dos ajustes (SigCdPam/SigCdPac)
1036:                 WITH THIS.cnt_4c__Impressora
1037:                     .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVertsPad
1038:                     .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzsPad
1039:                     .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDensPad
1040:                     .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelosPad
1041:                     .obj_4c_Opcao_imp.Value   = IIF(THIS.this_oBusinessObject.this_nImpEtis <> 0, ;
1042:                                                     THIS.this_oBusinessObject.this_nImpEtis, 1)
1043:                     .Visible     = .T.
1044:                 ENDWITH
1045: 
1046:                 *-- Voltar OptionGroups ao primeiro item
1047:                 IF THIS.obj_4c_Opt_Tipo.ButtonCount >= 1
1048:                     THIS.obj_4c_Opt_Tipo.Value = 1
1049:                 ENDIF
1050:                 IF THIS.obj_4c_Opt_Impressora.ButtonCount >= 1
1051:                     THIS.obj_4c_Opt_Impressora.Value = 1
1052:                     THIS.OptImpressoraInteractiveChange()
1053:                 ENDIF
1054: 
1055:                 *-- Devolver foco para inicio do fluxo
1056:                 THIS.txt_4c_Etq_Qtd.SetFocus()
1057:             ENDIF
1058: 
1059:         CATCH TO loc_oErro
1060:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
1061:                     " PROC=" + loc_oErro.Procedure, "Erro ao cancelar impress" + CHR(227) + "o")
1062:         ENDTRY
1063:     ENDPROC
1064: 
1065:     *--------------------------------------------------------------------------
1066:     * FormParaBO - Transfere valores do form para o Business Object
1067:     *--------------------------------------------------------------------------
1068:     PROTECTED PROCEDURE FormParaBO()
1069:         LOCAL loc_nTipoVal, loc_nImpVal
1070: 
1071:         THIS.this_oBusinessObject.this_nEtqIni = THIS.txt_4c_Etq_Ini.Value
1072:         THIS.this_oBusinessObject.this_nEtqQtd = THIS.txt_4c_Etq_Qtd.Value
1073: 
1074:         loc_nTipoVal = THIS.obj_4c_Opt_Tipo.Value
1075:         THIS.this_oBusinessObject.this_nTipoEtq = loc_nTipoVal
1076:         IF loc_nTipoVal >= 1 AND loc_nTipoVal <= THIS.obj_4c_Opt_Tipo.ButtonCount
1077:             THIS.this_oBusinessObject.this_cTagTipoEtq = ;
1078:                 ALLTRIM(THIS.obj_4c_Opt_Tipo.Buttons(loc_nTipoVal).Tag)
1079:         ENDIF
1080: 
1081:         loc_nImpVal = THIS.obj_4c_Opt_Impressora.Value
1082:         THIS.this_oBusinessObject.this_nImpressora = loc_nImpVal
1083:         IF loc_nImpVal >= 1 AND loc_nImpVal <= THIS.obj_4c_Opt_Impressora.ButtonCount
1084:             THIS.this_oBusinessObject.this_cNomeImpressora = ;
1085:                 ALLTRIM(THIS.obj_4c_Opt_Impressora.Buttons(loc_nImpVal).Tag)
1086:         ENDIF
1087: 
1088:         WITH THIS.cnt_4c__Impressora
1089:             THIS.this_oBusinessObject.this_nTpImp   = .obj_4c_Opcao_imp.Value
1090:             THIS.this_oBusinessObject.this_nAjVerts = .obj_4c_Spn_AjVerts.Value
1091:             THIS.this_oBusinessObject.this_nAjHorzs = .obj_4c_Spn_AjHorzs.Value
1092:             THIS.this_oBusinessObject.this_nAjDenss = .obj_4c_Spn_AjDenss.Value
1093:             THIS.this_oBusinessObject.this_nAjVelos = .obj_4c_Spn_AjVelos.Value
1094:             .Visible     = .T.
1095:         ENDWITH
1096:     ENDPROC
1097: 
1098:     *--------------------------------------------------------------------------
1099:     * BOParaForm - Transfere valores do Business Object para o form
1100:     *--------------------------------------------------------------------------
1101:     PROTECTED PROCEDURE BOParaForm()
1102:         THIS.txt_4c_Etq_Ini.Value = THIS.this_oBusinessObject.this_nEtqIni
1103:         THIS.txt_4c_Etq_Qtd.Value = THIS.this_oBusinessObject.this_nEtqQtd
1104: 
1105:         IF THIS.this_oBusinessObject.this_nTipoEtq >= 1 AND ;
1106:            THIS.this_oBusinessObject.this_nTipoEtq <= THIS.obj_4c_Opt_Tipo.ButtonCount
1107:             THIS.obj_4c_Opt_Tipo.Value = THIS.this_oBusinessObject.this_nTipoEtq
1108:         ENDIF
1109: 
1110:         IF THIS.this_oBusinessObject.this_nImpressora >= 1 AND ;
1111:            THIS.this_oBusinessObject.this_nImpressora <= THIS.obj_4c_Opt_Impressora.ButtonCount
1112:             THIS.obj_4c_Opt_Impressora.Value = THIS.this_oBusinessObject.this_nImpressora
1113:         ENDIF
1114: 
1115:         WITH THIS.cnt_4c__Impressora
1116:             .obj_4c_Opcao_imp.Value   = THIS.this_oBusinessObject.this_nTpImp
1117:             .obj_4c_Spn_AjVerts.Value = THIS.this_oBusinessObject.this_nAjVerts
1118:             .obj_4c_Spn_AjHorzs.Value = THIS.this_oBusinessObject.this_nAjHorzs
1119:             .obj_4c_Spn_AjDenss.Value = THIS.this_oBusinessObject.this_nAjDenss
1120:             .obj_4c_Spn_AjVelos.Value = THIS.this_oBusinessObject.this_nAjVelos
1121:             .Visible     = .T.
1122:         ENDWITH
1123:     ENDPROC
1124: 
1125:     *--------------------------------------------------------------------------
1126:     * HabilitarCampos - Habilita ou desabilita campos de entrada
1127:     *--------------------------------------------------------------------------
1128:     PROCEDURE HabilitarCampos(par_lHabilitar)
1129:         THIS.txt_4c_Etq_Ini.Enabled = par_lHabilitar
1130:         THIS.txt_4c_Etq_Qtd.Enabled = par_lHabilitar
1131: 
1132:         IF par_lHabilitar
1133:             THIS.obj_4c_Opt_Tipo.Enabled      = (THIS.obj_4c_Opt_Tipo.ButtonCount > 1)
1134:             THIS.obj_4c_Opt_Impressora.Enabled = (THIS.obj_4c_Opt_Impressora.ButtonCount > 1)
1135:         ELSE
1136:             THIS.obj_4c_Opt_Tipo.Enabled      = .F.
1137:             THIS.obj_4c_Opt_Impressora.Enabled = .F.
1138:         ENDIF
1139: 
1140:         WITH THIS.cnt_4c__Impressora
1141:             .obj_4c_Opcao_imp.Enabled   = par_lHabilitar
1142:             .obj_4c_Spn_AjVerts.Enabled = par_lHabilitar
1143:             .obj_4c_Spn_AjHorzs.Enabled = par_lHabilitar
1144:             .obj_4c_Spn_AjDenss.Enabled = par_lHabilitar
1145:             .obj_4c_Spn_AjVelos.Enabled = par_lHabilitar
1146:             .Visible     = .T.
1147:         ENDWITH
1148:     ENDPROC
1149: 
1150:     *--------------------------------------------------------------------------
1151:     * LimparCampos - Restaura campos ao estado inicial padrao
1152:     *--------------------------------------------------------------------------
1153:     PROCEDURE LimparCampos()
1154:         THIS.txt_4c_Etq_Ini.Value = 1
1155:         THIS.txt_4c_Etq_Qtd.Value = 0
1156:         THIS.txt_4c_Etq_Ini.Refresh()
1157:         THIS.txt_4c_Etq_Qtd.Refresh()
1158: 
1159:         IF THIS.obj_4c_Opt_Tipo.ButtonCount >= 1
1160:             THIS.obj_4c_Opt_Tipo.Value = 1
1161:         ENDIF
1162:         IF THIS.obj_4c_Opt_Impressora.ButtonCount >= 1
1163:             THIS.obj_4c_Opt_Impressora.Value = 1
1164:             THIS.OptImpressoraInteractiveChange()
1165:         ENDIF
1166: 
1167:         THIS.this_oBusinessObject.LimparCursorImpressao()
1168:         THIS.txt_4c_Etq_Qtd.SetFocus()
1169:     ENDPROC
1170: 
1171:     *--------------------------------------------------------------------------
1172:     * CarregarLista - Alias de CarregarDados para compatibilidade com FormBase
1173:     *--------------------------------------------------------------------------
1174:     PROCEDURE CarregarLista()
1175:         THIS.CarregarDados()
1176:     ENDPROC
1177: 
1178:     *--------------------------------------------------------------------------
1179:     * AjustarBotoesPorModo - Habilita botao Imprimir conforme disponibilidade
1180:     *--------------------------------------------------------------------------
1181:     PROCEDURE AjustarBotoesPorModo()
1182:         LOCAL loc_lPodeImprimir
1183:         loc_lPodeImprimir = (THIS.this_oBusinessObject.this_lTiposOk AND ;
1184:                              THIS.this_oBusinessObject.this_lImpressorasOk)
1185:         THIS.obj_4c_BtnReport.Buttons(1).Enabled = loc_lPodeImprimir
1186:     ENDPROC
1187: 
1188:     *--------------------------------------------------------------------------
1189:     * BtnBuscarClick - Recarrega dados de tipos e impressoras do banco
1190:     *--------------------------------------------------------------------------
1191:     PROCEDURE BtnBuscarClick()
1192:         THIS.CarregarDados()
1193:         THIS.AjustarBotoesPorModo()
1194:     ENDPROC
1195: 
1196:     *--------------------------------------------------------------------------
1197:     * BtnSalvarClick - Alias para BtnImprimeClick (acao principal do OPERACIONAL)
1198:     *--------------------------------------------------------------------------
1199:     PROCEDURE BtnSalvarClick()
1200:         THIS.BtnImprimeClick()
1201:     ENDPROC
1202: 
1203:     *--------------------------------------------------------------------------
1204:     * BtnCancelarClick - Cancela operacao em andamento e limpa os campos
1205:     *--------------------------------------------------------------------------
1206:     PROCEDURE BtnCancelarClick()
1207:         IF MsgConfirma("Cancelar a impress" + CHR(227) + "o e limpar os valores digitados ?", ;
1208:                        "Confirmar")
1209:             THIS.LimparCampos()
1210:         ENDIF
1211:     ENDPROC
1212: 
1213:     *--------------------------------------------------------------------------
1214:     * Destroy - Libera recursos e cursores
1215:     *--------------------------------------------------------------------------
1216:     PROCEDURE Destroy()
1217:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1218:             THIS.this_oBusinessObject = .NULL.
1219:         ENDIF
1220:         IF USED("cursor_4c_SigCdTpe")
1221:             USE IN cursor_4c_SigCdTpe
1222:         ENDIF
1223:         IF USED("cursor_4c_ImpAcessiveis")
1224:             USE IN cursor_4c_ImpAcessiveis
1225:         ENDIF
1226:         IF USED("cursor_4c_ImpTemp")
1227:             USE IN cursor_4c_ImpTemp
1228:         ENDIF
1229:         IF USED("cursor_4c_ConfigImp")
1230:             USE IN cursor_4c_ConfigImp
1231:         ENDIF
1232:         IF USED("cursor_4c_SigCdPam")
1233:             USE IN cursor_4c_SigCdPam
1234:         ENDIF
1235:         IF USED("cursor_4c_SigCdPac")
1236:             USE IN cursor_4c_SigCdPac
1237:         ENDIF
1238:         IF USED("dbImpressao")
1239:             USE IN dbImpressao
1240:         ENDIF
1241:         DODEFAULT()
1242:     ENDPROC
1243: 
1244: ENDDEFINE


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

