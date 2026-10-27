# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [METODO-INEXISTENTE] Metodo 'THIS.DispararLookup()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).
- [LAYOUT-POSITION] Controle 'Imagem' (parent: SIGOPCGP.fld_principal.Pag_Resultado.Result.Selecao): Top original=15 vs migrado 'lbl_4c_Imagem' Top=108 (diff=93px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Imagem' (parent: SIGOPCGP.fld_principal.Pag_Resultado.Result.Selecao): Left original=230 vs migrado 'lbl_4c_Imagem' Left=666 (diff=436px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopcgp.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (5896 linhas total):

*-- Linhas 39 a 146:
39:   this_nPageAtual         = 1
40: 
41:   *------------------------------------------------------------
42:   PROCEDURE Init
43:     RETURN DODEFAULT()
44:   ENDPROC
45: 
46:   *------------------------------------------------------------
47:   PROTECTED PROCEDURE InicializarForm
48:     LOCAL loc_lSucesso
49:     loc_lSucesso = .F.
50:     TRY
51:       THIS.this_oBusinessObject = CREATEOBJECT("sigopcgpBO")
52:       IF VARTYPE(THIS.this_oBusinessObject) = "O"
53:         THIS.this_cPrompt = THIS.Caption
54:         THIS.InicializarCursores()
55:         THIS.ConfigurarPageFrame()
56:         THIS.pgf_4c_1.Page1.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
57:         BINDEVENT(THIS.pgf_4c_1.Page1.grp_4c_Operacao,       "Click", THIS, "GrpOperacaoClick")
58:         BINDEVENT(THIS.pgf_4c_1.Page1.grp_4c_LimparFiltros,  "Click", THIS, "GrpLimparFiltrosClick")
59: 
60:         *-- Grid AfterRowColChange para carregar detalhes do produto selecionado
61:         BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.grd_4c_Produtos, ;
62:           "AfterRowColChange", THIS, "GrdProdutosAfterRowColChange")
63: 
64:         *-- Inicializar combos de filtro
65:         THIS.PopularCombos()
66:         *-- Criar botao Voltar na pagina de resultado
67:         THIS.ConfigurarBtnVoltar()
68:         BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao.cmd_4c_Salvar,   "Click", THIS, "BtnSalvarClick")
69:         BINDEVENT(THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
70:         *-- Carregar dados iniciais dos grids de filtro
71:         THIS.CarregarCaracteristicas()
72:         THIS.CarregarTiposOperacao()
73: 
74:         loc_lSucesso = .T.
75:       ELSE
76:         MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio.", "Erro")
77:       ENDIF
78:     CATCH TO loc_oErro
79:       MsgErro("Erro ao inicializar: " + loc_oErro.Message, "Erro")
80:     ENDTRY
81:     RETURN loc_lSucesso
82:   ENDPROC
83: 
84:   *------------------------------------------------------------
85:   PROTECTED PROCEDURE ConfigurarPageFrame
86:     *-- PageFrame principal (fld_principal) - 2 paginas: Consulta e Resultado
87:     THIS.AddObject("pgf_4c_1", "PageFrame")
88:     WITH THIS.pgf_4c_1
89:       .Top         = 0
90:       .Left        = 0
91:       .Width       = 1005
92:       .Height      = 616
93:       .PageCount   = 2
94:       .Tabs        = .F.
95:     ENDWITH
96: 
97:     THIS.ConfigurarPaginaConsulta()
98:     THIS.ConfigurarPaginaLista()
99:     THIS.ConfigurarPaginaResultado()
100:     THIS.ConfigurarPaginaDados()
101: 
102:     THIS.pgf_4c_1.Visible = .T.
103:   ENDPROC
104: 
105:   *------------------------------------------------------------
106:   PROTECTED PROCEDURE ConfigurarPaginaConsulta
107:     *-- Page1 = pagina de filtros/consulta
108:     WITH THIS.pgf_4c_1.Page1
109:       .Caption   = ""
110:       .BackColor = RGB(236, 233, 216)
111: 
112:       *-- Container titulo (cntSombra) - barra de titulo azul
113:       .AddObject("cnt_4c_Sombra", "Container")
114:       WITH .cnt_4c_Sombra
115:         .Top         = 0
116:         .Left        = 0
117:         .Width       = THIS.Width
118:         .Height      = 28
119:         .BackColor   = RGB(0, 0, 128)
120:         .BorderWidth = 0
121:         .Visible     = .T.
122: 
123:         .AddObject("lbl_4c_Titulo", "Label")
124:         WITH .lbl_4c_Titulo
125:           .Top       = 4
126:           .Left      = 4
127:           .Width     = THIS.Width
128:           .Height    = 20
129:           .Caption   = "Pesquisa Global de Produtos"
130:           .FontName  = "Tahoma"
131:           .FontSize  = 10
132:           .FontBold  = .T.
133:           .ForeColor = RGB(255, 255, 255)
134:           .BackStyle = 0
135:           .AutoSize  = .F.
136:         ENDWITH
137:       ENDWITH
138: 
139:       *-- CommandGroup de operacoes (grp_operacao): Consultar + Cancelar
140:       .AddObject("grp_4c_Operacao", "CommandGroup")
141:       WITH .grp_4c_Operacao
142:         .Top         = -3
143:         .Left        = 844
144:         .Height      = 85
145:         .Width       = 160
146:         .ButtonCount = 2

*-- Linhas 214 a 257:
214:   ENDPROC
215: 
216:   *------------------------------------------------------------
217:   PROTECTED PROCEDURE ConfigurarPaginaResultado
218:     *-- Page2 = pagina de resultados com 6 sub-paginas
219:     WITH THIS.pgf_4c_1.Page2
220:       .Caption   = ""
221:       .BackColor = RGB(236, 233, 216)
222: 
223:       *-- Label TxtCaption (legenda da consulta)
224:       .AddObject("lbl_4c_TxtCaption", "Label")
225:       WITH .lbl_4c_TxtCaption
226:         .Top       = 0
227:         .Left      = 0
228:         .Width     = 1000
229:         .Height    = 17
230:         .Caption   = ""
231:         .FontName  = "Tahoma"
232:         .FontSize  = 8
233:         .BackStyle = 0
234:         .ForeColor = RGB(0, 0, 0)
235:         .AutoSize  = .F.
236:       ENDWITH
237: 
238:       *-- PageFrame de resultados (Result) - 6 sub-paginas com abas
239:       .AddObject("pgf_4c_Result", "PageFrame")
240:       WITH .pgf_4c_Result
241:         .Top         = 17
242:         .Left        = 0
243:         .Width       = 1000
244:         .Height      = 590
245:         .PageCount   = 6
246:         .Tabs        = .T.
247:       ENDWITH
248: 
249:       *-- PageOrder 1: Selecao/Filtro Produtos
250:       WITH .pgf_4c_Result.Page1
251:         .Caption   = "Sele" + CHR(231) + CHR(227) + "o"
252:         .BackColor = RGB(236, 233, 216)
253:       ENDWITH
254: 
255:       *-- PageOrder 2: Custo
256:       WITH .pgf_4c_Result.Page2
257:         .Caption   = "Custo"

*-- Linhas 285 a 328:
285:   ENDPROC
286: 
287:   *------------------------------------------------------------
288:   PROTECTED PROCEDURE InicializarCursores
289:     *-- Validacao de UI nao executa SQL - apenas cria placeholders
290:     IF NOT USED("cursor_4c_Dados")
291:       SET NULL ON
292:       CREATE CURSOR cursor_4c_Dados ;
293:         (cpros  C(15), dpros  C(60), cgrus  C(5),  ;
294:          dgrus  C(40), cmoes  C(3),  price  N(18,4),;
295:          qatua  N(18,4), ativo L)
296:       SET NULL OFF
297:     ENDIF
298: 
299:     IF NOT USED("CsMatPrima")
300:       SET NULL ON
301:       CREATE CURSOR CsMatPrima ;
302:         (mats C(15), dcompos C(60), qtd_inicial N(18,4), ;
303:          qtd_final N(18,4), apenas L, Cgrus C(5), Tipos C(10))
304:       SET NULL OFF
305:     ENDIF
306: 
307:     IF NOT USED("cursor_4c_Caract")
308:       SET NULL ON
309:       CREATE CURSOR cursor_4c_Caract ;
310:         (marcado L, cods C(5), descs C(40))
311:       SET NULL OFF
312:     ENDIF
313: 
314:     IF NOT USED("cursor_4c_TOpe")
315:       SET NULL ON
316:       CREATE CURSOR cursor_4c_TOpe ;
317:         (marcado L, ctipo C(5), dtipo C(40))
318:       SET NULL OFF
319:     ENDIF
320: 
321:     IF NOT USED("CrSigMvHst")
322:       SET NULL ON
323:       CREATE CURSOR CrSigMvHst ;
324:         (cpros C(15), dtmov D, qtmov N(18,4), vlmov N(18,4))
325:       SET NULL OFF
326:     ENDIF
327: 
328:     IF NOT USED("CsEtiqueta")

*-- Linhas 347 a 404:
347:   ENDPROC
348: 
349:   *------------------------------------------------------------
350:   PROCEDURE CarregarDados
351:     THIS.BtnConsultarClick()
352:   ENDPROC
353: 
354:   *------------------------------------------------------------
355:   PROCEDURE BtnConsultarClick
356:     LOCAL loc_oPag, loc_oFiltros, loc_lSucesso, loc_cCaption
357:     LOCAL loc_cPesoI, loc_cPesoF, loc_cCustoI, loc_cCustoF
358: 
359:     loc_oPag     = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
360:     loc_lSucesso = .F.
361: 
362:     TRY
363:       *-- Cria objeto de filtros
364:       loc_oFiltros = CREATEOBJECT("Empty")
365: 
366:       *-- Produto / Descricao
367:       ADDPROPERTY(loc_oFiltros, "cProdutoInicial",     ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value))
368:       ADDPROPERTY(loc_oFiltros, "cProdutoFinal",       ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value))
369:       ADDPROPERTY(loc_oFiltros, "cDescricao",          ALLTRIM(loc_oPag.txt_4c_Descricao.Value))
370:       ADDPROPERTY(loc_oFiltros, "cDescritivo",         ALLTRIM(loc_oPag.txt_4c_Descritivo.Value))
371: 
372:       *-- Equivalente (so usa se checkbox marcado)
373:       ADDPROPERTY(loc_oFiltros, "cEquivalente", ;
374:         IIF(loc_oPag.chk_4c_Equiv.Value = 1, ALLTRIM(loc_oPag.txt_4c_Equiv.Value), ""))
375: 
376:       *-- Grupo / SubGrupo / Grande Grupo
377:       ADDPROPERTY(loc_oFiltros, "cGrandeGrupoCod",     ALLTRIM(loc_oPag.txt_4c_Gde.Value))
378:       ADDPROPERTY(loc_oFiltros, "cGrupoCod",           ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value))
379:       ADDPROPERTY(loc_oFiltros, "cSubgrupoCod",        ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value))
380: 
381:       *-- Linha / Colecao
382:       ADDPROPERTY(loc_oFiltros, "cLinha",              ALLTRIM(loc_oPag.txt_4c_LinhaI.Value))
383:       ADDPROPERTY(loc_oFiltros, "cLinha2",             ALLTRIM(loc_oPag.txt_4c_LinhaF.Value))
384:       ADDPROPERTY(loc_oFiltros, "cColuna",             ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value))
385:       ADDPROPERTY(loc_oFiltros, "cColuna2",            ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value))
386: 
387:       *-- Fornecedor / Referencia
388:       ADDPROPERTY(loc_oFiltros, "cFornecedorCod",      ALLTRIM(loc_oPag.txt_4c_CdFornec.Value))
389:       ADDPROPERTY(loc_oFiltros, "cRefFornecedor",      ALLTRIM(loc_oPag.txt_4c_RefFornec.Value))
390:       ADDPROPERTY(loc_oFiltros, "cRefFornecedorFinal", ALLTRIM(loc_oPag.txt_4c_RefFornecF.Value))
391:       ADDPROPERTY(loc_oFiltros, "nOptTipoRef",         loc_oPag.opt_4c_TpReffs.Value)
392: 
393:       *-- Cor / Faixa Valor / Classificacao
394:       ADDPROPERTY(loc_oFiltros, "cCorCod",             ALLTRIM(loc_oPag.txt_4c_Cor.Value))
395:       ADDPROPERTY(loc_oFiltros, "cFxPreco",            ALLTRIM(loc_oPag.txt_4c_FxPreco.Value))
396:       ADDPROPERTY(loc_oFiltros, "cClassificacao",      ALLTRIM(loc_oPag.txt_4c_Classe.Value))
397: 
398:       *-- Lista de Precos / Promocao
399:       ADDPROPERTY(loc_oFiltros, "cListaPrecos",        ALLTRIM(loc_oPag.txt_4c_Lista.Value))
400:       ADDPROPERTY(loc_oFiltros, "cPromocao",           ALLTRIM(loc_oPag.txt_4c_Promo.Value))
401: 
402:       *-- Situacao / Imagem (0=Todos)
403:       ADDPROPERTY(loc_oFiltros, "nSituacao",           loc_oPag.cmb_4c_Situas.ListIndex)
404:       ADDPROPERTY(loc_oFiltros, "nImagem",             loc_oPag.cmb_4c_Imagem.ListIndex)

