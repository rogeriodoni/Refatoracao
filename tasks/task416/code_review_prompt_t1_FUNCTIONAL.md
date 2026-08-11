# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (31)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_RESULTADO, CNT_4C_CONVERSAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [CONTAINER-TOGGLE] Container 'CNT_4C_CONVERSAO' eh flutuante (Visible=.F. toggled por botao) mas TornarControlesVisiveis NAO o filtra. Adicionar verificacao INLIST/IF para pular este container no loop.
- [METODO-INEXISTENTE] Metodo 'THIS.ProcessarBalanco()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ImprimirBalanco()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oPagina.txt_4c_Data.Value define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPagina.txt_4c_Data.Value.RecordSource).
- [GRID-HEADER] Header Caption 'Cód.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Encerramento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Início' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo Op.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Lista.Cnt_periodo): Top original=32 vs migrado 'lbl_4c_Label15' Top=288 (diff=256px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Lista.Cnt_periodo): Left original=22 vs migrado 'lbl_4c_Label15' Left=474 (diff=452px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Dados.Resultado.Cnt_Conversao): Top original=3 vs migrado 'lbl_4c_Label15' Top=288 (diff=285px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Dados.Resultado.Cnt_Conversao): Left original=13 vs migrado 'lbl_4c_Label15' Left=474 (diff=461px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Pesagem' (parent: SIGCDFEA.Pagina.Dados.Resultado): Top original=294 vs migrado 'Get_Pesagem' Top=167 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Pesagem' (parent: SIGCDFEA.Pagina.Dados.Resultado): Left original=892 vs migrado 'Get_Pesagem' Left=307 (diff=585px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Dados.Resultado): Top original=49 vs migrado 'lbl_4c_Label15' Top=288 (diff=239px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Dados.Resultado): Left original=205 vs migrado 'lbl_4c_Label15' Left=474 (diff=269px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Get_Saldof' (parent: SIGCDFEA.Pagina.Dados.Resultado): Top original=235 vs migrado 'Get_Saldo' Top=75 (diff=160px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_ordem' (parent: SIGCDFEA.Pagina.Dados.Resultado): Top original=318 vs migrado 'op_ordem' Top=2 (diff=316px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'op_ordem' (parent: SIGCDFEA.Pagina.Dados.Resultado): Left original=801 vs migrado 'op_ordem' Left=2 (diff=799px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDFEA.Pagina.Dados): Top original=78 vs migrado 'lbl_4c_Label2' Top=262 (diff=184px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDFEA.Pagina.Dados): Left original=34 vs migrado 'lbl_4c_Label2' Left=227 (diff=193px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDFEA.Pagina.Dados): Top original=24 vs migrado 'lbl_4c_Label3' Top=352 (diff=328px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDFEA.Pagina.Dados): Left original=158 vs migrado 'lbl_4c_Label3' Left=652 (diff=494px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label5' (parent: SIGCDFEA.Pagina.Dados): Left original=504 vs migrado 'lbl_4c_Label5' Left=235 (diff=269px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label4' (parent: SIGCDFEA.Pagina.Dados): Left original=30 vs migrado 'lbl_4c_Label4' Left=157 (diff=127px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Dados): Top original=51 vs migrado 'lbl_4c_Label15' Top=288 (diff=237px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDFEA.Pagina.Dados): Left original=34 vs migrado 'lbl_4c_Label15' Left=474 (diff=440px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Get_Data' (parent: SIGCDFEA.Pagina.Dados): Left original=198 vs migrado 'Get_Datai' Left=79 (diff=119px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFea.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5369 linhas total):

*-- Linhas 47 a 187:
47:     this_cPEmps     = ""    && empresa ativa para filtro de balanco
48: 
49:     *==========================================================================
50:     * Init - Apenas delega ao FormBase (que chama InicializarForm automaticamente)
51:     *==========================================================================
52:     PROCEDURE Init()
53:         LOCAL loc_lResultado
54:         loc_lResultado = .F.
55: 
56:         TRY
57:             loc_lResultado = DODEFAULT()
58:         CATCH TO loc_oErro
59:             MsgErro(loc_oErro.Message, "FormFea.Init")
60:         ENDTRY
61: 
62:         RETURN loc_lResultado
63:     ENDPROC
64: 
65:     *==========================================================================
66:     * InicializarForm - Configura estrutura completa do formulario
67:     * Chamado automaticamente pelo FormBase.Init()
68:     *==========================================================================
69:     PROTECTED PROCEDURE InicializarForm()
70:         LOCAL loc_lResultado
71:         loc_lResultado = .F.
72: 
73:         TRY
74:             *-- Criar Business Object
75:             THIS.this_oBusinessObject = CREATEOBJECT("FeaBO")
76: 
77:             IF VARTYPE(THIS.this_oBusinessObject) <> "O"
78:                 MsgErro("Erro ao criar FeaBO." + CHR(13) + ;
79:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
80:             ELSE
81:                 THIS.Caption = "Balan" + CHR(231) + "o"
82: 
83:                 THIS.this_cPEmps    = ALLTRIM(go_4c_Sistema.cCodEmpresa)
84:                 THIS.this_cAntEmpr  = THIS.this_cPEmps
85: 
86:                 THIS.ConfigurarPageFrame()
87:                 THIS.ConfigurarPaginaLista()
88:                 THIS.ConfigurarPaginaDados()
89: 
90:                 THIS.pgf_4c_Paginas.Visible = .T.
91:                 THIS.pgf_4c_Paginas.ActivePage = 1
92:                 THIS.this_cModoAtual           = "LISTA"
93: 
94:                 THIS.CarregarLista()
95: 
96:                 loc_lResultado = .T.
97:             ENDIF
98:         CATCH TO loc_oErro
99:             MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message, "Erro")
100:         ENDTRY
101: 
102:         RETURN loc_lResultado
103:     ENDPROC
104: 
105:     *==========================================================================
106:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
107:     * PageFrame.Top = -29 para ocultar abas (padrao frmcadastro)
108:     *==========================================================================
109:     PROTECTED PROCEDURE ConfigurarPageFrame()
110:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
111: 
112:         WITH THIS.pgf_4c_Paginas
113:             .PageCount = 2
114:             .Top       = -29
115:             .Left      = 0
116:             .Width     = THIS.Width
117:             .Height    = THIS.Height + 29
118:             .Tabs      = .F.
119:             .Visible   = .T.
120: 
121:             .Page1.Caption   = "Lista"
122:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
123:             .Page1.BackColor = RGB(255, 255, 255)
124: 
125:             .Page2.Caption   = "Dados"
126:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
127:             .Page2.BackColor = RGB(255, 255, 255)
128:         ENDWITH
129:     ENDPROC
130: 
131:     *==========================================================================
132:     * ConfigurarPaginaLista - Configura Page1 (filtros + grade de balanco)
133:     * FASE 4: cabecalho, botoes CRUD, filtro periodo, grade completa
134:     *==========================================================================
135:     PROTECTED PROCEDURE ConfigurarPaginaLista()
136:         LOCAL loc_oPagina
137:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
138: 
139:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
140:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
141: 
142:         *-- Container cabecalho escuro (cntSombra no legado)
143:         *-- Top=31 = 2 (original) + 29 (compensacao PageFrame.Top=-29)
144:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
145:         WITH loc_oPagina.cnt_4c_Cabecalho
146:             .Top         = 31
147:             .Left        = 0
148:             .Width       = THIS.Width
149:             .Height      = 80
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152:             .Visible     = .T.
153:         ENDWITH
154: 
155:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
156:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
157:             .Caption   = "Balan" + CHR(231) + "o"
158:             .Top       = 20
159:             .Left      = 12
160:             .Width     = THIS.Width
161:             .Height    = 40
162:             .FontName  = "Tahoma"
163:             .FontSize  = 16
164:             .FontBold  = .T.
165:             .ForeColor = RGB(0, 0, 0)
166:             .BackStyle = 0
167:             .AutoSize  = .F.
168:             .Visible   = .T.
169:         ENDWITH
170: 
171:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
172:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
173:             .Caption   = "Balan" + CHR(231) + "o"
174:             .Top       = 18
175:             .Left      = 10
176:             .Width     = THIS.Width
177:             .Height    = 46
178:             .FontName  = "Tahoma"
179:             .FontSize  = 16
180:             .FontBold  = .T.
181:             .ForeColor = RGB(255, 255, 255)
182:             .BackStyle = 0
183:             .AutoSize  = .F.
184:             .Visible   = .T.
185:         ENDWITH
186: 
187:         *-- Container botoes de operacao (Grupo_Op no legado)

*-- Linhas 220 a 399:
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
224: 
225:         *-- Botao Visualizar (Left=80)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
228:             .Caption         = "Visualizar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 80
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Tahoma"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.
238:             .FontSize        = 8
239:             .ForeColor       = RGB(90, 90, 90)
240:             .BackColor       = RGB(255, 255, 255)
241:             .Themes          = .F.
242:             .SpecialEffect   = 0
243:             .MousePointer    = 15
244:             .WordWrap        = .T.
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
249: 
250:         *-- Botao Alterar (Left=155)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
253:             .Caption         = "Alterar"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 155
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Tahoma"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .FontSize        = 8
264:             .ForeColor       = RGB(90, 90, 90)
265:             .BackColor       = RGB(255, 255, 255)
266:             .Themes          = .F.
267:             .SpecialEffect   = 0
268:             .MousePointer    = 15
269:             .WordWrap        = .T.
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
274: 
275:         *-- Botao Excluir (Left=230)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
278:             .Caption         = "Excluir"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 230
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Tahoma"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.
288:             .FontSize        = 8
289:             .ForeColor       = RGB(90, 90, 90)
290:             .BackColor       = RGB(255, 255, 255)
291:             .Themes          = .F.
292:             .SpecialEffect   = 0
293:             .MousePointer    = 15
294:             .WordWrap        = .T.
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
299: 
300:         *-- Botao Buscar (Left=305)
301:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
302:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
303:             .Caption         = "Buscar"
304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
305:             .PicturePosition = 13
306:             .Top             = 5
307:             .Left            = 305
308:             .Width           = 75
309:             .Height          = 75
310:             .FontName        = "Tahoma"
311:             .FontBold        = .T.
312:             .FontItalic      = .T.
313:             .FontSize        = 8
314:             .ForeColor       = RGB(90, 90, 90)
315:             .BackColor       = RGB(255, 255, 255)
316:             .Themes          = .F.
317:             .SpecialEffect   = 0
318:             .MousePointer    = 15
319:             .WordWrap        = .T.
320:             .AutoSize        = .F.
321:             .Visible         = .T.
322:         ENDWITH
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
324: 
325:         *-- Container saida/encerrar - padrao canonico (CLAUDE.md regra #10)
326:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
327:         WITH loc_oPagina.cnt_4c_Saida
328:             .Top         = 29
329:             .Left        = 917
330:             .Width       = 90
331:             .Height      = 85
332:             .BackStyle   = 0
333:             .BorderWidth = 0
334:             .Visible     = .T.
335:         ENDWITH
336: 
337:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
338:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
339:             .Caption         = "Encerrar"
340:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
341:             .PicturePosition = 13
342:             .Top             = 5
343:             .Left            = 5
344:             .Width           = 75
345:             .Height          = 75
346:             .FontName        = "Tahoma"
347:             .FontBold        = .T.
348:             .FontItalic      = .T.
349:             .FontSize        = 8
350:             .ForeColor       = RGB(90, 90, 90)
351:             .BackColor       = RGB(255, 255, 255)
352:             .Themes          = .F.
353:             .SpecialEffect   = 0
354:             .MousePointer    = 15
355:             .WordWrap        = .T.
356:             .AutoSize        = .F.
357:             .Visible         = .T.
358:         ENDWITH
359:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
360: 
361:         *-- Container filtro de periodo (Cnt_periodo no legado)
362:         *-- Top=113 = 84 (original) + 29 (compensacao)
363:         loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
364:         WITH loc_oPagina.cnt_4c_Periodo
365:             .Top         = 113
366:             .Left        = 21
367:             .Width       = 332
368:             .Height      = 59
369:             .BackColor   = RGB(255, 255, 255)
370:             .BackStyle   = 0
371:             .Visible     = .T.
372:         ENDWITH
373: 
374:         *-- Label Empresa (Say4 no legado: top=7, left=16)
375:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
376:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
377:             .Caption   = "Empresa : "
378:             .Top       = 7
379:             .Left      = 16
380:             .Width     = 63
381:             .Height    = 17
382:             .FontName  = "Tahoma"
383:             .FontSize  = 8
384:             .FontBold  = .F.
385:             .ForeColor = RGB(0, 0, 0)
386:             .BackStyle = 0
387:             .AutoSize  = .F.
388:             .Visible   = .T.
389:         ENDWITH
390: 
391:         *-- TextBox Empresa (Get_cd_empresa no legado: top=4, left=79, width=35)
392:         *-- MaxLength=3 obrigatorio (CLAUDE.md: SigCdEmp char(3))
393:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Empresa", "TextBox")
394:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa
395:             .Value         = THIS.this_cPEmps
396:             .Top           = 4
397:             .Left          = 79
398:             .Width         = 35
399:             .Height        = 23

*-- Linhas 406 a 649:
406:             .SpecialEffect = 0
407:             .Visible       = .T.
408:         ENDWITH
409:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa, "KeyPress", THIS, "EmpresaLostFocus")
410: 
411:         *-- Label Periodo (Label1 no legado: top=32, left=22)
412:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
413:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
414:             .Caption   = "Per" + CHR(237) + "odo : "
415:             .Top       = 32
416:             .Left      = 22
417:             .Width     = 57
418:             .Height    = 17
419:             .FontName  = "Tahoma"
420:             .FontSize  = 8
421:             .FontBold  = .F.
422:             .ForeColor = RGB(0, 0, 0)
423:             .BackStyle = 0
424:             .AutoSize  = .F.
425:             .Visible   = .T.
426:         ENDWITH
427: 
428:         *-- TextBox Data Inicial (Dt_inicial no legado: top=29, left=79, width=80)
429:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
430:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial
431:             .Value         = DATE()
432:             .Top           = 29
433:             .Left          = 79
434:             .Width         = 80
435:             .Height        = 23
436:             .Format        = "D"
437:             .FontName      = "Tahoma"
438:             .FontSize      = 8
439:             .BackColor     = RGB(255, 255, 255)
440:             .ForeColor     = RGB(0, 0, 0)
441:             .BorderStyle   = 1
442:             .SpecialEffect = 0
443:             .Visible       = .T.
444:         ENDWITH
445:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
446: 
447:         *-- Label separador entre datas (Say2 no legado: top=32, left=164, caption=CHR(224))
448:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Sep", "Label")
449:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Sep
450:             .Caption   = CHR(224)
451:             .Top       = 32
452:             .Left      = 164
453:             .Width     = 12
454:             .Height    = 17
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .FontBold  = .F.
458:             .ForeColor = RGB(0, 0, 0)
459:             .BackStyle = 0
460:             .AutoSize  = .F.
461:             .Visible   = .T.
462:         ENDWITH
463: 
464:         *-- TextBox Data Final (Dt_final no legado: top=29, left=177, width=80)
465:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
466:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal
467:             .Value         = DATE()
468:             .Top           = 29
469:             .Left          = 177
470:             .Width         = 80
471:             .Height        = 23
472:             .Format        = "D"
473:             .FontName      = "Tahoma"
474:             .FontSize      = 8
475:             .BackColor     = RGB(255, 255, 255)
476:             .ForeColor     = RGB(0, 0, 0)
477:             .BorderStyle   = 1
478:             .SpecialEffect = 0
479:             .Visible       = .T.
480:         ENDWITH
481:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
482: 
483:         *-- Botao Posicao Balanco (btnPosicao no legado: top=4+29=33, left=474)
484:         loc_oPagina.AddObject("cmd_4c_PosicaoBal", "CommandButton")
485:         WITH loc_oPagina.cmd_4c_PosicaoBal
486:             .Caption       = "Posi" + CHR(231) + CHR(227) + "o \<Bal."
487:             .Top           = 33
488:             .Left          = 474
489:             .Width         = 64
490:             .Height        = 55
491:             .FontName      = "Tahoma"
492:             .FontSize      = 8
493:             .FontBold      = .F.
494:             .ForeColor     = RGB(0, 0, 0)
495:             .BackColor     = RGB(224, 224, 224)
496:             .Themes        = .F.
497:             .SpecialEffect = 1
498:             .MousePointer  = 15
499:             .WordWrap      = .T.
500:             .AutoSize      = .F.
501:             .Visible       = .T.
502:         ENDWITH
503:         BINDEVENT(loc_oPagina.cmd_4c_PosicaoBal, "Click", THIS, "BtnPosicaoBalClick")
504: 
505:         *-- Grade de balanco (Grade no legado, Page1)
506:         *-- ColumnCount FORA do WITH (Problema 36: dentro nao cria colunas imediatamente)
507:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
508:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
509:         WITH loc_oPagina.grd_4c_Lista
510:             .Top                = 175
511:             .Left               = 21
512:             .Width              = 884
513:             .Height             = 540
514:             .FontName           = "Tahoma"
515:             .FontSize           = 8
516:             .ForeColor          = RGB(90, 90, 90)
517:             .BackColor          = RGB(255, 255, 255)
518:             .GridLineColor      = RGB(238, 238, 238)
519:             .HighlightBackColor = RGB(255, 255, 255)
520:             .HighlightForeColor = RGB(15, 41, 104)
521:             .HighlightStyle     = 2
522:             .DeleteMark         = .F.
523:             .RecordMark         = .F.
524:             .RowHeight          = 16
525:             .ScrollBars         = 2
526:             .GridLines          = 3
527:             .Visible            = .T.
528:         ENDWITH
529:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
530:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")
531: 
532:         THIS.TornarControlesVisiveis(loc_oPagina)
533:     ENDPROC
534: 
535:     *==========================================================================
536:     * ConfigurarPaginaDados - Configura Page2 (edicao + resultado de balanco)
537:     * FASE 5: container BotoesAcao + botoes Confirmar/Cancelar + Shape +
538:     *         Label/TextBox Codigo + Label/TextBox Data + cmd Processar
539:     *==========================================================================
540:     PROTECTED PROCEDURE ConfigurarPaginaDados()
541:         LOCAL loc_oPagina
542:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
543: 
544:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
545:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
546: 
547:         *-- Container botoes acao - Confirmar + Cancelar (Grupo_Salva no legado)
548:         *-- Top=46 = 17 (original) + 29 (compensacao)
549:         *-- Width=90 inicial (Cancelar oculto); 173 quando modo INSERIR com Fechamento
550:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
551:         WITH loc_oPagina.cnt_4c_BotoesAcao
552:             .Top         = 46
553:             .Left        = 817
554:             .Width       = 90
555:             .Height      = 85
556:             .BackStyle   = 0
557:             .Visible     = .T.
558:         ENDWITH
559: 
560:         *-- Botao Confirmar (Salva no legado: left=5, top=5, w=75, h=75)
561:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
562:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
563:             .Caption         = "Confirmar"
564:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
565:             .PicturePosition = 13
566:             .Top             = 5
567:             .Left            = 5
568:             .Width           = 75
569:             .Height          = 75
570:             .FontName        = "Tahoma"
571:             .FontBold        = .T.
572:             .FontItalic      = .T.
573:             .FontSize        = 8
574:             .ForeColor       = RGB(90, 90, 90)
575:             .BackColor       = RGB(255, 255, 255)
576:             .Themes          = .F.
577:             .SpecialEffect   = 0
578:             .MousePointer    = 15
579:             .WordWrap        = .T.
580:             .AutoSize        = .F.
581:             .Enabled         = .F.
582:             .Visible         = .T.
583:         ENDWITH
584:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
585: 
586:         *-- Botao Cancelar (Cancelar no legado: left=80, top=5; inicia oculto)
587:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
588:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
589:             .Caption         = "Encerrar"
590:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
591:             .PicturePosition = 13
592:             .Top             = 5
593:             .Left            = 80
594:             .Width           = 75
595:             .Height          = 75
596:             .FontName        = "Tahoma"
597:             .FontBold        = .T.
598:             .FontItalic      = .T.
599:             .FontSize        = 8
600:             .ForeColor       = RGB(90, 90, 90)
601:             .BackColor       = RGB(255, 255, 255)
602:             .Themes          = .F.
603:             .SpecialEffect   = 0
604:             .MousePointer    = 15
605:             .WordWrap        = .T.
606:             .AutoSize        = .F.
607:             .Visible         = .F.
608:         ENDWITH
609:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
610: 
611:         *-- Shape de borda ao redor dos campos de entrada (Shape1 no legado)
612:         *-- Top=36 = 7 (original) + 29 (compensacao)
613:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
614:         WITH loc_oPagina.shp_4c_Shape1
615:             .Top         = 36
616:             .Left        = 9
617:             .Width       = 662
618:             .Height      = 110
619:             .BorderColor = RGB(90, 90, 90)
620:             .BackStyle   = 0
621:             .Visible     = .T.
622:         ENDWITH
623: 
624:         *-- Label Codigo (Label4 no legado: top=24+29=53, left=30, w=42)
625:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
626:         WITH loc_oPagina.lbl_4c_Label4
627:             .Caption   = "C" + CHR(243) + "digo :"
628:             .Top       = 53
629:             .Left      = 30
630:             .Width     = 42
631:             .Height    = 15
632:             .FontName  = "Tahoma"
633:             .FontSize  = 8
634:             .FontBold  = .F.
635:             .ForeColor = RGB(90, 90, 90)
636:             .BackStyle = 0
637:             .AutoSize  = .F.
638:             .Visible   = .T.
639:         ENDWITH
640: 
641:         *-- TextBox Codigo (Get_Codigo no legado: top=19+29=48, left=75, w=54)
642:         *-- ReadOnly=.T. por padrao; edita em modo PROCURAR via HabilitarCampos
643:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
644:         WITH loc_oPagina.txt_4c_Codigo
645:             .Value         = 0
646:             .Top           = 48
647:             .Left          = 75
648:             .Width         = 54
649:             .Height        = 25

*-- Linhas 675 a 855:
675:             .Visible   = .T.
676:         ENDWITH
677: 
678:         *-- TextBox Data (Get_Data no legado: top=19+29=48, left=198, w=80)
679:         *-- Format="K" limpa ao digitar; FontName="Courier New" FontSize=9 (legado)
680:         loc_oPagina.AddObject("txt_4c_Data", "TextBox")
681:         WITH loc_oPagina.txt_4c_Data
682:             .Value         = {}
683:             .Top           = 48
684:             .Left          = 198
685:             .Width         = 80
686:             .Height        = 25
687:             .Format        = "K"
688:             .FontName      = "Courier New"
689:             .FontSize      = 9
690:             .BackColor     = RGB(255, 255, 255)
691:             .ForeColor     = RGB(0, 0, 0)
692:             .BorderStyle   = 1
693:             .SpecialEffect = 0
694:             .Visible       = .T.
695:         ENDWITH
696:         BINDEVENT(loc_oPagina.txt_4c_Data, "InteractiveChange", THIS, "DadosInteractiveChange")
697:         BINDEVENT(loc_oPagina.txt_4c_Data, "KeyPress", THIS, "DataLostFocus")
698: 
699:         *-- Label Grupo (Label1 no legado: top=51+29=80, left=34, w=38)
700:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
701:         WITH loc_oPagina.lbl_4c_Label1
702:             .Caption   = "Grupo :"
703:             .Top       = 80
704:             .Left      = 34
705:             .Width     = 38
706:             .Height    = 15
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .FontBold  = .F.
710:             .ForeColor = RGB(90, 90, 90)
711:             .BackStyle = 0
712:             .AutoSize  = .F.
713:             .Visible   = .T.
714:         ENDWITH
715: 
716:         *-- TextBox Codigo do Grupo (Get_Grupo no legado: top=46+29=75, left=75, w=80)
717:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
718:         WITH loc_oPagina.txt_4c_Grupo
719:             .Value         = ""
720:             .Top           = 75
721:             .Left          = 75
722:             .Width         = 80
723:             .Height        = 25
724:             .MaxLength     = 10
725:             .FontName      = "Tahoma"
726:             .FontSize      = 8
727:             .BackColor     = RGB(255, 255, 255)
728:             .ForeColor     = RGB(0, 0, 0)
729:             .BorderStyle   = 1
730:             .SpecialEffect = 0
731:             .Visible       = .T.
732:         ENDWITH
733:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
734:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
735:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "InteractiveChange", THIS, "DadosInteractiveChange")
736: 
737:         *-- TextBox Descricao Grupo (Get_DGrupo no legado: top=46+29=75, left=157, w=290)
738:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
739:         WITH loc_oPagina.txt_4c_DGrupo
740:             .Value         = ""
741:             .Top           = 75
742:             .Left          = 157
743:             .Width         = 290
744:             .Height        = 25
745:             .MaxLength     = 40
746:             .FontName      = "Tahoma"
747:             .FontSize      = 8
748:             .BackColor     = RGB(255, 255, 255)
749:             .ForeColor     = RGB(0, 0, 0)
750:             .BorderStyle   = 1
751:             .SpecialEffect = 0
752:             .Visible       = .T.
753:         ENDWITH
754:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "KeyPress", THIS, "DGrupoKeyPress")
755:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "DblClick", THIS, "DGrupoDblClick")
756:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "InteractiveChange", THIS, "DadosInteractiveChange")
757: 
758:         *-- Label Conta (Label2 no legado: top=78+29=107, left=34, w=38)
759:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
760:         WITH loc_oPagina.lbl_4c_Label2
761:             .Caption   = "Conta :"
762:             .Top       = 107
763:             .Left      = 34
764:             .Width     = 38
765:             .Height    = 15
766:             .FontName  = "Tahoma"
767:             .FontSize  = 8
768:             .FontBold  = .F.
769:             .ForeColor = RGB(90, 90, 90)
770:             .BackStyle = 0
771:             .AutoSize  = .F.
772:             .Visible   = .T.
773:         ENDWITH
774: 
775:         *-- TextBox Codigo da Conta (Get_Conta no legado: top=73+29=102, left=75, w=80)
776:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
777:         WITH loc_oPagina.txt_4c_Conta
778:             .Value         = ""
779:             .Top           = 102
780:             .Left          = 75
781:             .Width         = 80
782:             .Height        = 25
783:             .MaxLength     = 10
784:             .FontName      = "Tahoma"
785:             .FontSize      = 8
786:             .BackColor     = RGB(255, 255, 255)
787:             .ForeColor     = RGB(0, 0, 0)
788:             .BorderStyle   = 1
789:             .SpecialEffect = 0
790:             .Visible       = .T.
791:         ENDWITH
792:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")
793:         BINDEVENT(loc_oPagina.txt_4c_Conta, "DblClick", THIS, "ContaDblClick")
794:         BINDEVENT(loc_oPagina.txt_4c_Conta, "InteractiveChange", THIS, "DadosInteractiveChange")
795: 
796:         *-- TextBox Descricao Conta (Get_DConta no legado: top=73+29=102, left=157, w=290)
797:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
798:         WITH loc_oPagina.txt_4c_DConta
799:             .Value         = ""
800:             .Top           = 102
801:             .Left          = 157
802:             .Width         = 290
803:             .Height        = 25
804:             .MaxLength     = 80
805:             .FontName      = "Tahoma"
806:             .FontSize      = 8
807:             .BackColor     = RGB(255, 255, 255)
808:             .ForeColor     = RGB(0, 0, 0)
809:             .BorderStyle   = 1
810:             .SpecialEffect = 0
811:             .Visible       = .T.
812:         ENDWITH
813:         BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "DContaKeyPress")
814:         BINDEVENT(loc_oPagina.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
815:         BINDEVENT(loc_oPagina.txt_4c_DConta, "InteractiveChange", THIS, "DadosInteractiveChange")
816: 
817:         *-- Label Lote (Label5 no legado: top=51+29=80, left=504, w=30)
818:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
819:         WITH loc_oPagina.lbl_4c_Label5
820:             .Caption   = "Lote :"
821:             .Top       = 80
822:             .Left      = 504
823:             .Width     = 30
824:             .Height    = 15
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .FontBold  = .F.
828:             .ForeColor = RGB(90, 90, 90)
829:             .BackStyle = 0
830:             .AutoSize  = .F.
831:             .Visible   = .T.
832:         ENDWITH
833: 
834:         *-- TextBox Lote (getlote no legado: top=46+29=75, left=543, w=54)
835:         *-- Editavel somente quando !Fechamento (posicao sem balanco)
836:         loc_oPagina.AddObject("txt_4c_Lote", "TextBox")
837:         WITH loc_oPagina.txt_4c_Lote
838:             .Value         = 0
839:             .Top           = 75
840:             .Left          = 543
841:             .Width         = 54
842:             .Height        = 25
843:             .InputMask     = "999999"
844:             .FontName      = "Tahoma"
845:             .FontSize      = 8
846:             .BackColor     = RGB(255, 255, 255)
847:             .ForeColor     = RGB(0, 0, 0)
848:             .BorderStyle   = 1
849:             .SpecialEffect = 0
850:             .ReadOnly      = .T.
851:             .Visible       = .T.
852:         ENDWITH
853: 
854:         *-- Botao Processar (Processar no legado: top=22+29=51, left=747, w=75, h=75)
855:         *-- FontName="Comic Sans MS" FontBold=.T. do legado

*-- Linhas 875 a 1014:
875:             .AutoSize        = .F.
876:             .Visible         = .T.
877:         ENDWITH
878:         BINDEVENT(loc_oPagina.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
879: 
880:         *-- Container resultado (Resultado no legado)
881:         *-- INICIA OCULTO - torna-se visivel apos BtnProcessarClick executar
882:         *-- Top=152 = 123 (original) + 29 (compensacao)
883:         loc_oPagina.AddObject("cnt_4c_Resultado", "Container")
884:         WITH loc_oPagina.cnt_4c_Resultado
885:             .Top         = 152
886:             .Left        = 10
887:             .Width       = 980
888:             .Height      = 460
889:             .BackColor   = RGB(255, 255, 255)
890:             .BackStyle   = 1
891:             .Visible     = .F.
892:         ENDWITH
893: 
894:         THIS.ConfigurarResultado(loc_oPagina.cnt_4c_Resultado)
895: 
896:         *-- Bind Page2.Activate -> AjustarBotoesPorModo (Pagina.Dados.Activate no legado)
897:         BINDEVENT(loc_oPagina, "Activate", THIS, "AjustarBotoesPorModo")
898: 
899:         THIS.TornarControlesVisiveis(loc_oPagina)
900:     ENDPROC
901: 
902:     *==========================================================================
903:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
904:     * Preserva containers que devem iniciar ocultos (cnt_4c_Resultado)
905:     *==========================================================================
906:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
907:         LOCAL loc_i, loc_nP, loc_oObjeto, loc_cNome
908: 
909:         FOR loc_i = 1 TO par_oContainer.ControlCount
910:             loc_oObjeto = par_oContainer.Controls(loc_i)
911: 
912:             IF VARTYPE(loc_oObjeto) = "O"
913:                 loc_cNome = UPPER(loc_oObjeto.Name)
914: 
915:                 IF INLIST(loc_cNome, "CNT_4C_RESULTADO")
916:                     THIS.TornarControlesVisiveis(loc_oObjeto)
917:                     LOOP
918:                 ENDIF
919: 
920:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
921:                     loc_oObjeto.Visible = .T.
922:                 ENDIF
923: 
924:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
925:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
926:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
927:                     ENDFOR
928:                 ENDIF
929: 
930:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
931:                     THIS.TornarControlesVisiveis(loc_oObjeto)
932:                 ENDIF
933:             ENDIF
934:         ENDFOR
935:     ENDPROC
936: 
937:     *==========================================================================
938:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados/formulario)
939:     *==========================================================================
940:     PROCEDURE AlternarPagina(par_nPagina)
941:         LOCAL loc_lResultado
942:         loc_lResultado = .F.
943: 
944:         TRY
945:             IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
946:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
947:             ELSE
948:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
949: 
950:                 IF par_nPagina = 1
951:                     THIS.this_cModoAtual = "LISTA"
952:                     THIS.pgf_4c_Paginas.Page1.Enabled = .T.
953:                     THIS.CarregarLista()
954:                 ELSE
955:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
956:                 ENDIF
957: 
958:                 loc_lResultado = .T.
959:             ENDIF
960: 
961:         CATCH TO loc_oErro
962:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, ;
963:                 "FormFea.AlternarPagina")
964:         ENDTRY
965: 
966:         RETURN loc_lResultado
967:     ENDPROC
968: 
969:     *==========================================================================
970:     * CarregarLista - Carrega/recarrega grid da Page1 com dados do periodo filtrado
971:     * OBRIGATORIO: rebind ControlSource + Headers APOS RecordSource (Problema 2/48)
972:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
973:     *==========================================================================
974:     PROCEDURE CarregarLista()
975:         LOCAL loc_lResultado, loc_oGrid, loc_cEmp, loc_dDtI, loc_dDtF
976:         loc_lResultado = .F.
977: 
978:         TRY
979:             loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)
980:             loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
981:             loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
982: 
983:             THIS.this_oBusinessObject.PreencherFiltro(loc_cEmp, loc_dDtI, loc_dDtF)
984: 
985:             IF THIS.this_oBusinessObject.Buscar("")
986:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
987: 
988:                 loc_oGrid.ColumnCount  = 5
989:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
990: 
991:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
992:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
993:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
994:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
995:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.datais"
996: 
997:                 loc_oGrid.Column1.Width = 70
998:                 loc_oGrid.Column2.Width = 120
999:                 loc_oGrid.Column3.Width = 120
1000:                 loc_oGrid.Column4.Width = 200
1001:                 loc_oGrid.Column5.Width = 200
1002: 
1003:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d."
1004:                 loc_oGrid.Column2.Header1.Caption = "Grupo"
1005:                 loc_oGrid.Column3.Header1.Caption = "Conta"
1006:                 loc_oGrid.Column4.Header1.Caption = "Data Encerramento"
1007:                 loc_oGrid.Column5.Header1.Caption = "Data In" + CHR(237) + "cio"
1008: 
1009:                 THIS.FormatarGridLista(loc_oGrid)
1010: 
1011:                 THIS.this_cAntEmpr  = loc_cEmp
1012:                 THIS.this_dAntDtIni = loc_dDtI
1013:                 THIS.this_dAntDtFin = loc_dDtF
1014: 

