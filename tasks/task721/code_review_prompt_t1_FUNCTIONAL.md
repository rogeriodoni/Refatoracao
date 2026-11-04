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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1654 linhas total):

*-- Linhas 17 a 243:
17: *     BtnBuscarClick     -> re-executa ValidarOpExec para recarregar a OP
18: *     BtnCancelarClick   -> rollback + retorno ao estado inicial (sem confirmar)
19: *   Verificado na fase 7: Grupo_Salva.Click e Grupo_Conf.Click do legado
20: *   cobertos e ligados por BINDEVENT; os 4 metodos do BO chamados de fora
21: *   (BuscarOP/GerarNovaOP/ConfirmarGravacao/RollbackTransacao) sao PUBLIC
22: *   em sigopdivBO e em BusinessBase (regra #51); .Picture dos 4 botoes
23: *   existe em vbmp (regra #25). CORRIGIDO: FormParaBO atribuia CHARACTER
24: *   (ALLTRIM) a this_nNops, que e NUMERIC no BO - ConfirmarGravacao testa
25: *   IF this_nNops > 0 e estouraria type mismatch; agora VAL().
26: *   FASE 8 (consolidacao final): FormParaBO/BOParaForm cobrem as 3
27: *   propriedades do BO acessadas de fora (this_nNops/this_cOperacao/
28: *   this_cEmps -> FormParaBO; this_cProduto -> BOParaForm). HabilitarCampos,
29: *   LimparCampos, CarregarLista e AjustarBotoesPorModo substituem os
30: *   equivalentes de FormBase porque este form nao tem PageFrame CRUD
31: *   (AlternarPagina gerencia GrupoSalva/GrupoConf + Grade/Grade2 em vez de
32: *   Page1/Page2). Nenhum metodo novo requerido por esta fase ficou PROTECTED
33: *   sem necessidade (regra #51) e nenhum CATCH ficou silencioso (regra #9).
34: *============================================================================
35: DEFINE CLASS Formsigopdiv AS FormBase
36: 
37:     *-- Layout (pixel-perfect do legado)
38:     Width       = 830
39:     Height      = 527
40:     AutoCenter  = .T.
41:     BorderStyle = 2
42:     TitleBar    = 0
43:     ControlBox  = .F.
44:     Closable    = .F.
45:     MaxButton   = .F.
46:     MinButton   = .F.
47:     WindowType  = 1
48:     DataSession = 2
49:     Themes      = .F.
50:     ShowWindow  = 1
51:     KeyPreview  = .F.
52: 
53:     *-- Propriedades de estado
54:     this_oBusinessObject = .NULL.
55:     this_cMensagemErro   = ""
56:     this_cOperacao       = "D"    && 'D'=Divisao, 'R'=Reinicia
57:     this_lAutomatico     = .F.
58:     this_lEmValidacao    = .F.   && guarda de reentrancia (regra #47)
59:     this_cOpValidada     = ""    && ultimo valor de OP ja validado
60: 
61:     *==========================================================================
62:     * Init - Aceita parametro de operacao antes de chamar FormBase.Init
63:     *==========================================================================
64:     PROCEDURE Init(par_cOperacao)
65:         IF VARTYPE(par_cOperacao) = "C" AND !EMPTY(par_cOperacao)
66:             THIS.this_cOperacao = UPPER(ALLTRIM(par_cOperacao))
67:         ENDIF
68:         RETURN DODEFAULT()
69:     ENDPROC
70: 
71:     *==========================================================================
72:     * InicializarForm - Construcao completa do form
73:     *==========================================================================
74:     PROTECTED PROCEDURE InicializarForm()
75:         LOCAL loc_lSucesso, loc_oErro
76:         loc_lSucesso = .F.
77: 
78:         TRY
79:             *-- Criar BO
80:             THIS.this_oBusinessObject = CREATEOBJECT("sigopdivBO")
81:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
82:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigopdiv.", "Erro")
83:                 loc_lSucesso = .F.
84:             ENDIF
85: 
86:             *-- Validar DivOps em SigCdPam
87:             LOCAL loc_cSQL
88:             loc_cSQL = "SELECT DivOps FROM SigCdPam"
89:             IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_PamDiv") > 0
90:                 SELECT cursor_4c_PamDiv
91:                 GO TOP
92:                 IF EMPTY(ALLTRIM(cursor_4c_PamDiv.DivOps))
93:                     MsgAviso("Opera" + CHR(231) + CHR(227) + "o de Divis" + CHR(227) + ;
94:                              "o de Op n" + CHR(227) + "o Configurada nos par" + CHR(226) + ;
95:                              "metros do sistema...", "Configura" + CHR(231) + CHR(227) + "o")
96:                 ENDIF
97:                 USE IN cursor_4c_PamDiv
98:             ENDIF
99: 
100:             *-- Definir Caption conforme operacao
101:             IF THIS.this_cOperacao = "R"
102:                 THIS.Caption = "Reinicia Industrializa" + CHR(231) + CHR(227) + "o"
103:             ELSE
104:                 THIS.Caption = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
105:             ENDIF
106: 
107:             *-- Criar cursores de trabalho (privados desta sessao de dados)
108:             SET NULL ON
109:             CREATE CURSOR Temp_DivOp ;
110:                 (Qtds N(12,3), QtdEtiqs N(5,0), QtdDivs N(12,3), Dopes C(20), ;
111:                  Numes N(6,0), Dataes D, Obss M NULL, Nops N(10,0), SeqDivs N(3,0), ;
112:                  Cpros C(14), CodCors C(4), CodTams C(4), Empds C(3), Dpros C(65), ;
113:                  Notas C(6), Contas C(10), Citens N(10,0), Pesos N(12,3))
114:             CREATE CURSOR Temporario ;
115:                 (Qtds N(12,3), Dopes C(20), Numes N(6,0), Dataes D, Obss M NULL, ;
116:                  Nops N(10,0), SeqDivs N(3,0), Cpros C(14), CodCors C(4), CodTams C(4), ;
117:                  Empds C(3), Dpros C(65), Notas C(6), Contas C(10), Pesos N(9,3))
118:             INDEX ON Nops TAG Nops FOR Qtds > 0
119:             SET NULL OFF
120: 
121:             *-- Criar xNensi com estrutura identica a SigCdNei
122:             IF gnConnHandle > 0
123:                 IF SQLEXEC(gnConnHandle, "SELECT TOP 0 * FROM SigCdNei", ;
124:                            "cursor_4c_NensiStruct") > 0
125:                     DIMENSION loc_aNensiFields[1]
126:                     AFIELDS(loc_aNensiFields, "cursor_4c_NensiStruct")
127:                     CREATE CURSOR xNensi FROM ARRAY loc_aNensiFields
128:                     USE IN cursor_4c_NensiStruct
129:                 ENDIF
130:             ENDIF
131: 
132:             *-- Construir todos os controles UI
133:             THIS.ConfigurarControles()
134: 
135:             *-- Inicializar estado visual do form (Grade principal visivel)
136:             THIS.ConfigurarPaginaLista()
137: 
138:             *-- Propagar Caption para labels de titulo
139:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
140:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
141: 
142:             *-- BINDEVENT: Get_OP (unico campo digitavel do topo)
143:             *-- Regra #3: BINDEVENT "Valid" nao dispara em TextBox - o Valid do
144:             *-- legado vai no KeyPress com guard de ENTER(13)/TAB(9).
145:             *-- Regra #47: handler de LostFocus vai em "LostFocus", NUNCA em
146:             *-- "KeyPress" - ligado a KeyPress sem testar a tecla, o SetFocus
147:             *-- para a grade disparava a CADA caractere digitado.
148:             BINDEVENT(THIS.txt_4c_Op, "When",      THIS, "ValidarAcessoOp")
149:             BINDEVENT(THIS.txt_4c_Op, "KeyPress",  THIS, "ValidarOp")
150:             BINDEVENT(THIS.txt_4c_Op, "LostFocus", THIS, "OpLostFocus")
151: 
152:             *-- BINDEVENT: CommandGroups
153:             BINDEVENT(THIS.grp_4c_GrupoSalva, "Click", THIS, "GrupoSalvaClick")
154:             BINDEVENT(THIS.grp_4c_GrupoConf,  "Click", THIS, "GrupoConfClick")
155: 
156:             *-- BINDEVENT: Grade (principal) eventos
157:             BINDEVENT(THIS.grd_4c_Grade, "AfterRowColChange", THIS, "GradeAfterRowColChange")
158: 
159:             *-- BINDEVENT: Grade2 (resultado) eventos
160:             BINDEVENT(THIS.grd_4c_Grade2, "AfterRowColChange", THIS, "Grade2AfterRowColChange")
161: 
162:             *-- BINDEVENT: colunas editaveis da Grade (Column4=QtdDivs, Column2=QtdEtiqs)
163:             *-- O Valid do legado dispara ao SAIR da celula, por tecla OU por mouse:
164:             *-- "KeyPress" com guard de ENTER(13)/TAB(9) cobre a saida por tecla e
165:             *-- "LostFocus" cobre a saida por mouse. Ligar o handler de saida em
166:             *-- "KeyPress" (como estava) rodava a validacao a cada caractere - em
167:             *-- QtdEtiqs isso exibia "Informe somente Qtde maior que 1." e zerava a
168:             *-- celula ao digitar o segundo digito de qualquer numero iniciado por 1.
169:             BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "When",      THIS, "ValidarAcessoQtdDivisao")
170:             BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "KeyPress",  THIS, "ValidarQtdDivisao")
171:             BINDEVENT(THIS.grd_4c_Grade.Column4.Text1, "LostFocus", THIS, "QtdDivisaoLostFocus")
172:             BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "When",      THIS, "ValidarAcessoQtdEtiquetas")
173:             BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "KeyPress",  THIS, "ValidarQtdEtiquetas")
174:             BINDEVENT(THIS.grd_4c_Grade.Column2.Text1, "LostFocus", THIS, "QtdEtiquetasLostFocus")
175: 
176:             *-- BINDEVENT: EditBoxes - LostFocus do legado (ThisForm.grade2.Refresh)
177:             BINDEVENT(THIS.edt_4c_MemoObs, "LostFocus", THIS, "MemoObsLostFocus")
178:             BINDEVENT(THIS.edt_4c_Obss,    "LostFocus", THIS, "ObssLostFocus")
179: 
180:             *-- Ajustar caption do botao Gerar para modo Reinicia
181:             IF THIS.this_cOperacao = "R"
182:                 THIS.grp_4c_GrupoSalva.Buttons(1).Caption = "\<Reinicia"
183:             ENDIF
184: 
185:             *-- Tornar todos os controles visiveis (exceto flutuantes)
186:             THIS.TornarControlesVisiveis(THIS)
187: 
188:             loc_lSucesso = .T.
189: 
190:         CATCH TO loc_oErro
191:             MsgErro(loc_oErro.Message, "Erro em InicializarForm")
192:         ENDTRY
193: 
194:         RETURN loc_lSucesso
195:     ENDPROC
196: 
197:     *==========================================================================
198:     * ConfigurarPageFrame - Constroi o "frame" visual do form operacional:
199:     * Picture de fundo + container cabecalho (cntSombra) com labels de titulo.
200:     * Forms OPERACIONAIS nao usam PageFrame CRUD; este metodo agrupa a
201:     * estrutura fixa do topo (equivalente ao "frame" da tela).
202:     *==========================================================================
203:     PROTECTED PROCEDURE ConfigurarPageFrame()
204:         *-- Imagem de fundo (pixel-perfect do legado)
205:         THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
206: 
207:         *----------------------------------------------------------------------
208:         * Container cabecalho (cntSombra): fundo cinza + labels de titulo
209:         *----------------------------------------------------------------------
210:         THIS.AddObject("cnt_4c_Sombra", "Container")
211:         WITH THIS.cnt_4c_Sombra
212:             .Top         = 0
213:             .Left        = 0
214:             .Width       = THIS.Width
215:             .Height      = 80
216:             .BackColor   = RGB(100, 100, 100)
217:             .BorderWidth = 0
218:             .Visible     = .T.
219: 
220:             .AddObject("lbl_4c_Sombra", "Label")
221:             WITH .lbl_4c_Sombra
222:                 .Top      = 18
223:                 .Left     = 10
224:                 .Width    = THIS.Width
225:                 .Height   = 40
226:                 .FontBold = .T.
227:                 .FontName = "Tahoma"
228:                 .FontSize = 18
229:                 .BackStyle = 0
230:                 .ForeColor = RGB(0, 0, 0)
231:                 .WordWrap  = .T.
232:                 .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
233:                 .Visible   = .T.
234:             ENDWITH
235: 
236:             .AddObject("lbl_4c_Titulo", "Label")
237:             WITH .lbl_4c_Titulo
238:                 .Top      = 19
239:                 .Left     = 10
240:                 .Width    = THIS.Width
241:                 .Height   = 46
242:                 .FontBold = .T.
243:                 .FontName = "Tahoma"

