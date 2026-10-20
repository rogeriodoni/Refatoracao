# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Pagamentos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH ThisForm.Grd define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ThisForm.Grd.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpAut.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1448 linhas total):

*-- Linhas 6 a 78:
6: *
7: * Legado (Init): Lparameters poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica
8: * Uso canonico:
9: *   loForm = CREATEOBJECT("FormSigOpAut", THISFORM, cEmps, cDopes, nNumes, ;
10: *       lTipoPec, nTipoAutentica)
11: *   IF VARTYPE(loForm) = "O"
12: *       loForm.Show()
13: *   ENDIF
14: *
15: * Layout: form PLANO, sem PageFrame - o SCX legado nao tem PageFrame algum
16: * (cntSombra + Grd + TxtObs + botoes soltos direto na form). Ver padrao em
17: * Formale.prg/FormFpN.prg (dialogos OPERACIONAL planos).
18: *
19: * Fase 4/8 - Grid (Grd -> grd_4c_Dados, vinculado ao cursor local
20: * cursor_4c_Pagamentos, mesma estrutura de SigOpAutBO.this_cCursorPagamentos),
21: * os 3 botoes standalone do legado (Grade/Imprimir/Sair -> cmd_4c_Grade/
22: * cmd_4c_Fwbtnm1/cmd_4c_Sair) e a carga de dados (CarregarDados/VincularGrade,
23: * equivalentes ao bloco de consulta do Init legado). O legado NAO tem botoes
24: * CRUD (Incluir/Alterar/Excluir/Buscar) - este dialogo so marca linhas de
25: * pagamento/parcela para autenticar e imprime o comprovante.
26: *
27: * Fase 5/8 - Campo de observacao (Say6/TxtObs -> lbl_4c_Label6/txt_4c_TxtObs).
28: *
29: * Fase 6/8 - Controle OLE restante do dump (OleComm -> obj_4c_OleComm, porta
30: * serial da impressora de cheque/fiscal usada dentro de autentica()). SEM
31: * LOOKUPS: o form NAO tem nenhum CreateObject('fwbuscaext'/'fwBuscaSel'),
32: * sigacess() nem Seek em tabela auxiliar no codigo fonte original (SigOpAut e
33: * um dialogo modal de marcacao/autenticacao, nao um cadastro) - varredura
34: * integral de SigOpAut_form_codigo_fonte.txt confirma isso, entao esta
35: * fase nao tem nenhum AbrirLookupXxx/BtnXxxLookupKeyPress/DblClick.
36: *
37: * Fase 7/8 - Eventos principais dos 3 botoes standalone (BtnGradeClick/
38: * BtnImprimirClick/BtnSairClick, ligados por BINDEVENT em ConfigurarBotoes),
39: * Form.KeyPress (F2 -> Imprimir, F3 -> Grade) e o metodo Autentica() (envio
40: * do texto de autenticacao a impressora fiscal/cheque). Este dialogo NAO tem
41: * botoes CRUD (Incluir/Alterar/Visualizar/Excluir) - nenhum existe no
42: * legado, e nao ha o que mapear para eles; ver comentario acima (linhas
43: * 19-25) e tasks\task644\SigOpAut_form_codigo_fonte.txt. As chamadas de
44: * hardware que o legado faz via funcoes globais do Fortyus sem acervo
45: * (LeituraFab/fDecriptografar/ImpVerso/ReAutentica/Autentica-global) tem
46: * wrapper em utils\ (regra CLAUDE.md #13/#27); o ramo da impressora de
47: * CHEQUE (porta serial via obj_4c_OleComm) foi portado por completo, sem
48: * depender de nenhuma funcao externa.
49: *
50: * Fase 8/8 - Consolidacao: par FormParaBO/BOParaForm ligando a UNICA
51: * superficie editavel do legado (TxtObs -> SigOpAutBO.this_cObservacao, mais
52: * a linha corrente da grade via SigOpAutBO.CarregarDoCursor). Antes desta
53: * fase this_cObservacao estava declarada no BO e NUNCA era escrita nem lida:
54: * Autentica() lia THIS.txt_4c_TxtObs.Value direto, e o zeramento do campo no
55: * fim do Init escrevia no controle - duas fontes para o mesmo dado. Agora o
56: * BO eh a fonte unica nos dois sentidos.
57: *
58: * Os outros nomes canonicos de consolidacao do pipeline NAO se aplicam a este
59: * legado, e inventa-los violaria o PILAR 1 ("NUNCA inventar") ou produziria
60: * metodo vazio (proibido pela regra de completude). O SCX legado nao tem
61: * PageFrame, nao tem modo de edicao e tem exatamente 3 botoes (Grade/
62: * Imprimir/Encerrar); por isso os botoes CRUD (Incluir/Alterar/Visualizar/
63: * Excluir/Buscar) e o par Salvar/Cancelar da Page2 de Dados ficam fora do
64: * escopo desta tela. A grade EH carregada, so que pelo metodo unico
65: * CarregarDados() desta tela (que reproduz o bloco de consulta do Init
66: * legado e roda na abertura, nao atraves de um botao de busca separado).
67: * Tambem nao ha habilitar/limpar campos por modo, porque esta tela nao
68: * tem modo algum: o unico campo digitavel eh zerado por BOParaForm no
69: * fim do Init.
70: *==============================================================================
71: 
72: DEFINE CLASS FormSigOpAut AS FormBase
73: 
74:     *-- Propriedades visuais (PILAR 1: identico ao legado SigOpAut.SCX)
75:     Width        = 800
76:     Height       = 364
77:     AutoCenter   = .T.
78:     Caption      = "Autentica" + CHR(231) + CHR(227) + "o"

*-- Linhas 98 a 397:
98:     this_oModem = .NULL.
99: 
100:     *-- Parametros escalares equivalentes ao Init legado (repassados ao BO em
101:     *-- InicializarForm): _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica
102:     this_cEmps          = ""
103:     this_cDopes         = ""
104:     this_nNumes         = 0
105:     this_lTipoPec       = .F.
106:     this_nTipoAutentica = 0
107: 
108:     *--------------------------------------------------------------------------
109:     * Init - Recebe os mesmos parametros do Init legado (poform, _pEmps,
110:     * _pDopes, _pNumes, _pTipo, _pnAutentica). Armazena as referencias de UI
111:     * (ParentForm/oModem) e os escalares ANTES de DODEFAULT() - FormBase.Init()
112:     * chama InicializarForm(), que ja usa esses valores para criar o SigOpAutBO.
113:     *--------------------------------------------------------------------------
114:     PROCEDURE Init(par_oParentForm, par_cEmps, par_cDopes, par_nNumes, ;
115:             par_lTipoPec, par_nTipoAutentica)
116:         LOCAL loc_lSucesso
117: 
118:         IF VARTYPE(par_oParentForm) = "O"
119:             THIS.this_oParentForm = par_oParentForm
120:             IF PEMSTATUS(par_oParentForm, "oModemEest", 5)
121:                 THIS.this_oModem = par_oParentForm.oModemEest
122:             ENDIF
123:         ENDIF
124: 
125:         THIS.this_cEmps          = IIF(VARTYPE(par_cEmps) = "C", par_cEmps, "")
126:         THIS.this_cDopes         = IIF(VARTYPE(par_cDopes) = "C", par_cDopes, "")
127:         THIS.this_nNumes         = IIF(VARTYPE(par_nNumes) = "N", par_nNumes, 0)
128:         THIS.this_lTipoPec       = IIF(VARTYPE(par_lTipoPec) = "L", par_lTipoPec, .F.)
129:         THIS.this_nTipoAutentica = IIF(VARTYPE(par_nTipoAutentica) = "N", par_nTipoAutentica, 0)
130: 
131:         loc_lSucesso = DODEFAULT()
132: 
133:         RETURN loc_lSucesso
134:     ENDPROC
135: 
136:     *--------------------------------------------------------------------------
137:     * InicializarForm - Cria o Business Object com os escalares recebidos no
138:     * Init, monta a estrutura visual (cabecalho, grade, botoes) e faz a carga
139:     * da grade, na mesma ordem do Init legado.
140:     *--------------------------------------------------------------------------
141:     PROTECTED PROCEDURE InicializarForm()
142:         LOCAL loc_lSucesso, loc_oErro
143:         loc_lSucesso = .F.
144: 
145:         TRY
146:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpAutBO", ;
147:                 THIS.this_cEmps, THIS.this_cDopes, THIS.this_nNumes, ;
148:                 THIS.this_lTipoPec, THIS.this_nTipoAutentica)
149: 
150:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
151:                 THIS.ConfigurarPageFrame()
152:                 THIS.ConfigurarCabecalho()
153: 
154:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
155:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
156: 
157:                 *-- Grid e botoes criados DEPOIS do cabecalho: os botoes
158:                 *-- (Top=3..78) ficam DENTRO da faixa (Height=80) e precisam
159:                 *-- desenhar por cima dela (regra CLAUDE.md #11/#31).
160:                 THIS.ConfigurarGrid()
161:                 THIS.ConfigurarBotoes()
162:                 THIS.ConfigurarCampos()
163: 
164:                 THIS.TornarControlesVisiveis(THIS)
165: 
166:                 *-- Carga da grade por ULTIMO, com os controles ja visiveis -
167:                 *-- mesma posicao que o bloco de consulta ocupa no Init legado.
168:                 *-- Devolve .F. quando nao sobrou linha para autenticar, o que
169:                 *-- reproduz o "If Reccount() = 0 / ThisForm.Release /
170:                 *-- Return .F." do legado: InicializarForm .F. faz o
171:                 *-- CREATEOBJECT devolver .F. e a tela nao abre.
172:                 loc_lSucesso = THIS.CarregarDados()
173: 
174:                 *-- Regra de exibicao do campo Observacao: ULTIMO bloco do Init
175:                 *-- legado, logo depois do vinculo da grade. So faz sentido
176:                 *-- quando a tela vai mesmo abrir - com zero linha para
177:                 *-- autenticar o legado da Release e nunca chega aqui.
178:                 IF loc_lSucesso
179:                     THIS.AplicarRegraVisibilidadeObs()
180:                 ENDIF
181:             ELSE
182:                 MsgErro("Erro ao criar Business Object de Autentica" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
183:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
184:             ENDIF
185:         CATCH TO loc_oErro
186:             MsgErro(loc_oErro.Message + CHR(13) + ;
187:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
188:                 "Procedure: " + loc_oErro.Procedure, "Erro ao inicializar FormSigOpAut")
189:         ENDTRY
190: 
191:         RETURN loc_lSucesso
192:     ENDPROC
193: 
194:     *--------------------------------------------------------------------------
195:     * ConfigurarPageFrame - SigOpAut legado NAO TEM PageFrame: layout PLANO
196:     * com fundo new_background.jpg (Picture do dump), igual ao padrao de
197:     * dialogos OPERACIONAL pequenos sem abas (ver Formale.prg/FormFpN.prg).
198:     * Mantido so para configurar a aparencia base do form.
199:     *--------------------------------------------------------------------------
200:     PROTECTED PROCEDURE ConfigurarPageFrame()
201:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
202:         THIS.SetAll("FontName", "Tahoma")
203:         THIS.SetAll("FontSize", 8)
204:     ENDPROC
205: 
206:     *--------------------------------------------------------------------------
207:     * ConfigurarCabecalho - Container header cinza (cntSombra do legado)
208:     * Original: cntSombra Top=0, Left=0, Width=800, Height=80,
209:     * BackColor=100,100,100; lblSombra/lblTitulo Top=18/17, Left=10,
210:     * Width=769 (= THIS.Width - 21), ForeColor preto/branco, FontSize=18.
211:     *--------------------------------------------------------------------------
212:     PROTECTED PROCEDURE ConfigurarCabecalho()
213:         LOCAL loc_oErro
214:         TRY
215:             THIS.AddObject("cnt_4c_Cabecalho", "Container")
216:             WITH THIS.cnt_4c_Cabecalho
217:                 .Top         = 0
218:                 .Left        = 0
219:                 .Width       = THIS.Width
220:                 .Height      = 80
221:                 .BackStyle   = 1
222:                 .BackColor   = RGB(100, 100, 100)
223:                 .BorderWidth = 0
224:                 .Visible     = .T.
225:             ENDWITH
226: 
227:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
228:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
229:                 .FontBold      = .T.
230:                 .FontName      = "Tahoma"
231:                 .FontSize      = 18
232:                 .FontUnderline = .F.
233:                 .WordWrap      = .T.
234:                 .Alignment     = 0
235:                 .BackStyle     = 0
236:                 .AutoSize      = .F.
237:                 .Caption       = THIS.Caption
238:                 .Height        = 40
239:                 .Left          = 10
240:                 .Top           = 18
241:                 .Width         = THIS.Width - 21
242:                 .ForeColor     = RGB(0, 0, 0)
243:                 .Visible       = .T.
244:             ENDWITH
245: 
246:             THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
247:             WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
248:                 .FontBold      = .T.
249:                 .FontName      = "Tahoma"
250:                 .FontSize      = 18
251:                 .WordWrap      = .T.
252:                 .Alignment     = 0
253:                 .BackStyle     = 0
254:                 .AutoSize      = .F.
255:                 .Caption       = THIS.Caption
256:                 .Height        = 46
257:                 .Left          = 10
258:                 .Top           = 17
259:                 .Width         = THIS.Width - 21
260:                 .ForeColor     = RGB(255, 255, 255)
261:                 .ToolTipText   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio"
262:                 .Visible       = .T.
263:             ENDWITH
264:         CATCH TO loc_oErro
265:             MsgErro(loc_oErro.Message + CHR(13) + ;
266:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
267:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarCabecalho")
268:         ENDTRY
269:     ENDPROC
270: 
271:     *--------------------------------------------------------------------------
272:     * ConfigurarGrid - Grd legado (sem PageFrame, filho direto do form):
273:     * ColumnCount=3, Column1=Check1 (Marca), Column2/Column3=Text1 (Obs/Fpags),
274:     * os dois ultimos ReadOnly. Cria o cursor cursor_4c_Pagamentos com a MESMA
275:     * estrutura/ordem de campos de SigOpAutBO.this_cCursorPagamentos (regra
276:     * CLAUDE.md: CREATE CURSOR identico em todo lugar onde o mesmo alias
277:     * aparece) - equivale ao Load legado:
278:     *   Create Cursor csPgto (Marca L, Obs C(27), fpags C(12), Printed L,
279:     *                         Autenticas n(1))
280:     *
281:     * Aqui ficam SO as propriedades de desenho do Grd (as que nao dependem do
282:     * cursor). O vinculo (ColumnCount/RecordSource/ControlSource/Width/
283:     * CurrentControl) mora em VincularGrade(), porque tambem tem de rodar
284:     * DEPOIS de cada carga de dados.
285:     *--------------------------------------------------------------------------
286:     PROTECTED PROCEDURE ConfigurarGrid()
287:         LOCAL loc_oErro
288:         TRY
289:             IF !USED("cursor_4c_Pagamentos")
290:                 CREATE CURSOR cursor_4c_Pagamentos (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
291:             ENDIF
292: 
293:             THIS.AddObject("grd_4c_Dados", "Grid")
294:             WITH THIS.grd_4c_Dados
295:                 .Top               = 85
296:                 .Left              = 12
297:                 .Width             = 527
298:                 .Height            = 228
299:                 .TabIndex          = 1
300:                 .FontName          = "Tahoma"
301:                 .FontSize          = 8
302:                 .AllowHeaderSizing = .F.
303:                 .AllowRowSizing    = .F.
304:                 .DeleteMark        = .F.
305:                 .RecordMark        = .F.
306:                 .RowHeight         = 16
307:                 .ScrollBars        = 2
308:                 *-- O dump do SCX traz "SplitBar = .F.", mas Grid.SplitBar eh
309:                 *-- READ-ONLY em runtime (medido no VFP9: "Property SPLITBAR
310:                 *-- is read-only") - atribuir aborta o resto deste WITH dentro
311:                 *-- do TRY e as propriedades seguintes somem em silencio. O
312:                 *-- default ja eh .F. sem split, entao omitir eh fiel.
313:                 .Panel             = 1
314:                 .GridLineColor     = RGB(238, 238, 238)
315:                 *-- Grid.ReadOnly ANTES do ReadOnly de cada Column (regra
316:                 *-- CLAUDE.md #18/#46): o do Grid propaga e sobrescreve o das
317:                 *-- colunas. No legado so Column2/Column3 sao ReadOnly;
318:                 *-- Column1 (Marca) tem de aceitar o clique do usuario.
319:                 .ReadOnly          = .F.
320:                 .Visible           = .T.
321:             ENDWITH
322: 
323:             THIS.VincularGrade()
324:         CATCH TO loc_oErro
325:             MsgErro(loc_oErro.Message + CHR(13) + ;
326:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
327:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarGrid")
328:         ENDTRY
329:     ENDPROC
330: 
331:     *--------------------------------------------------------------------------
332:     * VincularGrade - (Re)vincula grd_4c_Dados ao cursor_4c_Pagamentos.
333:     * Legado (fim do Init):
334:     *   With ThisForm.Grd
335:     *       .RecordSource          = 'csPgto'
336:     *       .RecordSourceType      = 1
337:     *       .Column1.ControlSource = 'csPgto.marca'
338:     *       .Column2.ControlSource = 'csPgto.Obs'
339:     *       .Column3.ControlSource = 'csPgto.fPags'
340:     *       .Refresh
341:     *   EndWith
342:     *
343:     * PUBLIC e idempotente de proposito: SigOpAutBO.PopularCursorPagamentos()
344:     * faz USE IN + CREATE CURSOR no alias da grade, e derrubar o alias leva o
345:     * Grid a ColumnCount = 0 - retangulo branco sem cabecalho, sem erro e sem
346:     * log, morto pelo resto da vida do form. Por isso TODO caminho que popula
347:     * o cursor chama este metodo depois. O CheckBox da Column1 tambem eh
348:     * reinstalado aqui, porque reconstruir o ColumnCount cria objetos Column
349:     * novos (CurrentControl volta a "Text1").
350:     *
351:     * Ordem obrigatoria: ColumnCount -> RecordSource -> ControlSource ->
352:     * Width/Header (RecordSource recalcula as larguras para o default 90) e,
353:     * na Column1, AddObject -> propriedades do CheckBox -> CurrentControl ->
354:     * ControlSource por ULTIMO (ControlSource antes do AddObject dispara o
355:     * erro 1767).
356:     *--------------------------------------------------------------------------
357:     PROCEDURE VincularGrade()
358:         LOCAL loc_oErro, loc_oGrd, loc_lOk
359:         loc_lOk = .F.
360: 
361:         TRY
362:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5) AND USED("cursor_4c_Pagamentos")
363:                 loc_oGrd = THIS.grd_4c_Dados
364: 
365:                 *-- ColumnCount so eh reatribuido quando difere do esperado:
366:                 *-- REDUZIR destroi os controles postos por AddObject nas
367:                 *-- Columns (medido no VFP9); subir de 0 - que eh o estado
368:                 *-- depois do alias ser derrubado - eh justamente o caso que
369:                 *-- este metodo existe para consertar. Vem ANTES do
370:                 *-- RecordSource para o VFP nao auto-expandir a grade para as
371:                 *-- 5 colunas do cursor.
372:                 IF loc_oGrd.ColumnCount != 3
373:                     loc_oGrd.ColumnCount = 3
374:                 ENDIF
375: 
376:                 loc_oGrd.RecordSourceType = 1
377:                 loc_oGrd.RecordSource     = ""
378:                 loc_oGrd.ColumnCount = 3
379:                 loc_oGrd.RecordSource     = "cursor_4c_Pagamentos"
380: 
381:                 *-- Column1 - Check1 do legado (csPgto.marca), coluna de marcacao
382:                 loc_oGrd.Column1.FontSize  = 8
383:                 loc_oGrd.Column1.Movable   = .F.
384:                 loc_oGrd.Column1.Resizable = .F.
385:                 loc_oGrd.Column1.Alignment = 0
386:                 loc_oGrd.Column1.Enabled   = .T.
387:                 loc_oGrd.Column1.ReadOnly  = .F.
388:                 *-- Sparse = .F.: sem isto o CheckBox so desenha na linha
389:                 *-- corrente e as outras exibem 0/1 como texto, sem clique.
390:                 loc_oGrd.Column1.Sparse    = .F.
391: 
392:                 IF !PEMSTATUS(loc_oGrd.Column1, "chk_4c_Marca", 5)
393:                     loc_oGrd.Column1.AddObject("chk_4c_Marca", "CheckBox")
394:                 ENDIF
395: 
396:                 *-- Caption/Alignment/ReadOnly/Visible explicitos: CheckBox de
397:                 *-- Column renderiza mas NAO responde ao clique sem eles. Os

*-- Linhas 409 a 446:
409:                 loc_oGrd.Column1.chk_4c_Marca.Left      = 2
410:                 loc_oGrd.Column1.chk_4c_Marca.Height    = 17
411:                 loc_oGrd.Column1.chk_4c_Marca.Width     = 22
412: 
413:                 loc_oGrd.Column1.CurrentControl = "chk_4c_Marca"
414:                 loc_oGrd.Column1.ControlSource  = "cursor_4c_Pagamentos.Marca"
415: 
416:                 *-- Column2 - Text1 do legado (csPgto.Obs), ReadOnly/ColumnOrder=3
417:                 loc_oGrd.Column2.FontSize      = 8
418:                 loc_oGrd.Column2.Movable       = .F.
419:                 loc_oGrd.Column2.Resizable     = .F.
420:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Pagamentos.Obs"
421:                 loc_oGrd.Column2.ReadOnly      = .T.
422:                 loc_oGrd.Column2.Text1.FontSize    = 8
423:                 loc_oGrd.Column2.Text1.BorderStyle = 0
424:                 loc_oGrd.Column2.Text1.Margin      = 0
425:                 loc_oGrd.Column2.Text1.ReadOnly    = .T.
426:                 loc_oGrd.Column2.Text1.ForeColor   = RGB(0, 0, 0)
427:                 loc_oGrd.Column2.Text1.BackColor   = RGB(255, 255, 255)
428: 
429:                 *-- Column3 - Text1 do legado (csPgto.fPags), ReadOnly/ColumnOrder=2
430:                 loc_oGrd.Column3.FontSize      = 8
431:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Pagamentos.Fpags"
432:                 loc_oGrd.Column3.ReadOnly      = .T.
433:                 loc_oGrd.Column3.Text1.FontSize    = 8
434:                 loc_oGrd.Column3.Text1.BorderStyle = 0
435:                 loc_oGrd.Column3.Text1.Margin      = 0
436:                 loc_oGrd.Column3.Text1.ReadOnly    = .T.
437:                 loc_oGrd.Column3.Text1.ForeColor   = RGB(0, 0, 0)
438:                 loc_oGrd.Column3.Text1.BackColor   = RGB(255, 255, 255)
439: 
440:                 *-- Width/Header DEPOIS do RecordSource e dos ControlSource,
441:                 *-- senao o VFP devolve as larguras para o default 90
442:                 loc_oGrd.Column1.Width = 17
443:                 loc_oGrd.Column2.Width = 382
444:                 loc_oGrd.Column3.Width = 94
445: 
446:                 *-- Headers sem texto no legado (Caption = "", Alignment = 2)

*-- Linhas 460 a 834:
460:                 loc_oGrd.Column3.ColumnOrder = 2
461:                 loc_oGrd.Column2.ColumnOrder = 3
462: 
463:                 *-- Popular cursor NAO repinta a grade (regra CLAUDE.md #21):
464:                 *-- o legado fecha com Select csPgto / Go Top / .Refresh
465:                 SELECT cursor_4c_Pagamentos
466:                 GO TOP
467:                 loc_oGrd.Refresh()
468: 
469:                 *-- Os 4 handlers do CheckBox sao (re)ligados AQUI, e nao no
470:                 *-- InicializarForm: reconstruir o ColumnCount destroi os
471:                 *-- objetos Column e leva o chk_4c_Marca junto, e com ele os
472:                 *-- BINDEVENT. Ligados uma unica vez na inicializacao, o
473:                 *-- CheckBox ficaria inerte depois da primeira recarga.
474:                 THIS.LigarEventosGrade()
475: 
476:                 loc_lOk = .T.
477:             ENDIF
478:         CATCH TO loc_oErro
479:             MsgErro(loc_oErro.Message + CHR(13) + ;
480:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
481:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.VincularGrade")
482:             loc_lOk = .F.
483:         ENDTRY
484: 
485:         RETURN loc_lOk
486:     ENDPROC
487: 
488:     *--------------------------------------------------------------------------
489:     * LigarEventosGrade - Liga os 4 handlers do CheckBox da Column1.
490:     *
491:     * CheckBox de Column NAO alterna pelo binding nativo: ele renderiza, recebe
492:     * foco e ignora o clique. O legado tambem nao usa o toggle padrao - ele
493:     * escreve o valor por codigo no Click. Por isso os quatro eventos vao
494:     * juntos: KeyPress/MouseUp executam a marcacao, e Click/MouseDown existem
495:     * so para SUPRIMIR o toggle nativo com NODEFAULT (sem eles o valor alterna
496:     * duas vezes e volta ao que era).
497:     *
498:     * UNBINDEVENT antes de religar: VincularGrade eh idempotente e roda a cada
499:     * recarga do cursor; sem isso as ligacoes se ACUMULAM no mesmo objeto e um
500:     * unico clique dispararia o handler N vezes, alternando a marca N vezes.
501:     *
502:     * PEMSTATUS ANINHADO, nao com AND: VFP9 nao faz short-circuit, entao
503:     * "PEMSTATUS(THIS, 'grd_4c_Dados', 5) AND PEMSTATUS(THIS.grd_4c_Dados...)"
504:     * avaliaria o segundo lado mesmo sem a grade existir.
505:     *--------------------------------------------------------------------------
506:     PROTECTED PROCEDURE LigarEventosGrade()
507:         LOCAL loc_oChk, loc_oErro
508: 
509:         TRY
510:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
511:                 IF PEMSTATUS(THIS.grd_4c_Dados.Column1, "chk_4c_Marca", 5)
512:                     loc_oChk = THIS.grd_4c_Dados.Column1.chk_4c_Marca
513: 
514:                     UNBINDEVENT(loc_oChk)
515: 
516:                     BINDEVENT(loc_oChk, "KeyPress",  THIS, "ChkMarcaKeyPress")
517:                     BINDEVENT(loc_oChk, "MouseUp",   THIS, "ChkMarcaMouseUp")
518:                     BINDEVENT(loc_oChk, "MouseDown", THIS, "ChkMarcaMouseDown")
519:                     BINDEVENT(loc_oChk, "Click",     THIS, "ChkMarcaClick")
520:                 ENDIF
521:             ENDIF
522:         CATCH TO loc_oErro
523:             MsgErro(loc_oErro.Message + CHR(13) + ;
524:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
525:                 "Procedure: " + loc_oErro.Procedure, ;
526:                 "Erro em FormSigOpAut.LigarEventosGrade")
527:         ENDTRY
528:     ENDPROC
529: 
530:     *--------------------------------------------------------------------------
531:     * ValidarMarcacaoLinha - Regra de marcacao da linha corrente da grade.
532:     *
533:     * Legado (SIGOPAUT.Grd.Column1.Check1.Click), transcrito:
534:     *     if !(csPgto.printed)
535:     *         This.value = .t.
536:     *     endif
537:     *
538:     * O Click legado roda DEPOIS do toggle nativo do CheckBox (nao ha NoDefault
539:     * la), entao o efeito observavel eh:
540:     *   - linha ainda NAO autenticada (Printed = .F.) -> volta sempre para
541:     *     marcada; o usuario NAO consegue desmarcar o que ainda falta
542:     *     autenticar. Eh o par do guard do botao Encerrar, que recusa fechar a
543:     *     tela enquanto houver linha nao autenticada.
544:     *   - linha JA autenticada (Printed = .T.) -> o toggle vale, permitindo
545:     *     marcar de novo para reautenticar.
546:     * Aqui o toggle nativo foi suprimido (NODEFAULT nos handlers), entao ele eh
547:     * refeito explicitamente ANTES da regra - o resultado final eh identico.
548:     *
549:     * Marca e Printed sao LOGICOS no cursor (legado: "Create Cursor csPgto
550:     * (Marca L, Obs C(27), fpags C(12), Printed L, Autenticas n(1))"), por isso
551:     * a alternancia eh "!valor" e NAO o IIF(col = 0, 1, 0) usado quando a
552:     * coluna de marcacao eh numerica.
553:     *--------------------------------------------------------------------------
554:     PROCEDURE ValidarMarcacaoLinha()
555:         LOCAL loc_oErro
556: 
557:         TRY
558:             IF USED("cursor_4c_Pagamentos")
559:                 SELECT cursor_4c_Pagamentos
560:                 IF !EOF("cursor_4c_Pagamentos") AND !BOF("cursor_4c_Pagamentos")
561:                     REPLACE cursor_4c_Pagamentos.Marca ;
562:                         WITH !cursor_4c_Pagamentos.Marca
563: 
564:                     IF !cursor_4c_Pagamentos.Printed
565:                         REPLACE cursor_4c_Pagamentos.Marca WITH .T.
566:                     ENDIF
567: 
568:                     IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
569:                         THIS.grd_4c_Dados.Refresh()
570:                     ENDIF
571:                 ENDIF
572:             ENDIF
573:         CATCH TO loc_oErro
574:             MsgErro(loc_oErro.Message + CHR(13) + ;
575:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
576:                 "Procedure: " + loc_oErro.Procedure, ;
577:                 "Erro em FormSigOpAut.ValidarMarcacaoLinha")
578:         ENDTRY
579:     ENDPROC
580: 
581:     *--------------------------------------------------------------------------
582:     * ChkMarcaKeyPress - Espaco/Enter marcam a linha, igual ao clique.
583:     * Assinatura COMPLETA obrigatoria: handler ligado a KeyPress sem os dois
584:     * parametros estoura a cada tecla (regra CLAUDE.md #3).
585:     *--------------------------------------------------------------------------
586:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
587:         IF INLIST(par_nKeyCode, 13, 32)
588:             THIS.ValidarMarcacaoLinha()
589:             NODEFAULT
590:         ENDIF
591:     ENDPROC
592: 
593:     *--------------------------------------------------------------------------
594:     * ChkMarcaMouseUp - Clique do mouse: mesma acao da tecla.
595:     *--------------------------------------------------------------------------
596:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
597:         THIS.ValidarMarcacaoLinha()
598:         NODEFAULT
599:     ENDPROC
600: 
601:     *--------------------------------------------------------------------------
602:     * ChkMarcaMouseDown - Existe so para suprimir o toggle nativo do CheckBox.
603:     *--------------------------------------------------------------------------
604:     PROCEDURE ChkMarcaMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
605:         NODEFAULT
606:     ENDPROC
607: 
608:     *--------------------------------------------------------------------------
609:     * ChkMarcaClick - Existe so para suprimir o toggle nativo do CheckBox.
610:     *--------------------------------------------------------------------------
611:     PROCEDURE ChkMarcaClick()
612:         NODEFAULT
613:     ENDPROC
614: 
615:     *--------------------------------------------------------------------------
616:     * AplicarRegraVisibilidadeObs - Regra de exibicao do campo Observacao.
617:     *
618:     * Legado (ultimo bloco do Init, depois do vinculo da grade):
619:     *     If InList(CrSigFiFis.Imps,'BEMA8501','EPSON')
620:     *         .txtObs.Visible = .f.
621:     *     Else
622:     *         .txtObs.value = ""
623:     *         .Refresh
624:     *         .txtObs.SetFocus
625:     *     Endif
626:     *
627:     * Nessas duas impressoras a observacao nao vai para o papel, entao o campo
628:     * some. O legado esconde SOMENTE o TextBox e deixa o rotulo "Observacao" na
629:     * tela - transcrito como esta (PILAR 1), sem estender a regra ao Label.
630:     *
631:     * Em modo de teste/validacao de UI nao se consulta a configuracao fiscal
632:     * (ObterModeloImpressoraFiscal instancia o FisBO e le o SetFiscal.Ini) nem
633:     * se da SetFocus: a tela nao chega a ser exibida e SetFocus em form nao
634:     * ativo dispara erro. Sem modelo, cai no ramo ELSE - que eh o estado padrao
635:     * do campo, criado visivel e vazio em ConfigurarCampos.
636:     *--------------------------------------------------------------------------
637:     PROTECTED PROCEDURE AplicarRegraVisibilidadeObs()
638:         LOCAL loc_cModelo, loc_lInterativo, loc_oErro
639: 
640:         TRY
641:             IF PEMSTATUS(THIS, "txt_4c_TxtObs", 5)
642:                 loc_lInterativo = (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste) ;
643:                     AND (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
644: 
645:                 loc_cModelo = ""
646:                 IF loc_lInterativo
647:                     loc_cModelo = UPPER(ALLTRIM(THIS.ObterModeloImpressoraFiscal()))
648:                 ENDIF
649: 
650:                 IF INLIST(loc_cModelo, "BEMA8501", "EPSON")
651:                     THIS.txt_4c_TxtObs.Visible = .F.
652:                 ELSE
653:                     THIS.txt_4c_TxtObs.Visible = .T.
654: 
655:                     *-- Legado: ".txtObs.value = ''". Quem zera eh o BO (fonte
656:                     *-- unica do texto de observacao) e o form so reflete, via
657:                     *-- BOParaForm - o mesmo par usado em Autentica no sentido
658:                     *-- oposto.
659:                     IF VARTYPE(THIS.this_oBusinessObject) = "O"
660:                         THIS.this_oBusinessObject.this_cObservacao = ""
661:                         THIS.BOParaForm()
662:                     ELSE
663:                         THIS.txt_4c_TxtObs.Value = ""
664:                     ENDIF
665: 
666:                     THIS.Refresh()
667: 
668:                     IF loc_lInterativo
669:                         THIS.txt_4c_TxtObs.SetFocus()
670:                     ENDIF
671:                 ENDIF
672:             ENDIF
673:         CATCH TO loc_oErro
674:             MsgErro(loc_oErro.Message + CHR(13) + ;
675:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
676:                 "Procedure: " + loc_oErro.Procedure, ;
677:                 "Erro em FormSigOpAut.AplicarRegraVisibilidadeObs")
678:         ENDTRY
679:     ENDPROC
680: 
681:     *--------------------------------------------------------------------------
682:     * AplicarEstiloBotaoPadrao - Propriedades comuns aos 3 botoes standalone
683:     * (fwbtng/fwbtnm do legado, filhos diretos do form, fora de CommandGroup).
684:     * Themes=.T. + DisabledPicture (NUNCA Themes=.F. como nos Buttons(N) de
685:     * CommandGroup) para o icone renderizar - regra da memoria de botao
686:     * standalone com Picture.
687:     *--------------------------------------------------------------------------
688:     PROTECTED PROCEDURE AplicarEstiloBotaoPadrao(par_oBtn, par_cPicture)
689:         WITH par_oBtn
690:             .FontName         = "Comic Sans MS"
691:             .FontBold          = .T.
692:             .FontItalic        = .T.
693:             .FontSize          = 8
694:             .ForeColor         = RGB(90, 90, 90)
695:             .BackColor         = RGB(255, 255, 255)
696:             .SpecialEffect     = 0
697:             .PicturePosition   = 13
698:             .MousePointer      = 15
699:             .WordWrap          = .T.
700:             .AutoSize          = .F.
701:             .Picture           = gc_4c_CaminhoIcones + par_cPicture
702:             .DisabledPicture   = gc_4c_CaminhoIcones + par_cPicture
703:             .Themes            = .T.
704:             .Enabled           = .T.
705:             .Visible           = .T.
706:         ENDWITH
707:     ENDPROC
708: 
709:     *--------------------------------------------------------------------------
710:     * ConfigurarBotoes - 3 botoes standalone do legado (Top=3, Height=75,
711:     * Width=75, dentro da faixa do cabecalho - desenham por cima dela porque
712:     * sao criados DEPOIS). O legado NAO tem botoes CRUD: Grade foca a grade
713:     * (F3), Fwbtnm1 imprime/autentica (F2), Sair fecha o dialogo (Cancel=.T.).
714:     *--------------------------------------------------------------------------
715:     PROTECTED PROCEDURE ConfigurarBotoes()
716:         LOCAL loc_oErro
717:         TRY
718:             THIS.AddObject("cmd_4c_Grade", "CommandButton")
719:             WITH THIS.cmd_4c_Grade
720:                 .Top         = 3
721:                 .Left        = 573
722:                 .Width       = 75
723:                 .Height      = 75
724:                 .Caption     = "\<Grade"
725:                 .ToolTipText = "[F3] Grade"
726:             ENDWITH
727:             THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Grade, "geral_limpa_grade_60.jpg")
728: 
729:             THIS.AddObject("cmd_4c_Fwbtnm1", "CommandButton")
730:             WITH THIS.cmd_4c_Fwbtnm1
731:                 .Top     = 3
732:                 .Left    = 648
733:                 .Width   = 75
734:                 .Height  = 75
735:                 .Caption = "\<Imprimir"
736:             ENDWITH
737:             THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Fwbtnm1, "geral_impressora_normal_60.jpg")
738: 
739:             THIS.AddObject("cmd_4c_Sair", "CommandButton")
740:             WITH THIS.cmd_4c_Sair
741:                 .Top     = 3
742:                 .Left    = 723
743:                 .Width   = 75
744:                 .Height  = 75
745:                 .Cancel  = .T.
746:                 .Caption = "Encerrar"
747:             ENDWITH
748:             THIS.AplicarEstiloBotaoPadrao(THIS.cmd_4c_Sair, "cadastro_sair_60.jpg")
749: 
750:             *-- Botoes criados com AddObject (classe generica CommandButton,
751:             *-- sem subclasse): o Click so eh alcancado via BINDEVENT, em
752:             *-- metodos PUBLIC do form (regra CLAUDE.md #3/#8).
753:             BINDEVENT(THIS.cmd_4c_Grade,   "Click", THIS, "BtnGradeClick")
754:             BINDEVENT(THIS.cmd_4c_Fwbtnm1, "Click", THIS, "BtnImprimirClick")
755:             BINDEVENT(THIS.cmd_4c_Sair,    "Click", THIS, "BtnSairClick")
756:         CATCH TO loc_oErro
757:             MsgErro(loc_oErro.Message + CHR(13) + ;
758:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
759:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarBotoes")
760:         ENDTRY
761:     ENDPROC
762: 
763:     *--------------------------------------------------------------------------
764:     * ConfigurarCampos - Campo de observacao do legado (filho direto do form,
765:     * sem PageFrame): Say6 (label) + TxtObs (textbox), digitados pelo operador
766:     * e impressos no comprovante dentro de autentica() (Fase 7/8). Dump:
767:     *   Say6:   FontName=Tahoma, FontSize=8, Caption="Observacao", Left=12,
768:     *           Top=322, ForeColor=90,90,90 (classe say, sem Width/Alignment
769:     *           declarados - regra CLAUDE.md #23: AutoSize=.F. + Width que
770:     *           caiba o texto, Alignment=0)
771:     *   TxtObs: Left=12, Top=337, Width=430, Height=23, MaxLength=60
772:     *
773:     * O legado inicializa .txtObs.Value = "" e da SetFocus dentro do Init
774:     * (depois do bind da grade), e esconde o campo quando a impressora eh
775:     * BEMA8501/EPSON (If InList(CrSigFiFis.Imps,'BEMA8501','EPSON') / .txtObs.
776:     * Visible = .f.) - esse condicional pertence a CarregarDados/autentica
777:     * (Fase 7/8), que ja conhece o modelo da impressora fiscal via
778:     * ObterModeloImpressoraFiscal(). Aqui fica so a criacao do controle,
779:     * visivel por padrao.
780:     *
781:     * OleComm (Fase 6/8) - unico objeto do dump ainda sem equivalente no
782:     * migrado: controle OLE MSComm (porta serial), consumido dentro de
783:     * autentica() para falar com a impressora de cheque/Impressora Fiscal
784:     * (verso) quando o modelo NAO eh BEMA8501 (nesse ramo o legado cria o
785:     * proprio ThisForm.Parentform.oModemEest, que ja existe em
786:     * THIS.this_oModem). Dump: Top=91, Left=480, Width=100, Height=100, sem
787:     * Visible declarado (OLE control fica OCULTO - nao eh elemento de tela).
788:     * Mesmo padrao de obj_4c_OModem em FormSigReEch.prg: AddObject de
789:     * OLEControl TRAVA o VFP indefinidamente em ambiente sem o OCX
790:     * registrado/sem usuario, entao (a) nunca instanciar em modo teste/
791:     * validacao de UI e (b) envolver em TRY/CATCH proprio, sem abortar o
792:     * resto do form quando o MSComm nao estiver disponivel na maquina.
793:     *--------------------------------------------------------------------------
794:     PROTECTED PROCEDURE ConfigurarCampos()
795:         LOCAL loc_oErro, loc_oErroOle
796:         TRY
797:             THIS.AddObject("lbl_4c_Label6", "Label")
798:             WITH THIS.lbl_4c_Label6
799:                 .FontName  = "Tahoma"
800:                 .FontSize  = 8
801:                 .FontBold  = .F.
802:                 .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
803:                 .Left      = 12
804:                 .Top       = 322
805:                 .Width     = 100
806:                 .Height    = 17
807:                 .AutoSize  = .F.
808:                 .Alignment = 0
809:                 .BackStyle = 0
810:                 .ForeColor = RGB(90, 90, 90)
811:                 .TabIndex  = 5
812:                 .Visible   = .T.
813:             ENDWITH
814: 
815:             THIS.AddObject("txt_4c_TxtObs", "TextBox")
816:             WITH THIS.txt_4c_TxtObs
817:                 .Left      = 12
818:                 .Top       = 337
819:                 .Width     = 430
820:                 .Height    = 23
821:                 .MaxLength = 60
822:                 .TabIndex  = 6
823:                 .FontName  = "Tahoma"
824:                 .FontSize  = 8
825:                 .Value     = ""
826:                 .Visible   = .T.
827:             ENDWITH
828: 
829:             *-- OLE MSComm (porta serial) - nao instanciar em modo teste:
830:             *-- AddObject de OLEControl trava indefinidamente sem usuario.
831:             IF (TYPE("gb_4c_ModoTeste") != "L" OR !gb_4c_ModoTeste) AND ;
832:                     (TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI)
833:                 TRY
834:                     THIS.AddObject("obj_4c_OleComm", "OLEControl", "MSCommLib.MSComm")

*-- Linhas 847 a 1333:
847:         CATCH TO loc_oErro
848:             MsgErro(loc_oErro.Message + CHR(13) + ;
849:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
850:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.ConfigurarCampos")
851:         ENDTRY
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * CarregarDados - Carga da grade. Equivale ao bloco de consulta do Init
856:     * legado, transcrito do dump:
857:     *   =fLerFiscal() / Select CrSigFiFis / Goto top
858:     *   If Not _pTipo
859:     *       cursorquery('SigMvPar','CrTmpPar','EmpDopNums',lcEDN) + SigOpFp
860:     *   Else
861:     *       cursorquery('SigMvPec','CrTmpEstPe','EmpDopNums',lcEDN) + SigCdOpe
862:     *   EndIf
863:     *   If ( Alltrim(CrSigFiFis.Imps) = 'DARUMA' And _PnAutentica = 1 ) Or ;
864:     *      ( _PnAutentica <> 1 And Not ThisForm.ParentForm.TemAutentica )
865:     *       Zap
866:     *   EndIf
867:     *   Select csPgto / Go Top
868:     *   If Reccount() = 0 / ThisForm.Release / Return .F. / Endif
869:     *   With ThisForm / With .Grd / ... bind ... / EndWith / EndWith
870:     *
871:     * O SQL mora no BO (SigOpAutBO.PopularCursorPagamentos e
872:     * ZerarSeNaoRequerAutenticacao); no form ficam a leitura da configuracao
873:     * de hardware, a regra TemAutentica que vem do form pai, o revinculo da
874:     * grade e a decisao de nao abrir a tela.
875:     *
876:     * Retorna .F. quando nao sobrou linha alguma para autenticar: eh o
877:     * "ThisForm.Release + Return .F." do legado, propagado por InicializarForm
878:     * (CREATEOBJECT devolve .F. e a tela nao abre, sem mensagem - igual ao
879:     * legado, que fecha calado).
880:     *--------------------------------------------------------------------------
881:     PROCEDURE CarregarDados()
882:         LOCAL loc_oErro, loc_lOk, loc_oBO, loc_uTemAut
883:         loc_lOk = .F.
884: 
885:         TRY
886:             IF (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
887:                     (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
888:                 *-- Sem conexao SQL em modo de teste/validacao de UI: a grade
889:                 *-- fica com o cursor vazio criado em ConfigurarGrid e a tela
890:                 *-- abre normalmente - nao ha o que consultar.
891:                 THIS.VincularGrade()
892:                 loc_lOk = .T.
893:             ELSE
894:                 loc_oBO = THIS.this_oBusinessObject
895: 
896:                 IF VARTYPE(loc_oBO) = "O"
897:                     *-- Legado: ThisForm.ParentForm.TemAutentica, lido dentro do
898:                     *-- teste de Zap. VARTYPE antes de atribuir porque a
899:                     *-- property do form pai pode vir Logica ou Numerica
900:                     *-- (comparar tipos diferentes estoura type mismatch).
901:                     IF VARTYPE(THIS.this_oParentForm) = "O" ;
902:                             AND PEMSTATUS(THIS.this_oParentForm, "TemAutentica", 5)
903:                         loc_uTemAut = THIS.this_oParentForm.TemAutentica
904:                         IF VARTYPE(loc_uTemAut) = "L"
905:                             loc_oBO.this_lTemAutentica = loc_uTemAut
906:                         ENDIF
907:                         IF VARTYPE(loc_uTemAut) = "N"
908:                             loc_oBO.this_lTemAutentica = (loc_uTemAut != 0)
909:                         ENDIF
910:                     ENDIF
911: 
912:                     IF loc_oBO.PopularCursorPagamentos()
913:                         *-- Legado: Zap quando a impressora eh DARUMA com
914:                         *-- _PnAutentica = 1, ou quando o form pai nao exige
915:                         *-- autenticacao
916:                         loc_oBO.ZerarSeNaoRequerAutenticacao(THIS.ObterModeloImpressoraFiscal())
917: 
918:                         *-- PopularCursorPagamentos faz USE IN + CREATE CURSOR
919:                         *-- no alias da grade: sem revincular, o Grid fica em
920:                         *-- ColumnCount = 0 e vira um retangulo branco
921:                         THIS.VincularGrade()
922: 
923:                         *-- Legado: If Reccount() = 0 / ThisForm.Release / Return .F.
924:                         loc_lOk = (RECCOUNT("cursor_4c_Pagamentos") > 0)
925:                     ELSE
926:                         IF !EMPTY(loc_oBO.this_cMensagemErro)
927:                             MsgErro(loc_oBO.this_cMensagemErro, ;
928:                                 "Autentica" + CHR(231) + CHR(227) + "o")
929:                         ENDIF
930:                         loc_lOk = .F.
931:                     ENDIF
932:                 ENDIF
933:             ENDIF
934:         CATCH TO loc_oErro
935:             MsgErro(loc_oErro.Message + CHR(13) + ;
936:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
937:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.CarregarDados")
938:             loc_lOk = .F.
939:         ENDTRY
940: 
941:         RETURN loc_lOk
942:     ENDPROC
943: 
944:     *--------------------------------------------------------------------------
945:     * ObterModeloImpressoraFiscal - Legado (Init): "=fLerFiscal() / Select
946:     * CrSigFiFis / Goto top", consumido depois em Alltrim(CrSigFiFis.Imps).
947:     *
948:     * fLerFiscal() eh funcao global do Fortyus que NAO existe no acervo
949:     * portado - chama-la daria "File 'flerfiscal.prg' does not exist" em
950:     * runtime (nome desconhecido seguido de "(" nao eh erro de compilacao,
951:     * regra CLAUDE.md #13). O equivalente portado eh
952:     * FisBO.CarregarDeArquivo(), que le o mesmo SetFiscal.Ini e popula o mesmo
953:     * cursor CrSigFiFis; eh usado so quando o cursor ainda nao esta aberto,
954:     * para nao sobrescrever uma configuracao fiscal ja carregada por outra
955:     * tela.
956:     *
957:     * Modelo vazio apenas nao casa com o teste 'DARUMA' do legado - nao
958:     * impede autenticar.
959:     *--------------------------------------------------------------------------
960:     PROTECTED PROCEDURE ObterModeloImpressoraFiscal()
961:         LOCAL loc_cModelo, loc_oFis, loc_oErro
962:         loc_cModelo = ""
963: 
964:         TRY
965:             IF !USED("CrSigFiFis")
966:                 loc_oFis = CREATEOBJECT("FisBO")
967:                 IF VARTYPE(loc_oFis) = "O"
968:                     loc_oFis.CarregarDeArquivo()
969:                     loc_oFis = .NULL.
970:                 ENDIF
971:             ENDIF
972: 
973:             IF USED("CrSigFiFis")
974:                 SELECT CrSigFiFis
975:                 GO TOP
976:                 IF !EOF() AND VARTYPE(CrSigFiFis.Imps) = "C"
977:                     loc_cModelo = ALLTRIM(CrSigFiFis.Imps)
978:                 ENDIF
979:             ENDIF
980:         CATCH TO loc_oErro
981:             MsgAviso("N" + CHR(227) + "o foi poss" + CHR(237) + "vel ler a " + ;
982:                 "configura" + CHR(231) + CHR(227) + "o da impressora fiscal:" + ;
983:                 CHR(13) + loc_oErro.Message, ;
984:                 "Autentica" + CHR(231) + CHR(227) + "o")
985:             loc_cModelo = ""
986:         ENDTRY
987: 
988:         RETURN loc_cModelo
989:     ENDPROC
990:     *--------------------------------------------------------------------------
991:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
992:     * (AddObject cria com Visible=.F. por padrao). Itera Controls e, se algum
993:     * for PageFrame, tambem as Pages dele (este form nao tem PageFrame, mas o
994:     * metodo fica generico para reaproveitar nas fases seguintes).
995:     *
996:     * EXCECAO por NOME: obj_4c_OleComm (controle OLE MSComm) fica de fora -
997:     * o dump do SCX nao declara Visible para ele (eh um controle funcional de
998:     * porta serial, nunca um elemento de tela) e forcar .Visible = .T. criaria
999:     * uma caixa OLE 100x100 em branco sobre a grade (Top=91/Left=480 cai
1000:     * dentro da area do grd_4c_Dados). Mesmo padrao de exclusao por nome usado
1001:     * para containers flutuantes (regra CLAUDE.md de TornarControlesVisiveis).
1002:     *--------------------------------------------------------------------------
1003:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1004:         LOCAL loc_nI, loc_oControl, loc_nP, loc_lExcluido
1005: 
1006:         IF VARTYPE(par_oContainer) != "O"
1007:             RETURN
1008:         ENDIF
1009: 
1010:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1011:             loc_oControl = par_oContainer.Controls(loc_nI)
1012:             IF VARTYPE(loc_oControl) = "O"
1013:                 loc_lExcluido = INLIST(UPPER(loc_oControl.Name), "OBJ_4C_OLECOMM")
1014: 
1015:                 IF PEMSTATUS(loc_oControl, "Visible", 5) AND !loc_lExcluido
1016:                     loc_oControl.Visible = .T.
1017:                 ENDIF
1018: 
1019:                 IF !loc_lExcluido
1020:                     IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
1021:                         FOR loc_nP = 1 TO loc_oControl.PageCount
1022:                             THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
1023:                         ENDFOR
1024:                     ENDIF
1025: 
1026:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
1027:                         THIS.TornarControlesVisiveis(loc_oControl)
1028:                     ENDIF
1029:                 ENDIF
1030:             ENDIF
1031:         ENDFOR
1032:     ENDPROC
1033: 
1034:     *--------------------------------------------------------------------------
1035:     * KeyPress - Legado:
1036:     *   Case nKeyCode = -1 && F2 / NoDefault / ThisForm.Imprimir.Click()
1037:     *   Case nKeyCode = -2 && F3 / NoDefault / ThisForm.Grade.Click()
1038:     * KeyPreview = .T. (propriedade da classe) faz esses codigos de tecla
1039:     * chegarem aqui antes de qualquer controle filho.
1040:     *--------------------------------------------------------------------------
1041:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1042:         DO CASE
1043:             CASE par_nKeyCode = -1 && F2
1044:                 THIS.BtnImprimirClick()
1045:                 NODEFAULT
1046:             CASE par_nKeyCode = -2 && F3
1047:                 THIS.BtnGradeClick()
1048:                 NODEFAULT
1049:         ENDCASE
1050:     ENDPROC
1051: 
1052:     *--------------------------------------------------------------------------
1053:     * BtnGradeClick - cmd_4c_Grade.Click. Legado (Grade.Click):
1054:     *   Thisform.Grd.Column1.Setfocus
1055:     *--------------------------------------------------------------------------
1056:     PROCEDURE BtnGradeClick()
1057:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1058:             THIS.grd_4c_Dados.Column1.SetFocus()
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * BtnSairClick - cmd_4c_Sair.Click. Legado (Sair.Click):
1064:     *   Select csPgto / If Reccount() > 0 / Go top / Scan
1065:     *       if !(csPgto.Printed)
1066:     *           .Grd.Refresh / .Grd.Column1.SetFocus
1067:     *           MessageBox("Autenticacao Obrigatoria",16,"") / Return
1068:     *       endif
1069:     *   EndScan / EndIf
1070:     *   ldtime = DateTime() / Do While DateTime()-ldtime<=2 / =chrsaw(.5) / EndDo
1071:     *   ThisForm.Release
1072:     *
1073:     * ExisteLinhaNaoAutenticada() (BO) reproduz o Scan/Locate For !Printed.
1074:     * chrsaw(.5) em loop (funcao global do Fortyus nao portada - so dava
1075:     * tempo ao SO processar a tela) -> DOEVENTS no lugar, mesmo efeito
1076:     * pratico. MESSAGEBOX legado -> MsgAviso (regra CLAUDE.md "MESSAGEBOX
1077:     * PROIBIDO").
1078:     *--------------------------------------------------------------------------
1079:     PROCEDURE BtnSairClick()
1080:         LOCAL loc_tInicio
1081: 
1082:         IF VARTYPE(THIS.this_oBusinessObject) = "O" ;
1083:                 AND THIS.this_oBusinessObject.ExisteLinhaNaoAutenticada()
1084:             IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1085:                 THIS.grd_4c_Dados.Refresh()
1086:                 THIS.grd_4c_Dados.Column1.SetFocus()
1087:             ENDIF
1088:             MsgAviso("Autentica" + CHR(231) + CHR(227) + "o Obrigat" + CHR(243) + "ria", ;
1089:                 "Aten" + CHR(231) + CHR(227) + "o")
1090:             RETURN
1091:         ENDIF
1092: 
1093:         loc_tInicio = DATETIME()
1094:         DO WHILE DATETIME() - loc_tInicio <= 2
1095:             DOEVENTS
1096:         ENDDO
1097: 
1098:         THIS.Release()
1099:     ENDPROC
1100: 
1101:     *--------------------------------------------------------------------------
1102:     * BtnImprimirClick - cmd_4c_Fwbtnm1.Click. Legado (Fwbtnm1.Click):
1103:     *   Local lOk / lOk = .f.
1104:     *   if Reccount("csPgto") <=0
1105:     *       MessageBox("Nao existem observacoes a serem auteticadas",16,"")
1106:     *       ThisForm.Sair.Setfocus
1107:     *   Endif
1108:     *   Select csPgto / go Top / Scan
1109:     *       If csPgto.marca
1110:     *           lOk = ThisForm.Autentica(csPgto.Autenticas)
1111:     *           if lOk
1112:     *               Replace csPgto.marca with .f., csPgto.Printed with .t.
1113:     *           EndIf
1114:     *       EndIf
1115:     *   EndScan
1116:     *
1117:     * O legado NAO interrompe o fluxo quando o cursor esta vazio (apenas
1118:     * mostra o aviso e tenta focar Sair; o Scan seguinte nao executa nada
1119:     * num cursor vazio) - mesmo efeito reproduzido aqui.
1120:     *--------------------------------------------------------------------------
1121:     PROCEDURE BtnImprimirClick()
1122:         LOCAL loc_lOk, loc_oErro
1123: 
1124:         *-- Legado: "Local lOk / lOk = .f." - o valor so eh lido logo apos a
1125:         *-- atribuicao dentro do Scan, mas LOCAL sem inicializar nasce .F.
1126:         *-- (logico) no VFP e deixar implicito ja custou erro de tipo antes.
1127:         loc_lOk = .F.
1128: 
1129:         TRY
1130:             IF !USED("cursor_4c_Pagamentos") OR RECCOUNT("cursor_4c_Pagamentos") <= 0
1131:                 MsgAviso("N" + CHR(227) + "o existem observa" + CHR(231) + CHR(245) + "es a serem autenticadas", ;
1132:                     "Autentica" + CHR(231) + CHR(227) + "o")
1133:                 IF PEMSTATUS(THIS, "cmd_4c_Sair", 5)
1134:                     THIS.cmd_4c_Sair.SetFocus()
1135:                 ENDIF
1136:             ENDIF
1137: 
1138:             IF USED("cursor_4c_Pagamentos")
1139:                 SELECT cursor_4c_Pagamentos
1140:                 GO TOP
1141:                 SCAN
1142:                     IF cursor_4c_Pagamentos.Marca
1143:                         loc_lOk = THIS.Autentica(cursor_4c_Pagamentos.Autenticas)
1144:                         IF loc_lOk
1145:                             THIS.this_oBusinessObject.MarcarLinhaAutenticada()
1146:                         ENDIF
1147:                     ENDIF
1148:                 ENDSCAN
1149: 
1150:                 SELECT cursor_4c_Pagamentos
1151:                 GO TOP
1152:                 IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1153:                     THIS.grd_4c_Dados.Refresh()
1154:                 ENDIF
1155:             ENDIF
1156:         CATCH TO loc_oErro
1157:             MsgErro(loc_oErro.Message + CHR(13) + ;
1158:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1159:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.BtnImprimirClick")
1160:         ENDTRY
1161:     ENDPROC
1162: 
1163:     *--------------------------------------------------------------------------
1164:     * FormParaBO - Transferencia FORM -> BO.
1165:     *
1166:     * Este dialogo nao tem ficha de cadastro: a superficie editavel do legado
1167:     * eh UM campo (TxtObs) mais a coluna de marcacao da grade. Logo o par
1168:     * FormParaBO/BOParaForm aqui nao mapeia dezenas de campos - mapeia o que
1169:     * de fato existe:
1170:     *   - txt_4c_TxtObs -> this_cObservacao, o texto que autentica() imprime
1171:     *     junto do comprovante (legado: "_toPrint = padc(alltrim(ThisForm.
1172:     *     txtObs.Value),60," ")");
1173:     *   - a LINHA corrente da grade -> this_lLinhaMarca/this_cLinhaObs/
1174:     *     this_cLinhaFpags/this_lLinhaImpressa/this_nLinhaAutenticas, via
1175:     *     SigOpAutBO.CarregarDoCursor (o legado le csPgto.marca/.Autenticas
1176:     *     direto do cursor dentro do Scan do botao Imprimir).
1177:     *
1178:     * CarregarDoCursor NAO move o ponteiro (so SELECT + leitura dos campos),
1179:     * por isso FormParaBO pode ser chamado de DENTRO do SCAN de
1180:     * BtnImprimirClick sem quebrar a varredura.
1181:     *
1182:     * Retorna .F. quando o BO ainda nao existe - BtnImprimirClick e Autentica
1183:     * chamam este metodo e nao podem presumir sucesso.
1184:     *
1185:     * PROTECTED EXPLICITO, e nao por estilo: FormBase.prg declara
1186:     * "PROTECTED PROCEDURE FormParaBO" e o VFP9 NAO deixa a subclasse ALARGAR
1187:     * o escopo herdado - escrever "PROCEDURE FormParaBO" aqui deixaria o
1188:     * metodo protegido do mesmo jeito e mentiria para quem le. Consequencia
1189:     * pratica: so da para chama-lo por THIS. de dentro da classe; harness que
1190:     * precise exerce-lo tem de faze-lo por uma subclasse (ver
1191:     * automation\ProbeAut644F8.prg), nunca de um script solto - PEMSTATUS com
1192:     * o 3o argumento 5 responde "existe?", nao "da para chamar daqui?".
1193:     *--------------------------------------------------------------------------
1194:     PROTECTED PROCEDURE FormParaBO()
1195:         LOCAL loc_lOk, loc_oBO, loc_oErro
1196:         loc_lOk = .F.
1197: 
1198:         TRY
1199:             loc_oBO = THIS.this_oBusinessObject
1200: 
1201:             IF VARTYPE(loc_oBO) = "O"
1202:                 IF PEMSTATUS(THIS, "txt_4c_TxtObs", 5) ;
1203:                         AND VARTYPE(THIS.txt_4c_TxtObs.Value) = "C"
1204:                     loc_oBO.this_cObservacao = THIS.txt_4c_TxtObs.Value
1205:                 ELSE
1206:                     loc_oBO.this_cObservacao = ""
1207:                 ENDIF
1208: 
1209:                 IF USED("cursor_4c_Pagamentos")
1210:                     loc_oBO.CarregarDoCursor("cursor_4c_Pagamentos")
1211:                 ENDIF
1212: 
1213:                 loc_lOk = .T.
1214:             ENDIF
1215:         CATCH TO loc_oErro
1216:             MsgErro(loc_oErro.Message + CHR(13) + ;
1217:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1218:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.FormParaBO")
1219:             loc_lOk = .F.
1220:         ENDTRY
1221: 
1222:         RETURN loc_lOk
1223:     ENDPROC
1224: 
1225:     *--------------------------------------------------------------------------
1226:     * BOParaForm - Transferencia BO -> FORM, sentido inverso de FormParaBO.
1227:     *
1228:     * Espelha this_cObservacao no TextBox. Usado por
1229:     * AplicarRegraVisibilidadeObs para reproduzir o ".txtObs.value = ''" do
1230:     * fim do Init legado: quem zera eh o BO (fonte unica), o form so reflete.
1231:     *
1232:     * A grade NAO eh repintada a partir das properties this_*Linha*: elas sao
1233:     * uma FOTO da linha corrente (leitura), e quem desenha as linhas eh o
1234:     * ControlSource do Grid ligado ao proprio cursor. Reescrever o cursor a
1235:     * partir da foto sobrescreveria as outras linhas com a corrente.
1236:     *
1237:     * PROTECTED EXPLICITO pela mesma razao de FormParaBO acima (FormBase
1238:     * declara o nome como PROTECTED e o escopo herdado nao se alarga).
1239:     *--------------------------------------------------------------------------
1240:     PROTECTED PROCEDURE BOParaForm()
1241:         LOCAL loc_lOk, loc_oBO, loc_oErro
1242:         loc_lOk = .F.
1243: 
1244:         TRY
1245:             loc_oBO = THIS.this_oBusinessObject
1246: 
1247:             IF VARTYPE(loc_oBO) = "O"
1248:                 IF PEMSTATUS(THIS, "txt_4c_TxtObs", 5)
1249:                     THIS.txt_4c_TxtObs.Value = NVL(loc_oBO.this_cObservacao, "")
1250:                 ENDIF
1251:                 loc_lOk = .T.
1252:             ENDIF
1253:         CATCH TO loc_oErro
1254:             MsgErro(loc_oErro.Message + CHR(13) + ;
1255:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1256:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.BOParaForm")
1257:             loc_lOk = .F.
1258:         ENDTRY
1259: 
1260:         RETURN loc_lOk
1261:     ENDPROC
1262: 
1263:     *--------------------------------------------------------------------------
1264:     * Autentica - Envia o texto de autenticacao para a impressora fiscal
1265:     * (verso) ou para a impressora de cheque (porta serial OLE), conforme o
1266:     * modelo configurado e o tipo de autenticacao solicitado
1267:     * (par_nTipoAutentica - legado Lparameters _TpAutentica: 1 = Impressora
1268:     * Fiscal/Cheque via verso; outro valor = impressora fiscal "comum").
1269:     *
1270:     * Transcrito de SIGOPAUT.autentica
1271:     * (tasks\task644\SigOpAut_form_codigo_fonte.txt). _autVal vem de
1272:     * this_oBusinessObject.ObterTextoAutenticacao(); CrSigFiFis.Imps vem de
1273:     * THIS.ObterModeloImpressoraFiscal(). Aqui ficam so as chamadas de
1274:     * hardware que o legado faz via funcoes globais do Fortyus - LeituraFab/
1275:     * fDecriptografar/ImpVerso/ReAutentica/Autentica(global), SEM o acervo
1276:     * do protocolo proprietario da ECF (ver utils\leiturafab.prg e irmaos,
1277:     * regra CLAUDE.md #27). O ramo da impressora de CHEQUE (porta serial via
1278:     * obj_4c_OleComm) nao depende de nenhuma funcao externa e foi portado
1279:     * por completo, byte a byte igual ao legado.
1280:     *
1281:     * "Thisform.Primeiravez = .f." no legado roda ANTES de qualquer branch,
1282:     * o que faz "If Not Thisform.Primeiravez" dentro dos ramos ser SEMPRE
1283:     * verdadeiro (cai em ReAutentica, nunca no Autentica(global) do 1o
1284:     * disparo) - transcrito literalmente (regra CLAUDE.md #17: formula do
1285:     * legado nunca se reescreve, mesmo quando parece redundante).
1286:     *
1287:     * RetImpVer (loc_lRetImpVer) eh calculado mas NUNCA usado como retorno
1288:     * do metodo no legado - o "Return .t." final eh incondicional em todo
1289:     * caminho, exceto o "Return 0" dentro do ramo de impressora de cheque
1290:     * quando a configuracao de porta nao esta disponivel. Mesmo contrato
1291:     * aqui.
1292:     *--------------------------------------------------------------------------
1293:     PROTECTED PROCEDURE Autentica(par_nTipoAutentica)
1294:         LOCAL loc_oBO, loc_cAutVal, loc_cToPrintPad, loc_cToPrintCru, loc_cModelo
1295:         LOCAL loc_cNoFab, loc_cNoFabReal, loc_cModeloInterno, loc_lRetImpVer
1296:         LOCAL loc_uTemAut, loc_lTemAutentica, loc_lResultado, loc_oErro, loc_nImpCheqs
1297: 
1298:         loc_lResultado    = .T.
1299:         loc_lRetImpVer    = .T.
1300:         loc_lTemAutentica = .F.
1301: 
1302:         TRY
1303:             loc_oBO = THIS.this_oBusinessObject
1304: 
1305:             *-- Legado: "Thisform.Primeiravez = .f." roda ANTES de
1306:             *-- qualquer branch (ver nota acima)
1307:             loc_oBO.this_lPrimeiraVez = .F.
1308: 
1309:             *-- Legado: ThisForm.ParentForm.TemAutentica, lido fresco a
1310:             *-- cada chamada (nao reaproveita o snapshot de CarregarDados)
1311:             IF VARTYPE(THIS.this_oParentForm) = "O" ;
1312:                     AND PEMSTATUS(THIS.this_oParentForm, "TemAutentica", 5)
1313:                 loc_uTemAut = THIS.this_oParentForm.TemAutentica
1314:                 IF VARTYPE(loc_uTemAut) = "L"
1315:                     loc_lTemAutentica = loc_uTemAut
1316:                 ENDIF
1317:                 IF VARTYPE(loc_uTemAut) = "N"
1318:                     loc_lTemAutentica = (loc_uTemAut != 0)
1319:                 ENDIF
1320:             ENDIF
1321: 
1322:             loc_cAutVal = loc_oBO.ObterTextoAutenticacao()
1323: 
1324:             *-- Legado: "_toPrint = padc(alltrim(ThisForm.txtObs.Value),60," ")"
1325:             *-- lido FRESCO a cada chamada de autentica(). FormParaBO() eh a
1326:             *-- transferencia unica form -> BO (campo digitavel + linha corrente
1327:             *-- da grade), entao o texto sai de this_cObservacao e nao de uma
1328:             *-- segunda leitura do controle - fonte unica, mesmo instante de
1329:             *-- leitura do legado.
1330:             THIS.FormParaBO()
1331:             loc_cToPrintCru = loc_oBO.this_cObservacao
1332:             loc_cToPrintPad = PADC(ALLTRIM(loc_cToPrintCru), 60, " ")
1333:             loc_cModelo     = THIS.ObterModeloImpressoraFiscal()

*-- Linhas 1422 a 1448:
1422:         CATCH TO loc_oErro
1423:             MsgErro(loc_oErro.Message + CHR(13) + ;
1424:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1425:                 "Procedure: " + loc_oErro.Procedure, "Erro em FormSigOpAut.Autentica")
1426:             loc_lResultado = .F.
1427:         ENDTRY
1428: 
1429:         RETURN loc_lResultado
1430:     ENDPROC
1431: 
1432:     *--------------------------------------------------------------------------
1433:     * Destroy - Libera referencias de UI/BO. SigOpAut eh modal (WindowType=1)
1434:     * e o legado nao desabilita o ParentForm explicitamente no Init (o bloqueio
1435:     * de interacao vem do proprio modal do VFP), entao Destroy so limpa as
1436:     * referencias - nao ha Enabled a restaurar.
1437:     *--------------------------------------------------------------------------
1438:     PROCEDURE Destroy()
1439:         IF USED("cursor_4c_Pagamentos")
1440:             USE IN cursor_4c_Pagamentos
1441:         ENDIF
1442:         THIS.this_oParentForm     = .NULL.
1443:         THIS.this_oModem          = .NULL.
1444:         THIS.this_oBusinessObject = .NULL.
1445:         DODEFAULT()
1446:     ENDPROC
1447: 
1448: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigOpAutBO.prg):
*====================================================================
* SigOpAutBO.prg
*
* Business Object do dialogo OPERACIONAL "SIGOPAUT" (Autenticacao de
* comprovantes de pagamento/cheque na impressora fiscal ou na
* impressora de cheque via porta serial/OLE).
*
* O legado abre este form como filho MODAL de outro form (Lparameters
* poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica), monta um
* cursor LOCAL (csPgto: Marca L, Obs C(27), Fpags C(12), Printed L,
* Autenticas N(1)) a partir de SigMvPar (pagamentos) ou SigMvPec
* (parcelas), conforme _pTipo, e deixa o usuario marcar/autenticar
* cada linha antes de liberar o caixa.
*
* Nao existe uma unica tabela "mestre" - a origem dos dados depende do
* tipo de movimento (_pTipo): SigMvPar quando .F., SigMvPec quando .T.
* THIS.this_cTabela acompanha essa escolha (AtualizarTabelaOrigem).
*
* Referencias legado -> BO:
*   Thisform.toSeek       -> this_cToSeek      (EmpDopNums posicional)
*   Thisform.Primeiravez  -> this_lPrimeiraVez
*   Thisform.tpAutentica  -> this_nTipoAutentica (= Lparameters _pnAutentica)
*   csPgto (cursor local) -> this_cCursorPagamentos ("cursor_4c_Pagamentos")
*
* Thisform.oModem e Thisform.ParentForm permanecem no FORM (sao
* referencias a objetos de UI/OLE do form pai, fora da responsabilidade
* do Business Object).
*
* Herda de: BusinessBase
*
* Fase 2/8 - Nao ha INSERT/UPDATE/DELETE no legado deste dialogo: o unico
* codigo-fonte (Init/autentica/Sair.Click/Fwbtnm1.Click, ver
* tasks\task644\comportamento.json) so CONSULTA SigMvPar/SigMvPec/SigOpFp/
* SigCdOpe/SigMvCab (CursorQuery) e grava no CURSOR LOCAL csPgto (Replace
* marca/Printed) ou na porta serial/impressora fiscal (ImpVerso/Autentica/
* ReAutentica, via ThisForm.oModem) - nunca num INSERT/UPDATE em tabela.
* Por isso Inserir()/Atualizar()/ExecutarExclusao() permanecem SEM
* override: o comportamento padrao herdado de BusinessBase (recusar a
* operacao) ja eh o correto - inventar SQL de gravacao aqui violaria a
* regra de que a lista de colunas vem do schema/legado, nunca de
* suposicao, e este dialogo nunca grava em tabela nenhuma.
*
* Completado em: Fase 2 - PopularCursorPagamentos()/CarregarDoCursor()/
* ObterTextoAutenticacao()/ZerarSeNaoRequerAutenticacao()/
* ExisteLinhaNaoAutenticada()/MarcarLinhaAutenticada()/
* ObterChavePrimaria()
*====================================================================

DEFINE CLASS SigOpAutBO AS BusinessBase

    *-- Parametros recebidos na abertura do dialogo (legado: Lparameters
    *-- poform, _pEmps, _pDopes, _pNumes, _pTipo, _pnAutentica)
    this_cEmps             = ""    && Empresa (SigMvPar.emps / SigMvPec.emps)
    this_cDopes            = ""    && Documento de Operacao (SigCdOpe.dopes)
    this_nNumes            = 0     && Numero do movimento (SigMvPar.numes / SigMvPec.numes)
    this_lTipoPec          = .F.   && .T. = consulta SigMvPec (parcela) / .F. = consulta SigMvPar (pagamento) - legado "_pTipo"
    this_nTipoAutentica    = 0     && Tipo de autenticacao solicitada - legado "_pnAutentica"/"tpAutentica" (1 = impressora fiscal/cheque)

    *-- Estado de controle equivalente ao do form legado
    this_cToSeek           = ""    && Chave posicional EmpDopNums = PADR(Emps,3)+PADR(Dopes,20)+STR(Numes,6) - legado "toSeek"
    this_lPrimeiraVez      = .T.   && Controla a reautenticacao na 1a chamada a impressora fiscal - legado "Primeiravez"
    this_lTemAutentica     = .F.   && Espelha ParentForm.TemAutentica (config exige autenticar antes de liberar)
    this_cObservacao       = ""    && Texto digitado em TxtObs, impresso junto da autenticacao

    *-- Cursor de trabalho (equivalente ao csPgto local do legado:
    *-- Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))
    this_cCursorPagamentos = "cursor_4c_Pagamentos"
    this_nTotalPagamentos  = 0     && RECCOUNT() do cursor apos PopularCursorPagamentos()

    *-- Espelham a linha ATUAL de this_cCursorPagamentos (carregados por
    *-- CarregarDoCursor) - mesmos nomes/tipos das colunas do csPgto legado
    this_lLinhaMarca       = .F.   && Marca (L) - linha selecionada para autenticar
    this_cLinhaObs         = ""    && Obs (C(27)) - texto exibido na coluna 2 do Grd
    this_cLinhaFpags       = ""    && Fpags (C(12)) - forma de pagamento/codigo da parcela
    this_lLinhaImpressa    = .F.   && Printed (L) - .T. apos autenticar com sucesso
    this_nLinhaAutenticas  = 0     && Autenticas (N(1)) - tipo exigido por SigOpFp/SigCdOpe

    *-- Configuracao da porta serial da impressora de cheque (legado:
    *-- crTmpCfCom.Portas/Settings, lido de SigSyCom - ver
    *-- ObterConfigPortaCheque) - consumidos por FormSigOpAut.Autentica()
    this_nPortaCheque      = 0     && SigSyCom.Portas (WHERE Tipos = 'Impressora de Cheque')
    this_cSettingsCheque   = ""    && SigSyCom.Settings (mesma linha)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Parametros equivalentes ao Lparameters poform, _pEmps, _pDopes, _pNumes,
    * _pTipo, _pnAutentica do Init do form legado - o form migrado repassa so
    * os valores escalares; poform/oModem (objetos de UI) ficam no Form.
    *--------------------------------------------------------------------------
    PROCEDURE Init(par_cEmps, par_cDopes, par_nNumes, par_lTipoPec, par_nTipoAutentica)
        DODEFAULT("SigMvPar")

        THIS.this_cCampoChave = "cidchaves"

        IF VARTYPE(par_cEmps) = "C"
            THIS.this_cEmps = par_cEmps
        ENDIF

        IF VARTYPE(par_cDopes) = "C"
            THIS.this_cDopes = par_cDopes
        ENDIF

        IF VARTYPE(par_nNumes) = "N"
            THIS.this_nNumes = par_nNumes
        ENDIF

        IF VARTYPE(par_nTipoAutentica) = "N"
            THIS.this_nTipoAutentica = par_nTipoAutentica
        ENDIF

        THIS.this_lPrimeiraVez = .T.

        THIS.AtualizarTabelaOrigem(IIF(VARTYPE(par_lTipoPec) = "L", par_lTipoPec, .F.))
        THIS.AtualizarChaveBusca()

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarChaveBusca - Recalcula this_cToSeek (legado "toSeek") a partir
    * de Emps/Dopes/Numes. Chave POSICIONAL (regra CLAUDE.md #42): PADR
    * explicito em cada parte, NUNCA ALLTRIM - o padding faz parte da chave e
    * eh o que casa com a coluna EmpDopNums char(29) de SigMvPar/SigMvPec/
    * SigMvCab (emps char(3) + dopes char(20) + Str(numes,6) = 29).
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarChaveBusca()
        THIS.this_cToSeek = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
        RETURN THIS.this_cToSeek
    ENDPROC

    *--------------------------------------------------------------------------
    * AtualizarTabelaOrigem - Define a tabela de origem conforme o tipo de
    * movimento (legado SIGOPAUT.Init: "If Not _pTipo" consulta SigMvPar/
    * pagamentos; senao consulta SigMvPec/parcelas). A chave de filtro nos
    * dois casos eh EmpDopNums (this_cToSeek), a chave primaria eh cidchaves.
    *--------------------------------------------------------------------------
    PROCEDURE AtualizarTabelaOrigem(par_lTipoPec)
        IF VARTYPE(par_lTipoPec) != "L"
            RETURN .F.
        ENDIF

        THIS.this_lTipoPec = par_lTipoPec

        IF THIS.this_lTipoPec
            THIS.this_cTabela = "SigMvPec"
        ELSE
            THIS.this_cTabela = "SigMvPar"
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Este dialogo nao edita uma unica linha de uma
    * unica tabela (regra PROTECTED/BusinessBase #51): opera sobre VARIAS
    * linhas de SigMvPar/SigMvPec, todas sob o mesmo EmpDopNums. A chave
    * mais proxima de "registro em edicao" eh essa chave posicional - fica
    * disponivel so por completude de contrato (RegistrarAuditoria nunca eh
    * chamado, porque Inserir/Atualizar nao sao sobrescritos).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cToSeek)
    ENDPROC

    *--------------------------------------------------------------------------
    * PopularCursorPagamentos - Equivalente ao bloco de consulta do Init()
    * legado: (re)cria this_cCursorPagamentos (csPgto: Marca L, Obs C(27),
    * Fpags C(12), Printed L, Autenticas N(1)) e popula a partir de
    * SigMvPar (this_lTipoPec = .F.) ou SigMvPec (this_lTipoPec = .T.),
    * filtrando por EmpDopNums = this_cToSeek e por this_nTipoAutentica.
    *
    * Fica de fora (responsabilidade do FORM, que tem ParentForm/oModem):
    * - fLerFiscal()/CrSigFiFis (config de impressora fiscal - funcao
    *   global legado nao portada, ver ZerarSeNaoRequerAutenticacao abaixo)
    * - qualquer comunicacao com hardware (porta serial, impressora)
    *--------------------------------------------------------------------------
    FUNCTION PopularCursorPagamentos()
        LOCAL loc_lResultado, loc_nResultado, loc_nAutenticasFpg, loc_nAutenticasOpe
        LOCAL loc_cObs, loc_cFpags, loc_cCodigos10, loc_nDope, loc_nNume, loc_lPular
        loc_lResultado = .F.

        IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
            THIS.this_cMensagemErro = "Conex" + CHR(227) + "o com o banco de dados n" + CHR(227) + "o dispon" + CHR(237) + "vel"
            RETURN .F.
        ENDIF

        THIS.AtualizarChaveBusca()

        TRY
            IF USED(THIS.this_cCursorPagamentos)
                USE IN (THIS.this_cCursorPagamentos)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorPagamentos) (Marca L, Obs C(27), Fpags C(12), Printed L, Autenticas N(1))

            IF !THIS.this_lTipoPec

                *-- Legado: CursorQuery('SigMvPar','CrTmpPar','EmpDopNums',lcEDN)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Fpags, NCarnes, Outros " + ;
                    "FROM SigMvPar " + ;
                    "WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Par")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Par")
                    SELECT cursor_4c_SigOpAut_Par
                    SCAN
                        *-- Legado: CursorQuery('SigOpFp','CrTmpFpag','Fpags',CrTmpPar.Fpags)
                        *-- And InList(CrTmpFpag.Autenticas,1,3)
                        IF USED("cursor_4c_SigOpAut_Fpg")
                            USE IN cursor_4c_SigOpAut_Fpg
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT Autenticas FROM SigOpFp WHERE Fpags = " + EscaparSQL(ALLTRIM(cursor_4c_SigOpAut_Par.Fpags)), ;
                            "cursor_4c_SigOpAut_Fpg")

                        IF USED("cursor_4c_SigOpAut_Fpg") AND RECCOUNT("cursor_4c_SigOpAut_Fpg") > 0 ;
                                AND INLIST(cursor_4c_SigOpAut_Fpg.Autenticas, 1, 3)

                            loc_nAutenticasFpg = cursor_4c_SigOpAut_Fpg.Autenticas

                            *-- Legado: If _pnAutentica > 0 And _pnAutentica # m.Autenticas / Loop
                            IF THIS.this_nTipoAutentica <= 0 OR THIS.this_nTipoAutentica = loc_nAutenticasFpg
                                *-- Legado: Padr(Iif(!IsEmpty(NCarnes),'# '+Alltrim(NCarnes)+Iif(!IsEmpty(Outros),'; ',''),'')+Outros,40)
                                loc_cObs = PADR(IIF(!EMPTY(cursor_4c_SigOpAut_Par.NCarnes), ;
                                    "# " + ALLTRIM(cursor_4c_SigOpAut_Par.NCarnes) + ;
                                    IIF(!EMPTY(cursor_4c_SigOpAut_Par.Outros), "; ", ""), "") + ;
                                    cursor_4c_SigOpAut_Par.Outros, 40)

                                SELECT (THIS.this_cCursorPagamentos)
                                APPEND BLANK
                                REPLACE Marca WITH .T., ;
                                    Obs WITH loc_cObs, ;
                                    Fpags WITH cursor_4c_SigOpAut_Par.Fpags, ;
                                    Printed WITH .F., ;
                                    Autenticas WITH loc_nAutenticasFpg
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpAut_Par
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_SigOpAut_Fpg")
                    USE IN cursor_4c_SigOpAut_Fpg
                ENDIF
                IF USED("cursor_4c_SigOpAut_Par")
                    USE IN cursor_4c_SigOpAut_Par
                ENDIF

            ELSE

                *-- Legado: CursorQuery('SigCdOpe','CrTmpOpe','Dopes',_pDopes,[Autenticas])
                SQLEXEC(gnConnHandle, ;
                    "SELECT Autenticas FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)), ;
                    "cursor_4c_SigOpAut_Ope")
                loc_nAutenticasOpe = IIF(USED("cursor_4c_SigOpAut_Ope") AND RECCOUNT("cursor_4c_SigOpAut_Ope") > 0, ;
                    cursor_4c_SigOpAut_Ope.Autenticas, 0)

                *-- Legado: CursorQuery('SigMvPec','CrTmpEstPe','EmpDopNums',lcEDN)
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Codigos FROM SigMvPec WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Pec")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Pec")
                    SELECT cursor_4c_SigOpAut_Pec
                    SCAN
                        *-- Legado: _nDope = Val(Left(Str(Codigos,10),4)) / _nNume = Val(Right(Str(Codigos,10),6))
                        loc_cCodigos10 = cursor_4c_SigOpAut_Pec.Codigos
                        loc_nDope = VAL(LEFT(loc_cCodigos10, 4))
                        loc_nNume = VAL(RIGHT(loc_cCodigos10, 6))

                        *-- Legado: CursorQuery('SigCdOpe','CrTmpOpe2','ndopes',_ndope,[Dopes,CupFis])
                        IF USED("cursor_4c_SigOpAut_Ope2")
                            USE IN cursor_4c_SigOpAut_Ope2
                        ENDIF
                        SQLEXEC(gnConnHandle, ;
                            "SELECT Dopes, CupFis FROM SigCdOpe WHERE Ndopes = " + FormatarNumeroSQL(loc_nDope, 0), ;
                            "cursor_4c_SigOpAut_Ope2")

                        IF USED("cursor_4c_SigOpAut_Ope2") AND RECCOUNT("cursor_4c_SigOpAut_Ope2") > 0
                            loc_lPular = .F.

                            *-- Legado: If ( _pnAutentica>0 And _pnAutentica#m.Autenticas ) Or InList(CrTmpOpe2.CupFis,1,3) / Loop
                            IF THIS.this_nTipoAutentica > 0 AND THIS.this_nTipoAutentica != loc_nAutenticasOpe
                                loc_lPular = .T.
                            ENDIF
                            IF !loc_lPular AND INLIST(cursor_4c_SigOpAut_Ope2.CupFis, 1, 3)
                                loc_lPular = .T.
                            ENDIF

                            IF !loc_lPular
                                *-- Legado: m.Obs = CrTmpOpe2.dopes+' '+Str(_nNume,6) / m.Fpags = Str(CrTmpEstPe.Codigos)
                                loc_cObs   = ALLTRIM(cursor_4c_SigOpAut_Ope2.Dopes) + " " + STR(loc_nNume, 6)
                                loc_cFpags = STR(cursor_4c_SigOpAut_Pec.Codigos)

                                SELECT (THIS.this_cCursorPagamentos)
                                APPEND BLANK
                                REPLACE Marca WITH .T., ;
                                    Obs WITH loc_cObs, ;
                                    Fpags WITH loc_cFpags, ;
                                    Printed WITH .F., ;
                                    Autenticas WITH loc_nAutenticasOpe
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_SigOpAut_Pec
                    ENDSCAN
                ENDIF

                IF USED("cursor_4c_SigOpAut_Ope2")
                    USE IN cursor_4c_SigOpAut_Ope2
                ENDIF
                IF USED("cursor_4c_SigOpAut_Pec")
                    USE IN cursor_4c_SigOpAut_Pec
                ENDIF
                IF USED("cursor_4c_SigOpAut_Ope")
                    USE IN cursor_4c_SigOpAut_Ope
                ENDIF

            ENDIF

            SELECT (THIS.this_cCursorPagamentos)
            GO TOP
            THIS.this_nTotalPagamentos = RECCOUNT(THIS.this_cCursorPagamentos)
            loc_lResultado = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao buscar pagamentos/parcelas pendentes de autentica" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ZerarSeNaoRequerAutenticacao - Legado (Init, apos popular csPgto):
    *   If ( Alltrim(CrSigFiFis.Imps)='DARUMA' And _PnAutentica=1 ) Or
    *      (_PnAutentica<>1 And Not ThisForm.ParentForm.TemAutentica )
    *       Zap
    *   EndIf
    * CrSigFiFis.Imps (modelo da impressora fiscal) vem de fLerFiscal(),
    * funcao global do Fortyus NAO portada (config de hardware) - por isso
    * o modelo e o this_lTemAutentica (regra do form pai) sao recebidos
    * como parametro/property, em vez de consultados aqui.
    *--------------------------------------------------------------------------
    PROCEDURE ZerarSeNaoRequerAutenticacao(par_cModeloImpressora)
        LOCAL loc_lZerar
        loc_lZerar = .F.

        IF (UPPER(ALLTRIM(NVL(par_cModeloImpressora, ""))) = "DARUMA" AND THIS.this_nTipoAutentica = 1) ;
                OR (THIS.this_nTipoAutentica != 1 AND !THIS.this_lTemAutentica)
            loc_lZerar = .T.
        ENDIF

        IF loc_lZerar AND USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            ZAP
            THIS.this_nTotalPagamentos = 0
        ENDIF

        RETURN loc_lZerar
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega a LINHA ATUAL de this_cCursorPagamentos
    * (ou de outro alias/cursor com a mesma estrutura) para as properties
    * this_lLinha*/this_cLinha*/this_nLinha* (regra CLAUDE.md #9: SELECT
    * antes de acessar campo, nunca campo).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF !EMPTY(par_cAliasCursor) AND USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            IF !EOF()
                THIS.this_lLinhaMarca      = TratarNulo(Marca, .F.)
                THIS.this_cLinhaObs        = TratarNulo(Obs, "")
                THIS.this_cLinhaFpags      = TratarNulo(Fpags, "")
                THIS.this_lLinhaImpressa   = TratarNulo(Printed, .F.)
                THIS.this_nLinhaAutenticas = TratarNulo(Autenticas, 0)
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarLinhaAutenticada - Legado (Fwbtnm1.Click, apos Autentica() = .T.):
    *   Replace csPgto.marca with .f., csPgto.Printed with .t.
    * Opera sobre a linha ATUAL de this_cCursorPagamentos.
    *--------------------------------------------------------------------------
    PROCEDURE MarcarLinhaAutenticada()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            IF !EOF()
                REPLACE Marca WITH .F., Printed WITH .T.
                loc_lResultado = .T.
            ENDIF
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExisteLinhaNaoAutenticada - Legado (Sair.Click):
    *   Scan / if !(csPgto.Printed) / MessageBox('Autenticacao Obrigatoria') / Return
    * O form chama este metodo antes de liberar o Encerrar/Sair; a mensagem
    * (MsgAviso) e o foco na grade (Grd.Column1.SetFocus) ficam no FORM.
    *--------------------------------------------------------------------------
    FUNCTION ExisteLinhaNaoAutenticada()
        LOCAL loc_lPendente
        loc_lPendente = .F.

        IF USED(THIS.this_cCursorPagamentos)
            SELECT (THIS.this_cCursorPagamentos)
            LOCATE FOR !Printed
            loc_lPendente = FOUND()
        ENDIF

        RETURN loc_lPendente
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTextoAutenticacao - Parte SQL/texto do metodo "autentica" legado
    * (a comunicacao com a impressora/porta serial fica no FORM, que detem
    * ThisForm.oModem/OleComm):
    *   If CursorQuery('SigMvCab','CrTprMvCab','EmpDopNums',toSeek)
    *       _autVal = Padc(DTOC(Date())+"-"+Time()+" - "+Left(ecfs,3)+" - "+notas,60," ")
    *   Else
    *       _autVal = Padc(DTOC(Date())+"-"+Time(),60," ")
    *   EndIf
    *--------------------------------------------------------------------------
    FUNCTION ObterTextoAutenticacao()
        LOCAL loc_cTexto, loc_nResultado

        loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME(), 60, " ")

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0 AND !EMPTY(THIS.this_cToSeek)
            TRY
                IF USED("cursor_4c_SigOpAut_Cab")
                    USE IN cursor_4c_SigOpAut_Cab
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Ecfs, Notas FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(THIS.this_cToSeek), ;
                    "cursor_4c_SigOpAut_Cab")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Cab") AND RECCOUNT("cursor_4c_SigOpAut_Cab") > 0
                    loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME() + " - " + ;
                        LEFT(ALLTRIM(cursor_4c_SigOpAut_Cab.Ecfs), 3) + " - " + ;
                        ALLTRIM(cursor_4c_SigOpAut_Cab.Notas), 60, " ")
                ENDIF

                IF USED("cursor_4c_SigOpAut_Cab")
                    USE IN cursor_4c_SigOpAut_Cab
                ENDIF
            CATCH TO loc_oErro
                loc_cTexto = PADC(DTOC(DATE()) + "-" + TIME(), 60, " ")
            ENDTRY
        ENDIF

        RETURN loc_cTexto
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterTipoImpressaoCheque - Legado (autentica, ramo impressora de
    * cheque):
    *   =ThisForm.parentform.PodataMgr.CursorQuery('SigCdPam','CrTmpParam',.f.,.f.,[ImpCheqs])
    * SigCdPam eh tabela de parametros unica do sistema (1 so registro) -
    * sem filtro, le a unica linha.
    *--------------------------------------------------------------------------
    FUNCTION ObterTipoImpressaoCheque()
        LOCAL loc_nResultado, loc_nValor, loc_oErro
        loc_nValor = 0

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_Pam")
                    USE IN cursor_4c_SigOpAut_Pam
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, "SELECT ImpCheqs FROM SigCdPam", "cursor_4c_SigOpAut_Pam")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Pam") AND RECCOUNT("cursor_4c_SigOpAut_Pam") > 0
                    loc_nValor = NVL(cursor_4c_SigOpAut_Pam.ImpCheqs, 0)
                ENDIF

                IF USED("cursor_4c_SigOpAut_Pam")
                    USE IN cursor_4c_SigOpAut_Pam
                ENDIF
            CATCH TO loc_oErro
                loc_nValor = 0
            ENDTRY
        ENDIF

        RETURN loc_nValor
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterConfigPortaCheque - Legado:
    *   Select * From crSigSyCom Where Tipos = 'Impressora de Cheque' Into Cursor CrTmpCfCom
    * crSigSyCom vinha pre-carregado por fLerSettings() (funcao global do
    * Fortyus NAO portada - config de hardware); como SigSyCom tambem
    * existe como tabela do banco com as MESMAS colunas (Tipos/Portas/
    * Settings - ver docs/schema.sql), a consulta eh feita direto por
    * SQLEXEC, substituindo fLerSettings() + o filtro local em UM passo.
    *--------------------------------------------------------------------------
    FUNCTION ObterConfigPortaCheque()
        LOCAL loc_nResultado, loc_lResultado, loc_oErro
        loc_lResultado = .F.
        THIS.this_nPortaCheque    = 0
        THIS.this_cSettingsCheque = ""

        IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_Com")
                    USE IN cursor_4c_SigOpAut_Com
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT Portas, Settings FROM SigSyCom WHERE Tipos = " + EscaparSQL("Impressora de Cheque"), ;
                    "cursor_4c_SigOpAut_Com")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_Com") AND RECCOUNT("cursor_4c_SigOpAut_Com") > 0
                    SELECT cursor_4c_SigOpAut_Com
                    GO TOP
                    THIS.this_nPortaCheque    = NVL(Portas, 0)
                    THIS.this_cSettingsCheque = ALLTRIM(NVL(Settings, ""))
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_SigOpAut_Com")
                    USE IN cursor_4c_SigOpAut_Com
                ENDIF
            CATCH TO loc_oErro
                loc_lResultado = .F.
            ENDTRY
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterModeloInternoPorNumeroFabricacao - Legado:
    *   ThisForm.ParentForm.poDataMgr.SqlExecute([Select cModelos From
    *       SigFiMpF Where cImpFabs = '] + fDecriptografar(lcNoSerie) + ['], [crTmpImpF])
    *   lcModelo = crTmpImpF.cModelos
    * Quando o numero de fabricacao nao identifica nenhuma impressora
    * (leitura/decriptacao de hardware indisponivel neste acervo - ver
    * utils\leiturafab.prg/fdecriptografar.prg), o legado cai em
    * Space(10), que nunca casa com 'MP-7000 TH FI' - mesmo default aqui.
    *--------------------------------------------------------------------------
    FUNCTION ObterModeloInternoPorNumeroFabricacao(par_cNoFabReal)
        LOCAL loc_cModelo, loc_nResultado, loc_oErro
        loc_cModelo = SPACE(10)

        IF !EMPTY(par_cNoFabReal) AND TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
            TRY
                IF USED("cursor_4c_SigOpAut_MpF")
                    USE IN cursor_4c_SigOpAut_MpF
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, ;
                    "SELECT cModelos FROM SigFiMpF WHERE cImpFabs = " + EscaparSQL(ALLTRIM(par_cNoFabReal)), ;
                    "cursor_4c_SigOpAut_MpF")

                IF loc_nResultado >= 0 AND USED("cursor_4c_SigOpAut_MpF") AND RECCOUNT("cursor_4c_SigOpAut_MpF") > 0
                    loc_cModelo = NVL(cursor_4c_SigOpAut_MpF.cModelos, SPACE(10))
                ENDIF

                IF USED("cursor_4c_SigOpAut_MpF")
                    USE IN cursor_4c_SigOpAut_MpF
                ENDIF
            CATCH TO loc_oErro
                loc_cModelo = SPACE(10)
            ENDTRY
        ENDIF

        RETURN loc_cModelo
    ENDFUNC

ENDDEFINE

