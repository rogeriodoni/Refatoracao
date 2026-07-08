# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1549 linhas total):

*-- Linhas 31 a 207:
31:     *==========================================================================
32:     * Init - Aceita parametro de operacao antes de chamar FormBase.Init
33:     *==========================================================================
34:     PROCEDURE Init(par_cOperacao)
35:         IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao)
36:             THIS.this_cOperacao = UPPER(ALLTRIM(par_cOperacao))
37:         ENDIF
38:         RETURN DODEFAULT()
39:     ENDPROC
40: 
41:     *==========================================================================
42:     * InicializarForm - Construcao completa do form
43:     *==========================================================================
44:     PROTECTED PROCEDURE InicializarForm()
45:         LOCAL loc_lSucesso, loc_oErro
46:         loc_lSucesso = .F.
47: 
48:         TRY
49:             *-- Criar BO
50:             THIS.this_oBusinessObject = CREATEOBJECT("sigopdivBO")
51:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
52:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopdiv.", "Erro")
53:                 loc_lSucesso = .F.
54:             ENDIF
55: 
56:             *-- Validar DivOps em SigCdPam
57:             LOCAL loc_cSQL
58:             loc_cSQL = "SELECT DivOps FROM SigCdPam"
59:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamDiv") > 0
60:                 SELECT cursor_4c_PamDiv
61:                 GO TOP
62:                 IF EMPTY(ALLTRIM(cursor_4c_PamDiv.DivOps))
63:                     USE IN cursor_4c_PamDiv
64:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o de Divis" + CHR(227) + ;
65:                              "o de Op n" + CHR(227) + "o Configurada nos par" + CHR(226) + ;
66:                              "metros do sistema...", "Configura" + CHR(231) + CHR(227) + "o")
67:                     loc_lSucesso = .F.
68:                 ENDIF
69:                 USE IN cursor_4c_PamDiv
70:             ENDIF
71: 
72:             *-- Definir Caption conforme operacao
73:             IF THIS.this_cOperacao = "R"
74:                 THIS.Caption = "Reinicia Industrializa" + CHR(231) + CHR(227) + "o"
75:             ELSE
76:                 THIS.Caption = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
77:             ENDIF
78: 
79:             *-- Criar cursores de trabalho (privados desta sessao de dados)
80:             SET NULL ON
81:             CREATE CURSOR Temp_DivOp ;
82:                 (Qtds N(12,3), QtdEtiqs N(5,0), QtdDivs N(12,3), Dopes C(20), ;
83:                  Numes N(6,0), Dataes D, Obss M NULL, Nops N(10,0), SeqDivs N(3,0), ;
84:                  Cpros C(14), CodCors C(4), CodTams C(4), Empds C(3), Dpros C(65), ;
85:                  Notas C(6), Contas C(10), Citens N(10,0), Pesos N(12,3))
86:             CREATE CURSOR Temporario ;
87:                 (Qtds N(12,3), Dopes C(20), Numes N(6,0), Dataes D, Obss M NULL, ;
88:                  Nops N(10,0), SeqDivs N(3,0), Cpros C(14), CodCors C(4), CodTams C(4), ;
89:                  Empds C(3), Dpros C(65), Notas C(6), Contas C(10), Pesos N(9,3))
90:             INDEX ON Nops TAG Nops FOR Qtds > 0
91:             SET NULL OFF
92: 
93:             *-- Criar xNensi com estrutura identica a SigCdNei
94:             IF gnConnHandle > 0
95:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCdNei", ;
96:                            "cursor_4c_NensiStruct") > 0
97:                     DIMENSION loc_aNensiFields[1]
98:                     AFIELDS(loc_aNensiFields, "cursor_4c_NensiStruct")
99:                     CREATE CURSOR xNensi FROM ARRAY loc_aNensiFields
100:                     USE IN cursor_4c_NensiStruct
101:                 ENDIF
102:             ENDIF
103: 
104:             *-- Construir todos os controles UI
105:             THIS.ConfigurarControles()
106: 
107:             *-- Inicializar estado visual do form (Grade principal visivel)
108:             THIS.ConfigurarPaginaLista()
109: 
110:             *-- Propagar Caption para labels de titulo
111:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
112:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
113: 
114:             *-- BINDEVENT: Get_OP
115:             *-- Valid nao funciona via BINDEVENT em TextBox; usar KeyPress ENTER/TAB
116:             BINDEVENT(THIS.txt_4c_Op, "When",     THIS, "GetOpWhen")
117:             BINDEVENT(THIS.txt_4c_Op, "KeyPress",  THIS, "GetOpKeyPress")
118:             BINDEVENT(THIS.txt_4c_Op, "LostFocus", THIS, "GetOpLostFocus")
119: 
120:             *-- BINDEVENT: CommandGroups
121:             BINDEVENT(THIS.grp_4c_GrupoSalva, "Click", THIS, "GrupoSalvaClick")
122:             BINDEVENT(THIS.grp_4c_GrupoConf,  "Click", THIS, "GrupoConfClick")
123: 
124:             *-- BINDEVENT: Grade (principal) eventos
125:             BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")
126: 
127:             *-- BINDEVENT: Grade2 (resultado) eventos
128:             BINDEVENT(THIS.grd_4c_Grade2, "AfterRowColChange", THIS, "Grade2AfterRowColChange")
129: 
130:             *-- BINDEVENT: colunas editaveis da Grade (QtdDivs e QtdEtiqs)
131:             *-- Regra VFP9: BINDEVENT "Valid" nao funciona em TextBox.
132:             *-- Usar KeyPress (ENTER=13/TAB=9) para simular Valid + LostFocus para rede de seguranca.
133:             BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "KeyPress",  THIS, "GradeCol4KeyPress")
134:             BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "LostFocus", THIS, "GradeCol4LostFocus")
135:             BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "When",      THIS, "GradeCol4When")
136:             BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress",  THIS, "GradeCol2KeyPress")
137:             BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "LostFocus", THIS, "GradeCol2LostFocus")
138:             BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "When",      THIS, "GradeCol2When")
139: 
140:             *-- BINDEVENT: EditBoxes LostFocus
141:             BINDEVENT(THIS.edt_4c_MemoObs, "LostFocus", THIS, "MemoObsLostFocus")
142:             BINDEVENT(THIS.edt_4c_Obss,    "LostFocus", THIS, "ObssLostFocus")
143: 
144:             *-- Ajustar caption do botao Gerar para modo Reinicia
145:             IF THIS.this_cOperacao = "R"
146:                 THIS.grp_4c_GrupoSalva.Buttons(1).Caption = "\<Reinicia"
147:             ENDIF
148: 
149:             *-- Tornar todos os controles visiveis (exceto flutuantes)
150:             THIS.TornarControlesVisiveis(THIS)
151: 
152:             loc_lSucesso = .T.
153: 
154:         CATCH TO loc_oErro
155:             MsgErro(loc_oErro.Message, "Erro em InicializarForm")
156:         ENDTRY
157: 
158:         RETURN loc_lSucesso
159:     ENDPROC
160: 
161:     *==========================================================================
162:     * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
163:     * Picture de fundo + container cabecalho (cntSombra) com labels de titulo.
164:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
165:     * estrutura fixa do topo (equivalente ao "frame" da tela).
166:     *==========================================================================
167:     PROTECTED PROCEDURE ConfigurarPageFrame()
168:         *-- Imagem de fundo (pixel-perfect do legado)
169:         THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
170: 
171:         *----------------------------------------------------------------------
172:         * Container cabecalho (cntSombra): fundo cinza + labels de titulo
173:         *----------------------------------------------------------------------
174:         THIS.AddObject("cnt_4c_Sombra", "Container")
175:         WITH THIS.cnt_4c_Sombra
176:             .Top         = 0
177:             .Left        = 0
178:             .Width       = 828
179:             .Height      = 80
180:             .BackColor   = RGB(100, 100, 100)
181:             .BorderWidth = 0
182:             .Visible     = .T.
183: 
184:             .AddObject("lbl_4c_Sombra", "Label")
185:             WITH .lbl_4c_Sombra
186:                 .Top      = 18
187:                 .Left     = 10
188:                 .Width    = 769
189:                 .Height   = 40
190:                 .FontBold = .T.
191:                 .FontName = "Tahoma"
192:                 .FontSize = 18
193:                 .BackStyle = 0
194:                 .ForeColor = RGB(0, 0, 0)
195:                 .WordWrap  = .T.
196:                 .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
197:                 .Visible   = .T.
198:             ENDWITH
199: 
200:             .AddObject("lbl_4c_Titulo", "Label")
201:             WITH .lbl_4c_Titulo
202:                 .Top      = 19
203:                 .Left     = 10
204:                 .Width    = 769
205:                 .Height   = 46
206:                 .FontBold = .T.
207:                 .FontName = "Tahoma"