*-- Linhas 254 a 297:
254:     *==========================================================================
255:     * ConfigurarControles - Cria todos os objetos visuais do form
256:     *==========================================================================
257:     PROTECTED PROCEDURE ConfigurarControles()
258:         *-- Construir frame (picture + cabecalho)
259:         THIS.ConfigurarPageFrame()
260: 
261:         *-- Construir campos principais (labels, textboxes, editboxes)
262:         THIS.ConfigurarCamposPrincipais()
263: 
264:         *----------------------------------------------------------------------
265:         * CommandGroup Grupo_Salva: "Gerar O.P." + "Encerrar"
266:         *----------------------------------------------------------------------
267:         THIS.AddObject("grp_4c_GrupoSalva", "CommandGroup")
268:         WITH THIS.grp_4c_GrupoSalva
269:             .Top           = -1
270:             .Left          = 673
271:             .Width         = 160
272:             .Height        = 85
273:             .AutoSize      = .T.
274:             .ButtonCount   = 2
275:             .BorderStyle   = 0
276:             .SpecialEffect = 1
277:             .BorderColor   = RGB(100, 100, 100)
278:             .Themes        = .F.
279:             .Visible       = .T.
280:         ENDWITH
281:         WITH THIS.grp_4c_GrupoSalva.Buttons(1)
282:             .Top             = 5
283:             .Left            = 5
284:             .Height          = 75
285:             .Width           = 75
286:             .Caption         = "\<Gerar O.P."
287:             .FontBold        = .T.
288:             .FontItalic      = .T.
289:             .FontName        = "Tahoma"
290:             .FontSize        = 8
291:             .ForeColor       = RGB(90, 90, 90)
292:             .BackColor       = RGB(255, 255, 255)
293:             .Themes          = .F.
294:             .PicturePosition = 13
295:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
296:         ENDWITH
297:         WITH THIS.grp_4c_GrupoSalva.Buttons(2)

