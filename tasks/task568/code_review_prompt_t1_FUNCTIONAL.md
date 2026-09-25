# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [METODO-INEXISTENTE] Metodo 'THIS.CarregarFaixaNotas()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarFaixaPreenchida()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVDOC): Top original=98 vs migrado 'lbl_4c_Label1' Top=18 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGMVDOC): Top original=98 vs migrado 'lbl_4c_Label2' Top=18 (diff=80px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGMVDOC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (895 linhas total):

*-- Linhas 30 a 147:
30:     Themes      = .F.
31:     ShowTips    = .T.
32: 
33:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
34:     this_oRelatorio    = .NULL.
35:     this_cMensagemErro = ""
36: 
37:     *-- Faixa REAL de Notas Fiscais existentes (menor e maior nfis da empresa).
38:     *   Equivalem ao "Go Top" / "Go Bott" que o Init legado fazia sobre o cursor
39:     *   crDados para descobrir os limites da faixa. Populadas por LimparCampos e
40:     *   usadas pelos handlers de saida dos campos para limitar o que o usuario
41:     *   digita, exatamente como GetNotaI.Valid / GetNotaF.Valid do legado.
42:     this_nNotaMin      = 0
43:     this_nNotaMax      = 0
44: 
45:     *--------------------------------------------------------------------------
46:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
47:     *--------------------------------------------------------------------------
48:     PROCEDURE Init()
49:         RETURN DODEFAULT()
50:     ENDPROC
51: 
52:     *--------------------------------------------------------------------------
53:     * InicializarForm - Cria estrutura visual do formulario de relatorio
54:     *--------------------------------------------------------------------------
55:     PROTECTED PROCEDURE InicializarForm()
56:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
57:         loc_lSucesso   = .F.
58:         loc_lContinuar = .T.
59:         TRY
60:             THIS.Caption = "Emiss" + CHR(227) + "o do Documento"
61: 
62:             IF TYPE("gc_4c_CaminhoIcones") = "U"
63:                 gc_4c_CaminhoIcones = ""
64:             ENDIF
65:             IF TYPE("gc_4c_CaminhoReports") = "U"
66:                 gc_4c_CaminhoReports = ""
67:             ENDIF
68:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
69: 
70:             *-- Instanciar BO de relatorio
71:             THIS.this_oRelatorio = CREATEOBJECT("SIGMVDOCBO")
72:             IF VARTYPE(THIS.this_oRelatorio) != "O"
73:                 MsgErro("Erro ao criar SIGMVDOCBO" + CHR(13) + ;
74:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
75:                 loc_lContinuar = .F.
76:             ENDIF
77: 
78:             IF loc_lContinuar
79:                 THIS.ConfigurarCabecalho()
80:                 THIS.ConfigurarBotoes()
81:                 THIS.ConfigurarPageFrame()
82:                 THIS.ConfigurarPaginaLista()
83: 
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
86: 
87:                 *-- Liga os controles de filtro aos handlers e carrega a faixa
88:                 *   inicial de Notas (equivalente ao final do Init legado)
89:                 THIS.ConfigurarPaginaDados()
90:                 THIS.LimparCampos()
91: 
92:                 loc_lSucesso = .T.
93:             ENDIF
94:         CATCH TO loc_oErro
95:             THIS.this_cMensagemErro = loc_oErro.Message
96:             MsgErro(loc_oErro.Message + CHR(13) + ;
97:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
98:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
99:         ENDTRY
100:         RETURN loc_lSucesso
101:     ENDPROC
102: 
103:     *--------------------------------------------------------------------------
104:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
105:     *   Equivalente ao cntSombra do frmrelatorio legado.
106:     *--------------------------------------------------------------------------
107:     PROTECTED PROCEDURE ConfigurarCabecalho()
108:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
109:         WITH THIS.cnt_4c_Cabecalho
110:             .Top         = 0
111:             .Left        = 0
112:             .Width       = THIS.Width
113:             .Height      = 80
114:             .BackStyle   = 1
115:             .BackColor   = RGB(100, 100, 100)
116:             .BorderWidth = 0
117:             .Visible     = .T.
118: 
119:             .AddObject("lbl_4c_Sombra", "Label")
120:             WITH .lbl_4c_Sombra
121:                 .Top       = 22
122:                 .Left      = 22
123:                 .Width     = THIS.Width
124:                 .Height    = 30
125:                 .Caption   = "Emiss" + CHR(227) + "o do Documento"
126:                 .FontName  = "Tahoma"
127:                 .FontSize  = 14
128:                 .FontBold  = .T.
129:                 .ForeColor = RGB(0, 0, 0)
130:                 .BackStyle = 0
131:                 .Visible   = .T.
132:             ENDWITH
133: 
134:             .AddObject("lbl_4c_Titulo", "Label")
135:             WITH .lbl_4c_Titulo
136:                 .Top       = 20
137:                 .Left      = 20
138:                 .Width     = THIS.Width
139:                 .Height    = 30
140:                 .Caption   = "Emiss" + CHR(227) + "o do Documento"
141:                 .FontName  = "Tahoma"
142:                 .FontSize  = 14
143:                 .FontBold  = .T.
144:                 .ForeColor = RGB(255, 255, 255)
145:                 .BackStyle = 0
146:                 .Visible   = .T.
147:             ENDWITH

*-- Linhas 156 a 199:
156:     *   Buttons(3): Caption/Picture canonicos "Arquivos Email" (CLAUDE.md #100),
157:     *   sem relacao com o Name legado "DocExcel".
158:     *--------------------------------------------------------------------------
159:     PROTECTED PROCEDURE ConfigurarBotoes()
160:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
161:         WITH THIS.cmg_4c_Botoes
162:             .Top           = 0
163:             .Left          = 495
164:             .Width         = 310
165:             .Height        = 85
166:             .ButtonCount   = 4
167:             .BackStyle     = 0
168:             .BorderStyle   = 0
169:             .BorderColor   = RGB(136, 189, 188)
170:             .SpecialEffect = 1
171:             .Themes        = .F.
172:             .Visible       = .T.
173: 
174:             WITH .Buttons(1)
175:                 .Top             = 5
176:                 .Left            = 5
177:                 .Width           = 75
178:                 .Height          = 75
179:                 .Caption         = "\<Visualizar"
180:                 .FontName        = "Comic Sans MS"
181:                 .FontSize        = 8
182:                 .FontBold        = .T.
183:                 .FontItalic      = .T.
184:                 .BackColor       = RGB(255, 255, 255)
185:                 .ForeColor       = RGB(90, 90, 90)
186:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
187:                 .PicturePosition = 13
188:                 .SpecialEffect   = 0
189:                 .MousePointer    = 15
190:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
191:                 .Themes          = .F.
192:                 .Visible         = .T.
193:             ENDWITH
194: 
195:             WITH .Buttons(2)
196:                 .Top             = 5
197:                 .Left            = 80
198:                 .Width           = 75
199:                 .Height          = 75

*-- Linhas 266 a 357:
266:     *   Os controles de filtro (Nota Inicial/Final) sao adicionados na
267:     *   Page1 por ConfigurarPaginaLista.
268:     *--------------------------------------------------------------------------
269:     PROTECTED PROCEDURE ConfigurarPageFrame()
270:         LOCAL loc_oPgf
271: 
272:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
273:         loc_oPgf = THIS.pgf_4c_Paginas
274: 
275:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
276:         loc_oPgf.PageCount = 1
277: 
278:         loc_oPgf.Top    = 80
279:         loc_oPgf.Left   = -1
280:         loc_oPgf.Width  = THIS.Width + 2
281:         loc_oPgf.Height = THIS.Height - 80
282:         loc_oPgf.Tabs   = .F.
283: 
284:         loc_oPgf.Page1.Caption   = "Filtros"
285:         loc_oPgf.Page1.FontName  = "Tahoma"
286:         loc_oPgf.Page1.FontSize  = 8
287:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
288:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
289:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
290: 
291:         loc_oPgf.Visible    = .T.
292:         loc_oPgf.ActivePage = 1
293:     ENDPROC
294: 
295:     *--------------------------------------------------------------------------
296:     * ConfigurarPaginaLista - Controles de filtro da faixa de Nota Fiscal (Page1)
297:     *
298:     * Form REPORT (frmrelatorio) tem layout FLAT: PageFrame com UMA pagina so
299:     * (Filtros). Nao existe grade de registros nem botoes CRUD - a Page1 deste
300:     * tipo de form hospeda os campos de parametro do relatorio, e os botoes de
301:     * acao (Visualizar/Imprimir/Arquivos Email/Encerrar) vivem no cmg_4c_Botoes
302:     * criado em ConfigurarBotoes, fora do PageFrame.
303:     *
304:     * Posicoes EXATAS do SCX legado, compensadas pelo Top do PageFrame (-80):
305:     *     Shape1    Top=90  Left=203 W=394 H=32  -> Top=10
306:     *     Label1    Top=98  Left=254 W=96  H=15  -> Top=18  "Documentos de :"
307:     *     GetNotaI  Top=95  Left=352 W=60  H=23  -> Top=15
308:     *     Label2    Top=98  Left=419 W=9   H=15  -> Top=18  CHR(224) = a crasado
309:     *     GetNotaF  Top=94  Left=434 W=60  H=23  -> Top=14
310:     *
311:     * Ordem de criacao = ordem do SCX (Shape primeiro): o Shape eh a moldura do
312:     * bloco e precisa ficar ATRAS dos campos, que sao criados depois.
313:     *
314:     * Shape3 (Top=343) e Shape4 (Top=276) do SCX ficam fora da area visivel do
315:     * form (Form.Height=130) - sao restos do dialogo generico, nao migrados.
316:     *--------------------------------------------------------------------------
317:     PROTECTED PROCEDURE ConfigurarPaginaLista()
318:         LOCAL loc_oPag
319:         loc_oPag = THIS.pgf_4c_Paginas.Page1
320: 
321:         *-- Shape1: moldura do bloco de filtro
322:         *   SCX: BackStyle=0 / BorderStyle=0 / BorderColor=136,189,188
323:         loc_oPag.AddObject("shp_4c_Shape1", "Shape")
324:         WITH loc_oPag.shp_4c_Shape1
325:             .Top         = 10
326:             .Left        = 203
327:             .Width       = 394
328:             .Height      = 32
329:             .BackStyle   = 0
330:             .BorderStyle = 0
331:             .BorderColor = RGB(136, 189, 188)
332:             .Visible     = .T.
333:         ENDWITH
334: 
335:         *-- Label1 "Documentos de :"
336:         *   SCX declara AutoSize=.T., que eh no-op em Label criado por AddObject:
337:         *   usar Alignment=0 + Width explicita do legado (CLAUDE.md regra #23).
338:         loc_oPag.AddObject("lbl_4c_Label1", "Label")
339:         WITH loc_oPag.lbl_4c_Label1
340:             .Top       = 18
341:             .Left      = 254
342:             .Width     = 96
343:             .Height    = 15
344:             .Caption   = "Documentos de :"
345:             .FontName  = "Tahoma"
346:             .FontSize  = 8
347:             .FontBold  = .T.
348:             .Alignment = 0
349:             .BackStyle = 0
350:             .ForeColor = RGB(90, 90, 90)
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- GetNotaI -> txt_4c_NotaI (Nota Fiscal inicial da faixa)
355:         loc_oPag.AddObject("txt_4c_NotaI", "TextBox")
356:         WITH loc_oPag.txt_4c_NotaI
357:             .Top           = 15

*-- Linhas 415 a 478:
415:     * ConfigurarPaginaDados dos demais forms REPORT do projeto (ref: Formsigrecrf).
416:     *
417:     * GetNotaI.Valid / GetNotaF.Valid do legado sao reproduzidos em
418:     * TxtNotaILostFocus / TxtNotaFLostFocus: BINDEVENT em "Valid" nao dispara de
419:     * forma confiavel em TextBox (CLAUDE.md regra #3) e o Valid do legado rodava
420:     * justamente ao SAIR do campo.
421:     *
422:     * Os botoes sao ligados UM A UM em Buttons(N) (canonico REPORT) - NAO ligar
423:     * tambem o Click do proprio CommandGroup, senao cada clique dispara duas
424:     * vezes (o botao sem codigo de Click propaga o evento para o grupo).
425:     *--------------------------------------------------------------------------
426:     PROTECTED PROCEDURE ConfigurarPaginaDados()
427:         LOCAL loc_oPagina
428:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
429: 
430:         *-- Faixa de Nota Fiscal: valida ao sair do campo (Valid do legado)
431:         BINDEVENT(loc_oPagina.txt_4c_NotaI, "KeyPress", THIS, "TxtNotaILostFocus")
432:         BINDEVENT(loc_oPagina.txt_4c_NotaF, "KeyPress", THIS, "TxtNotaFLostFocus")
433: 
434:         *-- Botoes do relatorio (Visualizar / Imprimir / Arquivos Email / Encerrar)
435:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
436:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
437:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnEmailClick")
438:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
439:     ENDPROC
440: 
441:     *--------------------------------------------------------------------------
442:     * CarregarFaixaNotas - Descobre no banco a faixa REAL de Notas Fiscais
443:     *
444:     * Equivale ao que o Init legado fazia sobre o cursor crDados para achar os
445:     * limites da faixa -
446:     *     Go Top  / Thisform.GetNotaI.Value = nFis
447:     *     Go Bott / Thisform.GetNotaF.Value = nFis
448:     * Aqui os mesmos limites vem do banco (MIN/MAX de nfis na empresa corrente),
449:     * ja que o crDados do dialogo generico era populado pelo chamador externo.
450:     *
451:     * NAO escreve nos campos da tela: apenas atualiza this_nNotaMin /
452:     * this_nNotaMax, que os handlers de saida dos campos usam para limitar o que
453:     * for digitado. Quem escreve nos campos eh LimparCampos (abertura da tela e
454:     * botao Cancelar) e CarregarLista (que so traz de volta para dentro da faixa
455:     * o valor que tiver ficado fora dela).
456:     *
457:     * Sem conexao (validacao de UI / teste automatizado) devolve .F. com os
458:     * limites zerados e o form abre normalmente - o PrepararDados do BO recusa
459:     * faixa zerada.
460:     *--------------------------------------------------------------------------
461:     PROTECTED FUNCTION CarregarFaixaNotas()
462:         LOCAL loc_cSQL, loc_cEmpresa, loc_nResult, loc_lTemBanco, loc_lSucesso, loc_oErro
463: 
464:         THIS.this_nNotaMin = 0
465:         THIS.this_nNotaMax = 0
466:         loc_lSucesso       = .F.
467: 
468:         loc_lTemBanco = .T.
469:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
470:             loc_lTemBanco = .F.
471:         ENDIF
472:         IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
473:             loc_lTemBanco = .F.
474:         ENDIF
475: 
476:         IF loc_lTemBanco
477:             TRY
478:                 loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

*-- Linhas 521 a 895:
521:     * o ultimo documento como faixa inicial. Aqui esses limites vem de
522:     * CarregarFaixaNotas e sao copiados para os dois campos.
523:     *--------------------------------------------------------------------------
524:     PROTECTED PROCEDURE LimparCampos()
525:         LOCAL loc_oPagina
526: 
527:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
528: 
529:         THIS.CarregarFaixaNotas()
530: 
531:         loc_oPagina.txt_4c_NotaI.Value = THIS.this_nNotaMin
532:         loc_oPagina.txt_4c_NotaF.Value = THIS.this_nNotaMax
533:     ENDPROC
534: 
535:     *--------------------------------------------------------------------------
536:     * AlternarPagina - Ativa a pagina de filtros e devolve o foco ao 1o campo
537:     *
538:     * Form REPORT tem PageCount=1: qualquer indice fora da faixa cai na Page1
539:     * (Filtros). Sobrescreve FormBase.AlternarPagina para tambem reexibir o
540:     * PageFrame e reposicionar o foco no primeiro campo editavel, como o
541:     * dialogo legado fazia ao voltar do preview/impressao.
542:     *
543:     * PUBLIC (sem PROTECTED): eh chamado de FORA da classe pelo harness de
544:     * teste automatizado (CLAUDE.md regra #3).
545:     *--------------------------------------------------------------------------
546:     PROCEDURE AlternarPagina(par_nPagina)
547:         LOCAL loc_nPagina, loc_oPag, loc_oErro
548: 
549:         TRY
550:             IF VARTYPE(THIS.pgf_4c_Paginas) = "O"
551:                 loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
552:                 IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
553:                     loc_nPagina = 1
554:                 ENDIF
555: 
556:                 THIS.pgf_4c_Paginas.Visible    = .T.
557:                 THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
558: 
559:                 *-- SetFocus so eh valido com o form ja visivel; sem o guard,
560:                 *   chamar AlternarPagina antes do Show() cai no CATCH.
561:                 loc_oPag = THIS.pgf_4c_Paginas.Page1
562:                 IF THIS.Visible AND PEMSTATUS(loc_oPag, "txt_4c_NotaI", 5)
563:                     IF loc_oPag.txt_4c_NotaI.Visible AND loc_oPag.txt_4c_NotaI.Enabled
564:                         loc_oPag.txt_4c_NotaI.SetFocus()
565:                     ENDIF
566:                 ENDIF
567:             ENDIF
568:         CATCH TO loc_oErro
569:             MsgErro(loc_oErro.Message + CHR(13) + ;
570:                 "Linha: " + TRANSFORM(loc_oErro.LineNo), "AlternarPagina")
571:         ENDTRY
572:     ENDPROC
573: 
574: 
575:     *--------------------------------------------------------------------------
576:     * TxtNotaILostFocus - Valida a Nota Inicial contra a Nota Final digitada
577:     *   (equivalente funcional ao GetNotaI.Valid legado, que comparava contra
578:     *   o cursor crDados aberto pelo chamador externo do dialogo generico -
579:     *   nao reproduzivel aqui; a validacao de faixa correta eh preservada e
580:     *   tambem reforcada pelo PrepararDados do BO antes de rodar o relatorio)
581:     *--------------------------------------------------------------------------
582:     PROCEDURE TxtNotaILostFocus(par_nKeyCode, par_nShiftAltCtrl)
583:         LOCAL loc_oPag
584:         loc_oPag = THIS.pgf_4c_Paginas.Page1
585: 
586:         *-- Legado: Go Top  / If This.Value < nFis -> avisa e volta para o limite
587:         IF THIS.this_nNotaMin > 0 AND loc_oPag.txt_4c_NotaI.Value < THIS.this_nNotaMin
588:             MsgAviso("Nota Menor Que Inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
589:             loc_oPag.txt_4c_NotaI.Value = THIS.this_nNotaMin
590:         ENDIF
591: 
592:         *-- Legado: Go Bott / If This.Value > nFis -> avisa e volta para o limite
593:         IF THIS.this_nNotaMax > 0 AND loc_oPag.txt_4c_NotaI.Value > THIS.this_nNotaMax
594:             MsgAviso("Nota Maior Que Final !!!", "Aten" + CHR(231) + CHR(227) + "o")
595:             loc_oPag.txt_4c_NotaI.Value = THIS.this_nNotaMax
596:         ENDIF
597: 
598:         *-- Coerencia da faixa: a inicial nunca acima da final ja digitada
599:         IF loc_oPag.txt_4c_NotaF.Value > 0 AND loc_oPag.txt_4c_NotaI.Value > loc_oPag.txt_4c_NotaF.Value
600:             MsgAviso("Nota Inicial maior que a Nota Final !!!", "Aten" + CHR(231) + CHR(227) + "o")
601:             loc_oPag.txt_4c_NotaI.Value = loc_oPag.txt_4c_NotaF.Value
602:         ENDIF
603:     ENDPROC
604: 
605:     *--------------------------------------------------------------------------
606:     * TxtNotaFLostFocus - Valida a Nota Final contra a Nota Inicial digitada
607:     *--------------------------------------------------------------------------
608:     PROCEDURE TxtNotaFLostFocus(par_nKeyCode, par_nShiftAltCtrl)
609:         LOCAL loc_oPag
610:         loc_oPag = THIS.pgf_4c_Paginas.Page1
611: 
612:         *-- Legado: Go Top  / If This.Value < nFis -> avisa e volta para o limite
613:         IF THIS.this_nNotaMin > 0 AND loc_oPag.txt_4c_NotaF.Value < THIS.this_nNotaMin
614:             MsgAviso("Nota Menor Que Inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
615:             loc_oPag.txt_4c_NotaF.Value = THIS.this_nNotaMin
616:         ENDIF
617: 
618:         *-- Legado: Go Bott / If This.Value > nFis -> avisa e volta para o limite
619:         IF THIS.this_nNotaMax > 0 AND loc_oPag.txt_4c_NotaF.Value > THIS.this_nNotaMax
620:             MsgAviso("Nota Maior Que Final !!!", "Aten" + CHR(231) + CHR(227) + "o")
621:             loc_oPag.txt_4c_NotaF.Value = THIS.this_nNotaMax
622:         ENDIF
623: 
624:         *-- Coerencia da faixa: a final nunca abaixo da inicial ja digitada
625:         IF loc_oPag.txt_4c_NotaF.Value < loc_oPag.txt_4c_NotaI.Value
626:             MsgAviso("Nota Final menor que a Nota Inicial !!!", "Aten" + CHR(231) + CHR(227) + "o")
627:             loc_oPag.txt_4c_NotaF.Value = loc_oPag.txt_4c_NotaI.Value
628:         ENDIF
629:     ENDPROC
630: 
631:     *--------------------------------------------------------------------------
632:     * FormParaRelatorio - Copia os filtros digitados para o BO de relatorio
633:     *--------------------------------------------------------------------------
634:     PROTECTED PROCEDURE FormParaRelatorio()
635:         LOCAL loc_oPag
636:         loc_oPag = THIS.pgf_4c_Paginas.Page1
637: 
638:         WITH THIS.this_oRelatorio
639:             .this_nNotaI = loc_oPag.txt_4c_NotaI.Value
640:             .this_nNotaF = loc_oPag.txt_4c_NotaF.Value
641:         ENDWITH
642:     ENDPROC
643: 
644:     *--------------------------------------------------------------------------
645:     * ValidarFaixaPreenchida - Equivalente ao btnReport.Click legado:
646:     *   "If (This.Value <> 3) ... If Empty(GetNotaI.Value) / If Empty(GetNotaF.Value)"
647:     *   Roda antes de Visualizar/Imprimir (botoes 1 e 2 do grupo); o legado
648:     *   tambem cobria o botao Sair (4), mas bloquear o fechamento do dialogo
649:     *   por faixa vazia nao faz sentido no fluxo migrado - Encerrar fica de
650:     *   fora desta checagem (desvio deliberado, registrado aqui). O botao de
651:     *   Email/DocExcel (3) ja era excluido no legado.
652:     *--------------------------------------------------------------------------
653:     PROTECTED FUNCTION ValidarFaixaPreenchida()
654:         LOCAL loc_oPag, loc_lValido
655:         loc_oPag    = THIS.pgf_4c_Paginas.Page1
656:         loc_lValido = .T.
657: 
658:         IF EMPTY(loc_oPag.txt_4c_NotaI.Value)
659:             MsgErro("Nota Inicial Inv" + CHR(225) + "lida !!!", "")
660:             loc_lValido = .F.
661:         ELSE
662:             IF EMPTY(loc_oPag.txt_4c_NotaF.Value)
663:                 MsgErro("Nota Final Inv" + CHR(225) + "lida !!!", "")
664:                 loc_lValido = .F.
665:             ENDIF
666:         ENDIF
667: 
668:         RETURN loc_lValido
669:     ENDFUNC
670: 
671:     *--------------------------------------------------------------------------
672:     * BtnVisualizarClick - Preview do documento na tela
673:     *--------------------------------------------------------------------------
674:     PROCEDURE BtnVisualizarClick()
675:         IF THIS.ValidarFaixaPreenchida()
676:             THIS.FormParaRelatorio()
677:             IF !THIS.this_oRelatorio.Visualizar()
678:                 IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
679:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
680:                 ENDIF
681:             ENDIF
682:         ENDIF
683:     ENDPROC
684: 
685:     *--------------------------------------------------------------------------
686:     * BtnImprimirClick - Envia o documento para a impressora (com dialogo)
687:     *--------------------------------------------------------------------------
688:     PROCEDURE BtnImprimirClick()
689:         IF THIS.ValidarFaixaPreenchida()
690:             THIS.FormParaRelatorio()
691:             IF !THIS.this_oRelatorio.Imprimir()
692:                 IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
693:                     MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Imprimir")
694:                 ENDIF
695:             ENDIF
696:         ENDIF
697:     ENDPROC
698: 
699:     *--------------------------------------------------------------------------
700:     * BtnEmailClick - Gera arquivo (Excel) do documento para envio por email
701:     *--------------------------------------------------------------------------
702:     PROCEDURE BtnEmailClick()
703:         THIS.FormParaRelatorio()
704:         IF !THIS.this_oRelatorio.GerarExcel()
705:             IF !EMPTY(THIS.this_oRelatorio.ObterMensagemErro())
706:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Arquivos Email")
707:             ENDIF
708:         ENDIF
709:     ENDPROC
710: 
711:     *--------------------------------------------------------------------------
712:     * BtnEncerrarClick - Fecha o formulario
713:     *--------------------------------------------------------------------------
714:     PROCEDURE BtnEncerrarClick()
715:         THIS.Release()
716:     ENDPROC
717: 
718:     *--------------------------------------------------------------------------
719:     * Destroy - Libera referencia ao BO
720:     *   RelatorioBase herda de Custom (sem Release()) - usar .NULL. para liberar
721:     *--------------------------------------------------------------------------
722:     PROCEDURE Destroy()
723:         IF VARTYPE(THIS.this_oRelatorio) = "O"
724:             THIS.this_oRelatorio = .NULL.
725:         ENDIF
726:         DODEFAULT()
727:     ENDPROC
728: 
729:     *==========================================================================
730:     * METODOS DE COMPATIBILIDADE COM O PIPELINE CRUD
731:     *
732:     * Form REPORT nao tem grid de lista nem gravacao de registro: os nomes CRUD
733:     * abaixo existem porque o pipeline e o harness de teste automatizado os
734:     * chamam em todo form, e cada um recebe aqui o comportamento equivalente no
735:     * contexto de um relatorio (mesmo padrao dos demais forms REPORT do
736:     * projeto - ref: Formsigrecrf.prg).
737:     *
738:     * Os que o harness chama de FORA da classe (CarregarLista,
739:     * AjustarBotoesPorModo, HabilitarCampos, BtnCancelarClick) sao PUBLIC (sem
740:     * PROTECTED): PEMSTATUS(oForm, "Metodo", 5) devolve .T. mesmo para metodo
741:     * PROTECTED e a chamada real falharia em runtime (CLAUDE.md regra #3).
742:     *
743:     * FormParaBO e BOParaForm sao PROTECTED porque o FormBase ja os declara
744:     * assim - a protecao eh herdada e nao ha como afrouxa-la na subclasse
745:     * (declarar sem PROTECTED aqui nao muda nada: medido, chamada externa
746:     * estoura "Property FORMPARABO is not found"). Sao internos mesmo: quem os
747:     * usa sao os proprios metodos desta classe.
748:     *==========================================================================
749: 
750:     *--------------------------------------------------------------------------
751:     * FormParaBO - Copia os filtros da tela para o BO
752:     *   Nome CRUD do pipeline; em REPORT o destino eh o BO de relatorio, entao
753:     *   delega para FormParaRelatorio (fonte unica da copia dos filtros).
754:     *--------------------------------------------------------------------------
755:     PROTECTED PROCEDURE FormParaBO()
756:         THIS.FormParaRelatorio()
757:     ENDPROC
758: 
759:     *--------------------------------------------------------------------------
760:     * BOParaForm - Traz os filtros que estao no BO de volta para a tela
761:     *   Caminho inverso de FormParaBO: util depois de o BO ajustar a faixa
762:     *   (ex.: PrepararDados normaliza os limites) para a tela refletir o que
763:     *   sera efetivamente impresso.
764:     *--------------------------------------------------------------------------
765:     PROTECTED PROCEDURE BOParaForm()
766:         LOCAL loc_oPag
767: 
768:         IF VARTYPE(THIS.this_oRelatorio) != "O"
769:             RETURN
770:         ENDIF
771: 
772:         loc_oPag = THIS.pgf_4c_Paginas.Page1
773:         IF VARTYPE(loc_oPag) != "O"
774:             RETURN
775:         ENDIF
776: 
777:         WITH THIS.this_oRelatorio
778:             IF VARTYPE(loc_oPag.txt_4c_NotaI) = "O"
779:                 loc_oPag.txt_4c_NotaI.Value = .this_nNotaI
780:             ENDIF
781:             IF VARTYPE(loc_oPag.txt_4c_NotaF) = "O"
782:                 loc_oPag.txt_4c_NotaF.Value = .this_nNotaF
783:             ENDIF
784:         ENDWITH
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * CarregarLista - Em REPORT nao ha grid: recarrega a faixa de documentos
789:     *
790:     * O equivalente a "recarregar a lista" neste dialogo eh reconsultar quais
791:     * documentos existem (CarregarFaixaNotas) e, se a faixa disponivel tiver
792:     * mudado desde a abertura da tela, trazer de volta para dentro dela o que o
793:     * usuario tiver digitado - sem zerar o que ele escolheu, que eh o que
794:     * LimparCampos faz.
795:     *
796:     * Devolve sempre .T.: nao ha lista cuja carga possa falhar, e o relatorio
797:     * segue utilizavel mesmo com os limites zerados (o PrepararDados do BO
798:     * recusa faixa invalida com mensagem propria).
799:     *--------------------------------------------------------------------------
800:     PROCEDURE CarregarLista()
801:         LOCAL loc_oPag
802: 
803:         THIS.CarregarFaixaNotas()
804: 
805:         loc_oPag = THIS.pgf_4c_Paginas.Page1
806: 
807:         IF VARTYPE(loc_oPag) = "O" AND THIS.this_nNotaMin > 0 AND THIS.this_nNotaMax > 0
808:             IF loc_oPag.txt_4c_NotaI.Value < THIS.this_nNotaMin OR ;
809:                loc_oPag.txt_4c_NotaI.Value > THIS.this_nNotaMax
810:                 loc_oPag.txt_4c_NotaI.Value = THIS.this_nNotaMin
811:             ENDIF
812:             IF loc_oPag.txt_4c_NotaF.Value < THIS.this_nNotaMin OR ;
813:                loc_oPag.txt_4c_NotaF.Value > THIS.this_nNotaMax
814:                 loc_oPag.txt_4c_NotaF.Value = THIS.this_nNotaMax
815:             ENDIF
816:         ENDIF
817: 
818:         RETURN .T.
819:     ENDPROC
820: 
821:     *--------------------------------------------------------------------------
822:     * HabilitarCampos - Habilita/desabilita os campos de filtro da faixa
823:     *   par_lHabilitar ausente ou de tipo invalido assume .T. (habilitar), que
824:     *   eh o estado normal de um form REPORT - nao ha modo VISUALIZAR aqui.
825:     *--------------------------------------------------------------------------
826:     PROCEDURE HabilitarCampos(par_lHabilitar)
827:         LOCAL loc_lHab, loc_oPag
828: 
829:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
830:         loc_oPag = THIS.pgf_4c_Paginas.Page1
831: 
832:         IF VARTYPE(loc_oPag) != "O"
833:             RETURN
834:         ENDIF
835: 
836:         IF VARTYPE(loc_oPag.txt_4c_NotaI) = "O"
837:             loc_oPag.txt_4c_NotaI.Enabled = loc_lHab
838:         ENDIF
839:         IF VARTYPE(loc_oPag.txt_4c_NotaF) = "O"
840:             loc_oPag.txt_4c_NotaF.Enabled = loc_lHab
841:         ENDIF
842:     ENDPROC
843: 
844:     *--------------------------------------------------------------------------
845:     * AjustarBotoesPorModo - Em REPORT os 4 botoes ficam sempre habilitados
846:     *   (Visualizar / Imprimir / Arquivos Email / Encerrar). Chamado de FORA da
847:     *   classe pelo harness de teste, por isso PUBLIC.
848:     *--------------------------------------------------------------------------
849:     PROCEDURE AjustarBotoesPorModo()
850:         LOCAL loc_nI
851: 
852:         IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
853:             RETURN
854:         ENDIF
855: 
856:         FOR loc_nI = 1 TO THIS.cmg_4c_Botoes.ButtonCount
857:             THIS.cmg_4c_Botoes.Buttons(loc_nI).Enabled = .T.
858:         ENDFOR
859:     ENDPROC
860: 
861:     *--------------------------------------------------------------------------
862:     * BtnSalvarClick - Nome CRUD do pipeline; em REPORT "salvar o resultado" eh
863:     *   mandar o documento para a impressora. Delega para BtnImprimirClick para
864:     *   que a validacao da faixa (ValidarFaixaPreenchida) e o tratamento de erro
865:     *   fiquem em um lugar so.
866:     *--------------------------------------------------------------------------
867:     PROCEDURE BtnSalvarClick()
868:         THIS.BtnImprimirClick()
869:     ENDPROC
870: 
871:     *--------------------------------------------------------------------------
872:     * BtnCancelarClick - Nome CRUD do pipeline; em REPORT "cancelar a edicao" eh
873:     *   descartar o que foi digitado e voltar a faixa completa de documentos,
874:     *   devolvendo o foco ao primeiro campo para nova consulta.
875:     *
876:     *   O SetFocus so vale com a tela JA exibida: o harness de teste chama este
877:     *   metodo com o form apenas instanciado (sem Show), e ai SetFocus estoura.
878:     *   Dai a guarda por THIS.Visible alem da de Enabled.
879:     *--------------------------------------------------------------------------
880:     PROCEDURE BtnCancelarClick()
881:         LOCAL loc_oPag
882: 
883:         THIS.LimparCampos()
884: 
885:         loc_oPag = THIS.pgf_4c_Paginas.Page1
886: 
887:         IF VARTYPE(loc_oPag) = "O" AND THIS.Visible
888:             IF VARTYPE(loc_oPag.txt_4c_NotaI) = "O" AND loc_oPag.txt_4c_NotaI.Enabled
889:                 loc_oPag.txt_4c_NotaI.SetFocus()
890:             ENDIF
891:         ENDIF
892:     ENDPROC
893: 
894: ENDDEFINE
895: 


### BO (C:\4c\projeto\app\classes\SIGMVDOCBO.prg):
*==============================================================================
* SIGMVDOCBO.PRG
* Business Object para Relatorio de Emissao do Documento
*
* Herda de: RelatorioBase
* Form: FormSIGMVDOC.prg
* Relatorio original: SIGMVDOC.SCX (frmrelatorio) / SIGCDENT.FRX
*==============================================================================

DEFINE CLASS SIGMVDOCBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SIGCDENT"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario (faixa de Nota Fiscal)
    this_nNotaI             = 0
    this_nNotaF             = 0

    *-- Cursor principal gerado por PrepararDados (nome exigido pelo FRX legado)
    this_cCursorDados       = "crDados"

    *--------------------------------------------------------------------------
    * Init - Configura identificacao e titulo do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela           = ""
        THIS.this_cCampoChave       = ""
        THIS.this_cArquivoRelatorio = "SIGCDENT"
        THIS.this_cTituloRelatorio  = "Emiss" + CHR(227) + "o do Documento"
        THIS.this_cCursorDados      = "crDados"
        THIS.this_nNotaI            = 0
        THIS.this_nNotaF            = 0

        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Busca os documentos (Notas Fiscais) da faixa informada
    *
    * O SIGMVDOC.SCX legado eh um dialogo generico de impressao (recebe pRep/pTit
    * e espera encontrar um cursor "crDados" ja aberto pelo chamador); nenhum
    * .prg/.scx legado que povoe esse crDados para pRep="SIGCDENT" sobreviveu no
    * acervo (busca exaustiva no Framework e em C:\4install no vieram vazios).
    * A tabela abaixo (SigMvNfi) foi identificada pelo schema: eh a UNICA tabela
    * com coluna nfis char(6) (mesmo tamanho do InputMask "999999" dos campos
    * GetNotaI/GetNotaF) que tambem tem a coluna "impress" (contador de
    * impressao), condizente com "Emissao do Documento".
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cWhere, loc_nResult, loc_oErro
        LOCAL loc_cEmpresa, loc_cNotaI, loc_cNotaF

        loc_lSucesso = .F.

        TRY
            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)

            IF THIS.this_nNotaI <= 0 OR THIS.this_nNotaF <= 0
                THIS.this_cMensagemErro = "Informe a faixa de Notas Fiscais (inicial e final)."
            ELSE
                IF THIS.this_nNotaI > THIS.this_nNotaF
                    THIS.this_cMensagemErro = "Nota Inicial maior que a Nota Final!"
                ELSE
                    loc_cNotaI = PADL(ALLTRIM(STR(THIS.this_nNotaI, 6, 0)), 6, "0")
                    loc_cNotaF = PADL(ALLTRIM(STR(THIS.this_nNotaF, 6, 0)), 6, "0")

                    IF USED(THIS.this_cCursorDados)
                        USE IN (THIS.this_cCursorDados)
                    ENDIF

                    loc_cWhere = "emps = " + EscaparSQL(loc_cEmpresa) + ;
                        " AND nfis BETWEEN " + EscaparSQL(loc_cNotaI) + ;
                        " AND " + EscaparSQL(loc_cNotaF)

                    loc_cSQL = "SELECT * FROM SigMvNfi WHERE " + loc_cWhere + " ORDER BY nfis"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                    IF loc_nResult < 0
                        THIS.this_cMensagemErro = "Erro ao buscar documentos: " + CapturarErroSQL()
                    ELSE
                        IF RECCOUNT(THIS.this_cCursorDados) = 0
                            THIS.this_cMensagemErro = "Nenhum documento encontrado para a faixa de notas informada."
                        ELSE
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                            loc_lSucesso = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarReportForm (Pattern #117) - Executa REPORT FORM apenas se o FRX
    * existir; isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRXs legados Fortyus
    * foram desenhados em POINT="." + REPORTBEHAVIOR 80) e restaura o menu
    * principal apos o PREVIEW (Erro63 - _MREPORT corrompe o _MSYSMENU).
    * par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER"
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarReportForm(par_cRelatorioBase, par_cModo, par_cCursorDados)
        LOCAL loc_cFRX, loc_cPointOrig, loc_cSepOrig, loc_nBehaviorOrig

        loc_cFRX = FULLPATH(gc_4c_CaminhoReports + par_cRelatorioBase + ".frx")

        IF NOT FILE(loc_cFRX)
            MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                loc_cFRX + CHR(13) + CHR(13) + ;
                "O FRX legado ainda n" + CHR(227) + "o foi portado para o novo sistema.", "Erro")
            RETURN .F.
        ENDIF

        IF VARTYPE(par_cCursorDados) == "C" AND !EMPTY(par_cCursorDados)
            IF !USED(par_cCursorDados) OR RECCOUNT(par_cCursorDados) = 0
                MsgAviso("Nenhum registro encontrado com os filtros informados.", ;
                    "Aten" + CHR(231) + CHR(227) + "o")
                RETURN .F.
            ENDIF
        ENDIF

        loc_cPointOrig    = SET("POINT")
        loc_cSepOrig      = SET("SEPARATOR")
        loc_nBehaviorOrig = SET("REPORTBEHAVIOR")
        SET POINT TO "."
        SET SEPARATOR TO ","
        SET REPORTBEHAVIOR 80

        DO CASE
            CASE par_cModo == "PREVIEW"
                REPORT FORM (loc_cFRX) PREVIEW NOCONSOLE
            CASE par_cModo == "PRINTER_PROMPT"
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
            CASE par_cModo == "PRINTER"
                REPORT FORM (loc_cFRX) TO PRINTER NOCONSOLE
        ENDCASE

        SET POINT TO (loc_cPointOrig)
        SET SEPARATOR TO (loc_cSepOrig)
        SET REPORTBEHAVIOR (loc_nBehaviorOrig)

        TRY
            SET SYSMENU TO DEFAULT
            RELEASE POPUP popArquivo, popCadastros, popMovimentos, popRelatorios, popFerramentas, popAjuda
            CriarMenuPrincipal()
        CATCH
            *-- CriarMenuPrincipal fora do escopo (teste automatizado) - silencioso
        ENDTRY

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Exibe o documento em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PREVIEW", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Imprime o documento com dialogo de impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PRINTER_PROMPT", THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o documento para planilha Excel via REPORT FORM ASCII
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_cFRX, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_cFRX = FULLPATH(gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio + ".frx")
                IF NOT FILE(loc_cFRX)
                    MostrarErro("Arquivo de relat" + CHR(243) + "rio n" + CHR(227) + "o encontrado:" + CHR(13) + ;
                        loc_cFRX, "Erro")
                ELSE
                    loc_cArquivo = SYS(5) + CURDIR() + "SigMvDoc_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (loc_cFRX) TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                        loc_lSucesso = .T.
                    ELSE
                        THIS.this_cMensagemErro = "Falha ao gerar arquivo Excel."
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
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
    * ObterChavePrimaria - Identificador da execucao do relatorio (auditoria)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN "SIGMVDOC|" + ALLTRIM(go_4c_Sistema.cCodEmpresa) + "|" + ;
            PADL(ALLTRIM(STR(THIS.this_nNotaI, 6, 0)), 6, "0") + "|" + ;
            PADL(ALLTRIM(STR(THIS.this_nNotaF, 6, 0)), 6, "0")
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera o cursor de dados do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

