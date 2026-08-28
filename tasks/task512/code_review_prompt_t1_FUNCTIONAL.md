# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (17)
- [BINDEVENT-PARAMS] Handler 'NmReportLostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE NmReportLostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_SqlResult' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_SqlResultTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_SqlResult' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_SqlResultTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_SqlResult' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_SqlResultTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-HEADER] Header Caption 'Nome do Relatório' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Criação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Alteração' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Nome do Relatório' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Criação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Alteração' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Ativo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título do Campo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Título do Campo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Titulo, Fonte, Fte, Cor, Alinhar, Campo, Tipo, Saída Rel., Filtro, SubTot, Total, Titulo do Campo, Tam., Grupo. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2802 linhas total):

*-- Linhas 34 a 182:
34:     this_oWLstVARs         = .NULL.
35: 
36:     *==========================================================================
37:     * Init - Apenas delega ao FormBase (que chama InicializarForm)
38:     *==========================================================================
39:     PROCEDURE Init()
40:         LOCAL loc_lResultado
41:         loc_lResultado = .F.
42:         TRY
43:             loc_lResultado = DODEFAULT()
44:         CATCH TO loc_oErro
45:             MsgErro(loc_oErro.Message, "FormRPT.Init")
46:         ENDTRY
47:         RETURN loc_lResultado
48:     ENDPROC
49: 
50:     *==========================================================================
51:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase.Init)
52:     *==========================================================================
53:     PROTECTED PROCEDURE InicializarForm()
54:         LOCAL loc_lResultado
55:         loc_lResultado = .F.
56: 
57:         TRY
58:             *-- Fix DataSession=2: restaurar SET DATE/CENTURY (CLAUDE.md regra 9.4)
59:             SET DATE TO BRITISH
60:             SET CENTURY ON
61: 
62:             THIS.Caption = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
63: 
64:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
65:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
66:                     MsgErro("Conex" + CHR(227) + "o com banco de dados n" + CHR(227) + ;
67:                             "o estabelecida.", "Erro")
68:                     loc_lResultado = .F.
69:                 ENDIF
70:             ENDIF
71: 
72:             THIS.this_oBusinessObject = CREATEOBJECT("RPTBO")
73: 
74:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
75:                 MsgErro("Erro ao criar RPTBO.", "Erro de Inicializa" + CHR(231) + CHR(227) + "o")
76:                 loc_lResultado = .F.
77:             ENDIF
78: 
79:             THIS.ConfigurarPageFrame()
80: 
81:             IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
82:                 THIS.InicializarListas()
83:                 THIS.CarregarLista()
84:             ENDIF
85: 
86:             THIS.pgf_4c_Paginas.ActivePage = 1
87:             THIS.this_cModoAtual = "LISTA"
88: 
89:             loc_lResultado = .T.
90:         CATCH TO loc_oErro
91:             MsgErro(loc_oErro.Message, "FormRPT.InicializarForm")
92:         ENDTRY
93: 
94:         RETURN loc_lResultado
95:     ENDPROC
96: 
97:     *==========================================================================
98:     * ConfigurarPageFrame - Cria PageFrame externo com Page1 (Lista) e Page2 (Dados)
99:     *==========================================================================
100:     PROTECTED PROCEDURE ConfigurarPageFrame()
101:         LOCAL loc_lResultado
102:         loc_lResultado = .F.
103: 
104:         TRY
105:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
106:             WITH THIS.pgf_4c_Paginas
107:                 .Top       = -29
108:                 .Left      = 0
109:                 .Width     = THIS.Width
110:                 .Height    = THIS.Height + 29
111:                 .PageCount = 2
112:                 .Tabs      = .F.
113:             ENDWITH
114: 
115:             WITH THIS.pgf_4c_Paginas.Page1
116:                 .Caption = "Lista"
117:                 .Width   = THIS.Width
118:                 .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119:             ENDWITH
120: 
121:             WITH THIS.pgf_4c_Paginas.Page2
122:                 .Caption = "Dados"
123:                 .Width   = THIS.Width
124:             ENDWITH
125: 
126:             THIS.ConfigurarPaginaLista()
127:             THIS.ConfigurarPaginaDados()
128: 
129:             THIS.pgf_4c_Paginas.Visible = .T.
130: 
131:             loc_lResultado = .T.
132:         CATCH TO loc_oErro
133:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPageFrame")
134:         ENDTRY
135: 
136:         RETURN loc_lResultado
137:     ENDPROC
138: 
139:     *==========================================================================
140:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD e grid de relatorios
141:     *==========================================================================
142:     PROTECTED PROCEDURE ConfigurarPaginaLista()
143:         LOCAL loc_oPagina
144:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
145: 
146:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
147:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
148: 
149:         TRY
150:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
151:             WITH loc_oPagina.cnt_4c_Cabecalho
152:                 .Top        = 31
153:                 .Left       = 0
154:                 .Width      = 1003
155:                 .Height     = 80
156:                 .BackColor  = RGB(100, 100, 100)
157:                 .BorderWidth = 0
158:                 .Visible    = .T.
159:             ENDWITH
160: 
161:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
162:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
163:                 .Top       = 15
164:                 .Left      = 10
165:                 .Width     = 980
166:                 .Height    = 40
167:                 .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
168:                 .FontName  = "Tahoma"
169:                 .FontSize  = 16
170:                 .FontBold  = .T.
171:                 .ForeColor = RGB(0, 0, 0)
172:                 .BackStyle = 0
173:                 .Visible   = .T.
174:             ENDWITH
175: 
176:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
177:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
178:                 .Top       = 18
179:                 .Left      = 10
180:                 .Width     = 980
181:                 .Height    = 46
182:                 .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"