*-- Linhas 459 a 631:
459:         IF !EMPTY(THIS.this_oBusinessObject.this_cMensagemErro)
460:           MsgErro(THIS.this_oBusinessObject.this_cMensagemErro, "Erro")
461:         ELSE
462:           MsgAviso("Nenhum produto encontrado com os filtros informados.")
463:         ENDIF
464:       ENDIF
465: 
466:     CATCH TO loc_oErro
467:       THIS.MousePointer = 0
468:       MsgErro("Erro na consulta: " + loc_oErro.Message, "Erro")
469:     ENDTRY
470: 
471:     loc_oFiltros = .NULL.
472:   ENDPROC
473: 
474:   *------------------------------------------------------------
475:   *-- BtnCancelarClick: cancela edicao de preco (restaura ReadOnly nos campos de preco)
476:   PROCEDURE BtnCancelarClick
477:     LOCAL loc_oCab
478:     TRY
479:       loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
480:       loc_oCab.txt_4c_PrVendaR.ReadOnly   = .T.
481:       loc_oCab.txt_4c_MoePrVR.ReadOnly    = .T.
482:       loc_oCab.txt_4c_PesoMedioR.ReadOnly = .T.
483:       loc_oCab.txt_4c_FatorVR.ReadOnly    = .T.
484:       loc_oCab.txt_4c_MoeFatorR.ReadOnly  = .T.
485:       loc_oCab = .NULL.
486:     CATCH TO loc_oErro
487:       *-- INTENCIONAL: cnt_4c_Cabecalho pode nao estar instanciado ainda; ReadOnly e melhor-esforco
488:     ENDTRY
489:     THIS.this_lAlteraPreco = .F.
490:     THIS.AjustarBotoesPorModo()
491:   ENDPROC
492: 
493:   *------------------------------------------------------------
494:   *-- TornarControlesVisiveis: exclui containers flutuantes (Visible=.F.)
495:   PROCEDURE TornarControlesVisiveis(par_oContainer)
496:     LOCAL loc_i, loc_j, loc_oCtrl, loc_cNome
497:     IF VARTYPE(par_oContainer) # "O"
498:       RETURN
499:     ENDIF
500:     FOR loc_i = 1 TO par_oContainer.ControlCount
501:       loc_oCtrl = par_oContainer.Controls(loc_i)
502:       loc_cNome = UPPER(loc_oCtrl.Name)
503: 
504:       *-- Containers flutuantes permanecem Visible=.F. (mostrados via botoes)
505:       IF INLIST(loc_cNome, ;
506:           "CNT_4C_PRECO",    ;
507:           "CNT_4C_ZOOM",     ;
508:           "CNT_4C_FILTROS",  ;
509:           "CNT_4C_ETIQUETA", ;
510:           "CNT_4C_DETALHE")
511:         LOOP
512:       ENDIF
513: 
514:       *-- Indicador "Produto Descontinuado": nasce oculto e so aparece quando
515:       *-- o produto selecionado esta descontinuado (situas = 2).
516:       IF INLIST(loc_cNome, "SHP_4C_DESCONTINUADO", "LBL_4C_DESCONTINUADO")
517:         *-- Container preserva estado inicial, mas recursar para sub-controles Visible=.T.
518:         IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
519:             THIS.TornarControlesVisiveis(loc_oControl)
520:         ENDIF
521:         LOOP
522:       ENDIF
523: 
524:       loc_oCtrl.Visible = .T.
525: 
526:       *-- Recursao em Containers
527:       IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
528:         IF loc_oCtrl.ControlCount > 0
529:           THIS.TornarControlesVisiveis(loc_oCtrl)
530:         ENDIF
531:       ENDIF
532: 
533:       *-- Recursao em Pages de PageFrame
534:       IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
535:         FOR loc_j = 1 TO loc_oCtrl.PageCount
536:           THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
537:         ENDFOR
538:       ENDIF
539:     ENDFOR
540:     loc_oCtrl = .NULL.
541:   ENDPROC
542: 
543:   *------------------------------------------------------------
544:   PROCEDURE Destroy
545:     *-- Liberar todos os cursores utilizados pelo form
546:     LOCAL loc_aCursores(15), loc_i
547:     loc_aCursores(1)  = "cursor_4c_Dados"
548:     loc_aCursores(2)  = "CsMatPrima"
549:     loc_aCursores(3)  = "CrSigCdPro"
550:     loc_aCursores(4)  = "CrSigMvEst"
551:     loc_aCursores(5)  = "CrSigOpEtq1"
552:     loc_aCursores(6)  = "CrSigPrCpo"
553:     loc_aCursores(7)  = "CrSigMvHst"
554:     loc_aCursores(8)  = "CrSigMvEtr"
555:     loc_aCursores(9)  = "CrProdutos"
556:     loc_aCursores(10) = "TotGrupo2"
557:     loc_aCursores(11) = "CsFase"
558:     loc_aCursores(12) = "CsEtiqueta"
559:     loc_aCursores(13) = "crProEtqEqs"
560:     loc_aCursores(14) = "cursor_4c_Caract"
561:     loc_aCursores(15) = "cursor_4c_TOpe"
562: 
563:     FOR loc_i = 1 TO 15
564:       IF USED(loc_aCursores(loc_i))
565:         USE IN (loc_aCursores(loc_i))
566:       ENDIF
567:     ENDFOR
568: 
569:     *-- Liberar objeto de negocio
570:     THIS.this_oBusinessObject = .NULL.
571: 
572:     DODEFAULT()
573:   ENDPROC
574: 
575:   *------------------------------------------------------------
576:   PROCEDURE AlternarPagina(par_nPagina)
577:     THIS.pgf_4c_1.ActivePage = par_nPagina
578:   ENDPROC
579: 
580:   *------------------------------------------------------------
581:   PROCEDURE GrpOperacaoClick
582:     DO CASE
583:     CASE THIS.pgf_4c_1.Page1.grp_4c_Operacao.Value = 1
584:       THIS.BtnConsultarClick()
585:     CASE THIS.pgf_4c_1.Page1.grp_4c_Operacao.Value = 2
586:       THIS.BtnEncerrarClick()
587:     ENDCASE
588:   ENDPROC
589: 
590:   *------------------------------------------------------------
591:   PROTECTED PROCEDURE ConfigurarPaginaLista
592:     LOCAL loc_oPag
593:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
594: 
595:     *-- Separador horizontal (sh_Refs)
596:     loc_oPag.AddObject("shp_4c_Refs", "Shape")
597:     WITH loc_oPag.shp_4c_Refs
598:       .Top         = 481
599:       .Left        = 8
600:       .Height      = 1
601:       .Width       = 981
602:       .BorderStyle = 1
603:       .BorderWidth = 2
604:       .BackStyle   = 0
605:     ENDWITH
606: 
607:     *== LINHA 1: Produto inicial/final + Equivalente + Situacao + Imagem ==
608:     loc_oPag.AddObject("lbl_4c_Produto", "Label")
609:     WITH loc_oPag.lbl_4c_Produto
610:       .Top       = 84
611:       .Left      = 66
612:       .Width     = 47
613:       .Height    = 15
614:       .Caption   = "\<Produto :"
615:       .FontName  = "Tahoma"
616:       .FontSize  = 8
617:       .BackStyle = 0
618:     ENDWITH
619: 
620:     loc_oPag.AddObject("txt_4c_ProdutoI", "TextBox")
621:     WITH loc_oPag.txt_4c_ProdutoI
622:       .Top           = 80
623:       .Left          = 117
624:       .Width         = 126
625:       .Height        = 22
626:       .FontName      = "Tahoma"
627:       .FontSize      = 8
628:       .MaxLength     = 14
629:       .Format        = "K!"
630:       .BorderStyle   = 1
631:       .SpecialEffect = 1

*-- Linhas 1579 a 1622:
1579:     ENDWITH
1580: 
1581:     *-- OptTpDtCad (Alt/Inc)
1582:     loc_oPag.AddObject("opt_4c_TpDtCad", "OptionGroup")
1583:     loc_oPag.opt_4c_TpDtCad.Top         = 271
1584:     loc_oPag.opt_4c_TpDtCad.Left        = 708
1585:     loc_oPag.opt_4c_TpDtCad.Width       = 81
1586:     loc_oPag.opt_4c_TpDtCad.Height      = 24
1587:     loc_oPag.opt_4c_TpDtCad.ButtonCount = 2
1588:     loc_oPag.opt_4c_TpDtCad.BorderStyle = 0
1589:     loc_oPag.opt_4c_TpDtCad.BackStyle   = 0
1590:     loc_oPag.opt_4c_TpDtCad.Value       = 1
1591:     WITH loc_oPag.opt_4c_TpDtCad.Buttons(1)
1592:       .Caption  = "Alt"
1593:       .BackStyle = 0
1594:       .Top      = 2
1595:       .Left     = 2
1596:       .Width    = 35
1597:       .Height   = 20
1598:       .AutoSize = .F.
1599:     ENDWITH
1600:     WITH loc_oPag.opt_4c_TpDtCad.Buttons(2)
1601:       .Caption  = "Inc"
1602:       .BackStyle = 0
1603:       .Top      = 2
1604:       .Left     = 39
1605:       .Width    = 35
1606:       .Height   = 20
1607:       .AutoSize = .F.
1608:     ENDWITH
1609: 
1610:     *-- Dimensao Profundidade
1611:     loc_oPag.AddObject("lbl_4c_Profund", "Label")
1612:     WITH loc_oPag.lbl_4c_Profund
1613:       .Top       = 275
1614:       .Left      = 828
1615:       .Width     = 55
1616:       .Height    = 15
1617:       .Caption   = "Profund. :"
1618:       .FontName  = "Tahoma"
1619:       .FontSize  = 8
1620:       .BackStyle = 0
1621:     ENDWITH
1622: 

*-- Linhas 1812 a 1855:
1812:     ENDWITH
1813: 
1814:     *-- Opt_TpReffs (Similar/Equivalente/Todos)
1815:     loc_oPag.AddObject("opt_4c_TpReffs", "OptionGroup")
1816:     loc_oPag.opt_4c_TpReffs.Top         = 336
1817:     loc_oPag.opt_4c_TpReffs.Left        = 377
1818:     loc_oPag.opt_4c_TpReffs.Width       = 187
1819:     loc_oPag.opt_4c_TpReffs.Height      = 23
1820:     loc_oPag.opt_4c_TpReffs.ButtonCount = 3
1821:     loc_oPag.opt_4c_TpReffs.BorderStyle = 0
1822:     loc_oPag.opt_4c_TpReffs.BackStyle   = 0
1823:     loc_oPag.opt_4c_TpReffs.Value       = 3
1824:     WITH loc_oPag.opt_4c_TpReffs.Buttons(1)
1825:       .Caption  = "Similar"
1826:       .BackStyle = 0
1827:       .Top      = 2
1828:       .Left     = 2
1829:       .Width    = 58
1830:       .Height   = 19
1831:       .AutoSize = .F.
1832:     ENDWITH
1833:     WITH loc_oPag.opt_4c_TpReffs.Buttons(2)
1834:       .Caption  = "Equivalente"
1835:       .BackStyle = 0
1836:       .Top      = 2
1837:       .Left     = 62
1838:       .Width    = 65
1839:       .Height   = 19
1840:       .AutoSize = .F.
1841:     ENDWITH
1842:     WITH loc_oPag.opt_4c_TpReffs.Buttons(3)
1843:       .Caption  = "Todos"
1844:       .BackStyle = 0
1845:       .Top      = 2
1846:       .Left     = 129
1847:       .Width    = 55
1848:       .Height   = 19
1849:       .AutoSize = .F.
1850:     ENDWITH
1851: 
1852:     loc_oPag.AddObject("lbl_4c_Conjunto", "Label")
1853:     WITH loc_oPag.lbl_4c_Conjunto
1854:       .Top       = 341
1855:       .Left      = 830

*-- Linhas 2091 a 2134:
2091:       .BackStyle = 0
2092:     ENDWITH
2093: 
2094:     loc_oPag.AddObject("opt_4c_Webs", "OptionGroup")
2095:     loc_oPag.opt_4c_Webs.Top         = 407
2096:     loc_oPag.opt_4c_Webs.Left        = 851
2097:     loc_oPag.opt_4c_Webs.Width       = 132
2098:     loc_oPag.opt_4c_Webs.Height      = 63
2099:     loc_oPag.opt_4c_Webs.ButtonCount = 5
2100:     loc_oPag.opt_4c_Webs.BorderStyle = 0
2101:     loc_oPag.opt_4c_Webs.BackStyle   = 0
2102:     loc_oPag.opt_4c_Webs.Value       = 5
2103:     WITH loc_oPag.opt_4c_Webs.Buttons(1)
2104:       .Caption  = "Sim"
2105:       .BackStyle = 0
2106:       .Top      = 2
2107:       .Left     = 2
2108:       .Width    = 126
2109:       .Height   = 12
2110:       .AutoSize = .F.
2111:     ENDWITH
2112:     WITH loc_oPag.opt_4c_Webs.Buttons(2)
2113:       .Caption  = "N" + CHR(227) + "o"
2114:       .BackStyle = 0
2115:       .Top      = 14
2116:       .Left     = 2
2117:       .Width    = 126
2118:       .Height   = 12
2119:       .AutoSize = .F.
2120:     ENDWITH
2121:     WITH loc_oPag.opt_4c_Webs.Buttons(3)
2122:       .Caption  = "Tudo"
2123:       .BackStyle = 0
2124:       .Top      = 26
2125:       .Left     = 2
2126:       .Width    = 126
2127:       .Height   = 12
2128:       .AutoSize = .F.
2129:     ENDWITH
2130:     WITH loc_oPag.opt_4c_Webs.Buttons(4)
2131:       .Caption  = "Sim/N" + CHR(227) + "o"
2132:       .BackStyle = 0
2133:       .Top      = 38
2134:       .Left     = 2

*-- Linhas 2341 a 2450:
2341:     ENDWITH
2342: 
2343:     *-- OptTpData (Dt Operacao / Dt Cadastro)
2344:     loc_oPag.AddObject("opt_4c_TpData", "OptionGroup")
2345:     loc_oPag.opt_4c_TpData.Top         = 512
2346:     loc_oPag.opt_4c_TpData.Left        = 800
2347:     loc_oPag.opt_4c_TpData.Width       = 187
2348:     loc_oPag.opt_4c_TpData.Height      = 24
2349:     loc_oPag.opt_4c_TpData.ButtonCount = 2
2350:     loc_oPag.opt_4c_TpData.BorderStyle = 0
2351:     loc_oPag.opt_4c_TpData.BackStyle   = 0
2352:     loc_oPag.opt_4c_TpData.Value       = 1
2353:     WITH loc_oPag.opt_4c_TpData.Buttons(1)
2354:       .Caption  = "Dt Opera" + CHR(231) + CHR(227) + "o"
2355:       .BackStyle = 0
2356:       .Top      = 2
2357:       .Left     = 2
2358:       .Width    = 90
2359:       .Height   = 20
2360:       .AutoSize = .F.
2361:     ENDWITH
2362:     WITH loc_oPag.opt_4c_TpData.Buttons(2)
2363:       .Caption  = "Dt Cadastro"
2364:       .BackStyle = 0
2365:       .Top      = 2
2366:       .Left     = 94
2367:       .Width    = 90
2368:       .Height   = 20
2369:       .AutoSize = .F.
2370:     ENDWITH
2371: 
2372:     *-- Filtro de Situacao da Operacao (3 opcoes)
2373:     loc_oPag.AddObject("opt_4c_Operacao", "OptionGroup")
2374:     loc_oPag.opt_4c_Operacao.Top         = 534
2375:     loc_oPag.opt_4c_Operacao.Left        = 615
2376:     loc_oPag.opt_4c_Operacao.Width       = 227
2377:     loc_oPag.opt_4c_Operacao.Height      = 24
2378:     loc_oPag.opt_4c_Operacao.ButtonCount = 3
2379:     loc_oPag.opt_4c_Operacao.BorderStyle = 0
2380:     loc_oPag.opt_4c_Operacao.BackStyle   = 0
2381:     WITH loc_oPag.opt_4c_Operacao.Buttons(1)
2382:       .Caption  = "Pendentes"
2383:       .BackStyle = 0
2384:       .Top      = 2
2385:       .Left     = 2
2386:       .Width    = 72
2387:       .Height   = 20
2388:       .AutoSize = .F.
2389:     ENDWITH
2390:     WITH loc_oPag.opt_4c_Operacao.Buttons(2)
2391:       .Caption  = "Faturados"
2392:       .BackStyle = 0
2393:       .Top      = 2
2394:       .Left     = 76
2395:       .Width    = 72
2396:       .Height   = 20
2397:       .AutoSize = .F.
2398:     ENDWITH
2399:     WITH loc_oPag.opt_4c_Operacao.Buttons(3)
2400:       .Caption  = "Todos"
2401:       .BackStyle = 0
2402:       .Top      = 2
2403:       .Left     = 150
2404:       .Width    = 72
2405:       .Height   = 20
2406:       .AutoSize = .F.
2407:     ENDWITH
2408: 
2409:     *-- Filtro de Situacao do Pagamento (3 opcoes)
2410:     loc_oPag.AddObject("opt_4c_Pagamento", "OptionGroup")
2411:     loc_oPag.opt_4c_Pagamento.Top         = 550
2412:     loc_oPag.opt_4c_Pagamento.Left        = 615
2413:     loc_oPag.opt_4c_Pagamento.Width       = 227
2414:     loc_oPag.opt_4c_Pagamento.Height      = 24
2415:     loc_oPag.opt_4c_Pagamento.ButtonCount = 3
2416:     loc_oPag.opt_4c_Pagamento.BorderStyle = 0
2417:     loc_oPag.opt_4c_Pagamento.BackStyle   = 0
2418:     loc_oPag.opt_4c_Pagamento.Value       = 3
2419:     WITH loc_oPag.opt_4c_Pagamento.Buttons(1)
2420:       .Caption  = "Pagos"
2421:       .BackStyle = 0
2422:       .Top      = 2
2423:       .Left     = 2
2424:       .Width    = 72
2425:       .Height   = 20
2426:       .AutoSize = .F.
2427:     ENDWITH
2428:     WITH loc_oPag.opt_4c_Pagamento.Buttons(2)
2429:       .Caption  = "Pendentes"
2430:       .BackStyle = 0
2431:       .Top      = 2
2432:       .Left     = 76
2433:       .Width    = 72
2434:       .Height   = 20
2435:       .AutoSize = .F.
2436:     ENDWITH
2437:     WITH loc_oPag.opt_4c_Pagamento.Buttons(3)
2438:       .Caption  = "Cancelados"
2439:       .BackStyle = 0
2440:       .Top      = 2
2441:       .Left     = 150
2442:       .Width    = 72
2443:       .Height   = 20
2444:       .AutoSize = .F.
2445:     ENDWITH
2446: 
2447:     *== LINHA 18: Conta Financeira + CPF + Botao Conjuge ==
2448:     loc_oPag.AddObject("lbl_4c_ContaFin", "Label")
2449:     WITH loc_oPag.lbl_4c_ContaFin
2450:       .Top       = 578

