# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (29)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_RESULTADO, CNT_4C_CONVERSAO. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.ProcessarBalanco()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ImprimirBalanco()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH loc_oPagina.txt_4c_Data.Value define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPagina.txt_4c_Data.Value.RecordSource).
- [GRID-HEADER] Header Caption 'Cód.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Grupo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Encerramento' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Início' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Tipo Operação, Qtde, F.Adm, Falha, Base Falha, Fases, Peças, Pesos, Material, , I, Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFea.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5371 linhas total):

*-- Linhas 47 a 189:
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
87:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
88:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89:                 THIS.ConfigurarPaginaLista()
90:                 THIS.ConfigurarPaginaDados()
91: 
92:                 THIS.pgf_4c_Paginas.Visible = .T.
93:                 THIS.pgf_4c_Paginas.ActivePage = 1
94:                 THIS.this_cModoAtual           = "LISTA"
95: 
96:                 THIS.CarregarLista()
97: 
98:                 loc_lResultado = .T.
99:             ENDIF
100:         CATCH TO loc_oErro
101:             MsgErro("Erro em InicializarForm:" + CHR(13) + loc_oErro.Message, "Erro")
102:         ENDTRY
103: 
104:         RETURN loc_lResultado
105:     ENDPROC
106: 
107:     *==========================================================================
108:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
109:     * PageFrame.Top = -29 para ocultar abas (padrao frmcadastro)
110:     *==========================================================================
111:     PROTECTED PROCEDURE ConfigurarPageFrame()
112:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
113: 
114:         WITH THIS.pgf_4c_Paginas
115:             .PageCount = 2
116:             .Top       = -29
117:             .Left      = 0
118:             .Width     = THIS.Width
119:             .Height    = THIS.Height + 29
120:             .Tabs      = .F.
121:             .Visible   = .T.
122: 
123:             .Page1.Caption   = "Lista"
124:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
125:             .Page1.BackColor = RGB(255, 255, 255)
126: 
127:             .Page2.Caption   = "Dados"
128:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
129:             .Page2.BackColor = RGB(255, 255, 255)
130:         ENDWITH
131:     ENDPROC
132: 
133:     *==========================================================================
134:     * ConfigurarPaginaLista - Configura Page1 (filtros + grade de balanco)
135:     * FASE 4: cabecalho, botoes CRUD, filtro periodo, grade completa
136:     *==========================================================================
137:     PROTECTED PROCEDURE ConfigurarPaginaLista()
138:         LOCAL loc_oPagina
139:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
140: 
141:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
142:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
143: 
144:         *-- Container cabecalho escuro (cntSombra no legado)
145:         *-- Top=31 = 2 (original) + 29 (compensacao PageFrame.Top=-29)
146:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
147:         WITH loc_oPagina.cnt_4c_Cabecalho
148:             .Top         = 31
149:             .Left        = 0
150:             .Width       = THIS.Width
151:             .Height      = 80
152:             .BackColor   = RGB(100, 100, 100)
153:             .BorderWidth = 0
154:             .Visible     = .T.
155:         ENDWITH
156: 
157:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
158:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
159:             .Caption   = "Balan" + CHR(231) + "o"
160:             .Top       = 20
161:             .Left      = 12
162:             .Width     = THIS.Width
163:             .Height    = 40
164:             .FontName  = "Tahoma"
165:             .FontSize  = 16
166:             .FontBold  = .T.
167:             .ForeColor = RGB(0, 0, 0)
168:             .BackStyle = 0
169:             .AutoSize  = .F.
170:             .Visible   = .T.
171:         ENDWITH
172: 
173:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
174:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
175:             .Caption   = "Balan" + CHR(231) + "o"
176:             .Top       = 18
177:             .Left      = 10
178:             .Width     = THIS.Width
179:             .Height    = 46
180:             .FontName  = "Tahoma"
181:             .FontSize  = 16
182:             .FontBold  = .T.
183:             .ForeColor = RGB(255, 255, 255)
184:             .BackStyle = 0
185:             .AutoSize  = .F.
186:             .Visible   = .T.
187:         ENDWITH
188: 
189:         *-- Container botoes de operacao (Grupo_Op no legado)

*-- Linhas 222 a 401:
222:             .AutoSize        = .F.
223:             .Visible         = .T.
224:         ENDWITH
225:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
226: 
227:         *-- Botao Visualizar (Left=80)
228:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
229:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
230:             .Caption         = "Visualizar"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
232:             .PicturePosition = 13
233:             .Top             = 5
234:             .Left            = 80
235:             .Width           = 75
236:             .Height          = 75
237:             .FontName        = "Tahoma"
238:             .FontBold        = .T.
239:             .FontItalic      = .T.
240:             .FontSize        = 8
241:             .ForeColor       = RGB(90, 90, 90)
242:             .BackColor       = RGB(255, 255, 255)
243:             .Themes          = .F.
244:             .SpecialEffect   = 0
245:             .MousePointer    = 15
246:             .WordWrap        = .T.
247:             .AutoSize        = .F.
248:             .Visible         = .T.
249:         ENDWITH
250:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
251: 
252:         *-- Botao Alterar (Left=155)
253:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
254:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
255:             .Caption         = "Alterar"
256:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
257:             .PicturePosition = 13
258:             .Top             = 5
259:             .Left            = 155
260:             .Width           = 75
261:             .Height          = 75
262:             .FontName        = "Tahoma"
263:             .FontBold        = .T.
264:             .FontItalic      = .T.
265:             .FontSize        = 8
266:             .ForeColor       = RGB(90, 90, 90)
267:             .BackColor       = RGB(255, 255, 255)
268:             .Themes          = .F.
269:             .SpecialEffect   = 0
270:             .MousePointer    = 15
271:             .WordWrap        = .T.
272:             .AutoSize        = .F.
273:             .Visible         = .T.
274:         ENDWITH
275:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
276: 
277:         *-- Botao Excluir (Left=230)
278:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
279:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
280:             .Caption         = "Excluir"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
282:             .PicturePosition = 13
283:             .Top             = 5
284:             .Left            = 230
285:             .Width           = 75
286:             .Height          = 75
287:             .FontName        = "Tahoma"
288:             .FontBold        = .T.
289:             .FontItalic      = .T.
290:             .FontSize        = 8
291:             .ForeColor       = RGB(90, 90, 90)
292:             .BackColor       = RGB(255, 255, 255)
293:             .Themes          = .F.
294:             .SpecialEffect   = 0
295:             .MousePointer    = 15
296:             .WordWrap        = .T.
297:             .AutoSize        = .F.
298:             .Visible         = .T.
299:         ENDWITH
300:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
301: 
302:         *-- Botao Buscar (Left=305)
303:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
304:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
305:             .Caption         = "Buscar"
306:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
307:             .PicturePosition = 13
308:             .Top             = 5
309:             .Left            = 305
310:             .Width           = 75
311:             .Height          = 75
312:             .FontName        = "Tahoma"
313:             .FontBold        = .T.
314:             .FontItalic      = .T.
315:             .FontSize        = 8
316:             .ForeColor       = RGB(90, 90, 90)
317:             .BackColor       = RGB(255, 255, 255)
318:             .Themes          = .F.
319:             .SpecialEffect   = 0
320:             .MousePointer    = 15
321:             .WordWrap        = .T.
322:             .AutoSize        = .F.
323:             .Visible         = .T.
324:         ENDWITH
325:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
326: 
327:         *-- Container saida/encerrar - padrao canonico (CLAUDE.md regra #10)
328:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
329:         WITH loc_oPagina.cnt_4c_Saida
330:             .Top         = 29
331:             .Left        = 917
332:             .Width       = 90
333:             .Height      = 85
334:             .BackStyle   = 0
335:             .BorderWidth = 0
336:             .Visible     = .T.
337:         ENDWITH
338: 
339:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
340:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
341:             .Caption         = "Encerrar"
342:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
343:             .PicturePosition = 13
344:             .Top             = 5
345:             .Left            = 5
346:             .Width           = 75
347:             .Height          = 75
348:             .FontName        = "Tahoma"
349:             .FontBold        = .T.
350:             .FontItalic      = .T.
351:             .FontSize        = 8
352:             .ForeColor       = RGB(90, 90, 90)
353:             .BackColor       = RGB(255, 255, 255)
354:             .Themes          = .F.
355:             .SpecialEffect   = 0
356:             .MousePointer    = 15
357:             .WordWrap        = .T.
358:             .AutoSize        = .F.
359:             .Visible         = .T.
360:         ENDWITH
361:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
362: 
363:         *-- Container filtro de periodo (Cnt_periodo no legado)
364:         *-- Top=113 = 84 (original) + 29 (compensacao)
365:         loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
366:         WITH loc_oPagina.cnt_4c_Periodo
367:             .Top         = 113
368:             .Left        = 21
369:             .Width       = 332
370:             .Height      = 59
371:             .BackColor   = RGB(255, 255, 255)
372:             .BackStyle   = 0
373:             .Visible     = .T.
374:         ENDWITH
375: 
376:         *-- Label Empresa (Say4 no legado: top=7, left=16)
377:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
378:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
379:             .Caption   = "Empresa : "
380:             .Top       = 7
381:             .Left      = 16
382:             .Width     = 63
383:             .Height    = 17
384:             .FontName  = "Tahoma"
385:             .FontSize  = 8
386:             .FontBold  = .F.
387:             .ForeColor = RGB(0, 0, 0)
388:             .BackStyle = 0
389:             .AutoSize  = .F.
390:             .Visible   = .T.
391:         ENDWITH
392: 
393:         *-- TextBox Empresa (Get_cd_empresa no legado: top=4, left=79, width=35)
394:         *-- MaxLength=3 obrigatorio (CLAUDE.md: SigCdEmp char(3))
395:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Empresa", "TextBox")
396:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa
397:             .Value         = THIS.this_cPEmps
398:             .Top           = 4
399:             .Left          = 79
400:             .Width         = 35
401:             .Height        = 23

*-- Linhas 408 a 651:
408:             .SpecialEffect = 0
409:             .Visible       = .T.
410:         ENDWITH
411:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa, "KeyPress", THIS, "EmpresaLostFocus")
412: 
413:         *-- Label Periodo (Label1 no legado: top=32, left=22)
414:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
415:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
416:             .Caption   = "Per" + CHR(237) + "odo : "
417:             .Top       = 32
418:             .Left      = 22
419:             .Width     = 57
420:             .Height    = 17
421:             .FontName  = "Tahoma"
422:             .FontSize  = 8
423:             .FontBold  = .F.
424:             .ForeColor = RGB(0, 0, 0)
425:             .BackStyle = 0
426:             .AutoSize  = .F.
427:             .Visible   = .T.
428:         ENDWITH
429: 
430:         *-- TextBox Data Inicial (Dt_inicial no legado: top=29, left=79, width=80)
431:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
432:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial
433:             .Value         = DATE()
434:             .Top           = 29
435:             .Left          = 79
436:             .Width         = 80
437:             .Height        = 23
438:             .Format        = "D"
439:             .FontName      = "Tahoma"
440:             .FontSize      = 8
441:             .BackColor     = RGB(255, 255, 255)
442:             .ForeColor     = RGB(0, 0, 0)
443:             .BorderStyle   = 1
444:             .SpecialEffect = 0
445:             .Visible       = .T.
446:         ENDWITH
447:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
448: 
449:         *-- Label separador entre datas (Say2 no legado: top=32, left=164, caption=CHR(224))
450:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Sep", "Label")
451:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Sep
452:             .Caption   = CHR(224)
453:             .Top       = 32
454:             .Left      = 164
455:             .Width     = 12
456:             .Height    = 17
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .FontBold  = .F.
460:             .ForeColor = RGB(0, 0, 0)
461:             .BackStyle = 0
462:             .AutoSize  = .F.
463:             .Visible   = .T.
464:         ENDWITH
465: 
466:         *-- TextBox Data Final (Dt_final no legado: top=29, left=177, width=80)
467:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
468:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal
469:             .Value         = DATE()
470:             .Top           = 29
471:             .Left          = 177
472:             .Width         = 80
473:             .Height        = 23
474:             .Format        = "D"
475:             .FontName      = "Tahoma"
476:             .FontSize      = 8
477:             .BackColor     = RGB(255, 255, 255)
478:             .ForeColor     = RGB(0, 0, 0)
479:             .BorderStyle   = 1
480:             .SpecialEffect = 0
481:             .Visible       = .T.
482:         ENDWITH
483:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
484: 
485:         *-- Botao Posicao Balanco (btnPosicao no legado: top=4+29=33, left=474)
486:         loc_oPagina.AddObject("cmd_4c_PosicaoBal", "CommandButton")
487:         WITH loc_oPagina.cmd_4c_PosicaoBal
488:             .Caption       = "Posi" + CHR(231) + CHR(227) + "o \<Bal."
489:             .Top           = 33
490:             .Left          = 474
491:             .Width         = 64
492:             .Height        = 55
493:             .FontName      = "Tahoma"
494:             .FontSize      = 8
495:             .FontBold      = .F.
496:             .ForeColor     = RGB(0, 0, 0)
497:             .BackColor     = RGB(224, 224, 224)
498:             .Themes        = .F.
499:             .SpecialEffect = 1
500:             .MousePointer  = 15
501:             .WordWrap      = .T.
502:             .AutoSize      = .F.
503:             .Visible       = .T.
504:         ENDWITH
505:         BINDEVENT(loc_oPagina.cmd_4c_PosicaoBal, "Click", THIS, "BtnPosicaoBalClick")
506: 
507:         *-- Grade de balanco (Grade no legado, Page1)
508:         *-- ColumnCount FORA do WITH (Problema 36: dentro nao cria colunas imediatamente)
509:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
510:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
511:         WITH loc_oPagina.grd_4c_Lista
512:             .Top                = 175
513:             .Left               = 21
514:             .Width              = 884
515:             .Height             = 540
516:             .FontName           = "Tahoma"
517:             .FontSize           = 8
518:             .ForeColor          = RGB(90, 90, 90)
519:             .BackColor          = RGB(255, 255, 255)
520:             .GridLineColor      = RGB(238, 238, 238)
521:             .HighlightBackColor = RGB(255, 255, 255)
522:             .HighlightForeColor = RGB(15, 41, 104)
523:             .HighlightStyle     = 2
524:             .DeleteMark         = .F.
525:             .RecordMark         = .F.
526:             .RowHeight          = 16
527:             .ScrollBars         = 2
528:             .GridLines          = 3
529:             .Visible            = .T.
530:         ENDWITH
531:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
532:         BINDEVENT(loc_oPagina.grd_4c_Lista, "AfterRowColChange", THIS, "GradeAfterRowColChange")
533: 
534:         THIS.TornarControlesVisiveis(loc_oPagina)
535:     ENDPROC
536: 
537:     *==========================================================================
538:     * ConfigurarPaginaDados - Configura Page2 (edicao + resultado de balanco)
539:     * FASE 5: container BotoesAcao + botoes Confirmar/Cancelar + Shape +
540:     *         Label/TextBox Codigo + Label/TextBox Data + cmd Processar
541:     *==========================================================================
542:     PROTECTED PROCEDURE ConfigurarPaginaDados()
543:         LOCAL loc_oPagina
544:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
545: 
546:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
547:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
548: 
549:         *-- Container botoes acao - Confirmar + Cancelar (Grupo_Salva no legado)
550:         *-- Top=46 = 17 (original) + 29 (compensacao)
551:         *-- Width=90 inicial (Cancelar oculto); 173 quando modo INSERIR com Fechamento
552:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
553:         WITH loc_oPagina.cnt_4c_BotoesAcao
554:             .Top         = 46
555:             .Left        = 817
556:             .Width       = 90
557:             .Height      = 85
558:             .BackStyle   = 0
559:             .Visible     = .T.
560:         ENDWITH
561: 
562:         *-- Botao Confirmar (Salva no legado: left=5, top=5, w=75, h=75)
563:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
564:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
565:             .Caption         = "Confirmar"
566:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
567:             .PicturePosition = 13
568:             .Top             = 5
569:             .Left            = 5
570:             .Width           = 75
571:             .Height          = 75
572:             .FontName        = "Tahoma"
573:             .FontBold        = .T.
574:             .FontItalic      = .T.
575:             .FontSize        = 8
576:             .ForeColor       = RGB(90, 90, 90)
577:             .BackColor       = RGB(255, 255, 255)
578:             .Themes          = .F.
579:             .SpecialEffect   = 0
580:             .MousePointer    = 15
581:             .WordWrap        = .T.
582:             .AutoSize        = .F.
583:             .Enabled         = .F.
584:             .Visible         = .T.
585:         ENDWITH
586:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
587: 
588:         *-- Botao Cancelar (Cancelar no legado: left=80, top=5; inicia oculto)
589:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
590:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
591:             .Caption         = "Encerrar"
592:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
593:             .PicturePosition = 13
594:             .Top             = 5
595:             .Left            = 80
596:             .Width           = 75
597:             .Height          = 75
598:             .FontName        = "Tahoma"
599:             .FontBold        = .T.
600:             .FontItalic      = .T.
601:             .FontSize        = 8
602:             .ForeColor       = RGB(90, 90, 90)
603:             .BackColor       = RGB(255, 255, 255)
604:             .Themes          = .F.
605:             .SpecialEffect   = 0
606:             .MousePointer    = 15
607:             .WordWrap        = .T.
608:             .AutoSize        = .F.
609:             .Visible         = .F.
610:         ENDWITH
611:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
612: 
613:         *-- Shape de borda ao redor dos campos de entrada (Shape1 no legado)
614:         *-- Top=36 = 7 (original) + 29 (compensacao)
615:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
616:         WITH loc_oPagina.shp_4c_Shape1
617:             .Top         = 36
618:             .Left        = 9
619:             .Width       = 662
620:             .Height      = 110
621:             .BorderColor = RGB(90, 90, 90)
622:             .BackStyle   = 0
623:             .Visible     = .T.
624:         ENDWITH
625: 
626:         *-- Label Codigo (Label4 no legado: top=24+29=53, left=30, w=42)
627:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
628:         WITH loc_oPagina.lbl_4c_Label4
629:             .Caption   = "C" + CHR(243) + "digo :"
630:             .Top       = 53
631:             .Left      = 30
632:             .Width     = 42
633:             .Height    = 15
634:             .FontName  = "Tahoma"
635:             .FontSize  = 8
636:             .FontBold  = .F.
637:             .ForeColor = RGB(90, 90, 90)
638:             .BackStyle = 0
639:             .AutoSize  = .F.
640:             .Visible   = .T.
641:         ENDWITH
642: 
643:         *-- TextBox Codigo (Get_Codigo no legado: top=19+29=48, left=75, w=54)
644:         *-- ReadOnly=.T. por padrao; edita em modo PROCURAR via HabilitarCampos
645:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
646:         WITH loc_oPagina.txt_4c_Codigo
647:             .Value         = 0
648:             .Top           = 48
649:             .Left          = 75
650:             .Width         = 54
651:             .Height        = 25

