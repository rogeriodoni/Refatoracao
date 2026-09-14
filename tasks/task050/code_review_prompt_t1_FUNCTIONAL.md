# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (13)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Imprimir' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Operacoes' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Cabecalho' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Operação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Campo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Header1. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreche.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2194 linhas total):

*-- Linhas 35 a 148:
35:     *==========================================================================
36:     * INIT
37:     *==========================================================================
38:     PROCEDURE Init()
39:         RETURN DODEFAULT()
40:     ENDPROC
41: 
42:     *==========================================================================
43:     * INICIALIZARFORM - Cria estrutura do form de relatorio FLAT (sem PageFrame CRUD)
44:     *==========================================================================
45:     PROTECTED PROCEDURE InicializarForm()
46:         LOCAL loc_lSucesso
47:         loc_lSucesso = .F.
48:         TRY
49:             THIS.ConfigurarPageFrame()
50: 
51:             THIS.this_oRelatorio = CREATEOBJECT("sigrecheBO")
52:             IF VARTYPE(THIS.this_oRelatorio) != "O"
53:                 MsgErro("Erro ao criar BO do relat" + CHR(243) + "rio de Cheques", "InicializarForm")
54:             ELSE
55:                 THIS.this_oRelatorio.InicializarCursores()
56: 
57:                 THIS.ConfigurarCabecalho()
58:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
59: 
60:                 THIS.ConfigurarBotoes()
61:                 THIS.ConfigurarPaginaLista()
62: 
63:                 IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
64:                     THIS.this_oRelatorio.CarregarOpcoes()
65:                     THIS.AtualizarTitulosOpcao()
66:                 ENDIF
67: 
68:                 THIS.LimparCampos()
69:                 THIS.AlternarPagina(1)
70: 
71:                 THIS.Visible = .T.
72:                 loc_lSucesso = .T.
73:             ENDIF
74:         CATCH TO loc_oErro
75:             MsgErro(loc_oErro.Message, "InicializarForm")
76:         ENDTRY
77:         RETURN loc_lSucesso
78:     ENDPROC
79: 
80:     *==========================================================================
81:     * CONFIGURARPAGEFRAME - Configura propriedades de janela e moldura do form
82:     *
83:     * REPORT (frmrelatorio) usa layout FLAT: nao ha PageFrame de 2 abas como
84:     * em forms CRUD. Este metodo aplica as propriedades do "frame" da janela
85:     * (Caption, Picture de fundo, Icon, comportamento de janela) e estabelece
86:     * a area util para os containers de cabecalho, filtros e botoes que sao
87:     * adicionados diretamente ao Form em ConfigurarCabecalho/ConfigurarBotoes.
88:     *==========================================================================
89:     PROTECTED PROCEDURE ConfigurarPageFrame()
90:         THIS.Caption     = "Relat" + CHR(243) + "rio de Cheques"
91:         THIS.Picture     = gc_4c_CaminhoIcones + "new_background.jpg"
92:         THIS.Icon        = gc_4c_CaminhoIcones + "icon.ico"
93:         THIS.AutoCenter  = .T.
94:         THIS.BorderStyle = 2
95:         THIS.WindowType  = 1
96:         THIS.ControlBox  = .F.
97:         THIS.MaxButton   = .F.
98:         THIS.MinButton   = .F.
99:         THIS.TitleBar    = 0
100:         THIS.Themes      = .F.
101:         THIS.ShowTips    = .T.
102:         THIS.BackColor   = RGB(255, 255, 255)
103:     ENDPROC
104: 
105:     *==========================================================================
106:     * CONFIGURARCABECALHO - Container escuro com labels titulo/sombra
107:     *==========================================================================
108:     PROTECTED PROCEDURE ConfigurarCabecalho()
109:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
110:         WITH THIS.cnt_4c_Cabecalho
111:             .Top       = 0
112:             .Left      = 0
113:             .Width     = THIS.Width
114:             .Height    = 80
115:             .BackStyle = 1
116:             .BackColor = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible   = .T.
119: 
120:             .AddObject("lbl_4c_Sombra", "Label")
121:             WITH .lbl_4c_Sombra
122:                 .Top       = 15
123:                 .Left      = 12
124:                 .Width     = THIS.Width
125:                 .Height    = 40
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 16
128:                 .FontBold  = .T.
129:                 .BackStyle = 0
130:                 .ForeColor = RGB(0, 0, 0)
131:                 .Caption   = THIS.Parent.Caption
132:                 .Visible   = .T.
133:             ENDWITH
134: 
135:             .AddObject("lbl_4c_Titulo", "Label")
136:             WITH .lbl_4c_Titulo
137:                 .Top       = 18
138:                 .Left      = 10
139:                 .Width     = THIS.Width
140:                 .Height    = 40
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 16
143:                 .FontBold  = .T.
144:                 .BackStyle = 0
145:                 .ForeColor = RGB(255, 255, 255)
146:                 .Caption   = THIS.Parent.Caption
147:                 .Visible   = .T.
148:             ENDWITH

*-- Linhas 155 a 198:
155:     * Posicao: Left=726 (do SCX original), Top=6
156:     * Lefts internos: Btn1=5, Btn2=71, Btn3=137, Btn4=203 (incrementos de 66)
157:     *==========================================================================
158:     PROTECTED PROCEDURE ConfigurarBotoes()
159:         LOCAL loc_cIcones
160:         loc_cIcones = gc_4c_CaminhoIcones
161: 
162:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
163:         WITH THIS.cmg_4c_Botoes
164:             .Top         = 6
165:             .Left        = 726
166:             .Width       = 273
167:             .Height      = 80
168:             .ButtonCount = 4
169:             .BackStyle   = 0
170:             .BorderStyle = 0
171:             .BorderColor = RGB(136, 189, 188)
172:             .SpecialEffect = 1
173:             .Themes      = .F.
174:             .Visible     = .T.
175: 
176:             WITH .Buttons(1)
177:                 .Top             = 5
178:                 .Left            = 5
179:                 .Width           = 65
180:                 .Height          = 70
181:                 .Caption         = "Visualizar"
182:                 .Picture         = loc_cIcones + "ideo.jpg"
183:                 .FontBold        = .T.
184:                 .FontItalic      = .T.
185:                 .BackColor       = RGB(255, 255, 255)
186:                 .ForeColor       = RGB(90, 90, 90)
187:                 .PicturePosition = 13
188:                 .SpecialEffect   = 0
189:                 .MousePointer    = 15
190:                 .Themes          = .F.
191:                 .WordWrap        = .T.
192:             ENDWITH
193: 
194:             WITH .Buttons(2)
195:                 .Top             = 5
196:                 .Left            = 71
197:                 .Width           = 65
198:                 .Height          = 70

*-- Linhas 253 a 361:
253:             ENDWITH
254:         ENDWITH
255: 
256:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
257:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
258:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
259:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnCancelarClick")
260:     ENDPROC
261: 
262:     *==========================================================================
263:     * ATUALIZARESTADOCONTROLES - Override: form de relatorio nao usa CRUD
264:     *==========================================================================
265:     PROCEDURE AtualizarEstadoControles()
266:         RETURN
267:     ENDPROC
268: 
269:     *==========================================================================
270:     * CONFIGURARPAGINALISTA - Monta a "pagina" principal do relatorio (FLAT)
271:     *
272:     * Em forms CRUD esta procedure monta a Page1 (grid de registros + botoes
273:     * Incluir/Alterar/Excluir/Buscar). Em REPORT (frmrelatorio) o layout eh
274:     * FLAT - nao existe PageFrame de 2 abas. A "pagina de lista" do relatorio
275:     * eh a area de filtros + grids de selecao (operacoes/campos a imprimir).
276:     *
277:     * Este wrapper centraliza a montagem dessa area: filtros, grid de operacoes
278:     * e grid de campos a imprimir. Os botoes de acao (Visualizar/Imprimir/
279:     * Excel/Sair) ja foram criados em ConfigurarBotoes() como CommandGroup
280:     * cmg_4c_Botoes (padrao frmrelatorio do framework.vcx).
281:     *==========================================================================
282:     PROTECTED PROCEDURE ConfigurarPaginaLista()
283:         THIS.ConfigurarCamposFiltro()
284:         THIS.ConfigurarPaginaDados()
285:         THIS.ConfigurarGridOperacoes()
286:         THIS.ConfigurarGridImprimir()
287:     ENDPROC
288: 
289:     *==========================================================================
290:     * ALTERNARPAGINA - Controle de pagina (REPORT eh FLAT - 1 pagina logica)
291:     *
292:     * Em forms CRUD esta procedure faz THIS.pgf_4c_Paginas.ActivePage = N para
293:     * alternar entre Page1 (Lista) e Page2 (Dados). Em REPORT (frmrelatorio)
294:     * nao ha PageFrame de 2 abas - o form eh FLAT. Mesmo assim mantemos o
295:     * contrato do metodo e rastreamos a pagina logica em this_nPaginaAtual
296:     * para que codigo externo (ou validacao automatica) possa consultar o
297:     * estado da janela. Em REPORT par_nPagina sempre eh 1.
298:     *==========================================================================
299:     PROCEDURE AlternarPagina(par_nPagina)
300:         LOCAL loc_nPagina
301:         loc_nPagina = IIF(PCOUNT() < 1 OR VARTYPE(par_nPagina) != "N", 1, par_nPagina)
302:         IF loc_nPagina < 1
303:             loc_nPagina = 1
304:         ENDIF
305:         THIS.this_nPaginaAtual = loc_nPagina
306:     ENDPROC
307: 
308:     *==========================================================================
309:     * FORMPARARELATORIO - Transfere valores dos controles do form para o BO
310:     * Usa PEMSTATUS para cada controle (safe em todas as fases de migracao)
311:     *==========================================================================
312:     PROTECTED PROCEDURE FormParaRelatorio()
313:         IF VARTYPE(THIS.this_oRelatorio) != "O"
314:             RETURN
315:         ENDIF
316:         WITH THIS.this_oRelatorio
317:             *-- Tipo de relatorio (OptionGroup)
318:             IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
319:                 .this_nNrTipo = THIS.obj_4c_NrTipo.Value
320:             ENDIF
321:             *-- Opcao com/sem nota (OptionGroup)
322:             IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
323:                 .this_nNrOpcao = THIS.obj_4c_NrOpcao.Value
324:             ENDIF
325:             *-- Ordem de classificacao (ComboBox)
326:             IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
327:                 .this_nOrdem = THIS.cbo_4c_Ordem.Value
328:             ENDIF
329:             *-- Apenas ultima movimentacao (CheckBox - valor numerico 0/1)
330:             IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
331:                 .this_lUltima = (THIS.chk_4c_Ultima.Value = 1)
332:             ENDIF
333:             *-- Periodo
334:             IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
335:                 .this_dDtInicial = THIS.txt_4c_DtInicial.Value
336:             ENDIF
337:             IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
338:                 .this_dDtFinal = THIS.txt_4c_DtFinal.Value
339:             ENDIF
340:             *-- Empresa
341:             IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
342:                 .this_cCdEmpresa = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
343:             ENDIF
344:             IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
345:                 .this_cDsEmpresa = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
346:             ENDIF
347:             *-- Carteira (grupo/conta)
348:             IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
349:                 .this_cCdCarGrupo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
350:             ENDIF
351:             IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
352:                 .this_cDsCarGrupo = ALLTRIM(THIS.txt_4c_DsCarGrupo.Value)
353:             ENDIF
354:             IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
355:                 .this_cCdCarConta = ALLTRIM(THIS.txt_4c_CdCarConta.Value)
356:             ENDIF
357:             IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
358:                 .this_cDsCarConta = ALLTRIM(THIS.txt_4c_DsCarConta.Value)
359:             ENDIF
360:             *-- Deposito (grupo/conta)
361:             IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)