*-- Linhas 218 a 261:
218:     *==========================================================================
219:     * ConfigurarControles - Cria todos os objetos visuais do form
220:     *==========================================================================
221:     PROTECTED PROCEDURE ConfigurarControles()
222:         *-- Construir frame (picture + cabecalho)
223:         THIS.ConfigurarPageFrame()
224: 
225:         *-- Construir campos principais (labels, textboxes, editboxes)
226:         THIS.ConfigurarCamposPrincipais()
227: 
228:         *----------------------------------------------------------------------
229:         * CommandGroup Grupo_Salva: "Gerar O.P." + "Encerrar"
230:         *----------------------------------------------------------------------
231:         THIS.AddObject("grp_4c_GrupoSalva", "CommandGroup")
232:         WITH THIS.grp_4c_GrupoSalva
233:             .Top           = -1
234:             .Left          = 673
235:             .Width         = 160
236:             .Height        = 85
237:             .AutoSize      = .T.
238:             .ButtonCount   = 2
239:             .BorderStyle   = 0
240:             .SpecialEffect = 1
241:             .BorderColor   = RGB(100, 100, 100)
242:             .Themes        = .F.
243:             .Visible       = .T.
244:         ENDWITH
245:         WITH THIS.grp_4c_GrupoSalva.Buttons(1)
246:             .Top             = 5
247:             .Left            = 5
248:             .Height          = 75
249:             .Width           = 75
250:             .Caption         = "\<Gerar O.P."
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .FontName        = "Tahoma"
254:             .FontSize        = 8
255:             .ForeColor       = RGB(90, 90, 90)
256:             .BackColor       = RGB(255, 255, 255)
257:             .Themes          = .F.
258:             .PicturePosition = 13
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
260:         ENDWITH
261:         WITH THIS.grp_4c_GrupoSalva.Buttons(2)

*-- Linhas 339 a 382:
339:     * Labels (OP/Produto), TextBoxes de entrada (Get_OP/Get_Produto) e EditBoxes
340:     * de observacao (Get_obss/fwmemo_obs). Chamado por ConfigurarControles.
341:     *==========================================================================
342:     PROTECTED PROCEDURE ConfigurarCamposPrincipais()
343:         *----------------------------------------------------------------------
344:         * Label "OP :"
345:         *----------------------------------------------------------------------
346:         THIS.AddObject("lbl_4c_Op", "Label")
347:         WITH THIS.lbl_4c_Op
348:             .Top       = 87
349:             .Left      = 41
350:             .Width     = 23
351:             .Height    = 15
352:             .Caption   = "OP :"
353:             .ForeColor = RGB(90, 90, 90)
354:             .BackStyle = 0
355:             .Visible   = .T.
356:         ENDWITH
357: 
358:         *----------------------------------------------------------------------
359:         * TextBox Get_OP: entrada do numero da OP
360:         *----------------------------------------------------------------------
361:         THIS.AddObject("txt_4c_Op", "TextBox")
362:         WITH THIS.txt_4c_Op
363:             .Top           = 83
364:             .Left          = 67
365:             .Width         = 108
366:             .Height        = 23
367:             .Alignment     = 3
368:             .Format        = "K"
369:             .InputMask     = "999999999999"
370:             .MaxLength     = 12
371:             .SpecialEffect = 1
372:             .BorderColor   = RGB(100, 100, 100)
373:             .Value         = " "
374:             .Visible       = .T.
375:         ENDWITH
376: 
377:         *----------------------------------------------------------------------
378:         * Label "Produto :"
379:         *----------------------------------------------------------------------
380:         THIS.AddObject("lbl_4c_Produto", "Label")
381:         WITH THIS.lbl_4c_Produto
382:             .Top       = 87

