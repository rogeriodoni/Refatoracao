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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1547 linhas total):

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
253:             .FontName        = "Comic Sans MS"
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

*-- Linhas 977 a 1265:
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
1125:             IF INLIST(loc_cNome, ;
1126:                     "GRD_4C_GRADE2",   ;
1127:                     "EDT_4C_MEMOOBS",  ;
1128:                     "GRP_4C_GRUPOCONF")
1129:                 LOOP
1130:             ENDIF
1131: 
1132:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1133:                 loc_oCtrl.Visible = .T.
1134:             ENDIF
1135: 
1136:             *-- Recursao em Containers
1137:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
1138:                 IF loc_oCtrl.ControlCount > 0
1139:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1140:                 ENDIF
1141:             ENDIF
1142: 
1143:             *-- Recursao em Pages de PageFrame
1144:             IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
1145:                 FOR loc_j = 1 TO loc_oCtrl.PageCount
1146:                     THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
1147:                 ENDFOR
1148:             ENDIF
1149:         ENDFOR
1150: 
1151:         loc_oCtrl = .NULL.
1152:     ENDPROC
1153: 
1154:     *==========================================================================
1155:     * GradeCol2Valid - Column2 (QtdEtiqs) Valid
1156:     * Regras: mutuamente exclusivo com QtdDivs; > 1; nao pode exceder Qtds
1157:     *==========================================================================
1158:     PROCEDURE GradeCol2Valid()
1159:         LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
1160:         loc_lOk         = .T.
1161:         loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
1162:         loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value
1163: 
1164:         IF loc_nValDivisao > 0 AND loc_nValEtiq > 0
1165:             MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
1166:             THIS.grd_4c_Grade.Column2.Text1.Value = 0
1167:             loc_lOk = .F.
1168:         ENDIF
1169: 
1170:         IF loc_lOk AND loc_nValEtiq = 1
1171:             MsgAviso("Informe somente Qtde maior que 1.", "Aviso")
1172:             THIS.grd_4c_Grade.Column2.Text1.Value = 0
1173:             loc_lOk = .F.
1174:         ENDIF
1175: 
1176:         IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1177:             IF loc_nValEtiq > Temp_DivOp.Qtds
1178:                 MsgAviso("Quantidade de Etiquetas n" + CHR(227) + ;
1179:                          "o pode ser maior que a quantidade do Pedido...", "Aviso")
1180:                 THIS.grd_4c_Grade.Column2.Text1.Value = 0
1181:                 loc_lOk = .F.
1182:             ENDIF
1183:         ENDIF
1184: 
1185:         RETURN loc_lOk
1186:     ENDPROC
1187: 
1188:     *==========================================================================
1189:     * GradeCol2When - Column2 (QtdEtiqs) When
1190:     * Limpa binding ENTER (cancelando atalho de Column4) e libera celula
1191:     * apenas quando Qtds > 1 (nao faz sentido dividir em etiquetas se qtd=1)
1192:     *==========================================================================
1193:     PROCEDURE GradeCol2When()
1194:         ON KEY LABEL ENTER
1195:         IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1196:             RETURN (Temp_DivOp.Qtds > 1)
1197:         ENDIF
1198:         RETURN .F.
1199:     ENDPROC
1200: 
1201:     *==========================================================================
1202:     * MemoObsLostFocus - fwmemo_obs.LostFocus
1203:     *==========================================================================
1204:     PROCEDURE MemoObsLostFocus()
1205:         IF THIS.grd_4c_Grade2.Visible
1206:             THIS.grd_4c_Grade2.Refresh()
1207:         ENDIF
1208:     ENDPROC
1209: 
1210:     *==========================================================================
1211:     * ObssLostFocus - Get_obss.LostFocus
1212:     *==========================================================================
1213:     PROCEDURE ObssLostFocus()
1214:         IF THIS.grd_4c_Grade2.Visible
1215:             THIS.grd_4c_Grade2.Refresh()
1216:         ENDIF
1217:     ENDPROC
1218: 
1219:     *==========================================================================
1220:     * ExecutarModoAutomatico - Execucao automatica para divisao programatica
1221:     * par_aNop: array [n,1]=Dopes, [n,2]=Numes, [n,3]=CodCors, [n,4]=CodTams,
1222:     *           [n,5]=Emps, [n,6]=Nops, [n,7]=NovaOp(out), [n,8]=Qtds,
1223:     *           [n,9]=QtdsGeradas(out)
1224:     *==========================================================================
1225:     PROCEDURE ExecutarModoAutomatico(par_aNop)
1226:         LOCAL loc_nCnt, loc_llOk, loc_nOp
1227: 
1228:         IF TYPE("par_aNop", 1) # "A"
1229:             RETURN .F.
1230:         ENDIF
1231: 
1232:         THIS.this_lAutomatico = .T.
1233:         THIS.Visible = .F.
1234: 
1235:         *-- Simular entrada de OP (primeiro elemento)
1236:         loc_nOp = par_aNop[1, 6]
1237:         THIS.txt_4c_Op.Value = ALLTRIM(STR(loc_nOp))
1238:         THIS.GetOpValid()
1239: 
1240:         SELECT Temp_DivOp
1241:         IF RECCOUNT() = 0
1242:             RETURN .F.
1243:         ENDIF
1244: 
1245:         *-- Distribuir QtdDivs conforme array
1246:         loc_llOk = .F.
1247:         FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
1248:             SELECT Temp_DivOp
1249:             GO TOP
1250:             LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
1251:                        Numes   = par_aNop[loc_nCnt, 2] AND ;
1252:                        CodCors = par_aNop[loc_nCnt, 3] AND ;
1253:                        CodTams = par_aNop[loc_nCnt, 4]
1254:             IF !EOF()
1255:                 REPLACE QtdDivs WITH QtdDivs + par_aNop[loc_nCnt, 8]
1256:                 loc_llOk = .T.
1257:             ENDIF
1258:         ENDFOR
1259: 
1260:         IF !loc_llOk
1261:             RETURN .F.
1262:         ENDIF
1263: 
1264:         *-- Executar geracao
1265:         THIS.GrupoSalvaClick()

