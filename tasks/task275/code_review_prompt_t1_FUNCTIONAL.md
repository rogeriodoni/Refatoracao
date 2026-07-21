# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (8)
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtCGrupoValid' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtCGrupoValidValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [LOSTFOCUS-SEM-GUARDIA] Handler 'TxtDGrupoValid' (via BINDEVENT LostFocus) abre janela de busca mas NAO verifica se o valor mudou. No legado, Valid so dispara quando o valor MUDA, mas LostFocus dispara SEMPRE. CORRIGIR: Adicionar propriedade this_cUltimoTxtDGrupoValidValidado e comparar no inicio do handler: IF loc_cValor == THIS.this_cUltimo... THEN RETURN. Atualizar apos validacao bem-sucedida.
- [GRID-HEADER] Header Caption 'Lote (Código)' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data/Hora' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Saída' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Qtd' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Número' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Empresa, Grupo, Conta, Código, Descrição, Cor, Tam, Estoque, Saldo, Distribuido, Local, Emp O, Movimentação, Emp D, Grupo Orig, Conta Orig, Grupo Dest, Conta Dest, Item, Uni, Quantidade, Unitário, Total. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdis.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1747 linhas total):

*-- Linhas 26 a 346:
26:     this_cCodigos        = ""
27: 
28:     *==========================================================================
29:     PROCEDURE Init()
30:     *==========================================================================
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *==========================================================================
35:     PROCEDURE Destroy()
36:     *==========================================================================
37:         LOCAL loc_aCursores[8], loc_i
38:         loc_aCursores[1] = "cursor_4c_Dados"
39:         loc_aCursores[2] = "cursor_4c_Estoques"
40:         loc_aCursores[3] = "cursor_4c_Disponivel"
41:         loc_aCursores[4] = "cursor_4c_Distribui"
42:         loc_aCursores[5] = "cursor_4c_CabOpera"
43:         loc_aCursores[6] = "cursor_4c_ItensOper"
44:         loc_aCursores[7] = "cursor_4c_LotePrDis"
45:         loc_aCursores[8] = "cursor_4c_Produto"
46:         FOR loc_i = 1 TO 8
47:             IF USED(loc_aCursores[loc_i])
48:                 USE IN (loc_aCursores[loc_i])
49:             ENDIF
50:         NEXT loc_i
51:         DODEFAULT()
52:     ENDPROC
53: 
54:     *==========================================================================
55:     PROTECTED PROCEDURE InicializarForm()
56:     *==========================================================================
57:         LOCAL loc_lSucesso, loc_oErro
58:         loc_lSucesso = .F.
59:         TRY
60:             SET DATE TO BRITISH
61:             SET CENTURY ON
62: 
63:             THIS.this_oBusinessObject = CREATEOBJECT("sigprdisBO")
64:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
65:                 MsgErro("Erro ao criar sigprdisBO.", "Erro InicializarForm")
66:             ELSE
67:                 *-- Placeholders para ControlSource em DataSession=2
68:                 *-- Fechados/substituidos pelos metodos do BO antes de cada SQLEXEC
69:                 SET NULL ON
70:                 CREATE CURSOR cursor_4c_Dados (Codigos C(20), Datas T)
71:                 CREATE CURSOR cursor_4c_Estoques ;
72:                     (nMarca N(1), cidchaves C(36), emps C(4), grupos C(10), contas C(15))
73:                 CREATE CURSOR cursor_4c_Disponivel ;
74:                     (cpros C(14), dpros C(65), codcors C(4), codtams C(4), ;
75:                      QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
76:                 CREATE CURSOR cursor_4c_Distribui ;
77:                     (emps C(4), grupos C(10), contas C(15), ;
78:                      QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
79:                 CREATE CURSOR cursor_4c_CabOpera ;
80:                     (emps C(4), dopes C(20), numes C(10), datas T, grupos C(10), empdopnums C(40))
81:                 CREATE CURSOR cursor_4c_ItensOper ;
82:                     (cpros C(14), codcors C(4), codtams C(4), qtds N(10,2), locals C(10))
83:                 SET NULL OFF
84: 
85:                 THIS.ConfigurarPageFrame()
86:                 THIS.ConfigurarCabecalho()
87:                 THIS.ConfigurarSaida()
88:                 THIS.ConfigurarPaginaLista()
89:                 THIS.ConfigurarPaginaDados()
90: 
91:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = ;
92:                     "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
93:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
94:                     "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
95: 
96:                 *-- Page1 BINDEVENTs
97:                 LOCAL loc_oPg1 AS Object
98:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
99:                 BINDEVENT(loc_oPg1.txt_4c_DtInicial, "LostFocus",     THIS, "TxtDtInicialValid")
100:                 BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "LostFocus",     THIS, "TxtDtFinalValid")
101:                 BINDEVENT(loc_oPg1.txt_4c_DtFinal,   "KeyPress", THIS, "TxtDtFinalLostFocus")
102:                 BINDEVENT(loc_oPg1.cmd_4c_Novo,       "Click",    THIS, "BtnNovoClick")
103:                 BINDEVENT(loc_oPg1.cmd_4c_Abrir,      "Click",    THIS, "BtnAbrirClick")
104:                 BINDEVENT(THIS.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
105: 
106:                 *-- Page2 BINDEVENTs
107:                 LOCAL loc_oPg2 AS Object
108:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
109:                 BINDEVENT(loc_oPg2.cmd_4c_VoltarLista, "Click", THIS, "BtnVoltarListaClick")
110: 
111:                 *-- Inner pageframe sub-page BINDEVENTs
112:                 LOCAL loc_oPf1 AS Object
113:                 loc_oPf1 = loc_oPg2.pgf_4c_Pageframe1
114: 
115:                 *-- SubPage1 (Estoques)
116:                 LOCAL loc_oSub1 AS Object
117:                 loc_oSub1 = loc_oPf1.Page1
118:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(1), "Click", THIS, "BtnMarcarClick")
119:                 BINDEVENT(loc_oSub1.cmdg_4c_MarcaDesmarca.Buttons(2), "Click", THIS, "BtnDesmarcarClick")
120:                 BINDEVENT(loc_oSub1.cmd_4c_Processar,                  "Click", THIS, "BtnProcessarPage1Click")
121:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "MouseUp",  THIS, "ChkMarcaMouseUp")
122:                 BINDEVENT(loc_oSub1.grd_4c_Estoques.Column1.chk_4c_Marca, "KeyPress", THIS, "ChkMarcaKeyPress")
123: 
124:                 *-- SubPage2 (Distribuicao)
125:                 LOCAL loc_oSub2 AS Object
126:                 loc_oSub2 = loc_oPf1.Page2
127:                 BINDEVENT(loc_oSub2.cmd_4c_VoltarEst,      "Click",              THIS, "BtnVoltarEstClick")
128:                 BINDEVENT(loc_oSub2.cmd_4c_Salvar,         "Click",              THIS, "BtnSalvarClick")
129:                 BINDEVENT(loc_oSub2.cmd_4c_Filtrar,        "Click",              THIS, "BtnFiltrarClick")
130:                 BINDEVENT(loc_oSub2.img_4c_FigJpg,         "Click",              THIS, "ImgFotoClick")
131:                 BINDEVENT(loc_oSub2.txt_4c_CodGrupo,       "KeyPress",              THIS, "TxtCGrupoValid")
132:                 BINDEVENT(loc_oSub2.txt_4c_DsGrupo,        "KeyPress",              THIS, "TxtDGrupoValid")
133:                 BINDEVENT(loc_oSub2.txt_4c_ProdutoInicial, "LostFocus",              THIS, "TxtProdutoInicialValid")
134:                 BINDEVENT(loc_oSub2.grd_4c_Disponivel,     "AfterRowColChange",  THIS, "GrdDisponivelAfterRowColChange")
135:                 BINDEVENT(loc_oSub2.grd_4c_Distribui.Column3.Text1, "KeyPress", THIS, "GrdDistribuiQtdLostFocus")
136:                 BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "Valid",     THIS, "GrdDistribuiLocalValid")
137:                 BINDEVENT(loc_oSub2.grd_4c_Distribui.Column4.Text1, "KeyPress",  THIS, "TxtLocalKeyPress")
138: 
139:                 *-- SubPage3 (Operacoes)
140:                 LOCAL loc_oSub3 AS Object
141:                 loc_oSub3 = loc_oPf1.Page3
142:                 BINDEVENT(loc_oSub3.cmdg_4c_ProcOper.Buttons(1), "Click",             THIS, "BtnProcOperClick")
143:                 BINDEVENT(loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas, "AfterRowColChange", THIS, "GrdCabOperasAfterRowColChange")
144: 
145:                 THIS.TornarControlesVisiveis(THIS)
146: 
147:                 *-- Disable pages 2 and 3 until estoques processed
148:                 loc_oPf1.Page2.Enabled = .F.
149:                 loc_oPf1.Page3.Enabled = .F.
150: 
151:                 *-- Initial date range = today
152:                 THIS.this_oBusinessObject.this_dDataInicial = DATE()
153:                 THIS.this_oBusinessObject.this_dDataFinal   = DATE()
154:                 loc_oPg1.txt_4c_DtInicial.Value = DATE()
155:                 loc_oPg1.txt_4c_DtFinal.Value   = DATE()
156: 
157:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
158:                     THIS.CarregarLista()
159:                 ENDIF
160:                 THIS.pgf_4c_Paginas.Visible = .T.
161:                 THIS.pgf_4c_Paginas.ActivePage = 1
162:                 IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
163:                     loc_oPg1.grd_4c_Grade.SetFocus()
164:                 ELSE
165:                     loc_oPg1.cmd_4c_Novo.SetFocus()
166:                 ENDIF
167: 
168:                 loc_lSucesso = .T.
169:             ENDIF
170:         CATCH TO loc_oErro
171:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
172:                     " PROC=" + loc_oErro.Procedure, "Erro InicializarForm Formsigprdis")
173:         ENDTRY
174:         RETURN loc_lSucesso
175:     ENDPROC
176: 
177:     *==========================================================================
178:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
179:     *==========================================================================
180:         LOCAL loc_nI, loc_oControl
181: 
182:         IF VARTYPE(par_oContainer) <> "O"
183:             RETURN
184:         ENDIF
185: 
186:         FOR loc_nI = 1 TO par_oContainer.ControlCount
187:             loc_oControl = par_oContainer.Controls(loc_nI)
188: 
189:             IF VARTYPE(loc_oControl) = "O"
190:                 IF INLIST(UPPER(loc_oControl.Name), ;
191:                     "LBL_4C_LBLTITF", "LBL_4C_LBLTITT", "LBL_4C_LABEL3")
192:                     IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
193:                        loc_oControl.ControlCount > 0
194:                         THIS.TornarControlesVisiveis(loc_oControl)
195:                     ENDIF
196:                     LOOP
197:                 ENDIF
198: 
199:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
200:                     loc_oControl.Visible = .T.
201:                 ENDIF
202: 
203:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
204:                    loc_oControl.ControlCount > 0
205:                     THIS.TornarControlesVisiveis(loc_oControl)
206:                 ENDIF
207:             ENDIF
208:         ENDFOR
209:     ENDPROC
210: 
211:     *==========================================================================
212:     PROTECTED PROCEDURE ConfigurarCabecalho()
213:     *==========================================================================
214:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
215:         WITH THIS.cnt_4c_Cabecalho
216:             .Top        = 0
217:             .Left       = 0
218:             .Width      = THIS.Width
219:             .Height     = 45
220:             .BorderWidth= 0
221:             .BackStyle  = 1
222:             .BackColor  = RGB(90,90,90)
223:             .Visible     = .T.
224:         ENDWITH
225:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
226:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
227:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
228:             .Top       = 12
229:             .Left      = 12
230:             .Width     = THIS.Width
231:             .Height    = 30
232:             .AutoSize  = .F.
233:             .BackStyle = 0
234:             .ForeColor = RGB(0,0,0)
235:             .FontName  = "Tahoma"
236:             .FontSize  = 14
237:             .FontBold  = .T.
238:         ENDWITH
239:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
240:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
241:             .Caption   = "Distribui" + CHR(231) + CHR(227) + "o de Produtos"
242:             .Top       = 10
243:             .Left      = 10
244:             .Width     = THIS.Width
245:             .Height    = 30
246:             .AutoSize  = .F.
247:             .BackStyle = 0
248:             .ForeColor = RGB(255,255,255)
249:             .FontName  = "Tahoma"
250:             .FontSize  = 14
251:             .FontBold  = .T.
252:         ENDWITH
253:     ENDPROC
254: 
255:     *==========================================================================
256:     PROTECTED PROCEDURE ConfigurarPageFrame()
257:     *==========================================================================
258:         THIS.Picture    = gc_4c_CaminhoBase + "Framework\imagens\new_background.jpg"
259:         THIS.ScrollBars = 0
260:         THIS.ShowTips   = .T.
261: 
262:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
263:         WITH THIS.pgf_4c_Paginas
264:             .Left      = 0
265:             .Top       = 45
266:             .Width     = THIS.Width
267:             .Height    = THIS.Height - 45
268:             .PageCount = 2
269:             .Tabs      = .F.
270:             .Page1.Caption = "Lista"
271:             .Page2.Caption = "Dados"
272:         ENDWITH
273:     ENDPROC
274: 
275:     *==========================================================================
276:     PROTECTED PROCEDURE ConfigurarSaida()
277:     *==========================================================================
278:         THIS.AddObject("cnt_4c_Saida", "Container")
279:         WITH THIS.cnt_4c_Saida
280:             .Name        = "cnt_4c_Saida"
281:             .Left        = 917
282:             .Top         = 45
283:             .Width       = 90
284:             .Height      = 85
285:             .BackStyle = 1
286:             .BackColor = RGB(255, 255, 255)
287:             .BorderWidth = 0
288:             .Visible     = .T.
289:             .ZOrder(0)
290:         ENDWITH
291:         THIS.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
292:         WITH THIS.cnt_4c_Saida.cmd_4c_Encerrar
293:             .Name     = "cmd_4c_Encerrar"
294:             .Left     = 5
295:             .Top      = 5
296:             .Width    = 75
297:             .Height   = 75
298:             .Caption  = "Encerrar"
299:             .FontName = "Tahoma"
300:             .FontSize = 8
301:             .Visible  = .T.
302:         ENDWITH
303:     ENDPROC
304: 
305:     *==========================================================================
306:     PROTECTED PROCEDURE ConfigurarPaginaLista()
307:     *==========================================================================
308:         LOCAL loc_oPg1 AS Object
309:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
310: 
311:         loc_oPg1.AddObject("lbl_4c_Periodo", "Label")
312:         WITH loc_oPg1.lbl_4c_Periodo
313:             .Caption   = "Per" + CHR(237) + "odo :"
314:             .Left      = 35
315:             .Top       = 89
316:             .Width     = 60
317:             .Height    = 15
318:             .AutoSize  = .F.
319:             .BackStyle = 0
320:             .FontName  = "Tahoma"
321:             .FontSize  = 8
322:         ENDWITH
323: 
324:         loc_oPg1.AddObject("txt_4c_DtInicial", "TextBox")
325:         WITH loc_oPg1.txt_4c_DtInicial
326:             .Left     = 103
327:             .Top      = 105
328:             .Width    = 90
329:             .Height   = 22
330:             .Value    = DATE()
331:             .Format   = "D"
332:             .FontName = "Tahoma"
333:             .FontSize = 8
334:         ENDWITH
335: 
336:         loc_oPg1.AddObject("lbl_4c_Sep", "Label")
337:         WITH loc_oPg1.lbl_4c_Sep
338:             .Caption   = CHR(224)
339:             .Left      = 195
340:             .Top       = 109
341:             .Width     = 12
342:             .Height    = 15
343:             .AutoSize  = .F.
344:             .BackStyle = 0
345:         ENDWITH
346: 