*-- Linhas 220 a 655:
220:                 .WordWrap        = .T.
221:                 .Visible         = .T.
222:             ENDWITH
223:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
224: 
225:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
226:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
227:                 .Caption         = "Visualizar"
228:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
229:                 .PicturePosition = 13
230:                 .Top             = 5
231:                 .Left            = 80
232:                 .Width           = 75
233:                 .Height          = 75
234:                 .BackColor       = RGB(255, 255, 255)
235:                 .ForeColor       = RGB(90, 90, 90)
236:                 .FontName        = "Comic Sans MS"
237:                 .FontSize        = 8
238:                 .FontBold        = .T.
239:                 .FontItalic      = .T.
240:                 .Themes          = .F.
241:                 .SpecialEffect   = 0
242:                 .MousePointer    = 15
243:                 .WordWrap        = .T.
244:                 .Visible         = .T.
245:             ENDWITH
246:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
247: 
248:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
249:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
250:                 .Caption         = "Alterar"
251:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
252:                 .PicturePosition = 13
253:                 .Top             = 5
254:                 .Left            = 155
255:                 .Width           = 75
256:                 .Height          = 75
257:                 .BackColor       = RGB(255, 255, 255)
258:                 .ForeColor       = RGB(90, 90, 90)
259:                 .FontName        = "Comic Sans MS"
260:                 .FontSize        = 8
261:                 .FontBold        = .T.
262:                 .FontItalic      = .T.
263:                 .Themes          = .F.
264:                 .SpecialEffect   = 0
265:                 .MousePointer    = 15
266:                 .WordWrap        = .T.
267:                 .Visible         = .T.
268:             ENDWITH
269:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
270: 
271:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
272:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
273:                 .Caption         = "Excluir"
274:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
275:                 .PicturePosition = 13
276:                 .Top             = 5
277:                 .Left            = 230
278:                 .Width           = 75
279:                 .Height          = 75
280:                 .BackColor       = RGB(255, 255, 255)
281:                 .ForeColor       = RGB(90, 90, 90)
282:                 .FontName        = "Comic Sans MS"
283:                 .FontSize        = 8
284:                 .FontBold        = .T.
285:                 .FontItalic      = .T.
286:                 .Themes          = .F.
287:                 .SpecialEffect   = 0
288:                 .MousePointer    = 15
289:                 .WordWrap        = .T.
290:                 .Visible         = .T.
291:             ENDWITH
292:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
293: 
294:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
295:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
296:                 .Caption         = "Buscar"
297:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
298:                 .PicturePosition = 13
299:                 .Top             = 5
300:                 .Left            = 305
301:                 .Width           = 75
302:                 .Height          = 75
303:                 .BackColor       = RGB(255, 255, 255)
304:                 .ForeColor       = RGB(90, 90, 90)
305:                 .FontName        = "Comic Sans MS"
306:                 .FontSize        = 8
307:                 .FontBold        = .T.
308:                 .FontItalic      = .T.
309:                 .Themes          = .F.
310:                 .SpecialEffect   = 0
311:                 .MousePointer    = 15
312:                 .WordWrap        = .T.
313:                 .Visible         = .T.
314:             ENDWITH
315:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
316: 
317:             *-- Container saida - padrao canonico (CLAUDE.md regra #10)
318:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
319:             WITH loc_oPagina.cnt_4c_Saida
320:                 .Top        = 29
321:                 .Left       = 917
322:                 .Width      = 90
323:                 .Height     = 85
324:                 .BackStyle  = 0
325:                 .BorderWidth = 0
326:                 .Visible    = .T.
327:             ENDWITH
328: 
329:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
330:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
331:                 .Caption         = "Encerrar"
332:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
333:                 .PicturePosition = 13
334:                 .Top             = 5
335:                 .Left            = 5
336:                 .Width           = 75
337:                 .Height          = 75
338:                 .BackColor       = RGB(255, 255, 255)
339:                 .ForeColor       = RGB(90, 90, 90)
340:                 .FontName        = "Comic Sans MS"
341:                 .FontSize        = 8
342:                 .FontBold        = .T.
343:                 .FontItalic      = .T.
344:                 .Themes          = .F.
345:                 .SpecialEffect   = 0
346:                 .MousePointer    = 15
347:                 .WordWrap        = .T.
348:                 .Visible         = .T.
349:             ENDWITH
350:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
353:             WITH loc_oPagina.grd_4c_Lista
354:                 .Top                = 117
355:                 .Left               = 2
356:                 .Width              = 998
357:                 .Height             = 498
358:                 .FontName           = "Verdana"
359:                 .FontSize           = 8
360:                 .ForeColor          = RGB(90, 90, 90)
361:                 .BackColor          = RGB(255, 255, 255)
362:                 .GridLineColor      = RGB(238, 238, 238)
363:                 .HighlightBackColor = RGB(255, 255, 255)
364:                 .HighlightForeColor = RGB(15, 41, 104)
365:                 .HighlightStyle     = 2
366:                 .DeleteMark         = .F.
367:                 .RecordMark         = .F.
368:                 .RowHeight          = 16
369:                 .ScrollBars         = 2
370:                 .GridLines          = 3
371:                 .ColumnCount        = 5
372:                 .Visible            = .T.
373:             ENDWITH
374: 
375:             THIS.TornarControlesVisiveis(loc_oPagina)
376:         CATCH TO loc_oErro
377:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaLista")
378:         ENDTRY
379:     ENDPROC
380: 
381:     *==========================================================================
382:     * ConfigurarPaginaDados - Page2 externa: botoes Confirmar/Cancelar + PageFrame interno
383:     *   pgf_4c_Dados.Page1 = Editor SQL (campos + editor + grade resultado)
384:     *   pgf_4c_Dados.Page2 = Designer layout (Fase 6)
385:     *==========================================================================
386:     PROTECTED PROCEDURE ConfigurarPaginaDados()
387:         LOCAL loc_oPagina
388:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
389: 
390:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
391:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
392: 
393:         TRY
394:             *-- Botoes Confirmar + Cancelar (Grupo_Salva no legado)
395:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
396:             WITH loc_oPagina.cnt_4c_BotoesAcao
397:                 .Top        = 33
398:                 .Left       = 842
399:                 .Width      = 160
400:                 .Height     = 85
401:                 .BackStyle = 1
402:                 .BackColor = RGB(255, 255, 255)
403:                 .BorderWidth = 0
404:                 .Visible    = .T.
405:             ENDWITH
406: 
407:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
408:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
409:                 .Caption         = "Confirmar"
410:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
411:                 .PicturePosition = 13
412:                 .Top             = 5
413:                 .Left            = 5
414:                 .Width           = 75
415:                 .Height          = 75
416:                 .BackColor       = RGB(255, 255, 255)
417:                 .ForeColor       = RGB(90, 90, 90)
418:                 .FontName        = "Comic Sans MS"
419:                 .FontSize        = 8
420:                 .FontBold        = .T.
421:                 .FontItalic      = .T.
422:                 .Themes          = .F.
423:                 .SpecialEffect   = 0
424:                 .MousePointer    = 15
425:                 .WordWrap        = .T.
426:                 .Visible         = .T.
427:             ENDWITH
428:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
429: 
430:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
431:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
432:                 .Caption         = "Encerrar"
433:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
434:                 .PicturePosition = 13
435:                 .Top             = 5
436:                 .Left            = 80
437:                 .Width           = 75
438:                 .Height          = 75
439:                 .BackColor       = RGB(255, 255, 255)
440:                 .ForeColor       = RGB(90, 90, 90)
441:                 .FontName        = "Comic Sans MS"
442:                 .FontSize        = 8
443:                 .FontBold        = .T.
444:                 .FontItalic      = .T.
445:                 .Themes          = .F.
446:                 .SpecialEffect   = 0
447:                 .MousePointer    = 15
448:                 .WordWrap        = .T.
449:                 .Visible         = .T.
450:             ENDWITH
451:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
452: 
453:             *-- PageFrame interno (Pageframe1 no legado)
454:             *-- Top=-29 oculta abas; conteudo de Page1 usa coords SCX direto (sem offset adicional)
455:             loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
456:             WITH loc_oPagina.pgf_4c_Dados
457:                 .Top       = -29
458:                 .Left      = 0
459:                 .Width     = THIS.Width
460:                 .Height    = 631
461:                 .PageCount = 2
462:                 .Tabs      = .F.
463:                 .Visible   = .T.
464:             ENDWITH
465: 
466:             WITH loc_oPagina.pgf_4c_Dados.Page1
467:                 .Caption = "Editor SQL"
468:                 .Width   = THIS.Width
469:             ENDWITH
470: 
471:             WITH loc_oPagina.pgf_4c_Dados.Page2
472:                 .Caption = "Designer"
473:                 .Width   = THIS.Width
474:             ENDWITH
475: 
476:             THIS.ConfigurarEditorSQL(loc_oPagina.pgf_4c_Dados.Page1)
477:             THIS.ConfigurarDesignerLayout(loc_oPagina.pgf_4c_Dados.Page2)
478: 
479:             THIS.TornarControlesVisiveis(loc_oPagina)
480:         CATCH TO loc_oErro
481:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarPaginaDados")
482:         ENDTRY
483:     ENDPROC
484: 
485:     *==========================================================================
486:     * ConfigurarEditorSQL - Controles da Page1 interna (Editor SQL + campos cadastro)
487:     * Coordenadas: direto do SCX (relativos a Page1 de pgf_4c_Dados)
488:     * O duplo Top=-29 dos dois pageframes se cancela: coords SCX usadas sem ajuste
489:     *==========================================================================
490:     PROTECTED PROCEDURE ConfigurarEditorSQL(par_oPage)
491:         TRY
492:             *-- Container botoes de acao SQL (CmdGrp_Acoes no legado - 3 botoes)
493:             par_oPage.AddObject("cnt_4c_AcoesSQL", "Container")
494:             WITH par_oPage.cnt_4c_AcoesSQL
495:                 .Top        = 9
496:                 .Left       = 15
497:                 .Width      = 235
498:                 .Height     = 85
499:                 .BackColor  = RGB(53, 53, 53)
500:                 .BackStyle  = 1
501:                 .BorderWidth = 0
502:                 .Visible    = .T.
503:             ENDWITH
504: 
505:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Processar", "CommandButton")
506:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar
507:                 .Caption         = "Processar"
508:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
509:                 .PicturePosition = 13
510:                 .Top             = 5
511:                 .Left            = 5
512:                 .Width           = 75
513:                 .Height          = 75
514:                 .BackColor       = RGB(255, 255, 255)
515:                 .ForeColor       = RGB(90, 90, 90)
516:                 .FontName        = "Comic Sans MS"
517:                 .FontSize        = 8
518:                 .FontBold        = .T.
519:                 .FontItalic      = .T.
520:                 .Themes          = .F.
521:                 .SpecialEffect   = 0
522:                 .MousePointer    = 15
523:                 .WordWrap        = .T.
524:                 .Visible         = .T.
525:             ENDWITH
526:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
527: 
528:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_VisualizarRpt", "CommandButton")
529:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt
530:                 .Caption         = "Visualizar"
531:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
532:                 .PicturePosition = 13
533:                 .Top             = 5
534:                 .Left            = 80
535:                 .Width           = 75
536:                 .Height          = 75
537:                 .BackColor       = RGB(255, 255, 255)
538:                 .ForeColor       = RGB(90, 90, 90)
539:                 .FontName        = "Comic Sans MS"
540:                 .FontSize        = 8
541:                 .FontBold        = .T.
542:                 .FontItalic      = .T.
543:                 .Themes          = .F.
544:                 .SpecialEffect   = 0
545:                 .MousePointer    = 15
546:                 .WordWrap        = .T.
547:                 .Visible         = .T.
548:             ENDWITH
549:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt, "Click", THIS, "BtnVisualizarRptClick")
550: 
551:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Estrutura", "CommandButton")
552:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura
553:                 .Caption         = "Layout"
554:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
555:                 .PicturePosition = 13
556:                 .Top             = 5
557:                 .Left            = 155
558:                 .Width           = 75
559:                 .Height          = 75
560:                 .BackColor       = RGB(255, 255, 255)
561:                 .ForeColor       = RGB(90, 90, 90)
562:                 .FontName        = "Comic Sans MS"
563:                 .FontSize        = 8
564:                 .FontBold        = .T.
565:                 .FontItalic      = .T.
566:                 .Themes          = .F.
567:                 .SpecialEffect   = 0
568:                 .MousePointer    = 15
569:                 .WordWrap        = .T.
570:                 .Visible         = .T.
571:             ENDWITH
572:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura, "Click", THIS, "BtnLayoutClick")
573: 
574:             *-- Label "Nome do Arquivo do Report:"
575:             par_oPage.AddObject("lbl_4c_NmReport", "Label")
576:             WITH par_oPage.lbl_4c_NmReport
577:                 .Top       = 2
578:                 .Left      = 326
579:                 .Width     = 139
580:                 .Height    = 15
581:                 .Caption   = "Nome do Arquivo do Report:"
582:                 .FontName  = "Tahoma"
583:                 .FontSize  = 8
584:                 .BackStyle = 0
585:                 .Visible   = .T.
586:             ENDWITH
587: 
588:             *-- TextBox nome do relatorio (Txt_NmReport no legado)
589:             par_oPage.AddObject("txt_4c_NmReport", "TextBox")
590:             WITH par_oPage.txt_4c_NmReport
591:                 .Top       = 14
592:                 .Left      = 326
593:                 .Width     = 361
594:                 .Height    = 23
595:                 .FontName  = "Tahoma"
596:                 .FontSize  = 8
597:                 .MaxLength = 100
598:                 .Visible   = .T.
599:             ENDWITH
600: 
601:             *-- ComboBox para selecionar report existente (Cbo_NmReports no legado)
602:             par_oPage.AddObject("cbo_4c_NmReports", "ComboBox")
603:             WITH par_oPage.cbo_4c_NmReports
604:                 .Top           = 13
605:                 .Left          = 691
606:                 .Width         = 200
607:                 .Height        = 24
608:                 .Style         = 2
609:                 .FontName      = "Tahoma"
610:                 .FontSize      = 8
611:                 .RowSourceType = 0
612:                 .Visible       = .T.
613:             ENDWITH
614:             BINDEVENT(par_oPage.cbo_4c_NmReports, "InteractiveChange", THIS, "CboNmReportsChange")
615:             BINDEVENT(par_oPage.txt_4c_NmReport, "KeyPress", THIS, "NmReportLostFocus")
616: 
617:             *-- CheckBox Ativo (Chk_Ativo no legado)
618:             par_oPage.AddObject("chk_4c_Ativo", "CheckBox")
619:             WITH par_oPage.chk_4c_Ativo
620:                 .Top       = 19
621:                 .Left      = 733
622:                 .Width     = 48
623:                 .Height    = 15
624:                 .Caption   = "Ativo"
625:                 .FontName  = "Tahoma"
626:                 .FontSize  = 8
627:                 .Value     = 1
628:                 .BackStyle = 0
629:                 .Visible   = .T.
630:             ENDWITH
631: 
632:             *-- Label "Descricao desse Report:"
633:             par_oPage.AddObject("lbl_4c_Descr", "Label")
634:             WITH par_oPage.lbl_4c_Descr
635:                 .Top       = 38
636:                 .Left      = 326
637:                 .Width     = 119
638:                 .Height    = 15
639:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o desse Report:"
640:                 .FontName  = "Tahoma"
641:                 .FontSize  = 8
642:                 .BackStyle = 0
643:                 .Visible   = .T.
644:             ENDWITH
645: 
646:             *-- EditBox descricao (Edt_Descricao no legado)
647:             par_oPage.AddObject("edt_4c_Descricao", "EditBox")
648:             WITH par_oPage.edt_4c_Descricao
649:                 .Top        = 50
650:                 .Left       = 326
651:                 .Width      = 454
652:                 .Height     = 41
653:                 .FontName   = "Tahoma"
654:                 .FontSize   = 8
655:                 .ScrollBars = 3

*-- Linhas 805 a 885:
805:                 .MousePointer = 15
806:                 .Visible      = .T.
807:             ENDWITH
808:             BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F8, "Click", THIS, "LblF8Click")
809: 
810:             *-- Lbl_Tabelas: "Tabelas" sublinhado (overlay)
811:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Tabelas", "Label")
812:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Tabelas
813:                 .AutoSize      = .T.
814:                 .Top           = 2
815:                 .Left          = 146
816:                 .Height        = 15
817:                 .Width         = 53
818:                 .Caption       = "Tabelas"
819:                 .FontName      = "Verdana"
820:                 .FontSize      = 8
821:                 .FontBold      = .T.
822:                 .FontUnderline = .T.
823:                 .ForeColor     = RGB(90, 90, 90)
824:                 .BackStyle     = 0
825:                 .Visible       = .T.
826:             ENDWITH
827: 
828:             *-- Lbl_F9: "F9" azul clicavel (overlay)
829:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_F9", "Label")
830:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9
831:                 .AutoSize     = .T.
832:                 .Top          = 2
833:                 .Left         = 217
834:                 .Height       = 15
835:                 .Width        = 18
836:                 .Caption      = "F9"
837:                 .FontName     = "Verdana"
838:                 .FontSize     = 8
839:                 .FontBold     = .T.
840:                 .ForeColor    = RGB(0, 0, 255)
841:                 .BackStyle    = 0
842:                 .MousePointer = 15
843:                 .Visible      = .T.
844:             ENDWITH
845:             BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9, "Click", THIS, "LblF9Click")
846: 
847:             *-- Lbl_Variaveis: "Variaveis" sublinhado (overlay)
848:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Variaveis", "Label")
849:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Variaveis
850:                 .AutoSize      = .T.
851:                 .Top           = 2
852:                 .Left          = 328
853:                 .Height        = 15
854:                 .Width         = 63
855:                 .Caption       = "Vari" + CHR(225) + "veis"
856:                 .FontName      = "Verdana"
857:                 .FontSize      = 8
858:                 .FontBold      = .T.
859:                 .FontUnderline = .T.
860:                 .ForeColor     = RGB(90, 90, 90)
861:                 .BackStyle     = 0
862:                 .Visible       = .T.
863:             ENDWITH
864: 
865:             *-- Indicador SQL modificado (Lbl_SQL_Alterado no legado - asterisco vermelho)
866:             par_oPage.AddObject("lbl_4c_SqlAlterado", "Label")
867:             WITH par_oPage.lbl_4c_SqlAlterado
868:                 .Top       = 147
869:                 .Left      = 8
870:                 .Width     = 27
871:                 .Height    = 17
872:                 .Caption   = ""
873:                 .FontName  = "Tahoma"
874:                 .FontSize  = 12
875:                 .FontBold  = .T.
876:                 .ForeColor = RGB(255, 0, 0)
877:                 .BackStyle = 0
878:                 .Visible   = .T.
879:             ENDWITH
880: 
881:             *-- EditBox SQL (OleRTF_SqlCMD no legado - substituido por EditBox nativo)
882:             par_oPage.AddObject("edt_4c_SqlCMD", "EditBox")
883:             WITH par_oPage.edt_4c_SqlCMD
884:                 .Top        = 158
885:                 .Left       = 8