*-- Linhas 445 a 488:
445:     * 7 colunas: Pedido | Cliente | Cor | Tam | Qtd.Op | QtdDivs | Quantidade
446:     * Nota: Column2=QtdEtiqs, Column4=QtdDivs sao editaveis pelo usuario
447:     *==========================================================================
448:     PROTECTED PROCEDURE ConfigurarGrade()
449:         LOCAL loc_oGrd
450:         THIS.AddObject("grd_4c_Grade", "Grid")
451:         loc_oGrd = THIS.grd_4c_Grade
452:         WITH loc_oGrd
453:             .Top           = 121
454:             .Left          = 11
455:             .Width         = 626
456:             .Height        = 293
457:             .FontName      = "Arial"
458:             .FontSize      = 8
459:             .ColumnCount   = 7
460:             .DeleteMark    = .F.
461:             .GridLines     = 3
462:             .GridLineWidth = 1
463:             .GridLineColor = RGB(238, 238, 238)
464:             .HeaderHeight  = 17
465:             .RecordMark    = .F.
466:             .RowHeight     = 17
467:             .ScrollBars    = 2
468:             .ForeColor     = RGB(0, 0, 0)
469:             .BackColor     = RGB(255, 255, 255)
470:             .RecordSource  = "Temp_DivOp"
471:             .Visible       = .T.
472:         ENDWITH
473: 
474:         *-- Column1: Pedido (expressao Dopes + Numes - readonly)
475:         WITH loc_oGrd.Column1
476:             .Header1.Caption     = "Pedido"
477:             .Header1.Alignment   = 2
478:             .Header1.BackColor   = RGB(192, 192, 192)
479:             .Text1.ControlSource = "ALLTRIM(Temp_DivOp.Dopes)+' '+ALLTRIM(STR(Temp_DivOp.Numes,6))"
480:             .Text1.ReadOnly      = .T.
481:             .Text1.BorderStyle   = 0
482:             .Text1.Alignment     = 0
483:             .Text1.Margin        = 0
484:             .Width               = 160
485:             .Movable             = .F.
486:             .Resizable           = .F.
487:             .ReadOnly            = .T.
488:         ENDWITH

*-- Linhas 588 a 631:
588:     * ConfigurarGrade2 - Grade resultado (Temporario - oculto ate geracao)
589:     * 7 colunas: O.P. | Pedido | Cliente | Cor | Tam | Quantidade | Peso
590:     *==========================================================================
591:     PROTECTED PROCEDURE ConfigurarGrade2()
592:         LOCAL loc_oGrd
593:         THIS.AddObject("grd_4c_Grade2", "Grid")
594:         loc_oGrd = THIS.grd_4c_Grade2
595:         WITH loc_oGrd
596:             .Top           = 121
597:             .Left          = 11
598:             .Width         = 626
599:             .Height        = 293
600:             .FontName      = "Arial"
601:             .FontSize      = 8
602:             .ColumnCount   = 7
603:             .DeleteMark    = .F.
604:             .RecordMark    = .F.
605:             .GridLineWidth = 1
606:             .GridLineColor = RGB(136, 189, 188)
607:             .HeaderHeight  = 17
608:             .RowHeight     = 17
609:             .ScrollBars    = 2
610:             .ForeColor     = RGB(0, 0, 0)
611:             .BackColor     = RGB(255, 255, 255)
612:             .RecordSource  = "Temporario"
613:             .ReadOnly      = .T.
614:             .Enabled       = .F.
615:             .Visible       = .F.
616:         ENDWITH
617: 
618:         *-- Column1: Pedido
619:         WITH loc_oGrd.Column1
620:             .Header1.Caption     = "Pedido"
621:             .Header1.Alignment   = 2
622:             .Header1.BackColor   = RGB(192, 192, 192)
623:             .Text1.ControlSource = "ALLTRIM(Temporario.Dopes)+' '+ALLTRIM(STR(Temporario.Numes,6))"
624:             .Text1.ReadOnly      = .T.
625:             .Text1.Alignment     = 0
626:             .Text1.BorderStyle   = 0
627:             .Text1.Margin        = 0
628:             .Text1.Enabled       = .F.
629:             .Width               = 205
630:             .ColumnOrder         = 2
631:             .Movable             = .F.

