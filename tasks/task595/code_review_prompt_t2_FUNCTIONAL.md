# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CONTAINER1. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCPD.Container1): Top original=8 vs migrado 'lbl_4c_Label1' Top=455 (diff=447px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRCPD.Container1): Top original=9 vs migrado 'lbl_4c_Label2' Top=455 (diff=446px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRCPD.Container1): Left original=147 vs migrado 'lbl_4c_Label2' Left=92 (diff=55px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCPD.Container2): Top original=10 vs migrado 'lbl_4c_Label1' Top=455 (diff=445px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRCPD.Container2): Top original=10 vs migrado 'lbl_4c_Label2' Top=455 (diff=445px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGPRCPD.Container2): Left original=194 vs migrado 'lbl_4c_Label2' Left=92 (diff=102px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRCPD.Container2): Top original=10 vs migrado 'lbl_4c_Label3' Top=494 (diff=484px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRCPD.Container2): Left original=366 vs migrado 'lbl_4c_Label3' Left=11 (diff=355px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGPRCPD.Container2): Top original=10 vs migrado 'lbl_4c_Label4' Top=532 (diff=522px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGPRCPD.Container2): Left original=147 vs migrado 'lbl_4c_Label4' Left=11 (diff=136px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCPD): Left original=617 vs migrado 'lbl_4c_Label1' Left=11 (diff=606px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprcpd.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1091 linhas total):