*-- Linhas 1028 a 1296:
1028:     *==========================================================================
1029:     * FormatarGridLista - Aplica formatacao visual ao grid de lista
1030:     *==========================================================================
1031:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1032:         TRY
1033:             WITH par_oGrid
1034:                 .FontName = "Tahoma"
1035:                 .FontSize = 8
1036:             ENDWITH
1037:         CATCH TO loc_oErro
1038:             MsgErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, ;
1039:                 "FormFea.FormatarGridLista")
1040:         ENDTRY
1041:     ENDPROC
1042: 
1043:     *==========================================================================
1044:     * GradeAfterRowColChange - Rastreia mudanca de linha no grid
1045:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1046:     * AfterRowColChange requer LPARAMETERS par_nColIndex (CLAUDE.md regra #3)
1047:     *==========================================================================
1048:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1049:         LOCAL loc_lTemRegistro
1050:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1051: 
1052:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1053:             .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1054:             .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1055:             .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1056:             .Visible     = .T.
1057:         ENDWITH
1058:     ENDPROC
1059: 
1060:     *==========================================================================
1061:     * BtnIncluirClick - Abre Page2 para incluir novo balanco
1062:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1063:     *==========================================================================
1064:     PROCEDURE BtnIncluirClick()
1065:         THIS.this_cPcEscolha  = "INSERIR"
1066:         THIS.this_lFechamento = .T.
1067:         THIS.this_oBusinessObject.NovoRegistro()
1068:         THIS.this_cModoAtual  = "INCLUIR"
1069:         THIS.AlternarPagina(2)
1070:         THIS.AjustarBotoesPorModo()
1071:         THIS.HabilitarCampos()
1072:         *-- Inicializa Data apos AjustarBotoesPorModo (evita sobrescrita por BOParaForm)
1073:         THIS.pgf_4c_Paginas.Page2.txt_4c_Data.Value = DATE()
1074:     ENDPROC
1075: 
1076:     *==========================================================================
1077:     * BtnVisualizarClick - Abre Page2 em modo consulta (somente leitura)
1078:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1079:     *==========================================================================
1080:     PROCEDURE BtnVisualizarClick()
1081:         LOCAL loc_cCidChaves
1082:         loc_cCidChaves = ""
1083: 
1084:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1085:             SELECT cursor_4c_Dados
1086:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1087:         ENDIF
1088: 
1089:         IF EMPTY(loc_cCidChaves)
1090:             MsgAviso("Selecione um registro para visualizar.")
1091:         ELSE
1092:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1093:                 THIS.this_cPcEscolha = "CONSULTAR"
1094:                 THIS.this_cModoAtual = "VISUALIZAR"
1095:                 THIS.AlternarPagina(2)
1096:                 THIS.AjustarBotoesPorModo()
1097:                 THIS.HabilitarCampos()
1098:             ENDIF
1099:         ENDIF
1100:     ENDPROC
1101: 
1102:     *==========================================================================
1103:     * BtnAlterarClick - Abre Page2 para alterar balanco selecionado
1104:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1105:     *==========================================================================
1106:     PROCEDURE BtnAlterarClick()
1107:         LOCAL loc_cCidChaves
1108:         loc_cCidChaves = ""
1109: 
1110:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1111:             SELECT cursor_4c_Dados
1112:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1113:         ENDIF
1114: 
1115:         IF EMPTY(loc_cCidChaves)
1116:             MsgAviso("Selecione um registro para alterar.")
1117:         ELSE
1118:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1119:                 THIS.this_oBusinessObject.EditarRegistro()
1120:                 THIS.this_cPcEscolha = "ALTERAR"
1121:                 THIS.this_cModoAtual = "ALTERAR"
1122:                 THIS.AlternarPagina(2)
1123:                 THIS.AjustarBotoesPorModo()
1124:                 THIS.HabilitarCampos()
1125:             ENDIF
1126:         ENDIF
1127:     ENDPROC
1128: 
1129:     *==========================================================================
1130:     * BtnExcluirClick - Exclui balanco selecionado com confirmacao
1131:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1132:     *==========================================================================
1133:     PROCEDURE BtnExcluirClick()
1134:         LOCAL loc_cCidChaves, loc_lConfirma
1135:         loc_cCidChaves = ""
1136:         loc_lConfirma  = .F.
1137: 
1138:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1139:             SELECT cursor_4c_Dados
1140:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1141:         ENDIF
1142: 
1143:         IF EMPTY(loc_cCidChaves)
1144:             MsgAviso("Selecione um registro para excluir.")
1145:         ELSE
1146:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1147:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1148:                     "Confirmar Exclus" + CHR(227) + "o")
1149:                 IF loc_lConfirma
1150:                     IF THIS.this_oBusinessObject.Excluir()
1151:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1152:                         THIS.CarregarLista()
1153:                     ENDIF
1154:                 ENDIF
1155:             ENDIF
1156:         ENDIF
1157:     ENDPROC
1158: 
1159:     *==========================================================================
1160:     * BtnBuscarClick - Recarrega lista com filtros correntes
1161:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1162:     *==========================================================================
1163:     PROCEDURE BtnBuscarClick()
1164:         THIS.CarregarLista()
1165:     ENDPROC
1166: 
1167:     *==========================================================================
1168:     * BtnEncerrarClick - Fecha o formulario
1169:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1170:     *==========================================================================
1171:     PROCEDURE BtnEncerrarClick()
1172:         THIS.Release()
1173:     ENDPROC
1174: 
1175:     *==========================================================================
1176:     * BtnPosicaoBalClick - Posiciona para incluir novo balanco (btnPosicao legado)
1177:     * Legado: Fechamento=.F. + plAcInserir=.T. + Grupo_Op.Click(1)
1178:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1179:     *==========================================================================
1180:     PROCEDURE BtnPosicaoBalClick()
1181:         THIS.this_lFechamento = .F.
1182:         THIS.this_lAcInserir  = .T.
1183:         THIS.BtnIncluirClick()
1184:     ENDPROC
1185: 
1186:     *==========================================================================
1187:     * EmpresaLostFocus - Valida empresa e recarrega lista se empresa mudou
1188:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1189:     *==========================================================================
1190:     PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1191:         LOCAL loc_cEmp
1192:         loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)
1193: 
1194:         IF EMPTY(loc_cEmp)
1195:             MsgAviso("Empresa de preenchimento obrigat" + CHR(243) + "rio.")
1196:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.SetFocus()
1197:         ELSE
1198:             THIS.this_cPEmps = loc_cEmp
1199:             IF loc_cEmp <> THIS.this_cAntEmpr
1200:                 THIS.CarregarLista()
1201:             ENDIF
1202:         ENDIF
1203:     ENDPROC
1204: 
1205:     *==========================================================================
1206:     * DtInicialLostFocus - Sincroniza DtFinal se DtInicial > DtFinal; recarrega
1207:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1208:     *==========================================================================
1209:     PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1210:         LOCAL loc_dDtI, loc_dDtF, loc_oCnt
1211:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1212:         loc_dDtI = loc_oCnt.txt_4c_DtInicial.Value
1213:         loc_dDtF = loc_oCnt.txt_4c_DtFinal.Value
1214: 
1215:         IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
1216:             IF loc_dDtI > loc_dDtF
1217:                 loc_oCnt.txt_4c_DtFinal.Value = loc_dDtI
1218:                 loc_dDtF = loc_dDtI
1219:             ENDIF
1220:         ENDIF
1221: 
1222:         IF loc_dDtI <> THIS.this_dAntDtIni OR loc_dDtF <> THIS.this_dAntDtFin
1223:             THIS.CarregarLista()
1224:         ENDIF
1225:     ENDPROC
1226: 
1227:     *==========================================================================
1228:     * DtFinalLostFocus - Sincroniza DtInicial se DtFinal < DtInicial; recarrega
1229:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1230:     *==========================================================================
1231:     PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1232:         LOCAL loc_dDtI, loc_dDtF, loc_oCnt
1233:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1234:         loc_dDtI = loc_oCnt.txt_4c_DtInicial.Value
1235:         loc_dDtF = loc_oCnt.txt_4c_DtFinal.Value
1236: 
1237:         IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
1238:             IF loc_dDtF < loc_dDtI
1239:                 loc_oCnt.txt_4c_DtInicial.Value = loc_dDtF
1240:                 loc_dDtI = loc_dDtF
1241:             ENDIF
1242:         ENDIF
1243: 
1244:         IF loc_dDtI <> THIS.this_dAntDtIni OR loc_dDtF <> THIS.this_dAntDtFin
1245:             THIS.CarregarLista()
1246:         ENDIF
1247:     ENDPROC
1248: 
1249:     *==========================================================================
1250:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes ao entrar Page2
1251:     * Dispara via BINDEVENT em Page2.Activate (Pagina.Dados.Activate no legado)
1252:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1253:     *==========================================================================
1254:     PROCEDURE AjustarBotoesPorModo()
1255:         LOCAL loc_oPagina, loc_lCancelarVisivel, loc_lConsultar, loc_lSomenteVisual
1256:         loc_lResultado = .F.
1257: 
1258:         TRY
1259:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1260: 
1261:             *-- Carregar dados auxiliares de lookup (uma vez ao entrar em Page2)
1262:             THIS.CarregarDadosAuxiliares()
1263: 
1264:             loc_lConsultar      = (THIS.this_cPcEscolha = "CONSULTAR") OR !THIS.this_lFechamento
1265:             loc_lSomenteVisual  = (THIS.this_cPcEscolha = "CONSULTAR")
1266:             loc_lCancelarVisivel = (THIS.this_cPcEscolha <> "CONSULTAR") AND THIS.this_lFechamento
1267: 
1268:             *-- Cancelar: visivel apenas quando pode cancelar uma edicao real
1269:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Visible = loc_lCancelarVisivel
1270: 
1271:             *-- Confirmar.Cancel: ativado por ESC quando nao se pode confirmar
1272:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Cancel = loc_lConsultar
1273: 
1274:             *-- Width do container: 90 so Confirmar / 173 Confirmar + Cancelar
1275:             loc_oPagina.cnt_4c_BotoesAcao.Width = IIF(loc_lConsultar, 90, 173)
1276: 
1277:             *-- Processar: visivel somente em INSERIR
1278:             loc_oPagina.cmd_4c_Processar.Visible = (THIS.this_cPcEscolha = "INSERIR")
1279: 
1280:             *-- txt_4c_Data: editavel em INSERIR/ALTERAR ou quando !Fechamento
1281:             loc_oPagina.txt_4c_Data.ReadOnly = loc_lSomenteVisual AND THIS.this_lFechamento
1282: 
1283:             *-- Popula campos da BOParaForm (crSigCdFcx -> form)
1284:             THIS.BOParaForm()
1285: 
1286:             *-- Para CONSULTAR/EXCLUIR: exibir resultado salvo
1287:             IF INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
1288:                 THIS.CarregarDados()
1289:                 loc_oPagina.cnt_4c_Resultado.Visible = .T.
1290:             ELSE
1291:                 loc_oPagina.cnt_4c_Resultado.Visible = .F.
1292:             ENDIF
1293: 
1294:             *-- Para INSERIR e !Fechamento (posicao): Confirmar habilitado
1295:             IF THIS.this_cPcEscolha <> "INSERIR" OR !THIS.this_lFechamento
1296:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

