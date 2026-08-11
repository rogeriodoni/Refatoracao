# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (16)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SALVA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TmpTot' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH loc_oCnt.grd_4c_Gradenop define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oCnt.grd_4c_Gradenop.RecordSource).
- [GRID-WITH] Bloco WITH loc_oCnt.grd_4c_GradeTrf define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oCnt.grd_4c_GradeTrf.RecordSource).
- [GRID-HEADER] Header Caption 'Nº Fundição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Máquina' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tubos' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3807 linhas total):

*-- Linhas 33 a 89:
33:     this_nTuboAtual = 0
34: 
35:     *==========================================================================
36:     PROCEDURE Init()
37:     *==========================================================================
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *==========================================================================
42:     PROTECTED PROCEDURE InicializarForm()
43:     *==========================================================================
44:         LOCAL loc_lSucesso
45:         loc_lSucesso = .F.
46: 
47:         TRY
48:             *-- Criar Business Object
49:             THIS.this_oBusinessObject = CREATEOBJECT("FUNBO")
50:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
51:                 MsgErro("Erro ao criar FUNBO.", "Erro Init")
52:                 loc_lSucesso = .F.
53:             ELSE
54:                 *-- Criar cursores de trabalho locais (DataSession=2 privada)
55:                 SET SAFETY OFF
56:                 SET NULL ON
57: 
58:                 CREATE CURSOR TmpCera ( ;
59:                     Tubos    N(2,0),   ;
60:                     BCeras   N(12,2),  ;
61:                     Bases    N(12,2),  ;
62:                     Ceras    N(12,2),  ;
63:                     PMetals  N(12,2),  ;
64:                     CodCors  C(4)  NULL, ;
65:                     Obss     M     NULL, ;
66:                     TempMets C(15) NULL, ;
67:                     TempAmbs C(15) NULL, ;
68:                     TempTubs C(15) NULL, ;
69:                     TempAgus C(15) NULL, ;
70:                     CodArvs  C(10) NULL, ;
71:                     Descs    C(40) NULL, ;
72:                     Formulas M     NULL, ;
73:                     MetalNvs N(12,2),  ;
74:                     pmetalrs N(12,2),  ;
75:                     nStatus  N(1,0)    ;
76:                 )
77:                 INDEX ON STR(Tubos, 2) TAG Tubos
78: 
79:                 CREATE CURSOR TmpTrf ( ;
80:                     Dopes    C(20),  ;
81:                     Numes    N(6,0), ;
82:                     Tubos    N(2,0), ;
83:                     nNumes   N(10,0) ;
84:                 )
85:                 INDEX ON STR(Tubos, 2) + Dopes + STR(Numes, 6) TAG Tubos
86: 
87:                 CREATE CURSOR TmpNop ( ;
88:                     Nops       N(10,0),  ;
89:                     Cpros      C(14),    ;

*-- Linhas 123 a 237:
123:                 ENDWITH
124: 
125:                 *-- Vincular eventos base
126:                 BINDEVENT(THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar, ;
127:                     "Click", THIS, "BtnEncerrarClick")
128: 
129:                 *-- Carregar lista inicial
130:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
131:                     THIS.CarregarLista()
132:                 ENDIF
133: 
134:                 THIS.pgf_4c_Paginas.ActivePage = 1
135:                 THIS.this_cModoAtual = "LISTA"
136:                 loc_lSucesso = .T.
137:             ENDIF
138:         CATCH TO loc_oErro
139:             MsgErro("Erro em FormFUN.InicializarForm: " + loc_oErro.Message + ;
140:                 " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Init")
141:             loc_lSucesso = .F.
142:         ENDTRY
143: 
144:         RETURN loc_lSucesso
145:     ENDPROC
146: 
147:     *==========================================================================
148:     PROTECTED PROCEDURE ConfigurarPageFrame()
149:     *==========================================================================
150:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
151: 
152:         WITH THIS.pgf_4c_Paginas
153:             .Top       = -29
154:             .Left      = 0
155:             .Width     = THIS.Width
156:             .Height    = THIS.Height + 29
157:             .PageCount = 2
158:             .Tabs      = .F.
159:             .Visible   = .T.
160:         ENDWITH
161: 
162:         WITH THIS.pgf_4c_Paginas.Page1
163:             .Caption   = "Lista"
164:             .BackColor = RGB(255, 255, 255)
165:         ENDWITH
166: 
167:         WITH THIS.pgf_4c_Paginas.Page2
168:             .Caption   = "Dados"
169:             .BackColor = RGB(255, 255, 255)
170:         ENDWITH
171: 
172:         IF FILE(gc_4c_CaminhoIcones + "fundo_cad_1003.jpg")
173:             THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
174:             THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
175:         ENDIF
176: 
177:         THIS.pgf_4c_Paginas.Visible = .T.
178:     ENDPROC
179: 
180:     *==========================================================================
181:     PROTECTED PROCEDURE ConfigurarPaginaLista()
182:     *==========================================================================
183:         LOCAL loc_oPagina
184:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
185: 
186:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
187:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
188: 
189:         *----------------------------------------------------------------------
190:         * cnt_4c_Cabecalho - Faixa escura superior com titulo do form
191:         * Top canônico: 2 + 29 (compensação PageFrame) = 31
192:         *----------------------------------------------------------------------
193:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
194:         WITH loc_oPagina.cnt_4c_Cabecalho
195:             .Top         = 31
196:             .Left        = 0
197:             .Width       = THIS.Width
198:             .Height      = 80
199:             .BackColor   = RGB(100, 100, 100)
200:             .BackStyle   = 1
201:             .BorderWidth = 0
202:             .SpecialEffect = 0
203:             .Visible     = .T.
204:         ENDWITH
205: 
206:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
207:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
208:             .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
209:             .Top       = 15
210:             .Left      = 10
211:             .Width     = THIS.Width - 20
212:             .Height    = 40
213:             .AutoSize  = .F.
214:             .FontName  = "Tahoma"
215:             .FontSize  = 16
216:             .FontBold  = .T.
217:             .ForeColor = RGB(0, 0, 0)
218:             .BackStyle = 0
219:         ENDWITH
220: 
221:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
222:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
223:             .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
224:             .Top       = 18
225:             .Left      = 10
226:             .Width     = THIS.Width - 20
227:             .Height    = 46
228:             .AutoSize  = .F.
229:             .FontName  = "Tahoma"
230:             .FontSize  = 16
231:             .FontBold  = .T.
232:             .ForeColor = RGB(255, 255, 255)
233:             .BackStyle = 0
234:         ENDWITH
235: 
236:         *----------------------------------------------------------------------
237:         * cnt_4c_Botoes - Container botoes CRUD (Fase 4 adiciona os botoes)

*-- Linhas 378 a 423:
378:             .FontSize  = 8
379:             .BackColor = RGB(255, 255, 255)
380:         ENDWITH
381:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_CdEmpresa, "KeyPress", THIS, "EmpresaLostFocus")
382:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
383:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
384: 
385:         *----------------------------------------------------------------------
386:         * cmd_4c_BtnAguarde - Mensagem de espera durante carregamento
387:         * Original: top=266, left=339, width=322, height=72, visible=false -> comp +29 = 295
388:         *----------------------------------------------------------------------
389:         loc_oPagina.AddObject("cmd_4c_BtnAguarde", "CommandButton")
390:         WITH loc_oPagina.cmd_4c_BtnAguarde
391:             .Caption   = "Aguarde!  Atualizando  Dados . . ."
392:             .Top       = 295
393:             .Left      = 339
394:             .Width     = 322
395:             .Height    = 72
396:             .FontName  = "Tahoma"
397:             .FontSize  = 11
398:             .FontBold  = .T.
399:             .ForeColor = RGB(0, 0, 0)
400:             .BackColor = RGB(200, 200, 200)
401:             .Enabled   = .F.
402:             .Visible   = .F.
403:         ENDWITH
404: 
405:         *----------------------------------------------------------------------
406:         * txt_4c_Botao1 - TextBox display desabilitado na Lista
407:         * Original: Botao1 textbox, top=132, left=438, width=27, height=22 -> comp +29 = 161
408:         *----------------------------------------------------------------------
409:         loc_oPagina.AddObject("txt_4c_Botao1", "TextBox")
410:         WITH loc_oPagina.txt_4c_Botao1
411:             .Value     = ""
412:             .Top       = 161
413:             .Left      = 438
414:             .Width     = 27
415:             .Height    = 22
416:             .FontName  = "Tahoma"
417:             .FontSize  = 8
418:             .BackColor = RGB(255, 255, 255)
419:             .Enabled   = .F.
420:         ENDWITH
421: 
422:         *----------------------------------------------------------------------
423:         * cnt_4c_Botoes ajuste Width para 5 botoes de 75px (5+75+5+75+...= 380)

*-- Linhas 448 a 659:
448:             .WordWrap        = .T.
449:             .AutoSize        = .F.
450:         ENDWITH
451:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
452: 
453:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
454:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
455:             .Caption         = "Visualizar"
456:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
457:             .PicturePosition = 13
458:             .Top             = 5
459:             .Left            = 80
460:             .Width           = 75
461:             .Height          = 75
462:             .FontName        = "Tahoma"
463:             .FontBold        = .T.
464:             .FontItalic      = .T.
465:             .FontSize        = 8
466:             .ForeColor       = RGB(90, 90, 90)
467:             .BackColor       = RGB(255, 255, 255)
468:             .Themes          = .F.
469:             .SpecialEffect   = 0
470:             .MousePointer    = 15
471:             .WordWrap        = .T.
472:             .AutoSize        = .F.
473:         ENDWITH
474:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
475: 
476:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
477:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
478:             .Caption         = "Alterar"
479:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
480:             .PicturePosition = 13
481:             .Top             = 5
482:             .Left            = 155
483:             .Width           = 75
484:             .Height          = 75
485:             .FontName        = "Tahoma"
486:             .FontBold        = .T.
487:             .FontItalic      = .T.
488:             .FontSize        = 8
489:             .ForeColor       = RGB(90, 90, 90)
490:             .BackColor       = RGB(255, 255, 255)
491:             .Themes          = .F.
492:             .SpecialEffect   = 0
493:             .MousePointer    = 15
494:             .WordWrap        = .T.
495:             .AutoSize        = .F.
496:         ENDWITH
497:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
498: 
499:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
500:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
501:             .Caption         = "Excluir"
502:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
503:             .PicturePosition = 13
504:             .Top             = 5
505:             .Left            = 230
506:             .Width           = 75
507:             .Height          = 75
508:             .FontName        = "Tahoma"
509:             .FontBold        = .T.
510:             .FontItalic      = .T.
511:             .FontSize        = 8
512:             .ForeColor       = RGB(90, 90, 90)
513:             .BackColor       = RGB(255, 255, 255)
514:             .Themes          = .F.
515:             .SpecialEffect   = 0
516:             .MousePointer    = 15
517:             .WordWrap        = .T.
518:             .AutoSize        = .F.
519:         ENDWITH
520:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
521: 
522:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
523:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
524:             .Caption         = "Buscar"
525:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
526:             .PicturePosition = 13
527:             .Top             = 5
528:             .Left            = 305
529:             .Width           = 75
530:             .Height          = 75
531:             .FontName        = "Tahoma"
532:             .FontBold        = .T.
533:             .FontItalic      = .T.
534:             .FontSize        = 8
535:             .ForeColor       = RGB(90, 90, 90)
536:             .BackColor       = RGB(255, 255, 255)
537:             .Themes          = .F.
538:             .SpecialEffect   = 0
539:             .MousePointer    = 15
540:             .WordWrap        = .T.
541:             .AutoSize        = .F.
542:         ENDWITH
543:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
544: 
545:         *----------------------------------------------------------------------
546:         * grd_4c_Dados - Grade principal de listagem
547:         * Original: Grade.Top=157, Left=12, Width=944, Height=434 -> comp +29 = 186
548:         * ColumnCount DEVE ser setado FORA do WITH (nao cria colunas dentro do WITH)
549:         *----------------------------------------------------------------------
550:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
551:         loc_oPagina.grd_4c_Dados.ColumnCount = 6
552:         WITH loc_oPagina.grd_4c_Dados
553:             .Top                = 186
554:             .Left               = 12
555:             .Width              = 944
556:             .Height             = 434
557:             .FontName           = "Tahoma"
558:             .FontSize           = 8
559:             .ForeColor          = RGB(90, 90, 90)
560:             .BackColor          = RGB(255, 255, 255)
561:             .GridLineColor      = RGB(238, 158, 162)
562:             .HighlightBackColor = RGB(255, 255, 255)
563:             .HighlightForeColor = RGB(15, 41, 104)
564:             .HighlightStyle     = 2
565:             .DeleteMark         = .F.
566:             .RecordMark         = .F.
567:             .RowHeight          = 16
568:             .ScrollBars         = 2
569:             .GridLines          = 3
570:             .ReadOnly           = .T.
571:             .RecordSource       = "cursor_4c_Dados"
572:             .RecordSourceType   = 1
573:         ENDWITH
574: 
575:         WITH loc_oPagina.grd_4c_Dados.Column1
576:             .ControlSource   = "cursor_4c_Dados.codigos"
577:             .Width           = 70
578:             .Alignment       = 2
579:             .Header1.Caption = "N" + CHR(186) + " Fundi" + CHR(231) + CHR(227) + "o"
580:         ENDWITH
581: 
582:         WITH loc_oPagina.grd_4c_Dados.Column2
583:             .ControlSource   = "cursor_4c_Dados.emps"
584:             .Width           = 60
585:             .Header1.Caption = "Empresa"
586:         ENDWITH
587: 
588:         WITH loc_oPagina.grd_4c_Dados.Column3
589:             .ControlSource   = "cursor_4c_Dados.datas"
590:             .Width           = 140
591:             .Header1.Caption = "Data"
592:         ENDWITH
593: 
594:         WITH loc_oPagina.grd_4c_Dados.Column4
595:             .ControlSource   = "cursor_4c_Dados.codmaqfs"
596:             .Width           = 100
597:             .Header1.Caption = "M" + CHR(225) + "quina"
598:         ENDWITH
599: 
600:         WITH loc_oPagina.grd_4c_Dados.Column5
601:             .ControlSource   = "cursor_4c_Dados.ntubos"
602:             .Width           = 60
603:             .Alignment       = 2
604:             .Header1.Caption = "Tubos"
605:         ENDWITH
606: 
607:         WITH loc_oPagina.grd_4c_Dados.Column6
608:             .ControlSource   = "cursor_4c_Dados.usuars"
609:             .Width           = 100
610:             .Header1.Caption = "Usu" + CHR(225) + "rio"
611:         ENDWITH
612: 
613:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
614: 
615:         THIS.TornarControlesVisiveis(loc_oPagina)
616:     ENDPROC
617: 
618:     *==========================================================================
619:     PROTECTED PROCEDURE ConfigurarPaginaDados()
620:     *==========================================================================
621:         LOCAL loc_oPagina
622:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
623: 
624:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
625:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
626: 
627:         *----------------------------------------------------------------------
628:         * cnt_4c_Salva - Botoes Confirmar/Cancelar (Fase 4 adiciona os botoes)
629:         * Canonico: Top=33, Left=842, Width=160, Height=85
630:         *----------------------------------------------------------------------
631:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
632:         WITH loc_oPagina.cnt_4c_Salva
633:             .Top           = 33
634:             .Left          = 842
635:             .Width         = 160
636:             .Height        = 85
637:             .BackStyle = 1
638:             .BackColor = RGB(255, 255, 255)
639:             .SpecialEffect = 0
640:             .Visible     = .T.
641:         ENDWITH
642: 
643:         *----------------------------------------------------------------------
644:         * cnt_4c_Container2 - 24 checkboxes de tubos + opt_status (Fase 5)
645:         * Original: top=5, left=9, width=296, height=594 -> comp +29 = 34
646:         *----------------------------------------------------------------------
647:         loc_oPagina.AddObject("cnt_4c_Container2", "Container")
648:         WITH loc_oPagina.cnt_4c_Container2
649:             .Top         = 34
650:             .Left        = 9
651:             .Width       = 296
652:             .Height      = 594
653:             .BackStyle   = 1
654:             .BackColor   = RGB(225, 225, 225)
655:             .BorderWidth = 0
656:             .Visible     = .T.
657:         ENDWITH
658: 
659:         *----------------------------------------------------------------------

