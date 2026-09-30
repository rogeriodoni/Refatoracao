# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (20)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CARGA-DADOS] Metodo ValidarCpfCnpjFornecedor faz validacao SQL mas NAO chama metodo de carga de dados (CarregarGrade/BuscarSaldos). No legado, o Valid do campo de filtro carrega a grade automaticamente. Adicionar chamada ao metodo de carga apos validacao bem-sucedida.
- [CARGA-DADOS] OptionGroup 'opt_4c_Custo' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [CARGA-DADOS] OptionGroup 'opt_4c_Filtro' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [BINDEVENT-PARAMS] Handler 'ValidarDataInicial' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDataFinal' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGrupoAcesso' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGrupoAcesso(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarContaFornecedor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarCpfCnpjFornecedor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarCpfCnpjFornecedor(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDescricaoConta' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDescricaoConta(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarMoedaFornecedor' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarMoedaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormSigPrCtr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3470 linhas total):

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

*-- Linhas 239 a 684:
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
486:             loc_dDataIni     = ConverterParaData(loc_oPagina.txt_4c_Dt_inicial.Value)
487:             loc_dDataFimBase = ConverterParaData(loc_oPagina.txt_4c_Dt_final.Value)
488:             loc_tDataFim = DATETIME(YEAR(loc_dDataFimBase), MONTH(loc_dDataFimBase), ;
489:                 DAY(loc_dDataFimBase), 23, 59, 59)
490: 
491:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
492:                 SELECT DISTINCT a.Codigos, MAX(a.Datas) AS Datas, a.OriDopNums,
493:                     a.Usuars, a.Contas, b.Rclis
494:                 FROM SigPrCtr a
495:                 JOIN SigCdCli b ON a.Contas = b.Iclis
496:                 WHERE a.Datas BETWEEN <<FormatarDataSQL(loc_dDataIni)>> AND <<FormatarDataSQL(loc_tDataFim)>>
497:                 GROUP BY a.Codigos, a.OriDopNums, a.Usuars, a.Contas, b.Rclis
498:             ENDTEXT
499: 
500:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Lista")
501: 
502:             IF loc_nResultado >= 0
503:                 loc_oGrid.ColumnCount           = 6
504:                 loc_oGrid.RecordSource          = "cursor_4c_Lista"
505:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Lista.Codigos"
506:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Lista.Datas"
507:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Lista.OriDopNums"
508:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Lista.Usuars"
509:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Lista.Contas"
510:                 loc_oGrid.Column6.ControlSource = "cursor_4c_Lista.Rclis"
511: 
512:                 *-- Reconfigurar cabecalhos e largura APOS RecordSource (obrigatorio - regra #48)
513:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
514:                 loc_oGrid.Column2.Header1.Caption = "Data"
515:                 loc_oGrid.Column3.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
516:                 loc_oGrid.Column4.Header1.Caption = "Usu" + CHR(225) + "rio"
517:                 loc_oGrid.Column5.Header1.Caption = "Fornecedor"
518:                 loc_oGrid.Column6.Header1.Caption = "Nome"
519: 
520:                 THIS.FormatarGridLista(loc_oGrid)
521: 
522:                 *-- Column.Width por ULTIMO (regra #35c: RecordSource/ControlSource
523:                 *-- recalculam a largura para o default 90 - so fica se atribuido
524:                 *-- DEPOIS do FormatarGridLista)
525:                 loc_oGrid.Column1.Width = 80
526:                 loc_oGrid.Column2.Width = 75
527:                 loc_oGrid.Column3.Width = 280
528:                 loc_oGrid.Column4.Width = 80
529:                 loc_oGrid.Column5.Width = 80
530:                 loc_oGrid.Column6.Width = 180
531: 
532:                 IF USED("cursor_4c_Lista")
533:                     GO TOP IN cursor_4c_Lista
534:                 ENDIF
535:                 loc_oGrid.Refresh()
536:                 loc_lResultado = .T.
537:             ELSE
538:                 MsgErro("Erro ao carregar lista:" + CHR(13) + CapturarErroSQL(), "CarregarLista")
539:             ENDIF
540:         CATCH TO loException
541:             MostrarErro(loException, "FormSigPrCtr.CarregarLista")
542:         ENDTRY
543: 
544:         RETURN loc_lResultado
545:     ENDPROC
546: 
547:     *===========================================================================
548:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
549:     *===========================================================================
550:     PROCEDURE AlternarPagina(par_nPagina)
551:         LOCAL loc_lResultado
552:         loc_lResultado = .F.
553: 
554:         TRY
555:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
556:                 MsgErro("Parametro invalido em AlternarPagina: " + TRANSFORM(par_nPagina), "Erro")
557:             ELSE
558:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
559:                 IF par_nPagina = 1
560:                     THIS.this_cModoAtual = "LISTA"
561:                     THIS.CarregarLista()
562:                     THIS.AjustarBotoesPorModo()
563:                 ENDIF
564:                 loc_lResultado = .T.
565:             ENDIF
566:         CATCH TO loException
567:             MostrarErro(loException, "FormSigPrCtr.AlternarPagina")
568:         ENDTRY
569: 
570:         RETURN loc_lResultado
571:     ENDPROC
572: 
573:     *===========================================================================
574:     * FormatarGridLista - Formata visual do grid da lista
575:     *===========================================================================
576:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
577:         WITH par_oGrid
578:             .FontName = "Tahoma"
579:             .FontSize = 8
580:         ENDWITH
581:     ENDPROC
582: 
583:     *===========================================================================
584:     * ValidarDataInicial - LostFocus de txt_4c_Dt_inicial (legado: Dt_inicial.Valid)
585:     * Se a data inicial ultrapassar a final, empurra a final junto.
586:     *===========================================================================
587:     PROCEDURE ValidarDataInicial(par_nKeyCode, par_nShiftAltCtrl)
588:         LOCAL loc_oPagina
589:         TRY
590:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
591:             IF loc_oPagina.txt_4c_Dt_inicial.Value > loc_oPagina.txt_4c_Dt_final.Value
592:                 loc_oPagina.txt_4c_Dt_final.Value = loc_oPagina.txt_4c_Dt_inicial.Value
593:             ENDIF
594:         CATCH TO loException
595:             MostrarErro(loException, "FormSigPrCtr.ValidarDataInicial")
596:         ENDTRY
597:     ENDPROC
598: 
599:     *===========================================================================
600:     * ValidarDataFinal - LostFocus de txt_4c_Dt_final (legado: Dt_final.Valid +
601:     * Dt_final.LostFocus: reconstroi a data final, recarrega a Grade e devolve
602:     * o foco para ela).
603:     *===========================================================================
604:     PROCEDURE ValidarDataFinal(par_nKeyCode, par_nShiftAltCtrl)
605:         LOCAL loc_oPagina
606:         TRY
607:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
608:             IF loc_oPagina.txt_4c_Dt_final.Value < loc_oPagina.txt_4c_Dt_inicial.Value
609:                 loc_oPagina.txt_4c_Dt_inicial.Value = loc_oPagina.txt_4c_Dt_final.Value
610:             ENDIF
611:             THIS.CarregarLista()
612:             loc_oPagina.grd_4c_Lista.SetFocus()
613:         CATCH TO loException
614:             MostrarErro(loException, "FormSigPrCtr.ValidarDataFinal")
615:         ENDTRY
616:     ENDPROC
617: 
618:     *===========================================================================
619:     * BtnEncerrarClick - Fecha o formulario
620:     *===========================================================================
621:     PROCEDURE BtnEncerrarClick()
622:         THIS.Release()
623:     ENDPROC
624: 
625:     *===========================================================================
626:     * ConfigurarPaginaDados - Estrutura base de Page2 (FASE 3)
627:     * Cabecalho (faixa cinza, regra #11) + container vazio de botoes de acao.
628:     * Campos e lookups entram nas Fases 5-6.
629:     *===========================================================================
630:     PROTECTED PROCEDURE ConfigurarPaginaDados()
631:         LOCAL loc_oPagina, loc_oAba1, loc_oAba2, loc_oGrid
632:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
633: 
634:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
635: 
636:         *-- Cabecalho cinza (identico ao da pagina Lista - regra #11)
637:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
638:         WITH loc_oPagina.cnt_4c_Cabecalho
639:             .Top           = 29
640:             .Left          = 0
641:             .Width         = THIS.Width
642:             .Height        = 80
643:             .BackColor     = RGB(100, 100, 100)
644:             .BorderWidth   = 0
645:             .SpecialEffect = 0
646:             .Visible       = .T.
647: 
648:             .AddObject("lbl_4c_Sombra", "Label")
649:             WITH .lbl_4c_Sombra
650:                 .Caption   = THIS.Caption
651:                 .Top       = 15
652:                 .Left      = 10
653:                 .Width     = THIS.Width
654:                 .Height    = 40
655:                 .FontName  = "Tahoma"
656:                 .FontSize  = 16
657:                 .FontBold  = .T.
658:                 .ForeColor = RGB(0, 0, 0)
659:                 .BackStyle = 0
660:                 .AutoSize  = .F.
661:                 .Visible   = .T.
662:             ENDWITH
663: 
664:             .AddObject("lbl_4c_Titulo", "Label")
665:             WITH .lbl_4c_Titulo
666:                 .Caption   = THIS.Caption
667:                 .Top       = 18
668:                 .Left      = 10
669:                 .Width     = THIS.Width
670:                 .Height    = 46
671:                 .FontName  = "Tahoma"
672:                 .FontSize  = 16
673:                 .FontBold  = .T.
674:                 .ForeColor = RGB(255, 255, 255)
675:                 .BackStyle = 0
676:                 .AutoSize  = .F.
677:                 .Visible   = .T.
678:             ENDWITH
679:         ENDWITH
680: 
681:         *-- Container BotoesAcao - VAZIO nesta fase (Confirmar/Cancelar entram em fase posterior)
682:         *-- Posicionado relativo a THIS.Width (canonico: Left=842 quando Width=1000)
683:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
684:         WITH loc_oPagina.cnt_4c_BotoesAcao

*-- Linhas 714 a 788:
714:             .AutoSize        = .F.
715:             .Enabled         = .F.
716:         ENDWITH
717:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
718: 
719:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
720:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
721:             .Caption         = "Encerrar"
722:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
723:             .PicturePosition = 13
724:             .Top             = 5
725:             .Left            = 80
726:             .Width           = 75
727:             .Height          = 75
728:             .FontName        = "Comic Sans MS"
729:             .FontSize        = 8
730:             .FontBold        = .T.
731:             .FontItalic      = .T.
732:             .ForeColor       = RGB(90, 90, 90)
733:             .BackColor       = RGB(255, 255, 255)
734:             .Themes          = .F.
735:             .SpecialEffect   = 0
736:             .MousePointer    = 15
737:             .WordWrap        = .T.
738:             .AutoSize        = .F.
739:         ENDWITH
740:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
741: 
742:         *-- ===================================================================
743:         *-- PageFrame interno (legado: Pagina.Dados.Pageframe1) - Precificacao
744:         *-- (Page1) e Movimentacoes/Produtos (Page2). Tabs=.T. (abas reais e
745:         *-- visiveis, ao contrario do PageFrame externo pgf_4c_Paginas) - por
746:         *-- isso os filhos usam as coordenadas ORIGINAIS do SCX (relativas a
747:         *-- Pageframe1.PageN), SEM a compensacao +29 do truque Top=-29.
748:         *-- Aba Precificacao (Page1): labels, textboxes, os 2 OptionGroups de
749:         *-- filtro/precificacao e a grd_4c_Estoque. Botoes (processar/
750:         *-- btnCadastros/Bot_Consulta/Command12/cmdOperacao) e os grids da
751:         *-- aba Page2 (grd_4c_Disponivel/grd_4c_ItemXml) entram em fase
752:         *-- posterior.
753:         *-- ===================================================================
754:         loc_oPagina.AddObject("pgf_4c_Detalhes", "PageFrame")
755:         WITH loc_oPagina.pgf_4c_Detalhes
756:             .PageCount = 2
757:             .Top       = 115
758:             .Left      = 5
759:             .Width     = THIS.Width - 10
760:             .Height    = 485
761:             .Tabs      = .T.
762:             .Visible   = .T.
763: 
764:             .Page1.Caption   = "Precifica" + CHR(231) + CHR(227) + "o"
765:             .Page1.BackColor = RGB(255, 255, 255)
766: 
767:             .Page2.Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
768:             .Page2.BackColor = RGB(255, 255, 255)
769:         ENDWITH
770: 
771:         loc_oAba1 = loc_oPagina.pgf_4c_Detalhes.Page1
772: 
773:         *-- Say4 "Fornecedores :"
774:         loc_oAba1.AddObject("lbl_4c_Fornecedores", "Label")
775:         WITH loc_oAba1.lbl_4c_Fornecedores
776:             .Caption   = "Fornecedores :"
777:             .Top       = 69
778:             .Left      = 228
779:             .Width     = 75
780:             .Height    = 15
781:             .Alignment = 0
782:             .AutoSize  = .F.
783:             .BackStyle = 0
784:             .FontName  = "Tahoma"
785:             .FontSize  = 8
786:             .ForeColor = RGB(90, 90, 90)
787:         ENDWITH
788: 

*-- Linhas 805 a 924:
805:             .ForeColor     = RGB(0, 0, 0)
806:             .Value         = ""
807:         ENDWITH
808:         BINDEVENT(loc_oAba1.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupoAcesso")
809: 
810:         *-- Get_Conta -> this_cContas (schema: contas char(10))
811:         loc_oAba1.AddObject("txt_4c_Conta", "TextBox")
812:         WITH loc_oAba1.txt_4c_Conta
813:             .Top           = 66
814:             .Left          = 394
815:             .Width         = 85
816:             .Height        = 21
817:             .FontName      = "Tahoma"
818:             .FontSize      = 8
819:             .Format        = "K"
820:             .Alignment     = 0
821:             .MaxLength     = 10
822:             .BorderStyle   = 1
823:             .SpecialEffect = 1
824:             .ForeColor     = RGB(0, 0, 0)
825:             .Value         = ""
826:         ENDWITH
827:         BINDEVENT(loc_oAba1.txt_4c_Conta, "KeyPress", THIS, "ValidarContaFornecedor")
828: 
829:         *-- Get_cpf (CPF/CNPJ do fornecedor - validacao fValidarCPF/fValidarCNPJ;
830:         *-- SigPrCtr nao tem coluna de CPF, campo nao e persistido diretamente)
831:         loc_oAba1.AddObject("txt_4c_Cpf", "TextBox")
832:         WITH loc_oAba1.txt_4c_Cpf
833:             .Top           = 66
834:             .Left          = 481
835:             .Width         = 146
836:             .Height        = 21
837:             .FontName      = "Tahoma"
838:             .FontSize      = 8
839:             .InputMask     = "XXXXXXXXXXXXXXXXXXXX"
840:             .MaxLength     = 20
841:             .SpecialEffect = 1
842:             .ForeColor     = RGB(0, 0, 0)
843:             .Value         = ""
844:         ENDWITH
845:         BINDEVENT(loc_oAba1.txt_4c_Cpf, "KeyPress", THIS, "ValidarCpfCnpjFornecedor")
846: 
847:         *-- Get_Dconta (nome/razao social do fornecedor, preenchido apos
848:         *-- validar a Conta - CursorQuery em SigCdCli.Rclis no legado)
849:         loc_oAba1.AddObject("txt_4c_Dconta", "TextBox")
850:         WITH loc_oAba1.txt_4c_Dconta
851:             .Top           = 89
852:             .Left          = 307
853:             .Width         = 357
854:             .Height        = 21
855:             .FontName      = "Tahoma"
856:             .FontSize      = 8
857:             .Format        = "K"
858:             .MaxLength     = 40
859:             .SpecialEffect = 1
860:             .ForeColor     = RGB(0, 0, 0)
861:             .Value         = ""
862:         ENDWITH
863:         BINDEVENT(loc_oAba1.txt_4c_Dconta, "KeyPress", THIS, "ValidarDescricaoConta")
864: 
865:         *-- Say1 "Precificacao :"
866:         loc_oAba1.AddObject("lbl_4c_Precificacao", "Label")
867:         WITH loc_oAba1.lbl_4c_Precificacao
868:             .Caption   = "Precifica" + CHR(231) + CHR(227) + "o :"
869:             .Top       = 114
870:             .Left      = 237
871:             .Width     = 66
872:             .Height    = 15
873:             .Alignment = 0
874:             .AutoSize  = .F.
875:             .BackStyle = 0
876:             .FontName  = "Tahoma"
877:             .FontSize  = 8
878:             .ForeColor = RGB(90, 90, 90)
879:         ENDWITH
880: 
881:         *-- Opt_Custo -> lnOpc do Grupo_Salva.Salva.Click legado (Custo Total
882:         *-- x Custo pela Composicao). OptionGroup NAO tem ForeColor proprio
883:         *-- (regra #33) - cor fica em cada Buttons(N).
884:         loc_oAba1.AddObject("opt_4c_Custo", "OptionGroup")
885:         WITH loc_oAba1.opt_4c_Custo
886:             .ButtonCount = 2
887:             .Top         = 113
888:             .Left        = 303
889:             .Width       = 255
890:             .Height      = 17
891:             .BackStyle   = 0
892:             .BorderStyle = 0
893:             .Value       = 1
894:         ENDWITH
895:         WITH loc_oAba1.opt_4c_Custo.Buttons(1)
896:             .Caption   = "Custo Total"
897:             .Top       = 1
898:             .Left      = 5
899:             .Width     = 73
900:             .Height    = 15
901:             .AutoSize  = .T.
902:             .FontName  = "Tahoma"
903:             .FontSize  = 8
904:             .BackStyle = 0
905:             .ForeColor = RGB(90, 90, 90)
906:         ENDWITH
907:         WITH loc_oAba1.opt_4c_Custo.Buttons(2)
908:             .Caption   = "Custo pela Composi" + CHR(231) + CHR(227) + "o"
909:             .Top       = 1
910:             .Left      = 98
911:             .Width     = 129
912:             .Height    = 15
913:             .AutoSize  = .T.
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .BackStyle = 0
917:             .ForeColor = RGB(90, 90, 90)
918:         ENDWITH
919: 
920:         *-- Say3 "Moeda :"
921:         loc_oAba1.AddObject("lbl_4c_Moeda", "Label")
922:         WITH loc_oAba1.lbl_4c_Moeda
923:             .Caption   = "Moeda :"
924:             .Top       = 137

*-- Linhas 951 a 1038:
951:             .ForeColor     = RGB(0, 0, 0)
952:             .Value         = ""
953:         ENDWITH
954:         BINDEVENT(loc_oAba1.txt_4c_Moeda, "KeyPress", THIS, "ValidarMoedaFornecedor")
955: 
956:         *-- Say2 "Diretorio :"
957:         loc_oAba1.AddObject("lbl_4c_Diretorio", "Label")
958:         WITH loc_oAba1.lbl_4c_Diretorio
959:             .Caption   = "Diret" + CHR(243) + "rio :"
960:             .Top       = 160
961:             .Left      = 253
962:             .Width     = 50
963:             .Height    = 15
964:             .Alignment = 0
965:             .AutoSize  = .F.
966:             .BackStyle = 0
967:             .FontName  = "Tahoma"
968:             .FontSize  = 8
969:             .ForeColor = RGB(90, 90, 90)
970:         ENDWITH
971: 
972:         *-- Get_Arquivo -> this_cArquivo (schema: arquivo char(200))
973:         loc_oAba1.AddObject("txt_4c_Arquivo", "TextBox")
974:         WITH loc_oAba1.txt_4c_Arquivo
975:             .Top           = 157
976:             .Left          = 307
977:             .Width         = 357
978:             .Height        = 21
979:             .FontName      = "Tahoma"
980:             .FontSize      = 8
981:             .MaxLength     = 200
982:             .SpecialEffect = 1
983:             .ForeColor     = RGB(0, 0, 0)
984:             .Value         = ""
985:         ENDWITH
986: 
987:         *-- Opt_Fil -> lnTipo do CarregaArquivos legado (Somente / Nao / Ambos)
988:         loc_oAba1.AddObject("opt_4c_Filtro", "OptionGroup")
989:         WITH loc_oAba1.opt_4c_Filtro
990:             .ButtonCount = 3
991:             .Top         = 179
992:             .Left        = 303
993:             .Width       = 192
994:             .Height      = 24
995:             .BackStyle   = 0
996:             .BorderStyle = 0
997:             .Value       = 1
998:         ENDWITH
999:         WITH loc_oAba1.opt_4c_Filtro.Buttons(1)
1000:             .Caption   = "Somente"
1001:             .Top       = 5
1002:             .Left      = 5
1003:             .Width     = 60
1004:             .Height    = 15
1005:             .AutoSize  = .T.
1006:             .FontName  = "Tahoma"
1007:             .FontSize  = 8
1008:             .BackStyle = 0
1009:             .ForeColor = RGB(90, 90, 90)
1010:         ENDWITH
1011:         WITH loc_oAba1.opt_4c_Filtro.Buttons(2)
1012:             .Caption   = "N" + CHR(227) + "o"
1013:             .Top       = 5
1014:             .Left      = 84
1015:             .Width     = 37
1016:             .Height    = 15
1017:             .AutoSize  = .T.
1018:             .FontName  = "Tahoma"
1019:             .FontSize  = 8
1020:             .BackStyle = 0
1021:             .ForeColor = RGB(90, 90, 90)
1022:         ENDWITH
1023:         WITH loc_oAba1.opt_4c_Filtro.Buttons(3)
1024:             .Caption   = "Ambos"
1025:             .Top       = 5
1026:             .Left      = 132
1027:             .Width     = 50
1028:             .Height    = 15
1029:             .AutoSize  = .T.
1030:             .FontName  = "Tahoma"
1031:             .FontSize  = 8
1032:             .BackStyle = 0
1033:             .ForeColor = RGB(90, 90, 90)
1034:         ENDWITH
1035: 
1036:         *-- Label1 "Carregar produtos que constam nos XML's :" (legado declara
1037:         *-- AutoSize=.T. - transcrever Width/Height fixos: regra #23, AutoSize
1038:         *-- e no-op quando o Label e criado via AddObject)

*-- Linhas 1127 a 1349:
1127:             .Column5.Header1.ForeColor   = RGB(90, 90, 90)
1128:             .Column5.Header1.BackColor   = RGB(192, 192, 192)
1129:         ENDWITH
1130:         BINDEVENT(loc_oGrid.Column1.Header1, "Click", THIS, "OrdenarEstoquePorEmpresa")
1131:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "OrdenarEstoquePorMovimentacao")
1132:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "OrdenarEstoquePorNumero")
1133:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "OrdenarEstoquePorGrupo")
1134:         BINDEVENT(loc_oGrid.Column5.Header1, "Click", THIS, "OrdenarEstoquePorConta")
1135: 
1136:         *-- Shape1 (legado) - decorativo, BackStyle=0/BorderStyle=0 no dump
1137:         *-- original = invisivel (nao desenha preenchimento nem borda);
1138:         *-- transcrito fielmente mesmo assim (regra: nao inventar, so copiar).
1139:         loc_oAba1.AddObject("shp_4c_Shape1", "Shape")
1140:         WITH loc_oAba1.shp_4c_Shape1
1141:             .Top         = 2
1142:             .Left        = 912
1143:             .Width       = 90
1144:             .Height      = 110
1145:             .BackStyle   = 0
1146:             .BorderStyle = 0
1147:             .BorderColor = RGB(136, 189, 188)
1148:         ENDWITH
1149: 
1150:         *-- processar -> cmd_4c_Processar (legado nao declara Width/Height/
1151:         *-- FontName - herdados de Pageframe1.Page1: FontName="Tahoma",
1152:         *-- FontBold=.T., FontSize=8, ForeColor=RGB(90,90,90),
1153:         *-- BackColor=RGB(255,255,255); 75x75 pelo padrao dos demais botoes
1154:         *-- com icone "_60" deste form (Confirmar/Cancelar/Movimento).
1155:         loc_oAba1.AddObject("cmd_4c_Processar", "CommandButton")
1156:         WITH loc_oAba1.cmd_4c_Processar
1157:             .Caption         = "Processar"
1158:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
1159:             .PicturePosition = 13
1160:             .Top             = 7
1161:             .Left            = 962
1162:             .Width           = 75
1163:             .Height          = 75
1164:             .FontName        = "Tahoma"
1165:             .FontSize        = 8
1166:             .FontBold        = .T.
1167:             .ForeColor       = RGB(90, 90, 90)
1168:             .BackColor       = RGB(255, 255, 255)
1169:             .Themes          = .F.
1170:             .SpecialEffect   = 0
1171:             .MousePointer    = 15
1172:             .WordWrap        = .T.
1173:             .AutoSize        = .F.
1174:         ENDWITH
1175:         BINDEVENT(loc_oAba1.cmd_4c_Processar, "Click", THIS, "ProcessarArquivoXmlClick")
1176: 
1177:         *-- btnCadastros -> cmd_4c_BtnCadastros (legado: FontName/ForeColor
1178:         *-- herdados de Pageframe1.Page1 - Tahoma, ForeColor RGB(90,90,90))
1179:         loc_oAba1.AddObject("cmd_4c_BtnCadastros", "CommandButton")
1180:         WITH loc_oAba1.cmd_4c_BtnCadastros
1181:             .Caption       = ""
1182:             .Picture       = gc_4c_CaminhoIcones + "geral_pastas_28.jpg"
1183:             .Top           = 70
1184:             .Left          = 708
1185:             .Width         = 40
1186:             .Height        = 40
1187:             .FontName      = "Tahoma"
1188:             .FontSize      = 7
1189:             .ForeColor     = RGB(90, 90, 90)
1190:             .BackColor     = RGB(255, 255, 255)
1191:             .Themes        = .F.
1192:             .SpecialEffect = 0
1193:             .ToolTipText   = "<F3> Acessa o Cadastro Desta Conta"
1194:         ENDWITH
1195:         BINDEVENT(loc_oAba1.cmd_4c_BtnCadastros, "Click", THIS, "BtnCadastrosContaClick")
1196: 
1197:         *-- Bot_Consulta -> cmd_4c_Bot_Consulta (todas as props explicitas no dump)
1198:         loc_oAba1.AddObject("cmd_4c_Bot_Consulta", "CommandButton")
1199:         WITH loc_oAba1.cmd_4c_Bot_Consulta
1200:             .Caption       = ""
1201:             .Picture       = gc_4c_CaminhoIcones + "geral_calendario_26.jpg"
1202:             .Top           = 70
1203:             .Left          = 667
1204:             .Width         = 40
1205:             .Height        = 40
1206:             .FontName      = "Small Fonts"
1207:             .FontSize      = 4
1208:             .ForeColor     = RGB(90, 90, 90)
1209:             .BackColor     = RGB(255, 255, 255)
1210:             .Themes        = .F.
1211:             .SpecialEffect = 0
1212:             .ToolTipText   = "<F5> Faz a Consulta Gen" + CHR(233) + "rica de Vendas desta Conta..."
1213:         ENDWITH
1214:         BINDEVENT(loc_oAba1.cmd_4c_Bot_Consulta, "Click", THIS, "BtnConsultaVendasClick")
1215: 
1216:         *-- Command12 -> cmd_4c_Command12 (botao "..." - abre o seletor de
1217:         *-- arquivo XML; sem Picture no legado, so texto)
1218:         loc_oAba1.AddObject("cmd_4c_Command12", "CommandButton")
1219:         WITH loc_oAba1.cmd_4c_Command12
1220:             .Caption   = "..."
1221:             .Top       = 157
1222:             .Left      = 667
1223:             .Width     = 20
1224:             .Height    = 20
1225:             .FontName  = "Tahoma"
1226:             .FontSize  = 8
1227:             .FontBold  = .T.
1228:             .ForeColor = RGB(90, 90, 90)
1229:             .BackColor = RGB(255, 255, 255)
1230:             .Themes    = .F.
1231:         ENDWITH
1232:         BINDEVENT(loc_oAba1.cmd_4c_Command12, "Click", THIS, "SelecionarArquivoXmlClick")
1233: 
1234:         *-- cmdOperacao -> obj_4c_CmdOperacao (CommandGroup com 1 botao -
1235:         *-- "Movimento"; legado usa PROCEDURE btnOperacao.Valid, mas o unico
1236:         *-- disparo real e o clique - migrado para Click do proprio botao)
1237:         loc_oAba1.AddObject("obj_4c_CmdOperacao", "CommandGroup")
1238:         WITH loc_oAba1.obj_4c_CmdOperacao
1239:             .ButtonCount = 1
1240:             .AutoSize    = .T.
1241:             .Top         = 334
1242:             .Left        = 857
1243:             .Width       = 85
1244:             .Height      = 85
1245:             .BackStyle   = 0
1246:             .BorderStyle = 0
1247:             .Value       = 1
1248:         ENDWITH
1249:         WITH loc_oAba1.obj_4c_CmdOperacao.Buttons(1)
1250:             .Top             = 5
1251:             .Left            = 5
1252:             .Width           = 75
1253:             .Height          = 75
1254:             .Picture         = gc_4c_CaminhoIcones + "geral_pastas_60.jpg"
1255:             .PicturePosition = 13
1256:             .Caption         = "Movimento"
1257:             .ToolTipText     = "Movimenta" + CHR(231) + CHR(227) + "o"
1258:             .FontName        = "Comic Sans MS"
1259:             .FontSize        = 8
1260:             .FontBold        = .T.
1261:             .FontItalic      = .T.
1262:             .ForeColor       = RGB(90, 90, 90)
1263:             .BackColor       = RGB(255, 255, 255)
1264:             .Themes          = .F.
1265:         ENDWITH
1266:         BINDEVENT(loc_oAba1.obj_4c_CmdOperacao.Buttons(1), "Click", THIS, "AbrirMovimentoSelecionado")
1267: 
1268:         *-- ===================================================================
1269:         *-- Aba Movimentacoes (legado: Pagina.Dados.Pageframe1.Page2) - campos
1270:         *-- de exibicao do produto selecionado na grade de distribuicao
1271:         *-- (grdDisponivel/grdItemXml - grids entram em fase posterior).
1272:         *-- Coordenadas ORIGINAIS do SCX (Pageframe1 tem Tabs=.T., sem a
1273:         *-- compensacao +29 do pgf_4c_Paginas externo).
1274:         *-- ===================================================================
1275:         loc_oAba2 = loc_oPagina.pgf_4c_Detalhes.Page2
1276: 
1277:         *-- lbl_produto "Procurar Produto :"
1278:         loc_oAba2.AddObject("lbl_4c_ProcurarProduto", "Label")
1279:         WITH loc_oAba2.lbl_4c_ProcurarProduto
1280:             .Caption   = "Procurar Produto :"
1281:             .Top       = 74
1282:             .Left      = 8
1283:             .Width     = 91
1284:             .Height    = 15
1285:             .Alignment = 0
1286:             .AutoSize  = .F.
1287:             .BackStyle = 0
1288:             .FontName  = "Tahoma"
1289:             .FontSize  = 8
1290:             .ForeColor = RGB(90, 90, 90)
1291:         ENDWITH
1292: 
1293:         *-- get_produto_inicial -> txt_4c_ProdutoInicial (busca na grade
1294:         *-- crMovimentos/grd_4c_Disponivel - entra em fase posterior)
1295:         loc_oAba2.AddObject("txt_4c_ProdutoInicial", "TextBox")
1296:         WITH loc_oAba2.txt_4c_ProdutoInicial
1297:             .Top           = 90
1298:             .Left          = 8
1299:             .Width         = 108
1300:             .Height        = 21
1301:             .FontName      = "Tahoma"
1302:             .FontSize      = 8
1303:             .Format        = "K!"
1304:             .MaxLength     = 14
1305:             .SpecialEffect = 1
1306:             .ForeColor     = RGB(0, 0, 0)
1307:             .Value         = ""
1308:         ENDWITH
1309:         BINDEVENT(loc_oAba2.txt_4c_ProdutoInicial, "LostFocus", THIS, "ProcurarProdutoNaGrade")
1310: 
1311:         *-- Sistema - barra de titulo acima da grd_4c_Disponivel (fase posterior)
1312:         loc_oAba2.AddObject("txt_4c_Sistema", "TextBox")
1313:         WITH loc_oAba2.txt_4c_Sistema
1314:             .Top       = 113
1315:             .Left      = 8
1316:             .Width     = 684
1317:             .Height    = 20
1318:             .Alignment = 2
1319:             .FontName  = "Tahoma"
1320:             .FontSize  = 8
1321:             .FontBold  = .T.
1322:             .BackColor = RGB(128, 255, 255)
1323:             .ForeColor = RGB(0, 0, 0)
1324:             .ReadOnly  = .T.
1325:             .Value     = "Sistema"
1326:         ENDWITH
1327: 
1328:         *-- Arquivo - barra de titulo acima da grd_4c_ItemXml (fase posterior)
1329:         loc_oAba2.AddObject("txt_4c_ArquivoHeader", "TextBox")
1330:         WITH loc_oAba2.txt_4c_ArquivoHeader
1331:             .Top       = 113
1332:             .Left      = 691
1333:             .Width     = 495
1334:             .Height    = 20
1335:             .Alignment = 2
1336:             .FontName  = "Tahoma"
1337:             .FontSize  = 8
1338:             .FontBold  = .T.
1339:             .BackColor = RGB(255, 255, 128)
1340:             .ForeColor = RGB(0, 0, 0)
1341:             .ReadOnly  = .T.
1342:             .Value     = "Arquivo"
1343:         ENDWITH
1344: 
1345:         *-- Say3 "Movimentacao :"
1346:         loc_oAba2.AddObject("lbl_4c_MovimentacaoDetalhe", "Label")
1347:         WITH loc_oAba2.lbl_4c_MovimentacaoDetalhe
1348:             .Caption   = "Movimenta" + CHR(231) + CHR(227) + "o :"
1349:             .Top       = 483

*-- Linhas 1644 a 1701:
1644: 
1645:         THIS.ConfigurarPgPage2()
1646: 
1647:         THIS.TornarControlesVisiveis(loc_oPagina)
1648:     ENDPROC
1649: 
1650:     *===========================================================================
1651:     * ConfigurarPgPage2 - Restante da aba Movimentacoes (legado: Pagina.Dados.
1652:     * Pageframe1.Page2) - Shape5 (moldura decorativa da foto), os grids
1653:     * grd_4c_Disponivel/grd_4c_ItemXml (legado: grdDisponivel/grdItemXml),
1654:     * img_4c_FigJpg (foto do produto) e os botoes de exclusao de linha
1655:     * (btnExcluirSis/btnExcluirArq). Os demais controles desta aba (labels e
1656:     * TextBox de exibicao) ja foram criados em ConfigurarPaginaDados.
1657:     * ControlSource dos grids NAO e atribuido aqui - crMovimentos/crDistribui
1658:     * ainda nao existem neste ponto do Init (regra #41); e feito em
1659:     * ExecutarProcessamentoXml, quando os cursores ja foram criados.
1660:     *===========================================================================
1661:     PROTECTED PROCEDURE ConfigurarPgPage2()
1662:         LOCAL loc_oAba2, loc_oGrid
1663:         loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
1664: 
1665:         *-- Shape5 - moldura ao redor da foto do produto (FigJpg)
1666:         loc_oAba2.AddObject("shp_4c_Shape5", "Shape")
1667:         WITH loc_oAba2.shp_4c_Shape5
1668:             .Top         = 1
1669:             .Left        = 424
1670:             .Width       = 282
1671:             .Height      = 113
1672:             .BackStyle   = 0
1673:             .BorderStyle = 1
1674:             .BorderWidth = 2
1675:             .SpecialEffect = 0
1676:         ENDWITH
1677: 
1678:         *-- grdDisponivel -> grd_4c_Disponivel (movimentos disponiveis para
1679:         *-- distribuicao - crMovimentos, populado em ExecutarProcessamentoXml)
1680:         loc_oAba2.AddObject("grd_4c_Disponivel", "Grid")
1681:         loc_oGrid = loc_oAba2.grd_4c_Disponivel
1682:         loc_oGrid.Top                = 134
1683:         loc_oGrid.Left               = 8
1684:         loc_oGrid.Width              = 684
1685:         loc_oGrid.Height             = 344
1686:         loc_oGrid.ColumnCount        = 7
1687:         loc_oGrid.FontName           = "Tahoma"
1688:         loc_oGrid.FontSize           = 8
1689:         loc_oGrid.ReadOnly           = .T.
1690:         loc_oGrid.RecordMark         = .F.
1691:         loc_oGrid.RowHeight          = 17
1692:         loc_oGrid.BackColor          = RGB(237, 242, 243)
1693:         loc_oGrid.GridLineColor      = RGB(238, 238, 238)
1694:         loc_oGrid.HighlightForeColor = RGB(15, 41, 104)
1695:         loc_oGrid.HighlightStyle     = 2
1696:         WITH loc_oGrid
1697:             .Column1.Width             = 100
1698:             .Column1.Movable           = .F.
1699:             .Column1.Resizable         = .F.
1700:             .Column1.ReadOnly          = .T.
1701:             .Column1.ForeColor         = RGB(0, 0, 255)

*-- Linhas 1771 a 1815:
1771:             .Column7.Header1.Caption   = "Saldo"
1772:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
1773:         ENDWITH
1774:         BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "AtualizarDetalhesProdutoSelecionado")
1775:         BINDEVENT(loc_oGrid.Column1.Text1, "DblClick", THIS, "AbrirPesquisaGlobalProduto")
1776: 
1777:         *-- grdItemXml -> grd_4c_ItemXml (produtos distribuidos - crDistribui,
1778:         *-- populado em ExecutarProcessamentoXml). Column3 (Quantidade) e a
1779:         *-- UNICA editavel - o legado nao marca ReadOnly/Enabled nela.
1780:         loc_oAba2.AddObject("grd_4c_ItemXml", "Grid")
1781:         loc_oGrid = loc_oAba2.grd_4c_ItemXml
1782:         loc_oGrid.Top           = 134
1783:         loc_oGrid.Left          = 693
1784:         loc_oGrid.Width         = 493
1785:         loc_oGrid.Height        = 344
1786:         loc_oGrid.ColumnCount   = 4
1787:         loc_oGrid.FontName      = "Tahoma"
1788:         loc_oGrid.FontSize      = 8
1789:         loc_oGrid.RecordMark    = .F.
1790:         loc_oGrid.RowHeight     = 17
1791:         loc_oGrid.BackColor     = RGB(237, 242, 243)
1792:         loc_oGrid.GridLineColor = RGB(238, 238, 238)
1793:         WITH loc_oGrid
1794:             .Column1.Enabled           = .F.
1795:             .Column1.Width             = 100
1796:             .Column1.Movable           = .F.
1797:             .Column1.Resizable         = .F.
1798:             .Column1.ReadOnly          = .T.
1799:             .Column1.ForeColor         = RGB(0, 0, 0)
1800:             .Column1.BackColor         = RGB(237, 242, 243)
1801:             .Column1.Header1.Alignment = 2
1802:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
1803:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
1804: 
1805:             .Column2.Enabled           = .F.
1806:             .Column2.Width             = 235
1807:             .Column2.Movable           = .F.
1808:             .Column2.Resizable         = .F.
1809:             .Column2.ReadOnly          = .T.
1810:             .Column2.ForeColor         = RGB(0, 0, 0)
1811:             .Column2.BackColor         = RGB(237, 242, 243)
1812:             .Column2.Header1.Alignment = 2
1813:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
1814:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
1815: 

*-- Linhas 1845 a 2340:
1845:             .Stretch   = 1
1846:             .Visible   = .F.
1847:         ENDWITH
1848:         BINDEVENT(loc_oAba2.img_4c_FigJpg, "DblClick", THIS, "FigJpgDblClick")
1849: 
1850:         *-- btnExcluirSis -> cmd_4c_BtnExcluirSis (exclui linha de crMovimentos)
1851:         loc_oAba2.AddObject("cmd_4c_BtnExcluirSis", "CommandButton")
1852:         WITH loc_oAba2.cmd_4c_BtnExcluirSis
1853:             .Caption     = ""
1854:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1855:             .Top         = 479
1856:             .Left        = 663
1857:             .Width       = 40
1858:             .Height      = 37
1859:             .FontName    = "Arial"
1860:             .FontSize    = 7
1861:             .ForeColor   = RGB(255, 0, 0)
1862:             .BackColor   = RGB(255, 255, 255)
1863:             .Themes      = .F.
1864:             .TabStop     = .F.
1865:             .ToolTipText = "Excluir Linha da Grade Sistema"
1866:         ENDWITH
1867:         BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirSis, "Click", THIS, "BtnExcluirSisClick")
1868: 
1869:         *-- btnExcluirArq -> cmd_4c_BtnExcluirArq (exclui linha de crDistribui)
1870:         loc_oAba2.AddObject("cmd_4c_BtnExcluirArq", "CommandButton")
1871:         WITH loc_oAba2.cmd_4c_BtnExcluirArq
1872:             .Caption     = ""
1873:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1874:             .Top         = 479
1875:             .Left        = 1146
1876:             .Width       = 40
1877:             .Height      = 37
1878:             .FontName    = "Arial"
1879:             .FontSize    = 7
1880:             .ForeColor   = RGB(255, 0, 0)
1881:             .BackColor   = RGB(255, 255, 255)
1882:             .Themes      = .F.
1883:             .TabStop     = .F.
1884:             .ToolTipText = "Excluir Linha da Grade Arquivo"
1885:         ENDWITH
1886:         BINDEVENT(loc_oAba2.cmd_4c_BtnExcluirArq, "Click", THIS, "BtnExcluirArqClick")
1887:     ENDPROC
1888: 
1889:     *===========================================================================
1890:     * MontaGrade - Popula grd_4c_Estoque com os movimentos distribuiveis
1891:     * (legado: PROCEDURE montagrade). Chamada ao final das validacoes de
1892:     * Conta/Grupo/Cpf (ThisForm.Montagrade(.T.)) para filtrar pela conta do
1893:     * fornecedor digitado.
1894:     *===========================================================================
1895:     PROCEDURE MontaGrade(par_lFiltra)
1896:         LOCAL loc_oGrid, loc_cConta, loc_cSQL, loc_nResultado, loc_lResultado
1897:         loc_lResultado = .F.
1898: 
1899:         TRY
1900:             loc_oGrid  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
1901:             loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.txt_4c_Conta.Value)
1902: 
1903:             loc_oGrid.RecordSource = ""
1904: 
1905:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
1906:                 SELECT 0 AS nMarca, a.Emps, a.Dopes, a.Numes,
1907:                     a.EmpDopNums AS OriDopNums, a.grupoOs AS Grupos, a.contaOs AS Contas
1908:                 FROM SigMvCab a
1909:                 JOIN SigCdOpe b ON a.dopes = b.dopes
1910:                 JOIN SigOpCdd c ON b.dopes = c.dopes
1911:                 WHERE c.Distribui = 3
1912:                     AND a.chksubn = 0
1913:                     AND a.GrupoOs <> SPACE(10) AND a.ContaOs <> SPACE(10)
1914:                     <<IIF(par_lFiltra AND !EMPTY(loc_cConta), " AND a.ContaOs = " + EscaparSQL(loc_cConta), "")>>
1915:             ENDTEXT
1916: 
1917:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Estoque")
1918: 
1919:             IF loc_nResultado >= 0
1920:                 loc_oGrid.ColumnCount            = 5
1921:                 loc_oGrid.RecordSource           = "cursor_4c_Estoque"
1922:                 loc_oGrid.Column1.ControlSource  = "cursor_4c_Estoque.Emps"
1923:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Estoque.Dopes"
1924:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Estoque.Numes"
1925:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Estoque.Grupos"
1926:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Estoque.Contas"
1927: 
1928:                 loc_oGrid.Column1.Header1.Caption = "Empresa"
1929:                 loc_oGrid.Column2.Header1.Caption = "Movimenta" + CHR(231) + CHR(227) + "o"
1930:                 loc_oGrid.Column3.Header1.Caption = "Numero"
1931:                 loc_oGrid.Column4.Header1.Caption = "Grupo"
1932:                 loc_oGrid.Column5.Header1.Caption = "Conta"
1933: 
1934:                 loc_oGrid.Column1.Width = 70
1935:                 loc_oGrid.Column2.Width = 200
1936:                 loc_oGrid.Column3.Width = 80
1937:                 loc_oGrid.Column4.Width = 80
1938:                 loc_oGrid.Column5.Width = 80
1939: 
1940:                 IF USED("cursor_4c_Estoque")
1941:                     GO TOP IN cursor_4c_Estoque
1942:                 ENDIF
1943:                 loc_oGrid.Refresh()
1944:                 loc_lResultado = .T.
1945:             ELSE
1946:                 MsgErro("Erro ao montar grade de estoque:" + CHR(13) + CapturarErroSQL(), "MontaGrade")
1947:             ENDIF
1948:         CATCH TO loException
1949:             MostrarErro(loException, "FormSigPrCtr.MontaGrade")
1950:         ENDTRY
1951: 
1952:         RETURN loc_lResultado
1953:     ENDPROC
1954: 
1955:     *===========================================================================
1956:     * OrdenarEstoquePorEmpresa/Movimentacao/Numero/Grupo/Conta - Header1.Click
1957:     * das colunas do grd_4c_Estoque (legado: grdEstoque.ColumnN.Header1.Click)
1958:     *===========================================================================
1959:     PROCEDURE OrdenarEstoquePorCampo(par_cCampo, par_nColuna)
1960:         LOCAL loc_oGrid, loc_nI
1961:         TRY
1962:             IF USED("cursor_4c_Estoque")
1963:                 SELECT cursor_4c_Estoque
1964:                 INDEX ON &par_cCampo TAG (par_cCampo)
1965:             ENDIF
1966: 
1967:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.grd_4c_Estoque
1968:             FOR loc_nI = 1 TO loc_oGrid.ColumnCount
1969:                 loc_oGrid.Columns(loc_nI).Header1.BackColor = IIF(loc_nI = par_nColuna, ;
1970:                     RGB(251, 253, 176), RGB(192, 192, 192))
1971:             ENDFOR
1972:             loc_oGrid.Refresh()
1973:         CATCH TO loException
1974:             MostrarErro(loException, "FormSigPrCtr.OrdenarEstoquePorCampo")
1975:         ENDTRY
1976:     ENDPROC
1977: 
1978:     PROCEDURE OrdenarEstoquePorEmpresa()
1979:         THIS.OrdenarEstoquePorCampo("Emps", 1)
1980:     ENDPROC
1981: 
1982:     PROCEDURE OrdenarEstoquePorMovimentacao()
1983:         THIS.OrdenarEstoquePorCampo("Dopes", 2)
1984:     ENDPROC
1985: 
1986:     PROCEDURE OrdenarEstoquePorNumero()
1987:         THIS.OrdenarEstoquePorCampo("Numes", 3)
1988:     ENDPROC
1989: 
1990:     PROCEDURE OrdenarEstoquePorGrupo()
1991:         THIS.OrdenarEstoquePorCampo("Grupos", 4)
1992:     ENDPROC
1993: 
1994:     PROCEDURE OrdenarEstoquePorConta()
1995:         THIS.OrdenarEstoquePorCampo("Contas", 5)
1996:     ENDPROC
1997: 
1998:     *===========================================================================
1999:     * SelecionarArquivoXmlClick - Click de cmd_4c_Command12 (legado: Command12.
2000:     * Click) - abre o seletor de arquivo nativo do Windows e grava o caminho
2001:     * escolhido em txt_4c_Arquivo.
2002:     *===========================================================================
2003:     PROCEDURE SelecionarArquivoXmlClick()
2004:         LOCAL loc_oPagina, loc_cArquivo
2005:         TRY
2006:             loc_oPagina  = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2007:             loc_cArquivo = GETFILE("XML")
2008: 
2009:             IF !EMPTY(loc_cArquivo)
2010:                 loc_oPagina.txt_4c_Arquivo.Value = loc_cArquivo
2011:             ENDIF
2012:         CATCH TO loException
2013:             MostrarErro(loException, "FormSigPrCtr.SelecionarArquivoXmlClick")
2014:         ENDTRY
2015:     ENDPROC
2016: 
2017:     *===========================================================================
2018:     * BtnCadastrosContaClick - Click de cmd_4c_BtnCadastros (legado:
2019:     * btnCadastros.Click) - abre o Cadastro de Contas (SIGCDCTA -> FormCTA) da
2020:     * conta digitada. Show() FORA do TRY (CLAUDE.md #29 - FormCTA e modal).
2021:     *===========================================================================
2022:     PROCEDURE BtnCadastrosContaClick()
2023:         LOCAL loc_oPagina, loc_oForm, loc_oErro
2024:         loc_oForm = .NULL.
2025: 
2026:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2027: 
2028:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2029:             MsgAviso(CHR(201) + " Necess" + CHR(225) + "rio o Preenchimento Da Conta!!!", "Dados Incompletos")
2030:             loc_oPagina.txt_4c_Conta.SetFocus()
2031:         ELSE
2032:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
2033:                 TRY
2034:                     loc_oForm = CREATEOBJECT("FormCTA")
2035:                 CATCH TO loc_oErro
2036:                     MsgErro("Erro ao abrir o Cadastro de Contas:" + CHR(13) + loc_oErro.Message, "Cadastro de Contas")
2037:                     loc_oForm = .NULL.
2038:                 ENDTRY
2039: 
2040:                 IF VARTYPE(loc_oForm) = "O"
2041:                     loc_oForm.Show()
2042:                 ENDIF
2043:             ENDIF
2044:         ENDIF
2045:     ENDPROC
2046: 
2047:     *===========================================================================
2048:     * BtnConsultaVendasClick - Click de cmd_4c_Bot_Consulta (legado:
2049:     * Bot_Consulta.Click) - abriria a Consulta Generica de Vendas (SigOpCgv)
2050:     * da conta digitada. SigOpCgv NAO foi migrada (nao existe FormSigOpCgv no
2051:     * acervo) - degrada graciosamente com aviso, mesmo padrao ja usado em
2052:     * FormSigMvSbn para SigOpZom/SigRePhi. Show() FORA do TRY (CLAUDE.md #29).
2053:     *===========================================================================
2054:     PROCEDURE BtnConsultaVendasClick()
2055:         LOCAL loc_oPagina, loc_oForm, loc_oErro
2056: 
2057:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2058: 
2059:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2060:             MsgAviso(CHR(201) + " necess" + CHR(225) + "rio o preenchimento da Conta...", "Aviso")
2061:             loc_oPagina.txt_4c_Conta.SetFocus()
2062:             RETURN
2063:         ENDIF
2064: 
2065:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2066:             RETURN
2067:         ENDIF
2068: 
2069:         loc_oForm = .NULL.
2070:         TRY
2071:             loc_oForm = CREATEOBJECT("FormSigOpCgv", THIS, ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2072:         CATCH TO loc_oErro
2073:             loc_oForm = .NULL.
2074:         ENDTRY
2075: 
2076:         IF VARTYPE(loc_oForm) = "O"
2077:             loc_oForm.Show()
2078:         ELSE
2079:             MsgAviso("M" + CHR(243) + "dulo de Consulta Gen" + CHR(233) + "rica de Vendas (SigOpCgv) ainda n" + CHR(227) + ;
2080:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
2081:         ENDIF
2082:     ENDPROC
2083: 
2084:     *===========================================================================
2085:     * AbrirMovimentoSelecionado - Click do botao "Movimento" de
2086:     * obj_4c_CmdOperacao (legado: cmdOperacao.btnOperacao.Valid - o unico
2087:     * disparo real e o clique) - abre a movimentacao da linha atual de
2088:     * grd_4c_Estoque (Expedicao/SigCdOpe ou Producao/SigCdOpd). Show() FORA
2089:     * do TRY (CLAUDE.md #29 - FormSigMvExp/FormSigMvPdt sao modais).
2090:     *===========================================================================
2091:     PROCEDURE AbrirMovimentoSelecionado()
2092:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_nResultado, loc_cClasseForm, ;
2093:             loc_oForm, loc_oErro
2094:         loc_cClasseForm = ""
2095: 
2096:         TRY
2097:             IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque") ;
2098:                     OR EMPTY(ALLTRIM(NVL(cursor_4c_Estoque.Emps, ""))) ;
2099:                     OR EMPTY(ALLTRIM(NVL(cursor_4c_Estoque.Dopes, "")))
2100:                 MsgAviso("Selecione Um Registro Na Grade!!!", "Aten" + CHR(231) + CHR(227) + "o!!!")
2101:             ELSE
2102:                 loc_cEmps  = ALLTRIM(cursor_4c_Estoque.Emps)
2103:                 loc_cDopes = ALLTRIM(cursor_4c_Estoque.Dopes)
2104:                 loc_nNumes = cursor_4c_Estoque.Numes
2105: 
2106:                 IF USED("cursor_4c_TmpOpe")
2107:                     USE IN cursor_4c_TmpOpe
2108:                 ENDIF
2109:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2110:                     "SELECT Dopes FROM SigCdOpe WHERE Dopes = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpe")
2111: 
2112:                 IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpe") AND RECCOUNT("cursor_4c_TmpOpe") > 0
2113:                     loc_cClasseForm = "FormSigMvExp"
2114:                 ELSE
2115:                     IF USED("cursor_4c_TmpOpd")
2116:                         USE IN cursor_4c_TmpOpd
2117:                     ENDIF
2118:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2119:                         "SELECT Dopps FROM SigCdOpd WHERE Dopps = " + EscaparSQL(loc_cDopes), "cursor_4c_TmpOpd")
2120: 
2121:                     IF loc_nResultado > 0 AND USED("cursor_4c_TmpOpd") AND RECCOUNT("cursor_4c_TmpOpd") > 0
2122:                         loc_cClasseForm = "FormSigMvPdt"
2123:                     ENDIF
2124:                 ENDIF
2125: 
2126:                 IF USED("cursor_4c_TmpOpe")
2127:                     USE IN cursor_4c_TmpOpe
2128:                 ENDIF
2129:                 IF USED("cursor_4c_TmpOpd")
2130:                     USE IN cursor_4c_TmpOpd
2131:                 ENDIF
2132:             ENDIF
2133:         CATCH TO loException
2134:             MostrarErro(loException, "FormSigPrCtr.AbrirMovimentoSelecionado")
2135:         ENDTRY
2136: 
2137:         IF !EMPTY(loc_cClasseForm)
2138:             loc_oForm = .NULL.
2139:             TRY
2140:                 loc_oForm = CREATEOBJECT(loc_cClasseForm, loc_cDopes, "C", loc_nNumes, loc_cEmps, .T.)
2141:             CATCH TO loc_oErro
2142:                 MsgErro("Erro ao abrir movimenta" + CHR(231) + CHR(227) + "o:" + CHR(13) + loc_oErro.Message, ;
2143:                     "Movimenta" + CHR(231) + CHR(227) + "o")
2144:                 loc_oForm = .NULL.
2145:             ENDTRY
2146: 
2147:             IF VARTYPE(loc_oForm) = "O"
2148:                 loc_oForm.Show()
2149:             ENDIF
2150:         ENDIF
2151:     ENDPROC
2152: 
2153:     *===========================================================================
2154:     * CriarCursoresXml - Cursores de trabalho do import de XML (legado: Load
2155:     * do SCX - csPrNAOCad/crItens/crResultado). Mantidos com os nomes
2156:     * ORIGINAIS do legado (sem prefixo cursor_4c_) - mesma convencao ja usada
2157:     * neste form para crMovimentos/crDistribui (ProcurarProdutoNaGrade).
2158:     *===========================================================================
2159:     PROTECTED PROCEDURE CriarCursoresXml()
2160:         IF !USED("csPrNAOCad")
2161:             CREATE CURSOR csPrNAOCad (Referencia C(25), Unidade C(3), Qtds N(12,2), Pesos N(12,2), Valor N(12,2))
2162:         ENDIF
2163: 
2164:         IF !USED("crItens")
2165:             CREATE CURSOR crItens (codigo C(15), Descr C(30), quant C(15), valor_uni C(15), valor_tot C(15), ;
2166:                 base_icm C(15), valor_icm C(15), aliq_icm C(15), base_ipi C(15), valor_ipi C(15), aliq_ipi C(15), ;
2167:                 unid C(5), cfop C(4), ncm C(8), desconto C(15), frete C(15))
2168:         ENDIF
2169: 
2170:         IF !USED("crResultado")
2171:             CREATE CURSOR crResultado (xTp C(1), cpros C(14), dpros C(60), Qtds N(12,2), Units N(12,2), Total N(12,2))
2172:         ENDIF
2173:     ENDPROC
2174: 
2175:     *===========================================================================
2176:     * CarregarArquivosXml - Confere o CPF/CNPJ do fornecedor contra a chave de
2177:     * acesso do XML e decide se prossegue com a leitura (legado: PROCEDURE
2178:     * carregaarquivos - o parametro pTipo legado so controla se Lerxml roda).
2179:     *===========================================================================
2180:     PROTECTED PROCEDURE CarregarArquivosXml(par_lProcessar)
2181:         LOCAL loc_oPagina, loc_cArquivo, loc_cCgc, loc_cConteudo, loc_cChave, ;
2182:             loc_cCgcXml, loc_lOk, loc_cMsg
2183: 
2184:         loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2185: 
2186:         IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2187:             MsgAviso("Favor Informar uma Conta.", "Aviso")
2188:             RETURN .F.
2189:         ENDIF
2190: 
2191:         loc_cArquivo = loc_oPagina.txt_4c_Arquivo.Value
2192:         loc_cCgc     = ALLTRIM(STRTRAN(STRTRAN(STRTRAN(loc_oPagina.txt_4c_Cpf.Value, ".", ""), "/", ""), "-", ""))
2193: 
2194:         IF ALLTRIM(UPPER(RIGHT(JUSTFNAME(loc_cArquivo), 3))) != "XML"
2195:             MsgAviso("Arquivo est" + CHR(225) + " em formato diferente de XML.", "Aviso")
2196:             RETURN .F.
2197:         ENDIF
2198: 
2199:         IF !EMPTY(loc_cArquivo) AND !EMPTY(loc_cCgc)
2200:             loc_cArquivo  = ALLTRIM(loc_cArquivo)
2201:             loc_cConteudo = ALLTRIM(UPPER(FILETOSTR(loc_cArquivo)))
2202: 
2203:             IF !EMPTY(loc_cConteudo)
2204:                 loc_cChave  = ALLTRIM(STREXTRACT(loc_cConteudo, "<CHNFE>", "</CHNFE>"))
2205:                 loc_cCgcXml = SUBSTR(loc_cChave, 7, 14)
2206:                 loc_lOk     = .T.
2207: 
2208:                 IF loc_cCgcXml != loc_cCgc
2209:                     loc_lOk  = .F.
2210:                     loc_cMsg = "Fornecedor com CPF/CNPJ Diferente do XML," + CHR(13) + ;
2211:                         "Arquivo XML: " + loc_cCgcXml + CHR(13) + ;
2212:                         "Fornecedor: " + loc_cCgc + CHR(13) + ;
2213:                         "Deseja Continuar?"
2214:                     IF MsgConfirma(loc_cMsg, "Aten" + CHR(231) + CHR(227) + "o")
2215:                         loc_lOk = .T.
2216:                     ENDIF
2217:                 ENDIF
2218: 
2219:                 IF loc_lOk AND par_lProcessar
2220:                     THIS.LerArquivoXml(loc_cArquivo)
2221:                 ENDIF
2222:             ENDIF
2223:         ENDIF
2224: 
2225:         RETURN .T.
2226:     ENDPROC
2227: 
2228:     *===========================================================================
2229:     * LerArquivoXml - Le o XML de NF-e e popula crItens com os itens do
2230:     * documento (legado: PROCEDURE lerxml). Os demais campos do cabecalho
2231:     * (emitente/destinatario/impostos totais) sao extraidos no legado mas
2232:     * NUNCA referenciados em nenhum outro metodo do dump - leitura morta,
2233:     * omitida aqui (nao ha regra de negocio ativa a preservar).
2234:     *===========================================================================
2235:     PROTECTED PROCEDURE LerArquivoXml(par_cArquivo)
2236:         LOCAL loc_oXml, loc_oItem, loc_nQtdItens, loc_nI, loc_nContaDesconto, loc_lSucesso
2237:         loc_lSucesso = .F.
2238: 
2239:         IF EMPTY(par_cArquivo) OR !FILE(par_cArquivo)
2240:             RETURN .F.
2241:         ENDIF
2242: 
2243:         THIS.CriarCursoresXml()
2244: 
2245:         TRY
2246:             loc_oXml = CREATEOBJECT("MSXML.DOMDOCUMENT")
2247: 
2248:             IF !loc_oXml.Load(par_cArquivo)
2249:                 MsgErro(par_cArquivo + " est" + CHR(225) + " corrompido.", "Aviso")
2250:             ELSE
2251:                 IF UPPER(loc_oXml.DocumentElement.BaseName) = "NFEPROC"
2252:                     loc_nQtdItens      = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Length
2253:                     loc_nContaDesconto = 0
2254: 
2255:                     SELECT crItens
2256:                     FOR loc_nI = 0 TO loc_nQtdItens - 1
2257:                         loc_oItem = loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det").Item(loc_nI)
2258: 
2259:                         APPEND BLANK IN crItens
2260:                         REPLACE codigo    WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/cProd").ItemText, ;
2261:                                 Descr     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/xProd").ItemText, ;
2262:                                 quant     WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/qCom").ItemText, ;
2263:                                 valor_uni WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vUnCom").ItemText, ;
2264:                                 valor_tot WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vProd").ItemText, ;
2265:                                 unid      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/uCom").ItemText, ;
2266:                                 cfop      WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/CFOP").ItemText, ;
2267:                                 ncm       WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/NCM").ItemText ;
2268:                                 IN crItens
2269: 
2270:                         IF loc_oItem.SelectNodes("prod/vDesc").Length > 0
2271:                             REPLACE desconto WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vDesc").ItemText IN crItens
2272:                             loc_nContaDesconto = loc_nContaDesconto + 1
2273:                         ENDIF
2274: 
2275:                         IF loc_oItem.SelectNodes("prod/vFrete").Length > 0
2276:                             REPLACE frete WITH loc_oXml.SelectNodes("//nfeProc/NFe/infNFe/det/prod/vFrete").ItemText IN crItens
2277:                         ENDIF
2278:                     ENDFOR
2279: 
2280:                     loc_lSucesso = .T.
2281:                 ELSE
2282:                     MsgAviso(par_cArquivo + " n" + CHR(227) + "o " + CHR(233) + " uma nota fiscal com autoriza" + CHR(231) + CHR(227) + "o!", "Aviso")
2283:                 ENDIF
2284:             ENDIF
2285:         CATCH TO loException
2286:             MostrarErro(loException, "FormSigPrCtr.LerArquivoXml")
2287:         ENDTRY
2288: 
2289:         RETURN loc_lSucesso
2290:     ENDPROC
2291: 
2292:     *===========================================================================
2293:     * CarregarItensXmlNaGrade - Localiza cada item de crItens em SigCdPro
2294:     * (Reffs -> Cpros -> Dpros -> Dpro2s) e acumula o resultado em
2295:     * crResultado/csPrNAOCad (legado: PROCEDURE carregaritemxml). Os blocos
2296:     * de SigCdTam/SigCdCor do legado sao INALCANCAVEIS (lcTam/lcCor sao
2297:     * zerados incondicionalmente antes do IF que os testaria) - omitidos
2298:     * aqui, nao sao regra de negocio viva.
2299:     *===========================================================================
2300:     PROTECTED PROCEDURE CarregarItensXmlNaGrade()
2301:         LOCAL loc_cProd, loc_nQtds, loc_cCunis, loc_nVal, loc_nTot, loc_nBaseIcm, ;
2302:             loc_nValorIpi, loc_cTp, loc_nVariaProd, loc_nResultado, loc_cArquivoSaida
2303: 
2304:         IF !USED("crItens")
2305:             RETURN .F.
2306:         ENDIF
2307: 
2308:         TRY
2309:             SELECT crItens
2310:             GO TOP IN crItens
2311:             SCAN
2312:                 loc_cProd  = NVL(crItens.codigo, "")
2313:                 loc_nQtds  = IIF(TYPE("crItens.quant") = "N", NVL(crItens.quant, 0), VAL(NVL(crItens.quant, "")))
2314:                 loc_cCunis = IIF(INLIST(TYPE("crItens.unid"), "C", "M"), NVL(crItens.unid, ""), "")
2315:                 loc_nVal   = IIF(INLIST(TYPE("crItens.valor_uni"), "C", "M"), VAL(NVL(crItens.valor_uni, "")), ;
2316:                     IIF(TYPE("crItens.valor_uni") = "N", NVL(crItens.valor_uni, 0), 0))
2317:                 loc_nTot   = IIF(INLIST(TYPE("crItens.valor_tot"), "C", "M"), VAL(NVL(crItens.valor_tot, "")), ;
2318:                     IIF(TYPE("crItens.valor_tot") = "N", NVL(crItens.valor_tot, 0), 0))
2319:                 loc_nBaseIcm  = IIF(INLIST(TYPE("crItens.base_icm"), "C", "M"), VAL(NVL(crItens.base_icm, "")), ;
2320:                     IIF(TYPE("crItens.base_icm") = "N", NVL(crItens.base_icm, 0), 0))
2321:                 loc_nValorIpi = IIF(INLIST(TYPE("crItens.valor_ipi"), "C", "M"), VAL(NVL(crItens.valor_ipi, "")), ;
2322:                     IIF(TYPE("crItens.valor_ipi") = "N", NVL(crItens.valor_ipi, 0), 0))
2323: 
2324:                 IF !EMPTY(loc_cProd)
2325:                     IF USED("ProdImport")
2326:                         USE IN ProdImport
2327:                     ENDIF
2328:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2329:                         "SELECT * FROM SigCdPro WHERE Reffs = " + EscaparSQL(loc_cProd), "ProdImport")
2330:                     IF loc_nResultado < 1
2331:                         MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")
2332:                         LOOP
2333:                     ENDIF
2334: 
2335:                     IF RECCOUNT("ProdImport") = 0
2336:                         USE IN ProdImport
2337:                         loc_nResultado = SQLEXEC(gnConnHandle, ;
2338:                             "SELECT * FROM SigCdPro WHERE Cpros = " + EscaparSQL(loc_cProd), "ProdImport")
2339:                         IF loc_nResultado < 1
2340:                             MsgErro("Favor Reinicializar o Processo!!!", "Falha na Conex" + CHR(227) + "o (ProdImport)")

*-- Linhas 2421 a 2565:
2421:             GO TOP
2422:             IF RECCOUNT("csPrNAOCad") > 0
2423:                 loc_cArquivoSaida = ADDBS(SYS(5) + SYS(2003)) + "Produtos_Nao_Localizados"
2424:                 MsgAviso("Houve produtos n" + CHR(227) + "o Localizados" + CHR(13) + CHR(13) + ;
2425:                     "Arquivo : " + loc_cArquivoSaida + ".XLS", "Aten" + CHR(231) + CHR(227) + "o")
2426:                 SELECT csPrNAOCad
2427:                 COPY TO (loc_cArquivoSaida) XL5
2428:             ENDIF
2429:         ENDIF
2430: 
2431:         IF USED("crItens")
2432:             SELECT crItens
2433:             GO TOP
2434:         ENDIF
2435: 
2436:         RETURN .T.
2437:     ENDPROC
2438: 
2439:     *===========================================================================
2440:     * ProcessarArquivoXmlClick - Click de cmd_4c_Processar (legado: processar.
2441:     * Click) - valida Arquivo/Conta/Cpf preenchidos e delega o processamento.
2442:     *===========================================================================
2443:     PROCEDURE ProcessarArquivoXmlClick()
2444:         LOCAL loc_oPagina
2445:         TRY
2446:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2447: 
2448:             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Arquivo.Value))
2449:                 MsgAviso("Nenhum Diret" + CHR(243) + "rio Foi Informado.", "Aviso")
2450:             ELSE
2451:                 IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2452:                     MsgAviso("Nenhum Fornecedor Foi Informado.", "Aviso")
2453:                 ELSE
2454:                     IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cpf.Value))
2455:                         MsgAviso("CNPJ/CPF do Fornecedor N" + CHR(227) + "o Informado", "Aviso")
2456:                     ELSE
2457:                         THIS.ExecutarProcessamentoXml(loc_oPagina)
2458:                     ENDIF
2459:                 ENDIF
2460:             ENDIF
2461:         CATCH TO loException
2462:             MostrarErro(loException, "FormSigPrCtr.ProcessarArquivoXmlClick")
2463:         ENDTRY
2464:     ENDPROC
2465: 
2466:     *===========================================================================
2467:     * ExecutarProcessamentoXml - Orquestra o import do XML (legado: processar.
2468:     * Click, corpo principal): busca os movimentos distribuiveis da linha
2469:     * ATUAL de grd_4c_Estoque (legado nao faz SCAN - o bloco que somaria
2470:     * todas as linhas marcadas esta comentado no dump original, morto), le o
2471:     * XML/monta crResultado, agrupa em crDistribui, filtra crMovimentos por
2472:     * Opt_Filtro e converte a moeda de cada linha para a moeda base
2473:     * (SigCdPam.moedetqs) antes de exibir nos grids da aba Movimentacoes
2474:     * (grd_4c_Disponivel/grd_4c_ItemXml - concluidos na fase que fecha
2475:     * aquela aba).
2476:     *===========================================================================
2477:     PROTECTED PROCEDURE ExecutarProcessamentoXml(par_oPagina)
2478:         LOCAL loc_oAba2, loc_oGridDisp, loc_oGridItem, loc_nTipo, loc_cOriDopNums, ;
2479:             loc_cMoedaBase, loc_nCotaMoe, loc_cSQL, loc_nResultado, loc_nCotacao, loc_nUnits
2480: 
2481:         TRY
2482:             loc_oAba2     = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2483:             loc_oGridDisp = loc_oAba2.grd_4c_Disponivel
2484:             loc_oGridItem = loc_oAba2.grd_4c_ItemXml
2485: 
2486:             loc_nTipo = par_oPagina.opt_4c_Filtro.Value
2487: 
2488:             loc_oGridDisp.RecordSource = ""
2489:             loc_oGridItem.RecordSource = ""
2490: 
2491:             IF !USED("cursor_4c_Estoque") OR EOF("cursor_4c_Estoque")
2492:                 loc_cOriDopNums = ""
2493:             ELSE
2494:                 loc_cOriDopNums = cursor_4c_Estoque.OriDopNums
2495:             ENDIF
2496: 
2497:             loc_cMoedaBase = IIF(USED("crSigCdPam"), ALLTRIM(NVL(crSigCdPam.moedetqs, "")), "")
2498:             loc_nCotaMoe   = THIS.this_oBusinessObject.CarregarCambio(loc_cMoedaBase, DATE())
2499: 
2500:             TEXT TO loc_cSQL TEXTMERGE NOSHOW
2501:                 SELECT a.Cpros, f.Dpros, a.units,
2502:                     SUM(a.qtds) AS qtds, SUM(a.qtbaixas) AS qtbaixas, SUM(a.qtreservas) AS qtreservas,
2503:                     (SUM(a.qtds) - SUM(a.qtbaixas) - SUM(a.qtreservas)) AS Saldo,
2504:                     a.EmpDopNums AS OriDopNums, f.Cgrus, f.Sgrus, a.cidchaves, a.Moedas
2505:                 FROM SigMvItn a
2506:                 JOIN SigMvCab c ON a.EmpDopNums = c.EmpDopNums
2507:                 JOIN SigCdOpe d ON c.dopes = d.dopes
2508:                 JOIN SigOpCdd e ON d.dopes = e.dopes
2509:                 JOIN SigCdPro f ON a.Cpros = f.Cpros
2510:                 WHERE e.Distribui = 3
2511:                     AND c.GrupoOs <> SPACE(10)
2512:                     AND c.ContaOs <> SPACE(10)
2513:                     AND a.citem2 = 0
2514:                     AND a.qtds <> a.qtbaixas
2515:                     AND a.EmpDopNums IN (<<EscaparSQL(loc_cOriDopNums)>>)
2516:                 GROUP BY a.CPros, f.Dpros, f.Cgrus, f.Sgrus, a.EmpDopNums, a.units, a.cidchaves, a.Moedas
2517:             ENDTEXT
2518: 
2519:             IF USED("crMovimentos")
2520:                 USE IN crMovimentos
2521:             ENDIF
2522:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "crMovimentos")
2523: 
2524:             IF loc_nResultado < 1
2525:                 MsgAviso("Problemas no Select dos Produtos da Movimenta" + CHR(231) + CHR(227) + "o", "Aten" + CHR(231) + CHR(227) + "o")
2526:             ELSE
2527:                 SELECT crMovimentos
2528:                 INDEX ON Cgrus TAG Cgrus
2529:                 INDEX ON Cpros TAG Cpros
2530:                 SET ORDER TO Cpros
2531:                 GO TOP
2532: 
2533:                 THIS.CriarCursoresXml()
2534:                 SELECT crItens
2535:                 ZAP
2536:                 SELECT csPrNAOCad
2537:                 ZAP
2538:                 SELECT crResultado
2539:                 ZAP
2540: 
2541:                 THIS.CarregarArquivosXml(.T.)
2542:                 THIS.CarregarItensXmlNaGrade()
2543: 
2544:                 IF USED("crDistribui")
2545:                     USE IN crDistribui
2546:                 ENDIF
2547:                 SELECT Cpros, Dpros, SUM(Qtds) AS Qtds, MAX(Units) AS Units, SUM(Total) AS Total ;
2548:                     FROM crResultado ;
2549:                     GROUP BY Cpros, Dpros ;
2550:                     INTO CURSOR crDistribui READWRITE
2551: 
2552:                 SELECT crDistribui
2553:                 INDEX ON cPros TAG Tag1
2554:                 SET ORDER TO Tag1
2555: 
2556:                 loc_oGridItem.RecordSource          = "crDistribui"
2557:                 loc_oGridItem.Column1.ControlSource = "crDistribui.Cpros"
2558:                 loc_oGridItem.Column2.ControlSource = "crDistribui.Dpros"
2559:                 loc_oGridItem.Column3.ControlSource = "crDistribui.Qtds"
2560:                 loc_oGridItem.Column4.ControlSource = "crDistribui.Units"
2561: 
2562:                 *-- RecordSource reseta Header/Width para o default (regra #41c) -
2563:                 *-- reaplicar OS DOIS depois do ControlSource
2564:                 loc_oGridItem.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2565:                 loc_oGridItem.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 2631 a 2926:
2631:     * validada, preenche o Cpf e (se vazio) o Grupo, e recarrega a grade de
2632:     * estoque filtrada pela conta (ThisForm.Montagrade(.T.)).
2633:     *===========================================================================
2634:     PROTECTED PROCEDURE AtualizarCpfEGrupoPorConta(par_oPagina)
2635:         LOCAL loc_cConta, loc_nResultado
2636:         TRY
2637:             IF !EMPTY(ALLTRIM(par_oPagina.txt_4c_Conta.Value))
2638:                 loc_cConta = ALLTRIM(par_oPagina.txt_4c_Conta.Value)
2639: 
2640:                 IF USED("cursor_4c_TmpCli")
2641:                     USE IN cursor_4c_TmpCli
2642:                 ENDIF
2643:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2644:                     "SELECT Cpfs, Grupos FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta), ;
2645:                     "cursor_4c_TmpCli")
2646: 
2647:                 IF loc_nResultado >= 0 AND USED("cursor_4c_TmpCli") AND !EOF("cursor_4c_TmpCli")
2648:                     par_oPagina.txt_4c_Cpf.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Cpfs, ""))
2649:                     IF EMPTY(ALLTRIM(par_oPagina.txt_4c_Grupo.Value))
2650:                         par_oPagina.txt_4c_Grupo.Value = ALLTRIM(TratarNulo(cursor_4c_TmpCli.Grupos, ""))
2651:                     ENDIF
2652:                 ENDIF
2653: 
2654:                 IF USED("cursor_4c_TmpCli")
2655:                     USE IN cursor_4c_TmpCli
2656:                 ENDIF
2657: 
2658:                 THIS.MontaGrade(.T.)
2659:             ENDIF
2660:         CATCH TO loException
2661:             MostrarErro(loException, "FormSigPrCtr.AtualizarCpfEGrupoPorConta")
2662:         ENDTRY
2663:     ENDPROC
2664: 
2665:     *===========================================================================
2666:     * ValidarGrupoAcesso - LostFocus de txt_4c_Grupo (legado: Get_Grupo.Valid)
2667:     * fAcessoContab ja resolve o lookup (FormBuscaSimples) e preenche o
2668:     * proprio campo quando nao ha match exato.
2669:     *===========================================================================
2670:     PROCEDURE ValidarGrupoAcesso(par_nKeyCode, par_nShiftAltCtrl)
2671:         LOCAL loc_oPagina
2672:         TRY
2673:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2674:             fAcessoContab(gc_4c_UsuarioLogado, "C", loc_oPagina.txt_4c_Grupo.Value, ;
2675:                 loc_oPagina.txt_4c_Grupo, "", loc_oPagina.txt_4c_Conta.Value)
2676:         CATCH TO loException
2677:             MostrarErro(loException, "FormSigPrCtr.ValidarGrupoAcesso")
2678:         ENDTRY
2679:     ENDPROC
2680: 
2681:     *===========================================================================
2682:     * ValidarContaFornecedor - LostFocus de txt_4c_Conta (legado: Get_Conta.Valid)
2683:     *===========================================================================
2684:     PROCEDURE ValidarContaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
2685:         LOCAL loc_oPagina, loc_cGrupo
2686:         TRY
2687:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2688:             loc_cGrupo  = loc_oPagina.txt_4c_Grupo.Value
2689: 
2690:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
2691:                 IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", loc_oPagina.txt_4c_Conta.Value, ;
2692:                         loc_oPagina.txt_4c_Conta, loc_oPagina.txt_4c_Dconta)
2693:                     MsgErro("Acesso Negado!!!", "Aviso")
2694:                     loc_oPagina.txt_4c_Conta.Value  = ""
2695:                     loc_oPagina.txt_4c_Dconta.Value = ""
2696:                     loc_oPagina.txt_4c_Cpf.Value    = ""
2697:                 ENDIF
2698:             ELSE
2699:                 loc_oPagina.txt_4c_Dconta.Value = ""
2700:                 loc_oPagina.txt_4c_Cpf.Value    = ""
2701:             ENDIF
2702: 
2703:             THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
2704:         CATCH TO loException
2705:             MostrarErro(loException, "FormSigPrCtr.ValidarContaFornecedor")
2706:         ENDTRY
2707:     ENDPROC
2708: 
2709:     *===========================================================================
2710:     * ValidarDescricaoConta - LostFocus de txt_4c_Dconta (legado: Get_Dconta.Valid)
2711:     *===========================================================================
2712:     PROCEDURE ValidarDescricaoConta(par_nKeyCode, par_nShiftAltCtrl)
2713:         LOCAL loc_oPagina, loc_cGrupo
2714:         TRY
2715:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2716:             loc_cGrupo  = loc_oPagina.txt_4c_Grupo.Value
2717: 
2718:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Dconta.Value))
2719:                 IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "D", loc_oPagina.txt_4c_Dconta.Value, ;
2720:                         loc_oPagina.txt_4c_Conta, loc_oPagina.txt_4c_Dconta, .T., loc_cGrupo)
2721:                     MsgErro("Acesso Negado!!!", "Aviso")
2722:                     loc_oPagina.txt_4c_Dconta.Value = ""
2723:                     loc_oPagina.txt_4c_Conta.Value  = ""
2724:                     loc_oPagina.txt_4c_Cpf.Value    = ""
2725:                 ENDIF
2726:             ELSE
2727:                 loc_oPagina.txt_4c_Conta.Value = ""
2728:                 loc_oPagina.txt_4c_Cpf.Value   = ""
2729:             ENDIF
2730: 
2731:             THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
2732:         CATCH TO loException
2733:             MostrarErro(loException, "FormSigPrCtr.ValidarDescricaoConta")
2734:         ENDTRY
2735:     ENDPROC
2736: 
2737:     *===========================================================================
2738:     * ValidarCpfCnpjFornecedor - LostFocus de txt_4c_Cpf (legado: Get_cpf.Valid)
2739:     * Valida o digito verificador (fValidarCPF/fValidarCNPJ), localiza o
2740:     * fornecedor por Cpfs e confere acesso via fAcessoContas antes de
2741:     * preencher Conta/Dconta.
2742:     *===========================================================================
2743:     PROCEDURE ValidarCpfCnpjFornecedor(par_nKeyCode, par_nShiftAltCtrl)
2744:         LOCAL loc_oPagina, loc_cGrupo, loc_cCgc, loc_cCgcFmt, loc_nVerCpfCgc, loc_nResultado
2745:         TRY
2746:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2747: 
2748:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Cpf.Value))
2749:                 loc_cCgc = STRTRAN(STRTRAN(STRTRAN(loc_oPagina.txt_4c_Cpf.Value, ".", ""), "-", ""), "/", "")
2750:                 loc_nVerCpfCgc = 0
2751: 
2752:                 IF LEN(ALLTRIM(loc_cCgc)) != 14
2753:                     loc_cCgcFmt = TRANSFORM(loc_cCgc, "@R 999.999.999-99")
2754:                     IF LEN(ALLTRIM(loc_cCgc)) = 11
2755:                         loc_nVerCpfCgc = IIF(fValidarCPF(loc_cCgcFmt), 1, 2)
2756:                     ENDIF
2757:                 ELSE
2758:                     loc_cCgcFmt = TRANSFORM(loc_cCgc, "@R 99.999.999/9999-99")
2759:                     loc_nVerCpfCgc = IIF(fValidarCNPJ(loc_cCgcFmt), 1, 2)
2760:                 ENDIF
2761: 
2762:                 IF loc_nVerCpfCgc = 2
2763:                     MsgErro("CPF / CGC Incorreto !!!", "Aviso")
2764:                     loc_oPagina.txt_4c_Cpf.Value = ""
2765:                 ELSE
2766:                     IF USED("cursor_4c_BuscaCli")
2767:                         USE IN cursor_4c_BuscaCli
2768:                     ENDIF
2769:                     loc_nResultado = SQLEXEC(gnConnHandle, ;
2770:                         "SELECT IClis, RClis, Cpfs, Grupos FROM SigCdCli WHERE Cpfs = " + ;
2771:                         EscaparSQL(PADR(ALLTRIM(loc_cCgcFmt), 20)), "cursor_4c_BuscaCli")
2772: 
2773:                     IF loc_nResultado >= 0 AND USED("cursor_4c_BuscaCli") AND !EOF("cursor_4c_BuscaCli")
2774:                         loc_cGrupo = loc_oPagina.txt_4c_Grupo.Value
2775:                         IF !fAcessoContas(gc_4c_UsuarioLogado, loc_cGrupo, "C", ;
2776:                                 ALLTRIM(cursor_4c_BuscaCli.IClis), loc_oPagina.txt_4c_Conta.Value, loc_oPagina.txt_4c_Dconta.Value)
2777:                             MsgErro("Acesso Negado !!", "Aviso")
2778:                             loc_oPagina.txt_4c_Conta.Value  = ""
2779:                             loc_oPagina.txt_4c_Dconta.Value = ""
2780:                             loc_oPagina.txt_4c_Cpf.Value    = ""
2781:                         ELSE
2782:                             loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_BuscaCli.IClis)
2783:                             loc_oPagina.txt_4c_Dconta.Value = ALLTRIM(cursor_4c_BuscaCli.RClis)
2784:                             loc_oPagina.txt_4c_Cpf.Value    = ALLTRIM(cursor_4c_BuscaCli.Cpfs)
2785: 
2786:                             IF EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
2787:                                 loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(cursor_4c_BuscaCli.Grupos)
2788:                             ENDIF
2789: 
2790:                             THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
2791:                         ENDIF
2792:                     ELSE
2793:                         IF loc_nVerCpfCgc = 1
2794:                             MsgErro("CPF / CGC n" + CHR(227) + "o encontrado !!!", "Aviso")
2795:                         ENDIF
2796:                     ENDIF
2797: 
2798:                     IF USED("cursor_4c_BuscaCli")
2799:                         USE IN cursor_4c_BuscaCli
2800:                     ENDIF
2801:                 ENDIF
2802:             ELSE
2803:                 loc_oPagina.txt_4c_Dconta.Value = ""
2804:             ENDIF
2805:         CATCH TO loException
2806:             MostrarErro(loException, "FormSigPrCtr.ValidarCpfCnpjFornecedor")
2807:         ENDTRY
2808:     ENDPROC
2809: 
2810:     *===========================================================================
2811:     * ValidarMoedaFornecedor - LostFocus de txt_4c_Moeda (legado: Get_Moeda.Valid,
2812:     * fwbuscaext -> SigCdMoe). Padrao canonico FormBuscaAuxiliar: this_lAchouRegistro
2813:     * ANTES do Show(), this_lSelecionou antes de atribuir o valor (regra #37).
2814:     *===========================================================================
2815:     PROCEDURE ValidarMoedaFornecedor(par_nKeyCode, par_nShiftAltCtrl)
2816:         LOCAL loc_oPagina, loc_oBusca
2817:         TRY
2818:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
2819: 
2820:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Moeda.Value))
2821:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2822:                     "SigCdMoe", "cursor_4c_BuscaMoeda", "CMoes", ;
2823:                     ALLTRIM(loc_oPagina.txt_4c_Moeda.Value), "Sele" + CHR(231) + CHR(227) + "o")
2824: 
2825:                 IF VARTYPE(loc_oBusca) = "O"
2826:                     IF !loc_oBusca.this_lAchouRegistro
2827:                         loc_oBusca.mAddColuna("CMoes", "", "C" + CHR(243) + "digo")
2828:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
2829:                         loc_oBusca.Show()
2830:                     ENDIF
2831: 
2832:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoeda")
2833:                         loc_oPagina.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_BuscaMoeda.CMoes)
2834:                     ELSE
2835:                         loc_oPagina.txt_4c_Moeda.Value = ""
2836:                     ENDIF
2837: 
2838:                     loc_oBusca.Release()
2839:                 ENDIF
2840: 
2841:                 IF USED("cursor_4c_BuscaMoeda")
2842:                     USE IN cursor_4c_BuscaMoeda
2843:                 ENDIF
2844:             ELSE
2845:                 loc_oPagina.txt_4c_Moeda.Value = ""
2846:             ENDIF
2847:         CATCH TO loException
2848:             MostrarErro(loException, "FormSigPrCtr.ValidarMoedaFornecedor")
2849:         ENDTRY
2850:     ENDPROC
2851: 
2852:     *===========================================================================
2853:     * ProcurarProdutoNaGrade - LostFocus de txt_4c_ProdutoInicial (legado:
2854:     * get_produto_inicial.Valid) - localiza o produto digitado na grade de
2855:     * movimentos disponiveis (crMovimentos/grd_4c_Disponivel - populada na
2856:     * fase que adiciona os grids da aba Movimentacoes).
2857:     *===========================================================================
2858:     PROCEDURE ProcurarProdutoNaGrade()
2859:         LOCAL loc_oAba2, loc_cProduto
2860:         TRY
2861:             loc_oAba2   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2862:             loc_cProduto = ALLTRIM(loc_oAba2.txt_4c_ProdutoInicial.Value)
2863: 
2864:             IF !EMPTY(loc_cProduto) AND USED("crMovimentos")
2865:                 LOCATE FOR ALLTRIM(crMovimentos.Cpros) = loc_cProduto
2866:             ENDIF
2867:         CATCH TO loException
2868:             MostrarErro(loException, "FormSigPrCtr.ProcurarProdutoNaGrade")
2869:         ENDTRY
2870:     ENDPROC
2871: 
2872:     *===========================================================================
2873:     * AtualizarDetalhesProdutoSelecionado - AfterRowColChange de
2874:     * grd_4c_Disponivel (legado: grdDisponivel.AfterRowColChange) - busca os
2875:     * dados do produto da linha corrente em SigCdPro/SigCdGrp e atualiza os
2876:     * campos de exibicao da aba Movimentacoes + a imagem do produto. PUBLIC
2877:     * (alvo de BINDEVENT - regra #3); AfterRowColChange exige par_nColIndex.
2878:     *
2879:     * Colunas de SigCdPro lidas no legado mas NUNCA consumidas depois
2880:     * (cgrus/sgrus/CodCors - so alimentavam a consulta morta a SigCdPsg/
2881:     * Tmp_Sgru) e os LEFT JOINs com SigCdUni/SigCdCol/SigCdLin/SigPrFti/
2882:     * SigCdCli/SigCdGpr/SigCdFip (cujas colunas tambem nunca sao lidas) sao
2883:     * leitura morta - omitidas aqui, mesmo criterio ja aplicado em
2884:     * LerArquivoXml para os campos de cabecalho da NF-e nao referenciados.
2885:     *===========================================================================
2886:     PROCEDURE AtualizarDetalhesProdutoSelecionado(par_nColIndex)
2887:         LOCAL loc_oAba2, loc_cSQL, loc_nResultado, loc_cArquivoImg, loc_cFoto, ;
2888:             loc_nCotacao, loc_nCotVen, loc_nPrVenda, loc_cPrVendaMoeda, ;
2889:             loc_nFatArred, loc_nSoma
2890: 
2891:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2892:             RETURN
2893:         ENDIF
2894: 
2895:         TRY
2896:             loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
2897: 
2898:             IF USED("CrTSigPro")
2899:                 USE IN CrTSigPro
2900:             ENDIF
2901: 
2902:             loc_cSQL = "SELECT a.Cpros, a.Reffs, a.Pesoms, a.Moecusfs, a.Custofs, a.Pcuss, " + ;
2903:                 "a.Pvens, a.Moevs, a.FigJpgs, g.Arreds " + ;
2904:                 "FROM SigCdPro a LEFT JOIN SigCdGrp g ON a.Cgrus = g.Cgrus " + ;
2905:                 "WHERE a.Cpros = " + EscaparSQL(ALLTRIM(crMovimentos.Cpros))
2906: 
2907:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "CrTSigPro")
2908: 
2909:             IF loc_nResultado < 1 OR !USED("CrTSigPro") OR EOF("CrTSigPro")
2910:                 MsgErro("Favor reinicializar o processo.", "Falha na Conex" + CHR(227) + "o")
2911:             ELSE
2912:                 loc_oAba2.txt_4c_RefFornecedor.Value = TratarNulo(CrTSigPro.Reffs, "")
2913:                 loc_oAba2.txt_4c_PesoMedio.Value      = TratarNulo(CrTSigPro.Pesoms, 0)
2914:                 loc_oAba2.txt_4c_MoeCusFs.Value        = TratarNulo(CrTSigPro.Moecusfs, "")
2915:                 loc_oAba2.txt_4c_CustoFs.Value          = TratarNulo(CrTSigPro.Custofs, 0)
2916:                 loc_oAba2.txt_4c_PrecoMov.Value         = TratarNulo(CrTSigPro.Pcuss, 0)
2917: 
2918:                 loc_oAba2.txt_4c_MovCidChaves.Value = TratarNulo(crMovimentos.cidchaves, "")
2919:                 loc_oAba2.txt_4c_MovEmps.Value       = SUBSTR(crMovimentos.OriDopNums, 1, 3)
2920:                 loc_oAba2.txt_4c_MovDopes.Value      = SUBSTR(crMovimentos.OriDopNums, 4, 20)
2921:                 loc_oAba2.txt_4c_MovNumes.Value      = ALLTRIM(RIGHT(crMovimentos.OriDopNums, 6))
2922: 
2923:                 IF !ISNULL(CrTSigPro.FigJpgs) AND !EMPTY(CrTSigPro.FigJpgs)
2924:                     loc_cFoto = STRTRAN(CrTSigPro.FigJpgs, "data:image/png;base64,", "")
2925:                     loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpeg;base64,", "")
2926:                     loc_cFoto = STRTRAN(loc_cFoto, "data:image/jpg;base64,", "")