*-- Linhas 677 a 857:
677:             .Visible   = .T.
678:         ENDWITH
679: 
680:         *-- TextBox Data (Get_Data no legado: top=19+29=48, left=198, w=80)
681:         *-- Format="K" limpa ao digitar; FontName="Courier New" FontSize=9 (legado)
682:         loc_oPagina.AddObject("txt_4c_Data", "TextBox")
683:         WITH loc_oPagina.txt_4c_Data
684:             .Value         = {}
685:             .Top           = 48
686:             .Left          = 198
687:             .Width         = 80
688:             .Height        = 25
689:             .Format        = "K"
690:             .FontName      = "Courier New"
691:             .FontSize      = 9
692:             .BackColor     = RGB(255, 255, 255)
693:             .ForeColor     = RGB(0, 0, 0)
694:             .BorderStyle   = 1
695:             .SpecialEffect = 0
696:             .Visible       = .T.
697:         ENDWITH
698:         BINDEVENT(loc_oPagina.txt_4c_Data, "InteractiveChange", THIS, "DadosInteractiveChange")
699:         BINDEVENT(loc_oPagina.txt_4c_Data, "KeyPress", THIS, "DataLostFocus")
700: 
701:         *-- Label Grupo (Label1 no legado: top=51+29=80, left=34, w=38)
702:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
703:         WITH loc_oPagina.lbl_4c_Label1
704:             .Caption   = "Grupo :"
705:             .Top       = 80
706:             .Left      = 34
707:             .Width     = 38
708:             .Height    = 15
709:             .FontName  = "Tahoma"
710:             .FontSize  = 8
711:             .FontBold  = .F.
712:             .ForeColor = RGB(90, 90, 90)
713:             .BackStyle = 0
714:             .AutoSize  = .F.
715:             .Visible   = .T.
716:         ENDWITH
717: 
718:         *-- TextBox Codigo do Grupo (Get_Grupo no legado: top=46+29=75, left=75, w=80)
719:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
720:         WITH loc_oPagina.txt_4c_Grupo
721:             .Value         = ""
722:             .Top           = 75
723:             .Left          = 75
724:             .Width         = 80
725:             .Height        = 25
726:             .MaxLength     = 10
727:             .FontName      = "Tahoma"
728:             .FontSize      = 8
729:             .BackColor     = RGB(255, 255, 255)
730:             .ForeColor     = RGB(0, 0, 0)
731:             .BorderStyle   = 1
732:             .SpecialEffect = 0
733:             .Visible       = .T.
734:         ENDWITH
735:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "GrupoKeyPress")
736:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "DblClick", THIS, "GrupoDblClick")
737:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "InteractiveChange", THIS, "DadosInteractiveChange")
738: 
739:         *-- TextBox Descricao Grupo (Get_DGrupo no legado: top=46+29=75, left=157, w=290)
740:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
741:         WITH loc_oPagina.txt_4c_DGrupo
742:             .Value         = ""
743:             .Top           = 75
744:             .Left          = 157
745:             .Width         = 290
746:             .Height        = 25
747:             .MaxLength     = 40
748:             .FontName      = "Tahoma"
749:             .FontSize      = 8
750:             .BackColor     = RGB(255, 255, 255)
751:             .ForeColor     = RGB(0, 0, 0)
752:             .BorderStyle   = 1
753:             .SpecialEffect = 0
754:             .Visible       = .T.
755:         ENDWITH
756:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "KeyPress", THIS, "DGrupoKeyPress")
757:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "DblClick", THIS, "DGrupoDblClick")
758:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "InteractiveChange", THIS, "DadosInteractiveChange")
759: 
760:         *-- Label Conta (Label2 no legado: top=78+29=107, left=34, w=38)
761:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
762:         WITH loc_oPagina.lbl_4c_Label2
763:             .Caption   = "Conta :"
764:             .Top       = 107
765:             .Left      = 34
766:             .Width     = 38
767:             .Height    = 15
768:             .FontName  = "Tahoma"
769:             .FontSize  = 8
770:             .FontBold  = .F.
771:             .ForeColor = RGB(90, 90, 90)
772:             .BackStyle = 0
773:             .AutoSize  = .F.
774:             .Visible   = .T.
775:         ENDWITH
776: 
777:         *-- TextBox Codigo da Conta (Get_Conta no legado: top=73+29=102, left=75, w=80)
778:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
779:         WITH loc_oPagina.txt_4c_Conta
780:             .Value         = ""
781:             .Top           = 102
782:             .Left          = 75
783:             .Width         = 80
784:             .Height        = 25
785:             .MaxLength     = 10
786:             .FontName      = "Tahoma"
787:             .FontSize      = 8
788:             .BackColor     = RGB(255, 255, 255)
789:             .ForeColor     = RGB(0, 0, 0)
790:             .BorderStyle   = 1
791:             .SpecialEffect = 0
792:             .Visible       = .T.
793:         ENDWITH
794:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ContaKeyPress")
795:         BINDEVENT(loc_oPagina.txt_4c_Conta, "DblClick", THIS, "ContaDblClick")
796:         BINDEVENT(loc_oPagina.txt_4c_Conta, "InteractiveChange", THIS, "DadosInteractiveChange")
797: 
798:         *-- TextBox Descricao Conta (Get_DConta no legado: top=73+29=102, left=157, w=290)
799:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
800:         WITH loc_oPagina.txt_4c_DConta
801:             .Value         = ""
802:             .Top           = 102
803:             .Left          = 157
804:             .Width         = 290
805:             .Height        = 25
806:             .MaxLength     = 80
807:             .FontName      = "Tahoma"
808:             .FontSize      = 8
809:             .BackColor     = RGB(255, 255, 255)
810:             .ForeColor     = RGB(0, 0, 0)
811:             .BorderStyle   = 1
812:             .SpecialEffect = 0
813:             .Visible       = .T.
814:         ENDWITH
815:         BINDEVENT(loc_oPagina.txt_4c_DConta, "KeyPress", THIS, "DContaKeyPress")
816:         BINDEVENT(loc_oPagina.txt_4c_DConta, "DblClick", THIS, "DContaDblClick")
817:         BINDEVENT(loc_oPagina.txt_4c_DConta, "InteractiveChange", THIS, "DadosInteractiveChange")
818: 
819:         *-- Label Lote (Label5 no legado: top=51+29=80, left=504, w=30)
820:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
821:         WITH loc_oPagina.lbl_4c_Label5
822:             .Caption   = "Lote :"
823:             .Top       = 80
824:             .Left      = 504
825:             .Width     = 30
826:             .Height    = 15
827:             .FontName  = "Tahoma"
828:             .FontSize  = 8
829:             .FontBold  = .F.
830:             .ForeColor = RGB(90, 90, 90)
831:             .BackStyle = 0
832:             .AutoSize  = .F.
833:             .Visible   = .T.
834:         ENDWITH
835: 
836:         *-- TextBox Lote (getlote no legado: top=46+29=75, left=543, w=54)
837:         *-- Editavel somente quando !Fechamento (posicao sem balanco)
838:         loc_oPagina.AddObject("txt_4c_Lote", "TextBox")
839:         WITH loc_oPagina.txt_4c_Lote
840:             .Value         = 0
841:             .Top           = 75
842:             .Left          = 543
843:             .Width         = 54
844:             .Height        = 25
845:             .InputMask     = "999999"
846:             .FontName      = "Tahoma"
847:             .FontSize      = 8
848:             .BackColor     = RGB(255, 255, 255)
849:             .ForeColor     = RGB(0, 0, 0)
850:             .BorderStyle   = 1
851:             .SpecialEffect = 0
852:             .ReadOnly      = .T.
853:             .Visible       = .T.
854:         ENDWITH
855: 
856:         *-- Botao Processar (Processar no legado: top=22+29=51, left=747, w=75, h=75)
857:         *-- FontName="Comic Sans MS" FontBold=.T. do legado

*-- Linhas 877 a 1016:
877:             .AutoSize        = .F.
878:             .Visible         = .T.
879:         ENDWITH
880:         BINDEVENT(loc_oPagina.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
881: 
882:         *-- Container resultado (Resultado no legado)
883:         *-- INICIA OCULTO - torna-se visivel apos BtnProcessarClick executar
884:         *-- Top=152 = 123 (original) + 29 (compensacao)
885:         loc_oPagina.AddObject("cnt_4c_Resultado", "Container")
886:         WITH loc_oPagina.cnt_4c_Resultado
887:             .Top         = 152
888:             .Left        = 10
889:             .Width       = 980
890:             .Height      = 460
891:             .BackColor   = RGB(255, 255, 255)
892:             .BackStyle   = 1
893:             .Visible     = .F.
894:         ENDWITH
895: 
896:         THIS.ConfigurarResultado(loc_oPagina.cnt_4c_Resultado)
897: 
898:         *-- Bind Page2.Activate -> AjustarBotoesPorModo (Pagina.Dados.Activate no legado)
899:         BINDEVENT(loc_oPagina, "Activate", THIS, "AjustarBotoesPorModo")
900: 
901:         THIS.TornarControlesVisiveis(loc_oPagina)
902:     ENDPROC
903: 
904:     *==========================================================================
905:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
906:     * Preserva containers que devem iniciar ocultos (cnt_4c_Resultado)
907:     *==========================================================================
908:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
909:         LOCAL loc_i, loc_nP, loc_oObjeto, loc_cNome
910: 
911:         FOR loc_i = 1 TO par_oContainer.ControlCount
912:             loc_oObjeto = par_oContainer.Controls(loc_i)
913: 
914:             IF VARTYPE(loc_oObjeto) = "O"
915:                 loc_cNome = UPPER(loc_oObjeto.Name)
916: 
917:                 IF INLIST(loc_cNome, "CNT_4C_CABECALHO", "CNT_4C_RESULTADO", "CNT_4C_CONVERSAO")
918:                     THIS.TornarControlesVisiveis(loc_oObjeto)
919:                     LOOP
920:                 ENDIF
921: 
922:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
923:                     loc_oObjeto.Visible = .T.
924:                 ENDIF
925: 
926:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
927:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
928:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
929:                     ENDFOR
930:                 ENDIF
931: 
932:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
933:                     THIS.TornarControlesVisiveis(loc_oObjeto)
934:                 ENDIF
935:             ENDIF
936:         ENDFOR
937:     ENDPROC
938: 
939:     *==========================================================================
940:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados/formulario)
941:     *==========================================================================
942:     PROCEDURE AlternarPagina(par_nPagina)
943:         LOCAL loc_lResultado
944:         loc_lResultado = .F.
945: 
946:         TRY
947:             IF VARTYPE(par_nPagina) <> "N" OR par_nPagina < 1 OR par_nPagina > 2
948:                 MsgAviso("P" + CHR(225) + "gina inv" + CHR(225) + "lida: " + TRANSFORM(par_nPagina))
949:             ELSE
950:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
951: 
952:                 IF par_nPagina = 1
953:                     THIS.this_cModoAtual = "LISTA"
954:                     THIS.pgf_4c_Paginas.Page1.Enabled = .T.
955:                     THIS.CarregarLista()
956:                 ELSE
957:                     THIS.pgf_4c_Paginas.Page1.Enabled = .F.
958:                 ENDIF
959: 
960:                 loc_lResultado = .T.
961:             ENDIF
962: 
963:         CATCH TO loc_oErro
964:             MsgErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + loc_oErro.Message, ;
965:                 "FormFea.AlternarPagina")
966:         ENDTRY
967: 
968:         RETURN loc_lResultado
969:     ENDPROC
970: 
971:     *==========================================================================
972:     * CarregarLista - Carrega/recarrega grid da Page1 com dados do periodo filtrado
973:     * OBRIGATORIO: rebind ControlSource + Headers APOS RecordSource (Problema 2/48)
974:     * OBRIGATORIO: RecordSource FORA do WITH (Problema 36)
975:     *==========================================================================
976:     PROCEDURE CarregarLista()
977:         LOCAL loc_lResultado, loc_oGrid, loc_cEmp, loc_dDtI, loc_dDtF
978:         loc_lResultado = .F.
979: 
980:         TRY
981:             loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)
982:             loc_dDtI = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
983:             loc_dDtF = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
984: 
985:             THIS.this_oBusinessObject.PreencherFiltro(loc_cEmp, loc_dDtI, loc_dDtF)
986: 
987:             IF THIS.this_oBusinessObject.Buscar("")
988:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
989: 
990:                 loc_oGrid.ColumnCount  = 5
991:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
992: 
993:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
994:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.grupos"
995:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
996:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.datas"
997:                 loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.datais"
998: 
999:                 loc_oGrid.Column1.Width = 70
1000:                 loc_oGrid.Column2.Width = 120
1001:                 loc_oGrid.Column3.Width = 120
1002:                 loc_oGrid.Column4.Width = 200
1003:                 loc_oGrid.Column5.Width = 200
1004: 
1005:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d."
1006:                 loc_oGrid.Column2.Header1.Caption = "Grupo"
1007:                 loc_oGrid.Column3.Header1.Caption = "Conta"
1008:                 loc_oGrid.Column4.Header1.Caption = "Data Encerramento"
1009:                 loc_oGrid.Column5.Header1.Caption = "Data In" + CHR(237) + "cio"
1010: 
1011:                 THIS.FormatarGridLista(loc_oGrid)
1012: 
1013:                 THIS.this_cAntEmpr  = loc_cEmp
1014:                 THIS.this_dAntDtIni = loc_dDtI
1015:                 THIS.this_dAntDtFin = loc_dDtF
1016: 

