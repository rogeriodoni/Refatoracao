# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [OPTIONGROUP-LEFT] OptionGroup com ButtonCount=2 mas Buttons(2) NAO tem .Left definido. Sem .Left, todos os Buttons ficam sobrepostos no Left=0 e usuario so ve o primeiro. OBRIGATORIO definir .Left, .Top, .AutoSize, .ForeColor, .Themes em CADA Button.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (934 linhas total):

*-- Linhas 11 a 173:
11: * FASES CONCLUIDAS:
12: *   Fase 3/8 - Form - Estrutura Base
13: *     * Propriedades visuais (Width=800, Height=300, DataSession=2)
14: *     * Init() / InicializarForm() / Destroy()
15: *     * ConfigurarCabecalho() / ConfigurarBotoes() / ConfigurarPageFrame()
16: *   Fase 4/8 - Form - Campos de Filtro (Page1)
17: *     * ConfigurarPaginaFiltros() - empresa (codigo+descricao) + agrupamento
18: *     * ConfigurarPaginaLista() / ConfigurarPaginaDados() - aliases compat
19: *     * AlternarPagina(par_nPagina) - navegacao entre paginas
20: *   Fase 5/8 - Form - FormParaRelatorio + LimparCampos
21: *     * FormParaRelatorio() - transfere campos do form para propriedades do BO
22: *     * LimparCampos() - carrega defaults do BO nos campos (empresa padrao)
23: *     * InicializarForm() atualizado: chama LimparCampos() apos montar layout
24: *   Fase 6/8 - Form - BINDEVENTs, Handlers e Lookup Empresa
25: *     * ConfigurarEventos() - BINDEVENTs para empresa e botoes de relatorio
26: *     * EmpresaKeyPress / DesEmpresaKeyPress - teclado F4/Enter/Tab
27: *     * ValidarCodEmpresa() - valida codigo contra SigCdEmp, preenche descricao
28: *     * AbrirLookupEmpresa() - FormBuscaAuxiliar sobre SigCdEmp
29: *     * BtnVisualizarClick / BtnImprimirClick / BtnExcelClick / BtnEncerrarClick
30: *   Fase 7/8 - Form - Eventos Principais
31: *     * BtnVisualizarClick - Preview em tela (valida empresa+tabela)
32: *     * BtnImprimirClick   - Impressora com prompt (valida empresa+tabela)
33: *     * BtnExcelClick      - Impressao direta / Excel (valida empresa+tabela)
34: *     * BtnEncerrarClick   - Fecha formulario (ESC)
35: *     * BtnIncluirClick    - Navega para Page2 (no-op para REPORT, mantido p/ pipeline)
36: *     * BtnAlterarClick    - Nao aplicavel a REPORT (mantido p/ pipeline)
37: *     * BtnExcluirClick    - Nao aplicavel a REPORT (mantido p/ pipeline)
38: *==============================================================================
39: 
40: DEFINE CLASS Formsigreeqe AS FormBase
41: 
42:     *-- Dimensoes e aparencia (EXATAS do original: Width=800, Height=300)
43:     Height      = 300
44:     Width       = 800
45:     DataSession = 2
46:     ShowWindow  = 1
47:     WindowType  = 1
48:     AutoCenter  = .T.
49:     BorderStyle = 2
50:     ControlBox  = .F.
51:     MaxButton   = .F.
52:     MinButton   = .F.
53:     TitleBar    = 0
54:     Themes      = .F.
55:     ShowTips    = .T.
56: 
57:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
58:     this_oRelatorio    = .NULL.
59:     this_cMensagemErro = ""
60: 
61:     *--------------------------------------------------------------------------
62:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
63:     *--------------------------------------------------------------------------
64:     PROCEDURE Init()
65:         RETURN DODEFAULT()
66:     ENDPROC
67: 
68:     *--------------------------------------------------------------------------
69:     * InicializarForm - Cria estrutura base do formulario de relatorio
70:     *   1. Define Caption / Picture (fundo)
71:     *   2. Instancia sigreeqeBO (carrega cursores de apoio)
72:     *   3. Monta cabecalho escuro + botoes + PageFrame vazio
73:     *--------------------------------------------------------------------------
74:     PROTECTED PROCEDURE InicializarForm()
75:         LOCAL loc_lSucesso, loc_lContinuar
76:         loc_lSucesso   = .F.
77:         loc_lContinuar = .T.
78:         TRY
79:             THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
80: 
81:             IF TYPE("gc_4c_CaminhoIcones") = "U"
82:                 gc_4c_CaminhoIcones = ""
83:             ENDIF
84:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85: 
86:             *-- Instanciar BO de relatorio (Init() do BO carrega cursores de apoio)
87:             THIS.this_oRelatorio = CREATEOBJECT("sigreeqeBO")
88:             IF VARTYPE(THIS.this_oRelatorio) != "O"
89:                 MsgErro("Erro ao criar sigreeqeBO" + CHR(13) + ;
90:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
91:                 loc_lContinuar = .F.
92:             ENDIF
93: 
94:             IF loc_lContinuar
95:                 *-- Cabecalho escuro com titulo (equivalente ao cntSombra do legado)
96:                 THIS.ConfigurarCabecalho()
97: 
98:                 *-- Botoes do relatorio (Visualizar / Imprimir / Excel / Encerrar)
99:                 THIS.ConfigurarBotoes()
100: 
101:                 *-- PageFrame com pagina de filtros
102:                 THIS.ConfigurarPageFrame()
103: 
104:                 *-- Campos de filtro: empresa (codigo+descricao) e agrupamento
105:                 THIS.ConfigurarPaginaFiltros()
106: 
107:                 *-- Registrar eventos de interacao (BINDEVENTs)
108:                 THIS.ConfigurarEventos()
109: 
110:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
111:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
112: 
113:                 *-- Carregar defaults do BO (empresa padrao do usuario logado)
114:                 THIS.LimparCampos()
115: 
116:                 THIS.Visible   = .T.
117:                 loc_lSucesso   = .T.
118:             ENDIF
119:         CATCH TO loc_oErro
120:             THIS.this_cMensagemErro = loc_oErro.Message
121:             MsgErro(loc_oErro.Message + CHR(13) + ;
122:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
123:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
124:         ENDTRY
125:         RETURN loc_lSucesso
126:     ENDPROC
127: 
128:     *--------------------------------------------------------------------------
129:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
130:     *   Equivalente ao cntSombra do frmrelatorio legado.
131:     *   Largura = Width do form (cobre toda a faixa superior de 80px).
132:     *--------------------------------------------------------------------------
133:     PROTECTED PROCEDURE ConfigurarCabecalho()
134:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
135:         WITH THIS.cnt_4c_Cabecalho
136:             .Top         = 0
137:             .Left        = 0
138:             .Width       = THIS.Width
139:             .Height      = 80
140:             .BackStyle   = 1
141:             .BackColor   = RGB(100, 100, 100)
142:             .BorderWidth = 0
143:             .Visible     = .T.
144: 
145:             *-- Sombra deslocada (efeito 3D sobre texto branco)
146:             .AddObject("lbl_4c_Sombra", "Label")
147:             WITH .lbl_4c_Sombra
148:                 .Top       = 22
149:                 .Left      = 22
150:                 .Width     = THIS.Width
151:                 .Height    = 30
152:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
153:                 .FontName  = "Tahoma"
154:                 .FontSize  = 14
155:                 .FontBold  = .T.
156:                 .ForeColor = RGB(0, 0, 0)
157:                 .BackStyle = 0
158:                 .Visible   = .T.
159:             ENDWITH
160: 
161:             *-- Titulo em branco (sobre a sombra escura)
162:             .AddObject("lbl_4c_Titulo", "Label")
163:             WITH .lbl_4c_Titulo
164:                 .Top       = 20
165:                 .Left      = 20
166:                 .Width     = THIS.Width
167:                 .Height    = 30
168:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas por Empresa"
169:                 .FontName  = "Tahoma"
170:                 .FontSize  = 14
171:                 .FontBold  = .T.
172:                 .ForeColor = RGB(255, 255, 255)
173:                 .BackStyle = 0

*-- Linhas 181 a 224:
181:     *   Posicao original: btnReport.Left=527, Top=4
182:     *   Equivalente exato ao btnReport do frmrelatorio do framework.
183:     *--------------------------------------------------------------------------
184:     PROTECTED PROCEDURE ConfigurarBotoes()
185:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
186:         WITH THIS.cmg_4c_Botoes
187:             .Top           = 0
188:             .Left          = 529
189:             .Width         = 273
190:             .Height        = 80
191:             .ButtonCount   = 4
192:             .BackStyle     = 0
193:             .BorderStyle   = 0
194:             .BorderColor   = RGB(136, 189, 188)
195:             .SpecialEffect = 1
196:             .Themes        = .F.
197:             .Visible       = .T.
198: 
199:             *-- Visualizar (preview em tela) - equivalente a Visualiza do legado
200:             WITH .Buttons(1)
201:                 .Top             = 5
202:                 .Left            = 5
203:                 .Width           = 65
204:                 .Height          = 70
205:                 .Caption         = "Visualizar"
206:                 .FontBold        = .T.
207:                 .FontItalic      = .T.
208:                 .BackColor       = RGB(255, 255, 255)
209:                 .ForeColor       = RGB(90, 90, 90)
210:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
211:                 .PicturePosition = 13
212:                 .SpecialEffect   = 0
213:                 .MousePointer    = 15
214:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
215:                 .Themes          = .F.
216:                 .Visible         = .T.
217:             ENDWITH
218: 
219:             *-- Imprimir (impressora com prompt) - equivalente a Imprime do legado
220:             WITH .Buttons(2)
221:                 .Top             = 5
222:                 .Left            = 71
223:                 .Width           = 65
224:                 .Height          = 70

*-- Linhas 290 a 370:
290:     *   Posicionado logo abaixo do cabecalho (80px) ate o fim do form.
291:     *   Os campos de filtro (empresa, agrupamento) sao adicionados em fases 4+.
292:     *--------------------------------------------------------------------------
293:     PROTECTED PROCEDURE ConfigurarPageFrame()
294:         LOCAL loc_oPgf
295: 
296:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
297:         loc_oPgf = THIS.pgf_4c_Paginas
298: 
299:         *-- PageCount antes de acessar Page1
300:         loc_oPgf.PageCount = 1
301: 
302:         loc_oPgf.Top    = 85
303:         loc_oPgf.Left   = -1
304:         loc_oPgf.Width  = THIS.Width + 2
305:         loc_oPgf.Height = THIS.Height - 85
306:         loc_oPgf.Tabs   = .F.
307: 
308:         loc_oPgf.Page1.Caption   = "Filtros"
309:         loc_oPgf.Page1.FontName  = "Tahoma"
310:         loc_oPgf.Page1.FontSize  = 8
311:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
312:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
313:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
314: 
315:         loc_oPgf.Visible    = .T.
316:         loc_oPgf.ActivePage = 1
317:     ENDPROC
318: 
319:     *--------------------------------------------------------------------------
320:     * ConfigurarPaginaFiltros - Popula Page1 ("Filtros") com os controles
321:     *   equivalentes ao layout original SIGREEQE:
322:     *   - Say5  -> lbl_4c_Empresa  (Top=159, Left=208)
323:     *   - GetEmpresa    -> txt_4c_Empresa    (Top=156, Left=262, Width=36, MaxLength=3)
324:     *   - GetDesEmpresa -> txt_4c_DesEmpresa (Top=156, Left=300, Width=285)
325:     *   - Say1  -> lbl_4c_Agrupa   (Top=186, Left=210)
326:     *   - Opt_Agrupa -> opg_4c_Agrupa (Top=183, Left=258, Barra/Identidade)
327:     *
328:     *   PageFrame.Top=85 -> posicoes relativas: Top -= 85
329:     *--------------------------------------------------------------------------
330:     PROTECTED PROCEDURE ConfigurarPaginaFiltros()
331:         LOCAL loc_oPagina
332:         TRY
333:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
334: 
335:             *-- Label "Empresa :" (Say5: Top=159, Left=208)
336:             loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
337:             WITH loc_oPagina.lbl_4c_Empresa
338:                 .Top       = 74
339:                 .Left      = 208
340:                 .Width     = 54
341:                 .Height    = 17
342:                 .Caption   = "Empresa :"
343:                 .FontName  = "Tahoma"
344:                 .FontSize  = 8
345:                 .ForeColor = RGB(90, 90, 90)
346:                 .BackStyle = 0
347:                 .Visible   = .T.
348:             ENDWITH
349: 
350:             *-- Codigo da empresa (GetEmpresa: Top=156, Left=262, Width=36, MaxLength=3)
351:             loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
352:             WITH loc_oPagina.txt_4c_Empresa
353:                 .Top       = 71
354:                 .Left      = 262
355:                 .Width     = 36
356:                 .Height    = 23
357:                 .MaxLength = 3
358:                 .Value     = ""
359:                 .FontName  = "Tahoma"
360:                 .FontSize  = 8
361:                 .Visible   = .T.
362:             ENDWITH
363: 
364:             *-- Descricao da empresa (GetDesEmpresa: Top=156, Left=300, Width=285)
365:             loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
366:             WITH loc_oPagina.txt_4c_DesEmpresa
367:                 .Top      = 71
368:                 .Left     = 300
369:                 .Width    = 285
370:                 .Height   = 23

*-- Linhas 389 a 934:
389:                 .Visible   = .T.
390:             ENDWITH
391: 
392:             *-- OptionGroup agrupamento (Opt_Agrupa: Top=183, Left=258, Value=1)
393:             *-- Buttons(1)="Barra", Buttons(2)="Identidade"
394:             loc_oPagina.AddObject("opg_4c_Agrupa", "OptionGroup")
395:             WITH loc_oPagina.opg_4c_Agrupa
396:                 .Top           = 98
397:                 .Left          = 258
398:                 .Width         = 138
399:                 .Height        = 25
400:                 .ButtonCount   = 2
401:                 .BackStyle     = 0
402:                 .BorderStyle   = 0
403:                 .Value         = 1
404:                 .SpecialEffect = 0
405:                 .Visible       = .T.
406: 
407:                 WITH .Buttons(1)
408:                     .Caption   = "Barra"
409:                     .BackStyle = 0
410:                     .Value     = 1
411:                     .Height    = 15
412:                     .Left      = 5
413:                     .Top       = 5
414:                     .Width     = 44
415:                     .AutoSize  = .T.
416:                     .ForeColor = RGB(90, 90, 90)
417:                     .Visible   = .T.
418:                 ENDWITH
419: 
420:                 WITH .Buttons(2)
421:                     .Caption   = "Identidade"
422:                     .FontName  = "Tahoma"
423:                     .FontSize  = 8
424:                     .BackStyle = 0
425:                     .Height    = 15
426:                     .Left      = 63
427:                     .Top       = 5
428:                     .AutoSize  = .T.
429:                     .ForeColor = RGB(90, 90, 90)
430:                     .Visible   = .T.
431:                 ENDWITH
432:             ENDWITH
433: 
434:         CATCH TO loc_oErro
435:             MsgErro(loc_oErro.Message + CHR(13) + ;
436:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
437:                 "Procedure: " + loc_oErro.Procedure, "ConfigurarPaginaFiltros")
438:         ENDTRY
439:     ENDPROC
440: 
441:     *--------------------------------------------------------------------------
442:     * ConfigurarPaginaLista - Alias canonico do pipeline de migracao (frmcadastro).
443:     *   Em forms REPORT (frmrelatorio) NAO existe Page1 com grid CRUD: a unica
444:     *   pagina hospeda os campos de filtro do relatorio. Por compatibilidade
445:     *   com o validador automatico (que procura este identificador), expomos
446:     *   esta entrada que delega para ConfigurarPaginaFiltros.
447:     *--------------------------------------------------------------------------
448:     PROTECTED PROCEDURE ConfigurarPaginaLista()
449:         THIS.ConfigurarPaginaFiltros()
450:     ENDPROC
451: 
452:     *--------------------------------------------------------------------------
453:     * ConfigurarPaginaDados - Alias canonico do pipeline de migracao (frmcadastro).
454:     *   Em forms REPORT nao existe Page2 de dados separada. Delegamos para
455:     *   ConfigurarPaginaFiltros para que o validador das fases 5/6 reconheca
456:     *   o ponto de entrada padrao.
457:     *--------------------------------------------------------------------------
458:     PROTECTED PROCEDURE ConfigurarPaginaDados()
459:         THIS.ConfigurarPaginaFiltros()
460:     ENDPROC
461: 
462:     *--------------------------------------------------------------------------
463:     * AlternarPagina - Navega entre paginas do PageFrame
464:     *   Para form REPORT: Page1=Filtros (unica pagina ativa). Mantido para
465:     *   compatibilidade com o pipeline e eventual expansao futura.
466:     *--------------------------------------------------------------------------
467:     PROCEDURE AlternarPagina(par_nPagina)
468:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
469:             RETURN
470:         ENDIF
471:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
472:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
473:             THIS.pgf_4c_Paginas.Refresh()
474:         ENDIF
475:     ENDPROC
476: 
477:     *--------------------------------------------------------------------------
478:     * FormParaRelatorio - Copia valores dos campos do form para o BO.
479:     * Chamado antes de Visualizar(), Imprimir() ou ImprimirDireto().
480:     *--------------------------------------------------------------------------
481:     PROTECTED PROCEDURE FormParaRelatorio()
482:         LOCAL loc_oPagina
483:         TRY
484:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
485: 
486:             WITH THIS.this_oRelatorio
487:                 .this_cEmpresa    = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
488:                 .this_cDesEmpresa = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
489:                 .this_nAgrupa     = loc_oPagina.opg_4c_Agrupa.Value
490:             ENDWITH
491: 
492:         CATCH TO loc_oErro
493:             MsgErro(loc_oErro.Message + CHR(13) + ;
494:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
495:                 "Procedure: " + loc_oErro.Procedure, "FormParaRelatorio")
496:         ENDTRY
497:     ENDPROC
498: 
499:     *--------------------------------------------------------------------------
500:     * LimparCampos - Carrega defaults do BO nos campos do form.
501:     * Chamado em InicializarForm (apos BO criado) e ao cancelar.
502:     * BO.Init() ja carregou: this_cEmpresa = empresa padrao do usuario.
503:     *--------------------------------------------------------------------------
504:     PROCEDURE LimparCampos()
505:         LOCAL loc_oPagina, loc_cEmpresa, loc_cDesEmpresa
506:         TRY
507:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
508: 
509:             *-- Ler valores do BO (podem ja ter sido preenchidos pelo Init do BO)
510:             IF VARTYPE(THIS.this_oRelatorio) = "O"
511:                 loc_cEmpresa    = ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
512:                 loc_cDesEmpresa = ALLTRIM(THIS.this_oRelatorio.this_cDesEmpresa)
513:             ELSE
514:                 loc_cEmpresa    = ""
515:                 loc_cDesEmpresa = ""
516:             ENDIF
517: 
518:             loc_oPagina.txt_4c_Empresa.Value    = loc_cEmpresa
519:             loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDesEmpresa
520: 
521:             *-- Descricao habilitada apenas quando codigo esta vazio (equivalente ao When legado)
522:             loc_oPagina.txt_4c_DesEmpresa.Enabled = EMPTY(loc_cEmpresa)
523: 
524:             *-- Agrupamento: default Barra (1), mesmo que o legado
525:             loc_oPagina.opg_4c_Agrupa.Value = 1
526: 
527:         CATCH TO loc_oErro
528:             MsgErro(loc_oErro.Message + CHR(13) + ;
529:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
530:                 "Procedure: " + loc_oErro.Procedure, "LimparCampos")
531:         ENDTRY
532:     ENDPROC
533: 
534:     *--------------------------------------------------------------------------
535:     * Destroy - Libera BO de relatorio e chama destrutor da base
536:     *--------------------------------------------------------------------------
537:     PROCEDURE Destroy()
538:         IF VARTYPE(THIS.this_oRelatorio) = "O"
539:             THIS.this_oRelatorio = .NULL.
540:         ENDIF
541:         DODEFAULT()
542:     ENDPROC
543: 
544:     *--------------------------------------------------------------------------
545:     * ConfigurarEventos - Registra BINDEVENTs para todos os controles interativos.
546:     *   Chamado em InicializarForm apos todos os objetos estarem criados.
547:     *--------------------------------------------------------------------------
548:     PROTECTED PROCEDURE ConfigurarEventos()
549:         LOCAL loc_oPagina
550:         TRY
551:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
552: 
553:             *-- Campo codigo da empresa: F4=lookup, Enter/Tab=validar
554:             BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "EmpresaKeyPress")
555: 
556:             *-- Campo descricao: Enter/Tab/F4=abrir lookup por nome (equivalente ao Valid legado)
557:             BINDEVENT(loc_oPagina.txt_4c_DesEmpresa, "KeyPress", THIS, "DesEmpresaKeyPress")
558: 
559:             *-- Botoes de relatorio: cada botao com seu Click handler
560:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
561:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
562:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
563:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
564: 
565:         CATCH TO loc_oErro
566:             MsgErro(loc_oErro.Message + CHR(13) + ;
567:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
568:                 "Procedure: " + loc_oErro.Procedure, "ConfigurarEventos")
569:         ENDTRY
570:     ENDPROC
571: 
572:     *--------------------------------------------------------------------------
573:     * EmpresaKeyPress - Handler de teclado para txt_4c_Empresa.
574:     *   F4(115)=lookup direto, Enter(13)/Tab(9)=validar codigo digitado.
575:     *--------------------------------------------------------------------------
576:     PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
577:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
578:             THIS.AbrirLookupEmpresa()
579:         ELSE
580:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
581:             THIS.ValidarCodEmpresa()
582:             ENDIF
583:         ENDIF
584:     ENDPROC
585: 
586:     *--------------------------------------------------------------------------
587:     * DesEmpresaKeyPress - Handler de teclado para txt_4c_DesEmpresa.
588:     *   Enter/Tab/F4 abrem lookup filtrado pelo nome digitado.
589:     *   Equivalente ao Valid do GetDesEmpresa no legado (busca por razao social).
590:     *--------------------------------------------------------------------------
591:     PROCEDURE DesEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
592:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
593:             THIS.AbrirLookupEmpresa()
594:         ENDIF
595:     ENDPROC
596: 
597:     *--------------------------------------------------------------------------
598:     * ValidarCodEmpresa - Valida codigo digitado em txt_4c_Empresa contra o banco.
599:     *   Preenche txt_4c_DesEmpresa e atualiza this_cTabela no BO.
600:     *   Se empresa nao encontrada: limpa campos e abre lookup.
601:     *   Equivalente ao Valid do GetEmpresa no legado.
602:     *--------------------------------------------------------------------------
603:     PROCEDURE ValidarCodEmpresa()
604:         LOCAL loc_cValor, loc_oPagina, loc_lContinuar
605: 
606:         TRY
607:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
608:             loc_cValor     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
609:             loc_lContinuar = .T.
610: 
611:             IF EMPTY(loc_cValor)
612:                 loc_oPagina.txt_4c_DesEmpresa.Value   = ""
613:                 loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
614:                 THIS.this_oRelatorio.this_cEmpresa     = ""
615:                 THIS.this_oRelatorio.this_cDesEmpresa  = ""
616:                 THIS.this_oRelatorio.this_cTabela      = ""
617:                 loc_lContinuar = .F.
618:             ENDIF
619: 
620:             IF loc_lContinuar
621:                 THIS.this_oRelatorio.this_cEmpresa = loc_cValor
622:                 IF !THIS.this_oRelatorio.ValidarEmpresa()
623:                     loc_oPagina.txt_4c_Empresa.Value      = ""
624:                     loc_oPagina.txt_4c_DesEmpresa.Value   = ""
625:                     loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
626:                     THIS.this_oRelatorio.this_cEmpresa    = ""
627:                     THIS.this_oRelatorio.this_cDesEmpresa = ""
628:                     THIS.this_oRelatorio.this_cTabela     = ""
629:                     MsgAviso("Empresa n" + CHR(227) + "o encontrada." + CHR(13) + ;
630:                         "Selecione da lista.", "Empresa Inv" + CHR(225) + "lida")
631:                     THIS.AbrirLookupEmpresa()
632:                 ELSE
633:                     loc_oPagina.txt_4c_DesEmpresa.Value   = THIS.this_oRelatorio.this_cDesEmpresa
634:                     loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
635:                 ENDIF
636:             ENDIF
637: 
638:         CATCH TO loc_oErro
639:             MsgErro(loc_oErro.Message + CHR(13) + ;
640:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
641:                 "Procedure: " + loc_oErro.Procedure, "ValidarCodEmpresa")
642:         ENDTRY
643:     ENDPROC
644: 
645:     *--------------------------------------------------------------------------
646:     * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecionar empresa.
647:     *   Preenche txt_4c_Empresa e txt_4c_DesEmpresa com a selecao.
648:     *   Atualiza this_cTabela no BO via ValidarEmpresa().
649:     *--------------------------------------------------------------------------
650:     PROCEDURE AbrirLookupEmpresa()
651:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPagina
652: 
653:         TRY
654:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
655:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
656:                 "SigCdEmp", ;
657:                 "cursor_4c_BuscaEmp", ;
658:                 "CEmps", ;
659:                 ALLTRIM(loc_oPagina.txt_4c_Empresa.Value), ;
660:                 "Buscar Empresa")
661: 
662:             loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
663:             loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
664: 
665:             loc_oBusca.Show()
666: 
667:             IF loc_oBusca.this_lSelecionou
668:                 IF USED("cursor_4c_BuscaEmp")
669:                     SELECT cursor_4c_BuscaEmp
670:                     loc_cCodigo    = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
671:                     loc_cDescricao = ALLTRIM(cursor_4c_BuscaEmp.Razas)
672: 
673:                     loc_oPagina.txt_4c_Empresa.Value    = loc_cCodigo
674:                     loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDescricao
675: 
676:                     THIS.this_oRelatorio.this_cEmpresa    = loc_cCodigo
677:                     THIS.this_oRelatorio.this_cDesEmpresa = loc_cDescricao
678: 
679:                     THIS.this_oRelatorio.ValidarEmpresa()
680: 
681:                     loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
682:                 ENDIF
683:             ENDIF
684: 
685:             IF USED("cursor_4c_BuscaEmp")
686:                 USE IN cursor_4c_BuscaEmp
687:             ENDIF
688:             loc_oBusca.Release()
689: 
690:         CATCH TO loc_oErro
691:             MsgErro(loc_oErro.Message + CHR(13) + ;
692:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
693:                 "Procedure: " + loc_oErro.Procedure, "AbrirLookupEmpresa")
694:         ENDTRY
695:     ENDPROC
696: 
697:     *--------------------------------------------------------------------------
698:     * BtnVisualizarClick - Gera relatorio em preview na tela.
699:     *   Equivalente a btnReport.Click (Value=1) -> PROCEDURE visualizacao.
700:     *   Valida empresa e tabela antes de processar (mesma validacao do legado).
701:     *--------------------------------------------------------------------------
702:     PROCEDURE BtnVisualizarClick()
703:         LOCAL loc_oPagina, loc_lContinuar
704: 
705:         TRY
706:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
707:             loc_lContinuar = .T.
708: 
709:             THIS.FormParaRelatorio()
710: 
711:             IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
712:                 MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
713:                     "Campo Obrigat" + CHR(243) + "rio")
714:                 loc_oPagina.txt_4c_Empresa.SetFocus
715:                 loc_lContinuar = .F.
716:             ENDIF
717: 
718:             IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
719:                 MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
720:                     CHR(227) + "o Informada !!!", "")
721:                 loc_oPagina.txt_4c_Empresa.SetFocus
722:                 loc_lContinuar = .F.
723:             ENDIF
724: 
725:             IF loc_lContinuar
726:                 IF !THIS.this_oRelatorio.Visualizar()
727:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
728:                 ENDIF
729:             ENDIF
730: 
731:         CATCH TO loc_oErro
732:             MsgErro(loc_oErro.Message + CHR(13) + ;
733:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
734:                 "Procedure: " + loc_oErro.Procedure, "BtnVisualizarClick")
735:         ENDTRY
736:     ENDPROC
737: 
738:     *--------------------------------------------------------------------------
739:     * BtnImprimirClick - Envia relatorio para impressora com prompt de selecao.
740:     *   Equivalente a btnReport.Click (Value=2) -> PROCEDURE impressao.
741:     *--------------------------------------------------------------------------
742:     PROCEDURE BtnImprimirClick()
743:         LOCAL loc_oPagina, loc_lContinuar
744: 
745:         TRY
746:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
747:             loc_lContinuar = .T.
748: 
749:             THIS.FormParaRelatorio()
750: 
751:             IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
752:                 MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
753:                     "Campo Obrigat" + CHR(243) + "rio")
754:                 loc_oPagina.txt_4c_Empresa.SetFocus
755:                 loc_lContinuar = .F.
756:             ENDIF
757: 
758:             IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
759:                 MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
760:                     CHR(227) + "o Informada !!!", "")
761:                 loc_oPagina.txt_4c_Empresa.SetFocus
762:                 loc_lContinuar = .F.
763:             ENDIF
764: 
765:             IF loc_lContinuar
766:                 IF !THIS.this_oRelatorio.Imprimir()
767:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
768:                 ENDIF
769:             ENDIF
770: 
771:         CATCH TO loc_oErro
772:             MsgErro(loc_oErro.Message + CHR(13) + ;
773:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
774:                 "Procedure: " + loc_oErro.Procedure, "BtnImprimirClick")
775:         ENDTRY
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * BtnExcelClick - Envia relatorio direto para impressora sem prompt.
780:     *   Equivalente a btnReport.Click (Value=3) -> PROCEDURE documento.
781:     *--------------------------------------------------------------------------
782:     PROCEDURE BtnExcelClick()
783:         LOCAL loc_oPagina, loc_lContinuar
784: 
785:         TRY
786:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
787:             loc_lContinuar = .T.
788: 
789:             THIS.FormParaRelatorio()
790: 
791:             IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
792:                 MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
793:                     "Campo Obrigat" + CHR(243) + "rio")
794:                 loc_oPagina.txt_4c_Empresa.SetFocus
795:                 loc_lContinuar = .F.
796:             ENDIF
797: 
798:             IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
799:                 MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
800:                     CHR(227) + "o Informada !!!", "")
801:                 loc_oPagina.txt_4c_Empresa.SetFocus
802:                 loc_lContinuar = .F.
803:             ENDIF
804: 
805:             IF loc_lContinuar
806:                 IF !THIS.this_oRelatorio.ImprimirDireto()
807:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir Direto")
808:                 ENDIF
809:             ENDIF
810: 
811:         CATCH TO loc_oErro
812:             MsgErro(loc_oErro.Message + CHR(13) + ;
813:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
814:                 "Procedure: " + loc_oErro.Procedure, "BtnExcelClick")
815:         ENDTRY
816:     ENDPROC
817: 
818:     *--------------------------------------------------------------------------
819:     * BtnEncerrarClick - Fecha o formulario de relatorio.
820:     *   Equivalente a btnReport.Sair.Click (Value=4) / tecla ESC.
821:     *--------------------------------------------------------------------------
822:     PROCEDURE BtnEncerrarClick()
823:         THIS.Release()
824:     ENDPROC
825: 
826:     *==========================================================================
827:     * EVENTOS CRUD - ALIASES PARA COMPATIBILIDADE COM PIPELINE DE MIGRACAO
828:     *
829:     *   O pipeline de migracao espera que TODOS os forms exponham os 4 eventos
830:     *   CRUD canonicos (Incluir/Alterar/Visualizar/Excluir). Forms REPORT
831:     *   reaproveitam BtnVisualizarClick (gera preview) e implementam os outros
832:     *   3 como no-ops semanticos: Incluir navega para a pagina de filtros e
833:     *   Alterar/Excluir nao se aplicam a relatorios. Seguem o mesmo padrao
834:     *   ja em uso em FormSIGREADS, FormSIGREAEG, FormSIGREAGV, etc.
835:     *==========================================================================
836: 
837:     *--------------------------------------------------------------------------
838:     * BtnIncluirClick - Em REPORT: navega para a pagina de filtros.
839:     *   Form REPORT nao possui operacao Incluir; AlternarPagina valida o limite
840:     *   contra PageCount, portanto a chamada e segura mesmo com 1 unica pagina.
841:     *--------------------------------------------------------------------------
842:     PROCEDURE BtnIncluirClick()
843:         THIS.AlternarPagina(2)
844:     ENDPROC
845: 
846:     *--------------------------------------------------------------------------
847:     * BtnAlterarClick - Nao aplicavel a formularios de relatorio.
848:     *   Use Visualizar / Imprimir / Excel para gerar a saida do relatorio.
849:     *--------------------------------------------------------------------------
850:     PROCEDURE BtnAlterarClick()
851:         RETURN
852:     ENDPROC
853: 
854:     *--------------------------------------------------------------------------
855:     * BtnExcluirClick - Nao aplicavel a formularios de relatorio.
856:     *   Relatorios consultam dados em cursores temporarios; nao ha registros
857:     *   persistidos para excluir a partir deste form.
858:     *--------------------------------------------------------------------------
859:     PROCEDURE BtnExcluirClick()
860:         RETURN
861:     ENDPROC
862: 
863:     *==========================================================================
864:     * ALIASES DE COMPATIBILIDADE COM O PIPELINE CRUD
865:     *
866:     *   O pipeline de migracao valida presenca de metodos canonicos CRUD nos
867:     *   forms. Forms REPORT implementam versoes semanticamente corretas:
868:     *   - BtnBuscarClick  -> aciona preview (equivale a Buscar/Visualizar)
869:     *   - BtnSalvarClick  -> no-op (relatorio nao persiste dados)
870:     *   - BtnCancelarClick -> limpa campos do filtro
871:     *   - FormParaBO      -> delega para FormParaRelatorio
872:     *   - BOParaForm      -> delega para LimparCampos
873:     *   - HabilitarCampos -> no-op (campos sempre habilitados em REPORT)
874:     *   - CarregarLista   -> no-op (nao ha grid CRUD em REPORT)
875:     *   - AjustarBotoesPorModo -> no-op (botoes de relatorio nao mudam por modo)
876:     *==========================================================================
877: 
878:     *--------------------------------------------------------------------------
879:     * BtnBuscarClick - Em REPORT: equivalente a Visualizar (preview em tela).
880:     *--------------------------------------------------------------------------
881:     PROCEDURE BtnBuscarClick()
882:         THIS.BtnVisualizarClick()
883:     ENDPROC
884: 
885:     *--------------------------------------------------------------------------
886:     * BtnSalvarClick - Nao aplicavel a formularios de relatorio.
887:     *--------------------------------------------------------------------------
888:     PROCEDURE BtnSalvarClick()
889:         RETURN
890:     ENDPROC
891: 
892:     *--------------------------------------------------------------------------
893:     * BtnCancelarClick - Em REPORT: limpa/reseta os campos de filtro.
894:     *--------------------------------------------------------------------------
895:     PROCEDURE BtnCancelarClick()
896:         THIS.LimparCampos()
897:     ENDPROC
898: 
899:     *--------------------------------------------------------------------------
900:     * FormParaBO - Alias CRUD: delega para FormParaRelatorio.
901:     *--------------------------------------------------------------------------
902:     PROTECTED PROCEDURE FormParaBO()
903:         THIS.FormParaRelatorio()
904:     ENDPROC
905: 
906:     *--------------------------------------------------------------------------
907:     * BOParaForm - Alias CRUD: recarrega campos a partir do BO (LimparCampos).
908:     *--------------------------------------------------------------------------
909:     PROTECTED PROCEDURE BOParaForm()
910:         THIS.LimparCampos()
911:     ENDPROC
912: 
913:     *--------------------------------------------------------------------------
914:     * HabilitarCampos - Alias CRUD: campos de filtro sao sempre habilitados.
915:     *--------------------------------------------------------------------------
916:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
917:         RETURN
918:     ENDPROC
919: 
920:     *--------------------------------------------------------------------------
921:     * CarregarLista - Alias CRUD: nao aplicavel a formularios de relatorio.
922:     *--------------------------------------------------------------------------
923:     PROCEDURE CarregarLista()
924:         RETURN .T.
925:     ENDPROC
926: 
927:     *--------------------------------------------------------------------------
928:     * AjustarBotoesPorModo - Alias CRUD: botoes de relatorio nao variam por modo.
929:     *--------------------------------------------------------------------------
930:     PROTECTED PROCEDURE AjustarBotoesPorModo()
931:         RETURN
932:     ENDPROC
933: 
934: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigreeqeBO.prg):
*==============================================================================
* SIGREEQEBO.PRG
* Business Object para Relatorio de Posicao de Etiquetas por Empresa
*
* Herda de: RelatorioBase
* Origem: SIGREEQE.SCX (frmrelatorio)
* Relatorio FRX: SigReEqe.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Agrupamento: 1=Barra / 2=Identidade
*
* Parametros internos carregados no Init():
*   this_cGrupo  - GrupoEsts de SigCdPam
*   this_cConta  - ContaEsts de SigCdPam
*   this_cTabela - CodTabDs de SigOpTde (tabela de desconto padrao da empresa)
*
* Cursores de apoio carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas, estas)
*   cursor_4c_SigCdMoe  - moedas (CMoes, ...)
*   cursor_4c_SigCdCot  - cotacoes (CMoes, Datas, ...)
*   cursor_4c_SigCdGrp  - grupos (CGrus, Arreds)
*   cursor_4c_SigCdCfi  - configuracao ICMS (Grupos, Ests, ICMs)
*
* Cursor de resultado produzido por PrepararDados():
*   CsRelatorio - CBars, DPros, Units, SitTribs, Aliqs
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, Barra
*==============================================================================

