# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.
- [GRID-WITH] Bloco WITH Grade define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: Grade.RecordSource).
- [GRID-HEADER] Header Caption 'Movimentaçõ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Movimentações Pendentes, Valor. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigOpLrC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1884 linhas total):

*-- Linhas 8 a 51:
8: *       padrao Page1=Lista/Page2=Dados do CRUD - layout customizado com tres
9: *       containers flutuantes (legado: Container1/2/3) que o BO mostra ou
10: *       esconde conforme a operacao e o lado da conta em analise.
11: *       Aberto com: CREATEOBJECT("FormSigOpLrC", oFormPai, cOperacao, nOriDes, oFormCaixa)
12: *       DataSession=1: acessa cursores do form pai (TprMvCab) diretamente
13: *==============================================================================
14: 
15: DEFINE CLASS FormSigOpLrC AS FormBase
16: 
17:     Height       = 600
18:     Width        = 1000
19:     AutoCenter   = .T.
20:     ShowTips     = .T.
21:     ShowWindow   = 1
22:     WindowType   = 1
23:     ControlBox   = .F.
24:     Closable     = .F.
25:     MaxButton    = .F.
26:     MinButton    = .F.
27:     ClipControls = .F.
28:     TitleBar     = 0
29:     AlwaysOnTop  = .T.
30:     BorderStyle  = 2
31:     DataSession  = 1
32: 
33:     *-- Parametros recebidos do form pai (legado: lparameters loForm, pOperacao, pOriDes, loForm2)
34:     this_oParentForm  = .NULL.   && ThisForm.ParentForm / loForm
35:     this_oFormCaixa   = .NULL.   && ThisForm.PoFormCaixa / loForm2 - reabilitado ao fechar
36:     this_cOperacao    = ""       && ThisForm.Operacao / pOperacao - SigCdOpe.Dopes
37:     this_nOriDes      = 0        && ThisForm.OriDes / pOriDes - 0=indefinido, 1=Origem, 2=Destino
38:     this_nClickOriDes = 0        && ThisForm.ClickOriDes - lado escolhido pelo clique do usuario
39:     this_lRetorno     = .T.      && ThisForm.Retorno - lido pelo form pai apos o Show() modal
40: 
41:     *-- Alias do cursor do form PAI com o cabecalho do movimento em lancamento
42:     *-- (legado: TprMvCab, alcancado por "set datasession to loForm.DataSessionId").
43:     *-- Default = o nome do legado; o chamador pode troca-lo antes do Show() se
44:     *-- usar outro alias. DataSession=1 (ver cabecalho) eh o que torna o cursor
45:     *-- do pai visivel aqui.
46:     this_cAliasMovCab = "TprMvCab"
47: 
48:     *-- Guardas da troca de lado (CheckBox Sit_Origem/Sit_Destino). No legado os
49:     *-- dois Click chamam UM AO OUTRO quando Processa() nao acende container
50:     *-- nenhum ("If Not ThisForm.Processa() / ThisForm.Sit_Destino.Click()") -
51:     *-- ping-pong que so termina quando algum dos lados acende algo; nao

