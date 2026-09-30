# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (12)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CARGA-DADOS] OptionGroup 'opt_4c_Custo' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Filtro' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [METODO-INEXISTENTE] Metodo 'THIS.Width()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Lista' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_ListaTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Estoque' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_EstoqueTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fornecedor' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Empresa, Movimentação, Numero, Grupo, Conta, Código, Descrição, Valor, Quantidade, Baixado, Reservado, Saldo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Dados.Pageframe1.Page1): Top original=184 vs migrado 'lbl_4c_Label1' Top=135 (diff=49px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGPRCTR.Pagina.Dados.Pageframe1.Page1): Left original=55 vs migrado 'lbl_4c_Label1' Left=440 (diff=385px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3480 linhas total):

*-- Linhas 29 a 206:
29:     *===========================================================================
30:     * Init - Inicializa o formulario
31:     * REGRA CRITICA: Apenas RETURN DODEFAULT()
32:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
33:     *===========================================================================
34:     PROCEDURE Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *===========================================================================
39:     * InicializarForm - Configura estrutura completa
40:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
41:     *===========================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:         LOCAL loc_lSucesso
44:         loc_lSucesso = .F.
45: 
46:         TRY
47:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrCtrBO")
48: 
49:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
50:                 MostrarErro("Erro ao criar SigPrCtrBO" + CHR(13) + ;
51:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
52:                     "FormSigPrCtr.InicializarForm")
53:             ELSE
54:                 THIS.ConfigurarPageFrame()
55:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
58:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59:                 THIS.pgf_4c_Paginas.Visible = .T.
60:                 THIS.pgf_4c_Paginas.ActivePage = 1
61:                 THIS.this_cModoAtual = "LISTA"
62: 
63:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
64:                     THIS.CarregarCursoresGlobais()
65:                 ENDIF
66: 
67:                 loc_lSucesso = .T.
68:             ENDIF
69: 
70:         CATCH TO loException
71:             MostrarErro("Erro ao inicializar FormSigPrCtr:" + CHR(13) + ;
72:                 loException.Message + CHR(13) + ;
73:                 "Linha: " + TRANSFORM(loException.LineNo), ;
74:                 "FormSigPrCtr.InicializarForm")
75:         ENDTRY
76: 
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *===========================================================================
81:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
82:     * Top=-29 para esconder abas; controles compensam +29 no Top
83:     *===========================================================================
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .PageCount = 2
89:             .Top       = -29
90:             .Left      = 0
91:             .Width     = THIS.Width
92:             .Height    = THIS.Height + 29
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *===========================================================================
110:     * CarregarCursoresGlobais - Cursores de sessao carregados uma vez no Init
111:     * legado: crSigCdPam (parametros gerais - moedetqs/GrPadFors, usados pelo
112:     * botao Processar e por LimparCampos), crSigCdMoe/crSigCdCot (cotacao de
113:     * moedas, consumidos por SigPrCtrBO.CarregarCambio - fCarregarCambio nao
114:     * foi portada, memoria fCarregarCambio_nao_portada). Mantidos com o nome
115:     * ORIGINAL do legado (sem prefixo cursor_4c_) - mesma convencao ja usada
116:     * neste form para os cursores de trabalho da aba XML (crMovimentos etc).
117:     *===========================================================================
118:     PROTECTED PROCEDURE CarregarCursoresGlobais()
119:         TRY
120:             IF USED("crSigCdPam")
121:                 USE IN crSigCdPam
122:             ENDIF
123:             SQLEXEC(gnConnHandle, "SELECT * FROM SigCdPam", "crSigCdPam")
124: 
125:             IF USED("crSigCdMoe")
126:                 USE IN crSigCdMoe
127:             ENDIF
128:             SQLEXEC(gnConnHandle, "SELECT CMoes, Cotas FROM SigCdMoe", "crSigCdMoe")
129:             IF USED("crSigCdMoe")
130:                 SELECT crSigCdMoe
131:                 INDEX ON CMoes TAG CMoes
132:             ENDIF
133: 
134:             IF USED("crSigCdCot")
135:                 USE IN crSigCdCot
136:             ENDIF
137:             SQLEXEC(gnConnHandle, "SELECT * FROM SigCdCot", "crSigCdCot")
138:             IF USED("crSigCdCot")
139:                 SELECT crSigCdCot
140:                 INDEX ON CMoes + DTOS(Datas) TAG CMoeData DESCENDING
141:                 SET ORDER TO CMoeData DESCENDING
142:             ENDIF
143:         CATCH TO loException
144:             MostrarErro(loException, "FormSigPrCtr.CarregarCursoresGlobais")
145:         ENDTRY
146:     ENDPROC
147: 
148:     *===========================================================================
149:     * ConfigurarPaginaLista - Page1 completa (FASE 4)
150:     * Cabecalho (faixa cinza, regra #11) + filtro de periodo (legado:
151:     * Pagina.Lista.Dt_inicial/Dt_final) + Grid (legado: Pagina.Lista.Grade,
152:     * alimentada pela query lcQueryLista do Init) + container de botoes CRUD
153:     * (Incluir/Visualizar/Alterar/Excluir/Buscar) + container de saida
154:     * (Encerrar - padrao canonico, regra #10).
155:     *===========================================================================
156:     PROTECTED PROCEDURE ConfigurarPaginaLista()
157:         LOCAL loc_oPagina, loc_oCnt, loc_oGrid
158:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
159: 
160:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
161: 
162:         *-- Container Cabecalho (cntSombra no legado) - PRIMEIRO AddObject da pagina (regra #11)
163:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
164:         WITH loc_oPagina.cnt_4c_Cabecalho
165:             .Top         = 31
166:             .Left        = 0
167:             .Width       = THIS.Width
168:             .Height      = 80
169:             .BackColor   = RGB(100, 100, 100)
170:             .BorderWidth = 0
171:             .Visible     = .T.
172:         ENDWITH
173: 
174:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
175:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
176:             .Caption   = THIS.Caption
177:             .Top       = 15
178:             .Left      = 10
179:             .Width     = THIS.Width - 20
180:             .Height    = 40
181:             .FontName  = "Tahoma"
182:             .FontSize  = 16
183:             .FontBold  = .T.
184:             .ForeColor = RGB(0, 0, 0)
185:             .BackStyle = 0
186:             .AutoSize  = .F.
187:             .Visible   = .T.
188:         ENDWITH
189: 
190:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
191:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
192:             .Caption   = THIS.Caption
193:             .Top       = 18
194:             .Left      = 10
195:             .Width     = THIS.Width - 20
196:             .Height    = 46
197:             .FontName  = "Tahoma"
198:             .FontSize  = 16
199:             .FontBold  = .T.
200:             .ForeColor = RGB(255, 255, 255)
201:             .BackStyle = 0
202:             .AutoSize  = .F.
203:             .Visible   = .T.
204:         ENDWITH
205: 
206:         *-- Container Botoes CRUD (Grupo_Op no legado) - canonico: BackColor RGB(53,53,53)

*-- Linhas 239 a 675:
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:         ENDWITH
242:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
243: 
244:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
245:         WITH loc_oCnt.cmd_4c_Visualizar
246:             .Caption         = "Visualizar"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 80
251:             .Width           = 75
252:             .Height          = 75
253:             .FontName        = "Tahoma"
254:             .FontSize        = 8
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .MousePointer    = 15
262:             .WordWrap        = .T.
263:             .AutoSize        = .F.
264:         ENDWITH
265:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
266: 
267:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
268:         WITH loc_oCnt.cmd_4c_Alterar
269:             .Caption         = "Alterar"
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
271:             .PicturePosition = 13
272:             .Top             = 5
273:             .Left            = 155
274:             .Width           = 75
275:             .Height          = 75
276:             .FontName        = "Tahoma"
277:             .FontSize        = 8
278:             .FontBold        = .T.
279:             .FontItalic      = .T.
280:             .ForeColor       = RGB(90, 90, 90)
281:             .BackColor       = RGB(255, 255, 255)
282:             .Themes          = .F.
283:             .SpecialEffect   = 0
284:             .MousePointer    = 15
285:             .WordWrap        = .T.
286:             .AutoSize        = .F.
287:         ENDWITH
288:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
289: 
290:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
291:         WITH loc_oCnt.cmd_4c_Excluir
292:             .Caption         = "Excluir"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 230
297:             .Width           = 75
298:             .Height          = 75
299:             .FontName        = "Tahoma"
300:             .FontSize        = 8
301:             .FontBold        = .T.
302:             .FontItalic      = .T.
303:             .ForeColor       = RGB(90, 90, 90)
304:             .BackColor       = RGB(255, 255, 255)
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .MousePointer    = 15
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:         ENDWITH
311:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
312: 
313:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
314:         WITH loc_oCnt.cmd_4c_Buscar
315:             .Caption         = "Buscar"
316:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
317:             .PicturePosition = 13
318:             .Top             = 5
319:             .Left            = 305
320:             .Width           = 75
321:             .Height          = 75
322:             .FontName        = "Tahoma"
323:             .FontSize        = 8
324:             .FontBold        = .T.
325:             .FontItalic      = .T.
326:             .ForeColor       = RGB(90, 90, 90)
327:             .BackColor       = RGB(255, 255, 255)
328:             .Themes          = .F.
329:             .SpecialEffect   = 0
330:             .MousePointer    = 15
331:             .WordWrap        = .T.
332:             .AutoSize        = .F.
333:         ENDWITH
334:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
335: 
336:         *-- Container Saida (padrao canonico - regra #10: Width=90, Encerrar 75x75)
337:         *-- Posicionado relativo a THIS.Width (canonico: Left=917 quando Width=1000)
338:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
339:         WITH loc_oPagina.cnt_4c_Saida
340:             .Top         = 29
341:             .Left        = 917
342:             .Width       = 90
343:             .Height      = 85
344:             .BackStyle   = 0
345:             .BorderWidth = 0
346:             .Visible     = .T.
347:         ENDWITH
348:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
349:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
350:             .Caption         = "Encerrar"
351:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
352:             .PicturePosition = 13
353:             .Top             = 5
354:             .Left            = 5
355:             .Width           = 75
356:             .Height          = 75
357:             .FontName        = "Tahoma"
358:             .FontSize        = 8
359:             .FontBold        = .T.
360:             .FontItalic      = .T.
361:             .ForeColor       = RGB(90, 90, 90)
362:             .BackColor       = RGB(255, 255, 255)
363:             .Themes          = .F.
364:             .SpecialEffect   = 0
365:             .MousePointer    = 15
366:             .WordWrap        = .T.
367:             .AutoSize        = .F.
368:         ENDWITH
369:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
370: 
371:         *-- Filtro de Periodo (legado: Pagina.Lista.Label1/Dt_inicial/Dt_final/Say2)
372:         *-- Top compensado: 106+29=135 (Label1/Say2), 102+29=131 (Dt_inicial/Dt_final)
373:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
374:         WITH loc_oPagina.lbl_4c_Label1
375:             .Caption   = "Per" + CHR(237) + "odo :"
376:             .Top       = 135
377:             .Left      = 440
378:             .Width     = 45
379:             .Height    = 15
380:             .FontName  = "Tahoma"
381:             .FontSize  = 8
382:             .ForeColor = RGB(90, 90, 90)
383:             .BackStyle = 0
384:         ENDWITH
385: 
386:         loc_oPagina.AddObject("txt_4c_Dt_inicial", "TextBox")
387:         WITH loc_oPagina.txt_4c_Dt_inicial
388:             .Top      = 131
389:             .Left      = 495
390:             .Width    = 80
391:             .Height   = 21
392:             .Format   = "D"
393:             .Value    = DATE()
394:             .FontName = "Tahoma"
395:             .FontSize = 8
396:         ENDWITH
397:         BINDEVENT(loc_oPagina.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
398: 
399:         loc_oPagina.AddObject("txt_4c_Dt_final", "TextBox")
400:         WITH loc_oPagina.txt_4c_Dt_final
401:             .Top      = 131
402:             .Left     = 598
403:             .Width    = 80
404:             .Height   = 21
405:             .Format   = "D"
406:             .Value    = DATE()
407:             .FontName = "Tahoma"
408:             .FontSize = 8
409:         ENDWITH
410:         BINDEVENT(loc_oPagina.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")
411: 
412:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
413:         WITH loc_oPagina.lbl_4c_Label2
414:             .Caption   = "?"
415:             .Top       = 135
416:             .Left      = 582
417:             .Width     = 15
418:             .Height    = 15
419:             .FontName  = "Tahoma"
420:             .FontSize  = 8
421:             .ForeColor = RGB(90, 90, 90)
422:             .BackStyle = 0
423:         ENDWITH
424: 
425:         *-- Grid de Lista (Grade no legado) - Top compensado: 130+29=159
426:         *-- Alimentada por CarregarLista() com a query lcQueryLista do Init legado
427:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
428:         loc_oGrid = loc_oPagina.grd_4c_Lista
429:         loc_oGrid.Top                = 159
430:         loc_oGrid.Left               = 12
431:         loc_oGrid.Width              = 1138
432:         loc_oGrid.Height             = 470
433:         loc_oGrid.ColumnCount        = 6
434:         loc_oGrid.FontName           = "Tahoma"
435:         loc_oGrid.FontSize           = 8
436:         loc_oGrid.ForeColor          = RGB(90, 90, 90)
437:         loc_oGrid.BackColor          = RGB(255, 255, 255)
438:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
439:         loc_oGrid.HighlightBackColor = RGB(255, 255, 255)
440:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
441:         loc_oGrid.HighlightStyle     = 2
442:         loc_oGrid.DeleteMark         = .F.
443:         loc_oGrid.RecordMark         = .F.
444:         loc_oGrid.RowHeight          = 16
445:         loc_oGrid.ScrollBars         = 2
446:         loc_oGrid.GridLines          = 3
447:         loc_oGrid.ReadOnly           = .T.
448:         WITH loc_oGrid
449:             .Column1.Width = 80
450:             .Column2.Width = 75
451:             .Column3.Width = 280
452:             .Column4.Width = 80
453:             .Column5.Width = 80
454:             .Column6.Width = 180
455:         ENDWITH
456: 
457:         THIS.TornarControlesVisiveis(loc_oPagina)
458:     ENDPROC
459: 
460:     *===========================================================================
461:     * CarregarLista - Carrega o Grid da Lista com a query agregada do Init
462:     * legado (lcQueryLista): distinct por Codigos/OriDopNums/Usuars/Contas,
463:     * filtrado pelo periodo de txt_4c_Dt_inicial/txt_4c_Dt_final (default:
464:     * dia atual, igual ao legado ldDatai=fDtoSQL(Date())).
465:     *===========================================================================
466:     PROCEDURE CarregarLista()
467:         LOCAL loc_lResultado, loc_oPagina, loc_oGrid, loc_dDataIni, loc_dDataFimBase, ;
468:             loc_tDataFim, loc_cSQL, loc_nResultado
469:         loc_lResultado = .F.
470: 
471:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
472:             IF USED("cursor_4c_Lista")
473:                 USE IN cursor_4c_Lista
474:             ENDIF
475:             SET NULL ON
476:             CREATE CURSOR cursor_4c_Lista ;
477:                 (Codigos C(10), Datas T, OriDopNums C(29), Usuars C(10), Contas C(10), Rclis C(50))
478:             SET NULL OFF
479:             RETURN .T.
480:         ENDIF
481: 
482:         TRY
483:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
484:             loc_oGrid   = loc_oPagina.grd_4c_Lista
485: 
486:             *-- Desvincula o Grid ANTES de requerer no mesmo nome de cursor
487:             *-- (mesmo padrao ja usado em MontaGrade) - evita que o Grid
488:             *-- fique preso ao cursor durante o SQLEXEC que o recria.
489:             loc_oGrid.RecordSource = ""
490: 
491:             loc_dDataIni     = ConverterParaData(loc_oPagina.txt_4c_Dt_inicial.Value)
492:             loc_dDataFimBase = ConverterParaData(loc_oPagina.txt_4c_Dt_final.Value)
493:             loc_tDataFim = DATETIME(YEAR(loc_dDataFimBase), MONTH(loc_dDataFimBase), ;
494:                 DAY(loc_dDataFimBase), 23, 59, 59)
495: 
496:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
497:                 SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas, a.OriDopNums,
498:                     a.Usuars, a.Contas, b.Rclis
499:                 FROM SigPrCtr a
500:                 JOIN SigCdCli b ON a.Contas = b.Iclis
501:                 WHERE a.Datas BETWEEN <<FormatarDataSQL(loc_dDataIni)>> AND <<FormatarDataSQL(loc_tDataFim)>>
502:                 GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis
503:             ENDTEXT
504: 
505:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
506: 
507:             IF loc_nResultado >= 0
508:                 loc_oGrid.ColumnCount           = 6
509:                 loc_oGrid.RecordSource          = "cursor_4c_Lista"
510:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.Codigos"
511:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.Datas"
512:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.OriDopNums"
513:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.Usuars"
514:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.Contas"
515:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.Rclis"
516: 
517:                 *-- Reconfigurar cabecalhos e largura APOS RecordSource (obrigatorio - regra #48)
518:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
519:                 loc_oGrid.Column2.Header1.Caption = "Data"
520:                 loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
521:                 loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
522:                 loc_oGrid.Column5.Header1.Caption = "Fornecedor"
523:                 loc_oGrid.Column6.Header1.Caption = "Nome"
524: 
525:                 THIS.FormatarGridLista(loc_oGrid)
526: 
527:                 *-- Column.Width por ULTIMO (regra #35c: RecordSource/ControlSource
528:                 *-- recalculam a largura para o default 90 - so fica se atribuido
529:                 *-- DEPOIS do FormatarGridLista)
530:                 loc_oGrid.Column1.Width = 80
531:                 loc_oGrid.Column2.Width = 75
532:                 loc_oGrid.Column3.Width = 280
533:                 loc_oGrid.Column4.Width = 80
534:                 loc_oGrid.Column5.Width = 80
535:                 loc_oGrid.Column6.Width = 180
536: 
537:                 IF USED("cursor_4c_Lista")
538:                     GO TOP IN cursor_4c_Lista
539:                 ENDIF
540:                 loc_oGrid.Refresh()
541:                 loc_lResultado = .T.
542:             ELSE
543:                 MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "CarregarLista")
544:             ENDIF
545:         CATCH TO loException
546:             MostrarErro(loException, "FormSigPrCtr.CarregarLista")
547:         ENDTRY
548: 
549:         RETURN loc_lResultado
550:     ENDPROC
551: 
552:     *===========================================================================
553:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
554:     *===========================================================================
555:     PROCEDURE AlternarPagina(par_nPagina)
556:         LOCAL loc_lResultado
557:         loc_lResultado = .F.
558: 
559:         TRY
560:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
561:                 MsgErro("Parametro invalido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
562:             ELSE
563:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
564:                 IF par_nPagina = 1
565:                     THIS.this_cModoAtual = "LISTA"
566:                     THIS.CarregarLista()
567:                     THIS.AjustarBotoesPorModo()
568:                 ENDIF
569:                 loc_lResultado = .T.
570:             ENDIF
571:         CATCH TO loException
572:             MostrarErro(loException, "FormSigPrCtr.AlternarPagina")
573:         ENDTRY
574: 
575:         RETURN loc_lResultado
576:     ENDPROC
577: 
578:     *===========================================================================
579:     * FormatarGridLista - Formata visual do grid da lista
580:     *===========================================================================
581:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
582:         WITH par_oGrid
583:             .FontName = "Tahoma"
584:             .FontSize = 8
585:         ENDWITH
586:     ENDPROC
587: 
588:     *===========================================================================
589:     * ValidarDataInicial - LostFocus de txt_4c_Dt_inicial (legado: Dt_inicial.Valid)
590:     * Se a data inicial ultrapassar a final, empurra a final junto.
591:     *===========================================================================
592:     PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
593:         LOCAL loc_oPagina
594:         TRY
595:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
596:             IF loc_oPagina.txt_4c_Dt_inicial.Value > loc_oPagina.txt_4c_Dt_final.Value
597:                 loc_oPagina.txt_4c_Dt_final.Value = loc_oPagina.txt_4c_Dt_inicial.Value
598:             ENDIF
599:         CATCH TO loException
600:             MostrarErro(loException, "FormSigPrCtr.ValidarDataInicial")
601:         ENDTRY
602:     ENDPROC
603: 
604:     *===========================================================================
605:     * ValidarDataFinal - LostFocus de txt_4c_Dt_final (legado: Dt_final.Valid +
606:     * Dt_final.LostFocus: reconstroi a data final, recarrega a Grade e devolve
607:     * o foco para ela).
608:     *===========================================================================
609:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
610:         LOCAL loc_oPagina
611:         TRY
612:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
613:             IF loc_oPagina.txt_4c_Dt_final.Value < loc_oPagina.txt_4c_Dt_inicial.Value
614:                 loc_oPagina.txt_4c_Dt_inicial.Value = loc_oPagina.txt_4c_Dt_final.Value
615:             ENDIF
616:             THIS.CarregarLista()
617:             loc_oPagina.grd_4c_Lista.SetFocus()
618:         CATCH TO loException
619:             MostrarErro(loException, "FormSigPrCtr.ValidarDataFinal")
620:         ENDTRY
621:     ENDPROC
622: 
623:     *===========================================================================
624:     * BtnEncerrarClick - Fecha o formulario
625:     *===========================================================================
626:     PROCEDURE BtnEncerrarClick()
627:         THIS.Release()
628:     ENDPROC
629: 
630:     *===========================================================================
631:     * ConfigurarPaginaDados - Estrutura base de Page2 (FASE 3)
632:     * Cabecalho (faixa cinza, regra #11) + container vazio de botoes de acao.
633:     * Campos e lookups entram nas Fases 5-6.
634:     *===========================================================================
635:     PROTECTED PROCEDURE ConfigurarPaginaDados()
636:         LOCAL loc_oPagina, loc_oAba1, loc_oAba2, loc_oGrid
637:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
638: 
639:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
640: 
641:         *-- Cabecalho cinza (identico ao da pagina Lista - regra #11)
642:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
643:         WITH loc_oPagina.cnt_4c_Cabecalho
644:             .Top           = 29
645:             .Left          = 0
646:             .Width         = THIS.Width
647:             .Height        = 80
648:             .BackColor     = RGB(100, 100, 100)
649:             .BorderWidth   = 0
650:             .SpecialEffect = 0
651:             .Visible       = .T.
652: 
653:             .AddObject("lbl_4c_Sombra", "Label")
654:             WITH .lbl_4c_Sombra
655:                 .Caption   = THIS.Caption
656:                 .Top       = 15
657:                 .Left      = 10
658:                 .Width     = THIS.Width
659:                 .Height    = 40
660:                 .FontName  = "Tahoma"
661:                 .FontSize  = 16
662:                 .FontBold  = .T.
663:                 .ForeColor = RGB(0, 0, 0)
664:                 .BackStyle = 0
665:                 .AutoSize  = .F.
666:                 .Visible   = .T.
667:             ENDWITH
668: 
669:             .AddObject("lbl_4c_Titulo", "Label")
670:             WITH .lbl_4c_Titulo
671:                 .Caption   = THIS.Caption
672:                 .Top       = 18
673:                 .Left      = 10
674:                 .Width     = THIS.Width
675:                 .Height    = 46

*-- Linhas 719 a 793:
719:             .AutoSize        = .F.
720:             .Enabled         = .F.
721:         ENDWITH
722:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
723: 
724:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
725:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
726:             .Caption         = "Encerrar"
727:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
728:             .PicturePosition = 13
729:             .Top             = 5
730:             .Left            = 80
731:             .Width           = 75
732:             .Height          = 75
733:             .FontName        = "Comic Sans MS"
734:             .FontSize        = 8
735:             .FontBold        = .T.
736:             .FontItalic      = .T.
737:             .ForeColor       = RGB(90, 90, 90)
738:             .BackColor       = RGB(255, 255, 255)
739:             .Themes          = .F.
740:             .SpecialEffect   = 0
741:             .MousePointer    = 15
742:             .WordWrap        = .T.
743:             .AutoSize        = .F.
744:         ENDWITH
745:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
746: 
747:         *-- ===================================================================
748:         *-- PageFrame interno (legado: Pagina.Dados.Pageframe1) - Precificacao
749:         *-- (Page1) e Movimentacoes/Produtos (Page2). Tabs=.T. (abas reais e
750:         *-- visiveis, ao contrario do PageFrame externo pgf_4c_Paginas) - por
751:         *-- isso os filhos usam as coordenadas ORIGINAIS do SCX (relativas a
752:         *-- Pageframe1.PageN), SEM a compensacao +29 do truque Top=-29.
753:         *-- Aba Precificacao (Page1): labels, textboxes, os 2 OptionGroups de
754:         *-- filtro/precificacao e a grd_4c_Estoque. Botoes (processar/
755:         *-- btnCadastros/Bot_Consulta/Command12/cmdOperacao) e os grids da
756:         *-- aba Page2 (grd_4c_Disponivel/grd_4c_ItemXml) entram em fase
757:         *-- posterior.
758:         *-- ===================================================================
759:         loc_oPagina.AddObject("pgf_4c_Detalhes", "PageFrame")
760:         WITH loc_oPagina.pgf_4c_Detalhes
761:             .PageCount = 2
762:             .Top       = 115
763:             .Left      = 5
764:             .Width     = THIS.Width - 10
765:             .Height    = 485
766:             .Tabs      = .T.
767:             .Visible   = .T.
768: 
769:             .Page1.Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
770:             .Page1.BackColor = RGB(255, 255, 255)
771: 
772:             .Page2.Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
773:             .Page2.BackColor = RGB(255, 255, 255)
774:         ENDWITH
775: 
776:         loc_oAba1 = loc_oPagina.pgf_4c_Detalhes.Page1
777: 
778:         *-- Say4 "Fornecedores :"
779:         loc_oAba1.AddObject("lbl_4c_Fornecedores", "Label")
780:         WITH loc_oAba1.lbl_4c_Fornecedores
781:             .Caption   = "Fornecedores :"
782:             .Top       = 69
783:             .Left      = 228
784:             .Width     = 75
785:             .Height    = 15
786:             .Alignment = 0
787:             .AutoSize  = .F.
788:             .BackStyle = 0
789:             .FontName  = "Tahoma"
790:             .FontSize  = 8
791:             .ForeColor = RGB(90, 90, 90)
792:         ENDWITH
793: 

*-- Linhas 810 a 929:
810:             .ForeColor     = RGB(0, 0, 0)
811:             .Value         = ""
812:         ENDWITH
813:         BINDEVENT(loc_oAba1.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoAcesso")
814: 
815:         *-- Get_Conta -> this_cContas (schema: contas char(10))
816:         loc_oAba1.AddObject("txt_4c_Conta", "TextBox")
817:         WITH loc_oAba1.txt_4c_Conta
818:             .Top           = 66
819:             .Left          = 394
820:             .Width         = 85
821:             .Height        = 21
822:             .FontName      = "Tahoma"
823:             .FontSize      = 8
824:             .Format        = "K"
825:             .Alignment     = 0
826:             .MaxLength     = 10
827:             .BorderStyle   = 1
828:             .SpecialEffect = 1
829:             .ForeColor     = RGB(0, 0, 0)
830:             .Value         = ""
831:         ENDWITH
832:         BINDEVENT(loc_oAba1.txt_4c_Conta, "KeyPress", THIS, "ValidarContaFornecedor")
833: 
834:         *-- Get_cpf (CPF/CNPJ do fornecedor - validacao fValidarCPF/fValidarCNPJ;
835:         *-- SigPrCtr nao tem coluna de CPF, campo nao e persistido diretamente)
836:         loc_oAba1.AddObject("txt_4c_Cpf", "TextBox")
837:         WITH loc_oAba1.txt_4c_Cpf
838:             .Top           = 66
839:             .Left          = 481
840:             .Width         = 146
841:             .Height        = 21
842:             .FontName      = "Tahoma"
843:             .FontSize      = 8
844:             .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
845:             .MaxLength     = 20
846:             .SpecialEffect = 1
847:             .ForeColor     = RGB(0, 0, 0)
848:             .Value         = ""
849:         ENDWITH
850:         BINDEVENT(loc_oAba1.txt_4c_Cpf, "KeyPress", THIS, "ValidarCpfCnpjFornecedor")
851: 
852:         *-- Get_Dconta (nome/razao social do fornecedor, preenchido apos
853:         *-- validar a Conta - CursorQuery em SigCdCli.Rclis no legado)
854:         loc_oAba1.AddObject("txt_4c_Dconta", "TextBox")
855:         WITH loc_oAba1.txt_4c_Dconta
856:             .Top           = 89
857:             .Left          = 307
858:             .Width         = 357
859:             .Height        = 21
860:             .FontName      = "Tahoma"
861:             .FontSize      = 8
862:             .Format        = "K"
863:             .MaxLength     = 40
864:             .SpecialEffect = 1
865:             .ForeColor     = RGB(0, 0, 0)
866:             .Value         = ""
867:         ENDWITH
868:         BINDEVENT(loc_oAba1.txt_4c_Dconta, "KeyPress", THIS, "ValidarDescricaoConta")
869: 
870:         *-- Say1 "Precificacao :"
871:         loc_oAba1.AddObject("lbl_4c_Precificacao", "Label")
872:         WITH loc_oAba1.lbl_4c_Precificacao
873:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o :"
874:             .Top       = 114
875:             .Left      = 237
876:             .Width     = 66
877:             .Height    = 15
878:             .Alignment = 0
879:             .AutoSize  = .F.
880:             .BackStyle = 0
881:             .FontName  = "Tahoma"
882:             .FontSize  = 8
883:             .ForeColor = RGB(90, 90, 90)
884:         ENDWITH
885: 
886:         *-- Opt_Custo -> lnOpc do Grupo_Salva.Salva.Click legado (Custo Total
887:         *-- x Custo pela Composicao). OptionGroup NAO tem ForeColor proprio
888:         *-- (regra #33) - cor fica em cada Buttons(N).
889:         loc_oAba1.AddObject("opt_4c_Custo", "OptionGroup")
890:         WITH loc_oAba1.opt_4c_Custo
891:             .ButtonCount = 2
892:             .Top         = 113
893:             .Left        = 303
894:             .Width       = 255
895:             .Height      = 17
896:             .BackStyle   = 0
897:             .BorderStyle = 0
898:             .Value       = 1
899:         ENDWITH
900:         WITH loc_oAba1.opt_4c_Custo.Buttons(1)
901:             .Caption   = "Custo Total"
902:             .Top       = 1
903:             .Left      = 5
904:             .Width     = 73
905:             .Height    = 15
906:             .AutoSize  = .T.
907:             .FontName  = "Tahoma"
908:             .FontSize  = 8
909:             .BackStyle = 0
910:             .ForeColor = RGB(90, 90, 90)
911:         ENDWITH
912:         WITH loc_oAba1.opt_4c_Custo.Buttons(2)
913:             .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
914:             .Top       = 1
915:             .Left      = 98
916:             .Width     = 129
917:             .Height    = 15
918:             .AutoSize  = .T.
919:             .FontName  = "Tahoma"
920:             .FontSize  = 8
921:             .BackStyle = 0
922:             .ForeColor = RGB(90, 90, 90)
923:         ENDWITH
924: 
925:         *-- Say3 "Moeda :"
926:         loc_oAba1.AddObject("lbl_4c_Moeda", "Label")
927:         WITH loc_oAba1.lbl_4c_Moeda
928:             .Caption   = "Moeda :"
929:             .Top       = 137

*-- Linhas 956 a 1043:
956:             .ForeColor     = RGB(0, 0, 0)
957:             .Value         = ""
958:         ENDWITH
959:         BINDEVENT(loc_oAba1.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoedaFornecedor")
960: 
961:         *-- Say2 "Diretorio :"
962:         loc_oAba1.AddObject("lbl_4c_Diretorio", "Label")
963:         WITH loc_oAba1.lbl_4c_Diretorio
964:             .Caption   = "Diret" + CHR(243) + "rio :"
965:             .Top       = 160
966:             .Left      = 253
967:             .Width     = 50
968:             .Height    = 15
969:             .Alignment = 0
970:             .AutoSize  = .F.
971:             .BackStyle = 0
972:             .FontName  = "Tahoma"
973:             .FontSize  = 8
974:             .ForeColor = RGB(90, 90, 90)
975:         ENDWITH
976: 
977:         *-- Get_Arquivo -> this_cArquivo (schema: arquivo char(200))
978:         loc_oAba1.AddObject("txt_4c_Arquivo", "TextBox")
979:         WITH loc_oAba1.txt_4c_Arquivo
980:             .Top           = 157
981:             .Left          = 307
982:             .Width         = 357
983:             .Height        = 21
984:             .FontName      = "Tahoma"
985:             .FontSize      = 8
986:             .MaxLength     = 200
987:             .SpecialEffect = 1
988:             .ForeColor     = RGB(0, 0, 0)
989:             .Value         = ""
990:         ENDWITH
991: 
992:         *-- Opt_Fil -> lnTipo do CarregaArquivos legado (Somente / Nao / Ambos)
993:         loc_oAba1.AddObject("opt_4c_Filtro", "OptionGroup")
994:         WITH loc_oAba1.opt_4c_Filtro
995:             .ButtonCount = 3
996:             .Top         = 179
997:             .Left        = 303
998:             .Width       = 192
999:             .Height      = 24
1000:             .BackStyle   = 0
1001:             .BorderStyle = 0
1002:             .Value       = 1
1003:         ENDWITH
1004:         WITH loc_oAba1.opt_4c_Filtro.Buttons(1)
1005:             .Caption   = "Somente"
1006:             .Top       = 5
1007:             .Left      = 5
1008:             .Width     = 60
1009:             .Height    = 15
1010:             .AutoSize  = .T.
1011:             .FontName  = "Tahoma"
1012:             .FontSize  = 8
1013:             .BackStyle = 0
1014:             .ForeColor = RGB(90, 90, 90)
1015:         ENDWITH
1016:         WITH loc_oAba1.opt_4c_Filtro.Buttons(2)
1017:             .Caption   = "N" + CHR(227) + "o"
1018:             .Top       = 5
1019:             .Left      = 84
1020:             .Width     = 37
1021:             .Height    = 15
1022:             .AutoSize  = .T.
1023:             .FontName  = "Tahoma"
1024:             .FontSize  = 8
1025:             .BackStyle = 0
1026:             .ForeColor = RGB(90, 90, 90)
1027:         ENDWITH
1028:         WITH loc_oAba1.opt_4c_Filtro.Buttons(3)
1029:             .Caption   = "Ambos"
1030:             .Top       = 5
1031:             .Left      = 132
1032:             .Width     = 50
1033:             .Height    = 15
1034:             .AutoSize  = .T.
1035:             .FontName  = "Tahoma"
1036:             .FontSize  = 8
1037:             .BackStyle = 0
1038:             .ForeColor = RGB(90, 90, 90)
1039:         ENDWITH
1040: 
1041:         *-- Label1 "Carregar produtos que constam nos XML's :" (legado declara
1042:         *-- AutoSize=.T. - transcrever Width/Height fixos: regra #23, AutoSize
1043:         *-- e no-op quando o Label e criado via AddObject)

*-- Linhas 1132 a 1354:
1132:             .Column5.Header1.ForeColor   = RGB(90, 90, 90)
1133:             .Column5.Header1.BackColor   = RGB(192, 192, 192)
1134:         ENDWITH
1135:         BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "OrdenarEstoquePorEmpresa")
1136:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "OrdenarEstoquePorMovimentacao")
1137:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "OrdenarEstoquePorNumero")
1138:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "OrdenarEstoquePorGrupo")
1139:         BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "OrdenarEstoquePorConta")
1140: 
1141:         *-- Shape1 (legado) - decorativo, BackStyle=0/BorderStyle=0 no dump
1142:         *-- original = invisivel (nao desenha preenchimento nem borda);
1143:         *-- transcrito fielmente mesmo assim (regra: nao inventar, so copiar).
1144:         loc_oAba1.AddObject("shp_4c_Shape1", "Shape")
1145:         WITH loc_oAba1.shp_4c_Shape1
1146:             .Top         = 2
1147:             .Left        = 912
1148:             .Width       = 90
1149:             .Height      = 110
1150:             .BackStyle   = 0
1151:             .BorderStyle = 0
1152:             .BorderColor = RGB(136, 189, 188)
1153:         ENDWITH
1154: 
1155:         *-- processar -> cmd_4c_Processar (legado nao declara Width/Height/
1156:         *-- FontName - herdados de Pageframe1.Page1: FontName="Tahoma",
1157:         *-- FontBold=.T., FontSize=8, ForeColor=RGB(90,90,90),
1158:         *-- BackColor=RGB(255,255,255); 75x75 pelo padrao dos demais botoes
1159:         *-- com icone "_60" deste form (Confirmar/Cancelar/Movimento).
1160:         loc_oAba1.AddObject("cmd_4c_Processar", "CommandButton")
1161:         WITH loc_oAba1.cmd_4c_Processar
1162:             .Caption         = "Processar"
1163:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1164:             .PicturePosition = 13
1165:             .Top             = 5
1166:             .Left            = 962
1167:             .Width           = 75
1168:             .Height          = 75
1169:             .FontName        = "Tahoma"
1170:             .FontSize        = 8
1171:             .FontBold        = .T.
1172:             .ForeColor       = RGB(90, 90, 90)
1173:             .BackColor       = RGB(255, 255, 255)
1174:             .Themes          = .F.
1175:             .SpecialEffect   = 0
1176:             .MousePointer    = 15
1177:             .WordWrap        = .T.
1178:             .AutoSize        = .F.
1179:         ENDWITH
1180:         BINDEVENT(loc_oAba1.cmd_4c_Processar, "Click", THIS, "ProcessarArquivoXmlClick")
1181: 
1182:         *-- btnCadastros -> cmd_4c_BtnCadastros (legado: FontName/ForeColor
1183:         *-- herdados de Pageframe1.Page1 - Tahoma, ForeColor RGB(90,90,90))
1184:         loc_oAba1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
1185:         WITH loc_oAba1.cmd_4c_BtnCadastros
1186:             .Caption       = ""
1187:             .Picture       = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
1188:             .Top           = 70
1189:             .Left          = 708
1190:             .Width         = 40
1191:             .Height        = 40
1192:             .FontName      = "Tahoma"
1193:             .FontSize      = 7
1194:             .ForeColor     = RGB(90, 90, 90)
1195:             .BackColor     = RGB(255, 255, 255)
1196:             .Themes        = .F.
1197:             .SpecialEffect = 0
1198:             .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
1199:         ENDWITH
1200:         BINDEVENT(loc_oAba1.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosContaClick")
1201: 
1202:         *-- Bot_Consulta -> cmd_4c_Bot_Consulta (todas as props explicitas no dump)
1203:         loc_oAba1.AddObject("cmd_4c_Bot_Consulta", "CommandButton")
1204:         WITH loc_oAba1.cmd_4c_Bot_Consulta
1205:             .Caption       = ""
1206:             .Picture       = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
1207:             .Top           = 70
1208:             .Left          = 667
1209:             .Width         = 40
1210:             .Height        = 40
1211:             .FontName      = "Small Fonts"
1212:             .FontSize      = 4
1213:             .ForeColor     = RGB(90, 90, 90)
1214:             .BackColor     = RGB(255, 255, 255)
1215:             .Themes        = .F.
1216:             .SpecialEffect = 0
1217:             .ToolTipText   = "<F5> Faz a Consulta Gen" + CHR(233) + "rica de Vendas desta Conta..."
1218:         ENDWITH
1219:         BINDEVENT(loc_oAba1.cmd_4c_Bot_Consulta, "Click", THIS, "BtnConsultaVendasClick")
1220: 
1221:         *-- Command12 -> cmd_4c_Command12 (botao "..." - abre o seletor de
1222:         *-- arquivo XML; sem Picture no legado, so texto)
1223:         loc_oAba1.AddObject("cmd_4c_Command12", "CommandButton")
1224:         WITH loc_oAba1.cmd_4c_Command12
1225:             .Caption   = "..."
1226:             .Top       = 157
1227:             .Left      = 667
1228:             .Width     = 20
1229:             .Height    = 20
1230:             .FontName  = "Tahoma"
1231:             .FontSize  = 8
1232:             .FontBold  = .T.
1233:             .ForeColor = RGB(90, 90, 90)
1234:             .BackColor = RGB(255, 255, 255)
1235:             .Themes    = .F.
1236:         ENDWITH
1237:         BINDEVENT(loc_oAba1.cmd_4c_Command12, "Click", THIS, "SelecionarArquivoXmlClick")
1238: 
1239:         *-- cmdOperacao -> obj_4c_CmdOperacao (CommandGroup com 1 botao -
1240:         *-- "Movimento"; legado usa PROCEDURE btnOperacao.Valid, mas o unico
1241:         *-- disparo real e o clique - migrado para Click do proprio botao)
1242:         loc_oAba1.AddObject("obj_4c_CmdOperacao", "CommandGroup")
1243:         WITH loc_oAba1.obj_4c_CmdOperacao
1244:             .ButtonCount = 1
1245:             .AutoSize    = .T.
1246:             .Top         = 334
1247:             .Left        = 857
1248:             .Width       = 85
1249:             .Height      = 85
1250:             .BackStyle   = 0
1251:             .BorderStyle = 0
1252:             .Value       = 1
1253:         ENDWITH
1254:         WITH loc_oAba1.obj_4c_CmdOperacao.Buttons(1)
1255:             .Top             = 5
1256:             .Left            = 5
1257:             .Width           = 75
1258:             .Height          = 75
1259:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1260:             .PicturePosition = 13
1261:             .Caption         = "Movimento"
1262:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
1263:             .FontName        = "Comic Sans MS"
1264:             .FontSize        = 8
1265:             .FontBold        = .T.
1266:             .FontItalic      = .T.
1267:             .ForeColor       = RGB(90, 90, 90)
1268:             .BackColor       = RGB(255, 255, 255)
1269:             .Themes          = .F.
1270:         ENDWITH
1271:         BINDEVENT(loc_oAba1.obj_4c_CmdOperacao.Buttons(1), "Click", THIS, "AbrirMovimentoSelecionado")
1272: 
1273:         *-- ===================================================================
1274:         *-- Aba Movimentacoes (legado: Pagina.Dados.Pageframe1.Page2) - campos
1275:         *-- de exibicao do produto selecionado na grade de distribuicao
1276:         *-- (grdDisponivel/grdItemXml - grids entram em fase posterior).
1277:         *-- Coordenadas ORIGINAIS do SCX (Pageframe1 tem Tabs=.T., sem a
1278:         *-- compensacao +29 do pgf_4c_Paginas externo).
1279:         *-- ===================================================================
1280:         loc_oAba2 = loc_oPagina.pgf_4c_Detalhes.Page2
1281: 
1282:         *-- lbl_produto "Procurar Produto :"
1283:         loc_oAba2.AddObject("lbl_4c_ProcurarProduto", "Label")
1284:         WITH loc_oAba2.lbl_4c_ProcurarProduto
1285:             .Caption   = "Procurar Produto :"
1286:             .Top       = 74
1287:             .Left      = 8
1288:             .Width     = 91
1289:             .Height    = 15
1290:             .Alignment = 0
1291:             .AutoSize  = .F.
1292:             .BackStyle = 0
1293:             .FontName  = "Tahoma"
1294:             .FontSize  = 8
1295:             .ForeColor = RGB(90, 90, 90)
1296:         ENDWITH
1297: 
1298:         *-- get_produto_inicial -> txt_4c_ProdutoInicial (busca na grade
1299:         *-- crMovimentos/grd_4c_Disponivel - entra em fase posterior)
1300:         loc_oAba2.AddObject("txt_4c_ProdutoInicial", "TextBox")
1301:         WITH loc_oAba2.txt_4c_ProdutoInicial
1302:             .Top           = 90
1303:             .Left          = 8
1304:             .Width         = 108
1305:             .Height        = 21
1306:             .FontName      = "Tahoma"
1307:             .FontSize      = 8
1308:             .Format        = "K!"
1309:             .MaxLength     = 14
1310:             .SpecialEffect = 1
1311:             .ForeColor     = RGB(0, 0, 0)
1312:             .Value         = ""
1313:         ENDWITH
1314:         BINDEVENT(loc_oAba2.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProcurarProdutoNaGrade")
1315: 
1316:         *-- Sistema - barra de titulo acima da grd_4c_Disponivel (fase posterior)
1317:         loc_oAba2.AddObject("txt_4c_Sistema", "TextBox")
1318:         WITH loc_oAba2.txt_4c_Sistema
1319:             .Top       = 113
1320:             .Left      = 8
1321:             .Width     = 684
1322:             .Height    = 20
1323:             .Alignment = 2
1324:             .FontName  = "Tahoma"
1325:             .FontSize  = 8
1326:             .FontBold  = .T.
1327:             .BackColor = RGB(128, 255, 255)
1328:             .ForeColor = RGB(0, 0, 0)
1329:             .ReadOnly  = .T.
1330:             .Value     = "Sistema"
1331:         ENDWITH
1332: 
1333:         *-- Arquivo - barra de titulo acima da grd_4c_ItemXml (fase posterior)
1334:         loc_oAba2.AddObject("txt_4c_ArquivoHeader", "TextBox")
1335:         WITH loc_oAba2.txt_4c_ArquivoHeader
1336:             .Top       = 113
1337:             .Left      = 691
1338:             .Width     = 495
1339:             .Height    = 20
1340:             .Alignment = 2
1341:             .FontName  = "Tahoma"
1342:             .FontSize  = 8
1343:             .FontBold  = .T.
1344:             .BackColor = RGB(255, 255, 128)
1345:             .ForeColor = RGB(0, 0, 0)
1346:             .ReadOnly  = .T.
1347:             .Value     = "Arquivo"
1348:         ENDWITH
1349: 
1350:         *-- Say3 "Movimentacao :"
1351:         loc_oAba2.AddObject("lbl_4c_MovimentacaoDetalhe", "Label")
1352:         WITH loc_oAba2.lbl_4c_MovimentacaoDetalhe
1353:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
1354:             .Top       = 483

*-- Linhas 1649 a 1706:
1649: 
1650:         THIS.ConfigurarPgPage2()
1651: 
1652:         THIS.TornarControlesVisiveis(loc_oPagina)
1653:     ENDPROC
1654: 
1655:     *===========================================================================
1656:     * ConfigurarPgPage2 - Restante da aba Movimentacoes (legado: Pagina.Dados.
1657:     * Pageframe1.Page2) - Shape5 (moldura decorativa da foto), os grids
1658:     * grd_4c_Disponivel/grd_4c_ItemXml (legado: grdDisponivel/grdItemXml),
1659:     * img_4c_FigJpg (foto do produto) e os botoes de exclusao de linha
1660:     * (btnExcluirSis/btnExcluirArq). Os demais controles desta aba (labels e
1661:     * TextBox de exibicao) ja foram criados em ConfigurarPaginaDados.
1662:     * ControlSource dos grids NAO e atribuido aqui - crMovimentos/crDistribui
1663:     * ainda nao existem neste ponto do Init (regra #41); e feito em
1664:     * ExecutarProcessamentoXml, quando os cursores ja foram criados.
1665:     *===========================================================================
1666:     PROTECTED PROCEDURE ConfigurarPgPage2()
1667:         LOCAL loc_oAba2, loc_oGrid
1668:         loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
1669: 
1670:         *-- Shape5 - moldura ao redor da foto do produto (FigJpg)
1671:         loc_oAba2.AddObject("shp_4c_Shape5", "Shape")
1672:         WITH loc_oAba2.shp_4c_Shape5
1673:             .Top         = 1
1674:             .Left        = 424
1675:             .Width       = 282
1676:             .Height      = 113
1677:             .BackStyle   = 0
1678:             .BorderStyle = 1
1679:             .BorderWidth = 2
1680:             .SpecialEffect = 0
1681:         ENDWITH
1682: 
1683:         *-- grdDisponivel -> grd_4c_Disponivel (movimentos disponiveis para
1684:         *-- distribuicao - crMovimentos, populado em ExecutarProcessamentoXml)
1685:         loc_oAba2.AddObject("grd_4c_Disponivel", "Grid")
1686:         loc_oGrid = loc_oAba2.grd_4c_Disponivel
1687:         loc_oGrid.Top                = 134
1688:         loc_oGrid.Left               = 8
1689:         loc_oGrid.Width              = 684
1690:         loc_oGrid.Height             = 344
1691:         loc_oGrid.ColumnCount        = 7
1692:         loc_oGrid.FontName           = "Tahoma"
1693:         loc_oGrid.FontSize           = 8
1694:         loc_oGrid.ReadOnly           = .T.
1695:         loc_oGrid.RecordMark         = .F.
1696:         loc_oGrid.RowHeight          = 17
1697:         loc_oGrid.BackColor          = RGB(237, 242, 243)
1698:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
1699:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
1700:         loc_oGrid.HighlightStyle     = 2
1701:         WITH loc_oGrid
1702:             .Column1.Width             = 100
1703:             .Column1.Movable           = .F.
1704:             .Column1.Resizable         = .F.
1705:             .Column1.ReadOnly          = .T.
1706:             .Column1.ForeColor         = RGB(0, 0, 255)

*-- Linhas 1776 a 1820:
1776:             .Column7.Header1.Caption   = "Saldo"
1777:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1778:         ENDWITH
1779:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "AtualizarDetalhesProdutoSelecionado")
1780:         BINDEVENT(loc_oGrid.Column1.Text1, "DblClick", THIS, "AbrirPesquisaGlobalProduto")
1781: 
1782:         *-- grdItemXml -> grd_4c_ItemXml (produtos distribuidos - crDistribui,
1783:         *-- populado em ExecutarProcessamentoXml). Column3 (Quantidade) e a
1784:         *-- UNICA editavel - o legado nao marca ReadOnly/Enabled nela.
1785:         loc_oAba2.AddObject("grd_4c_ItemXml", "Grid")
1786:         loc_oGrid = loc_oAba2.grd_4c_ItemXml
1787:         loc_oGrid.Top           = 134
1788:         loc_oGrid.Left          = 693
1789:         loc_oGrid.Width         = 493
1790:         loc_oGrid.Height        = 344
1791:         loc_oGrid.ColumnCount   = 4
1792:         loc_oGrid.FontName      = "Tahoma"
1793:         loc_oGrid.FontSize      = 8
1794:         loc_oGrid.RecordMark    = .F.
1795:         loc_oGrid.RowHeight     = 17
1796:         loc_oGrid.BackColor     = RGB(237, 242, 243)
1797:         loc_oGrid.GridLineColor = RGB(238, 238, 238)
1798:         WITH loc_oGrid
1799:             .Column1.Enabled           = .F.
1800:             .Column1.Width             = 100
1801:             .Column1.Movable           = .F.
1802:             .Column1.Resizable         = .F.
1803:             .Column1.ReadOnly          = .T.
1804:             .Column1.ForeColor         = RGB(0, 0, 0)
1805:             .Column1.BackColor         = RGB(237, 242, 243)
1806:             .Column1.Header1.Alignment = 2
1807:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
1808:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1809: 
1810:             .Column2.Enabled           = .F.
1811:             .Column2.Width             = 235
1812:             .Column2.Movable           = .F.
1813:             .Column2.Resizable         = .F.
1814:             .Column2.ReadOnly          = .T.
1815:             .Column2.ForeColor         = RGB(0, 0, 0)
1816:             .Column2.BackColor         = RGB(237, 242, 243)
1817:             .Column2.Header1.Alignment = 2
1818:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1819:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1820: 

*-- Linhas 1850 a 2345:
1850:             .Stretch   = 1
1851:             .Visible   = .F.
1852:         ENDWITH
1853:         BINDEVENT(loc_oAba2.img_4c_FigJpg, "DblClick", THIS, "FigJpgDblClick")
1854: 
1855:         *-- btnExcluirSis -> cmd_4c_BtnExcluirSis (exclui linha de crMovimentos)
1856:         loc_oAba2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
1857:         WITH loc_oAba2.cmd_4c_BtnExcluirSis
1858:             .Caption     = ""
1859:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1860:             .Top         = 479
1861:             .Left        = 663
1862:             .Width       = 40
1863:             .Height      = 37
1864:             .FontName    = "Arial"
1865:             .FontSize    = 7
1866:             .ForeColor   = RGB(255, 0, 0)
1867:             .BackColor   = RGB(255, 255, 255)
1868:             .Themes      = .F.
1869:             .TabStop     = .F.
1870:             .ToolTipText = "Excluir Linha da Grade Sistema"
1871:         ENDWITH
1872:         BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")
1873: 
1874:         *-- btnExcluirArq -> cmd_4c_BtnExcluirArq (exclui linha de crDistribui)
1875:         loc_oAba2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
1876:         WITH loc_oAba2.cmd_4c_BtnExcluirArq
1877:             .Caption     = ""
1878:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1879:             .Top         = 479
1880:             .Left        = 1146
1881:             .Width       = 40
1882:             .Height      = 37
1883:             .FontName    = "Arial"
1884:             .FontSize    = 7
1885:             .ForeColor   = RGB(255, 0, 0)
1886:             .BackColor   = RGB(255, 255, 255)
1887:             .Themes      = .F.
1888:             .TabStop     = .F.
1889:             .ToolTipText = "Excluir Linha da Grade Arquivo"
1890:         ENDWITH
1891:         BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")
1892:     ENDPROC
1893: 
1894:     *===========================================================================
1895:     * MontaGrade - Popula grd_4c_Estoque com os movimentos distribuiveis
1896:     * (legado: PROCEDURE montagrade). Chamada ao final das validacoes de
1897:     * Conta/Grupo/Cpf (ThisForm.Montagrade(.T.)) para filtrar pela conta do
1898:     * fornecedor digitado.
1899:     *===========================================================================
1900:     PROCEDURE MontaGrade(par_lFiltra)
1901:         LOCAL loc_oGrid, loc_cConta, loc_cSQL, loc_nResultado, loc_lResultado
1902:         loc_lResultado = .F.
1903: 
1904:         TRY
1905:             loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
1906:             loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.txt_4c_Conta.Value)
1907: 
1908:             loc_oGrid.RecordSource = ""
1909: 
1910:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
1911:                 SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes,
1912:                     a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas
1913:                 FROM SigMvCab a
1914:                 JOIN SigCdOpe b ON a.dopes = b.dopes
1915:                 JOIN SigOpCdd c ON b.dopes = c.dopes
1916:                 WHERE c.Distribui = 3
1917:                     AND a.chksubn = 0
1918:                     AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)
1919:                     <<IIF(par_lFiltra AND !EMPTY(loc_cConta), " AND a.ContaOs = " + EscaparSQL(loc_cConta), "")>>
1920:             ENDTEXT
1921: 
1922:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")
1923: 
1924:             IF loc_nResultado >= 0
1925:                 loc_oGrid.ColumnCount            = 5
1926:                 loc_oGrid.RecordSource           = "cursor_4c_Estoque"
1927:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_Estoque.Emps"
1928:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Estoque.Dopes"
1929:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Estoque.Numes"
1930:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Estoque.Grupos"
1931:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Estoque.Contas"
1932: 
1933:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1934:                 loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1935:                 loc_oGrid.Column3.Header1.Caption = "Numero"
1936:                 loc_oGrid.Column4.Header1.Caption = "Grupo"
1937:                 loc_oGrid.Column5.Header1.Caption = "Conta"
1938: 
1939:                 loc_oGrid.Column1.Width = 70
1940:                 loc_oGrid.Column2.Width = 200
1941:                 loc_oGrid.Column3.Width = 80
1942:                 loc_oGrid.Column4.Width = 80
1943:                 loc_oGrid.Column5.Width = 80
1944: 
1945:                 IF USED("cursor_4c_Estoque")
1946:                     GO TOP IN cursor_4c_Estoque
1947:                 ENDIF
1948:                 loc_oGrid.Refresh()
1949:                 loc_lResultado = .T.
1950:             ELSE
1951:                 MsgErro("Erro ao montar grade de estoque:" + CHR(13) + CapturarErroSQL(), "MontaGrade")
1952:             ENDIF
1953:         CATCH TO loException
1954:             MostrarErro(loException, "FormSigPrCtr.MontaGrade")
1955:         ENDTRY
1956: 
1957:         RETURN loc_lResultado
1958:     ENDPROC
1959: 
1960:     *===========================================================================
1961:     * OrdenarEstoquePorEmpresa/Movimentacao/Numero/Grupo/Conta - Header1.Click
1962:     * das colunas do grd_4c_Estoque (legado: grdEstoque.ColumnN.Header1.Click)
1963:     *===========================================================================
1964:     PROCEDURE OrdenarEstoquePorCampo(par_cCampo, par_nColuna)
1965:         LOCAL loc_oGrid, loc_nI
1966:         TRY
1967:             IF USED("cursor_4c_Estoque")
1968:                 SELECT cursor_4c_Estoque
1969:                 INDEX ON &par_cCampo TAG (par_cCampo)
1970:             ENDIF
1971: 
1972:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
1973:             FOR loc_nI = 1 TO loc_oGrid.ColumnCount
1974:                 loc_oGrid.Columns(loc_nI).Header1.BackColor = IIF(loc_nI = par_nColuna, ;
1975:                     RGB(251, 253, 176), RGB(192, 192, 192))
1976:             ENDFOR
1977:             loc_oGrid.Refresh()
1978:         CATCH TO loException
1979:             MostrarErro(loException, "FormSigPrCtr.OrdenarEstoquePorCampo")
1980:         ENDTRY
1981:     ENDPROC
1982: 
1983:     PROCEDURE OrdenarEstoquePorEmpresa()
1984:         THIS.OrdenarEstoquePorCampo("Emps", 1)
1985:     ENDPROC
1986: 
1987:     PROCEDURE OrdenarEstoquePorMovimentacao()
1988:         THIS.OrdenarEstoquePorCampo("Dopes", 2)
1989:     ENDPROC
1990: 
1991:     PROCEDURE OrdenarEstoquePorNumero()
1992:         THIS.OrdenarEstoquePorCampo("Numes", 3)
1993:     ENDPROC
1994: 
1995:     PROCEDURE OrdenarEstoquePorGrupo()
1996:         THIS.OrdenarEstoquePorCampo("Grupos", 4)
1997:     ENDPROC
1998: 
1999:     PROCEDURE OrdenarEstoquePorConta()
2000:         THIS.OrdenarEstoquePorCampo("Contas", 5)
2001:     ENDPROC
2002: 
2003:     *===========================================================================
2004:     * SelecionarArquivoXmlClick - Click de cmd_4c_Command12 (legado: Command12.
2005:     * Click) - abre o seletor de arquivo nativo do Windows e grava o caminho
2006:     * escolhido em txt_4c_Arquivo.
2007:     *===========================================================================
2008:     PROCEDURE SelecionarArquivoXmlClick()
2009:         LOCAL loc_oPagina, loc_cArquivo
2010:         TRY
2011:             loc_oPagina  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2012:             loc_cArquivo = GETFILE("XML")
2013: 
2014:             IF !EMPTY(loc_cArquivo)
2015:                 loc_oPagina.txt_4c_Arquivo.Value = loc_cArquivo
2016:             ENDIF
2017:         CATCH TO loException
2018:             MostrarErro(loException, "FormSigPrCtr.SelecionarArquivoXmlClick")
2019:         ENDTRY
2020:     ENDPROC
2021: 
2022:     *===========================================================================
2023:     * BtnCadastrosContaClick - Click de cmd_4c_BtnCadastros (legado:
2024:     * btnCadastros.Click) - abre o Cadastro de Contas (SIGCDCTA -> FormCTA) da
2025:     * conta digitada. Show() FORA do TRY (CLAUDE.md #29 - FormCTA e modal).
2026:     *===========================================================================
2027:     PROCEDURE BtnCadastrosContaClick()
2028:         LOCAL loc_oPagina, loc_oForm, loc_oErro
2029:         loc_oForm = .NULL.
2030: 
2031:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2032: 
2033:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2034:             MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta!!!", "Dados Incompletos")
2035:             loc_oPagina.txt_4c_Conta.SetFocus()
2036:         ELSE
2037:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
2038:                 TRY
2039:                     loc_oForm = CREATEOBJECT("FormCTA")
2040:                 CATCH TO loc_oErro
2041:                     MsgErro("Erro ao abrir o Cadastro de Contas:" + CHR(13) + loc_oErro.Message, "Cadastro de Contas")
2042:                     loc_oForm = .NULL.
2043:                 ENDTRY
2044: 
2045:                 IF VARTYPE(loc_oForm) = "O"
2046:                     loc_oForm.Show()
2047:                 ENDIF
2048:             ENDIF
2049:         ENDIF
2050:     ENDPROC
2051: 
2052:     *===========================================================================
2053:     * BtnConsultaVendasClick - Click de cmd_4c_Bot_Consulta (legado:
2054:     * Bot_Consulta.Click) - abriria a Consulta Generica de Vendas (SigOpCgv)
2055:     * da conta digitada. SigOpCgv NAO foi migrada (nao existe FormSigOpCgv no
2056:     * acervo) - degrada graciosamente com aviso, mesmo padrao ja usado em
2057:     * FormSigMvSbn para SigOpZom/SigRePhi. Show() FORA do TRY (CLAUDE.md #29).
2058:     *===========================================================================
2059:     PROCEDURE BtnConsultaVendasClick()
2060:         LOCAL loc_oPagina, loc_oForm, loc_oErro
2061: 
2062:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2063: 
2064:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2065:             MsgAviso(CHR(201) + " necess" + CHR(225) + "rio o preenchimento da Conta...", "Aviso")
2066:             loc_oPagina.txt_4c_Conta.SetFocus()
2067:             RETURN
2068:         ENDIF
2069: 
2070:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2071:             RETURN
2072:         ENDIF
2073: 
2074:         loc_oForm = .NULL.
2075:         TRY
2076:             loc_oForm = CREATEOBJECT("FormSigOpCgv", THIS, ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2077:         CATCH TO loc_oErro
2078:             loc_oForm = .NULL.
2079:         ENDTRY
2080: 
2081:         IF VARTYPE(loc_oForm) = "O"
2082:             loc_oForm.Show()
2083:         ELSE
2084:             MsgAviso("M" + CHR(243) + "dulo de Consulta Gen" + CHR(233) + "rica de Vendas (SigOpCgv) ainda n" + CHR(227) + ;
2085:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
2086:         ENDIF
2087:     ENDPROC
2088: 
2089:     *===========================================================================
2090:     * AbrirMovimentoSelecionado - Click do botao "Movimento" de
2091:     * obj_4c_CmdOperacao (legado: cmdOperacao.btnOperacao.Valid - o unico
2092:     * disparo real e o clique) - abre a movimentacao da linha atual de
2093:     * grd_4c_Estoque (Expedicao/SigCdOpe ou Producao/SigCdOpd). Show() FORA
2094:     * do TRY (CLAUDE.md #29 - FormSigMvExp/FormSigMvPdt sao modais).
2095:     *===========================================================================
2096:     PROCEDURE AbrirMovimentoSelecionado()
2097:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_nResultado, loc_cClasseForm, ;
2098:             loc_oForm, loc_oErro
2099:         loc_cClasseForm = ""
2100: 
2101:         TRY
2102:             IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque") ;
2103:                     OR EMPTY(ALLTRIM(NVL(cursor_4c_Estoque.Emps, ""))) ;
2104:                     OR EMPTY(ALLTRIM(NVL(cursor_4c_Estoque.Dopes, "")))
2105:                 MsgAviso("Selecione Um Registro Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
2106:             ELSE
2107:                 loc_cEmps  = ALLTRIM(cursor_4c_Estoque.Emps)
2108:                 loc_cDopes = ALLTRIM(cursor_4c_Estoque.Dopes)
2109:                 loc_nNumes = cursor_4c_Estoque.Numes
2110: 
2111:                 IF USED("cursor_4c_TmpOpe")
2112:                     USE IN cursor_4c_TmpOpe
2113:                 ENDIF
2114:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2115:                     "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpe")
2116: 
2117:                 IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2118:                     loc_cClasseForm = "FormSigMvExp"
2119:                 ELSE
2120:                     IF USED("cursor_4c_TmpOpd")
2121:                         USE IN cursor_4c_TmpOpd
2122:                     ENDIF
2123:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2124:                         "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpd")
2125: 
2126:                     IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpd") AND RECCOUNT("cursor_4c_TmpOpd") > 0
2127:                         loc_cClasseForm = "FormSigMvPdt"
2128:                     ENDIF
2129:                 ENDIF
2130: 
2131:                 IF USED("cursor_4c_TmpOpe")
2132:                     USE IN cursor_4c_TmpOpe
2133:                 ENDIF
2134:                 IF USED("cursor_4c_TmpOpd")
2135:                     USE IN cursor_4c_TmpOpd
2136:                 ENDIF
2137:             ENDIF
2138:         CATCH TO loException
2139:             MostrarErro(loException, "FormSigPrCtr.AbrirMovimentoSelecionado")
2140:         ENDTRY
2141: 
2142:         IF !EMPTY(loc_cClasseForm)
2143:             loc_oForm = .NULL.
2144:             TRY
2145:                 loc_oForm = CREATEOBJECT(loc_cClasseForm, loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.)
2146:             CATCH TO loc_oErro
2147:                 MsgErro("Erro ao abrir movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
2148:                     "Movimenta" + CHR(231) + CHR(227) + "o")
2149:                 loc_oForm = .NULL.
2150:             ENDTRY
2151: 
2152:             IF VARTYPE(loc_oForm) = "O"
2153:                 loc_oForm.Show()
2154:             ENDIF
2155:         ENDIF
2156:     ENDPROC
2157: 
2158:     *===========================================================================
2159:     * CriarCursoresXml - Cursores de trabalho do import de XML (legado: Load
2160:     * do SCX - csPrNAOCad/crItens/crResultado). Mantidos com os nomes
2161:     * ORIGINAIS do legado (sem prefixo cursor_4c_) - mesma convencao ja usada
2162:     * neste form para crMovimentos/crDistribui (ProcurarProdutoNaGrade).
2163:     *===========================================================================
2164:     PROTECTED PROCEDURE CriarCursoresXml()
2165:         IF !USED("csPrNAOCad")
2166:             CREATE CURSOR csPrNAOCad (Referencia C(25), Unidade C(3), Qtds N(12,2), Pesos N(12,2), Valor N(12,2))
2167:         ENDIF
2168: 
2169:         IF !USED("crItens")
2170:             CREATE CURSOR crItens (codigo C(15), Descr C(30), quant C(15), valor_uni C(15), valor_tot C(15), ;
2171:                 base_icm C(15), valor_icm C(15), aliq_icm C(15), base_ipi C(15), valor_ipi C(15), aliq_ipi C(15), ;
2172:                 unid C(5), cfop C(4), ncm C(8), desconto C(15), frete C(15))
2173:         ENDIF
2174: 
2175:         IF !USED("crResultado")
2176:             CREATE CURSOR crResultado (xTp C(1), cpros C(14), dpros C(60), Qtds N(12,2), Units N(12,2), Total N(12,2))
2177:         ENDIF
2178:     ENDPROC
2179: 
2180:     *===========================================================================
2181:     * CarregarArquivosXml - Confere o CPF/CNPJ do fornecedor contra a chave de
2182:     * acesso do XML e decide se prossegue com a leitura (legado: PROCEDURE
2183:     * carregaarquivos - o parametro pTipo legado so controla se Lerxml roda).
2184:     *===========================================================================
2185:     PROTECTED PROCEDURE CarregarArquivosXml(par_lProcessar)
2186:         LOCAL loc_oPagina, loc_cArquivo, loc_cCgc, loc_cConteudo, loc_cChave, ;
2187:             loc_cCgcXml, loc_lOk, loc_cMsg
2188: 
2189:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2190: 
2191:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2192:             MsgAviso("Favor Informar uma Conta.", "Aviso")
2193:             RETURN .F.
2194:         ENDIF
2195: 
2196:         loc_cArquivo = loc_oPagina.txt_4c_Arquivo.Value
2197:         loc_cCgc     = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(loc_oPagina.txt_4c_Cpf.Value, ".", ""), "/", ""), "-", ""))
2198: 
2199:         IF ALLTRIM(UPPER(RIGHT(JUSTFNAME(loc_cArquivo), 3))) != "XML"
2200:             MsgAviso("Arquivo est" + CHR(225) + " em formato diferente de XML.", "Aviso")
2201:             RETURN .F.
2202:         ENDIF
2203: 
2204:         IF !EMPTY(loc_cArquivo) AND !EMPTY(loc_cCgc)
2205:             loc_cArquivo  = ALLTRIM(loc_cArquivo)
2206:             loc_cConteudo = ALLTRIM(UPPER(FILETOSTR(loc_cArquivo)))
2207: 
2208:             IF !EMPTY(loc_cConteudo)
2209:                 loc_cChave  = ALLTRIM(STREXTRACT(loc_cConteudo, "<CHNFE>", "</CHNFE>"))
2210:                 loc_cCgcXml = SUBSTR(loc_cChave, 7, 14)
2211:                 loc_lOk     = .T.
2212: 
2213:                 IF loc_cCgcXml != loc_cCgc
2214:                     loc_lOk  = .F.
2215:                     loc_cMsg = "Fornecedor com CPF/CNPJ Diferente do XML," + CHR(13) + ;
2216:                         "Arquivo XML: " + loc_cCgcXml + CHR(13) + ;
2217:                         "Fornecedor: " + loc_cCgc + CHR(13) + ;
2218:                         "Deseja Continuar?"
2219:                     IF MsgConfirma(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
2220:                         loc_lOk = .T.
2221:                     ENDIF
2222:                 ENDIF
2223: 
2224:                 IF loc_lOk AND par_lProcessar
2225:                     THIS.LerArquivoXml(loc_cArquivo)
2226:                 ENDIF
2227:             ENDIF
2228:         ENDIF
2229: 
2230:         RETURN .T.
2231:     ENDPROC
2232: 
2233:     *===========================================================================
2234:     * LerArquivoXml - Le o XML de NF-e e popula crItens com os itens do
2235:     * documento (legado: PROCEDURE lerxml). Os demais campos do cabecalho
2236:     * (emitente/destinatario/impostos totais) sao extraidos no legado mas
2237:     * NUNCA referenciados em nenhum outro metodo do dump - leitura morta,
2238:     * omitida aqui (nao ha regra de negocio ativa a preservar).
2239:     *===========================================================================
2240:     PROTECTED PROCEDURE LerArquivoXml(par_cArquivo)
2241:         LOCAL loc_oXml, loc_oItem, loc_nQtdItens, loc_nI, loc_nContaDesconto, loc_lSucesso
2242:         loc_lSucesso = .F.
2243: 
2244:         IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
2245:             RETURN .F.
2246:         ENDIF
2247: 
2248:         THIS.CriarCursoresXml()
2249: 
2250:         TRY
2251:             loc_oXml = CREATEOBJECT("MSXML.DOMDOCUMENT")
2252: 
2253:             IF !loc_oXml.Load(par_cArquivo)
2254:                 MsgErro(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
2255:             ELSE
2256:                 IF UPPER(loc_oXml.DocumentElement.BaseName) = "NFEPROC"
2257:                     loc_nQtdItens      = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2258:                     loc_nContaDesconto = 0
2259: 
2260:                     SELECT crItens
2261:                     FOR loc_nI = 0 TO loc_nQtdItens - 1
2262:                         loc_oItem = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_nI)
2263: 
2264:                         APPEND BLANK IN crItens
2265:                         REPLACE codigo    WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/cProd").ItemText, ;
2266:                                 Descr     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/xProd").ItemText, ;
2267:                                 quant     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/qCom").ItemText, ;
2268:                                 valor_uni WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vUnCom").ItemText, ;
2269:                                 valor_tot WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vProd").ItemText, ;
2270:                                 unid      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/uCom").ItemText, ;
2271:                                 cfop      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/CFOP").ItemText, ;
2272:                                 ncm       WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/NCM").ItemText ;
2273:                                 IN crItens
2274: 
2275:                         IF loc_oItem.SelectNodes("prod/vDesc").Length > 0
2276:                             REPLACE desconto WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").ItemText IN crItens
2277:                             loc_nContaDesconto = loc_nContaDesconto + 1
2278:                         ENDIF
2279: 
2280:                         IF loc_oItem.SelectNodes("prod/vFrete").Length > 0
2281:                             REPLACE frete WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vFrete").ItemText IN crItens
2282:                         ENDIF
2283:                     ENDFOR
2284: 
2285:                     loc_lSucesso = .T.
2286:                 ELSE
2287:                     MsgAviso(par_cArquivo + " n" + CHR(227) + "o " + CHR(233) + " uma nota fiscal com autoriza" + CHR(231) + CHR(227) + "o!", "Aviso")
2288:                 ENDIF
2289:             ENDIF
2290:         CATCH TO loException
2291:             MostrarErro(loException, "FormSigPrCtr.LerArquivoXml")
2292:         ENDTRY
2293: 
2294:         RETURN loc_lSucesso
2295:     ENDPROC
2296: 
2297:     *===========================================================================
2298:     * CarregarItensXmlNaGrade - Localiza cada item de crItens em SigCdPro
2299:     * (Reffs -> Cpros -> Dpros -> Dpro2s) e acumula o resultado em
2300:     * crResultado/csPrNAOCad (legado: PROCEDURE carregaritemxml). Os blocos
2301:     * de SigCdTam/SigCdCor do legado sao INALCANCAVEIS (lcTam/lcCor sao
2302:     * zerados incondicionalmente antes do IF que os testaria) - omitidos
2303:     * aqui, nao sao regra de negocio viva.
2304:     *===========================================================================
2305:     PROTECTED PROCEDURE CarregarItensXmlNaGrade()
2306:         LOCAL loc_cProd, loc_nQtds, loc_cCunis, loc_nVal, loc_nTot, loc_nBaseIcm, ;
2307:             loc_nValorIpi, loc_cTp, loc_nVariaProd, loc_nResultado, loc_cArquivoSaida
2308: 
2309:         IF !USED("crItens")
2310:             RETURN .F.
2311:         ENDIF
2312: 
2313:         TRY
2314:             SELECT crItens
2315:             GO TOP IN crItens
2316:             SCAN
2317:                 loc_cProd  = NVL(crItens.codigo, "")
2318:                 loc_nQtds  = IIF(TYPE("crItens.quant") = "N", NVL(crItens.quant, 0), VAL(NVL(crItens.quant, "")))
2319:                 loc_cCunis = IIF(INLIST(TYPE("crItens.unid"), "C", "M"), NVL(crItens.unid, ""), "")
2320:                 loc_nVal   = IIF(INLIST(TYPE("crItens.valor_uni"), "C", "M"), VAL(NVL(crItens.valor_uni, "")), ;
2321:                     IIF(TYPE("crItens.valor_uni") = "N", NVL(crItens.valor_uni, 0), 0))
2322:                 loc_nTot   = IIF(INLIST(TYPE("crItens.valor_tot"), "C", "M"), VAL(NVL(crItens.valor_tot, "")), ;
2323:                     IIF(TYPE("crItens.valor_tot") = "N", NVL(crItens.valor_tot, 0), 0))
2324:                 loc_nBaseIcm  = IIF(INLIST(TYPE("crItens.base_icm"), "C", "M"), VAL(NVL(crItens.base_icm, "")), ;
2325:                     IIF(TYPE("crItens.base_icm") = "N", NVL(crItens.base_icm, 0), 0))
2326:                 loc_nValorIpi = IIF(INLIST(TYPE("crItens.valor_ipi"), "C", "M"), VAL(NVL(crItens.valor_ipi, "")), ;
2327:                     IIF(TYPE("crItens.valor_ipi") = "N", NVL(crItens.valor_ipi, 0), 0))
2328: 
2329:                 IF !EMPTY(loc_cProd)
2330:                     IF USED("ProdImport")
2331:                         USE IN ProdImport
2332:                     ENDIF
2333:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2334:                         "SELECT * FROM SigCdPro WHERE Reffs = " + EscaparSQL(loc_cProd), "ProdImport")
2335:                     IF loc_nResultado < 1
2336:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2337:                         LOOP
2338:                     ENDIF
2339: 
2340:                     IF RECCOUNT("ProdImport") = 0
2341:                         USE IN ProdImport
2342:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2343:                             "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cProd), "ProdImport")
2344:                         IF loc_nResultado < 1
2345:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")

*-- Linhas 2426 a 2570:
2426:             GO TOP
2427:             IF RECCOUNT("csPrNAOCad") > 0
2428:                 loc_cArquivoSaida = ADDBS(SYS(5) + SYS(2003)) + "Produtos_Nao_Localizados"
2429:                 MsgAviso("Houve produtos n" + CHR(227) + "o Localizados" + CHR(13) + CHR(13) + ;
2430:                     "Arquivo : " + loc_cArquivoSaida + ".XLS", "Aten" + CHR(231) + CHR(227) + "o")
2431:                 SELECT csPrNAOCad
2432:                 COPY TO (loc_cArquivoSaida) XL5
2433:             ENDIF
2434:         ENDIF
2435: 
2436:         IF USED("crItens")
2437:             SELECT crItens
2438:             GO TOP
2439:         ENDIF
2440: 
2441:         RETURN .T.
2442:     ENDPROC
2443: 
2444:     *===========================================================================
2445:     * ProcessarArquivoXmlClick - Click de cmd_4c_Processar (legado: processar.
2446:     * Click) - valida Arquivo/Conta/Cpf preenchidos e delega o processamento.
2447:     *===========================================================================
2448:     PROCEDURE ProcessarArquivoXmlClick()
2449:         LOCAL loc_oPagina
2450:         TRY
2451:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2452: 
2453:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Arquivo.Value))
2454:                 MsgAviso("Nenhum Diret" + CHR(243) + "rio Foi Informado.", "Aviso")
2455:             ELSE
2456:                 IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2457:                     MsgAviso("Nenhum Fornecedor Foi Informado.", "Aviso")
2458:                 ELSE
2459:                     IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cpf.Value))
2460:                         MsgAviso("CNPJ/CPF do Fornecedor N" + CHR(227) + "o Informado", "Aviso")
2461:                     ELSE
2462:                         THIS.ExecutarProcessamentoXml(loc_oPagina)
2463:                     ENDIF
2464:                 ENDIF
2465:             ENDIF
2466:         CATCH TO loException
2467:             MostrarErro(loException, "FormSigPrCtr.ProcessarArquivoXmlClick")
2468:         ENDTRY
2469:     ENDPROC
2470: 
2471:     *===========================================================================
2472:     * ExecutarProcessamentoXml - Orquestra o import do XML (legado: processar.
2473:     * Click, corpo principal): busca os movimentos distribuiveis da linha
2474:     * ATUAL de grd_4c_Estoque (legado nao faz SCAN - o bloco que somaria
2475:     * todas as linhas marcadas esta comentado no dump original, morto), le o
2476:     * XML/monta crResultado, agrupa em crDistribui, filtra crMovimentos por
2477:     * Opt_Filtro e converte a moeda de cada linha para a moeda base
2478:     * (SigCdPam.moedetqs) antes de exibir nos grids da aba Movimentacoes
2479:     * (grd_4c_Disponivel/grd_4c_ItemXml - concluidos na fase que fecha
2480:     * aquela aba).
2481:     *===========================================================================
2482:     PROTECTED PROCEDURE ExecutarProcessamentoXml(par_oPagina)
2483:         LOCAL loc_oAba2, loc_oGridDisp, loc_oGridItem, loc_nTipo, loc_cOriDopNums, ;
2484:             loc_cMoedaBase, loc_nCotaMoe, loc_cSQL, loc_nResultado, loc_nCotacao, loc_nUnits
2485: 
2486:         TRY
2487:             loc_oAba2     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2488:             loc_oGridDisp = loc_oAba2.grd_4c_Disponivel
2489:             loc_oGridItem = loc_oAba2.grd_4c_ItemXml
2490: 
2491:             loc_nTipo = par_oPagina.opt_4c_Filtro.Value
2492: 
2493:             loc_oGridDisp.RecordSource = ""
2494:             loc_oGridItem.RecordSource = ""
2495: 
2496:             IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque")
2497:                 loc_cOriDopNums = ""
2498:             ELSE
2499:                 loc_cOriDopNums = cursor_4c_Estoque.OriDopNums
2500:             ENDIF
2501: 
2502:             loc_cMoedaBase = IIF(USED("crSigCdPam"), ALLTRIM(NVL(crSigCdPam.moedetqs, "")), "")
2503:             loc_nCotaMoe   = THIS.this_oBusinessObject.CarregarCambio(loc_cMoedaBase, DATE())
2504: 
2505:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
2506:                 SELECT a.Cpros, f.Dpros, a.units,
2507:                     SUM(a.qtds) AS qtds, SUM(a.qtbaixas) AS qtbaixas, SUM(a.qtreservas) AS qtreservas,
2508:                     (SUM(a.qtds) - SUM(a.qtbaixas) - SUM(a.qtreservas)) AS Saldo,
2509:                     a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus, a.cidchaves, a.Moedas
2510:                 FROM SigMvItn a
2511:                 JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums
2512:                 JOIN SigCdOpe d ON c.dopes = d.dopes
2513:                 JOIN SigOpCdd e ON d.dopes = e.dopes
2514:                 JOIN SigCdPro f ON a.Cpros = f.Cpros
2515:                 WHERE e.Distribui = 3
2516:                     AND c.GrupoOs <> SPACE(10)
2517:                     AND c.ContaOs <> SPACE(10)
2518:                     AND a.citem2 = 0
2519:                     AND a.qtds <> a.qtbaixas
2520:                     AND a.EmpDopNums IN (<<EscaparSQL(loc_cOriDopNums)>>)
2521:                 GROUP BY a.CPros, f.Dpros, f.Cgrus, f.Sgrus, a.EmpDopNums, a.units, a.cidchaves, a.Moedas
2522:             ENDTEXT
2523: 
2524:             IF USED("crMovimentos")
2525:                 USE IN crMovimentos
2526:             ENDIF
2527:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMovimentos")
2528: 
2529:             IF loc_nResultado < 1
2530:                 MsgAviso("Problemas no Select dos Produtos da Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2531:             ELSE
2532:                 SELECT crMovimentos
2533:                 INDEX ON Cgrus TAG Cgrus
2534:                 INDEX ON Cpros TAG Cpros
2535:                 SET ORDER TO Cpros
2536:                 GO TOP
2537: 
2538:                 THIS.CriarCursoresXml()
2539:                 SELECT crItens
2540:                 ZAP
2541:                 SELECT csPrNAOCad
2542:                 ZAP
2543:                 SELECT crResultado
2544:                 ZAP
2545: 
2546:                 THIS.CarregarArquivosXml(.T.)
2547:                 THIS.CarregarItensXmlNaGrade()
2548: 
2549:                 IF USED("crDistribui")
2550:                     USE IN crDistribui
2551:                 ENDIF
2552:                 SELECT Cpros, Dpros, SUM(Qtds) AS Qtds, MAX(Units) AS Units, SUM(Total) AS Total ;
2553:                     FROM crResultado ;
2554:                     GROUP BY Cpros, Dpros ;
2555:                     INTO CURSOR crDistribui READWRITE
2556: 
2557:                 SELECT crDistribui
2558:                 INDEX ON cPros TAG Tag1
2559:                 SET ORDER TO Tag1
2560: 
2561:                 loc_oGridItem.RecordSource          = "crDistribui"
2562:                 loc_oGridItem.Column1.ControlSource = "crDistribui.Cpros"
2563:                 loc_oGridItem.Column2.ControlSource = "crDistribui.Dpros"
2564:                 loc_oGridItem.Column3.ControlSource = "crDistribui.Qtds"
2565:                 loc_oGridItem.Column4.ControlSource = "crDistribui.Units"
2566: 
2567:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2568:                 *-- reaplicar OS DOIS depois do ControlSource
2569:                 loc_oGridItem.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2570:                 loc_oGridItem.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 2636 a 2788:
2636:     * validada, preenche o Cpf e (se vazio) o Grupo, e recarrega a grade de
2637:     * estoque filtrada pela conta (ThisForm.Montagrade(.T.)).
2638:     *===========================================================================
2639:     PROTECTED PROCEDURE AtualizarCpfEGrupoPorConta(par_oPagina)
2640:         LOCAL loc_cConta, loc_nResultado
2641:         TRY
2642:             IF !EMPTY(ALLTRIM(par_oPagina.txt_4c_Conta.Value))
2643:                 loc_cConta = ALLTRIM(par_oPagina.txt_4c_Conta.Value)
2644: 
2645:                 IF USED("cursor_4c_TmpCli")
2646:                     USE IN cursor_4c_TmpCli
2647:                 ENDIF
2648:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2649:                     "SELECT Cpfs, Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
2650:                     "cursor_4c_TmpCli")
2651: 
2652:                 IF loc_nResultado >= 0 AND USED("cursor_4c_TmpCli") AND !EOF("cursor_4c_TmpCli")
2653:                     par_oPagina.txt_4c_Cpf.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Cpfs, ""))
2654:                     IF EMPTY(ALLTRIM(par_oPagina.txt_4c_Grupo.Value))
2655:                         par_oPagina.txt_4c_Grupo.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Grupos, ""))
2656:                     ENDIF
2657:                 ENDIF
2658: 
2659:                 IF USED("cursor_4c_TmpCli")
2660:                     USE IN cursor_4c_TmpCli
2661:                 ENDIF
2662: 
2663:                 THIS.MontaGrade(.T.)
2664:             ENDIF
2665:         CATCH TO loException
2666:             MostrarErro(loException, "FormSigPrCtr.AtualizarCpfEGrupoPorConta")
2667:         ENDTRY
2668:     ENDPROC
2669: 
2670:     *===========================================================================
2671:     * ValidarGrupoAcesso - LostFocus de txt_4c_Grupo (legado: Get_Grupo.Valid)
2672:     * fAcessoContab ja resolve o lookup (FormBuscaSimples) e preenche o
2673:     * proprio campo quando nao ha match exato.
2674:     *===========================================================================
2675:     PROCEDURE ValidarGrupoAcesso(par_nKeyCode, par_nShiftAltCtrl)
2676:         LOCAL loc_oPagina
2677:         TRY
2678:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2679:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_oPagina.txt_4c_Grupo.Value, ;
2680:                 loc_oPagina.txt_4c_Grupo, "", loc_oPagina.txt_4c_Conta.Value)
2681:         CATCH TO loException
2682:             MostrarErro(loException, "FormSigPrCtr.ValidarGrupoAcesso")
2683:         ENDTRY
2684:     ENDPROC
2685: 
2686:     *===========================================================================
2687:     * ValidarContaFornecedor - LostFocus de txt_4c_Conta (legado: Get_Conta.Valid)
2688:     *===========================================================================
2689:     PROCEDURE ValidarContaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
2690:         LOCAL loc_oPagina, loc_cGrupo
2691:         TRY
2692:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2693:             loc_cGrupo  = loc_oPagina.txt_4c_Grupo.Value
2694: 
2695:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2696:                 IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_oPagina.txt_4c_Conta.Value, ;
2697:                         loc_oPagina.txt_4c_Conta, loc_oPagina.txt_4c_Dconta)
2698:                     MsgErro("Acesso Negado!!!", "Aviso")
2699:                     loc_oPagina.txt_4c_Conta.Value  = ""
2700:                     loc_oPagina.txt_4c_Dconta.Value = ""
2701:                     loc_oPagina.txt_4c_Cpf.Value    = ""
2702:                 ENDIF
2703:             ELSE
2704:                 loc_oPagina.txt_4c_Dconta.Value = ""
2705:                 loc_oPagina.txt_4c_Cpf.Value    = ""
2706:             ENDIF
2707: 
2708:             THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
2709:         CATCH TO loException
2710:             MostrarErro(loException, "FormSigPrCtr.ValidarContaFornecedor")
2711:         ENDTRY
2712:     ENDPROC
2713: 
2714:     *===========================================================================
2715:     * ValidarDescricaoConta - LostFocus de txt_4c_Dconta (legado: Get_Dconta.Valid)
2716:     *===========================================================================
2717:     PROCEDURE ValidarDescricaoConta(par_nKeyCode, par_nShiftAltCtrl)
2718:         LOCAL loc_oPagina, loc_cGrupo
2719:         TRY
2720:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2721:             loc_cGrupo  = loc_oPagina.txt_4c_Grupo.Value
2722: 
2723:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Dconta.Value))
2724:                 IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_oPagina.txt_4c_Dconta.Value, ;
2725:                         loc_oPagina.txt_4c_Conta, loc_oPagina.txt_4c_Dconta, .T., loc_cGrupo)
2726:                     MsgErro("Acesso Negado!!!", "Aviso")
2727:                     loc_oPagina.txt_4c_Dconta.Value = ""
2728:                     loc_oPagina.txt_4c_Conta.Value  = ""
2729:                     loc_oPagina.txt_4c_Cpf.Value    = ""
2730:                 ENDIF
2731:             ELSE
2732:                 loc_oPagina.txt_4c_Conta.Value = ""
2733:                 loc_oPagina.txt_4c_Cpf.Value   = ""
2734:             ENDIF
2735: 
2736:             THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
2737:         CATCH TO loException
2738:             MostrarErro(loException, "FormSigPrCtr.ValidarDescricaoConta")
2739:         ENDTRY
2740:     ENDPROC
2741: 
2742:     *===========================================================================
2743:     * ValidarCpfCnpjFornecedor - LostFocus de txt_4c_Cpf (legado: Get_cpf.Valid)
2744:     * Valida o digito verificador (fValidarCPF/fValidarCNPJ), localiza o
2745:     * fornecedor por Cpfs e confere acesso via fAcessoContas antes de
2746:     * preencher Conta/Dconta.
2747:     *===========================================================================
2748:     PROCEDURE ValidarCpfCnpjFornecedor(par_nKeyCode, par_nShiftAltCtrl)
2749:         LOCAL loc_oPagina, loc_cGrupo, loc_cCgc, loc_cCgcFmt, loc_nVerCpfCgc, loc_nResultado
2750:         TRY
2751:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2752: 
2753:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cpf.Value))
2754:                 loc_cCgc = STRTRAN(STRTRAN(STRTRAN(loc_oPagina.txt_4c_Cpf.Value, ".", ""), "-", ""), "/", "")
2755:                 loc_nVerCpfCgc = 0
2756: 
2757:                 IF LEN(ALLTRIM(loc_cCgc)) != 14
2758:                     loc_cCgcFmt = TRANSFORM(loc_cCgc, "@R 999.999.999-99")
2759:                     IF LEN(ALLTRIM(loc_cCgc)) = 11
2760:                         loc_nVerCpfCgc = IIF(fValidarCPF(loc_cCgcFmt), 1, 2)
2761:                     ENDIF
2762:                 ELSE
2763:                     loc_cCgcFmt = TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99")
2764:                     loc_nVerCpfCgc = IIF(fValidarCNPJ(loc_cCgcFmt), 1, 2)
2765:                 ENDIF
2766: 
2767:                 IF loc_nVerCpfCgc = 2
2768:                     MsgErro("CPF / CGC Incorreto !!!", "Aviso")
2769:                     loc_oPagina.txt_4c_Cpf.Value = ""
2770:                 ELSE
2771:                     IF USED("cursor_4c_BuscaCli")
2772:                         USE IN cursor_4c_BuscaCli
2773:                     ENDIF
2774:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2775:                         "SELECT IClis, RClis, Cpfs, Grupos FROM SigCdCli WHERE Cpfs = " + ;
2776:                         EscaparSQL(PADR(ALLTRIM(loc_cCgcFmt), 20)), "cursor_4c_BuscaCli")
2777: 
2778:                     IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaCli") AND !EOF("cursor_4c_BuscaCli")
2779:                         loc_cGrupo = loc_oPagina.txt_4c_Grupo.Value
2780:                         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ;
2781:                                 ALLTRIM(cursor_4c_BuscaCli.IClis), loc_oPagina.txt_4c_Conta.Value, loc_oPagina.txt_4c_Dconta.Value)
2782:                             MsgErro("Acesso Negado !!", "Aviso")
2783:                             loc_oPagina.txt_4c_Conta.Value  = ""
2784:                             loc_oPagina.txt_4c_Dconta.Value = ""
2785:                             loc_oPagina.txt_4c_Cpf.Value    = ""
2786:                         ELSE
2787:                             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.IClis)
2788:                             loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)

