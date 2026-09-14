# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [NAVEGACAO-PAGINA] Metodo 'BtnIncluirClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'BtnVisualizarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).
- [NAVEGACAO-PAGINA] Metodo 'BtnAlterarClick' faz ActivePage=2 mas NAO le dados de cursor nem chama CarregarHistorico/CarregarDados. Em forms OPERACIONAL, a navegacao para Page2 DEVE carregar dados da linha selecionada no grid de Page1 (padrao legado: cmd_consulta.Click le do cursor do grid).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)
- [FONTNAME-ERRADO] FontName 'Comic Sans MS' encontrado - substituir por 'Tahoma'

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGloT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (847 linhas total):

*-- Linhas 56 a 67:
56:                 THIS.ConfigurarPaginaLista()
57:                 THIS.ConfigurarPaginaDados()
58: 
59:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:                 THIS.pgf_4c_Paginas.Visible = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67: 

*-- Linhas 88 a 104:
88:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount   = 2
91:             .Top         = -29
92:             .Left        = 0
93:             .Width       = THIS.Width
94:             .Height      = THIS.Height + 29
95:             .Tabs        = .F.
96:             .BorderWidth = 0
97:             .Themes      = .F.
98:             .Page1.Caption = "Lista"
99:             .Page2.Caption = "Dados"
100:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:         ENDWITH
103:     ENDPROC
104: 

*-- Linhas 112 a 182:
112:         *-- Container Cabecalho (cinza opaco, Top=2+29=31)
113:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH loc_oPagina.cnt_4c_Cabecalho
115:             .Top         = 31
116:             .Left        = 0
117:             .Width       = THIS.Width
118:             .Height      = 80
119:             .BackStyle   = 1
120:             .BackColor   = RGB(100,100,100)
121:             .BorderWidth = 0
122:             .Visible     = .T.
123: 
124:             .AddObject("lbl_4c_Sombra", "Label")
125:             WITH .lbl_4c_Sombra
126:                 .AutoSize   = .F.
127:                 .FontBold   = .T.
128:                 .FontName   = "Tahoma"
129:                 .FontSize   = 16
130:                 .BackStyle  = 0
131:                 .Alignment  = 0
132:                 .Height     = 40
133:                 .Left       = 10
134:                 .Top        = 15
135:                 .Width      = THISFORM.Width - 20
136:                 .ForeColor  = RGB(0,0,0)
137:                 .Caption    = THISFORM.this_cTituloForm
138:                 .Visible    = .T.
139:             ENDWITH
140: 
141:             .AddObject("lbl_4c_Titulo", "Label")
142:             WITH .lbl_4c_Titulo
143:                 .AutoSize   = .F.
144:                 .FontBold   = .T.
145:                 .FontName   = "Tahoma"
146:                 .FontSize   = 16
147:                 .BackStyle  = 0
148:                 .Alignment  = 0
149:                 .Height     = 46
150:                 .Left       = 10
151:                 .Top        = 18
152:                 .Width      = THISFORM.Width - 20
153:                 .ForeColor  = RGB(255,255,255)
154:                 .Caption    = THISFORM.this_cTituloForm
155:                 .Visible    = .T.
156:             ENDWITH
157:         ENDWITH
158: 
159:         *-- Container Botoes CRUD (lado direito, Top=0+29=29)
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        = 542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackStyle   = 1
167:             .BackColor   = RGB(53,53,53)
168:             .BorderWidth = 0
169:             .Visible     = .T.
170: 
171:             .AddObject("cmd_4c_Incluir", "CommandButton")
172:             WITH .cmd_4c_Incluir
173:                 .Top             = 5
174:                 .Left            =  542
175:                 .Width           = 75
176:                 .Height          = 75
177:                 .Caption         = "Incluir"
178:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:                 .FontName        = "Tahoma"
180:                 .FontBold        = .T.
181:                 .FontItalic      = .T.
182:                 .FontSize        = 8

*-- Linhas 189 a 203:
189:                 .AutoSize        = .F.
190:             ENDWITH
191: 
192:             .AddObject("cmd_4c_Visualizar", "CommandButton")
193:             WITH .cmd_4c_Visualizar
194:                 .Top             = 5
195:                 .Left            =  542
196:                 .Width           = 75
197:                 .Height          = 75
198:                 .Caption         = "Visualizar"
199:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
200:                 .FontName        = "Tahoma"
201:                 .FontBold        = .T.
202:                 .FontItalic      = .T.
203:                 .FontSize        = 8