*-- Linhas 70 a 234:
70:     * Init - recebe os parametros do form pai (legado: lparameters loForm,
71:     * pOperacao, pOriDes, loForm2) antes de delegar a FormBase.Init()
72:     *==========================================================================
73:     PROCEDURE Init()
74:         LPARAMETERS par_oParentForm, par_cOperacao, par_nOriDes, par_oFormCaixa
75: 
76:         LOCAL loc_oErro
77:         TRY
78:             THIS.Caption = "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito"
79: 
80:             IF VARTYPE(par_oParentForm) = "O"
81:                 THIS.this_oParentForm = par_oParentForm
82:             ENDIF
83:             IF VARTYPE(par_oFormCaixa) = "O"
84:                 THIS.this_oFormCaixa = par_oFormCaixa
85:             ENDIF
86: 
87:             THIS.this_cOperacao    = TratarNulo(par_cOperacao, "")
88:             THIS.this_nOriDes      = TratarNulo(par_nOriDes, 0)
89:             THIS.this_nClickOriDes = 0
90:             THIS.this_lRetorno     = .T.
91:         CATCH TO loc_oErro
92:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
93:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em Init")
94:         ENDTRY
95: 
96:         RETURN DODEFAULT()
97:     ENDPROC
98: 
99:     *==========================================================================
100:     * InicializarForm - cria o Business Object e monta a estrutura visual base
101:     *==========================================================================
102:     PROTECTED PROCEDURE InicializarForm()
103:         LOCAL loc_lSucesso, loc_lBypassTeste, loc_oErro
104:         loc_lSucesso = .F.
105: 
106:         TRY
107:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
108: 
109:             THIS.this_oBusinessObject = CREATEOBJECT("SigOpLrCBO")
110:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
111:                 THIS.ConfigurarPageFrame()
112: 
113:                 THIS.cnt_4c_Sombra.lbl_4c_LblSombra.Caption = THIS.Caption
114:                 THIS.cnt_4c_Sombra.lbl_4c_LblTitulo.Caption = THIS.Caption
115: 
116:                 THIS.TornarControlesVisiveis(THIS)
117: 
118:                 *-- Vincula a grade ao cursor, que neste ponto existe e esta
119:                 *-- vazio (a carga real vem do BO). Feito DEPOIS de
120:                 *-- TornarControlesVisiveis para que a grade ja esteja com
121:                 *-- Visible=.T. dentro do painel.
122:                 THIS.CarregarDados()
123: 
124:                 *-- Estado INICIAL dos dois paineis de conta, pelo MESMO funil
125:                 *-- que os mantem depois: o legado abre Processa() escondendo
126:                 *-- Container2/Container3 e so os acende quando a conta tem
127:                 *-- observacao cadastrada / situacao que exiba bloqueio. Como o
128:                 *-- BO ainda nao processou nada, os dois metodos aqui apenas
129:                 *-- recolhem os paineis e apagam a linha de bloqueio - evitando
130:                 *-- que o estado inicial seja definido num lugar e mantido em
131:                 *-- outro, que eh como a mensagem de um lado sobrevive ao outro.
132:                 THIS.AtualizarContainer2()
133:                 THIS.AtualizarContainer3()
134: 
135:                 *-- Processamento de ABERTURA (legado: fecho do Init, que chama
136:                 *-- Processa() e, nao acendendo painel, tenta o lado oposto).
137:                 *-- Vem DEPOIS da montagem visual porque pinta a tela, e sob
138:                 *-- guarda porque o harness de teste instancia o form SEM
139:                 *-- parametro algum e sem conexao - sem a guarda o SQLEXEC do
140:                 *-- BO abriria dialogo e travaria o teste. A guarda NUNCA
141:                 *-- derruba o InicializarForm: parametro ausente nao eh falha
142:                 *-- de inicializacao, so significa que nao ha o que processar.
143:                 loc_lBypassTeste = (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste) OR ;
144:                     (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
145: 
146:                 IF !loc_lBypassTeste AND !EMPTY(THIS.this_cOperacao) AND ;
147:                         TYPE("gnConnHandle") = "N" AND gnConnHandle > 0
148:                     THIS.ProcessarAberturaDialogo()
149:                 ENDIF
150: 
151:                 loc_lSucesso = .T.
152:             ELSE
153:                 MsgErro("Falha ao criar SigOpLrCBO.", "Erro em InicializarForm")
154:             ENDIF
155:         CATCH TO loc_oErro
156:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
157:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em InicializarForm")
158:         ENDTRY
159: 
160:         RETURN loc_lSucesso
161:     ENDPROC
162: 
163:     *==========================================================================
164:     * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
165:     * NAO ha PageFrame real (nao segue Page1=Lista/Page2=Dados do CRUD): o
166:     * metodo delega para o cabecalho e para os tres containers flutuantes
167:     * (Limite/Saldo/Pendencias, Observacao da Conta, Situacao da Conta) que o
168:     * legado mostra ou esconde em Processa() conforme a operacao e o lado da
169:     * conta em analise.
170:     *
171:     * ORDEM DE CRIACAO - o legado cria os objetos nesta sequencia (SECAO 1 do
172:     * dump): cntSombra, Container1, Container2, Container3, Sit_Origem,
173:     * Sit_Destino, ok. AddObject empilha o ultimo no TOPO do z-order, entao a
174:     * sequencia abaixo tem de ser preservada: o botao Encerrar (Top 3..78) fica
175:     * SOBRE a faixa do cabecalho (Top 0..80) e so aparece porque eh criado
176:     * depois dela. Quem acrescentar os CheckBox Sit_Origem/Sit_Destino (Top
177:     * 143/179, Left 754 - sobre a area do Container1) deve inseri-los ENTRE
178:     * ConfigurarContainer3() e ConfigurarBotoes(), nunca no fim.
179:     *==========================================================================
180:     PROTECTED PROCEDURE ConfigurarPageFrame()
181:         THIS.ConfigurarCabecalho()
182:         THIS.ConfigurarContainer1()
183:         THIS.ConfigurarContainer2()
184:         THIS.ConfigurarContainer3()
185:         THIS.ConfigurarCheckBoxesLado()
186:         THIS.ConfigurarBotoes()
187:         THIS.ConfigurarEventos()
188:     ENDPROC
189: 
190:     *==========================================================================
191:     * ConfigurarCabecalho - container escuro superior com labels de titulo
192:     * Legado: cntSombra Top=0, Left=0, Width=1005, Height=80, BackColor=100,100,100
193:     *==========================================================================
194:     PROTECTED PROCEDURE ConfigurarCabecalho()
195:         LOCAL loc_oCab
196: 
197:         THIS.AddObject("cnt_4c_Sombra", "Container")
198:         loc_oCab = THIS.cnt_4c_Sombra
199:         WITH loc_oCab
200:             .Top         = 0
201:             .Left        = 0
202:             .Width       = THIS.Width
203:             .Height      = 80
204:             .BackColor   = RGB(100, 100, 100)
205:             .BackStyle   = 1
206:             .BorderWidth = 0
207:         ENDWITH
208: 
209:         loc_oCab.AddObject("lbl_4c_LblSombra", "Label")
210:         WITH loc_oCab.lbl_4c_LblSombra
211:             .AutoSize      = .F.
212:             .Width         = loc_oCab.Width - 20
213:             .Height        = 40
214:             .Top           = 18
215:             .Left          = 10
216:             .FontName      = "Tahoma"
217:             .FontSize      = 18
218:             .FontBold      = .T.
219:             .FontUnderline = .F.
220:             .Alignment     = 0
221:             .BackStyle     = 0
222:             .WordWrap      = .T.
223:             .ForeColor     = RGB(0, 0, 0)
224:             .Caption       = THIS.Caption
225:         ENDWITH
226: 
227:         loc_oCab.AddObject("lbl_4c_LblTitulo", "Label")
228:         WITH loc_oCab.lbl_4c_LblTitulo
229:             .AutoSize  = .F.
230:             .Width     = loc_oCab.Width - 20
231:             .Height    = 46
232:             .Top       = 17
233:             .Left      = 10
234:             .FontName  = "Tahoma"

*-- Linhas 250 a 329:
250:     * analisada esta sujeita a limite de credito (SigCdOpe.LimCres). A grade de
251:     * movimentos em aberto deste bloco eh criada por ConfigurarGrade().
252:     *==========================================================================
253:     PROTECTED PROCEDURE ConfigurarContainer1()
254:         THIS.AddObject("cnt_4c_Container1", "Container")
255:         WITH THIS.cnt_4c_Container1
256:             .Top           = 81
257:             .Left          = 9
258:             .Width         = 890
259:             .Height        = 253
260:             .BackStyle     = 0
261:             .BorderWidth   = 2
262:             .SpecialEffect = 2
263:             .BackColor     = RGB(188, 201, 254)
264:             .Visible     = .T.
265:         ENDWITH
266: 
267:         *-- Grade dos movimentos em aberto (legado: Container1.Grade)
268:         THIS.ConfigurarGrade(THIS.cnt_4c_Container1)
269: 
270:         *-- Labels/TextBoxes de leitura (legado: Label1, get_nconta, Say1..Say9
271:         *-- e os nove get_*) - todos em ConfigurarCamposContainer1
272:         THIS.ConfigurarCamposContainer1(THIS.cnt_4c_Container1)
273:     ENDPROC
274: 
275:     *==========================================================================
276:     * ConfigurarCamposContainer1 - PRIMEIRA METADE dos campos de leitura do
277:     * bloco "Limite de Credito" (legado: Container1). Todos os TextBoxes deste
278:     * bloco tem Procedure When retornando .f. no legado (comportamento.json) -
279:     * sao SOMENTE LEITURA, preenchidos pelo BO/Processa(), nunca digitados pelo
280:     * usuario. Por isso .ReadOnly = .T. aqui NAO viola a regra de "nao inventar
281:     * ReadOnly": o legado ja nega a entrada em TODOS eles.
282:     *
283:     * Labels "say" sem Width/Alignment no dump (AutoSize=.T./Alignment=0 da
284:     * classe) - AutoSize eh no-op em Label por AddObject, entao a Width eh
285:     * calculada para terminar poucos pixels antes do TextBox (Left=159),
286:     * igual ao padrao medido em Say9 (unico que declara Width=120 ~ termina em
287:     * 156, 3px antes do get_PendOutr em 159).
288:     *==========================================================================
289:     PROTECTED PROCEDURE ConfigurarCamposContainer1(par_oContainer)
290:         *-- Label1 (legado: Container1.Label1) - subtitulo do bloco
291:         par_oContainer.AddObject("lbl_4c_Label1", "Label")
292:         WITH par_oContainer.lbl_4c_Label1
293:             .AutoSize  = .F.
294:             .Top       = 0
295:             .Left      = 5
296:             .Width     = 157
297:             .Height    = 20
298:             .FontName  = "Tahoma"
299:             .FontSize  = 8
300:             .FontBold  = .T.
301:             .Alignment = 0
302:             .BackStyle = 0
303:             .ForeColor = RGB(90, 90, 90)
304:             .Caption   = "Libera" + CHR(231) + CHR(227) + "o de Cr" + CHR(233) + "dito"
305:         ENDWITH
306: 
307:         *-- get_nconta (legado: Container1.get_nconta) - rotulo "Cliente",
308:         *-- a Caption real (codigo + nome da conta) e atribuida por Processa()
309:         par_oContainer.AddObject("lbl_4c_GetNConta", "Label")
310:         WITH par_oContainer.lbl_4c_GetNConta
311:             .AutoSize  = .F.
312:             .Top       = 25
313:             .Left      = 30
314:             .Width     = 41
315:             .Height    = 15
316:             .FontName  = "Tahoma"
317:             .FontSize  = 8
318:             .Alignment = 0
319:             .BackStyle = 0
320:             .ForeColor = RGB(90, 90, 90)
321:             .Caption   = "Cliente"
322:         ENDWITH
323: 
324:         *-- Say6 / get_moeda (legado: top=30/26, left=115/159, width get=31)
325:         par_oContainer.AddObject("lbl_4c_Say6", "Label")
326:         WITH par_oContainer.lbl_4c_Say6
327:             .AutoSize  = .F.
328:             .Top       = 30
329:             .Left      = 115

*-- Linhas 618 a 692:
618:     * Comeca OCULTO - so reaparece quando a conta analisada tem observacao
619:     * cadastrada (SigCdCli.Obs), conforme AtualizarContainer2().
620:     *==========================================================================
621:     PROTECTED PROCEDURE ConfigurarContainer2()
622:         THIS.AddObject("cnt_4c_Container2", "Container")
623:         WITH THIS.cnt_4c_Container2
624:             .Top           = 336
625:             .Left          = 9
626:             .Width         = 890
627:             .Height        = 114
628:             .BackStyle     = 0
629:             .BorderWidth   = 2
630:             .SpecialEffect = 2
631:             .BackColor     = RGB(188, 201, 254)
632:             .Visible     = .T.
633:         ENDWITH
634: 
635:         THIS.ConfigurarCamposContainer2(THIS.cnt_4c_Container2)
636:     ENDPROC
637: 
638:     *==========================================================================
639:     * ConfigurarCamposContainer2 - campos do bloco "Observacao da Conta".
640:     * Legado: Container2.Label1 (titulo), Container2.fwmemo1 (EditBox com a
641:     * observacao cadastrada da conta) e Container2.get_nconta (rotulo que
642:     * recebe o codigo da conta em runtime).
643:     *
644:     * O dump declara AutoSize = .T. nos dois Labels, mas AutoSize eh no-op em
645:     * Label criado por AddObject e, com WordWrap, DESCARTA a Height - por isso
646:     * .AutoSize = .F. com Width/Height transcritos do SCX (os numeros do dump
647:     * JA SAO o auto-size que o Form Designer calculou).
648:     *
649:     * O EditBox eh SOMENTE LEITURA no legado (fwmemo1.ReadOnly = .T. no dump) -
650:     * a observacao vem do cadastro da conta e esta tela so a exibe.
651:     *==========================================================================
652:     PROTECTED PROCEDURE ConfigurarCamposContainer2(par_oContainer)
653:         *-- Label1 (legado: Container2.Label1, Tahoma 11 bold, ForeColor 90,90,90)
654:         par_oContainer.AddObject("lbl_4c_Label1", "Label")
655:         WITH par_oContainer.lbl_4c_Label1
656:             .AutoSize  = .F.
657:             .Top       = 3
658:             .Left      = 5
659:             .Width     = 160
660:             .Height    = 20
661:             .FontName  = "Tahoma"
662:             .FontSize  = 11
663:             .FontBold  = .T.
664:             .Alignment = 0
665:             .BackStyle = 0
666:             .ForeColor = RGB(90, 90, 90)
667:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o da Conta"
668:         ENDWITH
669: 
670:         *-- get_nconta (legado: Container2.get_nconta) - rotulo "Cliente"; a
671:         *-- Caption real (codigo da conta) eh atribuida em AtualizarContainer2
672:         par_oContainer.AddObject("lbl_4c_GetNConta", "Label")
673:         WITH par_oContainer.lbl_4c_GetNConta
674:             .AutoSize  = .F.
675:             .Top       = 25
676:             .Left      = 30
677:             .Width     = 160
678:             .Height    = 15
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .FontBold  = .T.
682:             .Alignment = 0
683:             .BackStyle = 0
684:             .ForeColor = RGB(90, 90, 90)
685:             .Caption   = "Cliente"
686:         ENDWITH
687: 
688:         *-- fwmemo1 (legado: Container2.fwmemo1, EditBox ReadOnly com
689:         *-- BackColor/DisabledBackColor 231,242,254 e NullDisplay " ")
690:         par_oContainer.AddObject("edt_4c_Observacao", "EditBox")
691:         WITH par_oContainer.edt_4c_Observacao
692:             .Top               = 39

*-- Linhas 711 a 788:
711:     * Comeca OCULTO - so reaparece quando SigCdCst.DispMovs = 1 para a situacao
712:     * cadastral da conta, conforme AtualizarContainer3().
713:     *==========================================================================
714:     PROTECTED PROCEDURE ConfigurarContainer3()
715:         THIS.AddObject("cnt_4c_Container3", "Container")
716:         WITH THIS.cnt_4c_Container3
717:             .Top           = 452
718:             .Left          = 9
719:             .Width         = 890
720:             .Height        = 138
721:             .BackStyle     = 0
722:             .BorderWidth   = 2
723:             .SpecialEffect = 2
724:             .BackColor     = RGB(188, 201, 254)
725:             .Visible     = .T.
726:         ENDWITH
727: 
728:         THIS.ConfigurarCamposContainer3(THIS.cnt_4c_Container3)
729:     ENDPROC
730: 
731:     *==========================================================================
732:     * ConfigurarCamposContainer3 - campos do bloco "Situacao da Conta".
733:     * Legado: Container3.Label1 (titulo), Container3.get_nconta (rotulo que
734:     * recebe o codigo da conta), Lb_msg1..Lb_msg4 (as quatro linhas de
735:     * informacao cadastral) e lb_msg5 (a linha de BLOQUEIO, que o legado
736:     * mantem oculta e so acende quando a situacao da conta recusa o
737:     * movimento - ver ValidarSituacaoConta).
738:     *
739:     * As Captions "Mensagem1".."Mensagem4"/"status" do dump sao placeholders de
740:     * design-time do legado; o texto real vem de AtualizarContainer3(). Por
741:     * isso os Labels nascem com Caption VAZIA - exibir "Mensagem1" na tela
742:     * seria pior que a cadeia vazia.
743:     *
744:     * Lb_msg1..Lb_msg4 NAO declaram AutoSize no dump (Width = 839 fixa, a
745:     * largura util do container); lb_msg5 declara AutoSize = .T., trocado por
746:     * .AutoSize = .F. com a geometria do dump pelo mesmo motivo do Container2.
747:     *==========================================================================
748:     PROTECTED PROCEDURE ConfigurarCamposContainer3(par_oContainer)
749:         *-- Label1 (legado: Container3.Label1, Tahoma 11 bold)
750:         par_oContainer.AddObject("lbl_4c_Label1", "Label")
751:         WITH par_oContainer.lbl_4c_Label1
752:             .AutoSize  = .F.
753:             .Top       = 5
754:             .Left      = 5
755:             .Width     = 136
756:             .Height    = 20
757:             .FontName  = "Tahoma"
758:             .FontSize  = 11
759:             .FontBold  = .T.
760:             .Alignment = 0
761:             .BackStyle = 0
762:             .ForeColor = RGB(90, 90, 90)
763:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o da Conta"
764:         ENDWITH
765: 
766:         *-- get_nconta (legado: Container3.get_nconta) - rotulo "Cliente"
767:         par_oContainer.AddObject("lbl_4c_GetNConta", "Label")
768:         WITH par_oContainer.lbl_4c_GetNConta
769:             .AutoSize  = .F.
770:             .Top       = 28
771:             .Left      = 30
772:             .Width     = 160
773:             .Height    = 15
774:             .FontName  = "Tahoma"
775:             .FontSize  = 8
776:             .FontBold  = .T.
777:             .Alignment = 0
778:             .BackStyle = 0
779:             .ForeColor = RGB(90, 90, 90)
780:             .Caption   = "Cliente"
781:         ENDWITH
782: 
783:         *-- Lb_msg1 (legado: Container3.Lb_msg1, top=46) - situacao cadastral
784:         par_oContainer.AddObject("lbl_4c_Msg1", "Label")
785:         WITH par_oContainer.lbl_4c_Msg1
786:             .AutoSize  = .F.
787:             .Top       = 46
788:             .Left      = 31

*-- Linhas 888 a 931:
888:     * dump; CheckBox com Picture nao sofre do problema de icone invisivel que
889:     * atinge CommandButton solto.
890:     *==========================================================================
891:     PROTECTED PROCEDURE ConfigurarCheckBoxesLado()
892:         THIS.AddObject("chk_4c_Sit_Origem", "CheckBox")
893:         WITH THIS.chk_4c_Sit_Origem
894:             .Top             = 143
895:             .Left            = 754
896:             .Width           = 120
897:             .Height          = 35
898:             .FontName        = "Comic Sans MS"
899:             .FontSize        = 8
900:             .FontBold        = .T.
901:             .FontItalic      = .T.
902:             .Alignment       = 0
903:             .Caption         = "Conta Origem"
904:             .Value           = 0
905:             .Style           = 1
906:             .MousePointer    = 15
907:             .PicturePosition = 1
908:             .ForeColor       = RGB(90, 90, 90)
909:             .BackColor       = RGB(255, 255, 255)
910:             .Themes          = .F.
911:             .TabIndex        = 3
912:             .ToolTipText     = "Origem"
913:             .Picture         = gc_4c_CaminhoIcones + "geral_usuarios_26.jpg"
914:         ENDWITH
915: 
916:         THIS.AddObject("chk_4c_Sit_Destino", "CheckBox")
917:         WITH THIS.chk_4c_Sit_Destino
918:             .Top             = 179
919:             .Left            = 754
920:             .Width           = 120
921:             .Height          = 35
922:             .FontName        = "Comic Sans MS"
923:             .FontSize        = 8
924:             .FontBold        = .T.
925:             .FontItalic      = .T.
926:             .Alignment       = 0
927:             .Caption         = "Conta Destino"
928:             .Value           = 0
929:             .Style           = 1
930:             .MousePointer    = 15
931:             .PicturePosition = 1

*-- Linhas 943 a 1014:
943:     * estrutura e NA MESMA ORDEM de campos que SigOpLrCBO usa em
944:     * CarregarMovimentosPendentes (dopes C(20), totas N(12,2)) - divergir a
945:     * ordem faz o INSERT casar coluna errada em silencio.
946:     * Legado: PROCEDURE Load -> Create Cursor DbOpera (dopes c(20), totas n(12,2))
947:     * O BO reaproveita este mesmo alias (IF !USED() ... ELSE ZAP), por isso o
948:     * vinculo da grade sobrevive a recarga.
949:     *==========================================================================
950:     PROTECTED PROCEDURE CriarCursorGrade()
951:         LOCAL loc_oErro
952: 
953:         TRY
954:             IF !USED(THIS.this_cCursorGrade)
955:                 CREATE CURSOR (THIS.this_cCursorGrade) (dopes C(20), totas N(12,2))
956:                 SELECT (THIS.this_cCursorGrade)
957:                 INDEX ON dopes TAG dopes
958:             ENDIF
959:         CATCH TO loc_oErro
960:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
961:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CriarCursorGrade")
962:         ENDTRY
963:     ENDPROC
964: 
965:     *==========================================================================
966:     * ConfigurarGrade - grade dos movimentos em aberto da conta analisada.
967:     * Legado: SIGOPLRC.Container1.Grade (Top=53, Left=295, Width=434,
968:     * Height=195, ColumnCount=2, Verdana 8, ReadOnly, RowHeight=16,
969:     * ScrollBars=2, DeleteMark=.F.). Somente leitura - o usuario apenas
970:     * consulta o que ja esta em aberto; nao ha coluna editavel.
971:     * NAO liga RecordSource/ControlSource aqui: o vinculo (e a largura das
972:     * colunas, que o RecordSource reseta para o default) fica em CarregarDados.
973:     *==========================================================================
974:     PROTECTED PROCEDURE ConfigurarGrade(par_oContainer)
975:         par_oContainer.AddObject("grd_4c_Dados", "Grid")
976: 
977:         WITH par_oContainer.grd_4c_Dados
978:             .Top         = 53
979:             .Left        = 295
980:             .Width       = 434
981:             .Height      = 195
982:             .ColumnCount = 2
983:             .FontName    = "Verdana"
984:             .FontSize    = 8
985:             .RowHeight   = 16
986:             .ScrollBars  = 2
987:             .Enabled     = .T.
988:             .DeleteMark  = .F.
989:             .RecordMark  = .F.
990:             *-- Grid.ReadOnly propaga para as colunas, por isso vem ANTES delas
991:             .ReadOnly    = .T.
992:         ENDWITH
993: 
994:         WITH par_oContainer.grd_4c_Dados.Column1
995:             .FontName = "Verdana"
996:             .FontSize = 8
997:             .Enabled  = .T.
998:             .ReadOnly = .T.
999:         ENDWITH
1000: 
1001:         WITH par_oContainer.grd_4c_Dados.Column1.Header1
1002:             .FontName  = "Verdana"
1003:             .FontSize  = 8
1004:             .Alignment = 2
1005:         ENDWITH
1006: 
1007:         WITH par_oContainer.grd_4c_Dados.Column1.Text1
1008:             .FontName    = "Verdana"
1009:             .FontSize    = 8
1010:             .BorderStyle = 0
1011:             .Margin      = 0
1012:             .ForeColor   = RGB(0, 0, 0)
1013:             .BackColor   = RGB(255, 255, 255)
1014:         ENDWITH

*-- Linhas 1057 a 1205:
1057:     * para o default e zera os captions, entao largura e titulo tem de ser
1058:     * reaplicados DEPOIS dele.
1059:     *==========================================================================
1060:     PROCEDURE CarregarDados()
1061:         LOCAL loc_lSucesso, loc_oGrade, loc_oErro
1062:         loc_lSucesso = .F.
1063: 
1064:         TRY
1065:             THIS.CriarCursorGrade()
1066: 
1067:             IF USED(THIS.this_cCursorGrade) AND ;
1068:                PEMSTATUS(THIS.cnt_4c_Container1, "grd_4c_Dados", 5)
1069: 
1070:                 loc_oGrade = THIS.cnt_4c_Container1.grd_4c_Dados
1071: 
1072:                 loc_oGrade.ColumnCount = 2
1073:                 loc_oGrade.RecordSource = THIS.this_cCursorGrade
1074:                 loc_oGrade.Column1.ControlSource = THIS.this_cCursorGrade + ".dopes"
1075:                 loc_oGrade.Column2.ControlSource = THIS.this_cCursorGrade + ".totas"
1076: 
1077:                 *-- Larguras e titulos DEPOIS do RecordSource (ele reseta ambos)
1078:                 loc_oGrade.Column1.Width = 290
1079:                 loc_oGrade.Column2.Width = 112
1080:                 loc_oGrade.Column1.Header1.Caption = "Movimenta" + CHR(231) + CHR(245) + ;
1081:                     "es Pendentes"
1082:                 loc_oGrade.Column2.Header1.Caption = "Valor"
1083: 
1084:                 SELECT (THIS.this_cCursorGrade)
1085:                 GO TOP
1086:                 loc_oGrade.Refresh()
1087: 
1088:                 loc_lSucesso = .T.
1089:             ENDIF
1090:         CATCH TO loc_oErro
1091:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1092:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CarregarDados")
1093:         ENDTRY
1094: 
1095:         RETURN loc_lSucesso
1096:     ENDPROC
1097: 
1098:     *==========================================================================
1099:     * AtualizarContainer2 - exibe (ou esconde) o bloco "Observacao da Conta"
1100:     * com o texto que o BO leu de SigCdCli.Obs. Legado, trecho de Processa():
1101:     *     If Not IsEmpty( CrTmpCli.Obs )
1102:     *         llAtvCnt = .t.
1103:     *         ThisForm.Container2.Visible = .t.
1104:     *         ThisForm.container2.fwmemo1.Value = CrTmpCli.Obs
1105:     *         ThisForm.container2.fwmemo1.Refresh
1106:     *         ThisForm.Container2.Get_nconta.Caption = _Conta
1107:     *     Endif
1108:     *
1109:     * O legado NUNCA reexibe o bloco quando a observacao esta vazia, e cada
1110:     * clique nos CheckBox de lado roda Processa() de novo - por isso este
1111:     * metodo tambem ESCONDE o bloco, senao a observacao da conta Origem
1112:     * ficaria na tela depois de o usuario trocar para a conta Destino.
1113:     *
1114:     * PUBLIC de proposito: eh chamado de fora da classe pelo funil que
1115:     * reprocessa o lado da conta.
1116:     *==========================================================================
1117:     PROCEDURE AtualizarContainer2()
1118:         LOCAL loc_lVisivel, loc_oBO, loc_oErro
1119: 
1120:         loc_lVisivel = .F.
1121: 
1122:         TRY
1123:             loc_oBO = THIS.this_oBusinessObject
1124: 
1125:             IF VARTYPE(loc_oBO) = "O"
1126:                 loc_lVisivel = loc_oBO.this_lContainer2Visivel
1127: 
1128:                 IF loc_lVisivel
1129:                     THIS.cnt_4c_Container2.edt_4c_Observacao.Value = ;
1130:                         TratarNulo(loc_oBO.this_cObsCliente, "")
1131:                     THIS.cnt_4c_Container2.lbl_4c_GetNConta.Caption = ;
1132:                         ALLTRIM(TratarNulo(loc_oBO.this_cConta, ""))
1133:                 ENDIF
1134:             ENDIF
1135: 
1136:             THIS.cnt_4c_Container2.Visible = loc_lVisivel
1137: 
1138:             IF loc_lVisivel
1139:                 THIS.cnt_4c_Container2.edt_4c_Observacao.Refresh()
1140:             ENDIF
1141:         CATCH TO loc_oErro
1142:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1143:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarContainer2")
1144:         ENDTRY
1145: 
1146:         RETURN loc_lVisivel
1147:     ENDPROC
1148: 
1149:     *==========================================================================
1150:     * AtualizarContainer3 - exibe (ou esconde) o bloco "Situacao da Conta" com
1151:     * as quatro linhas de informacao cadastral. Legado, trecho de Processa():
1152:     *     ThisForm.Container3.Get_nconta.Caption = _Conta
1153:     *     lb_msg1 = CrtmpCli.Situas + ' - ' + Alltrim(lcdSit)
1154:     *     lb_msg2 = Alltrim(Transform(CrTmpCli.VultComps,"@Z 999,999,999.99"))
1155:     *               + ' / ' + Iif(!IsEmpty(CrTmpCli.UltComps),Dtoc(CrTmpCli.UltComps),'')
1156:     *     lb_msg3 = Iif(!IsEmpty(CrTmpCli.Nascs),Dtoc(CrTmpCli.Nascs),'')
1157:     *     lb_msg4 = CrTmpCli.Codigos + ' ' + Iif(!IsEmpty(CrTmpCli.DtnCons),'j - '+Dtoc(...),'')
1158:     *               + ' ' + Iif(!IsEmpty(CrTmpCli.DtCasas),'c - '+Dtoc(...),'')
1159:     *
1160:     * As datas passam por ConverterParaData(): a MESMA coluna chega como DATE
1161:     * (property do BO ainda no valor inicial {}) ou como DATETIME (lida do SQL
1162:     * Server), e DTOC de um DATETIME nao erra, mas TTOD de um DATE erra - o
1163:     * normalizador cobre os dois caminhos.
1164:     *==========================================================================
1165:     PROCEDURE AtualizarContainer3()
1166:         LOCAL loc_lVisivel, loc_oBO, loc_oCnt, loc_dUltima, loc_dNasc
1167:         LOCAL loc_dConsorcio, loc_dCasamento, loc_oErro
1168: 
1169:         loc_lVisivel = .F.
1170: 
1171:         TRY
1172:             loc_oBO = THIS.this_oBusinessObject
1173: 
1174:             IF VARTYPE(loc_oBO) = "O"
1175:                 loc_lVisivel = loc_oBO.this_lContainer3Visivel
1176: 
1177:                 IF loc_lVisivel
1178:                     loc_oCnt       = THIS.cnt_4c_Container3
1179:                     loc_dUltima    = ConverterParaData(loc_oBO.this_dUltimaCompra)
1180:                     loc_dNasc      = ConverterParaData(loc_oBO.this_dNascimento)
1181:                     loc_dConsorcio = ConverterParaData(loc_oBO.this_dDtnCons)
1182:                     loc_dCasamento = ConverterParaData(loc_oBO.this_dDtCasas)
1183: 
1184:                     loc_oCnt.lbl_4c_GetNConta.Caption = ;
1185:                         ALLTRIM(TratarNulo(loc_oBO.this_cConta, ""))
1186: 
1187:                     loc_oCnt.lbl_4c_Msg1.Caption = ;
1188:                         ALLTRIM(TratarNulo(loc_oBO.this_cSituacaoCod, "")) + " - " + ;
1189:                         ALLTRIM(TratarNulo(loc_oBO.this_cDescrSituacao, ""))
1190: 
1191:                     loc_oCnt.lbl_4c_Msg2.Caption = ;
1192:                         ALLTRIM(TRANSFORM(TratarNulo(loc_oBO.this_nValorUltimaCompra, 0), ;
1193:                             "@Z 999,999,999.99")) + " / " + ;
1194:                         IIF(!EMPTY(loc_dUltima), DTOC(loc_dUltima), "")
1195: 
1196:                     loc_oCnt.lbl_4c_Msg3.Caption = ;
1197:                         IIF(!EMPTY(loc_dNasc), DTOC(loc_dNasc), "")
1198: 
1199:                     loc_oCnt.lbl_4c_Msg4.Caption = ;
1200:                         ALLTRIM(TratarNulo(loc_oBO.this_cCodigoCliente, "")) + " " + ;
1201:                         IIF(!EMPTY(loc_dConsorcio), "j - " + DTOC(loc_dConsorcio), "") + ;
1202:                         " " + IIF(!EMPTY(loc_dCasamento), "c - " + DTOC(loc_dCasamento), "")
1203:                 ENDIF
1204:             ENDIF
1205: 

*-- Linhas 1211 a 1884:
1211:             THIS.ValidarSituacaoConta()
1212:         CATCH TO loc_oErro
1213:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1214:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarContainer3")
1215:         ENDTRY
1216: 
1217:         RETURN loc_lVisivel
1218:     ENDPROC
1219: 
1220:     *==========================================================================
1221:     * ValidarSituacaoConta - transcreve a validacao que fecha o Processa() do
1222:     * legado: quando o lado da conta eh FIXO (OriDes > 0, isto eh, o form pai
1223:     * pediu a analise de um lado especifico), a situacao cadastral pode RECUSAR
1224:     * a movimentacao, e o legado comunica isso de duas formas ao mesmo tempo -
1225:     * acende lb_msg5 com o motivo e zera ThisForm.Retorno, que eh o valor lido
1226:     * pelo form pai para abortar a gravacao.
1227:     *
1228:     *     If Thisform.OriDes > 0
1229:     *         If CrTmpScli.BlqMovs = 1
1230:     *             lb_MSG5.Visible = .t.
1231:     *             lb_msg5.Caption = 'Movimentacao Bloqueada pela Situacao da Conta'
1232:     *             ThisForm.Retorno = .f.
1233:     *         Else
1234:     *             If TprMvCab.ValVars < 0 And CrTmpScli.BlqDescs = 1
1235:     *                 lb_MSG5.Visible = .t.
1236:     *                 lb_msg5.Caption = 'Desconto Bloqueado Pela Situacao da Conta'
1237:     *                 ThisForm.Retorno = .f.
1238:     *             EndIf
1239:     *         EndIf
1240:     *     EndIf
1241:     *
1242:     * A decisao (qual dos dois motivos, e se ha motivo) eh regra de negocio e
1243:     * mora no BO; aqui ela eh ESPELHADA na tela e no this_lRetorno do form. O
1244:     * retorno eh .T. quando a movimentacao esta liberada e .F. quando recusada,
1245:     * para quem chamar poder desviar o fluxo sem reler a tela.
1246:     *
1247:     * Reproduz tambem o lb_MSG5.Visible = .f. que o legado executa ANTES dos
1248:     * dois IFs: sem apagar, a mensagem do lado anterior sobrevive ao clique que
1249:     * troca Origem/Destino e a tela acusa bloqueio que nao existe mais.
1250:     *==========================================================================
1251:     PROCEDURE ValidarSituacaoConta()
1252:         LOCAL loc_lLiberado, loc_oBO, loc_oMsg, loc_oErro
1253: 
1254:         loc_lLiberado = .T.
1255: 
1256:         TRY
1257:             loc_oMsg = THIS.cnt_4c_Container3.lbl_4c_Msg5
1258:             loc_oBO  = THIS.this_oBusinessObject
1259: 
1260:             loc_oMsg.Visible = .F.
1261:             loc_oMsg.Caption = ""
1262: 
1263:             IF VARTYPE(loc_oBO) = "O"
1264:                 IF loc_oBO.this_lMsgBloqueioVisivel
1265:                     loc_oMsg.Caption = TratarNulo(loc_oBO.this_cMsgBloqueio, "")
1266:                     loc_oMsg.Visible = .T.
1267:                 ENDIF
1268: 
1269:                 loc_lLiberado      = loc_oBO.this_lRetorno
1270:                 THIS.this_lRetorno = loc_lLiberado
1271:             ENDIF
1272:         CATCH TO loc_oErro
1273:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1274:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ValidarSituacaoConta")
1275:         ENDTRY
1276: 
1277:         RETURN loc_lLiberado
1278:     ENDPROC
1279: 
1280:     *==========================================================================
1281:     * AtualizarCheckBoxesLado - espelha na tela a habilitacao dos dois CheckBox
1282:     * de escolha de lado, que eh decidida pelo BO (regra de negocio).
1283:     *
1284:     * Legado, inicio de Processa():
1285:     *     If ThisForm.OriDes > 0
1286:     *         ThisForm.Sit_Destino.Enabled = .f.
1287:     *         ThisForm.Sit_Origem.Enabled = .f.
1288:     *     EndIf
1289:     * e, no DO CASE que escolhe o lado, o reenable do lado em foco
1290:     * (Sit_Origem.Enabled = .t. / Sit_Destino.Enabled = .t.).
1291:     *
1292:     * As duas coisas ja estao no BO (Processar + DeterminarLadoConta), em
1293:     * this_lSitOrigemHabilitado/this_lSitDestinoHabilitado - aqui elas apenas
1294:     * chegam a tela. Lado FIXO (OriDes > 0, o form pai pediu um lado
1295:     * especifico) deixa os dois desabilitados: o usuario nao pode trocar.
1296:     *
1297:     * PUBLIC de proposito: faz parte do funil chamado de fora da classe.
1298:     *==========================================================================
1299:     PROCEDURE AtualizarCheckBoxesLado()
1300:         LOCAL loc_oBO, loc_oErro
1301: 
1302:         TRY
1303:             loc_oBO = THIS.this_oBusinessObject
1304: 
1305:             IF VARTYPE(loc_oBO) = "O"
1306:                 THIS.chk_4c_Sit_Origem.Enabled  = loc_oBO.this_lSitOrigemHabilitado
1307:                 THIS.chk_4c_Sit_Destino.Enabled = loc_oBO.this_lSitDestinoHabilitado
1308:             ENDIF
1309:         CATCH TO loc_oErro
1310:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1311:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarCheckBoxesLado")
1312:         ENDTRY
1313:     ENDPROC
1314: 
1315:     *==========================================================================
1316:     * AtualizarContainer1 - exibe (ou esconde) o bloco de limite de credito e
1317:     * leva para a tela os valores que o BO calculou. Legado, fecho do bloco
1318:     * Container1 de Processa():
1319:     *     ThisForm.Container1.get_nconta.Caption   = _Conta + " " + Alltrim(lcRazao)
1320:     *     ThisForm.Container1.get_contac.Value     = _Saldocc
1321:     *     ThisForm.Container1.get_cheque.Value     = _chequec
1322:     *     ThisForm.Container1.get_chqpend.Value    = _chequep
1323:     *     ThisForm.Container1.get_limcred.Value    = crSigClLcr.limcres
1324:     *     ThisForm.Container1.get_moeda.Value      = crSigClLcr.moedas
1325:     *     ThisForm.Container1.get_cotacao.Value    = fBuscarCotacao(crSigClLcr.moedas, date())
1326:     *     ThisForm.Container1.get_pendente.Value   = _Pendoutr
1327:     *     ThisForm.Container1.get_pendoutr.Value   = _Pendente
1328:     *     ThisForm.Container1.get_disponivel.forecolor = Iif(_SaldoFinal < 0, RGB(255,0,0), RGB(0,0,255))
1329:     *     ThisForm.Container1.get_disponivel.Value = _SaldoFinal
1330:     *
1331:     * ATENCAO - as duas linhas de pendencia NAO estao trocadas: no legado o
1332:     * nome da variavel engana e o rotulo da tela eh que manda. get_pendente
1333:     * esta sob o rotulo Say2 (total em aberto) e recebe _PendOutr, que eh o
1334:     * que esta em aberto em OUTRAS operacoes; get_PendOutr esta sob o rotulo
1335:     * Say9 (total da movimentacao) e recebe _Pendente, que eh o valor do
1336:     * PROPRIO movimento em lancamento. Transcrito como esta - inverter os dois
1337:     * exibe numero errado em dois campos ao mesmo tempo, sem erro na tela.
1338:     *
1339:     * A cor do saldo disponivel eh dinamica (vermelho se negativo, azul se
1340:     * positivo); o default de design-time posto em ConfigurarCamposContainer1
1341:     * vale so ate a primeira passagem por aqui.
1342:     *
1343:     * CarregarDados() fica no FIM e so quando o painel esta VISIVEL: Refresh de
1344:     * grade dentro de container oculto nao pinta, e a grade ficaria visualmente
1345:     * vazia com o cursor cheio.
1346:     *
1347:     * Como todo valor eh reatribuido sempre que o painel aparece, esconder
1348:     * basta - nao ha dado de um lado sobrevivendo visivel no outro.
1349:     *
1350:     * PUBLIC de proposito: faz parte do funil chamado de fora da classe.
1351:     *==========================================================================
1352:     PROCEDURE AtualizarContainer1()
1353:         LOCAL loc_lVisivel, loc_oBO, loc_oCnt, loc_nDisponivel, loc_oErro
1354: 
1355:         loc_lVisivel = .F.
1356: 
1357:         TRY
1358:             loc_oBO = THIS.this_oBusinessObject
1359: 
1360:             IF VARTYPE(loc_oBO) = "O"
1361:                 loc_lVisivel = loc_oBO.this_lContainer1Visivel
1362: 
1363:                 IF loc_lVisivel
1364:                     loc_oCnt        = THIS.cnt_4c_Container1
1365:                     loc_nDisponivel = TratarNulo(loc_oBO.this_nSaldoDisponivel, 0)
1366: 
1367:                     loc_oCnt.lbl_4c_GetNConta.Caption = ;
1368:                         TratarNulo(loc_oBO.this_cDescricaoConta, "")
1369: 
1370:                     loc_oCnt.txt_4c_Moeda.Value   = ALLTRIM(TratarNulo(loc_oBO.this_cMoeda, ""))
1371:                     loc_oCnt.txt_4c_Cotacao.Value = TratarNulo(loc_oBO.this_nCotacao, 0)
1372:                     loc_oCnt.txt_4c_LimCred.Value = TratarNulo(loc_oBO.this_nLimiteCredito, 0)
1373:                     loc_oCnt.txt_4c_Contac.Value  = TratarNulo(loc_oBO.this_nSaldoCC, 0)
1374:                     loc_oCnt.txt_4c_Cheque.Value  = TratarNulo(loc_oBO.this_nTotalCheques, 0)
1375:                     loc_oCnt.txt_4c_ChqPend.Value = TratarNulo(loc_oBO.this_nChequesPendentes, 0)
1376: 
1377:                     *-- Ver a nota do cabecalho: o campo sob o Say2 recebe o
1378:                     *-- que esta em aberto em OUTRAS operacoes, e o campo sob
1379:                     *-- o Say9 recebe o valor do PROPRIO movimento.
1380:                     loc_oCnt.txt_4c_Pendente.Value = TratarNulo(loc_oBO.this_nPendenteOutros, 0)
1381:                     loc_oCnt.txt_4c_PendOutr.Value = TratarNulo(loc_oBO.this_nPendente, 0)
1382: 
1383:                     loc_oCnt.txt_4c_Disponivel.ForeColor = ;
1384:                         IIF(loc_nDisponivel < 0, RGB(255, 0, 0), RGB(0, 0, 255))
1385:                     loc_oCnt.txt_4c_Disponivel.Value = loc_nDisponivel
1386:                 ENDIF
1387:             ENDIF
1388: 
1389:             THIS.cnt_4c_Container1.Visible = loc_lVisivel
1390: 
1391:             IF loc_lVisivel
1392:                 THIS.CarregarDados()
1393:             ENDIF
1394:         CATCH TO loc_oErro
1395:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1396:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em AtualizarContainer1")
1397:         ENDTRY
1398: 
1399:         RETURN loc_lVisivel
1400:     ENDPROC
1401: 
1402:     *==========================================================================
1403:     * ProcessarLado - FUNIL UNICO de reprocessamento da tela: o equivalente do
1404:     * PROCEDURE processa do form legado, na parte que cabe a VISAO. Manda o BO
1405:     * recalcular para o lado da conta em foco e espelha o resultado nos tres
1406:     * paineis, nos dois CheckBox e na grade.
1407:     *
1408:     * Roda na abertura do dialogo (ProcessarAberturaDialogo) e a CADA clique
1409:     * nos CheckBox Sit_Origem/Sit_Destino - exatamente como o legado, que
1410:     * reexecuta Processa() inteiro nesses mesmos pontos. Por isso toda
1411:     * atualizacao de tela mora aqui, e nao espalhada pelos handlers: eh o que
1412:     * impede o estado de um lado sobreviver ao outro.
1413:     *
1414:     * Devolve o llAtvCnt do legado (.T. = algum painel acendeu). Quem chama usa
1415:     * esse retorno para decidir se tenta o lado oposto, igual ao legado.
1416:     *
1417:     * ORDEM obrigatoria: FormParaBO (entrega ao BO o lado em foco) -> o BO
1418:     * calcula (ele decide visibilidade e valores) -> BOParaForm (espelha o
1419:     * resultado na tela, com a ordem interna que a grade exige). O Refresh
1420:     * final eh o Thisform.Refresh que encerra o Processa() legado.
1421:     *
1422:     * PUBLIC de proposito: eh o funil, chamado de fora da classe.
1423:     *==========================================================================
1424:     PROCEDURE ProcessarLado()
1425:         LOCAL loc_lAtivouPainel, loc_oBO, loc_oErro
1426: 
1427:         loc_lAtivouPainel = .F.
1428: 
1429:         TRY
1430:             loc_oBO = THIS.this_oBusinessObject
1431: 
1432:             IF VARTYPE(loc_oBO) = "O"
1433:                 THIS.FormParaBO()
1434: 
1435:                 loc_lAtivouPainel = loc_oBO.Processar()
1436: 
1437:                 THIS.BOParaForm()
1438: 
1439:                 THIS.Refresh()
1440:             ENDIF
1441:         CATCH TO loc_oErro
1442:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1443:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ProcessarLado")
1444:         ENDTRY
1445: 
1446:         RETURN loc_lAtivouPainel
1447:     ENDPROC
1448: 
1449:     *==========================================================================
1450:     * FormParaBO - transferencia TELA -> BO. Hook canonico do FormBase (lah ele
1451:     * eh PROTECTED e vazio); PROTECTED aqui pela mesma razao: quem o chama eh o
1452:     * proprio funil (ProcessarLado), nunca codigo de fora.
1453:     *
1454:     * Esta tela eh de EXIBICAO: os nove TextBox e o EditBox sao somente-leitura
1455:     * (no legado todos tem "PROCEDURE When / Return .f.") e o que eles mostram
1456:     * eh o RESULTADO do calculo do BO. Transferir esses campos de volta - o
1457:     * "FormParaBO com TODOS os campos" do padrao CRUD - sobrescreveria com o
1458:     * valor exibido justamente as properties que o BO acabou de calcular, e o
1459:     * reprocessamento seguinte partiria do numero velho. Por isso o unico dado
1460:     * que ESTA tela possui - e o unico que desce para o BO - eh a escolha do
1461:     * LADO da conta em analise:
1462:     *
1463:     *   this_nOriDes      o lado FIXO que o form pai pediu (parametro pOriDes
1464:     *                     do Init legado); ProcessarAberturaDialogo pode
1465:     *                     forca-lo para 2 na segunda tentativa, como o legado
1466:     *   this_nClickOriDes o lado escolhido pelo CLIQUE do usuario nos CheckBox
1467:     *                     Sit_Origem/Sit_Destino (legado: ThisForm.ClickOriDes)
1468:     *
1469:     * Sao exatamente as duas variaveis que o DO CASE do Processa() legado le
1470:     * para decidir qual conta analisar.
1471:     *==========================================================================
1472:     PROTECTED PROCEDURE FormParaBO()
1473:         LOCAL loc_oBO
1474: 
1475:         loc_oBO = THIS.this_oBusinessObject
1476: 
1477:         IF VARTYPE(loc_oBO) = "O"
1478:             loc_oBO.this_nOriDes      = THIS.this_nOriDes
1479:             loc_oBO.this_nClickOriDes = THIS.this_nClickOriDes
1480:         ENDIF
1481:     ENDPROC
1482: 
1483:     *==========================================================================
1484:     * BOParaForm - transferencia BO -> TELA. Hook canonico do FormBase (lah ele
1485:     * eh PROTECTED e vazio); PROTECTED aqui pela mesma razao do FormParaBO.
1486:     *
1487:     * Nao repete mapeamento de campo: delega aos quatro espelhos que ja
1488:     * transcrevem cada trecho do Processa() legado. A ORDEM eh obrigatoria:
1489:     *   1. os CheckBox (habilitacao do lado, inicio do Processa legado);
1490:     *   2. Container1 - acende o painel e so ENTAO repinta a grade, porque
1491:     *      Refresh de grade dentro de container oculto nao pinta (regra #21);
1492:     *   3. Container2 (observacao da conta);
1493:     *   4. Container3, que fecha chamando ValidarSituacaoConta - eh ela que
1494:     *      espelha a linha de bloqueio e o this_lRetorno lido pelo form pai.
1495:     *
1496:     * Os quatro rodam SEMPRE, inclusive quando o painel correspondente nao
1497:     * aparece: eh o que ESCONDE o painel e APAGA a mensagem do lado anterior
1498:     * quando o usuario troca Origem/Destino.
1499:     *==========================================================================
1500:     PROTECTED PROCEDURE BOParaForm()
1501:         THIS.AtualizarCheckBoxesLado()
1502:         THIS.AtualizarContainer1()
1503:         THIS.AtualizarContainer2()
1504:         THIS.AtualizarContainer3()
1505:     ENDPROC
1506: 
1507:     *==========================================================================
1508:     * TrocarLadoConta - corpo COMUM dos dois CheckBox de escolha de lado.
1509:     * par_nLado: 1 = Conta Origem, 2 = Conta Destino.
1510:     *
1511:     * Legado - SIGOPLRC.Sit_Origem.Click:
1512:     *     If ThisForm.OriDes = 0
1513:     *         ThisForm.Sit_Origem.Enabled = .f.
1514:     *         ThisForm.Sit_Destino.Enabled = .t.
1515:     *     Endif
1516:     *     ThisForm.ClickOriDes = 1
1517:     *     If Not ThisForm.Processa()
1518:     *         ThisForm.Sit_Destino.Click()
1519:     *     EndIf
1520:     *
1521:     * Legado - SIGOPLRC.Sit_Destino.Click: identico, com o Enabled invertido,
1522:     * ClickOriDes = 2 e DUAS linhas a mais no inicio (This.Value = 0 +
1523:     * This.Refresh). A assimetria eh do legado - so o Destino desmarca o
1524:     * proprio CheckBox - e esta transcrita como esta.
1525:     *
1526:     * O Enabled atribuido aqui eh depois RECALCULADO por
1527:     * AtualizarCheckBoxesLado (dentro de ProcessarLado), igual ao legado, cujo
1528:     * DO CASE em Processa() torna a habilitar o lado em foco - de modo que, com
1529:     * lado livre (OriDes = 0), os dois CheckBox terminam habilitados.
1530:     *
1531:     * A volta ao lado oposto eh limitada a UM salto - ver a nota de
1532:     * this_lLadoOpostoTentado na declaracao das propriedades.
1533:     *==========================================================================
1534:     PROTECTED PROCEDURE TrocarLadoConta(par_nLado)
1535:         LOCAL loc_nLadoOposto
1536: 
1537:         IF THIS.this_nOriDes = 0
1538:             IF par_nLado = 1
1539:                 THIS.chk_4c_Sit_Origem.Enabled  = .F.
1540:                 THIS.chk_4c_Sit_Destino.Enabled = .T.
1541:             ELSE
1542:                 THIS.chk_4c_Sit_Destino.Enabled = .F.
1543:                 THIS.chk_4c_Sit_Origem.Enabled  = .T.
1544:             ENDIF
1545:         ENDIF
1546: 
1547:         *-- So o Destino zera o proprio Value (assimetria do legado)
1548:         IF par_nLado = 2
1549:             THIS.chk_4c_Sit_Destino.Value = 0
1550:             THIS.chk_4c_Sit_Destino.Refresh()
1551:         ENDIF
1552: 
1553:         THIS.this_nClickOriDes = par_nLado
1554: 
1555:         IF !THIS.ProcessarLado()
1556:             IF !THIS.this_lLadoOpostoTentado
1557:                 THIS.this_lLadoOpostoTentado = .T.
1558:                 loc_nLadoOposto = IIF(par_nLado = 1, 2, 1)
1559:                 THIS.TrocarLadoConta(loc_nLadoOposto)
1560:             ENDIF
1561:         ENDIF
1562:     ENDPROC
1563: 
1564:     *==========================================================================
1565:     * ProcessarAberturaDialogo - fluxo de abertura do dialogo. Legado, fecho do
1566:     * PROCEDURE Init:
1567:     *     If Not Thisform.Processa()
1568:     *         If ThisForm.OriDes > 0
1569:     *             <reabilita o form Caixa> / ThisForm.Release
1570:     *         Else
1571:     *             ThisForm.OriDes = 2
1572:     *             If Not ThisForm.Processa()
1573:     *                 <reabilita o form Caixa> / ThisForm.Release
1574:     *             EndIf
1575:     *         Endif
1576:     *     EndIf
1577:     *
1578:     * Com lado LIVRE (OriDes = 0) o legado tenta a conta Origem e, nao
1579:     * acendendo painel nenhum, tenta a Destino forcando OriDes = 2; com lado
1580:     * FIXO nao ha segunda tentativa. Transcrito como esta.
1581:     *
1582:     * O Release() do legado NAO eh reproduzido aqui: Release dentro do Init
1583:     * cancela a instanciacao, e com isso o form pai perde a referencia de onde
1584:     * leria this_lRetorno (e o harness de teste nunca consegue instanciar a
1585:     * tela). No lugar dele fica this_lDialogoVazio, que Activate() consome para
1586:     * fechar de verdade - ver a nota la.
1587:     *
1588:     * PUBLIC de proposito: eh o ponto de entrada do processamento, chamado de
1589:     * fora da classe.
1590:     *==========================================================================
1591:     PROCEDURE ProcessarAberturaDialogo()
1592:         LOCAL loc_lAtivouPainel, loc_oBO, loc_oErro
1593: 
1594:         loc_lAtivouPainel = .F.
1595: 
1596:         TRY
1597:             loc_oBO = THIS.this_oBusinessObject
1598: 
1599:             IF VARTYPE(loc_oBO) = "O"
1600:                 IF loc_oBO.IniciarOperacao(THIS.this_cOperacao, THIS.this_nOriDes, ;
1601:                         THIS.this_cAliasMovCab)
1602: 
1603:                     THIS.this_nClickOriDes       = 0
1604:                     THIS.this_lLadoOpostoTentado = .F.
1605: 
1606:                     loc_lAtivouPainel = THIS.ProcessarLado()
1607: 
1608:                     *-- Segunda tentativa SO com lado livre (legado: OriDes = 2)
1609:                     IF !loc_lAtivouPainel AND THIS.this_nOriDes = 0
1610:                         THIS.this_nOriDes = 2
1611:                         loc_lAtivouPainel = THIS.ProcessarLado()
1612:                     ENDIF
1613:                 ENDIF
1614: 
1615:                 THIS.this_lRetorno = loc_oBO.this_lRetorno
1616:             ENDIF
1617: 
1618:             THIS.this_lDialogoVazio = !loc_lAtivouPainel
1619: 
1620:             *-- O legado reabilita o form Caixa no caminho em que desiste de
1621:             *-- abrir, logo antes do Release
1622:             IF THIS.this_lDialogoVazio AND VARTYPE(THIS.this_oFormCaixa) = "O"
1623:                 THIS.this_oFormCaixa.Enabled = .T.
1624:             ENDIF
1625:         CATCH TO loc_oErro
1626:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1627:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ProcessarAberturaDialogo")
1628:         ENDTRY
1629: 
1630:         RETURN loc_lAtivouPainel
1631:     ENDPROC
1632: 
1633:     *==========================================================================
1634:     * ConfigurarBotoes - unico botao de acao do form (legado: SIGOPLRC.ok,
1635:     * classe fwbtng, Top=3, Left=923, Caption="Encerrar", Cancel=.T.,
1636:     * Picture=cadastro_salvar_60.jpg, ToolTipText="[ESC] Encerrar").
1637:     *
1638:     * Geometria 75x75 (o canonico de botao do projeto) no lugar dos 80x100 da
1639:     * classe fwbtng: com 80 de largura o botao terminaria em 1003, fora do form
1640:     * de 1000, e com 100 de altura passaria da faixa do cabecalho. 923+75=998 e
1641:     * 3+75=78 cabem exatamente. O canonico cnt_4c_Saida (Left=917, Encerrar no
1642:     * rodape) NAO se aplica - eh dos CRUD paginados, e aqui o legado poe o
1643:     * botao no topo direito, sobre a faixa.
1644:     *
1645:     * Themes=.T. + DisabledPicture: CommandButton SOLTO (fora de CommandGroup)
1646:     * com Picture nao desenha o icone com Themes=.F.
1647:     *==========================================================================
1648:     PROTECTED PROCEDURE ConfigurarBotoes()
1649:         THIS.AddObject("cmd_4c_Ok", "CommandButton")
1650: 
1651:         WITH THIS.cmd_4c_Ok
1652:             .Top             = 3
1653:             .Left            = 923
1654:             .Width           = 75
1655:             .Height          = 75
1656:             .Caption         = "Encerrar"
1657:             .FontName        = "Comic Sans MS"
1658:             .FontSize        = 8
1659:             .FontBold        = .T.
1660:             .FontItalic      = .T.
1661:             .ForeColor       = RGB(90, 90, 90)
1662:             .BackColor       = RGB(255, 255, 255)
1663:             .Themes          = .T.
1664:             .SpecialEffect   = 0
1665:             .PicturePosition = 13
1666:             .MousePointer    = 15
1667:             .WordWrap        = .T.
1668:             .AutoSize        = .F.
1669:             .Cancel          = .T.
1670:             .TabIndex        = 1
1671:             .ToolTipText     = "[ESC] Encerrar"
1672:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1673:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1674:         ENDWITH
1675:     ENDPROC
1676: 
1677:     *==========================================================================
1678:     * ConfigurarEventos - BINDEVENT dos controles de acao. Os handlers alvo
1679:     * sao PUBLIC de proposito: BINDEVENT falha EM SILENCIO com metodo
1680:     * PROTECTED.
1681:     *==========================================================================
1682:     PROTECTED PROCEDURE ConfigurarEventos()
1683:         BINDEVENT(THIS.cmd_4c_Ok, "Click", THIS, "CmdOkClick")
1684: 
1685:         *-- Legado: Sit_Origem.Click / Sit_Destino.Click. "Click" (e nao
1686:         *-- InteractiveChange) eh o evento do legado, e eh o que tambem serve
1687:         *-- ao caminho em que um lado salta para o outro.
1688:         BINDEVENT(THIS.chk_4c_Sit_Origem,  "Click", THIS, "ChkSitOrigemClick")
1689:         BINDEVENT(THIS.chk_4c_Sit_Destino, "Click", THIS, "ChkSitDestinoClick")
1690:     ENDPROC
1691: 
1692:     *==========================================================================
1693:     * CmdOkClick - legado: SIGOPLRC.ok.Click
1694:     *     If Type('ThisForm.poFormCaixa') = "O"
1695:     *         ThisForm.PoFormCaixa.Enabled = .t.
1696:     *     Endif
1697:     *     Thisform.release
1698:     *==========================================================================
1699:     PROCEDURE CmdOkClick()
1700:         LOCAL loc_oErro
1701: 
1702:         TRY
1703:             THIS.FecharDialogo()
1704:         CATCH TO loc_oErro
1705:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1706:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em CmdOkClick")
1707:         ENDTRY
1708:     ENDPROC
1709: 
1710:     *==========================================================================
1711:     * ChkSitOrigemClick - legado: SIGOPLRC.Sit_Origem.Click (ver a transcricao
1712:     * linha a linha em TrocarLadoConta, que eh o corpo comum dos dois).
1713:     *
1714:     * Este wrapper existe por causa da guarda de reentrancia: o corpo mexe em
1715:     * Value/Enabled/Refresh dos proprios CheckBox e pode redisparar Click, e o
1716:     * caminho de falha salta para o lado oposto. Zerar this_lEmTrocaDeLado
1717:     * DEPOIS do ENDTRY (e tambem no CATCH) eh obrigatorio - flag que trava
1718:     * ligada mata a troca de lado pelo resto da vida do form.
1719:     *
1720:     * PUBLIC de proposito: BINDEVENT falha EM SILENCIO com metodo PROTECTED.
1721:     *==========================================================================
1722:     PROCEDURE ChkSitOrigemClick()
1723:         LOCAL loc_oErro
1724: 
1725:         TRY
1726:             IF !THIS.this_lEmTrocaDeLado
1727:                 THIS.this_lEmTrocaDeLado     = .T.
1728:                 THIS.this_lLadoOpostoTentado = .F.
1729: 
1730:                 THIS.TrocarLadoConta(1)
1731:             ENDIF
1732:         CATCH TO loc_oErro
1733:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1734:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ChkSitOrigemClick")
1735:         ENDTRY
1736: 
1737:         THIS.this_lEmTrocaDeLado = .F.
1738:     ENDPROC
1739: 
1740:     *==========================================================================
1741:     * ChkSitDestinoClick - legado: SIGOPLRC.Sit_Destino.Click. Ver a nota de
1742:     * ChkSitOrigemClick (guarda de reentrancia) e TrocarLadoConta (corpo).
1743:     *
1744:     * PUBLIC de proposito: BINDEVENT falha EM SILENCIO com metodo PROTECTED.
1745:     *==========================================================================
1746:     PROCEDURE ChkSitDestinoClick()
1747:         LOCAL loc_oErro
1748: 
1749:         TRY
1750:             IF !THIS.this_lEmTrocaDeLado
1751:                 THIS.this_lEmTrocaDeLado     = .T.
1752:                 THIS.this_lLadoOpostoTentado = .F.
1753: 
1754:                 THIS.TrocarLadoConta(2)
1755:             ENDIF
1756:         CATCH TO loc_oErro
1757:             MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo) + ;
1758:                 CHR(13) + "Procedure: " + loc_oErro.Procedure, "Erro em ChkSitDestinoClick")
1759:         ENDTRY
1760: 
1761:         THIS.this_lEmTrocaDeLado = .F.
1762:     ENDPROC
1763: 
1764:     *==========================================================================
1765:     * FecharDialogo - ponto UNICO de fechamento da tela.
1766:     *
1767:     * Fecha com Hide(), NAO com Release(): este form eh um dialogo que devolve
1768:     * resultado - quem o abre le THIS.this_lRetorno depois do Show() modal
1769:     * retornar (o legado devolvia pelo RETURN do evento Unload, inalcancavel em
1770:     * CREATEOBJECT + Show). Release() destroi o objeto mesmo com o chamador
1771:     * segurando a referencia, e a leitura seguinte estoura "is not an object".
1772:     * Cabe ao CHAMADOR dar Release() depois de ler. Hide() em form modal tambem
1773:     * devolve o Show(), entao para o usuario a tela fecha igual.
1774:     *
1775:     * Por isso o efeito EXTERNO que o legado fazia no ok.Click (reabilitar o
1776:     * form Caixa) mora aqui, antes do Hide, e nao so no Destroy: com Hide() o
1777:     * Destroy so roda quando o chamador liberar o objeto - tarde demais.
1778:     * O Destroy mantem a mesma reabilitacao como rede de seguranca (repetir eh
1779:     * inocuo) para o caminho em que a tela eh fechada sem passar por aqui.
1780:     *==========================================================================
1781:     PROCEDURE FecharDialogo()
1782:         IF VARTYPE(THIS.this_oFormCaixa) = "O"
1783:             THIS.this_oFormCaixa.Enabled = .T.
1784:         ENDIF
1785: 
1786:         THIS.Hide()
1787:     ENDPROC
1788: 
1789:     *==========================================================================
1790:     * Activate - fecha o dialogo quando nao ha nada para mostrar.
1791:     *
1792:     * O legado resolvia isso com ThisForm.Release DENTRO do Init, o que em VFP9
1793:     * CANCELA a instanciacao: CREATEOBJECT devolve .F. logico e o form pai
1794:     * perde a referencia de onde leria this_lRetorno (e o harness de teste
1795:     * nunca consegue instanciar a tela). Por isso ProcessarAberturaDialogo
1796:     * apenas MARCA this_lDialogoVazio e o fechamento acontece aqui - Activate
1797:     * roda DEPOIS do Show(), onde o Hide() de FecharDialogo devolve de fato o
1798:     * controle a quem abriu, com a referencia do form viva para a leitura do
1799:     * resultado.
1800:     *==========================================================================
1801:     PROCEDURE Activate()
1802:         IF THIS.this_lDialogoVazio
1803:             THIS.FecharDialogo()
1804:         ENDIF
1805: 
1806:         RETURN DODEFAULT()
1807:     ENDPROC
1808: 
1809:     *==========================================================================
1810:     * Unload - legado: PROCEDURE Unload / Return (ThisForm.Retorno).
1811:     * Mantido para atender quem abra a tela com DO FORM ... TO <var>; o
1812:     * consumo canonico no sistema novo eh ler THIS.this_lRetorno direto da
1813:     * referencia do form, que Hide() mantem viva.
1814:     *==========================================================================
1815:     PROCEDURE Unload()
1816:         RETURN THIS.this_lRetorno
1817:     ENDPROC
1818: 
1819:     *==========================================================================
1820:     * TornarControlesVisiveis - torna visiveis os controles do cabecalho.
1821:     * FILTRO OBRIGATORIO: cnt_4c_Container1/2/3 sao paineis FLUTUANTES que o
1822:     * BO mostra ou esconde conforme a operacao e o lado da conta em analise
1823:     * (regra de negocio, nao defeito de layout) - permanecem ocultos aqui.
1824:     *
1825:     * O filtro RECURSA no painel antes de pular: AddObject cria todo filho com
1826:     * Visible=.F., entao pular o container inteiro deixaria os FILHOS dele
1827:     * invisiveis para sempre - quando o BO acendesse cnt_4c_Container1 o painel
1828:     * apareceria VAZIO, sem a grade. Pula-se apenas o Visible do PROPRIO
1829:     * container.
1830:     *==========================================================================
1831:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1832:         LOCAL loc_nI, loc_oObjeto
1833: 
1834:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1835:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1836: 
1837:             IF VARTYPE(loc_oObjeto) = "O"
1838:                 IF INLIST(UPPER(loc_oObjeto.Name), "CNT_4C_CONTAINER1", "CNT_4C_CONTAINER2", "CNT_4C_CONTAINER3")
1839:                     IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1840:                         THIS.TornarControlesVisiveis(loc_oObjeto)
1841:                     ENDIF
1842:                     LOOP
1843:                 ENDIF
1844: 
1845:                 *-- lbl_4c_Msg5 (legado: lb_msg5) eh a linha de BLOQUEIO: o
1846:                 *-- legado a mantem oculta e so a acende quando a situacao da
1847:                 *-- conta recusa o movimento (ValidarSituacaoConta). Forcar
1848:                 *-- Visible = .T. aqui APAGARIA esse Visible = .F. e deixaria
1849:                 *-- uma faixa amarela vazia no bloco de situacao.
1850:                 IF UPPER(loc_oObjeto.Name) == "LBL_4C_MSG5"
1851:                     LOOP
1852:                 ENDIF
1853: 
1854:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1855:                     loc_oObjeto.Visible = .T.
1856:                 ENDIF
1857: 
1858:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1859:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1860:                 ENDIF
1861:             ENDIF
1862:         ENDFOR
1863:     ENDPROC
1864: 
1865:     *==========================================================================
1866:     * Destroy - reabilita o form Caixa (quando informado) e libera recursos
1867:     *==========================================================================
1868:     PROCEDURE Destroy()
1869:         IF VARTYPE(THIS.this_oFormCaixa) = "O"
1870:             THIS.this_oFormCaixa.Enabled = .T.
1871:         ENDIF
1872: 
1873:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
1874:             THIS.this_oBusinessObject = .NULL.
1875:         ENDIF
1876: 
1877:         IF USED("cursor_4c_Operacoes")
1878:             USE IN cursor_4c_Operacoes
1879:         ENDIF
1880: 
1881:         DODEFAULT()
1882:     ENDPROC
1883: 
1884: ENDDEFINE

