# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (9)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_EMP1. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterFiltroContaEquipe()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ObterNomeConta()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.pgf_4c_Job()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ResolverControle()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.CampoPreenchido()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValorCheck()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oGrid define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oGrid.RecordSource).
- [LAYOUT-POSITION] Controle 'lbl_01_019' (parent: SIGOPJOB.pgfPagina.pgPagina1): Left original=417 vs migrado 'lbl_4c_Lbl_01_019a' Left=501 (diff=84px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpJob.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4416 linhas total):

*-- Linhas 49 a 391:
49:     *-- Partes da chave posicional EmpDopNums (Emps(3)+Dopes(20)+Str(Numes,6))
50:     *-- do registro de SigMvJbC sendo editado - equivalentes a TprMvCab.Emps/
51:     *-- Dopes/Jobs do cursor global do form pai legado. Preenchidas pelo
52:     *-- chamador antes do Show() (CREATEOBJECT + atribuicao, ou via Init).
53:     this_cEmps  = ""
54:     this_cDopes = ""
55:     this_nNumes = 0
56: 
57:     *-- Guarda de reentrancia do lookup de contas da Page3 (regra #37/#47):
58:     *-- o picker (FormBuscaAuxiliar) eh MODAL e tira o foco do TextBox de
59:     *-- codigo, o que pode redisparar o proprio LostFocus antes do primeiro
60:     *-- Show() terminar.
61:     this_lEmLookupConta = .F.
62: 
63:     *-- Guarda de "valor nao mudou" (regra #47 - complementar a reentrancia
64:     *-- acima): LostFocus dispara SEMPRE que o foco sai do campo, mas o
65:     *-- Valid do legado (get_01_0NN/get_01_0NNa) so dispara quando o valor
66:     *-- MUDA. Sem isto, tabular pelas 14 linhas de equipe sem digitar nada
67:     *-- reabriria o lookup (ou repetiria o SQLEXEC do match exato) a cada
68:     *-- saida de campo. Uma property por LINHA (nao por campo): o par
69:     *-- codigo+nome da mesma linha compartilha o guard, igual ao padrao
70:     *-- de FormSigOpIpE.ValidarOcorrenciaEtiqueta (codigo+descricao
71:     *-- combinados com "|").
72:     this_cUltimoValidarConta024Validado = ""
73:     this_cUltimoValidarConta025Validado = ""
74:     this_cUltimoValidarConta026Validado = ""
75:     this_cUltimoValidarConta027Validado = ""
76:     this_cUltimoValidarConta028Validado = ""
77:     this_cUltimoValidarConta029Validado = ""
78:     this_cUltimoValidarConta030Validado = ""
79:     this_cUltimoValidarConta031Validado = ""
80:     this_cUltimoValidarConta032Validado = ""
81:     this_cUltimoValidarConta033Validado = ""
82:     this_cUltimoValidarConta034Validado = ""
83:     this_cUltimoValidarConta035Validado = ""
84:     this_cUltimoValidarConta036Validado = ""
85:     this_cUltimoValidarConta037Validado = ""
86: 
87:     *==========================================================================
88:     * Init - Recebe o form pai e a chave do Job sendo complementado.
89:     * Todos os parametros sao opcionais para permitir abertura standalone
90:     * (menu/teste automatizado) sem um form pai real.
91:     *==========================================================================
92:     PROCEDURE Init(par_oFormPai, par_cEmps, par_cDopes, par_nNumes, par_cContas)
93:         IF VARTYPE(par_oFormPai) = "O"
94:             THIS.this_oFormPai = par_oFormPai
95:             IF PEMSTATUS(par_oFormPai, "this_cModoAtual", 5)
96:                 THIS.this_cModoAtual = par_oFormPai.this_cModoAtual
97:             ENDIF
98:         ENDIF
99:         IF VARTYPE(par_cEmps) = "C"
100:             THIS.this_cEmps = par_cEmps
101:         ENDIF
102:         IF VARTYPE(par_cDopes) = "C"
103:             THIS.this_cDopes = par_cDopes
104:         ENDIF
105:         IF VARTYPE(par_nNumes) = "N"
106:             THIS.this_nNumes = par_nNumes
107:         ENDIF
108:         IF VARTYPE(par_cContas) = "C"
109:             THIS.this_cContas = par_cContas
110:         ENDIF
111: 
112:         RETURN DODEFAULT()
113:     ENDPROC
114: 
115:     *==========================================================================
116:     * InicializarForm - Instancia o SigOpJobBO e cria a estrutura visual base
117:     * (PageFrame de 6 abas + botao de retorno). Carga de dados (CarregarDo-
118:     * Cursor/Buscar), campos de identificacao do Job e os controles de cada
119:     * aba ficam para as Fases 5-6 (TextBoxes de dados).
120:     *==========================================================================
121:     PROTECTED PROCEDURE InicializarForm()
122:         LOCAL loc_lSucesso, loc_oErro
123:         loc_lSucesso = .F.
124: 
125:         TRY
126:             SET DATE TO BRITISH
127:             SET CENTURY ON
128: 
129:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpJobBO")
130:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
131: 
132:                 IF !EMPTY(ALLTRIM(THIS.this_cDopes))
133:                     THIS.Caption = "Complementos : " + ALLTRIM(PROPER(THIS.this_cDopes))
134:                 ENDIF
135: 
136:                 THIS.this_oBusinessObject.this_cEmpDopNums = ;
137:                     THIS.this_oBusinessObject.MontarChaveEmpDopNums(THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes)
138: 
139:                 *-- Define se o BO vai Inserir (registro novo) ou Atualizar
140:                 *-- (complemento ja gravado) - precisa vir ANTES de CmdRetornarClick
141:                 *-- chamar Salvar(), que exige this_lEmEdicao = .T. (regra do
142:                 *-- BusinessBase: Salvar() sem NovoRegistro/EditarRegistro falha).
143:                 THIS.CarregarOuIniciarRegistro()
144: 
145:                 *-- Parametrizacao da OPERACAO (SigOpCdI) e divisao de notas
146:                 *-- da EMPRESA (SigCdEmp). No legado as duas vem prontas na
147:                 *-- data session do form pai (crSigOpCdI) ou de um
148:                 *-- CursorQuery do proprio Init (LocalEmps); aqui o BO
149:                 *-- carrega. Precisam vir ANTES da configuracao visual porque
150:                 *-- alimentam os captions (AplicarTitulosPersonalizados), a
151:                 *-- marcacao de obrigatoriedade (ChecarCamposObrigatorios) e
152:                 *-- a visibilidade dos blocos de equipe
153:                 *-- (AplicarVisibilidadeEquipes).
154:                 THIS.this_oBusinessObject.CarregarConfiguracaoJob(THIS.this_cDopes)
155:                 THIS.this_oBusinessObject.CarregarDivisaoNotas(THIS.this_cEmps)
156: 
157:                 THIS.ConfigurarPageFrame()
158:                 THIS.ConfigurarCabecalhoJob()
159:                 THIS.ConfigurarAbaBriefing()
160:                 THIS.ConfigurarAbaDesafio()
161:                 THIS.ConfigurarAbaEquipes()
162:                 THIS.ConfigurarAbaMateriais()
163:                 THIS.ConfigurarAbaFinanceiroCampos()
164:                 THIS.ConfigurarAbaApresentacao()
165:                 THIS.ConfigurarBotaoRetornar()
166:                 THIS.ConfigurarGridFontes()
167: 
168:                 *-- Depois de TODOS os controles existirem: o metodo varre a
169:                 *-- arvore e nao enxerga o que ainda nao foi criado.
170:                 THIS.VincularChecagemObrigatorios(THIS)
171: 
172:                 THIS.TornarControlesVisiveis(THIS)
173: 
174:                 *-- DEPOIS de TornarControlesVisiveis, que forca Visible = .T.
175:                 *-- em tudo: aplicado antes, a regra de visibilidade dos
176:                 *-- blocos de equipe seria apagada.
177:                 THIS.AplicarTitulosPersonalizados()
178: 
179:                 THIS.CarregarLista()
180:                 THIS.CarregarCabecalhoJob()
181:                 THIS.BOParaForm()
182: 
183:                 THIS.AplicarVisibilidadeEquipes()
184: 
185:                 *-- Por ultimo: o legado chama ChecaObrigs no Init com o
186:                 *-- cursor ja preenchido, e aqui o equivalente e' depois de
187:                 *-- BOParaForm ter levado os valores para os controles.
188:                 THIS.ChecarCamposObrigatorios()
189: 
190:                 *-- Ultima linha do Init legado: ".pgfPagina.ActivePage =
191:                 *-- .pgfPagina.pgPagina1.PageOrder". Hoje e' equivalente ao
192:                 *-- default do VFP (Page1.PageOrder = 1), mas fica explicito
193:                 *-- porque ActivePage e' o PageOrder e NAO a ordem de
194:                 *-- declaracao (regra #31) - neste PageFrame a Page6 tem
195:                 *-- PageOrder 3, entao presumir a ordem de declaracao aqui
196:                 *-- abriria a aba errada se alguem mexer nos PageOrder.
197:                 THIS.pgf_4c_Job.ActivePage = THIS.pgf_4c_Job.Page1.PageOrder
198: 
199:                 loc_lSucesso = .T.
200:             ELSE
201:                 MsgErro("Falha ao criar SigOpJobBO.", "Erro em InicializarForm")
202:             ENDIF
203:         CATCH TO loc_oErro
204:             MsgErro(loc_oErro.Message + CHR(13) + ;
205:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
206:                     "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
207:         ENDTRY
208: 
209:         RETURN loc_lSucesso
210:     ENDPROC
211: 
212:     *==========================================================================
213:     * CarregarOuIniciarRegistro - Decide se o complemento do Job (SigMvJbC)
214:     * ja existe ou e novo, e prepara o BusinessBase de acordo:
215:     *
216:     *   - EXISTE  -> CarregarDoCursor() preenche as propriedades this_* a
217:     *                partir do registro gravado, depois EditarRegistro()
218:     *                (this_lEmEdicao = .T., this_lNovoRegistro = .F.).
219:     *   - NAO EXISTE -> NovoRegistro() (this_lEmEdicao = .T.,
220:     *                   this_lNovoRegistro = .T.) - os valores ficam nos
221:     *                   defaults declarados no BO (campos em branco).
222:     *
223:     * O legado nao precisa dessa distincao porque o TextBox ja esta ligado
224:     * por ControlSource ao cursor BUFFERED do form pai (sempre existe uma
225:     * linha, em branco ou nao, e o TableUpdate acontece quando o movimento
226:     * inteiro e salvo). Nesta arquitetura o BO grava com SQLEXEC explicito
227:     * em CmdRetornarClick, que exige this_lEmEdicao = .T. (BusinessBase.
228:     * Salvar() recusa gravar fora de edicao) e decide Inserir/Atualizar pelo
229:     * this_lNovoRegistro definido aqui.
230:     *
231:     * Sem conexao (modo de teste/validacao de UI) cai direto em
232:     * NovoRegistro() - ConexaoAtiva() ja devolve .F. nesse caso.
233:     *==========================================================================
234:     PROTECTED PROCEDURE CarregarOuIniciarRegistro()
235:         LOCAL loc_cSQL, loc_nResultado, loc_cAliasTmp, loc_oErro
236:         loc_cAliasTmp = "cursor_4c_JobTmp"
237: 
238:         TRY
239:             IF USED(loc_cAliasTmp)
240:                 USE IN (loc_cAliasTmp)
241:             ENDIF
242: 
243:             loc_nResultado = -1
244:             IF THIS.this_oBusinessObject.ConexaoAtiva()
245:                 loc_cSQL = "SELECT * FROM SigMvJbC WHERE empdopnums = " + ;
246:                     EscaparSQL(THIS.this_oBusinessObject.this_cEmpDopNums)
247:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)
248:             ENDIF
249: 
250:             IF loc_nResultado >= 0 AND USED(loc_cAliasTmp) AND RECCOUNT(loc_cAliasTmp) > 0
251:                 SELECT (loc_cAliasTmp)
252:                 GO TOP
253:                 THIS.this_oBusinessObject.CarregarDoCursor(loc_cAliasTmp)
254:                 THIS.this_oBusinessObject.EditarRegistro()
255:             ELSE
256:                 THIS.this_oBusinessObject.NovoRegistro()
257:             ENDIF
258: 
259:             IF USED(loc_cAliasTmp)
260:                 USE IN (loc_cAliasTmp)
261:             ENDIF
262:         CATCH TO loc_oErro
263:             MsgErro(loc_oErro.Message + CHR(13) + ;
264:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
265:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarOuIniciarRegistro")
266:         ENDTRY
267:     ENDPROC
268: 
269:     *==========================================================================
270:     * ConfigurarPageFrame - Cria pgf_4c_Job com as 6 abas do legado
271:     * (pgfPagina.pgPagina1..pgPagina6). Tabs=.T. porque o SCX nao tem nenhum
272:     * CommandGroup/OptionGroup navegando entre paginas (so cmdRetornar, que
273:     * fecha o form) - a navegacao eh pelas abas nativas mesmo.
274:     *
275:     * Posicoes EXATAS do dump do SCX legado (tasks\task755\layout.json):
276:     * pgfPagina Top=130, Left=-1, Width=1005, Height=473.
277:     *
278:     * Captions, fonte, cores e Picture de cada Page vem do dump do SCX
279:     * (bloco "Page<N>.*" de SIGOPJOB.pgfPagina) - transcritos LITERALMENTE.
280:     *
281:     * ATENCAO (regra #31): o PageOrder do legado NAO eh a ordem de declaracao.
282:     * pgPagina6 ("Apresentacao") tem PageOrder = 3, e por isso pgPagina3/4/5
283:     * aparecem em 4/5/6. Medido no VFP9 (automation\medir_pageorder_755.prg):
284:     * UMA atribuicao .Page6.PageOrder = 3 empurra Page3/4/5 para 4/5/6 e
285:     * reproduz exatamente a ordem do legado; o acesso por NOME (.Page3,
286:     * .Page6) continua apontando para o mesmo objeto depois disso, entao os
287:     * metodos Configurar*/Carregar* nao mudam.
288:     *
289:     * O PageFrame NAO recebe FontName/FontSize nem as Pages recebem Visible:
290:     * nenhuma das duas classes tem essas propriedades (medido em
291:     * automation\propriedades_baseclasses.txt) e a atribuicao abortaria este
292:     * metodo no meio, deixando o PageFrame sem Caption e invisivel (regra #33).
293:     * A fonte do legado mora na PAGE, que tem FontBold/FontName/FontSize.
294:     *==========================================================================
295:     PROTECTED PROCEDURE ConfigurarPageFrame()
296:         LOCAL loc_oErro, loc_cFundo, loc_nI, loc_oPg
297:         TRY
298:             loc_cFundo = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
299: 
300:             THIS.AddObject("pgf_4c_Job", "PageFrame")
301:             WITH THIS.pgf_4c_Job
302:                 .Top        = 130
303:                 .Left       = -1
304:                 .Width      = 1005
305:                 .Height     = 473
306:                 .PageCount  = 6
307:                 .Tabs       = .T.
308:                 .Visible    = .T.
309: 
310:                 *-- Captions EXATOS do dump (Page<N>.Caption)
311:                 .Page1.Caption = "Briefing"
312:                 .Page2.Caption = "Briefing Continua" + CHR(231) + CHR(227) + "o"
313:                 .Page3.Caption = "Informa" + CHR(231) + CHR(245) + "es Gerais"
314:                 .Page4.Caption = "Informa" + CHR(231) + CHR(245) + "es Gerais Continua" + ;
315:                                  CHR(231) + CHR(227) + "o"
316:                 .Page5.Caption = "Controladoria / Fiscal"
317:                 .Page6.Caption = "Apresenta" + CHR(231) + CHR(227) + "o"
318: 
319:                 *-- Ordem das abas do legado: pgPagina6 vem na 3a posicao
320:                 .Page6.PageOrder = 3
321:             ENDWITH
322: 
323:             *-- Fonte/cores/fundo de cada Page (Page<N>.FontBold/FontName/
324:             *-- FontSize/BackColor/ForeColor/Picture do dump, iguais nas 6)
325:             FOR loc_nI = 1 TO THIS.pgf_4c_Job.PageCount
326:                 loc_oPg = EVALUATE("THIS.pgf_4c_Job.Page" + TRANSFORM(loc_nI))
327:                 WITH loc_oPg
328:                     .FontBold  = .T.
329:                     .FontName  = "Tahoma"
330:                     .FontSize  = 8
331:                     .BackColor = RGB(255, 255, 255)
332:                     .ForeColor = RGB(90, 90, 90)
333:                     *-- Sem guard IF FILE(): .Picture inexistente falha em
334:                     *-- SILENCIO (regra #25) e o guard so esconderia o
335:                     *-- problema. O arquivo foi conferido no acervo legado.
336:                     .Picture = loc_cFundo
337:                 ENDWITH
338:             ENDFOR
339:         CATCH TO loc_oErro
340:             MsgErro(loc_oErro.Message + CHR(13) + ;
341:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
342:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarPageFrame")
343:         ENDTRY
344:     ENDPROC
345: 
346:     *==========================================================================
347:     * ConfigurarAbaBriefing - Page1 ("Briefing") - campos Jb_001/002/017..023
348:     * (datas) e Jb_003..008/021..023 (texto). Posicoes EXATAS do dump
349:     * (tasks\task755\layout.json). Nomes conforme tasks\task755\mapeamento.json.
350:     *==========================================================================
351:     PROTECTED PROCEDURE ConfigurarAbaBriefing()
352:         LOCAL loc_oPag, loc_oErro
353:         TRY
354:             loc_oPag = THIS.pgf_4c_Job.Page1
355: 
356:             *-- Apresentacao (data) + Orcamento (data)
357:             loc_oPag.AddObject("lbl_4c_Lbl_01_001", "Label")
358:             WITH loc_oPag.lbl_4c_Lbl_01_001
359:                 .Top = 7
360:                 .Left = 13
361:                 .Width = 90
362:                 .Height = 15
363:                 .Alignment = 0
364:                 .AutoSize = .F.
365:                 .BackStyle = 0
366:                 .ForeColor = RGB(90, 90, 90)
367:                 .FontName = "Tahoma"
368:                 .FontSize = 8
369:                 .Caption = "Apresenta" + CHR(231) + CHR(227) + "o"
370:             ENDWITH
371: 
372:             loc_oPag.AddObject("txt_4c__01_001", "TextBox")
373:             WITH loc_oPag.txt_4c__01_001
374:                 .Top = 22
375:                 .Left = 13
376:                 .Width = 90
377:                 .Height = 23
378:                 .Value = {}
379:             ENDWITH
380: 
381:             loc_oPag.AddObject("lbl_4c_Lbl_01_002", "Label")
382:             WITH loc_oPag.lbl_4c_Lbl_01_002
383:                 .Top = 7
384:                 .Left = 112
385:                 .Width = 90
386:                 .Height = 15
387:                 .Alignment = 0
388:                 .AutoSize = .F.
389:                 .BackStyle = 0
390:                 .ForeColor = RGB(90, 90, 90)
391:                 .FontName = "Tahoma"

*-- Linhas 593 a 733:
593:         CATCH TO loc_oErro
594:             MsgErro(loc_oErro.Message + CHR(13) + ;
595:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
596:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaBriefing")
597:         ENDTRY
598:     ENDPROC
599: 
600:     *==========================================================================
601:     * AdicionarBlocoMemoBriefing - Helper para o par Label+EditBox (482x90)
602:     * repetido 4 vezes em 2 colunas na Page1 (Briefing).
603:     *==========================================================================
604:     PROTECTED PROCEDURE AdicionarBlocoMemoBriefing(par_oPag, par_cNomeEdit, par_cNomeLbl, par_nTop, par_nLeft, par_cCaption)
605:         LOCAL loc_oLbl, loc_oEdt
606: 
607:         par_oPag.AddObject(par_cNomeLbl, "Label")
608:         loc_oLbl = EVALUATE("par_oPag." + par_cNomeLbl)
609:         WITH loc_oLbl
610:             .Top = par_nTop - 15
611:             .Left = par_nLeft
612:             .Width = 482
613:             .Height = 15
614:             .Alignment = 0
615:             .AutoSize = .F.
616:             .BackStyle = 0
617:             .ForeColor = RGB(90, 90, 90)
618:             .FontName = "Tahoma"
619:             .FontSize = 8
620:             .Caption = par_cCaption
621:         ENDWITH
622: 
623:         par_oPag.AddObject(par_cNomeEdit, "EditBox")
624:         loc_oEdt = EVALUATE("par_oPag." + par_cNomeEdit)
625:         WITH loc_oEdt
626:             .Top = par_nTop
627:             .Left = par_nLeft
628:             .Width = 482
629:             .Height = 90
630:             .ScrollBars = 2
631:             .Value = ""
632:         ENDWITH
633:     ENDPROC
634: 
635:     *==========================================================================
636:     * ConfigurarAbaDesafio - Page2 ("Desafio / Objetivos") - campos Jb_009..016,
637:     * todos memos de 482x90 em 2 colunas x 4 linhas (mesmo padrao da Page1).
638:     *==========================================================================
639:     PROTECTED PROCEDURE ConfigurarAbaDesafio()
640:         LOCAL loc_oPag, loc_oErro
641:         TRY
642:             loc_oPag = THIS.pgf_4c_Job.Page2
643: 
644:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_009", "lbl_4c_Lbl_01_009", ;
645:                 23, 13, "Desafio (o que queremos alcan" + CHR(231) + "ar, em " + CHR(250) + "ltima an" + CHR(225) + "lise, para o cliente)")
646:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_010", "lbl_4c_Lbl_01_010", ;
647:                 23, 505, "Objetivos (detalhamento dos objetivos)")
648:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_011", "lbl_4c_Lbl_01_011", ;
649:                 131, 13, "Tom de voz (como " + CHR(233) + " a linguagem que deve ser passada)")
650:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_012", "lbl_4c_Lbl_01_012", ;
651:                 131, 505, "Inspira" + CHR(231) + CHR(245) + "es (o que pode ser trabalhado relacionado ao objetivo e target)")
652:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_013", "lbl_4c_Lbl_01_013", ;
653:                 239, 13, "Cliente (expectativas, coment" + CHR(225) + "rios do cliente sobre o job em reuni" + CHR(227) + "o, fone e-mail)")
654:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_014", "lbl_4c_Lbl_01_014", ;
655:                 239, 505, "Sugest" + CHR(245) + "es / obrigatoriedades e/ou restri" + CHR(231) + CHR(245) + "es")
656:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_015", "lbl_4c_Lbl_01_015", ;
657:                 347, 13, "Comunica" + CHR(231) + CHR(227) + "o / pe" + CHR(231) + "as obrigat" + CHR(243) + "rias")
658:             THIS.AdicionarBlocoMemoBriefing(loc_oPag, "obj_4c_Get_01_016", "lbl_4c_Lbl_01_016", ;
659:                 347, 505, "Informa" + CHR(231) + CHR(245) + "es do local do evento (caracter" + CHR(237) + "sticas, restri" + CHR(231) + CHR(245) + "es de montagem, plantas)")
660:         CATCH TO loc_oErro
661:             MsgErro(loc_oErro.Message + CHR(13) + ;
662:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
663:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaDesafio")
664:         ENDTRY
665:     ENDPROC
666: 
667:     *==========================================================================
668:     * ConfigurarAbaEquipes - Page3, cuja aba se chama "Informacoes Gerais" no
669:     * legado (Page3.Caption do dump; o nome deste metodo descreve o CONTEUDO).
670:     * Traz os dois blocos de equipe do legado (cntEmp1 = "P&G" e
671:     * cntEmp2 = "SRCOM"), cada um com 7 linhas de Funcao / Nome / Codigo, mais
672:     * a faixa "Tipo de Projeto" / "Tipo de Desenvolvimento" abaixo da linha
673:     * divisoria.
674:     *
675:     * Posicoes/propriedades EXATAS do dump (SIGOPJOB.pgfPagina.pgPagina3.*).
676:     * Nomes conforme tasks\task755\mapeamento.json.
677:     *
678:     * Cada linha tem DOIS TextBox, como no legado:
679:     *   get_01_0NNa (Left=2, Width=355)  - NOME da conta, SEM ControlSource no
680:     *                                      SCX (preenchido por codigo a partir
681:     *                                      de SigCdCli.RClis - char(50))
682:     *   get_01_0NN  (Left=360, Width=80) - CODIGO, ControlSource
683:     *                                      "crSigMvJbC.Jb_0NN" (char(10))
684:     * O MaxLength vem da LARGURA DA COLUNA no schema (10 e 50), NUNCA do
685:     * Width em pixels (regra #19).
686:     *
687:     * A ordem de tabulacao do legado entra no NOME antes do CODIGO
688:     * (get_01_024a TabIndex=3, get_01_024 TabIndex=4) - transcrita.
689:     *
690:     * Os lookups (Valid/fwBuscaInt sobre crEquipes nos dois campos de cada
691:     * linha) sao da fase de lookups; aqui entra a superficie de dados.
692:     *==========================================================================
693:     PROTECTED PROCEDURE ConfigurarAbaEquipes()
694:         LOCAL loc_oPag, loc_oCnt, loc_oErro
695:         TRY
696:             loc_oPag = THIS.pgf_4c_Job.Page3
697: 
698:             *------------------------------------------------------------------
699:             * cntEmp1 - "P&G"
700:             *------------------------------------------------------------------
701:             loc_oPag.AddObject("cnt_4c_Emp1", "Container")
702:             WITH loc_oPag.cnt_4c_Emp1
703:                 .Top = 4
704:                 .Left = 23
705:                 .Width = 442
706:                 .Height = 305
707:                 .BackStyle = 0
708:                 .BorderWidth = 0
709:                 .SpecialEffect = 0
710:                 .Visible     = .T.
711:             ENDWITH
712:             loc_oCnt = loc_oPag.cnt_4c_Emp1
713: 
714:             loc_oCnt.AddObject("lbl_4c_Lbl_02_001", "Label")
715:             WITH loc_oCnt.lbl_4c_Lbl_02_001
716:                 .Top = 2
717:                 .Left = 2
718:                 .Width = 40
719:                 .Height = 15
720:                 .Alignment = 0
721:                 .AutoSize = .F.
722:                 .BackStyle = 0
723:                 .ForeColor = RGB(90, 90, 90)
724:                 .FontName = "Tahoma"
725:                 .FontSize = 8
726:                 .FontBold = .T.
727:                 .TabIndex = 1
728:                 .Caption = "P&G"
729:             ENDWITH
730: 
731:             *-- Atendimento
732:             loc_oCnt.AddObject("lbl_4c_Lbl_01_024", "Label")
733:             WITH loc_oCnt.lbl_4c_Lbl_01_024

*-- Linhas 1401 a 2008:
1401:             * No migrado os dois vao no LostFocus do respectivo campo (regra
1402:             * #47 - o handler nao testa tecla, logo nao pode ficar em
1403:             * KeyPress), ligados ao funil THIS.AbrirLookupConta por wrappers
1404:             * finos. O InteractiveChange do campo de codigo reavalia o When
1405:             * do campo de nome da mesma linha.
1406:             *------------------------------------------------------------------
1407:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024, "LostFocus", THIS, "ValidarConta024")
1408:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025, "LostFocus", THIS, "ValidarConta025")
1409:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026, "LostFocus", THIS, "ValidarConta026")
1410:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027, "LostFocus", THIS, "ValidarConta027")
1411:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028, "LostFocus", THIS, "ValidarConta028")
1412:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029, "LostFocus", THIS, "ValidarConta029")
1413:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030, "LostFocus", THIS, "ValidarConta030")
1414:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031, "LostFocus", THIS, "ValidarConta031")
1415:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032, "LostFocus", THIS, "ValidarConta032")
1416:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033, "LostFocus", THIS, "ValidarConta033")
1417:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034, "LostFocus", THIS, "ValidarConta034")
1418:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035, "LostFocus", THIS, "ValidarConta035")
1419:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036, "LostFocus", THIS, "ValidarConta036")
1420:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037, "LostFocus", THIS, "ValidarConta037")
1421: 
1422:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024a, "LostFocus", THIS, "ValidarNomeConta024")
1423:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025a, "LostFocus", THIS, "ValidarNomeConta025")
1424:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026a, "LostFocus", THIS, "ValidarNomeConta026")
1425:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027a, "LostFocus", THIS, "ValidarNomeConta027")
1426:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028a, "LostFocus", THIS, "ValidarNomeConta028")
1427:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029a, "LostFocus", THIS, "ValidarNomeConta029")
1428:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030a, "LostFocus", THIS, "ValidarNomeConta030")
1429:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031a, "LostFocus", THIS, "ValidarNomeConta031")
1430:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032a, "LostFocus", THIS, "ValidarNomeConta032")
1431:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033a, "LostFocus", THIS, "ValidarNomeConta033")
1432:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034a, "LostFocus", THIS, "ValidarNomeConta034")
1433:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035a, "LostFocus", THIS, "ValidarNomeConta035")
1434:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036a, "LostFocus", THIS, "ValidarNomeConta036")
1435:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037a, "LostFocus", THIS, "ValidarNomeConta037")
1436: 
1437:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_024, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1438:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_025, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1439:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_026, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1440:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_027, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1441:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_028, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1442:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_029, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1443:             BINDEVENT(loc_oPag.cnt_4c_Emp1.txt_4c__01_030, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1444:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_031, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1445:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_032, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1446:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_033, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1447:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_034, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1448:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_035, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1449:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_036, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1450:             BINDEVENT(loc_oPag.cnt_4c_Emp2.txt_4c__01_037, "InteractiveChange", THIS, "ContaEquipeInteractiveChange")
1451:         CATCH TO loc_oErro
1452:             MsgErro(loc_oErro.Message + CHR(13) + ;
1453:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1454:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaEquipes")
1455:         ENDTRY
1456:     ENDPROC
1457: 
1458:     *==========================================================================
1459:     * ObterFiltroContaEquipe - Universo do lookup de conta de equipe.
1460:     *
1461:     * O legado NAO busca em SigCdCli inteiro: o Init monta o cursor crEquipes
1462:     * com
1463:     *     Select a.IClis, a.RClis
1464:     *       From SigCdCli a, SigCdGcr b
1465:     *      Where a.Grupos = b.Codigos And b.Coletors = 8   && Atendimento
1466:     * e TODO Locate/fwBuscaInt das 14 linhas roda sobre esse cursor. O filtro
1467:     * eh REGRA DE NEGOCIO (so contas do grupo "Atendimento" podem ocupar os
1468:     * papeis de equipe) e eh transcrito aqui como condicao do 9o parametro
1469:     * (par_cFiltro) do FormBuscaAuxiliar - que o aplica nos TRES caminhos
1470:     * dele: match exato, LIKE prefixo e fallback show-all.
1471:     *
1472:     * Vai como subconsulta (nao JOIN) porque par_cFiltro eh colado dentro de
1473:     * um WHERE sobre uma tabela unica. Colunas conferidas em docs/schema.sql:
1474:     * SigCdCli.grupos char(10), SigCdGcr.codigos char(10),
1475:     * SigCdGcr.coletors numeric(2,0).
1476:     *==========================================================================
1477:     PROTECTED FUNCTION ObterFiltroContaEquipe()
1478:         RETURN "Grupos IN (SELECT Codigos FROM SigCdGcr WHERE Coletors = 8)"
1479:     ENDFUNC
1480: 
1481:     *==========================================================================
1482:     * AbrirLookupConta - Nucleo do lookup de conta (equipe) usado pelas 14
1483:     * linhas da Page3, nos DOIS sentidos que o legado tem.
1484:     *
1485:     * Equivale ao Valid de cada get_01_0NN (campo de CODIGO, par_cCampo =
1486:     * "Iclis") e ao Valid de cada get_01_0NNa (campo de NOME, par_cCampo =
1487:     * "Rclis"): o legado faz Locate em crEquipes pelo campo correspondente e,
1488:     * sem match (Eof), abre fwBuscaInt sobre o MESMO campo. Aqui o papel do
1489:     * crEquipes + fwBuscaInt eh feito pelo FormBuscaAuxiliar canonico (regras
1490:     * #36/#37), que ja executa o match EXATO no proprio Init - por isso NAO se
1491:     * duplica a checagem de existencia com um SQLEXEC proprio antes do picker.
1492:     *
1493:     * Os DOIS campos da linha sao escritos em qualquer um dos caminhos, como
1494:     * no legado (get_01_0NN.Value e get_01_0NNa.Value sao atribuidos juntos),
1495:     * e os dois sao limpos quando nada eh escolhido - transcricao do
1496:     * "If (Lastkey() <> 27) ... Else ... = [] / = [] / EndIf". Nao ha MsgAviso
1497:     * em nenhum ramo: o picker eh o proprio feedback (regra #50).
1498:     *
1499:     * Campo VAZIO nao abre picker: o legado abriria (Padr([],10) nunca casa em
1500:     * crEquipes), mas isso faz o dialogo subir a cada Tab por cada um dos 14
1501:     * papeis nao preenchidos. Mantido o guard de vazio, que eh o padrao do
1502:     * projeto para lookup em LostFocus (regras #47/#50) e ja era o
1503:     * comportamento desta tela.
1504:     *
1505:     * PUBLIC (BINDEVENT exige metodo publico - regra #3). Guarda de
1506:     * reentrancia: o picker eh MODAL, tira o foco do TextBox e redisparia o
1507:     * proprio LostFocus. Save/restore (nao set/clear) porque os wrappers de
1508:     * codigo e de nome compartilham este funil e o restore nao pode liberar a
1509:     * flag cedo demais caso um dia se encadeiem (regra #47).
1510:     *==========================================================================
1511:     PROCEDURE AbrirLookupConta(par_oTxtCod, par_oTxtNome, par_cCampo)
1512:         LOCAL loc_cValor, loc_cCampo, loc_oBusca, loc_lEmLookupAnt, loc_oErro
1513: 
1514:         IF THIS.this_lEmLookupConta
1515:             RETURN
1516:         ENDIF
1517:         IF VARTYPE(par_oTxtCod) != "O" OR VARTYPE(par_oTxtNome) != "O"
1518:             RETURN
1519:         ENDIF
1520: 
1521:         loc_cCampo = IIF(VARTYPE(par_cCampo) = "C" AND !EMPTY(par_cCampo), ;
1522:                          ALLTRIM(par_cCampo), "Iclis")
1523: 
1524:         loc_lEmLookupAnt         = THIS.this_lEmLookupConta
1525:         THIS.this_lEmLookupConta = .T.
1526:         TRY
1527:             *-- O valor pesquisado eh o do campo em que o usuario digitou:
1528:             *-- codigo quando o lookup partiu de get_01_0NN, nome quando
1529:             *-- partiu de get_01_0NNa.
1530:             IF UPPER(loc_cCampo) == "RCLIS"
1531:                 loc_cValor = ALLTRIM(par_oTxtNome.Value)
1532:             ELSE
1533:                 loc_cValor = ALLTRIM(par_oTxtCod.Value)
1534:             ENDIF
1535: 
1536:             IF EMPTY(loc_cValor)
1537:                 *-- Campo de origem vazio: nada a resolver. Limpa so o PAR
1538:                 *-- (codigo vazio nao pode ficar com nome preenchido, e nome
1539:                 *-- vazio com codigo preenchido eh resolvido pelo lookup de
1540:                 *-- codigo), sem abrir dialogo.
1541:                 IF UPPER(loc_cCampo) == "RCLIS"
1542:                     IF EMPTY(ALLTRIM(par_oTxtCod.Value))
1543:                         par_oTxtNome.Value = ""
1544:                     ENDIF
1545:                 ELSE
1546:                     par_oTxtNome.Value = ""
1547:                 ENDIF
1548:             ELSE
1549:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1550:                     "SigCdCli", "cursor_4c_BuscaConta", loc_cCampo, loc_cValor, ;
1551:                     "Sele" + CHR(231) + CHR(227) + "o de Filtros", .F., .T., ;
1552:                     THIS.ObterFiltroContaEquipe())
1553: 
1554:                 IF VARTYPE(loc_oBusca) = "O"
1555:                     IF !loc_oBusca.this_lAchouRegistro
1556:                         *-- Ordem das colunas igual a do legado: o campo
1557:                         *-- pesquisado vem primeiro em cada um dos dois Valid.
1558:                         IF UPPER(loc_cCampo) == "RCLIS"
1559:                             loc_oBusca.mAddColuna("Rclis", "", "Nome")
1560:                             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1561:                         ELSE
1562:                             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
1563:                             loc_oBusca.mAddColuna("Rclis", "", "Nome")
1564:                         ENDIF
1565:                         loc_oBusca.Show()
1566:                     ENDIF
1567: 
1568:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1569:                         SELECT cursor_4c_BuscaConta
1570:                         par_oTxtCod.Value  = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Iclis, ""))
1571:                         par_oTxtNome.Value = ALLTRIM(TratarNulo(cursor_4c_BuscaConta.Rclis, ""))
1572:                     ELSE
1573:                         *-- Legado: ESC / nada escolhido limpa os DOIS campos
1574:                         *-- da linha, nao so a descricao.
1575:                         par_oTxtCod.Value  = ""
1576:                         par_oTxtNome.Value = ""
1577:                     ENDIF
1578: 
1579:                     IF USED("cursor_4c_BuscaConta")
1580:                         USE IN cursor_4c_BuscaConta
1581:                     ENDIF
1582:                     loc_oBusca.Release()
1583:                 ENDIF
1584:             ENDIF
1585: 
1586:             *-- Legado fecha os dois Valid com ".Refresh" nos dois campos.
1587:             par_oTxtCod.Refresh()
1588:             par_oTxtNome.Refresh()
1589: 
1590:             *-- Reaplica o When de get_01_0NNa, que depende do codigo recem
1591:             *-- resolvido ("Empty(This.Parent.get_01_0NN.Value) And ...").
1592:             THIS.AtualizarEstadoContasEquipe()
1593:         CATCH TO loc_oErro
1594:             MsgErro(loc_oErro.Message + CHR(13) + ;
1595:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1596:                     "Procedure: " + loc_oErro.Procedure, "Erro em AbrirLookupConta")
1597:         ENDTRY
1598:         THIS.this_lEmLookupConta = loc_lEmLookupAnt
1599:     ENDPROC
1600: 
1601:     *==========================================================================
1602:     * AtualizarEstadoContasEquipe - Reproduz o "PROCEDURE When" dos 14 campos
1603:     * de NOME da Page3:
1604:     *     Return Empty(This.Parent.get_01_0NN.Value) And
1605:     *            InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])
1606:     * ou seja: o nome so aceita digitacao enquanto o codigo da MESMA linha
1607:     * esta vazio (resolvido o codigo, a descricao passa a ser so exibicao).
1608:     *
1609:     * Vive num metodo PUBLIC unico chamado pelo funil do lookup, pelo
1610:     * BOParaForm e por BINDEVENT InteractiveChange dos campos de codigo
1611:     * (regra #45.3) - BINDEVENT em "When" nao serve porque o retorno do
1612:     * delegate eh descartado e nao bloquearia a edicao.
1613:     *==========================================================================
1614:     PROCEDURE AtualizarEstadoContasEquipe()
1615:         LOCAL loc_oCnt1, loc_oCnt2, loc_lModoEdicao, loc_oErro
1616: 
1617:         TRY
1618:             loc_oCnt1       = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
1619:             loc_oCnt2       = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
1620:             loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1621: 
1622:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_024, loc_oCnt1.txt_4c__01_024a, loc_lModoEdicao)
1623:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_025, loc_oCnt1.txt_4c__01_025a, loc_lModoEdicao)
1624:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_026, loc_oCnt1.txt_4c__01_026a, loc_lModoEdicao)
1625:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_027, loc_oCnt1.txt_4c__01_027a, loc_lModoEdicao)
1626:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_028, loc_oCnt1.txt_4c__01_028a, loc_lModoEdicao)
1627:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_029, loc_oCnt1.txt_4c__01_029a, loc_lModoEdicao)
1628:             THIS.AjustarNomeContaEquipe(loc_oCnt1.txt_4c__01_030, loc_oCnt1.txt_4c__01_030a, loc_lModoEdicao)
1629: 
1630:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_031, loc_oCnt2.txt_4c__01_031a, loc_lModoEdicao)
1631:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_032, loc_oCnt2.txt_4c__01_032a, loc_lModoEdicao)
1632:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_033, loc_oCnt2.txt_4c__01_033a, loc_lModoEdicao)
1633:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_034, loc_oCnt2.txt_4c__01_034a, loc_lModoEdicao)
1634:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_035, loc_oCnt2.txt_4c__01_035a, loc_lModoEdicao)
1635:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_036, loc_oCnt2.txt_4c__01_036a, loc_lModoEdicao)
1636:             THIS.AjustarNomeContaEquipe(loc_oCnt2.txt_4c__01_037, loc_oCnt2.txt_4c__01_037a, loc_lModoEdicao)
1637:         CATCH TO loc_oErro
1638:             MsgErro(loc_oErro.Message + CHR(13) + ;
1639:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1640:                     "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarEstadoContasEquipe")
1641:         ENDTRY
1642:     ENDPROC
1643: 
1644:     *==========================================================================
1645:     * AjustarNomeContaEquipe - Aplica a UMA linha o When do campo de nome.
1646:     *
1647:     * O campo de CODIGO (get_01_0NN) NAO recebe tratamento: no dump o legado
1648:     * declara nele apenas Valid e LostFocus - nao ha When - logo ele eh
1649:     * sempre editavel, inclusive em VISUALIZAR. Desabilitar por modo seria
1650:     * inventar comportamento que o legado nao tem (PILAR 1).
1651:     *
1652:     * IFs aninhados em vez de AND encadeado porque VFP9 nao faz
1653:     * short-circuit: ALLTRIM teria de ser avaliado mesmo com o modo fora de
1654:     * edicao.
1655:     *==========================================================================
1656:     PROTECTED PROCEDURE AjustarNomeContaEquipe(par_oTxtCod, par_oTxtNome, par_lModoEdicao)
1657:         LOCAL loc_lHabilitaNome
1658:         loc_lHabilitaNome = .F.
1659: 
1660:         IF par_lModoEdicao
1661:             IF EMPTY(ALLTRIM(par_oTxtCod.Value))
1662:                 loc_lHabilitaNome = .T.
1663:             ENDIF
1664:         ENDIF
1665: 
1666:         *-- So atribui quando MUDA: este metodo roda tambem de dentro do
1667:         *-- LostFocus do proprio campo de nome (via AbrirLookupConta), e
1668:         *-- mexer em Enabled no meio de uma transicao de foco sem necessidade
1669:         *-- eh a forma mais facil de criar efeito colateral de foco.
1670:         IF par_oTxtNome.Enabled != loc_lHabilitaNome
1671:             par_oTxtNome.Enabled = loc_lHabilitaNome
1672:         ENDIF
1673:     ENDPROC
1674: 
1675:     *==========================================================================
1676:     * ValidarContaLinha - Funil COMUM dos wrappers ValidarConta0NN/
1677:     * ValidarNomeConta0NN: aplica o guard de "valor nao mudou" (regra #47 -
1678:     * LostFocus dispara SEMPRE que o foco sai do campo, mas o Valid do
1679:     * legado de get_01_0NN/get_01_0NNa so dispara quando o valor MUDA) antes
1680:     * de delegar a THIS.AbrirLookupConta.
1681:     *
1682:     * par_cPropGuarda identifica a property this_cUltimoValidarConta0NN-
1683:     * Validado da LINHA (compartilhada entre o wrapper de codigo e o de
1684:     * nome, como em FormSigOpIpE.ValidarOcorrenciaEtiqueta) - lida/escrita
1685:     * por EVALUATE/STORE...TO porque o nome vem em variavel (regra #15/#34).
1686:     *==========================================================================
1687:     PROCEDURE ValidarContaLinha(par_oTxtCod, par_oTxtNome, par_cCampo, par_cPropGuarda)
1688:         LOCAL loc_cValorAtual
1689: 
1690:         loc_cValorAtual = ALLTRIM(par_oTxtCod.Value) + "|" + ALLTRIM(par_oTxtNome.Value)
1691: 
1692:         IF loc_cValorAtual == EVALUATE("THIS." + par_cPropGuarda)
1693:             RETURN
1694:         ENDIF
1695: 
1696:         THIS.AbrirLookupConta(par_oTxtCod, par_oTxtNome, par_cCampo)
1697: 
1698:         STORE ALLTRIM(par_oTxtCod.Value) + "|" + ALLTRIM(par_oTxtNome.Value) ;
1699:             TO ("THIS." + par_cPropGuarda)
1700:     ENDPROC
1701: 
1702:     *==========================================================================
1703:     * ValidarConta024..037 - Wrappers finos de ValidarContaLinha para o campo
1704:     * de CODIGO de cada uma das 14 linhas de equipe (Page3, cnt_4c_Emp1 /
1705:     * cnt_4c_Emp2) - equivalem ao "PROCEDURE Valid" de get_01_0NN. PUBLIC
1706:     * (BINDEVENT exige - regra #3); sem parametros (LostFocus nao passa
1707:     * nenhum - regra #47).
1708:     *==========================================================================
1709:     PROCEDURE ValidarConta024()
1710:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024, ;
1711:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a, "Iclis", ;
1712:                               "this_cUltimoValidarConta024Validado")
1713:     ENDPROC
1714: 
1715:     PROCEDURE ValidarConta025()
1716:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025, ;
1717:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a, "Iclis", ;
1718:                               "this_cUltimoValidarConta025Validado")
1719:     ENDPROC
1720: 
1721:     PROCEDURE ValidarConta026()
1722:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026, ;
1723:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a, "Iclis", ;
1724:                               "this_cUltimoValidarConta026Validado")
1725:     ENDPROC
1726: 
1727:     PROCEDURE ValidarConta027()
1728:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027, ;
1729:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027a, "Iclis", ;
1730:                               "this_cUltimoValidarConta027Validado")
1731:     ENDPROC
1732: 
1733:     PROCEDURE ValidarConta028()
1734:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028, ;
1735:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028a, "Iclis", ;
1736:                               "this_cUltimoValidarConta028Validado")
1737:     ENDPROC
1738: 
1739:     PROCEDURE ValidarConta029()
1740:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029, ;
1741:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029a, "Iclis", ;
1742:                               "this_cUltimoValidarConta029Validado")
1743:     ENDPROC
1744: 
1745:     PROCEDURE ValidarConta030()
1746:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030, ;
1747:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030a, "Iclis", ;
1748:                               "this_cUltimoValidarConta030Validado")
1749:     ENDPROC
1750: 
1751:     PROCEDURE ValidarConta031()
1752:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031, ;
1753:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031a, "Iclis", ;
1754:                               "this_cUltimoValidarConta031Validado")
1755:     ENDPROC
1756: 
1757:     PROCEDURE ValidarConta032()
1758:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032, ;
1759:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032a, "Iclis", ;
1760:                               "this_cUltimoValidarConta032Validado")
1761:     ENDPROC
1762: 
1763:     PROCEDURE ValidarConta033()
1764:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033, ;
1765:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033a, "Iclis", ;
1766:                               "this_cUltimoValidarConta033Validado")
1767:     ENDPROC
1768: 
1769:     PROCEDURE ValidarConta034()
1770:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034, ;
1771:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034a, "Iclis", ;
1772:                               "this_cUltimoValidarConta034Validado")
1773:     ENDPROC
1774: 
1775:     PROCEDURE ValidarConta035()
1776:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035, ;
1777:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035a, "Iclis", ;
1778:                               "this_cUltimoValidarConta035Validado")
1779:     ENDPROC
1780: 
1781:     PROCEDURE ValidarConta036()
1782:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036, ;
1783:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036a, "Iclis", ;
1784:                               "this_cUltimoValidarConta036Validado")
1785:     ENDPROC
1786: 
1787:     PROCEDURE ValidarConta037()
1788:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037, ;
1789:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037a, "Iclis", ;
1790:                               "this_cUltimoValidarConta037Validado")
1791:     ENDPROC
1792: 
1793:     *==========================================================================
1794:     * ValidarNomeConta024..037 - Wrappers finos de ValidarContaLinha para o
1795:     * campo de NOME de cada linha de equipe - equivalem ao "PROCEDURE Valid"
1796:     * de get_01_0NNa, que faz "Locate For RClis = Padr(This.Value, 50)" e,
1797:     * sem match, abre fwBuscaInt sobre RClis. Era a METADE do lookup de cada
1798:     * linha que faltava: sem eles o usuario que digitasse o NOME da conta nao
1799:     * tinha como resolver o codigo. Compartilha o MESMO guard de "valor nao
1800:     * mudou" do wrapper de codigo da mesma linha (par_cPropGuarda identico).
1801:     *==========================================================================
1802:     PROCEDURE ValidarNomeConta024()
1803:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024, ;
1804:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_024a, "Rclis", ;
1805:                               "this_cUltimoValidarConta024Validado")
1806:     ENDPROC
1807: 
1808:     PROCEDURE ValidarNomeConta025()
1809:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025, ;
1810:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_025a, "Rclis", ;
1811:                               "this_cUltimoValidarConta025Validado")
1812:     ENDPROC
1813: 
1814:     PROCEDURE ValidarNomeConta026()
1815:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026, ;
1816:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_026a, "Rclis", ;
1817:                               "this_cUltimoValidarConta026Validado")
1818:     ENDPROC
1819: 
1820:     PROCEDURE ValidarNomeConta027()
1821:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027, ;
1822:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_027a, "Rclis", ;
1823:                               "this_cUltimoValidarConta027Validado")
1824:     ENDPROC
1825: 
1826:     PROCEDURE ValidarNomeConta028()
1827:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028, ;
1828:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_028a, "Rclis", ;
1829:                               "this_cUltimoValidarConta028Validado")
1830:     ENDPROC
1831: 
1832:     PROCEDURE ValidarNomeConta029()
1833:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029, ;
1834:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_029a, "Rclis", ;
1835:                               "this_cUltimoValidarConta029Validado")
1836:     ENDPROC
1837: 
1838:     PROCEDURE ValidarNomeConta030()
1839:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030, ;
1840:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.txt_4c__01_030a, "Rclis", ;
1841:                               "this_cUltimoValidarConta030Validado")
1842:     ENDPROC
1843: 
1844:     PROCEDURE ValidarNomeConta031()
1845:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031, ;
1846:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_031a, "Rclis", ;
1847:                               "this_cUltimoValidarConta031Validado")
1848:     ENDPROC
1849: 
1850:     PROCEDURE ValidarNomeConta032()
1851:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032, ;
1852:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_032a, "Rclis", ;
1853:                               "this_cUltimoValidarConta032Validado")
1854:     ENDPROC
1855: 
1856:     PROCEDURE ValidarNomeConta033()
1857:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033, ;
1858:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_033a, "Rclis", ;
1859:                               "this_cUltimoValidarConta033Validado")
1860:     ENDPROC
1861: 
1862:     PROCEDURE ValidarNomeConta034()
1863:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034, ;
1864:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_034a, "Rclis", ;
1865:                               "this_cUltimoValidarConta034Validado")
1866:     ENDPROC
1867: 
1868:     PROCEDURE ValidarNomeConta035()
1869:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035, ;
1870:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_035a, "Rclis", ;
1871:                               "this_cUltimoValidarConta035Validado")
1872:     ENDPROC
1873: 
1874:     PROCEDURE ValidarNomeConta036()
1875:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036, ;
1876:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_036a, "Rclis", ;
1877:                               "this_cUltimoValidarConta036Validado")
1878:     ENDPROC
1879: 
1880:     PROCEDURE ValidarNomeConta037()
1881:         THIS.ValidarContaLinha(THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037, ;
1882:                               THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.txt_4c__01_037a, "Rclis", ;
1883:                               "this_cUltimoValidarConta037Validado")
1884:     ENDPROC
1885: 
1886:     *==========================================================================
1887:     * ContaEquipeInteractiveChange - Reavalia o When dos campos de nome a cada
1888:     * tecla digitada no campo de codigo (o legado reavalia o When em cada
1889:     * refresh do container). Ligado por BINDEVENT nos 14 campos de codigo.
1890:     *==========================================================================
1891:     PROCEDURE ContaEquipeInteractiveChange()
1892:         THIS.AtualizarEstadoContasEquipe()
1893:     ENDPROC
1894: 
1895:     *==========================================================================
1896:     * ConfigurarTiposProjeto - Blocos "Tipo de Projeto" (Jb_038..041) e "Tipo
1897:     * de Desenvolvimento" (Jb_042..044) da Page3, abaixo da linha divisoria.
1898:     * Sao CheckBoxes independentes no legado (nao OptionGroup): o SCX declara
1899:     * sete checkbox separados, cada um com ControlSource proprio em coluna
1900:     * numeric(1,0) de SigMvJbC - mais de um pode ficar marcado.
1901:     * Posicoes EXATAS do dump.
1902:     *==========================================================================
1903:     PROTECTED PROCEDURE ConfigurarTiposProjeto(par_oPag)
1904:         *-- Tipo de Projeto (coluna da esquerda)
1905:         THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_003", 326, 26, 100, ;
1906:             "Tipo de Projeto", 45)
1907:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_038", "lbl_4c_Lbl_01_038", ;
1908:             350, 26, 44, 110, "Pedido do Cliente", 46, 47)
1909:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_039", "lbl_4c_Lbl_01_039", ;
1910:             369, 26, 44, 85, "Concorr" + CHR(234) + "ncia", 48, 49)
1911:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_040", "lbl_4c_Lbl_01_040", ;
1912:             389, 26, 44, 70, "Licita" + CHR(231) + CHR(227) + "o", 50, 51)
1913:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_041", "lbl_4c_Lbl_01_041", ;
1914:             408, 26, 44, 85, "Propriet" + CHR(225) + "rio", 52, 53)
1915: 
1916:         *-- Tipo de Desenvolvimento (coluna da direita)
1917:         THIS.AdicionarRotuloSecao(par_oPag, "lbl_4c_Lbl_02_004", 326, 208, 150, ;
1918:             "Tipo de Desenvolvimento", 54)
1919:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_042", "lbl_4c_Lbl_01_042", ;
1920:             350, 208, 226, 135, "Desenvolvimento Total", 55, 56)
1921:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_043", "lbl_4c_Lbl_01_043", ;
1922:             369, 208, 226, 65, "Produ" + CHR(231) + CHR(227) + "o", 57, 58)
1923:         THIS.AdicionarCheckBoxRotulado(par_oPag, "chk_4c_Get_01_044", "lbl_4c_Lbl_01_044", ;
1924:             389, 208, 226, 60, "Cria" + CHR(231) + CHR(227) + "o", 59, 60)
1925:     ENDPROC
1926: 
1927:     *==========================================================================
1928:     * AdicionarRotuloSecao - Label de titulo de bloco (os "lbl_02_NNN" do
1929:     * legado: FontBold = .T., sem Width/Alignment no dump - ver regra #23).
1930:     *==========================================================================
1931:     PROTECTED PROCEDURE AdicionarRotuloSecao(par_oPai, par_cNome, par_nTop, par_nLeft, ;
1932:                                              par_nWidth, par_cCaption, par_nTabIndex)
1933:         LOCAL loc_oLbl
1934: 
1935:         par_oPai.AddObject(par_cNome, "Label")
1936:         loc_oLbl = EVALUATE("par_oPai." + par_cNome)
1937:         WITH loc_oLbl
1938:             .Top = par_nTop
1939:             .Left = par_nLeft
1940:             .Width = par_nWidth
1941:             .Height = 15
1942:             .Alignment = 0
1943:             .AutoSize = .F.
1944:             .BackStyle = 0
1945:             .ForeColor = RGB(90, 90, 90)
1946:             .FontName = "Tahoma"
1947:             .FontSize = 8
1948:             .FontBold = .T.
1949:             .TabIndex = par_nTabIndex
1950:             .Caption = par_cCaption
1951:         ENDWITH
1952:     ENDPROC
1953: 
1954:     *==========================================================================
1955:     * AdicionarCheckBoxRotulado - Par CheckBox (Caption vazio) + Label ao lado,
1956:     * padrao repetido no SCX legado nas Pages 3, 5 e 6.
1957:     *
1958:     * O CheckBox do legado tem Caption = "" e o texto vem num Label separado,
1959:     * entao a caixa recebe Width/Height EXPLICITOS (16x17): AutoSize eh no-op
1960:     * em CheckBox criado por AddObject e a caixa ficaria nos 100x17 do default,
1961:     * cobrindo o Label ao lado. O Label vem DEPOIS da caixa, como no dump
1962:     * (TabIndex do Label eh o maior do par), e a caixa termina antes do Left
1963:     * do Label (26+16=42 < 44), sem sobreposicao.
1964:     *
1965:     * .Value = 0 NUMERICO (nunca .F.): as colunas Jb_0NN sao numeric(1,0) e
1966:     * misturar logico com numerico dispara "Operator/operand type mismatch".
1967:     *==========================================================================
1968:     PROTECTED PROCEDURE AdicionarCheckBoxRotulado(par_oPai, par_cNomeChk, par_cNomeLbl, ;
1969:                                                   par_nTop, par_nLeftChk, par_nLeftLbl, ;
1970:                                                   par_nWidthLbl, par_cCaption, ;
1971:                                                   par_nTabChk, par_nTabLbl)
1972:         LOCAL loc_oChk, loc_oLbl
1973: 
1974:         par_oPai.AddObject(par_cNomeChk, "CheckBox")
1975:         loc_oChk = EVALUATE("par_oPai." + par_cNomeChk)
1976:         WITH loc_oChk
1977:             .Top = par_nTop
1978:             .Left = par_nLeftChk
1979:             .Width = 16
1980:             .Height = 17
1981:             .Alignment = 0
1982:             .AutoSize = .F.
1983:             .BackStyle = 0
1984:             .SpecialEffect = 1
1985:             .TabIndex = par_nTabChk
1986:             .Caption = ""
1987:             .Value = 0
1988:         ENDWITH
1989: 
1990:         par_oPai.AddObject(par_cNomeLbl, "Label")
1991:         loc_oLbl = EVALUATE("par_oPai." + par_cNomeLbl)
1992:         WITH loc_oLbl
1993:             .Top = par_nTop
1994:             .Left = par_nLeftLbl
1995:             .Width = par_nWidthLbl
1996:             .Height = 15
1997:             .Alignment = 0
1998:             .AutoSize = .F.
1999:             .BackStyle = 0
2000:             .ForeColor = RGB(90, 90, 90)
2001:             .FontName = "Tahoma"
2002:             .FontSize = 8
2003:             .TabIndex = par_nTabLbl
2004:             .Caption = par_cCaption
2005:         ENDWITH
2006:     ENDPROC
2007: 
2008:     *==========================================================================

*-- Linhas 2017 a 2060:
2017:     * a regra #25 (icone so do dump confirmado). Os botoes usam Caption
2018:     * textual ("..." / "Abrir") em vez de icone.
2019:     *==========================================================================
2020:     PROTECTED PROCEDURE ConfigurarAbaMateriais()
2021:         LOCAL loc_oPag, loc_oErro
2022:         TRY
2023:             loc_oPag = THIS.pgf_4c_Job.Page4
2024: 
2025:             loc_oPag.AddObject("lbl_4c_Lbl_02_008", "Label")
2026:             WITH loc_oPag.lbl_4c_Lbl_02_008
2027:                 .Top = 14
2028:                 .Left = 13
2029:                 .Width = 150
2030:                 .Height = 15
2031:                 .Alignment = 0
2032:                 .AutoSize = .F.
2033:                 .BackStyle = 0
2034:                 .ForeColor = RGB(90, 90, 90)
2035:                 .FontName = "Tahoma"
2036:                 .FontSize = 8
2037:                 .FontBold = .T.
2038:                 .Caption = "Infos Clientes"
2039:             ENDWITH
2040: 
2041:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_045", "lbl_4c_Lbl_01_045", ;
2042:                 "cmd_4c_Btn_01_045", "cmd_4c_Btn_01_045b", 33, 48, "Logomarca", ;
2043:                 "Btn045Click", "Btn045bClick")
2044:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_046", "lbl_4c_Lbl_01_046", ;
2045:                 "cmd_4c_Btn_01_046", "cmd_4c_Btn_01_046b", 77, 92, "Manual de Marca", ;
2046:                 "Btn046Click", "Btn046bClick")
2047:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_047", "lbl_4c_Lbl_01_047", ;
2048:                 "cmd_4c_Btn_01_047", "cmd_4c_Btn_01_047b", 121, 136, "Imagens", ;
2049:                 "Btn047Click", "Btn047bClick")
2050:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_048", "lbl_4c_Lbl_01_048", ;
2051:                 "cmd_4c_Btn_01_048", "cmd_4c_Btn_01_048b", 165, 180, "Refer" + CHR(234) + "ncias", ;
2052:                 "Btn048Click", "Btn048bClick")
2053:             THIS.AdicionarCampoPastaMaterial(loc_oPag, "obj_4c_Get_01_061", "lbl_4c_Lbl_01_061", ;
2054:                 "cmd_4c_Btn_01_061", "cmd_4c_Btn_01_061b", 209, 224, ;
2055:                 "Atas, emails e correspond" + CHR(234) + "ncias de altera" + CHR(231) + CHR(245) + "es e aprova" + CHR(231) + CHR(227) + "o do cliente", ;
2056:                 "Btn061Click", "Btn061bClick")
2057: 
2058:             *-- Avaliacao do Job (memo largo, Jb_058)
2059:             loc_oPag.AddObject("lbl_4c_Lbl_01_058", "Label")
2060:             WITH loc_oPag.lbl_4c_Lbl_01_058