*-- Linhas 422 a 465:
422:     ENDPROC
423: 
424:     *==========================================================================
425:     PROTECTED PROCEDURE ConfigurarPaginaDados()
426:     *==========================================================================
427:         LOCAL loc_oPg2 AS Object
428:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
429: 
430:         loc_oPg2.AddObject("cmd_4c_VoltarLista", "CommandButton")
431:         WITH loc_oPg2.cmd_4c_VoltarLista
432:             .Caption  = CHR(171) + " Lista"
433:             .Left     = 5
434:             .Top      = 5
435:             .Width    = 80
436:             .Height   = 25
437:             .FontName = "Tahoma"
438:             .FontSize = 8
439:         ENDWITH
440: 
441:         loc_oPg2.AddObject("lbl_4c_Lote", "Label")
442:         WITH loc_oPg2.lbl_4c_Lote
443:             .Caption   = "Lote:"
444:             .Left      = 96
445:             .Top       = 10
446:             .Width     = 35
447:             .Height    = 15
448:             .AutoSize  = .F.
449:             .BackStyle = 0
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:         ENDWITH
453: 
454:         loc_oPg2.AddObject("txt_4c_LoteCodigo", "TextBox")
455:         WITH loc_oPg2.txt_4c_LoteCodigo
456:             .Left      = 132
457:             .Top       = 7
458:             .Width     = 180
459:             .Height    = 22
460:             .ReadOnly  = .T.
461:             .BackColor = RGB(230,230,230)
462:             .FontName  = "Tahoma"
463:             .FontSize  = 8
464:         ENDWITH
465: 

*-- Linhas 497 a 540:
497:     ENDPROC
498: 
499:     *==========================================================================
500:     PROTECTED PROCEDURE ConfigurarSubPaginaEstoques()
501:     *==========================================================================
502:         LOCAL loc_oSub AS Object
503:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1
504: 
505:         loc_oSub.AddObject("lbl_4c_TituloEst", "Label")
506:         WITH loc_oSub.lbl_4c_TituloEst
507:             .Caption   = "Estoques para distribuir"
508:             .Left      = 338
509:             .Top       = 189
510:             .Width     = 200
511:             .Height    = 15
512:             .AutoSize  = .F.
513:             .BackStyle = 0
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .FontBold  = .T.
517:         ENDWITH
518: 
519:         loc_oSub.AddObject("cmd_4c_Processar", "CommandButton")
520:         WITH loc_oSub.cmd_4c_Processar
521:             .Caption  = "Processar >>"
522:             .Left     = 730
523:             .Top      = 10
524:             .Width    = 120
525:             .Height   = 28
526:             .FontName = "Tahoma"
527:             .FontSize = 8
528:         ENDWITH
529: 
530:         loc_oSub.AddObject("cmdg_4c_MarcaDesmarca", "CommandGroup")
531:         WITH loc_oSub.cmdg_4c_MarcaDesmarca
532:             .Left        = 617
533:             .Top         = 351
534:             .Width       = 160
535:             .Height      = 50
536:             .ButtonCount = 2
537:         ENDWITH
538:         WITH loc_oSub.cmdg_4c_MarcaDesmarca.Buttons(1)
539:             .Caption = "Marcar Todos"
540:             .Left    = 5