*-- Linhas 1030 a 1298:
1030:     *==========================================================================
1031:     * FormatarGridLista - Aplica formatacao visual ao grid de lista
1032:     *==========================================================================
1033:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1034:         TRY
1035:             WITH par_oGrid
1036:                 .FontName = "Tahoma"
1037:                 .FontSize = 8
1038:             ENDWITH
1039:         CATCH TO loc_oErro
1040:             MsgErro("Erro ao formatar grid:" + CHR(13) + loc_oErro.Message, ;
1041:                 "FormFea.FormatarGridLista")
1042:         ENDTRY
1043:     ENDPROC
1044: 
1045:     *==========================================================================
1046:     * GradeAfterRowColChange - Rastreia mudanca de linha no grid
1047:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1048:     * AfterRowColChange requer LPARAMETERS par_nColIndex (CLAUDE.md regra #3)
1049:     *==========================================================================
1050:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1051:         LOCAL loc_lTemRegistro
1052:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1053: 
1054:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1055:             .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1056:             .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1057:             .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1058:             .Visible     = .T.
1059:         ENDWITH
1060:     ENDPROC
1061: 
1062:     *==========================================================================
1063:     * BtnIncluirClick - Abre Page2 para incluir novo balanco
1064:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1065:     *==========================================================================
1066:     PROCEDURE BtnIncluirClick()
1067:         THIS.this_cPcEscolha  = "INSERIR"
1068:         THIS.this_lFechamento = .T.
1069:         THIS.this_oBusinessObject.NovoRegistro()
1070:         THIS.this_cModoAtual  = "INCLUIR"
1071:         THIS.AlternarPagina(2)
1072:         THIS.AjustarBotoesPorModo()
1073:         THIS.HabilitarCampos()
1074:         *-- Inicializa Data apos AjustarBotoesPorModo (evita sobrescrita por BOParaForm)
1075:         THIS.pgf_4c_Paginas.Page2.txt_4c_Data.Value = DATE()
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     * BtnVisualizarClick - Abre Page2 em modo consulta (somente leitura)
1080:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1081:     *==========================================================================
1082:     PROCEDURE BtnVisualizarClick()
1083:         LOCAL loc_cCidChaves
1084:         loc_cCidChaves = ""
1085: 
1086:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1087:             SELECT cursor_4c_Dados
1088:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1089:         ENDIF
1090: 
1091:         IF EMPTY(loc_cCidChaves)
1092:             MsgAviso("Selecione um registro para visualizar.")
1093:         ELSE
1094:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1095:                 THIS.this_cPcEscolha = "CONSULTAR"
1096:                 THIS.this_cModoAtual = "VISUALIZAR"
1097:                 THIS.AlternarPagina(2)
1098:                 THIS.AjustarBotoesPorModo()
1099:                 THIS.HabilitarCampos()
1100:             ENDIF
1101:         ENDIF
1102:     ENDPROC
1103: 
1104:     *==========================================================================
1105:     * BtnAlterarClick - Abre Page2 para alterar balanco selecionado
1106:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1107:     *==========================================================================
1108:     PROCEDURE BtnAlterarClick()
1109:         LOCAL loc_cCidChaves
1110:         loc_cCidChaves = ""
1111: 
1112:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1113:             SELECT cursor_4c_Dados
1114:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1115:         ENDIF
1116: 
1117:         IF EMPTY(loc_cCidChaves)
1118:             MsgAviso("Selecione um registro para alterar.")
1119:         ELSE
1120:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1121:                 THIS.this_oBusinessObject.EditarRegistro()
1122:                 THIS.this_cPcEscolha = "ALTERAR"
1123:                 THIS.this_cModoAtual = "ALTERAR"
1124:                 THIS.AlternarPagina(2)
1125:                 THIS.AjustarBotoesPorModo()
1126:                 THIS.HabilitarCampos()
1127:             ENDIF
1128:         ENDIF
1129:     ENDPROC
1130: 
1131:     *==========================================================================
1132:     * BtnExcluirClick - Exclui balanco selecionado com confirmacao
1133:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1134:     *==========================================================================
1135:     PROCEDURE BtnExcluirClick()
1136:         LOCAL loc_cCidChaves, loc_lConfirma
1137:         loc_cCidChaves = ""
1138:         loc_lConfirma  = .F.
1139: 
1140:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1141:             SELECT cursor_4c_Dados
1142:             loc_cCidChaves = ALLTRIM(cursor_4c_Dados.cidchaves)
1143:         ENDIF
1144: 
1145:         IF EMPTY(loc_cCidChaves)
1146:             MsgAviso("Selecione um registro para excluir.")
1147:         ELSE
1148:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCidChaves)
1149:                 loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o deste balan" + CHR(231) + "o?", ;
1150:                     "Confirmar Exclus" + CHR(227) + "o")
1151:                 IF loc_lConfirma
1152:                     IF THIS.this_oBusinessObject.Excluir()
1153:                         MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1154:                         THIS.CarregarLista()
1155:                     ENDIF
1156:                 ENDIF
1157:             ENDIF
1158:         ENDIF
1159:     ENDPROC
1160: 
1161:     *==========================================================================
1162:     * BtnBuscarClick - Recarrega lista com filtros correntes
1163:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1164:     *==========================================================================
1165:     PROCEDURE BtnBuscarClick()
1166:         THIS.CarregarLista()
1167:     ENDPROC
1168: 
1169:     *==========================================================================
1170:     * BtnEncerrarClick - Fecha o formulario
1171:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1172:     *==========================================================================
1173:     PROCEDURE BtnEncerrarClick()
1174:         THIS.Release()
1175:     ENDPROC
1176: 
1177:     *==========================================================================
1178:     * BtnPosicaoBalClick - Posiciona para incluir novo balanco (btnPosicao legado)
1179:     * Legado: Fechamento=.F. + plAcInserir=.T. + Grupo_Op.Click(1)
1180:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1181:     *==========================================================================
1182:     PROCEDURE BtnPosicaoBalClick()
1183:         THIS.this_lFechamento = .F.
1184:         THIS.this_lAcInserir  = .T.
1185:         THIS.BtnIncluirClick()
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * EmpresaLostFocus - Valida empresa e recarrega lista se empresa mudou
1190:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1191:     *==========================================================================
1192:     PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1193:         LOCAL loc_cEmp
1194:         loc_cEmp = ALLTRIM(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.Value)
1195: 
1196:         IF EMPTY(loc_cEmp)
1197:             MsgAviso("Empresa de preenchimento obrigat" + CHR(243) + "rio.")
1198:             THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_Empresa.SetFocus()
1199:         ELSE
1200:             THIS.this_cPEmps = loc_cEmp
1201:             IF loc_cEmp <> THIS.this_cAntEmpr
1202:                 THIS.CarregarLista()
1203:             ENDIF
1204:         ENDIF
1205:     ENDPROC
1206: 
1207:     *==========================================================================
1208:     * DtInicialLostFocus - Sincroniza DtFinal se DtInicial > DtFinal; recarrega
1209:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1210:     *==========================================================================
1211:     PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1212:         LOCAL loc_dDtI, loc_dDtF, loc_oCnt
1213:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1214:         loc_dDtI = loc_oCnt.txt_4c_DtInicial.Value
1215:         loc_dDtF = loc_oCnt.txt_4c_DtFinal.Value
1216: 
1217:         IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
1218:             IF loc_dDtI > loc_dDtF
1219:                 loc_oCnt.txt_4c_DtFinal.Value = loc_dDtI
1220:                 loc_dDtF = loc_dDtI
1221:             ENDIF
1222:         ENDIF
1223: 
1224:         IF loc_dDtI <> THIS.this_dAntDtIni OR loc_dDtF <> THIS.this_dAntDtFin
1225:             THIS.CarregarLista()
1226:         ENDIF
1227:     ENDPROC
1228: 
1229:     *==========================================================================
1230:     * DtFinalLostFocus - Sincroniza DtInicial se DtFinal < DtInicial; recarrega
1231:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1232:     *==========================================================================
1233:     PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1234:         LOCAL loc_dDtI, loc_dDtF, loc_oCnt
1235:         loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
1236:         loc_dDtI = loc_oCnt.txt_4c_DtInicial.Value
1237:         loc_dDtF = loc_oCnt.txt_4c_DtFinal.Value
1238: 
1239:         IF VARTYPE(loc_dDtI) = "D" AND VARTYPE(loc_dDtF) = "D"
1240:             IF loc_dDtF < loc_dDtI
1241:                 loc_oCnt.txt_4c_DtInicial.Value = loc_dDtF
1242:                 loc_dDtI = loc_dDtF
1243:             ENDIF
1244:         ENDIF
1245: 
1246:         IF loc_dDtI <> THIS.this_dAntDtIni OR loc_dDtF <> THIS.this_dAntDtFin
1247:             THIS.CarregarLista()
1248:         ENDIF
1249:     ENDPROC
1250: 
1251:     *==========================================================================
1252:     * AjustarBotoesPorModo - Ajusta visibilidade/estado dos botoes ao entrar Page2
1253:     * Dispara via BINDEVENT em Page2.Activate (Pagina.Dados.Activate no legado)
1254:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1255:     *==========================================================================
1256:     PROCEDURE AjustarBotoesPorModo()
1257:         LOCAL loc_oPagina, loc_lCancelarVisivel, loc_lConsultar, loc_lSomenteVisual
1258:         loc_lResultado = .F.
1259: 
1260:         TRY
1261:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1262: 
1263:             *-- Carregar dados auxiliares de lookup (uma vez ao entrar em Page2)
1264:             THIS.CarregarDadosAuxiliares()
1265: 
1266:             loc_lConsultar      = (THIS.this_cPcEscolha = "CONSULTAR") OR !THIS.this_lFechamento
1267:             loc_lSomenteVisual  = (THIS.this_cPcEscolha = "CONSULTAR")
1268:             loc_lCancelarVisivel = (THIS.this_cPcEscolha <> "CONSULTAR") AND THIS.this_lFechamento
1269: 
1270:             *-- Cancelar: visivel apenas quando pode cancelar uma edicao real
1271:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Visible = loc_lCancelarVisivel
1272: 
1273:             *-- Confirmar.Cancel: ativado por ESC quando nao se pode confirmar
1274:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Cancel = loc_lConsultar
1275: 
1276:             *-- Width do container: 90 so Confirmar / 173 Confirmar + Cancelar
1277:             loc_oPagina.cnt_4c_BotoesAcao.Width = IIF(loc_lConsultar, 90, 173)
1278: 
1279:             *-- Processar: visivel somente em INSERIR
1280:             loc_oPagina.cmd_4c_Processar.Visible = (THIS.this_cPcEscolha = "INSERIR")
1281: 
1282:             *-- txt_4c_Data: editavel em INSERIR/ALTERAR ou quando !Fechamento
1283:             loc_oPagina.txt_4c_Data.ReadOnly = loc_lSomenteVisual AND THIS.this_lFechamento
1284: 
1285:             *-- Popula campos da BOParaForm (crSigCdFcx -> form)
1286:             THIS.BOParaForm()
1287: 
1288:             *-- Para CONSULTAR/EXCLUIR: exibir resultado salvo
1289:             IF INLIST(THIS.this_cPcEscolha, "CONSULTAR", "EXCLUIR")
1290:                 THIS.CarregarDados()
1291:                 loc_oPagina.cnt_4c_Resultado.Visible = .T.
1292:             ELSE
1293:                 loc_oPagina.cnt_4c_Resultado.Visible = .F.
1294:             ENDIF
1295: 
1296:             *-- Para INSERIR e !Fechamento (posicao): Confirmar habilitado
1297:             IF THIS.this_cPcEscolha <> "INSERIR" OR !THIS.this_lFechamento
1298:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.

*-- Linhas 1312 a 1355:
1312:     * ProcessarBalanco: TmpGccr, TmpCli, TmpPro, crSigOpOpt, LocalOpp, crSigCdOpe
1313:     * Chamado por AjustarBotoesPorModo ao entrar em Page2
1314:     *==========================================================================
1315:     PROTECTED PROCEDURE CarregarDadosAuxiliares()
1316:         LOCAL loc_cSql, loc_cEmpr
1317:         loc_cEmpr = THIS.this_cPEmps
1318: 
1319:         TRY
1320:             *-- crSigCdPac - parametros de conta do balanco
1321:             IF !USED("crSigCdPac")
1322:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPac WHERE Emps = " + EscaparSQL(loc_cEmpr)
1323:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPac")
1324:             ENDIF
1325: 
1326:             *-- crSigCdPam - parametros de material do balanco
1327:             IF !USED("crSigCdPam")
1328:                 loc_cSql = "SELECT TOP 1 * FROM SigCdPam WHERE Emps = " + EscaparSQL(loc_cEmpr)
1329:                 =SQLEXEC(gnConnHandle, loc_cSql, "crSigCdPam")
1330:             ENDIF
1331: 
1332:             *-- TmpGccr - grupos de balanco da empresa (SigCdGcc)
1333:             *-- Campos: Codigos (BalCodigo), Descrs (BalDescrs), UnifBals, GruFals, etc.
1334:             IF !USED("TmpGccr")
1335:                 loc_cSql = "SELECT Codigos, Descrs, UnifBals, GruFals, BalCodigo, BalDescrs FROM SigCdGcc " + ;
1336:                            "WHERE Emps = " + EscaparSQL(loc_cEmpr)
1337:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpGccr") > 0
1338:                     SELECT TmpGccr
1339:                     INDEX ON BalCodigo  TAG BalCodigo
1340:                     INDEX ON BalDescrs  TAG BalDescrs
1341:                     SET ORDER TO BalCodigo
1342:                 ENDIF
1343:             ENDIF
1344: 
1345:             *-- TmpCli - contas de balanco (clientes/contas correntes)
1346:             IF !USED("TmpCli")
1347:                 loc_cSql = "SELECT IClis, RClis, PagFals, RecFals, GruFals, Inativas, IClis AS BalCodigo, RClis AS BalNome " + ;
1348:                            "FROM SigCdCli WHERE Emps = " + EscaparSQL(loc_cEmpr)
1349:                 IF SQLEXEC(gnConnHandle, loc_cSql, "TmpCli") > 0
1350:                     SELECT TmpCli
1351:                     INDEX ON BalCodigo TAG BalCodigo
1352:                     INDEX ON BalNome   TAG BalNome
1353:                     SET ORDER TO BalCodigo
1354:                 ENDIF
1355:             ENDIF

*-- Linhas 1403 a 1580:
1403:     * BOParaForm - Preenche controles visuais a partir do BO / crSigCdFcx
1404:     * Fase 5: Codigo e Data (Grupo/Conta/Lote em Fase 6)
1405:     *==========================================================================
1406:     PROTECTED PROCEDURE BOParaForm()
1407:         LOCAL loc_oPagina
1408:         TRY
1409:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1410: 
1411:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1412:                 loc_oPagina.txt_4c_Codigo.Value = NVL(crSigCdFcx.Codigos, 0)
1413: 
1414:                 IF VARTYPE(crSigCdFcx.Datas) = "T" OR VARTYPE(crSigCdFcx.Datas) = "D"
1415:                     IF VARTYPE(crSigCdFcx.Datas) = "T"
1416:                         loc_oPagina.txt_4c_Data.Value = TTOD(crSigCdFcx.Datas)
1417:                     ELSE
1418:                         loc_oPagina.txt_4c_Data.Value = crSigCdFcx.Datas
1419:                     ENDIF
1420:                 ENDIF
1421: 
1422:                 *-- Fase 6: txt_4c_Grupo, txt_4c_DGrupo, txt_4c_Conta, txt_4c_DConta, txt_4c_Lote
1423:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1424:                     loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(NVL(crSigCdFcx.Grupos, ""))
1425:                     =SEEK(ALLTRIM(crSigCdFcx.Grupos), "TmpGccr", "BalCodigo")
1426:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5) AND USED("TmpGccr") AND !EOF("TmpGccr")
1427:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
1428:                     ENDIF
1429:                 ENDIF
1430: 
1431:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1432:                     loc_oPagina.txt_4c_Conta.Value = ALLTRIM(NVL(crSigCdFcx.Contas, ""))
1433:                     =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
1434:                     IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5) AND USED("TmpCli") AND !EOF("TmpCli")
1435:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.RClis)
1436:                     ENDIF
1437:                 ENDIF
1438:             ENDIF
1439:         CATCH TO loc_oErro
1440:             MsgErro("Erro em BOParaForm:" + CHR(13) + loc_oErro.Message, "FormFea")
1441:         ENDTRY
1442:     ENDPROC
1443: 
1444:     *==========================================================================
1445:     * FormParaBO - Le controles visuais e atualiza BO / crSigCdFcx
1446:     * Fase 5: Data (Grupo/Conta em Fase 6)
1447:     *==========================================================================
1448:     PROTECTED PROCEDURE FormParaBO()
1449:         LOCAL loc_oPagina
1450:         TRY
1451:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1452: 
1453:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1454:                 SELECT crSigCdFcx
1455:                 REPLACE crSigCdFcx.Datas WITH loc_oPagina.txt_4c_Data.Value
1456: 
1457:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1458:                     REPLACE crSigCdFcx.Grupos WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value), LEN(crSigCdFcx.Grupos))
1459:                 ENDIF
1460:                 IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1461:                     REPLACE crSigCdFcx.Contas WITH PADR(ALLTRIM(loc_oPagina.txt_4c_Conta.Value), LEN(crSigCdFcx.Contas))
1462:                 ENDIF
1463:             ENDIF
1464:         CATCH TO loc_oErro
1465:             MsgErro("Erro em FormParaBO:" + CHR(13) + loc_oErro.Message, "FormFea")
1466:         ENDTRY
1467:     ENDPROC
1468: 
1469:     *==========================================================================
1470:     * HabilitarCampos - Habilita/desabilita campos conforme modo (legado: When())
1471:     *==========================================================================
1472:     PROTECTED PROCEDURE HabilitarCampos()
1473:         LOCAL loc_oPagina, loc_lEdita, loc_lProcurar
1474:         TRY
1475:             loc_oPagina  = THIS.pgf_4c_Paginas.Page2
1476:             loc_lEdita   = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") OR !THIS.this_lFechamento
1477:             loc_lProcurar = (THIS.this_cPcEscolha = "PROCURAR")
1478: 
1479:             *-- Codigo: editavel somente em PROCURAR
1480:             loc_oPagina.txt_4c_Codigo.ReadOnly = !loc_lProcurar
1481: 
1482:             *-- Data: editavel em INSERIR/ALTERAR ou posicao
1483:             loc_oPagina.txt_4c_Data.ReadOnly = !loc_lEdita
1484: 
1485:             *-- Fase 6: Grupo, DGrupo, Conta, DConta, Lote (guardados por PEMSTATUS)
1486:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1487:                 loc_oPagina.txt_4c_Grupo.ReadOnly = !loc_lEdita
1488:             ENDIF
1489:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
1490:                 loc_oPagina.txt_4c_DGrupo.ReadOnly = !(EMPTY(loc_oPagina.txt_4c_Grupo.Value) AND loc_lEdita)
1491:             ENDIF
1492:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1493:                 loc_oPagina.txt_4c_Conta.ReadOnly = !loc_lEdita
1494:             ENDIF
1495:             IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
1496:                 loc_oPagina.txt_4c_DConta.ReadOnly = !(EMPTY(loc_oPagina.txt_4c_Conta.Value) AND loc_lEdita)
1497:             ENDIF
1498:             IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5)
1499:                 loc_oPagina.txt_4c_Lote.ReadOnly = THIS.this_lFechamento
1500:             ENDIF
1501:         CATCH TO loc_oErro
1502:             MsgErro("Erro em HabilitarCampos:" + CHR(13) + loc_oErro.Message, "FormFea")
1503:         ENDTRY
1504:     ENDPROC
1505: 
1506:     *==========================================================================
1507:     * LimparCampos - Limpa campos da Page2 (Fase 5: Data; Fase 6: restantes)
1508:     *==========================================================================
1509:     PROTECTED PROCEDURE LimparCampos()
1510:         LOCAL loc_oPagina
1511:         TRY
1512:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1513:             loc_oPagina.txt_4c_Data.Value = DATE()
1514:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1515:                 loc_oPagina.txt_4c_Grupo.Value = ""
1516:             ENDIF
1517:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
1518:                 loc_oPagina.txt_4c_DGrupo.Value = ""
1519:             ENDIF
1520:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1521:                 loc_oPagina.txt_4c_Conta.Value = ""
1522:             ENDIF
1523:             IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
1524:                 loc_oPagina.txt_4c_DConta.Value = ""
1525:             ENDIF
1526:             IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5)
1527:                 loc_oPagina.txt_4c_Lote.Value = 0
1528:             ENDIF
1529:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1530:             loc_oPagina.cnt_4c_Resultado.Visible = .F.
1531:         CATCH TO loc_oErro
1532:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "FormFea")
1533:         ENDTRY
1534:     ENDPROC
1535: 
1536:     *==========================================================================
1537:     * CarregarDados - Carrega resultado de balanco para CONSULTAR/EXCLUIR
1538:     * Equivale a ThisForm.CarregaDados do legado (nao extraido - implementado)
1539:     *==========================================================================
1540:     PROTECTED PROCEDURE CarregarDados()
1541:         LOCAL loc_lResultado
1542:         loc_lResultado = .F.
1543:         TRY
1544:             IF USED("CrSigCdFea") AND !EOF("CrSigCdFea") AND ;
1545:                USED("TmpResumo") AND RECCOUNT("TmpResumo") > 0
1546:                 *-- Dados ja carregados em TmpResumo pelo ultimo ProcessarBalanco
1547:                 loc_lResultado = .T.
1548:             ELSE
1549:                 *-- Para CONSULTAR/EXCLUIR sem processamento anterior:
1550:                 *-- carregar do SigOpCfe (saldos salvos) vinculados ao crSigCdFcx
1551:                 IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
1552:                     LOCAL loc_cSql
1553:                     loc_cSql = "SELECT * FROM SigOpCfe WHERE Codigos = " + ;
1554:                                TRANSFORM(crSigCdFcx.Codigos) + ;
1555:                                " AND Emps = " + EscaparSQL(ALLTRIM(crSigCdFcx.Emps)) + ;
1556:                                " ORDER BY Codigos, Cpros"
1557:                     IF SQLEXEC(gnConnHandle, loc_cSql, "CrSaldoCarreg") > 0
1558:                         *-- Popula TmpResumo a partir dos saldos salvos
1559:                         IF !USED("TmpResumo")
1560:                             CREATE CURSOR TmpResumo (Grupo C(10), Conta C(10), CMats C(14), ;
1561:                                 CUnis C(10), Saldoi N(12,3), FReal N(12,3), FAdmin N(12,3), ;
1562:                                 Saldof N(12,3), PfTrabs N(8,2), IndProd N(8,2), ;
1563:                                 PesoEnts N(12,3), PesoSais N(12,3), QtdeEnts N(12,3), ;
1564:                                 QtdeSais N(12,3), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1565:                                 Pesagem N(12,3), Pesagem2 N(12,3), Pesagem3 N(12,3), ;
1566:                                 Varias N(1), Agregas N(1), Visivel L, ;
1567:                                 Flag L, Flag2 L, Flag3 L, CodCors C(4), CodTams C(4))
1568:                             INDEX ON Grupo + Conta + CMats TAG GrConMat
1569:                             SET ORDER TO GrConMat
1570:                         ELSE
1571:                             SELECT TmpResumo
1572:                             ZAP
1573:                             SET ORDER TO GrConMat
1574:                         ENDIF
1575:                         SELECT CrSaldoCarreg
1576:                         SCAN
1577:                             INSERT INTO TmpResumo (Grupo, Conta, CMats, Saldof) ;
1578:                                 VALUES (crSigCdFcx.Grupos, crSigCdFcx.Contas, ;
1579:                                         CrSaldoCarreg.Cpros, CrSaldoCarreg.Pesagems)
1580:                         ENDSCAN