*-- Linhas 772 a 853:
772:             .WordWrap        = .T.
773:             .AutoSize        = .F.
774:         ENDWITH
775:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
776: 
777:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
778:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
779:             .Caption         = "Encerrar"
780:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
781:             .PicturePosition = 13
782:             .Top             = 5
783:             .Left            = 80
784:             .Width           = 75
785:             .Height          = 75
786:             .FontName        = "Tahoma"
787:             .FontBold        = .T.
788:             .FontItalic      = .T.
789:             .FontSize        = 8
790:             .ForeColor       = RGB(90, 90, 90)
791:             .BackColor       = RGB(255, 255, 255)
792:             .Themes          = .F.
793:             .SpecialEffect   = 0
794:             .MousePointer    = 15
795:             .WordWrap        = .T.
796:             .AutoSize        = .F.
797:         ENDWITH
798:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
799: 
800:         THIS.ConfigurarContainer1(loc_oPagina)
801:         THIS.ConfigurarContainer2(loc_oPagina)
802:         THIS.ConfigurarContainer3(loc_oPagina)
803:         THIS.ConfigurarContainer4(loc_oPagina)
804:         THIS.ConfigurarContainer5(loc_oPagina)
805:         THIS.ConfigurarContainer6(loc_oPagina)
806:         THIS.ConfigurarCntTotal(loc_oPagina)
807:         THIS.ConfigurarCamposPage2(loc_oPagina)
808: 
809:         THIS.TornarControlesVisiveis(loc_oPagina)
810:     ENDPROC
811: 
812:     *==========================================================================
813:     PROTECTED PROCEDURE CarregarArvores()
814:     *==========================================================================
815:         LOCAL loc_nResultado
816:         loc_nResultado = 0
817: 
818:         TRY
819:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
820:                 *-- Sem conexao SQL durante validacao de UI - pular
821:             ELSE
822:                 IF USED("cursor_4c_Arvores")
823:                     USE IN cursor_4c_Arvores
824:                 ENDIF
825: 
826:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
827:                     "SELECT a.codigos, a.descs, a.formulas, a.percs," + ;
828:                     " a.tempmets, a.temptubs, a.tempambs, a.tempagus" + ;
829:                     " FROM sigcdarv a ORDER BY a.codigos", ;
830:                     "cursor_4c_Arvores")
831: 
832:                 IF loc_nResultado < 0
833:                     MsgErro("Erro ao carregar " + CHR(225) + "rvores:" + ;
834:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
835:                 ENDIF
836:             ENDIF
837:         CATCH TO loc_oErro
838:             MsgErro("Erro em FormFUN.CarregarArvores: " + loc_oErro.Message, "Erro")
839:         ENDTRY
840:     ENDPROC
841: 
842:     *==========================================================================
843:     FUNCTION CarregarLista()
844:     *==========================================================================
845:         LOCAL loc_lSucesso, loc_cFiltro
846:         LOCAL loc_cEmps, loc_dDtIni, loc_dDtFim
847:         LOCAL loc_cDtIniSQL, loc_cDtFimSQL
848:         loc_lSucesso = .F.
849: 
850:         TRY
851:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
852:                 loc_lSucesso = .T.
853:             ELSE

*-- Linhas 885 a 1288:
885:                     " AND a.datas >= " + loc_cDtIniSQL + ;
886:                     " AND a.datas <= " + loc_cDtFimSQL
887: 
888:                 loc_lSucesso = THIS.this_oBusinessObject.Buscar(loc_cFiltro)
889: 
890:                 *-- Re-definir ControlSources apos Buscar() recriar cursor_4c_Dados (autobind por posicao)
891:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5) AND USED("cursor_4c_Dados")
892:                     LOCAL loc_oGrd
893:                     loc_oGrd = THIS.pgf_4c_Paginas.Page1.grd_4c_Dados
894:                     loc_oGrd.ColumnCount = 6
895:                     loc_oGrd.RecordSource          = "cursor_4c_Dados"
896:                     loc_oGrd.Column1.ControlSource = "cursor_4c_Dados.codigos"
897:                     loc_oGrd.Column2.ControlSource = "cursor_4c_Dados.emps"
898:                     loc_oGrd.Column3.ControlSource = "cursor_4c_Dados.datas"
899:                     loc_oGrd.Column4.ControlSource = "cursor_4c_Dados.codmaqfs"
900:                     loc_oGrd.Column5.ControlSource = "cursor_4c_Dados.ntubos"
901:                     loc_oGrd.Column6.ControlSource = "cursor_4c_Dados.usuars"
902:                 ENDIF
903: 
904:                 *-- Ocultar aguarde
905:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
906:             ENDIF
907:         CATCH TO loc_oErro
908:             MsgErro("Erro em FormFUN.CarregarLista: " + loc_oErro.Message, "Erro")
909:             TRY
910:                 THIS.pgf_4c_Paginas.Page1.cmd_4c_BtnAguarde.Visible = .F.
911:             CATCH
912:             ENDTRY
913:             loc_lSucesso = .F.
914:         ENDTRY
915: 
916:         RETURN loc_lSucesso
917:     ENDFUNC
918: 
919:     *==========================================================================
920:     PROCEDURE AlternarPagina(par_nPagina)
921:     *==========================================================================
922:         LOCAL loc_lSucesso
923:         loc_lSucesso = .F.
924: 
925:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
926:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
927: 
928:             IF par_nPagina = 1
929:                 THIS.this_cModoAtual = "LISTA"
930:                 THIS.CarregarLista()
931:             ENDIF
932: 
933:             loc_lSucesso = .T.
934:         ENDIF
935: 
936:         RETURN loc_lSucesso
937:     ENDPROC
938: 
939:     *==========================================================================
940:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
941:     *==========================================================================
942:         LOCAL loc_i, loc_oObjeto, loc_cNome
943: 
944:         FOR loc_i = 1 TO par_oContainer.ControlCount
945:             loc_oObjeto = par_oContainer.Controls(loc_i)
946: 
947:             IF VARTYPE(loc_oObjeto) != "O"
948:                 LOOP
949:             ENDIF
950: 
951:             loc_cNome = UPPER(loc_oObjeto.Name)
952: 
953:             *-- cnt_4c_Total inicia oculto - recursao nos filhos mas nao altera Visible
954:             IF loc_cNome = "CNT_4C_TOTAL"
955:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
956:                     THIS.TornarControlesVisiveis(loc_oObjeto)
957:                 ENDIF
958:                 LOOP
959:             ENDIF
960: 
961:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
962:                 loc_oObjeto.Visible = .T.
963:             ENDIF
964: 
965:             *-- PageFrame: iterar Pages
966:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
967:                 LOCAL loc_p
968:                 FOR loc_p = 1 TO loc_oObjeto.PageCount
969:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_p))
970:                 ENDFOR
971:             ENDIF
972: 
973:             *-- Container/Page: recursao nos filhos
974:             IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
975:                 THIS.TornarControlesVisiveis(loc_oObjeto)
976:             ENDIF
977:         ENDFOR
978:     ENDPROC
979: 
980:     *==========================================================================
981:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
982:     *==========================================================================
983:         WITH par_oGrid
984:             .FontName = "Verdana"
985:             .FontSize = 8
986:         ENDWITH
987:     ENDPROC
988: 
989:     *==========================================================================
990:     PROCEDURE BtnEncerrarClick()
991:     *==========================================================================
992:         THIS.Release()
993:     ENDPROC
994: 
995:     *==========================================================================
996:     PROCEDURE BtnIncluirClick()
997:     *==========================================================================
998:         LOCAL loc_lSucesso
999:         loc_lSucesso = .F.
1000: 
1001:         TRY
1002:             THIS.this_oBusinessObject.NovoRegistro()
1003:             THIS.LimparCampos()
1004:             THIS.this_cModoAtual = "INCLUIR"
1005:             THIS.this_lEmEdicao  = .T.
1006:             THIS.AlternarPagina(2)
1007:             THIS.AtualizarEstadoControles()
1008:             loc_lSucesso = .T.
1009:         CATCH TO loc_oErro
1010:             MsgErro("Erro em FormFUN.BtnIncluirClick: " + loc_oErro.Message, "Erro")
1011:         ENDTRY
1012: 
1013:         RETURN loc_lSucesso
1014:     ENDPROC
1015: 
1016:     *==========================================================================
1017:     PROCEDURE BtnAlterarClick()
1018:     *==========================================================================
1019:         LOCAL loc_nCodigos, loc_lSucesso
1020:         loc_lSucesso = .F.
1021: 
1022:         TRY
1023:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1024:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1025:             ELSE
1026:                 SELECT cursor_4c_Dados
1027:                 loc_nCodigos = cursor_4c_Dados.codigos
1028: 
1029:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1030:                     THIS.BOParaForm()
1031:                     THIS.this_cModoAtual = "ALTERAR"
1032:                     THIS.this_lEmEdicao  = .T.
1033:                     THIS.AlternarPagina(2)
1034:                     THIS.ChkTubo(1)
1035:                     THIS.AtualizarEstadoControles()
1036:                     loc_lSucesso = .T.
1037:                 ENDIF
1038:             ENDIF
1039:         CATCH TO loc_oErro
1040:             MsgErro("Erro em FormFUN.BtnAlterarClick: " + loc_oErro.Message, "Erro")
1041:         ENDTRY
1042: 
1043:         RETURN loc_lSucesso
1044:     ENDPROC
1045: 
1046:     *==========================================================================
1047:     PROCEDURE BtnVisualizarClick()
1048:     *==========================================================================
1049:         LOCAL loc_nCodigos, loc_lSucesso
1050:         loc_lSucesso = .F.
1051: 
1052:         TRY
1053:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1054:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1055:             ELSE
1056:                 SELECT cursor_4c_Dados
1057:                 loc_nCodigos = cursor_4c_Dados.codigos
1058: 
1059:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1060:                     THIS.BOParaForm()
1061:                     THIS.this_cModoAtual = "VISUALIZAR"
1062:                     THIS.this_lEmEdicao  = .F.
1063:                     THIS.AlternarPagina(2)
1064:                     THIS.ChkTubo(1)
1065:                     THIS.AtualizarEstadoControles()
1066:                     loc_lSucesso = .T.
1067:                 ENDIF
1068:             ENDIF
1069:         CATCH TO loc_oErro
1070:             MsgErro("Erro em FormFUN.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
1071:         ENDTRY
1072: 
1073:         RETURN loc_lSucesso
1074:     ENDPROC
1075: 
1076:     *==========================================================================
1077:     PROCEDURE BtnExcluirClick()
1078:     *==========================================================================
1079:         LOCAL loc_nCodigos, loc_lSucesso
1080:         loc_lSucesso = .F.
1081: 
1082:         TRY
1083:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1084:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1085:             ELSE
1086:                 SELECT cursor_4c_Dados
1087:                 loc_nCodigos = cursor_4c_Dados.codigos
1088: 
1089:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da fundi" + CHR(231) + ;
1090:                     CHR(227) + "o " + TRANSFORM(loc_nCodigos) + "?", "Excluir")
1091:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1092:                         IF THIS.this_oBusinessObject.Excluir()
1093:                             THIS.CarregarLista()
1094:                             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1095:                                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1096:                             ENDIF
1097:                             loc_lSucesso = .T.
1098:                         ENDIF
1099:                     ENDIF
1100:                 ENDIF
1101:             ENDIF
1102:         CATCH TO loc_oErro
1103:             MsgErro("Erro em FormFUN.BtnExcluirClick: " + loc_oErro.Message, "Erro")
1104:         ENDTRY
1105: 
1106:         RETURN loc_lSucesso
1107:     ENDPROC
1108: 
1109:     *==========================================================================
1110:     PROCEDURE BtnBuscarClick()
1111:     *==========================================================================
1112:         TRY
1113:             THIS.CarregarLista()
1114:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1115:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1116:             ENDIF
1117:         CATCH TO loc_oErro
1118:             MsgErro("Erro em FormFUN.BtnBuscarClick: " + loc_oErro.Message, "Erro")
1119:         ENDTRY
1120:     ENDPROC
1121: 
1122:     *==========================================================================
1123:     PROCEDURE BtnSalvarClick()
1124:     *==========================================================================
1125:         LOCAL loc_lSucesso
1126:         loc_lSucesso = .F.
1127: 
1128:         TRY
1129:             THIS.SalvarDadosTubo()
1130:             THIS.FormParaBO()
1131: 
1132:             IF THIS.this_oBusinessObject.Salvar()
1133:                 MsgInfo("Registro salvo com sucesso!", "Salvo")
1134:                 THIS.this_lEmEdicao  = .F.
1135:                 THIS.this_cModoAtual = "LISTA"
1136:                 THIS.AlternarPagina(1)
1137:                 THIS.AtualizarEstadoControles()
1138:                 loc_lSucesso = .T.
1139:             ELSE
1140:                 MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao salvar")
1141:             ENDIF
1142:         CATCH TO loc_oErro
1143:             MsgErro("Erro em FormFUN.BtnSalvarClick: " + loc_oErro.Message, "Erro")
1144:         ENDTRY
1145: 
1146:         RETURN loc_lSucesso
1147:     ENDPROC
1148: 
1149:     *==========================================================================
1150:     PROCEDURE BtnCancelarClick()
1151:     *==========================================================================
1152:         LOCAL loc_lSucesso, loc_lContinuar
1153:         loc_lSucesso  = .F.
1154:         loc_lContinuar = .T.
1155: 
1156:         IF THIS.this_lEmEdicao
1157:             IF !MsgConfirma("Deseja cancelar a edi" + CHR(231) + CHR(227) + "o?", "Cancelar")
1158:                 loc_lContinuar = .F.
1159:             ENDIF
1160:         ENDIF
1161: 
1162:         IF loc_lContinuar
1163:             TRY
1164:                 THIS.this_lEmEdicao  = .F.
1165:                 THIS.this_cModoAtual = "LISTA"
1166:                 THIS.AlternarPagina(1)
1167:                 THIS.AtualizarEstadoControles()
1168:                 loc_lSucesso = .T.
1169:             CATCH TO loc_oErro
1170:                 MsgErro("Erro em FormFUN.BtnCancelarClick: " + loc_oErro.Message, "Erro")
1171:             ENDTRY
1172:         ENDIF
1173: 
1174:         RETURN loc_lSucesso
1175:     ENDPROC
1176: 
1177:     *==========================================================================
1178:     PROCEDURE AtualizarEstadoControles()
1179:     *==========================================================================
1180:         LOCAL loc_lEmLista, loc_lEmEdicao, loc_oPg1, loc_oPg2, loc_lOk
1181:         loc_lEmLista  = (THIS.this_cModoAtual = "LISTA")
1182:         loc_lEmEdicao = !loc_lEmLista
1183:         loc_lOk = TYPE("THIS.pgf_4c_Paginas") = "O" AND !ISNULL(THIS.pgf_4c_Paginas)
1184: 
1185:         TRY
1186:             IF loc_lOk
1187:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1188:                 IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1189:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1190:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
1191:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1192:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
1193:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
1194:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
1195:                     ENDIF
1196:                 ENDIF
1197: 
1198:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1199:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1200:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1201:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1202:                             (loc_lEmEdicao AND THIS.this_cModoAtual != "VISUALIZAR")
1203:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1204:                     ENDIF
1205:                 ENDIF
1206:             ENDIF
1207:         CATCH TO loc_oErro
1208:             MsgErro("Erro em FormFUN.AtualizarEstadoControles: " + loc_oErro.Message, "Erro")
1209:         ENDTRY
1210:     ENDPROC
1211: 
1212:     *==========================================================================
1213:     PROCEDURE Destroy()
1214:     *==========================================================================
1215:         TRY
1216:             IF USED("TmpCera")
1217:                 USE IN TmpCera
1218:             ENDIF
1219:             IF USED("TmpTrf")
1220:                 USE IN TmpTrf
1221:             ENDIF
1222:             IF USED("TmpNop")
1223:                 USE IN TmpNop
1224:             ENDIF
1225:             IF USED("cursor_4c_Arvores")
1226:                 USE IN cursor_4c_Arvores
1227:             ENDIF
1228:             IF USED("cursor_4c_Dados")
1229:                 USE IN cursor_4c_Dados
1230:             ENDIF
1231:             IF USED("cursor_4c_TubosFund")
1232:                 USE IN cursor_4c_TubosFund
1233:             ENDIF
1234:             IF USED("cursor_4c_BuscaAux")
1235:                 USE IN cursor_4c_BuscaAux
1236:             ENDIF
1237:             IF USED("cursor_4c_TmpTot")
1238:                 USE IN cursor_4c_TmpTot
1239:             ENDIF
1240:         CATCH
1241:             *-- Silencioso no Destroy
1242:         ENDTRY
1243: 
1244:         DODEFAULT()
1245:     ENDPROC
1246: 
1247:     *==========================================================================
1248:     PROTECTED PROCEDURE ConfigurarContainer1(par_oPagina)
1249:     *==========================================================================
1250:         LOCAL loc_oCnt
1251:         loc_oCnt = par_oPagina.cnt_4c_Container1
1252: 
1253:         *-- lbl_4c_FundNo (Say2): "Fundicao No :"
1254:         loc_oCnt.AddObject("lbl_4c_FundNo", "Label")
1255:         WITH loc_oCnt.lbl_4c_FundNo
1256:             .Caption   = "Fundi" + CHR(231) + CHR(227) + "o N" + CHR(186) + " :"
1257:             .Left      = 5
1258:             .Top       = 10
1259:             .AutoSize  = .T.
1260:             .FontBold  = .T.
1261:             .BackStyle = 0
1262:             .ForeColor = RGB(36, 84, 155)
1263:         ENDWITH
1264: 
1265:         *-- txt_4c_Codigos (getCodigos): numero sequencial, somente leitura
1266:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
1267:         WITH loc_oCnt.txt_4c_Codigos
1268:             .Value     = 0
1269:             .InputMask = "999999"
1270:             .MaxLength = 7
1271:             .Left      = 96
1272:             .Top       = 5
1273:             .Width     = 52
1274:             .Height    = 25
1275:             .ReadOnly  = .T.
1276:         ENDWITH
1277: 
1278:         *-- lbl_4c_MaquinaLabel (Say4): "Maquina :"
1279:         loc_oCnt.AddObject("lbl_4c_MaquinaLabel", "Label")
1280:         WITH loc_oCnt.lbl_4c_MaquinaLabel
1281:             .Caption   = "M" + CHR(225) + "quina :"
1282:             .Left      = 188
1283:             .Top       = 10
1284:             .AutoSize  = .T.
1285:             .FontBold  = .T.
1286:             .BackStyle = 0
1287:             .ForeColor = RGB(36, 84, 155)
1288:         ENDWITH

*-- Linhas 1297 a 1340:
1297:             .Width     = 79
1298:             .Height    = 25
1299:         ENDWITH
1300:         BINDEVENT(loc_oCnt.txt_4c_Maq, "KeyPress", THIS, "ValidarMaquina")
1301: 
1302:         *-- lbl_4c_DataLabel (Say3): "Data :"
1303:         loc_oCnt.AddObject("lbl_4c_DataLabel", "Label")
1304:         WITH loc_oCnt.lbl_4c_DataLabel
1305:             .Caption   = "Data :"
1306:             .Left      = 54
1307:             .Top       = 41
1308:             .AutoSize  = .T.
1309:             .FontBold  = .T.
1310:             .BackStyle = 0
1311:             .ForeColor = RGB(36, 84, 155)
1312:         ENDWITH
1313: 
1314:         *-- txt_4c_Datas (getDatas): data da fundicao
1315:         loc_oCnt.AddObject("txt_4c_Datas", "TextBox")
1316:         WITH loc_oCnt.txt_4c_Datas
1317:             .Value     = {}
1318:             .MaxLength = 10
1319:             .Left      = 96
1320:             .Top       = 36
1321:             .Width     = 79
1322:             .Height    = 25
1323:         ENDWITH
1324: 
1325:         *-- lbl_4c_UsuarioLabel (Say1): "Usuario :"
1326:         loc_oCnt.AddObject("lbl_4c_UsuarioLabel", "Label")
1327:         WITH loc_oCnt.lbl_4c_UsuarioLabel
1328:             .Caption   = "Usu" + CHR(225) + "rio :"
1329:             .Left      = 192
1330:             .Top       = 41
1331:             .AutoSize  = .T.
1332:             .FontBold  = .T.
1333:             .BackStyle = 0
1334:             .ForeColor = RGB(36, 84, 155)
1335:         ENDWITH
1336: 
1337:         *-- txt_4c_Usu (Getusu): usuario que registrou, sempre somente leitura
1338:         loc_oCnt.AddObject("txt_4c_Usu", "TextBox")
1339:         WITH loc_oCnt.txt_4c_Usu
1340:             .Value     = ""