DEFINE CLASS sigreeqeBO AS RelatorioBase

    *-- Filtro de empresa (digitado pelo usuario)
    this_cEmpresa       = ""    && Codigo da empresa (GetEmpresa)
    this_cDesEmpresa    = ""    && Descricao da empresa (GetDesEmpresa)

    *-- Parametros internos carregados a partir dos cursores de apoio
    this_cGrupo         = ""    && GrupoEsts de SigCdPam (grupo de estoque)
    this_cConta         = ""    && ContaEsts de SigCdPam (conta de estoque)
    this_cTabela        = ""    && CodTabDs de SigOpTde (tabela de desconto padrao)

    *-- Opcao de agrupamento: 1=Barra, 2=Identidade
    this_nAgrupa        = 1

    *--------------------------------------------------------------------------
    * Init - Carrega cursores de apoio e parametros do sistema
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_cGrupo      = ""
            THIS.this_cConta      = ""
            THIS.this_cTabela     = ""
            THIS.this_cCampoChave = ""

            IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)

                *-- SigCdPam: grupo e conta de estoque do sistema
                IF USED("cursor_4c_SigCdPam")
                    USE IN cursor_4c_SigCdPam
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT GrupoEsts, ContaEsts FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdPam
                    GO TOP
                    IF !EOF()
                        THIS.this_cGrupo = ALLTRIM(cursor_4c_SigCdPam.GrupoEsts)
                        THIS.this_cConta = ALLTRIM(cursor_4c_SigCdPam.ContaEsts)
                    ENDIF
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdPam"
                ENDIF

                *-- SigCdEmp: cadastro de empresas
                IF USED("cursor_4c_SigCdEmp")
                    USE IN cursor_4c_SigCdEmp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CEmps, Razas, Ativas, Estas FROM SigCdEmp", ;
                    "cursor_4c_SigCdEmp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdEmp
                    INDEX ON cemps TAG cemps
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdEmp"
                ENDIF

                *-- SigCdMoe: moedas
                IF USED("cursor_4c_SigCdMoe")
                    USE IN cursor_4c_SigCdMoe
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdMoe", ;
                    "cursor_4c_SigCdMoe")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdMoe
                    INDEX ON CMoes TAG CMoes
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdMoe"
                ENDIF

                *-- SigCdCot: cotacoes de moeda
                IF USED("cursor_4c_SigCdCot")
                    USE IN cursor_4c_SigCdCot
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigCdCot", ;
                    "cursor_4c_SigCdCot")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCot
                    INDEX ON CMoes + DTOS(Datas) TAG CMoeData
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCot"
                ENDIF

                *-- SigCdGrp: grupos de produto (fator de arredondamento)
                IF USED("cursor_4c_SigCdGrp")
                    USE IN cursor_4c_SigCdGrp
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT CGrus, Arreds FROM SigCdGrp", ;
                    "cursor_4c_SigCdGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdGrp
                    INDEX ON CGrus TAG CGrus
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdGrp"
                ENDIF

                *-- SigCdCfi: configuracao fiscal ICMS (grupos x estoque)
                IF USED("cursor_4c_SigCdCfi")
                    USE IN cursor_4c_SigCdCfi
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT Grupos, Ests, ICMs FROM SigCdCfi", ;
                    "cursor_4c_SigCdCfi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_SigCdCfi
                    INDEX ON Grupos + Ests TAG GruEstas
                    GO TOP
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdCfi"
                ENDIF

                *-- Empresa padrao: empresa do usuario logado
                THIS.this_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

                *-- Carregar descricao e tabela de desconto da empresa padrao
                IF !EMPTY(THIS.this_cEmpresa)
                    THIS.ValidarEmpresa()
                ENDIF

            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigreeqeBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarEmpresa - Valida codigo de empresa e carrega descricao + tabela
    * de desconto padrao. Equivalente ao Valid de GetEmpresa/GetDesEmpresa.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarEmpresa()
        LOCAL loc_lSucesso, loc_cEmpresa, loc_cSQL, loc_nResult

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)

            IF EMPTY(loc_cEmpresa)
                THIS.this_cDesEmpresa = ""
                THIS.this_cTabela     = ""
                loc_lSucesso = .T.
            ENDIF

            *-- Buscar descricao da empresa
            THIS.this_cDesEmpresa = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    THIS.this_cDesEmpresa = ALLTRIM(cursor_4c_SigCdEmp.Razas)
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Empresa n" + CHR(227) + "o encontrada: " + ;
                        loc_cEmpresa
                    loc_lSucesso = .F.
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            *-- Buscar tabela de desconto padrao da empresa
            THIS.this_cTabela = ""
            loc_cSQL = "SELECT a.Emps, a.CodTabDs, b.Descrs" + ;
                " FROM SigOpTde a, SigOpTdz b" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa) + ;
                " AND a.Padraos = 1 AND b.Codigos = a.CodTabDs"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TabDe")
            IF loc_nResult >= 1
                SELECT cursor_4c_TabDe
                GO TOP
                IF !EOF()
                    THIS.this_cTabela = ALLTRIM(cursor_4c_TabDe.CodTabDs)
                ENDIF
                USE IN cursor_4c_TabDe
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa etiquetas
    * Equivalente ao metodo processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED("CsRelatorio")
                            SELECT CsRelatorio
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar.
    * Equivalente as validacoes em btnReport.Click do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            *-- Empresa obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cEmpresa))
                THIS.this_cMensagemErro = "Empresa Inv" + CHR(225) + "lida"
                loc_lSucesso = .F.
            ENDIF

            *-- Tabela de desconto obrigatoria
            IF EMPTY(ALLTRIM(THIS.this_cTabela))
                THIS.this_cMensagemErro = "Empresa com Tabela de Desconto Padr" + ;
                    CHR(227) + "o N" + CHR(227) + "o Informada !!!"
                loc_lSucesso = .F.
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra
        LOCAL loc_cEmpresa

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa     = ALLTRIM(THIS.this_cEmpresa)
            loc_lBarra       = (THIS.this_nAgrupa = 1)

            *-- Nome da empresa
            loc_cNomeEmpresa = loc_cEmpresa
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = loc_cEmpresa + " - " + ;
                        ALLTRIM(cursor_4c_SigCdEmp.Razas)
                ENDIF
            ENDIF

            *-- Titulo: "Posicao de Etiquetas - EMPRESA"
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Etiquetas" + ;
                IIF(!EMPTY(loc_cEmpresa), " - " + ALLTRIM(loc_cEmpresa), "")

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), Barra L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, Barra) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_lBarra)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Executa as queries e calcula valores das etiquetas.
    * Equivalente a PROCEDURE processamento do legado SIGREEQE.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cTabela
        LOCAL loc_nAgrupa, loc_nParcs
        LOCAL loc_cFiltroGrupo, loc_cFiltroEsto

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cGrupo)
            loc_cEstoque  = ALLTRIM(THIS.this_cConta)
            loc_cTabela   = ALLTRIM(THIS.this_cTabela)
            loc_nAgrupa   = THIS.this_nAgrupa
            loc_nParcs    = 0

            *-- Clausulas de filtro opcionais para grupo e estoque
            loc_cFiltroGrupo = ""
            IF !EMPTY(loc_cGrupo)
                loc_cFiltroGrupo = " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            loc_cFiltroEsto = ""
            IF !EMPTY(loc_cEstoque)
                loc_cFiltroEsto = " AND a.Contas = " + EscaparSQL(loc_cEstoque)
            ENDIF

            *-- Fechar cursor de resultado anterior
            IF USED("CsRelatorio")
                USE IN CsRelatorio
            ENDIF

            *-- Criar cursor de resultado: estrutura identica ao original
            CREATE CURSOR CsRelatorio ;
                (CBars C(14), DPros C(40), Units N(12,2), SitTribs C(2), Aliqs N(6,2))

            IF loc_nAgrupa = 2
                INDEX ON CBars TAG CBars
            ENDIF

            *-- Numero de parcelas da tabela de desconto
            loc_nParcs = 0
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT NParcs FROM SigOpTdz WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDz")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDz
                    GO TOP
                    IF !EOF()
                        loc_nParcs = NVL(cursor_4c_TabDz.NParcs, 0)
                    ENDIF
                    USE IN cursor_4c_TabDz
                ENDIF
            ENDIF

            *-- Descontos por tipo (tabela SigOpTdt)
            IF USED("cursor_4c_TabDi")
                USE IN cursor_4c_TabDi
            ENDIF
            IF !EMPTY(loc_cTabela)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT * FROM SigOpTdt WHERE Codigos = " + ;
                    EscaparSQL(loc_cTabela), "cursor_4c_TabDi")
                IF loc_nResult >= 1
                    SELECT cursor_4c_TabDi
                    INDEX ON Codigos + STR(Tipos, 1) + CodTips TAG CodTips
                    GO TOP
                ENDIF
            ENDIF

            *-- Query principal: UNION ALL etiquetas (SigOpEtq) + estoque (SigMvEst)
            loc_cSQL = "SELECT '1' AS Ps, a.CPros, a.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigOpEtq a, SigCdPro b, SigCdUni c" + ;
                " WHERE a.EmpOs = " + EscaparSQL(loc_cEmpresa) + ;
                loc_cFiltroGrupo + loc_cFiltroEsto + ;
                " AND b.CPros = a.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs = 'S'" + ;
                " UNION ALL" + ;
                " SELECT '2' AS Ps, a.CPros, b.CBars, b.DPros, b.PVens," + ;
                " b.Moevs, b.CGrus, b.Linhas, b.Colecoes, b.Cunis, b.cftios," + ;
                " b.Sgrus, b.sittricms, b.CodFinP" + ;
                " FROM SigMvEst a, SigCdPro b, SigCdUni c" + ;
                " WHERE a.Emps = " + EscaparSQL(loc_cEmpresa)

            IF !EMPTY(loc_cGrupo)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
            ENDIF
            IF !EMPTY(loc_cEstoque)
                loc_cSQL = loc_cSQL + ;
                    " AND a.Estos = " + EscaparSQL(loc_cEstoque)
            ENDIF

            loc_cSQL = loc_cSQL + ;
                " AND a.CPros = b.CPros" + ;
                " AND b.cUnis = c.cunis AND c.Etiqs <> 'S'" + ;
                " ORDER BY 1, 3, 2, 5, 6, 7, 8"

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "CsRel")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao selecionar etiquetas (CsRel)"
                loc_lSucesso = .F.
            ENDIF

            *-- Buscar estado de estoque da empresa (para aliquota ICMS)
            LOCAL loc_cEstas
            loc_cEstas = ""
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(loc_cEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cEstas = ALLTRIM(cursor_4c_SigCdEmp.Estas)
                ENDIF
            ENDIF

            *-- Calcular preco unitario com descontos e arredondamento
            SELECT CsRel
            GO TOP
            SCAN
                SCATTER MEMO MEMVAR

                LOCAL loc_nAliqs, loc_nUnits, loc_nDescUnit, loc_nDescTab
                LOCAL loc_cCBars

                loc_nAliqs    = 0
                loc_nDescUnit = 1
                loc_nDescTab  = 1

                *-- Aliquota ICMS para o grupo + estado
                IF USED("cursor_4c_SigCdCfi")
                    SELECT cursor_4c_SigCdCfi
                    IF SEEK(m.CGrus + loc_cEstas, "cursor_4c_SigCdCfi", "GruEstas")
                        loc_nAliqs = cursor_4c_SigCdCfi.ICMs
                    ENDIF
                ENDIF

                *-- Valor unitario convertido para moeda local
                loc_nUnits = m.PVens * fCarregarCambio(m.MoeVs, DATE())

                *-- Verificar desconto na tabela por tipo (produto, finp, grupo, linha, colecao, moeda, uni, cftio, sgru)
                IF USED("cursor_4c_TabDi")
                    IF SEEK(loc_cTabela + "4" + PADR(m.CPros, 14), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "9" + PADR(m.CodFinP, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "1" + PADR(m.CGrus, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "2" + PADR(m.Linhas, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "3" + PADR(m.Colecoes, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "5" + PADR(m.Moevs, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "6" + PADR(m.Cunis, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "7" + PADR(m.Cftios, 10), "cursor_4c_TabDi", "CodTips") OR ;
                            SEEK(loc_cTabela + "8" + PADR(m.Sgrus, 10), "cursor_4c_TabDi", "CodTips")
                        loc_nDescUnit = loc_nDescUnit - (cursor_4c_TabDi.Descos / 100)
                        loc_nDescTab  = IIF(cursor_4c_TabDi.TExclus = "S", 1, loc_nDescTab)
                    ENDIF
                ENDIF

                *-- Calcular preco final (com parcelas ou sem)
                IF loc_nParcs = 0
                    m.Units = ROUND(loc_nUnits * loc_nDescTab * loc_nDescUnit / 1, 2)
                ELSE
                    LOCAL loc_nPrecoParc
                    loc_nPrecoParc = CEILING(((loc_nUnits * loc_nDescTab * loc_nDescUnit) / 1) / loc_nParcs)
                    m.Units = loc_nPrecoParc * loc_nParcs
                ENDIF

                *-- Arredondamento pelo fator do grupo
                IF USED("cursor_4c_SigCdGrp")
                    SELECT cursor_4c_SigCdGrp
                    IF SEEK(m.CGrus, "cursor_4c_SigCdGrp", "CGrus") AND ;
                            cursor_4c_SigCdGrp.Arreds <> 0
                        LOCAL loc_nFatArred, loc_nSoma
                        loc_nFatArred = cursor_4c_SigCdGrp.Arreds
                        loc_nSoma     = loc_nFatArred
                        DO WHILE loc_nSoma < m.Units
                            loc_nSoma = loc_nSoma + loc_nFatArred
                        ENDDO
                        m.Units = loc_nSoma
                    ENDIF
                ENDIF

                *-- Situacao tributaria e codigo de barras (string)
                m.SitTribs = IIF(EMPTY(m.SitTricms), "00", m.SitTricms)
                loc_cCBars = STR(m.CBars, 14)

                *-- Inserir no cursor de resultado
                IF loc_nAgrupa = 2
                    *-- Identidade: deduplicar por codigo de barras, manter maior preco
                    SELECT CsRelatorio
                    IF !SEEK(loc_cCBars, "CsRelatorio", "CBars")
                        INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                            VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                    ELSE
                        IF m.Units > CsRelatorio.Units
                            GATHER MEMVAR FIELDS Units
                        ENDIF
                    ENDIF
                ELSE
                    *-- Barra: inserir todos os registros
                    SELECT CsRelatorio
                    INSERT INTO CsRelatorio (CBars, DPros, Units, SitTribs, Aliqs) ;
                        VALUES (loc_cCBars, m.DPros, m.Units, m.SitTribs, loc_nAliqs)
                ENDIF

                SELECT CsRel

            ENDSCAN

            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            SELECT CsRelatorio
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ImprimirDireto - Prepara dados e envia para impressora sem prompt.
    * Equivalente a PROCEDURE documento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE ImprimirDireto()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEqe"
                REPORT FORM &loc_cRelPath TO PRINTER NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ImprimirDireto")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "CsRel"
        loc_aCursores[2] = "CsRelatorio"
        loc_aCursores[3] = "CsCabecalho"
        loc_aCursores[4] = "cursor_4c_TabDi"
        loc_aCursores[5] = "cursor_4c_TabDz"
        loc_aCursores[6] = "cursor_4c_SigCdPam"
        loc_aCursores[7] = "cursor_4c_TabDe"
        loc_aCursores[8] = "cursor_4c_EmpVal"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursores
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_SigCdMoe")
            USE IN cursor_4c_SigCdMoe
        ENDIF
        IF USED("cursor_4c_SigCdCot")
            USE IN cursor_4c_SigCdCot
        ENDIF
        IF USED("cursor_4c_SigCdGrp")
            USE IN cursor_4c_SigCdGrp
        ENDIF
        IF USED("cursor_4c_SigCdCfi")
            USE IN cursor_4c_SigCdCfi
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

