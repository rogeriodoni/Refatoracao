# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [METODO-INEXISTENTE] Metodo 'THIS.GravarTodosOsTipos()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ConfirmarTransacao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Opt_leitor' (parent: SIGOPCPE): Top original=209 vs migrado 'obj_4c_Opt_leitor' Top=3 (diff=206px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_leitor' (parent: SIGOPCPE): Left original=445 vs migrado 'obj_4c_Opt_leitor' Left=5 (diff=440px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGOPCPE.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2305 linhas total):

*-- Linhas 22 a 156:
22: * FASE 3/8: Estrutura base do Form - DEFINE CLASS com as propriedades
23: * visuais transcritas do dump (Width=800/Height=355/BorderStyle=2/
24: * DataSession=2/TitleBar=0 - ver SECAO 2 do dump para SIGOPCPE),
25: * Init()/InicializarForm() e dois blocos:
26: *   - ConfigurarCabecalho() - cntSombra/lblSombra/lblTitulo do legado,
27: *     transcrito COM os valores exatos do dump (Left=7 no cntSombra,
28: *     Top=18/17 nos labels - nao e o padrao canonico injetado da regra
29: *     CLAUDE.md #11, que e para forms CRUD sem essa faixa no SCX; aqui a
30: *     faixa JA EXISTE no legado e e so transcrita).
31: *   - ConfigurarBotoes() - container cnt_4c_Botoes na posicao dos botoes
32: *     Ok/cancela do legado (Left=649..800, Top=3), deixado VAZIO
33: *     propositalmente (os botoes entrariam na Fase 4).
34: *
35: * FASE 4/8: o template generico daquela fase pede "Grid + botoes CRUD
36: * (Page1)" - NAO SE APLICA a este form. O legado (ver layout.json/
37: * analise.json: grid.temGrid=false, zero AddCursor/pColuna/Grade) e um
38: * dialogo OPERACIONAL FLAT de configuracao de hardware, sem PageFrame e
39: * sem lista de registros - so os 2 botoes Ok/cancela (ver
40: * comportamento.json). Inventar Page1/Grid/5 botoes CRUD (Incluir/
41: * Visualizar/Alterar/Excluir/Buscar) violaria o PILAR 1 (UX identica ao
42: * legado). O trabalho real daquela fase foi completar ConfigurarBotoes()
43: * com os 2 botoes reais: cmd_4c_Confirmar (Ok, Left=649 absoluto /
44: * Left=0 relativo ao container) e cmd_4c_Encerrar (cancela, Left=725
45: * absoluto / Left=76 relativo).
46: *
47: * FASE 5/8: ConfigurarCamposPrincipais() - COLUNA
48: * ESQUERDA, 14 dos 31 controles de dados. O template desta fase pede
49: * "primeiros 50% dos campos da Page2 + container cnt_4c_Cabecalho"; aqui
50: * nao existe Page2 (form FLAT) e o cnt_4c_Cabecalho ja foi entregue na
51: * Fase 3, entao o que esta fase entrega sao os campos, divididos pelo
52: * limite ESTRUTURAL da tela: a coluna esquerda (Left <= 320) eh o bloco
53: * de configuracao da porta serial, SEMPRE visivel no legado:
54: *   Say6/Cmb_Tipo, Say1/Spinner1, Say2/Cmb_Hand, Say3/Get_Set,
55: *   Say4/chk_dtr, Say5/chk_rts, Say7/Get_inbuf
56: * Os Top do SCX entram ABSOLUTOS (sem o "+29" dos forms CRUD - nao ha
57: * PageFrame) e o ControlSource de cada campo eh TRANSCRITO do SCX, com o
58: * alias do cursor novo (crSigSyCom -> cursor_4c_Dados): a ligacao campo
59: * <-> cursor eh o proprio mecanismo da tela no legado. Para isso o
60: * cursor eh aberto e posicionado ANTES de criar os campos, pelo
61: * SIGOPCPEBO.CarregarDados() chamado no InicializarForm - binding para
62: * alias fechado derrubaria o Init (CLAUDE.md regra #41).
63: *
64: * FASE 6/8 (ESTE ARQUIVO): ConfigurarCamposSecundarios() - COLUNA
65: * DIREITA, os 17 controles restantes: Say8/Get_outbuf, Say9/Get_inmode,
66: * Say11, Say10/Get_inlen (bloco numerico sempre visivel) e os dois
67: * blocos que o Init/InteractiveChange legado mostram/escondem conforme o
68: * Tipo escolhido - Say12/Get_TpLeChq, Say14/Chk_Bompara, Say15/
69: * chk_nominal, Say16/chk_cruzado (cheque) e Say13/Opt_leitor (leitor de
70: * codigo de barra). Todos nascem com .Visible = .T. no AddObject e quem
71: * decide a visibilidade de verdade eh AplicarVisibilidadePorTipo(),
72: * chamado no fim do InicializarForm - DEPOIS do TornarControlesVisiveis,
73: * que forca .T. em tudo. Say13 tem ZOrderSet = 12 no dump - bookkeeping
74: * do Form Designer, DESCARTADO (CLAUDE.md regra #33). Opt_leitor eh OptionGroup
75: * com ControlSource numerico direto (tpbarras numeric(1,0)): Value = indice
76: * do botao marcado (2 = Teclado, default do SCX), sem +1/-1 (regra #45);
77: * Option1/Option2.Value do dump (0/1) sao residuo do Form Designer e NAO
78: * sao transcritos nos botoes individuais - so o Value do GRUPO manda.
79: *
80: * Esta fase tambem entrega o que faz esses campos FUNCIONAREM, porque a
81: * regra governa os campos que ela acrescenta:
82: *   - ConfigurarEventos() - BINDEVENT do unico evento de campo do dump
83: *     (Cmb_Tipo.InteractiveChange).
84: *   - ValidarTipo() - transcricao desse InteractiveChange: SEEK(PADR(
85: *     valor,20)) na tag PesqTipo, Refresh so quando acha a linha, e
86: *     alternancia dos blocos condicionais sempre.
87: *   - AplicarVisibilidadePorTipo() - o bloco de esconder/reexibir que o
88: *     legado repete no Init e no InteractiveChange, com fonte unica.
89: * Nao ha lookup a implementar: o dump nao tem fwBusca*, mAddColuna,
90: * sigacess nem Acesso*, e nenhum campo tem Valid/When/LostFocus - o
91: * unico When (Chk_Bompara) esta com o corpo VAZIO no legado.
92: *
93: * FASE 7: os eventos dos DOIS unicos botoes do legado, que sao tambem os
94: * dois unicos Click do dump inteiro:
95: *   - BtnConfirmarClick() - Ok.Click: grava o cursor INTEIRO em SigSyCom
96: *     (GravarTodosOsTipos, equivalente ao poDataMgr.Update), confirma a
97: *     transacao (ConfirmarTransacao, equivalente ao Commit() < 1) e fecha.
98: *   - BtnEncerrarClick() - cancela.Click: Release, descartando o que
99: *     estiver so no cursor.
100: * O legado NAO tem barra CRUD (classe base [form] puro, sem frmcadastro,
101: * sem Grupo_Op, sem pcEscolha), por isso esta fase nao entrega
102: * BtnIncluirClick/BtnAlterarClick/BtnVisualizarClick/BtnExcluirClick -
103: * nao existe botao para eles no SCX e inventar um violaria o PILAR 1.
104: *
105: * FASE 8/8 (ESTE ARQUIVO): eventos auxiliares e consolidacao. O que entra:
106: *   - CarregarLista() - FUNIL unico de carga do cursor de trabalho
107: *     (SIGOPCPEBO.CarregarDados + reposicionamento + repintar guardado).
108: *     O InicializarForm passou a chamar o funil em vez do BO direto.
109: *   - BOParaForm() - properties do BO -> os 15 controles de dados + o
110: *     seletor Cmb_Tipo, com as conversoes de tipo explicitas. Passou a ser
111: *     o repintar do ValidarTipo, antes feito a mao ali dentro.
112: *   - FormParaBO() - o inverso: tela -> linha corrente do cursor (REPLACE)
113: *     -> properties do BO. Chamado pelo BtnConfirmarClick antes de gravar.
114: *   - BtnCancelarClick() - o SIGOPCPE.cancela.Click sob o nome do objeto
115: *     legado, delegando ao BtnEncerrarClick (que eh o nome do objeto do
116: *     migrado, cmd_4c_Encerrar, e eh quem o BINDEVENT liga).
117: *
118: * O template desta fase pede tambem BtnBuscarClick, BtnSalvarClick,
119: * HabilitarCampos, LimparCampos e AjustarBotoesPorModo. Os cinco sao
120: * convencao de form CRUD (frmcadastro) e NAO SE APLICAM a esta tela, pelo
121: * que o dump mostra:
122: *   - BtnBuscarClick  - nao ha botao Buscar nem lista para filtrar: os DOIS
123: *     unicos CommandButton do SCX sao Ok e cancela.
124: *   - BtnSalvarClick  - o botao de gravar do legado chama-se Ok / Caption
125: *     "Confirmar", e o handler dele eh o BtnConfirmarClick (Fase 7). Criar
126: *     um segundo nome para a mesma acao seria inventar botao.
127: *   - HabilitarCampos - o legado nao tem modo somente-leitura: os campos
128: *     estao sempre editaveis (nenhum Valid, nenhum ReadOnly, nenhum
129: *     Enabled = .F. no dump; o unico When, do Chk_Bompara, tem o corpo
130: *     VAZIO). O que o legado alterna eh VISIBILIDADE por tipo de
131: *     dispositivo, e isso eh o AplicarVisibilidadePorTipo (Fase 6).
132: *   - LimparCampos    - nao ha modo de inclusao a limpar: as 6 linhas
133: *     existem sempre (o Init legado as semeia) e o usuario so escolhe qual
134: *     editar. Zerar campos aqui apagaria configuracao gravada.
135: *   - AjustarBotoesPorModo - nao ha modos (nao existe pcEscolha no dump):
136: *     Confirmar e Encerrar ficam habilitados do inicio ao fim.
137: *
138: * Destroy() fecha o cursor_4c_Dados (equivalente ao ThisForm.poDataMgr.
139: * Release do legado - aqui nao ha objeto de conexao per-form, so cursor).
140: *==============================================================================
141: 
142: DEFINE CLASS FormSIGOPCPE AS FormBase
143: 
144:     *--------------------------------------------------------------------------
145:     * Propriedades visuais do form (transcritas do SIGOPCPE.SCX, sem escala -
146:     * form OPERACIONAL isolado, nao segue o padrao frmcadastro 1000x600)
147:     *--------------------------------------------------------------------------
148:     this_cMensagemErro = ""
149:     Width        = 800
150:     Height       = 355
151:     DataSession  = 2
152:     BorderStyle  = 2
153:     AutoCenter   = .T.
154:     ShowTips     = .T.
155:     ControlBox   = .F.
156:     MaxButton    = .F.

*-- Linhas 169 a 318:
169:     * Propriedade de estado (equivalente ao Cmb_Tipo.Value do legado - o
170:     * tipo de dispositivo escolhido, usado para reposicionar o cursor via
171:     * SEEK). O cbo_4c_Cmb_Tipo ja existe desde a Fase 5; o preenchimento
172:     * desta propriedade acompanha o InteractiveChange, na Fase 7.
173:     *--------------------------------------------------------------------------
174:     this_cTipoSelecionado = ""
175: 
176:     *==========================================================================
177:     * Init - Cria o Business Object e delega a inicializacao ao FormBase.Init
178:     *==========================================================================
179:     FUNCTION Init()
180:         THIS.this_oBusinessObject = CREATEOBJECT("SIGOPCPEBO")
181:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
182:             MsgErro("Erro ao criar SIGOPCPEBO.", "Erro")
183:             RETURN .F.
184:         ENDIF
185: 
186:         RETURN DODEFAULT()
187:     ENDFUNC
188: 
189:     *==========================================================================
190:     * InicializarForm - Monta a estrutura base do form
191:     * Deve retornar .T. em sucesso e .F. em falha (contrato do FormBase.Init)
192:     *==========================================================================
193:     PROTECTED PROCEDURE InicializarForm()
194:         LOCAL loc_lSucesso, loc_lProsseguir, loc_oErro
195: 
196:         loc_lSucesso    = .F.
197:         loc_lProsseguir = .T.
198: 
199:         TRY
200:             THIS.Picture = gc_4c_CaminhoFramework + "imagens\new_background.jpg"
201: 
202:             THIS.ConfigurarCabecalho()
203: 
204:             THIS.ConfigurarBotoes()
205: 
206:             *-- O cursor de trabalho tem de existir e estar POSICIONADO antes
207:             *-- de ConfigurarCamposPrincipais: os campos sao ligados a ele por
208:             *-- ControlSource (como no legado) e binding para alias fechado
209:             *-- derruba o Init inteiro (CLAUDE.md regra #41). Equivale ao
210:             *-- AddCursor + ReQuery + Index + Go Top que o Init legado executa
211:             *-- ANTES de qualquer Refresh de controle.
212:             *--
213:             *-- Falhando a carga, a tela NAO abre - mesmo comportamento do
214:             *-- legado, que faz [Return .f.] quando o fSqlConector nao
215:             *-- conecta. CarregarLista/CarregarDados ja exibiram a mensagem,
216:             *-- por isso aqui nao se repete (CLAUDE.md regra #20).
217:             *--
218:             *-- FASE 8: a chamada passa pelo FUNIL CarregarLista() em vez de
219:             *-- ir direto ao BO. Aqui os controles ainda NAO existem, entao o
220:             *-- funil carrega, indexa, semeia e posiciona o cursor e PULA o
221:             *-- repintar - o combo fica em branco, que eh o estado real do
222:             *-- legado na abertura (ver cabecalho de CarregarLista).
223:             IF !THIS.CarregarLista()
224:                 loc_lProsseguir = .F.
225:             ENDIF
226: 
227:             IF loc_lProsseguir
228:                 THIS.ConfigurarCamposPrincipais()
229: 
230:                 THIS.ConfigurarCamposSecundarios()
231: 
232:                 THIS.TornarControlesVisiveis(THIS)
233: 
234:                 *-- Eventos dos campos entregues nas Fases 5/6: o
235:                 *-- Cmb_Tipo.InteractiveChange do legado, que reposiciona o
236:                 *-- cursor e comanda a visibilidade dos dois blocos
237:                 *-- condicionais.
238:                 THIS.ConfigurarEventos()
239: 
240:                 *-- ULTIMO bloco do Init legado: esconde os 10 controles
241:                 *-- condicionais e reexibe conforme o Tipos da linha
242:                 *-- corrente. Roda DEPOIS do TornarControlesVisiveis, que
243:                 *-- forca .Visible = .T. em TODOS os controles do form -
244:                 *-- invertido, os blocos abririam sempre visiveis.
245:                 THIS.AplicarVisibilidadePorTipo()
246: 
247:                 *-- O [ThisForm.Cmb_Tipo.SetFocus] que fecha o Init legado
248:                 *-- nao se transcreve como chamada: SetFocus em controle de
249:                 *-- form ainda nao exibido estoura DENTRO deste TRY e
250:                 *-- derrubaria a tela. O efeito visivel eh o mesmo pelo
251:                 *-- .TabIndex = 1 do cbo_4c_Cmb_Tipo, que o torna o
252:                 *-- primeiro controle a receber o foco na exibicao.
253: 
254:                 loc_lSucesso = .T.
255:             ENDIF
256: 
257:         CATCH TO loc_oErro
258:             THIS.this_cMensagemErro = loc_oErro.Message
259:             MsgErro(loc_oErro.Message + CHR(13) + ;
260:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
261:                     "Procedure: " + loc_oErro.Procedure, ;
262:                     "Erro em FormSIGOPCPE.InicializarForm")
263:         ENDTRY
264: 
265:         RETURN loc_lSucesso
266:     ENDPROC
267: 
268:     *==========================================================================
269:     * ConfigurarCabecalho - Container cinza com titulo (cntSombra legado)
270:     * Transcrito EXATO do dump (SECAO 2 - SIGOPCPE.cntSombra/lblSombra/
271:     * lblTitulo): Top=0 Left=7 Width=800 Height=80 BackColor=RGB(100,100,100).
272:     * As duas labels tem o Caption sobrescrito pelo Init legado
273:     * ("ThisForm.cntSombra.lblSombra.Caption = ThisForm.Caption") - aqui
274:     * atribuido direto, sem passar por caption placeholder do dump
275:     * ("Cadastro de Testes", resto de outro form usado como base no Form
276:     * Designer do legado).
277:     *==========================================================================
278:     PROTECTED PROCEDURE ConfigurarCabecalho()
279:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
280:         WITH THIS.cnt_4c_Cabecalho
281:             .Top         = 0
282:             .Left        = 7
283:             .Width       = THIS.Width
284:             .Height      = 80
285:             .BackStyle   = 1
286:             .BackColor   = RGB(100, 100, 100)
287:             .BorderWidth = 0
288:             .Visible     = .T.
289:         ENDWITH
290: 
291:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
292:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
293:             .Top         = 18
294:             .Left        = 10
295:             .Width       = 769
296:             .Height      = 40
297:             .FontName    = "Tahoma"
298:             .FontSize    = 18
299:             .FontBold    = .T.
300:             .FontUnderline = .F.
301:             .ForeColor   = RGB(0, 0, 0)
302:             .BackStyle   = 0
303:             .WordWrap    = .T.
304:             .AutoSize    = .F.
305:             .Alignment   = 0
306:             .Caption     = THIS.Caption
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
311:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
312:             .Top         = 17
313:             .Left        = 10
314:             .Width       = 769
315:             .Height      = 46
316:             .FontName    = "Tahoma"
317:             .FontSize    = 18
318:             .FontBold    = .T.

*-- Linhas 340 a 387:
340:     * 76+75=151). Caption/Picture canonicos (regra CLAUDE.md #10):
341:     * Confirmar = cadastro_salvar_60.jpg, Encerrar = cadastro_sair_60.jpg.
342:     *
343:     * BINDEVENT dos Click fica para as Fases 7-8 (guard de conexao do
344:     * Init legado + fluxo de Update/Commit/fGrvSettings do Ok.Click e
345:     * Release do cancela.Click, ver comportamento.json).
346:     *==========================================================================
347:     PROTECTED PROCEDURE ConfigurarBotoes()
348:         THIS.AddObject("cnt_4c_Botoes", "Container")
349:         WITH THIS.cnt_4c_Botoes
350:             .Top         = 0
351:             .Left        = 649
352:             .Width       = 151
353:             .Height      = 85
354:             .BackStyle   = 0
355:             .BorderWidth = 0
356:             .Visible     = .T.
357:         ENDWITH
358: 
359:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Confirmar", "CommandButton")
360:         WITH THIS.cnt_4c_Botoes.cmd_4c_Confirmar
361:             .Top            = 5
362:             .Left           = 0
363:             .Width          = 75
364:             .Height         = 75
365:             .Caption        = "Confirmar"
366:             .Picture        = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
367:             .FontName       = "Comic Sans MS"
368:             .FontSize       = 8
369:             .FontBold       = .T.
370:             .FontItalic     = .T.
371:             .ForeColor      = RGB(90, 90, 90)
372:             .BackColor      = RGB(255, 255, 255)
373:             .Themes         = .F.
374:             .SpecialEffect  = 0
375:             .PicturePosition = 13
376:             .MousePointer   = 15
377:             .WordWrap       = .T.
378:             .AutoSize       = .F.
379:             .Visible        = .T.
380:         ENDWITH
381: 
382:         THIS.cnt_4c_Botoes.AddObject("cmd_4c_Encerrar", "CommandButton")
383:         WITH THIS.cnt_4c_Botoes.cmd_4c_Encerrar
384:             .Top            = 5
385:             .Left           = 76
386:             .Width          = 75
387:             .Height         = 75

*-- Linhas 447 a 578:
447:     * resto eh identico, coluna por coluna.
448:     *
449:     * Pre-requisito INDISPENSAVEL: o cursor ja esta aberto e posicionado
450:     * quando este metodo roda - o InicializarForm chama
451:     * this_oBusinessObject.CarregarDados() ANTES daqui, do mesmo jeito que o
452:     * Init legado faz AddCursor + ReQuery + Index + Go Top antes de qualquer
453:     * Refresh de controle. Sem isso o binding estouraria
454:     * [Alias CURSOR_4C_DADOS is not found] e a tela nao abriria
455:     * (CLAUDE.md regra #41).
456:     *
457:     * O .ControlSource eh a ULTIMA propriedade de cada bloco WITH: o .Value
458:     * que vem antes serve apenas para o controle nascer com o TIPO da coluna
459:     * destino (char -> vazio, numeric -> 0, bit -> logico no cursor); a
460:     * partir do binding quem manda eh o campo do cursor.
461:     *
462:     * EXCECAO: o Cmb_Tipo NAO eh ligado - no dump o ControlSource dele eh
463:     * string VAZIA. Ele nao grava nada, apenas escolhe a linha a posicionar.
464:     *
465:     * Propriedades vindas da CLASSE do Framework (framework.vcx), e nao do
466:     * SCX - o SCX so declara o que sobrescreve, entao o que ele NAO
467:     * declara tem de vir da classe, nunca de palpite
468:     * (docs/FRAMEWORK_class_codigo_fonte.txt):
469:     *   say         -> Height 15, BackStyle 0, ForeColor 90,90,90
470:     *   fwget       -> Height 23, Width 100, Format K, Themes .F.,
471:     *                  DisabledBackColor 192,192,192 / DisabledForeColor 0,0,0
472:     *   fwcombo     -> Height 24, Width 100, Style 2 (dropdown LIST),
473:     *                  Themes .F., DisabledForeColor 0,0,0
474:     *   fwcheckbox  -> Height 17, Width 60, Alignment 0, BackStyle 0,
475:     *                  ForeColor 90,90,90, Themes .F.
476:     * NAO sao atribuidas BackStyle em ComboBox/Spinner nem ForeColor em
477:     * Spinner-grupo: ComboBox e Spinner nao TEM BackStyle (conferido em
478:     * automation\propriedades_baseclasses.txt - CLAUDE.md regra #33).
479:     *
480:     * O label vem SEMPRE antes do seu controle no AddObject: a caixa do
481:     * label eh transparente (BackStyle = 0) e, criada depois, bloquearia
482:     * o clique no campo (CLAUDE.md regra #23).
483:     *==========================================================================
484:     PROTECTED PROCEDURE ConfigurarCamposPrincipais()
485:         LOCAL loc_nI, loc_cTipo
486: 
487:         *----------------------------------------------------------------------
488:         * Say6 "Tipo : " + Cmb_Tipo - escolha do dispositivo
489:         *
490:         * O Cmb_Tipo eh o UNICO controle da tela sem ControlSource tambem no
491:         * legado (ControlSource vazio no dump): ele nao grava nada, apenas
492:         * reposiciona o cursor via SEEK no InteractiveChange. Os 6 itens sao
493:         * os mesmos tipos que o Init legado GARANTE existirem na tabela,
494:         * lidos do BO (SIGOPCPEBO.ObterTipoPorIndice) para nao duplicar aqui
495:         * os literais com CHR() de Balanca (CLAUDE.md regra #4).
496:         *----------------------------------------------------------------------
497:         THIS.AddObject("lbl_4c_Label6", "Label")
498:         WITH THIS.lbl_4c_Label6
499:             .Top       = 110
500:             .Left      = 117
501:             *-- Width = 152 (Left do Cmb_Tipo) - 117: eh o vao que o legado
502:             *-- reservou para este texto. A classe say eh AutoSize = .T. /
503:             *-- Alignment = 0, mas AutoSize eh NO-OP em Label criado por
504:             *-- AddObject (fica nos 100 do default), por isso Width e Height
505:             *-- explicitos e Alignment = 0 (CLAUDE.md regra #23).
506:             .Width     = 35
507:             .Height    = 15
508:             .AutoSize  = .F.
509:             .Alignment = 0
510:             .WordWrap  = .F.
511:             .BackStyle = 0
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .ForeColor = RGB(90, 90, 90)
515:             .Caption   = "Tipo : "
516:             .Visible   = .T.
517:         ENDWITH
518: 
519:         THIS.AddObject("cbo_4c_Cmb_Tipo", "ComboBox")
520:         WITH THIS.cbo_4c_Cmb_Tipo
521:             .Top               = 106
522:             .Left              = 152
523:             .Width             = 168
524:             .Height            = 24
525:             .FontName          = "Tahoma"
526:             .FontSize          = 8
527:             .ForeColor         = RGB(90, 90, 90)
528:             .BorderColor       = RGB(100, 100, 100)
529:             .DisabledForeColor = RGB(0, 0, 0)
530:             .Themes            = .F.
531:             *-- Style = 2 (dropdown list) vem da classe fwcombo; o SCX nao
532:             *-- declara Style neste combo, logo ele HERDA o 2 - o usuario
533:             *-- escolhe na lista e nao digita.
534:             .Style             = 2
535:             .RowSourceType     = 1
536:             .RowSource         = ""
537:             .TabIndex          = 1
538:             *-- Value CHARACTER: o InteractiveChange faz SEEK(This.Value) na
539:             *-- tag PesqTipo (coluna tipos char(20)).
540:             .Value             = ""
541:             .Visible           = .T.
542: 
543:             .Clear()
544:         ENDWITH
545: 
546:         *-- Itens na MESMA ordem dos Insert Into / AddItem do Init legado
547:         FOR loc_nI = 1 TO THIS.this_oBusinessObject.this_nTotalTipos
548:             loc_cTipo = THIS.this_oBusinessObject.ObterTipoPorIndice(loc_nI)
549:             IF !EMPTY(loc_cTipo)
550:                 THIS.cbo_4c_Cmb_Tipo.AddItem(loc_cTipo)
551:             ENDIF
552:         ENDFOR
553: 
554:         *-- ListIndex = 0 (nenhum item pre-selecionado) eh o estado REAL do
555:         *-- legado: o With do Init faz .ListIndex = 1 ANTES do .Clear, e o
556:         *-- Clear zera o ListIndex - entao o combo abre em branco. Por isso
557:         *-- o [If Seek(ThisForm.Cmb_Tipo.value, ...)] logo abaixo falha e o
558:         *-- cursor permanece onde o Go Top o deixou. Explicito aqui para que
559:         *-- o estado inicial seja intencional, e nao acidental.
560:         THIS.cbo_4c_Cmb_Tipo.ListIndex = 0
561: 
562:         *----------------------------------------------------------------------
563:         * Say1 "Porta de Comunicacao : " + Spinner1 - numero da porta COM
564:         *
565:         * Spinner1 eh base class spinner (nao tem classe do Framework), por
566:         * isso Height/Width vem do proprio SCX. Faixa 1..10 tanto pelas
567:         * setas (SpinnerLow/HighValue) quanto pelo teclado (KeyboardLow/
568:         * HighValue), com Value inicial 1 - transcrito do dump.
569:         *----------------------------------------------------------------------
570:         THIS.AddObject("lbl_4c_Label1", "Label")
571:         WITH THIS.lbl_4c_Label1
572:             .Top       = 136
573:             .Left      = 30
574:             .Width     = 122
575:             .Height    = 15
576:             .AutoSize  = .F.
577:             .Alignment = 0
578:             .WordWrap  = .F.

*-- Linhas 891 a 969:
891:     * 17 controles restantes. Quatro deles (Say8/Get_outbuf, Say9/
892:     * Get_inmode, Say11, Say10/Get_inlen) formam o bloco numerico SEMPRE
893:     * visivel do dump; os outros treze pertencem aos dois blocos que o
894:     * Init/Cmb_Tipo.InteractiveChange do legado mostram/escondem conforme
895:     * o Tipo selecionado - cheque (Say12/Get_TpLeChq/Say14/Chk_Bompara/
896:     * Say15/chk_nominal/Say16/chk_cruzado) e leitor de codigo de barra
897:     * (Say13/Opt_leitor). A alternancia de Visible por Tipo fica para a
898:     * Fase 7 (Cmb_Tipo.InteractiveChange) - aqui todos nascem Visible =
899:     * .T., igual aos controles da Fase 5, porque TornarControlesVisiveis
900:     * (chamado no fim do InicializarForm) forca .T. em tudo mesmo; sem a
901:     * logica de reexibicao ainda implementada, esconder agora so
902:     * deixaria os blocos presos ocultos ate a Fase 7.
903:     *
904:     * Mesmas convencoes da Fase 5: Top ABSOLUTO (sem PageFrame, sem +29),
905:     * ControlSource TRANSCRITO do SCX com o alias trocado (crSigSyCom ->
906:     * cursor_4c_Dados), .Value antes do .ControlSource so para semear o
907:     * TIPO da coluna, Width do Label = gap exato ate o Left do controle
908:     * vizinho (mesma convencao da Fase 5 - conferido contra o dump:
909:     * Say13 e a unica label com Width/Height DECLARADOS no SCX, 80/15,
910:     * usados aqui ao inves do gap calculado).
911:     *
912:     * Say11 ("( 0 - Text , 1- Binary )") eh nota solta, sem controle de
913:     * dados vizinho - Width = 170 (texto + margem), sem gap para calcular.
914:     *
915:     * ZOrderSet = 12 do Say13 no dump eh bookkeeping do Form Designer -
916:     * NAO existe em runtime, DESCARTADO (CLAUDE.md regra #33).
917:     *
918:     * Opt_leitor (OptionGroup, ButtonCount = 3): ControlSource direto em
919:     * coluna numerica (tpbarras numeric(1,0)) grava a ORDEM do botao
920:     * marcado - Value = indice 1-based, SEM +1/-1 (CLAUDE.md regra #45).
921:     * O SCX declara Value = 2 (Teclado pre-selecionado). OptionGroup NAO
922:     * tem BorderStyle (so BackStyle) - regra #33, BorderStyle = 0 do dump
923:     * eh DESCARTADO. Option1.Value = 0 / Option2.Value = 1 no dump sao
924:     * residuo do Form Designer (o Value do GRUPO eh quem manda) e NAO
925:     * sao transcritos nos botoes individuais - atribuir Value != 0 num
926:     * Buttons(N) marca TODOS os botoes ao mesmo tempo (regra sobre
927:     * OptionGroup.Buttons(N).Value espurio).
928:     *==========================================================================
929:     PROTECTED PROCEDURE ConfigurarCamposSecundarios()
930:         *----------------------------------------------------------------------
931:         * Say8 "OutBufferMode : " + Get_outbuf - tamanho do buffer de
932:         * transmissao. Value NUMERICO (outbufs numeric(8,0)).
933:         *----------------------------------------------------------------------
934:         THIS.AddObject("lbl_4c_Label8", "Label")
935:         WITH THIS.lbl_4c_Label8
936:             .Top       = 109
937:             .Left      = 361
938:             .Width     = 89
939:             .Height    = 15
940:             .AutoSize  = .F.
941:             .Alignment = 0
942:             .WordWrap  = .F.
943:             .BackStyle = 0
944:             .FontName  = "Tahoma"
945:             .FontSize  = 8
946:             .ForeColor = RGB(90, 90, 90)
947:             .Caption   = "OutBufferMode : "
948:             .Visible   = .T.
949:         ENDWITH
950: 
951:         THIS.AddObject("txt_4c_Outbuf", "TextBox")
952:         WITH THIS.txt_4c_Outbuf
953:             .Top               = 106
954:             .Left              = 450
955:             .Width             = 80
956:             .Height            = 23
957:             .FontName          = "Tahoma"
958:             .FontSize          = 8
959:             .ForeColor         = RGB(90, 90, 90)
960:             .BorderColor       = RGB(100, 100, 100)
961:             .DisabledBackColor = RGB(192, 192, 192)
962:             .DisabledForeColor = RGB(0, 0, 0)
963:             .Themes            = .F.
964:             .Format            = "K"
965:             .TabIndex          = 8
966:             *-- Value NUMERICO: coluna outbufs numeric(8,0)
967:             .Value             = 0
968:             *-- "Tamanho Buffer Transmissao"
969:             .ToolTipText       = "Tamanho Buffer Transmiss" + CHR(227) + "o"

*-- Linhas 1272 a 1343:
1272:         * BLOCO CONDICIONAL "Leitor de Codigo de Barra" - Say13/Opt_leitor.
1273:         * O legado exibe quando Tipos = 'Leitora Codigo Barra' ou
1274:         * 'Leitora Cheques' (e tambem 'Impressora de Cheque' no
1275:         * InteractiveChange - Fase 7).
1276:         *
1277:         * Say13.Width/Height (80/15) vem DECLARADOS no dump - usados
1278:         * direto, ao inves do gap calculado (CLAUDE.md regra #23: usar o
1279:         * que o SCX declara). ZOrderSet = 12 do dump eh bookkeeping do
1280:         * Form Designer e NAO existe em runtime - DESCARTADO (regra #33).
1281:         *----------------------------------------------------------------------
1282:         THIS.AddObject("lbl_4c_Label13", "Label")
1283:         WITH THIS.lbl_4c_Label13
1284:             .Top       = 210
1285:             .Left      = 367
1286:             .Width     = 80
1287:             .Height    = 15
1288:             .AutoSize  = .F.
1289:             .Alignment = 0
1290:             .WordWrap  = .F.
1291:             .BackStyle = 0
1292:             .FontName  = "Tahoma"
1293:             .FontSize  = 8
1294:             .ForeColor = RGB(90, 90, 90)
1295:             .Caption   = "Tipo de Leitor  : "
1296:             .Visible   = .T.
1297:         ENDWITH
1298: 
1299:         *-- Opt_leitor: OptionGroup de 3 botoes (Serial/Teclado/Paralelo),
1300:         *-- ControlSource direto em tpbarras numeric(1,0). BorderStyle do
1301:         *-- dump eh DESCARTADO (OptionGroup nao tem essa propriedade -
1302:         *-- regra #33); so .BackStyle eh transcrito.
1303:         THIS.AddObject("obj_4c_Opt_leitor", "OptionGroup")
1304:         WITH THIS.obj_4c_Opt_leitor
1305:             .Top         = 209
1306:             .Left        = 445
1307:             .Width       = 205
1308:             .Height      = 24
1309:             .ButtonCount = 3
1310:             .AutoSize    = .F.
1311:             .BackStyle   = 0
1312:             .TabIndex    = 12
1313:             .Visible     = .T.
1314: 
1315:             WITH .Buttons(1)
1316:                 .Top       = 3
1317:                 .Left      = 5
1318:                 .Width     = 44
1319:                 .Height    = 15
1320:                 .FontName  = "Tahoma"
1321:                 .FontSize  = 8
1322:                 .BackStyle = 0
1323:                 .ForeColor = RGB(90, 90, 90)
1324:                 .Caption   = "Serial"
1325:             ENDWITH
1326: 
1327:             WITH .Buttons(2)
1328:                 .Top       = 3
1329:                 .Left      = 65
1330:                 .Width     = 55
1331:                 .Height    = 15
1332:                 .FontName  = "Tahoma"
1333:                 .FontSize  = 8
1334:                 .BackStyle = 0
1335:                 .ForeColor = RGB(90, 90, 90)
1336:                 .Caption   = "Teclado"
1337:             ENDWITH
1338: 
1339:             WITH .Buttons(3)
1340:                 .Top       = 3
1341:                 .Left      = 135
1342:                 .Width     = 56
1343:                 .Height    = 15

*-- Linhas 1361 a 1586:
1361:     * ConfigurarEventos - Liga os eventos dos campos desta fase
1362:     *
1363:     * O legado tem UM unico evento sobre os campos: o
1364:     * Cmb_Tipo.InteractiveChange (SECAO 3 do dump, objeto SIGOPCPE.Cmb_Tipo).
1365:     * Eh ele que torna a tela utilizavel - sem ele o usuario escolhe o
1366:     * dispositivo no combo e NADA acontece: o cursor fica na linha em que o
1367:     * CarregarDados o deixou e todos os campos continuam mostrando (e
1368:     * gravando) a configuracao de OUTRO aparelho.
1369:     *
1370:     * InteractiveChange eh evento normal e aceita BINDEVENT - ao contrario do
1371:     * Valid em TextBox, que nao dispara (CLAUDE.md regra #3). Nao passa
1372:     * parametro nenhum, por isso ValidarTipo() tem assinatura vazia, e o
1373:     * delegado eh PUBLIC: metodo PROTECTED falha em SILENCIO no BINDEVENT.
1374:     *
1375:     * Nenhum outro controle do dump tem evento ligado a campo. O unico
1376:     * restante eh Chk_Bompara.When, cujo corpo no legado esta VAZIO (ver
1377:     * SECAO 3 - "PROCEDURE When" sem uma linha de codigo): nao altera
1378:     * comportamento algum, logo nao ha o que transcrever. Os Click de Ok e
1379:     * cancela sao a entrega da fase de eventos.
1380:     *
1381:     * Os demais campos NAO recebem handler de validacao, e isso eh fidelidade
1382:     * e nao omissao: o dump nao declara Valid, When nem LostFocus em nenhum
1383:     * deles. A faixa 1..10 do numero da porta ja eh garantida pelo proprio
1384:     * Spinner (SpinnerLow/HighValue + KeyboardLow/HighValue, transcritos na
1385:     * Fase 5) e o dominio {0,1} de InModes eh apenas a nota do Say11 na tela
1386:     * - o legado nao recusa outro valor, e inventar a recusa exibiria uma
1387:     * mensagem que o usuario nunca viu (PILAR 1).
1388:     *==========================================================================
1389:     PROTECTED PROCEDURE ConfigurarEventos()
1390:         BINDEVENT(THIS.cbo_4c_Cmb_Tipo, "InteractiveChange", THIS, "ValidarTipo")
1391: 
1392:         *-- FASE 7 - os DOIS unicos botoes do legado (SECAO 3 do dump:
1393:         *-- SIGOPCPE.Ok.Click e SIGOPCPE.cancela.Click). Nao ha mais nenhum
1394:         *-- Click no dump inteiro, e o legado nao tem barra CRUD: a classe
1395:         *-- base eh [form] puro (nao frmcadastro), nao existe Grupo_Op nem
1396:         *-- pcEscolha, e os dois CommandButton sao Confirmar e Encerrar.
1397:         *-- Por isso esta fase NAO entrega BtnIncluirClick/BtnAlterarClick/
1398:         *-- BtnVisualizarClick/BtnExcluirClick: seriam botoes INVENTADOS
1399:         *-- (viola o PILAR 1) ou metodos vazios (viola a regra de completude).
1400:         *--
1401:         *-- Os delegados de BINDEVENT sao PUBLIC (sem PROTECTED): metodo
1402:         *-- PROTECTED falha em SILENCIO no bind (CLAUDE.md regra #3).
1403:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
1404:         BINDEVENT(THIS.cnt_4c_Botoes.cmd_4c_Encerrar,  "Click", THIS, "BtnEncerrarClick")
1405:     ENDPROC
1406: 
1407:     *==========================================================================
1408:     * ValidarTipo - Reproduz o Cmb_Tipo.InteractiveChange do legado
1409:     *
1410:     *   If Seek(This.value,'crSigSyCom','PesqTipo')
1411:     *     Thisform.Refresh
1412:     *   EndIf
1413:     *   <esconde os 10 controles condicionais e reexibe conforme Tipos>
1414:     *
1415:     * O combo eh o UNICO controle da tela sem ControlSource (tambem no
1416:     * legado): ele nao grava nada, so RESOLVE qual linha do cursor_4c_Dados
1417:     * os demais campos passam a exibir e editar.
1418:     *
1419:     * O SEEK usa PADR(valor, 20) porque a tag PesqTipo indexa tipos
1420:     * char(20): chave de largura fixa casa exato tanto sob SET EXACT ON
1421:     * quanto sob SET EXACT OFF - e este form tem DataSession = 2, que
1422:     * devolve os SET ao default do VFP, entao depender do valor global
1423:     * seria aposta. Eh o mesmo PADR(...,20) com que o
1424:     * SIGOPCPEBO.CarregarDados semeia e procura as linhas.
1425:     *
1426:     * O Refresh so acontece quando o SEEK ACHA a linha, igual ao legado -
1427:     * tipo inexistente na tabela deixa os campos como estavam, em vez de
1428:     * repintar com o registro errado. A alternancia de visibilidade roda
1429:     * SEMPRE, achando ou nao, tambem como no legado: ela le o Tipos da linha
1430:     * CORRENTE, qualquer que seja.
1431:     *
1432:     * PUBLIC (sem PROTECTED) porque eh delegado de BINDEVENT.
1433:     *==========================================================================
1434:     PROCEDURE ValidarTipo()
1435:         LOCAL loc_cTipo, loc_oErro
1436: 
1437:         TRY
1438:             loc_cTipo = ALLTRIM(NVL(THIS.cbo_4c_Cmb_Tipo.Value, ""))
1439: 
1440:             THIS.this_cTipoSelecionado = loc_cTipo
1441:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1442:                 THIS.this_oBusinessObject.this_cTipoSelecionado = loc_cTipo
1443:             ENDIF
1444: 
1445:             IF USED("cursor_4c_Dados") AND !EMPTY(loc_cTipo)
1446:                 IF SEEK(PADR(loc_cTipo, 20), "cursor_4c_Dados", "PesqTipo")
1447:                     *-- Linha achada: os campos ligados por ControlSource
1448:                     *-- passam a mostrar a configuracao deste aparelho. O BO
1449:                     *-- acompanha a linha corrente (equivalente, na
1450:                     *-- arquitetura em camadas, ao cursor unico que o
1451:                     *-- poDataMgr do legado grava inteiro).
1452:                     *--
1453:                     *-- FASE 8: o repintar passou a ser BOParaForm(), que
1454:                     *-- percorre os 15 controles a partir das properties do
1455:                     *-- BO com as conversoes de tipo explicitas - fonte unica
1456:                     *-- com a recarga feita pelo CarregarLista(), que chama o
1457:                     *-- mesmo metodo. O [Thisform.Refresh] do legado continua
1458:                     *-- aqui, DEPOIS, para repintar tambem o que nao passa
1459:                     *-- pelo mapeamento (labels e os dois blocos de botao).
1460:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
1461:                         THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
1462:                         THIS.BOParaForm()
1463:                     ENDIF
1464: 
1465:                     THIS.Refresh()
1466:                 ENDIF
1467:             ENDIF
1468: 
1469:             THIS.AplicarVisibilidadePorTipo()
1470: 
1471:         CATCH TO loc_oErro
1472:             MsgErro(loc_oErro.Message + CHR(13) + ;
1473:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1474:                     "Procedure: " + loc_oErro.Procedure, ;
1475:                     "Erro em FormSIGOPCPE.ValidarTipo")
1476:         ENDTRY
1477:     ENDPROC
1478: 
1479:     *==========================================================================
1480:     * AplicarVisibilidadePorTipo - Esconde/reexibe os dois blocos
1481:     * condicionais conforme o dispositivo da linha CORRENTE do cursor
1482:     *
1483:     * Transcricao do bloco que o legado repete em DOIS lugares (Init e
1484:     * Cmb_Tipo.InteractiveChange, SECAO 3 do dump): primeiro esconde os 10
1485:     * controles, depois reexibe por tipo. Metodo UNICO de proposito - regra
1486:     * de dependencia entre campos tem fonte unica (CLAUDE.md regra #45), e
1487:     * assim os dois chamadores (InicializarForm e ValidarTipo) ficam com
1488:     * exatamente o mesmo comportamento.
1489:     *
1490:     *   Bloco CHEQUE  Say12/Get_TpLeChq, Say14/Chk_BomPara,
1491:     *                 Say15/Chk_Nominal, Say16/Chk_Cruzado
1492:     *                 -> Tipos = 'Leitora Cheques' ou 'Impressora de Cheque'
1493:     *   Bloco LEITOR  Say13/Opt_leitor
1494:     *                 -> Tipos = 'Leitora Codigo Barra', 'Leitora Cheques'
1495:     *                    ou 'Impressora de Cheque'
1496:     *
1497:     * O segundo IF do Init legado omite 'Impressora de Cheque', que o
1498:     * InteractiveChange inclui. A condicao transcrita aqui eh a do
1499:     * InteractiveChange, e a diferenca NAO eh observavel na abertura: o
1500:     * CarregarDados fecha com GO TOP sobre a tag PesqTipo (tipos char(20)),
1501:     * entao a linha corrente no Init eh sempre a primeira em ordem
1502:     * alfabetica dos 6 tipos - "Balanca" -, que nao satisfaz nenhum dos dois
1503:     * IF e deixa os 10 controles escondidos nas DUAS versoes.
1504:     *
1505:     * PUBLIC (sem PROTECTED): a fase de eventos chama de fora ao trocar o
1506:     * dispositivo, e metodo que o form expoe nunca leva PROTECTED em nivel
1507:     * algum da heranca (CLAUDE.md regra #51).
1508:     *==========================================================================
1509:     PROCEDURE AplicarVisibilidadePorTipo()
1510:         LOCAL loc_cTipos, loc_lCheque, loc_lLeitor, loc_oErro
1511: 
1512:         TRY
1513:             *-- Tipos da linha corrente. Cursor fechado, vazio ou em EOF
1514:             *-- devolve vazio e os dois blocos ficam escondidos - o mesmo
1515:             *-- estado em que o Init legado abre a tela.
1516:             loc_cTipos = ""
1517:             IF USED("cursor_4c_Dados")
1518:                 IF !EOF("cursor_4c_Dados")
1519:                     loc_cTipos = ALLTRIM(NVL(cursor_4c_Dados.tipos, ""))
1520:                 ENDIF
1521:             ENDIF
1522: 
1523:             loc_lCheque = INLIST(loc_cTipos, "Leitora Cheques", ;
1524:                                  "Impressora de Cheque")
1525: 
1526:             loc_lLeitor = INLIST(loc_cTipos, "Leitora Codigo Barra", ;
1527:                                  "Leitora Cheques", "Impressora de Cheque")
1528: 
1529:             *-- Bloco CHEQUE - label e campo de cada linha andam juntos
1530:             THIS.lbl_4c_Label12.Visible     = loc_lCheque
1531:             THIS.cbo_4c_Get_TpLeChq.Visible = loc_lCheque
1532:             THIS.lbl_4c_Label14.Visible     = loc_lCheque
1533:             THIS.chk_4c_Chk_Bompara.Visible = loc_lCheque
1534:             THIS.lbl_4c_Label15.Visible     = loc_lCheque
1535:             THIS.chk_4c_Chk_nominal.Visible = loc_lCheque
1536:             THIS.lbl_4c_Label16.Visible     = loc_lCheque
1537:             THIS.chk_4c_Chk_cruzado.Visible = loc_lCheque
1538: 
1539:             *-- Bloco LEITOR de codigo de barra
1540:             THIS.lbl_4c_Label13.Visible     = loc_lLeitor
1541:             THIS.obj_4c_Opt_leitor.Visible  = loc_lLeitor
1542: 
1543:         CATCH TO loc_oErro
1544:             MsgErro(loc_oErro.Message + CHR(13) + ;
1545:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1546:                     "Procedure: " + loc_oErro.Procedure, ;
1547:                     "Erro em FormSIGOPCPE.AplicarVisibilidadePorTipo")
1548:         ENDTRY
1549:     ENDPROC
1550: 
1551:     *==========================================================================
1552:     * BtnConfirmarClick - FASE 7 - transcricao do SIGOPCPE.Ok.Click
1553:     *
1554:     *   If Not ThisForm.poDataMgr.Update('crSigSyCom')
1555:     *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ;
1556:     *                   'Falha na Conexao (Update - SigSyCom)')
1557:     *       Return 0
1558:     *   EndIf
1559:     *   If (ThisForm.poDataMgr.Commit() < 1)
1560:     *       =MessageBox('Favor Reinicializar o Processo!!!', 16, ;
1561:     *                   'Falha na Conexao (Commit)')
1562:     *       Return 0
1563:     *   EndIf
1564:     *   =fGrvSettings('CrSigSyCom')
1565:     *   Thisform.Release
1566:     *
1567:     * Os TRES passos do legado, na mesma ordem e com os mesmos caminhos de
1568:     * falha: cada [Return 0] ABORTA deixando a tela ABERTA (o usuario corrige
1569:     * e tenta de novo), e so o caminho inteiro bem-sucedido fecha o form.
1570:     *
1571:     * O passo 2 (Commit) eh um passo com caminho de falha PROPRIO, nao
1572:     * detalhe de infraestrutura - descartar o Commit() do legado eh defeito
1573:     * MUDO conhecido: a conexao deste ambiente nasce com
1574:     * SQLGETPROP(h, "Transactions") = 2 (MANUAL), entao sem SQLCOMMIT o
1575:     * gravado fica preso na transacao aberta e SOME se o processo morrer.
1576:     *
1577:     * NAO existe aqui ROLLBACK, e a ausencia eh DELIBERADA (dupla razao):
1578:     * o legado nao chama poDataMgr.RollBack neste Click - a mensagem
1579:     * "Favor Reinicializar o Processo!!!" eh justamente a instrucao de
1580:     * reiniciar, e eh o reinicio que descarta a transacao ainda nao
1581:     * confirmada -, e SQLROLLBACK(gnConnHandle) desfaria a transacao INTEIRA,
1582:     * levando embora gravacao de qualquer outra tela aberta na mesma
1583:     * conexao. Inventar o rollback seria mais destrutivo que a falha.
1584:     *
1585:     * O legado nao tem validacao nenhuma neste Click (nao ha Obrigatorios(),
1586:     * nao ha Valid nos campos, o unico When do dump esta com o corpo vazio),

*-- Linhas 1601 a 1647:
1601:     * chamar o nome sem definir o arquivo estouraria
1602:     * [File 'fgrvsettings.prg' does not exist] em RUNTIME (regra #13).
1603:     *
1604:     * PUBLIC (sem PROTECTED) porque eh delegado de BINDEVENT (regra #3) e
1605:     * tambem porque o harness de teste chama Btn*Click de fora da classe.
1606:     *==========================================================================
1607:     PROCEDURE BtnConfirmarClick()
1608:         LOCAL loc_lProsseguir
1609: 
1610:         *-- FASE 8 - Passo 0: descarrega a tela na linha CORRENTE do cursor
1611:         *-- antes de gravar. No legado isso eh efeito do ControlSource (o
1612:         *-- controle grava no cursor ao perder o foco, e acionar o botao faz
1613:         *-- o campo perder o foco); o FormParaBO repete o REPLACE de forma
1614:         *-- explicita, cobrindo a edicao ainda nao confirmada no campo em que o
1615:         *-- usuario estava.
1616:         *--
1617:         *-- O retorno .F. NAO aborta a gravacao, e isso eh deliberado: ele
1618:         *-- significa apenas "nao havia linha corrente para descarregar"
1619:         *-- (cursor em EOF). O legado grava o cursor INTEIRO, entao as 6
1620:         *-- linhas semeadas tem de ser gravadas mesmo que o usuario abra a
1621:         *-- tela e clique Confirmar sem escolher dispositivo nenhum - que eh
1622:         *-- exatamente o estado da abertura, com o Cmb_Tipo em branco.
1623:         *-- Abortar aqui faria a tela recusar justamente a primeira gravacao.
1624:         THIS.FormParaBO()
1625: 
1626:         *-- Passo 1 - equivalente ao poDataMgr.Update('crSigSyCom'): joga o
1627:         *-- cursor INTEIRO de volta para SigSyCom.
1628:         loc_lProsseguir = THIS.GravarTodosOsTipos()
1629: 
1630:         IF !loc_lProsseguir
1631:             *-- A falha JA foi mostrada com o texto do SQL Server pelo
1632:             *-- BusinessBase/BO (CLAUDE.md regra #20); a mensagem generica do
1633:             *-- legado so sai quando nada mais apareceu, para nao empilhar
1634:             *-- dois dialogos dizendo a mesma coisa.
1635:             IF !THIS.this_oBusinessObject.this_lErroExibido
1636:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1637:                         "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
1638:             ENDIF
1639:         ELSE
1640:             *-- Passo 2 - equivalente ao poDataMgr.Commit() < 1
1641:             IF !THIS.ConfirmarTransacao()
1642:                 MsgErro("Favor Reinicializar o Processo!!!", ;
1643:                         "Falha na Conex" + CHR(227) + "o (Commit)")
1644:             ELSE
1645:                 *-- Passo 3 - fGrvSettings: ver PERDA DOCUMENTADA no
1646:                 *-- cabecalho deste metodo.
1647:                 *-- Passo 4 - [Thisform.Release] do legado.

*-- Linhas 1671 a 1716:
1671:     * Release() e nao Hide(): este eh form de topo, aberto pelo menu, sem
1672:     * form pai esperando ler propriedade depois do fechamento.
1673:     *
1674:     * PUBLIC (sem PROTECTED) porque eh delegado de BINDEVENT (regra #3).
1675:     *==========================================================================
1676:     PROCEDURE BtnEncerrarClick()
1677:         THIS.Release()
1678:     ENDPROC
1679: 
1680:     *==========================================================================
1681:     * GravarTodosOsTipos - equivalente ao poDataMgr.Update('crSigSyCom')
1682:     *
1683:     * No legado o Update eh um TABLEUPDATE sobre o cursor bufferizado INTEIRO:
1684:     * ele grava TODAS as linhas de uma vez - INSERT nas que o Init
1685:     * acrescentou (os tipos de dispositivo que ainda nao existiam na tabela)
1686:     * e UPDATE nas que o usuario editou. Por isso aqui tambem se percorre o
1687:     * cursor TODO, e nao apenas a linha que o Cmb_Tipo deixou corrente: quem
1688:     * troca de dispositivo, mexe em dois e clica Confirmar tem de ver os dois
1689:     * gravados - gravar so a linha corrente perderia a outra em silencio.
1690:     *
1691:     * INSERT ou UPDATE se decide pela PK cidchaves: as linhas semeadas pelo
1692:     * SIGOPCPEBO.CarregarDados nascem com cidchaves novo (fUniqueIds) e ainda
1693:     * NAO existem na tabela. A fotografia das chaves ja gravadas eh UMA ida ao
1694:     * banco (nao uma por linha), feita no inicio.
1695:     *
1696:     * NovoRegistro() vem ANTES do CarregarDoCursor de proposito: ele chama
1697:     * LimparDados(), que hoje na BusinessBase so limpa a mensagem de erro, mas
1698:     * que uma subclasse pode passar a usar para zerar as properties - na ordem
1699:     * inversa a limpeza apagaria os valores recem-lidos do cursor.
1700:     *
1701:     * Quem grava eh Salvar() (PUBLIC na BusinessBase), nao Inserir()/
1702:     * Atualizar() direto: assim passam os hooks ValidarDados/AntesDeGravar/
1703:     * DepoisDeGravar e a auditoria, e a falha NUNCA fica muda (regra #20).
1704:     *
1705:     * Na PRIMEIRA falha o laco PARA (EXIT) - igual ao [Return 0] do legado,
1706:     * que aborta sem tentar o resto. EXIT dentro de TRY eh seguro; RETURN nao
1707:     * seria (CLAUDE.md regra #1), por isso o retorno eh unico e fica DEPOIS do
1708:     * ENDTRY.
1709:     *
1710:     * PROTECTED: so o BtnConfirmarClick chama, sempre com THIS. (regra #8).
1711:     *==========================================================================
1712:     PROTECTED FUNCTION GravarTodosOsTipos()
1713:         LOCAL loc_lResultado, loc_lProsseguir, loc_cAlias, loc_cAliasChaves
1714:         LOCAL loc_nTotal, loc_nI, loc_cChave, loc_lExiste, loc_oErro
1715: 
1716:         loc_lResultado   = .F.

*-- Linhas 1729 a 1772:
1729:         *-- mesma falha (medido no probe desta fase, que trouxe os dois).
1730:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1731:             MsgErro("Imposs" + CHR(237) + "vel Efetuar Conex" + CHR(227) + ;
1732:                     "o com Servidor de Banco de Dados...", "CreateObject")
1733:             THIS.this_oBusinessObject.this_lErroExibido = .T.
1734:             loc_lProsseguir = .F.
1735:         ENDIF
1736: 
1737:         IF loc_lProsseguir AND !USED(loc_cAlias)
1738:             MsgErro("Cursor de trabalho n" + CHR(227) + "o dispon" + CHR(237) + ;
1739:                     "vel - reabra a tela.", ;
1740:                     "Falha na Conex" + CHR(227) + "o (Update - SigSyCom)")
1741:             THIS.this_oBusinessObject.this_lErroExibido = .T.
1742:             loc_lProsseguir = .F.
1743:         ENDIF
1744: 
1745:         IF loc_lProsseguir
1746:             TRY
1747:                 *-- Fotografia das PKs ja gravadas em SigSyCom.
1748:                 IF USED(loc_cAliasChaves)
1749:                     USE IN (loc_cAliasChaves)
1750:                 ENDIF
1751: 
1752:                 IF SQLEXEC(gnConnHandle, "SELECT cidchaves FROM SigSyCom", ;
1753:                            loc_cAliasChaves) > 0
1754:                     SELECT (loc_cAlias)
1755:                     loc_nTotal     = RECCOUNT(loc_cAlias)
1756:                     loc_lResultado = .T.
1757: 
1758:                     FOR loc_nI = 1 TO loc_nTotal
1759:                         *-- Reposicionamento EXPLICITO a cada volta: o LOCATE
1760:                         *-- abaixo e o SQLEXEC do BO trabalham em outras areas,
1761:                         *-- e CarregarDoCursor le a linha CORRENTE do alias.
1762:                         SELECT (loc_cAlias)
1763:                         GO loc_nI
1764: 
1765:                         *-- tipos eh a chave de negocio char(20) NOT NULL: linha
1766:                         *-- sem tipo nao existe no legado (o Init semeia os 6) e
1767:                         *-- nao teria como ser gravada.
1768:                         IF EMPTY(ALLTRIM(NVL(cursor_4c_Dados.tipos, "")))
1769:                             LOOP
1770:                         ENDIF
1771: 
1772:                         loc_cChave  = ALLTRIM(NVL(cursor_4c_Dados.cidchaves, ""))

*-- Linhas 1824 a 1867:
1824:                 THIS.this_cMensagemErro = loc_oErro.Message
1825:                 MsgErro(loc_oErro.Message + CHR(13) + ;
1826:                         "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1827:                         "Procedure: " + loc_oErro.Procedure, ;
1828:                         "Erro em FormSIGOPCPE.GravarTodosOsTipos")
1829:                 THIS.this_oBusinessObject.this_lErroExibido = .T.
1830:                 loc_lResultado = .F.
1831:             ENDTRY
1832:         ENDIF
1833: 
1834:         RETURN loc_lResultado
1835:     ENDFUNC
1836: 
1837:     *==========================================================================
1838:     * ConfirmarTransacao - equivalente ao [If (poDataMgr.Commit() < 1)] do
1839:     * legado (o fSqlConector do Framework tem Commit()/RollBack() proprios).
1840:     *
1841:     * Medido neste ambiente: a conexao nasce com
1842:     * SQLGETPROP(gnConnHandle, "Transactions") = 2, isto eh MANUAL - sem
1843:     * SQLCOMMIT o que foi gravado so eh efetivado num SQLDISCONNECT limpo e
1844:     * SOME se o processo for morto. Conferir a gravacao na MESMA conexao nao
1845:     * prova nada: ela enxerga a propria transacao aberta.
1846:     *
1847:     * O par eh INERTE quando a conexao estiver em auto-commit (Transactions=1),
1848:     * em que nao ha transacao para confirmar. O IF eh ANINHADO de proposito:
1849:     * VFP9 NAO faz curto-circuito em AND, e [IF loc_lManual AND SQLCOMMIT(...)]
1850:     * chamaria o SQLCOMMIT de qualquer jeito.
1851:     *
1852:     * PROTECTED: so o BtnConfirmarClick chama, sempre com THIS. (regra #8).
1853:     *==========================================================================
1854:     PROTECTED FUNCTION ConfirmarTransacao()
1855:         LOCAL loc_lResultado, loc_lManual
1856: 
1857:         loc_lResultado = .T.
1858:         loc_lManual    = (SQLGETPROP(gnConnHandle, "Transactions") = 2)
1859: 
1860:         IF loc_lManual
1861:             IF SQLCOMMIT(gnConnHandle) < 1
1862:                 loc_lResultado = .F.
1863:             ENDIF
1864:         ENDIF
1865: 
1866:         RETURN loc_lResultado
1867:     ENDFUNC

*-- Linhas 1881 a 1934:
1881:     *   <semeia os 6 tipos que faltarem + Settings default 9600,n,8,1>
1882:     *
1883:     * O trabalho em si fica no SIGOPCPEBO.CarregarDados (camada de dados); o
1884:     * que esta fase acrescenta eh o FUNIL: ANTES o InicializarForm chamava
1885:     * CarregarDados direto, e qualquer recarga futura teria de repetir a mao o
1886:     * reposicionamento e o repintar. Com o funil, recarregar a tela passa a
1887:     * ter UM caminho so - o cursor volta posicionado no dispositivo que esta
1888:     * na tela (e nao na primeira linha), o BO acompanha a linha corrente e os
1889:     * campos sao repintados. Metodo unico eh a mesma exigencia que a regra
1890:     * #21 faz para grade e a regra #45 para dependencia entre campos.
1891:     *
1892:     * Chamado em DOIS momentos com exigencias opostas, e por isso o repintar
1893:     * eh GUARDADO:
1894:     *   - do InicializarForm, ANTES de ConfigurarCamposPrincipais: o cursor
1895:     *     TEM de existir e estar posicionado antes dos controles, porque eles
1896:     *     sao ligados a ele por ControlSource e binding para alias fechado
1897:     *     derruba o Init inteiro (CLAUDE.md regra #41). Nesse momento
1898:     *     cbo_4c_Cmb_Tipo ainda NAO existe, o BOParaForm eh pulado e o combo
1899:     *     permanece em branco - que eh o estado REAL do legado na abertura
1900:     *     (o With do Init faz .ListIndex = 1 ANTES do .Clear, e o Clear zera
1901:     *     o ListIndex).
1902:     *   - de uma recarga com a tela montada: ai os controles existem e o
1903:     *     BOParaForm repinta.
1904:     * PEMSTATUS(THIS, "<nome>", 5) responde exatamente essa pergunta -
1905:     * "o AddObject ja rodou?" -, que eh checagem de EXISTENCIA e nao de
1906:     * escopo (o uso que as regras #3/#34 proibem eh o oposto: confiar nele
1907:     * para saber se um membro eh alcancavel).
1908:     *
1909:     * SEEK que FALHA deixa o ponteiro em EOF no VFP9; por isso o GO TOP de
1910:     * reserva no ramo de falha, para a tela nunca ficar sem linha corrente
1911:     * numa recarga (os 6 itens do combo sao os 6 tipos que CarregarDados
1912:     * semeia, entao na pratica o SEEK nao falha).
1913:     *
1914:     * PUBLIC (sem PROTECTED): o TesteAutomatico.prg chama
1915:     * THIS.oForm.CarregarLista() de FORA da classe, e PEMSTATUS(...,5)
1916:     * devolve .T. mesmo para metodo PROTECTED - o teste entraria no ramo e a
1917:     * chamada estouraria em runtime (CLAUDE.md regras #3/#51).
1918:     *==========================================================================
1919:     FUNCTION CarregarLista()
1920:         LOCAL loc_lResultado, loc_cTipo, loc_oErro
1921: 
1922:         loc_lResultado = .F.
1923: 
1924:         TRY
1925:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1926:                 *-- CarregarDados ja exibe a propria falha; nao se repete a
1927:                 *-- mensagem aqui (CLAUDE.md regra #20).
1928:                 loc_lResultado = THIS.this_oBusinessObject.CarregarDados()
1929:             ENDIF
1930: 
1931:             IF loc_lResultado AND USED("cursor_4c_Dados")
1932:                 loc_cTipo = ALLTRIM(THIS.this_cTipoSelecionado)
1933: 
1934:                 SELECT cursor_4c_Dados

*-- Linhas 1960 a 2003:
1960:             THIS.this_cMensagemErro = loc_oErro.Message
1961:             MsgErro(loc_oErro.Message + CHR(13) + ;
1962:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1963:                     "Procedure: " + loc_oErro.Procedure, ;
1964:                     "Erro em FormSIGOPCPE.CarregarLista")
1965:             loc_lResultado = .F.
1966:         ENDTRY
1967: 
1968:         RETURN loc_lResultado
1969:     ENDFUNC
1970: 
1971:     *==========================================================================
1972:     * BOParaForm - FASE 8 - propriedades do BO -> controles da tela
1973:     *
1974:     * Os 15 controles de dados sao ligados por ControlSource a linha corrente
1975:     * do cursor_4c_Dados (transcricao do legado, que liga cada controle a
1976:     * crSigSyCom.<coluna>), entao o cursor eh o BUFFER DE EDICAO e o VFP9 ja
1977:     * mantem controle e linha em sincronia. Este metodo nao substitui esse
1978:     * mecanismo: ele fecha o circuito da arquitetura em camadas, deixando as
1979:     * properties do BO - que sao o que a camada de dados grava - como a fonte
1980:     * do que a tela mostra. Como as properties acabaram de ser lidas DESSA
1981:     * MESMA linha pelo CarregarDoCursor, cada atribuicao abaixo escreve de
1982:     * volta o valor que ja estava lah: nao ha como as duas versoes divergirem.
1983:     *
1984:     * Mapeamento COMPLETO - os 15 controles com ControlSource mais o seletor:
1985:     *
1986:     *   cbo_4c_Cmb_Tipo      (seletor, SEM ControlSource)  <- this_cTipos
1987:     *   obj_4c_Spinner1      portas    numeric(1,0)        <- this_nPortas
1988:     *   cbo_4c_Cmb_Hand      hands     char(20)            <- this_cHands
1989:     *   txt_4c_Set           settings  char(20)            <- this_cSettings
1990:     *   chk_4c_Chk_dtr       dtrs      bit    -> LOGICO    <- this_lDtrs
1991:     *   chk_4c_Chk_rts       rtss      bit    -> LOGICO    <- this_lRtss
1992:     *   txt_4c_Inbuf         inbufs    numeric(8,0)        <- this_nInbufs
1993:     *   txt_4c_Outbuf        outbufs   numeric(8,0)        <- this_nOutbufs
1994:     *   txt_4c_Inmode        inmodes   numeric(1,0)        <- this_nInmodes
1995:     *   txt_4c_Inlen         inlens    numeric(8,0)        <- this_nInlens
1996:     *   cbo_4c_Get_TpLeChq   tplechqs  char(1)             <- this_cTplechqs
1997:     *   chk_4c_Chk_Bompara   bompara   numeric(1,0)        <- this_nBompara
1998:     *   chk_4c_Chk_nominal   nominal   numeric(1,0)        <- this_nNominal
1999:     *   chk_4c_Chk_cruzado   cruzado   numeric(1,0)        <- this_nCruzado
2000:     *   obj_4c_Opt_leitor    tpbarras  numeric(1,0)        <- this_nTpbarras
2001:     *
2002:     * cidchaves (PK) e nomeimp char(40) NAO tem controle no SCX e por isso
2003:     * nao aparecem aqui - quem cuida das duas eh o INSERT/UPDATE do BO, que

*-- Linhas 2019 a 2305:
2019:     * ListIndex = 0, o mesmo branco com que o legado abre.
2020:     *
2021:     * SEM promover zero: tpbarras = 0 (linha semeada, que nasce em branco)
2022:     * fica 0 e o OptionGroup abre sem botao marcado, exatamente como no
2023:     * legado. IIF(col = 0, 1, col) aqui exibiria "Serial" e REGRAVARIA
2024:     * Serial em todo registro tocado (CLAUDE.md regra #45).
2025:     *
2026:     * NAO chama AplicarVisibilidadePorTipo: quem decide a visibilidade eh a
2027:     * linha corrente do cursor, nao o BO, e os dois chamadores deste metodo
2028:     * (ValidarTipo e CarregarLista) ja a chamam no proprio funil - chamar de
2029:     * novo aqui duplicaria a regra em dois lugares (regra #45).
2030:     *
2031:     * PROTECTED, e isso NAO eh escolha: o FormBase declara
2032:     * [PROTECTED PROCEDURE BOParaForm()] (formbase.prg:280) e PROTECTED na
2033:     * classe BASE prevalece sobre o override sem modificador - medido no VFP9
2034:     * em 2026-10-30, PEMSTATUS(oForm, "BOParaForm", 2) devolve .T. mesmo com
2035:     * [FUNCTION] puro aqui. Escrito PROTECTED de forma explicita para que o
2036:     * arquivo diga a verdade. Consequencia pratica: so se alcanca por
2037:     * THIS.BOParaForm() de DENTRO da classe (CLAUDE.md regra #8), que eh
2038:     * como os dois chamadores - ValidarTipo e CarregarLista - o usam.
2039:     * Chamada de fora estoura [Property BOPARAFORM is not found]
2040:     * (CLAUDE.md regra #51); o harness nao chama este hook.
2041:     *==========================================================================
2042:     PROTECTED FUNCTION BOParaForm()
2043:         LOCAL loc_lResultado, loc_oBO, loc_cTipo, loc_nI, loc_nIndice, loc_oErro
2044: 
2045:         loc_lResultado = .F.
2046: 
2047:         TRY
2048:             IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
2049:                AND PEMSTATUS(THIS, "cbo_4c_Cmb_Tipo", 5)
2050: 
2051:                 loc_oBO = THIS.this_oBusinessObject
2052: 
2053:                 *-- SELETOR - Cmb_Tipo, o unico controle sem ControlSource
2054:                 loc_cTipo   = ALLTRIM(NVL(loc_oBO.this_cTipos, ""))
2055:                 loc_nIndice = 0
2056: 
2057:                 FOR loc_nI = 1 TO THIS.cbo_4c_Cmb_Tipo.ListCount
2058:                     IF ALLTRIM(THIS.cbo_4c_Cmb_Tipo.List(loc_nI)) == loc_cTipo
2059:                         loc_nIndice = loc_nI
2060:                         EXIT
2061:                     ENDIF
2062:                 ENDFOR
2063: 
2064:                 *-- Atribui SO quando muda de verdade: este metodo tambem eh
2065:                 *-- chamado de DENTRO do InteractiveChange do proprio combo
2066:                 *-- (pelo ValidarTipo), e reescrever o ListIndex no meio da
2067:                 *-- interacao nao tem efeito util nenhum - o item ja eh o que
2068:                 *-- o usuario acabou de escolher.
2069:                 IF THIS.cbo_4c_Cmb_Tipo.ListIndex != loc_nIndice
2070:                     THIS.cbo_4c_Cmb_Tipo.ListIndex = loc_nIndice
2071:                 ENDIF
2072: 
2073:                 *-- Estado do tipo escolhido, nas duas camadas
2074:                 THIS.this_cTipoSelecionado    = loc_cTipo
2075:                 loc_oBO.this_cTipoSelecionado = loc_cTipo
2076: 
2077:                 *-- Bloco da porta serial (coluna esquerda, sempre visivel)
2078:                 THIS.obj_4c_Spinner1.Value = loc_oBO.this_nPortas
2079:                 THIS.cbo_4c_Cmb_Hand.Value = loc_oBO.this_cHands
2080:                 THIS.txt_4c_Set.Value      = loc_oBO.this_cSettings
2081: 
2082:                 *-- bit -> LOGICO
2083:                 THIS.chk_4c_Chk_dtr.Value = ConverterParaLogico(loc_oBO.this_lDtrs)
2084:                 THIS.chk_4c_Chk_rts.Value = ConverterParaLogico(loc_oBO.this_lRtss)
2085: 
2086:                 *-- Buffers e modo de leitura
2087:                 THIS.txt_4c_Inbuf.Value  = loc_oBO.this_nInbufs
2088:                 THIS.txt_4c_Outbuf.Value = loc_oBO.this_nOutbufs
2089:                 THIS.txt_4c_Inmode.Value = loc_oBO.this_nInmodes
2090:                 THIS.txt_4c_Inlen.Value  = loc_oBO.this_nInlens
2091: 
2092:                 *-- Bloco de cheque (tplechqs char(1) - a inicial da opcao)
2093:                 THIS.cbo_4c_Get_TpLeChq.Value = loc_oBO.this_cTplechqs
2094: 
2095:                 *-- numeric(1,0) -> CheckBox numerico {0,1}
2096:                 THIS.chk_4c_Chk_Bompara.Value = IIF(ConverterParaLogico(loc_oBO.this_nBompara), 1, 0)
2097:                 THIS.chk_4c_Chk_nominal.Value = IIF(ConverterParaLogico(loc_oBO.this_nNominal), 1, 0)
2098:                 THIS.chk_4c_Chk_cruzado.Value = IIF(ConverterParaLogico(loc_oBO.this_nCruzado), 1, 0)
2099: 
2100:                 *-- Bloco do leitor de codigo de barra - indice 1-based do
2101:                 *-- OptionGroup, DIRETO (1=Serial 2=Teclado 3=Paralelo)
2102:                 THIS.obj_4c_Opt_leitor.Value = loc_oBO.this_nTpbarras
2103: 
2104:                 loc_lResultado = .T.
2105:             ENDIF
2106: 
2107:         CATCH TO loc_oErro
2108:             THIS.this_cMensagemErro = loc_oErro.Message
2109:             MsgErro(loc_oErro.Message + CHR(13) + ;
2110:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2111:                     "Procedure: " + loc_oErro.Procedure, ;
2112:                     "Erro em FormSIGOPCPE.BOParaForm")
2113:             loc_lResultado = .F.
2114:         ENDTRY
2115: 
2116:         RETURN loc_lResultado
2117:     ENDFUNC
2118: 
2119:     *==========================================================================
2120:     * FormParaBO - FASE 8 - controles da tela -> linha do cursor -> BO
2121:     *
2122:     * Inverso do BOParaForm, nos MESMOS 15 controles (a tabela do mapeamento
2123:     * esta no cabecalho dele). Dois passos, nesta ordem:
2124:     *
2125:     *   1. REPLACE dos valores da tela na linha CORRENTE do cursor_4c_Dados.
2126:     *      Eh o mesmo efeito que o ControlSource produz quando o controle
2127:     *      perde o foco, e serve de rede para o unico caso em que isso pode
2128:     *      nao ter acontecido ainda: a edicao que o usuario deixou sem confirmar
2129:     *      no campo em que estava ao acionar o botao.
2130:     *   2. CarregarDoCursor, que repassa a linha as properties do BO.
2131:     *
2132:     * Fazer tela -> cursor -> BO (e nao tela -> BO) eh o que garante UMA
2133:     * fonte: quem grava eh o GravarTodosOsTipos, que percorre o cursor
2134:     * INTEIRO linha a linha chamando CarregarDoCursor (o legado faz o mesmo
2135:     * com poDataMgr.Update('crSigSyCom'), que eh um TABLEUPDATE do cursor
2136:     * inteiro). Se este metodo escrevesse so nas properties, o laco as
2137:     * sobrescreveria com o conteudo do cursor e o trabalho dele seria
2138:     * descartado em silencio - exatamente o tipo de divergencia muda que a
2139:     * regra #45 manda evitar com fonte unica.
2140:     *
2141:     * TIPOS no caminho de volta: ConverterParaNumero nas colunas numericas
2142:     * (devolve o proprio valor quando ja eh numerico) e ConverterParaLogico
2143:     * nas bit; os tres CheckBox sobre numeric(1,0) viram {0,1} com
2144:     * IIF(ConverterParaLogico(...), 1, 0), que aceita .Value logico ou
2145:     * numerico sem supor o que o driver entregou. tpbarras vai DIRETO, sem
2146:     * +1/-1 e sem promover 0 (regra #45).
2147:     *
2148:     * tipos NAO eh gravado por este metodo, e isso eh fidelidade: no legado o
2149:     * Cmb_Tipo nao tem ControlSource - ele escolhe QUAL linha a tela edita,
2150:     * nunca renomeia o dispositivo. cidchaves e nomeimp tambem ficam de fora
2151:     * por nao terem controle no SCX (quem as cobre eh o INSERT do BO).
2152:     *
2153:     * Linha corrente AUSENTE (cursor fechado ou em EOF) devolve .F. SEM
2154:     * escrever nada - REPLACE em EOF nao tem alvo. No VFP9 um SEEK que falha
2155:     * deixa o ponteiro justamente em EOF, e o legado tem esse mesmo
2156:     * comportamento no [If Seek(...)] do InteractiveChange.
2157:     *
2158:     * PROTECTED pelo MESMO motivo do BOParaForm: o FormBase declara
2159:     * [PROTECTED PROCEDURE FormParaBO()] (formbase.prg:285) e o PROTECTED da
2160:     * base prevalece sobre o override. O unico chamador eh o
2161:     * BtnConfirmarClick, com THIS. (regra #8).
2162:     *==========================================================================
2163:     PROTECTED FUNCTION FormParaBO()
2164:         LOCAL loc_lResultado, loc_oErro
2165:         LOCAL loc_nPortas, loc_cHands, loc_cSettings, loc_lDtrs, loc_lRtss
2166:         LOCAL loc_nInbufs, loc_nOutbufs, loc_nInmodes, loc_nInlens
2167:         LOCAL loc_cTplechqs, loc_nBompara, loc_nNominal, loc_nCruzado
2168:         LOCAL loc_nTpbarras
2169: 
2170:         loc_lResultado = .F.
2171: 
2172:         TRY
2173:             IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
2174:                AND PEMSTATUS(THIS, "cbo_4c_Cmb_Tipo", 5) ;
2175:                AND USED("cursor_4c_Dados")
2176: 
2177:                 IF !EOF("cursor_4c_Dados")
2178:                     *-- Bloco da porta serial
2179:                     loc_nPortas   = ConverterParaNumero(THIS.obj_4c_Spinner1.Value)
2180:                     loc_cHands    = THIS.cbo_4c_Cmb_Hand.Value
2181:                     loc_cSettings = THIS.txt_4c_Set.Value
2182: 
2183:                     *-- bit -> LOGICO
2184:                     loc_lDtrs = ConverterParaLogico(THIS.chk_4c_Chk_dtr.Value)
2185:                     loc_lRtss = ConverterParaLogico(THIS.chk_4c_Chk_rts.Value)
2186: 
2187:                     *-- Buffers e modo de leitura
2188:                     loc_nInbufs  = ConverterParaNumero(THIS.txt_4c_Inbuf.Value)
2189:                     loc_nOutbufs = ConverterParaNumero(THIS.txt_4c_Outbuf.Value)
2190:                     loc_nInmodes = ConverterParaNumero(THIS.txt_4c_Inmode.Value)
2191:                     loc_nInlens  = ConverterParaNumero(THIS.txt_4c_Inlen.Value)
2192: 
2193:                     *-- Bloco de cheque - tplechqs eh char(1): a INICIAL da
2194:                     *-- opcao escolhida no combo (T/S/P/M/C/K/H/U)
2195:                     loc_cTplechqs = LEFT(ALLTRIM(THIS.cbo_4c_Get_TpLeChq.Value), 1)
2196: 
2197:                     *-- numeric(1,0) {0,1}
2198:                     loc_nBompara = IIF(ConverterParaLogico(THIS.chk_4c_Chk_Bompara.Value), 1, 0)
2199:                     loc_nNominal = IIF(ConverterParaLogico(THIS.chk_4c_Chk_nominal.Value), 1, 0)
2200:                     loc_nCruzado = IIF(ConverterParaLogico(THIS.chk_4c_Chk_cruzado.Value), 1, 0)
2201: 
2202:                     *-- Indice 1-based do OptionGroup, DIRETO
2203:                     loc_nTpbarras = ConverterParaNumero(THIS.obj_4c_Opt_leitor.Value)
2204: 
2205:                     SELECT cursor_4c_Dados
2206:                     REPLACE portas   WITH loc_nPortas, ;
2207:                             hands    WITH loc_cHands, ;
2208:                             settings WITH loc_cSettings, ;
2209:                             dtrs     WITH loc_lDtrs, ;
2210:                             rtss     WITH loc_lRtss, ;
2211:                             inbufs   WITH loc_nInbufs, ;
2212:                             outbufs  WITH loc_nOutbufs, ;
2213:                             inmodes  WITH loc_nInmodes, ;
2214:                             inlens   WITH loc_nInlens, ;
2215:                             tplechqs WITH loc_cTplechqs, ;
2216:                             bompara  WITH loc_nBompara, ;
2217:                             nominal  WITH loc_nNominal, ;
2218:                             cruzado  WITH loc_nCruzado, ;
2219:                             tpbarras WITH loc_nTpbarras ;
2220:                         IN cursor_4c_Dados
2221: 
2222:                     THIS.this_oBusinessObject.CarregarDoCursor("cursor_4c_Dados")
2223: 
2224:                     loc_lResultado = .T.
2225:                 ENDIF
2226:             ENDIF
2227: 
2228:         CATCH TO loc_oErro
2229:             THIS.this_cMensagemErro = loc_oErro.Message
2230:             MsgErro(loc_oErro.Message + CHR(13) + ;
2231:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
2232:                     "Procedure: " + loc_oErro.Procedure, ;
2233:                     "Erro em FormSIGOPCPE.FormParaBO")
2234:             loc_lResultado = .F.
2235:         ENDTRY
2236: 
2237:         RETURN loc_lResultado
2238:     ENDFUNC
2239: 
2240:     *==========================================================================
2241:     * BtnCancelarClick - FASE 8 - o SIGOPCPE.cancela.Click do legado
2242:     *
2243:     *   Thisform.Release
2244:     *
2245:     * O objeto legado chama-se [cancela] e o Caption dele eh "Encerrar"
2246:     * (SECAO 2 do dump); no migrado ele eh o cmd_4c_Encerrar, e o handler
2247:     * ligado por BINDEVENT eh o BtnEncerrarClick - nomeado pelo objeto do
2248:     * migrado, como manda o PILAR 3. Este metodo eh o MESMO evento sob o
2249:     * nome do objeto legado, e existe porque eh por ele que o harness de
2250:     * teste e o verificador de completude chamam a acao de cancelar.
2251:     *
2252:     * Delega em vez de repetir a linha: duas copias de [Release] seriam duas
2253:     * coisas para manter em sincronia se amanha o cancelamento precisar
2254:     * desfazer algo. Hoje nao precisa - sair sem gravar DESCARTA as
2255:     * alteracoes sozinho, porque o que o usuario digita vai para o
2256:     * cursor_4c_Dados e quem leva o cursor ao banco eh so o
2257:     * BtnConfirmarClick; o cursor morre com o form, no Destroy. Nao ha
2258:     * TABLEREVERT por isso e porque TABLEREVERT em cursor sem buffering
2259:     * dispara erro 1586 (CLAUDE.md regra #52).
2260:     *
2261:     * PUBLIC (sem PROTECTED): chamado de fora pelo harness (regra #51).
2262:     *==========================================================================
2263:     PROCEDURE BtnCancelarClick()
2264:         THIS.BtnEncerrarClick()
2265:     ENDPROC
2266: 
2267:     *==========================================================================
2268:     * TornarControlesVisiveis - Torna visiveis todos os controles do
2269:     * container informado, recursivamente (AddObject cria com Visible=.F.)
2270:     *==========================================================================
2271:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2272:         LOCAL loc_nI, loc_oControle
2273: 
2274:         IF VARTYPE(par_oContainer) != "O"
2275:             RETURN
2276:         ENDIF
2277: 
2278:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2279:             loc_oControle = par_oContainer.Controls(loc_nI)
2280: 
2281:             IF PEMSTATUS(loc_oControle, "Visible", 5)
2282:                 loc_oControle.Visible = .T.
2283:             ENDIF
2284: 
2285:             IF PEMSTATUS(loc_oControle, "ControlCount", 5) AND loc_oControle.ControlCount > 0
2286:                 THIS.TornarControlesVisiveis(loc_oControle)
2287:             ENDIF
2288:         ENDFOR
2289:     ENDPROC
2290: 
2291:     *==========================================================================
2292:     * Destroy - Fecha o cursor de dados (equivalente ao ThisForm.poDataMgr.
2293:     * Release do legado - aqui nao ha objeto de conexao per-form)
2294:     *==========================================================================
2295:     PROCEDURE Destroy()
2296:         IF USED("cursor_4c_Dados")
2297:             USE IN cursor_4c_Dados
2298:         ENDIF
2299: 
2300:         THIS.this_oBusinessObject = .NULL.
2301: 
2302:         DODEFAULT()
2303:     ENDPROC
2304: 
2305: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPCPEBO.prg):
*==============================================================================
* SIGOPCPEBO.prg - Business Object para Porta de Comunicacao (SIGOPCPE)
*
* Form OPERACIONAL de configuracao de hardware serial/paralelo.
* Tabela principal: SigSyCom (chave primaria: cidchaves char(20))
*
* Legado: SIGOPCPE.SCX - o Init() carrega TODA a tabela num cursor
* (crSigSyCom, query [Select * From SigSyCom]), indexa por Tipos
* (tag PesqTipo) e GARANTE a existencia dos 6 registros fixos de tipo de
* dispositivo, inserindo os que faltarem com Tipos + CidChaves = fUniqueIds()
* e repondo Settings = '9600,n,8,1' quando chega vazio. O usuario escolhe o
* dispositivo no Cmb_Tipo (que NAO tem ControlSource - ele apenas reposiciona
* o cursor via SEEK) e edita os campos da linha corrente; o botao Ok grava com
* poDataMgr.Update('crSigSyCom') + Commit() + fGrvSettings('CrSigSyCom').
*
* Mapeamento ControlSource legado -> propriedade (todas as 17 colunas de
* SigSyCom sao NOT NULL - ver docs/schema.sql):
*   Spinner1     -> crSigSyCom.portas    -> this_nPortas     numeric(1,0)
*   Cmb_Hand     -> crSigSyCom.hands     -> this_cHands      char(20)
*   Get_Set      -> crSigSyCom.settings  -> this_cSettings   char(20)
*   chk_dtr      -> crSigSyCom.dtrs      -> this_lDtrs       bit
*   chk_rts      -> crSigSyCom.rtss      -> this_lRtss       bit
*   Get_inbuf    -> crSigSyCom.inbufs    -> this_nInbufs     numeric(8,0)
*   Get_outbuf   -> crSigSyCom.outbufs   -> this_nOutbufs    numeric(8,0)
*   Get_inmode   -> crSigSyCom.inmodes   -> this_nInmodes    numeric(1,0)
*   Get_inlen    -> crSigSyCom.inlens    -> this_nInlens     numeric(8,0)
*   Get_TpLeChq  -> crSigSyCom.TpLeChqs  -> this_cTplechqs   char(1)
*   Opt_leitor   -> crSigSyCom.tpBarras  -> this_nTpbarras   numeric(1,0)
*   Chk_Bompara  -> crSigSyCom.bompara   -> this_nBompara    numeric(1,0)
*   chk_nominal  -> crSigSyCom.nominal   -> this_nNominal    numeric(1,0)
*   chk_cruzado  -> crSigSyCom.cruzado   -> this_nCruzado    numeric(1,0)
*   Cmb_Tipo     -> (sem ControlSource)  -> this_cTipos      char(20)
*   (sem controle na tela)               -> this_cCidchaves  char(20) - PK
*   (sem controle na tela)               -> this_cNomeimp    char(40)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SIGOPCPEBO AS BusinessBase

    *==========================================================================
    * Identificacao do registro / chave
    *==========================================================================
    *-- Tipos: char(20) - nome do dispositivo. No legado eh a chave de
    *-- pesquisa (Index On Tipos Tag PesqTipo) e o valor escolhido no
    *-- Cmb_Tipo; as comparacoes por SEEK usam PADR(...,20), porque o padding
    *-- faz parte da chave posicional do indice (CLAUDE.md regra #42).
    this_cTipos      = ""   && char(20) NOT NULL - tipo de dispositivo

    *-- CidChaves: char(20) - PRIMARY KEY (constraint sigsycom_cidchaves).
    *-- Gerada pelo fUniqueIds() do Fortyus no Insert Into do Init legado -
    *-- NUNCA vazia, senao o segundo registro colide no indice unico
    *-- (CLAUDE.md regra #22).
    this_cCidchaves  = ""   && char(20) NOT NULL - chave primaria

    *==========================================================================
    * Configuracao da porta serial (bloco esquerdo da tela, sempre visivel)
    *==========================================================================
    *-- Portas: numeric(1,0) - numero da porta de comunicacao. O Spinner1 do
    *-- legado limita 1..10 (SpinnerLowValue 1 / SpinnerHighValue 10,
    *-- KeyboardLowValue 1 / KeyboardHighValue 10) com Value inicial 1.
    this_nPortas     = 0    && numeric(1,0) NOT NULL - No. da porta COM

    *-- Hands: char(20) - HandShaking. O Cmb_Hand (RowSourceType 1) recebe no
    *-- Init legado os itens '0-None', '1-Xon Xoff', '2-RTS' e ' '; com
    *-- ControlSource char, o valor gravado eh o TEXTO do item escolhido.
    this_cHands      = ""   && char(20) NOT NULL - HandShaking

    *-- Settings: char(20) - configuracao da porta no formato
    *-- 'baud,paridade,databits,stopbits'. O Init legado repoe o default
    *-- '9600,n,8,1' em todo registro que chega vazio (this_cSettingsPadrao).
    this_cSettings   = ""   && char(20) NOT NULL - Settings da porta

    *-- Dtrs / Rtss: colunas bit do SQL Server, que chegam ao VFP como LOGICO
    *-- (.T./.F.) - por isso this_l*, e nao this_n* (bit -> LOGICAL;
    *-- numeric(1,0) -> NUMERIC). Ligadas a chk_dtr / chk_rts.
    this_lDtrs       = .F.  && bit NOT NULL - DTRenable
    this_lRtss       = .F.  && bit NOT NULL - RTSenable

    *-- Buffers e modo de leitura (Get_inbuf / Get_outbuf / Get_inmode /
    *-- Get_inlen). O dominio de InModes esta documentado na propria tela
    *-- pelo Say11: "( 0 - Text , 1- Binary )".
    this_nInbufs     = 0    && numeric(8,0) NOT NULL - InBufferMode
    this_nOutbufs    = 0    && numeric(8,0) NOT NULL - OutBufferMode
    this_nInmodes    = 0    && numeric(1,0) NOT NULL - InModes (0=Text, 1=Binary)
    this_nInlens     = 0    && numeric(8,0) NOT NULL - InLen

    *==========================================================================
    * Bloco de cheque (Say12/Say14/Say15/Say16 + controles) - o legado so
    * exibe estes controles quando Tipos = 'Leitora Cheques' OU
    * 'Impressora de Cheque' (Init e Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpLeChqs: char(1) - leitora de cheques. O Get_TpLeChq eh ComboBox com
    *-- Style = 2 (dropdown list) e RowSource
    *-- "T-Teclado ,S-Serial,P,M-Manual,C-Cheque Pre,K-Pertochek,H-Check-Pronto,U-USB";
    *-- com ControlSource char, o valor gravado eh a INICIAL da opcao
    *-- escolhida (T/S/P/M/C/K/H/U).
    this_cTplechqs   = ""   && char(1) NOT NULL - tipo de leitora de cheque

    *-- BomPara / Nominal / Cruzado: numeric(1,0) ligadas a CheckBox
    *-- (Chk_Bompara / chk_nominal / chk_cruzado). CheckBox sobre coluna
    *-- numerica grava 0 ou 1 - nao eh o indice 1-based de OptionGroup/
    *-- ComboBox -, por isso propriedade NUMERICA com dominio {0,1} e
    *-- conversao explicita nos dois sentidos no Form.
    this_nBompara    = 0    && numeric(1,0) NOT NULL - imprime "Bom Para"
    this_nNominal    = 0    && numeric(1,0) NOT NULL - imprime nominal
    this_nCruzado    = 0    && numeric(1,0) NOT NULL - imprime cruzado

    *==========================================================================
    * Bloco de leitor de codigo de barra (Say13 + Opt_leitor) - o legado
    * exibe quando Tipos = 'Leitora Codigo Barra' OU 'Leitora Cheques' (Init)
    * e tambem 'Impressora de Cheque' (Cmb_Tipo.InteractiveChange).
    *==========================================================================
    *-- TpBarras: numeric(1,0) ligada ao Opt_leitor, OptionGroup de 3 botoes
    *-- (Option1 "Serial", Option2 "Teclado", Option3 "Paralelo") com
    *-- ControlSource direto: o valor gravado eh a ORDEM do botao marcado
    *-- (1=Serial, 2=Teclado, 3=Paralelo), 1-based e SEM +1/-1
    *-- (CLAUDE.md regra #45). O SCX declara Value = 2, logo o default de
    *-- tela eh "Teclado".
    this_nTpbarras   = 0    && numeric(1,0) NOT NULL - 1=Serial 2=Teclado 3=Paralelo

    *==========================================================================
    * Coluna NOT NULL sem controle na tela
    *==========================================================================
    *-- NomeImp: char(40) - nome da impressora associada ao dispositivo. Nao
    *-- tem controle no SCX e nao eh citada em metodo nenhum do legado:
    *-- existia apenas no registro em branco do cursor (AddCursor sem lista
    *-- de colunas = Select * + TableUpdate) e por isso continuava sendo
    *-- gravada em branco. Declarada aqui porque eh NOT NULL e o INSERT da
    *-- Fase 2 tem de cobri-la (CLAUDE.md regra #22).
    this_cNomeimp    = ""   && char(40) NOT NULL - nome da impressora

    *==========================================================================
    * Estado / apoio ao fluxo do form
    *==========================================================================
    *-- Alias do cursor que recebe TODA a tabela (equivalente ao crSigSyCom
    *-- do legado). O form percorre/posiciona este cursor conforme o Cmb_Tipo.
    this_cCursorDados     = "cursor_4c_Dados"

    *-- Lista dos 6 tipos de dispositivo que o Init legado GARANTE existirem
    *-- na tabela, na mesma ordem em que sao inseridos e em que o Cmb_Tipo os
    *-- apresenta (AddItem). Preenchida no Init() porque "Balanca" leva
    *-- cedilha e literal acentuado em .PRG eh proibido (CLAUDE.md regra #4).
    this_cTiposPadrao     = ""
    this_nTotalTipos      = 6

    *-- Settings default aplicado pelo Init legado a todo registro cujo
    *-- Settings chega vazio. Fica em propriedade propria, e nao na lista
    *-- acima, porque o proprio valor contem virgulas.
    this_cSettingsPadrao  = "9600,n,8,1"

    *-- Tipo selecionado no Cmb_Tipo. Guardado separado de this_cTipos para o
    *-- form saber qual linha reposicionar sem depender do estado do cursor.
    this_cTipoSelecionado = ""

    *-- Quantidade de registros carregados no cursor de dados.
    this_nQtdeRegistros   = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal e a chave primaria REAL de SigSyCom
    * (cidchaves - constraint sigsycom_cidchaves, ver docs/schema.sql), monta
    * a lista dos 6 tipos de dispositivo usando CHR() no lugar dos acentos e
    * zera o estado de edicao herdado de BusinessBase.
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigSyCom")

            THIS.this_cTabela     = "SigSyCom"
            THIS.this_cCampoChave = "cidchaves"

            *-- Os 6 tipos fixos, na ordem dos Insert Into / AddItem do legado.
            *-- "Balanca" = "Balan" + CHR(231) + "a"  (CHR(231) = c-cedilha)
            THIS.this_cTiposPadrao = "Balan" + CHR(231) + "a" + ;
                                     ",Cupom Fiscal" + ;
                                     ",Leitora Cheques" + ;
                                     ",Leitora Codigo Barra" + ;
                                     ",Impressora de Cheque" + ;
                                     ",Gaveta Serial"
            THIS.this_nTotalTipos = 6

            *-- Estado inicial: consulta, nenhum registro posicionado.
            THIS.this_cTipoSelecionado = ""
            THIS.this_nQtdeRegistros   = 0
            THIS.this_lEmEdicao        = .F.
            THIS.this_lNovoRegistro    = .F.
            THIS.this_lDadosAlterados  = .F.
            THIS.this_cMensagemErro    = ""
            THIS.this_lErroExibido     = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SIGOPCPEBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterTipoPorIndice - Devolve o nome do tipo de dispositivo na posicao
    * informada (1..this_nTotalTipos), na mesma ordem do Cmb_Tipo legado.
    * Indice fora da faixa devolve string vazia.
    *
    * Sem PROTECTED de proposito: o Form chama de fora para popular o
    * Cmb_Tipo e para resolver a linha a posicionar no cursor (CLAUDE.md
    * regra #51 - metodo que o form chama nunca pode ser PROTECTED).
    *==========================================================================
    FUNCTION ObterTipoPorIndice(par_nIndice)
        LOCAL loc_cRetorno, loc_nLinhas
        LOCAL ARRAY loc_aTipos[1]
        loc_cRetorno = ""

        IF VARTYPE(par_nIndice) = "N" AND par_nIndice >= 1
            loc_nLinhas = ALINES(loc_aTipos, THIS.this_cTiposPadrao, 1, ",")
            IF par_nIndice <= loc_nLinhas
                loc_cRetorno = ALLTRIM(loc_aTipos[par_nIndice])
            ENDIF
        ENDIF

        RETURN loc_cRetorno
    ENDFUNC

    *==========================================================================
    * ObterChavePrimaria - Valor da chave primaria para a auditoria
    * (BusinessBase.RegistrarAuditoria). A PK de SigSyCom eh cidchaves.
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Mapeia TODAS as 17 colunas da linha corrente do
    * alias informado para as propriedades this_*. Usado tanto para a linha
    * reposicionada pelo Cmb_Tipo (equivalente ao Seek legado) quanto para o
    * proprio cursor_4c_Dados.
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF VARTYPE(par_cAliasCursor) = "C"
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cTipos     = TratarNulo(tipos, "")
                THIS.this_cCidchaves = TratarNulo(cidchaves, "")
                THIS.this_nPortas    = TratarNulo(portas, 0)
                THIS.this_cHands     = TratarNulo(hands, "")
                THIS.this_cSettings  = TratarNulo(settings, "")

                *-- dtrs/rtss sao colunas bit do SQL Server - chegam ao VFP
                *-- como LOGICO (CLAUDE.md regra correlata a bit/numeric(1,0)).
                THIS.this_lDtrs      = dtrs
                THIS.this_lRtss      = rtss

                THIS.this_nInbufs    = TratarNulo(inbufs, 0)
                THIS.this_nOutbufs   = TratarNulo(outbufs, 0)
                THIS.this_nInmodes   = TratarNulo(inmodes, 0)
                THIS.this_nInlens    = TratarNulo(inlens, 0)
                THIS.this_cTplechqs  = TratarNulo(tplechqs, "")
                THIS.this_nTpbarras  = TratarNulo(tpbarras, 0)
                THIS.this_nBompara   = TratarNulo(bompara, 0)
                THIS.this_nNominal   = TratarNulo(nominal, 0)
                THIS.this_nCruzado   = TratarNulo(cruzado, 0)
                THIS.this_cNomeimp   = TratarNulo(nomeimp, "")

                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Inserir - INSERT completo em SigSyCom (as 17 colunas, todas NOT NULL).
    *
    * cidchaves eh a PK Fortyus (CLAUDE.md regra #22): gerada por
    * fUniqueIds() quando ainda esta vazia, NUNCA deixada em branco -
    * senao o proximo registro colide no indice unico sigsycom_cidchaves.
    *==========================================================================
    PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "INSERT INTO SigSyCom " + ;
                    "(tipos, portas, dtrs, rtss, hands, settings, inbufs, outbufs, " + ;
                    "inmodes, inlens, tpbarras, cidchaves, tplechqs, bompara, cruzado, " + ;
                    "nominal, nomeimp) VALUES (" + ;
                    EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao incluir Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Incluir")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * Atualizar - UPDATE completo em SigSyCom, filtrado pela PK cidchaves.
    *==========================================================================
    PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado

        loc_lResultado  = .F.
        loc_lProsseguir = .T.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + ;
                CHR(227) + "o dispon" + CHR(237) + "vel."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir AND EMPTY(ALLTRIM(THIS.this_cCidchaves))
            THIS.this_cMensagemErro = "Registro sem chave prim" + CHR(225) + "ria - n" + ;
                CHR(227) + "o " + CHR(233) + " poss" + CHR(237) + "vel alterar."
            loc_lProsseguir = .F.
        ENDIF

        IF loc_lProsseguir
            TRY
                loc_cSQL = "UPDATE SigSyCom SET " + ;
                    "tipos = "    + EscaparSQL(LEFT(THIS.this_cTipos, 20)) + ", " + ;
                    "portas = "   + FormatarNumeroSQL(THIS.this_nPortas, 0) + ", " + ;
                    "dtrs = "     + IIF(THIS.this_lDtrs, "1", "0") + ", " + ;
                    "rtss = "     + IIF(THIS.this_lRtss, "1", "0") + ", " + ;
                    "hands = "    + EscaparSQL(LEFT(THIS.this_cHands, 20)) + ", " + ;
                    "settings = " + EscaparSQL(LEFT(THIS.this_cSettings, 20)) + ", " + ;
                    "inbufs = "   + FormatarNumeroSQL(THIS.this_nInbufs, 0) + ", " + ;
                    "outbufs = "  + FormatarNumeroSQL(THIS.this_nOutbufs, 0) + ", " + ;
                    "inmodes = "  + FormatarNumeroSQL(THIS.this_nInmodes, 0) + ", " + ;
                    "inlens = "   + FormatarNumeroSQL(THIS.this_nInlens, 0) + ", " + ;
                    "tpbarras = " + FormatarNumeroSQL(THIS.this_nTpbarras, 0) + ", " + ;
                    "tplechqs = " + EscaparSQL(LEFT(THIS.this_cTplechqs, 1)) + ", " + ;
                    "bompara = "  + FormatarNumeroSQL(THIS.this_nBompara, 0) + ", " + ;
                    "cruzado = "  + FormatarNumeroSQL(THIS.this_nCruzado, 0) + ", " + ;
                    "nominal = "  + FormatarNumeroSQL(THIS.this_nNominal, 0) + ", " + ;
                    "nomeimp = "  + EscaparSQL(LEFT(THIS.this_cNomeimp, 40)) + ;
                    " WHERE cidchaves = " + EscaparSQL(LEFT(THIS.this_cCidchaves, 20))

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ELSE
                    THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                    loc_lResultado = .F.
                ENDIF

            CATCH TO loc_oErro
                THIS.this_cMensagemErro = "Erro ao alterar Porta de Comunica" + ;
                    CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message
                MsgErro(THIS.this_cMensagemErro, "Erro ao Alterar")
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarDados - Monta o cursor de trabalho da tela (equivalente EXATO ao
    * bloco de abertura do Init legado).
    *
    * O legado faz, nesta ordem:
    *   .AddCursor('SigSyCom','Tipos','crSigSyCom','','',[Select * From SigSyCom])
    *   .ReQuery('crSigSyCom')
    *   Select crSigSyCom / Index On Tipos Tag PesqTipo / Go Top
    *   para cada um dos 6 tipos: If Not Seek(Padr(<tipo>,20))
    *                                 Insert Into crSigSyCom (Tipos, CidChaves) ...
    *                             EndIf
    *                             If IsEmpty(Settings) -> Replace com '9600,n,8,1'
    *
    * Reproduzido aqui porque esse cursor NAO eh um detalhe de carga: os
    * controles da tela sao ligados a ele por ControlSource (como no legado),
    * entao ele tem de EXISTIR e estar POSICIONADO antes de
    * ConfigurarCamposPrincipais rodar - ControlSource apontando para alias
    * fechado derruba o Init inteiro com [Alias ... is not found]
    * (CLAUDE.md regra #41). Por isso o Form chama este metodo ANTES de criar
    * os campos, e por isso o ramo sem conexao tambem cria o cursor (com a
    * estrutura das 17 colunas de SigSyCom): sem alias vivo a tela nao abre
    * nem em modo de teste.
    *
    * READWRITE eh obrigatorio: os controles editam a linha corrente e o
    * bloco de semeadura faz INSERT/REPLACE no proprio cursor - cursor de
    * SQLEXEC nasce SOMENTE-LEITURA.
    *
    * Sem PROTECTED de proposito - o Form chama de fora (CLAUDE.md regra #51).
    *==========================================================================
    PROCEDURE CarregarDados()
        LOCAL loc_lResultado, loc_lProsseguir, loc_cSQL, loc_nResultado
        LOCAL loc_nI, loc_cTipo, loc_cAlias, loc_cAliasTmp, loc_oErro

        loc_lResultado  = .F.
        loc_lProsseguir = .T.
        loc_cAlias      = THIS.this_cCursorDados
        loc_cAliasTmp   = loc_cAlias + "_Tmp"

        TRY
            *-- Fecha o alias anterior. O TABLEREVERT so entra se houver
            *-- buffering de verdade: sem buffering ele NAO eh no-op, dispara
            *-- erro 1586 (CLAUDE.md regra #52). USE IN fecha o alias mesmo
            *-- com buffer sujo.
            IF USED(loc_cAlias)
                IF CURSORGETPROP("Buffering", loc_cAlias) > 1
                    TABLEREVERT(.T., loc_cAlias)
                ENDIF
                USE IN (loc_cAlias)
            ENDIF
            IF USED(loc_cAliasTmp)
                USE IN (loc_cAliasTmp)
            ENDIF

            IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
                *-- Mesma query do lcQryCFis legado: a tabela INTEIRA.
                loc_cSQL = "SELECT tipos, portas, dtrs, rtss, hands, settings, " + ;
                    "inbufs, outbufs, inmodes, inlens, tpbarras, cidchaves, " + ;
                    "tplechqs, bompara, cruzado, nominal, nomeimp FROM SigSyCom"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, loc_cAliasTmp)

                *-- SELECT bem-sucedido devolve 1 (um result set). O > 0 eh
                *-- estrito de proposito: o passo seguinte DEPENDE do cursor
                *-- temporario existir.
                IF loc_nResultado > 0
                    *-- SQLEXEC gera cursor SOMENTE-LEITURA; READWRITE eh
                    *-- obrigatorio porque os controles editam a linha e a
                    *-- semeadura faz INSERT/REPLACE no proprio cursor.
                    SELECT * FROM (loc_cAliasTmp) INTO CURSOR (loc_cAlias) READWRITE
                    IF USED(loc_cAliasTmp)
                        USE IN (loc_cAliasTmp)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Erro ao carregar Porta de Comunica" + ;
                        CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL()
                    MsgErro(THIS.this_cMensagemErro, "Erro ao Carregar")
                    loc_lProsseguir = .F.
                ENDIF
            ELSE
                *-- Sem conexao (modo de teste / validacao de UI): cursor vazio
                *-- com a estrutura REAL de SigSyCom (docs/schema.sql). dtrs e
                *-- rtss sao Logicos porque bit do SQL Server chega ao VFP
                *-- como Logico - e sao eles que alimentam os CheckBox ligados
                *-- por ControlSource.
                CREATE CURSOR (loc_cAlias) ( ;
                    tipos     C(20), ;
                    portas    N(1, 0), ;
                    dtrs      L, ;
                    rtss      L, ;
                    hands     C(20), ;
                    settings  C(20), ;
                    inbufs    N(8, 0), ;
                    outbufs   N(8, 0), ;
                    inmodes   N(1, 0), ;
                    inlens    N(8, 0), ;
                    tpbarras  N(1, 0), ;
                    cidchaves C(20), ;
                    tplechqs  C(1), ;
                    bompara   L, ;
                    cruzado   L, ;
                    nominal   L, ;
                    nomeimp   C(40) )
            ENDIF

            IF loc_lProsseguir
                SELECT (loc_cAlias)

                *-- Index On Tipos Tag PesqTipo + Go Top do legado. A tag eh
                *-- consultada por SEEK a partir do Cmb_Tipo; chave de coluna
                *-- UNICA (char(20)), logo o SEEK usa PADR(...,20) e casa
                *-- exato mesmo com SET EXACT ON.
                INDEX ON tipos TAG PesqTipo
                GO TOP

                *-- Semeadura dos 6 tipos, igual ao legado: o que faltar eh
                *-- inserido com Tipos + CidChaves = fUniqueIds(); as demais
                *-- colunas ficam no valor em branco do cursor, exatamente
                *-- como no Insert Into de duas colunas do legado. Em seguida,
                *-- Settings vazio recebe o default '9600,n,8,1'.
                FOR loc_nI = 1 TO THIS.this_nTotalTipos
                    loc_cTipo = THIS.ObterTipoPorIndice(loc_nI)

                    IF !EMPTY(loc_cTipo)
                        IF !SEEK(PADR(loc_cTipo, 20), loc_cAlias, "PesqTipo")
                            INSERT INTO (loc_cAlias) (tipos, cidchaves) ;
                                VALUES (PADR(loc_cTipo, 20), LEFT(fUniqueIds(), 20))
                        ENDIF

                        IF EMPTY(ALLTRIM(EVALUATE(loc_cAlias + ".settings")))
                            REPLACE settings WITH THIS.this_cSettingsPadrao ;
                                IN (loc_cAlias)
                        ENDIF
                    ENDIF
                ENDFOR

                SELECT (loc_cAlias)
                GO TOP

                THIS.this_nQtdeRegistros = RECCOUNT(loc_cAlias)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao carregar Porta de Comunica" + CHR(231) + CHR(227) + "o:" + ;
                    CHR(13) + loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro ao Carregar")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

