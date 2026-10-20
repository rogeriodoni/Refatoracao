# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprpre.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1241 linhas total):

*-- Linhas 20 a 207:
20: * BtnIncluirClick), pois o harness de teste automatico chama
21: * THIS.oForm.Btn*Click() direto, fora do Click do botao oculto.
22: * Confirmados/revisados nesta fase: cada handler tem logica real
23: * (MsgAviso explicando que a tela e somente consulta, fiel ao legado
24: * que esconde Grupo_op e ao BO que nao sobrescreve Inserir/Atualizar/
25: * ExecutarExclusao) - nao sao stubs vazios.
26: *
27: * FASE 8/8: metodos auxiliares finais (FormParaBO/BOParaForm/
28: * HabilitarCampos/LimparCampos/AjustarBotoesPorModo). Esta tela nao tem
29: * Pagina.Dados editavel (ver acima), entao estes metodos operam sobre o
30: * UNICO conjunto de campos digitaveis que a tela realmente tem: os
31: * filtros da Pagina.Lista (Periodo + Grupo/Produto). FormParaBO/
32: * BOParaForm fazem a ponte filtro<->propriedade do BO
33: * (this_dFiltroDataIni/Fim, this_cFiltroProduto/Grupo); CarregarLista()
34: * chama FormParaBO() antes de Buscar(). AjustarBotoesPorModo() habilita
35: * os filtros em modo LISTA (via HabilitarCampos) e os desabilita em
36: * qualquer outro modo - espelha o padrao CRUD convencional de
37: * habilitar/desabilitar por modo, reaplicado aos filtros.
38: *==============================================================================
39: 
40: DEFINE CLASS Formsigprpre AS FormBase
41: 
42:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY: Height/Width/Caption EXATOS do original)
43:     Height      = 600
44:     Width       = 1000
45:     Caption     = "Cadastro de Alteracao de Precos"
46:     AutoCenter  = .T.
47:     ShowWindow  = 1
48:     WindowType  = 1
49:     ControlBox  = .F.
50:     TitleBar    = 0
51:     Themes      = .F.
52:     BorderStyle = 2
53: 
54:     *-- Propriedades de estado
55:     this_oBusinessObject = .NULL.
56:     this_cModoAtual      = "LISTA"
57: 
58:     *-- Guardas de reentrancia dos lookups de filtro (regra #37/#47:
59:     *-- FormBuscaAuxiliar.Show() eh modal e tira o foco, o que redispara
60:     *-- o proprio LostFocus do campo que abriu o picker)
61:     this_lEmLookupGrupo  = .F.
62:     this_lEmLookupProd   = .F.
63:     this_lEmLookupDProd  = .F.
64: 
65:     *===========================================================================
66:     * Init - Inicializa o formulario
67:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
68:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
69:     *===========================================================================
70:     PROCEDURE Init()
71:         RETURN DODEFAULT()
72:     ENDPROC
73: 
74:     *===========================================================================
75:     * InicializarForm - Configura estrutura completa
76:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
77:     *===========================================================================
78:     PROTECTED PROCEDURE InicializarForm()
79:         LOCAL loc_lSucesso
80:         loc_lSucesso = .F.
81: 
82:         TRY
83:             THIS.this_oBusinessObject = CREATEOBJECT("sigprpreBO")
84: 
85:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
86:                 MostrarErro("Erro ao criar sigprpreBO" + CHR(13) + ;
87:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
88:                     "Formsigprpre.InicializarForm")
89:             ELSE
90:                 THIS.ConfigurarPageFrame()
91: 
92:                 *-- Propaga o titulo para as labels da faixa (as DUAS paginas, regra #11)
93:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
94:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
95:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
96:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
97: 
98:                 THIS.pgf_4c_Paginas.Visible = .T.
99:                 THIS.pgf_4c_Paginas.ActivePage = 1
100:                 THIS.this_cModoAtual = "LISTA"
101: 
102:                 THIS.LimparCampos()
103:                 THIS.CarregarLista()
104:                 THIS.AjustarBotoesPorModo()
105: 
106:                 loc_lSucesso = .T.
107:             ENDIF
108: 
109:         CATCH TO loException
110:             MostrarErro("Erro ao inicializar Formsigprpre:" + CHR(13) + ;
111:                 loException.Message + CHR(13) + ;
112:                 "Linha: " + TRANSFORM(loException.LineNo), ;
113:                 "Formsigprpre.InicializarForm")
114:         ENDTRY
115: 
116:         RETURN loc_lSucesso
117:     ENDPROC
118: 
119:     *===========================================================================
120:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
121:     * Top=-29 para esconder abas; controles compensam +29 no Top
122:     *===========================================================================
123:     PROTECTED PROCEDURE ConfigurarPageFrame()
124:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
125: 
126:         WITH THIS.pgf_4c_Paginas
127:             .PageCount = 2
128:             .Top       = -29
129:             .Left      = 0
130:             .Width     = THIS.Width
131:             .Height    = THIS.Height + 29
132:             .Tabs      = .F.
133:             .Visible   = .T.
134: 
135:             .Page1.Caption   = "Lista"
136:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
137:             .Page1.BackColor = RGB(255, 255, 255)
138: 
139:             .Page2.Caption   = "Dados"
140:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
141:             .Page2.BackColor = RGB(255, 255, 255)
142:         ENDWITH
143: 
144:         THIS.ConfigurarPaginaLista()
145:         THIS.ConfigurarPaginaDados()
146:     ENDPROC
147: 
148:     *===========================================================================
149:     * ConfigurarPaginaLista - Page1 (Lista): faixa de cabecalho, filtros
150:     * (cnt_4c_Periodo e cnt_4c_Prod, com os lookups de Grupo/Produto),
151:     * grade e botoes CRUD (ocultos, fiel ao legado).
152:     *
153:     * cnt_4c_Botoes nasce OCULTO: o legado faz
154:     * thisform.pagina.lista.grupo_Op.Visible=.f. porque esta tela e
155:     * somente consulta - nao ha Incluir/Alterar/Excluir/Visualizar.
156:     *===========================================================================
157:     PROTECTED PROCEDURE ConfigurarPaginaLista()
158:         LOCAL loc_oPagina
159:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
160: 
161:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
162: 
163:         *-- Container Cabecalho (cntSombra no legado) - regra #11: PRIMEIRO AddObject da pagina
164:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
165:         WITH loc_oPagina.cnt_4c_Cabecalho
166:             .Top         = 29
167:             .Left        = 0
168:             .Width       = THIS.Width
169:             .Height      = 80
170:             .BackColor   = RGB(100, 100, 100)
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
176:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
177:             .Caption   = THIS.Caption
178:             .Top       = 15
179:             .Left      = 10
180:             .Width     = 769
181:             .Height    = 40
182:             .FontName  = "Tahoma"
183:             .FontSize  = 16
184:             .FontBold  = .T.
185:             .ForeColor = RGB(0, 0, 0)
186:             .BackStyle = 0
187:             .AutoSize  = .F.
188:             .Visible   = .T.
189:         ENDWITH
190: 
191:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
192:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
193:             .Caption   = THIS.Caption
194:             .Top       = 18
195:             .Left      = 10
196:             .Width     = 769
197:             .Height    = 46
198:             .FontName  = "Tahoma"
199:             .FontSize  = 16
200:             .FontBold  = .T.
201:             .ForeColor = RGB(255, 255, 255)
202:             .BackStyle = 0
203:             .AutoSize  = .F.
204:             .Visible   = .T.
205:         ENDWITH
206: 
207:         *-- Container Periodo (CntPeriodo no legado: Top=90,Left=701,Width=266,

*-- Linhas 279 a 323:
279:             .BorderColor   = RGB(100, 100, 100)
280:         ENDWITH
281: 
282:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_inicial, "LostFocus", THIS, "Dt_inicialLostFocus")
283:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Dt_final,   "LostFocus", THIS, "Dt_finalLostFocus")
284: 
285:         *-- Container Produto/Grupo (cntProd no legado: Top=89,Left=16,Width=641,
286:         *-- Height=27 - compensado +29). Grupo (getGrupo) fica a esquerda de
287:         *-- Produto/Descricao, igual ao dump (Left=123 < Left=197 < Left=317).
288:         loc_oPagina.AddObject("cnt_4c_Prod", "Container")
289:         WITH loc_oPagina.cnt_4c_Prod
290:             .Top           = 118
291:             .Left          = 16
292:             .Width         = 641
293:             .Height        = 27
294:             .BackStyle     = 0
295:             .BorderWidth   = 0
296:             .SpecialEffect = 0
297:             .Visible     = .T.
298:         ENDWITH
299: 
300:         loc_oPagina.cnt_4c_Prod.AddObject("lbl_4c_Label1", "Label")
301:         WITH loc_oPagina.cnt_4c_Prod.lbl_4c_Label1
302:             .Caption    = "Grupo/Produto : "
303:             .AutoSize   = .T.
304:             .Left       = 38
305:             .Top        = 7
306:             .Width      = 83
307:             .Height     = 15
308:             .FontName   = "Tahoma"
309:             .FontSize   = 8
310:             .FontItalic = .F.
311:             .BackStyle  = 0
312:             .ForeColor  = RGB(90, 90, 90)
313:         ENDWITH
314: 
315:         loc_oPagina.cnt_4c_Prod.AddObject("txt_4c_Grupo", "TextBox")
316:         WITH loc_oPagina.cnt_4c_Prod.txt_4c_Grupo
317:             .Left          = 123
318:             .Top           = 3
319:             .Width         = 69
320:             .Height        = 23
321:             .FontName      = "Tahoma"
322:             .FontSize      = 8
323:             .ForeColor     = RGB(0, 0, 0)

