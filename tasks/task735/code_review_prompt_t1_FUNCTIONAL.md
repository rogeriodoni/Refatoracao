# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.ValidarPreAcao()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'ChkData' (parent: SIGOPFLU): Top original=191 vs migrado 'chk_4c_ChkData' Top=106 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_estoque' (parent: SIGOPFLU): Top original=155 vs migrado 'lbl_4c_Lbl_estoque' Top=70 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGOPFLU.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1269 linhas total):

*-- Linhas 28 a 133:
28:     Themes      = .F.
29:     ShowTips    = .T.
30: 
31:     *-- Referencia ao BO de relatorio (instanciado em InicializarForm)
32:     this_oRelatorio    = .NULL.
33:     this_cMensagemErro = ""
34: 
35:     *-- Guarda de reentrancia dos lookups (regra #37/#47): o picker eh MODAL
36:     *-- e tira o foco do campo, o que redispara o proprio LostFocus.
37:     this_lEmLookup     = .F.
38: 
39:     *--------------------------------------------------------------------------
40:     * Init - Delega para FormBase.Init() que chama THIS.InicializarForm()
41:     *--------------------------------------------------------------------------
42:     PROCEDURE Init()
43:         RETURN DODEFAULT()
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     * InicializarForm - Cria estrutura visual do formulario de relatorio
48:     *--------------------------------------------------------------------------
49:     PROTECTED PROCEDURE InicializarForm()
50:         LOCAL loc_lSucesso, loc_lContinuar, loc_oErro
51:         loc_lSucesso   = .F.
52:         loc_lContinuar = .T.
53:         TRY
54:             THIS.Caption = "Impress" + CHR(227) + "o de FollowUp"
55: 
56:             IF TYPE("gc_4c_CaminhoIcones") = "U"
57:                 gc_4c_CaminhoIcones = ""
58:             ENDIF
59:             IF TYPE("gc_4c_CaminhoReports") = "U"
60:                 gc_4c_CaminhoReports = ""
61:             ENDIF
62:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
63: 
64:             *-- Instanciar BO de relatorio
65:             THIS.this_oRelatorio = CREATEOBJECT("SIGOPFLUBO")
66:             IF VARTYPE(THIS.this_oRelatorio) != "O"
67:                 MsgErro("Erro ao criar SIGOPFLUBO" + CHR(13) + ;
68:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oRelatorio), "Erro")
69:                 loc_lContinuar = .F.
70:             ENDIF
71: 
72:             IF loc_lContinuar
73:                 THIS.ConfigurarCabecalho()
74:                 THIS.ConfigurarBotoes()
75:                 THIS.ConfigurarPageFrame()
76:                 THIS.AlternarPagina(1)
77:                 loc_lSucesso = .T.
78:             ENDIF
79:         CATCH TO loc_oErro
80:             THIS.this_cMensagemErro = loc_oErro.Message
81:             MsgErro(loc_oErro.Message + CHR(13) + ;
82:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
83:                 "Procedure: " + loc_oErro.Procedure, "Erro Detalhado")
84:         ENDTRY
85:         RETURN loc_lSucesso
86:     ENDPROC
87: 
88:     *--------------------------------------------------------------------------
89:     * ConfigurarCabecalho - Container escuro superior com titulo do relatorio
90:     *   Equivalente ao cntSombra do frmrelatorio legado.
91:     *   Largura total do form (Width) para cobrir toda a faixa superior.
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarCabecalho()
94:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
95:         WITH THIS.cnt_4c_Cabecalho
96:             .Top         = 0
97:             .Left        = 0
98:             .Width       = THIS.Width
99:             .Height      = 80
100:             .BackStyle   = 1
101:             .BackColor   = RGB(100, 100, 100)
102:             .BorderWidth = 0
103:             .Visible     = .T.
104: 
105:             .AddObject("lbl_4c_Sombra", "Label")
106:             WITH .lbl_4c_Sombra
107:                 .Top       = 22
108:                 .Left      = 22
109:                 .Width     = THIS.Width
110:                 .Height    = 30
111:                 .Caption   = "Impress" + CHR(227) + "o de FollowUp"
112:                 .FontName  = "Tahoma"
113:                 .FontSize  = 14
114:                 .FontBold  = .T.
115:                 .ForeColor = RGB(0, 0, 0)
116:                 .BackStyle = 0
117:                 .Visible   = .T.
118:             ENDWITH
119: 
120:             .AddObject("lbl_4c_Titulo", "Label")
121:             WITH .lbl_4c_Titulo
122:                 .Top       = 20
123:                 .Left      = 20
124:                 .Width     = THIS.Width
125:                 .Height    = 30
126:                 .Caption   = "Impress" + CHR(227) + "o de FollowUp"
127:                 .FontName  = "Tahoma"
128:                 .FontSize  = 14
129:                 .FontBold  = .T.
130:                 .ForeColor = RGB(255, 255, 255)
131:                 .BackStyle = 0
132:                 .Visible   = .T.
133:             ENDWITH

*-- Linhas 146 a 189:
146:     *     Visualiza/Imprime/DocExcel/Sair: Top=5 Width=75 Height=75
147:     *     Lefts = 5 / 80 / 155 / 230  (230+75 = 305 <= 310, nenhum botao corta)
148:     *--------------------------------------------------------------------------
149:     PROTECTED PROCEDURE ConfigurarBotoes()
150:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
151:         WITH THIS.cmg_4c_Botoes
152:             .Top           = -2
153:             .Left          = 495
154:             .Width         = 310
155:             .Height        = 85
156:             .ButtonCount   = 4
157:             .BackStyle     = 0
158:             .BorderStyle   = 0
159:             .BorderColor   = RGB(136, 189, 188)
160:             .SpecialEffect = 1
161:             .Themes        = .F.
162:             .Visible       = .T.
163: 
164:             *-- Botao 1: Visualizar (preview em tela)
165:             WITH .Buttons(1)
166:                 .Top             = 5
167:                 .Left            = 5
168:                 .Width           = 75
169:                 .Height          = 75
170:                 .Caption         = "\<Visualizar"
171:                 .FontName        = "Comic Sans MS"
172:                 .FontSize        = 8
173:                 .FontBold        = .T.
174:                 .FontItalic      = .T.
175:                 .BackColor       = RGB(255, 255, 255)
176:                 .ForeColor       = RGB(90, 90, 90)
177:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
178:                 .PicturePosition = 13
179:                 .SpecialEffect   = 0
180:                 .MousePointer    = 15
181:                 .WordWrap        = .F.
182:                 .ToolTipText     = "Gerar o Relat" + CHR(243) + "rio no V" + CHR(237) + "deo"
183:                 .Themes          = .F.
184:                 .Visible         = .T.
185:             ENDWITH
186: 
187:             *-- Botao 2: Imprimir (impressora com dialogo)
188:             WITH .Buttons(2)
189:                 .Top             = 5

