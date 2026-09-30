# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (3)
- [METODO-INEXISTENTE] Metodo 'THIS.MontarRetornoTef()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGPRDFT): Top original=200 vs migrado 'obj_4c_Optiongroup1' Top=4 (diff=196px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Optiongroup1' (parent: SIGPRDFT): Left original=222 vs migrado 'obj_4c_Optiongroup1' Left=5 (diff=217px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprdft.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2145 linhas total):

*-- Linhas 23 a 273:
23: *     a string de retorno do Unload - nao ha INSERT/UPDATE em tabela nenhuma.
24: *   - Habilitar...Campos / Limpar...Campos: o legado liga e desliga cada
25: *     controle no PONTO do protocolo em que o SiTef pede aquele dado
26: *     (GetDigitos.GotFocus, Text1.LostFocus, Optiongroup1.InteractiveChange,
27: *     GetDatas.GotFocus...), nao por modo de edicao. Concentrar isso num metodo
28: *     unico inverteria a ordem das habilitacoes e quebraria a negociacao com o
29: *     terminal.
30: *   - Btn...Encerrar...Click / Btn...Buscar...Click: nao existem no SCX. O unico
31: *     botao eh o Cancelar, migrado em BtnCancelarClick.
32: * FormParaBO/BOParaForm EXISTEM e sao reais: os seis campos de captura sao a
33: * ficha desta tela e o BO ja declarava as properties correspondentes.
34: *------------------------------------------------------------------------------
35: 
36: DEFINE CLASS Formsigprdft AS FormBase
37: 
38:     Height      = 370
39:     Width       = 500
40:     AutoCenter  = .T.
41:     BorderStyle = 2
42:     ShowWindow  = 0
43:     ShowWindow = 1
44:     ControlBox  = .F.
45:     Closable    = .F.
46:     FontName    = "Tahoma"
47:     FontSize    = 8
48:     MaxButton   = .F.
49:     MinButton   = .F.
50:     TitleBar    = 0
51:     WindowType  = 0
52:     KeyPreview  = .T.
53:     Themes      = .F.
54:     AlwaysOnTop = .T.
55: 
56:     this_oBusinessObject = .NULL.
57: 
58:     *-- Parametros recebidos na criacao (migrado de SIGPRDFT.Init PARAMETERS) -
59:     *-- guardados no Form ate InicializarForm() transferir para o BO.
60:     this_cEndSiTef = ""
61:     this_nValPago  = 0
62:     this_cCupom    = ""
63:     this_cCaixa    = ""
64:     this_cDebCred  = ""
65:     this_cTipPagto = ""
66:     this_nNumParcs = 1
67:     this_cIdent    = ""
68:     this_cOpers    = ""
69:     this_lKeyEsc   = .T.        && ThisForm.pckeyesc (legado) - habilita ESC para cancelar
70: 
71:     *-- ThisForm.abandona (legado - declarada em RESERVED3/ClassInfo do SCX).
72:     *-- O dump NUNCA a atribui: nasce .F. e so eh LIDA, em GetDigitos.Valid
73:     *-- ("IF tHISfORM.abandona / Thisform.release") e em GetDigitos.GotFocus
74:     *-- ("IF lnRetorno < 0 .or. ThisForm.Abandona"). Quem liga a flag eh o
75:     *-- chamador externo que abriu o dialogo, para derrubar a transacao em
76:     *-- curso. Declarada aqui para que os dois guards do legado continuem
77:     *-- existindo - sem a property eles nao teriam onde se apoiar.
78:     this_lAbandona = .F.
79: 
80:     *-- lnParcs / ldData do legado: variaveis PUBLIC declaradas no
81:     *-- SIGPRDFT.Init e lidas SO no Unload, que eh o RETURN da tela. NAO se
82:     *-- pode ler os controles no lugar delas - os dois divergem do controle de
83:     *-- proposito: Text1.LostFocus REFORMATA Text1.Value ("3" -> "03") DEPOIS
84:     *-- de o Valid ter gravado lnParcs, e Optiongroup1.InteractiveChange ZERA
85:     *-- GetDatas.Value sem tocar em ldData. Por isso moram aqui e sao
86:     *-- alimentadas nos MESMOS pontos do legado (Init, Text1.Valid e
87:     *-- GetDatas.Valid).
88:     *-- lnParcs eh CHARACTER apesar do prefixo "ln": o legado guarda
89:     *-- TRANSFORM(NumParcs,"@L 99") e depois Text1.Value, os dois char - eh o
90:     *-- que faz o "+" do Unload concatenar sem erro de tipo.
91:     this_cParcelasTef = ""
92:     this_dDataTef     = {}
93: 
94:     *-- pctvenda (property do SCX legado, default .T.). Unico consumidor:
95:     *-- Optiongroup1.When ("Return(ThisForm.pctvenda)"), que BLOQUEIA a entrada
96:     *-- de foco no grupo Tipo de Venda. Zerada em Text1.GotFocus e em
97:     *-- GetDatas.GotFocus - chegando nas parcelas ou no vencimento, o usuario
98:     *-- NAO volta mais a trocar o tipo da venda.
99:     *-- NAO eh o mesmo que Enabled: o legado le "IF Thisform.Optiongroup1.
100:     *-- Enabled" dentro de GetDatas.GotFocus para escolher o Buffer que manda
101:     *-- ao SiTef, entao colapsar pctvenda em .Enabled mudaria essa decisao.
102:     this_lTipoVendaLiberado = .T.
103: 
104:     *-- Espelho do RETURN do SIGPRDFT.Unload para o chamador que abre esta
105:     *-- tela por CREATEOBJECT + Show() (padrao do projeto), onde o valor
106:     *-- devolvido pelo evento Unload nao eh alcancavel. Preenchida no Destroy,
107:     *-- ANTES de o BO ser liberado.
108:     this_cRetornoTef = ""
109: 
110:     *--------------------------------------------------------------------------
111:     * Init - recebe os parametros da transacao (migrado de SIGPRDFT.Init
112:     * PARAMETERS EndSiTef, ValPago, Cupom, Caixa, DebCred, TipPagto, NumParcs,
113:     * lcIdent, pcOpers) e define Caption com CHR() antes de delegar ao FormBase
114:     *--------------------------------------------------------------------------
115:     PROCEDURE Init()
116:         LPARAMETERS par_cEndSiTef, par_nValPago, par_cCupom, par_cCaixa, ;
117:                     par_cDebCred, par_cTipPagto, par_nNumParcs, par_cIdent, par_cOpers
118: 
119:         THIS.Caption = "Sitef - Cart" + CHR(227) + "o de D" + CHR(233) + "bito"
120: 
121:         THIS.this_cEndSiTef = IIF(VARTYPE(par_cEndSiTef) = "C", par_cEndSiTef, "")
122:         THIS.this_nValPago  = IIF(VARTYPE(par_nValPago) = "N", par_nValPago, 0)
123:         THIS.this_cCupom    = IIF(VARTYPE(par_cCupom) $ "NC", TRANSFORM(par_cCupom, "@L 999999"), "000000")
124:         THIS.this_cCaixa    = IIF(VARTYPE(par_cCaixa) = "C", par_cCaixa, "")
125:         THIS.this_cDebCred  = IIF(VARTYPE(par_cDebCred) = "C", par_cDebCred, "")
126:         THIS.this_cTipPagto = IIF(VARTYPE(par_cTipPagto) = "C", par_cTipPagto, "")
127:         THIS.this_nNumParcs = IIF(VARTYPE(par_nNumParcs) = "N", par_nNumParcs, 1)
128:         THIS.this_cIdent    = IIF(VARTYPE(par_cIdent) $ "NC", TRANSFORM(par_cIdent), "")
129:         THIS.this_cOpers    = IIF(VARTYPE(par_cOpers) = "C", par_cOpers, "")
130: 
131:         *-- ShowWindow=1/WindowType=1 na classe causaria TIMEOUT em VFP9 -T
132:         *-- (top-level window bloqueante) em modo de teste automatizado.
133:         *-- Classe definida com ShowWindow=0/WindowType=0; producao restaura
134:         *-- o modal top-level aqui (SCX legado: WindowType = 1).
135:         IF !((TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI) OR ;
136:              (TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste))
137:             THIS.WindowType = 1
138:             THIS.ShowWindow = 1
139:         ENDIF
140:         RETURN DODEFAULT()
141:     ENDPROC
142: 
143:     *--------------------------------------------------------------------------
144:     * KeyPress - ESC cancela a transacao (migrado de SIGPRDFT.KeyPress).
145:     * KeyPreview=.T. na classe garante que este evento do FORM dispara antes
146:     * dos controles filhos processarem a tecla.
147:     *--------------------------------------------------------------------------
148:     PROCEDURE KeyPress(par_nKeyCode, par_nShiftAltCtrl)
149:         IF par_nKeyCode = 27 AND par_nShiftAltCtrl = 0 AND THIS.this_lKeyEsc
150:             NODEFAULT
151:             THIS.BtnCancelarClick()
152:         ENDIF
153:     ENDPROC
154: 
155:     *--------------------------------------------------------------------------
156:     * InicializarForm - cria o Business Object e monta a estrutura visual base
157:     *--------------------------------------------------------------------------
158:     PROTECTED PROCEDURE InicializarForm()
159:         LOCAL loc_lSucesso, loc_oErro
160:         loc_lSucesso = .F.
161: 
162:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
163:             RETURN .T.
164:         ENDIF
165: 
166:         TRY
167:             THIS.this_oBusinessObject = CREATEOBJECT("sigprdftBO")
168:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
169:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio sigprdftBO.", ;
170:                         "Erro em InicializarForm")
171:                 loc_lSucesso = .F.
172:             ELSE
173:                 THIS.ConfigurarPageFrame()
174:                 THIS.TornarControlesVisiveis(THIS)
175: 
176:                 *-- Transfere os parametros recebidos no Init para o BO e busca
177:                 *-- SigOpFp/sigcdemp/SIGFIMPF (migrado de SIGPRDFT.Init WITH
178:                 *-- Thisform / .poDatamgr.SqlExecute ...). Pulado em modo de
179:                 *-- teste headless (sem gnConnHandle real).
180:                 IF !(TYPE("gb_4c_ModoTeste") = "L" AND gb_4c_ModoTeste)
181:                     THIS.this_oBusinessObject.this_cEndSiTef = THIS.this_cEndSiTef
182:                     THIS.this_oBusinessObject.this_nValPago  = THIS.this_nValPago
183:                     THIS.this_oBusinessObject.this_cCupom    = THIS.this_cCupom
184:                     THIS.this_oBusinessObject.this_cCaixa    = THIS.this_cCaixa
185:                     THIS.this_oBusinessObject.this_cDebCred  = THIS.this_cDebCred
186:                     THIS.this_oBusinessObject.this_cTipPagto = THIS.this_cTipPagto
187:                     THIS.this_oBusinessObject.this_nNumParcs = THIS.this_nNumParcs
188:                     THIS.this_oBusinessObject.this_cIdent    = THIS.this_cIdent
189:                     THIS.this_oBusinessObject.this_cOpers    = THIS.this_cOpers
190: 
191:                     THIS.this_oBusinessObject.CarregarParametrosOperacao()
192:                 ENDIF
193: 
194:                 THIS.RegistrarEventosCampos()
195:                 THIS.ConfigurarValoresIniciais()
196: 
197:                 loc_lSucesso = .T.
198:             ENDIF
199:         CATCH TO loc_oErro
200:             MsgErro(loc_oErro.Message + CHR(13) + ;
201:                     "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
202:                     "Procedure: " + loc_oErro.Procedure, ;
203:                     "Erro em InicializarForm")
204:         ENDTRY
205: 
206:         RETURN loc_lSucesso
207:     ENDPROC
208: 
209:     *--------------------------------------------------------------------------
210:     * ConfigurarPageFrame - orquestra a montagem visual do form OPERACIONAL.
211:     * Nao ha PageFrame real (form legado nao tem Lista/Dados como CRUD); este
212:     * metodo delega para os configuradores especificos. SIGPRDFT eh um
213:     * dialogo modal de captura de pagamento (sem grid, sem lista, sem CRUD -
214:     * ver analise.json temGrid=false e layout.json sem BaseClass pageframe/
215:     * grid): a fase de estrutura visual completa aqui adiciona os campos e o
216:     * botao de saida REAIS do legado, em vez de Grid+botoes CRUD que nao
217:     * existem no SCX original (PILAR 1 - nao inventar UI). A logica de
218:     * validacao/protocolo SiTef (Valid/GotFocus dos campos) mora nos
219:     * metodos de validacao e nos handlers de GotFocus/KeyPress/LostFocus,
220:     * ligados aos controles por RegistrarEventosCampos().
221:     *--------------------------------------------------------------------------
222:     PROTECTED PROCEDURE ConfigurarPageFrame()
223:         THIS.ConfigurarCabecalho()
224:         THIS.ConfigurarCampos()
225:         THIS.ConfigurarBotaoSaida()
226:         THIS.ConfigurarOrdemTabulacao()
227:     ENDPROC
228: 
229:     *--------------------------------------------------------------------------
230:     * ConfigurarCabecalho - cria container escuro superior com labels de
231:     * titulo (migrado de SIGPRDFT.cntSombra/lblSombra/lblTitulo)
232:     *--------------------------------------------------------------------------
233:     PROTECTED PROCEDURE ConfigurarCabecalho()
234:         LOCAL loc_oCab
235: 
236:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
237:         loc_oCab = THIS.cnt_4c_Cabecalho
238:         WITH loc_oCab
239:             .Top         = 0
240:             .Left        = 0
241:             .Width       = THIS.Width
242:             .Height      = 80
243:             .BackColor   = RGB(100,100,100)
244:             .BackStyle   = 1
245:             .BorderWidth = 0
246:         ENDWITH
247: 
248:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
249:         WITH loc_oCab.lbl_4c_Sombra
250:             .AutoSize      = .F.
251:             .Width         = loc_oCab.Width - 10
252:             .Height        = 40
253:             .Top           = 18
254:             .Left          = 10
255:             .FontName      = "Tahoma"
256:             .FontSize      = 18
257:             .FontBold      = .T.
258:             .FontUnderline = .F.
259:             .Alignment     = 0
260:             .BackStyle     = 0
261:             .WordWrap      = .T.
262:             .ForeColor     = RGB(0,0,0)
263:             .Caption       = THIS.Caption
264:         ENDWITH
265: 
266:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
267:         WITH loc_oCab.lbl_4c_Titulo
268:             .AutoSize      = .F.
269:             .Width         = loc_oCab.Width - 10
270:             .Height        = 46
271:             .Top           = 17
272:             .Left          = 10
273:             .FontName      = "Tahoma"