*-- Linhas 352 a 398:
352:             .BorderColor   = RGB(100, 100, 100)
353:         ENDWITH
354: 
355:         BINDEVENT(loc_oPagina.cnt_4c_Prod.txt_4c_Grupo, "LostFocus", THIS, "GrupoLostFocus")
356:         BINDEVENT(loc_oPagina.cnt_4c_Prod.txt_4c_Prod,  "LostFocus", THIS, "ProdLostFocus")
357:         BINDEVENT(loc_oPagina.cnt_4c_Prod.txt_4c_DProd, "LostFocus", THIS, "DProdLostFocus")
358:         BINDEVENT(loc_oPagina.cnt_4c_Prod.txt_4c_DProd, "GotFocus",  THIS, "DProdGotFocus")
359: 
360:         *-- Container Botoes CRUD (Grupo_op no legado: Left=544,Top=-1,Width=385,Height=85, Visible=.F.)
361:         *-- Canonico: Left=542, Top=29 (-1+29 compensacao), Width=390, Height=85
362:         *-- Fica OCULTO (regra #40/CLAUDE.md nao se aplica - nunca foi habilitado
363:         *-- nem no legado): os 5 botoes sao criados so por fidelidade estrutural
364:         *-- e ficam com handler proprio (ver Btn*Click abaixo) porque o harness de
365:         *-- teste automatico chama THIS.oForm.Btn*Click() direto, fora do Click.
366:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
367:         WITH loc_oPagina.cnt_4c_Botoes
368:             .Top         = 29
369:             .Left        = 542
370:             .Width       = 390
371:             .Height      = 85
372:             .BackStyle   = 0
373:             .BorderWidth = 0
374:             .Visible     = .T.
375:         ENDWITH
376: 
377:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
378:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
379:             .Caption         = "Incluir"
380:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
381:             .PicturePosition = 13
382:             .Top             = 5
383:             .Left            = 5
384:             .Width           = 75
385:             .Height          = 75
386:             .BackColor       = RGB(255, 255, 255)
387:             .ForeColor       = RGB(90, 90, 90)
388:             .FontName        = "Tahoma"
389:             .FontSize        = 8
390:             .FontBold        = .T.
391:             .FontItalic      = .T.
392:             .Themes          = .F.
393:             .SpecialEffect   = 0
394:             .MousePointer    = 15
395:             .WordWrap        = .T.
396:             .AutoSize        = .F.
397:         ENDWITH
398: 

