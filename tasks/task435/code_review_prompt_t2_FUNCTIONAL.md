# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (11)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_CABECALHO, CNT_4C_SALVA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [MADDCOLUNA-PARAMS] Chamada mAddColuna com 2 parametros (esperado: 3). Assinatura correta: mAddColuna(campo, mascara_ou_vazio, titulo). NAO passar largura ou tabela como parametro. Exemplo: loc_oBusca.mAddColuna('Codigos', '', 'Codigo')
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Usuário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Máquina' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Observação' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: O.P., Produto, Qtde, Pedido, Data Entrega, Operação, Numes, Tipo Árvore, Metal Real, Metal Novo, Metal Ligado. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFUN.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3827 linhas total):

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

*-- Linhas 103 a 239:
103: 
104:                 *-- Montar interface
105:                 THIS.ConfigurarPageFrame()
106:                 THIS.ConfigurarPaginaLista()
107:                 THIS.ConfigurarPaginaDados()
108:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
109:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
110: 
111:                 *-- Valores iniciais dos filtros
112:                 THIS.this_cPEmps  = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
113:                 THIS.this_dDtIni  = DATE()
114:                 THIS.this_dDtFim  = DATE()
115:                 THIS.this_cAntEmpr = THIS.this_cPEmps
116:                 THIS.this_dAntDtI  = THIS.this_dDtIni
117:                 THIS.this_dAntDtF  = THIS.this_dDtFim
118: 
119:                 *-- Preencher campos de filtro na tela
120:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo
121:                     .txt_4c_CdEmpresa.Value = THIS.this_cPEmps
122:                     .txt_4c_DtInicial.Value  = THIS.this_dDtIni
123:                     .txt_4c_DtFinal.Value    = THIS.this_dDtFim
124:                     .Visible     = .T.
125:                 ENDWITH
126: 
127:                 *-- Vincular eventos base
128:                 BINDEVENT(THIS.pgf_4c_Paginas.Page1.cnt_4c_Saida.cmd_4c_Encerrar, ;
129:                     "Click", THIS, "BtnEncerrarClick")
130: 
131:                 *-- Carregar lista inicial
132:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
133:                     THIS.CarregarLista()
134:                 ENDIF
135: 
136:                 THIS.pgf_4c_Paginas.ActivePage = 1
137:                 THIS.this_cModoAtual = "LISTA"
138:                 loc_lSucesso = .T.
139:             ENDIF
140:         CATCH TO loc_oErro
141:             MsgErro("Erro em FormFUN.InicializarForm: " + loc_oErro.Message + ;
142:                 " | Linha: " + TRANSFORM(loc_oErro.LineNo), "Erro Init")
143:             loc_lSucesso = .F.
144:         ENDTRY
145: 
146:         RETURN loc_lSucesso
147:     ENDPROC
148: 
149:     *==========================================================================
150:     PROTECTED PROCEDURE ConfigurarPageFrame()
151:     *==========================================================================
152:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
153: 
154:         WITH THIS.pgf_4c_Paginas
155:             .Top       = -29
156:             .Left      = 0
157:             .Width     = THIS.Width
158:             .Height    = THIS.Height + 29
159:             .PageCount = 2
160:             .Tabs      = .F.
161:             .Visible   = .T.
162:         ENDWITH
163: 
164:         WITH THIS.pgf_4c_Paginas.Page1
165:             .Caption   = "Lista"
166:             .BackColor = RGB(255, 255, 255)
167:         ENDWITH
168: 
169:         WITH THIS.pgf_4c_Paginas.Page2
170:             .Caption   = "Dados"
171:             .BackColor = RGB(255, 255, 255)
172:         ENDWITH
173: 
174:         IF FILE(gc_4c_CaminhoIcones + "fundo_cad_1003.jpg")
175:             THIS.pgf_4c_Paginas.Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
176:             THIS.pgf_4c_Paginas.Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
177:         ENDIF
178: 
179:         THIS.pgf_4c_Paginas.Visible = .T.
180:     ENDPROC
181: 
182:     *==========================================================================
183:     PROTECTED PROCEDURE ConfigurarPaginaLista()
184:     *==========================================================================
185:         LOCAL loc_oPagina
186:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
187: 
188:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
189:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
190: 
191:         *----------------------------------------------------------------------
192:         * cnt_4c_Cabecalho - Faixa escura superior com titulo do form
193:         * Top canônico: 2 + 29 (compensação PageFrame) = 31
194:         *----------------------------------------------------------------------
195:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
196:         WITH loc_oPagina.cnt_4c_Cabecalho
197:             .Top         = 31
198:             .Left        = 0
199:             .Width       = THIS.Width
200:             .Height      = 80
201:             .BackColor   = RGB(100, 100, 100)
202:             .BackStyle   = 1
203:             .BorderWidth = 0
204:             .SpecialEffect = 0
205:             .Visible     = .T.
206:         ENDWITH
207: 
208:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
209:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
210:             .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
211:             .Top       = 15
212:             .Left      = 10
213:             .Width     = THIS.Width - 20
214:             .Height    = 40
215:             .AutoSize  = .F.
216:             .FontName  = "Tahoma"
217:             .FontSize  = 16
218:             .FontBold  = .T.
219:             .ForeColor = RGB(0, 0, 0)
220:             .BackStyle = 0
221:         ENDWITH
222: 
223:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
224:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
225:             .Caption   = "Cadastro de Fundi" + CHR(231) + CHR(245) + "es"
226:             .Top       = 18
227:             .Left      = 10
228:             .Width     = THIS.Width - 20
229:             .Height    = 46
230:             .AutoSize  = .F.
231:             .FontName  = "Tahoma"
232:             .FontSize  = 16
233:             .FontBold  = .T.
234:             .ForeColor = RGB(255, 255, 255)
235:             .BackStyle = 0
236:         ENDWITH
237: 
238:         *----------------------------------------------------------------------
239:         * cnt_4c_Botoes - Container botoes CRUD (Fase 4 adiciona os botoes)

*-- Linhas 380 a 425:
380:             .FontSize  = 8
381:             .BackColor = RGB(255, 255, 255)
382:         ENDWITH
383:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_CdEmpresa, "KeyPress", THIS, "EmpresaLostFocus")
384:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
385:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal,   "KeyPress", THIS, "DtFinalLostFocus")
386: 
387:         *----------------------------------------------------------------------
388:         * cmd_4c_BtnAguarde - Mensagem de espera durante carregamento
389:         * Original: top=266, left=339, width=322, height=72, visible=false -> comp +29 = 295
390:         *----------------------------------------------------------------------
391:         loc_oPagina.AddObject("cmd_4c_BtnAguarde", "CommandButton")
392:         WITH loc_oPagina.cmd_4c_BtnAguarde
393:             .Caption   = "Aguarde!  Atualizando  Dados . . ."
394:             .Top       = 295
395:             .Left      = 339
396:             .Width     = 322
397:             .Height    = 72
398:             .FontName  = "Tahoma"
399:             .FontSize  = 11
400:             .FontBold  = .T.
401:             .ForeColor = RGB(0, 0, 0)
402:             .BackColor = RGB(200, 200, 200)
403:             .Enabled   = .F.
404:             .Visible   = .F.
405:         ENDWITH
406: 
407:         *----------------------------------------------------------------------
408:         * txt_4c_Botao1 - TextBox display desabilitado na Lista
409:         * Original: Botao1 textbox, top=132, left=438, width=27, height=22 -> comp +29 = 161
410:         *----------------------------------------------------------------------
411:         loc_oPagina.AddObject("txt_4c_Botao1", "TextBox")
412:         WITH loc_oPagina.txt_4c_Botao1
413:             .Value     = ""
414:             .Top       = 161
415:             .Left      = 438
416:             .Width     = 27
417:             .Height    = 22
418:             .FontName  = "Tahoma"
419:             .FontSize  = 8
420:             .BackColor = RGB(255, 255, 255)
421:             .Enabled   = .F.
422:         ENDWITH
423: 
424:         *----------------------------------------------------------------------
425:         * cnt_4c_Botoes ajuste Width para 5 botoes de 75px (5+75+5+75+...= 380)

*-- Linhas 450 a 585:
450:             .WordWrap        = .T.
451:             .AutoSize        = .F.
452:         ENDWITH
453:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
454: 
455:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
456:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
457:             .Caption         = "Visualizar"
458:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
459:             .PicturePosition = 13
460:             .Top             = 5
461:             .Left            = 80
462:             .Width           = 75
463:             .Height          = 75
464:             .FontName        = "Tahoma"
465:             .FontBold        = .T.
466:             .FontItalic      = .T.
467:             .FontSize        = 8
468:             .ForeColor       = RGB(90, 90, 90)
469:             .BackColor       = RGB(255, 255, 255)
470:             .Themes          = .F.
471:             .SpecialEffect   = 0
472:             .MousePointer    = 15
473:             .WordWrap        = .T.
474:             .AutoSize        = .F.
475:         ENDWITH
476:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
477: 
478:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
479:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
480:             .Caption         = "Alterar"
481:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
482:             .PicturePosition = 13
483:             .Top             = 5
484:             .Left            = 155
485:             .Width           = 75
486:             .Height          = 75
487:             .FontName        = "Tahoma"
488:             .FontBold        = .T.
489:             .FontItalic      = .T.
490:             .FontSize        = 8
491:             .ForeColor       = RGB(90, 90, 90)
492:             .BackColor       = RGB(255, 255, 255)
493:             .Themes          = .F.
494:             .SpecialEffect   = 0
495:             .MousePointer    = 15
496:             .WordWrap        = .T.
497:             .AutoSize        = .F.
498:         ENDWITH
499:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
500: 
501:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
502:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
503:             .Caption         = "Excluir"
504:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
505:             .PicturePosition = 13
506:             .Top             = 5
507:             .Left            = 230
508:             .Width           = 75
509:             .Height          = 75
510:             .FontName        = "Tahoma"
511:             .FontBold        = .T.
512:             .FontItalic      = .T.
513:             .FontSize        = 8
514:             .ForeColor       = RGB(90, 90, 90)
515:             .BackColor       = RGB(255, 255, 255)
516:             .Themes          = .F.
517:             .SpecialEffect   = 0
518:             .MousePointer    = 15
519:             .WordWrap        = .T.
520:             .AutoSize        = .F.
521:         ENDWITH
522:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
523: 
524:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
525:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
526:             .Caption         = "Buscar"
527:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
528:             .PicturePosition = 13
529:             .Top             = 5
530:             .Left            = 305
531:             .Width           = 75
532:             .Height          = 75
533:             .FontName        = "Tahoma"
534:             .FontBold        = .T.
535:             .FontItalic      = .T.
536:             .FontSize        = 8
537:             .ForeColor       = RGB(90, 90, 90)
538:             .BackColor       = RGB(255, 255, 255)
539:             .Themes          = .F.
540:             .SpecialEffect   = 0
541:             .MousePointer    = 15
542:             .WordWrap        = .T.
543:             .AutoSize        = .F.
544:         ENDWITH
545:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
546: 
547:         *----------------------------------------------------------------------
548:         * grd_4c_Dados - Grade principal de listagem
549:         * Original: Grade.Top=157, Left=12, Width=944, Height=434 -> comp +29 = 186
550:         * ColumnCount DEVE ser setado FORA do WITH (nao cria colunas dentro do WITH)
551:         *----------------------------------------------------------------------
552:         loc_oPagina.AddObject("grd_4c_Dados", "Grid")
553:         loc_oPagina.grd_4c_Dados.ColumnCount = 5
554:         WITH loc_oPagina.grd_4c_Dados
555:             .Top                = 186
556:             .Left               = 12
557:             .Width              = 944
558:             .Height             = 434
559:             .FontName           = "Tahoma"
560:             .FontSize           = 8
561:             .ForeColor          = RGB(90, 90, 90)
562:             .BackColor          = RGB(255, 255, 255)
563:             .GridLineColor      = RGB(238, 158, 162)
564:             .HighlightBackColor = RGB(255, 255, 255)
565:             .HighlightForeColor = RGB(15, 41, 104)
566:             .HighlightStyle     = 2
567:             .DeleteMark         = .F.
568:             .RecordMark         = .F.
569:             .RowHeight          = 16
570:             .ScrollBars         = 2
571:             .GridLines          = 3
572:             .ReadOnly           = .T.
573:         ENDWITH
574: 
575:         WITH loc_oPagina.grd_4c_Dados.Column1
576:             .ControlSource   = "cursor_4c_Dados.codigos"
577:             .Width           = 52
578:             .Alignment       = 2
579:             .Header1.Caption = "C" + CHR(243) + "digo"
580:         ENDWITH
581: 
582:         WITH loc_oPagina.grd_4c_Dados.Column2
583:             .ControlSource   = "cursor_4c_Dados.datas"
584:             .Width           = 75
585:             .Header1.Caption = "Data"

*-- Linhas 608 a 657:
608:         loc_oPagina.grd_4c_Dados.RecordSource     = "cursor_4c_Dados"
609:         loc_oPagina.grd_4c_Dados.RecordSourceType = 1
610: 
611:         BINDEVENT(loc_oPagina.grd_4c_Dados, "DblClick", THIS, "BtnVisualizarClick")
612: 
613:         THIS.TornarControlesVisiveis(loc_oPagina)
614:     ENDPROC
615: 
616:     *==========================================================================
617:     PROTECTED PROCEDURE ConfigurarPaginaDados()
618:     *==========================================================================
619:         LOCAL loc_oPagina
620:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
621: 
622:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
623:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
624: 
625:         *----------------------------------------------------------------------
626:         * cnt_4c_Salva - Botoes Confirmar/Cancelar (Fase 4 adiciona os botoes)
627:         * Canonico: Top=33, Left=842, Width=160, Height=85
628:         *----------------------------------------------------------------------
629:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
630:         WITH loc_oPagina.cnt_4c_Salva
631:             .Top           = 33
632:             .Left          = 842
633:             .Width         = 160
634:             .Height        = 85
635:             .BackStyle = 1
636:             .BackColor = RGB(255, 255, 255)
637:             .SpecialEffect = 0
638:             .Visible     = .T.
639:         ENDWITH
640: 
641:         *----------------------------------------------------------------------
642:         * cnt_4c_Container2 - 24 checkboxes de tubos + opt_status (Fase 5)
643:         * Original: top=5, left=9, width=296, height=594 -> comp +29 = 34
644:         *----------------------------------------------------------------------
645:         loc_oPagina.AddObject("cnt_4c_Container2", "Container")
646:         WITH loc_oPagina.cnt_4c_Container2
647:             .Top         = 34
648:             .Left        = 9
649:             .Width       = 296
650:             .Height      = 594
651:             .BackStyle   = 1
652:             .BackColor   = RGB(225, 225, 225)
653:             .BorderWidth = 0
654:             .Visible     = .T.
655:         ENDWITH
656: 
657:         *----------------------------------------------------------------------