*-- Linhas 1591 a 1719:
1591:         RETURN loc_lResultado
1592:     ENDPROC
1593: 
1594:     *==========================================================================
1595:     * DadosInteractiveChange - Oculta resultado e desabilita Confirmar
1596:     * Disparado por InteractiveChange em txt_4c_Data (Fase 5) e futuramente
1597:     * txt_4c_Grupo, txt_4c_DGrupo, txt_4c_Conta, txt_4c_DConta (Fase 6)
1598:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1599:     *==========================================================================
1600:     PROCEDURE DadosInteractiveChange()
1601:         TRY
1602:             IF THIS.this_lFechamento
1603:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1604:             ENDIF
1605:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Visible = .F.
1606:         CATCH TO loc_oErro
1607:             MsgErro("Erro em DadosInteractiveChange:" + CHR(13) + loc_oErro.Message, "FormFea")
1608:         ENDTRY
1609:     ENDPROC
1610: 
1611:     *==========================================================================
1612:     * DataLostFocus - Copia data de fechamento para campo DataCc no Resultado
1613:     * Legado: Get_Data.LostFocus - copia valor para Resultado.Cnt_Conversao.Get_DataCc
1614:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1615:     *==========================================================================
1616:     PROCEDURE DataLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1617:         LOCAL loc_oPagina
1618:         TRY
1619:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1620:             IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
1621:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
1622:                     loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.Value = ;
1623:                         loc_oPagina.txt_4c_Data.Value
1624:                 ENDIF
1625:             ENDIF
1626:         CATCH TO loc_oErro
1627:             MsgErro("Erro em DataLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
1628:         ENDTRY
1629:     ENDPROC
1630: 
1631:     *==========================================================================
1632:     * BtnConfirmarClick - Salva o balanco apos validacao
1633:     * Legado: Salva.Click (Grupo_Salva no legado)
1634:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1635:     *==========================================================================
1636:     PROCEDURE BtnConfirmarClick()
1637:         LOCAL loc_lResultado, loc_oPagina, loc_cGrupo, loc_cConta, loc_dData, loc_dDataCc
1638:         loc_lResultado = .F.
1639: 
1640:         TRY
1641:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
1642:             loc_dData   = loc_oPagina.txt_4c_Data.Value
1643:             loc_cGrupo  = ""
1644:             loc_cConta  = ""
1645:             loc_dDataCc = {}
1646: 
1647:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1648:                 loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1649:             ENDIF
1650:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1651:                 loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1652:             ENDIF
1653:             IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
1654:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
1655:                     loc_dDataCc = loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.Value
1656:                 ENDIF
1657:             ENDIF
1658: 
1659:             IF THIS.this_lFechamento AND THIS.this_cPcEscolha = "INSERIR"
1660:                 *-- Validar Data
1661:                 IF EMPTY(loc_dData)
1662:                     MsgAviso("A Data Deve Ser Informada...")
1663:                     loc_oPagina.txt_4c_Data.SetFocus()
1664:                 ELSE
1665:                     IF EMPTY(loc_cGrupo)
1666:                     MsgAviso("O Grupo Deve Ser Informado...")
1667:                     IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1668:                         loc_oPagina.txt_4c_Grupo.SetFocus()
1669:                     ENDIF
1670:                 ELSE
1671:                     IF EMPTY(loc_cConta)
1672:                     MsgAviso("A Conta Deve Ser Informada...")
1673:                     IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1674:                         loc_oPagina.txt_4c_Conta.SetFocus()
1675:                     ENDIF
1676:                 ELSE
1677:                     *-- Validar DataCc >= Data
1678:                     IF VARTYPE(loc_dDataCc) = "D" AND !EMPTY(loc_dDataCc) AND loc_dDataCc < loc_dData
1679:                         MsgAviso("A Data de Lan" + CHR(231) + "amento N" + CHR(227) + "o Pode Ser" + CHR(13) + ;
1680:                                  "Menor Que a Data de Fechamento...")
1681:                         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "cnt_4c_Conversao", 5)
1682:                             IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao, "txt_4c_DataCc", 5)
1683:                                 loc_oPagina.cnt_4c_Resultado.cnt_4c_Conversao.txt_4c_DataCc.SetFocus()
1684:                             ENDIF
1685:                         ENDIF
1686:                     ELSE
1687:                         IF MsgConfirma("Esta Opera" + CHR(231) + CHR(227) + "o Ir" + CHR(225) + ;
1688:                                        " Encerrar o Balan" + CHR(231) + "o da Conta " + ;
1689:                                        loc_cGrupo + " / " + loc_cConta + "." + CHR(13) + CHR(13) + ;
1690:                                        "As Diferen" + CHR(231) + "as Selecionadas Na Tabela de Materiais " + ;
1691:                                        "Ser" + CHR(227) + "o Lan" + CHR(231) + "adas Nesta Conta..." + ;
1692:                                        CHR(13) + CHR(13) + "Deseja Prosseguir ?", ;
1693:                                        "Aten" + CHR(231) + CHR(227) + "o!!!")
1694:                         THIS.FormParaBO()
1695:                         IF THIS.this_oBusinessObject.Salvar()
1696:                             THIS.this_lFechamento = .T.
1697:                             THIS.AlternarPagina(1)
1698:                             loc_lResultado = .T.
1699:                         ENDIF
1700:                         ENDIF
1701:                     ENDIF
1702:                     ENDIF
1703:                     ENDIF
1704:                 ENDIF
1705:             ELSE
1706:                 IF THIS.this_lFechamento
1707:                     THIS.FormParaBO()
1708:                     IF THIS.this_oBusinessObject.Salvar()
1709:                         THIS.this_lFechamento = .T.
1710:                         THIS.AlternarPagina(1)
1711:                         loc_lResultado = .T.
1712:                     ENDIF
1713:                 ELSE
1714:                     *-- Modo posicao (!Fechamento): apenas reverter e voltar
1715:                     SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1716:                     THIS.this_lFechamento = .T.
1717:                     THIS.AlternarPagina(1)
1718:                     loc_lResultado = .T.
1719:                 ENDIF