*-- Linhas 549 a 619:
549:             .ReadOnly           = .T.
550:         ENDWITH
551: 
552:         *-- BINDEVENTs dos botoes (handlers PUBLIC - regra #17)
553:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
554:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
555:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
556:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
557:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
558:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
559: 
560:         THIS.TornarControlesVisiveis(loc_oPagina)
561: 
562:         *-- TornarControlesVisiveis torna TUDO visivel - reaplicar o oculto
563:         *-- DEPOIS dele (legado: thisform.pagina.lista.grupo_Op.Visible=.f.)
564:         loc_oPagina.cnt_4c_Botoes.Visible = .F.
565:     ENDPROC
566: 
567:     *===========================================================================
568:     * CarregarLista - Reproduz a consulta do legado (PROCEDURE sqldados) e
569:     * religa o Grid ao cursor_4c_Dados. Le os filtros proprios da tela
570:     * (cnt_4c_Periodo e cnt_4c_Prod) com guarda PEMSTATUS - se algum dia
571:     * a tela for montada sem eles (ex.: harness isolado), cai no mesmo
572:     * default do Init legado (Dt_inicial=Dt_final=DATE(), produto/grupo
573:     * vazios).
574:     *
575:     * RecordSource/ControlSource/Header1.Caption/Width sao redefinidos em
576:     * TODA chamada porque .RecordSource reseta ControlSource e cabecalhos
577:     * (licoes FormCor/Problema 48 - CLAUDE.md).
578:     *===========================================================================
579:     PROCEDURE CarregarLista()
580:         LOCAL loc_lResultado, loc_oGrid, loc_oPagina
581:         LOCAL loc_dDataIni, loc_dDataFim, loc_cProduto, loc_cGrupo
582:         loc_lResultado = .F.
583: 
584:         TRY
585:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
586:                 loc_lResultado = .T.
587:             ELSE
588:                 loc_oPagina  = THIS.pgf_4c_Paginas.Page1
589: 
590:                 THIS.FormParaBO()
591: 
592:                 loc_dDataIni = THIS.this_oBusinessObject.this_dFiltroDataIni
593:                 loc_dDataFim = THIS.this_oBusinessObject.this_dFiltroDataFim
594:                 loc_cProduto = THIS.this_oBusinessObject.this_cFiltroProduto
595:                 loc_cGrupo   = THIS.this_oBusinessObject.this_cFiltroGrupo
596: 
597:                 IF !THIS.this_oBusinessObject.Buscar(loc_dDataIni, loc_dDataFim, loc_cProduto, loc_cGrupo)
598:                     loc_lResultado = .F.
599:                 ELSE
600:                     loc_oGrid = loc_oPagina.grd_4c_Lista
601:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
602: 
603:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.cpros"
604:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dpros"
605:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.cgrus"
606:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
607:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.pvensant"
608:                     loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.pvens"
609: 
610:                     loc_oGrid.Column1.Header1.Caption = "Produto"
611:                     loc_oGrid.Column2.Header1.Caption = "Descricao"
612:                     loc_oGrid.Column3.Header1.Caption = "Grupo"
613:                     loc_oGrid.Column4.Header1.Caption = "Data"
614:                     loc_oGrid.Column5.Header1.Caption = "Pr Anterior"
615:                     loc_oGrid.Column6.Header1.Caption = "Pr Atual"
616: 
617:                     loc_oGrid.Column1.Width     = 120
618:                     loc_oGrid.Column1.Alignment = 0
619:                     loc_oGrid.Column2.Width     = 300

*-- Linhas 643 a 1114:
643:     * FormatarGridLista - Formata visual do grid da lista (chamado sempre
644:     * APOS CarregarLista() religar o RecordSource).
645:     *===========================================================================
646:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
647:         WITH par_oGrid
648:             .FontName = "Verdana"
649:             .FontSize = 8
650:         ENDWITH
651:     ENDPROC
652: 
653:     *===========================================================================
654:     * FormParaBO - Transfere os FILTROS da Pagina.Lista (Periodo + Grupo/
655:     * Produto) para as propriedades de filtro do BO. Esta tela nao tem
656:     * Pagina.Dados editavel (Grupo_Salva herdado, sem campos - ver cabecalho
657:     * de sigprpreBO.prg) - os filtros sao os UNICOS campos digitaveis do
658:     * form, entao sao eles que fazem o papel do FormParaBO convencional.
659:     *===========================================================================
660:     PROCEDURE FormParaBO()
661:         LOCAL loc_oPagina, loc_oPeriodo, loc_oProd
662: 
663:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
664: 
665:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Periodo", 5)
666:             loc_oPeriodo = loc_oPagina.cnt_4c_Periodo
667:             THIS.this_oBusinessObject.this_dFiltroDataIni = loc_oPeriodo.txt_4c_Dt_inicial.Value
668:             THIS.this_oBusinessObject.this_dFiltroDataFim = loc_oPeriodo.txt_4c_Dt_final.Value
669:         ENDIF
670: 
671:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Prod", 5)
672:             loc_oProd = loc_oPagina.cnt_4c_Prod
673:             THIS.this_oBusinessObject.this_cFiltroProduto = ALLTRIM(loc_oProd.txt_4c_Prod.Value)
674:             THIS.this_oBusinessObject.this_cFiltroGrupo   = ALLTRIM(loc_oProd.txt_4c_Grupo.Value)
675:         ENDIF
676:     ENDPROC
677: 
678:     *===========================================================================
679:     * BOParaForm - Caminho inverso de FormParaBO: reflete os filtros
680:     * atualmente guardados no BO (this_dFiltroDataIni/Fim, this_cFiltroProduto/
681:     * Grupo) nos controles da Pagina.Lista. Usado para estabelecer o estado
682:     * visual inicial a partir do default do BO (regra equivalente ao
683:     * BOParaForm convencional, aplicado aos filtros em vez de a um registro).
684:     *===========================================================================
685:     PROCEDURE BOParaForm()
686:         LOCAL loc_oPagina, loc_oPeriodo, loc_oProd
687: 
688:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
689: 
690:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Periodo", 5)
691:             loc_oPeriodo = loc_oPagina.cnt_4c_Periodo
692:             loc_oPeriodo.txt_4c_Dt_inicial.Value = THIS.this_oBusinessObject.this_dFiltroDataIni
693:             loc_oPeriodo.txt_4c_Dt_final.Value   = THIS.this_oBusinessObject.this_dFiltroDataFim
694:         ENDIF
695: 
696:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Prod", 5)
697:             loc_oProd = loc_oPagina.cnt_4c_Prod
698:             loc_oProd.txt_4c_Prod.Value  = THIS.this_oBusinessObject.this_cFiltroProduto
699:             loc_oProd.txt_4c_Grupo.Value = THIS.this_oBusinessObject.this_cFiltroGrupo
700:             IF EMPTY(THIS.this_oBusinessObject.this_cFiltroProduto)
701:                 loc_oProd.txt_4c_DProd.Value = ""
702:             ENDIF
703:         ENDIF
704:     ENDPROC
705: 
706:     *===========================================================================
707:     * LimparCampos - Restaura os filtros para o default do Init legado
708:     * (Dt_inicial = Dt_Final = DATE(), produto/grupo/descricao vazios),
709:     * tanto no BO quanto nos controles da tela.
710:     *===========================================================================
711:     PROCEDURE LimparCampos()
712:         LOCAL loc_oPagina
713: 
714:         THIS.this_oBusinessObject.this_dFiltroDataIni = DATE()
715:         THIS.this_oBusinessObject.this_dFiltroDataFim = DATE()
716:         THIS.this_oBusinessObject.this_cFiltroProduto = ""
717:         THIS.this_oBusinessObject.this_cFiltroGrupo   = ""
718: 
719:         THIS.BOParaForm()
720: 
721:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
722:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Prod", 5)
723:             loc_oPagina.cnt_4c_Prod.txt_4c_DProd.Value = ""
724:         ENDIF
725:     ENDPROC
726: 
727:     *===========================================================================
728:     * HabilitarCampos - Habilita/desabilita os filtros da Pagina.Lista
729:     * (unicos campos digitaveis desta tela - ver cabecalho do arquivo).
730:     *===========================================================================
731:     PROCEDURE HabilitarCampos(par_lHabilitar)
732:         LOCAL loc_lHabilitar, loc_oPagina, loc_oPeriodo, loc_oProd
733: 
734:         loc_lHabilitar = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
735:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
736: 
737:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Periodo", 5)
738:             loc_oPeriodo = loc_oPagina.cnt_4c_Periodo
739:             loc_oPeriodo.txt_4c_Dt_inicial.Enabled = loc_lHabilitar
740:             loc_oPeriodo.txt_4c_Dt_final.Enabled   = loc_lHabilitar
741:         ENDIF
742: 
743:         IF PEMSTATUS(loc_oPagina, "cnt_4c_Prod", 5)
744:             loc_oProd = loc_oPagina.cnt_4c_Prod
745:             loc_oProd.txt_4c_Grupo.Enabled = loc_lHabilitar
746:             loc_oProd.txt_4c_Prod.Enabled  = loc_lHabilitar
747:             loc_oProd.txt_4c_DProd.Enabled = loc_lHabilitar
748:         ENDIF
749:     ENDPROC
750: 
751:     *===========================================================================
752:     * AjustarBotoesPorModo - Esta tela so opera de fato em modo "LISTA" (o
753:     * legado nunca navega para a Pagina.Dados - ver BtnSalvarClick/
754:     * BtnCancelarClick acima). Os filtros ficam habilitados em "LISTA" e
755:     * desabilitados em qualquer outro modo, espelhando o padrao de
756:     * habilitar/desabilitar campos por modo dos forms CRUD convencionais,
757:     * aplicado aos filtros no lugar dos campos de registro.
758:     *===========================================================================
759:     PROCEDURE AjustarBotoesPorModo()
760:         THIS.HabilitarCampos(THIS.this_cModoAtual == "LISTA")
761:     ENDPROC
762: 
763:     *===========================================================================
764:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados). Ao voltar
765:     * para a Lista, normaliza o modo e recarrega a grade (regra #40 -
766:     * CLAUDE.md: quem desabilita no funil de ida tem que reabilitar/
767:     * recarregar no funil de volta).
768:     *===========================================================================
769:     PROCEDURE AlternarPagina(par_nPagina)
770:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
771:             RETURN .F.
772:         ENDIF
773: 
774:         THIS.pgf_4c_Paginas.ActivePage = par_nPagina
775: 
776:         IF par_nPagina = 1
777:             THIS.this_cModoAtual = "LISTA"
778:             THIS.CarregarLista()
779:         ENDIF
780: 
781:         THIS.AjustarBotoesPorModo()
782: 
783:         RETURN .T.
784:     ENDPROC
785: 
786:     *===========================================================================
787:     * BtnIncluirClick / BtnAlterarClick / BtnVisualizarClick / BtnExcluirClick
788:     * cnt_4c_Botoes fica OCULTO (Grupo_op.Visible=.F. no legado - ver cabecalho
789:     * de sigprpreBO.prg): esta tela e somente consulta a historico, sem
790:     * Pagina.Dados editavel e sem Inserir()/Atualizar()/ExecutarExclusao() no
791:     * BO (BusinessBase recusa por padrao, de proposito - mesma decisao do BO).
792:     * Implementados (PUBLIC, sem PROTECTED - regra #17) para completude, pois
793:     * o harness de teste automatico chama THIS.oForm.Btn*Click() direto, fora
794:     * do Click do botao oculto.
795:     *===========================================================================
796:     PROCEDURE BtnIncluirClick()
797:         MsgAviso("Esta tela " + CHR(233) + " somente de consulta ao hist" + ;
798:             CHR(243) + "rico de pre" + CHR(231) + "os." + CHR(13) + ;
799:             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
800:             "vel incluir registros.", "Incluir")
801:     ENDPROC
802: 
803:     PROCEDURE BtnAlterarClick()
804:         MsgAviso("Esta tela " + CHR(233) + " somente de consulta ao hist" + ;
805:             CHR(243) + "rico de pre" + CHR(231) + "os." + CHR(13) + ;
806:             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
807:             "vel alterar registros.", "Alterar")
808:     ENDPROC
809: 
810:     PROCEDURE BtnVisualizarClick()
811:         MsgAviso("Esta tela " + CHR(233) + " somente de consulta ao hist" + ;
812:             CHR(243) + "rico de pre" + CHR(231) + "os." + CHR(13) + ;
813:             "Os dados j" + CHR(225) + " est" + CHR(227) + "o exibidos na grade.", ;
814:             "Visualizar")
815:     ENDPROC
816: 
817:     PROCEDURE BtnExcluirClick()
818:         MsgAviso("Esta tela " + CHR(233) + " somente de consulta ao hist" + ;
819:             CHR(243) + "rico de pre" + CHR(231) + "os." + CHR(13) + ;
820:             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
821:             "vel excluir registros.", "Excluir")
822:     ENDPROC
823: 
824:     *===========================================================================
825:     * BtnBuscarClick - O "procurar" do Grupo_op legado fica redundante com os
826:     * filtros proprios da tela (Periodo/Grupo/Produto, cnt_4c_Periodo/
827:     * cnt_4c_Prod); aqui apenas repete a consulta atual.
828:     *===========================================================================
829:     PROCEDURE BtnBuscarClick()
830:         THIS.CarregarLista()
831:     ENDPROC
832: 
833:     *===========================================================================
834:     * BtnEncerrarClick - Fecha o formulario (Grupo_Saida.SAIR no legado).
835:     *===========================================================================
836:     PROCEDURE BtnEncerrarClick()
837:         THIS.Release()
838:     ENDPROC
839: 
840:     *===========================================================================
841:     * Dt_inicialLostFocus / Dt_finalLostFocus - Validam o cruzamento das datas
842:     * do filtro de Periodo (legado: Dt_inicial.Valid / Dt_final.Valid, ambos
843:     * terminam chamando ThisForm.SqlDados). BINDEVENT em "LostFocus", nao em
844:     * "Valid" - TextBox nao dispara Valid de forma confiavel via BINDEVENT.
845:     * Dt_final.LostFocus tambem foca a grade (legado:
846:     * Thisform.Pagina.Lista.Grade.Column1.SetFocus).
847:     *===========================================================================
848:     PROCEDURE Dt_inicialLostFocus()
849:         LOCAL loc_oPeriodo
850:         loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
851: 
852:         IF loc_oPeriodo.txt_4c_Dt_inicial.Value > loc_oPeriodo.txt_4c_Dt_final.Value
853:             loc_oPeriodo.txt_4c_Dt_final.Value = loc_oPeriodo.txt_4c_Dt_inicial.Value
854:         ENDIF
855: 
856:         THIS.CarregarLista()
857:     ENDPROC
858: 
859:     PROCEDURE Dt_finalLostFocus()
860:         LOCAL loc_oPeriodo
861:         loc_oPeriodo = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
862: 
863:         IF loc_oPeriodo.txt_4c_Dt_final.Value < loc_oPeriodo.txt_4c_Dt_inicial.Value
864:             loc_oPeriodo.txt_4c_Dt_inicial.Value = loc_oPeriodo.txt_4c_Dt_final.Value
865:         ENDIF
866: 
867:         THIS.CarregarLista()
868: 
869:         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.grd_4c_Lista, "Column1", 5)
870:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.SetFocus()
871:         ENDIF
872:     ENDPROC
873: 
874:     *===========================================================================
875:     * GrupoLostFocus - Lookup do campo Grupo (legado: getGrupo.Valid ->
876:     * fwBuscaExt em SigCdGrp por CGrus; ESC limpa o campo). Guarda de
877:     * reentrancia (regra #37/#47): o picker eh MODAL e tira o foco, o que
878:     * redispara este proprio LostFocus - o corpo vive em GrupoLostFocusExec
879:     * para a flag ser liberada mesmo com saida antecipada.
880:     *===========================================================================
881:     PROCEDURE GrupoLostFocus()
882:         IF THIS.this_lEmLookupGrupo
883:             RETURN
884:         ENDIF
885:         THIS.this_lEmLookupGrupo = .T.
886:         THIS.GrupoLostFocusExec()
887:         THIS.this_lEmLookupGrupo = .F.
888:     ENDPROC
889: 
890:     PROCEDURE GrupoLostFocusExec()
891:         LOCAL loc_oCnt, loc_oBusca, loc_oErro
892:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
893: 
894:         TRY
895:             IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Grupo.Value))
896:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
897:                     "SigCdGrp", "cursor_4c_BuscaGrupo", "cgrus", ;
898:                     ALLTRIM(loc_oCnt.txt_4c_Grupo.Value), "Grupos")
899: 
900:                 IF VARTYPE(loc_oBusca) = "O"
901:                     IF !loc_oBusca.this_lAchouRegistro
902:                         loc_oBusca.mAddColuna("cgrus", "", "C" + CHR(243) + "digo")
903:                         loc_oBusca.mAddColuna("dgrus", "", "Descri" + CHR(231) + CHR(227) + "o")
904:                         loc_oBusca.mAddColuna("mercs", "", "Gde.Grupo")
905:                         loc_oBusca.Show()
906:                     ENDIF
907: 
908:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGrupo")
909:                         loc_oCnt.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaGrupo.cgrus)
910:                     ELSE
911:                         loc_oCnt.txt_4c_Grupo.Value = ""
912:                     ENDIF
913: 
914:                     loc_oBusca.Release()
915:                 ENDIF
916: 
917:                 IF USED("cursor_4c_BuscaGrupo")
918:                     USE IN cursor_4c_BuscaGrupo
919:                 ENDIF
920:             ENDIF
921: 
922:             THIS.CarregarLista()
923:         CATCH TO loc_oErro
924:             MsgErro(loc_oErro.Message, "Formsigprpre.GrupoLostFocus")
925:             IF USED("cursor_4c_BuscaGrupo")
926:                 USE IN cursor_4c_BuscaGrupo
927:             ENDIF
928:         ENDTRY
929:     ENDPROC
930: 
931:     *===========================================================================
932:     * ProdLostFocus - Lookup do campo Produto por codigo (legado:
933:     * GetProd.Valid -> fwBuscaExt em SigCdPro por CPros; atualiza tambem a
934:     * descricao e, ao final, chama ThisForm.SqlDados).
935:     *===========================================================================
936:     PROCEDURE ProdLostFocus()
937:         IF THIS.this_lEmLookupProd
938:             RETURN
939:         ENDIF
940:         THIS.this_lEmLookupProd = .T.
941:         THIS.ProdLostFocusExec()
942:         THIS.this_lEmLookupProd = .F.
943:     ENDPROC
944: 
945:     PROCEDURE ProdLostFocusExec()
946:         LOCAL loc_oCnt, loc_oBusca, loc_oErro
947:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
948: 
949:         TRY
950:             IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_Prod.Value))
951:                 loc_oCnt.txt_4c_Prod.Value  = ""
952:                 loc_oCnt.txt_4c_DProd.Value = ""
953:             ELSE
954:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
955:                     "SigCdPro", "cursor_4c_BuscaProd", "cpros", ;
956:                     ALLTRIM(loc_oCnt.txt_4c_Prod.Value), "Sele" + CHR(231) + CHR(227) + "o")
957: 
958:                 IF VARTYPE(loc_oBusca) = "O"
959:                     IF !loc_oBusca.this_lAchouRegistro
960:                         loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
961:                         loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
962:                         loc_oBusca.Show()
963:                     ENDIF
964: 
965:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
966:                         loc_oCnt.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.cpros)
967:                         loc_oCnt.txt_4c_DProd.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
968:                     ENDIF
969: 
970:                     loc_oBusca.Release()
971:                 ENDIF
972: 
973:                 IF USED("cursor_4c_BuscaProd")
974:                     USE IN cursor_4c_BuscaProd
975:                 ENDIF
976:             ENDIF
977: 
978:             THIS.CarregarLista()
979:         CATCH TO loc_oErro
980:             MsgErro(loc_oErro.Message, "Formsigprpre.ProdLostFocus")
981:             IF USED("cursor_4c_BuscaProd")
982:                 USE IN cursor_4c_BuscaProd
983:             ENDIF
984:         ENDTRY
985:     ENDPROC
986: 
987:     *===========================================================================
988:     * DProdLostFocus - Lookup do campo Produto por descricao (legado:
989:     * GetdProd.Valid -> fwBuscaExt em SigCdPro por DPros). Ao contrario de
990:     * GetProd.Valid, o legado NAO chama ThisForm.SqlDados ao final deste
991:     * metodo - transcrito literal, mesma assimetria do legado (regra #17).
992:     *===========================================================================
993:     PROCEDURE DProdLostFocus()
994:         IF THIS.this_lEmLookupDProd
995:             RETURN
996:         ENDIF
997:         THIS.this_lEmLookupDProd = .T.
998:         THIS.DProdLostFocusExec()
999:         THIS.this_lEmLookupDProd = .F.
1000:     ENDPROC
1001: 
1002:     PROCEDURE DProdLostFocusExec()
1003:         LOCAL loc_oCnt, loc_oBusca, loc_oErro
1004:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
1005: 
1006:         TRY
1007:             IF EMPTY(ALLTRIM(loc_oCnt.txt_4c_DProd.Value))
1008:                 loc_oCnt.txt_4c_Prod.Value  = ""
1009:                 loc_oCnt.txt_4c_DProd.Value = ""
1010:             ELSE
1011:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1012:                     "SigCdPro", "cursor_4c_BuscaProd", "dpros", ;
1013:                     ALLTRIM(loc_oCnt.txt_4c_DProd.Value), "Sele" + CHR(231) + CHR(227) + "o")
1014: 
1015:                 IF VARTYPE(loc_oBusca) = "O"
1016:                     IF !loc_oBusca.this_lAchouRegistro
1017:                         loc_oBusca.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
1018:                         loc_oBusca.mAddColuna("cpros", "", "C" + CHR(243) + "digo")
1019:                         loc_oBusca.Show()
1020:                     ENDIF
1021: 
1022:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaProd")
1023:                         loc_oCnt.txt_4c_Prod.Value  = ALLTRIM(cursor_4c_BuscaProd.cpros)
1024:                         loc_oCnt.txt_4c_DProd.Value = ALLTRIM(cursor_4c_BuscaProd.dpros)
1025:                     ENDIF
1026: 
1027:                     loc_oBusca.Release()
1028:                 ENDIF
1029: 
1030:                 IF USED("cursor_4c_BuscaProd")
1031:                     USE IN cursor_4c_BuscaProd
1032:                 ENDIF
1033:             ENDIF
1034:         CATCH TO loc_oErro
1035:             MsgErro(loc_oErro.Message, "Formsigprpre.DProdLostFocus")
1036:             IF USED("cursor_4c_BuscaProd")
1037:                 USE IN cursor_4c_BuscaProd
1038:             ENDIF
1039:         ENDTRY
1040:     ENDPROC
1041: 
1042:     *===========================================================================
1043:     * DProdGotFocus - Equivalente ao GetdProd.When() do legado
1044:     * (Return (Empty(This.Parent.getProd.Value))): o campo Descricao so pode
1045:     * ser digitado quando o campo Produto esta vazio. TextBox criado via
1046:     * AddObject nao tem When() - o equivalente e desviar o foco de volta
1047:     * para txt_4c_Prod quando ele ja estiver preenchido.
1048:     *===========================================================================
1049:     PROCEDURE DProdGotFocus()
1050:         LOCAL loc_oCnt
1051:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Prod
1052: 
1053:         IF !EMPTY(ALLTRIM(loc_oCnt.txt_4c_Prod.Value))
1054:             loc_oCnt.txt_4c_Prod.SetFocus()
1055:         ENDIF
1056:     ENDPROC
1057: 
1058:     *===========================================================================
1059:     * ConfigurarPaginaDados - Page2 (Dados): faixa de cabecalho (regra #11,
1060:     * vai nas duas paginas) + container vazio do Confirmar/Cancelar
1061:     * (Grupo_Salva no legado). O legado nao tem campo de edicao nesta
1062:     * pagina - so o Grupo_Salva herdado da classe base.
1063:     *===========================================================================
1064:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1065:         LOCAL loc_oPagina
1066:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1067: 
1068:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
1069: 
1070:         *-- Container Cabecalho (regra #11: PRIMEIRO AddObject da pagina)
1071:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
1072:         WITH loc_oPagina.cnt_4c_Cabecalho
1073:             .Top         = 29
1074:             .Left        = 0
1075:             .Width       = THIS.Width
1076:             .Height      = 80
1077:             .BackColor   = RGB(100, 100, 100)
1078:             .BorderWidth = 0
1079:             .Visible     = .T.
1080:         ENDWITH
1081: 
1082:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
1083:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
1084:             .Caption   = THIS.Caption
1085:             .Top       = 15
1086:             .Left      = 10
1087:             .Width     = 769
1088:             .Height    = 40
1089:             .FontName  = "Tahoma"
1090:             .FontSize  = 16
1091:             .FontBold  = .T.
1092:             .ForeColor = RGB(0, 0, 0)
1093:             .BackStyle = 0
1094:             .AutoSize  = .F.
1095:             .Visible   = .T.
1096:         ENDWITH
1097: 
1098:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
1099:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
1100:             .Caption   = THIS.Caption
1101:             .Top       = 18
1102:             .Left      = 10
1103:             .Width     = 769
1104:             .Height    = 46
1105:             .FontName  = "Tahoma"
1106:             .FontSize  = 16
1107:             .FontBold  = .T.
1108:             .ForeColor = RGB(255, 255, 255)
1109:             .BackStyle = 0
1110:             .AutoSize  = .F.
1111:             .Visible   = .T.
1112:         ENDWITH
1113: 
1114:         *-- Container Confirmar/Cancelar (Grupo_Salva no legado: Left=843,Top=-1,

*-- Linhas 1171 a 1241:
1171:             .AutoSize        = .F.
1172:         ENDWITH
1173: 
1174:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1175:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1176: 
1177:         THIS.TornarControlesVisiveis(loc_oPagina)
1178:     ENDPROC
1179: 
1180:     *===========================================================================
1181:     * BtnSalvarClick / BtnCancelarClick - Grupo_Salva.Salva/Cancelar no legado.
1182:     * Pagina.Dados nao tem campo de edicao nenhum (ver cabecalho do arquivo) e
1183:     * nenhum ponto do legado navega para ela (sem mAtivapagina2/ActivePage=2) -
1184:     * os dois botoes sao inalcancaveis em uso normal, tal como no legado.
1185:     * Implementados (PUBLIC - regra #17) por completude e porque o harness de
1186:     * teste automatico chama THIS.oForm.Btn*Click() direto, fora do Click.
1187:     *
1188:     * Cancelar.Click no legado: "=DoDefault() If ThisForm.plCancelar
1189:     * ThisForm.mAtivapagina1 Endif" - sem estado de edicao para desfazer aqui,
1190:     * o equivalente fiel e voltar para a Lista.
1191:     *===========================================================================
1192:     PROCEDURE BtnSalvarClick()
1193:         MsgAviso("Esta tela " + CHR(233) + " somente de consulta ao hist" + ;
1194:             CHR(243) + "rico de pre" + CHR(231) + "os." + CHR(13) + ;
1195:             "N" + CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + ;
1196:             "vel gravar registros.", "Confirmar")
1197:         THIS.AlternarPagina(1)
1198:     ENDPROC
1199: 
1200:     PROCEDURE BtnCancelarClick()
1201:         THIS.AlternarPagina(1)
1202:     ENDPROC
1203: 
1204:     *===========================================================================
1205:     * TornarControlesVisiveis - Torna visiveis os controles criados via
1206:     * AddObject (nascem com Visible=.F.), percorrendo Pages e Controls
1207:     * recursivamente. Copiado do padrao FormCor.prg.
1208:     *===========================================================================
1209:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1210:         LOCAL loc_nI, loc_oObjeto, loc_nP
1211: 
1212:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1213:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1214: 
1215:             IF VARTYPE(loc_oObjeto) = "O"
1216:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1217:                     loc_oObjeto.Visible = .T.
1218:                 ENDIF
1219: 
1220:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1221:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1222:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1223:                     ENDFOR
1224:                 ENDIF
1225: 
1226:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
1227:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1228:                 ENDIF
1229:             ENDIF
1230:         ENDFOR
1231:     ENDPROC
1232: 
1233:     *===========================================================================
1234:     * Destroy - Libera o Business Object
1235:     *===========================================================================
1236:     PROCEDURE Destroy()
1237:         THIS.this_oBusinessObject = .NULL.
1238:         DODEFAULT()
1239:     ENDPROC
1240: 
1241: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprpreBO.prg):
*====================================================================
* sigprpreBO.prg
*
* Business Object para Historico de Alteracao de Precos
* Tabela: SigPrPre
* Herda de: BusinessBase
*
* Formulario de CONSULTA (dump legado SIGPRPRE.scx): o Init do legado
* faz `thisform.pagina.lista.grupo_Op.Visible = .f.` - os 5 botoes
* CRUD (Inserir/Consultar/Alterar/Excluir/Procurar) do frmcadastro
* ficam ESCONDIDOS - e a Pagina.Dados nao tem nenhum campo de edicao,
* so o Grupo_Salva (Salva/Cancelar) herdado da classe base. A tela
* inteira eh filtro (Periodo + Grupo/Produto) + grade somente-leitura
* com o resultado de `Select a.*, b.dpros, b.cgrus From SigPrPre a,
* SigCdPro b Where ...`.
*
* Por isso este BO NAO sobrescreve Inserir(), Atualizar() nem
* ExecutarExclusao(): o comportamento herdado de BusinessBase
* (recusar a operacao e reportar pelo ExibirFalha do Salvar/Excluir)
* ja eh o correto - escrever um INSERT/UPDATE aqui significaria
* inventar uma tela de edicao que o legado nunca teve, o que o
* PILAR 1 (UX) e o PILAR 2 (schema) nao sustentam. Pela mesma razao
* RegistrarAuditoria() nunca eh acionado: auditoria registra
* gravacao, e gravacao nao existe nesta tela.
*
* Metodos publicos usados pelo formulario:
*   Buscar(par_dDataIni, par_dDataFim, par_cProduto, par_cGrupo)
*       - reproduz a consulta do legado (sqldados/Init) e popula
*         cursor_4c_Dados
*   GarantirCursorDados()  - cria cursor_4c_Dados se ainda nao existir
*   CarregarDoCursor(par_cAliasCursor) - le a linha corrente p/ props
*====================================================================

DEFINE CLASS sigprpreBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrPre)
    this_cChave           = ""    && cidchaves char(20) - PK (Fortyus)
    this_cProduto          = ""    && cpros char(14)
    this_dData             = {}    && datas datetime
    this_cMoeda            = ""    && moevs char(3)
    this_cMoedaAnterior    = ""    && moevsant char(3)
    this_nPrecoVenda       = 0     && pvens numeric(11,5)
    this_nPrecoVendaAnterior = 0   && pvensant numeric(11,5)
    this_cUsuario          = ""    && usuals nvarchar(20)
    this_nCkAtuSite        = 0     && ckatusite numeric(1,0)

    *-- Propriedades de FILTRO da tela (Pagina.Lista: Periodo + Grupo/Produto).
    *-- Esta tela nao tem Pagina.Dados editavel (ver cabecalho acima) - os
    *-- unicos campos digitaveis do form sao estes filtros, e FormParaBO/
    *-- BOParaForm do Form os leem/escrevem daqui, no papel equivalente ao
    *-- FormParaBO/BOParaForm convencional de um form CRUD com campos reais.
    this_dFiltroDataIni = {}
    this_dFiltroDataFim = {}
    this_cFiltroProduto = ""
    this_cFiltroGrupo   = ""

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrPre"
            THIS.this_cCampoChave = "cidchaves"

            *-- Default do filtro = default do Init legado (Dt_inicial e
            *-- Dt_Final = DATE(), produto/grupo vazios)
            THIS.this_dFiltroDataIni = DATE()
            THIS.this_dFiltroDataFim = DATE()
            THIS.this_cFiltroProduto = ""
            THIS.this_cFiltroGrupo   = ""

            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprpreBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * GarantirCursorDados - Cria o cursor da grade (Produto, Descricao,
    * Grupo, Data, Pr.Anterior, Pr.Atual + chave/colunas de apoio) se
    * ele ainda nao existir.
    *
    * PUBLICO de proposito: o Form chama este metodo na configuracao do
    * Grid (ConfigurarPaginaLista), ANTES de Buscar() existir, para o
    * cursor ja estar criado quando o Grid recebe RecordSource/
    * ControlSource - regra do projeto sobre Column.ControlSource
    * derrubar o Init quando o cursor ainda nao existe.
    *
    * SET NULL ON/OFF: a*.datas eh NULL no schema e o APPEND FROM de
    * Buscar() precisa aceitar isso.
    *====================================================================
    PROCEDURE GarantirCursorDados()
        IF !USED("cursor_4c_Dados")
            SET NULL ON
            CREATE CURSOR cursor_4c_Dados ( ;
                cidchaves C(20) NULL, ;
                cpros C(14) NULL, ;
                datas T NULL, ;
                moevs C(3) NULL, ;
                moevsant C(3) NULL, ;
                pvens N(11,5) NULL, ;
                pvensant N(11,5) NULL, ;
                usuals C(20) NULL, ;
                ckatusite N(1,0) NULL, ;
                dpros C(65) NULL, ;
                cgrus C(3) NULL)
            SET NULL OFF
        ENDIF
    ENDPROC

    *====================================================================
    * Buscar - Reproduz a consulta do legado (PROCEDURE sqldados / Init):
    *
    *   Select a.*, b.dpros, b.cgrus From SigPrPre a, SigCdPro b
    *   Where a.datas Between ?llDatai And ?llDataf
    *     And a.cPros Between ?pcProd and ?pcProdF
    *     And b.cGrus Between ?pcGru  and ?pcGruF
    *     And a.cpros = b.cpros
    *
    * Datas: inicio 00:00:00, fim 23:59:59 (fDtoSQL(llDataf,'23:59:59')
    * no legado). Produto/Grupo: quando o filtro vem VAZIO, o legado
    * usa o sentinela 'zzzzzzzzzz'/'zzz' como limite superior (ou seja,
    * TODOS os produtos/grupos); quando vem preenchido, pcProdF/pcGruF
    * recebem o MESMO valor de pcProd/pcGru - o BETWEEN vira IGUALDADE.
    * Transcrito literal - nao inventar faixa diferente.
    *
    * Resultado vai para cursor_4c_Dados via cursor TEMPORARIO + ZAP +
    * APPEND (SQLEXEC sobre o alias do Grid zeraria ColumnCount).
    *====================================================================
    FUNCTION Buscar(par_dDataIni, par_dDataFim, par_cProduto, par_cGrupo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_oErro
        LOCAL loc_dDataIni, loc_dDataFim, loc_cDtIniBase, loc_cDtFimBase
        LOCAL loc_cDataIniSQL, loc_cDataFimSQL
        LOCAL loc_cProdIni, loc_cProdFim, loc_cGrupoIni, loc_cGrupoFim

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""
        THIS.this_lErroExibido  = .F.

        TRY
            THIS.GarantirCursorDados()

            loc_dDataIni = IIF(INLIST(VARTYPE(par_dDataIni), "D", "T"), par_dDataIni, DATE())
            loc_dDataFim = IIF(INLIST(VARTYPE(par_dDataFim), "D", "T"), par_dDataFim, DATE())

            loc_cDtIniBase = DTOS(loc_dDataIni)
            loc_cDtFimBase = DTOS(loc_dDataFim)
            loc_cDataIniSQL = "'" + SUBSTR(loc_cDtIniBase, 1, 4) + "-" + ;
                SUBSTR(loc_cDtIniBase, 5, 2) + "-" + SUBSTR(loc_cDtIniBase, 7, 2) + "'"
            loc_cDataFimSQL = "'" + SUBSTR(loc_cDtFimBase, 1, 4) + "-" + ;
                SUBSTR(loc_cDtFimBase, 5, 2) + "-" + SUBSTR(loc_cDtFimBase, 7, 2) + ;
                " 23:59:59'"

            loc_cProdIni  = IIF(VARTYPE(par_cProduto) = "C", ALLTRIM(par_cProduto), "")
            loc_cProdFim  = IIF(EMPTY(loc_cProdIni), "zzzzzzzzzz", loc_cProdIni)

            loc_cGrupoIni = IIF(VARTYPE(par_cGrupo) = "C", ALLTRIM(par_cGrupo), "")
            loc_cGrupoFim = IIF(EMPTY(loc_cGrupoIni), "zzz", loc_cGrupoIni)

            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                " a.pvens, a.pvensant, a.usuals, a.ckatusite, b.dpros, b.cgrus" + ;
                " FROM SigPrPre a" + ;
                " INNER JOIN SigCdPro b ON a.cpros = b.cpros" + ;
                " WHERE a.datas BETWEEN " + loc_cDataIniSQL + " AND " + loc_cDataFimSQL + ;
                " AND a.cpros BETWEEN " + EscaparSQL(loc_cProdIni) + " AND " + EscaparSQL(loc_cProdFim) + ;
                " AND b.cgrus BETWEEN " + EscaparSQL(loc_cGrupoIni) + " AND " + EscaparSQL(loc_cGrupoFim)

            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp")

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Erro ao buscar hist" + CHR(243) + "rico de pre" + ;
                    CHR(231) + "os: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
                THIS.this_lErroExibido = .T.
            ELSE
                SELECT cursor_4c_Dados
                ZAP
                IF RECCOUNT("cursor_4c_DadosTemp") > 0
                    APPEND FROM DBF("cursor_4c_DadosTemp")
                ENDIF
                GO TOP IN cursor_4c_Dados
                loc_lSucesso = .T.
            ENDIF

            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em Buscar")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Le a linha CORRENTE do cursor informado para as
    * propriedades do registro selecionado.
    *
    * Padrao canonico: SELECT (par_cAliasCursor) ANTES de acessar os
    * campos, acesso aos campos SEM prefixo de alias, e cada campo
    * protegido por TYPE() porque o mesmo metodo pode atender tanto o
    * cursor da grade (cursor_4c_Dados, com os 2 campos extras do JOIN)
    * quanto, no futuro, um cursor so com as colunas proprias de SigPrPre.
    *
    * PUBLICO de proposito: o Form chama este metodo de fora da classe, e
    * metodo PROTECTED chamado de fora estoura "Property ... is not
    * found" em runtime.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro

        loc_lSucesso = .F.
        loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
            ALLTRIM(par_cAliasCursor), "cursor_4c_Dados")

        TRY
            IF USED(loc_cAlias)
                SELECT (loc_cAlias)

                IF !EOF() AND !BOF()
                    IF TYPE(loc_cAlias + ".cidchaves") != "U"
                        THIS.this_cChave = TratarNulo(cidchaves, "")
                    ENDIF
                    IF TYPE(loc_cAlias + ".cpros") != "U"
                        THIS.this_cProduto = TratarNulo(cpros, "")
                    ENDIF
                    IF TYPE(loc_cAlias + ".datas") != "U"
                        THIS.this_dData = TratarNulo(datas, {})
                    ENDIF
                    IF TYPE(loc_cAlias + ".moevs") != "U"
                        THIS.this_cMoeda = TratarNulo(moevs, "")
                    ENDIF
                    IF TYPE(loc_cAlias + ".moevsant") != "U"
                        THIS.this_cMoedaAnterior = TratarNulo(moevsant, "")
                    ENDIF
                    IF TYPE(loc_cAlias + ".pvens") != "U"
                        THIS.this_nPrecoVenda = TratarNulo(pvens, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".pvensant") != "U"
                        THIS.this_nPrecoVendaAnterior = TratarNulo(pvensant, 0)
                    ENDIF
                    IF TYPE(loc_cAlias + ".usuals") != "U"
                        THIS.this_cUsuario = TratarNulo(usuals, "")
                    ENDIF
                    IF TYPE(loc_cAlias + ".ckatusite") != "U"
                        THIS.this_nCkAtuSite = TratarNulo(ckatusite, 0)
                    ENDIF

                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro selecionado."
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
                    "o est" + CHR(225) + " aberto."
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
            THIS.this_lErroExibido = .T.
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna o valor da chave primaria (Fortyus,
    * cidchaves char(20)) do registro corrente, para RegistrarAuditoria
    * (nunca acionado nesta tela, ver comentario de cabecalho, mas o
    * metodo fica implementado por consistencia com a heranca).
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(NVL(THIS.this_cChave, ""))
    ENDPROC

    *====================================================================
    * Destroy - Fecha os cursores de trabalho criados por este BO.
    *====================================================================
    PROCEDURE Destroy()
        IF USED("cursor_4c_DadosTemp")
            USE IN cursor_4c_DadosTemp
        ENDIF
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