*-- Linhas 288 a 334:
288:     * PageFrame - controles filhos de THIS, Top/Left transcritos EXATOS do
289:     * SCX legado, SEM compensacao +29 porque nao ha PageFrame.Top=-29 aqui).
290:     * Migrado de: SIGPRDFT.Shape2/Label5/GetValor/Label2/GetDigitos/Label8/
291:     * Container1(.Label1)/GetCartao/Label11/Label4/Optiongroup1/Label6/
292:     * Text1/GetDatas
293:     *--------------------------------------------------------------------------
294:     PROTECTED PROCEDURE ConfigurarCampos()
295:         LOCAL loc_oCnt
296: 
297:         *-- Shape2 - moldura decorativa ao redor dos campos
298:         THIS.AddObject("shp_4c_Shape2", "Shape")
299:         WITH THIS.shp_4c_Shape2
300:             .Top           = 93
301:             .Left          = 17
302:             .Width         = 466
303:             .Height        = 202
304:             .SpecialEffect = 0
305:         ENDWITH
306: 
307:         *-- Label5 "VALOR :" + txt_4c_Valor (GetValor)
308:         THIS.AddObject("lbl_4c_Label5", "Label")
309:         WITH THIS.lbl_4c_Label5
310:             .AutoSize  = .F.
311:             .Alignment = 0
312:             .Top       = 102
313:             .Left      = 175
314:             .Width     = 45
315:             .Height    = 15
316:             .FontName  = "Tahoma"
317:             .FontSize  = 8
318:             .FontBold  = .T.
319:             .ForeColor = RGB(90,90,90)
320:             .BackStyle = 0
321:             .Caption   = "VALOR :"
322:         ENDWITH
323: 
324:         THIS.AddObject("txt_4c_Valor", "TextBox")
325:         WITH THIS.txt_4c_Valor
326:             .Top               = 99
327:             .Left              = 222
328:             .Width             = 100
329:             .Height            = 23
330:             .Alignment         = 3
331:             .Value             = 0
332:             .InputMask         = "99,999,999.99"
333:             .Enabled           = .F.
334:             .FontName          = "Tahoma"

*-- Linhas 466 a 527:
466:             .DisabledForeColor = RGB(0,0,0)
467:         ENDWITH
468: 
469:         *-- Label4 "TIPO DE VENDA :" + obj_4c_Optiongroup1
470:         THIS.AddObject("lbl_4c_Label4", "Label")
471:         WITH THIS.lbl_4c_Label4
472:             .AutoSize  = .F.
473:             .Alignment = 0
474:             .Top       = 204
475:             .Left      = 129
476:             .Width     = 91
477:             .Height    = 15
478:             .FontName  = "Tahoma"
479:             .FontSize  = 8
480:             .FontBold  = .T.
481:             .ForeColor = RGB(90,90,90)
482:             .BackStyle = 0
483:             .Caption   = "TIPO DE VENDA :"
484:         ENDWITH
485: 
486:         THIS.AddObject("obj_4c_Optiongroup1", "OptionGroup")
487:         WITH THIS.obj_4c_Optiongroup1
488:             .ButtonCount = 2
489:             .Top         = 200
490:             .Left        = 222
491:             .Width       = 161
492:             .Height      = 26
493:             .Enabled     = .T.
494:             .Value       = 1
495: 
496:             WITH .Buttons(1)
497:                 .Caption   = " A vista"
498:                 .Top       = 4
499:                 .Left      = 5
500:                 .Width     = 61
501:                 .Height    = 17
502:                 .FontName  = "Tahoma"
503:                 .FontSize  = 8
504:                 .FontBold  = .T.
505:                 .ForeColor = RGB(90,90,90)
506:                 .BackStyle = 0
507:             ENDWITH
508: 
509:             WITH .Buttons(2)
510:                 .Caption   = " Predatado"
511:                 .Top       = 5
512:                 .Left      = 73
513:                 .Width     = 80
514:                 .Height    = 15
515:                 .FontName  = "Tahoma"
516:                 .FontSize  = 8
517:                 .FontBold  = .T.
518:                 .ForeColor = RGB(90,90,90)
519:                 .BackStyle = 0
520:             ENDWITH
521:         ENDWITH
522: 
523:         *-- Label6 "No PARCELAS :" + txt_4c_Text1 (Text1)
524:         THIS.AddObject("lbl_4c_Label6", "Label")
525:         WITH THIS.lbl_4c_Label6
526:             .AutoSize  = .F.
527:             .Alignment = 0

*-- Linhas 559 a 779:
559:     * (unico botao do form - dialogo modal de captura, sem CRUD).
560:     * Migrado de: SIGPRDFT.SAIDA (Command1/CANCELA)
561:     *--------------------------------------------------------------------------
562:     PROTECTED PROCEDURE ConfigurarBotaoSaida()
563:         THIS.AddObject("obj_4c_SAIDA", "CommandGroup")
564:         WITH THIS.obj_4c_SAIDA
565:             .ButtonCount = 1
566:             .AutoSize    = .T.
567:             .Top         = -2
568:             .Left        = 420
569:             .Width       = 85
570:             .Height      = 85
571:             .BorderStyle = 0
572:             *-- SCX legado: SAIDA.BackStyle = 0 (transparente). CommandGroup TEM
573:             *-- BackStyle - medido no VFP9, ao contrario do CommandButton, que
574:             *-- nao tem. Sem esta linha o grupo nasce opaco (default 1) e pinta
575:             *-- um retangulo branco sobre a faixa cinza do cabecalho.
576:             .BackStyle   = 0
577:             .BackColor   = RGB(255,255,255)
578:             .Themes      = .F.
579:             .Value       = 0
580: 
581:             WITH .Buttons(1)
582:                 .Top        = 5
583:                 .Left       = 5
584:                 .Width      = 75
585:                 .Height     = 75
586:                 .FontName   = "Comic Sans MS"
587:                 .FontSize   = 8
588:                 .FontBold   = .T.
589:                 .FontItalic = .T.
590:                 .Cancel     = .F.
591:                 .Caption    = "\<Cancelar"
592:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
593:                 .ForeColor  = RGB(90,90,90)
594:                 .BackColor  = RGB(255,255,255)
595:                 .Themes     = .F.
596:             ENDWITH
597:         ENDWITH
598:     ENDPROC
599: 
600:     *--------------------------------------------------------------------------
601:     * ConfigurarOrdemTabulacao - reproduz a ordem de tabulacao do SCX legado.
602:     *
603:     * Sem isto o TabIndex sai da ORDEM DE CRIACAO dos AddObject, que NAO eh a
604:     * do legado. Medido no VFP9 (automation\medir_tabindex_sigprdft.prg):
605:     *
606:     *   ordem de criacao : Valor -> Digitos -> Cartao -> Vencimento ->
607:     *                      Tipo de Venda -> Parcelas -> Cancelar
608:     *   TabIndex do SCX  : GetValor(1) -> GetCartao(2) -> GetDigitos(3) ->
609:     *                      Optiongroup1(5) -> Text1(6) -> GetDatas(7) ->
610:     *                      SAIDA(8)
611:     *
612:     * A divergencia NAO eh cosmetica: Text1.LostFocus habilita getDatas e o
613:     * KeyPress do Optiongroup1 faz KEYBOARD '{TAB}' - o legado conta com o Tab
614:     * saindo de "No PARCELAS" para "1a PARCELA/VENCTO". Na ordem de criacao o
615:     * Tab pula de "No PARCELAS" direto para o botao Cancelar, e o campo de
616:     * vencimento recem-habilitado so eh alcancado depois de dar a volta no form.
617:     *
618:     * TabIndex eh gravavel em runtime (medido): atribuir em ordem ASCENDENTE
619:     * poe cada controle na posicao pedida e empurra os demais para tras.
620:     * Os labels do legado tambem declaram TabIndex (5/6/7), mas Label NAO tem
621:     * TabStop (medido: .F.) - nao recebe foco. Transcrever esses valores seria
622:     * inerte e ainda embaralharia a sequencia dos controles que de fato param o
623:     * Tab, entao aqui so os focalizaveis sao numerados; labels e containers
624:     * ficam nas posicoes seguintes (8..15), sem efeito nenhum.
625:     *--------------------------------------------------------------------------
626:     PROTECTED PROCEDURE ConfigurarOrdemTabulacao()
627:         THIS.txt_4c_Valor.TabIndex        = 1    && SCX: GetValor      TabIndex=1
628:         THIS.txt_4c_Cartao.TabIndex       = 2    && SCX: GetCartao     TabIndex=2
629:         THIS.txt_4c_Digitos.TabIndex      = 3    && SCX: GetDigitos    TabIndex=3
630:         THIS.obj_4c_Optiongroup1.TabIndex = 4    && SCX: Optiongroup1  TabIndex=5
631:         THIS.txt_4c_Text1.TabIndex        = 5    && SCX: Text1         TabIndex=6
632:         THIS.txt_4c_Datas.TabIndex        = 6    && SCX: GetDatas      TabIndex=7
633:         THIS.obj_4c_SAIDA.TabIndex        = 7    && SCX: SAIDA         TabIndex=8
634:     ENDPROC
635: 
636:     *--------------------------------------------------------------------------
637:     * ConfigurarValoresIniciais - migrado da cauda de SIGPRDFT.Init (WITH
638:     * Thisform .GetDatas.Value/.GetValor.Value/.GetCartao.Enabled/
639:     * .Label2.Caption + Container1.Label1.Caption + Text1.Value + SetFocus)
640:     *--------------------------------------------------------------------------
641:     PROTECTED PROCEDURE ConfigurarValoresIniciais()
642:         LOCAL loc_oBO
643:         loc_oBO = THIS.this_oBusinessObject
644: 
645:         THIS.txt_4c_Datas.Value = DATE()
646:         THIS.txt_4c_Valor.Value = THIS.this_nValPago
647: 
648:         IF loc_oBO.this_lOpFpCartao
649:             THIS.txt_4c_Cartao.Enabled  = .T.
650:             THIS.lbl_4c_Label2.Caption  = "Validade Cartao :"
651:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Numero" + CHR(13) + "do Cartao"
652:         ELSE
653:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Insira ou Passe" + CHR(13) + "o Cartao"
654:         ENDIF
655: 
656:         THIS.txt_4c_Text1.Value = TRANSFORM(THIS.this_nNumParcs, "@L 99")
657: 
658:         *-- Legado SIGPRDFT.Init: lnParcs=TRANSFORM(NumParcs,"@L 99") / ldData=DATE()
659:         THIS.this_cParcelasTef = TRANSFORM(THIS.this_nNumParcs, "@L 99")
660:         THIS.this_dDataTef     = DATE()
661: 
662:         THIS.Refresh()
663:         THIS.txt_4c_Valor.SetFocus()
664:     ENDPROC
665: 
666:     *--------------------------------------------------------------------------
667:     * RegistrarEventosCampos - BINDEVENT dos campos com logica de protocolo
668:     * SiTef (migrado de GetDigitos/Text1/GetDatas/Optiongroup1/SAIDA). Valid
669:     * do legado eh reproduzido via KeyPress ENTER(13)/TAB(9) - BINDEVENT
670:     * "Valid" nao dispara de forma confiavel em TextBox (regra do projeto).
671:     *--------------------------------------------------------------------------
672:     PROTECTED PROCEDURE RegistrarEventosCampos()
673:         BINDEVENT(THIS.txt_4c_Digitos, "GotFocus", THIS, "DigitosGotFocus")
674:         BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "DigitosKeyPress")
675:         BINDEVENT(THIS.txt_4c_Digitos, "KeyPress", THIS, "DigitosLostFocus")
676: 
677:         BINDEVENT(THIS.txt_4c_Text1, "GotFocus", THIS, "Text1GotFocus")
678:         BINDEVENT(THIS.txt_4c_Text1, "KeyPress", THIS, "Text1KeyPress")
679:         BINDEVENT(THIS.txt_4c_Text1, "KeyPress", THIS, "Text1LostFocus")
680: 
681:         BINDEVENT(THIS.txt_4c_Datas, "GotFocus", THIS, "DatasGotFocus")
682:         BINDEVENT(THIS.txt_4c_Datas, "KeyPress", THIS, "DatasKeyPress")
683:         BINDEVENT(THIS.txt_4c_Datas, "KeyPress", THIS, "DatasLostFocus")
684: 
685:         BINDEVENT(THIS.obj_4c_Optiongroup1, "InteractiveChange", THIS, "OptTipoVendaChange")
686:         BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "KeyPress", THIS, "OptTipoVendaBtn1KeyPress")
687:         BINDEVENT(THIS.obj_4c_Optiongroup1.Buttons(1), "GotFocus", THIS, "OptTipoVendaBtn1GotFocus")
688: 
689:         BINDEVENT(THIS.obj_4c_SAIDA.Buttons(1), "Click", THIS, "BtnCancelarClick")
690:     ENDPROC
691: 
692:     *--------------------------------------------------------------------------
693:     * ExibirMensagemTef - substitui "DO Form SigTfDss WITH titulo,'',msg1,
694:     * msg2,'','VM',Left,Top" (dialogo de mensagem do legado, nao portado
695:     * nesta migracao - SIGTFDSS.scx nao faz parte do acervo). MsgAviso segue
696:     * o padrao do projeto (mensagens transitorias de protocolo, nao erro).
697:     *--------------------------------------------------------------------------
698:     PROTECTED PROCEDURE ExibirMensagemTef(par_cTitulo, par_cMsg1, par_cMsg2)
699:         LOCAL loc_cMsg
700:         loc_cMsg = ALLTRIM(par_cMsg1)
701:         IF !EMPTY(par_cMsg2)
702:             loc_cMsg = loc_cMsg + CHR(13) + ALLTRIM(par_cMsg2)
703:         ENDIF
704:         MsgAviso(loc_cMsg, par_cTitulo)
705:     ENDPROC
706: 
707:     *--------------------------------------------------------------------------
708:     * ErroTef - migrado de SIGPRDFT.errotef (PROCEDURE errotef PARAMETERS
709:     * pnRetornos). Mapeia os codigos de erro fixos do protocolo interativo.
710:     *--------------------------------------------------------------------------
711:     PROCEDURE ErroTef(par_nRetornos)
712:         LOCAL loc_oBO
713:         loc_oBO = THIS.this_oBusinessObject
714: 
715:         IF par_nRetornos = -1
716:             THIS.RetornoFalha("Modulo Nao Iniciado")
717:         ENDIF
718:         IF par_nRetornos = -2
719:             THIS.RetornoFalha("Operacao Cancelada pelo Usuario")
720:         ENDIF
721:         IF par_nRetornos = -3
722:             THIS.RetornoFalha("Fornecida uma Modalidade Invalida")
723:         ENDIF
724:         IF par_nRetornos = -4
725:             THIS.RetornoFalha("Falta Memoria para Rodar a Funcao")
726:         ENDIF
727:         IF par_nRetornos = -5
728:             THIS.RetornoFalha("Sem Comunicacao com o SiTef")
729:         ENDIF
730:     ENDPROC
731: 
732:     *--------------------------------------------------------------------------
733:     * RetornoFalha - migrado de SIGPRDFT.retornofalha. Monta o cursor crSiTef
734:     * (buffer de instrucoes do protocolo) e grava os arquivos SDF que o
735:     * software da impressora fiscal / retaguarda le (C:\client\Resp\*).
736:     * Pasta ausente nesta maquina (dev/teste sem integracao fiscal instalada)
737:     * -> grava eh pulada, sem quebrar o fluxo de cancelamento/erro.
738:     *--------------------------------------------------------------------------
739:     PROCEDURE RetornoFalha(par_cMensagem)
740:         LOCAL loc_cMensagem, loc_cValPago, loc_oErro
741: 
742:         loc_cMensagem = IIF(EMPTY(par_cMensagem), "Operacao Cancelada Pelo Usuario", par_cMensagem)
743:         loc_cValPago  = STRTRAN(ALLTRIM(TRANSFORM(THIS.this_oBusinessObject.this_nValPago, "99999999999.99")), ".", ",")
744: 
745:         IF !DIRECTORY("C:\client\Resp", 1)
746:             RETURN
747:         ENDIF
748: 
749:         TRY
750:             IF USED("crSiTef")
751:                 USE IN crSiTef
752:             ENDIF
753:             CREATE CURSOR crSiTef (tef c(100))
754: 
755:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
756:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
757:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
758:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
759:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
760:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = FF")
761:             INSERT INTO crSiTef (Tef) VALUES ("010-000 = 05")
762:             INSERT INTO crSiTef (Tef) VALUES ("028-000 = 0")
763:             INSERT INTO crSiTef (Tef) VALUES ("030-000 = " + IIF("AGUARDE" $ UPPER(loc_cMensagem), "TRANSACAO CANCELADA", loc_cMensagem))
764:             INSERT INTO crSiTef (Tef) VALUES ("150-000 = 00000000")
765:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
766: 
767:             SELECT crSiTef
768:             COPY TO C:\client\Resp\IntPos.001 SDF
769:             ZAP
770: 
771:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
772:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
773:             INSERT INTO crSiTef (Tef) VALUES ("999-999 = 0")
774: 
775:             COPY TO C:\client\Resp\IntPos.STS SDF
776: 
777:             USE IN crSiTef
778:         CATCH TO loc_oErro
779:             MsgErro(loc_oErro.Message, "Erro ao gravar retorno SiTef")