*-- Linhas 600 a 643:
600:     ENDPROC
601: 
602:     *==========================================================================
603:     PROTECTED PROCEDURE ConfigurarSubPaginaDistribuicao()
604:     *==========================================================================
605:         LOCAL loc_oSub AS Object
606:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
607: 
608:         loc_oSub.AddObject("cmd_4c_VoltarEst", "CommandButton")
609:         WITH loc_oSub.cmd_4c_VoltarEst
610:             .Caption  = CHR(171) + " Estoques"
611:             .Left     = 5
612:             .Top      = 5
613:             .Width    = 90
614:             .Height   = 25
615:             .FontName = "Tahoma"
616:             .FontSize = 8
617:         ENDWITH
618: 
619:         loc_oSub.AddObject("cmd_4c_Salvar", "CommandButton")
620:         WITH loc_oSub.cmd_4c_Salvar
621:             .Caption  = "Salvar"
622:             .Left     = 730
623:             .Top      = 5
624:             .Width    = 80
625:             .Height   = 25
626:             .FontName = "Tahoma"
627:             .FontSize = 8
628:         ENDWITH
629: 
630:         *-- Product image area
631:         loc_oSub.AddObject("shp_4c_Shape5", "Shape")
632:         WITH loc_oSub.shp_4c_Shape5
633:             .Left      = 4
634:             .Top       = 35
635:             .Width     = 163
636:             .Height    = 93
637:             .BackStyle = 1
638:             .BackColor = RGB(200,200,200)
639:         ENDWITH
640: 
641:         loc_oSub.AddObject("img_4c_FigJpg", "Image")
642:         WITH loc_oSub.img_4c_FigJpg
643:             .Left    = 7

*-- Linhas 918 a 961:
918:     ENDPROC
919: 
920:     *==========================================================================
921:     PROTECTED PROCEDURE ConfigurarSubPaginaOperacoes()
922:     *==========================================================================
923:         LOCAL loc_oSub AS Object
924:         loc_oSub = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
925: 
926:         *-- Obs container
927:         loc_oSub.AddObject("cntOperacao", "Container")
928:         WITH loc_oSub.cntOperacao
929:             .Left        = 3
930:             .Top         = 13
931:             .Width       = 564
932:             .Height      = 165
933:             .BackColor   = RGB(240,240,240)
934:             .BorderWidth = 1
935:         ENDWITH
936:         loc_oSub.cntOperacao.AddObject("lbl_4c_Obs", "Label")
937:         WITH loc_oSub.cntOperacao.lbl_4c_Obs
938:             .Caption   = "Obs. :"
939:             .Left      = 12
940:             .Top       = 10
941:             .Width     = 40
942:             .Height    = 15
943:             .AutoSize  = .F.
944:             .BackStyle = 0
945:             .FontName  = "Tahoma"
946:             .FontSize  = 8
947:         ENDWITH
948:         loc_oSub.cntOperacao.AddObject("txt_4c_CodObs", "TextBox")
949:         WITH loc_oSub.cntOperacao.txt_4c_CodObs
950:             .Left     = 52
951:             .Top      = 10
952:             .Width    = 27
953:             .Height   = 20
954:             .FontName = "Tahoma"
955:             .FontSize = 8
956:         ENDWITH
957:         loc_oSub.cntOperacao.AddObject("edt_4c_Obs", "EditBox")
958:         WITH loc_oSub.cntOperacao.edt_4c_Obs
959:             .Left     = 83
960:             .Top      = 10
961:             .Width    = 407

*-- Linhas 1092 a 1183:
1092:     * METODOS DE NEGOCIO
1093:     *==========================================================================
1094: 
1095:     PROCEDURE CarregarLista()
1096:     *==========================================================================
1097:         THIS.this_oBusinessObject.this_dDataInicial = ;
1098:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial.Value
1099:         THIS.this_oBusinessObject.this_dDataFinal = ;
1100:             THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal.Value
1101:         THIS.this_oBusinessObject.Buscar("")
1102:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = ""
1103:         IF USED("cursor_4c_Dados")
1104:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.ColumnCount = 3
1105:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.RecordSource = "cursor_4c_Dados"
1106:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1107:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column1.Header1.Caption = "Lote (C" + CHR(243) + "digo)"
1108:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.ControlSource = "cursor_4c_Dados.Datas"
1109:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Column2.Header1.Caption = "Data/Hora"
1110:         ENDIF
1111:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.Refresh()
1112:     ENDPROC
1113: 
1114:     PROCEDURE AbrirNovoBatch()
1115:     *==========================================================================
1116:         THIS.this_cEscolha = "INSERIR"
1117:         THIS.this_cCodigos = ALLTRIM(TRANSFORM(fGerUniqueKey("SIGPRDIS"), "@L 9999999999"))
1118:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = THIS.this_cCodigos
1119:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "NOVO"
1120: 
1121:         IF THIS.this_oBusinessObject.BuscarEstoques()
1122:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1123:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1124:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1125:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1126:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1127:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1128:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1129:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1130:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1131:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1132:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1133:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1134:         ENDIF
1135: 
1136:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .F.
1137:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3.Enabled = .F.
1138:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 1
1139:         THIS.pgf_4c_Paginas.ActivePage = 2
1140:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1141:     ENDPROC
1142: 
1143:     PROCEDURE AbrirBatchExistente(par_cCodigos)
1144:     *==========================================================================
1145:         THIS.this_cEscolha = "ALTERAR"
1146:         THIS.this_cCodigos = par_cCodigos
1147:         THIS.pgf_4c_Paginas.Page2.txt_4c_LoteCodigo.Value = par_cCodigos
1148:         THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption    = "EDITAR"
1149: 
1150:         THIS.this_oBusinessObject.InicializarLote(par_cCodigos)
1151: 
1152:         IF THIS.this_oBusinessObject.BuscarEstoques()
1153:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = ""
1154:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.ColumnCount = 4
1155:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.RecordSource = "cursor_4c_Estoques"
1156:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.ControlSource = "cursor_4c_Estoques.nMarca"
1157:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column1.Header1.Caption = ""
1158:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.ControlSource = "cursor_4c_Estoques.emps"
1159:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column2.Header1.Caption = "Empresa"
1160:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.ControlSource = "cursor_4c_Estoques.grupos"
1161:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column3.Header1.Caption = "Grupo"
1162:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.ControlSource = "cursor_4c_Estoques.contas"
1163:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Column4.Header1.Caption = "Conta"
1164:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1165:         ENDIF
1166: 
1167:         *-- Pre-marcar estoques do lote
1168:         IF USED("cursor_4c_Estoques") AND USED("cursor_4c_LotePrDis")
1169:             LOCAL loc_cEmpEst AS String
1170:             SELECT cursor_4c_Estoques
1171:             GO TOP
1172:             DO WHILE !EOF("cursor_4c_Estoques")
1173:                 loc_cEmpEst = ALLTRIM(cursor_4c_Estoques.emps)
1174:                 SELECT cursor_4c_LotePrDis
1175:                 LOCATE FOR ALLTRIM(empds) = loc_cEmpEst
1176:                 IF FOUND()
1177:                     REPLACE nMarca WITH 1 IN cursor_4c_Estoques
1178:                 ENDIF
1179:                 SELECT cursor_4c_Estoques
1180:                 SKIP
1181:             ENDDO
1182:             GO TOP IN cursor_4c_Estoques
1183:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()