*-- Linhas 891 a 968:
891:                 .ReadOnly   = .F.
892:                 .Visible    = .T.
893:             ENDWITH
894:             BINDEVENT(par_oPage.edt_4c_SqlCMD, "Change", THIS, "SqlCMDChange")
895: 
896:             *-- Grade de resultados SQL (FwGrade1_Resultado no legado)
897:             par_oPage.AddObject("grd_4c_Resultado", "Grid")
898:             WITH par_oPage.grd_4c_Resultado
899:                 .Top                = 379
900:                 .Left               = 8
901:                 .Width              = 986
902:                 .Height             = 218
903:                 .FontName           = "Verdana"
904:                 .FontSize           = 8
905:                 .ForeColor          = RGB(90, 90, 90)
906:                 .BackColor          = RGB(255, 255, 255)
907:                 .GridLineColor      = RGB(238, 238, 238)
908:                 .HighlightBackColor = RGB(255, 255, 255)
909:                 .HighlightForeColor = RGB(15, 41, 104)
910:                 .HighlightStyle     = 2
911:                 .DeleteMark         = .F.
912:                 .RecordMark         = .F.
913:                 .RowHeight          = 16
914:                 .ScrollBars         = 3
915:                 .GridLines          = 3
916:                 .ColumnCount        = 0
917:                 .ReadOnly           = .T.
918:                 .Visible            = .T.
919:             ENDWITH
920:         CATCH TO loc_oErro
921:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarEditorSQL")
922:         ENDTRY
923:     ENDPROC
924: 
925:     *==========================================================================
926:     * CarregarLista - Carrega lista de relatorios no grid
927:     *==========================================================================
928:     PROCEDURE CarregarLista()
929:         LOCAL loc_lResultado, loc_oGrid
930:         loc_lResultado = .F.
931: 
932:         TRY
933:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
934:                 loc_lResultado = .T.
935:             ELSE
936:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
937:                 IF THIS.this_oBusinessObject.Buscar("")
938:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
939: 
940:                     loc_oGrid.ColumnCount = 5
941:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
942:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
943:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
944:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
945:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
946:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
947: 
948:                     *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
949:                     loc_oGrid.Column1.Header1.Caption = "Nome do Relat" + CHR(243) + "rio"
950:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
951:                     loc_oGrid.Column3.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
952:                     loc_oGrid.Column4.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
953:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
954: 
955:                     loc_oGrid.Column1.Width = 350
956:                     loc_oGrid.Column2.Width = 350
957:                     loc_oGrid.Column3.Width = 90
958:                     loc_oGrid.Column4.Width = 90
959:                     loc_oGrid.Column5.Width = 50
960: 
961:                     THIS.FormatarGridLista(loc_oGrid)
962: 
963:                     loc_lResultado = .T.
964:                 ENDIF
965:                 ENDIF
966:             ENDIF
967:         CATCH TO loc_oErro
968:             MsgErro(loc_oErro.Message, "FormRPT.CarregarLista")

*-- Linhas 974 a 1382:
974:     *==========================================================================
975:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
976:     *==========================================================================
977:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
978:         LOCAL loc_lResultado
979:         loc_lResultado = .F.
980: 
981:         TRY
982:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
983:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
984: 
985:                 IF par_nPagina = 1
986:                     THIS.this_cModoAtual = "LISTA"
987:                     THIS.CarregarLista()
988:                 ELSE
989:                     THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
990:                 ENDIF
991: 
992:                 loc_lResultado = .T.
993:             ENDIF
994:         CATCH TO loc_oErro
995:             MsgErro(loc_oErro.Message, "FormRPT.AlternarPagina")
996:         ENDTRY
997: 
998:         RETURN loc_lResultado
999:     ENDPROC
1000: 
1001:     *==========================================================================
1002:     * BtnIncluirClick - Abre Page2 para incluir novo relatorio
1003:     *==========================================================================
1004:     PROCEDURE BtnIncluirClick()
1005:         TRY
1006:             THIS.this_oBusinessObject.NovoRegistro()
1007:             THIS.this_pcEscolha  = "INSERIR"
1008:             THIS.this_cModoAtual = "INCLUIR"
1009:             THIS.BOParaForm()
1010:             THIS.ConfigurarModoEditor(.F.)
1011:             THIS.AlternarPagina(2)
1012:         CATCH TO loc_oErro
1013:             MsgErro(loc_oErro.Message, "FormRPT.BtnIncluirClick")
1014:         ENDTRY
1015:     ENDPROC
1016: 
1017:     *==========================================================================
1018:     * BtnVisualizarClick - Abre Page2 para visualizar relatorio selecionado
1019:     *==========================================================================
1020:     PROCEDURE BtnVisualizarClick()
1021:         LOCAL loc_cRptId, loc_lProsseguir
1022:         loc_lProsseguir = .T.
1023:         TRY
1024:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1025:                 MsgAviso("Selecione um relat" + CHR(243) + "rio para visualizar.", ;
1026:                          "Aten" + CHR(231) + CHR(227) + "o")
1027:                 loc_lProsseguir = .F.
1028:             ENDIF
1029: 
1030:             IF loc_lProsseguir
1031:                 SELECT cursor_4c_Dados
1032:                 loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1033: 
1034:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1035:                     THIS.this_pcEscolha  = "CONSULTAR"
1036:                     THIS.this_cModoAtual = "VISUALIZAR"
1037:                     THIS.BOParaForm()
1038:                     THIS.ConfigurarModoEditor(.T.)
1039:                     THIS.AlternarPagina(2)
1040:                 ELSE
1041:                     MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
1042:                 ENDIF
1043:             ENDIF
1044:         CATCH TO loc_oErro
1045:             MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarClick")
1046:         ENDTRY
1047:     ENDPROC
1048: 
1049:     *==========================================================================
1050:     * BtnAlterarClick - Abre Page2 para alterar relatorio selecionado
1051:     *==========================================================================
1052:     PROCEDURE BtnAlterarClick()
1053:         LOCAL loc_cRptId, loc_lProsseguir
1054:         loc_lProsseguir = .T.
1055:         TRY
1056:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1057:                 MsgAviso("Selecione um relat" + CHR(243) + "rio para alterar.", ;
1058:                          "Aten" + CHR(231) + CHR(227) + "o")
1059:                 loc_lProsseguir = .F.
1060:             ENDIF
1061: 
1062:             IF loc_lProsseguir
1063:                 SELECT cursor_4c_Dados
1064:                 loc_cRptId = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1065: 
1066:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1067:                     THIS.this_oBusinessObject.EditarRegistro()
1068:                     THIS.this_pcEscolha  = "ALTERAR"
1069:                     THIS.this_cModoAtual = "ALTERAR"
1070:                     THIS.BOParaForm()
1071:                     THIS.ConfigurarModoEditor(.F.)
1072:                     THIS.AlternarPagina(2)
1073:                 ELSE
1074:                     MsgErro("Erro ao carregar relat" + CHR(243) + "rio selecionado.", "Erro")
1075:                 ENDIF
1076:             ENDIF
1077:         CATCH TO loc_oErro
1078:             MsgErro(loc_oErro.Message, "FormRPT.BtnAlterarClick")
1079:         ENDTRY
1080:     ENDPROC
1081: 
1082:     *==========================================================================
1083:     * BtnExcluirClick - Exclui relatorio selecionado apos confirmacao
1084:     *==========================================================================
1085:     PROCEDURE BtnExcluirClick()
1086:         LOCAL loc_cRptId, loc_cNmReport, loc_lProsseguir
1087:         loc_lProsseguir = .T.
1088:         TRY
1089:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR BOF("cursor_4c_Dados")
1090:                 MsgAviso("Selecione um relat" + CHR(243) + "rio para excluir.", ;
1091:                          "Aten" + CHR(231) + CHR(227) + "o")
1092:                 loc_lProsseguir = .F.
1093:             ENDIF
1094: 
1095:             IF loc_lProsseguir
1096:                 SELECT cursor_4c_Dados
1097:                 loc_cRptId    = ALLTRIM(NVL(cursor_4c_Dados.RPT_ID, ""))
1098:                 loc_cNmReport = ALLTRIM(NVL(cursor_4c_Dados.NmReport, ""))
1099: 
1100:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o do relat" + CHR(243) + "rio:" + ;
1101:                                CHR(13) + loc_cNmReport + "?", ;
1102:                                "Confirmar Exclus" + CHR(227) + "o")
1103: 
1104:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cRptId)
1105:                         IF THIS.this_oBusinessObject.Excluir()
1106:                             MsgInfo("Relat" + CHR(243) + "rio exclu" + CHR(237) + "do com sucesso!")
1107:                             THIS.CarregarLista()
1108:                         ELSE
1109:                             MsgErro("Erro ao excluir relat" + CHR(243) + "rio.", "Erro")
1110:                         ENDIF
1111:                     ELSE
1112:                         MsgErro("Erro ao carregar relat" + CHR(243) + "rio para exclus" + CHR(227) + "o.", "Erro")
1113:                     ENDIF
1114:                 ENDIF
1115:             ENDIF
1116:         CATCH TO loc_oErro
1117:             MsgErro(loc_oErro.Message, "FormRPT.BtnExcluirClick")
1118:         ENDTRY
1119:     ENDPROC
1120: 
1121:     *==========================================================================
1122:     * BtnBuscarClick - Filtra lista por nome ou descricao
1123:     *==========================================================================
1124:     PROCEDURE BtnBuscarClick()
1125:         LOCAL loc_cFiltro, loc_oGrid
1126:         TRY
1127:             loc_cFiltro = INPUTBOX("Digite o nome ou descri" + CHR(231) + CHR(227) + "o para buscar:", ;
1128:                           "Buscar Relat" + CHR(243) + "rio", "")
1129: 
1130:             IF VARTYPE(loc_cFiltro) = "C"
1131:                 IF THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1132:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1133: 
1134:                     loc_oGrid.ColumnCount = 5
1135:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1136:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.NmReport"
1137:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descr"
1138:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.DtCriacao"
1139:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
1140:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
1141: 
1142:                     loc_oGrid.Column1.Header1.Caption = "Nome do Relat" + CHR(243) + "rio"
1143:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1144:                     loc_oGrid.Column3.Header1.Caption = "Cria" + CHR(231) + CHR(227) + "o"
1145:                     loc_oGrid.Column4.Header1.Caption = "Altera" + CHR(231) + CHR(227) + "o"
1146:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
1147: 
1148:                     loc_oGrid.Column1.Width = 350
1149:                     loc_oGrid.Column2.Width = 350
1150:                     loc_oGrid.Column3.Width = 90
1151:                     loc_oGrid.Column4.Width = 90
1152:                     loc_oGrid.Column5.Width = 50
1153: 
1154:                     THIS.FormatarGridLista(loc_oGrid)
1155:                     loc_oGrid.Refresh()
1156:                 ENDIF
1157:             ENDIF
1158:         CATCH TO loc_oErro
1159:             MsgErro(loc_oErro.Message, "FormRPT.BtnBuscarClick")
1160:         ENDTRY
1161:     ENDPROC
1162: 
1163:     *==========================================================================
1164:     * BtnEncerrarClick - Fecha o formulario
1165:     *==========================================================================
1166:     PROCEDURE BtnEncerrarClick()
1167:         TRY
1168:             THIS.Release()
1169:         CATCH TO loc_oErro
1170:             MsgErro(loc_oErro.Message, "FormRPT.BtnEncerrarClick")
1171:         ENDTRY
1172:     ENDPROC
1173: 
1174:     *==========================================================================
1175:     * BtnSalvarClick - Coleta dados do form, salva via BO e volta para lista
1176:     *==========================================================================
1177:     PROCEDURE BtnSalvarClick()
1178:         LOCAL loc_lResultado
1179:         loc_lResultado = .F.
1180:         TRY
1181:             THIS.FormParaBO()
1182: 
1183:             IF THIS.this_oBusinessObject.Salvar()
1184:                 MsgInfo("Relat" + CHR(243) + "rio salvo com sucesso!")
1185:                 THIS.this_plCancelar = .F.
1186:                 THIS.this_cModoAtual = "LISTA"
1187:                 THIS.AlternarPagina(1)
1188:             ELSE
1189:                 MsgErro("Erro ao salvar relat" + CHR(243) + "rio.", "Erro")
1190:             ENDIF
1191:         CATCH TO loc_oErro
1192:             MsgErro(loc_oErro.Message, "FormRPT.BtnSalvarClick")
1193:         ENDTRY
1194:     ENDPROC
1195: 
1196:     *==========================================================================
1197:     * BtnCancelarClick - Cancela edicao e volta para lista
1198:     *==========================================================================
1199:     PROCEDURE BtnCancelarClick()
1200:         TRY
1201:             THIS.this_plCancelar = .T.
1202:             THIS.this_cModoAtual = "LISTA"
1203:             THIS.AlternarPagina(1)
1204:         CATCH TO loc_oErro
1205:             MsgErro(loc_oErro.Message, "FormRPT.BtnCancelarClick")
1206:         ENDTRY
1207:     ENDPROC
1208: 
1209:     *==========================================================================
1210:     * BtnProcessarClick - Executa SQL e exibe resultado na grade
1211:     *==========================================================================
1212:     PROCEDURE BtnProcessarClick()
1213:         LOCAL loc_cSQL, loc_nResultado, loc_oPage, loc_oGrid, loc_nCols, loc_nI, loc_lProsseguir
1214:         LOCAL laFields[1]
1215:         loc_lProsseguir = .T.
1216:         TRY
1217:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1218:             loc_cSQL  = ALLTRIM(loc_oPage.edt_4c_SqlCMD.Value)
1219: 
1220:             IF EMPTY(loc_cSQL)
1221:                 MsgAviso("Digite o comando SQL antes de processar.", "Aten" + CHR(231) + CHR(227) + "o")
1222:                 loc_lProsseguir = .F.
1223:             ENDIF
1224: 
1225:             IF loc_lProsseguir
1226:                 IF USED("cursor_4c_SqlResult")
1227:                     USE IN cursor_4c_SqlResult
1228:                 ENDIF
1229: 
1230:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResult")
1231: 
1232:                 IF loc_nResultado >= 0
1233:                     loc_oGrid = loc_oPage.grd_4c_Resultado
1234:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResult")
1235: 
1236:                     loc_oGrid.ColumnCount  = 0
1237:                     loc_oGrid.RecordSource = "cursor_4c_SqlResult"
1238:                     loc_oGrid.ColumnCount  = loc_nCols
1239: 
1240:                     FOR loc_nI = 1 TO loc_nCols
1241:                         loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
1242:                         loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
1243:                         loc_oGrid.Columns(loc_nI).Width = 100
1244:                     ENDFOR
1245: 
1246:                     loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1247:                     THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
1248:                     loc_oGrid.Refresh()
1249: 
1250:                     MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
1251:                             " registro(s) retornado(s).")
1252:                 ELSE
1253:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1254:                 ENDIF
1255:             ENDIF
1256:         CATCH TO loc_oErro
1257:             MsgErro(loc_oErro.Message, "FormRPT.BtnProcessarClick")
1258:         ENDTRY
1259:     ENDPROC
1260: 
1261:     *==========================================================================
1262:     * BtnVisualizarRptClick - Executa SQL e exibe relatorio FRX correspondente
1263:     *==========================================================================
1264:     PROCEDURE BtnVisualizarRptClick()
1265:         LOCAL loc_cSQL, loc_cNmReport, loc_oPage, loc_nResultado, loc_cFrxPath, loc_lProsseguir
1266:         loc_lProsseguir = .T.
1267:         TRY
1268:             loc_oPage    = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1269:             loc_cSQL     = ALLTRIM(loc_oPage.edt_4c_SqlCMD.Value)
1270:             loc_cNmReport = ALLTRIM(loc_oPage.txt_4c_NmReport.Value)
1271: 
1272:             IF EMPTY(loc_cSQL)
1273:                 MsgAviso("SQL n" + CHR(227) + "o definido. Processe o SQL primeiro.", ;
1274:                          "Aten" + CHR(231) + CHR(227) + "o")
1275:                 loc_lProsseguir = .F.
1276:             ENDIF
1277: 
1278:             IF loc_lProsseguir AND EMPTY(loc_cNmReport)
1279:                 MsgAviso("Nome do relat" + CHR(243) + "rio n" + CHR(227) + "o informado.", ;
1280:                          "Aten" + CHR(231) + CHR(227) + "o")
1281:                 loc_lProsseguir = .F.
1282:             ENDIF
1283: 
1284:             IF loc_lProsseguir
1285:                 loc_cFrxPath = ADDBS(gc_4c_CaminhoReports) + loc_cNmReport
1286: 
1287:                 IF !FILE(loc_cFrxPath + ".frx")
1288:                     MsgErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + ;
1289:                             CHR(13) + loc_cFrxPath + ".frx", "Erro")
1290:                     loc_lProsseguir = .F.
1291:                 ENDIF
1292:             ENDIF
1293: 
1294:             IF loc_lProsseguir
1295:                 IF USED("cursor_4c_SqlResult")
1296:                     USE IN cursor_4c_SqlResult
1297:                 ENDIF
1298: 
1299:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResult")
1300: 
1301:                 IF loc_nResultado >= 0
1302:                     REPORT FORM (loc_cFrxPath) PREVIEW NOCONSOLE
1303:                 ELSE
1304:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1305:                 ENDIF
1306:             ENDIF
1307:         CATCH TO loc_oErro
1308:             MsgErro(loc_oErro.Message, "FormRPT.BtnVisualizarRptClick")
1309:         ENDTRY
1310:     ENDPROC
1311: 
1312:     *==========================================================================
1313:     * BtnLayoutClick - Executa SQL e abre o Designer de Layout
1314:     *==========================================================================
1315:     PROCEDURE BtnLayoutClick()
1316:         LOCAL loc_cSQL, loc_nResultado, loc_nCols, loc_nI, loc_lProsseguir
1317:         LOCAL laFields[1]
1318:         LOCAL loc_oEditorPage, loc_oDesignerPage, loc_oPgfDados
1319:         loc_lProsseguir = .T.
1320:         TRY
1321:             loc_oPgfDados   = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados
1322:             loc_oEditorPage = loc_oPgfDados.Page1
1323:             loc_cSQL        = ALLTRIM(loc_oEditorPage.edt_4c_SqlCMD.Value)
1324: 
1325:             IF EMPTY(loc_cSQL)
1326:                 MsgAviso("Digite o comando SQL antes de abrir o designer.", "Aten" + CHR(231) + CHR(227) + "o")
1327:                 loc_lProsseguir = .F.
1328:             ENDIF
1329: 
1330:             IF loc_lProsseguir
1331:                 *-- Executa SQL para obter estrutura dos campos
1332:                 IF USED("cursor_4c_SqlResult")
1333:                     USE IN cursor_4c_SqlResult
1334:                 ENDIF
1335: 
1336:                 loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlResult")
1337: 
1338:                 IF loc_nResultado >= 0
1339:                     loc_nCols = AFIELDS(laFields, "cursor_4c_SqlResult")
1340: 
1341:                     IF loc_nCols = 0
1342:                         MsgAviso("O SQL n" + CHR(227) + "o retornou campos.", "Aten" + CHR(231) + CHR(227) + "o")
1343:                         loc_lProsseguir = .F.
1344:                     ENDIF
1345:                 ELSE
1346:                     MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
1347:                     loc_lProsseguir = .F.
1348:                 ENDIF
1349:             ENDIF
1350: 
1351:             IF loc_lProsseguir
1352:                 *-- Cria/recria cursores do designer
1353:                 THIS.CriarCursoresDesigner()
1354: 
1355:                 *-- Popula CrsProps_Titulo com 1 linha de titulo
1356:                 IF USED("CrsProps_Titulo")
1357:                     SELECT CrsProps_Titulo
1358:                     IF RECCOUNT("CrsProps_Titulo") = 0
1359:                         APPEND BLANK
1360:                         REPLACE CrsProps_Titulo.NmCampo    WITH "TITULO"
1361:                         REPLACE CrsProps_Titulo.LblCaption WITH ALLTRIM(THIS.this_oBusinessObject.this_cNmReport)
1362:                         REPLACE CrsProps_Titulo.LblFonte   WITH "Arial,12,B"
1363:                         REPLACE CrsProps_Titulo.LblAlinhar WITH "C"
1364:                         REPLACE CrsProps_Titulo.LblTamCmp  WITH 200
1365:                     ENDIF
1366:                 ENDIF
1367: 
1368:                 *-- Popula CrsProps_Campos com um registro por campo do resultado SQL
1369:                 IF USED("CrsProps_Campos")
1370:                     SELECT CrsProps_Campos
1371:                     ZAP
1372:                     FOR loc_nI = 1 TO loc_nCols
1373:                         APPEND BLANK
1374:                         REPLACE CrsProps_Campos.NmCampo    WITH ALLTRIM(laFields[loc_nI, 1])
1375:                         REPLACE CrsProps_Campos.TpCampo    WITH ALLTRIM(laFields[loc_nI, 2])
1376:                         REPLACE CrsProps_Campos.CkOutRPT   WITH 1
1377:                         REPLACE CrsProps_Campos.CkFiltro   WITH 0
1378:                         REPLACE CrsProps_Campos.CkSubTot   WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
1379:                         REPLACE CrsProps_Campos.CkTotal    WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), 1, 0)
1380:                         REPLACE CrsProps_Campos.LblCaption WITH ALLTRIM(laFields[loc_nI, 1])
1381:                         REPLACE CrsProps_Campos.LblFonte   WITH "Arial,9,N"
1382:                         REPLACE CrsProps_Campos.LblAlinhar WITH IIF(INLIST(laFields[loc_nI, 2], "N", "I", "B", "Y"), "R", "L")