*-- Linhas 788 a 831:
788:     * DigitosGotFocus, onde o legado passa "lsNsu, lsNSU" (mesma variavel,
789:     * so difere em maiusculas) por engano historico. Transcrito literal.
790:     *--------------------------------------------------------------------------
791:     PROCEDURE MontaRetorno(par_cTipTran, par_cDataHora, par_cCupom, par_cCartao, ;
792:             par_cNsu, par_cAutoriza, par_cFinaliza, par_nValPago, par_cMenRet)
793:         LOCAL loc_cValPago, loc_aCartao[11], loc_cLsCartao, loc_cCupomRestante, ;
794:               loc_nPos, loc_nLinha, loc_oErro
795: 
796:         loc_cValPago = STRTRAN(ALLTRIM(TRANSFORM(par_nValPago, "99999999999.99")), ".", ",")
797: 
798:         loc_aCartao[1]  = "Outro, nao definido"
799:         loc_aCartao[2]  = "Visa"
800:         loc_aCartao[3]  = "Mastercard"
801:         loc_aCartao[4]  = "Diners"
802:         loc_aCartao[5]  = "American Express"
803:         loc_aCartao[6]  = "Sollo"
804:         loc_aCartao[7]  = "Sidecard (Redecard)"
805:         loc_aCartao[8]  = "Private Label (Redecard)"
806:         loc_aCartao[9]  = "Redeshop"
807:         loc_aCartao[10] = ""
808:         loc_aCartao[11] = "Fininvest"
809: 
810:         IF VAL(par_cCartao) > 10 OR VAL(par_cCartao) < 0
811:             loc_cLsCartao = "0"
812:         ELSE
813:             loc_cLsCartao = par_cCartao
814:         ENDIF
815: 
816:         IF !DIRECTORY("C:\client\Resp", 1)
817:             RETURN
818:         ENDIF
819: 
820:         TRY
821:             IF USED("crSiTef")
822:                 USE IN crSiTef
823:             ENDIF
824:             CREATE CURSOR crSiTef (tef c(100))
825: 
826:             INSERT INTO crSiTef (Tef) VALUES ("000-000 = CRT")
827:             INSERT INTO crSiTef (Tef) VALUES ("001-000 = " + STR(VAL(THIS.this_cIdent), 10))
828:             INSERT INTO crSiTef (Tef) VALUES ("002-000 = ")
829:             INSERT INTO crSiTef (Tef) VALUES ("003-000 = " + loc_cValPago)
830:             INSERT INTO crSiTef (Tef) VALUES ("004-000 = 0")
831:             INSERT INTO crSiTef (Tef) VALUES ("009-000 = 0")