*-- Linhas 1310 a 1353:
1310:     * ProcessarBalanco: TmpGccr, TmpCli, TmpPro, crSigOpOpt, LocalOpp, crSigCdOpe
1311:     * Chamado por AjustarBotoesPorModo ao entrar em Page2
1312:     *==========================================================================
1313:     PROTECTED PROCEDURE CarregarDadosAuxiliares()
1314:         LOCAL loc_cSql, loc_cEmpr
1315:         loc_cEmpr = THIS.this_cPEmps
1316: 
1317:         TRY
1318:             *-- crSigCdPac - parametros de conta do balanco
1319:             IF !USED("crSigCdPac")
1320:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
1321:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac")
1322:             ENDIF
1323: 
1324:             *-- crSigCdPam - parametros de material do balanco
1325:             IF !USED("crSigCdPam")
1326:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
1327:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
1328:             ENDIF
1329: 
1330:             *-- TmpGccr - grupos de balanco da empresa (SigCdGcc)
1331:             *-- Campos: Codigos (BalCodigo), Descrs (BalDescrs), UnifBals, GruFals, etc.
1332:             IF !USED("TmpGccr")
1333:                 loc_cSql = "SELECT Codigos, Descrs, UnifBals, GruFals, BalCodigo, BalDescrs FROM SigCdGcc " + ;
1334:                            "WHERE Emps = " + EscaparSQL(loc_cEmpr)
1335:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpGccr") > 0
1336:                     SELECT TmpGccr
1337:                     INDEX ON BalCodigo  TAG BalCodigo
1338:                     INDEX ON BalDescrs  TAG BalDescrs
1339:                     SET ORDER TO BalCodigo
1340:                 ENDIF
1341:             ENDIF
1342: 
1343:             *-- TmpCli - contas de balanco (clientes/contas correntes)
1344:             IF !USED("TmpCli")
1345:                 loc_cSql = "SELECT IClis, RClis, PagFals, RecFals, GruFals, Inativas, IClis AS BalCodigo, RClis AS BalNome " + ;
1346:                            "FROM SigCdCli WHERE Emps = " + EscaparSQL(loc_cEmpr)
1347:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpCli") > 0
1348:                     SELECT TmpCli
1349:                     INDEX ON BalCodigo TAG BalCodigo
1350:                     INDEX ON BalNome   TAG BalNome
1351:                     SET ORDER TO BalCodigo
1352:                 ENDIF
1353:             ENDIF

*-- Linhas 1401 a 1578:
1401:     * BOParaForm - Preenche controles visuais a partir do BO / crSigCdFcx
1402:     * Fase 5: Codigo e Data (Grupo/Conta/Lote em Fase 6)
1403:     *==========================================================================
1404:     PROTECTED PROCEDURE BOParaForm()
1405:         LOCAL loc_oPagina
1406:         TRY
1407:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1408: 
1409:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1410:                 loc_oPagina.txt_4c_Codigo.Value = NVL(crSigCdFcx.Codigos, 0)
1411: 
1412:                 IF VARTYPE(crSigCdFcx.Datas) = "T" OR VARTYPE(crSigCdFcx.Datas) = "D"
1413:                     IF VARTYPE(crSigCdFcx.Datas) = "T"
1414:                         loc_oPagina.txt_4c_Data.Value = TTOD(crSigCdFcx.Datas)
1415:                     ELSE
1416:                         loc_oPagina.txt_4c_Data.Value = crSigCdFcx.Datas
1417:                     ENDIF
1418:                 ENDIF
1419: 
1420:                 *-- Fase 6: txt_4c_Grupo, txt_4c_DGrupo, txt_4c_Conta, txt_4c_DConta, txt_4c_Lote
1421:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1422:                     loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(NVL(crSigCdFcx.Grupos, ""))
1423:                     =SEEK(ALLTRIM(crSigCdFcx.Grupos), "TmpGccr", "BalCodigo")
1424:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5) AND USED("TmpGccr") AND !EOF("TmpGccr")
1425:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
1426:                     ENDIF
1427:                 ENDIF
1428: 
1429:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1430:                     loc_oPagina.txt_4c_Conta.Value = ALLTRIM(NVL(crSigCdFcx.Contas, ""))
1431:                     =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
1432:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5) AND USED("TmpCli") AND !EOF("TmpCli")
1433:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.RClis)
1434:                     ENDIF
1435:                 ENDIF
1436:             ENDIF
1437:         CATCH TO loc_oErro
1438:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "FormFea")
1439:         ENDTRY
1440:     ENDPROC
1441: 
1442:     *==========================================================================
1443:     * FormParaBO - Le controles visuais e atualiza BO / crSigCdFcx
1444:     * Fase 5: Data (Grupo/Conta em Fase 6)
1445:     *==========================================================================
1446:     PROTECTED PROCEDURE FormParaBO()
1447:         LOCAL loc_oPagina
1448:         TRY
1449:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1450: 
1451:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1452:                 SELECT crSigCdFcx
1453:                 REPLACE crSigCdFcx.Datas WITH loc_oPagina.txt_4c_Data.Value
1454: 
1455:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1456:                     REPLACE crSigCdFcx.Grupos WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), LEN(crSigCdFcx.Grupos))
1457:                 ENDIF
1458:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1459:                     REPLACE crSigCdFcx.Contas WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Conta.Value), LEN(crSigCdFcx.Contas))
1460:                 ENDIF
1461:             ENDIF
1462:         CATCH TO loc_oErro
1463:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormFea")
1464:         ENDTRY
1465:     ENDPROC
1466: 
1467:     *==========================================================================
1468:     * HabilitarCampos - Habilita/desabilita campos conforme modo (legado: When())
1469:     *==========================================================================
1470:     PROTECTED PROCEDURE HabilitarCampos()
1471:         LOCAL loc_oPagina, loc_lEdita, loc_lProcurar
1472:         TRY
1473:             loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1474:             loc_lEdita   = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") OR !THIS.this_lFechamento
1475:             loc_lProcurar = (THIS.this_cPcEscolha = "PROCURAR")
1476: 
1477:             *-- Codigo: editavel somente em PROCURAR
1478:             loc_oPagina.txt_4c_Codigo.ReadOnly = !loc_lProcurar
1479: 
1480:             *-- Data: editavel em INSERIR/ALTERAR ou posicao
1481:             loc_oPagina.txt_4c_Data.ReadOnly = !loc_lEdita
1482: 
1483:             *-- Fase 6: Grupo, DGrupo, Conta, DConta, Lote (guardados por PEMSTATUS)
1484:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1485:                 loc_oPagina.txt_4c_Grupo.ReadOnly = !loc_lEdita
1486:             ENDIF
1487:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
1488:                 loc_oPagina.txt_4c_DGrupo.ReadOnly = !(EMPTY(loc_oPagina.txt_4c_Grupo.Value) AND loc_lEdita)
1489:             ENDIF
1490:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1491:                 loc_oPagina.txt_4c_Conta.ReadOnly = !loc_lEdita
1492:             ENDIF
1493:             IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
1494:                 loc_oPagina.txt_4c_DConta.ReadOnly = !(EMPTY(loc_oPagina.txt_4c_Conta.Value) AND loc_lEdita)
1495:             ENDIF
1496:             IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5)
1497:                 loc_oPagina.txt_4c_Lote.ReadOnly = THIS.this_lFechamento
1498:             ENDIF
1499:         CATCH TO loc_oErro
1500:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "FormFea")
1501:         ENDTRY
1502:     ENDPROC
1503: 
1504:     *==========================================================================
1505:     * LimparCampos - Limpa campos da Page2 (Fase 5: Data; Fase 6: restantes)
1506:     *==========================================================================
1507:     PROTECTED PROCEDURE LimparCampos()
1508:         LOCAL loc_oPagina
1509:         TRY
1510:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1511:             loc_oPagina.txt_4c_Data.Value = DATE()
1512:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1513:                 loc_oPagina.txt_4c_Grupo.Value = ""
1514:             ENDIF
1515:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
1516:                 loc_oPagina.txt_4c_DGrupo.Value = ""
1517:             ENDIF
1518:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1519:                 loc_oPagina.txt_4c_Conta.Value = ""
1520:             ENDIF
1521:             IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
1522:                 loc_oPagina.txt_4c_DConta.Value = ""
1523:             ENDIF
1524:             IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5)
1525:                 loc_oPagina.txt_4c_Lote.Value = 0
1526:             ENDIF
1527:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1528:             loc_oPagina.cnt_4c_Resultado.Visible = .F.
1529:         CATCH TO loc_oErro
1530:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "FormFea")
1531:         ENDTRY
1532:     ENDPROC
1533: 
1534:     *==========================================================================
1535:     * CarregarDados - Carrega resultado de balanco para CONSULTAR/EXCLUIR
1536:     * Equivale a ThisForm.CarregaDados do legado (nao extraido - implementado)
1537:     *==========================================================================
1538:     PROTECTED PROCEDURE CarregarDados()
1539:         LOCAL loc_lResultado
1540:         loc_lResultado = .F.
1541:         TRY
1542:             IF USED("CrSigCdFea") AND !EOF("CrSigCdFea") AND ;
1543:                USED("TmpResumo") AND RECCOUNT("TmpResumo") > 0
1544:                 *-- Dados ja carregados em TmpResumo pelo ultimo ProcessarBalanco
1545:                 loc_lResultado = .T.
1546:             ELSE
1547:                 *-- Para CONSULTAR/EXCLUIR sem processamento anterior:
1548:                 *-- carregar do SigOpCfe (saldos salvos) vinculados ao crSigCdFcx
1549:                 IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1550:                     LOCAL loc_cSql
1551:                     loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + ;
1552:                                TRANSFORM(crSigCdFcx.Codigos) + ;
1553:                                " AND Emps = " + EscaparSQL(ALLTRIM(crSigCdFcx.Emps)) + ;
1554:                                " ORDER BY Codigos, Cpros"
1555:                     IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoCarreg") > 0
1556:                         *-- Popula TmpResumo a partir dos saldos salvos
1557:                         IF !USED("TmpResumo")
1558:                             CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), ;
1559:                                 CUnis C(10), Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), ;
1560:                                 Saldof N(12,3), PfTrabs N(8,2), IndProd N(8,2), ;
1561:                                 PesoEnts N(12,3), PesoSais N(12,3), QtdeEnts N(12,3), ;
1562:                                 QtdeSais N(12,3), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1563:                                 Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
1564:                                 Varias N(1), Agregas N(1), Visivel L, ;
1565:                                 Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
1566:                             INDEX ON Grupo + Conta + CMats TAG GrConMat
1567:                             SET ORDER TO GrConMat
1568:                         ELSE
1569:                             SELECT TmpResumo
1570:                             ZAP
1571:                             SET ORDER TO GrConMat
1572:                         ENDIF
1573:                         SELECT CrSaldoCarreg
1574:                         SCAN
1575:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, Saldof) ;
1576:                                 VALUES (crSigCdFcx.Grupos, crSigCdFcx.Contas, ;
1577:                                         CrSaldoCarreg.Cpros, CrSaldoCarreg.Pesagems)
1578:                         ENDSCAN