*-- Linhas 1404 a 1686:
1404:     ENDPROC
1405: 
1406:     *==========================================================================
1407:     * SqlCMDChange - Marca asterisco quando SQL e editado (evento BINDEVENT)
1408:     *==========================================================================
1409:     PROCEDURE SqlCMDChange()
1410:         TRY
1411:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.lbl_4c_SqlAlterado.Caption = "*"
1412:         CATCH TO loc_oErro
1413:             *-- Indicador nao critico; silencioso
1414:         ENDTRY
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * CboNmReportsChange - Preenche txt_4c_NmReport ao selecionar report existente
1419:     *==========================================================================
1420:     PROCEDURE CboNmReportsChange()
1421:         LOCAL loc_oPage, loc_cSelecionado
1422:         TRY
1423:             loc_oPage        = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1424:             loc_cSelecionado = ALLTRIM(loc_oPage.cbo_4c_NmReports.Value)
1425:             IF !EMPTY(loc_cSelecionado)
1426:                 loc_oPage.txt_4c_NmReport.Value = loc_cSelecionado
1427:             ENDIF
1428:         CATCH TO loc_oErro
1429:             MsgErro(loc_oErro.Message, "FormRPT.CboNmReportsChange")
1430:         ENDTRY
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * FormParaBO - Transfere dados do Form para o BO
1435:     *==========================================================================
1436:     PROTECTED PROCEDURE FormParaBO()
1437:         LOCAL loc_oPage, loc_oBO
1438:         TRY
1439:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1440:             loc_oBO   = THIS.this_oBusinessObject
1441: 
1442:             loc_oBO.this_cNmReport = ALLTRIM(loc_oPage.txt_4c_NmReport.Value)
1443:             loc_oBO.this_cDescr    = ALLTRIM(loc_oPage.edt_4c_Descricao.Value)
1444:             loc_oBO.this_lAtivo    = (loc_oPage.chk_4c_Ativo.Value = 1)
1445:             loc_oBO.this_cSqlQuery = loc_oPage.edt_4c_SqlCMD.Value
1446:         CATCH TO loc_oErro
1447:             MsgErro(loc_oErro.Message, "FormRPT.FormParaBO")
1448:         ENDTRY
1449:     ENDPROC
1450: 
1451:     *==========================================================================
1452:     * BOParaForm - Transfere dados do BO para o Form
1453:     *==========================================================================
1454:     PROTECTED PROCEDURE BOParaForm()
1455:         LOCAL loc_oPage, loc_oBO, loc_cSqlQuery
1456:         TRY
1457:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1458:             loc_oBO   = THIS.this_oBusinessObject
1459: 
1460:             loc_oPage.txt_4c_NmReport.Value    = loc_oBO.this_cNmReport
1461:             loc_oPage.edt_4c_Descricao.Value   = loc_oBO.this_cDescr
1462:             loc_oPage.chk_4c_Ativo.Value       = IIF(loc_oBO.this_lAtivo, 1, 0)
1463:             loc_oPage.txt_4c_DtCriacao.Value   = IIF(EMPTY(loc_oBO.this_dDtCriacao), "", DTOC(loc_oBO.this_dDtCriacao))
1464:             loc_oPage.txt_4c_DtAlteracao.Value = IIF(EMPTY(loc_oBO.this_dDtAlteracao), "", DTOC(loc_oBO.this_dDtAlteracao))
1465: 
1466:             *-- SqlQuery pode estar vazio se CarregarPorCodigo nao trouxe o campo memo
1467:             loc_cSqlQuery = loc_oBO.this_cSqlQuery
1468:             IF EMPTY(ALLTRIM(loc_cSqlQuery)) AND !EMPTY(ALLTRIM(loc_oBO.this_cRptId))
1469:                 loc_cSqlQuery = loc_oBO.CarregarSqlQuery(loc_oBO.this_cRptId)
1470:             ENDIF
1471:             loc_oPage.edt_4c_SqlCMD.Value = loc_cSqlQuery
1472: 
1473:             loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1474: 
1475:             THIS.PopularComboReports()
1476:         CATCH TO loc_oErro
1477:             MsgErro(loc_oErro.Message, "FormRPT.BOParaForm")
1478:         ENDTRY
1479:     ENDPROC
1480: 
1481:     *==========================================================================
1482:     * ConfigurarModoEditor - Habilita/desabilita campos conforme modo
1483:     *==========================================================================
1484:     PROTECTED PROCEDURE ConfigurarModoEditor(par_lSomenteLeitura)
1485:         LOCAL loc_oPage, loc_lRO
1486:         loc_lRO = (VARTYPE(par_lSomenteLeitura) = "L" AND par_lSomenteLeitura)
1487:         TRY
1488:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
1489: 
1490:             loc_oPage.txt_4c_NmReport.ReadOnly  = loc_lRO
1491:             loc_oPage.edt_4c_Descricao.ReadOnly = loc_lRO
1492:             loc_oPage.chk_4c_Ativo.Enabled      = !loc_lRO
1493:             loc_oPage.edt_4c_SqlCMD.ReadOnly    = loc_lRO
1494:             loc_oPage.cbo_4c_NmReports.Enabled  = !loc_lRO
1495: 
1496:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lRO
1497:         CATCH TO loc_oErro
1498:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarModoEditor")
1499:         ENDTRY
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * PopularComboReports - Carrega nomes de relatorios existentes no combobox
1504:     *==========================================================================
1505:     PROTECTED PROCEDURE PopularComboReports()
1506:         LOCAL loc_nRes
1507:         TRY
1508:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
1509:                 RETURN
1510:             ENDIF
1511: 
1512:             IF USED("cursor_4c_ReportNomes")
1513:                 USE IN cursor_4c_ReportNomes
1514:             ENDIF
1515: 
1516:             loc_nRes = SQLEXEC(gnConnHandle, ;
1517:                        "SELECT DISTINCT NmReport FROM SIGCDRLC ORDER BY NmReport", ;
1518:                        "cursor_4c_ReportNomes")
1519: 
1520:             IF loc_nRes >= 0
1521:                 WITH THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.cbo_4c_NmReports
1522:                     .RowSourceType = 2
1523:                     .RowSource     = "cursor_4c_ReportNomes"
1524:                     .BoundColumn   = 1
1525:                     .ColumnCount   = 1
1526:                 ENDWITH
1527:             ENDIF
1528:         CATCH TO loc_oErro
1529:             MsgErro(loc_oErro.Message, "FormRPT.PopularComboReports")
1530:         ENDTRY
1531:     ENDPROC
1532: 
1533:     *==========================================================================
1534:     * ConfigurarDesignerLayout - Page2 interna (Designer de Layout do Relatorio)
1535:     * Fase 5 Parte 2: botoes Voltar/SalvarRPT, labels, orientacao, tamanho papel
1536:     * Coords: direto do SCX Pageframe1.Page2 (sem ajuste - simetria dos dois Top=-29)
1537:     *==========================================================================
1538:     PROTECTED PROCEDURE ConfigurarDesignerLayout(par_oPage)
1539:         TRY
1540:             *-- Container botoes de acao do designer (CmdGrp_Acoes no legado - 2 botoes)
1541:             par_oPage.AddObject("cnt_4c_AcoesDesigner", "Container")
1542:             WITH par_oPage.cnt_4c_AcoesDesigner
1543:                 .Top         = 8
1544:                 .Left        = 11
1545:                 .Width       = 160
1546:                 .Height      = 85
1547:                 .BackColor   = RGB(53, 53, 53)
1548:                 .BackStyle   = 1
1549:                 .BorderWidth = 0
1550:                 .Visible     = .T.
1551:             ENDWITH
1552: 
1553:             par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_VoltarEditor", "CommandButton")
1554:             WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor
1555:                 .Caption         = "Voltar"
1556:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1557:                 .PicturePosition = 13
1558:                 .Top             = 5
1559:                 .Left            = 5
1560:                 .Width           = 75
1561:                 .Height          = 75
1562:                 .BackColor       = RGB(255, 255, 255)
1563:                 .ForeColor       = RGB(90, 90, 90)
1564:                 .FontName        = "Comic Sans MS"
1565:                 .FontSize        = 8
1566:                 .FontBold        = .T.
1567:                 .FontItalic      = .T.
1568:                 .Themes          = .F.
1569:                 .SpecialEffect   = 0
1570:                 .MousePointer    = 15
1571:                 .WordWrap        = .T.
1572:                 .Visible         = .T.
1573:             ENDWITH
1574:             BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor, "Click", THIS, "BtnVoltarEditorClick")
1575: 
1576:             par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_SalvarRPT", "CommandButton")
1577:             WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT
1578:                 .Caption         = "Salvar RPT"
1579:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1580:                 .PicturePosition = 13
1581:                 .Top             = 5
1582:                 .Left            = 80
1583:                 .Width           = 75
1584:                 .Height          = 75
1585:                 .BackColor       = RGB(255, 255, 255)
1586:                 .ForeColor       = RGB(90, 90, 90)
1587:                 .FontName        = "Comic Sans MS"
1588:                 .FontSize        = 8
1589:                 .FontBold        = .T.
1590:                 .FontItalic      = .T.
1591:                 .Themes          = .F.
1592:                 .SpecialEffect   = 0
1593:                 .MousePointer    = 15
1594:                 .WordWrap        = .T.
1595:                 .Visible         = .T.
1596:             ENDWITH
1597:             BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT, "Click", THIS, "BtnSalvarRPTClick")
1598: 
1599:             *-- Imagem orientacao (Img_Orientacao no legado)
1600:             par_oPage.AddObject("img_4c_Orientacao", "Image")
1601:             WITH par_oPage.img_4c_Orientacao
1602:                 .Top     = 6
1603:                 .Left    = 603
1604:                 .Width   = 130
1605:                 .Height  = 116
1606:                 .Stretch = 2
1607:                 .Picture = gc_4c_CaminhoIcones + "rpt_orientacao_retrato_26.jpg"
1608:                 .Visible = .T.
1609:             ENDWITH
1610: 
1611:             *-- OptionGroup orientacao Retrato/Paisagem (OptGrp_Orientacao no legado)
1612:             par_oPage.AddObject("opt_4c_Orientacao", "OptionGroup")
1613:             WITH par_oPage.opt_4c_Orientacao
1614:                 .Top         = 126
1615:                 .Left        = 580
1616:                 .Width       = 185
1617:                 .Height      = 28
1618:                 .ButtonCount = 2
1619:                 .BackStyle   = 0
1620:                 .BorderStyle = 0
1621:                 .Value       = 1
1622:                 .Visible     = .T.
1623:             ENDWITH
1624:             WITH par_oPage.opt_4c_Orientacao.Buttons(1)
1625:                 .Caption   = "Retrato"
1626:                 .BackStyle = 0
1627:                 .Left      = 5
1628:                 .Top       = 5
1629:                 .Width     = 72
1630:                 .AutoSize  = .T.
1631:                 .FontName  = "Tahoma"
1632:                 .FontSize  = 8
1633:                 .ForeColor = RGB(90, 90, 90)
1634:             ENDWITH
1635:             WITH par_oPage.opt_4c_Orientacao.Buttons(2)
1636:                 .Caption   = "Paisagem"
1637:                 .BackStyle = 0
1638:                 .Left      = 90
1639:                 .Top       = 5
1640:                 .Width     = 85
1641:                 .AutoSize  = .T.
1642:                 .FontName  = "Tahoma"
1643:                 .FontSize  = 8
1644:                 .ForeColor = RGB(90, 90, 90)
1645:             ENDWITH
1646:             BINDEVENT(par_oPage.opt_4c_Orientacao, "InteractiveChange", THIS, "OptOrientacaoChanged")
1647: 
1648:             *-- Label "Tamanho do Papel:" (Lbl_TamPapel no legado)
1649:             par_oPage.AddObject("lbl_4c_TamPapel", "Label")
1650:             WITH par_oPage.lbl_4c_TamPapel
1651:                 .Top       = 48
1652:                 .Left      = 202
1653:                 .Width     = 108
1654:                 .Height    = 16
1655:                 .Caption   = "Tamanho do Papel:"
1656:                 .FontName  = "Tahoma"
1657:                 .FontSize  = 8
1658:                 .BackStyle = 0
1659:                 .Visible   = .T.
1660:             ENDWITH
1661: 
1662:             *-- ComboBox tamanho papel (Cbo_TamPapel no legado)
1663:             par_oPage.AddObject("cbo_4c_TamPapel", "ComboBox")
1664:             WITH par_oPage.cbo_4c_TamPapel
1665:                 .Top           = 71
1666:                 .Left          = 202
1667:                 .Width         = 348
1668:                 .Height        = 24
1669:                 .Style         = 2
1670:                 .FontName      = "Tahoma"
1671:                 .FontSize      = 8
1672:                 .RowSourceType = 0
1673:                 .ColumnCount   = 1
1674:                 .BoundColumn   = 1
1675:                 .Visible       = .T.
1676:             ENDWITH
1677:             THIS.PopularCboTamPapel(par_oPage.cbo_4c_TamPapel)
1678: 
1679:             *-- Label nome do relatorio (Lbl_Nm_Relatorio no legado)
1680:             par_oPage.AddObject("lbl_4c_NmRelatorio", "Label")
1681:             WITH par_oPage.lbl_4c_NmRelatorio
1682:                 .Top       = 131
1683:                 .Left      = 10
1684:                 .Width     = 540
1685:                 .Height    = 22
1686:                 .Caption   = ""