*-- Linhas 884 a 1074:
884:     * O SCX legado nao tem lookup algum (zero fwBuscaExt / fwBuscaSel /
885:     * sigacess / mAddColuna no dump) - eh um dialogo de captura que conversa
886:     * com o terminal SiTef pela DLL CliSiTef32I, nao com tabela. Os unicos
887:     * campos digitaveis (GetDigitos, Text1, GetDatas) tem um PROCEDURE Valid
888:     * cujo INICIO eh validacao pura e o RESTO eh o avanco do protocolo. Os
889:     * metodos abaixo transcrevem essa cabeca de cada Valid; os handlers de
890:     * KeyPress chamam-nos e abortam quando reprovam - exatamente o que o
891:     * "Return(.f.)" do legado fazia (o Valid falso cancela a saida do campo).
892:     *==========================================================================
893: 
894:     *--------------------------------------------------------------------------
895:     * ValidarDigitos - cabeca de SIGPRDFT.GetDigitos.Valid:
896:     *     IF tHISfORM.abandona / Thisform.release / eNDIF
897:     *     IF LEN(Alltrim(This.Value)) <> 4 .and. ! EMPTY(This.Value)
898:     *         DO Form SigTfDss With ...,"Quantidade de Digitos Invalida",...
899:     *         This.Value = ""
900:     *         Return(.f.)
901:     *     ENDIF
902:     *     IF EMPTY(This.Value) / RETURN / Endif
903:     *
904:     * Devolve .T. so quando ha 4 digitos para transmitir. Campo VAZIO devolve
905:     * .F. de proposito: no legado o "RETURN" nu tambem eh saida limpa do Valid
906:     * que NAO avanca o protocolo - o usuario ainda nao digitou nada.
907:     * PUBLIC: chamado pelo handler ligado por BINDEVENT.
908:     *--------------------------------------------------------------------------
909:     PROCEDURE ValidarDigitos()
910:         LOCAL loc_lValido
911:         loc_lValido = .F.
912: 
913:         DO CASE
914:         CASE THIS.this_lAbandona
915:             *-- Legado: a flag derruba a tela antes de qualquer checagem.
916:             THIS.Release()
917: 
918:         CASE LEN(ALLTRIM(THIS.txt_4c_Digitos.Value)) != 4 AND !EMPTY(THIS.txt_4c_Digitos.Value)
919:             THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
920:                 "Quantidade de Digitos Invalida", "")
921:             THIS.txt_4c_Digitos.Value = ""
922: 
923:         CASE EMPTY(THIS.txt_4c_Digitos.Value)
924:             *-- Nada digitado: Valid valido, protocolo nao avanca.
925: 
926:         OTHERWISE
927:             loc_lValido = .T.
928:         ENDCASE
929: 
930:         RETURN loc_lValido
931:     ENDPROC
932: 
933:     *--------------------------------------------------------------------------
934:     * ValidarParcelas - cabeca de SIGPRDFT.Text1.Valid:
935:     *     IF EMPTY(THIS.Value) / RETURN .t. / Endif
936:     *
937:     * Unico guard que o legado tem neste campo. Devolve .F. no vazio (Valid
938:     * aprova, mas nao ha numero de parcelas para mandar ao SiTef) e .T. quando
939:     * ha valor. NAO acrescentar faixa minima/maxima: o legado nao a tem - quem
940:     * recusa parcela fora do permitido eh o proprio terminal, pelo
941:     * ProximoComando = 22, que o handler ja trata.
942:     * PUBLIC: chamado pelo handler ligado por BINDEVENT.
943:     *--------------------------------------------------------------------------
944:     PROCEDURE ValidarParcelas()
945:         RETURN !EMPTY(THIS.txt_4c_Text1.Value)
946:     ENDPROC
947: 
948:     *--------------------------------------------------------------------------
949:     * ValidarDataVencimento - cabeca de SIGPRDFT.GetDatas.Valid:
950:     *     IF LASTKEY() = 27 / RETURN .t. / ENDIF
951:     *     ldData=IIF(EMPTY(This.Value),DATE()+30,This.Value)
952:     *     This.Value = ldData
953:     *     This.Refresh
954:     *     IF ThisForm.Optiongroup1.Value = 2 .and. This.Value <= DATE() ;
955:     *        .and. ! EMPTY(This.Value)
956:     *         DO Form SigTfDss With ...,"Data Invalida",...
957:     *         RETURN .f.
958:     *     ENDIF
959:     *
960:     * O guard de ESC nao tinha sido migrado e a ORDEM importa: no legado ele
961:     * sai ANTES de o campo receber a data padrao (DATE()+30). Normalizar
962:     * primeiro gravaria vencimento numa transacao que o usuario abandonou.
963:     * PUBLIC: chamado pelo handler ligado por BINDEVENT.
964:     *--------------------------------------------------------------------------
965:     PROCEDURE ValidarDataVencimento()
966:         LOCAL loc_lValido, loc_dData
967:         loc_lValido = .F.
968: 
969:         DO CASE
970:         CASE LASTKEY() = 27
971:             *-- ESC: Valid do legado devolve .t. e nao toca em nada; aqui
972:             *-- devolve .F. porque o protocolo tambem nao deve avancar.
973: 
974:         OTHERWISE
975:             loc_dData = IIF(EMPTY(THIS.txt_4c_Datas.Value), DATE() + 30, THIS.txt_4c_Datas.Value)
976:             THIS.txt_4c_Datas.Value = loc_dData
977:             THIS.txt_4c_Datas.Refresh()
978: 
979:             *-- Legado GetDatas.Valid: "ldData=IIF(...)" vem ANTES da checagem
980:             *-- de data invalida - ldData fica gravado mesmo quando o Valid
981:             *-- recusa o valor. Ordem transcrita literal.
982:             THIS.this_dDataTef = loc_dData
983: 
984:             IF THIS.obj_4c_Optiongroup1.Value = 2 AND ;
985:                THIS.txt_4c_Datas.Value <= DATE() AND !EMPTY(THIS.txt_4c_Datas.Value)
986:                 THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
987:                     "Data Invalida", "")
988:             ELSE
989:                 loc_lValido = .T.
990:             ENDIF
991:         ENDCASE
992: 
993:         RETURN loc_lValido
994:     ENDPROC
995: 
996:     *--------------------------------------------------------------------------
997:     * BtnCancelarClick - migrado de SIGPRDFT.SAIDA.CANCELA.Click. PUBLIC porque
998:     * eh chamado via BINDEVENT (botao) e via KeyPress do form (tecla ESC).
999:     *
1000:     * Este eh o UNICO botao do form: o SCX legado declara so o CommandGroup
1001:     * SAIDA (ButtonCount = 1, Caption "\<Cancelar"). Nao ha barra CRUD nenhuma
1002:     * a migrar - o legado herda de `form` (nao de `frmcadastro`), nao tem
1003:     * Grupo_Op, nao tem pcEscolha e nao tem botao Incluir/Alterar/Visualizar/
1004:     * Excluir; inventar os quatro BtnXxxClick violaria o PILAR 1.
1005:     *
1006:     * O nome segue o prefixo canonico Btn*Click (e nao "CancelaClick", como o
1007:     * objeto do legado) porque essa eh a convencao do projeto para handler de
1008:     * botao - o mesmo criterio de "nomear pela ACAO, nao pelo nome do objeto
1009:     * legado". A acao aqui eh cancelar a transacao SiTef e liberar a tela.
1010:     *--------------------------------------------------------------------------
1011:     PROCEDURE BtnCancelarClick()
1012:         THIS.this_oBusinessObject.ContinuarSiTef(-1)
1013:         THIS.RetornoFalha("Oper. Cancelada pelo Usuario(1)")
1014:         THIS.Release()
1015:     ENDPROC
1016: 
1017:     *--------------------------------------------------------------------------
1018:     * DigitosGotFocus - conecta e inicia a transacao no SiTef, negocia o tipo
1019:     * de cartao (migrado de SIGPRDFT.GetDigitos.GotFocus). PUBLIC (BINDEVENT).
1020:     *--------------------------------------------------------------------------
1021:     PROCEDURE DigitosGotFocus()
1022:         LOCAL loc_oBO, loc_nRetorno, loc_cData, loc_cHora, loc_lContinua, ;
1023:               loc_nTipo, loc_nTipoVenda, loc_lTipoVenda, loc_cBandeiraLocal
1024: 
1025:         *-- Migrado de SIGPRDFT.GetDigitos.When, INTEIRO:
1026:         *--     If Empty(This.Value) / Set Confirm Off / Endif
1027:         *--     Return(EMPTY(This.Value))
1028:         *-- O RETURN eh um GATE, nao decoracao: com o campo ja preenchido o
1029:         *-- When RECUSA o foco, e por isso o GotFocus do legado nunca roda uma
1030:         *-- segunda vez. Reproduzido como saida antecipada - sem ele, voltar ao
1031:         *-- campo preenchido com TAB chamaria ConectarSiTef/IniciarSiTef de
1032:         *-- novo e REINICIARIA uma transacao ja autorizada.
1033:         *-- BINDEVENT em "When" nao serve: o retorno do delegate eh descartado,
1034:         *-- logo nao bloqueia nada (mesma razao do gate do Optiongroup1).
1035:         IF !EMPTY(THIS.txt_4c_Digitos.Value)
1036:             RETURN
1037:         ENDIF
1038:         SET CONFIRM OFF
1039: 
1040:         loc_oBO = THIS.this_oBusinessObject
1041: 
1042:         IF !loc_oBO.ConectarSiTef()
1043:             THIS.RetornoFalha("Sem comunicacao com SiTef")
1044:             THIS.Release()
1045:             RETURN
1046:         ENDIF
1047: 
1048:         loc_cData = STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2)
1049:         loc_cHora = STRTRAN(TIME(), ":", "")
1050: 
1051:         IF !loc_oBO.IniciarSiTef(0, STRTRAN(ALLTRIM(TRANSFORM(loc_oBO.this_nValPago, "99999999.99")), ".", ","), ;
1052:                 loc_oBO.this_cCupom, loc_cData, loc_cHora)
1053:             THIS.RetornoFalha("Sem comunicacao com SiTef")
1054:             THIS.Release()
1055:             RETURN
1056:         ENDIF
1057: 
1058:         loc_oBO.this_nProximoComando  = 0
1059:         loc_oBO.this_nTipoCampo       = 0
1060:         loc_oBO.this_nTamanhoMinimo   = 0
1061:         loc_oBO.this_nTamanhoMaximo   = 0
1062:         loc_oBO.this_cBuffer          = SPACE(2000)
1063:         loc_oBO.this_nContinua        = 0
1064:         loc_oBO.this_cTipoTransacao   = ""
1065:         loc_oBO.this_cDataHoraTef     = ""
1066:         loc_oBO.this_cCupomTef        = ""
1067:         loc_oBO.this_cCartaoAux       = ""
1068:         loc_oBO.this_cNsu             = ""
1069:         loc_oBO.this_cAutorizacao     = ""
1070:         loc_oBO.this_cFinalizacao     = ""
1071:         loc_oBO.this_cMensagemRetorno = ""
1072: 
1073:         loc_nTipo         = 1
1074:         loc_nTipoVenda     = 0

*-- Linhas 1081 a 1124:
1081:         loc_nRetorno       = 0
1082:         loc_lContinua      = !loc_oBO.this_lOpFpCartao
1083: 
1084:         THIS.obj_4c_Optiongroup1.Enabled = .F.
1085: 
1086:         DO WHILE loc_lContinua
1087:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1088: 
1089:             IF "SELECIONE A FORMA DE PAGAMENTO PAGAMENTO" $ UPPER(loc_oBO.this_cBuffer)
1090:                 IF loc_nTipoVenda = 2
1091:                     loc_lTipoVenda = .T.
1092:                 ELSE
1093:                     loc_nTipoVenda = 2
1094:                 ENDIF
1095:             ENDIF
1096: 
1097:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1098: 
1099:             IF loc_oBO.this_nProximoComando = 22
1100:                 IF LEN(ALLTRIM(loc_oBO.this_cBuffer)) != 0
1101:                     THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1102:                         ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
1103:                     loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1104:                     loc_nRetorno = -1
1105:                     EXIT
1106:                 ENDIF
1107:             ENDIF
1108: 
1109:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) = "DIGITE A SENHA"
1110:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1111:             ENDIF
1112: 
1113:             IF loc_nRetorno = 0
1114:                 EXIT
1115:             ENDIF
1116:             IF loc_nRetorno < 0
1117:                 THIS.ErroTef(loc_nRetorno)
1118:                 THIS.Release()
1119:                 RETURN
1120:             ENDIF
1121: 
1122:             IF loc_oBO.this_nProximoComando = 3
1123:                 loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
1124:             ENDIF

*-- Linhas 1260 a 1400:
1260:             IF !THIS.txt_4c_Text1.Enabled
1261:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Informe o Tipo" + CHR(13) + "da Venda"
1262:                 THIS.txt_4c_Digitos.Enabled = .F.
1263:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
1264:                 THIS.txt_4c_Datas.Enabled = .T.
1265:             ENDIF
1266:         ELSE
1267:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite os 4 Ultimos" + CHR(13) + "Digitos do Cartao"
1268:             THIS.obj_4c_Optiongroup1.Enabled = .T.
1269:         ENDIF
1270: 
1271:         THIS.obj_4c_SAIDA.Enabled = .T.
1272:     ENDPROC
1273: 
1274:     *--------------------------------------------------------------------------
1275:     * DigitosLostFocus - migrado de SIGPRDFT.GetDigitos.LostFocus
1276:     *--------------------------------------------------------------------------
1277:     PROCEDURE DigitosLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1278:         SET CONFIRM ON
1279:     ENDPROC
1280: 
1281:     *--------------------------------------------------------------------------
1282:     * DigitosKeyPress - equivalente ao SIGPRDFT.GetDigitos.Valid (disparado
1283:     * em ENTER/TAB - BINDEVENT "Valid" nao eh confiavel em TextBox).
1284:     *--------------------------------------------------------------------------
1285:     PROCEDURE DigitosKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1286:         LOCAL loc_oBO, loc_nRetorno, loc_lParcelas, loc_nCampo
1287: 
1288:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1289:             RETURN
1290:         ENDIF
1291: 
1292:         *-- Cabeca do Valid legado (abandona / 4 digitos / campo vazio).
1293:         IF !THIS.ValidarDigitos()
1294:             RETURN
1295:         ENDIF
1296: 
1297:         loc_oBO = THIS.this_oBusinessObject
1298: 
1299:         loc_lParcelas = .F.
1300:         loc_oBO.this_cMensagemRetorno = ""
1301:         loc_oBO.this_cBuffer = ALLTRIM(THIS.txt_4c_Digitos.Value) + REPLICATE(CHR(0), 2000 - LEN(ALLTRIM(THIS.txt_4c_Digitos.Value)))
1302:         loc_oBO.this_nContinua = 1000
1303:         loc_nRetorno = 10000
1304:         loc_nCampo = 1
1305: 
1306:         DO WHILE loc_nRetorno = 10000
1307:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1308: 
1309:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1310: 
1311:             IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
1312:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1313:             ENDIF
1314:             IF loc_nRetorno = 0
1315:                 EXIT
1316:             ENDIF
1317:             IF loc_nRetorno < 0
1318:                 THIS.ErroTef(loc_nRetorno)
1319:                 THIS.Release()
1320:                 RETURN
1321:             ENDIF
1322:             IF loc_oBO.this_nProximoComando = 22
1323:                 THIS.ExibirMensagemTef("Erro na Trasa" + CHR(231) + CHR(227) + "o", ;
1324:                     ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
1325:                 loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1326:                 IF loc_nRetorno != 10000
1327:                     EXIT
1328:                 ELSE
1329:                     IF loc_lParcelas
1330:                         THIS.txt_4c_Text1.Enabled = .T.
1331:                         THIS.obj_4c_Optiongroup1.Enabled = .F.
1332:                         RETURN
1333:                     ELSE
1334:                         RETURN
1335:                     ENDIF
1336:                 ENDIF
1337:             ENDIF
1338:             IF loc_oBO.this_nProximoComando = 21
1339:                 loc_oBO.this_cBuffer = IIF(loc_oBO.this_nNumParcs = 1, ;
1340:                     IIF(THIS.txt_4c_Datas.Value = DATE(), "1", "2"), IIF(loc_oBO.this_cDebCred = "P", "3", "4")) + REPLICATE(CHR(0), 1999)
1341:                 IF loc_oBO.this_cBuffer = "1"
1342:                     EXIT
1343:                 ENDIF
1344:                 loc_oBO.this_nContinua = 1000
1345:                 LOOP
1346:             ENDIF
1347:             IF loc_oBO.this_nProximoComando = 23
1348:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1349:             ENDIF
1350:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 510
1351:                 IF loc_oBO.this_lOpFpGarantias
1352:                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1353:                 ELSE
1354:                     loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
1355:                 ENDIF
1356:                 loc_oBO.this_nContinua = 1000
1357:             ENDIF
1358:             IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
1359:                 IF loc_oBO.this_lOpFpSaque
1360:                     MsgAviso("Saque via SiTef requer o dialogo SigCsTef, nao portado nesta migracao. Valor de saque assumido: 0,00.", "Saque")
1361:                 ENDIF
1362:                 loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
1363:                 loc_oBO.this_nContinua = 1000
1364:                 LOOP
1365:             ENDIF
1366:             IF loc_oBO.this_nProximoComando = 30 AND (loc_oBO.this_nTipoCampo = -1 OR loc_oBO.this_nTipoCampo = 506) AND loc_oBO.this_cDebCred != "P"
1367:                 THIS.txt_4c_Datas.Enabled = .T.
1368:                 EXIT
1369:             ENDIF
1370:             IF loc_oBO.this_nProximoComando = 30 AND (loc_oBO.this_cDebCred = "P" OR loc_oBO.this_nTipoCampo = 511)
1371:                 IF loc_nCampo = 1
1372:                     loc_oBO.this_cBuffer = TRANSFORM(loc_oBO.this_nNumParcs, "@L 99") + REPLICATE(CHR(0), 1999)
1373:                     loc_lParcelas = .T.
1374:                     loc_nCampo = 2
1375:                     LOOP
1376:                 ELSE
1377:                     THIS.txt_4c_Datas.Enabled = .T.
1378:                     EXIT
1379:                 ENDIF
1380:             ENDIF
1381:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) = "DIGITE A SENHA"
1382:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1383:             ENDIF
1384:             IF loc_oBO.this_nProximoComando = 3
1385:                 loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
1386:             ENDIF
1387:             IF loc_oBO.this_nTipoCampo = 100
1388:                 loc_oBO.this_cTipoTransacao = loc_oBO.this_cBuffer
1389:             ENDIF
1390:             IF loc_oBO.this_nTipoCampo = 105
1391:                 loc_oBO.this_cDataHoraTef = loc_oBO.this_cBuffer
1392:             ENDIF
1393:             IF loc_oBO.this_nTipoCampo = 121
1394:                 loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
1395:             ENDIF
1396:             IF loc_oBO.this_nTipoCampo = 131
1397:                 loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
1398:             ENDIF
1399:             IF loc_oBO.this_nTipoCampo = 132
1400:                 loc_oBO.this_cBandeira = LEFT(loc_oBO.this_cBuffer, 5)