*-- Linhas 375 a 418:
375:     * Labels (OP/Produto), TextBoxes de entrada (Get_OP/Get_Produto) e EditBoxes
376:     * de observacao (Get_obss/fwmemo_obs). Chamado por ConfigurarControles.
377:     *==========================================================================
378:     PROTECTED PROCEDURE ConfigurarCamposPrincipais()
379:         *----------------------------------------------------------------------
380:         * Label "OP :"
381:         *----------------------------------------------------------------------
382:         THIS.AddObject("lbl_4c_Op", "Label")
383:         WITH THIS.lbl_4c_Op
384:             .Top       = 87
385:             .Left      = 41
386:             .Width     = 23
387:             .Height    = 15
388:             .Caption   = "OP :"
389:             .ForeColor = RGB(90, 90, 90)
390:             .BackStyle = 0
391:             .Visible   = .T.
392:         ENDWITH
393: 
394:         *----------------------------------------------------------------------
395:         * TextBox Get_OP: entrada do numero da OP
396:         *----------------------------------------------------------------------
397:         THIS.AddObject("txt_4c_Op", "TextBox")
398:         WITH THIS.txt_4c_Op
399:             .Top           = 83
400:             .Left          = 67
401:             .Width         = 108
402:             .Height        = 23
403:             .Alignment     = 3
404:             .Format        = "K"
405:             .InputMask     = "999999999999"
406:             .MaxLength     = 12
407:             .SpecialEffect = 1
408:             .BorderColor   = RGB(100, 100, 100)
409:             .Value         = " "
410:             .Visible       = .T.
411:         ENDWITH
412: 
413:         *----------------------------------------------------------------------
414:         * Label "Produto :"
415:         *----------------------------------------------------------------------
416:         THIS.AddObject("lbl_4c_Produto", "Label")
417:         WITH THIS.lbl_4c_Produto
418:             .Top       = 87

*-- Linhas 483 a 526:
483:     * 7 colunas: Pedido | Cliente | Cor | Tam | Qtd.Op | QtdDivs | Quantidade
484:     * Nota: Column2=QtdEtiqs, Column4=QtdDivs sao editaveis pelo usuario
485:     *==========================================================================
486:     PROTECTED PROCEDURE ConfigurarGrade()
487:         LOCAL loc_oGrd
488:         THIS.AddObject("grd_4c_Grade", "Grid")
489:         loc_oGrd = THIS.grd_4c_Grade
490:         WITH loc_oGrd
491:             .Top           = 121
492:             .Left          = 11
493:             .Width         = 626
494:             .Height        = 293
495:             .FontName      = "Arial"
496:             .FontSize      = 8
497:             .ColumnCount   = 7
498:             .DeleteMark    = .F.
499:             .GridLines     = 3
500:             .GridLineWidth = 1
501:             .GridLineColor = RGB(238, 238, 238)
502:             .HeaderHeight  = 17
503:             .RecordMark    = .F.
504:             .RowHeight     = 17
505:             .ScrollBars    = 2
506:             .ForeColor     = RGB(0, 0, 0)
507:             .BackColor     = RGB(255, 255, 255)
508:             .RecordSource  = "Temp_DivOp"
509:             .Visible       = .T.
510:         ENDWITH
511: 
512:         *-- Column1: Pedido (expressao Dopes + Numes - readonly)
513:         WITH loc_oGrd.Column1
514:             .Header1.Caption     = "Pedido"
515:             .Header1.Alignment   = 2
516:             .Header1.BackColor   = RGB(192, 192, 192)
517:             .ControlSource       = "ALLTRIM(Temp_DivOp.Dopes)+' '+ALLTRIM(STR(Temp_DivOp.Numes,6))"
518:             .Text1.ReadOnly      = .T.
519:             .Text1.BorderStyle   = 0
520:             .Text1.Alignment     = 0
521:             .Text1.Margin        = 0
522:             .Width               = 160
523:             .Movable             = .F.
524:             .Resizable           = .F.
525:             .ReadOnly            = .T.
526:         ENDWITH

*-- Linhas 626 a 669:
626:     * ConfigurarGrade2 - Grade resultado (Temporario - oculto ate geracao)
627:     * 7 colunas: O.P. | Pedido | Cliente | Cor | Tam | Quantidade | Peso
628:     *==========================================================================
629:     PROTECTED PROCEDURE ConfigurarGrade2()
630:         LOCAL loc_oGrd
631:         THIS.AddObject("grd_4c_Grade2", "Grid")
632:         loc_oGrd = THIS.grd_4c_Grade2
633:         WITH loc_oGrd
634:             .Top           = 121
635:             .Left          = 11
636:             .Width         = 626
637:             .Height        = 293
638:             .FontName      = "Arial"
639:             .FontSize      = 8
640:             .ColumnCount   = 7
641:             .DeleteMark    = .F.
642:             .RecordMark    = .F.
643:             .GridLineWidth = 1
644:             .GridLineColor = RGB(136, 189, 188)
645:             .HeaderHeight  = 17
646:             .RowHeight     = 17
647:             .ScrollBars    = 2
648:             .ForeColor     = RGB(0, 0, 0)
649:             .BackColor     = RGB(255, 255, 255)
650:             .RecordSource  = "Temporario"
651:             .ReadOnly      = .T.
652:             .Enabled       = .F.
653:             .Visible       = .F.
654:         ENDWITH
655: 
656:         *-- Column1: Pedido
657:         WITH loc_oGrd.Column1
658:             .Header1.Caption     = "Pedido"
659:             .Header1.Alignment   = 2
660:             .Header1.BackColor   = RGB(192, 192, 192)
661:             .ControlSource       = "ALLTRIM(Temporario.Dopes)+' '+ALLTRIM(STR(Temporario.Numes,6))"
662:             .Text1.ReadOnly      = .T.
663:             .Text1.Alignment     = 0
664:             .Text1.BorderStyle   = 0
665:             .Text1.Margin        = 0
666:             .Text1.Enabled       = .F.
667:             .Width               = 205
668:             .ColumnOrder         = 2
669:             .Movable             = .F.