*-- Linhas 1589 a 1717:
1589:         RETURN loc_lResultado
1590:     ENDPROC
1591: 
1592:     *==========================================================================
1593:     * DadosInteractiveChange - Oculta resultado e desabilita Confirmar
1594:     * Disparado por InteractiveChange em txt_4c_Data (Fase 5) e futuramente
1595:     * txt_4c_Grupo, txt_4c_DGrupo, txt_4c_Conta, txt_4c_DConta (Fase 6)
1596:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1597:     *==========================================================================
1598:     PROCEDURE DadosInteractiveChange()
1599:         TRY
1600:             IF THIS.this_lFechamento
1601:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1602:             ENDIF
1603:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Visible = .F.
1604:         CATCH TO loc_oErro
1605:             MsgErro("Erro em DadosInteractiveChange:" + CHR(13) + loc_oErro.Message, "FormFea")
1606:         ENDTRY
1607:     ENDPROC
1608: 
1609:     *==========================================================================
1610:     * DataLostFocus - Copia data de fechamento para campo DataCc no Resultado
1611:     * Legado: Get_Data.LostFocus - copia valor para Resultado.Cnt_Conversao.Get_DataCc
1612:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1613:     *==========================================================================
1614:     PROCEDURE DataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1615:         LOCAL loc_oPagina
1616:         TRY
1617:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1618:             IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
1619:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
1620:                     loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.Value = ;
1621:                         loc_oPagina.txt_4c_Data.Value
1622:                 ENDIF
1623:             ENDIF
1624:         CATCH TO loc_oErro
1625:             MsgErro("Erro em DataLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
1626:         ENDTRY
1627:     ENDPROC
1628: 
1629:     *==========================================================================
1630:     * BtnConfirmarClick - Salva o balanco apos validacao
1631:     * Legado: Salva.Click (Grupo_Salva no legado)
1632:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1633:     *==========================================================================
1634:     PROCEDURE BtnConfirmarClick()
1635:         LOCAL loc_lResultado, loc_oPagina, loc_cGrupo, loc_cConta, loc_dData, loc_dDataCc
1636:         loc_lResultado = .F.
1637: 
1638:         TRY
1639:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1640:             loc_dData   = loc_oPagina.txt_4c_Data.Value
1641:             loc_cGrupo  = ""
1642:             loc_cConta  = ""
1643:             loc_dDataCc = {}
1644: 
1645:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1646:                 loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1647:             ENDIF
1648:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1649:                 loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1650:             ENDIF
1651:             IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
1652:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
1653:                     loc_dDataCc = loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.Value
1654:                 ENDIF
1655:             ENDIF
1656: 
1657:             IF THIS.this_lFechamento AND THIS.this_cPcEscolha = "INSERIR"
1658:                 *-- Validar Data
1659:                 IF EMPTY(loc_dData)
1660:                     MsgAviso("A Data Deve Ser Informada...")
1661:                     loc_oPagina.txt_4c_Data.SetFocus()
1662:                 ELSE
1663:                     IF EMPTY(loc_cGrupo)
1664:                     MsgAviso("O Grupo Deve Ser Informado...")
1665:                     IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1666:                         loc_oPagina.txt_4c_Grupo.SetFocus()
1667:                     ENDIF
1668:                 ELSE
1669:                     IF EMPTY(loc_cConta)
1670:                     MsgAviso("A Conta Deve Ser Informada...")
1671:                     IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1672:                         loc_oPagina.txt_4c_Conta.SetFocus()
1673:                     ENDIF
1674:                 ELSE
1675:                     *-- Validar DataCc >= Data
1676:                     IF VARTYPE(loc_dDataCc) = "D" AND !EMPTY(loc_dDataCc) AND loc_dDataCc < loc_dData
1677:                         MsgAviso("A Data de Lan" + CHR(231) + "amento N" + CHR(227) + "o Pode Ser" + CHR(13) + ;
1678:                                  "Menor Que a Data de Fechamento...")
1679:                         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
1680:                             IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
1681:                                 loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.SetFocus()
1682:                             ENDIF
1683:                         ENDIF
1684:                     ELSE
1685:                         IF MsgConfirma("Esta Opera" + CHR(231) + CHR(227) + "o Ir" + CHR(225) + ;
1686:                                        " Encerrar o Balan" + CHR(231) + "o da Conta " + ;
1687:                                        loc_cGrupo + " / " + loc_cConta + "." + CHR(13) + CHR(13) + ;
1688:                                        "As Diferen" + CHR(231) + "as Selecionadas Na Tabela de Materiais " + ;
1689:                                        "Ser" + CHR(227) + "o Lan" + CHR(231) + "adas Nesta Conta..." + ;
1690:                                        CHR(13) + CHR(13) + "Deseja Prosseguir ?", ;
1691:                                        "Aten" + CHR(231) + CHR(227) + "o!!!")
1692:                         THIS.FormParaBO()
1693:                         IF THIS.this_oBusinessObject.Salvar()
1694:                             THIS.this_lFechamento = .T.
1695:                             THIS.AlternarPagina(1)
1696:                             loc_lResultado = .T.
1697:                         ENDIF
1698:                         ENDIF
1699:                     ENDIF
1700:                     ENDIF
1701:                     ENDIF
1702:                 ENDIF
1703:             ELSE
1704:                 IF THIS.this_lFechamento
1705:                     THIS.FormParaBO()
1706:                     IF THIS.this_oBusinessObject.Salvar()
1707:                         THIS.this_lFechamento = .T.
1708:                         THIS.AlternarPagina(1)
1709:                         loc_lResultado = .T.
1710:                     ENDIF
1711:                 ELSE
1712:                     *-- Modo posicao (!Fechamento): apenas reverter e voltar
1713:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1714:                     THIS.this_lFechamento = .T.
1715:                     THIS.AlternarPagina(1)
1716:                     loc_lResultado = .T.
1717:                 ENDIF

*-- Linhas 1728 a 1806:
1728:     * BtnSalvarClick - Alias canonico de BtnConfirmarClick
1729:     * O botao real e cmd_4c_Confirmar (padrao CLAUDE.md regra #10 para SAIDA).
1730:     * Este metodo existe para atender contratos que esperam o nome "Salvar".
1731:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1732:     *==========================================================================
1733:     PROCEDURE BtnSalvarClick()
1734:         RETURN THIS.BtnConfirmarClick()
1735:     ENDPROC
1736: 
1737:     *==========================================================================
1738:     * BtnCancelarClick - Cancela edicao e retorna para Page1
1739:     * Legado: Cancelar.Click (Grupo_Salva no legado)
1740:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1741:     *==========================================================================
1742:     PROCEDURE BtnCancelarClick()
1743:         LOCAL loc_lResultado
1744:         loc_lResultado = .F.
1745: 
1746:         TRY
1747:             THIS.this_lCancelar = .T.
1748:             *-- Rollback da transacao SQL corrente
1749:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1750:             THIS.this_lFechamento = .T.
1751:             THIS.AlternarPagina(1)
1752:             loc_lResultado = .T.
1753:         CATCH TO loc_oErro
1754:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "FormFea")
1755:         ENDTRY
1756: 
1757:         RETURN loc_lResultado
1758:     ENDPROC
1759: 
1760:     *==========================================================================
1761:     * IncluirHistorico - Insere registro nos cursores TmpHist e TmpHistC
1762:     * Traducao de inclui_historico (legado). Chamado em SCAN loops dentro
1763:     * de ProcessarBalanco para cada movimento de entrada/saida.
1764:     * PUBLIC: BINDEVENT/SCAN exige metodo publico (CLAUDE.md regra #3)
1765:     *==========================================================================
1766:     PROCEDURE IncluirHistorico(par_cArquivo, par_cTipoConta, par_cTipo, ;
1767:                                par_nValor, par_nPeso, par_nPesoFabr, ;
1768:                                par_cGrupoo, par_cContao, par_cGrupod, par_cContad)
1769:         LOCAL loc_nEntrada, loc_nSaida, loc_nPEntrada, loc_nPSaida
1770:         LOCAL loc_nPfEntrada, loc_nPfSaida
1771:         LOCAL loc_cGrupo, loc_cConta, loc_cGrupo2, loc_cConta2
1772: 
1773:         STORE 0 TO loc_nEntrada, loc_nSaida, loc_nPEntrada, loc_nPSaida, loc_nPfEntrada, loc_nPfSaida
1774: 
1775:         IF par_cTipo = "E"
1776:             loc_nEntrada   = par_nValor
1777:             loc_nPEntrada  = par_nPeso
1778:             loc_nPfEntrada = par_nPesoFabr
1779:         ELSE
1780:             loc_nSaida   = par_nValor
1781:             loc_nPSaida  = par_nPeso
1782:             loc_nPfSaida = par_nPesoFabr
1783:         ENDIF
1784: 
1785:         IF par_cArquivo = "Nens"
1786:             SELECT LocalNens
1787:             IF par_cTipoConta = "O"
1788:                 loc_cGrupo  = LocalNens.Grupoos
1789:                 loc_cConta  = LocalNens.Contaos
1790:                 loc_cGrupo2 = LocalNens.Grupods
1791:                 loc_cConta2 = LocalNens.Contads
1792:             ELSE
1793:                 loc_cGrupo  = LocalNens.Grupods
1794:                 loc_cConta  = LocalNens.Contads
1795:                 loc_cGrupo2 = LocalNens.Grupoos
1796:                 loc_cConta2 = LocalNens.Contaos
1797:             ENDIF
1798:         ELSE
1799:             SELECT LocalEest
1800:             loc_cGrupo  = IIF(TYPE("par_cGrupoo") = "C", par_cGrupoo, SPACE(10))
1801:             loc_cConta  = IIF(TYPE("par_cContao") = "C", par_cContao, SPACE(10))
1802:             loc_cGrupo2 = IIF(TYPE("par_cGrupod") = "C", par_cGrupod, SPACE(10))
1803:             loc_cConta2 = IIF(TYPE("par_cContad") = "C", par_cContad, SPACE(10))
1804:         ENDIF
1805: 
1806:         IF loc_nEntrada = 0 AND loc_nSaida = 0 AND loc_nPEntrada = 0 AND loc_nPSaida = 0

*-- Linhas 1843 a 1897:
1843:     *==========================================================================
1844:     * BtnProcessarClick - Valida campos e executa ProcessarBalanco
1845:     * Legado: Processar.Click (o maior metodo do formulario: ~1475 linhas)
1846:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1847:     *==========================================================================
1848:     PROCEDURE BtnProcessarClick()
1849:         LOCAL loc_lResultado
1850:         loc_lResultado = .F.
1851: 
1852:         TRY
1853:             loc_lResultado = THIS.ProcessarBalanco()
1854:         CATCH TO loc_oErro
1855:             MsgErro("Erro em BtnProcessarClick:" + CHR(13) + loc_oErro.Message + ;
1856:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1857:                     CHR(13) + "Proc: " + loc_oErro.Procedure, "FormFea - Processar Balan" + CHR(231) + "o")
1858:         ENDTRY
1859: 
1860:         RETURN loc_lResultado
1861:     ENDPROC
1862: 
1863:     *==========================================================================
1864:     * ProcessarBalanco - Logica completa de processamento do balanco de estoque
1865:     * Traducao do legado Processar.Click (~1475 linhas) para nova arquitetura
1866:     *
1867:     * Fluxo:
1868:     *  1. Validacao de campos obrigatorios
1869:     *  2. ZAP de cursores temporarios
1870:     *  3. Pre-carregamento de lookups
1871:     *  4. SQL para buscar movimentacoes (LocalNens/LocalEest/LocalPesa)
1872:     *  5. SCAN de movimentacoes -> TmpResumo / TmpOpera / TmpConta / TmpResFas
1873:     *  6. Calculo de saldos finais (CrUltBal / CrSaldoI)
1874:     *  7. Calculo de cotacoes (TmpCot)
1875:     *  8. Calcular indice de produtividade
1876:     *  9. Se Fechamento: INSERT em CrSigCdFea
1877:     * 10. Exibir cnt_4c_Resultado
1878:     *==========================================================================
1879:     PROTECTED FUNCTION ProcessarBalanco()
1880:         LOCAL loc_oPagina, loc_cEmpr
1881:         LOCAL loc_cGrupo, loc_cConta, loc_dData, loc_nCodigo, loc_nLote
1882:         LOCAL loc_pDtI, loc_pDtF, loc_llFalse, loc_llTrue
1883:         LOCAL loc_cQuery, loc_cUpdate, loc_cSql, loc_cEdn, loc_cEGE
1884:         LOCAL loc_cMatSec, loc_nFalhaAdmitida, loc_llTipoQ, loc_llGrvPrz
1885:         LOCAL loc_cMaterial, loc_cMatResFa, loc_cOperacao
1886:         LOCAL loc_lOrigem, loc_lDestino, loc_lOrigemF, loc_lDestinoF
1887:         LOCAL loc_nPesoTotal, loc_nQtde, loc_nPeso, loc_nFalha
1888:         LOCAL loc_cCodCor, loc_cCodTam
1889:         LOCAL loc_cGrupoD, loc_cContaD
1890:         LOCAL loc_nNumFape, loc_nTrabalhado, loc_nTrabalhadB
1891:         LOCAL loc_nSaldoi, loc_nPesagem
1892:         LOCAL loc_cMoeda, loc_nCusto, loc_nCota
1893:         LOCAL loc_dDataUBal, loc_nNdFechas, loc_nCodigosFcx
1894:         LOCAL loc_cMatPrev, loc_cMatOuro
1895:         LOCAL loc_loBarra
1896: 
1897:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1903 a 1980:
1903:         IF THIS.this_cPcEscolha <> "INSERIR"
1904:             RETURN .F.
1905:         ENDIF
1906: 
1907:         *-- Ler valores dos campos
1908:         loc_dData  = loc_oPagina.txt_4c_Data.Value
1909:         loc_cGrupo = ""
1910:         loc_cConta = ""
1911:         loc_nLote  = 0
1912:         loc_nCodigo = IIF(VARTYPE(loc_oPagina.txt_4c_Codigo.Value) = "N", loc_oPagina.txt_4c_Codigo.Value, 0)
1913: 
1914:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1915:             loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1916:         ENDIF
1917:         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1918:             loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1919:         ENDIF
1920:         IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5) AND !THIS.this_lFechamento
1921:             loc_nLote = NVL(loc_oPagina.txt_4c_Lote.Value, 0)
1922:         ENDIF
1923: 
1924:         *-- Validar campos obrigatorios
1925:         IF EMPTY(loc_dData)
1926:             MsgAviso("A Data Deve Ser Informada...")
1927:             loc_oPagina.txt_4c_Data.SetFocus()
1928:             RETURN .F.
1929:         ENDIF
1930: 
1931:         IF EMPTY(loc_cGrupo)
1932:             MsgAviso("O Grupo Deve Ser Informado...")
1933:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1934:                 loc_oPagina.txt_4c_Grupo.SetFocus()
1935:             ENDIF
1936:             RETURN .F.
1937:         ENDIF
1938: 
1939:         IF EMPTY(loc_cConta)
1940:             MsgAviso("A Conta Deve Ser Informada...")
1941:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1942:                 loc_oPagina.txt_4c_Conta.SetFocus()
1943:             ENDIF
1944:             RETURN .F.
1945:         ENDIF
1946: 
1947:         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1948: 
1949:         *-- Ocultar resultado + resetar EntraPeso
1950:         loc_oPagina.cnt_4c_Resultado.Visible = .F.
1951:         THIS.this_lEntraPeso = .F.
1952: 
1953:         *-- ZAP / CREATE cursores temporarios
1954:         IF USED("TmpCot")
1955:             ZAP IN TmpCot
1956:         ELSE
1957:             CREATE CURSOR TmpCot (Cmoes C(10), Valos N(18,6))
1958:             INDEX ON Cmoes TAG Cmoes
1959:             SET ORDER TO Cmoes
1960:         ENDIF
1961: 
1962:         IF USED("TmpConta")
1963:             ZAP IN TmpConta
1964:             SELECT TmpConta
1965:             SET ORDER TO GrConta
1966:         ELSE
1967:             CREATE CURSOR TmpConta (Grupo C(10), Conta C(10), Nome C(80))
1968:             INDEX ON Grupo + Conta TAG GrConta
1969:             SET ORDER TO GrConta
1970:         ENDIF
1971: 
1972:         IF USED("TmpHist")
1973:             ZAP IN TmpHist
1974:         ELSE
1975:             CREATE CURSOR TmpHist (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), Datas D, ;
1976:                                    QtdeEnts N(12,3), QtdeSais N(12,3), Dopps C(15), ;
1977:                                    Numps N(10), cUnis C(10), Grupo2 C(10), Conta2 C(10), ;
1978:                                    PesoEnts N(12,3), PesoSais N(12,3), Nenvs N(10), ;
1979:                                    Obss C(100), Opers C(1), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1980:                                    cUnips C(10), Emps C(3), nLotes N(6))