*-- Linhas 1422 a 1679:
1422: 
1423:         IF loc_nRetorno != 10000
1424:             IF loc_oBO.this_cDebCred = "P" AND loc_oBO.this_cOpFpTcdc != "S"
1425:                 MsgAviso("Consulta CDC (SigCoCDC) nao portada nesta migracao.", "Consulta CDC")
1426:                 THIS.RetornoFalha("Consulta CDC Realizada")
1427:             ELSE
1428:                 IF loc_nRetorno = 0
1429:                     THIS.MontaRetorno(loc_oBO.this_cTipoTransacao, loc_oBO.this_cDataHoraTef, ;
1430:                         loc_oBO.this_cCupomTef, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
1431:                         loc_oBO.this_cAutorizacao, loc_oBO.this_cFinalizacao, loc_oBO.this_nValPago, ;
1432:                         loc_oBO.this_cMensagemRetorno)
1433:                 ENDIF
1434:             ENDIF
1435:             THIS.Release()
1436:             RETURN
1437:         ENDIF
1438: 
1439:         IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 514
1440:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite Codigo" + CHR(13) + "de Seguranca"
1441:         ELSE
1442:             IF loc_oBO.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada
1443:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite o Tipo" + CHR(13) + "Venda"
1444:                 THIS.obj_4c_Optiongroup1.Enabled = .T.
1445:                 THIS.txt_4c_Datas.Enabled = .T.
1446:             ELSE
1447:                 THIS.obj_4c_Optiongroup1.Enabled = .F.
1448:             ENDIF
1449:         ENDIF
1450:         THIS.txt_4c_Digitos.Enabled = .F.
1451:         THIS.obj_4c_Optiongroup1.Enabled = .T.
1452:     ENDPROC
1453: 
1454:     *--------------------------------------------------------------------------
1455:     * Text1GotFocus/LostFocus/KeyPress - migrado de SIGPRDFT.Text1 (numero
1456:     * de parcelas digitado manualmente quando o SiTef pede confirmacao).
1457:     *--------------------------------------------------------------------------
1458:     PROCEDURE Text1GotFocus()
1459:         *-- Migrado de SIGPRDFT.Text1.When ("Set Confirm off").
1460:         SET CONFIRM OFF
1461: 
1462:         *-- Legado Text1.GotFocus: "ThisForm.pcTvenda = .f." - fecha o gate do
1463:         *-- Optiongroup1.When. TEM efeito observavel (a fase anterior anotou o
1464:         *-- contrario por engano): a partir daqui o grupo Tipo de Venda deixa
1465:         *-- de aceitar foco, e o usuario nao volta mais a troca-lo.
1466:         THIS.this_lTipoVendaLiberado = .F.
1467:     ENDPROC
1468: 
1469:     PROCEDURE Text1LostFocus(par_nKeyCode, par_nShiftAltCtrl)
1470:         SET CONFIRM ON
1471:         THIS.txt_4c_Text1.Value = TRANSFORM(VAL(THIS.txt_4c_Text1.Value), "@L 99")
1472:         THIS.txt_4c_Text1.Enabled = .F.
1473:         THIS.txt_4c_Datas.Enabled = .T.
1474:     ENDPROC
1475: 
1476:     PROCEDURE Text1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1477:         LOCAL loc_oBO, loc_nRetorno
1478: 
1479:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1480:             RETURN
1481:         ENDIF
1482: 
1483:         *-- Cabeca do Valid legado (campo vazio nao avanca o protocolo).
1484:         IF !THIS.ValidarParcelas()
1485:             RETURN
1486:         ENDIF
1487: 
1488:         *-- Legado Text1.Valid: "lnParcs=This.Value", logo apos o guard de
1489:         *-- campo vazio e ANTES de montar o Buffer.
1490:         THIS.this_cParcelasTef = THIS.txt_4c_Text1.Value
1491: 
1492:         loc_oBO = THIS.this_oBusinessObject
1493:         loc_oBO.this_cBuffer = THIS.txt_4c_Text1.Value + REPLICATE(CHR(0), 1990)
1494:         loc_oBO.this_nContinua = 1000
1495:         loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1496: 
1497:         THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1498: 
1499:         IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
1500:             THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1501:         ENDIF
1502:         IF loc_oBO.this_nProximoComando = 22
1503:             THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1504:                 ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
1505:             loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1506:             RETURN
1507:         ENDIF
1508:         loc_oBO.this_cBuffer = ""
1509:         loc_oBO.this_nContinua = 0
1510:     ENDPROC
1511: 
1512:     *--------------------------------------------------------------------------
1513:     * OptTipoVendaChange/Btn1KeyPress/Btn1GotFocus - migrado de
1514:     * SIGPRDFT.Optiongroup1 (InteractiveChange/Option1.KeyPress/Option1.GotFocus)
1515:     *--------------------------------------------------------------------------
1516:     *-- Os tres handlers abrem com o gate de SIGPRDFT.Optiongroup1.When
1517:     *-- ("Return(ThisForm.pctvenda)"): com pctvenda em .F. o When recusa o foco
1518:     *-- e NENHUM evento do grupo chega a rodar. Reproduzido como saida
1519:     *-- antecipada em cada handler porque BINDEVENT em "When" nao bloqueia (o
1520:     *-- retorno do delegate eh descartado) e porque mapear pctvenda em
1521:     *-- .Enabled corromperia o "IF Thisform.Optiongroup1.Enabled" que
1522:     *-- DatasGotFocus le para montar o Buffer do SiTef.
1523:     PROCEDURE OptTipoVendaChange()
1524:         IF !THIS.this_lTipoVendaLiberado
1525:             RETURN
1526:         ENDIF
1527: 
1528:         THIS.txt_4c_Datas.Enabled = .T.
1529:         IF THIS.obj_4c_Optiongroup1.Value = 1
1530:             THIS.txt_4c_Datas.Value = DATE()
1531:         ELSE
1532:             THIS.txt_4c_Datas.Value = {}
1533:         ENDIF
1534:     ENDPROC
1535: 
1536:     PROCEDURE OptTipoVendaBtn1KeyPress(par_nKeyCode, par_nShiftAltCtrl)
1537:         IF !THIS.this_lTipoVendaLiberado
1538:             RETURN
1539:         ENDIF
1540: 
1541:         IF par_nKeyCode = 13
1542:             KEYBOARD "{TAB}"
1543:         ENDIF
1544:     ENDPROC
1545: 
1546:     PROCEDURE OptTipoVendaBtn1GotFocus()
1547:         IF !THIS.this_lTipoVendaLiberado
1548:             RETURN
1549:         ENDIF
1550: 
1551:         THIS.txt_4c_Datas.Enabled = .T.
1552:     ENDPROC
1553: 
1554:     *--------------------------------------------------------------------------
1555:     * DatasLostFocus - migrado de SIGPRDFT.GetDatas.LostFocus
1556:     *--------------------------------------------------------------------------
1557:     PROCEDURE DatasLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1558:         SET CONFIRM ON
1559:     ENDPROC
1560: 
1561:     *--------------------------------------------------------------------------
1562:     * DatasGotFocus - migrado de SIGPRDFT.GetDatas.GotFocus (reinicia estado
1563:     * de retorno e, quando a forma de pagamento nao aceita cartao/OptionGroup
1564:     * ja resolvido, avanca o protocolo ate ProximoComando=30 sozinho).
1565:     *--------------------------------------------------------------------------
1566:     PROCEDURE DatasGotFocus()
1567:         LOCAL loc_oBO, loc_nRetorno
1568: 
1569:         *-- Migrado de SIGPRDFT.GetDatas.When ("Set Confirm Off").
1570:         SET CONFIRM OFF
1571: 
1572:         *-- Legado GetDatas.GotFocus, PRIMEIRA linha: "ThisForm.pcTvenda = .f."
1573:         *-- Fecha o gate do Optiongroup1.When. NAO mexer em
1574:         *-- obj_4c_Optiongroup1.Enabled aqui: o proprio legado LE
1575:         *-- "IF Thisform.Optiongroup1.Enabled" alguns passos abaixo, neste
1576:         *-- mesmo metodo, para escolher o Buffer que envia ao SiTef.
1577:         THIS.this_lTipoVendaLiberado = .F.
1578: 
1579:         loc_oBO = THIS.this_oBusinessObject
1580: 
1581:         loc_oBO.this_cTipoTransacao   = ""
1582:         loc_oBO.this_cDataHoraTef     = ""
1583:         loc_oBO.this_cCupomTef        = ""
1584:         loc_oBO.this_cCartaoAux       = ""
1585:         loc_oBO.this_cNsu             = ""
1586:         loc_oBO.this_cAutorizacao     = ""
1587:         loc_oBO.this_cFinalizacao     = ""
1588:         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Data" + CHR(13) + "de Vencimento"
1589:         loc_oBO.this_cMensagemRetorno = ""
1590: 
1591:         IF loc_oBO.this_cDebCred != "P" AND !loc_oBO.this_lDataConfirmada AND loc_oBO.this_cOpFpTcdc != "S"
1592:             loc_oBO.this_nContinua = 1000
1593:             IF THIS.obj_4c_Optiongroup1.Enabled
1594:                 loc_oBO.this_cBuffer = STR(THIS.obj_4c_Optiongroup1.Value, 1) + REPLICATE(CHR(0), 1999)
1595:             ELSE
1596:                 DO WHILE loc_oBO.this_nProximoComando != 30
1597:                     loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1598:                     THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1599:                     IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
1600:                         THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1601:                     ENDIF
1602:                     IF loc_nRetorno < 0
1603:                         THIS.ErroTef(loc_nRetorno)
1604:                         THIS.Release()
1605:                         RETURN
1606:                     ENDIF
1607:                 ENDDO
1608:                 loc_oBO.this_cBuffer = THIS.txt_4c_Text1.Value + REPLICATE(CHR(0), 1998)
1609:             ENDIF
1610: 
1611:             loc_nRetorno = 10000
1612:             DO WHILE loc_nRetorno = 10000
1613:                 loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1614: 
1615:                 THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1616:                 IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
1617:                     THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1618:                 ENDIF
1619:                 IF loc_nRetorno < 0
1620:                     THIS.ErroTef(loc_nRetorno)
1621:                     THIS.Release()
1622:                     RETURN
1623:                 ENDIF
1624:                 IF loc_oBO.this_nProximoComando = 22
1625:                     THIS.ExibirMensagemTef("Erro na Transa" + CHR(231) + CHR(227) + "o", ;
1626:                         ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 1, 32)), ALLTRIM(SUBSTR(loc_oBO.this_cBuffer, 33, 32)))
1627:                     IF "CANC. CLIENTE" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer))
1628:                         loc_oBO.ContinuarSiTef(-1)
1629:                         RETURN
1630:                     ENDIF
1631:                     loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1632:                     IF loc_nRetorno != 10000
1633:                         THIS.Release()
1634:                         RETURN
1635:                     ELSE
1636:                         RETURN
1637:                     ENDIF
1638:                 ENDIF
1639:                 IF loc_oBO.this_nProximoComando = 30 AND THIS.obj_4c_Optiongroup1.Value = 2
1640:                     IF loc_oBO.this_nTipoCampo = 510
1641:                         IF loc_oBO.this_lOpFpGarantias
1642:                             loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1643:                         ELSE
1644:                             loc_oBO.this_cBuffer = "2" + REPLICATE(CHR(0), 1999)
1645:                         ENDIF
1646:                         loc_oBO.this_nContinua = 1000
1647:                         LOOP
1648:                     ENDIF
1649:                     EXIT
1650:                 ENDIF
1651:                 IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 506
1652:                     loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 1, 2)) + ;
1653:                         ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 4, 2)) + ;
1654:                         ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 7, 4)) + REPLICATE(CHR(0), 1992)
1655:                     loc_oBO.this_nContinua = 1000
1656:                     LOOP
1657:                 ENDIF
1658:                 IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 505
1659:                     loc_oBO.this_cBuffer = ALLTRIM(TRANSFORM(loc_oBO.this_nNumParcs, "@L 99")) + REPLICATE(CHR(0), 1998)
1660:                     loc_oBO.this_nContinua = 1000
1661:                     LOOP
1662:                 ENDIF
1663:                 IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 507
1664:                     IF MsgConfirma("Primeira Parcela A Vista", "Confirma")
1665:                         loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1666:                     ELSE
1667:                         loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1668:                     ENDIF
1669:                     loc_oBO.this_nContinua = 1000
1670:                     LOOP
1671:                 ENDIF
1672:                 IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 508
1673:                     loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nOpFpDias)) + REPLICATE(CHR(0), 1998)
1674:                     loc_oBO.this_nContinua = 1000
1675:                     LOOP
1676:                 ENDIF
1677:                 IF loc_oBO.this_nProximoComando = 20 AND loc_oBO.this_nTipoCampo = 509
1678:                     loc_oBO.this_cBuffer = ALLTRIM(STR(loc_oBO.this_nOpFpMesFec - 1)) + REPLICATE(CHR(0), 1999)
1679:                     loc_oBO.this_nContinua = 1000