*-- Linhas 1348 a 1458:
1348:     ENDPROC
1349: 
1350:     *==========================================================================
1351:     PROTECTED PROCEDURE ConfigurarContainer2(par_oPagina)
1352:     *==========================================================================
1353:         LOCAL loc_oCnt, loc_oChk, loc_cNomeChk, loc_n
1354:         LOCAL loc_nRow, loc_nCol, loc_nLeft, loc_nTop, loc_cPic
1355:         LOCAL ARRAY loc_aTops[6]
1356:         LOCAL ARRAY loc_aLefts[4]
1357: 
1358:         loc_oCnt = par_oPagina.cnt_4c_Container2
1359: 
1360:         *-- Cor vermelha conforme legado (BackStyle=0 = transparente sobre fundo vermelho)
1361:         loc_oCnt.BackColor = RGB(255, 0, 0)
1362:         loc_oCnt.BackStyle = 0
1363: 
1364:         *-- lbl_4c_Tubos (Label1): cabecalho da secao de tubos
1365:         loc_oCnt.AddObject("lbl_4c_Tubos", "Label")
1366:         WITH loc_oCnt.lbl_4c_Tubos
1367:             .Caption   = "\<Tubos"
1368:             .Left      = 5
1369:             .Top       = 1
1370:             .AutoSize  = .T.
1371:             .FontName  = "Verdana"
1372:             .FontBold  = .T.
1373:             .FontSize  = 8
1374:             .BackStyle = 0
1375:             .ForeColor = RGB(36, 84, 155)
1376:             .BackColor = RGB(210, 210, 210)
1377:         ENDWITH
1378: 
1379:         *-- opt_4c_Status: OptionGroup 4 opcoes de status (Nenhum/Cera/Fundir/Peca)
1380:         loc_oCnt.AddObject("opt_4c_Status", "OptionGroup")
1381:         WITH loc_oCnt.opt_4c_Status
1382:             .ButtonCount    = 4
1383:             .Left           = 69
1384:             .Top            = -3
1385:             .Width          = 228
1386:             .Height         = 25
1387:             .AutoSize       = .T.
1388:             .BackStyle      = 0
1389:             .Buttons(1).Caption  = "Nenhum"
1390:             .Buttons(1).Left     = 5
1391:             .Buttons(1).Top      = 5
1392:             .Buttons(1).AutoSize = .T.
1393:             .Buttons(2).Caption  = "Cera"
1394:             .Buttons(2).Left     = 72
1395:             .Buttons(2).Top      = 5
1396:             .Buttons(2).AutoSize = .T.
1397:             .Buttons(3).Caption  = "Fundir"
1398:             .Buttons(3).Left     = 120
1399:             .Buttons(3).Top      = 5
1400:             .Buttons(3).Width    = 54
1401:             .Buttons(3).Height   = 15
1402:             .Buttons(3).AutoSize = .T.
1403:             .Buttons(3).FontName = "Verdana"
1404:             .Buttons(3).FontSize = 8
1405:             .Buttons(3).BackStyle = 0
1406:             .Buttons(3).ForeColor = RGB(36, 84, 155)
1407:             .Buttons(4).Caption  = "Pe" + CHR(231) + "a"
1408:             .Buttons(4).Left     = 177
1409:             .Buttons(4).Top      = 5
1410:             .Buttons(4).Width    = 46
1411:             .Buttons(4).Height   = 15
1412:             .Buttons(4).AutoSize = .T.
1413:             .Buttons(4).FontName = "Verdana"
1414:             .Buttons(4).FontSize = 8
1415:             .Buttons(4).BackStyle = 0
1416:             .Buttons(4).ForeColor = RGB(36, 84, 155)
1417:         ENDWITH
1418:         BINDEVENT(loc_oCnt.opt_4c_Status, "InteractiveChange", THIS, "OptStatusChanged")
1419: 
1420:         *-- 24 CheckBoxes: grade 4 colunas x 6 linhas (Style=1 grafico, PicturePosition=13)
1421:         *   Colunas  Left: 3, 76, 149, 222
1422:         *   Linhas   Top:  20, 116, 212, 308, 404, 500
1423:         loc_aTops[1]  = 20
1424:         loc_aTops[2]  = 116
1425:         loc_aTops[3]  = 212
1426:         loc_aTops[4]  = 308
1427:         loc_aTops[5]  = 404
1428:         loc_aTops[6]  = 500
1429:         loc_aLefts[1] = 3
1430:         loc_aLefts[2] = 76
1431:         loc_aLefts[3] = 149
1432:         loc_aLefts[4] = 222
1433: 
1434:         FOR loc_n = 1 TO 24
1435:             loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1436:             loc_nRow = INT((loc_n - 1) / 4) + 1
1437:             loc_nCol = MOD(loc_n - 1, 4) + 1
1438:             loc_nTop  = loc_aTops[loc_nRow]
1439:             loc_nLeft = loc_aLefts[loc_nCol]
1440: 
1441:             DO CASE
1442:                 CASE loc_n = 1
1443:                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1444:                 CASE loc_n = 2
1445:                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1446:                 CASE loc_n = 3
1447:                     loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
1448:                 OTHERWISE
1449:                     loc_cPic = ""
1450:             ENDCASE
1451: 
1452:             loc_oCnt.AddObject(loc_cNomeChk, "CheckBox")
1453:             loc_oChk = EVALUATE("loc_oCnt." + loc_cNomeChk)
1454:             WITH loc_oChk
1455:                 .Caption         = PADL(TRANSFORM(loc_n), 2, "0")
1456:                 .Style           = 1
1457:                 .PicturePosition = 13
1458:                 .Alignment       = 0

*-- Linhas 1470 a 1638:
1470:             IF !EMPTY(loc_cPic) AND FILE(loc_cPic)
1471:                 loc_oCnt.Picture = loc_cPic
1472:             ENDIF
1473:             BINDEVENT(loc_oChk, "Click", THIS, "ChkTuboClick")
1474:         ENDFOR
1475:     ENDPROC
1476: 
1477:     *==========================================================================
1478:     PROCEDURE ChkTuboClick()
1479:     *==========================================================================
1480:         LOCAL loc_cTag, loc_nTubo
1481: 
1482:         TRY
1483:             loc_cTag  = _VFP.ActiveForm.ActiveControl.Tag
1484:             loc_nTubo = 0
1485:             IF LEFT(loc_cTag, 5) = "TUBE:"
1486:                 loc_nTubo = VAL(SUBSTR(loc_cTag, 6))
1487:             ENDIF
1488:             IF loc_nTubo > 0
1489:                 THIS.ChkTubo(loc_nTubo)
1490:             ENDIF
1491:         CATCH TO loc_oErro
1492:             MsgErro("Erro em FormFUN.ChkTuboClick: " + loc_oErro.Message, "Erro")
1493:         ENDTRY
1494:     ENDPROC
1495: 
1496:     *==========================================================================
1497:     PROCEDURE OptStatusChanged()
1498:     *==========================================================================
1499:         LOCAL loc_nStatus, loc_nMaqTubos, loc_n, loc_cNomeChk, loc_oCnt
1500: 
1501:         TRY
1502:             loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1503:             loc_nStatus   = loc_oCnt.opt_4c_Status.Value
1504:             loc_nMaqTubos = THIS.this_nMaqTubos
1505: 
1506:             FOR loc_n = 1 TO loc_nMaqTubos
1507:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1508:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1509:                     IF loc_oCnt.Value = 1
1510:                         SELECT TmpCera
1511:                         SET ORDER TO Tubos
1512:                         IF SEEK(STR(loc_n, 2))
1513:                             DO CASE
1514:                                 CASE loc_nStatus = 1
1515:                                     REPLACE nStatus WITH 1 IN TmpCera
1516:                                     loc_oCnt.Picture = ""
1517:                                 CASE loc_nStatus = 2
1518:                                     REPLACE nStatus WITH 2 IN TmpCera
1519:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1520:                                 CASE loc_nStatus = 3
1521:                                     REPLACE nStatus WITH 3 IN TmpCera
1522:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1523:                                 CASE loc_nStatus = 4
1524:                                     REPLACE nStatus WITH 4 IN TmpCera
1525:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
1526:                             ENDCASE
1527:                         ENDIF
1528:                     ENDIF
1529:                 ENDIF
1530:             ENDFOR
1531:         CATCH TO loc_oErro
1532:             MsgErro("Erro em FormFUN.OptStatusChanged: " + loc_oErro.Message, "Erro")
1533:         ENDTRY
1534:     ENDPROC
1535: 
1536:     *==========================================================================
1537:     PROCEDURE ValidarMaquina(par_nKeyCode, par_nShiftAltCtrl)
1538:     *==========================================================================
1539:         LOCAL loc_cCodMaq, loc_nResultado, loc_nTubos, loc_oCnt1
1540: 
1541:         TRY
1542:             loc_oCnt1   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1543:             loc_cCodMaq = ALLTRIM(loc_oCnt1.txt_4c_Maq.Value)
1544: 
1545:             IF EMPTY(loc_cCodMaq)
1546:                 THIS.this_nMaqTubos = 0
1547:                 THIS.AtualizarVisibilidadeCheckboxes(0)
1548:             ELSE
1549:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1550:                     "SELECT m.codigos, m.tubos FROM SigCfMqf m WHERE m.codigos = " + ;
1551:                     EscaparSQL(loc_cCodMaq), ;
1552:                     "cursor_4c_BuscaMaq")
1553: 
1554:                 loc_nTubos = 0
1555:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaMaq") AND ;
1556:                         RECCOUNT("cursor_4c_BuscaMaq") > 0
1557:                     SELECT cursor_4c_BuscaMaq
1558:                     loc_nTubos = cursor_4c_BuscaMaq.tubos
1559:                     THIS.this_nMaqTubos = loc_nTubos
1560:                     THIS.AtualizarVisibilidadeCheckboxes(loc_nTubos)
1561:                 ELSE
1562:                     MsgAviso("M" + CHR(225) + "quina '" + loc_cCodMaq + ;
1563:                         "' n" + CHR(227) + "o encontrada.", ;
1564:                         "M" + CHR(225) + "quina")
1565:                     loc_oCnt1.txt_4c_Maq.Value = ""
1566:                     THIS.this_nMaqTubos = 0
1567:                     THIS.AtualizarVisibilidadeCheckboxes(0)
1568:                 ENDIF
1569: 
1570:                 IF USED("cursor_4c_BuscaMaq")
1571:                     USE IN cursor_4c_BuscaMaq
1572:                 ENDIF
1573:             ENDIF
1574:         CATCH TO loc_oErro
1575:             MsgErro("Erro em FormFUN.ValidarMaquina: " + loc_oErro.Message, "Erro")
1576:         ENDTRY
1577:     ENDPROC
1578: 
1579:     *==========================================================================
1580:     PROTECTED PROCEDURE AtualizarVisibilidadeCheckboxes(par_nMaqTubos)
1581:     *==========================================================================
1582:         LOCAL loc_oCnt, loc_n, loc_cNomeChk
1583: 
1584:         TRY
1585:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1586:             FOR loc_n = 1 TO 24
1587:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1588:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1589:                     loc_oCnt.Visible = (loc_n <= par_nMaqTubos)
1590:                 ENDIF
1591:             ENDFOR
1592:         CATCH TO loc_oErro
1593:             MsgErro("Erro em FormFUN.AtualizarVisibilidadeCheckboxes: " + loc_oErro.Message, "Erro")
1594:         ENDTRY
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     PROCEDURE ChkTubo(par_nTubo)
1599:     *==========================================================================
1600:         LOCAL loc_n, loc_nMaqTubos, loc_oCnt, loc_cNomeChk, loc_cPic
1601: 
1602:         TRY
1603:             *-- Salvar dados do tubo anterior antes de trocar
1604:             IF THIS.this_nTuboAtual > 0 AND THIS.this_nTuboAtual != par_nTubo
1605:                 THIS.SalvarDadosTubo()
1606:             ENDIF
1607: 
1608:             THIS.this_nTuboAtual = par_nTubo
1609:             loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1610:             loc_nMaqTubos = THIS.this_nMaqTubos
1611: 
1612:             *-- Atualizar caption do tubo corrente em Container4 (se lbl_4c_SayTubo existir)
1613:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "lbl_4c_SayTubo", 5)
1614:                 IF par_nTubo > 0
1615:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = ;
1616:                         "( " + PADL(TRANSFORM(par_nTubo), 2, "0") + " )"
1617:                 ELSE
1618:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = "( )"
1619:                 ENDIF
1620:             ENDIF
1621: 
1622:             *-- Atualizar imagens dos checkboxes baseado em TmpTrf/TmpNop/TmpCera
1623:             FOR loc_n = 1 TO loc_nMaqTubos
1624:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1625:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1626:                     loc_cPic = ""
1627: 
1628:                     *-- Tubo com transformacao metalica em andamento
1629:                     IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
1630:                         SELECT TmpTrf
1631:                         SET ORDER TO 0
1632:                         LOCATE FOR TmpTrf.Tubos = loc_n
1633:                         IF FOUND()
1634:                             loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1635:                         ENDIF
1636:                     ENDIF
1637: 
1638:                     *-- Tubo com peca pronta (ordem de producao concluida)

*-- Linhas 1709 a 1792:
1709:                     SELECT TmpTrf
1710:                     SET ORDER TO Tubos
1711:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
1712:                     GO TOP
1713:                 ENDIF
1714:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_Gradenop", 5)
1715:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_Gradenop.Refresh()
1716:                 ENDIF
1717:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
1718:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
1719:                 ENDIF
1720:             ELSE
1721:                 THIS.LimparCamposTubo()
1722:             ENDIF
1723:         CATCH TO loc_oErro
1724:             MsgErro("Erro em FormFUN.ChkTubo " + TRANSFORM(par_nTubo) + ": " + ;
1725:                 loc_oErro.Message, "Erro")
1726:         ENDTRY
1727:     ENDPROC
1728: 
1729:     *==========================================================================
1730:     PROCEDURE LimparCampos()
1731:     *==========================================================================
1732:         LOCAL loc_oCnt1, loc_oCnt2, loc_oCnt3, loc_n, loc_cNomeChk
1733: 
1734:         TRY
1735:             loc_oCnt1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1736:             loc_oCnt2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1737: 
1738:             *-- Limpar campos do cabecalho (Container1)
1739:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Codigos", 5)
1740:                 loc_oCnt1.txt_4c_Codigos.Value = 0
1741:             ENDIF
1742:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
1743:                 loc_oCnt1.txt_4c_Datas.Value = {}
1744:             ENDIF
1745:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Usu", 5)
1746:                 loc_oCnt1.txt_4c_Usu.Value = ""
1747:             ENDIF
1748:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
1749:                 loc_oCnt1.txt_4c_Maq.Value = ""
1750:             ENDIF
1751: 
1752:             *-- Resetar OptionGroup e checkboxes (Container2)
1753:             IF PEMSTATUS(loc_oCnt2, "opt_4c_Status", 5)
1754:                 loc_oCnt2.opt_4c_Status.Value = 1
1755:             ENDIF
1756: 
1757:             FOR loc_n = 1 TO 24
1758:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1759:                 IF PEMSTATUS(loc_oCnt2, loc_cNomeChk, 5)
1760:                     loc_oCnt2.Value   = 0
1761:                     loc_oCnt2.Picture = ""
1762:                 ENDIF
1763:             ENDFOR
1764: 
1765:             *-- Zerar cursores de trabalho
1766:             IF USED("TmpCera")
1767:                 ZAP IN TmpCera
1768:             ENDIF
1769:             IF USED("TmpTrf")
1770:                 ZAP IN TmpTrf
1771:             ENDIF
1772:             IF USED("TmpNop")
1773:                 ZAP IN TmpNop
1774:             ENDIF
1775: 
1776:             THIS.this_nMaqTubos  = 0
1777:             THIS.this_nTuboAtual = 0
1778:             THIS.AtualizarVisibilidadeCheckboxes(0)
1779: 
1780:             *-- Limpar campos de entrada de Container3 se ja existem
1781:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
1782:             IF PEMSTATUS(loc_oCnt3, "txt_4c_Nop", 5)
1783:                 loc_oCnt3.txt_4c_Nop.Value  = 0
1784:                 loc_oCnt3.txt_4c_QtTb.Value = 0
1785:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
1786:                     loc_oCnt3.txt_4c_Qtd.Value = 0
1787:                 ENDIF
1788:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
1789:                     loc_oCnt3.txt_4c_Pecas.Value = 0
1790:                 ENDIF
1791:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
1792:                     loc_oCnt3.txt_4c_Operacao.Value = ""