*-- Linhas 2083 a 2275:
2083:         CATCH TO loc_oErro
2084:             MsgErro(loc_oErro.Message + CHR(13) + ;
2085:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2086:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaMateriais")
2087:         ENDTRY
2088:     ENDPROC
2089: 
2090:     *==========================================================================
2091:     * AdicionarCampoPastaMaterial - Helper para o padrao repetido 5x na Page4:
2092:     * Label + EditBox (caminho) + botao "Escolher" (GetDir) + botao "Abrir"
2093:     * (Shell.Application), nas posicoes EXATAS do dump (Top do label eh
2094:     * par_nTopLbl, Top do campo/botoes eh par_nTopCampo - a mesma relacao de
2095:     * -15/-9 vista nas 5 linhas do SCX).
2096:     *==========================================================================
2097:     PROTECTED PROCEDURE AdicionarCampoPastaMaterial(par_oPag, par_cNomeEdit, par_cNomeLbl, ;
2098:             par_cNomeBtn, par_cNomeBtnB, par_nTopLbl, par_nTopCampo, par_cCaption, ;
2099:             par_cHandlerBtn, par_cHandlerBtnB)
2100:         LOCAL loc_oLbl, loc_oEdt, loc_oBtn, loc_oBtnB
2101: 
2102:         par_oPag.AddObject(par_cNomeLbl, "Label")
2103:         loc_oLbl = EVALUATE("par_oPag." + par_cNomeLbl)
2104:         WITH loc_oLbl
2105:             .Top = par_nTopLbl
2106:             .Left = 13
2107:             .Width = 888
2108:             .Height = 15
2109:             .Alignment = 0
2110:             .AutoSize = .F.
2111:             .BackStyle = 0
2112:             .ForeColor = RGB(90, 90, 90)
2113:             .FontName = "Tahoma"
2114:             .FontSize = 8
2115:             .Caption = par_cCaption
2116:         ENDWITH
2117: 
2118:         par_oPag.AddObject(par_cNomeEdit, "EditBox")
2119:         loc_oEdt = EVALUATE("par_oPag." + par_cNomeEdit)
2120:         WITH loc_oEdt
2121:             .Top = par_nTopCampo
2122:             .Left = 13
2123:             .Width = 888
2124:             .Height = 23
2125:             .ScrollBars = 0
2126:             .Value = ""
2127:             *-- Legado: "PROCEDURE When / Return .f." - o campo NUNCA recebe
2128:             *-- foco por digitacao, em modo algum; o valor so muda pelos
2129:             *-- botoes "..."/"Abrir" (EscolherPasta/AbrirPasta).
2130:             .ReadOnly = .T.
2131:         ENDWITH
2132: 
2133:         par_oPag.AddObject(par_cNomeBtn, "CommandButton")
2134:         loc_oBtn = EVALUATE("par_oPag." + par_cNomeBtn)
2135:         WITH loc_oBtn
2136:             .Top = par_nTopCampo - 9
2137:             .Left = 905
2138:             .Width = 40
2139:             .Height = 32
2140:             .FontName = "Tahoma"
2141:             .FontSize = 8
2142:             .Caption = "..."
2143:             .ToolTipText = "Selecionar Diret" + CHR(243) + "rio, Pasta ou Caminho de Rede"
2144:         ENDWITH
2145:         BINDEVENT(loc_oBtn, "Click", THIS, par_cHandlerBtn)
2146: 
2147:         par_oPag.AddObject(par_cNomeBtnB, "CommandButton")
2148:         loc_oBtnB = EVALUATE("par_oPag." + par_cNomeBtnB)
2149:         WITH loc_oBtnB
2150:             .Top = par_nTopCampo - 9
2151:             .Left = 947
2152:             .Width = 40
2153:             .Height = 32
2154:             .FontName = "Tahoma"
2155:             .FontSize = 8
2156:             .Caption = "Abrir"
2157:             .ToolTipText = "Abrir no Explorer"
2158:         ENDWITH
2159:         BINDEVENT(loc_oBtnB, "Click", THIS, par_cHandlerBtnB)
2160:     ENDPROC
2161: 
2162:     *==========================================================================
2163:     * EscolherPasta/AbrirPasta - Nucleo dos 10 botoes "..."/"Abrir" da Page4
2164:     * (legado: btn_01_0NN.Click - GetDir + Alltrim; btn_01_0NNb.Click -
2165:     * Shell.Application.Open). PUBLIC (chamados pelos wrappers via THIS.).
2166:     *==========================================================================
2167:     PROCEDURE EscolherPasta(par_oTxt)
2168:         LOCAL loc_cDir
2169:         loc_cDir = GETDIR("", "Selecione o Diret" + CHR(243) + "rio, Pasta ou Caminho de Rede", ;
2170:             "Sele" + CHR(231) + CHR(227) + "o de Diret" + CHR(243) + "rios")
2171: 
2172:         IF !EMPTY(loc_cDir)
2173:             par_oTxt.Value = ALLTRIM(loc_cDir)
2174:         ELSE
2175:             par_oTxt.Value = ""
2176:         ENDIF
2177:         par_oTxt.Refresh()
2178:     ENDPROC
2179: 
2180:     PROCEDURE AbrirPasta(par_oTxt)
2181:         LOCAL loc_cDir, loc_oApp, loc_oErro
2182:         TRY
2183:             loc_cDir = ALLTRIM(par_oTxt.Value)
2184:             IF !EMPTY(loc_cDir)
2185:                 loc_oApp = CREATEOBJECT("Shell.Application")
2186:                 loc_oApp.Open(loc_cDir)
2187:             ENDIF
2188:         CATCH TO loc_oErro
2189:             MsgErro(loc_oErro.Message, "Erro ao abrir pasta")
2190:         ENDTRY
2191:     ENDPROC
2192: 
2193:     *==========================================================================
2194:     * Btn045Click..Btn061bClick - Wrappers finos de EscolherPasta/AbrirPasta
2195:     * para cada um dos 5 campos de caminho da Page4. PUBLIC (BINDEVENT exige).
2196:     *==========================================================================
2197:     PROCEDURE Btn045Click()
2198:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045)
2199:     ENDPROC
2200:     PROCEDURE Btn045bClick()
2201:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_045)
2202:     ENDPROC
2203:     PROCEDURE Btn046Click()
2204:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046)
2205:     ENDPROC
2206:     PROCEDURE Btn046bClick()
2207:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_046)
2208:     ENDPROC
2209:     PROCEDURE Btn047Click()
2210:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047)
2211:     ENDPROC
2212:     PROCEDURE Btn047bClick()
2213:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_047)
2214:     ENDPROC
2215:     PROCEDURE Btn048Click()
2216:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048)
2217:     ENDPROC
2218:     PROCEDURE Btn048bClick()
2219:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_048)
2220:     ENDPROC
2221:     PROCEDURE Btn061Click()
2222:         THIS.EscolherPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061)
2223:     ENDPROC
2224:     PROCEDURE Btn061bClick()
2225:         THIS.AbrirPasta(THIS.pgf_4c_Job.Page4.obj_4c_Get_01_061)
2226:     ENDPROC
2227: 
2228:     *==========================================================================
2229:     * ConfigurarAbaFinanceiroCampos - Page5 ("Controladoria / Fiscal"),
2230:     * campos restantes alem da grade "Fontes Pagadoras" (ja criada por
2231:     * ConfigurarGridFontes): titulo de secao, 8 checkboxes (Jb_063..069,075),
2232:     * Codigo de Atividade (Jb_062), Outras Receitas (Jb_070) e Comentarios
2233:     * Financeiros (Jb_071). Posicoes EXATAS do dump.
2234:     *==========================================================================
2235:     PROTECTED PROCEDURE ConfigurarAbaFinanceiroCampos()
2236:         LOCAL loc_oPag, loc_oErro
2237:         TRY
2238:             loc_oPag = THIS.pgf_4c_Job.Page5
2239: 
2240:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_009", 21, 15, 330, ;
2241:                 "Modelo Fiscal / Considera" + CHR(231) + CHR(245) + "es Financeiras", 1)
2242: 
2243:             *-- Coluna da esquerda
2244:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_063", "lbl_4c_Lbl_01_063", ;
2245:                 45, 15, 33, 90, "NF de Servi" + CHR(231) + "o", 2, 3)
2246:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_064", "lbl_4c_Lbl_01_064", ;
2247:                 64, 15, 33, 90, "Nota de D" + CHR(233) + "bito", 4, 5)
2248:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_065", "lbl_4c_Lbl_01_065", ;
2249:                 84, 15, 33, 90, "NF de Loca" + CHR(231) + CHR(227) + "o", 6, 7)
2250:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_075", "lbl_4c_Lbl_01_075", ;
2251:                 103, 15, 33, 100, "Conta Corrente", 8, 9)
2252: 
2253:             *-- Coluna do meio
2254:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_066", "lbl_4c_Lbl_01_066", ;
2255:                 45, 174, 192, 100, "Incentivo ICMS", 10, 11)
2256:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_067", "lbl_4c_Lbl_01_067", ;
2257:                 64, 174, 192, 110, "Incentivo Rouanet", 12, 13)
2258:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_068", "lbl_4c_Lbl_01_068", ;
2259:                 84, 174, 192, 90, "Incentivo ISS", 14, 15)
2260:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_069", "lbl_4c_Lbl_01_069", ;
2261:                 103, 174, 192, 80, "Patroc" + CHR(237) + "nio", 16, 17)
2262: 
2263:             *-- Coluna da direita
2264:             loc_oPag.AddObject("lbl_4c_Lbl_01_062", "Label")
2265:             WITH loc_oPag.lbl_4c_Lbl_01_062
2266:                 .Top = 7
2267:                 .Left = 347
2268:                 .Width = 150
2269:                 .Height = 15
2270:                 .Alignment = 0
2271:                 .AutoSize = .F.
2272:                 .BackStyle = 0
2273:                 .ForeColor = RGB(90, 90, 90)
2274:                 .FontName = "Tahoma"
2275:                 .FontSize = 8