*-- Linhas 389 a 551:
389:     *==========================================================================
390:     * BTNVISUALIZARCLICK - Botao 1: Visualizar relatorio em tela
391:     *==========================================================================
392:     PROCEDURE BtnVisualizarClick()
393:         LOCAL loc_lSucesso
394:         loc_lSucesso = .F.
395:         TRY
396:             THIS.FormParaRelatorio()
397:             loc_lSucesso = THIS.this_oRelatorio.Visualizar()
398:             IF !loc_lSucesso
399:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
400:             ENDIF
401:         CATCH TO loc_oErro
402:             MsgErro(loc_oErro.Message, "BtnVisualizarClick")
403:         ENDTRY
404:     ENDPROC
405: 
406:     *==========================================================================
407:     * BTNIMPRIMIRCLICK - Botao 2: Imprimir relatorio em impressora
408:     *==========================================================================
409:     PROCEDURE BtnImprimirClick()
410:         LOCAL loc_lSucesso
411:         loc_lSucesso = .F.
412:         TRY
413:             THIS.FormParaRelatorio()
414:             loc_lSucesso = THIS.this_oRelatorio.Imprimir()
415:             IF !loc_lSucesso
416:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
417:             ENDIF
418:         CATCH TO loc_oErro
419:             MsgErro(loc_oErro.Message, "BtnImprimirClick")
420:         ENDTRY
421:     ENDPROC
422: 
423:     *==========================================================================
424:     * BTNEXCELCLICK - Botao 3: Exportar para Excel
425:     *==========================================================================
426:     PROCEDURE BtnExcelClick()
427:         LOCAL loc_lSucesso
428:         loc_lSucesso = .F.
429:         TRY
430:             THIS.FormParaRelatorio()
431:             IF !THIS.this_oRelatorio.Validar()
432:                 MsgAviso(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
433:                 RETURN
434:             ENDIF
435:             IF !THIS.this_oRelatorio.PrepararDados()
436:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Excel")
437:                 RETURN
438:             ENDIF
439:             IF USED("cursor_4c_Relatorio")
440:                 LOCAL loc_cArqXls
441:                 loc_cArqXls = SYS(2023) + "\SigReChe_" + STRTRAN(DTOC(DATE()), "/", "") + ".xls"
442:                 COPY TO (loc_cArqXls) TYPE XL5
443:                 MsgInfo("Arquivo Excel gerado em: " + loc_cArqXls, "Excel")
444:                 loc_lSucesso = .T.
445:             ENDIF
446:         CATCH TO loc_oErro
447:             MsgErro(loc_oErro.Message, "BtnExcelClick")
448:         ENDTRY
449:     ENDPROC
450: 
451:     *==========================================================================
452:     * BTNCANCELARCLICK - Botao 4: Fechar o form (ESC)
453:     *==========================================================================
454:     PROCEDURE BtnCancelarClick()
455:         THIS.Release()
456:     ENDPROC
457: 
458:     *==========================================================================
459:     * BTNINCLUIRCLICK - "Gerar novo relatorio" (frmrelatorio: visualizar)
460:     * Em forms REPORT, "Incluir" mapeia para gerar/visualizar o relatorio
461:     * com os filtros atuais. Equivalente funcional ao botao Visualizar.
462:     *==========================================================================
463:     PROCEDURE BtnIncluirClick()
464:         LOCAL loc_lSucesso
465:         loc_lSucesso = .F.
466:         TRY
467:             THIS.FormParaRelatorio()
468:             loc_lSucesso = THIS.this_oRelatorio.Visualizar()
469:             IF !loc_lSucesso
470:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
471:                         "Gerar Relat" + CHR(243) + "rio")
472:             ENDIF
473:         CATCH TO loc_oErro
474:             MsgErro(loc_oErro.Message, "BtnIncluirClick")
475:         ENDTRY
476:     ENDPROC
477: 
478:     *==========================================================================
479:     * BTNALTERARCLICK - "Alterar parametros" (frmrelatorio: reset filtros)
480:     * Em forms REPORT, "Alterar" mapeia para limpar/redefinir os filtros
481:     * do relatorio. Equivalente funcional ao reset de campos.
482:     *==========================================================================
483:     PROCEDURE BtnAlterarClick()
484:         TRY
485:             THIS.LimparCampos()
486:             IF VARTYPE(THIS.txt_4c_DtInicial) = "O"
487:                 THIS.txt_4c_DtInicial.SetFocus()
488:             ENDIF
489:         CATCH TO loc_oErro
490:             MsgErro(loc_oErro.Message, "BtnAlterarClick")
491:         ENDTRY
492:     ENDPROC
493: 
494:     *==========================================================================
495:     * BTNEXCLUIRCLICK - "Cancelar/Encerrar" (frmrelatorio: fechar)
496:     * Em forms REPORT, "Excluir" nao tem sentido CRUD. Pede confirmacao
497:     * e encerra o formulario de relatorio. Equivalente ao botao Encerrar.
498:     *==========================================================================
499:     PROCEDURE BtnExcluirClick()
500:         IF MsgConfirma("Deseja encerrar o relat" + CHR(243) + "rio?", ;
501:                        "Encerrar")
502:             THIS.Release()
503:         ENDIF
504:     ENDPROC
505: 
506:     *==========================================================================
507:     * CONFIGURARCAMPOSFILTRO - Periodo, Empresa, Deposito, Emissor (esq/baixo)
508:     * Controles adicionados DIRETAMENTE ao form (layout FLAT - sem PageFrame)
509:     * Opcao/Situacao/Ordem/Ultima/Carteira: ver ConfigurarPaginaDados()
510:     *==========================================================================
511:     PROTECTED PROCEDURE ConfigurarCamposFiltro()
512: 
513:         *-- == PERIODO ==
514:         THIS.AddObject("lbl_4c_Periodo", "Label")
515:         WITH THIS.lbl_4c_Periodo
516:             .Top       = 113
517:             .Left      = 52
518:             .Width     = 50
519:             .Height    = 18
520:             .Caption   = "Per" + CHR(237) + "odo :"
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .FontBold  = .F.
524:             .BackStyle = 0
525:             .AutoSize  = .F.
526:             .Visible   = .T.
527:         ENDWITH
528: 
529:         THIS.AddObject("txt_4c_DtInicial", "TextBox")
530:         WITH THIS.txt_4c_DtInicial
531:             .Top       = 107
532:             .Left      = 101
533:             .Width     = 80
534:             .Height    = 23
535:             .Value     = DATE()
536:             .InputMask = "99/99/9999"
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .Visible   = .T.
540:         ENDWITH
541: 
542:         THIS.AddObject("lbl_4c_PeriodoA", "Label")
543:         WITH THIS.lbl_4c_PeriodoA
544:             .Top       = 112
545:             .Left      = 186
546:             .Width     = 10
547:             .Height    = 18
548:             .Caption   = "a"
549:             .FontName  = "Tahoma"
550:             .FontSize  = 8
551:             .BackStyle = 0

*-- Linhas 762 a 841:
762:         ENDWITH
763: 
764:         *-- Vincular KeyPress handlers periodo/empresa/deposito/emissor
765:         BINDEVENT(THIS.txt_4c_DtInicial,  "KeyPress", THIS, "TeclaDtInicial")
766:         BINDEVENT(THIS.txt_4c_DtFinal,    "KeyPress", THIS, "TeclaDtFinal")
767:         BINDEVENT(THIS.txt_4c_CdEmpresa,  "KeyPress", THIS, "TeclaCdEmpresa")
768:         BINDEVENT(THIS.txt_4c_DsEmpresa,  "KeyPress", THIS, "TeclaDsEmpresa")
769:         BINDEVENT(THIS.txt_4c_CdDepGrupo, "KeyPress", THIS, "TeclaCdDepGrupo")
770:         BINDEVENT(THIS.txt_4c_DsDepGrupo, "KeyPress", THIS, "TeclaDsDepGrupo")
771:         BINDEVENT(THIS.txt_4c_CdDepConta, "KeyPress", THIS, "TeclaCdDepConta")
772:         BINDEVENT(THIS.txt_4c_DsDepConta, "KeyPress", THIS, "TeclaDsDepConta")
773:         BINDEVENT(THIS.txt_4c_CdEmiGrupo, "KeyPress", THIS, "TeclaCdEmiGrupo")
774:         BINDEVENT(THIS.txt_4c_DsEmiGrupo, "KeyPress", THIS, "TeclaDsEmiGrupo")
775:         BINDEVENT(THIS.txt_4c_CdEmiConta, "KeyPress", THIS, "TeclaCdEmiConta")
776:         BINDEVENT(THIS.txt_4c_DsEmiConta, "KeyPress", THIS, "TeclaDsEmiConta")
777:     ENDPROC
778: 
779:     *==========================================================================
780:     * CONFIGURARPAGINADADADOS - Controles filtro DIREITA Parte 1 (Fase 5/8)
781:     * Opcao (com/sem nota), Situacao/Tipo, Ordem, Ultima Mov, Carteira Grupo/Conta
782:     * Posicoes EXATAS do layout.json (PILAR 1 - pixel-perfect)
783:     *==========================================================================
784:     PROTECTED PROCEDURE ConfigurarPaginaDados()
785: 
786:         *-- == OPCAO (OptionGroup - com/sem nota fiscal) ==
787:         THIS.AddObject("lbl_4c_LblOpcao", "Label")
788:         WITH THIS.lbl_4c_LblOpcao
789:             .Top       = 121
790:             .Left      = 495
791:             .Width     = 44
792:             .Height    = 18
793:             .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
794:             .FontName  = "Tahoma"
795:             .FontSize  = 8
796:             .BackStyle = 0
797:             .AutoSize  = .F.
798:             .Visible   = .T.
799:         ENDWITH
800: 
801:         THIS.AddObject("obj_4c_NrOpcao", "OptionGroup")
802:         WITH THIS.obj_4c_NrOpcao
803:             .Top         = 117
804:             .Left        = 540
805:             .Width       = 182
806:             .Height      = 23
807:             .ButtonCount = 3
808:             .BackStyle   = 0
809:             .BorderStyle = 0
810:             .Themes      = .F.
811:             .Value       = 3
812:             .Visible     = .T.
813:             WITH .Buttons(1)
814:                 .Caption = "Sim"
815:                 .Left    = 0
816:                 .Top     = 3
817:                 .Width   = 60
818:                 .Height  = 17
819:                 .Visible = .T.
820:             ENDWITH
821:             WITH .Buttons(2)
822:                 .Caption  = "N" + CHR(227) + "o"
823:                 .Left     = 61
824:                 .Top      = 3
825:                 .Width    = 60
826:                 .Height   = 17
827:                 .FontName = "Tahoma"
828:                 .FontSize = 8
829:                 .Visible  = .T.
830:             ENDWITH
831:             WITH .Buttons(3)
832:                 .Caption  = "Ambos"
833:                 .Left     = 122
834:                 .Top      = 3
835:                 .Width    = 60
836:                 .Height   = 17
837:                 .FontName = "Tahoma"
838:                 .FontSize = 8
839:                 .Visible  = .T.
840:             ENDWITH
841:         ENDWITH

*-- Linhas 855 a 898:
855:             .Visible   = .T.
856:         ENDWITH
857: 
858:         THIS.AddObject("obj_4c_NrTipo", "OptionGroup")
859:         WITH THIS.obj_4c_NrTipo
860:             .Top         = 143
861:             .Left        = 541
862:             .Width       = 213
863:             .Height      = 26
864:             .ButtonCount = 4
865:             .BackStyle   = 0
866:             .BorderStyle = 0
867:             .Themes      = .F.
868:             .Value       = 2
869:             .Visible     = .T.
870:             WITH .Buttons(1)
871:                 .Caption = "Abertos"
872:                 .Left    = 0
873:                 .Top     = 5
874:                 .Width   = 51
875:                 .Height  = 17
876:                 .Visible = .T.
877:             ENDWITH
878:             WITH .Buttons(2)
879:                 .Caption  = "Geral"
880:                 .Left     = 52
881:                 .Top      = 5
882:                 .Width    = 51
883:                 .Height   = 17
884:                 .FontName = "Tahoma"
885:                 .FontSize = 8
886:                 .Visible  = .T.
887:             ENDWITH
888:             WITH .Buttons(3)
889:                 .Caption  = "Dt Opera" + CHR(231) + CHR(227) + "o"
890:                 .Left     = 104
891:                 .Top      = 5
892:                 .Width    = 55
893:                 .Height   = 17
894:                 .FontName = "Tahoma"
895:                 .FontSize = 8
896:                 .Visible  = .T.
897:             ENDWITH
898:             WITH .Buttons(4)