*-- Linhas 1730 a 1808:
1730:     * BtnSalvarClick - Alias canonico de BtnConfirmarClick
1731:     * O botao real e cmd_4c_Confirmar (padrao CLAUDE.md regra #10 para SAIDA).
1732:     * Este metodo existe para atender contratos que esperam o nome "Salvar".
1733:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1734:     *==========================================================================
1735:     PROCEDURE BtnSalvarClick()
1736:         RETURN THIS.BtnConfirmarClick()
1737:     ENDPROC
1738: 
1739:     *==========================================================================
1740:     * BtnCancelarClick - Cancela edicao e retorna para Page1
1741:     * Legado: Cancelar.Click (Grupo_Salva no legado)
1742:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1743:     *==========================================================================
1744:     PROCEDURE BtnCancelarClick()
1745:         LOCAL loc_lResultado
1746:         loc_lResultado = .F.
1747: 
1748:         TRY
1749:             THIS.this_lCancelar = .T.
1750:             *-- Rollback da transacao SQL corrente
1751:             SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1752:             THIS.this_lFechamento = .T.
1753:             THIS.AlternarPagina(1)
1754:             loc_lResultado = .T.
1755:         CATCH TO loc_oErro
1756:             MsgErro("Erro em BtnCancelarClick:" + CHR(13) + loc_oErro.Message, "FormFea")
1757:         ENDTRY
1758: 
1759:         RETURN loc_lResultado
1760:     ENDPROC
1761: 
1762:     *==========================================================================
1763:     * IncluirHistorico - Insere registro nos cursores TmpHist e TmpHistC
1764:     * Traducao de inclui_historico (legado). Chamado em SCAN loops dentro
1765:     * de ProcessarBalanco para cada movimento de entrada/saida.
1766:     * PUBLIC: BINDEVENT/SCAN exige metodo publico (CLAUDE.md regra #3)
1767:     *==========================================================================
1768:     PROCEDURE IncluirHistorico(par_cArquivo, par_cTipoConta, par_cTipo, ;
1769:                                par_nValor, par_nPeso, par_nPesoFabr, ;
1770:                                par_cGrupoo, par_cContao, par_cGrupod, par_cContad)
1771:         LOCAL loc_nEntrada, loc_nSaida, loc_nPEntrada, loc_nPSaida
1772:         LOCAL loc_nPfEntrada, loc_nPfSaida
1773:         LOCAL loc_cGrupo, loc_cConta, loc_cGrupo2, loc_cConta2
1774: 
1775:         STORE 0 TO loc_nEntrada, loc_nSaida, loc_nPEntrada, loc_nPSaida, loc_nPfEntrada, loc_nPfSaida
1776: 
1777:         IF par_cTipo = "E"
1778:             loc_nEntrada   = par_nValor
1779:             loc_nPEntrada  = par_nPeso
1780:             loc_nPfEntrada = par_nPesoFabr
1781:         ELSE
1782:             loc_nSaida   = par_nValor
1783:             loc_nPSaida  = par_nPeso
1784:             loc_nPfSaida = par_nPesoFabr
1785:         ENDIF
1786: 
1787:         IF par_cArquivo = "Nens"
1788:             SELECT LocalNens
1789:             IF par_cTipoConta = "O"
1790:                 loc_cGrupo  = LocalNens.Grupoos
1791:                 loc_cConta  = LocalNens.Contaos
1792:                 loc_cGrupo2 = LocalNens.Grupods
1793:                 loc_cConta2 = LocalNens.Contads
1794:             ELSE
1795:                 loc_cGrupo  = LocalNens.Grupods
1796:                 loc_cConta  = LocalNens.Contads
1797:                 loc_cGrupo2 = LocalNens.Grupoos
1798:                 loc_cConta2 = LocalNens.Contaos
1799:             ENDIF
1800:         ELSE
1801:             SELECT LocalEest
1802:             loc_cGrupo  = IIF(TYPE("par_cGrupoo") = "C", par_cGrupoo, SPACE(10))
1803:             loc_cConta  = IIF(TYPE("par_cContao") = "C", par_cContao, SPACE(10))
1804:             loc_cGrupo2 = IIF(TYPE("par_cGrupod") = "C", par_cGrupod, SPACE(10))
1805:             loc_cConta2 = IIF(TYPE("par_cContad") = "C", par_cContad, SPACE(10))
1806:         ENDIF
1807: 
1808:         IF loc_nEntrada = 0 AND loc_nSaida = 0 AND loc_nPEntrada = 0 AND loc_nPSaida = 0

*-- Linhas 1845 a 1899:
1845:     *==========================================================================
1846:     * BtnProcessarClick - Valida campos e executa ProcessarBalanco
1847:     * Legado: Processar.Click (o maior metodo do formulario: ~1475 linhas)
1848:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1849:     *==========================================================================
1850:     PROCEDURE BtnProcessarClick()
1851:         LOCAL loc_lResultado
1852:         loc_lResultado = .F.
1853: 
1854:         TRY
1855:             loc_lResultado = THIS.ProcessarBalanco()
1856:         CATCH TO loc_oErro
1857:             MsgErro("Erro em BtnProcessarClick:" + CHR(13) + loc_oErro.Message + ;
1858:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1859:                     CHR(13) + "Proc: " + loc_oErro.Procedure, "FormFea - Processar Balan" + CHR(231) + "o")
1860:         ENDTRY
1861: 
1862:         RETURN loc_lResultado
1863:     ENDPROC
1864: 
1865:     *==========================================================================
1866:     * ProcessarBalanco - Logica completa de processamento do balanco de estoque
1867:     * Traducao do legado Processar.Click (~1475 linhas) para nova arquitetura
1868:     *
1869:     * Fluxo:
1870:     *  1. Validacao de campos obrigatorios
1871:     *  2. ZAP de cursores temporarios
1872:     *  3. Pre-carregamento de lookups
1873:     *  4. SQL para buscar movimentacoes (LocalNens/LocalEest/LocalPesa)
1874:     *  5. SCAN de movimentacoes -> TmpResumo / TmpOpera / TmpConta / TmpResFas
1875:     *  6. Calculo de saldos finais (CrUltBal / CrSaldoI)
1876:     *  7. Calculo de cotacoes (TmpCot)
1877:     *  8. Calcular indice de produtividade
1878:     *  9. Se Fechamento: INSERT em CrSigCdFea
1879:     * 10. Exibir cnt_4c_Resultado
1880:     *==========================================================================
1881:     PROTECTED FUNCTION ProcessarBalanco()
1882:         LOCAL loc_oPagina, loc_cEmpr
1883:         LOCAL loc_cGrupo, loc_cConta, loc_dData, loc_nCodigo, loc_nLote
1884:         LOCAL loc_pDtI, loc_pDtF, loc_llFalse, loc_llTrue
1885:         LOCAL loc_cQuery, loc_cUpdate, loc_cSql, loc_cEdn, loc_cEGE
1886:         LOCAL loc_cMatSec, loc_nFalhaAdmitida, loc_llTipoQ, loc_llGrvPrz
1887:         LOCAL loc_cMaterial, loc_cMatResFa, loc_cOperacao
1888:         LOCAL loc_lOrigem, loc_lDestino, loc_lOrigemF, loc_lDestinoF
1889:         LOCAL loc_nPesoTotal, loc_nQtde, loc_nPeso, loc_nFalha
1890:         LOCAL loc_cCodCor, loc_cCodTam
1891:         LOCAL loc_cGrupoD, loc_cContaD
1892:         LOCAL loc_nNumFape, loc_nTrabalhado, loc_nTrabalhadB
1893:         LOCAL loc_nSaldoi, loc_nPesagem
1894:         LOCAL loc_cMoeda, loc_nCusto, loc_nCota
1895:         LOCAL loc_dDataUBal, loc_nNdFechas, loc_nCodigosFcx
1896:         LOCAL loc_cMatPrev, loc_cMatOuro
1897:         LOCAL loc_loBarra
1898: 
1899:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1905 a 1982:
1905:         IF THIS.this_cPcEscolha <> "INSERIR"
1906:             RETURN .F.
1907:         ENDIF
1908: 
1909:         *-- Ler valores dos campos
1910:         loc_dData  = loc_oPagina.txt_4c_Data.Value
1911:         loc_cGrupo = ""
1912:         loc_cConta = ""
1913:         loc_nLote  = 0
1914:         loc_nCodigo = IIF(VARTYPE(loc_oPagina.txt_4c_Codigo.Value) = "N", loc_oPagina.txt_4c_Codigo.Value, 0)
1915: 
1916:         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1917:             loc_cGrupo = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
1918:         ENDIF
1919:         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1920:             loc_cConta = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
1921:         ENDIF
1922:         IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5) AND !THIS.this_lFechamento
1923:             loc_nLote = NVL(loc_oPagina.txt_4c_Lote.Value, 0)
1924:         ENDIF
1925: 
1926:         *-- Validar campos obrigatorios
1927:         IF EMPTY(loc_dData)
1928:             MsgAviso("A Data Deve Ser Informada...")
1929:             loc_oPagina.txt_4c_Data.SetFocus()
1930:             RETURN .F.
1931:         ENDIF
1932: 
1933:         IF EMPTY(loc_cGrupo)
1934:             MsgAviso("O Grupo Deve Ser Informado...")
1935:             IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
1936:                 loc_oPagina.txt_4c_Grupo.SetFocus()
1937:             ENDIF
1938:             RETURN .F.
1939:         ENDIF
1940: 
1941:         IF EMPTY(loc_cConta)
1942:             MsgAviso("A Conta Deve Ser Informada...")
1943:             IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
1944:                 loc_oPagina.txt_4c_Conta.SetFocus()
1945:             ENDIF
1946:             RETURN .F.
1947:         ENDIF
1948: 
1949:         SQLEXEC(gnConnHandle, "IF @@TRANCOUNT > 0 ROLLBACK")
1950: 
1951:         *-- Ocultar resultado + resetar EntraPeso
1952:         loc_oPagina.cnt_4c_Resultado.Visible = .F.
1953:         THIS.this_lEntraPeso = .F.
1954: 
1955:         *-- ZAP / CREATE cursores temporarios
1956:         IF USED("TmpCot")
1957:             ZAP IN TmpCot
1958:         ELSE
1959:             CREATE CURSOR TmpCot (Cmoes C(10), Valos N(18,6))
1960:             INDEX ON Cmoes TAG Cmoes
1961:             SET ORDER TO Cmoes
1962:         ENDIF
1963: 
1964:         IF USED("TmpConta")
1965:             ZAP IN TmpConta
1966:             SELECT TmpConta
1967:             SET ORDER TO GrConta
1968:         ELSE
1969:             CREATE CURSOR TmpConta (Grupo C(10), Conta C(10), Nome C(80))
1970:             INDEX ON Grupo + Conta TAG GrConta
1971:             SET ORDER TO GrConta
1972:         ENDIF
1973: 
1974:         IF USED("TmpHist")
1975:             ZAP IN TmpHist
1976:         ELSE
1977:             CREATE CURSOR TmpHist (Grupo C(10), Conta C(10), CMats C(14), TpOps C(15), Datas D, ;
1978:                                    QtdeEnts N(12,3), QtdeSais N(12,3), Dopps C(15), ;
1979:                                    Numps N(10), cUnis C(10), Grupo2 C(10), Conta2 C(10), ;
1980:                                    PesoEnts N(12,3), PesoSais N(12,3), Nenvs N(10), ;
1981:                                    Obss C(100), Opers C(1), PesoFabre N(12,3), PesoFabrs N(12,3), ;
1982:                                    cUnips C(10), Emps C(3), nLotes N(6))

*-- Linhas 2142 a 2185:
2142:         ENDIF
2143: 
2144:         IF !EMPTY(loc_dDataUBal) AND loc_dDataUBal > loc_dData
2145:             MsgAviso("A Data N" + CHR(227) + "o Pode Ser Menor Que o " + CHR(218) + ;
2146:                      "ltimo Balan" + CHR(231) + "o..." + CHR(13) + CHR(13) + ;
2147:                      "Data do " + CHR(218) + "ltimo Balan" + CHR(231) + "o : " + DTOC(loc_dDataUBal))
2148:             loc_oPagina.txt_4c_Data.SetFocus()
2149:             RETURN .F.
2150:         ENDIF
2151: 
2152:         *-- Atualizar Datais no FCX com data do ultimo balanco
2153:         IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
2154:             SELECT crSigCdFcx
2155:             REPLACE crSigCdFcx.Datais WITH loc_dDataUBal
2156:         ENDIF
2157: 
2158:         *-- Parametros de data para SQL parametrizado
2159:         loc_pDtI = fDtoSQL(loc_dDataUBal)
2160:         loc_pDtF = fDtoSQL(loc_dData, "23:59:59")
2161: 
2162:         *-- Dados da empresa (EmpBals)
2163:         loc_cSql = "SELECT TOP 1 * FROM SigCdEmp WHERE Cemps = " + EscaparSQL(loc_cEmpr)
2164:         =SQLEXEC(gnConnHandle, loc_cSql, "LocalEmp")
2165:         LOCAL loc_cEmpBals
2166:         loc_cEmpBals = ""
2167:         IF USED("LocalEmp") AND !EOF("LocalEmp") AND PEMSTATUS(LocalEmp, "EmpBals", 5)
2168:             loc_cEmpBals = ALLTRIM(NVL(LocalEmp.EmpBals, ""))
2169:         ENDIF
2170: 
2171:         *==========================================================================
2172:         *-- MOVIMENTACOES DE PRODUCAO (LocalNens / LocalNensI)
2173:         *==========================================================================
2174:         loc_cQuery = "SELECT Datas, Dopps, GrupoOs, ContaOs, GrupoDs, ContaDs, Emps, Numps, " + ;
2175:                      "Obss, cIdChaves, EmpDnPs, nLotes " + ;
2176:                      "FROM SigCdNec " + ;
2177:                      "WHERE ( Emps = " + EscaparSQL(loc_cEmpr) + ;
2178:                      IIF(!EMPTY(loc_cEmpBals), " OR Emps = " + EscaparSQL(loc_cEmpBals), "") + " )" + ;
2179:                      " AND Datas BETWEEN ?loc_pDtI AND ?loc_pDtF" + ;
2180:                      " AND ((GrupoDs = " + EscaparSQL(loc_cGrupo) + ;
2181:                      " AND ContaDs = " + EscaparSQL(loc_cConta) + ;
2182:                      " AND ProcdBal = ?loc_llFalse) OR (GrupoOs = " + EscaparSQL(loc_cGrupo) + ;
2183:                      " AND ContaOs = " + EscaparSQL(loc_cConta) + ;
2184:                      " AND ProcBals = ?loc_llFalse))" + ;
2185:                      IIF(loc_nLote > 0, " AND nLotes = " + TRANSFORM(loc_nLote), "") + ;

*-- Linhas 2282 a 2325:
2282:         *-- SCAN PRINCIPAL: Movimentacoes de Producao (LocalNens)
2283:         *==========================================================================
2284:         SELECT LocalNens
2285:         loc_loBarra = CREATEOBJECT("fwprogressbar", ;
2286:                       "Processando Mov. de Produ" + CHR(231) + CHR(227) + "o...", ;
2287:                       RECCOUNT("LocalNens"))
2288:         loc_loBarra.Show
2289: 
2290:         SCAN
2291:             loc_loBarra.Update(.T.)
2292: 
2293:             loc_cEdn = LocalNens.Emps + LocalNens.Dopps + STR(LocalNens.Numps, 10)
2294: 
2295:             =SEEK(LocalNens.Dopps, "LocalOpp", "Dopps")
2296: 
2297:             loc_lOrigem   = .F.
2298:             loc_lDestino  = .F.
2299:             loc_cMaterial = SPACE(14)
2300:             loc_cMatResFa = SPACE(14)
2301: 
2302:             IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
2303:                LocalOpp.Origems = 1 AND LocalNens.GrupoOs = loc_cGrupo AND ;
2304:                LocalNens.ContaOs = loc_cConta AND INLIST(LocalOpp.EstOrigs, 1, 2)
2305:                 loc_lOrigem = .T.
2306:             ENDIF
2307:             IF USED("LocalOpp") AND !EOF("LocalOpp") AND ;
2308:                LocalOpp.Destinos = 1 AND LocalNens.GrupoDs = loc_cGrupo AND ;
2309:                LocalNens.ContaDs = loc_cConta AND INLIST(LocalOpp.EstDests, 1, 2)
2310:                 loc_lDestino = .T.
2311:             ENDIF
2312: 
2313:             IF !loc_lOrigem AND !loc_lDestino
2314:                 LOOP
2315:             ENDIF
2316: 
2317:             loc_nPesoTotal = 0
2318:             loc_llGrvPrz   = .F.
2319: 
2320:             *-- Scan interno: itens do movimento (LocalNensI)
2321:             SELECT LocalNensI
2322:             SEEK loc_cEdn
2323:             SCAN WHILE EmpDNPs = loc_cEdn
2324:                 *-- Determinar material baseado em UnifBals
2325:                 IF USED("TmpGccr") AND !EOF("TmpGccr") AND TmpGccr.UnifBals = 4

*-- Linhas 2687 a 2730:
2687: 
2688:         *-- SCAN: Movimentacoes de Estoque
2689:         SELECT LocalEest
2690:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Processando Mov. de Estoque", RECCOUNT("LocalEest"))
2691:         loc_loBarra.Show
2692: 
2693:         SCAN
2694:             loc_loBarra.Update(.T.)
2695:             loc_cEdn = LocalEest.Emps + LocalEest.Dopes + STR(LocalEest.Numes, 6)
2696: 
2697:             =SEEK(LocalEest.Dopes, "crSigCdOpe", "Dopes")
2698: 
2699:             loc_lOrigem   = .F.
2700:             loc_lDestino  = .F.
2701:             loc_lOrigemF  = .F.
2702:             loc_lDestinoF = .F.
2703: 
2704:             IF USED("crSigCdOpe") AND !EOF("crSigCdOpe")
2705:                 IF crSigCdOpe.Estoqs = 1 AND (crSigCdOpe.EstOrigs = 4 OR crSigCdOpe.Opers = 3) AND LocalEest.Emps = loc_cEmpr
2706:                     IF crSigCdOpe.Origems = 1 AND LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta
2707:                         loc_lOrigem = .T.
2708:                     ELSE
2709:                         IF crSigCdOpe.Destinos = 1 AND LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
2710:                             loc_lDestino = .T.
2711:                         ENDIF
2712:                     ENDIF
2713:                 ELSE
2714:                     IF crSigCdOpe.Estoqs = 1 AND crSigCdOpe.Origems = 1 AND ;
2715:                        LocalEest.GrupoOs = loc_cGrupo AND LocalEest.ContaOs = loc_cConta AND LocalEest.Emps = loc_cEmpr
2716:                         IF INLIST(crSigCdOpe.EstOrigs, 1, 2)
2717:                             loc_lOrigem = .T.
2718:                         ENDIF
2719:                     ENDIF
2720:                     IF crSigCdOpe.Estoqs = 1 AND crSigCdOpe.Destinos = 1 AND ;
2721:                        LocalEest.GrupoDs = loc_cGrupo AND LocalEest.ContaDs = loc_cConta
2722:                         IF INLIST(crSigCdOpe.EstDests, 1, 2)
2723:                             loc_lDestino = .T.
2724:                         ENDIF
2725:                     ENDIF
2726:                 ENDIF
2727:             ENDIF
2728: 
2729:             IF !loc_lOrigem AND !loc_lDestino
2730:                 LOOP

*-- Linhas 3308 a 3351:
3308: 
3309:         *-- Calcular saldos finais para cada material em TmpResumo
3310:         SELECT TmpResumo
3311:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("TmpResumo"))
3312:         loc_loBarra.Show
3313:         loc_cMatPrev = SPACE(14)
3314: 
3315:         SCAN
3316:             loc_loBarra.Update(.T.)
3317:             STORE 0 TO loc_nSaldoi, loc_nPesagem
3318: 
3319:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3320:             IF !loc_llTipoQ AND TmpResumo.CMats <> loc_cMatPrev
3321:                 loc_nFalhaAdmitida = 0
3322:                 loc_cMatPrev = TmpResumo.CMats
3323:             ENDIF
3324: 
3325:             SELECT CrSaldoI
3326:             =SEEK(TmpResumo.CMats)
3327:             loc_nSaldoi = IIF(EOF("CrSaldoI"), 0, CrSaldoI.Pesagems)
3328: 
3329:             SELECT TmpOpera
3330:             =SEEK(TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats)
3331:             loc_nTrabalhado = 0
3332:             loc_nTrabalhadB = 0
3333:             SCAN WHILE CMats = TmpResumo.CMats
3334:                 =SEEK(TmpOpera.TpOps, "crSigOpOpt", "Cods")
3335:                 IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND ;
3336:                    USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
3337:                    crSigOpOpt.PFalhas <> 0 AND TmpPro.Varias = 1 AND ;
3338:                    crSigOpOpt.TFalhas <> "Q" AND TmpOpera.AplicFlhs <> 2 AND ;
3339:                    crSigCdPam.GrTrans <> loc_cGrupo
3340:                     loc_nFalhaAdmitida = loc_nFalhaAdmitida + ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3)
3341:                     REPLACE PFalha WITH crSigOpOpt.PFalhas, ;
3342:                             Falha  WITH ROUND(TmpOpera.QtdeBSais * crSigOpOpt.PFalhas / 100, 3) IN TmpOpera
3343:                 ENDIF
3344:                 IF USED("crSigOpOpt") AND !EOF("crSigOpOpt") AND ;
3345:                    (crSigOpOpt.Trabas = 1 OR EMPTY(TmpOpera.TpOps))
3346:                     loc_nTrabalhado = loc_nTrabalhado + TmpOpera.QtdeSais
3347:                     loc_nTrabalhadB = loc_nTrabalhadB + TmpOpera.QtdeBSais
3348:                 ENDIF
3349:             ENDSCAN
3350:             IF loc_nTrabalhadB <> 0
3351:                 loc_nTrabalhado = loc_nTrabalhadB

*-- Linhas 3372 a 3415:
3372: 
3373:         *-- Processar registros do saldo anterior que nao estao em TmpResumo
3374:         SELECT CrSaldoI
3375:         loc_loBarra = CREATEOBJECT("fwprogressbar", "Preparando Resumos", RECCOUNT("CrSaldoI"))
3376:         loc_loBarra.Show
3377:         SCAN
3378:             loc_loBarra.Update(.T.)
3379:             IF CrSaldoI.Pesagems = 0
3380:                 LOOP
3381:             ENDIF
3382:             =SEEK(CrSaldoI.Cpros, "TmpPro", "CPros")
3383:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3384:             =SEEK(LocalGru.Mercs, "LocalGgrp", "Codigos")
3385:             loc_nSaldoi = CrSaldoI.Pesagems
3386:             SELECT TmpResumo
3387:             LOCATE FOR CMats = CrSaldoI.Cpros
3388:             IF EOF()
3389:                 INSERT INTO TmpResumo (Grupo, Conta, CMats, CUnis, Varias, Agregas, Visivel) ;
3390:                     VALUES (loc_cGrupo, loc_cConta, CrSaldoI.Cpros, TmpPro.CUnis, TmpPro.Varias, LocalGru.nAgMts, .T.)
3391:                 SELECT TmpResumo
3392:                 REPLACE Saldoi WITH loc_nSaldoi, FReal WITH loc_nSaldoi, ;
3393:                         FAdmin WITH 0, Saldof WITH loc_nSaldoi, PfTrabs WITH 0
3394:             ENDIF
3395:         ENDSCAN
3396: 
3397:         *-- Construir tabela de cotacoes (TmpCot)
3398:         SELECT TmpResumo
3399:         SCAN
3400:             =SEEK(TmpResumo.CMats, "TmpPro", "CPros")
3401:             =SEEK(TmpPro.Cgrus, "LocalGru", "Cgrus")
3402: 
3403:             loc_nCusto = 0
3404:             loc_cMoeda = ""
3405: 
3406:             IF USED("crSigCdPam") AND !EOF("crSigCdPam") AND crSigCdPam.AcertBals = 1
3407:                 loc_nCusto = TmpPro.Custofs
3408:                 loc_cMoeda = ALLTRIM(TmpPro.MoeCusfs)
3409:             ELSE
3410:                 LOCAL loc_pDtHist1, loc_pDtHist2
3411:                 loc_pDtHist1 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData))
3412:                 loc_pDtHist2 = fDtoSQL(IIF(USED("crSigCdFcx") AND !EOF("crSigCdFcx"), crSigCdFcx.Datas, loc_dData), "23:59:59")
3413:                 loc_cQuery = "SELECT TOP 1 cIdChaves, UnitMeds FROM SigMvHst " + ;
3414:                              "WHERE Emps = " + EscaparSQL(loc_cEmpr) + ;
3415:                              " AND Cpros = " + EscaparSQL(ALLTRIM(TmpResumo.CMats)) + ;

*-- Linhas 3466 a 3510:
3466:         SELECT TmpResumo
3467:         GO TOP
3468: 
3469:         IF EOF("TmpResumo")
3470:             MsgAviso("Nenhuma Informa" + CHR(231) + CHR(227) + "o Foi Selecionada...")
3471:             loc_oPagina.txt_4c_Data.SetFocus()
3472:             RETURN .F.
3473:         ENDIF
3474: 
3475:         *-- Calcular indice de produtividade
3476:         SELECT a.Grupo, a.Conta, a.CMats, COUNT(a.TpOps) AS TotTpOp, ;
3477:                SUM(c.IndProds) AS TotIndProd, d.Freal, SUM(a.QtdeSais) AS TotQtde ;
3478:             FROM TmpOpera a, crSigOpOpt c, TmpResumo d ;
3479:             WHERE !EMPTY(a.QtdeSais) AND a.TpOps = c.Cods AND c.IndProds > 0 AND ;
3480:                   d.Grupo + d.Conta + d.CMats = a.Grupo + a.Conta + a.CMats ;
3481:             GROUP BY a.Grupo, a.Conta, a.CMats, d.Freal ;
3482:             INTO CURSOR TmpIndProd
3483: 
3484:         IF RECCOUNT("TmpIndProd") > 0
3485:             SELECT a.Grupo, a.Conta, a.CMats, ;
3486:                    ((a.TotQtde + a.Freal) * ((a.TotIndProd / a.TotTpOp) / 100)) AS IndProd ;
3487:                 FROM TmpIndProd a INTO CURSOR TmpIndProd
3488:             UPDATE TmpResumo SET IndProd = TmpIndProd.IndProd ;
3489:                 WHERE TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats = ;
3490:                       TmpIndProd.Grupo + TmpIndProd.Conta + TmpIndProd.CMats
3491:         ENDIF
3492: 
3493:         *-- Atualizar grdMov RecordSource (controle de Fase 6)
3494:         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "grdMov", 5)
3495:             loc_oPagina.cnt_4c_Resultado.grdMov.RecordSource = ""
3496:             SELECT Dopps, 1 AS nMarcas FROM TmpHist GROUP BY Dopps INTO CURSOR CrOpp READWRITE
3497:             WITH loc_oPagina.cnt_4c_Resultado.grdMov
3498:                 .RecordSource          = "crOpp"
3499:                 .Column1.ControlSource = "crOpp.nMarcas"
3500:                 .Column2.ControlSource = "crOpp.Dopps"
3501:                 .Column1.Width = 17
3502:                 .Column2.Width = 150
3503:                 .Refresh()
3504:             ENDWITH
3505:         ENDIF
3506: 
3507:         *-- Inserir no CrSigCdFea se Fechamento
3508:         IF THIS.this_lFechamento
3509:             loc_nNumFape = fGerUniqueKey(loc_cEmpr + "SigCdFea")
3510:             SELECT TmpResumo

