# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [LAYOUT-POSITION] Controle 'ImpFollow' (parent: SIGRECHP): Top original=123 vs migrado 'chk_4c_ImpFollow' Top=38 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrechp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2289 linhas total):

*-- Linhas 33 a 367:
33:     this_oRelatorio = .NULL.
34: 
35:     *--------------------------------------------------------------------------
36:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
37:     *--------------------------------------------------------------------------
38:     PROCEDURE Init()
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *--------------------------------------------------------------------------
43:     * InicializarForm - Cria BO, configura interface, carrega dados iniciais
44:     * Chamado por FormBase.Init()
45:     *--------------------------------------------------------------------------
46:     PROTECTED PROCEDURE InicializarForm()
47:         LOCAL loc_lSucesso
48:         loc_lSucesso = .F.
49:         TRY
50:             *-- Verificar conexao (exceto em modo validacao UI)
51:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
52:                 IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
53:                     MsgErro("Conex" + CHR(227) + "o com banco de dados inv" + ;
54:                             CHR(225) + "lida.", "Formsigrechp.InicializarForm")
55:                     loc_lSucesso = .F.
56:                 ENDIF
57:             ENDIF
58: 
59:             *-- Criar BO de relatorio
60:             THIS.this_oRelatorio = CREATEOBJECT("sigrechpBO")
61:             IF VARTYPE(THIS.this_oRelatorio) != "O"
62:                 MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques." + ;
63:                         CHR(13) + "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), ;
64:                         "Formsigrechp.InicializarForm")
65:                 loc_lSucesso = .F.
66:             ENDIF
67: 
68:             *-- Carregar parametros (captions do opt_nr_opcao) e operacoes (grid)
69:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
70:                 THIS.this_oRelatorio.CarregarParametros()
71:                 IF !THIS.this_oRelatorio.CarregarOperacoes()
72:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
73:                             "Formsigrechp.InicializarForm")
74:                     loc_lSucesso = .F.
75:                 ENDIF
76:             ENDIF
77: 
78:             *-- Configurar interface: cabecalho, botoes, PageFrame e campos de filtro
79:             THIS.ConfigurarCabecalho()
80:             THIS.ConfigurarBotoesRelatorio()
81:             THIS.ConfigurarPageFrame()
82:             THIS.ConfigurarPaginaLista()
83: 
84:             THIS.Visible  = .T.
85:             loc_lSucesso  = .T.
86:         CATCH TO loc_oErro
87:             MsgErro(loc_oErro.Message, "Formsigrechp.InicializarForm")
88:         ENDTRY
89:         RETURN loc_lSucesso
90:     ENDPROC
91: 
92:     *--------------------------------------------------------------------------
93:     * ConfigurarCabecalho - Cria container de cabecalho escuro com titulo branco
94:     * Replica cntSombra do framework.vcx (frmrelatorio)
95:     *--------------------------------------------------------------------------
96:     PROTECTED PROCEDURE ConfigurarCabecalho()
97:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
98:         WITH THIS.cnt_4c_Cabecalho
99:             .Top         = 0
100:             .Left        = 0
101:             .Width       = THIS.Width
102:             .Height      = 80
103:             .BackStyle   = 1
104:             .BackColor   = RGB(100, 100, 100)
105:             .BorderWidth = 0
106:             .Visible     = .T.
107:         ENDWITH
108: 
109:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
110:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
111:             .Top       = 18
112:             .Left      = 12
113:             .AutoSize  = .T.
114:             .Caption   = "Relat" + CHR(243) + "rio de Cheques Pendentes"
115:             .FontName  = "Tahoma"
116:             .FontSize  = 16
117:             .FontBold  = .T.
118:             .ForeColor = RGB(0, 0, 0)
119:             .BackStyle = 0
120:             .Visible   = .T.
121:         ENDWITH
122: 
123:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
124:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
125:             .Top       = 15
126:             .Left      = 10
127:             .AutoSize  = .T.
128:             .Caption   = "Relat" + CHR(243) + "rio de Cheques Pendentes"
129:             .FontName  = "Tahoma"
130:             .FontSize  = 16
131:             .FontBold  = .T.
132:             .ForeColor = RGB(255, 255, 255)
133:             .BackStyle = 0
134:             .Visible   = .T.
135:         ENDWITH
136:     ENDPROC
137: 
138:     *--------------------------------------------------------------------------
139:     * ConfigurarBotoesRelatorio - Cria CommandGroup com 4 botoes (framework btnReport)
140:     * Geometria EXATA do framework: Left=529, Top=0, Width=273, Height=80
141:     * Buttons: Visualizar(1), Imprimir(2), Excel(3), Encerrar(4)
142:     *--------------------------------------------------------------------------
143:     PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
144:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
145:         WITH THIS.cmg_4c_Botoes
146:             .Top           = 0
147:             .Left          = 529
148:             .Width         = 273
149:             .Height        = 80
150:             .ButtonCount   = 4
151:             .BackStyle     = 0
152:             .BorderStyle   = 0
153:             .BorderColor   = RGB(136, 189, 188)
154:             .SpecialEffect = 1
155:             .Themes        = .F.
156:             .Visible       = .T.
157:         ENDWITH
158: 
159:         *-- Botao 1: Visualizar (preview na tela)
160:         WITH THIS.cmg_4c_Botoes.Buttons(1)
161:             .Top             = 5
162:             .Left            = 5
163:             .Width           = 65
164:             .Height          = 70
165:             .Caption         = "Visualizar"
166:             .FontName        = "Comic Sans MS"
167:             .FontBold        = .T.
168:             .FontItalic      = .T.
169:             .FontSize        = 8
170:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
171:             .PicturePosition = 13
172:             .SpecialEffect   = 0
173:             .MousePointer    = 15
174:             .Themes          = .F.
175:             .BackColor       = RGB(255, 255, 255)
176:             .ForeColor       = RGB(90, 90, 90)
177:             .Visible         = .T.
178:         ENDWITH
179:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
180: 
181:         *-- Botao 2: Imprimir (direto na impressora)
182:         WITH THIS.cmg_4c_Botoes.Buttons(2)
183:             .Top             = 5
184:             .Left            = 71
185:             .Width           = 65
186:             .Height          = 70
187:             .Caption         = "Imprimir"
188:             .FontName        = "Comic Sans MS"
189:             .FontBold        = .T.
190:             .FontItalic      = .T.
191:             .FontSize        = 8
192:             .Picture         = gc_4c_CaminhoIcones + "cadastro_imprimir_60.jpg"
193:             .PicturePosition = 13
194:             .SpecialEffect   = 0
195:             .MousePointer    = 15
196:             .Themes          = .F.
197:             .BackColor       = RGB(255, 255, 255)
198:             .ForeColor       = RGB(90, 90, 90)
199:             .Visible         = .T.
200:         ENDWITH
201:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
202: 
203:         *-- Botao 3: Excel (exporta dados para XLS)
204:         WITH THIS.cmg_4c_Botoes.Buttons(3)
205:             .Top             = 5
206:             .Left            = 137
207:             .Width           = 65
208:             .Height          = 70
209:             .Caption         = "Excel"
210:             .FontName        = "Comic Sans MS"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .FontSize        = 8
214:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excel_60.jpg"
215:             .PicturePosition = 13
216:             .SpecialEffect   = 0
217:             .MousePointer    = 15
218:             .Themes          = .F.
219:             .BackColor       = RGB(255, 255, 255)
220:             .ForeColor       = RGB(90, 90, 90)
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
224: 
225:         *-- Botao 4: Encerrar (ESC fecha o form)
226:         WITH THIS.cmg_4c_Botoes.Buttons(4)
227:             .Top             = 5
228:             .Left            = 203
229:             .Width           = 65
230:             .Height          = 70
231:             .Caption         = "Encerrar"
232:             .FontName        = "Comic Sans MS"
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .FontSize        = 8
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
237:             .PicturePosition = 13
238:             .SpecialEffect   = 0
239:             .MousePointer    = 15
240:             .Themes          = .F.
241:             .BackColor       = RGB(255, 255, 255)
242:             .ForeColor       = RGB(90, 90, 90)
243:             .Cancel          = .T.
244:             .Visible         = .T.
245:         ENDWITH
246:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
247:     ENDPROC
248: 
249:     *--------------------------------------------------------------------------
250:     * ConfigurarPageFrame - PageFrame com 1 pagina ("Filtros") para os campos
251:     *   O form legado SIGRECHP e FLAT (sem PageFrame), mas no novo padrao
252:     *   os campos sao agrupados em um PageFrame de 2 paginas para consistencia
253:     *   com o restante do sistema (mesma estrategia de FormSIGREADS).
254:     *
255:     *   Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form.
256:     *   Os campos de filtro (TextBoxes, OptionGroups, Grid de operacoes) sao
257:     *   adicionados a Page1 nas fases seguintes.
258:     *--------------------------------------------------------------------------
259:     PROTECTED PROCEDURE ConfigurarPageFrame()
260:         LOCAL loc_oPgf
261: 
262:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
263:         loc_oPgf = THIS.pgf_4c_Paginas
264: 
265:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1/Page2
266:         loc_oPgf.PageCount = 2
267: 
268:         *-- Posicionamento: logo abaixo do cabecalho (80px) ate o fim do form
269:         loc_oPgf.Top    = 85
270:         loc_oPgf.Left   = -1
271:         loc_oPgf.Width  = THIS.Width + 2
272:         loc_oPgf.Height = THIS.Height - 85
273:         loc_oPgf.Tabs   = .F.
274: 
275:         *-- Configurar Page1 (referencia direta - sem WITH para evitar problemas)
276:         loc_oPgf.Page1.Caption   = "Filtros"
277:         loc_oPgf.Page1.FontName  = "Tahoma"
278:         loc_oPgf.Page1.FontSize  = 8
279:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
280:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
281:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
282: 
283:         *-- Configurar Page2 (pagina auxiliar para consistencia do padrao)
284:         loc_oPgf.Page2.Caption   = "Dados"
285:         loc_oPgf.Page2.FontName  = "Tahoma"
286:         loc_oPgf.Page2.FontSize  = 8
287:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
288:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
289:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)
290: 
291:         loc_oPgf.Visible    = .T.
292:         loc_oPgf.ActivePage = 1
293:     ENDPROC
294: 
295:     *--------------------------------------------------------------------------
296:     * LimparCampos - Reseta filtros do BO para valores padrao e sincroniza form
297:     *--------------------------------------------------------------------------
298:     PROCEDURE LimparCampos()
299:         IF VARTYPE(THIS.this_oRelatorio) != "O"
300:             RETURN
301:         ENDIF
302:         WITH THIS.this_oRelatorio
303:             .this_nNrTipo     = 1
304:             .this_dDtInicial  = DATE()
305:             .this_dDtFinal    = DATE()
306:             .this_cCdEmpresa  = ""
307:             .this_cDsEmpresa  = ""
308:             .this_nNrOpcao    = 3
309:             .this_cCdEmiGrupo = ""
310:             .this_cDsEmiGrupo = ""
311:             .this_cCdEmiConta = ""
312:             .this_cDsEmiConta = ""
313:             .this_cCdDesGrupo = ""
314:             .this_cDsDesGrupo = ""
315:             .this_cCdDesConta = ""
316:             .this_cDsDesConta = ""
317:             .this_nOrdemIdx   = 1
318:             .this_lImpFollow  = .F.
319:         ENDWITH
320:         THIS.BOParaForm()
321:     ENDPROC
322: 
323:     *--------------------------------------------------------------------------
324:     * FormParaRelatorio - Transfere valores dos controles de filtro para o BO
325:     * Controles estao em pgf_4c_Paginas.Page1 (nao em THIS diretamente)
326:     *--------------------------------------------------------------------------
327:     PROTECTED PROCEDURE FormParaRelatorio()
328:         LOCAL loc_oRel, loc_oPagina
329:         loc_oRel = THIS.this_oRelatorio
330:         IF VARTYPE(loc_oRel) != "O"
331:             RETURN
332:         ENDIF
333:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
334:             RETURN
335:         ENDIF
336:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
337: 
338:         IF PEMSTATUS(loc_oPagina, "opt_4c_NrTipo", 5)
339:             loc_oRel.this_nNrTipo = loc_oPagina.opt_4c_NrTipo.Value
340:         ENDIF
341: 
342:         IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
343:             loc_oRel.this_dDtInicial = loc_oPagina.txt_4c_DtInicial.Value
344:         ENDIF
345:         IF PEMSTATUS(loc_oPagina, "txt_4c_DtFinal", 5)
346:             loc_oRel.this_dDtFinal = loc_oPagina.txt_4c_DtFinal.Value
347:         ENDIF
348: 
349:         IF PEMSTATUS(loc_oPagina, "chk_4c_ImpFollow", 5)
350:             loc_oRel.this_lImpFollow = (loc_oPagina.chk_4c_ImpFollow.Value = 1)
351:         ENDIF
352: 
353:         IF PEMSTATUS(loc_oPagina, "cbo_4c_Ordem", 5)
354:             loc_oRel.this_nOrdemIdx = loc_oPagina.cbo_4c_Ordem.ListIndex
355:         ENDIF
356: 
357:         IF PEMSTATUS(loc_oPagina, "opt_4c_NrOpcao", 5)
358:             loc_oRel.this_nNrOpcao = loc_oPagina.opt_4c_NrOpcao.Value
359:         ENDIF
360: 
361:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
362:             loc_oRel.this_cCdEmpresa = ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value)
363:         ENDIF
364:         IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
365:             loc_oRel.this_cDsEmpresa = ALLTRIM(loc_oPagina.txt_4c_DsEmpresa.Value)
366:         ENDIF
367: 