*-- Linhas 1033 a 1235:
1033:         ENDWITH
1034: 
1035:         *-- Vincular KeyPress handlers para carteira (F4=115, ENTER=13, TAB=9)
1036:         BINDEVENT(THIS.txt_4c_CdCarGrupo, "KeyPress", THIS, "TeclaCdCarGrupo")
1037:         BINDEVENT(THIS.txt_4c_DsCarGrupo, "KeyPress", THIS, "TeclaDsCarGrupo")
1038:         BINDEVENT(THIS.txt_4c_CdCarConta, "KeyPress", THIS, "TeclaCdCarConta")
1039:         BINDEVENT(THIS.txt_4c_DsCarConta, "KeyPress", THIS, "TeclaDsCarConta")
1040:     ENDPROC
1041: 
1042:     *==========================================================================
1043:     * CONFIGURARGRIDOPERACOES - Grid de selecao de operacoes (3 colunas)
1044:     * Cursor: cursor_4c_Operacoes (Marcas L, Operacaos C15, Tipos C2)
1045:     * Original: grdOperacaos Top=158, Left=101, Width=188, Height=147
1046:     *==========================================================================
1047:     PROTECTED PROCEDURE ConfigurarGridOperacoes()
1048:         LOCAL loc_oGrid, loc_oCol
1049: 
1050:         THIS.AddObject("lbl_4c_Operacao", "Label")
1051:         WITH THIS.lbl_4c_Operacao
1052:             .Top       = 160
1053:             .Left      = 41
1054:             .Width     = 57
1055:             .Height    = 18
1056:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
1057:             .FontName  = "Tahoma"
1058:             .FontSize  = 8
1059:             .BackStyle = 0
1060:             .AutoSize  = .F.
1061:             .Visible   = .T.
1062:         ENDWITH
1063: 
1064:         THIS.AddObject("grd_4c_Operacoes", "Grid")
1065:         WITH THIS.grd_4c_Operacoes
1066:             .Top          = 158
1067:             .Left         = 101
1068:             .Width        = 188
1069:             .Height       = 147
1070:             .ColumnCount  = 3
1071:             .RecordSource = "cursor_4c_Operacoes"
1072:             .RecordMark   = .F.
1073:             .DeleteMark   = .F.
1074:             .ScrollBars   = 2
1075:             .RowHeight    = 18
1076:             .FontName     = "Verdana"
1077:             .FontSize     = 8
1078:             .ForeColor    = RGB(90, 90, 90)
1079:             .BackColor    = RGB(255, 255, 255)
1080:             .GridLineColor = RGB(238, 238, 238)
1081:             .HighlightStyle = 2
1082:             .Visible      = .T.
1083: 
1084:             *-- Coluna 1: CheckBox para marcar operacao (LOGICAL)
1085:             WITH .Column1
1086:                 .Width   = 22
1087:                 .Resizable = .F.
1088:                 .AddObject("Check1", "CheckBox")
1089:                 WITH .Check1
1090:                     .Caption  = ""
1091:                     .Value    = 0
1092:                     .Visible  = .T.
1093:                 ENDWITH
1094:                 .CurrentControl  = "Check1"
1095:                 .ControlSource   = "cursor_4c_Operacoes.Marcas"
1096:                 .Header1.Caption = ""
1097:             ENDWITH
1098: 
1099:             *-- Coluna 2: Descricao da operacao
1100:             WITH .Column2
1101:                 .Width          = 96
1102:                 .ControlSource  = "cursor_4c_Operacoes.Operacaos"
1103:                 .ReadOnly       = .T.
1104:                 .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1105:             ENDWITH
1106: 
1107:             *-- Coluna 3: Tipo da operacao
1108:             WITH .Column3
1109:                 .Width          = 40
1110:                 .ControlSource  = "cursor_4c_Operacoes.Tipos"
1111:                 .ReadOnly       = .T.
1112:                 .Header1.Caption = "Tipo"
1113:             ENDWITH
1114:         ENDWITH
1115: 
1116:         loc_oGrid = THIS.grd_4c_Operacoes
1117:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckOperacoes")
1118:         BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckOperacoes")
1119:     ENDPROC
1120: 
1121:     *==========================================================================
1122:     * CONFIGURARGRIDIMPRIMIR - Grid de selecao de campos de impressao (2 colunas)
1123:     * Cursor: cursor_4c_Imprimir (Marcas L, Campos C20)
1124:     * Original: grdImprimir Top=311, Left=101, Width=188, Height=58
1125:     *==========================================================================
1126:     PROTECTED PROCEDURE ConfigurarGridImprimir()
1127:         LOCAL loc_oGrid
1128: 
1129:         THIS.AddObject("lbl_4c_Campos", "Label")
1130:         WITH THIS.lbl_4c_Campos
1131:             .Top       = 311
1132:             .Left      = 50
1133:             .Width     = 50
1134:             .Height    = 18
1135:             .Caption   = "Campos :"
1136:             .FontName  = "Tahoma"
1137:             .FontSize  = 8
1138:             .BackStyle = 0
1139:             .AutoSize  = .F.
1140:             .Visible   = .T.
1141:         ENDWITH
1142: 
1143:         THIS.AddObject("grd_4c_Imprimir", "Grid")
1144:         WITH THIS.grd_4c_Imprimir
1145:             .Top          = 311
1146:             .Left         = 101
1147:             .Width        = 188
1148:             .Height       = 58
1149:             .ColumnCount  = 2
1150:             .RecordSource = "cursor_4c_Imprimir"
1151:             .RecordMark   = .F.
1152:             .DeleteMark   = .F.
1153:             .ScrollBars   = 2
1154:             .RowHeight    = 18
1155:             .FontName     = "Verdana"
1156:             .FontSize     = 8
1157:             .ForeColor    = RGB(90, 90, 90)
1158:             .BackColor    = RGB(255, 255, 255)
1159:             .GridLineColor = RGB(238, 238, 238)
1160:             .HighlightStyle = 2
1161:             .Visible      = .T.
1162: 
1163:             *-- Coluna 1: CheckBox para marcar campo (LOGICAL)
1164:             WITH .Column1
1165:                 .Width   = 22
1166:                 .Resizable = .F.
1167:                 .AddObject("Check1", "CheckBox")
1168:                 WITH .Check1
1169:                     .Caption  = ""
1170:                     .Value    = 0
1171:                     .Visible  = .T.
1172:                 ENDWITH
1173:                 .CurrentControl  = "Check1"
1174:                 .ControlSource   = "cursor_4c_Imprimir.Marcas"
1175:                 .Header1.Caption = ""
1176:             ENDWITH
1177: 
1178:             *-- Coluna 2: Nome do campo de impressao
1179:             WITH .Column2
1180:                 .Width           = 146
1181:                 .ControlSource   = "cursor_4c_Imprimir.Campos"
1182:                 .ReadOnly        = .T.
1183:                 .Header1.Caption = "Campo"
1184:             ENDWITH
1185:         ENDWITH
1186: 
1187:         loc_oGrid = THIS.grd_4c_Imprimir
1188:         BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress", THIS, "TeclaCheckImprimir")
1189:         BINDEVENT(loc_oGrid.Column1.Check1, "Click",    THIS, "CliqueCheckImprimir")
1190:     ENDPROC
1191: 
1192:     *==========================================================================
1193:     * LIMPARCAMPOS - Restaura campos de filtro para valores padrao
1194:     *==========================================================================
1195:     PROCEDURE LimparCampos()
1196:         IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
1197:             THIS.txt_4c_DtInicial.Value = DATE()
1198:         ENDIF
1199:         IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
1200:             THIS.txt_4c_DtFinal.Value = DATE()
1201:         ENDIF
1202:         IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
1203:             THIS.txt_4c_CdEmpresa.Value = ""
1204:         ENDIF
1205:         IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
1206:             THIS.txt_4c_DsEmpresa.Value = ""
1207:         ENDIF
1208:         IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
1209:             THIS.txt_4c_CdCarGrupo.Value = ""
1210:         ENDIF
1211:         IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
1212:             THIS.txt_4c_DsCarGrupo.Value = ""
1213:         ENDIF
1214:         IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
1215:             THIS.txt_4c_CdCarConta.Value = ""
1216:         ENDIF
1217:         IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
1218:             THIS.txt_4c_DsCarConta.Value = ""
1219:         ENDIF
1220:         IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
1221:             THIS.txt_4c_CdDepGrupo.Value = ""
1222:         ENDIF
1223:         IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
1224:             THIS.txt_4c_DsDepGrupo.Value = ""
1225:         ENDIF
1226:         IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
1227:             THIS.txt_4c_CdDepConta.Value = ""
1228:         ENDIF
1229:         IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
1230:             THIS.txt_4c_DsDepConta.Value = ""
1231:         ENDIF
1232:         IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)
1233:             THIS.txt_4c_CdEmiGrupo.Value = ""
1234:         ENDIF
1235:         IF PEMSTATUS(THIS, "txt_4c_DsEmiGrupo", 5)