*-- Linhas 3544 a 3587:
3544:     * Chamado por ConfigurarPaginaDados() apos criar o container vazio.
3545:     * ColumnCount e RecordSource ficam FORA de WITH (Problema 36 VFP9).
3546:     *==========================================================================
3547:     PROTECTED PROCEDURE ConfigurarResultado(par_oCnt)
3548:         LOCAL loc_lResultado, loc_oGrd, loc_oPage
3549:         loc_lResultado = .F.
3550:         TRY
3551:             *-- Shape3: barra de cabecalho periodo (top=7,left=8,w=434,h=31)
3552:             par_oCnt.AddObject("shp_4c_Shape3", "Shape")
3553:             WITH par_oCnt.shp_4c_Shape3
3554:                 .Top           = 7
3555:                 .Left          = 8
3556:                 .Width         = 434
3557:                 .Height        = 31
3558:                 .SpecialEffect = 1
3559:                 .BackColor     = RGB(204, 204, 204)
3560:                 .BackStyle     = 1
3561:                 .BorderStyle   = 1
3562:                 .Curvature     = 0
3563:                 .Visible       = .T.
3564:             ENDWITH
3565: 
3566:             *-- Label18: "Periodo :" (top=15,left=19,w=45,h=15)
3567:             par_oCnt.AddObject("lbl_4c_Label18", "Label")
3568:             WITH par_oCnt.lbl_4c_Label18
3569:                 .Caption   = "Per" + CHR(237) + "odo :"
3570:                 .Top       = 15
3571:                 .Left      = 19
3572:                 .Width     = 45
3573:                 .Height    = 15
3574:                 .FontName  = "Tahoma"
3575:                 .FontSize  = 8
3576:                 .BackStyle = 0
3577:                 .AutoSize  = .F.
3578:                 .Visible   = .T.
3579:             ENDWITH
3580: 
3581:             *-- Get_Datai: data inicial (top=12,left=79,w=72,h=21)
3582:             par_oCnt.AddObject("Get_Datai", "TextBox")
3583:             WITH par_oCnt.Get_Datai
3584:                 .Value         = DATE()
3585:                 .Top           = 12
3586:                 .Left          = 79
3587:                 .Width         = 72

*-- Linhas 3872 a 3915:
3872:                 .SpecialEffect = 0
3873:                 .Visible       = .T.
3874:             ENDWITH
3875:             BINDEVENT(par_oCnt.Get_Pesagem, "Valid", THIS, "PesagemLostFocus")
3876: 
3877:             par_oCnt.AddObject("Get_FReal", "TextBox")
3878:             WITH par_oCnt.Get_FReal
3879:                 .Value         = 0
3880:                 .Top           = 190
3881:                 .Left          = 307
3882:                 .Width         = 109
3883:                 .Height        = 21
3884:                 .InputMask     = "999,999.999"
3885:                 .ReadOnly      = .T.
3886:                 .FontName      = "Tahoma"
3887:                 .FontSize      = 8
3888:                 .BackColor     = RGB(240, 240, 240)
3889:                 .BorderStyle   = 1
3890:                 .SpecialEffect = 0
3891:                 .Visible       = .T.
3892:             ENDWITH
3893: 
3894:             par_oCnt.AddObject("Get_FAdmitida", "TextBox")
3895:             WITH par_oCnt.Get_FAdmitida
3896:                 .Value         = 0
3897:                 .Top           = 213
3898:                 .Left          = 307
3899:                 .Width         = 109
3900:                 .Height        = 21
3901:                 .InputMask     = "999,999.999"
3902:                 .ReadOnly      = .T.
3903:                 .FontName      = "Tahoma"
3904:                 .FontSize      = 8
3905:                 .BackColor     = RGB(240, 240, 240)
3906:                 .BorderStyle   = 1
3907:                 .SpecialEffect = 0
3908:                 .Visible       = .T.
3909:             ENDWITH
3910: 
3911:             par_oCnt.AddObject("Get_Saldof", "TextBox")
3912:             WITH par_oCnt.Get_Saldof
3913:                 .Value         = 0
3914:                 .Top           = 235
3915:                 .Left          = 307

*-- Linhas 4100 a 4283:
4100:                 .Visible   = .T.
4101:             ENDWITH
4102: 
4103:             *-- op_ordem OptionGroup (top=318,left=801,w=49,h=36 - 2 botoes)
4104:             par_oCnt.AddObject("op_ordem", "OptionGroup")
4105:             WITH par_oCnt.op_ordem
4106:                 .Top         = 318
4107:                 .Left        = 801
4108:                 .Width       = 49
4109:                 .Height      = 36
4110:                 .Value       = 1
4111:                 .BackStyle   = 0
4112:                 .ButtonCount = 2
4113:                 WITH .Buttons(1)
4114:                     .Caption   = "1"
4115:                     .Top       = 2
4116:                     .Left      = 2
4117:                     .Width     = 45
4118:                     .Height    = 15
4119:                     .BackStyle = 0
4120:                 ENDWITH
4121:                 WITH .Buttons(2)
4122:                     .Caption   = "2"
4123:                     .Top       = 19
4124:                     .Left      = 2
4125:                     .Width     = 45
4126:                     .Height    = 15
4127:                     .BackStyle = 0
4128:                     .FontName  = "Tahoma"
4129:                     .FontSize  = 8
4130:                 ENDWITH
4131:             ENDWITH
4132: 
4133:             *-- chkPerdas (top=335,left=469,w=139,h=15)
4134:             par_oCnt.AddObject("chkPerdas", "CheckBox")
4135:             WITH par_oCnt.chkPerdas
4136:                 .Caption   = "Demonstrativo de Perdas"
4137:                 .Top       = 335
4138:                 .Left      = 469
4139:                 .Width     = 139
4140:                 .Height    = 15
4141:                 .Value     = 0
4142:                 .FontName  = "Tahoma"
4143:                 .FontSize  = 8
4144:                 .BackStyle = 0
4145:                 .Visible   = .T.
4146:             ENDWITH
4147:             BINDEVENT(par_oCnt.chkPerdas, "Click", THIS, "chkPerdasClick")
4148: 
4149:             *-- SelTudo (top=371,left=191,w=40,h=40)
4150:             par_oCnt.AddObject("SelTudo", "CommandButton")
4151:             WITH par_oCnt.SelTudo
4152:                 .Caption         = ""
4153:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
4154:                 .PicturePosition = 4
4155:                 .Top             = 371
4156:                 .Left            = 191
4157:                 .Width           = 40
4158:                 .Height          = 40
4159:                 .ToolTipText     = "Selecionar Todos"
4160:                 .Themes          = .T.
4161:                 .SpecialEffect   = 0
4162:                 .MousePointer    = 15
4163:                 .Visible         = .T.
4164:             ENDWITH
4165:             BINDEVENT(par_oCnt.SelTudo, "Click", THIS, "BtnSelTudoClick")
4166: 
4167:             *-- apaga (top=411,left=191,w=40,h=40)
4168:             par_oCnt.AddObject("apaga", "CommandButton")
4169:             WITH par_oCnt.apaga
4170:                 .Caption         = ""
4171:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4172:                 .PicturePosition = 4
4173:                 .Top             = 411
4174:                 .Left            = 191
4175:                 .Width           = 40
4176:                 .Height          = 40
4177:                 .ToolTipText     = "Desmarcar Todos"
4178:                 .Themes          = .T.
4179:                 .SpecialEffect   = 0
4180:                 .MousePointer    = 15
4181:                 .Visible         = .T.
4182:             ENDWITH
4183:             BINDEVENT(par_oCnt.apaga, "Click", THIS, "BtnApagaClick")
4184: 
4185:             *-- Visualizar (top=370,left=476,w=75,h=75)
4186:             par_oCnt.AddObject("Visualizar", "CommandButton")
4187:             WITH par_oCnt.Visualizar
4188:                 .Caption         = "Visualizar"
4189:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
4190:                 .PicturePosition = 13
4191:                 .Top             = 370
4192:                 .Left            = 476
4193:                 .Width           = 75
4194:                 .Height          = 75
4195:                 .FontName        = "Tahoma"
4196:                 .FontSize        = 8
4197:                 .Themes          = .T.
4198:                 .SpecialEffect   = 0
4199:                 .MousePointer    = 15
4200:                 .WordWrap        = .T.
4201:                 .Visible         = .T.
4202:             ENDWITH
4203:             BINDEVENT(par_oCnt.Visualizar, "Click", THIS, "BtnVisualizarBalancoClick")
4204: 
4205:             *-- Imprimir (top=370,left=551,w=75,h=75)
4206:             par_oCnt.AddObject("Imprimir", "CommandButton")
4207:             WITH par_oCnt.Imprimir
4208:                 .Caption         = "Imprimir"
4209:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
4210:                 .PicturePosition = 13
4211:                 .Top             = 370
4212:                 .Left            = 551
4213:                 .Width           = 75
4214:                 .Height          = 75
4215:                 .FontName        = "Tahoma"
4216:                 .FontSize        = 8
4217:                 .Themes          = .T.
4218:                 .SpecialEffect   = 0
4219:                 .MousePointer    = 15
4220:                 .WordWrap        = .T.
4221:                 .Visible         = .T.
4222:             ENDWITH
4223:             BINDEVENT(par_oCnt.Imprimir, "Click", THIS, "BtnImprimirBalancoClick")
4224: 
4225:             *-- Pesagem (top=294,left=892,w=75,h=75) - inicia oculto
4226:             par_oCnt.AddObject("Pesagem", "CommandButton")
4227:             WITH par_oCnt.Pesagem
4228:                 .Caption         = "Pesagem"
4229:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
4230:                 .PicturePosition = 13
4231:                 .Top             = 294
4232:                 .Left            = 892
4233:                 .Width           = 75
4234:                 .Height          = 75
4235:                 .FontName        = "Tahoma"
4236:                 .FontSize        = 8
4237:                 .Themes          = .T.
4238:                 .SpecialEffect   = 0
4239:                 .MousePointer    = 15
4240:                 .WordWrap        = .T.
4241:                 .Visible         = .F.
4242:             ENDWITH
4243:             BINDEVENT(par_oCnt.Pesagem, "Click", THIS, "BtnPesagemClick")
4244: 
4245:             *-- Label3: "Movimentacoes" (top=352,left=652,w=76,h=15)
4246:             par_oCnt.AddObject("lbl_4c_Label3", "Label")
4247:             WITH par_oCnt.lbl_4c_Label3
4248:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
4249:                 .Top       = 352
4250:                 .Left      = 652
4251:                 .Width     = 76
4252:                 .Height    = 15
4253:                 .FontName  = "Tahoma"
4254:                 .FontSize  = 8
4255:                 .BackStyle = 0
4256:                 .AutoSize  = .F.
4257:                 .Visible   = .T.
4258:             ENDWITH
4259: 
4260:             *-- grdMov (top=370,left=649,w=189,h=82,2 cols)
4261:             *-- RecordSource/ColumnCount FORA de WITH (Problema 36)
4262:             par_oCnt.AddObject("grdMov", "Grid")
4263:             par_oCnt.grdMov.ColumnCount  = 2
4264:             par_oCnt.grdMov.RecordSource = ""
4265:             WITH par_oCnt.grdMov
4266:                 .Top         = 370
4267:                 .Left        = 649
4268:                 .Width       = 189
4269:                 .Height      = 82
4270:                 .GridLines   = 1
4271:                 .HeaderHeight = 20
4272:                 .FontName    = "Tahoma"
4273:                 .FontSize    = 8
4274:                 .Visible     = .T.
4275:             ENDWITH
4276:             WITH par_oCnt.grdMov.Column1
4277:                 .Header1.Caption = ""
4278:                 .Width           = 20
4279:                 .Sparse          = .F.
4280:             ENDWITH
4281:             par_oCnt.grdMov.Column1.AddObject("Check1", "CheckBox")
4282:             WITH par_oCnt.grdMov.Column1.Check1
4283:                 .Caption   = ""

*-- Linhas 4294 a 4337:
4294:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4295:                 .Width           = 160
4296:             ENDWITH
4297:             BINDEVENT(par_oCnt.grdMov.Column1.Check1, "KeyPress", THIS, "GrdMovCheck1KeyPress")
4298: 
4299:             *-- Pagina pageframe interno (top=5,left=462,w=510,h=275,3 paginas)
4300:             par_oCnt.AddObject("Pagina", "PageFrame")
4301:             WITH par_oCnt.Pagina
4302:                 .Top       = 5
4303:                 .Left      = 462
4304:                 .Width     = 510
4305:                 .Height    = 275
4306:                 .PageCount = 3
4307:                 .Tabs      = .T.
4308:                 .FontName  = "Tahoma"
4309:                 .FontSize  = 8
4310:                 .Visible   = .T.
4311:             ENDWITH
4312:             par_oCnt.Pagina.Pages(1).Caption = "Entradas"
4313:             par_oCnt.Pagina.Pages(2).Caption = "Sa" + CHR(237) + "das"
4314:             par_oCnt.Pagina.Pages(3).Caption = "Resumo"
4315: 
4316:             *-- GradeEntradas (Pagina.Page1 top=7,left=10,w=484,h=207,5 cols)
4317:             par_oCnt.Pagina.Pages(1).AddObject("GradeEntradas", "Grid")
4318:             par_oCnt.Pagina.Pages(1).GradeEntradas.ColumnCount  = 5
4319:             par_oCnt.Pagina.Pages(1).GradeEntradas.RecordSource = "TmpOpera"
4320:             loc_oGrd = par_oCnt.Pagina.Pages(1).GradeEntradas
4321:             WITH loc_oGrd
4322:                 .Top          = 7
4323:                 .Left         = 10
4324:                 .Width        = 484
4325:                 .Height       = 207
4326:                 .ReadOnly     = .T.
4327:                 .GridLines    = 1
4328:                 .HeaderHeight = 20
4329:                 .FontName     = "Tahoma"
4330:                 .FontSize     = 8
4331:                 .Visible      = .T.
4332:             ENDWITH
4333:             WITH loc_oGrd.Column1
4334:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4335:                 .ControlSource   = "TmpOpera.TpOps"
4336:                 .Width           = 120
4337:             ENDWITH

*-- Linhas 4355 a 4399:
4355:                 .ControlSource   = "TmpOpera.PesoBEnts"
4356:                 .Width           = 80
4357:             ENDWITH
4358:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEntradasAfterRowColChange")
4359:             BINDEVENT(par_oCnt.Pagina.Pages(1), "Activate", THIS, "PaginaResultadoPage1Activate")
4360: 
4361:             *-- Get_TpOperacao em Page1 (top=220,left=10,w=484,h=23)
4362:             par_oCnt.Pagina.Pages(1).AddObject("Get_TpOperacao", "TextBox")
4363:             WITH par_oCnt.Pagina.Pages(1).Get_TpOperacao
4364:                 .Value         = ""
4365:                 .Top           = 220
4366:                 .Left          = 10
4367:                 .Width         = 484
4368:                 .Height        = 23
4369:                 .ReadOnly      = .T.
4370:                 .FontName      = "Tahoma"
4371:                 .FontSize      = 8
4372:                 .BackColor     = RGB(240, 240, 240)
4373:                 .BorderStyle   = 1
4374:                 .SpecialEffect = 0
4375:                 .Visible       = .T.
4376:             ENDWITH
4377: 
4378:             *-- GradeSaidas (Pagina.Page2 top=7,left=10,w=484,h=207,5 cols)
4379:             par_oCnt.Pagina.Pages(2).AddObject("GradeSaidas", "Grid")
4380:             par_oCnt.Pagina.Pages(2).GradeSaidas.ColumnCount  = 5
4381:             par_oCnt.Pagina.Pages(2).GradeSaidas.RecordSource = "TmpOpera"
4382:             loc_oGrd = par_oCnt.Pagina.Pages(2).GradeSaidas
4383:             WITH loc_oGrd
4384:                 .Top          = 7
4385:                 .Left         = 10
4386:                 .Width        = 484
4387:                 .Height       = 207
4388:                 .ReadOnly     = .T.
4389:                 .GridLines    = 1
4390:                 .HeaderHeight = 20
4391:                 .FontName     = "Tahoma"
4392:                 .FontSize     = 8
4393:                 .Visible      = .T.
4394:             ENDWITH
4395:             WITH loc_oGrd.Column1
4396:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4397:                 .ControlSource   = "TmpOpera.TpOps"
4398:                 .Width           = 120
4399:             ENDWITH

*-- Linhas 4417 a 4461:
4417:                 .ControlSource   = "TmpOpera.PesoBSais"
4418:                 .Width           = 80
4419:             ENDWITH
4420:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeSaidasAfterRowColChange")
4421:             BINDEVENT(par_oCnt.Pagina.Pages(2), "Activate", THIS, "PaginaResultadoPage2Activate")
4422: 
4423:             *-- Get_TpOperacao em Page2 (top=220,left=10,w=484,h=23)
4424:             par_oCnt.Pagina.Pages(2).AddObject("Get_TpOperacao", "TextBox")
4425:             WITH par_oCnt.Pagina.Pages(2).Get_TpOperacao
4426:                 .Value         = ""
4427:                 .Top           = 220
4428:                 .Left          = 10
4429:                 .Width         = 484
4430:                 .Height        = 23
4431:                 .ReadOnly      = .T.
4432:                 .FontName      = "Tahoma"
4433:                 .FontSize      = 8
4434:                 .BackColor     = RGB(240, 240, 240)
4435:                 .BorderStyle   = 1
4436:                 .SpecialEffect = 0
4437:                 .Visible       = .T.
4438:             ENDWITH
4439: 
4440:             *-- GradeResumo (Pagina.Page3 top=7,left=10,w=484,h=241,4 cols)
4441:             par_oCnt.Pagina.Pages(3).AddObject("GradeResumo", "Grid")
4442:             par_oCnt.Pagina.Pages(3).GradeResumo.ColumnCount  = 4
4443:             par_oCnt.Pagina.Pages(3).GradeResumo.RecordSource = "TmpResFas"
4444:             loc_oGrd = par_oCnt.Pagina.Pages(3).GradeResumo
4445:             WITH loc_oGrd
4446:                 .Top          = 7
4447:                 .Left         = 10
4448:                 .Width        = 484
4449:                 .Height       = 241
4450:                 .ReadOnly     = .T.
4451:                 .GridLines    = 1
4452:                 .HeaderHeight = 20
4453:                 .FontName     = "Tahoma"
4454:                 .FontSize     = 8
4455:                 .Visible      = .T.
4456:             ENDWITH
4457:             WITH loc_oGrd.Column1
4458:                 .Header1.Caption = "Fases"
4459:                 .ControlSource   = "TmpResFas.Fases"
4460:                 .Width           = 120
4461:             ENDWITH