*-- Linhas 17 a 232:
17: *   Legado                   Migrado
18: *   -----------------------  -------------------------------------------------
19: *   Init                     Init (mesmos 4 parametros posicionais)
20: *                            + InicializarForm + CarregarLista
21: *   Release (poDataMgr)      Destroy - ver (b)
22: *   9x When (Return .f.)     .ReadOnly = .T. nos 9 TextBox de display
23: *   Grade.AfterRowColChange  GradeAfterRowColChange (via BINDEVENT)
24: *   Sair.Click               BtnSairClick (via BINDEVENT)
25: *   Load  (=fConfigGeral())  NAO PORTADO - ver (a)
26: *
27: * (a) Load: "=fConfigGeral()". fConfigGeral era funcao GLOBAL da aplicacao
28: *     legado (sig.prg / SIGFUNCS.PRG) que NAO veio no acervo. O que existe em
29: *     projeto\app\utils\fconfiggeral.prg e' um wrapper NO-OP (RETURN .T.) cujo
30: *     proprio cabecalho diz: "em codigo NOSSO nunca se chama fConfigGeral -
31: *     este arquivo existe APENAS para binario legado", porque o p-code dos VCX
32: *     o invoca e nao da para editar. Chama-lo daqui seria escrever uma chamada
33: *     que comprovadamente nao faz nada e ainda sugerir que falta alguma
34: *     inicializacao global. O que fConfigGeral fazia esta distribuido e ocorre
35: *     ANTES deste form abrir: config.prg (SETs, paths, aliases globais),
36: *     main.prg (conexao, CarregarEmpresa) e o sigprcpdBO (seus cursores).
37: *     Mesma decisao ja registrada em FormSigMvExp.prg.
38: *
39: * (b) Release: "ThisForm.poDataMgr.Release" + "Dodefault()". poDataMgr era o
40: *     fSqlConector PRIVADO deste form, criado no Init legado
41: *     ("CreateObject('fSqlConector', ThisForm.Name)"); o Release existia so
42: *     para devolver essa conexao. A arquitetura nova nao tem conexao por form:
43: *     usa o handle GLOBAL gnConnHandle, que NAO pode ser liberado ao fechar
44: *     uma tela (derrubaria a aplicacao inteira). O Destroy daqui faz o
45: *     equivalente util - fecha os cursores desta consulta - e chama
46: *     DODEFAULT() para FormBase reconstruir os popups do menu.
47: *
48: * SEM BOTAO CRUD: o legado tem UM UNICO CommandButton (Sair, fwbtng,
49: * "Encerrar", Click = ThisForm.Release) e herda de `form` puro, NAO de
50: * frmcadastro - o dump nao tem Grupo_Op, nao tem pcEscolha e nao tem nenhum
51: * dos quatro verbos da barra CRUD do framework. Por isso este form nao tem os
52: * quatro handlers dessa barra: criar os quatro exigiria INVENTAR botoes que o
53: * legado nao tem (viola o PILAR 1) ou deixar metodos vazios (proibido pela
54: * regra de completude). Os eventos de botao que o legado REALMENTE tem estao
55: * implementados - o de saida e o da grade, na tabela acima.
56: *==============================================================================
57: DEFINE CLASS Formsigprcpd AS FormBase
58: 
59:     DataSession  = 2
60:     ShowWindow = 1
61:     Width        = 800
62:     Height       = 600
63:     Caption      = ""
64:     BorderStyle  = 2
65:     AutoCenter   = .T.
66:     ControlBox   = .F.
67:     Closable     = .F.
68:     MaxButton    = .F.
69:     MinButton    = .F.
70:     Movable      = .F.
71:     ClipControls = .F.
72:     TitleBar     = 0
73:     ShowWindow   = 0
74:     WindowType   = 0
75: 
76:     *-- Business Object
77:     this_oBusinessObject = .NULL.
78: 
79:     *-- Parametros recebidos do chamador (equivalentes ao
80:     *-- LParameters pFase, pUnidade, pData, pCodigo do Init legado)
81:     this_cFasePar    = ""
82:     this_cUnidadePar = ""
83:     this_dDataPar    = {}
84:     this_nCodigoPar  = 0
85: 
86:     *--------------------------------------------------------------------------
87:     * Init - recebe os parametros do legado e define o Caption antes de
88:     * delegar a inicializacao padrao (FormBase.Init -> InicializarForm)
89:     *--------------------------------------------------------------------------
90:     PROCEDURE Init(par_cFase, par_cUnidade, par_dData, par_nCodigo)
91:         THIS.Caption = "Capacidade Produtiva"
92: 
93:         IF VARTYPE(par_cFase) = "C"
94:             THIS.this_cFasePar = par_cFase
95:         ENDIF
96:         IF VARTYPE(par_cUnidade) = "C"
97:             THIS.this_cUnidadePar = par_cUnidade
98:         ENDIF
99:         IF VARTYPE(par_dData) = "D" OR VARTYPE(par_dData) = "T"
100:             THIS.this_dDataPar = par_dData
101:         ENDIF
102:         IF VARTYPE(par_nCodigo) = "N"
103:             THIS.this_nCodigoPar = par_nCodigo
104:         ENDIF
105: 
106:         *-- ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9 -T
107:         *-- (top-level window bloqueante). Producao restaura o modal aqui.
108:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
109:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
110:             THIS.WindowType = 1
111:             THIS.ShowWindow = 1
112:         ENDIF
113: 
114:         RETURN DODEFAULT()
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * InicializarForm - Cria o Business Object e monta a estrutura base do
119:     * form. Chamado automaticamente por FormBase.Init() via DODEFAULT().
120:     *--------------------------------------------------------------------------
121:     PROTECTED PROCEDURE InicializarForm()
122:         LOCAL loc_lSucesso, loc_oErro, loc_lModoValidacaoOuTeste
123: 
124:         loc_lSucesso = .F.
125:         loc_lModoValidacaoOuTeste = (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
126:                                     (TYPE("gb_4c_ModoTeste")   = "L" AND gb_4c_ModoTeste)
127: 
128:         TRY
129:             THIS.this_oBusinessObject = CREATEOBJECT("sigprcpdBO")
130: 
131:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
132:                 MsgErro("Erro ao criar Business Object sigprcpdBO." + CHR(13) + ;
133:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
134:                         "Erro")
135:             ELSE
136:                 *-- Estrutura (controles/grid/botoes) eh SEMPRE montada, com ou
137:                 *-- sem conexao SQL - so o metodo que depende de SQL
138:                 *-- (CarregarLista) eh pulado em modo teste/validacao. Mesmo
139:                 *-- padrao dos forms CRUD (FORMCOR_LICOES_APRENDIDAS.md,
140:                 *-- Problema 4): sem isto, ValidarUIFidelity e qualquer probe
141:                 *-- headless veem o form "vazio" (nenhum controle no PEM),
142:                 *-- mesmo o form tendo instanciado com sucesso.
143:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
144:                 THIS.ConfigurarPageFrame()
145:                 THIS.TornarControlesVisiveis(THIS)
146: 
147:                 IF loc_lModoValidacaoOuTeste
148:                     *-- Sem conexao SQL disponivel: estrutura montada, grade
149:                     *-- nao carregada, para nao travar em modal de erro.
150:                     loc_lSucesso = .T.
151:                 ELSE
152:                     *-- Popula a grade com os parametros recebidos no Init
153:                     *-- (equivalente ao corpo do PROCEDURE Init do legado, que
154:                     *-- so mostra a tela depois de carregar os dados)
155:                     IF THIS.CarregarLista()
156:                         loc_lSucesso = .T.
157:                     ENDIF
158:                 ENDIF
159:             ENDIF
160: 
161:         CATCH TO loc_oErro
162:             MsgErro(loc_oErro.Message + CHR(13) + ;
163:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
164:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
165:         ENDTRY
166: 
167:         RETURN loc_lSucesso
168:     ENDPROC
169: 
170:     *--------------------------------------------------------------------------
171:     * ConfigurarPageFrame - Orquestrador de layout base
172:     * SIGPRCPD original eh flat OPERACIONAL (sem PageFrame nativo): o
173:     * legado nao tem Page1/Page2 nem botoes CRUD (Incluir/Alterar/Excluir/
174:     * Buscar) - so a Grade de operacoes e o botao Sair/Encerrar.
175:     *--------------------------------------------------------------------------
176:     PROTECTED PROCEDURE ConfigurarPageFrame()
177:         THIS.ConfigurarCabecalho()
178:         THIS.ConfigurarContainer1()
179:         THIS.ConfigurarContainer2()
180:         THIS.ConfigurarGrid()
181:         THIS.ConfigurarDetalheProduto()
182:         THIS.ConfigurarBotoes()
183:     ENDPROC
184: 
185:     *--------------------------------------------------------------------------
186:     * ConfigurarContainer1 - Container1 do legado: exibe a Fase/Setor e a
187:     * Data recebidos como parametro (txt_4c_Fase/txt_4c__Data). Ambos os
188:     * TextBoxes tem PROCEDURE When retornando .F. no legado (registro 13 e
189:     * 15 do dump) - nunca recebem foco, sao apenas display - por isso
190:     * ReadOnly = .T. aqui reproduz o comportamento, nao o inventa.
191:     *--------------------------------------------------------------------------
192:     PROTECTED PROCEDURE ConfigurarContainer1()
193:         LOCAL loc_oCnt
194: 
195:         THIS.AddObject("cnt_4c_Container1", "Container")
196:         loc_oCnt = THIS.cnt_4c_Container1
197:         WITH loc_oCnt
198:             .Top           = 104
199:             .Left          = 8
200:             .Width         = 278
201:             .Height        = 36
202:             .BackStyle     = 0
203:             .BorderWidth   = 0
204:             .SpecialEffect = 0
205:             .Visible       = .T.
206:         ENDWITH
207: 
208:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
209:         WITH loc_oCnt.lbl_4c_Label1
210:             .FontBold  = .T.
211:             .FontName  = "Tahoma"
212:             .FontSize  = 8
213:             .BackStyle = 0
214:             .Caption   = "Fase :"
215:             .Height    = 17
216:             .Left      = 2
217:             .Top       = 8
218:             .Width     = 40
219:             .ForeColor = RGB(90, 90, 90)
220:         ENDWITH
221: 
222:         loc_oCnt.AddObject("txt_4c_Fase", "TextBox")
223:         WITH loc_oCnt.txt_4c_Fase
224:             .FontBold  = .T.
225:             .FontName  = "Tahoma"
226:             .FontSize  = 8
227:             .Height    = 23
228:             .Left      = 44
229:             .Top       = 5
230:             .Width     = 100
231:             .BackColor = RGB(255, 198, 140)
232:             .Value     = ""

*-- Linhas 265 a 311:
265:     *--------------------------------------------------------------------------
266:     * ConfigurarContainer2 - Container2 do legado: exibe a capacidade
267:     * agregada (Capacidade/Utilizado/Saldo, em minutos) calculada por
268:     * sigprcpdBO.CarregarDados(). Os tres TextBoxes tambem tem PROCEDURE
269:     * When retornando .F. (registros 35/37/39) - display-only, ReadOnly.
270:     *--------------------------------------------------------------------------
271:     PROTECTED PROCEDURE ConfigurarContainer2()
272:         LOCAL loc_oCnt
273: 
274:         THIS.AddObject("cnt_4c_Container2", "Container")
275:         loc_oCnt = THIS.cnt_4c_Container2
276:         WITH loc_oCnt
277:             .Top           = 104
278:             .Left          = 288
279:             .Width         = 504
280:             .Height        = 36
281:             .BackStyle     = 0
282:             .BorderWidth   = 0
283:             .SpecialEffect = 0
284:             .Visible       = .T.
285:         ENDWITH
286: 
287:         loc_oCnt.AddObject("lbl_4c_Label1", "Label")
288:         WITH loc_oCnt.lbl_4c_Label1
289:             .AutoSize  = .T.
290:             .FontBold  = .T.
291:             .FontName  = "Tahoma"
292:             .FontSize  = 8
293:             .BackStyle = 0
294:             .Caption   = "Capacidade:"
295:             .Height    = 15
296:             .Left      = 9
297:             .Top       = 10
298:             .Width     = 70
299:             .ForeColor = RGB(90, 90, 90)
300:         ENDWITH
301: 
302:         loc_oCnt.AddObject("txt_4c_Cap", "TextBox")
303:         WITH loc_oCnt.txt_4c_Cap
304:             .FontBold   = .T.
305:             .FontName   = "Tahoma"
306:             .FontSize   = 8
307:             .Height     = 23
308:             .InputMask  = "99999"
309:             .Left       = 81
310:             .Top        = 5
311:             .Width      = 63

*-- Linhas 433 a 476:
433:     * ColumnOrder reproduz a ordem visual do SCX legado: Column8 (Unidade
434:     * Prod.) primeiro, seguido de Column1..Column7.
435:     *--------------------------------------------------------------------------
436:     PROTECTED PROCEDURE ConfigurarGrid()
437:         LOCAL loc_oGrid
438: 
439:         THIS.AddObject("grd_4c_Dados", "Grid")
440:         loc_oGrid = THIS.grd_4c_Dados
441: 
442:         WITH loc_oGrid
443:             .Top         = 139
444:             .Left        = 0
445:             .Width       = 801
446:             .Height      = 310
447:             .ColumnCount = 8
448:             .FontName    = "Arial"
449:             .DeleteMark  = .F.
450:             .RecordMark  = .F.
451:             .ReadOnly    = .T.
452:             .ScrollBars  = 2
453:             .Visible     = .T.
454:         ENDWITH
455: 
456:         WITH loc_oGrid.Column1
457:             .ColumnOrder       = 2
458:             .FontName          = "Arial"
459:             .Movable           = .F.
460:             .Resizable         = .F.
461:             .ReadOnly          = .T.
462:             .Header1.FontName  = "Tahoma"
463:             .Header1.FontSize  = 8
464:             .Header1.Alignment = 2
465:             .Header1.ForeColor = RGB(0, 0, 0)
466:             .Text1.FontName    = "Arial"
467:             .Text1.BorderStyle = 0
468:             .Text1.Margin      = 0
469:             .Text1.ReadOnly    = .T.
470:             .Text1.ForeColor   = RGB(0, 0, 0)
471:             .Text1.BackColor   = RGB(255, 255, 255)
472:         ENDWITH
473: 
474:         WITH loc_oGrid.Column2
475:             .ColumnOrder       = 3
476:             .FontName          = "Arial"

*-- Linhas 592 a 649:
592: 
593:         *-- Troca de linha na grade recarrega o detalhe do produto (imagem,
594:         *-- descricao, quantidade, cliente, tempo total do envelope) -
595:         *-- equivalente ao PROCEDURE AfterRowColChange do legado
596:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GradeAfterRowColChange")
597:     ENDPROC
598: 
599:     *--------------------------------------------------------------------------
600:     * CarregarLista - Chama sigprcpdBO.CarregarDados() com os parametros
601:     * recebidos no Init (Fase/Unidade/Data/Codigo) e, com sucesso, faz o
602:     * bind do Grid ao cursor resultante. Equivalente ao trecho final do
603:     * PROCEDURE Init do legado (bind da .grade + Go Top + Refresh).
604:     *
605:     * ControlSource so eh atribuido AQUI (depois do cursor existir - regra
606:     * #41), e Header1.Caption/Column.Width sao reconfigurados DEPOIS do
607:     * RecordSource (Problema 48 - RecordSource reseta os dois).
608:     *
609:     * PUBLIC de proposito (NAO marcar PROTECTED - regra #3 do CLAUDE.md):
610:     * TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da classe,
611:     * guardado so por PEMSTATUS(oForm, "CarregarLista", 5), que devolve .T.
612:     * mesmo para metodo PROTECTED (testa existencia, nao escopo) - com
613:     * PROTECTED o teste entra no branch e a chamada estoura em runtime com
614:     * "Property CARREGARLISTA is not found". Nome canonico do projeto (138
615:     * dos 141 forms OPERACIONAL usam CarregarLista), igual ao visualizador
616:     * de referencia FormSigMvSbn.
617:     *--------------------------------------------------------------------------
618:     FUNCTION CarregarLista()
619:         LOCAL loc_lSucesso, loc_oGrid, loc_cCursor
620: 
621:         loc_lSucesso = .F.
622: 
623:         IF THIS.this_oBusinessObject.CarregarDados(THIS.this_cFasePar, ;
624:                 THIS.this_cUnidadePar, THIS.this_dDataPar, THIS.this_nCodigoPar)
625: 
626:             loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
627:             loc_oGrid   = THIS.grd_4c_Dados
628: 
629:             *-- Container1/Container2: espelha ".container1.Get_Data.Value =
630:             *-- ThisForm.data" / "Get_Fase.Value = ThisForm.Setor" / Get_Cap/
631:             *-- Get_Utz/Get_Sld do legado, lendo do BO (fonte unica - valores
632:             *-- ja normalizados por CarregarDados, ex. ALLTRIM em this_cFases)
633:             THIS.cnt_4c_Container1.txt_4c_Fase.Value  = THIS.this_oBusinessObject.this_cFases
634:             THIS.cnt_4c_Container1.txt_4c__Data.Value = THIS.this_oBusinessObject.this_dDatas
635:             THIS.cnt_4c_Container2.txt_4c_Cap.Value   = THIS.this_oBusinessObject.this_nMinutos
636:             THIS.cnt_4c_Container2.txt_4c_Utz.Value   = THIS.this_oBusinessObject.this_nUtilizados
637:             THIS.cnt_4c_Container2.txt_4c__Sld.Value  = THIS.this_oBusinessObject.this_nSaldos
638: 
639:             *-- RecordSource fora do WITH (regra GRID-WITH): dentro do mesmo
640:             *-- WITH que acessa .ColumnN, o VFP9 pode nao ter recriado as
641:             *-- colunas ainda e estourar "Unknown member COLUMN1".
642:             loc_oGrid.RecordSource = loc_cCursor
643: 
644:             WITH loc_oGrid
645:                 .Column1.ControlSource = loc_cCursor + ".Nenvs"
646:                 .Column2.ControlSource = loc_cCursor + ".Nops"
647:                 .Column3.ControlSource = loc_cCursor + ".Ordems"
648:                 .Column4.ControlSource = loc_cCursor + ".TempoReal"
649:                 .Column5.ControlSource = loc_cCursor + ".Cpros"

*-- Linhas 685 a 783:
685:             *-- no fim do Init legado - carrega o detalhe da 1a linha sem
686:             *-- depender do usuario navegar a grade (SetFocus omitido: o
687:             *-- form ainda nao foi exibido neste ponto - THIS.Show() eh
688:             *-- chamado pelo menu.prg DEPOIS de InicializarForm retornar)
689:             THIS.GradeAfterRowColChange(1)
690: 
691:             loc_lSucesso = .T.
692:         ELSE
693:             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Capacidade Produtiva")
694:         ENDIF
695: 
696:         RETURN loc_lSucesso
697:     ENDFUNC
698: 
699:     *--------------------------------------------------------------------------
700:     * ConfigurarBotoes - Cria o unico botao do form legado (Sair/Encerrar).
701:     * SIGPRCPD nao tem Incluir/Alterar/Excluir/Buscar - eh form OPERACIONAL
702:     * de consulta, aberto ja com todos os parametros pelo chamador.
703:     *--------------------------------------------------------------------------
704:     PROTECTED PROCEDURE ConfigurarBotoes()
705:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
706:         WITH THIS.cmd_4c_Sair
707:             .Top        = 4
708:             .Left       = 725
709:             .Width      = 75
710:             .Height     = 75
711:             .Caption    = "Encerrar"
712:             .Cancel     = .T.
713:             .FontName   = "Comic Sans MS"
714:             .FontBold   = .T.
715:             .FontItalic = .T.
716:             .FontSize   = 8
717:             .ForeColor  = RGB(90, 90, 90)
718:             .BackColor  = RGB(255, 255, 255)
719:             .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
720:             .Themes     = .T.
721:             .Visible    = .T.
722:         ENDWITH
723: 
724:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "BtnSairClick")
725:     ENDPROC
726: 
727:     *--------------------------------------------------------------------------
728:     * BtnSairClick - Encerra o form (equivalente a ThisForm.Release do
729:     * legado). PUBLIC porque eh alvo de BINDEVENT (regra #3).
730:     *--------------------------------------------------------------------------
731:     PROCEDURE BtnSairClick()
732:         THIS.Release()
733:     ENDPROC
734: 
735:     *--------------------------------------------------------------------------
736:     * ConfigurarDetalheProduto - Cria os controles de detalhe da linha
737:     * selecionada na grade (FigJpg/Shape4/Get_descr/Say1-4/Get_qtde/
738:     * Get_Cliente/Get_tEnv/Label1 do legado). Todos os TextBox tem
739:     * PROCEDURE When retornando .F. no legado (registros 9/44/45/48) -
740:     * display-only, ReadOnly = .T. aqui reproduz o comportamento. Valores
741:     * sao populados por GradeAfterRowColChange() a cada troca de linha.
742:     *--------------------------------------------------------------------------
743:     PROTECTED PROCEDURE ConfigurarDetalheProduto()
744:         *-- FigJpg/Shape4: imagem do produto, ocultos ate a 1a troca de
745:         *-- linha achar foto (Visible=.F. no legado, so FigJpg.Visible eh
746:         *-- alternado no AfterRowColChange - Shape4 permanece SEMPRE oculto
747:         *-- no legado, nenhum metodo do dump o torna visivel; reproduzido
748:         *-- fielmente aqui, sem inventar toggle para ele).
749:         THIS.AddObject("img_4c_FigJpg", "Image")
750:         WITH THIS.img_4c_FigJpg
751:             .Top     = 457
752:             .Left    = 459
753:             .Width   = 143
754:             .Height  = 105
755:             .Stretch = 1
756:             .Picture = ""
757:             .Visible = .F.
758:         ENDWITH
759: 
760:         THIS.AddObject("shp_4c_Shape4", "Shape")
761:         WITH THIS.shp_4c_Shape4
762:             .Top     = 455
763:             .Left    = 456
764:             .Width   = 148
765:             .Height  = 109
766:             .Visible = .F.
767:         ENDWITH
768: 
769:         *-- Say2 "Descricao Produto" + Get_descr
770:         THIS.AddObject("lbl_4c_Label2", "Label")
771:         WITH THIS.lbl_4c_Label2
772:             .Top       = 455
773:             .Left      = 92
774:             .Width     = 130
775:             .Height    = 15
776:             .AutoSize  = .F.
777:             .BackStyle = 0
778:             .Alignment = 0
779:             .FontBold  = .T.
780:             .FontName  = "Tahoma"
781:             .FontSize  = 8
782:             .ForeColor = RGB(90, 90, 90)
783:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Produto"

*-- Linhas 921 a 975:
921:     *--------------------------------------------------------------------------
922:     * GradeAfterRowColChange - Recarrega o painel de detalhe da linha
923:     * selecionada na grade (imagem do produto, descricao, quantidade,
924:     * cliente e tempo total do envelope). Equivalente ao PROCEDURE
925:     * AfterRowColChange da Grade no legado (dump, linhas 1209-1244).
926:     *
927:     * PUBLIC + LPARAMETERS par_nColIndex: alvo de BINDEVENT (regra #3),
928:     * que exige metodo PUBLIC declarando o parametro do evento.
929:     *
930:     * A decodificacao do JPG (base64 -> arquivo em disco) eh feita aqui
931:     * (camada de UI) porque o BO so expoe o cursor de detalhe cru -
932:     * ObterDetalheProduto()/CarregarDoCursor() ja documentam essa divisao.
933:     * STRCONV(..., 14) roda uma UNICA vez (decode simples, nao duplo).
934:     *--------------------------------------------------------------------------
935:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
936:         LOCAL loc_cArquivo, loc_cFoto, loc_cCursorProduto, loc_cFigJpgs
937: 
938:         THIS.LockScreen = .T.
939: 
940:         THIS.img_4c_FigJpg.Visible = .F.
941:         THIS.img_4c_FigJpg.Picture = ""
942: 
943:         IF THIS.this_oBusinessObject.CarregarDoCursor(THIS.this_oBusinessObject.this_cCursorGrade)
944: 
945:             loc_cCursorProduto = THIS.this_oBusinessObject.this_cCursorProdutoDetalhe
946: 
947:             IF !EMPTY(THIS.this_oBusinessObject.this_cCpros) AND USED(loc_cCursorProduto) ;
948:                     AND TYPE(loc_cCursorProduto + ".FigJpgs") != "U"
949: 
950:                 loc_cFigJpgs = EVALUATE(loc_cCursorProduto + ".FigJpgs")
951: 
952:                 IF !ISNULL(loc_cFigJpgs) AND !EMPTY(loc_cFigJpgs)
953:                     loc_cArquivo = SYS(2023) + "\sigprcpd.jpg"
954:                     loc_cFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(loc_cFigJpgs, ;
955:                         "data:image/png;base64,", ""), ;
956:                         "data:image/jpeg;base64,", ""), ;
957:                         "data:image/jpg;base64,", ""), 14)
958: 
959:                     IF STRTOFILE(loc_cFoto, loc_cArquivo) > 0
960:                         THIS.img_4c_FigJpg.Picture = loc_cArquivo
961:                         THIS.img_4c_FigJpg.Visible = .T.
962:                     ENDIF
963:                 ENDIF
964:             ENDIF
965: 
966:             THIS.txt_4c_Descr.Value   = THIS.this_oBusinessObject.this_cDpros
967:             THIS.txt_4c_Qtde.Value    = THIS.this_oBusinessObject.this_nQtds
968:             THIS.txt_4c_Cliente.Value = THIS.this_oBusinessObject.this_cRclis
969:             THIS.txt_4c_TEnv.Value    = THIS.this_oBusinessObject.this_nTempU
970: 
971:             THIS.txt_4c_Descr.Refresh()
972:             THIS.txt_4c_Qtde.Refresh()
973:             THIS.txt_4c_Cliente.Refresh()
974:             THIS.txt_4c_TEnv.Refresh()
975:         ENDIF

*-- Linhas 981 a 1024:
981:     * ConfigurarCabecalho - Cria o container cinza escuro superior com os
982:     * labels de titulo (cntSombra/lblSombra/lblTitulo do legado)
983:     *--------------------------------------------------------------------------
984:     PROTECTED PROCEDURE ConfigurarCabecalho()
985:         LOCAL loc_oCab
986: 
987:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
988:         loc_oCab = THIS.cnt_4c_Cabecalho
989:         WITH loc_oCab
990:             .Top         = 0
991:             .Left        = 0
992:             .Width       = THIS.Width
993:             .Height      = 80
994:             .BackColor   = RGB(100, 100, 100)
995:             .BackStyle   = 1
996:             .BorderWidth = 0
997:             .Visible     = .T.
998:         ENDWITH
999: 
1000:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
1001:         WITH loc_oCab.lbl_4c_Sombra
1002:             .Top       = 18
1003:             .Left      = 10
1004:             .Width     = 769
1005:             .Height    = 40
1006:             .AutoSize  = .F.
1007:             .BackStyle = 0
1008:             .WordWrap  = .T.
1009:             .Alignment = 0
1010:             .FontName  = "Tahoma"
1011:             .FontSize  = 18
1012:             .FontBold  = .T.
1013:             .ForeColor = RGB(0, 0, 0)
1014:             .Caption   = THIS.Caption
1015:         ENDWITH
1016: 
1017:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
1018:         WITH loc_oCab.lbl_4c_Titulo
1019:             .Top       = 17
1020:             .Left      = 10
1021:             .Width     = 769
1022:             .Height    = 46
1023:             .AutoSize  = .F.
1024:             .BackStyle = 0

*-- Linhas 1033 a 1091:
1033:     ENDPROC
1034: 
1035:     *--------------------------------------------------------------------------
1036:     * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
1037:     * criados via AddObject (que nascem com Visible=.F.), percorrendo tambem
1038:     * Pages de PageFrames e Controls de sub-containers.
1039:     *--------------------------------------------------------------------------
1040:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1041:         LOCAL loc_nI, loc_oObjeto, loc_nP
1042: 
1043:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1044:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1045: 
1046:             IF VARTYPE(loc_oObjeto) = "O"
1047:                 *-- img_4c_FigJpg/shp_4c_Shape4: comecam ocultos de proposito
1048:                 *-- (Visible=.F. no legado) e so aparecem se
1049:                 *-- GradeAfterRowColChange achar foto do produto - nao forcar
1050:                 *-- Visible=.T. aqui (mesmo padrao de container flutuante)
1051:                 IF INLIST(UPPER(loc_oObjeto.Name), "IMG_4C_FIGJPG", "SHP_4C_SHAPE4")
1052:                     LOOP
1053:                 ENDIF
1054: 
1055:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1056:                     loc_oObjeto.Visible = .T.
1057:                 ENDIF
1058: 
1059:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1060:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1061:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1062:                     ENDFOR
1063:                 ENDIF
1064: 
1065:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1066:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1067:                 ENDIF
1068:             ENDIF
1069:         ENDFOR
1070:     ENDPROC
1071: 
1072:     *--------------------------------------------------------------------------
1073:     * Destroy - Fecha os cursores desta consulta antes de liberar o form
1074:     *--------------------------------------------------------------------------
1075:     PROCEDURE Destroy()
1076:         LOCAL loc_cLista, loc_nI, loc_cNome
1077: 
1078:         loc_cLista = "cursor_4c_Grade,cursor_4c_ProdutoDetalhe,cursor_4c_Pcz," + ;
1079:             "cursor_4c_PcpCap,cursor_4c_Pcg,cursor_4c_Pco,cursor_4c_PcoAgrupado"
1080: 
1081:         FOR loc_nI = 1 TO OCCURS(",", loc_cLista) + 1
1082:             loc_cNome = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))
1083:             IF !EMPTY(loc_cNome) AND USED(loc_cNome)
1084:                 USE IN (loc_cNome)
1085:             ENDIF
1086:         ENDFOR
1087: 
1088:         DODEFAULT()
1089:     ENDPROC
1090: 
1091: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcpdBO.prg):
*====================================================================
* sigprcpdBO.prg
*
* Business Object para Formsigprcpd (Capacidade Produtiva)
* Form OPERACIONAL (nao-CRUD): exibe, para um Envelope/Codigo de OP
* (SigCdPcz.codigos) em uma Fase/Setor e Unidade Produtiva, a capacidade
* de producao (minutos totais/utilizados/saldo, agregados a partir de
* SigCdPcp) e a grade de operacoes vinculadas (SigCdPco join SigCdCli),
* rateando o tempo de cada operacao pela proporcao apurada em SigCdPcg.
*
* Tabela principal para efeitos de ObterChavePrimaria/auditoria: SigCdPco
* (cidchaves char(20) - PK). Nao ha INSERT/UPDATE/DELETE no legado: o
* form apenas consulta e exibe - o comportamento padrao herdado de
* BusinessBase (recusar Inserir/Atualizar/ExecutarExclusao) ja eh o
* correto para este BO.
*
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigprcpdBO AS BusinessBase

    *-- Parametros recebidos do form/menu chamador (equivalentes a
    *-- LPARAMETERS pFase, pUnidade, pData, pCodigo do Init legado)
    this_cFases    = ""    && fases char(10) - Setor/Fase de producao
    this_cUniprdts = ""    && uniprdts char(10) - Unidade Produtiva (opcional)
    this_dDatas    = {}    && datas - Data de referencia da capacidade
    this_nCodigos  = 0     && codigos numeric(10,0) - Codigo do Envelope/OP (SigCdPcz)

    *-- Capacidade agregada (Container2: Capacidade/Utilizado/Saldo),
    *-- somada a partir de SigCdPcp para a Fase/Data/Unidade informadas
    this_nMinutos    = 0   && minutos numeric(9,1) - Capacidade total (minutos)
    this_nUtilizados = 0   && utilizados - minutos ja utilizados
    this_nSaldos     = 0   && saldos numeric(8,1) - Saldo disponivel (minutos)

    *-- Detalhe da linha corrente da grade (AfterRowColChange): dados do
    *-- produto e do cliente da operacao selecionada
    this_cCpros = ""    && cpros char(14) - codigo do produto da operacao
    this_cDpros = ""    && dpros - descricao do produto (SigCdPro.Dpros)
    this_nQtds  = 0     && qtds numeric(9,3) - quantidade da operacao
    this_cRclis = ""    && rclis - razao social do cliente (SigCdCli.Rclis)
    this_nTempU = 0     && tempU - tempo total do envelope (minutos)

    *-- Nome do cursor final que alimenta a grade (equivalente ao
    *-- zTmpPcpOp do legado)
    this_cCursorGrade = "cursor_4c_Grade"

    *-- Nome do cursor de detalhe do produto (equivalente ao CrTmpPro do
    *-- legado), populado por ObterDetalheProduto() a cada troca de linha
    this_cCursorProdutoDetalhe = "cursor_4c_ProdutoDetalhe"

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdPco"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigprcpdBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDados - Carrega a capacidade produtiva e a grade de
    * operacoes de um Envelope/OP (SigCdPcz.codigos), para uma
    * Fase/Setor, Data e (opcionalmente) Unidade Produtiva.
    *
    * Equivalente ao PROCEDURE Init do form legado SIGPRCPD: 4 consultas
    * remotas (validacao do envelope, capacidade agregada, "peso" por
    * envelope/sequencia em SigCdPcg, detalhe das operacoes em SigCdPco
    * + SigCdCli) seguidas de um SELECT local que agrupa o tempo das
    * operacoes por Fase+Unidade+Envelope+Sequencia (restrito as
    * combinacoes que tem "peso" em SigCdPcg) e de um SELECT local final
    * que rateia o tempo total do envelope (SigCdPcg.Minutos) entre as
    * operacoes proporcionalmente ao peso de cada uma.
    *
    * Parametros:
    *   par_cFase    - fases char(10), Setor/Fase de producao (obrigatorio)
    *   par_cUnidade - uniprdts char(10), Unidade Produtiva (opcional)
    *   par_dData    - datas, data de referencia da capacidade (obrigatorio)
    *   par_nCodigo  - codigos numeric(10,0), codigo do Envelope/OP (obrigatorio)
    *
    * Popula: this_nMinutos/this_nUtilizados/this_nSaldos (Container2) e
    * o cursor this_cCursorGrade, com as colunas do legado (nenvs, nops,
    * ordems, cpros, uniprdts, priors, pedido, cliente, rclis, tempu,
    * tempoo, temporeal).
    *
    * Retorno: .T. se sucesso, .F. se falha (mensagem em this_cMensagemErro)
    *====================================================================
    FUNCTION CarregarDados(par_cFase, par_cUnidade, par_dData, par_nCodigo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cFiltroUnid, loc_cCursorGrade

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cFase) != "C" OR EMPTY(par_cFase) OR ;
                        VARTYPE(par_dData) != "D" OR EMPTY(par_dData) OR ;
                        VARTYPE(par_nCodigo) != "N" OR NVL(par_nCodigo, 0) <= 0
                    THIS.this_cMensagemErro = "Fase, Data e C" + CHR(243) + "digo do Envelope s" + CHR(227) + "o obrigat" + CHR(243) + "rios."
                ELSE
                    THIS.this_cFases    = ALLTRIM(par_cFase)
                    THIS.this_cUniprdts = IIF(VARTYPE(par_cUnidade) = "C", ALLTRIM(par_cUnidade), "")
                    THIS.this_dDatas    = par_dData
                    THIS.this_nCodigos  = par_nCodigo

                    THIS.FecharCursoresTemporarios()

                    loc_cCursorGrade = THIS.this_cCursorGrade
                    loc_cFiltroUnid  = IIF(EMPTY(THIS.this_cUniprdts), "", " AND UniPrdts = " + EscaparSQL(THIS.this_cUniprdts))

                    *-- 1) Valida existencia do Envelope/OP (SigCdPcz)
                    loc_cSQL = "SELECT codigos FROM SigCdPcz WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcz")

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Envelope " + TRANSFORM(THIS.this_nCodigos) + " n" + CHR(227) + "o encontrado em SigCdPcz)"
                    ELSE
                        *-- 2) Capacidade agregada (SigCdPcp): Minutos/Utilizados/Saldos
                        loc_cSQL = "SELECT Codigos, SUM(minutos) AS Minutos, SUM(minutos - Saldos) AS Utilizados, SUM(saldos) AS Saldos " + ;
                            "FROM SigCdPcp " + ;
                            "WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                            " AND Datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                            " AND Fases = " + EscaparSQL(THIS.this_cFases) + ;
                            loc_cFiltroUnid + ;
                            " GROUP BY Codigos"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PcpCap")

                        IF loc_nResultado < 1
                            THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Capacidade n" + CHR(227) + "o encontrada em SigCdPcp)"
                        ELSE
                            THIS.this_nMinutos    = NVL(cursor_4c_PcpCap.Minutos, 0)
                            THIS.this_nUtilizados = NVL(cursor_4c_PcpCap.Utilizados, 0)
                            THIS.this_nSaldos     = NVL(cursor_4c_PcpCap.Saldos, 0)

                            *-- 3) "Peso"/tempo total por envelope-sequencia (SigCdPcg)
                            loc_cSQL = "SELECT * FROM SigCdPcg " + ;
                                "WHERE datas = " + FormatarDataSQL(THIS.this_dDatas) + ;
                                " AND fases = " + EscaparSQL(THIS.this_cFases) + ;
                                " AND codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                loc_cFiltroUnid + ;
                                " ORDER BY cidchaves"
                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pcg")

                            IF loc_nResultado < 1
                                THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Programa" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada em SigCdPcg)"
                            ELSE
                                *-- 4) Detalhe das operacoes (SigCdPco + SigCdCli), com Pedido e
                                *-- Cliente ja concatenados no SQL Server (RTRIM no lugar do STR
                                *-- posicional do legado, que aqui so serve para exibicao)
                                loc_cSQL = "SELECT a.*, " + ;
                                    "RTRIM(a.dopes) + '-' + RIGHT('     ' + CONVERT(VARCHAR(6), a.numes), 6) AS Pedido, " + ;
                                    "RTRIM(a.contas) + '-' + RTRIM(b.rclis) AS Cliente, " + ;
                                    "RTRIM(b.rclis) AS Rclis " + ;
                                    "FROM SigCdPco a INNER JOIN SigCdCli b ON a.contas = b.iclis " + ;
                                    "WHERE a.codigos = " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + ;
                                    " AND a.fases = " + EscaparSQL(THIS.this_cFases) + ;
                                    IIF(EMPTY(THIS.this_cUniprdts), "", " AND a.uniprdts = " + EscaparSQL(THIS.this_cUniprdts)) + ;
                                    " ORDER BY a.uniprdts, a.seqs, a.nenvs"
                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pco")

                                IF loc_nResultado < 1
                                    THIS.this_cMensagemErro = "Favor Reinicializar o Processo!!! (Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + "o encontradas em SigCdPco)"
                                ELSE
                                    *-- 5) Agrupa localmente o total de minutos por Fase+Unidade+
                                    *-- Envelope+Sequencia, restrito as combinacoes que existem em
                                    *-- SigCdPcg (equivalente ao zTmpPcpOp3 do legado). Chave
                                    *-- POSICIONAL: Fases/UniPrdts sao char(10) nos dois cursores e
                                    *-- STR() fixa a largura dos numericos - NAO fazer ALLTRIM aqui
                                    *-- (regra: chave posicional concatenada quebra em silencio).
                                    SELECT a.Fases, a.UniPrdts, a.Nenvs, a.Seqs, SUM(a.Minutos) AS Minutos ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                        GROUP BY a.Fases, a.UniPrdts, a.Nenvs, a.Seqs ;
                                        INTO CURSOR cursor_4c_PcoAgrupado READWRITE

                                    *-- 6) Grade final: rateia o tempo total do envelope (b.Minutos)
                                    *-- proporcionalmente ao peso de cada operacao (a.Minutos/c.Minutos).
                                    *-- TempoReal transcreve fStoM((a.minutos*60)/(c.minutos*60)*(b.minutos*60))
                                    *-- do legado (SIGFUNCS.PRG) via ConverterSegundosParaMinutos() -
                                    *-- ver comentario da funcao mais abaixo. Guard IIF(c.Minutos=0,...)
                                    *-- evita erro de divisao por zero que o legado nao previa.
                                    SELECT a.*, b.Minutos AS TempU, c.Minutos AS TempoO, ;
                                        ConverterSegundosParaMinutos(IIF(NVL(c.Minutos, 0) = 0, 0, (a.Minutos * 60) / (c.Minutos * 60) * (b.Minutos * 60))) AS TempoReal ;
                                        FROM cursor_4c_Pco a, cursor_4c_Pcg b, cursor_4c_PcoAgrupado c ;
                                        WHERE a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            b.Fases + b.UniPrdts + STR(b.Nenvs, 10) + STR(b.Seqs, 2) ;
                                          AND a.Fases + a.UniPrdts + STR(a.Nenvs, 10) + STR(a.Seqs, 2) = ;
                                            c.Fases + c.UniPrdts + STR(c.Nenvs, 10) + STR(c.Seqs, 2) ;
                                        ORDER BY b.Ordems, a.UniPrdts, a.Seqs, a.Nenvs ;
                                        INTO CURSOR (loc_cCursorGrade) READWRITE

                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ObterDetalheProduto - Busca descricao e imagem (base64) do produto
    * de uma linha da grade (SigCdPro), para exibicao ao trocar a linha
    * selecionada. Equivalente a parte de consulta do AfterRowColChange
    * do legado - decodificar o base64 e gravar o JPG em disco eh
    * responsabilidade do Form (camada de UI), nao do BO.
    *
    * Parametro: par_cCpros - cpros char(14), codigo do produto
    * Popula: cursor this_cCursorProdutoDetalhe (colunas Dpros, FigJpgs)
    * Retorno: .T. se encontrou o produto, .F. caso contrario
    *====================================================================
    FUNCTION ObterDetalheProduto(par_cCpros)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel."
            ELSE
                IF VARTYPE(par_cCpros) != "C" OR EMPTY(par_cCpros)
                    THIS.this_cMensagemErro = "C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado."
                ELSE
                    IF USED(THIS.this_cCursorProdutoDetalhe)
                        USE IN (THIS.this_cCursorProdutoDetalhe)
                    ENDIF

                    loc_cSQL = "SELECT FigJpgs, Dpros FROM SigCdPro WHERE Cpros = " + EscaparSQL(ALLTRIM(par_cCpros))
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorProdutoDetalhe)

                    IF loc_nResultado < 1
                        THIS.this_cMensagemErro = "Produto " + ALLTRIM(par_cCpros) + " n" + CHR(227) + "o encontrado em SigCdPro."
                    ELSE
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em ObterDetalheProduto")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega o detalhe da LINHA CORRENTE da grade
    * para as propriedades do BO. Equivalente a parte de LEITURA do
    * AfterRowColChange do form legado SIGPRCPD (dump, linhas 1231-1240):
    *     ThisForm.Get_descr.Value   = CrTmpPro.Dpros
    *     ThisForm.Get_qtde.Value    = zTmpPcpOp.Qtds
    *     ThisForm.Get_cliente.Value = zTmpPcpOp.Rclis
    *     ThisForm.Get_tEnv.Value    = zTmpPcpOp.TempU
    * O legado termina o handler com "Select zTmpPcpOp" - reproduzido aqui
    * pelo SELECT (loc_cAlias), para a area de trabalho corrente continuar
    * sendo a da grade quando o metodo retorna (o SQLEXEC do lookup de
    * produto troca a area corrente no meio do caminho).
    *
    * Metodo PUBLIC de proposito: quem chama eh o handler de
    * AfterRowColChange do Form, de FORA da classe. PROTECTED falharia em
    * runtime com "Property CARREGARDOCURSOR is not found", e o
    * PEMSTATUS(oBO, "CarregarDoCursor", 5) que costuma cercar a chamada
    * devolveria .T. sem proteger (so verifica existencia, nao escopo).
    *
    * Parametro: par_cAliasCursor - alias do cursor da grade. Omitido ou
    *            vazio, assume THIS.this_cCursorGrade.
    * Popula: this_cCpros, this_nQtds, this_cRclis, this_nTempU (da linha
    *         corrente da grade) e this_cDpros (lookup em SigCdPro).
    * Retorno: .T. se a linha foi lida - inclusive grade VAZIA, que apenas
    *          limpa o detalhe; .F. so se o cursor da grade nao existe.
    *
    * NOTA sobre retorno .T. com this_cMensagemErro preenchido: falha
    * APENAS no lookup da descricao do produto NAO invalida a leitura da
    * linha. Nesse caso this_cDpros fica vazio, a mensagem eh PRESERVADA
    * para o caller exibir se quiser, e o retorno continua .T.
    *====================================================================
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias

        loc_lSucesso = .F.
        THIS.this_cMensagemErro = ""

        TRY
            loc_cAlias = IIF(VARTYPE(par_cAliasCursor) = "C" AND !EMPTY(par_cAliasCursor), ;
                ALLTRIM(par_cAliasCursor), THIS.this_cCursorGrade)

            IF !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor " + loc_cAlias + " n" + CHR(227) + ;
                    "o est" + CHR(225) + " dispon" + CHR(237) + "vel."
            ELSE
                SELECT (loc_cAlias)

                THIS.LimparDetalhe()

                IF RECCOUNT(loc_cAlias) = 0 OR EOF(loc_cAlias)
                    *-- Grade sem linha posicionada: o detalhe fica limpo. O
                    *-- legado nunca chega aqui, porque a grade so dispara
                    *-- AfterRowColChange com uma linha valida selecionada.
                    loc_lSucesso = .T.
                ELSE
                    *-- Leitura por EVALUATE com guarda de TYPE() != "U": coluna
                    *-- ausente no cursor estouraria "Variable X is not found"
                    *-- em RUNTIME, compilando limpo. TratarNulo cobre o valor
                    *-- NULL (2o argumento eh o valor PADRAO, nao codigo de tipo).
                    *-- Tipos conferidos em docs\schema.sql (SigCdPco):
                    *-- cpros char(14), qtds numeric(9,3); Rclis vem do
                    *-- RTRIM(b.rclis) e TempU do SigCdPcg.Minutos numeric(9,1).
                    IF TYPE(loc_cAlias + ".Cpros") != "U"
                        THIS.this_cCpros = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Cpros"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".Qtds") != "U"
                        THIS.this_nQtds = TratarNulo(EVALUATE(loc_cAlias + ".Qtds"), 0)
                    ENDIF

                    IF TYPE(loc_cAlias + ".Rclis") != "U"
                        THIS.this_cRclis = ALLTRIM(TratarNulo(EVALUATE(loc_cAlias + ".Rclis"), ""))
                    ENDIF

                    IF TYPE(loc_cAlias + ".TempU") != "U"
                        THIS.this_nTempU = TratarNulo(EVALUATE(loc_cAlias + ".TempU"), 0)
                    ENDIF

                    *-- Descricao do produto (SigCdPro.Dpros), como o legado faz
                    *-- inline no AfterRowColChange. O cursor de detalhe fica
                    *-- disponivel para o Form ler FigJpgs e gerar o JPG (a
                    *-- decodificacao base64 eh responsabilidade da UI).
                    IF !EMPTY(THIS.this_cCpros)
                        IF THIS.ObterDetalheProduto(THIS.this_cCpros)
                            IF TYPE(THIS.this_cCursorProdutoDetalhe + ".Dpros") != "U"
                                THIS.this_cDpros = ALLTRIM(TratarNulo(EVALUATE(THIS.this_cCursorProdutoDetalhe + ".Dpros"), ""))
                            ENDIF
                        ENDIF
                    ENDIF

                    *-- Repoe a grade como area corrente (o SQLEXEC do lookup
                    *-- selecionou o cursor de detalhe) - "Select zTmpPcpOp".
                    IF USED(loc_cAlias)
                        SELECT (loc_cAlias)
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * LimparDetalhe - Zera as propriedades de detalhe da linha (produto,
    * quantidade, cliente e tempo do envelope). Usado no inicio de
    * CarregarDoCursor e quando a grade nao tem linha posicionada, para o
    * painel inferior nao exibir o detalhe da linha ANTERIOR.
    *
    * PUBLIC de proposito: o Form tambem limpa o painel ao recarregar a
    * grade (chamada de FORA da classe - mesma razao de CarregarDoCursor).
    *====================================================================
    PROCEDURE LimparDetalhe()
        THIS.this_cCpros = ""
        THIS.this_cDpros = ""
        THIS.this_nQtds  = 0
        THIS.this_cRclis = ""
        THIS.this_nTempU = 0
    ENDPROC

    *====================================================================
    * FecharCursoresTemporarios - Fecha os cursores intermediarios desta
    * consulta antes de recarregar (evita "Table buffer contains
    * uncommitted changes" numa segunda chamada a CarregarDados).
    *====================================================================
    PROTECTED PROCEDURE FecharCursoresTemporarios()
        LOCAL loc_cLista, loc_nI, loc_cNome

        loc_cLista = "cursor_4c_Pcz,cursor_4c_PcpCap,cursor_4c_Pcg,cursor_4c_Pco," + ;
            "cursor_4c_PcoAgrupado," + THIS.this_cCursorGrade

        FOR loc_nI = 1 TO OCCURS(",", loc_cLista) + 1
            loc_cNome = ALLTRIM(GETWORDNUM(loc_cLista, loc_nI, ","))
            IF !EMPTY(loc_cNome) AND USED(loc_cNome)
                USE IN (loc_cNome)
            ENDIF
        ENDFOR
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Este BO eh somente-consulta (form legado
    * SIGPRCPD nao tem INSERT/UPDATE/DELETE - o comportamento padrao
    * herdado de BusinessBase, que recusa Inserir/Atualizar/
    * ExecutarExclusao, ja eh o correto). Metodo mantido apenas por
    * padrao arquitetural; chave conceitual eh o codigo do Envelope/OP.
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

ENDDEFINE

*====================================================================
* ConverterSegundosParaMinutos - Converte um valor em SEGUNDOS para o
* formato decimal Minutos.Segundos (ex.: 755 segundos -> 12.35, ou
* seja, 12 minutos e 35 segundos), usado na coluna "Minutos" da grade
* (Column4, InputMask "9999.99").
*
* Transcricao literal de Function fStoM(pHor) em SIGFUNCS.PRG (Framework
* legado Fortyus, C:\4install\FortyusMC\Fortyus\SIGFUNCS.PRG:188-190):
*   Return Round(Int(pHor/60) + Abs(pHor-(Int(pHor/60)*60))/100, 2)
* Nome novo por exigencia do PILAR 3 - contrato numerico identico ao
* original (mesma entrada/saida para qualquer valor).
*
* Funcao GLOBAL (fora do DEFINE CLASS) para poder ser chamada por nome
* dentro da lista de colunas de um SELECT VFP local, igual ao fStoM(...)
* do legado - config.prg carrega este .prg via ADIR (*BO.prg) e a torna
* disponivel no PATH de procedures do sistema.
*====================================================================
FUNCTION ConverterSegundosParaMinutos(par_nSegundos)
    LOCAL loc_nMinutos

    IF VARTYPE(par_nSegundos) != "N"
        RETURN 0
    ENDIF

    loc_nMinutos = INT(par_nSegundos / 60)
    RETURN ROUND(loc_nMinutos + ABS(par_nSegundos - (loc_nMinutos * 60)) / 100, 2)
ENDFUNC