*-- Linhas 2980 a 3470:
2980:     * desta migracao (mesmo padrao de degradacao graciosa ja usado em
2981:     * BtnConsultaVendasClick/AbrirFormZoomImagem para SigOpCgv/SigOpZom).
2982:     *===========================================================================
2983:     PROCEDURE AbrirPesquisaGlobalProduto()
2984:         LOCAL loc_cProduto, loc_oForm, loc_oErro
2985: 
2986:         IF !USED("crMovimentos") OR EOF("crMovimentos")
2987:             RETURN
2988:         ENDIF
2989: 
2990:         loc_cProduto = ALLTRIM(crMovimentos.Cpros)
2991:         IF EMPTY(loc_cProduto)
2992:             RETURN
2993:         ENDIF
2994: 
2995:         loc_oForm = .NULL.
2996:         TRY
2997:             loc_oForm = CREATEOBJECT("FormSigOpCgp", loc_cProduto)
2998:         CATCH TO loc_oErro
2999:             loc_oForm = .NULL.
3000:         ENDTRY
3001: 
3002:         IF VARTYPE(loc_oForm) = "O"
3003:             loc_oForm.Show()
3004:         ELSE
3005:             MsgAviso("M" + CHR(243) + "dulo de Pesquisa Global de Produtos (SigOpCgp) ainda n" + CHR(227) + ;
3006:                 "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
3007:         ENDIF
3008:     ENDPROC
3009: 
3010:     *===========================================================================
3011:     * FigJpgDblClick - DblClick de img_4c_FigJpg (legado: FigJpg.DblClick) -
3012:     * grava a foto do produto corrente (memo cru, SEM decodificar base64 -
3013:     * diferente de AtualizarDetalhesProdutoSelecionado; assim mesmo no
3014:     * legado) num JPG temporario e abriria o Zoom de Imagem (SigOpZom), form
3015:     * auxiliar fora do escopo desta migracao (mesmo padrao de degradacao
3016:     * graciosa ja usado em FormSigMvSbn.AbrirFormZoomImagem).
3017:     *===========================================================================
3018:     PROCEDURE FigJpgDblClick()
3019:         LOCAL loc_cArquivo, loc_cSQL, loc_nResultado, loc_oForm, loc_oErro, loc_cTitulo
3020: 
3021:         IF !USED("crMovimentos") OR EOF("crMovimentos")
3022:             RETURN
3023:         ENDIF
3024: 
3025:         loc_cArquivo = ""
3026:         TRY
3027:             loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".Jpg"
3028: 
3029:             IF USED("cursor_4c_FotoZoom")
3030:                 USE IN cursor_4c_FotoZoom
3031:             ENDIF
3032:             loc_cSQL = "SELECT a.Cpros, a.FigJpgs FROM SigCdPro a WHERE a.Cpros = " + ;
3033:                 EscaparSQL(ALLTRIM(crMovimentos.Cpros))
3034:             loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_FotoZoom")
3035: 
3036:             IF loc_nResultado >= 0 AND USED("cursor_4c_FotoZoom") AND !EOF("cursor_4c_FotoZoom") ;
3037:                     AND !ISNULL(cursor_4c_FotoZoom.FigJpgs) AND !EMPTY(cursor_4c_FotoZoom.FigJpgs)
3038:                 STRTOFILE(cursor_4c_FotoZoom.FigJpgs, loc_cArquivo)
3039:             ELSE
3040:                 loc_cArquivo = ""
3041:             ENDIF
3042: 
3043:             IF USED("cursor_4c_FotoZoom")
3044:                 USE IN cursor_4c_FotoZoom
3045:             ENDIF
3046:         CATCH TO loException
3047:             MostrarErro(loException, "FormSigPrCtr.FigJpgDblClick")
3048:             loc_cArquivo = ""
3049:         ENDTRY
3050: 
3051:         IF !EMPTY(loc_cArquivo) AND FILE(loc_cArquivo)
3052:             loc_cTitulo = "Produto : " + ALLTRIM(crMovimentos.Cpros) + " - " + ALLTRIM(crMovimentos.Dpros)
3053: 
3054:             loc_oForm = .NULL.
3055:             TRY
3056:                 loc_oForm = CREATEOBJECT("FormSigOpZom", loc_cArquivo, loc_cTitulo, " ")
3057:             CATCH TO loc_oErro
3058:                 loc_oForm = .NULL.
3059:             ENDTRY
3060: 
3061:             IF VARTYPE(loc_oForm) = "O"
3062:                 loc_oForm.Show()
3063:             ELSE
3064:                 MsgAviso("M" + CHR(243) + "dulo de Zoom de Imagem (SigOpZom) ainda n" + CHR(227) + ;
3065:                     "o est" + CHR(225) + " dispon" + CHR(237) + "vel nesta vers" + CHR(227) + "o.", "Aviso")
3066:             ENDIF
3067: 
3068:             ERASE (loc_cArquivo)
3069:         ENDIF
3070:     ENDPROC
3071: 
3072:     *===========================================================================
3073:     * BtnExcluirSisClick - Click de cmd_4c_BtnExcluirSis (legado:
3074:     * btnExcluirSis.Click) - exclui a linha atual de crMovimentos
3075:     * (grd_4c_Disponivel).
3076:     *===========================================================================
3077:     PROCEDURE BtnExcluirSisClick()
3078:         LOCAL loc_oAba2
3079:         TRY
3080:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crMovimentos")
3081:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3082: 
3083:                 SELECT crMovimentos
3084:                 IF !EOF()
3085:                     DELETE
3086:                 ENDIF
3087:                 IF !EOF()
3088:                     SKIP
3089:                     SKIP -1
3090:                 ENDIF
3091:                 GO TOP
3092:                 loc_oAba2.grd_4c_Disponivel.SetFocus()
3093:                 loc_oAba2.grd_4c_Disponivel.Refresh()
3094:             ENDIF
3095:         CATCH TO loException
3096:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirSisClick")
3097:         ENDTRY
3098:     ENDPROC
3099: 
3100:     *===========================================================================
3101:     * BtnExcluirArqClick - Click de cmd_4c_BtnExcluirArq (legado:
3102:     * btnExcluirArq.Click) - exclui a linha atual de crDistribui
3103:     * (grd_4c_ItemXml).
3104:     *===========================================================================
3105:     PROCEDURE BtnExcluirArqClick()
3106:         LOCAL loc_oAba2
3107:         TRY
3108:             IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR") AND USED("crDistribui")
3109:                 loc_oAba2 = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page2
3110: 
3111:                 SELECT crDistribui
3112:                 IF !EOF()
3113:                     DELETE
3114:                 ENDIF
3115:                 IF !EOF()
3116:                     SKIP
3117:                     SKIP -1
3118:                 ENDIF
3119:                 GO TOP
3120:                 loc_oAba2.grd_4c_ItemXml.SetFocus()
3121:                 loc_oAba2.grd_4c_ItemXml.Refresh()
3122:             ENDIF
3123:         CATCH TO loException
3124:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirArqClick")
3125:         ENDTRY
3126:     ENDPROC
3127: 
3128:     *===========================================================================
3129:     * FormParaBO - Transfere os campos editaveis de Page2 (aba Precificacao)
3130:     * para o Business Object. Grupo/Dconta/Cpf NAO tem coluna em SigPrCtr
3131:     * (regra ja documentada nos comentarios de ConfigurarPaginaDados) e por
3132:     * isso nao sao mapeados aqui.
3133:     *===========================================================================
3134:     PROCEDURE FormParaBO()
3135:         LOCAL loc_oPagina
3136:         TRY
3137:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3138: 
3139:             THIS.this_oBusinessObject.this_cContas   = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
3140:             THIS.this_oBusinessObject.this_cMoedas   = ALLTRIM(loc_oPagina.txt_4c_Moeda.Value)
3141:             THIS.this_oBusinessObject.this_cArquivo  = ALLTRIM(loc_oPagina.txt_4c_Arquivo.Value)
3142:             THIS.this_oBusinessObject.this_nPrecific = loc_oPagina.opt_4c_Custo.Value
3143:         CATCH TO loException
3144:             MostrarErro(loException, "FormSigPrCtr.FormParaBO")
3145:         ENDTRY
3146:     ENDPROC
3147: 
3148:     *===========================================================================
3149:     * BOParaForm - Transfere o Business Object para os campos de Page2 e
3150:     * reconstitui Dconta/Cpf/Grupo + grd_4c_Estoque via o mesmo bloco usado
3151:     * apos validar a Conta digitada (AtualizarCpfEGrupoPorConta/MontaGrade).
3152:     *===========================================================================
3153:     PROCEDURE BOParaForm()
3154:         LOCAL loc_oPagina
3155:         TRY
3156:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3157: 
3158:             loc_oPagina.txt_4c_Conta.Value   = THIS.this_oBusinessObject.this_cContas
3159:             loc_oPagina.txt_4c_Moeda.Value   = THIS.this_oBusinessObject.this_cMoedas
3160:             loc_oPagina.txt_4c_Arquivo.Value = THIS.this_oBusinessObject.this_cArquivo
3161:             loc_oPagina.opt_4c_Custo.Value   = IIF(THIS.this_oBusinessObject.this_nPrecific = 2, 2, 1)
3162:             loc_oPagina.txt_4c_Grupo.Value   = ""
3163:             loc_oPagina.txt_4c_Cpf.Value     = ""
3164:             loc_oPagina.txt_4c_Dconta.Value  = ""
3165: 
3166:             THIS.AtualizarCpfEGrupoPorConta(loc_oPagina)
3167:         CATCH TO loException
3168:             MostrarErro(loException, "FormSigPrCtr.BOParaForm")
3169:         ENDTRY
3170:     ENDPROC
3171: 
3172:     *===========================================================================
3173:     * LimparCampos - Limpa os campos de Page2 (aba Precificacao) e a grade
3174:     * de estoque disponivel, preparando o formulario para modo INCLUIR.
3175:     *===========================================================================
3176:     PROCEDURE LimparCampos()
3177:         LOCAL loc_oPagina
3178:         TRY
3179:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3180: 
3181:             *-- Grupo de acesso padrao de fornecedores (legado: Init faz
3182:             *-- "Get_Grupo.Value = crSigCdPam.GrPadFors" uma unica vez; aqui
3183:             *-- reaplicado a cada Incluir, equivalente para "novo registro")
3184:             loc_oPagina.txt_4c_Grupo.Value   = IIF(USED("crSigCdPam"), ;
3185:                 ALLTRIM(NVL(crSigCdPam.GrPadFors, "")), "")
3186:             loc_oPagina.txt_4c_Conta.Value   = ""
3187:             loc_oPagina.txt_4c_Dconta.Value  = ""
3188:             loc_oPagina.txt_4c_Cpf.Value     = ""
3189:             loc_oPagina.txt_4c_Moeda.Value   = ""
3190:             loc_oPagina.txt_4c_Arquivo.Value = ""
3191:             loc_oPagina.opt_4c_Custo.Value   = 1
3192: 
3193:             loc_oPagina.grd_4c_Estoque.RecordSource = ""
3194:             IF USED("cursor_4c_Estoque")
3195:                 USE IN cursor_4c_Estoque
3196:             ENDIF
3197:         CATCH TO loException
3198:             MostrarErro(loException, "FormSigPrCtr.LimparCampos")
3199:         ENDTRY
3200:     ENDPROC
3201: 
3202:     *===========================================================================
3203:     * HabilitarCampos - Habilita/desabilita os campos editaveis da aba
3204:     * Precificacao. txt_4c_Dconta e sempre somente-leitura (preenchido por
3205:     * lookup em AtualizarCpfEGrupoPorConta, nunca digitado pelo usuario).
3206:     *===========================================================================
3207:     PROCEDURE HabilitarCampos(par_lHabilitar)
3208:         LOCAL loc_oPagina
3209:         TRY
3210:             loc_oPagina = THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1
3211: 
3212:             loc_oPagina.txt_4c_Grupo.Enabled   = par_lHabilitar
3213:             loc_oPagina.txt_4c_Conta.Enabled   = par_lHabilitar
3214:             loc_oPagina.txt_4c_Cpf.Enabled     = par_lHabilitar
3215:             loc_oPagina.txt_4c_Moeda.Enabled   = par_lHabilitar
3216:             loc_oPagina.txt_4c_Arquivo.Enabled = par_lHabilitar
3217:             loc_oPagina.opt_4c_Custo.Enabled   = par_lHabilitar
3218:             loc_oPagina.txt_4c_Dconta.Enabled  = .F.
3219:         CATCH TO loException
3220:             MostrarErro(loException, "FormSigPrCtr.HabilitarCampos")
3221:         ENDTRY
3222:     ENDPROC
3223: 
3224:     *===========================================================================
3225:     * AjustarBotoesPorModo - Alterna habilitacao dos botoes CRUD (Page1) e
3226:     * Confirmar/Cancelar (Page2) conforme this_cModoAtual. Chamada tanto ao
3227:     * ENTRAR em edicao quanto ao VOLTAR para a lista via AlternarPagina(1)
3228:     * (regra #40 - quem desabilita no funil de ida tem que reabilitar no
3229:     * funil de volta).
3230:     *===========================================================================
3231:     PROCEDURE AjustarBotoesPorModo()
3232:         LOCAL loc_oCntBotoes, loc_lEmEdicao
3233:         TRY
3234:             loc_oCntBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
3235:             loc_lEmEdicao  = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "VISUALIZAR")
3236: 
3237:             loc_oCntBotoes.cmd_4c_Incluir.Enabled    = !loc_lEmEdicao
3238:             loc_oCntBotoes.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
3239:             loc_oCntBotoes.cmd_4c_Alterar.Enabled    = !loc_lEmEdicao
3240:             loc_oCntBotoes.cmd_4c_Excluir.Enabled    = !loc_lEmEdicao
3241:             loc_oCntBotoes.cmd_4c_Buscar.Enabled     = !loc_lEmEdicao
3242: 
3243:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = ;
3244:                 INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
3245:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = loc_lEmEdicao
3246:         CATCH TO loException
3247:             MostrarErro(loException, "FormSigPrCtr.AjustarBotoesPorModo")
3248:         ENDTRY
3249:     ENDPROC
3250: 
3251:     *===========================================================================
3252:     * BtnIncluirClick - Inicia inclusao de novo lote de controle
3253:     * (legado: Grupo_Op.Click(1) -> DoDefault(1) navega para Pagina.Dados).
3254:     *===========================================================================
3255:     PROCEDURE BtnIncluirClick()
3256:         TRY
3257:             THIS.this_oBusinessObject.NovoRegistro()
3258:             THIS.LimparCampos()
3259:             THIS.this_cModoAtual = "INCLUIR"
3260:             THIS.HabilitarCampos(.T.)
3261:             THIS.AjustarBotoesPorModo()
3262:             THIS.AlternarPagina(2)
3263:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Detalhes.Page1.txt_4c_Conta.SetFocus()
3264:         CATCH TO loException
3265:             MostrarErro(loException, "FormSigPrCtr.BtnIncluirClick")
3266:         ENDTRY
3267:     ENDPROC
3268: 
3269:     *===========================================================================
3270:     * BtnAlterarClick - Carrega o lote selecionado na Lista (agrupado por
3271:     * Codigos - regra #42) para alteracao.
3272:     *===========================================================================
3273:     PROCEDURE BtnAlterarClick()
3274:         LOCAL loc_cCodigo, loc_lTemSelecao
3275:         loc_lTemSelecao = .F.
3276: 
3277:         TRY
3278:             IF USED("cursor_4c_Lista")
3279:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3280:                     loc_lTemSelecao = .T.
3281:                 ENDIF
3282:             ENDIF
3283: 
3284:             IF !loc_lTemSelecao
3285:                 MsgAviso("Selecione um registro na lista para alterar.", "Aviso")
3286:             ELSE
3287:                 SELECT cursor_4c_Lista
3288:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3289: 
3290:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3291:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3292:                 ELSE
3293:                     THIS.this_oBusinessObject.EditarRegistro()
3294:                     THIS.BOParaForm()
3295:                     THIS.this_cModoAtual = "ALTERAR"
3296:                     THIS.HabilitarCampos(.T.)
3297:                     THIS.AjustarBotoesPorModo()
3298:                     THIS.AlternarPagina(2)
3299:                 ENDIF
3300:             ENDIF
3301:         CATCH TO loException
3302:             MostrarErro(loException, "FormSigPrCtr.BtnAlterarClick")
3303:         ENDTRY
3304:     ENDPROC
3305: 
3306:     *===========================================================================
3307:     * BtnVisualizarClick - Carrega o lote selecionado somente para consulta
3308:     * (campos desabilitados, Confirmar desabilitado - padrao canonico).
3309:     *===========================================================================
3310:     PROCEDURE BtnVisualizarClick()
3311:         LOCAL loc_cCodigo, loc_lTemSelecao
3312:         loc_lTemSelecao = .F.
3313: 
3314:         TRY
3315:             IF USED("cursor_4c_Lista")
3316:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3317:                     loc_lTemSelecao = .T.
3318:                 ENDIF
3319:             ENDIF
3320: 
3321:             IF !loc_lTemSelecao
3322:                 MsgAviso("Selecione um registro na lista para visualizar.", "Aviso")
3323:             ELSE
3324:                 SELECT cursor_4c_Lista
3325:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3326: 
3327:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3328:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3329:                 ELSE
3330:                     THIS.BOParaForm()
3331:                     THIS.this_cModoAtual = "VISUALIZAR"
3332:                     THIS.HabilitarCampos(.F.)
3333:                     THIS.AjustarBotoesPorModo()
3334:                     THIS.AlternarPagina(2)
3335:                 ENDIF
3336:             ENDIF
3337:         CATCH TO loException
3338:             MostrarErro(loException, "FormSigPrCtr.BtnVisualizarClick")
3339:         ENDTRY
3340:     ENDPROC
3341: 
3342:     *===========================================================================
3343:     * BtnExcluirClick - Exclui o lote selecionado (todas as linhas do mesmo
3344:     * Codigos - legado: "Delete From SigPrCtr Where Codigos = ?_Codigo").
3345:     * Falha de gravacao nunca eh muda (regra #20) - BusinessBase.Excluir()
3346:     * ja chama MsgErro internamente quando necessario.
3347:     *===========================================================================
3348:     PROCEDURE BtnExcluirClick()
3349:         LOCAL loc_cCodigo, loc_lTemSelecao
3350:         loc_lTemSelecao = .F.
3351: 
3352:         TRY
3353:             IF USED("cursor_4c_Lista")
3354:                 IF RECCOUNT("cursor_4c_Lista") > 0 AND !EOF("cursor_4c_Lista")
3355:                     loc_lTemSelecao = .T.
3356:                 ENDIF
3357:             ENDIF
3358: 
3359:             IF !loc_lTemSelecao
3360:                 MsgAviso("Selecione um registro na lista para excluir.", "Aviso")
3361:             ELSE
3362:                 SELECT cursor_4c_Lista
3363:                 loc_cCodigo = ALLTRIM(cursor_4c_Lista.Codigos)
3364: 
3365:                 IF MsgConfirma("Deseja realmente excluir o registro " + loc_cCodigo + "?", ;
3366:                         "Confirmar Exclus" + CHR(227) + "o")
3367: 
3368:                     IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
3369:                         MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel localizar o registro selecionado.", "Erro")
3370:                     ELSE
3371:                         IF THIS.this_oBusinessObject.Excluir()
3372:                             MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Confirmar")
3373:                             THIS.CarregarLista()
3374:                         ELSE
3375:                             IF !THIS.this_oBusinessObject.this_lErroExibido
3376:                                 MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel excluir o registro.", "Confirmar")
3377:                             ENDIF
3378:                         ENDIF
3379:                     ENDIF
3380:                 ENDIF
3381:             ENDIF
3382:         CATCH TO loException
3383:             MostrarErro(loException, "FormSigPrCtr.BtnExcluirClick")
3384:         ENDTRY
3385:     ENDPROC
3386: 
3387:     *===========================================================================
3388:     * BtnBuscarClick - Recarrega a lista com o periodo atual dos filtros
3389:     * (legado: msv_procurar/GetCodigos nao foi migrado - nao ha campo de
3390:     * busca por exemplo na Lista, apenas o filtro de periodo, ja aplicado
3391:     * automaticamente pelo LostFocus de txt_4c_Dt_final/txt_4c_Dt_inicial;
3392:     * padrao identico ao de FormMoe/FormROM/FormPAT).
3393:     *===========================================================================
3394:     PROCEDURE BtnBuscarClick()
3395:         THIS.CarregarLista()
3396:     ENDPROC
3397: 
3398:     *===========================================================================
3399:     * BtnConfirmarClick - Salva o lote (Grupo_Salva.Salva.Click legado).
3400:     * SigPrCtrBO.ValidarDados() cobre a validacao "Favor Informar uma Conta.";
3401:     * falha de gravacao nunca eh muda (regra #20) - o form so complementa a
3402:     * mensagem quando o BO ainda nao exibiu nenhuma.
3403:     *===========================================================================
3404:     PROCEDURE BtnConfirmarClick()
3405:         TRY
3406:             THIS.FormParaBO()
3407: 
3408:             IF THIS.this_oBusinessObject.Salvar()
3409:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
3410:                 THIS.AlternarPagina(1)
3411:             ELSE
3412:                 IF !THIS.this_oBusinessObject.this_lErroExibido
3413:                     MsgErro("N" + CHR(227) + "o foi poss" + CHR(237) + "vel gravar o registro.", "Confirmar")
3414:                 ENDIF
3415:             ENDIF
3416:         CATCH TO loException
3417:             MostrarErro(loException, "FormSigPrCtr.BtnConfirmarClick")
3418:         ENDTRY
3419:     ENDPROC
3420: 
3421:     *===========================================================================
3422:     * BtnCancelarClick - Cancela a edicao e volta para a Lista (legado:
3423:     * Grupo_Salva.Cancelar.Click -> ThisForm.mAtivaPagina1 + ActivePage=1).
3424:     *===========================================================================
3425:     PROCEDURE BtnCancelarClick()
3426:         TRY
3427:             THIS.this_oBusinessObject.CancelarEdicao()
3428:             THIS.AlternarPagina(1)
3429:         CATCH TO loException
3430:             MostrarErro(loException, "FormSigPrCtr.BtnCancelarClick")
3431:         ENDTRY
3432:     ENDPROC
3433: 
3434:     *===========================================================================
3435:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
3436:     * REGRA: Deve iterar Pages E Controls para PageFrames (problema 6)
3437:     *===========================================================================
3438:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
3439:         LOCAL loc_nI, loc_oObjeto, loc_nP
3440: 
3441:         FOR loc_nI = 1 TO par_oContainer.ControlCount
3442:             loc_oObjeto = par_oContainer.Controls(loc_nI)
3443: 
3444:             IF VARTYPE(loc_oObjeto) = "O"
3445:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
3446:                     loc_oObjeto.Visible = .T.
3447:                 ENDIF
3448: 
3449:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
3450:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
3451:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
3452:                     ENDFOR
3453:                 ENDIF
3454: 
3455:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
3456:                     THIS.TornarControlesVisiveis(loc_oObjeto)
3457:                 ENDIF
3458:             ENDIF
3459:         ENDFOR
3460:     ENDPROC
3461: 
3462:     *===========================================================================
3463:     * Destroy - Libera o Business Object
3464:     *===========================================================================
3465:     PROCEDURE Destroy()
3466:         THIS.this_oBusinessObject = .NULL.
3467:         RETURN DODEFAULT()
3468:     ENDPROC
3469: 
3470: ENDDEFINE


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