*-- Linhas 4524 a 4545:
4524:                 .FontSize  = 8
4525:                 .BackStyle = 0
4526:                 .AutoSize  = .F.
4527:                 .Visible   = .T.
4528:             ENDWITH
4529:             par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_DataCc", "TextBox")
4530:             WITH par_oCnt.cnt_4c_Conversao.txt_4c_DataCc
4531:                 .Value         = DATE()
4532:                 .Top           = 28
4533:                 .Left          = 36
4534:                 .Width         = 80
4535:                 .Height        = 25
4536:                 .Format        = "K"
4537:                 .FontName      = "Tahoma"
4538:                 .FontSize      = 8
4539:                 .BackColor     = RGB(255, 255, 255)
4540:                 .BorderStyle   = 1
4541:                 .SpecialEffect = 0
4542:                 .Visible       = .T.
4543:             ENDWITH
4544:             par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_MOEDA", "TextBox")
4545:             WITH par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA

*-- Linhas 4556 a 4615:
4556:                 .SpecialEffect = 0
4557:                 .Visible       = .T.
4558:             ENDWITH
4559:             BINDEVENT(par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA, "KeyPress", THIS, "MoedaLostFocus")
4560:             par_oCnt.cnt_4c_Conversao.AddObject("cmd_4c_Cotacao", "CommandButton")
4561:             WITH par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao
4562:                 .Caption         = ""
4563:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_26.jpg"
4564:                 .PicturePosition = 4
4565:                 .Top             = 20
4566:                 .Left            = 202
4567:                 .Width           = 40
4568:                 .Height          = 40
4569:                 .ToolTipText     = "Cota" + CHR(231) + CHR(227) + "o"
4570:                 .Themes          = .T.
4571:                 .SpecialEffect   = 0
4572:                 .MousePointer    = 15
4573:                 .Visible         = .T.
4574:             ENDWITH
4575:             BINDEVENT(par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao, "Click", THIS, "CotacaoClick")
4576: 
4577:             *-- GradeMat (top=46,left=6,w=178,h=409,3 cols)
4578:             *-- RecordSource/ColumnCount FORA de WITH (Problema 36)
4579:             par_oCnt.AddObject("GradeMat", "Grid")
4580:             par_oCnt.GradeMat.ColumnCount  = 3
4581:             par_oCnt.GradeMat.RecordSource = "TmpResumo"
4582:             loc_oGrd = par_oCnt.GradeMat
4583:             WITH loc_oGrd
4584:                 .Top          = 46
4585:                 .Left         = 6
4586:                 .Width        = 178
4587:                 .Height       = 409
4588:                 .ReadOnly     = .F.
4589:                 .GridLines    = 1
4590:                 .HeaderHeight = 20
4591:                 .FontName     = "Tahoma"
4592:                 .FontSize     = 8
4593:                 .Visible      = .T.
4594:             ENDWITH
4595:             WITH loc_oGrd.Column1
4596:                 .Header1.Caption = "Material"
4597:                 .ControlSource   = "TmpResumo.CMats"
4598:                 .Width           = 110
4599:                 .ReadOnly        = .T.
4600:             ENDWITH
4601:             WITH loc_oGrd.Column2
4602:                 .Header1.Caption = ""
4603:                 .ControlSource   = "TmpResumo.Flag3"
4604:                 .Width           = 32
4605:                 .Sparse          = .F.
4606:             ENDWITH
4607:             loc_oGrd.Column2.AddObject("Check1", "CheckBox")
4608:             WITH loc_oGrd.Column2.Check1
4609:                 .Caption   = ""
4610:                 .Alignment = 0
4611:                 .ReadOnly  = .F.
4612:                 .Visible   = .T.
4613:                 .Top       = 9
4614:                 .Left      = 2
4615:                 .Height    = 17

