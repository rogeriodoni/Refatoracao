# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (18)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_RESUMO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarCursoresImpressao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResultadoDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarReportForm()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarCabecalhoImpressao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Entradas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Saidas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Saldos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_SaldoAnt' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Falhas' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Resumo' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRFEM.Resultado.Resumo): Top original=142 vs migrado 'lbl_4c_Label1' Top=90 (diff=52px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRFEM.Resultado.Resumo): Left original=162 vs migrado 'lbl_4c_Label1' Left=530 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRFEM.Resultado.Resumo): Top original=211 vs migrado 'lbl_4c_Label3' Top=90 (diff=121px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGPRFEM.Resultado.Resumo): Left original=164 vs migrado 'lbl_4c_Label3' Left=398 (diff=234px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGPRFEM.Resultado.Resumo): Top original=50 vs migrado 'lbl_4c_Label4' Top=118 (diff=68px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGPRFEM.Resultado.Resumo): Left original=39 vs migrado 'lbl_4c_Label4' Left=377 (diff=338px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1892 linhas total):

*-- Linhas 16 a 243:
16: * com 5 sub-containers (Detalhe/detalhe2/detalhe3/detalhe4/detalhe5), cada
17: * um com um Grid de 3 colunas, e o container Resumo com os totalizadores.
18: *
19: * Fase 3/8 entregou so a "casca": Init/InicializarForm + cabecalho.
20: *
21: * Fase 4/8 acrescenta:
22: *   - os grids/containers de resultado (cnt_4c_Resultado com os 5
23: *     sub-containers de detalhe e o container Resumo com os totalizadores)
24: *     - todos Visible=.F. ate o botao Processar rodar, exceto o Resumo,
25: *     que acompanha o Resultado;
26: *   - a barra de acao do topo direito (shp_4c_Shape2/shp_4c_Shape1 +
27: *     cmd_4c_Visualizar/cmd_4c_Imprimir/cmd_4c_Processar/cmd_4c_Sair),
28: *     criada DEPOIS do cabecalho porque fica sobre a faixa cinza;
29: *   - os cursores da area de Resultado (CriarCursoresResultado, equivalente
30: *     ao PROCEDURE Load do legado) e o bind das 5 grades + o espelho dos
31: *     totalizadores (CarregarDados/LigarGradeDetalhe/AtualizarResumo),
32: *     transcritos do trecho final de Processar.Click.
33: *
34: * Fase 5/8 acrescentou a metade dos campos de filtro do topo: a faixa do
35: * Periodo (lbl_4c_Label3 "Periodo :" + txt_4c_Datai + lbl_4c_Label1 "a" +
36: * txt_4c_Dataf), via ConfigurarFiltros().
37: *
38: * Fase 6/8 completa ConfigurarFiltros() com o campo restante - lbl_4c_Label4
39: * ("Tipo Analise :", SIGPRFEM.Say4) + txt_4c_Demonstrativo
40: * (SIGPRFEM.Get_Demonstrativo) - e implementa o lookup completo (PUBLIC,
41: * por causa do BINDEVENT): TeclaDemonstrativo (KeyPress F4/Enter/Tab) +
42: * ValidarDemonstrativo (match exato em SigPrDmo.Nome) + AbrirBuscaDemonstrativo
43: * (FormBuscaAuxiliar, tabela single-column - substitui o fwBuscaExt legado).
44: *
45: * Fase 7/8 acrescenta os eventos dos QUATRO botoes de acao, ligados por
46: * BINDEVENT em ConfigurarBotoesAcao e PUBLIC (BINDEVENT falha em silencio com
47: * metodo PROTECTED):
48: *   - BtnProcessarClick  (SIGPRFEM.Processar.Click) - as 3 validacoes com
49: *     SetFocus + delegacao do calculo ao SigPrFemBO.Processar + CarregarDados
50: *     + montagem dos cursores de impressao;
51: *   - BtnVisualizarClick (SIGPRFEM.Visualizar.Click) - REPORT FORM PREVIEW;
52: *   - BtnImprimirClick   (SIGPRFEM.Imprimir.Click)   - REPORT FORM TO PRINTER
53: *     PROMPT;
54: *   - BtnSairClick       (SIGPRFEM.Sair.Click)       - ThisForm.Release.
55: * Mais os auxiliares de suporte: ResultadoDisponivel (gate comum de Video/
56: * Impressora), MontarCursoresImpressao / MontarCabecalhoImpressao (bloco
57: * "Criando a Impressao" do fim do Click legado) e ExecutarReportForm (helper
58: * canonico: guard de FRX, guard de cursor vazio, isolamento de locale e
59: * restauracao do menu).
60: *
61: * Fase 8/8 fecha os eventos auxiliares que faltavam do dump e consolida o
62: * estado da tela:
63: *   - o "PROCEDURE When / Return .F." dos DEZ totalizadores de cnt_4c_Resumo,
64: *     transcrito como .TabStop = .F. em AdicionarTotalizador (BINDEVENT nao
65: *     serve para When - descarta o retorno do delegate);
66: *   - LimparResultado() - devolve a area de Resultado ao estado inicial
67: *     (container e os 5 detalhes escondidos, os 10 totais zerados), no ponto
68: *     em que o legado faz "ThisForm.Resultado.Visible = .f.";
69: *   - HabilitarCampos(par_lHabilitar) + a property this_lProcessando -
70: *     guard de reentrancia do botao Processar, reposto nos DOIS caminhos de
71: *     volta (sucesso e CATCH).
72: *
73: * O SCX legado NAO tem botao CRUD (Incluir/Alterar/Visualizar-registro/
74: * Excluir), nem Salvar/Cancelar, nem pagina de Lista: SIGPRFEM eh tela de
75: * processamento/analise, e os quatro botoes acima sao os unicos CommandButton
76: * do dump. Por isso este form nao tem BtnSalvarClick/BtnCancelarClick/
77: * BtnBuscarClick/CarregarLista/AjustarBotoesPorModo nem o par FormParaBO/
78: * BOParaForm: nao ha registro para gravar nem lista para navegar. O
79: * equivalente de FormParaBO aqui eh a leitura dos tres filtros no inicio de
80: * BtnProcessarClick (repassados a SigPrFemBO.Processar), e o equivalente de
81: * BOParaForm eh AtualizarResumo(), que espelha as properties this_n* do BO
82: * nos dez totalizadores. Inventar os handlers CRUD violaria o PILAR 1 e a
83: * regra "NUNCA inventar".
84: *
85: * Os DEZ PROCEDURE do dump legado e onde cada um foi parar:
86: *   posbalanco  -> SigPrFemBO.PosBalanco()          (Fase 2)
87: *   Load        -> CriarCursoresResultado()          (Fase 4)
88: *   Init        -> SigPrFemBO.Init() (os CursorQuery) + Init/InicializarForm
89: *   Release     -> Destroy()                         (libera o BO/cursores)
90: *   When x10    -> .TabStop = .F. em AdicionarTotalizador
91: *   Processar   -> BtnProcessarClick + SigPrFemBO.Processar()
92: *   Valid (Get_Demonstrativo) -> ValidarDemonstrativo/AbrirBuscaDemonstrativo
93: *   Visualizar  -> BtnVisualizarClick        Imprimir -> BtnImprimirClick
94: *   Sair        -> BtnSairClick
95: * O =fConfigGeral() do Load NAO eh chamado: o wrapper projeto\app\utils\
96: * fconfiggeral.prg eh no-op e existe so para o p-code dos VCX legado (regra
97: * #27); em codigo nosso a configuracao global ja veio do config.prg/main.prg.
98: *==============================================================================
99: DEFINE CLASS FormSigPrFem AS FormBase
100: 
101:     *-- Layout legado: 1000x600, sem TitleBar/ControlBox/MaxButton/MinButton
102:     Width        = 1000
103:     Height       = 600
104:     AutoCenter   = .T.
105:     BorderStyle  = 2
106:     ShowWindow = 1
107:     WindowType = 1
108:     ControlBox   = .F.
109:     Closable     = .F.
110:     MaxButton    = .F.
111:     MinButton    = .F.
112:     ClipControls = .F.
113:     TitleBar     = 0
114:     DataSession  = 2
115: 
116:     *-- .T. quando Processar terminou E os cursores de impressao (TmpImp/
117:     *-- Cabecalho) foram montados. Eh o gate dos botoes Video/Impressora -
118:     *-- equivale ao "If thisform.resultado.Visible" do legado, so que sem
119:     *-- depender apenas da visibilidade do container.
120:     this_lResultadoPronto = .F.
121: 
122:     *-- Guard de reentrancia do botao Processar. O calculo do SigPrFemBO exibe
123:     *-- barra de progresso (fwprogressbar), e cada .Refresh() dela devolve a
124:     *-- vez ao VFP: sem este guard um segundo clique em Processar entraria em
125:     *-- BtnProcessarClick com o primeiro ainda rodando, e as duas execucoes
126:     *-- disputariam os MESMOS cursores (ZAP/SCAN/REPLACE simultaneos sobre
127:     *-- cursor_4c_Entradas/Saidas/Saldos/SaldoAnt/Falhas/Resumo).
128:     this_lProcessando = .F.
129: 
130:     *==========================================================================
131:     PROCEDURE Init()
132:     *==========================================================================
133:         THIS.this_cTituloForm = "An" + CHR(225) + "lise de Produ" + CHR(231) + CHR(227) + "o"
134: 
135:         RETURN DODEFAULT()
136:     ENDPROC
137: 
138:     *==========================================================================
139:     PROTECTED PROCEDURE InicializarForm()
140:     *==========================================================================
141:         LOCAL loc_lSucesso, loc_oErro
142:         loc_lSucesso = .F.
143: 
144:         TRY
145:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
146: 
147:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrFemBO")
148:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
149:                 MsgErro("Falha ao criar SigPrFemBO." + CHR(13) + ;
150:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
151:                         "Erro em FormSigPrFem.InicializarForm")
152:             ELSE
153:                 THIS.this_oBusinessObject.this_oFormUI = THIS
154: 
155:                 *-- Cursores da area de Resultado (equivale ao PROCEDURE Load
156:                 *-- do legado, que roda ANTES do Init)
157:                 THIS.CriarCursoresResultado()
158: 
159:                 *-- Compor layout (flat OPERACIONAL, sem PageFrame CRUD)
160:                 THIS.ConfigurarPageFrame()
161: 
162:                 *-- Ecoar Caption nas labels do cabecalho (apos ConfigurarPageFrame)
163:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
164:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
165: 
166:                 *-- Tornar controles visiveis (AddObject cria com Visible=.F.)
167:                 THIS.TornarControlesVisiveis()
168: 
169:                 loc_lSucesso = .T.
170:             ENDIF
171:         CATCH TO loc_oErro
172:             MsgErro(loc_oErro.Message + CHR(13) + ;
173:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
174:                     "Procedure: " + loc_oErro.Procedure, ;
175:                     "Erro em FormSigPrFem.InicializarForm")
176:         ENDTRY
177: 
178:         RETURN loc_lSucesso
179:     ENDPROC
180: 
181:     *==========================================================================
182:     PROTECTED PROCEDURE ConfigurarPageFrame()
183:     *==========================================================================
184:     * OPERACIONAL flat - o legado SIGPRFEM nao usa PageFrame; os controles
185:     * (filtros, botoes, container Resultado) ficam diretamente sobre o Form.
186:     * Este metodo orquestra a composicao das regioes do form: cabecalho
187:     * (cntSombra) + container Resultado (5 grids de detalhe + Resumo) + barra
188:     * de acao do topo direito (Shapes + Video/Impressora/Processar/Encerrar).
189:     * As Fases 5-6 acrescentam os filtros/labels do topo e a Fase 7-8 os
190:     * eventos dos botoes de acao. Nome preservado por compatibilidade com o
191:     * pipeline de migracao.
192:     *
193:     * A barra de acao eh a ULTIMA: os botoes ficam em Top = 3, dentro da area
194:     * da faixa cinza do cabecalho, e so aparecem se criados depois dela.
195:     *==========================================================================
196:         THIS.ConfigurarCabecalho()
197:         THIS.ConfigurarFiltros()
198:         THIS.ConfigurarResultado()
199:         THIS.ConfigurarBotoesAcao()
200:     ENDPROC
201: 
202:     *==========================================================================
203:     PROTECTED PROCEDURE ConfigurarCabecalho()
204:     *==========================================================================
205:     * Cria cnt_4c_Sombra com lbl_4c_LblSombra (sombra preta) e lbl_4c_LblTitulo
206:     * (texto branco) - replica cntSombra/lblSombra/lblTitulo do legado
207:     * (SIGPRFEM.SCX), com o titulo definido em runtime a partir de THIS.Caption
208:     * (mesmo padrao do legado: ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption).
209:     *==========================================================================
210:         LOCAL loc_oCab, loc_oErro
211:         TRY
212:             THIS.AddObject("cnt_4c_Sombra", "Container")
213:             loc_oCab = THIS.cnt_4c_Sombra
214:             WITH loc_oCab
215:                 .Top         = 0
216:                 .Left        = 0
217:                 .Width       = THIS.Width
218:                 .Height      = 80
219:                 .BackStyle   = 1
220:                 .BackColor   = RGB(100, 100, 100)
221:                 .BorderWidth = 0
222:                 .Visible     = .T.
223:             ENDWITH
224: 
225:             loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
226:             WITH loc_oCab.lbl_4c_LblSombra
227:                 .AutoSize  = .F.
228:                 .Top       = 18
229:                 .Left      = 10
230:                 .Width     = loc_oCab.Width - 20
231:                 .Height    = 40
232:                 .FontBold  = .T.
233:                 .FontName  = "Tahoma"
234:                 .FontSize  = 18
235:                 .WordWrap  = .T.
236:                 .Alignment = 0
237:                 .BackStyle = 0
238:                 .ForeColor = RGB(0, 0, 0)
239:                 .Caption   = ""
240:                 .Visible   = .T.
241:             ENDWITH
242: 
243:             loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")

*-- Linhas 261 a 322:
261:         CATCH TO loc_oErro
262:             MsgErro(loc_oErro.Message + CHR(13) + ;
263:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
264:                     "Procedure: " + loc_oErro.Procedure, ;
265:                     "Erro em FormSigPrFem.ConfigurarCabecalho")
266:         ENDTRY
267:     ENDPROC
268: 
269:     *==========================================================================
270:     PROTECTED PROCEDURE ConfigurarFiltros()
271:     *==========================================================================
272:     * Campos de filtro diretamente sobre o Form (SIGPRFEM nao tem PageFrame -
273:     * regra OPERACIONAL flat). Fase 5/8 acrescentou a faixa do Per?odo
274:     * (Label3 "Per?odo :" + Get_Datai + Label1 "a" + Get_Dataf), transcrita
275:     * do dump (SIGPRFEM.Label3/Get_Datai/Label1/Get_Dataf).
276:     *
277:     * Fase 6/8 acrescenta o label Say4 ("Tipo An" + CHR(225) + "lise :") e o
278:     * campo Get_Demonstrativo (txt_4c_Demonstrativo), com o lookup fwBuscaExt
279:     * do legado migrado para FormBuscaAuxiliar (SigPrDmo.Nome, tabela
280:     * single-column). BINDEVENT + handlers (TeclaDemonstrativo/
281:     * ValidarDemonstrativo/AbrirBuscaDemonstrativo) ficam logo apos este
282:     * metodo, PUBLIC (regra do BINDEVENT - metodos PROTECTED falham em
283:     * silencio).
284:     *
285:     * Get_Datai/Get_Dataf sao TextBox de DATA (.Value = {}, nao string vazia -
286:     * o legado tem Format = "K" + Value = {}), preenchidos pelo usuario ou
287:     * validados no Click de Processar (Fases 7-8). Label1 ("a") eh o
288:     * separador entre as duas datas - AutoSize=.T. no dump, mas AddObject
289:     * ignora AutoSize (regra #23): usar AutoSize=.F. + Width/Height do dump.
290:     *==========================================================================
291:         LOCAL loc_oErro
292:         TRY
293:             *-- "Per?odo :" (SIGPRFEM.Label3)
294:             THIS.AddObject("lbl_4c_Label3", "Label")
295:             WITH THIS.lbl_4c_Label3
296:                 .AutoSize  = .F.
297:                 .FontName  = "Tahoma"
298:                 .FontSize  = 8
299:                 .BackStyle = 0
300:                 .Alignment = 0
301:                 .ForeColor = RGB(90, 90, 90)
302:                 .Caption   = "Per" + CHR(237) + "odo :"
303:                 .Left      = 398
304:                 .Top       = 90
305:                 .Width     = 45
306:                 .Height    = 15
307:                 .Visible   = .T.
308:             ENDWITH
309: 
310:             *-- Data inicial (SIGPRFEM.Get_Datai)
311:             THIS.AddObject("txt_4c_Datai", "TextBox")
312:             WITH THIS.txt_4c_Datai
313:                 .FontName      = "Tahoma"
314:                 .FontSize      = 8
315:                 .Alignment     = 0
316:                 .BackStyle     = 1
317:                 .BorderStyle   = 1
318:                 .Value         = {}
319:                 .Format        = "K"
320:                 .SpecialEffect = 1
321:                 .ForeColor     = RGB(0, 0, 0)
322:                 .BorderColor   = RGB(100, 100, 100)

*-- Linhas 409 a 618:
409:                 .Visible       = .T.
410:             ENDWITH
411: 
412:             *-- BINDEVENT: F4/DblClick abrem o picker direto; Enter/Tab
413:             *-- disparam a validacao (equivalente ao PROCEDURE Valid do legado)
414:             BINDEVENT(THIS.txt_4c_Demonstrativo, "DblClick", THIS, "AbrirBuscaDemonstrativo")
415:             BINDEVENT(THIS.txt_4c_Demonstrativo, "KeyPress", THIS, "TeclaDemonstrativo")
416:         CATCH TO loc_oErro
417:             MsgErro(loc_oErro.Message + CHR(13) + ;
418:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
419:                     "Procedure: " + loc_oErro.Procedure, ;
420:                     "Erro em FormSigPrFem.ConfigurarFiltros")
421:         ENDTRY
422:     ENDPROC
423: 
424:     *==========================================================================
425:     PROCEDURE TeclaDemonstrativo(par_nKeyCode, par_nShiftAltCtrl)
426:     *==========================================================================
427:     * Handler de KeyPress de txt_4c_Demonstrativo (BINDEVENT exige PUBLIC -
428:     * regra #3). F4(115) abre o picker direto; Enter(13)/Tab(9) disparam a
429:     * validacao - equivalente ao PROCEDURE Valid do legado (Get_Demonstrativo),
430:     * que roda ao sair do campo.
431:     *==========================================================================
432:         IF par_nKeyCode = 115
433:             THIS.AbrirBuscaDemonstrativo()
434:         ENDIF
435:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
436:             THIS.ValidarDemonstrativo()
437:         ENDIF
438:     ENDPROC
439: 
440:     *==========================================================================
441:     PROCEDURE ValidarDemonstrativo()
442:     *==========================================================================
443:     * Transcricao do PROCEDURE Valid de SIGPRFEM.Get_Demonstrativo: campo
444:     * vazio limpa (legado: This.Value = ''); campo preenchido tenta match
445:     * exato em SigPrDmo.Nome e, sem match, abre o picker (o legado sempre
446:     * chama fwBuscaExt, que ja faz o match exato sozinho - aqui a checagem
447:     * exata fica explicita para nao depender de reabrir o FormBuscaAuxiliar
448:     * so para confirmar um valor ja digitado corretamente).
449:     *==========================================================================
450:         LOCAL loc_cValor, loc_cSQL, loc_nResultado, loc_oErro
451: 
452:         IF VARTYPE(THIS.txt_4c_Demonstrativo) != "O"
453:             RETURN
454:         ENDIF
455: 
456:         TRY
457:             loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
458:             IF EMPTY(loc_cValor)
459:                 THIS.txt_4c_Demonstrativo.Value = ""
460:             ELSE
461:                 loc_cSQL = "SELECT TOP 1 Nome FROM SigPrDmo WHERE Nome = " + ;
462:                            EscaparSQL(loc_cValor)
463:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FemDmoVal")
464:                 IF loc_nResultado > 0 AND !EOF("cursor_4c_FemDmoVal")
465:                     SELECT cursor_4c_FemDmoVal
466:                     THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoVal.Nome)
467:                 ELSE
468:                     THIS.AbrirBuscaDemonstrativo()
469:                 ENDIF
470:                 IF USED("cursor_4c_FemDmoVal")
471:                     USE IN cursor_4c_FemDmoVal
472:                 ENDIF
473:             ENDIF
474:         CATCH TO loc_oErro
475:             MsgErro(loc_oErro.Message + CHR(13) + ;
476:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
477:                     "Procedure: " + loc_oErro.Procedure, ;
478:                     "Erro em FormSigPrFem.ValidarDemonstrativo")
479:         ENDTRY
480: 
481:         THIS.txt_4c_Demonstrativo.Refresh()
482:     ENDPROC
483: 
484:     *==========================================================================
485:     PROCEDURE AbrirBuscaDemonstrativo()
486:     *==========================================================================
487:     * Lookup de SIGPRFEM.Get_Demonstrativo via FormBuscaAuxiliar (substitui o
488:     * fwBuscaExt legado, que buscava em SigPrDmo/crListaRemota pelo campo
489:     * Nome). Tabela single-column: codigo e descricao sao o MESMO campo
490:     * Nome, entao ha uma UNICA mAddColuna (regra do SigCdOpe/SigPrDmo -
491:     * nunca inventar uma 2a coluna). Contrato do FormBuscaAuxiliar (regra
492:     * #37): o Init ja tenta o match exato sozinho - so mostra o picker
493:     * quando this_lAchouRegistro = .F., e so atribui o valor quando
494:     * this_lSelecionou = .T., para nao zerar o campo se o usuario cancelar.
495:     *==========================================================================
496:         LOCAL loc_oBusca, loc_cValor, loc_oErro
497: 
498:         IF VARTYPE(THIS.txt_4c_Demonstrativo) != "O"
499:             RETURN
500:         ENDIF
501: 
502:         TRY
503:             loc_cValor = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
504: 
505:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
506:                 "SigPrDmo", "cursor_4c_FemDmoBusca", "Nome", loc_cValor, ;
507:                 "Sele" + CHR(231) + CHR(227) + "o")
508: 
509:             IF VARTYPE(loc_oBusca) = "O"
510:                 IF !loc_oBusca.this_lAchouRegistro
511:                     loc_oBusca.mAddColuna("Nome", "", "Nome")
512:                     loc_oBusca.Show()
513:                 ENDIF
514: 
515:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_FemDmoBusca")
516:                     SELECT cursor_4c_FemDmoBusca
517:                     THIS.txt_4c_Demonstrativo.Value = ALLTRIM(cursor_4c_FemDmoBusca.Nome)
518:                 ENDIF
519: 
520:                 loc_oBusca.Release()
521:             ENDIF
522:         CATCH TO loc_oErro
523:             MsgErro(loc_oErro.Message + CHR(13) + ;
524:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
525:                     "Procedure: " + loc_oErro.Procedure, ;
526:                     "Erro em FormSigPrFem.AbrirBuscaDemonstrativo")
527:         ENDTRY
528: 
529:         IF USED("cursor_4c_FemDmoBusca")
530:             USE IN cursor_4c_FemDmoBusca
531:         ENDIF
532:         THIS.txt_4c_Demonstrativo.Refresh()
533:     ENDPROC
534: 
535:     *==========================================================================
536:     PROTECTED PROCEDURE ConfigurarResultado()
537:     *==========================================================================
538:     * Cria cnt_4c_Resultado (equivalente a SIGPRFEM.Resultado, Visible=.F.
539:     * ate o botao Processar exibi-lo) com os 5 sub-containers de detalhe
540:     * (Detalhe/detalhe2/detalhe3/detalhe4/detalhe5 do legado, cada um com
541:     * label Titulo + Grid de 3 colunas) e o container Resumo com os
542:     * totalizadores. Geometria e propriedades transcritas do dump
543:     * SigPrFem_form_codigo_fonte.txt (secoes SIGPRFEM.Resultado.*).
544:     *==========================================================================
545:         LOCAL loc_oErro
546:         TRY
547:             THIS.AddObject("cnt_4c_Resultado", "Container")
548:             WITH THIS.cnt_4c_Resultado
549:                 .Top       = 144
550:                 .Left      = 9
551:                 .Width     = 981
552:                 .Height    = 453
553:                 .BackStyle = 0
554:                 .Visible   = .F.
555:             ENDWITH
556: 
557:             THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe", 5, 336, ;
558:                 "Saldo com funcion" + CHR(225) + "rios antes do per" + CHR(237) + "odo", 230)
559:             THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe2", 4, 15, ;
560:                 "Entradas no per" + CHR(237) + "odo", 115)
561:             THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe3", 184, 15, ;
562:                 "Sa" + CHR(237) + "das no per" + CHR(237) + "odo", 102)
563:             THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe4", 184, 336, ;
564:                 "Saldo final com funcion" + CHR(225) + "rios", 159)
565:             THIS.ConfigurarGradeDetalhe("cnt_4c_Detalhe5", 5, 659, ;
566:                 "Falhas dos funcion" + CHR(225) + "rios no per" + CHR(237) + "odo", 196)
567: 
568:             THIS.ConfigurarResumo()
569:         CATCH TO loc_oErro
570:             MsgErro(loc_oErro.Message + CHR(13) + ;
571:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
572:                     "Procedure: " + loc_oErro.Procedure, ;
573:                     "Erro em FormSigPrFem.ConfigurarResultado")
574:         ENDTRY
575:     ENDPROC
576: 
577:     *==========================================================================
578:     PROTECTED PROCEDURE ConfigurarGradeDetalhe(par_cNome, par_nTop, par_nLeft, par_cTitulo, par_nLarguraTitulo)
579:     *==========================================================================
580:     * Monta um dos 5 sub-containers de detalhe (par_cNome) dentro de
581:     * cnt_4c_Resultado: label lbl_4c_Titulo + grid grd_4c_Dados (3 colunas,
582:     * ReadOnly, sem RecordMark/DeleteMark - regra OPERACIONAL). O
583:     * RecordSource/ControlSource do grid NAO eh definido aqui: o cursor de
584:     * dados ainda nao existe (soh eh criado quando o botao Processar roda,
585:     * nas fases seguintes) - regra #41 (ControlSource antes do cursor
586:     * existir derruba o Init). Quem popular o grid mais adiante DEVE
587:     * reaplicar Column.Width/Header1.Caption depois de setar RecordSource
588:     * (RecordSource reseta ambos - Problema 48/regra #35c).
589:     *==========================================================================
590:         LOCAL loc_oDet
591: 
592:         THIS.cnt_4c_Resultado.AddObject(par_cNome, "Container")
593:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cNome)
594:         WITH loc_oDet
595:             .Top       = par_nTop
596:             .Left      = par_nLeft
597:             .Width     = 294
598:             .Height    = 172
599:             .BackStyle = 0
600:             .Visible   = .F.
601:         ENDWITH
602: 
603:         loc_oDet.AddObject("lbl_4c_Titulo", "Label")
604:         WITH loc_oDet.lbl_4c_Titulo
605:             .AutoSize  = .F.
606:             .FontBold  = .T.
607:             .FontName  = "Tahoma"
608:             .FontSize  = 8
609:             .BackStyle = 0
610:             .Alignment = 0
611:             .ForeColor = RGB(90, 90, 90)
612:             .Caption   = par_cTitulo
613:             .Left      = 9
614:             .Top       = 4
615:             .Width     = par_nLarguraTitulo
616:             .Height    = 15
617:             .Visible   = .T.
618:         ENDWITH