*-- Linhas 770 a 851:
770:             .WordWrap        = .T.
771:             .AutoSize        = .F.
772:         ENDWITH
773:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
774: 
775:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
776:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
777:             .Caption         = "Encerrar"
778:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
779:             .PicturePosition = 13
780:             .Top             = 5
781:             .Left            = 80
782:             .Width           = 75
783:             .Height          = 75
784:             .FontName        = "Tahoma"
785:             .FontBold        = .T.
786:             .FontItalic      = .T.
787:             .FontSize        = 8
788:             .ForeColor       = RGB(90, 90, 90)
789:             .BackColor       = RGB(255, 255, 255)
790:             .Themes          = .F.
791:             .SpecialEffect   = 0
792:             .MousePointer    = 15
793:             .WordWrap        = .T.
794:             .AutoSize        = .F.
795:         ENDWITH
796:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
797: 
798:         THIS.ConfigurarContainer1(loc_oPagina)
799:         THIS.ConfigurarContainer2(loc_oPagina)
800:         THIS.ConfigurarContainer3(loc_oPagina)
801:         THIS.ConfigurarContainer4(loc_oPagina)
802:         THIS.ConfigurarContainer5(loc_oPagina)
803:         THIS.ConfigurarContainer6(loc_oPagina)
804:         THIS.ConfigurarCntTotal(loc_oPagina)
805:         THIS.ConfigurarCamposPage2(loc_oPagina)
806: 
807:         THIS.TornarControlesVisiveis(loc_oPagina)
808:     ENDPROC
809: 
810:     *==========================================================================
811:     PROTECTED PROCEDURE CarregarArvores()
812:     *==========================================================================
813:         LOCAL loc_nResultado
814:         loc_nResultado = 0
815: 
816:         TRY
817:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
818:                 *-- Sem conexao SQL durante validacao de UI - pular
819:             ELSE
820:                 IF USED("cursor_4c_Arvores")
821:                     USE IN cursor_4c_Arvores
822:                 ENDIF
823: 
824:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
825:                     "SELECT a.codigos, a.descs, a.formulas, a.percs," + ;
826:                     " a.tempmets, a.temptubs, a.tempambs, a.tempagus" + ;
827:                     " FROM sigcdarv a ORDER BY a.codigos", ;
828:                     "cursor_4c_Arvores")
829: 
830:                 IF loc_nResultado < 0
831:                     MsgErro("Erro ao carregar " + CHR(225) + "rvores:" + ;
832:                         CHR(13) + CapturarErroSQL(), "Erro SQL")
833:                 ENDIF
834:             ENDIF
835:         CATCH TO loc_oErro
836:             MsgErro("Erro em FormFUN.CarregarArvores: " + loc_oErro.Message, "Erro")
837:         ENDTRY
838:     ENDPROC
839: 
840:     *==========================================================================
841:     FUNCTION CarregarLista()
842:     *==========================================================================
843:         LOCAL loc_lSucesso, loc_cFiltro
844:         LOCAL loc_cEmps, loc_dDtIni, loc_dDtFim
845:         LOCAL loc_cDtIniSQL, loc_cDtFimSQL
846:         loc_lSucesso = .F.
847: 
848:         TRY
849:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
850:                 loc_lSucesso = .T.
851:             ELSE

*-- Linhas 914 a 1285:
914:     ENDFUNC
915: 
916:     *==========================================================================
917:     PROCEDURE AlternarPagina(par_nPagina)
918:     *==========================================================================
919:         LOCAL loc_lSucesso
920:         loc_lSucesso = .F.
921: 
922:         IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
923:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
924: 
925:             IF par_nPagina = 1
926:                 THIS.this_cModoAtual = "LISTA"
927:                 THIS.CarregarLista()
928:             ENDIF
929: 
930:             loc_lSucesso = .T.
931:         ENDIF
932: 
933:         RETURN loc_lSucesso
934:     ENDPROC
935: 
936:     *==========================================================================
937:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
938:     *==========================================================================
939:         LOCAL loc_i, loc_oObjeto, loc_cNome
940: 
941:         FOR loc_i = 1 TO par_oContainer.ControlCount
942:             loc_oObjeto = par_oContainer.Controls(loc_i)
943: 
944:             IF VARTYPE(loc_oObjeto) != "O"
945:                 LOOP
946:             ENDIF
947: 
948:             loc_cNome = UPPER(loc_oObjeto.Name)
949: 
950:             *-- containers ocultos: recursao nos filhos mas nao altera Visible
951:             IF INLIST(loc_cNome, "CNT_4C_TOTAL", "CNT_4C_CABECALHO", "CNT_4C_SALVA")
952:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
953:                     THIS.TornarControlesVisiveis(loc_oObjeto)
954:                 ENDIF
955:                 LOOP
956:             ENDIF
957: 
958:             IF PEMSTATUS(loc_oObjeto, "Visible", 5)
959:                 loc_oObjeto.Visible = .T.
960:             ENDIF
961: 
962:             *-- PageFrame: iterar Pages
963:             IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
964:                 LOCAL loc_p
965:                 FOR loc_p = 1 TO loc_oObjeto.PageCount
966:                     THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_p))
967:                 ENDFOR
968:             ENDIF
969: 
970:             *-- Container/Page: recursao nos filhos
971:             IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
972:                 THIS.TornarControlesVisiveis(loc_oObjeto)
973:             ENDIF
974:         ENDFOR
975:     ENDPROC
976: 
977:     *==========================================================================
978:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
979:     *==========================================================================
980:         WITH par_oGrid
981:             .FontName = "Verdana"
982:             .FontSize = 8
983:         ENDWITH
984:     ENDPROC
985: 
986:     *==========================================================================
987:     PROCEDURE BtnEncerrarClick()
988:     *==========================================================================
989:         THIS.Release()
990:     ENDPROC
991: 
992:     *==========================================================================
993:     PROCEDURE BtnIncluirClick()
994:     *==========================================================================
995:         LOCAL loc_lSucesso
996:         loc_lSucesso = .F.
997: 
998:         TRY
999:             THIS.this_oBusinessObject.NovoRegistro()
1000:             THIS.LimparCampos()
1001:             THIS.this_cModoAtual = "INCLUIR"
1002:             THIS.this_lEmEdicao  = .T.
1003:             THIS.AlternarPagina(2)
1004:             THIS.AtualizarEstadoControles()
1005:             loc_lSucesso = .T.
1006:         CATCH TO loc_oErro
1007:             MsgErro("Erro em FormFUN.BtnIncluirClick: " + loc_oErro.Message, "Erro")
1008:         ENDTRY
1009: 
1010:         RETURN loc_lSucesso
1011:     ENDPROC
1012: 
1013:     *==========================================================================
1014:     PROCEDURE BtnAlterarClick()
1015:     *==========================================================================
1016:         LOCAL loc_nCodigos, loc_lSucesso
1017:         loc_lSucesso = .F.
1018: 
1019:         TRY
1020:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1021:                 MsgAviso("Nenhum registro selecionado.", "Alterar")
1022:             ELSE
1023:                 SELECT cursor_4c_Dados
1024:                 loc_nCodigos = cursor_4c_Dados.codigos
1025: 
1026:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1027:                     THIS.BOParaForm()
1028:                     THIS.this_cModoAtual = "ALTERAR"
1029:                     THIS.this_lEmEdicao  = .T.
1030:                     THIS.AlternarPagina(2)
1031:                     THIS.ChkTubo(1)
1032:                     THIS.AtualizarEstadoControles()
1033:                     loc_lSucesso = .T.
1034:                 ENDIF
1035:             ENDIF
1036:         CATCH TO loc_oErro
1037:             MsgErro("Erro em FormFUN.BtnAlterarClick: " + loc_oErro.Message, "Erro")
1038:         ENDTRY
1039: 
1040:         RETURN loc_lSucesso
1041:     ENDPROC
1042: 
1043:     *==========================================================================
1044:     PROCEDURE BtnVisualizarClick()
1045:     *==========================================================================
1046:         LOCAL loc_nCodigos, loc_lSucesso
1047:         loc_lSucesso = .F.
1048: 
1049:         TRY
1050:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1051:                 MsgAviso("Nenhum registro selecionado.", "Visualizar")
1052:             ELSE
1053:                 SELECT cursor_4c_Dados
1054:                 loc_nCodigos = cursor_4c_Dados.codigos
1055: 
1056:                 IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1057:                     THIS.BOParaForm()
1058:                     THIS.this_cModoAtual = "VISUALIZAR"
1059:                     THIS.this_lEmEdicao  = .F.
1060:                     THIS.AlternarPagina(2)
1061:                     THIS.ChkTubo(1)
1062:                     THIS.AtualizarEstadoControles()
1063:                     loc_lSucesso = .T.
1064:                 ENDIF
1065:             ENDIF
1066:         CATCH TO loc_oErro
1067:             MsgErro("Erro em FormFUN.BtnVisualizarClick: " + loc_oErro.Message, "Erro")
1068:         ENDTRY
1069: 
1070:         RETURN loc_lSucesso
1071:     ENDPROC
1072: 
1073:     *==========================================================================
1074:     PROCEDURE BtnExcluirClick()
1075:     *==========================================================================
1076:         LOCAL loc_nCodigos, loc_lSucesso
1077:         loc_lSucesso = .F.
1078: 
1079:         TRY
1080:             IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
1081:                 MsgAviso("Nenhum registro selecionado.", "Excluir")
1082:             ELSE
1083:                 SELECT cursor_4c_Dados
1084:                 loc_nCodigos = cursor_4c_Dados.codigos
1085: 
1086:                 IF MsgConfirma("Confirma a exclus" + CHR(227) + "o da fundi" + CHR(231) + ;
1087:                     CHR(227) + "o " + TRANSFORM(loc_nCodigos) + "?", "Excluir")
1088:                     IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_nCodigos)
1089:                         IF THIS.this_oBusinessObject.Excluir()
1090:                             THIS.CarregarLista()
1091:                             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1092:                                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1093:                             ENDIF
1094:                             loc_lSucesso = .T.
1095:                         ENDIF
1096:                     ENDIF
1097:                 ENDIF
1098:             ENDIF
1099:         CATCH TO loc_oErro
1100:             MsgErro("Erro em FormFUN.BtnExcluirClick: " + loc_oErro.Message, "Erro")
1101:         ENDTRY
1102: 
1103:         RETURN loc_lSucesso
1104:     ENDPROC
1105: 
1106:     *==========================================================================
1107:     PROCEDURE BtnBuscarClick()
1108:     *==========================================================================
1109:         TRY
1110:             THIS.CarregarLista()
1111:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Dados", 5)
1112:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Dados.Refresh()
1113:             ENDIF
1114:         CATCH TO loc_oErro
1115:             MsgErro("Erro em FormFUN.BtnBuscarClick: " + loc_oErro.Message, "Erro")
1116:         ENDTRY
1117:     ENDPROC
1118: 
1119:     *==========================================================================
1120:     PROCEDURE BtnSalvarClick()
1121:     *==========================================================================
1122:         LOCAL loc_lSucesso
1123:         loc_lSucesso = .F.
1124: 
1125:         TRY
1126:             THIS.SalvarDadosTubo()
1127:             THIS.FormParaBO()
1128: 
1129:             IF THIS.this_oBusinessObject.Salvar()
1130:                 MsgInfo("Registro salvo com sucesso!", "Salvo")
1131:                 THIS.this_lEmEdicao  = .F.
1132:                 THIS.this_cModoAtual = "LISTA"
1133:                 THIS.AlternarPagina(1)
1134:                 THIS.AtualizarEstadoControles()
1135:                 loc_lSucesso = .T.
1136:             ELSE
1137:                 MsgErro(THIS.this_oBusinessObject.ObterMensagemErro(), "Erro ao salvar")
1138:             ENDIF
1139:         CATCH TO loc_oErro
1140:             MsgErro("Erro em FormFUN.BtnSalvarClick: " + loc_oErro.Message, "Erro")
1141:         ENDTRY
1142: 
1143:         RETURN loc_lSucesso
1144:     ENDPROC
1145: 
1146:     *==========================================================================
1147:     PROCEDURE BtnCancelarClick()
1148:     *==========================================================================
1149:         LOCAL loc_lSucesso, loc_lContinuar
1150:         loc_lSucesso  = .F.
1151:         loc_lContinuar = .T.
1152: 
1153:         IF THIS.this_lEmEdicao
1154:             IF !MsgConfirma("Deseja cancelar a edi" + CHR(231) + CHR(227) + "o?", "Cancelar")
1155:                 loc_lContinuar = .F.
1156:             ENDIF
1157:         ENDIF
1158: 
1159:         IF loc_lContinuar
1160:             TRY
1161:                 THIS.this_lEmEdicao  = .F.
1162:                 THIS.this_cModoAtual = "LISTA"
1163:                 THIS.AlternarPagina(1)
1164:                 THIS.AtualizarEstadoControles()
1165:                 loc_lSucesso = .T.
1166:             CATCH TO loc_oErro
1167:                 MsgErro("Erro em FormFUN.BtnCancelarClick: " + loc_oErro.Message, "Erro")
1168:             ENDTRY
1169:         ENDIF
1170: 
1171:         RETURN loc_lSucesso
1172:     ENDPROC
1173: 
1174:     *==========================================================================
1175:     PROCEDURE AtualizarEstadoControles()
1176:     *==========================================================================
1177:         LOCAL loc_lEmLista, loc_lEmEdicao, loc_oPg1, loc_oPg2, loc_lOk
1178:         loc_lEmLista  = (THIS.this_cModoAtual = "LISTA")
1179:         loc_lEmEdicao = !loc_lEmLista
1180:         loc_lOk = TYPE("THIS.pgf_4c_Paginas") = "O" AND !ISNULL(THIS.pgf_4c_Paginas)
1181: 
1182:         TRY
1183:             IF loc_lOk
1184:                 loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1185:                 IF PEMSTATUS(loc_oPg1, "cnt_4c_Botoes", 5)
1186:                     IF PEMSTATUS(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5)
1187:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
1188:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1189:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
1190:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
1191:                         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
1192:                     ENDIF
1193:                 ENDIF
1194: 
1195:                 loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1196:                 IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
1197:                     IF PEMSTATUS(loc_oPg2.cnt_4c_Salva, "cmd_4c_Confirmar", 5)
1198:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
1199:                             (loc_lEmEdicao AND THIS.this_cModoAtual != "VISUALIZAR")
1200:                         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
1201:                     ENDIF
1202:                 ENDIF
1203:             ENDIF
1204:         CATCH TO loc_oErro
1205:             MsgErro("Erro em FormFUN.AtualizarEstadoControles: " + loc_oErro.Message, "Erro")
1206:         ENDTRY
1207:     ENDPROC
1208: 
1209:     *==========================================================================
1210:     PROCEDURE Destroy()
1211:     *==========================================================================
1212:         TRY
1213:             IF USED("TmpCera")
1214:                 USE IN TmpCera
1215:             ENDIF
1216:             IF USED("TmpTrf")
1217:                 USE IN TmpTrf
1218:             ENDIF
1219:             IF USED("TmpNop")
1220:                 USE IN TmpNop
1221:             ENDIF
1222:             IF USED("cursor_4c_Arvores")
1223:                 USE IN cursor_4c_Arvores
1224:             ENDIF
1225:             IF USED("cursor_4c_Dados")
1226:                 USE IN cursor_4c_Dados
1227:             ENDIF
1228:             IF USED("cursor_4c_TubosFund")
1229:                 USE IN cursor_4c_TubosFund
1230:             ENDIF
1231:             IF USED("cursor_4c_BuscaAux")
1232:                 USE IN cursor_4c_BuscaAux
1233:             ENDIF
1234:             IF USED("cursor_4c_TmpTot")
1235:                 USE IN cursor_4c_TmpTot
1236:             ENDIF
1237:         CATCH
1238:             *-- Silencioso no Destroy
1239:         ENDTRY
1240: 
1241:         DODEFAULT()
1242:     ENDPROC
1243: 
1244:     *==========================================================================
1245:     PROTECTED PROCEDURE ConfigurarContainer1(par_oPagina)
1246:     *==========================================================================
1247:         LOCAL loc_oCnt
1248:         loc_oCnt = par_oPagina.cnt_4c_Container1
1249: 
1250:         *-- lbl_4c_FundNo (Say2): "Fundicao No :"
1251:         loc_oCnt.AddObject("lbl_4c_FundNo", "Label")
1252:         WITH loc_oCnt.lbl_4c_FundNo
1253:             .Caption   = "Fundi" + CHR(231) + CHR(227) + "o N" + CHR(186) + " :"
1254:             .Left      = 5
1255:             .Top       = 10
1256:             .AutoSize  = .T.
1257:             .FontBold  = .T.
1258:             .BackStyle = 0
1259:             .ForeColor = RGB(36, 84, 155)
1260:         ENDWITH
1261: 
1262:         *-- txt_4c_Codigos (getCodigos): numero sequencial, somente leitura
1263:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
1264:         WITH loc_oCnt.txt_4c_Codigos
1265:             .Value     = 0
1266:             .InputMask = "999999"
1267:             .MaxLength = 7
1268:             .Left      = 96
1269:             .Top       = 5
1270:             .Width     = 52
1271:             .Height    = 25
1272:             .ReadOnly  = .T.
1273:         ENDWITH
1274: 
1275:         *-- lbl_4c_MaquinaLabel (Say4): "Maquina :"
1276:         loc_oCnt.AddObject("lbl_4c_MaquinaLabel", "Label")
1277:         WITH loc_oCnt.lbl_4c_MaquinaLabel
1278:             .Caption   = "M" + CHR(225) + "quina :"
1279:             .Left      = 188
1280:             .Top       = 10
1281:             .AutoSize  = .T.
1282:             .FontBold  = .T.
1283:             .BackStyle = 0
1284:             .ForeColor = RGB(36, 84, 155)
1285:         ENDWITH