*-- Linhas 745 a 939:
745:     *==========================================================================
746:     * ConfigurarPaginaLista - Define estado inicial do form operacional:
747:     * Grade principal visivel, Grade2 oculta, GrupoSalva ativo.
748:     * Chamado em InicializarForm e ao retornar do estado de revisao.
749:     *==========================================================================
750:     PROCEDURE ConfigurarPaginaLista()
751:         WITH THIS.grd_4c_Grade
752:             .Enabled = .T.
753:             .Visible = .T.
754:         ENDWITH
755:         WITH THIS.grd_4c_Grade2
756:             .Enabled = .F.
757:             .Visible = .F.
758:         ENDWITH
759:         WITH THIS.edt_4c_Obss
760:             .Enabled = .T.
761:             .Visible = .T.
762:         ENDWITH
763:         WITH THIS.edt_4c_MemoObs
764:             .Enabled = .F.
765:             .Visible = .F.
766:         ENDWITH
767:         WITH THIS.grp_4c_GrupoSalva
768:             .Enabled = .T.
769:             .Visible = .T.
770:         ENDWITH
771:         WITH THIS.grp_4c_GrupoConf
772:             .Enabled = .F.
773:             .Visible = .F.
774:         ENDWITH
775:     ENDPROC
776: 
777:     *==========================================================================
778:     * AlternarPagina - Alterna estado visual do form operacional
779:     * par_nPagina: 1 = Entrada (Grade principal + GrupoSalva)
780:     *              2 = Revisao (Grade2 resultado + GrupoConf)
781:     * Sobrescreve FormBase.AlternarPagina que usa pgf_4c_Paginas inexistente.
782:     *==========================================================================
783:     PROCEDURE AlternarPagina(par_nPagina)
784:         DO CASE
785:         CASE par_nPagina = 1
786:             THIS.ConfigurarPaginaLista()
787:             THIS.grd_4c_Grade.Refresh()
788:         CASE par_nPagina = 2
789:             WITH THIS.grd_4c_Grade
790:                 .Enabled = .F.
791:                 .Visible = .F.
792:             ENDWITH
793:             WITH THIS.grd_4c_Grade2
794:                 .Enabled = .T.
795:                 .Visible = .T.
796:                 .Refresh()
797:             ENDWITH
798:             WITH THIS.edt_4c_Obss
799:                 .Enabled = .F.
800:                 .Visible = .F.
801:             ENDWITH
802:             WITH THIS.edt_4c_MemoObs
803:                 .Enabled = .T.
804:                 .Visible = .T.
805:             ENDWITH
806:             WITH THIS.grp_4c_GrupoSalva
807:                 .Enabled = .F.
808:                 .Visible = .F.
809:             ENDWITH
810:             WITH THIS.grp_4c_GrupoConf
811:                 .Enabled = .T.
812:                 .Visible = .T.
813:             ENDWITH
814:         ENDCASE
815:     ENDPROC
816: 
817:     *==========================================================================
818:     * GetOpWhen - Get_OP.When
819:     * Permite digitacao apenas enquanto Temporario estiver vazio
820:     *==========================================================================
821:     PROCEDURE GetOpWhen()
822:         RETURN RECCOUNT("Temporario") = 0
823:     ENDPROC
824: 
825:     *==========================================================================
826:     * GetOpKeyPress - Get_OP.KeyPress
827:     * Dispara GetOpValid ao pressionar ENTER(13) ou TAB(9)
828:     *==========================================================================
829:     PROCEDURE GetOpKeyPress(par_nKeyCode, par_nShiftAltCtrl)
830:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
831:             THIS.GetOpValid()
832:         ENDIF
833:     ENDPROC
834: 
835:     *==========================================================================
836:     * GetOpValid - Valida OP e carrega Temp_DivOp / xNensi via BO.BuscarOP
837:     *==========================================================================
838:     PROCEDURE GetOpValid()
839:         LOCAL loc_nOp, loc_lSucesso, loc_oErro
840:         loc_lSucesso = .F.
841: 
842:         IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
843:             RETURN .T.
844:         ENDIF
845: 
846:         IF LEN(ALLTRIM(THIS.txt_4c_Op.Value)) > 10
847:             THIS.txt_4c_Op.Value = RIGHT(ALLTRIM(THIS.txt_4c_Op.Value), 10)
848:         ENDIF
849: 
850:         loc_nOp = VAL(THIS.txt_4c_Op.Value)
851: 
852:         TRY
853:             loc_lSucesso = THIS.this_oBusinessObject.BuscarOP(loc_nOp)
854:         CATCH TO loc_oErro
855:             MsgErro(loc_oErro.Message, "Erro em GetOpValid")
856:             loc_lSucesso = .F.
857:         ENDTRY
858: 
859:         IF loc_lSucesso
860:             THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
861:             THIS.grd_4c_Grade.Refresh()
862:         ELSE
863:             THIS.txt_4c_Op.Value      = " "
864:             THIS.txt_4c_Produto.Value = " "
865:         ENDIF
866: 
867:         RETURN loc_lSucesso
868:     ENDPROC
869: 
870:     *==========================================================================
871:     * GetOpLostFocus - Get_OP.LostFocus
872:     * Se OP valida carregada, move foco para coluna QtdEtiqs da grade
873:     *==========================================================================
874:     PROCEDURE GetOpLostFocus()
875:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND ;
876:            USED("Temp_DivOp") AND !EOF("Temp_DivOp")
877:             THIS.grd_4c_Grade.Column2.Text1.SetFocus()
878:         ENDIF
879:     ENDPROC
880: 
881:     *==========================================================================
882:     * GrupoSalvaClick - Grupo_Salva.Click
883:     * Botao 1 (Gerar O.P.): valida e chama BO.GerarNovaOP
884:     * Botao 2 (Encerrar): rollback e fecha
885:     *==========================================================================
886:     PROCEDURE GrupoSalvaClick()
887:         LOCAL loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs
888:         LOCAL loc_lSucesso, loc_oErro
889: 
890:         IF THIS.grp_4c_GrupoSalva.Value = 2
891:             ON KEY LABEL ENTER
892:             THIS.this_oBusinessObject.RollbackTransacao()
893:             THIS.Release()
894:             RETURN
895:         ENDIF
896: 
897:         *-- Botao 1: Gerar O.P.
898:         IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
899:             MsgAviso("OP n" + CHR(227) + "o informada!!", "Aviso")
900:             THIS.txt_4c_Op.SetFocus()
901:             RETURN
902:         ENDIF
903: 
904:         loc_nOp       = VAL(THIS.txt_4c_Op.Value)
905:         loc_nQtds     = 0
906:         loc_nQtdDivs  = 0
907:         loc_nQtdEtiqs = 0
908: 
909:         *-- Somar quantidades de Temp_DivOp para validacao
910:         IF USED("Temp_DivOp") AND RECCOUNT("Temp_DivOp") > 0
911:             SELECT SUM(Qtds) AS SQtds, SUM(QtdDivs) AS SQtdDivs, SUM(QtdEtiqs) AS SQtdEtiqs ;
912:                 FROM Temp_DivOp INTO CURSOR cursor_4c_SumTmpDiv
913:             SELECT cursor_4c_SumTmpDiv
914:             GO TOP
915:             loc_nQtds     = NVL(cursor_4c_SumTmpDiv.SQtds,     0)
916:             loc_nQtdDivs  = NVL(cursor_4c_SumTmpDiv.SQtdDivs,  0)
917:             loc_nQtdEtiqs = NVL(cursor_4c_SumTmpDiv.SQtdEtiqs, 0)
918:             USE IN cursor_4c_SumTmpDiv
919:         ENDIF
920: 
921:         ON KEY LABEL ENTER
922: 
923:         *-- Delegar para BO
924:         loc_lSucesso = .F.
925:         TRY
926:             loc_lSucesso = THIS.this_oBusinessObject.GerarNovaOP(;
927:                 THIS.this_cOperacao, loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs)
928:         CATCH TO loc_oErro
929:             MsgErro(loc_oErro.Message, "Erro em GrupoSalvaClick")
930:         ENDTRY
931: 
932:         IF loc_lSucesso
933:             IF THIS.this_cOperacao = "D"
934:                 *-- Divisao: ir para estado de revisao (Grade2 + GrupoConf)
935:                 IF USED("Temp_DivOp")
936:                     SELECT Temp_DivOp
937:                     ZAP
938:                 ENDIF
939:                 SELECT Temporario