*-- Linhas 1714 a 1808:
1714:     *==========================================================================
1715:     * BtnVoltarEditorClick - Volta para Page1 do designer (Editor SQL)
1716:     *==========================================================================
1717:     PROCEDURE BtnVoltarEditorClick()
1718:         TRY
1719:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.ActivePage = 1
1720:         CATCH TO loc_oErro
1721:             MsgErro(loc_oErro.Message, "FormRPT.BtnVoltarEditorClick")
1722:         ENDTRY
1723:     ENDPROC
1724: 
1725:     *==========================================================================
1726:     * BtnSalvarRPTClick - Salva FRX do relatorio com configuracoes do designer
1727:     *==========================================================================
1728:     PROCEDURE BtnSalvarRPTClick()
1729:         LOCAL loc_lResultado
1730:         loc_lResultado = .F.
1731:         TRY
1732:             this.FormParaBO()
1733:             IF THIS.this_oBusinessObject.Salvar()
1734:                 MsgInfo("Layout do relat" + CHR(243) + "rio salvo com sucesso!")
1735:                 loc_lResultado = .T.
1736:             ELSE
1737:                 MsgErro("Erro ao salvar layout do relat" + CHR(243) + "rio.", "Erro")
1738:             ENDIF
1739:         CATCH TO loc_oErro
1740:             MsgErro(loc_oErro.Message, "FormRPT.BtnSalvarRPTClick")
1741:         ENDTRY
1742:         RETURN loc_lResultado
1743:     ENDPROC
1744: 
1745:     *==========================================================================
1746:     * OptOrientacaoChanged - Atualiza imagem ao mudar orientacao
1747:     *==========================================================================
1748:     PROCEDURE OptOrientacaoChanged()
1749:         LOCAL loc_oPage, loc_cImg
1750:         TRY
1751:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2
1752:             IF loc_oPage.opt_4c_Orientacao.Value = 1
1753:                 loc_cImg = gc_4c_CaminhoIcones + "rpt_orientacao_retrato_26.jpg"
1754:             ELSE
1755:                 loc_cImg = gc_4c_CaminhoIcones + "rpt_orientacao_paisagem_26.jpg"
1756:             ENDIF
1757:             IF FILE(loc_cImg)
1758:                 loc_oPage.img_4c_Orientacao.Picture = loc_cImg
1759:             ENDIF
1760:         CATCH TO loc_oErro
1761:             MsgErro(loc_oErro.Message, "FormRPT.OptOrientacaoChanged")
1762:         ENDTRY
1763:     ENDPROC
1764: 
1765:     *==========================================================================
1766:     * PopularCboTamPapel - Popula ComboBox com 41 tamanhos de papel (legado exato)
1767:     *==========================================================================
1768:     PROTECTED PROCEDURE PopularCboTamPapel(par_oCbo)
1769:         LOCAL laPaperSize[41], loc_i, loc_cItems
1770:         TRY
1771:             laPaperSize[ 1] = "Letter, 8 1/2 x 11 in"
1772:             laPaperSize[ 2] = "Letter Small, 8 1/2 x 11 in"
1773:             laPaperSize[ 3] = "Tabloid, 11 x 17 in"
1774:             laPaperSize[ 4] = "Ledger, 17 x 11 in"
1775:             laPaperSize[ 5] = "Legal, 8 1/2 x 14 in"
1776:             laPaperSize[ 6] = "Statement, 5 1/2 x 8 1/2 in"
1777:             laPaperSize[ 7] = "Executive, 7 1/4 x 10 1/2 in"
1778:             laPaperSize[ 8] = "A3, 297 x 420 mm"
1779:             laPaperSize[ 9] = "A4, 210 x 297 mm"
1780:             laPaperSize[10] = "A4, Small 210 x 297 mm"
1781:             laPaperSize[11] = "A5, 148 x 210 mm"
1782:             laPaperSize[12] = "B4 (JIS) 250 x 354 mm"
1783:             laPaperSize[13] = "B5 (JIS) 182 x 257 mm"
1784:             laPaperSize[14] = "Folio, 8 1/2 x 13 in"
1785:             laPaperSize[15] = "Quarto, 215 x 275 mm"
1786:             laPaperSize[16] = "10x14 in"
1787:             laPaperSize[17] = "11x17 in"
1788:             laPaperSize[18] = "Note, 8 1/2 x 11 in"
1789:             laPaperSize[19] = "#9 Envelope, 3 7/8 x 8 7/8 in"
1790:             laPaperSize[20] = "#10 Envelope, 4 1/8 x 9 1/2 in"
1791:             laPaperSize[21] = "#11 Envelope, 4 1/2 x 10 3/8 in"
1792:             laPaperSize[22] = "#12 Envelope, 4 3/4 x 11 in"
1793:             laPaperSize[23] = "#14 Envelope, 5 x 11 1/2 in"
1794:             laPaperSize[24] = "C size sheet"
1795:             laPaperSize[25] = "D size sheet"
1796:             laPaperSize[26] = "E size sheet"
1797:             laPaperSize[27] = "DL Envelope, 110 x 220 mm"
1798:             laPaperSize[28] = "C5 Envelope, 162 x 229 mm"
1799:             laPaperSize[29] = "C3 Envelope, 324 x 458 mm"
1800:             laPaperSize[30] = "C4 Envelope, 229 x 324 mm"
1801:             laPaperSize[31] = "C6 Envelope, 114 x 162 mm"
1802:             laPaperSize[32] = "C65 Envelope, 114 x 229 mm"
1803:             laPaperSize[33] = "B4 Envelope, 250 x 353 mm"
1804:             laPaperSize[34] = "B5 Envelope, 176 x 250 mm"
1805:             laPaperSize[35] = "B6 Envelope, 176 x 125 mm"
1806:             laPaperSize[36] = "Italy Envelope, 110 x 230 mm"
1807:             laPaperSize[37] = "Monarch Envelope, 3 7/8 x 7 1/2 in"
1808:             laPaperSize[38] = "6 3/4 Envelope, 3 5/8 x 6 1/2 in"