*-- Linhas 1294 a 1337:
1294:             .Width     = 79
1295:             .Height    = 25
1296:         ENDWITH
1297:         BINDEVENT(loc_oCnt.txt_4c_Maq, "KeyPress", THIS, "ValidarMaquina")
1298: 
1299:         *-- lbl_4c_DataLabel (Say3): "Data :"
1300:         loc_oCnt.AddObject("lbl_4c_DataLabel", "Label")
1301:         WITH loc_oCnt.lbl_4c_DataLabel
1302:             .Caption   = "Data :"
1303:             .Left      = 54
1304:             .Top       = 41
1305:             .AutoSize  = .T.
1306:             .FontBold  = .T.
1307:             .BackStyle = 0
1308:             .ForeColor = RGB(36, 84, 155)
1309:         ENDWITH
1310: 
1311:         *-- txt_4c_Datas (getDatas): data da fundicao
1312:         loc_oCnt.AddObject("txt_4c_Datas", "TextBox")
1313:         WITH loc_oCnt.txt_4c_Datas
1314:             .Value     = {}
1315:             .MaxLength = 10
1316:             .Left      = 96
1317:             .Top       = 36
1318:             .Width     = 79
1319:             .Height    = 25
1320:         ENDWITH
1321: 
1322:         *-- lbl_4c_UsuarioLabel (Say1): "Usuario :"
1323:         loc_oCnt.AddObject("lbl_4c_UsuarioLabel", "Label")
1324:         WITH loc_oCnt.lbl_4c_UsuarioLabel
1325:             .Caption   = "Usu" + CHR(225) + "rio :"
1326:             .Left      = 192
1327:             .Top       = 41
1328:             .AutoSize  = .T.
1329:             .FontBold  = .T.
1330:             .BackStyle = 0
1331:             .ForeColor = RGB(36, 84, 155)
1332:         ENDWITH
1333: 
1334:         *-- txt_4c_Usu (Getusu): usuario que registrou, sempre somente leitura
1335:         loc_oCnt.AddObject("txt_4c_Usu", "TextBox")
1336:         WITH loc_oCnt.txt_4c_Usu
1337:             .Value     = ""

*-- Linhas 1345 a 1455:
1345:     ENDPROC
1346: 
1347:     *==========================================================================
1348:     PROTECTED PROCEDURE ConfigurarContainer2(par_oPagina)
1349:     *==========================================================================
1350:         LOCAL loc_oCnt, loc_oChk, loc_cNomeChk, loc_n
1351:         LOCAL loc_nRow, loc_nCol, loc_nLeft, loc_nTop, loc_cPic
1352:         LOCAL ARRAY loc_aTops[6]
1353:         LOCAL ARRAY loc_aLefts[4]
1354: 
1355:         loc_oCnt = par_oPagina.cnt_4c_Container2
1356: 
1357:         *-- Cor vermelha conforme legado (BackStyle=0 = transparente sobre fundo vermelho)
1358:         loc_oCnt.BackColor = RGB(255, 0, 0)
1359:         loc_oCnt.BackStyle = 0
1360: 
1361:         *-- lbl_4c_Tubos (Label1): cabecalho da secao de tubos
1362:         loc_oCnt.AddObject("lbl_4c_Tubos", "Label")
1363:         WITH loc_oCnt.lbl_4c_Tubos
1364:             .Caption   = "\<Tubos"
1365:             .Left      = 5
1366:             .Top       = 1
1367:             .AutoSize  = .T.
1368:             .FontName  = "Verdana"
1369:             .FontBold  = .T.
1370:             .FontSize  = 8
1371:             .BackStyle = 0
1372:             .ForeColor = RGB(36, 84, 155)
1373:             .BackColor = RGB(210, 210, 210)
1374:         ENDWITH
1375: 
1376:         *-- opt_4c_Status: OptionGroup 4 opcoes de status (Nenhum/Cera/Fundir/Peca)
1377:         loc_oCnt.AddObject("opt_4c_Status", "OptionGroup")
1378:         WITH loc_oCnt.opt_4c_Status
1379:             .ButtonCount    = 4
1380:             .Left           = 69
1381:             .Top            = -3
1382:             .Width          = 228
1383:             .Height         = 25
1384:             .AutoSize       = .T.
1385:             .BackStyle      = 0
1386:             .Buttons(1).Caption  = "Nenhum"
1387:             .Buttons(1).Left     = 5
1388:             .Buttons(1).Top      = 5
1389:             .Buttons(1).AutoSize = .T.
1390:             .Buttons(2).Caption  = "Cera"
1391:             .Buttons(2).Left     = 72
1392:             .Buttons(2).Top      = 5
1393:             .Buttons(2).AutoSize = .T.
1394:             .Buttons(3).Caption  = "Fundir"
1395:             .Buttons(3).Left     = 120
1396:             .Buttons(3).Top      = 5
1397:             .Buttons(3).Width    = 54
1398:             .Buttons(3).Height   = 15
1399:             .Buttons(3).AutoSize = .T.
1400:             .Buttons(3).FontName = "Verdana"
1401:             .Buttons(3).FontSize = 8
1402:             .Buttons(3).BackStyle = 0
1403:             .Buttons(3).ForeColor = RGB(36, 84, 155)
1404:             .Buttons(4).Caption  = "Pe" + CHR(231) + "a"
1405:             .Buttons(4).Left     = 177
1406:             .Buttons(4).Top      = 5
1407:             .Buttons(4).Width    = 46
1408:             .Buttons(4).Height   = 15
1409:             .Buttons(4).AutoSize = .T.
1410:             .Buttons(4).FontName = "Verdana"
1411:             .Buttons(4).FontSize = 8
1412:             .Buttons(4).BackStyle = 0
1413:             .Buttons(4).ForeColor = RGB(36, 84, 155)
1414:         ENDWITH
1415:         BINDEVENT(loc_oCnt.opt_4c_Status, "InteractiveChange", THIS, "OptStatusChanged")
1416: 
1417:         *-- 24 CheckBoxes: grade 4 colunas x 6 linhas (Style=1 grafico, PicturePosition=13)
1418:         *   Colunas  Left: 3, 76, 149, 222
1419:         *   Linhas   Top:  20, 116, 212, 308, 404, 500
1420:         loc_aTops[1]  = 20
1421:         loc_aTops[2]  = 116
1422:         loc_aTops[3]  = 212
1423:         loc_aTops[4]  = 308
1424:         loc_aTops[5]  = 404
1425:         loc_aTops[6]  = 500
1426:         loc_aLefts[1] = 3
1427:         loc_aLefts[2] = 76
1428:         loc_aLefts[3] = 149
1429:         loc_aLefts[4] = 222
1430: 
1431:         FOR loc_n = 1 TO 24
1432:             loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1433:             loc_nRow = INT((loc_n - 1) / 4) + 1
1434:             loc_nCol = MOD(loc_n - 1, 4) + 1
1435:             loc_nTop  = loc_aTops[loc_nRow]
1436:             loc_nLeft = loc_aLefts[loc_nCol]
1437: 
1438:             DO CASE
1439:                 CASE loc_n = 1
1440:                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1441:                 CASE loc_n = 2
1442:                     loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1443:                 CASE loc_n = 3
1444:                     loc_cPic = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
1445:                 OTHERWISE
1446:                     loc_cPic = ""
1447:             ENDCASE
1448: 
1449:             loc_oCnt.AddObject(loc_cNomeChk, "CheckBox")
1450:             loc_oChk = EVALUATE("loc_oCnt." + loc_cNomeChk)
1451:             WITH loc_oChk
1452:                 .Caption         = PADL(TRANSFORM(loc_n), 2, "0")
1453:                 .Style           = 1
1454:                 .PicturePosition = 13
1455:                 .Alignment       = 0

*-- Linhas 1467 a 1635:
1467:             IF !EMPTY(loc_cPic) AND FILE(loc_cPic)
1468:                 loc_oCnt.Picture = loc_cPic
1469:             ENDIF
1470:             BINDEVENT(loc_oChk, "Click", THIS, "ChkTuboClick")
1471:         ENDFOR
1472:     ENDPROC
1473: 
1474:     *==========================================================================
1475:     PROCEDURE ChkTuboClick()
1476:     *==========================================================================
1477:         LOCAL loc_cTag, loc_nTubo
1478: 
1479:         TRY
1480:             loc_cTag  = _VFP.ActiveForm.ActiveControl.Tag
1481:             loc_nTubo = 0
1482:             IF LEFT(loc_cTag, 5) = "TUBE:"
1483:                 loc_nTubo = VAL(SUBSTR(loc_cTag, 6))
1484:             ENDIF
1485:             IF loc_nTubo > 0
1486:                 THIS.ChkTubo(loc_nTubo)
1487:             ENDIF
1488:         CATCH TO loc_oErro
1489:             MsgErro("Erro em FormFUN.ChkTuboClick: " + loc_oErro.Message, "Erro")
1490:         ENDTRY
1491:     ENDPROC
1492: 
1493:     *==========================================================================
1494:     PROCEDURE OptStatusChanged()
1495:     *==========================================================================
1496:         LOCAL loc_nStatus, loc_nMaqTubos, loc_n, loc_cNomeChk, loc_oCnt
1497: 
1498:         TRY
1499:             loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1500:             loc_nStatus   = loc_oCnt.opt_4c_Status.Value
1501:             loc_nMaqTubos = THIS.this_nMaqTubos
1502: 
1503:             FOR loc_n = 1 TO loc_nMaqTubos
1504:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1505:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1506:                     IF loc_oCnt.Value = 1
1507:                         SELECT TmpCera
1508:                         SET ORDER TO Tubos
1509:                         IF SEEK(STR(loc_n, 2))
1510:                             DO CASE
1511:                                 CASE loc_nStatus = 1
1512:                                     REPLACE nStatus WITH 1 IN TmpCera
1513:                                     loc_oCnt.Picture = ""
1514:                                 CASE loc_nStatus = 2
1515:                                     REPLACE nStatus WITH 2 IN TmpCera
1516:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_cera_60.jpg"
1517:                                 CASE loc_nStatus = 3
1518:                                     REPLACE nStatus WITH 3 IN TmpCera
1519:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1520:                                 CASE loc_nStatus = 4
1521:                                     REPLACE nStatus WITH 4 IN TmpCera
1522:                                     loc_oCnt.Picture = gc_4c_CaminhoIcones + "geral_pecapronta_60.jpg"
1523:                             ENDCASE
1524:                         ENDIF
1525:                     ENDIF
1526:                 ENDIF
1527:             ENDFOR
1528:         CATCH TO loc_oErro
1529:             MsgErro("Erro em FormFUN.OptStatusChanged: " + loc_oErro.Message, "Erro")
1530:         ENDTRY
1531:     ENDPROC
1532: 
1533:     *==========================================================================
1534:     PROCEDURE ValidarMaquina(par_nKeyCode, par_nShiftAltCtrl)
1535:     *==========================================================================
1536:         LOCAL loc_cCodMaq, loc_nResultado, loc_nTubos, loc_oCnt1
1537: 
1538:         TRY
1539:             loc_oCnt1   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1540:             loc_cCodMaq = ALLTRIM(loc_oCnt1.txt_4c_Maq.Value)
1541: 
1542:             IF EMPTY(loc_cCodMaq)
1543:                 THIS.this_nMaqTubos = 0
1544:                 THIS.AtualizarVisibilidadeCheckboxes(0)
1545:             ELSE
1546:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
1547:                     "SELECT m.codigos, m.tubos FROM SigCfMqf m WHERE m.codigos = " + ;
1548:                     EscaparSQL(loc_cCodMaq), ;
1549:                     "cursor_4c_BuscaMaq")
1550: 
1551:                 loc_nTubos = 0
1552:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaMaq") AND ;
1553:                         RECCOUNT("cursor_4c_BuscaMaq") > 0
1554:                     SELECT cursor_4c_BuscaMaq
1555:                     loc_nTubos = cursor_4c_BuscaMaq.tubos
1556:                     THIS.this_nMaqTubos = loc_nTubos
1557:                     THIS.AtualizarVisibilidadeCheckboxes(loc_nTubos)
1558:                 ELSE
1559:                     MsgAviso("M" + CHR(225) + "quina '" + loc_cCodMaq + ;
1560:                         "' n" + CHR(227) + "o encontrada.", ;
1561:                         "M" + CHR(225) + "quina")
1562:                     loc_oCnt1.txt_4c_Maq.Value = ""
1563:                     THIS.this_nMaqTubos = 0
1564:                     THIS.AtualizarVisibilidadeCheckboxes(0)
1565:                 ENDIF
1566: 
1567:                 IF USED("cursor_4c_BuscaMaq")
1568:                     USE IN cursor_4c_BuscaMaq
1569:                 ENDIF
1570:             ENDIF
1571:         CATCH TO loc_oErro
1572:             MsgErro("Erro em FormFUN.ValidarMaquina: " + loc_oErro.Message, "Erro")
1573:         ENDTRY
1574:     ENDPROC
1575: 
1576:     *==========================================================================
1577:     PROTECTED PROCEDURE AtualizarVisibilidadeCheckboxes(par_nMaqTubos)
1578:     *==========================================================================
1579:         LOCAL loc_oCnt, loc_n, loc_cNomeChk
1580: 
1581:         TRY
1582:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1583:             FOR loc_n = 1 TO 24
1584:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1585:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1586:                     loc_oCnt.Visible = (loc_n <= par_nMaqTubos)
1587:                 ENDIF
1588:             ENDFOR
1589:         CATCH TO loc_oErro
1590:             MsgErro("Erro em FormFUN.AtualizarVisibilidadeCheckboxes: " + loc_oErro.Message, "Erro")
1591:         ENDTRY
1592:     ENDPROC
1593: 
1594:     *==========================================================================
1595:     PROCEDURE ChkTubo(par_nTubo)
1596:     *==========================================================================
1597:         LOCAL loc_n, loc_nMaqTubos, loc_oCnt, loc_cNomeChk, loc_cPic
1598: 
1599:         TRY
1600:             *-- Salvar dados do tubo anterior antes de trocar
1601:             IF THIS.this_nTuboAtual > 0 AND THIS.this_nTuboAtual != par_nTubo
1602:                 THIS.SalvarDadosTubo()
1603:             ENDIF
1604: 
1605:             THIS.this_nTuboAtual = par_nTubo
1606:             loc_oCnt      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1607:             loc_nMaqTubos = THIS.this_nMaqTubos
1608: 
1609:             *-- Atualizar caption do tubo corrente em Container4 (se lbl_4c_SayTubo existir)
1610:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "lbl_4c_SayTubo", 5)
1611:                 IF par_nTubo > 0
1612:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = ;
1613:                         "( " + PADL(TRANSFORM(par_nTubo), 2, "0") + " )"
1614:                 ELSE
1615:                     THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.lbl_4c_SayTubo.Caption = "( )"
1616:                 ENDIF
1617:             ENDIF
1618: 
1619:             *-- Atualizar imagens dos checkboxes baseado em TmpTrf/TmpNop/TmpCera
1620:             FOR loc_n = 1 TO loc_nMaqTubos
1621:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1622:                 IF PEMSTATUS(loc_oCnt, loc_cNomeChk, 5)
1623:                     loc_cPic = ""
1624: 
1625:                     *-- Tubo com transformacao metalica em andamento
1626:                     IF USED("TmpTrf") AND RECCOUNT("TmpTrf") > 0
1627:                         SELECT TmpTrf
1628:                         SET ORDER TO 0
1629:                         LOCATE FOR TmpTrf.Tubos = loc_n
1630:                         IF FOUND()
1631:                             loc_cPic = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
1632:                         ENDIF
1633:                     ENDIF
1634: 
1635:                     *-- Tubo com peca pronta (ordem de producao concluida)