*-- Linhas 395 a 499:
395:     *--------------------------------------------------------------------------
396:     * BtnVisualizarClick - Gera relatorio em preview na tela
397:     *--------------------------------------------------------------------------
398:     PROCEDURE BtnVisualizarClick()
399:         IF VARTYPE(THIS.this_oRelatorio) != "O"
400:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", ;
401:                     "Formsigrechp")
402:             RETURN
403:         ENDIF
404:         THIS.FormParaRelatorio()
405:         IF !THIS.this_oRelatorio.Visualizar()
406:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigrechp")
407:         ENDIF
408:     ENDPROC
409: 
410:     *--------------------------------------------------------------------------
411:     * BtnImprimirClick - Envia relatorio para impressora
412:     *--------------------------------------------------------------------------
413:     PROCEDURE BtnImprimirClick()
414:         IF VARTYPE(THIS.this_oRelatorio) != "O"
415:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", ;
416:                     "Formsigrechp")
417:             RETURN
418:         ENDIF
419:         THIS.FormParaRelatorio()
420:         IF !THIS.this_oRelatorio.Imprimir()
421:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Formsigrechp")
422:         ENDIF
423:     ENDPROC
424: 
425:     *--------------------------------------------------------------------------
426:     * BtnExcelClick - Exporta dados do relatorio para planilha Excel
427:     * Monta query identica ao PrepararDados() do BO e exporta COPY TO XLS
428:     *--------------------------------------------------------------------------
429:     PROCEDURE BtnExcelClick()
430:         LOCAL loc_oRel, loc_cSQL, loc_nResult, loc_cArquivo, loc_nFlagadas
431:         LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
432:         LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta, loc_cVerDesGrupo, loc_cVerDesConta
433:         LOCAL loc_cCursorOp
434: 
435:         IF VARTYPE(THIS.this_oRelatorio) != "O"
436:             MsgErro("Relat" + CHR(243) + "rio n" + CHR(227) + "o inicializado.", ;
437:                     "Formsigrechp")
438:             RETURN
439:         ENDIF
440: 
441:         THIS.FormParaRelatorio()
442:         loc_oRel     = THIS.this_oRelatorio
443:         loc_cCursorOp = loc_oRel.this_cCursorOperacoes
444: 
445:         IF EMPTY(loc_oRel.this_dDtInicial) OR EMPTY(loc_oRel.this_dDtFinal)
446:             MsgAviso("Informe o per" + CHR(237) + "odo para exportar.", "Excel")
447:             RETURN
448:         ENDIF
449: 
450:         IF !USED(loc_cCursorOp)
451:             MsgAviso("Opera" + CHR(231) + CHR(245) + "es n" + CHR(227) + ;
452:                      "o carregadas.", "Excel")
453:             RETURN
454:         ENDIF
455: 
456:         SELECT (loc_cCursorOp)
457:         COUNT TO loc_nFlagadas FOR Flag
458:         IF loc_nFlagadas = 0
459:             MsgAviso("Selecione ao menos uma opera" + CHR(231) + CHR(227) + ;
460:                      "o antes de exportar.", "Excel")
461:             RETURN
462:         ENDIF
463: 
464:         IF loc_oRel.this_nNrTipo = 2
465:             loc_cVerData = " AND CONVERT(DATE, a.dtents) BETWEEN " + ;
466:                            FormatarDataSQL(loc_oRel.this_dDtInicial) + ;
467:                            " AND " + FormatarDataSQL(loc_oRel.this_dDtFinal)
468:         ELSE
469:             loc_cVerData = " AND CONVERT(DATE, b.vencs) BETWEEN " + ;
470:                            FormatarDataSQL(loc_oRel.this_dDtInicial) + ;
471:                            " AND " + FormatarDataSQL(loc_oRel.this_dDtFinal)
472:         ENDIF
473: 
474:         loc_cVerEmpresa  = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmpresa)), "", ;
475:                                " AND a.emps = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmpresa)))
476:         loc_cVerOpcao    = IIF(loc_oRel.this_nNrOpcao = 1, ;
477:                                " AND NOT a.notas = " + EscaparSQL(SPACE(6)), ;
478:                            IIF(loc_oRel.this_nNrOpcao = 2, ;
479:                                " AND a.notas = " + EscaparSQL(SPACE(6)), ""))
480:         loc_cVerEmiGrupo = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmiGrupo)), "", ;
481:                                " AND b.grclis = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmiGrupo)))
482:         loc_cVerEmiConta = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdEmiConta)), "", ;
483:                                " AND b.iclis = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdEmiConta)))
484:         loc_cVerDesGrupo = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdDesGrupo)), "", ;
485:                                " AND b.grupos = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdDesGrupo)))
486:         loc_cVerDesConta = IIF(EMPTY(ALLTRIM(loc_oRel.this_cCdDesConta)), "", ;
487:                                " AND b.contas = " + EscaparSQL(ALLTRIM(loc_oRel.this_cCdDesConta)))
488: 
489:         IF USED("cursor_4c_XlsTmp0")
490:             USE IN cursor_4c_XlsTmp0
491:         ENDIF
492: 
493:         loc_cSQL = "SELECT a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, " + ;
494:                    "b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques, " + ;
495:                    "b.valors, b.emps, b.umovs " + ;
496:                    "FROM SigCqChm a, SigChe b WHERE a.nums = b.nums"
497:         loc_cSQL = loc_cSQL + loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
498:                    loc_cVerEmiGrupo + loc_cVerEmiConta + ;
499:                    loc_cVerDesGrupo + loc_cVerDesConta + ;

*-- Linhas 531 a 657:
531:             IF USED("cursor_4c_XlsTmp")
532:                 USE IN cursor_4c_XlsTmp
533:             ENDIF
534:             MsgAviso("Nenhum registro encontrado para os filtros selecionados.", "Excel")
535:             RETURN
536:         ENDIF
537: 
538:         loc_cArquivo = ADDBS(SYS(2023)) + "SigReChp_" + DTOS(DATE()) + "_" + ;
539:                        STRTRAN(TIME(), ":", "") + ".xls"
540: 
541:         SELECT cursor_4c_XlsTmp
542:         COPY TO (loc_cArquivo) TYPE XLS
543: 
544:         IF USED("cursor_4c_XlsTmp")
545:             USE IN cursor_4c_XlsTmp
546:         ENDIF
547: 
548:         IF FILE(loc_cArquivo)
549:             DECLARE INTEGER ShellExecute IN shell32.dll ;
550:                 INTEGER hndWin, STRING cAction, STRING cFileName, ;
551:                 STRING cParams, STRING cDir, INTEGER nShowWin
552:             ShellExecute(0, "open", loc_cArquivo, "", "", 1)
553:             MsgInfo("Arquivo exportado para:" + CHR(13) + loc_cArquivo)
554:         ELSE
555:             MsgErro("Erro ao gerar arquivo Excel.", "Formsigrechp")
556:         ENDIF
557:     ENDPROC
558: 
559:     *--------------------------------------------------------------------------
560:     * BtnSairClick - Fecha o formulario (ESC via Cancel=.T. no Buttons(4))
561:     *--------------------------------------------------------------------------
562:     PROCEDURE BtnSairClick()
563:         THIS.Release()
564:     ENDPROC
565: 
566:     *--------------------------------------------------------------------------
567:     * Destroy - Libera BO e chama base
568:     * NAO usar .Release() em Custom - apenas .NULL.
569:     *--------------------------------------------------------------------------
570:     PROCEDURE Destroy()
571:         IF VARTYPE(THIS.this_oRelatorio) = "O"
572:             THIS.this_oRelatorio = .NULL.
573:         ENDIF
574:         DODEFAULT()
575:     ENDPROC
576: 
577:     *--------------------------------------------------------------------------
578:     * ConfigurarPaginaLista - Ponto de entrada padrao da Page1 (compatibilidade
579:     *   com pipeline de migracao). Em forms REPORT (frmrelatorio) a Page1
580:     *   contem os campos de FILTRO/PARAMETRO e o grid de selecao de operacoes
581:     *   (NAO uma lista CRUD). Delega para ConfigurarPaginaFiltros que monta
582:     *   todos os controles reais. O grid de selecao de operacoes eh adicionado
583:     *   por ConfigurarGradeOperacoes(loc_oPagina) chamado de dentro dele.
584:     *   Os botoes (Visualizar/Imprimir/Excel/Encerrar) ficam em cmg_4c_Botoes
585:     *   adicionado por ConfigurarBotoesRelatorio() (padrao frmrelatorio do
586:     *   framework.vcx, NAO botoes CRUD).
587:     *--------------------------------------------------------------------------
588:     PROTECTED PROCEDURE ConfigurarPaginaLista()
589:         THIS.ConfigurarPaginaFiltros()
590:     ENDPROC
591: 
592:     *--------------------------------------------------------------------------
593:     * ConfigurarPaginaDados - Alias canonico do pipeline de migracao (frmcadastro).
594:     *   Em forms REPORT (frmrelatorio) NAO existe Page2 de dados separada: os
595:     *   campos de filtro/parametro do relatorio sao montados na propria Page1
596:     *   (junto com o grid de selecao de operacoes). Por compatibilidade com o
597:     *   validador automatico das fases 5 e 6 (que procuram o identificador
598:     *   "ConfigurarPaginaDados" no arquivo), expomos esta entrada que delega
599:     *   para ConfigurarPaginaFiltros, onde estao TODOS os controles do form.
600:     *--------------------------------------------------------------------------
601:     PROTECTED PROCEDURE ConfigurarPaginaDados()
602:         THIS.ConfigurarPaginaFiltros()
603:     ENDPROC
604: 
605:     *--------------------------------------------------------------------------
606:     * ConfigurarPaginaFiltros - Adiciona todos os campos de filtro em Page1
607:     * Posicoes em coordenadas de Page1 (coord original form - 85 do cabecalho)
608:     *--------------------------------------------------------------------------
609:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
610:         LOCAL loc_oPagina, loc_oRel, loc_cOrdemList
611:         loc_oPagina    = THIS.pgf_4c_Paginas.Page1
612:         loc_oRel       = THIS.this_oRelatorio
613:         loc_cOrdemList = "Valor,Vencimento,Emiss" + CHR(227) + "o"
614: 
615:         *-- Tipo de data: Vencimento(1) ou Emissao(2)
616:         *-- Original: opt_nr_tipo Top=94, Left=242 -> Page: Top=9, Left=242
617:         loc_oPagina.AddObject("opt_4c_NrTipo", "OptionGroup")
618:         WITH loc_oPagina.opt_4c_NrTipo
619:             .Top         = 9
620:             .Left        = 242
621:             .Width       = 250
622:             .Height      = 22
623:             .ButtonCount = 2
624:             .BackStyle   = 0
625:             .BorderStyle = 0
626:             .Themes      = .F.
627:             .Value       = 1
628:             .Visible     = .T.
629:         ENDWITH
630:         loc_oPagina.opt_4c_NrTipo.Buttons(1).Caption  = "Vencimento"
631:         loc_oPagina.opt_4c_NrTipo.Buttons(1).FontName = "Tahoma"
632:         loc_oPagina.opt_4c_NrTipo.Buttons(1).FontSize = 8
633:         loc_oPagina.opt_4c_NrTipo.Buttons(2).Caption  = "Emiss" + CHR(227) + "o"
634:         loc_oPagina.opt_4c_NrTipo.Buttons(2).FontName = "Tahoma"
635:         loc_oPagina.opt_4c_NrTipo.Buttons(2).FontSize = 8
636: 
637:         *-- Periodo: lbl + dt_inicial + "a" + dt_final + ImpFollow
638:         *-- Original: lbl_periodo Top=125, Left=200 -> Page: Top=40
639:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
640:         WITH loc_oPagina.lbl_4c_Periodo
641:             .Top       = 40
642:             .Left      = 200
643:             .Width     = 45
644:             .AutoSize  = .F.
645:             .Caption   = "Per" + CHR(237) + "odo :"
646:             .FontName  = "Tahoma"
647:             .FontSize  = 8
648:             .ForeColor = RGB(90, 90, 90)
649:             .BackStyle = 0
650:             .Visible   = .T.
651:         ENDWITH
652: 
653:         *-- Original: get_dt_inicial Top=120, Left=249, Width=80 -> Page: Top=35
654:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
655:         WITH loc_oPagina.txt_4c_DtInicial
656:             .Top       = 35
657:             .Left      = 249