*-- Linhas 1692 a 1735:
1692:                 ENDIF
1693:                 IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
1694:                     IF loc_oBO.this_lOpFpSaque
1695:                         MsgAviso("Saque via SiTef requer o dialogo SigCsTef, nao portado nesta migracao. Valor de saque assumido: 0,00.", "Saque")
1696:                     ENDIF
1697:                     loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
1698:                     loc_oBO.this_nContinua = 1000
1699:                     LOOP
1700:                 ENDIF
1701:                 IF loc_oBO.this_nProximoComando = 3
1702:                     loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
1703:                 ENDIF
1704:                 IF loc_oBO.this_nTipoCampo = 100
1705:                     loc_oBO.this_cTipoTransacao = loc_oBO.this_cBuffer
1706:                 ENDIF
1707:                 IF loc_oBO.this_nTipoCampo = 105
1708:                     loc_oBO.this_cDataHoraTef = loc_oBO.this_cBuffer
1709:                 ENDIF
1710:                 IF loc_oBO.this_nTipoCampo = 121
1711:                     loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
1712:                 ENDIF
1713:                 IF loc_oBO.this_nTipoCampo = 131
1714:                     loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
1715:                 ENDIF
1716:                 IF loc_oBO.this_nTipoCampo = 132
1717:                     loc_oBO.this_cBandeira = LEFT(loc_oBO.this_cBuffer, 5)
1718:                 ENDIF
1719:                 IF loc_oBO.this_nTipoCampo = 134
1720:                     loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_oBO.this_cBuffer)))
1721:                 ENDIF
1722:                 IF loc_oBO.this_nTipoCampo = 135
1723:                     loc_oBO.this_cAutorizacao = loc_oBO.this_cBuffer
1724:                 ENDIF
1725:                 IF loc_nRetorno != 0
1726:                     loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
1727:                 ENDIF
1728:                 IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
1729:                     loc_oBO.this_cMensagemRetorno = loc_oBO.this_cBuffer
1730:                     loc_oBO.this_cBuffer = SPACE(2000)
1731:                     loc_oBO.this_nContinua = 0
1732:                 ENDIF
1733:             ENDDO
1734: 
1735:             IF loc_nRetorno != 10000

*-- Linhas 1751 a 1794:
1751:     * Fecha o fluxo comum: confirma a data, aguarda ProximoComando=30 e
1752:     * finaliza (MontaRetorno em sucesso, RetornoFalha em cancelamento/erro).
1753:     *--------------------------------------------------------------------------
1754:     PROCEDURE DatasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1755:         LOCAL loc_oBO, loc_nRetorno, loc_cSenha, loc_oFormSenha, loc_cMensagem
1756: 
1757:         IF par_nKeyCode != 13 AND par_nKeyCode != 9
1758:             RETURN
1759:         ENDIF
1760: 
1761:         *-- Cabeca do Valid legado (ESC / data padrao DATE()+30 / data invalida
1762:         *-- quando o tipo de venda eh parcelado). O ESC sai ANTES da
1763:         *-- normalizacao, como no legado.
1764:         IF !THIS.ValidarDataVencimento()
1765:             RETURN
1766:         ENDIF
1767: 
1768:         loc_oBO = THIS.this_oBusinessObject
1769: 
1770:         DO WHILE loc_oBO.this_nProximoComando != 30
1771:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1772:             THIS.obj_4c_SAIDA.Buttons(1).Enabled = (loc_oBO.this_nProximoComando != 23)
1773:             IF "SENHA" $ UPPER(ALLTRIM(loc_oBO.this_cBuffer)) OR loc_oBO.this_nProximoComando = 23
1774:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1775:             ENDIF
1776:             IF loc_nRetorno < 0
1777:                 THIS.ErroTef(loc_nRetorno)
1778:                 THIS.Release()
1779:                 RETURN
1780:             ENDIF
1781:         ENDDO
1782: 
1783:         loc_oBO.this_cMensagemRetorno = ""
1784:         loc_oBO.this_cAutorizacao = ""
1785:         loc_cMensagem = ""
1786:         loc_oBO.this_cBuffer = ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 1, 2)) + ;
1787:             ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 4, 2)) + ;
1788:             ALLTRIM(SUBSTR(DTOC(THIS.txt_4c_Datas.Value), 7, 4)) + REPLICATE(CHR(0), 1992)
1789:         loc_oBO.this_nContinua = 1000
1790:         loc_nRetorno = 10000
1791: 
1792:         DO WHILE loc_nRetorno = 10000
1793:             loc_nRetorno = loc_oBO.ContinuarSiTef(loc_oBO.this_nContinua)
1794: 

*-- Linhas 1828 a 2033:
1828:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1829:             ENDIF
1830:             IF loc_oBO.this_nProximoComando = 30 AND loc_oBO.this_nTipoCampo = 500
1831:                 loc_oFormSenha = CREATEOBJECT("FormSIGPRSTF")
1832:                 loc_oFormSenha.Show()
1833:                 IF loc_oFormSenha.this_lCancelado
1834:                     loc_oBO.FinalizarSiTef(0, IIF(EMPTY(loc_oBO.this_cCupomTef), "1", loc_oBO.this_cCupomTef), ;
1835:                         STR(YEAR(DATE()), 4) + SUBSTR(DTOC(DATE()), 4, 2) + SUBSTR(DTOC(DATE()), 1, 2), STRTRAN(TIME(), ":", ""))
1836:                     THIS.RetornoFalha("Operacao Cancelada pelo Usuario")
1837:                     loc_nRetorno = -2
1838:                     EXIT
1839:                 ELSE
1840:                     loc_cSenha = loc_oFormSenha.this_cSenhaRetorno
1841:                     loc_oBO.this_cBuffer = loc_cSenha + REPLICATE(CHR(0), 1900)
1842:                     LOOP
1843:                 ENDIF
1844:             ENDIF
1845:             IF UPPER(loc_oBO.this_cBuffer) = "ASSUME GARANTIA"
1846:                 IF MsgConfirma("Assume Inversao de Risco ?", "Confirma")
1847:                     loc_oBO.this_cBuffer = "0" + REPLICATE(CHR(0), 1999)
1848:                 ELSE
1849:                     loc_oBO.this_cBuffer = "1" + REPLICATE(CHR(0), 1999)
1850:                 ENDIF
1851:                 LOOP
1852:             ENDIF
1853:             IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = 130
1854:                 IF loc_oBO.this_lOpFpSaque
1855:                     MsgAviso("Saque via SiTef requer o dialogo SigCsTef, nao portado nesta migracao. Valor de saque assumido: 0,00.", "Saque")
1856:                 ENDIF
1857:                 loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 2000 - LEN(loc_oBO.this_cValorSaque))
1858:                 loc_oBO.this_nContinua = 1000
1859:                 LOOP
1860:             ENDIF
1861:             IF loc_oBO.this_nProximoComando = 34 AND loc_oBO.this_nTipoCampo = -1
1862:                 MsgAviso("Entrada CDC (SigCsTef) nao portada nesta migracao. Valor assumido: 0,00.", "Entrada CDC")
1863:                 loc_oBO.this_cBuffer = loc_oBO.this_cValorSaque + REPLICATE(CHR(0), 1900)
1864:                 LOOP
1865:             ENDIF
1866:             IF loc_oBO.this_nProximoComando = 3
1867:                 loc_oBO.this_cMensagemRetorno = ALLTRIM(loc_oBO.this_cBuffer)
1868:             ENDIF
1869:             IF loc_oBO.this_nTipoCampo = 100
1870:                 loc_oBO.this_cTipoTransacao = loc_oBO.this_cBuffer
1871:             ENDIF
1872:             IF loc_oBO.this_nTipoCampo = 105
1873:                 loc_oBO.this_cDataHoraTef = loc_oBO.this_cBuffer
1874:             ENDIF
1875:             IF loc_oBO.this_nTipoCampo = 121
1876:                 loc_oBO.this_cCupomTef = loc_oBO.this_cBuffer
1877:             ENDIF
1878:             IF loc_oBO.this_nTipoCampo = 131
1879:                 loc_oBO.this_cCartaoAux = LEFT(loc_oBO.this_cBuffer, 5)
1880:             ENDIF
1881:             IF loc_oBO.this_nTipoCampo = 132
1882:                 loc_oBO.this_cBandeira = LEFT(loc_oBO.this_cBuffer, 5)
1883:             ENDIF
1884:             IF loc_oBO.this_nTipoCampo = 134
1885:                 loc_oBO.this_cNsu = ALLTRIM(STR(VAL(loc_oBO.this_cBuffer)))
1886:             ENDIF
1887:             IF loc_oBO.this_nTipoCampo = 135
1888:                 loc_oBO.this_cAutorizacao = loc_oBO.this_cBuffer
1889:             ENDIF
1890:             IF loc_nRetorno != 0
1891:                 loc_oBO.this_cFinalizacao = loc_oBO.this_cBuffer
1892:             ENDIF
1893:             IF UPPER(ALLTRIM(loc_oBO.this_cBuffer)) $ "DIGITE A SENHA"
1894:                 THIS.cnt_4c_Container1.lbl_4c_Label1.Caption = "Digite a Senha"
1895:             ENDIF
1896:             IF loc_oBO.this_nProximoComando != 21 AND loc_oBO.this_nProximoComando != 30
1897:                 loc_cMensagem = loc_oBO.this_cBuffer
1898:                 loc_oBO.this_cBuffer = SPACE(2000)
1899:                 loc_oBO.this_nContinua = 0
1900:             ENDIF
1901:         ENDDO
1902: 
1903:         IF loc_nRetorno != 10000
1904:             IF loc_oBO.this_cDebCred = "P"
1905:                 MsgAviso("Consulta CDC (SigCoCDC) nao portada nesta migracao.", "Consulta CDC")
1906:                 THIS.RetornoFalha("Consulta CDC Realizada")
1907:             ELSE
1908:                 IF loc_nRetorno = 0
1909:                     THIS.MontaRetorno(loc_oBO.this_cTipoTransacao, loc_oBO.this_cDataHoraTef, ;
1910:                         loc_oBO.this_cCupomTef, loc_oBO.this_cBandeira, loc_oBO.this_cNsu, ;
1911:                         loc_oBO.this_cAutorizacao, loc_oBO.this_cFinalizacao, loc_oBO.this_nValPago, ;
1912:                         loc_oBO.this_cMensagemRetorno)
1913:                 ELSE
1914:                     IF loc_nRetorno >= -5
1915:                         THIS.ErroTef(loc_nRetorno)
1916:                     ENDIF
1917:                 ENDIF
1918:             ENDIF
1919:         ENDIF
1920:         THIS.Release()
1921:     ENDPROC
1922: 
1923:     *--------------------------------------------------------------------------
1924:     * FormParaBO - transfere os campos de captura da tela para as properties
1925:     * correspondentes do BO.
1926:     *
1927:     * NAO eh hook de CRUD aqui (o legado nao tem Incluir/Alterar/Excluir nem
1928:     * modo de edicao): estes seis campos SAO a ficha desta tela - valor, 4
1929:     * ultimos digitos, numero do cartao, tipo da venda, numero de parcelas e
1930:     * vencimento da primeira. O BO ja declarava as properties
1931:     * (this_nValor/this_cDigitos/this_cCartao/this_nTipoVenda/this_nParcelas/
1932:     * this_dDataParc) e sem este metodo elas nunca eram preenchidas.
1933:     *
1934:     * Conversao de tipo OBRIGATORIA, nao cosmetica:
1935:     *   - txt_4c_Text1.Value eh CHARACTER (mascara "99" + TRANSFORM(...,
1936:     *     "@L 99") no LostFocus, igual ao legado) e this_nParcelas eh NUMERIC
1937:     *     -> VAL(). Atribuir direto deixaria a property char e estouraria na
1938:     *     primeira comparacao aritmetica.
1939:     *   - txt_4c_Datas.Value eh DATE -> ConverterParaData() garante DATE no BO
1940:     *     mesmo que o controle receba DATETIME em algum caminho.
1941:     *
1942:     * PROTECTED porque FormBase declara o hook como PROTECTED e subclasse nao
1943:     * alarga escopo em VFP9.
1944:     *--------------------------------------------------------------------------
1945:     PROTECTED PROCEDURE FormParaBO()
1946:         LOCAL loc_oBO
1947: 
1948:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1949:             RETURN .F.
1950:         ENDIF
1951: 
1952:         loc_oBO = THIS.this_oBusinessObject
1953: 
1954:         loc_oBO.this_nValor     = THIS.txt_4c_Valor.Value
1955:         loc_oBO.this_cDigitos   = ALLTRIM(THIS.txt_4c_Digitos.Value)
1956:         loc_oBO.this_cCartao    = ALLTRIM(THIS.txt_4c_Cartao.Value)
1957:         loc_oBO.this_nTipoVenda = THIS.obj_4c_Optiongroup1.Value
1958:         loc_oBO.this_nParcelas  = THIS.txt_4c_Text1.Value
1959:         loc_oBO.this_dDataParc  = ConverterParaData(THIS.txt_4c_Datas.Value)
1960: 
1961:         RETURN .T.
1962:     ENDPROC
1963: 
1964:     *--------------------------------------------------------------------------
1965:     * BOParaForm - caminho inverso do FormParaBO. Existe para o chamador que
1966:     * pre-carrega a transacao no BO (valor, parcelas e vencimento vindos do
1967:     * pedido) antes de exibir o dialogo, e para repintar a tela depois de o
1968:     * protocolo SiTef alterar esses campos.
1969:     *
1970:     * txt_4c_Text1.Value volta com a MESMA mascara do legado
1971:     * (TRANSFORM(...,"@L 99")) - o controle eh char e a property eh numerica.
1972:     * PROTECTED: mesmo motivo do FormParaBO.
1973:     *--------------------------------------------------------------------------
1974:     PROTECTED PROCEDURE BOParaForm()
1975:         LOCAL loc_oBO
1976: 
1977:         IF VARTYPE(THIS.this_oBusinessObject) != "O"
1978:             RETURN .F.
1979:         ENDIF
1980: 
1981:         loc_oBO = THIS.this_oBusinessObject
1982: 
1983:         THIS.txt_4c_Valor.Value   = loc_oBO.this_nValor
1984:         THIS.txt_4c_Digitos.Value = loc_oBO.this_cDigitos
1985:         THIS.txt_4c_Cartao.Value  = loc_oBO.this_cCartao
1986:         THIS.txt_4c_Text1.Value   = TRANSFORM(loc_oBO.this_nParcelas, "@L 99")
1987:         THIS.txt_4c_Datas.Value   = ConverterParaData(loc_oBO.this_dDataParc)
1988: 
1989:         *-- Optiongroup1.Value eh NUMERICO e 1-based (1=A Vista, 2=Parcelado).
1990:         *-- Fora da faixa dos 2 botoes, nao atribui: valor invalido marcaria
1991:         *-- todos os radios (regra dos OptionGroup do projeto).
1992:         IF BETWEEN(loc_oBO.this_nTipoVenda, 1, THIS.obj_4c_Optiongroup1.ButtonCount)
1993:             THIS.obj_4c_Optiongroup1.Value = loc_oBO.this_nTipoVenda
1994:         ENDIF
1995: 
1996:         RETURN .T.
1997:     ENDPROC
1998: 
1999:     *--------------------------------------------------------------------------
2000:     * MontarRetornoTef - transcricao literal do RETURN do SIGPRDFT.Unload:
2001:     *
2002:     *     If ! Type('ThisForm.pcBandeira') = [C] or Empty(ThisForm.pcBandeira)
2003:     *         ThisForm.pcBandeira = [00000]
2004:     *     Endif
2005:     *     If ! Type('ThisForm.lsCartao') = [C] or Empty(ThisForm.lsCartao)
2006:     *         ThisForm.lsCartao = [00000]
2007:     *     Endif
2008:     *     RETURN(lcSaque+"/"+lnParcs+"/"+DTOC(ldData)+ThisForm.pcBandeira+ThisForm.lsCartao)
2009:     *
2010:     * Esta string EH o resultado da tela - o chamador legado a le e dela extrai
2011:     * saque, parcelas, vencimento, bandeira e cartao. Reescrever o formato
2012:     * (ordem, separador "/", ausencia de separador entre bandeira e cartao)
2013:     * quebraria o chamador em silencio, entao nada aqui eh "arrumado".
2014:     *
2015:     * Precedencia do legado: em VFP o "=" liga mais forte que o NOT, logo
2016:     * "! Type(x) = [C]" eh NOT(Type(x) == 'C') - e nao (NOT Type(x)) == 'C'.
2017:     * Por isso o teste migrado eh VARTYPE(...) != "C" OR EMPTY(...).
2018:     *
2019:     * Os tres CLEAR DLLS e o CHRSAW(2) do Unload legado estao COMENTADOS no
2020:     * SCX (desligados de proposito - descarregar a CliSiTef32I.DLL entre duas
2021:     * transacoes derrubava a sessao do PIN-pad), portanto nao sao migrados.
2022:     *--------------------------------------------------------------------------
2023:     FUNCTION MontarRetornoTef()
2024:         LOCAL loc_oBO, loc_cSaque, loc_cBandeira, loc_cCartao, loc_dData
2025: 
2026:         loc_oBO = THIS.this_oBusinessObject
2027: 
2028:         IF VARTYPE(loc_oBO) = "O"
2029:             IF VARTYPE(loc_oBO.this_cBandeira) != "C" OR EMPTY(loc_oBO.this_cBandeira)
2030:                 loc_oBO.this_cBandeira = "00000"
2031:             ENDIF
2032:             IF VARTYPE(loc_oBO.this_cCartaoAux) != "C" OR EMPTY(loc_oBO.this_cCartaoAux)
2033:                 loc_oBO.this_cCartaoAux = "00000"