*-- Linhas 1724 a 1789:
1724:     ENDPROC
1725: 
1726:     *==========================================================================
1727:     PROCEDURE LimparCampos()
1728:     *==========================================================================
1729:         LOCAL loc_oCnt1, loc_oCnt2, loc_oCnt3, loc_n, loc_cNomeChk
1730: 
1731:         TRY
1732:             loc_oCnt1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1733:             loc_oCnt2 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1734: 
1735:             *-- Limpar campos do cabecalho (Container1)
1736:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Codigos", 5)
1737:                 loc_oCnt1.txt_4c_Codigos.Value = 0
1738:             ENDIF
1739:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
1740:                 loc_oCnt1.txt_4c_Datas.Value = {}
1741:             ENDIF
1742:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Usu", 5)
1743:                 loc_oCnt1.txt_4c_Usu.Value = ""
1744:             ENDIF
1745:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
1746:                 loc_oCnt1.txt_4c_Maq.Value = ""
1747:             ENDIF
1748: 
1749:             *-- Resetar OptionGroup e checkboxes (Container2)
1750:             IF PEMSTATUS(loc_oCnt2, "opt_4c_Status", 5)
1751:                 loc_oCnt2.opt_4c_Status.Value = 1
1752:             ENDIF
1753: 
1754:             FOR loc_n = 1 TO 24
1755:                 loc_cNomeChk = "chk_4c_Check" + TRANSFORM(loc_n)
1756:                 IF PEMSTATUS(loc_oCnt2, loc_cNomeChk, 5)
1757:                     loc_oCnt2.Value   = 0
1758:                     loc_oCnt2.Picture = ""
1759:                 ENDIF
1760:             ENDFOR
1761: 
1762:             *-- Zerar cursores de trabalho
1763:             IF USED("TmpCera")
1764:                 ZAP IN TmpCera
1765:             ENDIF
1766:             IF USED("TmpTrf")
1767:                 ZAP IN TmpTrf
1768:             ENDIF
1769:             IF USED("TmpNop")
1770:                 ZAP IN TmpNop
1771:             ENDIF
1772: 
1773:             THIS.this_nMaqTubos  = 0
1774:             THIS.this_nTuboAtual = 0
1775:             THIS.AtualizarVisibilidadeCheckboxes(0)
1776: 
1777:             *-- Limpar campos de entrada de Container3 se ja existem
1778:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
1779:             IF PEMSTATUS(loc_oCnt3, "txt_4c_Nop", 5)
1780:                 loc_oCnt3.txt_4c_Nop.Value  = 0
1781:                 loc_oCnt3.txt_4c_QtTb.Value = 0
1782:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
1783:                     loc_oCnt3.txt_4c_Qtd.Value = 0
1784:                 ENDIF
1785:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
1786:                     loc_oCnt3.txt_4c_Pecas.Value = 0
1787:                 ENDIF
1788:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
1789:                     loc_oCnt3.txt_4c_Operacao.Value = ""

*-- Linhas 1809 a 1852:
1809:     ENDPROC
1810: 
1811:     *==========================================================================
1812:     PROCEDURE BOParaForm()
1813:     *==========================================================================
1814:         LOCAL loc_oBO, loc_oCnt1, loc_oCnt2, loc_nResultado, loc_nCodigos
1815:         LOCAL loc_n, loc_cNomeChk, loc_cPic
1816:         LOCAL loc_nTubo, loc_nBCeras, loc_nBases, loc_nCeras, loc_nPMetals
1817:         LOCAL loc_cCodCors, loc_mObss, loc_cTmpMets, loc_cTmpAmbs
1818:         LOCAL loc_cTmpTubs, loc_cTmpAgus, loc_cCodArvs, loc_cDescs
1819:         LOCAL loc_mFormulas, loc_nMetalNvs, loc_nPmetalrs, loc_nNStatus
1820: 
1821:         TRY
1822:             loc_oBO      = THIS.this_oBusinessObject
1823:             loc_oCnt1    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
1824:             loc_oCnt2    = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container2
1825:             loc_nCodigos = loc_oBO.this_nCodigos
1826: 
1827:             *-- Preencher Container1 com dados do cabecalho (SIGCDFUN)
1828:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Codigos", 5)
1829:                 loc_oCnt1.txt_4c_Codigos.Value = loc_nCodigos
1830:             ENDIF
1831:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
1832:                 loc_oCnt1.txt_4c_Datas.Value = loc_oBO.this_dDatas
1833:             ENDIF
1834:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Usu", 5)
1835:                 loc_oCnt1.txt_4c_Usu.Value = ALLTRIM(loc_oBO.this_cUsuars)
1836:             ENDIF
1837:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
1838:                 loc_oCnt1.txt_4c_Maq.Value = ALLTRIM(loc_oBO.this_cCodMaqfs)
1839:             ENDIF
1840: 
1841:             *-- Numero de tubos da maquina -> visibilidade dos checkboxes
1842:             THIS.this_nMaqTubos = loc_oBO.this_nNTubos
1843:             THIS.AtualizarVisibilidadeCheckboxes(THIS.this_nMaqTubos)
1844: 
1845:             *-- Limpar cursores antes de recarregar
1846:             IF USED("TmpCera")
1847:                 ZAP IN TmpCera
1848:             ENDIF
1849:             IF USED("TmpTrf")
1850:                 ZAP IN TmpTrf
1851:             ENDIF
1852:             IF USED("TmpNop")

*-- Linhas 2020 a 2173:
2020:     ENDPROC
2021: 
2022:     *==========================================================================
2023:     PROCEDURE FormParaBO()
2024:     *==========================================================================
2025:         LOCAL loc_oBO, loc_oCnt1
2026: 
2027:         TRY
2028:             loc_oBO   = THIS.this_oBusinessObject
2029:             loc_oCnt1 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container1
2030: 
2031:             *-- Transferir campos editaveis do cabecalho para o BO
2032:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Datas", 5)
2033:                 loc_oBO.this_dDatas = loc_oCnt1.txt_4c_Datas.Value
2034:             ENDIF
2035:             IF PEMSTATUS(loc_oCnt1, "txt_4c_Maq", 5)
2036:                 loc_oBO.this_cCodMaqfs = ALLTRIM(loc_oCnt1.txt_4c_Maq.Value)
2037:             ENDIF
2038: 
2039:             *-- Usuario e empresa (preenchidos automaticamente)
2040:             loc_oBO.this_cUsuars = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
2041:             loc_oBO.this_cEmps   = ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))
2042: 
2043:             *-- Numero de tubos da maquina corrente
2044:             loc_oBO.this_nNTubos = THIS.this_nMaqTubos
2045: 
2046:             *-- Observacao geral
2047:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4, "edt_4c_ObsG", 5)
2048:                 loc_oBO.this_mObsG = ;
2049:                     ALLTRIM(THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4.edt_4c_ObsG.Value)
2050:             ENDIF
2051: 
2052:         CATCH TO loc_oErro
2053:             MsgErro("Erro em FormFUN.FormParaBO: " + loc_oErro.Message, "Erro")
2054:         ENDTRY
2055:     ENDPROC
2056: 
2057:     *==========================================================================
2058:     PROTECTED PROCEDURE ConfigurarContainer3(par_oPagina)
2059:     *==========================================================================
2060:         LOCAL loc_oCnt
2061:         loc_oCnt = par_oPagina.cnt_4c_Container3
2062: 
2063:         loc_oCnt.AddObject("lbl_4c_SayNop", "Label")
2064:         WITH loc_oCnt.lbl_4c_SayNop
2065:             .Caption   = "O.P. n" + CHR(186) + " :"
2066:             .Left      = 20
2067:             .Top       = 6
2068:             .AutoSize  = .T.
2069:             .FontBold  = .T.
2070:             .BackStyle = 0
2071:             .ForeColor = RGB(36, 84, 155)
2072:         ENDWITH
2073: 
2074:         loc_oCnt.AddObject("txt_4c_Nop", "TextBox")
2075:         WITH loc_oCnt.txt_4c_Nop
2076:             .Value     = 0
2077:             .InputMask = "9999999999"
2078:             .Left      = 73
2079:             .Top       = 4
2080:             .Width     = 94
2081:             .Height    = 20
2082:             .FontName  = "Tahoma"
2083:             .FontSize  = 8
2084:         ENDWITH
2085:         BINDEVENT(loc_oCnt.txt_4c_Nop, "KeyPress", THIS, "NopLostFocus")
2086: 
2087:         loc_oCnt.AddObject("lbl_4c_SayComp", "Label")
2088:         WITH loc_oCnt.lbl_4c_SayComp
2089:             .Caption   = "Componentes:"
2090:             .Left      = 171
2091:             .Top       = 6
2092:             .AutoSize  = .T.
2093:             .FontBold  = .T.
2094:             .BackStyle = 0
2095:             .ForeColor = RGB(36, 84, 155)
2096:         ENDWITH
2097: 
2098:         loc_oCnt.AddObject("txt_4c_Qtd", "TextBox")
2099:         WITH loc_oCnt.txt_4c_Qtd
2100:             .Value     = 0
2101:             .Left      = 260
2102:             .Top       = 4
2103:             .Width     = 87
2104:             .Height    = 20
2105:             .ReadOnly  = .T.
2106:             .FontName  = "Tahoma"
2107:             .FontSize  = 8
2108:             .BackColor = RGB(240, 240, 240)
2109:         ENDWITH
2110: 
2111:         loc_oCnt.AddObject("lbl_4c_SayQtTb", "Label")
2112:         WITH loc_oCnt.lbl_4c_SayQtTb
2113:             .Caption   = "Qtde Tubo :"
2114:             .Left      = 2
2115:             .Top       = 27
2116:             .AutoSize  = .T.
2117:             .FontBold  = .T.
2118:             .BackStyle = 0
2119:             .ForeColor = RGB(36, 84, 155)
2120:         ENDWITH
2121: 
2122:         loc_oCnt.AddObject("txt_4c_QtTb", "TextBox")
2123:         WITH loc_oCnt.txt_4c_QtTb
2124:             .Value     = 0
2125:             .InputMask = "9999999999.999"
2126:             .Left      = 73
2127:             .Top       = 25
2128:             .Width     = 94
2129:             .Height    = 20
2130:             .FontName  = "Tahoma"
2131:             .FontSize  = 8
2132:         ENDWITH
2133:         BINDEVENT(loc_oCnt.txt_4c_QtTb, "KeyPress", THIS, "QtTbLostFocus")
2134: 
2135:         loc_oCnt.AddObject("lbl_4c_SayPecas", "Label")
2136:         WITH loc_oCnt.lbl_4c_SayPecas
2137:             .Caption   = "Qtd. Pe" + CHR(231) + "as :"
2138:             .Left      = 185
2139:             .Top       = 27
2140:             .AutoSize  = .T.
2141:             .FontBold  = .T.
2142:             .BackStyle = 0
2143:             .ForeColor = RGB(36, 84, 155)
2144:         ENDWITH
2145: 
2146:         loc_oCnt.AddObject("txt_4c_Pecas", "TextBox")
2147:         WITH loc_oCnt.txt_4c_Pecas
2148:             .Value     = 0
2149:             .Left      = 260
2150:             .Top       = 25
2151:             .Width     = 87
2152:             .Height    = 20
2153:             .ReadOnly  = .T.
2154:             .FontName  = "Tahoma"
2155:             .FontSize  = 8
2156:             .BackColor = RGB(240, 240, 240)
2157:         ENDWITH
2158: 
2159:         loc_oCnt.AddObject("grd_4c_Gradenop", "Grid")
2160:         loc_oCnt.grd_4c_Gradenop.ColumnCount = 5
2161:         loc_oCnt.grd_4c_Gradenop.RecordSource = "TmpNop"
2162:         WITH loc_oCnt.grd_4c_Gradenop
2163:             .Top          = 48
2164:             .Left         = 7
2165:             .Width        = 435
2166:             .Height       = 122
2167:             .FontName     = "Tahoma"
2168:             .FontSize     = 8
2169:             .ReadOnly     = .T.
2170:             .GridLines    = 1
2171:             .HeaderHeight = 17
2172:             .RowHeight    = 17
2173:             .RecordMark   = .F.