*-- Linhas 2518 a 2596:
2518:       .ToolTipText = "Procurar Conta Por C" + CHR(244) + "njuge"
2519:     ENDWITH
2520: 
2521:     *-- BINDEVENTs: Lookups F4 nos campos de filtro
2522:     BINDEVENT(loc_oPag.txt_4c_ProdutoI,  "KeyPress", THIS, "TxtProdutoIKeyPress")
2523:     BINDEVENT(loc_oPag.txt_4c_ProdutoF,  "KeyPress", THIS, "TxtProdutoFKeyPress")
2524:     BINDEVENT(loc_oPag.txt_4c_Equiv,     "KeyPress", THIS, "TxtEquivKeyPress")
2525:     BINDEVENT(loc_oPag.txt_4c_CdGrupo,   "KeyPress", THIS, "TxtCdGrupoKeyPress")
2526:     BINDEVENT(loc_oPag.txt_4c_Gde,       "KeyPress", THIS, "TxtGdeKeyPress")
2527:     BINDEVENT(loc_oPag.txt_4c_CdSGrupo,  "KeyPress", THIS, "TxtCdSGrupoKeyPress")
2528:     BINDEVENT(loc_oPag.txt_4c_Cor,       "KeyPress", THIS, "TxtCorKeyPress")
2529:     BINDEVENT(loc_oPag.txt_4c_LinhaI,    "KeyPress", THIS, "TxtLinhaIKeyPress")
2530:     BINDEVENT(loc_oPag.txt_4c_LinhaF,    "KeyPress", THIS, "TxtLinhaFKeyPress")
2531:     BINDEVENT(loc_oPag.txt_4c_GrupoVI,   "KeyPress", THIS, "TxtGrupoVIKeyPress")
2532:     BINDEVENT(loc_oPag.txt_4c_GrupoVF,   "KeyPress", THIS, "TxtGrupoVFKeyPress")
2533:     BINDEVENT(loc_oPag.txt_4c_MoeCusto,  "KeyPress", THIS, "TxtMoeCustoKeyPress")
2534:     BINDEVENT(loc_oPag.txt_4c_MoeEstim,  "KeyPress", THIS, "TxtMoeEstimKeyPress")
2535:     BINDEVENT(loc_oPag.txt_4c_MoeVenda,  "KeyPress", THIS, "TxtMoeVendaKeyPress")
2536:     BINDEVENT(loc_oPag.txt_4c_CodFinP,   "KeyPress", THIS, "TxtCodFinPKeyPress")
2537:     BINDEVENT(loc_oPag.txt_4c_CodFinPF,  "KeyPress", THIS, "TxtCodFinPFKeyPress")
2538:     BINDEVENT(loc_oPag.txt_4c_Classe,    "KeyPress", THIS, "TxtClasseKeyPress")
2539:     BINDEVENT(loc_oPag.txt_4c_Tam,       "KeyPress", THIS, "TxtTamKeyPress")
2540:     BINDEVENT(loc_oPag.txt_4c_DTam,      "KeyPress", THIS, "TxtDTamKeyPress")
2541:     BINDEVENT(loc_oPag.txt_4c_Categoria, "KeyPress", THIS, "TxtCategoriaKeyPress")
2542:     BINDEVENT(loc_oPag.txt_4c_DCategoria,"KeyPress", THIS, "TxtDCategoriaKeyPress")
2543:     BINDEVENT(loc_oPag.txt_4c_Promo,     "KeyPress", THIS, "TxtPromoKeyPress")
2544:     BINDEVENT(loc_oPag.txt_4c_Lista,     "KeyPress", THIS, "TxtListaKeyPress")
2545:     BINDEVENT(loc_oPag.txt_4c_CdFornec,  "KeyPress", THIS, "TxtCdFornecKeyPress")
2546:     BINDEVENT(loc_oPag.txt_4c_Emps,      "KeyPress", THIS, "TxtEmpsKeyPress")
2547:     BINDEVENT(loc_oPag.txt_4c_GrupoCC,   "KeyPress", THIS, "TxtGrupoCCKeyPress")
2548:     BINDEVENT(loc_oPag.txt_4c_CdConta,   "KeyPress", THIS, "TxtCdContaKeyPress")
2549:     BINDEVENT(loc_oPag.txt_4c_ContaO,    "KeyPress", THIS, "TxtContaOKeyPress")
2550:     BINDEVENT(loc_oPag.txt_4c_EmpsO,     "KeyPress", THIS, "TxtEmpsOKeyPress")
2551: 
2552:     loc_oPag = .NULL.
2553:   ENDPROC
2554: 
2555:   *------------------------------------------------------------
2556:   PROTECTED PROCEDURE ConfigurarGrdComposicao(par_oPag)
2557:     par_oPag.AddObject("grd_4c_Composicao", "Grid")
2558:     par_oPag.grd_4c_Composicao.Top          = 425
2559:     par_oPag.grd_4c_Composicao.Left         = 117
2560:     par_oPag.grd_4c_Composicao.Width        = 722
2561:     par_oPag.grd_4c_Composicao.Height       = 54
2562:     par_oPag.grd_4c_Composicao.ColumnCount  = 7
2563:     par_oPag.grd_4c_Composicao.RecordSource = "CsMatPrima"
2564: 
2565:     WITH par_oPag.grd_4c_Composicao
2566:       .FontName          = "Tahoma"
2567:       .FontSize          = 8
2568:       .DeleteMark        = .F.
2569:       .RecordMark        = .F.
2570:       .ScrollBars        = 2
2571:       .RowHeight         = 18
2572:       .AllowHeaderSizing = .F.
2573:       .AllowRowSizing    = .F.
2574: 
2575:       WITH .Column1
2576:         .Width           = 108
2577:         .ControlSource   = "CsMatPrima.mats"
2578:         .Movable         = .F.
2579:         .Resizable       = .F.
2580:         .Header1.Caption = "Caracter" + CHR(237) + "stica"
2581:         .Header1.Alignment = 2
2582:       ENDWITH
2583: 
2584:       WITH .Column2
2585:         .Width           = 290
2586:         .ControlSource   = "CsMatPrima.dcompos"
2587:         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2588:         .Header1.Alignment = 2
2589:       ENDWITH
2590: 
2591:       WITH .Column3
2592:         .Width           = 80
2593:         .ControlSource   = "CsMatPrima.qtd_inicial"
2594:         .Header1.Caption = "Qtd"
2595:         .Header1.Alignment = 2
2596:       ENDWITH

*-- Linhas 2629 a 2758:
2629:   ENDPROC
2630: 
2631:   *------------------------------------------------------------
2632:   PROTECTED PROCEDURE ConfigurarGrdCaracts(par_oPag)
2633:     par_oPag.AddObject("grd_4c_Caract", "Grid")
2634:     par_oPag.grd_4c_Caract.Top          = 319
2635:     par_oPag.grd_4c_Caract.Left         = 568
2636:     par_oPag.grd_4c_Caract.Width        = 187
2637:     par_oPag.grd_4c_Caract.Height       = 105
2638:     par_oPag.grd_4c_Caract.ColumnCount  = 2
2639:     par_oPag.grd_4c_Caract.RecordSource = "cursor_4c_Caract"
2640: 
2641:     WITH par_oPag.grd_4c_Caract
2642:       .FontName          = "Tahoma"
2643:       .FontSize          = 8
2644:       .DeleteMark        = .F.
2645:       .RecordMark        = .F.
2646:       .ScrollBars        = 2
2647:       .RowHeight         = 17
2648:       .AllowHeaderSizing = .F.
2649:       .AllowRowSizing    = .F.
2650: 
2651:       *-- Column1: CheckBox (marcado)
2652:       .Column1.AddObject("Check1", "CheckBox")
2653:       WITH .Column1
2654:         .Width          = 15
2655:         .CurrentControl = "Check1"
2656:         .Sparse         = .F.
2657:         .ControlSource  = "cursor_4c_Caract.marcado"
2658:         .Header1.Caption = ""
2659:       ENDWITH
2660: 
2661:       WITH .Column2
2662:         .Width           = 150
2663:         .ControlSource   = "cursor_4c_Caract.descs"
2664:         .Header1.Caption = "Caracter" + CHR(237) + "stica"
2665:         .Header1.Alignment = 2
2666:       ENDWITH
2667:     ENDWITH
2668:   ENDPROC
2669: 
2670:   *------------------------------------------------------------
2671:   PROTECTED PROCEDURE ConfigurarGrdTOpe(par_oPag)
2672:     par_oPag.AddObject("grd_4c_TOpe", "Grid")
2673:     par_oPag.grd_4c_TOpe.Top          = 485
2674:     par_oPag.grd_4c_TOpe.Left         = 118
2675:     par_oPag.grd_4c_TOpe.Width        = 360
2676:     par_oPag.grd_4c_TOpe.Height       = 89
2677:     par_oPag.grd_4c_TOpe.ColumnCount  = 3
2678:     par_oPag.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"
2679: 
2680:     WITH par_oPag.grd_4c_TOpe
2681:       .FontName          = "Tahoma"
2682:       .FontSize          = 8
2683:       .DeleteMark        = .F.
2684:       .RecordMark        = .F.
2685:       .ScrollBars        = 2
2686:       .RowHeight         = 17
2687:       .AllowHeaderSizing = .F.
2688:       .AllowRowSizing    = .F.
2689: 
2690:       *-- Column1: CheckBox (marcado)
2691:       .Column1.AddObject("Check1", "CheckBox")
2692:       WITH .Column1
2693:         .Width          = 15
2694:         .CurrentControl = "Check1"
2695:         .Sparse         = .F.
2696:         .ControlSource  = "cursor_4c_TOpe.marcado"
2697:         .Header1.Caption = ""
2698:       ENDWITH
2699: 
2700:       WITH .Column2
2701:         .Width           = 31
2702:         .ControlSource   = "cursor_4c_TOpe.ctipo"
2703:         .Header1.Caption = "C" + CHR(243) + "d"
2704:         .Header1.Alignment = 2
2705:       ENDWITH
2706: 
2707:       WITH .Column3
2708:         .Width           = 290
2709:         .ControlSource   = "cursor_4c_TOpe.dtipo"
2710:         .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2711:         .Header1.Alignment = 2
2712:       ENDWITH
2713:     ENDWITH
2714:   ENDPROC
2715: 
2716:   *------------------------------------------------------------
2717:   *-- Fase 5/8: Page2 (Selecao) - Grid + Cabecalho Parte 1
2718:   PROTECTED PROCEDURE ConfigurarPaginaDados
2719:     LOCAL loc_oPag
2720:     loc_oPag = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1
2721: 
2722:     *-- Grid principal de produtos (grd_produtos)
2723:     loc_oPag.AddObject("grd_4c_Produtos", "Grid")
2724:     loc_oPag.grd_4c_Produtos.RecordSource = "CrProdutos"
2725:     loc_oPag.grd_4c_Produtos.Top          = 5
2726:     loc_oPag.grd_4c_Produtos.Left         = 0
2727:     loc_oPag.grd_4c_Produtos.Width        = 655
2728:     loc_oPag.grd_4c_Produtos.Height       = 275
2729: 
2730:     loc_oPag.grd_4c_Produtos.ColumnCount = 2
2731:     WITH loc_oPag.grd_4c_Produtos
2732:       .FontName          = "Tahoma"
2733:       .FontSize          = 8
2734:       .DeleteMark        = .F.
2735:       .RecordMark        = .F.
2736:       .ScrollBars        = 2
2737:       .RowHeight         = 18
2738:       .AllowHeaderSizing = .F.
2739:       .AllowRowSizing    = .F.
2740:       .ReadOnly          = .T.
2741: 
2742:       WITH .Column1
2743:         .Width             = 108
2744:         .ControlSource     = "CrProdutos.cpros"
2745:         .Movable           = .F.
2746:         .Resizable         = .F.
2747:         .Header1.Caption   = "C" + CHR(243) + "d"
2748:         .Header1.Alignment = 2
2749:       ENDWITH
2750: 
2751:       WITH .Column2
2752:         .Width             = 525
2753:         .ControlSource     = "CrProdutos.dpros"
2754:         .Movable           = .F.
2755:         .Resizable         = .F.
2756:         .Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
2757:         .Header1.Alignment = 2
2758:       ENDWITH