*-- Linhas 1291 a 1547:
1291:     * Ao ser acionado (por atalho herdado ou automacao), delega para o fluxo
1292:     * operacional principal: valida OP digitada e gera as novas OPs divididas.
1293:     *==========================================================================
1294:     PROCEDURE BtnIncluirClick()
1295:         THIS.grp_4c_GrupoSalva.Value = 1
1296:         THIS.GrupoSalvaClick()
1297:     ENDPROC
1298: 
1299:     *==========================================================================
1300:     * BtnAlterarClick - Override de FormBase.BtnAlterarClick
1301:     * Form OPERACIONAL: alteracao corresponde a revisao da divisao gerada.
1302:     * Se Grade2 estiver ativa (estado de revisao), move foco para coluna O.P.
1303:     * para o usuario editar as novas OPs. Caso contrario, posiciona foco na
1304:     * coluna de divisao da grade principal para iniciar a alteracao.
1305:     *==========================================================================
1306:     PROCEDURE BtnAlterarClick()
1307:         IF THIS.grd_4c_Grade2.Visible
1308:             THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
1309:         ELSE
1310:             IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1311:                 THIS.grd_4c_Grade.Column4.Text1.SetFocus()
1312:             ELSE
1313:                 THIS.txt_4c_Op.SetFocus()
1314:             ENDIF
1315:         ENDIF
1316:     ENDPROC
1317: 
1318:     *==========================================================================
1319:     * BtnVisualizarClick - Override de FormBase.BtnVisualizarClick
1320:     * Form OPERACIONAL: visualizacao corresponde ao estado de revisao da
1321:     * divisao (Grade2). Alterna para pagina de revisao se houver Temporario
1322:     * preenchido; caso contrario, mantem estado atual e move foco para OP.
1323:     *==========================================================================
1324:     PROCEDURE BtnVisualizarClick()
1325:         IF USED("Temporario") AND RECCOUNT("Temporario") > 0
1326:             THIS.AlternarPagina(2)
1327:         ELSE
1328:             THIS.txt_4c_Op.SetFocus()
1329:         ENDIF
1330:     ENDPROC
1331: 
1332:     *==========================================================================
1333:     * BtnExcluirClick - Override de FormBase.BtnExcluirClick
1334:     * Form OPERACIONAL: exclusao equivale a rollback da transacao em curso.
1335:     * Confirma com usuario; se aprovado, faz rollback no BO e volta para
1336:     * estado inicial de entrada (Grade principal + GrupoSalva).
1337:     *==========================================================================
1338:     PROCEDURE BtnExcluirClick()
1339:         LOCAL loc_lConfirma
1340:         loc_lConfirma = MsgConfirma("Cancelar a divis" + CHR(227) + ;
1341:                                     "o em andamento e descartar altera" + ;
1342:                                     CHR(231) + CHR(245) + "es?", "Confirma" + ;
1343:                                     CHR(231) + CHR(227) + "o")
1344:         IF !loc_lConfirma
1345:             RETURN
1346:         ENDIF
1347: 
1348:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1349:            VARTYPE(THIS.this_oBusinessObject) = "O"
1350:             THIS.this_oBusinessObject.RollbackTransacao()
1351:         ENDIF
1352: 
1353:         IF USED("Temp_DivOp")
1354:             SELECT Temp_DivOp
1355:             ZAP
1356:         ENDIF
1357:         IF USED("Temporario")
1358:             SELECT Temporario
1359:             ZAP
1360:         ENDIF
1361:         IF USED("xNensi")
1362:             SELECT xNensi
1363:             ZAP
1364:         ENDIF
1365: 
1366:         THIS.txt_4c_Op.Value      = " "
1367:         THIS.txt_4c_Produto.Value = " "
1368:         THIS.AlternarPagina(1)
1369:         THIS.txt_4c_Op.SetFocus()
1370:         THIS.Refresh()
1371:     ENDPROC
1372: 
1373:     *==========================================================================
1374:     * BtnBuscarClick - Override de FormBase.BtnBuscarClick
1375:     * Form OPERACIONAL: re-executa a validacao e carga da OP corrente.
1376:     * Permite ao usuario recarregar o grid caso os dados tenham sido
1377:     * alterados externamente sem precisar limpar e redigitar a OP.
1378:     *==========================================================================
1379:     PROCEDURE BtnBuscarClick()
1380:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
1381:             THIS.GetOpValid()
1382:         ELSE
1383:             THIS.txt_4c_Op.SetFocus()
1384:         ENDIF
1385:     ENDPROC
1386: 
1387:     *==========================================================================
1388:     * BtnEncerrarClick - Override de FormBase.BtnEncerrarClick
1389:     * Form OPERACIONAL: faz rollback da transacao em aberto e fecha o form.
1390:     * Equivale a clicar "Encerrar" nos CommandGroups de Salva ou Conf.
1391:     *==========================================================================
1392:     PROCEDURE BtnEncerrarClick()
1393:         ON KEY LABEL ENTER
1394:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1395:            VARTYPE(THIS.this_oBusinessObject) = "O"
1396:             THIS.this_oBusinessObject.RollbackTransacao()
1397:         ENDIF
1398:         THIS.Release()
1399:     ENDPROC
1400: 
1401:     *==========================================================================
1402:     * BtnSalvarClick - Override de FormBase.BtnSalvarClick
1403:     * Form OPERACIONAL: delega para o CommandGroup ativo.
1404:     * Se estiver em modo revisao (GrupoConf visivel) -> ConfirmarGravacao.
1405:     * Se estiver em modo entrada (GrupoSalva visivel) -> GerarNovaOP.
1406:     *==========================================================================
1407:     PROCEDURE BtnSalvarClick()
1408:         IF THIS.grp_4c_GrupoConf.Visible AND THIS.grp_4c_GrupoConf.Enabled
1409:             THIS.grp_4c_GrupoConf.Value = 1
1410:             THIS.GrupoConfClick()
1411:         ELSE
1412:             THIS.grp_4c_GrupoSalva.Value = 1
1413:             THIS.GrupoSalvaClick()
1414:         ENDIF
1415:     ENDPROC
1416: 
1417:     *==========================================================================
1418:     * BtnCancelarClick - Override de FormBase.BtnCancelarClick
1419:     * Form OPERACIONAL: cancela a divisao em andamento, faz rollback e
1420:     * retorna ao estado inicial de entrada sem pedir confirmacao.
1421:     *==========================================================================
1422:     PROCEDURE BtnCancelarClick()
1423:         ON KEY LABEL ENTER
1424:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1425:            VARTYPE(THIS.this_oBusinessObject) = "O"
1426:             THIS.this_oBusinessObject.RollbackTransacao()
1427:         ENDIF
1428: 
1429:         IF USED("Temp_DivOp")
1430:             SELECT Temp_DivOp
1431:             ZAP
1432:         ENDIF
1433:         IF USED("Temporario")
1434:             SELECT Temporario
1435:             ZAP
1436:         ENDIF
1437:         IF USED("xNensi")
1438:             SELECT xNensi
1439:             ZAP
1440:         ENDIF
1441: 
1442:         THIS.txt_4c_Op.Value      = " "
1443:         THIS.txt_4c_Produto.Value = " "
1444:         THIS.AlternarPagina(1)
1445:         THIS.txt_4c_Op.SetFocus()
1446:         THIS.Refresh()
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * FormParaBO - Transfere estado do form para propriedades do BO
1451:     * Form OPERACIONAL: propaga numero da OP, operacao e empresa corrente.
1452:     * Chamado antes de qualquer persistencia (GerarNovaOP/ConfirmarGravacao).
1453:     *==========================================================================
1454:     PROCEDURE FormParaBO()
1455:         THIS.this_oBusinessObject.this_nNops     = ALLTRIM(THIS.txt_4c_Op.Value)
1456:         THIS.this_oBusinessObject.this_cOperacao = THIS.this_cOperacao
1457:         THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
1458:     ENDPROC
1459: 
1460:     *==========================================================================
1461:     * BOParaForm - Transfere estado do BO para os controles do form
1462:     * Form OPERACIONAL: atualiza campo de produto apos carga da OP.
1463:     *==========================================================================
1464:     PROCEDURE BOParaForm()
1465:         THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
1466:     ENDPROC
1467: 
1468:     *==========================================================================
1469:     * HabilitarCampos - Habilita ou desabilita controles de entrada
1470:     * Form OPERACIONAL: Get_OP editavel apenas enquanto Temporario estiver
1471:     * vazio (antes de gerar as OPs). Get_Produto sempre readonly.
1472:     *==========================================================================
1473:     PROCEDURE HabilitarCampos(par_lHabilitar)
1474:         LOCAL loc_lOpHabilitada
1475:         loc_lOpHabilitada = par_lHabilitar AND (RECCOUNT("Temporario") = 0)
1476:         THIS.txt_4c_Op.Enabled = loc_lOpHabilitada
1477:         THIS.txt_4c_Op.ReadOnly = !loc_lOpHabilitada
1478:     ENDPROC
1479: 
1480:     *==========================================================================
1481:     * LimparCampos - Zera todos os campos e cursores de trabalho
1482:     * Form OPERACIONAL: limpa Get_OP, Get_Produto, Temp_DivOp, Temporario,
1483:     * xNensi e retorna form ao estado inicial (Grade principal + GrupoSalva).
1484:     *==========================================================================
1485:     PROCEDURE LimparCampos()
1486:         THIS.txt_4c_Op.Value      = " "
1487:         THIS.txt_4c_Produto.Value = " "
1488: 
1489:         IF USED("Temp_DivOp")
1490:             SELECT Temp_DivOp
1491:             ZAP
1492:         ENDIF
1493:         IF USED("Temporario")
1494:             SELECT Temporario
1495:             ZAP
1496:         ENDIF
1497:         IF USED("xNensi")
1498:             SELECT xNensi
1499:             ZAP
1500:         ENDIF
1501: 
1502:         THIS.AlternarPagina(1)
1503:         THIS.Refresh()
1504:     ENDPROC
1505: 
1506:     *==========================================================================
1507:     * CarregarLista - Recarrega o grid principal para a OP corrente
1508:     * Form OPERACIONAL: se OP informada, re-executa GetOpValid para repopular
1509:     * Temp_DivOp e atualizar o grid; caso contrario, apenas limpa os cursores.
1510:     *==========================================================================
1511:     PROCEDURE CarregarLista()
1512:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
1513:             THIS.GetOpValid()
1514:         ENDIF
1515:         IF USED("Temp_DivOp")
1516:             THIS.grd_4c_Grade.Refresh()
1517:         ENDIF
1518:     ENDPROC
1519: 
1520:     *==========================================================================
1521:     * AjustarBotoesPorModo - Ajusta visibilidade dos CommandGroups conforme modo
1522:     * Form OPERACIONAL: usa AlternarPagina para controlar GrupoSalva/GrupoConf.
1523:     * Parametro par_cModo: "LISTA"/"ENTRADA" -> pagina 1, "DADOS"/"REVISAO" -> pagina 2.
1524:     *==========================================================================
1525:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1526:         IF VARTYPE(par_cModo) = "C"
1527:             IF UPPER(ALLTRIM(par_cModo)) = "DADOS" OR UPPER(ALLTRIM(par_cModo)) = "REVISAO"
1528:                 THIS.AlternarPagina(2)
1529:             ELSE
1530:                 THIS.AlternarPagina(1)
1531:             ENDIF
1532:         ENDIF
1533:     ENDPROC
1534: 
1535:     *==========================================================================
1536:     * Destroy - Destrutor: rollback seguro + limpeza de key bindings
1537:     *==========================================================================
1538:     PROCEDURE Destroy()
1539:         ON KEY LABEL ENTER
1540:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1541:            VARTYPE(THIS.this_oBusinessObject) = "O"
1542:             THIS.this_oBusinessObject.RollbackTransacao()
1543:         ENDIF
1544:         DODEFAULT()
1545:     ENDPROC
1546: 
1547: ENDDEFINE