*-- Linhas 2819 a 2936:
2819: 
2820:     *===========================================================================
2821:     * ValidarMoedaFornecedor - LostFocus de txt_4c_Moeda (legado: Get_Moeda.Valid,
2822:     * fwbuscaext -> SigCdMoe). Padrao canonico FormBuscaAuxiliar: this_lAchouRegistro
2823:     * ANTES do Show(), this_lSelecionou antes de atribuir o valor (regra #37).
2824:     *===========================================================================
2825:     PROCEDURE ValidarMoedaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
2826:         LOCAL loc_oPagina, loc_oBusca
2827:         TRY
2828:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2829: 
2830:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Moeda.Value))
2831:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2832:                     "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", ;
2833:                     ALLTRIM(loc_oPagina.txt_4c_Moeda.Value), "Sele" + CHR(231) + CHR(227) + "o")
2834: 
2835:                 IF VARTYPE(loc_oBusca) = "O"
2836:                     IF !loc_oBusca.this_lAchouRegistro
2837:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2838:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2839:                         loc_oBusca.Show()
2840:                     ENDIF
2841: 
2842:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2843:                         loc_oPagina.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2844:                     ELSE
2845:                         loc_oPagina.txt_4c_Moeda.Value = ""
2846:                     ENDIF
2847: 
2848:                     loc_oBusca.Release()
2849:                 ENDIF
2850: 
2851:                 IF USED("cursor_4c_BuscaMoeda")
2852:                     USE IN cursor_4c_BuscaMoeda
2853:                 ENDIF
2854:             ELSE
2855:                 loc_oPagina.txt_4c_Moeda.Value = ""
2856:             ENDIF
2857:         CATCH TO loException
2858:             MostrarErro(loException, "FormSigPrCtr.ValidarMoedaFornecedor")
2859:         ENDTRY
2860:     ENDPROC
2861: 
2862:     *===========================================================================
2863:     * ProcurarProdutoNaGrade - LostFocus de txt_4c_ProdutoInicial (legado:
2864:     * get_produto_inicial.Valid) - localiza o produto digitado na grade de
2865:     * movimentos disponiveis (crMovimentos/grd_4c_Disponivel - populada na
2866:     * fase que adiciona os grids da aba Movimentacoes).
2867:     *===========================================================================
2868:     PROCEDURE ProcurarProdutoNaGrade()
2869:         LOCAL loc_oAba2, loc_cProduto
2870:         TRY
2871:             loc_oAba2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2872:             loc_cProduto = ALLTRIM(loc_oAba2.txt_4c_ProdutoInicial.Value)
2873: 
2874:             IF !EMPTY(loc_cProduto) AND USED("crMovimentos")
2875:                 LOCATE FOR ALLTRIM(crMovimentos.Cpros) = loc_cProduto
2876:             ENDIF
2877:         CATCH TO loException
2878:             MostrarErro(loException, "FormSigPrCtr.ProcurarProdutoNaGrade")
2879:         ENDTRY
2880:     ENDPROC
2881: 
2882:     *===========================================================================
2883:     * AtualizarDetalhesProdutoSelecionado - AfterRowColChange de
2884:     * grd_4c_Disponivel (legado: grdDisponivel.AfterRowColChange) - busca os
2885:     * dados do produto da linha corrente em SigCdPro/SigCdGrp e atualiza os
2886:     * campos de exibicao da aba Movimentacoes + a imagem do produto. PUBLIC
2887:     * (alvo de BINDEVENT - regra #3); AfterRowColChange exige par_nColIndex.
2888:     *
2889:     * Colunas de SigCdPro lidas no legado mas NUNCA consumidas depois
2890:     * (cgrus/sgrus/CodCors - so alimentavam a consulta morta a SigCdPsg/
2891:     * Tmp_Sgru) e os LEFT JOINs com SigCdUni/SigCdCol/SigCdLin/SigPrFti/
2892:     * SigCdCli/SigCdGpr/SigCdFip (cujas colunas tambem nunca sao lidas) sao
2893:     * leitura morta - omitidas aqui, mesmo criterio ja aplicado em
2894:     * LerArquivoXml para os campos de cabecalho da NF-e nao referenciados.
2895:     *===========================================================================
2896:     PROCEDURE AtualizarDetalhesProdutoSelecionado(par_nColIndex)
2897:         LOCAL loc_oAba2, loc_cSQL, loc_nResultado, loc_cArquivoImg, loc_cFoto, ;
2898:             loc_nCotacao, loc_nCotVen, loc_nPrVenda, loc_cPrVendaMoeda, ;
2899:             loc_nFatArred, loc_nSoma
2900: 
2901:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2902:             RETURN
2903:         ENDIF
2904: 
2905:         TRY
2906:             loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2907: 
2908:             IF USED("CrTSigPro")
2909:                 USE IN CrTSigPro
2910:             ENDIF
2911: 
2912:             loc_cSQL = "SELECT a.Cpros, a.Reffs, a.Pesoms, a.Moecusfs, a.Custofs, a.Pcuss, " + ;
2913:                 "a.Pvens, a.Moevs, a.FigJpgs, g.Arreds " + ;
2914:                 "FROM SigCdPro a LEFT JOIN SigCdGrp g ON a.Cgrus = g.Cgrus " + ;
2915:                 "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(crMovimentos.Cpros))
2916: 
2917:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrTSigPro")
2918: 
2919:             IF loc_nResultado < 1 OR !USED("CrTSigPro") OR EOF("CrTSigPro")
2920:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
2921:             ELSE
2922:                 loc_oAba2.txt_4c_RefFornecedor.Value = TratarNulo(CrTSigPro.Reffs, "")
2923:                 loc_oAba2.txt_4c_PesoMedio.Value      = TratarNulo(CrTSigPro.Pesoms, 0)
2924:                 loc_oAba2.txt_4c_MoeCusFs.Value        = TratarNulo(CrTSigPro.Moecusfs, "")
2925:                 loc_oAba2.txt_4c_CustoFs.Value          = TratarNulo(CrTSigPro.Custofs, 0)
2926:                 loc_oAba2.txt_4c_PrecoMov.Value         = TratarNulo(CrTSigPro.Pcuss, 0)
2927: 
2928:                 loc_oAba2.txt_4c_MovCidChaves.Value = TratarNulo(crMovimentos.cidchaves, "")
2929:                 loc_oAba2.txt_4c_MovEmps.Value       = SUBSTR(crMovimentos.OriDopNums, 1, 3)
2930:                 loc_oAba2.txt_4c_MovDopes.Value      = SUBSTR(crMovimentos.OriDopNums, 4, 20)
2931:                 loc_oAba2.txt_4c_MovNumes.Value      = ALLTRIM(RIGHT(crMovimentos.OriDopNums, 6))
2932: 
2933:                 IF !ISNULL(CrTSigPro.FigJpgs) AND !EMPTY(CrTSigPro.FigJpgs)
2934:                     loc_cFoto = STRTRAN(CrTSigPro.FigJpgs, "data:image/png;base64,", "")
2935:                     loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
2936:                     loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")

*-- Linhas 2990 a 3480:
2990:     * desta migracao (mesmo padrao de degradacao graciosa ja usado em
2991:     * BtnConsultaVendasClick/AbrirFormZoomImagem para SigOpCgv/SigOpZom).
2992:     *===========================================================================
2993:     PROCEDURE AbrirPesquisaGlobalProduto()
2994:         LOCAL loc_cProduto, loc_oForm, loc_oErro
2995: 
2996:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2997:             RETURN
2998:         ENDIF
2999: 
3000:         loc_cProduto = ALLTRIM(crMovimentos.Cpros)
3001:         IF EMPTY(loc_cProduto)
3002:             RETURN
3003:         ENDIF
3004: 
3005:         loc_oForm = .NULL.
3006:         TRY
3007:             loc_oForm = CREATEOBJECT("FormSigOpCgp", loc_cProduto)
3008:         CATCH TO loc_oErro
3009:             loc_oForm = .NULL.
3010:         ENDTRY
3011: 
3012:         IF VARTYPE(loc_oForm) = "O"
3013:             loc_oForm.Show()
3014:         ELSE
3015:             MsgAviso("M" + CHR(243) + "dulo de Pesquisa Global de Produtos (SigOpCgp) ainda n" + CHR(227) + ;
3016:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
3017:         ENDIF
3018:     ENDPROC
3019: 
3020:     *===========================================================================
3021:     * FigJpgDblClick - DblClick de img_4c_FigJpg (legado: FigJpg.DblClick) -
3022:     * grava a foto do produto corrente (memo cru, SEM decodificar base64 -
3023:     * diferente de AtualizarDetalhesProdutoSelecionado; assim mesmo no
3024:     * legado) num JPG temporario e abriria o Zoom de Imagem (SigOpZom), form
3025:     * auxiliar fora do escopo desta migracao (mesmo padrao de degradacao
3026:     * graciosa ja usado em FormSigMvSbn.AbrirFormZoomImagem).
3027:     *===========================================================================
3028:     PROCEDURE FigJpgDblClick()
3029:         LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro, loc_cTitulo
3030: 
3031:         IF !USED("crMovimentos") OR EOF("crMovimentos")
3032:             RETURN
3033:         ENDIF
3034: 
3035:         loc_cArquivo = ""
3036:         TRY
3037:             loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".Jpg"
3038: 
3039:             IF USED("cursor_4c_FotoZoom")
3040:                 USE IN cursor_4c_FotoZoom
3041:             ENDIF
3042:             loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
3043:                 EscaparSQL(ALLTRIM(crMovimentos.Cpros))
3044:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoZoom")
3045: 
3046:             IF loc_nResultado >= 0 AND USED("cursor_4c_FotoZoom") AND !EOF("cursor_4c_FotoZoom") ;
3047:                     AND !ISNULL(cursor_4c_FotoZoom.FigJpgs) AND !EMPTY(cursor_4c_FotoZoom.FigJpgs)
3048:                 STRTOFILE(cursor_4c_FotoZoom.FigJpgs, loc_cArquivo)
3049:             ELSE
3050:                 loc_cArquivo = ""
3051:             ENDIF
3052: 
3053:             IF USED("cursor_4c_FotoZoom")
3054:                 USE IN cursor_4c_FotoZoom
3055:             ENDIF
3056:         CATCH TO loException
3057:             MostrarErro(loException, "FormSigPrCtr.FigJpgDblClick")
3058:             loc_cArquivo = ""
3059:         ENDTRY
3060: 
3061:         IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
3062:             loc_cTitulo = "Produto : " + ALLTRIM(crMovimentos.Cpros) + " - " + ALLTRIM(crMovimentos.Dpros)
3063: 
3064:             loc_oForm = .NULL.
3065:             TRY
3066:                 loc_oForm = CREATEOBJECT("FormSigOpZom", loc_cArquivo, loc_cTitulo, " ")
3067:             CATCH TO loc_oErro
3068:                 loc_oForm = .NULL.
3069:             ENDTRY
3070: 
3071:             IF VARTYPE(loc_oForm) = "O"
3072:                 loc_oForm.Show()
3073:             ELSE
3074:                 MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
3075:                     "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
3076:             ENDIF
3077: 
3078:             ERASE (loc_cArquivo)
3079:         ENDIF
3080:     ENDPROC
3081: 
3082:     *===========================================================================
3083:     * BtnExcluirSisClick - Click de cmd_4c_BtnExcluirSis (legado:
3084:     * btnExcluirSis.Click) - exclui a linha atual de crMovimentos
3085:     * (grd_4c_Disponivel).
3086:     *===========================================================================
3087:     PROCEDURE BtnExcluirSisClick()
3088:         LOCAL loc_oAba2
3089:         TRY
3090:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crMovimentos")
3091:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3092: 
3093:                 SELECT crMovimentos
3094:                 IF !EOF()
3095:                     DELETE
3096:                 ENDIF
3097:                 IF !EOF()
3098:                     SKIP
3099:                     SKIP -1
3100:                 ENDIF
3101:                 GO TOP
3102:                 loc_oAba2.grd_4c_Disponivel.SetFocus()
3103:                 loc_oAba2.grd_4c_Disponivel.Refresh()
3104:             ENDIF
3105:         CATCH TO loException
3106:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirSisClick")
3107:         ENDTRY
3108:     ENDPROC
3109: 
3110:     *===========================================================================
3111:     * BtnExcluirArqClick - Click de cmd_4c_BtnExcluirArq (legado:
3112:     * btnExcluirArq.Click) - exclui a linha atual de crDistribui
3113:     * (grd_4c_ItemXml).
3114:     *===========================================================================
3115:     PROCEDURE BtnExcluirArqClick()
3116:         LOCAL loc_oAba2
3117:         TRY
3118:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crDistribui")
3119:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3120: 
3121:                 SELECT crDistribui
3122:                 IF !EOF()
3123:                     DELETE
3124:                 ENDIF
3125:                 IF !EOF()
3126:                     SKIP
3127:                     SKIP -1
3128:                 ENDIF
3129:                 GO TOP
3130:                 loc_oAba2.grd_4c_ItemXml.SetFocus()
3131:                 loc_oAba2.grd_4c_ItemXml.Refresh()
3132:             ENDIF
3133:         CATCH TO loException
3134:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirArqClick")
3135:         ENDTRY
3136:     ENDPROC
3137: 
3138:     *===========================================================================
3139:     * FormParaBO - Transfere os campos editaveis de Page2 (aba Precificacao)
3140:     * para o Business Object. Grupo/Dconta/Cpf NAO tem coluna em SigPrCtr
3141:     * (regra ja documentada nos comentarios de ConfigurarPaginaDados) e por
3142:     * isso nao sao mapeados aqui.
3143:     *===========================================================================
3144:     PROCEDURE FormParaBO()
3145:         LOCAL loc_oPagina
3146:         TRY
3147:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3148: 
3149:             THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
3150:             THIS.this_oBusinessObject.this_cMoedas   = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
3151:             THIS.this_oBusinessObject.this_cArquivo  = ALLTRIM(loc_oPagina.txt_4c_Arquivo.Value)
3152:             THIS.this_oBusinessObject.this_nPrecific = loc_oPagina.opt_4c_Custo.Value
3153:         CATCH TO loException
3154:             MostrarErro(loException, "FormSigPrCtr.FormParaBO")
3155:         ENDTRY
3156:     ENDPROC
3157: 
3158:     *===========================================================================
3159:     * BOParaForm - Transfere o Business Object para os campos de Page2 e
3160:     * reconstitui Dconta/Cpf/Grupo + grd_4c_Estoque via o mesmo bloco usado
3161:     * apos validar a Conta digitada (AtualizarCpfEGrupoPorConta/MontaGrade).
3162:     *===========================================================================
3163:     PROCEDURE BOParaForm()
3164:         LOCAL loc_oPagina
3165:         TRY
3166:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3167: 
3168:             loc_oPagina.txt_4c_Conta.Value   = THIS.this_oBusinessObject.this_cContas
3169:             loc_oPagina.txt_4c_Moeda.Value   = THIS.this_oBusinessObject.this_cMoedas
3170:             loc_oPagina.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cArquivo
3171:             loc_oPagina.opt_4c_Custo.Value   = IIF(THIS.this_oBusinessObject.this_nPrecific = 2, 2, 1)
3172:             loc_oPagina.txt_4c_Grupo.Value   = ""
3173:             loc_oPagina.txt_4c_Cpf.Value     = ""
3174:             loc_oPagina.txt_4c_Dconta.Value  = ""
3175: 
3176:             THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
3177:         CATCH TO loException
3178:             MostrarErro(loException, "FormSigPrCtr.BOParaForm")
3179:         ENDTRY
3180:     ENDPROC
3181: 
3182:     *===========================================================================
3183:     * LimparCampos - Limpa os campos de Page2 (aba Precificacao) e a grade
3184:     * de estoque disponivel, preparando o formulario para modo INCLUIR.
3185:     *===========================================================================
3186:     PROCEDURE LimparCampos()
3187:         LOCAL loc_oPagina
3188:         TRY
3189:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3190: 
3191:             *-- Grupo de acesso padrao de fornecedores (legado: Init faz
3192:             *-- "Get_Grupo.Value = crSigCdPam.GrPadFors" uma unica vez; aqui
3193:             *-- reaplicado a cada Incluir, equivalente para "novo registro")
3194:             loc_oPagina.txt_4c_Grupo.Value   = IIF(USED("crSigCdPam"), ;
3195:                 ALLTRIM(NVL(crSigCdPam.GrPadFors, "")), "")
3196:             loc_oPagina.txt_4c_Conta.Value   = ""
3197:             loc_oPagina.txt_4c_Dconta.Value  = ""
3198:             loc_oPagina.txt_4c_Cpf.Value     = ""
3199:             loc_oPagina.txt_4c_Moeda.Value   = ""
3200:             loc_oPagina.txt_4c_Arquivo.Value = ""
3201:             loc_oPagina.opt_4c_Custo.Value   = 1
3202: 
3203:             loc_oPagina.grd_4c_Estoque.RecordSource = ""
3204:             IF USED("cursor_4c_Estoque")
3205:                 USE IN cursor_4c_Estoque
3206:             ENDIF
3207:         CATCH TO loException
3208:             MostrarErro(loException, "FormSigPrCtr.LimparCampos")
3209:         ENDTRY
3210:     ENDPROC
3211: 
3212:     *===========================================================================
3213:     * HabilitarCampos - Habilita/desabilita os campos editaveis da aba
3214:     * Precificacao. txt_4c_Dconta e sempre somente-leitura (preenchido por
3215:     * lookup em AtualizarCpfEGrupoPorConta, nunca digitado pelo usuario).
3216:     *===========================================================================
3217:     PROCEDURE HabilitarCampos(par_lHabilitar)
3218:         LOCAL loc_oPagina
3219:         TRY
3220:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3221: 
3222:             loc_oPagina.txt_4c_Grupo.Enabled   = par_lHabilitar
3223:             loc_oPagina.txt_4c_Conta.Enabled   = par_lHabilitar
3224:             loc_oPagina.txt_4c_Cpf.Enabled     = par_lHabilitar
3225:             loc_oPagina.txt_4c_Moeda.Enabled   = par_lHabilitar
3226:             loc_oPagina.txt_4c_Arquivo.Enabled = par_lHabilitar
3227:             loc_oPagina.opt_4c_Custo.Enabled   = par_lHabilitar
3228:             loc_oPagina.txt_4c_Dconta.Enabled  = .F.
3229:         CATCH TO loException
3230:             MostrarErro(loException, "FormSigPrCtr.HabilitarCampos")
3231:         ENDTRY
3232:     ENDPROC
3233: 
3234:     *===========================================================================
3235:     * AjustarBotoesPorModo - Alterna habilitacao dos botoes CRUD (Page1) e
3236:     * Confirmar/Cancelar (Page2) conforme this_cModoAtual. Chamada tanto ao
3237:     * ENTRAR em edicao quanto ao VOLTAR para a lista via AlternarPagina(1)
3238:     * (regra #40 - quem desabilita no funil de ida tem que reabilitar no
3239:     * funil de volta).
3240:     *===========================================================================
3241:     PROCEDURE AjustarBotoesPorModo()
3242:         LOCAL loc_oCntBotoes, loc_lEmEdicao
3243:         TRY
3244:             loc_oCntBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
3245:             loc_lEmEdicao  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
3246: 
3247:             loc_oCntBotoes.cmd_4c_Incluir.Enabled    = !loc_lEmEdicao
3248:             loc_oCntBotoes.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
3249:             loc_oCntBotoes.cmd_4c_Alterar.Enabled    = !loc_lEmEdicao
3250:             loc_oCntBotoes.cmd_4c_Excluir.Enabled    = !loc_lEmEdicao
3251:             loc_oCntBotoes.cmd_4c_Buscar.Enabled     = !loc_lEmEdicao
3252: 
3253:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
3254:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3255:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = loc_lEmEdicao
3256:         CATCH TO loException
3257:             MostrarErro(loException, "FormSigPrCtr.AjustarBotoesPorModo")
3258:         ENDTRY
3259:     ENDPROC
3260: 
3261:     *===========================================================================
3262:     * BtnIncluirClick - Inicia inclusao de novo lote de controle
3263:     * (legado: Grupo_Op.Click(1) -> DoDefault(1) navega para Pagina.Dados).
3264:     *===========================================================================
3265:     PROCEDURE BtnIncluirClick()
3266:         TRY
3267:             THIS.this_oBusinessObject.NovoRegistro()
3268:             THIS.LimparCampos()
3269:             THIS.this_cModoAtual = "INCLUIR"
3270:             THIS.HabilitarCampos(.T.)
3271:             THIS.AjustarBotoesPorModo()
3272:             THIS.AlternarPagina(2)
3273:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.txt_4c_Conta.SetFocus()
3274:         CATCH TO loException
3275:             MostrarErro(loException, "FormSigPrCtr.BtnIncluirClick")
3276:         ENDTRY
3277:     ENDPROC
3278: 
3279:     *===========================================================================
3280:     * BtnAlterarClick - Carrega o lote selecionado na Lista (agrupado por
3281:     * Codigos - regra #42) para alteracao.
3282:     *===========================================================================
3283:     PROCEDURE BtnAlterarClick()
3284:         LOCAL loc_cCodigo, loc_lTemSelecao
3285:         loc_lTemSelecao = .F.
3286: 
3287:         TRY
3288:             IF USED("cursor_4c_Lista")
3289:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3290:                     loc_lTemSelecao = .T.
3291:                 ENDIF
3292:             ENDIF
3293: 
3294:             IF !loc_lTemSelecao
3295:                 MsgAviso("Selecione um registro na lista para alterar.", "Aviso")
3296:             ELSE
3297:                 SELECT cursor_4c_Lista
3298:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3299: 
3300:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3301:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3302:                 ELSE
3303:                     THIS.this_oBusinessObject.EditarRegistro()
3304:                     THIS.BOParaForm()
3305:                     THIS.this_cModoAtual = "ALTERAR"
3306:                     THIS.HabilitarCampos(.T.)
3307:                     THIS.AjustarBotoesPorModo()
3308:                     THIS.AlternarPagina(2)
3309:                 ENDIF
3310:             ENDIF
3311:         CATCH TO loException
3312:             MostrarErro(loException, "FormSigPrCtr.BtnAlterarClick")
3313:         ENDTRY
3314:     ENDPROC
3315: 
3316:     *===========================================================================
3317:     * BtnVisualizarClick - Carrega o lote selecionado somente para consulta
3318:     * (campos desabilitados, Confirmar desabilitado - padrao canonico).
3319:     *===========================================================================
3320:     PROCEDURE BtnVisualizarClick()
3321:         LOCAL loc_cCodigo, loc_lTemSelecao
3322:         loc_lTemSelecao = .F.
3323: 
3324:         TRY
3325:             IF USED("cursor_4c_Lista")
3326:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3327:                     loc_lTemSelecao = .T.
3328:                 ENDIF
3329:             ENDIF
3330: 
3331:             IF !loc_lTemSelecao
3332:                 MsgAviso("Selecione um registro na lista para visualizar.", "Aviso")
3333:             ELSE
3334:                 SELECT cursor_4c_Lista
3335:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3336: 
3337:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3338:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3339:                 ELSE
3340:                     THIS.BOParaForm()
3341:                     THIS.this_cModoAtual = "VISUALIZAR"
3342:                     THIS.HabilitarCampos(.F.)
3343:                     THIS.AjustarBotoesPorModo()
3344:                     THIS.AlternarPagina(2)
3345:                 ENDIF
3346:             ENDIF
3347:         CATCH TO loException
3348:             MostrarErro(loException, "FormSigPrCtr.BtnVisualizarClick")
3349:         ENDTRY
3350:     ENDPROC
3351: 
3352:     *===========================================================================
3353:     * BtnExcluirClick - Exclui o lote selecionado (todas as linhas do mesmo
3354:     * Codigos - legado: "Delete From SigPrCtr Where Codigos = ?_Codigo").
3355:     * Falha de gravacao nunca eh muda (regra #20) - BusinessBase.Excluir()
3356:     * ja chama MsgErro internamente quando necessario.
3357:     *===========================================================================
3358:     PROCEDURE BtnExcluirClick()
3359:         LOCAL loc_cCodigo, loc_lTemSelecao
3360:         loc_lTemSelecao = .F.
3361: 
3362:         TRY
3363:             IF USED("cursor_4c_Lista")
3364:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3365:                     loc_lTemSelecao = .T.
3366:                 ENDIF
3367:             ENDIF
3368: 
3369:             IF !loc_lTemSelecao
3370:                 MsgAviso("Selecione um registro na lista para excluir.", "Aviso")
3371:             ELSE
3372:                 SELECT cursor_4c_Lista
3373:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3374: 
3375:                 IF MsgConfirma("Deseja realmente excluir o registro " + loc_cCodigo + "?", ;
3376:                         "Confirmar Exclus" + CHR(227) + "o")
3377: 
3378:                     IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3379:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3380:                     ELSE
3381:                         IF THIS.this_oBusinessObject.Excluir()
3382:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
3383:                             THIS.CarregarLista()
3384:                         ELSE
3385:                             IF !THIS.this_oBusinessObject.this_lErroExibido
3386:                                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
3387:                             ENDIF
3388:                         ENDIF
3389:                     ENDIF
3390:                 ENDIF
3391:             ENDIF
3392:         CATCH TO loException
3393:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirClick")
3394:         ENDTRY
3395:     ENDPROC
3396: 
3397:     *===========================================================================
3398:     * BtnBuscarClick - Recarrega a lista com o periodo atual dos filtros
3399:     * (legado: msv_procurar/GetCodigos nao foi migrado - nao ha campo de
3400:     * busca por exemplo na Lista, apenas o filtro de periodo, ja aplicado
3401:     * automaticamente pelo LostFocus de txt_4c_Dt_final/txt_4c_Dt_inicial;
3402:     * padrao identico ao de FormMoe/FormROM/FormPAT).
3403:     *===========================================================================
3404:     PROCEDURE BtnBuscarClick()
3405:         THIS.CarregarLista()
3406:     ENDPROC
3407: 
3408:     *===========================================================================
3409:     * BtnConfirmarClick - Salva o lote (Grupo_Salva.Salva.Click legado).
3410:     * SigPrCtrBO.ValidarDados() cobre a validacao "Favor Informar uma Conta.";
3411:     * falha de gravacao nunca eh muda (regra #20) - o form so complementa a
3412:     * mensagem quando o BO ainda nao exibiu nenhuma.
3413:     *===========================================================================
3414:     PROCEDURE BtnConfirmarClick()
3415:         TRY
3416:             THIS.FormParaBO()
3417: 
3418:             IF THIS.this_oBusinessObject.Salvar()
3419:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
3420:                 THIS.AlternarPagina(1)
3421:             ELSE
3422:                 IF !THIS.this_oBusinessObject.this_lErroExibido
3423:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
3424:                 ENDIF
3425:             ENDIF
3426:         CATCH TO loException
3427:             MostrarErro(loException, "FormSigPrCtr.BtnConfirmarClick")
3428:         ENDTRY
3429:     ENDPROC
3430: 
3431:     *===========================================================================
3432:     * BtnCancelarClick - Cancela a edicao e volta para a Lista (legado:
3433:     * Grupo_Salva.Cancelar.Click -> ThisForm.mAtivaPagina1 + ActivePage=1).
3434:     *===========================================================================
3435:     PROCEDURE BtnCancelarClick()
3436:         TRY
3437:             THIS.this_oBusinessObject.CancelarEdicao()
3438:             THIS.AlternarPagina(1)
3439:         CATCH TO loException
3440:             MostrarErro(loException, "FormSigPrCtr.BtnCancelarClick")
3441:         ENDTRY
3442:     ENDPROC
3443: 
3444:     *===========================================================================
3445:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
3446:     * REGRA: Deve iterar Pages E Controls para PageFrames (problema 6)
3447:     *===========================================================================
3448:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3449:         LOCAL loc_nI, loc_oObjeto, loc_nP
3450: 
3451:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3452:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3453: 
3454:             IF VARTYPE(loc_oObjeto) = "O"
3455:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3456:                     loc_oObjeto.Visible = .T.
3457:                 ENDIF
3458: 
3459:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3460:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3461:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3462:                     ENDFOR
3463:                 ENDIF
3464: 
3465:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3466:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3467:                 ENDIF
3468:             ENDIF
3469:         ENDFOR
3470:     ENDPROC
3471: 
3472:     *===========================================================================
3473:     * Destroy - Libera o Business Object
3474:     *===========================================================================
3475:     PROCEDURE Destroy()
3476:         THIS.this_oBusinessObject = .NULL.
3477:         RETURN DODEFAULT()
3478:     ENDPROC
3479: 
3480: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SigPrCtrBO.prg):
*====================================================================
* SigPrCtrBO.prg
*
* Business Object para Controle de Movimentacoes por XML
* Tabela: SigPrCtr
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SigPrCtrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigPrCtr)
    this_cPkChave     = ""    && pkchave    char(20)  - PK
    this_cCodCors     = ""    && codcors    char(4)
    this_cCodigos     = ""    && codigos    char(10)
    this_cCodTams     = ""    && codtams    char(4)
    this_cCpros       = ""    && cpros      char(14)
    this_dDatas       = {}    && datas      datetime  NULL
    this_dDtAlts      = {}    && dtalts     datetime  NULL
    this_nQtdos       = 0     && qtdos      numeric(10,2)
    this_nQtds        = 0     && qtds       numeric(10,2)
    this_cUsuAlts     = ""    && usualts    char(10)
    this_cUsuars      = ""    && usuars     char(10)
    this_cOriDopNums  = ""    && oridopnums char(29)
    this_cContas      = ""    && contas     char(10)
    this_nPrecific    = 0     && precific   numeric(1,0)
    this_cMoedas      = ""    && moedas     char(3)
    this_cArquivo     = ""    && arquivo    char(200)
    this_cFkChaves    = ""    && fkchaves   char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigPrCtr"
            THIS.this_cCampoChave = "pkchave"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SigPrCtrBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Chave primaria do registro atual (RegistrarAuditoria)
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cPkChave)
    ENDFUNC

    *====================================================================
    * CarregarCambio - fCarregarCambio (SIGFUNCS.PRG) do legado NAO foi
    * portada para utils/functions.prg (memoria: fCarregarCambio_nao_portada).
    * Usa os cursores crSigCdCot/crSigCdMoe (carregados pelo Form no Init,
    * mesma sessao - FormSigPrCtr nao declara DataSession proprio). PUBLIC
    * (nao PROTECTED) - chamada pelo Form em ExecutarProcessamentoXml.
    *====================================================================
    FUNCTION CarregarCambio(par_cMoeda, par_xData)
        LOCAL loc_nCotacao, loc_cMoeda, loc_dData, loc_oErro
        loc_nCotacao = 0
        loc_cMoeda   = ALLTRIM(par_cMoeda)

        DO CASE
            CASE VARTYPE(par_xData) == "T"
                loc_dData = ConverterParaData(par_xData)
            CASE VARTYPE(par_xData) == "D"
                loc_dData = par_xData
            OTHERWISE
                loc_dData = DATE()
        ENDCASE

        IF EMPTY(loc_cMoeda)
            RETURN 1
        ENDIF

        TRY
            IF USED("crSigCdMoe")
                SELECT crSigCdMoe
                SET ORDER TO CMoes
                IF SEEK(loc_cMoeda) AND crSigCdMoe.Cotas <> 0
                    IF USED("crSigCdCot")
                        SELECT crSigCdCot
                        SET ORDER TO CMoeData DESCENDING
                        SET NEAR ON
                        SEEK loc_cMoeda + DTOS(loc_dData)
                        SET NEAR OFF
                        IF !EOF() AND ALLTRIM(crSigCdCot.CMoes) = loc_cMoeda
                            loc_nCotacao = crSigCdCot.Valos
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            SET NEAR OFF
        ENDTRY

        RETURN IIF(loc_nCotacao = 0, 1, loc_nCotacao)
    ENDFUNC

    *====================================================================
    * ValidarDados - Validacao chamada pelo BusinessBase.Salvar() antes de
    * Inserir/Atualizar (legado: "Favor Informar uma Conta." - guard no
    * inicio do Lerxml/processar do Pageframe1.Page1 - comportamento.json).
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cContas))
            THIS.this_cMensagemErro = "Favor Informar uma Conta."
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades a partir de uma linha do
    * cursor (estrutura de dbo.SigPrCtr - docs/schema.sql).
    * REGRA: OriDopNums eh chave POSICIONAL (Emps char(3)+Dopes char(20)+
    * Str(Numes,6) = 29) - NUNCA aplicar ALLTRIM nela, o padding faz parte
    * da chave usada para casar com SigMvCab.EmpDopNums.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)

            THIS.this_cPkChave    = ALLTRIM(TratarNulo(pkchave, ""))
            THIS.this_cCodCors    = ALLTRIM(TratarNulo(codcors, ""))
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos, ""))
            THIS.this_cCodTams    = ALLTRIM(TratarNulo(codtams, ""))
            THIS.this_cCpros      = ALLTRIM(TratarNulo(cpros, ""))
            THIS.this_dDatas      = ConverterParaData(TratarNulo(datas, {}))
            THIS.this_dDtAlts     = ConverterParaData(TratarNulo(dtalts, {}))
            THIS.this_nQtdos      = TratarNulo(qtdos, 0)
            THIS.this_nQtds       = TratarNulo(qtds, 0)
            THIS.this_cUsuAlts    = ALLTRIM(TratarNulo(usualts, ""))
            THIS.this_cUsuars     = ALLTRIM(TratarNulo(usuars, ""))
            THIS.this_cOriDopNums = TratarNulo(oridopnums, "")
            THIS.this_cContas     = ALLTRIM(TratarNulo(contas, ""))
            THIS.this_nPrecific   = TratarNulo(precific, 0)
            THIS.this_cMoedas     = ALLTRIM(TratarNulo(moedas, ""))
            THIS.this_cArquivo    = ALLTRIM(TratarNulo(arquivo, ""))
            THIS.this_cFkChaves   = ALLTRIM(TratarNulo(fkchaves, ""))

            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigPrCtr
    * Espelha o "Insert Into crSigPrCtr (...)" + "Replace PkChave With
    * fUniqueIds()" do Grupo_Salva.Salva.Click legado (modo INSERIR):
    * a chave primaria (pkchave) e o codigo de agrupamento (codigos) sao
    * gerados aqui quando ainda nao foram atribuidos pelo chamador.
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChave))
                THIS.this_cPkChave = LEFT(fUniqueIds(), 20)
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCodigos))
                THIS.this_cCodigos = fGerMascara(fGerUniqueKey("SigPrCtr"))
            ENDIF

            IF EMPTY(THIS.this_dDatas)
                THIS.this_dDatas = DATETIME()
            ENDIF

            THIS.this_cUsuars = IIF(!EMPTY(ALLTRIM(THIS.this_cUsuars)), THIS.this_cUsuars, ;
                IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, ""))

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigPrCtr (pkchave, codcors, codigos, codtams, cpros,
                    datas, dtalts, qtdos, qtds, usualts, usuars, oridopnums,
                    contas, precific, moedas, arquivo, fkchaves)
                VALUES (
                    <<EscaparSQL(THIS.this_cPkChave)>>,
                    <<EscaparSQL(THIS.this_cCodCors)>>,
                    <<EscaparSQL(THIS.this_cCodigos)>>,
                    <<EscaparSQL(THIS.this_cCodTams)>>,
                    <<EscaparSQL(THIS.this_cCpros)>>,
                    <<FormatarDataSQL(THIS.this_dDatas)>>,
                    <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    <<EscaparSQL(THIS.this_cContas)>>,
                    <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    <<EscaparSQL(THIS.this_cMoedas)>>,
                    <<EscaparSQL(THIS.this_cArquivo)>>,
                    <<EscaparSQL(THIS.this_cFkChaves)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "SigPrCtrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente em SigPrCtr (WHERE pkchave)
    * Espelha "Replace DtAlts With Datetime() / UsuAlts With m.usuar" do
    * Grupo_Salva.Salva.Click legado (modo ALTERAR).
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            THIS.this_dDtAlts  = DATETIME()
            THIS.this_cUsuAlts = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, THIS.this_cUsuAlts)

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigPrCtr
                SET codcors    = <<EscaparSQL(THIS.this_cCodCors)>>,
                    codigos    = <<EscaparSQL(THIS.this_cCodigos)>>,
                    codtams    = <<EscaparSQL(THIS.this_cCodTams)>>,
                    cpros      = <<EscaparSQL(THIS.this_cCpros)>>,
                    datas      = <<FormatarDataSQL(THIS.this_dDatas)>>,
                    dtalts     = <<FormatarDataSQL(THIS.this_dDtAlts)>>,
                    qtdos      = <<FormatarNumeroSQL(THIS.this_nQtdos, 2)>>,
                    qtds       = <<FormatarNumeroSQL(THIS.this_nQtds, 2)>>,
                    usualts    = <<EscaparSQL(THIS.this_cUsuAlts)>>,
                    usuars     = <<EscaparSQL(THIS.this_cUsuars)>>,
                    oridopnums = <<EscaparSQL(THIS.this_cOriDopNums)>>,
                    contas     = <<EscaparSQL(THIS.this_cContas)>>,
                    precific   = <<FormatarNumeroSQL(THIS.this_nPrecific, 0)>>,
                    moedas     = <<EscaparSQL(THIS.this_cMoedas)>>,
                    arquivo    = <<EscaparSQL(THIS.this_cArquivo)>>,
                    fkchaves   = <<EscaparSQL(THIS.this_cFkChaves)>>
                WHERE pkchave = <<EscaparSQL(THIS.this_cPkChave)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "SigPrCtrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega a linha mais representativa do agrupamento
    * "Codigos" (legado: crSigPrCtr requerido pela Grade da Lista, que
    * agrupa por Codigos - regra #42/comportamento.json). Usada por
    * Alterar/Visualizar/Excluir para trazer Conta/Moeda/Arquivo/Precific
    * do "cabecalho" do lote antes de reconstruir as linhas em Confirmar.
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF

            loc_cSQL = "SELECT TOP 1 * FROM SigPrCtr WHERE codigos = " + ;
                EscaparSQL(par_cCodigo) + " ORDER BY pkchave"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarregaCtr")

            IF loc_nResultado >= 0 AND USED("cursor_4c_CarregaCtr") AND RECCOUNT("cursor_4c_CarregaCtr") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_CarregaCtr")
                THIS.this_lNovoRegistro = .F.
            ELSE
                THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado"
            ENDIF

            IF USED("cursor_4c_CarregaCtr")
                USE IN cursor_4c_CarregaCtr
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "SigPrCtrBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui TODAS as linhas do lote "Codigos" (transcrito
    * literalmente do legado: "Delete From SigPrCtr Where Codigos = ?_Codigo",
    * msv_Alterar - comportamento.json). A Lista agrupa por Codigos (regra
    * #42), entao excluir eh excluir o lote inteiro, nao so a linha this_cPkChave.
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso

        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCtr WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir controle:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "SigPrCtrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