*-- Linhas 3938 a 4784:
3938:   *-- KEYPRESS HANDLERS - Lookup F4 (par_nKeyCode=28 ou 115)
3939:   *============================================================
3940: 
3941:   PROCEDURE TxtProdutoIKeyPress(par_nKeyCode, par_nShiftAlt)
3942:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_ProdutoI")
3943:       THIS.AbrirLookupProduto("I")
3944:     ENDIF
3945:   ENDPROC
3946: 
3947:   PROCEDURE TxtProdutoFKeyPress(par_nKeyCode, par_nShiftAlt)
3948:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_ProdutoF")
3949:       THIS.AbrirLookupProduto("F")
3950:     ENDIF
3951:   ENDPROC
3952: 
3953:   PROCEDURE TxtEquivKeyPress(par_nKeyCode, par_nShiftAlt)
3954:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Equiv")
3955:       THIS.AbrirLookupEquiv()
3956:     ENDIF
3957:   ENDPROC
3958: 
3959:   PROCEDURE TxtCdGrupoKeyPress(par_nKeyCode, par_nShiftAlt)
3960:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdGrupo")
3961:       THIS.AbrirLookupGrupo()
3962:     ENDIF
3963:   ENDPROC
3964: 
3965:   PROCEDURE TxtGdeKeyPress(par_nKeyCode, par_nShiftAlt)
3966:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Gde")
3967:       THIS.AbrirLookupGrandeGrupo()
3968:     ENDIF
3969:   ENDPROC
3970: 
3971:   PROCEDURE TxtCdSGrupoKeyPress(par_nKeyCode, par_nShiftAlt)
3972:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdSGrupo")
3973:       THIS.AbrirLookupSubGrupo()
3974:     ENDIF
3975:   ENDPROC
3976: 
3977:   PROCEDURE TxtCorKeyPress(par_nKeyCode, par_nShiftAlt)
3978:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Cor")
3979:       THIS.AbrirLookupCor()
3980:     ENDIF
3981:   ENDPROC
3982: 
3983:   PROCEDURE TxtLinhaIKeyPress(par_nKeyCode, par_nShiftAlt)
3984:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_LinhaI")
3985:       THIS.AbrirLookupLinha("I")
3986:     ENDIF
3987:   ENDPROC
3988: 
3989:   PROCEDURE TxtLinhaFKeyPress(par_nKeyCode, par_nShiftAlt)
3990:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_LinhaF")
3991:       THIS.AbrirLookupLinha("F")
3992:     ENDIF
3993:   ENDPROC
3994: 
3995:   PROCEDURE TxtGrupoVIKeyPress(par_nKeyCode, par_nShiftAlt)
3996:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_GrupoVI")
3997:       THIS.AbrirLookupGrupoV("I")
3998:     ENDIF
3999:   ENDPROC
4000: 
4001:   PROCEDURE TxtGrupoVFKeyPress(par_nKeyCode, par_nShiftAlt)
4002:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_GrupoVF")
4003:       THIS.AbrirLookupGrupoV("F")
4004:     ENDIF
4005:   ENDPROC
4006: 
4007:   PROCEDURE TxtMoeCustoKeyPress(par_nKeyCode, par_nShiftAlt)
4008:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_MoeCusto")
4009:       THIS.AbrirLookupMoeda("MoeCusto")
4010:     ENDIF
4011:   ENDPROC
4012: 
4013:   PROCEDURE TxtMoeEstimKeyPress(par_nKeyCode, par_nShiftAlt)
4014:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_MoeEstim")
4015:       THIS.AbrirLookupMoeda("MoeEstim")
4016:     ENDIF
4017:   ENDPROC
4018: 
4019:   PROCEDURE TxtMoeVendaKeyPress(par_nKeyCode, par_nShiftAlt)
4020:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_MoeVenda")
4021:       THIS.AbrirLookupMoeda("MoeVenda")
4022:     ENDIF
4023:   ENDPROC
4024: 
4025:   PROCEDURE TxtCodFinPKeyPress(par_nKeyCode, par_nShiftAlt)
4026:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CodFinP")
4027:       THIS.AbrirLookupModeloFin("P")
4028:     ENDIF
4029:   ENDPROC
4030: 
4031:   PROCEDURE TxtCodFinPFKeyPress(par_nKeyCode, par_nShiftAlt)
4032:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CodFinPF")
4033:       THIS.AbrirLookupModeloFin("F")
4034:     ENDIF
4035:   ENDPROC
4036: 
4037:   PROCEDURE TxtClasseKeyPress(par_nKeyCode, par_nShiftAlt)
4038:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Classe")
4039:       THIS.AbrirLookupClasse()
4040:     ENDIF
4041:   ENDPROC
4042: 
4043:   PROCEDURE TxtTamKeyPress(par_nKeyCode, par_nShiftAlt)
4044:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Tam")
4045:       THIS.AbrirLookupTamanho("C")
4046:     ENDIF
4047:   ENDPROC
4048: 
4049:   PROCEDURE TxtDTamKeyPress(par_nKeyCode, par_nShiftAlt)
4050:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_DTam")
4051:       THIS.AbrirLookupTamanho("D")
4052:     ENDIF
4053:   ENDPROC
4054: 
4055:   PROCEDURE TxtCategoriaKeyPress(par_nKeyCode, par_nShiftAlt)
4056:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Categoria")
4057:       THIS.AbrirLookupCategoria("C")
4058:     ENDIF
4059:   ENDPROC
4060: 
4061:   PROCEDURE TxtDCategoriaKeyPress(par_nKeyCode, par_nShiftAlt)
4062:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_DCategoria")
4063:       THIS.AbrirLookupCategoria("D")
4064:     ENDIF
4065:   ENDPROC
4066: 
4067:   PROCEDURE TxtPromoKeyPress(par_nKeyCode, par_nShiftAlt)
4068:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Promo")
4069:       THIS.AbrirLookupPromocao()
4070:     ENDIF
4071:   ENDPROC
4072: 
4073:   PROCEDURE TxtListaKeyPress(par_nKeyCode, par_nShiftAlt)
4074:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Lista")
4075:       THIS.AbrirLookupLista()
4076:     ENDIF
4077:   ENDPROC
4078: 
4079:   PROCEDURE TxtCdFornecKeyPress(par_nKeyCode, par_nShiftAlt)
4080:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdFornec")
4081:       THIS.AbrirLookupFornecedor()
4082:     ENDIF
4083:   ENDPROC
4084: 
4085:   PROCEDURE TxtEmpsKeyPress(par_nKeyCode, par_nShiftAlt)
4086:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_Emps")
4087:       THIS.AbrirLookupEmpresa("Emps", "DsEmps")
4088:     ENDIF
4089:   ENDPROC
4090: 
4091:   PROCEDURE TxtGrupoCCKeyPress(par_nKeyCode, par_nShiftAlt)
4092:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_GrupoCC")
4093:       THIS.AbrirLookupGrupoCC()
4094:     ENDIF
4095:   ENDPROC
4096: 
4097:   PROCEDURE TxtCdContaKeyPress(par_nKeyCode, par_nShiftAlt)
4098:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_CdConta")
4099:       THIS.AbrirLookupContaCC()
4100:     ENDIF
4101:   ENDPROC
4102: 
4103:   PROCEDURE TxtContaOKeyPress(par_nKeyCode, par_nShiftAlt)
4104:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_ContaO")
4105:       THIS.AbrirLookupContaFin()
4106:     ENDIF
4107:   ENDPROC
4108: 
4109:   PROCEDURE TxtEmpsOKeyPress(par_nKeyCode, par_nShiftAlt)
4110:     IF THIS.DispararLookup(par_nKeyCode, "txt_4c_EmpsO")
4111:       THIS.AbrirLookupEmpresa("EmpsO", "")
4112:     ENDIF
4113:   ENDPROC
4114: 
4115:   *------------------------------------------------------------
4116:   *-- DispararLookup: decide se o lookup deve abrir para a tecla recebida.
4117:   *-- F4 (28/115) abre sempre - eh pedido explicito de lista pelo usuario.
4118:   *-- ENTER (13) / TAB (9) reproduzem o PROCEDURE Valid do legado, que so
4119:   *-- consulta quando o campo tem conteudo (If Not Empty(This.Value)).
4120:   PROTECTED FUNCTION DispararLookup(par_nKeyCode, par_cControle)
4121:     LOCAL loc_oPag, loc_uValor, loc_lAbre
4122:     loc_lAbre = .F.
4123: 
4124:     IF INLIST(par_nKeyCode, 28, 115)
4125:       loc_lAbre = .T.
4126:     ELSE
4127:       IF INLIST(par_nKeyCode, 9, 13)
4128:         loc_oPag   = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4129:         loc_uValor = EVALUATE("loc_oPag." + par_cControle + ".Value")
4130:         loc_lAbre  = !EMPTY(loc_uValor)
4131:         loc_oPag   = .NULL.
4132:       ENDIF
4133:     ENDIF
4134: 
4135:     RETURN loc_lAbre
4136:   ENDFUNC
4137: 
4138:   *============================================================
4139:   *-- ABRIR LOOKUP METHODS
4140:   *============================================================
4141: 
4142:   PROCEDURE AbrirLookupProduto(par_cTipo)
4143:     LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
4144:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4145:     DO CASE
4146:       CASE par_cTipo = "I"
4147:         loc_cTarget = "txt_4c_ProdutoI"
4148:         loc_cVal    = ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value)
4149:       CASE par_cTipo = "F"
4150:         loc_cTarget = "txt_4c_ProdutoF"
4151:         loc_cVal    = ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value)
4152:       OTHERWISE
4153:         RETURN
4154:     ENDCASE
4155:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4156:       "SigCdPro", "cursor_4c_LkpProd", "cpros", loc_cVal, "Produto")
4157:     IF ISNULL(loc_oForm)
4158:       RETURN
4159:     ENDIF
4160:     IF NOT loc_oForm.this_lAchouRegistro
4161:       loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d. Produto")
4162:       loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
4163:       loc_oForm.Show()
4164:     ENDIF
4165:     IF loc_oForm.this_lSelecionou
4166:       loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpProd.cpros)
4167:     ELSE
4168:       loc_oPag.&loc_cTarget..Value = ""
4169:     ENDIF
4170:     IF USED("cursor_4c_LkpProd")
4171:       USE IN cursor_4c_LkpProd
4172:     ENDIF
4173:     loc_oForm.Release()
4174:   ENDPROC
4175: 
4176:   PROCEDURE AbrirLookupEquiv
4177:     LOCAL loc_oPag, loc_cVal, loc_oForm
4178:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4179:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Equiv.Value)
4180:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4181:       "SigCdPro", "cursor_4c_LkpEquiv", "cpros", loc_cVal, "Produto/Equivalente")
4182:     IF ISNULL(loc_oForm)
4183:       RETURN
4184:     ENDIF
4185:     IF NOT loc_oForm.this_lAchouRegistro
4186:       loc_oForm.mAddColuna("cpros", "", "C" + CHR(243) + "d.")
4187:       loc_oForm.mAddColuna("dpros", "", "Descri" + CHR(231) + CHR(227) + "o")
4188:       loc_oForm.Show()
4189:     ENDIF
4190:     IF loc_oForm.this_lSelecionou
4191:       loc_oPag.txt_4c_Equiv.Value = ALLTRIM(cursor_4c_LkpEquiv.cpros)
4192:     ELSE
4193:       loc_oPag.txt_4c_Equiv.Value = ""
4194:     ENDIF
4195:     IF USED("cursor_4c_LkpEquiv")
4196:       USE IN cursor_4c_LkpEquiv
4197:     ENDIF
4198:     loc_oForm.Release()
4199:   ENDPROC
4200: 
4201:   PROCEDURE AbrirLookupGrupo
4202:     LOCAL loc_oPag, loc_cVal, loc_oForm
4203:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4204:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
4205:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4206:       "SigCdGrp", "cursor_4c_LkpGrp", "CGrus", loc_cVal, "Grupo de Produto")
4207:     IF ISNULL(loc_oForm)
4208:       RETURN
4209:     ENDIF
4210:     IF NOT loc_oForm.this_lAchouRegistro
4211:       loc_oForm.mAddColuna("CGrus", "", "C" + CHR(243) + "d.")
4212:       loc_oForm.mAddColuna("DGrus", "", "Grupo")
4213:       loc_oForm.Show()
4214:     ENDIF
4215:     IF loc_oForm.this_lSelecionou
4216:       loc_oPag.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_LkpGrp.CGrus)
4217:       loc_oPag.txt_4c_DsGrupo.Value = ALLTRIM(cursor_4c_LkpGrp.DGrus)
4218:     ELSE
4219:       loc_oPag.txt_4c_CdGrupo.Value = ""
4220:       loc_oPag.txt_4c_DsGrupo.Value = ""
4221:     ENDIF
4222:     IF USED("cursor_4c_LkpGrp")
4223:       USE IN cursor_4c_LkpGrp
4224:     ENDIF
4225:     loc_oForm.Release()
4226:   ENDPROC
4227: 
4228:   PROCEDURE AbrirLookupGrandeGrupo
4229:     LOCAL loc_oPag, loc_cVal, loc_oForm
4230:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4231:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Gde.Value)
4232:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4233:       "SigCdGpr", "cursor_4c_LkpGpr", "codigos", loc_cVal, "Grande Grupo")
4234:     IF ISNULL(loc_oForm)
4235:       RETURN
4236:     ENDIF
4237:     IF NOT loc_oForm.this_lAchouRegistro
4238:       loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
4239:       loc_oForm.mAddColuna("descs",   "", "Descri" + CHR(231) + CHR(227) + "o")
4240:       loc_oForm.Show()
4241:     ENDIF
4242:     IF loc_oForm.this_lSelecionou
4243:       loc_oPag.txt_4c_Gde.Value = ALLTRIM(cursor_4c_LkpGpr.codigos)
4244:     ELSE
4245:       loc_oPag.txt_4c_Gde.Value = ""
4246:     ENDIF
4247:     IF USED("cursor_4c_LkpGpr")
4248:       USE IN cursor_4c_LkpGpr
4249:     ENDIF
4250:     loc_oForm.Release()
4251:   ENDPROC
4252: 
4253:   PROCEDURE AbrirLookupSubGrupo
4254:     LOCAL loc_oPag, loc_cVal, loc_oForm
4255:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4256:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value)
4257:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4258:       "SigCdPsg", "cursor_4c_LkpPsg", "codigos", loc_cVal, "Sub-Grupo")
4259:     IF ISNULL(loc_oForm)
4260:       RETURN
4261:     ENDIF
4262:     IF NOT loc_oForm.this_lAchouRegistro
4263:       loc_oForm.mAddColuna("codigos",    "", "C" + CHR(243) + "d.")
4264:       loc_oForm.mAddColuna("descricaos", "", "Sub-Grupo")
4265:       loc_oForm.Show()
4266:     ENDIF
4267:     IF loc_oForm.this_lSelecionou
4268:       loc_oPag.txt_4c_CdSGrupo.Value = ALLTRIM(cursor_4c_LkpPsg.codigos)
4269:       loc_oPag.txt_4c_DsSGrupo.Value = ALLTRIM(cursor_4c_LkpPsg.descricaos)
4270:     ELSE
4271:       loc_oPag.txt_4c_CdSGrupo.Value = ""
4272:       loc_oPag.txt_4c_DsSGrupo.Value = ""
4273:     ENDIF
4274:     IF USED("cursor_4c_LkpPsg")
4275:       USE IN cursor_4c_LkpPsg
4276:     ENDIF
4277:     loc_oForm.Release()
4278:   ENDPROC
4279: 
4280:   PROCEDURE AbrirLookupCor
4281:     LOCAL loc_oPag, loc_cVal, loc_oForm
4282:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4283:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Cor.Value)
4284:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4285:       "SigCdCor", "cursor_4c_LkpCor", "cods", loc_cVal, "Cor")
4286:     IF ISNULL(loc_oForm)
4287:       RETURN
4288:     ENDIF
4289:     IF NOT loc_oForm.this_lAchouRegistro
4290:       loc_oForm.mAddColuna("cods", "", "C" + CHR(243) + "d.")
4291:       loc_oForm.mAddColuna("descs", "", "Cor")
4292:       loc_oForm.Show()
4293:     ENDIF
4294:     IF loc_oForm.this_lSelecionou
4295:       loc_oPag.txt_4c_Cor.Value  = ALLTRIM(cursor_4c_LkpCor.cods)
4296:       loc_oPag.txt_4c_DCor.Value = ALLTRIM(cursor_4c_LkpCor.descs)
4297:     ELSE
4298:       loc_oPag.txt_4c_Cor.Value  = ""
4299:       loc_oPag.txt_4c_DCor.Value = ""
4300:     ENDIF
4301:     IF USED("cursor_4c_LkpCor")
4302:       USE IN cursor_4c_LkpCor
4303:     ENDIF
4304:     loc_oForm.Release()
4305:   ENDPROC
4306: 
4307:   PROCEDURE AbrirLookupLinha(par_cTipo)
4308:     LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
4309:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4310:     IF par_cTipo = "I"
4311:       loc_cTarget = "txt_4c_LinhaI"
4312:       loc_cVal    = ALLTRIM(loc_oPag.txt_4c_LinhaI.Value)
4313:     ELSE
4314:       loc_cTarget = "txt_4c_LinhaF"
4315:       loc_cVal    = ALLTRIM(loc_oPag.txt_4c_LinhaF.Value)
4316:     ENDIF
4317:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4318:       "SigCdLin", "cursor_4c_LkpLin", "Linhas", loc_cVal, "Linha")
4319:     IF ISNULL(loc_oForm)
4320:       RETURN
4321:     ENDIF
4322:     IF NOT loc_oForm.this_lAchouRegistro
4323:       loc_oForm.mAddColuna("Linhas", "", "Linha")
4324:       loc_oForm.mAddColuna("Descs",  "", "Descri" + CHR(231) + CHR(227) + "o")
4325:       loc_oForm.Show()
4326:     ENDIF
4327:     IF loc_oForm.this_lSelecionou
4328:       loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpLin.Linhas)
4329:     ELSE
4330:       loc_oPag.&loc_cTarget..Value = ""
4331:     ENDIF
4332:     IF USED("cursor_4c_LkpLin")
4333:       USE IN cursor_4c_LkpLin
4334:     ENDIF
4335:     loc_oForm.Release()
4336:   ENDPROC
4337: 
4338:   PROCEDURE AbrirLookupGrupoV(par_cTipo)
4339:     LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cTarget
4340:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4341:     IF par_cTipo = "I"
4342:       loc_cTarget = "txt_4c_GrupoVI"
4343:       loc_cVal    = ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value)
4344:     ELSE
4345:       loc_cTarget = "txt_4c_GrupoVF"
4346:       loc_cVal    = ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value)
4347:     ENDIF
4348:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4349:       "SigCdCol", "cursor_4c_LkpCol", "Colecoes", loc_cVal, "Grupo de Venda")
4350:     IF ISNULL(loc_oForm)
4351:       RETURN
4352:     ENDIF
4353:     IF NOT loc_oForm.this_lAchouRegistro
4354:       loc_oForm.mAddColuna("Colecoes", "", "C" + CHR(243) + "d.")
4355:       loc_oForm.mAddColuna("Descs",    "", "Grupo Venda")
4356:       loc_oForm.Show()
4357:     ENDIF
4358:     IF loc_oForm.this_lSelecionou
4359:       loc_oPag.&loc_cTarget..Value = ALLTRIM(cursor_4c_LkpCol.Colecoes)
4360:     ELSE
4361:       loc_oPag.&loc_cTarget..Value = ""
4362:     ENDIF
4363:     IF USED("cursor_4c_LkpCol")
4364:       USE IN cursor_4c_LkpCol
4365:     ENDIF
4366:     loc_oForm.Release()
4367:   ENDPROC
4368: 
4369:   PROCEDURE AbrirLookupMoeda(par_cCampo)
4370:     LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cCtrl
4371:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4372:     loc_cCtrl = "txt_4c_" + par_cCampo
4373:     loc_cVal  = ALLTRIM(loc_oPag.&loc_cCtrl..Value)
4374:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4375:       "SigCdMoe", "cursor_4c_LkpMoe", "CMoes", loc_cVal, "Moeda")
4376:     IF ISNULL(loc_oForm)
4377:       RETURN
4378:     ENDIF
4379:     IF NOT loc_oForm.this_lAchouRegistro
4380:       loc_oForm.mAddColuna("CMoes", "", "C" + CHR(243) + "d.")
4381:       loc_oForm.mAddColuna("DMoes", "", "Moeda")
4382:       loc_oForm.Show()
4383:     ENDIF
4384:     IF loc_oForm.this_lSelecionou
4385:       loc_oPag.&loc_cCtrl..Value = ALLTRIM(cursor_4c_LkpMoe.CMoes)
4386:     ELSE
4387:       loc_oPag.&loc_cCtrl..Value = ""
4388:     ENDIF
4389:     IF USED("cursor_4c_LkpMoe")
4390:       USE IN cursor_4c_LkpMoe
4391:     ENDIF
4392:     loc_oForm.Release()
4393:   ENDPROC
4394: 
4395:   PROCEDURE AbrirLookupModeloFin(par_cTipo)
4396:     LOCAL loc_oPag, loc_cVal, loc_oForm
4397:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4398:     IF par_cTipo = "P"
4399:       loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodFinP.Value)
4400:     ELSE
4401:       loc_cVal = ALLTRIM(loc_oPag.txt_4c_CodFinPF.Value)
4402:     ENDIF
4403:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4404:       "SigCdFip", "cursor_4c_LkpFip", "Cods", loc_cVal, "Modelo/Finalizador")
4405:     IF ISNULL(loc_oForm)
4406:       RETURN
4407:     ENDIF
4408:     IF NOT loc_oForm.this_lAchouRegistro
4409:       loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "d.")
4410:       loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
4411:       loc_oForm.Show()
4412:     ENDIF
4413:     IF loc_oForm.this_lSelecionou
4414:       IF par_cTipo = "P"
4415:         loc_oPag.txt_4c_CodFinP.Value  = ALLTRIM(cursor_4c_LkpFip.Cods)
4416:       ELSE
4417:         loc_oPag.txt_4c_CodFinPF.Value = ALLTRIM(cursor_4c_LkpFip.Cods)
4418:       ENDIF
4419:     ELSE
4420:       IF par_cTipo = "P"
4421:         loc_oPag.txt_4c_CodFinP.Value  = ""
4422:       ELSE
4423:         loc_oPag.txt_4c_CodFinPF.Value = ""
4424:       ENDIF
4425:     ENDIF
4426:     IF USED("cursor_4c_LkpFip")
4427:       USE IN cursor_4c_LkpFip
4428:     ENDIF
4429:     loc_oForm.Release()
4430:   ENDPROC
4431: 
4432:   PROCEDURE AbrirLookupClasse
4433:     LOCAL loc_oPag, loc_cVal, loc_oForm
4434:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4435:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Classe.Value)
4436:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4437:       "SigCdCls", "cursor_4c_LkpCls", "cods", loc_cVal, ;
4438:       "Classifica" + CHR(231) + CHR(227) + "o")
4439:     IF ISNULL(loc_oForm)
4440:       RETURN
4441:     ENDIF
4442:     IF NOT loc_oForm.this_lAchouRegistro
4443:       loc_oForm.mAddColuna("cods",  "", "C" + CHR(243) + "d.")
4444:       loc_oForm.mAddColuna("descs", "", "Classifica" + CHR(231) + CHR(227) + "o")
4445:       loc_oForm.Show()
4446:     ENDIF
4447:     IF loc_oForm.this_lSelecionou
4448:       loc_oPag.txt_4c_Classe.Value = ALLTRIM(cursor_4c_LkpCls.cods)
4449:     ELSE
4450:       loc_oPag.txt_4c_Classe.Value = ""
4451:     ENDIF
4452:     IF USED("cursor_4c_LkpCls")
4453:       USE IN cursor_4c_LkpCls
4454:     ENDIF
4455:     loc_oForm.Release()
4456:   ENDPROC
4457: 
4458:   *------------------------------------------------------------
4459:   *-- AbrirLookupTamanho: legado getTam.Valid / get_dTam.Valid
4460:   *-- fwbuscaext sobre SigCdTam, buscando por Cods ("C") ou Descs ("D").
4461:   *-- Os dois lados preenchem SEMPRE o par codigo + descricao.
4462:   PROCEDURE AbrirLookupTamanho(par_cLado)
4463:     LOCAL loc_oPag, loc_cVal, loc_cCampo, loc_oForm
4464:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4465: 
4466:     IF par_cLado = "D"
4467:       loc_cCampo = "Descs"
4468:       loc_cVal   = ALLTRIM(loc_oPag.txt_4c_DTam.Value)
4469:     ELSE
4470:       loc_cCampo = "Cods"
4471:       loc_cVal   = ALLTRIM(loc_oPag.txt_4c_Tam.Value)
4472:     ENDIF
4473: 
4474:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4475:       "SigCdTam", "cursor_4c_LkpTam", loc_cCampo, loc_cVal, ;
4476:       "Sele" + CHR(231) + CHR(227) + "o de Tamanho")
4477:     IF ISNULL(loc_oForm)
4478:       RETURN
4479:     ENDIF
4480: 
4481:     IF NOT loc_oForm.this_lAchouRegistro
4482:       IF par_cLado = "D"
4483:         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
4484:         loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
4485:       ELSE
4486:         loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
4487:         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
4488:       ENDIF
4489:       loc_oForm.Show()
4490:     ENDIF
4491: 
4492:     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpTam")
4493:       SELECT cursor_4c_LkpTam
4494:       loc_oPag.txt_4c_Tam.Value  = ALLTRIM(NVL(cursor_4c_LkpTam.Cods, ""))
4495:       loc_oPag.txt_4c_DTam.Value = ALLTRIM(NVL(cursor_4c_LkpTam.Descs, ""))
4496:     ENDIF
4497: 
4498:     IF USED("cursor_4c_LkpTam")
4499:       USE IN cursor_4c_LkpTam
4500:     ENDIF
4501:     loc_oForm.Release()
4502:     loc_oPag = .NULL.
4503:   ENDPROC
4504: 
4505:   *------------------------------------------------------------
4506:   *-- AbrirLookupCategoria: legado getCategoria.Valid / getDCategoria.Valid
4507:   *-- fwbuscaext sobre SigCdCtg, buscando por Cods ("C") ou Descs ("D").
4508:   PROCEDURE AbrirLookupCategoria(par_cLado)
4509:     LOCAL loc_oPag, loc_cVal, loc_cCampo, loc_oForm
4510:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4511: 
4512:     IF par_cLado = "D"
4513:       loc_cCampo = "Descs"
4514:       loc_cVal   = ALLTRIM(loc_oPag.txt_4c_DCategoria.Value)
4515:     ELSE
4516:       loc_cCampo = "Cods"
4517:       loc_cVal   = ALLTRIM(loc_oPag.txt_4c_Categoria.Value)
4518:     ENDIF
4519: 
4520:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4521:       "SigCdCtg", "cursor_4c_LkpCtg", loc_cCampo, loc_cVal, ;
4522:       "Sele" + CHR(231) + CHR(227) + "o de Cole" + CHR(231) + CHR(227) + "o")
4523:     IF ISNULL(loc_oForm)
4524:       RETURN
4525:     ENDIF
4526: 
4527:     IF NOT loc_oForm.this_lAchouRegistro
4528:       IF par_cLado = "D"
4529:         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
4530:         loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
4531:       ELSE
4532:         loc_oForm.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
4533:         loc_oForm.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
4534:       ENDIF
4535:       loc_oForm.Show()
4536:     ENDIF
4537: 
4538:     IF loc_oForm.this_lSelecionou AND USED("cursor_4c_LkpCtg")
4539:       SELECT cursor_4c_LkpCtg
4540:       loc_oPag.txt_4c_Categoria.Value  = ALLTRIM(NVL(cursor_4c_LkpCtg.Cods, ""))
4541:       loc_oPag.txt_4c_DCategoria.Value = ALLTRIM(NVL(cursor_4c_LkpCtg.Descs, ""))
4542:     ENDIF
4543: 
4544:     IF USED("cursor_4c_LkpCtg")
4545:       USE IN cursor_4c_LkpCtg
4546:     ENDIF
4547:     loc_oForm.Release()
4548:     loc_oPag = .NULL.
4549:   ENDPROC
4550: 
4551:   PROCEDURE AbrirLookupPromocao
4552:     LOCAL loc_oPag, loc_cVal, loc_oForm
4553:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4554:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Promo.Value)
4555:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4556:       "SigPrPmc", "cursor_4c_LkpPmc", "promos", loc_cVal, "Promo" + CHR(231) + CHR(227) + "o")
4557:     IF ISNULL(loc_oForm)
4558:       RETURN
4559:     ENDIF
4560:     IF NOT loc_oForm.this_lAchouRegistro
4561:       loc_oForm.mAddColuna("promos", "", "Promo" + CHR(231) + CHR(227) + "o")
4562:       loc_oForm.Show()
4563:     ENDIF
4564:     IF loc_oForm.this_lSelecionou
4565:       loc_oPag.txt_4c_Promo.Value = ALLTRIM(cursor_4c_LkpPmc.promos)
4566:     ELSE
4567:       loc_oPag.txt_4c_Promo.Value = ""
4568:     ENDIF
4569:     IF USED("cursor_4c_LkpPmc")
4570:       USE IN cursor_4c_LkpPmc
4571:     ENDIF
4572:     loc_oForm.Release()
4573:   ENDPROC
4574: 
4575:   PROCEDURE AbrirLookupLista
4576:     LOCAL loc_oPag, loc_cVal, loc_oForm
4577:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4578:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_Lista.Value)
4579:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4580:       "SigCdLpc", "cursor_4c_LkpLpc", "lprecos", loc_cVal, ;
4581:       "Lista de Pre" + CHR(231) + "os")
4582:     IF ISNULL(loc_oForm)
4583:       RETURN
4584:     ENDIF
4585:     IF NOT loc_oForm.this_lAchouRegistro
4586:       loc_oForm.mAddColuna("lprecos", "", "Lista")
4587:       loc_oForm.Show()
4588:     ENDIF
4589:     IF loc_oForm.this_lSelecionou
4590:       loc_oPag.txt_4c_Lista.Value = ALLTRIM(cursor_4c_LkpLpc.lprecos)
4591:     ELSE
4592:       loc_oPag.txt_4c_Lista.Value = ""
4593:     ENDIF
4594:     IF USED("cursor_4c_LkpLpc")
4595:       USE IN cursor_4c_LkpLpc
4596:     ENDIF
4597:     loc_oForm.Release()
4598:   ENDPROC
4599: 
4600:   PROCEDURE AbrirLookupFornecedor
4601:     LOCAL loc_oPag, loc_cVal, loc_oForm
4602:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4603:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdFornec.Value)
4604:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4605:       "SigCdCli", "cursor_4c_LkpForn", "Iclis", loc_cVal, "Fornecedor")
4606:     IF ISNULL(loc_oForm)
4607:       RETURN
4608:     ENDIF
4609:     IF NOT loc_oForm.this_lAchouRegistro
4610:       loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
4611:       loc_oForm.mAddColuna("Rclis", "", "Fornecedor")
4612:       loc_oForm.Show()
4613:     ENDIF
4614:     IF loc_oForm.this_lSelecionou
4615:       loc_oPag.txt_4c_CdFornec.Value = ALLTRIM(cursor_4c_LkpForn.Iclis)
4616:       loc_oPag.txt_4c_DsFornec.Value = ALLTRIM(cursor_4c_LkpForn.Rclis)
4617:     ELSE
4618:       loc_oPag.txt_4c_CdFornec.Value = ""
4619:       loc_oPag.txt_4c_DsFornec.Value = ""
4620:     ENDIF
4621:     IF USED("cursor_4c_LkpForn")
4622:       USE IN cursor_4c_LkpForn
4623:     ENDIF
4624:     loc_oForm.Release()
4625:   ENDPROC
4626: 
4627:   PROCEDURE AbrirLookupEmpresa(par_cCampo, par_cCampoDes)
4628:     LOCAL loc_oPag, loc_cVal, loc_oForm, loc_cCtrl, loc_cCtrlD
4629:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4630:     loc_cCtrl = "txt_4c_" + par_cCampo
4631:     loc_cVal  = ALLTRIM(loc_oPag.&loc_cCtrl..Value)
4632:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4633:       "SigCdEmp", "cursor_4c_LkpEmp", "Cemps", loc_cVal, "Empresa")
4634:     IF ISNULL(loc_oForm)
4635:       RETURN
4636:     ENDIF
4637:     IF NOT loc_oForm.this_lAchouRegistro
4638:       loc_oForm.mAddColuna("Cemps", "", "C" + CHR(243) + "d.")
4639:       loc_oForm.mAddColuna("Razas", "", "Empresa")
4640:       loc_oForm.Show()
4641:     ENDIF
4642:     IF loc_oForm.this_lSelecionou
4643:       loc_oPag.&loc_cCtrl..Value = ALLTRIM(cursor_4c_LkpEmp.Cemps)
4644:       IF NOT EMPTY(par_cCampoDes)
4645:         loc_cCtrlD = "txt_4c_" + par_cCampoDes
4646:         loc_oPag.&loc_cCtrlD..Value = ALLTRIM(cursor_4c_LkpEmp.Razas)
4647:       ENDIF
4648:     ELSE
4649:       loc_oPag.&loc_cCtrl..Value = ""
4650:       IF NOT EMPTY(par_cCampoDes)
4651:         loc_cCtrlD = "txt_4c_" + par_cCampoDes
4652:         loc_oPag.&loc_cCtrlD..Value = ""
4653:       ENDIF
4654:     ENDIF
4655:     IF USED("cursor_4c_LkpEmp")
4656:       USE IN cursor_4c_LkpEmp
4657:     ENDIF
4658:     loc_oForm.Release()
4659:   ENDPROC
4660: 
4661:   PROCEDURE AbrirLookupGrupoCC
4662:     LOCAL loc_oPag, loc_cVal, loc_oForm
4663:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4664:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_GrupoCC.Value)
4665:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4666:       "SigCdGcr", "cursor_4c_LkpGcr", "codigos", loc_cVal, "Grupo C/C")
4667:     IF ISNULL(loc_oForm)
4668:       RETURN
4669:     ENDIF
4670:     IF NOT loc_oForm.this_lAchouRegistro
4671:       loc_oForm.mAddColuna("codigos", "", "C" + CHR(243) + "d.")
4672:       loc_oForm.mAddColuna("descrs",  "", "Grupo C/C")
4673:       loc_oForm.Show()
4674:     ENDIF
4675:     IF loc_oForm.this_lSelecionou
4676:       loc_oPag.txt_4c_GrupoCC.Value  = ALLTRIM(cursor_4c_LkpGcr.codigos)
4677:       loc_oPag.txt_4c_NGrupoCC.Value = ALLTRIM(cursor_4c_LkpGcr.descrs)
4678:     ELSE
4679:       loc_oPag.txt_4c_GrupoCC.Value  = ""
4680:       loc_oPag.txt_4c_NGrupoCC.Value = ""
4681:     ENDIF
4682:     IF USED("cursor_4c_LkpGcr")
4683:       USE IN cursor_4c_LkpGcr
4684:     ENDIF
4685:     loc_oForm.Release()
4686:   ENDPROC
4687: 
4688:   PROCEDURE AbrirLookupContaCC
4689:     LOCAL loc_oPag, loc_cVal, loc_oForm
4690:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4691:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_CdConta.Value)
4692:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4693:       "SigCdCli", "cursor_4c_LkpConta", "Iclis", loc_cVal, "Conta Corrente")
4694:     IF ISNULL(loc_oForm)
4695:       RETURN
4696:     ENDIF
4697:     IF NOT loc_oForm.this_lAchouRegistro
4698:       loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
4699:       loc_oForm.mAddColuna("Rclis", "", "Conta")
4700:       loc_oForm.Show()
4701:     ENDIF
4702:     IF loc_oForm.this_lSelecionou
4703:       loc_oPag.txt_4c_CdConta.Value = ALLTRIM(cursor_4c_LkpConta.Iclis)
4704:       loc_oPag.txt_4c_NConta.Value  = ALLTRIM(cursor_4c_LkpConta.Rclis)
4705:     ELSE
4706:       loc_oPag.txt_4c_CdConta.Value = ""
4707:       loc_oPag.txt_4c_NConta.Value  = ""
4708:     ENDIF
4709:     IF USED("cursor_4c_LkpConta")
4710:       USE IN cursor_4c_LkpConta
4711:     ENDIF
4712:     loc_oForm.Release()
4713:   ENDPROC
4714: 
4715:   PROCEDURE AbrirLookupContaFin
4716:     LOCAL loc_oPag, loc_cVal, loc_oForm
4717:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4718:     loc_cVal  = ALLTRIM(loc_oPag.txt_4c_ContaO.Value)
4719:     loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
4720:       "SigCdCli", "cursor_4c_LkpContaO", "Iclis", loc_cVal, "Conta Financeira")
4721:     IF ISNULL(loc_oForm)
4722:       RETURN
4723:     ENDIF
4724:     IF NOT loc_oForm.this_lAchouRegistro
4725:       loc_oForm.mAddColuna("Iclis", "", "C" + CHR(243) + "d.")
4726:       loc_oForm.mAddColuna("Rclis", "", "Conta")
4727:       loc_oForm.Show()
4728:     ENDIF
4729:     IF loc_oForm.this_lSelecionou
4730:       loc_oPag.txt_4c_ContaO.Value  = ALLTRIM(cursor_4c_LkpContaO.Iclis)
4731:       loc_oPag.txt_4c_NContaO.Value = ALLTRIM(cursor_4c_LkpContaO.Rclis)
4732:     ELSE
4733:       loc_oPag.txt_4c_ContaO.Value  = ""
4734:       loc_oPag.txt_4c_NContaO.Value = ""
4735:     ENDIF
4736:     IF USED("cursor_4c_LkpContaO")
4737:       USE IN cursor_4c_LkpContaO
4738:     ENDIF
4739:     loc_oForm.Release()
4740:   ENDPROC
4741: 
4742:   *------------------------------------------------------------
4743:   *-- GrpLimparFiltrosClick: limpa todos os campos de filtro
4744:   PROCEDURE GrpLimparFiltrosClick
4745:     LOCAL loc_oPag
4746:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4747: 
4748:     TRY
4749:       *-- Produto
4750:       loc_oPag.txt_4c_ProdutoI.Value  = ""
4751:       loc_oPag.txt_4c_ProdutoF.Value  = ""
4752:       loc_oPag.txt_4c_Descricao.Value = ""
4753:       loc_oPag.txt_4c_Descritivo.Value= ""
4754:       loc_oPag.txt_4c_Barra.Value     = ""
4755:       loc_oPag.txt_4c_Equiv.Value     = ""
4756:       loc_oPag.chk_4c_Equiv.Value     = 0
4757: 
4758:       *-- Situacao / Imagem
4759:       loc_oPag.cmb_4c_Situas.ListIndex = 0
4760:       loc_oPag.cmb_4c_Imagem.ListIndex = 0
4761: 
4762:       *-- Grupo / SubGrupo
4763:       loc_oPag.txt_4c_Gde.Value      = ""
4764:       loc_oPag.txt_4c_CdGrupo.Value  = ""
4765:       loc_oPag.txt_4c_DsGrupo.Value  = ""
4766:       loc_oPag.txt_4c_CdSGrupo.Value = ""
4767:       loc_oPag.txt_4c_DsSGrupo.Value = ""
4768: 
4769:       *-- Linha / Colecao
4770:       loc_oPag.txt_4c_LinhaI.Value  = ""
4771:       loc_oPag.txt_4c_LinhaF.Value  = ""
4772:       loc_oPag.txt_4c_GrupoVI.Value = ""
4773:       loc_oPag.txt_4c_GrupoVF.Value = ""
4774: 
4775:       *-- Descricao completa
4776:       loc_oPag.txt_4c_DCompl.Value = ""
4777: 
4778:       *-- Pesos
4779:       loc_oPag.txt_4c_PesoI.Value = ""
4780:       loc_oPag.txt_4c_PesoF.Value = ""
4781: 
4782:       *-- Custo / Venda / Estimado
4783:       loc_oPag.txt_4c_CustoI.Value  = ""
4784:       loc_oPag.txt_4c_CustoF.Value  = ""

