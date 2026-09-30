# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA, CNT_4C_RESUMO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarCursoresImpressao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResultadoDisponivel()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarReportForm()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.MontarCabecalhoImpressao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrFem.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1912 linhas total):

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

*-- Linhas 901 a 1000:
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
982:             SET NULL ON
983:             CREATE CURSOR cursor_4c_Entradas (Emps C(3), TpOps C(15), Qtde N(12,3))
984:             SET NULL OFF
985:             INDEX ON Emps + TpOps TAG TpOps
986: 
987:             *-- Saidas no periodo (legado: Saidas)
988:             IF USED("cursor_4c_Saidas")
989:                 USE IN cursor_4c_Saidas
990:             ENDIF
991:             SET NULL ON
992:             CREATE CURSOR cursor_4c_Saidas (Emps C(3), TpOps C(15), Qtde N(12,3))
993:             SET NULL OFF
994:             INDEX ON Emps + TpOps TAG TpOps
995: 
996:             *-- Saldo atual com funcionarios (legado: Saldos)
997:             IF USED("cursor_4c_Saldos")
998:                 USE IN cursor_4c_Saldos
999:             ENDIF
1000:             SET NULL ON

*-- Linhas 1042 a 1091:
1042:             SET NULL OFF
1043:             MsgErro(loc_oErro.Message + CHR(13) + ;
1044:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1045:                     "Procedure: " + loc_oErro.Procedure, ;
1046:                     "Erro em FormSigPrFem.CriarCursoresResultado")
1047:         ENDTRY
1048:     ENDPROC
1049: 
1050:     *==========================================================================
1051:     PROCEDURE CarregarDados()
1052:     *==========================================================================
1053:     * Liga os 5 grids da area de Resultado aos cursores ja populados e exibe
1054:     * o bloco inteiro - transcricao do trecho final de Processar.Click do
1055:     * legado (os cinco blocos "With ThisForm.Resultado.Detalhe<N>" seguidos de
1056:     * "ThisForm.Resultado.Visible = .t."). Devolve .T. quando o Resultado foi
1057:     * exibido.
1058:     *
1059:     * Nomes de coluna e captions transcritos um a um do legado:
1060:     *   SaldoAnt -> Fase / Qtde / Emp        Entradas -> Operacao / Qtde / Emp
1061:     *   Saidas   -> Operacao / Qtde / Emp    Saldos   -> Fase / Qtde / Emp
1062:     *   Falhas   -> Fase / Falha / Emp
1063:     *==========================================================================
1064:         LOCAL loc_lSucesso, loc_oErro
1065:         loc_lSucesso = .F.
1066: 
1067:         TRY
1068:             *-- Saldo anterior (legado: Detalhe <- SaldoAnt)
1069:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe", "cursor_4c_SaldoAnt", ;
1070:                 "Grupos", "Fase", "Qtde", "Qtde")
1071: 
1072:             *-- Entradas no periodo (legado: detalhe2 <- Entradas)
1073:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe2", "cursor_4c_Entradas", ;
1074:                 "TpOps", "Opera" + CHR(231) + CHR(227) + "o", "Qtde", "Qtde")
1075: 
1076:             *-- Saidas no periodo (legado: detalhe3 <- Saidas)
1077:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe3", "cursor_4c_Saidas", ;
1078:                 "TpOps", "Opera" + CHR(231) + CHR(227) + "o", "Qtde", "Qtde")
1079: 
1080:             *-- Saldo atual com funcionario (legado: detalhe4 <- Saldos)
1081:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe4", "cursor_4c_Saldos", ;
1082:                 "Grupos", "Fase", "Qtde", "Qtde")
1083: 
1084:             *-- Falhas dos funcionarios (legado: detalhe5 <- Falhas)
1085:             THIS.LigarGradeDetalhe("cnt_4c_Detalhe5", "cursor_4c_Falhas", ;
1086:                 "Grupos", "Fase", "Qtde", "Falha")
1087: 
1088:             *-- Totalizadores do bloco Resumo
1089:             THIS.AtualizarResumo()
1090: 
1091:             *-- Exibe o bloco de resultado (legado: ThisForm.Resultado.Visible = .t.)