*-- Linhas 1256 a 2041:
1256:     ENDPROC
1257: 
1258:     *==========================================================================
1259:     * ATUALIZARTITULOSOPCAO - Aplica titulos dinamicos do SigCdPac ao OptionGroup
1260:     * Chamado apos CarregarOpcoes() quando ha conexao disponivel
1261:     *==========================================================================
1262:     PROCEDURE AtualizarTitulosOpcao()
1263:         IF VARTYPE(THIS.this_oRelatorio) != "O"
1264:             RETURN
1265:         ENDIF
1266:         IF !PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
1267:             RETURN
1268:         ENDIF
1269:         WITH THIS.obj_4c_NrOpcao
1270:             .Buttons(1).Caption = THIS.this_oRelatorio.this_cTituloOpcao1
1271:             .Buttons(2).Caption = THIS.this_oRelatorio.this_cTituloOpcao2
1272:             .Buttons(3).Caption = THIS.this_oRelatorio.this_cTituloOpcao3
1273:         ENDWITH
1274:     ENDPROC
1275: 
1276:     *==========================================================================
1277:     * HANDLERS DE TECLA - KeyPress para campos de filtro (F4=115, ENTER=13, TAB=9)
1278:     * Campos de data nao tem lookup - handlers vazios conforme padrao
1279:     *==========================================================================
1280:     PROCEDURE TeclaDtInicial(par_nKeyCode, par_nShift)
1281:     ENDPROC
1282: 
1283:     PROCEDURE TeclaDtFinal(par_nKeyCode, par_nShift)
1284:     ENDPROC
1285: 
1286:     PROCEDURE TeclaCdEmpresa(par_nKeyCode, par_nShift)
1287:         IF par_nKeyCode = 115
1288:             THIS.AbrirBuscaEmpresa()
1289:         ENDIF
1290:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1291:             THIS.ValidarCdEmpresa()
1292:         ENDIF
1293:     ENDPROC
1294: 
1295:     PROCEDURE TeclaDsEmpresa(par_nKeyCode, par_nShift)
1296:         IF par_nKeyCode = 115
1297:             THIS.AbrirBuscaEmpresa()
1298:         ENDIF
1299:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1300:             THIS.ValidarDsEmpresa()
1301:         ENDIF
1302:     ENDPROC
1303: 
1304:     PROCEDURE TeclaCdCarGrupo(par_nKeyCode, par_nShift)
1305:         IF par_nKeyCode = 115
1306:             THIS.AbrirBuscaCarGrupo()
1307:         ENDIF
1308:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1309:             THIS.ValidarCdCarGrupo()
1310:         ENDIF
1311:     ENDPROC
1312: 
1313:     PROCEDURE TeclaDsCarGrupo(par_nKeyCode, par_nShift)
1314:         IF par_nKeyCode = 115
1315:             THIS.AbrirBuscaCarGrupo()
1316:         ENDIF
1317:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1318:             THIS.ValidarDsCarGrupo()
1319:         ENDIF
1320:     ENDPROC
1321: 
1322:     PROCEDURE TeclaCdCarConta(par_nKeyCode, par_nShift)
1323:         IF par_nKeyCode = 115
1324:             THIS.AbrirBuscaCarConta()
1325:         ENDIF
1326:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1327:             THIS.ValidarCdCarConta()
1328:         ENDIF
1329:     ENDPROC
1330: 
1331:     PROCEDURE TeclaDsCarConta(par_nKeyCode, par_nShift)
1332:         IF par_nKeyCode = 115
1333:             THIS.AbrirBuscaCarConta()
1334:         ENDIF
1335:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1336:             THIS.ValidarDsCarConta()
1337:         ENDIF
1338:     ENDPROC
1339: 
1340:     PROCEDURE TeclaCdDepGrupo(par_nKeyCode, par_nShift)
1341:         IF par_nKeyCode = 115
1342:             THIS.AbrirBuscaDepGrupo()
1343:         ENDIF
1344:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1345:             THIS.ValidarCdDepGrupo()
1346:         ENDIF
1347:     ENDPROC
1348: 
1349:     PROCEDURE TeclaDsDepGrupo(par_nKeyCode, par_nShift)
1350:         IF par_nKeyCode = 115
1351:             THIS.AbrirBuscaDepGrupo()
1352:         ENDIF
1353:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1354:             THIS.ValidarDsDepGrupo()
1355:         ENDIF
1356:     ENDPROC
1357: 
1358:     PROCEDURE TeclaCdDepConta(par_nKeyCode, par_nShift)
1359:         IF par_nKeyCode = 115
1360:             THIS.AbrirBuscaDepConta()
1361:         ENDIF
1362:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1363:             THIS.ValidarCdDepConta()
1364:         ENDIF
1365:     ENDPROC
1366: 
1367:     PROCEDURE TeclaDsDepConta(par_nKeyCode, par_nShift)
1368:         IF par_nKeyCode = 115
1369:             THIS.AbrirBuscaDepConta()
1370:         ENDIF
1371:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1372:             THIS.ValidarDsDepConta()
1373:         ENDIF
1374:     ENDPROC
1375: 
1376:     PROCEDURE TeclaCdEmiGrupo(par_nKeyCode, par_nShift)
1377:         IF par_nKeyCode = 115
1378:             THIS.AbrirBuscaEmiGrupo()
1379:         ENDIF
1380:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1381:             THIS.ValidarCdEmiGrupo()
1382:         ENDIF
1383:     ENDPROC
1384: 
1385:     PROCEDURE TeclaDsEmiGrupo(par_nKeyCode, par_nShift)
1386:         IF par_nKeyCode = 115
1387:             THIS.AbrirBuscaEmiGrupo()
1388:         ENDIF
1389:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1390:             THIS.ValidarDsEmiGrupo()
1391:         ENDIF
1392:     ENDPROC
1393: 
1394:     PROCEDURE TeclaCdEmiConta(par_nKeyCode, par_nShift)
1395:         IF par_nKeyCode = 115
1396:             THIS.AbrirBuscaEmiConta()
1397:         ENDIF
1398:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1399:             THIS.ValidarCdEmiConta()
1400:         ENDIF
1401:     ENDPROC
1402: 
1403:     PROCEDURE TeclaDsEmiConta(par_nKeyCode, par_nShift)
1404:         IF par_nKeyCode = 115
1405:             THIS.AbrirBuscaEmiConta()
1406:         ENDIF
1407:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1408:             THIS.ValidarDsEmiConta()
1409:         ENDIF
1410:     ENDPROC
1411: 
1412:     *==========================================================================
1413:     * TECLACHECK* - Toggle de checkbox nos grids via teclado (ENTER=13 / SPACE=32)
1414:     *==========================================================================
1415:     PROCEDURE TeclaCheckOperacoes(par_nKeyCode, par_nShift)
1416:         IF par_nKeyCode = 13 OR par_nKeyCode = 32
1417:             IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
1418:                 SELECT cursor_4c_Operacoes
1419:                 REPLACE Marcas WITH !Marcas
1420:                 THIS.grd_4c_Operacoes.Refresh()
1421:             ENDIF
1422:         ENDIF
1423:         IF par_nKeyCode = 9
1424:             IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
1425:                 THIS.obj_4c_NrTipo.Buttons(1).SetFocus()
1426:             ENDIF
1427:         ENDIF
1428:     ENDPROC
1429: 
1430:     PROCEDURE TeclaCheckImprimir(par_nKeyCode, par_nShift)
1431:         IF par_nKeyCode = 13 OR par_nKeyCode = 32
1432:             IF USED("cursor_4c_Imprimir") AND !EOF("cursor_4c_Imprimir")
1433:                 SELECT cursor_4c_Imprimir
1434:                 REPLACE Marcas WITH !Marcas
1435:                 THIS.grd_4c_Imprimir.Refresh()
1436:             ENDIF
1437:         ENDIF
1438:         IF par_nKeyCode = 9
1439:             IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
1440:                 THIS.cbo_4c_Ordem.SetFocus()
1441:             ENDIF
1442:         ENDIF
1443:     ENDPROC
1444: 
1445:     *==========================================================================
1446:     * CLIQUECHECKOPERACOES - Refresh do grid apos toggle por clique de mouse
1447:     * O ControlSource atualiza Marcas automaticamente; apenas sincroniza display
1448:     *==========================================================================
1449:     PROCEDURE CliqueCheckOperacoes()
1450:         IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
1451:             THIS.grd_4c_Operacoes.Refresh()
1452:         ENDIF
1453:     ENDPROC
1454: 
1455:     *==========================================================================
1456:     * CLIQUECHECKIMPRIMIR - Refresh do grid apos toggle por clique de mouse
1457:     *==========================================================================
1458:     PROCEDURE CliqueCheckImprimir()
1459:         IF PEMSTATUS(THIS, "grd_4c_Imprimir", 5)
1460:             THIS.grd_4c_Imprimir.Refresh()
1461:         ENDIF
1462:     ENDPROC
1463: 
1464:     *==========================================================================
1465:     * VALIDACAO E LOOKUP - EMPRESA
1466:     * Tabela: SigCdEmp, Codigo: cEmps, Descricao: Razas
1467:     *==========================================================================
1468:     PROCEDURE ValidarCdEmpresa()
1469:         LOCAL loc_cCodigo, loc_cSQL, loc_nResult
1470:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmpresa.Value)
1471:         IF EMPTY(loc_cCodigo)
1472:             THIS.txt_4c_DsEmpresa.Value = ""
1473:             RETURN
1474:         ENDIF
1475:         loc_cSQL    = "SELECT cEmps, Razas FROM SigCdEmp WHERE cEmps = " + EscaparSQL(loc_cCodigo)
1476:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpVal")
1477:         IF loc_nResult > 0 AND USED("cursor_4c_EmpVal")
1478:             SELECT cursor_4c_EmpVal
1479:             IF !EOF()
1480:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(Razas)
1481:             ELSE
1482:                 THIS.txt_4c_CdEmpresa.Value = ""
1483:                 THIS.txt_4c_DsEmpresa.Value = ""
1484:                 THIS.AbrirBuscaEmpresa()
1485:             ENDIF
1486:             USE IN cursor_4c_EmpVal
1487:         ENDIF
1488:     ENDPROC
1489: 
1490:     PROCEDURE ValidarDsEmpresa()
1491:         LOCAL loc_cNome
1492:         loc_cNome = ALLTRIM(THIS.txt_4c_DsEmpresa.Value)
1493:         IF EMPTY(loc_cNome)
1494:             THIS.txt_4c_CdEmpresa.Value = ""
1495:             RETURN
1496:         ENDIF
1497:         THIS.AbrirBuscaEmpresa()
1498:     ENDPROC
1499: 
1500:     PROCEDURE AbrirBuscaEmpresa()
1501:         LOCAL loLookup, loc_lSucesso
1502:         loc_lSucesso = .F.
1503:         TRY
1504:             loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1505:             IF VARTYPE(loLookup) = "O"
1506:                 loLookup.ConfigurarBusca("SigCdEmp", "cEmps", "Razas", ;
1507:                     "Empresa", ALLTRIM(THIS.txt_4c_CdEmpresa.Value))
1508:                 loLookup.Show()
1509:                 IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1510:                     THIS.txt_4c_CdEmpresa.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1511:                     THIS.txt_4c_DsEmpresa.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1512:                 ENDIF
1513:                 loLookup = .NULL.
1514:                 loc_lSucesso = .T.
1515:             ENDIF
1516:         CATCH TO loc_oErro
1517:             MsgErro(loc_oErro.Message, "AbrirBuscaEmpresa")
1518:         ENDTRY
1519:         RETURN loc_lSucesso
1520:     ENDPROC
1521: 
1522:     *==========================================================================
1523:     * VALIDACAO E LOOKUP - CARTEIRA GRUPO
1524:     * Grupo de carteira (fAcessoContab no legado)
1525:     *==========================================================================
1526:     PROCEDURE ValidarCdCarGrupo()
1527:         LOCAL loc_cCodigo, loc_cSQL, loc_nResult
1528:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
1529:         IF EMPTY(loc_cCodigo)
1530:             THIS.txt_4c_DsCarGrupo.Value = ""
1531:             THIS.txt_4c_CdCarConta.Value = ""
1532:             THIS.txt_4c_DsCarConta.Value = ""
1533:             RETURN
1534:         ENDIF
1535:         loc_cSQL    = "SELECT DISTINCT GruCarts AS Codigo, GruCarts AS Descricao " + ;
1536:                       "FROM SigCqChm WHERE GruCarts = " + EscaparSQL(loc_cCodigo)
1537:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoVal")
1538:         IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoVal")
1539:             SELECT cursor_4c_CarGrupoVal
1540:             IF !EOF()
1541:                 THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(Codigo)
1542:             ELSE
1543:                 THIS.txt_4c_CdCarGrupo.Value = ""
1544:                 THIS.txt_4c_DsCarGrupo.Value = ""
1545:                 THIS.txt_4c_CdCarConta.Value = ""
1546:                 THIS.txt_4c_DsCarConta.Value = ""
1547:             ENDIF
1548:             USE IN cursor_4c_CarGrupoVal
1549:         ENDIF
1550:     ENDPROC
1551: 
1552:     PROCEDURE ValidarDsCarGrupo()
1553:         LOCAL loc_cDescricao
1554:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarGrupo.Value)
1555:         IF EMPTY(loc_cDescricao)
1556:             THIS.txt_4c_CdCarGrupo.Value = ""
1557:             THIS.txt_4c_CdCarConta.Value = ""
1558:             THIS.txt_4c_DsCarConta.Value = ""
1559:             RETURN
1560:         ENDIF
1561:         THIS.AbrirBuscaCarGrupo()
1562:     ENDPROC
1563: 
1564:     PROCEDURE AbrirBuscaCarGrupo()
1565:         LOCAL loLookup, loc_cSQL, loc_nResult
1566:         TRY
1567:             loc_cSQL = "SELECT DISTINCT GruCarts AS codigo, GruCarts AS descricao " + ;
1568:                        "FROM SigCqChm ORDER BY GruCarts"
1569:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarGrupoLst")
1570:             IF loc_nResult > 0 AND USED("cursor_4c_CarGrupoLst")
1571:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1572:                 IF VARTYPE(loLookup) = "O"
1573:                     loLookup.ConfigurarBuscaCursor("cursor_4c_CarGrupoLst", ;
1574:                         "codigo", "descricao", "Grupo Carteira", ;
1575:                         ALLTRIM(THIS.txt_4c_CdCarGrupo.Value))
1576:                     loLookup.Show()
1577:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1578:                         THIS.txt_4c_CdCarGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1579:                         THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1580:                         THIS.txt_4c_CdCarConta.Value = ""
1581:                         THIS.txt_4c_DsCarConta.Value = ""
1582:                     ENDIF
1583:                     loLookup = .NULL.
1584:                 ENDIF
1585:                 USE IN cursor_4c_CarGrupoLst
1586:             ENDIF
1587:         CATCH TO loc_oErro
1588:             MsgErro(loc_oErro.Message, "AbrirBuscaCarGrupo")
1589:         ENDTRY
1590:     ENDPROC
1591: 
1592:     *==========================================================================
1593:     * VALIDACAO E LOOKUP - CARTEIRA CONTA
1594:     * Conta dentro do grupo de carteira selecionado
1595:     *==========================================================================
1596:     PROCEDURE ValidarCdCarConta()
1597:         LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
1598:         loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
1599:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdCarConta.Value)
1600:         IF EMPTY(loc_cCodigo)
1601:             THIS.txt_4c_DsCarConta.Value = ""
1602:             RETURN
1603:         ENDIF
1604:         loc_cSQL = "SELECT DISTINCT ConCarts AS Codigo, Iclis AS Descricao " + ;
1605:                    "FROM SigCqChm WHERE ConCarts = " + EscaparSQL(loc_cCodigo)
1606:         IF !EMPTY(loc_cGrupo)
1607:             loc_cSQL = loc_cSQL + " AND GruCarts = " + EscaparSQL(loc_cGrupo)
1608:         ENDIF
1609:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaVal")
1610:         IF loc_nResult > 0 AND USED("cursor_4c_CarContaVal")
1611:             SELECT cursor_4c_CarContaVal
1612:             IF !EOF()
1613:                 THIS.txt_4c_DsCarConta.Value = ALLTRIM(Codigo)
1614:             ELSE
1615:                 MsgAviso("Acesso Negado!!", "Carteira")
1616:                 THIS.txt_4c_CdCarConta.Value = ""
1617:                 THIS.txt_4c_DsCarConta.Value = ""
1618:             ENDIF
1619:             USE IN cursor_4c_CarContaVal
1620:         ENDIF
1621:     ENDPROC
1622: 
1623:     PROCEDURE ValidarDsCarConta()
1624:         LOCAL loc_cDescricao
1625:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsCarConta.Value)
1626:         IF EMPTY(loc_cDescricao)
1627:             THIS.txt_4c_CdCarConta.Value = ""
1628:             RETURN
1629:         ENDIF
1630:         THIS.AbrirBuscaCarConta()
1631:     ENDPROC
1632: 
1633:     PROCEDURE AbrirBuscaCarConta()
1634:         LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
1635:         TRY
1636:             loc_cGrupo = ALLTRIM(THIS.txt_4c_CdCarGrupo.Value)
1637:             loc_cSQL   = "SELECT DISTINCT ConCarts AS codigo, ConCarts AS descricao " + ;
1638:                          "FROM SigCqChm"
1639:             IF !EMPTY(loc_cGrupo)
1640:                 loc_cSQL = loc_cSQL + " WHERE GruCarts = " + EscaparSQL(loc_cGrupo)
1641:             ENDIF
1642:             loc_cSQL = loc_cSQL + " ORDER BY ConCarts"
1643:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CarContaLst")
1644:             IF loc_nResult > 0 AND USED("cursor_4c_CarContaLst")
1645:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1646:                 IF VARTYPE(loLookup) = "O"
1647:                     loLookup.ConfigurarBuscaCursor("cursor_4c_CarContaLst", ;
1648:                         "codigo", "descricao", "Conta Carteira", ;
1649:                         ALLTRIM(THIS.txt_4c_CdCarConta.Value))
1650:                     loLookup.Show()
1651:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1652:                         THIS.txt_4c_CdCarConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1653:                         THIS.txt_4c_DsCarConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1654:                     ENDIF
1655:                     loLookup = .NULL.
1656:                 ENDIF
1657:                 USE IN cursor_4c_CarContaLst
1658:             ENDIF
1659:         CATCH TO loc_oErro
1660:             MsgErro(loc_oErro.Message, "AbrirBuscaCarConta")
1661:         ENDTRY
1662:     ENDPROC
1663: 
1664:     *==========================================================================
1665:     * VALIDACAO E LOOKUP - DEPOSITO GRUPO
1666:     *==========================================================================
1667:     PROCEDURE ValidarCdDepGrupo()
1668:         LOCAL loc_cCodigo, loc_cSQL, loc_nResult
1669:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
1670:         IF EMPTY(loc_cCodigo)
1671:             THIS.txt_4c_DsDepGrupo.Value = ""
1672:             THIS.txt_4c_CdDepConta.Value = ""
1673:             THIS.txt_4c_DsDepConta.Value = ""
1674:             RETURN
1675:         ENDIF
1676:         loc_cSQL    = "SELECT DISTINCT Grupos AS Codigo, Grupos AS Descricao " + ;
1677:                       "FROM SigCqChm WHERE Grupos = " + EscaparSQL(loc_cCodigo)
1678:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoVal")
1679:         IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoVal")
1680:             SELECT cursor_4c_DepGrupoVal
1681:             IF !EOF()
1682:                 THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(Codigo)
1683:             ELSE
1684:                 THIS.txt_4c_CdDepGrupo.Value = ""
1685:                 THIS.txt_4c_DsDepGrupo.Value = ""
1686:                 THIS.txt_4c_CdDepConta.Value = ""
1687:                 THIS.txt_4c_DsDepConta.Value = ""
1688:             ENDIF
1689:             USE IN cursor_4c_DepGrupoVal
1690:         ENDIF
1691:     ENDPROC
1692: 
1693:     PROCEDURE ValidarDsDepGrupo()
1694:         LOCAL loc_cDescricao
1695:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepGrupo.Value)
1696:         IF EMPTY(loc_cDescricao)
1697:             THIS.txt_4c_CdDepGrupo.Value = ""
1698:             THIS.txt_4c_CdDepConta.Value = ""
1699:             THIS.txt_4c_DsDepConta.Value = ""
1700:             RETURN
1701:         ENDIF
1702:         THIS.AbrirBuscaDepGrupo()
1703:     ENDPROC
1704: 
1705:     PROCEDURE AbrirBuscaDepGrupo()
1706:         LOCAL loLookup, loc_cSQL, loc_nResult
1707:         TRY
1708:             loc_cSQL    = "SELECT DISTINCT Grupos AS codigo, Grupos AS descricao " + ;
1709:                           "FROM SigCqChm ORDER BY Grupos"
1710:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepGrupoLst")
1711:             IF loc_nResult > 0 AND USED("cursor_4c_DepGrupoLst")
1712:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1713:                 IF VARTYPE(loLookup) = "O"
1714:                     loLookup.ConfigurarBuscaCursor("cursor_4c_DepGrupoLst", ;
1715:                         "codigo", "descricao", "Grupo Dep" + CHR(243) + "sito", ;
1716:                         ALLTRIM(THIS.txt_4c_CdDepGrupo.Value))
1717:                     loLookup.Show()
1718:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1719:                         THIS.txt_4c_CdDepGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1720:                         THIS.txt_4c_DsDepGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1721:                         THIS.txt_4c_CdDepConta.Value = ""
1722:                         THIS.txt_4c_DsDepConta.Value = ""
1723:                     ENDIF
1724:                     loLookup = .NULL.
1725:                 ENDIF
1726:                 USE IN cursor_4c_DepGrupoLst
1727:             ENDIF
1728:         CATCH TO loc_oErro
1729:             MsgErro(loc_oErro.Message, "AbrirBuscaDepGrupo")
1730:         ENDTRY
1731:     ENDPROC
1732: 
1733:     *==========================================================================
1734:     * VALIDACAO E LOOKUP - DEPOSITO CONTA
1735:     * Conta de deposito (link SigCqChm.Contas ? SigCdCli.Iclis)
1736:     *==========================================================================
1737:     PROCEDURE ValidarCdDepConta()
1738:         LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
1739:         loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
1740:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdDepConta.Value)
1741:         IF EMPTY(loc_cCodigo)
1742:             THIS.txt_4c_DsDepConta.Value = ""
1743:             RETURN
1744:         ENDIF
1745:         loc_cSQL = "SELECT a.Contas AS Codigo, e.Rclis AS Descricao " + ;
1746:                    "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis " + ;
1747:                    "WHERE a.Contas = " + EscaparSQL(loc_cCodigo)
1748:         IF !EMPTY(loc_cGrupo)
1749:             loc_cSQL = loc_cSQL + " AND a.Grupos = " + EscaparSQL(loc_cGrupo)
1750:         ENDIF
1751:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaVal")
1752:         IF loc_nResult > 0 AND USED("cursor_4c_DepContaVal")
1753:             SELECT cursor_4c_DepContaVal
1754:             IF !EOF()
1755:                 THIS.txt_4c_DsDepConta.Value = ALLTRIM(Descricao)
1756:             ELSE
1757:                 MsgAviso("Acesso Negado!!", "Dep" + CHR(243) + "sito")
1758:                 THIS.txt_4c_CdDepConta.Value = ""
1759:                 THIS.txt_4c_DsDepConta.Value = ""
1760:             ENDIF
1761:             USE IN cursor_4c_DepContaVal
1762:         ENDIF
1763:     ENDPROC
1764: 
1765:     PROCEDURE ValidarDsDepConta()
1766:         LOCAL loc_cDescricao
1767:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsDepConta.Value)
1768:         IF EMPTY(loc_cDescricao)
1769:             THIS.txt_4c_CdDepConta.Value = ""
1770:             RETURN
1771:         ENDIF
1772:         THIS.AbrirBuscaDepConta()
1773:     ENDPROC
1774: 
1775:     PROCEDURE AbrirBuscaDepConta()
1776:         LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
1777:         TRY
1778:             loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdDepGrupo.Value)
1779:             loc_cSQL    = "SELECT DISTINCT a.Contas AS codigo, e.Rclis AS descricao " + ;
1780:                           "FROM SigCqChm a JOIN SigCdCli e ON a.Contas = e.Iclis"
1781:             IF !EMPTY(loc_cGrupo)
1782:                 loc_cSQL = loc_cSQL + " WHERE a.Grupos = " + EscaparSQL(loc_cGrupo)
1783:             ENDIF
1784:             loc_cSQL    = loc_cSQL + " ORDER BY e.Rclis"
1785:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DepContaLst")
1786:             IF loc_nResult > 0 AND USED("cursor_4c_DepContaLst")
1787:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1788:                 IF VARTYPE(loLookup) = "O"
1789:                     loLookup.ConfigurarBuscaCursor("cursor_4c_DepContaLst", ;
1790:                         "codigo", "descricao", "Conta Dep" + CHR(243) + "sito", ;
1791:                         ALLTRIM(THIS.txt_4c_CdDepConta.Value))
1792:                     loLookup.Show()
1793:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1794:                         THIS.txt_4c_CdDepConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1795:                         THIS.txt_4c_DsDepConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1796:                     ENDIF
1797:                     loLookup = .NULL.
1798:                 ENDIF
1799:                 USE IN cursor_4c_DepContaLst
1800:             ENDIF
1801:         CATCH TO loc_oErro
1802:             MsgErro(loc_oErro.Message, "AbrirBuscaDepConta")
1803:         ENDTRY
1804:     ENDPROC
1805: 
1806:     *==========================================================================
1807:     * VALIDACAO E LOOKUP - EMISSOR GRUPO
1808:     *==========================================================================
1809:     PROCEDURE ValidarCdEmiGrupo()
1810:         LOCAL loc_cCodigo, loc_cSQL, loc_nResult
1811:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
1812:         IF EMPTY(loc_cCodigo)
1813:             THIS.txt_4c_DsEmiGrupo.Value = ""
1814:             THIS.txt_4c_CdEmiConta.Value = ""
1815:             THIS.txt_4c_DsEmiConta.Value = ""
1816:             RETURN
1817:         ENDIF
1818:         loc_cSQL    = "SELECT DISTINCT Grclis AS Codigo, Grclis AS Descricao " + ;
1819:                       "FROM SigCqChm WHERE Grclis = " + EscaparSQL(loc_cCodigo)
1820:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoVal")
1821:         IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoVal")
1822:             SELECT cursor_4c_EmiGrupoVal
1823:             IF !EOF()
1824:                 THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(Codigo)
1825:             ELSE
1826:                 THIS.txt_4c_CdEmiGrupo.Value = ""
1827:                 THIS.txt_4c_DsEmiGrupo.Value = ""
1828:                 THIS.txt_4c_CdEmiConta.Value = ""
1829:                 THIS.txt_4c_DsEmiConta.Value = ""
1830:             ENDIF
1831:             USE IN cursor_4c_EmiGrupoVal
1832:         ENDIF
1833:     ENDPROC
1834: 
1835:     PROCEDURE ValidarDsEmiGrupo()
1836:         LOCAL loc_cDescricao
1837:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiGrupo.Value)
1838:         IF EMPTY(loc_cDescricao)
1839:             THIS.txt_4c_CdEmiGrupo.Value = ""
1840:             THIS.txt_4c_CdEmiConta.Value = ""
1841:             THIS.txt_4c_DsEmiConta.Value = ""
1842:             RETURN
1843:         ENDIF
1844:         THIS.AbrirBuscaEmiGrupo()
1845:     ENDPROC
1846: 
1847:     PROCEDURE AbrirBuscaEmiGrupo()
1848:         LOCAL loLookup, loc_cSQL, loc_nResult
1849:         TRY
1850:             loc_cSQL    = "SELECT DISTINCT Grclis AS codigo, Grclis AS descricao " + ;
1851:                           "FROM SigCqChm ORDER BY Grclis"
1852:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiGrupoLst")
1853:             IF loc_nResult > 0 AND USED("cursor_4c_EmiGrupoLst")
1854:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1855:                 IF VARTYPE(loLookup) = "O"
1856:                     loLookup.ConfigurarBuscaCursor("cursor_4c_EmiGrupoLst", ;
1857:                         "codigo", "descricao", "Grupo Emissor", ;
1858:                         ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value))
1859:                     loLookup.Show()
1860:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1861:                         THIS.txt_4c_CdEmiGrupo.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1862:                         THIS.txt_4c_DsEmiGrupo.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1863:                         THIS.txt_4c_CdEmiConta.Value = ""
1864:                         THIS.txt_4c_DsEmiConta.Value = ""
1865:                     ENDIF
1866:                     loLookup = .NULL.
1867:                 ENDIF
1868:                 USE IN cursor_4c_EmiGrupoLst
1869:             ENDIF
1870:         CATCH TO loc_oErro
1871:             MsgErro(loc_oErro.Message, "AbrirBuscaEmiGrupo")
1872:         ENDTRY
1873:     ENDPROC
1874: 
1875:     *==========================================================================
1876:     * VALIDACAO E LOOKUP - EMISSOR CONTA
1877:     * Conta de emissor (link SigCqChm.Iclis ? SigCdCli.Iclis)
1878:     *==========================================================================
1879:     PROCEDURE ValidarCdEmiConta()
1880:         LOCAL loc_cGrupo, loc_cCodigo, loc_cSQL, loc_nResult
1881:         loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
1882:         loc_cCodigo = ALLTRIM(THIS.txt_4c_CdEmiConta.Value)
1883:         IF EMPTY(loc_cCodigo)
1884:             THIS.txt_4c_DsEmiConta.Value = ""
1885:             RETURN
1886:         ENDIF
1887:         loc_cSQL = "SELECT DISTINCT a.Iclis AS Codigo, d.Rclis AS Descricao " + ;
1888:                    "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis " + ;
1889:                    "WHERE a.Iclis = " + EscaparSQL(loc_cCodigo)
1890:         IF !EMPTY(loc_cGrupo)
1891:             loc_cSQL = loc_cSQL + " AND a.Grclis = " + EscaparSQL(loc_cGrupo)
1892:         ENDIF
1893:         loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaVal")
1894:         IF loc_nResult > 0 AND USED("cursor_4c_EmiContaVal")
1895:             SELECT cursor_4c_EmiContaVal
1896:             IF !EOF()
1897:                 THIS.txt_4c_DsEmiConta.Value = ALLTRIM(Descricao)
1898:             ELSE
1899:                 MsgAviso("Acesso Negado!!", "Emissor")
1900:                 THIS.txt_4c_CdEmiConta.Value = ""
1901:                 THIS.txt_4c_DsEmiConta.Value = ""
1902:             ENDIF
1903:             USE IN cursor_4c_EmiContaVal
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     PROCEDURE ValidarDsEmiConta()
1908:         LOCAL loc_cDescricao
1909:         loc_cDescricao = ALLTRIM(THIS.txt_4c_DsEmiConta.Value)
1910:         IF EMPTY(loc_cDescricao)
1911:             THIS.txt_4c_CdEmiConta.Value = ""
1912:             RETURN
1913:         ENDIF
1914:         THIS.AbrirBuscaEmiConta()
1915:     ENDPROC
1916: 
1917:     PROCEDURE AbrirBuscaEmiConta()
1918:         LOCAL loLookup, loc_cGrupo, loc_cSQL, loc_nResult
1919:         TRY
1920:             loc_cGrupo  = ALLTRIM(THIS.txt_4c_CdEmiGrupo.Value)
1921:             loc_cSQL    = "SELECT DISTINCT a.Iclis AS codigo, d.Rclis AS descricao " + ;
1922:                           "FROM SigCqChm a JOIN SigCdCli d ON a.Iclis = d.Iclis"
1923:             IF !EMPTY(loc_cGrupo)
1924:                 loc_cSQL = loc_cSQL + " WHERE a.Grclis = " + EscaparSQL(loc_cGrupo)
1925:             ENDIF
1926:             loc_cSQL    = loc_cSQL + " ORDER BY d.Rclis"
1927:             loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmiContaLst")
1928:             IF loc_nResult > 0 AND USED("cursor_4c_EmiContaLst")
1929:                 loLookup = CREATEOBJECT("FormBuscaAuxiliar")
1930:                 IF VARTYPE(loLookup) = "O"
1931:                     loLookup.ConfigurarBuscaCursor("cursor_4c_EmiContaLst", ;
1932:                         "codigo", "descricao", "Conta Emissor", ;
1933:                         ALLTRIM(THIS.txt_4c_CdEmiConta.Value))
1934:                     loLookup.Show()
1935:                     IF !EMPTY(ALLTRIM(NVL(loLookup.this_cCodigoSelecionado, "")))
1936:                         THIS.txt_4c_CdEmiConta.Value = ALLTRIM(loLookup.this_cCodigoSelecionado)
1937:                         THIS.txt_4c_DsEmiConta.Value = ALLTRIM(loLookup.this_cDescricaoSelecionada)
1938:                     ENDIF
1939:                     loLookup = .NULL.
1940:                 ENDIF
1941:                 USE IN cursor_4c_EmiContaLst
1942:             ENDIF
1943:         CATCH TO loc_oErro
1944:             MsgErro(loc_oErro.Message, "AbrirBuscaEmiConta")
1945:         ENDTRY
1946:     ENDPROC
1947: 
1948:     *==========================================================================
1949:     * BTNBUSCARCLICK - "Buscar" no contexto de relatorio: gerar visualizacao
1950:     *==========================================================================
1951:     PROCEDURE BtnBuscarClick()
1952:         LOCAL loc_lSucesso
1953:         loc_lSucesso = .F.
1954:         TRY
1955:             THIS.FormParaRelatorio()
1956:             loc_lSucesso = THIS.this_oRelatorio.Visualizar()
1957:             IF !loc_lSucesso
1958:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), ;
1959:                         "Gerar Relat" + CHR(243) + "rio")
1960:             ENDIF
1961:         CATCH TO loc_oErro
1962:             MsgErro(loc_oErro.Message, "BtnBuscarClick")
1963:         ENDTRY
1964:     ENDPROC
1965: 
1966:     *==========================================================================
1967:     * BTNENCERRARCLICK - Encerrar/fechar o form de relatorio
1968:     *==========================================================================
1969:     PROCEDURE BtnEncerrarClick()
1970:         THIS.Release()
1971:     ENDPROC
1972: 
1973:     *==========================================================================
1974:     * BTNSALVARCLICK - "Salvar" no contexto de relatorio: imprimir
1975:     *==========================================================================
1976:     PROCEDURE BtnSalvarClick()
1977:         LOCAL loc_lSucesso
1978:         loc_lSucesso = .F.
1979:         TRY
1980:             THIS.FormParaRelatorio()
1981:             loc_lSucesso = THIS.this_oRelatorio.Imprimir()
1982:             IF !loc_lSucesso
1983:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
1984:             ENDIF
1985:         CATCH TO loc_oErro
1986:             MsgErro(loc_oErro.Message, "BtnSalvarClick")
1987:         ENDTRY
1988:     ENDPROC
1989: 
1990:     *==========================================================================
1991:     * FORMPARABO - Alias de FormParaRelatorio (compatibilidade com FormBase)
1992:     *==========================================================================
1993:     PROCEDURE FormParaBO()
1994:         THIS.FormParaRelatorio()
1995:     ENDPROC
1996: 
1997:     *==========================================================================
1998:     * BOPARAFORM - Carrega estado do BO de volta para os controles do form
1999:     * Inverso de FormParaRelatorio: popula controles com valores atuais do BO
2000:     *==========================================================================
2001:     PROTECTED PROCEDURE BOParaForm()
2002:         IF VARTYPE(THIS.this_oRelatorio) != "O"
2003:             RETURN
2004:         ENDIF
2005:         WITH THIS.this_oRelatorio
2006:             IF PEMSTATUS(THIS, "obj_4c_NrTipo", 5)
2007:                 THIS.obj_4c_NrTipo.Value = .this_nNrTipo
2008:             ENDIF
2009:             IF PEMSTATUS(THIS, "obj_4c_NrOpcao", 5)
2010:                 THIS.obj_4c_NrOpcao.Value = .this_nNrOpcao
2011:             ENDIF
2012:             IF PEMSTATUS(THIS, "cbo_4c_Ordem", 5)
2013:                 THIS.cbo_4c_Ordem.Value = .this_nOrdem
2014:             ENDIF
2015:             IF PEMSTATUS(THIS, "chk_4c_Ultima", 5)
2016:                 THIS.chk_4c_Ultima.Value = IIF(.this_lUltima = .T., 1, 0)
2017:             ENDIF
2018:             IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
2019:                 THIS.txt_4c_DtInicial.Value = .this_dDtInicial
2020:             ENDIF
2021:             IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
2022:                 THIS.txt_4c_DtFinal.Value = .this_dDtFinal
2023:             ENDIF
2024:             IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
2025:                 THIS.txt_4c_CdEmpresa.Value = ALLTRIM(.this_cCdEmpresa)
2026:             ENDIF
2027:             IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
2028:                 THIS.txt_4c_DsEmpresa.Value = ALLTRIM(.this_cDsEmpresa)
2029:             ENDIF
2030:             IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
2031:                 THIS.txt_4c_CdCarGrupo.Value = ALLTRIM(.this_cCdCarGrupo)
2032:             ENDIF
2033:             IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
2034:                 THIS.txt_4c_DsCarGrupo.Value = ALLTRIM(.this_cDsCarGrupo)
2035:             ENDIF
2036:             IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
2037:                 THIS.txt_4c_CdCarConta.Value = ALLTRIM(.this_cCdCarConta)
2038:             ENDIF
2039:             IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
2040:                 THIS.txt_4c_DsCarConta.Value = ALLTRIM(.this_cDsCarConta)
2041:             ENDIF