*-- Linhas 2140 a 2183:
2140:         ENDIF
2141: 
2142:         IF !EMPTY(loc_dDataUBal) AND loc_dDataUBal > loc_dData
2143:             MsgAviso("A Data N" + CHR(227) + "o Pode Ser Menor Que o " + CHR(218) + ;
2144:                      "ltimo Balan" + CHR(231) + "o..." + CHR(13) + CHR(13) + ;
2145:                      "Data do " + CHR(218) + "ltimo Balan" + CHR(231) + "o : " + DTOC(loc_dDataUBal))
2146:             loc_oPagina.txt_4c_Data.SetFocus()
2147:             RETURN .F.
2148:         ENDIF
2149: 
2150:         *-- Atualizar Datais no FCX com data do ultimo balanco
2151:         IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
2152:             SELECT crSigCdFcx
2153:             REPLACE crSigCdFcx.Datais WITH loc_dDataUBal
2154:         ENDIF
2155: 
2156:         *-- Parametros de data para SQL parametrizado
2157:         loc_pDtI = fDtoSQL(loc_dDataUBal)
2158:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
2159: 
2160:         *-- Dados da empresa (EmpBals)
2161:         loc_cSql = "SELECT TOP 1 * FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpr)
2162:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalEmp")
2163:         LOCAL loc_cEmpBals
2164:         loc_cEmpBals = ""
2165:         IF USED("LocalEmp") AND !EOF("LocalEmp") AND PEMSTATUS(LocalEmp, "EmpBals", 5)
2166:             loc_cEmpBals = ALLTRIM(NVL(LocalEmp.EmpBals, ""))
2167:         ENDIF
2168: 
2169:         *==========================================================================
2170:         *-- MOVIMENTACOES DE PRODUCAO (LocalNens / LocalNensI)
2171:         *==========================================================================
2172:         loc_cQuery = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, " + ;
2173:                      "Obss, cIdChaves, EmpDnPs, nLotes " + ;
2174:                      "FROM SigCdNec " + ;
2175:                      "WHERE ( Emps = " + EscaparSQL(loc_cEmpr) + ;
2176:                      IIF(!EMPTY(loc_cEmpBals), " OR Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2177:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2178:                      " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2179:                      " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
2180:                      " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2181:                      " AND ContaOs = " + EscaparSQL(loc_cConta) + ;
2182:                      " AND ProcBals = ?loc_llFalse))" + ;
2183:                      IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;

*-- Linhas 2280 a 2323:
2280:         *-- SCAN PRINCIPAL: Movimentacoes de Producao (LocalNens)
2281:         *==========================================================================
2282:         SELECT LocalNens
2283:         loc_loBarra = CREATEOBJECT("fwprogressbar", ;
2284:                       "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", ;
2285:                       RECCOUNT("LocalNens"))
2286:         loc_loBarra.Show
2287: 
2288:         SCAN
2289:             loc_loBarra.Update(.T.)
2290: 
2291:             loc_cEdn = LocalNens.Emps + LocalNens.Dopps + STR(LocalNens.Numps, 10)
2292: 
2293:             =SEEK(LocalNens.Dopps, "LocalOpp", "Dopps")
2294: 
2295:             loc_lOrigem   = .F.
2296:             loc_lDestino  = .F.
2297:             loc_cMaterial = SPACE(14)
2298:             loc_cMatResFa = SPACE(14)
2299: 
2300:             IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
2301:                LocalOpp.Origems = 1 AND LocalNens.GrupoOs = loc_cGrupo AND ;
2302:                LocalNens.ContaOs = loc_cConta AND INLIST(LocalOpp.EstOrigs, 1, 2)
2303:                 loc_lOrigem = .T.
2304:             ENDIF
2305:             IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
2306:                LocalOpp.Destinos = 1 AND LocalNens.GrupoDs = loc_cGrupo AND ;
2307:                LocalNens.ContaDs = loc_cConta AND INLIST(LocalOpp.EstDests, 1, 2)
2308:                 loc_lDestino = .T.
2309:             ENDIF
2310: 
2311:             IF !loc_lOrigem AND !loc_lDestino
2312:                 LOOP
2313:             ENDIF
2314: 
2315:             loc_nPesoTotal = 0
2316:             loc_llGrvPrz   = .F.
2317: 
2318:             *-- Scan interno: itens do movimento (LocalNensI)
2319:             SELECT LocalNensI
2320:             SEEK loc_cEdn
2321:             SCAN WHILE EmpDNPs = loc_cEdn
2322:                 *-- Determinar material baseado em UnifBals
2323:                 IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 4

*-- Linhas 2685 a 2728:
2685: 
2686:         *-- SCAN: Movimentacoes de Estoque
2687:         SELECT LocalEest
2688:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("LocalEest"))
2689:         loc_loBarra.Show
2690: 
2691:         SCAN
2692:             loc_loBarra.Update(.T.)
2693:             loc_cEdn = LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 6)
2694: 
2695:             =SEEK(LocalEest.Dopes, "crSigCdOpe", "Dopes")
2696: 
2697:             loc_lOrigem   = .F.
2698:             loc_lDestino  = .F.
2699:             loc_lOrigemF  = .F.
2700:             loc_lDestinoF = .F.
2701: 
2702:             IF USED("crSigCdOpe") AND !EOF("crSigCdOpe")
2703:                 IF crSigCdOpe.Estoqs = 1 AND (crSigCdOpe.EstOrigs = 4 OR crSigCdOpe.Opers = 3) AND LocalEest.Emps = loc_cEmpr
2704:                     IF crSigCdOpe.Origems = 1 AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
2705:                         loc_lOrigem = .T.
2706:                     ELSE
2707:                         IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
2708:                             loc_lDestino = .T.
2709:                         ENDIF
2710:                     ENDIF
2711:                 ELSE
2712:                     IF crSigCdOpe.Estoqs = 1 AND crSigCdOpe.Origems = 1 AND ;
2713:                        LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta AND LocalEest.Emps = loc_cEmpr
2714:                         IF INLIST(crSigCdOpe.EstOrigs, 1, 2)
2715:                             loc_lOrigem = .T.
2716:                         ENDIF
2717:                     ENDIF
2718:                     IF crSigCdOpe.Estoqs = 1 AND crSigCdOpe.Destinos = 1 AND ;
2719:                        LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
2720:                         IF INLIST(crSigCdOpe.EstDests, 1, 2)
2721:                             loc_lDestino = .T.
2722:                         ENDIF
2723:                     ENDIF
2724:                 ENDIF
2725:             ENDIF
2726: 
2727:             IF !loc_lOrigem AND !loc_lDestino
2728:                 LOOP

*-- Linhas 3306 a 3349:
3306: 
3307:         *-- Calcular saldos finais para cada material em TmpResumo
3308:         SELECT TmpResumo
3309:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("TmpResumo"))
3310:         loc_loBarra.Show
3311:         loc_cMatPrev = SPACE(14)
3312: 
3313:         SCAN
3314:             loc_loBarra.Update(.T.)
3315:             STORE 0 TO loc_nSaldoi, loc_nPesagem
3316: 
3317:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3318:             IF !loc_llTipoQ AND TmpResumo.CMats <> loc_cMatPrev
3319:                 loc_nFalhaAdmitida = 0
3320:                 loc_cMatPrev = TmpResumo.CMats
3321:             ENDIF
3322: 
3323:             SELECT CrSaldoI
3324:             =SEEK(TmpResumo.CMats)
3325:             loc_nSaldoi = IIF(EOF("CrSaldoI"), 0, CrSaldoI.Pesagems)
3326: 
3327:             SELECT TmpOpera
3328:             =SEEK(TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats)
3329:             loc_nTrabalhado = 0
3330:             loc_nTrabalhadB = 0
3331:             SCAN WHILE CMats = TmpResumo.CMats
3332:                 =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
3333:                 IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
3334:                    USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
3335:                    crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
3336:                    crSigOpOpt.TFalhas <> "Q" AND TmpOpera.AplicFlhs <> 2 AND ;
3337:                    crSigCdPam.GrTrans <> loc_cGrupo
3338:                     loc_nFalhaAdmitida = loc_nFalhaAdmitida + ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3)
3339:                     REPLACE PFalha WITH crSigOpOpt.PFalhas, ;
3340:                             Falha  WITH ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3) IN TmpOpera
3341:                 ENDIF
3342:                 IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
3343:                    (crSigOpOpt.Trabas = 1 OR EMPTY(TmpOpera.TpOps))
3344:                     loc_nTrabalhado = loc_nTrabalhado + TmpOpera.QtdeSais
3345:                     loc_nTrabalhadB = loc_nTrabalhadB + TmpOpera.QtdeBSais
3346:                 ENDIF
3347:             ENDSCAN
3348:             IF loc_nTrabalhadB <> 0
3349:                 loc_nTrabalhado = loc_nTrabalhadB

*-- Linhas 3359 a 3413:
3359:             =SEEK(loc_cConta, "TmpCli", "BalCodigo")
3360:             IF TmpResumo.Saldof <> 0 AND USED("TmpCli") AND !EOF("TmpCli") AND ;
3361:                (TmpCli.PagFals = 1 OR TmpCli.RecFals = 1)
3362:                 REPLACE Flag WITH .T., Flag2 WITH .T. IN TmpResumo
3363:                 IF THIS.this_lFechamento
3364:                     IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
3365:                         loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.Visible = .T.
3366:                     ENDIF
3367:                 ENDIF
3368:             ENDIF
3369:         ENDSCAN
3370: 
3371:         *-- Processar registros do saldo anterior que nao estao em TmpResumo
3372:         SELECT CrSaldoI
3373:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("CrSaldoI"))
3374:         loc_loBarra.Show
3375:         SCAN
3376:             loc_loBarra.Update(.T.)
3377:             IF CrSaldoI.Pesagems = 0
3378:                 LOOP
3379:             ENDIF
3380:             =SEEK(CrSaldoI.Cpros, "TmpPro", "CPros")
3381:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3382:             =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3383:             loc_nSaldoi = CrSaldoI.Pesagems
3384:             SELECT TmpResumo
3385:             LOCATE FOR CMats = CrSaldoI.Cpros
3386:             IF EOF()
3387:                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3388:                     VALUES (loc_cGrupo, loc_cConta, CrSaldoI.Cpros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3389:                 SELECT TmpResumo
3390:                 REPLACE Saldoi WITH loc_nSaldoi, FReal WITH loc_nSaldoi, ;
3391:                         FAdmin WITH 0, Saldof WITH loc_nSaldoi, PfTrabs WITH 0
3392:             ENDIF
3393:         ENDSCAN
3394: 
3395:         *-- Construir tabela de cotacoes (TmpCot)
3396:         SELECT TmpResumo
3397:         SCAN
3398:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3399:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3400: 
3401:             loc_nCusto = 0
3402:             loc_cMoeda = ""
3403: 
3404:             IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND crSigCdPam.AcertBals = 1
3405:                 loc_nCusto = TmpPro.Custofs
3406:                 loc_cMoeda = ALLTRIM(TmpPro.MoeCusfs)
3407:             ELSE
3408:                 LOCAL loc_pDtHist1, loc_pDtHist2
3409:                 loc_pDtHist1 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData))
3410:                 loc_pDtHist2 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), "23:59:59")
3411:                 loc_cQuery = "SELECT TOP 1 cIdChaves, UnitMeds FROM SigMvHst " + ;
3412:                              "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3413:                              " AND Cpros = " + EscaparSQL(ALLTRIM(TmpResumo.CMats)) + ;

*-- Linhas 3464 a 3508:
3464:         SELECT TmpResumo
3465:         GO TOP
3466: 
3467:         IF EOF("TmpResumo")
3468:             MsgAviso("Nenhuma Informa" + CHR(231) + CHR(227) + "o Foi Selecionada...")
3469:             loc_oPagina.txt_4c_Data.SetFocus()
3470:             RETURN .F.
3471:         ENDIF
3472: 
3473:         *-- Calcular indice de produtividade
3474:         SELECT a.Grupo, a.Conta, a.CMats, COUNT(a.TpOps) AS TotTpOp, ;
3475:                SUM(c.IndProds) AS TotIndProd, d.Freal, SUM(a.QtdeSais) AS TotQtde ;
3476:             FROM TmpOpera a, crSigOpOpt c, TmpResumo d ;
3477:             WHERE !EMPTY(a.QtdeSais) AND a.TpOps = c.Cods AND c.IndProds > 0 AND ;
3478:                   d.Grupo + d.Conta + d.CMats = a.Grupo + a.Conta + a.CMats ;
3479:             GROUP BY a.Grupo, a.Conta, a.CMats, d.Freal ;
3480:             INTO CURSOR TmpIndProd
3481: 
3482:         IF RECCOUNT("TmpIndProd") > 0
3483:             SELECT a.Grupo, a.Conta, a.CMats, ;
3484:                    ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) AS IndProd ;
3485:                 FROM TmpIndProd a INTO CURSOR TmpIndProd
3486:             UPDATE TmpResumo SET IndProd = TmpIndProd.IndProd ;
3487:                 WHERE TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats = ;
3488:                       TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats
3489:         ENDIF
3490: 
3491:         *-- Atualizar grdMov RecordSource (controle de Fase 6)
3492:         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "grdMov", 5)
3493:             loc_oPagina.cnt_4c_Resultado.grdMov.RecordSource = ""
3494:             SELECT Dopps, 1 AS nMarcas FROM TmpHist GROUP BY Dopps INTO CURSOR CrOpp READWRITE
3495:             WITH loc_oPagina.cnt_4c_Resultado.grdMov
3496:                 .RecordSource          = "crOpp"
3497:                 .Column1.ControlSource = "crOpp.nMarcas"
3498:                 .Column2.ControlSource = "crOpp.Dopps"
3499:                 .Column1.Width = 17
3500:                 .Column2.Width = 150
3501:                 .Refresh()
3502:             ENDWITH
3503:         ENDIF
3504: 
3505:         *-- Inserir no CrSigCdFea se Fechamento
3506:         IF THIS.this_lFechamento
3507:             loc_nNumFape = fGerUniqueKey(loc_cEmpr + "SigCdFea")
3508:             SELECT TmpResumo

*-- Linhas 3542 a 3585:
3542:     * Chamado por ConfigurarPaginaDados() apos criar o container vazio.
3543:     * ColumnCount e RecordSource ficam FORA de WITH (Problema 36 VFP9).
3544:     *==========================================================================
3545:     PROTECTED PROCEDURE ConfigurarResultado(par_oCnt)
3546:         LOCAL loc_lResultado, loc_oGrd, loc_oPage
3547:         loc_lResultado = .F.
3548:         TRY
3549:             *-- Shape3: barra de cabecalho periodo (top=7,left=8,w=434,h=31)
3550:             par_oCnt.AddObject("shp_4c_Shape3", "Shape")
3551:             WITH par_oCnt.shp_4c_Shape3
3552:                 .Top           = 7
3553:                 .Left          = 8
3554:                 .Width         = 434
3555:                 .Height        = 31
3556:                 .SpecialEffect = 1
3557:                 .BackColor     = RGB(204, 204, 204)
3558:                 .BackStyle     = 1
3559:                 .BorderStyle   = 1
3560:                 .Curvature     = 0
3561:                 .Visible       = .T.
3562:             ENDWITH
3563: 
3564:             *-- Label18: "Periodo :" (top=15,left=19,w=45,h=15)
3565:             par_oCnt.AddObject("lbl_4c_Label18", "Label")
3566:             WITH par_oCnt.lbl_4c_Label18
3567:                 .Caption   = "Per" + CHR(237) + "odo :"
3568:                 .Top       = 15
3569:                 .Left      = 19
3570:                 .Width     = 45
3571:                 .Height    = 15
3572:                 .FontName  = "Tahoma"
3573:                 .FontSize  = 8
3574:                 .BackStyle = 0
3575:                 .AutoSize  = .F.
3576:                 .Visible   = .T.
3577:             ENDWITH
3578: 
3579:             *-- Get_Datai: data inicial (top=12,left=79,w=72,h=21)
3580:             par_oCnt.AddObject("Get_Datai", "TextBox")
3581:             WITH par_oCnt.Get_Datai
3582:                 .Value         = DATE()
3583:                 .Top           = 12
3584:                 .Left          = 79
3585:                 .Width         = 72

*-- Linhas 3870 a 3913:
3870:                 .SpecialEffect = 0
3871:                 .Visible       = .T.
3872:             ENDWITH
3873:             BINDEVENT(par_oCnt.Get_Pesagem, "Valid", THIS, "PesagemLostFocus")
3874: 
3875:             par_oCnt.AddObject("Get_FReal", "TextBox")
3876:             WITH par_oCnt.Get_FReal
3877:                 .Value         = 0
3878:                 .Top           = 190
3879:                 .Left          = 307
3880:                 .Width         = 109
3881:                 .Height        = 21
3882:                 .InputMask     = "999,999.999"
3883:                 .ReadOnly      = .T.
3884:                 .FontName      = "Tahoma"
3885:                 .FontSize      = 8
3886:                 .BackColor     = RGB(240, 240, 240)
3887:                 .BorderStyle   = 1
3888:                 .SpecialEffect = 0
3889:                 .Visible       = .T.
3890:             ENDWITH
3891: 
3892:             par_oCnt.AddObject("Get_FAdmitida", "TextBox")
3893:             WITH par_oCnt.Get_FAdmitida
3894:                 .Value         = 0
3895:                 .Top           = 213
3896:                 .Left          = 307
3897:                 .Width         = 109
3898:                 .Height        = 21
3899:                 .InputMask     = "999,999.999"
3900:                 .ReadOnly      = .T.
3901:                 .FontName      = "Tahoma"
3902:                 .FontSize      = 8
3903:                 .BackColor     = RGB(240, 240, 240)
3904:                 .BorderStyle   = 1
3905:                 .SpecialEffect = 0
3906:                 .Visible       = .T.
3907:             ENDWITH
3908: 
3909:             par_oCnt.AddObject("Get_Saldof", "TextBox")
3910:             WITH par_oCnt.Get_Saldof
3911:                 .Value         = 0
3912:                 .Top           = 235
3913:                 .Left          = 307