*-- Linhas 1214 a 1598:
1214:     * HANDLERS DE EVENTOS
1215:     *==========================================================================
1216: 
1217:     PROCEDURE BtnEncerrarClick()
1218:     *==========================================================================
1219:         THIS.Release()
1220:     ENDPROC
1221: 
1222:     PROCEDURE BtnNovoClick()
1223:     *==========================================================================
1224:         THIS.AbrirNovoBatch()
1225:     ENDPROC
1226: 
1227:     PROCEDURE BtnAbrirClick()
1228:     *==========================================================================
1229:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0 ;
1230:                 AND !EOF("cursor_4c_Dados")
1231:             SELECT cursor_4c_Dados
1232:             LOCAL loc_cCodigos AS String
1233:             loc_cCodigos = ALLTRIM(cursor_4c_Dados.Codigos)
1234:             IF !EMPTY(loc_cCodigos)
1235:                 THIS.AbrirBatchExistente(loc_cCodigos)
1236:             ENDIF
1237:         ELSE
1238:             MsgAviso("Selecione um lote na lista.", "Aviso")
1239:         ENDIF
1240:     ENDPROC
1241: 
1242:     PROCEDURE TxtDtInicialValid()
1243:     *==========================================================================
1244:         LOCAL loc_oDtI AS Object, loc_oDtF AS Object
1245:         loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
1246:         loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal
1247:         IF loc_oDtI.Value > loc_oDtF.Value
1248:             loc_oDtF.Value = loc_oDtI.Value
1249:         ENDIF
1250:     ENDPROC
1251: 
1252:     PROCEDURE TxtDtFinalValid()
1253:     *==========================================================================
1254:         LOCAL loc_oDtI AS Object, loc_oDtF AS Object
1255:         loc_oDtI = THIS.pgf_4c_Paginas.Page1.txt_4c_DtInicial
1256:         loc_oDtF = THIS.pgf_4c_Paginas.Page1.txt_4c_DtFinal
1257:         IF loc_oDtF.Value < loc_oDtI.Value
1258:             loc_oDtI.Value = loc_oDtF.Value
1259:         ENDIF
1260:     ENDPROC
1261: 
1262:     PROCEDURE TxtDtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1263:     *==========================================================================
1264:         THIS.CarregarLista()
1265:         THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
1266:     ENDPROC
1267: 
1268:     PROCEDURE BtnVoltarListaClick()
1269:     *==========================================================================
1270:         THIS.pgf_4c_Paginas.Visible = .T.
1271:         THIS.pgf_4c_Paginas.ActivePage = 1
1272:         THIS.CarregarLista()
1273:         IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1274:             THIS.pgf_4c_Paginas.Page1.grd_4c_Grade.SetFocus()
1275:         ELSE
1276:             THIS.pgf_4c_Paginas.Page1.cmd_4c_Novo.SetFocus()
1277:         ENDIF
1278:     ENDPROC
1279: 
1280:     PROCEDURE BtnVoltarEstClick()
1281:     *==========================================================================
1282:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 1
1283:         THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.cmd_4c_Processar.SetFocus()
1284:     ENDPROC
1285: 
1286:     PROCEDURE BtnMarcarClick()
1287:     *==========================================================================
1288:         IF USED("cursor_4c_Estoques")
1289:             SELECT cursor_4c_Estoques
1290:             REPLACE ALL nMarca WITH 1
1291:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     PROCEDURE BtnDesmarcarClick()
1296:     *==========================================================================
1297:         IF USED("cursor_4c_Estoques")
1298:             SELECT cursor_4c_Estoques
1299:             REPLACE ALL nMarca WITH 0
1300:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1301:         ENDIF
1302:     ENDPROC
1303: 
1304:     PROCEDURE ChkMarcaMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
1305:     *==========================================================================
1306:         NODEFAULT
1307:         IF USED("cursor_4c_Estoques")
1308:             SELECT cursor_4c_Estoques
1309:             REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1310:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1311:         ENDIF
1312:     ENDPROC
1313: 
1314:     PROCEDURE ChkMarcaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1315:     *==========================================================================
1316:         IF INLIST(par_nKeyCode, 13, 32)
1317:             IF USED("cursor_4c_Estoques")
1318:                 SELECT cursor_4c_Estoques
1319:                 REPLACE nMarca WITH IIF(cursor_4c_Estoques.nMarca = 0, 1, 0)
1320:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page1.grd_4c_Estoques.Refresh()
1321:             ENDIF
1322:         ENDIF
1323:     ENDPROC
1324: 
1325:     PROCEDURE BtnProcessarPage1Click()
1326:     *==========================================================================
1327:         IF THIS.this_oBusinessObject.PrepararCursoresDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
1328:             LOCAL loc_oSub2 AS Object
1329:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1330:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1331:             IF USED("cursor_4c_Disponivel")
1332:                 loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1333:                 loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1334:                 loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1335:                 loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1336:                 loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1337:                 loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1338:                 loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1339:                 loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1340:                 loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1341:                 loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1342:                 loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1343:                 loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1344:                 loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1345:                 loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Sa" + CHR(237) + "da"
1346:                 loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1347:                 loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1348:             ENDIF
1349:             loc_oSub2.grd_4c_Disponivel.Refresh()
1350:             loc_oSub2.grd_4c_Distribui.RecordSource = ""
1351:             IF USED("cursor_4c_Distribui")
1352:                 loc_oSub2.grd_4c_Distribui.ColumnCount = 4
1353:                 loc_oSub2.grd_4c_Distribui.RecordSource = "cursor_4c_Distribui"
1354:                 loc_oSub2.grd_4c_Distribui.Column1.ControlSource = "cursor_4c_Distribui.emps"
1355:                 loc_oSub2.grd_4c_Distribui.Column1.Header1.Caption = "Empresa"
1356:                 loc_oSub2.grd_4c_Distribui.Column2.ControlSource = "cursor_4c_Distribui.QtdSaldo"
1357:                 loc_oSub2.grd_4c_Distribui.Column2.Header1.Caption = "Saldo"
1358:                 loc_oSub2.grd_4c_Distribui.Column3.ControlSource = "cursor_4c_Distribui.QtdDistr"
1359:                 loc_oSub2.grd_4c_Distribui.Column3.Header1.Caption = "Qtd"
1360:                 loc_oSub2.grd_4c_Distribui.Column4.ControlSource = "cursor_4c_Distribui.locals"
1361:                 loc_oSub2.grd_4c_Distribui.Column4.Header1.Caption = "Local"
1362:             ENDIF
1363:             loc_oSub2.grd_4c_Distribui.Refresh()
1364:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.Enabled = .T.
1365:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage    = 2
1366:             loc_oSub2.grd_4c_Disponivel.SetFocus()
1367:         ENDIF
1368:     ENDPROC
1369: 
1370:     PROCEDURE GrdDisponivelAfterRowColChange(par_nColIndex)
1371:     *==========================================================================
1372:         IF USED("cursor_4c_Disponivel") AND !EOF("cursor_4c_Disponivel")
1373:             LOCAL loc_cCpros AS String
1374:             SELECT cursor_4c_Disponivel
1375:             loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
1376:             IF !EMPTY(loc_cCpros) AND THIS.this_oBusinessObject.BuscarProduto(loc_cCpros)
1377:                 LOCAL loc_oSub2 AS Object
1378:                 loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1379:                 SELECT cursor_4c_Produto
1380:                 loc_oSub2.txt_4c_CdGrupo.Value      = TratarNulo(cgrus,  "C")
1381:                 loc_oSub2.txt_4c_DsGrupoP.Value     = TratarNulo(dgrus,  "C")
1382:                 loc_oSub2.txt_4c_CdFornecedor.Value = TratarNulo(ifors,  "C")
1383:                 loc_oSub2.txt_4c_DsFornecedor.Value = TratarNulo(rclis,  "C")
1384:                 loc_oSub2.txt_4c_MoedaPrVenda.Value = TratarNulo(moevs,  "C")
1385:                 loc_oSub2.txt_4c_PrVenda.Value      = TratarNulo(pvens,  "N")
1386:             ENDIF
1387:         ENDIF
1388:     ENDPROC
1389: 
1390:     PROCEDURE GrdDistribuiQtdLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1391:     *==========================================================================
1392:         IF USED("cursor_4c_Disponivel") AND USED("cursor_4c_Distribui") ;
1393:                 AND !EOF("cursor_4c_Disponivel")
1394:             LOCAL loc_cCpros AS String, loc_cCodCors AS String, loc_cCodTams AS String
1395:             SELECT cursor_4c_Disponivel
1396:             loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
1397:             loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
1398:             loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)
1399:             THIS.this_oBusinessObject.CalcularSaldo(loc_cCpros, loc_cCodCors, loc_cCodTams)
1400:             LOCAL loc_oSub2 AS Object
1401:             loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1402:             loc_oSub2.grd_4c_Disponivel.Refresh()
1403:             loc_oSub2.grd_4c_Distribui.Refresh()
1404:         ENDIF
1405:     ENDPROC
1406: 
1407:     PROCEDURE GrdDistribuiLocalValid()
1408:     *==========================================================================
1409:         LOCAL loc_cLocal AS String, loc_nRes AS Number, loc_oLookup AS Object
1410:         LOCAL loc_lSucesso, loc_oErro
1411:         loc_lSucesso = .F.
1412:         TRY
1413:             loc_cLocal = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2 ;
1414:                 .grd_4c_Distribui.Column4.Text1.Value)
1415:             IF !EMPTY(loc_cLocal)
1416:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1417:                     "SELECT Codigos, Descricaos FROM SigPrLcl WHERE Codigos LIKE " + ;
1418:                     EscaparSQL(loc_cLocal + "%") + " ORDER BY Codigos", ;
1419:                     "cursor_4c_Locais", "Codigos", loc_cLocal, ;
1420:                     "Localiza" + CHR(231) + CHR(227) + "o")
1421:                 IF VARTYPE(loc_oLookup) = "O"
1422:                     loc_oLookup.AddColuna("Codigos",    "", "Localiza" + CHR(231) + CHR(227) + "o")
1423:                     loc_oLookup.AddColuna("Descricaos", "", "Descri" + CHR(231) + CHR(227) + "o")
1424:                     loc_oLookup.Show()
1425:                     IF USED("cursor_4c_Locais") AND RECCOUNT("cursor_4c_Locais") > 0
1426:                         IF USED("cursor_4c_Distribui") AND !EOF("cursor_4c_Distribui")
1427:                             REPLACE cursor_4c_Distribui.locals WITH ALLTRIM(cursor_4c_Locais.Codigos)
1428:                         ENDIF
1429:                     ENDIF
1430:                     IF USED("cursor_4c_Locais")
1431:                         USE IN cursor_4c_Locais
1432:                     ENDIF
1433:                 ENDIF
1434:             ENDIF
1435:             loc_lSucesso = .T.
1436:         CATCH TO loc_oErro
1437:             MsgErro(loc_oErro.Message, "Erro Lookup Local")
1438:         ENDTRY
1439:         RETURN loc_lSucesso
1440:     ENDPROC
1441: 
1442:     PROCEDURE TxtLocalKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1443:     *==========================================================================
1444:         DO CASE
1445:             CASE par_nKeyCode = 9
1446:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Column1.SetFocus()
1447:                 NODEFAULT
1448:             CASE par_nKeyCode = 115
1449:                 THIS.GrdDistribuiLocalValid()
1450:                 NODEFAULT
1451:         ENDCASE
1452:     ENDPROC
1453: 
1454:     PROCEDURE TxtProdutoInicialValid()
1455:     *==========================================================================
1456:         LOCAL loc_cCpros AS String, loc_nRec AS Number
1457:         loc_cCpros = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.txt_4c_ProdutoInicial.Value)
1458:         IF !EMPTY(loc_cCpros) AND USED("cursor_4c_Disponivel")
1459:             SELECT cursor_4c_Disponivel
1460:             loc_nRec = RECNO()
1461:             GO TOP
1462:             LOCATE FOR ALLTRIM(cpros) >= loc_cCpros
1463:             IF EOF()
1464:                 GO loc_nRec
1465:             ENDIF
1466:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.grd_4c_Disponivel.Refresh()
1467:         ENDIF
1468:     ENDPROC
1469: 
1470:     PROCEDURE TxtCGrupoValid(par_nKeyCode, par_nShiftAltCtrl)
1471:     *==========================================================================
1472:         LOCAL loc_cCodigo AS String, loc_nRes AS Number, loc_oLookup AS Object, loc_oErro
1473:         LOCAL loc_oSub2 AS Object
1474:         loc_oSub2  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1475:         loc_cCodigo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
1476:         IF EMPTY(loc_cCodigo)
1477:             loc_oSub2.txt_4c_DsGrupo.Value = ""
1478:         ELSE
1479:             TRY
1480:                 IF USED("cursor_4c_GrpBusca")
1481:                     USE IN cursor_4c_GrpBusca
1482:                 ENDIF
1483:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1484:                     "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
1485:                     EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", "cursor_4c_GrpBusca")
1486:                 IF loc_nRes > 0 AND USED("cursor_4c_GrpBusca") AND RECCOUNT("cursor_4c_GrpBusca") > 0
1487:                     IF RECCOUNT("cursor_4c_GrpBusca") = 1
1488:                         SELECT cursor_4c_GrpBusca
1489:                         loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBusca.CGrus)
1490:                         loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBusca.DGrus)
1491:                     ELSE
1492:                         loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1493:                             "SELECT CGrus, DGrus FROM SigCdGrp WHERE CGrus LIKE " + ;
1494:                             EscaparSQL(loc_cCodigo + "%") + " ORDER BY CGrus", ;
1495:                             "cursor_4c_GrpBuscaD", "CGrus", loc_cCodigo, "Grupos")
1496:                         IF VARTYPE(loc_oLookup) = "O"
1497:                             loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1498:                             loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1499:                             loc_oLookup.Show()
1500:                             IF USED("cursor_4c_GrpBuscaD") AND RECCOUNT("cursor_4c_GrpBuscaD") > 0
1501:                                 SELECT cursor_4c_GrpBuscaD
1502:                                 loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaD.CGrus)
1503:                                 loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaD.DGrus)
1504:                             ENDIF
1505:                             IF USED("cursor_4c_GrpBuscaD")
1506:                                 USE IN cursor_4c_GrpBuscaD
1507:                             ENDIF
1508:                         ENDIF
1509:                     ENDIF
1510:                 ELSE
1511:                     loc_oSub2.txt_4c_CodGrupo.Value = ""
1512:                     loc_oSub2.txt_4c_DsGrupo.Value  = ""
1513:                 ENDIF
1514:                 IF USED("cursor_4c_GrpBusca")
1515:                     USE IN cursor_4c_GrpBusca
1516:                 ENDIF
1517:             CATCH TO loc_oErro
1518:                 MsgErro(loc_oErro.Message, "Erro lookup Grupo C" + CHR(243) + "digo")
1519:             ENDTRY
1520:         ENDIF
1521:     ENDPROC
1522: 
1523:     PROCEDURE TxtDGrupoValid(par_nKeyCode, par_nShiftAltCtrl)
1524:     *==========================================================================
1525:         LOCAL loc_cDesc AS String, loc_oLookup AS Object, loc_oErro
1526:         LOCAL loc_oSub2 AS Object
1527:         loc_oSub2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1528:         loc_cDesc  = ALLTRIM(loc_oSub2.txt_4c_DsGrupo.Value)
1529:         IF EMPTY(loc_cDesc)
1530:             loc_oSub2.txt_4c_CodGrupo.Value = ""
1531:         ELSE
1532:             TRY
1533:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
1534:                     "SELECT DGrus, CGrus FROM SigCdGrp ORDER BY DGrus", ;
1535:                     "cursor_4c_GrpBuscaDesc", "DGrus", loc_cDesc, "Grupos")
1536:                 IF VARTYPE(loc_oLookup) = "O"
1537:                     loc_oLookup.AddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1538:                     loc_oLookup.AddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1539:                     loc_oLookup.Show()
1540:                     IF USED("cursor_4c_GrpBuscaDesc") AND RECCOUNT("cursor_4c_GrpBuscaDesc") > 0
1541:                         SELECT cursor_4c_GrpBuscaDesc
1542:                         loc_oSub2.txt_4c_CodGrupo.Value = ALLTRIM(cursor_4c_GrpBuscaDesc.CGrus)
1543:                         loc_oSub2.txt_4c_DsGrupo.Value  = ALLTRIM(cursor_4c_GrpBuscaDesc.DGrus)
1544:                     ELSE
1545:                         loc_oSub2.txt_4c_CodGrupo.Value = ""
1546:                         loc_oSub2.txt_4c_DsGrupo.Value  = ""
1547:                     ENDIF
1548:                     IF USED("cursor_4c_GrpBuscaDesc")
1549:                         USE IN cursor_4c_GrpBuscaDesc
1550:                     ENDIF
1551:                 ENDIF
1552:             CATCH TO loc_oErro
1553:                 MsgErro(loc_oErro.Message, "Erro lookup Grupo Descri" + CHR(231) + CHR(227) + "o")
1554:             ENDTRY
1555:         ENDIF
1556:     ENDPROC
1557: 
1558:     PROCEDURE BtnFiltrarClick()
1559:     *==========================================================================
1560:         LOCAL loc_oSub2 AS Object, loc_cCGrupo AS String, loc_nRes AS Number, loc_oErro
1561:         loc_oSub2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2
1562:         loc_cCGrupo = ALLTRIM(loc_oSub2.txt_4c_CodGrupo.Value)
1563:         IF !USED("cursor_4c_Disponivel")
1564:             RETURN
1565:         ENDIF
1566:         IF EMPTY(loc_cCGrupo)
1567:             loc_oSub2.grd_4c_Disponivel.RecordSource = ""
1568:             loc_oSub2.grd_4c_Disponivel.ColumnCount = 7
1569:             loc_oSub2.grd_4c_Disponivel.RecordSource = "cursor_4c_Disponivel"
1570:             loc_oSub2.grd_4c_Disponivel.Column1.ControlSource = "cursor_4c_Disponivel.cpros"
1571:             loc_oSub2.grd_4c_Disponivel.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1572:             loc_oSub2.grd_4c_Disponivel.Column2.ControlSource = "cursor_4c_Disponivel.dpros"
1573:             loc_oSub2.grd_4c_Disponivel.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1574:             loc_oSub2.grd_4c_Disponivel.Column3.ControlSource = "cursor_4c_Disponivel.codcors"
1575:             loc_oSub2.grd_4c_Disponivel.Column3.Header1.Caption = "Cor"
1576:             loc_oSub2.grd_4c_Disponivel.Column4.ControlSource = "cursor_4c_Disponivel.codtams"
1577:             loc_oSub2.grd_4c_Disponivel.Column4.Header1.Caption = "Tam"
1578:             loc_oSub2.grd_4c_Disponivel.Column5.ControlSource = "cursor_4c_Disponivel.QtdEstoque"
1579:             loc_oSub2.grd_4c_Disponivel.Column5.Header1.Caption = "Estoque"
1580:             loc_oSub2.grd_4c_Disponivel.Column6.ControlSource = "cursor_4c_Disponivel.QtdSaida"
1581:             loc_oSub2.grd_4c_Disponivel.Column6.Header1.Caption = "Sa" + CHR(237) + "da"
1582:             loc_oSub2.grd_4c_Disponivel.Column7.ControlSource = "cursor_4c_Disponivel.QtdSaldo"
1583:             loc_oSub2.grd_4c_Disponivel.Column7.Header1.Caption = "Saldo"
1584:             loc_oSub2.grd_4c_Disponivel.Refresh()
1585:         ELSE
1586:             TRY
1587:                 IF USED("cursor_4c_DispFiltro")
1588:                     USE IN cursor_4c_DispFiltro
1589:                 ENDIF
1590:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1591:                     "SELECT DISTINCT a.cpros," + ;
1592:                     "  ISNULL(p.dpros,'') AS dpros," + ;
1593:                     "  a.codcors, a.codtams," + ;
1594:                     "  SUM(a.qtdos) AS QtdEstoque," + ;
1595:                     "  SUM(a.qtds) AS QtdSaida," + ;
1596:                     "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
1597:                     " FROM SigPrDis a" + ;
1598:                     " INNER JOIN SigCdPro p ON p.cpros = a.cpros" + ;