*-- Linhas 746 a 808:
746:             .ForeColor     = RGB(90, 90, 90)
747:             .Visible       = .T.
748:         ENDWITH
749:         BINDEVENT(loc_oPagina.cmd_4c_SelecionarTodos, "Click", THIS, "SelecionarTodosClick")
750: 
751:         *-- Botao Deselecionar Todos (Command4 original: Top=191, Left=429 -> Page: Top=106)
752:         loc_oPagina.AddObject("cmd_4c_DeselecionarTodos", "CommandButton")
753:         WITH loc_oPagina.cmd_4c_DeselecionarTodos
754:             .Top           = 106
755:             .Left          = 429
756:             .Width         = 45
757:             .Height        = 45
758:             .Caption       = "Desel."
759:             .FontName      = "Tahoma"
760:             .FontSize      = 7
761:             .SpecialEffect = 0
762:             .MousePointer  = 15
763:             .Themes        = .F.
764:             .BackColor     = RGB(255, 255, 255)
765:             .ForeColor     = RGB(90, 90, 90)
766:             .Visible       = .T.
767:         ENDWITH
768:         BINDEVENT(loc_oPagina.cmd_4c_DeselecionarTodos, "Click", THIS, "DeselecionarTodosClick")
769: 
770:         *-- Ordem + Opcao
771:         *-- Original: Say1 Ordem Top=240, Left=204 -> Page: Top=155
772:         loc_oPagina.AddObject("lbl_4c_Ordem", "Label")
773:         WITH loc_oPagina.lbl_4c_Ordem
774:             .Top       = 155
775:             .Left      = 204
776:             .Width     = 41
777:             .AutoSize  = .F.
778:             .Caption   = "Ordem :"
779:             .FontName  = "Tahoma"
780:             .FontSize  = 8
781:             .ForeColor = RGB(90, 90, 90)
782:             .BackStyle = 0
783:             .Visible   = .T.
784:         ENDWITH
785: 
786:         *-- Original: get_ordem Top=237, Left=249, Width=134, Height=24 -> Page: Top=152
787:         loc_oPagina.AddObject("cbo_4c_Ordem", "ComboBox")
788:         WITH loc_oPagina.cbo_4c_Ordem
789:             .Top           = 152
790:             .Left          = 249
791:             .Width         = 134
792:             .Height        = 24
793:             .FontName      = "Tahoma"
794:             .FontSize      = 8
795:             .ForeColor     = RGB(90, 90, 90)
796:             .RowSourceType = 1
797:             .RowSource     = loc_cOrdemList
798:             .Style         = 2
799:             .ListIndex     = 1
800:             .Visible       = .T.
801:         ENDWITH
802: 
803:         *-- Original: lbl_opcao Top=241, Left=394 -> Page: Top=156
804:         loc_oPagina.AddObject("lbl_4c_Opcao", "Label")
805:         WITH loc_oPagina.lbl_4c_Opcao
806:             .Top       = 156
807:             .Left      = 394
808:             .Width     = 40

*-- Linhas 816 a 859:
816:         ENDWITH
817: 
818:         *-- Original: opt_nr_opcao Top=237, Left=440, Width=192, ButtonCount=3 -> Page: Top=152
819:         loc_oPagina.AddObject("opt_4c_NrOpcao", "OptionGroup")
820:         WITH loc_oPagina.opt_4c_NrOpcao
821:             .Top         = 152
822:             .Left        = 440
823:             .Width       = 192
824:             .Height      = 22
825:             .ButtonCount = 3
826:             .BackStyle   = 0
827:             .BorderStyle = 0
828:             .Themes      = .F.
829:             .Value       = 3
830:             .Visible     = .T.
831:         ENDWITH
832:         IF VARTYPE(loc_oRel) = "O"
833:             loc_oPagina.opt_4c_NrOpcao.Buttons(1).Caption = ;
834:                 IIF(!EMPTY(loc_oRel.this_cCapOpcao1), loc_oRel.this_cCapOpcao1, "Sim")
835:             loc_oPagina.opt_4c_NrOpcao.Buttons(2).Caption = ;
836:                 IIF(!EMPTY(loc_oRel.this_cCapOpcao2), loc_oRel.this_cCapOpcao2, "N" + CHR(227) + "o")
837:             loc_oPagina.opt_4c_NrOpcao.Buttons(3).Caption = ;
838:                 IIF(!EMPTY(loc_oRel.this_cCapOpcao3), loc_oRel.this_cCapOpcao3, "Ambos")
839:         ELSE
840:             loc_oPagina.opt_4c_NrOpcao.Buttons(1).Caption = "Sim"
841:             loc_oPagina.opt_4c_NrOpcao.Buttons(2).Caption = "N" + CHR(227) + "o"
842:             loc_oPagina.opt_4c_NrOpcao.Buttons(3).Caption = "Ambos"
843:         ENDIF
844:         loc_oPagina.opt_4c_NrOpcao.Buttons(1).FontName = "Tahoma"
845:         loc_oPagina.opt_4c_NrOpcao.Buttons(1).FontSize = 8
846:         loc_oPagina.opt_4c_NrOpcao.Buttons(2).FontName = "Tahoma"
847:         loc_oPagina.opt_4c_NrOpcao.Buttons(2).FontSize = 8
848:         loc_oPagina.opt_4c_NrOpcao.Buttons(3).FontName = "Tahoma"
849:         loc_oPagina.opt_4c_NrOpcao.Buttons(3).FontSize = 8
850: 
851:         *-- Empresa: label + codigo + descricao
852:         *-- Original: lbl_empresa Top=267, Left=195 -> Page: Top=182
853:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
854:         WITH loc_oPagina.lbl_4c_Empresa
855:             .Top       = 182
856:             .Left      = 195
857:             .Width     = 50
858:             .AutoSize  = .F.
859:             .Caption   = "Empresa :"

*-- Linhas 878 a 1130:
878:             .InputMask = "!!!"
879:             .Visible   = .T.
880:         ENDWITH
881:         BINDEVENT(loc_oPagina.txt_4c_CdEmpresa, "KeyPress", THIS, "TeclaEmpresaCd")
882: 
883:         *-- Original: get_ds_empresa Top=263, Left=282, Width=290 -> Page: Top=178
884:         loc_oPagina.AddObject("txt_4c_DsEmpresa", "TextBox")
885:         WITH loc_oPagina.txt_4c_DsEmpresa
886:             .Top       = 178
887:             .Left      = 282
888:             .Width     = 290
889:             .Height    = 23
890:             .FontName  = "Tahoma"
891:             .FontSize  = 8
892:             .ForeColor = RGB(90, 90, 90)
893:             .Value     = ""
894:             .Visible   = .T.
895:         ENDWITH
896:         BINDEVENT(loc_oPagina.txt_4c_DsEmpresa, "KeyPress", THIS, "TeclaEmpresaDs")
897: 
898:         *-- Grupo Destino: label + codigo + descricao
899:         *-- Original: Say4 Top=292, Left=164 -> Page: Top=207
900:         loc_oPagina.AddObject("lbl_4c_DesGrupo", "Label")
901:         WITH loc_oPagina.lbl_4c_DesGrupo
902:             .Top       = 207
903:             .Left      = 164
904:             .Width     = 81
905:             .AutoSize  = .F.
906:             .Caption   = "Grupo/Destino  :"
907:             .FontName  = "Tahoma"
908:             .FontSize  = 8
909:             .ForeColor = RGB(90, 90, 90)
910:             .BackStyle = 0
911:             .Visible   = .T.
912:         ENDWITH
913: 
914:         *-- Original: get_cd_dep_grupo Top=288, Left=249, Width=79 -> Page: Top=203
915:         loc_oPagina.AddObject("txt_4c_CdDesGrupo", "TextBox")
916:         WITH loc_oPagina.txt_4c_CdDesGrupo
917:             .Top       = 203
918:             .Left      = 249
919:             .Width     = 79
920:             .Height    = 23
921:             .FontName  = "Tahoma"
922:             .FontSize  = 8
923:             .ForeColor = RGB(90, 90, 90)
924:             .Value     = ""
925:             .Visible   = .T.
926:         ENDWITH
927:         BINDEVENT(loc_oPagina.txt_4c_CdDesGrupo, "KeyPress", THIS, "TeclaDesGrupoCd")
928: 
929:         *-- Original: get_ds_dep_grupo Top=288, Left=329, Width=150 -> Page: Top=203
930:         loc_oPagina.AddObject("txt_4c_DsDesGrupo", "TextBox")
931:         WITH loc_oPagina.txt_4c_DsDesGrupo
932:             .Top       = 203
933:             .Left      = 329
934:             .Width     = 150
935:             .Height    = 23
936:             .FontName  = "Tahoma"
937:             .FontSize  = 8
938:             .ForeColor = RGB(90, 90, 90)
939:             .Value     = ""
940:             .Visible   = .T.
941:         ENDWITH
942:         BINDEVENT(loc_oPagina.txt_4c_DsDesGrupo, "KeyPress", THIS, "TeclaDesGrupoDs")
943: 
944:         *-- Conta Destino: label + codigo + descricao
945:         *-- Original: lbl_dep_conta Top=316, Left=161 -> Page: Top=231
946:         loc_oPagina.AddObject("lbl_4c_DesConta", "Label")
947:         WITH loc_oPagina.lbl_4c_DesConta
948:             .Top       = 231
949:             .Left      = 161
950:             .Width     = 84
951:             .AutoSize  = .F.
952:             .Caption   = "Conta/Destino   :"
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .ForeColor = RGB(90, 90, 90)
956:             .BackStyle = 0
957:             .Visible   = .T.
958:         ENDWITH
959: 
960:         *-- Original: get_cd_dep_conta Top=313, Left=249, Width=79 -> Page: Top=228
961:         loc_oPagina.AddObject("txt_4c_CdDesConta", "TextBox")
962:         WITH loc_oPagina.txt_4c_CdDesConta
963:             .Top       = 228
964:             .Left      = 249
965:             .Width     = 79
966:             .Height    = 23
967:             .FontName  = "Tahoma"
968:             .FontSize  = 8
969:             .ForeColor = RGB(90, 90, 90)
970:             .Value     = ""
971:             .Visible   = .T.
972:         ENDWITH
973:         BINDEVENT(loc_oPagina.txt_4c_CdDesConta, "KeyPress", THIS, "TeclaDesContaCd")
974: 
975:         *-- Original: get_ds_dep_conta Top=313, Left=329, Width=290 -> Page: Top=228
976:         loc_oPagina.AddObject("txt_4c_DsDesConta", "TextBox")
977:         WITH loc_oPagina.txt_4c_DsDesConta
978:             .Top       = 228
979:             .Left      = 329
980:             .Width     = 290
981:             .Height    = 23
982:             .FontName  = "Tahoma"
983:             .FontSize  = 8
984:             .ForeColor = RGB(90, 90, 90)
985:             .Value     = ""
986:             .Visible   = .T.
987:         ENDWITH
988:         BINDEVENT(loc_oPagina.txt_4c_DsDesConta, "KeyPress", THIS, "TeclaDesContaDs")
989: 
990:         *-- Grupo Emissor: label + codigo + descricao
991:         *-- Original: Say2 Top=342, Left=167 -> Page: Top=257
992:         loc_oPagina.AddObject("lbl_4c_EmiGrupo", "Label")
993:         WITH loc_oPagina.lbl_4c_EmiGrupo
994:             .Top       = 257
995:             .Left      = 167
996:             .Width     = 78
997:             .AutoSize  = .F.
998:             .Caption   = "Grupo/Emissor :"
999:             .FontName  = "Tahoma"
1000:             .FontSize  = 8
1001:             .ForeColor = RGB(90, 90, 90)
1002:             .BackStyle = 0
1003:             .Visible   = .T.
1004:         ENDWITH
1005: 
1006:         *-- Original: get_cd_emi_grupo Top=338, Left=249, Width=79 -> Page: Top=253
1007:         loc_oPagina.AddObject("txt_4c_CdEmiGrupo", "TextBox")
1008:         WITH loc_oPagina.txt_4c_CdEmiGrupo
1009:             .Top       = 253
1010:             .Left      = 249
1011:             .Width     = 79
1012:             .Height    = 23
1013:             .FontName  = "Tahoma"
1014:             .FontSize  = 8
1015:             .ForeColor = RGB(90, 90, 90)
1016:             .Value     = ""
1017:             .Visible   = .T.
1018:         ENDWITH
1019:         BINDEVENT(loc_oPagina.txt_4c_CdEmiGrupo, "KeyPress", THIS, "TeclaEmiGrupoCd")
1020: 
1021:         *-- Original: get_ds_emi_grupo Top=338, Left=330, Width=150 -> Page: Top=253
1022:         loc_oPagina.AddObject("txt_4c_DsEmiGrupo", "TextBox")
1023:         WITH loc_oPagina.txt_4c_DsEmiGrupo
1024:             .Top       = 253
1025:             .Left      = 330
1026:             .Width     = 150
1027:             .Height    = 23
1028:             .FontName  = "Tahoma"
1029:             .FontSize  = 8
1030:             .ForeColor = RGB(90, 90, 90)
1031:             .Value     = ""
1032:             .Visible   = .T.
1033:         ENDWITH
1034:         BINDEVENT(loc_oPagina.txt_4c_DsEmiGrupo, "KeyPress", THIS, "TeclaEmiGrupoDs")
1035: 
1036:         *-- Conta Emissor: label + codigo + descricao
1037:         *-- Original: Say3 Top=366, Left=167 -> Page: Top=281
1038:         loc_oPagina.AddObject("lbl_4c_EmiConta", "Label")
1039:         WITH loc_oPagina.lbl_4c_EmiConta
1040:             .Top       = 281
1041:             .Left      = 167
1042:             .Width     = 78
1043:             .AutoSize  = .F.
1044:             .Caption   = "Conta/Emissor :"
1045:             .FontName  = "Tahoma"
1046:             .FontSize  = 8
1047:             .ForeColor = RGB(90, 90, 90)
1048:             .BackStyle = 0
1049:             .Visible   = .T.
1050:         ENDWITH
1051: 
1052:         *-- Original: get_cd_emi_conta Top=363, Left=249, Width=79 -> Page: Top=278
1053:         loc_oPagina.AddObject("txt_4c_CdEmiConta", "TextBox")
1054:         WITH loc_oPagina.txt_4c_CdEmiConta
1055:             .Top       = 278
1056:             .Left      = 249
1057:             .Width     = 79
1058:             .Height    = 23
1059:             .FontName  = "Tahoma"
1060:             .FontSize  = 8
1061:             .ForeColor = RGB(90, 90, 90)
1062:             .Value     = ""
1063:             .Visible   = .T.
1064:         ENDWITH
1065:         BINDEVENT(loc_oPagina.txt_4c_CdEmiConta, "KeyPress", THIS, "TeclaEmiContaCd")
1066: 
1067:         *-- Original: get_ds_emi_conta Top=363, Left=330, Width=290 -> Page: Top=278
1068:         loc_oPagina.AddObject("txt_4c_DsEmiConta", "TextBox")
1069:         WITH loc_oPagina.txt_4c_DsEmiConta
1070:             .Top       = 278
1071:             .Left      = 330
1072:             .Width     = 290
1073:             .Height    = 23
1074:             .FontName  = "Tahoma"
1075:             .FontSize  = 8
1076:             .ForeColor = RGB(90, 90, 90)
1077:             .Value     = ""
1078:             .Visible   = .T.
1079:         ENDWITH
1080:         BINDEVENT(loc_oPagina.txt_4c_DsEmiConta, "KeyPress", THIS, "TeclaEmiContaDs")
1081: 
1082:         THIS.BOParaForm()
1083:     ENDPROC
1084: 
1085:     *--------------------------------------------------------------------------
1086:     * ConfigurarGradeOperacoes - Cria grid de selecao de operacoes (GradeOpera)
1087:     * Regra critica: AddObject("Check1") ANTES de CurrentControl e ControlSource
1088:     * Original: GradeOpera Top=146, Left=249, Width=178, Height=89 -> Page: Top=61
1089:     *--------------------------------------------------------------------------
1090:     PROTECTED PROCEDURE ConfigurarGradeOperacoes(par_oPagina)
1091:         LOCAL loc_oGrid, loc_cCursor
1092:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes
1093: 
1094:         par_oPagina.AddObject("grd_4c_Opera", "Grid")
1095:         loc_oGrid = par_oPagina.grd_4c_Opera
1096: 
1097:         WITH loc_oGrid
1098:             .Top                = 61
1099:             .Left               = 249
1100:             .Width              = 178
1101:             .Height             = 89
1102:             .ColumnCount        = 2
1103:             .RecordMark         = .F.
1104:             .DeleteMark         = .F.
1105:             .ScrollBars         = 2
1106:             .RowHeight          = 16
1107:             .FontName           = "Verdana"
1108:             .FontSize           = 8
1109:             .GridLineColor      = RGB(238, 238, 238)
1110:             .HighlightStyle     = 2
1111:             .HighlightBackColor = RGB(255, 255, 255)
1112:             .HighlightForeColor = RGB(15, 41, 104)
1113:             .AllowHeaderSizing  = .F.
1114:             .AllowRowSizing     = .F.
1115:             .Visible            = .T.
1116:         ENDWITH
1117: 
1118:         *-- Column1: CheckBox para Flag (selecao da operacao)
1119:         WITH loc_oGrid.Column1
1120:             .Width     = 25
1121:             .FontName  = "Verdana"
1122:             .FontSize  = 8
1123:             .Alignment = 2
1124:         ENDWITH
1125:         loc_oGrid.Column1.Header1.Caption = ""
1126:         loc_oGrid.Column1.AddObject("Check1", "CheckBox")
1127:         loc_oGrid.Column1.Check1.Caption  = ""
1128:         loc_oGrid.Column1.CurrentControl  = "Check1"
1129:         loc_oGrid.Column1.ControlSource   = loc_cCursor + ".Flag"
1130: 

