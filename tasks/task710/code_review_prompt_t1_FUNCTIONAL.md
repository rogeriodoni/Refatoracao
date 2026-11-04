# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Itens define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Itens.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Rodape define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Rodape.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpCpo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1778 linhas total):

*-- Linhas 7 a 278:
7: *
8: * O legado nao tem Page1=Lista/Page2=Dados: e um dialogo unico (WindowType=1,
9: * 1000x600, TitleBar=0, ControlBox=.F., Movable=.F.) aberto por um form PAI
10: * (PROCEDURE Init legado: LParameters pFrm, pKey / .ParentForm = pFrm /
11: * .ParentForm.Enabled = .f.). Mostra a composicao do produto informado em
12: * pKey numa grade (grdItens), deixa o usuario marcar os componentes
13: * desejados, totaliza as linhas marcadas numa 2a grade (grdRodape) e devolve
14: * a selecao ao fechar - btnConfirmar mantem so as linhas marcadas, btnSair
15: * descarta todas (ThisForm.Release, que reabilita o form pai).
16: *
17: * Fase 1/8 e Fase 2/8 (BO): SigOpCpoBO.prg - propriedades, Init,
18: * CarregarProduto/CarregarComposicao/CarregarTipos/AplicarFiltroTipo/
19: * AtualizarTotais/ConfirmarSelecao/CancelarSelecao/DecodificarImagem.
20: *
21: * Fase 3/8 - ESTRUTURA BASE: esqueleto da classe (propriedades, Init()
22: * recebendo form pai + produto, InicializarForm(), Destroy()) e o cabecalho
23: * (cnt_4c_Sombra/lbl_4c_LblSombra/lbl_4c_LblTitulo), com geometria
24: * TRANSCRITA do dump.
25: *
26: * Fase 4/8 (este bloco): grade de componentes (grd_4c_Itens, equivalente a
27: * grdItens) + grade de totais (grd_4c_Rodape, equivalente a grdRodape) +
28: * CommandGroup de saida (cmg_4c_Botoes, equivalente a cntBotoes) + o metodo
29: * CarregarDados() (equivalente a SelecionaDados/AtuaTotas), que popula os
30: * cursores da BO ANTES das grades serem montadas - Column.ControlSource
31: * exige o cursor ja existente (regra #41). ComboBox de tipos e Image
32: * (Fases 5-6) e os eventos reais (Check1 da grade, Valid do combo, Click
33: * dos botoes, DblClick da imagem - Fase 7) entram nos blocos seguintes.
34: *
35: * Fase 5/8: label + combobox de filtro por tipo de composicao
36: * (lbl_4c_Label1/cbo_4c_CmbTipos, equivalentes a Say1/cmbTipos do legado),
37: * ligado ao cursor_4c_Tipos ja populado pela BO em CarregarTipos().
38: *
39: * Fase 6/8 (este bloco): ultimos controles e a VALIDACAO DE CAMPO do
40: * legado, ligada por BINDEVENT -
41: *   - Image de zoom do componente (img_4c_ImgFigJpg, equivalente a
42: *     ImgFigJpg do legado) - nasce oculta, igual ao legado (regra de
43: *     container flutuante: excluida de TornarControlesVisiveis);
44: *   - ValidarFiltroTipo(): o PROCEDURE Valid do cmbTipos legado
45: *     (Select crGrade / Set Filter To Tipos = cmbTipos.Value In crGrade /
46: *     Go Top In crGrade / ThisForm.grdItens.Refresh), delegando a
47: *     THIS.this_oBusinessObject.AplicarFiltroTipo();
48: *   - AtualizarRodape(par_nRegistroGrade): funil UNICO de repintura da
49: *     grade + grade de totais + Buttons(1).Enabled (regra #21 - popular
50: *     cursor NAO repinta a grade; o repaint tem de rodar em TODO caminho
51: *     que mexe no cursor), chamado pela validacao do combo com 0 (GO TOP,
52: *     como o legado) e reusado na Fase 7 pelo toggle do checkbox, que
53: *     passa o RECNO para a grade nao saltar;
54: *   - ValidarFocoRodape(): o GotFocus de grdRodape.Column1.Text1 legado
55: *     (ThisForm.grdItens.Column1.SetFocus) - a grade de totais eh
56: *     somente-leitura e devolve o foco a grade de itens;
57: *   - ValidarTagRodapeGotFocus()/ValidarTagRodapeLostFocus(): o par
58: *     GotFocus (This.Tag = This.Value) / LostFocus (This.Value =
59: *     This.Tag) de grdRodape.Column2.Text1 legado, que restaura o valor
60: *     original da celula caso algo a tenha alterado.
61: *
62: * NAO HA LOOKUP (FormBuscaAuxiliar) NESTE FORM: o codigo fonte original
63: * (tasks/task710/SigOpCpo_form_codigo_fonte.txt) nao tem nenhum
64: * CreateObject('fwBuscaExt'/'fwBuscaSel',...) nem chamada a sigacess() nem
65: * PROCEDURE Valid/KeyPress abrindo picker por F4/F5 - este dialogo so
66: * exibe a composicao do produto-pai (grd_4c_Itens) com uma linha por
67: * componente para o usuario MARCAR/DESMARCAR (checkbox da Column1) e
68: * filtrar por tipo (cbo_4c_CmbTipos, ja ligado ao cursor_4c_Tipos). PILAR
69: * 1/migration_guide.md proibem inventar lookup que o legado nao tem, e
70: * por isso nao existe AbrirLookup*/AbrirBusca* aqui: a superficie de
71: * campo desta fase eh o combo de tipo + a validacao dele.
72: *
73: * Os eventos de ACAO (Check1 da grade, AfterRowColChange da grade, Click
74: * dos 2 botoes do cmg_4c_Botoes, Click da imagem) entram na Fase 7.
75: *==============================================================================
76: 
77: DEFINE CLASS FormSigOpCpo AS FormBase
78: 
79:     Height       = 600
80:     Width        = 1000
81:     Caption      = ""
82:     TitleBar     = 0
83:     ShowWindow   = 1
84:     ControlBox   = .F.
85:     Movable      = .F.
86:     MaxButton    = .F.
87:     MinButton    = .F.
88:     WindowType   = 0
89:     DataSession  = 1
90:     BorderStyle  = 2
91:     AutoCenter   = .T.
92: 
93:     *-- Form pai que abriu o dialogo (.ParentForm legado) - fica desabilitado
94:     *-- enquanto este dialogo estiver aberto e eh reabilitado no Destroy
95:     *-- (equivalente ao PROCEDURE Release legado: ThisForm.ParentForm.Enabled
96:     *-- = .t. / =DoDefault()).
97:     this_oFormPai = .NULL.
98: 
99:     *-- Produto-pai cuja composicao esta sendo exibida (.lpKey legado,
100:     *-- recebido via Init(par_oFormPai, par_cCpros) e repassado ao BO em
101:     *-- THIS.this_oBusinessObject.CarregarProduto()).
102:     this_cCprosParam = ""
103: 
104:     *-- Ultimo tipo de composicao de fato aplicado como filtro em
105:     *-- cursor_4c_Grade. Guarda de valor-nao-mudou de ValidarFiltroTipo():
106:     *-- o Valid do legado roda ao SAIR do combo, e aqui a validacao esta
107:     *-- ligada a DOIS eventos (InteractiveChange, para reagir na hora em que
108:     *-- o usuario escolhe o item do dropdown Style=2, e LostFocus, que eh o
109:     *-- equivalente literal do Valid). Sem esta guarda o filtro seria
110:     *-- reaplicado e a grade repintada duas vezes por escolha.
111:     this_cTipoFiltroAtual = ""
112: 
113:     *-- Guarda de reentrancia de ValidarFiltroTipo(): a repintura da grade
114:     *-- mexe no foco (grd_4c_Itens.Refresh) e pode redisparar o LostFocus do
115:     *-- combo, reentrando no proprio handler. Ligada pelo wrapper
116:     *-- ValidarFiltroTipo() e liberada por ele DEPOIS do corpo
117:     *-- (ValidarFiltroTipoExec()), para a flag nunca travar ligada quando o
118:     *-- corpo sair por um RETURN antecipado (regra #47).
119:     this_lEmFiltroTipo = .F.
120: 
121:     *-- Guarda de reentrancia de AtualizarRodape(), o funil UNICO de
122:     *-- sincronismo form <-> BO <-> controles desta tela (FormParaBO() ->
123:     *-- AtualizarTotais() -> BOParaForm()). O funil mexe no ponteiro de
124:     *-- cursor_4c_Grade (GO TOP / GO <recno>) e chama grd_4c_Itens.Refresh(),
125:     *-- e as duas coisas disparam o AfterRowColChange da grade, que por sua
126:     *-- vez chama o funil de novo. A cadeia termina sozinha (o 2o passe repoe
127:     *-- o ponteiro na MESMA linha e nao gera evento novo), mas depender disso
128:     *-- eh fragil: a flag garante que cada acao do usuario produza UM passe.
129:     this_lEmAtualizacao = .F.
130: 
131:     *--------------------------------------------------------------------------
132:     * Init - recebe o form pai e o produto, desabilita o pai (equivalente ao
133:     * ".ParentForm = pFrm / .ParentForm.Enabled = .f." do Init legado) e
134:     * delega o resto da inicializacao a FormBase.Init() -> InicializarForm().
135:     *--------------------------------------------------------------------------
136:     PROCEDURE Init(par_oFormPai, par_cCpros)
137:         THIS.Caption = "Composi" + CHR(231) + CHR(227) + "o de Produtos"
138: 
139:         THIS.this_oFormPai = IIF(VARTYPE(par_oFormPai) = "O", par_oFormPai, .NULL.)
140:         IF VARTYPE(THIS.this_oFormPai) = "O"
141:             THIS.this_oFormPai.Enabled = .F.
142:         ENDIF
143: 
144:         THIS.this_cCprosParam = IIF(VARTYPE(par_cCpros) = "C", par_cCpros, "")
145: 
146:         *-- WindowType=1 (modal top-level) causaria TIMEOUT em VFP9 -T. Classe
147:         *-- definida com WindowType=0; producao restaura para modal aqui, fora
148:         *-- de teste/validacao de UI (mesmo padrao de FormSIGOPCCO/FormSigOpCcl).
149:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
150:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
151:             THIS.WindowType = 1
152:             THIS.ShowWindow = 1
153:         ENDIF
154: 
155:         RETURN DODEFAULT()
156:     ENDPROC
157: 
158:     *--------------------------------------------------------------------------
159:     * InicializarForm - cria o Business Object, valida o produto-pai
160:     * (equivalente ao CursorQuery(SigCdPro,...)+Release do Init legado quando
161:     * o produto nao existe) e monta o cabecalho. Grade/combo/botoes/imagem
162:     * entram nas proximas fases.
163:     *--------------------------------------------------------------------------
164:     PROTECTED PROCEDURE InicializarForm()
165:         LOCAL loc_lSucesso, loc_oErro
166:         loc_lSucesso = .F.
167: 
168:         TRY
169:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpCpoBO")
170: 
171:             IF VARTYPE(THIS.this_oBusinessObject) != "O" OR !THIS.this_oBusinessObject.Init()
172:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigOpCpoBO." + CHR(13) + ;
173:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
174:                         "Erro em InicializarForm")
175:             ELSE
176:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
177: 
178:                 IF !THIS.this_oBusinessObject.CarregarProduto(THIS.this_cCprosParam)
179:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
180:                             "Aten" + CHR(231) + CHR(227) + "o!!!")
181:                 ELSE
182:                     THIS.Caption = ALLTRIM(THIS.Caption) + " - " + ;
183:                         ALLTRIM(THIS.this_oBusinessObject.this_cCpros) + " - " + ;
184:                         ALLTRIM(THIS.this_oBusinessObject.this_cDprosProduto)
185: 
186:                     THIS.ConfigurarCabecalho()
187: 
188:                     THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
189:                     THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
190: 
191:                     *-- CarregarDados() PRIMEIRO: popula cursor_4c_Grade/
192:                     *-- cursor_4c_Rodape via BO antes de qualquer Grid ser
193:                     *-- montado (regra #41 - Column.ControlSource exige o
194:                     *-- cursor ja existente).
195:                     THIS.CarregarDados()
196:                     THIS.ConfigurarGridItens()
197:                     THIS.ConfigurarGridRodape()
198:                     THIS.ConfigurarFiltroTipo()
199:                     THIS.ConfigurarBotoes()
200:                     THIS.ConfigurarImagem()
201: 
202:                     THIS.TornarControlesVisiveis(THIS)
203: 
204:                     *-- Trecho FINAL do selecionadados legado (Go Top +
205:                     *-- grdItens.Refresh + Column1.SetFocus + Go Top In
206:                     *-- crRodape + grdRodape.Refresh): popular o cursor NAO
207:                     *-- repinta a grade (regra #21), e o repaint tem de rodar
208:                     *-- DEPOIS de TornarControlesVisiveis - Refresh em
209:                     *-- controle invisivel nao pinta.
210:                     THIS.CarregarLista()
211: 
212:                     loc_lSucesso = .T.
213:                 ENDIF
214:             ENDIF
215:         CATCH TO loc_oErro
216:             MsgErro(loc_oErro.Message + CHR(13) + ;
217:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
218:                     "Procedure: " + loc_oErro.Procedure, ;
219:                     "Erro em InicializarForm")
220:         ENDTRY
221: 
222:         RETURN loc_lSucesso
223:     ENDPROC
224: 
225:     *--------------------------------------------------------------------------
226:     * ConfigurarCabecalho - container cinza (cntSombra do legado) com os dois
227:     * labels de titulo sobrepostos (sombra preta + titulo branco).
228:     * Geometria TRANSCRITA do dump: SIGOPCPO.cntSombra/lblSombra/lblTitulo.
229:     *--------------------------------------------------------------------------
230:     PROTECTED PROCEDURE ConfigurarCabecalho()
231:         THIS.AddObject("cnt_4c_Sombra", "Container")
232:         WITH THIS.cnt_4c_Sombra
233:             .Top         = 0
234:             .Left        = 0
235:             .Width       = THIS.Width
236:             .Height      = 80
237:             .BackColor   = RGB(100, 100, 100)
238:             .BackStyle   = 1
239:             .BorderWidth = 0
240:             .Visible     = .T.
241:         ENDWITH
242: 
243:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblSombra", "Label")
244:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblSombra
245:             .Top           = 18
246:             .Left          = 10
247:             .Width         = 769
248:             .Height        = 40
249:             .AutoSize      = .F.
250:             .BackStyle     = 0
251:             .WordWrap      = .T.
252:             .Alignment     = 0
253:             .FontName      = "Tahoma"
254:             .FontSize      = 18
255:             .FontBold      = .T.
256:             .FontUnderline = .F.
257:             .ForeColor     = RGB(0, 0, 0)
258:             .Caption       = THIS.Caption
259:             .Visible       = .T.
260:         ENDWITH
261: 
262:         THIS.cnt_4c_Sombra.AddObject("lbl_4c_LblTitulo", "Label")
263:         WITH THIS.cnt_4c_Sombra.lbl_4c_LblTitulo
264:             .Top         = 17
265:             .Left        = 10
266:             .Width       = 769
267:             .Height      = 46
268:             .AutoSize    = .F.
269:             .BackStyle   = 0
270:             .WordWrap    = .T.
271:             .Alignment   = 0
272:             .FontName    = "Tahoma"
273:             .FontSize    = 18
274:             .FontBold    = .T.
275:             .ForeColor   = RGB(255, 255, 255)
276:             .Caption     = THIS.Caption
277:             .ToolTipText = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
278:             .Visible     = .T.

*-- Linhas 295 a 474:
295:     * MESMAS colunas de SigOpCpoBO.CarregarComposicao(), para a grade montar
296:     * sem erro mesmo com a composicao vazia.
297:     *--------------------------------------------------------------------------
298:     PROTECTED PROCEDURE CarregarDados()
299:         LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape
300:         loc_lSucesso      = .F.
301:         loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
302:         loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape
303: 
304:         IF THIS.this_oBusinessObject.CarregarComposicao()
305:             loc_lSucesso = .T.
306:         ELSE
307:             MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
308:                     "Erro ao Carregar Composi" + CHR(231) + CHR(227) + "o")
309:         ENDIF
310: 
311:         IF !USED(loc_cCursorGrade)
312:             SET NULL ON
313:             CREATE CURSOR (loc_cCursorGrade) ;
314:                 (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
315:                  Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
316:                  Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
317:                  FigJpgs M, Tipos C(20))
318:             SET NULL OFF
319:         ENDIF
320: 
321:         IF USED(loc_cCursorRodape)
322:             USE IN (loc_cCursorRodape)
323:         ENDIF
324: 
325:         SET NULL ON
326:         CREATE CURSOR (loc_cCursorRodape) (Descrs C(100), Usuars C(10), Totas N(12,2))
327:         SET NULL OFF
328: 
329:         *-- "Insert Into crRodape (Totas) Values (0)" do selecionadados legado.
330:         *-- O REPLACE vai com "IN (<alias>)" EXPLICITO: AtualizarTotais() do
331:         *-- BO faz "SELECT ... INTO CURSOR <tmp>" seguido de "USE IN <tmp>", e
332:         *-- fechar o cursor CORRENTE deixa a work area VAZIA - um REPLACE sem
333:         *-- alias logo depois estoura "No table is open in the current work
334:         *-- area." e derruba o InicializarForm (o form nao abre).
335:         SELECT (loc_cCursorRodape)
336:         APPEND BLANK
337:         REPLACE Totas WITH 0 IN (loc_cCursorRodape)
338: 
339:         IF loc_lSucesso AND THIS.this_oBusinessObject.this_nQtdeComponentes > 0
340:             THIS.this_oBusinessObject.AtualizarTotais()
341:             REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
342:                 IN (loc_cCursorRodape)
343:         ENDIF
344: 
345:         IF USED(loc_cCursorGrade)
346:             SELECT (loc_cCursorGrade)
347:             GO TOP
348:         ENDIF
349: 
350:         SELECT (loc_cCursorRodape)
351:         GO TOP
352: 
353:         RETURN loc_lSucesso
354:     ENDPROC
355: 
356:     *--------------------------------------------------------------------------
357:     * ConfigurarGridItens - grade de componentes da composicao (grdItens do
358:     * legado), ligada a cursor_4c_Grade (ja populado por CarregarDados()).
359:     * Geometria e colunas TRANSCRITAS do dump (SIGOPCPO.grdItens +
360:     * PROCEDURE montagrades): 8 colunas, Column.InputMask/ControlSource
361:     * sao propriedades que a Column repassa ao CurrentControl - igual ao
362:     * legado. Ordem de configuracao segue o padrao canonico (ColumnCount ->
363:     * RecordSource -> ControlSource -> Header1.Caption -> Width por ultimo -
364:     * Problema 48/regra #41): mexer em Width ANTES de RecordSource/
365:     * ControlSource estabilizarem reseta tudo para o default 90.
366:     *
367:     * Column1 recebe CheckBox via AddObject + CurrentControl + Sparse = .F.
368:     * (regra #18 - AddObject sozinho NAO faz o controle aparecer). O For
369:     * Movable/Resizable/ReadOnly do legado (.Column&lcCol..ReadOnly =
370:     * (I > 1)) foi transcrito coluna a coluna: Column1 fica EDITAVEL (o
371:     * checkbox), Column2-8 continuam ReadOnly - e o ReadOnly de Column vem
372:     * DEPOIS do ReadOnly do Grid (regra #18).
373:     *--------------------------------------------------------------------------
374:     PROTECTED PROCEDURE ConfigurarGridItens()
375:         THIS.AddObject("grd_4c_Itens", "Grid")
376:         WITH THIS.grd_4c_Itens
377:             .Top               = 198
378:             .Left              = 10
379:             .Width             = 980
380:             .Height            = 371
381:             .FontName          = "Tahoma"
382:             .FontSize          = 8
383:             .AllowHeaderSizing = .F.
384:             .AllowRowSizing    = .F.
385:             .DeleteMark        = .F.
386:             .RecordMark        = .F.
387:             .HeaderHeight      = 16
388:             .RowHeight         = 18
389:             .ScrollBars        = 2
390:             .GridLineColor     = RGB(238, 238, 238)
391:             .ToolTipText       = "Grade de Produtos"
392:             .ReadOnly          = .T.
393:         ENDWITH
394: 
395:         *-- Vinculo ao cursor + colunas: extraido para VincularGradeItens()
396:         *-- porque CarregarLista() tem de poder REFAZE-LO (Problema 48 -
397:         *-- re-atribuir RecordSource reseta Column.Width/Header1.Caption e
398:         *-- destroi o CurrentControl do CheckBox). Chamado DEPOIS do
399:         *-- .ReadOnly = .T. do Grid, porque o ReadOnly do grid propaga para
400:         *-- as colunas e sobrescreveria o Column1.ReadOnly = .F. (regra #18).
401:         THIS.VincularGradeItens()
402: 
403:         WITH THIS.grd_4c_Itens
404:             .Visible = .T.
405:         ENDWITH
406: 
407:         *-- AfterRowColChange de SIGOPCPO.grdItens: decodifica a imagem do
408:         *-- componente corrente (equivalente a ImgFigJpg.Picture/Visible do
409:         *-- legado) e recalcula os totais (ThisForm.AtuaTotas). Nao filtra
410:         *-- par_nColIndex - carrega o detalhe da linha corrente, uso correto
411:         *-- deste evento (regra #46). Ligado AQUI, e nao em
412:         *-- VincularGradeItens(), porque o objeto Grid nunca eh recriado: um
413:         *-- 2o BINDEVENT do mesmo par (objeto, evento) somaria uma segunda
414:         *-- chamada ao mesmo handler a cada re-vinculo.
415:         BINDEVENT(THIS.grd_4c_Itens, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
416:     ENDPROC
417: 
418:     *--------------------------------------------------------------------------
419:     * VincularGradeItens - liga grd_4c_Itens a cursor_4c_Grade e configura as
420:     * 8 colunas. Extraido de ConfigurarGridItens() para ser REUSADO por
421:     * CarregarLista(): a ordem canonica eh ColumnCount -> RecordSource ->
422:     * ControlSource -> Header1.Caption -> Width por ULTIMO (Problema 48 /
423:     * regra #41), porque re-atribuir RecordSource reseta Width e Caption para
424:     * o default 90/"Header1" e DESTROI o CurrentControl do CheckBox da
425:     * Column1 (regra #18) - quem re-vincula tem de repetir o bloco INTEIRO.
426:     *
427:     * ColumnCount so eh tocado quando esta diferente de 8: atribuir
428:     * ColumnCount RECRIA os objetos Column, matando o CheckBox e os
429:     * BINDEVENT dele. Por isso os 4 handlers do CheckBox sao ligados APENAS
430:     * no passe em que o controle de fato nasce (AddObject) - religar sem o
431:     * AddObject somaria uma 2a chamada do mesmo handler por evento, e o
432:     * toggle da marcacao se anularia.
433:     *--------------------------------------------------------------------------
434:     PROTECTED PROCEDURE VincularGradeItens()
435:         LOCAL loc_cCursor, loc_lCriouCheck
436:         loc_cCursor    = THIS.this_oBusinessObject.this_cCursorGrade
437:         loc_lCriouCheck = .F.
438: 
439:         WITH THIS.grd_4c_Itens
440:             IF .ColumnCount != 8
441:                 .ColumnCount = 8
442:             ENDIF
443: 
444:             .RecordSource = loc_cCursor
445: 
446:             .Column1.ControlSource = loc_cCursor + ".Marcas"
447:             .Column2.ControlSource = loc_cCursor + ".Mats"
448:             .Column3.ControlSource = loc_cCursor + ".Dpros"
449:             .Column4.ControlSource = loc_cCursor + ".Qtds"
450:             .Column5.ControlSource = loc_cCursor + ".UniCompos"
451:             .Column6.ControlSource = loc_cCursor + ".PCompos"
452:             .Column7.ControlSource = loc_cCursor + ".Moeds"
453:             .Column8.ControlSource = loc_cCursor + ".Totas"
454: 
455:             .Column1.Header1.Caption = ""
456:             .Column2.Header1.Caption = "Item"
457:             .Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
458:             .Column4.Header1.Caption = "Qtde."
459:             .Column5.Header1.Caption = "Uni"
460:             .Column6.Header1.Caption = "Valor Unit" + CHR(225) + "rio"
461:             .Column7.Header1.Caption = "Moe"
462:             .Column8.Header1.Caption = "Valor Total"
463: 
464:             .Column4.InputMask = "99999.999"
465:             .Column6.InputMask = "99999999.999"
466:             .Column8.InputMask = "99999999.99"
467: 
468:             .Column1.Width = 15
469:             .Column2.Width = 120
470:             .Column3.Width = 394
471:             .Column4.Width = 120
472:             .Column5.Width = 31
473:             .Column6.Width = 120
474:             .Column7.Width = 31

*-- Linhas 524 a 614:
524:         *-- COMPLETO, FORA de qualquer WITH: dentro de um WITH, um
525:         *-- ".filho.AddObject(...)" seguido de "WITH .filho.neto" eh o padrao
526:         *-- de WITH aninhado que o VFP9 resolve mal - as propriedades do neto
527:         *-- sao ignoradas em SILENCIO, e o checkbox sairia com a geometria
528:         *-- default sem nenhum erro na tela.
529:         IF !PEMSTATUS(THIS.grd_4c_Itens.Column1, "chk_4c_Marca", 5)
530:             THIS.grd_4c_Itens.Column1.AddObject("chk_4c_Marca", "CheckBox")
531: 
532:             WITH THIS.grd_4c_Itens.Column1.chk_4c_Marca
533:                 .Top       = 2
534:                 .Left      = 2
535:                 .Caption   = ""
536:                 .FontName  = "Verdana"
537:                 .FontSize  = 8
538:                 .Alignment = 0
539:             ENDWITH
540: 
541:             loc_lCriouCheck = .T.
542:         ENDIF
543: 
544:         *-- AddObject sozinho NAO faz o controle aparecer: sem CurrentControl
545:         *-- a Column continua desenhando o Text1 dela, e sem Sparse = .F. o
546:         *-- CheckBox so apareceria na linha ativa (regra #18).
547:         THIS.grd_4c_Itens.Column1.CurrentControl = "chk_4c_Marca"
548:         THIS.grd_4c_Itens.Column1.Sparse         = .F.
549: 
550:         *-- Toggle da marcacao do componente (Column1.Check1 do legado): o
551:         *-- binding nativo do CheckBox na Column NAO alterna o valor (regra
552:         *-- do CheckBox em Grid - exige os 4 handlers). MouseDown e Click
553:         *-- apenas suprimem o toggle padrao (NoDefault); MouseUp e
554:         *-- KeyPress(13/32) fazem o toggle de fato, delegando ambos a
555:         *-- AlternarMarcaLinhaAtual() (mesmo corpo do Procedure/MouseUp e do
556:         *-- KeyPress legado: Replace Marcas With Not Marcas + refresh +
557:         *-- AtuaTotas). Ligados SOMENTE no passe em que o CheckBox nasceu -
558:         *-- ver comentario do metodo.
559:         IF loc_lCriouCheck
560:             BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "MouseDown", THIS, "ChkMarcaMouseDown")
561:             BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "MouseUp", THIS, "ChkMarcaMouseUp")
562:             BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
563:             BINDEVENT(THIS.grd_4c_Itens.Column1.chk_4c_Marca, "Click", THIS, "ChkMarcaClick")
564:         ENDIF
565:     ENDPROC
566: 
567:     *--------------------------------------------------------------------------
568:     * ConfigurarGridRodape - grade de totais (grdRodape do legado), ligada a
569:     * cursor_4c_Rodape (1 linha, ja populada por CarregarDados()). Geometria
570:     * e colunas TRANSCRITAS do dump (SIGOPCPO.grdRodape + PROCEDURE
571:     * montagrades): 3 colunas, todas ReadOnly - mesmo ordem canonica
572:     * (ControlSource -> Header1.Caption -> Width por ultimo).
573:     *--------------------------------------------------------------------------
574:     PROTECTED PROCEDURE ConfigurarGridRodape()
575:         LOCAL loc_cCursor
576:         loc_cCursor = THIS.this_oBusinessObject.this_cCursorRodape
577: 
578:         THIS.AddObject("grd_4c_Rodape", "Grid")
579:         WITH THIS.grd_4c_Rodape
580:             .Top               = 566
581:             .Left              = 542
582:             .Width             = 447
583:             .Height            = 23
584:             .FontName          = "Arial"
585:             .AllowHeaderSizing = .F.
586:             .AllowRowSizing    = .F.
587:             .DeleteMark        = .F.
588:             .RecordMark        = .F.
589:             .HeaderHeight      = 4
590:             .ScrollBars        = 2
591:             .BackColor         = RGB(224, 253, 254)
592:             .ToolTipText       = "Totais"
593:             .ColumnCount       = 3
594:             .ReadOnly          = .T.
595:             .RecordSource      = loc_cCursor
596: 
597:             .Column1.ControlSource = loc_cCursor + ".Descrs"
598:             .Column2.ControlSource = loc_cCursor + ".Usuars"
599:             .Column3.ControlSource = loc_cCursor + ".Totas"
600: 
601:             .Column1.Header1.Caption = ""
602:             .Column2.Header1.Caption = ""
603:             .Column3.Header1.Caption = ""
604: 
605:             .Column3.InputMask = "999999999.99"
606: 
607:             .Column1.Width = 152
608:             .Column2.Width = 152
609:             .Column3.Width = 120
610: 
611:             .Column1.FontName  = "Arial"
612:             .Column1.BackColor = RGB(245, 251, 136)
613:             .Column2.FontName  = "Arial"
614:             .Column2.FontBold  = .T.

*-- Linhas 636 a 787:
636: 
637:         *-- Eventos de CELULA da grade de totais, transcritos do legado.
638:         *-- Text1 eh membro NATIVO de Column (nao precisa de AddObject) e
639:         *-- por isso pode ser alvo direto de BINDEVENT; os handlers sao
640:         *-- PUBLIC (regra #3) e GotFocus/LostFocus nao passam parametro.
641:         *--
642:         *-- SIGOPCPO.grdRodape.Column1.Text1.GotFocus:
643:         *--     ThisForm.grdItens.Column1.SetFocus
644:         *-- SIGOPCPO.grdRodape.Column2.Text1.GotFocus:  This.Tag = This.Value
645:         *-- SIGOPCPO.grdRodape.Column2.Text1.LostFocus: This.Value = This.Tag
646:         BINDEVENT(THIS.grd_4c_Rodape.Column1.Text1, "GotFocus", ;
647:                   THIS, "ValidarFocoRodape")
648:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "GotFocus", ;
649:                   THIS, "ValidarTagRodapeGotFocus")
650:         BINDEVENT(THIS.grd_4c_Rodape.Column2.Text1, "LostFocus", ;
651:                   THIS, "ValidarTagRodapeLostFocus")
652:     ENDPROC
653: 
654:     *--------------------------------------------------------------------------
655:     * ConfigurarFiltroTipo - Label + ComboBox de filtro por tipo de
656:     * composicao (Say1/cmbTipos do legado). Geometria TRANSCRITA do dump
657:     * (SIGOPCPO.Say1/cmbTipos): o label nao declara Width/Alignment no SCX
658:     * (classe say, regra #23), mas aqui o legado JA declara Width=32 - entao
659:     * NAO eh o caso da regra (nada a corrigir).
660:     *
661:     * cmbTipos eh fwcombo Style=2 (dropdown list) SEM ControlSource: o
662:     * legado o popula via Clear/AddItem a partir de LocalTpCom (SigCdTpc),
663:     * ja feito pela BO em CarregarTipos() -> cursor_4c_Tipos. Aqui o combo
664:     * liga via RowSourceType=2 (Alias) nesse MESMO cursor (ja existe quando
665:     * este metodo roda - chamado DEPOIS de CarregarDados() em
666:     * InicializarForm), o que reproduz a lista sem reimplementar o
667:     * Clear/AddItem. .Value recebe this_cTipoSelecionado (equivalente a
668:     * ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos) do
669:     * SelecionaDados legado), DEPOIS do RowSource estar definido. O Valid
670:     * do legado (Set Filter To Tipos = cmbTipos.Value In crGrade + Refresh)
671:     * eh ligado no fim deste metodo e implementado em ValidarFiltroTipo(),
672:     * delegando a THIS.this_oBusinessObject.AplicarFiltroTipo().
673:     *--------------------------------------------------------------------------
674:     PROTECTED PROCEDURE ConfigurarFiltroTipo()
675:         LOCAL loc_cCursorTipos
676:         loc_cCursorTipos = THIS.this_oBusinessObject.this_cCursorTipos
677: 
678:         THIS.AddObject("lbl_4c_Label1", "Label")
679:         WITH THIS.lbl_4c_Label1
680:             .Top       = 169
681:             .Left      = 296
682:             .Width     = 32
683:             .Height    = 15
684:             .AutoSize  = .F.
685:             .BackStyle = 0
686:             .Alignment = 0
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .FontBold  = .T.
690:             .ForeColor = RGB(90, 90, 90)
691:             .Caption   = "Tipo :"
692:             .Visible   = .T.
693:         ENDWITH
694: 
695:         THIS.AddObject("cbo_4c_CmbTipos", "ComboBox")
696:         WITH THIS.cbo_4c_CmbTipos
697:             .Top          = 165
698:             .Left         = 335
699:             .Width        = 325
700:             .Height       = 23
701:             .FontName     = "Courier New"
702:             .Style        = 2
703:             .ToolTipText  = "Sele" + CHR(231) + CHR(227) + "o de Tipos"
704:             .ColumnCount  = 1
705:             .BoundColumn  = 1
706:             .RowSourceType = 2
707:             .RowSource    = loc_cCursorTipos
708:             .Visible      = .T.
709:         ENDWITH
710: 
711:         IF USED(loc_cCursorTipos) AND RECCOUNT(loc_cCursorTipos) > 0
712:             THIS.cbo_4c_CmbTipos.Value = THIS.this_oBusinessObject.this_cTipoSelecionado
713:         ENDIF
714: 
715:         *-- Guarda de valor-nao-mudou inicializada com o tipo que o
716:         *-- SelecionaDados legado ja deixou aplicado em cursor_4c_Grade
717:         *-- (CarregarComposicao -> CarregarTipos -> AplicarFiltroTipo da BO),
718:         *-- ANTES de ligar os eventos: assim a primeira interacao real do
719:         *-- usuario eh a primeira reaplicacao do filtro.
720:         THIS.this_cTipoFiltroAtual = THIS.this_oBusinessObject.this_cTipoSelecionado
721: 
722:         *-- Valid do cmbTipos legado. BINDEVENT exige metodo PUBLIC (regra
723:         *-- #3) - ValidarFiltroTipo nao leva PROTECTED. Dois eventos: o
724:         *-- InteractiveChange reage na hora em que o usuario escolhe o item
725:         *-- do dropdown (Style=2) e o LostFocus eh o equivalente literal do
726:         *-- Valid (que no legado roda ao SAIR do campo); a guarda
727:         *-- this_cTipoFiltroAtual impede o trabalho duplicado. Nenhum dos
728:         *-- dois eventos passa parametro, por isso o handler nao declara
729:         *-- nenhum.
730:         BINDEVENT(THIS.cbo_4c_CmbTipos, "InteractiveChange", THIS, "ValidarFiltroTipo")
731:         BINDEVENT(THIS.cbo_4c_CmbTipos, "LostFocus", THIS, "ValidarFiltroTipo")
732:     ENDPROC
733: 
734:     *--------------------------------------------------------------------------
735:     * ConfigurarBotoes - CommandGroup de saida (cntBotoes do legado), com os
736:     * 2 botoes OK/Cancelar. Geometria TRANSCRITA do dump
737:     * (SIGOPCPO.cntBotoes). CommandGroup NAO tem FontName/ForeColor (regra
738:     * #33) - essas propriedades vao nos Buttons(N), que tem as duas. Criado
739:     * DEPOIS de ConfigurarCabecalho() (chamado antes em InicializarForm),
740:     * para desenhar por cima da faixa cinza (Top = -2 sobrepoe o cabecalho,
741:     * igual ao legado). Buttons(1).Enabled reflete
742:     * this_oBusinessObject.this_lPermiteConfirmar - fonte UNICA do estado do
743:     * botao (equivalente a btnConfirmar.Enabled = (LocalTot.Qtds > 0) do
744:     * AtuaTotas legado, ja calculado em CarregarDados()). Os Click dos
745:     * botoes entram na Fase 7.
746:     *--------------------------------------------------------------------------
747:     PROTECTED PROCEDURE ConfigurarBotoes()
748:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
749:         WITH THIS.cmg_4c_Botoes
750:             .Top           = -2
751:             .Left          = 842
752:             .Width         = 160
753:             .Height        = 85
754:             .ButtonCount   = 2
755:             .BackStyle     = 0
756:             .BorderStyle   = 0
757:             .SpecialEffect = 1
758:             .BorderColor   = RGB(136, 189, 188)
759:             .Themes        = .F.
760: 
761:             WITH .Buttons(1)
762:                 .Top             = 5
763:                 .Left            = 5
764:                 .Height          = 75
765:                 .Width           = 75
766:                 .FontBold        = .T.
767:                 .FontItalic      = .T.
768:                 .FontName        = "Comic Sans MS"
769:                 .FontSize        = 8
770:                 .WordWrap        = .T.
771:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
772:                 .Caption         = "\<OK"
773:                 .MousePointer    = 15
774:                 .ToolTipText     = "Gravar os Dados Informados"
775:                 .SpecialEffect   = 0
776:                 .PicturePosition = 13
777:                 .ForeColor       = RGB(90, 90, 90)
778:                 .BackColor       = RGB(255, 255, 255)
779:                 .Themes          = .F.
780:                 .Enabled         = THIS.this_oBusinessObject.this_lPermiteConfirmar
781:             ENDWITH
782: 
783:             WITH .Buttons(2)
784:                 .Top           = 5
785:                 .Left          = 80
786:                 .Height        = 75
787:                 .Width         = 75

*-- Linhas 806 a 1581:
806: 
807:         *-- Click de cada botao do CommandGroup (cntBotoes do legado - cada
808:         *-- Buttons(N) tem o proprio Click, nao um Click unico do grupo).
809:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnConfirmarClick")
810:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnCancelarClick")
811:     ENDPROC
812: 
813:     *--------------------------------------------------------------------------
814:     * ConfigurarImagem - Image de zoom do componente (ImgFigJpg do legado).
815:     * Geometria TRANSCRITA do dump (SIGOPCPO.ImgFigJpg): nasce OCULTA
816:     * (Visible = .F.), igual ao legado - so fica visivel quando a linha
817:     * corrente da grade tem FigJpgs preenchido (AfterRowColChange legado:
818:     * ThisForm.ImgFigJpg.Visible = .f. seguido de .Visible = .t. condicional
819:     * ao StrToFile ter sucesso). Por isso ela eh EXCLUIDA de
820:     * TornarControlesVisiveis (regra de containers que nascem ocultos de
821:     * proposito), e o Picture so eh atribuido pelo AfterRowColChange real
822:     * (Fase 7), nunca aqui.
823:     *--------------------------------------------------------------------------
824:     PROTECTED PROCEDURE ConfigurarImagem()
825:         THIS.AddObject("img_4c_ImgFigJpg", "Image")
826:         WITH THIS.img_4c_ImgFigJpg
827:             .Top         = 84
828:             .Left        = 12
829:             .Width       = 252
830:             .Height      = 106
831:             .Anchor      = 0
832:             .Stretch     = 1
833:             .Enabled     = .T.
834:             .ToolTipText = "Imagem do Produto (Clique Duplo Para Zoom)"
835:             .Picture     = ""
836:             .Visible     = .F.
837:         ENDWITH
838: 
839:         *-- Click de SIGOPCPO.ImgFigJpg: zoom da imagem do componente
840:         *-- corrente (Do Form SigOpZom do legado).
841:         BINDEVENT(THIS.img_4c_ImgFigJpg, "Click", THIS, "ImgFigJpgClick")
842:     ENDPROC
843: 
844:     *--------------------------------------------------------------------------
845:     * ValidarFiltroTipo - Valid do cmbTipos legado. Wrapper FINO: so cuida da
846:     * guarda de reentrancia e delega o corpo a ValidarFiltroTipoExec(), para
847:     * a flag ser liberada mesmo quando o corpo sai por um RETURN antecipado
848:     * (regra #47 - set/clear no proprio corpo trava a flag ligada e mata o
849:     * handler pelo resto da vida do form).
850:     *
851:     * PUBLIC (sem PROTECTED): eh alvo de BINDEVENT, e metodo PROTECTED falha
852:     * em silencio no bind (regra #3). Nem InteractiveChange nem LostFocus
853:     * passam parametro, por isso a assinatura eh vazia.
854:     *--------------------------------------------------------------------------
855:     PROCEDURE ValidarFiltroTipo()
856:         IF THIS.this_lEmFiltroTipo
857:             RETURN
858:         ENDIF
859: 
860:         THIS.this_lEmFiltroTipo = .T.
861:         THIS.ValidarFiltroTipoExec()
862:         THIS.this_lEmFiltroTipo = .F.
863:     ENDPROC
864: 
865:     *--------------------------------------------------------------------------
866:     * ValidarFiltroTipoExec - corpo da validacao do campo Tipo. Transcricao
867:     * do PROCEDURE Valid de SIGOPCPO.cmbTipos:
868:     *     Select crGrade
869:     *     Set Filter To Tipos = ThisForm.cmbTipos.Value In crGrade
870:     *     Go Top In crGrade
871:     *     ThisForm.grdItens.Refresh
872:     * O Set Filter/Go Top moram em
873:     * THIS.this_oBusinessObject.AplicarFiltroTipo() (fonte unica do filtro,
874:     * Fase 2) e a repintura em THIS.AtualizarRodape() (funil unico, regra
875:     * #21) - aqui fica apenas a leitura do campo e a guarda de
876:     * valor-nao-mudou.
877:     *
878:     * A comparacao da guarda usa ALLTRIM nos DOIS lados: o .Value vem de uma
879:     * coluna char(20) (padded) e this_cTipoFiltroAtual pode ter sido gravado
880:     * sem o padding, e com SET EXACT ON (config.prg) "X" == "X   " eh .F. -
881:     * sem o ALLTRIM a guarda nunca casaria e o filtro seria reaplicado duas
882:     * vezes por escolha. ALLTRIM aqui eh seguro porque a guarda so decide
883:     * REAPLICAR ou nao; quem compara contra o cursor eh a BO, com o valor
884:     * cru.
885:     *--------------------------------------------------------------------------
886:     PROCEDURE ValidarFiltroTipoExec()
887:         LOCAL loc_cTipo, loc_oErro
888: 
889:         TRY
890:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
891:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
892:                         "Erro ao Filtrar por Tipo")
893:             ELSE
894:                 loc_cTipo = THIS.cbo_4c_CmbTipos.Value
895:                 IF VARTYPE(loc_cTipo) != "C"
896:                     loc_cTipo = THIS.this_oBusinessObject.this_cTipoEmBranco
897:                 ENDIF
898: 
899:                 IF ALLTRIM(loc_cTipo) == ALLTRIM(THIS.this_cTipoFiltroAtual)
900:                     *-- Tipo nao mudou: o filtro ja esta aplicado em
901:                     *-- cursor_4c_Grade e a grade ja reflete este tipo.
902:                     *-- Reaplicar so repintaria a grade de novo e perderia a
903:                     *-- linha corrente.
904:                 ELSE
905:                     IF THIS.this_oBusinessObject.AplicarFiltroTipo(loc_cTipo)
906:                         THIS.this_cTipoFiltroAtual = THIS.this_oBusinessObject.this_cTipoSelecionado
907:                         *-- 0 = GO TOP: o Valid legado termina com
908:                         *-- "Go Top In crGrade" - trocou o filtro, a grade
909:                         *-- volta para a primeira linha do novo conjunto.
910:                         THIS.AtualizarRodape(0)
911:                     ELSE
912:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel aplicar o " + ;
913:                                 "filtro de tipo de composi" + CHR(231) + CHR(227) + "o.", ;
914:                                 "Erro ao Filtrar por Tipo")
915:                     ENDIF
916:                 ENDIF
917:             ENDIF
918: 
919:         CATCH TO loc_oErro
920:             MsgErro(loc_oErro.Message + CHR(13) + ;
921:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
922:                     "Procedure: " + loc_oErro.Procedure, ;
923:                     "Erro ao Filtrar por Tipo")
924:         ENDTRY
925:     ENDPROC
926: 
927:     *--------------------------------------------------------------------------
928:     * AtualizarRodape - FUNIL UNICO de repintura: recalcula os totais pela
929:     * BO (fonte unica - AtuaTotas legado), espelha o total geral na linha de
930:     * cursor_4c_Rodape, repinta as DUAS grades e reflete o estado do botao
931:     * Confirmar. Equivalente ao PROCEDURE atuatotas legado:
932:     *     ThisForm.grdRodape.Column3.Text1.Value = LocalTot.Totas
933:     *     ThisForm.grdRodape.Column3.Refresh
934:     *     ThisForm.cntBotoes.btnConfirmar.Enabled = (LocalTot.Qtds > 0)
935:     * (no migrado o total vai para a COLUNA do cursor via REPLACE, igual ao
936:     * que CarregarDados() ja faz, em vez de escrever no .Value da celula -
937:     * assim o valor sobrevive a qualquer repintura do Grid).
938:     *
939:     * Popular/filtrar cursor NAO repinta a grade (regra #21): o Refresh tem
940:     * de rodar em TODO caminho que mexe no cursor, por isso ele mora aqui, e
941:     * nao dentro de cada handler.
942:     *
943:     * par_nRegistroGrade diz onde DEIXAR o ponteiro de cursor_4c_Grade, e eh
944:     * o chamador que decide - este metodo nao adivinha:
945:     *   - 0 / ausente -> GO TOP, que eh o que o legado faz no caminho do
946:     *     FILTRO (Go Top In crGrade no proprio Valid do cmbTipos);
947:     *   - RECNO() capturado ANTES pelo chamador -> volta para aquela linha,
948:     *     que eh o que o caminho do CHECKBOX precisa (Fase 7): a linha
949:     *     corrente eh o que o AfterRowColChange usa para escolher a imagem,
950:     *     e um GO TOP faria a grade saltar a cada marcacao.
951:     * Repor o ponteiro eh OBRIGATORIO nos dois casos: o SELECT ... SUM() de
952:     * AtualizarTotais() percorre o cursor e pode deixa-lo em EOF.
953:     *
954:     * O metodo eh o FUNIL de sincronismo desta tela, nos tres passos:
955:     *   1. THIS.FormParaBO()  - o que esta nos controles e na linha corrente
956:     *                           da grade vai para as properties do BO;
957:     *   2. BO.AtualizarTotais() - o BO recalcula o que eh dele (totais e
958:     *                           this_lPermiteConfirmar);
959:     *   3. THIS.BOParaForm()  - o estado do BO volta para os controles
960:     *                           (total do rodape, botao Confirmar, imagem do
961:     *                           componente, combo de tipo).
962:     * Nenhum handler escreve direto nesses controles: fonte unica.
963:     *
964:     * Reentrancia: os passos 1 e 3 mexem no ponteiro do cursor e repintam a
965:     * grade, o que redispara o AfterRowColChange dela - que chama este
966:     * mesmo metodo. this_lEmAtualizacao garante UM passe por acao do
967:     * usuario (ver comentario da property).
968:     *--------------------------------------------------------------------------
969:     PROTECTED PROCEDURE AtualizarRodape(par_nRegistroGrade)
970:         LOCAL loc_cCursorGrade, loc_nRegGrade, loc_oErro
971: 
972:         IF THIS.this_lEmAtualizacao
973:             RETURN
974:         ENDIF
975: 
976:         loc_nRegGrade = IIF(VARTYPE(par_nRegistroGrade) = "N", par_nRegistroGrade, 0)
977: 
978:         THIS.this_lEmAtualizacao = .T.
979: 
980:         TRY
981:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
982:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
983:                         "Erro ao Atualizar Totais")
984:             ELSE
985:                 loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
986: 
987:                 *-- Ponteiro ANTES de FormParaBO(): eh a linha corrente que
988:                 *-- CarregarDoCursor() le para alimentar o BO.
989:                 IF USED(loc_cCursorGrade)
990:                     SELECT (loc_cCursorGrade)
991:                     IF loc_nRegGrade > 0 AND loc_nRegGrade <= RECCOUNT()
992:                         GO loc_nRegGrade
993:                     ELSE
994:                         GO TOP
995:                     ENDIF
996:                 ENDIF
997: 
998:                 THIS.FormParaBO()
999:                 THIS.this_oBusinessObject.AtualizarTotais()
1000: 
1001:                 IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1002:                     THIS.grd_4c_Itens.Refresh()
1003:                 ENDIF
1004: 
1005:                 THIS.BOParaForm()
1006:             ENDIF
1007: 
1008:         CATCH TO loc_oErro
1009:             MsgErro(loc_oErro.Message + CHR(13) + ;
1010:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1011:                     "Procedure: " + loc_oErro.Procedure, ;
1012:                     "Erro ao Atualizar Totais")
1013:         ENDTRY
1014: 
1015:         *-- Liberada FORA do TRY/CATCH para nunca travar ligada quando o
1016:         *-- corpo estourar (mesmo motivo da guarda do lookup, regra #47).
1017:         THIS.this_lEmAtualizacao = .F.
1018:     ENDPROC
1019: 
1020:     *--------------------------------------------------------------------------
1021:     * ValidarFocoRodape - GotFocus de SIGOPCPO.grdRodape.Column1.Text1
1022:     * legado, que eh uma unica linha: ThisForm.grdItens.Column1.SetFocus.
1023:     * A grade de totais eh somente-leitura (Grid.ReadOnly = .T. + as 3
1024:     * Column.ReadOnly = .T.), entao o legado DEVOLVE o foco a grade de
1025:     * itens assim que ela o recebe por Tab.
1026:     *
1027:     * PUBLIC (alvo de BINDEVENT, regra #3) e sem parametro (GotFocus nao
1028:     * passa nenhum). Sem TRY/CATCH de proposito: um dialogo modal de erro
1029:     * disparado por uma troca de foco seria pior que o proprio problema -
1030:     * as pre-condicoes do SetFocus (grade existente, visivel, habilitada e
1031:     * com registro) sao conferidas por guarda explicita. A devolucao de
1032:     * foco nao reentra: o SetFocus leva o foco PARA FORA da grade de
1033:     * totais, logo o GotFocus dela nao dispara de novo.
1034:     *--------------------------------------------------------------------------
1035:     PROCEDURE ValidarFocoRodape()
1036:         LOCAL loc_cCursorGrade
1037: 
1038:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1039:             RETURN
1040:         ENDIF
1041: 
1042:         IF !PEMSTATUS(THIS, "grd_4c_Itens", 5)
1043:             RETURN
1044:         ENDIF
1045: 
1046:         loc_cCursorGrade = THIS.this_oBusinessObject.this_cCursorGrade
1047:         IF !USED(loc_cCursorGrade) OR RECCOUNT(loc_cCursorGrade) = 0
1048:             RETURN
1049:         ENDIF
1050: 
1051:         IF THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled
1052:             THIS.grd_4c_Itens.Column1.SetFocus()
1053:         ENDIF
1054:     ENDPROC
1055: 
1056:     *--------------------------------------------------------------------------
1057:     * ValidarTagRodapeGotFocus - GotFocus de SIGOPCPO.grdRodape.Column2.Text1
1058:     * legado (This.Tag = This.Value): guarda o valor original da celula ao
1059:     * entrar nela. Tag de TextBox aceita SOMENTE caractere, e Column2 esta
1060:     * ligada a cursor_4c_Rodape.Usuars (char(10)), entao o valor ja chega
1061:     * como caractere - o VARTYPE abaixo cobre o caso de a celula ainda nao
1062:     * ter valor ligado.
1063:     *
1064:     * PUBLIC (alvo de BINDEVENT) e sem parametro (GotFocus nao passa
1065:     * nenhum).
1066:     *--------------------------------------------------------------------------
1067:     PROCEDURE ValidarTagRodapeGotFocus()
1068:         LOCAL loc_oCelula
1069: 
1070:         IF !PEMSTATUS(THIS, "grd_4c_Rodape", 5)
1071:             RETURN
1072:         ENDIF
1073: 
1074:         loc_oCelula = THIS.grd_4c_Rodape.Column2.Text1
1075:         IF VARTYPE(loc_oCelula.Value) = "C"
1076:             loc_oCelula.Tag = loc_oCelula.Value
1077:         ELSE
1078:             loc_oCelula.Tag = TRANSFORM(loc_oCelula.Value)
1079:         ENDIF
1080:     ENDPROC
1081: 
1082:     *--------------------------------------------------------------------------
1083:     * ValidarTagRodapeLostFocus - LostFocus de
1084:     * SIGOPCPO.grdRodape.Column2.Text1 legado (This.Value = This.Tag):
1085:     * restaura o valor guardado no GotFocus ao sair da celula, desfazendo
1086:     * qualquer alteracao. Eh a trava de edicao do legado para essa celula,
1087:     * complementar ao Column2.ReadOnly = .T. - sem ela a trava ficaria
1088:     * apenas na propriedade, e a propriedade eh resetada por qualquer
1089:     * re-bind de RecordSource (Problema 48).
1090:     *
1091:     * So restaura quando o valor REALMENTE mudou e quando o tipo do Tag
1092:     * (sempre caractere) bate com o tipo da celula: atribuir caractere a
1093:     * celula numerica dispararia "Data type mismatch", e a celula so eh
1094:     * numerica se o RecordSource tiver sido re-vinculado a outra coluna.
1095:     *
1096:     * PUBLIC (alvo de BINDEVENT) e sem parametro (LostFocus nao passa
1097:     * nenhum).
1098:     *--------------------------------------------------------------------------
1099:     PROCEDURE ValidarTagRodapeLostFocus()
1100:         LOCAL loc_oCelula
1101: 
1102:         IF !PEMSTATUS(THIS, "grd_4c_Rodape", 5)
1103:             RETURN
1104:         ENDIF
1105: 
1106:         loc_oCelula = THIS.grd_4c_Rodape.Column2.Text1
1107:         IF VARTYPE(loc_oCelula.Value) != "C" OR VARTYPE(loc_oCelula.Tag) != "C"
1108:             RETURN
1109:         ENDIF
1110: 
1111:         IF !(loc_oCelula.Value == loc_oCelula.Tag)
1112:             loc_oCelula.Value = loc_oCelula.Tag
1113:         ENDIF
1114:     ENDPROC
1115: 
1116:     *--------------------------------------------------------------------------
1117:     * AlternarMarcaLinhaAtual - corpo comum do MouseUp e do KeyPress(13/32) de
1118:     * SIGOPCPO.grdItens.Column1.Check1:
1119:     *     Replace Marcas With Not Marcas In crGrade
1120:     *     ThisForm.grdItens.Column1.Refresh
1121:     *     ThisForm.grdItens.Refresh
1122:     *     ThisForm.AtuaTotas
1123:     * O refresh da grade de itens e a repintura do rodape (AtuaTotas) moram
1124:     * no funil AtualizarRodape() (regra #21). RECNO() eh capturado ANTES de
1125:     * chamar AtualizarRodape() e repassado a ela, para a grade permanecer na
1126:     * MESMA linha que o usuario acabou de marcar (AtualizarRodape so faz
1127:     * GO TOP quando recebe 0 - ver comentario do metodo).
1128:     *--------------------------------------------------------------------------
1129:     PROTECTED PROCEDURE AlternarMarcaLinhaAtual()
1130:         LOCAL loc_cCursor, loc_nRecno, loc_oErro
1131: 
1132:         TRY
1133:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1134:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
1135:                         "Erro ao Marcar Componente")
1136:             ELSE
1137:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
1138: 
1139:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1140:                     SELECT (loc_cCursor)
1141:                     REPLACE Marcas WITH !Marcas
1142:                     loc_nRecno = RECNO()
1143: 
1144:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1145:                         THIS.grd_4c_Itens.Column1.Refresh()
1146:                     ENDIF
1147: 
1148:                     THIS.AtualizarRodape(loc_nRecno)
1149:                 ENDIF
1150:             ENDIF
1151: 
1152:         CATCH TO loc_oErro
1153:             MsgErro(loc_oErro.Message + CHR(13) + ;
1154:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1155:                     "Procedure: " + loc_oErro.Procedure, ;
1156:                     "Erro ao Marcar Componente")
1157:         ENDTRY
1158:     ENDPROC
1159: 
1160:     *--------------------------------------------------------------------------
1161:     * ChkMarcaMouseDown - Procedure (MouseDown) de Check1 legado: so suprime
1162:     * o toggle padrao do CheckBox (NoDefault). PUBLIC (alvo de BINDEVENT,
1163:     * regra #3); assinatura completa de MouseDown, mesmo sem uso.
1164:     *--------------------------------------------------------------------------
1165:     PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1166:         NODEFAULT
1167:     ENDPROC
1168: 
1169:     *--------------------------------------------------------------------------
1170:     * ChkMarcaMouseUp - Procedure (MouseUp) de Check1 legado: alterna a
1171:     * marcacao da linha corrente, sem checar qual botao do mouse (o legado
1172:     * tambem nao checa). PUBLIC (alvo de BINDEVENT, regra #3).
1173:     *--------------------------------------------------------------------------
1174:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1175:         THIS.AlternarMarcaLinhaAtual()
1176:         NODEFAULT
1177:     ENDPROC
1178: 
1179:     *--------------------------------------------------------------------------
1180:     * ChkMarcaKeyPress - KeyPress de Check1 legado: alterna a marcacao so em
1181:     * Enter(13)/Espaco(32), exatamente como o "If InList(nKeyCode, 13, 32)"
1182:     * do legado - fora dessas teclas, nao chama NoDefault e o KeyPress segue
1183:     * o processamento padrao. PUBLIC (alvo de BINDEVENT, regra #3).
1184:     *--------------------------------------------------------------------------
1185:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1186:         IF INLIST(par_nKeyCode, 13, 32)
1187:             THIS.AlternarMarcaLinhaAtual()
1188:             NODEFAULT
1189:         ENDIF
1190:     ENDPROC
1191: 
1192:     *--------------------------------------------------------------------------
1193:     * ChkMarcaClick - Click de Check1 legado (so "NoDefault" - suprime o
1194:     * toggle padrao, que fica a cargo do MouseUp/KeyPress). PUBLIC (alvo de
1195:     * BINDEVENT, regra #3).
1196:     *--------------------------------------------------------------------------
1197:     PROCEDURE ChkMarcaClick()
1198:         NODEFAULT
1199:     ENDPROC
1200: 
1201:     *--------------------------------------------------------------------------
1202:     * GradeItensAfterRowColChange - AfterRowColChange de SIGOPCPO.grdItens:
1203:     *     Clear Resources
1204:     *     ThisForm.ImgFigJpg.Picture = []
1205:     *     ThisForm.ImgFigJpg.Visible = .f.
1206:     *     If Not Empty(crGrade.FigJpgs) And Not IsNull(crGrade.FigJpgs) ;
1207:     *         And (StrToFile(Strconv(Strtran(...),14), lcArq) > 0)
1208:     *         ThisForm.ImgFigJpg.Picture = (lcArq)
1209:     *         ThisForm.ImgFigJpg.Visible = .t.
1210:     *     EndIf
1211:     *     ThisForm.AtuaTotas
1212:     * O corpo inteiro eh o funil THIS.AtualizarRodape(), que faz
1213:     * FormParaBO() -> AtualizarTotais() -> BOParaForm(): eh o BOParaForm()
1214:     * que troca a imagem (Picture/Visible), a partir do this_cFigjpgs que o
1215:     * FormParaBO() acabou de ler da linha corrente, e a decodificacao do
1216:     * base64 mora em THIS.this_oBusinessObject.DecodificarImagem() (fonte
1217:     * unica, Fase 2). O unico trabalho deste handler eh dizer ao funil QUAL
1218:     * linha eh a corrente - o funil nao adivinha (ver AtualizarRodape).
1219:     *
1220:     * PUBLIC (alvo de BINDEVENT, regra #3); par_nColIndex nao eh usado -
1221:     * este handler carrega o detalhe da linha corrente, independente da
1222:     * coluna de destino, que eh o uso CORRETO deste evento (regra #46).
1223:     *--------------------------------------------------------------------------
1224:     PROCEDURE GradeItensAfterRowColChange(par_nColIndex)
1225:         LOCAL loc_cCursor, loc_oErro
1226: 
1227:         TRY
1228:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1229:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
1230: 
1231:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1232:                     THIS.AtualizarRodape(RECNO(loc_cCursor))
1233:                 ELSE
1234:                     THIS.AtualizarRodape(0)
1235:                 ENDIF
1236:             ENDIF
1237: 
1238:         CATCH TO loc_oErro
1239:             MsgErro(loc_oErro.Message + CHR(13) + ;
1240:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1241:                     "Procedure: " + loc_oErro.Procedure, ;
1242:                     "Erro ao Carregar Imagem do Componente")
1243:         ENDTRY
1244:     ENDPROC
1245: 
1246:     *--------------------------------------------------------------------------
1247:     * BtnConfirmarClick - Click de Buttons(1) do cntBotoes legado (OK):
1248:     *     Select crGrade
1249:     *     Set Filter To
1250:     *     Go Top In crGrade
1251:     *     Select crGrade
1252:     *     Scan
1253:     *         If Not Marcas
1254:     *             Delete In crGrade
1255:     *         EndIf
1256:     *     EndScan
1257:     *     ThisForm.Release
1258:     * O descarte das linhas nao marcadas mora em
1259:     * THIS.this_oBusinessObject.ConfirmarSelecao() (fonte unica, Fase 2). O
1260:     * Release so acontece com sucesso - sem RETURN dentro do TRY (regra #1),
1261:     * flag loc_lSucesso decide a saida DEPOIS do ENDTRY. PUBLIC (alvo de
1262:     * BINDEVENT, regra #3).
1263:     *--------------------------------------------------------------------------
1264:     PROCEDURE BtnConfirmarClick()
1265:         LOCAL loc_lSucesso, loc_oErro
1266:         loc_lSucesso = .F.
1267: 
1268:         TRY
1269:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1270:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
1271:                         "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
1272:             ELSE
1273:                 IF THIS.this_oBusinessObject.ConfirmarSelecao()
1274:                     loc_lSucesso = .T.
1275:                 ELSE
1276:                     MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, ;
1277:                             "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
1278:                 ENDIF
1279:             ENDIF
1280: 
1281:         CATCH TO loc_oErro
1282:             MsgErro(loc_oErro.Message + CHR(13) + ;
1283:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1284:                     "Procedure: " + loc_oErro.Procedure, ;
1285:                     "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
1286:         ENDTRY
1287: 
1288:         IF loc_lSucesso
1289:             THIS.Release()
1290:         ENDIF
1291:     ENDPROC
1292: 
1293:     *--------------------------------------------------------------------------
1294:     * BtnCancelarClick - Click de Buttons(2) do cntBotoes legado (Cancelar):
1295:     *     Select crGrade
1296:     *     Set Filter To
1297:     *     Go Top In crGrade
1298:     *     Select crGrade
1299:     *     Scan
1300:     *         Delete In crGrade
1301:     *     EndScan
1302:     *     ThisForm.Release
1303:     * O descarte INCONDICIONAL de todas as linhas mora em
1304:     * THIS.this_oBusinessObject.CancelarSelecao() (fonte unica, Fase 2). O
1305:     * Release acontece sempre - cancelar nunca falha de um jeito que impeca
1306:     * sair do dialogo. PUBLIC (alvo de BINDEVENT, regra #3).
1307:     *--------------------------------------------------------------------------
1308:     PROCEDURE BtnCancelarClick()
1309:         LOCAL loc_oErro
1310: 
1311:         TRY
1312:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1313:                 THIS.this_oBusinessObject.CancelarSelecao()
1314:             ENDIF
1315: 
1316:         CATCH TO loc_oErro
1317:             MsgErro(loc_oErro.Message + CHR(13) + ;
1318:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1319:                     "Procedure: " + loc_oErro.Procedure, ;
1320:                     "Erro ao Cancelar Sele" + CHR(231) + CHR(227) + "o")
1321:         ENDTRY
1322: 
1323:         THIS.Release()
1324:     ENDPROC
1325: 
1326:     *--------------------------------------------------------------------------
1327:     * ImgFigJpgClick - Click de SIGOPCPO.ImgFigJpg legado:
1328:     *     Select crGrade
1329:     *     If Not Empty(crGrade.FigJpgs) And Not IsNull(crGrade.FigJpgs)
1330:     *         lcFoto = Strconv(Strtran(...), 14)
1331:     *         =StrToFile(lcFoto, lcArq)
1332:     *     EndIf
1333:     *     If File(lcArq)
1334:     *         Do Form SigOpZom With lcArq, [Produto : ]+Mats+[ - ]+DPros, ;
1335:     *                  [Ref. Fornecedor : ]+Reffs
1336:     *     EndIf
1337:     * A decodificacao mora em THIS.this_oBusinessObject.DecodificarImagem()
1338:     * (fonte unica, Fase 2); a abertura do zoom em
1339:     * THIS.AbrirFormZoomImagem() - SigOpZom esta FORA do escopo desta task
1340:     * (ProximasMigracoes\SigOpZom.SCX ainda nao migrado), mesmo padrao do
1341:     * FormSigMvSbn.ImgFigJpgDblClick: CREATEOBJECT guardado, ausencia
1342:     * AVISADA via MsgAviso em vez de estourar "Class definition ... is not
1343:     * found". Quando SigOpZom for migrado, esta chamada passa a funcionar
1344:     * sem nenhuma alteracao aqui. PUBLIC (alvo de BINDEVENT, regra #3).
1345:     *--------------------------------------------------------------------------
1346:     PROCEDURE ImgFigJpgClick()
1347:         LOCAL loc_cCursor, loc_cFigJpgs, loc_cArquivo, loc_cProduto, ;
1348:               loc_cDescricao, loc_cReferencia, loc_oErro
1349:         loc_cArquivo = ""
1350: 
1351:         TRY
1352:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1353:                 loc_cCursor = THIS.this_oBusinessObject.this_cCursorGrade
1354: 
1355:                 IF USED(loc_cCursor) AND !EOF(loc_cCursor)
1356:                     loc_cFigJpgs    = TratarNulo(EVALUATE(loc_cCursor + ".FigJpgs"), "")
1357:                     loc_cProduto    = TratarNulo(EVALUATE(loc_cCursor + ".Mats"), "")
1358:                     loc_cDescricao  = TratarNulo(EVALUATE(loc_cCursor + ".Dpros"), "")
1359:                     loc_cReferencia = TratarNulo(EVALUATE(loc_cCursor + ".Reffs"), "")
1360: 
1361:                     IF !EMPTY(loc_cFigJpgs) AND THIS.this_oBusinessObject.DecodificarImagem(loc_cFigJpgs)
1362:                         loc_cArquivo = THIS.this_oBusinessObject.this_cArquivoImagem
1363:                     ENDIF
1364:                 ENDIF
1365:             ENDIF
1366: 
1367:         CATCH TO loc_oErro
1368:             MsgErro(loc_oErro.Message + CHR(13) + ;
1369:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1370:                     "Procedure: " + loc_oErro.Procedure, ;
1371:                     "Erro ao Abrir Zoom da Imagem")
1372:             loc_cArquivo = ""
1373:         ENDTRY
1374: 
1375:         *-- Legado: If File(lcArq) / Do Form SigOpZom With ... Show() de form
1376:         *-- fica FORA de qualquer TRY (regra #29).
1377:         IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
1378:             THIS.AbrirFormZoomImagem(loc_cArquivo, loc_cProduto, loc_cDescricao, loc_cReferencia)
1379:         ENDIF
1380:     ENDPROC
1381: 
1382:     *--------------------------------------------------------------------------
1383:     * AbrirFormZoomImagem - "Do Form SigOpZom With lcArq, 'Produto : '+...,
1384:     * 'Ref. Fornecedor : '+..." do legado. SigOpZom ainda nao foi migrado
1385:     * (ProximasMigracoes\SigOpZom.SCX) - mesma situacao documentada em
1386:     * FormSigMvSbn.AbrirFormZoomImagem: CREATEOBJECT guardado em TRY/CATCH,
1387:     * ausencia avisada via MsgAviso em vez de estourar "Class definition
1388:     * FORMSIGOPZOM is not found". Show() fica FORA do TRY (regra #29).
1389:     *--------------------------------------------------------------------------
1390:     PROTECTED PROCEDURE AbrirFormZoomImagem(par_cArquivo, par_cProduto, par_cDescricao, par_cReferencia)
1391:         LOCAL loc_oForm, loc_oErro, loc_cLinha2, loc_cLinha3
1392: 
1393:         loc_cLinha2 = "Produto : " + ALLTRIM(par_cProduto) + " - " + ALLTRIM(par_cDescricao)
1394:         loc_cLinha3 = "Ref. Fornecedor : " + ALLTRIM(par_cReferencia)
1395: 
1396:         TRY
1397:             loc_oForm = CREATEOBJECT("FormSigOpZom", par_cArquivo, loc_cLinha2, loc_cLinha3)
1398:         CATCH TO loc_oErro
1399:             loc_oForm = .NULL.
1400:         ENDTRY
1401: 
1402:         IF VARTYPE(loc_oForm) = "O"
1403:             loc_oForm.Show()
1404:         ELSE
1405:             MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
1406:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", ;
1407:                 "Aviso")
1408:         ENDIF
1409:     ENDPROC
1410: 
1411:     *==========================================================================
1412:     * Fase 8/8 - CONSOLIDACAO: o trio de sincronismo da tela
1413:     *
1414:     * CarregarLista() / FormParaBO() / BOParaForm() sao os tres metodos que
1415:     * fecham a migracao. Nao ha HabilitarCampos/LimparCampos/
1416:     * AjustarBotoesPorModo/BtnBuscarClick/BtnEncerrarClick aqui, e a ausencia
1417:     * eh deliberada: sao convencao de form CRUD (Page1=Lista/Page2=Dados com
1418:     * os modos INCLUIR/ALTERAR/VISUALIZAR). O SCX legado deste dialogo
1419:     * (tasks/task710/SigOpCpo_form_codigo_fonte.txt) NAO tem modo de edicao,
1420:     * NAO tem campo que se limpe (os unicos dados editaveis sao a marcacao
1421:     * da Column1 e o combo de tipo, ambos sempre habilitados), e tem
1422:     * exatamente DOIS botoes - OK (btnConfirmar) e Cancelar (btnSair), ja
1423:     * entregues na Fase 7. Criar os cinco metodos aqui obrigaria a INVENTAR
1424:     * modos e botoes que o legado nao tem (viola o PILAR 1 e a regra "NUNCA
1425:     * inventar") ou a entregar metodos vazios (proibido pela regra de
1426:     * completude).
1427:     *==========================================================================
1428: 
1429:     *--------------------------------------------------------------------------
1430:     * CarregarLista - liga a grade de componentes ao cursor JA populado e
1431:     * repinta a tela. Eh o trecho FINAL do PROCEDURE selecionadados legado,
1432:     * que o migrado nao executava:
1433:     *     Go Top In crGrade
1434:     *     ThisForm.grdItens.Refresh
1435:     *     ThisForm.grdItens.Column1.SetFocus
1436:     *     Go Top In crRodape
1437:     *     ThisForm.grdRodape.Refresh
1438:     * Popular cursor NAO repinta a grade (regra #21): sem este metodo, o
1439:     * cursor abre cheio e a grade aparece VAZIA - o sintoma ("a tela nao traz
1440:     * dados") manda o diagnostico para SQL/cursor/permissao.
1441:     *
1442:     * NAO re-consulta o banco: a carga eh de CarregarDados() (-> BO.
1443:     * CarregarComposicao()), que roda ANTES das grades existirem porque
1444:     * Column.ControlSource exige o cursor ja criado (regra #41). Este metodo
1445:     * eh o passo seguinte - re-vincular e repintar - e por isso pode ser
1446:     * chamado quantas vezes for preciso sem custo de SQL.
1447:     *
1448:     * O re-vinculo (VincularGradeItens) eh condicional: so refaz quando a
1449:     * grade NAO esta mais apontando para o cursor certo (RecordSource vazio
1450:     * ou trocado), porque re-atribuir RecordSource reseta Width/Caption das
1451:     * colunas e destroi o CurrentControl do CheckBox (Problema 48/regra #18).
1452:     *
1453:     * PUBLIC: TesteAutomatico.prg chama THIS.oForm.CarregarLista() de FORA da
1454:     * classe, e PEMSTATUS nao distingue escopo - metodo PROTECTED entraria no
1455:     * branch do teste e estouraria "Property CARREGARLISTA is not found"
1456:     * (regra #3).
1457:     *--------------------------------------------------------------------------
1458:     FUNCTION CarregarLista()
1459:         LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, loc_oErro
1460:         loc_lSucesso = .F.
1461: 
1462:         TRY
1463:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1464:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
1465:                         "Erro ao Carregar a Grade")
1466:             ELSE
1467:                 loc_cCursorGrade  = THIS.this_oBusinessObject.this_cCursorGrade
1468:                 loc_cCursorRodape = THIS.this_oBusinessObject.this_cCursorRodape
1469: 
1470:                 IF !USED(loc_cCursorGrade)
1471:                     MsgErro("Cursor da composi" + CHR(231) + CHR(227) + "o (" + ;
1472:                             loc_cCursorGrade + ") indispon" + CHR(237) + "vel.", ;
1473:                             "Erro ao Carregar a Grade")
1474:                 ELSE
1475:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1476:                         IF !(UPPER(ALLTRIM(THIS.grd_4c_Itens.RecordSource)) == ;
1477:                              UPPER(ALLTRIM(loc_cCursorGrade)))
1478:                             THIS.VincularGradeItens()
1479:                         ENDIF
1480:                     ENDIF
1481: 
1482:                     *-- "Go Top In crRodape" do legado: a linha unica de
1483:                     *-- totais sempre repousa no topo.
1484:                     IF USED(loc_cCursorRodape)
1485:                         SELECT (loc_cCursorRodape)
1486:                         GO TOP
1487:                     ENDIF
1488: 
1489:                     *-- Totais + rodape + botao Confirmar + imagem pelo funil
1490:                     *-- (fonte unica). 0 = GO TOP em cursor_4c_Grade, que eh
1491:                     *-- o que o legado faz neste ponto.
1492:                     THIS.AtualizarRodape(0)
1493: 
1494:                     *-- "ThisForm.grdItens.Column1.SetFocus" do legado: o
1495:                     *-- dialogo abre com o foco na coluna de marcacao, para o
1496:                     *-- usuario poder marcar com Espaco/Enter sem usar o mouse
1497:                     *-- (os handlers de teclado do CheckBox dependem disso).
1498:                     IF PEMSTATUS(THIS, "grd_4c_Itens", 5)
1499:                         IF THIS.grd_4c_Itens.Visible AND THIS.grd_4c_Itens.Enabled ;
1500:                            AND RECCOUNT(loc_cCursorGrade) > 0
1501:                             THIS.grd_4c_Itens.Column1.SetFocus()
1502:                         ENDIF
1503:                     ENDIF
1504: 
1505:                     loc_lSucesso = .T.
1506:                 ENDIF
1507:             ENDIF
1508: 
1509:         CATCH TO loc_oErro
1510:             MsgErro(loc_oErro.Message + CHR(13) + ;
1511:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1512:                     "Procedure: " + loc_oErro.Procedure, ;
1513:                     "Erro ao Carregar a Grade")
1514:         ENDTRY
1515: 
1516:         RETURN loc_lSucesso
1517:     ENDFUNC
1518: 
1519:     *--------------------------------------------------------------------------
1520:     * FormParaBO - transfere para o BO TUDO o que o usuario pode alterar
1521:     * nesta tela. A superficie editavel do dialogo legado sao apenas tres
1522:     * coisas, e as tres estao cobertas:
1523:     *   1. cbo_4c_CmbTipos.Value  -> this_cTipoSelecionado  (o cmbTipos do
1524:     *      legado, cujo Valid aplica "Set Filter To Tipos = ..." em crGrade);
1525:     *   2. a LINHA CORRENTE de cursor_4c_Grade -> as properties de linha do
1526:     *      BO, via THIS.this_oBusinessObject.CarregarDoCursor() - inclui
1527:     *      this_lMarcas (o CheckBox da Column1, unica coluna editavel) e
1528:     *      this_cFigjpgs, que eh o que BOParaForm() usa para a imagem;
1529:     *   3. a linha de cursor_4c_Rodape -> this_cDescrsRodape/
1530:     *      this_cUsuarsRodape/this_nTotasRodape (as 3 celulas do grdRodape).
1531:     * NAO ha mais nada: os outros 7 controles da grade sao Column.ReadOnly =
1532:     * .T. e os dois labels do cabecalho sao somente-exibicao.
1533:     *
1534:     * CarregarDoCursor() eh PUBLIC na BusinessBase - chama-lo daqui eh
1535:     * legitimo; o que nunca se chama de fora eh metodo PROTECTED (regra #51).
1536:     *
1537:     * O alias originalmente selecionado eh restaurado no fim: o metodo roda
1538:     * dentro do funil AtualizarRodape(), que repos o ponteiro da grade ANTES
1539:     * de chamar este metodo e conta com ele intacto depois.
1540:     *
1541:     * PROTECTED EXPLICITO: FormBase declara "PROTECTED PROCEDURE FormParaBO",
1542:     * e em VFP9 a subclasse NAO pode ALARGAR o escopo herdado - escrever
1543:     * "FUNCTION FormParaBO" sem o modificador nao torna o metodo publico, so
1544:     * esconde de quem le que ele continua protegido. Medido nesta tela
1545:     * (2026-10-30): chamado de um script solto devolve .F. sem executar o
1546:     * corpo; chamado por THIS. de dentro da classe roda normalmente. Para
1547:     * exercitar num harness, usar "DEFINE CLASS Probe AS FormSigOpCpo" com um
1548:     * metodo publico que chame THIS.FormParaBO().
1549:     *--------------------------------------------------------------------------
1550:     PROTECTED FUNCTION FormParaBO()
1551:         LOCAL loc_lSucesso, loc_cCursorGrade, loc_cCursorRodape, ;
1552:               loc_cAliasAnterior, loc_cTipo, loc_oErro
1553:         loc_lSucesso = .F.
1554: 
1555:         TRY
1556:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1557:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
1558:                         "Erro ao Transferir Dados da Tela")
1559:             ELSE
1560:                 loc_cAliasAnterior = ALIAS()
1561:                 loc_cCursorGrade   = THIS.this_oBusinessObject.this_cCursorGrade
1562:                 loc_cCursorRodape  = THIS.this_oBusinessObject.this_cCursorRodape
1563: 
1564:                 *-- 1. Tipo escolhido no combo. Style = 2 (dropdown list)
1565:                 *-- devolve CARACTERE; o PADR para 20 reproduz a largura de
1566:                 *-- SigCdTpc.Tipos char(20), que eh com o que o SET FILTER
1567:                 *-- compara (chave posicional - regra #42).
1568:                 IF PEMSTATUS(THIS, "cbo_4c_CmbTipos", 5)
1569:                     loc_cTipo = THIS.cbo_4c_CmbTipos.Value
1570:                     IF VARTYPE(loc_cTipo) != "C"
1571:                         loc_cTipo = TRANSFORM(loc_cTipo)
1572:                     ENDIF
1573:                     THIS.this_oBusinessObject.this_cTipoSelecionado = PADR(loc_cTipo, 20)
1574:                 ENDIF
1575: 
1576:                 *-- 2. Linha corrente da grade de componentes.
1577:                 IF USED(loc_cCursorGrade) AND !EOF(loc_cCursorGrade)
1578:                     THIS.this_oBusinessObject.CarregarDoCursor(loc_cCursorGrade)
1579:                 ENDIF
1580: 
1581:                 *-- 3. Celulas da grade de totais.

*-- Linhas 1598 a 1684:
1598:         CATCH TO loc_oErro
1599:             MsgErro(loc_oErro.Message + CHR(13) + ;
1600:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1601:                     "Procedure: " + loc_oErro.Procedure, ;
1602:                     "Erro ao Transferir Dados da Tela")
1603:         ENDTRY
1604: 
1605:         RETURN loc_lSucesso
1606:     ENDFUNC
1607: 
1608:     *--------------------------------------------------------------------------
1609:     * BOParaForm - caminho inverso: o estado do BO vai para os controles.
1610:     * Reune, num lugar so, tudo o que o legado escreve na tela:
1611:     *   - this_nTotalTotas       -> cursor_4c_Rodape.Totas + grdRodape
1612:     *     ("ThisForm.grdRodape.Column3.Text1.Value = LocalTot.Totas /
1613:     *     Column3.Refresh" do AtuaTotas legado - no migrado o valor vai para
1614:     *     a COLUNA do cursor via REPLACE, e nao para o .Value da celula,
1615:     *     assim sobrevive a qualquer repintura do Grid);
1616:     *   - this_lPermiteConfirmar -> Buttons(1).Enabled
1617:     *     ("ThisForm.cntBotoes.btnConfirmar.Enabled = (LocalTot.Qtds > 0)");
1618:     *   - this_cFigjpgs          -> img_4c_ImgFigJpg.Picture/.Visible
1619:     *     (o AfterRowColChange legado: limpa a imagem e so a mostra quando o
1620:     *     base64 do componente corrente decodifica);
1621:     *   - this_cCpros/this_cDprosProduto -> Caption e os dois labels da faixa
1622:     *     (o "... - <Cpros> - <Dpros>" montado no Init legado);
1623:     *   - this_cTipoSelecionado  -> cbo_4c_CmbTipos.Value
1624:     *     ("ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos)
1625:     *     / cmbTipos.Refresh" do selecionadados legado).
1626:     *
1627:     * O combo so eh escrito quando o valor REALMENTE difere: atribuir .Value
1628:     * dispara o InteractiveChange, que esta ligado a ValidarFiltroTipo() -
1629:     * reescrever o mesmo valor reaplicaria o filtro e repintaria a grade de
1630:     * novo (as guardas this_cTipoFiltroAtual/this_lEmFiltroTipo tambem
1631:     * cortam isso, mas nao se deve depender de guarda para nao gerar
1632:     * trabalho que nao existe).
1633:     *
1634:     * PROTECTED EXPLICITO pelo mesmo motivo de FormParaBO(): FormBase declara
1635:     * "PROTECTED PROCEDURE BOParaForm" e o escopo vem da HERANCA - omitir o
1636:     * modificador nao alarga nada. CarregarLista(), ao contrario, NAO existe
1637:     * em FormBase e por isso fica publico de verdade.
1638:     *--------------------------------------------------------------------------
1639:     PROTECTED FUNCTION BOParaForm()
1640:         LOCAL loc_lSucesso, loc_cCursorRodape, loc_cAliasAnterior, ;
1641:               loc_cTipoBO, loc_cCaption, loc_oErro
1642:         loc_lSucesso = .F.
1643: 
1644:         TRY
1645:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
1646:                 MsgErro("Objeto de neg" + CHR(243) + "cio indispon" + CHR(237) + "vel.", ;
1647:                         "Erro ao Exibir Dados na Tela")
1648:             ELSE
1649:                 loc_cAliasAnterior = ALIAS()
1650:                 loc_cCursorRodape  = THIS.this_oBusinessObject.this_cCursorRodape
1651: 
1652:                 *-- Total geral na linha unica do rodape. "IN (<alias>)"
1653:                 *-- EXPLICITO: este metodo roda logo depois de
1654:                 *-- AtualizarTotais(), que fecha o cursor temporario da soma e
1655:                 *-- com isso pode deixar a work area corrente VAZIA - REPLACE
1656:                 *-- sem alias ali estoura "No table is open in the current
1657:                 *-- work area.".
1658:                 IF USED(loc_cCursorRodape)
1659:                     SELECT (loc_cCursorRodape)
1660:                     GO TOP
1661:                     IF !EOF()
1662:                         REPLACE Totas WITH THIS.this_oBusinessObject.this_nTotalTotas ;
1663:                             IN (loc_cCursorRodape)
1664:                     ENDIF
1665:                 ENDIF
1666: 
1667:                 IF PEMSTATUS(THIS, "grd_4c_Rodape", 5)
1668:                     THIS.grd_4c_Rodape.Column3.Refresh()
1669:                     THIS.grd_4c_Rodape.Refresh()
1670:                 ENDIF
1671: 
1672:                 *-- Botao OK: habilitado so com quantidade marcada > 0.
1673:                 IF PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
1674:                     THIS.cmg_4c_Botoes.Buttons(1).Enabled = ;
1675:                         THIS.this_oBusinessObject.this_lPermiteConfirmar
1676:                 ENDIF
1677: 
1678:                 *-- Imagem do componente corrente: limpa primeiro (igual ao
1679:                 *-- legado) e so reaparece se o base64 decodificar.
1680:                 IF PEMSTATUS(THIS, "img_4c_ImgFigJpg", 5)
1681:                     THIS.img_4c_ImgFigJpg.Picture = ""
1682:                     THIS.img_4c_ImgFigJpg.Visible = .F.
1683: 
1684:                     IF !EMPTY(THIS.this_oBusinessObject.this_cFigjpgs)

*-- Linhas 1697 a 1719:
1697:                         ALLTRIM(THIS.this_oBusinessObject.this_cCpros) + " - " + ;
1698:                         ALLTRIM(THIS.this_oBusinessObject.this_cDprosProduto)
1699: 
1700:                     THIS.Caption = loc_cCaption
1701: 
1702:                     IF PEMSTATUS(THIS, "cnt_4c_Sombra", 5)
1703:                         THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = loc_cCaption
1704:                         THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = loc_cCaption
1705:                     ENDIF
1706:                 ENDIF
1707: 
1708:                 *-- Tipo filtrado: so escreve quando difere (ver comentario).
1709:                 IF PEMSTATUS(THIS, "cbo_4c_CmbTipos", 5)
1710:                     loc_cTipoBO = THIS.this_oBusinessObject.this_cTipoSelecionado
1711:                     IF VARTYPE(THIS.cbo_4c_CmbTipos.Value) = "C" ;
1712:                        AND !(PADR(THIS.cbo_4c_CmbTipos.Value, 20) == PADR(loc_cTipoBO, 20))
1713:                         THIS.cbo_4c_CmbTipos.Value = loc_cTipoBO
1714:                         THIS.cbo_4c_CmbTipos.Refresh()
1715:                     ENDIF
1716:                 ENDIF
1717: 
1718:                 IF !EMPTY(loc_cAliasAnterior) AND USED(loc_cAliasAnterior)
1719:                     SELECT (loc_cAliasAnterior)

*-- Linhas 1725 a 1778:
1725:         CATCH TO loc_oErro
1726:             MsgErro(loc_oErro.Message + CHR(13) + ;
1727:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1728:                     "Procedure: " + loc_oErro.Procedure, ;
1729:                     "Erro ao Exibir Dados na Tela")
1730:         ENDTRY
1731: 
1732:         RETURN loc_lSucesso
1733:     ENDFUNC
1734: 
1735:     *--------------------------------------------------------------------------
1736:     * TornarControlesVisiveis - torna todos os controles visiveis
1737:     * recursivamente. FILTRO: img_4c_ImgFigJpg eh o UNICO controle flutuante
1738:     * deste form - nasce Visible = .F. de proposito (igual ao ImgFigJpg
1739:     * legado) e so aparece quando a grade tem imagem para exibir.
1740:     *--------------------------------------------------------------------------
1741:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1742:         LOCAL loc_i, loc_oControl
1743: 
1744:         FOR loc_i = 1 TO par_oContainer.ControlCount
1745:             loc_oControl = par_oContainer.Controls(loc_i)
1746:             IF VARTYPE(loc_oControl) = "O"
1747:                 IF UPPER(loc_oControl.Name) == "IMG_4C_IMGFIGJPG"
1748:                     LOOP
1749:                 ENDIF
1750:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
1751:                     loc_oControl.Visible = .T.
1752:                 ENDIF
1753:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1754:                     THIS.TornarControlesVisiveis(loc_oControl)
1755:                 ENDIF
1756:             ENDIF
1757:         ENDFOR
1758:     ENDPROC
1759: 
1760:     *--------------------------------------------------------------------------
1761:     * Destroy - equivalente ao PROCEDURE Release legado
1762:     * (ThisForm.ParentForm.Enabled = .t. / =DoDefault()): reabilita o form
1763:     * pai e fecha o cursor do produto antes de delegar a FormBase.Destroy()
1764:     * (libera o BO, restaura o menu).
1765:     *--------------------------------------------------------------------------
1766:     PROCEDURE Destroy()
1767:         IF VARTYPE(THIS.this_oFormPai) = "O"
1768:             THIS.this_oFormPai.Enabled = .T.
1769:         ENDIF
1770: 
1771:         IF USED("cursor_4c_Produto")
1772:             USE IN cursor_4c_Produto
1773:         ENDIF
1774: 
1775:         DODEFAULT()
1776:     ENDPROC
1777: 
1778: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpCpoBO.prg):
*==============================================================================
* SigOpCpoBO.prg - Business Object para Composicao de Produtos (SIGOPCPO)
*
* Form OPERACIONAL de SELECAO: eh um dialogo modal (WindowType = 1,
* TitleBar = 0, ControlBox = .F., Movable = .F.) aberto por um form PAI
* (o Init legado recebe LParameters pFrm, pKey e faz .ParentForm = pFrm /
* .ParentForm.Enabled = .f.). Ele lista a composicao (componentes) do produto
* informado em pKey, deixa o usuario MARCAR quais componentes deseja e, no
* botao OK, mantem na grade apenas as linhas marcadas; no Cancelar, descarta
* todas. Quem persiste eh o form PAI - esta tela NAO grava em tabela alguma.
*
* Tabela principal: SigPrCpo (chave primaria: cidchaves char(20) -
* constraint sigprcpo_cidchaves, ver docs/schema.sql)
* Tabelas auxiliares: SigCdPro (descricao / preco / moeda / referencia /
* imagem do componente e do produto-pai) e SigCdTpc (tipos de composicao com
* Custos = 2, que alimentam o cmbTipos).
*
* Legado (SigOpCpo.SCX):
*   Load           -> fConfigGeral() + Create Cursor crRodape
*                     (Descrs c(100), Usuars c(10), Totas n(12,2))
*   Init           -> guarda pFrm/pKey, lpKey = Padr(pKey, 14),
*                     CursorQuery([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros])
*                     para validar o produto e montar o Caption
*                     (Caption + " - " + lpKey + " - " + LocalPro.DPros),
*                     depois MontaGrades + SelecionaDados
*   SelecionaDados -> Zap crGrade/crRodape; SELECT da composicao (SigPrCpo a
*                     + SigCdPro b) para LocalCompo; Insert Into crGrade;
*                     SELECT Tipos From SigCdTpc Where Custos = 2 para
*                     popular o cmbTipos; Set Filter To Tipos = cmbTipos.Value
*   AtuaTotas      -> Select Sum(Qtds), Sum(Totas) From crGrade Where Marcas
*                     -> grdRodape.Column3 + habilita/desabilita o btnConfirmar
*
* Mapeamento SELECT legado -> coluna real -> propriedade (tipos conferidos
* em docs/schema.sql, lido com Get-Content -Raw por ser UTF-16 - regra #14):
*   a.CPros              -> SigPrCpo.cpros     char(14)      -> this_cCpros
*   a.Mats               -> SigPrCpo.mats      char(14)      -> this_cMats
*   b.DPros              -> SigCdPro.dpros     char(65)      -> this_cDpros
*   a.Qtds               -> SigPrCpo.qtds      numeric(8,3)  -> this_nQtds
*   a.UniCompos          -> SigPrCpo.unicompos char(3)       -> this_cUnicompos
*   b.PVens as PCompos   -> SigCdPro.pvens     numeric(11,5) -> this_nPcompos
*   b.Moevs as Moeds     -> SigCdPro.moevs     char(3)       -> this_cMoeds
*   (a.Qtds * b.PVens)   -> calculado          numeric(11,3) -> this_nTotas
*   a.Etiqs              -> SigPrCpo.etiqs     char(1)       -> this_cEtiqs
*   b.Reffs              -> SigCdPro.reffs     char(40)      -> this_cReffs
*   b.FigJpgs            -> SigCdPro.figjpgs   text NULL     -> this_cFigjpgs
*   a.Tipos              -> SigPrCpo.tipos     char(20)      -> this_cTipos
*   (sem controle)       -> SigPrCpo.cidchaves char(20) PK   -> this_cCidchaves
*
* ATENCAO - as duas colunas "gemeas" que a tela NAO le:
* SigPrCpo tem pcompos numeric(11,3) e moeds char(3) PROPRIAS, mas o SELECT
* legado NAO as usa: ele toma b.PVens as PCompos e b.Moevs as Moeds, isto eh,
* o preco de venda e a moeda de venda do COMPONENTE em SigCdPro. Trocar a
* origem mudaria o valor exibido e o total - por isso as propriedades
* this_nPcompos / this_cMoeds documentam de onde vem (regra #17: a formula e
* a origem do legado se transcrevem, nao se reescrevem).
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*==============================================================================

DEFINE CLASS SigOpCpoBO AS BusinessBase

    *==========================================================================
    * Chave do dialogo - produto cuja composicao esta sendo exibida
    *==========================================================================
    *-- Cpros: char(14) - codigo do produto-PAI. Equivale ao .lpKey do legado
    *-- (.lpKey = Padr(Iif(Type([pKey])=[C], pKey, []), 14)) e eh o filtro da
    *-- consulta da composicao (Where a.CPros = '<lpKey>'). O PADR ate 14 eh
    *-- obrigatorio: a coluna eh char(14) e a comparacao com o valor gravado
    *-- depende do padding (regra #42).
    this_cCpros        = ""   && char(14) NOT NULL - produto-pai (lpKey)

    *-- Descricao do produto-pai, lida de SigCdPro.dpros pelo CursorQuery
    *-- ([SigCdPro],[LocalPro],[Cpros],lpKey,[DPros]) do Init legado. Entra no
    *-- Caption do form e nos dois labels da faixa do cabecalho
    *-- (lblSombra/lblTitulo recebem ThisForm.Caption).
    this_cDprosProduto = ""   && char(65) NOT NULL - descricao do produto-pai

    *-- Cidchaves: char(20) - PRIMARY KEY de SigPrCpo (constraint
    *-- sigprcpo_cidchaves). A tela nao grava, mas a chave eh declarada para o
    *-- ObterChavePrimaria() da auditoria e para que a leitura de uma linha
    *-- possa identificar o registro de origem sem ambiguidade.
    this_cCidchaves    = ""   && char(20) NOT NULL - chave primaria SigPrCpo

    *==========================================================================
    * Linha corrente da composicao (colunas da grade grdItens)
    *==========================================================================
    *-- Marcas: coluna LOGICA que existe SO no cursor da grade (nao ha coluna
    *-- equivalente em SigPrCpo). O legado a inicializa com
    *-- (LocalCompo.Etiqs = [S]), isto eh, o componente nasce marcado quando
    *-- Etiqs = "S", e a alterna com Replace Marcas With Not Marcas nos
    *-- handlers do CheckBox da Column1. Propriedade LOGICA porque a origem eh
    *-- uma comparacao, nao uma coluna numeric(1,0) nem bit.
    this_lMarcas       = .F.  && logico (so cursor) - componente selecionado

    *-- Mats: char(14) - codigo do componente (coluna "Item" da grade). No
    *-- SELECT ele tambem eh o lado do join com SigCdPro (a.Mats = b.CPros).
    this_cMats         = ""   && char(14) NOT NULL - codigo do componente

    *-- Dpros: char(65) - descricao do componente, vinda de SigCdPro.dpros
    *-- (coluna "Descricao", a mais larga da grade - Column3.Width = 394).
    this_cDpros        = ""   && char(65) NOT NULL - descricao do componente

    *-- Qtds: numeric(8,3) - quantidade do componente na composicao. Exibida
    *-- com InputMask [99999.999] na Column4 e somada no total de quantidade
    *-- que habilita o botao OK.
    this_nQtds         = 0    && numeric(8,3) NOT NULL - quantidade

    *-- UniCompos: char(3) - unidade da composicao (coluna "Uni",
    *-- Column5.Width = 31).
    this_cUnicompos    = ""   && char(3) NOT NULL - unidade do componente

    *-- Pcompos: o SELECT legado toma b.PVens as PCompos, ou seja o PRECO DE
    *-- VENDA do componente em SigCdPro - numeric(11,5) -, e NAO a coluna
    *-- SigPrCpo.pcompos (numeric(11,3)), que existe mas nao eh lida. Exibido
    *-- com InputMask [99999999.999] na Column6 ("Valor Unitario").
    this_nPcompos      = 0    && numeric(11,5) NOT NULL - b.PVens as PCompos

    *-- Moeds: o SELECT legado toma b.Moevs as Moeds, isto eh a MOEDA DE
    *-- VENDA do componente em SigCdPro - char(3) -, e NAO a coluna
    *-- SigPrCpo.moeds, que existe mas nao eh lida. Coluna "Moe" da grade
    *-- (Column7.Width = 31).
    this_cMoeds        = ""   && char(3) NOT NULL - b.Moevs as Moeds

    *-- Totas: valor total da linha. Formula do legado, transcrita sem
    *-- reescrita (regra #17): (a.Qtds * b.PVens) - quantidade da composicao
    *-- multiplicada pelo preco de venda do componente. SigPrCpo tem uma
    *-- coluna totas numeric(11,3), mas o SELECT NAO a le: o valor eh sempre
    *-- recalculado. Exibido com InputMask [99999999.99] na Column8, que eh a
    *-- unica coluna em negrito e com BackColor 245,251,136.
    this_nTotas        = 0    && calculado numeric(11,3) - Qtds * PVens

    *-- Etiqs: char(1) - flag de etiqueta do componente. O unico uso na tela
    *-- eh definir o estado inicial de Marcas (Marcas = (Etiqs = "S")); nao
    *-- tem coluna na grade.
    this_cEtiqs        = ""   && char(1) NOT NULL - "S" marca o componente

    *-- Reffs: char(40) - referencia do fornecedor do componente. Nao tem
    *-- coluna na grade: eh usada no titulo da tela de zoom da imagem
    *-- (Do Form SigOpZom With ... , [Ref. Fornecedor : ] + crGrade.Reffs).
    this_cReffs        = ""   && char(40) NOT NULL - ref. do fornecedor

    *-- Figjpgs: coluna text NULL de SigCdPro com a imagem do componente em
    *-- base64. O legado remove os prefixos data:image/...;base64, e decodifica
    *-- com Strconv(..., 14) UMA unica vez, gravando o resultado em arquivo
    *-- temporario antes de atribuir ao .Picture do Image. Propriedade de
    *-- CARACTERE porque guarda o base64 cru; por ser NULL no banco, toda
    *-- leitura passa por Nvl(..., []) como no Insert Into legado.
    this_cFigjpgs      = ""   && text NULL - imagem do componente em base64

    *-- Tipos: char(20) - tipo de composicao da linha. Eh a coluna pela qual o
    *-- cmbTipos FILTRA a grade (Set Filter To Tipos = cmbTipos.Value In
    *-- crGrade), executado tanto no fim do SelecionaDados quanto no Valid do
    *-- combo.
    this_cTipos        = ""   && char(20) NOT NULL - tipo de composicao

    *==========================================================================
    * Linha do rodape (grade grdRodape) - cursor criado no Load legado com
    * Create Cursor crRodape (Descrs c(100), Usuars c(10), Totas n(12,2)).
    * O legado insere UMA linha (Insert Into crRodape (Totas) Values (0)) e so
    * atualiza Totas; Descrs e Usuars ficam em branco, mas existem porque as
    * tres colunas estao ligadas as tres Columns do grdRodape
    * (Column1 -> Descrs, Column2 -> Usuars, Column3 -> Totas).
    *==========================================================================
    this_cDescrsRodape = ""   && c(100) cursor local - Column1 do grdRodape
    this_cUsuarsRodape = ""   && c(10)  cursor local - Column2 do grdRodape
    this_nTotasRodape  = 0    && n(12,2) cursor local - Column3 (total geral)

    *==========================================================================
    * Totais do AtuaTotas
    *
    * O legado agrupa SO as linhas marcadas:
    *   Select [ ] as Agrupar, Sum(Qtds) as Qtds, Sum(Totas) as Totas
    *     From crGrade Where Marcas Group By 1 Into Cursor LocalTot
    * O "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total, e nao se troca por soma de tudo.
    * O botao OK fica habilitado apenas quando LocalTot.Qtds > 0.
    *==========================================================================
    this_nTotalQtds    = 0    && soma de Qtds das linhas com Marcas = .T.
    this_nTotalTotas   = 0    && soma de Totas das linhas com Marcas = .T.

    *-- Espelha o Enabled do btnConfirmar: (LocalTot.Qtds > 0) no legado.
    *-- Fonte UNICA do estado do botao - o form apenas reflete esta
    *-- propriedade, para nao existirem dois criterios divergentes.
    this_lPermiteConfirmar = .F.

    *==========================================================================
    * Filtro de tipo (cmbTipos) - ComboBox Style = 2 (dropdown list),
    * FontName "Courier New", SEM ControlSource: ele apenas filtra a grade.
    *==========================================================================
    *-- Valor corrente do combo, usado no Set Filter To Tipos = <valor>.
    this_cTipoSelecionado = ""

    *-- Equivale ao llBrc do SelecionaDados legado: fica .T. quando ALGUMA
    *-- linha da composicao tem Tipos vazio (If Not llBrc And
    *-- Empty(LocalCompo.Tipos)). Nesse caso o legado acrescenta um item
    *-- Space(20) no TOPO do combo e o seleciona por padrao; sem nenhuma linha
    *-- sem tipo, o default passa a ser o PRIMEIRO tipo retornado por SigCdTpc
    *-- (ThisForm.cmbTipos.Value = Iif(llBrc, Space(20), LocalTpCom.Tipos)).
    this_lTemTipoEmBranco = .F.

    *-- Item em branco do combo: Space(20), do tamanho exato de
    *-- SigPrCpo.tipos char(20), para o Set Filter To comparar certo.
    this_cTipoEmBranco    = ""

    *-- Filtro fixo da consulta de tipos: Where Custos = 2 em SigCdTpc
    *-- (coluna numeric(1,0)). Valor TRANSCRITO do legado - mudar aqui muda
    *-- quais tipos o usuario pode escolher.
    this_nCustosFiltro    = 2

    *-- Quantidade de tipos carregados de SigCdTpc (sem contar o item em
    *-- branco), para o form saber se o combo tem conteudo.
    this_nQtdeTipos       = 0

    *==========================================================================
    * Tabelas envolvidas (nomes EXATOS do banco - PILAR 2)
    *==========================================================================
    this_cTabelaComposicao = "SigPrCpo"   && composicao do produto (principal)
    this_cTabelaProduto    = "SigCdPro"   && produto: descricao/preco/imagem
    this_cTabelaTipoComp   = "SigCdTpc"   && tipos de composicao do cmbTipos

    *==========================================================================
    * Aliases dos cursores (PILAR 3 - nomes novos, prefixo cursor_4c_)
    *
    * Correspondencia com o legado:
    *   crGrade    -> this_cCursorGrade     (grade grdItens; no legado o cursor
    *                                        pertence ao form PAI e aqui eh
    *                                        apenas Zap'ado - na arquitetura
    *                                        nova ele eh criado e populado por
    *                                        este BO, e o form pai o le depois
    *                                        que o dialogo fecha)
    *   crRodape   -> this_cCursorRodape    (grade grdRodape, 1 linha)
    *   LocalCompo -> this_cCursorTempComp  (cursor TEMPORARIO do SQLEXEC da
    *                                        composicao; o SQLEXEC nunca vai
    *                                        para o alias ligado ao Grid, que
    *                                        perderia o ColumnCount)
    *   LocalTpCom -> this_cCursorTipos     (tipos de SigCdTpc)
    *   LocalPro   -> this_cCursorProduto   (cabecalho: descricao do produto)
    *   LocalTot   -> this_cCursorTotais    (totais do AtuaTotas)
    *==========================================================================
    this_cCursorGrade     = "cursor_4c_Grade"
    this_cCursorRodape    = "cursor_4c_Rodape"
    this_cCursorTempComp  = "cursor_4c_TempComp"
    this_cCursorTipos     = "cursor_4c_Tipos"
    this_cCursorTempTipos = "cursor_4c_TempTipos"
    this_cCursorProduto   = "cursor_4c_Produto"
    this_cCursorTotais    = "cursor_4c_Totais"

    *==========================================================================
    * Decodificacao da imagem (SigCdPro.figjpgs)
    *
    * O legado retira TRES prefixos data-URI antes do Strconv(..., 14):
    *   Strtran(Strtran(Strtran(FigJpgs,[data:image/png;base64,],[]),
    *                                  [data:image/jpeg;base64,],[]),
    *                                  [data:image/jpg;base64,],[])
    * Os prefixos ficam em propriedades para que exista UM unico lugar com a
    * lista, e o Strconv seja aplicado UMA SO VEZ sobre o resultado - decodar
    * duas vezes devolve lixo e a imagem nao abre.
    *==========================================================================
    this_cPrefixoPng  = "data:image/png;base64,"
    this_cPrefixoJpeg = "data:image/jpeg;base64,"
    this_cPrefixoJpg  = "data:image/jpg;base64,"

    *-- Caminho do arquivo .jpg temporario gerado por StrToFile para alimentar
    *-- o .Picture do Image (no legado: Sys(2023) + "\" + Sys(2015) + ".jpg").
    this_cArquivoImagem = ""

    *==========================================================================
    * Estado do dialogo
    *==========================================================================
    *-- .T. quando o usuario fechou pelo OK (btnConfirmar) e portanto as linhas
    *-- MARCADAS devem ser devolvidas ao form pai; .F. no Cancelar (btnSair),
    *-- que descarta todas as linhas.
    this_lConfirmado      = .F.

    *-- Quantidade de componentes carregados na grade (Reccount do cursor da
    *-- grade), usada pelo legado em If (Reccount([crGrade]) > 0) antes de
    *-- calcular os totais iniciais.
    this_nQtdeComponentes = 0

    *==========================================================================
    * Init - Inicializa o Business Object
    *
    * Define a tabela principal (SigPrCpo) e a chave primaria REAL (cidchaves
    * - constraint sigprcpo_cidchaves, docs/schema.sql), fixa os valores
    * constantes transcritos do legado e zera o estado de edicao herdado de
    * BusinessBase.
    *
    * NAO sobrescreve Inserir()/Atualizar()/ExecutarExclusao(): esta tela eh
    * um dialogo de SELECAO e todo Insert Into / Replace / Delete do legado
    * tem por destino CURSOR LOCAL (crGrade e crRodape) - o acesso remoto eh
    * 100% Select. O comportamento padrao herdado de BusinessBase (recusar a
    * gravacao e reportar pelo ExibirFalha do Salvar) ja eh o correto, e
    * inventar um INSERT aqui violaria a regra #22 (a lista de colunas vem do
    * schema, nunca de adivinhacao).
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            DODEFAULT("SigPrCpo")

            THIS.this_cTabela     = "SigPrCpo"
            THIS.this_cCampoChave = "cidchaves"

            *-- Nomes das tabelas auxiliares (PILAR 2 - nomes exatos).
            THIS.this_cTabelaComposicao = "SigPrCpo"
            THIS.this_cTabelaProduto    = "SigCdPro"
            THIS.this_cTabelaTipoComp   = "SigCdTpc"

            *-- Item em branco do cmbTipos: Space(20) = largura de
            *-- SigPrCpo.tipos char(20), igual ao AddItem(Space(20)) legado.
            THIS.this_cTipoEmBranco = SPACE(20)

            *-- Filtro fixo da consulta de tipos (SigCdTpc.custos = 2).
            THIS.this_nCustosFiltro = 2

            *-- Prefixos data-URI removidos antes do Strconv(..., 14).
            THIS.this_cPrefixoPng  = "data:image/png;base64,"
            THIS.this_cPrefixoJpeg = "data:image/jpeg;base64,"
            THIS.this_cPrefixoJpg  = "data:image/jpg;base64,"

            *-- Estado inicial do dialogo: nada carregado, nada marcado, OK
            *-- desabilitado (btnConfirmar.Enabled = .f. no SelecionaDados).
            THIS.this_cCpros            = ""
            THIS.this_cDprosProduto     = ""
            THIS.this_cCidchaves        = ""
            THIS.this_lMarcas           = .F.
            THIS.this_cMats             = ""
            THIS.this_cDpros            = ""
            THIS.this_nQtds             = 0
            THIS.this_cUnicompos        = ""
            THIS.this_nPcompos          = 0
            THIS.this_cMoeds            = ""
            THIS.this_nTotas            = 0
            THIS.this_cEtiqs            = ""
            THIS.this_cReffs            = ""
            THIS.this_cFigjpgs          = ""
            THIS.this_cTipos            = ""
            THIS.this_cDescrsRodape     = ""
            THIS.this_cUsuarsRodape     = ""
            THIS.this_nTotasRodape      = 0
            THIS.this_nTotalQtds        = 0
            THIS.this_nTotalTotas       = 0
            THIS.this_lPermiteConfirmar = .F.
            THIS.this_cTipoSelecionado  = ""
            THIS.this_lTemTipoEmBranco  = .F.
            THIS.this_nQtdeTipos        = 0
            THIS.this_cArquivoImagem    = ""
            THIS.this_lConfirmado       = .F.
            THIS.this_nQtdeComponentes  = 0

            *-- Estado de edicao herdado de BusinessBase: dialogo de selecao
            *-- nunca entra em edicao de registro.
            THIS.this_lEmEdicao       = .F.
            THIS.this_lNovoRegistro   = .F.
            THIS.this_lDadosAlterados = .F.
            THIS.this_cMensagemErro   = ""
            THIS.this_lErroExibido    = .F.

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro("Erro ao inicializar SigOpCpoBO:" + CHR(13) + ;
                    loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Devolve a chave primaria da linha corrente
    * (SigPrCpo.cidchaves char(20)), usada pela auditoria de BusinessBase.
    *
    * PADR ate 20 porque a coluna eh char(20) e o valor guardado na property
    * pode vir com ALLTRIM na leitura do cursor (regra #42).
    *==========================================================================
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN PADR(ALLTRIM(THIS.this_cCidchaves), 20)
    ENDFUNC

    *==========================================================================
    * Fase 2 - Metodos de carga (equivalentes ao CRUD desta tela)
    *
    * Este dialogo eh SOMENTE-LEITURA no banco: o Init legado (Load +
    * SelecionaDados) faz so Select; o que o usuario marca so eh persistido
    * quando o form PAI grava a composicao, fora deste BO. Por isso Inserir(),
    * Atualizar() e ExecutarExclusao() NAO sao sobrescritos aqui - o
    * comportamento herdado de BusinessBase (recusar a operacao) ja eh o
    * adequado para este dialogo, e RegistrarAuditoria() so eh chamado por
    * esses dois metodos (regra: Audit System). Os metodos abaixo substituem,
    * um a um, a logica do Load/Init/SelecionaDados/AtuaTotas do legado:
    *
    *   Load + Create Cursor crRodape   -> THIS.Init() (Fase 1)
    *   CursorQuery(SigCdPro,...)       -> THIS.CarregarProduto()
    *   SelecionaDados (Insert crGrade) -> THIS.CarregarComposicao()
    *   SelecionaDados (combo Tipos)    -> THIS.CarregarTipos() (PROTECTED,
    *                                      chamado por CarregarComposicao)
    *   Set Filter To Tipos = ...       -> THIS.AplicarFiltroTipo()
    *   AtuaTotas                       -> THIS.AtualizarTotais()
    *   btnConfirmar.Click              -> THIS.ConfirmarSelecao()
    *   btnSair.Click                   -> THIS.CancelarSelecao()
    *   ImgFigJpg.Click (Strconv+jpg)   -> THIS.DecodificarImagem()
    *   leitura da linha da grade       -> THIS.CarregarDoCursor()
    *==========================================================================

    *==========================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de cursor_4c_Grade (ou outro
    * alias informado) para as properties this_* da linha. Usado pelo form
    * sempre que a linha corrente da grade mudar (AfterRowColChange) ou antes
    * de abrir o zoom da imagem (ImgFigJpgClick).
    *==========================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor) AND !EOF(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_lMarcas    = TratarNulo(Marcas, .F.)
            THIS.this_cCidchaves = TratarNulo(Cidchaves, "")
            THIS.this_cMats      = TratarNulo(Mats, "")
            THIS.this_cDpros     = TratarNulo(Dpros, "")
            THIS.this_nQtds      = TratarNulo(Qtds, 0)
            THIS.this_cUnicompos = TratarNulo(UniCompos, "")
            THIS.this_nPcompos   = TratarNulo(PCompos, 0)
            THIS.this_cMoeds     = TratarNulo(Moeds, "")
            THIS.this_nTotas     = TratarNulo(Totas, 0)
            THIS.this_cEtiqs     = TratarNulo(Etiqs, "")
            THIS.this_cReffs     = TratarNulo(Reffs, "")
            THIS.this_cFigjpgs   = TratarNulo(FigJpgs, "")
            THIS.this_cTipos     = TratarNulo(Tipos, "")

            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * CarregarProduto - Valida o produto-pai (par_cCpros, equivalente ao
    * .lpKey legado) e le a descricao em SigCdPro.dpros para compor o Caption
    * do form ("... - <Cpros> - <Dpros>"), igual ao CursorQuery([SigCdPro],
    * [LocalPro],[Cpros],lpKey,[DPros]) do Init legado.
    *
    * Retorna .F. quando o produto nao existe (equivalente ao
    * "MessageBox('O Produto Informado Nao Existe!!!',...) / .Release" do
    * legado) - o form eh quem decide fechar, exibindo this_cMensagemErro.
    *==========================================================================
    FUNCTION CarregarProduto(par_cCpros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            THIS.this_cCpros = PADR(ALLTRIM(TratarNulo(par_cCpros, "")), 14)

            IF USED(THIS.this_cCursorProduto)
                USE IN (THIS.this_cCursorProduto)
            ENDIF

            loc_cSQL = "SELECT dpros FROM SigCdPro " + ;
                       "WHERE cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorProduto))

            IF loc_nResultado > 0 AND USED(THIS.this_cCursorProduto) ;
                    AND RECCOUNT(THIS.this_cCursorProduto) > 0

                SELECT (THIS.this_cCursorProduto)
                GO TOP
                THIS.this_cDprosProduto = TratarNulo(Dpros, "")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "O Produto Informado N" + CHR(227) + ;
                    "o Existe!!!"
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Validar Produto")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarComposicao - Recria cursor_4c_Grade (equivalente a crGrade) com
    * a composicao do produto em THIS.this_cCpros, no mesmo SELECT do legado
    * (SigPrCpo a INNER JOIN SigCdPro b, Order By a.Mats), e so depois monta o
    * filtro de tipos (THIS.CarregarTipos + THIS.AplicarFiltroTipo), igual ao
    * SelecionaDados legado (Zap crGrade/crRodape -> Select -> Insert Into
    * crGrade -> Select Tipos -> Set Filter To).
    *
    * O SQLEXEC NUNCA vai direto para cursor_4c_Grade (regra do SQLEXEC zerar
    * ColumnCount do Grid): a consulta roda em cursor_4c_TempComp e cada linha
    * eh copiada por APPEND BLANK + REPLACE para o cursor local que o Grid usa.
    *==========================================================================
    FUNCTION CarregarComposicao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, ;
              loc_lTemBranco, loc_cCidchaves, loc_cMats, loc_cDpros, ;
              loc_nQtds, loc_cUnicompos, loc_nPcompos, loc_cMoeds, ;
              loc_nTotas, loc_cEtiqs, loc_cReffs, loc_cFigjpgs, loc_cTipos

        loc_lResultado = .F.
        loc_lTemBranco = .F.

        TRY
            IF USED(THIS.this_cCursorTempComp)
                USE IN (THIS.this_cCursorTempComp)
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.mats, b.dpros, a.qtds, " + ;
                       "a.unicompos, b.pvens AS pcompos, b.moevs AS moeds, " + ;
                       "(a.qtds * b.pvens) AS totas, a.etiqs, b.reffs, " + ;
                       "b.figjpgs, a.tipos " + ;
                       "FROM SigPrCpo a INNER JOIN SigCdPro b " + ;
                       "ON a.mats = b.cpros " + ;
                       "WHERE a.cpros = " + EscaparSQL(ALLTRIM(THIS.this_cCpros)) + ;
                       " ORDER BY a.mats"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempComp))

            IF loc_nResultado < 0
                THIS.this_cMensagemErro = "Falha ao consultar a composi" + ;
                    CHR(231) + CHR(227) + "o do produto." + CHR(13) + ;
                    CapturarErroSQL()
            ELSE
                IF USED(THIS.this_cCursorGrade)
                    USE IN (THIS.this_cCursorGrade)
                ENDIF

                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorGrade) ;
                    (Marcas L, Cidchaves C(20), Mats C(14), Dpros C(65), ;
                     Qtds N(8,3), UniCompos C(3), PCompos N(11,5), ;
                     Moeds C(3), Totas N(11,3), Etiqs C(1), Reffs C(40), ;
                     FigJpgs M, Tipos C(20))
                SET NULL OFF

                IF USED(THIS.this_cCursorTempComp)
                    SELECT (THIS.this_cCursorTempComp)
                    SCAN
                        loc_cCidchaves = TratarNulo(cidchaves, "")
                        loc_cMats      = TratarNulo(mats, "")
                        loc_cDpros     = TratarNulo(dpros, "")
                        loc_nQtds      = TratarNulo(qtds, 0)
                        loc_cUnicompos = TratarNulo(unicompos, "")
                        loc_nPcompos   = TratarNulo(pcompos, 0)
                        loc_cMoeds     = TratarNulo(moeds, "")
                        loc_nTotas     = TratarNulo(totas, 0)
                        loc_cEtiqs     = TratarNulo(etiqs, "")
                        loc_cReffs     = TratarNulo(reffs, "")
                        loc_cFigjpgs   = TratarNulo(figjpgs, "")
                        loc_cTipos     = TratarNulo(tipos, "")

                        IF EMPTY(loc_cTipos)
                            loc_lTemBranco = .T.
                        ENDIF

                        SELECT (THIS.this_cCursorGrade)
                        APPEND BLANK
                        REPLACE Marcas    WITH (loc_cEtiqs == "S"), ;
                                Cidchaves WITH loc_cCidchaves, ;
                                Mats      WITH loc_cMats, ;
                                Dpros     WITH loc_cDpros, ;
                                Qtds      WITH loc_nQtds, ;
                                UniCompos WITH loc_cUnicompos, ;
                                PCompos   WITH loc_nPcompos, ;
                                Moeds     WITH loc_cMoeds, ;
                                Totas     WITH loc_nTotas, ;
                                Etiqs     WITH loc_cEtiqs, ;
                                Reffs     WITH loc_cReffs, ;
                                FigJpgs   WITH loc_cFigjpgs, ;
                                Tipos     WITH loc_cTipos

                        SELECT (THIS.this_cCursorTempComp)
                    ENDSCAN

                    USE IN (THIS.this_cCursorTempComp)
                ENDIF

                THIS.this_lTemTipoEmBranco = loc_lTemBranco
                THIS.this_nQtdeComponentes = RECCOUNT(THIS.this_cCursorGrade)

                SELECT (THIS.this_cCursorGrade)
                GO TOP

                THIS.CarregarTipos()
                THIS.AplicarFiltroTipo(THIS.this_cTipoSelecionado)

                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CarregarTipos (PROTECTED) - Monta cursor_4c_Tipos a partir de SigCdTpc
    * Where Custos = 2 (this_nCustosFiltro), igual ao "Select Tipos From
    * SigCdTpc Where Custos = 2" do SelecionaDados legado. Quando
    * this_lTemTipoEmBranco (setado por CarregarComposicao) acrescenta o item
    * em branco Space(20) no TOPO, igual ao AddItem(Space(20)) legado, e
    * define this_cTipoSelecionado com o default (o item em branco, se
    * existir; senao o primeiro tipo retornado).
    *
    * PROTECTED porque so faz sentido chamado por CarregarComposicao - o form
    * nunca precisa chama-lo isoladamente, so ler cursor_4c_Tipos.
    *==========================================================================
    PROTECTED PROCEDURE CarregarTipos()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_oErro, loc_cTipo
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorTempTipos)
                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            loc_cSQL = "SELECT tipos FROM SigCdTpc " + ;
                       "WHERE custos = " + ;
                       FormatarNumeroSQL(THIS.this_nCustosFiltro, 0) + ;
                       " ORDER BY tipos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, (THIS.this_cCursorTempTipos))

            IF USED(THIS.this_cCursorTipos)
                USE IN (THIS.this_cCursorTipos)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorTipos) (Tipos C(20))

            IF THIS.this_lTemTipoEmBranco
                APPEND BLANK
                REPLACE Tipos WITH THIS.this_cTipoEmBranco
            ENDIF

            IF loc_nResultado >= 0 AND USED(THIS.this_cCursorTempTipos)
                SELECT (THIS.this_cCursorTempTipos)
                SCAN
                    loc_cTipo = TratarNulo(tipos, "")
                    SELECT (THIS.this_cCursorTipos)
                    APPEND BLANK
                    REPLACE Tipos WITH loc_cTipo
                    SELECT (THIS.this_cCursorTempTipos)
                ENDSCAN

                USE IN (THIS.this_cCursorTempTipos)
            ENDIF

            THIS.this_nQtdeTipos = RECCOUNT(THIS.this_cCursorTipos)

            SELECT (THIS.this_cCursorTipos)
            GO TOP

            THIS.this_cTipoSelecionado = IIF(RECCOUNT(THIS.this_cCursorTipos) > 0, ;
                TratarNulo(Tipos, THIS.this_cTipoEmBranco), ;
                THIS.this_cTipoEmBranco)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Carregar Tipos de Composi" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *==========================================================================
    * AplicarFiltroTipo - Filtra cursor_4c_Grade pelo tipo escolhido no
    * cmbTipos, igual ao "Select crGrade / Set Filter To Tipos =
    * ThisForm.cmbTipos.Value In crGrade / Go Top In crGrade" do Valid legado.
    * Comparacao com == (SET EXACT ON global) contra o valor JA padronizado
    * para 20 posicoes (this_cTipoSelecionado nunca leva ALLTRIM - regra da
    * comparacao com buffer padded).
    *
    * O VALOR ENTRA NA EXPRESSAO COMO LITERAL - NUNCA como THIS.<property>.
    * SET FILTER guarda a expressao como TEXTO e a REAVALIA a cada acesso a
    * registro, resolvendo o THIS contra o objeto que estiver ativo NAQUELE
    * momento - e nao contra este BO. Medido no VFP9 (automation\
    * MedirSetFilterThis.prg, 2026-10-30) com "SET FILTER TO Tipos ==
    * THIS.this_cTipoSelecionado", que o VFP armazena como
    * [TIPOS==This.THIS_CTIPOSELECIONADO]:
    *
    *   GO TOP de DENTRO deste BO        -> OK (3 linhas visiveis)
    *   GO TOP de dentro de OUTRO objeto -> ERRO "Property
    *                                       THIS_CTIPOSELECIONADO is not found"
    *   GO TOP fora de objeto algum      -> o VFP DESCARTA O FILTRO em
    *                                       silencio: FILTER() volta VAZIO
    *   valor como LITERAL               -> OK nos TRES contextos
    *
    * A ultima linha do meio eh a perigosa: o Grid repinta FORA de qualquer
    * metodo, entao a grade passaria a exibir TODOS os tipos sem erro na
    * tela - divergencia muda do legado (PILAR 1), que filtra de verdade.
    * O delimitador do literal eh escolhido entre ", ' e [] para o valor
    * nunca quebrar a expressao.
    *==========================================================================
    FUNCTION AplicarFiltroTipo(par_cTipo)
        LOCAL loc_lResultado, loc_cValor, loc_cExpr
        loc_lResultado = .F.

        THIS.this_cTipoSelecionado = TratarNulo(par_cTipo, THIS.this_cTipoEmBranco)

        IF USED(THIS.this_cCursorGrade)
            loc_cValor = THIS.this_cTipoSelecionado

            DO CASE
            CASE !(CHR(34) $ loc_cValor)
                loc_cExpr = "Tipos == " + CHR(34) + loc_cValor + CHR(34)
            CASE !("'" $ loc_cValor)
                loc_cExpr = "Tipos == '" + loc_cValor + "'"
            OTHERWISE
                loc_cExpr = "Tipos == [" + STRTRAN(loc_cValor, "]", " ") + "]"
            ENDCASE

            SELECT (THIS.this_cCursorGrade)
            SET FILTER TO &loc_cExpr
            GO TOP
            loc_lResultado = .T.
        ENDIF

        THIS.AtualizarTotais()

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * AtualizarTotais - Soma Qtds/Totas das linhas MARCADAS de cursor_4c_Grade
    * e habilita/desabilita a confirmacao, igual ao AtuaTotas legado:
    *   Select Sum(Qtds) as Qtds, Sum(Totas) as Totas From crGrade
    *     Where Marcas Group By 1 Into Cursor LocalTot
    *   btnConfirmar.Enabled = (LocalTot.Qtds > 0)
    * "Where Marcas" eh criterio de negocio (regra #17): linha DESMARCADA
    * nao entra no total - nao se troca por soma de tudo.
    *
    * O TOTAL EH DA COMPOSICAO INTEIRA, NAO DO TIPO FILTRADO - e isso eh
    * FIEL ao legado, nao um descuido. Medido no VFP9 (automation\
    * MedirSelectComSetFilter.prg, 2026-10-30) com SET FILTER ativo em um
    * tipo que cobre 90 de 100: o acesso NAVEGACIONAL (COUNT, SCAN) respeita
    * o filtro e da 90, mas o SELECT SQL local o IGNORA e da 100 - inclusive
    * na forma exata do AtuaTotas legado (Select .. Where Marcas Group By 1).
    * Como o legado usa esse mesmo SELECT, ele tambem totaliza a composicao
    * inteira. NUNCA trocar este SELECT por SCAN/COUNT "para respeitar o
    * filtro": isso mudaria o numero que o usuario ve, em silencio.
    *==========================================================================
    FUNCTION AtualizarTotais()
        LOCAL loc_lResultado, loc_nSomaQtds, loc_nSomaTotas, loc_oErro
        loc_lResultado = .F.
        loc_nSomaQtds  = 0
        loc_nSomaTotas = 0

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT SUM(Qtds) AS SomaQtds, SUM(Totas) AS SomaTotas ;
                    FROM (THIS.this_cCursorGrade) WHERE Marcas = .T. ;
                    INTO CURSOR cursor_4c_SomaMarcadas

                IF USED("cursor_4c_SomaMarcadas")
                    loc_nSomaQtds  = TratarNulo(cursor_4c_SomaMarcadas.SomaQtds, 0)
                    loc_nSomaTotas = TratarNulo(cursor_4c_SomaMarcadas.SomaTotas, 0)
                    USE IN cursor_4c_SomaMarcadas
                ENDIF
            ENDIF

            THIS.this_nTotalQtds        = loc_nSomaQtds
            THIS.this_nTotalTotas       = loc_nSomaTotas
            THIS.this_lPermiteConfirmar = (loc_nSomaQtds > 0)

            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Atualizar Totais")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * ConfirmarSelecao - Equivalente ao btnConfirmar.Click legado: descarta as
    * linhas NAO marcadas de cursor_4c_Grade (Select crGrade / Set Filter To /
    * Scan / If Not Marcas / Delete / EndScan) e marca o dialogo como
    * confirmado, para o form PAI ler apenas os componentes escolhidos.
    *==========================================================================
    FUNCTION ConfirmarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                SCAN
                    IF !Marcas
                        DELETE
                    ENDIF
                ENDSCAN
                GO TOP
            ENDIF

            THIS.this_lConfirmado = .T.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Confirmar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * CancelarSelecao - Equivalente ao btnSair.Click legado: descarta TODAS as
    * linhas de cursor_4c_Grade (Select crGrade / Set Filter To / Scan /
    * Delete / EndScan), incondicional - nao so as desmarcadas - e marca o
    * dialogo como NAO confirmado.
    *==========================================================================
    FUNCTION CancelarSelecao()
        LOCAL loc_lResultado, loc_oErro
        loc_lResultado = .F.

        TRY
            IF USED(THIS.this_cCursorGrade)
                SELECT (THIS.this_cCursorGrade)
                SET FILTER TO
                ZAP
            ENDIF

            THIS.this_lConfirmado = .F.
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Cancelar Sele" + CHR(231) + CHR(227) + "o")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *==========================================================================
    * DecodificarImagem - Remove os tres prefixos data-URI e decodifica o
    * base64 de SigCdPro.figjpgs, gravando o resultado num .jpg temporario,
    * igual ao ImgFigJpg.Click legado:
    *   lcArq = Sys(2023) + [\] + Sys(2015) + [.jpg]
    *   Strconv(Strtran(Strtran(Strtran(FigJpgs,png,[]),jpeg,[]),jpg,[]), 14)
    *   StrToFile(lcFoto, lcArq)
    * O Strconv roda UMA SO VEZ sobre o resultado dos tres Strtran - decodar
    * duas vezes devolve lixo. this_cArquivoImagem fica "" quando nao ha
    * imagem, igual ao Image.Visible = .F. do legado quando Empty(FigJpgs).
    *==========================================================================
    FUNCTION DecodificarImagem(par_cFigjpgsBase64)
        LOCAL loc_lResultado, loc_cBase64, loc_cBinario, loc_cArquivo, loc_oErro
        loc_lResultado = .F.
        THIS.this_cArquivoImagem = ""

        TRY
            loc_cBase64 = TratarNulo(par_cFigjpgsBase64, "")

            IF !EMPTY(loc_cBase64)
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoPng,  "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpeg, "")
                loc_cBase64 = STRTRAN(loc_cBase64, THIS.this_cPrefixoJpg,  "")

                loc_cBinario = STRCONV(loc_cBase64, 14)
                loc_cArquivo = ADDBS(SYS(2023)) + SYS(2015) + ".jpg"

                IF STRTOFILE(loc_cBinario, loc_cArquivo) > 0
                    THIS.this_cArquivoImagem = loc_cArquivo
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao Decodificar Imagem")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