*-- Linhas 1812 a 1855:
1812:     ENDPROC
1813: 
1814:     *==========================================================================
1815:     PROCEDURE BOParaForm()
1816:     *==========================================================================
1817:         LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_nResultado, loc_nCodigos
1818:         LOCAL loc_n, loc_cNomeChk, loc_cPic
1819:         LOCAL loc_nTubo, loc_nBCeras, loc_nBases, loc_nCeras, loc_nPMetals
1820:         LOCAL loc_cCodCors, loc_mObss, loc_cTmpMets, loc_cTmpAmbs
1821:         LOCAL loc_cTmpTubs, loc_cTmpAgus, loc_cCodArvs, loc_cDescs
1822:         LOCAL loc_mFormulas, loc_nMetalNvs, loc_nPmetalrs, loc_nNStatus
1823: 
1824:         TRY
1825:             loc_oBO      = THIS.this_oBusinessObject
1826:             loc_oCnt1    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1827:             loc_oCnt2    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1828:             loc_nCodigos = loc_oBO.this_nCodigos
1829: 
1830:             *-- Preencher Container1 com dados do cabecalho (SIGCDFUN)
1831:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Codigos", 5)
1832:                 loc_oCnt1.txt_4c_Codigos.Value = loc_nCodigos
1833:             ENDIF
1834:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
1835:                 loc_oCnt1.txt_4c_Datas.Value = loc_oBO.this_dDatas
1836:             ENDIF
1837:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Usu", 5)
1838:                 loc_oCnt1.txt_4c_Usu.Value = ALLTRIM(loc_oBO.this_cUsuars)
1839:             ENDIF
1840:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
1841:                 loc_oCnt1.txt_4c_Maq.Value = ALLTRIM(loc_oBO.this_cCodMaqfs)
1842:             ENDIF
1843: 
1844:             *-- Numero de tubos da maquina -> visibilidade dos checkboxes
1845:             THIS.this_nMaqTubos = loc_oBO.this_nNTubos
1846:             THIS.AtualizarVisibilidadeCheckboxes(THIS.this_nMaqTubos)
1847: 
1848:             *-- Limpar cursores antes de recarregar
1849:             IF USED("TmpCera")
1850:                 ZAP IN TmpCera
1851:             ENDIF
1852:             IF USED("TmpTrf")
1853:                 ZAP IN TmpTrf
1854:             ENDIF
1855:             IF USED("TmpNop")

*-- Linhas 2023 a 2179:
2023:     ENDPROC
2024: 
2025:     *==========================================================================
2026:     PROCEDURE FormParaBO()
2027:     *==========================================================================
2028:         LOCAL loc_oBO, loc_oCnt1
2029: 
2030:         TRY
2031:             loc_oBO   = THIS.this_oBusinessObject
2032:             loc_oCnt1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
2033: 
2034:             *-- Transferir campos editaveis do cabecalho para o BO
2035:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
2036:                 loc_oBO.this_dDatas = loc_oCnt1.txt_4c_Datas.Value
2037:             ENDIF
2038:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
2039:                 loc_oBO.this_cCodMaqfs = ALLTRIM(loc_oCnt1.txt_4c_Maq.Value)
2040:             ENDIF
2041: 
2042:             *-- Usuario e empresa (preenchidos automaticamente)
2043:             loc_oBO.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
2044:             loc_oBO.this_cEmps   = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
2045: 
2046:             *-- Numero de tubos da maquina corrente
2047:             loc_oBO.this_nNTubos = THIS.this_nMaqTubos
2048: 
2049:             *-- Observacao geral
2050:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "edt_4c_ObsG", 5)
2051:                 loc_oBO.this_mObsG = ;
2052:                     ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.edt_4c_ObsG.Value)
2053:             ENDIF
2054: 
2055:         CATCH TO loc_oErro
2056:             MsgErro("Erro em FormFUN.FormParaBO: " + loc_oErro.Message, "Erro")
2057:         ENDTRY
2058:     ENDPROC
2059: 
2060:     *==========================================================================
2061:     PROTECTED PROCEDURE ConfigurarContainer3(par_oPagina)
2062:     *==========================================================================
2063:         LOCAL loc_oCnt
2064:         loc_oCnt = par_oPagina.cnt_4c_Container3
2065: 
2066:         loc_oCnt.AddObject("lbl_4c_SayNop", "Label")
2067:         WITH loc_oCnt.lbl_4c_SayNop
2068:             .Caption   = "O.P. n" + CHR(186) + " :"
2069:             .Left      = 20
2070:             .Top       = 6
2071:             .AutoSize  = .T.
2072:             .FontBold  = .T.
2073:             .BackStyle = 0
2074:             .ForeColor = RGB(36, 84, 155)
2075:         ENDWITH
2076: 
2077:         loc_oCnt.AddObject("txt_4c_Nop", "TextBox")
2078:         WITH loc_oCnt.txt_4c_Nop
2079:             .Value     = 0
2080:             .InputMask = "9999999999"
2081:             .Left      = 73
2082:             .Top       = 4
2083:             .Width     = 94
2084:             .Height    = 20
2085:             .FontName  = "Tahoma"
2086:             .FontSize  = 8
2087:         ENDWITH
2088:         BINDEVENT(loc_oCnt.txt_4c_Nop, "KeyPress", THIS, "NopLostFocus")
2089: 
2090:         loc_oCnt.AddObject("lbl_4c_SayComp", "Label")
2091:         WITH loc_oCnt.lbl_4c_SayComp
2092:             .Caption   = "Componentes:"
2093:             .Left      = 171
2094:             .Top       = 6
2095:             .AutoSize  = .T.
2096:             .FontBold  = .T.
2097:             .BackStyle = 0
2098:             .ForeColor = RGB(36, 84, 155)
2099:         ENDWITH
2100: 
2101:         loc_oCnt.AddObject("txt_4c_Qtd", "TextBox")
2102:         WITH loc_oCnt.txt_4c_Qtd
2103:             .Value     = 0
2104:             .Left      = 260
2105:             .Top       = 4
2106:             .Width     = 87
2107:             .Height    = 20
2108:             .ReadOnly  = .T.
2109:             .FontName  = "Tahoma"
2110:             .FontSize  = 8
2111:             .BackColor = RGB(240, 240, 240)
2112:         ENDWITH
2113: 
2114:         loc_oCnt.AddObject("lbl_4c_SayQtTb", "Label")
2115:         WITH loc_oCnt.lbl_4c_SayQtTb
2116:             .Caption   = "Qtde Tubo :"
2117:             .Left      = 2
2118:             .Top       = 27
2119:             .AutoSize  = .T.
2120:             .FontBold  = .T.
2121:             .BackStyle = 0
2122:             .ForeColor = RGB(36, 84, 155)
2123:         ENDWITH
2124: 
2125:         loc_oCnt.AddObject("txt_4c_QtTb", "TextBox")
2126:         WITH loc_oCnt.txt_4c_QtTb
2127:             .Value     = 0
2128:             .InputMask = "9999999999.999"
2129:             .Left      = 73
2130:             .Top       = 25
2131:             .Width     = 94
2132:             .Height    = 20
2133:             .FontName  = "Tahoma"
2134:             .FontSize  = 8
2135:         ENDWITH
2136:         BINDEVENT(loc_oCnt.txt_4c_QtTb, "KeyPress", THIS, "QtTbLostFocus")
2137: 
2138:         loc_oCnt.AddObject("lbl_4c_SayPecas", "Label")
2139:         WITH loc_oCnt.lbl_4c_SayPecas
2140:             .Caption   = "Qtd. Pe" + CHR(231) + "as :"
2141:             .Left      = 185
2142:             .Top       = 27
2143:             .AutoSize  = .T.
2144:             .FontBold  = .T.
2145:             .BackStyle = 0
2146:             .ForeColor = RGB(36, 84, 155)
2147:         ENDWITH
2148: 
2149:         loc_oCnt.AddObject("txt_4c_Pecas", "TextBox")
2150:         WITH loc_oCnt.txt_4c_Pecas
2151:             .Value     = 0
2152:             .Left      = 260
2153:             .Top       = 25
2154:             .Width     = 87
2155:             .Height    = 20
2156:             .ReadOnly  = .T.
2157:             .FontName  = "Tahoma"
2158:             .FontSize  = 8
2159:             .BackColor = RGB(240, 240, 240)
2160:         ENDWITH
2161: 
2162:         loc_oCnt.AddObject("grd_4c_Gradenop", "Grid")
2163:         loc_oCnt.grd_4c_Gradenop.ColumnCount = 5
2164:         WITH loc_oCnt.grd_4c_Gradenop
2165:             .Top                     = 48
2166:             .Left                    = 7
2167:             .Width                   = 435
2168:             .Height                  = 122
2169:             .RecordSource            = "TmpNop"
2170:             .FontName                = "Tahoma"
2171:             .FontSize                = 8
2172:             .ReadOnly                = .T.
2173:             .GridLines               = 1
2174:             .HeaderHeight            = 17
2175:             .RowHeight               = 17
2176:             .Column1.Header1.Caption = "O.P."
2177:             .Column1.ControlSource   = "TmpNop.Nops"
2178:             .Column1.Width           = 60
2179:             .Column2.Header1.Caption = "Produto"

*-- Linhas 2189 a 2515:
2189:             .Column5.ControlSource   = "TmpNop.DtEnts"
2190:             .Column5.Width           = 90
2191:             .RecordMark   = .F.
2192:             .DeleteMark   = .F.
2193:         ENDWITH
2194:         BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")
2195: 
2196:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
2197:         WITH loc_oCnt.txt_4c_Operacao
2198:             .Value     = ""
2199:             .Left      = 18
2200:             .Top       = 171
2201:             .Width     = 290
2202:             .Height    = 25
2203:             .ReadOnly  = .T.
2204:             .FontName  = "Tahoma"
2205:             .FontSize  = 8
2206:             .BackColor = RGB(240, 240, 240)
2207:         ENDWITH
2208: 
2209:         loc_oCnt.AddObject("cmd_4c_AdicionarNop", "CommandButton")
2210:         WITH loc_oCnt.cmd_4c_AdicionarNop
2211:             .Caption         = ""
2212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2213:             .PicturePosition = 4
2214:             .Top             = 172
2215:             .Left            = 384
2216:             .Width           = 40
2217:             .Height          = 40
2218:             .Themes          = .T.
2219:             .SpecialEffect   = 0
2220:             .MousePointer    = 15
2221:         ENDWITH
2222:         BINDEVENT(loc_oCnt.cmd_4c_AdicionarNop, "Click", THIS, "AdicionarNopClick")
2223: 
2224:         loc_oCnt.AddObject("lbl_4c_SayCopiar", "Label")
2225:         WITH loc_oCnt.lbl_4c_SayCopiar
2226:             .Caption   = "Copiar Tubo :"
2227:             .Left      = 5
2228:             .Top       = 232
2229:             .AutoSize  = .T.
2230:             .FontBold  = .T.
2231:             .BackStyle = 0
2232:             .ForeColor = RGB(36, 84, 155)
2233:         ENDWITH
2234: 
2235:         loc_oCnt.AddObject("txt_4c_Tubo", "TextBox")
2236:         WITH loc_oCnt.txt_4c_Tubo
2237:             .Value     = 0
2238:             .InputMask = "99"
2239:             .Left      = 89
2240:             .Top       = 230
2241:             .Width     = 21
2242:             .Height    = 20
2243:             .FontName  = "Tahoma"
2244:             .FontSize  = 8
2245:         ENDWITH
2246:         BINDEVENT(loc_oCnt.txt_4c_Tubo, "KeyPress", THIS, "TuboLostFocus")
2247: 
2248:         loc_oCnt.AddObject("chk_4c_ChkRep", "CheckBox")
2249:         WITH loc_oCnt.chk_4c_ChkRep
2250:             .Caption   = "Repetir nosTubos"
2251:             .Left      = 5
2252:             .Top       = 253
2253:             .Width     = 118
2254:             .Height    = 15
2255:             .Value     = 0
2256:             .FontName  = "Tahoma"
2257:             .FontSize  = 8
2258:             .BackStyle = 0
2259:         ENDWITH
2260: 
2261:         loc_oCnt.AddObject("lbl_4c_SayTrf", "Label")
2262:         WITH loc_oCnt.lbl_4c_SayTrf
2263:             .Caption   = "Transforma" + CHR(231) + CHR(245) + "es :"
2264:             .Left      = 5
2265:             .Top       = 275
2266:             .AutoSize  = .T.
2267:             .FontBold  = .T.
2268:             .BackStyle = 0
2269:             .ForeColor = RGB(36, 84, 155)
2270:         ENDWITH
2271: 
2272:         loc_oCnt.AddObject("txt_4c_Trf", "TextBox")
2273:         WITH loc_oCnt.txt_4c_Trf
2274:             .Value     = ""
2275:             .MaxLength = 20
2276:             .Left      = 108
2277:             .Top       = 273
2278:             .Width     = 80
2279:             .Height    = 20
2280:             .FontName  = "Tahoma"
2281:             .FontSize  = 8
2282:         ENDWITH
2283:         BINDEVENT(loc_oCnt.txt_4c_Trf, "KeyPress", THIS, "TrfLostFocus")
2284: 
2285:         loc_oCnt.AddObject("grd_4c_GradeTrf", "Grid")
2286:         loc_oCnt.grd_4c_GradeTrf.ColumnCount = 2
2287:         WITH loc_oCnt.grd_4c_GradeTrf
2288:             .Top                     = 216
2289:             .Left                    = 209
2290:             .Width                   = 233
2291:             .Height                  = 122
2292:             .RecordSource            = "TmpTrf"
2293:             .FontName                = "Tahoma"
2294:             .FontSize                = 8
2295:             .ReadOnly                = .T.
2296:             .GridLines               = 1
2297:             .HeaderHeight            = 17
2298:             .RowHeight               = 17
2299:             .Column1.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2300:             .Column1.ControlSource   = "TmpTrf.Dopes"
2301:             .Column1.Width           = 155
2302:             .Column2.Header1.Caption = "Numes"
2303:             .Column2.ControlSource   = "TmpTrf.Numes"
2304:             .Column2.Width           = 55
2305:             .RecordMark   = .F.
2306:             .DeleteMark   = .F.
2307:         ENDWITH
2308: 
2309:         loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
2310:         WITH loc_oCnt.cmd_4c_RemoverTrf
2311:             .Caption         = ""
2312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2313:             .PicturePosition = 4
2314:             .Top             = 297
2315:             .Left            = 165
2316:             .Width           = 40
2317:             .Height          = 40
2318:             .Themes          = .T.
2319:             .SpecialEffect   = 0
2320:             .MousePointer    = 15
2321:         ENDWITH
2322:         BINDEVENT(loc_oCnt.cmd_4c_RemoverTrf, "Click", THIS, "RemoverTrfClick")
2323:     ENDPROC
2324: 
2325:     *==========================================================================
2326:     PROTECTED PROCEDURE ConfigurarContainer4(par_oPagina)
2327:     *==========================================================================
2328:         LOCAL loc_oCnt
2329:         loc_oCnt = par_oPagina.cnt_4c_Container4
2330: 
2331:         loc_oCnt.AddObject("lbl_4c_ObsTubo", "Label")
2332:         WITH loc_oCnt.lbl_4c_ObsTubo
2333:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Tubo"
2334:             .Left      = 14
2335:             .Top       = 3
2336:             .AutoSize  = .T.
2337:             .FontBold  = .T.
2338:             .BackStyle = 0
2339:             .ForeColor = RGB(36, 84, 155)
2340:         ENDWITH
2341: 
2342:         loc_oCnt.AddObject("lbl_4c_SayTubo", "Label")
2343:         WITH loc_oCnt.lbl_4c_SayTubo
2344:             .Caption   = "( )"
2345:             .Left      = 148
2346:             .Top       = 3
2347:             .AutoSize  = .T.
2348:             .BackStyle = 0
2349:             .ForeColor = RGB(36, 84, 155)
2350:         ENDWITH
2351: 
2352:         loc_oCnt.AddObject("lbl_4c_ObsGeral", "Label")
2353:         WITH loc_oCnt.lbl_4c_ObsGeral
2354:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o Geral"
2355:             .Left      = 342
2356:             .Top       = 2
2357:             .AutoSize  = .T.
2358:             .FontBold  = .T.
2359:             .BackStyle = 0
2360:             .ForeColor = RGB(36, 84, 155)
2361:         ENDWITH
2362: 
2363:         loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
2364:         WITH loc_oCnt.edt_4c_Obs
2365:             .Value      = ""
2366:             .Left       = 9
2367:             .Top        = 19
2368:             .Width      = 328
2369:             .Height     = 95
2370:             .FontName   = "Tahoma"
2371:             .FontSize   = 8
2372:             .ScrollBars = 2
2373:         ENDWITH
2374:         BINDEVENT(loc_oCnt.edt_4c_Obs, "LostFocus", THIS, "SalvarDadosTubo")
2375: 
2376:         loc_oCnt.AddObject("edt_4c_ObsG", "EditBox")
2377:         WITH loc_oCnt.edt_4c_ObsG
2378:             .Value      = ""
2379:             .Left       = 340
2380:             .Top        = 18
2381:             .Width      = 328
2382:             .Height     = 95
2383:             .FontName   = "Tahoma"
2384:             .FontSize   = 8
2385:             .ScrollBars = 2
2386:         ENDWITH
2387:     ENDPROC
2388: 
2389:     *==========================================================================
2390:     PROTECTED PROCEDURE ConfigurarContainer5(par_oPagina)
2391:     *==========================================================================
2392:         LOCAL loc_oCnt
2393:         loc_oCnt = par_oPagina.cnt_4c_Container5
2394: 
2395:         loc_oCnt.AddObject("lbl_4c_ConvTitle", "Label")
2396:         WITH loc_oCnt.lbl_4c_ConvTitle
2397:             .Caption   = "Convers" + CHR(227) + "o Cera/Metal"
2398:             .Left      = 4
2399:             .Top       = 2
2400:             .AutoSize  = .T.
2401:             .FontBold  = .T.
2402:             .BackStyle = 0
2403:             .ForeColor = RGB(36, 84, 155)
2404:         ENDWITH
2405: 
2406:         loc_oCnt.AddObject("lbl_4c_CorLabel", "Label")
2407:         WITH loc_oCnt.lbl_4c_CorLabel
2408:             .Caption   = "Cor"
2409:             .Left      = 5
2410:             .Top       = 19
2411:             .AutoSize  = .T.
2412:             .BackStyle = 0
2413:             .ForeColor = RGB(36, 84, 155)
2414:         ENDWITH
2415: 
2416:         loc_oCnt.AddObject("txt_4c_Cor", "TextBox")
2417:         WITH loc_oCnt.txt_4c_Cor
2418:             .Value     = ""
2419:             .MaxLength = 4
2420:             .Left      = 5
2421:             .Top       = 33
2422:             .Width     = 38
2423:             .Height    = 23
2424:             .FontName  = "Tahoma"
2425:             .FontSize  = 8
2426:         ENDWITH
2427:         BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress",  THIS, "CorKeyPress")
2428:         BINDEVENT(loc_oCnt.txt_4c_Cor, "DblClick",  THIS, "CorDblClick")
2429:         BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress", THIS, "ValidarCor")
2430: 
2431:         loc_oCnt.AddObject("lbl_4c_BasecLabel", "Label")
2432:         WITH loc_oCnt.lbl_4c_BasecLabel
2433:             .Caption   = "Base Cera"
2434:             .Left      = 45
2435:             .Top       = 19
2436:             .AutoSize  = .T.
2437:             .BackStyle = 0
2438:             .ForeColor = RGB(36, 84, 155)
2439:         ENDWITH
2440: 
2441:         loc_oCnt.AddObject("txt_4c_Basec", "TextBox")
2442:         WITH loc_oCnt.txt_4c_Basec
2443:             .Value     = 0
2444:             .InputMask = "999999999.99"
2445:             .Left      = 44
2446:             .Top       = 33
2447:             .Width     = 100
2448:             .Height    = 23
2449:             .FontName  = "Tahoma"
2450:             .FontSize  = 8
2451:         ENDWITH
2452:         BINDEVENT(loc_oCnt.txt_4c_Basec, "KeyPress", THIS, "BasecLostFocus")
2453: 
2454:         loc_oCnt.AddObject("lbl_4c_BaseLabel", "Label")
2455:         WITH loc_oCnt.lbl_4c_BaseLabel
2456:             .Caption   = "Base"
2457:             .Left      = 145
2458:             .Top       = 20
2459:             .AutoSize  = .T.
2460:             .BackStyle = 0
2461:             .ForeColor = RGB(36, 84, 155)
2462:         ENDWITH
2463: 
2464:         loc_oCnt.AddObject("txt_4c_Base", "TextBox")
2465:         WITH loc_oCnt.txt_4c_Base
2466:             .Value     = 0
2467:             .InputMask = "999999999.99"
2468:             .Left      = 144
2469:             .Top       = 33
2470:             .Width     = 100
2471:             .Height    = 23
2472:             .FontName  = "Tahoma"
2473:             .FontSize  = 8
2474:         ENDWITH
2475:         BINDEVENT(loc_oCnt.txt_4c_Base, "KeyPress", THIS, "BaseLostFocus")
2476: 
2477:         loc_oCnt.AddObject("lbl_4c_CeraLabel", "Label")
2478:         WITH loc_oCnt.lbl_4c_CeraLabel
2479:             .Caption   = "Cera"
2480:             .Left      = 5
2481:             .Top       = 61
2482:             .AutoSize  = .T.
2483:             .BackStyle = 0
2484:             .ForeColor = RGB(36, 84, 155)
2485:         ENDWITH
2486: 
2487:         loc_oCnt.AddObject("txt_4c_Cera", "TextBox")
2488:         WITH loc_oCnt.txt_4c_Cera
2489:             .Value     = 0
2490:             .InputMask = "999999999.99"
2491:             .Left      = 5
2492:             .Top       = 74
2493:             .Width     = 83
2494:             .Height    = 23
2495:             .ReadOnly  = .T.
2496:             .FontName  = "Tahoma"
2497:             .FontSize  = 8
2498:             .BackColor = RGB(240, 240, 240)
2499:         ENDWITH
2500: 
2501:         loc_oCnt.AddObject("lbl_4c_PesoMetalLabel", "Label")
2502:         WITH loc_oCnt.lbl_4c_PesoMetalLabel
2503:             .Caption   = "Peso Metal"
2504:             .Left      = 88
2505:             .Top       = 61
2506:             .AutoSize  = .T.
2507:             .BackStyle = 0
2508:             .ForeColor = RGB(36, 84, 155)
2509:         ENDWITH
2510: 
2511:         loc_oCnt.AddObject("txt_4c_Metal", "TextBox")
2512:         WITH loc_oCnt.txt_4c_Metal
2513:             .Value     = 0
2514:             .InputMask = "999999999.99"
2515:             .Left      = 88