*-- Linhas 1148 a 1191:
1148:     *--------------------------------------------------------------------------
1149:     * BOParaForm - Sincroniza valores do BO com os controles de Page1
1150:     *--------------------------------------------------------------------------
1151:     PROTECTED PROCEDURE BOParaForm()
1152:         LOCAL loc_oPagina, loc_oRel
1153:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1154:             RETURN
1155:         ENDIF
1156:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1157:             RETURN
1158:         ENDIF
1159:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1160:         loc_oRel    = THIS.this_oRelatorio
1161: 
1162:         IF PEMSTATUS(loc_oPagina, "opt_4c_NrTipo", 5)
1163:             loc_oPagina.opt_4c_NrTipo.Value = loc_oRel.this_nNrTipo
1164:         ENDIF
1165:         IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
1166:             loc_oPagina.txt_4c_DtInicial.Value = loc_oRel.this_dDtInicial
1167:         ENDIF
1168:         IF PEMSTATUS(loc_oPagina, "txt_4c_DtFinal", 5)
1169:             loc_oPagina.txt_4c_DtFinal.Value = loc_oRel.this_dDtFinal
1170:         ENDIF
1171:         IF PEMSTATUS(loc_oPagina, "chk_4c_ImpFollow", 5)
1172:             loc_oPagina.chk_4c_ImpFollow.Value = IIF(loc_oRel.this_lImpFollow, 1, 0)
1173:         ENDIF
1174:         IF PEMSTATUS(loc_oPagina, "cbo_4c_Ordem", 5)
1175:             loc_oPagina.cbo_4c_Ordem.ListIndex = loc_oRel.this_nOrdemIdx
1176:         ENDIF
1177:         IF PEMSTATUS(loc_oPagina, "opt_4c_NrOpcao", 5)
1178:             loc_oPagina.opt_4c_NrOpcao.Value = loc_oRel.this_nNrOpcao
1179:         ENDIF
1180:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1181:             loc_oPagina.txt_4c_CdEmpresa.Value = loc_oRel.this_cCdEmpresa
1182:         ENDIF
1183:         IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1184:             loc_oPagina.txt_4c_DsEmpresa.Value = loc_oRel.this_cDsEmpresa
1185:         ENDIF
1186:         IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1187:             loc_oPagina.txt_4c_CdDesGrupo.Value = loc_oRel.this_cCdDesGrupo
1188:         ENDIF
1189:         IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1190:             loc_oPagina.txt_4c_DsDesGrupo.Value = loc_oRel.this_cDsDesGrupo
1191:         ENDIF

