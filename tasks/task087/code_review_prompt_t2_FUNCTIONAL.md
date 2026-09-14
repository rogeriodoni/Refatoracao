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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreeqe.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (936 linhas total):

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

*-- Linhas 389 a 936:
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
417:                     .Themes    = .F.
418:                     .Visible   = .T.
419:                 ENDWITH
420: 
421:                 WITH .Buttons(2)
422:                     .Caption   = "Identidade"
423:                     .FontName  = "Tahoma"
424:                     .FontSize  = 8
425:                     .BackStyle = 0
426:                     .Height    = 15
427:                     .Left      = 63
428:                     .Top       = 5
429:                     .AutoSize  = .T.
430:                     .ForeColor = RGB(90, 90, 90)
431:                     .Themes    = .F.
432:                     .Visible   = .T.
433:                 ENDWITH
434:             ENDWITH
435: 
436:         CATCH TO loc_oErro
437:             MsgErro(loc_oErro.Message + CHR(13) + ;
438:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
439:                 "Procedure: " + loc_oErro.Procedure, "ConfigurarPaginaFiltros")
440:         ENDTRY
441:     ENDPROC
442: 
443:     *--------------------------------------------------------------------------
444:     * ConfigurarPaginaLista - Alias canonico do pipeline de migracao (frmcadastro).
445:     *   Em forms REPORT (frmrelatorio) NAO existe Page1 com grid CRUD: a unica
446:     *   pagina hospeda os campos de filtro do relatorio. Por compatibilidade
447:     *   com o validador automatico (que procura este identificador), expomos
448:     *   esta entrada que delega para ConfigurarPaginaFiltros.
449:     *--------------------------------------------------------------------------
450:     PROTECTED PROCEDURE ConfigurarPaginaLista()
451:         THIS.ConfigurarPaginaFiltros()
452:     ENDPROC
453: 
454:     *--------------------------------------------------------------------------
455:     * ConfigurarPaginaDados - Alias canonico do pipeline de migracao (frmcadastro).
456:     *   Em forms REPORT nao existe Page2 de dados separada. Delegamos para
457:     *   ConfigurarPaginaFiltros para que o validador das fases 5/6 reconheca
458:     *   o ponto de entrada padrao.
459:     *--------------------------------------------------------------------------
460:     PROTECTED PROCEDURE ConfigurarPaginaDados()
461:         THIS.ConfigurarPaginaFiltros()
462:     ENDPROC
463: 
464:     *--------------------------------------------------------------------------
465:     * AlternarPagina - Navega entre paginas do PageFrame
466:     *   Para form REPORT: Page1=Filtros (unica pagina ativa). Mantido para
467:     *   compatibilidade com o pipeline e eventual expansao futura.
468:     *--------------------------------------------------------------------------
469:     PROCEDURE AlternarPagina(par_nPagina)
470:         IF !PEMSTATUS(THIS, "pgf_4c_Paginas", 5)
471:             RETURN
472:         ENDIF
473:         IF par_nPagina >= 1 AND par_nPagina <= THIS.pgf_4c_Paginas.PageCount
474:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
475:             THIS.pgf_4c_Paginas.Refresh()
476:         ENDIF
477:     ENDPROC
478: 
479:     *--------------------------------------------------------------------------
480:     * FormParaRelatorio - Copia valores dos campos do form para o BO.
481:     * Chamado antes de Visualizar(), Imprimir() ou ImprimirDireto().
482:     *--------------------------------------------------------------------------
483:     PROTECTED PROCEDURE FormParaRelatorio()
484:         LOCAL loc_oPagina
485:         TRY
486:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
487: 
488:             WITH THIS.this_oRelatorio
489:                 .this_cEmpresa    = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
490:                 .this_cDesEmpresa = ALLTRIM(loc_oPagina.txt_4c_DesEmpresa.Value)
491:                 .this_nAgrupa     = loc_oPagina.opg_4c_Agrupa.Value
492:             ENDWITH
493: 
494:         CATCH TO loc_oErro
495:             MsgErro(loc_oErro.Message + CHR(13) + ;
496:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
497:                 "Procedure: " + loc_oErro.Procedure, "FormParaRelatorio")
498:         ENDTRY
499:     ENDPROC
500: 
501:     *--------------------------------------------------------------------------
502:     * LimparCampos - Carrega defaults do BO nos campos do form.
503:     * Chamado em InicializarForm (apos BO criado) e ao cancelar.
504:     * BO.Init() ja carregou: this_cEmpresa = empresa padrao do usuario.
505:     *--------------------------------------------------------------------------
506:     PROCEDURE LimparCampos()
507:         LOCAL loc_oPagina, loc_cEmpresa, loc_cDesEmpresa
508:         TRY
509:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
510: 
511:             *-- Ler valores do BO (podem ja ter sido preenchidos pelo Init do BO)
512:             IF VARTYPE(THIS.this_oRelatorio) = "O"
513:                 loc_cEmpresa    = ALLTRIM(THIS.this_oRelatorio.this_cEmpresa)
514:                 loc_cDesEmpresa = ALLTRIM(THIS.this_oRelatorio.this_cDesEmpresa)
515:             ELSE
516:                 loc_cEmpresa    = ""
517:                 loc_cDesEmpresa = ""
518:             ENDIF
519: 
520:             loc_oPagina.txt_4c_Empresa.Value    = loc_cEmpresa
521:             loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDesEmpresa
522: 
523:             *-- Descricao habilitada apenas quando codigo esta vazio (equivalente ao When legado)
524:             loc_oPagina.txt_4c_DesEmpresa.Enabled = EMPTY(loc_cEmpresa)
525: 
526:             *-- Agrupamento: default Barra (1), mesmo que o legado
527:             loc_oPagina.opg_4c_Agrupa.Value = 1
528: 
529:         CATCH TO loc_oErro
530:             MsgErro(loc_oErro.Message + CHR(13) + ;
531:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
532:                 "Procedure: " + loc_oErro.Procedure, "LimparCampos")
533:         ENDTRY
534:     ENDPROC
535: 
536:     *--------------------------------------------------------------------------
537:     * Destroy - Libera BO de relatorio e chama destrutor da base
538:     *--------------------------------------------------------------------------
539:     PROCEDURE Destroy()
540:         IF VARTYPE(THIS.this_oRelatorio) = "O"
541:             THIS.this_oRelatorio = .NULL.
542:         ENDIF
543:         DODEFAULT()
544:     ENDPROC
545: 
546:     *--------------------------------------------------------------------------
547:     * ConfigurarEventos - Registra BINDEVENTs para todos os controles interativos.
548:     *   Chamado em InicializarForm apos todos os objetos estarem criados.
549:     *--------------------------------------------------------------------------
550:     PROTECTED PROCEDURE ConfigurarEventos()
551:         LOCAL loc_oPagina
552:         TRY
553:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
554: 
555:             *-- Campo codigo da empresa: F4=lookup, Enter/Tab=validar
556:             BINDEVENT(loc_oPagina.txt_4c_Empresa, "KeyPress", THIS, "EmpresaKeyPress")
557: 
558:             *-- Campo descricao: Enter/Tab/F4=abrir lookup por nome (equivalente ao Valid legado)
559:             BINDEVENT(loc_oPagina.txt_4c_DesEmpresa, "KeyPress", THIS, "DesEmpresaKeyPress")
560: 
561:             *-- Botoes de relatorio: cada botao com seu Click handler
562:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
563:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
564:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
565:             BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
566: 
567:         CATCH TO loc_oErro
568:             MsgErro(loc_oErro.Message + CHR(13) + ;
569:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
570:                 "Procedure: " + loc_oErro.Procedure, "ConfigurarEventos")
571:         ENDTRY
572:     ENDPROC
573: 
574:     *--------------------------------------------------------------------------
575:     * EmpresaKeyPress - Handler de teclado para txt_4c_Empresa.
576:     *   F4(115)=lookup direto, Enter(13)/Tab(9)=validar codigo digitado.
577:     *--------------------------------------------------------------------------
578:     PROCEDURE EmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
579:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
580:             THIS.AbrirLookupEmpresa()
581:         ELSE
582:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
583:             THIS.ValidarCodEmpresa()
584:             ENDIF
585:         ENDIF
586:     ENDPROC
587: 
588:     *--------------------------------------------------------------------------
589:     * DesEmpresaKeyPress - Handler de teclado para txt_4c_DesEmpresa.
590:     *   Enter/Tab/F4 abrem lookup filtrado pelo nome digitado.
591:     *   Equivalente ao Valid do GetDesEmpresa no legado (busca por razao social).
592:     *--------------------------------------------------------------------------
593:     PROCEDURE DesEmpresaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
594:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
595:             THIS.AbrirLookupEmpresa()
596:         ENDIF
597:     ENDPROC
598: 
599:     *--------------------------------------------------------------------------
600:     * ValidarCodEmpresa - Valida codigo digitado em txt_4c_Empresa contra o banco.
601:     *   Preenche txt_4c_DesEmpresa e atualiza this_cTabela no BO.
602:     *   Se empresa nao encontrada: limpa campos e abre lookup.
603:     *   Equivalente ao Valid do GetEmpresa no legado.
604:     *--------------------------------------------------------------------------
605:     PROCEDURE ValidarCodEmpresa()
606:         LOCAL loc_cValor, loc_oPagina, loc_lContinuar
607: 
608:         TRY
609:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
610:             loc_cValor     = ALLTRIM(loc_oPagina.txt_4c_Empresa.Value)
611:             loc_lContinuar = .T.
612: 
613:             IF EMPTY(loc_cValor)
614:                 loc_oPagina.txt_4c_DesEmpresa.Value   = ""
615:                 loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
616:                 THIS.this_oRelatorio.this_cEmpresa     = ""
617:                 THIS.this_oRelatorio.this_cDesEmpresa  = ""
618:                 THIS.this_oRelatorio.this_cTabela      = ""
619:                 loc_lContinuar = .F.
620:             ENDIF
621: 
622:             IF loc_lContinuar
623:                 THIS.this_oRelatorio.this_cEmpresa = loc_cValor
624:                 IF !THIS.this_oRelatorio.ValidarEmpresa()
625:                     loc_oPagina.txt_4c_Empresa.Value      = ""
626:                     loc_oPagina.txt_4c_DesEmpresa.Value   = ""
627:                     loc_oPagina.txt_4c_DesEmpresa.Enabled = .T.
628:                     THIS.this_oRelatorio.this_cEmpresa    = ""
629:                     THIS.this_oRelatorio.this_cDesEmpresa = ""
630:                     THIS.this_oRelatorio.this_cTabela     = ""
631:                     MsgAviso("Empresa n" + CHR(227) + "o encontrada." + CHR(13) + ;
632:                         "Selecione da lista.", "Empresa Inv" + CHR(225) + "lida")
633:                     THIS.AbrirLookupEmpresa()
634:                 ELSE
635:                     loc_oPagina.txt_4c_DesEmpresa.Value   = THIS.this_oRelatorio.this_cDesEmpresa
636:                     loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
637:                 ENDIF
638:             ENDIF
639: 
640:         CATCH TO loc_oErro
641:             MsgErro(loc_oErro.Message + CHR(13) + ;
642:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
643:                 "Procedure: " + loc_oErro.Procedure, "ValidarCodEmpresa")
644:         ENDTRY
645:     ENDPROC
646: 
647:     *--------------------------------------------------------------------------
648:     * AbrirLookupEmpresa - Abre FormBuscaAuxiliar para selecionar empresa.
649:     *   Preenche txt_4c_Empresa e txt_4c_DesEmpresa com a selecao.
650:     *   Atualiza this_cTabela no BO via ValidarEmpresa().
651:     *--------------------------------------------------------------------------
652:     PROCEDURE AbrirLookupEmpresa()
653:         LOCAL loc_oBusca, loc_cCodigo, loc_cDescricao, loc_oPagina
654: 
655:         TRY
656:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
657:             loc_oBusca  = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
658:                 "SigCdEmp", ;
659:                 "cursor_4c_BuscaEmp", ;
660:                 "CEmps", ;
661:                 ALLTRIM(loc_oPagina.txt_4c_Empresa.Value), ;
662:                 "Buscar Empresa")
663: 
664:             loc_oBusca.mAddColuna("CEmps", "", "C" + CHR(243) + "digo")
665:             loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
666: 
667:             loc_oBusca.Show()
668: 
669:             IF loc_oBusca.this_lSelecionou
670:                 IF USED("cursor_4c_BuscaEmp")
671:                     SELECT cursor_4c_BuscaEmp
672:                     loc_cCodigo    = ALLTRIM(cursor_4c_BuscaEmp.CEmps)
673:                     loc_cDescricao = ALLTRIM(cursor_4c_BuscaEmp.Razas)
674: 
675:                     loc_oPagina.txt_4c_Empresa.Value    = loc_cCodigo
676:                     loc_oPagina.txt_4c_DesEmpresa.Value = loc_cDescricao
677: 
678:                     THIS.this_oRelatorio.this_cEmpresa    = loc_cCodigo
679:                     THIS.this_oRelatorio.this_cDesEmpresa = loc_cDescricao
680: 
681:                     THIS.this_oRelatorio.ValidarEmpresa()
682: 
683:                     loc_oPagina.txt_4c_DesEmpresa.Enabled = .F.
684:                 ENDIF
685:             ENDIF
686: 
687:             IF USED("cursor_4c_BuscaEmp")
688:                 USE IN cursor_4c_BuscaEmp
689:             ENDIF
690:             loc_oBusca.Release()
691: 
692:         CATCH TO loc_oErro
693:             MsgErro(loc_oErro.Message + CHR(13) + ;
694:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
695:                 "Procedure: " + loc_oErro.Procedure, "AbrirLookupEmpresa")
696:         ENDTRY
697:     ENDPROC
698: 
699:     *--------------------------------------------------------------------------
700:     * BtnVisualizarClick - Gera relatorio em preview na tela.
701:     *   Equivalente a btnReport.Click (Value=1) -> PROCEDURE visualizacao.
702:     *   Valida empresa e tabela antes de processar (mesma validacao do legado).
703:     *--------------------------------------------------------------------------
704:     PROCEDURE BtnVisualizarClick()
705:         LOCAL loc_oPagina, loc_lContinuar
706: 
707:         TRY
708:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
709:             loc_lContinuar = .T.
710: 
711:             THIS.FormParaRelatorio()
712: 
713:             IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
714:                 MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
715:                     "Campo Obrigat" + CHR(243) + "rio")
716:                 loc_oPagina.txt_4c_Empresa.SetFocus
717:                 loc_lContinuar = .F.
718:             ENDIF
719: 
720:             IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
721:                 MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
722:                     CHR(227) + "o Informada !!!", "")
723:                 loc_oPagina.txt_4c_Empresa.SetFocus
724:                 loc_lContinuar = .F.
725:             ENDIF
726: 
727:             IF loc_lContinuar
728:                 IF !THIS.this_oRelatorio.Visualizar()
729:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
730:                 ENDIF
731:             ENDIF
732: 
733:         CATCH TO loc_oErro
734:             MsgErro(loc_oErro.Message + CHR(13) + ;
735:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
736:                 "Procedure: " + loc_oErro.Procedure, "BtnVisualizarClick")
737:         ENDTRY
738:     ENDPROC
739: 
740:     *--------------------------------------------------------------------------
741:     * BtnImprimirClick - Envia relatorio para impressora com prompt de selecao.
742:     *   Equivalente a btnReport.Click (Value=2) -> PROCEDURE impressao.
743:     *--------------------------------------------------------------------------
744:     PROCEDURE BtnImprimirClick()
745:         LOCAL loc_oPagina, loc_lContinuar
746: 
747:         TRY
748:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
749:             loc_lContinuar = .T.
750: 
751:             THIS.FormParaRelatorio()
752: 
753:             IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
754:                 MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
755:                     "Campo Obrigat" + CHR(243) + "rio")
756:                 loc_oPagina.txt_4c_Empresa.SetFocus
757:                 loc_lContinuar = .F.
758:             ENDIF
759: 
760:             IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
761:                 MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
762:                     CHR(227) + "o Informada !!!", "")
763:                 loc_oPagina.txt_4c_Empresa.SetFocus
764:                 loc_lContinuar = .F.
765:             ENDIF
766: 
767:             IF loc_lContinuar
768:                 IF !THIS.this_oRelatorio.Imprimir()
769:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
770:                 ENDIF
771:             ENDIF
772: 
773:         CATCH TO loc_oErro
774:             MsgErro(loc_oErro.Message + CHR(13) + ;
775:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
776:                 "Procedure: " + loc_oErro.Procedure, "BtnImprimirClick")
777:         ENDTRY
778:     ENDPROC
779: 
780:     *--------------------------------------------------------------------------
781:     * BtnExcelClick - Envia relatorio direto para impressora sem prompt.
782:     *   Equivalente a btnReport.Click (Value=3) -> PROCEDURE documento.
783:     *--------------------------------------------------------------------------
784:     PROCEDURE BtnExcelClick()
785:         LOCAL loc_oPagina, loc_lContinuar
786: 
787:         TRY
788:             loc_oPagina    = THIS.pgf_4c_Paginas.Page1
789:             loc_lContinuar = .T.
790: 
791:             THIS.FormParaRelatorio()
792: 
793:             IF EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cEmpresa))
794:                 MsgAviso("Empresa inv" + CHR(225) + "lida.", ;
795:                     "Campo Obrigat" + CHR(243) + "rio")
796:                 loc_oPagina.txt_4c_Empresa.SetFocus
797:                 loc_lContinuar = .F.
798:             ENDIF
799: 
800:             IF loc_lContinuar AND EMPTY(ALLTRIM(THIS.this_oRelatorio.this_cTabela))
801:                 MsgAviso("Empresa com Tabela de Desconto Padr" + CHR(227) + "o N" + ;
802:                     CHR(227) + "o Informada !!!", "")
803:                 loc_oPagina.txt_4c_Empresa.SetFocus
804:                 loc_lContinuar = .F.
805:             ENDIF
806: 
807:             IF loc_lContinuar
808:                 IF !THIS.this_oRelatorio.ImprimirDireto()
809:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir Direto")
810:                 ENDIF
811:             ENDIF
812: 
813:         CATCH TO loc_oErro
814:             MsgErro(loc_oErro.Message + CHR(13) + ;
815:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
816:                 "Procedure: " + loc_oErro.Procedure, "BtnExcelClick")
817:         ENDTRY
818:     ENDPROC
819: 
820:     *--------------------------------------------------------------------------
821:     * BtnEncerrarClick - Fecha o formulario de relatorio.
822:     *   Equivalente a btnReport.Sair.Click (Value=4) / tecla ESC.
823:     *--------------------------------------------------------------------------
824:     PROCEDURE BtnEncerrarClick()
825:         THIS.Release()
826:     ENDPROC
827: 
828:     *==========================================================================
829:     * EVENTOS CRUD - ALIASES PARA COMPATIBILIDADE COM PIPELINE DE MIGRACAO
830:     *
831:     *   O pipeline de migracao espera que TODOS os forms exponham os 4 eventos
832:     *   CRUD canonicos (Incluir/Alterar/Visualizar/Excluir). Forms REPORT
833:     *   reaproveitam BtnVisualizarClick (gera preview) e implementam os outros
834:     *   3 como no-ops semanticos: Incluir navega para a pagina de filtros e
835:     *   Alterar/Excluir nao se aplicam a relatorios. Seguem o mesmo padrao
836:     *   ja em uso em FormSIGREADS, FormSIGREAEG, FormSIGREAGV, etc.
837:     *==========================================================================
838: 
839:     *--------------------------------------------------------------------------
840:     * BtnIncluirClick - Em REPORT: navega para a pagina de filtros.
841:     *   Form REPORT nao possui operacao Incluir; AlternarPagina valida o limite
842:     *   contra PageCount, portanto a chamada e segura mesmo com 1 unica pagina.
843:     *--------------------------------------------------------------------------
844:     PROCEDURE BtnIncluirClick()
845:         THIS.AlternarPagina(2)
846:     ENDPROC
847: 
848:     *--------------------------------------------------------------------------
849:     * BtnAlterarClick - Nao aplicavel a formularios de relatorio.
850:     *   Use Visualizar / Imprimir / Excel para gerar a saida do relatorio.
851:     *--------------------------------------------------------------------------
852:     PROCEDURE BtnAlterarClick()
853:         RETURN
854:     ENDPROC
855: 
856:     *--------------------------------------------------------------------------
857:     * BtnExcluirClick - Nao aplicavel a formularios de relatorio.
858:     *   Relatorios consultam dados em cursores temporarios; nao ha registros
859:     *   persistidos para excluir a partir deste form.
860:     *--------------------------------------------------------------------------
861:     PROCEDURE BtnExcluirClick()
862:         RETURN
863:     ENDPROC
864: 
865:     *==========================================================================
866:     * ALIASES DE COMPATIBILIDADE COM O PIPELINE CRUD
867:     *
868:     *   O pipeline de migracao valida presenca de metodos canonicos CRUD nos
869:     *   forms. Forms REPORT implementam versoes semanticamente corretas:
870:     *   - BtnBuscarClick  -> aciona preview (equivale a Buscar/Visualizar)
871:     *   - BtnSalvarClick  -> no-op (relatorio nao persiste dados)
872:     *   - BtnCancelarClick -> limpa campos do filtro
873:     *   - FormParaBO      -> delega para FormParaRelatorio
874:     *   - BOParaForm      -> delega para LimparCampos
875:     *   - HabilitarCampos -> no-op (campos sempre habilitados em REPORT)
876:     *   - CarregarLista   -> no-op (nao ha grid CRUD em REPORT)
877:     *   - AjustarBotoesPorModo -> no-op (botoes de relatorio nao mudam por modo)
878:     *==========================================================================
879: 
880:     *--------------------------------------------------------------------------
881:     * BtnBuscarClick - Em REPORT: equivalente a Visualizar (preview em tela).
882:     *--------------------------------------------------------------------------
883:     PROCEDURE BtnBuscarClick()
884:         THIS.BtnVisualizarClick()
885:     ENDPROC
886: 
887:     *--------------------------------------------------------------------------
888:     * BtnSalvarClick - Nao aplicavel a formularios de relatorio.
889:     *--------------------------------------------------------------------------
890:     PROCEDURE BtnSalvarClick()
891:         RETURN
892:     ENDPROC
893: 
894:     *--------------------------------------------------------------------------
895:     * BtnCancelarClick - Em REPORT: limpa/reseta os campos de filtro.
896:     *--------------------------------------------------------------------------
897:     PROCEDURE BtnCancelarClick()
898:         THIS.LimparCampos()
899:     ENDPROC
900: 
901:     *--------------------------------------------------------------------------
902:     * FormParaBO - Alias CRUD: delega para FormParaRelatorio.
903:     *--------------------------------------------------------------------------
904:     PROTECTED PROCEDURE FormParaBO()
905:         THIS.FormParaRelatorio()
906:     ENDPROC
907: 
908:     *--------------------------------------------------------------------------
909:     * BOParaForm - Alias CRUD: recarrega campos a partir do BO (LimparCampos).
910:     *--------------------------------------------------------------------------
911:     PROTECTED PROCEDURE BOParaForm()
912:         THIS.LimparCampos()
913:     ENDPROC
914: 
915:     *--------------------------------------------------------------------------
916:     * HabilitarCampos - Alias CRUD: campos de filtro sao sempre habilitados.
917:     *--------------------------------------------------------------------------
918:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
919:         RETURN
920:     ENDPROC
921: 
922:     *--------------------------------------------------------------------------
923:     * CarregarLista - Alias CRUD: nao aplicavel a formularios de relatorio.
924:     *--------------------------------------------------------------------------
925:     PROCEDURE CarregarLista()
926:         RETURN .T.
927:     ENDPROC
928: 
929:     *--------------------------------------------------------------------------
930:     * AjustarBotoesPorModo - Alias CRUD: botoes de relatorio nao variam por modo.
931:     *--------------------------------------------------------------------------
932:     PROTECTED PROCEDURE AjustarBotoesPorModo()
933:         RETURN
934:     ENDPROC
935: 
936: ENDDEFINE


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