*-- Linhas 4855 a 4965:
4855: 
4856:   *------------------------------------------------------------
4857:   *-- PopularCombos: inicializa combos Situacao e Imagem
4858:   PROTECTED PROCEDURE PopularCombos
4859:     LOCAL loc_oPag
4860:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
4861: 
4862:     WITH loc_oPag.cmb_4c_Situas
4863:       .Clear
4864:       .AddItem("Ativos  ")
4865:       .AddItem("Inativos")
4866:       .AddItem("Ambos   ")
4867:       .Value = "Ambos   "
4868:     ENDWITH
4869: 
4870:     WITH loc_oPag.cmb_4c_Imagem
4871:       .Clear
4872:       .AddItem("c/Imagem")
4873:       .AddItem("s/Imagem")
4874:       .AddItem("Ambos   ")
4875:       .Value = "Ambos   "
4876:     ENDWITH
4877: 
4878:     loc_oPag = .NULL.
4879:   ENDPROC
4880: 
4881:   *------------------------------------------------------------
4882:   *-- ConfigurarBtnVoltar: cria botao Voltar na pagina de resultados
4883:   PROTECTED PROCEDURE ConfigurarBtnVoltar
4884:     LOCAL loc_oPag
4885:     loc_oPag = THIS.pgf_4c_1.Page2
4886: 
4887:     loc_oPag.AddObject("cmd_4c_Voltar", "CommandButton")
4888:     WITH loc_oPag.cmd_4c_Voltar
4889:       .Top         = 0
4890:       .Left        = 920
4891:       .Width       = 75
4892:       .Height      = 17
4893:       .Caption     = "\<Voltar"
4894:       .FontName    = "Tahoma"
4895:       .FontSize    = 8
4896:       .FontBold    = .T.
4897:       .Visible     = .T.
4898:     ENDWITH
4899: 
4900:     BINDEVENT(loc_oPag.cmd_4c_Voltar, "Click", THIS, "BtnVoltarClick")
4901:     loc_oPag = .NULL.
4902:   ENDPROC
4903: 
4904:   *------------------------------------------------------------
4905:   *-- BtnVoltarClick: retorna para pagina de filtros
4906:   PROCEDURE BtnVoltarClick
4907:     THIS.Caption = THIS.this_cPrompt
4908:     THIS.pgf_4c_1.Page2.lbl_4c_TxtCaption.Caption = THIS.Caption
4909:     THIS.AlternarPagina(1)
4910:   ENDPROC
4911: 
4912:   *------------------------------------------------------------
4913:   *-- KeyPress do Form: F8 ativa busca por LIKE
4914:   PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
4915:     IF par_nKeyCode = -7
4916:       IF VARTYPE(go_4c_Sistema) = "O"
4917:         go_4c_Sistema.BuscaP = .T.
4918:       ENDIF
4919:     ENDIF
4920:     DODEFAULT(par_nKeyCode, par_nShiftAltCtrl)
4921:   ENDPROC
4922: 
4923:   *------------------------------------------------------------
4924:   *-- GrdProdutosAfterRowColChange: carrega detalhes do produto selecionado
4925:   PROCEDURE GrdProdutosAfterRowColChange(par_nColIndex)
4926:     LOCAL loc_cCodPro, loc_cSQL, loc_nRet, loc_oCab, loc_lProsseguir
4927:     LOCAL loc_cCodGru, loc_cCodSgru, loc_cCodCor
4928:     LOCAL loc_cDsSgrupo, loc_cDsCor
4929:     LOCAL loc_nPrecoDe, loc_nPVenda, loc_dAux, loc_oPagSel, loc_lDescont
4930: 
4931:     IF !USED("CrProdutos") OR RECCOUNT("CrProdutos") = 0
4932:       RETURN
4933:     ENDIF
4934: 
4935:     SELECT CrProdutos
4936:     IF EOF()
4937:       RETURN
4938:     ENDIF
4939: 
4940:     loc_cCodPro = ALLTRIM(CrProdutos.cpros)
4941:     IF EMPTY(loc_cCodPro)
4942:       RETURN
4943:     ENDIF
4944: 
4945:     loc_lProsseguir = .T.
4946:     TRY
4947:       THIS.MousePointer = 11
4948: 
4949:       *-- Query principal: dados do produto com JOINs
4950:       loc_cSQL = ;
4951:         "Select a.cpros, a.cgrus, a.dpros, a.sgrus, a.cunis, " + ;
4952:         "a.ifors, a.reffs, a.qmins, a.pvens, a.moevs, " + ;
4953:         "a.pesoms, a.fcustos, a.moepcs, a.fvendas, a.moepvs, " + ;
4954:         "a.obspeds, a.obspes, a.linhas, a.colecoes, " + ;
4955:         "a.CodCors, a.cproeqs, a.cClass, a.Locals, a.cbars, " + ;
4956:         "a.CodFinP, a.Conjunts, a.Mercs, a.pcuss, a.moecs, " + ;
4957:         "a.situas, a.DPro2s, a.DPro3s, a.Volumes, " + ;
4958:         "a.Categoria, a.CodMacro, a.ObsCompras, a.PrecoDe, " + ;
4959:         "a.dtincs, a.UsuIncs, a.UltComps, a.vUltComps, a.MUltComps, " + ;
4960:         "k.descs As descCtg, " + ;
4961:         "a.pesobs, a.tamps, a.tamhs, a.tamls, a.ProdWebs, " + ;
4962:         "c.rclis, g.dgrus, " + ;
4963:         "b.descs As desccol, l.descs As desclin, " + ;
4964:         "f.descs As descftio, h.descs As descgru " + ;
4965:         "From SigCdPro a " + ;