*-- Linhas 2070 a 2113:
2070:     * HABILITARCAMPOS - Habilita/desabilita todos os controles de filtro
2071:     * par_lHabilitar: .T. = editavel, .F. = somente leitura
2072:     *==========================================================================
2073:     PROCEDURE HabilitarCampos(par_lHabilitar)
2074:         LOCAL loc_lHabilitar
2075:         loc_lHabilitar = IIF(PCOUNT() < 1 OR VARTYPE(par_lHabilitar) != "L", .T., par_lHabilitar)
2076: 
2077:         IF PEMSTATUS(THIS, "txt_4c_DtInicial", 5)
2078:             THIS.txt_4c_DtInicial.ReadOnly = !loc_lHabilitar
2079:         ENDIF
2080:         IF PEMSTATUS(THIS, "txt_4c_DtFinal", 5)
2081:             THIS.txt_4c_DtFinal.ReadOnly = !loc_lHabilitar
2082:         ENDIF
2083:         IF PEMSTATUS(THIS, "txt_4c_CdEmpresa", 5)
2084:             THIS.txt_4c_CdEmpresa.ReadOnly = !loc_lHabilitar
2085:         ENDIF
2086:         IF PEMSTATUS(THIS, "txt_4c_DsEmpresa", 5)
2087:             THIS.txt_4c_DsEmpresa.ReadOnly = !loc_lHabilitar
2088:         ENDIF
2089:         IF PEMSTATUS(THIS, "txt_4c_CdCarGrupo", 5)
2090:             THIS.txt_4c_CdCarGrupo.ReadOnly = !loc_lHabilitar
2091:         ENDIF
2092:         IF PEMSTATUS(THIS, "txt_4c_DsCarGrupo", 5)
2093:             THIS.txt_4c_DsCarGrupo.ReadOnly = !loc_lHabilitar
2094:         ENDIF
2095:         IF PEMSTATUS(THIS, "txt_4c_CdCarConta", 5)
2096:             THIS.txt_4c_CdCarConta.ReadOnly = !loc_lHabilitar
2097:         ENDIF
2098:         IF PEMSTATUS(THIS, "txt_4c_DsCarConta", 5)
2099:             THIS.txt_4c_DsCarConta.ReadOnly = !loc_lHabilitar
2100:         ENDIF
2101:         IF PEMSTATUS(THIS, "txt_4c_CdDepGrupo", 5)
2102:             THIS.txt_4c_CdDepGrupo.ReadOnly = !loc_lHabilitar
2103:         ENDIF
2104:         IF PEMSTATUS(THIS, "txt_4c_DsDepGrupo", 5)
2105:             THIS.txt_4c_DsDepGrupo.ReadOnly = !loc_lHabilitar
2106:         ENDIF
2107:         IF PEMSTATUS(THIS, "txt_4c_CdDepConta", 5)
2108:             THIS.txt_4c_CdDepConta.ReadOnly = !loc_lHabilitar
2109:         ENDIF
2110:         IF PEMSTATUS(THIS, "txt_4c_DsDepConta", 5)
2111:             THIS.txt_4c_DsDepConta.ReadOnly = !loc_lHabilitar
2112:         ENDIF
2113:         IF PEMSTATUS(THIS, "txt_4c_CdEmiGrupo", 5)