*-- Linhas 699 a 742:
699:     ENDPROC
700: 
701:     *==========================================================================
702:     PROTECTED PROCEDURE ConfigurarResumo()
703:     *==========================================================================
704:     * Monta cnt_4c_Resumo (SIGPRFEM.Resultado.Resumo) dentro de
705:     * cnt_4c_Resultado, com os 10 TextBox ReadOnly de totalizadores
706:     * (mapeados para this_n* de SigPrFemBO - o preenchimento eh feito por
707:     * AtualizarResumo(), chamado por CarregarDados() a partir de
708:     * BtnProcessarClick)
709:     * e os 11 labels correspondentes. Geometria/propriedades transcritas do
710:     * dump (secoes SIGPRFEM.Resultado.Resumo.*).
711:     *==========================================================================
712:         LOCAL loc_oRes
713: 
714:         THIS.cnt_4c_Resultado.AddObject("cnt_4c_Resumo", "Container")
715:         loc_oRes = THIS.cnt_4c_Resultado.cnt_4c_Resumo
716:         WITH loc_oRes
717:             .Top       = 184
718:             .Left      = 659
719:             .Width     = 294
720:             .Height    = 264
721:             .BackStyle = 0
722:             .Visible   = .T.
723:         ENDWITH
724: 
725:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label13", "Totalizadores", 7, 4, 79, .T.)
726: 
727:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label5", "Saldo Inicial :", 136, 27, 65, .F.)
728:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Saldoi", 203, 25, .F.)
729: 
730:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label4", ;
731:             "Saldo funcion" + CHR(225) + "rios ant./ per" + CHR(237) + "odo :", 39, 50, 162, .F.)
732:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_SaldoAnt", 203, 48, .F.)
733: 
734:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label6", ;
735:             "Entradas no per" + CHR(237) + "odo :", 95, 73, 106, .F.)
736:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_Entradas", 203, 71, .F.)
737: 
738:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label7", "Sub-Total entradas :", 100, 96, 101, .F.)
739:         THIS.AdicionarTotalizador(loc_oRes, "txt_4c_TEntradas", 203, 94, .F.)
740: 
741:         THIS.AdicionarLabelResumo(loc_oRes, "lbl_4c_Label8", ;
742:             "Sa" + CHR(237) + "das no per" + CHR(237) + "odo :", 107, 119, 94, .F.)