*-- Linhas 1828 a 1871:
1828:     * grd_4c_TIT (5 cols/Top=180), grd_4c_CMPs (12 cols/Top=258), grd_4c_GRP (7 cols/Top=529)
1829:     * RecordSource definido em runtime quando cursor de dados e carregado
1830:     *==========================================================================
1831:     PROTECTED PROCEDURE ConfigurarGradesDesigner(par_oPage)
1832:         LOCAL loc_oGrd, loc_oCol
1833:         TRY
1834:             *=== GRADE 1: grd_4c_TIT (FwGrade1_TIT) - titulo/cabecalho, 5 colunas ===
1835:             par_oPage.AddObject("grd_4c_TIT", "Grid")
1836:             loc_oGrd = par_oPage.grd_4c_TIT
1837:             WITH loc_oGrd
1838:                 .Top              = 180
1839:                 .Left             = 4
1840:                 .Width            = 990
1841:                 .Height           = 65
1842:                 .ColumnCount      = 5
1843:                 .RecordSourceType = 1
1844:                 .RecordSource     = ""
1845:                 .GridLines        = 1
1846:                 .HeaderHeight     = 25
1847:                 .RowHeight        = 30
1848:                 .DeleteMark       = .F.
1849:                 .RecordMark       = .F.
1850:                 .ScrollBars       = 2
1851:                 .Visible          = .T.
1852:             ENDWITH
1853: 
1854:             *- Col1: LblCaption - "Titulo" (EditBox)
1855:             loc_oCol = loc_oGrd.Column1
1856:             loc_oCol.Header1.Caption = "T" + CHR(237) + "tulo"
1857:             loc_oCol.Width  = 300
1858:             loc_oCol.Sparse = .F.
1859:             loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
1860:             loc_oCol.CurrentControl = "edt_4c_TitCaption"
1861:             WITH loc_oCol.edt_4c_TitCaption
1862:                 .Width      = 298
1863:                 .Height     = 28
1864:                 .ScrollBars = 0
1865:             ENDWITH
1866: 
1867:             *- Col2: LblFonte - "Fonte" (EditBox - string "FontName,Size,Style")
1868:             loc_oCol = loc_oGrd.Column2
1869:             loc_oCol.Header1.Caption = "Fonte"
1870:             loc_oCol.Width  = 230
1871:             loc_oCol.Sparse = .F.

*-- Linhas 1892 a 1952:
1892:                 .FontName      = "Tahoma"
1893:                 .FontSize      = 8
1894:             ENDWITH
1895:             BINDEVENT(loc_oCol.cmd_4c_FonteTIT, "Click", THIS, "BtnFonteTITClick")
1896: 
1897:             *- Col4: BtCor - "Cor" (CommandButton - abre GETCOLOR)
1898:             loc_oCol = loc_oGrd.Column4
1899:             loc_oCol.Header1.Caption = "Cor"
1900:             loc_oCol.Width  = 80
1901:             loc_oCol.Sparse = .F.
1902:             loc_oCol.AddObject("cmd_4c_CorTIT", "CommandButton")
1903:             loc_oCol.CurrentControl = "cmd_4c_CorTIT"
1904:             WITH loc_oCol.cmd_4c_CorTIT
1905:                 .Caption       = "..."
1906:                 .Width         = 75
1907:                 .Height        = 25
1908:                 .SpecialEffect = 0
1909:                 .FontName      = "Tahoma"
1910:                 .FontSize      = 8
1911:             ENDWITH
1912:             BINDEVENT(loc_oCol.cmd_4c_CorTIT, "Click", THIS, "BtnCorTITClick")
1913: 
1914:             *- Col5: LblAlinhar - "Alinhar" (ComboBox Esq./Cen./Dir.)
1915:             loc_oCol = loc_oGrd.Column5
1916:             loc_oCol.Header1.Caption = "Alinhar"
1917:             loc_oCol.Width  = 300
1918:             loc_oCol.Sparse = .F.
1919:             loc_oCol.AddObject("cbo_4c_AlinharTIT", "ComboBox")
1920:             loc_oCol.CurrentControl = "cbo_4c_AlinharTIT"
1921:             WITH loc_oCol.cbo_4c_AlinharTIT
1922:                 .Style         = 2
1923:                 .RowSourceType = 1
1924:                 .RowSource     = "Esq.,Cen.,Dir."
1925:                 .Width         = 120
1926:                 .Height        = 24
1927:                 .FontName      = "Tahoma"
1928:                 .FontSize      = 8
1929:             ENDWITH
1930: 
1931:             *=== GRADE 2: grd_4c_CMPs (FwGrade2_CMPs) - campos do relatorio, 12 colunas ===
1932:             par_oPage.AddObject("grd_4c_CMPs", "Grid")
1933:             loc_oGrd = par_oPage.grd_4c_CMPs
1934:             WITH loc_oGrd
1935:                 .Top              = 258
1936:                 .Left             = 4
1937:                 .Width            = 990
1938:                 .Height           = 238
1939:                 .ColumnCount      = 12
1940:                 .RecordSourceType = 1
1941:                 .RecordSource     = ""
1942:                 .GridLines        = 1
1943:                 .HeaderHeight     = 25
1944:                 .RowHeight        = 30
1945:                 .DeleteMark       = .F.
1946:                 .RecordMark       = .F.
1947:                 .ScrollBars       = 3
1948:                 .Visible          = .T.
1949:             ENDWITH
1950: 
1951:             *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
1952:             loc_oCol = loc_oGrd.Column1

*-- Linhas 2099 a 2159:
2099:                 .FontName      = "Tahoma"
2100:                 .FontSize      = 8
2101:             ENDWITH
2102:             BINDEVENT(loc_oCol.cmd_4c_FonteCMP, "Click", THIS, "BtnFonteCMPClick")
2103: 
2104:             *- Col10: LblBtCor - "Cor" (CommandButton - abre GETCOLOR)
2105:             loc_oCol = loc_oGrd.Column10
2106:             loc_oCol.Header1.Caption = "Cor"
2107:             loc_oCol.Width  = 65
2108:             loc_oCol.Sparse = .F.
2109:             loc_oCol.AddObject("cmd_4c_CorCMP", "CommandButton")
2110:             loc_oCol.CurrentControl = "cmd_4c_CorCMP"
2111:             WITH loc_oCol.cmd_4c_CorCMP
2112:                 .Caption       = "..."
2113:                 .Width         = 60
2114:                 .Height        = 25
2115:                 .SpecialEffect = 0
2116:                 .FontName      = "Tahoma"
2117:                 .FontSize      = 8
2118:             ENDWITH
2119:             BINDEVENT(loc_oCol.cmd_4c_CorCMP, "Click", THIS, "BtnCorCMPClick")
2120: 
2121:             *- Col11: LblAlinhar - "Alinhar" (ComboBox)
2122:             loc_oCol = loc_oGrd.Column11
2123:             loc_oCol.Header1.Caption = "Alinhar"
2124:             loc_oCol.Width  = 80
2125:             loc_oCol.Sparse = .F.
2126:             loc_oCol.AddObject("cbo_4c_AlinharCMP", "ComboBox")
2127:             loc_oCol.CurrentControl = "cbo_4c_AlinharCMP"
2128:             WITH loc_oCol.cbo_4c_AlinharCMP
2129:                 .Style         = 2
2130:                 .RowSourceType = 1
2131:                 .RowSource     = "Esq.,Cen.,Dir."
2132:                 .Width         = 75
2133:                 .Height        = 24
2134:                 .FontName      = "Tahoma"
2135:                 .FontSize      = 8
2136:             ENDWITH
2137: 
2138:             *- Col12: LblTamCmp - "Tam." (Spinner - tamanho da fonte)
2139:             loc_oCol = loc_oGrd.Column12
2140:             loc_oCol.Header1.Caption = "Tam."
2141:             loc_oCol.Width  = 90
2142:             loc_oCol.Sparse = .F.
2143:             loc_oCol.AddObject("spn_4c_TamCMP", "Spinner")
2144:             loc_oCol.CurrentControl = "spn_4c_TamCMP"
2145:             WITH loc_oCol.spn_4c_TamCMP
2146:                 .Width            = 85
2147:                 .Height           = 24
2148:                 .SpinnerLowValue  = 6
2149:                 .SpinnerHighValue = 72
2150:                 .Increment        = 1
2151:             ENDWITH
2152: 
2153:             *=== Label "Totalizar pelo Campo:..." (Lbl_CmpGrupo) ===
2154:             par_oPage.AddObject("lbl_4c_CmpGrupo", "Label")
2155:             WITH par_oPage.lbl_4c_CmpGrupo
2156:                 .Top       = 510
2157:                 .Left      = 10
2158:                 .Width     = 316
2159:                 .Height    = 16