*-- Linhas 977 a 1267:
977:     * Botao 1 (Confirmar): persiste Obss e faz COMMIT via BO
978:     * Botao 2 (Encerrar): rollback e fecha
979:     *==========================================================================
980:     PROCEDURE GrupoConfClick()
981:         LOCAL loc_lSucesso, loc_oErro
982: 
983:         IF THIS.grp_4c_GrupoConf.Value = 2
984:             ON KEY LABEL ENTER
985:             THIS.this_oBusinessObject.RollbackTransacao()
986:             THIS.Release()
987:             RETURN
988:         ENDIF
989: 
990:         *-- Botao 1: Confirmar
991:         loc_lSucesso = .F.
992:         TRY
993:             loc_lSucesso = THIS.this_oBusinessObject.ConfirmarGravacao()
994:         CATCH TO loc_oErro
995:             MsgErro(loc_oErro.Message, "Erro em GrupoConfClick")
996:         ENDTRY
997: 
998:         IF loc_lSucesso
999:             IF USED("Temporario")
1000:                 SELECT Temporario
1001:                 ZAP
1002:             ENDIF
1003:             THIS.txt_4c_Op.Value      = " "
1004:             THIS.txt_4c_Produto.Value = " "
1005:             THIS.AlternarPagina(1)
1006: 
1007:             IF !THIS.this_lAutomatico
1008:                 THIS.txt_4c_Op.SetFocus()
1009:             ENDIF
1010:             THIS.Refresh()
1011:         ENDIF
1012:     ENDPROC
1013: 
1014:     *==========================================================================
1015:     * GradeAfterRowColChange - Grade.AfterRowColChange
1016:     * Atualiza editbox de observacao ao navegar entre linhas
1017:     *==========================================================================
1018:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1019:         THIS.edt_4c_Obss.Refresh()
1020:     ENDPROC
1021: 
1022:     *==========================================================================
1023:     * Grade2AfterRowColChange - Grade2.AfterRowColChange
1024:     * Atualiza editbox de observacao ao navegar entre OPs geradas
1025:     *==========================================================================
1026:     PROCEDURE Grade2AfterRowColChange(par_nColIndex)
1027:         THIS.edt_4c_MemoObs.Refresh()
1028:     ENDPROC
1029: 
1030:     *==========================================================================
1031:     * GradeCol4Valid - Column4 (QtdDivs) Valid
1032:     * Regras: QtdDivs e QtdEtiqs mutuamente exclusivos; nao pode exceder Qtds
1033:     *==========================================================================
1034:     PROCEDURE GradeCol4Valid()
1035:         LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
1036:         loc_lOk       = .T.
1037:         loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
1038:         loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value
1039: 
1040:         IF loc_nValEtiq > 0 AND loc_nValDivisao > 0
1041:             MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
1042:             THIS.grd_4c_Grade.Column4.Text1.Value = 0
1043:             loc_lOk = .F.
1044:         ENDIF
1045: 
1046:         IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1047:             IF loc_nValDivisao > Temp_DivOp.Qtds
1048:                 MsgAviso("Quantidade a dividir n" + CHR(227) + ;
1049:                          "o pode ser maior que a quantidade do Pedido...", "Aviso")
1050:                 THIS.grd_4c_Grade.Column4.Text1.Value = 0
1051:                 loc_lOk = .F.
1052:             ENDIF
1053:         ENDIF
1054: 
1055:         RETURN loc_lOk
1056:     ENDPROC
1057: 
1058:     *==========================================================================
1059:     * GradeCol4When - Column4 (QtdDivs) When
1060:     * Define ENTER para avan?ar linha (DNARROW) quando em QtdDivs
1061:     *==========================================================================
1062:     PROCEDURE GradeCol4When()
1063:         ON KEY LABEL ENTER KEYBOARD "{DNARROW}"
1064:         RETURN .T.
1065:     ENDPROC
1066: 
1067:     *==========================================================================
1068:     * GradeCol4KeyPress - Column4 (QtdDivs) KeyPress
1069:     * Simula Valid em ENTER(13)/TAB(9). Retorna 0 via binding de Valid nao
1070:     * funciona em TextBox sob BINDEVENT; aqui resetamos o valor se invalido
1071:     * e deixamos a tecla fluir para o VFP9 processar navegacao.
1072:     *==========================================================================
1073:     PROCEDURE GradeCol4KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1074:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1075:             THIS.GradeCol4Valid()
1076:         ENDIF
1077:     ENDPROC
1078: 
1079:     *==========================================================================
1080:     * GradeCol4LostFocus - Column4 (QtdDivs) LostFocus
1081:     * Rede de seguranca: aplica validacao ao sair da celula por click/mouse
1082:     *==========================================================================
1083:     PROCEDURE GradeCol4LostFocus()
1084:         THIS.GradeCol4Valid()
1085:     ENDPROC
1086: 
1087:     *==========================================================================
1088:     * GradeCol2KeyPress - Column2 (QtdEtiqs) KeyPress
1089:     *==========================================================================
1090:     PROCEDURE GradeCol2KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1091:         IF par_nKeyCode = 13 OR par_nKeyCode = 9
1092:             THIS.GradeCol2Valid()
1093:         ENDIF
1094:     ENDPROC
1095: 
1096:     *==========================================================================
1097:     * GradeCol2LostFocus - Column2 (QtdEtiqs) LostFocus
1098:     *==========================================================================
1099:     PROCEDURE GradeCol2LostFocus()
1100:         THIS.GradeCol2Valid()
1101:     ENDPROC
1102: 
1103:     *==========================================================================
1104:     * TornarControlesVisiveis - Torna visiveis todos os controles do form
1105:     * recursivamente, EXCETO containers/controles flutuantes que devem
1106:     * permanecer Visible=.F. ate serem alternados por AlternarPagina(2).
1107:     *
1108:     * Controles flutuantes (estado inicial oculto):
1109:     *   - grd_4c_Grade2      : Grade resultado, aparece apos Gerar O.P.
1110:     *   - edt_4c_MemoObs     : EditBox de obs das OPs geradas
1111:     *   - grp_4c_GrupoConf   : Botoes Confirmar/Encerrar (modo revisao)
1112:     *==========================================================================
1113:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1114:         LOCAL loc_i, loc_j, loc_oCtrl, loc_cNome
1115: 
1116:         IF VARTYPE(par_oContainer) # "O"
1117:             RETURN
1118:         ENDIF
1119: 
1120:         FOR loc_i = 1 TO par_oContainer.ControlCount
1121:             loc_oCtrl = par_oContainer.Controls(loc_i)
1122:             loc_cNome = UPPER(loc_oCtrl.Name)
1123: 
1124:             *-- Controles flutuantes: permanecem ocultos (alternados via AlternarPagina)
1125:             *-- CNT_4C_SOMBRA: visibilidade gerenciada por ConfigurarPageFrame
1126:             IF INLIST(loc_cNome, ;
1127:                     "GRD_4C_GRADE2",    ;
1128:                     "EDT_4C_MEMOOBS",   ;
1129:                     "GRP_4C_GRUPOCONF", ;
1130:                     "CNT_4C_SOMBRA")
1131:                 LOOP
1132:             ENDIF
1133: 
1134:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1135:                 loc_oCtrl.Visible = .T.
1136:             ENDIF
1137: 
1138:             *-- Recursao em Containers
1139:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
1140:                 IF loc_oCtrl.ControlCount > 0
1141:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1142:                 ENDIF
1143:             ENDIF
1144: 
1145:             *-- Recursao em Pages de PageFrame
1146:             IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
1147:                 FOR loc_j = 1 TO loc_oCtrl.PageCount
1148:                     THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
1149:                 ENDFOR
1150:             ENDIF
1151:         ENDFOR
1152: 
1153:         loc_oCtrl = .NULL.
1154:     ENDPROC
1155: 
1156:     *==========================================================================
1157:     * GradeCol2Valid - Column2 (QtdEtiqs) Valid
1158:     * Regras: mutuamente exclusivo com QtdDivs; > 1; nao pode exceder Qtds
1159:     *==========================================================================
1160:     PROCEDURE GradeCol2Valid()
1161:         LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
1162:         loc_lOk         = .T.
1163:         loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
1164:         loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value
1165: 
1166:         IF loc_nValDivisao > 0 AND loc_nValEtiq > 0
1167:             MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
1168:             THIS.grd_4c_Grade.Column2.Text1.Value = 0
1169:             loc_lOk = .F.
1170:         ENDIF
1171: 
1172:         IF loc_lOk AND loc_nValEtiq = 1
1173:             MsgAviso("Informe somente Qtde maior que 1.", "Aviso")
1174:             THIS.grd_4c_Grade.Column2.Text1.Value = 0
1175:             loc_lOk = .F.
1176:         ENDIF
1177: 
1178:         IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1179:             IF loc_nValEtiq > Temp_DivOp.Qtds
1180:                 MsgAviso("Quantidade de Etiquetas n" + CHR(227) + ;
1181:                          "o pode ser maior que a quantidade do Pedido...", "Aviso")
1182:                 THIS.grd_4c_Grade.Column2.Text1.Value = 0
1183:                 loc_lOk = .F.
1184:             ENDIF
1185:         ENDIF
1186: 
1187:         RETURN loc_lOk
1188:     ENDPROC
1189: 
1190:     *==========================================================================
1191:     * GradeCol2When - Column2 (QtdEtiqs) When
1192:     * Limpa binding ENTER (cancelando atalho de Column4) e libera celula
1193:     * apenas quando Qtds > 1 (nao faz sentido dividir em etiquetas se qtd=1)
1194:     *==========================================================================
1195:     PROCEDURE GradeCol2When()
1196:         ON KEY LABEL ENTER
1197:         IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1198:             RETURN (Temp_DivOp.Qtds > 1)
1199:         ENDIF
1200:         RETURN .F.
1201:     ENDPROC
1202: 
1203:     *==========================================================================
1204:     * MemoObsLostFocus - fwmemo_obs.LostFocus
1205:     *==========================================================================
1206:     PROCEDURE MemoObsLostFocus()
1207:         IF THIS.grd_4c_Grade2.Visible
1208:             THIS.grd_4c_Grade2.Refresh()
1209:         ENDIF
1210:     ENDPROC
1211: 
1212:     *==========================================================================
1213:     * ObssLostFocus - Get_obss.LostFocus
1214:     *==========================================================================
1215:     PROCEDURE ObssLostFocus()
1216:         IF THIS.grd_4c_Grade2.Visible
1217:             THIS.grd_4c_Grade2.Refresh()
1218:         ENDIF
1219:     ENDPROC
1220: 
1221:     *==========================================================================
1222:     * ExecutarModoAutomatico - Execucao automatica para divisao programatica
1223:     * par_aNop: array [n,1]=Dopes, [n,2]=Numes, [n,3]=CodCors, [n,4]=CodTams,
1224:     *           [n,5]=Emps, [n,6]=Nops, [n,7]=NovaOp(out), [n,8]=Qtds,
1225:     *           [n,9]=QtdsGeradas(out)
1226:     *==========================================================================
1227:     PROCEDURE ExecutarModoAutomatico(par_aNop)
1228:         LOCAL loc_nCnt, loc_llOk, loc_nOp
1229: 
1230:         IF TYPE("par_aNop", 1) # "A"
1231:             RETURN .F.
1232:         ENDIF
1233: 
1234:         THIS.this_lAutomatico = .T.
1235:         THIS.Visible = .F.
1236: 
1237:         *-- Simular entrada de OP (primeiro elemento)
1238:         loc_nOp = par_aNop[1, 6]
1239:         THIS.txt_4c_Op.Value = ALLTRIM(STR(loc_nOp))
1240:         THIS.GetOpValid()
1241: 
1242:         SELECT Temp_DivOp
1243:         IF RECCOUNT() = 0
1244:             RETURN .F.
1245:         ENDIF
1246: 
1247:         *-- Distribuir QtdDivs conforme array
1248:         loc_llOk = .F.
1249:         FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
1250:             SELECT Temp_DivOp
1251:             GO TOP
1252:             LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
1253:                        Numes   = par_aNop[loc_nCnt, 2] AND ;
1254:                        CodCors = par_aNop[loc_nCnt, 3] AND ;
1255:                        CodTams = par_aNop[loc_nCnt, 4]
1256:             IF !EOF()
1257:                 REPLACE QtdDivs WITH QtdDivs + par_aNop[loc_nCnt, 8]
1258:                 loc_llOk = .T.
1259:             ENDIF
1260:         ENDFOR
1261: 
1262:         IF !loc_llOk
1263:             RETURN .F.
1264:         ENDIF
1265: 
1266:         *-- Executar geracao
1267:         THIS.GrupoSalvaClick()