*-- Linhas 2140 a 2194:
2140:     * CARREGARLISTA - Recarrega grids de operacoes e campos de impressao
2141:     * Para forms REPORT, recria cursores e atualiza opcoes do BO via banco
2142:     *==========================================================================
2143:     PROCEDURE CarregarLista()
2144:         LOCAL loc_lSucesso
2145:         loc_lSucesso = .F.
2146:         TRY
2147:             IF VARTYPE(THIS.this_oRelatorio) != "O"
2148:                 loc_lSucesso = .F.
2149:             ENDIF
2150:             THIS.this_oRelatorio.InicializarCursores()
2151:             IF TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
2152:                 THIS.this_oRelatorio.CarregarOpcoes()
2153:                 THIS.AtualizarTitulosOpcao()
2154:             ENDIF
2155:             IF PEMSTATUS(THIS, "grd_4c_Operacoes", 5)
2156:                 THIS.grd_4c_Operacoes.Refresh()
2157:             ENDIF
2158:             IF PEMSTATUS(THIS, "grd_4c_Imprimir", 5)
2159:                 THIS.grd_4c_Imprimir.Refresh()
2160:             ENDIF
2161:             loc_lSucesso = .T.
2162:         CATCH TO loc_oErro
2163:             MsgErro(loc_oErro.Message, "CarregarLista")
2164:         ENDTRY
2165:         RETURN loc_lSucesso
2166:     ENDPROC
2167: 
2168:     *==========================================================================
2169:     * AJUSTARBOTOESPORMODO - Ajusta estado dos botoes
2170:     * Para forms REPORT, todos os botoes de acao permanecem habilitados
2171:     *==========================================================================
2172:     PROCEDURE AjustarBotoesPorModo()
2173:         IF !PEMSTATUS(THIS, "cmg_4c_Botoes", 5)
2174:             RETURN
2175:         ENDIF
2176:         WITH THIS.cmg_4c_Botoes
2177:             .Buttons(1).Enabled = .T.
2178:             .Buttons(2).Enabled = .T.
2179:             .Buttons(3).Enabled = .T.
2180:             .Buttons(4).Enabled = .T.
2181:         ENDWITH
2182:     ENDPROC
2183: 
2184:     *==========================================================================
2185:     * DESTROY - Limpeza de recursos
2186:     *==========================================================================
2187:     PROCEDURE Destroy()
2188:         IF VARTYPE(THIS.this_oRelatorio) = "O"
2189:             THIS.this_oRelatorio = .NULL.
2190:         ENDIF
2191:         DODEFAULT()
2192:     ENDPROC
2193: 
2194: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecheBO.prg):
*==============================================================================
* SIGRECHEBO.PRG
* Business Object para Relatorio de Cheques (SIGRECHE)
*
* Herda de RelatorioBase
* Filtros: periodo, empresa, tipo, opcao, ordem, ultima movimentacao,
*          carteira (grupo/conta), deposito (grupo/conta), emissor (grupo/conta)
* Tabelas principais: SigCqChm, SigChe, SigCdCli, SigCdOpt, SigCdPac, SigCdEmp
*==============================================================================