*-- Linhas 762 a 868:
762:     ENDPROC
763: 
764:     *==========================================================================
765:     PROTECTED PROCEDURE AdicionarLabelResumo(par_oPai, par_cNome, par_cCaption, par_nLeft, par_nTop, par_nWidth, par_lNegrito)
766:     *==========================================================================
767:     * Helper para os labels de cnt_4c_Resumo - classe "say" do legado
768:     * (AutoSize=.T. no dump), mas AddObject nao respeita AutoSize (regra
769:     * #23): usar AutoSize=.F. + Width/Height transcritos do dump.
770:     *==========================================================================
771:         par_oPai.AddObject(par_cNome, "Label")
772:         WITH EVALUATE("par_oPai." + par_cNome)
773:             .AutoSize  = .F.
774:             .FontBold  = par_lNegrito
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .BackStyle = 0
778:             .Alignment = 0
779:             .ForeColor = RGB(90, 90, 90)
780:             .Caption   = par_cCaption
781:             .Left      = par_nLeft
782:             .Top       = par_nTop
783:             .Width     = par_nWidth
784:             .Height    = 15
785:             .Visible   = .T.
786:         ENDWITH
787:     ENDPROC
788: 
789:     *==========================================================================
790:     PROTECTED PROCEDURE AdicionarTotalizador(par_oPai, par_cNome, par_nLeft, par_nTop, par_lNegrito)
791:     *==========================================================================
792:     * Helper para os TextBox ReadOnly de totalizadores de cnt_4c_Resumo -
793:     * mesmo padrao (Alignment/InputMask/SpecialEffect/cores) nos 10 campos
794:     * do dump (Get_Saldoi/Get_SaldoAnt/Get_Entradas/Get_TEntradas/
795:     * Get_Saidas/Get_Saldo/Get_SaldoFunc/Get_Pesagem/Get_SaldoT/Get_FalhaFunc).
796:     *
797:     * .TabStop = .F. eh a transcricao do "PROCEDURE When / Return .F." que os
798:     * DEZ totalizadores tem no dump: o When devolvendo .F. impede o campo de
799:     * receber foco, tirando-o da ordem de tabulacao. Nao da para migrar isso
800:     * com BINDEVENT(.., "When", ..) - o BINDEVENT DESCARTA o retorno do
801:     * delegate, entao um When ligado assim nunca bloqueia nada (mesma
802:     * armadilha da regra #3). Com .TabStop = .F. o Tab pula os 10 campos, e o
803:     * .ReadOnly = .T. ja existente cobre o caso do clique com o mouse.
804:     *==========================================================================
805:         par_oPai.AddObject(par_cNome, "TextBox")
806:         WITH EVALUATE("par_oPai." + par_cNome)
807:             .FontBold          = par_lNegrito
808:             .FontName          = "Tahoma"
809:             .FontSize          = 8
810:             .Alignment         = 3
811:             .Value             = 0
812:             .InputMask         = "999,999.999"
813:             .Margin            = 1
814:             .ReadOnly          = .T.
815:             .TabStop           = .F.
816:             .SpecialEffect     = 1
817:             .DisabledBackColor = RGB(255, 255, 255)
818:             .BorderColor       = RGB(100, 100, 100)
819:             .Left              = par_nLeft
820:             .Top               = par_nTop
821:             .Width             = 86
822:             .Height            = 21
823:             .Visible           = .T.
824:         ENDWITH
825:     ENDPROC
826: 
827:     *==========================================================================
828:     PROTECTED PROCEDURE ConfigurarBotoesAcao()
829:     *==========================================================================
830:     * Barra de acao do topo direito - transcrita do dump do legado
831:     * (SIGPRFEM.Shape2 / Shape1 / Visualizar / Imprimir / Processar / Sair).
832:     *
833:     * A ORDEM DE CRIACAO IMPORTA por dois motivos:
834:     *   1) os botoes ficam em Top = 3, DENTRO da area da faixa cinza do
835:     *      cabecalho (cnt_4c_Sombra: Top 0, Height 80) - por isso este metodo
836:     *      roda DEPOIS de ConfigurarCabecalho, senao a faixa cobre os botoes;
837:     *   2) os dois Shapes sao as molduras que ficam ATRAS dos botoes
838:     *      (Shape2 emoldura Video/Impressora, Shape1 emoldura Processar/
839:     *      Encerrar) - criados antes, os CommandButton desenham por cima.
840:     * AddObject empilha no z-order: o ultimo objeto criado fica na frente.
841:     *
842:     * O ZOrderSet do dump NAO eh transcrito - eh bookkeeping do Form Designer
843:     * e nao existe como propriedade em runtime (regra #33); o equivalente eh
844:     * exatamente esta ordem de criacao.
845:     *
846:     * Os CommandButton sao STANDALONE (nao estao em CommandGroup) e tem
847:     * .Picture, entao levam .Themes = .T. + .DisabledPicture com a MESMA
848:     * imagem: com Themes = .F. o icone deixa de renderizar quando o botao
849:     * fica Enabled = .F. (o dump legado traz Themes = .F. - aqui eh desvio
850:     * deliberado, para o icone nao desaparecer).
851:     *==========================================================================
852:         LOCAL loc_oErro
853:         TRY
854:             *-- Moldura de Video/Impressora (SIGPRFEM.Shape2)
855:             THIS.AddObject("shp_4c_Shape2", "Shape")
856:             WITH THIS.shp_4c_Shape2
857:                 .Top           = 7
858:                 .Left          = 667
859:                 .Width         = 146
860:                 .Height        = 75
861:                 .BackStyle     = 0
862:                 .BorderStyle   = 0
863:                 .SpecialEffect = 1
864:                 .BorderColor   = RGB(136, 189, 188)
865:                 .Visible       = .T.
866:             ENDWITH
867: 
868:             *-- Moldura de Processar/Encerrar (SIGPRFEM.Shape1)

*-- Linhas 901 a 1139:
901:                 "Encerrar", "cadastro_sair_60.jpg", "", .T.)
902: 
903:             *-- Eventos dos 4 botoes (Fase 7). Os handlers sao PUBLIC de
904:             *-- proposito: BINDEVENT falha EM SILENCIO com metodo PROTECTED.
905:             BINDEVENT(THIS.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
906:             BINDEVENT(THIS.cmd_4c_Imprimir,   "Click", THIS, "BtnImprimirClick")
907:             BINDEVENT(THIS.cmd_4c_Processar,  "Click", THIS, "BtnProcessarClick")
908:             BINDEVENT(THIS.cmd_4c_Sair,       "Click", THIS, "BtnSairClick")
909:         CATCH TO loc_oErro
910:             MsgErro(loc_oErro.Message + CHR(13) + ;
911:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
912:                     "Procedure: " + loc_oErro.Procedure, ;
913:                     "Erro em FormSigPrFem.ConfigurarBotoesAcao")
914:         ENDTRY
915:     ENDPROC
916: 
917:     *==========================================================================
918:     PROTECTED PROCEDURE ConfigurarBotaoAcao(par_oBotao, par_nLeft, par_cCaption, par_cIcone, par_cToolTip, par_lCancel)
919:     *==========================================================================
920:     * Aplica a um dos 4 CommandButton da barra de acao (JA criado pelo
921:     * AddObject do chamador) as propriedades que os quatro compartilham no
922:     * dump: Top = 3, 75x75, Comic Sans MS 8 bold italic, ForeColor 90,90,90
923:     * sobre BackColor branco, PicturePosition = 13 (icone acima do texto).
924:     * Mudam apenas Left, Caption, Picture, ToolTipText e o Cancel do Encerrar.
925:     *
926:     * O AddObject fica no chamador, com o nome LITERAL, de proposito: assim o
927:     * nome de cada botao eh visivel no fonte (e nao escondido atras de um
928:     * parametro) para quem le o form e para as auditorias do pipeline.
929:     *==========================================================================
930:         WITH par_oBotao
931:             .Top               = 3
932:             .Left              = par_nLeft
933:             .Width             = 75
934:             .Height            = 75
935:             .FontBold          = .T.
936:             .FontItalic        = .T.
937:             .FontName          = "Comic Sans MS"
938:             .FontSize          = 8
939:             .WordWrap          = .T.
940:             .AutoSize          = .F.
941:             .Caption           = par_cCaption
942:             .Picture           = gc_4c_CaminhoIcones + par_cIcone
943:             .DisabledPicture   = gc_4c_CaminhoIcones + par_cIcone
944:             .PicturePosition   = 13
945:             .ToolTipText       = par_cToolTip
946:             .Cancel            = par_lCancel
947:             .ForeColor         = RGB(90, 90, 90)
948:             .BackColor         = RGB(255, 255, 255)
949:             .DisabledBackColor = RGB(255, 255, 255)
950:             .SpecialEffect     = 0
951:             .MousePointer      = 15
952:             .Themes            = .T.
953:             .Visible           = .T.
954:         ENDWITH
955:     ENDPROC
956: 
957:     *==========================================================================
958:     PROTECTED PROCEDURE CriarCursoresResultado()
959:     *==========================================================================
960:     * Equivalente ao PROCEDURE Load do legado: cria os cursores que alimentam
961:     * os 5 grids da area de Resultado, mais o cursor de trabalho do resumo,
962:     * com a MESMA estrutura, a MESMA ORDEM DE CAMPOS e os MESMOS indices do
963:     * dump (regra dos forms OPERACIONAIS: cursor recriado em outro ponto tem
964:     * de repetir a ordem dos campos, senao o APPEND/REPLACE vai para a coluna
965:     * errada).
966:     *
967:     * Roda ANTES de compor o layout, como no legado (Load executa antes do
968:     * Init): assim os cursores ja existem quando CarregarDados() liga os
969:     * grids. Os AddObject dos grids NAO definem RecordSource/ControlSource
970:     * (regra #41 - ControlSource de cursor inexistente derruba o Init); todo
971:     * o bind vive em CarregarDados().
972:     *
973:     * DataSession = 2 (private): estes cursores pertencem a esta instancia do
974:     * form e morrem com ela.
975:     *==========================================================================
976:         LOCAL loc_oErro
977:         TRY
978:             *-- Entradas no periodo (legado: Entradas)
979:             IF USED("cursor_4c_Entradas")
980:                 USE IN cursor_4c_Entradas
981:             ENDIF
982:             CREATE CURSOR cursor_4c_Entradas (Emps C(3), TpOps C(15), Qtde N(12,3))
983:             INDEX ON Emps + TpOps TAG TpOps
984: 
985:             *-- Saidas no periodo (legado: Saidas)
986:             IF USED("cursor_4c_Saidas")
987:                 USE IN cursor_4c_Saidas
988:             ENDIF
989:             CREATE CURSOR cursor_4c_Saidas (Emps C(3), TpOps C(15), Qtde N(12,3))
990:             INDEX ON Emps + TpOps TAG TpOps
991: 
992:             *-- Saldo atual com funcionarios (legado: Saldos)
993:             IF USED("cursor_4c_Saldos")
994:                 USE IN cursor_4c_Saldos
995:             ENDIF
996:             CREATE CURSOR cursor_4c_Saldos (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
997:             INDEX ON Grupos + Contas TAG GruConta
998: 
999:             *-- Saldo com funcionarios antes do periodo (legado: SaldoAnt)
1000:             IF USED("cursor_4c_SaldoAnt")
1001:                 USE IN cursor_4c_SaldoAnt
1002:             ENDIF
1003:             CREATE CURSOR cursor_4c_SaldoAnt (Grupos C(10), Contas C(10), Qtde N(12,3), Emps C(3))
1004:             INDEX ON Grupos + Contas TAG GruConta
1005: 
1006:             *-- Falhas dos funcionarios no periodo (legado: Falhas)
1007:             IF USED("cursor_4c_Falhas")
1008:                 USE IN cursor_4c_Falhas
1009:             ENDIF
1010:             CREATE CURSOR cursor_4c_Falhas (Grupos C(10), Contas C(10), Qtde N(12,3), ;
1011:                                             Entra N(12,3), Saida N(12,3), Emps C(3))
1012:             INDEX ON Grupos + Contas TAG GruConta
1013: 
1014:             *-- Cursor de trabalho do resumo por Grupo/Conta/Produto (legado: TmpResumo)
1015:             IF USED("cursor_4c_Resumo")
1016:                 USE IN cursor_4c_Resumo
1017:             ENDIF
1018:             CREATE CURSOR cursor_4c_Resumo (Flag L, Flag2 L, Grupo C(10), Conta C(10), ;
1019:                 CMats C(14), CUnis C(3), PesoEnts N(12,3), QtdeEnts N(12,3), ;
1020:                 PesoSais N(12,3), QtdeSais N(12,3), Saldoi N(12,3), Pesagem N(12,3), ;
1021:                 FReal N(12,3), FAdmin N(12,3), Saldof N(12,3), PesoPEnts N(12,3), ;
1022:                 PesoPSais N(12,3), PfTrabs N(9,2), Flag3 L, Varias N(1), ;
1023:                 PesoFabre N(12,3), PesoFabrs N(12,3), cUniPs C(3), CodCors C(4), ;
1024:                 CodTams C(4), Visivel L, Agregas N(1))
1025:             INDEX ON CMats + CodCors + CodTams TAG cpros
1026:             INDEX ON Grupo + Conta + CMats + CodCors + CodTams TAG GrConMat FOR Visivel
1027:         CATCH TO loc_oErro
1028:             MsgErro(loc_oErro.Message + CHR(13) + ;
1029:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1030:                     "Procedure: " + loc_oErro.Procedure, ;
1031:                     "Erro em FormSigPrFem.CriarCursoresResultado")
1032:         ENDTRY
1033:     ENDPROC
1034: 
1035:     *==========================================================================
1036:     PROCEDURE CarregarDados()
1037:     *==========================================================================
1038:     * Liga os 5 grids da area de Resultado aos cursores ja populados e exibe
1039:     * o bloco inteiro - transcricao do trecho final de Processar.Click do
1040:     * legado (os cinco blocos "With ThisForm.Resultado.Detalhe<N>" seguidos de
1041:     * "ThisForm.Resultado.Visible = .t."). Devolve .T. quando o Resultado foi
1042:     * exibido.
1043:     *
1044:     * Nomes de coluna e captions transcritos um a um do legado:
1045:     *   SaldoAnt -> Fase / Qtde / Emp        Entradas -> Operacao / Qtde / Emp
1046:     *   Saidas   -> Operacao / Qtde / Emp    Saldos   -> Fase / Qtde / Emp
1047:     *   Falhas   -> Fase / Falha / Emp
1048:     *==========================================================================
1049:         LOCAL loc_lSucesso, loc_oErro
1050:         loc_lSucesso = .F.
1051: 
1052:         TRY
1053:             *-- Saldo anterior (legado: Detalhe <- SaldoAnt)
1054:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe", "cursor_4c_SaldoAnt", ;
1055:                 "Grupos", "Fase", "Qtde", "Qtde")
1056: 
1057:             *-- Entradas no periodo (legado: detalhe2 <- Entradas)
1058:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe2", "cursor_4c_Entradas", ;
1059:                 "TpOps", "Opera" + CHR(231) + CHR(227) + "o", "Qtde", "Qtde")
1060: 
1061:             *-- Saidas no periodo (legado: detalhe3 <- Saidas)
1062:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe3", "cursor_4c_Saidas", ;
1063:                 "TpOps", "Opera" + CHR(231) + CHR(227) + "o", "Qtde", "Qtde")
1064: 
1065:             *-- Saldo atual com funcionario (legado: detalhe4 <- Saldos)
1066:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe4", "cursor_4c_Saldos", ;
1067:                 "Grupos", "Fase", "Qtde", "Qtde")
1068: 
1069:             *-- Falhas dos funcionarios (legado: detalhe5 <- Falhas)
1070:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe5", "cursor_4c_Falhas", ;
1071:                 "Grupos", "Fase", "Qtde", "Falha")
1072: 
1073:             *-- Totalizadores do bloco Resumo
1074:             THIS.AtualizarResumo()
1075: 
1076:             *-- Exibe o bloco de resultado (legado: ThisForm.Resultado.Visible = .t.)
1077:             THIS.cnt_4c_Resultado.Visible = .T.
1078:             THIS.Refresh()
1079: 
1080:             *-- O legado chama .SetFocus em cada uma das 5 grades; o efeito
1081:             *-- observavel eh o foco terminar na ultima (detalhe5).
1082:             IF THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.Visible AND ;
1083:                THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.grd_4c_Dados.Visible
1084:                 THIS.cnt_4c_Resultado.cnt_4c_Detalhe5.grd_4c_Dados.SetFocus()
1085:             ENDIF
1086: 
1087:             loc_lSucesso = .T.
1088:         CATCH TO loc_oErro
1089:             MsgErro(loc_oErro.Message + CHR(13) + ;
1090:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1091:                     "Procedure: " + loc_oErro.Procedure, ;
1092:                     "Erro em FormSigPrFem.CarregarDados")
1093:         ENDTRY
1094: 
1095:         RETURN loc_lSucesso
1096:     ENDPROC
1097: 
1098:     *==========================================================================
1099:     PROTECTED PROCEDURE LigarGradeDetalhe(par_cContainer, par_cCursor, par_cCampo1, par_cCaption1, par_cCampo2, par_cCaption2)
1100:     *==========================================================================
1101:     * Aplica a UM dos 5 sub-containers de detalhe o bind que o legado faz em
1102:     * bloco: torna o container e a grade visiveis, posiciona o cursor no topo,
1103:     * define RecordSource + ControlSource das 3 colunas, os captions e - por
1104:     * ULTIMO - as larguras do dump. A 3a coluna eh sempre Emps/"Emp" nos
1105:     * cinco grids do legado.
1106:     *
1107:     * Por que a largura vem DEPOIS do RecordSource: atribuir RecordSource/
1108:     * ControlSource faz o VFP recalcular as larguras para o default 90 e
1109:     * resetar os Header1.Caption (Problema 48 / regra #35c) - definir antes
1110:     * seria descartado.
1111:     *
1112:     * Sem o GO TOP + Refresh a grade nao repinta as linhas inseridas depois
1113:     * de o cursor ter nascido vazio: o cursor fica cheio e a tela parece sem
1114:     * dados (o legado fecha cada bloco com Select <cursor> / Go Top / .Refresh
1115:     * pelo mesmo motivo).
1116:     *==========================================================================
1117:         LOCAL loc_oDet, loc_oGrid
1118: 
1119:         IF !USED(par_cCursor)
1120:             RETURN
1121:         ENDIF
1122: 
1123:         *-- Os 5 sub-containers de detalhe sao filhos de cnt_4c_Resultado, nao
1124:         *-- do Form (Left/Top no dump sao relativos ao container Resultado).
1125:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cContainer)
1126:         loc_oDet.Visible = .T.
1127: 
1128:         loc_oGrid = loc_oDet.grd_4c_Dados
1129:         loc_oGrid.Visible = .T.
1130: 
1131:         SELECT (par_cCursor)
1132:         GO TOP
1133: 
1134:         WITH loc_oGrid
1135:             .ColumnCount             = 3
1136:             .RecordSource            = par_cCursor
1137:             .Column1.ControlSource   = par_cCursor + "." + par_cCampo1
1138:             .Column1.Header1.Caption = par_cCaption1
1139:             .Column2.ControlSource   = par_cCursor + "." + par_cCampo2