*-- Linhas 2247 a 2482:
2247:                 .FontName      = "Tahoma"
2248:                 .FontSize      = 8
2249:             ENDWITH
2250:             BINDEVENT(loc_oCol.cmd_4c_FonteGRP, "Click", THIS, "BtnFonteGRPClick")
2251: 
2252:             *- Col5: BtCor - "Cor" (CommandButton - abre GETCOLOR)
2253:             loc_oCol = loc_oGrd.Column5
2254:             loc_oCol.Header1.Caption = "Cor"
2255:             loc_oCol.Width  = 80
2256:             loc_oCol.Sparse = .F.
2257:             loc_oCol.AddObject("cmd_4c_CorGRP", "CommandButton")
2258:             loc_oCol.CurrentControl = "cmd_4c_CorGRP"
2259:             WITH loc_oCol.cmd_4c_CorGRP
2260:                 .Caption       = "..."
2261:                 .Width         = 75
2262:                 .Height        = 25
2263:                 .SpecialEffect = 0
2264:                 .FontName      = "Tahoma"
2265:                 .FontSize      = 8
2266:             ENDWITH
2267:             BINDEVENT(loc_oCol.cmd_4c_CorGRP, "Click", THIS, "BtnCorGRPClick")
2268: 
2269:             *- Col6: LblAlinhar - "Alinhar" (ComboBox)
2270:             loc_oCol = loc_oGrd.Column6
2271:             loc_oCol.Header1.Caption = "Alinhar"
2272:             loc_oCol.Width  = 160
2273:             loc_oCol.Sparse = .F.
2274:             loc_oCol.AddObject("cbo_4c_AlinharGRP", "ComboBox")
2275:             loc_oCol.CurrentControl = "cbo_4c_AlinharGRP"
2276:             WITH loc_oCol.cbo_4c_AlinharGRP
2277:                 .Style         = 2
2278:                 .RowSourceType = 1
2279:                 .RowSource     = "Esq.,Cen.,Dir."
2280:                 .Width         = 155
2281:                 .Height        = 24
2282:                 .FontName      = "Tahoma"
2283:                 .FontSize      = 8
2284:             ENDWITH
2285: 
2286:             *- Col7: LblTamCmp - "Tam." (Spinner)
2287:             loc_oCol = loc_oGrd.Column7
2288:             loc_oCol.Header1.Caption = "Tam."
2289:             loc_oCol.Width  = 149
2290:             loc_oCol.Sparse = .F.
2291:             loc_oCol.AddObject("spn_4c_TamGRP", "Spinner")
2292:             loc_oCol.CurrentControl = "spn_4c_TamGRP"
2293:             WITH loc_oCol.spn_4c_TamGRP
2294:                 .Width            = 120
2295:                 .Height           = 24
2296:                 .SpinnerLowValue  = 6
2297:                 .SpinnerHighValue = 72
2298:                 .Increment        = 1
2299:             ENDWITH
2300: 
2301:         CATCH TO loc_oErro
2302:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarGradesDesigner")
2303:         ENDTRY
2304:     ENDPROC
2305: 
2306:     *==========================================================================
2307:     * BtnFonteTITClick - Abre GETFONT para o campo TpFonte da grade grd_4c_TIT
2308:     *==========================================================================
2309:     PROCEDURE BtnFonteTITClick()
2310:         LOCAL loc_cFonte
2311:         TRY
2312:             loc_cFonte = GETFONT()
2313:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
2314:                 REPLACE CrsProps_Titulo.LblFonte WITH loc_cFonte IN CrsProps_Titulo
2315:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
2316:             ENDIF
2317:         CATCH TO loc_oErro
2318:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteTITClick")
2319:         ENDTRY
2320:     ENDPROC
2321: 
2322:     *==========================================================================
2323:     * BtnCorTITClick - Abre GETCOLOR para o campo LblBtCor da grade grd_4c_TIT
2324:     *==========================================================================
2325:     PROCEDURE BtnCorTITClick()
2326:         LOCAL loc_nCor
2327:         TRY
2328:             loc_nCor = GETCOLOR()
2329:             IF loc_nCor >= 0 AND USED("CrsProps_Titulo") AND !EOF("CrsProps_Titulo")
2330:                 REPLACE CrsProps_Titulo.LblBtCor WITH loc_nCor IN CrsProps_Titulo
2331:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_TIT.Refresh()
2332:             ENDIF
2333:         CATCH TO loc_oErro
2334:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorTITClick")
2335:         ENDTRY
2336:     ENDPROC
2337: 
2338:     *==========================================================================
2339:     * BtnFonteCMPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_CMPs
2340:     *==========================================================================
2341:     PROCEDURE BtnFonteCMPClick()
2342:         LOCAL loc_cFonte
2343:         TRY
2344:             loc_cFonte = GETFONT()
2345:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
2346:                 REPLACE CrsProps_Campos.LblFonte WITH loc_cFonte IN CrsProps_Campos
2347:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
2348:             ENDIF
2349:         CATCH TO loc_oErro
2350:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteCMPClick")
2351:         ENDTRY
2352:     ENDPROC
2353: 
2354:     *==========================================================================
2355:     * BtnCorCMPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_CMPs
2356:     *==========================================================================
2357:     PROCEDURE BtnCorCMPClick()
2358:         LOCAL loc_nCor
2359:         TRY
2360:             loc_nCor = GETCOLOR()
2361:             IF loc_nCor >= 0 AND USED("CrsProps_Campos") AND !EOF("CrsProps_Campos")
2362:                 REPLACE CrsProps_Campos.LblBtCor WITH loc_nCor IN CrsProps_Campos
2363:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_CMPs.Refresh()
2364:             ENDIF
2365:         CATCH TO loc_oErro
2366:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorCMPClick")
2367:         ENDTRY
2368:     ENDPROC
2369: 
2370:     *==========================================================================
2371:     * BtnFonteGRPClick - Abre GETFONT para LblFonte da linha atual de grd_4c_GRP
2372:     *==========================================================================
2373:     PROCEDURE BtnFonteGRPClick()
2374:         LOCAL loc_cFonte
2375:         TRY
2376:             loc_cFonte = GETFONT()
2377:             IF !EMPTY(loc_cFonte) AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
2378:                 REPLACE CrsProps_GRP.LblFonte WITH loc_cFonte IN CrsProps_GRP
2379:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
2380:             ENDIF
2381:         CATCH TO loc_oErro
2382:             MsgErro(loc_oErro.Message, "FormRPT.BtnFonteGRPClick")
2383:         ENDTRY
2384:     ENDPROC
2385: 
2386:     *==========================================================================
2387:     * BtnCorGRPClick - Abre GETCOLOR para LblBtCor da linha atual de grd_4c_GRP
2388:     *==========================================================================
2389:     PROCEDURE BtnCorGRPClick()
2390:         LOCAL loc_nCor
2391:         TRY
2392:             loc_nCor = GETCOLOR()
2393:             IF loc_nCor >= 0 AND USED("CrsProps_GRP") AND !EOF("CrsProps_GRP")
2394:                 REPLACE CrsProps_GRP.LblBtCor WITH loc_nCor IN CrsProps_GRP
2395:                 THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page2.grd_4c_GRP.Refresh()
2396:             ENDIF
2397:         CATCH TO loc_oErro
2398:             MsgErro(loc_oErro.Message, "FormRPT.BtnCorGRPClick")
2399:         ENDTRY
2400:     ENDPROC
2401: 
2402:     *==========================================================================
2403:     * FormatarGridLista - Formata visual do grid da lista
2404:     *==========================================================================
2405:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2406:         WITH par_oGrid
2407:             .FontName = "Verdana"
2408:             .FontSize = 8
2409:         ENDWITH
2410:     ENDPROC
2411: 
2412:     *==========================================================================
2413:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2414:     *==========================================================================
2415:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2416:         LOCAL loc_nI, loc_oObjeto, loc_nP
2417: 
2418:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2419:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2420: 
2421:             IF VARTYPE(loc_oObjeto) = "O"
2422:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2423:                     loc_oObjeto.Visible = .T.
2424:                 ENDIF
2425: 
2426:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2427:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2428:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2429:                     ENDFOR
2430:                 ELSE
2431:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2432:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2433:                     ENDIF
2434:                 ENDIF
2435:             ENDIF
2436:         ENDFOR
2437:     ENDPROC
2438: 
2439:     *==========================================================================
2440:     * Destroy - Libera recursos ao fechar o formulario
2441:     *==========================================================================
2442:     PROCEDURE Destroy()
2443:         TRY
2444:             *-- Limpar key labels ANTES de liberar janelas flutuantes
2445:             ON Key Label F8
2446:             ON Key Label F9
2447:             IF TYPE("g_oFormRPT_4c_") = "O"
2448:                 RELEASE g_oFormRPT_4c_
2449:             ENDIF
2450: 
2451:             IF VARTYPE(THIS.this_oWLstTABs) = "O"
2452:                 THIS.this_oWLstTABs = .NULL.
2453:             ENDIF
2454: 
2455:             IF VARTYPE(THIS.this_oWLstVARs) = "O"
2456:                 THIS.this_oWLstVARs = .NULL.
2457:             ENDIF
2458: 
2459:             IF USED("cursor_4c_Dados")
2460:                 USE IN cursor_4c_Dados
2461:             ENDIF
2462:             IF USED("cursor_4c_SqlResult")
2463:                 USE IN cursor_4c_SqlResult
2464:             ENDIF
2465:             IF USED("cursor_4c_ReportNomes")
2466:                 USE IN cursor_4c_ReportNomes
2467:             ENDIF
2468:             IF USED("crSIGCDRLC")
2469:                 USE IN crSIGCDRLC
2470:             ENDIF
2471:             IF USED("Crs_RPT_C")
2472:                 USE IN Crs_RPT_C
2473:             ENDIF
2474:             IF USED("CrsTmp_SqlResult")
2475:                 USE IN CrsTmp_SqlResult
2476:             ENDIF
2477:             IF USED("CrsProps_Titulo")
2478:                 USE IN CrsProps_Titulo
2479:             ENDIF
2480:             IF USED("CrsProps_Campos")
2481:                 USE IN CrsProps_Campos
2482:             ENDIF

*-- Linhas 2497 a 2540:
2497:     *==========================================================================
2498:     * CriarCursoresDesigner - Cria cursores de trabalho para o designer de layout
2499:     *==========================================================================
2500:     PROTECTED PROCEDURE CriarCursoresDesigner()
2501:         TRY
2502:             *-- Cursor de titulos do relatorio
2503:             IF USED("CrsProps_Titulo")
2504:                 USE IN CrsProps_Titulo
2505:             ENDIF
2506:             CREATE CURSOR CrsProps_Titulo ( ;
2507:                 NmCampo    C(40),  ;
2508:                 TpCampo    C(10),  ;
2509:                 CkOutRPT   I,      ;
2510:                 CkFiltro   I,      ;
2511:                 CkSubTot   I,      ;
2512:                 CkTotal    I,      ;
2513:                 LblCaption C(200), ;
2514:                 LblFonte   C(50),  ;
2515:                 LblBtFonte C(1),   ;
2516:                 LblBtCor   I,      ;
2517:                 LblAlinhar C(6),   ;
2518:                 LblTamCmp  I,      ;
2519:                 LblTipoCmp C(1)    ;
2520:             )
2521: 
2522:             *-- Cursor de campos do relatorio
2523:             IF USED("CrsProps_Campos")
2524:                 USE IN CrsProps_Campos
2525:             ENDIF
2526:             CREATE CURSOR CrsProps_Campos ( ;
2527:                 NmCampo    C(40),  ;
2528:                 TpCampo    C(10),  ;
2529:                 CkOutRPT   I,      ;
2530:                 CkFiltro   I,      ;
2531:                 CkSubTot   I,      ;
2532:                 CkTotal    I,      ;
2533:                 LblCaption C(200), ;
2534:                 LblFonte   C(50),  ;
2535:                 LblBtFonte C(1),   ;
2536:                 LblBtCor   I,      ;
2537:                 LblAlinhar C(6),   ;
2538:                 LblTamCmp  I,      ;
2539:                 LblTipoCmp C(1)    ;
2540:             )