*-- Linhas 1626 a 1747:
1626:         ENDIF
1627:     ENDPROC
1628: 
1629:     PROCEDURE ImgFotoClick()
1630:     *==========================================================================
1631:         LOCAL loc_nRes AS Number, loc_cArquivo AS String, loc_oErro
1632:         IF !USED("cursor_4c_Disponivel") OR EOF("cursor_4c_Disponivel")
1633:             RETURN
1634:         ENDIF
1635:         TRY
1636:             SELECT cursor_4c_Disponivel
1637:             LOCAL loc_cCpros AS String
1638:             loc_cCpros = ALLTRIM(cursor_4c_Disponivel.cpros)
1639:             IF !EMPTY(loc_cCpros)
1640:                 IF USED("cursor_4c_TmpFoto")
1641:                     USE IN cursor_4c_TmpFoto
1642:                 ENDIF
1643:                 loc_nRes = SQLEXEC(gnConnHandle, ;
1644:                     "SELECT FigJpgs FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCpros), ;
1645:                     "cursor_4c_TmpFoto")
1646:                 IF loc_nRes > 0 AND RECCOUNT("cursor_4c_TmpFoto") > 0
1647:                     SELECT cursor_4c_TmpFoto
1648:                     IF !EMPTY(cursor_4c_TmpFoto.FigJpgs) AND !ISNULL(cursor_4c_TmpFoto.FigJpgs)
1649:                         LOCAL loc_cBase64 AS String, loc_cBin AS String
1650:                         loc_cBase64 = STRTRAN(STRTRAN(STRTRAN( ;
1651:                             cursor_4c_TmpFoto.FigJpgs, ;
1652:                             "data:image/png;base64,",  ""), ;
1653:                             "data:image/jpeg;base64,", ""), ;
1654:                             "data:image/jpg;base64,",  "")
1655:                         loc_cBin     = STRCONV(loc_cBase64, 14)
1656:                         loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
1657:                         STRTOFILE(loc_cBin, loc_cArquivo)
1658:                         IF FILE(loc_cArquivo)
1659:                             THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page2.img_4c_FigJpg.Picture = ;
1660:                                 loc_cArquivo
1661:                         ENDIF
1662:                     ENDIF
1663:                 ENDIF
1664:                 IF USED("cursor_4c_TmpFoto")
1665:                     USE IN cursor_4c_TmpFoto
1666:                 ENDIF
1667:             ENDIF
1668:         CATCH TO loc_oErro
1669:             MsgErro(loc_oErro.Message, "Erro ao carregar foto do produto")
1670:         ENDTRY
1671:     ENDPROC
1672: 
1673:     PROCEDURE BtnSalvarClick()
1674:     *==========================================================================
1675:         IF THIS.this_oBusinessObject.ProcessarDistribuicao(THIS.this_cCodigos, THIS.this_cEscolha)
1676:             MsgInfo("Distribui" + CHR(231) + CHR(227) + "o salva com sucesso.", "Sucesso")
1677:             THIS.this_cEscolha = "ALTERAR"
1678:             THIS.pgf_4c_Paginas.Page2.lbl_4c_Modo.Caption = "EDITAR"
1679:             *-- Switch to operacoes page
1680:             IF THIS.this_oBusinessObject.BuscarOperacoes(THIS.this_cCodigos)
1681:                 LOCAL loc_oSub3 AS Object
1682:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1683:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = ""
1684:                 IF USED("cursor_4c_CabOpera")
1685:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.ColumnCount = 6
1686:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.RecordSource = "cursor_4c_CabOpera"
1687:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.ControlSource = "cursor_4c_CabOpera.emps"
1688:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column1.Header1.Caption = "Emp O"
1689:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.ControlSource = "cursor_4c_CabOpera.dopes"
1690:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1691:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.ControlSource = "cursor_4c_CabOpera.numes"
1692:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column3.Header1.Caption = "N" + CHR(250) + "mero"
1693:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.ControlSource = "cursor_4c_CabOpera.datas"
1694:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column4.Header1.Caption = "Data"
1695:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.ControlSource = "cursor_4c_CabOpera.grupos"
1696:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column5.Header1.Caption = "Grupo Orig"
1697:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.ControlSource = "cursor_4c_CabOpera.empdopnums"
1698:                     loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Column6.Header1.Caption = "Emp+Op+Num"
1699:                 ENDIF
1700:                 loc_oSub3.pgf_4c_Operacoes.Page1.grd_4c_CabOperas.Refresh()
1701:                 loc_oSub3.Enabled = .T.
1702:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.ActivePage = 3
1703:             ENDIF
1704:         ENDIF
1705:     ENDPROC
1706: 
1707:     PROCEDURE BtnProcOperClick()
1708:     *==========================================================================
1709:         LOCAL loc_oSub3 AS Object, loc_cCodObs AS String, loc_cObs AS String
1710:         loc_oSub3   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1711:         loc_cCodObs = ALLTRIM(loc_oSub3.cntOperacao.txt_4c_CodObs.Value)
1712:         loc_cObs    = ALLTRIM(loc_oSub3.cntOperacao.edt_4c_Obs.Value)
1713:         MsgAviso("Processamento de opera" + CHR(231) + CHR(245) + "es n" + ;
1714:                  CHR(227) + "o implementado nesta vers" + CHR(227) + "o." + CHR(13) + ;
1715:                  "O lote j" + CHR(225) + " foi salvo em SigPrDis.", "Informa" + CHR(231) + CHR(227) + "o")
1716:     ENDPROC
1717: 
1718:     PROCEDURE GrdCabOperasAfterRowColChange(par_nColIndex)
1719:     *==========================================================================
1720:         IF USED("cursor_4c_CabOpera") AND !EOF("cursor_4c_CabOpera")
1721:             SELECT cursor_4c_CabOpera
1722:             LOCAL loc_cEmpDopNums AS String
1723:             loc_cEmpDopNums = ALLTRIM(cursor_4c_CabOpera.empdopnums)
1724:             IF !EMPTY(loc_cEmpDopNums) AND THIS.this_oBusinessObject.BuscarItensOperacao(loc_cEmpDopNums)
1725:                 LOCAL loc_oSub3 AS Object
1726:                 loc_oSub3 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Pageframe1.Page3
1727:                 loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.RecordSource = ""
1728:                 IF USED("cursor_4c_ItensOper")
1729:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.ColumnCount = 5
1730:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.RecordSource = "cursor_4c_ItensOper"
1731:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1.ControlSource = "cursor_4c_ItensOper.cpros"
1732:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1733:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2.ControlSource = "cursor_4c_ItensOper.codcors"
1734:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column2.Header1.Caption = "Cor"
1735:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3.ControlSource = "cursor_4c_ItensOper.codtams"
1736:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column3.Header1.Caption = "Tam"
1737:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4.ControlSource = "cursor_4c_ItensOper.qtds"
1738:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column4.Header1.Caption = "Quantidade"
1739:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5.ControlSource = "cursor_4c_ItensOper.locals"
1740:                     loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Column5.Header1.Caption = "Local"
1741:                 ENDIF
1742:                 loc_oSub3.pgf_4c_Operacoes.Page2.grd_4c_ItnOperas.Refresh()
1743:             ENDIF
1744:         ENDIF
1745:     ENDPROC
1746: 
1747: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdisBO.prg):
*=============================================================================*
* sigprdisBO.prg - Business Object para Distribuicao de Produtos
*=============================================================================*
* Herda de: BusinessBase
* Form associado: Formsigprdis.prg (forms\operacionais\)
* Tabela principal: sigprdis (PK: cidchaves)
* Tabela auxiliar : SIGTEMPD  (cidchaves C64 - temp de processamento)
*
* Descricao: Gerencia a distribuicao de produtos entre empresas/estoques.
*   - Page1 (Lista): lista de distribuicoes por periodo (TmpSigPrDis)
*   - Page2 (Dados): grade de disponivel (crDisponivel) e distribuicao
*                    (crDistribui) por empresa/grupo/conta
*   - Page3 (Ops)  : historico de operacoes geradas pelo processamento
*
* Campos sigprdis:
*   cidchaves C(20)   PK auto (fUniqueIds por linha)
*   codigos   C(10)   chave de lote (agrupa N linhas do mesmo lote)
*   datas     T       data/hora do lote
*   dtalts    T       data/hora ultima alteracao
*   cpros     C(14)   codigo do produto
*   codcors   C(4)    codigo da cor
*   codtams   C(4)    codigo do tamanho
*   empdopnums C(29)  empresa+operacao+numero destino gerado
*   empds     C(3)    empresa destino
*   empgruests C(23)  empresa+grupo+conta (composto 3+10+10)
*   locals    C(10)   localizacao/enderecamento
*   qtds      N(10,2) quantidade distribuida
*   qtdos     N(10,2) quantidade original (pre-distribuicao)
*   usuars    C(10)   usuario que criou
*   usualts   C(10)   usuario que alterou por ultimo
*   oridopnums C(29)  empresa+operacao+numero origem
*=============================================================================*