*-- Linhas 5176 a 5362:
5176: 
5177:   *------------------------------------------------------------
5178:   *-- CarregarImagemProduto: carrega imagem JPG do produto
5179:   PROTECTED PROCEDURE CarregarImagemProduto(par_cCodPro)
5180:     LOCAL loc_cSQL, loc_nRet, loc_cArquivo, loc_oImg
5181: 
5182:     loc_oImg = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.img_4c_FigJpg
5183:     loc_oImg.Picture = ""
5184: 
5185:     TRY
5186:       loc_cSQL = "Select FigJpgs From SigCdPro " + ;
5187:         "Where cpros = " + EscaparSQL(par_cCodPro)
5188:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpImg")
5189:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpImg") AND !EOF("cursor_4c_TmpImg")
5190:         IF !ISNULL(cursor_4c_TmpImg.FigJpgs) AND !EMPTY(cursor_4c_TmpImg.FigJpgs)
5191:           loc_cArquivo = SYS(2023) + "\" + SYS(2015) + ".jpg"
5192:           STRTOFILE(cursor_4c_TmpImg.FigJpgs, loc_cArquivo)
5193:           loc_oImg.Picture = loc_cArquivo
5194:         ENDIF
5195:       ENDIF
5196:       IF USED("cursor_4c_TmpImg")
5197:         USE IN cursor_4c_TmpImg
5198:       ENDIF
5199:     CATCH TO loc_oErro
5200:       *-- INTENCIONAL: imagem nao disponivel (cursor/SQLEXEC pode falhar, FigJpgs vazio); produto exibe sem foto
5201:     ENDTRY
5202: 
5203:     loc_oImg = .NULL.
5204:   ENDPROC
5205: 
5206:   *------------------------------------------------------------
5207:   *-- CarregarCaracteristicas: carrega grid de caracteristicas do filtro
5208:   PROTECTED PROCEDURE CarregarCaracteristicas
5209:     LOCAL loc_cSQL, loc_nRet
5210:     TRY
5211:       loc_cSQL = "Select 0 as marcado, Codigos as cods, " + ;
5212:         "Codigos as descs From SigCrRap"
5213:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpCaract")
5214:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpCaract")
5215:         IF USED("cursor_4c_Caract")
5216:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = ""
5217:           SELECT cursor_4c_Caract
5218:           SELECT cursor_4c_Caract
5219:           ZAP
5220:           APPEND FROM DBF("cursor_4c_TmpCaract")
5221:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.ColumnCount = 2
5222:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.RecordSource = "cursor_4c_Caract"
5223:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.ControlSource  = "cursor_4c_Caract.marcado"
5224:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column1.Header1.Caption = ""
5225:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.ControlSource  = "cursor_4c_Caract.descs"
5226:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Column2.Header1.Caption = "Caracter" + CHR(237) + "stica"
5227:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Caract.Refresh()
5228:         ENDIF
5229:         USE IN cursor_4c_TmpCaract
5230:       ENDIF
5231:     CATCH TO loc_oErro
5232:       *-- INTENCIONAL: caracteristicas nao disponiveis para o produto; grid permanece vazio sem dialog
5233:     ENDTRY
5234:   ENDPROC
5235: 
5236:   *------------------------------------------------------------
5237:   *-- CarregarTiposOperacao: carrega grid de tipos de operacao
5238:   PROTECTED PROCEDURE CarregarTiposOperacao
5239:     LOCAL loc_cSQL, loc_nRet
5240:     TRY
5241:       loc_cSQL = "Select 0 as marcado, Codigos as ctipo, " + ;
5242:         "Descrs as dtipo From SigCdTom"
5243:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpTOpe")
5244:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpTOpe")
5245:         IF USED("cursor_4c_TOpe")
5246:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = ""
5247:           SELECT cursor_4c_TOpe
5248:           SELECT cursor_4c_TOpe
5249:           ZAP
5250:           APPEND FROM DBF("cursor_4c_TmpTOpe")
5251:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.ColumnCount = 3
5252:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.RecordSource = "cursor_4c_TOpe"
5253:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.ControlSource  = "cursor_4c_TOpe.marcado"
5254:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column1.Header1.Caption = ""
5255:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.ControlSource  = "cursor_4c_TOpe.ctipo"
5256:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column2.Header1.Caption = "C" + CHR(243) + "d"
5257:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.ControlSource  = "cursor_4c_TOpe.dtipo"
5258:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Column3.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
5259:           THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_TOpe.Refresh()
5260:         ENDIF
5261:         USE IN cursor_4c_TmpTOpe
5262:       ENDIF
5263:     CATCH TO loc_oErro
5264:       *-- INTENCIONAL: tipos de operacao nao disponiveis para o produto; grid permanece vazio sem dialog
5265:     ENDTRY
5266:   ENDPROC
5267: 
5268:   *------------------------------------------------------------
5269:   *-- MontaStrTpOpe: monta string IN para filtro de tipos de operacao
5270:   PROTECTED PROCEDURE MontaStrTpOpe
5271:     LOCAL loc_cResult
5272:     loc_cResult = ""
5273: 
5274:     IF !USED("cursor_4c_TOpe")
5275:       RETURN loc_cResult
5276:     ENDIF
5277: 
5278:     SELECT cursor_4c_TOpe
5279:     SCAN FOR cursor_4c_TOpe.marcado
5280:       IF !EMPTY(loc_cResult)
5281:         loc_cResult = loc_cResult + ","
5282:       ENDIF
5283:       loc_cResult = loc_cResult + "'" + ;
5284:         ALLTRIM(cursor_4c_TOpe.ctipo) + "'"
5285:     ENDSCAN
5286: 
5287:     RETURN loc_cResult
5288:   ENDPROC
5289: 
5290:   *------------------------------------------------------------
5291:   *-- CarregarComposicaoFiltro: carrega grid composicao do filtro
5292:   PROTECTED PROCEDURE CarregarComposicaoFiltro
5293:     LOCAL loc_cSQL, loc_nRet
5294: 
5295:     IF USED("CsMatPrima")
5296:       THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = ""
5297:       SELECT CsMatPrima
5298:       ZAP IN CsMatPrima
5299:     ENDIF
5300: 
5301:     TRY
5302:       loc_cSQL = "Select cpros as mats, dpros as dcompos, " + ;
5303:         "0.00 as qtd_inicial, 0.00 as qtd_final, " + ;
5304:         ".F. as apenas, cgrus as Cgrus, '' as Tipos " + ;
5305:         "From SigCdPro Where 1=0"
5306:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMat")
5307:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpMat")
5308:         USE IN cursor_4c_TmpMat
5309:       ENDIF
5310:     CATCH TO loc_oErro
5311:       *-- INTENCIONAL: SQLEXEC inicial pode falhar (estrutura cursor); CsMatPrima sera populado por consulta real
5312:     ENDTRY
5313: 
5314:     IF USED("CsMatPrima")
5315:       THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.RecordSource = "CsMatPrima"
5316:       THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1.grd_4c_Composicao.Refresh()
5317:     ENDIF
5318:   ENDPROC
5319: 
5320:   *------------------------------------------------------------
5321:   *-- LimparCamposCabecalho: limpa todos os campos de detalhe do produto
5322:   PROTECTED PROCEDURE LimparCamposCabecalho
5323:     LOCAL loc_oCab
5324: 
5325:     loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
5326: 
5327:     TRY
5328:       loc_oCab.txt_4c__cd_fornecedor.Value  = ""
5329:       loc_oCab.txt_4c__ds_fornecedor.Value  = ""
5330:       loc_oCab.txt_4c__ref_fornecedor.Value = ""
5331:       loc_oCab.txt_4c__cd_grupo.Value       = ""
5332:       loc_oCab.txt_4c__ds_grupo.Value       = ""
5333:       loc_oCab.txt_4c__cd_sgrupo.Value      = ""
5334:       loc_oCab.txt_4c__ds_sgrupo.Value      = ""
5335:       loc_oCab.txt_4c_CdLinha.Value         = ""
5336:       loc_oCab.txt_4c_DsLinha.Value         = ""
5337:       loc_oCab.txt_4c_GrVenda.Value         = ""
5338:       loc_oCab.txt_4c_GrDvenda.Value        = ""
5339:       loc_oCab.txt_4c__cd_unidade.Value     = ""
5340:       loc_oCab.txt_4c__cd_ggrupo.Value      = ""
5341:       loc_oCab.txt_4c__ds_ggrupo.Value      = ""
5342:       loc_oCab.txt_4c_CodFinP.Value         = ""
5343:       loc_oCab.txt_4c_DesFinP.Value         = ""
5344:       loc_oCab.txt_4c_Conjunto.Value        = ""
5345:       loc_oCab.txt_4c_Equivalente.Value     = ""
5346:       loc_oCab.txt_4c__qtd_minima.Value     = 0
5347:       loc_oCab.txt_4c_VBars.Value           = ""
5348:       loc_oCab.txt_4c_CodCorR.Value         = ""
5349:       loc_oCab.txt_4c_DescCorR.Value        = ""
5350:       loc_oCab.txt_4c_ClassifR.Value        = ""
5351:       loc_oCab.txt_4c_PrVendaR.Value        = 0
5352:       loc_oCab.txt_4c_MoePrVR.Value         = ""
5353:       loc_oCab.txt_4c_PesoMedioR.Value      = 0
5354:       loc_oCab.txt_4c_FatorVR.Value         = 0
5355:       loc_oCab.txt_4c_MoeFatorR.Value       = ""
5356:       loc_oCab.txt_4c_LocaisR.Value         = ""
5357:       loc_oCab.txt_4c_Obs1R.Value           = ""
5358:       loc_oCab.txt_4c_Obs2R.Value           = ""
5359:       loc_oCab.txt_4c_DPro2s.Value          = ""
5360:       loc_oCab.txt_4c_CdCategoriaR.Value    = ""
5361:       loc_oCab.txt_4c_DsCategoriaR.Value    = ""
5362:       loc_oCab.txt_4c_CodMacroR.Value       = ""