*-- Linhas 1103 a 1154:
1103:         CATCH TO loc_oErro
1104:             MsgErro(loc_oErro.Message + CHR(13) + ;
1105:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1106:                     "Procedure: " + loc_oErro.Procedure, ;
1107:                     "Erro em FormSigPrFem.CarregarDados")
1108:         ENDTRY
1109: 
1110:         RETURN loc_lSucesso
1111:     ENDPROC
1112: 
1113:     *==========================================================================
1114:     PROTECTED PROCEDURE LigarGradeDetalhe(par_cContainer, par_cCursor, par_cCampo1, par_cCaption1, par_cCampo2, par_cCaption2)
1115:     *==========================================================================
1116:     * Aplica a UM dos 5 sub-containers de detalhe o bind que o legado faz em
1117:     * bloco: torna o container e a grade visiveis, posiciona o cursor no topo,
1118:     * define RecordSource + ControlSource das 3 colunas, os captions e - por
1119:     * ULTIMO - as larguras do dump. A 3a coluna eh sempre Emps/"Emp" nos
1120:     * cinco grids do legado.
1121:     *
1122:     * Por que a largura vem DEPOIS do RecordSource: atribuir RecordSource/
1123:     * ControlSource faz o VFP recalcular as larguras para o default 90 e
1124:     * resetar os Header1.Caption (Problema 48 / regra #35c) - definir antes
1125:     * seria descartado.
1126:     *
1127:     * Sem o GO TOP + Refresh a grade nao repinta as linhas inseridas depois
1128:     * de o cursor ter nascido vazio: o cursor fica cheio e a tela parece sem
1129:     * dados (o legado fecha cada bloco com Select <cursor> / Go Top / .Refresh
1130:     * pelo mesmo motivo).
1131:     *==========================================================================
1132:         LOCAL loc_oDet, loc_oGrid
1133: 
1134:         IF !USED(par_cCursor)
1135:             RETURN
1136:         ENDIF
1137: 
1138:         *-- Os 5 sub-containers de detalhe sao filhos de cnt_4c_Resultado, nao
1139:         *-- do Form (Left/Top no dump sao relativos ao container Resultado).
1140:         loc_oDet = EVALUATE("THIS.cnt_4c_Resultado." + par_cContainer)
1141:         loc_oDet.Visible = .T.
1142: 
1143:         loc_oGrid = loc_oDet.grd_4c_Dados
1144:         loc_oGrid.Visible = .T.
1145: 
1146:         SELECT (par_cCursor)
1147:         GO TOP
1148: 
1149:         *-- ColumnCount/RecordSource ficam FORA do WITH: acessar .Column dentro
1150:         *-- do mesmo WITH que ainda esta definindo o RecordSource estoura
1151:         *-- 'Unknown member COLUMN1' porque as colunas nao existem no momento
1152:         *-- em que o WITH eh aberto.
1153:         loc_oGrid.ColumnCount  = 3
1154:         loc_oGrid.RecordSource = par_cCursor

*-- Linhas 1171 a 1249:
1171:     ENDPROC
1172: 
1173:     *==========================================================================
1174:     PROTECTED PROCEDURE AtualizarResumo()
1175:     *==========================================================================
1176:     * Espelha nos 10 TextBox ReadOnly de cnt_4c_Resumo os totais calculados
1177:     * pelo BO - transcricao do bloco "With ThisForm.Resultado.Resumo" do
1178:     * legado. FONTE UNICA: quem calcula eh o SigPrFemBO (this_n*), o form
1179:     * apenas exibe - as somas do legado (lnSaldoIni + lnTotalEntra +
1180:     * lnSaldoaFun para o sub-total, lnPesagem + lnSaldoFunc para o total)
1181:     * NAO sao repetidas aqui, para o mesmo numero nao ser calculado em dois
1182:     * lugares (regra #17).
1183:     *==========================================================================
1184:         LOCAL loc_oRes, loc_oBO
1185: 
1186:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1187:             RETURN
1188:         ENDIF
1189: 
1190:         loc_oBO  = THIS.this_oBusinessObject
1191:         loc_oRes = THIS.cnt_4c_Resultado.cnt_4c_Resumo
1192: 
1193:         WITH loc_oRes
1194:             .txt_4c_Saldoi.Value    = loc_oBO.this_nSaldoInicial
1195:             .txt_4c_SaldoAnt.Value  = loc_oBO.this_nSaldoAnterior
1196:             .txt_4c_Entradas.Value  = loc_oBO.this_nEntradas
1197:             .txt_4c_TEntradas.Value = loc_oBO.this_nTotalEntradas
1198:             .txt_4c_Saidas.Value    = loc_oBO.this_nSaidas
1199:             .txt_4c_Pesagem.Value   = loc_oBO.this_nPesagem
1200:             .txt_4c_Saldo.Value     = loc_oBO.this_nSaldo
1201:             .txt_4c_SaldoFunc.Value = loc_oBO.this_nSaldoFuncionarios
1202:             .txt_4c_FalhaFunc.Value = loc_oBO.this_nFalhaFuncionarios
1203:             .txt_4c_SaldoT.Value    = loc_oBO.this_nSaldoTotal
1204:             .Refresh()
1205:         ENDWITH
1206:     ENDPROC
1207: 
1208:     *==========================================================================
1209:     PROCEDURE LimparResultado()
1210:     *==========================================================================
1211:     * PUBLIC de proposito (sem PROTECTED): os harness de teste do pipeline
1212:     * chamam esta familia de metodos de FORA da classe, e PEMSTATUS(oForm,
1213:     * "LimparResultado", 5) devolve .T. mesmo com o metodo PROTECTED - so
1214:     * verifica existencia, nao escopo. O teste entraria no branch e a chamada
1215:     * real estouraria "Property LIMPARRESULTADO is not found" (regra #3).
1216:     *
1217:     * Devolve a area de Resultado ao estado de tela recem-aberta: esconde o
1218:     * container (equivale ao "ThisForm.Resultado.Visible = .f." que abre o
1219:     * Processar.Click legado), esconde os cinco sub-containers de detalhe e
1220:     * zera os dez totalizadores.
1221:     *
1222:     * Por que os sub-containers e os totalizadores tambem: no legado os cinco
1223:     * "With ThisForm.Resultado.Detalhe<N> / .Visible = .t." so rodam no FIM de
1224:     * um processamento bem-sucedido, entao um processamento que aborta no meio
1225:     * deixa o bloco inteiro escondido e ninguem ve numero velho. Aqui, sem
1226:     * esta limpeza, os dez TextBox continuariam com os valores da rodada
1227:     * ANTERIOR e os cinco containers continuariam Visible = .T. por baixo do
1228:     * container escondido - e bastaria uma rodada seguinte parar antes de
1229:     * CarregarDados() para o usuario ver, lado a lado, grades da rodada nova e
1230:     * totais da rodada velha, sem nenhum aviso de que sao de periodos
1231:     * diferentes.
1232:     *
1233:     * Os totalizadores sao zerados DIRETO (e nao por AtualizarResumo) porque
1234:     * aqui a intencao eh justamente NAO espelhar o BO: as properties this_n*
1235:     * dele ainda carregam o resultado antigo neste ponto.
1236:     *==========================================================================
1237:         LOCAL loc_nI, loc_cCnt, loc_oRes
1238: 
1239:         THIS.this_lResultadoPronto    = .F.
1240:         THIS.cnt_4c_Resultado.Visible = .F.
1241: 
1242:         *-- Os cinco sub-containers do dump: Detalhe, detalhe2..detalhe5.
1243:         *-- Acesso por nome montado vai de STORE ... TO (expr), nunca de
1244:         *-- Controls("<nome>") - Controls eh indexado por NUMERO (regra #34).
1245:         FOR loc_nI = 1 TO 5
1246:             loc_cCnt = "cnt_4c_Detalhe" + IIF(loc_nI = 1, "", TRANSFORM(loc_nI))
1247:             IF PEMSTATUS(THIS.cnt_4c_Resultado, loc_cCnt, 5)
1248:                 STORE .F. TO ("THIS.cnt_4c_Resultado." + loc_cCnt + ".Visible")
1249:             ENDIF

*-- Linhas 1267 a 1575:
1267:     ENDPROC
1268: 
1269:     *==========================================================================
1270:     PROCEDURE HabilitarCampos(par_lHabilitar)
1271:     *==========================================================================
1272:     * PUBLIC pelo mesmo motivo de LimparResultado (regra #3): os harness do
1273:     * pipeline chamam oForm.HabilitarCampos(.F./.T.) de fora da classe.
1274:     *
1275:     * Liga/desliga os tres filtros do topo e os quatro botoes de acao. Eh a
1276:     * metade VISIVEL do guard this_lProcessando: enquanto o SigPrFemBO calcula,
1277:     * o botao Processar fica Enabled = .F. e nem chega a disparar o Click, em
1278:     * vez de depender so da flag para recusar a reentrada.
1279:     *
1280:     * Desligar tambem cmd_4c_Sair eh proposital: ele tem Cancel = .T. (responde
1281:     * ao ESC), e fechar a tela no meio do processamento destruiria os cursores
1282:     * que o BO ainda esta percorrendo.
1283:     *
1284:     * Os quatro botoes sobrevivem ao Enabled = .F. sem perder o icone porque
1285:     * ConfigurarBotaoAcao ja os cria com .Themes = .T. + .DisabledPicture
1286:     * apontando para a MESMA imagem (regra do CommandButton standalone com
1287:     * Picture).
1288:     *
1289:     * REABILITAR EH OBRIGACAO DO FUNIL, NAO DO CHAMADOR (licao do Erro176):
1290:     * quem chama HabilitarCampos(.F.) eh so BtnProcessarClick, e ele repoe
1291:     * HabilitarCampos(.T.) nos DOIS caminhos de volta - o de sucesso e o do
1292:     * CATCH. Sem a reposicao no CATCH, um erro no meio do calculo deixaria a
1293:     * tela inteira cinza e inutilizavel ate ser fechada e reaberta.
1294:     *==========================================================================
1295:         LOCAL loc_lLiga
1296: 
1297:         loc_lLiga = .T.
1298:         IF VARTYPE(par_lHabilitar) = "L"
1299:             loc_lLiga = par_lHabilitar
1300:         ENDIF
1301: 
1302:         THIS.txt_4c_Datai.Enabled         = loc_lLiga
1303:         THIS.txt_4c_Dataf.Enabled         = loc_lLiga
1304:         THIS.txt_4c_Demonstrativo.Enabled = loc_lLiga
1305: 
1306:         THIS.cmd_4c_Processar.Enabled  = loc_lLiga
1307:         THIS.cmd_4c_Visualizar.Enabled = loc_lLiga
1308:         THIS.cmd_4c_Imprimir.Enabled   = loc_lLiga
1309:         THIS.cmd_4c_Sair.Enabled       = loc_lLiga
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1314:     *==========================================================================
1315:     * Torna visiveis todos os controles recursivamente (AddObject cria com
1316:     * Visible = .F.). FILTRO OBRIGATORIO: o container Resultado (Fase 4) e
1317:     * os cinco sub-containers de detalhe (Detalhe/detalhe2/detalhe3/detalhe4/
1318:     * detalhe5) sao flutuantes com Visible=.F. no legado ate o usuario clicar
1319:     * Processar - NAO tornar visiveis aqui, mas recursar dentro deles para
1320:     * que os filhos (Grid/Titulo) fiquem prontos quando o botao Processar
1321:     * exibir o container.
1322:     *==========================================================================
1323:         LOCAL loc_nI, loc_oControl, loc_nP
1324:         IF VARTYPE(par_oContainer) != "O"
1325:             par_oContainer = THIS
1326:         ENDIF
1327:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1328:             loc_oControl = par_oContainer.Controls(loc_nI)
1329:             IF VARTYPE(loc_oControl) = "O"
1330:                 IF INLIST(UPPER(loc_oControl.Name), "CNT_4C_RESULTADO", ;
1331:                           "CNT_4C_DETALHE", "CNT_4C_DETALHE2", "CNT_4C_DETALHE3", ;
1332:                           "CNT_4C_DETALHE4", "CNT_4C_DETALHE5")
1333:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1334:                        loc_oControl.ControlCount > 0
1335:                         THIS.TornarControlesVisiveis(loc_oControl)
1336:                     ENDIF
1337:                     LOOP
1338:                 ENDIF
1339: 
1340:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1341:                     loc_oControl.Visible = .T.
1342:                 ENDIF
1343:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1344:                     FOR loc_nP = 1 TO loc_oControl.PageCount
1345:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1346:                     ENDFOR
1347:                 ENDIF
1348:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
1349:                    loc_oControl.ControlCount > 0
1350:                     THIS.TornarControlesVisiveis(loc_oControl)
1351:                 ENDIF
1352:             ENDIF
1353:         ENDFOR
1354:     ENDPROC
1355: 
1356: 
1357:     *==========================================================================
1358:     * BtnProcessarClick - evento do botao Processar (SIGPRFEM.Processar.Click)
1359:     *
1360:     * Transcricao da PARTE DE TELA do Click legado: le os tres filtros, aplica
1361:     * as tres validacoes com SetFocus, esconde o bloco de Resultado, delega o
1362:     * calculo ao BO e volta a exibir o Resultado com as grades ligadas.
1363:     *
1364:     * As tres validacoes ficam AQUI (e nao no BO) porque cada uma devolve o
1365:     * foco a um controle - e os controles sao do form. Os RETURN delas vem
1366:     * ANTES do TRY (regra #1: RETURN nao pode existir dentro de TRY/CATCH).
1367:     *
1368:     * Ordem e mensagens EXATAS do legado:
1369:     *   1. Empty(ldDataf)      -> "A Data Final Deve Ser Informada!!!"      -> Get_Dataf
1370:     *   2. ldDatai > ldDataf   -> "A Data Final Deve Ser Maior Que a Data Inicial!!!" -> Get_Datai
1371:     *   3. Empty(lcConfig)     -> "A Configuracao Deve Ser Informada!!!"    -> Get_Demonstrativo
1372:     *==========================================================================
1373:     PROCEDURE BtnProcessarClick()
1374:         LOCAL loc_dDataI, loc_dDataF, loc_cConfig, loc_oErro
1375: 
1376:         *-- Guard de reentrancia: a barra de progresso do BO devolve a vez ao
1377:         *-- VFP a cada Refresh, entao um segundo clique cairia aqui com o
1378:         *-- primeiro processamento ainda percorrendo os cursores. RETURN ANTES
1379:         *-- do TRY (regra #1).
1380:         IF THIS.this_lProcessando
1381:             RETURN
1382:         ENDIF
1383: 
1384:         *-- SIGPRFEM eh OPERACIONAL FLAT: os filtros sao filhos DIRETOS do Form
1385:         *-- (nao ha PageFrame nem container de filtros), como em ConfigurarFiltros
1386:         loc_dDataI  = ConverterParaData(THIS.txt_4c_Datai.Value)
1387:         loc_dDataF  = ConverterParaData(THIS.txt_4c_Dataf.Value)
1388:         loc_cConfig = ALLTRIM(THIS.txt_4c_Demonstrativo.Value)
1389: 
1390:         IF EMPTY(loc_dDataF)
1391:             MsgAviso("A Data Final Deve Ser Informada!!!", ;
1392:                      "Aten" + CHR(231) + CHR(227) + "o")
1393:             THIS.txt_4c_Dataf.SetFocus()
1394:             RETURN
1395:         ENDIF
1396: 
1397:         IF loc_dDataI > loc_dDataF
1398:             MsgAviso("A Data Final Deve Ser Maior Que a Data Inicial!!!", ;
1399:                      "Aten" + CHR(231) + CHR(227) + "o")
1400:             THIS.txt_4c_Datai.SetFocus()
1401:             RETURN
1402:         ENDIF
1403: 
1404:         IF EMPTY(loc_cConfig)
1405:             MsgAviso("A Configura" + CHR(231) + CHR(227) + "o Deve Ser Informada!!!", ;
1406:                      "Aten" + CHR(231) + CHR(227) + "o")
1407:             THIS.txt_4c_Demonstrativo.SetFocus()
1408:             RETURN
1409:         ENDIF
1410: 
1411:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1412:             MsgErro("Objeto de neg" + CHR(243) + "cio n" + CHR(227) + "o dispon" + ;
1413:                     CHR(237) + "vel.", "Erro em FormSigPrFem.BtnProcessarClick")
1414:             RETURN
1415:         ENDIF
1416: 
1417:         TRY
1418:             THIS.this_lProcessando = .T.
1419:             THIS.HabilitarCampos(.F.)
1420: 
1421:             *-- Legado: ThisForm.Resultado.Visible = .f. / ThisForm.Refresh
1422:             *-- (aqui tambem escondendo os 5 detalhes e zerando os totais,
1423:             *-- para nao sobrar numero da rodada anterior se esta abortar)
1424:             THIS.LimparResultado()
1425: 
1426:             THIS.MousePointer = 11
1427: 
1428:             IF THIS.this_oBusinessObject.Processar(loc_dDataI, loc_dDataF, loc_cConfig)
1429:                 *-- Liga as 5 grades + espelha os totalizadores + exibe o bloco
1430:                 IF THIS.CarregarDados()
1431:                     *-- "Criando a Impressao" do fim do Click legado: monta os
1432:                     *-- cursores que o SigPrFem.frx consome (TmpImp/cabecalho)
1433:                     THIS.this_lResultadoPronto = THIS.MontarCursoresImpressao()
1434:                 ENDIF
1435:             ENDIF
1436: 
1437:             THIS.MousePointer = 0
1438:             THIS.HabilitarCampos(.T.)
1439:             THIS.this_lProcessando = .F.
1440:         CATCH TO loc_oErro
1441:             *-- Caminho de volta do ERRO: repor o estado da tela AQUI tambem,
1442:             *-- senao um erro no meio do calculo deixa os filtros e os quatro
1443:             *-- botoes cinza para sempre (licao do Erro176)
1444:             THIS.MousePointer = 0
1445:             THIS.HabilitarCampos(.T.)
1446:             THIS.this_lProcessando = .F.
1447:             MsgErro(loc_oErro.Message + CHR(13) + ;
1448:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1449:                     "Procedure: " + loc_oErro.Procedure, ;
1450:                     "Erro em FormSigPrFem.BtnProcessarClick")
1451:         ENDTRY
1452:     ENDPROC
1453: 
1454:     *==========================================================================
1455:     * BtnVisualizarClick - evento do botao Video (SIGPRFEM.Visualizar.Click)
1456:     *
1457:     * Legado:
1458:     *   If thisform.resultado.Visible / Select TmpImp / Go Top / If !Eof()
1459:     *       Report Form SIGPRFEM Preview NoConsole
1460:     *
1461:     * O "resultado.Visible" do legado eh o gate: sem ter processado, o botao
1462:     * nao faz nada. Aqui o gate eh o mesmo container (cnt_4c_Resultado) mais a
1463:     * flag this_lResultadoPronto, que so fica .T. quando os cursores de
1464:     * impressao foram montados - assim o clique antes de processar avisa em vez
1465:     * de abrir um preview vazio.
1466:     *==========================================================================
1467:     PROCEDURE BtnVisualizarClick()
1468:         LOCAL loc_oErro
1469: 
1470:         IF !THIS.ResultadoDisponivel()
1471:             RETURN
1472:         ENDIF
1473: 
1474:         TRY
1475:             = THIS.ExecutarReportForm("SigPrFem", "PREVIEW", "TmpImp")
1476:         CATCH TO loc_oErro
1477:             MsgErro(loc_oErro.Message + CHR(13) + ;
1478:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1479:                     "Procedure: " + loc_oErro.Procedure, ;
1480:                     "Erro em FormSigPrFem.BtnVisualizarClick")
1481:         ENDTRY
1482:     ENDPROC
1483: 
1484:     *==========================================================================
1485:     * BtnImprimirClick - evento do botao Impressora (SIGPRFEM.Imprimir.Click)
1486:     *
1487:     * Legado: identico ao Visualizar, trocando "Preview" por "To Print Prompt".
1488:     *==========================================================================
1489:     PROCEDURE BtnImprimirClick()
1490:         LOCAL loc_oErro
1491: 
1492:         IF !THIS.ResultadoDisponivel()
1493:             RETURN
1494:         ENDIF
1495: 
1496:         TRY
1497:             = THIS.ExecutarReportForm("SigPrFem", "PRINTER_PROMPT", "TmpImp")
1498:         CATCH TO loc_oErro
1499:             MsgErro(loc_oErro.Message + CHR(13) + ;
1500:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1501:                     "Procedure: " + loc_oErro.Procedure, ;
1502:                     "Erro em FormSigPrFem.BtnImprimirClick")
1503:         ENDTRY
1504:     ENDPROC
1505: 
1506:     *==========================================================================
1507:     * BtnSairClick - evento do botao Encerrar (SIGPRFEM.Sair.Click)
1508:     * Legado: ThisForm.Release
1509:     *==========================================================================
1510:     PROCEDURE BtnSairClick()
1511:         THIS.Release()
1512:     ENDPROC
1513: 
1514:     *==========================================================================
1515:     * ResultadoDisponivel - gate comum de Video/Impressora
1516:     *
1517:     * Reproduz o "If thisform.resultado.Visible ... If !Eof()" que envolve os
1518:     * dois Click de relatorio do legado. Devolve .T. so quando ha o que
1519:     * imprimir; quando nao ha, avisa (o legado fica MUDO, o que faz o usuario
1520:     * clicar varias vezes achando que o botao esta quebrado - desvio
1521:     * deliberado, e o unico do bloco).
1522:     *==========================================================================
1523:     PROTECTED FUNCTION ResultadoDisponivel()
1524:         LOCAL loc_lPronto
1525:         loc_lPronto = .F.
1526: 
1527:         IF THIS.cnt_4c_Resultado.Visible AND THIS.this_lResultadoPronto AND ;
1528:            USED("TmpImp")
1529:             SELECT TmpImp
1530:             GO TOP
1531:             loc_lPronto = !EOF("TmpImp")
1532:         ENDIF
1533: 
1534:         IF !loc_lPronto
1535:             MsgAviso("Processe a an" + CHR(225) + "lise antes de emitir o relat" + ;
1536:                      CHR(243) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
1537:         ENDIF
1538: 
1539:         RETURN loc_lPronto
1540:     ENDFUNC
1541: 
1542:     *==========================================================================
1543:     * MontarCursoresImpressao - bloco "Criando a Impressao" do fim de
1544:     * Processar.Click legado.
1545:     *
1546:     * Monta TmpImprime (coluna da esquerda: totais e falhas por fase),
1547:     * TmpImprime2 (coluna da direita: resumo de entradas/saidas/saldos), faz o
1548:     * FULL JOIN das duas em TmpImp e cria o cursor Cabecalho.
1549:     *
1550:     * Os nomes TmpImp/Cabecalho e os nomes de campo (Linha/Cabec/Titulo/Valor/
1551:     * Traco/Entrada/Saida/Falha/Linha2/Cabec2/Titulo2/Valor2/Traco2/Emps) NAO
1552:     * levam o prefixo cursor_4c_ nem sufixo _4c_: sao contrato do SigPrFem.frx,
1553:     * que veio do legado sem alteracao (PILAR 1/2). Renomear aqui quebraria
1554:     * todas as expressoes do FRX.
1555:     *
1556:     * As somas usadas nas linhas do relatorio vem das properties this_n* do BO
1557:     * (FONTE UNICA - regra #17): o total nao eh recalculado aqui.
1558:     *==========================================================================
1559:     PROTECTED FUNCTION MontarCursoresImpressao()
1560:         LOCAL loc_lSucesso, loc_oErro, loc_oBO
1561:         LOCAL loc_nLinha, loc_nLinha2, loc_nPerc
1562:         LOCAL loc_nQEnt, loc_nQSai, loc_nQFalha, loc_cOrdem
1563: 
1564:         loc_lSucesso = .F.
1565: 
1566:         TRY
1567:             loc_oBO = THIS.this_oBusinessObject
1568: 
1569:             IF USED("TmpImprime2")
1570:                 USE IN TmpImprime2
1571:             ENDIF
1572:             CREATE CURSOR TmpImprime2 (Linha2 N(3), Cabec2 L, Titulo2 C(40), ;
1573:                                        Valor2 N(12,3), Traco2 L, Emps C(3))
1574: 
1575:             IF USED("TmpImprime")

*-- Linhas 1750 a 1802:
1750: 
1751:             *-- Cabecalho do FRX (razao social da empresa + titulo + periodo)
1752:             IF !THIS.MontarCabecalhoImpressao()
1753:                 MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel montar o cabe" + ;
1754:                          CHR(231) + "alho do relat" + CHR(243) + "rio.", ;
1755:                          "Aten" + CHR(231) + CHR(227) + "o")
1756:             ENDIF
1757: 
1758:             loc_lSucesso = USED("TmpImp")
1759:         CATCH TO loc_oErro
1760:             MsgErro(loc_oErro.Message + CHR(13) + ;
1761:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1762:                     "Procedure: " + loc_oErro.Procedure, ;
1763:                     "Erro em FormSigPrFem.MontarCursoresImpressao")
1764:         ENDTRY
1765: 
1766:         RETURN loc_lSucesso
1767:     ENDFUNC
1768: 
1769:     *==========================================================================
1770:     * MontarCabecalhoImpressao - cursor "Cabecalho" consumido pelo SigPrFem.frx
1771:     *
1772:     * Legado:
1773:     *   CursorQuery('SigCdEmp', 'crSigCdEmp', 'Cemps', _Empr, 'Razas')
1774:     *   Create Cursor Cabecalho(pNomeEmpresa c(60), pRelTitulo c(60), pPeriodo c(60))
1775:     *   Insert ... Values (crSigCdEmp.Razas, 'Analise de Producao',
1776:     *                      'Periodo : ' + Dtoc(ldDatai) + ' ate ' + Dtoc(ldDataf))
1777:     *
1778:     * SigCdEmp usa Cemps/Razas (nao Cemps/Razas) - conferido em docs/schema.sql.
1779:     *==========================================================================
1780:     PROTECTED FUNCTION MontarCabecalhoImpressao()
1781:         LOCAL loc_cRazao, loc_nRet, loc_cSQL, loc_oBO
1782: 
1783:         loc_oBO   = THIS.this_oBusinessObject
1784:         loc_cRazao = ""
1785: 
1786:         IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
1787:             IF USED("cursor_4c_CdEmp")
1788:                 USE IN cursor_4c_CdEmp
1789:             ENDIF
1790:             loc_cSQL = "SELECT Cemps, Razas FROM SigCdEmp WHERE Cemps = " + ;
1791:                        EscaparSQL(go_4c_Sistema.cCodEmpresa)
1792:             loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CdEmp")
1793:             IF loc_nRet >= 1 AND USED("cursor_4c_CdEmp") AND !EOF("cursor_4c_CdEmp")
1794:                 loc_cRazao = ALLTRIM(TratarNulo(cursor_4c_CdEmp.Razas, ""))
1795:             ENDIF
1796:         ENDIF
1797: 
1798:         IF EMPTY(loc_cRazao)
1799:             loc_cRazao = ALLTRIM(go_4c_Sistema.cEmpresa)
1800:         ENDIF
1801: 
1802:         IF USED("Cabecalho")

*-- Linhas 1839 a 1912:
1839: 
1840:         IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
1841:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
1842:                 MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
1843:                          "Aten" + CHR(231) + CHR(227) + "o")
1844:                 RETURN .F.
1845:             ENDIF
1846:             SELECT (par_cCursorDados)
1847:             GO TOP
1848:         ENDIF
1849: 
1850:         loc_cPointOrig    = SET("POINT")
1851:         loc_cSepOrig      = SET("SEPARATOR")
1852:         loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
1853:         SET POINT TO "."
1854:         SET SEPARATOR TO ","
1855:         SET REPORTBEHAVIOR 80
1856: 
1857:         DO CASE
1858:             CASE par_cModo == "PREVIEW"
1859:                 REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
1860:             CASE par_cModo == "PRINTER_PROMPT"
1861:                 REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
1862:             CASE par_cModo == "PRINTER"
1863:                 REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
1864:         ENDCASE
1865: 
1866:         SET POINT TO (loc_cPointOrig)
1867:         SET SEPARATOR TO (loc_cSepOrig)
1868:         SET REPORTBEHAVIOR (loc_nBehaviorOrig)
1869: 
1870:         TRY
1871:             SET SYSMENU TO DEFAULT
1872:             RELEASE POPUP popArquivo, popCadastros, popMovimentos, ;
1873:                           popRelatorios, popFerramentas, popAjuda
1874:             CriarMenuPrincipal()
1875:         CATCH
1876:             *-- CriarMenuPrincipal fora de escopo (teste automatizado) - silencioso
1877:         ENDTRY
1878: 
1879:         RETURN .T.
1880:     ENDFUNC
1881:     *==========================================================================
1882:     PROCEDURE Destroy()
1883:     *==========================================================================
1884:         LOCAL loc_oErro
1885:         TRY
1886:             *-- Cursores de impressao do FRX (nomes ditados pelo SigPrFem.frx)
1887:             IF USED("TmpImp")
1888:                 USE IN TmpImp
1889:             ENDIF
1890:             IF USED("TmpImprime")
1891:                 USE IN TmpImprime
1892:             ENDIF
1893:             IF USED("TmpImprime2")
1894:                 USE IN TmpImprime2
1895:             ENDIF
1896:             IF USED("Cabecalho")
1897:                 USE IN Cabecalho
1898:             ENDIF
1899: 
1900:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1901:                 THIS.this_oBusinessObject = .NULL.
1902:             ENDIF
1903:         CATCH TO loc_oErro
1904:             MsgErro(loc_oErro.Message + CHR(13) + ;
1905:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1906:                     "Procedure: " + loc_oErro.Procedure, ;
1907:                     "Erro em FormSigPrFem.Destroy")
1908:         ENDTRY
1909:         DODEFAULT()
1910:     ENDPROC
1911: 
1912: ENDDEFINE