*-- Linhas 4635 a 4942:
4635:                 .Width     = 22
4636:             ENDWITH
4637:             loc_oGrd.Column3.CurrentControl = "Check1"
4638:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeMatAfterRowColChange")
4639:             BINDEVENT(loc_oGrd.Column2.Check1, "InteractiveChange", THIS, "GradeMatCheck1Change")
4640: 
4641:             loc_lResultado = .T.
4642:         CATCH TO loc_oErro
4643:             MsgErro("Erro em ConfigurarResultado:" + CHR(13) + loc_oErro.Message + ;
4644:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
4645:         ENDTRY
4646:         RETURN loc_lResultado
4647:     ENDPROC
4648: 
4649:     *==========================================================================
4650:     * GrupoKeyPress / GrupoDblClick / AbrirLookupGrupo
4651:     * Lookup de Grupo de Balanco (TmpGccr pre-carregado)
4652:     *==========================================================================
4653:     PROCEDURE GrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4654:         IF INLIST(par_nKeyCode, 13, 9, 115)
4655:             THIS.AbrirLookupGrupo()
4656:             NODEFAULT
4657:         ENDIF
4658:     ENDPROC
4659: 
4660:     PROCEDURE GrupoDblClick()
4661:         THIS.AbrirLookupGrupo()
4662:     ENDPROC
4663: 
4664:     PROTECTED PROCEDURE AbrirLookupGrupo()
4665:         LOCAL loc_oPagina, loc_oBusca
4666:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4667:         TRY
4668:             IF !USED("TmpGccr")
4669:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4670:             ELSE
4671:                 SELECT TmpGccr
4672:                 GO TOP
4673:                 SET ORDER TO BalCodigo
4674:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4675:                 IF VARTYPE(loc_oBusca) = "O"
4676:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4677:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4678:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4679:                     loc_oBusca.Show()
4680:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4681:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4682:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4683:                         ENDIF
4684:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4685:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4686:                         ENDIF
4687:                     ENDIF
4688:                     loc_oBusca.Release()
4689:                     loc_oBusca = .NULL.
4690:                 ENDIF
4691:             ENDIF
4692:         CATCH TO loc_oErro
4693:             MsgErro("Erro em AbrirLookupGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
4694:         ENDTRY
4695:     ENDPROC
4696: 
4697:     *==========================================================================
4698:     * DGrupoKeyPress / DGrupoDblClick / AbrirLookupDGrupo
4699:     * Lookup de Grupo por Descricao
4700:     *==========================================================================
4701:     PROCEDURE DGrupoKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4702:         IF INLIST(par_nKeyCode, 13, 9, 115)
4703:             THIS.AbrirLookupDGrupo()
4704:             NODEFAULT
4705:         ENDIF
4706:     ENDPROC
4707: 
4708:     PROCEDURE DGrupoDblClick()
4709:         THIS.AbrirLookupDGrupo()
4710:     ENDPROC
4711: 
4712:     PROTECTED PROCEDURE AbrirLookupDGrupo()
4713:         LOCAL loc_oPagina, loc_oBusca
4714:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4715:         TRY
4716:             IF !USED("TmpGccr")
4717:                 MsgAviso("Dados de grupo n" + CHR(227) + "o carregados.")
4718:             ELSE
4719:                 SELECT TmpGccr
4720:                 SET ORDER TO BalDescrs
4721:                 GO TOP
4722:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4723:                 IF VARTYPE(loc_oBusca) = "O"
4724:                     loc_oBusca.this_cCursorDestino = "TmpGccr"
4725:                     loc_oBusca.mAddColuna("BalCodigo", "", "Grupo")
4726:                     loc_oBusca.mAddColuna("Descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
4727:                     loc_oBusca.Show()
4728:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpGccr")
4729:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Grupo", 5)
4730:                             loc_oPagina.txt_4c_Grupo.Value = ALLTRIM(TmpGccr.BalCodigo)
4731:                         ENDIF
4732:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
4733:                             loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(TmpGccr.Descrs)
4734:                         ENDIF
4735:                     ENDIF
4736:                     loc_oBusca.Release()
4737:                     loc_oBusca = .NULL.
4738:                 ENDIF
4739:                 SELECT TmpGccr
4740:                 SET ORDER TO BalCodigo
4741:             ENDIF
4742:         CATCH TO loc_oErro
4743:             MsgErro("Erro em AbrirLookupDGrupo:" + CHR(13) + loc_oErro.Message, "FormFea")
4744:         ENDTRY
4745:     ENDPROC
4746: 
4747:     *==========================================================================
4748:     * ContaKeyPress / ContaDblClick / AbrirLookupConta
4749:     * Lookup de Conta de Balanco (TmpCli pre-carregado)
4750:     *==========================================================================
4751:     PROCEDURE ContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4752:         IF INLIST(par_nKeyCode, 13, 9, 115)
4753:             THIS.AbrirLookupConta()
4754:             NODEFAULT
4755:         ENDIF
4756:     ENDPROC
4757: 
4758:     PROCEDURE ContaDblClick()
4759:         THIS.AbrirLookupConta()
4760:     ENDPROC
4761: 
4762:     PROTECTED PROCEDURE AbrirLookupConta()
4763:         LOCAL loc_oPagina, loc_oBusca
4764:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4765:         TRY
4766:             IF !USED("TmpCli")
4767:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4768:             ELSE
4769:                 SELECT TmpCli
4770:                 GO TOP
4771:                 SET ORDER TO BalCodigo
4772:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4773:                 IF VARTYPE(loc_oBusca) = "O"
4774:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4775:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4776:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4777:                     loc_oBusca.Show()
4778:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4779:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4780:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4781:                         ENDIF
4782:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4783:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4784:                         ENDIF
4785:                     ENDIF
4786:                     loc_oBusca.Release()
4787:                     loc_oBusca = .NULL.
4788:                 ENDIF
4789:             ENDIF
4790:         CATCH TO loc_oErro
4791:             MsgErro("Erro em AbrirLookupConta:" + CHR(13) + loc_oErro.Message, "FormFea")
4792:         ENDTRY
4793:     ENDPROC
4794: 
4795:     *==========================================================================
4796:     * DContaKeyPress / DContaDblClick / AbrirLookupDConta
4797:     * Lookup de Conta por Nome
4798:     *==========================================================================
4799:     PROCEDURE DContaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
4800:         IF INLIST(par_nKeyCode, 13, 9, 115)
4801:             THIS.AbrirLookupDConta()
4802:             NODEFAULT
4803:         ENDIF
4804:     ENDPROC
4805: 
4806:     PROCEDURE DContaDblClick()
4807:         THIS.AbrirLookupDConta()
4808:     ENDPROC
4809: 
4810:     PROTECTED PROCEDURE AbrirLookupDConta()
4811:         LOCAL loc_oPagina, loc_oBusca
4812:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
4813:         TRY
4814:             IF !USED("TmpCli")
4815:                 MsgAviso("Dados de conta n" + CHR(227) + "o carregados.")
4816:             ELSE
4817:                 SELECT TmpCli
4818:                 SET ORDER TO BalNome
4819:                 GO TOP
4820:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
4821:                 IF VARTYPE(loc_oBusca) = "O"
4822:                     loc_oBusca.this_cCursorDestino = "TmpCli"
4823:                     loc_oBusca.mAddColuna("BalCodigo", "", "Conta")
4824:                     loc_oBusca.mAddColuna("BalNome", "", "Nome")
4825:                     loc_oBusca.Show()
4826:                     IF loc_oBusca.this_lSelecionou AND !EOF("TmpCli")
4827:                         IF PEMSTATUS(loc_oPagina, "txt_4c_Conta", 5)
4828:                             loc_oPagina.txt_4c_Conta.Value = ALLTRIM(TmpCli.BalCodigo)
4829:                         ENDIF
4830:                         IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
4831:                             loc_oPagina.txt_4c_DConta.Value = ALLTRIM(TmpCli.BalNome)
4832:                         ENDIF
4833:                     ENDIF
4834:                     loc_oBusca.Release()
4835:                     loc_oBusca = .NULL.
4836:                 ENDIF
4837:                 SELECT TmpCli
4838:                 SET ORDER TO BalCodigo
4839:             ENDIF
4840:         CATCH TO loc_oErro
4841:             MsgErro("Erro em AbrirLookupDConta:" + CHR(13) + loc_oErro.Message, "FormFea")
4842:         ENDTRY
4843:     ENDPROC
4844: 
4845:     *==========================================================================
4846:     * MoedaLostFocus - Lookup de Moeda (SigCdMoe) ao sair do campo
4847:     * PUBLIC: BINDEVENT em txt_4c_MOEDA.LostFocus
4848:     *==========================================================================
4849:     PROCEDURE MoedaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
4850:         LOCAL loc_oCnt, loc_cMoeda, loc_oBusca
4851:         TRY
4852:             loc_oCnt  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.cnt_4c_Conversao
4853:             loc_cMoeda = ALLTRIM(NVL(loc_oCnt.txt_4c_MOEDA.Value, ""))
4854: 
4855:             IF EMPTY(loc_cMoeda)
4856:                 loc_oCnt.txt_4c_MOEDA.Value = ""
4857:             ELSE
4858:                 loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, "SigCdMoe", ;
4859:                     "crListaMoe", "CMoes", loc_cMoeda, "Sele" + CHR(231) + CHR(227) + "o")
4860:                 IF VARTYPE(loc_oBusca) = "O"
4861:                     IF !loc_oBusca.this_lSelecionou
4862:                         loc_oBusca.mAddColuna("CMoes", "", "Moeda")
4863:                         loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
4864:                         loc_oBusca.Show()
4865:                     ENDIF
4866:                     IF loc_oBusca.this_lSelecionou AND USED("crListaMoe") AND !EOF("crListaMoe")
4867:                         loc_oCnt.txt_4c_MOEDA.Value = ALLTRIM(crListaMoe.CMoes)
4868:                     ELSE
4869:                         loc_oCnt.txt_4c_MOEDA.Value = ""
4870:                     ENDIF
4871:                     IF USED("crListaMoe")
4872:                         USE IN crListaMoe
4873:                     ENDIF
4874:                     loc_oBusca.Release()
4875:                     loc_oBusca = .NULL.
4876:                 ENDIF
4877:             ENDIF
4878:         CATCH TO loc_oErro
4879:             MsgErro("Erro em MoedaLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
4880:         ENDTRY
4881:     ENDPROC
4882: 
4883:     *==========================================================================
4884:     * CotacaoClick - Abre form de cotacao de moeda
4885:     * PUBLIC: BINDEVENT em cmd_4c_Cotacao.Click
4886:     *==========================================================================
4887:     PROCEDURE CotacaoClick()
4888:         TRY
4889:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
4890:                 DO FORM SigOpCot WITH THISFORM, crSigCdFcx.Datas
4891:             ENDIF
4892:         CATCH TO loc_oErro
4893:             MsgErro("Erro em CotacaoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
4894:         ENDTRY
4895:     ENDPROC
4896: 
4897:     *==========================================================================
4898:     * GradeMatAfterRowColChange - Atualiza campos de resumo ao mudar linha do GradeMat
4899:     * Equivale ao GradeMat.AfterRowColChange do legado
4900:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
4901:     *==========================================================================
4902:     PROCEDURE GradeMatAfterRowColChange(par_nColIndex)
4903:         LOCAL loc_oCnt, loc_oPage1, loc_oPage2
4904:         TRY
4905:             IF USED("TmpResumo") AND !EOF("TmpResumo")
4906:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
4907:                 SELECT TmpResumo
4908: 
4909:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
4910:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
4911:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
4912:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
4913:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
4914:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
4915:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
4916:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
4917:                 loc_oCnt.Get_Pfalha.Value    = TmpResumo.PfTrabs
4918: 
4919:                 *-- Atualizar GradeEntradas com filtro do material corrente
4920:                 IF USED("TmpOpera")
4921:                     SELECT TmpOpera
4922:                     SET ORDER TO GrConMatTp
4923:                     SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
4924:                     GO TOP
4925:                 ENDIF
4926: 
4927:                 IF PEMSTATUS(loc_oCnt, "Pagina", 5)
4928:                     loc_oPage1 = loc_oCnt.Pagina.Pages(1)
4929:                     IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
4930:                         loc_oPage1.GradeEntradas.Refresh()
4931:                         loc_oPage1.GradeEntradas.AfterRowColChange(1)
4932:                     ENDIF
4933:                     loc_oPage2 = loc_oCnt.Pagina.Pages(2)
4934:                     IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
4935:                         loc_oPage2.GradeSaidas.Refresh()
4936:                     ENDIF
4937: 
4938:                     *-- Atualizar GradeResumo com filtro do material corrente
4939:                     IF USED("TmpResFas")
4940:                         SELECT TmpResFas
4941:                         SET KEY TO TmpResumo.CMats
4942:                         GO TOP

*-- Linhas 4962 a 5264:
4962: 
4963:     *==========================================================================
4964:     * GradeEntradasAfterRowColChange - Atualiza Get_TpOperacao na Page1
4965:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
4966:     *==========================================================================
4967:     PROCEDURE GradeEntradasAfterRowColChange(par_nColIndex)
4968:         LOCAL loc_oPage1
4969:         TRY
4970:             IF USED("TmpOpera") AND !EOF("TmpOpera")
4971:                 loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
4972:                 IF PEMSTATUS(loc_oPage1, "Get_TpOperacao", 5)
4973:                     loc_oPage1.Get_TpOperacao.Value = ALLTRIM(NVL(TmpOpera.TpOps, ""))
4974:                     loc_oPage1.Get_TpOperacao.Refresh()
4975:                 ENDIF
4976:             ENDIF
4977:         CATCH TO loc_oErro
4978:             MsgErro("Erro em GradeEntradasAfterRowColChange:" + CHR(13) + loc_oErro.Message, "FormFea")
4979:         ENDTRY
4980:     ENDPROC
4981: 
4982:     *==========================================================================
4983:     * GradeSaidasAfterRowColChange - Atualiza Get_TpOperacao na Page2
4984:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
4985:     *==========================================================================
4986:     PROCEDURE GradeSaidasAfterRowColChange(par_nColIndex)
4987:         LOCAL loc_oPage2
4988:         TRY
4989:             IF USED("TmpOpera") AND !EOF("TmpOpera")
4990:                 loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
4991:                 IF PEMSTATUS(loc_oPage2, "Get_TpOperacao", 5)
4992:                     loc_oPage2.Get_TpOperacao.Value = ALLTRIM(NVL(TmpOpera.TpOps, ""))
4993:                     loc_oPage2.Get_TpOperacao.Refresh()
4994:                 ENDIF
4995:             ENDIF
4996:         CATCH TO loc_oErro
4997:             MsgErro("Erro em GradeSaidasAfterRowColChange:" + CHR(13) + loc_oErro.Message, "FormFea")
4998:         ENDTRY
4999:     ENDPROC
5000: 
5001:     *==========================================================================
5002:     * GradeMatCheck1Change - Valida Check1 (Flag3) ao mudar no GradeMat
5003:     * Impedimentos: conta sem acerto (Flag2=.F.) ou saldo zero
5004:     * PUBLIC: BINDEVENT exige metodo publico
5005:     *==========================================================================
5006:     PROCEDURE GradeMatCheck1Change()
5007:         LOCAL loc_oCnt
5008:         TRY
5009:             IF USED("TmpResumo") AND !EOF("TmpResumo")
5010:                 loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5011:                 IF !TmpResumo.Flag2
5012:                     MsgAviso("Esta Conta N" + CHR(227) + "o Permite Acerto de Balan" + CHR(231) + "o...")
5013:                     SELECT TmpResumo
5014:                     REPLACE Flag3 WITH .F.
5015:                     IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5016:                         loc_oCnt.GradeMat.Refresh()
5017:                     ENDIF
5018:                 ELSE
5019:                     IF TmpResumo.Saldof = 0 AND TmpResumo.Flag3
5020:                         MsgAviso("N" + CHR(227) + "o H" + CHR(225) + " Diferen" + CHR(231) + CHR(97) + "  Para Acerto...")
5021:                         SELECT TmpResumo
5022:                         REPLACE Flag3 WITH .F.
5023:                         IF PEMSTATUS(loc_oCnt, "GradeMat", 5)
5024:                             loc_oCnt.GradeMat.Refresh()
5025:                         ENDIF
5026:                     ENDIF
5027:                 ENDIF
5028:             ENDIF
5029:         CATCH TO loc_oErro
5030:             MsgErro("Erro em GradeMatCheck1Change:" + CHR(13) + loc_oErro.Message, "FormFea")
5031:         ENDTRY
5032:     ENDPROC
5033: 
5034:     *==========================================================================
5035:     * chkPerdasClick - Desabilita outros checkboxes quando Perdas marcado
5036:     * PUBLIC: BINDEVENT exige metodo publico
5037:     *==========================================================================
5038:     PROCEDURE chkPerdasClick()
5039:         LOCAL loc_oCnt
5040:         TRY
5041:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5042:             IF loc_oCnt.chkPerdas.Value = 1
5043:                 loc_oCnt.Resumido.Value  = 0
5044:                 loc_oCnt.Historico.Value = 0
5045:                 loc_oCnt.chkServ.Value   = 0
5046:                 loc_oCnt.Analitico.Value = 0
5047:                 loc_oCnt.porMov.Value    = 0
5048:                 loc_oCnt.MovAgru.Value   = 0
5049:                 loc_oCnt.porenv.Value    = 0
5050:                 loc_oCnt.pormat.Value    = 0
5051:                 loc_oCnt.MovLote.Value   = 0
5052:             ENDIF
5053:         CATCH TO loc_oErro
5054:             MsgErro("Erro em chkPerdasClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5055:         ENDTRY
5056:     ENDPROC
5057: 
5058:     *==========================================================================
5059:     * BtnPesagemClick - Ativa modo de entrada de pesagem fisica
5060:     * PUBLIC: BINDEVENT exige metodo publico
5061:     *==========================================================================
5062:     PROCEDURE BtnPesagemClick()
5063:         LOCAL loc_oCnt
5064:         TRY
5065:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5066:             THIS.this_lEntraPeso = .T.
5067:             loc_oCnt.Get_Pesagem.ReadOnly = .F.
5068:             loc_oCnt.Get_Pesagem.SetFocus()
5069:         CATCH TO loc_oErro
5070:             MsgErro("Erro em BtnPesagemClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5071:         ENDTRY
5072:     ENDPROC
5073: 
5074:     *==========================================================================
5075:     * PesagemLostFocus - Recalcula saldos ao informar pesagem fisica
5076:     * Disparado por Valid do Get_Pesagem (equivalente ao legado)
5077:     * PUBLIC: BINDEVENT exige metodo publico
5078:     *==========================================================================
5079:     PROCEDURE PesagemLostFocus()
5080:         LOCAL loc_oCnt, loc_nPesagem
5081:         TRY
5082:             THIS.this_lEntraPeso = .F.
5083:             IF USED("TmpResumo") AND !EOF("TmpResumo")
5084:                 loc_oCnt    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5085:                 loc_nPesagem = NVL(loc_oCnt.Get_Pesagem.Value, 0)
5086:                 SELECT TmpResumo
5087:                 REPLACE Pesagem WITH loc_nPesagem, ;
5088:                         Saldof  WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem - TmpResumo.FAdmin, ;
5089:                         FReal   WITH TmpResumo.Saldoi + TmpResumo.QtdeEnts - TmpResumo.QtdeSais - loc_nPesagem
5090:                 loc_oCnt.Get_Saldo.Value     = TmpResumo.Saldoi
5091:                 loc_oCnt.Get_TEntradas.Value = TmpResumo.QtdeEnts
5092:                 loc_oCnt.Get_SEntradas.Value = TmpResumo.Saldoi + TmpResumo.QtdeEnts
5093:                 loc_oCnt.Get_SSaidas.Value   = TmpResumo.QtdeSais
5094:                 loc_oCnt.Get_Pesagem.Value   = TmpResumo.Pesagem
5095:                 loc_oCnt.Get_FReal.Value     = TmpResumo.FReal
5096:                 loc_oCnt.Get_FAdmitida.Value = TmpResumo.FAdmin
5097:                 loc_oCnt.Get_Saldof.Value    = TmpResumo.Saldof
5098:                 loc_oCnt.Get_Pesagem.ReadOnly = .T.
5099:             ENDIF
5100:         CATCH TO loc_oErro
5101:             MsgErro("Erro em PesagemLostFocus:" + CHR(13) + loc_oErro.Message, "FormFea")
5102:         ENDTRY
5103:     ENDPROC
5104: 
5105:     *==========================================================================
5106:     * BtnSelTudoClick - Marca todos os materiais (Flag3=.T.) no GradeMat
5107:     * PUBLIC: BINDEVENT exige metodo publico
5108:     *==========================================================================
5109:     PROCEDURE BtnSelTudoClick()
5110:         TRY
5111:             IF USED("TmpResumo")
5112:                 SELECT TmpResumo
5113:                 REPLACE ALL Flag3 WITH .T.
5114:                 GO TOP
5115:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5116:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5117:                 ENDIF
5118:             ENDIF
5119:         CATCH TO loc_oErro
5120:             MsgErro("Erro em BtnSelTudoClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5121:         ENDTRY
5122:     ENDPROC
5123: 
5124:     *==========================================================================
5125:     * BtnApagaClick - Desmarca todos os materiais (Flag3=.F.) no GradeMat
5126:     * PUBLIC: BINDEVENT exige metodo publico
5127:     *==========================================================================
5128:     PROCEDURE BtnApagaClick()
5129:         TRY
5130:             IF USED("TmpResumo")
5131:                 SELECT TmpResumo
5132:                 REPLACE ALL Flag3 WITH .F.
5133:                 GO TOP
5134:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "GradeMat", 5)
5135:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.GradeMat.Refresh()
5136:                 ENDIF
5137:             ENDIF
5138:         CATCH TO loc_oErro
5139:             MsgErro("Erro em BtnApagaClick:" + CHR(13) + loc_oErro.Message, "FormFea")
5140:         ENDTRY
5141:     ENDPROC
5142: 
5143:     *==========================================================================
5144:     * GrdMovCheck1KeyPress - Alterna nMarcas com Enter/Espaco no grdMov
5145:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
5146:     *==========================================================================
5147:     PROCEDURE GrdMovCheck1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
5148:         TRY
5149:             IF INLIST(m.par_nKeyCode, 13, 32)
5150:                 IF USED("crOpp") AND !EOF("crOpp")
5151:                     SELECT crOpp
5152:                     REPLACE nMarcas WITH IIF(crOpp.nMarcas = 0, 1, 0)
5153:                     KEYBOARD "{DNARROW}"
5154:                     KEYBOARD "{UPARROW}"
5155:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado, "grdMov", 5)
5156:                         THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.grdMov.Refresh()
5157:                     ENDIF
5158:                 ENDIF
5159:                 NODEFAULT
5160:             ENDIF
5161:         CATCH TO loc_oErro
5162:             MsgErro("Erro em GrdMovCheck1KeyPress:" + CHR(13) + loc_oErro.Message, "FormFea")
5163:         ENDTRY
5164:     ENDPROC
5165: 
5166:     *==========================================================================
5167:     * PaginaResultadoPage1Activate - Ativa aba Entradas (seta ordem TmpOpera)
5168:     * PUBLIC: BINDEVENT em Pagina.Pages(1).Activate
5169:     *==========================================================================
5170:     PROCEDURE PaginaResultadoPage1Activate()
5171:         LOCAL loc_oPage1
5172:         TRY
5173:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5174:                 SELECT TmpOpera
5175:                 SET ORDER TO GrConMatTp
5176:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5177:                 GO TOP
5178:                 loc_oPage1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(1)
5179:                 IF PEMSTATUS(loc_oPage1, "GradeEntradas", 5)
5180:                     loc_oPage1.GradeEntradas.Refresh()
5181:                     loc_oPage1.GradeEntradas.AfterRowColChange(1)
5182:                 ENDIF
5183:             ENDIF
5184:         CATCH TO loc_oErro
5185:             MsgErro("Erro em PaginaResultadoPage1Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5186:         ENDTRY
5187:     ENDPROC
5188: 
5189:     *==========================================================================
5190:     * PaginaResultadoPage2Activate - Ativa aba Saidas (seta ordem TmpOpera)
5191:     * PUBLIC: BINDEVENT em Pagina.Pages(2).Activate
5192:     *==========================================================================
5193:     PROCEDURE PaginaResultadoPage2Activate()
5194:         LOCAL loc_oPage2
5195:         TRY
5196:             IF USED("TmpOpera") AND USED("TmpResumo") AND !EOF("TmpResumo")
5197:                 SELECT TmpOpera
5198:                 SET ORDER TO GrConMatTp
5199:                 SET KEY TO TmpResumo.Grupo + TmpResumo.Conta + TmpResumo.CMats
5200:                 GO TOP
5201:                 loc_oPage2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Pagina.Pages(2)
5202:                 IF PEMSTATUS(loc_oPage2, "GradeSaidas", 5)
5203:                     loc_oPage2.GradeSaidas.Refresh()
5204:                     loc_oPage2.GradeSaidas.AfterRowColChange(1)
5205:                 ENDIF
5206:             ENDIF
5207:         CATCH TO loc_oErro
5208:             MsgErro("Erro em PaginaResultadoPage2Activate:" + CHR(13) + loc_oErro.Message, "FormFea")
5209:         ENDTRY
5210:     ENDPROC
5211: 
5212:     *==========================================================================
5213:     * BtnVisualizarBalancoClick - Preview do relatorio de balanco
5214:     * PUBLIC: BINDEVENT exige metodo publico
5215:     *==========================================================================
5216:     PROCEDURE BtnVisualizarBalancoClick()
5217:         THIS.ImprimirBalanco("PREVIEW")
5218:     ENDPROC
5219: 
5220:     *==========================================================================
5221:     * BtnImprimirBalancoClick - Impressao do relatorio de balanco
5222:     * PUBLIC: BINDEVENT exige metodo publico
5223:     *==========================================================================
5224:     PROCEDURE BtnImprimirBalancoClick()
5225:         THIS.ImprimirBalanco("PRINTER_PROMPT")
5226:     ENDPROC
5227: 
5228:     *==========================================================================
5229:     * ImprimirBalanco - Executa o relatorio de Balanco de Estoque (SIGCDFEA.frx)
5230:     * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
5231:     * Cria TmpCabec, chama REPORT FORM com isolamento de locale (Pattern #117)
5232:     *==========================================================================
5233:     PROTECTED FUNCTION ImprimirBalanco(par_cModo)
5234:         LOCAL loc_lResultado, loc_cFRX, loc_cSubTitulo, loc_cEmpresa
5235:         LOCAL loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig, loc_oCnt
5236:         loc_lResultado = .F.
5237: 
5238:         TRY
5239:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado
5240: 
5241:             *-- Montar cursor TmpCabec para o FRX
5242:             IF USED("TmpCabec")
5243:                 USE IN TmpCabec
5244:             ENDIF
5245:             CREATE CURSOR TmpCabec (Titulo C(100), SubTitulo C(254), Empresa C(80))
5246: 
5247:             loc_cSubTitulo = ""
5248:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
5249:                 IF USED("TmpCli")
5250:                     =SEEK(ALLTRIM(crSigCdFcx.Contas), "TmpCli", "BalCodigo")
5251:                 ENDIF
5252:                 loc_cSubTitulo = " Conta : " + ALLTRIM(NVL(crSigCdFcx.Grupos, "")) + ;
5253:                                  " / " + ALLTRIM(NVL(crSigCdFcx.Contas, ""))
5254:                 IF USED("TmpCli") AND !EOF("TmpCli")
5255:                     loc_cSubTitulo = loc_cSubTitulo + " [ " + ALLTRIM(TmpCli.RClis) + " ] "
5256:                 ENDIF
5257:                 loc_cSubTitulo = loc_cSubTitulo + CHR(13) + CHR(10) + ;
5258:                                  "Per" + CHR(237) + "odo : " + ;
5259:                                  NVL(DTOC(crSigCdFcx.Datais), "") + " a " + ;
5260:                                  NVL(DTOC(crSigCdFcx.Datas), "")
5261:             ENDIF
5262: 
5263:             loc_cEmpresa = ALLTRIM(NVL(go_4c_Sistema.cEmpresa, ""))
5264:             INSERT INTO TmpCabec (Titulo, SubTitulo, Empresa) ;

*-- Linhas 5272 a 5315:
5272:                     "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
5273:             ELSE
5274:                 IF !USED("TmpResumo") OR RECCOUNT("TmpResumo") = 0
5275:                     MsgAviso("Nenhum registro encontrado para impress" + CHR(227) + "o.")
5276:                 ELSE
5277:                     *-- Isolar locale para FRX legado (Pattern #117)
5278:                     loc_cPointOrig    = SET("POINT")
5279:                     loc_cSepOrig      = SET("SEPARATOR")
5280:                     loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
5281:                     SET POINT TO "."
5282:                     SET SEPARATOR TO ","
5283:                     SET REPORTBEHAVIOR 80
5284: 
5285:                     DO CASE
5286:                         CASE par_cModo == "PREVIEW"
5287:                             REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
5288:                         CASE par_cModo == "PRINTER_PROMPT"
5289:                             REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
5290:                         CASE par_cModo == "PRINTER"
5291:                             REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
5292:                     ENDCASE
5293: 
5294:                     SET POINT TO (loc_cPointOrig)
5295:                     SET SEPARATOR TO (loc_cSepOrig)
5296:                     SET REPORTBEHAVIOR (loc_nBehaviorOrig)
5297: 
5298:                     *-- Restaurar menu apos REPORT FORM PREVIEW (Erro63)
5299:                     TRY
5300:                         SET SYSMENU TO DEFAULT
5301:                         RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
5302:                         CriarMenuPrincipal()
5303:                     CATCH
5304:                     ENDTRY
5305: 
5306:                     loc_lResultado = .T.
5307:                 ENDIF
5308:             ENDIF
5309:         CATCH TO loc_oErro
5310:             MsgErro("Erro em ImprimirBalanco:" + CHR(13) + loc_oErro.Message + ;
5311:                     CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormFea")
5312:         ENDTRY
5313: 
5314:         IF USED("TmpCabec")
5315:             USE IN TmpCabec

*-- Linhas 5321 a 5364:
5321:     *==========================================================================
5322:     * Destroy - Liberacao de recursos ao fechar o formulario
5323:     *==========================================================================
5324:     PROCEDURE Destroy()
5325:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
5326:             THIS.this_oBusinessObject = .NULL.
5327:         ENDIF
5328: 
5329:         *-- Fechar cursores temporarios locais (criados pelo processamento)
5330:         LOCAL loc_aCursores(30), loc_i
5331:         loc_aCursores(1)  = "TmpResumo"
5332:         loc_aCursores(2)  = "TmpOpera"
5333:         loc_aCursores(3)  = "TmpConta"
5334:         loc_aCursores(4)  = "TmpGccr"
5335:         loc_aCursores(5)  = "TmpCli"
5336:         loc_aCursores(6)  = "TmpPro"
5337:         loc_aCursores(7)  = "TmpCot"
5338:         loc_aCursores(8)  = "TmpHist"
5339:         loc_aCursores(9)  = "TmpPrz"
5340:         loc_aCursores(10) = "TmpResFas"
5341:         loc_aCursores(11) = "CrSigCdFea"
5342:         loc_aCursores(12) = "cursor_4c_Dados"
5343:         loc_aCursores(13) = "cursor_4c_BuscaGrupo"
5344:         loc_aCursores(14) = "cursor_4c_BuscaConta"
5345:         loc_aCursores(15) = "crSigMvCab"
5346:         loc_aCursores(16) = "crSigMvItn"
5347:         loc_aCursores(17) = "crSigCdFcx"
5348:         loc_aCursores(18) = "crSigCdPac"
5349:         loc_aCursores(19) = "crSigCdPam"
5350:         loc_aCursores(20) = "crSigOpOpt"
5351:         loc_aCursores(21) = "LocalOpp"
5352:         loc_aCursores(22) = "crSigCdOpe"
5353:         loc_aCursores(23) = "TmpGccr"
5354:         loc_aCursores(24) = "LocalGru"
5355:         loc_aCursores(25) = "LocalGgrp"
5356:         loc_aCursores(26) = "CrOpp"
5357:         loc_aCursores(27) = "LocalEmp"
5358:         loc_aCursores(28) = "crDtUBal"
5359:         loc_aCursores(29) = "CrUltBal"
5360:         loc_aCursores(30) = "CrSaldoI"
5361: 
5362:         FOR loc_i = 1 TO ALEN(loc_aCursores)
5363:             IF USED(loc_aCursores(loc_i))
5364:                 USE IN (loc_aCursores(loc_i))


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