*-- Linhas 212 a 226:
212:                 .Enabled         = .F.
213:             ENDWITH
214: 
215:             .AddObject("cmd_4c_Alterar", "CommandButton")
216:             WITH .cmd_4c_Alterar
217:                 .Top             = 5
218:                 .Left            =  542
219:                 .Width           = 75
220:                 .Height          = 75
221:                 .Caption         = "Alterar"
222:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
223:                 .FontName        = "Tahoma"
224:                 .FontBold        = .T.
225:                 .FontItalic      = .T.
226:                 .FontSize        = 8

*-- Linhas 235 a 249:
235:                 .Enabled         = .F.
236:             ENDWITH
237: 
238:             .AddObject("cmd_4c_Excluir", "CommandButton")
239:             WITH .cmd_4c_Excluir
240:                 .Top             = 5
241:                 .Left            =  542
242:                 .Width           = 75
243:                 .Height          = 75
244:                 .Caption         = "Excluir"
245:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
246:                 .FontName        = "Tahoma"
247:                 .FontBold        = .T.
248:                 .FontItalic      = .T.
249:                 .FontSize        = 8

*-- Linhas 258 a 272:
258:                 .Enabled         = .F.
259:             ENDWITH
260: 
261:             .AddObject("cmd_4c_Buscar", "CommandButton")
262:             WITH .cmd_4c_Buscar
263:                 .Top             = 5
264:                 .Left            =  542
265:                 .Width           = 75
266:                 .Height          = 75
267:                 .Caption         = "Buscar"
268:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
269:                 .FontName        = "Tahoma"
270:                 .FontBold        = .T.
271:                 .FontItalic      = .T.
272:                 .FontSize        = 8

*-- Linhas 281 a 312:
281:             ENDWITH
282:         ENDWITH
283: 
284:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
285:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
286:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
287:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
288:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
289: 
290:         *-- Container Encerrar (padrao canonico: Left=917, Width=90)
291:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
292:         WITH loc_oPagina.cnt_4c_Saida
293:             .Top         = 29
294:             .Left        = 917
295:             .Width       = 90
296:             .Height      = 85
297:             .BackStyle   = 0
298:             .BorderWidth = 0
299:             .Visible     = .T.
300: 
301:             .AddObject("cmd_4c_Encerrar", "CommandButton")
302:             WITH .cmd_4c_Encerrar
303:                 .Top             = 5
304:                 .Left            = 917
305:                 .Width           = 75
306:                 .Height          = 75
307:                 .Caption         = "Encerrar"
308:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
309:                 .FontName        = "Tahoma"
310:                 .FontBold        = .T.
311:                 .FontItalic      = .T.
312:                 .FontSize        = 8

*-- Linhas 320 a 334:
320:             ENDWITH
321:         ENDWITH
322: 
323:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
324: 
325:         *-- Grid de Lista (Top=88+29=117)
326:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
327:         WITH loc_oPagina.grd_4c_Lista
328:             .Top                = 117
329:             .Left               = 26
330:             .Width              = 890
331:             .Height             = 468
332:             .FontName           = "Verdana"
333:             .FontSize           = 8
334:             .ForeColor          = RGB(90,90,90)