*-- Linhas 1293 a 1549:
1293:     * Ao ser acionado (por atalho herdado ou automacao), delega para o fluxo
1294:     * operacional principal: valida OP digitada e gera as novas OPs divididas.
1295:     *==========================================================================
1296:     PROCEDURE BtnIncluirClick()
1297:         THIS.grp_4c_GrupoSalva.Value = 1
1298:         THIS.GrupoSalvaClick()
1299:     ENDPROC
1300: 
1301:     *==========================================================================
1302:     * BtnAlterarClick - Override de FormBase.BtnAlterarClick
1303:     * Form OPERACIONAL: alteracao corresponde a revisao da divisao gerada.
1304:     * Se Grade2 estiver ativa (estado de revisao), move foco para coluna O.P.
1305:     * para o usuario editar as novas OPs. Caso contrario, posiciona foco na
1306:     * coluna de divisao da grade principal para iniciar a alteracao.
1307:     *==========================================================================
1308:     PROCEDURE BtnAlterarClick()
1309:         IF THIS.grd_4c_Grade2.Visible
1310:             THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
1311:         ELSE
1312:             IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1313:                 THIS.grd_4c_Grade.Column4.Text1.SetFocus()
1314:             ELSE
1315:                 THIS.txt_4c_Op.SetFocus()
1316:             ENDIF
1317:         ENDIF
1318:     ENDPROC
1319: 
1320:     *==========================================================================
1321:     * BtnVisualizarClick - Override de FormBase.BtnVisualizarClick
1322:     * Form OPERACIONAL: visualizacao corresponde ao estado de revisao da
1323:     * divisao (Grade2). Alterna para pagina de revisao se houver Temporario
1324:     * preenchido; caso contrario, mantem estado atual e move foco para OP.
1325:     *==========================================================================
1326:     PROCEDURE BtnVisualizarClick()
1327:         IF USED("Temporario") AND RECCOUNT("Temporario") > 0
1328:             THIS.AlternarPagina(2)
1329:         ELSE
1330:             THIS.txt_4c_Op.SetFocus()
1331:         ENDIF
1332:     ENDPROC
1333: 
1334:     *==========================================================================
1335:     * BtnExcluirClick - Override de FormBase.BtnExcluirClick
1336:     * Form OPERACIONAL: exclusao equivale a rollback da transacao em curso.
1337:     * Confirma com usuario; se aprovado, faz rollback no BO e volta para
1338:     * estado inicial de entrada (Grade principal + GrupoSalva).
1339:     *==========================================================================
1340:     PROCEDURE BtnExcluirClick()
1341:         LOCAL loc_lConfirma
1342:         loc_lConfirma = MsgConfirma("Cancelar a divis" + CHR(227) + ;
1343:                                     "o em andamento e descartar altera" + ;
1344:                                     CHR(231) + CHR(245) + "es?", "Confirma" + ;
1345:                                     CHR(231) + CHR(227) + "o")
1346:         IF !loc_lConfirma
1347:             RETURN
1348:         ENDIF
1349: 
1350:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1351:            VARTYPE(THIS.this_oBusinessObject) = "O"
1352:             THIS.this_oBusinessObject.RollbackTransacao()
1353:         ENDIF
1354: 
1355:         IF USED("Temp_DivOp")
1356:             SELECT Temp_DivOp
1357:             ZAP
1358:         ENDIF
1359:         IF USED("Temporario")
1360:             SELECT Temporario
1361:             ZAP
1362:         ENDIF
1363:         IF USED("xNensi")
1364:             SELECT xNensi
1365:             ZAP
1366:         ENDIF
1367: 
1368:         THIS.txt_4c_Op.Value      = " "
1369:         THIS.txt_4c_Produto.Value = " "
1370:         THIS.AlternarPagina(1)
1371:         THIS.txt_4c_Op.SetFocus()
1372:         THIS.Refresh()
1373:     ENDPROC
1374: 
1375:     *==========================================================================
1376:     * BtnBuscarClick - Override de FormBase.BtnBuscarClick
1377:     * Form OPERACIONAL: re-executa a validacao e carga da OP corrente.
1378:     * Permite ao usuario recarregar o grid caso os dados tenham sido
1379:     * alterados externamente sem precisar limpar e redigitar a OP.
1380:     *==========================================================================
1381:     PROCEDURE BtnBuscarClick()
1382:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
1383:             THIS.GetOpValid()
1384:         ELSE
1385:             THIS.txt_4c_Op.SetFocus()
1386:         ENDIF
1387:     ENDPROC
1388: 
1389:     *==========================================================================
1390:     * BtnEncerrarClick - Override de FormBase.BtnEncerrarClick
1391:     * Form OPERACIONAL: faz rollback da transacao em aberto e fecha o form.
1392:     * Equivale a clicar "Encerrar" nos CommandGroups de Salva ou Conf.
1393:     *==========================================================================
1394:     PROCEDURE BtnEncerrarClick()
1395:         ON KEY LABEL ENTER
1396:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1397:            VARTYPE(THIS.this_oBusinessObject) = "O"
1398:             THIS.this_oBusinessObject.RollbackTransacao()
1399:         ENDIF
1400:         THIS.Release()
1401:     ENDPROC
1402: 
1403:     *==========================================================================
1404:     * BtnSalvarClick - Override de FormBase.BtnSalvarClick
1405:     * Form OPERACIONAL: delega para o CommandGroup ativo.
1406:     * Se estiver em modo revisao (GrupoConf visivel) -> ConfirmarGravacao.
1407:     * Se estiver em modo entrada (GrupoSalva visivel) -> GerarNovaOP.
1408:     *==========================================================================
1409:     PROCEDURE BtnSalvarClick()
1410:         IF THIS.grp_4c_GrupoConf.Visible AND THIS.grp_4c_GrupoConf.Enabled
1411:             THIS.grp_4c_GrupoConf.Value = 1
1412:             THIS.GrupoConfClick()
1413:         ELSE
1414:             THIS.grp_4c_GrupoSalva.Value = 1
1415:             THIS.GrupoSalvaClick()
1416:         ENDIF
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * BtnCancelarClick - Override de FormBase.BtnCancelarClick
1421:     * Form OPERACIONAL: cancela a divisao em andamento, faz rollback e
1422:     * retorna ao estado inicial de entrada sem pedir confirmacao.
1423:     *==========================================================================
1424:     PROCEDURE BtnCancelarClick()
1425:         ON KEY LABEL ENTER
1426:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1427:            VARTYPE(THIS.this_oBusinessObject) = "O"
1428:             THIS.this_oBusinessObject.RollbackTransacao()
1429:         ENDIF
1430: 
1431:         IF USED("Temp_DivOp")
1432:             SELECT Temp_DivOp
1433:             ZAP
1434:         ENDIF
1435:         IF USED("Temporario")
1436:             SELECT Temporario
1437:             ZAP
1438:         ENDIF
1439:         IF USED("xNensi")
1440:             SELECT xNensi
1441:             ZAP
1442:         ENDIF
1443: 
1444:         THIS.txt_4c_Op.Value      = " "
1445:         THIS.txt_4c_Produto.Value = " "
1446:         THIS.AlternarPagina(1)
1447:         THIS.txt_4c_Op.SetFocus()
1448:         THIS.Refresh()
1449:     ENDPROC
1450: 
1451:     *==========================================================================
1452:     * FormParaBO - Transfere estado do form para propriedades do BO
1453:     * Form OPERACIONAL: propaga numero da OP, operacao e empresa corrente.
1454:     * Chamado antes de qualquer persistencia (GerarNovaOP/ConfirmarGravacao).
1455:     *==========================================================================
1456:     PROCEDURE FormParaBO()
1457:         THIS.this_oBusinessObject.this_nNops     = ALLTRIM(THIS.txt_4c_Op.Value)
1458:         THIS.this_oBusinessObject.this_cOperacao = THIS.this_cOperacao
1459:         THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
1460:     ENDPROC
1461: 
1462:     *==========================================================================
1463:     * BOParaForm - Transfere estado do BO para os controles do form
1464:     * Form OPERACIONAL: atualiza campo de produto apos carga da OP.
1465:     *==========================================================================
1466:     PROCEDURE BOParaForm()
1467:         THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
1468:     ENDPROC
1469: 
1470:     *==========================================================================
1471:     * HabilitarCampos - Habilita ou desabilita controles de entrada
1472:     * Form OPERACIONAL: Get_OP editavel apenas enquanto Temporario estiver
1473:     * vazio (antes de gerar as OPs). Get_Produto sempre readonly.
1474:     *==========================================================================
1475:     PROCEDURE HabilitarCampos(par_lHabilitar)
1476:         LOCAL loc_lOpHabilitada
1477:         loc_lOpHabilitada = par_lHabilitar AND (RECCOUNT("Temporario") = 0)
1478:         THIS.txt_4c_Op.Enabled = loc_lOpHabilitada
1479:         THIS.txt_4c_Op.ReadOnly = !loc_lOpHabilitada
1480:     ENDPROC
1481: 
1482:     *==========================================================================
1483:     * LimparCampos - Zera todos os campos e cursores de trabalho
1484:     * Form OPERACIONAL: limpa Get_OP, Get_Produto, Temp_DivOp, Temporario,
1485:     * xNensi e retorna form ao estado inicial (Grade principal + GrupoSalva).
1486:     *==========================================================================
1487:     PROCEDURE LimparCampos()
1488:         THIS.txt_4c_Op.Value      = " "
1489:         THIS.txt_4c_Produto.Value = " "
1490: 
1491:         IF USED("Temp_DivOp")
1492:             SELECT Temp_DivOp
1493:             ZAP
1494:         ENDIF
1495:         IF USED("Temporario")
1496:             SELECT Temporario
1497:             ZAP
1498:         ENDIF
1499:         IF USED("xNensi")
1500:             SELECT xNensi
1501:             ZAP
1502:         ENDIF
1503: 
1504:         THIS.AlternarPagina(1)
1505:         THIS.Refresh()
1506:     ENDPROC
1507: 
1508:     *==========================================================================
1509:     * CarregarLista - Recarrega o grid principal para a OP corrente
1510:     * Form OPERACIONAL: se OP informada, re-executa GetOpValid para repopular
1511:     * Temp_DivOp e atualizar o grid; caso contrario, apenas limpa os cursores.
1512:     *==========================================================================
1513:     PROCEDURE CarregarLista()
1514:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
1515:             THIS.GetOpValid()
1516:         ENDIF
1517:         IF USED("Temp_DivOp")
1518:             THIS.grd_4c_Grade.Refresh()
1519:         ENDIF
1520:     ENDPROC
1521: 
1522:     *==========================================================================
1523:     * AjustarBotoesPorModo - Ajusta visibilidade dos CommandGroups conforme modo
1524:     * Form OPERACIONAL: usa AlternarPagina para controlar GrupoSalva/GrupoConf.
1525:     * Parametro par_cModo: "LISTA"/"ENTRADA" -> pagina 1, "DADOS"/"REVISAO" -> pagina 2.
1526:     *==========================================================================
1527:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1528:         IF VARTYPE(par_cModo) = "C"
1529:             IF UPPER(ALLTRIM(par_cModo)) = "DADOS" OR UPPER(ALLTRIM(par_cModo)) = "REVISAO"
1530:                 THIS.AlternarPagina(2)
1531:             ELSE
1532:                 THIS.AlternarPagina(1)
1533:             ENDIF
1534:         ENDIF
1535:     ENDPROC
1536: 
1537:     *==========================================================================
1538:     * Destroy - Destrutor: rollback seguro + limpeza de key bindings
1539:     *==========================================================================
1540:     PROCEDURE Destroy()
1541:         ON KEY LABEL ENTER
1542:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1543:            VARTYPE(THIS.this_oBusinessObject) = "O"
1544:             THIS.this_oBusinessObject.RollbackTransacao()
1545:         ENDIF
1546:         DODEFAULT()
1547:     ENDPROC
1548: 
1549: ENDDEFINE