*-- Linhas 2543 a 2735:
2543:             .FontName  = "Tahoma"
2544:             .FontSize  = 8
2545:         ENDWITH
2546:         BINDEVENT(loc_oCnt.txt_4c_Mreal, "LostFocus", THIS, "SalvarDadosTubo")
2547: 
2548:         loc_oCnt.AddObject("lbl_4c_MetalNovoLabel", "Label")
2549:         WITH loc_oCnt.lbl_4c_MetalNovoLabel
2550:             .Caption   = "Metal Novo"
2551:             .Left      = 106
2552:             .Top       = 102
2553:             .AutoSize  = .T.
2554:             .BackStyle = 0
2555:             .ForeColor = RGB(36, 84, 155)
2556:         ENDWITH
2557: 
2558:         loc_oCnt.AddObject("txt_4c_metnovo", "TextBox")
2559:         WITH loc_oCnt.txt_4c_metnovo
2560:             .Value     = 0
2561:             .InputMask = "999999999.99"
2562:             .Left      = 106
2563:             .Top       = 115
2564:             .Width     = 100
2565:             .Height    = 23
2566:             .ReadOnly  = .T.
2567:             .FontName  = "Tahoma"
2568:             .FontSize  = 8
2569:             .BackColor = RGB(240, 240, 240)
2570:         ENDWITH
2571:     ENDPROC
2572: 
2573:     *==========================================================================
2574:     PROTECTED PROCEDURE ConfigurarContainer6(par_oPagina)
2575:     *==========================================================================
2576:         LOCAL loc_oCnt
2577:         loc_oCnt = par_oPagina.cnt_4c_Container6
2578: 
2579:         loc_oCnt.AddObject("lbl_4c_TempFundTitle", "Label")
2580:         WITH loc_oCnt.lbl_4c_TempFundTitle
2581:             .Caption   = "Temperatura Fundi" + CHR(231) + CHR(227) + "o"
2582:             .Left      = 5
2583:             .Top       = 2
2584:             .AutoSize  = .T.
2585:             .FontBold  = .T.
2586:             .BackStyle = 0
2587:             .ForeColor = RGB(36, 84, 155)
2588:         ENDWITH
2589: 
2590:         loc_oCnt.AddObject("lbl_4c_TempMetLabel", "Label")
2591:         WITH loc_oCnt.lbl_4c_TempMetLabel
2592:             .Caption   = "Metal"
2593:             .Left      = 5
2594:             .Top       = 20
2595:             .AutoSize  = .T.
2596:             .BackStyle = 0
2597:             .ForeColor = RGB(36, 84, 155)
2598:         ENDWITH
2599: 
2600:         loc_oCnt.AddObject("txt_4c_TempMet", "TextBox")
2601:         WITH loc_oCnt.txt_4c_TempMet
2602:             .Value     = ""
2603:             .MaxLength = 15
2604:             .Left      = 5
2605:             .Top       = 36
2606:             .Width     = 115
2607:             .Height    = 23
2608:             .FontName  = "Tahoma"
2609:             .FontSize  = 8
2610:         ENDWITH
2611:         BINDEVENT(loc_oCnt.txt_4c_TempMet, "LostFocus", THIS, "SalvarDadosTubo")
2612: 
2613:         loc_oCnt.AddObject("lbl_4c_TempTubLabel", "Label")
2614:         WITH loc_oCnt.lbl_4c_TempTubLabel
2615:             .Caption   = "Tubo"
2616:             .Left      = 123
2617:             .Top       = 20
2618:             .AutoSize  = .T.
2619:             .BackStyle = 0
2620:             .ForeColor = RGB(36, 84, 155)
2621:         ENDWITH
2622: 
2623:         loc_oCnt.AddObject("txt_4c_TempTub", "TextBox")
2624:         WITH loc_oCnt.txt_4c_TempTub
2625:             .Value     = ""
2626:             .MaxLength = 15
2627:             .Left      = 123
2628:             .Top       = 36
2629:             .Width     = 115
2630:             .Height    = 23
2631:             .FontName  = "Tahoma"
2632:             .FontSize  = 8
2633:         ENDWITH
2634:         BINDEVENT(loc_oCnt.txt_4c_TempTub, "LostFocus", THIS, "SalvarDadosTubo")
2635: 
2636:         loc_oCnt.AddObject("lbl_4c_TempRevTitle", "Label")
2637:         WITH loc_oCnt.lbl_4c_TempRevTitle
2638:             .Caption   = "Temperatura Revestimento"
2639:             .Left      = 4
2640:             .Top       = 61
2641:             .AutoSize  = .T.
2642:             .FontBold  = .T.
2643:             .BackStyle = 0
2644:             .ForeColor = RGB(36, 84, 155)
2645:         ENDWITH
2646: 
2647:         loc_oCnt.AddObject("lbl_4c_TempAmbLabel", "Label")
2648:         WITH loc_oCnt.lbl_4c_TempAmbLabel
2649:             .Caption   = "Ambiente"
2650:             .Left      = 5
2651:             .Top       = 77
2652:             .AutoSize  = .T.
2653:             .BackStyle = 0
2654:             .ForeColor = RGB(36, 84, 155)
2655:         ENDWITH
2656: 
2657:         loc_oCnt.AddObject("txt_4c_TempAmb", "TextBox")
2658:         WITH loc_oCnt.txt_4c_TempAmb
2659:             .Value     = ""
2660:             .MaxLength = 15
2661:             .Left      = 5
2662:             .Top       = 93
2663:             .Width     = 115
2664:             .Height    = 23
2665:             .FontName  = "Tahoma"
2666:             .FontSize  = 8
2667:         ENDWITH
2668:         BINDEVENT(loc_oCnt.txt_4c_TempAmb, "LostFocus", THIS, "SalvarDadosTubo")
2669: 
2670:         loc_oCnt.AddObject("lbl_4c_TempAguLabel", "Label")
2671:         WITH loc_oCnt.lbl_4c_TempAguLabel
2672:             .Caption   = CHR(193) + "gua"
2673:             .Left      = 123
2674:             .Top       = 77
2675:             .AutoSize  = .T.
2676:             .BackStyle = 0
2677:             .ForeColor = RGB(36, 84, 155)
2678:         ENDWITH
2679: 
2680:         loc_oCnt.AddObject("txt_4c_TempAgu", "TextBox")
2681:         WITH loc_oCnt.txt_4c_TempAgu
2682:             .Value     = ""
2683:             .MaxLength = 15
2684:             .Left      = 123
2685:             .Top       = 93
2686:             .Width     = 115
2687:             .Height    = 23
2688:             .FontName  = "Tahoma"
2689:             .FontSize  = 8
2690:         ENDWITH
2691:         BINDEVENT(loc_oCnt.txt_4c_TempAgu, "LostFocus", THIS, "SalvarDadosTubo")
2692:     ENDPROC
2693: 
2694:     *==========================================================================
2695:     PROTECTED PROCEDURE ConfigurarCntTotal(par_oPagina)
2696:     *==========================================================================
2697:         LOCAL loc_oCnt
2698:         loc_oCnt = par_oPagina.cnt_4c_Total
2699: 
2700:         loc_oCnt.AddObject("lbl_4c_TotalMetal", "Label")
2701:         WITH loc_oCnt.lbl_4c_TotalMetal
2702:             .Caption   = "Total de Metal"
2703:             .Left      = 6
2704:             .Top       = 5
2705:             .AutoSize  = .T.
2706:             .FontBold  = .T.
2707:             .BackStyle = 0
2708:             .ForeColor = RGB(36, 84, 155)
2709:         ENDWITH
2710: 
2711:         loc_oCnt.AddObject("grd_4c_TmpTot", "Grid")
2712:         loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
2713:         WITH loc_oCnt.grd_4c_TmpTot
2714:             .Top                     = 49
2715:             .Left                    = 28
2716:             .Width                   = 354
2717:             .Height                  = 122
2718:             .FontName                = "Tahoma"
2719:             .FontSize                = 8
2720:             .ReadOnly                = .T.
2721:             .GridLines               = 1
2722:             .HeaderHeight            = 17
2723:             .RowHeight               = 17
2724:             .Column1.Header1.Caption = "Tipo " + CHR(193) + "rvore"
2725:             .Column1.Width           = 80
2726:             .Column2.Header1.Caption = "Metal Real"
2727:             .Column2.Width           = 80
2728:             .Column3.Header1.Caption = "Metal Novo"
2729:             .Column3.Width           = 80
2730:             .Column4.Header1.Caption = "Metal Ligado"
2731:             .Column4.Width           = 80
2732:             .RecordMark   = .F.
2733:             .DeleteMark   = .F.
2734:         ENDWITH
2735: 