*-- Linhas 783 a 1006:
783:     *==========================================================================
784:     * ConfigurarPaginaLista - Define estado inicial do form operacional:
785:     * Grade principal visivel, Grade2 oculta, GrupoSalva ativo.
786:     * Chamado em InicializarForm e ao retornar do estado de revisao.
787:     *==========================================================================
788:     PROCEDURE ConfigurarPaginaLista()
789:         WITH THIS.grd_4c_Grade
790:             .Enabled = .T.
791:             .Visible = .T.
792:         ENDWITH
793:         WITH THIS.grd_4c_Grade2
794:             .Enabled = .F.
795:             .Visible = .F.
796:         ENDWITH
797:         WITH THIS.edt_4c_Obss
798:             .Enabled = .T.
799:             .Visible = .T.
800:         ENDWITH
801:         WITH THIS.edt_4c_MemoObs
802:             .Enabled = .F.
803:             .Visible = .F.
804:         ENDWITH
805:         WITH THIS.grp_4c_GrupoSalva
806:             .Enabled = .T.
807:             .Visible = .T.
808:         ENDWITH
809:         WITH THIS.grp_4c_GrupoConf
810:             .Enabled = .F.
811:             .Visible = .F.
812:         ENDWITH
813:     ENDPROC
814: 
815:     *==========================================================================
816:     * AlternarPagina - Alterna estado visual do form operacional
817:     * par_nPagina: 1 = Entrada (Grade principal + GrupoSalva)
818:     *              2 = Revisao (Grade2 resultado + GrupoConf)
819:     * Sobrescreve FormBase.AlternarPagina que usa pgf_4c_Paginas inexistente.
820:     *==========================================================================
821:     PROCEDURE AlternarPagina(par_nPagina)
822:         DO CASE
823:         CASE par_nPagina = 1
824:             THIS.ConfigurarPaginaLista()
825:             THIS.grd_4c_Grade.Refresh()
826:         CASE par_nPagina = 2
827:             WITH THIS.grd_4c_Grade
828:                 .Enabled = .F.
829:                 .Visible = .F.
830:             ENDWITH
831:             WITH THIS.grd_4c_Grade2
832:                 .Enabled = .T.
833:                 .Visible = .T.
834:                 .Refresh()
835:             ENDWITH
836:             WITH THIS.edt_4c_Obss
837:                 .Enabled = .F.
838:                 .Visible = .F.
839:             ENDWITH
840:             WITH THIS.edt_4c_MemoObs
841:                 .Enabled = .T.
842:                 .Visible = .T.
843:             ENDWITH
844:             WITH THIS.grp_4c_GrupoSalva
845:                 .Enabled = .F.
846:                 .Visible = .F.
847:             ENDWITH
848:             WITH THIS.grp_4c_GrupoConf
849:                 .Enabled = .T.
850:                 .Visible = .T.
851:             ENDWITH
852:         ENDCASE
853:     ENDPROC
854: 
855:     *==========================================================================
856:     * ValidarAcessoOp - Get_OP.When do legado
857:     * Permite digitacao apenas enquanto Temporario estiver vazio
858:     *==========================================================================
859:     PROCEDURE ValidarAcessoOp()
860:         RETURN RECCOUNT("Temporario") = 0
861:     ENDPROC
862: 
863:     *==========================================================================
864:     * ValidarOp - Get_OP.KeyPress (substituto do Valid; regra #3)
865:     * Dispara a validacao apenas em ENTER(13) ou TAB(9). O guard de tecla eh
866:     * obrigatorio: sem ele a consulta rodaria a cada caractere (regra #47).
867:     *==========================================================================
868:     PROCEDURE ValidarOp(par_nKeyCode, par_nShiftAltCtrl)
869:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
870:             RETURN
871:         ENDIF
872:         IF THIS.this_lEmValidacao
873:             RETURN
874:         ENDIF
875: 
876:         THIS.this_lEmValidacao = .T.
877:         THIS.ValidarOpExec()
878:         THIS.this_lEmValidacao = .F.
879:     ENDPROC
880: 
881:     *==========================================================================
882:     * ValidarOpExec - corpo do Get_OP.Valid do legado
883:     * Valida OP e carrega Temp_DivOp / xNensi via BO.BuscarOP.
884:     * Separado do wrapper porque o corpo tem RETURN antecipado (regra #47).
885:     *==========================================================================
886:     PROCEDURE ValidarOpExec()
887:         LOCAL loc_nOp, loc_lSucesso, loc_oErro
888:         loc_lSucesso = .F.
889: 
890:         IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
891:             RETURN .T.
892:         ENDIF
893: 
894:         IF LEN(ALLTRIM(THIS.txt_4c_Op.Value)) > 10
895:             THIS.txt_4c_Op.Value = RIGHT(ALLTRIM(THIS.txt_4c_Op.Value), 10)
896:         ENDIF
897: 
898:         loc_nOp = VAL(THIS.txt_4c_Op.Value)
899: 
900:         TRY
901:             loc_lSucesso = THIS.this_oBusinessObject.BuscarOP(loc_nOp)
902:         CATCH TO loc_oErro
903:             MsgErro(loc_oErro.Message, "Erro em ValidarOpExec")
904:             loc_lSucesso = .F.
905:         ENDTRY
906: 
907:         IF loc_lSucesso
908:             THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
909:             THIS.grd_4c_Grade.Refresh()
910:         ELSE
911:             THIS.txt_4c_Op.Value      = " "
912:             THIS.txt_4c_Produto.Value = " "
913:         ENDIF
914: 
915:         *-- Registra o valor processado para o guard de valor-nao-mudou do
916:         *-- OpLostFocus (evita reconsultar a mesma OP ao sair do campo).
917:         THIS.this_cOpValidada = ALLTRIM(THIS.txt_4c_Op.Value)
918: 
919:         RETURN loc_lSucesso
920:     ENDPROC
921: 
922:     *==========================================================================
923:     * OpLostFocus - Get_OP.LostFocus do legado
924:     * O Valid do legado dispara ao SAIR do campo por QUALQUER meio, inclusive
925:     * clique do mouse - entao a saida por mouse tambem valida aqui, guardada
926:     * pelo valor-nao-mudou para nao repetir a consulta que o ENTER/TAB ja fez.
927:     * Depois reproduz o LostFocus: se a OP carregou, foco vai para a grade.
928:     * LostFocus NAO passa parametro (regra #47) - sem (par_nKeyCode, ...).
929:     *==========================================================================
930:     PROCEDURE OpLostFocus()
931:         IF THIS.this_lEmValidacao
932:             RETURN
933:         ENDIF
934:         THIS.this_lEmValidacao = .T.
935: 
936:         IF ALLTRIM(THIS.txt_4c_Op.Value) <> ALLTRIM(THIS.this_cOpValidada)
937:             THIS.ValidarOpExec()
938:         ENDIF
939: 
940:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND ;
941:            USED("Temp_DivOp") AND !EOF("Temp_DivOp")
942:             THIS.grd_4c_Grade.Column2.Text1.SetFocus()
943:         ENDIF
944: 
945:         THIS.this_lEmValidacao = .F.
946:     ENDPROC
947: 
948:     *==========================================================================
949:     * GrupoSalvaClick - Grupo_Salva.Click
950:     * Botao 1 (Gerar O.P.): valida e chama BO.GerarNovaOP
951:     * Botao 2 (Encerrar): rollback e fecha
952:     *==========================================================================
953:     PROCEDURE GrupoSalvaClick()
954:         LOCAL loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs
955:         LOCAL loc_lSucesso, loc_oErro
956: 
957:         IF THIS.grp_4c_GrupoSalva.Value = 2
958:             ON KEY LABEL ENTER
959:             THIS.this_oBusinessObject.RollbackTransacao()
960:             THIS.Release()
961:             RETURN
962:         ENDIF
963: 
964:         *-- Botao 1: Gerar O.P.
965:         IF EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) OR VAL(THIS.txt_4c_Op.Value) = 0
966:             MsgAviso("OP n" + CHR(227) + "o informada!!", "Aviso")
967:             THIS.txt_4c_Op.SetFocus()
968:             RETURN
969:         ENDIF
970: 
971:         loc_nOp       = VAL(THIS.txt_4c_Op.Value)
972:         loc_nQtds     = 0
973:         loc_nQtdDivs  = 0
974:         loc_nQtdEtiqs = 0
975: 
976:         *-- Somar quantidades de Temp_DivOp para validacao
977:         IF USED("Temp_DivOp") AND RECCOUNT("Temp_DivOp") > 0
978:             SELECT SUM(Qtds) AS SQtds, SUM(QtdDivs) AS SQtdDivs, SUM(QtdEtiqs) AS SQtdEtiqs ;
979:                 FROM Temp_DivOp INTO CURSOR cursor_4c_SumTmpDiv
980:             SELECT cursor_4c_SumTmpDiv
981:             GO TOP
982:             loc_nQtds     = NVL(cursor_4c_SumTmpDiv.SQtds,     0)
983:             loc_nQtdDivs  = NVL(cursor_4c_SumTmpDiv.SQtdDivs,  0)
984:             loc_nQtdEtiqs = NVL(cursor_4c_SumTmpDiv.SQtdEtiqs, 0)
985:             USE IN cursor_4c_SumTmpDiv
986:         ENDIF
987: 
988:         ON KEY LABEL ENTER
989: 
990:         *-- Delegar para BO
991:         loc_lSucesso = .F.
992:         TRY
993:             loc_lSucesso = THIS.this_oBusinessObject.GerarNovaOP(;
994:                 THIS.this_cOperacao, loc_nOp, loc_nQtds, loc_nQtdDivs, loc_nQtdEtiqs)
995:         CATCH TO loc_oErro
996:             MsgErro(loc_oErro.Message, "Erro em GrupoSalvaClick")
997:         ENDTRY
998: 
999:         IF loc_lSucesso
1000:             IF THIS.this_cOperacao = "D"
1001:                 *-- Divisao: ir para estado de revisao (Grade2 + GrupoConf)
1002:                 IF USED("Temp_DivOp")
1003:                     SELECT Temp_DivOp
1004:                     ZAP
1005:                 ENDIF
1006:                 SELECT Temporario

*-- Linhas 1044 a 1366:
1044:     * Botao 1 (Confirmar): persiste Obss e faz COMMIT via BO
1045:     * Botao 2 (Encerrar): rollback e fecha
1046:     *==========================================================================
1047:     PROCEDURE GrupoConfClick()
1048:         LOCAL loc_lSucesso, loc_oErro
1049: 
1050:         IF THIS.grp_4c_GrupoConf.Value = 2
1051:             ON KEY LABEL ENTER
1052:             THIS.this_oBusinessObject.RollbackTransacao()
1053:             THIS.Release()
1054:             RETURN
1055:         ENDIF
1056: 
1057:         *-- Botao 1: Confirmar
1058:         loc_lSucesso = .F.
1059:         TRY
1060:             loc_lSucesso = THIS.this_oBusinessObject.ConfirmarGravacao()
1061:         CATCH TO loc_oErro
1062:             MsgErro(loc_oErro.Message, "Erro em GrupoConfClick")
1063:         ENDTRY
1064: 
1065:         IF loc_lSucesso
1066:             IF USED("Temporario")
1067:                 SELECT Temporario
1068:                 ZAP
1069:             ENDIF
1070:             THIS.txt_4c_Op.Value      = " "
1071:             THIS.txt_4c_Produto.Value = " "
1072:             THIS.AlternarPagina(1)
1073: 
1074:             IF !THIS.this_lAutomatico
1075:                 THIS.txt_4c_Op.SetFocus()
1076:             ENDIF
1077:             THIS.Refresh()
1078:         ENDIF
1079:     ENDPROC
1080: 
1081:     *==========================================================================
1082:     * GradeAfterRowColChange - Grade.AfterRowColChange
1083:     * Atualiza editbox de observacao ao navegar entre linhas
1084:     *==========================================================================
1085:     PROCEDURE GradeAfterRowColChange(par_nColIndex)
1086:         THIS.edt_4c_Obss.Refresh()
1087:     ENDPROC
1088: 
1089:     *==========================================================================
1090:     * Grade2AfterRowColChange - Grade2.AfterRowColChange
1091:     * Atualiza editbox de observacao ao navegar entre OPs geradas
1092:     *==========================================================================
1093:     PROCEDURE Grade2AfterRowColChange(par_nColIndex)
1094:         THIS.edt_4c_MemoObs.Refresh()
1095:     ENDPROC
1096: 
1097:     *==========================================================================
1098:     * ValidarQtdDivisaoExec - corpo do Grade.Column4.Text1.Valid do legado
1099:     * Regras: QtdDivs e QtdEtiqs mutuamente exclusivos; nao pode exceder Qtds
1100:     *==========================================================================
1101:     PROCEDURE ValidarQtdDivisaoExec()
1102:         LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
1103:         loc_lOk       = .T.
1104:         loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
1105:         loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value
1106: 
1107:         IF loc_nValEtiq > 0 AND loc_nValDivisao > 0
1108:             MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
1109:             THIS.grd_4c_Grade.Column4.Text1.Value = 0
1110:             loc_lOk = .F.
1111:         ENDIF
1112: 
1113:         IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1114:             IF loc_nValDivisao > Temp_DivOp.Qtds
1115:                 MsgAviso("Quantidade a dividir n" + CHR(227) + ;
1116:                          "o pode ser maior que a quantidade do Pedido...", "Aviso")
1117:                 THIS.grd_4c_Grade.Column4.Text1.Value = 0
1118:                 loc_lOk = .F.
1119:             ENDIF
1120:         ENDIF
1121: 
1122:         RETURN loc_lOk
1123:     ENDPROC
1124: 
1125:     *==========================================================================
1126:     * ValidarAcessoQtdDivisao - Grade.Column4.Text1.When do legado
1127:     * Define ENTER para avancar linha (DNARROW) quando em QtdDivs
1128:     *==========================================================================
1129:     PROCEDURE ValidarAcessoQtdDivisao()
1130:         ON KEY LABEL ENTER KEYBOARD "{DNARROW}"
1131:         RETURN .T.
1132:     ENDPROC
1133: 
1134:     *==========================================================================
1135:     * ValidarQtdDivisao - Grade.Column4.Text1.KeyPress (substituto do Valid)
1136:     * Guard de tecla OBRIGATORIO (regra #47): sem ele a validacao rodava a
1137:     * cada caractere, zerando a celula no meio da digitacao.
1138:     *==========================================================================
1139:     PROCEDURE ValidarQtdDivisao(par_nKeyCode, par_nShiftAltCtrl)
1140:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1141:             RETURN
1142:         ENDIF
1143:         IF THIS.this_lEmValidacao
1144:             RETURN
1145:         ENDIF
1146: 
1147:         THIS.this_lEmValidacao = .T.
1148:         THIS.ValidarQtdDivisaoExec()
1149:         THIS.this_lEmValidacao = .F.
1150:     ENDPROC
1151: 
1152:     *==========================================================================
1153:     * QtdDivisaoLostFocus - saida da celula por MOUSE
1154:     * O Valid do legado dispara ao sair da celula por qualquer meio; o
1155:     * KeyPress cobre ENTER/TAB e este cobre o clique fora. A guarda de
1156:     * reentrancia eh obrigatoria porque o Exec abre MsgAviso (modal) e zera
1157:     * a celula - as duas coisas redisparam o proprio LostFocus (regra #47).
1158:     * LostFocus NAO passa parametro - sem (par_nKeyCode, par_nShiftAltCtrl).
1159:     *==========================================================================
1160:     PROCEDURE QtdDivisaoLostFocus()
1161:         IF THIS.this_lEmValidacao
1162:             RETURN
1163:         ENDIF
1164: 
1165:         THIS.this_lEmValidacao = .T.
1166:         THIS.ValidarQtdDivisaoExec()
1167:         THIS.this_lEmValidacao = .F.
1168:     ENDPROC
1169: 
1170:     *==========================================================================
1171:     * ValidarQtdEtiquetas - Grade.Column2.Text1.KeyPress (substituto do Valid)
1172:     *==========================================================================
1173:     PROCEDURE ValidarQtdEtiquetas(par_nKeyCode, par_nShiftAltCtrl)
1174:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1175:             RETURN
1176:         ENDIF
1177:         IF THIS.this_lEmValidacao
1178:             RETURN
1179:         ENDIF
1180: 
1181:         THIS.this_lEmValidacao = .T.
1182:         THIS.ValidarQtdEtiquetasExec()
1183:         THIS.this_lEmValidacao = .F.
1184:     ENDPROC
1185: 
1186:     *==========================================================================
1187:     * QtdEtiquetasLostFocus - saida da celula por MOUSE
1188:     * Mesma guarda de reentrancia do QtdDivisaoLostFocus (regra #47).
1189:     *==========================================================================
1190:     PROCEDURE QtdEtiquetasLostFocus()
1191:         IF THIS.this_lEmValidacao
1192:             RETURN
1193:         ENDIF
1194: 
1195:         THIS.this_lEmValidacao = .T.
1196:         THIS.ValidarQtdEtiquetasExec()
1197:         THIS.this_lEmValidacao = .F.
1198:     ENDPROC
1199: 
1200:     *==========================================================================
1201:     * TornarControlesVisiveis - Torna visiveis todos os controles do form
1202:     * recursivamente, EXCETO containers/controles flutuantes que devem
1203:     * permanecer Visible=.F. ate serem alternados por AlternarPagina(2).
1204:     *
1205:     * Controles flutuantes (estado inicial oculto):
1206:     *   - grd_4c_Grade2      : Grade resultado, aparece apos Gerar O.P.
1207:     *   - edt_4c_MemoObs     : EditBox de obs das OPs geradas
1208:     *   - grp_4c_GrupoConf   : Botoes Confirmar/Encerrar (modo revisao)
1209:     *==========================================================================
1210:     PROCEDURE TornarControlesVisiveis(par_oContainer)
1211:         LOCAL loc_i, loc_j, loc_oCtrl, loc_cNome
1212: 
1213:         IF VARTYPE(par_oContainer) # "O"
1214:             RETURN
1215:         ENDIF
1216: 
1217:         FOR loc_i = 1 TO par_oContainer.ControlCount
1218:             loc_oCtrl = par_oContainer.Controls(loc_i)
1219:             loc_cNome = UPPER(loc_oCtrl.Name)
1220: 
1221:             *-- Controles flutuantes: permanecem ocultos (alternados via AlternarPagina)
1222:             *-- CNT_4C_SOMBRA: visibilidade gerenciada por ConfigurarPageFrame
1223:             IF INLIST(loc_cNome, ;
1224:                     "GRD_4C_GRADE2",    ;
1225:                     "EDT_4C_MEMOOBS",   ;
1226:                     "GRP_4C_GRUPOCONF", ;
1227:                     "CNT_4C_SOMBRA")
1228:                 LOOP
1229:             ENDIF
1230: 
1231:             IF PEMSTATUS(loc_oCtrl, "Visible", 5)
1232:                 loc_oCtrl.Visible = .T.
1233:             ENDIF
1234: 
1235:             *-- Recursao em Containers
1236:             IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
1237:                 IF loc_oCtrl.ControlCount > 0
1238:                     THIS.TornarControlesVisiveis(loc_oCtrl)
1239:                 ENDIF
1240:             ENDIF
1241: 
1242:             *-- Recursao em Pages de PageFrame
1243:             IF UPPER(loc_oCtrl.BaseClass) = "PAGEFRAME"
1244:                 FOR loc_j = 1 TO loc_oCtrl.PageCount
1245:                     THIS.TornarControlesVisiveis(loc_oCtrl.Pages(loc_j))
1246:                 ENDFOR
1247:             ENDIF
1248:         ENDFOR
1249: 
1250:         loc_oCtrl = .NULL.
1251:     ENDPROC
1252: 
1253:     *==========================================================================
1254:     * ValidarQtdEtiquetasExec - corpo do Grade.Column2.Text1.Valid do legado
1255:     * Regras: mutuamente exclusivo com QtdDivs; > 1; nao pode exceder Qtds
1256:     *==========================================================================
1257:     PROCEDURE ValidarQtdEtiquetasExec()
1258:         LOCAL loc_lOk, loc_nValDivisao, loc_nValEtiq
1259:         loc_lOk         = .T.
1260:         loc_nValDivisao = THIS.grd_4c_Grade.Column4.Text1.Value
1261:         loc_nValEtiq    = THIS.grd_4c_Grade.Column2.Text1.Value
1262: 
1263:         IF loc_nValDivisao > 0 AND loc_nValEtiq > 0
1264:             MsgAviso("Informe Somente Qtde Divis" + CHR(227) + "o ou Qtde de Etiquetas...", "Aviso")
1265:             THIS.grd_4c_Grade.Column2.Text1.Value = 0
1266:             loc_lOk = .F.
1267:         ENDIF
1268: 
1269:         IF loc_lOk AND loc_nValEtiq = 1
1270:             MsgAviso("Informe somente Qtde maior que 1.", "Aviso")
1271:             THIS.grd_4c_Grade.Column2.Text1.Value = 0
1272:             loc_lOk = .F.
1273:         ENDIF
1274: 
1275:         IF loc_lOk AND USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1276:             IF loc_nValEtiq > Temp_DivOp.Qtds
1277:                 MsgAviso("Quantidade de Etiquetas n" + CHR(227) + ;
1278:                          "o pode ser maior que a quantidade do Pedido...", "Aviso")
1279:                 THIS.grd_4c_Grade.Column2.Text1.Value = 0
1280:                 loc_lOk = .F.
1281:             ENDIF
1282:         ENDIF
1283: 
1284:         RETURN loc_lOk
1285:     ENDPROC
1286: 
1287:     *==========================================================================
1288:     * ValidarAcessoQtdEtiquetas - Grade.Column2.Text1.When do legado
1289:     * Limpa binding ENTER (cancelando atalho de Column4) e libera celula
1290:     * apenas quando Qtds > 1 (nao faz sentido dividir em etiquetas se qtd=1)
1291:     *==========================================================================
1292:     PROCEDURE ValidarAcessoQtdEtiquetas()
1293:         ON KEY LABEL ENTER
1294:         IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1295:             RETURN (Temp_DivOp.Qtds > 1)
1296:         ENDIF
1297:         RETURN .F.
1298:     ENDPROC
1299: 
1300:     *==========================================================================
1301:     * MemoObsLostFocus - fwmemo_obs.LostFocus do legado (grade2.Refresh)
1302:     * LostFocus NAO passa parametro (regra #47)
1303:     *==========================================================================
1304:     PROCEDURE MemoObsLostFocus()
1305:         IF THIS.grd_4c_Grade2.Visible
1306:             THIS.grd_4c_Grade2.Refresh()
1307:         ENDIF
1308:     ENDPROC
1309: 
1310:     *==========================================================================
1311:     * ObssLostFocus - Get_obss.LostFocus do legado (grade2.Refresh)
1312:     * LostFocus NAO passa parametro (regra #47)
1313:     *==========================================================================
1314:     PROCEDURE ObssLostFocus()
1315:         IF THIS.grd_4c_Grade2.Visible
1316:             THIS.grd_4c_Grade2.Refresh()
1317:         ENDIF
1318:     ENDPROC
1319: 
1320:     *==========================================================================
1321:     * ExecutarModoAutomatico - Execucao automatica para divisao programatica
1322:     * par_aNop: array [n,1]=Dopes, [n,2]=Numes, [n,3]=CodCors, [n,4]=CodTams,
1323:     *           [n,5]=Emps, [n,6]=Nops, [n,7]=NovaOp(out), [n,8]=Qtds,
1324:     *           [n,9]=QtdsGeradas(out)
1325:     *==========================================================================
1326:     PROCEDURE ExecutarModoAutomatico(par_aNop)
1327:         LOCAL loc_nCnt, loc_llOk, loc_nOp
1328: 
1329:         IF TYPE("par_aNop", 1) # "A"
1330:             RETURN .F.
1331:         ENDIF
1332: 
1333:         THIS.this_lAutomatico = .T.
1334:         THIS.Visible = .F.
1335: 
1336:         *-- Simular entrada de OP (primeiro elemento)
1337:         loc_nOp = par_aNop[1, 6]
1338:         THIS.txt_4c_Op.Value = ALLTRIM(STR(loc_nOp))
1339:         THIS.ValidarOpExec()
1340: 
1341:         SELECT Temp_DivOp
1342:         IF RECCOUNT() = 0
1343:             RETURN .F.
1344:         ENDIF
1345: 
1346:         *-- Distribuir QtdDivs conforme array
1347:         loc_llOk = .F.
1348:         FOR loc_nCnt = 1 TO ALEN(par_aNop, 1)
1349:             SELECT Temp_DivOp
1350:             GO TOP
1351:             LOCATE FOR Dopes   = par_aNop[loc_nCnt, 1] AND ;
1352:                        Numes   = par_aNop[loc_nCnt, 2] AND ;
1353:                        CodCors = par_aNop[loc_nCnt, 3] AND ;
1354:                        CodTams = par_aNop[loc_nCnt, 4]
1355:             IF !EOF()
1356:                 REPLACE QtdDivs WITH QtdDivs + par_aNop[loc_nCnt, 8]
1357:                 loc_llOk = .T.
1358:             ENDIF
1359:         ENDFOR
1360: 
1361:         IF !loc_llOk
1362:             RETURN .F.
1363:         ENDIF
1364: 
1365:         *-- Executar geracao
1366:         THIS.GrupoSalvaClick()

*-- Linhas 1392 a 1654:
1392:     * Ao ser acionado (por atalho herdado ou automacao), delega para o fluxo
1393:     * operacional principal: valida OP digitada e gera as novas OPs divididas.
1394:     *==========================================================================
1395:     PROCEDURE BtnIncluirClick()
1396:         THIS.grp_4c_GrupoSalva.Value = 1
1397:         THIS.GrupoSalvaClick()
1398:     ENDPROC
1399: 
1400:     *==========================================================================
1401:     * BtnAlterarClick - Override de FormBase.BtnAlterarClick
1402:     * Form OPERACIONAL: alteracao corresponde a revisao da divisao gerada.
1403:     * Se Grade2 estiver ativa (estado de revisao), move foco para coluna O.P.
1404:     * para o usuario editar as novas OPs. Caso contrario, posiciona foco na
1405:     * coluna de divisao da grade principal para iniciar a alteracao.
1406:     *==========================================================================
1407:     PROCEDURE BtnAlterarClick()
1408:         IF THIS.grd_4c_Grade2.Visible
1409:             THIS.grd_4c_Grade2.Column2.Text1.SetFocus()
1410:         ELSE
1411:             IF USED("Temp_DivOp") AND !EOF("Temp_DivOp")
1412:                 THIS.grd_4c_Grade.Column4.Text1.SetFocus()
1413:             ELSE
1414:                 THIS.txt_4c_Op.SetFocus()
1415:             ENDIF
1416:         ENDIF
1417:     ENDPROC
1418: 
1419:     *==========================================================================
1420:     * BtnVisualizarClick - Override de FormBase.BtnVisualizarClick
1421:     * Form OPERACIONAL: visualizacao corresponde ao estado de revisao da
1422:     * divisao (Grade2). Alterna para pagina de revisao se houver Temporario
1423:     * preenchido; caso contrario, mantem estado atual e move foco para OP.
1424:     *==========================================================================
1425:     PROCEDURE BtnVisualizarClick()
1426:         IF USED("Temporario") AND RECCOUNT("Temporario") > 0
1427:             THIS.AlternarPagina(2)
1428:         ELSE
1429:             THIS.txt_4c_Op.SetFocus()
1430:         ENDIF
1431:     ENDPROC
1432: 
1433:     *==========================================================================
1434:     * BtnExcluirClick - Override de FormBase.BtnExcluirClick
1435:     * Form OPERACIONAL: exclusao equivale a rollback da transacao em curso.
1436:     * Confirma com usuario; se aprovado, faz rollback no BO e volta para
1437:     * estado inicial de entrada (Grade principal + GrupoSalva).
1438:     *==========================================================================
1439:     PROCEDURE BtnExcluirClick()
1440:         LOCAL loc_lConfirma
1441:         loc_lConfirma = MsgConfirma("Cancelar a divis" + CHR(227) + ;
1442:                                     "o em andamento e descartar altera" + ;
1443:                                     CHR(231) + CHR(245) + "es?", "Confirma" + ;
1444:                                     CHR(231) + CHR(227) + "o")
1445:         IF !loc_lConfirma
1446:             RETURN
1447:         ENDIF
1448: 
1449:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1450:            VARTYPE(THIS.this_oBusinessObject) = "O"
1451:             THIS.this_oBusinessObject.RollbackTransacao()
1452:         ENDIF
1453: 
1454:         IF USED("Temp_DivOp")
1455:             SELECT Temp_DivOp
1456:             ZAP
1457:         ENDIF
1458:         IF USED("Temporario")
1459:             SELECT Temporario
1460:             ZAP
1461:         ENDIF
1462:         IF USED("xNensi")
1463:             SELECT xNensi
1464:             ZAP
1465:         ENDIF
1466: 
1467:         THIS.txt_4c_Op.Value      = " "
1468:         THIS.txt_4c_Produto.Value = " "
1469:         THIS.AlternarPagina(1)
1470:         THIS.txt_4c_Op.SetFocus()
1471:         THIS.Refresh()
1472:     ENDPROC
1473: 
1474:     *==========================================================================
1475:     * BtnBuscarClick - Override de FormBase.BtnBuscarClick
1476:     * Form OPERACIONAL: re-executa a validacao e carga da OP corrente.
1477:     * Permite ao usuario recarregar o grid caso os dados tenham sido
1478:     * alterados externamente sem precisar limpar e redigitar a OP.
1479:     *==========================================================================
1480:     PROCEDURE BtnBuscarClick()
1481:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
1482:             THIS.ValidarOpExec()
1483:         ELSE
1484:             THIS.txt_4c_Op.SetFocus()
1485:         ENDIF
1486:     ENDPROC
1487: 
1488:     *==========================================================================
1489:     * BtnEncerrarClick - Override de FormBase.BtnEncerrarClick
1490:     * Form OPERACIONAL: faz rollback da transacao em aberto e fecha o form.
1491:     * Equivale a clicar "Encerrar" nos CommandGroups de Salva ou Conf.
1492:     *==========================================================================
1493:     PROCEDURE BtnEncerrarClick()
1494:         ON KEY LABEL ENTER
1495:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1496:            VARTYPE(THIS.this_oBusinessObject) = "O"
1497:             THIS.this_oBusinessObject.RollbackTransacao()
1498:         ENDIF
1499:         THIS.Release()
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * BtnSalvarClick - Override de FormBase.BtnSalvarClick
1504:     * Form OPERACIONAL: delega para o CommandGroup ativo.
1505:     * Se estiver em modo revisao (GrupoConf visivel) -> ConfirmarGravacao.
1506:     * Se estiver em modo entrada (GrupoSalva visivel) -> GerarNovaOP.
1507:     *==========================================================================
1508:     PROCEDURE BtnSalvarClick()
1509:         IF THIS.grp_4c_GrupoConf.Visible AND THIS.grp_4c_GrupoConf.Enabled
1510:             THIS.grp_4c_GrupoConf.Value = 1
1511:             THIS.GrupoConfClick()
1512:         ELSE
1513:             THIS.grp_4c_GrupoSalva.Value = 1
1514:             THIS.GrupoSalvaClick()
1515:         ENDIF
1516:     ENDPROC
1517: 
1518:     *==========================================================================
1519:     * BtnCancelarClick - Override de FormBase.BtnCancelarClick
1520:     * Form OPERACIONAL: cancela a divisao em andamento, faz rollback e
1521:     * retorna ao estado inicial de entrada sem pedir confirmacao.
1522:     *==========================================================================
1523:     PROCEDURE BtnCancelarClick()
1524:         ON KEY LABEL ENTER
1525:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1526:            VARTYPE(THIS.this_oBusinessObject) = "O"
1527:             THIS.this_oBusinessObject.RollbackTransacao()
1528:         ENDIF
1529: 
1530:         IF USED("Temp_DivOp")
1531:             SELECT Temp_DivOp
1532:             ZAP
1533:         ENDIF
1534:         IF USED("Temporario")
1535:             SELECT Temporario
1536:             ZAP
1537:         ENDIF
1538:         IF USED("xNensi")
1539:             SELECT xNensi
1540:             ZAP
1541:         ENDIF
1542: 
1543:         THIS.txt_4c_Op.Value      = " "
1544:         THIS.txt_4c_Produto.Value = " "
1545:         THIS.AlternarPagina(1)
1546:         THIS.txt_4c_Op.SetFocus()
1547:         THIS.Refresh()
1548:     ENDPROC
1549: 
1550:     *==========================================================================
1551:     * FormParaBO - Transfere estado do form para propriedades do BO
1552:     * Form OPERACIONAL: propaga numero da OP, operacao e empresa corrente.
1553:     * Chamado antes de qualquer persistencia (GerarNovaOP/ConfirmarGravacao).
1554:     *==========================================================================
1555:     PROCEDURE FormParaBO()
1556:         THIS.this_oBusinessObject.this_nNops     = THIS.txt_4c_Op.Value
1557:         THIS.this_oBusinessObject.this_cOperacao = THIS.this_cOperacao
1558:         THIS.this_oBusinessObject.this_cEmps     = go_4c_Sistema.cCodEmpresa
1559:     ENDPROC
1560: 
1561:     *==========================================================================
1562:     * BOParaForm - Transfere estado do BO para os controles do form
1563:     * Form OPERACIONAL: atualiza campo de produto apos carga da OP.
1564:     *==========================================================================
1565:     PROCEDURE BOParaForm()
1566:         THIS.txt_4c_Produto.Value = THIS.this_oBusinessObject.this_cProduto
1567:     ENDPROC
1568: 
1569:     *==========================================================================
1570:     * HabilitarCampos - Habilita ou desabilita controles de entrada
1571:     * Form OPERACIONAL: Get_OP editavel apenas enquanto Temporario estiver
1572:     * vazio (antes de gerar as OPs). Get_Produto sempre readonly.
1573:     *==========================================================================
1574:     PROCEDURE HabilitarCampos(par_lHabilitar)
1575:         LOCAL loc_lOpHabilitada
1576:         loc_lOpHabilitada = par_lHabilitar AND (RECCOUNT("Temporario") = 0)
1577:         THIS.txt_4c_Op.Enabled = loc_lOpHabilitada
1578:         THIS.txt_4c_Op.ReadOnly = !loc_lOpHabilitada
1579:     ENDPROC
1580: 
1581:     *==========================================================================
1582:     * LimparCampos - Zera todos os campos e cursores de trabalho
1583:     * Form OPERACIONAL: limpa Get_OP, Get_Produto, Temp_DivOp, Temporario,
1584:     * xNensi e retorna form ao estado inicial (Grade principal + GrupoSalva).
1585:     *==========================================================================
1586:     PROCEDURE LimparCampos()
1587:         THIS.txt_4c_Op.Value      = " "
1588:         THIS.txt_4c_Produto.Value = " "
1589: 
1590:         *-- Invalida o guard de valor-nao-mudou: os cursores sao ZAPados logo
1591:         *-- abaixo, entao reinformar a MESMA OP tem de reconsultar (sem isto a
1592:         *-- saida por mouse acharia que a OP ja estava validada e a grade
1593:         *-- ficaria vazia).
1594:         THIS.this_cOpValidada = ""
1595: 
1596:         IF USED("Temp_DivOp")
1597:             SELECT Temp_DivOp
1598:             ZAP
1599:         ENDIF
1600:         IF USED("Temporario")
1601:             SELECT Temporario
1602:             ZAP
1603:         ENDIF
1604:         IF USED("xNensi")
1605:             SELECT xNensi
1606:             ZAP
1607:         ENDIF
1608: 
1609:         THIS.AlternarPagina(1)
1610:         THIS.Refresh()
1611:     ENDPROC
1612: 
1613:     *==========================================================================
1614:     * CarregarLista - Recarrega o grid principal para a OP corrente
1615:     * Form OPERACIONAL: se OP informada, re-executa ValidarOpExec para repopular
1616:     * Temp_DivOp e atualizar o grid; caso contrario, apenas limpa os cursores.
1617:     *==========================================================================
1618:     PROCEDURE CarregarLista()
1619:         IF !EMPTY(ALLTRIM(THIS.txt_4c_Op.Value)) AND VAL(THIS.txt_4c_Op.Value) > 0
1620:             THIS.ValidarOpExec()
1621:         ENDIF
1622:         IF USED("Temp_DivOp")
1623:             THIS.grd_4c_Grade.Refresh()
1624:         ENDIF
1625:     ENDPROC
1626: 
1627:     *==========================================================================
1628:     * AjustarBotoesPorModo - Ajusta visibilidade dos CommandGroups conforme modo
1629:     * Form OPERACIONAL: usa AlternarPagina para controlar GrupoSalva/GrupoConf.
1630:     * Parametro par_cModo: "LISTA"/"ENTRADA" -> pagina 1, "DADOS"/"REVISAO" -> pagina 2.
1631:     *==========================================================================
1632:     PROCEDURE AjustarBotoesPorModo(par_cModo)
1633:         IF VARTYPE(par_cModo) = "C"
1634:             IF UPPER(ALLTRIM(par_cModo)) = "DADOS" OR UPPER(ALLTRIM(par_cModo)) = "REVISAO"
1635:                 THIS.AlternarPagina(2)
1636:             ELSE
1637:                 THIS.AlternarPagina(1)
1638:             ENDIF
1639:         ENDIF
1640:     ENDPROC
1641: 
1642:     *==========================================================================
1643:     * Destroy - Destrutor: rollback seguro + limpeza de key bindings
1644:     *==========================================================================
1645:     PROCEDURE Destroy()
1646:         ON KEY LABEL ENTER
1647:         IF !ISNULL(THIS.this_oBusinessObject) AND ;
1648:            VARTYPE(THIS.this_oBusinessObject) = "O"
1649:             THIS.this_oBusinessObject.RollbackTransacao()
1650:         ENDIF
1651:         DODEFAULT()
1652:     ENDPROC
1653: 
1654: ENDDEFINE