*-- Linhas 2203 a 2533:
2203:             .ControlSource   = "TmpNop.DtEnts"
2204:             .Width           = 90
2205:         ENDWITH
2206:         BINDEVENT(loc_oCnt.grd_4c_Gradenop, "AfterRowColChange", THIS, "GradenopAfterRowColChange")
2207: 
2208:         loc_oCnt.AddObject("txt_4c_Operacao", "TextBox")
2209:         WITH loc_oCnt.txt_4c_Operacao
2210:             .Value     = ""
2211:             .Left      = 18
2212:             .Top       = 171
2213:             .Width     = 290
2214:             .Height    = 25
2215:             .ReadOnly  = .T.
2216:             .FontName  = "Tahoma"
2217:             .FontSize  = 8
2218:             .BackColor = RGB(240, 240, 240)
2219:         ENDWITH
2220: 
2221:         loc_oCnt.AddObject("cmd_4c_AdicionarNop", "CommandButton")
2222:         WITH loc_oCnt.cmd_4c_AdicionarNop
2223:             .Caption         = ""
2224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2225:             .PicturePosition = 4
2226:             .Top             = 172
2227:             .Left            = 384
2228:             .Width           = 40
2229:             .Height          = 40
2230:             .Themes          = .T.
2231:             .SpecialEffect   = 0
2232:             .MousePointer    = 15
2233:         ENDWITH
2234:         BINDEVENT(loc_oCnt.cmd_4c_AdicionarNop, "Click", THIS, "AdicionarNopClick")
2235: 
2236:         loc_oCnt.AddObject("lbl_4c_SayCopiar", "Label")
2237:         WITH loc_oCnt.lbl_4c_SayCopiar
2238:             .Caption   = "Copiar Tubo :"
2239:             .Left      = 5
2240:             .Top       = 232
2241:             .AutoSize  = .T.
2242:             .FontBold  = .T.
2243:             .BackStyle = 0
2244:             .ForeColor = RGB(36, 84, 155)
2245:         ENDWITH
2246: 
2247:         loc_oCnt.AddObject("txt_4c_Tubo", "TextBox")
2248:         WITH loc_oCnt.txt_4c_Tubo
2249:             .Value     = 0
2250:             .InputMask = "99"
2251:             .Left      = 89
2252:             .Top       = 230
2253:             .Width     = 21
2254:             .Height    = 20
2255:             .FontName  = "Tahoma"
2256:             .FontSize  = 8
2257:         ENDWITH
2258:         BINDEVENT(loc_oCnt.txt_4c_Tubo, "KeyPress", THIS, "TuboLostFocus")
2259: 
2260:         loc_oCnt.AddObject("chk_4c_ChkRep", "CheckBox")
2261:         WITH loc_oCnt.chk_4c_ChkRep
2262:             .Caption   = "Repetir nosTubos"
2263:             .Left      = 5
2264:             .Top       = 253
2265:             .Width     = 118
2266:             .Height    = 15
2267:             .Value     = 0
2268:             .FontName  = "Tahoma"
2269:             .FontSize  = 8
2270:             .BackStyle = 0
2271:         ENDWITH
2272: 
2273:         loc_oCnt.AddObject("lbl_4c_SayTrf", "Label")
2274:         WITH loc_oCnt.lbl_4c_SayTrf
2275:             .Caption   = "Transforma" + CHR(231) + CHR(245) + "es :"
2276:             .Left      = 5
2277:             .Top       = 275
2278:             .AutoSize  = .T.
2279:             .FontBold  = .T.
2280:             .BackStyle = 0
2281:             .ForeColor = RGB(36, 84, 155)
2282:         ENDWITH
2283: 
2284:         loc_oCnt.AddObject("txt_4c_Trf", "TextBox")
2285:         WITH loc_oCnt.txt_4c_Trf
2286:             .Value     = ""
2287:             .MaxLength = 20
2288:             .Left      = 108
2289:             .Top       = 273
2290:             .Width     = 80
2291:             .Height    = 20
2292:             .FontName  = "Tahoma"
2293:             .FontSize  = 8
2294:         ENDWITH
2295:         BINDEVENT(loc_oCnt.txt_4c_Trf, "KeyPress", THIS, "TrfLostFocus")
2296: 
2297:         loc_oCnt.AddObject("grd_4c_GradeTrf", "Grid")
2298:         loc_oCnt.grd_4c_GradeTrf.ColumnCount = 2
2299:         loc_oCnt.grd_4c_GradeTrf.RecordSource = "TmpTrf"
2300:         WITH loc_oCnt.grd_4c_GradeTrf
2301:             .Top          = 216
2302:             .Left         = 209
2303:             .Width        = 233
2304:             .Height       = 122
2305:             .FontName     = "Tahoma"
2306:             .FontSize     = 8
2307:             .ReadOnly     = .T.
2308:             .GridLines    = 1
2309:             .HeaderHeight = 17
2310:             .RowHeight    = 17
2311:             .RecordMark   = .F.
2312:             .DeleteMark   = .F.
2313:         ENDWITH
2314: 
2315:         WITH loc_oCnt.grd_4c_GradeTrf.Column1
2316:             .Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
2317:             .ControlSource   = "TmpTrf.Dopes"
2318:             .Width           = 155
2319:         ENDWITH
2320: 
2321:         WITH loc_oCnt.grd_4c_GradeTrf.Column2
2322:             .Header1.Caption = "Numes"
2323:             .ControlSource   = "TmpTrf.Numes"
2324:             .Width           = 55
2325:         ENDWITH
2326: 
2327:         loc_oCnt.AddObject("cmd_4c_RemoverTrf", "CommandButton")
2328:         WITH loc_oCnt.cmd_4c_RemoverTrf
2329:             .Caption         = ""
2330:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2331:             .PicturePosition = 4
2332:             .Top             = 297
2333:             .Left            = 165
2334:             .Width           = 40
2335:             .Height          = 40
2336:             .Themes          = .T.
2337:             .SpecialEffect   = 0
2338:             .MousePointer    = 15
2339:         ENDWITH
2340:         BINDEVENT(loc_oCnt.cmd_4c_RemoverTrf, "Click", THIS, "RemoverTrfClick")
2341:     ENDPROC
2342: 
2343:     *==========================================================================
2344:     PROTECTED PROCEDURE ConfigurarContainer4(par_oPagina)
2345:     *==========================================================================
2346:         LOCAL loc_oCnt
2347:         loc_oCnt = par_oPagina.cnt_4c_Container4
2348: 
2349:         loc_oCnt.AddObject("lbl_4c_ObsTubo", "Label")
2350:         WITH loc_oCnt.lbl_4c_ObsTubo
2351:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o do Tubo"
2352:             .Left      = 14
2353:             .Top       = 3
2354:             .AutoSize  = .T.
2355:             .FontBold  = .T.
2356:             .BackStyle = 0
2357:             .ForeColor = RGB(36, 84, 155)
2358:         ENDWITH
2359: 
2360:         loc_oCnt.AddObject("lbl_4c_SayTubo", "Label")
2361:         WITH loc_oCnt.lbl_4c_SayTubo
2362:             .Caption   = "( )"
2363:             .Left      = 148
2364:             .Top       = 3
2365:             .AutoSize  = .T.
2366:             .BackStyle = 0
2367:             .ForeColor = RGB(36, 84, 155)
2368:         ENDWITH
2369: 
2370:         loc_oCnt.AddObject("lbl_4c_ObsGeral", "Label")
2371:         WITH loc_oCnt.lbl_4c_ObsGeral
2372:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o Geral"
2373:             .Left      = 342
2374:             .Top       = 2
2375:             .AutoSize  = .T.
2376:             .FontBold  = .T.
2377:             .BackStyle = 0
2378:             .ForeColor = RGB(36, 84, 155)
2379:         ENDWITH
2380: 
2381:         loc_oCnt.AddObject("edt_4c_Obs", "EditBox")
2382:         WITH loc_oCnt.edt_4c_Obs
2383:             .Value      = ""
2384:             .Left       = 9
2385:             .Top        = 19
2386:             .Width      = 328
2387:             .Height     = 95
2388:             .FontName   = "Tahoma"
2389:             .FontSize   = 8
2390:             .ScrollBars = 2
2391:         ENDWITH
2392:         BINDEVENT(loc_oCnt.edt_4c_Obs, "LostFocus", THIS, "SalvarDadosTubo")
2393: 
2394:         loc_oCnt.AddObject("edt_4c_ObsG", "EditBox")
2395:         WITH loc_oCnt.edt_4c_ObsG
2396:             .Value      = ""
2397:             .Left       = 340
2398:             .Top        = 18
2399:             .Width      = 328
2400:             .Height     = 95
2401:             .FontName   = "Tahoma"
2402:             .FontSize   = 8
2403:             .ScrollBars = 2
2404:         ENDWITH
2405:     ENDPROC
2406: 
2407:     *==========================================================================
2408:     PROTECTED PROCEDURE ConfigurarContainer5(par_oPagina)
2409:     *==========================================================================
2410:         LOCAL loc_oCnt
2411:         loc_oCnt = par_oPagina.cnt_4c_Container5
2412: 
2413:         loc_oCnt.AddObject("lbl_4c_ConvTitle", "Label")
2414:         WITH loc_oCnt.lbl_4c_ConvTitle
2415:             .Caption   = "Convers" + CHR(227) + "o Cera/Metal"
2416:             .Left      = 4
2417:             .Top       = 2
2418:             .AutoSize  = .T.
2419:             .FontBold  = .T.
2420:             .BackStyle = 0
2421:             .ForeColor = RGB(36, 84, 155)
2422:         ENDWITH
2423: 
2424:         loc_oCnt.AddObject("lbl_4c_CorLabel", "Label")
2425:         WITH loc_oCnt.lbl_4c_CorLabel
2426:             .Caption   = "Cor"
2427:             .Left      = 5
2428:             .Top       = 19
2429:             .AutoSize  = .T.
2430:             .BackStyle = 0
2431:             .ForeColor = RGB(36, 84, 155)
2432:         ENDWITH
2433: 
2434:         loc_oCnt.AddObject("txt_4c_Cor", "TextBox")
2435:         WITH loc_oCnt.txt_4c_Cor
2436:             .Value     = ""
2437:             .MaxLength = 4
2438:             .Left      = 5
2439:             .Top       = 33
2440:             .Width     = 38
2441:             .Height    = 23
2442:             .FontName  = "Tahoma"
2443:             .FontSize  = 8
2444:         ENDWITH
2445:         BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress",  THIS, "CorKeyPress")
2446:         BINDEVENT(loc_oCnt.txt_4c_Cor, "DblClick",  THIS, "CorDblClick")
2447:         BINDEVENT(loc_oCnt.txt_4c_Cor, "KeyPress", THIS, "ValidarCor")
2448: 
2449:         loc_oCnt.AddObject("lbl_4c_BasecLabel", "Label")
2450:         WITH loc_oCnt.lbl_4c_BasecLabel
2451:             .Caption   = "Base Cera"
2452:             .Left      = 45
2453:             .Top       = 19
2454:             .AutoSize  = .T.
2455:             .BackStyle = 0
2456:             .ForeColor = RGB(36, 84, 155)
2457:         ENDWITH
2458: 
2459:         loc_oCnt.AddObject("txt_4c_Basec", "TextBox")
2460:         WITH loc_oCnt.txt_4c_Basec
2461:             .Value     = 0
2462:             .InputMask = "999999999.99"
2463:             .Left      = 44
2464:             .Top       = 33
2465:             .Width     = 100
2466:             .Height    = 23
2467:             .FontName  = "Tahoma"
2468:             .FontSize  = 8
2469:         ENDWITH
2470:         BINDEVENT(loc_oCnt.txt_4c_Basec, "KeyPress", THIS, "BasecLostFocus")
2471: 
2472:         loc_oCnt.AddObject("lbl_4c_BaseLabel", "Label")
2473:         WITH loc_oCnt.lbl_4c_BaseLabel
2474:             .Caption   = "Base"
2475:             .Left      = 145
2476:             .Top       = 20
2477:             .AutoSize  = .T.
2478:             .BackStyle = 0
2479:             .ForeColor = RGB(36, 84, 155)
2480:         ENDWITH
2481: 
2482:         loc_oCnt.AddObject("txt_4c_Base", "TextBox")
2483:         WITH loc_oCnt.txt_4c_Base
2484:             .Value     = 0
2485:             .InputMask = "999999999.99"
2486:             .Left      = 144
2487:             .Top       = 33
2488:             .Width     = 100
2489:             .Height    = 23
2490:             .FontName  = "Tahoma"
2491:             .FontSize  = 8
2492:         ENDWITH
2493:         BINDEVENT(loc_oCnt.txt_4c_Base, "KeyPress", THIS, "BaseLostFocus")
2494: 
2495:         loc_oCnt.AddObject("lbl_4c_CeraLabel", "Label")
2496:         WITH loc_oCnt.lbl_4c_CeraLabel
2497:             .Caption   = "Cera"
2498:             .Left      = 5
2499:             .Top       = 61
2500:             .AutoSize  = .T.
2501:             .BackStyle = 0
2502:             .ForeColor = RGB(36, 84, 155)
2503:         ENDWITH
2504: 
2505:         loc_oCnt.AddObject("txt_4c_Cera", "TextBox")
2506:         WITH loc_oCnt.txt_4c_Cera
2507:             .Value     = 0
2508:             .InputMask = "999999999.99"
2509:             .Left      = 5
2510:             .Top       = 74
2511:             .Width     = 83
2512:             .Height    = 23
2513:             .ReadOnly  = .T.
2514:             .FontName  = "Tahoma"
2515:             .FontSize  = 8
2516:             .BackColor = RGB(240, 240, 240)
2517:         ENDWITH
2518: 
2519:         loc_oCnt.AddObject("lbl_4c_PesoMetalLabel", "Label")
2520:         WITH loc_oCnt.lbl_4c_PesoMetalLabel
2521:             .Caption   = "Peso Metal"
2522:             .Left      = 88
2523:             .Top       = 61
2524:             .AutoSize  = .T.
2525:             .BackStyle = 0
2526:             .ForeColor = RGB(36, 84, 155)
2527:         ENDWITH
2528: 
2529:         loc_oCnt.AddObject("txt_4c_Metal", "TextBox")
2530:         WITH loc_oCnt.txt_4c_Metal
2531:             .Value     = 0
2532:             .InputMask = "999999999.99"
2533:             .Left      = 88

*-- Linhas 2561 a 2753:
2561:             .FontName  = "Tahoma"
2562:             .FontSize  = 8
2563:         ENDWITH
2564:         BINDEVENT(loc_oCnt.txt_4c_Mreal, "LostFocus", THIS, "SalvarDadosTubo")
2565: 
2566:         loc_oCnt.AddObject("lbl_4c_MetalNovoLabel", "Label")
2567:         WITH loc_oCnt.lbl_4c_MetalNovoLabel
2568:             .Caption   = "Metal Novo"
2569:             .Left      = 106
2570:             .Top       = 102
2571:             .AutoSize  = .T.
2572:             .BackStyle = 0
2573:             .ForeColor = RGB(36, 84, 155)
2574:         ENDWITH
2575: 
2576:         loc_oCnt.AddObject("txt_4c_metnovo", "TextBox")
2577:         WITH loc_oCnt.txt_4c_metnovo
2578:             .Value     = 0
2579:             .InputMask = "999999999.99"
2580:             .Left      = 106
2581:             .Top       = 115
2582:             .Width     = 100
2583:             .Height    = 23
2584:             .ReadOnly  = .T.
2585:             .FontName  = "Tahoma"
2586:             .FontSize  = 8
2587:             .BackColor = RGB(240, 240, 240)
2588:         ENDWITH
2589:     ENDPROC
2590: 
2591:     *==========================================================================
2592:     PROTECTED PROCEDURE ConfigurarContainer6(par_oPagina)
2593:     *==========================================================================
2594:         LOCAL loc_oCnt
2595:         loc_oCnt = par_oPagina.cnt_4c_Container6
2596: 
2597:         loc_oCnt.AddObject("lbl_4c_TempFundTitle", "Label")
2598:         WITH loc_oCnt.lbl_4c_TempFundTitle
2599:             .Caption   = "Temperatura Fundi" + CHR(231) + CHR(227) + "o"
2600:             .Left      = 5
2601:             .Top       = 2
2602:             .AutoSize  = .T.
2603:             .FontBold  = .T.
2604:             .BackStyle = 0
2605:             .ForeColor = RGB(36, 84, 155)
2606:         ENDWITH
2607: 
2608:         loc_oCnt.AddObject("lbl_4c_TempMetLabel", "Label")
2609:         WITH loc_oCnt.lbl_4c_TempMetLabel
2610:             .Caption   = "Metal"
2611:             .Left      = 5
2612:             .Top       = 20
2613:             .AutoSize  = .T.
2614:             .BackStyle = 0
2615:             .ForeColor = RGB(36, 84, 155)
2616:         ENDWITH
2617: 
2618:         loc_oCnt.AddObject("txt_4c_TempMet", "TextBox")
2619:         WITH loc_oCnt.txt_4c_TempMet
2620:             .Value     = ""
2621:             .MaxLength = 15
2622:             .Left      = 5
2623:             .Top       = 36
2624:             .Width     = 115
2625:             .Height    = 23
2626:             .FontName  = "Tahoma"
2627:             .FontSize  = 8
2628:         ENDWITH
2629:         BINDEVENT(loc_oCnt.txt_4c_TempMet, "LostFocus", THIS, "SalvarDadosTubo")
2630: 
2631:         loc_oCnt.AddObject("lbl_4c_TempTubLabel", "Label")
2632:         WITH loc_oCnt.lbl_4c_TempTubLabel
2633:             .Caption   = "Tubo"
2634:             .Left      = 123
2635:             .Top       = 20
2636:             .AutoSize  = .T.
2637:             .BackStyle = 0
2638:             .ForeColor = RGB(36, 84, 155)
2639:         ENDWITH
2640: 
2641:         loc_oCnt.AddObject("txt_4c_TempTub", "TextBox")
2642:         WITH loc_oCnt.txt_4c_TempTub
2643:             .Value     = ""
2644:             .MaxLength = 15
2645:             .Left      = 123
2646:             .Top       = 36
2647:             .Width     = 115
2648:             .Height    = 23
2649:             .FontName  = "Tahoma"
2650:             .FontSize  = 8
2651:         ENDWITH
2652:         BINDEVENT(loc_oCnt.txt_4c_TempTub, "LostFocus", THIS, "SalvarDadosTubo")
2653: 
2654:         loc_oCnt.AddObject("lbl_4c_TempRevTitle", "Label")
2655:         WITH loc_oCnt.lbl_4c_TempRevTitle
2656:             .Caption   = "Temperatura Revestimento"
2657:             .Left      = 4
2658:             .Top       = 61
2659:             .AutoSize  = .T.
2660:             .FontBold  = .T.
2661:             .BackStyle = 0
2662:             .ForeColor = RGB(36, 84, 155)
2663:         ENDWITH
2664: 
2665:         loc_oCnt.AddObject("lbl_4c_TempAmbLabel", "Label")
2666:         WITH loc_oCnt.lbl_4c_TempAmbLabel
2667:             .Caption   = "Ambiente"
2668:             .Left      = 5
2669:             .Top       = 77
2670:             .AutoSize  = .T.
2671:             .BackStyle = 0
2672:             .ForeColor = RGB(36, 84, 155)
2673:         ENDWITH
2674: 
2675:         loc_oCnt.AddObject("txt_4c_TempAmb", "TextBox")
2676:         WITH loc_oCnt.txt_4c_TempAmb
2677:             .Value     = ""
2678:             .MaxLength = 15
2679:             .Left      = 5
2680:             .Top       = 93
2681:             .Width     = 115
2682:             .Height    = 23
2683:             .FontName  = "Tahoma"
2684:             .FontSize  = 8
2685:         ENDWITH
2686:         BINDEVENT(loc_oCnt.txt_4c_TempAmb, "LostFocus", THIS, "SalvarDadosTubo")
2687: 
2688:         loc_oCnt.AddObject("lbl_4c_TempAguLabel", "Label")
2689:         WITH loc_oCnt.lbl_4c_TempAguLabel
2690:             .Caption   = CHR(193) + "gua"
2691:             .Left      = 123
2692:             .Top       = 77
2693:             .AutoSize  = .T.
2694:             .BackStyle = 0
2695:             .ForeColor = RGB(36, 84, 155)
2696:         ENDWITH
2697: 
2698:         loc_oCnt.AddObject("txt_4c_TempAgu", "TextBox")
2699:         WITH loc_oCnt.txt_4c_TempAgu
2700:             .Value     = ""
2701:             .MaxLength = 15
2702:             .Left      = 123
2703:             .Top       = 93
2704:             .Width     = 115
2705:             .Height    = 23
2706:             .FontName  = "Tahoma"
2707:             .FontSize  = 8
2708:         ENDWITH
2709:         BINDEVENT(loc_oCnt.txt_4c_TempAgu, "LostFocus", THIS, "SalvarDadosTubo")
2710:     ENDPROC
2711: 
2712:     *==========================================================================
2713:     PROTECTED PROCEDURE ConfigurarCntTotal(par_oPagina)
2714:     *==========================================================================
2715:         LOCAL loc_oCnt
2716:         loc_oCnt = par_oPagina.cnt_4c_Total
2717: 
2718:         loc_oCnt.AddObject("lbl_4c_TotalMetal", "Label")
2719:         WITH loc_oCnt.lbl_4c_TotalMetal
2720:             .Caption   = "Total de Metal"
2721:             .Left      = 6
2722:             .Top       = 5
2723:             .AutoSize  = .T.
2724:             .FontBold  = .T.
2725:             .BackStyle = 0
2726:             .ForeColor = RGB(36, 84, 155)
2727:         ENDWITH
2728: 
2729:         loc_oCnt.AddObject("grd_4c_TmpTot", "Grid")
2730:         loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
2731:         WITH loc_oCnt.grd_4c_TmpTot
2732:             .Top                     = 49
2733:             .Left                    = 28
2734:             .Width                   = 354
2735:             .Height                  = 122
2736:             .FontName                = "Tahoma"
2737:             .FontSize                = 8
2738:             .ReadOnly                = .T.
2739:             .GridLines               = 1
2740:             .HeaderHeight            = 17
2741:             .RowHeight               = 17
2742:             .Column1.Header1.Caption = "Tipo " + CHR(193) + "rvore"
2743:             .Column1.Width           = 80
2744:             .Column2.Header1.Caption = "Metal Real"
2745:             .Column2.Width           = 80
2746:             .Column3.Header1.Caption = "Metal Novo"
2747:             .Column3.Width           = 80
2748:             .Column4.Header1.Caption = "Metal Ligado"
2749:             .Column4.Width           = 80
2750:             .RecordMark   = .F.
2751:             .DeleteMark   = .F.
2752:         ENDWITH
2753: 