*-- Linhas 1151 a 1229:
1151:     ENDPROC
1152: 
1153:     *==========================================================================
1154:     PROTECTED PROCEDURE AtualizarResumo()
1155:     *==========================================================================
1156:     * Espelha nos 10 TextBox ReadOnly de cnt_4c_Resumo os totais calculados
1157:     * pelo BO - transcricao do bloco "With ThisForm.Resultado.Resumo" do
1158:     * legado. FONTE UNICA: quem calcula eh o SigPrFemBO (this_n*), o form
1159:     * apenas exibe - as somas do legado (lnSaldoIni + lnTotalEntra +
1160:     * lnSaldoaFun para o sub-total, lnPesagem + lnSaldoFunc para o total)
1161:     * NAO sao repetidas aqui, para o mesmo numero nao ser calculado em dois
1162:     * lugares (regra #17).
1163:     *==========================================================================
1164:         LOCAL loc_oRes, loc_oBO
1165: 
1166:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1167:             RETURN
1168:         ENDIF
1169: 
1170:         loc_oBO  = THIS.this_oBusinessObject
1171:         loc_oRes = THIS.cnt_4c_Resultado.cnt_4c_Resumo
1172: 
1173:         WITH loc_oRes
1174:             .txt_4c_Saldoi.Value    = loc_oBO.this_nSaldoInicial
1175:             .txt_4c_SaldoAnt.Value  = loc_oBO.this_nSaldoAnterior
1176:             .txt_4c_Entradas.Value  = loc_oBO.this_nEntradas
1177:             .txt_4c_TEntradas.Value = loc_oBO.this_nTotalEntradas
1178:             .txt_4c_Saidas.Value    = loc_oBO.this_nSaidas
1179:             .txt_4c_Pesagem.Value   = loc_oBO.this_nPesagem
1180:             .txt_4c_Saldo.Value     = loc_oBO.this_nSaldo
1181:             .txt_4c_SaldoFunc.Value = loc_oBO.this_nSaldoFuncionarios
1182:             .txt_4c_FalhaFunc.Value = loc_oBO.this_nFalhaFuncionarios
1183:             .txt_4c_SaldoT.Value    = loc_oBO.this_nSaldoTotal
1184:             .Refresh()
1185:         ENDWITH
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     PROCEDURE LimparResultado()
1190:     *==========================================================================
1191:     * PUBLIC de proposito (sem PROTECTED): os harness de teste do pipeline
1192:     * chamam esta familia de metodos de FORA da classe, e PEMSTATUS(oForm,
1193:     * "LimparResultado", 5) devolve .T. mesmo com o metodo PROTECTED - so
1194:     * verifica existencia, nao escopo. O teste entraria no branch e a chamada
1195:     * real estouraria "Property LIMPARRESULTADO is not found" (regra #3).
1196:     *
1197:     * Devolve a area de Resultado ao estado de tela recem-aberta: esconde o
1198:     * container (equivale ao "ThisForm.Resultado.Visible = .f." que abre o
1199:     * Processar.Click legado), esconde os cinco sub-containers de detalhe e
1200:     * zera os dez totalizadores.
1201:     *
1202:     * Por que os sub-containers e os totalizadores tambem: no legado os cinco
1203:     * "With ThisForm.Resultado.Detalhe<N> / .Visible = .t." so rodam no FIM de
1204:     * um processamento bem-sucedido, entao um processamento que aborta no meio
1205:     * deixa o bloco inteiro escondido e ninguem ve numero velho. Aqui, sem
1206:     * esta limpeza, os dez TextBox continuariam com os valores da rodada
1207:     * ANTERIOR e os cinco containers continuariam Visible = .T. por baixo do
1208:     * container escondido - e bastaria uma rodada seguinte parar antes de
1209:     * CarregarDados() para o usuario ver, lado a lado, grades da rodada nova e
1210:     * totais da rodada velha, sem nenhum aviso de que sao de periodos
1211:     * diferentes.
1212:     *
1213:     * Os totalizadores sao zerados DIRETO (e nao por AtualizarResumo) porque
1214:     * aqui a intencao eh justamente NAO espelhar o BO: as properties this_n*
1215:     * dele ainda carregam o resultado antigo neste ponto.
1216:     *==========================================================================
1217:         LOCAL loc_nI, loc_cCnt, loc_oRes
1218: 
1219:         THIS.this_lResultadoPronto    = .F.
1220:         THIS.cnt_4c_Resultado.Visible = .F.
1221: 
1222:         *-- Os cinco sub-containers do dump: Detalhe, detalhe2..detalhe5.
1223:         *-- Acesso por nome montado vai de STORE ... TO (expr), nunca de
1224:         *-- Controls("<nome>") - Controls eh indexado por NUMERO (regra #34).
1225:         FOR loc_nI = 1 TO 5
1226:             loc_cCnt = "cnt_4c_Detalhe" + IIF(loc_nI = 1, "", TRANSFORM(loc_nI))
1227:             IF PEMSTATUS(THIS.cnt_4c_Resultado, loc_cCnt, 5)
1228:                 STORE .F. TO ("THIS.cnt_4c_Resultado." + loc_cCnt + ".Visible")
1229:             ENDIF

*-- Linhas 1247 a 1555:
1247:     ENDPROC
1248: 
1249:     *==========================================================================
1250:     PROCEDURE HabilitarCampos(par_lHabilitar)
1251:     *==========================================================================
1252:     * PUBLIC pelo mesmo motivo de LimparResultado (regra #3): os harness do
1253:     * pipeline chamam oForm.HabilitarCampos(.F./.T.) de fora da classe.
1254:     *
1255:     * Liga/desliga os tres filtros do topo e os quatro botoes de acao. Eh a
1256:     * metade VISIVEL do guard this_lProcessando: enquanto o SigPrFemBO calcula,
1257:     * o botao Processar fica Enabled = .F. e nem chega a disparar o Click, em
1258:     * vez de depender so da flag para recusar a reentrada.
1259:     *
1260:     * Desligar tambem cmd_4c_Sair eh proposital: ele tem Cancel = .T. (responde
1261:     * ao ESC), e fechar a tela no meio do processamento destruiria os cursores
1262:     * que o BO ainda esta percorrendo.
1263:     *
1264:     * Os quatro botoes sobrevivem ao Enabled = .F. sem perder o icone porque
1265:     * ConfigurarBotaoAcao ja os cria com .Themes = .T. + .DisabledPicture
1266:     * apontando para a MESMA imagem (regra do CommandButton standalone com
1267:     * Picture).
1268:     *
1269:     * REABILITAR EH OBRIGACAO DO FUNIL, NAO DO CHAMADOR (licao do Erro176):
1270:     * quem chama HabilitarCampos(.F.) eh so BtnProcessarClick, e ele repoe
1271:     * HabilitarCampos(.T.) nos DOIS caminhos de volta - o de sucesso e o do
1272:     * CATCH. Sem a reposicao no CATCH, um erro no meio do calculo deixaria a
1273:     * tela inteira cinza e inutilizavel ate ser fechada e reaberta.
1274:     *==========================================================================
1275:         LOCAL loc_lLiga
1276: 
1277:         loc_lLiga = .T.
1278:         IF VARTYPE(par_lHabilitar) = "L"
1279:             loc_lLiga = par_lHabilitar
1280:         ENDIF
1281: 
1282:         THIS.txt_4c_Datai.Enabled         = loc_lLiga
1283:         THIS.txt_4c_Dataf.Enabled         = loc_lLiga
1284:         THIS.txt_4c_Demonstrativo.Enabled = loc_lLiga
1285: 
1286:         THIS.cmd_4c_Processar.Enabled  = loc_lLiga
1287:         THIS.cmd_4c_Visualizar.Enabled = loc_lLiga
1288:         THIS.cmd_4c_Imprimir.Enabled   = loc_lLiga
1289:         THIS.cmd_4c_Sair.Enabled       = loc_lLiga
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1294:     *==========================================================================
1295:     * Torna visiveis todos os controles recursivamente (AddObject cria com
1296:     * Visible = .F.). FILTRO OBRIGATORIO: o container Resultado (Fase 4) e
1297:     * os cinco sub-containers de detalhe (Detalhe/detalhe2/detalhe3/detalhe4/
1298:     * detalhe5) sao flutuantes com Visible=.F. no legado ate o usuario clicar
1299:     * Processar - NAO tornar visiveis aqui, mas recursar dentro deles para
1300:     * que os filhos (Grid/Titulo) fiquem prontos quando o botao Processar
1301:     * exibir o container.
1302:     *==========================================================================
1303:         LOCAL loc_nI, loc_oControl, loc_nP
1304:         IF VARTYPE(par_oContainer) != "O"
1305:             par_oContainer = THIS
1306:         ENDIF
1307:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1308:             loc_oControl = par_oContainer.Controls(loc_nI)
1309:             IF VARTYPE(loc_oControl) = "O"
1310:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_RESULTADO", ;
1311:                           "CNT_4C_DETALHE", "CNT_4C_DETALHE2", "CNT_4C_DETALHE3", ;
1312:                           "CNT_4C_DETALHE4", "CNT_4C_DETALHE5")
1313:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1314:                        loc_oControl.ControlCount > 0
1315:                         THIS.TornarControlesVisiveis(loc_oControl)
1316:                     ENDIF
1317:                     LOOP
1318:                 ENDIF
1319: 
1320:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1321:                     loc_oControl.Visible = .T.
1322:                 ENDIF
1323:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1324:                     FOR loc_nP = 1 TO loc_oControl.PageCount
1325:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1326:                     ENDFOR
1327:                 ENDIF
1328:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1329:                    loc_oControl.ControlCount > 0
1330:                     THIS.TornarControlesVisiveis(loc_oControl)
1331:                 ENDIF
1332:             ENDIF
1333:         ENDFOR
1334:     ENDPROC
1335: 
1336: 
1337:     *==========================================================================
1338:     * BtnProcessarClick - evento do botao Processar (SIGPRFEM.Processar.Click)
1339:     *
1340:     * Transcricao da PARTE DE TELA do Click legado: le os tres filtros, aplica
1341:     * as tres validacoes com SetFocus, esconde o bloco de Resultado, delega o
1342:     * calculo ao BO e volta a exibir o Resultado com as grades ligadas.
1343:     *
1344:     * As tres validacoes ficam AQUI (e nao no BO) porque cada uma devolve o
1345:     * foco a um controle - e os controles sao do form. Os RETURN delas vem
1346:     * ANTES do TRY (regra #1: RETURN nao pode existir dentro de TRY/CATCH).
1347:     *
1348:     * Ordem e mensagens EXATAS do legado:
1349:     *   1. Empty(ldDataf)      -> "A Data Final Deve Ser Informada!!!"      -> Get_Dataf
1350:     *   2. ldDatai > ldDataf   -> "A Data Final Deve Ser Maior Que a Data Inicial!!!" -> Get_Datai
1351:     *   3. Empty(lcConfig)     -> "A Configuracao Deve Ser Informada!!!"    -> Get_Demonstrativo
1352:     *==========================================================================
1353:     PROCEDURE BtnProcessarClick()
1354:         LOCAL loc_dDataI, loc_dDataF, loc_cConfig, loc_oErro
1355: 
1356:         *-- Guard de reentrancia: a barra de progresso do BO devolve a vez ao
1357:         *-- VFP a cada Refresh, entao um segundo clique cairia aqui com o
1358:         *-- primeiro processamento ainda percorrendo os cursores. RETURN ANTES
1359:         *-- do TRY (regra #1).
1360:         IF THIS.this_lProcessando
1361:             RETURN
1362:         ENDIF
1363: 
1364:         *-- SIGPRFEM eh OPERACIONAL FLAT: os filtros sao filhos DIRETOS do Form
1365:         *-- (nao ha PageFrame nem container de filtros), como em ConfigurarFiltros
1366:         loc_dDataI  = ConverterParaData(THIS.txt_4c_Datai.Value)
1367:         loc_dDataF  = ConverterParaData(THIS.txt_4c_Dataf.Value)
1368:         loc_cConfig = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1369: 
1370:         IF EMPTY(loc_dDataF)
1371:             MsgAviso("A Data Final Deve Ser Informada!!!", ;
1372:                      "Aten" + CHR(231) + CHR(227) + "o")
1373:             THIS.txt_4c_Dataf.SetFocus()
1374:             RETURN
1375:         ENDIF
1376: 
1377:         IF loc_dDataI > loc_dDataF
1378:             MsgAviso("A Data Final Deve Ser Maior Que a Data Inicial!!!", ;
1379:                      "Aten" + CHR(231) + CHR(227) + "o")
1380:             THIS.txt_4c_Datai.SetFocus()
1381:             RETURN
1382:         ENDIF
1383: 
1384:         IF EMPTY(loc_cConfig)
1385:             MsgAviso("A Configura" + CHR(231) + CHR(227) + "o Deve Ser Informada!!!", ;
1386:                      "Aten" + CHR(231) + CHR(227) + "o")
1387:             THIS.txt_4c_Demonstrativo.SetFocus()
1388:             RETURN
1389:         ENDIF
1390: 
1391:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1392:             MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
1393:                     CHR(237) + "vel.", "Erro em FormSigPrFem.BtnProcessarClick")
1394:             RETURN
1395:         ENDIF
1396: 
1397:         TRY
1398:             THIS.this_lProcessando = .T.
1399:             THIS.HabilitarCampos(.F.)
1400: 
1401:             *-- Legado: ThisForm.Resultado.Visible = .f. / ThisForm.Refresh
1402:             *-- (aqui tambem escondendo os 5 detalhes e zerando os totais,
1403:             *-- para nao sobrar numero da rodada anterior se esta abortar)
1404:             THIS.LimparResultado()
1405: 
1406:             THIS.MousePointer = 11
1407: 
1408:             IF THIS.this_oBusinessObject.Processar(loc_dDataI, loc_dDataF, loc_cConfig)
1409:                 *-- Liga as 5 grades + espelha os totalizadores + exibe o bloco
1410:                 IF THIS.CarregarDados()
1411:                     *-- "Criando a Impressao" do fim do Click legado: monta os
1412:                     *-- cursores que o SigPrFem.frx consome (TmpImp/cabecalho)
1413:                     THIS.this_lResultadoPronto = THIS.MontarCursoresImpressao()
1414:                 ENDIF
1415:             ENDIF
1416: 
1417:             THIS.MousePointer = 0
1418:             THIS.HabilitarCampos(.T.)
1419:             THIS.this_lProcessando = .F.
1420:         CATCH TO loc_oErro
1421:             *-- Caminho de volta do ERRO: repor o estado da tela AQUI tambem,
1422:             *-- senao um erro no meio do calculo deixa os filtros e os quatro
1423:             *-- botoes cinza para sempre (licao do Erro176)
1424:             THIS.MousePointer = 0
1425:             THIS.HabilitarCampos(.T.)
1426:             THIS.this_lProcessando = .F.
1427:             MsgErro(loc_oErro.Message + CHR(13) + ;
1428:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1429:                     "Procedure: " + loc_oErro.Procedure, ;
1430:                     "Erro em FormSigPrFem.BtnProcessarClick")
1431:         ENDTRY
1432:     ENDPROC
1433: 
1434:     *==========================================================================
1435:     * BtnVisualizarClick - evento do botao Video (SIGPRFEM.Visualizar.Click)
1436:     *
1437:     * Legado:
1438:     *   If thisform.resultado.Visible / Select TmpImp / Go Top / If !Eof()
1439:     *       Report Form SIGPRFEM Preview NoConsole
1440:     *
1441:     * O "resultado.Visible" do legado eh o gate: sem ter processado, o botao
1442:     * nao faz nada. Aqui o gate eh o mesmo container (cnt_4c_Resultado) mais a
1443:     * flag this_lResultadoPronto, que so fica .T. quando os cursores de
1444:     * impressao foram montados - assim o clique antes de processar avisa em vez
1445:     * de abrir um preview vazio.
1446:     *==========================================================================
1447:     PROCEDURE BtnVisualizarClick()
1448:         LOCAL loc_oErro
1449: 
1450:         IF !THIS.ResultadoDisponivel()
1451:             RETURN
1452:         ENDIF
1453: 
1454:         TRY
1455:             = THIS.ExecutarReportForm("SigPrFem", "PREVIEW", "TmpImp")
1456:         CATCH TO loc_oErro
1457:             MsgErro(loc_oErro.Message + CHR(13) + ;
1458:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1459:                     "Procedure: " + loc_oErro.Procedure, ;
1460:                     "Erro em FormSigPrFem.BtnVisualizarClick")
1461:         ENDTRY
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * BtnImprimirClick - evento do botao Impressora (SIGPRFEM.Imprimir.Click)
1466:     *
1467:     * Legado: identico ao Visualizar, trocando "Preview" por "To Print Prompt".
1468:     *==========================================================================
1469:     PROCEDURE BtnImprimirClick()
1470:         LOCAL loc_oErro
1471: 
1472:         IF !THIS.ResultadoDisponivel()
1473:             RETURN
1474:         ENDIF
1475: 
1476:         TRY
1477:             = THIS.ExecutarReportForm("SigPrFem", "PRINTER_PROMPT", "TmpImp")
1478:         CATCH TO loc_oErro
1479:             MsgErro(loc_oErro.Message + CHR(13) + ;
1480:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1481:                     "Procedure: " + loc_oErro.Procedure, ;
1482:                     "Erro em FormSigPrFem.BtnImprimirClick")
1483:         ENDTRY
1484:     ENDPROC
1485: 
1486:     *==========================================================================
1487:     * BtnSairClick - evento do botao Encerrar (SIGPRFEM.Sair.Click)
1488:     * Legado: ThisForm.Release
1489:     *==========================================================================
1490:     PROCEDURE BtnSairClick()
1491:         THIS.Release()
1492:     ENDPROC
1493: 
1494:     *==========================================================================
1495:     * ResultadoDisponivel - gate comum de Video/Impressora
1496:     *
1497:     * Reproduz o "If thisform.resultado.Visible ... If !Eof()" que envolve os
1498:     * dois Click de relatorio do legado. Devolve .T. so quando ha o que
1499:     * imprimir; quando nao ha, avisa (o legado fica MUDO, o que faz o usuario
1500:     * clicar varias vezes achando que o botao esta quebrado - desvio
1501:     * deliberado, e o unico do bloco).
1502:     *==========================================================================
1503:     PROTECTED FUNCTION ResultadoDisponivel()
1504:         LOCAL loc_lPronto
1505:         loc_lPronto = .F.
1506: 
1507:         IF THIS.cnt_4c_Resultado.Visible AND THIS.this_lResultadoPronto AND ;
1508:            USED("TmpImp")
1509:             SELECT TmpImp
1510:             GO TOP
1511:             loc_lPronto = !EOF("TmpImp")
1512:         ENDIF
1513: 
1514:         IF !loc_lPronto
1515:             MsgAviso("Processe a an" + CHR(225) + "lise antes de emitir o relat" + ;
1516:                      CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
1517:         ENDIF
1518: 
1519:         RETURN loc_lPronto
1520:     ENDFUNC
1521: 
1522:     *==========================================================================
1523:     * MontarCursoresImpressao - bloco "Criando a Impressao" do fim de
1524:     * Processar.Click legado.
1525:     *
1526:     * Monta TmpImprime (coluna da esquerda: totais e falhas por fase),
1527:     * TmpImprime2 (coluna da direita: resumo de entradas/saidas/saldos), faz o
1528:     * FULL JOIN das duas em TmpImp e cria o cursor Cabecalho.
1529:     *
1530:     * Os nomes TmpImp/Cabecalho e os nomes de campo (Linha/Cabec/Titulo/Valor/
1531:     * Traco/Entrada/Saida/Falha/Linha2/Cabec2/Titulo2/Valor2/Traco2/Emps) NAO
1532:     * levam o prefixo cursor_4c_ nem sufixo _4c_: sao contrato do SigPrFem.frx,
1533:     * que veio do legado sem alteracao (PILAR 1/2). Renomear aqui quebraria
1534:     * todas as expressoes do FRX.
1535:     *
1536:     * As somas usadas nas linhas do relatorio vem das properties this_n* do BO
1537:     * (FONTE UNICA - regra #17): o total nao eh recalculado aqui.
1538:     *==========================================================================
1539:     PROTECTED FUNCTION MontarCursoresImpressao()
1540:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1541:         LOCAL loc_nLinha, loc_nLinha2, loc_nPerc
1542:         LOCAL loc_nQEnt, loc_nQSai, loc_nQFalha, loc_cOrdem
1543: 
1544:         loc_lSucesso = .F.
1545: 
1546:         TRY
1547:             loc_oBO = THIS.this_oBusinessObject
1548: 
1549:             IF USED("TmpImprime2")
1550:                 USE IN TmpImprime2
1551:             ENDIF
1552:             CREATE CURSOR TmpImprime2 (Linha2 N(3), Cabec2 L, Titulo2 C(40), ;
1553:                                        Valor2 N(12,3), Traco2 L, Emps C(3))
1554: 
1555:             IF USED("TmpImprime")

*-- Linhas 1600 a 1718:
1600:                          loc_oBO.this_nSaldoFuncionarios - loc_oBO.this_nFalhaFuncionarios, .T.)
1601: 
1602:             *-- Coluna da direita: resumo de entradas / saidas / saldos das fases
1603:             loc_nLinha2 = 0
1604: 
1605:             SELECT cursor_4c_Entradas
1606:             GO TOP
1607:             IF !EOF()
1608:                 loc_nLinha2 = loc_nLinha2 + 1
1609:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1610:                      VALUES (loc_nLinha2, .T., "Resumo de Entradas")
1611: 
1612:                 SELECT cursor_4c_Entradas
1613:                 SCAN
1614:                     loc_nLinha2 = loc_nLinha2 + 1
1615:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
1616:                          VALUES (loc_nLinha2, .F., cursor_4c_Entradas.TpOps, ;
1617:                                  cursor_4c_Entradas.Qtde, cursor_4c_Entradas.Emps)
1618:                     SELECT cursor_4c_Entradas
1619:                 ENDSCAN
1620:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1621:             ENDIF
1622: 
1623:             loc_nLinha2 = loc_nLinha2 + 1
1624:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1625:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nEntradas)
1626: 
1627:             SELECT cursor_4c_Saidas
1628:             GO TOP
1629:             IF !EOF()
1630:                 loc_nLinha2 = loc_nLinha2 + 1
1631:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1632:                      VALUES (loc_nLinha2, .T., "Resumo de Saidas")
1633: 
1634:                 SELECT cursor_4c_Saidas
1635:                 SCAN
1636:                     loc_nLinha2 = loc_nLinha2 + 1
1637:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2, Emps) ;
1638:                          VALUES (loc_nLinha2, .F., ;
1639:                                  IIF(EMPTY(cursor_4c_Saidas.TpOps), "PRODUZIDO", cursor_4c_Saidas.TpOps), ;
1640:                                  cursor_4c_Saidas.Qtde, cursor_4c_Saidas.Emps)
1641:                     SELECT cursor_4c_Saidas
1642:                 ENDSCAN
1643:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1644:             ENDIF
1645: 
1646:             loc_nLinha2 = loc_nLinha2 + 1
1647:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1648:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaidas)
1649: 
1650:             SELECT cursor_4c_Saldos
1651:             GO TOP
1652:             IF !EOF()
1653:                 loc_nLinha2 = loc_nLinha2 + 1
1654:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1655:                      VALUES (loc_nLinha2, .T., " ")
1656:                 loc_nLinha2 = loc_nLinha2 + 1
1657:                 INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2) ;
1658:                      VALUES (loc_nLinha2, .T., "Saldos das Fases")
1659: 
1660:                 SELECT cursor_4c_Saldos
1661:                 SCAN
1662:                     loc_nLinha2 = loc_nLinha2 + 1
1663:                     INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1664:                          VALUES (loc_nLinha2, .F., cursor_4c_Saldos.Grupos, cursor_4c_Saldos.Qtde)
1665:                     SELECT cursor_4c_Saldos
1666:                 ENDSCAN
1667:                 REPLACE Traco2 WITH .T. IN TmpImprime2
1668:             ENDIF
1669: 
1670:             loc_nLinha2 = loc_nLinha2 + 1
1671:             INSERT INTO TmpImprime2 (Linha2, Cabec2, Titulo2, Valor2) ;
1672:                  VALUES (loc_nLinha2, .F., " ", loc_oBO.this_nSaldoFuncionarios)
1673: 
1674:             *-- Falhas por fase - a coluna "%" eh Falha/Saida*100 (regra do legado:
1675:             *-- percentual sobre a SAIDA, nao sobre a entrada).
1676:             *-- O guard de Saida = 0 eh o UNICO desvio: o legado divide direto e
1677:             *-- estoura "Divisao por zero" numa fase sem saida no periodo,
1678:             *-- derrubando a montagem do relatorio inteiro.
1679:             SELECT cursor_4c_Falhas
1680:             GO TOP
1681:             IF !EOF()
1682:                 loc_nLinha = loc_nLinha + 1
1683:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
1684:                      VALUES (loc_nLinha, .T., PADC("Falhas das Fases", 70))
1685:                 loc_nLinha = loc_nLinha + 1
1686:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo) ;
1687:                      VALUES (loc_nLinha, .T., ;
1688:                              "Setor           Entrada      Saida      Falha Gr         %")
1689: 
1690:                 SELECT cursor_4c_Falhas
1691:                 SCAN
1692:                     loc_nLinha = loc_nLinha + 1
1693:                     loc_nPerc  = IIF(cursor_4c_Falhas.Saida = 0, 0, ;
1694:                                      cursor_4c_Falhas.Qtde / cursor_4c_Falhas.Saida * 100)
1695:                     INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
1696:                                             Entrada, Saida, Falha) ;
1697:                          VALUES (loc_nLinha, .F., cursor_4c_Falhas.Grupos, ;
1698:                                  cursor_4c_Falhas.Qtde, loc_nPerc, cursor_4c_Falhas.Entra, ;
1699:                                  cursor_4c_Falhas.Saida, .T.)
1700:                     SELECT cursor_4c_Falhas
1701:                 ENDSCAN
1702: 
1703:                 SELECT cursor_4c_Falhas
1704:                 SUM Entra, Saida, Qtde TO loc_nQEnt, loc_nQSai, loc_nQFalha
1705:                 loc_nPerc = IIF(loc_nQSai = 0, 0, loc_nQFalha / loc_nQSai * 100)
1706: 
1707:                 REPLACE Traco WITH .T. IN TmpImprime
1708:                 loc_nLinha = loc_nLinha + 1
1709:                 INSERT INTO TmpImprime (Linha, Cabec, Titulo, Valor, Valor1, ;
1710:                                         Entrada, Saida, Falha) ;
1711:                      VALUES (loc_nLinha, .F., " ", loc_nQFalha, loc_nPerc, ;
1712:                              loc_nQEnt, loc_nQSai, .T.)
1713:             ENDIF
1714: 
1715:             *-- FULL JOIN das duas colunas, ordenado pela mais longa
1716:             loc_cOrdem = "T1.Linha"
1717:             IF loc_nLinha2 > loc_nLinha
1718:                 loc_cOrdem = "T2.Linha2"

