# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (27)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_CONTAINER3, CNT_4C_CONTAINER2, CNT_4C_CONTAINER4, CNT_4C_CONTAINER5. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [METODO-INEXISTENTE] Metodo 'THIS.Controls()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container3.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container3.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container3.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container2.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container1.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container4.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource).
- [GRID-WITH] Bloco WITH THIS.cnt_4c_Container5.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource).
- [GRID-HEADER] Header Caption 'Produto2' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Prioridade, Disponível, Utilizar, Produto, Cor, Tam, Disponivel, Descrição, Uni, Qtde, Linha, Quantidade, Estoque, Produzir, Obs, Movimentação, Código, Atual, Utilizado, Emp. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Container5' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container5' Top=10 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container5' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container5' Left=284 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container2' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container2' Top=10 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container2' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container2' Left=284 (diff=272px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container4' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container4' Top=8 (diff=117px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container4' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container4' Left=229 (diff=217px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRGLP): Top original=125 vs migrado 'cnt_4c_Container1' Top=10 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container1' (parent: SIGPRGLP): Left original=12 vs migrado 'cnt_4c_Container1' Left=259 (diff=247px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Container3' (parent: SIGPRGLP): Top original=373 vs migrado 'cnt_4c_Container3' Top=5 (diff=368px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLP.Container3): Top original=173 vs migrado 'txt_4c_Tot_Qtd' Top=349 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Qtd' (parent: SIGPRGLP.Container3): Left original=188 vs migrado 'txt_4c_Tot_Qtd' Left=417 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLP.Container3): Top original=173 vs migrado 'txt_4c_Tot_Est' Top=349 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Est' (parent: SIGPRGLP.Container3): Left original=269 vs migrado 'txt_4c_Tot_Est' Left=498 (diff=229px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLP.Container3): Top original=173 vs migrado 'txt_4c_Tot_Prz' Top=349 (diff=176px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Tot_Prz' (parent: SIGPRGLP.Container3): Left original=350 vs migrado 'txt_4c_Tot_Prz' Left=580 (diff=230px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGlp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2847 linhas total):

*-- Linhas 10 a 421:
10: *   CODE -> arquitetura em camadas (FormBase / SigPrGlpBO)
11: *
12: * CHAMADA:
13: *   loForm = CREATEOBJECT("FormSigPrGlp", loFormPai, dData, lReserva, nEmphPdr, lAutom, nNumeroOp)
14: *   loForm.Show()
15: *==============================================================================*
16: 
17: DEFINE CLASS FormSigPrGlp AS FormBase
18: 
19:     *-- Dimensoes identicas ao legado
20:     Height       = 600
21:     Width        = 1000
22:     BorderStyle  = 2
23:     AutoCenter   = .T.
24:     TitleBar     = 0
25:     ShowWindow = 1
26:     WindowType = 1
27:     ControlBox   = .F.
28:     Closable     = .F.
29:     MaxButton    = .F.
30:     MinButton    = .F.
31:     ClipControls = .F.
32:     DataSession  = 2
33:     WindowState  = 0
34:     KeyPreview   = .T.
35:     ShowTips     = .T.
36: 
37:     *-- Referencia ao form pai (datasession compartilhada)
38:     poFormPai        = .NULL.
39:     *-- Flags operacionais
40:     this_lReserva    = .F.
41:     this_lAutomatico = .F.
42:     this_nNumeroDaOp = 0
43:     this_nEmphPdr    = 0
44:     this_dData       = {}
45:     *-- Controle de edicao na coluna Produzir
46:     this_nOldValue   = 0
47: 
48:     *==========================================================================
49:     PROCEDURE Init
50:     *==========================================================================
51:         LPARAMETERS par_loFormPai, par_dData, par_lReservaAuto, par_nEmphPdr, par_lAutom, par_nNumeroOp
52: 
53:         IF VARTYPE(par_loFormPai) = "O"
54:             THIS.poFormPai     = par_loFormPai
55:             THIS.DataSessionId = par_loFormPai.DataSessionId
56:         ENDIF
57: 
58:         THIS.this_lReserva    = IIF(VARTYPE(par_lReservaAuto)="L", par_lReservaAuto, .F.)
59:         THIS.this_nEmphPdr    = IIF(VARTYPE(par_nEmphPdr)="N",    par_nEmphPdr,    0)
60:         THIS.this_lAutomatico = IIF(VARTYPE(par_lAutom)="L",      par_lAutom,      .F.)
61:         THIS.this_nNumeroDaOp = IIF(VARTYPE(par_nNumeroOp)="N",   par_nNumeroOp,   0)
62:         THIS.this_dData       = IIF(VARTYPE(par_dData)="D",       par_dData,       DATE())
63: 
64:         RETURN DODEFAULT()
65:     ENDPROC
66: 
67:     *==========================================================================
68:     PROTECTED PROCEDURE InicializarForm
69:     *==========================================================================
70:         LOCAL loc_lSucesso, loc_nSal, loc_nEst, loc_nPrz
71:         loc_lSucesso = .F.
72:         loc_nSal     = 0
73:         loc_nEst     = 0
74:         loc_nPrz     = 0
75: 
76:         TRY
77:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrGlpBO")
78:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
79:                 MsgErro("Falha ao criar SigPrGlpBO", "Erro")
80:             ELSE
81:                 WITH THIS.this_oBusinessObject
82:                     .this_lReserva    = THIS.this_lReserva
83:                     .this_lAutomatico = THIS.this_lAutomatico
84:                     .this_nNumeroDaOp = THIS.this_nNumeroDaOp
85:                     .this_nEmphPdr    = THIS.this_nEmphPdr
86:                     .this_dData       = THIS.this_dData
87:                     IF USED("CrSigCdPac")
88:                         SELECT CrSigCdPac
89:                         .this_cSigKey = TratarNulo(CrSigCdPac.sigKeys, "C")
90:                     ENDIF
91:                 ENDWITH
92: 
93:                 IF THIS.this_lReserva
94:                     THIS.Caption = "Pr" + CHR(233) + "via da Reserva Autom" + CHR(225) + "tica"
95:                 ELSE
96:                     THIS.Caption = "Pr" + CHR(233) + "via da Globaliza" + CHR(231) + CHR(227) + "o"
97:                 ENDIF
98: 
99:                 THIS.ConfigurarPageFrame()
100:                 THIS.ConfigurarCabecalho()
101:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
102:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
103: 
104:                 THIS.this_oBusinessObject.InicializarConexaoTemp()
105:                 THIS.this_oBusinessObject.CarregarParametros()
106:                 THIS.this_oBusinessObject.CarregarComposicao()
107:                 THIS.this_oBusinessObject.InicializarTmpSaldU()
108: 
109:                 IF USED("SelPedra")
110:                     SELECT SelPedra
111:                     IF RECCOUNT() = 0
112:                         APPEND BLANK
113:                     ENDIF
114:                 ENDIF
115: 
116:                 THIS.ConfigurarLayout()
117:                 THIS.CarregarDados()
118:                 THIS.TornarControlesVisiveis()
119: 
120:                 *-- Estado inicial do botao Pedras
121:                 THIS.cmd_4c_Pedras.Enabled = .F.
122:                 IF USED("crSigCdPam")
123:                     SELECT crSigCdPam
124:                     IF !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
125:                        !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
126:                        !THIS.this_lReserva
127:                         THIS.cmd_4c_Pedras.Enabled = .T.
128:                     ENDIF
129:                 ENDIF
130: 
131:                 IF USED("TmpFinal")
132:                     SELECT TmpFinal
133:                     SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
134:                     GO TOP
135:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
136:                     THIS.txt_4c_Tot_Est.Value = loc_nEst
137:                     THIS.txt_4c_Tot_Prz.Value = loc_nPrz
138:                 ENDIF
139: 
140:                 THIS.Refresh
141:                 loc_lSucesso = .T.
142:             ENDIF
143:         CATCH TO loc_oErro
144:             MsgErro("Erro ao inicializar FormSigPrGlp: " + loc_oErro.Message + ;
145:                     " Ln=" + TRANSFORM(loc_oErro.LineNo) + ;
146:                     " Proc=" + loc_oErro.Procedure, "Erro")
147:         ENDTRY
148: 
149:         RETURN loc_lSucesso
150:     ENDPROC
151: 
152:     *==========================================================================
153:     PROTECTED PROCEDURE ConfigurarPageFrame
154:     *==========================================================================
155:         LOCAL loc_cImg
156:         loc_cImg = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
157:         IF FILE(loc_cImg)
158:             THIS.Picture = loc_cImg
159:         ENDIF
160:     ENDPROC
161: 
162:     *==========================================================================
163:     PROTECTED PROCEDURE ConfigurarCabecalho
164:     *==========================================================================
165:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
166:         WITH THIS.cnt_4c_Cabecalho
167:             .Top         = 0
168:             .Left        = 0
169:             .Width       = THIS.Width
170:             .Height      = 80
171:             .BackStyle   = 1
172:             .BackColor   = RGB(100, 100, 100)
173:             .BorderWidth = 0
174: 
175:             .AddObject("lbl_4c_Sombra", "Label")
176:             WITH .lbl_4c_Sombra
177:                 .AutoSize  = .F.
178:                 .Top       = 18
179:                 .Left      = 10
180:                 .Width     = THIS.Width
181:                 .Height    = 40
182:                 .FontBold  = .T.
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 18
185:                 .BackStyle = 0
186:                 .ForeColor = RGB(0, 0, 0)
187:                 .Caption   = " "
188:             ENDWITH
189: 
190:             .AddObject("lbl_4c_Titulo", "Label")
191:             WITH .lbl_4c_Titulo
192:                 .AutoSize  = .F.
193:                 .Top       = 17
194:                 .Left      = 10
195:                 .Width     = THIS.Width
196:                 .Height    = 46
197:                 .FontBold  = .T.
198:                 .FontName  = "Tahoma"
199:                 .FontSize  = 18
200:                 .BackStyle = 0
201:                 .ForeColor = RGB(255, 255, 255)
202:                 .Caption   = " "
203:             ENDWITH
204:         ENDWITH
205:     ENDPROC
206: 
207:     *==========================================================================
208:     PROTECTED PROCEDURE ConfigurarLayout
209:     *==========================================================================
210:         LOCAL loc_cImgProcessar, loc_cImgCancelar, loc_cImgRelatorio
211:         LOCAL loc_cImgDisp, loc_cImgLinhas, loc_cImgPedras, loc_cImgEstoque
212: 
213:         loc_cImgProcessar  = gc_4c_CaminhoIcones + "geral_executar_60.jpg"
214:         loc_cImgCancelar   = gc_4c_CaminhoIcones + "cadastro_encerrar_60.jpg"
215:         loc_cImgRelatorio  = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
216:         loc_cImgDisp       = gc_4c_CaminhoIcones + "geral_pesquisar_60.jpg"
217:         loc_cImgLinhas     = gc_4c_CaminhoIcones + "geral_lista_60.jpg"
218:         loc_cImgPedras     = gc_4c_CaminhoIcones + "geral_adicionar_60.jpg"
219:         loc_cImgEstoque    = gc_4c_CaminhoIcones + "geral_estoque_60.jpg"
220: 
221:         *-- Botao Disponiveis (622,3,75,75)
222:         THIS.AddObject("cmd_4c_Disponivel", "CommandButton")
223:         WITH THIS.cmd_4c_Disponivel
224:             .Top         = 3
225:             .Left        = 622
226:             .Width       = 75
227:             .Height      = 75
228:             .Caption     = "\<Dispon" + CHR(237) + "veis"
229:             .FontBold    = .T.
230:             .FontItalic  = .T.
231:             .FontName    = "Comic Sans MS"
232:             .FontSize    = 8
233:             .WordWrap    = .T.
234:             .ForeColor   = RGB(90, 90, 90)
235:             .BackColor   = RGB(255, 255, 255)
236:             .Themes      = .T.
237:             IF FILE(loc_cImgDisp)
238:                 .Picture         = loc_cImgDisp
239:                 .DisabledPicture = loc_cImgDisp
240:             ENDIF
241:         ENDWITH
242:         BINDEVENT(THIS.cmd_4c_Disponivel, "Click", THIS, "BtnDisponiveiClick")
243: 
244:         *-- Botao Total/Linhas (697,3,75,75)
245:         THIS.AddObject("cmd_4c_TotLinha", "CommandButton")
246:         WITH THIS.cmd_4c_TotLinha
247:             .Top         = 3
248:             .Left        = 697
249:             .Width       = 75
250:             .Height      = 75
251:             .Caption     = "\<Total/Linhas"
252:             .FontBold    = .T.
253:             .FontItalic  = .T.
254:             .FontName    = "Comic Sans MS"
255:             .FontSize    = 8
256:             .WordWrap    = .T.
257:             .ForeColor   = RGB(90, 90, 90)
258:             .BackColor   = RGB(255, 255, 255)
259:             .Themes      = .T.
260:             IF FILE(loc_cImgLinhas)
261:                 .Picture         = loc_cImgLinhas
262:                 .DisabledPicture = loc_cImgLinhas
263:             ENDIF
264:         ENDWITH
265:         BINDEVENT(THIS.cmd_4c_TotLinha, "Click", THIS, "BtnTotLinhaClick")
266: 
267:         *-- Botao Pedras/Requisicoes (472,3,75,75)
268:         THIS.AddObject("cmd_4c_Pedras", "CommandButton")
269:         WITH THIS.cmd_4c_Pedras
270:             .Top         = 3
271:             .Left        = 472
272:             .Width       = 75
273:             .Height      = 75
274:             .Caption     = "\<Requisi" + CHR(231) + CHR(245) + "es"
275:             .FontBold    = .T.
276:             .FontItalic  = .T.
277:             .FontName    = "Comic Sans MS"
278:             .FontSize    = 8
279:             .WordWrap    = .T.
280:             .ForeColor   = RGB(90, 90, 90)
281:             .BackColor   = RGB(255, 255, 255)
282:             .Themes      = .T.
283:             IF FILE(loc_cImgPedras)
284:                 .Picture         = loc_cImgPedras
285:                 .DisabledPicture = loc_cImgPedras
286:             ENDIF
287:         ENDWITH
288:         BINDEVENT(THIS.cmd_4c_Pedras, "Click", THIS, "BtnPedrasClick")
289: 
290:         *-- Botao SelEstoque (547,3,75,75)
291:         THIS.AddObject("cmd_4c_SelEstoque", "CommandButton")
292:         WITH THIS.cmd_4c_SelEstoque
293:             .Top         = 3
294:             .Left        = 547
295:             .Width       = 75
296:             .Height      = 75
297:             .Caption     = "\<Estoques"
298:             .FontBold    = .T.
299:             .FontItalic  = .T.
300:             .FontName    = "Comic Sans MS"
301:             .FontSize    = 8
302:             .WordWrap    = .T.
303:             .ForeColor   = RGB(90, 90, 90)
304:             .BackColor   = RGB(255, 255, 255)
305:             .Themes      = .T.
306:             .Enabled     = .F.
307:             IF FILE(loc_cImgEstoque)
308:                 .Picture         = loc_cImgEstoque
309:                 .DisabledPicture = loc_cImgEstoque
310:             ENDIF
311:         ENDWITH
312:         BINDEVENT(THIS.cmd_4c_SelEstoque, "Click", THIS, "BtnSelEstoqueClick")
313: 
314:         *-- Botao Relatorio (772,3,75,75)
315:         THIS.AddObject("cmd_4c_BtnRelatorio", "CommandButton")
316:         WITH THIS.cmd_4c_BtnRelatorio
317:             .Top         = 3
318:             .Left        = 772
319:             .Width       = 75
320:             .Height      = 75
321:             .Caption     = "\<Relat" + CHR(243) + "rio"
322:             .FontBold    = .T.
323:             .FontItalic  = .T.
324:             .FontName    = "Comic Sans MS"
325:             .FontSize    = 8
326:             .WordWrap    = .T.
327:             .ForeColor   = RGB(90, 90, 90)
328:             .BackColor   = RGB(255, 255, 255)
329:             .Themes      = .T.
330:             IF FILE(loc_cImgRelatorio)
331:                 .Picture         = loc_cImgRelatorio
332:                 .DisabledPicture = loc_cImgRelatorio
333:             ENDIF
334:         ENDWITH
335:         BINDEVENT(THIS.cmd_4c_BtnRelatorio, "Click", THIS, "BtnRelatorioClick")
336: 
337:         *-- Botao Processar (847,3,75,75)
338:         THIS.AddObject("cmd_4c_Processar", "CommandButton")
339:         WITH THIS.cmd_4c_Processar
340:             .Top         = 3
341:             .Left        = 847
342:             .Width       = 75
343:             .Height      = 75
344:             .Caption     = "\<Processar"
345:             .FontBold    = .T.
346:             .FontItalic  = .T.
347:             .FontName    = "Comic Sans MS"
348:             .FontSize    = 8
349:             .WordWrap    = .T.
350:             .ForeColor   = RGB(90, 90, 90)
351:             .BackColor   = RGB(255, 255, 255)
352:             .Themes      = .T.
353:             IF FILE(loc_cImgProcessar)
354:                 .Picture         = loc_cImgProcessar
355:                 .DisabledPicture = loc_cImgProcessar
356:             ENDIF
357:         ENDWITH
358:         BINDEVENT(THIS.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
359: 
360:         *-- Botao Sair/Cancelar (922,3,75,75)
361:         THIS.AddObject("cmd_4c_Cancelar", "CommandButton")
362:         WITH THIS.cmd_4c_Cancelar
363:             .Top         = 3
364:             .Left        = 922
365:             .Width       = 75
366:             .Height      = 75
367:             .Caption     = "Encerrar"
368:             .FontBold    = .T.
369:             .FontItalic  = .T.
370:             .FontName    = "Comic Sans MS"
371:             .FontSize    = 8
372:             .WordWrap    = .T.
373:             .ForeColor   = RGB(90, 90, 90)
374:             .BackColor   = RGB(255, 255, 255)
375:             .Themes      = .T.
376:             IF FILE(loc_cImgCancelar)
377:                 .Picture         = loc_cImgCancelar
378:                 .DisabledPicture = loc_cImgCancelar
379:             ENDIF
380:         ENDWITH
381:         BINDEVENT(THIS.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
382: 
383:         *-- Grid principal GradeItens (Top=125, Left=11, Width=708, Height=224, 9 colunas)
384:         THIS.AddObject("grd_4c_Dados", "Grid")
385:         WITH THIS.grd_4c_Dados
386:             .Top              = 125
387:             .Left             = 11
388:             .Width            = 708
389:             .Height           = 224
390:             .ColumnCount      = 9
391:             .AllowHeaderSizing = .F.
392:             .AllowRowSizing    = .F.
393:             .DeleteMark        = .F.
394:             .RecordMark        = .F.
395:             .ScrollBars        = 3
396:             .RowHeight         = 16
397:             .GridLineColor     = RGB(238, 238, 238)
398:             .FontName          = "Tahoma"
399:             .FontSize          = 8
400:             *-- Col1: Produto
401:             WITH .Column1
402:                 .Width          = 80
403:                 .ReadOnly       = .T.
404:                 .Movable        = .F.
405:                 .Resizable      = .F.
406:                 .Header1.Caption = "Produto"
407:                 .Header1.FontName = "Verdana"
408:                 .Header1.FontSize = 8
409:                 .Header1.Alignment = 2
410:                 .Header1.ForeColor = RGB(36, 84, 155)
411:             ENDWITH
412:             *-- Col2: Cor
413:             WITH .Column2
414:                 .Width          = 40
415:                 .ReadOnly       = .T.
416:                 .Movable        = .F.
417:                 .Resizable      = .F.
418:                 .Header1.Caption = "Cor"
419:                 .Header1.FontName = "Verdana"
420:                 .Header1.FontSize = 8
421:                 .Header1.Alignment = 2

*-- Linhas 508 a 569:
508:                 .Header1.FontSize = 8
509:                 .Header1.Alignment = 2
510:                 .Header1.ForeColor = RGB(36, 84, 155)
511:             ENDWITH
512:         ENDWITH
513:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GradeItensAfterRowColChange")
514:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "When",      THIS, "GrdCol6TextWhen")
515:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "Valid",     THIS, "GrdCol6TextValid")
516:         BINDEVENT(THIS.grd_4c_Dados.Column6.Text1, "KeyPress", THIS, "GrdCol6TextLostFocus")
517:         *-- Redirecionar foco das colunas somente-leitura para Column6 (editavel)
518:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "GrdColXGotFocus")
519:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "GrdColXGotFocus")
520:         BINDEVENT(THIS.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "GrdColXGotFocus")
521:         BINDEVENT(THIS.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "GrdColXGotFocus")
522:         BINDEVENT(THIS.grd_4c_Dados.Column5.Text1, "GotFocus", THIS, "GrdColXGotFocus")
523:         BINDEVENT(THIS.grd_4c_Dados.Column7.Text1, "GotFocus", THIS, "GrdColXGotFocus")
524:         BINDEVENT(THIS.grd_4c_Dados.Column8.Text1, "GotFocus", THIS, "GrdColXGotFocus")
525: 
526:         *-- Totais abaixo do grid (349,417-662)
527:         THIS.AddObject("txt_4c_Tot_Qtd", "TextBox")
528:         WITH THIS.txt_4c_Tot_Qtd
529:             .Top          = 349
530:             .Left         = 417
531:             .Width        = 80
532:             .Height       = 23
533:             .ReadOnly     = .T.
534:             .FontName     = "Tahoma"
535:             .FontSize     = 8
536:             .SpecialEffect = 1
537:             .Value        = 0
538:         ENDWITH
539: 
540:         THIS.AddObject("txt_4c_Tot_Est", "TextBox")
541:         WITH THIS.txt_4c_Tot_Est
542:             .Top          = 349
543:             .Left         = 498
544:             .Width        = 81
545:             .Height       = 23
546:             .ReadOnly     = .T.
547:             .FontName     = "Tahoma"
548:             .FontSize     = 8
549:             .SpecialEffect = 1
550:             .Value        = 0
551:         ENDWITH
552: 
553:         THIS.AddObject("txt_4c_Tot_Prz", "TextBox")
554:         WITH THIS.txt_4c_Tot_Prz
555:             .Top          = 349
556:             .Left         = 580
557:             .Width        = 82
558:             .Height       = 23
559:             .ReadOnly     = .T.
560:             .FontName     = "Tahoma"
561:             .FontSize     = 8
562:             .SpecialEffect = 1
563:             .Value        = 0
564:         ENDWITH
565: 
566:         *-- Label para observacao (726,369)
567:         THIS.AddObject("lbl_4c_Txt_ObsItens", "Label")
568:         WITH THIS.lbl_4c_Txt_ObsItens
569:             .Top       = 369

*-- Linhas 599 a 645:
599:             .Height  = 204
600:             .Visible = .F.
601:         ENDWITH
602: 
603:         *-- Container3: saldo/estoque (sempre visivel, Top=373, Left=12, Width=708, Height=205)
604:         THIS.AddObject("cnt_4c_Container3", "Container")
605:         WITH THIS.cnt_4c_Container3
606:             .Top           = 373
607:             .Left          = 12
608:             .Width         = 708
609:             .Height        = 205
610:             .BackColor     = RGB(255, 255, 255)
611:             .SpecialEffect = 0
612:             .BorderWidth   = 1
613: 
614:             .AddObject("lbl_4c_Label1", "Label")
615:             WITH .lbl_4c_Label1
616:                 .Top       = 5
617:                 .Left      = 6
618:                 .Width     = 118
619:                 .Height    = 16
620:                 .AutoSize  = .F.
621:                 .BackStyle = 0
622:                 .FontBold  = .T.
623:                 .FontName  = "Tahoma"
624:                 .FontSize  = 8
625:                 .ForeColor = RGB(90, 90, 90)
626:                 .Caption   = "Estoque Dispon" + CHR(237) + "vel"
627:             ENDWITH
628: 
629:             .AddObject("grd_4c_Dados", "Grid")
630:             WITH .grd_4c_Dados
631:                 .Top              = 24
632:                 .Left             = 6
633:                 .Width            = 444
634:                 .Height           = 148
635:                 .ColumnCount      = 6
636:                 .AllowHeaderSizing = .F.
637:                 .AllowRowSizing    = .F.
638:                 .DeleteMark        = .F.
639:                 .RecordMark        = .F.
640:                 .ScrollBars        = 2
641:                 .RowHeight         = 16
642:                 .GridLineColor     = RGB(238, 238, 238)
643:                 .FontSize          = 8
644:                 WITH .Column1
645:                     .Width = 70

*-- Linhas 711 a 756:
711:                 .ReadOnly     = .T.
712:                 .SpecialEffect = 1
713:                 .FontSize     = 8
714:             ENDWITH
715: 
716:             .AddObject("txt_4c_Tot_Qtd", "TextBox")
717:             WITH .txt_4c_Tot_Qtd
718:                 .Top          = 173
719:                 .Left         = 188
720:                 .Width        = 80
721:                 .Height       = 23
722:                 .ReadOnly     = .T.
723:                 .SpecialEffect = 1
724:                 .FontSize     = 8
725:                 .Value        = 0
726:             ENDWITH
727: 
728:             .AddObject("txt_4c_Tot_Est", "TextBox")
729:             WITH .txt_4c_Tot_Est
730:                 .Top          = 173
731:                 .Left         = 269
732:                 .Width        = 80
733:                 .Height       = 23
734:                 .ReadOnly     = .T.
735:                 .SpecialEffect = 1
736:                 .FontSize     = 8
737:                 .Value        = 0
738:             ENDWITH
739: 
740:             .AddObject("txt_4c_Tot_Prz", "TextBox")
741:             WITH .txt_4c_Tot_Prz
742:                 .Top          = 173
743:                 .Left         = 350
744:                 .Width        = 80
745:                 .Height       = 23
746:                 .ReadOnly     = .T.
747:                 .SpecialEffect = 1
748:                 .FontSize     = 8
749:                 .Value        = 0
750:             ENDWITH
751: 
752:             .AddObject("lbl_4c_Label2", "Label")
753:             WITH .lbl_4c_Label2
754:                 .Top = 90
755:                 .Left = 454
756:                 .Width = 36

*-- Linhas 773 a 839:
773:                 .Caption = "Conta"
774:                 .FontSize = 8
775:                 .ForeColor = RGB(90, 90, 90)
776:             ENDWITH
777:         ENDWITH
778:         BINDEVENT(THIS.cnt_4c_Container3.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt3GradeAfterRowColChange")
779: 
780:         *-- Container1: totais por linha (Visible=.F., sobreposicao)
781:         THIS.AddObject("cnt_4c_Container1", "Container")
782:         WITH THIS.cnt_4c_Container1
783:             .Top           = 125
784:             .Left          = 12
785:             .Width         = 708
786:             .Height        = 465
787:             .BackColor     = RGB(255, 255, 255)
788:             .BackStyle     = 1
789:             .SpecialEffect = 0
790:             .Visible       = .F.
791: 
792:             .AddObject("lbl_4c_Label1", "Label")
793:             WITH .lbl_4c_Label1
794:                 .Top = 10
795:                 .Left = 259
796:                 .Width = 170
797:                 .Height = 18
798:                 .AutoSize = .F.
799:                 .BackStyle = 0
800:                 .FontBold = .T.
801:                 .FontName = "Tahoma"
802:                 .FontSize = 10
803:                 .ForeColor = RGB(90, 90, 90)
804:                 .Caption = "Pe" + CHR(231) + "as a produzir por linha"
805:             ENDWITH
806: 
807:             .AddObject("cmd_4c_CancelaLin", "CommandButton")
808:             WITH .cmd_4c_CancelaLin
809:                 .Top = 10
810:                 .Left = 620
811:                 .Width = 75
812:                 .Height = 75
813:                 .Caption = "OK"
814:                 .FontBold = .T.
815:                 .FontItalic = .T.
816:                 .FontName = "Comic Sans MS"
817:                 .FontSize = 8
818:                 .ForeColor = RGB(90, 90, 90)
819:                 .BackColor = RGB(255, 255, 255)
820:                 .Themes = .F.
821:             ENDWITH
822: 
823:             .AddObject("grd_4c_Dados", "Grid")
824:             WITH .grd_4c_Dados
825:                 .Top = 32
826:                 .Left = 174
827:                 .Width = 359
828:                 .Height = 420
829:                 .ColumnCount = 4
830:                 .AllowHeaderSizing = .F.
831:                 .AllowRowSizing = .F.
832:                 .DeleteMark = .F.
833:                 .RecordMark = .F.
834:                 .ScrollBars = 2
835:                 .RowHeight = 16
836:                 .FontSize = 8
837:                 WITH .Column1
838:                     .Width = 80
839:                     .ReadOnly = .T.

*-- Linhas 866 a 932:
866:                     .Header1.FontSize = 8
867:                     .Header1.ForeColor = RGB(36, 84, 155)
868:                 ENDWITH
869:             ENDWITH
870:         ENDWITH
871:         BINDEVENT(THIS.cnt_4c_Container1.cmd_4c_CancelaLin, "Click", THIS, "BtnCancelaLin1Click")
872: 
873:         *-- Container2: disponivel por produto/cor/tam (Visible=.F.)
874:         THIS.AddObject("cnt_4c_Container2", "Container")
875:         WITH THIS.cnt_4c_Container2
876:             .Top = 125
877:             .Left = 12
878:             .Width = 708
879:             .Height = 465
880:             .BackColor = RGB(255, 255, 255)
881:             .BackStyle = 1
882:             .SpecialEffect = 0
883:             .Visible = .F.
884: 
885:             .AddObject("lbl_4c_Label1", "Label")
886:             WITH .lbl_4c_Label1
887:                 .Top = 10
888:                 .Left = 284
889:                 .Width = 123
890:                 .Height = 18
891:                 .AutoSize = .F.
892:                 .BackStyle = 0
893:                 .FontBold = .T.
894:                 .FontName = "Tahoma"
895:                 .FontSize = 10
896:                 .ForeColor = RGB(90, 90, 90)
897:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
898:             ENDWITH
899: 
900:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
901:             WITH .cmd_4c_CancelaDisp
902:                 .Top = 10
903:                 .Left = 620
904:                 .Width = 75
905:                 .Height = 75
906:                 .Caption = "Sair"
907:                 .FontBold = .T.
908:                 .FontItalic = .T.
909:                 .FontName = "Comic Sans MS"
910:                 .FontSize = 8
911:                 .ForeColor = RGB(90, 90, 90)
912:                 .BackColor = RGB(255, 255, 255)
913:                 .Themes = .F.
914:             ENDWITH
915: 
916:             .AddObject("grd_4c_Dados", "Grid")
917:             WITH .grd_4c_Dados
918:                 .Top = 32
919:                 .Left = 169
920:                 .Width = 370
921:                 .Height = 388
922:                 .ColumnCount = 5
923:                 .AllowHeaderSizing = .F.
924:                 .AllowRowSizing = .F.
925:                 .DeleteMark = .F.
926:                 .RecordMark = .F.
927:                 .ScrollBars = 2
928:                 .RowHeight = 16
929:                 .FontSize = 8
930:                 WITH .Column1
931:                     .Width = 80
932:                     .ReadOnly = .T.

*-- Linhas 971 a 1016:
971:                     .Text1.BorderStyle = 0
972:                     .Text1.Alignment = 3
973:                     .Text1.Value = 0
974:                 ENDWITH
975:             ENDWITH
976:             BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt2Col5TextValid")
977: 
978:             .AddObject("lbl_4c_Label2", "Label")
979:             WITH .lbl_4c_Label2
980:                 .Top = 432
981:                 .Left = 168
982:                 .Width = 84
983:                 .Height = 15
984:                 .AutoSize = .F.
985:                 .BackStyle = 0
986:                 .FontSize = 8
987:                 .ForeColor = RGB(90, 90, 90)
988:                 .Caption = "Qtde " + CHR(224) + " Produzir :"
989:             ENDWITH
990: 
991:             .AddObject("lbl_4c_Label3", "Label")
992:             WITH .lbl_4c_Label3
993:                 .Top = 431
994:                 .Left = 365
995:                 .Width = 109
996:                 .Height = 17
997:                 .AutoSize = .F.
998:                 .BackStyle = 0
999:                 .FontSize = 8
1000:                 .ForeColor = RGB(90, 90, 90)
1001:                 .Caption = "Qtde " + CHR(224) + " Utilizar :"
1002:             ENDWITH
1003: 
1004:             .AddObject("txt_4c_Qt_pedida", "TextBox")
1005:             WITH .txt_4c_Qt_pedida
1006:                 .Top = 428
1007:                 .Left = 268
1008:                 .Width = 80
1009:                 .Height = 23
1010:                 .ReadOnly = .T.
1011:                 .SpecialEffect = 1
1012:                 .FontSize = 8
1013:                 .Value = 0
1014:             ENDWITH
1015: 
1016:             .AddObject("txt_4c_Qt_Selec", "TextBox")

*-- Linhas 1023 a 1094:
1023:                 .SpecialEffect = 1
1024:                 .FontSize = 8
1025:                 .Value = 0
1026:             ENDWITH
1027:         ENDWITH
1028:         BINDEVENT(THIS.cnt_4c_Container2.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp2Click")
1029:         *-- Redirecionar foco das colunas somente-leitura para Column5 (QtdDisp editavel)
1030:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column1.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1031:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column2.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1032:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column3.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1033:         BINDEVENT(THIS.cnt_4c_Container2.grd_4c_Dados.Column4.Text1, "GotFocus", THIS, "Cnt2GrdColXGotFocus")
1034: 
1035:         *-- Container4: pedras/requisicoes adicionais (Visible=.F.)
1036:         THIS.AddObject("cnt_4c_Container4", "Container")
1037:         WITH THIS.cnt_4c_Container4
1038:             .Top = 125
1039:             .Left = 12
1040:             .Width = 708
1041:             .Height = 465
1042:             .BackColor = RGB(255, 255, 255)
1043:             .BackStyle = 1
1044:             .SpecialEffect = 0
1045:             .Visible = .F.
1046: 
1047:             .AddObject("lbl_4c_Label1", "Label")
1048:             WITH .lbl_4c_Label1
1049:                 .Top = 8
1050:                 .Left = 229
1051:                 .Width = 249
1052:                 .Height = 18
1053:                 .AutoSize = .F.
1054:                 .BackStyle = 0
1055:                 .FontBold = .T.
1056:                 .FontName = "Tahoma"
1057:                 .FontSize = 10
1058:                 .ForeColor = RGB(90, 90, 90)
1059:                 .Caption = "Requisi" + CHR(231) + CHR(227) + "o de componentes adicionais"
1060:             ENDWITH
1061: 
1062:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1063:             WITH .cmd_4c_CancelaDisp
1064:                 .Top = 10
1065:                 .Left = 620
1066:                 .Width = 75
1067:                 .Height = 75
1068:                 .Caption = "Sair"
1069:                 .FontBold = .T.
1070:                 .FontItalic = .T.
1071:                 .FontName = "Comic Sans MS"
1072:                 .FontSize = 8
1073:                 .ForeColor = RGB(90, 90, 90)
1074:                 .BackColor = RGB(255, 255, 255)
1075:                 .Themes = .F.
1076:             ENDWITH
1077: 
1078:             .AddObject("grd_4c_Dados", "Grid")
1079:             WITH .grd_4c_Dados
1080:                 .Top = 32
1081:                 .Left = 9
1082:                 .Width = 605
1083:                 .Height = 420
1084:                 .ColumnCount = 5
1085:                 .AllowHeaderSizing = .F.
1086:                 .AllowRowSizing = .F.
1087:                 .DeleteMark = .F.
1088:                 .RecordMark = .F.
1089:                 .ScrollBars = 3
1090:                 .RowHeight = 16
1091:                 .FontSize = 8
1092:                 WITH .Column1
1093:                     .Width = 80
1094:                     .ReadOnly = .F.

*-- Linhas 1129 a 1199:
1129:                     .Header1.FontSize = 8
1130:                     .Header1.ForeColor = RGB(36, 84, 155)
1131:                 ENDWITH
1132:             ENDWITH
1133:         ENDWITH
1134:         BINDEVENT(THIS.cnt_4c_Container4.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp4Click")
1135:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1, "Valid", THIS, "Cnt4Col1TextValid")
1136:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column4.Text1, "When",  THIS, "Cnt4Col4TextWhen")
1137:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "When",  THIS, "Cnt4Col5TextWhen")
1138:         BINDEVENT(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt4Col5TextValid")
1139: 
1140:         *-- Container5: selecao de estoque por grupo/conta (Visible=.F.)
1141:         THIS.AddObject("cnt_4c_Container5", "Container")
1142:         WITH THIS.cnt_4c_Container5
1143:             .Top = 125
1144:             .Left = 12
1145:             .Width = 708
1146:             .Height = 465
1147:             .BackColor = RGB(255, 255, 255)
1148:             .BackStyle = 1
1149:             .SpecialEffect = 0
1150:             .Visible = .F.
1151: 
1152:             .AddObject("lbl_4c_Label1", "Label")
1153:             WITH .lbl_4c_Label1
1154:                 .Top = 10
1155:                 .Left = 284
1156:                 .Width = 123
1157:                 .Height = 18
1158:                 .AutoSize = .F.
1159:                 .BackStyle = 0
1160:                 .FontBold = .T.
1161:                 .FontName = "Tahoma"
1162:                 .FontSize = 10
1163:                 .ForeColor = RGB(90, 90, 90)
1164:                 .Caption = "Estoque Dispon" + CHR(237) + "vel"
1165:             ENDWITH
1166: 
1167:             .AddObject("cmd_4c_CancelaDisp", "CommandButton")
1168:             WITH .cmd_4c_CancelaDisp
1169:                 .Top = 10
1170:                 .Left = 620
1171:                 .Width = 75
1172:                 .Height = 75
1173:                 .Caption = "OK"
1174:                 .FontBold = .T.
1175:                 .FontItalic = .T.
1176:                 .FontName = "Comic Sans MS"
1177:                 .FontSize = 8
1178:                 .ForeColor = RGB(90, 90, 90)
1179:                 .BackColor = RGB(255, 255, 255)
1180:                 .Themes = .F.
1181:             ENDWITH
1182: 
1183:             .AddObject("grd_4c_Dados", "Grid")
1184:             WITH .grd_4c_Dados
1185:                 .Top = 32
1186:                 .Left = 141
1187:                 .Width = 425
1188:                 .Height = 372
1189:                 .ColumnCount = 5
1190:                 .AllowHeaderSizing = .F.
1191:                 .AllowRowSizing = .F.
1192:                 .DeleteMark = .F.
1193:                 .RecordMark = .F.
1194:                 .ScrollBars = 2
1195:                 .RowHeight = 16
1196:                 .FontSize = 8
1197:                 WITH .Column1
1198:                     .Width = 80
1199:                     .ReadOnly = .T.

*-- Linhas 1238 a 1284:
1238:                     .Text1.BorderStyle = 0
1239:                     .Text1.Alignment = 3
1240:                     .Text1.Value = 0
1241:                 ENDWITH
1242:             ENDWITH
1243:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1, "Valid", THIS, "Cnt5Col5TextValid")
1244:             BINDEVENT(THIS.cnt_4c_Container5.grd_4c_Dados, "AfterRowColChange", THIS, "Cnt5GradeAfterRowColChange")
1245: 
1246:             .AddObject("lbl_4c_Label2", "Label")
1247:             WITH .lbl_4c_Label2
1248:                 .Top = 413
1249:                 .Left = 428
1250:                 .Width = 48
1251:                 .Height = 15
1252:                 .AutoSize = .F.
1253:                 .BackStyle = 0
1254:                 .FontSize = 8
1255:                 .ForeColor = RGB(90, 90, 90)
1256:                 .Caption = "Produzir :"
1257:             ENDWITH
1258: 
1259:             .AddObject("lbl_4c_Label3", "Label")
1260:             WITH .lbl_4c_Label3
1261:                 .Top = 438
1262:                 .Left = 435
1263:                 .Width = 41
1264:                 .Height = 15
1265:                 .AutoSize = .F.
1266:                 .BackStyle = 0
1267:                 .FontSize = 8
1268:                 .ForeColor = RGB(90, 90, 90)
1269:                 .Caption = "Utilizar :"
1270:             ENDWITH
1271: 
1272:             .AddObject("lbl_4c_Label4", "Label")
1273:             WITH .lbl_4c_Label4
1274:                 .Top = 413
1275:                 .Left = 93
1276:                 .Width = 38
1277:                 .Height = 15
1278:                 .AutoSize = .F.
1279:                 .BackStyle = 0
1280:                 .FontSize = 8
1281:                 .ForeColor = RGB(90, 90, 90)
1282:                 .Caption = "Grupo :"
1283:             ENDWITH
1284: 

*-- Linhas 1339 a 1960:
1339:                 .SpecialEffect = 1
1340:                 .FontSize = 8
1341:                 .Value = 0
1342:             ENDWITH
1343:         ENDWITH
1344:         BINDEVENT(THIS.cnt_4c_Container5.cmd_4c_CancelaDisp, "Click", THIS, "BtnCancelaDisp5Click")
1345: 
1346:         *-- Shape2: delineamento visual da area de data/info no topo (9,9,279,51)
1347:         THIS.AddObject("shp_4c_Shape2", "Shape")
1348:         WITH THIS.shp_4c_Shape2
1349:             .Top         = 9
1350:             .Left        = 9
1351:             .Width       = 279
1352:             .Height      = 51
1353:             .BackStyle   = 0
1354:             .BorderColor = RGB(255, 255, 255)
1355:             .BorderWidth = 2
1356:             .SpecialEffect = 0
1357:         ENDWITH
1358: 
1359:         *-- Shape3: delineamento visual da area de numero/referencia (820,10,116,38)
1360:         THIS.AddObject("shp_4c_Shape3", "Shape")
1361:         WITH THIS.shp_4c_Shape3
1362:             .Top         = 10
1363:             .Left        = 820
1364:             .Width       = 116
1365:             .Height      = 38
1366:             .BackStyle   = 0
1367:             .BorderColor = RGB(255, 255, 255)
1368:             .BorderWidth = 2
1369:             .SpecialEffect = 0
1370:         ENDWITH
1371:     ENDPROC
1372: 
1373:     *==========================================================================
1374:     * ConfigurarPaginaLista - Restaura a visao principal do form
1375:     *
1376:     * OPERACIONAL: nao ha PageFrame com Page1/Page2 como em CRUD. A "pagina
1377:     * lista" aqui eh o conjunto: grid principal (grd_4c_Dados / TmpFinal) +
1378:     * totais + Container3 (saldo por grupo/conta, sempre visivel). Os overlays
1379:     * (Container1/2/4/5) sao escondidos e as acoes principais reabilitadas.
1380:     *==========================================================================
1381:     PROTECTED PROCEDURE ConfigurarPaginaLista
1382:         LOCAL loc_lPodeAcao
1383: 
1384:         *-- Ocultar overlays flutuantes
1385:         IF PEMSTATUS(THIS, "cnt_4c_Container1", 5)
1386:             THIS.cnt_4c_Container1.Visible = .F.
1387:         ENDIF
1388:         IF PEMSTATUS(THIS, "cnt_4c_Container2", 5)
1389:             THIS.cnt_4c_Container2.Visible = .F.
1390:         ENDIF
1391:         IF PEMSTATUS(THIS, "cnt_4c_Container4", 5)
1392:             THIS.cnt_4c_Container4.Visible = .F.
1393:         ENDIF
1394:         IF PEMSTATUS(THIS, "cnt_4c_Container5", 5)
1395:             THIS.cnt_4c_Container5.Visible = .F.
1396:         ENDIF
1397: 
1398:         *-- Grid principal e Container3 (saldo) sempre acessiveis
1399:         IF PEMSTATUS(THIS, "grd_4c_Dados", 5)
1400:             THIS.grd_4c_Dados.Enabled = .T.
1401:             THIS.grd_4c_Dados.ZOrder
1402:         ENDIF
1403:         IF PEMSTATUS(THIS, "cnt_4c_Container3", 5)
1404:             THIS.cnt_4c_Container3.Enabled = .T.
1405:         ENDIF
1406: 
1407:         *-- Reabilitar botoes de acao principal
1408:         THIS.cmd_4c_Processar.Enabled  = .T.
1409:         THIS.cmd_4c_Cancelar.Enabled   = .T.
1410:         THIS.cmd_4c_TotLinha.Enabled   = .T.
1411:         THIS.cmd_4c_Disponivel.Enabled = .T.
1412:         THIS.cmd_4c_BtnRelatorio.Enabled = .T.
1413: 
1414:         *-- Botao Pedras/SelEstoque respeitam regra de negocio
1415:         loc_lPodeAcao = .F.
1416:         IF USED("crSigCdPam")
1417:             SELECT crSigCdPam
1418:             loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND !EMPTY(crSigCdPam.DopReqcs) AND ;
1419:                             !EMPTY(crSigCdPam.DopPedcs) AND !EMPTY(crSigCdPam.DopComps) AND ;
1420:                             !THIS.this_lReserva
1421:         ENDIF
1422:         THIS.cmd_4c_Pedras.Enabled     = loc_lPodeAcao
1423:         THIS.cmd_4c_SelEstoque.Enabled = loc_lPodeAcao
1424: 
1425:         *-- Focar grid principal na coluna editavel Produzir
1426:         IF THIS.grd_4c_Dados.Enabled
1427:             THIS.grd_4c_Dados.Refresh
1428:             THIS.grd_4c_Dados.Column6.SetFocus
1429:         ENDIF
1430:     ENDPROC
1431: 
1432:     *==========================================================================
1433:     * ConfigurarPaginaDados - Configura a area de detalhes do item corrente
1434:     *
1435:     * OPERACIONAL: nao ha PageFrame com Page2, mas o form tem uma "area de
1436:     * dados" logica composta por Container3 (saldo por grupo/conta do produto
1437:     * selecionado) + EditBox de observacao + totais Qtd/Est/Prz. Este metodo
1438:     * atualiza os bindings e valores exibidos para o registro corrente do grid
1439:     * principal (TmpFinal). E chamado apos mudanca de linha no grid principal.
1440:     *==========================================================================
1441:     PROTECTED PROCEDURE ConfigurarPaginaDados
1442:         LOCAL loc_nSaldo, loc_nEstoque, loc_nProduzir
1443: 
1444:         loc_nSaldo    = 0
1445:         loc_nEstoque  = 0
1446:         loc_nProduzir = 0
1447: 
1448:         *-- Requer TmpFinal e TmpSaldG carregados
1449:         IF !USED("TmpFinal") OR !USED("TmpSaldG")
1450:             RETURN
1451:         ENDIF
1452: 
1453:         *-- Reposicionar TmpSaldG conforme item corrente do grid principal
1454:         SELECT TmpSaldG
1455:         SET ORDER TO Cpros
1456:         SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1457:         GO TOP
1458: 
1459:         *-- Vincular Container3 grid ao cursor de saldo detalhado
1460:         WITH THIS.cnt_4c_Container3.grd_4c_Dados
1461:             .RecordSource = "TmpSaldG"
1462:             .Column1.ControlSource = "TmpSaldG.Grupos"
1463:             .Column2.ControlSource = "TmpSaldG.Estos"
1464:             .Column3.ControlSource = "TmpSaldG.Saldo"
1465:             .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1466:             .Column5.ControlSource = "TmpSaldG.Disps"
1467:             .Column6.ControlSource = "TmpSaldG.Emps"
1468:             .SetAll("ReadOnly", .T.)
1469:             .Refresh
1470:         ENDWITH
1471: 
1472:         *-- Descricoes grupo/conta (buscadas via CursorQuery no AfterRowColChange)
1473:         IF USED("TmpGrupo")
1474:             THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = TratarNulo(TmpGrupo.Descrs, "C")
1475:         ENDIF
1476:         IF USED("TmpConta")
1477:             THIS.cnt_4c_Container3.txt_4c__dconta.Value = TratarNulo(TmpConta.RClis, "C")
1478:         ENDIF
1479: 
1480:         *-- Totais do item corrente (Saldo/Estoque/Produzir do TmpSaldo)
1481:         IF USED("TmpSaldo") AND SEEK(TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1482:             loc_nSaldo    = NVL(TmpSaldo.Saldo, 0)
1483:             loc_nEstoque  = NVL(TmpSaldo.Saldo, 0) - NVL(TmpSaldo.Disps, 0)
1484:             loc_nProduzir = NVL(TmpSaldo.Disps, 0)
1485:         ENDIF
1486:         THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = loc_nSaldo
1487:         THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = loc_nEstoque
1488:         THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = loc_nProduzir
1489: 
1490:         *-- Rebind da EditBox de observacao ao item corrente
1491:         THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1492:         THIS.obj_4c_ObsItens.Refresh
1493: 
1494:         *-- Rotulo dinamico da observacao
1495:         THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ;
1496:                                             ALLTRIM(TratarNulo(TmpFinal.Cpros, "C"))
1497:     ENDPROC
1498: 
1499:     *==========================================================================
1500:     * AlternarPagina - Alterna entre a visao principal e os overlays
1501:     *
1502:     * Parametros: par_nPagina
1503:     *   0 -> visao principal (grid + Container3) - via ConfigurarPaginaLista()
1504:     *   1 -> Container1 (Totais por Linha) - equivalente a BtnTotLinhaClick
1505:     *   2 -> Container2 (Disponibilidade)  - equivalente a BtnDisponiveiClick
1506:     *   3 -> Container3 permanece ativo (saldo por grupo/conta) - restaura lista
1507:     *   4 -> Container4 (Requisicoes)      - equivalente a BtnPedrasClick
1508:     *   5 -> Container5 (Selecao Estoque)  - equivalente a BtnSelEstoqueClick
1509:     *==========================================================================
1510:     PROCEDURE AlternarPagina(par_nPagina)
1511:         LOCAL loc_nPag
1512:         loc_nPag = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 0)
1513: 
1514:         DO CASE
1515:             CASE loc_nPag = 1
1516:                 THIS.BtnTotLinhaClick()
1517:             CASE loc_nPag = 2
1518:                 THIS.BtnDisponiveiClick()
1519:             CASE loc_nPag = 4
1520:                 THIS.BtnPedrasClick()
1521:             CASE loc_nPag = 5
1522:                 THIS.BtnSelEstoqueClick()
1523:             OTHERWISE
1524:                 *-- Pagina 0 ou 3: restaurar visao principal
1525:                 THIS.ConfigurarPaginaLista()
1526:         ENDCASE
1527:     ENDPROC
1528: 
1529:     *==========================================================================
1530:     PROTECTED PROCEDURE CarregarDados
1531:     *==========================================================================
1532:         LOCAL loc_lReadOnly
1533: 
1534:         *-- Grid principal: vincular ao TmpFinal
1535:         IF USED("TmpFinal")
1536:             WITH THIS.grd_4c_Dados
1537:                 .RecordSource = "TmpFinal"
1538:                 .Column1.ControlSource = "TmpFinal.Cpros"
1539:                 .Column2.ControlSource = "TmpFinal.CodCors"
1540:                 .Column3.ControlSource = "TmpFinal.Dopes"
1541:                 .Column4.ControlSource = "TmpFinal.Numes"
1542:                 .Column5.ControlSource = "TmpFinal.Saldo"
1543:                 .Column6.ControlSource = "TmpFinal.Produzir"
1544:                 .Column7.ControlSource = "TmpFinal.Estoque"
1545:                 .Column8.ControlSource = "IIF(EMPTY(TmpFinal.Obsps), ' ', '*')"
1546:                 .Column9.ControlSource = "TmpFinal.CodTams"
1547:             ENDWITH
1548: 
1549:             *-- Se nao ha operacao de transferencia, grid fica somente leitura
1550:             IF USED("crSigCdPam")
1551:                 SELECT crSigCdPam
1552:                 IF EMPTY(crSigCdPam.TransfRes)
1553:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
1554:                 ENDIF
1555:             ENDIF
1556:         ENDIF
1557: 
1558:         *-- Container3: Grid saldo por grupo/conta (TmpSaldG)
1559:         IF USED("TmpSaldG") AND USED("TmpFinal")
1560:             SELECT TmpSaldG
1561:             SET ORDER TO Cpros
1562:             GO TOP
1563:             IF !EOF("TmpFinal")
1564:                 SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
1565:             ENDIF
1566:             GO TOP
1567: 
1568:             WITH THIS.cnt_4c_Container3.grd_4c_Dados
1569:                 .RecordSource = "TmpSaldG"
1570:                 .Column1.ControlSource = "TmpSaldG.Grupos"
1571:                 .Column2.ControlSource = "TmpSaldG.Estos"
1572:                 .Column3.ControlSource = "TmpSaldG.Saldo"
1573:                 .Column4.ControlSource = "TmpSaldG.Saldo - TmpSaldG.Disps"
1574:                 .Column5.ControlSource = "TmpSaldG.Disps"
1575:                 .Column6.ControlSource = "TmpSaldG.Emps"
1576:                 .SetAll("ReadOnly", .T.)
1577:             ENDWITH
1578:         ENDIF
1579: 
1580:         *-- ObsItens: vincula ao campo de observacao do item corrente
1581:         IF USED("TmpFinal")
1582:             THIS.obj_4c_ObsItens.ControlSource = "TmpFinal.Obsps"
1583:         ENDIF
1584:     ENDPROC
1585: 
1586:     *==========================================================================
1587:     PROTECTED PROCEDURE TornarControlesVisiveis
1588:     *==========================================================================
1589:         LOCAL loc_nI, loc_oCtrl
1590:         FOR loc_nI = 1 TO THIS.ControlCount
1591:             loc_oCtrl = THIS.Controls(loc_nI)
1592:             IF INLIST(loc_oCtrl.Name, ;
1593:                       "cnt_4c_Container1", ;
1594:                       "cnt_4c_Container2", ;
1595:                       "cnt_4c_Container4", ;
1596:                       "cnt_4c_Container5", ;
1597:                       "img_4c_ImgFigJpg")
1598:                 *-- Container permanece oculto, mas sub-controles precisam de Visible=.T.
1599:                 *-- para que aparecam quando o container for tornado visivel por um botao
1600:                 IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1601:                     THIS.TornarSubControlesVisiveis(loc_oCtrl)
1602:                 ENDIF
1603:                 LOOP
1604:             ENDIF
1605:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1606:                 loc_oCtrl.Visible = .T.
1607:             ENDIF
1608:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1609:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1610:             ENDIF
1611:         ENDFOR
1612:     ENDPROC
1613: 
1614:     *==========================================================================
1615:     PROTECTED PROCEDURE TornarSubControlesVisiveis(par_oContainer)
1616:     *==========================================================================
1617:         LOCAL loc_nI, loc_oCtrl
1618:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1619:             loc_oCtrl = par_oContainer.Controls(loc_nI)
1620:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1621:                 loc_oCtrl.Visible = .T.
1622:             ENDIF
1623:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5) AND loc_oCtrl.ControlCount > 0
1624:                 THIS.TornarSubControlesVisiveis(loc_oCtrl)
1625:             ENDIF
1626:         ENDFOR
1627:     ENDPROC
1628: 
1629:     *==========================================================================
1630:     PROCEDURE Destroy
1631:     *==========================================================================
1632:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1633:             THIS.this_oBusinessObject.LiberarConexaoTemp()
1634:         ENDIF
1635:         DODEFAULT()
1636:     ENDPROC
1637: 
1638:     *==========================================================================
1639:     * HANDLERS DE EVENTOS DOS BOTOES PRINCIPAIS
1640:     *==========================================================================
1641: 
1642:     PROCEDURE BtnDisponiveiClick
1643:         LOCAL loc_cCpro, loc_cCor
1644: 
1645:         TRY
1646:             IF USED("TmpFinal")
1647:                 loc_cCpro = TmpFinal.Cpros
1648:                 loc_cCor  = TmpFinal.CodCors
1649: 
1650:                 IF USED("TmpDisp")
1651:                     THIS.cnt_4c_Container2.grd_4c_Dados.RecordSource = ""
1652:                     USE IN TmpDisp
1653:                 ENDIF
1654: 
1655:                 SELECT Cpros, CodCors, CodTams, Disps, 000000000.000 AS Utilizar ;
1656:                   FROM TmpSaldo ;
1657:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND Disps > 0 ;
1658:                  ORDER BY Cpros, CodCors, CodTams ;
1659:                   INTO CURSOR TmpDisp READWRITE
1660: 
1661:                 THIS.grd_4c_Dados.Enabled = .F.
1662: 
1663:                 IF _Tally = 0
1664:                     MsgAviso("N" + CHR(227) + "o Existe Estoque Dispon" + CHR(237) + "vel Em Nenhum Tamanho!!!", "")
1665:                     THIS.BtnCancelaDisp2Click()
1666:                 ELSE
1667:                     WITH THIS.cnt_4c_Container2.grd_4c_Dados
1668:                         .RecordSource = "TmpDisp"
1669:                         .Column1.ControlSource = "TmpDisp.Cpros"
1670:                         .Column2.ControlSource = "TmpDisp.CodCors"
1671:                         .Column3.ControlSource = "TmpDisp.CodTams"
1672:                         .Column4.ControlSource = "TmpDisp.Disps"
1673:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1674:                     ENDWITH
1675: 
1676:                     WITH THIS.cnt_4c_Container2
1677:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo
1678:                         .txt_4c_Qt_Selec.Value  = 0
1679:                         .Visible     = .T.
1680:                     ENDWITH
1681: 
1682:                     THIS.cmd_4c_Processar.Enabled  = .F.
1683:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1684:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1685:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1686:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1687:                     THIS.cnt_4c_Container3.Enabled = .F.
1688:                     THIS.cnt_4c_Container2.Visible = .T.
1689:                     THIS.cnt_4c_Container2.ZOrder
1690:                     THIS.cnt_4c_Container2.grd_4c_Dados.Refresh
1691:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.SetFocus
1692:                 ENDIF
1693:             ENDIF
1694:         CATCH TO loc_oErro
1695:             MsgErro(loc_oErro.Message, "Erro")
1696:         ENDTRY
1697:     ENDPROC
1698: 
1699:     PROCEDURE BtnTotLinhaClick
1700:         TRY
1701:             IF USED("TmpLinha")
1702:                 THIS.cnt_4c_Container1.grd_4c_Dados.RecordSource = ""
1703:                 USE IN TmpLinha
1704:             ENDIF
1705: 
1706:             SELECT Linhas, 0 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1707:               FROM TmpFinal ;
1708:              GROUP BY 1 ;
1709:              UNION ALL ;
1710:             SELECT PADR("TOTAIS", 10) AS Linhas, 1 AS Ordem, SUM(Saldo) AS Saldo, SUM(Estoque) AS Estoque, SUM(Produzir) AS Produzir ;
1711:               FROM TmpFinal ;
1712:              GROUP BY 1 ;
1713:               INTO CURSOR TmpLinha ;
1714:              ORDER BY 2, 1
1715: 
1716:             WITH THIS.cnt_4c_Container1.grd_4c_Dados
1717:                 .RecordSource = "TmpLinha"
1718:                 .Column1.ControlSource = "TmpLinha.Linhas"
1719:                 .Column2.ControlSource = "TmpLinha.Saldo"
1720:                 .Column3.ControlSource = "TmpLinha.Estoque"
1721:                 .Column4.ControlSource = "TmpLinha.Produzir"
1722:                 .SetAll("DynamicFontBold",  "TmpLinha.Linhas = [TOTAIS]", "Column")
1723:                 .SetAll("DynamicForeColor", "IIF(TmpLinha.Linhas = [TOTAIS], RGB(0,0,255), RGB(0,0,0))", "Column")
1724:             ENDWITH
1725: 
1726:             THIS.cmd_4c_Processar.Enabled  = .F.
1727:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1728:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1729:             THIS.cmd_4c_Pedras.Enabled     = .F.
1730:             THIS.cmd_4c_Disponivel.Enabled = .F.
1731:             THIS.grd_4c_Dados.Enabled      = .F.
1732:             THIS.cnt_4c_Container3.Enabled = .F.
1733:             THIS.cnt_4c_Container1.Visible = .T.
1734:             THIS.cnt_4c_Container1.ZOrder
1735:             THIS.cnt_4c_Container1.grd_4c_Dados.Refresh
1736:             THIS.cnt_4c_Container1.grd_4c_Dados.Column1.SetFocus
1737:         CATCH TO loc_oErro
1738:             MsgErro(loc_oErro.Message, "Erro")
1739:         ENDTRY
1740:     ENDPROC
1741: 
1742:     PROCEDURE BtnPedrasClick
1743:         TRY
1744:             IF USED("SelPedra")
1745:                 THIS.cnt_4c_Container4.grd_4c_Dados.RecordSource = ""
1746:             ENDIF
1747: 
1748:             WITH THIS.cnt_4c_Container4.grd_4c_Dados
1749:                 .RecordSource = "SelPedra"
1750:                 .Column1.ControlSource = "SelPedra.Cpros"
1751:                 .Column2.ControlSource = "SelPedra.Dpros"
1752:                 .Column3.ControlSource = "SelPedra.Cunis"
1753:                 .Column4.ControlSource = "SelPedra.Qtds"
1754:                 .Column5.ControlSource = "SelPedra.Cpro2s"
1755:             ENDWITH
1756: 
1757:             THIS.cmd_4c_Processar.Enabled  = .F.
1758:             THIS.cmd_4c_Cancelar.Enabled   = .F.
1759:             THIS.cmd_4c_TotLinha.Enabled   = .F.
1760:             THIS.cmd_4c_Pedras.Enabled     = .F.
1761:             THIS.cmd_4c_Disponivel.Enabled = .F.
1762:             THIS.grd_4c_Dados.Enabled      = .F.
1763:             THIS.cnt_4c_Container3.Enabled = .F.
1764:             THIS.cnt_4c_Container4.Visible = .T.
1765:             THIS.cnt_4c_Container4.ZOrder
1766:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
1767:             THIS.cnt_4c_Container4.grd_4c_Dados.Column1.SetFocus
1768:         CATCH TO loc_oErro
1769:             MsgErro(loc_oErro.Message, "Erro")
1770:         ENDTRY
1771:     ENDPROC
1772: 
1773:     PROCEDURE BtnSelEstoqueClick
1774:         LOCAL loc_cCpro, loc_cCor, loc_cTam
1775: 
1776:         TRY
1777:             IF USED("TmpFinal")
1778:                 loc_cCpro = TmpFinal.Cpros
1779:                 loc_cCor  = TmpFinal.CodCors
1780:                 loc_cTam  = TmpFinal.CodTams
1781: 
1782:                 IF USED("TmpDisp")
1783:                     THIS.cnt_4c_Container5.grd_4c_Dados.RecordSource = ""
1784:                     USE IN TmpDisp
1785:                 ENDIF
1786: 
1787:                 SELECT Priors, Grupos, Estos, Cpros, CodCors, CodTams, Disps, ;
1788:                        000000000.000 AS Utilizar ;
1789:                   FROM TmpSaldG ;
1790:                  WHERE Cpros = m.loc_cCpro AND CodCors = m.loc_cCor AND CodTams = m.loc_cTam AND Disps > 0 ;
1791:                   INTO CURSOR Resultado ORDER BY 1, 2, 3, 4
1792:                 SELECT 0
1793:                 USE DBF("Resultado") ALIAS TmpDisp AGAIN
1794:                 USE IN Resultado
1795: 
1796:                 THIS.grd_4c_Dados.Enabled = .F.
1797: 
1798:                 IF _Tally = 0
1799:                     MsgAviso("N" + CHR(227) + "o existe Estoque Dispon" + CHR(237) + "vel !!!", "")
1800:                     THIS.BtnCancelaDisp5Click()
1801:                 ELSE
1802:                     WITH THIS.cnt_4c_Container5.grd_4c_Dados
1803:                         .RecordSource = "TmpDisp"
1804:                         .Column1.ControlSource = "TmpDisp.Grupos"
1805:                         .Column2.ControlSource = "TmpDisp.Estos"
1806:                         .Column3.ControlSource = "TmpDisp.Priors"
1807:                         .Column4.ControlSource = "TmpDisp.Disps"
1808:                         .Column5.ControlSource = "TmpDisp.Utilizar"
1809:                     ENDWITH
1810: 
1811:                     WITH THIS.cnt_4c_Container5
1812:                         .lbl_4c_Label1.Caption = "Estoque Dispon" + CHR(237) + "vel (" + ;
1813:                                                  ALLTRIM(loc_cCpro) + " " + ALLTRIM(loc_cCor) + ;
1814:                                                  "/" + ALLTRIM(loc_cTam) + ")"
1815:                         .txt_4c_Qt_pedida.Value = TmpFinal.Saldo - TmpFinal.Estoque
1816:                         .txt_4c_Qt_Selec.Value  = 0
1817:                         .Visible     = .T.
1818:                     ENDWITH
1819: 
1820:                     THIS.cmd_4c_Processar.Enabled  = .F.
1821:                     THIS.cmd_4c_Cancelar.Enabled   = .F.
1822:                     THIS.cmd_4c_TotLinha.Enabled   = .F.
1823:                     THIS.cmd_4c_Disponivel.Enabled = .F.
1824:                     THIS.cmd_4c_SelEstoque.Enabled = .F.
1825:                     THIS.cmd_4c_Pedras.Enabled     = .F.
1826:                     THIS.cnt_4c_Container3.Enabled = .F.
1827:                     THIS.cnt_4c_Container5.Visible = .T.
1828:                     THIS.cnt_4c_Container5.ZOrder
1829:                     THIS.cnt_4c_Container5.grd_4c_Dados.Refresh
1830:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.SetFocus
1831:                 ENDIF
1832:             ENDIF
1833:         CATCH TO loc_oErro
1834:             MsgErro(loc_oErro.Message, "Erro")
1835:         ENDTRY
1836:     ENDPROC
1837: 
1838:     PROCEDURE BtnCancelarClick
1839:         TRY
1840:             IF VARTYPE(THIS.poFormPai) = "O"
1841:                 THIS.poFormPai.Enabled = .T.
1842:             ENDIF
1843:             THIS.Release
1844:         CATCH TO loc_oErro
1845:             MsgErro(loc_oErro.Message, "Erro")
1846:         ENDTRY
1847:     ENDPROC
1848: 
1849:     PROCEDURE BtnProcessarClick
1850:         LOCAL loc_dPrevisao, loc_dGeracao, loc_lSucesso
1851: 
1852:         loc_dPrevisao = DATE()
1853:         loc_dGeracao  = THIS.this_dData
1854:         loc_lSucesso  = .F.
1855: 
1856:         TRY
1857:             *-- Tentar obter datas do formulario pai/av?
1858:             IF VARTYPE(THIS.poFormPai) = "O"
1859:                 TRY
1860:                     IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
1861:                         loc_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
1862:                         loc_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
1863:                     ENDIF
1864:                 CATCH
1865:                 ENDTRY
1866:             ENDIF
1867: 
1868:             WITH THIS.this_oBusinessObject
1869:                 .this_lReserva    = THIS.this_lReserva
1870:                 .this_lAutomatico = THIS.this_lAutomatico
1871:                 .this_nNumeroDaOp = THIS.this_nNumeroDaOp
1872:                 .this_dPrevisao   = loc_dPrevisao
1873:                 .this_dGeracao    = loc_dGeracao
1874:             ENDWITH
1875: 
1876:             loc_lSucesso = THIS.this_oBusinessObject.Processar(loc_dPrevisao, loc_dGeracao)
1877: 
1878:             IF loc_lSucesso
1879:                 MsgInfo("Processamento conclu" + CHR(237) + "do com sucesso!", "Informa" + CHR(231) + CHR(227) + "o")
1880:                 IF VARTYPE(THIS.poFormPai) = "O"
1881:                     THIS.poFormPai.Enabled = .T.
1882:                 ENDIF
1883:                 THIS.Release
1884:             ENDIF
1885:         CATCH TO loc_oErro
1886:             MsgErro(loc_oErro.Message, "Erro")
1887:         ENDTRY
1888:     ENDPROC
1889: 
1890:     PROCEDURE BtnRelatorioClick
1891:         TRY
1892:             IF THIS.this_oBusinessObject.GerarRelatorio()
1893:                 THIS.ExecutarReportForm("SigPrGlp", "PRINTER_PROMPT", "crImpressao")
1894:             ENDIF
1895:         CATCH TO loc_oErro
1896:             MsgErro(loc_oErro.Message, "Erro")
1897:         ENDTRY
1898:     ENDPROC
1899: 
1900:     *==========================================================================
1901:     * HANDLERS DE EVENTOS DOS CONTAINERS OVERLAY
1902:     *==========================================================================
1903: 
1904:     PROCEDURE BtnCancelaLin1Click
1905:         WITH THIS
1906:             .cmd_4c_Processar.Enabled  = .T.
1907:             .cmd_4c_Cancelar.Enabled   = .T.
1908:             .cmd_4c_Pedras.Enabled     = .T.
1909:             .cmd_4c_TotLinha.Enabled   = .T.
1910:             .cmd_4c_Disponivel.Enabled = .T.
1911:             .cnt_4c_Container1.Visible = .F.
1912:             .cnt_4c_Container3.Enabled = .T.
1913:             .grd_4c_Dados.Enabled      = .T.
1914:             .grd_4c_Dados.ZOrder
1915:             .grd_4c_Dados.Refresh
1916:             .grd_4c_Dados.Column6.SetFocus
1917:         ENDWITH
1918:     ENDPROC
1919: 
1920:     PROCEDURE BtnCancelaDisp2Click
1921:         LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
1922:         LOCAL loc_lSucesso
1923:         loc_lSucesso = .F.
1924: 
1925:         TRY
1926:             IF USED("TmpDisp") AND USED("TmpFinal")
1927:                 SELECT TmpDisp
1928:                 SUM Utilizar TO loc_nQtdUtil
1929: 
1930:                 IF loc_nQtdUtil > 0
1931:                     SELECT TmpDisp
1932:                     SCAN
1933:                         IF Utilizar = 0
1934:                             LOOP
1935:                         ENDIF
1936:                         loc_nQtUtil = Utilizar
1937:                         =SEEK(TmpDisp.CPros + TmpDisp.CodCors + TmpDisp.CodTams, "TmpSaldo")
1938:                         SELECT TmpFinal
1939:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
1940:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
1941: 
1942:                         SELECT TmpSaldo
1943:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
1944: 
1945:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
1946:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
1947:                         ENDIF
1948:                         REPLACE KeySelm WITH .T. IN TmpSaldU
1949: 
1950:                         SELECT TmpSaldG
1951:                         SET ORDER TO Cpros
1952:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
1953:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
1954: 
1955:                         SELECT TmpDisp
1956:                     ENDSCAN
1957:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
1958:                 ENDIF
1959:                 loc_lSucesso = .T.
1960:             ENDIF