DEFINE CLASS sigrecheBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoFrx        = ""
    this_cTitulo            = ""

    *-- Nomes dos cursores
    this_cCursorDados       = "cursor_4c_Dados"
    this_cCursorCabecalho   = "cursor_4c_Cabecalho"
    this_cCursorOperacoes   = "cursor_4c_Operacoes"
    this_cCursorImprimir    = "cursor_4c_Imprimir"

    *-- Filtros de periodo (get_dt_inicial / get_dt_final)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtros de empresa (get_cd_empresa / get_ds_empresa)
    this_cCdEmpresa         = ""
    this_cDsEmpresa         = ""

    *-- Tipo de relatorio: 1=Abertos, 2=Geral, 3=DtOperacao, 4=DtVencimento
    this_nNrTipo            = 1

    *-- Opcao (com/sem nota): 1=Sim, 2=Nao, 3=Ambos
    this_nNrOpcao           = 3

    *-- Ordem de classificacao: 1=Carteira,2=Deposito,3=Emissor,4=DtEntrada,5=CPF,6=Nome
    this_nOrdem             = 1

    *-- Apenas ultima movimentacao por cheque
    this_lUltima            = .T.

    *-- Titulos dinamicos carregados de SigCdPac
    this_cTituloOpcao1      = "Sim"
    this_cTituloOpcao2      = "N" + CHR(227) + "o"
    this_cTituloOpcao3      = "Ambos"

    *-- Filtros de carteira (get_cd_car_grupo / get_ds_car_grupo / ...)
    this_cCdCarGrupo        = ""
    this_cDsCarGrupo        = ""
    this_cCdCarConta        = ""
    this_cDsCarConta        = ""

    *-- Filtros de deposito (get_cd_dep_grupo / get_ds_dep_grupo / ...)
    this_cCdDepGrupo        = ""
    this_cDsDepGrupo        = ""
    this_cCdDepConta        = ""
    this_cDsDepConta        = ""

    *-- Filtros de emissor (get_cd_emi_grupo / get_ds_emi_grupo / ...)
    this_cCdEmiGrupo        = ""
    this_cDsEmiGrupo        = ""
    this_cCdEmiConta        = ""
    this_cDsEmiConta        = ""

    *--------------------------------------------------------------------------
    * Init - Configura caminho do FRX e titulo; inicializa datas com hoje
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cArquivoFrx = gc_4c_CaminhoReports + "SigReChe.frx"
        THIS.this_cTitulo     = "Relat" + CHR(243) + "rio de Cheques"
        THIS.this_dDtInicial  = DATE()
        THIS.this_dDtFinal    = DATE()
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursores - Cria cursor_4c_Imprimir (campos opcionals de impressao)
    * e cursor_4c_Operacoes vazio (preenchido por CarregarOpcoes)
    * Chamado pelo Form em InicializarForm()
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursores()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED(THIS.this_cCursorImprimir)
                USE IN (THIS.this_cCursorImprimir)
            ENDIF
            CREATE CURSOR cursor_4c_Imprimir (Marcas L(1), Campos C(20))
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.T., "C" + CHR(243) + "digo")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F.")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "Nome")
            INSERT INTO cursor_4c_Imprimir (Marcas, Campos) VALUES (.F., "C.P.F. T")
            GO TOP IN cursor_4c_Imprimir

            IF USED(THIS.this_cCursorOperacoes)
                USE IN (THIS.this_cCursorOperacoes)
            ENDIF
            CREATE CURSOR cursor_4c_Operacoes (Marcas L(1), Operacaos C(15), Tipos C(2))

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "InicializarCursores")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOpcoes - Carrega SigCdOpt ? cursor_4c_Operacoes
    * e titulos de opcao de SigCdPac (para o OptionGroup do form)
    * Chamado pelo Form apos InicializarCursores()
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOpcoes()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL
        loc_lSucesso = .F.
        TRY
            loc_cSQL = "SELECT Operacaos, Tipos FROM SigCdOpt"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpOpt")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpOpt")
                SELECT cursor_4c_TmpOpt
                GO TOP
                SCAN
                    INSERT INTO cursor_4c_Operacoes (Marcas, Operacaos, Tipos) ;
                        VALUES (.F., cursor_4c_TmpOpt.Operacaos, cursor_4c_TmpOpt.Tipos)
                ENDSCAN
                USE IN cursor_4c_TmpOpt
            ENDIF
            GO TOP IN cursor_4c_Operacoes

            loc_cSQL = "SELECT TitOpcS, TitOpcN, TitOpcA FROM SigCdPac"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpPac")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpPac")
                SELECT cursor_4c_TmpPac
                GO TOP
                IF !EOF()
                    IF !EMPTY(ALLTRIM(TitOpcS))
                        THIS.this_cTituloOpcao1 = ALLTRIM(TitOpcS)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcN))
                        THIS.this_cTituloOpcao2 = ALLTRIM(TitOpcN)
                    ENDIF
                    IF !EMPTY(ALLTRIM(TitOpcA))
                        THIS.this_cTituloOpcao3 = ALLTRIM(TitOpcA)
                    ENDIF
                ENDIF
                USE IN cursor_4c_TmpPac
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "CarregarOpcoes")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Validar - Valida filtros antes de gerar relatorio
    * Retorna .T. se tudo ok; caso contrario seta this_cMensagemErro
    *--------------------------------------------------------------------------
    PROCEDURE ValidarDados()
        LOCAL loc_nMarcados

        IF EMPTY(THIS.this_dDtInicial)
            THIS.this_cMensagemErro = "Data inicial inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtFinal)
            THIS.this_cMensagemErro = "Data final inv" + CHR(225) + "lida!"
            RETURN .F.
        ENDIF
        IF THIS.this_dDtFinal < THIS.this_dDtInicial
            THIS.this_cMensagemErro = "Data inicial maior que data final!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorOperacoes)
            SELECT (THIS.this_cCursorOperacoes)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos uma Opera" + CHR(231) + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        loc_nMarcados = 0
        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF Marcas
                    loc_nMarcados = loc_nMarcados + 1
                ENDIF
            ENDSCAN
        ENDIF
        IF loc_nMarcados = 0
            THIS.this_cMensagemErro = "Selecione ao menos um Campo para Impress" + CHR(227) + "o!"
            RETURN .F.
        ENDIF

        IF USED(THIS.this_cCursorImprimir)
            SELECT (THIS.this_cCursorImprimir)
            SCAN
                IF !Marcas
                    IF (Campos = "C.P.F." .AND. THIS.this_nOrdem = 5) .OR. ;
                       (Campos = "Nome"   .AND. THIS.this_nOrdem = 6)
                        THIS.this_cMensagemErro = "Esta Ordem Necessita Que Selecione o " + ;
                            "Campo de Impress" + CHR(227) + "o " + ALLTRIM(Campos) + "!"
                        RETURN .F.
                    ENDIF
                ENDIF
            ENDSCAN
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros, executa via SQLEXEC, filtra
    * por operacoes selecionadas e popula cursor_4c_Cabecalho + cursor_4c_Relatorio
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_nResult
        LOCAL loc_cVerData, loc_cVerEmpresa, loc_cVerOpcao
        LOCAL loc_cVerCarGrupo, loc_cVerCarConta
        LOCAL loc_cVerDepGrupo, loc_cVerDepConta
        LOCAL loc_cVerEmiGrupo, loc_cVerEmiConta
        LOCAL loc_cVerAberto, loc_cOrdenaPor, loc_cQuebra, loc_cTituloOrdem
        LOCAL loc_cTitulo, loc_cNomeEmpresa, loc_cPeriodo
        LOCAL loc_cCarteira, loc_cDeposito, loc_cEmissor, loc_cOperacao
        LOCAL loc_lCpfs, loc_lRclis, loc_lCpft
        LOCAL loc_cSQL, loc_cNum

        loc_lSucesso = .F.
        loc_lCpfs    = .F.
        loc_lRclis   = .F.
        loc_lCpft    = .F.

        TRY
            *-- 1. Condicao de data conforme tipo
            IF THIS.this_nNrTipo = 3
                loc_cVerData = " AND a.dtents BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ELSE
                loc_cVerData = " AND b.vencs BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                               " AND " + FormatarDataSQL(THIS.this_dDtFinal)
            ENDIF

            *-- 2. Filtros opcionais de empresa, opcao, carteira, deposito, emissor
            IF EMPTY(ALLTRIM(THIS.this_cCdEmpresa))
                loc_cVerEmpresa = ""
            ELSE
                loc_cVerEmpresa = " AND a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmpresa))
            ENDIF

            IF THIS.this_nNrOpcao = 1
                loc_cVerOpcao = " AND a.notas <> '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 2
                loc_cVerOpcao = " AND a.notas = '" + SPACE(6) + "'"
            ENDIF
            IF THIS.this_nNrOpcao = 3
                loc_cVerOpcao = ""
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdCarGrupo))
                loc_cVerCarGrupo = ""
            ELSE
                loc_cVerCarGrupo = " AND a.grucarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdCarConta))
                loc_cVerCarConta = ""
            ELSE
                loc_cVerCarConta = " AND a.concarts = " + EscaparSQL(ALLTRIM(THIS.this_cCdCarConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdDepGrupo))
                loc_cVerDepGrupo = ""
            ELSE
                loc_cVerDepGrupo = " AND a.grupos = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdDepConta))
                loc_cVerDepConta = ""
            ELSE
                loc_cVerDepConta = " AND a.contas = " + EscaparSQL(ALLTRIM(THIS.this_cCdDepConta))
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo))
                loc_cVerEmiGrupo = ""
            ELSE
                loc_cVerEmiGrupo = " AND a.grclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiGrupo))
            ENDIF
            IF EMPTY(ALLTRIM(THIS.this_cCdEmiConta))
                loc_cVerEmiConta = ""
            ELSE
                loc_cVerEmiConta = " AND a.iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEmiConta))
            ENDIF

            *-- Filtro de abertos aplicado no filtro local pos-SQLEXEC
            IF THIS.this_nNrTipo = 1
                loc_cVerAberto = " AND c.Tipos = 'DB'"
            ELSE
                loc_cVerAberto = ""
            ENDIF

            *-- 3. ORDER BY, campo Quebra e sufixo do titulo conforme ordem
            DO CASE
                CASE THIS.this_nOrdem = 1
                    loc_cOrdenaPor  = "a.GruCarts, a.ConCarts, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Carteira: ' + a.GruCarts + '/' + a.ConCarts"
                    loc_cTituloOrdem = "Carteira"
                CASE THIS.this_nOrdem = 2
                    loc_cOrdenaPor  = "a.Grupos, a.Contas, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Dep' + CHR(243) + 'sito: ' + a.Grupos + '/' + a.Contas"
                    loc_cTituloOrdem = "Dep" + CHR(243) + "sito"
                CASE THIS.this_nOrdem = 3
                    loc_cOrdenaPor  = "a.Grclis, a.Iclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Grupo/Conta Emissor: ' + a.Grclis + '/' + a.Iclis"
                    loc_cTituloOrdem = "Emissor"
                CASE THIS.this_nOrdem = 4
                    loc_cOrdenaPor  = "a.Dtents, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Entrada: ' + DTOC(a.Dtents)"
                    loc_cTituloOrdem = "Data de Entrada"
                CASE THIS.this_nOrdem = 5
                    loc_cOrdenaPor  = "a.Cpfs, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'C.P.F.: ' + a.Cpfs"
                    loc_cTituloOrdem = "C.P.F."
                OTHERWISE
                    loc_cOrdenaPor  = "a.Rclis, a.Operacaos, a.Nums"
                    loc_cQuebra     = "'Nome: ' + a.Rclis"
                    loc_cTituloOrdem = "Nome do Cliente"
            ENDCASE

            *-- 4. Titulo do relatorio
            loc_cTitulo = "Relat" + CHR(243) + "rio de Cheques - "
            DO CASE
                CASE THIS.this_nNrTipo = 1
                    loc_cTitulo = loc_cTitulo + "Abertos"
                CASE THIS.this_nNrTipo = 2
                    loc_cTitulo = loc_cTitulo + "Geral"
                CASE THIS.this_nNrTipo = 3
                    loc_cTitulo = loc_cTitulo + "Data de Opera" + CHR(231) + CHR(227) + "o"
                OTHERWISE
                    loc_cTitulo = loc_cTitulo + "Data de Vencimento"
            ENDCASE
            loc_cTitulo = loc_cTitulo + " - Ordem: " + loc_cTituloOrdem

            *-- 5. Nome da empresa corrente
            loc_cNomeEmpresa = ""
            loc_cSQL = "SELECT Razas FROM SigCdEmp WHERE cEmps = " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpEmp")
            IF loc_nResult > 0 AND USED("cursor_4c_TmpEmp")
                SELECT cursor_4c_TmpEmp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(Razas)
                ENDIF
                USE IN cursor_4c_TmpEmp
            ENDIF

            *-- 6. Textos descritivos para o cabecalho do relatorio
            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDtInicial) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDtFinal) + " - " + ;
                           "Empresa: " + IIF(EMPTY(ALLTRIM(THIS.this_cCdEmpresa)), ;
                               "Geral", ;
                               ALLTRIM(THIS.this_cCdEmpresa) + " - " + ALLTRIM(THIS.this_cDsEmpresa))

            loc_cCarteira = "Grupo / Conta Carteira : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdCarGrupo) + " - " + ALLTRIM(THIS.this_cDsCarGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdCarConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdCarConta) + " - " + ALLTRIM(THIS.this_cDsCarConta))

            loc_cDeposito = "Grupo / Conta Deposito : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdDepGrupo) + " - " + ALLTRIM(THIS.this_cDsDepGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdDepConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdDepConta) + " - " + ALLTRIM(THIS.this_cDsDepConta))

            loc_cEmissor = "Grupo / Conta Emissor  : " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiGrupo)), "Todos", ;
                    ALLTRIM(THIS.this_cCdEmiGrupo) + " - " + ALLTRIM(THIS.this_cDsEmiGrupo)) + ;
                " / " + ;
                IIF(EMPTY(ALLTRIM(THIS.this_cCdEmiConta)), "Todas", ;
                    ALLTRIM(THIS.this_cCdEmiConta) + " - " + ALLTRIM(THIS.this_cDsEmiConta))

            *-- 7. Texto das operacoes selecionadas
            loc_cOperacao = "Opera" + CHR(231) + CHR(227) + "o : "
            IF USED(THIS.this_cCursorOperacoes)
                SELECT (THIS.this_cCursorOperacoes)
                SCAN
                    IF Marcas
                        IF LEN(ALLTRIM(loc_cOperacao)) > 12
                            loc_cOperacao = loc_cOperacao + " / "
                        ENDIF
                        loc_cOperacao = loc_cOperacao + ALLTRIM(Operacaos)
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 8. Flags de campos de impressao (Cpfs, Rclis, CpfsT)
            IF USED(THIS.this_cCursorImprimir)
                SELECT (THIS.this_cCursorImprimir)
                SCAN
                    IF Marcas
                        IF Campos = "C.P.F."
                            loc_lCpfs = (THIS.this_nOrdem # 5)
                        ENDIF
                        IF Campos = "Nome"
                            loc_lRclis = (THIS.this_nOrdem # 6)
                        ENDIF
                        IF Campos = "C.P.F. T"
                            loc_lCpft = .T.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            *-- 9. Cursor de cabecalho do relatorio
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            CREATE CURSOR cursor_4c_Cabecalho (NomeEmpresa C(80), Titulo C(80), Periodo C(80), ;
                                               Operacao C(200), Carteira C(80), Deposito C(80), ;
                                               Emissor C(80), Tipo N(1), ;
                                               Cpfs L(1), Rclis L(1), Cpfst L(1))
            INSERT INTO cursor_4c_Cabecalho ;
                (NomeEmpresa, Titulo, Periodo, Operacao, Carteira, ;
                 Deposito, Emissor, Tipo, Cpfs, Rclis, Cpfst) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cPeriodo, loc_cOperacao, ;
                        loc_cCarteira, loc_cDeposito, loc_cEmissor, THIS.this_nOrdem, ;
                        loc_lCpfs, loc_lRclis, loc_lCpft)

            *-- 10. SQL principal via SQLEXEC (SigCqChm + SigChe + SigCdCli x3)
            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF
            loc_cSQL = "SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, " + ;
                       "a.Contas + '-' + e.rclis AS Contas, a.Grclis, a.Iclis, a.Dtsis, " + ;
                       "b.Vencs, b.Valors, b.Emps, b.Bancos, b.Agencias, b.Ncontas, b.Ncheques, " + ;
                       "b.Bancos + '-' + b.Agencias + '-' + b.Ncontas + '-' + b.Ncheques AS Cheques, " + ;
                       "a.codigos AS Operacaos, d.Cpfs, d.Rclis, a.hists, f.cpfs AS cpfsT " + ;
                       "FROM SigCqChm a, SigCdCli d, SigCdCli e, " + ;
                       "SigChe b LEFT JOIN SigCdCli f ON b.grupot = f.grupos AND b.contat = f.iclis " + ;
                       "WHERE a.Nums = b.Nums AND b.Iclis = d.Iclis AND a.contas = e.Iclis" + ;
                       loc_cVerData + loc_cVerEmpresa + loc_cVerOpcao + ;
                       loc_cVerCarGrupo + loc_cVerCarConta + ;
                       loc_cVerDepGrupo + loc_cVerDepConta + ;
                       loc_cVerEmiGrupo + loc_cVerEmiConta
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Relatorio0")
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cheques."
                loc_lSucesso = .F.
            ENDIF

            *-- 11. Filtrar por operacoes selecionadas e montar cursor final
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            IF THIS.this_lUltima
                *-- Apenas ultima movimentacao por numero de cheque
                *-- Cria cursor-modelo com campo Quebra adicional
                SELECT *, SPACE(100) AS Quebra ;
                    FROM cursor_4c_Relatorio0 ;
                    WHERE 0 = 1 ;
                    INTO CURSOR cursor_4c_Resultado READWRITE

                *-- Seleciona com Quebra calculada, ordenado por Nums + Dtsis DESC
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, a.cpfsT, ;
                       &loc_cQuebra. AS Quebra, a.hists ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       INTO CURSOR cursor_4c_Selecao ;
                       ORDER BY a.Nums, a.Dtsis DESCENDING

                *-- Pega primeiro registro de cada grupo Nums (= mais recente)
                SELECT cursor_4c_Selecao
                GO TOP
                SCAN
                    loc_cNum = Nums
                    SCATTER MEMVAR MEMO
                    SELECT cursor_4c_Resultado
                    APPEND BLANK
                    GATHER MEMVAR MEMO
                    SELECT cursor_4c_Selecao
                    SCAN WHILE Nums = loc_cNum
                    ENDSCAN
                    SKIP -1
                ENDSCAN

                SELECT a.* FROM cursor_4c_Resultado a ;
                    ORDER BY &loc_cOrdenaPor. ;
                    INTO CURSOR cursor_4c_Relatorio

                IF USED("cursor_4c_Resultado")
                    USE IN cursor_4c_Resultado
                ENDIF
                IF USED("cursor_4c_Selecao")
                    USE IN cursor_4c_Selecao
                ENDIF
            ELSE
                *-- Todas as movimentacoes
                SELECT a.Nums, a.NumLotes, a.Dtents, a.GruCarts, a.ConCarts, a.Grupos, ;
                       a.Contas, a.Grclis, a.Iclis, a.Dtsis, ;
                       a.Vencs, a.Valors, a.Emps, a.Cheques, ;
                       a.Operacaos, a.Cpfs, a.Rclis, &loc_cQuebra. AS Quebra, a.hists, a.cpfsT ;
                       FROM cursor_4c_Relatorio0 a, cursor_4c_Operacoes c ;
                       WHERE c.Marcas AND a.Operacaos = c.Operacaos &loc_cVerAberto. ;
                       ORDER BY &loc_cOrdenaPor. ;
                       INTO CURSOR cursor_4c_Relatorio
            ENDIF

            IF USED("cursor_4c_Relatorio0")
                USE IN cursor_4c_Relatorio0
            ENDIF

            SELECT cursor_4c_Relatorio
            GO TOP

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Valida, prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) TO PRINTER PROMPT NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Valida, prepara dados e exibe preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF !THIS.Validar()
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ENDIF
            REPORT FORM (THIS.this_cArquivoFrx) PREVIEW NOCONSOLE
            IF USED("cursor_4c_Cabecalho")
                USE IN cursor_4c_Cabecalho
            ENDIF
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros do relatorio
    * Usada pela auditoria para identificar a execucao do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO=" + ALLTRIM(STR(THIS.this_nNrTipo, 1)) + ;
                     ";OPC="  + ALLTRIM(STR(THIS.this_nNrOpcao, 1)) + ;
                     ";ORD="  + ALLTRIM(STR(THIS.this_nOrdem, 1)) + ;
                     ";DT="   + DTOC(THIS.this_dDtInicial) + ;
                     "-"      + DTOC(THIS.this_dDtFinal) + ;
                     ";EMP="  + ALLTRIM(THIS.this_cCdEmpresa) + ;
                     ";CAR="  + ALLTRIM(THIS.this_cCdCarGrupo) + "/" + ALLTRIM(THIS.this_cCdCarConta) + ;
                     ";DEP="  + ALLTRIM(THIS.this_cCdDepGrupo) + "/" + ALLTRIM(THIS.this_cCdDepConta) + ;
                     ";EMI="  + ALLTRIM(THIS.this_cCdEmiGrupo) + "/" + ALLTRIM(THIS.this_cCdEmiConta) + ;
                     ";ULT="  + IIF(THIS.this_lUltima, "S", "N")
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros a partir de cursor de preset
    * Para BO de relatorio, o cursor pode armazenar parametros previamente usados
    * par_cAliasCursor: nome do cursor com colunas dos filtros
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
                    IF TYPE("m.nNrTipo") = "N"
                        THIS.this_nNrTipo = m.nNrTipo
                    ENDIF
                    IF TYPE("m.nNrOpcao") = "N"
                        THIS.this_nNrOpcao = m.nNrOpcao
                    ENDIF
                    IF TYPE("m.nOrdem") = "N"
                        THIS.this_nOrdem = m.nOrdem
                    ENDIF
                    IF TYPE("m.lUltima") = "L"
                        THIS.this_lUltima = m.lUltima
                    ENDIF
                    IF TYPE("m.cCdCarGrupo") = "C"
                        THIS.this_cCdCarGrupo = ALLTRIM(m.cCdCarGrupo)
                    ENDIF
                    IF TYPE("m.cDsCarGrupo") = "C"
                        THIS.this_cDsCarGrupo = ALLTRIM(m.cDsCarGrupo)
                    ENDIF
                    IF TYPE("m.cCdCarConta") = "C"
                        THIS.this_cCdCarConta = ALLTRIM(m.cCdCarConta)
                    ENDIF
                    IF TYPE("m.cDsCarConta") = "C"
                        THIS.this_cDsCarConta = ALLTRIM(m.cDsCarConta)
                    ENDIF
                    IF TYPE("m.cCdDepGrupo") = "C"
                        THIS.this_cCdDepGrupo = ALLTRIM(m.cCdDepGrupo)
                    ENDIF
                    IF TYPE("m.cDsDepGrupo") = "C"
                        THIS.this_cDsDepGrupo = ALLTRIM(m.cDsDepGrupo)
                    ENDIF
                    IF TYPE("m.cCdDepConta") = "C"
                        THIS.this_cCdDepConta = ALLTRIM(m.cCdDepConta)
                    ENDIF
                    IF TYPE("m.cDsDepConta") = "C"
                        THIS.this_cDsDepConta = ALLTRIM(m.cDsDepConta)
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

                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "CarregarDoCursor")
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
            MsgErro(loc_oErro.Message, "Inserir")
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
            MsgErro(loc_oErro.Message, "Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    * par_cOperacao: tipo de operacao (IMPRESSAO, VISUALIZACAO)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        LOCAL loc_cUsuario
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
                       EscaparSQL("SigReChe") + ", " + ;
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
    * Destroy - Fecha cursores locais e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Cabecalho")
            USE IN cursor_4c_Cabecalho
        ENDIF
        IF USED("cursor_4c_Relatorio")
            USE IN cursor_4c_Relatorio
        ENDIF
        IF USED(THIS.this_cCursorOperacoes)
            USE IN (THIS.this_cCursorOperacoes)
        ENDIF
        IF USED(THIS.this_cCursorImprimir)
            USE IN (THIS.this_cCursorImprimir)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