*-- Linhas 2772 a 3191:
2772:             .WordWrap        = .T.
2773:             .AutoSize        = .F.
2774:         ENDWITH
2775:         BINDEVENT(loc_oCnt.cmd_4c_Retornar, "Click", THIS, "BtnCancelarTotalClick")
2776:     ENDPROC
2777: 
2778:     *==========================================================================
2779:     PROTECTED PROCEDURE ConfigurarCamposPage2(par_oPagina)
2780:     *==========================================================================
2781:         *-- lbl_4c_TipoArvoreLabel: Say4 top=98+29=127, left=327
2782:         par_oPagina.AddObject("lbl_4c_TipoArvoreLabel", "Label")
2783:         WITH par_oPagina.lbl_4c_TipoArvoreLabel
2784:             .Caption   = "Tipo " + CHR(193) + "rvore :"
2785:             .Left      = 327
2786:             .Top       = 127
2787:             .AutoSize  = .T.
2788:             .FontBold  = .T.
2789:             .BackStyle = 0
2790:             .ForeColor = RGB(36, 84, 155)
2791:         ENDWITH
2792: 
2793:         *-- txt_4c_codarvore: top=93+29=122, left=416
2794:         par_oPagina.AddObject("txt_4c_codarvore", "TextBox")
2795:         WITH par_oPagina.txt_4c_codarvore
2796:             .Value     = ""
2797:             .MaxLength = 10
2798:             .Left      = 416
2799:             .Top       = 122
2800:             .Width     = 79
2801:             .Height    = 25
2802:             .FontName  = "Tahoma"
2803:             .FontSize  = 8
2804:         ENDWITH
2805:         BINDEVENT(par_oPagina.txt_4c_codarvore, "KeyPress",  THIS, "ArvoreKeyPress")
2806:         BINDEVENT(par_oPagina.txt_4c_codarvore, "DblClick",  THIS, "ArvoreDblClick")
2807:         BINDEVENT(par_oPagina.txt_4c_codarvore, "KeyPress", THIS, "ValidarArvore")
2808: 
2809:         *-- txt_4c_descarvore: top=93+29=122, left=497
2810:         par_oPagina.AddObject("txt_4c_descarvore", "TextBox")
2811:         WITH par_oPagina.txt_4c_descarvore
2812:             .Value     = ""
2813:             .MaxLength = 40
2814:             .Left      = 497
2815:             .Top       = 122
2816:             .Width     = 200
2817:             .Height    = 25
2818:             .ReadOnly  = .T.
2819:             .FontName  = "Tahoma"
2820:             .FontSize  = 8
2821:             .BackColor = RGB(240, 240, 240)
2822:         ENDWITH
2823:         BINDEVENT(par_oPagina.txt_4c_descarvore, "KeyPress", THIS, "ArvoreDescKeyPress")
2824:         BINDEVENT(par_oPagina.txt_4c_descarvore, "DblClick", THIS, "ArvoreDescDblClick")
2825: 
2826:         *-- cmd_4c_BtnTotal: top=12+29=41, left=718
2827:         par_oPagina.AddObject("cmd_4c_BtnTotal", "CommandButton")
2828:         WITH par_oPagina.cmd_4c_BtnTotal
2829:             .Caption         = "Total Metal"
2830:             .Picture         = gc_4c_CaminhoIcones + "geral_arvore_ouro_60.jpg"
2831:             .PicturePosition = 13
2832:             .Top             = 41
2833:             .Left            = 718
2834:             .Width           = 80
2835:             .Height          = 100
2836:             .FontName        = "Tahoma"
2837:             .FontBold        = .T.
2838:             .FontItalic      = .T.
2839:             .FontSize        = 8
2840:             .ForeColor       = RGB(90, 90, 90)
2841:             .BackColor       = RGB(255, 255, 255)
2842:             .Themes          = .F.
2843:             .SpecialEffect   = 0
2844:             .MousePointer    = 15
2845:             .WordWrap        = .T.
2846:             .AutoSize        = .F.
2847:         ENDWITH
2848:         BINDEVENT(par_oPagina.cmd_4c_BtnTotal, "Click", THIS, "BtnTotalClick")
2849:     ENDPROC
2850: 
2851:     *==========================================================================
2852:     PROCEDURE SalvarDadosTubo()
2853:     *==========================================================================
2854:         LOCAL loc_oCnt4, loc_oCnt5, loc_oCnt6, loc_lSucesso
2855:         loc_lSucesso = .F.
2856: 
2857:         TRY
2858:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2859:                 SELECT TmpCera
2860:                 SET ORDER TO Tubos
2861:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
2862:                     loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
2863:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2864:                     loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
2865: 
2866:                     IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
2867:                         REPLACE Obss WITH loc_oCnt4.edt_4c_Obs.Value IN TmpCera
2868:                     ENDIF
2869:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Mreal", 5)
2870:                         REPLACE pmetalrs WITH NVL(loc_oCnt5.txt_4c_Mreal.Value, 0) IN TmpCera
2871:                     ENDIF
2872:                     IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
2873:                         REPLACE TempMets WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempMet.Value, "")) IN TmpCera
2874:                         REPLACE TempTubs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempTub.Value, "")) IN TmpCera
2875:                         REPLACE TempAmbs WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempAmb.Value, "")) IN TmpCera
2876:                         REPLACE TempAgus WITH ALLTRIM(NVL(loc_oCnt6.txt_4c_TempAgu.Value, "")) IN TmpCera
2877:                     ENDIF
2878:                     loc_lSucesso = .T.
2879:                 ENDIF
2880:             ENDIF
2881:         CATCH TO loc_oErro
2882:             MsgErro("Erro em FormFUN.SalvarDadosTubo: " + loc_oErro.Message, "Erro")
2883:         ENDTRY
2884: 
2885:         RETURN loc_lSucesso
2886:     ENDPROC
2887: 
2888:     *==========================================================================
2889:     PROCEDURE CorKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2890:     *==========================================================================
2891:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2892:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2893:             THIS.AbrirLookupCor()
2894:         ENDIF
2895:     ENDPROC
2896: 
2897:     *==========================================================================
2898:     PROCEDURE CorDblClick()
2899:     *==========================================================================
2900:         THIS.AbrirLookupCor()
2901:     ENDPROC
2902: 
2903:     *==========================================================================
2904:     PROCEDURE AbrirLookupCor()
2905:     *==========================================================================
2906:         LOCAL loc_oCnt5, loc_cAtual, loc_oBusca
2907: 
2908:         TRY
2909:             loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2910:             loc_cAtual = ALLTRIM(NVL(loc_oCnt5.txt_4c_Cor.Value, ""))
2911: 
2912:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
2913:                 "SigCdCor", ;
2914:                 "cgrus", ;
2915:                 loc_cAtual, ;
2916:                 loc_oCnt5.txt_4c_Cor, ;
2917:                 "Selecionar Cor", ;
2918:                 .T., .T., "")
2919:             IF VARTYPE(loc_oBusca) = "O"
2920:                 loc_oBusca.mAddColuna("cgrus", "9999", "C" + CHR(243) + "digo")
2921:                 loc_oBusca.mAddColuna("descs", "X(30)", "Descri" + CHR(231) + CHR(227) + "o")
2922:                 loc_oBusca.Show()
2923:                 THIS.ValidarCor()
2924:             ENDIF
2925:         CATCH TO loc_oErro
2926:             MsgErro("Erro em FormFUN.AbrirLookupCor: " + loc_oErro.Message, "Erro")
2927:         ENDTRY
2928:     ENDPROC
2929: 
2930:     *==========================================================================
2931:     PROCEDURE ValidarCor(par_nKeyCode, par_nShiftAltCtrl)
2932:     *==========================================================================
2933:         LOCAL loc_oCnt5, loc_cCodCor, loc_nResultado, loc_lSucesso
2934:         loc_lSucesso = .F.
2935: 
2936:         TRY
2937:             loc_oCnt5   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
2938:             loc_cCodCor = ALLTRIM(NVL(loc_oCnt5.txt_4c_Cor.Value, ""))
2939: 
2940:             IF EMPTY(loc_cCodCor)
2941:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2942:                     SELECT TmpCera
2943:                     SET ORDER TO Tubos
2944:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
2945:                         REPLACE CodCors WITH "" IN TmpCera
2946:                     ENDIF
2947:                 ENDIF
2948:                 loc_lSucesso = .T.
2949:             ELSE
2950:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
2951:                     "SELECT c.cods FROM SigCdCor c WHERE c.cods = " + ;
2952:                     EscaparSQL(loc_cCodCor), ;
2953:                     "cursor_4c_BuscaCor")
2954: 
2955:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaCor") AND ;
2956:                         RECCOUNT("cursor_4c_BuscaCor") > 0
2957:                     IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
2958:                         SELECT TmpCera
2959:                         SET ORDER TO Tubos
2960:                         IF SEEK(STR(THIS.this_nTuboAtual, 2))
2961:                             REPLACE CodCors WITH loc_cCodCor IN TmpCera
2962:                         ENDIF
2963:                     ENDIF
2964:                     loc_lSucesso = .T.
2965:                 ELSE
2966:                     MsgAviso("Cor '" + loc_cCodCor + "' n" + CHR(227) + "o encontrada.", "Cor")
2967:                     loc_oCnt5.txt_4c_Cor.Value = ""
2968:                 ENDIF
2969: 
2970:                 IF USED("cursor_4c_BuscaCor")
2971:                     USE IN cursor_4c_BuscaCor
2972:                 ENDIF
2973:             ENDIF
2974:         CATCH TO loc_oErro
2975:             MsgErro("Erro em FormFUN.ValidarCor: " + loc_oErro.Message, "Erro")
2976:         ENDTRY
2977: 
2978:         RETURN loc_lSucesso
2979:     ENDPROC
2980: 
2981:     *==========================================================================
2982:     PROCEDURE ArvoreKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2983:     *==========================================================================
2984:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
2985:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
2986:             THIS.AbrirLookupArvore()
2987:         ENDIF
2988:     ENDPROC
2989: 
2990:     *==========================================================================
2991:     PROCEDURE ArvoreDblClick()
2992:     *==========================================================================
2993:         THIS.AbrirLookupArvore()
2994:     ENDPROC
2995: 
2996:     *==========================================================================
2997:     PROCEDURE AbrirLookupArvore()
2998:     *==========================================================================
2999:         LOCAL loc_oPg2, loc_cAtual, loc_oBusca
3000: 
3001:         TRY
3002:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3003:             loc_cAtual = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
3004: 
3005:             IF !USED("cursor_4c_Arvores")
3006:                 THIS.CarregarArvores()
3007:             ENDIF
3008: 
3009:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
3010:                 "cursor_4c_Arvores", ;
3011:                 "codigos", ;
3012:                 loc_cAtual, ;
3013:                 loc_oPg2.txt_4c_codarvore, ;
3014:                 "Selecionar " + CHR(193) + "rvore", ;
3015:                 .T., .T., "")
3016:             IF VARTYPE(loc_oBusca) = "O"
3017:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
3018:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
3019:                 loc_oBusca.Show()
3020:                 THIS.ValidarArvore()
3021:             ENDIF
3022:         CATCH TO loc_oErro
3023:             MsgErro("Erro em FormFUN.AbrirLookupArvore: " + loc_oErro.Message, "Erro")
3024:         ENDTRY
3025:     ENDPROC
3026: 
3027:     *==========================================================================
3028:     PROCEDURE ValidarArvore(par_nKeyCode, par_nShiftAltCtrl)
3029:     *==========================================================================
3030:         LOCAL loc_oPg2, loc_cCodArv, loc_cDescs, loc_lSucesso
3031:         loc_lSucesso = .F.
3032: 
3033:         TRY
3034:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
3035:             loc_cCodArv = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
3036: 
3037:             IF EMPTY(loc_cCodArv)
3038:                 IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3039:                     loc_oPg2.txt_4c_descarvore.Value = ""
3040:                 ENDIF
3041:                 IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3042:                     SELECT TmpCera
3043:                     SET ORDER TO Tubos
3044:                     IF SEEK(STR(THIS.this_nTuboAtual, 2))
3045:                         REPLACE CodArvs WITH "", Descs WITH "" IN TmpCera
3046:                     ENDIF
3047:                 ENDIF
3048:                 loc_lSucesso = .T.
3049:             ELSE
3050:                 IF !USED("cursor_4c_Arvores")
3051:                     THIS.CarregarArvores()
3052:                 ENDIF
3053: 
3054:                 IF USED("cursor_4c_Arvores")
3055:                     SELECT cursor_4c_Arvores
3056:                     LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3057:                     IF FOUND()
3058:                         loc_cDescs = ALLTRIM(NVL(cursor_4c_Arvores.descs, ""))
3059:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3060:                             loc_oPg2.txt_4c_descarvore.Value = loc_cDescs
3061:                         ENDIF
3062:                         IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3063:                             SELECT TmpCera
3064:                             SET ORDER TO Tubos
3065:                             IF SEEK(STR(THIS.this_nTuboAtual, 2))
3066:                                 REPLACE CodArvs WITH loc_cCodArv, Descs WITH loc_cDescs IN TmpCera
3067:                             ENDIF
3068:                         ENDIF
3069:                         THIS.CalcMetal()
3070:                         loc_lSucesso = .T.
3071:                     ELSE
3072:                         MsgAviso(CHR(193) + "rvore '" + loc_cCodArv + ;
3073:                             "' n" + CHR(227) + "o encontrada.", CHR(193) + "rvore")
3074:                         loc_oPg2.txt_4c_codarvore.Value  = ""
3075:                         IF PEMSTATUS(loc_oPg2, "txt_4c_descarvore", 5)
3076:                             loc_oPg2.txt_4c_descarvore.Value = ""
3077:                         ENDIF
3078:                     ENDIF
3079:                 ENDIF
3080:             ENDIF
3081:         CATCH TO loc_oErro
3082:             MsgErro("Erro em FormFUN.ValidarArvore: " + loc_oErro.Message, "Erro")
3083:         ENDTRY
3084: 
3085:         RETURN loc_lSucesso
3086:     ENDPROC
3087: 
3088:     *==========================================================================
3089:     PROCEDURE ArvoreDescKeyPress(par_nKeyCode, par_nShiftAltCtrl)
3090:     *==========================================================================
3091:         LPARAMETERS par_nKeyCode, par_nShiftAltCtrl
3092:         IF par_nKeyCode = 13 OR par_nKeyCode = 9 OR par_nKeyCode = 115
3093:             THIS.AbrirLookupArvoreDesc()
3094:         ENDIF
3095:     ENDPROC
3096: 
3097:     *==========================================================================
3098:     PROCEDURE ArvoreDescDblClick()
3099:     *==========================================================================
3100:         THIS.AbrirLookupArvoreDesc()
3101:     ENDPROC
3102: 
3103:     *==========================================================================
3104:     PROCEDURE AbrirLookupArvoreDesc()
3105:     *==========================================================================
3106:         LOCAL loc_oPg2, loc_cAtual, loc_oBusca
3107: 
3108:         TRY
3109:             loc_oPg2   = THIS.pgf_4c_Paginas.Page2
3110:             loc_cAtual = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
3111: 
3112:             IF !USED("cursor_4c_Arvores")
3113:                 THIS.CarregarArvores()
3114:             ENDIF
3115: 
3116:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", ;
3117:                 "cursor_4c_Arvores", ;
3118:                 "codigos", ;
3119:                 loc_cAtual, ;
3120:                 loc_oPg2.txt_4c_codarvore, ;
3121:                 "Selecionar " + CHR(193) + "rvore", ;
3122:                 .T., .T., "")
3123:             IF VARTYPE(loc_oBusca) = "O"
3124:                 loc_oBusca.mAddColuna("codigos", "X(10)", "C" + CHR(243) + "digo")
3125:                 loc_oBusca.mAddColuna("descs",   "X(40)", "Descri" + CHR(231) + CHR(227) + "o")
3126:                 loc_oBusca.Show()
3127:                 THIS.ValidarArvore()
3128:             ENDIF
3129:         CATCH TO loc_oErro
3130:             MsgErro("Erro em FormFUN.AbrirLookupArvoreDesc: " + loc_oErro.Message, "Erro")
3131:         ENDTRY
3132:     ENDPROC
3133: 
3134:     *==========================================================================
3135:     PROCEDURE CalcMetal()
3136:     *==========================================================================
3137:         LOCAL loc_oCnt5, loc_oPg2, loc_cCodArv, loc_cFormula
3138:         LOCAL loc_nBCeras, loc_nBases, loc_nCeras, loc_nPesoMetal, loc_nMetalNovo, loc_nPercs
3139:         LOCAL loc_lSucesso
3140:         loc_lSucesso = .F.
3141: 
3142:         TRY
3143:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3144:                 SELECT TmpCera
3145:                 SET ORDER TO Tubos
3146:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3147:                     loc_nBCeras = NVL(TmpCera.BCeras, 0)
3148:                     loc_nBases  = NVL(TmpCera.Bases, 0)
3149: 
3150:                     IF loc_nBCeras > 0 AND loc_nBases > 0 AND loc_nBCeras < loc_nBases
3151:                         MsgAviso("Base com Cera n" + CHR(227) + "o pode ser menor que a Base.", "Aviso")
3152:                         REPLACE Bases WITH 0 IN TmpCera
3153:                         loc_nBases = 0
3154:                     ENDIF
3155: 
3156:                     loc_nCeras = loc_nBCeras - loc_nBases
3157:                     REPLACE Ceras WITH loc_nCeras IN TmpCera
3158: 
3159:                     loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3160:                     IF PEMSTATUS(loc_oCnt5, "txt_4c_Cera", 5)
3161:                         loc_oCnt5.txt_4c_Cera.Value = loc_nCeras
3162:                     ENDIF
3163: 
3164:                     loc_oPg2    = THIS.pgf_4c_Paginas.Page2
3165:                     loc_cCodArv = ""
3166:                     IF PEMSTATUS(loc_oPg2, "txt_4c_codarvore", 5)
3167:                         loc_cCodArv = ALLTRIM(NVL(loc_oPg2.txt_4c_codarvore.Value, ""))
3168:                     ENDIF
3169: 
3170:                     loc_nPesoMetal = 0
3171:                     loc_nMetalNovo = 0
3172:                     loc_nPercs     = 0
3173: 
3174:                     IF !EMPTY(loc_cCodArv) AND USED("cursor_4c_Arvores")
3175:                         SELECT cursor_4c_Arvores
3176:                         LOCATE FOR ALLTRIM(cursor_4c_Arvores.codigos) = loc_cCodArv
3177:                         IF FOUND()
3178:                             loc_cFormula = ALLTRIM(NVL(cursor_4c_Arvores.formulas, ""))
3179:                             loc_nPercs   = NVL(cursor_4c_Arvores.percs, 0)
3180:                             IF !EMPTY(loc_cFormula)
3181:                                 SELECT TmpCera
3182:                                 TRY
3183:                                     loc_nPesoMetal = EVALUATE(loc_cFormula)
3184:                                 CATCH
3185:                                     loc_nPesoMetal = 0
3186:                                 ENDTRY
3187:                                 loc_nMetalNovo = (loc_nPesoMetal * loc_nPercs) / 100
3188:                             ENDIF
3189:                         ENDIF
3190:                     ENDIF
3191: 