*-- Linhas 2057 a 2145:
2057:     * algum caminho ele nao tiver sido preenchido.
2058:     *
2059:     * Atende os dois modos de abertura: "DO FORM ... TO lcRetorno" (le este
2060:     * RETURN) e CREATEOBJECT + Show() (le a property this_cRetornoTef, que
2061:     * sobrevive ao fechamento porque o chamador ainda tem a referencia).
2062:     *--------------------------------------------------------------------------
2063:     PROCEDURE Unload()
2064:         IF EMPTY(THIS.this_cRetornoTef)
2065:             THIS.this_cRetornoTef = THIS.MontarRetornoTef()
2066:         ENDIF
2067:         RETURN THIS.this_cRetornoTef
2068:     ENDPROC
2069: 
2070:     *--------------------------------------------------------------------------
2071:     * Move - migrado de SIGPRDFT.Move ("llCancela=.f."). llCancela eh a flag de
2072:     * cancelamento do FORM CHAMADOR no padrao Fortyus (nao eh lida em nenhum
2073:     * ponto deste SCX); no novo desenho ela vive no BO, como this_lCancela.
2074:     *
2075:     * DESVIO DELIBERADO, registrado: o Move legado NAO chama DoDefault, ou
2076:     * seja, engole o reposicionamento. Aqui o DODEFAULT eh mantido, porque a
2077:     * classe migrada usa AutoCenter = .T. e engolir o Move deixaria o dialogo
2078:     * ancorado no canto. O legado nao sofria disso por posicionar a tela na mao
2079:     * (TitleBar = 0 / ControlBox = .F. - o usuario nunca conseguiu arrasta-la).
2080:     *
2081:     * O DO CASE por PCOUNT() existe porque Move aceita 1, 2, 3 ou 4 argumentos:
2082:     * repassar parametro ausente ao DODEFAULT o converteria em .F. e o
2083:     * reposicionamento falharia com erro de tipo.
2084:     *--------------------------------------------------------------------------
2085:     PROCEDURE Move(par_nLeft, par_nTop, par_nWidth, par_nHeight)
2086:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2087:             THIS.this_oBusinessObject.this_lCancela = .F.
2088:         ENDIF
2089: 
2090:         DO CASE
2091:         CASE PCOUNT() >= 4
2092:             DODEFAULT(par_nLeft, par_nTop, par_nWidth, par_nHeight)
2093:         CASE PCOUNT() = 3
2094:             DODEFAULT(par_nLeft, par_nTop, par_nWidth)
2095:         CASE PCOUNT() = 2
2096:             DODEFAULT(par_nLeft, par_nTop)
2097:         CASE PCOUNT() = 1
2098:             DODEFAULT(par_nLeft)
2099:         OTHERWISE
2100:             DODEFAULT()
2101:         ENDCASE
2102:     ENDPROC
2103: 
2104:     *--------------------------------------------------------------------------
2105:     * TornarControlesVisiveis - torna todos os controles visiveis
2106:     * recursivamente (AddObject cria com Visible=.F. por padrao).
2107:     * FILTRO: nenhum container flutuante neste form.
2108:     *--------------------------------------------------------------------------
2109:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2110:         LOCAL loc_i, loc_oControl
2111: 
2112:         FOR loc_i = 1 TO par_oContainer.ControlCount
2113:             loc_oControl = par_oContainer.Controls(loc_i)
2114:             IF VARTYPE(loc_oControl) = "O"
2115:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
2116:                     loc_oControl.Visible = .T.
2117:                 ENDIF
2118:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0
2119:                     THIS.TornarControlesVisiveis(loc_oControl)
2120:                 ENDIF
2121:             ENDIF
2122:         ENDFOR
2123:     ENDPROC
2124: 
2125:     *--------------------------------------------------------------------------
2126:     * Destroy - libera recursos ao fechar o form
2127:     *--------------------------------------------------------------------------
2128:     PROCEDURE Destroy()
2129:         *-- Calcula o retorno da tela ANTES de soltar o BO: o Unload dispara
2130:         *-- DEPOIS do Destroy e ja nao alcancaria this_cBandeira/
2131:         *-- this_cCartaoAux/this_cValorSaque. Migrado de SIGPRDFT.Release
2132:         *-- ("ThisForm.poDataMgr.Release / dodefault()"), que eh onde o legado
2133:         *-- solta o gerenciador de dados.
2134:         THIS.this_cRetornoTef = THIS.MontarRetornoTef()
2135: 
2136:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2137:             THIS.this_oBusinessObject = .NULL.
2138:         ENDIF
2139:         IF USED("crSiTef")
2140:             USE IN crSiTef
2141:         ENDIF
2142:         DODEFAULT()
2143:     ENDPROC
2144: 
2145: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprdftBO.prg):
*==============================================================================
* SIGPRDFTBO.PRG
* Business Object - Integracao com terminal SiTef (pagamento em cartao de debito)
* Origem: SIGPRDFT.scx (form legado, sem tabela propria - integracao com DLL SiTef)
*==============================================================================