*-- Linhas 5397 a 5529:
5397:   *-- BtnVisualizarClick: executa a consulta com os filtros informados e
5398:   *-- exibe o resultado - alias de BtnConsultarClick, que e a propria acao
5399:   *-- de "visualizar" produtos nesta tela (legado: Cmd_Consulta.Click).
5400:   PROCEDURE BtnVisualizarClick
5401:     THIS.BtnConsultarClick()
5402:   ENDPROC
5403: 
5404:   *------------------------------------------------------------
5405:   *-- BtnAlterarClick: habilita a edicao do preco/peso medio/fator do produto
5406:   *-- selecionado na grade. Equivalente ao legado altpreco.Click
5407:   *-- ("Confirma a Alteracao de Preco" + ThisForm.AlteraPreco = .T.), mas sem
5408:   *-- abrir SigCdPro.Scx: os campos editaveis ja estao no proprio cabecalho
5409:   *-- do resultado (txt_4c_PrVendaR/PesoMedioR/FatorVR) e sao gravados por
5410:   *-- BtnSalvarClick - simplificacao de arquitetura (PILAR 3), mesmo
5411:   *-- resultado de negocio do legado.
5412:   PROCEDURE BtnAlterarClick
5413:     LOCAL loc_oCab
5414: 
5415:     IF !USED("CrProdutos") OR EOF("CrProdutos")
5416:       MsgAviso("Selecione um produto na grade antes de alterar o pre" + CHR(231) + "o.")
5417:       RETURN
5418:     ENDIF
5419: 
5420:     IF !fChecaAcesso("SIGOPCGP", "ALTPRECO")
5421:       MsgAviso("Usu" + CHR(225) + "rio n" + CHR(227) + "o possui acesso para alterar pre" + CHR(231) + "os.")
5422:       RETURN
5423:     ENDIF
5424: 
5425:     IF !MsgConfirma("Confirma a altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o?", "Confirma" + CHR(231) + CHR(227) + "o")
5426:       RETURN
5427:     ENDIF
5428: 
5429:     THIS.this_lAlteraPreco = .T.
5430: 
5431:     TRY
5432:       loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
5433:       loc_oCab.txt_4c_PrVendaR.ReadOnly   = .F.
5434:       loc_oCab.txt_4c_MoePrVR.ReadOnly    = .F.
5435:       loc_oCab.txt_4c_PesoMedioR.ReadOnly = .F.
5436:       loc_oCab.txt_4c_FatorVR.ReadOnly    = .F.
5437:       loc_oCab.txt_4c_MoeFatorR.ReadOnly  = .F.
5438:       loc_oCab.txt_4c_PrVendaR.SetFocus()
5439:       loc_oCab = .NULL.
5440:     CATCH TO loc_oErro
5441:       *-- INTENCIONAL: cnt_4c_Cabecalho pode nao estar instanciado ainda; ReadOnly e melhor-esforco
5442:     ENDTRY
5443: 
5444:     THIS.AjustarBotoesPorModo()
5445:   ENDPROC
5446: 
5447:   *============================================================
5448:   *-- FASE 8: METODOS DE CONSOLIDACAO
5449:   *============================================================
5450: 
5451:   *------------------------------------------------------------
5452:   *-- BtnBuscarClick: executa busca usando filtros informados (alias de BtnConsultarClick)
5453:   PROCEDURE BtnBuscarClick
5454:     THIS.BtnConsultarClick()
5455:   ENDPROC
5456: 
5457:   *------------------------------------------------------------
5458:   *-- BtnEncerrarClick: encerra o formulario
5459:   PROCEDURE BtnEncerrarClick
5460:     THIS.Release()
5461:   ENDPROC
5462: 
5463:   *------------------------------------------------------------
5464:   *-- BtnSalvarClick: salva alteracao de preco do produto selecionado
5465:   PROCEDURE BtnSalvarClick
5466:     LOCAL loc_lSucesso, loc_cCodPro, loc_oCab
5467:     LOCAL loc_cSQL, loc_nRet
5468: 
5469:     loc_lSucesso = .F.
5470: 
5471:     IF !THIS.this_lAlteraPreco
5472:       MsgAviso("Altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o n" + CHR(227) + "o habilitada.")
5473:       RETURN
5474:     ENDIF
5475: 
5476:     IF !USED("CrProdutos") OR RECCOUNT("CrProdutos") = 0
5477:       MsgAviso("Nenhum produto selecionado.")
5478:       RETURN
5479:     ENDIF
5480: 
5481:     SELECT CrProdutos
5482:     IF EOF()
5483:       MsgAviso("Nenhum produto selecionado.")
5484:       RETURN
5485:     ENDIF
5486: 
5487:     loc_cCodPro = ALLTRIM(CrProdutos.cpros)
5488:     IF EMPTY(loc_cCodPro)
5489:       MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o identificado.")
5490:       RETURN
5491:     ENDIF
5492: 
5493:     loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
5494: 
5495:     TRY
5496:       *-- Recarregar dados atuais do produto do banco para nao perder campos nao editaveis
5497:       loc_cSQL = "SELECT dpros, cgrus, sgrus, cunis, ifors, reffs, " + ;
5498:         "pcuss, moecs, pesoms, fcustos, margems, pvens, valors " + ;
5499:         "FROM SigCdPro WHERE cpros = " + EscaparSQL(loc_cCodPro)
5500: 
5501:       loc_nRet = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSalvar")
5502: 
5503:       IF loc_nRet >= 1 AND USED("cursor_4c_TmpSalvar") AND !EOF("cursor_4c_TmpSalvar")
5504:         GO TOP IN cursor_4c_TmpSalvar
5505: 
5506:         THIS.this_oBusinessObject.this_cCodPro        = loc_cCodPro
5507:         THIS.this_oBusinessObject.this_cDescPro       = ALLTRIM(NVL(cursor_4c_TmpSalvar.dpros,   ""))
5508:         THIS.this_oBusinessObject.this_cGrupoPro      = ALLTRIM(NVL(cursor_4c_TmpSalvar.cgrus,   ""))
5509:         THIS.this_oBusinessObject.this_cSubGrupoPro   = ALLTRIM(NVL(cursor_4c_TmpSalvar.sgrus,   ""))
5510:         THIS.this_oBusinessObject.this_cUnidadePro    = ALLTRIM(NVL(cursor_4c_TmpSalvar.cunis,   ""))
5511:         THIS.this_oBusinessObject.this_cFornecedorPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.ifors,   ""))
5512:         THIS.this_oBusinessObject.this_cRefPro        = ALLTRIM(NVL(cursor_4c_TmpSalvar.reffs,   ""))
5513:         THIS.this_oBusinessObject.this_nPrecoCusto    = NVL(cursor_4c_TmpSalvar.pcuss,   0)
5514:         THIS.this_oBusinessObject.this_cMoedaCustoPro = ALLTRIM(NVL(cursor_4c_TmpSalvar.moecs,   ""))
5515:         THIS.this_oBusinessObject.this_nMargem        = NVL(cursor_4c_TmpSalvar.margems, 0)
5516:         THIS.this_oBusinessObject.this_nCustoEstimado = NVL(cursor_4c_TmpSalvar.valors,  0)
5517: 
5518:         *-- Campos editaveis pelo usuario (preco, peso, fator)
5519:         THIS.this_oBusinessObject.this_nPrecoVenda  = NVL(loc_oCab.txt_4c_PrVendaR.Value,   0)
5520:         THIS.this_oBusinessObject.this_nPesoMedio   = NVL(loc_oCab.txt_4c_PesoMedioR.Value, 0)
5521:         THIS.this_oBusinessObject.this_nFatorCusto  = NVL(loc_oCab.txt_4c_FatorVR.Value,    0)
5522: 
5523:         IF USED("cursor_4c_TmpSalvar")
5524:           USE IN cursor_4c_TmpSalvar
5525:         ENDIF
5526: 
5527:         loc_lSucesso = THIS.this_oBusinessObject.Atualizar()
5528: 
5529:         IF loc_lSucesso

*-- Linhas 5561 a 5604:
5561:   *------------------------------------------------------------
5562:   *-- FormParaBO: copia todos os campos do formulario para propriedades do BO
5563:   *-- Nomenclatura das properties segue EXATAMENTE a declaracao em sigopcgpBO.prg
5564:   PROTECTED PROCEDURE FormParaBO
5565:     LOCAL loc_oPag, loc_oBO
5566:     LOCAL loc_cPesoI, loc_cPesoF, loc_cCustoI, loc_cCustoF
5567:     LOCAL loc_cEstimI, loc_cEstimF, loc_cVendaI, loc_cVendaF
5568:     LOCAL loc_cTamps, loc_cTamas, loc_cTamcs
5569: 
5570:     IF VARTYPE(THIS.this_oBusinessObject) != "O"
5571:       RETURN
5572:     ENDIF
5573: 
5574:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
5575:     loc_oBO  = THIS.this_oBusinessObject
5576: 
5577:     TRY
5578:       *-- Produto / Descricao / Descritivo / Descr. Completa / Barra
5579:       loc_oBO.this_cProdutoInicial = ALLTRIM(loc_oPag.txt_4c_ProdutoI.Value)
5580:       loc_oBO.this_cProdutoFinal   = ALLTRIM(loc_oPag.txt_4c_ProdutoF.Value)
5581:       loc_oBO.this_cDescricao      = ALLTRIM(loc_oPag.txt_4c_Descricao.Value)
5582:       loc_oBO.this_cDescritivo     = ALLTRIM(loc_oPag.txt_4c_Descritivo.Value)
5583:       loc_oBO.this_cDCompl         = ALLTRIM(loc_oPag.txt_4c_DCompl.Value)
5584:       loc_oBO.this_nBarra          = ALLTRIM(loc_oPag.txt_4c_Barra.Value)
5585: 
5586:       *-- Equivalente
5587:       loc_oBO.this_lEquivalentes = (loc_oPag.chk_4c_Equiv.Value = 1)
5588:       loc_oBO.this_cEquivalente  = ALLTRIM(loc_oPag.txt_4c_Equiv.Value)
5589: 
5590:       *-- Grupo / SubGrupo / Grande Grupo / Linha / Colecao (Grupo de Venda)
5591:       loc_oBO.this_cGde      = ALLTRIM(loc_oPag.txt_4c_Gde.Value)
5592:       loc_oBO.this_cCdGrupo  = ALLTRIM(loc_oPag.txt_4c_CdGrupo.Value)
5593:       loc_oBO.this_cDsGrupo  = ALLTRIM(loc_oPag.txt_4c_DsGrupo.Value)
5594:       loc_oBO.this_cCdSGrupo = ALLTRIM(loc_oPag.txt_4c_CdSGrupo.Value)
5595:       loc_oBO.this_cDsSGrupo = ALLTRIM(loc_oPag.txt_4c_DsSGrupo.Value)
5596:       loc_oBO.this_cLinhaI   = ALLTRIM(loc_oPag.txt_4c_LinhaI.Value)
5597:       loc_oBO.this_cLinhaF   = ALLTRIM(loc_oPag.txt_4c_LinhaF.Value)
5598:       loc_oBO.this_cColecaoI = ALLTRIM(loc_oPag.txt_4c_GrupoVI.Value)
5599:       loc_oBO.this_cColecaoF = ALLTRIM(loc_oPag.txt_4c_GrupoVF.Value)
5600: 
5601:       *-- Peso (faixa)
5602:       loc_cPesoI = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoI.Value), ",", "")
5603:       loc_cPesoF = STRTRAN(ALLTRIM(loc_oPag.txt_4c_PesoF.Value), ",", "")
5604:       loc_oBO.this_nPesoInicial = VAL(loc_cPesoI)

*-- Linhas 5699 a 5742:
5699:   *------------------------------------------------------------
5700:   *-- BOParaForm: copia propriedades do BO para os campos do formulario
5701:   *-- Nomenclatura das properties segue EXATAMENTE a declaracao em sigopcgpBO.prg
5702:   PROTECTED PROCEDURE BOParaForm
5703:     LOCAL loc_oPag, loc_oBO
5704: 
5705:     IF VARTYPE(THIS.this_oBusinessObject) != "O"
5706:       RETURN
5707:     ENDIF
5708: 
5709:     loc_oPag = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
5710:     loc_oBO  = THIS.this_oBusinessObject
5711: 
5712:     TRY
5713:       *-- Produto / Descricao / Descritivo / Descr. Completa / Barra
5714:       loc_oPag.txt_4c_ProdutoI.Value   = loc_oBO.this_cProdutoInicial
5715:       loc_oPag.txt_4c_ProdutoF.Value   = loc_oBO.this_cProdutoFinal
5716:       loc_oPag.txt_4c_Descricao.Value  = loc_oBO.this_cDescricao
5717:       loc_oPag.txt_4c_Descritivo.Value = loc_oBO.this_cDescritivo
5718:       loc_oPag.txt_4c_DCompl.Value     = loc_oBO.this_cDCompl
5719:       loc_oPag.txt_4c_Barra.Value      = IIF(loc_oBO.this_nBarra = 0, "", ALLTRIM(STR(loc_oBO.this_nBarra, 14)))
5720: 
5721:       *-- Equivalente
5722:       loc_oPag.txt_4c_Equiv.Value = loc_oBO.this_cEquivalente
5723:       loc_oPag.chk_4c_Equiv.Value = IIF(loc_oBO.this_lEquivalentes, 1, 0)
5724: 
5725:       *-- Grupo / SubGrupo / Grande Grupo / Linha / Colecao (Grupo de Venda)
5726:       loc_oPag.txt_4c_Gde.Value      = loc_oBO.this_cGde
5727:       loc_oPag.txt_4c_CdGrupo.Value  = loc_oBO.this_cCdGrupo
5728:       loc_oPag.txt_4c_DsGrupo.Value  = loc_oBO.this_cDsGrupo
5729:       loc_oPag.txt_4c_CdSGrupo.Value = loc_oBO.this_cCdSGrupo
5730:       loc_oPag.txt_4c_DsSGrupo.Value = loc_oBO.this_cDsSGrupo
5731:       loc_oPag.txt_4c_LinhaI.Value   = loc_oBO.this_cLinhaI
5732:       loc_oPag.txt_4c_LinhaF.Value   = loc_oBO.this_cLinhaF
5733:       loc_oPag.txt_4c_GrupoVI.Value  = loc_oBO.this_cColecaoI
5734:       loc_oPag.txt_4c_GrupoVF.Value  = loc_oBO.this_cColecaoF
5735: 
5736:       *-- Peso (faixa)
5737:       loc_oPag.txt_4c_PesoI.Value = TRANSFORM(loc_oBO.this_nPesoInicial)
5738:       loc_oPag.txt_4c_PesoF.Value = TRANSFORM(loc_oBO.this_nPesoFinal)
5739: 
5740:       *-- Cor
5741:       loc_oPag.txt_4c_Cor.Value  = loc_oBO.this_cCor
5742:       loc_oPag.txt_4c_DCor.Value = loc_oBO.this_cDCor