*-- Linhas 2341 a 2394:
2341:         CATCH TO loc_oErro
2342:             MsgErro(loc_oErro.Message + CHR(13) + ;
2343:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2344:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaFinanceiroCampos")
2345:         ENDTRY
2346:     ENDPROC
2347: 
2348:     *==========================================================================
2349:     * ConfigurarAbaApresentacao - Page6 ("Apresentacao" no dump): tipo de
2350:     * apresentacao (Jb_049/050), Proposta Comercial (Jb_051/052/053 + Jb_073
2351:     * "Outros"), Proposta Tecnica (Jb_054/055/056 + Jb_074 "Outros") e o memo
2352:     * largo "Documentos Necessarios" (Jb_057). Posicoes EXATAS do dump.
2353:     *==========================================================================
2354:     PROTECTED PROCEDURE ConfigurarAbaApresentacao()
2355:         LOCAL loc_oPag, loc_oErro
2356:         TRY
2357:             loc_oPag = THIS.pgf_4c_Job.Page6
2358: 
2359:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_005", 30, 16, 100, "Apresenta" + CHR(231) + CHR(227) + "o", 1)
2360:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_049", "lbl_4c_Lbl_01_049", ;
2361:                 54, 16, 34, 70, "Presencial", 2, 3)
2362:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_050", "lbl_4c_Lbl_01_050", ;
2363:                 73, 16, 34, 70, "Eletr" + CHR(244) + "nica", 4, 5)
2364: 
2365:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_006", 30, 233, 150, "Proposta Comercial", 6)
2366:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_051", "lbl_4c_Lbl_01_051", ;
2367:                 54, 233, 251, 65, "Impress" + CHR(227) + "o", 7, 8)
2368:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_052", "lbl_4c_Lbl_01_052", ;
2369:                 73, 233, 251, 30, "CD", 9, 10)
2370:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_053", "lbl_4c_Lbl_01_053", ;
2371:                 93, 233, 251, 50, "Outros", 11, 12)
2372:             loc_oPag.AddObject("obj_4c_Get_01_073", "EditBox")
2373:             WITH loc_oPag.obj_4c_Get_01_073
2374:                 .Top = 114
2375:                 .Left = 233
2376:                 .Width = 360
2377:                 .Height = 23
2378:                 .ScrollBars = 0
2379:                 .TabIndex = 13
2380:                 .Value = ""
2381:             ENDWITH
2382: 
2383:             THIS.AdicionarRotuloSecao(loc_oPag, "lbl_4c_Lbl_02_007", 30, 625, 150, "Proposta T" + CHR(233) + "cnica", 14)
2384:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_054", "lbl_4c_Lbl_01_054", ;
2385:                 54, 625, 643, 65, "Impress" + CHR(227) + "o", 15, 16)
2386:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_055", "lbl_4c_Lbl_01_055", ;
2387:                 73, 625, 643, 30, "CD", 17, 18)
2388:             THIS.AdicionarCheckBoxRotulado(loc_oPag, "chk_4c_Get_01_056", "lbl_4c_Lbl_01_056", ;
2389:                 93, 625, 643, 50, "Outros", 19, 20)
2390:             loc_oPag.AddObject("obj_4c_Get_01_074", "EditBox")
2391:             WITH loc_oPag.obj_4c_Get_01_074
2392:                 .Top = 114
2393:                 .Left = 625
2394:                 .Width = 360