*-- Linhas 2754 a 3173:
2754:             .WordWrap        = .T.
2755:             .AutoSize        = .F.
2756:         ENDWITH
2757:         BINDEVENT(loc_oCnt.cmd_4c_Retornar, "Click", THIS, "BtnCancelarTotalClick")
2758:     ENDPROC
2759: 
2760:     *==========================================================================
2761:     PROTECTED PROCEDURE ConfigurarCamposPage2(par_oPagina)
2762:     *==========================================================================
2763:         *-- lbl_4c_TipoArvoreLabel: Say4 top=98+29=127, left=327
2764:         par_oPagina.AddObject("lbl_4c_TipoArvoreLabel", "Label")
2765:         WITH par_oPagina.lbl_4c_TipoArvoreLabel
2766:             .Caption   = "Tipo " + CHR(193) + "rvore :"
2767:             .Left      = 327
2768:             .Top       = 127
2769:             .AutoSize  = .T.
2770:             .FontBold  = .T.
2771:             .BackStyle = 0
2772:             .ForeColor = RGB(36, 84, 155)
2773:         ENDWITH
2774: 
2775:         *-- txt_4c_codarvore: top=93+29=122, left=416
2776:         par_oPagina.AddObject("txt_4c_codarvore", "TextBox")
2777:         WITH par_oPagina.txt_4c_codarvore
2778:             .Value     = ""
2779:             .MaxLength = 10
2780:             .Left      = 416
2781:             .Top       = 122
2782:             .Width     = 79
2783:             .Height    = 25
2784:             .FontName  = "Tahoma"
2785:             .FontSize  = 8
2786:         ENDWITH
2787:         BINDEVENT(par_oPagina.txt_4c_codarvore, "KeyPress",  THIS, "ArvoreKeyPress")
2788:         BINDEVENT(par_oPagina.txt_4c_codarvore, "DblClick",  THIS, "ArvoreDblClick")
2789:         BINDEVENT(par_oPagina.txt_4c_codarvore, "KeyPress", THIS, "ValidarArvore")
2790: 
2791:         *-- txt_4c_descarvore: top=93+29=122, left=497
2792:         par_oPagina.AddObject("txt_4c_descarvore", "TextBox")
2793:         WITH par_oPagina.txt_4c_descarvore
2794:             .Value     = ""
2795:             .MaxLength = 40
2796:             .Left      = 497
2797:             .Top       = 122
2798:             .Width     = 200
2799:             .Height    = 25
2800:             .ReadOnly  = .T.
2801:             .FontName  = "Tahoma"
2802:             .FontSize  = 8
2803:             .BackColor = RGB(240, 240, 240)
2804:         ENDWITH
2805:         BINDEVENT(par_oPagina.txt_4c_descarvore, "KeyPress", THIS, "ArvoreDescKeyPress")
2806:         BINDEVENT(par_oPagina.txt_4c_descarvore, "DblClick", THIS, "ArvoreDescDblClick")
2807: 
2808:         *-- cmd_4c_BtnTotal: top=12+29=41, left=718
2809:         par_oPagina.AddObject("cmd_4c_BtnTotal", "CommandButton")
2810:         WITH par_oPagina.cmd_4c_BtnTotal
2811:             .Caption         = "Total Metal"
2812:             .Picture         = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
2813:             .PicturePosition = 13
2814:             .Top             = 41
2815:             .Left            = 718
2816:             .Width           = 80
2817:             .Height          = 100
2818:             .FontName        = "Tahoma"
2819:             .FontBold        = .T.
2820:             .FontItalic      = .T.
2821:             .FontSize        = 8
2822:             .ForeColor       = RGB(90, 90, 90)
2823:             .BackColor       = RGB(255, 255, 255)
2824:             .Themes          = .F.
2825:             .SpecialEffect   = 0
2826:             .MousePointer    = 15
2827:             .WordWrap        = .T.
2828:             .AutoSize        = .F.
2829:         ENDWITH
2830:         BINDEVENT(par_oPagina.cmd_4c_BtnTotal, "Click", THIS, "BtnTotalClick")
2831:     ENDPROC
2832: 
2833:     *==========================================================================
2834:     PROCEDURE SalvarDadosTubo()
2835:     *==========================================================================
2836:         LOCAL loc_oCnt4, loc_oCnt5, loc_oCnt6, loc_lSucesso
2837:         loc_lSucesso = .F.
2838: 
2839:         TRY
2840:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2841:                 SELECT TmpCera
2842:                 SET ORDER TO Tubos
2843:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
2844:                     loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
2845:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2846:                     loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
2847: 
2848:                     IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
2849:                         REPLACE Obss WITH loc_oCnt4.edt_4c_Obs.Value IN TmpCera
2850:                     ENDIF
2851:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Mreal", 5)
2852:                         REPLACE pmetalrs WITH NVL(loc_oCnt5.txt_4c_Mreal.Value, 0) IN TmpCera
2853:                     ENDIF
2854:                     IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
2855:                         REPLACE TempMets WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempMet.Value, "")) IN TmpCera
2856:                         REPLACE TempTubs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempTub.Value, "")) IN TmpCera
2857:                         REPLACE TempAmbs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempAmb.Value, "")) IN TmpCera
2858:                         REPLACE TempAgus WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempAgu.Value, "")) IN TmpCera
2859:                     ENDIF
2860:                     loc_lSucesso = .T.
2861:                 ENDIF
2862:             ENDIF
2863:         CATCH TO loc_oErro
2864:             MsgErro("Erro em FormFUN.SalvarDadosTubo: " + loc_oErro.Message, "Erro")
2865:         ENDTRY
2866: 
2867:         RETURN loc_lSucesso
2868:     ENDPROC
2869: 
2870:     *==========================================================================
2871:     PROCEDURE CorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2872:     *==========================================================================
2873:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2874:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2875:             THIS.AbrirLookupCor()
2876:         ENDIF
2877:     ENDPROC
2878: 
2879:     *==========================================================================
2880:     PROCEDURE CorDblClick()
2881:     *==========================================================================
2882:         THIS.AbrirLookupCor()
2883:     ENDPROC
2884: 
2885:     *==========================================================================
2886:     PROCEDURE AbrirLookupCor()
2887:     *==========================================================================
2888:         LOCAL loc_oCnt5, loc_cAtual, loc_oBusca
2889: 
2890:         TRY
2891:             loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2892:             loc_cAtual = ALLTRIM(NVL(loc_oCnt5.txt_4c_Cor.Value, ""))
2893: 
2894:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
2895:                 "SigCdCor", ;
2896:                 "cgrus", ;
2897:                 loc_cAtual, ;
2898:                 loc_oCnt5.txt_4c_Cor, ;
2899:                 "Selecionar Cor", ;
2900:                 .T., .T., "")
2901:             IF VARTYPE(loc_oBusca) = "O"
2902:                 loc_oBusca.mAddColuna("cgrus", "9999", "C" + CHR(243) + "digo")
2903:                 loc_oBusca.mAddColuna("descs", "X(30)", "Descri" + CHR(231) + CHR(227) + "o")
2904:                 loc_oBusca.Show()
2905:                 THIS.ValidarCor()
2906:             ENDIF
2907:         CATCH TO loc_oErro
2908:             MsgErro("Erro em FormFUN.AbrirLookupCor: " + loc_oErro.Message, "Erro")
2909:         ENDTRY
2910:     ENDPROC
2911: 
2912:     *==========================================================================
2913:     PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
2914:     *==========================================================================
2915:         LOCAL loc_oCnt5, loc_cCodCor, loc_nResultado, loc_lSucesso
2916:         loc_lSucesso = .F.
2917: 
2918:         TRY
2919:             loc_oCnt5   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2920:             loc_cCodCor = ALLTRIM(NVL(loc_oCnt5.txt_4c_Cor.Value, ""))
2921: 
2922:             IF EMPTY(loc_cCodCor)
2923:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2924:                     SELECT TmpCera
2925:                     SET ORDER TO Tubos
2926:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
2927:                         REPLACE CodCors WITH "" IN TmpCera
2928:                     ENDIF
2929:                 ENDIF
2930:                 loc_lSucesso = .T.
2931:             ELSE
2932:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2933:                     "SELECT c.cgrus FROM SigCdCor c WHERE c.cgrus = " + ;
2934:                     EscaparSQL(loc_cCodCor), ;
2935:                     "cursor_4c_BuscaCor")
2936: 
2937:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaCor") AND ;
2938:                         RECCOUNT("cursor_4c_BuscaCor") > 0
2939:                     IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2940:                         SELECT TmpCera
2941:                         SET ORDER TO Tubos
2942:                         IF SEEK(STR(THIS.this_nTuboAtual, 2))
2943:                             REPLACE CodCors WITH loc_cCodCor IN TmpCera
2944:                         ENDIF
2945:                     ENDIF
2946:                     loc_lSucesso = .T.
2947:                 ELSE
2948:                     MsgAviso("Cor '" + loc_cCodCor + "' n" + CHR(227) + "o encontrada.", "Cor")
2949:                     loc_oCnt5.txt_4c_Cor.Value = ""
2950:                 ENDIF
2951: 
2952:                 IF USED("cursor_4c_BuscaCor")
2953:                     USE IN cursor_4c_BuscaCor
2954:                 ENDIF
2955:             ENDIF
2956:         CATCH TO loc_oErro
2957:             MsgErro("Erro em FormFUN.ValidarCor: " + loc_oErro.Message, "Erro")
2958:         ENDTRY
2959: 
2960:         RETURN loc_lSucesso
2961:     ENDPROC
2962: 
2963:     *==========================================================================
2964:     PROCEDURE ArvoreKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2965:     *==========================================================================
2966:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2967:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2968:             THIS.AbrirLookupArvore()
2969:         ENDIF
2970:     ENDPROC
2971: 
2972:     *==========================================================================
2973:     PROCEDURE ArvoreDblClick()
2974:     *==========================================================================
2975:         THIS.AbrirLookupArvore()
2976:     ENDPROC
2977: 
2978:     *==========================================================================
2979:     PROCEDURE AbrirLookupArvore()
2980:     *==========================================================================
2981:         LOCAL loc_oPg2, loc_cAtual, loc_oBusca
2982: 
2983:         TRY
2984:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2985:             loc_cAtual = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
2986: 
2987:             IF !USED("cursor_4c_Arvores")
2988:                 THIS.CarregarArvores()
2989:             ENDIF
2990: 
2991:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
2992:                 "cursor_4c_Arvores", ;
2993:                 "codigos", ;
2994:                 loc_cAtual, ;
2995:                 loc_oPg2.txt_4c_codarvore, ;
2996:                 "Selecionar " + CHR(193) + "rvore", ;
2997:                 .T., .T., "")
2998:             IF VARTYPE(loc_oBusca) = "O"
2999:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
3000:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
3001:                 loc_oBusca.Show()
3002:                 THIS.ValidarArvore()
3003:             ENDIF
3004:         CATCH TO loc_oErro
3005:             MsgErro("Erro em FormFUN.AbrirLookupArvore: " + loc_oErro.Message, "Erro")
3006:         ENDTRY
3007:     ENDPROC
3008: 
3009:     *==========================================================================
3010:     PROCEDURE ValidarArvore(par_nKeyCode, par_nShiftAltCtrl)
3011:     *==========================================================================
3012:         LOCAL loc_oPg2, loc_cCodArv, loc_cDescs, loc_lSucesso
3013:         loc_lSucesso = .F.
3014: 
3015:         TRY
3016:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
3017:             loc_cCodArv = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
3018: 
3019:             IF EMPTY(loc_cCodArv)
3020:                 IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3021:                     loc_oPg2.txt_4c_descarvore.Value = ""
3022:                 ENDIF
3023:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3024:                     SELECT TmpCera
3025:                     SET ORDER TO Tubos
3026:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
3027:                         REPLACE CodArvs WITH "", Descs WITH "" IN TmpCera
3028:                     ENDIF
3029:                 ENDIF
3030:                 loc_lSucesso = .T.
3031:             ELSE
3032:                 IF !USED("cursor_4c_Arvores")
3033:                     THIS.CarregarArvores()
3034:                 ENDIF
3035: 
3036:                 IF USED("cursor_4c_Arvores")
3037:                     SELECT cursor_4c_Arvores
3038:                     LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3039:                     IF FOUND()
3040:                         loc_cDescs = ALLTRIM(NVL(cursor_4c_Arvores.descs, ""))
3041:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3042:                             loc_oPg2.txt_4c_descarvore.Value = loc_cDescs
3043:                         ENDIF
3044:                         IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3045:                             SELECT TmpCera
3046:                             SET ORDER TO Tubos
3047:                             IF SEEK(STR(THIS.this_nTuboAtual, 2))
3048:                                 REPLACE CodArvs WITH loc_cCodArv, Descs WITH loc_cDescs IN TmpCera
3049:                             ENDIF
3050:                         ENDIF
3051:                         THIS.CalcMetal()
3052:                         loc_lSucesso = .T.
3053:                     ELSE
3054:                         MsgAviso(CHR(193) + "rvore '" + loc_cCodArv + ;
3055:                             "' n" + CHR(227) + "o encontrada.", CHR(193) + "rvore")
3056:                         loc_oPg2.txt_4c_codarvore.Value  = ""
3057:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3058:                             loc_oPg2.txt_4c_descarvore.Value = ""
3059:                         ENDIF
3060:                     ENDIF
3061:                 ENDIF
3062:             ENDIF
3063:         CATCH TO loc_oErro
3064:             MsgErro("Erro em FormFUN.ValidarArvore: " + loc_oErro.Message, "Erro")
3065:         ENDTRY
3066: 
3067:         RETURN loc_lSucesso
3068:     ENDPROC
3069: 
3070:     *==========================================================================
3071:     PROCEDURE ArvoreDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3072:     *==========================================================================
3073:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3074:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3075:             THIS.AbrirLookupArvoreDesc()
3076:         ENDIF
3077:     ENDPROC
3078: 
3079:     *==========================================================================
3080:     PROCEDURE ArvoreDescDblClick()
3081:     *==========================================================================
3082:         THIS.AbrirLookupArvoreDesc()
3083:     ENDPROC
3084: 
3085:     *==========================================================================
3086:     PROCEDURE AbrirLookupArvoreDesc()
3087:     *==========================================================================
3088:         LOCAL loc_oPg2, loc_cAtual, loc_oBusca
3089: 
3090:         TRY
3091:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3092:             loc_cAtual = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
3093: 
3094:             IF !USED("cursor_4c_Arvores")
3095:                 THIS.CarregarArvores()
3096:             ENDIF
3097: 
3098:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
3099:                 "cursor_4c_Arvores", ;
3100:                 "codigos", ;
3101:                 loc_cAtual, ;
3102:                 loc_oPg2.txt_4c_codarvore, ;
3103:                 "Selecionar " + CHR(193) + "rvore", ;
3104:                 .T., .T., "")
3105:             IF VARTYPE(loc_oBusca) = "O"
3106:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
3107:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
3108:                 loc_oBusca.Show()
3109:                 THIS.ValidarArvore()
3110:             ENDIF
3111:         CATCH TO loc_oErro
3112:             MsgErro("Erro em FormFUN.AbrirLookupArvoreDesc: " + loc_oErro.Message, "Erro")
3113:         ENDTRY
3114:     ENDPROC
3115: 
3116:     *==========================================================================
3117:     PROCEDURE CalcMetal()
3118:     *==========================================================================
3119:         LOCAL loc_oCnt5, loc_oPg2, loc_cCodArv, loc_cFormula
3120:         LOCAL loc_nBCeras, loc_nBases, loc_nCeras, loc_nPesoMetal, loc_nMetalNovo, loc_nPercs
3121:         LOCAL loc_lSucesso
3122:         loc_lSucesso = .F.
3123: 
3124:         TRY
3125:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3126:                 SELECT TmpCera
3127:                 SET ORDER TO Tubos
3128:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3129:                     loc_nBCeras = NVL(TmpCera.BCeras, 0)
3130:                     loc_nBases  = NVL(TmpCera.Bases, 0)
3131: 
3132:                     IF loc_nBCeras > 0 AND loc_nBases > 0 AND loc_nBCeras < loc_nBases
3133:                         MsgAviso("Base com Cera n" + CHR(227) + "o pode ser menor que a Base.", "Aviso")
3134:                         REPLACE Bases WITH 0 IN TmpCera
3135:                         loc_nBases = 0
3136:                     ENDIF
3137: 
3138:                     loc_nCeras = loc_nBCeras - loc_nBases
3139:                     REPLACE Ceras WITH loc_nCeras IN TmpCera
3140: 
3141:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3142:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Cera", 5)
3143:                         loc_oCnt5.txt_4c_Cera.Value = loc_nCeras
3144:                     ENDIF
3145: 
3146:                     loc_oPg2    = THIS.pgf_4c_Paginas.Page2
3147:                     loc_cCodArv = ""
3148:                     IF PEMSTATUS(loc_oPg2, "txt_4c_codarvore", 5)
3149:                         loc_cCodArv = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
3150:                     ENDIF
3151: 
3152:                     loc_nPesoMetal = 0
3153:                     loc_nMetalNovo = 0
3154:                     loc_nPercs     = 0
3155: 
3156:                     IF !EMPTY(loc_cCodArv) AND USED("cursor_4c_Arvores")
3157:                         SELECT cursor_4c_Arvores
3158:                         LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3159:                         IF FOUND()
3160:                             loc_cFormula = ALLTRIM(NVL(cursor_4c_Arvores.formulas, ""))
3161:                             loc_nPercs   = NVL(cursor_4c_Arvores.percs, 0)
3162:                             IF !EMPTY(loc_cFormula)
3163:                                 SELECT TmpCera
3164:                                 TRY
3165:                                     loc_nPesoMetal = EVALUATE(loc_cFormula)
3166:                                 CATCH
3167:                                     loc_nPesoMetal = 0
3168:                                 ENDTRY
3169:                                 loc_nMetalNovo = (loc_nPesoMetal * loc_nPercs) / 100
3170:                             ENDIF
3171:                         ENDIF
3172:                     ENDIF
3173: 