*-- Linhas 2561 a 2802:
2561:     *==========================================================================
2562:     * HabilitarCampos - Habilita ou desabilita campos do formulario de edicao
2563:     *==========================================================================
2564:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2565:         THIS.ConfigurarModoEditor(!par_lHabilitar)
2566:     ENDPROC
2567: 
2568:     *==========================================================================
2569:     * LimparCampos - Limpa todos os campos do formulario de edicao
2570:     *==========================================================================
2571:     PROTECTED PROCEDURE LimparCampos()
2572:         LOCAL loc_oPage, loc_oErro
2573:         TRY
2574:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2575:             loc_oPage.txt_4c_NmReport.Value      = ""
2576:             loc_oPage.edt_4c_Descricao.Value     = ""
2577:             loc_oPage.chk_4c_Ativo.Value         = 1
2578:             loc_oPage.txt_4c_DtCriacao.Value     = ""
2579:             loc_oPage.txt_4c_DtAlteracao.Value   = ""
2580:             loc_oPage.edt_4c_SqlCMD.Value        = ""
2581:             loc_oPage.lbl_4c_SqlAlterado.Caption = ""
2582:         CATCH TO loc_oErro
2583:             MsgErro(loc_oErro.Message, "FormRPT.LimparCampos")
2584:         ENDTRY
2585:     ENDPROC
2586: 
2587:     *==========================================================================
2588:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
2589:     *==========================================================================
2590:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2591:         LOCAL loc_oCnt, loc_lModoLista, loc_lModoEdicao, loc_oErro
2592:         TRY
2593:             loc_lModoLista  = (THIS.this_cModoAtual = "LISTA")
2594:             loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2595: 
2596:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
2597:             loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lModoLista
2598:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lModoLista
2599:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lModoLista
2600:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lModoLista
2601:             loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lModoLista
2602: 
2603:             WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2604:                 .cmd_4c_Confirmar.Enabled = loc_lModoEdicao
2605:                 .cmd_4c_Cancelar.Enabled  = !loc_lModoLista
2606:                 .Visible     = .T.
2607:             ENDWITH
2608:         CATCH TO loc_oErro
2609:             MsgErro(loc_oErro.Message, "FormRPT.AjustarBotoesPorModo")
2610:         ENDTRY
2611:     ENDPROC
2612: 
2613:     *==========================================================================
2614:     * InicializarListas - Cria janelas flutuantes Tabelas (F8) e Variaveis (F9)
2615:     * Equivalente ao Init legado que criava oWLstTABs/oWLstVARs (CreateObject Form)
2616:     *==========================================================================
2617:     PROTECTED PROCEDURE InicializarListas()
2618:         LOCAL loc_nRes
2619:         TRY
2620:             *-- Janela flutuante de Tabelas (F8)
2621:             THIS.this_oWLstTABs = CREATEOBJECT("Form")
2622:             WITH THIS.this_oWLstTABs
2623:                 .BorderStyle       = 1
2624:                 .Caption           = "Tabelas (ESC para fechar)"
2625:                 .HalfHeightCaption = .T.
2626:                 .Left              = 0
2627:                 .Top               = 0
2628:                 .Height            = 280
2629:                 .Width             = 180
2630:                 .Closable          = .F.
2631:                 .MaxButton         = .F.
2632:                 .MinButton         = .F.
2633:                 .Name              = "FrmLstTABs"
2634:                 .ShowTips          = .T.
2635:             ENDWITH
2636:             THIS.this_oWLstTABs.AddObject("Lst_TABs", "ListBox")
2637:             WITH THIS.this_oWLstTABs.Lst_TABs
2638:                 .Left    = 0
2639:                 .Top     = 0
2640:                 .Height  = 280
2641:                 .Width   = 180
2642:                 .Visible = .T.
2643:             ENDWITH
2644:             BINDEVENT(THIS.this_oWLstTABs.Lst_TABs, "DblClick", THIS, "LstTABsDblClick")
2645: 
2646:             *-- Popula lista com tabelas do SQL Server (sys.tables = catalogo)
2647:             IF USED("cursor_4c_Tables")
2648:                 USE IN cursor_4c_Tables
2649:             ENDIF
2650:             loc_nRes = SQLEXEC(gnConnHandle, ;
2651:                 "SELECT UPPER(name) AS NmTable FROM sys.tables ORDER BY name", ;
2652:                 "cursor_4c_Tables")
2653:             IF loc_nRes >= 0
2654:                 SELECT cursor_4c_Tables
2655:                 SCAN
2656:                     THIS.this_oWLstTABs.Lst_TABs.AddItem(ALLTRIM(cursor_4c_Tables.NmTable))
2657:                 ENDSCAN
2658:                 USE IN cursor_4c_Tables
2659:             ENDIF
2660: 
2661:             *-- Janela flutuante de Variaveis (F9)
2662:             THIS.this_oWLstVARs = CREATEOBJECT("Form")
2663:             WITH THIS.this_oWLstVARs
2664:                 .BorderStyle       = 1
2665:                 .Caption           = "Vari" + CHR(225) + "veis (ESC para fechar)"
2666:                 .HalfHeightCaption = .T.
2667:                 .Left              = 0
2668:                 .Top               = 0
2669:                 .Height            = 100
2670:                 .Width             = 180
2671:                 .Closable          = .F.
2672:                 .MaxButton         = .F.
2673:                 .MinButton         = .F.
2674:                 .Name              = "FrmLstVARs"
2675:                 .ShowTips          = .T.
2676:             ENDWITH
2677:             THIS.this_oWLstVARs.AddObject("Lst_VARs", "ListBox")
2678:             WITH THIS.this_oWLstVARs.Lst_VARs
2679:                 .Left    = 0
2680:                 .Top     = 0
2681:                 .Height  = 100
2682:                 .Width   = 180
2683:                 .Visible = .T.
2684:             ENDWITH
2685:             THIS.this_oWLstVARs.Lst_VARs.AddItem("?_vp_DtInicial")
2686:             THIS.this_oWLstVARs.Lst_VARs.AddItem("?_vp_DtFinal")
2687:             BINDEVENT(THIS.this_oWLstVARs.Lst_VARs, "DblClick", THIS, "LstVARsDblClick")
2688: 
2689:             *-- Vincular F8/F9 globalmente via PUBLIC ref (ON Key Label requer scope global)
2690:             PUBLIC g_oFormRPT_4c_
2691:             g_oFormRPT_4c_ = THIS
2692:             ON Key Label F8 g_oFormRPT_4c_.AtivarListas("oWLstTABs")
2693:             ON Key Label F9 g_oFormRPT_4c_.AtivarListas("oWLstVARs")
2694: 
2695:         CATCH TO loc_oErro
2696:             MsgErro(loc_oErro.Message, "FormRPT.InicializarListas")
2697:         ENDTRY
2698:     ENDPROC
2699: 
2700:     *==========================================================================
2701:     * AtivarListas - Exibe ou oculta janela flutuante de Tabelas ou Variaveis
2702:     * PUBLIC: chamado via ON Key Label F8/F9 e pelos labels clicaveis F8/F9
2703:     *==========================================================================
2704:     PROCEDURE AtivarListas(par_cTipo)
2705:         LOCAL loc_oWLst, loc_lProsseguir
2706:         loc_lProsseguir = .T.
2707:         TRY
2708:             IF par_cTipo = "oWLstTABs"
2709:                 loc_oWLst = THIS.this_oWLstTABs
2710:             ELSE
2711:                 loc_oWLst = THIS.this_oWLstVARs
2712:             ENDIF
2713: 
2714:             IF VARTYPE(loc_oWLst) != "O"
2715:                 loc_lProsseguir = .F.
2716:             ENDIF
2717: 
2718:             IF loc_lProsseguir
2719:                 IF loc_oWLst.Visible
2720:                     loc_oWLst.Hide()
2721:                 ELSE
2722:                     loc_oWLst.Top  = 420
2723:                     loc_oWLst.Left = 20
2724:                     loc_oWLst.Show()
2725:                 ENDIF
2726:             ENDIF
2727:         CATCH TO loc_oErro
2728:             MsgErro(loc_oErro.Message, "FormRPT.AtivarListas")
2729:         ENDTRY
2730:     ENDPROC
2731: 
2732:     *==========================================================================
2733:     * LblF8Click - Clique no label "F8" abre lista de Tabelas (equivalente F8 key)
2734:     *==========================================================================
2735:     PROCEDURE LblF8Click()
2736:         TRY
2737:             THIS.AtivarListas("oWLstTABs")
2738:         CATCH TO loc_oErro
2739:             MsgErro(loc_oErro.Message, "FormRPT.LblF8Click")
2740:         ENDTRY
2741:     ENDPROC
2742: 
2743:     *==========================================================================
2744:     * LblF9Click - Clique no label "F9" abre lista de Variaveis (equivalente F9 key)
2745:     *==========================================================================
2746:     PROCEDURE LblF9Click()
2747:         TRY
2748:             THIS.AtivarListas("oWLstVARs")
2749:         CATCH TO loc_oErro
2750:             MsgErro(loc_oErro.Message, "FormRPT.LblF9Click")
2751:         ENDTRY
2752:     ENDPROC
2753: 
2754:     *==========================================================================
2755:     * LstTABsDblClick - Duplo clique em Tabelas insere nome da tabela no editor SQL
2756:     *==========================================================================
2757:     PROCEDURE LstTABsDblClick()
2758:         LOCAL loc_cTabela, loc_oPage
2759:         TRY
2760:             loc_cTabela = ALLTRIM(THIS.this_oWLstTABs.Lst_TABs.DisplayValue)
2761:             IF !EMPTY(loc_cTabela)
2762:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2763:                 loc_oPage.edt_4c_SqlCMD.SelText = loc_cTabela
2764:             ENDIF
2765:             THIS.this_oWLstTABs.Hide()
2766:         CATCH TO loc_oErro
2767:             MsgErro(loc_oErro.Message, "FormRPT.LstTABsDblClick")
2768:         ENDTRY
2769:     ENDPROC
2770: 
2771:     *==========================================================================
2772:     * LstVARsDblClick - Duplo clique em Variaveis insere var no editor SQL
2773:     *==========================================================================
2774:     PROCEDURE LstVARsDblClick()
2775:         LOCAL loc_cVar, loc_oPage
2776:         TRY
2777:             loc_cVar = ALLTRIM(THIS.this_oWLstVARs.Lst_VARs.DisplayValue)
2778:             IF !EMPTY(loc_cVar)
2779:                 loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2780:                 loc_oPage.edt_4c_SqlCMD.SelText = loc_cVar
2781:             ENDIF
2782:             THIS.this_oWLstVARs.Hide()
2783:         CATCH TO loc_oErro
2784:             MsgErro(loc_oErro.Message, "FormRPT.LstVARsDblClick")
2785:         ENDTRY
2786:     ENDPROC
2787: 
2788:     *==========================================================================
2789:     * NmReportLostFocus - Substitui "-" por "~" no nome do relatorio (comportamento legado)
2790:     *==========================================================================
2791:     PROCEDURE NmReportLostFocus(par_nKeyCode, par_nShiftAltCtrl)
2792:         LOCAL loc_oPage
2793:         TRY
2794:             loc_oPage = THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1
2795:             loc_oPage.txt_4c_NmReport.Value = ;
2796:                 STRTRAN(loc_oPage.txt_4c_NmReport.Value, "-", "~")
2797:         CATCH TO loc_oErro
2798:             MsgErro(loc_oErro.Message, "FormRPT.NmReportLostFocus")
2799:         ENDTRY
2800:     ENDPROC
2801: 
2802: ENDDEFINE


### BO (C:\4c\projeto\app\classes\RPTBO.prg):
*------------------------------------------------------------------------------
* RPTBO.prg - Business Object para Cadastro Customizado de Relatorios 4Report
* Herda de BusinessBase
* Tabelas principais: SIGCDRLC (cabecalho), SIGCDRLD (detalhes/layout FRX)
* Migrado de: SIGCDRPT (tasks/task512)
*------------------------------------------------------------------------------
DEFINE CLASS RPTBO AS BusinessBase

    *-- Propriedades: Cabecalho do Relatorio (SIGCDRLC)
    this_cRptId        = ""    && RPT_ID - Chave Primaria: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    this_cNmReport     = ""    && NmReport - Nome do arquivo do report
    this_cDescr        = ""    && Descr - Descricao do report
    this_lAtivo        = .T.   && Ativo - Flag ativo (1=Ativo, 0=Inativo)
    this_dDtCriacao    = {}    && DtCriacao - Data de criacao do report
    this_dDtAlteracao  = {}    && DtAlteracao - Data da ultima alteracao
    this_cSqlQuery     = ""    && SqlQuery - Comando SQL do report (memo)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDRLC"
        THIS.this_cCampoChave = "RPT_ID"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cRptId
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRptId - Gera novo RPT_ID no formato original: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarRptId()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT para listar relatorios no grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso  = .F.
        loc_cFiltro   = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
                       " FROM SIGCDRLC"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE NmReport LIKE " + EscaparSQL("%" + loc_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY NmReport"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar relat" + CHR(243) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do relatorio por RPT_ID
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            MsgErro("RPT_ID inv" + CHR(225) + "lido para carregamento.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorNome - Carrega cabecalho do relatorio por NmReport
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorNome(par_cNmReport)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNmReport) != "C" OR EMPTY(ALLTRIM(par_cNmReport))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE NmReport = " + EscaparSQL(ALLTRIM(par_cNmReport))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSqlQuery - Carrega apenas o SqlQuery de um relatorio (campo memo)
    *--------------------------------------------------------------------------
    FUNCTION CarregarSqlQuery(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.
        loc_cQuery   = ""

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN ""
        ENDIF

        TRY
            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF

            loc_cSQL = "SELECT SqlQuery FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlQuery")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_SqlQuery") > 0
                SELECT cursor_4c_SqlQuery
                loc_cQuery = NVL(SqlQuery, "")
            ENDIF

            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cQuery
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")

            IF PEMSTATUS(ALIAS() + "", "SqlQuery", 5) OR ;
               AFIELDS(laFields, par_cAliasCursor) > 0
                IF ASCAN(laFields, "SQLQUERY") > 0
                    THIS.this_cSqlQuery = TratarNulo(SqlQuery, "C")
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursorCompleto - Mapeia TODOS os campos incluindo SqlQuery
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursorCompleto(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
            THIS.this_cSqlQuery    = TratarNulo(SqlQuery,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursorCompleto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Campo NOME do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Campo SQL do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cRptId
        loc_lSucesso = .F.

        TRY
            *-- Gerar RPT_ID unico no formato original
            loc_cRptId = THIS.GerarRptId()
            THIS.this_cRptId      = loc_cRptId
            THIS.this_dDtCriacao  = DATE()
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                       " (RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cRptId) + ", " + ;
                       EscaparSQL(THIS.this_cNmReport) + ", " + ;
                       EscaparSQL(THIS.this_cDescr) + ", " + ;
                       IIF(THIS.this_lAtivo, "1", "0") + ", " + ;
                       FormatarDataSQL(THIS.this_dDtCriacao) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlteracao) + ", " + ;
                       EscaparSQL(THIS.this_cSqlQuery) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " NmReport = " + EscaparSQL(THIS.this_cNmReport) + "," + ;
                       " Descr = " + EscaparSQL(THIS.this_cDescr) + "," + ;
                       " Ativo = " + IIF(THIS.this_lAtivo, "1", "0") + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + "," + ;
                       " SqlQuery = " + EscaparSQL(THIS.this_cSqlQuery) + ;
                       " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SIGCDRLD + SIGCDRLC (PROTECTED)
    * Ordem obrigatoria: SIGCDRLD primeiro (filhos), depois SIGCDRLC (pai)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para exclus" + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- 1. Excluir detalhes/layout FRX (SIGCDRLD) - filhos primeiro
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhes do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir cabecalho (SIGCDRLC) - pai depois
            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarSqlQuery - Atualiza apenas o campo SqlQuery de um relatorio existente
    * Chamado pelo editor SQL quando o usuario edita a query sem alterar outros campos
    *--------------------------------------------------------------------------
    FUNCTION SalvarSqlQuery(par_cRptId, par_cSqlQuery)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " SqlQuery = " + EscaparSQL(par_cSqlQuery) + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar SQL do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.SalvarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarSqlQuery - Executa o SqlQuery e retorna cursor com resultado
    * Usado pelo editor SQL para pre-visualizar resultados
    *--------------------------------------------------------------------------
    FUNCTION ExecutarSqlQuery(par_cSqlQuery, par_cCursorDestino)
        LOCAL loc_nResultado, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
                           par_cCursorDestino, "cursor_4c_SqlResult")

        IF VARTYPE(par_cSqlQuery) != "C" OR EMPTY(ALLTRIM(par_cSqlQuery))
            MsgAviso("SQL n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ALLTRIM(par_cSqlQuery), loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTabelasSqlServer - Lista tabelas do banco para o editor SQL (F8)
    *--------------------------------------------------------------------------
    FUNCTION BuscarTabelasSqlServer()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Tabelas")
                USE IN cursor_4c_Tabelas
            ENDIF

            loc_cSQL = "SELECT UPPER(Name) AS NmTable, Object_ID, Modify_Date" + ;
                       " FROM sys.tables" + ;
                       " ORDER BY Name"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tabelas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarTabelasSqlServer:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarColunasDaTabela - Lista colunas de uma tabela especifica (F9)
    *--------------------------------------------------------------------------
    FUNCTION BuscarColunasDaTabela(par_cNomeTabela)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNomeTabela) != "C" OR EMPTY(ALLTRIM(par_cNomeTabela))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Colunas")
                USE IN cursor_4c_Colunas
            ENDIF

            loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, c.Max_Length" + ;
                       " FROM sys.all_Columns c" + ;
                       " JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID" + ;
                       " WHERE c.Object_ID = OBJECT_ID(" + EscaparSQL(ALLTRIM(par_cNomeTabela)) + ")" + ;
                       " ORDER BY c.Column_ID"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Colunas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar colunas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarColunasDaTabela:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