*-- Linhas 2436 a 2505:
2436:         CATCH TO loc_oErro
2437:             MsgErro(loc_oErro.Message + CHR(13) + ;
2438:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2439:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarAbaApresentacao")
2440:         ENDTRY
2441:     ENDPROC
2442: 
2443:     *==========================================================================
2444:     * ConfigurarCabecalhoJob - Bloco de identificacao do Job, criado DIRETO na
2445:     * raiz do form (acima do PageFrame), exatamente como no SCX legado: o
2446:     * SIGOPJOB nao tem o container de cabecalho cinza (cntSombra) do
2447:     * frmcadastro - sao campos soltos na Form.
2448:     *
2449:     * Posicoes/propriedades EXATAS do dump (SIGOPJOB.getCab*/lblCab*/Say3/
2450:     * get_Extra/lbl_Extra). Nomes conforme tasks\task755\mapeamento.json.
2451:     *
2452:     * getCab001/002/005/006/010 sao SOMENTE-LEITURA: o SCX declara
2453:     * "Enabled = .F." explicitamente nos cinco, com DisabledBackColor
2454:     * 255,255,244 (creme) - eh a cor que da a aparencia de campo travado do
2455:     * legado. Quem os preenche eh CarregarCabecalhoJob(), a partir das
2456:     * propriedades this_cCab* do BO.
2457:     *
2458:     * O Label vem SEMPRE antes do campo (a caixa transparente do Label nao
2459:     * pode ficar por cima do controle - regra #23). Os Labels da classe "say"
2460:     * do legado nao declaram Width nem Alignment, entao recebem
2461:     * Alignment = 0 + AutoSize = .F. + Width que caiba o texto, e ForeColor
2462:     * RGB(90,90,90) - sobre o fundo claro da Form, branco seria INVISIVEL
2463:     * (regra #12).
2464:     *==========================================================================
2465:     PROTECTED PROCEDURE ConfigurarCabecalhoJob()
2466:         LOCAL loc_oErro
2467:         TRY
2468:             *-- Linha 1: Job (codigo) + Descricao do Job
2469:             THIS.AddObject("lbl_4c_LblCab001", "Label")
2470:             WITH THIS.lbl_4c_LblCab001
2471:                 .Top = 3
2472:                 .Left = 16
2473:                 .Width = 30
2474:                 .Height = 15
2475:                 .Alignment = 0
2476:                 .AutoSize = .F.
2477:                 .BackStyle = 0
2478:                 .ForeColor = RGB(90, 90, 90)
2479:                 .FontName = "Tahoma"
2480:                 .FontSize = 8
2481:                 .TabIndex = 1
2482:                 .Caption = "Job"
2483:             ENDWITH
2484: 
2485:             THIS.AddObject("txt_4c_Cab001", "TextBox")
2486:             WITH THIS.txt_4c_Cab001
2487:                 .Top = 18
2488:                 .Left = 16
2489:                 .Width = 80
2490:                 .Height = 23
2491:                 .BorderStyle = 1
2492:                 .SpecialEffect = 1
2493:                 .TabIndex = 2
2494:                 .Enabled = .F.
2495:                 .MaxLength = 10
2496:                 .BackColor         = RGB(255, 255, 244)
2497:                 .DisabledBackColor = RGB(255, 255, 244)
2498:                 .Value = ""
2499:             ENDWITH
2500: 
2501:             THIS.AddObject("lbl_4c_LblCab002", "Label")
2502:             WITH THIS.lbl_4c_LblCab002
2503:                 .Top = 3
2504:                 .Left = 99
2505:                 .Width = 60

*-- Linhas 2713 a 2818:
2713:         CATCH TO loc_oErro
2714:             MsgErro(loc_oErro.Message + CHR(13) + ;
2715:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2716:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarCabecalhoJob")
2717:         ENDTRY
2718:     ENDPROC
2719: 
2720:     *==========================================================================
2721:     * ConfigurarBotaoRetornar - Cria obj_4c_CmdRetornar (cmdRetornar legado),
2722:     * CommandGroup de 1 botao que fecha o dialogo de Complementos do Job
2723:     * (Click em CmdRetornarClick, regra #3/#45 - BINDEVENT em Buttons(1)).
2724:     * Posicao EXATA do dump: Top=13, Left=907, Width=85, Height=85.
2725:     *==========================================================================
2726:     PROTECTED PROCEDURE ConfigurarBotaoRetornar()
2727:         LOCAL loc_oErro
2728:         TRY
2729:             THIS.AddObject("obj_4c_CmdRetornar", "CommandGroup")
2730:             WITH THIS.obj_4c_CmdRetornar
2731:                 .Top         = 13
2732:                 .Left        = 907
2733:                 .Width       = 85
2734:                 .Height      = 85
2735:                 .ButtonCount = 1
2736:                 .BackStyle   = 0
2737:                 .BorderStyle = 0
2738:                 .Value       = 0
2739:                 .Visible     = .T.
2740: 
2741:                 WITH .Buttons(1)
2742:                     .Top        = 5
2743:                     .Left       = 5
2744:                     .Width      = 75
2745:                     .Height     = 75
2746:                     .FontBold   = .T.
2747:                     .FontItalic = .T.
2748:                     .FontName   = "Comic Sans MS"
2749:                     .FontSize   = 8
2750:                     .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
2751:                     .Caption    = "Retornar"
2752:                     .ForeColor  = RGB(90, 90, 90)
2753:                     .BackColor  = RGB(255, 255, 255)
2754:                     .Themes     = .F.
2755:                     .Cancel     = .T.
2756:                 ENDWITH
2757:             ENDWITH
2758:             BINDEVENT(THIS.obj_4c_CmdRetornar.Buttons(1), "Click", THIS, "CmdRetornarClick")
2759:         CATCH TO loc_oErro
2760:             MsgErro(loc_oErro.Message + CHR(13) + ;
2761:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2762:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarBotaoRetornar")
2763:         ENDTRY
2764:     ENDPROC
2765: 
2766:     *==========================================================================
2767:     * ConfigurarGridFontes - Cria a secao "Fontes Pagadoras" (grdFontes do
2768:     * legado) na Page5 (Financeiro): label de secao, linha divisoria, grade
2769:     * editavel ligada a cursor_4c_Fontes, botoes Inserir/Excluir (icones
2770:     * cadastro_inserir_26.jpg / cadastro_excluir_26.jpg - transcritos do dump
2771:     * em tasks\task755\SigOpJob_form_codigo_fonte.txt:3677/3689, regra #25)
2772:     * e os totalizadores txt_4c_TotFontes/txt_4c_TotValores (somente leitura).
2773:     *
2774:     * O cursor placeholder nasce ANTES do Grid (regra #41) com a MESMA ordem
2775:     * de colunas do SELECT feito por SigOpJobBO.CarregarFontes(), para o
2776:     * rebind em CarregarLista() nao reordenar nada.
2777:     *==========================================================================
2778:     PROTECTED PROCEDURE ConfigurarGridFontes()
2779:         LOCAL loc_oPagina, loc_oErro
2780:         TRY
2781:             IF USED("cursor_4c_Fontes")
2782:                 USE IN cursor_4c_Fontes
2783:             ENDIF
2784:             SET NULL ON
2785:             CREATE CURSOR cursor_4c_Fontes ;
2786:                 (empdopnums C(29), jbi_autors C(20), jbi_fontes C(50), ;
2787:                  jbi_modelos C(30), jbi_valors N(11,2), pkchaves C(20))
2788:             SET NULL OFF
2789: 
2790:             loc_oPagina = THIS.pgf_4c_Job.Page5
2791: 
2792:             loc_oPagina.AddObject("lbl_4c_Lbl_02_010", "Label")
2793:             WITH loc_oPagina.lbl_4c_Lbl_02_010
2794:                 .Top       = 199
2795:                 .Left      = 13
2796:                 .Width     = 200
2797:                 .Height    = 15
2798:                 .Alignment = 0
2799:                 .AutoSize  = .F.
2800:                 .BackStyle = 0
2801:                 .ForeColor = RGB(90, 90, 90)
2802:                 .FontName  = "Tahoma"
2803:                 .FontSize  = 8
2804:                 .Caption   = "Fontes Pagadoras"
2805:                 .Visible   = .T.
2806:             ENDWITH
2807: 
2808:             loc_oPagina.AddObject("lin_4c_Line1", "Line")
2809:             WITH loc_oPagina.lin_4c_Line1
2810:                 .Top     = 194
2811:                 .Left    = 13
2812:                 .Width   = 974
2813:                 .Height  = 0
2814:                 .Visible = .T.
2815:             ENDWITH
2816: 
2817:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
2818:             WITH loc_oPagina.grd_4c_Dados

*-- Linhas 2885 a 3027:
2885:                 .Column4.Header1.FontName  = "Verdana"
2886:                 .Column4.Header1.FontSize  = 8
2887:             ENDWITH
2888:             BINDEVENT(loc_oPagina.grd_4c_Dados, "AfterRowColChange", THIS, "GrdFontesAfterRowColChange")
2889:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column1.Text1, "When", THIS, "GrdFontesColumnWhen")
2890:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column2.Text1, "When", THIS, "GrdFontesColumnWhen")
2891:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column3.Text1, "When", THIS, "GrdFontesColumnWhen")
2892:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Text1, "When", THIS, "GrdFontesColumnWhen")
2893:             BINDEVENT(loc_oPagina.grd_4c_Dados.Column4.Text1, "Valid", THIS, "GrdFontesColumn4Valid")
2894: 
2895:             *-- Botao Inserir linha (legado: btnInserir top=217, left=947)
2896:             loc_oPagina.AddObject("cmd_4c_BtnInserir", "CommandButton")
2897:             WITH loc_oPagina.cmd_4c_BtnInserir
2898:                 .Top             = 217
2899:                 .Left            = 947
2900:                 .Width           = 42
2901:                 .Height          = 42
2902:                 .Caption         = ""
2903:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2904:                 .PicturePosition = 13
2905:                 .Themes          = .T.
2906:                 .SpecialEffect   = 0
2907:                 .MousePointer    = 15
2908:                 .ToolTipText     = "Inserir Linha em Branco na Grade"
2909:                 .Visible         = .T.
2910:             ENDWITH
2911:             BINDEVENT(loc_oPagina.cmd_4c_BtnInserir, "Click", THIS, "BtnInserirClick")
2912: 
2913:             *-- Botao Excluir linha (legado: btnExcluir top=257, left=947)
2914:             loc_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
2915:             WITH loc_oPagina.cmd_4c_BtnExcluir
2916:                 .Top             = 257
2917:                 .Left            = 947
2918:                 .Width           = 42
2919:                 .Height          = 42
2920:                 .Caption         = ""
2921:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2922:                 .PicturePosition = 13
2923:                 .Themes          = .T.
2924:                 .SpecialEffect   = 0
2925:                 .MousePointer    = 15
2926:                 .ToolTipText     = "Excluir"
2927:                 .Visible         = .T.
2928:             ENDWITH
2929:             BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirClick")
2930: 
2931:             *-- Totalizadores (somente leitura) - legado: getTotFontes/getTotValores
2932:             loc_oPagina.AddObject("txt_4c_TotFontes", "TextBox")
2933:             WITH loc_oPagina.txt_4c_TotFontes
2934:                 .Top               = 419
2935:                 .Left              = 595
2936:                 .Width             = 150
2937:                 .Height            = 23
2938:                 .Alignment         = 1
2939:                 .BorderStyle       = 1
2940:                 .SpecialEffect     = 1
2941:                 .Enabled           = .F.
2942:                 .Value             = ""
2943:                 .BackColor         = RGB(255, 255, 244)
2944:                 .DisabledBackColor = RGB(255, 255, 244)
2945:                 .Visible           = .T.
2946:             ENDWITH
2947: 
2948:             loc_oPagina.AddObject("txt_4c_TotValores", "TextBox")
2949:             WITH loc_oPagina.txt_4c_TotValores
2950:                 .Top               = 419
2951:                 .Left              = 747
2952:                 .Width             = 174
2953:                 .Height            = 23
2954:                 .Alignment         = 1
2955:                 .BorderStyle       = 1
2956:                 .SpecialEffect     = 1
2957:                 .Enabled           = .F.
2958:                 .Value             = ""
2959:                 .BackColor         = RGB(255, 255, 244)
2960:                 .DisabledBackColor = RGB(255, 255, 244)
2961:                 .Visible           = .T.
2962:             ENDWITH
2963:         CATCH TO loc_oErro
2964:             MsgErro(loc_oErro.Message + CHR(13) + ;
2965:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2966:                     "Procedure: " + loc_oErro.Procedure, "Erro em ConfigurarGridFontes")
2967:         ENDTRY
2968:     ENDPROC
2969: 
2970:     *==========================================================================
2971:     * CarregarLista - Carrega SigMvJbI (via BO.CarregarFontes) na grade
2972:     * "Fontes Pagadoras" e rebinda RecordSource/ControlSource/Width/Header -
2973:     * RecordSource RESETA essas propriedades (Problema 48), por isso sao
2974:     * reaplicadas aqui, depois do load (legado: PROCEDURE montagrades).
2975:     *
2976:     * Em modo INCLUIR/ALTERAR garante ao menos 1 linha em branco (mesma
2977:     * logica do btnInserir.Click) e exibe os botoes de Inserir/Excluir;
2978:     * em VISUALIZAR eles ficam ocultos e a grade some de edicao via o
2979:     * guard de GrdFontesColumnWhen.
2980:     *
2981:     * PUBLIC de proposito: este e' o FUNIL de carga da lista deste dialogo
2982:     * (a grade "Fontes Pagadoras" e' a unica lista que o SCX legado tem), e
2983:     * o harness de teste chama THIS.oForm.CarregarLista() de FORA da classe
2984:     * - PEMSTATUS devolve .T. para metodo PROTECTED, entao o teste entraria
2985:     * no branch e a chamada estouraria em runtime (regra #3).
2986:     *==========================================================================
2987:     PROCEDURE CarregarLista()
2988:         LOCAL loc_oGrid, loc_cAlias, loc_lModoEdicao, loc_lProsseguir, loc_oErro
2989: 
2990:         TRY
2991:             *-- Guarda SEM "RETURN" dentro do TRY (regra #1): o early-exit vira
2992:             *-- flag e o corpo fica sob o IF.
2993:             loc_lProsseguir = THIS.this_oBusinessObject.CarregarFontes()
2994: 
2995:             IF loc_lProsseguir
2996:                 loc_cAlias      = THIS.this_oBusinessObject.this_cCursorFontes
2997:                 loc_oGrid       = THIS.pgf_4c_Job.Page5.grd_4c_Dados
2998:                 loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2999: 
3000:                 WITH loc_oGrid
3001:                     .RecordSource = loc_cAlias
3002: 
3003:                     .Column1.ControlSource   = loc_cAlias + ".jbi_fontes"
3004:                     .Column1.Width           = 360
3005:                     .Column1.Header1.Caption = "Cliente"
3006: 
3007:                     .Column2.ControlSource   = loc_cAlias + ".jbi_modelos"
3008:                     .Column2.Width           = 220
3009:                     .Column2.Header1.Caption = "Modelo Fiscal"
3010: 
3011:                     .Column3.ControlSource   = loc_cAlias + ".jbi_autors"
3012:                     .Column3.Width           = 150
3013:                     .Column3.Header1.Caption = "N" + CHR(250) + "mero Incentivo"
3014: 
3015:                     .Column4.ControlSource   = loc_cAlias + ".jbi_valors"
3016:                     .Column4.Width           = 174
3017:                     .Column4.Header1.Caption = "Valor"
3018:                 ENDWITH
3019: 
3020:                 SELECT (loc_cAlias)
3021:                 GO TOP
3022: 
3023:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnInserir.Visible = .F.
3024:                 THIS.pgf_4c_Job.Page5.cmd_4c_BtnExcluir.Visible = .F.
3025: 
3026:                 IF loc_lModoEdicao
3027:                     LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)

*-- Linhas 3041 a 3430:
3041:         CATCH TO loc_oErro
3042:             MsgErro(loc_oErro.Message + CHR(13) + ;
3043:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3044:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarLista")
3045:         ENDTRY
3046:     ENDPROC
3047: 
3048:     *==========================================================================
3049:     * CarregarCabecalhoJob - Preenche o bloco de identificacao do Job
3050:     * (equivalente a PROCEDURE carregacabs do SCX legado, que tambem comeca
3051:     * LIMPANDO os getCab antes de recarregar).
3052:     *
3053:     * Os cinco campos sao Enabled = .F.: quem le o banco eh
3054:     * SigOpJobBO.CarregarCabecalho(), e aqui so se espelha o resultado.
3055:     *==========================================================================
3056:     PROTECTED PROCEDURE CarregarCabecalhoJob()
3057:         LOCAL loc_oBO, loc_oErro
3058: 
3059:         TRY
3060:             *-- Limpeza previa (o "For lnClr = 1 To 12 ... Value = []" legado)
3061:             THIS.txt_4c_Cab001.Value = ""
3062:             THIS.txt_4c_Cab002.Value = ""
3063:             THIS.txt_4c_Cab005.Value = ""
3064:             THIS.txt_4c_Cab006.Value = ""
3065:             THIS.txt_4c_Cab010.Value = {}
3066: 
3067:             *-- Guarda de conexao em IF SEPARADO (VFP9 nao garante
3068:             *-- short-circuit em AND) e delegada ao BO.ConexaoAtiva(), que
3069:             *-- testa TYPE antes do valor - sem conexao a variavel
3070:             *-- gnConnHandle pode nem existir.
3071:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3072:                 loc_oBO = THIS.this_oBusinessObject
3073: 
3074:                 IF loc_oBO.ConexaoAtiva()
3075:                     loc_oBO.CarregarCabecalho(THIS.this_cContas)
3076: 
3077:                     THIS.txt_4c_Cab001.Value = loc_oBO.this_cCabJobs
3078:                     THIS.txt_4c_Cab002.Value = loc_oBO.this_cCabJobDesc
3079:                     THIS.txt_4c_Cab005.Value = loc_oBO.this_cCabContas
3080:                     THIS.txt_4c_Cab006.Value = loc_oBO.this_cCabContaDesc
3081:                     THIS.txt_4c_Cab010.Value = ConverterParaData(loc_oBO.this_dCabDataEntrada)
3082:                 ENDIF
3083:             ENDIF
3084: 
3085:             THIS.txt_4c_Cab001.Refresh()
3086:             THIS.txt_4c_Cab002.Refresh()
3087:             THIS.txt_4c_Cab005.Refresh()
3088:             THIS.txt_4c_Cab006.Refresh()
3089:             THIS.txt_4c_Cab010.Refresh()
3090:         CATCH TO loc_oErro
3091:             MsgErro(loc_oErro.Message + CHR(13) + ;
3092:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3093:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarCabecalhoJob")
3094:         ENDTRY
3095:     ENDPROC
3096: 
3097:     *==========================================================================
3098:     * CarregarNomesEquipes - Preenche os 14 campos de NOME da Page3 a partir
3099:     * do codigo gravado em cada campo de codigo (equivalente a PROCEDURE
3100:     * mdadosequipes do SCX legado, que para cada Jb_024..037 nao vazio faz
3101:     * CursorQuery em SigCdCli e joga RClis no campo "a").
3102:     *
3103:     * O legado NAO tem ControlSource nos campos "a": eles sao preenchidos por
3104:     * codigo, e eh isso que se reproduz aqui.
3105:     *==========================================================================
3106:     PROTECTED PROCEDURE CarregarNomesEquipes()
3107:         LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_oErro
3108: 
3109:         TRY
3110:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3111:                 loc_oBO   = THIS.this_oBusinessObject
3112:                 loc_oCnt1 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp1
3113:                 loc_oCnt2 = THIS.pgf_4c_Job.Page3.cnt_4c_Emp2
3114: 
3115:                 loc_oCnt1.txt_4c__01_024a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb024)
3116:                 loc_oCnt1.txt_4c__01_025a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb025)
3117:                 loc_oCnt1.txt_4c__01_026a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb026)
3118:                 loc_oCnt1.txt_4c__01_027a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb027)
3119:                 loc_oCnt1.txt_4c__01_028a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb028)
3120:                 loc_oCnt1.txt_4c__01_029a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb029)
3121:                 loc_oCnt1.txt_4c__01_030a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb030)
3122: 
3123:                 loc_oCnt2.txt_4c__01_031a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb031)
3124:                 loc_oCnt2.txt_4c__01_032a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb032)
3125:                 loc_oCnt2.txt_4c__01_033a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb033)
3126:                 loc_oCnt2.txt_4c__01_034a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb034)
3127:                 loc_oCnt2.txt_4c__01_035a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb035)
3128:                 loc_oCnt2.txt_4c__01_036a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb036)
3129:                 loc_oCnt2.txt_4c__01_037a.Value = THIS.ObterNomeConta(loc_oBO.this_cJb037)
3130:             ENDIF
3131:         CATCH TO loc_oErro
3132:             MsgErro(loc_oErro.Message + CHR(13) + ;
3133:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3134:                     "Procedure: " + loc_oErro.Procedure, "Erro em CarregarNomesEquipes")
3135:         ENDTRY
3136:     ENDPROC
3137: 
3138:     *==========================================================================
3139:     * ObterNomeConta - SigCdCli.RClis do codigo informado, delegando ao BO.
3140:     * Devolve "" para codigo vazio ou sem conexao (modo de teste/validacao de
3141:     * UI roda com gnConnHandle invalido).
3142:     *==========================================================================
3143:     PROTECTED FUNCTION ObterNomeConta(par_cCodigo)
3144:         LOCAL loc_cNome
3145:         loc_cNome = ""
3146: 
3147:         *-- IFs aninhados, nao AND encadeado: VFP9 nao garante short-circuit,
3148:         *-- e a guarda de conexao tem de vir DEPOIS de provar que o BO existe.
3149:         IF VARTYPE(par_cCodigo) = "C" AND !EMPTY(ALLTRIM(par_cCodigo))
3150:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3151:                 IF THIS.this_oBusinessObject.ConexaoAtiva()
3152:                     loc_cNome = THIS.this_oBusinessObject.ObterRazaoConta(par_cCodigo)
3153:                 ENDIF
3154:             ENDIF
3155:         ENDIF
3156: 
3157:         RETURN loc_cNome
3158:     ENDFUNC
3159: 
3160:     *==========================================================================
3161:     * GrdFontesColumnWhen - Controla editabilidade das 4 colunas da grade
3162:     * "Fontes Pagadoras" (legado: Column1..4.Text1.When, texto identico nas
3163:     * quatro - "Return InList(ThisForm.pcEscolha, [INSERIR], [ALTERAR])").
3164:     *==========================================================================
3165:     PROCEDURE GrdFontesColumnWhen()
3166:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3167:     ENDPROC
3168: 
3169:     *==========================================================================
3170:     * GrdFontesColumn4Valid - Ao sair da coluna Valor com Cliente e Modelo
3171:     * Fiscal preenchidos, garante uma nova linha em branco no final da grade
3172:     * (legado: Column4.Text1.Valid).
3173:     *==========================================================================
3174:     PROCEDURE GrdFontesColumn4Valid()
3175:         LOCAL loc_cAlias
3176: 
3177:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3178:             RETURN .T.
3179:         ENDIF
3180: 
3181:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3182:         IF !USED(loc_cAlias)
3183:             RETURN .T.
3184:         ENDIF
3185: 
3186:         SELECT (loc_cAlias)
3187:         IF !EMPTY(jbi_fontes) AND !EMPTY(jbi_modelos) AND !EOF()
3188:             SKIP
3189:             IF EOF()
3190:                 INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3191:                     (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3192:             ENDIF
3193:         ENDIF
3194: 
3195:         GO TOP
3196:         THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3197:         GO BOTTOM
3198: 
3199:         RETURN .T.
3200:     ENDPROC
3201: 
3202:     *==========================================================================
3203:     * BtnInserirClick - Insere linha em branco na grade "Fontes Pagadoras"
3204:     * (legado: pgPagina5.btnInserir.Click). So reutiliza linha ja vazia
3205:     * (JBI_Fontes e JBI_Modelos vazios); senao cria uma nova com pkChaves
3206:     * unico (fUniqueIds()).
3207:     *==========================================================================
3208:     PROCEDURE BtnInserirClick()
3209:         *-- Guardas por FLAG, nunca RETURN: RETURN dentro de TRY/ENDTRY (bare
3210:         *-- ou com valor) estoura "RETURN/RETRY statement not allowed in
3211:         *-- TRY/CATCH" em RUNTIME, e so no caminho em que a guarda pega -
3212:         *-- o .prg compila limpo e o caminho feliz passa nos testes (regra #1).
3213:         LOCAL loc_cAlias, loc_lProsseguir, loc_oErro
3214:         loc_lProsseguir = .T.
3215: 
3216:         TRY
3217:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3218:                 loc_lProsseguir = .F.
3219:             ENDIF
3220: 
3221:             IF loc_lProsseguir
3222:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3223:                 IF !USED(loc_cAlias)
3224:                     loc_lProsseguir = .F.
3225:                 ENDIF
3226:             ENDIF
3227: 
3228:             IF loc_lProsseguir
3229:                 SELECT (loc_cAlias)
3230:                 LOCATE FOR EMPTY(jbi_fontes) AND EMPTY(jbi_modelos)
3231:                 IF !FOUND()
3232:                     INSERT INTO (loc_cAlias) (empdopnums, pkchaves) VALUES ;
3233:                         (THIS.this_oBusinessObject.this_cEmpDopNums, fUniqueIds())
3234:                 ENDIF
3235: 
3236:                 SELECT (loc_cAlias)
3237:                 GO TOP
3238:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3239:                 GO BOTTOM
3240:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.SetFocus()
3241:                 THIS.GrdFontesAfterRowColChange(1)
3242:             ENDIF
3243:         CATCH TO loc_oErro
3244:             MsgErro(loc_oErro.Message + CHR(13) + ;
3245:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3246:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnInserirClick")
3247:         ENDTRY
3248:     ENDPROC
3249: 
3250:     *==========================================================================
3251:     * BtnExcluirClick - Exclui a linha corrente da grade "Fontes Pagadoras"
3252:     * (legado: pgPagina5.btnExcluir.Click). DELETE sem PACK - SET DELETED ON
3253:     * (config.prg) ja tira a linha da visao do Grid.
3254:     *==========================================================================
3255:     PROCEDURE BtnExcluirClick()
3256:         *-- Guardas por FLAG, nunca RETURN - ver comentario de BtnInserirClick
3257:         *-- (regra #1). Aqui o RETURN era ainda mais perigoso: ele ficava
3258:         *-- ANTES do LockScreen = .T., mas o estouro em runtime deixaria o
3259:         *-- metodo pelo CATCH, que repoe LockScreen = .F.
3260:         LOCAL loc_cAlias, loc_nRec, loc_lProsseguir, loc_oErro
3261:         loc_lProsseguir = .T.
3262: 
3263:         TRY
3264:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
3265:                 loc_lProsseguir = .F.
3266:             ENDIF
3267: 
3268:             IF loc_lProsseguir
3269:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3270:                 IF !USED(loc_cAlias)
3271:                     loc_lProsseguir = .F.
3272:                 ENDIF
3273:             ENDIF
3274: 
3275:             IF loc_lProsseguir
3276:                 THIS.LockScreen = .T.
3277: 
3278:                 SELECT (loc_cAlias)
3279:                 loc_nRec = RECNO()
3280:                 IF !EOF()
3281:                     DELETE
3282:                 ENDIF
3283: 
3284:                 GO TOP
3285:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3286:                 IF BETWEEN(loc_nRec, 1, RECCOUNT())
3287:                     GO (loc_nRec)
3288:                 ELSE
3289:                     GO BOTTOM
3290:                 ENDIF
3291:                 THIS.pgf_4c_Job.Page5.grd_4c_Dados.Refresh()
3292:                 THIS.GrdFontesAfterRowColChange(1)
3293: 
3294:                 THIS.LockScreen = .F.
3295:             ENDIF
3296:         CATCH TO loc_oErro
3297:             THIS.LockScreen = .F.
3298:             MsgErro(loc_oErro.Message + CHR(13) + ;
3299:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3300:                     "Procedure: " + loc_oErro.Procedure, "Erro em BtnExcluirClick")
3301:         ENDTRY
3302:     ENDPROC
3303: 
3304:     *==========================================================================
3305:     * GrdFontesAfterRowColChange - Recalcula os totalizadores da grade.
3306:     * Uso legitimo de AfterRowColChange (regra #46): nao valida CELULA, so
3307:     * agrega o cursor inteiro - igual ao legado, que tambem chama este
3308:     * evento manualmente apos cada INSERT/DELETE/GO (nao confia em disparo
3309:     * automatico do Grid para recalculo).
3310:     *==========================================================================
3311:     PROCEDURE GrdFontesAfterRowColChange(par_nColIndex)
3312:         THIS.RecalcularTotaisFontes()
3313:     ENDPROC
3314: 
3315:     *==========================================================================
3316:     * RecalcularTotaisFontes - Soma Count(1)/Sum(JBI_Valors) por EmpDopNums,
3317:     * igual ao legado (grdFontes.AfterRowColChange), e espelha nos
3318:     * totalizadores txt_4c_TotFontes/txt_4c_TotValores.
3319:     *==========================================================================
3320:     PROCEDURE RecalcularTotaisFontes()
3321:         LOCAL loc_cAlias, loc_nSoma, loc_nValors, loc_oErro
3322: 
3323:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3324:             RETURN
3325:         ENDIF
3326: 
3327:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
3328:         IF !USED(loc_cAlias)
3329:             RETURN
3330:         ENDIF
3331: 
3332:         TRY
3333:             SELECT empdopnums, COUNT(1) AS Soma, SUM(jbi_valors) AS Valors ;
3334:                 FROM (loc_cAlias) ;
3335:                 GROUP BY empdopnums ;
3336:                 INTO CURSOR cursor_4c_FontesTot
3337: 
3338:             IF RECCOUNT("cursor_4c_FontesTot") > 0
3339:                 GO TOP IN cursor_4c_FontesTot
3340:                 loc_nSoma   = cursor_4c_FontesTot.Soma
3341:                 loc_nValors = cursor_4c_FontesTot.Valors
3342:             ELSE
3343:                 loc_nSoma   = 0
3344:                 loc_nValors = 0
3345:             ENDIF
3346: 
3347:             IF USED("cursor_4c_FontesTot")
3348:                 USE IN cursor_4c_FontesTot
3349:             ENDIF
3350: 
3351:             THIS.pgf_4c_Job.Page5.txt_4c_TotFontes.Value  = TRANSFORM(loc_nSoma, "999,999,999")
3352:             THIS.pgf_4c_Job.Page5.txt_4c_TotValores.Value = TRANSFORM(loc_nValors, "999,999,999,999.99")
3353:             THIS.pgf_4c_Job.Page5.txt_4c_TotFontes.Refresh()
3354:             THIS.pgf_4c_Job.Page5.txt_4c_TotValores.Refresh()
3355:         CATCH TO loc_oErro
3356:             MsgErro(loc_oErro.Message + CHR(13) + ;
3357:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3358:                     "Procedure: " + loc_oErro.Procedure, "Erro em RecalcularTotaisFontes")
3359:         ENDTRY
3360:     ENDPROC
3361: 
3362:     *==========================================================================
3363:     * BOParaForm - Espelha as propriedades this_* do BO nos controles da tela.
3364:     * NESTA FASE cobre o cabecalho de identificacao do Job (raiz do form),
3365:     * Page1 (Briefing), Page2 (Desafio/Objetivos) e Page3 (Equipes). As
3366:     * paginas restantes (Materiais/Financeiro/Apresentacao) sao adicionadas
3367:     * nas proximas fases e este metodo sera estendido junto.
3368:     *==========================================================================
3369:     PROTECTED PROCEDURE BOParaForm()
3370:         LOCAL loc_oBO, loc_oPag1, loc_oPag2, loc_oPag3, loc_oCnt1, loc_oCnt2, loc_oErro
3371: 
3372:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3373:             RETURN
3374:         ENDIF
3375: 
3376:         TRY
3377:             loc_oBO   = THIS.this_oBusinessObject
3378:             loc_oPag1 = THIS.pgf_4c_Job.Page1
3379:             loc_oPag2 = THIS.pgf_4c_Job.Page2
3380: 
3381:             *-- Page1 - Briefing
3382:             loc_oPag1.txt_4c__01_001.Value = ConverterParaData(loc_oBO.this_dJb001)
3383:             loc_oPag1.txt_4c__01_002.Value = ConverterParaData(loc_oBO.this_dJb002)
3384:             loc_oPag1.obj_4c_Get_01_003.Value = loc_oBO.this_cJb003
3385:             loc_oPag1.obj_4c_Get_01_004.Value = loc_oBO.this_cJb004
3386:             loc_oPag1.obj_4c_Get_01_005.Value = loc_oBO.this_cJb005
3387:             loc_oPag1.obj_4c_Get_01_006.Value = loc_oBO.this_cJb006
3388:             loc_oPag1.obj_4c_Get_01_007.Value = loc_oBO.this_cJb007
3389:             loc_oPag1.obj_4c_Get_01_008.Value = loc_oBO.this_cJb008
3390:             loc_oPag1.txt_4c__01_017.Value = ConverterParaData(loc_oBO.this_dJb017)
3391:             loc_oPag1.txt_4c__01_018.Value = ConverterParaData(loc_oBO.this_dJb018)
3392:             loc_oPag1.txt_4c__01_019.Value = ConverterParaData(loc_oBO.this_dJb019)
3393:             loc_oPag1.txt_4c__01_020.Value = ConverterParaData(loc_oBO.this_dJb020)
3394:             loc_oPag1.obj_4c_Get_01_021.Value = loc_oBO.this_cJb021
3395:             loc_oPag1.obj_4c_Get_01_022.Value = loc_oBO.this_cJb022
3396:             loc_oPag1.obj_4c_Get_01_023.Value = loc_oBO.this_cJb023
3397: 
3398:             *-- Page2 - Desafio / Objetivos
3399:             loc_oPag2.obj_4c_Get_01_009.Value = loc_oBO.this_cJb009
3400:             loc_oPag2.obj_4c_Get_01_010.Value = loc_oBO.this_cJb010
3401:             loc_oPag2.obj_4c_Get_01_011.Value = loc_oBO.this_cJb011
3402:             loc_oPag2.obj_4c_Get_01_012.Value = loc_oBO.this_cJb012
3403:             loc_oPag2.obj_4c_Get_01_013.Value = loc_oBO.this_cJb013
3404:             loc_oPag2.obj_4c_Get_01_014.Value = loc_oBO.this_cJb014
3405:             loc_oPag2.obj_4c_Get_01_015.Value = loc_oBO.this_cJb015
3406:             loc_oPag2.obj_4c_Get_01_016.Value = loc_oBO.this_cJb016
3407: 
3408:             *-- Raiz do form - "Briefing Extra" (Jb_072, numeric(1,0)).
3409:             *-- CheckBox.Value eh NUMERICO: comparar explicitamente, nunca
3410:             *-- atribuir a property direto (IIF exige condicao LOGICA).
3411:             THIS.chk_4c_Get_Extra.Value = IIF(loc_oBO.this_nJb072 = 1, 1, 0)
3412: 
3413:             *-- Page3 - Equipes (codigos) e classificacao do Job
3414:             loc_oPag3 = THIS.pgf_4c_Job.Page3
3415:             loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
3416:             loc_oCnt2 = loc_oPag3.cnt_4c_Emp2
3417: 
3418:             loc_oCnt1.txt_4c__01_024.Value = loc_oBO.this_cJb024
3419:             loc_oCnt1.txt_4c__01_025.Value = loc_oBO.this_cJb025
3420:             loc_oCnt1.txt_4c__01_026.Value = loc_oBO.this_cJb026
3421:             loc_oCnt1.txt_4c__01_027.Value = loc_oBO.this_cJb027
3422:             loc_oCnt1.txt_4c__01_028.Value = loc_oBO.this_cJb028
3423:             loc_oCnt1.txt_4c__01_029.Value = loc_oBO.this_cJb029
3424:             loc_oCnt1.txt_4c__01_030.Value = loc_oBO.this_cJb030
3425: 
3426:             loc_oCnt2.txt_4c__01_031.Value = loc_oBO.this_cJb031
3427:             loc_oCnt2.txt_4c__01_032.Value = loc_oBO.this_cJb032
3428:             loc_oCnt2.txt_4c__01_033.Value = loc_oBO.this_cJb033
3429:             loc_oCnt2.txt_4c__01_034.Value = loc_oBO.this_cJb034
3430:             loc_oCnt2.txt_4c__01_035.Value = loc_oBO.this_cJb035

*-- Linhas 3488 a 3596:
3488:         CATCH TO loc_oErro
3489:             MsgErro(loc_oErro.Message + CHR(13) + ;
3490:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3491:                     "Procedure: " + loc_oErro.Procedure, "Erro em BOParaForm")
3492:         ENDTRY
3493:     ENDPROC
3494: 
3495:     *==========================================================================
3496:     * HabilitarCampos - Aplica o "PROCEDURE When" do legado aos campos que so
3497:     * ficam editaveis em INCLUIR/ALTERAR. BINDEVENT em "When" nao funciona
3498:     * (regra #45.3 - o retorno do delegate eh descartado e nao bloqueia a
3499:     * edicao), entao a gate vira .Enabled direto, aplicado uma vez a partir
3500:     * do BOParaForm - este dialogo nao troca de modo depois de aberto
3501:     * (this_cModoAtual vem do form pai no Init e fica fixo pelo resto da
3502:     * vida do form, nao ha AlternarPagina/troca de modo em runtime aqui).
3503:     *
3504:     * Campos SEM When no dump (todos os outros TextBox/EditBox/CheckBox de
3505:     * Jb_003..016, 021..023, 024..044, 049..058, 062..075) ficam sempre
3506:     * editaveis, inclusive em VISUALIZAR - nao inventar gate que o legado
3507:     * nao tem (PILAR 1). A grade "Fontes Pagadoras" ja tem seu proprio guard
3508:     * (GrdFontesColumnWhen) e as equipes da Page3 o seu
3509:     * (AtualizarEstadoContasEquipe/AjustarNomeContaEquipe).
3510:     *==========================================================================
3511:     PROTECTED PROCEDURE HabilitarCampos()
3512:         LOCAL loc_lModoEdicao, loc_oPag1, loc_oPag4, loc_oErro
3513:         loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3514: 
3515:         TRY
3516:             *-- Page1 - as 2 datas de Apresentacao/Orcamento e as 4 do
3517:             *-- Periodo do Evento/Montagem (legado: get_01_001/002/017..020)
3518:             loc_oPag1 = THIS.pgf_4c_Job.Page1
3519:             loc_oPag1.txt_4c__01_001.Enabled = loc_lModoEdicao
3520:             loc_oPag1.txt_4c__01_002.Enabled = loc_lModoEdicao
3521:             loc_oPag1.txt_4c__01_017.Enabled = loc_lModoEdicao
3522:             loc_oPag1.txt_4c__01_018.Enabled = loc_lModoEdicao
3523:             loc_oPag1.txt_4c__01_019.Enabled = loc_lModoEdicao
3524:             loc_oPag1.txt_4c__01_020.Enabled = loc_lModoEdicao
3525: 
3526:             *-- Page4 - botoes "..." (GetDir) dos 5 campos de pasta/arquivo.
3527:             *-- O botao "Abrir" (b) nao tem When no dump - so le o caminho e
3528:             *-- abre o Explorer, inofensivo em qualquer modo; o EditBox e
3529:             *-- ReadOnly sempre (AdicionarCampoPastaMaterial), nao precisa
3530:             *-- gate por modo.
3531:             loc_oPag4 = THIS.pgf_4c_Job.Page4
3532:             loc_oPag4.cmd_4c_Btn_01_045.Enabled = loc_lModoEdicao
3533:             loc_oPag4.cmd_4c_Btn_01_046.Enabled = loc_lModoEdicao
3534:             loc_oPag4.cmd_4c_Btn_01_047.Enabled = loc_lModoEdicao
3535:             loc_oPag4.cmd_4c_Btn_01_048.Enabled = loc_lModoEdicao
3536:             loc_oPag4.cmd_4c_Btn_01_061.Enabled = loc_lModoEdicao
3537: 
3538:             *-- Raiz do form - Contatos com o Cliente (legado: getCabContatos)
3539:             THIS.obj_4c_GetCabContatos.Enabled = loc_lModoEdicao
3540:         CATCH TO loc_oErro
3541:             MsgErro(loc_oErro.Message + CHR(13) + ;
3542:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3543:                     "Procedure: " + loc_oErro.Procedure, "Erro em HabilitarCampos")
3544:         ENDTRY
3545:     ENDPROC
3546: 
3547:     *==========================================================================
3548:     * FormParaBO - Le os controles da tela para as propriedades this_* do BO.
3549:     * NESTA FASE cobre "Briefing Extra" (raiz), Page1 (Briefing), Page2
3550:     * (Desafio/Objetivos) e Page3 (Equipes) - ver comentario de BOParaForm
3551:     * sobre a extensao nas proximas fases.
3552:     *
3553:     * Os getCab* do cabecalho NAO entram aqui: sao somente-leitura e seus
3554:     * valores vem de SigMvCab/SigCdCli, nao de colunas de SigMvJbC.
3555:     *==========================================================================
3556:     PROTECTED PROCEDURE FormParaBO()
3557:         LOCAL loc_oBO, loc_oPag1, loc_oPag2, loc_oPag3, loc_oCnt1, loc_oCnt2, loc_oErro
3558: 
3559:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3560:             RETURN
3561:         ENDIF
3562: 
3563:         TRY
3564:             loc_oBO   = THIS.this_oBusinessObject
3565:             loc_oPag1 = THIS.pgf_4c_Job.Page1
3566:             loc_oPag2 = THIS.pgf_4c_Job.Page2
3567: 
3568:             *-- Page1 - Briefing
3569:             loc_oBO.this_dJb001 = ConverterParaData(loc_oPag1.txt_4c__01_001.Value)
3570:             loc_oBO.this_dJb002 = ConverterParaData(loc_oPag1.txt_4c__01_002.Value)
3571:             loc_oBO.this_cJb003 = loc_oPag1.obj_4c_Get_01_003.Value
3572:             loc_oBO.this_cJb004 = loc_oPag1.obj_4c_Get_01_004.Value
3573:             loc_oBO.this_cJb005 = loc_oPag1.obj_4c_Get_01_005.Value
3574:             loc_oBO.this_cJb006 = loc_oPag1.obj_4c_Get_01_006.Value
3575:             loc_oBO.this_cJb007 = loc_oPag1.obj_4c_Get_01_007.Value
3576:             loc_oBO.this_cJb008 = loc_oPag1.obj_4c_Get_01_008.Value
3577:             loc_oBO.this_dJb017 = ConverterParaData(loc_oPag1.txt_4c__01_017.Value)
3578:             loc_oBO.this_dJb018 = ConverterParaData(loc_oPag1.txt_4c__01_018.Value)
3579:             loc_oBO.this_dJb019 = ConverterParaData(loc_oPag1.txt_4c__01_019.Value)
3580:             loc_oBO.this_dJb020 = ConverterParaData(loc_oPag1.txt_4c__01_020.Value)
3581:             loc_oBO.this_cJb021 = loc_oPag1.obj_4c_Get_01_021.Value
3582:             loc_oBO.this_cJb022 = loc_oPag1.obj_4c_Get_01_022.Value
3583:             loc_oBO.this_cJb023 = loc_oPag1.obj_4c_Get_01_023.Value
3584: 
3585:             *-- Page2 - Desafio / Objetivos
3586:             loc_oBO.this_cJb009 = loc_oPag2.obj_4c_Get_01_009.Value
3587:             loc_oBO.this_cJb010 = loc_oPag2.obj_4c_Get_01_010.Value
3588:             loc_oBO.this_cJb011 = loc_oPag2.obj_4c_Get_01_011.Value
3589:             loc_oBO.this_cJb012 = loc_oPag2.obj_4c_Get_01_012.Value
3590:             loc_oBO.this_cJb013 = loc_oPag2.obj_4c_Get_01_013.Value
3591:             loc_oBO.this_cJb014 = loc_oPag2.obj_4c_Get_01_014.Value
3592:             loc_oBO.this_cJb015 = loc_oPag2.obj_4c_Get_01_015.Value
3593:             loc_oBO.this_cJb016 = loc_oPag2.obj_4c_Get_01_016.Value
3594: 
3595:             *-- Raiz do form - "Briefing Extra" (Jb_072, numeric(1,0))
3596:             loc_oBO.this_nJb072 = IIF(THIS.chk_4c_Get_Extra.Value = 1, 1, 0)

*-- Linhas 3602 a 3622:
3602:             *-- As colunas Jb_024..037 sao char(10) NOT NULL: ALLTRIM aqui
3603:             *-- (o SQL Server faz blank-padding ANSI em char) e o INSERT/UPDATE
3604:             *-- do BO fecha com PADR(..., 10), o MESMO tamanho do .MaxLength
3605:             *-- destes TextBox.
3606:             loc_oPag3 = THIS.pgf_4c_Job.Page3
3607:             loc_oCnt1 = loc_oPag3.cnt_4c_Emp1
3608:             loc_oCnt2 = loc_oPag3.cnt_4c_Emp2
3609: 
3610:             loc_oBO.this_cJb024 = ALLTRIM(loc_oCnt1.txt_4c__01_024.Value)
3611:             loc_oBO.this_cJb025 = ALLTRIM(loc_oCnt1.txt_4c__01_025.Value)
3612:             loc_oBO.this_cJb026 = ALLTRIM(loc_oCnt1.txt_4c__01_026.Value)
3613:             loc_oBO.this_cJb027 = ALLTRIM(loc_oCnt1.txt_4c__01_027.Value)
3614:             loc_oBO.this_cJb028 = ALLTRIM(loc_oCnt1.txt_4c__01_028.Value)
3615:             loc_oBO.this_cJb029 = ALLTRIM(loc_oCnt1.txt_4c__01_029.Value)
3616:             loc_oBO.this_cJb030 = ALLTRIM(loc_oCnt1.txt_4c__01_030.Value)
3617: 
3618:             loc_oBO.this_cJb031 = ALLTRIM(loc_oCnt2.txt_4c__01_031.Value)
3619:             loc_oBO.this_cJb032 = ALLTRIM(loc_oCnt2.txt_4c__01_032.Value)
3620:             loc_oBO.this_cJb033 = ALLTRIM(loc_oCnt2.txt_4c__01_033.Value)
3621:             loc_oBO.this_cJb034 = ALLTRIM(loc_oCnt2.txt_4c__01_034.Value)
3622:             loc_oBO.this_cJb035 = ALLTRIM(loc_oCnt2.txt_4c__01_035.Value)

*-- Linhas 3667 a 3782:
3667:         CATCH TO loc_oErro
3668:             MsgErro(loc_oErro.Message + CHR(13) + ;
3669:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
3670:                     "Procedure: " + loc_oErro.Procedure, "Erro em FormParaBO")
3671:         ENDTRY
3672:     ENDPROC
3673: 
3674:     *==========================================================================
3675:     * TornarControlesVisiveis - Torna visiveis todos os controles criados via
3676:     * AddObject (que nascem com Visible=.F.), percorrendo Pages de PageFrame
3677:     * e Controls de Container/CommandGroup recursivamente.
3678:     *==========================================================================
3679:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3680:         LOCAL loc_nI, loc_oObjeto, loc_nP
3681: 
3682:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3683:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3684: 
3685:             IF VARTYPE(loc_oObjeto) = "O"
3686:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3687:                     loc_oObjeto.Visible = .T.
3688:                 ENDIF
3689: 
3690:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3691:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3692:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3693:                     ENDFOR
3694:                 ENDIF
3695: 
3696:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
3697:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3698:                 ENDIF
3699:             ENDIF
3700:         ENDFOR
3701:     ENDPROC
3702: 
3703:     *==========================================================================
3704:     * VincularChecagemObrigatorios - Liga ChecarCamposObrigatorios ao
3705:     * LostFocus de todo campo digitavel/marcavel da tela.
3706:     *
3707:     * No SCX legado isso esta escrito campo a campo: ~60 "PROCEDURE
3708:     * LostFocus" cujo corpo e' uma linha so, "ThisForm.ChecaObrigs()". O
3709:     * efeito e' que QUALQUER saida de campo repinta a marcacao de
3710:     * obrigatoriedade; reproduzir por varredura da arvore de controles da o
3711:     * mesmo resultado sem repetir 60 BINDEVENTs, e nao pode divergir da
3712:     * lista de campos quando uma aba mudar.
3713:     *
3714:     * LostFocus (nao KeyPress): o legado valida ao SAIR do campo, e o
3715:     * handler nao testa tecla nenhuma (regra #47). ChecarCamposObrigatorios
3716:     * nao tem parametros - LostFocus nao passa nenhum.
3717:     *
3718:     * O Grid fica de FORA: as celulas tem funil proprio
3719:     * (GrdFontesColumn4Valid / GrdFontesAfterRowColChange) e o legado nao
3720:     * liga ChecaObrigs a nenhuma coluna da grade.
3721:     *
3722:     * Os campos de conta da Page3 ganham um SEGUNDO delegate aqui, somado ao
3723:     * ValidarConta0NN/ValidarNomeConta0NN que ja tinham - exatamente como no
3724:     * legado, em que get_01_0NN declara Valid (lookup) E LostFocus
3725:     * (ChecaObrigs). Como este BINDEVENT e' registrado DEPOIS, ele roda
3726:     * DEPOIS do lookup, isto e' com o campo ja resolvido.
3727:     *==========================================================================
3728:     PROTECTED PROCEDURE VincularChecagemObrigatorios(par_oContainer)
3729:         LOCAL loc_nI, loc_oObj, loc_cBase, loc_nP
3730: 
3731:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3732:             loc_oObj = par_oContainer.Controls(loc_nI)
3733: 
3734:             IF VARTYPE(loc_oObj) = "O"
3735:                 loc_cBase = UPPER(loc_oObj.BaseClass)
3736: 
3737:                 DO CASE
3738:                     CASE loc_cBase = "GRID"
3739:                         *-- grade tem funil proprio - ver comentario acima
3740: 
3741:                     CASE INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "CHECKBOX")
3742:                         BINDEVENT(loc_oObj, "LostFocus", THIS, "ChecarCamposObrigatorios")
3743: 
3744:                     CASE loc_cBase = "PAGEFRAME"
3745:                         FOR loc_nP = 1 TO loc_oObj.PageCount
3746:                             THIS.VincularChecagemObrigatorios(loc_oObj.Pages(loc_nP))
3747:                         ENDFOR
3748: 
3749:                     OTHERWISE
3750:                         IF PEMSTATUS(loc_oObj, "ControlCount", 5)
3751:                             IF loc_oObj.ControlCount > 0
3752:                                 THIS.VincularChecagemObrigatorios(loc_oObj)
3753:                             ENDIF
3754:                         ENDIF
3755:                 ENDCASE
3756:             ENDIF
3757:         ENDFOR
3758:     ENDPROC
3759: 
3760:     *==========================================================================
3761:     * ResolverControle - Devolve o objeto de controle no caminho
3762:     * par_cCaminho, SEMPRE relativo a THIS.pgf_4c_Job (ex.:
3763:     * "Page1.txt_4c__01_001", "Page3.cnt_4c_Emp1.txt_4c__01_024").
3764:     *
3765:     * Alcancar membro por NOME em VFP9 se faz com EVALUATE na LEITURA
3766:     * (regra #15/#34) - Controls("nome") estoura, e PEMSTATUS nao protege.
3767:     * O TYPE() antes do EVALUATE evita TRY/CATCH: caminho invalido devolve
3768:     * "U" sem erro, e CATCH aqui seria silencioso ou ruidoso demais (este
3769:     * metodo roda em laco de 69 posicoes).
3770:     *
3771:     * Devolve .NULL. quando o controle nao existe - acontece legitimamente
3772:     * em probe/harness, em que parte da tela pode nao ter sido criada.
3773:     *==========================================================================
3774:     PROTECTED FUNCTION ResolverControle(par_cCaminho)
3775:         LOCAL loc_cExpr
3776: 
3777:         IF VARTYPE(par_cCaminho) != "C"
3778:             RETURN .NULL.
3779:         ENDIF
3780:         IF EMPTY(par_cCaminho)
3781:             RETURN .NULL.
3782:         ENDIF

*-- Linhas 3861 a 3982:
3861:     * PEMSTATUS antes de atribuir porque propriedade que a classe nao tem
3862:     * estoura em runtime e derruba a tela (regra #33).
3863:     *==========================================================================
3864:     PROTECTED PROCEDURE MarcarCampoObrigatorio(par_cCaminho, par_lOk, par_cPropriedade)
3865:         LOCAL loc_oCtrl, loc_nCor
3866: 
3867:         loc_oCtrl = THIS.ResolverControle(par_cCaminho)
3868:         IF VARTYPE(loc_oCtrl) != "O"
3869:             RETURN
3870:         ENDIF
3871: 
3872:         loc_nCor = IIF(par_lOk, RGB(36, 84, 155), RGB(255, 0, 0))
3873: 
3874:         IF par_cPropriedade = "F"
3875:             IF PEMSTATUS(loc_oCtrl, "ForeColor", 5)
3876:                 loc_oCtrl.ForeColor = loc_nCor
3877:             ENDIF
3878:         ELSE
3879:             IF PEMSTATUS(loc_oCtrl, "BorderColor", 5)
3880:                 loc_oCtrl.BorderColor = loc_nCor
3881:             ENDIF
3882:         ENDIF
3883:     ENDPROC
3884: 
3885:     *==========================================================================
3886:     * ChecarCamposObrigatorios - Transcricao de "PROCEDURE checaobrigs" do
3887:     * SCX legado. Devolve "OK" ou "ERRO" e, no caminho, PINTA cada campo
3888:     * conferido de azul (atendido) ou vermelho (em falta).
3889:     *
3890:     * A obrigatoriedade NAO esta no codigo: vem da MASCARA POSICIONAL
3891:     * SigOpCdI.job_mv_obr, em que o caractere da posicao N vale "1" quando o
3892:     * campo N desta lista e obrigatorio NESTA operacao
3893:     * (BO.CampoObrigatorio). Sem mascara carregada nada e' obrigatorio e o
3894:     * metodo devolve "OK" pintando tudo de azul - comportamento neutro.
3895:     *
3896:     * A lista de 69 posicoes e a ORDEM dela sao regra de negocio: e' a
3897:     * mascara que as indexa, logo reordenar ou "compactar" os indices vagos
3898:     * muda qual campo cada "1" da mascara torna obrigatorio (regra #17 -
3899:     * transcrever, nunca reescrever). Por isso os indices sem campo proprio
3900:     * (membros de grupo de CheckBox, conferidos pelo rotulo do grupo) ficam
3901:     * EXPLICITOS na lista, com caminho vazio, em vez de omitidos.
3902:     *
3903:     * DUAS PECULIARIDADES DO LEGADO, PRESERVADAS DE PROPOSITO:
3904:     *
3905:     * 1. O indice 65 ("Outras Receitas") le a mascara na posicao 69, nao na
3906:     *    65 - "Substr(Nvl(crSigOpCdI.JOB_MV_OBR, []), 69, 1)" esta escrito
3907:     *    literalmente assim no SCX.
3908:     *
3909:     * 2. As duas guardas que deveriam DISPENSAR os campos de equipe quando o
3910:     *    bloco esta oculto estao escritas no SCX como
3911:     *    "If InList(22, 23, 24, 25, 26, 27, 28) And Not ...cntEmp1.Visible" -
3912:     *    sem "lnCnt" como primeiro argumento. InList(22, 23, ..., 28) testa
3913:     *    se 22 esta em {23..28}, ou seja e' SEMPRE .F., e a dispensa nunca
3914:     *    acontece no legado. Reproduzido como esta (e nao "corrigido"):
3915:     *    ativar a dispensa mudaria quais campos bloqueiam o retorno, que e'
3916:     *    justamente a regra que esta mascara existe para definir. A terceira
3917:     *    InList do mesmo bloco traz "lnCnt" e funciona - e' ela que pinta
3918:     *    tambem o campo de NOME da linha de equipe.
3919:     *
3920:     * PUBLIC: chamado por BINDEVENT nos LostFocus dos campos (regra #3) e
3921:     * por CmdRetornarClick.
3922:     *==========================================================================
3923:     PROCEDURE ChecarCamposObrigatorios()
3924:         LOCAL loc_cRet, loc_lOks, loc_nI, loc_oBO, loc_lObrig, loc_oErro
3925:         LOCAL ARRAY loc_aCpo[69]
3926: 
3927:         loc_cRet = "OK"
3928: 
3929:         *-- RETURN fora do TRY (regra #1)
3930:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
3931:             RETURN loc_cRet
3932:         ENDIF
3933:         loc_oBO = THIS.this_oBusinessObject
3934: 
3935:         *-- Caminhos relativos a THIS.pgf_4c_Job, na MESMA ordem do laCpo
3936:         *-- legado. "" = indice sem campo proprio (membro de grupo).
3937:         *-- Pagina 1 (Briefing)
3938:         loc_aCpo[01] = "Page1.txt_4c__01_001"              && Apresentacao
3939:         loc_aCpo[02] = "Page1.txt_4c__01_002"              && Orcamento
3940:         loc_aCpo[03] = "Page1.txt_4c__01_017"              && Periodo do Evento
3941:         loc_aCpo[04] = "Page1.txt_4c__01_019"              && Periodo de Montagem
3942:         loc_aCpo[05] = "Page1.obj_4c_Get_01_022"           && Publico Estimado
3943:         loc_aCpo[06] = "Page1.obj_4c_Get_01_023"           && Budget Estimado
3944:         loc_aCpo[07] = "Page1.obj_4c_Get_01_021"           && Local do Evento
3945:         loc_aCpo[08] = "Page1.obj_4c_Get_01_003"           && Sobre o que estamos falando
3946:         loc_aCpo[09] = "Page1.obj_4c_Get_01_004"           && Historico
3947:         loc_aCpo[10] = "Page1.obj_4c_Get_01_005"           && Contexto Mercadologico
3948:         loc_aCpo[11] = "Page1.obj_4c_Get_01_006"           && Cenario
3949:         loc_aCpo[12] = "Page1.obj_4c_Get_01_007"           && Target
3950:         loc_aCpo[13] = "Page1.obj_4c_Get_01_008"           && O problema
3951:         *-- Pagina 2 (Briefing Continuacao)
3952:         loc_aCpo[14] = "Page2.obj_4c_Get_01_009"           && Desafio
3953:         loc_aCpo[15] = "Page2.obj_4c_Get_01_010"           && Objetivos
3954:         loc_aCpo[16] = "Page2.obj_4c_Get_01_011"           && Tom de voz
3955:         loc_aCpo[17] = "Page2.obj_4c_Get_01_012"           && Inspiracoes
3956:         loc_aCpo[18] = "Page2.obj_4c_Get_01_013"           && Cliente
3957:         loc_aCpo[19] = "Page2.obj_4c_Get_01_014"           && Sugestoes
3958:         loc_aCpo[20] = "Page2.obj_4c_Get_01_015"           && Comunicacao
3959:         loc_aCpo[21] = "Page2.obj_4c_Get_01_016"           && Infos do local do evento
3960:         *-- Pagina 3 (Informacoes Gerais) - bloco de equipe 1
3961:         loc_aCpo[22] = "Page3.cnt_4c_Emp1.txt_4c__01_024"  && Atendimento
3962:         loc_aCpo[23] = "Page3.cnt_4c_Emp1.txt_4c__01_025"  && Comercial
3963:         loc_aCpo[24] = "Page3.cnt_4c_Emp1.txt_4c__01_028"  && Arquiteto
3964:         loc_aCpo[25] = "Page3.cnt_4c_Emp1.txt_4c__01_026"  && Gerencia de Projeto
3965:         loc_aCpo[26] = "Page3.cnt_4c_Emp1.txt_4c__01_029"  && Orcamento
3966:         loc_aCpo[27] = "Page3.cnt_4c_Emp1.txt_4c__01_027"  && Criacao
3967:         loc_aCpo[28] = "Page3.cnt_4c_Emp1.txt_4c__01_030"  && Montagem
3968:         *-- Pagina 3 - bloco de equipe 2
3969:         loc_aCpo[29] = "Page3.cnt_4c_Emp2.txt_4c__01_031"  && Lider de Projeto
3970:         loc_aCpo[30] = "Page3.cnt_4c_Emp2.txt_4c__01_032"  && Atendimento
3971:         loc_aCpo[31] = "Page3.cnt_4c_Emp2.txt_4c__01_035"  && Planejamento
3972:         loc_aCpo[32] = "Page3.cnt_4c_Emp2.txt_4c__01_033"  && Comercial
3973:         loc_aCpo[33] = "Page3.cnt_4c_Emp2.txt_4c__01_036"  && Producao
3974:         loc_aCpo[34] = "Page3.cnt_4c_Emp2.txt_4c__01_034"  && Criacao
3975:         loc_aCpo[35] = "Page3.cnt_4c_Emp2.txt_4c__01_037"  && Producao Financeira
3976:         *-- Pagina 3 - grupos de CheckBox (conferidos pelo rotulo da secao)
3977:         loc_aCpo[36] = "Page3.lbl_4c_Lbl_02_003"           && Tipo de Projeto
3978:         loc_aCpo[37] = ""                                  && Concorrencia
3979:         loc_aCpo[38] = ""                                  && Licitacao
3980:         loc_aCpo[39] = ""                                  && Proprietario
3981:         loc_aCpo[40] = "Page3.lbl_4c_Lbl_02_004"           && Tipo de Desenvolvimento
3982:         loc_aCpo[41] = ""                                  && Producao

*-- Linhas 4163 a 4225:
4163:         CATCH TO loc_oErro
4164:             MsgErro(loc_oErro.Message + CHR(13) + ;
4165:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4166:                     "Procedure: " + loc_oErro.Procedure, "Erro em ChecarCamposObrigatorios")
4167:         ENDTRY
4168: 
4169:         RETURN loc_cRet
4170:     ENDPROC
4171: 
4172:     *==========================================================================
4173:     * AplicarTitulosPersonalizados - Transcricao de "PROCEDURE carregatits"
4174:     * (titulos de aba/secao) mais o unico site de job_mv_cpo que o SCX usa
4175:     * (o rotulo do "Briefing Extra", dentro de carregacabs).
4176:     *
4177:     * Cada titulo vive num bloco de 50 caracteres numa POSICAO FIXA de
4178:     * SigOpCdI.job_mv_tit, e o legado so sobrescreve o Caption quando vem
4179:     * texto ("If Not Empty(...)") - sem parametrizacao a tela fica com os
4180:     * captions transcritos do SCX. Mesma postura aqui.
4181:     *
4182:     * A posicao 551 existe no legado e esta COMENTADA la ("Nao Colocado na
4183:     * Tela Ainda"); nao ha controle para ela e por isso nao aparece aqui.
4184:     *==========================================================================
4185:     PROTECTED PROCEDURE AplicarTitulosPersonalizados()
4186:         LOCAL loc_oBO, loc_cTexto, loc_oErro
4187: 
4188:         *-- RETURN fora do TRY (regra #1)
4189:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4190:             RETURN
4191:         ENDIF
4192:         loc_oBO = THIS.this_oBusinessObject
4193: 
4194:         TRY
4195:             *-- 101: Caption da Page1 e, com sufixo, da Page2
4196:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(101)
4197:             IF !EMPTY(loc_cTexto)
4198:                 THIS.pgf_4c_Job.Page1.Caption = loc_cTexto
4199:                 THIS.pgf_4c_Job.Page2.Caption = loc_cTexto + " Continua" + ;
4200:                                                 CHR(231) + CHR(227) + "o"
4201:             ENDIF
4202: 
4203:             *-- 151 / 201: rotulos dos dois blocos de equipe da Page3
4204:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(151)
4205:             IF !EMPTY(loc_cTexto)
4206:                 THIS.pgf_4c_Job.Page3.cnt_4c_Emp1.lbl_4c_Lbl_02_001.Caption = loc_cTexto
4207:             ENDIF
4208: 
4209:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(201)
4210:             IF !EMPTY(loc_cTexto)
4211:                 THIS.pgf_4c_Job.Page3.cnt_4c_Emp2.lbl_4c_Lbl_02_002.Caption = loc_cTexto
4212:             ENDIF
4213: 
4214:             *-- 251 / 301: secoes "Tipo de Projeto" e "Tipo de Desenvolvimento"
4215:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(251)
4216:             IF !EMPTY(loc_cTexto)
4217:                 THIS.pgf_4c_Job.Page3.lbl_4c_Lbl_02_003.Caption = loc_cTexto
4218:             ENDIF
4219: 
4220:             loc_cTexto = loc_oBO.ObterTituloPersonalizado(301)
4221:             IF !EMPTY(loc_cTexto)
4222:                 THIS.pgf_4c_Job.Page3.lbl_4c_Lbl_02_004.Caption = loc_cTexto
4223:             ENDIF
4224: 
4225:             *-- 351: secao "Infos Clientes" da Page4

*-- Linhas 4260 a 4381:
4260:         CATCH TO loc_oErro
4261:             MsgErro(loc_oErro.Message + CHR(13) + ;
4262:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4263:                     "Procedure: " + loc_oErro.Procedure, "Erro em AplicarTitulosPersonalizados")
4264:         ENDTRY
4265:     ENDPROC
4266: 
4267:     *==========================================================================
4268:     * AplicarVisibilidadeEquipes - Mostra/esconde os dois blocos de equipe da
4269:     * Page3 conforme SigCdEmp.divnotas da empresa do movimento. Transcricao
4270:     * do "Do Case" do Init legado:
4271:     *
4272:     *   Case (lnEmp = 2) && Um      -> cntEmp1 visivel, cntEmp2 oculto
4273:     *   Case (lnEmp = 3) && Dois    -> cntEmp2 assume o Left de cntEmp1,
4274:     *                                  cntEmp1 oculto, cntEmp2 visivel
4275:     *   Case (lnEmp = 4) && Nenhuma -> os dois ocultos
4276:     *
4277:     * Nao ha "Otherwise": com divnotas 1 (ou qualquer outro valor) o legado
4278:     * deixa os dois blocos como nasceram, e e' o que acontece aqui.
4279:     *
4280:     * TEM DE RODAR DEPOIS DE TornarControlesVisiveis(), que forca
4281:     * Visible = .T. em tudo e apagaria esta regra - mesma armadilha
4282:     * documentada para toda regra de visibilidade por modo.
4283:     *==========================================================================
4284:     PROTECTED PROCEDURE AplicarVisibilidadeEquipes()
4285:         LOCAL loc_oPag, loc_nDiv, loc_oErro
4286: 
4287:         *-- RETURN fora do TRY (regra #1)
4288:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
4289:             RETURN
4290:         ENDIF
4291: 
4292:         TRY
4293:             loc_oPag = THIS.pgf_4c_Job.Page3
4294:             loc_nDiv = THIS.this_oBusinessObject.this_nDivNotas
4295: 
4296:             DO CASE
4297:                 CASE loc_nDiv = 2
4298:                     loc_oPag.cnt_4c_Emp1.Visible = .T.
4299:                     loc_oPag.cnt_4c_Emp2.Visible = .F.
4300: 
4301:                 CASE loc_nDiv = 3
4302:                     loc_oPag.cnt_4c_Emp2.Left    = loc_oPag.cnt_4c_Emp1.Left
4303:                     loc_oPag.cnt_4c_Emp1.Visible = .F.
4304:                     loc_oPag.cnt_4c_Emp2.Visible = .T.
4305: 
4306:                 CASE loc_nDiv = 4
4307:                     loc_oPag.cnt_4c_Emp1.Visible = .F.
4308:                     loc_oPag.cnt_4c_Emp2.Visible = .F.
4309:             ENDCASE
4310:         CATCH TO loc_oErro
4311:             MsgErro(loc_oErro.Message + CHR(13) + ;
4312:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4313:                     "Procedure: " + loc_oErro.Procedure, "Erro em AplicarVisibilidadeEquipes")
4314:         ENDTRY
4315:     ENDPROC
4316: 
4317:     *==========================================================================
4318:     * CmdRetornarClick - Fecha o dialogo de Complementos do Job (legado:
4319:     * SIGOPJOB.cmdRetornar.btnRetornar.Click). Em INCLUIR/ALTERAR, ANTES de
4320:     * fechar: remove da grade "Fontes Pagadoras" as linhas em branco deixadas
4321:     * pela edicao - transcricao de "Delete From crSigMvJbI Where Empty(
4322:     * JBI_Fontes) Or Empty(JBI_Modelos)" - e GRAVA o complemento (FormParaBO +
4323:     * BO.Salvar() + BO.PersistirFontes()).
4324:     *
4325:     * O legado nao precisa gravar aqui: o TextBox ja esta ligado por
4326:     * ControlSource ao cursor BUFFERED do form pai, e o TableUpdate acontece
4327:     * quando o movimento inteiro e salvo (fora deste dialogo). Nesta
4328:     * arquitetura em camadas o BO grava com SQLEXEC explicito, e so ha um
4329:     * ponto de saida (Retornar) para persistir - fechar sem gravar perderia
4330:     * tudo o que foi digitado. Em VISUALIZAR fecha direto, sem gravar nada
4331:     * (igual ao legado, que tambem so limpa a grade e fecha).
4332:     *
4333:     * Se Salvar()/PersistirFontes() falhar, o dialogo NAO fecha (a falha ja
4334:     * foi exibida pelo proprio BO - regra "CATCH nunca silencioso" /
4335:     * "ExibirFalha") e o usuario pode corrigir e tentar de novo.
4336:     *
4337:     * PUBLIC (BINDEVENT exige - regra #3). THIS.Release() dispara Destroy()
4338:     * na cadeia de heranca, que reabilita THIS.this_oFormPai (equivalente ao
4339:     * "PROCEDURE Release / ThisForm.ParentForm.Enabled = .t." do SCX legado).
4340:     *==========================================================================
4341:     PROCEDURE CmdRetornarClick()
4342:         LOCAL loc_cAlias, loc_lEmEdicao, loc_lSalvou, loc_lProsseguir, loc_oErro
4343:         loc_lEmEdicao   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
4344:         loc_lSalvou     = .T.
4345:         loc_lProsseguir = .T.
4346: 
4347:         *-- Campos obrigatorios em falta: o legado reconfere ChecaObrigs aqui
4348:         *-- (nao confia na marcacao deixada pelos LostFocus) e, se houver
4349:         *-- pendencia, PERGUNTA se o usuario quer corrigir agora. Respondendo
4350:         *-- SIM ele devolve .f. e a tela NAO fecha nem grava - os campos ficam
4351:         *-- vermelhos para conferencia. Respondendo NAO, segue e fecha.
4352:         *-- MsgConfirma devolve LOGICAL, nunca 6 (regra #7).
4353:         IF loc_lEmEdicao
4354:             IF THIS.ChecarCamposObrigatorios() = "ERRO"
4355:                 IF MsgConfirma("Existem Campos Obrigat" + CHR(243) + "rios Que N" + CHR(227) + ;
4356:                                "o Foram Preenchidos!!!" + CHR(13) + ;
4357:                                "Esses Campos Est" + CHR(227) + "o Marcados em Vermelho Para Verifica" + ;
4358:                                CHR(231) + CHR(227) + "o" + CHR(13) + ;
4359:                                "E N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
4360:                                "vel Salvar a Movimenta" + CHR(231) + CHR(227) + "o Sem Preench" + ;
4361:                                CHR(234) + "-los." + CHR(13) + ;
4362:                                "Deseja Corrigir Esses Campos Agora?", ;
4363:                                "Aten" + CHR(231) + CHR(227) + "o!!!")
4364:                     loc_lProsseguir = .F.
4365:                 ENDIF
4366:             ENDIF
4367:         ENDIF
4368: 
4369:         *-- RETURN fora do TRY (regra #1)
4370:         IF !loc_lProsseguir
4371:             RETURN
4372:         ENDIF
4373: 
4374:         TRY
4375:             IF loc_lEmEdicao AND VARTYPE(THIS.this_oBusinessObject) = "O"
4376:                 loc_cAlias = THIS.this_oBusinessObject.this_cCursorFontes
4377:                 IF USED(loc_cAlias)
4378:                     SELECT (loc_cAlias)
4379:                     DELETE FOR EMPTY(jbi_fontes) OR EMPTY(jbi_modelos)
4380:                     GO BOTTOM
4381:                 ENDIF

*-- Linhas 4391 a 4416:
4391:             loc_lSalvou = .F.
4392:             MsgErro(loc_oErro.Message + CHR(13) + ;
4393:                     "Linha: "     + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
4394:                     "Procedure: " + loc_oErro.Procedure, "Erro em CmdRetornarClick")
4395:         ENDTRY
4396: 
4397:         IF loc_lSalvou
4398:             THIS.Release()
4399:         ENDIF
4400:     ENDPROC
4401: 
4402:     *==========================================================================
4403:     * Destroy - Reabilita o form pai (equivalente ao Click legado de
4404:     * cmdRetornar, repetido aqui para cobrir fechamento pelo X da janela ou
4405:     * ESC) antes de delegar para FormBase.Destroy (libera this_oBusinessObject
4406:     * e restaura o menu principal).
4407:     *==========================================================================
4408:     PROCEDURE Destroy()
4409:         IF VARTYPE(THIS.this_oFormPai) = "O"
4410:             THIS.this_oFormPai.Enabled = .T.
4411:         ENDIF
4412: 
4413:         DODEFAULT()
4414:     ENDPROC
4415: 
4416: ENDDEFINE