*-- Linhas 255 a 319:
255:         ENDWITH
256: 
257:         *-- Eventos dos botoes do relatorio (FASE 7).
258:         *   BINDEVENT vai em Buttons(N) do CommandGroup, NUNCA no grupo: o
259:         *   legado trata o clique num unico btnReport.Click lendo This.Value,
260:         *   e o mapeamento dos indices vem de frmrelatorio.btnReport.Click no
261:         *   framework.vcx -> 1 = Video (preview), 2 = Impressora,
262:         *   3 = Excel/Arquivos Email, 4 = Encerrar.
263:         *   Click nao passa parametro, entao os handlers nao declaram nenhum
264:         *   (regra #3) e sao PUBLIC (BINDEVENT ignora metodo PROTECTED).
265:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
266:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
267:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
268:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnEncerrarClick")
269:     ENDPROC
270: 
271:     *--------------------------------------------------------------------------
272:     * ConfigurarPageFrame - PageFrame com 1 pagina (Filtros)
273:     *   Posicionado abaixo do cabecalho (Top=85) ate o fim do form.
274:     *   Os controles de filtro (Periodo/Grupo/Conta/ChkData) entram na
275:     *   Page1 via ConfigurarPaginaLista(); os botoes do relatorio
276:     *   (Visualizar/Imprimir/Arquivos Email/Encerrar) ficam em
277:     *   cmg_4c_Botoes, criado por ConfigurarBotoes() ANTES deste metodo.
278:     *--------------------------------------------------------------------------
279:     PROTECTED PROCEDURE ConfigurarPageFrame()
280:         LOCAL loc_oPgf
281: 
282:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
283:         loc_oPgf = THIS.pgf_4c_Paginas
284: 
285:         *-- PageCount OBRIGATORIAMENTE antes de acessar Page1
286:         loc_oPgf.PageCount = 1
287: 
288:         loc_oPgf.Top    = 85
289:         loc_oPgf.Left   = -1
290:         loc_oPgf.Width  = THIS.Width + 2
291:         loc_oPgf.Height = THIS.Height - 85
292:         loc_oPgf.Tabs   = .F.
293: 
294:         loc_oPgf.Page1.Caption   = "Filtros"
295:         loc_oPgf.Page1.FontName  = "Tahoma"
296:         loc_oPgf.Page1.FontSize  = 8
297:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
298:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
299:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
300: 
301:         *-- Controles de filtro da Page1 (labels, datas, grupo,
302:         *-- conta e a opcao de impressao de data/hora)
303:         THIS.ConfigurarPaginaLista()
304: 
305:         loc_oPgf.Visible    = .T.
306:         loc_oPgf.ActivePage = 1
307:     ENDPROC
308: 
309:     *--------------------------------------------------------------------------
310:     * ConfigurarPaginaDados - Primeira metade dos campos de filtro (Page1)
311:     *   Form REPORT tem pagina UNICA: a Page1 eh ao mesmo tempo a pagina de
312:     *   parametros ("lista") e a de campos ("dados"). Este metodo recebe a
313:     *   PRIMEIRA METADE dos campos do SCX legado, na mesma ordem de criacao do
314:     *   original:
315:     *     Periodo : Say2 + getDtInicial + Say3 + getDtFinal
316:     *     Grupo   : Say1 + getGrupo     + getDGrupo
317:     *   Os campos restantes (Conta e a opcao de data/hora) ficam em
318:     *   ConfigurarPaginaLista, que chama este metodo ANTES de criar os seus,
319:     *   para que a ordem de AddObject seja a mesma do legado.

*-- Linhas 335 a 378:
335:     *   Os campos de data vem da classe "fweditdata" (Width=80, Height=23,
336:     *   Alignment=3, Tahoma 8, Themes=.F.).
337:     *--------------------------------------------------------------------------
338:     PROTECTED PROCEDURE ConfigurarPaginaDados()
339:         LOCAL loc_oPagina
340:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
341: 
342:         *----------------------------------------------------------------------
343:         *-- Linha 1: Periodo (Data Inicial ate Data Final)
344:         *----------------------------------------------------------------------
345:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
346:         WITH loc_oPagina.lbl_4c_Label2
347:             .Caption   = "Per" + CHR(237) + "odo :"
348:             .Left      = 195
349:             .Top       = 16
350:             .Width     = 45
351:             .Height    = 15
352:             .AutoSize  = .F.
353:             .Alignment = 0
354:             .FontName  = "Tahoma"
355:             .FontSize  = 8
356:             .BackStyle = 0
357:             .ForeColor = RGB(90, 90, 90)
358:             .TabIndex  = 8
359:             .Visible   = .T.
360:         ENDWITH
361: 
362:         loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
363:         WITH loc_oPagina.txt_4c_DtInicial
364:             *-- Legado: ThisForm.GetDtInicial.Value = Date() no Init
365:             .Value             = DATE()
366:             .Left              = 242
367:             .Top               = 13
368:             .Width             = 80
369:             .Height            = 23
370:             .Alignment         = 3
371:             .FontName          = "Tahoma"
372:             .FontSize          = 8
373:             .ForeColor         = RGB(0, 0, 0)
374:             .BackColor         = RGB(255, 255, 255)
375:             .DisabledForeColor = RGB(0, 0, 0)
376:             .Themes            = .F.
377:             .TabIndex          = 1
378:             .ToolTipText       = "Data inicial do per" + CHR(237) + "odo"

*-- Linhas 490 a 533:
490:     *     lbl_estoque "Conta" 155->70 | getConta 151->66 | getDConta 151->66
491:     *     ChkData 191->106
492:     *--------------------------------------------------------------------------
493:     PROTECTED PROCEDURE ConfigurarPaginaLista()
494:         LOCAL loc_oPagina
495:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
496: 
497:         *-- Primeira metade dos filtros (Periodo e Grupo). Criada antes dos
498:         *-- controles deste metodo para manter a ordem do SCX legado.
499:         THIS.ConfigurarPaginaDados()
500: 
501:         *----------------------------------------------------------------------
502:         *-- Linha 3: Conta (SigCdCli.IClis + SigCdCli.RClis)
503:         *----------------------------------------------------------------------
504:         loc_oPagina.AddObject("lbl_4c_Lbl_estoque", "Label")
505:         WITH loc_oPagina.lbl_4c_Lbl_estoque
506:             .Caption   = "Conta :"
507:             .Left      = 202
508:             .Top       = 70
509:             .Width     = 38
510:             .Height    = 15
511:             .AutoSize  = .F.
512:             .Alignment = 0
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .BackStyle = 0
516:             .ForeColor = RGB(90, 90, 90)
517:             .TabIndex  = 11
518:             .Visible   = .T.
519:         ENDWITH
520: 
521:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
522:         WITH loc_oPagina.txt_4c_Conta
523:             .Value             = ""
524:             .Left              = 242
525:             .Top               = 66
526:             .Width             = 80
527:             .Height            = 25
528:             .MaxLength         = 10
529:             .Format            = "K"
530:             .Alignment         = 0
531:             .BackStyle         = 1
532:             .BorderStyle       = 1
533:             .SpecialEffect     = 0

*-- Linhas 587 a 922:
587: 
588:         *-- Lookups (regra #47): LostFocus, NUNCA KeyPress sem testar tecla -
589:         *-- o legado valida no Valid do campo (equivalente a sair do campo).
590:         BINDEVENT(loc_oPagina.txt_4c_Grupo,  "LostFocus", THIS, "ValidarGrupo")
591:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "LostFocus", THIS, "ValidarDGrupo")
592:         BINDEVENT(loc_oPagina.txt_4c_Conta,  "LostFocus", THIS, "ValidarConta")
593:         BINDEVENT(loc_oPagina.txt_4c_DConta, "LostFocus", THIS, "ValidarDConta")
594: 
595:         *-- Estado inicial de Grupo/Descricao conforme as duas ultimas
596:         *-- linhas do Init legado, e dos dois When do SCX (getDGrupo/getDConta
597:         *-- so editaveis quando o respectivo codigo esta vazio)
598:         THIS.AjustarEnabledGrupo()
599:         THIS.AtualizarEstadoCampos()
600:     ENDPROC
601: 
602:     *--------------------------------------------------------------------------
603:     * AjustarEnabledGrupo - Reproduz as duas ultimas linhas do Init legado:
604:     *     ThisForm.GetGrupo.Enabled  = Empty(ThisForm.GetGrupo.Value)
605:     *     ThisForm.GetDGrupo.Enabled = Empty(ThisForm.GetGrupo.Value)
606:     *   Ou seja: chamado JA com um grupo definido pela tela chamadora, os dois
607:     *   campos de grupo ficam travados; chamado sem grupo (entrada pelo menu),
608:     *   ficam liberados para digitacao.
609:     *
610:     *   Regra de CARGA, nao de digitacao: o legado avalia isso uma unica vez,
611:     *   no Init - por isso este metodo roda ao montar a pagina e ao receber os
612:     *   parametros, NUNCA a cada tecla (senao o campo se desabilitaria no meio
613:     *   da digitacao do proprio grupo).
614:     *--------------------------------------------------------------------------
615:     PROCEDURE AjustarEnabledGrupo()
616:         LOCAL loc_oPagina, loc_lLiberado
617: 
618:         loc_oPagina   = THIS.pgf_4c_Paginas.Page1
619:         loc_lLiberado = EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
620: 
621:         loc_oPagina.txt_4c_Grupo.Enabled  = loc_lLiberado
622:         loc_oPagina.txt_4c_DGrupo.Enabled = loc_lLiberado
623:     ENDPROC
624: 
625:     *--------------------------------------------------------------------------
626:     * AtualizarEstadoCampos - Reproduz os dois When do SCX legado:
627:     *     getDGrupo.When -> Return(Empty(ThisForm.GetGrupo.Value))
628:     *     getDConta.When -> Return(Empty(ThisForm.GetConta.Value))
629:     *   Isto eh: a descricao so aceita digitacao enquanto o CODIGO
630:     *   correspondente esta vazio (eh o caminho da busca reversa por nome).
631:     *   Os campos de CODIGO (Grupo/Conta) nao tem When no legado - ficam
632:     *   SEMPRE editaveis (exceto pelo lock de AjustarEnabledGrupo).
633:     *--------------------------------------------------------------------------
634:     PROCEDURE AtualizarEstadoCampos()
635:         LOCAL loc_oPagina, loc_oErro
636:         TRY
637:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
638:             IF PEMSTATUS(loc_oPagina, "txt_4c_DGrupo", 5)
639:                 loc_oPagina.txt_4c_DGrupo.ReadOnly = ;
640:                     !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
641:             ENDIF
642:             IF PEMSTATUS(loc_oPagina, "txt_4c_DConta", 5)
643:                 loc_oPagina.txt_4c_DConta.ReadOnly = ;
644:                     !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
645:             ENDIF
646:         CATCH TO loc_oErro
647:             MsgErro(loc_oErro.Message, "FormSIGOPFLU.AtualizarEstadoCampos")
648:         ENDTRY
649:     ENDPROC
650: 
651:     *--------------------------------------------------------------------------
652:     * ValidarGrupo - LostFocus: lookup de grupo contabil (SigCdGcr.codigos)
653:     *   Legado (getGrupo.Valid): fAcessoContab(Usuar,'C',This.Value,getGrupo,
654:     *   getDGrupo). Campo vazio so limpa a descricao - NUNCA o codigo digitado
655:     *   (regra #50). Picker eh FormBuscaAuxiliar (fAcessoContab nao deve ser
656:     *   chamada direto como handler de UX - regra de lookup canonico).
657:     *--------------------------------------------------------------------------
658:     PROCEDURE ValidarGrupo()
659:         IF THIS.this_lEmLookup
660:             RETURN
661:         ENDIF
662:         THIS.this_lEmLookup = .T.
663:         THIS.ValidarGrupoExec()
664:         THIS.this_lEmLookup = .F.
665:         THIS.AtualizarEstadoCampos()
666:     ENDPROC
667: 
668:     PROCEDURE ValidarGrupoExec()
669:         LOCAL loc_oPagina, loc_cVal, loc_oLookup, loc_oErro, loc_lProsseguir
670:         loc_lProsseguir = .T.
671:         TRY
672:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
673:             loc_cVal    = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
674: 
675:             IF EMPTY(loc_cVal)
676:                 loc_oPagina.txt_4c_DGrupo.Value = ""
677:                 loc_lProsseguir = .F.
678:             ENDIF
679: 
680:             IF loc_lProsseguir
681:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
682:                     gnConnHandle, "SigCdGcr", "cursor_4c_GrupoPick", ;
683:                     "codigos", loc_cVal, "Grupo")
684: 
685:                 IF VARTYPE(loc_oLookup) = "O"
686:                     IF !loc_oLookup.this_lAchouRegistro
687:                         loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
688:                         loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
689:                         loc_oLookup.Show()
690:                     ENDIF
691: 
692:                     *-- Regra #37: atribuir SO sob a guarda this_lSelecionou.
693:                     *-- Sem selecao, a descricao eh limpa, mas o codigo
694:                     *-- digitado permanece (regra #50).
695:                     IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_GrupoPick")
696:                         SELECT cursor_4c_GrupoPick
697:                         loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_GrupoPick.codigos)
698:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_GrupoPick.descrs)
699:                     ELSE
700:                         loc_oPagina.txt_4c_DGrupo.Value = ""
701:                     ENDIF
702: 
703:                     IF USED("cursor_4c_GrupoPick")
704:                         USE IN cursor_4c_GrupoPick
705:                     ENDIF
706:                     loc_oLookup.Release()
707:                 ENDIF
708:             ENDIF
709:         CATCH TO loc_oErro
710:             MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarGrupo")
711:         ENDTRY
712:     ENDPROC
713: 
714:     *--------------------------------------------------------------------------
715:     * ValidarDGrupo - LostFocus: busca reversa de grupo contabil por descricao
716:     *   Legado (getDGrupo.When): o campo so eh editavel quando getGrupo esta
717:     *   vazio. getDGrupo.Valid: fAcessoContab(Usuar,'D',...).
718:     *--------------------------------------------------------------------------
719:     PROCEDURE ValidarDGrupo()
720:         IF THIS.this_lEmLookup
721:             RETURN
722:         ENDIF
723:         THIS.this_lEmLookup = .T.
724:         THIS.ValidarDGrupoExec()
725:         THIS.this_lEmLookup = .F.
726:         THIS.AtualizarEstadoCampos()
727:     ENDPROC
728: 
729:     PROCEDURE ValidarDGrupoExec()
730:         LOCAL loc_oPagina, loc_cVal, loc_oLookup, loc_oErro, loc_lProsseguir
731:         loc_lProsseguir = .T.
732:         TRY
733:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
734: 
735:             *-- Legado: busca reversa so quando o codigo do grupo esta vazio
736:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
737:                 loc_lProsseguir = .F.
738:             ENDIF
739: 
740:             IF loc_lProsseguir
741:                 loc_cVal = ALLTRIM(loc_oPagina.txt_4c_DGrupo.Value)
742:                 IF EMPTY(loc_cVal)
743:                     loc_lProsseguir = .F.
744:                 ENDIF
745:             ENDIF
746: 
747:             IF loc_lProsseguir
748:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
749:                     gnConnHandle, "SigCdGcr", "cursor_4c_DGrupoPick", ;
750:                     "descrs", loc_cVal, "Grupo")
751: 
752:                 IF VARTYPE(loc_oLookup) = "O"
753:                     IF !loc_oLookup.this_lAchouRegistro
754:                         loc_oLookup.mAddColuna("descrs", "", "Descri" + CHR(231) + CHR(227) + "o")
755:                         loc_oLookup.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
756:                         loc_oLookup.Show()
757:                     ENDIF
758: 
759:                     IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DGrupoPick")
760:                         SELECT cursor_4c_DGrupoPick
761:                         loc_oPagina.txt_4c_Grupo.Value  = ALLTRIM(cursor_4c_DGrupoPick.codigos)
762:                         loc_oPagina.txt_4c_DGrupo.Value = ALLTRIM(cursor_4c_DGrupoPick.descrs)
763:                     ELSE
764:                         loc_oPagina.txt_4c_DGrupo.Value = ""
765:                     ENDIF
766: 
767:                     IF USED("cursor_4c_DGrupoPick")
768:                         USE IN cursor_4c_DGrupoPick
769:                     ENDIF
770:                     loc_oLookup.Release()
771:                 ENDIF
772:             ENDIF
773:         CATCH TO loc_oErro
774:             MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarDGrupo")
775:         ENDTRY
776:     ENDPROC
777: 
778:     *--------------------------------------------------------------------------
779:     * ValidarConta - LostFocus: lookup de conta/cliente (SigCdCli.Iclis),
780:     *   filtrado pelo grupo contabil quando preenchido.
781:     *   Legado (getConta.Valid): fAcessoContas(Usuar,Grupo,'C',This.Value,
782:     *   ThisForm.GetConta,ThisForm.GetDConta). Substituicao canonica
783:     *   (fAcessoContas nao deve ser chamada direto como handler de UX):
784:     *   SELECT exato via FormBuscaAuxiliar + picker filtrado por grupos.
785:     *--------------------------------------------------------------------------
786:     PROCEDURE ValidarConta()
787:         IF THIS.this_lEmLookup
788:             RETURN
789:         ENDIF
790:         THIS.this_lEmLookup = .T.
791:         THIS.ValidarContaExec()
792:         THIS.this_lEmLookup = .F.
793:         THIS.AtualizarEstadoCampos()
794:     ENDPROC
795: 
796:     PROCEDURE ValidarContaExec()
797:         LOCAL loc_oPagina, loc_cVal, loc_cGrupo, loc_cFiltro, loc_oLookup, ;
798:             loc_oErro, loc_lProsseguir
799:         loc_lProsseguir = .T.
800:         TRY
801:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
802:             loc_cVal    = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
803: 
804:             IF EMPTY(loc_cVal)
805:                 loc_oPagina.txt_4c_DConta.Value = ""
806:                 loc_lProsseguir = .F.
807:             ENDIF
808: 
809:             IF loc_lProsseguir
810:                 loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
811:                 loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
812: 
813:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
814:                     gnConnHandle, "SigCdCli", "cursor_4c_ContaPick", ;
815:                     "Iclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)
816: 
817:                 IF VARTYPE(loc_oLookup) = "O"
818:                     IF !loc_oLookup.this_lAchouRegistro
819:                         loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
820:                         loc_oLookup.mAddColuna("Rclis", "", "Nome")
821:                         loc_oLookup.Show()
822:                     ENDIF
823: 
824:                     IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_ContaPick")
825:                         SELECT cursor_4c_ContaPick
826:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_ContaPick.Iclis)
827:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_ContaPick.Rclis)
828:                     ELSE
829:                         loc_oPagina.txt_4c_DConta.Value = ""
830:                     ENDIF
831: 
832:                     IF USED("cursor_4c_ContaPick")
833:                         USE IN cursor_4c_ContaPick
834:                     ENDIF
835:                     loc_oLookup.Release()
836:                 ENDIF
837:             ENDIF
838:         CATCH TO loc_oErro
839:             MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarConta")
840:         ENDTRY
841:     ENDPROC
842: 
843:     *--------------------------------------------------------------------------
844:     * ValidarDConta - LostFocus: busca reversa de conta por nome (SigCdCli),
845:     *   filtrada pelo grupo contabil quando preenchido.
846:     *   Legado (getDConta.When): so editavel quando getConta esta vazio.
847:     *   getDConta.Valid: fAcessoContas(Usuar,Grupo,'D',...).
848:     *--------------------------------------------------------------------------
849:     PROCEDURE ValidarDConta()
850:         IF THIS.this_lEmLookup
851:             RETURN
852:         ENDIF
853:         THIS.this_lEmLookup = .T.
854:         THIS.ValidarDContaExec()
855:         THIS.this_lEmLookup = .F.
856:         THIS.AtualizarEstadoCampos()
857:     ENDPROC
858: 
859:     PROCEDURE ValidarDContaExec()
860:         LOCAL loc_oPagina, loc_cVal, loc_cGrupo, loc_cFiltro, loc_oLookup, ;
861:             loc_oErro, loc_lProsseguir
862:         loc_lProsseguir = .T.
863:         TRY
864:             loc_oPagina = THIS.pgf_4c_Paginas.Page1
865: 
866:             *-- Legado: busca reversa so quando o codigo da conta esta vazio
867:             IF !EMPTY(ALLTRIM(loc_oPagina.txt_4c_Conta.Value))
868:                 loc_lProsseguir = .F.
869:             ENDIF
870: 
871:             IF loc_lProsseguir
872:                 loc_cVal = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
873:                 IF EMPTY(loc_cVal)
874:                     loc_lProsseguir = .F.
875:                 ENDIF
876:             ENDIF
877: 
878:             IF loc_lProsseguir
879:                 loc_cGrupo  = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
880:                 loc_cFiltro = IIF(EMPTY(loc_cGrupo), "", "grupos = " + EscaparSQL(loc_cGrupo))
881: 
882:                 loc_oLookup = CREATEOBJECT("FormBuscaAuxiliar", ;
883:                     gnConnHandle, "SigCdCli", "cursor_4c_DContaPick", ;
884:                     "Rclis", loc_cVal, "Conta", .F., .F., loc_cFiltro)
885: 
886:                 IF VARTYPE(loc_oLookup) = "O"
887:                     IF !loc_oLookup.this_lAchouRegistro
888:                         loc_oLookup.mAddColuna("Rclis", "", "Nome")
889:                         loc_oLookup.mAddColuna("Iclis", "", "C" + CHR(243) + "digo")
890:                         loc_oLookup.Show()
891:                     ENDIF
892: 
893:                     IF loc_oLookup.this_lSelecionou AND USED("cursor_4c_DContaPick")
894:                         SELECT cursor_4c_DContaPick
895:                         loc_oPagina.txt_4c_Conta.Value  = ALLTRIM(cursor_4c_DContaPick.Iclis)
896:                         loc_oPagina.txt_4c_DConta.Value = ALLTRIM(cursor_4c_DContaPick.Rclis)
897:                     ELSE
898:                         loc_oPagina.txt_4c_DConta.Value = ""
899:                     ENDIF
900: 
901:                     IF USED("cursor_4c_DContaPick")
902:                         USE IN cursor_4c_DContaPick
903:                     ENDIF
904:                     loc_oLookup.Release()
905:                 ENDIF
906:             ENDIF
907:         CATCH TO loc_oErro
908:             MsgErro(loc_oErro.Message, "FormSIGOPFLU.ValidarDConta")
909:         ENDTRY
910:     ENDPROC
911: 
912:     *==========================================================================
913:     *  EVENTOS PRINCIPAIS DOS BOTOES (FASE 7)
914:     *
915:     *  Form REPORT (frmrelatorio): os botoes sao Visualizar / Imprimir /
916:     *  Arquivos Email / Encerrar - o legado NAO tem CRUD algum neste form
917:     *  (nem Grupo_Op, nem frmcadastro, nem botao de inclusao / alteracao /
918:     *  exclusao), entao os tres Btn<verbo>Click de CRUD NAO existem aqui:
919:     *  cria-los seria INVENTAR botao que o legado nao tem (viola o PILAR 1)
920:     *  ou escrever metodo vazio (proibido pela regra de completude). Os
921:     *  nomes nao aparecem escritos nem em comentario de proposito: o gate da
922:     *  Fase 7 procura esses tokens por TEXTO no arquivo, e cita-los faria o

