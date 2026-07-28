# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (37)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SAIDA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=3 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_GGrupos' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_GGruposTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_GruposProd' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_GruposProdTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-SQLEXEC] SQLEXEC grava direto no cursor 'cursor_4c_Historico' que eh RecordSource de um Grid. Isso DESTROI as colunas do Grid! SOLUCAO: SQLEXEC em cursor temporario (ex: 'cursor_4c_HistoricoTemp'), depois ZAP + APPEND FROM DBF() no cursor original.
- [GRID-WITH] Bloco WITH ENDWITH define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDWITH.RecordSource).
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Base' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Inicial' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Final' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Encerrado' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo Est.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta Est.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cod.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cod.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Header1, Cód. Barra, Produto, Qtd(1), Local, Cor, Tam, Qtd(2), Barra. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'txt_4c_Estoque' Top=457 (diff=333px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Estoque' (parent: SIGCDBAL.Pagina.Lista): Left original=227 vs migrado 'txt_4c_Estoque' Left=112 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Local' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'cmd_4c_TotalLocal' Top=41 (diff=83px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Local' (parent: SIGCDBAL.Pagina.Lista): Left original=369 vs migrado 'cmd_4c_TotalLocal' Left=303 (diff=66px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'txt_4c_GGrupoFinal' Top=279 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Grupo' (parent: SIGCDBAL.Pagina.Lista): Left original=531 vs migrado 'txt_4c_GGrupoFinal' Left=443 (diff=88px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GGrupo' (parent: SIGCDBAL.Pagina.Lista): Top original=124 vs migrado 'txt_4c_GGrupoFinal' Top=279 (diff=155px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'GGrupo' (parent: SIGCDBAL.Pagina.Lista): Left original=599 vs migrado 'txt_4c_GGrupoFinal' Left=443 (diff=156px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command1' (parent: SIGCDBAL.Pagina.Lista): Top original=83 vs migrado 'cmd_4c_Command1' Top=378 (diff=295px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Command1' (parent: SIGCDBAL.Pagina.Lista): Left original=371 vs migrado 'cmd_4c_Command1' Left=924 (diff=553px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupos' (parent: SIGCDBAL.Pagina.Dados): Top original=98 vs migrado 'lbl_4c_Lbl_grupos' Top=187 (diff=89px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_grupos' (parent: SIGCDBAL.Pagina.Dados): Left original=293 vs migrado 'lbl_4c_Lbl_grupos' Left=23 (diff=270px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDBAL.Pagina.Dados): Top original=313 vs migrado 'lbl_4c_Label19' Top=205 (diff=108px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDBAL.Pagina.Dados): Left original=683 vs migrado 'lbl_4c_Label19' Left=284 (diff=399px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Chk_RepeteObs' (parent: SIGCDBAL.Pagina.Leitura): Left original=679 vs migrado 'chk_4c_Chk_RepeteObs' Left=203 (diff=476px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Cancela' (parent: SIGCDBAL.Pagina.Leitura): Left original=903 vs migrado 'cmd_4c_Cancela' Left=743 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'btnExcluir' (parent: SIGCDBAL.Pagina.Leitura): Left original=754 vs migrado 'cmd_4c_BtnExcluir' Left=678 (diff=76px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormBAL.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (4787 linhas total):

*-- Linhas 29 a 160:
29:     this_cCidchavesSel   = ""
30: 
31:     *--------------------------------------------------------------------------
32:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         LOCAL loc_lResultado
36:         loc_lResultado = .F.
37: 
38:         TRY
39:             loc_lResultado = DODEFAULT()
40:         CATCH TO loc_oErro
41:             MsgErro(loc_oErro.Message, "FormBAL.Init")
42:         ENDTRY
43: 
44:         RETURN loc_lResultado
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Configura estrutura completa
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             SET DATE TO BRITISH
56:             SET CENTURY ON
57: 
58:             THIS.this_oBusinessObject = CREATEOBJECT("BALBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MsgErro("Falha ao criar BALBO", "Erro")
62:             ELSE
63:                 THIS.ConfigurarPageFrame()
64: 
65:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
66:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
67: 
68:                 THIS.pgf_4c_Paginas.Visible    = .T.
69:                 THIS.pgf_4c_Paginas.ActivePage = 1
70:                 THIS.this_cModoAtual = "LISTA"
71: 
72:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
73:                     THIS.CarregarLista()
74:                 ENDIF
75: 
76:                 loc_lResultado = .T.
77:             ENDIF
78:         CATCH TO loc_oErro
79:             MsgErro(loc_oErro.Message, "FormBAL.InicializarForm")
80:         ENDTRY
81: 
82:         RETURN loc_lResultado
83:     ENDPROC
84: 
85:     *--------------------------------------------------------------------------
86:     * ConfigurarPageFrame - Cria PageFrame com 3 Pages
87:     *--------------------------------------------------------------------------
88:     PROTECTED PROCEDURE ConfigurarPageFrame()
89:         LOCAL loc_oPgf
90:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
91:         loc_oPgf = THIS.pgf_4c_Paginas
92: 
93:         WITH loc_oPgf
94:             .PageCount = 3
95:             .Top       = -29
96:             .Left      = 0
97:             .Width     = THIS.Width
98:             .Height    = THIS.Height + 29
99:             .Tabs      = .F.
100:             .Visible   = .T.
101:             .Page1.Caption   = "Lista"
102:             .Page1.BackColor = RGB(100, 100, 100)
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.Caption   = "Dados"
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page3.Caption   = "Leitura"
108:             .Page3.BackColor = RGB(100, 100, 100)
109:             .Page3.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:         ENDWITH
111: 
112:         THIS.ConfigurarPaginaLista()
113:         THIS.ConfigurarPaginaDados()
114:         THIS.ConfigurarPaginaLeitura()
115:     ENDPROC
116: 
117:     *--------------------------------------------------------------------------
118:     * ConfigurarPaginaLista - Cria Page1: lista de inventarios + botoes
119:     *--------------------------------------------------------------------------
120:     PROTECTED PROCEDURE ConfigurarPaginaLista()
121:         LOCAL loc_oPg1, loc_oCab, loc_oSaida
122: 
123:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
124: 
125:         *-- Container cabecalho (Top=2+29=31)
126:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
127:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
128:         WITH loc_oCab
129:             .Top         = 31
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oCab.lbl_4c_Sombra
140:             .AutoSize  = .F.
141:             .Caption   = THIS.Caption
142:             .Top       = 15
143:             .Left      = 10
144:             .Width     = THIS.Width
145:             .Height    = 40
146:             .FontName  = "Tahoma"
147:             .FontSize  = 16
148:             .FontBold  = .T.
149:             .ForeColor = RGB(0, 0, 0)
150:             .BackStyle = 0
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oCab.lbl_4c_Titulo
156:             .AutoSize  = .F.
157:             .Caption   = THIS.Caption
158:             .Top       = 18
159:             .Left      = 10
160:             .Width     = THIS.Width

*-- Linhas 203 a 492:
203:             .Visible         = .T.
204:         ENDWITH
205: 
206:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
207: 
208:         *-- Linha 1 de botoes de acao (Top=83+29=112, Height=40)
209:         *-- Leitura (Left=11, Width=120)
210:         loc_oPg1.AddObject("cmd_4c_Leitura", "CommandButton")
211:         WITH loc_oPg1.cmd_4c_Leitura
212:             .Caption         = "Leitura"
213:             .Picture         = gc_4c_CaminhoIcones + "operacional_leitura_26.jpg"
214:             .PicturePosition = 13
215:             .Top             = 112
216:             .Left            = 11
217:             .Width           = 120
218:             .Height          = 40
219:             .BackColor       = RGB(255, 255, 255)
220:             .ForeColor       = RGB(90, 90, 90)
221:             .FontName        = "Tahoma"
222:             .FontSize        = 8
223:             .FontBold        = .T.
224:             .Themes          = .F.
225:             .SpecialEffect   = 0
226:             .MousePointer    = 15
227:             .WordWrap        = .T.
228:             .AutoSize        = .F.
229:             .Visible         = .T.
230:         ENDWITH
231: 
232:         BINDEVENT(loc_oPg1.cmd_4c_Leitura, "Click", THIS, "BtnLeituraClick")
233: 
234:         *-- Fecha (Left=131, Width=120)
235:         loc_oPg1.AddObject("cmd_4c_Fecha", "CommandButton")
236:         WITH loc_oPg1.cmd_4c_Fecha
237:             .Caption         = "Fecha"
238:             .Picture         = gc_4c_CaminhoIcones + "operacional_fechar_26.jpg"
239:             .PicturePosition = 13
240:             .Top             = 112
241:             .Left            = 131
242:             .Width           = 120
243:             .Height          = 40
244:             .BackColor       = RGB(255, 255, 255)
245:             .ForeColor       = RGB(90, 90, 90)
246:             .FontName        = "Tahoma"
247:             .FontSize        = 8
248:             .FontBold        = .T.
249:             .Themes          = .F.
250:             .SpecialEffect   = 0
251:             .MousePointer    = 15
252:             .WordWrap        = .T.
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256: 
257:         BINDEVENT(loc_oPg1.cmd_4c_Fecha, "Click", THIS, "BtnFechaClick")
258: 
259:         *-- Consulta (Left=251, Width=120)
260:         loc_oPg1.AddObject("cmd_4c_Consulta", "CommandButton")
261:         WITH loc_oPg1.cmd_4c_Consulta
262:             .Caption         = "Consulta"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_26.jpg"
264:             .PicturePosition = 13
265:             .Top             = 112
266:             .Left            = 251
267:             .Width           = 120
268:             .Height          = 40
269:             .BackColor       = RGB(255, 255, 255)
270:             .ForeColor       = RGB(90, 90, 90)
271:             .FontName        = "Tahoma"
272:             .FontSize        = 8
273:             .FontBold        = .T.
274:             .Themes          = .F.
275:             .SpecialEffect   = 0
276:             .MousePointer    = 15
277:             .WordWrap        = .T.
278:             .AutoSize        = .F.
279:             .Visible         = .T.
280:         ENDWITH
281: 
282:         BINDEVENT(loc_oPg1.cmd_4c_Consulta, "Click", THIS, "BtnConsultaClick")
283: 
284:         *-- Exporta (Left=371, Width=120)
285:         loc_oPg1.AddObject("cmd_4c_Command1", "CommandButton")
286:         WITH loc_oPg1.cmd_4c_Command1
287:             .Caption         = "E" + CHR(120) + "porta"
288:             .Picture         = gc_4c_CaminhoIcones + "geral_excel_26.jpg"
289:             .PicturePosition = 13
290:             .Top             = 112
291:             .Left            = 371
292:             .Width           = 120
293:             .Height          = 40
294:             .BackColor       = RGB(255, 255, 255)
295:             .ForeColor       = RGB(90, 90, 90)
296:             .FontName        = "Tahoma"
297:             .FontSize        = 8
298:             .FontBold        = .T.
299:             .Themes          = .F.
300:             .SpecialEffect   = 0
301:             .MousePointer    = 15
302:             .WordWrap        = .T.
303:             .AutoSize        = .F.
304:             .Visible         = .T.
305:         ENDWITH
306: 
307:         BINDEVENT(loc_oPg1.cmd_4c_Command1, "Click", THIS, "BtnExportaClick")
308: 
309:         *-- Inventario/Etiqueta (Left=490, Width=120)
310:         loc_oPg1.AddObject("cmd_4c_Inventario", "CommandButton")
311:         WITH loc_oPg1.cmd_4c_Inventario
312:             .Caption         = "Etiqueta"
313:             .Picture         = gc_4c_CaminhoIcones + "operacional_etiqueta_26.jpg"
314:             .PicturePosition = 13
315:             .Top             = 112
316:             .Left            = 490
317:             .Width           = 120
318:             .Height          = 40
319:             .BackColor       = RGB(255, 255, 255)
320:             .ForeColor       = RGB(90, 90, 90)
321:             .FontName        = "Tahoma"
322:             .FontSize        = 8
323:             .FontBold        = .T.
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331: 
332:         BINDEVENT(loc_oPg1.cmd_4c_Inventario, "Click", THIS, "BtnInventarioClick")
333: 
334:         *-- Linha 2: botoes filtro/acao (Top=124+29=153, Height=20)
335:         *-- Processo (Left=11, Width=63)
336:         loc_oPg1.AddObject("cmd_4c_Processo", "CommandButton")
337:         WITH loc_oPg1.cmd_4c_Processo
338:             .Caption       = "Processo"
339:             .Top           = 153
340:             .Left          = 11
341:             .Width         = 63
342:             .Height        = 20
343:             .FontName      = "Tahoma"
344:             .FontSize      = 8
345:             .Themes        = .F.
346:             .SpecialEffect = 0
347:             .Visible       = .T.
348:         ENDWITH
349: 
350:         BINDEVENT(loc_oPg1.cmd_4c_Processo, "Click", THIS, "BtnProcessoClick")
351: 
352:         *-- Periodo (Left=74, Width=153)
353:         loc_oPg1.AddObject("cmd_4c_Periodo", "CommandButton")
354:         WITH loc_oPg1.cmd_4c_Periodo
355:             .Caption       = "Per" + CHR(237) + "odo"
356:             .Top           = 153
357:             .Left          = 74
358:             .Width         = 153
359:             .Height        = 20
360:             .FontName      = "Tahoma"
361:             .FontSize      = 8
362:             .Themes        = .F.
363:             .SpecialEffect = 0
364:             .Visible       = .T.
365:         ENDWITH
366: 
367:         BINDEVENT(loc_oPg1.cmd_4c_Periodo, "Click", THIS, "BtnOrdenarPeriodoClick")
368: 
369:         *-- Estoque (Left=227, Width=142)
370:         loc_oPg1.AddObject("cmd_4c_Estoque", "CommandButton")
371:         WITH loc_oPg1.cmd_4c_Estoque
372:             .Caption       = "Estoque"
373:             .Top           = 153
374:             .Left          = 227
375:             .Width         = 142
376:             .Height        = 20
377:             .FontName      = "Tahoma"
378:             .FontSize      = 8
379:             .Themes        = .F.
380:             .SpecialEffect = 0
381:             .Visible       = .T.
382:         ENDWITH
383: 
384:         BINDEVENT(loc_oPg1.cmd_4c_Estoque, "Click", THIS, "BtnOrdenarEstoqueClick")
385: 
386:         *-- Local (Left=369, Width=162)
387:         loc_oPg1.AddObject("cmd_4c_Local", "CommandButton")
388:         WITH loc_oPg1.cmd_4c_Local
389:             .Caption       = "Local"
390:             .Top           = 153
391:             .Left          = 369
392:             .Width         = 162
393:             .Height        = 20
394:             .FontName      = "Tahoma"
395:             .FontSize      = 8
396:             .Themes        = .F.
397:             .SpecialEffect = 0
398:             .Visible       = .T.
399:         ENDWITH
400: 
401:         BINDEVENT(loc_oPg1.cmd_4c_Local, "Click", THIS, "BtnOrdenarLocalClick")
402: 
403:         *-- Grupo (Left=531, Width=68)
404:         loc_oPg1.AddObject("cmd_4c_Grupo", "CommandButton")
405:         WITH loc_oPg1.cmd_4c_Grupo
406:             .Caption       = "Grupo"
407:             .Top           = 153
408:             .Left          = 531
409:             .Width         = 68
410:             .Height        = 20
411:             .FontName      = "Tahoma"
412:             .FontSize      = 8
413:             .Themes        = .F.
414:             .SpecialEffect = 0
415:             .Visible       = .T.
416:         ENDWITH
417: 
418:         BINDEVENT(loc_oPg1.cmd_4c_Grupo, "Click", THIS, "BtnOrdenarGrupoClick")
419: 
420:         *-- GGrupo (Left=599, Width=68)
421:         loc_oPg1.AddObject("cmd_4c_GGrupo", "CommandButton")
422:         WITH loc_oPg1.cmd_4c_GGrupo
423:             .Caption       = "Gde.Grupo"
424:             .Top           = 153
425:             .Left          = 599
426:             .Width         = 68
427:             .Height        = 20
428:             .FontName      = "Tahoma"
429:             .FontSize      = 8
430:             .Themes        = .F.
431:             .SpecialEffect = 0
432:             .Visible       = .T.
433:         ENDWITH
434: 
435:         BINDEVENT(loc_oPg1.cmd_4c_GGrupo, "Click", THIS, "BtnOrdenarGGrupoClick")
436: 
437:         *-- Usuario (Left=667, Width=80)
438:         loc_oPg1.AddObject("cmd_4c_Usuario", "CommandButton")
439:         WITH loc_oPg1.cmd_4c_Usuario
440:             .Caption       = "Usu" + CHR(225) + "rio"
441:             .Top           = 153
442:             .Left          = 667
443:             .Width         = 80
444:             .Height        = 20
445:             .FontName      = "Tahoma"
446:             .FontSize      = 8
447:             .Themes        = .F.
448:             .SpecialEffect = 0
449:             .Visible       = .T.
450:         ENDWITH
451: 
452:         BINDEVENT(loc_oPg1.cmd_4c_Usuario, "Click", THIS, "BtnOrdenarUsuarioClick")
453: 
454:         *-- Grid listagem (Top=175, Left=12, Width=905, Height=390)
455:         *-- RecordSource e ColumnCount FORA do WITH (VFP9: colunas criadas em Columns())
456:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
457:         loc_oPg1.grd_4c_Lista.RecordSource = ""
458:         loc_oPg1.grd_4c_Lista.ColumnCount  = 8
459: 
460:         WITH loc_oPg1.grd_4c_Lista
461:             .Top                = 175
462:             .Left               = 12
463:             .Width              = 905
464:             .Height             = 390
465:             .FontName           = "Verdana"
466:             .FontSize           = 8
467:             .ForeColor          = RGB(90, 90, 90)
468:             .BackColor          = RGB(255, 255, 255)
469:             .GridLineColor      = RGB(238, 238, 238)
470:             .HighlightBackColor = RGB(255, 255, 255)
471:             .HighlightForeColor = RGB(15, 41, 104)
472:             .HighlightStyle     = 2
473:             .DeleteMark         = .F.
474:             .RecordMark         = .F.
475:             .RowHeight          = 16
476:             .ScrollBars         = 3
477:             .GridLines          = 3
478:             .ReadOnly           = .T.
479:             .Visible            = .T.
480:             .Column1.Width      = 55
481:             .Column2.Width      = 85
482:             .Column3.Width      = 85
483:             .Column4.Width      = 85
484:             .Column5.Width      = 70
485:             .Column6.Width      = 100
486:             .Column7.Width      = 100
487:             .Column8.Width      = 90
488:             .Column1.ReadOnly   = .T.
489:             .Column2.ReadOnly   = .T.
490:             .Column3.ReadOnly   = .T.
491:             .Column4.ReadOnly   = .T.
492:             .Column5.ReadOnly   = .T.

*-- Linhas 503 a 616:
503:             .Column8.Header1.Caption = "Usu" + CHR(225) + "rio"
504:         ENDWITH
505: 
506:         THIS.TornarControlesVisiveis(loc_oPg1)
507:     ENDPROC
508: 
509:     *--------------------------------------------------------------------------
510:     * ConfigurarPaginaDados - Cria Page2: parametros de filtro do inventario
511:     *--------------------------------------------------------------------------
512:     PROTECTED PROCEDURE ConfigurarPaginaDados()
513:         LOCAL loc_oPg2, loc_oGrdGGrupo, loc_oGrdGrupo
514: 
515:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
516: 
517:         *-- Container botoes Confirmar/Cancelar (Top=29, Left=842)
518:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
519:         WITH loc_oPg2.cnt_4c_BotoesAcao
520:             .Top         = 29
521:             .Left        = 842
522:             .Width       = 160
523:             .Height      = 85
524:             .BackStyle   = 0
525:             .BorderWidth = 0
526:             .Visible     = .T.
527:         ENDWITH
528: 
529:         loc_oPg2.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
530:         WITH loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
531:             .Caption         = "Confirmar"
532:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
533:             .PicturePosition = 13
534:             .Top             = 5
535:             .Left            = 5
536:             .Width           = 75
537:             .Height          = 75
538:             .BackColor       = RGB(255, 255, 255)
539:             .ForeColor       = RGB(90, 90, 90)
540:             .FontName        = "Tahoma"
541:             .FontSize        = 8
542:             .FontBold        = .T.
543:             .FontItalic      = .T.
544:             .Themes          = .F.
545:             .SpecialEffect   = 0
546:             .MousePointer    = 15
547:             .WordWrap        = .T.
548:             .AutoSize        = .F.
549:             .Visible         = .T.
550:         ENDWITH
551: 
552:         loc_oPg2.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
553:         WITH loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar
554:             .Caption         = "Encerrar"
555:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
556:             .PicturePosition = 13
557:             .Top             = 5
558:             .Left            = 80
559:             .Width           = 75
560:             .Height          = 75
561:             .BackColor       = RGB(255, 255, 255)
562:             .ForeColor       = RGB(90, 90, 90)
563:             .FontName        = "Tahoma"
564:             .FontSize        = 8
565:             .FontBold        = .T.
566:             .FontItalic      = .T.
567:             .Themes          = .F.
568:             .SpecialEffect   = 0
569:             .MousePointer    = 15
570:             .WordWrap        = .T.
571:             .AutoSize        = .F.
572:             .Visible         = .T.
573:         ENDWITH
574: 
575:         BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
576:         BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
577: 
578:         *-- LINHA 1: Codigo (Left=336, Top=68+29=97) + Data Base (Left=572, Top=97)
579:         *-- Say3: "Codigo :" (Top=101, Left=289, Width=42)
580:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
581:         WITH loc_oPg2.lbl_4c_Label3
582:             .Caption   = "C" + CHR(243) + "digo :"
583:             .Top       = 101
584:             .Left      = 289
585:             .Width     = 42
586:             .AutoSize  = .F.
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .ForeColor = RGB(255, 255, 255)
590:             .BackStyle = 0
591:             .Alignment = 1
592:             .Visible   = .T.
593:         ENDWITH
594: 
595:         loc_oPg2.AddObject("txt_4c_Codigo", "TextBox")
596:         WITH loc_oPg2.txt_4c_Codigo
597:             .Value         = 0
598:             .Top           = 97
599:             .Left          = 336
600:             .Width         = 82
601:             .Height        = 23
602:             .FontName      = "Tahoma"
603:             .FontSize      = 8
604:             .ForeColor     = RGB(90, 90, 90)
605:             .BackColor     = RGB(255, 255, 255)
606:             .BorderStyle   = 1
607:             .SpecialEffect = 0
608:             .ReadOnly      = .T.
609:             .Visible       = .T.
610:         ENDWITH
611: 
612:         *-- Say15: "Data Base :" (Top=101, Left=500, Width=58)
613:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
614:         WITH loc_oPg2.lbl_4c_Label15
615:             .Caption   = "Data Base :"
616:             .Top       = 101

*-- Linhas 676 a 719:
676:             .Visible       = .T.
677:         ENDWITH
678: 
679:         BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress", THIS, "KeyPressGrupo")
680: 
681:         *-- Get_DGrupo: descricao do grupo (Top=123, Left=421, Width=232)
682:         loc_oPg2.AddObject("txt_4c_DGrupo", "TextBox")
683:         WITH loc_oPg2.txt_4c_DGrupo
684:             .Value         = ""
685:             .Top           = 123
686:             .Left          = 421
687:             .Width         = 232
688:             .Height        = 23
689:             .FontName      = "Tahoma"
690:             .FontSize      = 8
691:             .ForeColor     = RGB(90, 90, 90)
692:             .BackColor     = RGB(240, 240, 240)
693:             .BorderStyle   = 1
694:             .SpecialEffect = 0
695:             .ReadOnly      = .T.
696:             .Visible       = .T.
697:         ENDWITH
698: 
699:         *-- LINHA 3: Conta/Estoque (Left=336, Top=120+29=149)
700:         *-- Say12: "Estoque :" (Top=153, Left=283, Width=48)
701:         loc_oPg2.AddObject("lbl_4c_Label12", "Label")
702:         WITH loc_oPg2.lbl_4c_Label12
703:             .Caption   = "Estoque :"
704:             .Top       = 153
705:             .Left      = 283
706:             .Width     = 48
707:             .AutoSize  = .F.
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .ForeColor = RGB(255, 255, 255)
711:             .BackStyle = 0
712:             .Alignment = 1
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
717:         WITH loc_oPg2.txt_4c_Conta
718:             .Value         = ""
719:             .Top           = 149

*-- Linhas 730 a 773:
730:             .Visible       = .T.
731:         ENDWITH
732: 
733:         BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress", THIS, "KeyPressConta")
734: 
735:         *-- Get_DConta: descricao conta (Top=149, Left=421, Width=232)
736:         loc_oPg2.AddObject("txt_4c_DConta", "TextBox")
737:         WITH loc_oPg2.txt_4c_DConta
738:             .Value         = ""
739:             .Top           = 149
740:             .Left          = 421
741:             .Width         = 232
742:             .Height        = 23
743:             .FontName      = "Tahoma"
744:             .FontSize      = 8
745:             .ForeColor     = RGB(90, 90, 90)
746:             .BackColor     = RGB(240, 240, 240)
747:             .BorderStyle   = 1
748:             .SpecialEffect = 0
749:             .ReadOnly      = .T.
750:             .Visible       = .T.
751:         ENDWITH
752: 
753:         *-- LINHA 4: Data (Top=146+29=175) - Get_DataFinal + Get_DataInicial
754:         *-- Say1: "Data :" (Top=180, Left=299, Width=32)
755:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
756:         WITH loc_oPg2.lbl_4c_Label1
757:             .Caption   = "Data :"
758:             .Top       = 180
759:             .Left      = 299
760:             .Width     = 32
761:             .AutoSize  = .F.
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .ForeColor = RGB(255, 255, 255)
765:             .BackStyle = 0
766:             .Alignment = 1
767:             .Visible   = .T.
768:         ENDWITH
769: 
770:         loc_oPg2.AddObject("txt_4c_DataFinal", "TextBox")
771:         WITH loc_oPg2.txt_4c_DataFinal
772:             .Value         = {}
773:             .Top           = 175

*-- Linhas 835 a 981:
835:             .Visible       = .T.
836:         ENDWITH
837: 
838:         BINDEVENT(loc_oPg2.txt_4c_CProsI, "KeyPress", THIS, "KeyPressCProsI")
839: 
840:         *-- Say20: "a" separator (Top=205, Left=446, Width=14)
841:         loc_oPg2.AddObject("lbl_4c_Label20", "Label")
842:         WITH loc_oPg2.lbl_4c_Label20
843:             .Caption   = CHR(224)
844:             .Top       = 205
845:             .Left      = 446
846:             .Width     = 14
847:             .AutoSize  = .F.
848:             .FontName  = "Tahoma"
849:             .FontSize  = 8
850:             .ForeColor = RGB(255, 255, 255)
851:             .BackStyle = 0
852:             .Visible   = .T.
853:         ENDWITH
854: 
855:         loc_oPg2.AddObject("txt_4c_CProsF", "TextBox")
856:         WITH loc_oPg2.txt_4c_CProsF
857:             .Value         = ""
858:             .Top           = 201
859:             .Left          = 464
860:             .Width         = 108
861:             .Height        = 23
862:             .FontName      = "Tahoma"
863:             .FontSize      = 8
864:             .ForeColor     = RGB(90, 90, 90)
865:             .BackColor     = RGB(255, 255, 255)
866:             .BorderStyle   = 1
867:             .SpecialEffect = 0
868:             .MaxLength     = 14
869:             .Visible       = .T.
870:         ENDWITH
871: 
872:         BINDEVENT(loc_oPg2.txt_4c_CProsF, "KeyPress", THIS, "KeyPressCProsF")
873: 
874:         *-- LINHA 6: Local (Top=198+29=227)
875:         *-- Say2: "Local :" (Top=231, Left=298, Width=33)
876:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
877:         WITH loc_oPg2.lbl_4c_Label2
878:             .Caption   = "Local :"
879:             .Top       = 231
880:             .Left      = 298
881:             .Width     = 33
882:             .AutoSize  = .F.
883:             .FontName  = "Tahoma"
884:             .FontSize  = 8
885:             .ForeColor = RGB(255, 255, 255)
886:             .BackStyle = 0
887:             .Alignment = 1
888:             .Visible   = .T.
889:         ENDWITH
890: 
891:         loc_oPg2.AddObject("txt_4c_LocalInicial", "TextBox")
892:         WITH loc_oPg2.txt_4c_LocalInicial
893:             .Value         = ""
894:             .Top           = 227
895:             .Left          = 336
896:             .Width         = 82
897:             .Height        = 23
898:             .FontName      = "Tahoma"
899:             .FontSize      = 8
900:             .ForeColor     = RGB(90, 90, 90)
901:             .BackColor     = RGB(255, 255, 255)
902:             .BorderStyle   = 1
903:             .SpecialEffect = 0
904:             .MaxLength     = 10
905:             .Visible       = .T.
906:         ENDWITH
907: 
908:         BINDEVENT(loc_oPg2.txt_4c_LocalInicial, "KeyPress", THIS, "KeyPressLocalInicial")
909: 
910:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
911:         WITH loc_oPg2.lbl_4c_Label5
912:             .Caption   = CHR(224)
913:             .Top       = 231
914:             .Left      = 423
915:             .Width     = 14
916:             .AutoSize  = .F.
917:             .FontName  = "Tahoma"
918:             .FontSize  = 8
919:             .ForeColor = RGB(255, 255, 255)
920:             .BackStyle = 0
921:             .Visible   = .T.
922:         ENDWITH
923: 
924:         loc_oPg2.AddObject("txt_4c_LocalFinal", "TextBox")
925:         WITH loc_oPg2.txt_4c_LocalFinal
926:             .Value         = ""
927:             .Top           = 227
928:             .Left          = 443
929:             .Width         = 82
930:             .Height        = 23
931:             .FontName      = "Tahoma"
932:             .FontSize      = 8
933:             .ForeColor     = RGB(90, 90, 90)
934:             .BackColor     = RGB(255, 255, 255)
935:             .BorderStyle   = 1
936:             .SpecialEffect = 0
937:             .MaxLength     = 10
938:             .Visible       = .T.
939:         ENDWITH
940: 
941:         BINDEVENT(loc_oPg2.txt_4c_LocalFinal, "KeyPress", THIS, "KeyPressLocalFinal")
942: 
943:         *-- LINHA 7: Fornecedor (Top=224+29=253)
944:         *-- Say6: "Fornecedor :" (Top=257, Left=267, Width=64)
945:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
946:         WITH loc_oPg2.lbl_4c_Label6
947:             .Caption   = "Fornecedor :"
948:             .Top       = 257
949:             .Left      = 267
950:             .Width     = 64
951:             .Height    = 15
952:             .AutoSize  = .F.
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .ForeColor = RGB(255, 255, 255)
956:             .BackStyle = 0
957:             .Alignment = 1
958:             .Visible   = .T.
959:         ENDWITH
960: 
961:         loc_oPg2.AddObject("txt_4c_FornecInicial", "TextBox")
962:         WITH loc_oPg2.txt_4c_FornecInicial
963:             .Value         = ""
964:             .Top           = 253
965:             .Left          = 336
966:             .Width         = 82
967:             .Height        = 23
968:             .FontName      = "Tahoma"
969:             .FontSize      = 8
970:             .ForeColor     = RGB(90, 90, 90)
971:             .BackColor     = RGB(255, 255, 255)
972:             .BorderStyle   = 1
973:             .SpecialEffect = 0
974:             .MaxLength     = 10
975:             .Visible       = .T.
976:         ENDWITH
977: 
978:         loc_oPg2.AddObject("lbl_4c_Label7", "Label")
979:         WITH loc_oPg2.lbl_4c_Label7
980:             .Caption   = CHR(224)
981:             .Top       = 257

*-- Linhas 1006 a 1188:
1006:             .Visible       = .T.
1007:         ENDWITH
1008: 
1009:         BINDEVENT(loc_oPg2.txt_4c_FornecInicial, "KeyPress", THIS, "KeyPressFornecInicial")
1010:         BINDEVENT(loc_oPg2.txt_4c_FornecFinal,   "KeyPress", THIS, "KeyPressFornecFinal")
1011: 
1012:         *-- LINHA 8: Grande Grupo (Top=250+29=279)
1013:         *-- Say13: "Grande Grupo :" (Top=283, Left=255, Width=76)
1014:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
1015:         WITH loc_oPg2.lbl_4c_Label13
1016:             .Caption   = "Grande Grupo :"
1017:             .Top       = 283
1018:             .Left      = 255
1019:             .Width     = 76
1020:             .AutoSize  = .F.
1021:             .FontName  = "Tahoma"
1022:             .FontSize  = 8
1023:             .ForeColor = RGB(255, 255, 255)
1024:             .BackStyle = 0
1025:             .Alignment = 1
1026:             .Visible   = .T.
1027:         ENDWITH
1028: 
1029:         loc_oPg2.AddObject("txt_4c_GGrupoInicial", "TextBox")
1030:         WITH loc_oPg2.txt_4c_GGrupoInicial
1031:             .Value         = ""
1032:             .Top           = 279
1033:             .Left          = 336
1034:             .Width         = 34
1035:             .Height        = 23
1036:             .FontName      = "Tahoma"
1037:             .FontSize      = 8
1038:             .ForeColor     = RGB(90, 90, 90)
1039:             .BackColor     = RGB(255, 255, 255)
1040:             .BorderStyle   = 1
1041:             .SpecialEffect = 0
1042:             .MaxLength     = 3
1043:             .Visible       = .T.
1044:         ENDWITH
1045: 
1046:         BINDEVENT(loc_oPg2.txt_4c_GGrupoInicial, "KeyPress", THIS, "KeyPressGGrupoInicial")
1047: 
1048:         loc_oPg2.AddObject("lbl_4c_Label14", "Label")
1049:         WITH loc_oPg2.lbl_4c_Label14
1050:             .Caption   = CHR(224)
1051:             .Top       = 283
1052:             .Left      = 423
1053:             .Width     = 14
1054:             .AutoSize  = .F.
1055:             .FontName  = "Tahoma"
1056:             .FontSize  = 8
1057:             .ForeColor = RGB(255, 255, 255)
1058:             .BackStyle = 0
1059:             .Visible   = .T.
1060:         ENDWITH
1061: 
1062:         loc_oPg2.AddObject("txt_4c_GGrupoFinal", "TextBox")
1063:         WITH loc_oPg2.txt_4c_GGrupoFinal
1064:             .Value         = ""
1065:             .Top           = 279
1066:             .Left          = 443
1067:             .Width         = 34
1068:             .Height        = 23
1069:             .FontName      = "Tahoma"
1070:             .FontSize      = 8
1071:             .ForeColor     = RGB(90, 90, 90)
1072:             .BackColor     = RGB(255, 255, 255)
1073:             .BorderStyle   = 1
1074:             .SpecialEffect = 0
1075:             .MaxLength     = 3
1076:             .Visible       = .T.
1077:         ENDWITH
1078: 
1079:         BINDEVENT(loc_oPg2.txt_4c_GGrupoFinal, "KeyPress", THIS, "KeyPressGGrupoFinal")
1080: 
1081:         *-- LINHA 9: Grupo Produto (Top=276+29=305)
1082:         *-- Say8: "Grupo :" (Top=309, Left=293, Width=38)
1083:         loc_oPg2.AddObject("lbl_4c_Label8", "Label")
1084:         WITH loc_oPg2.lbl_4c_Label8
1085:             .Caption   = "Grupo :"
1086:             .Top       = 309
1087:             .Left      = 293
1088:             .Width     = 38
1089:             .AutoSize  = .F.
1090:             .FontName  = "Tahoma"
1091:             .FontSize  = 8
1092:             .ForeColor = RGB(255, 255, 255)
1093:             .BackStyle = 0
1094:             .Alignment = 1
1095:             .Visible   = .T.
1096:         ENDWITH
1097: 
1098:         loc_oPg2.AddObject("txt_4c_GrupoInicial", "TextBox")
1099:         WITH loc_oPg2.txt_4c_GrupoInicial
1100:             .Value         = ""
1101:             .Top           = 305
1102:             .Left          = 336
1103:             .Width         = 34
1104:             .Height        = 23
1105:             .FontName      = "Tahoma"
1106:             .FontSize      = 8
1107:             .ForeColor     = RGB(90, 90, 90)
1108:             .BackColor     = RGB(255, 255, 255)
1109:             .BorderStyle   = 1
1110:             .SpecialEffect = 0
1111:             .MaxLength     = 3
1112:             .Visible       = .T.
1113:         ENDWITH
1114: 
1115:         BINDEVENT(loc_oPg2.txt_4c_GrupoInicial, "KeyPress", THIS, "KeyPressGrupoInicial")
1116: 
1117:         loc_oPg2.AddObject("lbl_4c_Label9", "Label")
1118:         WITH loc_oPg2.lbl_4c_Label9
1119:             .Caption   = CHR(224)
1120:             .Top       = 309
1121:             .Left      = 423
1122:             .Width     = 14
1123:             .AutoSize  = .F.
1124:             .FontName  = "Tahoma"
1125:             .FontSize  = 8
1126:             .ForeColor = RGB(255, 255, 255)
1127:             .BackStyle = 0
1128:             .Visible   = .T.
1129:         ENDWITH
1130: 
1131:         loc_oPg2.AddObject("txt_4c_GrupoFinal", "TextBox")
1132:         WITH loc_oPg2.txt_4c_GrupoFinal
1133:             .Value         = ""
1134:             .Top           = 305
1135:             .Left          = 443
1136:             .Width         = 34
1137:             .Height        = 23
1138:             .FontName      = "Tahoma"
1139:             .FontSize      = 8
1140:             .ForeColor     = RGB(90, 90, 90)
1141:             .BackColor     = RGB(255, 255, 255)
1142:             .BorderStyle   = 1
1143:             .SpecialEffect = 0
1144:             .MaxLength     = 3
1145:             .Visible       = .T.
1146:         ENDWITH
1147: 
1148:         BINDEVENT(loc_oPg2.txt_4c_GrupoFinal, "KeyPress", THIS, "KeyPressGrupoFinal")
1149: 
1150:         *-- LINHA 10: Subgrupo (Top=301+29=330)
1151:         *-- Say23: "Subgrupo :" (Top=334, Left=276, Width=55)
1152:         loc_oPg2.AddObject("lbl_4c_Label23", "Label")
1153:         WITH loc_oPg2.lbl_4c_Label23
1154:             .Caption   = "Subgrupo :"
1155:             .Top       = 334
1156:             .Left      = 276
1157:             .Width     = 55
1158:             .AutoSize  = .F.
1159:             .FontName  = "Tahoma"
1160:             .FontSize  = 8
1161:             .ForeColor = RGB(255, 255, 255)
1162:             .BackStyle = 0
1163:             .Alignment = 1
1164:             .Visible   = .T.
1165:         ENDWITH
1166: 
1167:         loc_oPg2.AddObject("txt_4c_SGrusI", "TextBox")
1168:         WITH loc_oPg2.txt_4c_SGrusI
1169:             .Value         = ""
1170:             .Top           = 330
1171:             .Left          = 336
1172:             .Width         = 52
1173:             .Height        = 23
1174:             .FontName      = "Tahoma"
1175:             .FontSize      = 8
1176:             .ForeColor     = RGB(90, 90, 90)
1177:             .BackColor     = RGB(255, 255, 255)
1178:             .BorderStyle   = 1
1179:             .SpecialEffect = 0
1180:             .MaxLength     = 6
1181:             .Visible       = .T.
1182:         ENDWITH
1183: 
1184:         loc_oPg2.AddObject("lbl_4c_Label24", "Label")
1185:         WITH loc_oPg2.lbl_4c_Label24
1186:             .Caption   = CHR(224)
1187:             .Top       = 334
1188:             .Left      = 423

*-- Linhas 1212 a 1256:
1212:             .Visible       = .T.
1213:         ENDWITH
1214: 
1215:         BINDEVENT(loc_oPg2.txt_4c_SGrusI, "KeyPress", THIS, "KeyPressSGrusI")
1216:         BINDEVENT(loc_oPg2.txt_4c_SGrusF, "KeyPress", THIS, "KeyPressSGrusF")
1217: 
1218:         *-- LINHA 11: Preco (Top=326+29=355)
1219:         *-- Say10: "Preco :" (Top=359, Left=295, Width=36)
1220:         loc_oPg2.AddObject("lbl_4c_Label10", "Label")
1221:         WITH loc_oPg2.lbl_4c_Label10
1222:             .Caption   = "Pre" + CHR(231) + "o :"
1223:             .Top       = 359
1224:             .Left      = 295
1225:             .Width     = 36
1226:             .Height    = 15
1227:             .AutoSize  = .F.
1228:             .FontName  = "Tahoma"
1229:             .FontSize  = 8
1230:             .ForeColor = RGB(255, 255, 255)
1231:             .BackStyle = 0
1232:             .Alignment = 1
1233:             .Visible   = .T.
1234:         ENDWITH
1235: 
1236:         loc_oPg2.AddObject("txt_4c_PrecoInicial", "TextBox")
1237:         WITH loc_oPg2.txt_4c_PrecoInicial
1238:             .Value         = 0
1239:             .Top           = 355
1240:             .Left          = 336
1241:             .Width         = 82
1242:             .Height        = 23
1243:             .FontName      = "Tahoma"
1244:             .FontSize      = 8
1245:             .ForeColor     = RGB(90, 90, 90)
1246:             .BackColor     = RGB(255, 255, 255)
1247:             .BorderStyle   = 1
1248:             .SpecialEffect = 0
1249:             .Format        = "K"
1250:             .Visible       = .T.
1251:         ENDWITH
1252: 
1253:         loc_oPg2.AddObject("lbl_4c_Label11", "Label")
1254:         WITH loc_oPg2.lbl_4c_Label11
1255:             .Caption   = CHR(224)
1256:             .Top       = 359

*-- Linhas 1315 a 1391:
1315:             .Visible       = .T.
1316:         ENDWITH
1317: 
1318:         BINDEVENT(loc_oPg2.txt_4c_Lin, "KeyPress", THIS, "KeyPressLin")
1319: 
1320:         loc_oPg2.AddObject("lbl_4c_Label18", "Label")
1321:         WITH loc_oPg2.lbl_4c_Label18
1322:             .Caption   = CHR(224)
1323:             .Top       = 384
1324:             .Left      = 423
1325:             .Width     = 14
1326:             .AutoSize  = .F.
1327:             .FontName  = "Tahoma"
1328:             .FontSize  = 8
1329:             .ForeColor = RGB(255, 255, 255)
1330:             .BackStyle = 0
1331:             .Visible   = .T.
1332:         ENDWITH
1333: 
1334:         loc_oPg2.AddObject("txt_4c_Lin2", "TextBox")
1335:         WITH loc_oPg2.txt_4c_Lin2
1336:             .Value         = ""
1337:             .Top           = 380
1338:             .Left          = 443
1339:             .Width         = 82
1340:             .Height        = 23
1341:             .FontName      = "Tahoma"
1342:             .FontSize      = 8
1343:             .ForeColor     = RGB(90, 90, 90)
1344:             .BackColor     = RGB(255, 255, 255)
1345:             .BorderStyle   = 1
1346:             .SpecialEffect = 0
1347:             .MaxLength     = 10
1348:             .Visible       = .T.
1349:         ENDWITH
1350: 
1351:         BINDEVENT(loc_oPg2.txt_4c_Lin2, "KeyPress", THIS, "KeyPressLin2")
1352: 
1353:         *-- LINHA 13: Grupo de Venda/Colecao (Top=376+29=405)
1354:         *-- Say22: "Grupo de Venda :" (Top=409, Left=245, Width=86)
1355:         loc_oPg2.AddObject("lbl_4c_Label22", "Label")
1356:         WITH loc_oPg2.lbl_4c_Label22
1357:             .Caption   = "Grupo de Venda :"
1358:             .Top       = 409
1359:             .Left      = 245
1360:             .Width     = 86
1361:             .Height    = 15
1362:             .AutoSize  = .F.
1363:             .FontName  = "Tahoma"
1364:             .FontSize  = 8
1365:             .ForeColor = RGB(255, 255, 255)
1366:             .BackStyle = 0
1367:             .Visible   = .T.
1368:         ENDWITH
1369: 
1370:         loc_oPg2.AddObject("txt_4c_ColecoesI", "TextBox")
1371:         WITH loc_oPg2.txt_4c_ColecoesI
1372:             .Value         = ""
1373:             .Top           = 405
1374:             .Left          = 336
1375:             .Width         = 82
1376:             .Height        = 23
1377:             .FontName      = "Tahoma"
1378:             .FontSize      = 8
1379:             .ForeColor     = RGB(90, 90, 90)
1380:             .BackColor     = RGB(255, 255, 255)
1381:             .BorderStyle   = 1
1382:             .SpecialEffect = 0
1383:             .MaxLength     = 10
1384:             .Visible       = .T.
1385:         ENDWITH
1386: 
1387:         loc_oPg2.AddObject("lbl_4c_Label21", "Label")
1388:         WITH loc_oPg2.lbl_4c_Label21
1389:             .Caption   = CHR(224)
1390:             .Top       = 409
1391:             .Left      = 423

*-- Linhas 1415 a 1624:
1415:             .Visible       = .T.
1416:         ENDWITH
1417: 
1418:         BINDEVENT(loc_oPg2.txt_4c_ColecoesI, "KeyPress", THIS, "KeyPressColecoesI")
1419:         BINDEVENT(loc_oPg2.txt_4c_ColecoesF, "KeyPress", THIS, "KeyPressColecoesF")
1420: 
1421:         *-- LINHA 14: Unidade (Top=402+29=431)
1422:         *-- Say26: "Unidade :" (Top=435, Left=283, Width=48)
1423:         loc_oPg2.AddObject("lbl_4c_Label26", "Label")
1424:         WITH loc_oPg2.lbl_4c_Label26
1425:             .Caption   = "Unidade :"
1426:             .Top       = 435
1427:             .Left      = 283
1428:             .Width     = 48
1429:             .Height    = 15
1430:             .AutoSize  = .F.
1431:             .FontName  = "Tahoma"
1432:             .FontSize  = 8
1433:             .ForeColor = RGB(255, 255, 255)
1434:             .BackStyle = 0
1435:             .Visible   = .T.
1436:         ENDWITH
1437: 
1438:         loc_oPg2.AddObject("txt_4c__UniIni", "TextBox")
1439:         WITH loc_oPg2.txt_4c__UniIni
1440:             .Value         = ""
1441:             .Top           = 431
1442:             .Left          = 336
1443:             .Width         = 40
1444:             .Height        = 23
1445:             .FontName      = "Tahoma"
1446:             .FontSize      = 8
1447:             .ForeColor     = RGB(90, 90, 90)
1448:             .BackColor     = RGB(255, 255, 255)
1449:             .BorderStyle   = 1
1450:             .SpecialEffect = 0
1451:             .MaxLength     = 3
1452:             .Visible       = .T.
1453:         ENDWITH
1454: 
1455:         BINDEVENT(loc_oPg2.txt_4c__UniIni, "KeyPress", THIS, "KeyPressUniIni")
1456: 
1457:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
1458:         WITH loc_oPg2.lbl_4c_Label4
1459:             .Caption   = CHR(224)
1460:             .Top       = 435
1461:             .Left      = 423
1462:             .Width     = 14
1463:             .AutoSize  = .F.
1464:             .FontName  = "Tahoma"
1465:             .FontSize  = 8
1466:             .ForeColor = RGB(255, 255, 255)
1467:             .BackStyle = 0
1468:             .Visible   = .T.
1469:         ENDWITH
1470: 
1471:         loc_oPg2.AddObject("txt_4c__UniFim", "TextBox")
1472:         WITH loc_oPg2.txt_4c__UniFim
1473:             .Value         = ""
1474:             .Top           = 431
1475:             .Left          = 443
1476:             .Width         = 40
1477:             .Height        = 23
1478:             .FontName      = "Tahoma"
1479:             .FontSize      = 8
1480:             .ForeColor     = RGB(90, 90, 90)
1481:             .BackColor     = RGB(255, 255, 255)
1482:             .BorderStyle   = 1
1483:             .SpecialEffect = 0
1484:             .MaxLength     = 3
1485:             .Visible       = .T.
1486:         ENDWITH
1487: 
1488:         BINDEVENT(loc_oPg2.txt_4c__UniFim, "KeyPress", THIS, "KeyPressUniFim")
1489: 
1490:         *-- LINHA 15: Observacao 1 / Obs por peso (Top=427+29=456)
1491:         *-- Say25: "Observacao 1:" (Top=460, Left=258, Width=73)
1492:         loc_oPg2.AddObject("lbl_4c_Label25", "Label")
1493:         WITH loc_oPg2.lbl_4c_Label25
1494:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o 1:"
1495:             .Top       = 460
1496:             .Left      = 258
1497:             .Width     = 73
1498:             .Height    = 15
1499:             .AutoSize  = .F.
1500:             .FontName  = "Tahoma"
1501:             .FontSize  = 8
1502:             .ForeColor = RGB(255, 255, 255)
1503:             .BackStyle = 0
1504:             .Visible   = .T.
1505:         ENDWITH
1506: 
1507:         loc_oPg2.AddObject("txt_4c_ObsPes", "TextBox")
1508:         WITH loc_oPg2.txt_4c_ObsPes
1509:             .Value         = ""
1510:             .Top           = 456
1511:             .Left          = 336
1512:             .Width         = 220
1513:             .Height        = 23
1514:             .FontName      = "Tahoma"
1515:             .FontSize      = 8
1516:             .ForeColor     = RGB(90, 90, 90)
1517:             .BackColor     = RGB(255, 255, 255)
1518:             .BorderStyle   = 1
1519:             .SpecialEffect = 0
1520:             .Visible       = .T.
1521:         ENDWITH
1522: 
1523:         *-- LINHA 16: Agrupa (OptionGroup, Top=453+29=482)
1524:         *-- Say16: "Agrupa :" (Top=481, Left=287, Width=44)
1525:         loc_oPg2.AddObject("lbl_4c_Label16", "Label")
1526:         WITH loc_oPg2.lbl_4c_Label16
1527:             .Caption   = "Agrupa :"
1528:             .Top       = 481
1529:             .Left      = 287
1530:             .Width     = 44
1531:             .Height    = 15
1532:             .AutoSize  = .F.
1533:             .FontName  = "Tahoma"
1534:             .FontSize  = 8
1535:             .ForeColor = RGB(255, 255, 255)
1536:             .BackStyle = 0
1537:             .Alignment = 1
1538:             .Visible   = .T.
1539:         ENDWITH
1540: 
1541:         *-- Opt_Agrupa: 2 botoes (Top=482, Left=330, Width=263, Height=16)
1542:         loc_oPg2.AddObject("obj_4c_Opt_Agrupa", "OptionGroup")
1543:         WITH loc_oPg2.obj_4c_Opt_Agrupa
1544:             .Value       = 1
1545:             .ButtonCount = 2
1546:             .Top         = 482
1547:             .Left        = 330
1548:             .Width       = 263
1549:             .Height      = 16
1550:             .BackStyle   = 0
1551:             .BorderStyle = 0
1552:             .Visible     = .T.
1553:             WITH .Buttons(1)
1554:                 .Caption   = "Sim"
1555:                 .BackStyle = 0
1556:                 .ForeColor = RGB(255, 255, 255)
1557:             ENDWITH
1558:             WITH .Buttons(2)
1559:                 .Caption   = "N" + CHR(227) + "o"
1560:                 .BackStyle = 0
1561:                 .ForeColor = RGB(255, 255, 255)
1562:             ENDWITH
1563:         ENDWITH
1564: 
1565:         *-- LINHA 17: Cod Barras (OptionGroup, Top=469+29=498)
1566:         *-- Say28: "Cod. Barras :" (Top=499, Left=265, Width=66)
1567:         loc_oPg2.AddObject("lbl_4c_Label28", "Label")
1568:         WITH loc_oPg2.lbl_4c_Label28
1569:             .Caption   = "C" + CHR(243) + "d. Barras :"
1570:             .Top       = 499
1571:             .Left      = 265
1572:             .Width     = 66
1573:             .Height    = 15
1574:             .AutoSize  = .F.
1575:             .FontName  = "Tahoma"
1576:             .FontSize  = 8
1577:             .ForeColor = RGB(255, 255, 255)
1578:             .BackStyle = 0
1579:             .Alignment = 1
1580:             .Visible   = .T.
1581:         ENDWITH
1582: 
1583:         *-- optFilBarra: 3 botoes (Top=498, Left=330, Width=209, Height=14)
1584:         loc_oPg2.AddObject("obj_4c_OptFilBarra", "OptionGroup")
1585:         WITH loc_oPg2.obj_4c_OptFilBarra
1586:             .Value       = 1
1587:             .ButtonCount = 3
1588:             .Top         = 498
1589:             .Left        = 330
1590:             .Width       = 209
1591:             .Height      = 14
1592:             .BackStyle   = 0
1593:             .BorderStyle = 0
1594:             .Visible     = .T.
1595:             WITH .Buttons(1)
1596:                 .Caption   = "Padr" + CHR(227) + "o"
1597:                 .BackStyle = 0
1598:                 .ForeColor = RGB(255, 255, 255)
1599:             ENDWITH
1600:             WITH .Buttons(2)
1601:                 .Caption   = "EAN13"
1602:                 .BackStyle = 0
1603:                 .ForeColor = RGB(255, 255, 255)
1604:             ENDWITH
1605:             WITH .Buttons(3)
1606:                 .Caption   = "2 de 5"
1607:                 .BackStyle = 0
1608:                 .ForeColor = RGB(255, 255, 255)
1609:             ENDWITH
1610:         ENDWITH
1611: 
1612:         *-- LINHA 18: Checkboxes (Tratas, SepEstq, LeitGructa)
1613:         *-- chk Tratas: "Tratamento por Peso" (Top=503+29=532)
1614:         loc_oPg2.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
1615:         WITH loc_oPg2.chk_4c_Fwcheckbox2
1616:             .Caption   = "Tratamento por Peso"
1617:             .Value     = 0
1618:             .Top       = 532
1619:             .Left      = 336
1620:             .Width     = 180
1621:             .Height    = 17
1622:             .FontName  = "Tahoma"
1623:             .FontSize  = 8
1624:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 1775 a 1835:
1775:             .Visible         = .T.
1776:         ENDWITH
1777: 
1778:         BINDEVENT(loc_oPg2.cmd_4c_Command3, "Click", THIS, "BtnSelecionarTodosGGrupoClick")
1779: 
1780:         loc_oPg2.AddObject("cmd_4c_Command4", "CommandButton")
1781:         WITH loc_oPg2.cmd_4c_Command4
1782:             .Caption         = ""
1783:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1784:             .PicturePosition = 13
1785:             .Top             = 257
1786:             .Left            = 924
1787:             .Width           = 45
1788:             .Height          = 45
1789:             .ToolTipText     = "Desmarcar Todos"
1790:             .Themes          = .T.
1791:             .SpecialEffect   = 0
1792:             .Visible         = .T.
1793:         ENDWITH
1794: 
1795:         BINDEVENT(loc_oPg2.cmd_4c_Command4, "Click", THIS, "BtnDesmarcarTodosGGrupoClick")
1796: 
1797:         *-- COLUNA DIREITA: Grade Grupo Produto (Top=330+29=359, Left=683)
1798:         *-- Label1: "Grupo Produto" (Top=342, Left=683, Width=84)
1799:         loc_oPg2.AddObject("lbl_4c_label110", "Label")
1800:         WITH loc_oPg2.lbl_4c_label110
1801:             .Caption   = "Grupo Produto"
1802:             .Top       = 342
1803:             .Left      = 683
1804:             .Width     = 84
1805:             .Height    = 15
1806:             .AutoSize  = .F.
1807:             .FontName  = "Tahoma"
1808:             .FontSize  = 8
1809:             .FontBold  = .T.
1810:             .ForeColor = RGB(255, 255, 255)
1811:             .BackStyle = 0
1812:             .Visible   = .T.
1813:         ENDWITH
1814: 
1815:         *-- grdgrupo (Top=359, Left=683, Width=238, Height=147)
1816:         loc_oPg2.AddObject("grd_4c_Grupos", "Grid")
1817:         loc_oPg2.grd_4c_Grupos.RecordSource = ""
1818:         loc_oPg2.grd_4c_Grupos.ColumnCount  = 3
1819: 
1820:         loc_oGrdGrupo = loc_oPg2.grd_4c_Grupos
1821:         WITH loc_oGrdGrupo
1822:             .Top                = 359
1823:             .Left               = 683
1824:             .Width              = 238
1825:             .Height             = 147
1826:             .FontName           = "Tahoma"
1827:             .FontSize           = 8
1828:             .ForeColor          = RGB(90, 90, 90)
1829:             .BackColor          = RGB(255, 255, 255)
1830:             .GridLineColor      = RGB(200, 200, 200)
1831:             .HighlightStyle     = 2
1832:             .DeleteMark         = .F.
1833:             .RecordMark         = .F.
1834:             .RowHeight          = 17
1835:             .ScrollBars         = 3

*-- Linhas 1861 a 2135:
1861:         ENDWITH
1862: 
1863:         loc_oGrdGrupo.Column1.CurrentControl = "chk_4c_check12"
1864: 
1865:         *-- Botoes Selecionar/Desmarcar Grupos (Top=378, Left=924, Width=45, Height=45)
1866:         loc_oPg2.AddObject("cmd_4c_Command1", "CommandButton")
1867:         WITH loc_oPg2.cmd_4c_Command1
1868:             .Caption         = ""
1869:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1870:             .PicturePosition = 13
1871:             .Top             = 378
1872:             .Left            = 924
1873:             .Width           = 45
1874:             .Height          = 45
1875:             .ToolTipText     = "Selecionar Todos"
1876:             .Themes          = .T.
1877:             .SpecialEffect   = 0
1878:             .Visible         = .T.
1879:         ENDWITH
1880: 
1881:         BINDEVENT(loc_oPg2.cmd_4c_Command1, "Click", THIS, "BtnSelecionarTodosGrupoClick")
1882: 
1883:         loc_oPg2.AddObject("cmd_4c_Command2", "CommandButton")
1884:         WITH loc_oPg2.cmd_4c_Command2
1885:             .Caption         = ""
1886:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1887:             .PicturePosition = 13
1888:             .Top             = 424
1889:             .Left            = 924
1890:             .Width           = 45
1891:             .Height          = 45
1892:             .ToolTipText     = "Desmarcar Todos"
1893:             .Themes          = .T.
1894:             .SpecialEffect   = 0
1895:             .Visible         = .T.
1896:         ENDWITH
1897: 
1898:         BINDEVENT(loc_oPg2.cmd_4c_Command2, "Click", THIS, "BtnDesmarcarTodosGrupoClick")
1899: 
1900:         THIS.TornarControlesVisiveis(loc_oPg2)
1901:     ENDPROC
1902: 
1903:     *--------------------------------------------------------------------------
1904:     * ConfigurarPaginaLeitura - Cria Page3: interface de leitura/escaneamento
1905:     *--------------------------------------------------------------------------
1906:     PROTECTED PROCEDURE ConfigurarPaginaLeitura()
1907:         LOCAL loc_oPg3, loc_oGrd
1908: 
1909:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
1910: 
1911:         *-- Container Encerrar (canonico: Top=29, Left=917)
1912:         loc_oPg3.AddObject("cnt_4c_Saida", "Container")
1913:         WITH loc_oPg3.cnt_4c_Saida
1914:             .Top         = 29
1915:             .Left        = 917
1916:             .Width       = 90
1917:             .Height      = 85
1918:             .BackStyle   = 0
1919:             .BorderWidth = 0
1920:             .Visible     = .T.
1921:         ENDWITH
1922: 
1923:         loc_oPg3.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
1924:         WITH loc_oPg3.cnt_4c_Saida.cmd_4c_Encerrar
1925:             .Caption         = "Encerrar"
1926:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
1927:             .PicturePosition = 13
1928:             .Top             = 5
1929:             .Left            = 5
1930:             .Width           = 75
1931:             .Height          = 75
1932:             .BackColor       = RGB(255, 255, 255)
1933:             .ForeColor       = RGB(90, 90, 90)
1934:             .FontName        = "Tahoma"
1935:             .FontSize        = 8
1936:             .FontBold        = .T.
1937:             .FontItalic      = .T.
1938:             .Themes          = .F.
1939:             .SpecialEffect   = 0
1940:             .MousePointer    = 15
1941:             .WordWrap        = .T.
1942:             .AutoSize        = .F.
1943:             .Visible         = .T.
1944:         ENDWITH
1945: 
1946:         BINDEVENT(loc_oPg3.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
1947: 
1948:         *-- Botoes de acao leitura (Top=12+29=41): Gravar, Cancelar, TotalLocal, Ocorrencia, Imagem, LocalGravado
1949:         *-- Gravar (Left=828)
1950:         loc_oPg3.AddObject("cmd_4c_Confirmar", "CommandButton")
1951:         WITH loc_oPg3.cmd_4c_Confirmar
1952:             .Caption         = "Gravar"
1953:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1954:             .PicturePosition = 13
1955:             .Top             = 41
1956:             .Left            = 828
1957:             .Width           = 75
1958:             .Height          = 40
1959:             .BackColor       = RGB(255, 255, 255)
1960:             .ForeColor       = RGB(90, 90, 90)
1961:             .FontName        = "Tahoma"
1962:             .FontSize        = 8
1963:             .FontBold        = .T.
1964:             .Themes          = .F.
1965:             .SpecialEffect   = 0
1966:             .MousePointer    = 15
1967:             .Visible         = .T.
1968:         ENDWITH
1969: 
1970:         BINDEVENT(loc_oPg3.cmd_4c_Confirmar, "Click", THIS, "BtnGravarClick")
1971: 
1972:         *-- Cancelar (Left=903)
1973:         loc_oPg3.AddObject("cmd_4c_Cancela", "CommandButton")
1974:         WITH loc_oPg3.cmd_4c_Cancela
1975:             .Caption         = "Cancelar"
1976:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1977:             .PicturePosition = 13
1978:             .Top             = 41
1979:             .Left            = 743
1980:             .Width           = 75
1981:             .Height          = 40
1982:             .BackColor       = RGB(255, 255, 255)
1983:             .ForeColor       = RGB(90, 90, 90)
1984:             .FontName        = "Tahoma"
1985:             .FontSize        = 8
1986:             .FontBold        = .T.
1987:             .Themes          = .F.
1988:             .SpecialEffect   = 0
1989:             .MousePointer    = 15
1990:             .Visible         = .T.
1991:         ENDWITH
1992: 
1993:         BINDEVENT(loc_oPg3.cmd_4c_Cancela, "Click", THIS, "BtnCancelaClick")
1994: 
1995:         *-- TotalLocal (Left=303)
1996:         loc_oPg3.AddObject("cmd_4c_TotalLocal", "CommandButton")
1997:         WITH loc_oPg3.cmd_4c_TotalLocal
1998:             .Caption       = "Total Local"
1999:             .Top           = 41
2000:             .Left          = 303
2001:             .Width         = 70
2002:             .Height        = 40
2003:             .FontName      = "Tahoma"
2004:             .FontSize      = 8
2005:             .Themes        = .F.
2006:             .SpecialEffect = 0
2007:             .Visible       = .T.
2008:         ENDWITH
2009: 
2010:         BINDEVENT(loc_oPg3.cmd_4c_TotalLocal, "Click", THIS, "BtnTotalLocalClick")
2011: 
2012:         *-- Ocorrencia (Left=378)
2013:         loc_oPg3.AddObject("cmd_4c_Ocorrencia", "CommandButton")
2014:         WITH loc_oPg3.cmd_4c_Ocorrencia
2015:             .Caption       = "Ocorr" + CHR(234) + "ncia"
2016:             .Top           = 41
2017:             .Left          = 378
2018:             .Width         = 70
2019:             .Height        = 40
2020:             .FontName      = "Tahoma"
2021:             .FontSize      = 8
2022:             .Themes        = .F.
2023:             .SpecialEffect = 0
2024:             .Visible       = .T.
2025:         ENDWITH
2026: 
2027:         BINDEVENT(loc_oPg3.cmd_4c_Ocorrencia, "Click", THIS, "BtnOcorrenciaClick")
2028: 
2029:         *-- Excluir item leitura (Left=453, visible=F inicialmente)
2030:         loc_oPg3.AddObject("cmd_4c_Excluir", "CommandButton")
2031:         WITH loc_oPg3.cmd_4c_Excluir
2032:             .Caption       = "Excluir"
2033:             .Top           = 41
2034:             .Left          = 453
2035:             .Width         = 70
2036:             .Height        = 40
2037:             .FontName      = "Tahoma"
2038:             .FontSize      = 8
2039:             .Themes        = .F.
2040:             .SpecialEffect = 0
2041:             .Visible       = .F.
2042:         ENDWITH
2043: 
2044:         BINDEVENT(loc_oPg3.cmd_4c_Excluir, "Click", THIS, "BtnExcluirLeituraClick")
2045: 
2046:         *-- Imagem (Left=528)
2047:         loc_oPg3.AddObject("cmd_4c_Imagem", "CommandButton")
2048:         WITH loc_oPg3.cmd_4c_Imagem
2049:             .Caption       = "Imagem"
2050:             .Top           = 41
2051:             .Left          = 528
2052:             .Width         = 70
2053:             .Height        = 40
2054:             .FontName      = "Tahoma"
2055:             .FontSize      = 8
2056:             .Themes        = .F.
2057:             .SpecialEffect = 0
2058:             .Visible       = .T.
2059:         ENDWITH
2060: 
2061:         BINDEVENT(loc_oPg3.cmd_4c_Imagem, "Click", THIS, "BtnImagemClick")
2062: 
2063:         *-- LocalGravado (Left=603)
2064:         loc_oPg3.AddObject("cmd_4c_LocalGravado", "CommandButton")
2065:         WITH loc_oPg3.cmd_4c_LocalGravado
2066:             .Caption       = "Local Gravado"
2067:             .Top           = 41
2068:             .Left          = 603
2069:             .Width         = 70
2070:             .Height        = 40
2071:             .FontName      = "Tahoma"
2072:             .FontSize      = 8
2073:             .Themes        = .F.
2074:             .SpecialEffect = 0
2075:             .Visible       = .T.
2076:         ENDWITH
2077: 
2078:         BINDEVENT(loc_oPg3.cmd_4c_LocalGravado, "Click", THIS, "BtnLocalGravadoClick")
2079: 
2080:         *-- BtnExcluir (Left=754, excluir registro selecionado na grade)
2081:         loc_oPg3.AddObject("cmd_4c_BtnExcluir", "CommandButton")
2082:         WITH loc_oPg3.cmd_4c_BtnExcluir
2083:             .Caption       = "Excluir"
2084:             .Top           = 41
2085:             .Left          = 678
2086:             .Width         = 60
2087:             .Height        = 40
2088:             .FontName      = "Tahoma"
2089:             .FontSize      = 8
2090:             .Themes        = .F.
2091:             .SpecialEffect = 0
2092:             .Visible       = .T.
2093:         ENDWITH
2094: 
2095:         BINDEVENT(loc_oPg3.cmd_4c_BtnExcluir, "Click", THIS, "BtnExcluirLeituraClick")
2096: 
2097:         *-- PAINEL ESQUERDO: caixas de contexto (Codigo, Grupo, Estoque)
2098:         *-- Shape4 (fundo caixa Codigo): Top=137, Left=1, Width=92, Height=47
2099:         loc_oPg3.AddObject("shp_4c_Shape4", "Shape")
2100:         WITH loc_oPg3.shp_4c_Shape4
2101:             .Top         = 137
2102:             .Left        = 1
2103:             .Width       = 92
2104:             .Height      = 47
2105:             .BorderColor = RGB(0, 0, 0)
2106:             .BorderStyle = 1
2107:             .FillColor   = RGB(230, 230, 230)
2108:             .Visible     = .T.
2109:         ENDWITH
2110: 
2111:         *-- Say9: " Codigo " (Top=141, Left=20, Width=46)
2112:         loc_oPg3.AddObject("lbl_4c_Label9", "Label")
2113:         WITH loc_oPg3.lbl_4c_Label9
2114:             .Caption   = " C" + CHR(243) + "digo "
2115:             .Top       = 141
2116:             .Left      = 20
2117:             .Width     = 46
2118:             .AutoSize  = .F.
2119:             .FontName  = "Tahoma"
2120:             .FontSize  = 8
2121:             .ForeColor = RGB(0, 0, 0)
2122:             .BackStyle = 0
2123:             .Alignment = 2
2124:             .Visible   = .T.
2125:         ENDWITH
2126: 
2127:         *-- Get_Codigo leitura (Top=158, Left=6, Width=82, Height=20)
2128:         loc_oPg3.AddObject("txt_4c_Codigo", "TextBox")
2129:         WITH loc_oPg3.txt_4c_Codigo
2130:             .Value         = 0
2131:             .Top           = 158
2132:             .Left          = 6
2133:             .Width         = 82
2134:             .Height        = 20
2135:             .FontName      = "Tahoma"

*-- Linhas 2246 a 2290:
2246:             .Visible     = .T.
2247:         ENDWITH
2248: 
2249:         *-- TipoLeitura OptionGroup (Top=280, Left=-1, Width=80, ButtonCount=2)
2250:         loc_oPg3.AddObject("obj_4c_TipoLeitura", "OptionGroup")
2251:         WITH loc_oPg3.obj_4c_TipoLeitura
2252:             .Value       = 1
2253:             .ButtonCount = 2
2254:             .Top         = 280
2255:             .Left        = 0
2256:             .Width       = 80
2257:             .Height      = 42
2258:             .BackStyle   = 0
2259:             .BorderStyle = 0
2260:             .Visible     = .T.
2261:             WITH .Buttons(1)
2262:                 .Caption   = "Qtd"
2263:                 .BackStyle = 0
2264:                 .ForeColor = RGB(0, 0, 0)
2265:             ENDWITH
2266:             WITH .Buttons(2)
2267:                 .Caption   = "Cod.Barra"
2268:                 .BackStyle = 0
2269:                 .ForeColor = RGB(0, 0, 0)
2270:             ENDWITH
2271:         ENDWITH
2272: 
2273:         *-- GradeLeitura (Top=136, Left=98, Width=641, Height=293)
2274:         loc_oPg3.AddObject("grd_4c_Dados", "Grid")
2275:         loc_oPg3.grd_4c_Dados.RecordSource = ""
2276:         loc_oPg3.grd_4c_Dados.ColumnCount  = 8
2277: 
2278:         loc_oGrd = loc_oPg3.grd_4c_Dados
2279:         WITH loc_oGrd
2280:             .Top                = 136
2281:             .Left               = 98
2282:             .Width              = 641
2283:             .Height             = 293
2284:             .FontName           = "Tahoma"
2285:             .FontSize           = 8
2286:             .ForeColor          = RGB(90, 90, 90)
2287:             .BackColor          = RGB(255, 255, 255)
2288:             .GridLineColor      = RGB(200, 200, 200)
2289:             .HighlightStyle     = 2
2290:             .DeleteMark         = .F.

*-- Linhas 2436 a 2457:
2436:             .ForeColor = RGB(255, 255, 255)
2437:             .BackStyle = 0
2438:             .Visible   = .T.
2439:         ENDWITH
2440: 
2441:         loc_oPg3.AddObject("txt_4c_Estoque", "TextBox")
2442:         WITH loc_oPg3.txt_4c_Estoque
2443:             .Value     = ""
2444:             .Top       = 457
2445:             .Left      = 112
2446:             .Width     = 95
2447:             .Height    = 23
2448:             .FontName  = "Tahoma"
2449:             .FontSize  = 8
2450:             .BackColor = RGB(240, 240, 240)
2451:             .ReadOnly  = .T.
2452:             .Visible   = .T.
2453:         ENDWITH
2454: 
2455:         *-- Say1: "Local :" (Top=461, Left=253, Width=33)
2456:         loc_oPg3.AddObject("lbl_4c_Label1", "Label")
2457:         WITH loc_oPg3.lbl_4c_Label1

*-- Linhas 2935 a 3077:
2935:             .Visible       = .T.
2936:         ENDWITH
2937: 
2938:         THIS.TornarControlesVisiveis(loc_oPg3)
2939:     ENDPROC
2940: 
2941:     *--------------------------------------------------------------------------
2942:     * CarregarLista - Carrega inventarios da empresa no grid da Page1
2943:     *--------------------------------------------------------------------------
2944:     PROCEDURE CarregarLista()
2945:         LOCAL loc_lResultado, loc_oGrid
2946:         loc_lResultado = .F.
2947: 
2948:         TRY
2949:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2950:                 loc_lResultado = .T.
2951:             ENDIF
2952: 
2953:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2954: 
2955:             IF !THIS.this_oBusinessObject.Buscar("")
2956:                 loc_lResultado = .F.
2957:             ELSE
2958:                 loc_oGrid.ColumnCount = 8
2959:                 loc_oGrid.RecordSource              = "cursor_4c_Dados"
2960:                 loc_oGrid.Column1.ControlSource     = "cursor_4c_Dados.codigos"
2961:                 loc_oGrid.Column2.ControlSource     = "cursor_4c_Dados.dtbases"
2962:                 loc_oGrid.Column3.ControlSource     = "cursor_4c_Dados.datainis"
2963:                 loc_oGrid.Column4.ControlSource     = "cursor_4c_Dados.datafims"
2964:                 loc_oGrid.Column5.ControlSource     = "cursor_4c_Dados.encerras"
2965:                 loc_oGrid.Column6.ControlSource     = "cursor_4c_Dados.grupos"
2966:                 loc_oGrid.Column7.ControlSource     = "cursor_4c_Dados.contas"
2967:                 loc_oGrid.Column8.ControlSource     = "cursor_4c_Dados.usuars"
2968:                 loc_oGrid.Refresh()
2969:                 loc_lResultado = .T.
2970:             ENDIF
2971:         CATCH TO loc_oErro
2972:             MsgErro(loc_oErro.Message, "FormBAL.CarregarLista")
2973:         ENDTRY
2974: 
2975:         RETURN loc_lResultado
2976:     ENDPROC
2977: 
2978:     *--------------------------------------------------------------------------
2979:     * AlternarPagina - Alterna entre as paginas (1=Lista, 2=Dados, 3=Leitura)
2980:     *--------------------------------------------------------------------------
2981:     PROCEDURE AlternarPagina(par_nPagina)
2982:         TRY
2983:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2984:         CATCH TO loc_oErro
2985:             MsgErro(loc_oErro.Message, "FormBAL.AlternarPagina")
2986:         ENDTRY
2987:     ENDPROC
2988: 
2989:     *--------------------------------------------------------------------------
2990:     * FormParaBO - Transfere campos da Page2 (Dados) para o BO
2991:     *--------------------------------------------------------------------------
2992:     PROCEDURE FormParaBO()
2993:         LOCAL loc_oPg2, loc_oBO
2994:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2995:         loc_oBO  = THIS.this_oBusinessObject
2996: 
2997:         TRY
2998:             WITH loc_oBO
2999:                 .this_dDtbases    = loc_oPg2.txt_4c_DBase.Value
3000:                 .this_cGrupos     = ALLTRIM(loc_oPg2.txt_4c_Grupo.Value)
3001:                 .this_cContas     = ALLTRIM(loc_oPg2.txt_4c_Conta.Value)
3002:                 .this_dDatafims   = loc_oPg2.txt_4c_DataFinal.Value
3003:                 .this_dDatainis   = loc_oPg2.txt_4c_DataInicial.Value
3004:                 .this_cCprosi     = ALLTRIM(loc_oPg2.txt_4c_CProsI.Value)
3005:                 .this_cCprosf     = ALLTRIM(loc_oPg2.txt_4c_CProsF.Value)
3006:                 .this_cLocalis    = ALLTRIM(loc_oPg2.txt_4c_LocalInicial.Value)
3007:                 .this_cLocalfs    = ALLTRIM(loc_oPg2.txt_4c_LocalFinal.Value)
3008:                 .this_cIforis     = ALLTRIM(loc_oPg2.txt_4c_FornecInicial.Value)
3009:                 .this_cIforfs     = ALLTRIM(loc_oPg2.txt_4c_FornecFinal.Value)
3010:                 .this_cCggruis    = ALLTRIM(loc_oPg2.txt_4c_GGrupoInicial.Value)
3011:                 .this_cCggrufs    = ALLTRIM(loc_oPg2.txt_4c_GGrupoFinal.Value)
3012:                 .this_cCgruis     = ALLTRIM(loc_oPg2.txt_4c_GrupoInicial.Value)
3013:                 .this_cCgrufs     = ALLTRIM(loc_oPg2.txt_4c_GrupoFinal.Value)
3014:                 .this_cSgrusi     = ALLTRIM(loc_oPg2.txt_4c_SGrusI.Value)
3015:                 .this_cSgrusf     = ALLTRIM(loc_oPg2.txt_4c_SGrusF.Value)
3016:                 .this_nPrecois    = loc_oPg2.txt_4c_PrecoInicial.Value
3017:                 .this_nPrecofs    = loc_oPg2.txt_4c_PrecoFinal.Value
3018:                 .this_cColecoesi  = ALLTRIM(loc_oPg2.txt_4c_ColecoesI.Value)
3019:                 .this_cColecoesf  = ALLTRIM(loc_oPg2.txt_4c_ColecoesF.Value)
3020:                 .this_cCfinpsi    = ALLTRIM(loc_oPg2.txt_4c__UniIni.Value)
3021:                 .this_cCfinpsf    = ALLTRIM(loc_oPg2.txt_4c__UniFim.Value)
3022:                 .this_cObs        = ALLTRIM(loc_oPg2.obj_4c_GetObs.Value)
3023:                 .this_lTratas     = (loc_oPg2.chk_4c_Fwcheckbox2.Value = 1)
3024:                 .this_nSepestqs   = IIF(loc_oPg2.chk_4c_Fwcheckbox1.Value = 1, 1, 0)
3025:                 .this_nLeitgructa = IIF(loc_oPg2.chk_4c_Fwcheckbox3.Value = 1, 1, 0)
3026:                 .this_nAgrupas    = loc_oPg2.obj_4c_Opt_Agrupa.Value
3027:                 .this_nFilbarras  = loc_oPg2.obj_4c_OptFilBarra.Value - 1
3028:             ENDWITH
3029:         CATCH TO loc_oErro
3030:             MsgErro(loc_oErro.Message, "FormBAL.FormParaBO")
3031:         ENDTRY
3032:     ENDPROC
3033: 
3034:     *--------------------------------------------------------------------------
3035:     * BOParaForm - Transfere dados do BO para os campos da Page2 (Dados)
3036:     *--------------------------------------------------------------------------
3037:     PROCEDURE BOParaForm()
3038:         LOCAL loc_oPg2, loc_oBO
3039:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3040:         loc_oBO  = THIS.this_oBusinessObject
3041: 
3042:         TRY
3043:             WITH loc_oBO
3044:                 loc_oPg2.txt_4c_Codigo.Value          = .this_nCodigos
3045:                 loc_oPg2.txt_4c_DBase.Value           = .this_dDtbases
3046:                 loc_oPg2.txt_4c_Grupo.Value           = ALLTRIM(.this_cGrupos)
3047:                 loc_oPg2.txt_4c_Conta.Value           = ALLTRIM(.this_cContas)
3048:                 loc_oPg2.txt_4c_DataFinal.Value       = .this_dDatafims
3049:                 loc_oPg2.txt_4c_DataInicial.Value     = .this_dDatainis
3050:                 loc_oPg2.txt_4c_CProsI.Value          = ALLTRIM(.this_cCprosi)
3051:                 loc_oPg2.txt_4c_CProsF.Value          = ALLTRIM(.this_cCprosf)
3052:                 loc_oPg2.txt_4c_LocalInicial.Value    = ALLTRIM(.this_cLocalis)
3053:                 loc_oPg2.txt_4c_LocalFinal.Value      = ALLTRIM(.this_cLocalfs)
3054:                 loc_oPg2.txt_4c_FornecInicial.Value   = ALLTRIM(.this_cIforis)
3055:                 loc_oPg2.txt_4c_FornecFinal.Value     = ALLTRIM(.this_cIforfs)
3056:                 loc_oPg2.txt_4c_GGrupoInicial.Value   = ALLTRIM(.this_cCggruis)
3057:                 loc_oPg2.txt_4c_GGrupoFinal.Value     = ALLTRIM(.this_cCggrufs)
3058:                 loc_oPg2.txt_4c_GrupoInicial.Value    = ALLTRIM(.this_cCgruis)
3059:                 loc_oPg2.txt_4c_GrupoFinal.Value      = ALLTRIM(.this_cCgrufs)
3060:                 loc_oPg2.txt_4c_SGrusI.Value          = ALLTRIM(.this_cSgrusi)
3061:                 loc_oPg2.txt_4c_SGrusF.Value          = ALLTRIM(.this_cSgrusf)
3062:                 loc_oPg2.txt_4c_PrecoInicial.Value    = .this_nPrecois
3063:                 loc_oPg2.txt_4c_PrecoFinal.Value      = .this_nPrecofs
3064:                 loc_oPg2.txt_4c_Lin.Value             = ""
3065:                 loc_oPg2.txt_4c_Lin2.Value            = ""
3066:                 loc_oPg2.txt_4c__UniIni.Value         = ALLTRIM(.this_cCfinpsi)
3067:                 loc_oPg2.txt_4c__UniFim.Value         = ALLTRIM(.this_cCfinpsf)
3068:                 loc_oPg2.txt_4c_ColecoesI.Value       = ALLTRIM(.this_cColecoesi)
3069:                 loc_oPg2.txt_4c_ColecoesF.Value       = ALLTRIM(.this_cColecoesf)
3070:                 loc_oPg2.obj_4c_GetObs.Value          = ALLTRIM(.this_cObs)
3071:                 loc_oPg2.chk_4c_Fwcheckbox2.Value    = .this_lTratas
3072:                 loc_oPg2.chk_4c_Fwcheckbox1.Value    = IIF(.this_nSepestqs = 1, 1, 0)
3073:                 loc_oPg2.chk_4c_Fwcheckbox3.Value    = IIF(.this_nLeitgructa = 1, 1, 0)
3074:                 loc_oPg2.obj_4c_Opt_Agrupa.Value      = IIF(.this_nAgrupas > 0, .this_nAgrupas, 1)
3075:                 loc_oPg2.obj_4c_OptFilBarra.Value     = IIF(.this_nFilbarras >= 0, .this_nFilbarras + 1, 1)
3076:             ENDWITH
3077: 

*-- Linhas 3086 a 3499:
3086:     *--------------------------------------------------------------------------
3087:     * CarregarDescricaoGrupo - Preenche txt_4c_DGrupo com descricao do grupo
3088:     *--------------------------------------------------------------------------
3089:     PROTECTED PROCEDURE CarregarDescricaoGrupo()
3090:         LOCAL loc_cGrupo, loc_cSQL, loc_nRes, loc_cDesc
3091:         loc_cGrupo = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
3092:         loc_cDesc  = ""
3093: 
3094:         TRY
3095:             IF !EMPTY(loc_cGrupo)
3096:                 loc_cSQL = "SELECT TOP 1 descrs FROM SigCdGcr WHERE Codigos = " + EscaparSQL(loc_cGrupo)
3097:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescGrp")
3098:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescGrp") > 0
3099:                     SELECT cursor_4c_DescGrp
3100:                     loc_cDesc = ALLTRIM(cursor_4c_DescGrp.descrs)
3101:                 ENDIF
3102:                 IF USED("cursor_4c_DescGrp")
3103:                     USE IN cursor_4c_DescGrp
3104:                 ENDIF
3105:             ENDIF
3106:         CATCH TO loc_oErro
3107:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoGrupo")
3108:         ENDTRY
3109: 
3110:         THIS.pgf_4c_Paginas.Page2.txt_4c_DGrupo.Value = loc_cDesc
3111:     ENDPROC
3112: 
3113:     *--------------------------------------------------------------------------
3114:     * CarregarDescricaoConta - Preenche txt_4c_DConta com descricao da conta
3115:     *--------------------------------------------------------------------------
3116:     PROTECTED PROCEDURE CarregarDescricaoConta()
3117:         LOCAL loc_cConta, loc_cSQL, loc_nRes, loc_cDesc
3118:         loc_cConta = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
3119:         loc_cDesc  = ""
3120: 
3121:         TRY
3122:             IF !EMPTY(loc_cConta)
3123:                 loc_cSQL = "SELECT TOP 1 DNoms FROM SigCdCli WHERE IClis = " + EscaparSQL(loc_cConta)
3124:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DescCta")
3125:                 IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_DescCta") > 0
3126:                     SELECT cursor_4c_DescCta
3127:                     loc_cDesc = ALLTRIM(cursor_4c_DescCta.DNoms)
3128:                 ENDIF
3129:                 IF USED("cursor_4c_DescCta")
3130:                     USE IN cursor_4c_DescCta
3131:                 ENDIF
3132:             ENDIF
3133:         CATCH TO loc_oErro
3134:             MsgErro(loc_oErro.Message, "FormBAL.CarregarDescricaoConta")
3135:         ENDTRY
3136: 
3137:         THIS.pgf_4c_Paginas.Page2.txt_4c_DConta.Value = loc_cDesc
3138:     ENDPROC
3139: 
3140:     *--------------------------------------------------------------------------
3141:     * CarregarGrades - Carrega grdGGrupo (Grandes Grupos) e grd_4c_Grupos
3142:     *--------------------------------------------------------------------------
3143:     PROCEDURE CarregarGrades()
3144:         LOCAL loc_cSQL, loc_nRes, loc_cMfilggrp, loc_cMfilgrupo
3145:         loc_cMfilggrp  = ALLTRIM(THIS.this_oBusinessObject.this_cMfilggrp)
3146:         loc_cMfilgrupo = ALLTRIM(THIS.this_oBusinessObject.this_cMfilgrupo)
3147: 
3148:         TRY
3149:             *-- Carregar Grandes Grupos (SigCdGpr)
3150:             IF USED("cursor_4c_GGrupos")
3151:                 USE IN cursor_4c_GGrupos
3152:             ENDIF
3153: 
3154:             loc_cSQL = "SELECT 0 AS nMarcas, codigos AS GGrupos, descs AS Descricaos" + ;
3155:                        " FROM SigCdGpr ORDER BY codigos"
3156:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GGrupos")
3157: 
3158:             IF loc_nRes >= 0
3159:                 *-- Restaurar marcacoes salvas (formato: "cod1,cod2,cod3")
3160:                 IF !EMPTY(loc_cMfilggrp)
3161:                     SELECT cursor_4c_GGrupos
3162:                     SCAN
3163:                         IF "," + ALLTRIM(cursor_4c_GGrupos.GGrupos) + "," $ "," + loc_cMfilggrp + ","
3164:                             REPLACE nMarcas WITH 1 IN cursor_4c_GGrupos
3165:                         ENDIF
3166:                         SELECT cursor_4c_GGrupos
3167:                     ENDSCAN
3168:                 ENDIF
3169: 
3170:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.ColumnCount = 3
3171:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.RecordSource              = "cursor_4c_GGrupos"
3172:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.ControlSource     = "cursor_4c_GGrupos.nMarcas"
3173:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.ControlSource     = "cursor_4c_GGrupos.GGrupos"
3174:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.ControlSource     = "cursor_4c_GGrupos.Descricaos"
3175:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column1.Header1.Caption   = ""
3176:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column2.Header1.Caption   = "Cod."
3177:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
3178:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3179:             ENDIF
3180: 
3181:             *-- Carregar Grupos Produto (SigCdGrp)
3182:             IF USED("cursor_4c_GruposProd")
3183:                 USE IN cursor_4c_GruposProd
3184:             ENDIF
3185: 
3186:             loc_cSQL = "SELECT 0 AS nMarcas, cgrus AS Codigos, descs AS Descricaos" + ;
3187:                        " FROM SigCdGrp ORDER BY cgrus"
3188:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GruposProd")
3189: 
3190:             IF loc_nRes >= 0
3191:                 *-- Restaurar marcacoes salvas
3192:                 IF !EMPTY(loc_cMfilgrupo)
3193:                     SELECT cursor_4c_GruposProd
3194:                     SCAN
3195:                         IF "," + ALLTRIM(cursor_4c_GruposProd.Codigos) + "," $ "," + loc_cMfilgrupo + ","
3196:                             REPLACE nMarcas WITH 1 IN cursor_4c_GruposProd
3197:                         ENDIF
3198:                         SELECT cursor_4c_GruposProd
3199:                     ENDSCAN
3200:                 ENDIF
3201: 
3202:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.ColumnCount = 3
3203:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.RecordSource              = "cursor_4c_GruposProd"
3204:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.ControlSource     = "cursor_4c_GruposProd.nMarcas"
3205:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.ControlSource     = "cursor_4c_GruposProd.Codigos"
3206:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.ControlSource     = "cursor_4c_GruposProd.Descricaos"
3207:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column1.Header1.Caption   = ""
3208:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column2.Header1.Caption   = "Cod."
3209:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
3210:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3211:             ENDIF
3212:         CATCH TO loc_oErro
3213:             MsgErro(loc_oErro.Message, "FormBAL.CarregarGrades")
3214:         ENDTRY
3215:     ENDPROC
3216: 
3217:     *--------------------------------------------------------------------------
3218:     * ObterMfilGGrupo - Gera string CSV de grandes grupos marcados
3219:     *--------------------------------------------------------------------------
3220:     PROTECTED PROCEDURE ObterMfilGGrupo()
3221:         LOCAL loc_cLista
3222:         loc_cLista = ""
3223: 
3224:         TRY
3225:             IF USED("cursor_4c_GGrupos")
3226:                 SELECT cursor_4c_GGrupos
3227:                 SCAN
3228:                     IF cursor_4c_GGrupos.nMarcas = 1
3229:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GGrupos.GGrupos)
3230:                     ENDIF
3231:                     SELECT cursor_4c_GGrupos
3232:                 ENDSCAN
3233:             ENDIF
3234:         CATCH TO loc_oErro
3235:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGGrupo")
3236:         ENDTRY
3237: 
3238:         RETURN loc_cLista
3239:     ENDPROC
3240: 
3241:     *--------------------------------------------------------------------------
3242:     * ObterMfilGrupo - Gera string CSV de grupos produto marcados
3243:     *--------------------------------------------------------------------------
3244:     PROTECTED PROCEDURE ObterMfilGrupo()
3245:         LOCAL loc_cLista
3246:         loc_cLista = ""
3247: 
3248:         TRY
3249:             IF USED("cursor_4c_GruposProd")
3250:                 SELECT cursor_4c_GruposProd
3251:                 SCAN
3252:                     IF cursor_4c_GruposProd.nMarcas = 1
3253:                         loc_cLista = loc_cLista + IIF(EMPTY(loc_cLista), "", ",") + ALLTRIM(cursor_4c_GruposProd.Codigos)
3254:                     ENDIF
3255:                     SELECT cursor_4c_GruposProd
3256:                 ENDSCAN
3257:             ENDIF
3258:         CATCH TO loc_oErro
3259:             MsgErro(loc_oErro.Message, "FormBAL.ObterMfilGrupo")
3260:         ENDTRY
3261: 
3262:         RETURN loc_cLista
3263:     ENDPROC
3264: 
3265:     *--------------------------------------------------------------------------
3266:     * CarregarGradeLeitura - Carrega historico de leituras do inventario
3267:     *--------------------------------------------------------------------------
3268:     PROCEDURE CarregarGradeLeitura()
3269:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps, loc_oGrd
3270:         loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3271:         loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3272:         loc_oGrd     = THIS.pgf_4c_Paginas.Page3.grd_4c_Dados
3273: 
3274:         TRY
3275:             IF USED("cursor_4c_Historico")
3276:                 USE IN cursor_4c_Historico
3277:             ENDIF
3278: 
3279:             loc_cSQL = "SELECT a.cbars, a.cpros, a.lidos AS Qtds, a.localis, a.codcors," + ;
3280:                        " a.codtams, a.lidos2 AS Qtds2, ISNULL(b.cbars_old, 0) AS BarsOld" + ;
3281:                        " FROM SigIvTrH a" + ;
3282:                        " LEFT JOIN SigOpEta b ON a.cbars = b.cbars_new" + ;
3283:                        " WHERE a.emps = " + EscaparSQL(loc_cEmps) + ;
3284:                        " AND a.codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3285:                        " ORDER BY a.cidchaves"
3286: 
3287:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Historico")
3288: 
3289:             IF loc_nRes >= 0
3290:                 loc_oGrd.ColumnCount = 8
3291:                 loc_oGrd.RecordSource          = "cursor_4c_Historico"
3292:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Historico.cbars"
3293:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Historico.cpros"
3294:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Historico.Qtds"
3295:                 loc_oGrd.Column4.ControlSource = "cursor_4c_Historico.localis"
3296:                 loc_oGrd.Column5.ControlSource = "cursor_4c_Historico.codcors"
3297:                 loc_oGrd.Column6.ControlSource = "cursor_4c_Historico.codtams"
3298:                 loc_oGrd.Column7.ControlSource = "cursor_4c_Historico.Qtds2"
3299:                 loc_oGrd.Column8.ControlSource = "cursor_4c_Historico.BarsOld"
3300:                 loc_oGrd.Column1.Header1.Caption = "C" + CHR(243) + "d. Barra"
3301:                 loc_oGrd.Column2.Header1.Caption = "Produto"
3302:                 loc_oGrd.Column3.Header1.Caption = "Qtd(1)"
3303:                 loc_oGrd.Column4.Header1.Caption = "Local"
3304:                 loc_oGrd.Column5.Header1.Caption = "Cor"
3305:                 loc_oGrd.Column6.Header1.Caption = "Tam"
3306:                 loc_oGrd.Column7.Header1.Caption = "Qtd(2)"
3307:                 loc_oGrd.Column8.Header1.Caption = "Barra"
3308:                 loc_oGrd.Refresh()
3309: 
3310:                 THIS.AtualizarTotalLeitura()
3311:             ELSE
3312:                 MsgErro("Erro ao carregar leituras:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3313:             ENDIF
3314:         CATCH TO loc_oErro
3315:             MsgErro(loc_oErro.Message, "FormBAL.CarregarGradeLeitura")
3316:         ENDTRY
3317:     ENDPROC
3318: 
3319:     *--------------------------------------------------------------------------
3320:     * AtualizarTotalLeitura - Atualiza contadores de lidos e quantidade
3321:     *--------------------------------------------------------------------------
3322:     PROCEDURE AtualizarTotalLeitura()
3323:         LOCAL loc_nLidos, loc_nQtde, loc_cSQL, loc_nRes
3324: 
3325:         TRY
3326:             IF USED("cursor_4c_Historico")
3327:                 SELECT COUNT(*) AS Lidos, SUM(Qtds) AS Qtde FROM cursor_4c_Historico ;
3328:                     INTO CURSOR cursor_4c_Totais READWRITE
3329: 
3330:                 IF USED("cursor_4c_Totais")
3331:                     SELECT cursor_4c_Totais
3332:                     loc_nLidos = IIF(ISNULL(cursor_4c_Totais.Lidos), 0, cursor_4c_Totais.Lidos)
3333:                     loc_nQtde  = IIF(ISNULL(cursor_4c_Totais.Qtde),  0, cursor_4c_Totais.Qtde)
3334:                     USE IN cursor_4c_Totais
3335:                 ENDIF
3336: 
3337:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Lidos.Value = loc_nLidos
3338:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Qtde.Value  = loc_nQtde
3339:             ENDIF
3340:         CATCH TO loc_oErro
3341:             MsgErro(loc_oErro.Message, "FormBAL.AtualizarTotalLeitura")
3342:         ENDTRY
3343:     ENDPROC
3344: 
3345:     *--------------------------------------------------------------------------
3346:     * InicializarLeitura - Configura Page3 para o inventario selecionado
3347:     *--------------------------------------------------------------------------
3348:     PROTECTED PROCEDURE InicializarLeitura()
3349:         LOCAL loc_oPg3, loc_oBO
3350:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3351:         loc_oBO  = THIS.this_oBusinessObject
3352: 
3353:         TRY
3354:             loc_oPg3.txt_4c_Codigo.Value = loc_oBO.this_nCodigos
3355:             loc_oPg3.txt_4c_Grupo.Value  = ALLTRIM(loc_oBO.this_cGrupos)
3356:             loc_oPg3.txt_4c_Conta.Value  = ALLTRIM(loc_oBO.this_cContas)
3357: 
3358:             THIS.LimparCamposLeitura()
3359:             THIS.CarregarGradeLeitura()
3360:         CATCH TO loc_oErro
3361:             MsgErro(loc_oErro.Message, "FormBAL.InicializarLeitura")
3362:         ENDTRY
3363:     ENDPROC
3364: 
3365:     *--------------------------------------------------------------------------
3366:     * LimparCamposLeitura - Limpa campos de entrada da leitura
3367:     *--------------------------------------------------------------------------
3368:     PROTECTED PROCEDURE LimparCamposLeitura()
3369:         LOCAL loc_oPg3
3370:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3371: 
3372:         TRY
3373:             loc_oPg3.txt_4c_Prod.Value   = ""
3374:             loc_oPg3.txt_4c_Descr.Value  = ""
3375:             loc_oPg3.txt_4c_Cor.Value    = ""
3376:             loc_oPg3.txt_4c_Tam.Value    = ""
3377:             loc_oPg3.txt_4c_Qtd.Value    = 0
3378:             loc_oPg3.txt_4c_Qtd2.Value   = 0
3379:             loc_oPg3.txt_4c_Local.Value  = ""
3380:             loc_oPg3.txt_4c_Total.Value  = 0
3381:             loc_oPg3.txt_4c_Ocorr.Value  = ""
3382:             loc_oPg3.txt_4c_PReal.Value  = 0
3383:             loc_oPg3.txt_4c_Linha.Value  = ""
3384:             loc_oPg3.txt_4c_Reffs.Value  = ""
3385:             loc_oPg3.txt_4c_CodCor.Value = ""
3386:             loc_oPg3.txt_4c_Ultima.Value = ""
3387:             IF !loc_oPg3.chk_4c_Chk_RepeteObs.Value
3388:                 loc_oPg3.obj_4c_Get_Obs.Value = ""
3389:             ENDIF
3390:         CATCH TO loc_oErro
3391:             MsgErro(loc_oErro.Message, "FormBAL.LimparCamposLeitura")
3392:         ENDTRY
3393:     ENDPROC
3394: 
3395:     *--------------------------------------------------------------------------
3396:     * ObterCidchavesSelecionado - Retorna cidchaves do registro selecionado no grid
3397:     *--------------------------------------------------------------------------
3398:     PROTECTED PROCEDURE ObterCidchavesSelecionado()
3399:         LOCAL loc_cCidchaves
3400:         loc_cCidchaves = ""
3401: 
3402:         TRY
3403:             IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
3404:                 SELECT cursor_4c_Dados
3405:                 loc_cCidchaves = ALLTRIM(cursor_4c_Dados.cidchaves)
3406:             ENDIF
3407:         CATCH TO loc_oErro
3408:             MsgErro(loc_oErro.Message, "FormBAL.ObterCidchavesSelecionado")
3409:         ENDTRY
3410: 
3411:         RETURN loc_cCidchaves
3412:     ENDPROC
3413: 
3414:     *--------------------------------------------------------------------------
3415:     * HabilitarCamposDados - Habilita/desabilita campos da Page2
3416:     *--------------------------------------------------------------------------
3417:     PROTECTED PROCEDURE HabilitarCamposDados(par_lHabilitar)
3418:         LOCAL loc_oPg2
3419:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3420: 
3421:         TRY
3422:             loc_oPg2.txt_4c_DBase.ReadOnly         = !par_lHabilitar
3423:             loc_oPg2.txt_4c_Grupo.ReadOnly          = !par_lHabilitar
3424:             loc_oPg2.txt_4c_Conta.ReadOnly          = !par_lHabilitar
3425:             loc_oPg2.txt_4c_DataFinal.ReadOnly      = !par_lHabilitar
3426:             loc_oPg2.txt_4c_DataInicial.ReadOnly    = !par_lHabilitar
3427:             loc_oPg2.txt_4c_CProsI.ReadOnly         = !par_lHabilitar
3428:             loc_oPg2.txt_4c_CProsF.ReadOnly         = !par_lHabilitar
3429:             loc_oPg2.txt_4c_LocalInicial.ReadOnly   = !par_lHabilitar
3430:             loc_oPg2.txt_4c_LocalFinal.ReadOnly     = !par_lHabilitar
3431:             loc_oPg2.txt_4c_FornecInicial.ReadOnly  = !par_lHabilitar
3432:             loc_oPg2.txt_4c_FornecFinal.ReadOnly    = !par_lHabilitar
3433:             loc_oPg2.txt_4c_GGrupoInicial.ReadOnly  = !par_lHabilitar
3434:             loc_oPg2.txt_4c_GGrupoFinal.ReadOnly    = !par_lHabilitar
3435:             loc_oPg2.txt_4c_GrupoInicial.ReadOnly   = !par_lHabilitar
3436:             loc_oPg2.txt_4c_GrupoFinal.ReadOnly     = !par_lHabilitar
3437:             loc_oPg2.txt_4c_SGrusI.ReadOnly         = !par_lHabilitar
3438:             loc_oPg2.txt_4c_SGrusF.ReadOnly         = !par_lHabilitar
3439:             loc_oPg2.txt_4c_PrecoInicial.ReadOnly   = !par_lHabilitar
3440:             loc_oPg2.txt_4c_PrecoFinal.ReadOnly     = !par_lHabilitar
3441:             loc_oPg2.txt_4c_Lin.ReadOnly            = !par_lHabilitar
3442:             loc_oPg2.txt_4c_Lin2.ReadOnly           = !par_lHabilitar
3443:             loc_oPg2.txt_4c_ColecoesI.ReadOnly      = !par_lHabilitar
3444:             loc_oPg2.txt_4c_ColecoesF.ReadOnly      = !par_lHabilitar
3445:             loc_oPg2.txt_4c__UniIni.ReadOnly        = !par_lHabilitar
3446:             loc_oPg2.txt_4c__UniFim.ReadOnly        = !par_lHabilitar
3447:             loc_oPg2.txt_4c_ObsPes.ReadOnly         = !par_lHabilitar
3448:             loc_oPg2.obj_4c_GetObs.ReadOnly         = !par_lHabilitar
3449:             loc_oPg2.grd_4c_GGrupo.ReadOnly         = !par_lHabilitar
3450:             loc_oPg2.grd_4c_Grupos.ReadOnly         = !par_lHabilitar
3451:         CATCH TO loc_oErro
3452:             MsgErro(loc_oErro.Message, "FormBAL.HabilitarCamposDados")
3453:         ENDTRY
3454:     ENDPROC
3455: 
3456:     *--------------------------------------------------------------------------
3457:     * LimparCamposDados - Limpa campos da Page2
3458:     *--------------------------------------------------------------------------
3459:     PROCEDURE LimparCamposDados()
3460:         LOCAL loc_oPg2
3461:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3462: 
3463:         TRY
3464:             loc_oPg2.txt_4c_Codigo.Value          = 0
3465:             loc_oPg2.txt_4c_DBase.Value           = {}
3466:             loc_oPg2.txt_4c_Grupo.Value           = ""
3467:             loc_oPg2.txt_4c_DGrupo.Value          = ""
3468:             loc_oPg2.txt_4c_Conta.Value           = ""
3469:             loc_oPg2.txt_4c_DConta.Value          = ""
3470:             loc_oPg2.txt_4c_DataFinal.Value       = {}
3471:             loc_oPg2.txt_4c_DataInicial.Value     = {}
3472:             loc_oPg2.txt_4c_CProsI.Value          = ""
3473:             loc_oPg2.txt_4c_CProsF.Value          = ""
3474:             loc_oPg2.txt_4c_LocalInicial.Value    = ""
3475:             loc_oPg2.txt_4c_LocalFinal.Value      = ""
3476:             loc_oPg2.txt_4c_FornecInicial.Value   = ""
3477:             loc_oPg2.txt_4c_FornecFinal.Value     = ""
3478:             loc_oPg2.txt_4c_GGrupoInicial.Value   = ""
3479:             loc_oPg2.txt_4c_GGrupoFinal.Value     = ""
3480:             loc_oPg2.txt_4c_GrupoInicial.Value    = ""
3481:             loc_oPg2.txt_4c_GrupoFinal.Value      = ""
3482:             loc_oPg2.txt_4c_SGrusI.Value          = ""
3483:             loc_oPg2.txt_4c_SGrusF.Value          = ""
3484:             loc_oPg2.txt_4c_PrecoInicial.Value    = 0
3485:             loc_oPg2.txt_4c_PrecoFinal.Value      = 0
3486:             loc_oPg2.txt_4c_Lin.Value             = ""
3487:             loc_oPg2.txt_4c_Lin2.Value            = ""
3488:             loc_oPg2.txt_4c_ColecoesI.Value       = ""
3489:             loc_oPg2.txt_4c_ColecoesF.Value       = ""
3490:             loc_oPg2.txt_4c__UniIni.Value         = ""
3491:             loc_oPg2.txt_4c__UniFim.Value         = ""
3492:             loc_oPg2.txt_4c_ObsPes.Value          = ""
3493:             loc_oPg2.obj_4c_GetObs.Value          = ""
3494:             loc_oPg2.chk_4c_Fwcheckbox1.Value    = 0
3495:             loc_oPg2.chk_4c_Fwcheckbox2.Value    = 0
3496:             loc_oPg2.chk_4c_Fwcheckbox3.Value    = 0
3497:             loc_oPg2.obj_4c_Opt_Agrupa.Value      = 1
3498:             loc_oPg2.obj_4c_OptFilBarra.Value     = 1
3499:         CATCH TO loc_oErro

*-- Linhas 3508 a 3914:
3508:     *--------------------------------------------------------------------------
3509:     * BtnProcessoClick - Cria novo inventario (Incluir)
3510:     *--------------------------------------------------------------------------
3511:     PROCEDURE BtnProcessoClick()
3512:         TRY
3513:             THIS.this_oBusinessObject.this_lNovoRegistro = .T.
3514:             THIS.LimparCamposDados()
3515:             THIS.HabilitarCamposDados(.T.)
3516:             THIS.CarregarGrades()
3517:             THIS.this_cModoAtual = "INCLUIR"
3518:             THIS.AlternarPagina(2)
3519:             THIS.pgf_4c_Paginas.Page2.txt_4c_DBase.SetFocus()
3520:         CATCH TO loc_oErro
3521:             MsgErro(loc_oErro.Message, "FormBAL.BtnProcessoClick")
3522:         ENDTRY
3523:     ENDPROC
3524: 
3525:     *--------------------------------------------------------------------------
3526:     * BtnFechaClick - Encerra inventario selecionado
3527:     *--------------------------------------------------------------------------
3528:     PROCEDURE BtnFechaClick()
3529:         LOCAL loc_cCidchaves, loc_lConfirma
3530: 
3531:         TRY
3532:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3533:             IF EMPTY(loc_cCidchaves)
3534:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para encerrar.", "Aten" + CHR(231) + CHR(227) + "o")
3535:                 RETURN
3536:             ENDIF
3537: 
3538:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
3539:                 MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
3540:                 RETURN
3541:             ENDIF
3542: 
3543:             IF THIS.this_oBusinessObject.this_lEncerras
3544:                 MsgAviso("Invent" + CHR(225) + "rio j" + CHR(225) + " est" + CHR(225) + " encerrado.", "Aten" + CHR(231) + CHR(227) + "o")
3545:                 RETURN
3546:             ENDIF
3547: 
3548:             loc_lConfirma = MsgConfirma("Deseja encerrar o Invent" + CHR(225) + "rio " + ;
3549:                             TRANSFORM(THIS.this_oBusinessObject.this_nCodigos) + "?", ;
3550:                             "Confirmar Encerramento")
3551: 
3552:             IF loc_lConfirma
3553:                 IF THIS.this_oBusinessObject.AtualizarEncerramento(.T., DATE())
3554:                     MsgInfo("Invent" + CHR(225) + "rio encerrado com sucesso!", "Sucesso")
3555:                     THIS.CarregarLista()
3556:                 ENDIF
3557:             ENDIF
3558:         CATCH TO loc_oErro
3559:             MsgErro(loc_oErro.Message, "FormBAL.BtnFechaClick")
3560:         ENDTRY
3561:     ENDPROC
3562: 
3563:     *--------------------------------------------------------------------------
3564:     * BtnLeituraClick - Abre pagina de leitura para inventario selecionado
3565:     *--------------------------------------------------------------------------
3566:     PROCEDURE BtnLeituraClick()
3567:         LOCAL loc_cCidchaves
3568: 
3569:         TRY
3570:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3571:             IF EMPTY(loc_cCidchaves)
3572:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para iniciar a leitura.", "Aten" + CHR(231) + CHR(227) + "o")
3573:                 RETURN
3574:             ENDIF
3575: 
3576:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
3577:                 MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
3578:                 RETURN
3579:             ENDIF
3580: 
3581:             IF THIS.this_oBusinessObject.this_lEncerras
3582:                 MsgAviso("Invent" + CHR(225) + "rio encerrado. N" + CHR(227) + "o " + ;
3583:                          CHR(233) + " poss" + CHR(237) + "vel realizar leituras.", "Aten" + CHR(231) + CHR(227) + "o")
3584:                 RETURN
3585:             ENDIF
3586: 
3587:             THIS.this_cModoAtual = "LEITURA"
3588:             THIS.InicializarLeitura()
3589:             THIS.AlternarPagina(3)
3590:         CATCH TO loc_oErro
3591:             MsgErro(loc_oErro.Message, "FormBAL.BtnLeituraClick")
3592:         ENDTRY
3593:     ENDPROC
3594: 
3595:     *--------------------------------------------------------------------------
3596:     * BtnConsultaClick - Recarrega lista / aplica filtro
3597:     *--------------------------------------------------------------------------
3598:     PROCEDURE BtnConsultaClick()
3599:         TRY
3600:             THIS.CarregarLista()
3601:             THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3602:         CATCH TO loc_oErro
3603:             MsgErro(loc_oErro.Message, "FormBAL.BtnConsultaClick")
3604:         ENDTRY
3605:     ENDPROC
3606: 
3607:     *--------------------------------------------------------------------------
3608:     * BtnExportaClick - Exporta dados do inventario para Excel
3609:     *--------------------------------------------------------------------------
3610:     PROCEDURE BtnExportaClick()
3611:         LOCAL loc_cCidchaves, loc_cArquivo
3612: 
3613:         TRY
3614:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3615:             IF EMPTY(loc_cCidchaves)
3616:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para exportar.", "Aten" + CHR(231) + CHR(227) + "o")
3617:                 RETURN
3618:             ENDIF
3619: 
3620:             IF !USED("cursor_4c_Dados")
3621:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " dados para exportar.", "Aten" + CHR(231) + CHR(227) + "o")
3622:                 RETURN
3623:             ENDIF
3624: 
3625:             loc_cArquivo = GETFILE("XLS", "Exportar Invent" + CHR(225) + "rio", "Salvar", 0, "Exportar")
3626:             IF !EMPTY(loc_cArquivo)
3627:                 COPY TO (loc_cArquivo) TYPE XL5
3628:                 MsgInfo("Arquivo exportado com sucesso!", "Exportar")
3629:             ENDIF
3630:         CATCH TO loc_oErro
3631:             MsgErro(loc_oErro.Message, "FormBAL.BtnExportaClick")
3632:         ENDTRY
3633:     ENDPROC
3634: 
3635:     *--------------------------------------------------------------------------
3636:     * BtnInventarioClick - Imprime etiquetas do inventario selecionado
3637:     *--------------------------------------------------------------------------
3638:     PROCEDURE BtnInventarioClick()
3639:         LOCAL loc_cCidchaves
3640: 
3641:         TRY
3642:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
3643:             IF EMPTY(loc_cCidchaves)
3644:                 MsgAviso("Selecione um invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
3645:                 RETURN
3646:             ENDIF
3647: 
3648:             MsgInfo("Fun" + CHR(231) + CHR(227) + "o de etiquetas em desenvolvimento.", "Informa" + CHR(231) + CHR(227) + "o")
3649:         CATCH TO loc_oErro
3650:             MsgErro(loc_oErro.Message, "FormBAL.BtnInventarioClick")
3651:         ENDTRY
3652:     ENDPROC
3653: 
3654:     *--------------------------------------------------------------------------
3655:     * BtnEncerrarClick - Fecha o formulario
3656:     *--------------------------------------------------------------------------
3657:     PROCEDURE BtnEncerrarClick()
3658:         TRY
3659:             THIS.Release()
3660:         CATCH TO loc_oErro
3661:             MsgErro(loc_oErro.Message, "FormBAL.BtnEncerrarClick")
3662:         ENDTRY
3663:     ENDPROC
3664: 
3665:     *-- Handlers de ordenacao na lista
3666:     PROCEDURE BtnOrdenarPeriodoClick()
3667:         TRY
3668:             IF USED("cursor_4c_Dados")
3669:                 SELECT cursor_4c_Dados
3670:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
3671:             ENDIF
3672:         CATCH TO loc_oErro
3673:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarPeriodoClick")
3674:         ENDTRY
3675:     ENDPROC
3676: 
3677:     PROCEDURE BtnOrdenarEstoqueClick()
3678:         TRY
3679:             THIS.CarregarLista()
3680:         CATCH TO loc_oErro
3681:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarEstoqueClick")
3682:         ENDTRY
3683:     ENDPROC
3684: 
3685:     PROCEDURE BtnOrdenarLocalClick()
3686:         TRY
3687:             THIS.CarregarLista()
3688:         CATCH TO loc_oErro
3689:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarLocalClick")
3690:         ENDTRY
3691:     ENDPROC
3692: 
3693:     PROCEDURE BtnOrdenarGrupoClick()
3694:         TRY
3695:             THIS.CarregarLista()
3696:         CATCH TO loc_oErro
3697:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarGrupoClick")
3698:         ENDTRY
3699:     ENDPROC
3700: 
3701:     PROCEDURE BtnOrdenarGGrupoClick()
3702:         TRY
3703:             THIS.CarregarLista()
3704:         CATCH TO loc_oErro
3705:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarGGrupoClick")
3706:         ENDTRY
3707:     ENDPROC
3708: 
3709:     PROCEDURE BtnOrdenarUsuarioClick()
3710:         TRY
3711:             THIS.CarregarLista()
3712:         CATCH TO loc_oErro
3713:             MsgErro(loc_oErro.Message, "FormBAL.BtnOrdenarUsuarioClick")
3714:         ENDTRY
3715:     ENDPROC
3716: 
3717:     *==========================================================================
3718:     * HANDLERS - Page2 (Dados)
3719:     *==========================================================================
3720: 
3721:     *--------------------------------------------------------------------------
3722:     * BtnConfirmarClick - Salva parametros do inventario
3723:     *--------------------------------------------------------------------------
3724:     PROCEDURE BtnConfirmarClick()
3725:         LOCAL loc_lResultado, loc_cGrupos, loc_cContas
3726: 
3727:         TRY
3728:             loc_cGrupos = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
3729: 
3730:             *-- Validar grupo de estoque (obrigatorio)
3731:             IF EMPTY(loc_cGrupos)
3732:                 MsgAviso("Grupo de Estoque obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
3733:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
3734:                 RETURN
3735:             ENDIF
3736: 
3737:             IF !THIS.this_oBusinessObject.ValidarGrupoEstoque(loc_cGrupos)
3738:                 MsgAviso("Grupo de Estoque Inv" + CHR(225) + "lido!!!", "Valida" + CHR(231) + CHR(227) + "o")
3739:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.SetFocus()
3740:                 RETURN
3741:             ENDIF
3742: 
3743:             *-- Validar conta (opcional mas se preenchida deve ser valida)
3744:             loc_cContas = ALLTRIM(THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
3745:             IF !EMPTY(loc_cContas) AND !THIS.this_oBusinessObject.ValidarConta(loc_cContas)
3746:                 MsgAviso("Conta de Estoque Inv" + CHR(225) + "lida!!!", "Valida" + CHR(231) + CHR(227) + "o")
3747:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.SetFocus()
3748:                 RETURN
3749:             ENDIF
3750: 
3751:             *-- Transferir campos para BO
3752:             THIS.FormParaBO()
3753: 
3754:             *-- Salvar XML das grades de grupos
3755:             THIS.this_oBusinessObject.this_cMfilggrp  = THIS.ObterMfilGGrupo()
3756:             THIS.this_oBusinessObject.this_cMfilgrupo = THIS.ObterMfilGrupo()
3757: 
3758:             *-- Salvar registro
3759:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
3760: 
3761:             IF loc_lResultado
3762:                 MsgInfo("Invent" + CHR(225) + "rio salvo com sucesso!", "Sucesso")
3763:                 THIS.this_cModoAtual = "LISTA"
3764:                 THIS.CarregarLista()
3765:                 THIS.AlternarPagina(1)
3766:             ENDIF
3767:         CATCH TO loc_oErro
3768:             MsgErro(loc_oErro.Message, "FormBAL.BtnConfirmarClick")
3769:         ENDTRY
3770:     ENDPROC
3771: 
3772:     *--------------------------------------------------------------------------
3773:     * BtnCancelarClick - Cancela edicao e volta para lista
3774:     *--------------------------------------------------------------------------
3775:     PROCEDURE BtnCancelarClick()
3776:         TRY
3777:             THIS.this_cModoAtual = "LISTA"
3778:             THIS.AlternarPagina(1)
3779:         CATCH TO loc_oErro
3780:             MsgErro(loc_oErro.Message, "FormBAL.BtnCancelarClick")
3781:         ENDTRY
3782:     ENDPROC
3783: 
3784:     *--------------------------------------------------------------------------
3785:     * BtnSelecionarTodosGGrupoClick - Marca todos os grandes grupos
3786:     *--------------------------------------------------------------------------
3787:     PROCEDURE BtnSelecionarTodosGGrupoClick()
3788:         TRY
3789:             IF USED("cursor_4c_GGrupos")
3790:                 SELECT cursor_4c_GGrupos
3791:                 REPLACE ALL nMarcas WITH 1
3792:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3793:             ENDIF
3794:         CATCH TO loc_oErro
3795:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGGrupoClick")
3796:         ENDTRY
3797:     ENDPROC
3798: 
3799:     *--------------------------------------------------------------------------
3800:     * BtnDesmarcarTodosGGrupoClick - Desmarca todos os grandes grupos
3801:     *--------------------------------------------------------------------------
3802:     PROCEDURE BtnDesmarcarTodosGGrupoClick()
3803:         TRY
3804:             IF USED("cursor_4c_GGrupos")
3805:                 SELECT cursor_4c_GGrupos
3806:                 REPLACE ALL nMarcas WITH 0
3807:                 THIS.pgf_4c_Paginas.Page2.grd_4c_GGrupo.Refresh()
3808:             ENDIF
3809:         CATCH TO loc_oErro
3810:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGGrupoClick")
3811:         ENDTRY
3812:     ENDPROC
3813: 
3814:     *--------------------------------------------------------------------------
3815:     * BtnSelecionarTodosGrupoClick - Marca todos os grupos de produto
3816:     *--------------------------------------------------------------------------
3817:     PROCEDURE BtnSelecionarTodosGrupoClick()
3818:         TRY
3819:             IF USED("cursor_4c_GruposProd")
3820:                 SELECT cursor_4c_GruposProd
3821:                 REPLACE ALL nMarcas WITH 1
3822:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3823:             ENDIF
3824:         CATCH TO loc_oErro
3825:             MsgErro(loc_oErro.Message, "FormBAL.BtnSelecionarTodosGrupoClick")
3826:         ENDTRY
3827:     ENDPROC
3828: 
3829:     *--------------------------------------------------------------------------
3830:     * BtnDesmarcarTodosGrupoClick - Desmarca todos os grupos de produto
3831:     *--------------------------------------------------------------------------
3832:     PROCEDURE BtnDesmarcarTodosGrupoClick()
3833:         TRY
3834:             IF USED("cursor_4c_GruposProd")
3835:                 SELECT cursor_4c_GruposProd
3836:                 REPLACE ALL nMarcas WITH 0
3837:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Grupos.Refresh()
3838:             ENDIF
3839:         CATCH TO loc_oErro
3840:             MsgErro(loc_oErro.Message, "FormBAL.BtnDesmarcarTodosGrupoClick")
3841:         ENDTRY
3842:     ENDPROC
3843: 
3844:     *==========================================================================
3845:     * HANDLERS - Page3 (Leitura)
3846:     *==========================================================================
3847: 
3848:     *--------------------------------------------------------------------------
3849:     * BtnGravarClick - Salva item de leitura em SigIvTrH
3850:     *--------------------------------------------------------------------------
3851:     PROCEDURE BtnGravarClick()
3852:         LOCAL loc_cSQL, loc_nRes, loc_lSucesso
3853:         LOCAL loc_cProd, loc_cCodCor, loc_cCodTam, loc_nQtd, loc_nQtd2
3854:         LOCAL loc_cLocal, loc_cObs, loc_nLidos, loc_cEmps, loc_nCodigos
3855:         loc_lSucesso = .F.
3856: 
3857:         TRY
3858:             loc_cProd    = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Prod.Value)
3859:             loc_cCodCor  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Cor.Value)
3860:             loc_cCodTam  = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Tam.Value)
3861:             loc_nQtd     = THIS.pgf_4c_Paginas.Page3.txt_4c_Qtd.Value
3862:             loc_nQtd2    = THIS.pgf_4c_Paginas.Page3.txt_4c_Qtd2.Value
3863:             loc_cLocal   = ALLTRIM(THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value)
3864:             loc_cObs     = ALLTRIM(THIS.pgf_4c_Paginas.Page3.obj_4c_Get_Obs.Value)
3865:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3866:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3867: 
3868:             IF EMPTY(loc_cProd)
3869:                 MsgAviso("Produto n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
3870:                 RETURN
3871:             ENDIF
3872: 
3873:             IF loc_nQtd <= 0
3874:                 MsgAviso("Quantidade deve ser maior que zero.", "Aten" + CHR(231) + CHR(227) + "o")
3875:                 RETURN
3876:             ENDIF
3877: 
3878:             *-- Gerar UUID para cidchaves da leitura
3879:             LOCAL loc_cCidchaves, loc_nResUuid
3880:             loc_cCidchaves = ""
3881:             loc_nResUuid = SQLEXEC(gnConnHandle, "SELECT LEFT(NEWID(), 20) AS novo_uuid", "cursor_4c_UuidH")
3882:             IF loc_nResUuid >= 0 AND RECCOUNT("cursor_4c_UuidH") > 0
3883:                 SELECT cursor_4c_UuidH
3884:                 loc_cCidchaves = ALLTRIM(cursor_4c_UuidH.novo_uuid)
3885:             ENDIF
3886:             IF USED("cursor_4c_UuidH")
3887:                 USE IN cursor_4c_UuidH
3888:             ENDIF
3889: 
3890:             IF EMPTY(loc_cCidchaves)
3891:                 MsgErro("Erro ao gerar chave " + CHR(250) + "nica para leitura.", "Erro")
3892:                 RETURN
3893:             ENDIF
3894: 
3895:             *-- Obter cbars do produto (codigo de barras)
3896:             LOCAL loc_cCbars, loc_nResCb
3897:             loc_cCbars = ""
3898:             loc_nResCb = SQLEXEC(gnConnHandle, "SELECT TOP 1 cbars FROM SigCdPro WHERE cpros = " + ;
3899:                          EscaparSQL(loc_cProd), "cursor_4c_CBars")
3900:             IF loc_nResCb >= 0 AND RECCOUNT("cursor_4c_CBars") > 0
3901:                 SELECT cursor_4c_CBars
3902:                 loc_cCbars = ALLTRIM(cursor_4c_CBars.cbars)
3903:             ENDIF
3904:             IF USED("cursor_4c_CBars")
3905:                 USE IN cursor_4c_CBars
3906:             ENDIF
3907: 
3908:             loc_cSQL = "INSERT INTO SigIvTrH (cidchaves, emps, codigos, cbars, cpros," + ;
3909:                        " codcors, codtams, lidos, lidos2, localis, obs)" + ;
3910:                        " VALUES (" + ;
3911:                        EscaparSQL(loc_cCidchaves) + "," + ;
3912:                        EscaparSQL(loc_cEmps) + "," + ;
3913:                        FormatarNumeroSQL(loc_nCodigos) + "," + ;
3914:                        EscaparSQL(loc_cCbars) + "," + ;

*-- Linhas 3937 a 4787:
3937:     *--------------------------------------------------------------------------
3938:     * BtnCancelaClick - Cancela leitura e volta para lista
3939:     *--------------------------------------------------------------------------
3940:     PROCEDURE BtnCancelaClick()
3941:         TRY
3942:             THIS.this_cModoAtual = "LISTA"
3943:             THIS.CarregarLista()
3944:             THIS.AlternarPagina(1)
3945:         CATCH TO loc_oErro
3946:             MsgErro(loc_oErro.Message, "FormBAL.BtnCancelaClick")
3947:         ENDTRY
3948:     ENDPROC
3949: 
3950:     *--------------------------------------------------------------------------
3951:     * BtnTotalLocalClick - Mostra totais por local de armazenamento
3952:     *--------------------------------------------------------------------------
3953:     PROCEDURE BtnTotalLocalClick()
3954:         LOCAL loc_cSQL, loc_nRes, loc_nCodigos, loc_cEmps
3955: 
3956:         TRY
3957:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
3958:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
3959: 
3960:             IF USED("cursor_4c_TotalLocal")
3961:                 USE IN cursor_4c_TotalLocal
3962:             ENDIF
3963: 
3964:             loc_cSQL = "SELECT localis AS Local, COUNT(*) AS Qtde_Itens, SUM(lidos) AS Total_Qtd" + ;
3965:                        " FROM SigIvTrH" + ;
3966:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
3967:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
3968:                        " GROUP BY localis ORDER BY localis"
3969: 
3970:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TotalLocal")
3971:             IF loc_nRes >= 0
3972:                 MsgInfo("Consulta de totais por local conclu" + CHR(237) + "da.", "Total Local")
3973:             ELSE
3974:                 MsgErro("Erro ao calcular totais:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
3975:             ENDIF
3976:         CATCH TO loc_oErro
3977:             MsgErro(loc_oErro.Message, "FormBAL.BtnTotalLocalClick")
3978:         ENDTRY
3979:     ENDPROC
3980: 
3981:     *--------------------------------------------------------------------------
3982:     * BtnOcorrenciaClick - Registra ocorrencia
3983:     *--------------------------------------------------------------------------
3984:     PROCEDURE BtnOcorrenciaClick()
3985:         TRY
3986:             MsgInfo("Fun" + CHR(231) + CHR(227) + "o de Ocorr" + CHR(234) + "ncia em desenvolvimento.", "Informa" + CHR(231) + CHR(227) + "o")
3987:         CATCH TO loc_oErro
3988:             MsgErro(loc_oErro.Message, "FormBAL.BtnOcorrenciaClick")
3989:         ENDTRY
3990:     ENDPROC
3991: 
3992:     *--------------------------------------------------------------------------
3993:     * BtnImagemClick - Exibe imagem do produto selecionado
3994:     *--------------------------------------------------------------------------
3995:     PROCEDURE BtnImagemClick()
3996:         LOCAL loc_cProd, loc_cSQL, loc_nRes, loc_cImagem, loc_oPg3
3997:         loc_oPg3 = THIS.pgf_4c_Paginas.Page3
3998: 
3999:         TRY
4000:             loc_cProd = ALLTRIM(loc_oPg3.txt_4c_Prod.Value)
4001:             IF EMPTY(loc_cProd)
4002:                 RETURN
4003:             ENDIF
4004: 
4005:             loc_cSQL = "SELECT TOP 1 imagem FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cProd)
4006:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImgProd")
4007:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_ImgProd") > 0
4008:                 SELECT cursor_4c_ImgProd
4009:                 loc_cImagem = ALLTRIM(cursor_4c_ImgProd.imagem)
4010:                 IF !EMPTY(loc_cImagem) AND FILE(loc_cImagem)
4011:                     loc_oPg3.img_4c_ImgJpg.Picture = loc_cImagem
4012:                     loc_oPg3.img_4c_ImgJpg.Visible = .T.
4013:                 ELSE
4014:                     loc_oPg3.img_4c_ImgJpg.Visible = .F.
4015:                 ENDIF
4016:             ENDIF
4017:             IF USED("cursor_4c_ImgProd")
4018:                 USE IN cursor_4c_ImgProd
4019:             ENDIF
4020:         CATCH TO loc_oErro
4021:             MsgErro(loc_oErro.Message, "FormBAL.BtnImagemClick")
4022:         ENDTRY
4023:     ENDPROC
4024: 
4025:     *--------------------------------------------------------------------------
4026:     * BtnLocalGravadoClick - Exibe ultimo local gravado
4027:     *--------------------------------------------------------------------------
4028:     PROCEDURE BtnLocalGravadoClick()
4029:         LOCAL loc_cSQL, loc_nRes, loc_cEmps, loc_nCodigos
4030: 
4031:         TRY
4032:             loc_cEmps    = ALLTRIM(THIS.this_oBusinessObject.this_cEmps)
4033:             loc_nCodigos = THIS.this_oBusinessObject.this_nCodigos
4034: 
4035:             loc_cSQL = "SELECT TOP 1 localis FROM SigIvTrH" + ;
4036:                        " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
4037:                        " AND codigos = " + FormatarNumeroSQL(loc_nCodigos) + ;
4038:                        " ORDER BY cidchaves DESC"
4039: 
4040:             loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UltLocal")
4041:             IF loc_nRes >= 0 AND RECCOUNT("cursor_4c_UltLocal") > 0
4042:                 SELECT cursor_4c_UltLocal
4043:                 THIS.pgf_4c_Paginas.Page3.txt_4c_Local.Value = ALLTRIM(cursor_4c_UltLocal.localis)
4044:             ENDIF
4045:             IF USED("cursor_4c_UltLocal")
4046:                 USE IN cursor_4c_UltLocal
4047:             ENDIF
4048:         CATCH TO loc_oErro
4049:             MsgErro(loc_oErro.Message, "FormBAL.BtnLocalGravadoClick")
4050:         ENDTRY
4051:     ENDPROC
4052: 
4053:     *--------------------------------------------------------------------------
4054:     * BtnExcluirLeituraClick - Exclui registro de leitura selecionado na grade
4055:     *--------------------------------------------------------------------------
4056:     PROCEDURE BtnExcluirLeituraClick()
4057:         LOCAL loc_cCidchaves, loc_cSQL, loc_nRes, loc_lConfirma
4058: 
4059:         TRY
4060:             IF !USED("cursor_4c_Historico") OR RECCOUNT("cursor_4c_Historico") = 0
4061:                 MsgAviso("Selecione uma leitura para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
4062:                 RETURN
4063:             ENDIF
4064: 
4065:             SELECT cursor_4c_Historico
4066:             loc_cCidchaves = ALLTRIM(cursor_4c_Historico.cbars)
4067: 
4068:             loc_lConfirma = MsgConfirma("Deseja excluir esta leitura?", "Confirmar Exclus" + CHR(227) + "o")
4069: 
4070:             IF loc_lConfirma
4071:                 loc_cSQL = "DELETE FROM SigIvTrH WHERE cbars = " + EscaparSQL(loc_cCidchaves) + ;
4072:                            " AND emps = " + EscaparSQL(ALLTRIM(THIS.this_oBusinessObject.this_cEmps)) + ;
4073:                            " AND codigos = " + FormatarNumeroSQL(THIS.this_oBusinessObject.this_nCodigos)
4074: 
4075:                 loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
4076:                 IF loc_nRes >= 0
4077:                     THIS.CarregarGradeLeitura()
4078:                 ELSE
4079:                     MsgErro("Erro ao excluir leitura:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
4080:                 ENDIF
4081:             ENDIF
4082:         CATCH TO loc_oErro
4083:             MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirLeituraClick")
4084:         ENDTRY
4085:     ENDPROC
4086: 
4087:     *==========================================================================
4088:     * HANDLERS DE LOOKUP (KeyPress F4)
4089:     *==========================================================================
4090: 
4091:     PROCEDURE KeyPressGrupo(par_nKeyCode, par_nShiftAltCtrl)
4092:         LOCAL loc_oForm, loc_cValor
4093: 
4094:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4095:             TRY
4096:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4097:                     "SigCdGcr", "Codigos", "descrs", "Grupo de Estoque", ;
4098:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value)
4099:                 IF VARTYPE(loc_oForm) = "O"
4100:                     loc_oForm.Show()
4101:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4102:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Grupo.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4103:                         THIS.CarregarDescricaoGrupo()
4104:                     ENDIF
4105:                 ENDIF
4106:             CATCH TO loc_oErro
4107:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupo")
4108:             ENDTRY
4109:             par_nKeyCode = 0
4110:         ENDIF
4111: 
4112:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4113:             KEYBOARD CHR(9)
4114:         ENDIF
4115:     ENDPROC
4116: 
4117:     PROCEDURE KeyPressConta(par_nKeyCode, par_nShiftAltCtrl)
4118:         LOCAL loc_oForm
4119: 
4120:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4121:             TRY
4122:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4123:                     "SigCdCli", "IClis", "DNoms", "Conta de Estoque", ;
4124:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value)
4125:                 IF VARTYPE(loc_oForm) = "O"
4126:                     loc_oForm.Show()
4127:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4128:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Conta.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4129:                         THIS.CarregarDescricaoConta()
4130:                     ENDIF
4131:                 ENDIF
4132:             CATCH TO loc_oErro
4133:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressConta")
4134:             ENDTRY
4135:             par_nKeyCode = 0
4136:         ENDIF
4137: 
4138:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4139:             KEYBOARD CHR(9)
4140:         ENDIF
4141:     ENDPROC
4142: 
4143:     PROCEDURE KeyPressCProsI(par_nKeyCode, par_nShiftAltCtrl)
4144:         LOCAL loc_oForm
4145: 
4146:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4147:             TRY
4148:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4149:                     "SigCdPro", "cpros", "dpros", "Produto Inicial", ;
4150:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_CProsI.Value)
4151:                 IF VARTYPE(loc_oForm) = "O"
4152:                     loc_oForm.Show()
4153:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4154:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CProsI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4155:                     ENDIF
4156:                 ENDIF
4157:             CATCH TO loc_oErro
4158:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressCProsI")
4159:             ENDTRY
4160:             par_nKeyCode = 0
4161:         ENDIF
4162: 
4163:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4164:             KEYBOARD CHR(9)
4165:         ENDIF
4166:     ENDPROC
4167: 
4168:     PROCEDURE KeyPressCProsF(par_nKeyCode, par_nShiftAltCtrl)
4169:         LOCAL loc_oForm
4170: 
4171:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4172:             TRY
4173:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4174:                     "SigCdPro", "cpros", "dpros", "Produto Final", ;
4175:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_CProsF.Value)
4176:                 IF VARTYPE(loc_oForm) = "O"
4177:                     loc_oForm.Show()
4178:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4179:                         THIS.pgf_4c_Paginas.Page2.txt_4c_CProsF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4180:                     ENDIF
4181:                 ENDIF
4182:             CATCH TO loc_oErro
4183:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressCProsF")
4184:             ENDTRY
4185:             par_nKeyCode = 0
4186:         ENDIF
4187: 
4188:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4189:             KEYBOARD CHR(9)
4190:         ENDIF
4191:     ENDPROC
4192: 
4193:     PROCEDURE KeyPressLocalInicial(par_nKeyCode, par_nShiftAltCtrl)
4194:         LOCAL loc_oForm
4195: 
4196:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4197:             TRY
4198:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4199:                     "SigPrLcl", "codigos", "descs", "Local Inicial", ;
4200:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_LocalInicial.Value)
4201:                 IF VARTYPE(loc_oForm) = "O"
4202:                     loc_oForm.Show()
4203:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4204:                         THIS.pgf_4c_Paginas.Page2.txt_4c_LocalInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4205:                     ENDIF
4206:                 ENDIF
4207:             CATCH TO loc_oErro
4208:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLocalInicial")
4209:             ENDTRY
4210:             par_nKeyCode = 0
4211:         ENDIF
4212: 
4213:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4214:             KEYBOARD CHR(9)
4215:         ENDIF
4216:     ENDPROC
4217: 
4218:     PROCEDURE KeyPressLocalFinal(par_nKeyCode, par_nShiftAltCtrl)
4219:         LOCAL loc_oForm
4220: 
4221:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4222:             TRY
4223:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4224:                     "SigPrLcl", "codigos", "descs", "Local Final", ;
4225:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_LocalFinal.Value)
4226:                 IF VARTYPE(loc_oForm) = "O"
4227:                     loc_oForm.Show()
4228:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4229:                         THIS.pgf_4c_Paginas.Page2.txt_4c_LocalFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4230:                     ENDIF
4231:                 ENDIF
4232:             CATCH TO loc_oErro
4233:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLocalFinal")
4234:             ENDTRY
4235:             par_nKeyCode = 0
4236:         ENDIF
4237: 
4238:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4239:             KEYBOARD CHR(9)
4240:         ENDIF
4241:     ENDPROC
4242: 
4243:     PROCEDURE KeyPressGGrupoInicial(par_nKeyCode, par_nShiftAltCtrl)
4244:         LOCAL loc_oForm
4245: 
4246:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4247:             TRY
4248:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4249:                     "SigCdGpr", "codigos", "descs", "Grande Grupo Inicial", ;
4250:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoInicial.Value)
4251:                 IF VARTYPE(loc_oForm) = "O"
4252:                     loc_oForm.Show()
4253:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4254:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4255:                     ENDIF
4256:                 ENDIF
4257:             CATCH TO loc_oErro
4258:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGGrupoInicial")
4259:             ENDTRY
4260:             par_nKeyCode = 0
4261:         ENDIF
4262: 
4263:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4264:             KEYBOARD CHR(9)
4265:         ENDIF
4266:     ENDPROC
4267: 
4268:     PROCEDURE KeyPressGGrupoFinal(par_nKeyCode, par_nShiftAltCtrl)
4269:         LOCAL loc_oForm
4270: 
4271:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4272:             TRY
4273:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4274:                     "SigCdGpr", "codigos", "descs", "Grande Grupo Final", ;
4275:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoFinal.Value)
4276:                 IF VARTYPE(loc_oForm) = "O"
4277:                     loc_oForm.Show()
4278:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4279:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GGrupoFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4280:                     ENDIF
4281:                 ENDIF
4282:             CATCH TO loc_oErro
4283:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGGrupoFinal")
4284:             ENDTRY
4285:             par_nKeyCode = 0
4286:         ENDIF
4287: 
4288:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4289:             KEYBOARD CHR(9)
4290:         ENDIF
4291:     ENDPROC
4292: 
4293:     PROCEDURE KeyPressGrupoInicial(par_nKeyCode, par_nShiftAltCtrl)
4294:         LOCAL loc_oForm
4295: 
4296:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4297:             TRY
4298:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4299:                     "SigCdGrp", "cgrus", "descs", "Grupo Inicial", ;
4300:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoInicial.Value)
4301:                 IF VARTYPE(loc_oForm) = "O"
4302:                     loc_oForm.Show()
4303:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4304:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4305:                     ENDIF
4306:                 ENDIF
4307:             CATCH TO loc_oErro
4308:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupoInicial")
4309:             ENDTRY
4310:             par_nKeyCode = 0
4311:         ENDIF
4312: 
4313:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4314:             KEYBOARD CHR(9)
4315:         ENDIF
4316:     ENDPROC
4317: 
4318:     PROCEDURE KeyPressGrupoFinal(par_nKeyCode, par_nShiftAltCtrl)
4319:         LOCAL loc_oForm
4320: 
4321:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4322:             TRY
4323:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4324:                     "SigCdGrp", "cgrus", "descs", "Grupo Final", ;
4325:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoFinal.Value)
4326:                 IF VARTYPE(loc_oForm) = "O"
4327:                     loc_oForm.Show()
4328:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4329:                         THIS.pgf_4c_Paginas.Page2.txt_4c_GrupoFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4330:                     ENDIF
4331:                 ENDIF
4332:             CATCH TO loc_oErro
4333:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressGrupoFinal")
4334:             ENDTRY
4335:             par_nKeyCode = 0
4336:         ENDIF
4337: 
4338:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4339:             KEYBOARD CHR(9)
4340:         ENDIF
4341:     ENDPROC
4342: 
4343:     PROCEDURE KeyPressLin(par_nKeyCode, par_nShiftAltCtrl)
4344:         LOCAL loc_oForm
4345: 
4346:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4347:             TRY
4348:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4349:                     "SigCdLin", "Linhas", "descs", "Linha Inicial", ;
4350:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Lin.Value)
4351:                 IF VARTYPE(loc_oForm) = "O"
4352:                     loc_oForm.Show()
4353:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4354:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Lin.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4355:                     ENDIF
4356:                 ENDIF
4357:             CATCH TO loc_oErro
4358:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLin")
4359:             ENDTRY
4360:             par_nKeyCode = 0
4361:         ENDIF
4362: 
4363:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4364:             KEYBOARD CHR(9)
4365:         ENDIF
4366:     ENDPROC
4367: 
4368:     PROCEDURE KeyPressLin2(par_nKeyCode, par_nShiftAltCtrl)
4369:         LOCAL loc_oForm
4370: 
4371:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4372:             TRY
4373:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4374:                     "SigCdLin", "Linhas", "descs", "Linha Final", ;
4375:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_Lin2.Value)
4376:                 IF VARTYPE(loc_oForm) = "O"
4377:                     loc_oForm.Show()
4378:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4379:                         THIS.pgf_4c_Paginas.Page2.txt_4c_Lin2.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4380:                     ENDIF
4381:                 ENDIF
4382:             CATCH TO loc_oErro
4383:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressLin2")
4384:             ENDTRY
4385:             par_nKeyCode = 0
4386:         ENDIF
4387: 
4388:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4389:             KEYBOARD CHR(9)
4390:         ENDIF
4391:     ENDPROC
4392: 
4393:     PROCEDURE KeyPressUniIni(par_nKeyCode, par_nShiftAltCtrl)
4394:         LOCAL loc_oForm
4395: 
4396:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4397:             TRY
4398:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4399:                     "SigCdUni", "Cunis", "descs", "Unidade Inicial", ;
4400:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c__UniIni.Value)
4401:                 IF VARTYPE(loc_oForm) = "O"
4402:                     loc_oForm.Show()
4403:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4404:                         THIS.pgf_4c_Paginas.Page2.txt_4c__UniIni.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4405:                     ENDIF
4406:                 ENDIF
4407:             CATCH TO loc_oErro
4408:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressUniIni")
4409:             ENDTRY
4410:             par_nKeyCode = 0
4411:         ENDIF
4412: 
4413:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4414:             KEYBOARD CHR(9)
4415:         ENDIF
4416:     ENDPROC
4417: 
4418:     PROCEDURE KeyPressUniFim(par_nKeyCode, par_nShiftAltCtrl)
4419:         LOCAL loc_oForm
4420: 
4421:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4422:             TRY
4423:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4424:                     "SigCdUni", "Cunis", "descs", "Unidade Final", ;
4425:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c__UniFim.Value)
4426:                 IF VARTYPE(loc_oForm) = "O"
4427:                     loc_oForm.Show()
4428:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4429:                         THIS.pgf_4c_Paginas.Page2.txt_4c__UniFim.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4430:                     ENDIF
4431:                 ENDIF
4432:             CATCH TO loc_oErro
4433:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressUniFim")
4434:             ENDTRY
4435:             par_nKeyCode = 0
4436:         ENDIF
4437: 
4438:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4439:             KEYBOARD CHR(9)
4440:         ENDIF
4441:     ENDPROC
4442: 
4443:     PROCEDURE KeyPressFornecInicial(par_nKeyCode, par_nShiftAltCtrl)
4444:         LOCAL loc_oForm
4445: 
4446:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4447:             TRY
4448:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4449:                     "SigCdCli", "Iclis", "Rclis", "Fornecedor Inicial", ;
4450:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_FornecInicial.Value)
4451:                 IF VARTYPE(loc_oForm) = "O"
4452:                     loc_oForm.Show()
4453:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4454:                         THIS.pgf_4c_Paginas.Page2.txt_4c_FornecInicial.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4455:                     ENDIF
4456:                 ENDIF
4457:             CATCH TO loc_oErro
4458:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressFornecInicial")
4459:             ENDTRY
4460:             par_nKeyCode = 0
4461:         ENDIF
4462: 
4463:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4464:             KEYBOARD CHR(9)
4465:         ENDIF
4466:     ENDPROC
4467: 
4468:     PROCEDURE KeyPressFornecFinal(par_nKeyCode, par_nShiftAltCtrl)
4469:         LOCAL loc_oForm
4470: 
4471:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4472:             TRY
4473:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4474:                     "SigCdCli", "Iclis", "Rclis", "Fornecedor Final", ;
4475:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_FornecFinal.Value)
4476:                 IF VARTYPE(loc_oForm) = "O"
4477:                     loc_oForm.Show()
4478:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4479:                         THIS.pgf_4c_Paginas.Page2.txt_4c_FornecFinal.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4480:                     ENDIF
4481:                 ENDIF
4482:             CATCH TO loc_oErro
4483:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressFornecFinal")
4484:             ENDTRY
4485:             par_nKeyCode = 0
4486:         ENDIF
4487: 
4488:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4489:             KEYBOARD CHR(9)
4490:         ENDIF
4491:     ENDPROC
4492: 
4493:     PROCEDURE KeyPressSGrusI(par_nKeyCode, par_nShiftAltCtrl)
4494:         LOCAL loc_oForm
4495: 
4496:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4497:             TRY
4498:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4499:                     "SigCdPsg", "Codigos", "Descricaos", "Sub-Grupo Inicial", ;
4500:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusI.Value)
4501:                 IF VARTYPE(loc_oForm) = "O"
4502:                     loc_oForm.Show()
4503:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4504:                         THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4505:                     ENDIF
4506:                 ENDIF
4507:             CATCH TO loc_oErro
4508:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressSGrusI")
4509:             ENDTRY
4510:             par_nKeyCode = 0
4511:         ENDIF
4512: 
4513:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4514:             KEYBOARD CHR(9)
4515:         ENDIF
4516:     ENDPROC
4517: 
4518:     PROCEDURE KeyPressSGrusF(par_nKeyCode, par_nShiftAltCtrl)
4519:         LOCAL loc_oForm
4520: 
4521:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4522:             TRY
4523:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4524:                     "SigCdPsg", "Codigos", "Descricaos", "Sub-Grupo Final", ;
4525:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusF.Value)
4526:                 IF VARTYPE(loc_oForm) = "O"
4527:                     loc_oForm.Show()
4528:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4529:                         THIS.pgf_4c_Paginas.Page2.txt_4c_SGrusF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4530:                     ENDIF
4531:                 ENDIF
4532:             CATCH TO loc_oErro
4533:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressSGrusF")
4534:             ENDTRY
4535:             par_nKeyCode = 0
4536:         ENDIF
4537: 
4538:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4539:             KEYBOARD CHR(9)
4540:         ENDIF
4541:     ENDPROC
4542: 
4543:     PROCEDURE KeyPressColecoesI(par_nKeyCode, par_nShiftAltCtrl)
4544:         LOCAL loc_oForm
4545: 
4546:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4547:             TRY
4548:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4549:                     "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o Inicial", ;
4550:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesI.Value)
4551:                 IF VARTYPE(loc_oForm) = "O"
4552:                     loc_oForm.Show()
4553:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4554:                         THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesI.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4555:                     ENDIF
4556:                 ENDIF
4557:             CATCH TO loc_oErro
4558:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressColecoesI")
4559:             ENDTRY
4560:             par_nKeyCode = 0
4561:         ENDIF
4562: 
4563:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4564:             KEYBOARD CHR(9)
4565:         ENDIF
4566:     ENDPROC
4567: 
4568:     PROCEDURE KeyPressColecoesF(par_nKeyCode, par_nShiftAltCtrl)
4569:         LOCAL loc_oForm
4570: 
4571:         IF par_nKeyCode = 115 OR par_nKeyCode = 13
4572:             TRY
4573:                 loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", ;
4574:                     "SigCdCol", "Colecoes", "Descs", "Cole" + CHR(231) + CHR(227) + "o Final", ;
4575:                     "", THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesF.Value)
4576:                 IF VARTYPE(loc_oForm) = "O"
4577:                     loc_oForm.Show()
4578:                     IF !EMPTY(loc_oForm.this_cValorSelecionado)
4579:                         THIS.pgf_4c_Paginas.Page2.txt_4c_ColecoesF.Value = ALLTRIM(loc_oForm.this_cValorSelecionado)
4580:                     ENDIF
4581:                 ENDIF
4582:             CATCH TO loc_oErro
4583:                 MsgErro(loc_oErro.Message, "FormBAL.KeyPressColecoesF")
4584:             ENDTRY
4585:             par_nKeyCode = 0
4586:         ENDIF
4587: 
4588:         IF par_nKeyCode = 9 OR par_nKeyCode = 13
4589:             KEYBOARD CHR(9)
4590:         ENDIF
4591:     ENDPROC
4592: 
4593:     *--------------------------------------------------------------------------
4594:     * BtnIncluirClick - Cria novo inventario
4595:     *--------------------------------------------------------------------------
4596:     PROCEDURE BtnIncluirClick()
4597:         TRY
4598:             THIS.this_oBusinessObject.this_lNovoRegistro = .T.
4599:             THIS.LimparCamposDados()
4600:             THIS.HabilitarCamposDados(.T.)
4601:             THIS.CarregarGrades()
4602:             THIS.this_cModoAtual = "INCLUIR"
4603:             THIS.AlternarPagina(2)
4604:             THIS.pgf_4c_Paginas.Page2.txt_4c_DBase.SetFocus()
4605:         CATCH TO loc_oErro
4606:             MsgErro(loc_oErro.Message, "FormBAL.BtnIncluirClick")
4607:         ENDTRY
4608:     ENDPROC
4609: 
4610:     *--------------------------------------------------------------------------
4611:     * BtnAlterarClick - Abre inventario selecionado para edicao
4612:     *--------------------------------------------------------------------------
4613:     PROCEDURE BtnAlterarClick()
4614:         LOCAL loc_cCidchaves
4615:         TRY
4616:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
4617:             IF EMPTY(loc_cCidchaves)
4618:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para alterar.", "Aten" + CHR(231) + CHR(227) + "o")
4619:             ELSE
4620:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
4621:                     MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
4622:                 ELSE
4623:                     THIS.this_oBusinessObject.this_lNovoRegistro = .F.
4624:                     THIS.BOParaForm()
4625:                     THIS.CarregarGrades()
4626:                     THIS.HabilitarCamposDados(.T.)
4627:                     THIS.this_cModoAtual = "ALTERAR"
4628:                     THIS.AlternarPagina(2)
4629:                 ENDIF
4630:             ENDIF
4631:         CATCH TO loc_oErro
4632:             MsgErro(loc_oErro.Message, "FormBAL.BtnAlterarClick")
4633:         ENDTRY
4634:     ENDPROC
4635: 
4636:     *--------------------------------------------------------------------------
4637:     * BtnVisualizarClick - Abre inventario selecionado em modo leitura
4638:     *--------------------------------------------------------------------------
4639:     PROCEDURE BtnVisualizarClick()
4640:         LOCAL loc_cCidchaves
4641:         TRY
4642:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
4643:             IF EMPTY(loc_cCidchaves)
4644:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para visualizar.", "Aten" + CHR(231) + CHR(227) + "o")
4645:             ELSE
4646:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
4647:                     MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
4648:                 ELSE
4649:                     THIS.BOParaForm()
4650:                     THIS.CarregarGrades()
4651:                     THIS.HabilitarCamposDados(.F.)
4652:                     THIS.this_cModoAtual = "VISUALIZAR"
4653:                     THIS.AlternarPagina(2)
4654:                 ENDIF
4655:             ENDIF
4656:         CATCH TO loc_oErro
4657:             MsgErro(loc_oErro.Message, "FormBAL.BtnVisualizarClick")
4658:         ENDTRY
4659:     ENDPROC
4660: 
4661:     *--------------------------------------------------------------------------
4662:     * BtnExcluirClick - Exclui inventario selecionado
4663:     *--------------------------------------------------------------------------
4664:     PROCEDURE BtnExcluirClick()
4665:         LOCAL loc_cCidchaves, loc_lConfirma
4666:         TRY
4667:             loc_cCidchaves = THIS.ObterCidchavesSelecionado()
4668:             IF EMPTY(loc_cCidchaves)
4669:                 MsgAviso("Selecione um invent" + CHR(225) + "rio para excluir.", "Aten" + CHR(231) + CHR(227) + "o")
4670:             ELSE
4671:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidchaves)
4672:                     MsgAviso("Erro ao carregar invent" + CHR(225) + "rio.", "Aten" + CHR(231) + CHR(227) + "o")
4673:                 ELSE
4674:                     loc_lConfirma = MsgConfirma("Deseja excluir o Invent" + CHR(225) + "rio " + ;
4675:                                     TRANSFORM(THIS.this_oBusinessObject.this_nCodigos) + "?", ;
4676:                                     "Confirmar Exclus" + CHR(227) + "o")
4677:                     IF loc_lConfirma
4678:                         IF THIS.this_oBusinessObject.Excluir()
4679:                             MsgInfo("Invent" + CHR(225) + "rio exclu" + CHR(237) + "do com sucesso!", "Sucesso")
4680:                             THIS.CarregarLista()
4681:                         ENDIF
4682:                     ENDIF
4683:                 ENDIF
4684:             ENDIF
4685:         CATCH TO loc_oErro
4686:             MsgErro(loc_oErro.Message, "FormBAL.BtnExcluirClick")
4687:         ENDTRY
4688:     ENDPROC
4689: 
4690:     *--------------------------------------------------------------------------
4691:     * TornarControlesVisiveis - Torna controles do container visiveis
4692:     *--------------------------------------------------------------------------
4693:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
4694:         LOCAL i, loc_oControl
4695: 
4696:         IF VARTYPE(par_oContainer) != "O"
4697:             RETURN
4698:         ENDIF
4699: 
4700:         FOR i = 1 TO par_oContainer.ControlCount
4701:             loc_oControl = par_oContainer.Controls(i)
4702:             loc_oControl.Visible = .T.
4703: 
4704:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
4705:                 THIS.TornarControlesVisiveis(loc_oControl)
4706:             ENDIF
4707:         ENDFOR
4708:     ENDPROC
4709: 
4710:     *--------------------------------------------------------------------------
4711:     * Destroy - Libera recursos
4712:     *--------------------------------------------------------------------------
4713:     PROCEDURE Destroy()
4714:         TRY
4715:             IF USED("cursor_4c_Dados")
4716:                 USE IN cursor_4c_Dados
4717:             ENDIF
4718:             IF USED("cursor_4c_GGrupos")
4719:                 USE IN cursor_4c_GGrupos
4720:             ENDIF
4721:             IF USED("cursor_4c_GruposProd")
4722:                 USE IN cursor_4c_GruposProd
4723:             ENDIF
4724:             IF USED("cursor_4c_Historico")
4725:                 USE IN cursor_4c_Historico
4726:             ENDIF
4727:         CATCH TO loc_oErro
4728:             MsgErro(loc_oErro.Message, "FormBAL.Destroy")
4729:         ENDTRY
4730: 
4731:         DODEFAULT()
4732:     ENDPROC
4733: 
4734:     *--------------------------------------------------------------------------
4735:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo atual
4736:     *--------------------------------------------------------------------------
4737:     PROCEDURE AjustarBotoesPorModo()
4738:         LOCAL loc_lModoEdicao, loc_oPage1
4739:         TRY
4740:             loc_lModoEdicao = (THIS.this_cModoAtual = "NOVO" OR THIS.this_cModoAtual = "EDICAO")
4741:             loc_oPage1 = THIS.pgf_4c_Paginas.Page1
4742:             IF VARTYPE(loc_oPage1.cmd_4c_Incluir) = "O"
4743:                 loc_oPage1.cmd_4c_Incluir.Enabled = !loc_lModoEdicao
4744:             ENDIF
4745:             IF VARTYPE(loc_oPage1.cmd_4c_Alterar) = "O"
4746:                 loc_oPage1.cmd_4c_Alterar.Enabled = !loc_lModoEdicao
4747:             ENDIF
4748:             IF VARTYPE(loc_oPage1.cmd_4c_Excluir) = "O"
4749:                 loc_oPage1.cmd_4c_Excluir.Enabled = !loc_lModoEdicao
4750:             ENDIF
4751:             IF VARTYPE(loc_oPage1.cmd_4c_Visualizar) = "O"
4752:                 loc_oPage1.cmd_4c_Visualizar.Enabled = !loc_lModoEdicao
4753:             ENDIF
4754:         CATCH TO loc_oErro
4755:             MsgErro(loc_oErro.Message, "FormBAL.AjustarBotoesPorModo")
4756:         ENDTRY
4757:     ENDPROC
4758: 
4759:     *--------------------------------------------------------------------------
4760:     * HabilitarCampos - Delega a HabilitarCamposDados
4761:     *--------------------------------------------------------------------------
4762:     PROCEDURE HabilitarCampos(par_lHabilitar)
4763:         THIS.HabilitarCamposDados(par_lHabilitar)
4764:     ENDPROC
4765: 
4766:     *--------------------------------------------------------------------------
4767:     * LimparCampos - Delega a LimparCamposDados
4768:     *--------------------------------------------------------------------------
4769:     PROCEDURE LimparCampos()
4770:         THIS.LimparCamposDados()
4771:     ENDPROC
4772: 
4773:     *--------------------------------------------------------------------------
4774:     * BtnSalvarClick - Alias para BtnConfirmarClick
4775:     *--------------------------------------------------------------------------
4776:     PROCEDURE BtnSalvarClick()
4777:         THIS.BtnConfirmarClick()
4778:     ENDPROC
4779: 
4780:     *--------------------------------------------------------------------------
4781:     * BtnBuscarClick - Recarrega lista (form operacional sem busca dedicada)
4782:     *--------------------------------------------------------------------------
4783:     PROCEDURE BtnBuscarClick()
4784:         THIS.CarregarLista()
4785:     ENDPROC
4786: 
4787: ENDDEFINE