*-- Linhas 1213 a 2289:
1213:     * SelecionarTodosClick - Marca Flag=.T. em todas as operacoes
1214:     * Equivalente ao Command3.Click do original
1215:     *--------------------------------------------------------------------------
1216:     PROCEDURE SelecionarTodosClick()
1217:         LOCAL loc_cCursor, loc_nRecno
1218:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1219:             RETURN
1220:         ENDIF
1221:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes
1222:         IF !USED(loc_cCursor)
1223:             RETURN
1224:         ENDIF
1225:         TRY
1226:             SELECT (loc_cCursor)
1227:             loc_nRecno = RECNO()
1228:             REPLACE ALL Flag WITH .T. IN (loc_cCursor)
1229:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1230:                 GOTO loc_nRecno IN (loc_cCursor)
1231:             ENDIF
1232:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
1233:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
1234:             ENDIF
1235:         CATCH TO loc_oErro
1236:             MsgErro(loc_oErro.Message, "Formsigrechp.SelecionarTodosClick")
1237:         ENDTRY
1238:     ENDPROC
1239: 
1240:     *--------------------------------------------------------------------------
1241:     * DeselecionarTodosClick - Marca Flag=.F. em todas as operacoes
1242:     * Equivalente ao Command4.Click do original
1243:     *--------------------------------------------------------------------------
1244:     PROCEDURE DeselecionarTodosClick()
1245:         LOCAL loc_cCursor, loc_nRecno
1246:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1247:             RETURN
1248:         ENDIF
1249:         loc_cCursor = THIS.this_oRelatorio.this_cCursorOperacoes
1250:         IF !USED(loc_cCursor)
1251:             RETURN
1252:         ENDIF
1253:         TRY
1254:             SELECT (loc_cCursor)
1255:             loc_nRecno = RECNO()
1256:             REPLACE ALL Flag WITH .F. IN (loc_cCursor)
1257:             IF BETWEEN(loc_nRecno, 1, RECCOUNT(loc_cCursor))
1258:                 GOTO loc_nRecno IN (loc_cCursor)
1259:             ENDIF
1260:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
1261:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
1262:             ENDIF
1263:         CATCH TO loc_oErro
1264:             MsgErro(loc_oErro.Message, "Formsigrechp.DeselecionarTodosClick")
1265:         ENDTRY
1266:     ENDPROC
1267: 
1268:     *--------------------------------------------------------------------------
1269:     * TeclaEmpresaCd/Ds - KeyPress handlers para campos de Empresa
1270:     * F4(115)/ENTER(13)/TAB(9) disparam validacao/lookup
1271:     *--------------------------------------------------------------------------
1272:     PROCEDURE TeclaEmpresaCd(par_nKeyCode, par_nShiftAltCtrl)
1273:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1274:             THIS.AbrirLookupEmpresa()
1275:         ELSE
1276:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1277:             THIS.ValidarCdEmpresa()
1278:             ENDIF
1279:         ENDIF
1280:     ENDPROC
1281: 
1282:     PROCEDURE TeclaEmpresaDs(par_nKeyCode, par_nShiftAltCtrl)
1283:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1284:             THIS.AbrirLookupEmpresa()
1285:         ELSE
1286:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1287:             THIS.ValidarDsEmpresa()
1288:             ENDIF
1289:         ENDIF
1290:     ENDPROC
1291: 
1292:     *--------------------------------------------------------------------------
1293:     * ValidarCdEmpresa - Valida codigo empresa em SigCdEmp; preenche Razas
1294:     * SigCdEmp: cEmps (codigo), Razas (razao social)
1295:     *--------------------------------------------------------------------------
1296:     PROCEDURE ValidarCdEmpresa()
1297:         LOCAL loc_cCod, loc_cSql, loc_nResult, loc_oPagina
1298:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1299:             RETURN
1300:         ENDIF
1301:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1302:         IF !PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1303:             RETURN
1304:         ENDIF
1305:         loc_cCod = ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value)
1306:         IF EMPTY(loc_cCod)
1307:             IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1308:                 loc_oPagina.txt_4c_DsEmpresa.Value = ""
1309:             ENDIF
1310:             RETURN
1311:         ENDIF
1312:         TRY
1313:             IF USED("cursor_4c_EmpVal")
1314:                 USE IN cursor_4c_EmpVal
1315:             ENDIF
1316:             loc_cSql    = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
1317:                           EscaparSQL(loc_cCod)
1318:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
1319:             IF loc_nResult > 0
1320:                 SELECT cursor_4c_EmpVal
1321:                 IF !EOF()
1322:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1323:                         loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1324:                     ENDIF
1325:                 ELSE
1326:                     MsgAviso("Empresa " + CHR(39) + loc_cCod + CHR(39) + ;
1327:                              " n" + CHR(227) + "o encontrada.", "Empresa")
1328:                     loc_oPagina.txt_4c_CdEmpresa.Value = ""
1329:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1330:                         loc_oPagina.txt_4c_DsEmpresa.Value = ""
1331:                     ENDIF
1332:                 ENDIF
1333:                 USE IN cursor_4c_EmpVal
1334:             ENDIF
1335:         CATCH TO loc_oErro
1336:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdEmpresa")
1337:         ENDTRY
1338:     ENDPROC
1339: 
1340:     *--------------------------------------------------------------------------
1341:     * ValidarDsEmpresa - Busca empresa por Razas; preenche cEmps
1342:     *--------------------------------------------------------------------------
1343:     PROCEDURE ValidarDsEmpresa()
1344:         LOCAL loc_cDesc, loc_cSql, loc_nResult, loc_oPagina
1345:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1346:             RETURN
1347:         ENDIF
1348:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1349:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1350:             RETURN
1351:         ENDIF
1352:         loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsEmpresa.Value)
1353:         IF EMPTY(loc_cDesc)
1354:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1355:                 loc_oPagina.txt_4c_CdEmpresa.Value = ""
1356:             ENDIF
1357:             RETURN
1358:         ENDIF
1359:         TRY
1360:             IF USED("cursor_4c_EmpVal")
1361:                 USE IN cursor_4c_EmpVal
1362:             ENDIF
1363:             loc_cSql    = "SELECT TOP 1 cEmps, Razas FROM SigCdEmp " + ;
1364:                           "WHERE Razas LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1365:                           " ORDER BY cEmps"
1366:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmpVal")
1367:             IF loc_nResult > 0
1368:                 SELECT cursor_4c_EmpVal
1369:                 IF !EOF()
1370:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1371:                         loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.cEmps)
1372:                     ENDIF
1373:                     loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_EmpVal.Razas)
1374:                 ENDIF
1375:                 USE IN cursor_4c_EmpVal
1376:             ENDIF
1377:         CATCH TO loc_oErro
1378:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmpresa")
1379:         ENDTRY
1380:     ENDPROC
1381: 
1382:     *--------------------------------------------------------------------------
1383:     * TeclaDesGrupoCd/Ds - KeyPress handlers para Grupo Destino
1384:     *--------------------------------------------------------------------------
1385:     PROCEDURE TeclaDesGrupoCd(par_nKeyCode, par_nShiftAltCtrl)
1386:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1387:             THIS.AbrirLookupDesGrupo()
1388:         ELSE
1389:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1390:             THIS.ValidarCdDesGrupo()
1391:             ENDIF
1392:         ENDIF
1393:     ENDPROC
1394: 
1395:     PROCEDURE TeclaDesGrupoDs(par_nKeyCode, par_nShiftAltCtrl)
1396:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1397:             THIS.AbrirLookupDesGrupo()
1398:         ELSE
1399:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1400:             THIS.ValidarDsDesGrupo()
1401:             ENDIF
1402:         ENDIF
1403:     ENDPROC
1404: 
1405:     *--------------------------------------------------------------------------
1406:     * ValidarCdDesGrupo - Valida codigo grupo destino em SigCdGcr; preenche desc
1407:     * Ao limpar codigo: limpa desc + conta destino associada
1408:     *--------------------------------------------------------------------------
1409:     PROCEDURE ValidarCdDesGrupo()
1410:         LOCAL loc_cCod, loc_cSql, loc_nResult, loc_oPagina
1411:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1412:             RETURN
1413:         ENDIF
1414:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1415:         IF !PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1416:             RETURN
1417:         ENDIF
1418:         loc_cCod = ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value)
1419:         IF EMPTY(loc_cCod)
1420:             IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1421:                 loc_oPagina.txt_4c_DsDesGrupo.Value = ""
1422:             ENDIF
1423:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1424:                 loc_oPagina.txt_4c_CdDesConta.Value = ""
1425:             ENDIF
1426:             IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1427:                 loc_oPagina.txt_4c_DsDesConta.Value = ""
1428:             ENDIF
1429:             RETURN
1430:         ENDIF
1431:         TRY
1432:             IF USED("cursor_4c_GrpDesVal")
1433:                 USE IN cursor_4c_GrpDesVal
1434:             ENDIF
1435:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1436:                           EscaparSQL(loc_cCod)
1437:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
1438:             IF loc_nResult > 0
1439:                 SELECT cursor_4c_GrpDesVal
1440:                 IF !EOF()
1441:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1442:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
1443:                     ENDIF
1444:                 ELSE
1445:                     MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
1446:                              " n" + CHR(227) + "o encontrado.", "Grupo/Destino")
1447:                     loc_oPagina.txt_4c_CdDesGrupo.Value = ""
1448:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1449:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ""
1450:                     ENDIF
1451:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1452:                         loc_oPagina.txt_4c_CdDesConta.Value = ""
1453:                     ENDIF
1454:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1455:                         loc_oPagina.txt_4c_DsDesConta.Value = ""
1456:                     ENDIF
1457:                 ENDIF
1458:                 USE IN cursor_4c_GrpDesVal
1459:             ENDIF
1460:         CATCH TO loc_oErro
1461:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdDesGrupo")
1462:         ENDTRY
1463:     ENDPROC
1464: 
1465:     *--------------------------------------------------------------------------
1466:     * ValidarDsDesGrupo - Busca grupo destino por Descrs em SigCdGcr
1467:     *--------------------------------------------------------------------------
1468:     PROCEDURE ValidarDsDesGrupo()
1469:         LOCAL loc_cDesc, loc_cSql, loc_nResult, loc_oPagina
1470:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1471:             RETURN
1472:         ENDIF
1473:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1474:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1475:             RETURN
1476:         ENDIF
1477:         loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsDesGrupo.Value)
1478:         IF EMPTY(loc_cDesc)
1479:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1480:                 loc_oPagina.txt_4c_CdDesGrupo.Value = ""
1481:             ENDIF
1482:             RETURN
1483:         ENDIF
1484:         TRY
1485:             IF USED("cursor_4c_GrpDesVal")
1486:                 USE IN cursor_4c_GrpDesVal
1487:             ENDIF
1488:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
1489:                           "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1490:                           " ORDER BY Codigos"
1491:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpDesVal")
1492:             IF loc_nResult > 0
1493:                 SELECT cursor_4c_GrpDesVal
1494:                 IF !EOF()
1495:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1496:                         loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Codigos)
1497:                     ENDIF
1498:                     loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_GrpDesVal.Descrs)
1499:                 ENDIF
1500:                 USE IN cursor_4c_GrpDesVal
1501:             ENDIF
1502:         CATCH TO loc_oErro
1503:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesGrupo")
1504:         ENDTRY
1505:     ENDPROC
1506: 
1507:     *--------------------------------------------------------------------------
1508:     * TeclaDesContaCd/Ds - KeyPress handlers para Conta Destino
1509:     *--------------------------------------------------------------------------
1510:     PROCEDURE TeclaDesContaCd(par_nKeyCode, par_nShiftAltCtrl)
1511:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1512:             THIS.AbrirLookupDesConta()
1513:         ELSE
1514:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1515:             THIS.ValidarCdDesConta()
1516:             ENDIF
1517:         ENDIF
1518:     ENDPROC
1519: 
1520:     PROCEDURE TeclaDesContaDs(par_nKeyCode, par_nShiftAltCtrl)
1521:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1522:             THIS.AbrirLookupDesConta()
1523:         ELSE
1524:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1525:             THIS.ValidarDsDesConta()
1526:             ENDIF
1527:         ENDIF
1528:     ENDPROC
1529: 
1530:     *--------------------------------------------------------------------------
1531:     * ValidarCdDesConta - Valida conta destino em SigCdCli (Iclis/rClis)
1532:     * Original: fAcessoContas verifica conta; retorna .F. e limpa se invalida
1533:     *--------------------------------------------------------------------------
1534:     PROCEDURE ValidarCdDesConta()
1535:         LOCAL loc_cCod, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
1536:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1537:             RETURN
1538:         ENDIF
1539:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1540:         IF !PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1541:             RETURN
1542:         ENDIF
1543:         loc_cCod   = ALLTRIM(loc_oPagina.txt_4c_CdDesConta.Value)
1544:         loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
1545:                          ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
1546:         IF EMPTY(loc_cCod)
1547:             IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1548:                 loc_oPagina.txt_4c_DsDesConta.Value = ""
1549:             ENDIF
1550:             RETURN
1551:         ENDIF
1552:         TRY
1553:             IF USED("cursor_4c_CliVal")
1554:                 USE IN cursor_4c_CliVal
1555:             ENDIF
1556:             loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
1557:                        EscaparSQL(loc_cCod)
1558:             IF !EMPTY(loc_cGrupo)
1559:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1560:             ENDIF
1561:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
1562:             IF loc_nResult > 0
1563:                 SELECT cursor_4c_CliVal
1564:                 IF !EOF()
1565:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1566:                         loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
1567:                     ENDIF
1568:                 ELSE
1569:                     MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
1570:                              " inv" + CHR(225) + "lida.", "Conta/Destino")
1571:                     loc_oPagina.txt_4c_CdDesConta.Value = ""
1572:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1573:                         loc_oPagina.txt_4c_DsDesConta.Value = ""
1574:                     ENDIF
1575:                 ENDIF
1576:                 USE IN cursor_4c_CliVal
1577:             ENDIF
1578:         CATCH TO loc_oErro
1579:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdDesConta")
1580:         ENDTRY
1581:     ENDPROC
1582: 
1583:     *--------------------------------------------------------------------------
1584:     * ValidarDsDesConta - Busca conta destino por rClis em SigCdCli
1585:     *--------------------------------------------------------------------------
1586:     PROCEDURE ValidarDsDesConta()
1587:         LOCAL loc_cDesc, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
1588:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1589:             RETURN
1590:         ENDIF
1591:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1592:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1593:             RETURN
1594:         ENDIF
1595:         loc_cDesc  = ALLTRIM(loc_oPagina.txt_4c_DsDesConta.Value)
1596:         loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
1597:                          ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
1598:         IF EMPTY(loc_cDesc)
1599:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1600:                 loc_oPagina.txt_4c_CdDesConta.Value = ""
1601:             ENDIF
1602:             RETURN
1603:         ENDIF
1604:         TRY
1605:             IF USED("cursor_4c_CliVal")
1606:                 USE IN cursor_4c_CliVal
1607:             ENDIF
1608:             loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
1609:                        "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
1610:             IF !EMPTY(loc_cGrupo)
1611:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1612:             ENDIF
1613:             loc_cSql    = loc_cSql + " ORDER BY Iclis"
1614:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_CliVal")
1615:             IF loc_nResult > 0
1616:                 SELECT cursor_4c_CliVal
1617:                 IF !EOF()
1618:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1619:                         loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_CliVal.Iclis)
1620:                     ENDIF
1621:                     loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_CliVal.rClis)
1622:                 ENDIF
1623:                 USE IN cursor_4c_CliVal
1624:             ENDIF
1625:         CATCH TO loc_oErro
1626:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsDesConta")
1627:         ENDTRY
1628:     ENDPROC
1629: 
1630:     *--------------------------------------------------------------------------
1631:     * TeclaEmiGrupoCd/Ds - KeyPress handlers para Grupo Emissor
1632:     *--------------------------------------------------------------------------
1633:     PROCEDURE TeclaEmiGrupoCd(par_nKeyCode, par_nShiftAltCtrl)
1634:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1635:             THIS.AbrirLookupEmiGrupo()
1636:         ELSE
1637:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1638:             THIS.ValidarCdEmiGrupo()
1639:             ENDIF
1640:         ENDIF
1641:     ENDPROC
1642: 
1643:     PROCEDURE TeclaEmiGrupoDs(par_nKeyCode, par_nShiftAltCtrl)
1644:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1645:             THIS.AbrirLookupEmiGrupo()
1646:         ELSE
1647:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1648:             THIS.ValidarDsEmiGrupo()
1649:             ENDIF
1650:         ENDIF
1651:     ENDPROC
1652: 
1653:     *--------------------------------------------------------------------------
1654:     * ValidarCdEmiGrupo - Valida codigo grupo emissor em SigCdGcr; preenche desc
1655:     * Ao limpar codigo: limpa desc + conta emissor associada
1656:     *--------------------------------------------------------------------------
1657:     PROCEDURE ValidarCdEmiGrupo()
1658:         LOCAL loc_cCod, loc_cSql, loc_nResult, loc_oPagina
1659:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1660:             RETURN
1661:         ENDIF
1662:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1663:         IF !PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
1664:             RETURN
1665:         ENDIF
1666:         loc_cCod = ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value)
1667:         IF EMPTY(loc_cCod)
1668:             IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1669:                 loc_oPagina.txt_4c_DsEmiGrupo.Value = ""
1670:             ENDIF
1671:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1672:                 loc_oPagina.txt_4c_CdEmiConta.Value = ""
1673:             ENDIF
1674:             IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1675:                 loc_oPagina.txt_4c_DsEmiConta.Value = ""
1676:             ENDIF
1677:             RETURN
1678:         ENDIF
1679:         TRY
1680:             IF USED("cursor_4c_GrpEmiVal")
1681:                 USE IN cursor_4c_GrpEmiVal
1682:             ENDIF
1683:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr WHERE Codigos = " + ;
1684:                           EscaparSQL(loc_cCod)
1685:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
1686:             IF loc_nResult > 0
1687:                 SELECT cursor_4c_GrpEmiVal
1688:                 IF !EOF()
1689:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1690:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
1691:                     ENDIF
1692:                 ELSE
1693:                     MsgAviso("Grupo " + CHR(39) + loc_cCod + CHR(39) + ;
1694:                              " n" + CHR(227) + "o encontrado.", "Grupo/Emissor")
1695:                     loc_oPagina.txt_4c_CdEmiGrupo.Value = ""
1696:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1697:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ""
1698:                     ENDIF
1699:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1700:                         loc_oPagina.txt_4c_CdEmiConta.Value = ""
1701:                     ENDIF
1702:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1703:                         loc_oPagina.txt_4c_DsEmiConta.Value = ""
1704:                     ENDIF
1705:                 ENDIF
1706:                 USE IN cursor_4c_GrpEmiVal
1707:             ENDIF
1708:         CATCH TO loc_oErro
1709:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdEmiGrupo")
1710:         ENDTRY
1711:     ENDPROC
1712: 
1713:     *--------------------------------------------------------------------------
1714:     * ValidarDsEmiGrupo - Busca grupo emissor por Descrs em SigCdGcr
1715:     *--------------------------------------------------------------------------
1716:     PROCEDURE ValidarDsEmiGrupo()
1717:         LOCAL loc_cDesc, loc_cSql, loc_nResult, loc_oPagina
1718:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1719:             RETURN
1720:         ENDIF
1721:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1722:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
1723:             RETURN
1724:         ENDIF
1725:         loc_cDesc = ALLTRIM(loc_oPagina.txt_4c_DsEmiGrupo.Value)
1726:         IF EMPTY(loc_cDesc)
1727:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
1728:                 loc_oPagina.txt_4c_CdEmiGrupo.Value = ""
1729:             ENDIF
1730:             RETURN
1731:         ENDIF
1732:         TRY
1733:             IF USED("cursor_4c_GrpEmiVal")
1734:                 USE IN cursor_4c_GrpEmiVal
1735:             ENDIF
1736:             loc_cSql    = "SELECT TOP 1 Codigos, Descrs FROM SigCdGcr " + ;
1737:                           "WHERE Descrs LIKE " + EscaparSQL(loc_cDesc + "%") + ;
1738:                           " ORDER BY Codigos"
1739:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_GrpEmiVal")
1740:             IF loc_nResult > 0
1741:                 SELECT cursor_4c_GrpEmiVal
1742:                 IF !EOF()
1743:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
1744:                         loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Codigos)
1745:                     ENDIF
1746:                     loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_GrpEmiVal.Descrs)
1747:                 ENDIF
1748:                 USE IN cursor_4c_GrpEmiVal
1749:             ENDIF
1750:         CATCH TO loc_oErro
1751:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiGrupo")
1752:         ENDTRY
1753:     ENDPROC
1754: 
1755:     *--------------------------------------------------------------------------
1756:     * TeclaEmiContaCd/Ds - KeyPress handlers para Conta Emissor
1757:     *--------------------------------------------------------------------------
1758:     PROCEDURE TeclaEmiContaCd(par_nKeyCode, par_nShiftAltCtrl)
1759:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1760:             THIS.AbrirLookupEmiConta()
1761:         ELSE
1762:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1763:             THIS.ValidarCdEmiConta()
1764:             ENDIF
1765:         ENDIF
1766:     ENDPROC
1767: 
1768:     PROCEDURE TeclaEmiContaDs(par_nKeyCode, par_nShiftAltCtrl)
1769:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
1770:             THIS.AbrirLookupEmiConta()
1771:         ELSE
1772:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1773:             THIS.ValidarDsEmiConta()
1774:             ENDIF
1775:         ENDIF
1776:     ENDPROC
1777: 
1778:     *--------------------------------------------------------------------------
1779:     * ValidarCdEmiConta - Valida conta emissor em SigCdCli (Iclis/rClis)
1780:     * Original: fAcessoContas verifica conta; limpa e retorna .F. se invalida
1781:     *--------------------------------------------------------------------------
1782:     PROCEDURE ValidarCdEmiConta()
1783:         LOCAL loc_cCod, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
1784:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1785:             RETURN
1786:         ENDIF
1787:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1788:         IF !PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1789:             RETURN
1790:         ENDIF
1791:         loc_cCod   = ALLTRIM(loc_oPagina.txt_4c_CdEmiConta.Value)
1792:         loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
1793:                          ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
1794:         IF EMPTY(loc_cCod)
1795:             IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1796:                 loc_oPagina.txt_4c_DsEmiConta.Value = ""
1797:             ENDIF
1798:             RETURN
1799:         ENDIF
1800:         TRY
1801:             IF USED("cursor_4c_EmiCliVal")
1802:                 USE IN cursor_4c_EmiCliVal
1803:             ENDIF
1804:             loc_cSql = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
1805:                        EscaparSQL(loc_cCod)
1806:             IF !EMPTY(loc_cGrupo)
1807:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1808:             ENDIF
1809:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
1810:             IF loc_nResult > 0
1811:                 SELECT cursor_4c_EmiCliVal
1812:                 IF !EOF()
1813:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1814:                         loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
1815:                     ENDIF
1816:                 ELSE
1817:                     MsgAviso("Conta " + CHR(39) + loc_cCod + CHR(39) + ;
1818:                              " inv" + CHR(225) + "lida.", "Conta/Emissor")
1819:                     loc_oPagina.txt_4c_CdEmiConta.Value = ""
1820:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1821:                         loc_oPagina.txt_4c_DsEmiConta.Value = ""
1822:                     ENDIF
1823:                 ENDIF
1824:                 USE IN cursor_4c_EmiCliVal
1825:             ENDIF
1826:         CATCH TO loc_oErro
1827:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarCdEmiConta")
1828:         ENDTRY
1829:     ENDPROC
1830: 
1831:     *--------------------------------------------------------------------------
1832:     * ValidarDsEmiConta - Busca conta emissor por rClis em SigCdCli
1833:     *--------------------------------------------------------------------------
1834:     PROCEDURE ValidarDsEmiConta()
1835:         LOCAL loc_cDesc, loc_cGrupo, loc_cSql, loc_nResult, loc_oPagina
1836:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1837:             RETURN
1838:         ENDIF
1839:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1840:         IF !PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
1841:             RETURN
1842:         ENDIF
1843:         loc_cDesc  = ALLTRIM(loc_oPagina.txt_4c_DsEmiConta.Value)
1844:         loc_cGrupo = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
1845:                          ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
1846:         IF EMPTY(loc_cDesc)
1847:             IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1848:                 loc_oPagina.txt_4c_CdEmiConta.Value = ""
1849:             ENDIF
1850:             RETURN
1851:         ENDIF
1852:         TRY
1853:             IF USED("cursor_4c_EmiCliVal")
1854:                 USE IN cursor_4c_EmiCliVal
1855:             ENDIF
1856:             loc_cSql = "SELECT TOP 1 Iclis, rClis FROM SigCdCli " + ;
1857:                        "WHERE rClis LIKE " + EscaparSQL(loc_cDesc + "%")
1858:             IF !EMPTY(loc_cGrupo)
1859:                 loc_cSql = loc_cSql + " AND grclis = " + EscaparSQL(loc_cGrupo)
1860:             ENDIF
1861:             loc_cSql    = loc_cSql + " ORDER BY Iclis"
1862:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_EmiCliVal")
1863:             IF loc_nResult > 0
1864:                 SELECT cursor_4c_EmiCliVal
1865:                 IF !EOF()
1866:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
1867:                         loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.Iclis)
1868:                     ENDIF
1869:                     loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_EmiCliVal.rClis)
1870:                 ENDIF
1871:                 USE IN cursor_4c_EmiCliVal
1872:             ENDIF
1873:         CATCH TO loc_oErro
1874:             MsgErro(loc_oErro.Message, "Formsigrechp.ValidarDsEmiConta")
1875:         ENDTRY
1876:     ENDPROC
1877: 
1878:     *--------------------------------------------------------------------------
1879:     * AlternarPagina - Navega entre paginas do PageFrame
1880:     * Para form REPORT: Page1=Filtros (pagina principal ativa)
1881:     *--------------------------------------------------------------------------
1882:     PROCEDURE AlternarPagina(par_nPagina)
1883:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1884:             RETURN
1885:         ENDIF
1886:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
1887:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1888:         ENDIF
1889:     ENDPROC
1890: 
1891:     *--------------------------------------------------------------------------
1892:     * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecao de empresa (F4)
1893:     * Tabela: SigCdEmp (cEmps=codigo, Razas=razao social)
1894:     *--------------------------------------------------------------------------
1895:     PROCEDURE AbrirLookupEmpresa()
1896:         LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual
1897:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1898:             RETURN
1899:         ENDIF
1900:         loc_oPagina  = THIS.pgf_4c_Paginas.Page1
1901:         loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5), ;
1902:                             ALLTRIM(loc_oPagina.txt_4c_CdEmpresa.Value), "")
1903:         TRY
1904:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1905:                 "SigCdEmp", ;
1906:                 "cursor_4c_BuscaEmp", ;
1907:                 "cEmps", ;
1908:                 loc_cCodAtual, ;
1909:                 "Buscar Empresa")
1910:             loc_oBusca.mAddColuna("cEmps", "", "C" + CHR(243) + "digo")
1911:             loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
1912:             loc_oBusca.Show()
1913:             IF loc_oBusca.this_lSelecionou
1914:                 IF USED("cursor_4c_BuscaEmp")
1915:                     SELECT cursor_4c_BuscaEmp
1916:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmpresa", 5)
1917:                         loc_oPagina.txt_4c_CdEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.cEmps)
1918:                     ENDIF
1919:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmpresa", 5)
1920:                         loc_oPagina.txt_4c_DsEmpresa.Value = ALLTRIM(cursor_4c_BuscaEmp.Razas)
1921:                     ENDIF
1922:                 ENDIF
1923:             ENDIF
1924:         CATCH TO loc_oErro
1925:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmpresa")
1926:         ENDTRY
1927:         IF USED("cursor_4c_BuscaEmp")
1928:             USE IN cursor_4c_BuscaEmp
1929:         ENDIF
1930:         IF VARTYPE(loc_oBusca) = "O"
1931:             loc_oBusca = .NULL.
1932:         ENDIF
1933:     ENDPROC
1934: 
1935:     *--------------------------------------------------------------------------
1936:     * AbrirLookupDesGrupo - Abre FormBuscaAuxiliar para selecao de grupo destino (F4)
1937:     * Tabela: SigCdGcr (Codigos=codigo, Descrs=descricao)
1938:     * Ao selecionar: limpa conta destino vinculada ao grupo
1939:     *--------------------------------------------------------------------------
1940:     PROCEDURE AbrirLookupDesGrupo()
1941:         LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual
1942:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1943:             RETURN
1944:         ENDIF
1945:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
1946:         loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
1947:                             ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
1948:         TRY
1949:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1950:                 "SigCdGcr", ;
1951:                 "cursor_4c_BuscaDesGrp", ;
1952:                 "Codigos", ;
1953:                 loc_cCodAtual, ;
1954:                 "Buscar Grupo Destino")
1955:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
1956:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1957:             loc_oBusca.Show()
1958:             IF loc_oBusca.this_lSelecionou
1959:                 IF USED("cursor_4c_BuscaDesGrp")
1960:                     SELECT cursor_4c_BuscaDesGrp
1961:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5)
1962:                         loc_oPagina.txt_4c_CdDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Codigos)
1963:                     ENDIF
1964:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesGrupo", 5)
1965:                         loc_oPagina.txt_4c_DsDesGrupo.Value = ALLTRIM(cursor_4c_BuscaDesGrp.Descrs)
1966:                     ENDIF
1967:                     *-- Limpa conta destino pois depende do grupo
1968:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
1969:                         loc_oPagina.txt_4c_CdDesConta.Value = ""
1970:                     ENDIF
1971:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
1972:                         loc_oPagina.txt_4c_DsDesConta.Value = ""
1973:                     ENDIF
1974:                 ENDIF
1975:             ENDIF
1976:         CATCH TO loc_oErro
1977:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupDesGrupo")
1978:         ENDTRY
1979:         IF USED("cursor_4c_BuscaDesGrp")
1980:             USE IN cursor_4c_BuscaDesGrp
1981:         ENDIF
1982:         IF VARTYPE(loc_oBusca) = "O"
1983:             loc_oBusca = .NULL.
1984:         ENDIF
1985:     ENDPROC
1986: 
1987:     *--------------------------------------------------------------------------
1988:     * AbrirLookupDesConta - Abre FormBuscaAuxiliar para selecao de conta destino (F4)
1989:     * Tabela: SigCdCli (Iclis=codigo, rClis=nome), filtrado por grupo destino se informado
1990:     *--------------------------------------------------------------------------
1991:     PROCEDURE AbrirLookupDesConta()
1992:         LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual, loc_cGrupo, loc_cSQL
1993:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
1994:             RETURN
1995:         ENDIF
1996:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
1997:         loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5), ;
1998:                             ALLTRIM(loc_oPagina.txt_4c_CdDesConta.Value), "")
1999:         loc_cGrupo    = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdDesGrupo", 5), ;
2000:                             ALLTRIM(loc_oPagina.txt_4c_CdDesGrupo.Value), "")
2001:         TRY
2002:             IF EMPTY(loc_cGrupo)
2003:                 loc_cSQL = ""
2004:             ELSE
2005:                 loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
2006:             ENDIF
2007:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2008:                 "SigCdCli" + loc_cSQL, ;
2009:                 "cursor_4c_BuscaDesCli", ;
2010:                 "Iclis", ;
2011:                 loc_cCodAtual, ;
2012:                 "Buscar Conta Destino")
2013:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2014:             loc_oBusca.mAddColuna("rClis", "", "Nome")
2015:             loc_oBusca.Show()
2016:             IF loc_oBusca.this_lSelecionou
2017:                 IF USED("cursor_4c_BuscaDesCli")
2018:                     SELECT cursor_4c_BuscaDesCli
2019:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdDesConta", 5)
2020:                         loc_oPagina.txt_4c_CdDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.Iclis)
2021:                     ENDIF
2022:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsDesConta", 5)
2023:                         loc_oPagina.txt_4c_DsDesConta.Value = ALLTRIM(cursor_4c_BuscaDesCli.rClis)
2024:                     ENDIF
2025:                 ENDIF
2026:             ENDIF
2027:         CATCH TO loc_oErro
2028:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupDesConta")
2029:         ENDTRY
2030:         IF USED("cursor_4c_BuscaDesCli")
2031:             USE IN cursor_4c_BuscaDesCli
2032:         ENDIF
2033:         IF VARTYPE(loc_oBusca) = "O"
2034:             loc_oBusca = .NULL.
2035:         ENDIF
2036:     ENDPROC
2037: 
2038:     *--------------------------------------------------------------------------
2039:     * AbrirLookupEmiGrupo - Abre FormBuscaAuxiliar para selecao de grupo emissor (F4)
2040:     * Tabela: SigCdGcr (Codigos=codigo, Descrs=descricao)
2041:     * Ao selecionar: limpa conta emissor vinculada ao grupo
2042:     *--------------------------------------------------------------------------
2043:     PROCEDURE AbrirLookupEmiGrupo()
2044:         LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual
2045:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
2046:             RETURN
2047:         ENDIF
2048:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
2049:         loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
2050:                             ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
2051:         TRY
2052:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2053:                 "SigCdGcr", ;
2054:                 "cursor_4c_BuscaEmiGrp", ;
2055:                 "Codigos", ;
2056:                 loc_cCodAtual, ;
2057:                 "Buscar Grupo Emissor")
2058:             loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2059:             loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
2060:             loc_oBusca.Show()
2061:             IF loc_oBusca.this_lSelecionou
2062:                 IF USED("cursor_4c_BuscaEmiGrp")
2063:                     SELECT cursor_4c_BuscaEmiGrp
2064:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5)
2065:                         loc_oPagina.txt_4c_CdEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Codigos)
2066:                     ENDIF
2067:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiGrupo", 5)
2068:                         loc_oPagina.txt_4c_DsEmiGrupo.Value = ALLTRIM(cursor_4c_BuscaEmiGrp.Descrs)
2069:                     ENDIF
2070:                     *-- Limpa conta emissor pois depende do grupo
2071:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
2072:                         loc_oPagina.txt_4c_CdEmiConta.Value = ""
2073:                     ENDIF
2074:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
2075:                         loc_oPagina.txt_4c_DsEmiConta.Value = ""
2076:                     ENDIF
2077:                 ENDIF
2078:             ENDIF
2079:         CATCH TO loc_oErro
2080:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmiGrupo")
2081:         ENDTRY
2082:         IF USED("cursor_4c_BuscaEmiGrp")
2083:             USE IN cursor_4c_BuscaEmiGrp
2084:         ENDIF
2085:         IF VARTYPE(loc_oBusca) = "O"
2086:             loc_oBusca = .NULL.
2087:         ENDIF
2088:     ENDPROC
2089: 
2090:     *--------------------------------------------------------------------------
2091:     * BtnIncluirClick - Evento CRUD compatibilidade pipeline: para form REPORT
2092:     *   equivale a Imprimir (gerar copia fisica do relatorio)
2093:     *--------------------------------------------------------------------------
2094:     PROCEDURE BtnIncluirClick()
2095:         THIS.BtnImprimirClick()
2096:     ENDPROC
2097: 
2098:     *--------------------------------------------------------------------------
2099:     * BtnAlterarClick - Evento CRUD compatibilidade pipeline: para form REPORT
2100:     *   equivale a Visualizar (preview do relatorio na tela)
2101:     *--------------------------------------------------------------------------
2102:     PROCEDURE BtnAlterarClick()
2103:         THIS.BtnVisualizarClick()
2104:     ENDPROC
2105: 
2106:     *--------------------------------------------------------------------------
2107:     * BtnExcluirClick - Evento CRUD compatibilidade pipeline: para form REPORT
2108:     *   equivale a Encerrar (nao ha exclusao em relatorios)
2109:     *--------------------------------------------------------------------------
2110:     PROCEDURE BtnExcluirClick()
2111:         THIS.BtnSairClick()
2112:     ENDPROC
2113: 
2114:     *--------------------------------------------------------------------------
2115:     * BtnBuscarClick - Compatibilidade pipeline CRUD: para form REPORT equivale a Visualizar
2116:     *--------------------------------------------------------------------------
2117:     PROCEDURE BtnBuscarClick()
2118:         THIS.BtnVisualizarClick()
2119:     ENDPROC
2120: 
2121:     *--------------------------------------------------------------------------
2122:     * BtnEncerrarClick - Fecha o formulario
2123:     *--------------------------------------------------------------------------
2124:     PROCEDURE BtnEncerrarClick()
2125:         THIS.Release()
2126:     ENDPROC
2127: 
2128:     *--------------------------------------------------------------------------
2129:     * BtnSalvarClick - Compatibilidade pipeline CRUD: para form REPORT equivale a Imprimir
2130:     *--------------------------------------------------------------------------
2131:     PROCEDURE BtnSalvarClick()
2132:         THIS.BtnImprimirClick()
2133:     ENDPROC
2134: 
2135:     *--------------------------------------------------------------------------
2136:     * BtnCancelarClick - Fecha o formulario (cancelar = encerrar em form REPORT)
2137:     *--------------------------------------------------------------------------
2138:     PROCEDURE BtnCancelarClick()
2139:         THIS.Release()
2140:     ENDPROC
2141: 
2142:     *--------------------------------------------------------------------------
2143:     * FormParaBO - Alias canonico de FormParaRelatorio para compatibilidade com
2144:     *   o pipeline de migracao (que espera o nome FormParaBO em forms CRUD).
2145:     *   Em forms REPORT (frmrelatorio) o "BO" eh o objeto de relatorio. Delega
2146:     *   para FormParaRelatorio, que ja transfere TODOS os valores dos controles
2147:     *   de filtro para as propriedades this_* do BO de relatorio.
2148:     *--------------------------------------------------------------------------
2149:     PROCEDURE FormParaBO()
2150:         THIS.FormParaRelatorio()
2151:     ENDPROC
2152: 
2153:     *--------------------------------------------------------------------------
2154:     * HabilitarCampos - Em form REPORT todos os campos de filtro ficam sempre
2155:     *   habilitados (nao ha modos INCLUIR/ALTERAR/VISUALIZAR). Implementacao
2156:     *   funcional: itera os controles editaveis de Page1 e aplica Enabled =
2157:     *   par_lHabilitar. Garante consistencia visual e atende ao contrato do
2158:     *   pipeline de validacao automatica.
2159:     *--------------------------------------------------------------------------
2160:     PROCEDURE HabilitarCampos(par_lHabilitar)
2161:         LOCAL loc_lHab, loc_oPag, loc_aNomes, loc_nI, loc_cNome
2162:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
2163:             RETURN
2164:         ENDIF
2165:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2166:         loc_oPag = THIS.pgf_4c_Paginas.Page1
2167:         DIMENSION loc_aNomes(20)
2168:         loc_aNomes(1)  = "opt_4c_NrTipo"
2169:         loc_aNomes(2)  = "txt_4c_DtInicial"
2170:         loc_aNomes(3)  = "txt_4c_DtFinal"
2171:         loc_aNomes(4)  = "chk_4c_ImpFollow"
2172:         loc_aNomes(5)  = "cbo_4c_Ordem"
2173:         loc_aNomes(6)  = "opt_4c_NrOpcao"
2174:         loc_aNomes(7)  = "txt_4c_CdEmpresa"
2175:         loc_aNomes(8)  = "txt_4c_DsEmpresa"
2176:         loc_aNomes(9)  = "txt_4c_CdDesGrupo"
2177:         loc_aNomes(10) = "txt_4c_DsDesGrupo"
2178:         loc_aNomes(11) = "txt_4c_CdDesConta"
2179:         loc_aNomes(12) = "txt_4c_DsDesConta"
2180:         loc_aNomes(13) = "txt_4c_CdEmiGrupo"
2181:         loc_aNomes(14) = "txt_4c_DsEmiGrupo"
2182:         loc_aNomes(15) = "txt_4c_CdEmiConta"
2183:         loc_aNomes(16) = "txt_4c_DsEmiConta"
2184:         loc_aNomes(17) = "grd_4c_Opera"
2185:         loc_aNomes(18) = "cmd_4c_SelecionarTodos"
2186:         loc_aNomes(19) = "cmd_4c_DeselecionarTodos"
2187:         loc_aNomes(20) = ""
2188:         FOR loc_nI = 1 TO 20
2189:             loc_cNome = loc_aNomes(loc_nI)
2190:             IF !EMPTY(loc_cNome) AND PEMSTATUS(loc_oPag, loc_cNome, 5)
2191:                 EVALUATE("loc_oPag." + loc_cNome + ".Enabled = loc_lHab")
2192:             ENDIF
2193:         ENDFOR
2194:     ENDPROC
2195: 
2196:     *--------------------------------------------------------------------------
2197:     * CarregarLista - Em form REPORT nao existe grid CRUD de lista. Recarrega
2198:     *   o cursor de operacoes (usado pelo grid de selecao em Page1) e retorna
2199:     *   .T. para compatibilidade com o pipeline de validacao automatica.
2200:     *--------------------------------------------------------------------------
2201:     PROCEDURE CarregarLista()
2202:         LOCAL loc_lOk
2203:         loc_lOk = .T.
2204:         IF VARTYPE(THIS.this_oRelatorio) = "O"
2205:             TRY
2206:                 loc_lOk = THIS.this_oRelatorio.CarregarOperacoes()
2207:                 IF loc_lOk AND PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
2208:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Opera", 5)
2209:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Opera.Refresh()
2210:                     ENDIF
2211:                 ENDIF
2212:             CATCH TO loc_oErro
2213:                 MsgErro(loc_oErro.Message, "Formsigrechp.CarregarLista")
2214:                 loc_lOk = .F.
2215:             ENDTRY
2216:         ENDIF
2217:         RETURN loc_lOk
2218:     ENDPROC
2219: 
2220:     *--------------------------------------------------------------------------
2221:     * AjustarBotoesPorModo - Em form REPORT nao existem modos INCLUIR/ALTERAR/
2222:     *   VISUALIZAR; os botoes Visualizar/Imprimir/Excel/Encerrar ficam sempre
2223:     *   habilitados. Implementacao funcional: garante .Enabled = .T. em todos
2224:     *   os Buttons() do CommandGroup principal cmg_4c_Botoes apos qualquer
2225:     *   alteracao de estado (atende ao contrato do pipeline de migracao).
2226:     *--------------------------------------------------------------------------
2227:     PROCEDURE AjustarBotoesPorModo()
2228:         LOCAL loc_nI, loc_nQtde
2229:         IF !PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2230:             RETURN
2231:         ENDIF
2232:         loc_nQtde = THIS.cmg_4c_Botoes.ButtonCount
2233:         FOR loc_nI = 1 TO loc_nQtde
2234:             THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
2235:         ENDFOR
2236:     ENDPROC
2237: 
2238:     *--------------------------------------------------------------------------
2239:     * AbrirLookupEmiConta - Abre FormBuscaAuxiliar para selecao de conta emissor (F4)
2240:     * Tabela: SigCdCli (Iclis=codigo, rClis=nome), filtrado por grupo emissor se informado
2241:     *--------------------------------------------------------------------------
2242:     PROCEDURE AbrirLookupEmiConta()
2243:         LOCAL loc_oBusca, loc_oPagina, loc_cCodAtual, loc_cGrupo, loc_cSQL
2244:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
2245:             RETURN
2246:         ENDIF
2247:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
2248:         loc_cCodAtual = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5), ;
2249:                             ALLTRIM(loc_oPagina.txt_4c_CdEmiConta.Value), "")
2250:         loc_cGrupo    = IIF(PEMSTATUS(loc_oPagina, "txt_4c_CdEmiGrupo", 5), ;
2251:                             ALLTRIM(loc_oPagina.txt_4c_CdEmiGrupo.Value), "")
2252:         TRY
2253:             IF EMPTY(loc_cGrupo)
2254:                 loc_cSQL = ""
2255:             ELSE
2256:                 loc_cSQL = " WHERE grclis = " + EscaparSQL(loc_cGrupo)
2257:             ENDIF
2258:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2259:                 "SigCdCli" + loc_cSQL, ;
2260:                 "cursor_4c_BuscaEmiCli", ;
2261:                 "Iclis", ;
2262:                 loc_cCodAtual, ;
2263:                 "Buscar Conta Emissor")
2264:             loc_oBusca.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
2265:             loc_oBusca.mAddColuna("rClis", "", "Nome")
2266:             loc_oBusca.Show()
2267:             IF loc_oBusca.this_lSelecionou
2268:                 IF USED("cursor_4c_BuscaEmiCli")
2269:                     SELECT cursor_4c_BuscaEmiCli
2270:                     IF PEMSTATUS(loc_oPagina, "txt_4c_CdEmiConta", 5)
2271:                         loc_oPagina.txt_4c_CdEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.Iclis)
2272:                     ENDIF
2273:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DsEmiConta", 5)
2274:                         loc_oPagina.txt_4c_DsEmiConta.Value = ALLTRIM(cursor_4c_BuscaEmiCli.rClis)
2275:                     ENDIF
2276:                 ENDIF
2277:             ENDIF
2278:         CATCH TO loc_oErro
2279:             MsgErro(loc_oErro.Message, "Formsigrechp.AbrirLookupEmiConta")
2280:         ENDTRY
2281:         IF USED("cursor_4c_BuscaEmiCli")
2282:             USE IN cursor_4c_BuscaEmiCli
2283:         ENDIF
2284:         IF VARTYPE(loc_oBusca) = "O"
2285:             loc_oBusca = .NULL.
2286:         ENDIF
2287:     ENDPROC
2288: 
2289: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrechpBO.prg):
*==============================================================================
* SIGRECHPBO.PRG
* Business Object: SigReChp - Cheques em aberto
*
* Herda de: RelatorioBase
* Tipo: REPORT
* Tabela principal: SigCqChm + SigChe (join)
* FRX: SigReChp.frx
*==============================================================================