*-- Linhas 3195 a 3505:
3195:     ENDPROC
3196: 
3197:     *==========================================================================
3198:     PROCEDURE BasecLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3199:     *==========================================================================
3200:         LOCAL loc_oCnt5, loc_nBCeras, loc_lSucesso
3201:         loc_lSucesso = .F.
3202: 
3203:         TRY
3204:             loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3205:             loc_nBCeras = NVL(loc_oCnt5.txt_4c_Basec.Value, 0)
3206: 
3207:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3208:                 SELECT TmpCera
3209:                 SET ORDER TO Tubos
3210:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3211:                     REPLACE BCeras WITH loc_nBCeras IN TmpCera
3212:                 ENDIF
3213:             ENDIF
3214: 
3215:             THIS.CalcMetal()
3216:             loc_lSucesso = .T.
3217:         CATCH TO loc_oErro
3218:             MsgErro("Erro em FormFUN.BasecLostFocus: " + loc_oErro.Message, "Erro")
3219:         ENDTRY
3220: 
3221:         RETURN loc_lSucesso
3222:     ENDPROC
3223: 
3224:     *==========================================================================
3225:     PROCEDURE BaseLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3226:     *==========================================================================
3227:         LOCAL loc_oCnt5, loc_nBases, loc_lSucesso
3228:         loc_lSucesso = .F.
3229: 
3230:         TRY
3231:             loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3232:             loc_nBases = NVL(loc_oCnt5.txt_4c_Base.Value, 0)
3233: 
3234:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3235:                 SELECT TmpCera
3236:                 SET ORDER TO Tubos
3237:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3238:                     REPLACE Bases WITH loc_nBases IN TmpCera
3239:                 ENDIF
3240:             ENDIF
3241: 
3242:             THIS.CalcMetal()
3243:             loc_lSucesso = .T.
3244:         CATCH TO loc_oErro
3245:             MsgErro("Erro em FormFUN.BaseLostFocus: " + loc_oErro.Message, "Erro")
3246:         ENDTRY
3247: 
3248:         RETURN loc_lSucesso
3249:     ENDPROC
3250: 
3251:     *==========================================================================
3252:     PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3253:     *==========================================================================
3254:         LOCAL loc_cEmps, loc_lSucesso
3255:         loc_lSucesso = .F.
3256: 
3257:         TRY
3258:             loc_cEmps = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_CdEmpresa.Value, ""))
3259:             IF loc_cEmps != THIS.this_cAntEmpr
3260:                 THIS.this_cAntEmpr = loc_cEmps
3261:                 THIS.CarregarLista()
3262:             ENDIF
3263:             loc_lSucesso = .T.
3264:         CATCH TO loc_oErro
3265:             MsgErro("Erro em FormFUN.EmpresaLostFocus: " + loc_oErro.Message, "Erro")
3266:         ENDTRY
3267: 
3268:         RETURN loc_lSucesso
3269:     ENDPROC
3270: 
3271:     *==========================================================================
3272:     PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3273:     *==========================================================================
3274:         LOCAL loc_dDtIni, loc_lSucesso
3275:         loc_lSucesso = .F.
3276: 
3277:         TRY
3278:             loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
3279:             IF loc_dDtIni != THIS.this_dAntDtI
3280:                 THIS.this_dAntDtI = loc_dDtIni
3281:                 THIS.CarregarLista()
3282:             ENDIF
3283:             loc_lSucesso = .T.
3284:         CATCH TO loc_oErro
3285:             MsgErro("Erro em FormFUN.DtInicialLostFocus: " + loc_oErro.Message, "Erro")
3286:         ENDTRY
3287: 
3288:         RETURN loc_lSucesso
3289:     ENDPROC
3290: 
3291:     *==========================================================================
3292:     PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3293:     *==========================================================================
3294:         LOCAL loc_dDtFim, loc_lSucesso
3295:         loc_lSucesso = .F.
3296: 
3297:         TRY
3298:             loc_dDtFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
3299:             IF loc_dDtFim != THIS.this_dAntDtF
3300:                 THIS.this_dAntDtF = loc_dDtFim
3301:                 THIS.CarregarLista()
3302:             ENDIF
3303:             loc_lSucesso = .T.
3304:         CATCH TO loc_oErro
3305:             MsgErro("Erro em FormFUN.DtFinalLostFocus: " + loc_oErro.Message, "Erro")
3306:         ENDTRY
3307: 
3308:         RETURN loc_lSucesso
3309:     ENDPROC
3310: 
3311:     *==========================================================================
3312:     PROCEDURE NopLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3313:     *==========================================================================
3314:         LOCAL loc_oCnt3, loc_nNop, loc_nResultado, loc_lSucesso
3315:         loc_lSucesso = .F.
3316: 
3317:         TRY
3318:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3319:             loc_nNop  = NVL(loc_oCnt3.txt_4c_Nop.Value, 0)
3320: 
3321:             IF loc_nNop <= 0
3322:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3323:                     loc_oCnt3.txt_4c_Qtd.Value = 0
3324:                 ENDIF
3325:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3326:                     loc_oCnt3.txt_4c_Pecas.Value = 0
3327:                 ENDIF
3328:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3329:                     loc_oCnt3.txt_4c_Operacao.Value = ""
3330:                 ENDIF
3331:                 loc_lSucesso = .T.
3332:             ELSE
3333:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3334:                     "SELECT o.nops, o.cpros, o.qtds, o.numes, o.dtents" + ;
3335:                     " FROM SigOpPic o" + ;
3336:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3337:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3338:                     "cursor_4c_BuscaNop")
3339: 
3340:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaNop") AND ;
3341:                         RECCOUNT("cursor_4c_BuscaNop") > 0
3342:                     SELECT cursor_4c_BuscaNop
3343:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3344:                         loc_oCnt3.txt_4c_Qtd.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3345:                     ENDIF
3346:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3347:                         loc_oCnt3.txt_4c_Pecas.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3348:                     ENDIF
3349:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3350:                         loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(cursor_4c_BuscaNop.cpros, ""))
3351:                     ENDIF
3352:                     loc_lSucesso = .T.
3353:                 ELSE
3354:                     MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
3355:                         " n" + CHR(227) + "o encontrada.", "O.P.")
3356:                     loc_oCnt3.txt_4c_Nop.Value = 0
3357:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3358:                         loc_oCnt3.txt_4c_Qtd.Value = 0
3359:                     ENDIF
3360:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3361:                         loc_oCnt3.txt_4c_Pecas.Value = 0
3362:                     ENDIF
3363:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3364:                         loc_oCnt3.txt_4c_Operacao.Value = ""
3365:                     ENDIF
3366:                 ENDIF
3367: 
3368:                 IF USED("cursor_4c_BuscaNop")
3369:                     USE IN cursor_4c_BuscaNop
3370:                 ENDIF
3371:             ENDIF
3372:         CATCH TO loc_oErro
3373:             MsgErro("Erro em FormFUN.NopLostFocus: " + loc_oErro.Message, "Erro")
3374:         ENDTRY
3375: 
3376:         RETURN loc_lSucesso
3377:     ENDPROC
3378: 
3379:     *==========================================================================
3380:     PROCEDURE QtTbLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3381:     *==========================================================================
3382:         LOCAL loc_oCnt3, loc_nQtTb, loc_nMaxQtd, loc_lSucesso
3383:         loc_lSucesso = .F.
3384: 
3385:         TRY
3386:             loc_oCnt3   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3387:             loc_nQtTb   = NVL(loc_oCnt3.txt_4c_QtTb.Value, 0)
3388:             loc_nMaxQtd = 0
3389:             IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3390:                 loc_nMaxQtd = NVL(loc_oCnt3.txt_4c_Qtd.Value, 0)
3391:             ENDIF
3392: 
3393:             IF loc_nMaxQtd > 0 AND loc_nQtTb > loc_nMaxQtd
3394:                 MsgAviso("Quantidade solicitada (" + TRANSFORM(loc_nQtTb) + ;
3395:                     ") excede quantidade dispon" + CHR(237) + "vel (" + ;
3396:                     TRANSFORM(loc_nMaxQtd) + ").", "Quantidade")
3397:                 loc_oCnt3.txt_4c_QtTb.Value = loc_nMaxQtd
3398:             ENDIF
3399:             loc_lSucesso = .T.
3400:         CATCH TO loc_oErro
3401:             MsgErro("Erro em FormFUN.QtTbLostFocus: " + loc_oErro.Message, "Erro")
3402:         ENDTRY
3403: 
3404:         RETURN loc_lSucesso
3405:     ENDPROC
3406: 
3407:     *==========================================================================
3408:     PROCEDURE TuboLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3409:     *==========================================================================
3410:         LOCAL loc_oCnt3, loc_nTuboFonte, loc_nTuboAtual
3411:         LOCAL loc_nTotal, loc_nI, loc_cDopes, loc_nNumes, loc_nNNumes
3412:         LOCAL loc_lSucesso
3413:         LOCAL ARRAY loc_aTrfs[1, 3]
3414:         loc_lSucesso = .F.
3415:         loc_nTotal   = 0
3416: 
3417:         TRY
3418:             loc_oCnt3      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3419:             loc_nTuboFonte = NVL(loc_oCnt3.txt_4c_Tubo.Value, 0)
3420:             loc_nTuboAtual = THIS.this_nTuboAtual
3421: 
3422:             IF loc_nTuboFonte > 0 AND loc_nTuboAtual > 0 AND ;
3423:                     loc_nTuboFonte != loc_nTuboAtual AND USED("TmpTrf")
3424:                 *-- Coletar registros do tubo fonte
3425:                 SELECT TmpTrf
3426:                 SET ORDER TO 0
3427:                 GO TOP
3428:                 DO WHILE !EOF("TmpTrf")
3429:                     IF TmpTrf.Tubos = loc_nTuboFonte
3430:                         loc_nTotal = loc_nTotal + 1
3431:                         DIMENSION loc_aTrfs[loc_nTotal, 3]
3432:                         loc_aTrfs[loc_nTotal, 1] = TmpTrf.Dopes
3433:                         loc_aTrfs[loc_nTotal, 2] = TmpTrf.Numes
3434:                         loc_aTrfs[loc_nTotal, 3] = TmpTrf.nNumes
3435:                     ENDIF
3436:                     SKIP
3437:                 ENDDO
3438: 
3439:                 *-- Inserir no tubo destino se nao existir
3440:                 FOR loc_nI = 1 TO loc_nTotal
3441:                     loc_cDopes  = loc_aTrfs[loc_nI, 1]
3442:                     loc_nNumes  = loc_aTrfs[loc_nI, 2]
3443:                     loc_nNNumes = loc_aTrfs[loc_nI, 3]
3444:                     SELECT TmpTrf
3445:                     LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cDopes
3446:                     IF !FOUND()
3447:                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3448:                             VALUES (loc_cDopes, loc_nNumes, loc_nTuboAtual, loc_nNNumes)
3449:                     ENDIF
3450:                 ENDFOR
3451: 
3452:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3, "grd_4c_GradeTrf", 5)
3453:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3.grd_4c_GradeTrf.Refresh()
3454:                 ENDIF
3455:             ENDIF
3456:             loc_lSucesso = .T.
3457:         CATCH TO loc_oErro
3458:             MsgErro("Erro em FormFUN.TuboLostFocus: " + loc_oErro.Message, "Erro")
3459:         ENDTRY
3460: 
3461:         RETURN loc_lSucesso
3462:     ENDPROC
3463: 
3464:     *==========================================================================
3465:     PROCEDURE TrfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3466:     *==========================================================================
3467:         LOCAL loc_oCnt3, loc_cTrf, loc_nResultado, loc_lSucesso
3468:         LOCAL loc_nTuboAtual, loc_lRep, loc_nNNumes, loc_nT
3469:         loc_lSucesso = .F.
3470: 
3471:         TRY
3472:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3473:             loc_cTrf  = ALLTRIM(NVL(loc_oCnt3.txt_4c_Trf.Value, ""))
3474: 
3475:             IF EMPTY(loc_cTrf)
3476:                 loc_lSucesso = .T.
3477:             ELSE
3478:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3479:                     "SELECT TOP 1 m.dopes, m.numes FROM SigMvCab m" + ;
3480:                     " WHERE m.dopes = " + EscaparSQL(loc_cTrf) + ;
3481:                     " AND m.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
3482:                     " ORDER BY m.numes DESC", ;
3483:                     "cursor_4c_BuscaTrf")
3484: 
3485:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaTrf") AND ;
3486:                         RECCOUNT("cursor_4c_BuscaTrf") > 0
3487:                     loc_nTuboAtual = THIS.this_nTuboAtual
3488:                     loc_lRep       = .F.
3489:                     IF PEMSTATUS(loc_oCnt3, "chk_4c_ChkRep", 5)
3490:                         loc_lRep = (loc_oCnt3.chk_4c_ChkRep.Value = 1)
3491:                     ENDIF
3492: 
3493:                     SELECT cursor_4c_BuscaTrf
3494:                     loc_nNNumes = NVL(cursor_4c_BuscaTrf.numes, 0)
3495: 
3496:                     IF loc_nTuboAtual > 0 AND USED("TmpTrf")
3497:                         SELECT TmpTrf
3498:                         LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cTrf
3499:                         IF !FOUND()
3500:                             INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3501:                                 VALUES (loc_cTrf, 0, loc_nTuboAtual, loc_nNNumes)
3502:                         ENDIF
3503: 
3504:                         IF loc_lRep
3505:                             FOR loc_nT = 1 TO THIS.this_nMaqTubos

*-- Linhas 3512 a 3796:
3512:                                     ENDIF
3513:                                 ENDIF
3514:                             ENDFOR
3515:                         ENDIF
3516: 
3517:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5)
3518:                             loc_oCnt3.grd_4c_GradeTrf.Refresh()
3519:                         ENDIF
3520:                     ENDIF
3521:                     loc_oCnt3.txt_4c_Trf.Value = ""
3522:                     loc_lSucesso = .T.
3523:                 ELSE
3524:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cTrf + ;
3525:                         "' n" + CHR(227) + "o encontrada.", ;
3526:                         "Opera" + CHR(231) + CHR(227) + "o")
3527:                     loc_oCnt3.txt_4c_Trf.Value = ""
3528:                 ENDIF
3529: 
3530:                 IF USED("cursor_4c_BuscaTrf")
3531:                     USE IN cursor_4c_BuscaTrf
3532:                 ENDIF
3533:             ENDIF
3534:         CATCH TO loc_oErro
3535:             MsgErro("Erro em FormFUN.TrfLostFocus: " + loc_oErro.Message, "Erro")
3536:         ENDTRY
3537: 
3538:         RETURN loc_lSucesso
3539:     ENDPROC
3540: 
3541:     *==========================================================================
3542:     PROCEDURE AdicionarNopClick()
3543:     *==========================================================================
3544:         LOCAL loc_oCnt3, loc_nNop, loc_nQtTb, loc_nTuboAtual
3545:         LOCAL loc_cCpros, loc_nQtds, loc_nNumes, loc_nRes2
3546:         LOCAL loc_dDtEnt, loc_lSucesso
3547:         loc_lSucesso = .F.
3548: 
3549:         TRY
3550:             loc_oCnt3      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3551:             loc_nNop       = NVL(loc_oCnt3.txt_4c_Nop.Value, 0)
3552:             loc_nQtTb      = NVL(loc_oCnt3.txt_4c_QtTb.Value, 0)
3553:             loc_nTuboAtual = THIS.this_nTuboAtual
3554: 
3555:             IF loc_nNop <= 0
3556:                 MsgAviso("Informe o n" + CHR(186) + " da O.P.", "O.P.")
3557:             ELSE
3558:                 IF loc_nTuboAtual <= 0
3559:                 MsgAviso("Selecione um tubo antes de adicionar a O.P.", "Tubo")
3560:             ELSE
3561:                 IF loc_nQtTb <= 0
3562:                 MsgAviso("Informe a quantidade do tubo.", "Quantidade")
3563:             ELSE
3564:                 loc_cCpros = ""
3565:                 loc_nQtds  = 0
3566:                 loc_nNumes = 0
3567: 
3568:                 loc_nRes2 = SQLEXEC(gnConnHandle, ;
3569:                     "SELECT o.cpros, o.qtds, o.numes FROM SigOpPic o" + ;
3570:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3571:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3572:                     "cursor_4c_BuscaNop2")
3573: 
3574:                 IF loc_nRes2 > 0 AND USED("cursor_4c_BuscaNop2") AND ;
3575:                         RECCOUNT("cursor_4c_BuscaNop2") > 0
3576:                     SELECT cursor_4c_BuscaNop2
3577:                     loc_cCpros = ALLTRIM(NVL(cursor_4c_BuscaNop2.cpros, ""))
3578:                     loc_nQtds  = NVL(cursor_4c_BuscaNop2.qtds, 0)
3579:                     loc_nNumes = NVL(cursor_4c_BuscaNop2.numes, 0)
3580: 
3581:                     IF USED("cursor_4c_BuscaNop2")
3582:                         USE IN cursor_4c_BuscaNop2
3583:                     ENDIF
3584: 
3585:                     IF USED("TmpNop")
3586:                         SELECT TmpNop
3587:                         LOCATE FOR TmpNop.Tubos = loc_nTuboAtual AND TmpNop.Nops = loc_nNop
3588:                         IF !FOUND()
3589:                             loc_dDtEnt = DATE()
3590:                             INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
3591:                                                EmpDopNums, DtEnts) ;
3592:                                 VALUES (loc_nNop, loc_cCpros, loc_nQtTb, loc_nTuboAtual, ;
3593:                                         loc_nQtds, loc_nNumes, ;
3594:                                         PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
3595:                                         loc_dDtEnt)
3596:                         ENDIF
3597: 
3598:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_Gradenop", 5)
3599:                             loc_oCnt3.grd_4c_Gradenop.Refresh()
3600:                         ENDIF
3601:                     ENDIF
3602: 
3603:                     loc_oCnt3.txt_4c_Nop.Value  = 0
3604:                     loc_oCnt3.txt_4c_QtTb.Value = 0
3605:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3606:                         loc_oCnt3.txt_4c_Qtd.Value = 0
3607:                     ENDIF
3608:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3609:                         loc_oCnt3.txt_4c_Pecas.Value = 0
3610:                     ENDIF
3611:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3612:                         loc_oCnt3.txt_4c_Operacao.Value = ""
3613:                     ENDIF
3614: 
3615:                     THIS.CalcMetal()
3616:                     loc_lSucesso = .T.
3617:                 ELSE
3618:                     IF USED("cursor_4c_BuscaNop2")
3619:                         USE IN cursor_4c_BuscaNop2
3620:                     ENDIF
3621:                     MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
3622:                         " n" + CHR(227) + "o encontrada.", "O.P.")
3623:                 ENDIF
3624:                 ENDIF
3625:                 ENDIF
3626:             ENDIF
3627:         CATCH TO loc_oErro
3628:             MsgErro("Erro em FormFUN.AdicionarNopClick: " + loc_oErro.Message, "Erro")
3629:         ENDTRY
3630: 
3631:         RETURN loc_lSucesso
3632:     ENDPROC
3633: 
3634:     *==========================================================================
3635:     PROCEDURE RemoverTrfClick()
3636:     *==========================================================================
3637:         LOCAL loc_oCnt3, loc_nTuboAtual, loc_lSucesso
3638:         loc_lSucesso = .F.
3639: 
3640:         TRY
3641:             loc_oCnt3     = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3642:             loc_nTuboAtual = THIS.this_nTuboAtual
3643: 
3644:             IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5) AND USED("TmpTrf")
3645:                 SELECT TmpTrf
3646:                 IF !EOF("TmpTrf") AND TmpTrf.Tubos = loc_nTuboAtual
3647:                     DELETE
3648:                     SET FILTER TO
3649:                     PACK NOOPTIMIZE
3650:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
3651:                     GO TOP
3652:                     loc_oCnt3.grd_4c_GradeTrf.Refresh()
3653:                 ENDIF
3654:             ENDIF
3655:             loc_lSucesso = .T.
3656:         CATCH TO loc_oErro
3657:             MsgErro("Erro em FormFUN.RemoverTrfClick: " + loc_oErro.Message, "Erro")
3658:         ENDTRY
3659: 
3660:         RETURN loc_lSucesso
3661:     ENDPROC
3662: 
3663:     *==========================================================================
3664:     PROCEDURE GradenopAfterRowColChange(par_nColIndex)
3665:     *==========================================================================
3666:         LPARAMETERS par_nColIndex
3667:         LOCAL loc_oCnt3, loc_lSucesso
3668:         loc_lSucesso = .F.
3669: 
3670:         TRY
3671:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3672:             IF USED("TmpNop") AND !EOF("TmpNop") AND PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3673:                 SELECT TmpNop
3674:                 IF !EOF("TmpNop")
3675:                     loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(TmpNop.Cpros, "")) + ;
3676:                         "  Qt: " + TRANSFORM(NVL(TmpNop.Qtds, 0), "999,999.999")
3677:                 ENDIF
3678:             ENDIF
3679:             loc_lSucesso = .T.
3680:         CATCH TO loc_oErro
3681:             MsgErro("Erro em FormFUN.GradenopAfterRowColChange: " + loc_oErro.Message, "Erro")
3682:         ENDTRY
3683: 
3684:         RETURN loc_lSucesso
3685:     ENDPROC
3686: 
3687:     *==========================================================================
3688:     PROCEDURE BtnTotalClick()
3689:     *==========================================================================
3690:         LOCAL loc_oCnt, loc_lSucesso
3691:         loc_lSucesso = .F.
3692: 
3693:         TRY
3694:             IF USED("cursor_4c_TmpTot")
3695:                 USE IN cursor_4c_TmpTot
3696:             ENDIF
3697: 
3698:             IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
3699:                 SELECT TmpCera.CodArvs AS CodArvs, ;
3700:                        TmpCera.Descs   AS Descs,   ;
3701:                        SUM(TmpCera.pmetalrs) AS PesoRealTotal, ;
3702:                        SUM(TmpCera.MetalNvs) AS MetalNovoTotal, ;
3703:                        SUM(TmpCera.PMetals)  AS PesoMetalTotal  ;
3704:                 FROM TmpCera ;
3705:                 WHERE TmpCera.nStatus = 3 ;
3706:                 GROUP BY TmpCera.CodArvs, TmpCera.Descs ;
3707:                 INTO CURSOR cursor_4c_TmpTot NOFILTER
3708:             ELSE
3709:                 CREATE CURSOR cursor_4c_TmpTot ( ;
3710:                     CodArvs        C(10), ;
3711:                     Descs          C(40), ;
3712:                     PesoRealTotal  N(12,2), ;
3713:                     MetalNovoTotal N(12,2), ;
3714:                     PesoMetalTotal N(12,2) ;
3715:                 )
3716:             ENDIF
3717: 
3718:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Total
3719:             IF PEMSTATUS(loc_oCnt, "grd_4c_TmpTot", 5)
3720:                 loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
3721:                 loc_oCnt.grd_4c_TmpTot.RecordSource            = "cursor_4c_TmpTot"
3722:                 loc_oCnt.grd_4c_TmpTot.Column1.ControlSource   = "cursor_4c_TmpTot.CodArvs"
3723:                 loc_oCnt.grd_4c_TmpTot.Column2.ControlSource   = "cursor_4c_TmpTot.PesoRealTotal"
3724:                 loc_oCnt.grd_4c_TmpTot.Column3.ControlSource   = "cursor_4c_TmpTot.MetalNovoTotal"
3725:                 loc_oCnt.grd_4c_TmpTot.Column4.ControlSource   = "cursor_4c_TmpTot.PesoMetalTotal"
3726:                 loc_oCnt.grd_4c_TmpTot.Refresh()
3727:             ENDIF
3728: 
3729:             loc_oCnt.Visible = .T.
3730:             loc_oCnt.ZOrder(0)
3731:             loc_lSucesso = .T.
3732:         CATCH TO loc_oErro
3733:             MsgErro("Erro em FormFUN.BtnTotalClick: " + loc_oErro.Message, "Erro")
3734:         ENDTRY
3735: 
3736:         RETURN loc_lSucesso
3737:     ENDPROC
3738: 
3739:     *==========================================================================
3740:     PROCEDURE BtnCancelarTotalClick()
3741:     *==========================================================================
3742:         LOCAL loc_lSucesso
3743:         loc_lSucesso = .F.
3744: 
3745:         TRY
3746:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Total.Visible = .F.
3747:             loc_lSucesso = .T.
3748:         CATCH TO loc_oErro
3749:             MsgErro("Erro em FormFUN.BtnCancelarTotalClick: " + loc_oErro.Message, "Erro")
3750:         ENDTRY
3751: 
3752:         RETURN loc_lSucesso
3753:     ENDPROC
3754: 
3755:     *==========================================================================
3756:     PROTECTED PROCEDURE LimparCamposTubo()
3757:     *==========================================================================
3758:         LOCAL loc_oCnt4, loc_oCnt5, loc_oCnt6, loc_oPg2
3759: 
3760:         TRY
3761:             loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
3762:             loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3763:             loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
3764:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3765: 
3766:             IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
3767:                 loc_oCnt4.edt_4c_Obs.Value = ""
3768:             ENDIF
3769: 
3770:             IF PEMSTATUS(loc_oCnt5, "txt_4c_Cor", 5)
3771:                 loc_oCnt5.txt_4c_Cor.Value     = ""
3772:                 loc_oCnt5.txt_4c_Basec.Value   = 0
3773:                 loc_oCnt5.txt_4c_Base.Value    = 0
3774:                 loc_oCnt5.txt_4c_Cera.Value    = 0
3775:                 loc_oCnt5.txt_4c_Metal.Value   = 0
3776:                 loc_oCnt5.txt_4c_Mreal.Value   = 0
3777:                 loc_oCnt5.txt_4c_metnovo.Value = 0
3778:             ENDIF
3779: 
3780:             IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
3781:                 loc_oCnt6.txt_4c_TempMet.Value = ""
3782:                 loc_oCnt6.txt_4c_TempTub.Value = ""
3783:                 loc_oCnt6.txt_4c_TempAmb.Value = ""
3784:                 loc_oCnt6.txt_4c_TempAgu.Value = ""
3785:             ENDIF
3786: 
3787:             IF PEMSTATUS(loc_oPg2, "txt_4c_codarvore", 5)
3788:                 loc_oPg2.txt_4c_codarvore.Value  = ""
3789:                 loc_oPg2.txt_4c_descarvore.Value = ""
3790:             ENDIF
3791: 
3792:             IF USED("TmpNop")
3793:                 SELECT TmpNop
3794:                 SET FILTER TO
3795:                 GO TOP
3796:             ENDIF