*-- Linhas 1967 a 2105:
1967:             .cmd_4c_Cancelar.Enabled   = .T.
1968:             .cmd_4c_TotLinha.Enabled   = .T.
1969:             .cmd_4c_SelEstoque.Enabled = .T.
1970:             .cmd_4c_Pedras.Enabled     = .T.
1971:             .cmd_4c_Disponivel.Enabled = .T.
1972:             .cnt_4c_Container3.Enabled = .T.
1973:             .cnt_4c_Container2.Visible = .F.
1974:             .grd_4c_Dados.Enabled      = .T.
1975:             .grd_4c_Dados.ZOrder
1976:             .grd_4c_Dados.Refresh
1977:             .grd_4c_Dados.Column6.SetFocus
1978:         ENDWITH
1979:     ENDPROC
1980: 
1981:     PROCEDURE BtnCancelaDisp4Click
1982:         WITH THIS
1983:             .cmd_4c_Processar.Enabled  = .T.
1984:             .cmd_4c_Cancelar.Enabled   = .T.
1985:             .cmd_4c_TotLinha.Enabled   = .T.
1986:             .cmd_4c_Pedras.Enabled     = .T.
1987:             .cmd_4c_Disponivel.Enabled = .T.
1988:             .cnt_4c_Container3.Enabled = .T.
1989:             .cnt_4c_Container4.Visible = .F.
1990:             .grd_4c_Dados.Enabled      = .T.
1991:             .grd_4c_Dados.ZOrder
1992:             .grd_4c_Dados.Refresh
1993:             .grd_4c_Dados.Column6.SetFocus
1994:         ENDWITH
1995:     ENDPROC
1996: 
1997:     PROCEDURE BtnCancelaDisp5Click
1998:         LOCAL loc_nQtdUtil, loc_nQtUtil, loc_xBaixa
1999: 
2000:         TRY
2001:             IF USED("TmpDisp") AND USED("TmpFinal")
2002:                 SELECT TmpDisp
2003:                 SUM Utilizar TO loc_nQtdUtil
2004: 
2005:                 IF loc_nQtdUtil > 0
2006:                     SELECT TmpDisp
2007:                     SCAN
2008:                         IF Utilizar = 0
2009:                             LOOP
2010:                         ENDIF
2011:                         loc_nQtUtil = Utilizar
2012:                         =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2013: 
2014:                         SELECT TmpFinal
2015:                         REPLACE Produzir WITH TmpFinal.Produzir - m.loc_nQtUtil
2016:                         REPLACE Estoque  WITH TmpFinal.Saldo - TmpFinal.Produzir
2017: 
2018:                         SELECT TmpSaldo
2019:                         REPLACE TmpSaldo.Disps WITH TmpSaldo.Disps - m.loc_nQtUtil
2020: 
2021:                         IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2022:                             INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2023:                         ENDIF
2024:                         REPLACE KeySelm WITH .T. IN TmpSaldU
2025: 
2026:                         SELECT TmpSaldG
2027:                         SET ORDER TO Cpros
2028:                         =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams + STR(TmpDisp.Priors, 2) + TmpDisp.Grupos + TmpDisp.Estos)
2029:                         REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_nQtUtil
2030: 
2031:                         SELECT TmpDisp
2032:                     ENDSCAN
2033:                     =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2034:                 ENDIF
2035:             ENDIF
2036:         CATCH TO loc_oErro
2037:             MsgErro(loc_oErro.Message, "Erro")
2038:         ENDTRY
2039: 
2040:         WITH THIS
2041:             .cmd_4c_Processar.Enabled  = .T.
2042:             .cmd_4c_Cancelar.Enabled   = .T.
2043:             .cmd_4c_TotLinha.Enabled   = .T.
2044:             .cmd_4c_Disponivel.Enabled = .T.
2045:             .cmd_4c_SelEstoque.Enabled = .T.
2046:             .cmd_4c_Pedras.Enabled     = .T.
2047:             .cnt_4c_Container3.Enabled = .T.
2048:             .cnt_4c_Container5.Visible = .F.
2049:             .grd_4c_Dados.Enabled      = .T.
2050:             .grd_4c_Dados.ZOrder
2051:             .grd_4c_Dados.Refresh
2052:             .grd_4c_Dados.Column6.SetFocus
2053:         ENDWITH
2054:     ENDPROC
2055: 
2056:     *==========================================================================
2057:     * HANDLERS DE EVENTOS DO GRID PRINCIPAL (GradeItens)
2058:     *==========================================================================
2059: 
2060:     PROCEDURE GradeItensAfterRowColChange
2061:         LPARAMETERS par_nColIndex
2062:         LOCAL loc_cSQL, loc_lcArquivo, loc_lcFoto, loc_nSal, loc_nEst, loc_nPrz
2063: 
2064:         TRY
2065:             IF !USED("TmpFinal") OR EOF("TmpFinal")
2066:                 RETURN
2067:             ENDIF
2068: 
2069:             THIS.obj_4c_ObsItens.Refresh
2070:             THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item " + ALLTRIM(TmpFinal.CPros)
2071: 
2072:             =SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo")
2073: 
2074:             SELECT TmpSaldG
2075:             SET ORDER TO Cpros
2076:             SET KEY TO TmpFinal.Cpros + TmpFinal.CodCors + TmpFinal.CodTams
2077:             GO TOP
2078: 
2079:             WITH THIS.cnt_4c_Container3
2080:                 IF USED("TmpSaldo") AND !EOF("TmpSaldo")
2081:                     .txt_4c_Tot_Qtd.Value = TmpSaldo.Saldo
2082:                     .txt_4c_Tot_Est.Value = TmpSaldo.Saldo - TmpSaldo.Disps
2083:                     .txt_4c_Tot_Prz.Value = TmpSaldo.Disps
2084:                 ENDIF
2085: 
2086:                 .lbl_4c_Label1.Caption = ALLTRIM(TmpFinal.Cpros) + ;
2087:                     IIF(!EMPTY(TmpFinal.CodCors), " Cor:" + TmpFinal.CodCors, "") + ;
2088:                     IIF(!EMPTY(TmpFinal.CodTams), " Tam:" + TmpFinal.CodTams, "")
2089: 
2090:                 .grd_4c_Dados.Refresh
2091:                 .Visible     = .T.
2092:             ENDWITH
2093: 
2094:             *-- Foto do produto
2095:             loc_cSQL = "SELECT TOP 1 FigJpgs FROM SigCdPro WHERE CPros = '" + ;
2096:                        ALLTRIM(TmpFinal.CPros) + "'"
2097:             IF SQLEXEC(gnConnHandle, loc_cSQL, "xTmpProFig") > 0
2098:                 CLEAR RESOURCES
2099:                 THIS.img_4c_ImgFigJpg.Picture = ""
2100:                 THIS.img_4c_ImgFigJpg.Visible = .F.
2101: 
2102:                 IF !EMPTY(xTmpProFig.FigJpgs) AND !ISNULL(xTmpProFig.FigJpgs)
2103:                     loc_lcFoto = STRCONV(STRTRAN(STRTRAN(STRTRAN(xTmpProFig.FigJpgs, ;
2104:                                      "data:image/png;base64,", ""), ;
2105:                                      "data:image/jpeg;base64,", ""), ;

*-- Linhas 2121 a 2847:
2121:         ENDTRY
2122:     ENDPROC
2123: 
2124:     PROCEDURE GrdCol6TextWhen
2125:         LOCAL loc_lPermite
2126:         loc_lPermite = .T.
2127: 
2128:         TRY
2129:             IF USED("TmpFinal")
2130:                 THIS.this_nOldValue = THIS.grd_4c_Dados.Column6.Text1.Value
2131: 
2132:                 IF THIS.this_lReserva AND TmpFinal.Estoque = 0
2133:                     loc_cSQL = "SELECT TOP 1 CGrus FROM SigCdPro WHERE CPros = '" + ;
2134:                                ALLTRIM(TmpFinal.CPros) + "'"
2135:                     IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempPro") > 0
2136:                         loc_cSQL = "SELECT TOP 1 TipoEstos FROM SigCdGrp WHERE CGrus = '" + ;
2137:                                    ALLTRIM(xTempPro.CGrus) + "'"
2138:                         IF SQLEXEC(gnConnHandle, loc_cSQL, "xTempGru") > 0
2139:                             IF INLIST(xTempGru.TipoEstos, 3, 4)
2140:                                 THIS.cmd_4c_Disponivel.Enabled = .T.
2141:                             ENDIF
2142:                             IF USED("xTempGru")
2143:                                 USE IN xTempGru
2144:                             ENDIF
2145:                         ENDIF
2146:                         IF USED("xTempPro")
2147:                             USE IN xTempPro
2148:                         ENDIF
2149:                     ENDIF
2150:                 ENDIF
2151:             ENDIF
2152:         CATCH TO loc_oErro
2153:             MsgErro(loc_oErro.Message, "Erro")
2154:         ENDTRY
2155: 
2156:         RETURN loc_lPermite
2157:     ENDPROC
2158: 
2159:     PROCEDURE GrdCol6TextValid
2160:         LOCAL loc_lValido, loc_nNewValue, loc_nOld, loc_xBaixa
2161: 
2162:         loc_lValido  = .T.
2163:         loc_nNewValue = THIS.grd_4c_Dados.Column6.Text1.Value
2164:         loc_nOld      = THIS.this_nOldValue
2165: 
2166:         TRY
2167:             IF !USED("TmpFinal") OR !USED("TmpSaldo")
2168:                 loc_lResultado = .T.
2169:             ENDIF
2170: 
2171:             IF !SEEK(TmpFinal.Cpros, "TmpSaldU", "Cpros")
2172:                 INSERT INTO TmpSaldU (Cpros) VALUES (TmpFinal.Cpros)
2173:             ENDIF
2174: 
2175:             IF loc_nNewValue <> loc_nOld AND TmpSaldU.KeySelm
2176:                 IF MsgConfirma("Produto com Sele" + CHR(231) + CHR(227) + "o Manual de estoque. " + ;
2177:                                CHR(13) + "O sistema ir" + CHR(225) + " acionar o modo autom" + CHR(225) + "tico. Deseja Continuar?", "")
2178:                     *-- Continue
2179:                 ELSE
2180:                     THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2181:                     loc_lValido = .F.
2182:                 ENDIF
2183:             ENDIF
2184: 
2185:             IF loc_lValido
2186:                 DO CASE
2187:                     CASE loc_nNewValue = loc_nOld
2188:                         *-- nada a fazer
2189:                     CASE loc_nNewValue < 0
2190:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Um Valor Negativo!!!", "")
2191:                         THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2192:                     CASE loc_nNewValue > TmpFinal.Saldo
2193:                         MsgAviso("A Quantidade a Produzir N" + CHR(227) + "o Pode Ser Maior Que a Quantidade Da Opera" + CHR(231) + CHR(227) + "o!!!", "")
2194:                         THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo - TmpFinal.Estoque
2195:                     CASE !SEEK(TmpFinal.CPros + TmpFinal.CodCors + TmpFinal.CodTams, "TmpSaldo") AND ;
2196:                          TmpFinal.Produzir <> TmpFinal.Saldo
2197:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
2198:                         THIS.grd_4c_Dados.Column6.Text1.Value = TmpFinal.Saldo
2199:                     OTHERWISE
2200:                         IF TmpSaldo.Disps + TmpFinal.Estoque >= TmpFinal.Saldo - loc_nNewValue
2201:                             REPLACE TmpSaldo.Disps   WITH TmpSaldo.Disps + TmpFinal.Estoque - (TmpFinal.Saldo - TmpFinal.Produzir) IN TmpSaldo
2202:                             REPLACE TmpFinal.Estoque WITH TmpFinal.Saldo - loc_nNewValue IN TmpFinal
2203:                             REPLACE KeySelm WITH .F. IN TmpSaldU
2204: 
2205:                             SELECT TmpSaldo
2206:                             loc_xBaixa = Saldo - Disps
2207:                             SELECT TmpSaldG
2208:                             SET ORDER TO Cpros
2209:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2210:                             REPLACE Disps WITH Saldo WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams
2211:                             =SEEK(TmpSaldo.Cpros + TmpSaldo.CodCors + TmpSaldo.CodTams)
2212:                             SCAN WHILE Cpros = TmpSaldo.Cpros AND CodCors = TmpSaldo.CodCors AND CodTams = TmpSaldo.CodTams AND m.loc_xBaixa > 0
2213:                                 IF TmpSaldG.Disps >= m.loc_xBaixa
2214:                                     REPLACE TmpSaldG.Disps WITH TmpSaldG.Disps - m.loc_xBaixa
2215:                                     m.loc_xBaixa = 0
2216:                                 ELSE
2217:                                     m.loc_xBaixa = m.loc_xBaixa - TmpSaldG.Disps
2218:                                     REPLACE TmpSaldG.Disps WITH 0
2219:                                 ENDIF
2220:                             ENDSCAN
2221:                         ELSE
2222:                             MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Saldo Dispon" + CHR(237) + "vel Deste Produto No Estoque Para Reservar!!!", "")
2223:                             THIS.grd_4c_Dados.Column6.Text1.Value = loc_nOld
2224:                         ENDIF
2225:                 ENDCASE
2226:             ENDIF
2227:         CATCH TO loc_oErro
2228:             MsgErro(loc_oErro.Message, "Erro")
2229:         ENDTRY
2230: 
2231:         RETURN loc_lValido
2232:     ENDPROC
2233: 
2234:     PROCEDURE GrdCol6TextLostFocus
2235:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2236:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz
2237: 
2238:         TRY
2239:             IF USED("TmpFinal")
2240:                 SELECT TmpFinal
2241:                 loc_nRecno = RECNO()
2242:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2243:                 GO loc_nRecno
2244:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2245:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2246:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2247:                 THIS.txt_4c_Tot_Qtd.Refresh
2248:                 THIS.txt_4c_Tot_Est.Refresh
2249:                 THIS.txt_4c_Tot_Prz.Refresh
2250:                 THIS.Refresh
2251:             ENDIF
2252:         CATCH TO loc_oErro
2253:             MsgErro(loc_oErro.Message, "Erro")
2254:         ENDTRY
2255:     ENDPROC
2256: 
2257:     *==========================================================================
2258:     * HANDLERS DOS GRIDS DE CONTAINERS OVERLAY
2259:     *==========================================================================
2260: 
2261:     PROCEDURE Cnt5GradeAfterRowColChange
2262:         LPARAMETERS par_nColIndex
2263:         LOCAL loc_cSQL
2264: 
2265:         *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
2266:     ENDPROC
2267: 
2268:     PROCEDURE Cnt5Col5TextValid
2269:         LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno
2270: 
2271:         loc_lValido = .T.
2272: 
2273:         TRY
2274:             loc_nVal = THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value
2275: 
2276:             IF loc_nVal > TmpDisp.Disps
2277:                 MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser maior que Qtde Disponivel...", "")
2278:                 THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2279:                 THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2280:                 loc_lValido = .F.
2281:             ELSE
2282:                 IF loc_nVal < 0
2283:                     MsgAviso("A quantidade a utilizar n" + CHR(227) + "o pode ser menor que zero ...", "")
2284:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2285:                     THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2286:                     loc_lValido = .F.
2287:                 ELSE
2288:                     loc_nRecno = RECNO("TmpDisp")
2289:                     SUM TmpDisp.Utilizar TO loc_nQtdUtil
2290:                     GO loc_nRecno IN TmpDisp
2291:                     IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo - TmpFinal.Estoque
2292:                         MsgAviso("Qtde Selecionada n" + CHR(227) + "o pode ser maior que Qtde Solicitada...", "")
2293:                         THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Value = 0
2294:                         THIS.cnt_4c_Container5.grd_4c_Dados.Column5.Text1.Refresh
2295:                         loc_lValido = .F.
2296:                     ELSE
2297:                         THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Value = loc_nQtdUtil
2298:                         THIS.cnt_4c_Container5.txt_4c_Qt_Selec.Refresh
2299:                     ENDIF
2300:                 ENDIF
2301:             ENDIF
2302:         CATCH TO loc_oErro
2303:             MsgErro(loc_oErro.Message, "Erro")
2304:         ENDTRY
2305: 
2306:         RETURN loc_lValido
2307:     ENDPROC
2308: 
2309:     PROCEDURE Cnt2Col5TextValid
2310:         LOCAL loc_lValido, loc_nVal, loc_nQtdUtil, loc_nRecno
2311: 
2312:         loc_lValido = .T.
2313: 
2314:         TRY
2315:             loc_nVal = THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value
2316: 
2317:             IF loc_nVal > TmpDisp.Disps
2318:                 MsgAviso("A Qtde. a Utilizar N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Disponivel!!!", "")
2319:                 THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
2320:                 THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
2321:                 loc_lValido = .F.
2322:             ELSE
2323:                 loc_nRecno = RECNO("TmpDisp")
2324:                 SUM TmpDisp.Utilizar TO loc_nQtdUtil
2325:                 GO loc_nRecno IN TmpDisp
2326:                 IF USED("TmpFinal") AND loc_nQtdUtil > TmpFinal.Saldo
2327:                     MsgAviso("A Qtde. Selecionada N" + CHR(227) + "o Pode Ser Maior Que a Qtde. Pedida!!!", "")
2328:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Value = 0
2329:                     THIS.cnt_4c_Container2.grd_4c_Dados.Column5.Text1.Refresh
2330:                     loc_lValido = .F.
2331:                 ELSE
2332:                     THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Value = loc_nQtdUtil
2333:                     THIS.cnt_4c_Container2.txt_4c_Qt_Selec.Refresh
2334:                 ENDIF
2335:             ENDIF
2336:         CATCH TO loc_oErro
2337:             MsgErro(loc_oErro.Message, "Erro")
2338:         ENDTRY
2339: 
2340:         RETURN loc_lValido
2341:     ENDPROC
2342: 
2343:     PROCEDURE Cnt4Col1TextValid
2344:         LOCAL loc_lValido, loc_cVal, loc_cSQL
2345: 
2346:         loc_lValido = .T.
2347: 
2348:         TRY
2349:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2350:             IF !EMPTY(loc_cVal)
2351:                 loc_cSQL = "SELECT TOP 1 CPros, DPros, Cunis FROM SigCdPro WHERE CPros = '" + ;
2352:                            EscaparSQL(loc_cVal)
2353:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaRemota") > 0 AND RECCOUNT("crListaRemota") > 0
2354:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2355:                     REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2356:                             SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2357:                 ELSE
2358:                     *-- Abrir picker (FormBuscaAuxiliar)
2359:                     DO FormBuscaAuxiliar WITH gnConnHandle, "SigCdPro", "crListaRemota", "CPros", ;
2360:                                              loc_cVal, "Sele" + CHR(231) + CHR(227) + "o", 1000, ;
2361:                                              "CPros", "DPros"
2362:                     IF USED("crListaRemota") AND RECCOUNT("crListaRemota") > 0
2363:                         THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value = crListaRemota.CPros
2364:                         REPLACE SelPedra.Dpros WITH crListaRemota.DPros, ;
2365:                                 SelPedra.Cunis WITH crListaRemota.Cunis IN SelPedra
2366:                     ENDIF
2367:                 ENDIF
2368:                 IF USED("crListaRemota")
2369:                     USE IN crListaRemota
2370:                 ENDIF
2371:                 THIS.cnt_4c_Container4.grd_4c_Dados.Refresh
2372:             ENDIF
2373:         CATCH TO loc_oErro
2374:             MsgErro(loc_oErro.Message, "Erro")
2375:         ENDTRY
2376: 
2377:         RETURN loc_lValido
2378:     ENDPROC
2379: 
2380:     *==========================================================================
2381:     PROCEDURE GrdColXGotFocus
2382:     *==========================================================================
2383:         IF VARTYPE(THIS.grd_4c_Dados) = "O" AND VARTYPE(THIS.grd_4c_Dados.Column6) = "O"
2384:             THIS.grd_4c_Dados.Column6.Text1.SetFocus()
2385:         ENDIF
2386:     ENDPROC
2387: 
2388:     *==========================================================================
2389:     PROCEDURE Cnt2GrdColXGotFocus
2390:     *==========================================================================
2391:         LOCAL loc_oGrd
2392:         loc_oGrd = THIS.cnt_4c_Container2.grd_4c_Dados
2393:         IF VARTYPE(loc_oGrd) = "O" AND VARTYPE(loc_oGrd.Column5) = "O"
2394:             loc_oGrd.Column5.Text1.SetFocus()
2395:         ENDIF
2396:     ENDPROC
2397: 
2398:     *==========================================================================
2399:     PROCEDURE Cnt4Col4TextWhen
2400:     *==========================================================================
2401:         RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2402:     ENDPROC
2403: 
2404:     *==========================================================================
2405:     PROCEDURE Cnt4Col5TextWhen
2406:     *==========================================================================
2407:         RETURN !EMPTY(THIS.cnt_4c_Container4.grd_4c_Dados.Column1.Text1.Value)
2408:     ENDPROC
2409: 
2410:     *==========================================================================
2411:     PROCEDURE Cnt4Col5TextValid
2412:     *==========================================================================
2413:         LOCAL loc_lValido, loc_cVal, loc_cSQL, loc_oBusca
2414:         loc_lValido = .T.
2415: 
2416:         TRY
2417:             loc_cVal = ALLTRIM(THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value)
2418:             IF !EMPTY(loc_cVal)
2419:                 loc_cSQL = "SELECT TOP 1 CPros, DPros FROM SigCdPro WHERE CPros = " + ;
2420:                            EscaparSQL(loc_cVal)
2421:                 IF SQLEXEC(gnConnHandle, loc_cSQL, "crListaPro2") > 0 AND RECCOUNT("crListaPro2") > 0
2422:                     THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2423:                     REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2424:                 ELSE
2425:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdPro", ;
2426:                                              "crListaPro2", "CPros", loc_cVal, ;
2427:                                              "Produto Substituto")
2428:                     IF VARTYPE(loc_oBusca) = "O"
2429:                         loc_oBusca.mAddColuna("CPros", "C" + CHR(243) + "digo", 80)
2430:                         loc_oBusca.mAddColuna("DPros", "Descri" + CHR(231) + CHR(227) + "o", 300)
2431:                         loc_oBusca.Show()
2432:                         IF loc_oBusca.this_lSelecionou AND USED("crListaPro2") AND RECCOUNT("crListaPro2") > 0
2433:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = crListaPro2.CPros
2434:                             REPLACE SelPedra.Cpro2s WITH crListaPro2.CPros IN SelPedra
2435:                         ELSE
2436:                             THIS.cnt_4c_Container4.grd_4c_Dados.Column5.Text1.Value = ""
2437:                             REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
2438:                         ENDIF
2439:                         loc_oBusca = .NULL.
2440:                     ENDIF
2441:                 ENDIF
2442:                 IF USED("crListaPro2")
2443:                     USE IN crListaPro2
2444:                 ENDIF
2445:             ELSE
2446:                 REPLACE SelPedra.Cpro2s WITH "" IN SelPedra
2447:             ENDIF
2448:             THIS.cnt_4c_Container4.grd_4c_Dados.Refresh()
2449:         CATCH TO loc_oErro
2450:             MsgErro(loc_oErro.Message, "Erro")
2451:         ENDTRY
2452: 
2453:         RETURN loc_lValido
2454:     ENDPROC
2455: 
2456:     *==========================================================================
2457:     * Cnt3GradeAfterRowColChange - Atualiza descricoes de grupo/conta ao mudar
2458:     * de linha no grid de saldo (Container3.grd_4c_Dados / TmpSaldG)
2459:     *==========================================================================
2460:     PROCEDURE Cnt3GradeAfterRowColChange
2461:         LPARAMETERS par_nColIndex
2462:         LOCAL loc_cSQL
2463: 
2464:         *-- Lookups removidos (Iclis/SigCdCli e Codigos/SigCdGcr nao existem no legado original)
2465:     ENDPROC
2466: 
2467:     *==========================================================================
2468:     * ExecutarReportForm - Helper canonico REPORT FORM com guard FILE()
2469:     * e isolamento SET POINT/SEPARATOR/REPORTBEHAVIOR 80
2470:     * par_cRelatorioBase : nome base do FRX (sem path, sem extensao)
2471:     * par_cModo          : "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
2472:     * par_cCursorDados   : alias do cursor de dados (opcional - verifica se vazio)
2473:     *==========================================================================
2474:     PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
2475:         LOCAL loc_cArqFrx, loc_cOldPoint, loc_cOldSep, loc_oErro
2476: 
2477:         par_cRelatorioBase = STRTRAN(UPPER(par_cRelatorioBase), ".FRX", "")
2478:         loc_cArqFrx = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")
2479: 
2480:         IF !FILE(loc_cArqFrx)
2481:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
2482:                     loc_cArqFrx, "Relat" + CHR(243) + "rio")
2483:             RETURN
2484:         ENDIF
2485: 
2486:         IF !EMPTY(par_cCursorDados)
2487:             IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
2488:                 MsgAviso("Nenhum dado para exibir.")
2489:                 RETURN
2490:             ENDIF
2491:         ENDIF
2492: 
2493:         loc_cOldPoint = SET("POINT")
2494:         loc_cOldSep   = SET("SEPARATOR")
2495: 
2496:         TRY
2497:             SET POINT TO "."
2498:             SET SEPARATOR TO ","
2499:             SET REPORTBEHAVIOR 80
2500:             DO CASE
2501:                 CASE par_cModo = "PREVIEW"
2502:                     REPORT FORM (loc_cArqFrx) PREVIEW
2503:                 CASE par_cModo = "PRINTER_PROMPT"
2504:                     REPORT FORM (loc_cArqFrx) TO PRINTER PROMPT
2505:                 CASE par_cModo = "PRINTER"
2506:                     REPORT FORM (loc_cArqFrx) TO PRINTER
2507:                 OTHERWISE
2508:                     REPORT FORM (loc_cArqFrx) PREVIEW
2509:             ENDCASE
2510:         CATCH TO loc_oErro
2511:             MsgErro("Erro relat" + CHR(243) + "rio: " + loc_oErro.Message, "Relat" + CHR(243) + "rio")
2512:         ENDTRY
2513: 
2514:         SET POINT TO (loc_cOldPoint)
2515:         SET SEPARATOR TO (loc_cOldSep)
2516:     ENDPROC
2517: 
2518:     *==========================================================================
2519:     * EVENTOS PRINCIPAIS (CRUD-nomeados) - Form OPERACIONAL "Previa da Globalizacao"
2520:     * Este form nao possui botoes CRUD literais (Incluir/Alterar/Visualizar/Excluir),
2521:     * mas os handlers sao expostos como aliases das acoes operacionais equivalentes
2522:     * para uso por integradores externos (menus, chamadas automatizadas, testes).
2523:     *==========================================================================
2524: 
2525:     PROCEDURE BtnIncluirClick
2526:         *-- INCLUIR (novo processamento): executa Processar (fluxo principal)
2527:         TRY
2528:             THIS.BtnProcessarClick()
2529:         CATCH TO loc_oErro
2530:             MsgErro(loc_oErro.Message, "Erro")
2531:         ENDTRY
2532:     ENDPROC
2533: 
2534:     PROCEDURE BtnAlterarClick
2535:         *-- ALTERAR (recalcular totais da grade principal a partir de TmpFinal)
2536:         LOCAL loc_nRecno, loc_nSal, loc_nEst, loc_nPrz, loc_oErro
2537: 
2538:         TRY
2539:             IF USED("TmpFinal")
2540:                 SELECT TmpFinal
2541:                 loc_nRecno = RECNO()
2542:                 loc_nSal = 0
2543:                 loc_nEst = 0
2544:                 loc_nPrz = 0
2545:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2546:                 IF loc_nRecno <= RECCOUNT("TmpFinal") AND loc_nRecno > 0
2547:                     GO loc_nRecno IN TmpFinal
2548:                 ENDIF
2549: 
2550:                 IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2551:                     THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2552:                     THIS.txt_4c_Tot_Qtd.Refresh()
2553:                 ENDIF
2554:                 IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2555:                     THIS.txt_4c_Tot_Est.Value = loc_nEst
2556:                     THIS.txt_4c_Tot_Est.Refresh()
2557:                 ENDIF
2558:                 IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
2559:                     THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2560:                     THIS.txt_4c_Tot_Prz.Refresh()
2561:                 ENDIF
2562:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
2563:                     THIS.grd_4c_Dados.Refresh()
2564:                 ENDIF
2565:                 THIS.Refresh()
2566:             ENDIF
2567:         CATCH TO loc_oErro
2568:             MsgErro(loc_oErro.Message, "Erro")
2569:         ENDTRY
2570:     ENDPROC
2571: 
2572:     PROCEDURE BtnVisualizarClick
2573:         *-- VISUALIZAR: emite o relatorio da previa (equivalente ao btnRelatorio)
2574:         TRY
2575:             THIS.BtnRelatorioClick()
2576:         CATCH TO loc_oErro
2577:             MsgErro(loc_oErro.Message, "Erro")
2578:         ENDTRY
2579:     ENDPROC
2580: 
2581:     PROCEDURE BtnExcluirClick
2582:         *-- EXCLUIR (cancelar processamento em andamento): rollback + release
2583:         TRY
2584:             IF MsgConfirma("Cancelar o processamento atual?", "Confirma" + CHR(231) + CHR(227) + "o")
2585:                 THIS.BtnCancelarClick()
2586:             ENDIF
2587:         CATCH TO loc_oErro
2588:             MsgErro(loc_oErro.Message, "Erro")
2589:         ENDTRY
2590:     ENDPROC
2591: 
2592:     *==========================================================================
2593:     * BtnBuscarClick - Rebusca / reexibe os dados atuais
2594:     * Para form OPERACIONAL sem filtros editaveis pelo usuario, "Buscar"
2595:     * equivale a atualizar os totais e o binding do grid principal a partir
2596:     * dos cursores TmpFinal/TmpSaldo/TmpSaldG ja carregados pelo form pai.
2597:     *==========================================================================
2598:     PROCEDURE BtnBuscarClick
2599:         TRY
2600:             THIS.CarregarDados()
2601:             IF USED("TmpFinal")
2602:                 LOCAL loc_nSal, loc_nEst, loc_nPrz
2603:                 loc_nSal = 0
2604:                 loc_nEst = 0
2605:                 loc_nPrz = 0
2606:                 SELECT TmpFinal
2607:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2608:                 GO TOP
2609:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2610:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2611:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2612:             ENDIF
2613:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2614:                 THIS.grd_4c_Dados.Refresh()
2615:             ENDIF
2616:         CATCH TO loc_oErro
2617:             MsgErro(loc_oErro.Message, "Erro")
2618:         ENDTRY
2619:     ENDPROC
2620: 
2621:     *==========================================================================
2622:     * BtnEncerrarClick - Encerra / fecha o form sem processar
2623:     * Equivalente ao botao Sair/Cancelar do legado.
2624:     *==========================================================================
2625:     PROCEDURE BtnEncerrarClick
2626:         TRY
2627:             IF VARTYPE(THIS.poFormPai) = "O"
2628:                 THIS.poFormPai.Enabled = .T.
2629:             ENDIF
2630:             THIS.Release
2631:         CATCH TO loc_oErro
2632:             MsgErro(loc_oErro.Message, "Erro")
2633:         ENDTRY
2634:     ENDPROC
2635: 
2636:     *==========================================================================
2637:     * BtnSalvarClick - Salva / confirma o processamento
2638:     * Para form OPERACIONAL "Previa da Globalizacao", salvar equivale a
2639:     * executar o processamento completo (botao Processar do legado).
2640:     *==========================================================================
2641:     PROCEDURE BtnSalvarClick
2642:         TRY
2643:             THIS.BtnProcessarClick()
2644:         CATCH TO loc_oErro
2645:             MsgErro(loc_oErro.Message, "Erro")
2646:         ENDTRY
2647:     ENDPROC
2648: 
2649:     *==========================================================================
2650:     * CarregarLista - Alias canonico para CarregarDados (compatibilidade FormBase)
2651:     * Forms CRUD chamam CarregarLista; em OPERACIONAL delega para CarregarDados.
2652:     *==========================================================================
2653:     PROCEDURE CarregarLista
2654:         TRY
2655:             THIS.CarregarDados()
2656:         CATCH TO loc_oErro
2657:             MsgErro(loc_oErro.Message, "Erro")
2658:         ENDTRY
2659:     ENDPROC
2660: 
2661:     *==========================================================================
2662:     * FormParaBO - Transfere estado do form para o BO
2663:     * Em form OPERACIONAL as propriedades relevantes sao flags de contexto
2664:     * (lReserva, lAutomatico, nNumeroDaOp) e datas obtidas do form pai.
2665:     *==========================================================================
2666:     PROCEDURE FormParaBO
2667:         TRY
2668:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2669:                 RETURN
2670:             ENDIF
2671:             WITH THIS.this_oBusinessObject
2672:                 .this_lReserva    = THIS.this_lReserva
2673:                 .this_lAutomatico = THIS.this_lAutomatico
2674:                 .this_nNumeroDaOp = THIS.this_nNumeroDaOp
2675:                 .this_nEmphPdr    = THIS.this_nEmphPdr
2676:                 .this_dData       = THIS.this_dData
2677: 
2678:                 *-- Datas de previsao/geracao obtidas do form avo (se existir)
2679:                 IF VARTYPE(THIS.poFormPai) = "O"
2680:                     TRY
2681:                         IF VARTYPE(THIS.poFormPai.poFormPai) = "O"
2682:                             .this_dPrevisao = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetPrevisao.Value
2683:                             .this_dGeracao  = THIS.poFormPai.poFormPai.cnt_4c_Previsao.txt_4c_GetGeracao.Value
2684:                         ENDIF
2685:                     CATCH
2686:                     ENDTRY
2687:                 ENDIF
2688:             ENDWITH
2689:         CATCH TO loc_oErro
2690:             MsgErro(loc_oErro.Message, "Erro")
2691:         ENDTRY
2692:     ENDPROC
2693: 
2694:     *==========================================================================
2695:     * BOParaForm - Atualiza o form com dados/estado do BO
2696:     * Em form OPERACIONAL rebinda grids e atualiza totais a partir dos
2697:     * cursores calculados pelo BO (TmpFinal/TmpSaldo/TmpSaldG).
2698:     *==========================================================================
2699:     PROCEDURE BOParaForm
2700:         LOCAL loc_nSal, loc_nEst, loc_nPrz
2701:         loc_nSal = 0
2702:         loc_nEst = 0
2703:         loc_nPrz = 0
2704: 
2705:         TRY
2706:             THIS.CarregarDados()
2707: 
2708:             IF USED("TmpFinal")
2709:                 SELECT TmpFinal
2710:                 SUM Saldo, Estoque, Produzir TO loc_nSal, loc_nEst, loc_nPrz
2711:                 GO TOP
2712:                 THIS.txt_4c_Tot_Qtd.Value = loc_nSal
2713:                 THIS.txt_4c_Tot_Est.Value = loc_nEst
2714:                 THIS.txt_4c_Tot_Prz.Value = loc_nPrz
2715:             ENDIF
2716: 
2717:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2718:                 THIS.grd_4c_Dados.Refresh()
2719:             ENDIF
2720:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2721:                 THIS.cnt_4c_Container3.Refresh()
2722:             ENDIF
2723:             THIS.Refresh()
2724:         CATCH TO loc_oErro
2725:             MsgErro(loc_oErro.Message, "Erro")
2726:         ENDTRY
2727:     ENDPROC
2728: 
2729:     *==========================================================================
2730:     * HabilitarCampos - Habilita ou desabilita controles conforme contexto
2731:     * par_lHabilitar : .T. = habilitar controles editaveis, .F. = somente leitura
2732:     * Para form OPERACIONAL o unico campo editavel pelo usuario e a coluna
2733:     * Produzir (Column6) do grid principal.
2734:     *==========================================================================
2735:     PROCEDURE HabilitarCampos(par_lHabilitar)
2736:         LOCAL loc_lHab
2737:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2738: 
2739:         TRY
2740:             *-- Coluna Produzir do grid principal
2741:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
2742:                 IF loc_lHab
2743:                     *-- Permitir edicao apenas se nao ha operacao TransfRes bloqueando
2744:                     IF USED("crSigCdPam")
2745:                         SELECT crSigCdPam
2746:                         IF EMPTY(crSigCdPam.TransfRes)
2747:                             THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2748:                         ELSE
2749:                             THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2750:                         ENDIF
2751:                     ELSE
2752:                         THIS.grd_4c_Dados.Column6.ReadOnly = .F.
2753:                     ENDIF
2754:                 ELSE
2755:                     THIS.grd_4c_Dados.SetAll("ReadOnly", .T.)
2756:                 ENDIF
2757:             ENDIF
2758: 
2759:             *-- Botoes de acao
2760:             THIS.AjustarBotoesPorModo()
2761:         CATCH TO loc_oErro
2762:             MsgErro(loc_oErro.Message, "Erro")
2763:         ENDTRY
2764:     ENDPROC
2765: 
2766:     *==========================================================================
2767:     * LimparCampos - Zera totais do form sem liberar cursores do form pai
2768:     * Em form OPERACIONAL os cursores pertencem ao form pai; este metodo
2769:     * apenas zera a exibicao de totais e limpa os overlays.
2770:     *==========================================================================
2771:     PROCEDURE LimparCampos
2772:         TRY
2773:             *-- Zerar totalizadores
2774:             IF VARTYPE(THIS.txt_4c_Tot_Qtd) = "O"
2775:                 THIS.txt_4c_Tot_Qtd.Value = 0
2776:             ENDIF
2777:             IF VARTYPE(THIS.txt_4c_Tot_Est) = "O"
2778:                 THIS.txt_4c_Tot_Est.Value = 0
2779:             ENDIF
2780:             IF VARTYPE(THIS.txt_4c_Tot_Prz) = "O"
2781:                 THIS.txt_4c_Tot_Prz.Value = 0
2782:             ENDIF
2783: 
2784:             *-- Zerar totalizadores do Container3 (saldo por grupo/conta)
2785:             IF VARTYPE(THIS.cnt_4c_Container3) = "O"
2786:                 THIS.cnt_4c_Container3.txt_4c_Tot_Qtd.Value = 0
2787:                 THIS.cnt_4c_Container3.txt_4c_Tot_Est.Value = 0
2788:                 THIS.cnt_4c_Container3.txt_4c_Tot_Prz.Value = 0
2789:                 THIS.cnt_4c_Container3.txt_4c__dgrupo.Value = ""
2790:                 THIS.cnt_4c_Container3.txt_4c__dconta.Value = ""
2791:             ENDIF
2792: 
2793:             *-- Limpar label de observacao
2794:             IF VARTYPE(THIS.lbl_4c_Txt_ObsItens) = "O"
2795:                 THIS.lbl_4c_Txt_ObsItens.Caption = "Observa" + CHR(231) + CHR(227) + "o do Item"
2796:             ENDIF
2797: 
2798:             *-- Ocultar overlays flutuantes
2799:             THIS.ConfigurarPaginaLista()
2800:         CATCH TO loc_oErro
2801:             MsgErro(loc_oErro.Message, "Erro")
2802:         ENDTRY
2803:     ENDPROC
2804: 
2805:     *==========================================================================
2806:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme contexto atual
2807:     * Em form OPERACIONAL o "modo" eh determinado pelo estado dos cursores:
2808:     *   - Sem TmpFinal    -> apenas Cancelar disponivel
2809:     *   - Com TmpFinal    -> todos os botoes operacionais disponiveis
2810:     *   - Overlay ativo   -> botoes principais desabilitados (gerenciado pelos
2811:     *                        handlers Btn*Click individuais)
2812:     *==========================================================================
2813:     PROCEDURE AjustarBotoesPorModo
2814:         LOCAL loc_lTemDados, loc_lPodeAcao
2815:         loc_lTemDados = .F.
2816:         loc_lPodeAcao = .F.
2817: 
2818:         TRY
2819:             *-- Verificar se ha dados carregados
2820:             IF USED("TmpFinal")
2821:                 loc_lTemDados = RECCOUNT("TmpFinal") > 0
2822:             ENDIF
2823: 
2824:             *-- Verificar se operacao de pedras/selecao de estoque esta disponivel
2825:             IF loc_lTemDados AND USED("crSigCdPam")
2826:                 SELECT crSigCdPam
2827:                 loc_lPodeAcao = !EMPTY(crSigCdPam.DopEmphs) AND ;
2828:                                 !EMPTY(crSigCdPam.DopReqcs) AND ;
2829:                                 !EMPTY(crSigCdPam.DopPedcs) AND ;
2830:                                 !EMPTY(crSigCdPam.DopComps) AND ;
2831:                                 !THIS.this_lReserva
2832:             ENDIF
2833: 
2834:             *-- Aplicar estado aos botoes
2835:             THIS.cmd_4c_Processar.Enabled    = loc_lTemDados
2836:             THIS.cmd_4c_Cancelar.Enabled     = .T.
2837:             THIS.cmd_4c_TotLinha.Enabled     = loc_lTemDados
2838:             THIS.cmd_4c_Disponivel.Enabled   = loc_lTemDados
2839:             THIS.cmd_4c_BtnRelatorio.Enabled = loc_lTemDados
2840:             THIS.cmd_4c_Pedras.Enabled       = loc_lPodeAcao
2841:             THIS.cmd_4c_SelEstoque.Enabled   = loc_lPodeAcao
2842:         CATCH TO loc_oErro
2843:             MsgErro(loc_oErro.Message, "Erro")
2844:         ENDTRY
2845:     ENDPROC
2846: 
2847: ENDDEFINE