*-- Linhas 4098 a 4281:
4098:                 .Visible   = .T.
4099:             ENDWITH
4100: 
4101:             *-- op_ordem OptionGroup (top=318,left=801,w=49,h=36 - 2 botoes)
4102:             par_oCnt.AddObject("op_ordem", "OptionGroup")
4103:             WITH par_oCnt.op_ordem
4104:                 .Top         = 318
4105:                 .Left        = 801
4106:                 .Width       = 49
4107:                 .Height      = 36
4108:                 .Value       = 1
4109:                 .BackStyle   = 0
4110:                 .ButtonCount = 2
4111:                 WITH .Buttons(1)
4112:                     .Caption   = "1"
4113:                     .Top       = 2
4114:                     .Left      = 2
4115:                     .Width     = 45
4116:                     .Height    = 15
4117:                     .BackStyle = 0
4118:                 ENDWITH
4119:                 WITH .Buttons(2)
4120:                     .Caption   = "2"
4121:                     .Top       = 19
4122:                     .Left      = 2
4123:                     .Width     = 45
4124:                     .Height    = 15
4125:                     .BackStyle = 0
4126:                     .FontName  = "Tahoma"
4127:                     .FontSize  = 8
4128:                 ENDWITH
4129:             ENDWITH
4130: 
4131:             *-- chkPerdas (top=335,left=469,w=139,h=15)
4132:             par_oCnt.AddObject("chkPerdas", "CheckBox")
4133:             WITH par_oCnt.chkPerdas
4134:                 .Caption   = "Demonstrativo de Perdas"
4135:                 .Top       = 335
4136:                 .Left      = 469
4137:                 .Width     = 139
4138:                 .Height    = 15
4139:                 .Value     = 0
4140:                 .FontName  = "Tahoma"
4141:                 .FontSize  = 8
4142:                 .BackStyle = 0
4143:                 .Visible   = .T.
4144:             ENDWITH
4145:             BINDEVENT(par_oCnt.chkPerdas, "Click", THIS, "chkPerdasClick")
4146: 
4147:             *-- SelTudo (top=371,left=191,w=40,h=40)
4148:             par_oCnt.AddObject("SelTudo", "CommandButton")
4149:             WITH par_oCnt.SelTudo
4150:                 .Caption         = ""
4151:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
4152:                 .PicturePosition = 4
4153:                 .Top             = 371
4154:                 .Left            = 191
4155:                 .Width           = 40
4156:                 .Height          = 40
4157:                 .ToolTipText     = "Selecionar Todos"
4158:                 .Themes          = .T.
4159:                 .SpecialEffect   = 0
4160:                 .MousePointer    = 15
4161:                 .Visible         = .T.
4162:             ENDWITH
4163:             BINDEVENT(par_oCnt.SelTudo, "Click", THIS, "BtnSelTudoClick")
4164: 
4165:             *-- apaga (top=411,left=191,w=40,h=40)
4166:             par_oCnt.AddObject("apaga", "CommandButton")
4167:             WITH par_oCnt.apaga
4168:                 .Caption         = ""
4169:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4170:                 .PicturePosition = 4
4171:                 .Top             = 411
4172:                 .Left            = 191
4173:                 .Width           = 40
4174:                 .Height          = 40
4175:                 .ToolTipText     = "Desmarcar Todos"
4176:                 .Themes          = .T.
4177:                 .SpecialEffect   = 0
4178:                 .MousePointer    = 15
4179:                 .Visible         = .T.
4180:             ENDWITH
4181:             BINDEVENT(par_oCnt.apaga, "Click", THIS, "BtnApagaClick")
4182: 
4183:             *-- Visualizar (top=370,left=476,w=75,h=75)
4184:             par_oCnt.AddObject("Visualizar", "CommandButton")
4185:             WITH par_oCnt.Visualizar
4186:                 .Caption         = "Visualizar"
4187:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
4188:                 .PicturePosition = 13
4189:                 .Top             = 370
4190:                 .Left            = 476
4191:                 .Width           = 75
4192:                 .Height          = 75
4193:                 .FontName        = "Tahoma"
4194:                 .FontSize        = 8
4195:                 .Themes          = .T.
4196:                 .SpecialEffect   = 0
4197:                 .MousePointer    = 15
4198:                 .WordWrap        = .T.
4199:                 .Visible         = .T.
4200:             ENDWITH
4201:             BINDEVENT(par_oCnt.Visualizar, "Click", THIS, "BtnVisualizarBalancoClick")
4202: 
4203:             *-- Imprimir (top=370,left=551,w=75,h=75)
4204:             par_oCnt.AddObject("Imprimir", "CommandButton")
4205:             WITH par_oCnt.Imprimir
4206:                 .Caption         = "Imprimir"
4207:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
4208:                 .PicturePosition = 13
4209:                 .Top             = 370
4210:                 .Left            = 551
4211:                 .Width           = 75
4212:                 .Height          = 75
4213:                 .FontName        = "Tahoma"
4214:                 .FontSize        = 8
4215:                 .Themes          = .T.
4216:                 .SpecialEffect   = 0
4217:                 .MousePointer    = 15
4218:                 .WordWrap        = .T.
4219:                 .Visible         = .T.
4220:             ENDWITH
4221:             BINDEVENT(par_oCnt.Imprimir, "Click", THIS, "BtnImprimirBalancoClick")
4222: 
4223:             *-- Pesagem (top=294,left=892,w=75,h=75) - inicia oculto
4224:             par_oCnt.AddObject("Pesagem", "CommandButton")
4225:             WITH par_oCnt.Pesagem
4226:                 .Caption         = "Pesagem"
4227:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
4228:                 .PicturePosition = 13
4229:                 .Top             = 294
4230:                 .Left            = 892
4231:                 .Width           = 75
4232:                 .Height          = 75
4233:                 .FontName        = "Tahoma"
4234:                 .FontSize        = 8
4235:                 .Themes          = .T.
4236:                 .SpecialEffect   = 0
4237:                 .MousePointer    = 15
4238:                 .WordWrap        = .T.
4239:                 .Visible         = .F.
4240:             ENDWITH
4241:             BINDEVENT(par_oCnt.Pesagem, "Click", THIS, "BtnPesagemClick")
4242: 
4243:             *-- Label3: "Movimentacoes" (top=352,left=652,w=76,h=15)
4244:             par_oCnt.AddObject("lbl_4c_Label3", "Label")
4245:             WITH par_oCnt.lbl_4c_Label3
4246:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
4247:                 .Top       = 352
4248:                 .Left      = 652
4249:                 .Width     = 76
4250:                 .Height    = 15
4251:                 .FontName  = "Tahoma"
4252:                 .FontSize  = 8
4253:                 .BackStyle = 0
4254:                 .AutoSize  = .F.
4255:                 .Visible   = .T.
4256:             ENDWITH
4257: 
4258:             *-- grdMov (top=370,left=649,w=189,h=82,2 cols)
4259:             *-- RecordSource/ColumnCount FORA de WITH (Problema 36)
4260:             par_oCnt.AddObject("grdMov", "Grid")
4261:             par_oCnt.grdMov.ColumnCount  = 2
4262:             par_oCnt.grdMov.RecordSource = ""
4263:             WITH par_oCnt.grdMov
4264:                 .Top         = 370
4265:                 .Left        = 649
4266:                 .Width       = 189
4267:                 .Height      = 82
4268:                 .GridLines   = 1
4269:                 .HeaderHeight = 20
4270:                 .FontName    = "Tahoma"
4271:                 .FontSize    = 8
4272:                 .Visible     = .T.
4273:             ENDWITH
4274:             WITH par_oCnt.grdMov.Column1
4275:                 .Header1.Caption = ""
4276:                 .Width           = 20
4277:                 .Sparse          = .F.
4278:             ENDWITH
4279:             par_oCnt.grdMov.Column1.AddObject("Check1", "CheckBox")
4280:             WITH par_oCnt.grdMov.Column1.Check1
4281:                 .Caption   = ""

*-- Linhas 4292 a 4335:
4292:                 .Header1.Caption = "Tipo Op."
4293:                 .Width           = 160
4294:             ENDWITH
4295:             BINDEVENT(par_oCnt.grdMov.Column1.Check1, "KeyPress", THIS, "GrdMovCheck1KeyPress")
4296: 
4297:             *-- Pagina pageframe interno (top=5,left=462,w=510,h=275,3 paginas)
4298:             par_oCnt.AddObject("Pagina", "PageFrame")
4299:             WITH par_oCnt.Pagina
4300:                 .Top       = 5
4301:                 .Left      = 462
4302:                 .Width     = 510
4303:                 .Height    = 275
4304:                 .PageCount = 3
4305:                 .Tabs      = .T.
4306:                 .FontName  = "Tahoma"
4307:                 .FontSize  = 8
4308:                 .Visible   = .T.
4309:             ENDWITH
4310:             par_oCnt.Pagina.Pages(1).Caption = "Entradas"
4311:             par_oCnt.Pagina.Pages(2).Caption = "Sa" + CHR(237) + "das"
4312:             par_oCnt.Pagina.Pages(3).Caption = "Resumo"
4313: 
4314:             *-- GradeEntradas (Pagina.Page1 top=7,left=10,w=484,h=207,5 cols)
4315:             par_oCnt.Pagina.Pages(1).AddObject("GradeEntradas", "Grid")
4316:             par_oCnt.Pagina.Pages(1).GradeEntradas.ColumnCount  = 5
4317:             par_oCnt.Pagina.Pages(1).GradeEntradas.RecordSource = "TmpOpera"
4318:             loc_oGrd = par_oCnt.Pagina.Pages(1).GradeEntradas
4319:             WITH loc_oGrd
4320:                 .Top          = 7
4321:                 .Left         = 10
4322:                 .Width        = 484
4323:                 .Height       = 207
4324:                 .ReadOnly     = .T.
4325:                 .GridLines    = 1
4326:                 .HeaderHeight = 20
4327:                 .FontName     = "Tahoma"
4328:                 .FontSize     = 8
4329:                 .Visible      = .T.
4330:             ENDWITH
4331:             WITH loc_oGrd.Column1
4332:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4333:                 .ControlSource   = "TmpOpera.TpOps"
4334:                 .Width           = 120
4335:             ENDWITH

*-- Linhas 4353 a 4397:
4353:                 .ControlSource   = "TmpOpera.PesoBEnts"
4354:                 .Width           = 80
4355:             ENDWITH
4356:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEntradasAfterRowColChange")
4357:             BINDEVENT(par_oCnt.Pagina.Pages(1), "Activate", THIS, "PaginaResultadoPage1Activate")
4358: 
4359:             *-- Get_TpOperacao em Page1 (top=220,left=10,w=484,h=23)
4360:             par_oCnt.Pagina.Pages(1).AddObject("Get_TpOperacao", "TextBox")
4361:             WITH par_oCnt.Pagina.Pages(1).Get_TpOperacao
4362:                 .Value         = ""
4363:                 .Top           = 220
4364:                 .Left          = 10
4365:                 .Width         = 484
4366:                 .Height        = 23
4367:                 .ReadOnly      = .T.
4368:                 .FontName      = "Tahoma"
4369:                 .FontSize      = 8
4370:                 .BackColor     = RGB(240, 240, 240)
4371:                 .BorderStyle   = 1
4372:                 .SpecialEffect = 0
4373:                 .Visible       = .T.
4374:             ENDWITH
4375: 
4376:             *-- GradeSaidas (Pagina.Page2 top=7,left=10,w=484,h=207,5 cols)
4377:             par_oCnt.Pagina.Pages(2).AddObject("GradeSaidas", "Grid")
4378:             par_oCnt.Pagina.Pages(2).GradeSaidas.ColumnCount  = 5
4379:             par_oCnt.Pagina.Pages(2).GradeSaidas.RecordSource = "TmpOpera"
4380:             loc_oGrd = par_oCnt.Pagina.Pages(2).GradeSaidas
4381:             WITH loc_oGrd
4382:                 .Top          = 7
4383:                 .Left         = 10
4384:                 .Width        = 484
4385:                 .Height       = 207
4386:                 .ReadOnly     = .T.
4387:                 .GridLines    = 1
4388:                 .HeaderHeight = 20
4389:                 .FontName     = "Tahoma"
4390:                 .FontSize     = 8
4391:                 .Visible      = .T.
4392:             ENDWITH
4393:             WITH loc_oGrd.Column1
4394:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4395:                 .ControlSource   = "TmpOpera.TpOps"
4396:                 .Width           = 120
4397:             ENDWITH

*-- Linhas 4415 a 4459:
4415:                 .ControlSource   = "TmpOpera.PesoBSais"
4416:                 .Width           = 80
4417:             ENDWITH
4418:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeSaidasAfterRowColChange")
4419:             BINDEVENT(par_oCnt.Pagina.Pages(2), "Activate", THIS, "PaginaResultadoPage2Activate")
4420: 
4421:             *-- Get_TpOperacao em Page2 (top=220,left=10,w=484,h=23)
4422:             par_oCnt.Pagina.Pages(2).AddObject("Get_TpOperacao", "TextBox")
4423:             WITH par_oCnt.Pagina.Pages(2).Get_TpOperacao
4424:                 .Value         = ""
4425:                 .Top           = 220
4426:                 .Left          = 10
4427:                 .Width         = 484
4428:                 .Height        = 23
4429:                 .ReadOnly      = .T.
4430:                 .FontName      = "Tahoma"
4431:                 .FontSize      = 8
4432:                 .BackColor     = RGB(240, 240, 240)
4433:                 .BorderStyle   = 1
4434:                 .SpecialEffect = 0
4435:                 .Visible       = .T.
4436:             ENDWITH
4437: 
4438:             *-- GradeResumo (Pagina.Page3 top=7,left=10,w=484,h=241,4 cols)
4439:             par_oCnt.Pagina.Pages(3).AddObject("GradeResumo", "Grid")
4440:             par_oCnt.Pagina.Pages(3).GradeResumo.ColumnCount  = 4
4441:             par_oCnt.Pagina.Pages(3).GradeResumo.RecordSource = "TmpResFas"
4442:             loc_oGrd = par_oCnt.Pagina.Pages(3).GradeResumo
4443:             WITH loc_oGrd
4444:                 .Top          = 7
4445:                 .Left         = 10
4446:                 .Width        = 484
4447:                 .Height       = 241
4448:                 .ReadOnly     = .T.
4449:                 .GridLines    = 1
4450:                 .HeaderHeight = 20
4451:                 .FontName     = "Tahoma"
4452:                 .FontSize     = 8
4453:                 .Visible      = .T.
4454:             ENDWITH
4455:             WITH loc_oGrd.Column1
4456:                 .Header1.Caption = "Fases"
4457:                 .ControlSource   = "TmpResFas.Fases"
4458:                 .Width           = 120
4459:             ENDWITH

*-- Linhas 4471 a 4613:
4471:                 .Header1.Caption = "Pesos"
4472:                 .ControlSource   = "TmpResFas.Pesos"
4473:                 .Width           = 120
4474:             ENDWITH
4475: 
4476:             *-- cnt_4c_Conversao (top=292,left=192,w=248,h=66) - inicia oculto
4477:             par_oCnt.AddObject("cnt_4c_Conversao", "Container")
4478:             WITH par_oCnt.cnt_4c_Conversao
4479:                 .Top         = 292
4480:                 .Left        = 192
4481:                 .Width       = 248
4482:                 .Height      = 66
4483:                 .BackColor   = RGB(240, 240, 240)
4484:                 .BackStyle   = 1
4485:                 .Visible     = .F.
4486:             ENDWITH
4487:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_TituloConv", "Label")
4488:             WITH par_oCnt.cnt_4c_Conversao.lbl_4c_TituloConv
4489:                 .Caption   = "Convers" + CHR(227) + "o"
4490:                 .Top       = 3
4491:                 .Left      = 13
4492:                 .Width     = 62
4493:                 .Height    = 15
4494:                 .FontName  = "Tahoma"
4495:                 .FontSize  = 8
4496:                 .FontBold  = .T.
4497:                 .BackStyle = 0
4498:                 .AutoSize  = .F.
4499:                 .Visible   = .T.
4500:             ENDWITH
4501:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_DataLabel", "Label")
4502:             WITH par_oCnt.cnt_4c_Conversao.lbl_4c_DataLabel
4503:                 .Caption   = "Data:"
4504:                 .Top       = 33
4505:                 .Left      = 4
4506:                 .Width     = 30
4507:                 .Height    = 15
4508:                 .FontName  = "Tahoma"
4509:                 .FontSize  = 8
4510:                 .BackStyle = 0
4511:                 .AutoSize  = .F.
4512:                 .Visible   = .T.
4513:             ENDWITH
4514:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_MoedaLabel", "Label")
4515:             WITH par_oCnt.cnt_4c_Conversao.lbl_4c_MoedaLabel
4516:                 .Caption   = "Moeda:"
4517:                 .Top       = 33
4518:                 .Left      = 122
4519:                 .Width     = 40
4520:                 .Height    = 15
4521:                 .FontName  = "Tahoma"
4522:                 .FontSize  = 8
4523:                 .BackStyle = 0
4524:                 .AutoSize  = .F.
4525:                 .Visible   = .T.
4526:             ENDWITH
4527:             par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_DataCc", "TextBox")
4528:             WITH par_oCnt.cnt_4c_Conversao.txt_4c_DataCc
4529:                 .Value         = DATE()
4530:                 .Top           = 28
4531:                 .Left          = 36
4532:                 .Width         = 80
4533:                 .Height        = 25
4534:                 .Format        = "K"
4535:                 .FontName      = "Tahoma"
4536:                 .FontSize      = 8
4537:                 .BackColor     = RGB(255, 255, 255)
4538:                 .BorderStyle   = 1
4539:                 .SpecialEffect = 0
4540:                 .Visible       = .T.
4541:             ENDWITH
4542:             par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_MOEDA", "TextBox")
4543:             WITH par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA
4544:                 .Value         = ""
4545:                 .Top           = 28
4546:                 .Left          = 166
4547:                 .Width         = 31
4548:                 .Height        = 25
4549:                 .MaxLength     = 10
4550:                 .FontName      = "Tahoma"
4551:                 .FontSize      = 8
4552:                 .BackColor     = RGB(255, 255, 255)
4553:                 .BorderStyle   = 1
4554:                 .SpecialEffect = 0
4555:                 .Visible       = .T.
4556:             ENDWITH
4557:             BINDEVENT(par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA, "KeyPress", THIS, "MoedaLostFocus")
4558:             par_oCnt.cnt_4c_Conversao.AddObject("cmd_4c_Cotacao", "CommandButton")
4559:             WITH par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao
4560:                 .Caption         = ""
4561:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_26.jpg"
4562:                 .PicturePosition = 4
4563:                 .Top             = 20
4564:                 .Left            = 202
4565:                 .Width           = 40
4566:                 .Height          = 40
4567:                 .ToolTipText     = "Cota" + CHR(231) + CHR(227) + "o"
4568:                 .Themes          = .T.
4569:                 .SpecialEffect   = 0
4570:                 .MousePointer    = 15
4571:                 .Visible         = .T.
4572:             ENDWITH
4573:             BINDEVENT(par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao, "Click", THIS, "CotacaoClick")
4574: 
4575:             *-- GradeMat (top=46,left=6,w=178,h=409,3 cols)
4576:             *-- RecordSource/ColumnCount FORA de WITH (Problema 36)
4577:             par_oCnt.AddObject("GradeMat", "Grid")
4578:             par_oCnt.GradeMat.ColumnCount  = 3
4579:             par_oCnt.GradeMat.RecordSource = "TmpResumo"
4580:             loc_oGrd = par_oCnt.GradeMat
4581:             WITH loc_oGrd
4582:                 .Top          = 46
4583:                 .Left         = 6
4584:                 .Width        = 178
4585:                 .Height       = 409
4586:                 .ReadOnly     = .F.
4587:                 .GridLines    = 1
4588:                 .HeaderHeight = 20
4589:                 .FontName     = "Tahoma"
4590:                 .FontSize     = 8
4591:                 .Visible      = .T.
4592:             ENDWITH
4593:             WITH loc_oGrd.Column1
4594:                 .Header1.Caption = "Material"
4595:                 .ControlSource   = "TmpResumo.CMats"
4596:                 .Width           = 110
4597:                 .ReadOnly        = .T.
4598:             ENDWITH
4599:             WITH loc_oGrd.Column2
4600:                 .Header1.Caption = ""
4601:                 .ControlSource   = "TmpResumo.Flag3"
4602:                 .Width           = 32
4603:                 .Sparse          = .F.
4604:             ENDWITH
4605:             loc_oGrd.Column2.AddObject("Check1", "CheckBox")
4606:             WITH loc_oGrd.Column2.Check1
4607:                 .Caption   = ""
4608:                 .Alignment = 0
4609:                 .ReadOnly  = .F.
4610:                 .Visible   = .T.
4611:                 .Top       = 9
4612:                 .Left      = 2
4613:                 .Height    = 17