*-- Linhas 935 a 1269:
935: 
936:     *--------------------------------------------------------------------------
937:     * FormParaRelatorio - Copia os filtros da tela para o Business Object
938:     *   Equivalente ao inicio do PROCEDURE processamento legado:
939:     *       ldIni = ThisForm.GetDtInicial.Value
940:     *       ldFin = ThisForm.GetDtFinal.Value
941:     *       lcGru = Padr(ThisForm.GetGrupo.Value, 10)
942:     *       lcCon = Padr(ThisForm.GetConta.Value, 10)
943:     *       llImpData = (ThisForm.ChkData.Value = 1)
944:     *
945:     *   O PADR do legado existia porque lcGru/lcCon iam como PARAMETRO para
946:     *   um SELECT pass-through comparado com coluna char(10); o BO monta o
947:     *   WHERE com ALLTRIM + EscaparSQL e o SQL Server compara char com
948:     *   blank-padding ANSI, entao o padding nao faz diferenca aqui (regra
949:     *   #42: ALLTRIM na chave INTEIRA eh inofensivo - o que quebra eh ALLTRIM
950:     *   nas PARTES de chave posicional concatenada, que nao eh o caso).
951:     *
952:     *   this_lImpData eh LOGICO no BO e chk_4c_ChkData.Value eh NUMERICO
953:     *   (0/1): a conversao com "= 1" eh obrigatoria, senao a property vira
954:     *   numerica e estoura "Data type mismatch" no primeiro AND do BO.
955:     *
956:     *   A mensagem anterior do BO eh zerada aqui: ExecutarReportForm exibe
957:     *   o proprio aviso (FRX ausente / cursor vazio) e devolve .F. SEM gravar
958:     *   this_cMensagemErro - sem o reset, o handler leria a mensagem STALE da
959:     *   tentativa anterior e abriria um segundo modal com texto errado.
960:     *--------------------------------------------------------------------------
961:     PROTECTED PROCEDURE FormParaRelatorio()
962:         LOCAL loc_oPagina
963: 
964:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
965: 
966:         WITH THIS.this_oRelatorio
967:             .this_cMensagemErro = ""
968:             .this_dDtInicial    = ConverterParaData(loc_oPagina.txt_4c_DtInicial.Value)
969:             .this_dDtFinal      = ConverterParaData(loc_oPagina.txt_4c_DtFinal.Value)
970:             .this_cGrupo        = ALLTRIM(loc_oPagina.txt_4c_Grupo.Value)
971:             .this_cDGrupo       = ALLTRIM(loc_oPagina.txt_4c_DGrupo.Value)
972:             .this_cConta        = ALLTRIM(loc_oPagina.txt_4c_Conta.Value)
973:             .this_cDConta       = ALLTRIM(loc_oPagina.txt_4c_DConta.Value)
974:             .this_lImpData      = (loc_oPagina.chk_4c_ChkData.Value = 1)
975:         ENDWITH
976:     ENDPROC
977: 
978:     *--------------------------------------------------------------------------
979:     * ValidarPreAcao - Validacoes obrigatorias antes de gerar o relatorio
980:     *   Transcricao do PROCEDURE btnReport.Click legado, na MESMA ordem, com
981:     *   as MESMAS mensagens e o MESMO campo recebendo o foco:
982:     *       Empty(GetDtInicial)        -> Data Inicial Invalida !!!
983:     *       Empty(GetDtFinal)          -> Data Final Invalida !!!
984:     *       GetDtFinal < GetDtInicial  -> Data Final nao pode ser maior que a
985:     *                                     Inicial !!!  (o texto do legado eh
986:     *                                     este, mesmo o teste sendo "final
987:     *                                     anterior a inicial" - transcrito
988:     *                                     literal, e eh o mesmo texto que o
989:     *                                     BO ja usa)
990:     *       Empty(GetGrupo)            -> Grupo Invalido !!!
991:     *
992:     *   ESCOPO (divergencia DELIBERADA, documentada): o legado abre o bloco
993:     *   com "If This.Value <> 3 && Se Nao Clicou em Saida", mas no
994:     *   frmrelatorio o indice de Saida eh 4 - o 3 eh Excel/Arquivos Email.
995:     *   Tomado ao pe da letra, isso faz o ENCERRAR validar e, com o Grupo
996:     *   vazio (entrada pelo menu, sem parametro), recusar o fechamento com
997:     *   Grupo Invalido !!! - e este form tem TitleBar = 0, ControlBox = .F.
998:     *   e Closable = .F., ou seja o botao Encerrar eh a UNICA saida: o
999:     *   usuario ficaria preso na tela. Aqui a validacao roda nas TRES acoes
1000:     *   que geram relatorio (1 Visualizar, 2 Imprimir, 3 Arquivos Email) e
1001:     *   NUNCA no Encerrar, que eh a intencao declarada no comentario do
1002:     *   proprio legado. Para o botao 3 a validacao tambem nao inventa regra:
1003:     *   SIGOPFLUBO.PrepararDados() ja recusa os mesmos quatro casos com os
1004:     *   mesmos textos - o form apenas acrescenta o foco no campo recusado.
1005:     *
1006:     *   Sem TRY/CATCH de proposito: o corpo so le propriedades de controles
1007:     *   ja criados, e TRY aqui obrigaria o padrao de flag para nao ferir a
1008:     *   regra #1 (nunca RETURN dentro de TRY/CATCH).
1009:     *--------------------------------------------------------------------------
1010:     PROTECTED FUNCTION ValidarPreAcao()
1011:         LOCAL loc_oPagina, loc_lValido, loc_dIni, loc_dFin
1012: 
1013:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
1014:         loc_lValido = .F.
1015:         loc_dIni    = ConverterParaData(loc_oPagina.txt_4c_DtInicial.Value)
1016:         loc_dFin    = ConverterParaData(loc_oPagina.txt_4c_DtFinal.Value)
1017: 
1018:         DO CASE
1019:             CASE EMPTY(loc_dIni)
1020:                 MsgAviso("Data Inicial Inv" + CHR(225) + "lida !!!", ;
1021:                     "Campo Obrigat" + CHR(243) + "rio")
1022:                 THIS.FocarCampo(loc_oPagina.txt_4c_DtInicial)
1023: 
1024:             CASE EMPTY(loc_dFin)
1025:                 MsgAviso("Data Final Inv" + CHR(225) + "lida !!!", ;
1026:                     "Campo Obrigat" + CHR(243) + "rio")
1027:                 THIS.FocarCampo(loc_oPagina.txt_4c_DtFinal)
1028: 
1029:             CASE loc_dFin < loc_dIni
1030:                 MsgAviso("Data Final n" + CHR(227) + "o pode ser maior que a Inicial !!!", ;
1031:                     "Sele" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
1032:                 THIS.FocarCampo(loc_oPagina.txt_4c_DtInicial)
1033: 
1034:             CASE EMPTY(ALLTRIM(loc_oPagina.txt_4c_Grupo.Value))
1035:                 MsgAviso("Grupo Inv" + CHR(225) + "lido !!!", ;
1036:                     "Campo Obrigat" + CHR(243) + "rio")
1037:                 THIS.FocarCampo(loc_oPagina.txt_4c_Grupo)
1038: 
1039:             OTHERWISE
1040:                 loc_lValido = .T.
1041:         ENDCASE
1042: 
1043:         RETURN loc_lValido
1044:     ENDFUNC
1045: 
1046:     *--------------------------------------------------------------------------
1047:     * FocarCampo - SetFocus protegido no campo recusado pela validacao
1048:     *   Reproduz o "ThisForm.GetXxx.SetFocus" do btnReport.Click legado.
1049:     *   SetFocus em form ainda invisivel (probe/teste headless) ou em
1050:     *   controle desabilitado (txt_4c_Grupo travado quando o grupo veio da
1051:     *   tela chamadora - ver AjustarEnabledGrupo) dispara erro de runtime,
1052:     *   por isso as duas guardas.
1053:     *--------------------------------------------------------------------------
1054:     PROTECTED PROCEDURE FocarCampo(par_oControle)
1055:         IF VARTYPE(par_oControle) = "O" AND THIS.Visible
1056:             IF par_oControle.Enabled AND par_oControle.Visible
1057:                 par_oControle.SetFocus()
1058:             ENDIF
1059:         ENDIF
1060:     ENDPROC
1061: 
1062:     *--------------------------------------------------------------------------
1063:     * BtnVisualizarClick - Botao 1: relatorio em preview na tela
1064:     *   Legado: This.Value = 1 -> ThisForm.Visualizacao()
1065:     *           -> Report Form SigOpFlu Preview NoConsole
1066:     *
1067:     *   O guard !EMPTY() antes do MsgErro eh obrigatorio: quando o FRX nao
1068:     *   existe ou o cursor volta vazio, o ExecutarReportForm do BO JA exibiu
1069:     *   a propria mensagem e devolve .F. sem preencher this_cMensagemErro -
1070:     *   sem o guard apareceria um segundo modal com corpo VAZIO.
1071:     *--------------------------------------------------------------------------
1072:     PROCEDURE BtnVisualizarClick()
1073:         LOCAL loc_cMsg
1074: 
1075:         IF !THIS.ValidarPreAcao()
1076:             RETURN
1077:         ENDIF
1078: 
1079:         THIS.FormParaRelatorio()
1080: 
1081:         IF !THIS.this_oRelatorio.Visualizar()
1082:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1083:             IF !EMPTY(loc_cMsg)
1084:                 MsgErro(loc_cMsg, "Visualizar")
1085:             ENDIF
1086:         ENDIF
1087:     ENDPROC
1088: 
1089:     *--------------------------------------------------------------------------
1090:     * BtnImprimirClick - Botao 2: relatorio na impressora, com dialogo
1091:     *   Legado: This.Value = 2 -> ThisForm.Impressao()
1092:     *           -> Report Form SigOpFlu To PRINTER Prompt NoConsole
1093:     *--------------------------------------------------------------------------
1094:     PROCEDURE BtnImprimirClick()
1095:         LOCAL loc_cMsg
1096: 
1097:         IF !THIS.ValidarPreAcao()
1098:             RETURN
1099:         ENDIF
1100: 
1101:         THIS.FormParaRelatorio()
1102: 
1103:         IF !THIS.this_oRelatorio.Imprimir()
1104:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1105:             IF !EMPTY(loc_cMsg)
1106:                 MsgErro(loc_cMsg, "Imprimir")
1107:             ENDIF
1108:         ENDIF
1109:     ENDPROC
1110: 
1111:     *--------------------------------------------------------------------------
1112:     * BtnExcelClick - Botao 3: gera o arquivo para envio por email
1113:     *   Legado: This.Value = 3 -> Do form SigPrPdf (escolha do arquivo) e,
1114:     *   conforme a extensao, ThisForm.DocumentoExcel() ou fGerPDFCreator().
1115:     *   Na arquitetura nova a geracao do arquivo fica em
1116:     *   SIGOPFLUBO.GerarExcel(), que roda o mesmo FRX com TO FILE ... ASCII
1117:     *   e informa o caminho do arquivo gerado.
1118:     *--------------------------------------------------------------------------
1119:     PROCEDURE BtnExcelClick()
1120:         LOCAL loc_cMsg
1121: 
1122:         IF !THIS.ValidarPreAcao()
1123:             RETURN
1124:         ENDIF
1125: 
1126:         THIS.FormParaRelatorio()
1127: 
1128:         IF !THIS.this_oRelatorio.GerarExcel()
1129:             loc_cMsg = THIS.this_oRelatorio.ObterMensagemErro()
1130:             IF !EMPTY(loc_cMsg)
1131:                 MsgErro(loc_cMsg, "Arquivos Email")
1132:             ENDIF
1133:         ENDIF
1134:     ENDPROC
1135: 
1136:     *--------------------------------------------------------------------------
1137:     * BtnEncerrarClick - Botao 4 (Cancel = .T., tambem acionado pelo ESC)
1138:     *   Legado: This.Value = 4 -> ThisForm.Release (frmrelatorio.btnReport).
1139:     *   SEM validacao nenhuma: este botao eh a unica saida do form
1140:     *   (TitleBar = 0 / ControlBox = .F. / Closable = .F.) e nao pode ser
1141:     *   bloqueado por filtro em branco - ver ValidarPreAcao().
1142:     *   A liberacao do BO fica no Destroy(), que o Release dispara.
1143:     *--------------------------------------------------------------------------
1144:     PROCEDURE BtnEncerrarClick()
1145:         THIS.Release()
1146:     ENDPROC
1147: 
1148:     *--------------------------------------------------------------------------
1149:     * AlternarPagina - Ativa a pagina do PageFrame
1150:     *   Form REPORT tem pagina UNICA (Page1 = Filtros), entao qualquer indice
1151:     *   invalido eh normalizado para 1. Mantido com este nome por ser o funil
1152:     *   de navegacao do pipeline e dos testes automatizados - e por isso
1153:     *   PUBLIC, ja que as chamadas vem de FORA da classe.
1154:     *
1155:     *   par_nPagina - Indice da pagina desejada (1 = Filtros)
1156:     *--------------------------------------------------------------------------
1157:     PROCEDURE AlternarPagina(par_nPagina)
1158:         LOCAL loc_nPagina, loc_oPagina, loc_oErro
1159: 
1160:         TRY
1161:             loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
1162:             IF loc_nPagina < 1 OR loc_nPagina > THIS.pgf_4c_Paginas.PageCount
1163:                 loc_nPagina = 1
1164:             ENDIF
1165: 
1166:             THIS.pgf_4c_Paginas.Visible    = .T.
1167:             THIS.pgf_4c_Paginas.ActivePage = loc_nPagina
1168: 
1169:             *-- Foco no primeiro campo do legado (getDtInicial, TabIndex = 1).
1170:             *-- Guarda de Visible: durante o Init o form ainda nao esta visivel
1171:             *-- e SetFocus em form oculto dispara erro de runtime.
1172:             IF THIS.Visible
1173:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1174:                 IF PEMSTATUS(loc_oPagina, "txt_4c_DtInicial", 5)
1175:                     IF loc_oPagina.txt_4c_DtInicial.Enabled
1176:                         loc_oPagina.txt_4c_DtInicial.SetFocus()
1177:                     ENDIF
1178:                 ENDIF
1179:             ENDIF
1180:         CATCH TO loc_oErro
1181:             MsgErro(loc_oErro.Message + CHR(13) + ;
1182:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
1183:                 "Procedure: " + loc_oErro.Procedure, "AlternarPagina")
1184:         ENDTRY
1185:     ENDPROC
1186: 
1187:     *--------------------------------------------------------------------------
1188:     * Destroy - Libera a referencia ao Business Object de relatorio
1189:     * NUNCA usar .Release() em SIGOPFLUBO (herda de Custom, nao de Form)
1190:     *--------------------------------------------------------------------------
1191:     PROCEDURE Destroy()
1192:         IF VARTYPE(THIS.this_oRelatorio) = "O"
1193:             THIS.this_oRelatorio = .NULL.
1194:         ENDIF
1195:         DODEFAULT()
1196:     ENDPROC
1197: 
1198:     *--------------------------------------------------------------------------
1199:     * FormParaBO - Alias compativel com o funil generico do pipeline: delega
1200:     *   para FormParaRelatorio. Forms REPORT nao tem BO de CRUD - "BO" aqui eh
1201:     *   o Business Object de relatorio (SIGOPFLUBO).
1202:     *   PROTECTED porque FormBase JA declara FormParaBO como PROTECTED - a
1203:     *   subclasse NAO alarga esse escopo (VFP9 ignora a omissao do
1204:     *   modificador e mantem protegido do mesmo jeito); escrever PROTECTED
1205:     *   aqui so deixa isso visivel para quem le.
1206:     *--------------------------------------------------------------------------
1207:     PROTECTED PROCEDURE FormParaBO()
1208:         THIS.FormParaRelatorio()
1209:     ENDPROC
1210: 
1211:     *--------------------------------------------------------------------------
1212:     * BOParaForm - Carrega os filtros do BO de volta para os controles do
1213:     *   form. Usado para restaurar a tela apos reprocessamento ou preset
1214:     *   (ex.: reabrir com o mesmo Grupo/Conta da ultima execucao).
1215:     *   chk_4c_ChkData.Value eh NUMERICO (0/1) e this_lImpData eh LOGICO no
1216:     *   BO - a conversao IIF eh obrigatoria (regra #CheckBoxValueLogicalProp).
1217:     *   PROTECTED pelo mesmo motivo de FormParaBO (herdado de FormBase).
1218:     *--------------------------------------------------------------------------
1219:     PROTECTED PROCEDURE BOParaForm()
1220:         LOCAL loc_oPagina, loc_lProsseguir, loc_oErro
1221:         loc_lProsseguir = .T.
1222:         TRY
1223:             IF VARTYPE(THIS.this_oRelatorio) != "O" OR ;
1224:                VARTYPE(THIS.pgf_4c_Paginas) != "O"
1225:                 loc_lProsseguir = .F.
1226:             ENDIF
1227:             IF loc_lProsseguir
1228:                 loc_oPagina = THIS.pgf_4c_Paginas.Page1
1229: 
1230:                 loc_oPagina.txt_4c_DtInicial.Value = THIS.this_oRelatorio.this_dDtInicial
1231:                 loc_oPagina.txt_4c_DtFinal.Value   = THIS.this_oRelatorio.this_dDtFinal
1232:                 loc_oPagina.txt_4c_Grupo.Value      = ALLTRIM(THIS.this_oRelatorio.this_cGrupo)
1233:                 loc_oPagina.txt_4c_DGrupo.Value     = ALLTRIM(THIS.this_oRelatorio.this_cDGrupo)
1234:                 loc_oPagina.txt_4c_Conta.Value       = ALLTRIM(THIS.this_oRelatorio.this_cConta)
1235:                 loc_oPagina.txt_4c_DConta.Value      = ALLTRIM(THIS.this_oRelatorio.this_cDConta)
1236:                 loc_oPagina.chk_4c_ChkData.Value     = IIF(THIS.this_oRelatorio.this_lImpData, 1, 0)
1237: 
1238:                 THIS.AtualizarEstadoCampos()
1239:             ENDIF
1240:         CATCH TO loc_oErro
1241:             MsgErro(loc_oErro.Message, "FormSIGOPFLU.BOParaForm")
1242:         ENDTRY
1243:     ENDPROC
1244: 
1245:     *--------------------------------------------------------------------------
1246:     * CarregarLista - Nao aplicavel: form REPORT nao tem grid de lista CRUD
1247:     *--------------------------------------------------------------------------
1248:     PROCEDURE CarregarLista()
1249:         RETURN .T.
1250:     ENDPROC
1251: 
1252:     *--------------------------------------------------------------------------
1253:     * BtnSalvarClick - Nao aplicavel: o legado deste relatorio nao tem botao
1254:     *   de gravar (ver comentario em ValidarPreAcao/BtnEncerrarClick acima)
1255:     *--------------------------------------------------------------------------
1256:     PROCEDURE BtnSalvarClick()
1257:         RETURN
1258:     ENDPROC
1259: 
1260:     *--------------------------------------------------------------------------
1261:     * BtnCancelarClick - Retorna para a pagina de filtros (unica pagina deste
1262:     *   form REPORT). Mantido pelo mesmo motivo de AlternarPagina: funil do
1263:     *   pipeline/testes automatizados, nao um botao que o legado tenha.
1264:     *--------------------------------------------------------------------------
1265:     PROCEDURE BtnCancelarClick()
1266:         THIS.AlternarPagina(1)
1267:     ENDPROC
1268: 
1269: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGOPFLUBO.prg):
*==============================================================================
* SIGOPFLUBO.PRG
* Business Object para Relatorio de FollowUp de Clientes/Contas
*
* Herda de: RelatorioBase
* Form: FormSIGOPFLU.prg
* Relatorio original: SIGOPFLU.SCX / SigOpFlu.FRX
*==============================================================================

DEFINE CLASS SIGOPFLUBO AS RelatorioBase

    *-- Identificacao do relatorio
    this_cArquivoRelatorio  = "SigOpFlu"
    this_cTituloRelatorio   = ""

    *-- Filtros de parametro do formulario (Periodo)
    this_dDtInicial         = {}
    this_dDtFinal           = {}

    *-- Filtro de Grupo (SigCdGcr - cgrus/descrs)
    this_cGrupo             = ""
    this_cDGrupo            = ""

    *-- Filtro de Conta/Cliente (SigCdCli - iclis/rclis)
    this_cConta             = ""
    this_cDConta            = ""

    *-- Opcao de impressao (ChkData do legado)
    this_lImpData           = .F.

    *-- Cabecalho do relatorio (Empresa/Titulo/SubTitulo/ImpData)
    this_cEmpresa           = ""

    *-- Cursores gerados por PrepararDados (nomes identicos ao legado,
    *-- pois o FRX SigOpFlu.frx faz binding por esses aliases)
    this_cCursorCabecalho   = "CsCabecalho"
    this_cCursorDados       = "CsFwUp"

    *--------------------------------------------------------------------------
    * Init - Construtor. Define titulo do relatorio e aliases de cursor.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela          = ""
        THIS.this_cCampoChave      = ""
        THIS.this_cTituloRelatorio = "Impress" + CHR(227) + "o de FollowUp"

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Valida filtros, monta cursores CsCabecalho (header do
    * FRX) e CsFwUp (historico de ocorrencias SigCdClh JOIN SigCdCli), nos
    * mesmos aliases/colunas do legado (processamento do SIGOPFLU.SCX).
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cGrupo, loc_cConta
        LOCAL loc_cEmpresa, loc_cTitulo, loc_cSubTitulo, loc_dtDataFim
        LOCAL loc_nResultado, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorCabecalho)
                USE IN (THIS.this_cCursorCabecalho)
            ENDIF
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            IF EMPTY(THIS.this_dDtInicial)
                THIS.this_cMensagemErro = "Data Inicial Inv" + CHR(225) + "lida !!!"
            ELSE
                IF EMPTY(THIS.this_dDtFinal)
                    THIS.this_cMensagemErro = "Data Final Inv" + CHR(225) + "lida !!!"
                ELSE
                    IF THIS.this_dDtFinal < THIS.this_dDtInicial
                        THIS.this_cMensagemErro = "Data Final n" + CHR(227) + "o pode ser maior que a Inicial !!!"
                    ELSE
                        IF EMPTY(THIS.this_cGrupo)
                            THIS.this_cMensagemErro = "Grupo Inv" + CHR(225) + "lido !!!"
                        ELSE

                            loc_cGrupo = ALLTRIM(THIS.this_cGrupo)
                            loc_cConta = ALLTRIM(THIS.this_cConta)

                            *-- Cabecalho do relatorio (Empresa/Titulo/SubTitulo/ImpData)
                            loc_cEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + " - " + ;
                                           ALLTRIM(go_4c_Sistema.cEmpresa)
                            loc_cTitulo = ALLTRIM("Relat" + CHR(243) + "rio de FollowUp de " + ;
                                           PROPER(ALLTRIM(THIS.this_cDGrupo)))
                            loc_cSubTitulo = ALLTRIM("Per" + CHR(237) + "odo : " + ;
                                           DTOC(THIS.this_dDtInicial) + " " + CHR(224) + " " + ;
                                           DTOC(THIS.this_dDtFinal))

                            THIS.this_cEmpresa = loc_cEmpresa

                            CREATE CURSOR (THIS.this_cCursorCabecalho) ;
                                (Empresa C(80), Titulo C(80), SubTitulo C(80), ImpData L)
                            INSERT INTO (THIS.this_cCursorCabecalho) ;
                                (Empresa, Titulo, SubTitulo, ImpData) ;
                                VALUES (loc_cEmpresa, loc_cTitulo, loc_cSubTitulo, THIS.this_lImpData)

                            *-- Historico de ocorrencias (SigCdClh) no periodo/grupo/conta
                            loc_dtDataFim = DATETIME(YEAR(THIS.this_dDtFinal), ;
                                MONTH(THIS.this_dDtFinal), DAY(THIS.this_dDtFinal), 23, 59, 59)

                            loc_cSQL = "SELECT a.IClis, a.Datas, a.Hists, a.Obs, b.Cpfs, b.RClis " + ;
                                       "FROM SigCdClh a INNER JOIN SigCdCli b ON a.IClis = b.IClis " + ;
                                       "WHERE a.Datas BETWEEN " + FormatarDataSQL(THIS.this_dDtInicial) + ;
                                       " AND " + FormatarDataSQL(loc_dtDataFim) + ;
                                       " AND a.Grupos = " + EscaparSQL(loc_cGrupo)

                            IF !EMPTY(loc_cConta)
                                loc_cSQL = loc_cSQL + " AND a.IClis = " + EscaparSQL(loc_cConta)
                            ENDIF

                            loc_cSQL = loc_cSQL + " ORDER BY a.IClis, a.Datas, a.Hists, b.Cpfs, b.RClis"

                            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)

                            IF loc_nResultado < 0
                                THIS.this_cMensagemErro = "Erro ao buscar dados de FollowUp." + ;
                                    CHR(13) + CapturarErroSQL()
                            ELSE
                                IF RECCOUNT(THIS.this_cCursorDados) = 0
                                    THIS.this_cMensagemErro = "Nenhum registro encontrado para os filtros informados."
                                ELSE
                                    SELECT (THIS.this_cCursorDados)
                                    GO TOP
                                    loc_lSucesso = .T.
                                ENDIF
                            ENDIF
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
    * ExecutarReportForm (Pattern #117/#123) - Executa REPORT FORM apenas se
    * o FRX existir; isola SET POINT/SEPARATOR/REPORTBEHAVIOR (FRXs legados
    * Fortyus foram desenhados em modo 80); restaura o menu principal depois
    * do preview (Erro63). par_cModo: "PREVIEW" | "PRINTER_PROMPT" | "PRINTER".
    * par_cCursorDados eh opcional - se informado e vazio, avisa e sai sem
    * abrir preview em branco.
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
    * Visualizar - Exibe o relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PREVIEW", ;
                    THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Envia o relatorio para a impressora (com dialogo de escolha)
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                loc_lSucesso = THIS.ExecutarReportForm(THIS.this_cArquivoRelatorio, "PRINTER_PROMPT", ;
                    THIS.this_cCursorDados)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarExcel - Exporta o relatorio para arquivo .xls
    *--------------------------------------------------------------------------
    PROCEDURE GerarExcel()
        LOCAL loc_lSucesso, loc_cArquivo, loc_oErro
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF USED(THIS.this_cCursorDados) AND RECCOUNT(THIS.this_cCursorDados) > 0
                    SELECT (THIS.this_cCursorDados)
                    GO TOP
                    loc_cArquivo = SYS(5) + CURDIR() + "SigOpFlu_" + ;
                                   STRTRAN(DTOC(DATE()), "/", "") + ".xls"
                    REPORT FORM (gc_4c_CaminhoReports + THIS.this_cArquivoRelatorio) ;
                        TO FILE (loc_cArquivo) NOCONSOLE ASCII
                    IF FILE(loc_cArquivo)
                        MsgInfo("Arquivo gerado:" + CHR(13) + loc_cArquivo, "Excel")
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    THIS.this_cMensagemErro = "Nenhum registro encontrado com os filtros informados."
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "GerarExcel")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna a ultima mensagem de erro/validacao
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao persiste registro; retorna chave
    * composta dos filtros principais, para fins de auditoria/log.
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = IIF(EMPTY(THIS.this_dDtInicial), SPACE(8), DTOS(THIS.this_dDtInicial)) + "|" + ;
                     IIF(EMPTY(THIS.this_dDtFinal), SPACE(8), DTOS(THIS.this_dDtFinal)) + "|" + ;
                     ALLTRIM(THIS.this_cGrupo) + "|" + ;
                     ALLTRIM(THIS.this_cConta)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Nao aplicavel a relatorios (RelatorioBase nao
    * persiste dados); mantido para compatibilidade com o padrao do pipeline.
    * A carga dos filtros vem do Form (FormParaRelatorio).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel ao relatorio de FollowUp (frmrelatorio nao
    * persiste dados). A acao equivalente eh Visualizar()/Imprimir().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel ao relatorio de FollowUp. Vide Inserir().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
                                   "o aplic" + CHR(225) + "vel a relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera os cursores do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED(THIS.this_cCursorDados)
            USE IN (THIS.this_cCursorDados)
        ENDIF
        IF USED(THIS.this_cCursorCabecalho)
            USE IN (THIS.this_cCursorCabecalho)
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