*-- Linhas 1730 a 1782:
1730: 
1731:             *-- Cabecalho do FRX (razao social da empresa + titulo + periodo)
1732:             IF !THIS.MontarCabecalhoImpressao()
1733:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel montar o cabe" + ;
1734:                          CHR(231) + "alho do relat" + CHR(243) + "rio.", ;
1735:                          "Aten" + CHR(231) + CHR(227) + "o")
1736:             ENDIF
1737: 
1738:             loc_lSucesso = USED("TmpImp")
1739:         CATCH TO loc_oErro
1740:             MsgErro(loc_oErro.Message + CHR(13) + ;
1741:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1742:                     "Procedure: " + loc_oErro.Procedure, ;
1743:                     "Erro em FormSigPrFem.MontarCursoresImpressao")
1744:         ENDTRY
1745: 
1746:         RETURN loc_lSucesso
1747:     ENDFUNC
1748: 
1749:     *==========================================================================
1750:     * MontarCabecalhoImpressao - cursor "Cabecalho" consumido pelo SigPrFem.frx
1751:     *
1752:     * Legado:
1753:     *   CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr, 'Razas')
1754:     *   Create Cursor Cabecalho(pNomeEmpresa c(60), pRelTitulo c(60), pPeriodo c(60))
1755:     *   Insert ... Values (crSigCdEmp.Razas, 'Analise de Producao',
1756:     *                      'Periodo : ' + Dtoc(ldDatai) + ' ate ' + Dtoc(ldDataf))
1757:     *
1758:     * SigCdEmp usa Cemps/Razas (nao Cemps/Razas) - conferido em docs/schema.sql.
1759:     *==========================================================================
1760:     PROTECTED FUNCTION MontarCabecalhoImpressao()
1761:         LOCAL loc_cRazao, loc_nRet, loc_cSQL, loc_oBO
1762: 
1763:         loc_oBO   = THIS.this_oBusinessObject
1764:         loc_cRazao = ""
1765: 
1766:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1767:             IF USED("cursor_4c_CdEmp")
1768:                 USE IN cursor_4c_CdEmp
1769:             ENDIF
1770:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1771:                        EscaparSQL(go_4c_Sistema.cCodEmpresa)
1772:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdEmp")
1773:             IF loc_nRet >= 1 AND USED("cursor_4c_CdEmp") AND !EOF("cursor_4c_CdEmp")
1774:                 loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_CdEmp.Razas, ""))
1775:             ENDIF
1776:         ENDIF
1777: 
1778:         IF EMPTY(loc_cRazao)
1779:             loc_cRazao = ALLTRIM(go_4c_Sistema.cEmpresa)
1780:         ENDIF
1781: 
1782:         IF USED("Cabecalho")