*-- Linhas 3213 a 3466:
3213:     ENDPROC
3214: 
3215:     *==========================================================================
3216:     PROCEDURE BasecLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3217:     *==========================================================================
3218:         LOCAL loc_oCnt5, loc_nBCeras, loc_lSucesso
3219:         loc_lSucesso = .F.
3220: 
3221:         TRY
3222:             loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3223:             loc_nBCeras = NVL(loc_oCnt5.txt_4c_Basec.Value, 0)
3224: 
3225:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3226:                 SELECT TmpCera
3227:                 SET ORDER TO Tubos
3228:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3229:                     REPLACE BCeras WITH loc_nBCeras IN TmpCera
3230:                 ENDIF
3231:             ENDIF
3232: 
3233:             THIS.CalcMetal()
3234:             loc_lSucesso = .T.
3235:         CATCH TO loc_oErro
3236:             MsgErro("Erro em FormFUN.BasecLostFocus: " + loc_oErro.Message, "Erro")
3237:         ENDTRY
3238: 
3239:         RETURN loc_lSucesso
3240:     ENDPROC
3241: 
3242:     *==========================================================================
3243:     PROCEDURE BaseLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3244:     *==========================================================================
3245:         LOCAL loc_oCnt5, loc_nBases, loc_lSucesso
3246:         loc_lSucesso = .F.
3247: 
3248:         TRY
3249:             loc_oCnt5  = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3250:             loc_nBases = NVL(loc_oCnt5.txt_4c_Base.Value, 0)
3251: 
3252:             IF USED("TmpCera") AND THIS.this_nTuboAtual > 0
3253:                 SELECT TmpCera
3254:                 SET ORDER TO Tubos
3255:                 IF SEEK(STR(THIS.this_nTuboAtual, 2))
3256:                     REPLACE Bases WITH loc_nBases IN TmpCera
3257:                 ENDIF
3258:             ENDIF
3259: 
3260:             THIS.CalcMetal()
3261:             loc_lSucesso = .T.
3262:         CATCH TO loc_oErro
3263:             MsgErro("Erro em FormFUN.BaseLostFocus: " + loc_oErro.Message, "Erro")
3264:         ENDTRY
3265: 
3266:         RETURN loc_lSucesso
3267:     ENDPROC
3268: 
3269:     *==========================================================================
3270:     PROCEDURE EmpresaLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3271:     *==========================================================================
3272:         LOCAL loc_cEmps, loc_lSucesso
3273:         loc_lSucesso = .F.
3274: 
3275:         TRY
3276:             loc_cEmps = ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_CdEmpresa.Value, ""))
3277:             IF loc_cEmps != THIS.this_cAntEmpr
3278:                 THIS.this_cAntEmpr = loc_cEmps
3279:                 THIS.CarregarLista()
3280:             ENDIF
3281:             loc_lSucesso = .T.
3282:         CATCH TO loc_oErro
3283:             MsgErro("Erro em FormFUN.EmpresaLostFocus: " + loc_oErro.Message, "Erro")
3284:         ENDTRY
3285: 
3286:         RETURN loc_lSucesso
3287:     ENDPROC
3288: 
3289:     *==========================================================================
3290:     PROCEDURE DtInicialLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3291:     *==========================================================================
3292:         LOCAL loc_dDtIni, loc_lSucesso
3293:         loc_lSucesso = .F.
3294: 
3295:         TRY
3296:             loc_dDtIni = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtInicial.Value
3297:             IF loc_dDtIni != THIS.this_dAntDtI
3298:                 THIS.this_dAntDtI = loc_dDtIni
3299:                 THIS.CarregarLista()
3300:             ENDIF
3301:             loc_lSucesso = .T.
3302:         CATCH TO loc_oErro
3303:             MsgErro("Erro em FormFUN.DtInicialLostFocus: " + loc_oErro.Message, "Erro")
3304:         ENDTRY
3305: 
3306:         RETURN loc_lSucesso
3307:     ENDPROC
3308: 
3309:     *==========================================================================
3310:     PROCEDURE DtFinalLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3311:     *==========================================================================
3312:         LOCAL loc_dDtFim, loc_lSucesso
3313:         loc_lSucesso = .F.
3314: 
3315:         TRY
3316:             loc_dDtFim = THIS.pgf_4c_Paginas.Page1.cnt_4c_Periodo.txt_4c_DtFinal.Value
3317:             IF loc_dDtFim != THIS.this_dAntDtF
3318:                 THIS.this_dAntDtF = loc_dDtFim
3319:                 THIS.CarregarLista()
3320:             ENDIF
3321:             loc_lSucesso = .T.
3322:         CATCH TO loc_oErro
3323:             MsgErro("Erro em FormFUN.DtFinalLostFocus: " + loc_oErro.Message, "Erro")
3324:         ENDTRY
3325: 
3326:         RETURN loc_lSucesso
3327:     ENDPROC
3328: 
3329:     *==========================================================================
3330:     PROCEDURE NopLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3331:     *==========================================================================
3332:         LOCAL loc_oCnt3, loc_nNop, loc_nResultado, loc_lSucesso
3333:         loc_lSucesso = .F.
3334: 
3335:         TRY
3336:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3337:             loc_nNop  = NVL(loc_oCnt3.txt_4c_Nop.Value, 0)
3338: 
3339:             IF loc_nNop <= 0
3340:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3341:                     loc_oCnt3.txt_4c_Qtd.Value = 0
3342:                 ENDIF
3343:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3344:                     loc_oCnt3.txt_4c_Pecas.Value = 0
3345:                 ENDIF
3346:                 IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3347:                     loc_oCnt3.txt_4c_Operacao.Value = ""
3348:                 ENDIF
3349:                 loc_lSucesso = .T.
3350:             ELSE
3351:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3352:                     "SELECT o.nops, o.cpros, o.qtds, o.numes, o.dtents" + ;
3353:                     " FROM SigOpPic o" + ;
3354:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3355:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3356:                     "cursor_4c_BuscaNop")
3357: 
3358:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaNop") AND ;
3359:                         RECCOUNT("cursor_4c_BuscaNop") > 0
3360:                     SELECT cursor_4c_BuscaNop
3361:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3362:                         loc_oCnt3.txt_4c_Qtd.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3363:                     ENDIF
3364:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3365:                         loc_oCnt3.txt_4c_Pecas.Value = NVL(cursor_4c_BuscaNop.qtds, 0)
3366:                     ENDIF
3367:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3368:                         loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(cursor_4c_BuscaNop.cpros, ""))
3369:                     ENDIF
3370:                     loc_lSucesso = .T.
3371:                 ELSE
3372:                     MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
3373:                         " n" + CHR(227) + "o encontrada.", "O.P.")
3374:                     loc_oCnt3.txt_4c_Nop.Value = 0
3375:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3376:                         loc_oCnt3.txt_4c_Qtd.Value = 0
3377:                     ENDIF
3378:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Pecas", 5)
3379:                         loc_oCnt3.txt_4c_Pecas.Value = 0
3380:                     ENDIF
3381:                     IF PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3382:                         loc_oCnt3.txt_4c_Operacao.Value = ""
3383:                     ENDIF
3384:                 ENDIF
3385: 
3386:                 IF USED("cursor_4c_BuscaNop")
3387:                     USE IN cursor_4c_BuscaNop
3388:                 ENDIF
3389:             ENDIF
3390:         CATCH TO loc_oErro
3391:             MsgErro("Erro em FormFUN.NopLostFocus: " + loc_oErro.Message, "Erro")
3392:         ENDTRY
3393: 
3394:         RETURN loc_lSucesso
3395:     ENDPROC
3396: 
3397:     *==========================================================================
3398:     PROCEDURE QtTbLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3399:     *==========================================================================
3400:         LOCAL loc_oCnt3, loc_nQtTb, loc_nMaxQtd, loc_lSucesso
3401:         loc_lSucesso = .F.
3402: 
3403:         TRY
3404:             loc_oCnt3   = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3405:             loc_nQtTb   = NVL(loc_oCnt3.txt_4c_QtTb.Value, 0)
3406:             loc_nMaxQtd = 0
3407:             IF PEMSTATUS(loc_oCnt3, "txt_4c_Qtd", 5)
3408:                 loc_nMaxQtd = NVL(loc_oCnt3.txt_4c_Qtd.Value, 0)
3409:             ENDIF
3410: 
3411:             IF loc_nMaxQtd > 0 AND loc_nQtTb > loc_nMaxQtd
3412:                 MsgAviso("Quantidade solicitada (" + TRANSFORM(loc_nQtTb) + ;
3413:                     ") excede quantidade dispon" + CHR(237) + "vel (" + ;
3414:                     TRANSFORM(loc_nMaxQtd) + ").", "Quantidade")
3415:                 loc_oCnt3.txt_4c_QtTb.Value = loc_nMaxQtd
3416:             ENDIF
3417:             loc_lSucesso = .T.
3418:         CATCH TO loc_oErro
3419:             MsgErro("Erro em FormFUN.QtTbLostFocus: " + loc_oErro.Message, "Erro")
3420:         ENDTRY
3421: 
3422:         RETURN loc_lSucesso
3423:     ENDPROC
3424: 
3425:     *==========================================================================
3426:     PROCEDURE TuboLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3427:     *==========================================================================
3428:         LOCAL loc_oCnt3, loc_nTuboFonte, loc_nTuboAtual
3429:         LOCAL loc_nTotal, loc_nI, loc_cDopes, loc_nNumes, loc_nNNumes
3430:         LOCAL loc_lSucesso
3431:         LOCAL ARRAY loc_aTrfs[1, 3]
3432:         loc_lSucesso = .F.
3433:         loc_nTotal   = 0
3434: 
3435:         TRY
3436:             loc_oCnt3      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3437:             loc_nTuboFonte = NVL(loc_oCnt3.txt_4c_Tubo.Value, 0)
3438:             loc_nTuboAtual = THIS.this_nTuboAtual
3439: 
3440:             IF loc_nTuboFonte > 0 AND loc_nTuboAtual > 0 AND ;
3441:                     loc_nTuboFonte != loc_nTuboAtual AND USED("TmpTrf")
3442:                 *-- Coletar registros do tubo fonte
3443:                 SELECT TmpTrf
3444:                 SET ORDER TO 0
3445:                 GO TOP
3446:                 DO WHILE !EOF("TmpTrf")
3447:                     IF TmpTrf.Tubos = loc_nTuboFonte
3448:                         loc_nTotal = loc_nTotal + 1
3449:                         DIMENSION loc_aTrfs[loc_nTotal, 3]
3450:                         loc_aTrfs[loc_nTotal, 1] = TmpTrf.Dopes
3451:                         loc_aTrfs[loc_nTotal, 2] = TmpTrf.Numes
3452:                         loc_aTrfs[loc_nTotal, 3] = TmpTrf.nNumes
3453:                     ENDIF
3454:                     SKIP
3455:                 ENDDO
3456: 
3457:                 *-- Inserir no tubo destino se nao existir
3458:                 FOR loc_nI = 1 TO loc_nTotal
3459:                     loc_cDopes  = loc_aTrfs[loc_nI, 1]
3460:                     loc_nNumes  = loc_aTrfs[loc_nI, 2]
3461:                     loc_nNNumes = loc_aTrfs[loc_nI, 3]
3462:                     SELECT TmpTrf
3463:                     LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cDopes
3464:                     IF !FOUND()
3465:                         INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3466:                             VALUES (loc_cDopes, loc_nNumes, loc_nTuboAtual, loc_nNNumes)