*-- Linhas 4633 a 4940:
4633:                 .Width     = 22
4634:             ENDWITH
4635:             loc_oGrd.Column3.CurrentControl = "Check1"
4636:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeMatAfterRowColChange")
4637:             BINDEVENT(loc_oGrd.Column2.Check1, "InteractiveChange", THIS, "GradeMatCheck1Change")
4638: 
4639:             loc_lResultado = .T.
4640:         CATCH TO loc_oErro
4641:             MsgErro("Erro em ConfigurarResultado:" + CHR(13) + loc_oErro.Message + ;
4642:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
4643:         ENDTRY
4644:         RETURN loc_lResultado
4645:     ENDPROC
4646: 
4647:     *==========================================================================
4648:     * GrupoKeyPress / GrupoDblClick / AbrirLookupGrupo
4649:     * Lookup de Grupo de Balanco (TmpGccr pre-carregado)
4650:     *==========================================================================
4651:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4652:         IF INLIST(par_nKeyCode, 13, 9, 115)
4653:             THIS.AbrirLookupGrupo()
4654:             NODEFAULT
4655:         ENDIF
4656:     ENDPROC
4657: 
4658:     PROCEDURE GrupoDblClick()
4659:         THIS.AbrirLookupGrupo()
4660:     ENDPROC
4661: 
4662:     PROTECTED PROCEDURE AbrirLookupGrupo()
4663:         LOCAL loc_oPagina, loc_oBusca
4664:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4665:         TRY
4666:             IF !USED("TmpGccr")
4667:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4668:             ELSE
4669:                 SELECT TmpGccr
4670:                 GO TOP
4671:                 SET ORDER TO BalCodigo
4672:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4673:                 IF VARTYPE(loc_oBusca) = "O"
4674:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4675:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4676:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4677:                     loc_oBusca.Show()
4678:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4679:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4680:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4681:                         ENDIF
4682:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4683:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4684:                         ENDIF
4685:                     ENDIF
4686:                     loc_oBusca.Release()
4687:                     loc_oBusca = .NULL.
4688:                 ENDIF
4689:             ENDIF
4690:         CATCH TO loc_oErro
4691:             MsgErro("Erro em AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
4692:         ENDTRY
4693:     ENDPROC
4694: 
4695:     *==========================================================================
4696:     * DGrupoKeyPress / DGrupoDblClick / AbrirLookupDGrupo
4697:     * Lookup de Grupo por Descricao
4698:     *==========================================================================
4699:     PROCEDURE DGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4700:         IF INLIST(par_nKeyCode, 13, 9, 115)
4701:             THIS.AbrirLookupDGrupo()
4702:             NODEFAULT
4703:         ENDIF
4704:     ENDPROC
4705: 
4706:     PROCEDURE DGrupoDblClick()
4707:         THIS.AbrirLookupDGrupo()
4708:     ENDPROC
4709: 
4710:     PROTECTED PROCEDURE AbrirLookupDGrupo()
4711:         LOCAL loc_oPagina, loc_oBusca
4712:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4713:         TRY
4714:             IF !USED("TmpGccr")
4715:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4716:             ELSE
4717:                 SELECT TmpGccr
4718:                 SET ORDER TO BalDescrs
4719:                 GO TOP
4720:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4721:                 IF VARTYPE(loc_oBusca) = "O"
4722:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4723:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4724:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4725:                     loc_oBusca.Show()
4726:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4727:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4728:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4729:                         ENDIF
4730:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4731:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4732:                         ENDIF
4733:                     ENDIF
4734:                     loc_oBusca.Release()
4735:                     loc_oBusca = .NULL.
4736:                 ENDIF
4737:                 SELECT TmpGccr
4738:                 SET ORDER TO BalCodigo
4739:             ENDIF
4740:         CATCH TO loc_oErro
4741:             MsgErro("Erro em AbrirLookupDGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
4742:         ENDTRY
4743:     ENDPROC
4744: 
4745:     *==========================================================================
4746:     * ContaKeyPress / ContaDblClick / AbrirLookupConta
4747:     * Lookup de Conta de Balanco (TmpCli pre-carregado)
4748:     *==========================================================================
4749:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4750:         IF INLIST(par_nKeyCode, 13, 9, 115)
4751:             THIS.AbrirLookupConta()
4752:             NODEFAULT
4753:         ENDIF
4754:     ENDPROC
4755: 
4756:     PROCEDURE ContaDblClick()
4757:         THIS.AbrirLookupConta()
4758:     ENDPROC
4759: 
4760:     PROTECTED PROCEDURE AbrirLookupConta()
4761:         LOCAL loc_oPagina, loc_oBusca
4762:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4763:         TRY
4764:             IF !USED("TmpCli")
4765:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4766:             ELSE
4767:                 SELECT TmpCli
4768:                 GO TOP
4769:                 SET ORDER TO BalCodigo
4770:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4771:                 IF VARTYPE(loc_oBusca) = "O"
4772:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4773:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4774:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4775:                     loc_oBusca.Show()
4776:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4777:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4778:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4779:                         ENDIF
4780:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4781:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4782:                         ENDIF
4783:                     ENDIF
4784:                     loc_oBusca.Release()
4785:                     loc_oBusca = .NULL.
4786:                 ENDIF
4787:             ENDIF
4788:         CATCH TO loc_oErro
4789:             MsgErro("Erro em AbrirLookupConta:" + CHR(13) + loc_oErro.Message, "FormFea")
4790:         ENDTRY
4791:     ENDPROC
4792: 
4793:     *==========================================================================
4794:     * DContaKeyPress / DContaDblClick / AbrirLookupDConta
4795:     * Lookup de Conta por Nome
4796:     *==========================================================================
4797:     PROCEDURE DContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4798:         IF INLIST(par_nKeyCode, 13, 9, 115)
4799:             THIS.AbrirLookupDConta()
4800:             NODEFAULT
4801:         ENDIF
4802:     ENDPROC
4803: 
4804:     PROCEDURE DContaDblClick()
4805:         THIS.AbrirLookupDConta()
4806:     ENDPROC
4807: 
4808:     PROTECTED PROCEDURE AbrirLookupDConta()
4809:         LOCAL loc_oPagina, loc_oBusca
4810:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4811:         TRY
4812:             IF !USED("TmpCli")
4813:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4814:             ELSE
4815:                 SELECT TmpCli
4816:                 SET ORDER TO BalNome
4817:                 GO TOP
4818:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4819:                 IF VARTYPE(loc_oBusca) = "O"
4820:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4821:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4822:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4823:                     loc_oBusca.Show()
4824:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4825:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4826:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4827:                         ENDIF
4828:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4829:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4830:                         ENDIF
4831:                     ENDIF
4832:                     loc_oBusca.Release()
4833:                     loc_oBusca = .NULL.
4834:                 ENDIF
4835:                 SELECT TmpCli
4836:                 SET ORDER TO BalCodigo
4837:             ENDIF
4838:         CATCH TO loc_oErro
4839:             MsgErro("Erro em AbrirLookupDConta:" + CHR(13) + loc_oErro.Message, "FormFea")
4840:         ENDTRY
4841:     ENDPROC
4842: 
4843:     *==========================================================================
4844:     * MoedaLostFocus - Lookup de Moeda (SigCdMoe) ao sair do campo
4845:     * PUBLIC: BINDEVENT em txt_4c_MOEDA.LostFocus
4846:     *==========================================================================
4847:     PROCEDURE MoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
4848:         LOCAL loc_oCnt, loc_cMoeda, loc_oBusca
4849:         TRY
4850:             loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.cnt_4c_Conversao
4851:             loc_cMoeda = ALLTRIM(NVL(loc_oCnt.txt_4c_MOEDA.Value, ""))
4852: 
4853:             IF EMPTY(loc_cMoeda)
4854:                 loc_oCnt.txt_4c_MOEDA.Value = ""
4855:             ELSE
4856:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
4857:                     "crListaMoe", "CMoes", loc_cMoeda, "Sele" + CHR(231) + CHR(227) + "o")
4858:                 IF VARTYPE(loc_oBusca) = "O"
4859:                     IF !loc_oBusca.this_lSelecionou
4860:                         loc_oBusca.mAddColuna("CMoes", "", "Moeda")
4861:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
4862:                         loc_oBusca.Show()
4863:                     ENDIF
4864:                     IF loc_oBusca.this_lSelecionou AND USED("crListaMoe") AND !EOF("crListaMoe")
4865:                         loc_oCnt.txt_4c_MOEDA.Value = ALLTRIM(crListaMoe.CMoes)
4866:                     ELSE
4867:                         loc_oCnt.txt_4c_MOEDA.Value = ""
4868:                     ENDIF
4869:                     IF USED("crListaMoe")
4870:                         USE IN crListaMoe
4871:                     ENDIF
4872:                     loc_oBusca.Release()
4873:                     loc_oBusca = .NULL.
4874:                 ENDIF
4875:             ENDIF
4876:         CATCH TO loc_oErro
4877:             MsgErro("Erro em MoedaLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
4878:         ENDTRY
4879:     ENDPROC
4880: 
4881:     *==========================================================================
4882:     * CotacaoClick - Abre form de cotacao de moeda
4883:     * PUBLIC: BINDEVENT em cmd_4c_Cotacao.Click
4884:     *==========================================================================
4885:     PROCEDURE CotacaoClick()
4886:         TRY
4887:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
4888:                 DO FORM SigOpCot WITH THISFORM, crSigCdFcx.Datas
4889:             ENDIF
4890:         CATCH TO loc_oErro
4891:             MsgErro("Erro em CotacaoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
4892:         ENDTRY
4893:     ENDPROC
4894: 
4895:     *==========================================================================
4896:     * GradeMatAfterRowColChange - Atualiza campos de resumo ao mudar linha do GradeMat
4897:     * Equivale ao GradeMat.AfterRowColChange do legado
4898:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
4899:     *==========================================================================
4900:     PROCEDURE GradeMatAfterRowColChange(par_nColIndex)
4901:         LOCAL loc_oCnt, loc_oPage1, loc_oPage2
4902:         TRY
4903:             IF USED("TmpResumo") AND !EOF("TmpResumo")
4904:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
4905:                 SELECT TmpResumo
4906: 
4907:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
4908:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
4909:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
4910:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
4911:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
4912:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
4913:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
4914:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
4915:                 loc_oCnt.Get_Pfalha.Value    = TmpResumo.PfTrabs
4916: 
4917:                 *-- Atualizar GradeEntradas com filtro do material corrente
4918:                 IF USED("TmpOpera")
4919:                     SELECT TmpOpera
4920:                     SET ORDER TO GrConMatTp
4921:                     SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
4922:                     GO TOP
4923:                 ENDIF
4924: 
4925:                 IF PEMSTATUS(loc_oCnt, "Pagina", 5)
4926:                     loc_oPage1 = loc_oCnt.Pagina.Pages(1)
4927:                     IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
4928:                         loc_oPage1.GradeEntradas.Refresh()
4929:                         loc_oPage1.GradeEntradas.AfterRowColChange(1)
4930:                     ENDIF
4931:                     loc_oPage2 = loc_oCnt.Pagina.Pages(2)
4932:                     IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
4933:                         loc_oPage2.GradeSaidas.Refresh()
4934:                     ENDIF
4935: 
4936:                     *-- Atualizar GradeResumo com filtro do material corrente
4937:                     IF USED("TmpResFas")
4938:                         SELECT TmpResFas
4939:                         SET KEY TO TmpResumo.CMats
4940:                         GO TOP

*-- Linhas 4960 a 5262:
4960: 
4961:     *==========================================================================
4962:     * GradeEntradasAfterRowColChange - Atualiza Get_TpOperacao na Page1
4963:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
4964:     *==========================================================================
4965:     PROCEDURE GradeEntradasAfterRowColChange(par_nColIndex)
4966:         LOCAL loc_oPage1
4967:         TRY
4968:             IF USED("TmpOpera") AND !EOF("TmpOpera")
4969:                 loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
4970:                 IF PEMSTATUS(loc_oPage1, "Get_TpOperacao", 5)
4971:                     loc_oPage1.Get_TpOperacao.Value = ALLTRIM(NVL(TmpOpera.TpOps, ""))
4972:                     loc_oPage1.Get_TpOperacao.Refresh()
4973:                 ENDIF
4974:             ENDIF
4975:         CATCH TO loc_oErro
4976:             MsgErro("Erro em GradeEntradasAfterRowColChange:" + CHR(13) + loc_oErro.Message, "FormFea")
4977:         ENDTRY
4978:     ENDPROC
4979: 
4980:     *==========================================================================
4981:     * GradeSaidasAfterRowColChange - Atualiza Get_TpOperacao na Page2
4982:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
4983:     *==========================================================================
4984:     PROCEDURE GradeSaidasAfterRowColChange(par_nColIndex)
4985:         LOCAL loc_oPage2
4986:         TRY
4987:             IF USED("TmpOpera") AND !EOF("TmpOpera")
4988:                 loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
4989:                 IF PEMSTATUS(loc_oPage2, "Get_TpOperacao", 5)
4990:                     loc_oPage2.Get_TpOperacao.Value = ALLTRIM(NVL(TmpOpera.TpOps, ""))
4991:                     loc_oPage2.Get_TpOperacao.Refresh()
4992:                 ENDIF
4993:             ENDIF
4994:         CATCH TO loc_oErro
4995:             MsgErro("Erro em GradeSaidasAfterRowColChange:" + CHR(13) + loc_oErro.Message, "FormFea")
4996:         ENDTRY
4997:     ENDPROC
4998: 
4999:     *==========================================================================
5000:     * GradeMatCheck1Change - Valida Check1 (Flag3) ao mudar no GradeMat
5001:     * Impedimentos: conta sem acerto (Flag2=.F.) ou saldo zero
5002:     * PUBLIC: BINDEVENT exige metodo publico
5003:     *==========================================================================
5004:     PROCEDURE GradeMatCheck1Change()
5005:         LOCAL loc_oCnt
5006:         TRY
5007:             IF USED("TmpResumo") AND !EOF("TmpResumo")
5008:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5009:                 IF !TmpResumo.Flag2
5010:                     MsgAviso("Esta Conta N" + CHR(227) + "o Permite Acerto de Balan" + CHR(231) + "o...")
5011:                     SELECT TmpResumo
5012:                     REPLACE Flag3 WITH .F.
5013:                     IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5014:                         loc_oCnt.GradeMat.Refresh()
5015:                     ENDIF
5016:                 ELSE
5017:                     IF TmpResumo.Saldof = 0 AND TmpResumo.Flag3
5018:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Diferen" + CHR(231) + CHR(97) + "  Para Acerto...")
5019:                         SELECT TmpResumo
5020:                         REPLACE Flag3 WITH .F.
5021:                         IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5022:                             loc_oCnt.GradeMat.Refresh()
5023:                         ENDIF
5024:                     ENDIF
5025:                 ENDIF
5026:             ENDIF
5027:         CATCH TO loc_oErro
5028:             MsgErro("Erro em GradeMatCheck1Change:" + CHR(13) + loc_oErro.Message, "FormFea")
5029:         ENDTRY
5030:     ENDPROC
5031: 
5032:     *==========================================================================
5033:     * chkPerdasClick - Desabilita outros checkboxes quando Perdas marcado
5034:     * PUBLIC: BINDEVENT exige metodo publico
5035:     *==========================================================================
5036:     PROCEDURE chkPerdasClick()
5037:         LOCAL loc_oCnt
5038:         TRY
5039:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5040:             IF loc_oCnt.chkPerdas.Value = 1
5041:                 loc_oCnt.Resumido.Value  = 0
5042:                 loc_oCnt.Historico.Value = 0
5043:                 loc_oCnt.chkServ.Value   = 0
5044:                 loc_oCnt.Analitico.Value = 0
5045:                 loc_oCnt.porMov.Value    = 0
5046:                 loc_oCnt.MovAgru.Value   = 0
5047:                 loc_oCnt.porenv.Value    = 0
5048:                 loc_oCnt.pormat.Value    = 0
5049:                 loc_oCnt.MovLote.Value   = 0
5050:             ENDIF
5051:         CATCH TO loc_oErro
5052:             MsgErro("Erro em chkPerdasClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5053:         ENDTRY
5054:     ENDPROC
5055: 
5056:     *==========================================================================
5057:     * BtnPesagemClick - Ativa modo de entrada de pesagem fisica
5058:     * PUBLIC: BINDEVENT exige metodo publico
5059:     *==========================================================================
5060:     PROCEDURE BtnPesagemClick()
5061:         LOCAL loc_oCnt
5062:         TRY
5063:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5064:             THIS.this_lEntraPeso = .T.
5065:             loc_oCnt.Get_Pesagem.ReadOnly = .F.
5066:             loc_oCnt.Get_Pesagem.SetFocus()
5067:         CATCH TO loc_oErro
5068:             MsgErro("Erro em BtnPesagemClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5069:         ENDTRY
5070:     ENDPROC
5071: 
5072:     *==========================================================================
5073:     * PesagemLostFocus - Recalcula saldos ao informar pesagem fisica
5074:     * Disparado por Valid do Get_Pesagem (equivalente ao legado)
5075:     * PUBLIC: BINDEVENT exige metodo publico
5076:     *==========================================================================
5077:     PROCEDURE PesagemLostFocus()
5078:         LOCAL loc_oCnt, loc_nPesagem
5079:         TRY
5080:             THIS.this_lEntraPeso = .F.
5081:             IF USED("TmpResumo") AND !EOF("TmpResumo")
5082:                 loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5083:                 loc_nPesagem = NVL(loc_oCnt.Get_Pesagem.Value, 0)
5084:                 SELECT TmpResumo
5085:                 REPLACE Pesagem WITH loc_nPesagem, ;
5086:                         Saldof  WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem - TmpResumo.FAdmin, ;
5087:                         FReal   WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem
5088:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
5089:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
5090:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
5091:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
5092:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
5093:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
5094:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
5095:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
5096:                 loc_oCnt.Get_Pesagem.ReadOnly = .T.
5097:             ENDIF
5098:         CATCH TO loc_oErro
5099:             MsgErro("Erro em PesagemLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
5100:         ENDTRY
5101:     ENDPROC
5102: 
5103:     *==========================================================================
5104:     * BtnSelTudoClick - Marca todos os materiais (Flag3=.T.) no GradeMat
5105:     * PUBLIC: BINDEVENT exige metodo publico
5106:     *==========================================================================
5107:     PROCEDURE BtnSelTudoClick()
5108:         TRY
5109:             IF USED("TmpResumo")
5110:                 SELECT TmpResumo
5111:                 REPLACE ALL Flag3 WITH .T.
5112:                 GO TOP
5113:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5114:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5115:                 ENDIF
5116:             ENDIF
5117:         CATCH TO loc_oErro
5118:             MsgErro("Erro em BtnSelTudoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5119:         ENDTRY
5120:     ENDPROC
5121: 
5122:     *==========================================================================
5123:     * BtnApagaClick - Desmarca todos os materiais (Flag3=.F.) no GradeMat
5124:     * PUBLIC: BINDEVENT exige metodo publico
5125:     *==========================================================================
5126:     PROCEDURE BtnApagaClick()
5127:         TRY
5128:             IF USED("TmpResumo")
5129:                 SELECT TmpResumo
5130:                 REPLACE ALL Flag3 WITH .F.
5131:                 GO TOP
5132:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5133:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5134:                 ENDIF
5135:             ENDIF
5136:         CATCH TO loc_oErro
5137:             MsgErro("Erro em BtnApagaClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5138:         ENDTRY
5139:     ENDPROC
5140: 
5141:     *==========================================================================
5142:     * GrdMovCheck1KeyPress - Alterna nMarcas com Enter/Espaco no grdMov
5143:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
5144:     *==========================================================================
5145:     PROCEDURE GrdMovCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
5146:         TRY
5147:             IF INLIST(m.par_nKeyCode, 13, 32)
5148:                 IF USED("crOpp") AND !EOF("crOpp")
5149:                     SELECT crOpp
5150:                     REPLACE nMarcas WITH IIF(crOpp.nMarcas = 0, 1, 0)
5151:                     KEYBOARD "{DNARROW}"
5152:                     KEYBOARD "{UPARROW}"
5153:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "grdMov", 5)
5154:                         THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.grdMov.Refresh()
5155:                     ENDIF
5156:                 ENDIF
5157:                 NODEFAULT
5158:             ENDIF
5159:         CATCH TO loc_oErro
5160:             MsgErro("Erro em GrdMovCheck1KeyPress:" + CHR(13) + loc_oErro.Message, "FormFea")
5161:         ENDTRY
5162:     ENDPROC
5163: 
5164:     *==========================================================================
5165:     * PaginaResultadoPage1Activate - Ativa aba Entradas (seta ordem TmpOpera)
5166:     * PUBLIC: BINDEVENT em Pagina.Pages(1).Activate
5167:     *==========================================================================
5168:     PROCEDURE PaginaResultadoPage1Activate()
5169:         LOCAL loc_oPage1
5170:         TRY
5171:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5172:                 SELECT TmpOpera
5173:                 SET ORDER TO GrConMatTp
5174:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5175:                 GO TOP
5176:                 loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
5177:                 IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
5178:                     loc_oPage1.GradeEntradas.Refresh()
5179:                     loc_oPage1.GradeEntradas.AfterRowColChange(1)
5180:                 ENDIF
5181:             ENDIF
5182:         CATCH TO loc_oErro
5183:             MsgErro("Erro em PaginaResultadoPage1Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5184:         ENDTRY
5185:     ENDPROC
5186: 
5187:     *==========================================================================
5188:     * PaginaResultadoPage2Activate - Ativa aba Saidas (seta ordem TmpOpera)
5189:     * PUBLIC: BINDEVENT em Pagina.Pages(2).Activate
5190:     *==========================================================================
5191:     PROCEDURE PaginaResultadoPage2Activate()
5192:         LOCAL loc_oPage2
5193:         TRY
5194:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5195:                 SELECT TmpOpera
5196:                 SET ORDER TO GrConMatTp
5197:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5198:                 GO TOP
5199:                 loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
5200:                 IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
5201:                     loc_oPage2.GradeSaidas.Refresh()
5202:                     loc_oPage2.GradeSaidas.AfterRowColChange(1)
5203:                 ENDIF
5204:             ENDIF
5205:         CATCH TO loc_oErro
5206:             MsgErro("Erro em PaginaResultadoPage2Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5207:         ENDTRY
5208:     ENDPROC
5209: 
5210:     *==========================================================================
5211:     * BtnVisualizarBalancoClick - Preview do relatorio de balanco
5212:     * PUBLIC: BINDEVENT exige metodo publico
5213:     *==========================================================================
5214:     PROCEDURE BtnVisualizarBalancoClick()
5215:         THIS.ImprimirBalanco("PREVIEW")
5216:     ENDPROC
5217: 
5218:     *==========================================================================
5219:     * BtnImprimirBalancoClick - Impressao do relatorio de balanco
5220:     * PUBLIC: BINDEVENT exige metodo publico
5221:     *==========================================================================
5222:     PROCEDURE BtnImprimirBalancoClick()
5223:         THIS.ImprimirBalanco("PRINTER_PROMPT")
5224:     ENDPROC
5225: 
5226:     *==========================================================================
5227:     * ImprimirBalanco - Executa o relatorio de Balanco de Estoque (SIGCDFEA.frx)
5228:     * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
5229:     * Cria TmpCabec, chama REPORT FORM com isolamento de locale (Pattern #117)
5230:     *==========================================================================
5231:     PROTECTED FUNCTION ImprimirBalanco(par_cModo)
5232:         LOCAL loc_lResultado, loc_cFRX, loc_cSubTitulo, loc_cEmpresa
5233:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_oCnt
5234:         loc_lResultado = .F.
5235: 
5236:         TRY
5237:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5238: 
5239:             *-- Montar cursor TmpCabec para o FRX
5240:             IF USED("TmpCabec")
5241:                 USE IN TmpCabec
5242:             ENDIF
5243:             CREATE CURSOR TmpCabec (Titulo C(100), SubTitulo C(254), Empresa C(80))
5244: 
5245:             loc_cSubTitulo = ""
5246:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
5247:                 IF USED("TmpCli")
5248:                     =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
5249:                 ENDIF
5250:                 loc_cSubTitulo = " Conta : " + ALLTRIM(NVL(crSigCdFcx.Grupos, "")) + ;
5251:                                  " / " + ALLTRIM(NVL(crSigCdFcx.Contas, ""))
5252:                 IF USED("TmpCli") AND !EOF("TmpCli")
5253:                     loc_cSubTitulo = loc_cSubTitulo + " [ " + ALLTRIM(TmpCli.RClis) + " ] "
5254:                 ENDIF
5255:                 loc_cSubTitulo = loc_cSubTitulo + CHR(13) + CHR(10) + ;
5256:                                  "Per" + CHR(237) + "odo : " + ;
5257:                                  NVL(DTOC(crSigCdFcx.Datais), "") + " a " + ;
5258:                                  NVL(DTOC(crSigCdFcx.Datas), "")
5259:             ENDIF
5260: 
5261:             loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
5262:             INSERT INTO TmpCabec (Titulo, SubTitulo, Empresa) ;

*-- Linhas 5270 a 5313:
5270:                     "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
5271:             ELSE
5272:                 IF !USED("TmpResumo") OR RECCOUNT("TmpResumo") = 0
5273:                     MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.")
5274:                 ELSE
5275:                     *-- Isolar locale para FRX legado (Pattern #117)
5276:                     loc_cPointOrig    = SET("POINT")
5277:                     loc_cSepOrig      = SET("SEPARATOR")
5278:                     loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
5279:                     SET POINT TO "."
5280:                     SET SEPARATOR TO ","
5281:                     SET REPORTBEHAVIOR 80
5282: 
5283:                     DO CASE
5284:                         CASE par_cModo == "PREVIEW"
5285:                             REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
5286:                         CASE par_cModo == "PRINTER_PROMPT"
5287:                             REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
5288:                         CASE par_cModo == "PRINTER"
5289:                             REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
5290:                     ENDCASE
5291: 
5292:                     SET POINT TO (loc_cPointOrig)
5293:                     SET SEPARATOR TO (loc_cSepOrig)
5294:                     SET REPORTBEHAVIOR (loc_nBehaviorOrig)
5295: 
5296:                     *-- Restaurar menu apos REPORT FORM PREVIEW (Erro63)
5297:                     TRY
5298:                         SET SYSMENU TO DEFAULT
5299:                         RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
5300:                         CriarMenuPrincipal()
5301:                     CATCH
5302:                     ENDTRY
5303: 
5304:                     loc_lResultado = .T.
5305:                 ENDIF
5306:             ENDIF
5307:         CATCH TO loc_oErro
5308:             MsgErro("Erro em ImprimirBalanco:" + CHR(13) + loc_oErro.Message + ;
5309:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
5310:         ENDTRY
5311: 
5312:         IF USED("TmpCabec")
5313:             USE IN TmpCabec

*-- Linhas 5319 a 5362:
5319:     *==========================================================================
5320:     * Destroy - Liberacao de recursos ao fechar o formulario
5321:     *==========================================================================
5322:     PROCEDURE Destroy()
5323:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5324:             THIS.this_oBusinessObject = .NULL.
5325:         ENDIF
5326: 
5327:         *-- Fechar cursores temporarios locais (criados pelo processamento)
5328:         LOCAL loc_aCursores(30), loc_i
5329:         loc_aCursores(1)  = "TmpResumo"
5330:         loc_aCursores(2)  = "TmpOpera"
5331:         loc_aCursores(3)  = "TmpConta"
5332:         loc_aCursores(4)  = "TmpGccr"
5333:         loc_aCursores(5)  = "TmpCli"
5334:         loc_aCursores(6)  = "TmpPro"
5335:         loc_aCursores(7)  = "TmpCot"
5336:         loc_aCursores(8)  = "TmpHist"
5337:         loc_aCursores(9)  = "TmpPrz"
5338:         loc_aCursores(10) = "TmpResFas"
5339:         loc_aCursores(11) = "CrSigCdFea"
5340:         loc_aCursores(12) = "cursor_4c_Dados"
5341:         loc_aCursores(13) = "cursor_4c_BuscaGrupo"
5342:         loc_aCursores(14) = "cursor_4c_BuscaConta"
5343:         loc_aCursores(15) = "crSigMvCab"
5344:         loc_aCursores(16) = "crSigMvItn"
5345:         loc_aCursores(17) = "crSigCdFcx"
5346:         loc_aCursores(18) = "crSigCdPac"
5347:         loc_aCursores(19) = "crSigCdPam"
5348:         loc_aCursores(20) = "crSigOpOpt"
5349:         loc_aCursores(21) = "LocalOpp"
5350:         loc_aCursores(22) = "crSigCdOpe"
5351:         loc_aCursores(23) = "TmpGccr"
5352:         loc_aCursores(24) = "LocalGru"
5353:         loc_aCursores(25) = "LocalGgrp"
5354:         loc_aCursores(26) = "CrOpp"
5355:         loc_aCursores(27) = "LocalEmp"
5356:         loc_aCursores(28) = "crDtUBal"
5357:         loc_aCursores(29) = "CrUltBal"
5358:         loc_aCursores(30) = "CrSaldoI"
5359: 
5360:         FOR loc_i = 1 TO ALEN(loc_aCursores)
5361:             IF USED(loc_aCursores(loc_i))
5362:                 USE IN (loc_aCursores(loc_i))


### BO (C:\4c\projeto\app\classes\FeaBO.prg):
*==============================================================================
* FeaBO.prg - Business Object: Fechamento de Estoque (Balanco)
* Tabela principal: SigCdFcx
* Formulario origem: SIGCDFEA.SCX (frmcadastro)
* Criado: 2026-08-02
*
* Schema SigCdFcx:
*   emps char(3), codigos numeric(6,0), grupos char(10), contas char(10),
*   datais datetime, datas datetime, cpros char(14), entradas numeric(11,3),
*   fadmins numeric(11,3), freals numeric(11,3), pesagems numeric(11,3),
*   saidas numeric(11,3), saldos numeric(11,3), usuars char(10),
*   cidchaves char(20) PK
*==============================================================================

DEFINE CLASS FeaBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdFcx (schema exato)
    *--------------------------------------------------------------------------
    this_cEmps      = ""   && emps char(3) - empresa
    this_nCodigos   = 0    && codigos numeric(6,0) - codigo negocio
    this_cGrupos    = ""   && grupos char(10)
    this_cContas    = ""   && contas char(10)
    this_dDatais    = {}   && datais datetime - data inicial
    this_dDatas     = {}   && datas datetime - data final
    this_cCpros     = ""   && cpros char(14) - codigo produto
    this_nEntradas  = 0    && entradas numeric(11,3)
    this_nFadmins   = 0    && fadmins numeric(11,3) - falha admitida
    this_nFreals    = 0    && freals numeric(11,3) - falha real
    this_nPesagems  = 0    && pesagems numeric(11,3)
    this_nSaidas    = 0    && saidas numeric(11,3)
    this_nSaldos    = 0    && saldos numeric(11,3)
    this_cUsuars    = ""   && usuars char(10)
    this_cCidChaves = ""   && cidchaves char(20) - PK

    *--------------------------------------------------------------------------
    * Propriedades de descricao (lookup - nao armazenadas na tabela)
    *--------------------------------------------------------------------------
    this_cDGrupos   = ""   && descricao do grupo (TmpGccr.Descrs)
    this_cDContas   = ""   && descricao da conta (TmpCli.RClis)

    *--------------------------------------------------------------------------
    * Propriedades de filtro de periodo (Page1/Lista)
    *--------------------------------------------------------------------------
    this_cEmpFiltro  = ""  && empresa do filtro (Get_cd_empresa)
    this_dDtInicial  = {}  && data inicial do filtro
    this_dDtFinal    = {}  && data final do filtro

    *--------------------------------------------------------------------------
    * Propriedades de estado do processo
    *--------------------------------------------------------------------------
    this_nLote      = 0    && lote de processamento (getlote - numeric 6)
    this_lFechamento = .T. && registro esta aberto para processamento
    this_lAcInserir  = .F. && acao de insercao ativa
    this_lEntraPeso  = .F. && entrada de peso via balanca

    *--------------------------------------------------------------------------
    * Propriedades de resultado (populadas apos ProcessarBalanco via TmpResumo)
    *--------------------------------------------------------------------------
    this_nSaldoi    = 0    && saldo inicial (TmpResumo.Saldoi)
    this_nQtdeEnts  = 0    && quantidade de entradas (TmpResumo.QtdeEnts)
    this_nSEntradas = 0    && saldo + entradas (calculado: Saldoi + QtdeEnts)
    this_nQtdeSais  = 0    && quantidade de saidas (TmpResumo.QtdeSais)
    this_nPesagem   = 0    && pesagem fisica (TmpResumo.Pesagem)
    this_nFReal     = 0    && falha real (TmpResumo.FReal)
    this_nFAdmin    = 0    && falha admitida (TmpResumo.FAdmin)
    this_nSaldof    = 0    && saldo final (TmpResumo.Saldof)
    this_nPfTrabs   = 0    && percentual falha/trabalhado (TmpResumo.PfTrabs)

    *--------------------------------------------------------------------------
    * Propriedades de filtros de impressao (checkboxes/opcoes do Resultado)
    *--------------------------------------------------------------------------
    this_lPerdas    = .F.  && demonstrativo de perdas (chkPerdas)
    this_lHistorico = .F.  && historico (Historico)
    this_lResumido  = .T.  && resumido - default ativo (Resumido)
    this_lAnalitico = .F.  && analitico (Analitico)
    this_lServicos  = .F.  && servicos (chkServ)
    this_lPorMov    = .F.  && por movimentacao (porMov)
    this_lPorEnv    = .F.  && por envio (porenv)
    this_lPorMat    = .F.  && por material (pormat)
    this_lMovAgru   = .F.  && movimentacao agrupada (MovAgru)
    this_lMovLote   = .F.  && movimentacao por lote (MovLote)
    this_nOrdem     = 1    && opcao de ordem do relatorio (op_ordem)

    *--------------------------------------------------------------------------
    * Propriedades de conversao de moeda (Cnt_Conversao)
    *--------------------------------------------------------------------------
    this_cMoeda     = ""   && codigo da moeda (Get_MOEDA / SigCdMoe.CMoes)
    this_dDataCc    = {}   && data de conversao (Get_DataCc)

    *--------------------------------------------------------------------------
    * Propriedades de tipo de operacao selecionada (AfterRowColChange GradeMat)
    *--------------------------------------------------------------------------
    this_cTpOperacao = ""  && tipo de operacao do grid (TmpOpera.TpOps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFcx"
            THIS.this_cCampoChave = "CidChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdFcx filtrados por empresa e periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cDtF
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpFiltro))

            IF VARTYPE(THIS.this_dDtInicial) = "D" AND !EMPTY(THIS.this_dDtInicial)
                loc_cSQL = loc_cSQL + " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF

            IF VARTYPE(THIS.this_dDtFinal) = "D" AND !EMPTY(THIS.this_dDtFinal)
                loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                loc_cDtF = LEFT(loc_cDtF, LEN(loc_cDtF) - 1) + " 23:59:59'"
                loc_cSQL = loc_cSQL + " AND a.Datas <= " + loc_cDtF
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Contas, a.Datas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao listar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por CidChaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_nCodigos   = TratarNulo(Codigos,   "N")
                THIS.this_cGrupos    = TratarNulo(Grupos,    "C")
                THIS.this_cContas    = TratarNulo(Contas,    "C")
                THIS.this_dDatais    = IIF(ISNULL(Datais),   {}, TTOD(Datais))
                THIS.this_dDatas     = IIF(ISNULL(Datas),    {}, TTOD(Datas))
                THIS.this_cCpros     = TratarNulo(Cpros,     "C")
                THIS.this_nEntradas  = TratarNulo(Entradas,  "N")
                THIS.this_nFadmins   = TratarNulo(Fadmins,   "N")
                THIS.this_nFreals    = TratarNulo(Freals,    "N")
                THIS.this_nPesagems  = TratarNulo(Pesagems,  "N")
                THIS.this_nSaidas    = TratarNulo(Saidas,    "N")
                THIS.this_nSaldos    = TratarNulo(Saldos,    "N")
                THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Gerar chave primaria unica via SQL Server
            SQLEXEC(gnConnHandle, "SELECT REPLACE(CAST(NEWID() AS VARCHAR(36)),'-','') AS chave", "cursor_4c_ChaveNova")
            IF USED("cursor_4c_ChaveNova") AND RECCOUNT("cursor_4c_ChaveNova") > 0
                SELECT cursor_4c_ChaveNova
                THIS.this_cCidChaves = LEFT(ALLTRIM(chave), 20)
                USE IN cursor_4c_ChaveNova
            ELSE
                IF USED("cursor_4c_ChaveNova")
                    USE IN cursor_4c_ChaveNova
                ENDIF
                THIS.this_cCidChaves = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa) + "FCX" + TRANSFORM(SECONDS()), 20)
            ENDIF

            THIS.this_cEmps   = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "INSERT INTO SigCdFcx" + ;
                       " (Emps, Codigos, Grupos, Contas, Datais, Datas," + ;
                       "  Cpros, Entradas, Fadmins, Freals, Pesagems," + ;
                       "  Saidas, Saldos, Usuars, CidChaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatais) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEntradas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFadmins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFreals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesagems) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaidas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaldos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdFcx SET" + ;
                       " Grupos   = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                       " Contas   = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
                       " Datais   = " + FormatarDataSQL(THIS.this_dDatais) + "," + ;
                       " Datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Cpros    = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + "," + ;
                       " Entradas = " + FormatarNumeroSQL(THIS.this_nEntradas) + "," + ;
                       " Fadmins  = " + FormatarNumeroSQL(THIS.this_nFadmins) + "," + ;
                       " Freals   = " + FormatarNumeroSQL(THIS.this_nFreals) + "," + ;
                       " Pesagems = " + FormatarNumeroSQL(THIS.this_nPesagems) + "," + ;
                       " Saidas   = " + FormatarNumeroSQL(THIS.this_nSaidas) + "," + ;
                       " Saldos   = " + FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                       " Usuars   = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdFcx e movimentos relacionados
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cEdns
        loc_lResultado = .F.

        TRY
            *-- Chave composta usada em SigMvCab/SigMvItn
            loc_cEdns = LEFT(ALLTRIM(THIS.this_cEmps), 3) + PADL(TRANSFORM(THIS.this_nCodigos), 6, "0")

            *-- Excluir itens de movimentos (SigMvItn)
            loc_cSQL    = "DELETE FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Excluir cabecalho de movimentos (SigMvCab)
                loc_cSQL    = "DELETE FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Excluir registro principal (SigCdFcx)
                    loc_cSQL    = "DELETE FROM SigCdFcx WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir Fechamento de Estoque (SigCdFcx):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir cabecalho de movimentos (SigMvCab):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens de movimentos (SigMvItn):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherFiltro - Define parametros de filtro empresa + periodo
    *--------------------------------------------------------------------------
    PROCEDURE PreencherFiltro(par_cEmp, par_dDtI, par_dDtF)
        THIS.this_cEmpFiltro = ALLTRIM(par_cEmp)
        THIS.this_dDtInicial = par_dDtI
        THIS.this_dDtFinal   = par_dDtF
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega cursor de grupos de conta corrente para lookup
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT g.Codigos, g.Descrs FROM SigCdGcr g"

            IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = loc_cSQL + " WHERE g.Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY g.Descrs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar grupos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarContas - Carrega cursor de contas/clientes para lookup (SigCdCli)
    *--------------------------------------------------------------------------
    FUNCTION BuscarContas(par_cGrupo, par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT c.Iclis, c.RClis, c.Inativas FROM SigCdCli c ORDER BY c.RClis"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaConta")
                TABLEREVERT(.T., "cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