*-- Linhas 362 a 431:
362:         *-- Container Cabecalho Page2 (cinza opaco, Top=2+29=31)
363:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
364:         WITH loc_oPagina.cnt_4c_Cabecalho
365:             .Top         = 31
366:             .Left        = 0
367:             .Width       = THISFORM.Width
368:             .Height      = 80
369:             .BackStyle   = 1
370:             .BackColor   = RGB(100,100,100)
371:             .BorderWidth = 0
372:             .Visible     = .T.
373: 
374:             .AddObject("lbl_4c_Sombra", "Label")
375:             WITH .lbl_4c_Sombra
376:                 .AutoSize  = .F.
377:                 .FontBold  = .T.
378:                 .FontName  = "Tahoma"
379:                 .FontSize  = 16
380:                 .BackStyle = 0
381:                 .Alignment = 0
382:                 .Height    = 40
383:                 .Left      = 10
384:                 .Top       = 15
385:                 .Width     = THISFORM.Width - 20
386:                 .ForeColor = RGB(0,0,0)
387:                 .Caption   = THISFORM.this_cTituloForm
388:                 .Visible   = .T.
389:             ENDWITH
390: 
391:             .AddObject("lbl_4c_Titulo", "Label")
392:             WITH .lbl_4c_Titulo
393:                 .AutoSize  = .F.
394:                 .FontBold  = .T.
395:                 .FontName  = "Tahoma"
396:                 .FontSize  = 16
397:                 .BackStyle = 0
398:                 .Alignment = 0
399:                 .Height    = 46
400:                 .Left      = 10
401:                 .Top       = 18
402:                 .Width     = THISFORM.Width - 20
403:                 .ForeColor = RGB(255,255,255)
404:                 .Caption   = THISFORM.this_cTituloForm
405:                 .Visible   = .T.
406:             ENDWITH
407:         ENDWITH
408: 
409:         *-- Container Botoes de Acao (Confirmar/Cancelar) - Top=4+29=33
410:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
411:         WITH loc_oPagina.cnt_4c_BotoesAcao
412:             .Top         = 33
413:             .Left        = 842
414:             .Width       = 160
415:             .Height      = 85
416:             .BackStyle   = 0
417:             .BorderWidth = 0
418:             .Visible     = .T.
419: 
420:             .AddObject("cmd_4c_Confirmar", "CommandButton")
421:             WITH .cmd_4c_Confirmar
422:                 .Top             = 5
423:                 .Left            = 5
424:                 .Width           = 75
425:                 .Height          = 75
426:                 .Caption         = "Confirmar"
427:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
428:                 .FontName        = "Tahoma"
429:                 .FontBold        = .T.
430:                 .FontItalic      = .T.
431:                 .FontSize        = 8

*-- Linhas 438 a 452:
438:                 .AutoSize        = .F.
439:             ENDWITH
440: 
441:             .AddObject("cmd_4c_Cancelar", "CommandButton")
442:             WITH .cmd_4c_Cancelar
443:                 .Top             = 5
444:                 .Left            = 80
445:                 .Width           = 75
446:                 .Height          = 75
447:                 .Caption         = "Encerrar"
448:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
449:                 .FontName        = "Tahoma"
450:                 .FontBold        = .T.
451:                 .FontItalic      = .T.
452:                 .FontSize        = 8

*-- Linhas 461 a 491:
461:             ENDWITH
462:         ENDWITH
463: 
464:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, ;
465:                   "Click", THIS, "BtnSalvarClick")
466:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, ;
467:                   "Click", THIS, "BtnCancelarClick")
468: 
469:         *-- Container Encerrar Page2 (padrao canonico: Left=917, Width=90)
470:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
471:         WITH loc_oPagina.cnt_4c_Saida
472:             .Top         = 29
473:             .Left        = 917
474:             .Width       = 90
475:             .Height      = 85
476:             .BackStyle   = 0
477:             .BorderWidth = 0
478:             .Visible     = .T.
479: 
480:             .AddObject("cmd_4c_Encerrar", "CommandButton")
481:             WITH .cmd_4c_Encerrar
482:                 .Top             = 5
483:                 .Left            = 917
484:                 .Width           = 75
485:                 .Height          = 75
486:                 .Caption         = "Encerrar"
487:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
488:                 .FontName        = "Tahoma"
489:                 .FontBold        = .T.
490:                 .FontItalic      = .T.
491:                 .FontSize        = 8

*-- Linhas 499 a 560:
499:             ENDWITH
500:         ENDWITH
501: 
502:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, ;
503:                   "Click", THIS, "BtnEncerrarClick")
504: 
505:         *-- FASE 5: Primeiro campo (50% dos campos) - Tipo
506:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
507:         WITH loc_oPagina.lbl_4c_Tipo
508:             .Top       = 145
509:             .Left      = 30
510:             .Width     = 80
511:             .Height    = 18
512:             .Caption   = "Tipo:"
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .AutoSize  = .F.
516:             .BackStyle = 0
517:             .ForeColor = RGB(90,90,90)
518:             .Visible   = .T.
519:         ENDWITH
520: 
521:         loc_oPagina.AddObject("txt_4c_Tipos", "TextBox")
522:         WITH loc_oPagina.txt_4c_Tipos
523:             .Top         = 142
524:             .Left        = 115
525:             .Width       = 100
526:             .Height      = 22
527:             .Value       = ""
528:             .MaxLength   = 10
529:             .FontName    = "Tahoma"
530:             .FontSize    = 8
531:             .BackColor   = RGB(255,255,255)
532:             .ForeColor   = RGB(0,0,128)
533:             .BorderStyle = 1
534:             .Visible     = .T.
535:         ENDWITH
536: 
537:         loc_oPagina.AddObject("lbl_4c_Descrs", "Label")
538:         WITH loc_oPagina.lbl_4c_Descrs
539:             .Top       = 175
540:             .Left      = 30
541:             .Width     = 80
542:             .Height    = 18
543:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o:"
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .AutoSize  = .F.
547:             .BackStyle = 0
548:             .ForeColor = RGB(90,90,90)
549:             .Visible   = .T.
550:         ENDWITH
551: 
552:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
553:         WITH loc_oPagina.txt_4c_Descrs
554:             .Top         = 172
555:             .Left        = 115
556:             .Width       = 400
557:             .Height      = 22
558:             .Value       = ""
559:             .MaxLength   = 60
560:             .FontName    = "Tahoma"