*-- Linhas 1819 a 1892:
1819: 
1820:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
1821:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1822:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
1823:                          "Aten" + CHR(231) + CHR(227) + "o")
1824:                 RETURN .F.
1825:             ENDIF
1826:             SELECT (par_cCursorDados)
1827:             GO TOP
1828:         ENDIF
1829: 
1830:         loc_cPointOrig    = SET("POINT")
1831:         loc_cSepOrig      = SET("SEPARATOR")
1832:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1833:         SET POINT TO "."
1834:         SET SEPARATOR TO ","
1835:         SET REPORTBEHAVIOR 80
1836: 
1837:         DO CASE
1838:             CASE par_cModo == "PREVIEW"
1839:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1840:             CASE par_cModo == "PRINTER_PROMPT"
1841:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
1842:             CASE par_cModo == "PRINTER"
1843:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
1844:         ENDCASE
1845: 
1846:         SET POINT TO (loc_cPointOrig)
1847:         SET SEPARATOR TO (loc_cSepOrig)
1848:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
1849: 
1850:         TRY
1851:             SET SYSMENU TO DEFAULT
1852:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
1853:                           popRelatorios, popFerramentas, popAjuda
1854:             CriarMenuPrincipal()
1855:         CATCH
1856:             *-- CriarMenuPrincipal fora de escopo (teste automatizado) - silencioso
1857:         ENDTRY
1858: 
1859:         RETURN .T.
1860:     ENDFUNC
1861:     *==========================================================================
1862:     PROCEDURE Destroy()
1863:     *==========================================================================
1864:         LOCAL loc_oErro
1865:         TRY
1866:             *-- Cursores de impressao do FRX (nomes ditados pelo SigPrFem.frx)
1867:             IF USED("TmpImp")
1868:                 USE IN TmpImp
1869:             ENDIF
1870:             IF USED("TmpImprime")
1871:                 USE IN TmpImprime
1872:             ENDIF
1873:             IF USED("TmpImprime2")
1874:                 USE IN TmpImprime2
1875:             ENDIF
1876:             IF USED("Cabecalho")
1877:                 USE IN Cabecalho
1878:             ENDIF
1879: 
1880:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1881:                 THIS.this_oBusinessObject = .NULL.
1882:             ENDIF
1883:         CATCH TO loc_oErro
1884:             MsgErro(loc_oErro.Message + CHR(13) + ;
1885:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1886:                     "Procedure: " + loc_oErro.Procedure, ;
1887:                     "Erro em FormSigPrFem.Destroy")
1888:         ENDTRY
1889:         DODEFAULT()
1890:     ENDPROC
1891: 
1892: ENDDEFINE