DEFINE CLASS sigprdisBO AS BusinessBase

    *-- Identificacao do lote (chave de negocio usada nos SELECTs de listagem)
    this_cCodigos       = ""

    *-- PK fisica de cada linha da distribuicao (gerada por fUniqueIds)
    this_cCidChaves     = ""

    *-- Data e hora do lote
    this_dDatas         = {}

    *-- Data e hora da ultima alteracao
    this_dDtAlts        = {}

    *-- Codigo do produto distribuido
    this_cCpros         = ""

    *-- Codigo da cor do produto
    this_cCodCors       = ""

    *-- Codigo do tamanho do produto
    this_cCodTams       = ""

    *-- Empresa + Operacao + Numero destino (composto char 29)
    this_cEmpDopNums    = ""

    *-- Empresa destino (char 3)
    this_cEmpDs         = ""

    *-- Empresa + Grupo + Conta composto (char 23 = 3+10+10)
    this_cEmpGruEsts    = ""

    *-- Localizacao / enderecamento do estoque (char 10)
    this_cLocals        = ""

    *-- Quantidade distribuida
    this_nQtds          = 0

    *-- Quantidade original (antes da distribuicao, preenchida no processamento)
    this_nQtdOs         = 0

    *-- Usuario que criou o lancamento
    this_cUsuars        = ""

    *-- Usuario da ultima alteracao
    this_cUsuAlts       = ""

    *-- Empresa + Operacao + Numero origem (char 29)
    this_cOriDopNums    = ""

    *-- Filtros de pesquisa de lotes (usados em Buscar)
    this_dDataInicial   = {}
    this_dDataFinal     = {}

    *-- Chave de query temporaria (cidquerys em SIGTEMPD, gerada por fUniqueIds)
    this_cCidQuerys     = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com tabela e campo-chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela      = "sigprdis"
        THIS.this_cCampoChave  = "cidchaves"
        THIS.this_dDataInicial = DATE()
        THIS.this_dDataFinal   = DATE()
    ENDPROC


    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * METODOS CRUD (BusinessBase)
    *==========================================================================

    *--------------------------------------------------------------------------
    * Buscar - Lista lotes de distribuicao por periodo (cursor_4c_Dados)
    * Colunas: Codigos, Datas
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cWhere)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT DISTINCT Codigos, Datas FROM SigPrDis" + ;
                       " WHERE CAST(Datas AS date) BETWEEN " + ;
                       FormatarDataSQL(THIS.this_dDataInicial) + ;
                       " AND " + FormatarDataSQL(THIS.this_dDataFinal) + ;
                       " ORDER BY Datas DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar distribui" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega primeira linha de um lote pelo campo Codigos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cidchaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso             = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_cCodigos       = ALLTRIM(par_cCodigos)
                THIS.this_lNovoRegistro  = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves   = TratarNulo(cidchaves,   "C")
            THIS.this_cCodigos     = TratarNulo(codigos,     "C")
            THIS.this_dDatas       = IIF(ISNULL(datas),  {}, datas)
            THIS.this_dDtAlts      = IIF(ISNULL(dtalts), {}, dtalts)
            THIS.this_cCpros       = TratarNulo(cpros,       "C")
            THIS.this_cCodCors     = TratarNulo(codcors,     "C")
            THIS.this_cCodTams     = TratarNulo(codtams,     "C")
            THIS.this_cEmpDopNums  = TratarNulo(empdopnums,  "C")
            THIS.this_cEmpDs       = TratarNulo(empds,       "C")
            THIS.this_cEmpGruEsts  = TratarNulo(empgruests,  "C")
            THIS.this_cLocals      = TratarNulo(locals,      "C")
            THIS.this_nQtds        = TratarNulo(qtds,        "N")
            THIS.this_nQtdOs       = TratarNulo(qtdos,       "N")
            THIS.this_cUsuars      = TratarNulo(usuars,      "C")
            THIS.this_cUsuAlts     = TratarNulo(usualts,     "C")
            THIS.this_cOriDopNums  = TratarNulo(oridopnums,  "C")
            loc_lSucesso           = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(THIS.this_cCidChaves)
            THIS.this_cCidChaves = fUniqueIds()
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigPrDis" + ;
                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves)                       + "," + ;
                       EscaparSQL(THIS.this_cCodigos)                         + "," + ;
                       EscaparSQL(THIS.this_cCodCors)                         + "," + ;
                       EscaparSQL(THIS.this_cCodTams)                         + "," + ;
                       EscaparSQL(THIS.this_cCpros)                           + "," + ;
                       "GETDATE(),"                                                  + ;
                       "GETDATE(),"                                                  + ;
                       EscaparSQL(THIS.this_cEmpDopNums)                      + "," + ;
                       EscaparSQL(THIS.this_cEmpDs)                           + "," + ;
                       EscaparSQL(THIS.this_cEmpGruEsts)                      + "," + ;
                       EscaparSQL(THIS.this_cLocals)                          + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtdOs)                    + "," + ;
                       FormatarNumeroSQL(THIS.this_nQtds)                     + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))              + "," + ;
                       EscaparSQL(THIS.this_cOriDopNums)                      + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao inserir distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Inserir:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de uma linha de distribuicao em SigPrDis
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigPrDis SET" + ;
                       "  codcors    = " + EscaparSQL(THIS.this_cCodCors)              + "," + ;
                       "  codtams    = " + EscaparSQL(THIS.this_cCodTams)              + "," + ;
                       "  cpros      = " + EscaparSQL(THIS.this_cCpros)                + "," + ;
                       "  dtalts     = GETDATE(),"                                           + ;
                       "  empdopnums = " + EscaparSQL(THIS.this_cEmpDopNums)           + "," + ;
                       "  empds      = " + EscaparSQL(THIS.this_cEmpDs)                + "," + ;
                       "  empgruests = " + EscaparSQL(THIS.this_cEmpGruEsts)           + "," + ;
                       "  locals     = " + EscaparSQL(THIS.this_cLocals)               + "," + ;
                       "  qtdos      = " + FormatarNumeroSQL(THIS.this_nQtdOs)         + "," + ;
                       "  qtds       = " + FormatarNumeroSQL(THIS.this_nQtds)          + "," + ;
                       "  usualts    = " + EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))   + "," + ;
                       "  oridopnums = " + EscaparSQL(THIS.this_cOriDopNums)                  + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.Atualizar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE do lote completo de SigPrDis (por Codigos)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                       EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir lote de distribui" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigprdisBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * METODOS DE NEGOCIO (operacional - distribuicao de produtos)
    *==========================================================================

    *--------------------------------------------------------------------------
    * BuscarEstoques - Carrega SigCdCeg (tpcads=3) com flag nMarca para selecao
    * Cria cursor_4c_Estoques: nMarca, cidchaves, emps, grupos, contas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarEstoques()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Estoques")
                USE IN cursor_4c_Estoques
            ENDIF

            loc_cSQL = "SELECT 0 AS nMarca, cidchaves, emps, grupos, contas" + ;
                       " FROM SigCdCeg" + ;
                       " WHERE tpcads = 3" + ;
                       " ORDER BY emps, grupos, contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoques")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_Estoques")
                    GO TOP IN cursor_4c_Estoques
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarEstoques:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarLote - Carrega todas as linhas SigPrDis de um lote
    * Cria cursor_4c_LotePrDis com todos os campos de SigPrDis
    *--------------------------------------------------------------------------
    PROCEDURE InicializarLote(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_LotePrDis")
                USE IN cursor_4c_LotePrDis
            ENDIF

            loc_cSQL = "SELECT * FROM SigPrDis" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_LotePrDis")

            IF loc_nResultado < 0
                MsgErro("Erro ao inicializar lote:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_LotePrDis")
                    GO TOP IN cursor_4c_LotePrDis
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em InicializarLote:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararCursoresDistribuicao
    * Prepara cursor_4c_Disponivel e cursor_4c_Distribui a partir dos
    * estoques marcados em cursor_4c_Estoques.
    * par_cCodigos : codigo do lote (vazio se INSERIR)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE PrepararCursoresDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nSel
        LOCAL loc_cEmp, loc_cGrupo, loc_cConta, loc_nQtdDistr
        loc_lSucesso = .F.

        TRY
            *-- Contar estoques marcados
            loc_nSel = 0
            IF USED("cursor_4c_Estoques")
                SELECT cursor_4c_Estoques
                COUNT FOR nMarca = 1 TO loc_nSel
            ENDIF

            IF loc_nSel = 0
                MsgAviso("Nenhum estoque foi selecionado.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            *-- Fechar cursores anteriores
            IF USED("cursor_4c_Disponivel")
                USE IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                USE IN cursor_4c_Distribui
            ENDIF

            *-- Montar cursor_4c_Disponivel
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "SELECT a.cpros, ISNULL(p.dpros,'') AS dpros," + ;
                           "  a.codcors, a.codtams," + ;
                           "  SUM(a.qtdos) AS QtdEstoque," + ;
                           "  SUM(a.qtds)  AS QtdSaida," + ;
                           "  (SUM(a.qtdos) - SUM(a.qtds)) AS QtdSaldo" + ;
                           " FROM SigPrDis a" + ;
                           " LEFT JOIN SigCdPro p ON p.cpros = a.cpros" + ;
                           " WHERE a.Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " GROUP BY a.cpros, p.dpros, a.codcors, a.codtams" + ;
                           " ORDER BY a.cpros, a.codcors, a.codtams"
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Disponivel")
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar produtos disponivel:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Disponivel ;
                    (cpros C(14), dpros C(65), codcors C(4), codtams C(4), ;
                     QtdEstoque N(10,2), QtdSaida N(10,2), QtdSaldo N(10,2))
                SET NULL OFF
            ENDIF

            *-- Montar cursor_4c_Distribui a partir dos estoques marcados
            SET NULL ON
            CREATE CURSOR cursor_4c_Distribui ;
                (emps C(3), grupos C(10), contas C(10), ;
                 QtdSaldo N(10,2), QtdDistr N(10,2), locals C(10))
            SET NULL OFF

            SELECT cursor_4c_Estoques
            GO TOP
            DO WHILE !EOF("cursor_4c_Estoques")
                IF cursor_4c_Estoques.nMarca = 1
                    loc_cEmp   = ALLTRIM(cursor_4c_Estoques.emps)
                    loc_cGrupo = ALLTRIM(cursor_4c_Estoques.grupos)
                    loc_cConta = ALLTRIM(cursor_4c_Estoques.contas)
                    loc_nQtdDistr = 0

                    IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND ;
                       !EMPTY(par_cCodigos) AND ;
                       USED("cursor_4c_LotePrDis")
                        SELECT cursor_4c_LotePrDis
                        GO TOP
                        SCAN FOR ALLTRIM(empds) = loc_cEmp
                            loc_nQtdDistr = loc_nQtdDistr + qtds
                        ENDSCAN
                    ENDIF

                    INSERT INTO cursor_4c_Distribui ;
                        (emps, grupos, contas, QtdSaldo, QtdDistr, locals) ;
                        VALUES (loc_cEmp, loc_cGrupo, loc_cConta, 0, loc_nQtdDistr, "")
                ENDIF
                SELECT cursor_4c_Estoques
                SKIP
            ENDDO

            IF USED("cursor_4c_Disponivel")
                GO TOP IN cursor_4c_Disponivel
            ENDIF
            IF USED("cursor_4c_Distribui")
                GO TOP IN cursor_4c_Distribui
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em PrepararCursoresDistribuicao:" + CHR(13) + ;
                    loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CalcularSaldo - Recalcula QtdSaldo em cursor_4c_Disponivel
    * Chamado apos edicao de QtdDistr em cursor_4c_Distribui
    * par_cCpros/par_cCodCors/par_cCodTams: produto selecionado
    *--------------------------------------------------------------------------
    PROCEDURE CalcularSaldo(par_cCpros, par_cCodCors, par_cCodTams)
        LOCAL loc_nQtdDistr, loc_nQtdEstoque, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Distribui") OR !USED("cursor_4c_Disponivel")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_Distribui
            SUM QtdDistr TO loc_nQtdDistr

            SELECT cursor_4c_Disponivel
            LOCATE FOR ALLTRIM(cpros)   = ALLTRIM(par_cCpros)  AND ;
                        ALLTRIM(codcors) = ALLTRIM(par_cCodCors) AND ;
                        ALLTRIM(codtams) = ALLTRIM(par_cCodTams)

            IF FOUND()
                loc_nQtdEstoque = cursor_4c_Disponivel.QtdEstoque

                IF loc_nQtdEstoque - loc_nQtdDistr < 0
                    MsgAviso("Saldo insuficiente para movimentar.", "Aviso")
                    SELECT cursor_4c_Distribui
                    GO TOP
                    REPLACE ALL QtdDistr WITH 0
                    loc_nQtdDistr = 0
                    *-- Recalcular apos zerar
                    SELECT cursor_4c_Distribui
                    SUM QtdDistr TO loc_nQtdDistr
                ENDIF

                SELECT cursor_4c_Disponivel
                REPLACE QtdSaida WITH loc_nQtdDistr
                REPLACE QtdSaldo WITH (loc_nQtdEstoque - loc_nQtdDistr)
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loException
            MsgErro("Erro em CalcularSaldo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarProduto - Carrega detalhes de produto para exibicao no painel lateral
    * Cria cursor_4c_Produto com campos do SigCdPro + joins
    *--------------------------------------------------------------------------
    PROCEDURE BuscarProduto(par_cCpros)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis," + ;
                       "  a.reffs, a.valors, a.moedas, a.pvens, a.moevs," + ;
                       "  a.pesoms, a.linhas, a.situas, a.colecoes," + ;
                       "  a.pcuss, a.moecs, a.pvideals, a.ifors," + ;
                       "  ISNULL(c.Rclis, '') AS rclis," + ;
                       "  ISNULL(g.dgrus, '') AS dgrus" + ;
                       " FROM SigCdPro a" + ;
                       " LEFT JOIN SigCdCli c ON c.iclis = a.ifors" + ;
                       " LEFT JOIN SigCdGrp g ON g.cgrus = a.cgrus" + ;
                       " WHERE a.cpros = " + EscaparSQL(par_cCpros)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Produto") > 0
                GO TOP IN cursor_4c_Produto
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarProduto:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarDistribuicao
    * Grava o lote de distribuicao em SigPrDis a partir de cursor_4c_Distribui
    * e cursor_4c_Disponivel. Usa transacao explicita para garantir atomicidade.
    * par_cCodigos : codigo do lote (Codigos)
    * par_cEscolha : "INSERIR" ou "ALTERAR"
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarDistribuicao(par_cCodigos, par_cEscolha)
        LOCAL loc_lSucesso, loc_lTransacaoAberta
        LOCAL loc_cSQL, loc_nResultado
        LOCAL loc_cCidChaves, loc_cCpros, loc_cCodCors, loc_cCodTams
        LOCAL loc_nQtdDistr, loc_cEmps, loc_cGrupos, loc_cContas
        LOCAL loc_nTotDis, loc_nQtdNeg

        loc_lSucesso         = .F.
        loc_lTransacaoAberta = .F.

        *-- Validar cursor_4c_Distribui tem quantidades
        IF !USED("cursor_4c_Distribui")
            MsgAviso("Cursor de distribui" + CHR(231) + CHR(227) + CHR(227) + ;
                     "o n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Aviso")
            RETURN .F.
        ENDIF

        SELECT cursor_4c_Distribui
        SUM QtdDistr TO loc_nTotDis
        IF loc_nTotDis = 0
            MsgAviso("Nenhum produto foi informado para distribuir.", "Aviso")
            RETURN .F.
        ENDIF

        *-- Validar sem saldos negativos em cursor_4c_Disponivel
        IF USED("cursor_4c_Disponivel")
            SELECT cursor_4c_Disponivel
            GO TOP
            COUNT FOR QtdSaldo < 0 TO loc_nQtdNeg
            IF loc_nQtdNeg > 0
                MsgAviso("Existem produtos distribu" + CHR(237) + "dos que est" + ;
                         CHR(227) + "o ficando com saldo negativo." + CHR(13) + ;
                         "Favor checar antes de processar.", "Aviso")
                RETURN .F.
            ENDIF
        ENDIF

        TRY
            SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
            loc_lTransacaoAberta = .T.

            *-- Se ALTERAR: remover linhas existentes do lote
            IF UPPER(ALLTRIM(par_cEscolha)) = "ALTERAR" AND !EMPTY(par_cCodigos)
                loc_cSQL = "DELETE FROM SigPrDis WHERE Codigos = " + ;
                           EscaparSQL(par_cCodigos)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado < 0
                    SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                    MsgErro("Erro ao remover lote anterior:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                ENDIF
            ENDIF

            *-- Para cada produto disponivel x empresa distribui: INSERT em SigPrDis
            IF USED("cursor_4c_Disponivel")
                SELECT cursor_4c_Disponivel
                GO TOP
                DO WHILE !EOF("cursor_4c_Disponivel")
                    loc_cCpros   = ALLTRIM(cursor_4c_Disponivel.cpros)
                    loc_cCodCors = ALLTRIM(cursor_4c_Disponivel.codcors)
                    loc_cCodTams = ALLTRIM(cursor_4c_Disponivel.codtams)

                    SELECT cursor_4c_Distribui
                    GO TOP
                    DO WHILE !EOF("cursor_4c_Distribui")
                        loc_nQtdDistr = cursor_4c_Distribui.QtdDistr
                        loc_cEmps     = ALLTRIM(cursor_4c_Distribui.emps)
                        loc_cGrupos   = ALLTRIM(cursor_4c_Distribui.grupos)
                        loc_cContas   = ALLTRIM(cursor_4c_Distribui.contas)

                        IF loc_nQtdDistr > 0
                            loc_cCidChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigPrDis" + ;
                                       " (cidchaves, codigos, codcors, codtams, cpros," + ;
                                       "  datas, dtalts, empdopnums, empds, empgruests," + ;
                                       "  locals, qtdos, qtds, usualts, usuars, oridopnums)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cCidChaves)                               + "," + ;
                                       EscaparSQL(par_cCodigos)                                 + "," + ;
                                       EscaparSQL(loc_cCodCors)                                 + "," + ;
                                       EscaparSQL(loc_cCodTams)                                 + "," + ;
                                       EscaparSQL(loc_cCpros)                                   + "," + ;
                                       "GETDATE(),"                                                    + ;
                                       "GETDATE(),"                                                    + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(loc_cEmps)                                    + "," + ;
                                       EscaparSQL(loc_cEmps + loc_cGrupos + loc_cContas)        + "," + ;
                                       EscaparSQL(ALLTRIM(cursor_4c_Distribui.locals))          + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       FormatarNumeroSQL(loc_nQtdDistr)                         + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10))                + "," + ;
                                       "'')"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                            IF loc_nResultado < 0
                                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                                MsgErro("Erro ao inserir linha de distribui" + ;
                                        CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                                        CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                        ENDIF

                        SELECT cursor_4c_Distribui
                        SKIP
                    ENDDO

                    SELECT cursor_4c_Disponivel
                    SKIP
                ENDDO
            ENDIF

            SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
            loc_lTransacaoAberta = .F.

            THIS.this_cCodigos = par_cCodigos
            THIS.RegistrarAuditoria(IIF(UPPER(ALLTRIM(par_cEscolha)) = "INSERIR", "INSERT", "UPDATE"))
            loc_lSucesso = .T.

        CATCH TO loException
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
            MsgErro("Erro em ProcessarDistribuicao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega operacoes de SigMvCab geradas pela distribuicao
    * Cria cursor_4c_CabOpera: cidchaves, emps, dopes, numes, grupos, datas
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CabOpera")
                USE IN cursor_4c_CabOpera
            ENDIF

            loc_cSQL = "SELECT m.cidchaves, m.emps, m.dopes, m.numes," + ;
                       "  m.grupos, m.datas, m.empdopnums" + ;
                       " FROM SigMvCab m" + ;
                       " WHERE m.empdopnums IN (" + ;
                       "   SELECT DISTINCT empdopnums FROM SigPrDis" + ;
                       "   WHERE Codigos = " + EscaparSQL(par_cCodigos) + ")" + ;
                       " ORDER BY m.emps, m.dopes, m.numes"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CabOpera")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_CabOpera")
                    GO TOP IN cursor_4c_CabOpera
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarItensOperacao - Carrega itens distribuidos de uma operacao/lote
    * Cria cursor_4c_ItnOpera: cidchaves, cpros, dpros, codcors, codtams, qtds, qtdos
    *--------------------------------------------------------------------------
    PROCEDURE BuscarItensOperacao(par_cEmpdopNums)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_ItnOpera")
                USE IN cursor_4c_ItnOpera
            ENDIF

            loc_cSQL = "SELECT d.cidchaves, d.cpros, ISNULL(p.dpros,'') AS dpros," + ;
                       "  d.codcors, d.codtams, d.qtds, d.qtdos" + ;
                       " FROM SigPrDis d" + ;
                       " LEFT JOIN SigCdPro p ON p.cpros = d.cpros" + ;
                       " WHERE d.empdopnums = " + EscaparSQL(par_cEmpdopNums) + ;
                       " ORDER BY d.cpros, d.codcors, d.codtams"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ItnOpera")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar itens da opera" + CHR(231) + CHR(227) + CHR(227) + "o:" + ;
                        CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ItnOpera")
                    GO TOP IN cursor_4c_ItnOpera
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarItensOperacao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