*-- Linhas 3480 a 3523:
3480:     ENDPROC
3481: 
3482:     *==========================================================================
3483:     PROCEDURE TrfLostFocus(par_nKeyCode, par_nShiftAltCtrl)
3484:     *==========================================================================
3485:         LOCAL loc_oCnt3, loc_cTrf, loc_nResultado, loc_lSucesso
3486:         LOCAL loc_nTuboAtual, loc_lRep, loc_nNNumes, loc_nT
3487:         loc_lSucesso = .F.
3488: 
3489:         TRY
3490:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3491:             loc_cTrf  = ALLTRIM(NVL(loc_oCnt3.txt_4c_Trf.Value, ""))
3492: 
3493:             IF EMPTY(loc_cTrf)
3494:                 loc_lSucesso = .T.
3495:             ELSE
3496:                 loc_nResultado = SQLEXEC(gnConnHandle, ;
3497:                     "SELECT TOP 1 m.dopes, m.numes FROM SigMvCab m" + ;
3498:                     " WHERE m.dopes = " + EscaparSQL(loc_cTrf) + ;
3499:                     " AND m.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))) + ;
3500:                     " ORDER BY m.numes DESC", ;
3501:                     "cursor_4c_BuscaTrf")
3502: 
3503:                 IF loc_nResultado > 0 AND USED("cursor_4c_BuscaTrf") AND ;
3504:                         RECCOUNT("cursor_4c_BuscaTrf") > 0
3505:                     loc_nTuboAtual = THIS.this_nTuboAtual
3506:                     loc_lRep       = .F.
3507:                     IF PEMSTATUS(loc_oCnt3, "chk_4c_ChkRep", 5)
3508:                         loc_lRep = (loc_oCnt3.chk_4c_ChkRep.Value = 1)
3509:                     ENDIF
3510: 
3511:                     SELECT cursor_4c_BuscaTrf
3512:                     loc_nNNumes = NVL(cursor_4c_BuscaTrf.numes, 0)
3513: 
3514:                     IF loc_nTuboAtual > 0 AND USED("TmpTrf")
3515:                         SELECT TmpTrf
3516:                         LOCATE FOR TmpTrf.Tubos = loc_nTuboAtual AND TmpTrf.Dopes = loc_cTrf
3517:                         IF !FOUND()
3518:                             INSERT INTO TmpTrf (Dopes, Numes, Tubos, nNumes) ;
3519:                                 VALUES (loc_cTrf, 0, loc_nTuboAtual, loc_nNNumes)
3520:                         ENDIF
3521: 
3522:                         IF loc_lRep
3523:                             FOR loc_nT = 1 TO THIS.this_nMaqTubos

*-- Linhas 3539 a 3620:
3539:                     loc_oCnt3.txt_4c_Trf.Value = ""
3540:                     loc_lSucesso = .T.
3541:                 ELSE
3542:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o '" + loc_cTrf + ;
3543:                         "' n" + CHR(227) + "o encontrada.", ;
3544:                         "Opera" + CHR(231) + CHR(227) + "o")
3545:                     loc_oCnt3.txt_4c_Trf.Value = ""
3546:                 ENDIF
3547: 
3548:                 IF USED("cursor_4c_BuscaTrf")
3549:                     USE IN cursor_4c_BuscaTrf
3550:                 ENDIF
3551:             ENDIF
3552:         CATCH TO loc_oErro
3553:             MsgErro("Erro em FormFUN.TrfLostFocus: " + loc_oErro.Message, "Erro")
3554:         ENDTRY
3555: 
3556:         RETURN loc_lSucesso
3557:     ENDPROC
3558: 
3559:     *==========================================================================
3560:     PROCEDURE AdicionarNopClick()
3561:     *==========================================================================
3562:         LOCAL loc_oCnt3, loc_nNop, loc_nQtTb, loc_nTuboAtual
3563:         LOCAL loc_cCpros, loc_nQtds, loc_nNumes, loc_nRes2
3564:         LOCAL loc_dDtEnt, loc_lSucesso
3565:         loc_lSucesso = .F.
3566: 
3567:         TRY
3568:             loc_oCnt3      = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3569:             loc_nNop       = NVL(loc_oCnt3.txt_4c_Nop.Value, 0)
3570:             loc_nQtTb      = NVL(loc_oCnt3.txt_4c_QtTb.Value, 0)
3571:             loc_nTuboAtual = THIS.this_nTuboAtual
3572: 
3573:             IF loc_nNop <= 0
3574:                 MsgAviso("Informe o n" + CHR(186) + " da O.P.", "O.P.")
3575:             ELSE
3576:                 IF loc_nTuboAtual <= 0
3577:                 MsgAviso("Selecione um tubo antes de adicionar a O.P.", "Tubo")
3578:             ELSE
3579:                 IF loc_nQtTb <= 0
3580:                 MsgAviso("Informe a quantidade do tubo.", "Quantidade")
3581:             ELSE
3582:                 loc_cCpros = ""
3583:                 loc_nQtds  = 0
3584:                 loc_nNumes = 0
3585: 
3586:                 loc_nRes2 = SQLEXEC(gnConnHandle, ;
3587:                     "SELECT o.cpros, o.qtds, o.numes FROM SigOpPic o" + ;
3588:                     " WHERE o.nops = " + TRANSFORM(loc_nNop) + ;
3589:                     " AND o.emps = " + EscaparSQL(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, ""))), ;
3590:                     "cursor_4c_BuscaNop2")
3591: 
3592:                 IF loc_nRes2 > 0 AND USED("cursor_4c_BuscaNop2") AND ;
3593:                         RECCOUNT("cursor_4c_BuscaNop2") > 0
3594:                     SELECT cursor_4c_BuscaNop2
3595:                     loc_cCpros = ALLTRIM(NVL(cursor_4c_BuscaNop2.cpros, ""))
3596:                     loc_nQtds  = NVL(cursor_4c_BuscaNop2.qtds, 0)
3597:                     loc_nNumes = NVL(cursor_4c_BuscaNop2.numes, 0)
3598: 
3599:                     IF USED("cursor_4c_BuscaNop2")
3600:                         USE IN cursor_4c_BuscaNop2
3601:                     ENDIF
3602: 
3603:                     IF USED("TmpNop")
3604:                         SELECT TmpNop
3605:                         LOCATE FOR TmpNop.Tubos = loc_nTuboAtual AND TmpNop.Nops = loc_nNop
3606:                         IF !FOUND()
3607:                             loc_dDtEnt = DATE()
3608:                             INSERT INTO TmpNop (Nops, Cpros, Qtds, Tubos, Qtdos, Numes, ;
3609:                                                EmpDopNums, DtEnts) ;
3610:                                 VALUES (loc_nNop, loc_cCpros, loc_nQtTb, loc_nTuboAtual, ;
3611:                                         loc_nQtds, loc_nNumes, ;
3612:                                         PADR(ALLTRIM(NVL(go_4c_Sistema.cCodEmpresa, "")), 29), ;
3613:                                         loc_dDtEnt)
3614:                         ENDIF
3615: 
3616:                         IF PEMSTATUS(loc_oCnt3, "grd_4c_Gradenop", 5)
3617:                             loc_oCnt3.grd_4c_Gradenop.Refresh()
3618:                         ENDIF
3619:                     ENDIF
3620: 

*-- Linhas 3636 a 3746:
3636:                     IF USED("cursor_4c_BuscaNop2")
3637:                         USE IN cursor_4c_BuscaNop2
3638:                     ENDIF
3639:                     MsgAviso("O.P. n" + CHR(186) + " " + TRANSFORM(loc_nNop) + ;
3640:                         " n" + CHR(227) + "o encontrada.", "O.P.")
3641:                 ENDIF
3642:                 ENDIF
3643:                 ENDIF
3644:             ENDIF
3645:         CATCH TO loc_oErro
3646:             MsgErro("Erro em FormFUN.AdicionarNopClick: " + loc_oErro.Message, "Erro")
3647:         ENDTRY
3648: 
3649:         RETURN loc_lSucesso
3650:     ENDPROC
3651: 
3652:     *==========================================================================
3653:     PROCEDURE RemoverTrfClick()
3654:     *==========================================================================
3655:         LOCAL loc_oCnt3, loc_nTuboAtual, loc_lSucesso
3656:         loc_lSucesso = .F.
3657: 
3658:         TRY
3659:             loc_oCnt3     = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3660:             loc_nTuboAtual = THIS.this_nTuboAtual
3661: 
3662:             IF PEMSTATUS(loc_oCnt3, "grd_4c_GradeTrf", 5) AND USED("TmpTrf")
3663:                 SELECT TmpTrf
3664:                 IF !EOF("TmpTrf") AND TmpTrf.Tubos = loc_nTuboAtual
3665:                     DELETE
3666:                     SET FILTER TO
3667:                     PACK NOOPTIMIZE
3668:                     SET FILTER TO TmpTrf.Tubos = THIS.this_nTuboAtual
3669:                     GO TOP
3670:                     loc_oCnt3.grd_4c_GradeTrf.Refresh()
3671:                 ENDIF
3672:             ENDIF
3673:             loc_lSucesso = .T.
3674:         CATCH TO loc_oErro
3675:             MsgErro("Erro em FormFUN.RemoverTrfClick: " + loc_oErro.Message, "Erro")
3676:         ENDTRY
3677: 
3678:         RETURN loc_lSucesso
3679:     ENDPROC
3680: 
3681:     *==========================================================================
3682:     PROCEDURE GradenopAfterRowColChange(par_nColIndex)
3683:     *==========================================================================
3684:         LPARAMETERS par_nColIndex
3685:         LOCAL loc_oCnt3, loc_lSucesso
3686:         loc_lSucesso = .F.
3687: 
3688:         TRY
3689:             loc_oCnt3 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container3
3690:             IF USED("TmpNop") AND !EOF("TmpNop") AND PEMSTATUS(loc_oCnt3, "txt_4c_Operacao", 5)
3691:                 SELECT TmpNop
3692:                 IF !EOF("TmpNop")
3693:                     loc_oCnt3.txt_4c_Operacao.Value = ALLTRIM(NVL(TmpNop.Cpros, "")) + ;
3694:                         "  Qt: " + TRANSFORM(NVL(TmpNop.Qtds, 0), "999,999.999")
3695:                 ENDIF
3696:             ENDIF
3697:             loc_lSucesso = .T.
3698:         CATCH TO loc_oErro
3699:             MsgErro("Erro em FormFUN.GradenopAfterRowColChange: " + loc_oErro.Message, "Erro")
3700:         ENDTRY
3701: 
3702:         RETURN loc_lSucesso
3703:     ENDPROC
3704: 
3705:     *==========================================================================
3706:     PROCEDURE BtnTotalClick()
3707:     *==========================================================================
3708:         LOCAL loc_oCnt, loc_lSucesso
3709:         loc_lSucesso = .F.
3710: 
3711:         TRY
3712:             IF USED("cursor_4c_TmpTot")
3713:                 USE IN cursor_4c_TmpTot
3714:             ENDIF
3715: 
3716:             IF USED("TmpCera") AND RECCOUNT("TmpCera") > 0
3717:                 SELECT TmpCera.CodArvs AS CodArvs, ;
3718:                        TmpCera.Descs   AS Descs,   ;
3719:                        SUM(TmpCera.pmetalrs) AS PesoRealTotal, ;
3720:                        SUM(TmpCera.MetalNvs) AS MetalNovoTotal, ;
3721:                        SUM(TmpCera.PMetals)  AS PesoMetalTotal  ;
3722:                 FROM TmpCera ;
3723:                 WHERE TmpCera.nStatus = 3 ;
3724:                 GROUP BY TmpCera.CodArvs, TmpCera.Descs ;
3725:                 INTO CURSOR cursor_4c_TmpTot NOFILTER
3726:             ELSE
3727:                 SET NULL ON
3728:                 CREATE CURSOR cursor_4c_TmpTot ( ;
3729:                     CodArvs        C(10), ;
3730:                     Descs          C(40), ;
3731:                     PesoRealTotal  N(12,2), ;
3732:                     MetalNovoTotal N(12,2), ;
3733:                     PesoMetalTotal N(12,2) ;
3734:                 )
3735:                 SET NULL OFF
3736:             ENDIF
3737: 
3738:             loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Total
3739:             IF PEMSTATUS(loc_oCnt, "grd_4c_TmpTot", 5)
3740:                 loc_oCnt.grd_4c_TmpTot.ColumnCount = 4
3741:                 loc_oCnt.grd_4c_TmpTot.RecordSource            = "cursor_4c_TmpTot"
3742:                 loc_oCnt.grd_4c_TmpTot.Column1.ControlSource   = "cursor_4c_TmpTot.CodArvs"
3743:                 loc_oCnt.grd_4c_TmpTot.Column2.ControlSource   = "cursor_4c_TmpTot.PesoRealTotal"
3744:                 loc_oCnt.grd_4c_TmpTot.Column3.ControlSource   = "cursor_4c_TmpTot.MetalNovoTotal"
3745:                 loc_oCnt.grd_4c_TmpTot.Column4.ControlSource   = "cursor_4c_TmpTot.PesoMetalTotal"
3746:                 loc_oCnt.grd_4c_TmpTot.Refresh()

*-- Linhas 3757 a 3816:
3757:     ENDPROC
3758: 
3759:     *==========================================================================
3760:     PROCEDURE BtnCancelarTotalClick()
3761:     *==========================================================================
3762:         LOCAL loc_lSucesso
3763:         loc_lSucesso = .F.
3764: 
3765:         TRY
3766:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Total.Visible = .F.
3767:             loc_lSucesso = .T.
3768:         CATCH TO loc_oErro
3769:             MsgErro("Erro em FormFUN.BtnCancelarTotalClick: " + loc_oErro.Message, "Erro")
3770:         ENDTRY
3771: 
3772:         RETURN loc_lSucesso
3773:     ENDPROC
3774: 
3775:     *==========================================================================
3776:     PROTECTED PROCEDURE LimparCamposTubo()
3777:     *==========================================================================
3778:         LOCAL loc_oCnt4, loc_oCnt5, loc_oCnt6, loc_oPg2
3779: 
3780:         TRY
3781:             loc_oCnt4 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container4
3782:             loc_oCnt5 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container5
3783:             loc_oCnt6 = THIS.pgf_4c_Paginas.Page2.cnt_4c_Container6
3784:             loc_oPg2  = THIS.pgf_4c_Paginas.Page2
3785: 
3786:             IF PEMSTATUS(loc_oCnt4, "edt_4c_Obs", 5)
3787:                 loc_oCnt4.edt_4c_Obs.Value = ""
3788:             ENDIF
3789: 
3790:             IF PEMSTATUS(loc_oCnt5, "txt_4c_Cor", 5)
3791:                 loc_oCnt5.txt_4c_Cor.Value     = ""
3792:                 loc_oCnt5.txt_4c_Basec.Value   = 0
3793:                 loc_oCnt5.txt_4c_Base.Value    = 0
3794:                 loc_oCnt5.txt_4c_Cera.Value    = 0
3795:                 loc_oCnt5.txt_4c_Metal.Value   = 0
3796:                 loc_oCnt5.txt_4c_Mreal.Value   = 0
3797:                 loc_oCnt5.txt_4c_metnovo.Value = 0
3798:             ENDIF
3799: 
3800:             IF PEMSTATUS(loc_oCnt6, "txt_4c_TempMet", 5)
3801:                 loc_oCnt6.txt_4c_TempMet.Value = ""
3802:                 loc_oCnt6.txt_4c_TempTub.Value = ""
3803:                 loc_oCnt6.txt_4c_TempAmb.Value = ""
3804:                 loc_oCnt6.txt_4c_TempAgu.Value = ""
3805:             ENDIF
3806: 
3807:             IF PEMSTATUS(loc_oPg2, "txt_4c_codarvore", 5)
3808:                 loc_oPg2.txt_4c_codarvore.Value  = ""
3809:                 loc_oPg2.txt_4c_descarvore.Value = ""
3810:             ENDIF
3811: 
3812:             IF USED("TmpNop")
3813:                 SELECT TmpNop
3814:                 SET FILTER TO
3815:                 GO TOP
3816:             ENDIF


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
					SET NULL ON
					CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
					    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
					SET NULL OFF
				ENDIF
				MsgErro("Erro ao buscar fundi" + CHR(231) + CHR(245) + "es:" + ;
				    CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro em FUNBO.Buscar: " + loc_oErro.Message, "Erro")
			IF !USED("cursor_4c_Dados")
				SET NULL ON
				CREATE CURSOR cursor_4c_Dados (codigos N(6,0), emps C(3), datas T, ;
				    usuars C(10), codmaqfs C(10), ntubos N(2,0), obss C(200))
				SET NULL OFF
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