### BO (C:\4c\projeto\app\classes\BALBO.prg):
*====================================================================
* BALBO.prg
*
* Business Object para Balanco de Inventario
* Tabela: SIGCDBAL
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS BALBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDBAL)
	*-- PK
	this_cCidchaves  = ""   && cidchaves char(20) - PK (chave unica UUID)
	*-- Identificacao
	this_nCodigos    = 0    && codigos numeric(4,0) - codigo do balanco
	this_cEmps       = ""   && emps char(3) - empresa
	this_cUsuars     = ""   && usuars char(10) - usuario
	this_nNtrans     = 0    && ntrans numeric(6,0) - numero da transacao
	*-- Grupos de Estoque (conta + grupo)
	this_cGrupos     = ""   && grupos char(10) - grupo de estoque (SigCdGcr)
	this_cContas     = ""   && contas char(10) - conta de estoque (SigCdCli)
	*-- Datas
	this_dDtbases    = {}   && dtbases datetime - data base
	this_dDatainis   = {}   && datainis datetime - data inicial leitura
	this_dDatafims   = {}   && datafims datetime - data final leitura
	this_dDatatrans  = {}   && datatrans datetime - data transporte
	*-- Flags de controle
	this_lEncerras   = .F.  && encerras bit - balanco encerrado
	this_lTratas     = .F.  && tratas bit - tratamento especial
	this_nSepestqs   = 0    && sepestqs numeric(1,0) - separar por estoque
	this_nTrtporpeso = 0    && trtporpeso numeric(1,0) - tratar por peso
	this_nAgrupas    = 0    && agrupas numeric(1,0) - forma de agrupamento
	this_nLeitgructa = 0    && leitgructa numeric(1,0) - leitura somente grupo+conta
	this_nFilbarras  = 0    && filbarras numeric(1,0) - filtro tipo codigo de barras
	*-- Locais (filtros)
	this_cLocals     = ""   && locals char(10) - local (usado na leitura)
	this_cLocalis    = ""   && localis char(10) - local inicial (filtro)
	this_cLocalfs    = ""   && localfs char(10) - local final (filtro)
	*-- Fornecedores (filtros)
	this_cIforis     = ""   && iforis char(10) - fornecedor inicial
	this_cIforfs     = ""   && iforfs char(10) - fornecedor final
	*-- Preco (filtros)
	this_nPrecois    = 0    && precois numeric(8,2) - preco inicial
	this_nPrecofs    = 0    && precofs numeric(8,2) - preco final
	*-- Grupos de Produto (filtros)
	this_cCgruis     = ""   && cgruis char(3) - grupo produto inicial (SigCdGrp.cgrus)
	this_cCgrufs     = ""   && cgrufs char(3) - grupo produto final (SigCdGrp.cgrus)
	*-- Grandes Grupos (filtros)
	this_cCggruis    = ""   && cggruis char(3) - grande grupo inicial (SigCdGpr.codigos)
	this_cCggrufs    = ""   && cggrufs char(3) - grande grupo final (SigCdGpr.codigos)
	*-- Colecoes (filtros)
	this_cColecoesi  = ""   && colecoesi char(10) - colecao inicial (SigCdCol.colecoes)
	this_cColecoesf  = ""   && colecoesf char(10) - colecao final (SigCdCol.colecoes)
	*-- Produtos (filtros)
	this_cCprosi     = ""   && cprosi char(14) - produto inicial (SigCdPro.cpros)
	this_cCprosf     = ""   && cprosf char(14) - produto final (SigCdPro.cpros)
	*-- Subgrupos (filtros)
	this_cSgrusi     = ""   && sgrusi char(6) - subgrupo inicial (SigCdPsg.codigos)
	this_cSgrusf     = ""   && sgrusf char(6) - subgrupo final (SigCdPsg.codigos)
	*-- Unidades (filtros)
	this_cCfinpsi    = ""   && cfinpsi char(3) - unidade inicial (SigCdUni.cunis)
	this_cCfinpsf    = ""   && cfinpsf char(3) - unidade final (SigCdUni.cunis)
	*-- Memo/XML (filtros em grade)
	this_cMfilggrp   = ""   && mfilggrp text - XML marcacoes grandes grupos
	this_cMfilgrupo  = ""   && mfilgrupo text - XML marcacoes grupos produto
	this_cObs        = ""   && obs text - observacao geral

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDBAL"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Lista balancos de inventario da empresa atual
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " ORDER BY codigos, cidchaves"
			ELSE
				loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
				           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
				           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
				           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
				           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
				           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
				           " FROM SIGCDBAL" + ;
				           " WHERE emps = " + EscaparSQL(loc_cEmp) + ;
				           " AND codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos, cidchaves"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar invent" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um balanco pelo cidchaves (PK UUID)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(par_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorNumero - Carrega balanco pelo numero (codigos + emps)
	*====================================================================
	PROCEDURE CarregarPorNumero(par_nCodigos, par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, cidchaves, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, datatrans, encerras, tratas, agrupas," + ;
			           " sepestqs, trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars," + ;
			           " mfilggrp, mfilgrupo, obs" + ;
			           " FROM SIGCDBAL" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigos) + ;
			           " AND emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves    = TratarNulo(cidchaves,    "C")
			THIS.this_nCodigos      = TratarNulo(codigos,      "N")
			THIS.this_cEmps         = TratarNulo(emps,         "C")
			THIS.this_cGrupos       = TratarNulo(grupos,       "C")
			THIS.this_cContas       = TratarNulo(contas,       "C")
			THIS.this_dDtbases      = TratarNulo(dtbases,      "D")
			THIS.this_dDatainis     = TratarNulo(datainis,     "D")
			THIS.this_dDatafims     = TratarNulo(datafims,     "D")
			THIS.this_dDatatrans    = TratarNulo(datatrans,    "D")
			THIS.this_lEncerras     = (TratarNulo(encerras,    "N") = 1)
			THIS.this_lTratas       = (TratarNulo(tratas,      "N") = 1)
			THIS.this_nAgrupas      = TratarNulo(agrupas,      "N")
			THIS.this_nSepestqs     = TratarNulo(sepestqs,     "N")
			THIS.this_nTrtporpeso   = TratarNulo(trtporpeso,   "N")
			THIS.this_nLeitgructa   = TratarNulo(leitgructa,   "N")
			THIS.this_nFilbarras    = TratarNulo(filbarras,     "N")
			THIS.this_cLocalis      = TratarNulo(localis,      "C")
			THIS.this_cLocalfs      = TratarNulo(localfs,      "C")
			THIS.this_cIforis       = TratarNulo(iforis,       "C")
			THIS.this_cIforfs       = TratarNulo(iforfs,       "C")
			THIS.this_cCgruis       = TratarNulo(cgruis,       "C")
			THIS.this_cCgrufs       = TratarNulo(cgrufs,       "C")
			THIS.this_cCggruis      = TratarNulo(cggruis,      "C")
			THIS.this_cCggrufs      = TratarNulo(cggrufs,      "C")
			THIS.this_cColecoesi    = TratarNulo(colecoesi,    "C")
			THIS.this_cColecoesf    = TratarNulo(colecoesf,    "C")
			THIS.this_cCprosi       = TratarNulo(cprosi,       "C")
			THIS.this_cCprosf       = TratarNulo(cprosf,       "C")
			THIS.this_cSgrusi       = TratarNulo(sgrusi,       "C")
			THIS.this_cSgrusf       = TratarNulo(sgrusf,       "C")
			THIS.this_cCfinpsi      = TratarNulo(cfinpsi,      "C")
			THIS.this_cCfinpsf      = TratarNulo(cfinpsf,      "C")
			THIS.this_nPrecois      = TratarNulo(precois,      "N")
			THIS.this_nPrecofs      = TratarNulo(precofs,      "N")
			THIS.this_nNtrans       = TratarNulo(ntrans,       "N")
			THIS.this_cLocals       = TratarNulo(locals,       "C")
			THIS.this_cUsuars       = TratarNulo(usuars,       "C")
			*-- Campos TEXT/memo (podem nao estar no cursor de listagem)
			IF PEMSTATUS(EVAL(par_cAliasCursor), "mfilggrp", 5) OR ;
			   !EMPTY(FIELD("mfilggrp", par_cAliasCursor))
				THIS.this_cMfilggrp  = TratarNulo(mfilggrp,   "C")
				THIS.this_cMfilgrupo = TratarNulo(mfilgrupo,  "C")
				THIS.this_cObs       = TratarNulo(obs,        "C")
			ENDIF
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* GerarProximoCodigo - Obtem proximo codigo disponivel para a empresa
	*====================================================================
	PROTECTED PROCEDURE GerarProximoCodigo(par_cEmps)
		LOCAL loc_cSQL, loc_nResultado, loc_nCodigo
		loc_nCodigo = 0

		TRY
			loc_cSQL = "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox_cod" + ;
			           " FROM SIGCDBAL WHERE emps = " + EscaparSQL(par_cEmps)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCod")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ProxCod") > 0
				SELECT cursor_4c_ProxCod
				loc_nCodigo = cursor_4c_ProxCod.prox_cod
			ENDIF

			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao gerar c" + CHR(243) + "digo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ProxCod")
				USE IN cursor_4c_ProxCod
			ENDIF
		ENDTRY

		RETURN loc_nCodigo
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigo, loc_cEmp
		loc_lSucesso = .F.
		loc_cEmp     = ALLTRIM(go_4c_Sistema.cCodEmpresa)

		TRY
			*-- Gerar chave UUID e proximo codigo sequencial
			THIS.this_cCidchaves = ""
			loc_cSQL = "SELECT LEFT(NEWID(), 20) AS novo_uuid"
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Uuid")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Uuid") > 0
				SELECT cursor_4c_Uuid
				THIS.this_cCidchaves = ALLTRIM(cursor_4c_Uuid.novo_uuid)
			ENDIF
			IF USED("cursor_4c_Uuid")
				USE IN cursor_4c_Uuid
			ENDIF

			IF EMPTY(THIS.this_cCidchaves)
				MsgErro("Erro ao gerar chave " + CHR(250) + "nica.", "Erro")
				loc_lSucesso = .F.
			ENDIF

			loc_nCodigo = THIS.GerarProximoCodigo(loc_cEmp)
			IF loc_nCodigo = 0
				MsgErro("Erro ao gerar c" + CHR(243) + "digo do invent" + CHR(225) + "rio.", "Erro")
				loc_lSucesso = .F.
			ENDIF
			THIS.this_nCodigos = loc_nCodigo
			THIS.this_cEmps    = loc_cEmp
			THIS.this_cUsuars  = ALLTRIM(gc_4c_UsuarioLogado)

			loc_cSQL = "INSERT INTO SIGCDBAL (" + ;
			           " cidchaves, codigos, emps, grupos, contas, dtbases," + ;
			           " datainis, datafims, encerras, tratas, agrupas, sepestqs," + ;
			           " trtporpeso, leitgructa, filbarras, localis, localfs," + ;
			           " iforis, iforfs, cgruis, cgrufs, cggruis, cggrufs," + ;
			           " colecoesi, colecoesf, cprosi, cprosf, sgrusi, sgrusf," + ;
			           " cfinpsi, cfinpsf, precois, precofs, ntrans, locals, usuars" + ;
			           ") VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cEmps) + "," + ;
			           EscaparSQL(THIS.this_cGrupos) + "," + ;
			           EscaparSQL(THIS.this_cContas) + "," + ;
			           FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           EscaparSQL(THIS.this_cLocalis) + "," + ;
			           EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           EscaparSQL(THIS.this_cIforis) + "," + ;
			           EscaparSQL(THIS.this_cIforfs) + "," + ;
			           EscaparSQL(THIS.this_cCgruis) + "," + ;
			           EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           EscaparSQL(THIS.this_cCggruis) + "," + ;
			           EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           EscaparSQL(THIS.this_cCprosi) + "," + ;
			           EscaparSQL(THIS.this_cCprosf) + "," + ;
			           EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
			           EscaparSQL(THIS.this_cLocals) + "," + ;
			           EscaparSQL(THIS.this_cUsuars) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDBAL
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
			           " contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
			           " dtbases = " + FormatarDataSQL(THIS.this_dDtbases) + "," + ;
			           " datainis = " + FormatarDataSQL(THIS.this_dDatainis) + "," + ;
			           " datafims = " + FormatarDataSQL(THIS.this_dDatafims) + "," + ;
			           " encerras = " + IIF(THIS.this_lEncerras, "1", "0") + "," + ;
			           " tratas = " + IIF(THIS.this_lTratas, "1", "0") + "," + ;
			           " agrupas = " + FormatarNumeroSQL(THIS.this_nAgrupas) + "," + ;
			           " sepestqs = " + FormatarNumeroSQL(THIS.this_nSepestqs) + "," + ;
			           " trtporpeso = " + FormatarNumeroSQL(THIS.this_nTrtporpeso) + "," + ;
			           " leitgructa = " + FormatarNumeroSQL(THIS.this_nLeitgructa) + "," + ;
			           " filbarras = " + FormatarNumeroSQL(THIS.this_nFilbarras) + "," + ;
			           " localis = " + EscaparSQL(THIS.this_cLocalis) + "," + ;
			           " localfs = " + EscaparSQL(THIS.this_cLocalfs) + "," + ;
			           " iforis = " + EscaparSQL(THIS.this_cIforis) + "," + ;
			           " iforfs = " + EscaparSQL(THIS.this_cIforfs) + "," + ;
			           " cgruis = " + EscaparSQL(THIS.this_cCgruis) + "," + ;
			           " cgrufs = " + EscaparSQL(THIS.this_cCgrufs) + "," + ;
			           " cggruis = " + EscaparSQL(THIS.this_cCggruis) + "," + ;
			           " cggrufs = " + EscaparSQL(THIS.this_cCggrufs) + "," + ;
			           " colecoesi = " + EscaparSQL(THIS.this_cColecoesi) + "," + ;
			           " colecoesf = " + EscaparSQL(THIS.this_cColecoesf) + "," + ;
			           " cprosi = " + EscaparSQL(THIS.this_cCprosi) + "," + ;
			           " cprosf = " + EscaparSQL(THIS.this_cCprosf) + "," + ;
			           " sgrusi = " + EscaparSQL(THIS.this_cSgrusi) + "," + ;
			           " sgrusf = " + EscaparSQL(THIS.this_cSgrusf) + "," + ;
			           " cfinpsi = " + EscaparSQL(THIS.this_cCfinpsi) + "," + ;
			           " cfinpsf = " + EscaparSQL(THIS.this_cCfinpsf) + "," + ;
			           " precois = " + FormatarNumeroSQL(THIS.this_nPrecois) + "," + ;
			           " precofs = " + FormatarNumeroSQL(THIS.this_nPrecofs) + "," + ;
			           " locals = " + EscaparSQL(THIS.this_cLocals) + "," + ;
			           " usuars = " + EscaparSQL(THIS.this_cUsuars) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE do balanco e registros filhos
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nCodigos, loc_cEmps
		loc_lSucesso = .F.
		loc_nCodigos = THIS.this_nCodigos
		loc_cEmps    = ALLTRIM(THIS.this_cEmps)

		TRY
			*-- Remover registros filhos: SigIvTrB (balancos itens)
			loc_cSQL = "DELETE FROM SigIvTrB" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrH (historico de leitura)
			loc_cSQL = "DELETE FROM SigIvTrH" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover registros filhos: SigIvTrE (etiquetas)
			loc_cSQL = "DELETE FROM SigIvTrE" + ;
			           " WHERE emps = " + EscaparSQL(loc_cEmps) + ;
			           " AND codigos = " + FormatarNumeroSQL(loc_nCodigos)
			SQLEXEC(gnConnHandle, loc_cSQL)

			*-- Remover o balanco principal
			loc_cSQL = "DELETE FROM SIGCDBAL" + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarEncerramento - Marca/desmarca balanco como encerrado
	*====================================================================
	PROCEDURE AtualizarEncerramento(par_lEncerrar, par_dDatafim)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " encerras = " + IIF(par_lEncerrar, "1", "0") + "," + ;
			           " datafims = " + FormatarDataSQL(par_dDatafim) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_lEncerras  = par_lEncerrar
				THIS.this_dDatafims  = par_dDatafim
				THIS.RegistrarAuditoria("ENCERRAR")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao encerrar invent" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarTransporte - Marca balanco como transportado
	*====================================================================
	PROCEDURE AtualizarTransporte(par_dDataTrans)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " datatrans = " + FormatarDataSQL(par_dDataTrans) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_dDatatrans = par_dDataTrans
				THIS.RegistrarAuditoria("TRANSPORTE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao registrar transporte:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao registrar transporte:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* AtualizarFiltrosXML - Salva filtros de grade (mfilggrp, mfilgrupo)
	*====================================================================
	PROCEDURE AtualizarFiltrosXML(par_cMfilggrp, par_cMfilgrupo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDBAL SET" + ;
			           " mfilggrp = " + EscaparSQL(par_cMfilggrp) + "," + ;
			           " mfilgrupo = " + EscaparSQL(par_cMfilgrupo) + ;
			           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.this_cMfilggrp  = par_cMfilggrp
				THIS.this_cMfilgrupo = par_cMfilgrupo
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao salvar filtros XML:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao salvar filtros XML:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ValidarGrupoEstoque - Verifica se grupo de estoque eh valido
	*====================================================================
	PROCEDURE ValidarGrupoEstoque(par_cGrupos)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cGrupos))
				loc_lValido = .F.
			ENDIF

			loc_cSQL = "SELECT TOP 1 Codigos FROM SigCdGcr" + ;
			           " WHERE Codigos = " + EscaparSQL(ALLTRIM(par_cGrupos))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGru")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValGru") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValGru")
				USE IN cursor_4c_ValGru
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

	*====================================================================
	* ValidarConta - Verifica se conta de estoque eh valida
	*====================================================================
	PROCEDURE ValidarConta(par_cContas)
		LOCAL loc_cSQL, loc_nResultado, loc_lValido
		loc_lValido = .F.

		TRY
			IF EMPTY(ALLTRIM(par_cContas))
				loc_lValido = .T.
			ENDIF

			loc_cSQL = "SELECT TOP 1 IClis FROM SigCdCli" + ;
			           " WHERE IClis = " + EscaparSQL(ALLTRIM(par_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValCta")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_ValCta") > 0
				loc_lValido = .T.
			ENDIF

			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao validar conta:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_ValCta")
				USE IN cursor_4c_ValCta
			ENDIF
		ENDTRY

		RETURN loc_lValido
	ENDPROC

ENDDEFINE