### BO (C:\4c\projeto\app\classes\FUNBO.prg):
*==============================================================================
* FUNBO.prg - Business Object para Cadastro de Fundicoes (SIGCDFUN)
* Tabela principal : SIGCDFUN (cabecalho)
* Tabela detalhe   : SigCdFud (tubos, ordens de producao, transferencias)
*==============================================================================

DEFINE CLASS FUNBO AS BusinessBase

	*-- SIGCDFUN: campos do cabecalho
	this_nCodigos   = 0    && codigos   numeric(6,0) - ID da fundicao
	this_cCidChaves = ""   && cidchaves char(20)     - PK fisica
	this_cEmps      = ""   && emps      char(3)      - empresa
	this_dDatas     = {}   && datas     datetime     - data da fundicao
	this_cCodMaqfs  = ""   && codmaqfs  char(10)     - codigo da maquina
	this_cUsuars    = ""   && usuars    char(10)      - usuario que registrou
	this_mObsG      = ""   && obss      text         - observacao geral do cabecalho

	*-- Propriedade de trabalho: numero de tubos da maquina (SigCfMqf.Tubos)
	*   Lido no CarregarPorCodigo via JOIN, devolvido ao form em BOParaForm
	this_nNTubos    = 0

	*==========================================================================
	PROCEDURE Init()
	*==========================================================================
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDFUN"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*==========================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
	*==========================================================================
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*==========================================================================
	* Buscar - Retorna lista de fundicoes em cursor_4c_Dados
	* par_cFiltro: fragmento WHERE sem a palavra WHERE
	*==========================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF VARTYPE(par_cFiltro) != "C"
				par_cFiltro = ""
			ENDIF

			loc_cSQL = "SELECT f.codigos, f.emps, f.datas, f.usuars, f.codmaqfs," + ;
			           " f.ntubos," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(200)), '') AS obss" + ;
			           " FROM SIGCDFUN f"

			IF !EMPTY(ALLTRIM(par_cFiltro))
				loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY f.datas DESC, f.codigos DESC"

			IF USED("cursor_4c_Dados")
				USE IN cursor_4c_Dados
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				IF !USED("cursor_4c_Dados")
					CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
					    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
				ENDIF
				MsgErro("Erro ao buscar fundi" + CHR(231) + CHR(245) + "es:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.Buscar: " + loc_oErro.Message, "Erro")
			IF !USED("cursor_4c_Dados")
				CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
				    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarPorCodigo - Carrega registro pelo codigos (ID numerico)
	* Tambem carrega this_nNTubos (numero de tubos da maquina) via JOIN SigCfMqf
	*==========================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigos)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT f.codigos, f.cidchaves, f.emps, f.datas," + ;
			           " f.codmaqfs, f.usuars," + ;
			           " ISNULL(CAST(f.obss AS NVARCHAR(MAX)), '') AS obss," + ;
			           " ISNULL(m.tubos, 24) AS ntubos" + ;
			           " FROM SIGCDFUN f" + ;
			           " LEFT JOIN SigCfMqf m ON m.codigos = f.codmaqfs" + ;
			           " WHERE f.codigos = " + TRANSFORM(par_nCodigos)

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND USED("cursor_4c_Carrega") AND ;
			        RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ELSE
				MsgErro("Fundi" + CHR(231) + CHR(227) + "o " + ;
				    TRANSFORM(par_nCodigos) + " n" + CHR(227) + "o encontrada.", "Aviso")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
		ENDTRY

		IF USED("cursor_4c_Carrega")
			USE IN cursor_4c_Carrega
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CarregarDoCursor - Popula propriedades a partir de cursor aberto
	*==========================================================================
	PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_nCodigos   = TratarNulo(codigos,   "N")
			THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
			THIS.this_cEmps      = TratarNulo(emps,      "C")
			THIS.this_dDatas     = TratarNulo(datas,     "D")
			THIS.this_cCodMaqfs  = TratarNulo(codmaqfs,  "C")
			THIS.this_cUsuars    = TratarNulo(usuars,    "C")
			THIS.this_mObsG      = TratarNulo(obss,      "C")
			THIS.this_nNTubos    = TratarNulo(ntubos,    "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Inserir - INSERT SIGCDFUN + SigCdFud (PROTECTED - chamado por Salvar())
	*==========================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado
		LOCAL loc_nCodigos, loc_cChave, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			*-- Flag de tubos em producao (nTubos em SIGCDFUN): 1 se nStatus 2 ou 3
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			*-- Gerar proximo codigos via SQL Server
			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "SELECT ISNULL(MAX(codigos), 0) + 1 AS prox FROM SIGCDFUN", ;
			    "cursor_4c_FunNextId")
			IF loc_nResultado < 0 OR !USED("cursor_4c_FunNextId")
				MsgErro("Erro ao gerar ID de fundi" + CHR(231) + CHR(227) + "o: " + ;
				    CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nCodigos = cursor_4c_FunNextId.prox
				USE IN cursor_4c_FunNextId

				THIS.this_nCodigos = loc_nCodigos

				*-- Gerar cidchaves (20 chars via SYS(2015))
				loc_cChave = SYS(2015) + SYS(2015)
				THIS.this_cCidChaves = loc_cChave

				*-- Campos automaticos
				IF EMPTY(THIS.this_cUsuars)
					THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
				ENDIF
				IF EMPTY(THIS.this_cEmps)
					THIS.this_cEmps = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
				ENDIF

				SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

				loc_cSQL = "INSERT INTO SIGCDFUN" + ;
				    " (cidchaves, codigos, emps, datas, datars," + ;
				    " codmaqfs, horas, ntubos, usuars, obss)" + ;
				    " VALUES (" + ;
				    EscaparSQL(loc_cChave) + "," + ;
				    TRANSFORM(loc_nCodigos) + "," + ;
				    EscaparSQL(THIS.this_cEmps) + "," + ;
				    FormatarDataSQL(THIS.this_dDatas) + "," + ;
				    GETDATE() + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
				    EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
				    TRANSFORM(loc_nNTuboFlag) + "," + ;
				    EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
				    THIS.PrepararMemoSQL(THIS.this_mObsG) + ")"

				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao inserir fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(loc_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("INSERT")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Inserir: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* Atualizar - UPDATE SIGCDFUN + recriar SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_nNTuboFlag
		loc_lSucesso = .F.

		TRY
			loc_nNTuboFlag = THIS.CalcularFlagNTubos()

			IF EMPTY(THIS.this_cUsuars)
				THIS.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
			ENDIF

			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_cSQL = "UPDATE SIGCDFUN SET" + ;
			    " emps     = " + EscaparSQL(THIS.this_cEmps) + "," + ;
			    " datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
			    " datars   = " + GETDATE() + "," + ;
			    " codmaqfs = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cCodMaqfs, ""))) + "," + ;
			    " horas    = " + EscaparSQL(SUBSTR(TIME(), 1, 8)) + "," + ;
			    " ntubos   = " + TRANSFORM(loc_nNTuboFlag) + "," + ;
			    " usuars   = " + EscaparSQL(ALLTRIM(NVL(THIS.this_cUsuars, ""))) + "," + ;
			    " obss     = " + THIS.PrepararMemoSQL(THIS.this_mObsG) + ;
			    " WHERE codigos = " + TRANSFORM(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao atualizar fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- Excluir detalhes antigos e reinserir dos cursores de trabalho
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes antigos da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					IF THIS.InserirDetalhesSigCdFud(THIS.this_nCodigos)
						SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
						THIS.RegistrarAuditoria("UPDATE")
						loc_lSucesso = .T.
					ELSE
						SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.Atualizar: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* ExecutarExclusao - DELETE SIGCDFUN + SigCdFud (PROTECTED)
	*==========================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_lSucesso, loc_nResultado
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")

			loc_nResultado = SQLEXEC(gnConnHandle, ;
			    "DELETE FROM SIGCDFUN WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
			IF loc_nResultado < 0
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
				MsgErro("Erro ao excluir fundi" + CHR(231) + CHR(227) + "o:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_nResultado = SQLEXEC(gnConnHandle, ;
				    "DELETE FROM SigCdFud WHERE codigos = " + TRANSFORM(THIS.this_nCodigos))
				IF loc_nResultado < 0
					SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
					MsgErro("Erro ao excluir detalhes da fundi" + CHR(231) + CHR(227) + "o:" + ;
					    CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
					THIS.RegistrarAuditoria("DELETE")
					loc_lSucesso = .T.
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro em FUNBO.ExecutarExclusao: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* InserirDetalhesSigCdFud - Insere linhas de SigCdFud a partir de
	*   TmpTrf (transferencias), TmpNop (ordens de producao), TmpCera (tubos)
	*==========================================================================
	PROTECTED PROCEDURE InserirDetalhesSigCdFud(par_nCodigos)
		LOCAL loc_lSucesso, loc_cSQL, loc_nResultado, loc_cChave
		LOCAL loc_cDopes, loc_nNNumes, loc_nTubos
		LOCAL loc_nNops, loc_nQtds, loc_nQtdos
		LOCAL loc_nBCeras, loc_nBases, loc_cCodCors, loc_cCodArvs
		LOCAL loc_nMetals, loc_nMetalNvs, loc_nNStatus
		LOCAL loc_cTmpMets, loc_cTmpAmbs, loc_cTmpTubs, loc_cTmpAgus
		loc_lSucesso = .T.

		TRY
			*------------------------------------------------------------------
			* 1. TmpTrf -> SigCdFud (transferencias/lancamentos de operacao)
			*    Condicao de skip: Dopes vazio OU nNumes = 0
			*------------------------------------------------------------------
			IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
				SELECT TmpTrf
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_cDopes  = ALLTRIM(TmpTrf.Dopes)
					loc_nNNumes = TmpTrf.nNumes
					loc_nTubos  = TmpTrf.Tubos

					IF !EMPTY(loc_cDopes) AND loc_nNNumes > 0
						loc_cChave  = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nnumes, nops, qtds, qtdos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNNumes) + "," + ;
						    "0,0,0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir transfer" + CHR(234) + "ncia" + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpTrf
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 2. TmpNop -> SigCdFud (ordens de producao)
			*    Condicao de skip: nops = 0 OU qtdos = 0
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpNop") AND RECCOUNT("TmpNop") > 0
				SELECT TmpNop
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nNops  = TmpNop.Nops
					loc_nQtds  = TmpNop.Qtds
					loc_nTubos = TmpNop.Tubos
					loc_nQtdos = TmpNop.Qtdos

					IF loc_nNops > 0 AND loc_nQtdos > 0
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos, nops, qtds, qtdos, nnumes," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, obss," + ;
						    " tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    TRANSFORM(loc_nNops) + "," + ;
						    FormatarNumeroSQL(loc_nQtds, 3) + "," + ;
						    FormatarNumeroSQL(loc_nQtdos, 3) + "," + ;
						    "0," + ;
						    "0,0,0,0,0," + ;
						    "'','',NULL," + ;
						    "'','','','')"
						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir O.P. " + TRANSFORM(loc_nNops) + ;
							    " (tubo " + TRANSFORM(loc_nTubos) + ") em SigCdFud:" + ;
							    CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpNop
					SKIP
				ENDDO
			ENDIF

			*------------------------------------------------------------------
			* 3. TmpCera -> SigCdFud (dados de cera/metal por tubo)
			*    Condicao de skip: bceras = 0 E bases = 0 (tubo sem dados)
			*    metals em SigCdFud = pmetalrs (peso real do metal, digitado)
			*------------------------------------------------------------------
			IF loc_lSucesso AND USED("TmpCera") AND RECCOUNT("TmpCera") > 0
				SELECT TmpCera
				SET ORDER TO
				GO TOP
				DO WHILE !EOF() AND loc_lSucesso
					loc_nBCeras   = TmpCera.BCeras
					loc_nBases    = TmpCera.Bases
					loc_nTubos    = TmpCera.Tubos
					loc_cCodCors  = ALLTRIM(NVL(TmpCera.CodCors, ""))
					loc_cCodArvs  = ALLTRIM(NVL(TmpCera.CodArvs, ""))
					loc_nMetals   = TmpCera.pmetalrs   && peso real (digitado)
					loc_nMetalNvs = TmpCera.MetalNvs
					loc_nNStatus  = TmpCera.nStatus
					loc_cTmpMets  = ALLTRIM(NVL(TmpCera.TempMets, ""))
					loc_cTmpAmbs  = ALLTRIM(NVL(TmpCera.TempAmbs, ""))
					loc_cTmpTubs  = ALLTRIM(NVL(TmpCera.TempTubs, ""))
					loc_cTmpAgus  = ALLTRIM(NVL(TmpCera.TempAgus, ""))

					IF !(loc_nBCeras = 0 AND loc_nBases = 0)
						loc_cChave = SYS(2015) + SYS(2015)
						loc_cSQL = "INSERT INTO SigCdFud" + ;
						    " (cidchaves, codigos, tubos," + ;
						    " bceras, bases, metals, metalnvs, nstatus," + ;
						    " codcors, codarvs, nnumes, nops, qtds, qtdos," + ;
						    " obss, tempmets, tempambs, temptubs, tempagus)" + ;
						    " VALUES (" + ;
						    EscaparSQL(loc_cChave) + "," + ;
						    TRANSFORM(par_nCodigos) + "," + ;
						    TRANSFORM(loc_nTubos) + "," + ;
						    FormatarNumeroSQL(loc_nBCeras, 2) + "," + ;
						    FormatarNumeroSQL(loc_nBases,  2) + "," + ;
						    FormatarNumeroSQL(loc_nMetals,   2) + "," + ;
						    FormatarNumeroSQL(loc_nMetalNvs, 2) + "," + ;
						    TRANSFORM(loc_nNStatus) + "," + ;
						    EscaparSQL(loc_cCodCors) + "," + ;
						    EscaparSQL(loc_cCodArvs) + "," + ;
						    "0,0,0,0," + ;
						    THIS.PrepararMemoSQL(NVL(TmpCera.Obss, "")) + "," + ;
						    EscaparSQL(loc_cTmpMets) + "," + ;
						    EscaparSQL(loc_cTmpAmbs) + "," + ;
						    EscaparSQL(loc_cTmpTubs) + "," + ;
						    EscaparSQL(loc_cTmpAgus) + ")"

						loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
						IF loc_nResultado < 0
							MsgErro("Erro ao inserir tubo " + TRANSFORM(loc_nTubos) + ;
							    " em SigCdFud:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
							loc_lSucesso = .F.
						ENDIF
					ENDIF

					SELECT TmpCera
					SKIP
				ENDDO
			ENDIF

		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.InserirDetalhesSigCdFud: " + loc_oErro.Message + ;
			    " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro")
			loc_lSucesso = .F.
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*==========================================================================
	* CalcularFlagNTubos - Retorna 1 se ha tubos em producao (nStatus 2 ou 3)
	*   Corresponde ao campo SIGCDFUN.ntubos (flag vermelho na grade)
	*==========================================================================
	PROTECTED PROCEDURE CalcularFlagNTubos()
		LOCAL loc_nFlag
		loc_nFlag = 0

		IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
			SELECT TmpCera
			LOCATE FOR TmpCera.nStatus = 2 OR TmpCera.nStatus = 3
			IF FOUND()
				loc_nFlag = 1
			ENDIF
		ENDIF

		RETURN loc_nFlag
	ENDPROC

	*==========================================================================
	* PrepararMemoSQL - Prepara campo memo/texto para SQL (NULL ou 'texto')
	*==========================================================================
	PROTECTED PROCEDURE PrepararMemoSQL(par_mTexto)
		LOCAL loc_cValor
		loc_cValor = ALLTRIM(NVL(CAST(par_mTexto AS CHARACTER), ""))

		IF EMPTY(loc_cValor)
			RETURN "NULL"
		ENDIF

		loc_cValor = SUBSTR(loc_cValor, 1, 4000)
		loc_cValor = STRTRAN(loc_cValor, "'", "''")

		RETURN "'" + loc_cValor + "'"
	ENDPROC

ENDDEFINE