*-- Linhas 5822 a 5896:
5822: 
5823:   *------------------------------------------------------------
5824:   *-- HabilitarCampos: habilita/desabilita controles conforme permissao de alteracao de preco
5825:   PROTECTED PROCEDURE HabilitarCampos
5826:     LOCAL loc_oPag, loc_lPode, loc_oCab
5827: 
5828:     loc_lPode = THIS.this_lAlteraPreco
5829:     loc_oPag  = THIS.pgf_4c_1.Page1.pgf_4c_Filtro.Page1
5830: 
5831:     TRY
5832:       *-- Filtros de consulta sempre habilitados
5833:       loc_oPag.txt_4c_ProdutoI.Enabled  = .T.
5834:       loc_oPag.txt_4c_ProdutoF.Enabled  = .T.
5835:       loc_oPag.txt_4c_Descricao.Enabled = .T.
5836:       loc_oPag.txt_4c_Descritivo.Enabled = .T.
5837:       loc_oPag.txt_4c_Barra.Enabled     = .T.
5838:       loc_oPag.txt_4c_Equiv.Enabled     = .T.
5839:       loc_oPag.chk_4c_Equiv.Enabled     = .T.
5840:       loc_oPag.txt_4c_CdGrupo.Enabled   = .T.
5841:       loc_oPag.txt_4c_CdSGrupo.Enabled  = .T.
5842:       loc_oPag.txt_4c_CdFornec.Enabled  = .T.
5843:       loc_oPag.txt_4c_RefFornec.Enabled = .T.
5844:       loc_oPag.txt_4c_Cor.Enabled       = .T.
5845:     CATCH TO loc_oErro
5846:       *-- INTENCIONAL: filtros podem nao estar instanciados; Enabled eh melhor-esforco
5847:     ENDTRY
5848: 
5849:     TRY
5850:       *-- Campos de preco no resultado: editaveis somente se lAlteraPreco = .T.
5851:       loc_oCab = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_Cabecalho
5852:       loc_oCab.txt_4c_PrVendaR.ReadOnly   = !loc_lPode
5853:       loc_oCab.txt_4c_MoePrVR.ReadOnly    = !loc_lPode
5854:       loc_oCab.txt_4c_PesoMedioR.ReadOnly = !loc_lPode
5855:       loc_oCab.txt_4c_FatorVR.ReadOnly    = !loc_lPode
5856:       loc_oCab.txt_4c_MoeFatorR.ReadOnly  = !loc_lPode
5857:       loc_oCab = .NULL.
5858:     CATCH TO loc_oErro
5859:       *-- INTENCIONAL: cnt_4c_Cabecalho de resultado pode nao estar instanciado; ReadOnly eh melhor-esforco
5860:     ENDTRY
5861: 
5862:     THIS.AjustarBotoesPorModo()
5863: 
5864:     loc_oPag = .NULL.
5865:   ENDPROC
5866: 
5867:   *------------------------------------------------------------
5868:   *-- LimparCampos: limpa todos os campos de filtro (delega para GrpLimparFiltrosClick)
5869:   PROCEDURE LimparCampos
5870:     THIS.GrpLimparFiltrosClick()
5871:   ENDPROC
5872: 
5873:   *------------------------------------------------------------
5874:   *-- CarregarLista: executa a consulta e carrega os grids de resultado
5875:   PROCEDURE CarregarLista
5876:     THIS.BtnConsultarClick()
5877:   ENDPROC
5878: 
5879:   *------------------------------------------------------------
5880:   *-- AjustarBotoesPorModo: habilita/desabilita botoes de acao conforme permissoes e estado
5881:   PROCEDURE AjustarBotoesPorModo
5882:     LOCAL loc_oCnt, loc_lHabilitar
5883: 
5884:     loc_lHabilitar = THIS.this_lAlteraPreco AND THIS.this_lConsultaExecutada
5885: 
5886:     TRY
5887:       loc_oCnt = THIS.pgf_4c_1.Page2.pgf_4c_Result.Page1.cnt_4c_BotoesAcao
5888:       loc_oCnt.cmd_4c_Salvar.Enabled   = loc_lHabilitar
5889:       loc_oCnt.cmd_4c_Cancelar.Enabled = loc_lHabilitar
5890:       loc_oCnt = .NULL.
5891:     CATCH TO loc_oErro
5892:       *-- INTENCIONAL: cnt_4c_BotoesAcao pode nao estar instanciado; Enabled eh melhor-esforco
5893:     ENDTRY
5894:   ENDPROC
5895: 
5896: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigopcgpBO.prg):
*==============================================================================
* sigopcgpBO.prg - Business Object para Consulta Global de Produtos
* Origem: SIGOPCGP.SCX
* Herda de: BusinessBase
* Tipo: OPERACIONAL (consulta/relatorio - nao eh CRUD de tabela unica)
*==============================================================================

DEFINE CLASS sigopcgpBO AS BusinessBase

    *-- Controle de fluxo (equivalentes as propriedades/vars do form legado)
    this_lConsultaExecutada = .F.   && ConsultaExecutada - evita reprocessar a mesma consulta
    this_cProdutoAtual      = ""    && _Produto - produto corrente (crTSigPro.cpros) na Pagina Resultado
    this_lAlteraPreco       = .F.   && ThisForm.AlteraPreco - fluxo de alteracao de preco (Do Form SigCdPro)
    this_lPrEca             = .F.   && par_prEca recebido no Init do form legado (fluxo iniciado por outra tela)
    this_nTpCalcp           = 0     && ThisForm.Tpcalcp - tipo de calculo de preco em uso
    this_cComposiciona      = ""    && ThisForm.Composiciona - grupo de composicao corrente
    this_lRetornoCj         = .F.   && ThisForm.RetornoCj - retorno do dialogo de conjuge (Do Form SigOpCcj)
    this_cEmpOperas         = ""    && ThisForm.EmpOperas - empresa selecionada para a faixa de operacao
    this_lUsuarioRestrito   = .F.   && ThisForm.llUser - restringe edicao de imagem/preco por tipo de usuario

    *-- Filtro: Produto (faixa de codigo + descricoes)
    this_cProdutoInicial = ""    && Get_produto_inicial - SigCdPro.cpros (faixa - inicio)
    this_cProdutoFinal   = ""    && Get_produto_final   - SigCdPro.cpros (faixa - fim)
    this_cDescricao      = ""    && Get_descricao       - SigCdPro.dpros (contem)
    this_cDescritivo     = ""    && Get_Descritivo      - SigCdPro.descritivo (contem)
    this_cDCompl         = ""    && Get_DCompl          - descricao completa (contem)
    this_cEquivalente    = ""    && getEquivalente      - SigCdPro.cpros do produto equivalente
    this_nBarra          = 0     && Get_Barra           - codigo de barras (SigCdPro.cbars)
    this_lEquivalentes   = .F.   && chkEquivalentes     - .T. = inclui produtos equivalentes na busca

    *-- Filtro: Grupo / Subgrupo / Grande Grupo / Linha / Colecao
    this_cCdGrupo    = ""    && get_cd_grupo  - SigCdGrp.cgrus
    this_cDsGrupo    = ""    && get_ds_grupo  - SigCdGrp.dgrus (preenchido pelo lookup)
    this_cCdSGrupo   = ""    && get_cd_sgrupo - SigCdPsg.codigos (subgrupo do grupo acima)
    this_cDsSGrupo   = ""    && get_ds_sgrupo - SigCdPsg.descricaos (preenchido pelo lookup)
    this_cGde        = ""    && Get_gde       - SigCdGpr.codigos (grande grupo)
    this_cLinhaI     = ""    && GetLin        - SigCdLin.linhas (faixa - inicio)
    this_cLinhaF     = ""    && GetLin2       - SigCdLin.linhas (faixa - fim)
    this_cColecaoI   = ""    && GetCol        - SigCdCol.colecoes (faixa - inicio)
    this_cColecaoF   = ""    && GetCol1       - SigCdCol.colecoes (faixa - fim)

    *-- Filtro: Peso / Cor / Tamanho / Dimensoes
    this_nPesoInicial = 0     && get_peso_inicial - SigCdPro.pesoms (faixa - inicio)
    this_nPesoFinal   = 0     && get_peso_final   - SigCdPro.pesoms (faixa - fim)
    this_cCor         = ""    && getCor      - SigCdCor.cods
    this_cDCor        = ""    && Get_dCor    - SigCdCor.descs (preenchido pelo lookup)
    this_cTam         = ""    && getTam      - SigCdTam.cods
    this_cDTam        = ""    && get_dTam    - SigCdTam.descs (preenchido pelo lookup)
    this_nTamProf     = 0     && get_tamps   - dimensao: profundidade
    this_nTamAlt      = 0     && get_tamas   - dimensao: altura
    this_nTamComp     = 0     && get_tamcs   - dimensao: comprimento

    *-- Filtro: Categoria / Conjunto (codigo pai) / Classificacao / Modelo / Faixa de Valor
    this_cCategoria   = ""    && getCategoria   - SigCdCtg.cods
    this_cDCategoria  = ""    && getDCategoria  - SigCdCtg.descs (preenchido pelo lookup)
    this_cConjunto    = ""    && getConjunto    - codigo pai (SigCdPro.conjunts)
    this_cClasse      = ""    && get_cClass     - SigCdCls.cods
    this_cCodFinPI    = ""    && getCodFinP     - SigCdFip.cods (Modelo, faixa - inicio)
    this_cCodFinPF    = ""    && getCodFinPF    - SigCdFip.cods (Modelo, faixa - fim)
    this_cFxPreco     = ""    && getFxPreco     - SigCdPpc/SigCdPpi (faixa de valor do grupo)
    this_cLocais      = ""    && getLocals      - localizacao do produto
    this_cCodMacro    = ""    && getCodMacro    - codigo macro do produto

    *-- Filtro: CPF/CGC, Situacao, Imagem, Web
    this_cCPF          = ""    && Get_CPF   - CPF/CGC do cliente/fornecedor (faixa de operacao)
    this_cSituacao     = ""    && cmbSituas  - situacao do produto (RowSource)
    this_cImagem       = ""    && cmbImagem  - filtro por presenca de imagem (RowSource)
    this_nProdutoWeb   = 0     && optWebs    - indice do OptionGroup (5 opcoes) - produto web
    this_lOff          = .F.   && chkOff     - produto fora de linha / inativo no site

    *-- Filtro: Fornecedor / Referencia / Lista de Precos / Promocao
    this_cCdFornecedor   = ""    && get_cd_fornecedor  - SigCdCli.iclis (fAcessoContas)
    this_cDsFornecedor   = ""    && get_ds_fornecedor  - SigCdCli.rclis (preenchido pelo lookup)
    this_cRefFornecedor  = ""    && get_ref_fornecedor - SigCdPro.reffs (faixa - inicio)
    this_cRefFornecedorF = ""    && Get_ReffsF         - SigCdPro.reffs (faixa - fim)
    this_nTpReffs        = 0     && Opt_TpReffs        - indice do OptionGroup (3 opcoes)
    this_cLista          = ""    && Get_Lista          - SigCdLpc.lprecos
    this_cPromo          = ""    && get_promo          - SigPrPmc.promos

    *-- Filtro: Faixas de valor (custo / estimado / venda) + moeda
    this_nCustoInicial    = 0     && get_custo_inicial    - faixa de custo (inicio)
    this_nCustoFinal      = 0     && get_custo_final      - faixa de custo (fim)
    this_cMoeCusto        = ""    && get_moe_custo        - SigCdMoe.cmoes
    this_nEstimadoInicial = 0     && get_estimado_inicial - faixa de valor estimado (inicio)
    this_nEstimadoFinal   = 0     && get_estimado_final   - faixa de valor estimado (fim)
    this_cMoeEstimado     = ""    && get_moe_estimado     - SigCdMoe.cmoes
    this_nVendaInicial    = 0     && get_venda_inicial    - faixa de preco de venda (inicio)
    this_nVendaFinal      = 0     && get_venda_final      - faixa de preco de venda (fim)
    this_cMoeVenda        = ""    && get_moe_venda        - SigCdMoe.cmoes

    *-- Filtro: Empresa / Operacao / Periodo
    this_cEmpresa      = ""    && getEmps    - SigCdEmp.cemps
    this_cDEmpresa     = ""    && getDEmps   - SigCdEmp.razas (preenchido pelo lookup)
    this_cEmpresaOpe   = ""    && getEmpsO   - SigCdEmp.cemps (faixa de operacao)
    this_cOperacaoI    = ""    && Get_Operacaoi - SigCdOpe.dopes (faixa - inicio)
    this_cOperacaoF    = ""    && Get_Operacao  - SigCdOpe.dopes (faixa - fim)
    this_nTipoOperacao = 0     && OptOperacao   - indice do OptionGroup (3 opcoes)
    this_nTipoData     = 0     && OptTpData     - indice do OptionGroup (2 opcoes) - Dt. Operacao / Dt. Cadastro
    this_nTipoDataCad  = 0     && OptTpDtCad    - indice do OptionGroup (2 opcoes) - Inclusao / Alteracao
    this_nFormaPagto   = 0     && OptPagamento  - indice do OptionGroup (3 opcoes)
    this_lMarcaTOpe    = .F.   && ck_MarcaTOpe  - marca/desmarca todos os tipos de operacao da grade
    this_dDtOperacaoI  = {}    && get_dt_inicial - faixa de data de operacao (inicio)
    this_dDtOperacaoF  = {}    && get_dt_final   - faixa de data de operacao (fim)
    this_dDtAlteracaoI = {}    && getDtAltI      - faixa de data de alteracao (inicio)
    this_dDtAlteracaoF = {}    && getDtAltF      - faixa de data de alteracao (fim)

    *-- Filtro: Grupo/Conta Contabil (C.C. relacionado) e Conta de Origem/Destino do movimento
    this_cCdGrupoContab = ""    && get_Grupo   - SigCdCrg.ccargs (fAcessoContab)
    this_cDsGrupoContab = ""    && get_NGrupo  - descricao do grupo contabil (preenchido pelo lookup)
    this_cConta         = ""    && Get_Conta   - SigCdCli.iclis (fAcessoContas)
    this_cDConta        = ""    && Get_NConta  - SigCdCli.rclis (preenchido pelo lookup)
    this_cContaO        = ""    && get_ContaO  - SigCdCli.iclis (conta de origem/destino do movimento)
    this_cDContaO       = ""    && get_NContaO - SigCdCli.rclis (preenchido pelo lookup)

    *--------------------------------------------------------------------------
    * Init - este BO eh de CONSULTA customizada (SigOpCgp nao eh cadastro CRUD
    * de uma tabela so, e sim um painel que cruza SigCdPro com dezenas de
    * tabelas de apoio). this_cTabela/this_cCampoChave ficam com a entidade
    * central da consulta (Produtos), mas NAO sao passados a DODEFAULT():
    * BusinessBase.Init(pcTabela) so instanciaria um DataAccess generico sobre
    * SigCdPro, que este BO nao usa (as consultas sao todas via SQLEXEC).
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega o produto corrente a partir do cursor que
    * alimenta a grade de resultados (CrTSigPro/CrProdutos no legado). Este BO
    * eh de CONSULTA (SigOpCgp cruza SigCdPro com dezenas de tabelas de apoio
    * via SQLEXEC proprios de cada aba de resultado) - nao ha gravacao de
    * registro aqui, so o rastreio de qual produto esta em foco.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF VARTYPE(par_cAliasCursor) != "C" OR EMPTY(par_cAliasCursor) OR !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        SELECT (par_cAliasCursor)

        IF TYPE("cpros") != "U"
            THIS.this_cProdutoAtual = TratarNulo(cpros, "C")
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - SigOpCgp eh consulta sobre SigCdPro; a chave do
    * registro em foco (usada so se algum fluxo chegar a chamar
    * RegistrarAuditoria) eh o codigo do produto corrente.
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cProdutoAtual
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir / Atualizar / ExecutarExclusao - SigOpCgp eh form de CONSULTA
    * (Consulta Global de Produtos): nenhum botao do legado grava SigCdPro por
    * aqui - alteracao e inclusao de produto abrem Do Form SigCdPro (FormProduto,
    * via BtnCadastroAlterar/btnProduto). A unica gravacao vista no dump
    * (Update SigCdPrf Set Obs em Pag_Resultado.Result.Fase.Get_Obs.LostFocus)
    * eh a observacao de fase de producao, que pertence ao metodo da propria
    * grade/aba Fase (fases seguintes desta migracao), nao a este trio. O
    * comportamento padrao herdado de BusinessBase (recusar a operacao) ja eh
    * o correto para este BO.
    *--------------------------------------------------------------------------

ENDDEFINE