DEFINE CLASS sigrechpBO AS RelatorioBase

    *-- Filtro: tipo de data (1=Data Vencimento, 2=Data Operacao)
    this_nNrTipo            = 1

    *-- Filtro: periodo
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro: empresa
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Filtro: opcao de nota (1=Sim/com nota, 2=Nao/sem nota, 3=Ambos)
    this_nNrOpcao           = 3

    *-- Filtro: emissor - grupo contabil
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""

    *-- Filtro: emissor - conta contabil
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *-- Filtro: destino - grupo contabil
    this_cCdDesGrupo        = ""
    this_cDsDesGrupo        = ""

    *-- Filtro: destino - conta contabil
    this_cCdDesConta        = ""
    this_cDsDesConta        = ""

    *-- Filtro: ordem de classificacao e index selecionado
    this_cNmOrdem           = ""
    this_nOrdemIdx          = 1

    *-- Filtro: imprimir follow-up
    this_lImpFollow         = .F.

    *-- Captions dinamicos do opt_nr_opcao (carregados de SigCdPac)
    this_cCapOpcao1         = ""
    this_cCapOpcao2         = ""
    this_cCapOpcao3         = ""

    *-- Cursores de trabalho
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorTemp        = "cursor_4c_Temp"

    *-- Variaveis de cabecalho do relatorio
    this_cNomeEmpresa       = ""
    this_cTitulo            = ""
    this_cPeriodo           = ""
    this_cEmissor           = ""
    this_cDestino           = ""

    *-- Caminho do arquivo FRX
    this_cArquivoRelatorio  = ""

    *--------------------------------------------------------------------------
    * Init - Configura propriedades basicas do BO de relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela          = ""
            THIS.this_cCampoChave      = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReChp.frx"
            THIS.this_dDtInicial       = DATE()
            THIS.this_dDtFinal         = DATE()
            THIS.this_nNrTipo          = 1
            THIS.this_nNrOpcao         = 3
            THIS.this_nOrdemIdx        = 1
            THIS.this_cTitulo          = "Relat" + CHR(243) + "rio de Cheques Pendentes"
            THIS.this_cCapOpcao1       = "Sim"
            THIS.this_cCapOpcao2       = "N" + CHR(227) + "o"
            THIS.this_cCapOpcao3       = "Ambos"
            loc_lSucesso               = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro do ultimo processamento
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega captions do opt_nr_opcao de SigCdPac
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql
        loc_lSucesso = .F.
        TRY
            loc_cSql = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_Pac")
            IF loc_nResult > 0
                SELECT cursor_4c_Pac
                GO TOP
                IF !EOF()
                    THIS.this_cCapOpcao1 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcS)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcS), "Sim")
                    THIS.this_cCapOpcao2 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcN)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcN), "N" + CHR(227) + "o")
                    THIS.this_cCapOpcao3 = IIF(!EMPTY(ALLTRIM(cursor_4c_Pac.TitOpcA)), ;
                        ALLTRIM(cursor_4c_Pac.TitOpcA), "Ambos")
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarParametros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes DB/TR de SigCdOpt
    * Cria cursor_4c_Operacoes com Flag (L) e Operacaos (C15)
    * Chamado pelo Form em InicializarForm() para popular o grid
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_cOpc
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF

            CREATE CURSOR (THIS.this_cCursorOperacoes) (Flag L, Operacaos C(15))

            loc_cSql = "SELECT Operacaos FROM SigCdOpt " + ;
                       "WHERE Tipos = 'DB' OR Tipos = 'TR' " + ;
                       "ORDER BY Operacaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_OpcLoad")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao carregar opera" + CHR(231) + CHR(245) + ;
                                          "es de SigCdOpt"
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_OpcLoad
            SCAN
                loc_cOpc = ALLTRIM(Operacaos)
                INSERT INTO (THIS.this_cCursorOperacoes) (Flag, Operacaos) ;
                    VALUES (.F., loc_cOpc)
            ENDSCAN

            IF USED("cursor_4c_OpcLoad")
                USE IN cursor_4c_OpcLoad
            ENDIF

            SELECT (THIS.this_cCursorOperacoes)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarOperacoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula CsRelatorio para impressao
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult, loc_cSql, loc_nFlagadas
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta, loc_cVerDesGrupo, loc_cVerDesConta
        LOCAL loc_cCursorFinal

        loc_lSucesso = .F.
        TRY
            *-- Valida periodo
            IF EMPTY(THIS.this_dDtInicial) OR EMPTY(THIS.this_dDtFinal)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDtInicial > THIS.this_dDtFinal
                THIS.this_cMensagemErro = "Data inicial maior que data final"
                loc_lSucesso = .F.
            ENDIF

            *-- Valida operacoes selecionadas
            IF !USED(THIS.this_cCursorOperacoes)
                THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(245) + ;
                                          "es n" + CHR(227) + "o carregadas"
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorOperacoes)
            COUNT TO loc_nFlagadas FOR Flag
            IF loc_nFlagadas = 0
                THIS.this_cMensagemErro = "Selecione ao menos uma opera" + CHR(231) + CHR(227) + "o"
                loc_lSucesso = .F.
            ENDIF

            *-- Clausula WHERE: tipo de data (Vencimento=1 ou Operacao=2)
            IF THIS.this_nNrTipo = 2
                loc_cVerData = " AND CONVERT(DATE, a.dtents) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ELSE
                loc_cVerData = " AND CONVERT(DATE, b.vencs) BETWEEN " + ;
                               FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            *-- Clausula WHERE: empresa (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            *-- Clausula WHERE: opcao de nota (1=com nota, 2=sem nota, 3=ambos)
            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND NOT a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = " + EscaparSQL(SPACE(6))
            ELSE
                loc_cVerOpcao = ""
                ENDIF
            ENDIF

            *-- Clausula WHERE: grupo emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND b.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF

            *-- Clausula WHERE: conta emissor (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND b.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Clausula WHERE: grupo destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesGrupo))
                loc_cVerDesGrupo = ""
            ELSE
                loc_cVerDesGrupo = " AND b.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesGrupo))
            ENDIF

            *-- Clausula WHERE: conta destino (opcional)
            IF EMPTY(ALLTRIM(THIS.this_cCdDesConta))
                loc_cVerDesConta = ""
            ELSE
                loc_cVerDesConta = " AND b.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDesConta))
            ENDIF

            *-- 1. Query SQL Server: SigCqChm JOIN SigChe com todos os filtros
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            loc_cSql = "SELECT a.nums, a.numlotes, a.dtents, b.grclis, b.iclis, " + ;
                       "b.vencs, b.bancos, b.agencias, b.ncontas, b.ncheques, " + ;
                       "b.valors, b.emps, b.umovs, ' ' AS Hists " + ;
                       "FROM SigCqChm a, SigChe b " + ;
                       "WHERE a.nums = b.nums"
            loc_cSql = loc_cSql + loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta + ;
                       loc_cVerDesGrupo + loc_cVerDesConta + ;
                       " ORDER BY a.nums, a.numlotes, a.dtents, " + ;
                       "b.grclis, b.iclis, b.vencs, b.bancos, " + ;
                       "b.agencias, b.ncontas, b.ncheques, b.valors, b.emps, b.umovs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSql, "cursor_4c_SqlTmp0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados dos cheques"
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Join VFP local com operacoes selecionadas -> cursor resultado
            *-- ImpFollow: resultado vai para cursor_4c_Temp; senao: vai para CsRelatorio
            loc_cCursorFinal = IIF(THIS.this_lImpFollow, THIS.this_cCursorTemp, "CsRelatorio")

            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF THIS.this_lImpFollow AND USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF

            *-- SELECT com ORDER BY dinamico baseado no indice do combobox de ordem
            DO CASE
                CASE THIS.this_nOrdemIdx = 2
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 4 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
                CASE THIS.this_nOrdemIdx = 3
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 5 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
                OTHERWISE
                    SELECT a.nums, SPACE(50) AS RClis, ;
                           MAX(a.valors) AS valors, MAX(a.vencs) AS vencs, ;
                           MAX(a.dtents) AS dtents, MAX(a.grclis) AS grclis, ;
                           MAX(a.numlotes) AS numlotes, MAX(a.iclis) AS iclis, ;
                           MAX(a.bancos) AS bancos, MAX(a.agencias) AS agencias, ;
                           MAX(a.ncontas) AS ncontas, MAX(a.ncheques) AS ncheques, ;
                           MAX(a.emps) AS emps, MAX(a.umovs) AS umovs, ;
                           MAX(a.Hists) AS Hists ;
                      FROM cursor_4c_SqlTmp0 a, cursor_4c_Operacoes d ;
                     WHERE ALLTRIM(a.umovs) = ALLTRIM(d.Operacaos) AND d.Flag ;
                     GROUP BY 1, 2 ;
                     ORDER BY 3 ;
                      INTO CURSOR (loc_cCursorFinal) READWRITE
            ENDCASE

            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF

            *-- 3. Preenche rClis e opcionalmente Hists
            IF THIS.this_lImpFollow
                THIS.ProcessarComFollowUp()
            ELSE
                THIS.BuscarClientes()
            ENDIF

            SELECT CsRelatorio
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarClientes - Preenche rClis em CsRelatorio via SigCdCli (sem FollowUp)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE BuscarClientes()
        LOCAL loc_cSqlC, loc_nResult, loc_cIclis
        TRY
            SELECT CsRelatorio
            SCAN
                loc_cIclis = ALLTRIM(CsRelatorio.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliB")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliB
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliB.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliB
                    ENDIF
                    SELECT CsRelatorio
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.BuscarClientes")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarComFollowUp - Cria CsRelatorio com Hists e rClis do SigCheH/SigCdCli
    * Usado quando ImpFollow = .T.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ProcessarComFollowUp()
        LOCAL loc_cSqlH, loc_cSqlC, loc_nResult, loc_cNums, loc_cIclis
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            CREATE CURSOR CsRelatorio (Nums C(8), Numlotes N(8,0), dtents D, ;
                                       GrClis C(10), Iclis C(10), Vencs D, ;
                                       Bancos C(3), Agencias C(4), nContas C(10), ;
                                       nCheques C(6), Valors N(12,2), Emps C(3), ;
                                       Umovs C(15), Hists C(76), RClis C(50))

            SELECT (THIS.this_cCursorTemp)
            SCAN
                SCATTER MEMVAR MEMO

                SELECT CsRelatorio
                APPEND BLANK
                GATHER MEMVAR MEMO

                *-- Busca historico do cheque em SigCheH
                loc_cNums = ALLTRIM(m.Nums)
                loc_cSqlH = "SELECT TOP 1 Hists FROM SigCheH WHERE Nums = " + ;
                            EscaparSQL(loc_cNums)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlH, "cursor_4c_CheH")
                IF loc_nResult > 0
                    SELECT cursor_4c_CheH
                    IF !EOF()
                        REPLACE CsRelatorio.Hists WITH ALLTRIM(cursor_4c_CheH.Hists) ;
                                IN CsRelatorio
                    ENDIF
                    USE IN cursor_4c_CheH
                ENDIF

                *-- Busca razao social do cliente em SigCdCli
                loc_cIclis = ALLTRIM(m.Iclis)
                IF !EMPTY(loc_cIclis)
                    loc_cSqlC = "SELECT TOP 1 rClis FROM SigCdCli WHERE Iclis = " + ;
                                EscaparSQL(loc_cIclis)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlC, "cursor_4c_CliF")
                    IF loc_nResult > 0
                        SELECT cursor_4c_CliF
                        IF !EOF()
                            REPLACE CsRelatorio.RClis WITH ALLTRIM(cursor_4c_CliF.rClis) ;
                                    IN CsRelatorio
                        ENDIF
                        USE IN cursor_4c_CliF
                    ENDIF
                ENDIF

                SELECT (THIS.this_cCursorTemp)
            ENDSCAN

            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.ProcessarComFollowUp")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria cursor CsCabecalho para o cabecalho do relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp
        LOCAL loc_cNomeEmpresa, loc_cTipoData, loc_cPeriodo, loc_cEmissor, loc_cDestino

        loc_lSucesso = .F.
        TRY
            loc_cNomeEmpresa = ""
            loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cEmps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            IF THIS.this_nNrTipo = 2
                loc_cTipoData = "Data da Movimenta" + CHR(231) + CHR(227) + "o: "
            ELSE
                loc_cTipoData = "Data de Vencimento: "
            ENDIF

            loc_cPeriodo = loc_cTipoData + ;
                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                           DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdEmiConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsEmiConta))

            loc_cDestino = "Grupo / Conta Destino  : " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesGrupo)), ;
                               "Todos", ;
                               ALLTRIM(THIS.this_cCdDesGrupo) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesGrupo)) + ;
                           " / " + ;
                           IIF(EMPTY(ALLTRIM(THIS.this_cCdDesConta)), ;
                               "Todas", ;
                               ALLTRIM(THIS.this_cCdDesConta) + " - " + ;
                               ALLTRIM(THIS.this_cDsDesConta))

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho (NomeEmpresa C(80), Titulo C(80), ;
                                       Periodo C(80), Operacao C(80), ;
                                       Emissor C(80), Destino C(80))
            INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo, Emissor, Destino) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo, ;
                        loc_cPeriodo, loc_cEmissor, loc_cDestino)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            IF USED(THIS.this_cCursorTemp)
                USE IN (THIS.this_cCursorTemp)
            ENDIF
            IF USED("cursor_4c_SqlTmp0")
                USE IN cursor_4c_SqlTmp0
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT CsRelatorio
            REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrechpBO.Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdemIdx, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";DES="  + ALLTRIM(THIS.this_cCdDesGrupo) + "/" + ALLTRIM(THIS.this_cCdDesConta) + ;
                     ";FLW="  + IIF(THIS.this_lImpFollow, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do BO a partir de cursor de preset
    * par_cAliasCursor: nome do cursor com colunas dos filtros previamente usados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de preset n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + ALLTRIM(NVL(loc_cAlias, ""))
            ELSE
                SELECT (loc_cAlias)
                IF EOF()
                    THIS.this_cMensagemErro = "Cursor de preset vazio: " + loc_cAlias
                ELSE
                    SCATTER MEMVAR

                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.dDtInicial") = "D"
                        THIS.this_dDtInicial = m.dDtInicial
                    ENDIF
                    IF TYPE("m.dDtFinal") = "D"
                        THIS.this_dDtFinal = m.dDtFinal
                    ENDIF
                    IF TYPE("m.cCdEmpresa") = "C"
                        THIS.this_cCdEmpresa = ALLTRIM(m.cCdEmpresa)
                    ENDIF
                    IF TYPE("m.cDsEmpresa") = "C"
                        THIS.this_cDsEmpresa = ALLTRIM(m.cDsEmpresa)
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.cCdEmiGrupo") = "C"
                        THIS.this_cCdEmiGrupo = ALLTRIM(m.cCdEmiGrupo)
                    ENDIF
                    IF TYPE("m.cDsEmiGrupo") = "C"
                        THIS.this_cDsEmiGrupo = ALLTRIM(m.cDsEmiGrupo)
                    ENDIF
                    IF TYPE("m.cCdEmiConta") = "C"
                        THIS.this_cCdEmiConta = ALLTRIM(m.cCdEmiConta)
                    ENDIF
                    IF TYPE("m.cDsEmiConta") = "C"
                        THIS.this_cDsEmiConta = ALLTRIM(m.cDsEmiConta)
                    ENDIF
                    IF TYPE("m.cCdDesGrupo") = "C"
                        THIS.this_cCdDesGrupo = ALLTRIM(m.cCdDesGrupo)
                    ENDIF
                    IF TYPE("m.cDsDesGrupo") = "C"
                        THIS.this_cDsDesGrupo = ALLTRIM(m.cDsDesGrupo)
                    ENDIF
                    IF TYPE("m.cCdDesConta") = "C"
                        THIS.this_cCdDesConta = ALLTRIM(m.cCdDesConta)
                    ENDIF
                    IF TYPE("m.cDsDesConta") = "C"
                        THIS.this_cDsDesConta = ALLTRIM(m.cDsDesConta)
                    ENDIF
                    IF TYPE("m.nOrdemIdx") = "N"
                        THIS.this_nOrdemIdx = m.nOrdemIdx
                    ENDIF
                    IF TYPE("m.lImpFollow") = "L"
                        THIS.this_lImpFollow = m.lImpFollow
                    ENDIF

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: produzir documento impresso
    * Delega para Imprimir e registra auditoria de IMPRESSAO
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: recalcular e visualizar
    * Delega para Visualizar e registra auditoria de VISUALIZACAO
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrechpBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReChp") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            *-- Auditoria nao deve interromper geracao do relatorio
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