*-- Linhas 633 a 642:
633:             loc_oGrid.RecordSource           = "cursor_4c_Lista"
634:             loc_oGrid.Column1.ControlSource  = "cursor_4c_Lista.Tipos"
635:             loc_oGrid.Column2.ControlSource  = "cursor_4c_Lista.Descrs"
636:             loc_oGrid.Column1.Header1.Caption = "Tipo"
637:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
638: 
639:             THIS.FormatarGridLista(loc_oGrid)
640:             loc_lSucesso = .T.
641: 
642:         CATCH TO loc_oErro

*-- Linhas 669 a 679:
669:             loc_lTemRegistro = (RECCOUNT("cursor_4c_Lista") > 0) AND !EOF("cursor_4c_Lista")
670:         ENDIF
671: 
672:         loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
673:         loc_oBotoes.cmd_4c_Alterar.Enabled    = loc_lTemRegistro
674:         loc_oBotoes.cmd_4c_Excluir.Enabled    = loc_lTemRegistro
675:     ENDPROC
676: 
677:     *--------------------------------------------------------------------------
678:     * BtnIncluirClick - vai para Page2 em modo INCLUIR
679:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\SigPrGloTBO.prg):
*====================================================================
* SigPrGloTBO.prg
*
* Business Object para SigPrGloT (Formulario Operacional)
* Herda de BusinessBase
*====================================================================

DEFINE CLASS SigPrGloTBO AS BusinessBase

	*-- Propriedades da entidade
	this_cMensagemErro = ""
	this_cTipos        = ""
	this_cDescrs       = ""

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()

		THIS.this_cTabela     = ""
		THIS.this_cCampoChave = "Tipos"

		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria do registro atual
	*====================================================================
	PROTECTED FUNCTION ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cTipos)
	ENDFUNC

	*====================================================================
	* ValidarDados - Valida dados antes de Inserir/Atualizar
	*====================================================================
	PROTECTED FUNCTION ValidarDados()
		IF EMPTY(ALLTRIM(THIS.this_cTipos))
			MsgAviso("Informe o Tipo.", ;
			         "Valida" + CHR(231) + CHR(227) + "o")
			RETURN .F.
		ENDIF
		IF EMPTY(ALLTRIM(THIS.this_cDescrs))
			MsgAviso("Informe a Descri" + CHR(231) + CHR(227) + "o.", ;
			         "Valida" + CHR(231) + CHR(227) + "o")
			RETURN .F.
		ENDIF
		RETURN .T.
	ENDFUNC

	*====================================================================
	* CarregarDoCursor - Carrega propriedades a partir de cursor
	*====================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cTipos  = TratarNulo(Tipos,  "C")
			THIS.this_cDescrs = TratarNulo(Descrs, "C")
			RETURN .T.
		ENDIF
		RETURN .F.
	ENDPROC

	*====================================================================
	* Inserir - Form operacional sem tabela de destino
	*====================================================================
	FUNCTION Inserir()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF THIS.ValidarDados()
				THIS.RegistrarAuditoria("I")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

	*====================================================================
	* Atualizar - Form operacional sem tabela de destino
	*====================================================================
	FUNCTION Atualizar()
		LOCAL loc_lSucesso, loc_oErro
		loc_lSucesso = .F.

		TRY
			IF THIS.ValidarDados()
				THIS.RegistrarAuditoria("A")
				loc_lSucesso = .T.
			ENDIF
		CATCH TO loc_oErro
			MsgErro(loc_oErro.Message, "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDFUNC

ENDDEFINE