DEFINE CLASS sigprdftBO AS BusinessBase

    *-- Parametros de entrada recebidos do form/tela chamadora (Init original)
    this_cEndSiTef = ""             && Endereco do servidor SiTef (EndSiTef)
    this_nValPago = 0               && Valor a ser pago na transacao (ValPago)
    this_cCupom = ""                && Numero do cupom fiscal (Cupom)
    this_cCaixa = ""                && Identificacao do caixa/PDV (Caixa)
    this_cDebCred = ""              && Indicador Debito/Credito (DebCred)
    this_cTipPagto = ""             && Tipo de pagamento (TipPagto)
    this_nNumParcs = 0              && Numero de parcelas informado na chamada (NumParcs)
    this_cIdent = ""                && Identificador da transacao (lcIdent)
    this_cOpers = ""                && Operador responsavel (pcOpers)

    *-- Campos digitados na tela (mapeados dos controles GetValor/GetDigitos/GetCartao/etc)
    this_nValor = 0                 && GetValor.Value - valor da transacao
    this_cDigitos = ""              && GetDigitos.Value - 4 ultimos digitos do cartao
    this_cCartao = ""               && GetCartao.Value - numero do cartao lido/digitado
    this_cBandeira = "00000"        && ThisForm.pcBandeira - bandeira do cartao
    this_nTipoVenda = 1             && Optiongroup1.Value - 1=A Vista, 2=Parcelado
    this_nParcelas = 0              && Text1.Value - numero de parcelas
    this_dDataParc = {}             && GetDatas.Value - data da 1a parcela/vencimento

    *-- Dados de retorno da transacao TEF (preenchidos apos comunicacao com o PIN-PAD)
    this_cTipoTransacao = ""        && lsTipTran - tipo de transacao retornado pelo SiTef
    this_cDataHoraTef = ""          && lsDataHora - data/hora da transacao no SiTef
    this_cCupomTef = ""             && lsCupom - cupom retornado pelo SiTef
    this_cCartaoTef = ""            && lsCartao - numero de cartao mascarado retornado
    this_cNsu = ""                  && lsNsu - Numero Sequencial Unico da transacao
    this_cAutorizacao = ""          && lsAutoriza - codigo de autorizacao
    this_cFinalizacao = ""          && lsFinaliza - codigo de finalizacao da transacao
    this_cMensagemRetorno = ""      && MenRet - mensagem de retorno do SiTef

    *-- Controle de fluxo/protocolo SiTef
    this_nProximoComando = 0        && ProximoComando - protocolo ContinuaFuncaoSiTefInterativo
    this_nTipoCampo = 0             && TipoCampo
    this_nTamanhoMinimo = 0         && TamanhoMinimo
    this_nTamanhoMaximo = 0         && TamanhoMaximo
    this_cBuffer = ""               && Buffer - buffer de comunicacao com o SiTef
    this_nContinua = 0              && lnContinua
    this_lCancela = .F.             && llCancela - indica cancelamento da operacao
    this_lAbandona = .F.            && ThisForm.abandona - indica abandono da tela
    this_lKeyEsc = .T.              && ThisForm.pckeyesc - habilita ESC para cancelar
    this_lTransacaoOk = .F.         && Indica se a transacao foi concluida com sucesso

    *-- Parametros consultados na operacao de pagamento (SigOpFp/sigcdemp/SIGFIMPF)
    this_lOpFpCartao = .F.          && SigOpFp.lcartao = "S" - forma aceita cartao
    this_lOpFpSaque = .F.           && SigOpFp.lsaque = "S" - permite saque
    this_cOpFpTcdc = "N"            && SigOpFp.tcdc - indica consulta CDC
    this_lOpFpGarantias = .F.       && SigOpFp.garantias = "S"
    this_nOpFpDias = 0              && SigOpFp.dias
    this_nOpFpMesFec = 0            && SigOpFp.mesfec
    this_cIdTerminal = ""           && Empresa+caixa enviado ao SiTef (ConfiguraInt*)

    *-- Estado auxiliar do protocolo (migrado de variaveis PUBLIC/PRIVATE do form legado)
    this_lDataConfirmada = .F.      && DCD - .T. apos ProximoComando=21 confirmar data
    this_cCartaoAux = ""            && ThisForm.lsCartao (legado) - Left(Buffer,5) em TipoCampo=131
    this_cValorSaque = "0,00"       && lcSaque - valor de saque (sub-dialogo SigCsTef nao portado)

    *--------------------------------------------------------------------------
    * INIT - Construtor
    * Este BO nao possui tabela propria: eh uma integracao com o terminal SiTef
    * (DLL CliSiTef32I.DLL), portanto this_cTabela/this_cCampoChave ficam vazios.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()

        THIS.this_cTabela = ""
        THIS.this_cCampoChave = ""

        THIS.DeclararFuncoesSiTef()

        RETURN .T.
    ENDPROC

    *==========================================================================
    * DeclararFuncoesSiTef - DECLARE-DLL das 4 funcoes do protocolo interativo
    * (migrado de SIGPRDFT.Load). Redeclarar a mesma assinatura eh inofensivo
    * em VFP9; a falha real (DLL ausente) so aparece quando a funcao eh
    * CHAMADA, nao na declaracao - por isso o TRY aqui eh so para nao derrubar
    * InicializarForm em maquina de desenvolvimento sem o CliSiTef32I.DLL.
    *==========================================================================
    PROTECTED PROCEDURE DeclararFuncoesSiTef()
        LOCAL loc_oErro

        TRY
            DECLARE INTEGER ConfiguraIntSiTefInterativo IN "CliSiTef32I.DLL" ;
                STRING lsEndereco, STRING lsLoja, STRING lsTerminal, INTEGER lnReservado

            DECLARE INTEGER IniciaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnModalidade, STRING lsValor, STRING lsCupom, STRING lsData, ;
                STRING lsHorario, STRING lsOperador, STRING lsRestricao

            DECLARE INTEGER ContinuaFuncaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER @lnComando, INTEGER @lnTipo, INTEGER @lnMinimo, INTEGER @lnMaximo, ;
                STRING @lsBuffer, INTEGER lnTamanho, INTEGER lnResultado

            DECLARE INTEGER FinalizaTransacaoSiTefInterativo IN "CliSiTef32I.DLL" ;
                INTEGER lnConfirma, STRING lsCupom, STRING lsData, STRING lsHorario
        CATCH TO loc_oErro
            *-- DLL nao presente nesta maquina (dev/teste sem PIN-pad SiTef) -
            *-- as chamadas reais avisam o usuario via ConectarSiTef/IniciarSiTef.
        ENDTRY
    ENDPROC

    *==========================================================================
    * CarregarParametrosOperacao - Migrado de SIGPRDFT.Init (blocos
    * SqlExecute crSigOpFp/crSigCdEmp) + GotFocus (lcIdTerminal). Le a forma de
    * pagamento (SigOpFp) pelo codigo recebido em this_cOpers e monta o
    * identificador de terminal (empresa+caixa) usado por ConectarSiTef.
    *==========================================================================
    FUNCTION CarregarParametrosOperacao()
        LOCAL loc_lSucesso, loc_oErro, loc_nEmpresa

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF
            SQLEXEC(gnConnHandle, ;
                "SELECT lcartao, lsaque, tcdc, garantias, dias, mesfec FROM SigOpFp " + ;
                "WHERE fpags = " + EscaparSQL(THIS.this_cOpers), ;
                "cursor_4c_SigOpFp")

            IF USED("cursor_4c_SigOpFp") AND !EOF("cursor_4c_SigOpFp")
                THIS.this_lOpFpCartao    = (TratarNulo(cursor_4c_SigOpFp.lcartao, "N") = "S")
                THIS.this_lOpFpSaque     = (TratarNulo(cursor_4c_SigOpFp.lsaque, "N") = "S")
                THIS.this_cOpFpTcdc      = TratarNulo(cursor_4c_SigOpFp.tcdc, "N")
                THIS.this_lOpFpGarantias = (TratarNulo(cursor_4c_SigOpFp.garantias, "N") = "S")
                THIS.this_nOpFpDias      = TratarNulo(cursor_4c_SigOpFp.dias, 0)
                THIS.this_nOpFpMesFec    = TratarNulo(cursor_4c_SigOpFp.mesfec, 0)
                loc_lSucesso = .T.
            ENDIF
            IF USED("cursor_4c_SigOpFp")
                USE IN cursor_4c_SigOpFp
            ENDIF

            IF loc_lSucesso
                *-- sigcdemp.codemps (numeric) equivale ao SigCdEmp.nEmps legado;
                *-- sigcdemp.cemps (char) eh a chave usada no filtro por empresa.
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT codemps FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SigCdEmpTef")

                loc_nEmpresa = 0
                IF USED("cursor_4c_SigCdEmpTef") AND !EOF("cursor_4c_SigCdEmpTef")
                    loc_nEmpresa = TratarNulo(cursor_4c_SigCdEmpTef.codemps, 0)
                ENDIF
                IF USED("cursor_4c_SigCdEmpTef")
                    USE IN cursor_4c_SigCdEmpTef
                ENDIF

                *-- SIGFIMPF.cncaixas (caixa/PDV corrente) - SigFiMpF legado nao
                *-- tem equivalente de "caixa aberto" nesta migracao; melhor
                *-- esforco: 1o registro da empresa. Sem match, terminal fecha
                *-- com "000000" (mesmo fallback do legado quando nao localizado).
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
                SQLEXEC(gnConnHandle, ;
                    "SELECT cncaixas FROM SIGFIMPF WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_SIGFIMPF")

                IF USED("cursor_4c_SIGFIMPF") AND !EOF("cursor_4c_SIGFIMPF")
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + ;
                        TRANSFORM(VAL(TratarNulo(cursor_4c_SIGFIMPF.cncaixas, "0")), "@L 999999")
                ELSE
                    THIS.this_cIdTerminal = PADL(ALLTRIM(STR(loc_nEmpresa, 5)), 5, "0") + "000000"
                ENDIF
                IF USED("cursor_4c_SIGFIMPF")
                    USE IN cursor_4c_SIGFIMPF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + ;
                    "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
                    "Procedure: " + loc_oErro.Procedure, ;
                    "Erro ao carregar parametros da operacao")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *==========================================================================
    * ConectarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * ConfiguraIntSiTefInterativo). Retorna .T. se a comunicacao com o
    * servidor SiTef foi estabelecida.
    *==========================================================================
    FUNCTION ConectarSiTef()
        LOCAL loc_nRetorno

        IF EMPTY(THIS.this_cIdTerminal)
            THIS.this_cIdTerminal = "00000000000"
        ENDIF

        loc_nRetorno = ConfiguraIntSiTefInterativo(ALLTRIM(THIS.this_cEndSiTef), ;
            THIS.this_cIdTerminal, THIS.this_cIdTerminal, 0)

        RETURN (loc_nRetorno = 0)
    ENDFUNC

    *==========================================================================
    * IniciarSiTef - Migrado de SIGPRDFT.GetDigitos.GotFocus (bloco
    * IniciaFuncaoSiTefInterativo). par_nModalidade=0 eh a unica modalidade
    * usada pelo legado (cartao de debito/credito).
    *==========================================================================
    FUNCTION IniciarSiTef(par_nModalidade, par_cValor, par_cCupom, par_cData, par_cHora)
        LOCAL loc_nRetorno

        loc_nRetorno = IniciaFuncaoSiTefInterativo(par_nModalidade, par_cValor, par_cCupom, ;
            par_cData, par_cHora, THIS.this_cCaixa, "")

        RETURN (loc_nRetorno = 10000)
    ENDFUNC

    *==========================================================================
    * ContinuarSiTef - Migrado das chamadas ContinuaFuncaoSiTefInterativo
    * espalhadas pelo legado (GetDigitos.Valid/GotFocus, GetDatas.Valid/
    * GotFocus, Text1.Valid, SAIDA.CANCELA.Click). Centraliza a chamada por
    * referencia (LOCAL -> DLL -> THIS.this_n*/this_cBuffer) porque VFP9 nao
    * garante passagem por referencia de property de objeto para DLL externa.
    *==========================================================================
    FUNCTION ContinuarSiTef(par_nContinua)
        LOCAL loc_nProximoComando, loc_nTipoCampo, loc_nTamanhoMinimo, ;
              loc_nTamanhoMaximo, loc_cBuffer, loc_nRetorno

        loc_nProximoComando = THIS.this_nProximoComando
        loc_nTipoCampo      = THIS.this_nTipoCampo
        loc_nTamanhoMinimo  = THIS.this_nTamanhoMinimo
        loc_nTamanhoMaximo  = THIS.this_nTamanhoMaximo
        loc_cBuffer         = IIF(EMPTY(THIS.this_cBuffer), SPACE(2000), THIS.this_cBuffer)

        loc_nRetorno = ContinuaFuncaoSiTefInterativo(@loc_nProximoComando, @loc_nTipoCampo, ;
            @loc_nTamanhoMinimo, @loc_nTamanhoMaximo, @loc_cBuffer, LEN(loc_cBuffer), par_nContinua)

        THIS.this_nProximoComando = loc_nProximoComando
        THIS.this_nTipoCampo      = loc_nTipoCampo
        THIS.this_nTamanhoMinimo  = loc_nTamanhoMinimo
        THIS.this_nTamanhoMaximo  = loc_nTamanhoMaximo
        THIS.this_cBuffer         = loc_cBuffer

        RETURN loc_nRetorno
    ENDFUNC

    *==========================================================================
    * FinalizarSiTef - Migrado de SIGPRDFT.GetDatas.Valid (bloco
    * FinalizaTransacaoSiTefInterativo, disparado ao cancelar via senha de
    * supervisor - FormSIGPRSTF).
    *==========================================================================
    FUNCTION FinalizarSiTef(par_nConfirma, par_cCupom, par_cData, par_cHora)
        RETURN FinalizaTransacaoSiTefInterativo(par_nConfirma, par_cCupom, par_cData, par_cHora)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - SIGPRDFT nao tem cursor nem tabela propria. Os dados
    * digitados na tela (Valor, Digitos, Cartao, TipoVenda, Parcelas, Data)
    * sao atribuidos diretamente as properties this_n*/this_c*/this_d* pelo
    * proprio Form (FormParaBO/BOParaForm), e o retorno da transacao TEF
    * (Nsu/Autorizacao/Finalizacao/etc) vem do protocolo ContinuaFuncaoSiTef
    * Interativo via DLL, nao de um SELECT. Nao ha cursor de banco a
    * percorrer aqui - o comportamento padrao herdado de BusinessBase
    * (no-op, RETURN .T.) ja eh o correto.
    *==========================================================================

    *==========================================================================
    * ObterChavePrimaria - SIGPRDFT nao grava registro nenhum (integracao com
    * o terminal SiTef via CliSiTef32I.DLL - CREATE CURSOR crSiTef eh apenas
    * o buffer de instrucoes do protocolo TEF, nunca persistido no SQL
    * Server). Nao existe chave primaria porque nao existe tabela; retornar
    * vazio mantem RegistrarAuditoria() inofensivo (ela ja aborta quando a
    * chave vem vazia - ver BusinessBase.RegistrarAuditoria).
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *==========================================================================
    * Inserir/Atualizar/ExecutarExclusao: SIGPRDFT eh um dialogo de captura de
    * pagamento em cartao (SIGPRDFT.scx), sem AddCursor, sem tabela e sem SQL
    * de persistencia associados no legado (ver comportamento.json: as unicas
    * queries SQL sao INSERT INTO crSiTef, um cursor LOCAL de memoria usado
    * so para montar o buffer do protocolo ContinuaFuncaoSiTefInterativo, e
    * nunca chega a SQLEXEC/SQL Server). O comportamento padrao herdado de
    * BusinessBase (recusar a operacao) ja eh o correto - nao ha necessidade
    * de sobrescrever esses tres metodos aqui, e RegistrarAuditoria() nunca
    * roda porque Inserir/Atualizar/ExecutarExclusao nunca sao chamados.
    *==========================================================================

ENDDEFINE

